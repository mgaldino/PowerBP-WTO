# Exhaustive path-role policy for the unchanged N3 v5 public interface.
# Roles are assigned from schema position before any value is interpreted.

sr_escape_pointer <- function(value) gsub("/", "~1", gsub("~", "~0", value, fixed = TRUE), fixed = TRUE)

sr_leaf_entries <- function(object, pointer = "", keys = list(), parent_length = NA_integer_) {
  if (is.null(object)) {
    return(list(list(pointer = pointer, keys = keys, type = "null", value = NULL,
                     parent_length = parent_length)))
  }
  if (is.list(object)) {
    if (length(object) == 0L) {
      return(list(list(pointer = pointer, keys = keys, type = "empty_list", value = list(),
                       parent_length = parent_length)))
    }
    output <- list()
    object_names <- names(object)
    for (index in seq_along(object)) {
      if (is.null(object_names) || !nzchar(object_names[[index]])) {
        key <- index
        child_pointer <- paste0(pointer, "/", index - 1L)
      } else {
        key <- object_names[[index]]
        child_pointer <- paste0(pointer, "/", sr_escape_pointer(key))
      }
      output <- c(output, sr_leaf_entries(object[[index]], child_pointer,
                                           c(keys, list(key)), length(object)))
    }
    return(output)
  }
  sc_assert(length(object) == 1L, "FAIL_TYPE", paste("non-scalar leaf at", pointer))
  type <- if (is.character(object)) "string" else if (is.logical(object)) "boolean" else
    if (is.integer(object)) "integer" else if (is.numeric(object)) "number" else typeof(object)
  list(list(pointer = pointer, keys = keys, type = type, value = object,
            parent_length = parent_length))
}

sr_named_keys <- function(entry) {
  values <- unlist(entry$keys)
  values[!grepl("^[0-9]+$", values)]
}

sr_has <- function(entry, name) name %in% sr_named_keys(entry)
sr_last_named <- function(entry) tail(sr_named_keys(entry), 1L)
sr_leaf_index <- function(entry) {
  value <- tail(entry$keys, 1L)[[1L]]
  if (is.numeric(value)) as.integer(value) else NA_integer_
}

sr_cell_index <- function(entry) {
  keys <- entry$keys
  marker <- which(vapply(keys, function(value) is.character(value) &&
                          identical(value, "correspondence_cells"), logical(1)))
  sc_assert(length(marker) == 1L && marker + 1L <= length(keys) && is.numeric(keys[[marker + 1L]]),
            "FAIL_COVERAGE", paste("cannot resolve cell ordinal for", entry$pointer))
  as.integer(keys[[marker + 1L]])
}

sr_candidate_role <- function(entry) {
  named <- sr_named_keys(entry)
  last <- sr_last_named(entry)

  if (identical(entry$pointer, "/schema_ref") || identical(entry$pointer, "/function_of/name")) {
    return("structural")
  }
  if (identical(entry$pointer, "/function_of/domain")) return("exact_math")

  if (last %in% c("cell_id", "existence_status", "nonexistence_certificate",
                  "equilibrium_id", "source_continuation_record_ids", "N1", "payoff_date")) {
    return("structural")
  }

  if (last %in% c("domain_conditions", "admissibility_conditions") ||
      tail(named, 1L) %in% c("domain_conditions", "admissibility_conditions")) {
    index <- sr_leaf_index(entry)
    sc_assert(!is.na(index), "FAIL_COVERAGE", paste("missing condition ordinal at", entry$pointer))
    if (index == 8L) return("structural")
    if (last == "domain_conditions") {
      if (index %in% c(4L, 5L, 6L) || index >= 9L) return("exact_math")
      return("mixed")
    }
    # Every equilibrium record appends exactly three assessment-wide clauses.
    if (index > entry$parent_length - 3L) return("mixed")
    if (index %in% c(4L, 5L, 6L) || index >= 9L) return("exact_math")
    return("mixed")
  }

  if (last %in% c("assumptions_used", "checks_performed")) return("mixed")

  if ("proposer_payoff_after_every_feasible_proposal" %in% named) return("exact_math")
  if ("candidate_payoffs_in_primitives" %in% named) {
    if (last == "exclusion_minus_deliberate_failure") return("mixed")
    return("exact_math")
  }
  if (last == "recognized_proposer_payoff") return("exact_math")

  if ("belief_system" %in% named) return("mixed")

  if ("frozen_continuation" %in% named) {
    if (last == "source") return("structural")
    if (last %in% c("weak_value_in_R2_current_units", "theta_0", "theta_1")) return("exact_math")
    if (last %in% c("transport_to_R1", "posterior_invariance")) return("mixed")
  }

  if ("ballot_map_after_every_feasible_proposal" %in% named) return("mixed")

  if ("outcome_distribution" %in% named) {
    if (sr_cell_index(entry) == 11L && last %in% c("pass_with_hegemon", "pass_without_hegemon")) {
      return("mixed")
    }
    return("exact_math")
  }

  if ("selected_proposal_parameterization" %in% named) {
    if (last == "pure_and_mixed") return("human_review_only")
    if (last == "coalition_size") {
      # The mixed E/P cell contains two branch-specific cardinalities in prose.
      if (sr_cell_index(entry) == 11L) return("mixed")
      return("exact_math")
    }
    if (last == "family") return("mixed")
  }
  if (last == "feasibility" && "strategy_profile" %in% named) return("mixed")

  if (last == "branch_classification") return("human_review_only")
  if (last %in% c("existence_uniqueness_status", "selection_status")) return("mixed")

  if ("hegemon_payoff_by_type" %in% named) {
    if (sr_cell_index(entry) == 11L) return("mixed")
    return("exact_math")
  }

  if ("weak_nonproposer_pre_recognition_expected_value" %in% named) {
    if (last == "type") return("human_review_only")
    if (last == "by_weak_state_l") return("mixed")
  }

  sc_abort("FAIL_COVERAGE", paste("unclassified candidate leaf", entry$pointer))
}

sr_ledger_role <- function(entry) {
  named <- sr_named_keys(entry)
  if (tail(named, 1L) == "claim") {
    claim_index <- entry$keys[[which(vapply(entry$keys, is.numeric, logical(1)))[1L]]]
    mixed_claims <- c(1L, 2L, 7L, 8L, 11L, 17L)
    return(if (as.integer(claim_index) %in% mixed_claims) "mixed" else "human_review_only")
  }
  "structural"
}

sr_assign_roles <- function(object, source_type = c("candidate", "ledger")) {
  source_type <- match.arg(source_type)
  entries <- sr_leaf_entries(object)
  role_function <- if (source_type == "candidate") sr_candidate_role else sr_ledger_role
  for (index in seq_along(entries)) entries[[index]]$role <- role_function(entries[[index]])
  pointers <- vapply(entries, `[[`, character(1), "pointer")
  sc_assert(length(unique(pointers)) == length(pointers), "FAIL_COVERAGE",
            paste(source_type, "leaf pointers are not unique"))
  entries
}

sr_role_counts <- function(entries) {
  roles <- c("structural", "exact_math", "mixed", "human_review_only")
  result <- setNames(integer(length(roles)), roles)
  observed <- table(vapply(entries, `[[`, character(1), "role"))
  result[names(observed)] <- as.integer(observed)
  result
}

sr_check_candidate_schema <- function(candidate) {
  sc_assert(identical(names(candidate), c("schema_ref", "function_of", "correspondence_cells")),
            "FAIL_TYPE", "candidate top-level fields changed")
  sc_assert(identical(candidate$schema_ref, "equilibrium_correspondence_v1"),
            "FAIL_TYPE", "candidate schema_ref changed")
  sc_assert(length(candidate$correspondence_cells) == 11L, "FAIL_COVERAGE",
            "N3 candidate must contain eleven cells")
  record_names <- c(
    "equilibrium_id", "admissibility_conditions", "branch_classification",
    "strategy_profile", "belief_system", "source_continuation_record_ids",
    "source_interface_hashes", "existence_uniqueness_status", "selection_status",
    "assumptions_used", "checks_performed", "recognized_proposer_payoff",
    "weak_nonproposer_pre_recognition_expected_value", "hegemon_payoff_by_type",
    "outcome_distribution", "payoff_date"
  )
  for (cell in candidate$correspondence_cells) {
    sc_assert(identical(names(cell), c("cell_id", "domain_conditions", "existence_status",
                                       "equilibrium_records", "nonexistence_certificate")),
              "FAIL_TYPE", "coverage-cell fields changed")
    sc_assert(identical(cell$existence_status, "exists") &&
                length(cell$equilibrium_records) == 1L && is.null(cell$nonexistence_certificate),
              "FAIL_COVERAGE", "each current N3 cell must contain exactly one record")
    sc_assert(identical(names(cell$equilibrium_records[[1L]]), record_names),
              "FAIL_TYPE", "equilibrium record fields changed")
  }
  invisible(TRUE)
}

sr_check_ledger_schema <- function(ledger) {
  sc_assert(identical(names(ledger), c("schema_version", "node", "candidate_status",
                                       "source_interface", "equilibrium_ids", "claims")),
            "FAIL_TYPE", "ledger top-level fields changed")
  sc_assert(length(ledger$claims) == 17L, "FAIL_COVERAGE", "ledger must contain 17 claims")
  expected <- c("claim_id", "equilibrium_ids", "branch", "payoff_date", "claim", "status", "evidence")
  for (claim in ledger$claims) sc_assert(identical(names(claim), expected), "FAIL_TYPE",
                                         "ledger claim fields changed")
  invisible(TRUE)
}

sr_leaf_binding <- function(entry, source_type, segments, obligation_ref = NULL,
                            certificate_ids = character(0), machine_status) {
  list(
    source_type = source_type,
    json_pointer = entry$pointer,
    role = entry$role,
    leaf_type = entry$type,
    source_sha256 = if (entry$type == "string") sc_sha256_text(entry$value) else
      sc_sha256_text(jsonlite::toJSON(entry$value, auto_unbox = TRUE, null = "null")),
    segments = segments,
    expected_obligation_ref = obligation_ref,
    certificate_ids = as.list(certificate_ids),
    machine_status = machine_status
  )
}
