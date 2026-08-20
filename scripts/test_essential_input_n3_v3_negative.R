#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

negative_assert <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

negative_clone <- function(x) unserialize(serialize(x, NULL))

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
negative_assert(length(script_argument) == 1L, "Could not resolve negative-test path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

verifier_path <- file.path(repository_root, "scripts", "verify_essential_input_n3_v3.R")
oracle_path <- file.path(repository_root, "scripts", "oracle_essential_input_n3_v3.R")
candidate_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_interfaces",
  "n3_r1_majority_candidate_v3.json"
)
ledger_path <- file.path(repository_root, "model_redesign", "essential_input_n3_claim_ledger_v3.json")
derivation_path <- file.path(repository_root, "model_redesign", "essential_input_n3_r1_majority_derivation_v3.md")
n1_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_interfaces",
  "n1_r2_majority_candidate_v1.json"
)
for (path in c(verifier_path, oracle_path, candidate_path, ledger_path, derivation_path, n1_path)) {
  negative_assert(file.exists(path), paste("Missing negative-test input:", path))
}

verifier_environment <- new.env(parent = baseenv())
sys.source(verifier_path, envir = verifier_environment)
oracle_environment <- new.env(parent = baseenv())
sys.source(oracle_path, envir = oracle_environment)

n1_hash <- "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
candidate <- jsonlite::fromJSON(candidate_path, simplifyVector = FALSE)
ledger <- jsonlite::fromJSON(ledger_path, simplifyVector = FALSE)
n1 <- jsonlite::fromJSON(n1_path, simplifyVector = FALSE)
derivation_text <- verifier_environment$n3v3_read_utf8(derivation_path, "N3 v3 derivation")
canonical <- verifier_environment$n3v3_load_canonical(repository_root, n1_hash)

candidate_rejections <- 0L
ledger_rejections <- 0L
derivation_rejections <- 0L

expect_candidate_rejection <- function(label, mutation, require_oracle = TRUE) {
  altered <- mutation(negative_clone(candidate))
  structural_rejected <- inherits(
    try(
      verifier_environment$n3v3_validate_candidate_structural(altered, canonical$candidate),
      silent = TRUE
    ),
    "try-error"
  )
  negative_assert(structural_rejected, paste("Structural validator accepted:", label))
  if (require_oracle) {
    oracle_rejected <- inherits(
      try(
        oracle_environment$oracle_validate_candidate(altered, n1, n1_hash, n1_path),
        silent = TRUE
      ),
      "try-error"
    )
    negative_assert(oracle_rejected, paste("Algebraic oracle accepted:", label))
  }
  candidate_rejections <<- candidate_rejections + 1L
}

expect_ledger_rejection <- function(label, mutation) {
  altered <- mutation(negative_clone(ledger))
  rejected <- inherits(
    try(
      verifier_environment$n3v3_validate_ledger_structural(altered, canonical$ledger),
      silent = TRUE
    ),
    "try-error"
  )
  negative_assert(rejected, paste("Ledger validator accepted:", label))
  ledger_rejections <<- ledger_rejections + 1L
}

expect_derivation_rejection <- function(label, altered) {
  rejected <- inherits(
    try(verifier_environment$n3v3_validate_derivation_semantics(altered), silent = TRUE),
    "try-error"
  )
  negative_assert(rejected, paste("Derivation validator accepted:", label))
  derivation_rejections <<- derivation_rejections + 1L
}

# Findings reproduced with the external file-hash pins deliberately outside the
# validation path. Each altered object exists only in memory.
expect_candidate_rejection("C_l=999", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    weak_nonproposer_pre_recognition_expected_value$by_weak_state_l <- "C_l=999"
  x
})

expect_candidate_rejection("invalid low offer y=0, no paid weak, r_i=1", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    strategy_profile$selected_proposal_parameterization$family <-
    "For every i: y=0; every x_j=0; r_i=1."
  x
})

expect_candidate_rejection("Bayes posterior zero after positive failure", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    belief_system$published_vote_vector <-
    "For nu>0, the positive-probability failure has posterior at 0."
  x
})

expect_candidate_rejection("off-path vote posterior omitted when nu>0", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    belief_system$zero_probability_proposal_vote_vectors <-
    "Only at nu=0, eta_i(s,v) is arbitrary."
  x
})

expect_candidate_rejection("remove coverage cell", function(x) {
  x$correspondence_cells <- x$correspondence_cells[-11L]
  x
}, require_oracle = FALSE)

expect_candidate_rejection("duplicate coverage id", function(x) {
  x$correspondence_cells[[2L]]$cell_id <- x$correspondence_cells[[1L]]$cell_id
  x
}, require_oracle = FALSE)

expect_candidate_rejection("wrong frozen source hash", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    source_interface_hashes$N1 <- paste0("sha256:", strrep("0", 64))
  x
})

expect_candidate_rejection("double discount in strategy transport", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    strategy_profile$frozen_continuation$transport_to_R1 <- "weak beta^2/m"
  x
}, require_oracle = FALSE)

expect_candidate_rejection("erase nonpivotal y", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    strategy_profile$ballot_map_after_every_feasible_proposal$
    hegemon_if_k_at_least_q_minus_1 <- "no pays o_theta"
  x
}, require_oracle = FALSE)

expect_candidate_rejection("select deliberate failure", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    strategy_profile$candidate_payoffs_in_primitives$
    exclusion_minus_deliberate_failure <- "0"
  x
}, require_oracle = FALSE)

expect_candidate_rejection("erase screening delay", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    outcome_distribution$delay <- 0L
  x
})

expect_candidate_rejection("collapse proposer identities", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    selection_status <- "omega is symmetric across proposer identities"
  x
}, require_oracle = FALSE)

expect_candidate_rejection("schema laundering", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    unauthorized_field <- "new schema"
  x
}, require_oracle = FALSE)

expect_ledger_rejection("double-discount claim", function(x) {
  x$claims[[1L]]$claim <- "N1 is multiplied by beta twice, producing beta^2/m."
  x
})

expect_ledger_rejection("false branch", function(x) {
  x$claims[[8L]]$branch <- "selected deliberate failure"
  x
})

expect_ledger_rejection("claim omitted", function(x) {
  x$claims <- x$claims[-17L]
  x
})

expect_ledger_rejection("claim status weakened", function(x) {
  x$claims[[1L]]$status <- "checked numerically"
  x
})

expect_ledger_rejection("equilibrium id omitted", function(x) {
  x$equilibrium_ids <- x$equilibrium_ids[-1L]
  x
})

expect_ledger_rejection("source hash changed", function(x) {
  x$source_interface$artifact_hash <- paste0("sha256:", strrep("f", 64))
  x
})

false_c06 <- gsub(
  "o mapa de respostas e outcomes induzido por N1 é\ninvariante à crença de ballot",
  "elevar r_i preserva literalmente a crença",
  derivation_text,
  fixed = TRUE
)
false_c06 <- gsub(
  "Esta prova não afirma que duas propostas públicas distintas preservam\nliteralmente a mesma crença.",
  "A prova afirma preservação literal da crença.",
  false_c06,
  fixed = TRUE
)
expect_derivation_rejection("false literal-belief preservation in C06", false_c06)

missing_offpath_derivation <- gsub(
  "Isso inclui vetores zero-probabilidade\nquando nu>0",
  "Isso inclui apenas vetores quando nu=0",
  derivation_text,
  fixed = TRUE
)
missing_offpath_derivation <- gsub(
  "Em todo assessment e para todo nu in [0,1]",
  "Somente no endpoint nu=0",
  missing_offpath_derivation,
  fixed = TRUE
)
expect_derivation_rejection("derivation omits nu>0 off-path histories", missing_offpath_derivation)

cat(
  "NEGATIVE_TESTS_REJECTED:",
  candidate_rejections,
  "candidate,",
  ledger_rejections,
  "ledger, and",
  derivation_rejections,
  "derivation mutations; pins bypassed in memory.\n"
)
