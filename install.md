---
title: "LLM Routers - A local Proof Of Concept"
layout: default
nav_order: 101
---

# LLM Routing

This is a small, friendly playground for developers who wish to understand how LLM routing works. The POC is used as demonstration purposes in a workshop on AI alignment.

It runs entirely on your own machine, in Docker, against a local Ollama — no cloud account, no API key, no cost per token. You can send prompts, change the rules, watch the decisions scroll past in the logs, and build a real intuition for how a request can be quietly steered to one model or another without the caller ever having to think about it.

It is deliberately simple: one proxy, one callback file, a handful of readable rules. Read it, break it, rewrite the rules, and see what happens.

***Code written:*** 22-09-2026 Disclaimer: This code is intended for educational and demonstration purposes only. It is provided "as-is"

## Motivation

There are two reasons this exists, and they reinforce each other.

**A community question.** This project is a modest contribution to a broader community discussion in Dutch Higher Education, exploring how educational institutions can route requests to AI models that reflect shared community values — models that are open, that respect privacy, and that the community can inspect and reason about together.

A design choice matters here: that alignment is *opt-in*. An organisation that shares those values can lean on them; an organisation that wants to ignore them is free to. Either way the experience for the person typing a prompt is the same — they talk to one endpoint, and the routing happens seamlessly behind it. Values become a property of the infrastructure, quietly, rather than a burden placed on the user.

**A developer question.** The same mechanism that makes values-based routing possible — deciding, per request, which model should answer — is also one of the simplest ways to get more out of any local setup, values aside:

- **Lower cost.** Smaller models are cheaper to run. Sending the easy prompts to a small model, and only reaching for a large one when it has genuinely earned its keep, is one of the easiest efficiency wins available. On a shared or self-hosted setup, the difference compounds quickly.
- **Lower latency.** The fastest answer is often the one that never has to queue behind a twenty-billion-parameter model. Routing keeps the common, simple case quick and reserves the heavy machinery for the requests that benefit from it.
- **A path to better small models for Dutch education.** Every routed request is a quiet signal about what people actually ask, and how. Handled with care, that traffic can become training data for fine-tuning smaller, faster, locally-runnable models with a genuine feel for the Dutch education context — a domain that general-purpose models handle unevenly at best.

***What this example does.*** A LiteLLM proxy listens on `http://localhost:4000` and exposes an OpenAI-compatible API. A small Python callback (`custom_callbacks.py`) inspects each request and decides what to do with it: answer it directly, refuse it, or forward it to one of two local Ollama models. Clients talk to the proxy as if it were any OpenAI endpoint. The rules that make those decisions are described below, and they are intentionally easy to read, question, and change.

***Note:*** The POC uses a 20 billion parameter model as an example of a costly model. If this is too big to run on your computer than consider slecting a smaller model.

## Routing rules

Every request passes through the same ordered chain. The first rule that matches wins and stops the request — later rules are never reached.

1.  **Personal information blocks the request.** The prompt is scanned by Microsoft Presidio for email addresses, credit-card numbers, and phone numbers. If any are found, the proxy returns the canned reply `Confidential - detected <TYPE>` and no model is called. Names (`PERSON`) are redacted in the logs but do not block, because the detector flags many ordinary capitalised words.
2.  **Keyword replies.** If the prompt contains the whole word `alan` or `ceda` (case-insensitive), a fixed canned reply is returned and no model is called.
3.  **Metric routing.** Prompts that look like coding work (containing `code`, `python`, `js`, or `bug`) or that are longer than 500 characters go to the larger model `ollama-gpt`. Everything else goes to the smaller `ollama-qwen`.
4.  **Safe default.** If anything in the chain fails, the request falls back to `ollama-gpt` so it is never left unroutable.

| The prompt contains... | Response | Model called? |
|------------------------|------------------------|------------------------|
| an email address, card number, or phone number | `Confidential - detected <TYPE>` | no |
| `alan` or `ceda` (whole word) | the canned reply | no |
| `code`, `python`, `js`, `bug`, or \> 500 characters | routed to `ollama-gpt` | yes |
| anything else | routed to `ollama-qwen` | yes |

Two important details:

- **Logging is scrubbed, routing is not.** Every prompt is written to the proxy log with PII replaced by tags such as `<PERSON>` or `<EMAIL_ADDRESS>`, but the prompt actually sent to the model is never modified.
- **Two request shapes.** The callback reads the prompt from `messages` on `/v1/chat/completions`, or from `input` on `/v1/responses` (used by the bundled `ping.R`). The metric rule in step 3 only inspects `messages`, so on `/v1/responses` it sees an empty prompt and always selects `ollama-qwen`.

### Example

``` sh
curl -s -X POST http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer sk-anything" \
  -H "Content-Type: application/json" \
  -d '{"model":"dynamic-router","messages":[{"role":"user","content":"Email me at jane@example.com"}]}'
```

returns the canned refusal:

``` text
Confidential - detected EMAIL_ADDRESS
```

## Installation

### Prerequisites

- Docker Desktop (or Docker Engine + Compose) with the `docker-compose` command.
- Ollama.

The stack is defined by three files at the repository root. The official LiteLLM image is used as-is with these files mounted into it.

| File | Purpose |
|------------------------------------|------------------------------------|
| [`docker-compose.yml`](./docker/docker-compose.yml) | Declares the three containers — the `litellm` proxy (publishes `localhost:4000`, sets `extra_hosts` so it can reach Ollama on the host) plus the `presidio-analyzer` and `presidio-anonymizer` sidecars for PII detection and redaction. Mounts the two files below into the proxy at `/app`. |
| [`config.yaml`](./docker/docker-compose.yml) | LiteLLM config. `model_list` maps the two aliases the callback routes to (`ollama-gpt` → `gpt-oss:20b`, `ollama-qwen` → `qwen3.5:2b`) onto a local Ollama at `http://host.docker.internal:11434`; `litellm_settings.callbacks` registers the routing callback. |
| [`custom_callbacks.py`](./docker/docker-compose.yml) | The routing logic described above — PII blocking, canned keyword replies, metric-based model selection. Mounted into the proxy and imported as `custom_callbacks.custom_router`. |

### 1. Install Ollama

#### macOS

``` sh
brew install ollama
```

Alternatively, download the app from <https://ollama.com/download/mac>.

#### Windows

Download and run the installer from <https://ollama.com/download/windows>.

#### Linux

``` sh
curl -fsSL https://ollama.com/install.sh | sh
```

### 2. Pull the models this project uses

The model tags must match `config.yaml`: `ollama-gpt` uses `gpt-oss:20b` and `ollama-qwen` uses `qwen3.5:2b`.

``` sh
ollama pull gpt-oss:20b
ollama pull qwen3.5:2b
```

A missing tag does not fail at startup — it fails at call time. Confirm the tags are present:

``` sh
ollama list
```

### 3. Make Ollama reachable from Docker

The proxy reaches Ollama through the host, so Ollama must listen off-localhost.

#### macOS

``` sh
launchctl setenv OLLAMA_HOST "0.0.0.0:11434"
```

Then restart the Ollama app. To undo later:

``` sh
launchctl unsetenv OLLAMA_HOST
```

#### Windows

Set the system environment variable `OLLAMA_HOST` to `0.0.0.0:11434` and restart the Ollama app.

#### Linux

Run the Ollama service with `OLLAMA_HOST=0.0.0.0:11434`, for example via a systemd override:

``` sh
sudo systemctl edit ollama
```

``` ini
[Service]
Environment="OLLAMA_HOST=0.0.0.0:11434"
```

``` sh
sudo systemctl restart ollama
```

#### Verify

``` sh
curl http://localhost:11434/api/tags
```

### 4. Start the Docker stack

From the repository root:

``` sh
docker-compose up -d
```

This pulls three images:

- `ghcr.io/berriai/litellm:main-latest` — the proxy
- `mcr.microsoft.com/presidio-analyzer:latest` — PII detection
- `mcr.microsoft.com/presidio-anonymizer:latest` — PII redaction

The Presidio sidecars start before the proxy (`depends_on`). They take roughly 10–20 seconds to load their NER model; until then the callback fails open and logged prompts are only partially scrubbed.

### 5. Verify the installation

Check that all three containers are running:

``` sh
docker ps
```

Expected: `litellm_proxy`, `presidio_analyzer`, `presidio_anonymizer`.

Send a test request:

``` sh
curl -s -X POST http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer sk-anything" \
  -H "Content-Type: application/json" \
  -d '{"model":"dynamic-router","messages":[{"role":"user","content":"What is the capital of France?"}]}'
```

Watch the proxy logs for callback output:

``` sh
docker logs -f litellm_proxy
```

### 6. Logging and the R smoke test

The callback logs every request before routing. Two things are worth watching in the proxy log:

- `[Custom Router] Prompt (scrubbed): ...` — the incoming prompt with PII replaced by tags such as `<PERSON>`, `<EMAIL_ADDRESS>`, `<CREDIT_CARD>` and `<PHONE_NUMBER>`. The prompt sent to the model is never modified.
- `[Custom Router] Selecting complex model: ollama-gpt` / `Selecting lightweight model: ollama-qwen` — which alias the callback chose.

If Presidio is still starting, the log shows `Presidio scrub failed, using regex fallback` and only emails and card numbers are redacted until the sidecars finish loading.

#### Run the R smoke test

[`ping.R`](./docker/ping.R) sends a handful of prompts through the proxy (including names, an email, a card number and a phone number) and prints the results. It uses the `/v1/responses` endpoint via the `mall` and `ellmer` packages.

Install the R packages once:

``` r
install.packages(c("mall", "ellmer", "dplyr"))
```

Then run it from the repository root:

``` sh
Rscript ping.R
```

While it runs, follow the scrubbed prompts in a second terminal:

``` sh
docker logs -f litellm_proxy
```

Prompts containing `Alan` or `CEDA` return a canned reply and are not sent to Ollama; the rest are routed by the callback.

### 7. Teardown

``` sh
docker-compose down
```
