"""LiteLLM pre-call callback for the local Ollama proxy.

This module is bind-mounted into the upstream LiteLLM image at /app and wired up
via `litellm_settings.callbacks: ["custom_callbacks.custom_router"]` in
config.yaml. LiteLLM imports the module and calls `custom_router.async_pre_call_hook`
once per request, BEFORE the model is resolved and called.

Responsibilities, in order of precedence:
  1. Log the incoming prompt with PII scrubbed (logging only - the request is
     never modified by this step).
  2. Return a canned "Confidential" reply, without calling any model, when the
     prompt contains personal information (email, card number, phone number).
  3. Short-circuit to a canned reply when the prompt contains a trigger keyword.
  4. Otherwise route to one of the two Ollama aliases based on simple metrics.

Because the hook fires before route resolution, it can rewrite `data["model"]`;
that is why the client may send a model name (e.g. "dynamic-router") that does
not exist in config.yaml's model_list.

Caveat: with Presidio down, only email and Luhn-valid card block — a phone number will not block in the fallback path.
"""

import re
import httpx
import litellm
from litellm.integrations.custom_logger import CustomLogger

# Keywords -> fixed replies. Matching is whole-word and case-insensitive.
# When a keyword matches, the hook sets `data["mock_response"]` and returns
# early, so no Ollama model is ever called for that request.

CANNED_RESPONSES = {
    "alan": "Alan, what can I say. Alan is.",
    "ceda": "CEDA, probably the best team in the world.",
}

# Reply returned when personal information is detected. Like the keyword replies
# above, it is delivered via `mock_response` so no Ollama model is ever called.
PII_RESPONSE = "Confidential"


# Microsoft Presidio runs as two sibling containers on the compose network.
# `presidio-analyzer` / `presidio-anonymizer` are Docker Compose SERVICE NAMES,
# resolved by Docker's internal DNS on the litellm_default network - not
# hostnames and not localhost. Port 3000 is the sidecar's container port (no
# host port is published). From inside the LiteLLM container, "localhost" would
# refer to the LiteLLM container itself, so these must stay as service names.

PRESIDIO_ANALYZER_URL = "http://presidio-analyzer:3000/analyze"
PRESIDIO_ANONYMIZER_URL = "http://presidio-anonymizer:3000/anonymize"

# Entity types Presidio should detect. PERSON and PHONE_NUMBER require its NER
# model; EMAIL_ADDRESS and CREDIT_CARD are also covered by the regex fallback.
# (Used for the scrubbed log line, which redacts everything detected.)

PII_ENTITIES = ["PERSON", "EMAIL_ADDRESS", "CREDIT_CARD", "PHONE_NUMBER"]

# Entity types that BLOCK the request and return PII_RESPONSE instead of routing
# to a model. Deliberately excludes PERSON: the NER model flags many ordinary
# capitalized words, so blocking on PERSON would reject far too many requests.
# PERSON is still redacted in the log, just not treated as a reason to block.

BLOCK_ENTITIES = {"EMAIL_ADDRESS", "CREDIT_CARD", "PHONE_NUMBER"}

# Regexes used only by the fallback scrubber when Presidio is unreachable.
# Email: standard local-part@domain.tld shape.

_EMAIL_RE = re.compile(r"\b[\w.+-]+@[\w-]+\.[\w.-]+\b")

# Card: a run of 13-19 digits, optionally separated by spaces or hyphens.
# Deliberately broad; `_luhn_ok` below filters out non-card digit runs.

_CARD_RE = re.compile(r"\b(?:\d[ -]?){13,19}\b")


def _luhn_ok(digits):
    """Return True if `digits` (a string of 0-9) passes the Luhn checksum.

    Validating with Luhn stops the broad `_CARD_RE` from redacting unrelated
    long numbers (order ids, timestamps, etc.) in the fallback path.
    """
    total, alt = 0, False
    for ch in reversed(digits):
        n = int(ch)
        # Double every second digit counting from the right, subtracting 9 when
        # the doubling produces a two-digit number.
        if alt:
            n *= 2
            if n > 9:
                n -= 9
        total += n
        alt = not alt
    return total % 10 == 0


def _regex_scrub(text):
    """Best-effort stdlib scrubber used when Presidio is unavailable.

    Returns `(scrubbed_text, detected)` where `detected` is the set of entity
    types that were found. Covers email addresses and Luhn-valid card numbers
    only; it cannot detect names or phone numbers, so those neither redact nor
    block in the fallback path.
    """
    detected = set()
    text, n = _EMAIL_RE.subn("<EMAIL_ADDRESS>", text)
    if n:
        detected.add("EMAIL_ADDRESS")

    def _card(match):
        if _luhn_ok(re.sub(r"\D", "", match.group())):
            detected.add("CREDIT_CARD")
            return "<CREDIT_CARD>"
        return match.group()

    # `sub` accepts a callable so each candidate is Luhn-checked individually
    # and left untouched if it is not a plausible card number.
    text = _CARD_RE.sub(_card, text)
    return text, detected


async def _scrub(text):
    """Return `(scrubbed_text, detected)` for a prompt.

    `scrubbed_text` is a PII-redacted copy for logging; `detected` is the set of
    entity types found (used to decide whether to block the request).

    Two-step Presidio flow: /analyze locates entities, /anonymize replaces them
    with tagged placeholders (e.g. <PERSON>, <EMAIL_ADDRESS>). Async because the
    hook is async and this makes network calls; blocking here would stall the
    event loop for every request.

    Fails OPEN: any error (sidecars not yet up, timeout, bad response) falls back
    to `_regex_scrub` so a logging failure can never break a user request.
    """
    if not text:
        return text, set()
    try:
        async with httpx.AsyncClient(timeout=10.0) as client:
            # Step 1: ask the analyzer where the PII is.
            analysis = await client.post(
                PRESIDIO_ANALYZER_URL,
                json={"text": text, "language": "en", "entities": PII_ENTITIES},
            )
            analysis.raise_for_status()
            results = analysis.json()
            detected = {r.get("entity_type") for r in results} if results else set()
            # No entities found -> nothing to anonymize; return the original.
            if not results:
                return text, set()
            # Step 2: ask the anonymizer to replace the spans it was told about.
            anonymized = await client.post(
                PRESIDIO_ANONYMIZER_URL,
                json={"text": text, "analyzer_results": results},
            )
            anonymized.raise_for_status()
            return anonymized.json().get("text", text), detected
    except Exception as e:
        print(f"[Custom Router] Presidio scrub failed, using regex fallback: {str(e)}")
        return _regex_scrub(text)


def _content_to_text(content):
    """Flatten an OpenAI-style `content` field into a plain string.

    `content` may be a plain string, or a list of typed parts (e.g.
    `[{"type": "text", "text": "..."}]`), so both shapes are handled here.
    """
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        return " ".join(
            p.get("text", "")
            for p in content
            if isinstance(p, dict) and isinstance(p.get("text"), str)
        )
    return ""


def _extract_canned_prompt(data):
    """Return the user's prompt text regardless of which endpoint was called.

    LiteLLM exposes the prompt in different fields per route:
      * /v1/chat/completions -> `data["messages"]` (list of {role, content})
      * /v1/responses        -> `data["input"]` (string, or list of message items)
    ellmer/mall (see ping.R) uses /v1/responses, so reading only `messages`
    would silently see an empty prompt on that route.
    """
    messages = data.get("messages")
    if messages:
        return _content_to_text(messages[-1].get("content", ""))
    inp = data.get("input")
    if isinstance(inp, str):
        return inp
    if isinstance(inp, list):
        # Prefer the most recent user message; fall back to the last item of any
        # role (tool/output items) if no user-role entry exists.
        for item in reversed(inp):
            if isinstance(item, dict) and item.get("role") == "user":
                return _content_to_text(item.get("content", ""))
        for item in reversed(inp):
            if isinstance(item, dict):
                return _content_to_text(item.get("content", ""))
    return ""


class CustomMetricRouter(CustomLogger):
    """Callback implementing PII-scrubbed logging, canned replies, and routing."""

    async def async_pre_call_hook(self, **kwargs):
        # LiteLLM calls every hook with keyword arguments. Read defensively with
        # `.get` and defaults so a version that passes fewer keys still works.
        data = kwargs.get("data", {})
        user_api_key_dict = kwargs.get("user_api_key_dict", {})
        call_type = kwargs.get("call_type", "")

        # LiteLLM has used different kwarg names for the cache across versions;
        # accept whichever is present rather than assuming one.
        cache = kwargs.get("cache") or kwargs.get("cache_dict") or {}

        try:
            messages = data.get("messages", [])
            user_prompt = ""
            if messages:
                user_prompt = messages[-1].get("content", "")

            # --- Step 1: PII scan + scrubbed logging (logging only) -----------
            # One Presidio call feeds both the redacted log line and the block
            # decision below. The prompt sent to the model is untouched here.
            # Wrapped in its own try/except so a logging problem can never alter
            # routing or reject the request.
            scanned_prompt = _extract_canned_prompt(data)
            try:
                scrubbed, detected = await _scrub(scanned_prompt)
                print(f"[Custom Router] Prompt (scrubbed): {scrubbed}")
            except Exception as log_err:
                detected = set()
                print(f"[Custom Router] Prompt logging failed: {str(log_err)}")

            # --- Step 2: block prompts containing personal information --------
            # Highest precedence: returning early means no model is called.
            blocked = detected & BLOCK_ENTITIES
            if blocked:
                print(
                    f"[Custom Router] PII detected {sorted(blocked)}; returning {PII_RESPONSE}"
                )
                data["mock_response"] = (
                    f"{PII_RESPONSE} - detected {', '.join(sorted(blocked))}"
                )
                # Model must still resolve to a real alias in model_list, or
                # routing fails with "no healthy deployments" before
                # mock_response is honoured.
                data["model"] = "ollama-gpt"
                return data

            # --- Step 3: canned responses -------------------------------------
            # Whole-word, case-insensitive keyword match. Returning early here
            # means the metric block below is skipped and no model is called.
            canned_prompt = scanned_prompt.lower()
            for keyword, canned in CANNED_RESPONSES.items():
                if re.search(rf"\b{re.escape(keyword)}\b", canned_prompt):
                    print(f"[Custom Router] Canned response for keyword: {keyword}")
                    # A returned string would be treated as a request rejection
                    # by LiteLLM, so the reply must go through `mock_response`.
                    data["mock_response"] = canned
                    # The model still has to resolve to a real alias in
                    # model_list, otherwise routing fails with "no healthy
                    # deployments" before mock_response is honoured.
                    data["model"] = "ollama-gpt"
                    return data

            # --- Step 4: metric-based routing --------------------------------
            # Note this reads `messages` only, so on /v1/responses it sees an
            # empty prompt (length 0) and always picks the lightweight model.
            prompt_length = len(user_prompt)
            is_coding_request = any(
                word in user_prompt.lower() for word in ["code", "python", "js", "bug"]
            )

            print(
                f"[Custom Router] Prompt metrics -> Length: {prompt_length}, Code-heavy: {is_coding_request}"
            )

            # Coding prompts, or anything longer than 500 chars, get the larger
            # model; everything else gets the small one.
            if is_coding_request or prompt_length > 500:
                print("[Custom Router] Selecting complex model: ollama-gpt")
                data["model"] = "ollama-gpt"
            else:
                print("[Custom Router] Selecting lightweight model: ollama-qwen")
                data["model"] = "ollama-qwen"

        except Exception as e:
            print(f"[Custom Router] Error: {str(e)}")
            # Never leave the model unroutable - fall back to a known-good alias.
            if isinstance(data, dict):
                data["model"] = "ollama-gpt"

        return data


# The module-level instance LiteLLM resolves from the config string
# "custom_callbacks.custom_router".
custom_router = CustomMetricRouter()
