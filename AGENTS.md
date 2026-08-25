# AI-Alignment — AGENTS.md

## What this is

Jekyll site (GitHub Pages, `just-the-docs` theme) about AI benchmarking for education, run by CEDA. Content is a mix of Markdown, R Markdown (flexdashboard), R scripts, and static HTML dashboards.

## Directory structure

```
src/Live/                 # R pipeline: data gathering → exploration → dashboard
  UTIL.R                  # Shared helpers sourced by all pipeline scripts
  Gather.R                # Fetches live benchmark data from 7+ APIs
  Explore_Benchmarks.R    # Builds ggplot/plotly/ggiraph visualizations
  Live_Data_Story.Rmd     # flexdashboard that knits to Dashboard/Live_Data_Story.html
src/Workshop/Materials/   # Workshop .Rmd files and handouts
Dashboard/                # Pre-built HTML dashboards (committed outputs)
Evidence/evidence.csv     # Human-curated list of AI evidence sources
_includes/                # Jekyll includes (custom footer)
```

## Key commands

```sh
# Serve Jekyll locally (uses local theme, not remote)
bundle exec jekyll serve --config _config_local.yml

# Install R package dependencies
# Key packages: httr2, jsonlite, ggplot2, plotly, ggiraph, flexdashboard,
#   dplyr, tidyr, purrr, logger, kableExtra, htmltools, ggthemes, lubridate,
#   ggplotify, reticulate (for HuggingFace datasets)
```

## R data pipeline (run in order)

1. `src/Live/Gather.R` — fetches from Artificial Analysis, Epoch AI, Oolong Arena, Cisco, HuggingFace, LLM-Stats, OpenRouter
2. `src/Live/Explore_Benchmarks.R` — processes data, saves `artificial_results.Rdata`
3. `src/Live/Live_Data_Story.Rmd` — knits to `Dashboard/Live_Data_Story.html`

**Required env vars:** `DATA_DIR` (all scripts), `ACTI_KEY` (Gather.R only, for Artificial Analysis API)
**Optional env vars:** `HUGGING_READ` (HuggingFace token), `LLM_STATS` (LLM-Stats API key)

Per-source failures in `Gather.R` are non-fatal (script continues). Data-dir/auth failures are fatal.

## Dashboard outputs

- `Dashboard/Live_Data_Story.html` — flexdashboard with interactive plotly/ggiraph charts (knitted from Rmd)
- `Dashboard/info_benchmarks.html` — standalone HTML (pandoc-based, not R Markdown)

Both are pre-built and committed. Jekyll serves them as static assets from `Dashboard/`.

## Conventions

### Shared utilities (`UTIL.R`)

`src/Live/UTIL.R` contains all reusable helpers. **Never duplicate these** — always `source("UTIL.R")` at the top of each script:

| Helper | Purpose | Fatal? |
|---|---|---|
| `setup_logging()` | Init `logger` at given threshold | No |
| `stop_fatal(msg)` | Log FATAL + quit with status 1 | Yes |
| `validate_data_dir()` | Require `DATA_DIR` env var + dir exists | Yes |
| `validate_env_var(name)` | Require any non-empty env var | Yes |
| `save_rdata(obj, file)` | Save .Rdata; fatal on write failure | Yes |
| `load_safe(path)` | Load .Rdata; returns FALSE on failure | No |
| `with_logged_warnings(expr)` | Evaluate expr, log + muffle warnings | No |
| `non_fatal(prefix)` | Factory: `tryCatch(..., error = non_fatal("Source X"))` | No |
| `fatal(prefix)` | Factory: `tryCatch(..., error = fatal("Source X"))` | Yes |
| `show_error(title, detail)` | Render visible error card (Rmd only) | No |
| `get_result(results, key)` | Safe accessor for results list | No |
| `try_render(results, key, label)` | One-call panel render with error card | No |

### Error handling

- Use `non_fatal(prefix)` in `tryCatch` error handlers instead of inline `function(e) { log_error(...) }`.
- Use `fatal(prefix)` only when a source is required (e.g. Artificial Analysis in `Gather.R`, results save in `Explore_Benchmarks.R`).
- Per-source failures are non-fatal in both `Gather.R` and `Explore_Benchmarks.R` — the pipeline continues.
- `load_safe()` replaces the `tryCatch(load(...))` + existence-check pattern. Check its return value.

### Accessibility

- Every flexdashboard panel must use `try_render()` or the explicit `show_error()` pattern so failures produce visible error cards — never blank panels.
- Provide alt/fallback text for all plotly and ggiraph visualizations in the narrative text outside the chunk.
- Color is never the sole differentiator: charts distinguish data via position, shape, or labels in addition to color.
- `show_error()` uses a red (`#f8d7da`) background — pair with text (`#721c24`) that passes WCAG AA contrast (ratio > 4.5:1).
- For JAWS/NVDA compatibility, do not suppress inline CSS in Rmd panels; keep `self_contained: true` so styles are bundled.
- The "Read Aloud" button pattern in the intro panel uses `SpeechSynthesisUtterance` — test that it does not interfere with screen reader virtual cursor modes. Use `aria-live="polite"` on dynamic content regions.
- Use semantic heading hierarchy: panels should start at `###` and descend logically; do not skip levels.

### Readability & style

- Line width: **80 characters max** for code, 100 for comments.
- Indentation: **2 spaces**, no tabs.
- `tryCatch` blocks: open brace on same line as `tryCatch({`, closing `})` at the same indent as the opening call. Error handler on its own line.
- Name all arguments in `sprintf()` calls — positional arguments are fragile.
- Use `force(prefix)` in factory functions to ensure lazy evaluation captures the intended value.
- Keep functions short (under 30 lines). Extract helpers rather than nesting `tryCatch` more than 2 levels deep.
- Comments go **before** the code they explain, as full sentences, not inline at end of line.
- File-scoped constants and config at the top; data processing in the middle; save/output at the bottom.
- `library()` calls go inside `suppressPackageStartupMessages({})` at the top of each script.

### Visual & theme conventions

- Charts use `theme_solarized_2()` from `ggthemes` as the base theme.
- Interactive output: `plotly` (bar charts), `ggiraph` (scatter/point charts).
- flexdashboard uses bootswatch `flatly` theme with Inter + Montserrat fonts.
- Jekyll uses `just-the-docs` theme, light color scheme, search enabled.
- No CI/CD config (no `.github/` directory). Site deploys via GitHub Pages from the `main` branch.
