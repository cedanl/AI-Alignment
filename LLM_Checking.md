---
title: "Running Locally"
layout: default
nav_order: 3
---

# Context

With the rise of [agentic](https://www.moveworks.com/us/en/resources/blog/what-does-agentic-mean) LLMs, there is a need for more resources, including the number of calls and their costs. The general capabilities of computers for running LLMs are improving, and optimisations at smaller model levels are delivering better performance. Therefore, at the time of writing (***May 2026***), one of the more common developer questions is “Can I run this locally?” or “What hardware do I need to run this locally?” The adoption of local models for agentic use, such as for coding and research (e.g., Claude Code) or for personal assistants (e.g., [openclaw](https://openclaw.ai/) ), is increasing. Therefore, for benchmarking models important to education, it is helpful to have a hardware checker that can determine whether a model can run locally and what the expected performance would be. This check helps focus our collective attention on the models that are most likely to be used locally i and for supporting the development of tools that educators and students can use without requiring access to large cloud-based models with the attendant risks, such as costs, data privacy, digital sovereignty, and sustainability (energy use).

# Ollama

Ollama runs LLMs locally or redirects calls to the cloud. It has a chat interface, and you can call it via an API. To install Ollama, follow [this link](https://ollama.com/download).

# LLM checker

A tool that checks the hardware requirements for running LLMs locally and provides recommendations is llm-checker. It requires Node. It can also act in conjunction with the Claude code so that the Claude code knows which models it can run locally via [Ollama](https://docs.ollama.com/integrations/claude-code).

LLM-checker assumes that you are running local LLMs and requires Ollama. You can find the installation guide [here](https://github.com/Pavelevich/llm-checker#installation).
