#!/usr/bin/env Rscript

# Independent mechanical verifier for the N6 private-information comparison.
# It validates exact frozen-source transport, coverage, common-refinement
# pairing, set-valued comparison fields, and scope. Negative tests mutate
# in-memory copies only; no repository artifact is altered by the tests.

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

clone <- function(x) unserialize(serialize(x, NULL))

sha256_file <- function(path) {
  out <- system2("shasum", c("-a", "256", shQuote(path)), stdout = TRUE,
                 env = c("LC_ALL=C", "LANG=C"))
  assert_true(length(out) == 1L, paste("Could not hash", path))
  digest <- strsplit(out[[1L]], "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", digest), paste("Malformed hash", path))
  paste0("sha256:", digest)
}

read_json <- function(path) jsonlite::fromJSON(path, simplifyVector = FALSE)

expected_n3_hash <- "sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee"
expected_n4_hash <- "sha256:ee61ce6f854d4393f51048592a5221a9999a8f3f7daca1e749e7f19a88927f2d"
expected_n6_schema <- "private_information_comparison_v1"
payoff_names <- c("theta_0", "theta_1")
outcome_names <- c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")

find_by_id <- function(items, field, value) {
  hits <- Filter(function(x) identical(x[[field]], value), items)
  assert_true(length(hits) == 1L, paste("Expected one", field, "=", value))
  hits[[1L]]
}

ids_of <- function(items, field) {
  vapply(items, function(x) x[[field]], character(1))
}

assert_unique <- function(x, label) {
  assert_true(!anyDuplicated(x), paste(label, "contains duplicate IDs"))
}

validate_coverage_cell <- function(cell, source_cell, record_field) {
  assert_true(setequal(names(cell), c(
    "cell_id", "domain_conditions", "existence_status", record_field,
    "nonexistence_certificate"
  )), paste("Unexpected coverage-cell fields:", cell$cell_id))
  assert_true(identical(cell$cell_id, source_cell$cell_id),
              paste("Source cell ID changed:", source_cell$cell_id))
  assert_true(identical(cell$domain_conditions, source_cell$domain_conditions),
              paste("Domain conditions changed:", source_cell$cell_id))
  assert_true(identical(cell$existence_status, source_cell$existence_status),
              paste("Existence status changed:", source_cell$cell_id))
  assert_true(identical(cell$nonexistence_certificate, source_cell$nonexistence_certificate),
              paste("Nonexistence certificate changed:", source_cell$cell_id))
  records <- cell[[record_field]]
  assert_true(is.list(records), paste("Records are not a list:", source_cell$cell_id))
  if (identical(source_cell$existence_status, "exists")) {
    assert_true(length(records) >= 1L,
                paste("Existing source cell lost all records:", source_cell$cell_id))
    assert_true(is.null(cell$nonexistence_certificate),
                paste("Existing cell has a none certificate:", source_cell$cell_id))
  } else if (identical(source_cell$existence_status, "none")) {
    assert_true(length(records) == 0L,
                paste("None cell contains a fabricated record:", source_cell$cell_id))
    cert <- cell$nonexistence_certificate
    assert_true(is.list(cert), paste("None cell lacks certificate:", source_cell$cell_id))
    assert_true(all(c("ledger_claim_ids", "assumptions_used", "checks_performed") %in% names(cert)),
                paste("Incomplete none certificate:", source_cell$cell_id))
    assert_true(length(cert$ledger_claim_ids) > 0L && length(cert$assumptions_used) > 0L &&
                  length(cert$checks_performed) > 0L,
                paste("Empty none certificate:", source_cell$cell_id))
  } else {
    stop("Unknown source existence status.", call. = FALSE)
  }
}

validate_private_collection <- function(cells, source_cells, institution, source_hash) {
  assert_true(is.list(cells) && length(cells) == length(source_cells),
              paste(institution, "cell count differs from source"))
  cell_ids <- ids_of(cells, "cell_id")
  assert_unique(cell_ids, paste(institution, "cell IDs"))
  assert_true(setequal(cell_ids, ids_of(source_cells, "cell_id")),
              paste(institution, "cell partition differs from source"))

  source_record_ids <- character(0)
  private_record_ids <- character(0)
  for (source_cell in source_cells) {
    cell <- find_by_id(cells, "cell_id", source_cell$cell_id)
    validate_coverage_cell(cell, source_cell, "private_rule_records")
    if (identical(source_cell$existence_status, "exists")) {
      source_record_ids <- c(source_record_ids,
                             ids_of(source_cell$equilibrium_records, "equilibrium_id"))
      for (eq in source_cell$equilibrium_records) {
        hits <- Filter(function(x) identical(x$source_equilibrium_id, eq$equilibrium_id),
                       cell$private_rule_records)
        assert_true(length(hits) == 1L,
                    paste("Source equilibrium is not represented exactly once:", eq$equilibrium_id))
        rec <- hits[[1L]]
        assert_true(identical(rec$institution, institution),
                    paste("Wrong institution for", eq$equilibrium_id))
        assert_true(identical(rec$source_equilibrium_cell_id, source_cell$cell_id),
                    paste("Wrong source cell for", eq$equilibrium_id))
        assert_true(identical(rec$source_interface_hash, source_hash),
                    paste("Wrong source hash for", eq$equilibrium_id))
        assert_true(identical(rec$admissibility_conditions, eq$admissibility_conditions),
                    paste("Admissibility changed for", eq$equilibrium_id))
        assert_true(identical(rec$private_payoff_vector, eq$hegemon_payoff_by_type),
                    paste("Payoff vector changed for", eq$equilibrium_id))
        assert_true(identical(rec$private_outcome_distribution, eq$outcome_distribution),
                    paste("Outcome distribution changed for", eq$equilibrium_id))
        assert_true(identical(rec$selection_status, eq$selection_status),
                    paste("Selection status changed for", eq$equilibrium_id))
        private_record_ids <- c(private_record_ids, rec$private_rule_record_id)
      }
    }
  }
  assert_unique(source_record_ids, paste(institution, "source equilibrium IDs"))
  assert_unique(private_record_ids, paste(institution, "private record IDs"))
  list(source_record_ids = source_record_ids, private_record_ids = private_record_ids)
}

validate_comparison <- function(n6, n3, n4, majority_cells, unanimity_cells) {
  comparisons <- n6$comparison_cells
  assert_true(is.list(comparisons), "comparison_cells must be a list")
  expected_cell_count <- length(majority_cells) * length(unanimity_cells)
  assert_true(length(comparisons) == expected_cell_count,
              "comparison_cells is not the common-refinement cross-product")
  assert_unique(ids_of(comparisons, "cell_id"), "comparison cell IDs")

  comparison_ids <- character(0)
  for (m_cell in majority_cells) {
    for (u_cell in unanimity_cells) {
      expected_cell_id <- paste0("N6-CELL-", m_cell$cell_id, "--", u_cell$cell_id)
      comp_cell <- find_by_id(comparisons, "cell_id", expected_cell_id)
      cond <- comp_cell$domain_conditions
      assert_true(identical(cond$majority_cell_id, m_cell$cell_id) &&
                    identical(cond$unanimity_cell_id, u_cell$cell_id),
                  paste("Wrong common-refinement coordinates:", expected_cell_id))
      both_exists <- identical(m_cell$existence_status, "exists") &&
        identical(u_cell$existence_status, "exists")
      assert_true(identical(comp_cell$existence_status, if (both_exists) "exists" else "none"),
                  paste("Wrong comparison existence status:", expected_cell_id))
      m_records <- m_cell$private_rule_records
      u_records <- u_cell$private_rule_records
      recs <- comp_cell$comparison_records
      if (!both_exists) {
        assert_true(length(recs) == 0L, paste("None comparison has records:", expected_cell_id))
        cert <- comp_cell$nonexistence_certificate
        assert_true(is.list(cert) && length(cert$ledger_claim_ids) > 0L &&
                      length(cert$assumptions_used) > 0L && length(cert$checks_performed) > 0L,
                    paste("None comparison lacks a certificate:", expected_cell_id))
        next
      }
      assert_true(is.null(comp_cell$nonexistence_certificate),
                  paste("Existing comparison has a none certificate:", expected_cell_id))
      expected_count <- length(m_records) * length(u_records)
      assert_true(length(recs) == expected_count,
                  paste("Comparison record count differs:", expected_cell_id))
      for (m_rec in m_records) {
        for (u_rec in u_records) {
          expected_id <- paste0("N6-COMPARISON-", m_rec$source_equilibrium_id,
                                "--", u_rec$source_equilibrium_id)
          hits <- Filter(function(x) identical(x$comparison_id, expected_id), recs)
          assert_true(length(hits) == 1L, paste("Missing comparison pair:", expected_id))
          rec <- hits[[1L]]
          comparison_ids <- c(comparison_ids, rec$comparison_id)
          assert_true(identical(rec$source_equilibrium_ids$majority,
                                m_rec$source_equilibrium_id) &&
                        identical(rec$source_equilibrium_ids$unanimity,
                                  u_rec$source_equilibrium_id),
                      paste("Wrong source IDs:", expected_id))
          assert_true(identical(rec$source_interface_hashes$N3, expected_n3_hash) &&
                        identical(rec$source_interface_hashes$N4, expected_n4_hash),
                      paste("Wrong dependency hashes:", expected_id))
          assert_true(identical(rec$private_payoff_vectors_by_rule$majority,
                                m_rec$private_payoff_vector) &&
                        identical(rec$private_payoff_vectors_by_rule$unanimity,
                                  u_rec$private_payoff_vector),
                      paste("Joint payoff vector changed:", expected_id))
          assert_true(identical(rec$private_outcome_distributions_by_rule$majority,
                                m_rec$private_outcome_distribution) &&
                        identical(rec$private_outcome_distributions_by_rule$unanimity,
                                  u_rec$private_outcome_distribution),
                      paste("Joint outcome distribution changed:", expected_id))
          contrasts <- rec$private_rule_contrasts
          assert_true(identical(contrasts$status, "set_valued"),
                      paste("Comparison was silently scalarized:", expected_id))
          assert_true(is.list(contrasts$scope) &&
                        identical(contrasts$scope$formal_domain,
                                  "The complete formal comparison retains both m=2 and m>=3 source cells for coverage and completeness.") &&
                        identical(contrasts$scope$substantive_scope,
                                  "The main substantive interpretation emphasizes organizations with at least three weak states (m>=3; four or more total members).") &&
                        identical(contrasts$scope$mge3_delay_existence,
                                  "In the N4 m>=3 cells, delay equilibria exist universally in the source correspondence.") &&
                        identical(contrasts$scope$mge3_delay_selection,
                                  "Delay is not forced in those cells: pooling also exists, and N6 preserves both branches without selection."),
                      paste("Formal/substantive scope distinction is missing:", expected_id))
          for (theta in payoff_names) {
            x <- contrasts$payoff_by_type[[theta]]
            assert_true(identical(x$majority, as.character(m_rec$private_payoff_vector[[theta]])) ||
                          identical(x$majority, jsonlite::toJSON(m_rec$private_payoff_vector[[theta]], auto_unbox = TRUE, null = "null", digits = NA)),
                        paste("Missing majority payoff contrast:", expected_id, theta))
            assert_true(identical(x$unanimity, as.character(u_rec$private_payoff_vector[[theta]])) ||
                          identical(x$unanimity, jsonlite::toJSON(u_rec$private_payoff_vector[[theta]], auto_unbox = TRUE, null = "null", digits = NA)),
                        paste("Missing unanimity payoff contrast:", expected_id, theta))
            assert_true(is.character(x$difference_majority_minus_unanimity) &&
                          identical(x$ordering_status, "set_valued_no_scalar_ordering_asserted"),
                        paste("Incomplete payoff contrast:", expected_id, theta))
          }
          for (outcome in outcome_names) {
            x <- contrasts$outcome_distribution[[outcome]]
            assert_true(is.character(x$difference_majority_minus_unanimity) &&
                          identical(x$ordering_status, "set_valued_no_scalar_ordering_asserted"),
                        paste("Incomplete outcome contrast:", expected_id, outcome))
          }
          assert_true(identical(contrasts$delay$ordering_status,
                                "no_robust_delay_ranking_asserted"),
                      paste("Delay was silently ranked:", expected_id))
        }
      }
    }
  }
  assert_unique(comparison_ids, "comparison IDs")
  comparison_ids
}

validate_n6 <- function(n6, n3, n4) {
  assert_true(identical(names(n6), c(
    "schema_ref", "function_of", "private_rule_cells", "comparison_cells"
  )), "N6 top-level schema changed or contains an out-of-scope collection")
  assert_true(identical(n6$schema_ref, expected_n6_schema), "Wrong N6 schema")
  assert_true(identical(n6$function_of, n3$function_of), "N6 function_of differs from predecessors")
  forbidden <- intersect(names(n6), c(
    "public_equilibrium_cells", "informational_rent_cells", "RI_M", "RI_U",
    "DeltaRI", "formation", "entry_value"
  ))
  assert_true(length(forbidden) == 0L, "N6 contains an N7/formation collection")
  assert_true(is.list(n6$private_rule_cells) &&
                setequal(names(n6$private_rule_cells), c("majority", "unanimity")),
              "N6 private_rule_cells must preserve both rules")
  m_check <- validate_private_collection(
    n6$private_rule_cells$majority, n3$correspondence_cells,
    "majority", expected_n3_hash
  )
  u_check <- validate_private_collection(
    n6$private_rule_cells$unanimity, n4$correspondence_cells,
    "unanimity", expected_n4_hash
  )
  assert_true(length(intersect(m_check$source_record_ids, u_check$source_record_ids)) == 0L,
              "Private source equilibrium IDs collide across rules")
  validate_comparison(
    n6, n3, n4, n6$private_rule_cells$majority,
    n6$private_rule_cells$unanimity
  )
  invisible(TRUE)
}

script_path <- normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)[[1L]]), mustWork = TRUE)
repo <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
path_n3 <- file.path(repo, "model_redesign", "essential_input_interfaces", "n3_r1_majority_candidate_v1.json")
path_n4 <- file.path(repo, "model_redesign", "essential_input_n4_r1_unanimity_interface.json")
path_n6 <- file.path(repo, "model_redesign", "essential_input_n6_private_information_comparison_v1.json")
path_ledger <- file.path(repo, "model_redesign", "essential_input_n6_private_information_comparison_ledger.json")

assert_true(identical(sha256_file(path_n3), expected_n3_hash), "Frozen N3 hash mismatch")
assert_true(identical(sha256_file(path_n4), expected_n4_hash), "Frozen N4 hash mismatch")
assert_true(file.exists(path_n6), "N6 interface is missing")
assert_true(file.exists(path_ledger), "N6 ledger is missing")
n3 <- read_json(path_n3)
n4 <- read_json(path_n4)
n6 <- read_json(path_n6)
ledger <- read_json(path_ledger)
assert_true(identical(ledger$node_id, "N6"), "Ledger node_id is not N6")
assert_true(identical(ledger$artifact_hash, sha256_file(path_n6)), "Ledger hash is stale")
assert_true(identical(ledger$dependency_hashes$N3, expected_n3_hash) &&
              identical(ledger$dependency_hashes$N4, expected_n4_hash),
            "Ledger dependency hashes are stale")
validate_n6(n6, n3, n4)
cat("PASS: N6 schema, exact source transport, coverage, common refinement, contrasts, scope, and ledger hash.\n")

assert_fails <- function(label, mutate) {
  candidate <- clone(n6)
  candidate <- mutate(candidate)
  succeeded <- tryCatch({
    validate_n6(candidate, n3, n4)
    TRUE
  }, error = function(e) FALSE)
  assert_true(!succeeded, paste("Negative test did not fail:", label))
  cat("PASS negative:", label, "\n")
}

assert_fails("duplicate private source record", function(x) {
  x$private_rule_cells$majority[[1L]]$private_rule_records[[2L]] <-
    clone(x$private_rule_cells$majority[[1L]]$private_rule_records[[1L]])
  x
})
assert_fails("missing comparison pair", function(x) {
  x$comparison_cells[[1L]]$comparison_records <- list()
  x
})
assert_fails("stale N4 source hash", function(x) {
  x$comparison_cells[[1L]]$comparison_records[[1L]]$source_interface_hashes$N4 <- "sha256:stale"
  x
})
assert_fails("surviving rule collection deleted", function(x) {
  x$private_rule_cells$majority[[1L]]$private_rule_records <- list()
  x
})
assert_fails("payoff projection altered", function(x) {
  x$comparison_cells[[1L]]$comparison_records[[1L]]$private_payoff_vectors_by_rule$majority$theta_0 <- "altered"
  x
})
assert_fails("out-of-scope RI_M field", function(x) {
  x$RI_M <- list()
  x
})
cat("PASS: six negative mutation tests rejected.\n")
