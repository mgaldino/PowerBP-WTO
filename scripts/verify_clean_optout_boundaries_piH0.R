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
near <- function(x, y) all(abs(x - y) < tol)

# Boundary A: beta<1, o0=0, interior prior.
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
zero_low$low_on_path_direct <- (1 - zero_low$mu) * (
  1 - (zero_low$m - 1) * zero_low$beta / zero_low$m
)
zero_low$pool_on_path_direct <- zero_low$P -
  (zero_low$m - 1) * zero_low$beta * zero_low$P / zero_low$m
zero_low$forced_pool_direct <- zero_low$P -
  (zero_low$m - 1) * zero_low$beta / zero_low$m
zero_low$security_direct <- pmax(
  zero_low$low_on_path_direct,
  zero_low$forced_pool_direct
)

add_check(
  "zero_low_branch_payoffs_match_reduced_forms",
  near(zero_low$low_on_path_direct, zero_low$a * zero_low$L) &&
    near(zero_low$pool_on_path_direct, zero_low$a * zero_low$P) &&
    near(zero_low$forced_pool_direct, zero_low$P - zero_low$delta),
  "three branch payoffs are built separately from offers and state weights"
)
add_check(
  "zero_low_low_class_dominates_when_L_ge_P",
  all(
    zero_low$low_on_path_direct[zero_low$L >= zero_low$P] + tol >=
      zero_low$forced_pool_direct[zero_low$L >= zero_low$P]
  ),
  "low-only attains the security value in the L>=P regime"
)
add_check(
  "zero_low_pool_class_strict_when_P_gt_L",
  all(
    zero_low$pool_on_path_direct[zero_low$P > zero_low$L] >
      zero_low$security_direct[zero_low$P > zero_low$L]
  ),
  "canonical pooling strictly beats both off-path guarantees when P>L"
)
zero_low$low_survives_direct <- zero_low$low_on_path_direct + tol >=
  zero_low$forced_pool_direct
zero_low$low_survives_reduced <- zero_low$P - zero_low$delta <=
  zero_low$a * zero_low$L + tol
add_check(
  "zero_low_multiplicity_condition",
  identical(zero_low$low_survives_direct, zero_low$low_survives_reduced) &&
    any(zero_low$low_survives_direct[zero_low$P > zero_low$L]) &&
    any(!zero_low$low_survives_direct[zero_low$P > zero_low$L]),
  "independent payoff comparison reproduces both multiplicity regimes"
)

# Boundary B: beta<1, o1=1, o0>0.
o1_one <- expand.grid(
  n_states = c(3, 5, 13),
  beta = c(0.2, 0.6, 0.9),
  mu = c(0.1, 0.5, 0.9),
  o0 = c(0.05, 0.3, 0.7),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
o1_one$m <- o1_one$n_states - 1L
o1_one$D0 <- 1 - o1_one$o0
o1_one$delta <- o1_one$beta * (o1_one$m - 1) / o1_one$m
o1_one$low_on_path <- (1 - o1_one$mu) * o1_one$D0 *
  (1 - o1_one$delta)
o1_one$low_guarantee <- (1 - o1_one$mu) * o1_one$D0
add_check(
  "o1_one_shaving_gap_positive",
  all(o1_one$low_guarantee > o1_one$low_on_path) &&
    near(
      o1_one$low_guarantee - o1_one$low_on_path,
      (1 - o1_one$mu) * o1_one$delta * o1_one$D0
    ),
  "the guarantee and on-path payoff are constructed independently"
)

# Boundary C: beta=1, including intersections with o0=0 or o1=1.
beta_one <- expand.grid(
  n_states = c(3, 4, 5, 13),
  mu = c(0.1, 0.4, 0.7, 0.95),
  o0 = c(0, 0.05, 0.2, 0.45),
  o1 = c(0.15, 0.4, 0.7, 1),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
beta_one <- beta_one[beta_one$o1 > beta_one$o0, , drop = FALSE]
beta_one$m <- beta_one$n_states - 1L
beta_one$D0 <- 1 - beta_one$o0
beta_one$P <- 1 - beta_one$o1
beta_one$L <- (1 - beta_one$mu) * beta_one$D0
beta_one$S <- pmax(beta_one$P, beta_one$L)
beta_one$delta <- (beta_one$m - 1) / beta_one$m
beta_one$rejection_by_recognition <-
  (1 / beta_one$m) * beta_one$S +
  ((beta_one$m - 1) / beta_one$m) * 0
beta_one$low_on_path_direct <- (1 - beta_one$mu) * (
  beta_one$D0 - (beta_one$m - 1) * beta_one$D0 / beta_one$m
)
beta_one$forced_pool_direct <- beta_one$P -
  (beta_one$m - 1) * beta_one$D0 / beta_one$m
beta_one$security_direct <- pmax(
  beta_one$low_on_path_direct,
  beta_one$forced_pool_direct
)

add_check(
  "beta_one_rejection_value_from_recognition",
  near(beta_one$rejection_by_recognition, beta_one$S / beta_one$m),
  "R2 recognition probability times recognized-proposer surplus gives S/m"
)
add_check(
  "beta_one_low_branch_identity",
  near(beta_one$low_on_path_direct, beta_one$L / beta_one$m),
  "current low-only offers D0/m to every non-proposer"
)
add_check(
  "beta_one_selected_classes_attain_security",
  all(
    beta_one$low_on_path_direct[beta_one$L >= beta_one$P] + tol >=
      beta_one$forced_pool_direct[beta_one$L >= beta_one$P]
  ) &&
    all(
      beta_one$P[beta_one$P > beta_one$L] /
        beta_one$m[beta_one$P > beta_one$L] >
        beta_one$security_direct[beta_one$P > beta_one$L]
    ),
  "low/rejection attain the L>=P floor; pool/rejection beat it when P>L"
)
beta_one$low_survives_direct <- beta_one$low_on_path_direct + tol >=
  beta_one$forced_pool_direct
beta_one$low_survives_reduced <- beta_one$P -
  beta_one$delta * beta_one$D0 <= beta_one$L / beta_one$m + tol
add_check(
  "beta_one_low_multiplicity_condition",
  identical(beta_one$low_survives_direct, beta_one$low_survives_reduced) &&
    any(beta_one$low_survives_direct[beta_one$P > beta_one$L]) &&
    any(!beta_one$low_survives_direct[beta_one$P > beta_one$L]),
  "branch payoff comparison reproduces both P>L low-only outcomes"
)

# Majority boundary expressions are recorded as algebraic bounds, not PBE proofs.
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
majority_boundaries$exclusion_branch <- 1 -
  majority_boundaries$k * majority_boundaries$c
majority_boundaries$low_branch <- (1 - majority_boundaries$mu) * (
  1 - majority_boundaries$o0 -
    (majority_boundaries$k - 1) * majority_boundaries$c
) + majority_boundaries$mu * majority_boundaries$c
majority_boundaries$pool_branch <- 1 - majority_boundaries$o1 -
  (majority_boundaries$k - 1) * majority_boundaries$c
majority_boundaries$floor <- pmax(
  majority_boundaries$exclusion_branch,
  majority_boundaries$low_branch,
  majority_boundaries$pool_branch
)
add_check(
  "majority_boundary_branch_bounds_smoke",
  all(is.finite(majority_boundaries$floor)) &&
    all(majority_boundaries$floor + tol >=
      majority_boundaries$exclusion_branch),
  "smoke check for three independently constructed algebraic bound branches"
)

# Degenerate priors are one-sided limits of the regular interior model.
endpoint_grid <- expand.grid(
  n_states = c(3, 4, 5, 13),
  beta = c(0.25, 0.6, 0.9),
  o0 = c(0.05, 0.2, 0.45),
  o1 = c(0.15, 0.4, 0.7, 0.95),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
endpoint_grid <- endpoint_grid[endpoint_grid$o1 > endpoint_grid$o0, , drop = FALSE]
endpoint_grid$m <- endpoint_grid$n_states - 1L
endpoint_grid$q <- floor(endpoint_grid$n_states / 2) + 1L
endpoint_grid$k <- endpoint_grid$q - 1L
endpoint_grid$c <- endpoint_grid$beta / endpoint_grid$m
endpoint_grid$D0 <- 1 - endpoint_grid$o0
endpoint_grid$P <- 1 - endpoint_grid$o1
endpoint_grid$delta <- endpoint_grid$beta *
  (endpoint_grid$m - 1) / endpoint_grid$m
endpoint_grid$a <- 1 - endpoint_grid$delta
endpoint_grid$DU <- endpoint_grid$D0 - endpoint_grid$delta * endpoint_grid$P
endpoint_grid$mu_E <- (endpoint_grid$D0 - endpoint_grid$P) /
  endpoint_grid$DU
endpoint_grid$mu_lower <- endpoint_grid$mu_E / 2
endpoint_grid$mu_upper <- (1 + endpoint_grid$mu_E) / 2
endpoint_grid$GP <- endpoint_grid$a * endpoint_grid$P
endpoint_grid$GL_lower <- (1 - endpoint_grid$mu_lower) * endpoint_grid$DU
endpoint_grid$GL_upper <- (1 - endpoint_grid$mu_upper) * endpoint_grid$DU

add_check(
  "endpoint_unanimity_lateral_sequences",
  all(endpoint_grid$GP <= endpoint_grid$GL_lower + tol) &&
    all(endpoint_grid$GP > endpoint_grid$GL_upper) &&
    all(endpoint_grid$mu_E > 0 & endpoint_grid$mu_E < 1),
  "mu_E/2 has no regular U PBE; (1+mu_E)/2 clears the payoff cutoff"
)

eps <- c(0.1, 0.01, 0.001)
limit_grid <- merge(endpoint_grid, data.frame(eps = eps), by = NULL)
limit_grid$BM_lower <- (1 - limit_grid$eps) * limit_grid$D0 +
  limit_grid$eps * limit_grid$c
limit_grid$BM_upper <- limit_grid$eps * limit_grid$D0 +
  (1 - limit_grid$eps) * limit_grid$c
add_check(
  "endpoint_majority_BM_convergence",
  near(
    abs(limit_grid$BM_lower - limit_grid$D0),
    limit_grid$eps * abs(limit_grid$c - limit_grid$D0)
  ) &&
    near(
      abs(limit_grid$BM_upper - limit_grid$c),
      limit_grid$eps * abs(limit_grid$D0 - limit_grid$c)
    ),
  "B_M approaches D0 at 0+ and c at 1- by independent substitutions"
)

n4_ties <- data.frame(beta = c(0.3, 0.6, 0.9), eps = 0.01)
n4_ties$m <- 3
n4_ties$q <- 3
n4_ties$k <- 2
n4_ties$c <- n4_ties$beta / n4_ties$m
n4_ties$E <- 1 - n4_ties$k * n4_ties$c
n4_ties$o0 <- n4_ties$k * n4_ties$c
n4_ties$D0 <- 1 - n4_ties$o0
n4_ties$BM <- (1 - n4_ties$eps) * n4_ties$D0 +
  n4_ties$eps * n4_ties$c
add_check(
  "endpoint_N4_lower_tie_points_to_exclusion",
  near(n4_ties$D0, n4_ties$E) && all(n4_ties$BM < n4_ties$E),
  "when D0=E, every positive interior epsilon has B_M<E"
)

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
dir.create(dirname(log_path), recursive = TRUE, showWarnings = FALSE)
utils::write.csv(checks, output_path, row.names = FALSE, fileEncoding = "UTF-8")

ended_at <- Sys.time()
passed_n <- sum(checks$passed)
total_n <- nrow(checks)
git_sha <- tryCatch(
  system2("git", c("rev-parse", "HEAD"), stdout = TRUE, stderr = FALSE)[1],
  error = function(e) "unavailable"
)
if (length(git_sha) == 0L || is.na(git_sha)) git_sha <- "unavailable"
session_lines <- sub("[[:space:]]+$", "", capture.output(utils::sessionInfo()))
log_lines <- c(
  sprintf("script=%s", script_name),
  sprintf("git_head_at_execution=%s", git_sha),
  sprintf("started_at=%s", format(started_at, tz = "America/Sao_Paulo")),
  sprintf("ended_at=%s", format(ended_at, tz = "America/Sao_Paulo")),
  paste0(
    "inputs=zero_low:n=3,4,5,13;beta=0.2,0.6,0.9;",
    "mu=0.1,0.4,0.7,0.95;o1=0.1,0.35,0.7,0.95;",
    "beta_one:o0=0,0.05,0.2,0.45;o1=0.15,0.4,0.7,1;",
    "endpoint_eps=0.1,0.01,0.001"
  ),
  sprintf("zero_low_rows=%d", nrow(zero_low)),
  sprintf("o1_one_rows=%d", nrow(o1_one)),
  sprintf("beta_one_rows=%d", nrow(beta_one)),
  sprintf("majority_boundary_rows=%d", nrow(majority_boundaries)),
  sprintf("endpoint_rows=%d", nrow(endpoint_grid)),
  sprintf("output=%s", output_path),
  sprintf("passed=%d", passed_n),
  sprintf("total=%d", total_n),
  sprintf("status=%s", if (passed_n == total_n) "PASS" else "FAIL"),
  sprintf(
    "failed_checks=%s",
    paste(checks$check_id[!checks$passed], collapse = ",")
  ),
  "session_info_begin",
  session_lines,
  "session_info_end"
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
