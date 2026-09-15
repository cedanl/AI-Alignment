---
title: "LLM Routers - Saving money, enforcing alignment"
layout: default
nav_order: 100
---

<div class="info-box">

<strong>Scope.</strong> This page makes the case for placing an LLM router in front of NL Education chat interfaces such as the eduGenAI pilot - https://npuls.nl/edugenai  — lowering cost, and if scaled, later enforcing our community values — and treats the router as a shared community practice. Examples were found via web search on 15-09-2026.

</div>

# Summary

> An LLM router is a governance layer, and governance is a community practice.
{:.note}

This page makes the case for adding an LLM router in front of our chat interface for NL Education — and for treating that router as a shared community practice rather than a piece of infrastructure that one team installs and forgets. A router inspects each prompt and sends it to the most suitable model: a cheap one for simple questions, a strong one for hard tasks, and one on our own infrastructure whenever confidential data is involved. Done well, this lowers costs and turns our values into something the software actually enforces.
{:.section-intro}

What the router enforces is the community scorecard. Those rules encode how we, as an educational community, judge models — which ones are accurate, which are safe, which keep data at home — and they cannot be written once and left alone. New frontier models appear faster than any hand-maintained ruleset can follow, so the rules need the same thing any community practice needs: regular review, honest challenge, and updates as our shared understanding of our values evolves. The maintenance cost of the rules is not overhead; it is the governance itself, and it is work we should share openly rather than centralise.

The practical path is deliberately modest: start with an out-of-the-box commercial router — or, for the Dutch education sector, the [eduGenAI](https://npuls.nl/edugenai) pilot, where institutions can already choose which models to use and where data sovereignty is a design goal — nudge users towards better habits, collect feedback that improves smaller cheaper models, and generate our own benchmarks from real NL Education use — one step up the ladder of complexity at a time. The technology requires expertise. The community practice around the scorecard is the half to the equation that decides whether the router serves our values.

# Context

How we use LLMs is changing. Instead of one-off prompts typed into a chat interface, LLMs are increasingly used in swarms — for example, teams of models that write code or carry out research together. This shift is pushing costs up sharply across industry, both through official educational services and through unapproved "shadow AI" use. Without a strategy to address this, the first sign of the problem will be a surprising bill.

# Routing to LLM models

> The following technology has the potential to lower the cost of LLM usage and additionally provide a governance layer for our community values (Alignment).
{:.note}

There are real advantages to automatically inspecting the prompts written by end users and then routing each prompt to the most suitable LLM. If a prompt does not require much thinking, it can be sent to a cheaper model that is still accurate. If a prompt is just a simple "thank you", it can be handled without calling any model at all, while still sending nudges back to the end user — such as canned responses — so that they can learn the new way of talking. If a prompt involves confidential information, it can be routed to a model running on our own infrastructure. In practice, this lowers costs considerably, and it also makes it possible to enforce governance by defining rules. The hidden expense is that this approach adds complexity to your infrastructure and requires a degree of expertise to extract the full benefit.

In this page we explore the following:

1. What is an LLM router
2. What do we want to achieve
3. Relationship to a Chat GUI
4. Real world examples
5. The practicality of LLM routing

# What is an LLM router

An LLM router is an intelligent software layer that evaluates each incoming user prompt and automatically sends it to the most suitable Large Language Model (LLM). The decision is based on factors such as task complexity, cost, speed, and capability. Routers use several different approaches to make that decision.

The simplest approach is to look for keywords in the prompt and route based on those. For example, if the prompt contains the words "financial" or "medical", the router sends it to an LLM running on your own infrastructure. Simple pattern matching like this is fragile and error-prone. The next step up is a small machine learning model that characterises the prompt and then routes it based on its understanding of the context.

As the technology matures, additional features will become commonplace — such as pluggable governance rules, better observability, and easier tuning of the classification models used for routing.

# What do we want to achieve

This is a website about AI alignment. What we want to achieve is not necessarily the massive cost savings that LLM routers can deliver at scale. Those savings can be obtained through a near out-of-the-box deployment of an open source router, or by buying in an AI Act and GDPR compliant routing service. Once we have experience with the infrastructure component, what we want to achieve is a second layer of decision making inside the router that takes the community scorecard into account.

Scorecard routing can be as simple as baking the scorecard rules into the router's configuration — for example, by writing custom Python code that runs as part of the routing decision. Initially this code would be static: the scorecard rules would need updating by hand as new information becomes available. However, given the rapid pace at which new frontier models are released, a better approach would be to gather information live from benchmarking services. Given the update rate, and the need to consult a wide range of benchmarks, this would carry a cost of maintenance and human sanity-checking of the rules. That cost is part of the cost of governance, and it is what allows the rules to be updated dynamically as the community's understanding of its values evolves.

# Relationship to a Chat GUI

The examples of reuse of data below all require options such as opt-in and explanations within the chat interface.
{:.section-intro}

## Contextual feedback

Based on its rules the LLM router can provide extra feedback to the end user that nudges them to better behaviour. For example, if the user has a choice of model in the GUI interface and it is less secure or data is going into the cloud as another model choice then the LLM router can add a disclaimer explaining the situation as part of the response especially if the prompt is characterised as confidential.

As nudging can be intrusive, there should be an off switch in the interface and a clear explanation about the motivation.

## Training data

The user prompts are useful for training models especially if the user has the chance to provide feedback through the chat web interface. If this approach is enabled, at the least the user should have an opt-out option with terms and conditions in the interface.

Examples of usage are mentioned in the next subsections:

### Improving the LLM router

The small ML model that routes prompts can be further trained from the thumbs up or down feedback in the chat interface on the returned response. Chatbot Arena is the best-known example of this approach at scale — users compare model outputs and the aggregated preferences are used both to rank models and to train routers (Chiang et al., 2024, [arXiv:2403.04132](https://arxiv.org/abs/2403.04132)).

### Binary classification (thumbs up/down)

A user is provided with two outputs and chooses the best and, if necessary, defining the category of the topic answered. At scale the responses are used to fine tune a smaller model for the particular topic. The smaller model is cheaper and faster to run and is more attuned to the Educational sector. This is the same pairwise-preference mechanism behind RouteLLM, whose binary strong/weak routers are trained on exactly this kind of data (Ong et al., 2024, [arXiv:2406.18665](https://arxiv.org/abs/2406.18665)).

### On error feedback

If a prompt is causing issues such as a hallucination or providing harmful content then a feedback button can be used to generate further training data or help the router recognize and avoid a riskier model.

### Distillation

A subset of prompts might be sent to expensive models. The generated responses are then used to improve smaller models. This approach provides training data for the Educational context.

### Generating our own NL benchmarks

The data mentioned above is useful for keeping benchmarks fresh. For example, the on error feedback provides real world examples of when AI fails within the context of Dutch Education. For what to collect, the hallucination taxonomy in Huang et al. (2023, [arXiv:2311.05232](https://arxiv.org/abs/2311.05232)) gives a starting vocabulary for categorising real-world failures.

# Real world examples

The table below lists the most prominent open source and commercial LLM routers. The "Viability" column assesses each router specifically against our goal from the previous section: running custom AI alignment rules — baking community scorecard rules into the routing decision as configuration or code.
{:.section-intro}

## Open source routers

| Router | Approach | Viability for custom alignment rules | Citation |
|---|---|---|---|
| **RouteLLM** (LMSYS) | Trained routers (matrix factorization, BERT, weighted-Elo) choose between a strong/expensive and a weak/cheap model pair, based on a predicted "win rate" — an estimate of how likely the stronger model's answer is to beat the weaker one for that specific prompt | Limited as-is: routing is purely a cost/quality trade-off with no policy layer. It is, however, cleanly extensible — a scorecard could be implemented as a custom router by implementing the abstract `Router` class (`calculate_strong_win_rate`). Small research-oriented codebase; routers are trained on Chatbot Arena preference data and may need retraining for new model pairs | [lm-sys/RouteLLM](https://github.com/lm-sys/RouteLLM); Ong et al. (2024), [arXiv:2406.18665](https://arxiv.org/abs/2406.18665) |
| **LiteLLM AI Gateway** (BerriAI) | A self-hosted gateway with one OpenAI-compatible interface to 100+ providers; load-balancing strategies (weighted, latency, cost), fallbacks, spend tracking, guardrails, plus an Auto Router (beta) that classifies requests using heuristics, an LLM classifier, or semantic rules | Strong fit: a custom routing strategy can be plugged in via `CustomRoutingStrategyBase`, and scorecard rules can also be enforced as guardrails (custom hooks) on requests. Large, active, production-grade project — but Auto Routing is beta, and some enterprise features sit behind a commercial license | [BerriAI/litellm](https://github.com/BerriAI/litellm); [Routing docs](https://docs.litellm.ai/docs/routing); [Auto Routing docs](https://docs.litellm.ai/docs/proxy/auto_routing) |
| **vLLM Semantic Router** | A programmable "Mixture-of-Models" router: it evaluates request signals, user preferences and **application policies** to select or compose a model path, without hard-coding routing logic into applications | Best architectural fit: policies and system-prompt rules per category are first-class configuration, which maps directly onto scorecard rules; it also ships guardrails and hallucination detection. Young but very fast-moving project under the vLLM umbrella (Apache-2.0); heavier infrastructure (a Go service, Envoy, embedding models) than the simpler options | [vllm-project/semantic-router](https://github.com/vllm-project/semantic-router); "When to Reason: Semantic Router for vLLM", [arXiv:2510.08731](https://arxiv.org/abs/2510.08731) |
| **Semantic Router** (Aurelio Labs) | A library, not a gateway: routes are defined by lists of example utterances matched in semantic vector space, giving superfast (~millisecond) decisions; fully local execution is possible | Good fit for rule-like routing — a "confidential data" or "political content" route is literally just a list of example utterances, and route thresholds are trainable (see the healthcare routing example in its docs). But you must build the serving layer around it yourself; there is no built-in gateway, observability, or fallbacks | [aurelio-labs/semantic-router](https://github.com/aurelio-labs/semantic-router); Manias et al. (2024), IEEE GlobeCom, [arXiv:2404.15869](https://arxiv.org/abs/2404.15869) |
| **Gateway API Inference Extension / llm-d Router** (Kubernetes SIG) | An Envoy-based inference gateway for Kubernetes: picks the best endpoint across self-hosted model servers, aware of load and prefix caching, with priority and A/B rollout APIs | Poor fit for alignment rules: it routes *between replicas of the same model* for latency and throughput, not between models by policy. Only relevant if every scorecard-selected model is self-hosted on Kubernetes — in which case it complements (rather than replaces) a policy router like LiteLLM. Significant platform expertise required | [kubernetes-sigs/gateway-api-inference-extension](https://github.com/kubernetes-sigs/gateway-api-inference-extension); [llm-d/llm-d-router](https://github.com/llm-d/llm-d-router) |
{:.contents-table}

## Commercial routers (out of the box)

These are ready-made services: no infrastructure to run, and usable with an account and an API key. The trade-off is that the routing logic lives on the vendor's side, so our own alignment rules can only be applied by placing a gateway of our own between our users and the service.

| Router | Approach | Viability for custom alignment rules | Citation |
|---|---|---|---|
| **Not Diamond** | A commercial intelligent model router, focused on coding agents: it predicts the best model for each request, claiming accuracy gains and cost savings at equivalent quality. Its recommendations are executed in your existing gateway or harness, protecting against vendor lock-in. SOC 2 and ISO 27001 compliant; customers include OpenRouter, Dropbox, IBM, and DoorDash | Moderate fit: excellent out of the box for cost/quality routing with strong compliance credentials, but the routing rules are the vendor's, not ours. Our scorecard rules cannot run inside Not Diamond itself; they would have to be enforced in a gateway layer in front of it. Priced commercially (per-demo/API) | [notdiamond.ai](https://www.notdiamond.ai); [docs](https://code.notdiamond.ai/docs/) |
| **OpenRouter** | A commercial unified API giving access to hundreds of models through a single endpoint, with automatic fallbacks and cost-effective model selection; drop-in replacement for the OpenAI SDK | Limited fit for alignment rules: the simplest of all to adopt — sign up, point your existing OpenAI client at it — but routing happens entirely on OpenRouter's side. Our scorecard rules would have to live in a local gateway between our users and OpenRouter. Data-processing/compliance terms are contractual, not configurable in code | [openrouter.ai/docs](https://openrouter.ai/docs) |
| **eduGenAI** (SURF/Npuls pilot) | A Dutch education-sector platform offering chat with both SURF-hosted open-source and commercial models, developed to protect public values such as data sovereignty and privacy; a DPIA was carried out during development, and from H2 2026 institutions can choose which AI models to use and connect their own systems | Emerging fit: not a router itself, but the sector platform through which model choice and scorecard rules could be exercised; pilot-stage, so capabilities are still being built out — worth engaging now to ensure alignment rules are represented | [npuls.nl/edugenai](https://npuls.nl/edugenai); [SURF DPIA news](https://www.surf.nl/en/news/dpia-edugenai-working-on-safe-and-responsible-ai-in-education); [pilot expansion news](https://npuls.nl/nieuws/edu-gen-ai-breidt-pilot-uit) |
{:.contents-table}

## Choosing a starting point

In terms of the ladder of experience described below: **Semantic Router** (Aurelio Labs) and **LiteLLM** are the natural starting points for prototyping scorecard rules — the former as an embeddable library, the latter as a full gateway. Among the commercial options, **Not Diamond** is the better first step because its recommendations execute in our own gateway, leaving room to layer scorecard rules on top. **RouteLLM** is the strongest option where routing is driven by measured cost/quality benchmarks, which matches the live-benchmark-driven rules discussed earlier, but it expects more in-house machine learning capability. The Kubernetes inference gateway is only worth considering once the models the scorecard selects are self-hosted at scale. For institutions in the Dutch education sector, the [eduGenAI](https://npuls.nl/edugenai) pilot is the natural sector-level platform to engage with — its model-choice features are exactly where community scorecard rules could land.

# The practicality of LLM routing

LLM routing is not a trivial project. It requires additional artifacts inside your infrastructure and a potentially complex and rapidly changing ruleset — which, depending on the complexity of the rules and extra features, may require significant maintenance. To walk up the ladder of experience, it may well be worth first starting with a commercial product that is guaranteed stable and runs outside your organisation. Build up your understanding and improve the routing rules to suit your specific needs; then, once your team is skilled and understands the subtle details, consider moving to an open source router running on your own infrastructure.

Another approach is to deploy an open source router with a minimum set of rules, and slowly increase the complexity once it is stable.

## What you are signing up for

The "additional artifacts" mentioned above are worth spelling out. A router is rarely just one service: you may also be running an embedding model for the classification step, a place to store the rules and configuration, logging and observability so you can see what was routed where and why, and — if you choose a learned router such as RouteLLM — a cycle of retraining whenever the model pool changes. The research behind RouteLLM is explicit that a router must judge two things at once: what kind of question the prompt is, and how well each available model handles it. Its practical guidance reflects that: routing thresholds should be calibrated against a sample of your own queries, not left at defaults ([lm-sys/RouteLLM](https://github.com/lm-sys/RouteLLM); [LMSYS blog](https://lmsys.org/blog/2024-07-01-routellm/)).

The "rapidly changing ruleset" is the other half of the commitment. New frontier models appear at a pace that no hand-maintained ruleset can comfortably follow. The strong/weak model pair, the candidate pool, and the thresholds all need periodic review — and every review is a small piece of governance work, as argued in the section on what we want to achieve.

## Where the real costs sit

The visible costs are infrastructure and maintenance. The less visible cost is that routing mistakes are quality mistakes: if the router sends a complex prompt to a model that cannot handle it, or a confidential prompt to a model outside your infrastructure, the result is not just a wrong answer — it is a governance failure of exactly the kind the keyword-matching example in "What is an LLM router" was meant to illustrate. A router that is right 95% of the time still mis-routes one request in twenty, and those requests are rarely random; they cluster around the harder, more sensitive cases.

The benchmark-driven variant discussed earlier — rules gathered live from benchmarking services — carries its own additional load: data plumbing, benchmark selection, and human sanity-checking of the rules. That cost is deliberate and worthwhile, but it should be budgeted as part of governance, not discovered later.

## Walking the ladder in practice

If your traffic is small and homogeneous, a router's complexity may exceed its savings. Routing earns its keep at scale — the larger and more varied the prompt mix, the more both the cost savings and the governance layer are worth.

This is a potential path, not a recommendation — here is a starting point for a conversation:

<div class="step-section">

<span class="step-number">1</span> <strong class="color-accent-text">Start with a commercial service.</strong> Not ideal, but it allows you to break the problem into smaller parts. Not Diamond's recommendations execute in your own gateway; OpenRouter is the simplest to adopt. Either way you learn what routing does to your traffic without owning any infrastructure.

</div>

<div class="step-section">

<span class="step-number">2</span> <strong class="color-accent-text">Move to a self-hosted gateway.</strong> Once the rules are understood, move to LiteLLM as a self-hosted gateway and express your scorecard rules as guardrails and custom routing strategies.

</div>

<div class="step-section">

<span class="step-number">3</span> <strong class="color-accent-text">Consider learned and heavier options.</strong> Only then consider learned routing (RouteLLM) or the heavier infrastructure options (vLLM Semantic Router, the Kubernetes inference gateway).

</div>

# Final thoughts

What is our definition of scale? Out of the box LLM routers can push down costs. However, have we got enough usage to extract all the value? There is a lot of gold to pick up off the ground, but that requires experience, dedication, time and hours. We can nudge users to help them learn the best ways to communicate with the LLMs, mitigate bad behaviour, support AI alignment to our values, generate benchmarks, and improve smaller cheaper models to perform better for NL Education — one step up the ladder of complexity at a time.

# Further reading

Blog posts that explain the benefits of LLM routing in plain terms:

- *RouteLLM: An Open-Source Framework for Cost-Effective LLM Routing* (LMSYS blog) ([lmsys.org](https://lmsys.org/blog/2024-07-01-routellm/)) — explains the core dilemma in plain terms: capable models are expensive, cheap models are weaker, and routing between the two gets the best of both
- *Building an LLM Router for High-Quality and Cost-Effective Responses* (Anyscale blog) ([anyscale.com](https://www.anyscale.com/blog/building-an-llm-router-for-high-quality-and-cost-effective-responses)) — its introduction gives a clear plain-language picture of what a router does and why it saves money; the rest is a hands-on build guide for those who want depth
- *Auto Router* (OpenRouter documentation) ([openrouter.ai](https://openrouter.ai/docs/guides/routing/routers/auto-router)) — a plain-terms explanation of automatic model selection driven by what millions of real users spend on
- *Beyond a Single Model: Building Mixture-of-Models Systems with vLLM Semantic Router* (vLLM Semantic Router blog) ([vllm-sr.ai](https://vllm-sr.ai/blog/vllm-sr-new-chapter-mom)) — why no single model is best for every request; largely technical, but the opening is accessible to a general reader

Research papers:

- *Dynamic Model Routing and Cascading for Efficient LLM Inference: A Survey* ([arXiv:2603.04445](https://arxiv.org/abs/2603.04445)) — a broad survey of routing and cascading approaches
- *RouteLLM: Learning to Route LLMs with Preference Data* ([arXiv:2406.18665](https://arxiv.org/abs/2406.18665)) — the research behind the open source router in the examples above
- *RouterBench: A Benchmark for Multi-LLM Routing System* ([arXiv:2403.12031](https://arxiv.org/abs/2403.12031)) — how routing systems are measured on cost vs. quality
- *Arch-Router: Aligning LLM Routing with Human Preferences* ([arXiv:2506.16655](https://arxiv.org/abs/2506.16655)) — routing that follows human-stated preferences, closest to our scorecard idea