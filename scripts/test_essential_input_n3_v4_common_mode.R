#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

common_assert <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

common_clone <- function(object) unserialize(serialize(object, NULL))

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
common_assert(length(script_argument) == 1L, "Could not resolve common-mode test path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

paths <- list(
  verifier = file.path(repository_root, "scripts", "verify_essential_input_n3_v4.R"),
  oracle = file.path(repository_root, "scripts", "oracle_essential_input_n3_v4.R"),
  builder = file.path(repository_root, "scripts", "build_essential_input_n3_v4.R"),
  candidate = file.path(
    repository_root,
    "model_redesign",
    "essential_input_interfaces",
    "n3_r1_majority_candidate_v4.json"
  ),
  ledger = file.path(repository_root, "model_redesign", "essential_input_n3_claim_ledger_v4.json"),
  derivation = file.path(repository_root, "model_redesign", "essential_input_n3_r1_majority_derivation_v4.md"),
  n1 = file.path(
    repository_root,
    "model_redesign",
    "essential_input_interfaces",
    "n1_r2_majority_candidate_v1.json"
  )
)
for (path in unlist(paths, use.names = FALSE)) {
  common_assert(file.exists(path), paste("Missing common-mode test input:", path))
}

verifier_environment <- new.env(parent = baseenv())
sys.source(paths$verifier, envir = verifier_environment)
oracle_environment <- new.env(parent = baseenv())
sys.source(paths$oracle, envir = oracle_environment)

candidate <- jsonlite::fromJSON(paths$candidate, simplifyVector = FALSE)
ledger <- jsonlite::fromJSON(paths$ledger, simplifyVector = FALSE)
n1 <- jsonlite::fromJSON(paths$n1, simplifyVector = FALSE)
derivation_text <- verifier_environment$n3v4_read_utf8(paths$derivation, "N3 v4 derivation")
n1_hash <- "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"

# Obtain the structural expected object from a real builder process. External
# permanent-artifact pins are intentionally not called anywhere in this suite.
temporary_root <- tempfile("n3v4-common-mode-builder-")
dir.create(temporary_root, recursive = TRUE)
on.exit(unlink(temporary_root, recursive = TRUE, force = TRUE), add = TRUE)
expected_candidate_path <- file.path(temporary_root, "candidate.json")
expected_ledger_path <- file.path(temporary_root, "ledger.json")
builder_output <- system2(
  "Rscript",
  c(
    "--vanilla",
    shQuote(paths$builder),
    shQuote(paste0("--interface-output=", expected_candidate_path)),
    shQuote(paste0("--ledger-output=", expected_ledger_path)),
    "--quiet"
  ),
  stdout = TRUE,
  stderr = TRUE
)
builder_status <- attr(builder_output, "status")
if (is.null(builder_status)) builder_status <- 0L
common_assert(
  identical(as.integer(builder_status), 0L),
  paste("Builder-equivalent fixture failed:", paste(builder_output, collapse = "\n"))
)
structural_candidate <- jsonlite::fromJSON(expected_candidate_path, simplifyVector = FALSE)
structural_ledger <- jsonlite::fromJSON(expected_ledger_path, simplifyVector = FALSE)
verifier_environment$n3v4_validate_candidate_structural(candidate, structural_candidate)
verifier_environment$n3v4_validate_ledger_structural(ledger, structural_ledger)

candidate_rejections <- 0L
ledger_rejections <- 0L
derivation_rejections <- 0L

expect_candidate_common_mode_rejection <- function(label, mutation) {
  altered_candidate <- mutation(common_clone(candidate))
  altered_structural <- mutation(common_clone(structural_candidate))
  structural_result <- try(
    verifier_environment$n3v4_validate_candidate_structural(
      altered_candidate,
      altered_structural
    ),
    silent = TRUE
  )
  common_assert(
    !inherits(structural_result, "try-error"),
    paste("Common-mode fixture did not neutralize structural comparison:", label)
  )
  oracle_rejected <- inherits(
    try(
      oracle_environment$oracle_validate_candidate(
        altered_candidate,
        n1,
        n1_hash,
        paths$n1
      ),
      silent = TRUE
    ),
    "try-error"
  )
  common_assert(oracle_rejected, paste("Independent oracle accepted common-mode corruption:", label))
  candidate_rejections <<- candidate_rejections + 1L
}

expect_ledger_common_mode_rejection <- function(label, mutation) {
  altered_ledger <- mutation(common_clone(ledger))
  altered_structural <- mutation(common_clone(structural_ledger))
  structural_result <- try(
    verifier_environment$n3v4_validate_ledger_structural(altered_ledger, altered_structural),
    silent = TRUE
  )
  common_assert(
    !inherits(structural_result, "try-error"),
    paste("Common-mode ledger fixture did not neutralize structural comparison:", label)
  )
  oracle_rejected <- inherits(
    try(oracle_environment$oracle_validate_ledger(altered_ledger, n1_hash), silent = TRUE),
    "try-error"
  )
  common_assert(oracle_rejected, paste("Independent oracle accepted common-mode ledger corruption:", label))
  ledger_rejections <<- ledger_rejections + 1L
}

expect_derivation_common_mode_rejection <- function(label, mutation) {
  altered_derivation <- mutation(derivation_text)
  altered_structural <- mutation(derivation_text)
  common_assert(
    identical(altered_derivation, altered_structural) && !identical(altered_derivation, derivation_text),
    paste("Common-mode derivation fixture failed to mutate both copies:", label)
  )
  oracle_rejected <- inherits(
    try(oracle_environment$oracle_validate_derivation(altered_derivation), silent = TRUE),
    "try-error"
  )
  common_assert(oracle_rejected, paste("Independent oracle accepted common-mode derivation corruption:", label))
  derivation_rejections <<- derivation_rejections + 1L
}

expect_candidate_common_mode_rejection("candidate payoff S(nu)", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    candidate_payoffs_in_primitives$low_type_only <- "(1-nu)*999+nu*beta/m"
  x
})

expect_candidate_common_mode_rejection("complete proposer payoff map", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    proposer_payoff_after_every_feasible_proposal$
    if_k_equals_q_minus_2_and_beta_o0_at_most_y_below_beta_o1 <- "r_i"
  x
})

expect_candidate_common_mode_rejection("weak ballot cutoff", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    ballot_map_after_every_feasible_proposal$weak_nonproposer_j <-
    "vote yes iff x_j>=0; at equality T^Y selects yes"
  x
})

expect_candidate_common_mode_rejection("H complete ballot map", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    ballot_map_after_every_feasible_proposal$hegemon_if_k_at_least_q_minus_1 <-
    "both types vote yes because passage is independent of H"
  x
})

expect_candidate_common_mode_rejection("first cell frontier", function(x) {
  x$correspondence_cells[[1L]]$domain_conditions[[10L]] <-
    "0<=nu<=beta*(o_1-o_0)/(1-beta*o_0)"
  x
})

expect_candidate_common_mode_rejection("outside-option domain endpoint", function(x) {
  x$correspondence_cells[[1L]]$domain_conditions[[9L]] <- "o_1<=1/m"
  x
})

expect_candidate_common_mode_rejection("selected low proposal", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    selected_proposal_parameterization$family <-
    "For every i: y=0; every weak nonproposer gets x_j=0; r_i=1."
  x
})

expect_candidate_common_mode_rejection("selected proposal feasibility", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$feasibility <-
    "The selected proposal may spend more than the unit pie."
  x
})

expect_candidate_common_mode_rejection("positive failure posterior", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system$
    published_vote_vector <- "For nu>0, Bayes fixes the posterior at 0."
  x
})

expect_candidate_common_mode_rejection("off-path posterior for nu>0", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system$
    zero_probability_proposal_vote_vectors <- "eta_i(s,v) is supplied only at nu=0."
  x
})

expect_candidate_common_mode_rejection("weak identity payoff", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    weak_nonproposer_pre_recognition_expected_value$by_weak_state_l <- "C_l=999"
  x
})

expect_candidate_common_mode_rejection("low-branch H payoff", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$hegemon_payoff_by_type$theta_0 <-
    "beta^2*o_0"
  x
})

expect_candidate_common_mode_rejection("mixed H coefficient retaining tokens", function(x) {
  x$correspondence_cells[[11L]]$equilibrium_records[[1L]]$hegemon_payoff_by_type$theta_0 <-
    sub(
      "o_0*sum_{K subset W\\{i}, |K|=q-1}e_{i,K}",
      "2*o_0*sum_{K subset W\\{i}, |K|=q-1}e_{i,K}",
      x$correspondence_cells[[11L]]$equilibrium_records[[1L]]$hegemon_payoff_by_type$theta_0,
      fixed = TRUE
    )
  x
})

expect_candidate_common_mode_rejection("outcome delay", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$outcome_distribution$delay <- 0L
  x
})

expect_candidate_common_mode_rejection("multiplicity and identities", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$selection_status <-
    "Only a symmetric pure coalition identity is retained."
  x
})

expect_candidate_common_mode_rejection("mixed proposer weights", function(x) {
  x$correspondence_cells[[11L]]$equilibrium_records[[1L]]$strategy_profile$
    selected_proposal_parameterization$pure_and_mixed <-
    "Every proposer must choose exclusion purely."
  x
})

expect_candidate_common_mode_rejection("continuation discount", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    frozen_continuation$transport_to_R1 <- "weak continuation beta^2/m"
  x
})

expect_candidate_common_mode_rejection("frozen N1 source", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$source_interface_hashes$N1 <-
    paste0("sha256:", strrep("0", 64))
  x
})

expect_candidate_common_mode_rejection("branch classification", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$branch_classification <-
    "deliberate failure selected"
  x
})

expect_candidate_common_mode_rejection("claim binding", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$checks_performed[[8L]] <-
    "N3V4-C08 deliberate failure is selected"
  x
})

expect_ledger_common_mode_rejection("double discount", function(x) {
  x$claims[[1L]]$claim <- "N1 is multiplied by beta twice, producing beta^2/m."
  x
})

expect_ledger_common_mode_rejection("false selected branch", function(x) {
  x$claims[[8L]]$branch <- "selected deliberate failure"
  x
})

expect_ledger_common_mode_rejection("wrong source", function(x) {
  x$source_interface$artifact_hash <- paste0("sha256:", strrep("f", 64))
  x
})

expect_derivation_common_mode_rejection("false literal-belief C06", function(text) {
  altered <- gsub(
    "o mapa de respostas e outcomes induzido por N1 é\ninvariante à crença de ballot",
    "elevar r_i preserva literalmente a crença",
    text,
    fixed = TRUE
  )
  gsub(
    "Esta prova não afirma que duas propostas públicas distintas preservam\nliteralmente a mesma crença.",
    "A prova afirma preservação literal da crença.",
    altered,
    fixed = TRUE
  )
})

cat(
  "COMMON_MODE_NEGATIVES_REJECTED:",
  candidate_rejections,
  "candidate,",
  ledger_rejections,
  "ledger, and",
  derivation_rejections,
  "derivation joint corruptions; structural expected objects were mutated identically.\n"
)
