# Gather Benchmark information
#
# Pulls live AI benchmark data from multiple sources and saves
# .Rdata / .csv files to DATA_DIR for use by Explore_Benchmarks.R.
#
#
# Required env vars: ACTI_KEY, DATA_DIR
# Optional env vars: HUGGING_READ
# Depends on: logger (install via pak::pak("logger"))


suppressPackageStartupMessages({
  library(httr2)
  library(jsonlite)
  library(httr)
  library(dplyr)
  library(purrr)
  library(logger)
})

# ---------------------------------------------------------------------------
# Logging setup
# ---------------------------------------------------------------------------

# logger writes timestamped, levelled lines to stdout:
#   INFO  [2024-06-01 12:00:00] message
#   WARN  [2024-06-01 12:00:00] message
# Raise the threshold to WARN in high-volume runs to reduce noise.
log_threshold(INFO)

# stop_fatal: logs at FATAL level then exits with a non-zero status code.
# Used only for conditions that make further work impossible: missing
# credentials or an unwritable DATA_DIR.  Per-source failures use
# log_error() and continue so remaining sources still run.
stop_fatal <- function(msg) {
  log_fatal(msg)
  quit(save = "no", status = 1, runLast = FALSE)
}

# ---------------------------------------------------------------------------
# Environment validation
# ---------------------------------------------------------------------------

acti_key    <- Sys.getenv("ACTI_KEY")
data_dir    <- Sys.getenv("DATA_DIR")
hugging_key <- Sys.getenv("HUGGING_READ")

if (nchar(acti_key) == 0) stop_fatal("ACTI_KEY is not set.")
if (nchar(data_dir) == 0) stop_fatal("DATA_DIR is not set.")
if (!dir.exists(data_dir)) {
  stop_fatal(sprintf("DATA_DIR does not exist: %s", data_dir))
}

log_info(sprintf("Writing output to: %s", data_dir))

# ---------------------------------------------------------------------------
# Helper: save .Rdata with error handling
# ---------------------------------------------------------------------------

save_rdata <- function(obj_name, file, envir = parent.frame()) {
  # A write failure is always fatal: downstream scripts cannot render
  # without their input files.
  tryCatch(
    save(list = obj_name, file = file, envir = envir, compress = TRUE),
    error = function(e) {
      stop_fatal(sprintf(
        "Failed to write %s: %s", file, conditionMessage(e)
      ))
    }
  )
  log_info(sprintf("Saved %s", file))
}

# ---------------------------------------------------------------------------
# Source 1: Artificial Analysis
# ---------------------------------------------------------------------------
#
# Fatal on failure: this is the primary data source for Explore_Benchmarks.R.
# req_error(is_error = \(r) FALSE) disables httr2's built-in HTTP error
# raising so we can inspect the status ourselves and distinguish a 401
# (bad API key) from other HTTP errors before calling stop_fatal.

log_info("Fetching Artificial Analysis model data...")

tryCatch({
  resp <- request(
    "https://artificialanalysis.ai/api/v2/data/llms/models"
  ) |>
    req_headers("x-api-key" = acti_key) |>
    req_error(is_error = \(r) FALSE) |>
    req_perform()

  if (resp_status(resp) == 401L) {
    stop_fatal(
      "Artificial Analysis: authentication failed (ACTI_KEY rejected)."
    )
  }
  if (resp_status(resp) != 200L) {
    stop_fatal(sprintf(
      "Artificial Analysis: unexpected HTTP %d.", resp_status(resp)
    ))
  }

  data   <- resp_body_json(resp)
  df_all <- jsonlite::fromJSON(
    jsonlite::toJSON(data, auto_unbox = TRUE),
    flatten = TRUE
  )$data

  save_rdata("df_all",
    file  = file.path(data_dir, "artificial.Rdata"),
    envir = environment()
  )
  log_info(sprintf(
    "Artificial Analysis: %d models retrieved.", nrow(df_all)
  ))
},
# Catches network errors and parse errors not handled above.
# Fatal here because Explore_Benchmarks.R cannot run without this data.
error = function(e) {
  stop_fatal(sprintf(
    "Artificial Analysis fetch failed: %s", conditionMessage(e)
  ))
})

# ---------------------------------------------------------------------------
# Source 2: Epoch AI
# ---------------------------------------------------------------------------
#
# Non-fatal: if the ZIP download or CSV extraction fails, later sources
# can still be gathered and the dashboard renders with reduced content.

log_info("Fetching Epoch AI benchmark data...")

tryCatch({
  epoch_url <- "https://epoch.ai/data/benchmark_data.zip"
  temp_zip  <- tempfile(fileext = ".zip")
  temp_dir  <- tempdir()

  # on.exit registers cleanup that runs when this scope exits — including
  # on error — so the temp ZIP is removed even if an exception is thrown.
  on.exit(if (file.exists(temp_zip)) unlink(temp_zip), add = TRUE)

  # withCallingHandlers intercepts warnings WITHOUT unwinding the call
  # stack, so download.file continues executing after the handler returns.
  # invokeRestart("muffleWarning") silences R's default accumulator after
  # we have logged the message, preventing duplicate output.
  withCallingHandlers(
    download.file(epoch_url, temp_zip, mode = "wb", quiet = TRUE),
    warning = function(w) {
      log_warn(sprintf(
        "Epoch download warning: %s", conditionMessage(w)
      ))
      invokeRestart("muffleWarning")
    }
  )

  if (!file.exists(temp_zip) || file.info(temp_zip)$size == 0L) {
    stop("Downloaded ZIP is empty or missing.")
  }

  unzipped_files <- unzip(temp_zip, exdir = temp_dir)
  csv_files      <- grep("\\.csv$", unzipped_files, value = TRUE)

  if (length(csv_files) == 0L) stop("No CSV files found in Epoch ZIP.")

  epoch_data        <- lapply(csv_files, read.csv, stringsAsFactors = FALSE)
  names(epoch_data) <- basename(csv_files)

  save_rdata("epoch_data",
    file  = file.path(data_dir, "epoch.Rdata"),
    envir = environment()
  )
  log_info(sprintf(
    "Epoch AI: %d CSV files extracted.", length(csv_files)
  ))
},
# Catches stop() calls above and any network or parse errors from
# download.file / unzip.  Logged at ERROR (not FATAL) so the script
# continues to the remaining sources.
error = function(e) {
  log_error(sprintf(
    "Epoch AI fetch failed (non-fatal): %s", conditionMessage(e)
  ))
})

# ---------------------------------------------------------------------------
# Source 3: BenchLM leaderboard
# ---------------------------------------------------------------------------

log_info("Fetching BenchLM leaderboard...")

tryCatch({
  benchlm_url <- "https://benchlm.ai/api/data/leaderboard?format=csv&limit=200"
  dest        <- file.path(data_dir, "benchmarkllm_leaderboard_latest.csv")

  # Same withCallingHandlers pattern as Epoch: log warnings and muffle them
  # so download.file can continue without R accumulating duplicate output.
  withCallingHandlers(
    download.file(benchlm_url, dest, mode = "wb", quiet = TRUE),
    warning = function(w) {
      log_warn(sprintf(
        "BenchLM download warning: %s", conditionMessage(w)
      ))
      invokeRestart("muffleWarning")
    }
  )

  log_info(sprintf("BenchLM: saved to %s", dest))
},
error = function(e) {
  log_error(sprintf(
    "BenchLM fetch failed (non-fatal): %s", conditionMessage(e)
  ))
})

# ---------------------------------------------------------------------------
# Source 4: Oolong-tea arena leaderboards
# ---------------------------------------------------------------------------

log_info("Fetching Oolong arena leaderboard index...")

tryCatch({
  owner   <- "oolong-tea-2026"
  repo    <- "arena-ai-leaderboards"
  idx_url <- paste0(
    "https://raw.githubusercontent.com/", owner, "/", repo,
    "/refs/heads/main/data/latest.json"
  )

  # Inner tryCatch re-raises with a clearer message before the outer
  # handler sees it.  stop() inside a tryCatch expression converts any
  # condition into a plain error that propagates to the outer handler.
  dir_index <- tryCatch(
    unlist(jsonlite::fromJSON(idx_url)),
    error = function(e) {
      stop(sprintf(
        "Could not fetch arena index: %s", conditionMessage(e)
      ))
    }
  )

  if (length(dir_index) == 0L) stop("Arena index is empty.")

  api_url <- paste0(
    "https://api.github.com/repos/", owner, "/", repo,
    "/contents/data/", dir_index[[1]]
  )
  files <- request(api_url) |>
    req_error(is_error = \(r) resp_status(r) != 200L) |>
    req_perform() |>
    resp_body_json()

  json_files <- keep(files, ~ grepl("\\.json$", .x$name))

  if (length(json_files) == 0L) {
    stop("No JSON files found in arena data directory.")
  }

  # Per-file tryCatch: a single file failing should not abort the whole
  # source.  Returning NULL lets the outer Filter() remove failed files,
  # and stop() below catches the case where every file fails.
  dfs <- map(json_files, function(f) {
    tryCatch({
      json_raw <- request(f$download_url) |>
        req_error(is_error = \(r) resp_status(r) != 200L) |>
        req_perform() |>
        resp_body_string()
      jsonlite::fromJSON(json_raw, flatten = TRUE)
    },
    error = function(e) {
      log_warn(sprintf(
        "Skipping arena file %s: %s", f$name, conditionMessage(e)
      ))
      NULL
    })
  })

  dfs <- Filter(Negate(is.null), dfs)
  if (length(dfs) == 0L) stop("All arena files failed to download.")

  save_rdata("dfs",
    file  = file.path(data_dir, "oolong.Rdata"),
    envir = environment()
  )
  log_info(sprintf(
    "Oolong arena: %d leaderboard files saved.", length(dfs)
  ))
},
error = function(e) {
  log_error(sprintf(
    "Oolong arena fetch failed (non-fatal): %s", conditionMessage(e)
  ))
})

# ---------------------------------------------------------------------------
# Source 5: Cisco AI Defense safety leaderboard
# ---------------------------------------------------------------------------

log_info("Fetching Cisco AI Defense safety leaderboard...")

tryCatch({
  cisco_url <- "https://leaderboard.aidefense.cisco.com/api/rankings?limit=200"
  response  <- GET(cisco_url)

  # httr::GET does not raise on HTTP errors by default; http_error() checks
  # the status code and stop() converts it to a condition for tryCatch.
  if (http_error(response)) {
    stop(sprintf(
      "HTTP %d from Cisco leaderboard.", status_code(response)
    ))
  }

  cisco_df <- content(response, as = "text", encoding = "UTF-8") |>
    jsonlite::fromJSON(flatten = TRUE) |>
    as.data.frame()

  save_rdata("cisco_df",
    file  = file.path(data_dir, "cisco.Rdata"),
    envir = environment()
  )
  log_info(sprintf("Cisco leaderboard: %d rows saved.", nrow(cisco_df)))
},
error = function(e) {
  log_error(sprintf(
    "Cisco leaderboard fetch failed (non-fatal): %s", conditionMessage(e)
  ))
})

# ---------------------------------------------------------------------------
# Source 6: HuggingFace UGI leaderboard
# ---------------------------------------------------------------------------

log_info("Fetching HuggingFace UGI leaderboard...")

tryCatch({
  ugi_url <- paste0(
    "https://huggingface.co/spaces/DontPlanToEnd/",
    "UGI-Leaderboard/resolve/main/ugi-leaderboard-data.csv"
  )
  dest <- file.path(data_dir, "ugi-leaderboard-data.csv")

  withCallingHandlers(
    download.file(ugi_url, dest, mode = "wb", quiet = TRUE),
    warning = function(w) {
      log_warn(sprintf("UGI download warning: %s", conditionMessage(w)))
      invokeRestart("muffleWarning")
    }
  )

  log_info(sprintf("UGI leaderboard: saved to %s", dest))
},
error = function(e) {
  log_error(sprintf(
    "UGI leaderboard fetch failed (non-fatal): %s", conditionMessage(e)
  ))
})

# ---------------------------------------------------------------------------
# Source 7: HuggingFace trustworthy leaderboard (via reticulate)
# ---------------------------------------------------------------------------

if (nchar(hugging_key) > 0L) {
  log_info("Fetching HuggingFace trustworthy leaderboard...")

  # reticulate surfaces Python exceptions as R conditions, so tryCatch
  # catches them the same way as native R errors.  Virtualenv setup
  # failure, import errors, and dataset-load errors all reach the
  # error handler below without any special casing.
  tryCatch({
    library(reticulate)
    use_virtualenv("hf_env", required = TRUE)

    datasets      <- import("datasets")
    py_dataset    <- datasets$load_dataset(
      "AI-Secure/llm-trustworthy-leaderboard-results"
    )
    pandas_df     <- py_dataset$train$to_pandas()
    r_leaderboard <- py_to_r(pandas_df)

    save_rdata("r_leaderboard",
      file  = file.path(data_dir, "hf_trustworthy_leaderboard.Rdata"),
      envir = environment()
    )
    log_info(sprintf(
      "HF trustworthy leaderboard: %d rows saved.", nrow(r_leaderboard)
    ))
  },
  error = function(e) {
    log_error(sprintf(
      "HF trustworthy leaderboard fetch failed (non-fatal): %s",
      conditionMessage(e)
    ))
  })
} else {
  log_warn(
    "HUGGING_READ not set — skipping HuggingFace trustworthy leaderboard."
  )
}


# ---------------------------------------------------------------------------
# Source : LMM-STATS
# ---------------------------------------------------------------------------

tryCatch({
  log_info("Fetching LLM-STATS data...")
  timestamp_llm_stats <- Sys.Date()
  
  limit    <- 50
  days     <- 60
  api_key  <- Sys.getenv("LLM_STATS")

  
  # Ensure the data directory path ends with a slash safely
  if (data_dir != "" && !endsWith(data_dir, "/")) {
    data_dir <- paste0(data_dir, "/")
  }
  
  # --- 1. Fetch Rankings ---
  log_info("Requesting ranking data...")
  response <- request("https://api.zeroeval.com/stats/v1/rankings") |>
    req_url_query(category = "coding", limit = limit) |>
    req_auth_bearer_token(api_key) |>
    req_retry(max_tries = 1) |> # Automatically handles temporary network issues/rate limits
    req_error(is_error = function(resp) FALSE) |> # Prevents httr2 from throwing an unhandled R error immediately
    req_perform()
  
  if (resp_is_error(response)) {
    stop(sprintf("Rankings API HTTP Error %s", resp_status(response)))
  }
  data_ranking <- resp_body_json(response)
  
  # --- 2. Fetch Updates ---
  log_info("Requesting updates data...")
  response_updates <- request("https://api.zeroeval.com/stats/v1/updates") |>
    req_url_query(days = 16, limit = 10) |>
    req_auth_bearer_token(api_key) |>
    req_retry(max_tries = 1) |> 
    req_error(is_error = function(resp) FALSE) |> 
    req_perform()
  
  if (resp_is_error(response_updates)) {
    stop(sprintf("Updates API HTTP Error %s", resp_status(response_updates)))
  }
  data_updates <- resp_body_json(response_updates)
  
  
  # Create and execute the request
  #  Max limit and number of days. Needs experimentation to find optimal values
  response_updates <- request("https://api.zeroeval.com/stats/v1/updates") |>
    req_url_query(days = 16, limit = 10) |>
    req_auth_bearer_token(api_key) |>
    req_perform()
  
  data_updates <- resp_body_json(response_updates)
  
  
  
  # Extract and combine in one step
  models_updated_df <- map_df(data_updates[["models"]], function(model) {
    tibble(
      id          = model[["id"]],
      org         = model[["organization"]][["name"]],
      open_weight = model[["open_weight"]],
      added_at    = model[["added_at"]],
      source      = model[["source"]],
      url         = model[["url"]]
    )
  })
  
  
  # Extract and combine in one step
  models_rank_df <- map_df(data_ranking[["models"]], function(model) {
    tibble(
      model_name  = model[["model_name"]],
      org         = model[["organization"]],
      score       = model[["score"]],
      min_input_price = model[["min_input_price"]],
      open_weight = model[["open_weight"]],
      benchmarks_evaluated = model[["benchmarks_evaluated"]],
      source      = model[["source"]],
      url         = model[["url"]]
    )
  })
  
 
  if (nrow(models_updated_df) > 0) {
    models_updated_df$added_at <- as.POSIXct(
      models_updated_df$added_at, 
      format = "%Y-%m-%dT%H:%M:%OS", 
      tz = "UTC"
    )
  }
  
  
  # --- 5. Save Results ---
  save_path <- paste0(data_dir, "llm_stats.Rdata")
  save(timestamp_llm_stats, models_rank_df, models_updated_df, file = save_path, compress = TRUE)
  log_info(sprintf("Successfully saved data to %s", save_path))
  
}, error = function(e) { 
  log_error(sprintf("LLM-STAT (non-fatal): %s", conditionMessage(e)))
})
