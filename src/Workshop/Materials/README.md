<style>
  .readme-content {
    font-family: system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    line-height: 1.6;
  }
  .info-box {
    border-left: 4px solid darkblue;
    background: #f0f4ff;
    padding: 1em 1.25em;
    border-radius: 4px;
    margin: 1em 0;
  }
  .info-box strong {
    color: darkblue;
  }
  .step-card {
    border-left: 4px solid darkblue;
    background: #f8faff;
    padding: 0.75em 1.25em;
    border-radius: 4px;
    margin: 1em 0;
  }
  .step-number {
    display: inline-block;
    background: darkblue;
    color: #fff;
    font-weight: 700;
    font-size: 0.85em;
    width: 1.8em;
    height: 1.8em;
    line-height: 1.8em;
    text-align: center;
    border-radius: 50%;
    margin-right: 0.5em;
  }
  .section-intro {
    font-style: italic;
    color: #333;
    padding: 0.5em 1em;
    border-left: 2px solid #8ab4f8;
    background: #f8faff;
    border-radius: 3px;
    margin: 0.5em 0 1.5em 0;
  }
  .contents-table th {
    background: darkblue;
    color: #fff;
    padding: 0.5em 1em;
    text-align: left;
  }
  .contents-table td {
    padding: 0.5em 1em;
    border-bottom: 1px solid #e0e7f0;
  }
  .contents-table tr:last-child td {
    border-bottom: none;
  }
</style>

<div class="readme-content">

# Workshop Materials — AI Alignment

This directory contains materials designed to support workshops on <span style="color: darkblue; font-weight: 500;">AI Alignment</span>, benchmarking, and the evaluation of AI systems against educational values. Materials are developed under the <span style="color: darkblue; font-weight: 500;">CEDA</span> project and are intended for use by the Dutch Education community.



## Workshop Usage Guide

A workshop typically moves through three phases: preparing the context and materials, facilitating engagement, and capturing outcomes for continued progress.

<div class="section-intro">
Each session should be tailored to the audience — from introductory overviews for educators to deep-dive technical sessions for data professionals. Estimated timings assume a 60–90 minute slot unless otherwise noted.
</div>

<div class="step-card">
<span class="step-number">1</span> <strong style="color: darkblue; font-size: 1.05em;">Preparation (before the session)</strong>
<br><br>
<ul style="margin: 0.25em 0 0 0; padding-left: 2.5em;">
  <li>Review the materials listed in <a href="#contents">Contents</a> and select those relevant to your session and audience size (allow <strong>30 min</strong>).</li>
  <li>Familiarise yourself with the <span style="color: darkblue; font-weight: 500;">AI Alignment Scorecards</span> project context by reading the <a href="/README.md">project README</a> and the <a href="/Dashboard/info_benchmarks.html">information dashboard</a>.</li>
  <li>Prepare any technical setup: projector, printed handouts, live dashboard access. If using the live dashboards, test the URLs in advance.</li>
  <li>For groups larger than 15, prepare breakout prompts and assign a facilitator per table.</li>
</ul>
</div>

<div class="step-card">
<span class="step-number">2</span> <strong style="color: darkblue; font-size: 1.05em;">Facilitation (during the session)</strong>
<br><br>
<ul style="margin: 0.25em 0 0 0; padding-left: 2.5em;">
  <li>Open with the <strong>AI Alignment</strong> framing (5–10 min): why benchmarking and scorecarding matter for responsible AI in education. Use the <a href="/index.md">project homepage</a> as a visual anchor.</li>
  <li>Distribute or project the selected materials. Allow participants to explore individually (5 min) before group discussion.</li>
  <li>Encourage participants to explore the <a href="/Dashboard/Live_Data_Story.html">Live Benchmarks Dashboard</a> for real-time data and reflect on what the metrics mean for their context.</li>
  <li>Close with a share-out (10–15 min): each group highlights one insight or open question.</li>
</ul>
</div>

<div class="step-card">
<span class="step-number">3</span> <strong style="color: darkblue; font-size: 1.05em;">Follow-up (after the session)</strong>
<br><br>
<ul style="margin: 0.25em 0 0 0; padding-left: 2.5em;">
  <li>Collect feedback and observations using a shared document or brief survey (allow <strong>5 min</strong> at session end).</li>
  <li>Capture which materials resonated and any gaps identified — this feeds directly into the project's iterative development.</li>
  <li>Refer participants to the project <a href="/">homepage</a> for continued engagement and dashboard updates.</li>
  <li>Share a summary email with links to the materials and dashboard within one week.</li>
</ul>
</div>




## Contents

<table class="contents-table">
<thead>
<tr><th>File</th><th>Description</th><th>Suggested Use</th></tr>
</thead>
<tbody>
<tr>
  <td><a href="Background_Information.html">Background_Information</a> (.Rmd / .html)</td>
  <td>Background context on <span style="color: darkblue; font-weight: 500;">AI Alignment</span> — theory, frameworks, and key concepts for workshop facilitators and participants.</td>
  <td>Distribute or project before the session as pre-reading. Use the paginated HTML for on-screen browsing; print selected pages for handouts.</td>
</tr>
<tr>
  <td><a href="READING_LIST.html">READING_LIST</a> (.Rmd / .html)</td>
  <td>Dynamic, searchable bibliography of 65+ publications on LLM benchmarking and evaluation, with expandable abstracts and DOI links to original papers.</td>
  <td>Display during the session as a live reference. Encourage participants to filter by author/title and explore papers relevant to their context.</td>
</tr>
<tr>
  <td><a href="worksheet.docx">worksheet</a> (.Rmd / .docx)</td>
  <td>Workshop worksheet with blank tables for note-taking, scoring exercises, and group discussion prompts.</td>
  <td>Print and distribute to participants at the start of the session. Editable DOCX can be adapted for different group sizes.</td>
</tr>
<tr>
  <td><a href="references.bib">references.bib</a></td>
  <td>BibTeX database of 65 references on LLM benchmarking, shared by the R Markdown materials.</td>
  <td>Used automatically by the .Rmd files. Update or extend to customise the reading list for specific workshop topics.</td>
</tr>
</tbody>
</table>

<p style="color: #555;"><em>Source .Rmd files can be opened and rendered in RStudio. Pre-rendered HTML and DOCX outputs are provided for immediate use.</em></p>





## <span style="color: darkblue;">Dashboards</span>

1.  [Live Benchmarks Dashboard](Dashboard/Live_Data_Story.html) - A dashboard that tracks the performance of AI models against various benchmarks.
1.  [Information Dashboard](Dashboard/info_benchmarks.html) - An information dashboard about AI Alignment. The menu option [Scorecard/Visualization](Dashboard/info_benchmarks.html#visualization) is a mockup of a potential community process.




## <span style="color: darkblue;">Acknowledgments</span>

<div class="info-box">
<strong>Acknowledgments</strong><br>
This work is part of the <span style="color: darkblue; font-weight: 500;">AI Alignment</span> project under <span style="color: darkblue; font-weight: 500;">CEDA</span>, supported by the Npuls LA team. The project builds on insights from the 2025 Npuls report on Generative AI in Dutch education, which identified benchmarking and scorecarding as essential steps toward responsible AI deployment.<br><br>
See the project-level <a href="/Acknowledgment.md">Acknowledgment</a> page for detailed credits and contributors.
</div>



<p style="color: #555;"><em>For questions or contributions, contact Alan Berg.</em></p>

</div>
