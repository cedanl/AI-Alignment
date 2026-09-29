# =====================================================================
# Synthetic data generation: LLM performance across community values
# for the use of LLMs in Dutch higher education (hoger onderwijs)
#
# Output: llm_performance_community_values.csv
#   One unique row per model; one column per community value.
#   Scores on a 0-100 benchmark-style scale.
#
# Community value columns and their research basis (citations):
#
# 1. menselijke_regie (human agency & oversight)
#    - EU High-Level Expert Group on AI (2019). Ethics Guidelines for
#      Trustworthy AI, key requirement 1 "Human agency and oversight".
#      https://digital-strategy.ec.europa.eu/en/library/ethics-guidelines-trustworthy-ai
# 2. privacy (privacy & data governance)
#    - EU AI HLEG (2019), key requirement 3; GDPR/AVG context.
#    - Jobin, A., Ienca, M., & Vayena, E. (2019). The global landscape of
#      AI ethics guidelines. Nature Machine Intelligence, 1(9), 389-399.
#      (privacy among the most-cited principles; transparency #1)
# 3. transparantie (transparency & explainability)
#    - EU AI HLEG (2019), key requirement 4; Jobin et al. (2019):
#      transparency is the most frequently cited AI-ethics principle.
# 4. fairness_inclusie (diversity, non-discrimination & fairness)
#    - EU AI HLEG (2019), key requirement 5.
#    - UNESCO (2021). Recommendation on the Ethics of Artificial
#      Intelligence, section on education: non-discrimination incl.
#      disability, gender equality, cultural diversity.
# 5. veiligheid_robustheid (technical robustness & safety)
#    - EU AI HLEG (2019), key requirement 2.
# 6. verantwoording (accountability & redress)
#    - EU AI HLEG (2019), key requirement 7.
#    - Npuls (n.d.). "AI en data waarde(n)vol inzetten" / "Verantwoord
#      gebruik AI en data": sectorkaders zoals Referentiekader en
#      Algoritmeregister. https://www.npuls.nl/ai-waardenvol-inzetten
# 7. maatschappelijk_duurzaamheid (societal & environmental well-being)
#    - EU AI HLEG (2019), key requirement 6 (incl. sustainability of
#      resource-hungry large models).
# 8. onderwijskwaliteit (pedagogical quality)
#    - UNESCO (2021), education section: AI must support human-centered
#      pedagogy, teacher facilitation, quality learning.
#    - Crompton, H., & Burke, D. (2023). Artificial intelligence in
#      higher education: the state of the field. International Journal
#      of Educational Technology in Higher Education, 20(22).
#      (systematic review; ethics themes incl. pedagogical fit)
# 9. nederlandse_context (Dutch language & public-value context)
#    - Npuls (n.d.): publieke waarden, sectorregie en Nederlandse
#      voorzieningen (eduGenAI; Community AI & Data,
#      https://community-data-ai.npuls.nl/) - LLM quality for Dutch
#      language, curricula and public-valorization context.
#    - UNESCO (2021): respect for cultural and linguistic diversity.
# 10. digitale_soevereiniteit (digital/data sovereignty)
#    - Npuls (n.d.): sectorregie op publieke waarden en afhankelijkheid
#      van commerciële partijen ("De rol van data blijft onderbelicht…
#      vergroot de afhankelijkheid van commerciële partijen").
#    - European Commission (n.d.): European approach to digital
#      sovereignty / "A European approach to artificial intelligence".
#      https://digital-strategy.ec.europa.eu/en/policies/european-approach-artificial-intelligence
# 11. academische_integriteit (academic & research integrity)
#    - UNESCO (2021), education section: protecting human agency and
#      integrity of learning and assessment.
#    - Crompton, H., & Burke, D. (2023): ethics themes in HE AI incl.
#      integrity/authenticity of student work.
# 12. toegankelijkheid (accessibility & equal use)
#    - EU AI HLEG (2019), key requirement 5: systems should be
#      accessible to all, regardless of any disability.
#    - UNESCO (2021): inclusion and equitable access to AI benefits.
# 13. betaalbaarheid (affordability for public institutions)
#    - Npuls (n.d.): publieke regie, collectieve voorzieningen en
#      weerbaarheid van het publiek onderwijsdomein (digital sector
#      facilities; Community AI & Data).
#    - UNESCO (2021): equitable access; avoid deepening inequalities
#      between well-resourced and under-resourced institutions.
# =====================================================================

set.seed(20260929)  # reproducibility
file_out <- "~/Gitlab/Local_playground/NPULS/LITELLM/llm_performance_community_values.csv" # CSV output

# ---- 0. User knob ----
N_SYNTHETIC_MODELS <- 10  # number of additional randomly named models

# ---- 1. Community values ----
values <- c(
  "menselijke_regie", "privacy", "transparantie", "fairness_inclusie",
  "veiligheid_robustheid", "verantwoording", "maatschappelijk_duurzaamheid",
  "onderwijskwaliteit", "nederlandse_context", "digitale_soevereiniteit",
  "academische_integriteit", "toegankelijkheid", "betaalbaarheid"
)

# Value-specific difficulty for frontier models (population mean offsets).
# Governance-heavy values (transparantie, verantwoording, duurzaamheid,
# digitale soevereiniteit) score structurally lower than raw task quality.
value_offsets <- c(
  menselijke_regie = 4,
  privacy = 2,
  transparantie = -12,
  fairness_inclusie = -6,
  veiligheid_robustheid = 0,
  verantwoording = -10,
  maatschappelijk_duurzaamheid = -14,
  onderwijskwaliteit = 6,
  nederlandse_context = -8,
  digitale_soevereiniteit = -11,
  academische_integriteit = -5,
  toegankelijkheid = -7,
  betaalbaarheid = -9
)

# ---- 2. Random humanly-readable model names ----
# Generate n unique, plausible model names from Dutch-flavored stems
# plus size/tier suffixes. Uniqueness is guaranteed against a list of
# names that must stay reserved (e.g. the real-world models).
gen_model_names <- function(n, reserved = character(0), seed = NULL) {
  stems <- c("Studie", "Delta", "Bollen", "Duin", "Waterwolf", "Kompas",
             "Veer", "Polder", "Zandpad", "Boterham", "Deltapunt", "Ster",
             "Kikker", "Duinrand", "Stuw", "Zeehond", "Slot", "Meander",
             "Wolkenveld", "Graspieper")
  suffixes <- c("-2", "-7B", "-Large", "-Mini", "-Pro", "-1", "-XL",
                "-3", "-13B", "-Plus")
  if (!is.null(seed)) set.seed(seed)
  out <- character(0)
  while (length(out) < n) {
    cand <- paste0(sample(stems, 1), sample(suffixes, 1))
    if (!(cand %in% out) && !(cand %in% reserved))
      out <- c(out, cand)
  }
  out
}

# ---- 3. Models: one unique row per model ----
# Latent overall model quality (drives cross-value correlation)
real_models <- data.frame(
  model = c("GPT-4o", "Gemini 2.5 Pro", "Claude Sonnet 4", "Llama 3.1 70B",
            "Mistral Large 2", "eduGenAI-NL", "GPT-4o-mini", "Phi-4"),
  share_quality = c(72, 71, 71, 65, 64, 62, 66, 60),
  provenance = c(rep("commercieel", 3), rep("open gewicht", 2),
                 "nederlandse publieke voorziening", rep("commercieel", 2)),
  stringsAsFactors = FALSE
)
names_synth <- gen_model_names(N_SYNTHETIC_MODELS,
                               reserved = real_models$model, seed = 42)
synth_models <- data.frame(
  model = names_synth,
  share_quality = round(runif(N_SYNTHETIC_MODELS, 58, 68)),
  provenance = rep("synthetisch", N_SYNTHETIC_MODELS),
  stringsAsFactors = FALSE
)
models <- rbind(real_models, synth_models)
stopifnot(nrow(models) == length(unique(models$model)))  # one row per model

# ---- 4. Best-fit scenario annotation (per model, not a row dimension) ----
scenarios <- c(
  "tutoring_studenten",          # inhoudelijke uitleg/uitspraak-feedback
  "automatische_feedback",       # feedback op studentenwerk
  "toetsvoorbereiding",          # oefenvragen & examenvoorbereiding
  "lesmateriaal_ontwerp",        # ontwerp en bewerk lesmateriaal
  "samenvatten_vakliteratuur",   # NL vakliteratuur samenvatten
  "privacy_gevoelig_advies"      # advies met persoonsgegevens in speelveld
)
# Plausible profile: commercial models best at pedagogy-heavy tasks,
# open-weight models at summarization, NL public model at privacy-aware advising.
best_fit_probs <- list(
  commercieel                        = c(0.30, 0.25, 0.15, 0.20, 0.10, 0.00),
  "open gewicht"                     = c(0.10, 0.10, 0.10, 0.10, 0.60, 0.00),
  "nederlandse publieke voorziening" = c(0.10, 0.10, 0.10, 0.10, 0.20, 0.40),
  synthetisch                        = c(0.20, 0.15, 0.15, 0.15, 0.25, 0.10)
)
models$best_fit_scenario <- vapply(
  models$provenance,
  function(p) sample(scenarios, 1, prob = best_fit_probs[[p]]),
  character(1)
)
models$fit_boost_onderwijskwaliteit <- ifelse(
  models$best_fit_scenario %in% c("tutoring_studenten", "lesmateriaal_ontwerp"),
  5, 0)
models$fit_drop_privacy <- ifelse(
  models$best_fit_scenario == "privacy_gevoelig_advies", -6, 0)

# ---- 5. Simulate scores ----
n <- nrow(models)
q <- models$share_quality + rnorm(n, 0, 1.5)  # latent model quality, one per row

score <- function(base, offset, extra, sd_noise = 2.5)
  pmin(100, pmax(0, round(base + offset + extra + rnorm(length(base), 0, sd_noise))))

df <- data.frame(
  model_id   = seq_len(n),
  model      = models$model,
  provenance = models$provenance,
  best_fit_scenario = models$best_fit_scenario
)
# per-provenance structural deviations where it matters
extra <- lapply(values, function(v) rep(0, n))
names(extra) <- values
ov <- models$provenance == "nederlandse publieke voorziening"
ow <- models$provenance == "open gewicht"
cm <- models$provenance == "commercieel"
extra$digitale_soevereiniteit[ov] <- 10
extra$nederlandse_context[ov]     <- 12
extra$privacy[cm]                 <- 3
extra$privacy[ow]                 <- -5
extra$verantwoording[ow]          <- -4
extra$verantwoording[cm]          <- 2
extra$betaalbaarheid[ow]          <- 8
extra$betaalbaarheid[ov]          <- 6
extra$betaalbaarheid[models$provenance == "synthetisch"] <- 4
extra$onderwijskwaliteit <- models$fit_boost_onderwijskwaliteit
extra$privacy            <- extra$privacy + models$fit_drop_privacy

for (v in values)
  df[[v]] <- score(q, value_offsets[[v]], extra[[v]])

# ---- 6. Self-checks & write CSV ----
stopifnot(nrow(df) == n, !anyNA(df[, values]))
stopifnot(length(unique(df$model)) == n)  # each model exactly one unique row
stopifnot(all(unlist(df[, values]) >= 0 & unlist(df[, values]) <= 100))

write.csv(df, file_out, row.names = FALSE)

cat("Wrote", out, "-", nrow(df), "unique model rows,", length(values),
    "value columns\n")
cat("Models:", paste(df$model, collapse = ", "), "\n")
cat("Per-value means:\n")
print(round(colMeans(df[, values]), 1))