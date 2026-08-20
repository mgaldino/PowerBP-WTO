# Independent semantic validator library for N4 v3.
#
# This file does not source the builder and does not construct the candidate.
# It binds the exported schema to an independently coded set of semantic
# invariants. The executable verifier adds byte pins and full leaf manifests.

n4v3_semantic_errors <- function() character(0)

n4v3_add_error <- function(errors, condition, message) {
  if (!isTRUE(condition)) c(errors, message) else errors
}

n4v3_character_values <- function(x) {
  as.character(unlist(x, recursive = TRUE, use.names = FALSE))
}

n4v3_named_exactly <- function(x, expected) {
  is.list(x) && identical(sort(names(x)), sort(expected))
}

n4v3_contains <- function(x, value) {
  any(n4v3_character_values(x) == value)
}

n4v3_flatten_leaves <- function(object, path = "$") {
  rows <- list()
  recurse <- function(value, current_path) {
    if (is.null(value)) {
      rows[[length(rows) + 1L]] <<- data.frame(
        path = current_path, value = "<NULL>", stringsAsFactors = FALSE
      )
      return(invisible(NULL))
    }
    if (is.list(value)) {
      if (length(value) == 0L) {
        rows[[length(rows) + 1L]] <<- data.frame(
          path = current_path, value = "<EMPTY_LIST>", stringsAsFactors = FALSE
        )
        return(invisible(NULL))
      }
      value_names <- names(value)
      if (!is.null(value_names) && all(nzchar(value_names))) {
        for (name in value_names) recurse(value[[name]], paste0(current_path, ".", name))
      } else {
        for (index in seq_along(value)) {
          recurse(value[[index]], paste0(current_path, "[", index, "]"))
        }
      }
      return(invisible(NULL))
    }
    if (length(value) != 1L) {
      for (index in seq_along(value)) {
        recurse(value[[index]], paste0(current_path, "[", index, "]"))
      }
      return(invisible(NULL))
    }
    encoded <- if (is.logical(value)) {
      if (is.na(value)) "<NA_LOGICAL>" else if (value) "true" else "false"
    } else if (is.numeric(value)) {
      if (is.na(value)) "<NA_NUMERIC>" else format(value, digits = 17, scientific = FALSE)
    } else {
      enc2utf8(as.character(value))
    }
    rows[[length(rows) + 1L]] <<- data.frame(
      path = current_path, value = encoded, stringsAsFactors = FALSE
    )
    invisible(NULL)
  }
  recurse(object, path)
  do.call(rbind, rows)
}

n4v3_candidate_path_category <- function(path) {
  if (grepl("^\\$\\.(schema_ref|function_of)", path)) return("candidate_header")
  if (grepl("\\.strategy_profile\\.frozen_continuation", path)) return("strategy_frozen_continuation")
  if (grepl("\\.strategy_profile\\.derived_quantities", path)) return("strategy_derived_quantities")
  if (grepl("\\.strategy_profile\\.independent_ballot_oracle", path)) return("strategy_ballot_oracle")
  if (grepl("\\.strategy_profile\\.exact_proposer_security", path)) return("strategy_security")
  if (grepl("\\.strategy_profile\\.ballot_response_map", path)) return("strategy_ballot_map")
  if (grepl("\\.strategy_profile\\.branch_candidate_coverage", path)) return("strategy_branch_coverage")
  if (grepl("\\.strategy_profile\\.pooling_family", path)) return("strategy_pooling")
  if (grepl("\\.strategy_profile\\.low_type_only_family", path)) return("strategy_low_only")
  if (grepl("\\.strategy_profile\\.delay_family", path)) return("strategy_delay")
  if (grepl("\\.strategy_profile\\.proposal_mixing", path)) return("strategy_mixing")
  if (grepl("\\.strategy_profile\\.proposer_identity_completion", path)) return("strategy_identity")
  if (grepl("\\.strategy_profile\\.nu0_reporting", path)) return("strategy_nu0_reporting")
  if (grepl("\\.strategy_profile\\.downstream_transport", path)) return("strategy_transport")
  if (grepl("\\.belief_system", path)) return("belief_system")
  if (grepl("\\.source_(continuation_record_ids|interface_hashes)", path)) return("record_sources")
  if (grepl("\\.(existence_uniqueness_status|selection_status)$", path)) return("record_status_selection")
  if (grepl("\\.(assumptions_used|checks_performed)", path)) return("record_assumptions_checks")
  if (grepl("\\.recognized_proposer_payoff", path)) return("record_proposer_payoff")
  if (grepl("\\.weak_nonproposer_pre_recognition_expected_value", path)) return("record_weak_payoff")
  if (grepl("\\.hegemon_payoff_by_type", path)) return("record_hegemon_payoff")
  if (grepl("\\.outcome_distribution", path)) return("record_outcome")
  if (grepl("\\.payoff_date$", path)) return("record_payoff_date")
  if (grepl("\\.equilibrium_records\\[[0-9]+\\]\\.(equilibrium_id|admissibility_conditions|branch_classification)", path)) return("record_identity_domain")
  if (grepl("\\.correspondence_cells\\[[0-9]+\\]\\.(cell_id|domain_conditions)", path)) return("cell_identity_domain")
  if (grepl("\\.correspondence_cells\\[[0-9]+\\]\\.(existence_status|nonexistence_certificate)", path)) return("cell_existence")
  NA_character_
}

n4v3_ledger_path_category <- function(path) {
  if (grepl("^\\$\\.(ledger_schema|node_id|artifact_path|artifact_hash|cold_note_path|cold_note_hash|node_status)$", path)) return("ledger_header")
  if (grepl("\\.claims\\[[0-9]+\\]\\.(claim_id|equilibrium_ids|branch|payoff_date|status)", path)) return("ledger_claim_identity")
  if (grepl("\\.claims\\[[0-9]+\\]\\.(claim|evidence)$", path)) return("ledger_claim_content")
  NA_character_
}

n4v3_audit_path_coverage <- function(object, artifact = c("candidate", "ledger")) {
  artifact <- match.arg(artifact)
  leaves <- n4v3_flatten_leaves(object)
  categorizer <- if (artifact == "candidate") {
    n4v3_candidate_path_category
  } else {
    n4v3_ledger_path_category
  }
  leaves$category <- vapply(leaves$path, categorizer, character(1))
  list(
    valid = !anyNA(leaves$category),
    uncovered = leaves[is.na(leaves$category), , drop = FALSE],
    leaves = leaves
  )
}

n4v3_validate_formula_grid <- function(tolerance = 1e-10) {
  errors <- character(0)
  for (m in 2:6) {
    for (beta in c(0.1, 0.5, 0.9, 0.99)) {
      for (o0 in c(0.02, 0.25, 0.7)) {
        for (o1 in c((1 + o0) / 2, 0.98)) {
          if (o1 <= o0 || o1 >= 1) next
          nu_star <- (o1 - o0) / (1 - o0)
          ell <- beta * o0
          h <- beta * o1
          A <- beta * (1 - o0) / m
          B <- beta * (1 - o1) / m
          for (nu in unique(c(0, nu_star / 2, nu_star, (1 + nu_star) / 2, 1))) {
            D <- (1 - nu) * A
            C <- if (nu <= nu_star) D else B
            P_cap <- 1 - h - (m - 1) * B
            if (abs((P_cap - B) - (1 - beta)) > tolerance) {
              errors <- c(errors, "Independent P_cap-B identity failed.")
            }
            if (m >= 3) {
              S <- (1 - nu) * B
              if (!(S < P_cap - tolerance && C > S + tolerance)) {
                errors <- c(errors, "Independent m>=3 security/delay inequality failed.")
              }
            } else {
              Q_L <- 1 - ell - A
              Q_P <- 1 - h - A
              R_0 <- min(D, B)
              R_L <- min((1 - nu) * Q_L, B)
              R_P <- max(0, Q_P)
              S <- max(R_0, R_L, R_P)
              if (!(Q_L > 0 && S < P_cap - tolerance)) {
                errors <- c(errors, "Independent m=2 capacity/security inequality failed.")
              }
              reduced <- if (nu <= nu_star) D >= R_P - tolerance else B >= R_P - tolerance
              if (!identical(C >= S - tolerance, reduced)) {
                errors <- c(errors, "Independent m=2 delay equivalence failed.")
              }
            }
          }
        }
      }
    }
  }
  unique(errors)
}

n4v3_validate_candidate_semantics <- function(candidate, ledger = NULL, builder_text = NULL) {
  errors <- character(0)
  n2_hash <- "sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2"
  expected_cell_ids <- c(
    "N4V3-CELL-M2-NU0", "N4V3-CELL-M2-LOW", "N4V3-CELL-M2-HIGH",
    "N4V3-CELL-MGE3-NU0", "N4V3-CELL-MGE3-LOW", "N4V3-CELL-MGE3-HIGH"
  )
  expected_eq_ids <- sub("CELL", "EQ", expected_cell_ids, fixed = TRUE)
  expected_record_fields <- c(
    "equilibrium_id", "admissibility_conditions", "branch_classification",
    "strategy_profile", "belief_system", "source_continuation_record_ids",
    "source_interface_hashes", "existence_uniqueness_status", "selection_status",
    "assumptions_used", "checks_performed", "recognized_proposer_payoff",
    "weak_nonproposer_pre_recognition_expected_value", "hegemon_payoff_by_type",
    "outcome_distribution", "payoff_date"
  )
  expected_strategy_fields <- c(
    "frozen_continuation", "derived_quantities", "independent_ballot_oracle",
    "exact_proposer_security", "ballot_response_map_after_every_feasible_proposal",
    "branch_candidate_coverage", "pooling_family", "low_type_only_family",
    "delay_family", "proposal_mixing", "proposer_identity_completion",
    "nu0_reporting", "downstream_transport"
  )
  expected_belief_fields <- c(
    "entry", "positive_weight_proposal", "weak_action_passivity", "public_H_vote",
    "on_path_delay", "zero_weight_proposal", "zero_probability_failure_vector",
    "zero_prior_types", "completeness"
  )

  errors <- n4v3_add_error(
    errors,
    n4v3_named_exactly(candidate, c("schema_ref", "function_of", "correspondence_cells")),
    "Wrong candidate top-level schema."
  )
  if (!is.list(candidate)) return(unique(errors))
  errors <- n4v3_add_error(errors, identical(candidate$schema_ref, "equilibrium_correspondence_v1"), "Wrong schema_ref.")
  errors <- n4v3_add_error(errors, identical(candidate$function_of$name, "entry_belief"), "Wrong function_of name.")
  errors <- n4v3_add_error(errors, identical(candidate$function_of$domain, "[0,1]"), "Wrong function_of domain.")
  errors <- n4v3_add_error(errors, length(candidate$correspondence_cells) == 6L, "Candidate must have six cells.")

  candidate_text <- paste(n4v3_character_values(candidate), collapse = "\n")
  required_global <- c(
    "nu_star=(o_1-o_0)/(1-o_0); ell=beta*o_0; h=beta*o_1; A=beta*(1-o_0)/m; B=beta*(1-o_1)/m",
    "D=(1-nu)*A; C=D when nu<=nu_star and C=B when nu>nu_star",
    "S_3(nu)=(1-nu)*B",
    "S_2(nu)=max{R_0(nu),R_L(nu),R_P}",
    "for nu<1 attained iff (1-nu)*Q_L>B, and at equality or below only a supremum; at nu=1 its zero value is attained",
    "The oracle neither reads the N4 candidate nor imports any candidate security formula.",
    "eliminate weakly dominated actions before sequential best response and T^Y",
    "Every positive-probability failure vector under an on-path proposal receives its exact Bayes posterior",
    "The proposer payoff uses N2 realized payoffs by theta and the true nu, never the ballot belief.",
    "The full Cartesian product across identities is retained.",
    "For every assessment define rho_c=(1/m)*sum_i Pr_i(c)",
    "Identity permutations may be collapsed only downstream for an exactly equal H-payoff vector",
    "equality of the budget is not imposed"
  )
  for (anchor in required_global) {
    errors <- n4v3_add_error(
      errors, grepl(anchor, candidate_text, fixed = TRUE),
      paste0("Missing independent semantic anchor: ", anchor)
    )
  }
  forbidden_global <- c(
    "S_m=min{P,D}", "S_2=max{F,K,M}", "F=1-h-A",
    "forces both voters to yes", "multi-veto delay is impossible",
    "symmetry is imposed", "T^Y before stage-undominance"
  )
  for (forbidden in forbidden_global) {
    errors <- n4v3_add_error(
      errors, !grepl(forbidden, candidate_text, fixed = TRUE),
      paste0("Forbidden obsolete/corrupt semantic leaf: ", forbidden)
    )
  }

  if (length(candidate$correspondence_cells) == 6L) {
    observed_cell_ids <- vapply(candidate$correspondence_cells, `[[`, character(1), "cell_id")
    errors <- n4v3_add_error(errors, identical(observed_cell_ids, expected_cell_ids), "Cell partition/ordering changed.")
    for (index in seq_along(candidate$correspondence_cells)) {
      cell <- candidate$correspondence_cells[[index]]
      errors <- n4v3_add_error(
        errors,
        n4v3_named_exactly(cell, c(
          "cell_id", "domain_conditions", "existence_status",
          "equilibrium_records", "nonexistence_certificate"
        )),
        paste0("Malformed coverage cell ", index, ".")
      )
      errors <- n4v3_add_error(errors, identical(cell$existence_status, "exists"), paste0("Cell ", index, " must exist."))
      errors <- n4v3_add_error(errors, length(cell$equilibrium_records) == 1L, paste0("Cell ", index, " must have one parametric record."))
      errors <- n4v3_add_error(errors, is.null(cell$nonexistence_certificate), paste0("Cell ", index, " has a spurious top-level none certificate."))
      if (length(cell$equilibrium_records) != 1L) next
      record <- cell$equilibrium_records[[1L]]
      errors <- n4v3_add_error(errors, n4v3_named_exactly(record, expected_record_fields), paste0("Wrong record fields in cell ", index, "."))
      errors <- n4v3_add_error(errors, identical(record$equilibrium_id, expected_eq_ids[[index]]), paste0("Wrong equilibrium_id in cell ", index, "."))
      errors <- n4v3_add_error(errors, n4v3_named_exactly(record$strategy_profile, expected_strategy_fields), paste0("Wrong strategy fields in cell ", index, "."))
      errors <- n4v3_add_error(errors, n4v3_named_exactly(record$belief_system, expected_belief_fields), paste0("Wrong belief fields in cell ", index, "."))
      errors <- n4v3_add_error(
        errors,
        identical(n4v3_character_values(record$source_continuation_record_ids), c("N2-EQ-LOW-TYPE-ONLY", "N2-EQ-POOLING")),
        paste0("Wrong N2 source records in cell ", index, ".")
      )
      errors <- n4v3_add_error(errors, identical(record$source_interface_hashes$N2, n2_hash), paste0("Wrong N2 hash in cell ", index, "."))
      errors <- n4v3_add_error(errors, length(record$checks_performed) == 21L, paste0("Incomplete claim checks in cell ", index, "."))
      errors <- n4v3_add_error(errors, n4v3_named_exactly(record$hegemon_payoff_by_type, c("theta_0", "theta_1")), paste0("Wrong H payoff coordinates in cell ", index, "."))
      errors <- n4v3_add_error(errors, n4v3_named_exactly(record$outcome_distribution, c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")), paste0("Wrong outcome coordinates in cell ", index, "."))
      errors <- n4v3_add_error(errors, identical(record$outcome_distribution$pass_without_hegemon, "0"), paste0("Pass-without-H must be zero in cell ", index, "."))
      errors <- n4v3_add_error(errors, identical(record$outcome_distribution$failure, "0"), paste0("R1 terminal failure must be zero in cell ", index, "."))

      m2 <- grepl("-M2-", cell$cell_id, fixed = TRUE)
      nu0 <- grepl("-NU0", cell$cell_id, fixed = TRUE)
      low <- grepl("-LOW", cell$cell_id, fixed = TRUE)
      high <- grepl("-HIGH", cell$cell_id, fixed = TRUE)
      security <- record$strategy_profile$exact_proposer_security
      coverage <- record$strategy_profile$branch_candidate_coverage
      pooling <- record$strategy_profile$pooling_family
      low_family <- record$strategy_profile$low_type_only_family
      delay <- record$strategy_profile$delay_family

      expected_security <- if (m2) "S_2(nu)=max{R_0(nu),R_L(nu),R_P}" else "S_3(nu)=(1-nu)*B"
      errors <- n4v3_add_error(errors, identical(security$formula, expected_security), paste0("Wrong security in cell ", index, "."))
      if (m2) {
        errors <- n4v3_add_error(errors, identical(sort(names(security$components)), c("R_0", "R_L", "R_P")), paste0("Wrong m=2 security components in cell ", index, "."))
        errors <- n4v3_add_error(errors, grepl("supremum", security$topology, fixed = TRUE), paste0("Missing m=2 supremum topology in cell ", index, "."))
        errors <- n4v3_add_error(errors, identical(coverage$delay$status_rule, "conditional"), paste0("Wrong m=2 delay status in cell ", index, "."))
        errors <- n4v3_add_error(errors, identical(coverage$delay$exists_when, "C>=S_2"), paste0("Wrong m=2 delay boundary in cell ", index, "."))
        errors <- n4v3_add_error(errors, identical(coverage$at_least_two_weak_vetoes$status_rule, "none"), paste0("m=2 cannot have two weak vetoes in cell ", index, "."))
        errors <- n4v3_add_error(errors, grepl("H_tie", pooling$proposer_residual_rule$equality, fixed = TRUE), paste0("Missing m=2 pooling H_tie in cell ", index, "."))
      } else {
        errors <- n4v3_add_error(errors, identical(security$topology, "attained maximum guarantee"), paste0("Wrong m>=3 attainment in cell ", index, "."))
        errors <- n4v3_add_error(errors, identical(coverage$delay$status_rule, "exists"), paste0("m>=3 delay must be universal in cell ", index, "."))
        errors <- n4v3_add_error(errors, identical(coverage$at_least_two_weak_vetoes$status_rule, "exists for every prior and every feasible package"), paste0("Wrong m>=3 multi-veto status in cell ", index, "."))
        errors <- n4v3_add_error(errors, grepl("requires Y=h", pooling$proposer_residual_rule$equality, fixed = TRUE), paste0("Wrong m>=3 pooling endpoint in cell ", index, "."))
      }

      errors <- n4v3_add_error(errors, identical(coverage$pooling$status_rule, "exists"), paste0("Pooling missing in cell ", index, "."))
      errors <- n4v3_add_error(errors, identical(coverage$high_type_only$status_rule, "none"), paste0("High-only corruption in cell ", index, "."))
      errors <- n4v3_add_error(errors, identical(coverage$H_separation_with_weak_veto$status_rule, "none"), paste0("H-separation corruption in cell ", index, "."))
      errors <- n4v3_add_error(errors, n4v3_contains(pooling$support_conditions, "h<=Y<=y_bar"), paste0("Wrong pooling H floor in cell ", index, "."))
      errors <- n4v3_add_error(errors, n4v3_contains(pooling$support_conditions, "x_ij>=B for every j!=i"), paste0("Wrong pooling weak floor in cell ", index, "."))
      errors <- n4v3_add_error(errors, grepl("x_ik<=C, including equality", delay$one_weak_veto$condition, fixed = TRUE), paste0("Wrong sole-veto boundary in cell ", index, "."))
      errors <- n4v3_add_error(errors, grepl("rho_c=(1/m)*sum_i Pr_i(c)", record$strategy_profile$proposer_identity_completion$assessment_weights, fixed = TRUE), paste0("Undefined assessment aggregation weights in cell ", index, "."))
      errors <- n4v3_add_error(errors, grepl("every positive-probability failure vector uses Bayes", record$belief_system$public_H_vote, fixed = TRUE), paste0("Belief map does not impose Bayes in cell ", index, "."))
      errors <- n4v3_add_error(errors, grepl("own explicit posterior eta", record$belief_system$zero_probability_failure_vector, fixed = TRUE), paste0("Incomplete off-path beliefs in cell ", index, "."))

      if (nu0) {
        errors <- n4v3_add_error(errors, identical(coverage$low_type_only$status_rule, "exists"), paste0("nu=0 L must exist in cell ", index, "."))
        errors <- n4v3_add_error(errors, identical(low_family$existence_status, "exists exactly at nu=0"), paste0("Wrong nu=0 L family in cell ", index, "."))
        errors <- n4v3_add_error(errors, n4v3_named_exactly(record$strategy_profile$nu0_reporting, c("coordinates", "full_image", "H_payoff", "outcome", "interpretation")), paste0("Incomplete nu=0 reporting in cell ", index, "."))
        expected_H <- list(
          theta_0 = "rho_L*bar_Y_L+rho_P*bar_Y_P+rho_D*ell",
          theta_1 = "(rho_L+rho_D)*h+rho_P*bar_Y_P"
        )
        expected_outcome <- list(
          pass_with_hegemon = "rho_L+rho_P", pass_without_hegemon = "0",
          failure = "0", delay = "rho_D"
        )
      } else {
        errors <- n4v3_add_error(errors, identical(coverage$low_type_only$status_rule, "none"), paste0("Positive-prior L must be none in cell ", index, "."))
        errors <- n4v3_add_error(errors, identical(low_family$existence_status, "none"), paste0("Wrong positive-prior L family in cell ", index, "."))
        errors <- n4v3_add_error(errors, identical(record$strategy_profile$nu0_reporting$status, "not_applicable"), paste0("nu0 reporting must be typed N/A in cell ", index, "."))
        expected_H <- if (low) {
          list(
            theta_0 = "rho_P*bar_Y_P+rho_D*ell",
            theta_1 = "rho_P*bar_Y_P+rho_D*h"
          )
        } else {
          list(
            theta_0 = "rho_P*bar_Y_P+rho_D*h",
            theta_1 = "rho_P*bar_Y_P+rho_D*h"
          )
        }
        expected_outcome <- list(
          pass_with_hegemon = "rho_P", pass_without_hegemon = "0",
          failure = "0", delay = "rho_D"
        )
      }
      errors <- n4v3_add_error(errors, identical(record$hegemon_payoff_by_type, expected_H), paste0("Wrong H payoff map in cell ", index, "."))
      errors <- n4v3_add_error(errors, identical(record$outcome_distribution, expected_outcome), paste0("Wrong outcome map in cell ", index, "."))
      if (low || nu0) {
        errors <- n4v3_add_error(errors, identical(delay$hegemon_payoff_by_type, list(theta_0 = "ell", theta_1 = "h")), paste0("Wrong low-region delay H vector in cell ", index, "."))
      }
      if (high) {
        errors <- n4v3_add_error(errors, identical(delay$hegemon_payoff_by_type, list(theta_0 = "h", theta_1 = "h")), paste0("Wrong high-region delay H vector in cell ", index, "."))
      }
    }
  }

  errors <- c(errors, n4v3_validate_formula_grid())

  coverage <- n4v3_audit_path_coverage(candidate, "candidate")
  if (!coverage$valid) {
    errors <- c(errors, paste0("Uncovered candidate leaf path: ", coverage$uncovered$path))
  }

  if (!is.null(builder_text)) {
    builder_required <- c(
      "S_3(nu)=(1-nu)*B", "S_2(nu)=max{R_0(nu),R_L(nu),R_P}",
      "for nu<1 attained iff (1-nu)*Q_L>B, and at equality or below only a supremum; at nu=1 its zero value is attained",
      "eliminate weakly dominated actions before sequential best response and T^Y",
      "The full Cartesian product across identities is retained.",
      "For every assessment define rho_c=(1/m)*sum_i Pr_i(c)",
      "exists iff C>=S_2; none iff C<S_2"
    )
    for (anchor in builder_required) {
      errors <- n4v3_add_error(
        errors, grepl(anchor, builder_text, fixed = TRUE),
        paste0("Builder lacks independently required semantic anchor: ", anchor)
      )
    }
    for (forbidden in forbidden_global) {
      errors <- n4v3_add_error(
        errors, !grepl(forbidden, builder_text, fixed = TRUE),
        paste0("Builder contains obsolete/corrupt semantic formula: ", forbidden)
      )
    }
  }

  if (!is.null(ledger)) {
    errors <- n4v3_add_error(
      errors,
      n4v3_named_exactly(ledger, c(
        "ledger_schema", "node_id", "artifact_path", "artifact_hash",
        "cold_note_path", "cold_note_hash", "node_status", "claims"
      )),
      "Wrong ledger fields."
    )
    errors <- n4v3_add_error(errors, identical(ledger$ledger_schema, "essential_input_claim_ledger_v1"), "Wrong ledger schema.")
    errors <- n4v3_add_error(errors, identical(ledger$node_id, "N4"), "Wrong ledger node.")
    errors <- n4v3_add_error(errors, identical(ledger$node_status, "pending_independent_review"), "Wrong N4 lifecycle in ledger.")
    errors <- n4v3_add_error(errors, length(ledger$claims) == 21L, "Ledger must contain 21 claims.")
    if (length(ledger$claims) == 21L) {
      expected_claim_ids <- paste0("N4V3-CLM-", sprintf("%03d", 1:21))
      observed_claim_ids <- vapply(ledger$claims, `[[`, character(1), "claim_id")
      errors <- n4v3_add_error(errors, identical(observed_claim_ids, expected_claim_ids), "Ledger claim IDs/order changed.")
      for (claim in ledger$claims) {
        errors <- n4v3_add_error(errors, claim$status %in% c("proved", "checked numerically"), paste0("Invalid claim status for ", claim$claim_id, "."))
        errors <- n4v3_add_error(errors, identical(n4v3_character_values(claim$equilibrium_ids), expected_eq_ids), paste0("Incomplete equilibrium linkage for ", claim$claim_id, "."))
        errors <- n4v3_add_error(errors, grepl("derivation_v3.md#", claim$evidence, fixed = TRUE), paste0("Wrong evidence path for ", claim$claim_id, "."))
      }
    }
    ledger_coverage <- n4v3_audit_path_coverage(ledger, "ledger")
    if (!ledger_coverage$valid) {
      errors <- c(errors, paste0("Uncovered ledger leaf path: ", ledger_coverage$uncovered$path))
    }
  }

  unique(errors)
}
