---
title: "Case study: Hosted benchmarking service"
layout: default
nav_order: 9
---

# Commercial Service

> [Trooper AI](https://www.trooper.ai/nl/llm-quality-benchmark) Tests against 25 free benchmarks.

Here is an example of a ready to run commercial service. This service is not open source, but it is a good example of how to run a benchmarking service without needing to build your own infrastructure.

There are pro's and con's. The main pro is that you can get up and running quickly without needing to build your own infrastructure. The main con is that you are limited to the benchmarks that the service provides, and you may not have as much control over the benchmarking process.

Trooper.AI GPU Server Blibs are dedicated, fully isolated GPU server instances hosted within the European Union. Each Blib provides users with powerful hardware and software resources, specifically tailored for GPU-intensive workloads such as machine learning, deep learning inference, data analytics, and GPU-accelerated application development.

The Trooper.AI [LLM TestBench](https://www.trooper.ai/nl/llm-quality-benchmark) is a free, browser-based benchmark that runs 25 tests in 7 categories — text, instruction following, multilingual fluency, structured output, reasoning, programming, and tool calling — against any OpenAI-compatible endpoint. The model itself acts as judge (LLM-as-judge) on a 0-10 scale, and your API key never leaves the browser. It is also designed to validate self-hosted models running on [Trooper.AI GPU servers](https://www.trooper.ai/nl/lp/ai-gpu-server), with [published GPU performance benchmarks](https://www.trooper.ai/nl/benchmarks) for reference.

## Similar benchmarking services

Other hosted and community benchmarking services offer similar or complementary capabilities:

- [Artificial Analysis](https://artificialanalysis.ai/) — Independent analysis of AI models and API providers, tracking quality, speed, and cost. Maintains the Intelligence Index and multiple arenas and leaderboards.
  - [Optima — build your own benchmark](https://artificialanalysis.ai/optima) — Create custom benchmarks from your own tasks to find the right model for your use case.
  - [LLM Leaderboard](https://artificialanalysis.ai/leaderboards/models) — Ranked models across intelligence, speed, cost, and capabilities.
  - [Methodology](https://artificialanalysis.ai/methodology) — How the Intelligence Index and other evaluations are designed and run.
- [Vellum LLM Leaderboard](https://www.vellum.ai/llm-leaderboard) — Public leaderboard of benchmark results (Humanity's Last Exam, GPQA Diamond, SWE-Bench, OSWorld, Terminal-Bench 2.1, BrowseComp) plus throughput, latency, and pricing tables.
- [Promptfoo](https://github.com/promptfoo/promptfoo) — Open-source evaluation and red-teaming platform for prompts, models, and RAG pipelines, with support for local and hosted providers.
  - [Promptfoo documentation](https://www.promptfoo.dev/docs/getting-started/) — Getting started with evaluations and benchmarks.
- [OpenCompass](https://github.com/open-compass/opencompass) — Open-source one-stop LLM evaluation platform by Shanghai AI Lab, supporting 100+ datasets across zero-shot, few-shot, and chain-of-thought settings.
  - [CompassRank](https://rank.opencompass.org.cn/home) — The hosted leaderboard of open and API models.
  - [CompassHub](https://hub.opencompass.org.cn/home) — A benchmark browser for exploring and contributing evaluation datasets.
- [EleutherAI lm-evaluation-harness](https://github.com/EleutherAI/lm-evaluation-harness) — The open-source framework behind the Hugging Face [Open LLM Leaderboard](https://huggingface.co/spaces/open-llm-leaderboard/open_llm_leaderboard), supporting 60+ standard benchmarks and local or OpenAI-compatible endpoints (see also Running Locally).