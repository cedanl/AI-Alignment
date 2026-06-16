# Explore live benchmark data
#
# Loads .Rdata files written by Gather.R, builds ggplot / girafe /
# plotly visualisations, and saves a named results list to
# artificial_results.Rdata for use by Live_Data_Story.Rmd.
#
# Required env var: DATA_DIR (directory written by Gather.R)
# Depends on: logger (install via pak::pak("logger"))

suppressPackageStartupMessages({
  library(ggplot2)
  library(plotly)
  library(stringr)
  library(dplyr)
  library(ggthemes)
  library(ggiraph)
  library(lubridate)
  library(tidyr)
  library(purrr)
  library(logger)
})

# ---------------------------------------------------------------------------
# Logging setup
# ---------------------------------------------------------------------------

log_threshold(INFO)

# stop_fatal: logs at FATAL then exits 1.
# Only used for DATA_DIR problems; per-section failures are non-fatal so
# the remaining sections and the final results save still run.
stop_fatal <- function(msg) {
  log_fatal(msg)
  quit(save = "no", status = 1, runLast = FALSE)
}

# ---------------------------------------------------------------------------
# Environment validation
# ---------------------------------------------------------------------------

data_dir <- Sys.getenv("DATA_DIR")

if (nchar(data_dir) == 0) stop_fatal("DATA_DIR is not set.")
if (!dir.exists(data_dir)) {
  stop_fatal(sprintf("DATA_DIR does not exist: %s", data_dir))
}

log_info(sprintf("Reading data from: %s", data_dir))

# ---------------------------------------------------------------------------
# Setup
# ---------------------------------------------------------------------------

subtitle <- paste0("Graph generated: ", Sys.Date())

# results accumulates all visualisations across all three sources.
# It is saved at the end regardless of how many sections succeeded,
# so Live_Data_Story.Rmd can render with partial data rather than crash.
results <- list()

# ---------------------------------------------------------------------------
# Section 1: Artificial Analysis
# ---------------------------------------------------------------------------
#
# If artificial.Rdata cannot be loaded the entire section is skipped via
# the outer tryCatch.  Within the section each chart and the metadata
# build each have their own tryCatch so a single failure does not prevent
# the remaining charts from being built.

log_info("Processing Artificial Analysis data...")

tryCatch({
  load(file.path(data_dir, "artificial.Rdata"))  # provides df_all

  # sapply collapses the list-column to a plain vector; length-0 entries
  # (models with no release date in the API) become NA rather than causing
  # a later as.Date() error.
  df_all$release_date <- sapply(
    df_all$release_date,
    function(x) if (length(x) == 0) NA else x[1]
  )
  df_all$release_date <- as.Date(df_all$release_date)

  log_info(sprintf(
    "Artificial Analysis: %d models loaded.", nrow(df_all)
  ))

  # --- 1a: Creators count chart -------------------------------------------

  tryCatch({
    creators_df        <- as.data.frame(table(df_all$model_creator.name))
    names(creators_df) <- c("Creator", "Count")
    d <- highlight_key(creators_df, ~Creator)

    p <- ggplot(
      d,
      aes(
        x    = reorder(Creator, Count),
        y    = Count,
        text = paste0(
          "Creator: ", Creator,
          "\nNumber of Models: ", Count
        )
      )
    ) +
      geom_col(fill = "darkblue") +
      scale_fill_gradient(low = "yellow", high = "darkblue") +
      labs(
        x     = "Org",
        y     = paste0("Number of Models\n", subtitle),
        title = "Creators of LLMs vs number of Models benchmarked\n"
      ) +
      coord_flip() +
      theme_solarized_2()

    results[["Artificial: Graphics - Creators Count"]] <- ggplotly(
      p,
      tooltip = "text"
    ) |>
      layout(hoverlabel = list(
        bgcolor     = "darkblue",
        font        = list(family = "Arial", size = 12, color = "white"),
        bordercolor = "black"
      )) |>
      highlight(
        on         = "plotly_hover",
        off        = "plotly_doubleclick",
        color      = "darkred",
        opacityDim = 0.5
      )

    log_info("Built: Creators Count chart")
  },
  error = function(e) {
    log_error(sprintf(
      "Creators Count chart failed (non-fatal): %s", conditionMessage(e)
    ))
  })

  # --- 1b: HLE Score vs Price scatter -------------------------------------

  tryCatch({
    df_scat <- df_all[df_all$pricing.price_1m_blended_3_to_1 > 0, ]
    df_scat <- df_scat[!is.na(df_scat$evaluations.hle), ]
    df_scat$evaluations.hle <- as.numeric(df_scat$evaluations.hle)

    p <- ggplot(
      df_scat,
      aes(
        y = evaluations.hle,
        x = pricing.price_1m_blended_3_to_1
      )
    ) +
      geom_point_interactive(aes(
        tooltip = slug,
        data_id = slug
      )) +
      xlim(0, 40) +
      theme_solarized_2() +
      labs(
        x        = "Price per 1M tokens (blended 3 to 1)",
        y        = "HLE Score",
        title    = "HLE Score vs Price for LLMs",
        subtitle = subtitle
      ) +
      geom_text(
        aes(
          x     = 40,
          y     = Inf,
          label = paste0(
            "    Some models may be overpriced relative",
            " \nto their performance on this benchmark"
          )
        ),
        hjust       = 1.05,
        vjust       = 1.5,
        inherit.aes = FALSE,
        color       = "darkblue",
        size        = 3.5,
        fontface    = "italic"
      )

    results[["Artificial: Graphics - Benchmark Example"]] <- girafe(
      ggobj   = p,
      options = list(opts_hover(css = "fill:darkblue;r:3pt;"))
    )

    log_info("Built: HLE vs Price scatter")
  },
  error = function(e) {
    log_error(sprintf(
      "HLE scatter failed (non-fatal): %s", conditionMessage(e)
    ))
  })

  # --- 1c: Benchmark metadata + normalised evaluations --------------------
  #
  # analytics_bench_df is static metadata describing each benchmark name,
  # its source URL, and a domain tag.  It is saved to disk here and also
  # used by section 1d to join descriptions onto the evaluation scores.
  # The inner tryCatch isolates metadata build failures from the chart-
  # build step so that a description typo cannot break the normalised chart.
  # 
  # Fragile: If the benchmark names in df_all change, then descriptions are not maintainable and should be dropped from the final presentation layer.

  tryCatch({
    benchmarks <- names(df_all) |>
      str_subset("^evaluations\\.") |>
      str_remove("^evaluations\\.")
    
    n_bench <- length(benchmarks)

    bench_url         <- character(n_bench)
    bench_description <- character(n_bench)
    bench_tags        <- character(n_bench)

    bench_url[1] <- paste0(
      "https://artificialanalysis.ai/evaluations/",
      "artificial-analysis-intelligence-index"
    )
    bench_description[1] <- paste0(
      "Artificial Analysis Intelligence Index combines performance",
      " across ten evaluations: GDPval-AA, t2-Bench Telecom,",
      " Terminal-Bench Hard, SciCode, AA-LCR, AA-Omniscience,",
      " IFBench, Humanity's Last Exam, GPQA Diamond, CritPt."
    )
    bench_tags[1] <- "AGI"

    bench_url[2]         <- bench_url[1]
    bench_description[2] <- bench_description[1]
    bench_tags[2]        <- "Coding"

    bench_url[3]         <- bench_url[1]
    bench_description[3] <- bench_description[1]
    bench_tags[3]        <- "Maths"

    bench_url[4]         <- "https://github.com/TIGER-AI-Lab/MMLU-Pro"
    bench_description[4] <- paste0(
      "MMLU-Pro: a more challenging and robust benchmark for language",
      " models across 12K complex questions in various disciplines."
    )
    bench_tags[4] <- "Reasoning"

    bench_url[5]         <- "https://github.com/idavidrein/gpqa"
    bench_description[5] <- paste0(
      "GPQA: 448 multiple-choice questions written by domain experts",
      " in biology, physics, and chemistry."
    )
    bench_tags[5] <- "Reasoning"

    bench_url[6]         <- "https://agi.safe.ai"
    bench_description[6] <- paste0(
      "Humanity's Last Exam: 2,500 challenging questions across",
      " over a hundred subjects at the frontier of human knowledge."
    )
    bench_tags[6] <- "AGI"

    bench_url[7]         <- "https://livecodebench.github.io"
    bench_description[7] <- paste0(
      "LiveCodeBench: holistic, contamination-free evaluation of LLMs",
      " for code, updated continuously with new problems."
    )
    bench_tags[7] <- "Coding"

    bench_url[8]         <- "https://scicode-bench.github.io"
    bench_description[8] <- paste0(
      "SciCode: models a realistic scientist workflow of identifying",
      " science concepts and transforming them into simulation code."
    )
    bench_tags[8] <- "Coding"

    bench_url[9] <- paste0(
      "https://artificialanalysis.ai/evaluations/math-500"
    )
    bench_description[9] <- paste0(
      "MATH-500: 500 problems spanning algebra, geometry, number",
      " theory, and probability, requiring step-by-step solutions."
    )
    bench_tags[9] <- "Saturated"

    bench_url[10] <- paste0(
      "https://artificialanalysis.ai/evaluations/aime-2025"
    )
    bench_description[10] <- paste0(
      "AIME 2025: all 30 problems from the 2025 American Invitational",
      " Mathematics Examination."
    )
    bench_tags[10] <- "Maths"

    bench_url[11]         <- "https://artificialanalysis.ai/evaluations"
    bench_description[11] <- "AIM25"
    bench_tags[11]        <- "Maths"

    bench_url[12]         <- "https://arxiv.org/abs/2507.02833"
    bench_description[12] <- "IFBench"
    bench_tags[12]        <- "Instructions"

    bench_url[13] <- paste0(
      "https://artificialanalysis.ai/methodology/",
      "intelligence-benchmarking#aa-lcr"
    )
    bench_description[13] <- paste0(
      "AA-LCR: measures ability to extract and synthesise information",
      " from long-form documents ranging from 10k to 100k tokens."
    )
    bench_tags[13] <- "Long context Reasoning"

    bench_url[14]         <- bench_url[13]
    bench_description[14] <- paste0(
      "Terminal-Bench: agentic benchmark evaluating agents on software",
      " engineering, sysadmin, and game-playing via a terminal."
    )
    bench_tags[14] <- "Agentic"

    bench_url[15]         <- "https://github.com/sierra-research/tau2-bench"
    bench_description[15] <- paste0(
      "t2-Bench: benchmark for Tool-Agent-User interaction",
      " in real-world domains."
    )
    bench_tags[15] <- "Agentic"
    
    bench_url[16]         <- bench_url[15]
    bench_description[16] <- bench_description[15]
    bench_tags[16]        <- bench_tags[15]
    
    bench_url[17]         <- bench_url[15]
    bench_description[17] <- bench_description[15]
    bench_tags[17]        <- bench_tags[15]
  
    bench_url[15]         <- bench_url[14]
    bench_description[15] <- bench_description[14]
    bench_tags[15]        <- bench_tags[14]

    
    analytics_bench_df <- data.frame(
      Name        = benchmarks,
      Description = bench_description,
      URL         = bench_url,
      TAGS        = bench_tags
    )
    save(
      analytics_bench_df,
      file     = file.path(data_dir, "artificial_description.Rdata"),
      compress = TRUE
    )
    log_info("Built: benchmark metadata data frame")

    # --- 1d: Normalised evaluations data + all-benchmarks chart ----------
    #
    # Depends on analytics_bench_df built above.  A separate inner
    # tryCatch keeps a pivot / merge failure from hiding the already-
    # saved metadata file or preventing the chart from being attempted.

    tryCatch({
      cols_included <- c(
        2,
        which(startsWith(
          names(df_all), "pricing.price_1m_blended_3_to_1"
        )),
        which(startsWith(names(df_all), "evaluations"))
      )
      df_evals       <- df_all[, cols_included]
      eval_col_names <- names(df_evals) |>
        str_subset("^evaluations\\.") |>
        str_remove("^evaluations\\.")
      names(df_evals) <- c("model", "price", eval_col_names)

      df_long_evals <- pivot_longer(
        data      = df_evals,
        cols      = 3:ncol(df_evals),
        names_to  = "Benchmark",
        values_to = "Score"
      )
      # Drop rows where Score is an empty list-column element before
      # coercing to numeric; list-columns survive pivot_longer unchanged.
      df_long_evals <- df_long_evals[lengths(df_long_evals$Score) > 0, ]
      df_long_evals$Score <- as.numeric(unlist(df_long_evals$Score))

      df_long_evals <- merge(
        analytics_bench_df,
        df_long_evals,
        by.x = "Name",
        by.y = "Benchmark"
      ) |>
        select(Name, Description, URL, TAGS, model, price, Score)

      df_long_evals_norm <- df_long_evals |>
        group_by(Name) |>
        mutate(
          norm_score = (Score - min(Score, na.rm = TRUE)) /
            (max(Score, na.rm = TRUE) - min(Score, na.rm = TRUE)),
          rank = min_rank(desc(Score))
        ) |>
        ungroup()

      results[["Artificial: Dataframe - All benchmarks"]] <-
        df_long_evals_norm
      log_info("Built: normalised evaluations data frame")

      # --- Chart: all-benchmarks price vs normalised score ---------------

      tryCatch({
        p <- ggplot(
          df_long_evals_norm,
          aes(x = price, y = norm_score, color = Name)
        ) +
          geom_jitter_interactive(
            aes(
              tooltip = paste0(
                model,
                "\nCapability: ", TAGS,
                "\nRank: ", rank,
                "\nBenchmark: ", Name,
                "\nEstimated Price: $", price,
                "\nScore: ", Score,
                "\nNormalized Score: ",
                round(norm_score, digits = 3)
              ),
              data_id = Name
            ),
            size   = 1,
            width  = 0.5,
            height = 0.02
          ) +
          xlim(0, 50) +
          theme_minimal() +
          labs(
            title    = "Hover over points to see benchmark details",
            subtitle = subtitle
          ) +
          theme(plot.title = element_text_interactive(
            data_id   = "title_id",
            hover_css = "content: attr(data_id);"
          )) +
          theme_solarized_2() +
          theme(legend.position = "none")

        results[["Artificial: Graphic - All benchmarks"]] <- girafe(
          ggobj   = p,
          options = list(
            # Lock the clicked group at full opacity while dimming others.
            opts_selection(
              type       = "single",
              only_shiny = FALSE,
              css        = paste0(
                "opacity:1.0 !important;",
                "stroke:black;stroke-width:2px;"
              )
            ),
            # Fade unselected points to invisible on click.
            opts_selection_inv(
              css = "opacity:0;transition:opacity 0.3s ease;"
            ),
            # Drop un-hovered points to zero opacity, masking tooltips
            # from points that the cursor is not directly over.
            opts_hover_inv(css = girafe_css(
              css   = "opacity:0;transition:opacity 0.2s ease;",
              text  = "opacity:0;",
              image = "opacity:0;"
            )),
            opts_hover(css = "stroke:black;stroke-width:1px;"),
            opts_tooltip(css = paste0(
              "background-color:lightblue;",
              "color:#000000;",
              "padding:8px;",
              "border-radius:5px;",
              "font-family:sans-serif;",
              "border:1px solid #93a1a1;"
            ))
          )
        )

        log_info("Built: All Benchmarks chart")
      },
      error = function(e) {
        log_error(sprintf(
          "All Benchmarks chart failed (non-fatal): %s",
          conditionMessage(e)
        ))
      })
    },
    # Catches pivot, merge, or normalisation errors.
    # analytics_bench_df was already saved above, so its file is intact.
    error = function(e) {
      log_error(sprintf(
        "Normalised evaluations build failed (non-fatal): %s",
        conditionMessage(e)
      ))
    })
  },
  # Catches bench metadata construction errors.
  # Individual chart failures are already handled by inner handlers above.
  error = function(e) {
    log_error(sprintf(
      "Benchmark metadata build failed (non-fatal): %s",
      conditionMessage(e)
    ))
  })
},
# Outer handler: catches artificial.Rdata load failure or unhandled
# errors from the release_date coercion step.
error = function(e) {
  log_error(sprintf(
    "Cannot load artificial.Rdata — skipping source 1: %s",
    conditionMessage(e)
  ))
})

# ---------------------------------------------------------------------------
# Section 2: Oolong arena leaderboards
# ---------------------------------------------------------------------------

log_info("Processing Oolong arena data...")

tryCatch({
  load(file.path(data_dir, "oolong.Rdata"))  # provides dfs

  # dfs[[1]] contains the top-level index; individual leaderboards start
  # at dfs[[2]].
  oo_harvested <- as.Date(dfs[[1]][["date"]])
  oo_count     <- bind_rows(
    dfs[[1]][["leaderboards"]],
    .id = "ARENA_type"
  )

  boards <- dfs[2:length(dfs)] |>
    map_dfr(\(x) data.frame(
      Arena               = unlist(x[["meta"]][["leaderboard"]]),
      url                 = unlist(x[["meta"]][["source_url"]]),
      models_benchmarked  = unlist(x[["meta"]][["model_count"]]),
      best_model          = unlist(x[["models"]][["model"]][[1]]),
      ranked_second_model = unlist(x[["models"]][["model"]][[2]])
    ))

  results[["OOland: Dataframe - benchmarks"]] <- boards
  log_info(sprintf(
    "Oolong arena: %d leaderboards loaded.", nrow(boards)
  ))

  # --- Arena board chart --------------------------------------------------

  tryCatch({
    # Fragile: Need to review code if the structure of dfs changes in future Oolong releases.
    df_test <- dfs[[3]][["models"]]
    df_test <- df_test[order(df_test$score, decreasing = TRUE), ]
    df_test$rank <- 1:nrow(df_test)

    p <- ggplot(
      df_test,
      aes(y = score, x = rank, color = license)
    ) +
      geom_point_interactive(
        aes(
          tooltip = paste0(
            "Model: ", model,
            "\nVendor: ", vendor,
            "\nRank: ", rank,
            "\nScore: ", score,
            "\nLicense: ", license
          ),
          data_id = license
        ),
        size = 2
      ) +
      theme_solarized_2() +
      labs(
        title    = paste0("Arena Board: ", boards$Arena[1]),
        subtitle = subtitle
      )
p
    results[["OOlang: Graphic - Arena Board"]] <- girafe(
      ggobj   = p,
      options = list(
        opts_hover(css = "fill:orange;stroke:black;cursor:pointer;"),
        opts_zoom(max = 5),
        opts_toolbar(position = "topright")
      )
    )

    log_info("Built: Oolong Arena Board chart")
  },
  error = function(e) {
    log_error(sprintf(
      "Oolong Arena chart failed (non-fatal): %s", conditionMessage(e)
    ))
  })
},
error = function(e) {
  log_error(sprintf(
    "Cannot load oolong.Rdata — skipping source 2: %s",
    conditionMessage(e)
  ))
})

# ---------------------------------------------------------------------------
# Section 3: Epoch AI
# ---------------------------------------------------------------------------

log_info("Processing Epoch AI data...")

tryCatch({
  load(file.path(data_dir, "epoch.Rdata"))  # provides epoch_data

  # Extract the first six columns from each CSV file in the Epoch dataset.
  # Each file represents one benchmark; imap_dfr passes the file name as
  # an identifier so rows can be traced back to their source benchmark.
  target_cols <- 1:6

  epoch_results_long <- epoch_data |>
    imap_dfr(\(x, file_name) {
      map_dfr(target_cols, \(idx) {
        # Per-cell tryCatch: a missing column in one file should not abort
        # the entire reshape.  NULL returned here causes map_dfr to fill
        # that row with NA rather than throwing.
        val <- tryCatch(
          unlist(x[[idx]]),
          error = function(e) NULL
        )

        col_name <- tryCatch(
          names(x)[idx],
          error = function(e) NULL
        )

        # Replace NULL / NA / empty column names with a positional fallback
        # so the resulting data frame always has a non-empty column_name.
        if (is.null(col_name) || is.na(col_name) || col_name == "") {
          col_name <- paste0("index_", idx)
        }

        if (is.null(val) || length(val) == 0) {
          log_warn(sprintf(
            "Epoch: missing data in %s at index %d (%s)",
            file_name, idx, col_name
          ))
          val <- NA
        } else {
          val <- val[1]
        }

        data.frame(
          original_file    = file_name,
          column_index     = idx,
          column_name      = col_name,
          value            = as.character(val),
          stringsAsFactors = FALSE
        )
      })
    })

  epoch_results_long$Benchmark <- str_sub(
    epoch_results_long$original_file,
    end = -5
  )

  epoch_summary <- data.frame(
    Benchmark     = unlist(
      epoch_results_long |>
        filter(column_name == "Model.version") |>
        select(Benchmark)
    ),
    Model.version = unlist(
      epoch_results_long |>
        filter(column_name == "Model.version") |>
        select(value)
    ),
    Release.date  = unlist(
      epoch_results_long |>
        filter(column_name == "Release.date") |>
        select(value)
    ),
    Organization  = unlist(
      epoch_results_long |>
        filter(column_name == "Organization") |>
        select(value)
    ),
    Country       = unlist(
      epoch_results_long |>
        filter(column_name == "Country") |>
        select(value)
    )
  )

  # Remove the "_external" suffix that Epoch appends to benchmark file names
  # so the display name matches the published benchmark name.
  epoch_summary$Benchmark <- gsub(
    pattern     = "_external",
    replacement = "",
    x           = epoch_summary$Benchmark,
    fixed       = TRUE
  )
  rownames(epoch_summary) <- NULL

  results[["Epoch: Dataframe - Best Model"]] <- epoch_summary
  log_info(sprintf(
    "Epoch AI: %d benchmark rows processed.", nrow(epoch_summary)
  ))
},
error = function(e) {
  log_error(sprintf(
    "Cannot load epoch.Rdata — skipping source 3: %s",
    conditionMessage(e)
  ))
})


# ---------------------------------------------------------------------------
# Section x: Cisco Safety
# ---------------------------------------------------------------------------

tryCatch({
  load(paste0(data_dir, "cisco.Rdata"))
  
  # Sort by combined score and assign rank for tooltip display.
  cisco_sorted_df <- cisco_df |>
    arrange(-data.combined_score) |> 
    mutate(rank = row_number())
  
  # Build a ggplot scatter plot of combined score vs rank, colored by source type.
  p <- ggplot(
    cisco_sorted_df,
    aes(y = `data.combined_score`, x = rank, color = `data.source_type`)
  ) +
    geom_point_interactive(
      aes(
        tooltip = paste0(
          "Model: ", `data.model`,
          "\nScore: ", `data.combined_score`,
          "\nLicense: ", `data.source_type`
        ),
        data_id = `data.source_type`
      ),
      size = 2
    ) +
    theme_solarized_2() +
    labs(
      title    = paste0("Cisco Safety "),
      subtitle = "",
      x = "Rank", 
      y = "Combined Score")
  
  # Convert the ggplot to an interactive girafe object with hover and zoom options.
  # Save the resulting interactive plot in the results list under a descriptive name.
  results[["Cisco: Graphic - Safety"]]  <-
    girafe(
      ggobj   = p,
      options = list(
        opts_hover(css = "fill:orange;stroke:black;cursor:pointer;"),
        opts_zoom(max = 5),
        opts_toolbar(position = "topright"),
        opts_sizing(rescale = TRUE) 
      )
    )
  
  log_info("Built: Cisco Safety chart")
},
error = function(e) {
  log_error(sprintf(
    "Cisco Safety chart failed (non-fatal): %s", conditionMessage(e)
  ))
})

# ---------------------------------------------------------------------------
# LLM Stats
# ---------------------------------------------------------------------------

tryCatch({
  log_info("Processing LLM Stats data...")
  load(paste0(data_dir, "llm_stats.Rdata"))
  results[["LLM_Stats: Dataframe - Ranking"]] <- models_rank_df
  results[["LLM_Stats: Dataframe - Updates"]] <- models_updated_df
},
error = function(e) {
  log_error(sprintf(
    "Failed loading llm_stats (non-fatal): %s", conditionMessage(e)
  ))
})




# ---------------------------------------------------------------------------
# OpenRouter
# ---------------------------------------------------------------------------


log_info("Processing Openrouter data...")

tryCatch({
  log_info("Loading openroute data")
  load(file.path(data_dir,  "Open_Router.Rdata"))  

arc_df <- openrouter_df$architecture
arc_df <- arc_df %>%
  mutate(output = map_chr(output_modalities, ~ paste(.x, collapse = ",")),
         input = map_chr(input_modalities, ~ paste(.x, collapse = ",")))

arc_counts_df <- arc_df |>
  count(output, input) 


generate_stylish_matrix <- function(data_df, 
                                    base_font_size = 12, 
                                    low_color = "#F4F6F7", 
                                    high_color = "#2E86C1", 
                                    text_color = "#2C3E50") {
  
  # 1. Build the stylized ggplot base
  gg_plot <- ggplot(data_df, aes(x = input, y = output, fill = n)) +
    # Render tiles that will stretch to fill available canvas space
    geom_tile(aes(fill = n), color = "white", linewidth = 1.5, linejoin = "round") +
    
    # Text labels with dynamic text coloring based on tile intensity
    geom_text(aes(label = n, 
                  color = stage(n, after_scale = ifelse(fill > (max(data_df$n) / 1.8), "white", text_color))), 
              fontface = "bold", 
              size = base_font_size * 0.35) + 
    
    # Elegant color gradient
    scale_fill_gradient(low = low_color, high = high_color) +
    
    # Clean labels
    labs(
      title = "Input vs Output Modalities Matrix",
      x = "Input Modality",
      y = "Output Modality"
    ) +
    
    # Page-optimized minimalist theme
    theme_minimal(base_size = base_font_size) + 
    theme(
      plot.title = element_text(face = "bold", size = rel(1.3), hjust = 0.5, margin = margin(b = 15)),
      axis.title.x = element_text(face = "bold", margin = margin(t = 10)),
      axis.title.y = element_text(face = "bold", margin = margin(r = 10)),
      
      # Text adjustments for neat formatting
      axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, color = "#4A5568"),
      axis.text.y = element_text(color = "#4A5568"),
      
      panel.grid = element_blank(),
      
      # CRITICAL CHANGES FOR YOUR REQUEST:
      legend.position = "none",             # Completely removes all legends
      plot.margin = margin(20, 20, 20, 20)  # Generous margins to prevent clipping
    ) +
    
    # REMOVED coord_fixed(). Replaced with coord_cartesian to allow boxes 
    # to tall-stretch or wide-stretch according to the device's dimension limits.
    coord_cartesian(expand = FALSE) 
  
  # 2. Dynamic conversion via ggplotify
  ggplotify::as.ggplot(gg_plot)
}

log_info("Generating graphic for OpenRouter architecture modularity")
results[["OpenRouter: Graphic - Modularity"]] <- generate_stylish_matrix(arc_counts_df, base_font_size = 14)

},
error = function(e) {
  log_error(sprintf(
    "Open router plotting failed (non-fatal): %s", conditionMessage(e)
  ))
})

# ---------------------------------------------------------------------------
# Save results
# ---------------------------------------------------------------------------
#
# Saves whatever was accumulated in `results` across all three sections.
# Runs unconditionally so Live_Data_Story.Rmd always gets a file to load,
# even if every section failed and the list is empty.
# A write failure is fatal because the dashboard cannot render without it.

log_info(sprintf("Saving %d result(s)...", length(results)))
log_info("{names(results)}")

tryCatch(
  save(
    results,
    file     = file.path(data_dir, "artificial_results.Rdata"),
    compress = TRUE
  ),
  error = function(e) {
    stop_fatal(sprintf("Failed to save results: %s", conditionMessage(e)))
  }
)

log_info("Explore complete.")

