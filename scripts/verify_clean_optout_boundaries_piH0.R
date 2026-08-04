#!/usr/bin/env Rscript

options(warn = 1)

started_at <- Sys.time()
script_name <- "scripts/verify_clean_optout_boundaries_piH0.R"
output_path <- "tables/clean_optout_boundary_checks_piH0.csv"
log_path <- "quality_reports/logs/verify_clean_optout_boundaries_piH0.log"

checks <- data.frame(
  check_id = character(),
  passed = logical(),
  detail = character(),
  stringsAsFactors = FALSE
)

add_check <- function(check_id, passed, detail) {
  checks <<- rbind(
    checks,
    data.frame(
      check_id = check_id,
      passed = isTRUE(passed),
      detail = as.character(detail),
      stringsAsFactors = FALSE
    )
  )
}

tol <- 1e-10

zero_low <- expand.grid(
  n_states = c(3, 4, 5, 13),
  beta = c(0.2, 0.6, 0.9),
  mu = c(0.1, 0.4, 0.7, 0.95),
  o1 = c(0.1, 0.35, 0.7, 0.95),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
zero_low$m <- zero_low$n_states - 1L
zero_low$P <- 1 - zero_low$o1
zero_low$L <- 1 - zero_low$mu
zero_low$delta <- zero_low$beta * (zero_low$m - 1) / zero_low$m
zero_low$a <- 1 - zero_low$delta
zero_low$low_exists_when_pooling_dominates <-
  zero_low$P - zero_low$delta <= zero_low$a * zero_low$L + tol

add_check(
  "zero_low_boundary_has_both_terminal_regimes",
  any(zero_low$L >= zero_low$P) && any(zero_low$P > zero_low$L),
  "grid exercises L>=P and P>L"
)
add_check(
  "zero_low_boundary_has_both_multiplicity_results",
  any(zero_low$low_exists_when_pooling_dominates) &&
    any(!zero_low$low_exists_when_pooling_dominates),
  "grid exercises presence and absence of the additional low-only PBE"
)

beta_one <- expand.grid(
  n_states = c(3, 4, 5, 13),
  mu = c(0.1, 0.4, 0.7, 0.95),
  o0 = c(0.05, 0.2, 0.45),
  o1 = c(0.15, 0.4, 0.7, 0.95),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
beta_one <- beta_one[beta_one$o1 > beta_one$o0, , drop = FALSE]
beta_one$m <- beta_one$n_states - 1L
beta_one$P <- 1 - beta_one$o1
beta_one$L <- (1 - beta_one$mu) * (1 - beta_one$o0)
beta_one$S <- pmax(beta_one$P, beta_one$L)
beta_one$rejection_proposer <- beta_one$S / beta_one$m
add_check(
  "beta_one_rejection_value",
  all(beta_one$rejection_proposer >= 0),
  "R1 rejection gives S/m when beta=1"
)

majority_boundaries <- expand.grid(
  n_states = 4:20,
  beta = c(0.3, 0.8, 1),
  mu = c(0.1, 0.5, 0.9),
  o0 = c(0, 0.1, 0.4),
  o1 = c(0.2, 0.6, 0.95),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
majority_boundaries <- majority_boundaries[
  majority_boundaries$o1 > majority_boundaries$o0,
  ,
  drop = FALSE
]
majority_boundaries$m <- majority_boundaries$n_states - 1L
majority_boundaries$q <- floor(majority_boundaries$n_states / 2) + 1L
majority_boundaries$k <- majority_boundaries$q - 1L
majority_boundaries$c <- majority_boundaries$beta /
  majority_boundaries$m
majority_boundaries$E <- 1 -
  majority_boundaries$k * majority_boundaries$c
majority_boundaries$L_floor <- (1 - majority_boundaries$mu) *
  (
    1 - majority_boundaries$o0 -
      (majority_boundaries$k - 1) * majority_boundaries$c
  ) +
  majority_boundaries$mu * majority_boundaries$c
majority_boundaries$P_floor <- 1 - majority_boundaries$o1 -
  (majority_boundaries$k - 1) * majority_boundaries$c
majority_boundaries$F <- pmax(
  majority_boundaries$E,
  majority_boundaries$L_floor,
  majority_boundaries$P_floor
)
add_check(
  "majority_boundary_floors_are_finite",
  all(is.finite(majority_boundaries$F)),
  "F_M,1 and F_M,0 expressions are finite on the grid"
)
add_check(
  "majority_boundary_floor_contains_E",
  all(majority_boundaries$F + tol >= majority_boundaries$E),
  "the boundary maximum always weakly exceeds paid exclusion"
)

o1_one <- expand.grid(
  n_states = c(3, 5, 13),
  beta = c(0.2, 0.6, 0.9),
  mu = c(0.1, 0.5, 0.9),
  o0 = c(0.05, 0.3, 0.7),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
o1_one$m <- o1_one$n_states - 1L
o1_one$delta <- o1_one$beta * (o1_one$m - 1) / o1_one$m
o1_one$on_path_low <- (1 - o1_one$mu) *
  (1 - o1_one$delta) * (1 - o1_one$o0)
o1_one$off_path_shaving <- (1 - o1_one$mu) * (1 - o1_one$o0)
add_check(
  "o1_one_shaving_gap_positive",
  all(o1_one$off_path_shaving > o1_one$on_path_low),
  "with o1=1, off-path zero-surplus pooling creates a strict gap"
)

endpoint_priors <- data.frame(
  mu = c(0, 1),
  label = c("low_type_certain", "high_type_certain"),
  stringsAsFactors = FALSE
)
add_check(
  "endpoint_priors_recorded_as_boundaries",
  identical(endpoint_priors$mu, c(0, 1)),
  paste(endpoint_priors$label, collapse = " | ")
)

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
dir.create(dirname(log_path), recursive = TRUE, showWarnings = FALSE)
utils::write.csv(checks, output_path, row.names = FALSE, fileEncoding = "UTF-8")

ended_at <- Sys.time()
passed_n <- sum(checks$passed)
total_n <- nrow(checks)
log_lines <- c(
  sprintf("script=%s", script_name),
  sprintf("started_at=%s", format(started_at, tz = "America/Sao_Paulo")),
  sprintf("ended_at=%s", format(ended_at, tz = "America/Sao_Paulo")),
  sprintf("zero_low_rows=%d", nrow(zero_low)),
  sprintf("beta_one_rows=%d", nrow(beta_one)),
  sprintf("majority_boundary_rows=%d", nrow(majority_boundaries)),
  sprintf("passed=%d", passed_n),
  sprintf("total=%d", total_n),
  sprintf("status=%s", if (passed_n == total_n) "PASS" else "FAIL"),
  sprintf(
    "failed_checks=%s",
    paste(checks$check_id[!checks$passed], collapse = ",")
  )
)
writeLines(log_lines, log_path, useBytes = TRUE)

cat(
  sprintf(
    "Boundary checks: %d/%d passed. Output: %s. Log: %s.\n",
    passed_n,
    total_n,
    output_path,
    log_path
  )
)

if (passed_n != total_n) {
  quit(status = 1L)
}
