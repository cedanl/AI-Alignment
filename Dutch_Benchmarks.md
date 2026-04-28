---
title: "Dutch Benchmarks"
layout: default
nav_order: 4
---

# Dutch Benchmarks

There are number of benchmarks tuned specifically to the Dutch Language.

NOTE:

1.  ***Due to the rapid ageing of many benchmarks,***If you wish to implement a specific benchmark you may will need to check its current validity and if the benchmarks dataset needs updating.
2.  **Licensing** especially of the datasets has not (as yet) been reviewed
3.  **LM‑Eval** is *generation/classification‑oriented*, not embedding‑oriented.
4.  **Translating** specific benchmarks into Dutch is a path that is worth exploring
5.  **Complexity and velocity of change**: A fuller and regular scan will unveil a greater range of Dutch specific benchmarks.

These include:

- [**DUMB**](https://github.com/wietsedv/dumb) **(Dutch Model Benchmark)**: An up-to-date leaderboard and suite designed for the "Smart Evaluation" of Dutch models, providing a centralized comparison of how different LLMs handle Dutch-specific nuances. Reference: <https://aclanthology.org/2023.emnlp-main.447.pdf> (Source code update 3 years ago)

  - [Paper](https://aclanthology.org/2023.emnlp-main.447/)

- [SQUard-NL:](https://pieter.ai/blog/2024/evaluating-dutch-llms/)**S**tanford **Qu**estion **A**nswering **D**ataset (SQuAD) is a reading comprehension dataset, consisting of questions posed by crowdworkers on a set of Wikipedia articles, where the answer to every question is a segment of text, or *span*, from the corresponding reading passage, or the question might be unanswerable. Results page for [SQUard](https://rajpurkar.github.io/SQuAD-explorer/) Reference: <https://arxiv.org/pdf/1606.05250>

- [SICK-NL:](https://aclanthology.org/2021.eacl-main.126/) a dataset targeting Natural Language Inference in Dutch. SICK-NL is obtained by translating the SICK dataset of (Marelli et al., 2014) from English into Dutch. Having a parallel inference dataset allows us to compare both monolingual and multilingual NLP models for English and Dutch on the two tasks.

- [**MTEB-NL**](https://github.com/nikolay-banar/mteb-nl-dev) is a massive text embedding benchmark for Dutch. It extends the [MTEB (Massive Text Embedding Benchmark)](https://github.com/embeddings-benchmark/mteb) with tasks and datasets tailored to Dutch (NL).

  **Note**: This repository is deprecated, as **mteb-nl-dev** is incorporated into the main [MTEB](https://github.com/embeddings-benchmark/mteb) project. You can find MTEB-NL [here](http://mteb-leaderboard.hf.space/?benchmark_name=MTEB%28nld%2C+v1%29) with the corresponding latest evaluations.

**Leadershipboards:**

There are a number of leadership boards that have elements that can be reused within the Dutch context. These include:

- **European LLM Leaderboard:** a collection of multilingual evaluation results obtained using our fork of the LM-evaluation-harness (<https://github.com/OpenGPTX/lm-evaluation-harness>), based on V1 of the <https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard>.
- [Benchmark AI:](https://benchlm.ai/) The most comprehensive LLM comparison tool — 178 benchmarks, real pricing, and runtime data in one place.
  - [Multilingual](https://benchlm.ai/multilingual)
  - [Methodology](https://benchlm.ai/methodology)
  - [Evaluation Harness](https://github.com/groq/openbench/tree/main)
- [Onyx](https://onyx.app/llm-leaderboard)
- [Artificial Analysis](https://artificialanalysis.ai/)
  - [Methodology](https://artificialanalysis.ai/methodology)

**Hardware comparisons**

[LLMfit](https://www.llmfit.org/) is a terminal tool that right-sizes LLM models to your system's RAM, CPU, and GPU. Detects your hardware, scores each model across quality, speed, fit, and context dimensions, and tells you which ones will actually run well on your machine. The tool also enables community benchmarks across a range of hardware providing intelligence on which models are most appropriate for common hardware specs.

**Worth mentioning:**

However, not sure of active status:

- [ITHAX](https://www.ithax.ai/nl-benchmark/): AI praktijk benchmark voor Nederlands! Dus hoe goed scoren de modellen op taal-interpretatie, in context learning, programmeren, vertalen en meer.De benchmark is gebaseerd op meer dan 35 vragen verdeeld over 9 categorieën. De vragen zijn een afspiegeling van wat wij bij onze klanten tegenkomen. Sommige modellen in de test claimen expliciet Nederlands te ondersteunen, anderen niet. Om een goed beeld te krijgen van de verhoudingen hebben we een dwarsdoorsnede gekozen van de nu beschikbare modellen, van klein tot groot en van open tot commercieel.
- [De Langhe Et Al. (2024)](https://lt3.ugent.be/publications/benchmarking-zero-shot-text-classification-for-dut) - Benchmarking Zero-Shot Text Classification for Dutch
- [FinGEITje](https://dl.acm.org/doi/epdf/10.1145/3677052.3698628) - Dutch financial evaluation benchmark,
  - [Model code](https://github.com/snoels/fingeit)
  - [Evaluation package](https://github.com/snoels/fingeit/tree/main/src/evaluation)
- [DutchCrows:](https://studenttheses.uu.nl/handle/20.500.12932/50325) A Benchmark for Measuring Dutch Stereotypes in Large Language Models
- [Wietse de Vries](https://research.rug.nl/en/publications/evaluation-and-adaptation-of-neural-language-models-for-under-res/): Evaluation and Adaptation of Neural Language Models for Under-Resourced Languages - we find that language models can be adapted to other higher-resource languages (Dutch and Italian) or to low-resource languages (Gronings and Frisian) with minimal extra training.
- [Bram Vanroy:](https://arxiv.org/pdf/2312.12852) Language Resources for Dutch Large Language Modelling. Despite the rapid expansion of types of large language models, there remains a notable gap in models specifically designed for the Dutch language.e first fine-tuned Llama 2 using Dutch-specific web-crawled data and subsequently refined this model further on multiple synthetic instruction and chat datasets. These datasets as well as the model weights are made available. In addition, we provide a leaderboard to keep track of the performance of (Dutch) models on a number of generation tasks, and we include results of a number of state-of-the-art models, including our own.
- Evaluating Dutch Speakers and Large Language Models on Standard Dutch: a grammatical Challenge Set based on the Algemene Nederlandse Spraakkunst
  - [Paper](https://www.clinjournal.org/clinj/article/view/216/224)
