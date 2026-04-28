---
title: "Evaluation Harness"
layout: default
nav_order: 2
---

# Evaluation Harnesses

> ℹ️ **Information:** 
> Consider [adding](https://huggingface.co/blog/Neo111x/integrating-benchmarks-into-lm-evaluation-harness) available Dutch benchmarks into an evaluation harness and sharing.

## Context

AN evaluation harness allows you to easily run a standardized set of benchmarks against a model of choice. This allows you fill in gaps in your knowledge about the capabilites of your model of interest. The harness also allows you to attach your own benchmarks by following well documented conventions ad structures.

## LM Evaluation harness

> [lm-evaluation-harness](https://github.com/EleutherAI/lm-evaluation-harness) : The Language Model Evaluation Harness is a unified framework for testing generative language models on a wide variety of benchmarks. It ensures reproducibility by using publicly available prompts and supports customized evaluations.

[Quote:](https://huggingface.co/blog/Neo111x/integrating-benchmarks-into-lm-evaluation-harness) The LM Evaluation Harness is a Python-based framework developed by EleutherAI for evaluating the performance of language models on a wide range of NLP benchmarks. It supports multiple tasks such as multiple-choice, question answering, and classification, and is compatible with both local and API-based models (like OpenAI's GPT or Hugging Face models). The harness provides a standardized way to compare model performance across datasets like MMLU, HellaSwag, ARC, and more. It is modular, extensible, and widely used in the research community for assessing language model capabilities.

[Key features](https://slyracoon23.github.io/blog/posts/2025-03-21_eleutherai-evaluation-methods.html) include Over 60 standard academic benchmarks with hundreds of subtasks

It includes a Dutch version of the [MMLU benchmark](https://en.wikipedia.org/wiki/MMLU) which consists of 15,908 multiple-choice questions, with 1,540 of them being used to select and assess optimal settings for models – temperature, [batch size](https://en.wikipedia.org/wiki/Batch_processing "Batch processing") and [learning rate](https://en.wikipedia.org/wiki/Learning_rate). The questions span across 57 subjects, from highly complex [STEM](https://en.wikipedia.org/wiki/Science,_technology,_engineering,_and_mathematics "Science, technology, engineering, and mathematics") fields and international law, to nutrition and religion. It was one of the most commonly used [benchmarks](https://en.wikipedia.org/wiki/Benchmarks_for_artificial_intelligence "Benchmarks for artificial intelligence") for comparing the capabilities of [large language models](https://en.wikipedia.org/wiki/Large_language_model "Large language model"), with over 100 million downloads as of July 2024

## A Dutch Version

> ⚠️ **Warning** 
> Last modified 2 years ago:

You can find a Dutch evaluation harness here: [Dutch Evaluation Harness](https://github.com/iPieter/dutch-lm-evaluation-harness).
The harness includes support for Support for Dutch evaluation benchmarks (e.g. SQUADNL) and Dutch prompts.


