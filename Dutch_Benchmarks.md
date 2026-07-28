---
title: "Dutch Benchmarks"
layout: default
nav_order: 4
---

# Dutch Benchmarks

<div class="info-box">

<strong>AI-generated — July 2026.</strong> This page was produced by an AI assistant drawing on publicly available benchmark documentation, papers, and repository descriptions. Details should be checked against the primary sources. Due to the rapid ageing of benchmarks, verify current validity before implementation.

</div>

# Context

There are a number of benchmarks tuned specifically to the Dutch language, ranging from grammatical evaluation and reading comprehension to logical reasoning, bias assessment, and information retrieval. The landscape is evolving quickly, with older benchmarks being superseded by newer versions or incorporated into larger frameworks.

Before using any benchmark listed here, consider the following:
{:.section-intro}

<div class="step-section">

<span class="step-number">1</span> <strong class="color-accent-text">Check current validity.</strong> Benchmarks age quickly — datasets may need updating, and some leaderboards are no longer maintained.

</div>

<div class="step-section">

<span class="step-number">2</span> <strong class="color-accent-text">Review licensing.</strong> Licensing of datasets has not been fully reviewed here. Always verify before use, especially for commercial applications.

</div>

<div class="step-section">

<span class="step-number">3</span> <strong class="color-accent-text">Choose the right tool.</strong> LM Evaluation Harness is <em>generation/classification-oriented</em>, not embedding-oriented. For embedding tasks, use MTEB-NL.

</div>

<div class="step-section">

<span class="step-number">4</span> <strong class="color-accent-text">Translation is a viable path.</strong> Translating specific English benchmarks into Dutch is worth exploring, but watch for cultural adaptation issues — machine translation alone can miss linguistic nuances.

</div>

<div class="step-section">

<span class="step-number">5</span> <strong class="color-accent-text">The landscape changes fast.</strong> A fuller and regular scan will unveil a greater range of Dutch-specific benchmarks. Some resources listed here may have moved or been superseded.

</div>

# Comprehensive Benchmarks

These benchmarks cover multiple task types and provide a broad assessment of Dutch language model capability.

## DUMB — Dutch Model Benchmark

<strong>DUMB</strong> (de Vries et al., EMNLP 2023) is a balanced benchmark of <strong>nine Dutch language tasks</strong> spanning word-level, word-pair-level, sentence-pair-level, and document-level tasks across low-, medium-, and high-resource settings. It includes four tasks that were previously unavailable in Dutch.

<strong>Tasks:</strong> Part-of-Speech Tagging (Lassy Small), Named Entity Recognition (SoNaR-1), Word Sense Disambiguation (WiC-NL), Pronoun Disambiguation (DPR), Causal Reasoning (COPA-NL), Natural Language Inference (SICK-NL), Sentiment Analysis (DBRD), Abusive Language Detection (DALC), Question Answering (SQuAD-NL).

<strong>Key innovation:</strong> DUMB introduces <strong>Relative Error Reduction (RER)</strong> as a comparative metric — measuring how much a model improves over the BERTje baseline — rather than using raw mean scores. This makes scores comparable even as the set of models changes over time.

[Leaderboard](https://dumbench.nl) · [Repository](https://github.com/wietsedv/dumb) · [Paper](https://aclanthology.org/2023.emnlp-main.447/)

## MTEB-NL — Massive Text Embedding Benchmark for Dutch

<strong>MTEB-NL</strong> (Banar et al., 2026) is a comprehensive embedding benchmark for Dutch, extending the international <strong>MTEB (Massive Text Embedding Benchmark)</strong> with tasks and datasets tailored to Dutch. It was originally developed as a separate repository (<strong>mteb-nl-dev</strong>) before being incorporated into the main MTEB project.

The benchmark covers <strong>7 task types across 40 datasets</strong>: classification, multi-label classification, pair classification, reranking, retrieval, clustering, and semantic textual similarity. It includes both existing Dutch datasets and newly created ones.

Alongside the benchmark, the authors released <strong>E5-NL</strong>, a series of compact yet efficient Dutch embedding models, and a training dataset compiled from available Dutch retrieval resources.

[MTEB-NL Leaderboard](http://mteb-leaderboard.hf.space/?benchmark_name=MTEB%28nld%2C+v1%29) · [Paper (ACL 2026)](https://aclanthology.org/2026.findings-acl.1236/) · [arXiv](https://arxiv.org/html/2509.12340)

## BLiMP-NL — Linguistic Minimal Pairs for Dutch

<strong>BLiMP-NL</strong> is a corpus of <strong>8,400 Dutch sentence pairs</strong> intended for grammatical evaluation of language models. Each pair consists of a grammatical sentence and a minimally different ungrammatical sentence. The corpus covers <strong>84 paradigms</strong> grouped into <strong>22 syntactic phenomena</strong>.

The dataset improves on the original English BLiMP in two key ways: (1) native speakers created and checked all minimal pairs, and (2) human validation used both <strong>acceptability ratings</strong> (7-point scale, 30+ participants per item) and <strong>reading times</strong> (self-paced reading). The authors evaluated 14 Dutch transformer models, with GPT-2-based models showing superior overall performance.

[Dataset](https://doi.org/10.34973/tj4p-y007) · [Paper (MIT Press, 2025)](https://direct.mit.edu/coli/article/51/4/1267/128735/BLiMP-NL-A-Corpus-of-Dutch-Minimal-Pairs-and)

## ScandEval — Scandinavian and Germanic Language Evaluation

<strong>ScandEval</strong> is a leaderboard and Python package for evaluating LLMs on Scandinavian and Germanic languages, including Dutch. It provides a standardized evaluation framework with multiple benchmark tasks. The <strong>Open Dutch LLM Evaluation Leaderboard</strong> (formerly at HuggingFace Spaces) is no longer maintained; users are referred to ScandEval for Dutch evaluations instead.

ScandEval includes Dutch tasks such as <strong>conll_nl</strong> (named entity recognition), <strong>dutch_social</strong> (sentiment analysis), <strong>squad_nl</strong> (question answering), <strong>mmlu_nl</strong> (knowledge), <strong>hellaswag_nl</strong> (commonsense reasoning), and others.

[ScandEval Dutch NLG](https://scandeval.com/dutch-nlg/) · [Repository](https://github.com/ScandEval/ScandEval)

# Task-Specific Benchmarks

These benchmarks target specific capabilities or domains.

## SQuAD-NL — Dutch Question Answering

<strong>SQuAD-NL</strong> is the Dutch version of the Stanford Question Answering Dataset. It consists of reading comprehension questions posed on Wikipedia articles, where the answer is a text span from the passage. SQuAD-NL is included as one of the nine tasks in the DUMB benchmark and is also used by ScandEval for Dutch evaluation.

[Dutch LLM Evaluation Blog Post](https://pieter.ai/blog/2024/evaluating-dutch-llms/) · [Original SQuAD Paper](https://arxiv.org/pdf/1606.05250)

## SICK-NL — Dutch Natural Language Inference

<strong>SICK-NL</strong> is a dataset targeting natural language inference in Dutch, obtained by translating the English SICK dataset (Marelli et al., 2014). Having a parallel inference dataset allows comparison of both monolingual and multilingual NLP models for English and Dutch on the same tasks.

[Paper (EACL 2021)](https://aclanthology.org/2021.eacl-main.126/)

## BEIR-NL — Dutch Information Retrieval Benchmark

<strong>BEIR-NL</strong> (Lotfi et al., 2025) is a Dutch-translated version of the BEIR benchmark for zero-shot evaluation of information retrieval models. It covers <strong>14 datasets</strong> across multiple retrieval tasks and domains, automatically translated using Gemini-1.5-flash. The authors evaluated BM25, multilingual dense ranking models, and reranking models.

Key findings: BM25 remains a competitive baseline, only outperformed by larger dense models; combining BM25 with reranking matches the best dense models. The study also found that back-translation causes a performance drop, highlighting the limitations of translation-based benchmarks and the need for native Dutch resources.

[Paper (BUCC 2025)](https://aclanthology.org/2025.bucc-1.5.pdf) · [HuggingFace](https://huggingface.co/datasets?search=BEIR-NL)

## SLR-Bench-Dutch — Logical Reasoning in Dutch

<strong>SLR-Bench-Dutch</strong> is the Dutch-language version of the Scalable Logical Reasoning Benchmark. It provides <strong>19,000+ inductive reasoning tasks</strong> across 20 complexity levels grouped into 4 tiers (basic, easy, medium, hard). Each task includes a natural language prompt in Dutch, an executable validation program for automatic evaluation, and a latent ground-truth rule.

The benchmark supports curriculum learning — models can be trained and evaluated across progressively harder levels — and is fully automatically generated, requiring no human annotation.

[Dataset on HuggingFace](https://huggingface.co/datasets/AIML-TUDA/SLR-Bench-Dutch) · [Paper (NeurIPS 2025)](https://arxiv.org/abs/2506.15787)

## DutchCrowS — Dutch Stereotype Benchmark

<strong>DutchCrowS</strong> is the first benchmark specifically designed to evaluate Dutch stereotypes in LLMs. It adapts the CrowS-Pairs dataset by selecting, translating, and adapting data, then extending it with newly crowdsourced Dutch-specific stereotypes across <strong>nine social groups</strong> (831 sentence pairs total).

Findings: models explicitly trained on Dutch data (GEITje-7B-Ultra, EuroLLM-9B-Instruct) exhibit higher stereotyping scores than general multilingual models — suggesting that training on a language introduces bias specific to that language.

[MSc Thesis (Utrecht University, 2025)](https://studenttheses.uu.nl/handle/20.500.12932/50325)

## Social Bias Benchmark (MinBZK) — Dutch Hiring Bias

The Dutch Ministry of the Interior and Kingdom Relations (<strong>MinBZK</strong>) developed a benchmark to assess social bias in LLMs within a <strong>hiring decision setting</strong>, focusing on gender and country of origin. It systematically generates thousands of template-based prompts and measures bias through acceptance rate differences.

Evaluated models (GPT-4o-mini, Claude 3.5 Haiku, Geitje-7B-Ultra, EuroLLM-9B-Instruct) <strong>all exhibited social bias</strong> to some extent. The benchmark is publicly available under an EUPL-1.2 license.

[Repository](https://github.com/MinBZK/llm-benchmark/tree/main/benchmarks/social-bias) · [Paper (LREC 2026)](https://anneschuth.nl/assets/burema-lrec2026.pdf)

## ANS Challenge Set — Dutch Grammatical Challenge

A challenge set based on the <strong>Algemene Nederlandse Spraakkunst (ANS)</strong>, the comprehensive resource of Dutch prescriptive grammar created by linguists. The study collected acceptability judgments from Dutch native speakers and evaluated both transformer-encoder and transformer-decoder Dutch LLMs. Encoder models showed near-perfect accuracy, but sensitivities for specific sentences differed between models and humans, partially due to mismatches between reference grammar and actual Dutch usage.

[Paper (CLIN Journal, 2026)](https://www.clinjournal.org/clinj/article/view/216/224)

## FinGEITje — Dutch Financial Evaluation

<strong>FinGEITje</strong> is a Dutch financial evaluation benchmark for assessing LLM performance on financial domain tasks in Dutch. It includes model weights, an evaluation package, and task definitions specific to the Dutch financial sector.

[Model Code](https://github.com/snoels/fingeit) · [Evaluation Package](https://github.com/snoels/fingeit/tree/main/src/evaluation) · [Paper](https://dl.acm.org/doi/epdf/10.1145/3677052.3698628)

## Benchmarking Zero-Shot Text Classification for Dutch

De Langhe et al. (2024) studied zero-shot text classification performance for Dutch, benchmarking several models and approaches. This work provides insights into how well models handle Dutch text classification without task-specific training data.

[Paper (LT3, Ghent University)](https://lt3.ugent.be/publications/benchmarking-zero-shot-text-classification-for-dut)

## Psychometric Evaluation of Dutch LLMs

A <strong>systematic evaluation of 14 Dutch transformer models</strong> examined how well their surprisal estimates account for reading times in sentence, paragraph, and book reading corpora. GPT-2-based models (particularly gpt2-small-dutch) demonstrated superior overall performance. The study replicated the inverse scaling trend (smaller models performing better for reading time prediction) and the linear effect of surprisal on reading times for Dutch.

[Paper (Behavior Research Methods, 2025)](https://link.springer.com/article/10.3758/s13428-025-02774-4) · [Data & Code](https://osf.io/wr4qf/)

# Dutch Language Models (with Evaluation Context)

Several models have been specifically trained or adapted for Dutch and are evaluated using the benchmarks above.

## RobBERT Family

<strong>RobBERT</strong> (Delobelle et al.) is a Dutch version of RoBERTa, with multiple versions:

- <strong>RobBERT v2</strong> — Dutch vocabulary, trained on OSCAR 2019
- <strong>RobBERT-2022</strong> — Updated with larger OSCAR 22.01 corpus
- <strong>RobBERT-2023</strong> — State-of-the-art: achieves <strong>+18.6 RER</strong> on DUMB benchmark (large variant, 355M params), outperforming all existing Dutch and multilingual models at time of release. Uses Tik-to-Tok model conversion strategy from English RoBERTa.
- <strong>RobBERTje</strong> — Distilled variants (40M–74M params) for faster inference

[RobBERT Page](https://pieter.ai/robbert/) · [Repository](https://github.com/ipieter/robbert) · [RobBERT-2023 Paper](https://www.clinjournal.org/clinj/article/view/180)

## BERTje

<strong>BERTje</strong> (de Vries et al., 2019) is the first Dutch pre-trained language model, a Dutch version of BERT-base. It serves as the baseline model for the DUMB benchmark's RER metric. Although now outperformed by larger models, it remains a widely used reference point.

## GEITje Family

<strong>GEITje</strong> (Rijgersberg, Vanroy) is a family of Dutch LLMs based on Mistral 7B, continued-pretrained on Dutch corpora (GigaCorpusNL, MADLAD-400). Variants include:

- <strong>GEITje-7B</strong> — Base Dutch model
- <strong>GEITje-7B-chat / chat-v2</strong> — Instruction-tuned versions
- <strong>GEITje 7B Ultra</strong> — First preference-optimized Dutch LLM, using SFT + preference optimization

[Repository](https://github.com/Rijgersberg/GEITje) · [GEITje Ultra Paper](https://arxiv.org/html/2412.04092v1)

## Fietje

<strong>Fietje</strong> (Beersmans et al., 2025) is a family of small language models specifically designed for Dutch, based on Phi-2 (2.7B parameters). Despite its small size, Fietje demonstrated competitive results with larger models at time of release. It is fully open-source: weights, datasets, training, and evaluation code are all publicly accessible. Its instruction-tuned and chat variants (Fietje 2B Chat) showed substantial improvements, outperforming larger 7B models like GEITje and Tweety on multiple benchmarks.

[Paper (CLIN Journal, 2025)](https://www.clinjournal.org/clinj/article/view/213)

# Leaderboards and Evaluation Infrastructure

## Dutch LM Evaluation Harness

A fork of EleutherAI's LM Evaluation Harness with support for Dutch evaluation benchmarks (e.g., SQuAD-NL) and Dutch prompts. Can evaluate models loaded via transformers, vLLM, commercial APIs, and PEFT adapters.

[Repository](https://github.com/iPieter/dutch-lm-evaluation-harness)

## ITHAX NL Benchmark

<strong>ITHAX</strong> provides a practical AI benchmark for Dutch, testing models on language interpretation, in-context learning, programming, translation, and more. Based on 35+ questions across 9 categories, drawn from real client use cases. Includes models ranging from small to large, open to commercial.

[ITHAX NL Benchmark](https://www.ithax.ai/nl-benchmark/)

## European LLM Leaderboard

A collection of multilingual evaluation results using a fork of LM Evaluation Harness (OpenGPTX), based on version 1 of the HuggingFace Open LLM Leaderboard.

[Repository](https://github.com/OpenGPTX/lm-evaluation-harness)

## General-Purpose Leaderboards with Dutch Relevance

These platforms aggregate benchmarks and pricing data, including multilingual results:

| Platform | Description |
|----------|-------------|
| [BenchLM](https://benchlm.ai/) | 178 benchmarks, real pricing, runtime data. Includes [multilingual section](https://benchlm.ai/multilingual). |
| [Onyx LLM Leaderboard](https://onyx.app/llm-leaderboard) | General leaderboard with multilingual results. |
| [Artificial Analysis](https://artificialanalysis.ai/) | Cross-provider model comparison with pricing, speed, and quality metrics. |

# Hardware Context

<div class="info-box">

<strong>LLMfit</strong> is a terminal tool that right-sizes LLM models to your system's RAM, CPU, and GPU. It detects your hardware, scores each model across quality, speed, fit, and context dimensions, and tells you which ones will actually run well on your machine. The tool also enables community benchmarks across a range of hardware, providing intelligence on which models are most appropriate for common hardware specifications — relevant when deciding which Dutch models can run locally in educational settings.

[LLMfit](https://www.llmfit.org/)

</div>

# Summary: Notes for Practitioners

<div class="info-box">

<ul>
<li><strong>For broad NLU evaluation:</strong> DUMB (9 tasks, encoder-focused) or ScandEval (generative models, Germanic languages).</li>
<li><strong>For embedding quality:</strong> MTEB-NL (40 datasets, 7 task types).</li>
<li><strong>For grammatical knowledge:</strong> BLiMP-NL (8,400 minimal pairs, 22 phenomena) or ANS Challenge Set (prescriptive grammar).</li>
<li><strong>For information retrieval:</strong> BEIR-NL (14 datasets, zero-shot).</li>
<li><strong>For logical reasoning:</strong> SLR-Bench-Dutch (19,000+ tasks, 20 levels).</li>
<li><strong>For bias and fairness:</strong> DutchCrowS (stereotypes, 9 social groups) or MinBZK Social Bias Benchmark (hiring decisions).</li>
<li><strong>For finance:</strong> FinGEITje (Dutch financial domain evaluation).</li>
<li><strong>For reading time / psycholinguistics:</strong> Psychometric evaluation data (14 models, 3 eye-tracking corpora).</li>
<li><strong>For Dutch models:</strong> RobBERT-2023-large (best encoder), Fietje 2B Chat (best small model), GEITje 7B Ultra (best conversational).</li>
</ul>

</div>

---

<em>This page was generated by an AI assistant on <strong>28 July 2026</strong>. It synthesises publicly available sources including DUMB, MTEB-NL, BLiMP-NL, ScandEval, SQuAD-NL, SICK-NL, BEIR-NL, SLR-Bench-Dutch, DutchCrowS, the MinBZK Social Bias Benchmark, the ANS Challenge Set, FinGEITje, RobBERT, BERTje, GEITje, and Fietje publications, the Dutch LM Evaluation Harness, ITHAX, the European LLM Leaderboard, and BenchLM. Specific claims and scores should be verified against the primary sources.</em>
{:.muted-text}