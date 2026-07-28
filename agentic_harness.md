---
title: "Agentic Harness Benchmarks"
layout: default
nav_order: 11
---

<div class="info-box">

<strong>AI-generated report — July 2026.</strong> This page was produced by an AI assistant drawing on published benchmarks, blog posts, and repository documentation. It should be read as a secondary synthesis, not primary research. Check specific numbers against the original source before relying on them.

</div>

# Context

When someone uses a tool like Claude Code, OpenCode, Codex CLI, or Cursor Agent, they are not using a raw AI model on its own. They are using a **harness** — the surrounding software that wraps the model in a run loop, a set of tools, permission rules, a way of managing context, and an output format. The same model placed inside a different harness can produce noticeably different results in terms of correctness, cost, and speed.

A growing family of benchmarks tries to measure how much the harness matters, separate from the model. This page summarises the most relevant ones in plain language.
{:.section-intro}

# Key Takeaways

<div class="step-section">

<span class="step-number">1</span> <strong class="color-accent-text">The harness matters as much as the model.</strong> The same model under different harnesses can swing in score by 17–27 points — often larger than the gap between competing frontier models.

</div>

<div class="step-section">

<span class="step-number">2</span> <strong class="color-accent-text">When everyone solves the task, speed and cost decide.</strong> On easier tasks where all good harnesses succeed, wall-clock time and token cost can vary by 4–8×.

</div>

<div class="step-section">

<span class="step-number">3</span> <strong class="color-accent-text">Reliability is the hidden axis.</strong> A single successful run (pass@1) looks impressive but hides how often the agent fails. The stricter pass^k metric — succeeding on *every* repeat — can collapse even strong-looking agents below 25%.

</div>

<div class="step-section">

<span class="step-number">4</span> <strong class="color-accent-text">Benchmarks are not neutral.</strong> A reported score reflects the model *plus* the harness *plus* the scoring pipeline. Switching to a uniform scaffold can even reverse model rankings.

</div>

<div class="step-section">

<span class="step-number">5</span> <strong class="color-accent-text">Infrastructure changes scores.</strong> Resource configuration alone can swing benchmark results by about 6 points, and cold-start latency on serverless providers can shift latency-sensitive benchmarks by 10–20%.

</div>

<div class="step-section">

<span class="step-number">6</span> <strong class="color-accent-text">The field moves fast.</strong> Scores saturate, benchmarks get contaminated, and new variants appear monthly. Any snapshot is temporary.

<span class="step-number">7</span> <strong class="color-accent-text">Using AI to keep track of AI.</strong> Economically, it is better for AI to track these benchmarks and have a human review. Hence this auto generated, human in the loop update document.

</div>

# Plain-Language Glossary

<div class="info-box">

- **Harness** — the scaffolding around a model: tools, run loop, permissions, context handling, output format.
- **Scaffold** — often used interchangeably with harness; the supporting code and prompts that turn a model into an agent.
- **pass@k** — the task counts as solved if *at least one* of k attempts succeeds. Optimistic; flatters agents.
- **pass^k** — the task counts as solved only if *all* k attempts succeed. Strict; measures consistency.
- **Pass@1** — single-trial success rate. The most common headline number.
- **Benchmaxxing** — when a model or agent looks good because it is over-optimised for public benchmarks or has seen the answers in training data.
- **Contamination** — benchmark tasks leaking into a model's training data, inflating its score.

</div>

# The Benchmarks

## HarnessBench

HarnessBench compares Codex CLI, Claude Code CLI, and Cursor Agent CLI side-by-side on 27 real debugging tasks from 9 open-source repositories. Each task is scored by deterministic hidden tests — never by an AI judge.

The top condition was Codex / GPT-5.5 / xhigh at 22 out of 27 passes. Runtime differences were clearer than accuracy differences: the fastest Cursor configuration finished in a median of 3.6 minutes, while the slowest Claude configuration took 15.1 minutes. The author cautions that 27 tasks are too few for statistically significant ranking claims, but that harness differences are real and show up in exploration style, timeout handling, and caching.

<div class="info-box">

<strong>Note on fairness:</strong> Repository-local steering files (such as `AGENTS.md`, `CLAUDE.md`, `.codex`, `.claude`) are sanitised before each run to prevent the agent from being quietly steered toward a known answer.

</div>

[Repository](https://github.com/nyosegawa/harness-bench) · [Blog post](https://nyosegawa.com/en/posts/harness-bench/)

## Claw-SWE-Bench

Claw-SWE-Bench is a 350-task multilingual benchmark with an adapter protocol that makes different agent harnesses (called "claws") comparable under fixed settings, across 8 languages and 43 repositories.

The key finding: harness choice changes the score by 27.4 percentage points under fixed models, while model choice changes it by 29.4 points under fixed harness — harness and model are nearly equal in effect. A minimal adapter (asking the model to write a patch directly) scores only 19.1%, while a full adapter (letting the model edit files and exporting the patch from Git) reaches 73.4% with the same model.

[Paper](https://arxiv.org/abs/2606.12344) · [Repository](https://github.com/opensquilla/claw-swe-bench)

## OpenBench

OpenBench compares coding-agent harnesses — codex, pi, opencode, cursor, devin, and open-model claude — on self-contained coding tasks graded by checker scripts (exit 0 = solved, never the harness's own claim of success).

Its Track A pins all harnesses to the same model so differences come from the harness alone. Findings so far: correctness saturates for frontier harnesses on easier tasks; efficiency separates them instead, with wall-clock spread up to about 4× and token cost up to about 8×. The `pi` harness is repeatedly the fastest and leanest. Open models are surprisingly close to frontier models — a 72-run open-model matrix cost about $1.02 in API spend.

[Repository](https://github.com/sbf-developer/openbench)

## SWE-bench Family

SWE-bench is the dominant coding-agent benchmark. The agent receives a real GitHub issue and a repository checkout, produces a patch, and is scored by the repository's own test suite. Variants include:
{:.section-intro}

| Variant | Tasks | Notes |
|---------|-------|-------|
| SWE-bench Full | 2,294 | 12 Python repos, original set |
| Verified | 500 | Human-verified solvable (with OpenAI). Now considered contaminated |
| Lite | 300 | Filtered subset, faster eval |
| Multilingual | 300 | 9 languages |
| Pro | 1,865 | Enterprise-difficulty (Scale AI). Top ~23% vs 70%+ on Verified |
| Live | 50+ new/month | Continuously growing (Microsoft Research) |
| Mobile | Proprietary | iOS production codebase, multi-modal (PRD + Figma) |
{:.contents-table}

<div class="info-box">

<strong>Key insight:</strong> Scores are a property of **model + scaffold + harness**, not the model alone. On SWE-bench Pro, a basic scaffold scores 23% while an optimised 250-turn scaffold scores 45%+ — a 22-point swing from scaffolding alone. On SWE-bench Mobile, the same model (Opus 4.5) achieves 12% on Cursor but only 2% on OpenCode — a 6× gap. The best overall configuration scored only 12%, suggesting a large gap between current agent capabilities and industrial requirements.

</div>

[Leaderboards](https://www.swebench.com/) · [SWE-bench Mobile](https://arxiv.org/abs/2602.09540)

## Terminal-Bench

Terminal-Bench measures end-to-end terminal agent capability: compiling code, training ML models, configuring servers, reverse engineering, and scientific workflows.

<div class="info-box">

<strong>Harness engineering proof point:</strong> LangChain improved from 52.8% to 66.5% (+13.7 points) by changing *only* the harness (system prompt, tool choice, execution flow) while keeping the model fixed. Anthropic also showed that infrastructure configuration alone swings scores by +6 points (p < 0.01).

</div>

Top scores (early 2026): GPT-5.3-Codex at 77.3%, Claude Code Opus 4.6 at 65.4%.

## TAU-bench / τ-bench

TAU-bench evaluates tool-agent-user interaction in customer-service domains (retail, airline — later expanded to telecom and banking/knowledge). The agent must follow a written policy document across a multi-turn conversation while using domain API tools. Grading compares the final database state to an annotated goal — transcript quality is irrelevant.

<div class="info-box">

<strong>The most important metric here is pass^k:</strong> the probability that *all* k independent attempts succeed. State-of-the-art agents drop below 25% at pass^8 in retail, even when single-run scores look healthy in the low-to-mid 60s. For production agents that must get it right every time, pass^k is the more honest signal.

</div>

τ²-bench (2025) adds a dual-control telecom domain where the user also holds tools. τ³-bench (2026) expands to voice full-duplex and knowledge retrieval.

[Repository](https://github.com/sierra-research/tau-bench) · [τ²-bench](https://github.com/sierra-research/tau2-bench) · [Leaderboard](https://taubench.com)

## AgentBench

AgentBench evaluates agents across eight environments: OS shell, database SQL, knowledge graph queries, digital card game, household simulation, web shopping, web browsing, and lateral-thinking puzzles. It is the broadest major benchmark. 2026 community scores: Claude Opus 4.7 ~73%, GPT-5.3 Codex ~70%.

<div class="info-box">

<strong>Caveat:</strong> Per-environment scores diverge by 30+ points — aggregate scores can mask zeros in individual environments. A 2026 study found all eight major agent benchmarks could be reward-hacked by automated scanning agents, so top scores warrant extra scrutiny.

</div>

[Repository](https://github.com/THUDM/AgentBench)

## OpenCode Harness

OpenCode Harness is a clean-room, model-agnostic harness for evaluating coding agents across providers (DeepSeek, Qwen, Claude, OpenAI, local endpoints). It standardises the agent loop, tool permissions, trace production, and eval reporting. Its first DeepSeek diagnostic benchmark exposed concrete failure modes: marker-following drift, tool-loop overrun, long-context synthesis gaps, and repair finalisation gaps. Results are presented as diagnostic evidence rather than a leaderboard.

[Repository](https://github.com/samarailly51-pixel/opencode-harness)

## Coder Eval

Coder Eval is an open-source framework that runs real agents (Claude Code, Codex, Gemini Antigravity) in a sandbox against declarative YAML tasks, then scores the files and commands produced. It is designed for CI gates, A/B experiments between agent configs, and skill trigger verification. Unlike fixed-dataset benchmarks, it scores *your own tasks* with weighted 0.0–1.0 continuous criteria, per-tool cost telemetry, and a JUnit XML report for CI pipelines.

[Repository](https://github.com/UiPath/coder_eval)

# Other Notable Benchmarks

<div class="info-box">

- **ICAE-Bench** — 480 anonymised tasks across 12 languages. The agent receives a fuzzy product requirement document and must clarify missing requirements with a hidden-spec Oracle before implementing. Four-part scoring: dynamic tests, structural similarity, critic review, and interaction quality.

- **EvoCode-Bench** — 26 stateful coding tasks with 5–15 rounds per task. Tests whether agents can keep a project working as user requirements change cumulatively. Runs on the Harbor multi-step framework.

- **LoCoBench-Agent** — 8,000 interactive scenarios across 10 languages and 36 domains, 10K–1M token context range, multi-turn evaluation up to 50 turns. Nine bias-free metrics including execution success rate, memory retention, and cross-file consistency.

- **OpenCode Bench** (anomalyco) — Multi-judge evaluation across five dimensions (API signature, logic equivalence, integration, test coverage, checks). Three isolated episodes per evaluation, variance-penalised score aggregation.

- **FeatureBench** — Feature development rather than bug fixing. Claude 4.5 Opus drops from 74.4% on SWE-bench to 11.0% on FeatureBench, revealing scaffolding limitations on open-ended tasks.

</div>

# Reliability Metrics in Plain Terms

| Metric | Definition | Meaning |
|--------|------------|---------|
| pass@k | At least 1 of k attempts succeeds | Optimistic; flatters agents |
| pass^k | All k attempts succeed | Strict; measures consistency |
| pass@1 | Single-trial success rate | Most common headline metric |
{:.contents-table}

<div class="info-box">

<strong>Why this matters:</strong> pass^k is the more production-relevant signal. An agent that works 8 of 10 times independently has a pass^2 of 64% and a pass^4 of 41% — far below its pass@1 of 80%. In a workflow that needs the agent right every time, the worst run governs the outcome, not the best.

</div>

# Maintenance

This landscape changes rapidly. New benchmarks and updated scores appear weekly. The content of this report should be viewed as a snapshot from mid-2026, not a permanently current reference. Scores shift as models update, benchmarks evolve, and contamination accumulates. For live leaderboard data, consult the benchmark-specific sites linked above.

# Evolution

The pattern across all agentic harness benchmarks points toward a convergence on multi-axis evaluation: accuracy alone is insufficient. Future benchmarks increasingly pair correctness with cost accounting, latency measurement, pass^k reliability, and policy adherence. The harness — not the model — is the variable that separates production-ready from demo-ready.

---

*This report was generated by an AI assistant on 28 July 2026. It synthesises publicly available sources including the HarnessBench blog and repository, Claw-SWE-Bench, OpenBench, SWE-bench documentation, τ-bench documentation, AgentBench, OpenCode Harness, Coder Eval, ICAE-Bench, EvoCode-Bench, LoCoBench-Agent, and survey articles from Rapid Claw, Prefactor, and others cited in the text. Verbatim claims should be checked against the primary sources.*
{:.muted-text}