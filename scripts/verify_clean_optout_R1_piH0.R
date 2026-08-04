#!/usr/bin/env Rscript

options(warn = 1)

started_at <- Sys.time()
script_name <- "scripts/verify_clean_optout_R1_piH0.R"
output_path <- "tables/clean_optout_R1_checks_piH0.csv"
log_path <- "quality_reports/logs/verify_clean_optout_R1_piH0.log"

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
near <- function(x, y) all(abs(x - y) < tol)

grid <- expand.grid(
  n_states = 3:20,
  beta = c(0.15, 0.4, 0.7, 0.9, 0.99),
  mu = c(0.01, 0.1, 0.25, 0.5, 0.75, 0.9, 0.99),
  o0 = c(0.02, 0.1, 0.3, 0.55),
  o1 = c(0.08, 0.2, 0.5, 0.8, 0.98),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
grid <- grid[grid$o1 > grid$o0, , drop = FALSE]
grid$m <- grid$n_states - 1L
grid$P <- 1 - grid$o1
grid$D0 <- 1 - grid$o0
grid$L <- (1 - grid$mu) * grid$D0
grid$delta <- grid$beta * (grid$m - 1) / grid$m
grid$a <- 1 - grid$delta
grid$DU <- grid$D0 - grid$delta * grid$P
grid$mu_terminal <- (grid$o1 - grid$o0) / grid$D0
grid$mu_exists <- 1 - grid$a * grid$P / grid$DU
grid$GP <- grid$a * grid$P
grid$GL <- (1 - grid$mu) * grid$DU
grid$pi_low <- grid$a * grid$L
grid$pi_pool <- grid$P - grid$delta * pmax(grid$P, grid$L)
grid$local_ballot <- grid$beta * grid$o1 >= grid$o0
grid$global_exists <- grid$local_ballot & grid$GP > grid$GL

add_check(
  "regular_DU_positive",
  all(grid$DU > 0),
  sprintf("%d regular grid rows", nrow(grid))
)
add_check(
  "existence_cutoff_above_terminal_cutoff",
  all(grid$mu_exists > grid$mu_terminal),
  "mu_E>nu_2* throughout the regular domain"
)
add_check(
  "cutoff_gap_identity",
  near(
    grid$mu_exists - grid$mu_terminal,
    grid$delta * grid$P * (grid$D0 - grid$P) /
      (grid$D0 * grid$DU)
  ),
  "closed-form cutoff gap"
)
add_check(
  "security_inequality_cutoff_equivalence",
  identical(grid$GP > grid$GL, grid$mu > grid$mu_exists),
  "GP>GL iff mu>mu_E on the grid"
)
add_check(
  "low_only_shaving_gap_identity",
  near(
    grid$GL - grid$pi_low,
    (1 - grid$mu) * grid$delta * (grid$D0 - grid$P)
  ),
  "GL-pi_L=(1-mu)delta(D0-P)"
)
add_check(
  "low_only_shaving_gap_strict",
  all(grid$GL > grid$pi_low),
  "regular low-only cannot attain the off-path security payoff"
)
add_check(
  "existence_implies_pooling_terminal_regime",
  all(grid$P[grid$global_exists] > grid$L[grid$global_exists]),
  "every regular existence row has P>L"
)
add_check(
  "existence_pooling_attains_security",
  near(
    grid$pi_pool[grid$global_exists],
    grid$GP[grid$global_exists]
  ),
  "on-path pooling equals GP wherever a regular PBE exists"
)

examples <- data.frame(
  example = c(
    "regular_exists",
    "ballot_nonexistence",
    "shaving_nonexistence"
  ),
  n_states = c(5, 5, 5),
  beta = c(0.8, 0.4, 0.8),
  mu = c(0.5, 0.8, 0.1),
  o0 = c(0.1, 0.3, 0.1),
  o1 = c(0.2, 0.5, 0.2),
  expected = c(TRUE, FALSE, FALSE),
  stringsAsFactors = FALSE
)
examples$m <- examples$n_states - 1L
examples$P <- 1 - examples$o1
examples$D0 <- 1 - examples$o0
examples$delta <- examples$beta * (examples$m - 1) / examples$m
examples$a <- 1 - examples$delta
examples$DU <- examples$D0 - examples$delta * examples$P
examples$GP <- examples$a * examples$P
examples$GL <- (1 - examples$mu) * examples$DU
examples$observed <- examples$beta * examples$o1 >= examples$o0 &
  examples$GP > examples$GL
add_check(
  "named_regular_examples",
  identical(examples$observed, examples$expected),
  paste(examples$example, examples$observed, collapse = " | ")
)

tie_case <- data.frame(n_states = 5, beta = 0.8, o0 = 0.1, o1 = 0.2)
tie_case$m <- tie_case$n_states - 1L
tie_case$P <- 1 - tie_case$o1
tie_case$D0 <- 1 - tie_case$o0
tie_case$delta <- tie_case$beta * (tie_case$m - 1) / tie_case$m
tie_case$a <- 1 - tie_case$delta
tie_case$DU <- tie_case$D0 - tie_case$delta * tie_case$P
tie_case$mu <- 1 - tie_case$a * tie_case$P / tie_case$DU
tie_case$GP <- tie_case$a * tie_case$P
tie_case$GL <- (1 - tie_case$mu) * tie_case$DU
add_check(
  "strict_tie_boundary",
  near(tie_case$GP, tie_case$GL),
  "GP=GL at mu_E; the theorem correctly requires a strict inequality"
)

zero_o0 <- expand.grid(
  n_states = c(3, 5, 13),
  beta = c(0.4, 0.8),
  mu = c(0.25, 0.6, 0.9),
  o1 = c(0.2, 0.5, 0.8),
  KEEP.OUT.ATTRS = FALSE
)
zero_o0$m <- zero_o0$n_states - 1L
zero_o0$P <- 1 - zero_o0$o1
zero_o0$L <- 1 - zero_o0$mu
zero_o0$delta <- zero_o0$beta * (zero_o0$m - 1) / zero_o0$m
zero_o0$a <- 1 - zero_o0$delta
zero_o0$low_also_exists <- zero_o0$P - zero_o0$delta <=
  zero_o0$a * zero_o0$L + tol
add_check(
  "zero_o0_boundary_is_nonempty_and_classified",
  any(zero_o0$low_also_exists) && any(!zero_o0$low_also_exists),
  "the o0=0 boundary exercises both multiplicity regimes"
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
  sprintf("regular_grid_rows=%d", nrow(grid)),
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
    "R1 unanimity checks: %d/%d passed. Output: %s. Log: %s.\n",
    passed_n,
    total_n,
    output_path,
    log_path
  )
)

if (passed_n != total_n) {
  quit(status = 1L)
}
