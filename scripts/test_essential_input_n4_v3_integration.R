#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

assert_close <- function(actual, expected, message, tolerance = 1e-9) {
  assert_true(
    is.finite(actual) && is.finite(expected) && abs(actual - expected) <= tolerance,
    message
  )
}

identical_bytes <- function(path_a, path_b) {
  if (!file.exists(path_a) || !file.exists(path_b)) return(FALSE)
  size_a <- file.info(path_a)$size
  size_b <- file.info(path_b)$size
  if (!identical(size_a, size_b)) return(FALSE)
  identical(
    readBin(path_a, what = "raw", n = size_a),
    readBin(path_b, what = "raw", n = size_b)
  )
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the integration-test path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
source(file.path(repository_root, "scripts", "oracle_essential_input_n4_v3.R"))

candidate_path <- file.path(
  repository_root, "model_redesign", "essential_input_interfaces",
  "n4_r1_unanimity_candidate_v3.json"
)
ledger_path <- file.path(
  repository_root, "model_redesign", "essential_input_n4_claim_ledger_v3.json"
)
builder_path <- file.path(repository_root, "scripts", "build_essential_input_n4_v3.R")

assert_true(file.exists(candidate_path), "N4 v3 candidate is missing.")
assert_true(file.exists(ledger_path), "N4 v3 ledger is missing.")
assert_true(file.exists(builder_path), "N4 v3 builder is missing.")

# Two actual builder executions in independent R processes must reproduce the
# canonical files byte for byte. This is intentionally not two serializations
# of one in-memory object.
rscript <- file.path(R.home("bin"), "Rscript")
run_dirs <- c(tempfile("n4-v3-build-a-"), tempfile("n4-v3-build-b-"))
for (run_dir in run_dirs) dir.create(run_dir, recursive = TRUE)
on.exit(unlink(run_dirs, recursive = TRUE, force = TRUE), add = TRUE)
run_outputs <- lapply(run_dirs, function(run_dir) {
  interface_out <- file.path(run_dir, "candidate.json")
  ledger_out <- file.path(run_dir, "ledger.json")
  output <- system2(
    rscript,
    c(
      "--vanilla", builder_path,
      paste0("--interface-out=", interface_out),
      paste0("--ledger-out=", ledger_out)
    ),
    stdout = TRUE,
    stderr = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  status <- attr(output, "status")
  if (is.null(status)) status <- 0L
  assert_true(status == 0L, paste(output, collapse = "\n"))
  list(interface = interface_out, ledger = ledger_out)
})
assert_true(
  identical_bytes(run_outputs[[1L]]$interface, run_outputs[[2L]]$interface),
  "Two real builder executions produced different candidate bytes."
)
assert_true(
  identical_bytes(run_outputs[[1L]]$ledger, run_outputs[[2L]]$ledger),
  "Two real builder executions produced different ledger bytes."
)
assert_true(
  identical_bytes(run_outputs[[1L]]$interface, candidate_path),
  "Independent builder output differs from the canonical candidate."
)
assert_true(
  identical_bytes(run_outputs[[1L]]$ledger, ledger_path),
  "Independent builder output differs from the canonical ledger."
)

constant_map <- function(primitives, eta) {
  keys <- n4v3_required_failure_keys(primitives$m)
  n4v3_make_continuation_map(primitives, setNames(rep(eta, length(keys)), keys))
}

map_by_H <- function(primitives, eta_yes, eta_no) {
  keys <- n4v3_required_failure_keys(primitives$m)
  posterior <- ifelse(substr(keys, 1L, 1L) == "Y", eta_yes, eta_no)
  n4v3_make_continuation_map(primitives, setNames(posterior, keys))
}

# Universal pooling: all failure vectors use pooling, all voters say yes, and
# the package uses the exact weak floor B.
for (m in c(2, 3, 5)) {
  primitives <- list(m = m, beta = 0.9, o0 = 0.2, o1 = 0.6, y_bar = 0.8)
  d <- n4v3_derived_primitives(primitives)
  for (nu in c(0, d$nu_star, 0.75, 1)) {
    proposal <- list(
      y = d$h,
      x = rep(d$B, m - 1L),
      r = 1 - d$h - (m - 1L) * d$B
    )
    result <- n4v3_assert_valid_assessment(list(
      primitives = primitives,
      nu = nu,
      proposal = proposal,
      weak_votes = rep(TRUE, m - 1L),
      h_votes_by_type = c(theta_0 = TRUE, theta_1 = TRUE),
      ballot_belief = nu,
      on_path_proposal = TRUE,
      continuation_map = constant_map(primitives, 1)
    ))
    assert_close(result$payoffs$recognized_proposer_expected_true_prior, proposal$r,
                 "Pooling proposer payoff mismatch.")
    assert_true(all(result$outcomes$pass_with_hegemon == 1),
                "Pooling did not pass with H.")
  }
}

# Low-type-only at nu=0 is sustained at the exact endpoints Y=ell and x_j=B.
for (m in c(2, 3, 5)) {
  primitives <- list(m = m, beta = 0.9, o0 = 0.2, o1 = 0.6, y_bar = 0.8)
  d <- n4v3_derived_primitives(primitives)
  proposal <- list(
    y = d$ell,
    x = rep(d$B, m - 1L),
    r = 1 - d$ell - (m - 1L) * d$B
  )
  result <- n4v3_assert_valid_assessment(list(
    primitives = primitives,
    nu = 0,
    proposal = proposal,
    weak_votes = rep(TRUE, m - 1L),
    h_votes_by_type = c(theta_0 = TRUE, theta_1 = FALSE),
    ballot_belief = 0,
    on_path_proposal = TRUE,
    continuation_map = map_by_H(primitives, 1, 0)
  ))
  assert_close(result$payoffs$hegemon_by_type[["theta_0"]], d$ell,
               "Low-only low-type H payoff mismatch.")
  assert_close(result$payoffs$hegemon_by_type[["theta_1"]], d$h,
               "Low-only high-type H continuation mismatch.")
}

# H-veto boundaries for m=2: x=0 below nu_star, x=B at the frontier and above.
p_h <- list(m = 2, beta = 0.9, o0 = 0.2, o1 = 0.6, y_bar = 0.8)
d_h <- n4v3_derived_primitives(p_h)
h_veto_specs <- list(
  list(nu = 0.1, x = 0, y = d_h$ell / 2,
       eta = c(NN = 1, YN = 1, NY = 0.1)),
  list(nu = d_h$nu_star, x = d_h$B, y = d_h$ell / 2,
       eta = c(NN = 1, YN = 1, NY = d_h$nu_star)),
  list(nu = 0.75, x = d_h$B, y = d_h$h / 2,
       eta = c(NN = 1, YN = 1, NY = 0.75))
)
for (spec in h_veto_specs) {
  result <- n4v3_assert_valid_assessment(list(
    primitives = p_h,
    nu = spec$nu,
    proposal = list(y = spec$y, x = spec$x, r = 1 - spec$y - spec$x),
    weak_votes = TRUE,
    h_votes_by_type = c(theta_0 = FALSE, theta_1 = FALSE),
    ballot_belief = spec$nu,
    on_path_proposal = TRUE,
    continuation_map = n4v3_make_continuation_map(p_h, spec$eta)
  ))
  expected_C <- if (spec$nu <= d_h$nu_star) (1 - spec$nu) * d_h$A else d_h$B
  assert_close(result$payoffs$recognized_proposer_expected_true_prior, expected_C,
               "H-veto proposer continuation mismatch.")
}

# A single labeled weak veto at x_k<C, with all other weak responders paid C,
# is a valid on-path delay assessment.
p_single <- list(m = 3, beta = 0.9, o0 = 0.2, o1 = 0.6, y_bar = 0.8)
d_single <- n4v3_derived_primitives(p_single)
nu_single <- 0.1
C_single <- (1 - nu_single) * d_single$A
r_single <- 1 - C_single / 2 - C_single
single_result <- n4v3_assert_valid_assessment(list(
  primitives = p_single,
  nu = nu_single,
  proposal = list(y = 0, x = c(C_single / 2, C_single), r = r_single),
  weak_votes = c(FALSE, TRUE),
  h_votes_by_type = c(theta_0 = TRUE, theta_1 = TRUE),
  ballot_belief = nu_single,
  on_path_proposal = TRUE,
  continuation_map = constant_map(p_single, nu_single)
))
assert_close(single_result$payoffs$recognized_proposer_expected_true_prior, C_single,
             "Single-veto delay payoff mismatch.")

# Exact m>=3 punishment: all weak responders veto, H0=no into pooling and
# H1=yes into low-only. H=yes continuation value increases with veto count.
security_map_m3 <- function(primitives) {
  d <- n4v3_derived_primitives(primitives)
  keys <- n4v3_required_failure_keys(primitives$m)
  eta <- vapply(keys, function(key) {
    votes <- strsplit(key, "", fixed = TRUE)[[1L]]
    if (votes[[1L]] == "N") return(1)
    weak_no <- sum(votes[-1L] == "N")
    value <- d$B + (d$A - d$B) * (weak_no - 1) / (primitives$m - 2)
    1 - value / d$A
  }, numeric(1))
  n4v3_make_continuation_map(primitives, setNames(eta, keys))
}

p_sec3 <- list(m = 3, beta = 0.9, o0 = 0.2, o1 = 0.6, y_bar = 0.8)
d_sec3 <- n4v3_derived_primitives(p_sec3)
nu_sec3 <- 0.3
sec3 <- n4v3_assert_valid_assessment(list(
  primitives = p_sec3,
  nu = nu_sec3,
  proposal = list(y = 0.1, x = c(0.2, 0.2), r = 0.1),
  weak_votes = c(FALSE, FALSE),
  h_votes_by_type = c(theta_0 = FALSE, theta_1 = TRUE),
  ballot_belief = 1,
  on_path_proposal = FALSE,
  continuation_map = security_map_m3(p_sec3)
))
assert_close(
  sec3$payoffs$recognized_proposer_expected_true_prior,
  (1 - nu_sec3) * d_sec3$B,
  "Exact m>=3 security punishment payoff mismatch."
)

# m=2 security components: R_0 witnesses and the strict-capacity sequences for
# R_L and R_P are validated directly by the ballot oracle.
p_sec2 <- list(m = 2, beta = 0.9, o0 = 0.2, o1 = 0.6, y_bar = 0.8)
d_sec2 <- n4v3_derived_primitives(p_sec2)

# R_0=D<B: common low-type-only H veto at x=A.
nu_D <- 0.75
r0_D <- n4v3_assert_valid_assessment(list(
  primitives = p_sec2,
  nu = nu_D,
  proposal = list(y = d_sec2$ell / 2, x = d_sec2$A,
                  r = 1 - d_sec2$ell / 2 - d_sec2$A),
  weak_votes = TRUE,
  h_votes_by_type = c(theta_0 = FALSE, theta_1 = FALSE),
  ballot_belief = nu_D,
  on_path_proposal = FALSE,
  continuation_map = constant_map(p_sec2, 0)
))
assert_close(r0_D$payoffs$recognized_proposer_expected_true_prior,
             (1 - nu_D) * d_sec2$A, "R_0=D witness mismatch.")

# R_0=B<=D: common pooling H veto at x=A.
nu_B <- 0.1
r0_B <- n4v3_assert_valid_assessment(list(
  primitives = p_sec2,
  nu = nu_B,
  proposal = list(y = d_sec2$ell / 2, x = d_sec2$A,
                  r = 1 - d_sec2$ell / 2 - d_sec2$A),
  weak_votes = TRUE,
  h_votes_by_type = c(theta_0 = FALSE, theta_1 = FALSE),
  ballot_belief = nu_B,
  on_path_proposal = FALSE,
  continuation_map = constant_map(p_sec2, 1)
))
assert_close(r0_B$payoffs$recognized_proposer_expected_true_prior,
             d_sec2$B, "R_0=B witness mismatch.")

# R_L capacity is approached from below because x>A is strict.
epsilon <- 1e-6
Q_L <- 1 - d_sec2$ell - d_sec2$A
nu_RL <- 0.75
rl_result <- n4v3_assert_valid_assessment(list(
  primitives = p_sec2,
  nu = nu_RL,
  proposal = list(
    y = d_sec2$ell,
    x = d_sec2$A + epsilon,
    r = Q_L - epsilon
  ),
  weak_votes = TRUE,
  h_votes_by_type = c(theta_0 = TRUE, theta_1 = FALSE),
  ballot_belief = nu_RL,
  on_path_proposal = FALSE,
  continuation_map = constant_map(p_sec2, 0)
))
assert_close(
  rl_result$payoffs$recognized_proposer_expected_true_prior,
  (1 - nu_RL) * (Q_L - epsilon),
  "R_L strict-capacity sequence mismatch."
)
assert_true(
  (1 - nu_RL) * Q_L - rl_result$payoffs$recognized_proposer_expected_true_prior > 0,
  "R_L capacity was incorrectly attained at x>A."
)

# Positive R_P is approached from below by pooling passage at y=h,x>A.
Q_P <- 1 - d_sec2$h - d_sec2$A
assert_true(Q_P > 0, "R_P fixture requires a positive capacity.")
rp_result <- n4v3_assert_valid_assessment(list(
  primitives = p_sec2,
  nu = 0.5,
  proposal = list(y = d_sec2$h, x = d_sec2$A + epsilon, r = Q_P - epsilon),
  weak_votes = TRUE,
  h_votes_by_type = c(theta_0 = TRUE, theta_1 = TRUE),
  ballot_belief = 0.5,
  on_path_proposal = FALSE,
  continuation_map = constant_map(p_sec2, 1)
))
assert_close(rp_result$payoffs$recognized_proposer_expected_true_prior,
             Q_P - epsilon, "R_P strict-capacity sequence mismatch.")
assert_true(Q_P - rp_result$payoffs$recognized_proposer_expected_true_prior > 0,
            "Positive R_P was incorrectly attained at x>A.")

# Identity aggregation keeps each weak state separate and reproduces the
# approved nu=0 H-reporting coordinates without selecting a convention.
m_identity <- 3
R <- c(0.25, 0.2, 0.18)
w <- matrix(NA_real_, nrow = m_identity, ncol = m_identity)
w[1, -1] <- c(0.1, 0.12)
w[2, -2] <- c(0.15, 0.08)
w[3, -3] <- c(0.11, 0.09)
V <- vapply(seq_len(m_identity), function(k) {
  (R[[k]] + sum(w[-k, k])) / m_identity
}, numeric(1))
assert_true(length(unique(round(V, 10))) > 1L,
            "Identity-indexed weak payoffs were silently collapsed.")

rho <- c(L = 1 / 3, P = 1 / 3, D = 1 / 3)
bar_Y_L <- 0.25
bar_Y_P <- 0.55
H0 <- rho[["L"]] * bar_Y_L + rho[["P"]] * bar_Y_P + rho[["D"]] * d_sec3$ell
H1 <- (rho[["L"]] + rho[["D"]]) * d_sec3$h + rho[["P"]] * bar_Y_P
assert_close(H0, mean(c(bar_Y_L, bar_Y_P, d_sec3$ell)),
             "nu=0 H0 reporting coordinate mismatch.")
assert_close(H1, mean(c(d_sec3$h, bar_Y_P, d_sec3$h)),
             "nu=0 H1 reporting coordinate mismatch.")

# Candidate/ledger integration and exact six-cell coverage.
candidate <- jsonlite::fromJSON(candidate_path, simplifyVector = FALSE)
ledger <- jsonlite::fromJSON(ledger_path, simplifyVector = FALSE)
assert_true(identical(candidate$schema_ref, "equilibrium_correspondence_v1"),
            "Wrong N4 v3 schema.")
assert_true(length(candidate$correspondence_cells) == 6L,
            "N4 v3 must have six coverage cells.")
assert_true(all(vapply(candidate$correspondence_cells, function(cell) {
  identical(cell$existence_status, "exists") &&
    length(cell$equilibrium_records) == 1L && is.null(cell$nonexistence_certificate)
}, logical(1))), "A top-level N4 v3 cell is malformed.")
assert_true(identical(ledger$node_id, "N4"), "Ledger node mismatch.")
assert_true(length(ledger$claims) == 21L, "Ledger claim coverage mismatch.")

cat("PASS: N4 v3 independent builds, oracle witnesses, and integration\n")
