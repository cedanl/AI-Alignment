---
title: "Running Locally"
layout: default
nav_order: 3
---

# Context

With the rise of [agentic](https://www.moveworks.com/us/en/resources/blog/what-does-agentic-mean) LLMs, there is a need for more resources, including the number of calls and their costs. The general capabilities of computers for running LLMs are improving, and optimisations at smaller model levels are delivering better performance. Therefore, at the time of writing (***May 2026***), one of the more common developer questions is “Can I run this locally?” or “What hardware do I need to run this locally?” The adoption of local models for agentic use, such as for coding and research (e.g., Claude Code) or for personal assistants (e.g., [openclaw](https://openclaw.ai/) ), is increasing. Therefore, for benchmarking models important to education, it is helpful to have a hardware checker that can determine whether a model can run locally and what the expected performance would be. This check helps focus our collective attention on the models that are most likely to be used locally i and for supporting the development of tools that educators and students can use without requiring access to large cloud-based models with the attendant risks, such as costs, data privacy, digital sovereignty, and sustainability (energy use).

# Ollama

Ollama runs LLMs locally or redirects calls to the cloud. It has a chat interface, and you can call it via an API. To install Ollama, follow [this link](https://ollama.com/download).

For benchmarking models through Ollama, the following resources are relevant:

- [EleutherAI lm-evaluation-harness](https://github.com/EleutherAI/lm-evaluation-harness) — The standard framework for evaluating LLMs on 60+ academic benchmarks (MMLU, HellaSwag, GSM8K, and more) and the backend of the Hugging Face Open LLM Leaderboard. Supports GGUF/quantized models and local OpenAI-compatible servers, so models served by Ollama can be benchmarked reproducibly.
- [lm-evaluation-harness — API guide](https://github.com/EleutherAI/lm-evaluation-harness/blob/main/docs/API_guide.md) — Documents the `local-completions` and `local-chat-completions` model types, which point evaluation at any OpenAI-compatible local server, including Ollama at `http://localhost:11434/v1`.
- [Ollama — OpenAI compatibility](https://docs.ollama.com/api/openai-compatibility) — Ollama exposes `/v1/chat/completions`, `/v1/completions`, and `/v1/responses`, so existing evaluation tooling can connect to local models by changing only the base URL.
- [Ollama blog — Faster Gemma 4 on MLX with multi-token prediction](https://ollama.com/blog/faster-gemma-4-mlx-mtp) — Ollama measures generation speed (tokens per second) on the Aider polyglot coding-agent benchmark, as an example of benchmarking local models through Ollama.
- [Ollama blog — NVIDIA DGX Spark performance](https://ollama.com/blog/nvidia-spark-performance) — Published performance tests with prefill and decode tokens per second per model and quantization, including the reproducible test script.
- [Ollama — Hardware support](https://docs.ollama.com/gpu) — The official compatibility table for NVIDIA, AMD, and Apple Silicon GPUs, useful for deciding which models can feasibly be benchmarked locally.

# LLM checker

A tool that checks the hardware requirements for running LLMs locally and provides recommendations is llm-checker. It requires Node. It can also act in conjunction with the Claude code so that the Claude code knows which models it can run locally via [Ollama](https://docs.ollama.com/integrations/claude-code).

LLM-checker assumes that you are running local LLMs and requires Ollama. You can find the installation guide [here](https://github.com/Pavelevich/llm-checker#installation).
