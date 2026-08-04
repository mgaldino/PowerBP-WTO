#!/usr/bin/env Rscript

options(warn = 1)

started_at <- Sys.time()
script_name <- "scripts/verify_clean_optout_protocol_piH0.R"
history_path <- "tables/clean_optout_gate0_histories_piH0.tsv"
rmd_path <- "model_redesign/power_architecture_derivations.Rmd"
output_path <- "tables/clean_optout_protocol_checks_piH0.csv"
log_path <- "quality_reports/logs/verify_clean_optout_protocol_piH0.log"

if (!file.exists(history_path) || !file.exists(rmd_path)) {
  stop("Run this script from the repository root.", call. = FALSE)
}

if (!requireNamespace("dplyr", quietly = TRUE)) {
  stop("Package 'dplyr' is required.", call. = FALSE)
}

history <- utils::read.delim(
  history_path,
  check.names = FALSE,
  quote = "",
  comment.char = "",
  stringsAsFactors = FALSE
)
rmd_lines <- readLines(rmd_path, warn = FALSE, encoding = "UTF-8")
rmd_text <- paste(rmd_lines, collapse = "\n")

checks <- data.frame(
  check_id = character(),
  passed = logical(),
  detail = character(),
  stringsAsFactors = FALSE
)

add_check <- function(check_id, passed, detail) {
  checks <<- dplyr::bind_rows(
    checks,
    data.frame(
      check_id = check_id,
      passed = isTRUE(passed),
      detail = as.character(detail),
      stringsAsFactors = FALSE
    )
  )
}

required_columns <- c(
  "history_id", "round", "rule", "active players", "quota",
  "quota reached?", "H vote", "participation offer to H?",
  "failure cause", "H included?", "H remains?", "y implemented?",
  "destination of y", "H payoff", "weak payoffs", "discount factor",
  "relevant posterior", "terminal or continuation", "next subgame"
)
add_check(
  "history_columns",
  identical(names(history), required_columns),
  paste("columns:", paste(names(history), collapse = " | "))
)

expected_ids <- sprintf("G%02d", 1:21)
add_check(
  "history_ids_complete",
  identical(history$history_id, expected_ids),
  paste("observed:", paste(history$history_id, collapse = ","))
)
add_check(
  "history_cells_nonempty",
  !any(is.na(history)) && !any(trimws(as.matrix(history)) == ""),
  "all versioned history-table cells must be populated"
)

h_no <- history[history[["H vote"]] == "no", , drop = FALSE]
add_check(
  "h_no_never_included",
  nrow(h_no) > 0L && all(h_no[["H included?"]] == "no"),
  "every H-no row excludes H"
)
add_check(
  "h_no_never_remains",
  nrow(h_no) > 0L && all(h_no[["H remains?"]] == "no"),
  "every H-no row makes opt-out irreversible"
)
add_check(
  "h_no_never_implements_y",
  nrow(h_no) > 0L && all(grepl("^no", h_no[["y implemented?"]])),
  "no H-no row implements the conditional participation package"
)

h_no_r1 <- h_no[h_no$round == "R1", , drop = FALSE]
add_check(
  "r1_h_no_is_immediate_optout",
  nrow(h_no_r1) > 0L && all(h_no_r1[["H payoff"]] == "o_theta"),
  paste("R1 H-no payoffs:", paste(unique(h_no_r1[["H payoff"]]), collapse = ","))
)
add_check(
  "r1_h_no_has_no_discounted_continuation",
  !any(grepl("beta\\*C|beta C|C_H2", h_no_r1[["H payoff"]])),
  "the no action never pays beta times an H continuation value"
)

h_no_r2 <- h_no[h_no$round == "R2", , drop = FALSE]
add_check(
  "r2_h_no_is_terminal_optout",
  nrow(h_no_r2) > 0L && all(h_no_r2[["H payoff"]] == "beta*o_theta"),
  paste("R2 H-no payoffs:", paste(unique(h_no_r2[["H payoff"]]), collapse = ","))
)

h_yes_pass_ids <- c("G01", "G05", "G10", "G14")
h_yes_pass <- history[history$history_id %in% h_yes_pass_ids, , drop = FALSE]
add_check(
  "h_yes_pass_includes_h",
  nrow(h_yes_pass) == length(h_yes_pass_ids) &&
    all(h_yes_pass[["H included?"]] == "yes") &&
    all(h_yes_pass[["y implemented?"]] == "yes"),
  "an H-yes agreement that reaches the quota includes H and implements y"
)

r1_h_yes_fail <- history[history$history_id %in% c("G02", "G06"), , drop = FALSE]
add_check(
  "r1_h_yes_weak_failure_keeps_h",
  nrow(r1_h_yes_fail) == 2L &&
    all(r1_h_yes_fail[["H remains?"]] == "yes") &&
    all(grepl("beta\\*C_H2", r1_h_yes_fail[["H payoff"]])) &&
    all(r1_h_yes_fail[["terminal or continuation"]] == "continuation"),
  "only H-yes plus weak shortfall creates an active-H R2 continuation"
)

r2_h_yes_fail <- history[history$history_id %in% c("G11", "G15"), , drop = FALSE]
add_check(
  "r2_h_yes_failure_is_terminal",
  nrow(r2_h_yes_fail) == 2L &&
    all(r2_h_yes_fail[["H payoff"]] == "beta*o_theta") &&
    all(r2_h_yes_fail[["weak payoffs"]] == "0") &&
    all(r2_h_yes_fail[["terminal or continuation"]] == "terminal"),
  "terminal failure pays H beta*o_theta and weak states zero"
)

reabsorbed <- history[history$history_id %in% c("G07", "G16"), , drop = FALSE]
add_check(
  "majority_h_no_reabsorbs_y",
  nrow(reabsorbed) == 2L &&
    all(reabsorbed[["destination of y"]] == "reabsorbed by proposer"),
  "current majority weak-only passage does not burn y"
)

post_optout <- history[history$history_id %in% c("G19", "G20", "G21"), , drop = FALSE]
add_check(
  "post_optout_never_reincludes_h",
  nrow(post_optout) == 3L &&
    all(post_optout[["H included?"]] == "no") &&
    all(grepl("fixed at 0", post_optout[["participation offer to H?"]])) &&
    all(post_optout[["H payoff"]] == "0 additional"),
  "after R1 opt-out, y is fixed at zero and H receives no additional flow"
)

add_check(
  "unanimity_post_optout_unreachable",
  history[history$history_id == "G21", "terminal or continuation"] ==
    "unreachable; branch ended at opt-out",
  "the original N-vote quota cannot be met by m active weak states"
)

n_grid <- 3:200
m_grid <- n_grid - 1
q_grid <- floor(n_grid / 2) + 1
add_check(
  "original_majority_quota_feasible_for_weak_only_r2",
  all(q_grid <= m_grid),
  sprintf("min(m-q)=%d over N=3,...,200", min(m_grid - q_grid))
)

set.seed(20260804)
budget_draws <- lapply(seq_len(500), function(draw_id) {
  y <- stats::runif(1, min = 0, max = 1)
  named_total <- stats::runif(1, min = 0, max = 1 - y)
  x_i_h <- 1 - y - named_total
  x_i_wo <- 1 - named_total
  data.frame(
    draw_id = draw_id,
    h_budget = y + named_total + x_i_h,
    wo_budget = named_total + x_i_wo,
    reabsorption = x_i_wo - x_i_h - y
  )
})
budget_draws <- dplyr::bind_rows(budget_draws)
budget_ok <- all(abs(budget_draws$h_budget - 1) < 1e-12) &&
  all(abs(budget_draws$wo_budget - 1) < 1e-12) &&
  all(abs(budget_draws$reabsorption) < 1e-12)
add_check(
  "budget_identities",
  budget_ok,
  "500 deterministic random draws close both budgets and reabsorb y exactly"
)

h_yes_r1 <- function(y, pass_probability, beta, continuation_value) {
  pass_probability * y +
    (1 - pass_probability) * beta * continuation_value
}
o_example <- 0.4
y_example <- 0.55
beta_example <- 0.8
continuation_example <- 0.7
direct_difference <- h_yes_r1(
  y_example,
  pass_probability = 1,
  beta = beta_example,
  continuation_value = continuation_example
) - o_example
non_direct_difference <- h_yes_r1(
  y_example,
  pass_probability = 0.35,
  beta = beta_example,
  continuation_value = continuation_example
) - o_example
add_check(
  "direct_cutoff_only_under_certain_implementation",
  abs(direct_difference - (y_example - o_example)) < 1e-12 &&
    abs(non_direct_difference - (y_example - o_example)) > 1e-6,
  sprintf(
    "p=1 difference=%.6f; p=.35 expected-IC difference=%.6f",
    direct_difference,
    non_direct_difference
  )
)

required_rmd_markers <- c(
  "pi_H=0",
  "b_0=b_1=0",
  "EU_H^R(N\\mid\\theta,h)=o_\\theta",
  "weak-vote-passive assessment",
  "not a global voting rule",
  "original \\(q\\)",
  "Independent Gate 0 verdict"
)
for (marker in required_rmd_markers) {
  add_check(
    paste0("rmd_marker_", gsub("[^A-Za-z0-9]+", "_", marker)),
    grepl(marker, rmd_text, fixed = TRUE),
    paste("required marker:", marker)
  )
}

add_check(
  "v6_is_not_an_rmd_output_dependency",
  !grepl(
    "(readLines|readRDS|source|child|include_graphics)\\s*\\([^)]*formal_model_v6",
    rmd_text,
    perl = TRUE
  ),
  "the autonomous laboratory does not source the target manuscript"
)

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
dir.create(dirname(log_path), recursive = TRUE, showWarnings = FALSE)
utils::write.csv(checks, output_path, row.names = FALSE, fileEncoding = "UTF-8")

finished_at <- Sys.time()
overall_pass <- all(checks$passed)
log_lines <- c(
  "Clean immediate-opt-out protocol verifier",
  paste("script:", script_name),
  paste("started_at:", format(started_at, tz = "America/Sao_Paulo")),
  paste("finished_at:", format(finished_at, tz = "America/Sao_Paulo")),
  paste("inputs:", history_path, "and", rmd_path),
  paste("checks:", nrow(checks)),
  paste("passed:", sum(checks$passed)),
  paste("failed:", sum(!checks$passed)),
  paste("status:", if (overall_pass) "PASS" else "FAIL"),
  "",
  paste(checks$check_id, ifelse(checks$passed, "PASS", "FAIL"), checks$detail, sep = " | "),
  "",
  paste(capture.output(sessionInfo()), collapse = "\n")
)
log_lines <- unlist(strsplit(log_lines, "\n", fixed = TRUE), use.names = FALSE)
log_lines <- sub("[[:blank:]]+$", "", log_lines)
writeLines(log_lines, log_path, useBytes = TRUE)

message(sprintf(
  "Protocol checks: %d/%d passed. Output: %s. Log: %s.",
  sum(checks$passed),
  nrow(checks),
  output_path,
  log_path
))

if (!overall_pass) {
  failed_ids <- checks$check_id[!checks$passed]
  stop(
    paste("Mandatory protocol checks failed:", paste(failed_ids, collapse = ", ")),
    call. = FALSE
  )
}
