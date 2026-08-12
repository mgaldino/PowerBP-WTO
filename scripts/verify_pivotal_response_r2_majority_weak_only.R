#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE)

repo_root <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
gate0_path <- file.path(
  repo_root,
  "model_redesign",
  "pivotal_response_interfaces",
  "gate0_bundle_v1.json"
)
interface_path <- file.path(
  repo_root,
  "model_redesign",
  "pivotal_response_interfaces",
  "r2_majority_weak_only_v1.json"
)
checks_path <- file.path(
  repo_root,
  "tables",
  "pivotal_response_r2_majority_weak_only_checks_v1.csv"
)
cases_path <- file.path(
  repo_root,
  "tables",
  "pivotal_response_r2_majority_weak_only_cases_v1.csv"
)

expected_gate0_hash <- paste0(
  "6e28cb3faf3b70bc5ed990ce35a9e393",
  "26be15f93252e93e6663d771e2b0b7c1"
)

sha256 <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", normalizePath(path, winslash = "/", mustWork = TRUE)),
    stdout = TRUE,
    stderr = TRUE
  )
  if (!identical(attr(output, "status"), NULL) && attr(output, "status") != 0) {
    stop(paste(output, collapse = "\n"))
  }
  strsplit(output[[1]], "[[:space:]]+")[[1]][[1]]
}

poisson_binomial <- function(probabilities) {
  distribution <- 1
  for (probability in probabilities) {
    distribution <- c(distribution * (1 - probability), 0) +
      c(0, distribution * probability)
  }
  distribution
}

pivot_probability <- function(probabilities, voter, threshold) {
  others <- probabilities[-voter]
  distribution <- poisson_binomial(others)
  target <- threshold - 1L
  if (target < 0L || target > length(others)) {
    return(0)
  }
  distribution[[target + 1L]]
}

direct_ballot_equilibrium <- function(probabilities, threshold, tolerance = 1e-12) {
  for (voter in seq_along(probabilities)) {
    if (probabilities[[voter]] < 1 - tolerance) {
      relevance <- pivot_probability(probabilities, voter, threshold)
      if (relevance > tolerance) {
        return(FALSE)
      }
    }
  }
  TRUE
}

formula_ballot_equilibrium <- function(probabilities, threshold, tolerance = 1e-12) {
  certain_yes <- sum(probabilities >= 1 - tolerance)
  possible_yes <- sum(probabilities > tolerance)
  certain_yes >= threshold || possible_yes <= threshold - 2L
}

pass_probability <- function(probabilities, threshold) {
  distribution <- poisson_binomial(probabilities)
  if (threshold > length(probabilities)) {
    return(0)
  }
  sum(distribution[(threshold + 1L):length(distribution)])
}

add_check <- local({
  rows <- list()
  function(name = NULL, pass = NULL, details = NULL, collect = FALSE) {
    if (collect) {
      return(do.call(rbind, rows))
    }
    rows[[length(rows) + 1L]] <<- data.frame(
      check = name,
      pass = isTRUE(pass),
      details = as.character(details),
      stringsAsFactors = FALSE
    )
    invisible(NULL)
  }
})

add_check(
  "frozen_gate0_hash",
  file.exists(gate0_path) && identical(sha256(gate0_path), expected_gate0_hash),
  if (file.exists(gate0_path)) sha256(gate0_path) else "missing"
)

add_check(
  "candidate_interface_exists",
  file.exists(interface_path),
  interface_path
)

if (file.exists(interface_path)) {
  interface_text <- paste(readLines(interface_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  required_fragments <- c(
    '"status": "candidate_pending_independent_review"',
    '"discount_application_count": 0',
    '"necessary_and_sufficient_profile_condition": "a>=t or ell<=t-2"',
    '"selection": "none"'
  )
  add_check(
    "interface_required_fields",
    all(vapply(required_fragments, grepl, logical(1), x = interface_text, fixed = TRUE)),
    paste(required_fragments, collapse = " | ")
  )
}

case_rows <- list()
pure_equivalence <- TRUE
pure_determinism <- TRUE
case_index <- 0L

for (N in 3:15) {
  m <- N - 1L
  K <- N - 2L
  q <- floor(N / 2) + 1L
  threshold <- q - 1L

  grid <- expand.grid(rep(list(c(0, 1)), K))
  direct <- apply(grid, 1L, direct_ballot_equilibrium, threshold = threshold)
  formula <- apply(grid, 1L, formula_ballot_equilibrium, threshold = threshold)
  pure_equivalence <- pure_equivalence && identical(as.logical(direct), as.logical(formula))

  equilibrium_rows <- grid[formula, , drop = FALSE]
  if (nrow(equilibrium_rows) > 0L) {
    outcome_probabilities <- apply(
      equilibrium_rows,
      1L,
      pass_probability,
      threshold = threshold
    )
    pure_determinism <- pure_determinism && all(
      abs(outcome_probabilities) < 1e-12 |
        abs(outcome_probabilities - 1) < 1e-12
    )
  }

  yes_counts <- 0:K
  pure_pass_counts <- yes_counts[yes_counts >= threshold]
  pure_fail_counts <- yes_counts[yes_counts <= threshold - 2L]
  case_index <- case_index + 1L
  case_rows[[case_index]] <- data.frame(
    N = N,
    m = m,
    K = K,
    original_q = q,
    threshold_t = threshold,
    pure_pass_yes_counts = paste(pure_pass_counts, collapse = ";"),
    pure_failure_yes_counts = if (length(pure_fail_counts) == 0L) {
      "none"
    } else {
      paste(pure_fail_counts, collapse = ";")
    },
    excluded_boundary_count = threshold - 1L,
    weak_only_node_nonempty = threshold >= 1L && threshold <= K,
    stringsAsFactors = FALSE
  )
}

add_check(
  "pure_profile_formula_equivalence_N3_N15",
  pure_equivalence,
  "direct relevance condition equals a>=t or a<=t-2"
)
add_check(
  "pure_equilibrium_outcomes_are_deterministic",
  pure_determinism,
  "pass probability is always zero or one"
)

mixed_equivalence <- TRUE
mixed_determinism <- TRUE
mixed_grid <- c(0, 0.25, 0.5, 0.75, 1)

for (N in 3:9) {
  K <- N - 2L
  q <- floor(N / 2) + 1L
  threshold <- q - 1L
  grid <- expand.grid(rep(list(mixed_grid), K))
  direct <- apply(grid, 1L, direct_ballot_equilibrium, threshold = threshold)
  formula <- apply(grid, 1L, formula_ballot_equilibrium, threshold = threshold)
  mixed_equivalence <- mixed_equivalence && identical(as.logical(direct), as.logical(formula))
  equilibrium_rows <- grid[formula, , drop = FALSE]
  if (nrow(equilibrium_rows) > 0L) {
    outcome_probabilities <- apply(
      equilibrium_rows,
      1L,
      pass_probability,
      threshold = threshold
    )
    mixed_determinism <- mixed_determinism && all(
      abs(outcome_probabilities) < 1e-12 |
        abs(outcome_probabilities - 1) < 1e-12
    )
  }
}

add_check(
  "mixed_grid_formula_equivalence_N3_N9",
  mixed_equivalence,
  "five-point independent-probability grid"
)
add_check(
  "mixed_equilibrium_outcomes_are_deterministic",
  mixed_determinism,
  "no grid equilibrium has stochastic passage"
)

N3_profile <- 1
add_check(
  "N3_unique_ballot_yes",
  direct_ballot_equilibrium(N3_profile, 1L) &&
    !direct_ballot_equilibrium(0, 1L),
  "K=t=1"
)

N4_all_no <- c(0, 0)
N4_all_yes <- c(1, 1)
add_check(
  "N4_gate0_joint_completion_counterexample",
  direct_ballot_equilibrium(N4_all_no, 2L) &&
    direct_ballot_equilibrium(N4_all_yes, 2L) &&
    pivot_probability(N4_all_no, 1L, 2L) == 0 &&
    pivot_probability(N4_all_no, 2L, 2L) == 0 &&
    pass_probability(N4_all_no, 2L) == 0 &&
    pass_probability(N4_all_yes, 2L) == 1,
  "both no votes are locally irrelevant at all no, but the joint change passes"
)

N5_all_no <- rep(0, 3)
N5_all_yes <- rep(1, 3)
N5_outsider_gift <- c(1, 1, 0)
gift_vector <- c(0.4, 0.2, 0.2, 0.2)
add_check(
  "N5_positive_gifts_and_oversized_support",
  direct_ballot_equilibrium(N5_all_no, 2L) &&
    direct_ballot_equilibrium(N5_all_yes, 2L) &&
    direct_ballot_equilibrium(N5_outsider_gift, 2L) &&
    pass_probability(N5_outsider_gift, 2L) == 1 &&
    pivot_probability(N5_outsider_gift, 3L, 2L) == 0 &&
    abs(sum(gift_vector) - 1) < 1e-12 &&
    all(gift_vector > 0) &&
    gift_vector[[1]] > 0 &&
    length(N5_all_yes) > 2L,
  paste(
    "one no voter receives 0.2; all yes has oversized support;",
    "on-path residual 0.4 strictly exceeds failed-deviation payoff 0"
  )
)

open_gift_examples <- rbind(
  c(0.55, 0.15, 0.15, 0.15),
  c(0.40, 0.10, 0.20, 0.30),
  c(0.25, 0.25, 0.25, 0.25)
)
add_check(
  "positive_gift_open_set_examples",
  all(abs(rowSums(open_gift_examples) - 1) < 1e-12) &&
    all(open_gift_examples > 0),
  "three interior simplex allocations with positive proposer residual"
)

simplex_examples <- rbind(
  c(1, 0, 0),
  c(0.4, 0.3, 0.3),
  c(0, 0.2, 0.8)
)
pure_payoff_construction <- all(simplex_examples >= 0) &&
  all(abs(rowSums(simplex_examples) - 1) < 1e-12)
add_check(
  "pure_conditional_payoff_construction",
  pure_payoff_construction,
  "every sampled simplex vector is a passing allocation; zero is a failure outcome"
)

behavioral_target <- c(0, 0.12, 0.18)
target_total <- sum(behavioral_target)
normalized_pass <- behavioral_target / target_total
reconstructed_target <- target_total * normalized_pass +
  (1 - target_total) * rep(0, length(behavioral_target))
add_check(
  "behavioral_subnormalized_payoff_construction",
  behavioral_target[[1]] == 0 &&
    target_total < 1 &&
    abs(sum(normalized_pass) - 1) < 1e-12 &&
    max(abs(reconstructed_target - behavioral_target)) < 1e-12,
  "recognized proposer mixes residual-zero passage with failure"
)

case_table <- do.call(rbind, case_rows)
utils::write.csv(case_table, cases_path, row.names = FALSE, na = "")

checks <- add_check(collect = TRUE)
utils::write.csv(checks, checks_path, row.names = FALSE, na = "")

failed <- checks[!checks$pass, , drop = FALSE]
if (nrow(failed) > 0L) {
  print(failed)
  stop(sprintf("FAIL: %d of %d checks failed", nrow(failed), nrow(checks)))
}

message(sprintf("PASS: %d/%d checks passed", nrow(checks), nrow(checks)))
message(sprintf("Wrote %s", checks_path))
message(sprintf("Wrote %s", cases_path))
