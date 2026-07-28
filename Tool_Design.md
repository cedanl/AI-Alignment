---
title: "Designing a Tool"
layout: default
nav_order: 10
---

<div class="info-box">

<strong>AI-generated — July 2026.</strong> This page synthesises publicly available sources on community-driven benchmark collection, evaluation harnesses, and AI observatory initiatives. It should be read as a secondary synthesis, not primary research.

</div>

# Context

A central challenge for AI benchmarking in education is that the landscape moves faster than any single institution can track. New models, benchmarks, and scoring methodologies appear weekly. Scores saturate, benchmarks become contaminated, and yesterday's leaderboard is today's historical artefact.

This page explores the infrastructural and community requirements for building a sustainable tool that gathers benchmarks, stores historical data, and generates accessible dashboards for the education community.
{:.section-intro}

# Key Takeaways

<div class="step-section">

<span class="step-number">1</span> <strong class="color-accent-text">Automated pipelines exist and are proven.</strong> Projects like <strong>MLCommons Science</strong> (YAML-driven benchmark catalog with CI validation), <strong>HuggingFace Community Evals</strong> (PR-based .eval_results/ format), and <strong>EveryEvalEver</strong> (22,000+ model results across 2,200 benchmarks) demonstrate that community-driven benchmark collection is technically feasible today.

</div>

<div class="step-section">

<span class="step-number">2</span> <strong class="color-accent-text">Standardisation is the bottleneck.</strong> EveryEvalEver found that its database ingested results from <strong>31 different evaluation formats</strong> and had to translate each one. A common JSON schema for benchmark metadata — modelled after Croissant (MLCommons) — is essential for interoperability.

</div>

<div class="step-section">

<span class="step-number">3</span> <strong class="color-accent-text">Education-specific benchmarks are emerging but sparse.</strong> The <strong>AI-for-Education.org Pedagogy Benchmark</strong> and the <strong>UNESCO AI Observatory for Latin America</strong> are early efforts. However, most education stakeholders rely on general-purpose benchmarks (MMLU, GSM8K, SWE-bench) that were not designed for pedagogical evaluation.

</div>

<div class="step-section">

<span class="step-number">4</span> <strong class="color-accent-text">AI observatories are an emerging governance model.</strong> The <strong>EdTech Hub AI Observatory & Action Lab</strong>, the <strong>UNESCO Observatory on AI in Education</strong>, and the <strong>Global AI Observatory (Society & AI)</strong> represent different approaches to the same need: centralised, evidence-based tracking of AI's impact on education. An education benchmarking tool would naturally complement these efforts.

</div>

<div class="step-section">

<span class="step-number">5</span> <strong class="color-accent-text">Maintenance cost is the unsolved problem.</strong> EveryEvalEver estimates it would cost <strong>$370,000</strong> to rerun the evaluations in its database. The MLCommons Science catalogue uses automated CI checks but still requires human maintainers. A sustainable model likely requires <strong>institutional backing</strong> — from a university, a foundation, or an intergovernmental organisation.

</div>

# How Other Projects Do It

Several existing projects demonstrate viable patterns for community-driven benchmark collection. Each offers lessons for an education-focused tool.

## MLCommons Science Working Group — YAML Benchmark Catalogue

The MLCommons Science Working Group maintains a <strong>versioned YAML catalogue</strong> of scientific AI benchmarks. Each benchmark entry includes citations, FAIR (Findable, Accessible, Interoperable, Reusable) scores, and ratings. A <strong>Python toolchain</strong> validates entries, runs URL checks, and generates Markdown, LaTeX, and MkDocs outputs. Contributions are submitted via <strong>pull request</strong> and reviewed by maintainers before publication.

[Repository](https://github.com/mlcommons-science/benchmark) · [Paper](https://mlcommons-science.github.io/benchmark/benchmarks.pdf)

<div class="info-box">

<strong>Relevant pattern:</strong> A YAML-based, PR-driven catalogue with automated validation checks (`make check`, `make check_url`) ensures data quality without requiring manual curation of every entry.

</div>

## EveryEvalEver — Crowdsourced Benchmark Results Database

EveryEvalEver, led by researchers at <strong>IBM, Hugging Face, and Technical University of Munich</strong>, collects evaluation results into a <strong>standardised JSON format</strong> with four metadata blocks: source provenance, model information, generation configuration, and metric semantics. The database already contains <strong>22,000+ model results across 2,200 benchmarks</strong>, translated from 31 different evaluation formats. Auto-translation tools exist for <strong>HELM, lm-eval-harness, and Inspect AI</strong>. Each submission receives a unique ID and cannot be deleted — conflicting results remain visible in the metadata.

<div class="info-box">

<strong>Relevant pattern:</strong> A standardised JSON schema plus auto-translation from popular harnesses lowers the barrier to contribution. Immutable submission IDs and transparent conflict handling build trust.

</div>

[Website](https://evalevalai.com/projects/every-eval-ever/) · [Paper](https://arxiv.org/pdf/2606.14516) · [Database on HuggingFace](https://huggingface.co/datasets/evaleval/EEE_datastore)

## HuggingFace Community Evals — PR-Based Model Results

HuggingFace's Community Evals project adds structured evaluation results to model repositories using the <strong>.eval_results/ YAML format</strong>. Anyone can submit results via <strong>pull request</strong>, and results appear on both model pages and benchmark leaderboards. It supports extraction from model cards, the Artificial Analysis API, and HuggingFace Papers. A Claude Code skill exists for automated evaluation management.

[Repository](https://github.com/huggingface/community-evals) · [Benchmark Tracker](https://github.com/huggingface/community-evals/blob/main/BENCHMARK_TRACKER.md)

<div class="info-box">

<strong>Relevant pattern:</strong> Tying evaluation results directly to model repositories (rather than a separate database) makes them visible where users already look. A skill-based automation layer reduces manual effort.

</div>

## EleutherAI LM Evaluation Harness — The De Facto Standard

The <strong>LM Evaluation Harness</strong> is the most widely used framework for standardised LLM evaluation. It supports <strong>60+ academic benchmarks</strong> with hundreds of subtasks, local and API-based models, publicly available prompts for reproducibility, and a YAML-based task configuration system. It serves as the backend for HuggingFace's <strong>Open LLM Leaderboard</strong> and has been used in hundreds of published papers and by organisations including NVIDIA, Google, and Mosaic ML.

<div class="info-box">

<strong>Relevant pattern:</strong> A YAML task definition format, publicly verifiable prompts, and standardised output logging create a reproducible evaluation pipeline. The framework's integration with HuggingFace Hub for results publication demonstrates a viable open-data model.

</div>

[Repository](https://github.com/EleutherAI/lm-evaluation-harness) · [Task Guide](https://github.com/EleutherAI/lm-evaluation-harness/blob/main/docs/task_guide.md) · [Integration Guide](https://huggingface.co/blog/Neo111x/integrating-benchmarks-into-lm-evaluation-harness)

## Measurement Data Bank (AIMS Foundation) — Psychometric Response Matrices

The Measurement Data Bank at Stanford's <strong>AIMS Foundation</strong> curates <strong>146 AI evaluation benchmarks</strong> as standardised `(subjects × items)` response matrices for Item Response Theory (IRT) and psychometric analysis. Each benchmark has a <strong>self-contained build.py</strong> that downloads raw data, builds the matrix, generates a heatmap, converts to a PyTorch payload, and uploads to HuggingFace Hub. The pipeline is fully reproducible and covers 92 ready benchmarks with per-item response data.

[Repository](https://github.com/aims-foundations/measurement-db)

<div class="info-box">

<strong>Relevant pattern:</strong> A self-contained build script per benchmark, a flat directory structure, and automated HuggingFace uploads create a reproducible, extensible data pipeline. The psychometric framing (IRT analysis) offers a richer analytical lens than raw accuracy scores.

</div>

## MoltBench — Crowdsourced Benchmarks Built by AI Agents

MoltBench is an <strong>executable benchmark built by AI agents, for AI agents</strong>. Agents submit tasks, a different AI agent peer-reviews each submission through blind adversarial testing (three adversarial tests per submission), and accepted tasks are merged. The review process is <strong>fully deterministic</strong> — no LLM-as-a-judge — using file content, exit codes, and JSON structure checks. Tasks trace back to real agent behaviours observed on the MoltBook platform (770,000+ autonomous LLM agent interactions).

[Repository](https://github.com/moltbench/moltbench)

<div class="info-box">

<strong>Relevant pattern:</strong> A fully autonomous task submission and peer-review pipeline, with deterministic grading and provenance from real-world agent interactions. Offers a model for scaling benchmark creation beyond human capacity.

</div>

# AI Observatories — Governance Models for Education

Several observatory initiatives provide institutional frameworks that an education benchmarking tool could complement or contribute to.

## EdTech Hub AI Observatory & Action Lab

The <strong>AI Observatory & Action Lab</strong> (supported by FCDO) scans AI trends in education, tests real-world applications, and provides tailored guidance for decision-makers in low- and middle-income countries. The Observatory produces weekly "signals" — curated observations of AI-in-education developments — while the Action Lab runs pilots and engagements directly with governments. A dedicated workstream on <strong>AI Tool Benchmarking</strong> assesses foundational AI models against education criteria such as pedagogical standards and support for special educational needs.

[Observatory Page](https://edtechhub.org/ai-observatory/) · [Learning Brief Series](https://edtechhub.org/ai-observatory-learning-brief-series/) · [Tools Portal](https://ai.edtechhub.org/en)

<div class="info-box">

<strong>Relevance to this project:</strong> The EdTech Hub's AI Tool Benchmarking workstream is the closest existing initiative to an education-focused AI benchmark tool. Collaboration or data-sharing with this initiative would provide immediate real-world grounding.

</div>

## UNESCO Observatory on AI in Education for Latin America and the Caribbean

The <strong>UNESCO Observatory</strong> is the first regional platform anchored in the UN system dedicated to AI in education. It brings together <strong>33 Ministries of Education</strong>, universities, research centres, and technology partners. Its lines of action include evidence generation, ethical and regulatory framework development, teacher training, and pilot initiatives. The Observatory operates on the principle that "AI cannot govern education; education must govern AI."

[Announcement](https://www.unesco.org/en/articles/observatory-artificial-intelligence-education-latin-america-and-caribbean)

## Global AI Observatory (Society & AI)

The <strong>Global AI Observatory</strong> tracks how governments integrate AI into K-12 and higher education across <strong>56 nations</strong>. Each country profile documents official initiative names, issuing bodies, policy types, and direct links to primary source documents. Data is sourced exclusively from official government publications and manually verified.

[Observatory Page](https://societyandai.org/research/observatory/)

## AI-for-Education.org Benchmarks

The <strong>AI-for-Education.org</strong> project, in collaboration with Fab AI and others, has developed the <strong>Pedagogy Benchmark</strong> — the world's first benchmark testing whether LLMs can pass teacher exams (based on Chilean Ministry of Education questions) — and the <strong>Visual Reasoning Benchmark</strong> for primary school visual mathematics. Results are published on a public <strong>Education Leaderboard</strong>.

[Pedagogy Benchmark Leaderboard](https://benchmarks.ai-for-education.org/) · [About the Benchmarks](https://www.fab-ai.org/initiatives/ai-for-education/edtech-quality/benchmarks/about)

# Proposed Tool Architecture

Drawing on the patterns above, a community-driven education AI benchmarking tool would likely include:

## Data Layer

- A <strong>YAML or JSON schema</strong> for benchmark metadata and results (following EveryEvalEver and MLCommons Science patterns)
- <strong>Versioned storage</strong> with immutable result IDs and transparent conflict handling
- <strong>Standardised response matrices</strong> enabling psychometric analysis (following the Measurement Data Bank pattern)

## Automation Layer

- <strong>GitHub Actions workflows</strong> for periodic data collection from live sources (Artificial Analysis, HuggingFace, Epoch AI)
- <strong>PR-based contribution model</strong> with automated validation checks (following HuggingFace Community Evals and MLCommons Science patterns)
- <strong>Auto-translation adapters</strong> from major evaluation harnesses (lm-eval-harness, HELM, Inspect AI)

## Presentation Layer

- <strong>Static dashboards</strong> generated from collected data (the current Jekyll + flexdashboard approach)
- <strong>Benchmark cards</strong> documenting what each benchmark measures, its limitations, and known contamination status (following the EvaluationCards pattern)
- <strong>Education-specific overlays</strong> mapping benchmark results to pedagogical criteria

## Governance Layer

- <strong>Open-source repository</strong> with documented contribution guidelines
- <strong>Transparent maintenance policy</strong> including deprecation of contaminated benchmarks
- <strong>Institutional partnership</strong> with an education-focused organisation for sustained resourcing

# Maintenance

Maintenance would need to be <strong>continuous</strong> due to the rapid progress of AI capabilities and model versions. Scores saturate, benchmarks become contaminated, and new variants appear monthly. The level of effort required would only be justified by a <strong>large-scale community process</strong>, perhaps through the administration of a central AI observatory dedicated to the education sector.

<div class="info-box">

<strong>Cost reality check:</strong> EveryEvalEver estimates it would cost <strong>$370,000</strong> to reproduce the aggregated results in its database — and that does not include agentic evaluations, reasoning model runs, or repeated trials, which are far more computationally intensive. An education-focused tool would need proportional resourcing.

</div>

In the meantime, the content of this website should be viewed as an <strong>experiment</strong> intended to inform and build literacy and interest. It demonstrates what is technically possible while acknowledging that sustainable operation requires institutional backing.

# Evolution

The convergence of several trends makes this an opportune moment for an education AI benchmarking tool:

1. <strong>Standardisation efforts are maturing.</strong> EveryEvalEver's JSON schema, MLCommons' Croissant format, and HuggingFace's .eval_results/ format provide interoperable foundations.

2. <strong>Education-specific benchmarks are emerging.</strong> The Pedagogy Benchmark, the AI-for-Education.org leaderboard, and the EdTech Hub's AI Tool Benchmarking workstream are early signals of demand.

3. <strong>AI observatories provide institutional homes.</strong> UNESCO, EdTech Hub, and Society & AI are building the governance infrastructure that a benchmarking tool could feed into.

4. <strong>The cost of evaluation is rising.</strong> Sharing and reusing prior results becomes more valuable as frontier model evaluations grow more expensive. EveryEvalEver's estimated $370,000 reproduction cost makes the case for open, reusable results databases.

Given the interest many have in this crucial area of Alignment, please <strong>reach out</strong> if you have interesting contacts, research, or wish to offer support.

---

<em>This page was generated by an AI assistant on <strong>28 July 2026</strong>. It synthesises publicly available sources including the MLCommons Science Working Group benchmark collection, EveryEvalEver, HuggingFace Community Evals, the EleutherAI LM Evaluation Harness, the AIMS Foundation Measurement Data Bank, MoltBench, the EdTech Hub AI Observatory & Action Lab, the UNESCO Observatory on AI in Education, the Global AI Observatory (Society & AI), and the AI-for-Education.org benchmarks. Verbatim claims and cost estimates should be checked against the primary sources.</em>
{:.muted-text}