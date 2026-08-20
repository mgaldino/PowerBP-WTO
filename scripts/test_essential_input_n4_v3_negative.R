#!/usr/bin/env Rscript

# Testes negativos e contraprovas dirigidas para o oracle independente de N4 v3.

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

assert_close <- function(actual, expected, message, tolerance = 1e-10) {
  assert_true(
    length(actual) == 1L && length(expected) == 1L &&
      is.finite(actual) && is.finite(expected) &&
      abs(actual - expected) <= tolerance,
    message
  )
}

expect_error <- function(expression, pattern, label) {
  observed <- tryCatch(
    {
      force(expression)
      NULL
    },
    error = function(error) conditionMessage(error)
  )
  assert_true(!is.null(observed), paste0("Expected rejection: ", label))
  assert_true(
    grepl(pattern, observed, fixed = TRUE),
    paste0("Wrong rejection for ", label, ": ", observed)
  )
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the test path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
source(file.path(repository_root, "scripts", "oracle_essential_input_n4_v3.R"))

make_map <- function(primitives, posterior_by_key) {
  expected <- n4v3_required_failure_keys(primitives$m)
  assert_true(
    identical(sort(names(posterior_by_key)), sort(expected)),
    "Fixture does not cover every failing ballot vector."
  )
  n4v3_make_continuation_map(primitives, posterior_by_key)
}

# The oracle must truly enumerate every simultaneous ballot and every profile
# of the other voters in each weak responder's stage-undominance problem.
for (m in 2:6) {
  ballots <- n4v3_all_ballot_vectors(m)
  assert_true(nrow(ballots) == 2^m, paste0("Incomplete ballot enumeration for m=", m, "."))
  assert_true(
    length(unique(apply(ballots, 1L, n4v3_vote_key))) == 2^m,
    paste0("Duplicated ballot vector for m=", m, ".")
  )
  assert_true(
    length(n4v3_required_failure_keys(m)) == 2^m - 1L,
    paste0("Incomplete failure history support for m=", m, ".")
  )
}

# Counterexample 1 from N4 v2 review: m=3, proposal (h,b,b,P), two weak
# vetoes. This is a valid zero-probability proposal assessment. It therefore
# rejects any validator that mechanically rules out multi-veto profiles.
p3 <- list(m = 3, beta = 0.9, o0 = 0.2, o1 = 0.6, y_bar = 0.8)
d3 <- n4v3_derived_primitives(p3)
eta3 <- c(
  NNN = 0, YNN = 1,
  NYN = 0, YYN = 1,
  NNY = 0, YNY = 1,
  NYY = 1
)
a3 <- list(
  primitives = p3,
  nu = 0.1,
  proposal = list(y = d3$h, x = c(d3$B, d3$B), r = 1 - d3$h - 2 * d3$B),
  weak_votes = c(FALSE, FALSE),
  h_votes_by_type = c(theta_0 = TRUE, theta_1 = TRUE),
  ballot_belief = 0.1,
  on_path_proposal = FALSE,
  continuation_map = make_map(p3, eta3)
)
r3 <- n4v3_assert_valid_assessment(a3)
assert_true(
  all(vapply(r3$weak_diagnostics, function(x) !x$undominated[["yes"]], logical(1))),
  "m=3 counterexample did not eliminate yes by stage-undominance."
)
assert_close(
  r3$payoffs$recognized_proposer_expected_true_prior,
  d3$B,
  "m=3 counterexample did not pay the proposer b under pooling."
)

# Counterexample 2 from N4 v2 review: m=2, proposal (h,a,F). At the actual
# H=yes profile the weak responder is indifferent, but no weakly dominates yes
# because the H=no contingency is strict. T^Y cannot resurrect eliminated yes.
p2 <- list(m = 2, beta = 0.5, o0 = 0.2, o1 = 0.6, y_bar = 0.8)
d2 <- n4v3_derived_primitives(p2)
eta2 <- c(NN = 0, YN = 0, NY = 1)
a2 <- list(
  primitives = p2,
  nu = 0.5,
  proposal = list(y = d2$h, x = d2$A, r = 1 - d2$h - d2$A),
  weak_votes = FALSE,
  h_votes_by_type = c(theta_0 = TRUE, theta_1 = TRUE),
  ballot_belief = 0.5,
  on_path_proposal = FALSE,
  continuation_map = make_map(p2, eta2)
)
r2 <- n4v3_assert_valid_assessment(a2)
assert_true(
  !r2$weak_diagnostics$W1$undominated[["yes"]] &&
    r2$weak_diagnostics$W1$undominated[["no"]],
  "m=2 counterexample did not apply stage-undominance before T^Y."
)
assert_close(
  r2$payoffs$recognized_proposer_expected_true_prior,
  (1 - a2$nu) * d2$A,
  "m=2 counterexample used a package residual instead of realized N2 payoffs."
)

# Type-conditioned accounting is read directly from N2: low-only gives each
# weak state (A,0), never the ex-ante value (1-eta)A in the realized high branch.
n2_low <- n4v3_n2_continuation(p2, 0.25)
assert_close(n2_low$weak_realized_by_type[["theta_0"]], d2$A,
             "N2 low-only low-state realized payoff mismatch.")
assert_close(n2_low$weak_realized_by_type[["theta_1"]], 0,
             "N2 low-only high-state realized payoff must be zero.")
assert_close(n2_low$weak_subjective_value, 0.75 * d2$A,
             "N2 low-only subjective value mismatch.")

# Review counterexample 3: at a high prior, an H-veto assessment with x<b is
# invalid. The weak responder must reject because no weakly dominates yes.
p_high <- list(m = 2, beta = 0.9, o0 = 0.2, o1 = 0.6, y_bar = 0.8)
d_high <- n4v3_derived_primitives(p_high)
eta_high <- setNames(rep(0.75, length(n4v3_required_failure_keys(2))),
                     n4v3_required_failure_keys(2))
a_high <- list(
  primitives = p_high,
  nu = 0.75,
  proposal = list(y = 0.2, x = d_high$B / 2, r = 1 - 0.2 - d_high$B / 2),
  weak_votes = TRUE,
  h_votes_by_type = c(theta_0 = FALSE, theta_1 = FALSE),
  ballot_belief = 0.75,
  on_path_proposal = TRUE,
  continuation_map = make_map(p_high, eta_high)
)
r_high <- n4v3_evaluate_assessment(a_high)
assert_true(!r_high$valid, "High-prior H-veto fixture with x<b was accepted.")
assert_true(
  any(grepl("Weak responder 1", r_high$errors, fixed = TRUE)),
  "High-prior H-veto fixture failed for the wrong reason."
)

# A positive-probability failure history must satisfy Bayes exactly.
bad_bayes <- a_high
bad_bayes$weak_votes <- FALSE
bad_bayes$h_votes_by_type <- c(theta_0 = TRUE, theta_1 = TRUE)
bad_bayes$proposal <- list(y = d_high$h, x = d_high$B, r = 1 - d_high$h - d_high$B)
bad_bayes$continuation_map <- make_map(
  p_high,
  setNames(rep(1, length(n4v3_required_failure_keys(2))),
           n4v3_required_failure_keys(2))
)
r_bayes <- n4v3_evaluate_assessment(bad_bayes)
assert_true(
  any(grepl("Bayes violation", r_bayes$errors, fixed = TRUE)),
  "The oracle accepted a wrong posterior at an on-path failure vector."
)

# Coverage and schema corruptions must fail before equilibrium evaluation.
missing_map <- a2
missing_map$continuation_map[[1L]] <- NULL
expect_error(
  n4v3_evaluate_assessment(missing_map),
  "every and only failing ballot vector",
  "missing public failure vector"
)

wrong_record <- a2
wrong_record$continuation_map$YN$record_id <- "N2-EQ-POOLING"
expect_error(
  n4v3_evaluate_assessment(wrong_record),
  "record inconsistent with its posterior",
  "N2 record inconsistent with posterior"
)

extra_primitive <- a2
extra_primitive$primitives$new_rule <- TRUE
expect_error(
  n4v3_evaluate_assessment(extra_primitive),
  "Primitives must contain exactly",
  "unauthorized primitive"
)

cat("PASS: N4 v3 independent-oracle counterexamples and negative fixtures\n")
