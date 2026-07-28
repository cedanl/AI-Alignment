---
title: "Community Building"
layout: default
nav_order: 12
---

# Community Building

<div class="info-box">

<strong>AI-generated — July 2026.</strong> This page was produced by an AI assistant drawing on publicly available information about community initiatives in AI benchmarking, evaluation, safety, and alignment. Details should be checked against the primary sources.

</div>

# Context

This pilot program gauges the broader educational community's interest through a literacy and discussion effort centred on workshops. Example materials are available on this website and can be incrementally developed as workshops take place.

The challenge of AI benchmarking for education is too large and fast-moving for any single group to tackle alone. Fortunately, a diverse ecosystem of communities, coalitions, and organisations is already working on related problems — from standardising evaluation results to building domain-specific benchmarks for pedagogy and child safety.

Below is a catalogue of these communities, organised by focus area, with citations so readers can explore further.
{:.section-intro}

# Evaluation Infrastructure & Standards

These communities focus on the plumbing: how evaluation results are structured, shared, compared, and trusted.

## EvalEval Coalition

The <strong>EvalEval Coalition</strong> — hosted by <strong>Hugging Face, University of Edinburgh, and EleutherAI</strong> — is a cross-sector research coalition dedicated to improving the state of AI evaluations. It operates across three working groups: Research, Infrastructure, and Organisation.

The coalition's flagship project is <strong>EveryEvalEver</strong>, a standardised JSON schema for evaluation results and a community-crowdsourced repository hosted on Hugging Face. As of June 2026, it contains <strong>22,000+ model results across 2,200 benchmarks</strong>, translated from 31 different evaluation formats. Auto-converters exist for HELM, lm-eval-harness, and Inspect AI. A companion project, <strong>Evaluation Cards</strong>, provides a live interpretive layer over 100,000+ reported evaluation results, with signals for reproducibility, completeness, provenance, and comparability.

[EvalEval on HuggingFace](https://huggingface.co/evaleval) · [EveryEvalEver](https://evalevalai.com/projects/every-eval-ever/) · [Evaluation Cards](https://evalcards.evalevalai.com/) · [Paper (arXiv)](https://arxiv.org/pdf/2606.14516)

## MLCommons

<strong>MLCommons</strong> is an open engineering consortium with <strong>125+ members</strong> including startups, leading companies, academics, and non-profits. It is the world leader in building AI benchmarks through collaborative engineering.

Relevant working groups include:

- <strong>AI Risk & Reliability (AIRR)</strong> — develops safety tests and benchmarks for AI, with workstreams for agentic safety, multimodal safety, security, and scaling/analytics.
- <strong>Science Working Group</strong> — curates a YAML-based catalogue of scientific AI benchmarks with FAIR scores, automated CI validation, and published outputs.
- <strong>Datasets Working Group</strong> — maintains <strong>Croissant</strong>, the open metadata standard for ML datasets.

[MLCommons](https://mlcommons.org/) · [Get Involved](https://mlcommons.org/get-involved/) · [AIRR Working Group](https://mlcommons.org/working-groups/ai-risk-reliability/) · [Science Benchmarks](https://github.com/mlcommons-science/benchmark)

## AI Alliance — Trust & Safety Evaluation Initiative

The <strong>AI Alliance's Trust and Safety Evaluation Initiative (TSEI)</strong> includes the <strong>"Evaluation Is for Everyone"</strong> project, which aims to educate developers about AI trust and safety evaluations, build evaluation taxonomies, provide useful leaderboards, and maintain an Evaluation Reference Stack. Companion projects include <strong>Testing Generative AI Applications</strong> and the <strong>Evaluation Reference Stack</strong>.

The Alliance also launched <strong>Project Tapestry</strong>, an open-source platform for globally federated development of frontier open models, with an Evaluation Certification work group defining the evidence required for claims of capability, sovereignty, and safety.

[Evaluation Is for Everyone](https://the-ai-alliance.github.io/trust-safety-evals/) · [Project Tapestry](https://the-ai-alliance.github.io/tapestry/) · [AI Alliance](https://the-ai-alliance.org/)

## Benchlist — Cryptographically Signed Scores

<strong>Benchlist</strong> tackles the trust problem in benchmark reporting. Every score on Benchlist is a <strong>fresh re-run</strong> of a public benchmark, <strong>cryptographically signed</strong> (Ed25519), with confidence intervals shown inline and contamination flagged. Anyone can pay $0.50 to challenge any number, triggering an independent re-run by a different attestor. Disagreements are public. Scores can optionally be anchored to Ethereum via Aligned Layer.

[Benchlist](https://benchlist.ai/)

## peerBench

<strong>peerBench</strong> is an open-source, non-profit community implementation of a NeurIPS paper on benchmark quality. The community collaborates on creating prompts, reviewing submissions, and improving the quality of AI benchmarking.

[peerBench](https://peerbench.ai/)

## TraceVerse Community

<strong>TraceVerse Community</strong> is an open evaluation and observability ecosystem built on Hugging Face Hub. It hosts datasets, traces, and benchmarking pipelines to measure cost, latency, and quality across models using production-like workflows. Projects include <strong>SmolTrace</strong> (public benchmark + leaderboard), <strong>genai-otel-instrument</strong> (one-line OpenTelemetry instrumentation), and <strong>TraceMind</strong> (hosted trace viewer). The community maintains 311 eval tasks across travel, ecommerce, healthcare, finance, education, and other domains.

[TraceVerse on HuggingFace](https://huggingface.co/traceverse-community)

# Education-Focused Communities

These groups are specifically working on AI evaluation and benchmarking in educational contexts.

## AI-for-Education.org / Fab AI

<strong>AI-for-Education.org</strong>, in collaboration with <strong>Fab AI</strong>, has developed the <strong>Pedagogy Benchmark</strong> — the world's first benchmark testing whether LLMs can pass teacher exams (based on Chilean Ministry of Education questions). They also built the <strong>Visual Reasoning Benchmark</strong> for primary school visual mathematics and are working on a <strong>Special Educational Needs and Disabilities (SEND) pedagogy benchmark</strong>. Results are published on a public Education Leaderboard.

[Pedagogy Benchmark Leaderboard](https://benchmarks.ai-for-education.org/) · [About the Benchmarks](https://www.fab-ai.org/initiatives/ai-for-education/edtech-quality/benchmarks/about)

## EdTech Hub AI Observatory & Action Lab

The <strong>AI Observatory & Action Lab</strong> (supported by FCDO) scans AI trends in education, tests real-world applications, and provides tailored guidance for decision-makers in low- and middle-income countries. A dedicated workstream on <strong>AI Tool Benchmarking</strong> assesses foundational AI models against education criteria such as pedagogical standards and support for special educational needs.

[Observatory](https://edtechhub.org/ai-observatory/) · [Learning Briefs](https://edtechhub.org/ai-observatory-learning-brief-series/) · [Tools Portal](https://ai.edtechhub.org/en)

## UNESCO Observatory on AI in Education

The <strong>UNESCO Observatory on AI in Education for Latin America and the Caribbean</strong> brings together <strong>33 Ministries of Education</strong>, universities, research centres, and technology partners. It operates on the principle that "AI cannot govern education; education must govern AI." Its lines of action include evidence generation, ethical framework development, teacher training, and pilot initiatives.

[Announcement](https://www.unesco.org/en/articles/observatory-artificial-intelligence-education-latin-america-and-caribbean)

## Global AI Observatory (Society & AI)

The <strong>Global AI Observatory</strong> tracks how governments integrate AI into K-12 and higher education across <strong>56 nations</strong>. Each country profile documents official initiative names, issuing bodies, policy types, and direct links to primary source government documents.

[Observatory](https://societyandai.org/research/observatory/)

## Weval — Evidence-Based AI Evaluation for Education

<strong>Weval</strong> is an open platform for building qualitative evaluations, with a community of <strong>1,000+ contributors</strong>. It includes an <strong>Evidence-Based AI Evaluation</strong> blueprint that tests AI tutoring and teaching capabilities against evidence-based pedagogical practices from global education research — operationalising Rosenshine's principles, Cognitive Load Theory, Socratic dialogue, and other established frameworks into testable criteria.

[Weval](https://weval.org/)

## KORA Benchmark — AI Child Safety

<strong>KORA</strong> builds the first non-profit, independent, and open-source benchmark for AI child safety. It measures how today's AI systems behave with children against <strong>26 child-specific risks</strong>, and publishes everything openly. It includes a <strong>Models benchmark</strong> (safety scores for frontier AI models) and an <strong>Apps benchmark</strong> (end-to-end evaluation of consumer AI apps as a child would use them).

[KORA Benchmark](https://korabench.ai/)

## Aspen Digital — Community-Aligned AI Benchmarks

<strong>Aspen Digital</strong> is putting public input into the driver's seat for AI benchmark design. Starting with food security, they convene subject matter experts, community leaders, and ML researchers to identify concrete challenges and produce benchmarks that reflect what the public actually wants from AI.

[Community-Aligned AI Benchmarks](https://www.aspendigital.org/project/ai-benchmarks/)

# AI Safety & Alignment Communities

These organisations focus on the broader challenge of ensuring AI systems are safe, aligned, and trustworthy. Their work on evaluation methodologies and benchmark design is directly relevant to education-focused efforts.

## Center for AI Safety (CAIS)

<strong>CAIS</strong> conducts technical AI safety research, builds the field through educational programmes, and advocates for safety standards. Relevant evaluation work includes the <strong>MASK Benchmark</strong> (disentangling honesty from accuracy) and <strong>AgentHarm</strong> (measuring harmfulness in agentic systems).

[CAIS](https://safe.ai/)

## FAR.AI — Frontier Alignment Research

<strong>FAR.AI</strong> is a research and education non-profit focusing on ensuring advanced AI is safe and beneficial. It hosts the <strong>Alignment Workshop</strong> series, <strong>ControlConf</strong> (dedicated to AI control techniques), and runs grantmaking and fellowship programmes.

[FAR.AI](https://www.far.ai/)

## Safe AI for Humanity Foundation

An independent non-profit dedicated to understanding, measuring, and mitigating risks from advanced AI systems. It develops <strong>evaluation harness concepts</strong> for jailbreak resistance, prompt injection, bias, safety refusal, and corrigibility — all published openly.

[Safe AI for Humanity](https://ai-4-h.org/)

## ValueAI

<strong>ValueAI</strong> builds open infrastructure for agent value-alignment: datasets, model artifacts, training recipes, alignment algorithms, and evaluation workflows with clear provenance. The focus is on agent behaviour — goals, tool use, delegation, memory, safety boundaries, and fidelity to human intent.

[ValueAI](https://valuealigned.ai/)

## Stanford AI Alignment (SAIA)

<strong>SAIA</strong> is a Stanford Existential Risks Initiative research community focused on building the AI safety community at Stanford, conducting research, and accelerating students into impactful careers in AI safety.

[SAIA](https://stanfordaialignment.org/)

# AI Safety Education & Capacity Building

These organisations train the next generation of researchers and practitioners who will design, run, and interpret AI evaluations — including those relevant to education.

## Kairos Project / SPAR

<strong>Kairos</strong> is a non-profit focused on accelerating talent into AI safety and policy. Its <strong>SPAR</strong> research fellowship matches aspiring researchers with experts — its Spring 2026 round featured 137 projects and 427 mentees. Research conducted through SPAR has been accepted at ICML and NeurIPS.

[Kairos Project](https://kairos-project.org/)

## ARENA

<strong>ARENA</strong> provides in-person AI safety bootcamps in London, equipping participants with the skills, community, and confidence to contribute to technical AI safety. Programmes run 2-3 times per year, each lasting 4-5 weeks.

[ARENA](https://www.arena.education/)

## AI Safety Foundations

<strong>AI Safety Foundations</strong> makes complex AI safety concepts understandable for high school and undergraduate students, covering the alignment problem, current challenges in deployed systems, and pathways to contribute to the field.

[AI Safety Foundations](https://aisafetyedu.org/)

## Lens Academy

<strong>Lens Academy</strong> is a non-profit AI safety education platform offering structured introductions, guided group discussions, and AI-tutor-supported courses on the risks of advanced AI and what to do about them.

[Lens Academy](https://lensacademy.org/)

# How to Use This List

This catalogue serves several purposes for the community-building pilot:

- <strong>Identify potential partners</strong> — Several communities above (particularly EdTech Hub, AI-for-Education.org, and Weval) are working directly on education AI benchmarking and may welcome collaboration.
- <strong>Learn from existing models</strong> — The EvalEval Coalition's standardised JSON schema, MLCommons' PR-based contribution model, and Benchlist's cryptographic attestation all offer design patterns applicable to education benchmarks.
- <strong>Avoid duplication</strong> — Before building new evaluation infrastructure, check whether EveryEvalEver's schema or Evaluation Cards' interpretive layer can be extended rather than reimplemented.
- <strong>Find expertise</strong> — The AI safety and alignment communities listed above include researchers with deep experience in evaluation methodology, benchmark design, and human-AI interaction.

# Get Involved

If you have questions about any of the communities listed above, have contacts to suggest, or wish to run a workshop exploring how these efforts relate to AI alignment in education, please reach out.

---

<em>This page was generated by an AI assistant on <strong>28 July 2026</strong>. It synthesises publicly available sources including the EvalEval Coalition, MLCommons, the AI Alliance, HuggingFace Community Evals, Benchlist, peerBench, TraceVerse, AI-for-Education.org, the EdTech Hub AI Observatory, UNESCO, Society & AI, Weval, KORA, Aspen Digital, CAIS, FAR.AI, Safe AI for Humanity, ValueAI, SAIA, Kairos, ARENA, AI Safety Foundations, and Lens Academy. Details should be verified against the primary sources.</em>
{:.muted-text}