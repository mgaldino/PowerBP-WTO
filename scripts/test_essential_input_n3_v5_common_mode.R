#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

cm5_assert <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

cm5_clone <- function(object) unserialize(serialize(object, NULL))

cm5_transform_v4_to_v5 <- function(object) {
  if (is.list(object)) {
    result <- lapply(object, cm5_transform_v4_to_v5)
    names(result) <- names(object)
    return(result)
  }
  if (!is.character(object)) return(object)
  object <- gsub("N3V4", "N3V5", object, fixed = TRUE)
  object <- gsub("n3v4", "n3v5", object, fixed = TRUE)
  object <- gsub("candidate_v4", "candidate_v5", object, fixed = TRUE)
  object <- gsub("ledger_v4", "ledger_v5", object, fixed = TRUE)
  object <- gsub("derivation_v4", "derivation_v5", object, fixed = TRUE)
  object <- gsub("claim-ledger-v4", "claim-ledger-v5", object, fixed = TRUE)
  object
}

cm5_set_at <- function(object, keys, value) {
  cm5_assert(length(keys) >= 1L, "Mutation path is empty.")
  key <- keys[[1L]]
  if (length(keys) == 1L) {
    object[[key]] <- value
    return(object)
  }
  object[[key]] <- cm5_set_at(object[[key]], keys[-1L], value)
  object
}

cm5_mutated_value <- function(entry) {
  if (identical(entry$type, "NULL") || identical(entry$type, "empty-list")) return("invalid")
  value <- entry$value
  if (is.character(value)) return("0")
  if (is.logical(value)) return(!value)
  if (is.integer(value)) return(as.integer(if (value == 999L) -999L else 999L))
  if (is.numeric(value)) return(if (value == 999) -999 else 999)
  stop(paste("Unsupported mutation type", entry$type), call. = FALSE)
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
cm5_assert(length(script_argument) == 1L, "Could not resolve N3 v5 common-mode test path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

paths <- list(
  oracle = file.path(repository_root, "scripts", "oracle_essential_input_n3_v5.R"),
  candidate = file.path(repository_root, "model_redesign", "essential_input_interfaces", "n3_r1_majority_candidate_v5.json"),
  ledger = file.path(repository_root, "model_redesign", "essential_input_n3_claim_ledger_v5.json"),
  derivation = file.path(repository_root, "model_redesign", "essential_input_n3_r1_majority_derivation_v5.md"),
  v4_candidate = file.path(repository_root, "model_redesign", "essential_input_interfaces", "n3_r1_majority_candidate_v4.json"),
  v4_ledger = file.path(repository_root, "model_redesign", "essential_input_n3_claim_ledger_v4.json"),
  n1 = file.path(repository_root, "model_redesign", "essential_input_interfaces", "n1_r2_majority_candidate_v1.json")
)
for (path in unlist(paths, use.names = FALSE)) cm5_assert(file.exists(path), paste("Missing common-mode input:", path))

oracle_environment <- new.env(parent = baseenv())
sys.source(paths$oracle, envir = oracle_environment)

candidate <- jsonlite::fromJSON(paths$candidate, simplifyVector = FALSE)
ledger <- jsonlite::fromJSON(paths$ledger, simplifyVector = FALSE)
v4_candidate <- jsonlite::fromJSON(paths$v4_candidate, simplifyVector = FALSE)
v4_ledger <- jsonlite::fromJSON(paths$v4_ledger, simplifyVector = FALSE)
n1 <- jsonlite::fromJSON(paths$n1, simplifyVector = FALSE)
derivation <- rawToChar(readBin(paths$derivation, what = "raw", n = file.info(paths$derivation)$size))
n1_hash <- "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"

structural_candidate <- cm5_transform_v4_to_v5(v4_candidate)
structural_ledger <- cm5_transform_v4_to_v5(v4_ledger)
legacy_candidate_reference <- cm5_clone(structural_candidate)
legacy_ledger_reference <- cm5_clone(structural_ledger)
cm5_assert(identical(candidate, structural_candidate), "V5 candidate is not normalized-v4 structural identity.")
cm5_assert(identical(ledger, structural_ledger), "V5 ledger is not normalized-v4 structural identity.")

candidate_entries <- oracle_environment$ov5_leaf_entries(candidate)
candidate_rejections <- 0L
candidate_acceptances <- character(0)
for (entry in candidate_entries) {
  replacement <- cm5_mutated_value(entry)
  altered <- cm5_set_at(cm5_clone(candidate), entry$keys, replacement)
  altered_structural <- cm5_set_at(cm5_clone(structural_candidate), entry$keys, replacement)
  altered_legacy <- cm5_set_at(cm5_clone(legacy_candidate_reference), entry$keys, replacement)
  cm5_assert(
    identical(altered, altered_structural) && identical(altered, altered_legacy),
    paste("Three-way candidate common-mode fixture failed at", entry$path)
  )
  rejected <- inherits(
    try(
      oracle_environment$ov5_validate_candidate_path(altered, n1, n1_hash, entry$path),
      silent = TRUE
    ),
    "try-error"
  )
  if (rejected) {
    candidate_rejections <- candidate_rejections + 1L
  } else {
    candidate_acceptances <- c(candidate_acceptances, entry$path)
  }
}
cm5_assert(
  length(candidate_acceptances) == 0L,
  paste("Semantic evaluator accepted candidate leaf mutations:", paste(candidate_acceptances, collapse = ", "))
)

ledger_entries <- oracle_environment$ov5_leaf_entries(ledger)
ledger_rejections <- 0L
ledger_acceptances <- character(0)
for (entry in ledger_entries) {
  replacement <- cm5_mutated_value(entry)
  altered <- cm5_set_at(cm5_clone(ledger), entry$keys, replacement)
  altered_structural <- cm5_set_at(cm5_clone(structural_ledger), entry$keys, replacement)
  altered_legacy <- cm5_set_at(cm5_clone(legacy_ledger_reference), entry$keys, replacement)
  cm5_assert(
    identical(altered, altered_structural) && identical(altered, altered_legacy),
    paste("Three-way ledger common-mode fixture failed at", entry$path)
  )
  rejected <- inherits(
    try(oracle_environment$ov5_validate_ledger(altered, candidate, n1_hash), silent = TRUE),
    "try-error"
  )
  if (rejected) {
    ledger_rejections <- ledger_rejections + 1L
  } else {
    ledger_acceptances <- c(ledger_acceptances, entry$path)
  }
}
cm5_assert(
  length(ledger_acceptances) == 0L,
  paste("Semantic evaluator accepted ledger leaf mutations:", paste(ledger_acceptances, collapse = ", "))
)

directed_mutations <- list(
  candidate_payoff = function(x) {
    x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$candidate_payoffs_in_primitives$low_type_only <- "(1-nu)*999+nu*beta/m"; x
  },
  proposer_map = function(x) {
    x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$proposer_payoff_after_every_feasible_proposal$if_k_equals_q_minus_2_and_beta_o0_at_most_y_below_beta_o1 <- "r_i"; x
  },
  weak_ballot = function(x) {
    x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$ballot_map_after_every_feasible_proposal$weak_nonproposer_j <- "vote yes iff x_j>=0; at equality T^Y selects yes"; x
  },
  h_ballot = function(x) {
    x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$ballot_map_after_every_feasible_proposal$hegemon_if_k_at_least_q_minus_1 <- "both types vote yes because passage is independent of H"; x
  },
  frontier = function(x) {
    x$correspondence_cells[[1L]]$domain_conditions[[10L]] <- "0<=nu<=beta*(o_1-o_0)/(1-beta*o_0)"; x
  },
  selected_proposal = function(x) {
    x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$selected_proposal_parameterization$family <- "For every i: y=0; every x_j=0; r_i=1."; x
  },
  beliefs = function(x) {
    x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system$zero_probability_proposal_vote_vectors <- "eta_i(s,v) is supplied only at nu=0."; x
  },
  weak_identity = function(x) {
    x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$weak_nonproposer_pre_recognition_expected_value$by_weak_state_l <- "C_l=999"; x
  },
  mixed_h_coefficient = function(x) {
    x$correspondence_cells[[11L]]$equilibrium_records[[1L]]$hegemon_payoff_by_type$theta_0 <- sub("o_0*sum_", "2*o_0*sum_", x$correspondence_cells[[11L]]$equilibrium_records[[1L]]$hegemon_payoff_by_type$theta_0, fixed = TRUE); x
  },
  outcome = function(x) {
    x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$outcome_distribution$delay <- 0L; x
  }
)
directed_rejections <- 0L
for (label in names(directed_mutations)) {
  mutation <- directed_mutations[[label]]
  altered <- mutation(cm5_clone(candidate))
  altered_structural <- mutation(cm5_clone(structural_candidate))
  altered_legacy <- mutation(cm5_clone(legacy_candidate_reference))
  cm5_assert(
    identical(altered, altered_structural) && identical(altered, altered_legacy),
    paste("Directed three-way fixture failed for", label)
  )
  rejected <- inherits(
    try(oracle_environment$ov5_validate_candidate(altered, n1, n1_hash), silent = TRUE),
    "try-error"
  )
  cm5_assert(rejected, paste("Semantic evaluator accepted directed common-mode corruption", label))
  directed_rejections <- directed_rejections + 1L
}

sections <- oracle_environment$ov5_claim_sections(derivation)
claim_rejections <- 0L
for (index in seq_len(17L)) {
  claim_id <- sprintf("N3V5-C%02d", index)
  original_section <- sections[[claim_id]]
  contradiction <- paste0(
    '<a id="claim-', tolower(claim_id), '"></a>\n',
    "### Claim ", claim_id, " — CONTRADICTION\n\n",
    "CONTRADICTION: the semantic claim is false.\n"
  )
  altered <- sub(original_section, contradiction, derivation, fixed = TRUE)
  altered_structural <- sub(original_section, contradiction, derivation, fixed = TRUE)
  altered_legacy <- sub(original_section, contradiction, derivation, fixed = TRUE)
  cm5_assert(
    identical(altered, altered_structural) && identical(altered, altered_legacy) && !identical(altered, derivation),
    paste("Three-way derivation fixture failed for", claim_id)
  )
  rejected <- inherits(try(oracle_environment$ov5_validate_derivation(altered), silent = TRUE), "try-error")
  cm5_assert(rejected, paste("Semantic evaluator accepted derivation contradiction", claim_id))
  claim_rejections <- claim_rejections + 1L
}

cat(
  "COMMON_MODE_EXHAUSTIVE_REJECTED:",
  candidate_rejections, "/", length(candidate_entries),
  "candidate leaves (including all 958 previously vulnerable);",
  ledger_rejections, "/", length(ledger_entries),
  "ledger leaves;",
  claim_rejections, "/17 claim contradictions;",
  directed_rejections, "/10 directed historical classes.\n"
)
