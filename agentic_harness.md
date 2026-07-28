---
title: "Agentic Harness Benchmarks"
layout: default
nav_order: 11
---

<div class="info-box">

<strong>AI-generated report — July 2026.</strong> This page was produced by an AI assistant drawing on published benchmarks, blog posts, and repository documentation. It should be read as a <strong>secondary synthesis</strong>, not primary research. The landscape moves fast — check specific numbers against the original source before relying on them.

</div>

# Context

When someone uses a tool like Claude Code, OpenCode, Codex CLI, or Cursor Agent, they are not using a raw AI model on its own. They are using a <strong>harness</strong> — the surrounding software that wraps the model in a <strong>run loop</strong> (how it plans and executes steps), a set of <strong>tools</strong> (file editing, shell commands, search), <strong>permission rules</strong> (what actions are allowed), a way of <strong>managing context</strong> (what information fits in the model's limited window), and an <strong>output format</strong> (how changes are applied). The same model placed inside a different harness can produce noticeably different results in <em>correctness</em>, <em>cost</em>, and <em>speed</em>. Choosing the right harness for a task can matter more than picking one frontier model over another.

A growing family of benchmarks tries to measure how much the harness matters, separate from the model. This page summarises the most relevant ones in plain language.
{:.section-intro}

# Key Takeaways

<div class="step-section">

<span class="step-number">1</span> <strong class="color-accent-text">The harness matters as much as the model.</strong> The same model under different harnesses can swing in score by <strong>17–27 points</strong> — often <em>larger</em> than the gap between competing frontier models. A state-of-the-art model can look mediocre if wrapped in a poor harness, and a mid-tier model can punch above its weight with a well-designed scaffold. Researchers now treat the harness as a <strong>first-class variable</strong>, not a detail.

</div>

<div class="step-section">

<span class="step-number">2</span> <strong class="color-accent-text">When everyone solves the task, speed and cost decide.</strong> On straightforward tasks where all good harnesses succeed, <strong>efficiency becomes the differentiator</strong>. Wall-clock time can vary by <strong>4×</strong> and token cost by <strong>8×</strong> between harnesses running the same model. The fastest harness finishes in minutes while another takes nearly twenty — and API costs scale accordingly. For teams running agents at scale, this efficiency gap translates directly into <em>real budget differences</em>.

</div>

<div class="step-section">

<span class="step-number">3</span> <strong class="color-accent-text">Reliability is the hidden axis.</strong> A single successful run (pass@1) might look impressive, but it hides how often the agent <em>really</em> fails. The stricter <strong>pass^k</strong> metric — succeeding on <em>every</em> repeat — tells a different story. State-of-the-art agents that score 60%+ on a single attempt can drop <strong>below 25%</strong> when required to get it right eight times out of eight. In production, where users do not retry until it works, reliability is the metric that matters most.

</div>

<div class="step-section">

<span class="step-number">4</span> <strong class="color-accent-text">Benchmarks are not neutral.</strong> A reported score reflects <strong>the model <em>plus</em> the harness <em>plus</em> the scoring pipeline</strong> — not the model alone. A benchmark's native scaffold may favour certain models or tool-calling formats. One study showed that switching from a benchmark's own pipeline to a <em>uniform</em> scaffold <strong>reversed model rankings</strong> entirely. Always ask: "What scaffold produced this number?" before drawing conclusions.

</div>

<div class="step-section">

<span class="step-number">5</span> <strong class="color-accent-text">Infrastructure changes scores.</strong> Resource configuration alone — <em>CPU, memory, network, timeout settings</em> — can swing benchmark results by about <strong>6 points</strong> (p &lt; 0.01). Cold-start latency on serverless providers can shift latency-sensitive benchmarks by <strong>10–20%</strong>. A benchmark score is never purely about the agent; it is always about the <em>agent plus the infrastructure it runs on</em>.

</div>

<div class="step-section">

<span class="step-number">6</span> <strong class="color-accent-text">The field moves fast.</strong> Scores <strong>saturate</strong> (everyone hits the ceiling), benchmarks get <strong>contaminated</strong> (tasks leak into training data, inflating scores), and new variants appear <em>monthly</em>. The SWE-bench Verified leaderboard, once the gold standard, is now considered contaminated. Any snapshot — including this one — is temporary. Always check the publication date.

<span class="step-number">7</span> <strong class="color-accent-text">Using AI to track AI.</strong> The pace of change makes it economically impractical for humans to track every benchmark release manually. Hence this <em>auto-generated, human-in-the-loop</em> update document: AI compiles the landscape, a human reviews and decides what matters. Expect periodic refreshes as the field evolves.

</div>

# Plain-Language Glossary

<div class="info-box">

<ul>
<li><strong>Harness</strong> — the scaffolding around a model: tools, run loop, permissions, context handling, output format.</li>
<li><strong>Scaffold</strong> — often used interchangeably with harness; the supporting code and prompts that turn a model into an agent.</li>
<li><strong>pass@k</strong> — the task counts as solved if <em>at least one</em> of k attempts succeeds. Optimistic; flatters agents.</li>
<li><strong>pass^k</strong> — the task counts as solved only if <em>all</em> k attempts succeed. Strict; measures consistency.</li>
<li><strong>Pass@1</strong> — single-trial success rate. The most common headline number.</li>
<li><strong>Benchmaxxing</strong> — when a model or agent looks good because it is over-optimised for public benchmarks or has seen the answers in training data.</li>
<li><strong>Contamination</strong> — benchmark tasks leaking into a model's training data, inflating its score.</li>
</ul>

</div>

# The Benchmarks

## HarnessBench

HarnessBench compares <strong>Codex CLI</strong>, <strong>Claude Code CLI</strong>, and <strong>Cursor Agent CLI</strong> side-by-side on <strong>27 real debugging tasks</strong> drawn from 9 open-source repositories. Each task is scored by <strong>deterministic hidden tests</strong> (core tests for the required fix, regression tests for surrounding behaviour) — never by an AI judge. This avoids the "LLM-as-a-judge" problem where the grader itself can wobble.

The top condition was <strong>Codex / GPT-5.5 / xhigh at 22 out of 27 passes</strong>. Runtime differences were clearer than accuracy differences: the fastest Cursor configuration finished in a median of <strong>3.6 minutes</strong>, while the slowest Claude configuration took <strong>15.1 minutes</strong>. The author cautions that 27 tasks are <em>too few for statistically significant ranking claims</em>, but that harness differences are real and show up in <strong>exploration style</strong>, <strong>timeout handling</strong>, and <strong>caching behaviour</strong> — factors that rarely appear in model-only benchmarks.

<div class="info-box">

<strong>Note on fairness:</strong> Repository-local steering files (such as <code>AGENTS.md</code>, <code>CLAUDE.md</code>, <code>.codex</code>, <code>.claude</code>) are sanitised before each run to prevent the agent from being quietly steered toward a known answer.

</div>

[Repository](https://github.com/nyosegawa/harness-bench) · [Blog post](https://nyosegawa.com/en/posts/harness-bench/)

## Claw-SWE-Bench

Claw-SWE-Bench is a <strong>350-task multilingual benchmark</strong> with an adapter protocol that makes different agent harnesses (called <strong>"claws"</strong>) comparable under <em>fixed settings</em> — same prompt, same runtime budget, same workspace contract, same evaluator. It spans <strong>8 languages</strong> and <strong>43 repositories</strong>.

The key finding is remarkably clean: harness choice changes the score by <strong>27.4 percentage points</strong> under fixed models, while model choice changes it by <strong>29.4 points</strong> under fixed harness — harness and model are <em>nearly equal in effect size</em>. A minimal adapter (asking the model to write a unified diff directly) scores only <strong>19.1%</strong>, while a full adapter (letting the model edit repository files through tools and exporting the patch from Git state) reaches <strong>73.4%</strong> with the same model. The difference is not the model's coding ability — it is whether the output format matches what the scoring system expects.

[Paper](https://arxiv.org/abs/2606.12344) · [Repository](https://github.com/opensquilla/claw-swe-bench)

## OpenBench

OpenBench compares coding-agent harnesses — <strong>codex, pi, opencode, cursor, devin, and open-model claude</strong> — on self-contained coding tasks. Grading uses <strong>checker scripts</strong> (exit 0 = solved, optionally with <code>SCORE:</code> for partial credit), never the harness's own claim of success. This prevents the agent from declaring victory when it has not actually solved the task.

Its <strong>Track A</strong> pins <em>all</em> harnesses to the same canonical model (<code>gpt-5.5-medium</code>) so that any difference comes from the harness alone. Findings so far: <strong>correctness saturates</strong> for frontier harnesses on easier tasks — they all solve everything — so <strong>efficiency becomes the separator</strong>. Wall-clock spread reaches about <strong>4×</strong> and token cost up to about <strong>8×</strong>. The <code>pi</code> harness is repeatedly the fastest and leanest across panels. <strong>Open models are surprisingly close</strong> to frontier models: a 72-run open-model matrix cost about <strong>$1.02</strong> in total API spend, demonstrating that cost-effective evaluation is feasible.

[Repository](https://github.com/sbf-developer/openbench)

## SWE-bench Family

SWE-bench is the <strong>dominant coding-agent benchmark</strong> and the one most cited in model announcements. The agent receives a <strong>real GitHub issue</strong> and a repository checkout, produces a patch, and is scored by the <strong>repository's own test suite</strong>. No judge model, no rubric, no partial credit — either the tests pass or they do not. Variants include:
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

<strong>Key insight:</strong> Scores are a property of <strong>model + scaffold + harness</strong>, not the model alone. On <strong>SWE-bench Pro</strong>, a basic scaffold scores 23% while an optimised 250-turn scaffold scores 45%+ — a <strong>22-point swing</strong> from scaffolding alone, with no model change. On <strong>SWE-bench Mobile</strong>, the <em>same model</em> (Opus 4.5) achieves <strong>12% on Cursor</strong> but only <strong>2% on OpenCode</strong> — a <strong>6× gap</strong>. The best overall configuration across all agents and models scored only <strong>12%</strong>, revealing a large gap between current agent capabilities and the demands of industrial software development. Most failures came from <em>incomplete implementations</em>, not from misunderstanding the task.

</div>

[Leaderboards](https://www.swebench.com/) · [SWE-bench Mobile](https://arxiv.org/abs/2602.09540)

## Terminal-Bench

Terminal-Bench measures <strong>end-to-end terminal agent capability</strong>: compiling code, training ML models, configuring servers, reverse engineering binaries, and running scientific workflows. These are <em>open-ended, multi-step tasks</em> that require planning, error recovery, and environment awareness — not just editing a single file.

<div class="info-box">

<strong>Harness engineering proof point:</strong> LangChain improved from 52.8% to 66.5% (+13.7 points) by changing <em>only</em> the harness (system prompt, tool choice, execution flow) while keeping the model fixed. Anthropic also showed that infrastructure configuration alone swings scores by +6 points (p < 0.01).

</div>

Top scores (early 2026): GPT-5.3-Codex at 77.3%, Claude Code Opus 4.6 at 65.4%.

## TAU-bench / τ-bench

<strong>TAU-bench (τ-bench)</strong> evaluates <strong>tool-agent-user interaction</strong> in customer-service domains — retail, airline, and later telecom and banking/knowledge. The agent must follow a <strong>written policy document</strong> across a multi-turn conversation while using domain API tools (booking flights, processing refunds, checking policies). Grading compares the <strong>final database state</strong> to an annotated goal — the transcript quality is <em>irrelevant</em>. The agent cannot bluff its way to a pass with confident-sounding text; it must actually make the correct tool calls that change the database.

<div class="info-box">

<strong>The most important metric here is pass^k:</strong> the probability that <em>all</em> k independent attempts succeed. State-of-the-art agents drop below 25% at pass^8 in retail, even when single-run scores look healthy in the low-to-mid 60s. For production agents that must get it right every time, pass^k is the more honest signal.

</div>

τ²-bench (2025) adds a dual-control telecom domain where the user also holds tools. τ³-bench (2026) expands to voice full-duplex and knowledge retrieval.

[Repository](https://github.com/sierra-research/tau-bench) · [τ²-bench](https://github.com/sierra-research/tau2-bench) · [Leaderboard](https://taubench.com)

## AgentBench

<strong>AgentBench</strong> evaluates agents across <strong>eight distinct environments</strong>: OS shell, database SQL, knowledge graph queries, digital card game, household simulation, web shopping, web browsing, and lateral-thinking puzzles. It is the <strong>broadest major benchmark</strong> — a model that crushes coding benchmarks might fail at web navigation or creative reasoning. 2026 community scores: <strong>Claude Opus 4.7 ~73%</strong>, <strong>GPT-5.3 Codex ~70%</strong>.

<div class="info-box">

<strong>Caveat:</strong> Per-environment scores diverge by 30+ points — aggregate scores can mask zeros in individual environments. A 2026 study found all eight major agent benchmarks could be reward-hacked by automated scanning agents, so top scores warrant extra scrutiny.

</div>

[Repository](https://github.com/THUDM/AgentBench)

## OpenCode Harness

OpenCode Harness is a <strong>clean-room, model-agnostic</strong> harness for evaluating coding agents across providers — <strong>DeepSeek, Qwen, Claude, OpenAI, and local endpoints</strong> (vLLM, SGLang, Ollama). It standardises the agent loop, tool permissions, trace production, and eval reporting. Its first DeepSeek diagnostic benchmark (4 suites, 12 tasks) exposed <strong>concrete failure modes</strong>: marker-following drift (the agent stops tracking which files it has edited), tool-loop overrun (the agent repeats unsuccessful tool calls), long-context synthesis gaps (the agent loses track of earlier context), and repair finalisation gaps (the agent cannot finish fixing its own mistakes). Results are presented as <strong>diagnostic evidence</strong> rather than a leaderboard — the goal is to improve harness design, not to rank models.

[Repository](https://github.com/samarailly51-pixel/opencode-harness)

## Coder Eval

Coder Eval is an open-source framework that runs <strong>real agents</strong> (Claude Code, Codex, Gemini Antigravity) in a <strong>sandbox</strong> against declarative <strong>YAML tasks</strong>, then scores the files and commands they produced. It is designed for <strong>CI gates</strong> (fail the build on regressions), <strong>A/B experiments</strong> between agent configs (model vs. model, prompt vs. prompt, tool-on vs. tool-off), and <strong>skill trigger verification</strong> (did the agent actually use the skill?). Unlike fixed-dataset benchmarks that rank models on a shared leaderboard, Coder Eval scores <strong><em>your own tasks</em></strong> — the tasks, skills, and workflows you ship — with weighted 0.0–1.0 continuous criteria, per-tool cost telemetry, and a JUnit XML report for CI pipelines. It fills the gap between "research benchmark" and "production CI check".

[Repository](https://github.com/UiPath/coder_eval)

# Other Notable Benchmarks

<div class="info-box">

<ul>
<li><strong>ICAE-Bench</strong> — <strong>480 anonymised tasks</strong> across 12 programming languages. The agent receives a <em>deliberately fuzzy</em> Product Requirement Document and must clarify missing requirements with a <strong>hidden-spec Oracle</strong> (a user agent that knows the ground truth) before implementing. Four-part scoring: dynamic tests, structural similarity, critic review, and interaction quality. This tests whether agents can <em>ask clarifying questions</em> — a critical real-world skill.</li>
<li><strong>EvoCode-Bench</strong> — <strong>26 stateful coding tasks</strong> with <strong>5–15 rounds per task</strong>. Tests whether agents can keep a project working as user requirements change <em>cumulatively</em>. Later rounds inherit earlier implementation decisions, dependencies, file layouts, and API choices. Runs on the Harbor multi-step framework with per-step verifiers.</li>
<li><strong>LoCoBench-Agent</strong> — <strong>8,000 interactive scenarios</strong> across 10 languages and 36 domains, with context ranges from <strong>10K to 1M tokens</strong> and multi-turn evaluation up to 50 turns. Nine bias-free metrics rigorously validated to eliminate file count bias — including execution success rate, memory retention across turns, and cross-file consistency.</li>
<li><strong>OpenCode Bench</strong> (anomalyco) — <strong>Multi-judge evaluation</strong> across five dimensions (API signature compliance, logic equivalence, integration correctness, test coverage, project checks). Uses <strong>three independent LLM judges</strong> per submission with <strong>variance penalties</strong> for disagreement. Three isolated episodes per evaluation for statistical reliability.</li>
<li><strong>FeatureBench</strong> — Tests <strong>feature development</strong> rather than bug fixing. A revealing data point: <strong>Claude 4.5 Opus drops from 74.4% on SWE-bench to 11.0% on FeatureBench</strong>, showing that current scaffolds are far better at patching existing code than at building new functionality from scratch.</li>
</ul>

</div>

# Reliability Metrics in Plain Terms

| Metric | Definition | Meaning |
|--------|------------|---------|
| pass@k | At least 1 of k attempts succeeds | Optimistic; flatters agents |
| pass^k | All k attempts succeed | Strict; measures consistency |
| pass@1 | Single-trial success rate | Most common headline metric |
{:.contents-table}

<div class="info-box">

<strong>Why this matters:</strong> pass^k is the <strong>more production-relevant signal</strong> because it measures <em>consistency</em>, not peak capability. An agent that works 8 of 10 times independently has a pass^2 of <strong>64%</strong> and a pass^4 of <strong>41%</strong> — far below its pass@1 of 80%. In a workflow that needs the agent right <em>every time</em> — processing refunds, deploying code, responding to customers — the <strong>worst run governs the outcome</strong>, not the best. If you see only pass@1 in a vendor's report, ask for pass^k before trusting the number.

</div>

# Maintenance

This landscape changes <strong>rapidly</strong>. New benchmarks and updated scores appear <em>weekly</em>. The content of this report should be viewed as a <strong>snapshot from mid-2026</strong>, not a permanently current reference. Scores shift as models update, benchmarks evolve, and contamination accumulates. The SWE-bench Verified leaderboard that was the gold standard in 2024 is now considered contaminated — this will happen to today's benchmarks too. For <strong>live leaderboard data</strong>, consult the benchmark-specific sites linked above.

# Evolution

The pattern across all agentic harness benchmarks points toward a convergence on <strong>multi-axis evaluation</strong>: raw accuracy alone is <em>insufficient</em> to determine whether an agent is ready for real-world use. Future benchmarks increasingly pair correctness with <strong>cost accounting</strong> (dollars per task), <strong>latency measurement</strong> (time to completion), <strong>pass^k reliability</strong> (consistency across repeated runs), and <strong>policy adherence</strong> (did the agent follow the rules?). The <strong>harness — not the model — is the variable that separates production-ready from demo-ready</strong>: a well-designed harness makes a capable model reliable, while a poor one makes any model unpredictable.

---

<em>This report was generated by an AI assistant on <strong>28 July 2026</strong>. It synthesises publicly available sources including the HarnessBench blog and repository, Claw-SWE-Bench, OpenBench, SWE-bench documentation, τ-bench documentation, AgentBench, OpenCode Harness, Coder Eval, ICAE-Bench, EvoCode-Bench, LoCoBench-Agent, and survey articles from Rapid Claw, Prefactor, and others cited in the text. Verbatim claims should be checked against the primary sources before relying on them.</em>
{:.muted-text}