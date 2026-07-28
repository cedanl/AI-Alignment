---
title: "Workshop Materials"
layout: default
nav_order: 100
---

# Workshop Materials — AI Alignment

This directory holds the materials we use to run workshops on AI alignment, benchmarking, and the evaluation of AI systems against educational values. The materials are produced under the CEDA project and aimed at the Dutch education community — from teachers and school leaders to data and policy professionals.

A workshop is not a lecture. It is a structured session in which participants build a shared vocabulary for talking about AI quality, then apply that vocabulary to real benchmark data. The goal is practical literacy: by the end, participants should be able to read a model scorecard, question what a benchmark measures, and connect those numbers to decisions in their own educational context.

## Who these workshops are for

The materials adapt to three audiences, and most sessions mix at least two:

- **Educators and school leaders** who need a working understanding of what AI benchmarks do and do not tell them about safe, fair use in classrooms.
- **Policy and governance staff** who write procurement or adoption guidance and must judge vendor claims against evidence.
- **Data and technical professionals** who want to reproduce, extend, or critique the underlying benchmarking pipeline.

Facilitators should pick the depth that fits the room. An introductory session spends most of its time on framing and reflection; a technical session opens the R Markdown sources and walks through the data pipeline.

## What participants take away

Each session is built around four concrete outcomes:

1. **A shared frame.** Participants can explain, in plain language, what AI alignment and benchmarking mean for education.
2. **Hands-on reading.** Participants can interpret a live benchmark dashboard and name at least one metric's limitation.
3. **A scoring habit.** Using the worksheet, participants practice turning observations into a structured scorecard rather than an impression.
4. **A next step.** Each group leaves with one insight or open question worth pursuing after the session.

## Workshop Usage Guide

A workshop typically moves through three phases: preparing the context and materials, facilitating engagement, and capturing outcomes for continued progress.
{:.section-intro}

Each session should be tailored to the audience — from introductory overviews for educators to deep-dive technical sessions for data professionals. Estimated timings assume a 60–90 minute slot unless otherwise noted.


<div class="step-section">

<span class="step-number">1</span> <strong class="color-accent-text">Preparation (before the session)</strong>

<ul>

<li>Review the materials listed in <a href="#contents">Contents</a> and select those relevant to your session and audience size (allow <strong>30 min</strong>).</li>

<li>Familiarise yourself with the <strong>AI Alignment project</strong> context by reading the <a href="https://cedanl.github.io/AI-Alignment">project README</a> and the <a href="https://cedanl.github.io/AI-Alignment/Dashboard/info_benchmarks.html">information dashboard</a>.</li>

<li>Prepare any technical setup: projector, printed handouts, live dashboard access. If using the live dashboards, test the URLs in advance.</li>

<li>For groups larger than 15, prepare breakout prompts and assign a facilitator per table.</li>

</ul>

</div>



<div class="step-section">

<span class="step-number">2</span> <strong class="color-accent-text">Facilitation (during the session)</strong>

<ul>

<li>Open with the <strong>AI Alignment</strong> framing (5–10 min): why benchmarking and scorecarding matter for responsible AI in education. Use the <a href="https://cedanl.github.io/AI-Alignment">project homepage</a> as a visual anchor.</li>

<li>Distribute or project the selected materials. Allow participants to explore individually (5 min) before group discussion.</li>

<li>Encourage participants to explore the <a href="https://cedanl.github.io/AI-Alignment/Dashboard/Live_Data_Story.html">Live Benchmarks Dashboard</a> for real-time data and reflect on what the metrics mean for their context.</li>

<li>Close with a share-out (10–15 min): each group highlights one insight or open question.</li>

</ul>

</div>



<div class="step-section">

<span class="step-number">3</span> <strong class="color-accent-text">Follow-up (after the session)</strong>

<ul>

<li>Collect feedback and observations using a shared document or brief survey (allow <strong>5 min</strong> at session end).</li>

<li>Capture which materials resonated and any gaps identified — this feeds directly into the project's iterative development.</li>

<li>Refer participants to the project <a href="https://cedanl.github.io/AI-Alignment">homepage</a> for continued engagement and dashboard updates.</li>

<li>Share a summary email with links to the materials and dashboard within one week.</li>

</ul>

</div>


## Contents

| File | Description | Suggested Use |
|-----------------|----------------------------|---------------------------|
| [Background_Information](Background_Information.html) (.Rmd / .html) | Background context on **AI Alignment** — theory, frameworks, and key concepts for workshop facilitators and participants. | Distribute or project before the session as pre-reading. Use the paginated HTML for on-screen browsing; print selected pages for handouts. |
| [READING_LIST](READING_LIST.html) (.Rmd / .html) | Dynamic, searchable bibliography of 65+ publications on LLM benchmarking and evaluation, with expandable abstracts and DOI links to original papers. | Display during the session as a live reference. Encourage participants to filter by author/title and explore papers relevant to their context. |
| [worksheet](worksheet.docx) (.Rmd / .docx) | Workshop worksheet with blank tables for note-taking, scoring exercises, and group discussion prompts. | Print and distribute to participants at the start of the session. Editable DOCX can be adapted for different group sizes. |
| [references.bib](references.bib) | BibTeX database of 65 references on LLM benchmarking, shared by the R Markdown materials. | Used automatically by the .Rmd files. Update or extend to customise the reading list for specific workshop topics. |
{:.contents-table}


*Source .Rmd files can be opened and rendered in RStudio. Pre-rendered HTML and DOCX outputs are provided for immediate use.*
{:.info-box}


> *For questions or contributions, contact Alan Berg.*
{:.muted-text}
