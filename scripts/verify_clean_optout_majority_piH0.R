#!/usr/bin/env Rscript

options(warn = 1)

started_at <- Sys.time()
script_name <- "scripts/verify_clean_optout_majority_piH0.R"
output_path <- "tables/clean_optout_majority_checks_piH0.csv"
log_path <- "quality_reports/logs/verify_clean_optout_majority_piH0.log"

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
  mu = c(0.01, 0.15, 0.4, 0.7, 0.95, 0.99),
  o0 = c(0.02, 0.1, 0.3, 0.55),
  o1 = c(0.08, 0.2, 0.5, 0.8, 0.98),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
grid <- grid[grid$o1 > grid$o0, , drop = FALSE]
grid$m <- grid$n_states - 1L
grid$q <- floor(grid$n_states / 2) + 1L
grid$k <- grid$q - 1L
grid$c <- grid$beta / grid$m
grid$E <- 1 - grid$k * grid$c
grid$L_total <- (1 - grid$mu) * (1 - grid$o0)
grid$B <- grid$L_total + grid$mu * grid$c
grid$P <- 1 - grid$o1
grid$F <- pmax(grid$E, grid$B, grid$P)
grid$A <- 1 - (1 - grid$mu) * grid$o0
grid$low_branch_low_state <- 1 - grid$o0 - (grid$k - 1) * grid$c
grid$low_branch_high_state <- grid$c
grid$low_candidate <- (1 - grid$mu) * grid$low_branch_low_state +
  grid$mu * grid$low_branch_high_state
grid$all_pass_small <- grid$E - (1 - grid$mu) * grid$o0

add_check(
  "quota_geometry",
  all(grid$q <= grid$m & grid$k <= grid$m - 1L),
  sprintf("%d regular majority grid rows", nrow(grid))
)
add_check(
  "paid_exclusion_is_strictly_better_than_delay",
  all(grid$E > grid$c),
  "E-c=1-qc>0 for beta<1 and q<=m"
)
add_check(
  "paid_exclusion_gap_identity",
  near(grid$E - grid$c, 1 - grid$q * grid$c),
  "E-c=1-qc"
)
add_check(
  "A_B_identity",
  near(grid$A - grid$B, grid$mu * (1 - grid$c)),
  "A-B=mu(1-c)>0"
)
add_check(
  "low_candidate_identity",
  near(
    grid$low_candidate,
    grid$B - (1 - grid$mu) * (grid$k - 1) * grid$c
  ),
  "branch-by-branch payoff equals the reduced expression"
)
add_check(
  "low_candidate_strictly_below_B_when_k_gt_1",
  all(grid$low_candidate[grid$k > 1] < grid$B[grid$k > 1]) &&
    near(grid$low_candidate[grid$k == 1], grid$B[grid$k == 1]),
  "strict for k>1 and equality for k=1"
)
add_check(
  "small_all_pass_below_exclusion",
  all(grid$all_pass_small < grid$E),
  "T=E-(1-mu)o0<E in the regular domain"
)
add_check(
  "security_floor_range",
  all(grid$F > 0 & grid$F <= 1),
  "0<F_M<=1"
)

n4 <- grid[grid$n_states == 4, , drop = FALSE]
n4$exists <- n4$E >= n4$B | n4$P > n4$B
n4$nonexists <- n4$B > n4$E & n4$B >= n4$P
add_check(
  "N4_existence_complement",
  all(xor(n4$exists, n4$nonexists)),
  "N=4 existence and nonexistence regions are exact complements"
)

examples <- data.frame(
  example = c("N4_strict_nonexistence", "N4_tie_nonexistence", "N4_pooling"),
  n_states = 4L,
  beta = 0.9,
  mu = 0.5,
  o0 = 0.1,
  o1 = c(0.8, 0.4, 0.2),
  expected_exists = c(FALSE, FALSE, TRUE),
  stringsAsFactors = FALSE
)
examples$m <- 3
examples$q <- 3
examples$k <- 2
examples$c <- examples$beta / examples$m
examples$E <- 1 - examples$k * examples$c
examples$B <- (1 - examples$mu) * (1 - examples$o0) +
  examples$mu * examples$c
examples$P <- 1 - examples$o1
examples$observed_exists <- examples$E >= examples$B |
  examples$P > examples$B
add_check(
  "N4_named_examples",
  identical(examples$observed_exists, examples$expected_exists),
  paste(examples$example, examples$observed_exists, collapse = " | ")
)
add_check(
  "N4_tie_example_is_exact",
  near(examples$B[2], examples$P[2]) &&
    examples$B[2] > examples$E[2],
  "B=P>E in the named tie case"
)

no_cheap <- grid[grid$o0 >= grid$k * grid$c, , drop = FALSE]
add_check(
  "strong_no_cheap_implies_E_ge_B",
  nrow(no_cheap) > 0L && all(no_cheap$E + tol >= no_cheap$B),
  "o0>=kc implies E>=B uniformly over mu"
)
add_check(
  "strong_no_cheap_implies_E_gt_P",
  nrow(no_cheap) > 0L && all(no_cheap$E > no_cheap$P),
  "o1>o0>=kc implies E>P"
)

endpoint_grid <- expand.grid(
  n_states = 3:20,
  beta = c(0.2, 0.7, 0.99),
  o0 = c(0.05, 0.3, 0.7),
  KEEP.OUT.ATTRS = FALSE
)
endpoint_grid$m <- endpoint_grid$n_states - 1L
endpoint_grid$q <- floor(endpoint_grid$n_states / 2) + 1L
endpoint_grid$k <- endpoint_grid$q - 1L
endpoint_grid$c <- endpoint_grid$beta / endpoint_grid$m
endpoint_grid$gap_mu0 <- endpoint_grid$k * endpoint_grid$c -
  endpoint_grid$o0
endpoint_grid$gap_mu1 <- endpoint_grid$q * endpoint_grid$c - 1
add_check(
  "no_cheap_endpoint_high_is_nonpositive",
  all(endpoint_grid$gap_mu1 < 0),
  "qc-1<0 for beta<1"
)

large <- grid[grid$n_states >= 5, , drop = FALSE]
large$separating_canonical <- large$A + tol >= large$F
large$separating_condition <- (1 - large$mu) * large$o0 <=
  large$k * large$c + tol
add_check(
  "large_N_separating_condition",
  identical(
    large$separating_canonical,
    large$separating_condition
  ),
  "A>=F reduces to (1-mu)o0<=kc in the regular domain"
)
add_check(
  "large_N_weak_total_bounds",
  all(large$F <= 1),
  "every canonical large-N weak total can lie within [F,1]"
)

proposal_grid <- grid
proposal_grid$X_paid <- proposal_grid$k * proposal_grid$c
proposal_grid$intermediate_low_r <- (1 - proposal_grid$mu) *
  (1 - proposal_grid$o0 - proposal_grid$X_paid) +
  proposal_grid$mu * proposal_grid$c
proposal_grid$intermediate_high_r <- 1 - proposal_grid$X_paid -
  (1 - proposal_grid$mu) * proposal_grid$o0
add_check(
  "proposal_bound_intermediate_low_r",
  all(proposal_grid$intermediate_low_r <= proposal_grid$B + tol),
  "intermediate r<=k-1 completion is bounded by B"
)
add_check(
  "proposal_bound_intermediate_high_r",
  all(proposal_grid$intermediate_high_r < proposal_grid$E),
  "intermediate r>=k completion is strictly below E"
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
    "inputs=n_states:3:20;beta:0.15,0.4,0.7,0.9,0.99;",
    "mu:0.01,0.15,0.4,0.7,0.95,0.99;",
    "o0:0.02,0.1,0.3,0.55;o1:0.08,0.2,0.5,0.8,0.98"
  ),
  sprintf("regular_grid_rows=%d", nrow(grid)),
  sprintf("proposal_bound_rows=%d", nrow(proposal_grid)),
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
    "Majority checks: %d/%d passed. Output: %s. Log: %s.\n",
    passed_n,
    total_n,
    output_path,
    log_path
  )
)

if (passed_n != total_n) {
  quit(status = 1L)
}
