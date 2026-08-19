#!/usr/bin/env Rscript

# Verify the N7 Phase A public-benchmark intermediate candidate.
# This verifier deliberately rejects any public-private pairing, rent object,
# N7 lifecycle advancement, ballot mixing, domain loss, or extra schema field.

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

clone <- function(x) unserialize(serialize(x, NULL))

args <- commandArgs(trailingOnly = TRUE)
repo <- if (length(args) >= 1L) {
  normalizePath(args[[1L]], mustWork = TRUE)
} else {
  normalizePath(".", mustWork = TRUE)
}

path_candidate <- file.path(
  repo, "model_redesign",
  "essential_input_n7_phaseA_public_benchmarks_candidate_v1.json"
)
path_ledger <- file.path(
  repo, "model_redesign",
  "essential_input_n7_phaseA_public_benchmarks_ledger.json"
)
path_derivation <- file.path(
  repo, "model_redesign",
  "essential_input_n7_phaseA_public_benchmarks_derivation.md"
)
path_gate <- file.path(
  repo, "quality_reports",
  "2026-08-19_n7_phaseA_comparison_gate_discussion.md"
)
path_contract <- file.path(
  repo, "quality_reports", "plans",
  "2026-08-12_essential_input_gate0.md"
)
path_dag <- file.path(repo, "model_redesign", "essential_input_game_dag.json")

expected_candidate_hash <- paste0(
  "sha256:",
  "db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5"
)
expected_n6_hash <- paste0(
  "sha256:",
  "e5a71e29720598f829beb4f720bc966a64d2b04569ded0ba404cdd03b81b3f2a"
)

read_json <- function(path) {
  jsonlite::fromJSON(path, simplifyVector = FALSE)
}

sha256_file <- function(path) {
  out <- system2(
    "shasum", c("-a", "256", shQuote(path)), stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  assert_true(length(out) == 1L, paste("Could not hash", path))
  digest <- strsplit(out[[1L]], "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", digest), paste("Malformed hash", path))
  paste0("sha256:", digest)
}

as_chars <- function(x) as.character(unlist(x, use.names = FALSE))

same_names <- function(x, expected) {
  length(names(x)) == length(expected) && setequal(names(x), expected)
}

flat_json <- function(x) {
  as.character(jsonlite::toJSON(
    x, auto_unbox = TRUE, null = "null", digits = NA
  ))
}

find_node <- function(dag, id) {
  hits <- Filter(function(node) identical(node$id, id), dag$nodes)
  assert_true(length(hits) == 1L, paste("DAG node not unique:", id))
  hits[[1L]]
}

theta_key <- function(theta) paste0("theta_", theta)
theta_tag <- function(theta) paste0("T", theta)
o_name <- function(theta) paste0("o_", theta)

r2_id <- function(institution, theta, m_group) {
  paste(
    "N7A-PUB",
    if (identical(institution, "majority")) "M" else "U",
    "R2", theta_tag(theta), toupper(m_group), sep = "-"
  )
}

expected_cell_ids <- function(institution, round, theta) {
  inst <- if (identical(institution, "majority")) "M" else "U"
  if (identical(round, "R2")) {
    return(paste(
      "N7A-PUB", inst, "R2", theta_tag(theta), c("M2", "MGE3"),
      "CELL", sep = "-"
    ))
  }
  if (identical(institution, "unanimity")) {
    return(paste(
      "N7A-PUB", inst, "R1", theta_tag(theta), c("M2", "MGE3"),
      "CELL", sep = "-"
    ))
  }
  unlist(lapply(c("M2", "MGE3"), function(group) {
    paste(
      "N7A-PUB", inst, "R1", theta_tag(theta), group,
      c("LT", "EQ", "GT"), "CELL", sep = "-"
    )
  }), use.names = FALSE)
}

validate_lifecycle <- function(dag) {
  n6 <- find_node(dag, "N6")
  n7 <- find_node(dag, "N7")
  assert_true(identical(n6$status, "pass"), "N6 is not pass.")
  assert_true(identical(n6$frozen, TRUE), "N6 is not frozen.")
  assert_true(identical(n6$artifact_hash, expected_n6_hash), "N6 hash changed.")
  assert_true(identical(n7$status, "pending"), "N7 advanced beyond pending.")
  assert_true(is.null(n7$frozen), "Pending N7 has a frozen field.")
  assert_true(is.null(n7$artifact_hash), "Pending N7 has an artifact_hash.")
  assert_true(is.null(n7$reviews), "Pending N7 has reviews.")
  assert_true(is.null(n7$artifact_path), "Pending N7 has an artifact_path.")
  TRUE
}

validate_candidate <- function(candidate, dag) {
  expected_top <- c(
    "schema_ref", "function_of", "public_equilibrium_cells",
    "informational_rent_cells", "informational_rent_contrast_cells"
  )
  assert_true(same_names(candidate, expected_top), "Candidate top-level schema changed.")
  assert_true(
    identical(candidate$schema_ref, "complete_information_benchmark_v1"),
    "Wrong schema_ref."
  )
  assert_true(
    identical(candidate$function_of$name, "prior_mu") &&
      identical(candidate$function_of$domain, "[0,1]"),
    "Wrong function_of object."
  )
  assert_true(
    same_names(candidate$informational_rent_cells, c("majority", "unanimity")),
    "Rent collection names changed."
  )
  assert_true(
    is.null(candidate$informational_rent_cells$majority) &&
      is.null(candidate$informational_rent_cells$unanimity) &&
      is.null(candidate$informational_rent_contrast_cells),
    "Phase A candidate contains a rent or contrast object."
  )

  schema <- dag$interface_schemas$complete_information_benchmark_v1
  expected_record_fields <- as_chars(schema$public_equilibrium_record_fields)
  expected_payoff_fields <- as_chars(
    dag$shared_schema_types$public_payoff_vector_v1$fields
  )
  expected_outcome_fields <- as_chars(schema$outcome_distribution_fields)
  expected_cell_fields <- c(
    "cell_id", "domain_conditions", "existence_status",
    "public_equilibrium_records", "nonexistence_certificate"
  )

  all_record_ids <- character(0)
  all_cells <- list()
  for (institution in c("majority", "unanimity")) {
    for (round in c("R2", "R1")) {
      for (theta in 0:1) {
        key <- theta_key(theta)
        cells <- candidate$public_equilibrium_cells[[institution]][[round]][[key]]
        assert_true(is.list(cells), paste("Cells missing:", institution, round, key))
        observed_cell_ids <- vapply(cells, function(x) x$cell_id, character(1))
        expected_ids <- expected_cell_ids(institution, round, theta)
        assert_true(
          length(observed_cell_ids) == length(expected_ids) &&
            setequal(observed_cell_ids, expected_ids),
          paste("Coverage partition changed:", institution, round, key)
        )
        for (cell in cells) {
          assert_true(same_names(cell, expected_cell_fields), paste("Cell schema changed:", cell$cell_id))
          assert_true(identical(cell$existence_status, "exists"), paste("Unexpected none cell:", cell$cell_id))
          assert_true(is.null(cell$nonexistence_certificate), paste("Existing cell has certificate:", cell$cell_id))
          assert_true(length(cell$public_equilibrium_records) == 1L, paste("Cell does not contain one parametric family record:", cell$cell_id))
          rec <- cell$public_equilibrium_records[[1L]]
          assert_true(same_names(rec, expected_record_fields), paste("Record schema changed:", cell$cell_id))
          assert_true(identical(rec$public_equilibrium_id, sub("-CELL$", "", cell$cell_id)), paste("Record/cell ID mismatch:", cell$cell_id))
          assert_true(identical(rec$institution, institution), paste("Wrong institution:", cell$cell_id))
          assert_true(identical(rec$round, round), paste("Wrong round:", cell$cell_id))
          assert_true(identical(rec$theta, theta), paste("Wrong theta:", cell$cell_id))
          assert_true(same_names(rec$payoff_vector, expected_payoff_fields), paste("Payoff schema changed:", cell$cell_id))
          assert_true(same_names(rec$outcome_distribution, expected_outcome_fields), paste("Outcome schema changed:", cell$cell_id))
          assert_true(identical(rec$outcome_distribution$failure, 0L) || identical(rec$outcome_distribution$failure, 0), paste("Public failure survived:", cell$cell_id))
          assert_true(identical(rec$outcome_distribution$delay, 0L) || identical(rec$outcome_distribution$delay, 0), paste("Public delay survived:", cell$cell_id))
          assert_true(identical(rec$belief_system$multiplicity, "none: belief differences do not generate additional public assessments"), paste("Belief multiplicity added:", cell$cell_id))
          assert_true(grepl("common knowledge", rec$belief_system$type_information, fixed = TRUE), paste("Public type not fixed:", cell$cell_id))
          assert_true(grepl("public benchmark only", rec$selection_status, fixed = TRUE), paste("Phase A label missing:", cell$cell_id))
          assert_true(
            grepl("Before the simultaneous ballot", rec$strategy_profile$hegemon, fixed = TRUE),
            paste("H strategy may condition on realized votes:", cell$cell_id)
          )
          assert_true(!grepl("beta\\*beta", flat_json(rec), fixed = FALSE), paste("Double discount found:", cell$cell_id))

          id <- rec$public_equilibrium_id
          is_m2 <- grepl("-M2-", id, fixed = TRUE) || grepl("-M2$", id)
          m_group <- if (is_m2) "m2" else "mge3"
          o <- o_name(theta)

          if (identical(round, "R2")) {
            assert_true(length(rec$source_public_continuation_ids) == 0L, paste("R2 has continuation source:", id))
            assert_true(!grepl("beta", flat_json(rec$payoff_vector), fixed = TRUE), paste("Beta entered R2 payoff:", id))
            if (identical(institution, "majority")) {
              assert_true(identical(as.numeric(rec$outcome_distribution$pass_without_hegemon), 1), paste("Wrong M-R2 outcome:", id))
              assert_true(identical(rec$payoff_vector$recognized_proposer_payoff, "1"), paste("Wrong M-R2 proposer payoff:", id))
              assert_true(identical(rec$payoff_vector$weak_nonproposer_pre_recognition_expected_value, "1/m"), paste("Wrong M-R2 weak payoff:", id))
              assert_true(identical(rec$payoff_vector$hegemon_payoff, o), paste("Wrong M-R2 H payoff:", id))
            } else {
              assert_true(identical(as.numeric(rec$outcome_distribution$pass_with_hegemon), 1), paste("Wrong U-R2 outcome:", id))
              assert_true(identical(rec$payoff_vector$recognized_proposer_payoff, paste0("1-", o)), paste("Wrong U-R2 proposer payoff:", id))
              assert_true(identical(rec$payoff_vector$hegemon_payoff, o), paste("Wrong U-R2 H payoff:", id))
            }
          } else {
            expected_source <- r2_id(institution, theta, m_group)
            assert_true(
              length(rec$source_public_continuation_ids) == 1L &&
                identical(rec$source_public_continuation_ids[[1L]], expected_source),
              paste("Wrong same-rule same-type R2 source:", id)
            )
            assert_true(grepl("exactly one beta", rec$payoff_date, fixed = TRUE), paste("Exactly-once timing label missing:", id))
            if (identical(institution, "unanimity")) {
              expected_r <- paste0("1-beta*(m-1+", o, ")/m")
              assert_true(identical(rec$payoff_vector$recognized_proposer_payoff, expected_r), paste("Wrong U-R1 proposer payoff:", id))
              assert_true(identical(rec$payoff_vector$hegemon_payoff, paste0("beta*", o)), paste("Wrong U-R1 H payoff:", id))
              assert_true(identical(as.numeric(rec$outcome_distribution$pass_with_hegemon), 1), paste("Wrong U-R1 outcome:", id))
              assert_true(identical(rec$strategy_profile$proposal_mixing, "none"), paste("U-R1 proposal mixing added:", id))
              assert_true(grepl("1-beta>0", rec$branch_classification$agreement_delay_mixing, fixed = TRUE), paste("U-R1 delay margin missing:", id))
            } else {
              region <- sub("^.*-(LT|EQ|GT)$", "\\1", id)
              inclusion <- region %in% c("LT", "EQ")
              expected_r <- if (inclusion) {
                paste0("1-beta*", o, "-beta*(q-2)/m")
              } else {
                "1-beta*(q-1)/m"
              }
              expected_h <- if (inclusion) paste0("beta*", o) else o
              assert_true(identical(rec$payoff_vector$recognized_proposer_payoff, expected_r), paste("Wrong M-R1 proposer payoff:", id))
              assert_true(identical(rec$payoff_vector$hegemon_payoff, expected_h), paste("Wrong M-R1 H payoff:", id))
              assert_true(is.list(rec$payoff_vector$weak_nonproposer_pre_recognition_expected_value), paste("Identity-indexed weak payoff map missing:", id))
              assert_true(grepl("identity-indexed map", rec$payoff_vector$weak_nonproposer_pre_recognition_expected_value$type, fixed = TRUE), paste("Weak identity payoff type missing:", id))
              assert_true(grepl("1-beta*q/m>0", rec$branch_classification$agreement_delay_mixing, fixed = TRUE), paste("M-R1 delay margin missing:", id))
              if (inclusion) {
                assert_true(identical(as.numeric(rec$outcome_distribution$pass_with_hegemon), 1), paste("Inclusion outcome changed:", id))
              } else {
                assert_true(identical(as.numeric(rec$outcome_distribution$pass_without_hegemon), 1), paste("Exclusion outcome changed:", id))
              }
              if (identical(region, "EQ")) {
                assert_true(grepl("tie-break selects inclusion", rec$strategy_profile$boundary_selection, fixed = TRUE), paste("Boundary selection changed:", id))
              }
              if (identical(m_group, "mge3")) {
                assert_true(grepl("F_i", rec$strategy_profile$coalition_correspondence, fixed = TRUE), paste("Parametric coalition family missing:", id))
              }
            }
          }
          all_record_ids <- c(all_record_ids, rec$public_equilibrium_id)
          all_cells[[length(all_cells) + 1L]] <- cell
        }
      }
    }
  }
  assert_true(length(all_record_ids) == 24L, "Public record count is not 24.")
  assert_true(length(unique(all_record_ids)) == 24L, "Public record IDs are not unique.")

  serialized <- flat_json(candidate)
  forbidden <- c(
    "private_source", "source_N6", "source_equilibrium_id",
    "RI_M", "RI_U", "DeltaRI", "formal_model_v5", "formal_model_v6"
  )
  for (token in forbidden) {
    assert_true(!grepl(token, serialized, fixed = TRUE), paste("Forbidden Phase A token:", token))
  }
  TRUE
}

expect_rejected <- function(candidate, dag, label) {
  rejected <- inherits(
    try(validate_candidate(candidate, dag), silent = TRUE),
    "try-error"
  )
  assert_true(rejected, paste("Negative fixture was accepted:", label))
}

stopifnot(
  file.exists(path_candidate), file.exists(path_ledger),
  file.exists(path_derivation), file.exists(path_gate),
  file.exists(path_contract), file.exists(path_dag)
)

candidate <- read_json(path_candidate)
ledger <- read_json(path_ledger)
dag <- read_json(path_dag)

assert_true(identical(sha256_file(path_candidate), expected_candidate_hash), "Candidate bytes changed.")
assert_true(identical(ledger$candidate_hash, expected_candidate_hash), "Ledger candidate hash differs.")
assert_true(identical(ledger$node_id, "N7") && identical(ledger$phase, "A"), "Ledger is not N7 Phase A.")
assert_true(identical(ledger$lifecycle_status, "intermediate_candidate_pending_unfrozen"), "Ledger advanced N7 lifecycle.")
assert_true(identical(ledger$public_record_count, 24L), "Ledger record count differs.")
assert_true(identical(ledger$architectural_dependency$frozen_hash, expected_n6_hash), "Ledger N6 readiness hash changed.")
assert_true(grepl("readiness only", ledger$architectural_dependency$use_in_phase_A, fixed = TRUE), "Ledger uses N6 substantively.")

contract_text <- paste(readLines(path_contract, encoding = "UTF-8", warn = FALSE), collapse = "\n")
assert_true(grepl("Fase A do Goal 4", contract_text, fixed = TRUE), "Contract lacks Phase A authorization.")
assert_true(grepl("Gate autoral entre as Fases A e B", contract_text, fixed = TRUE), "Contract lacks the Phase A-to-B gate.")
assert_true(grepl("`N7` permanece `pending` e `unfrozen`", contract_text, fixed = TRUE), "Contract does not preserve pending N7.")
assert_true(
  grepl("nenhuma renda", contract_text, fixed = TRUE) &&
    grepl("calculada e `N7`", contract_text, fixed = TRUE),
  "Contract does not forbid Phase A rents."
)

invisible(validate_lifecycle(dag))
invisible(validate_candidate(candidate, dag))

# Independent numerical and combinatorial checks over the authorized interior.
for (m in 2:50) {
  q <- floor((m + 1) / 2) + 1
  assert_true(q <= m, paste("q>m at m=", m))
  k <- q - 1
  for (beta in c(0.01, 0.2, 0.5, 0.9, 0.999)) {
    assert_true(1 - beta * q / m > 0, paste("Majority delay margin failed at m=", m, ", beta=", beta))
    assert_true(1 - beta > 0, paste("Unanimity delay margin failed at beta=", beta))
    for (o in unique(c(0.001, min(0.999, 0.5 / m), 1 / m, min(0.999, 1.5 / m), 0.999))) {
      if (!(o > 0 && o < 1)) next
      r_e <- 1 - beta * k / m
      r_i <- 1 - beta * o - beta * (k - 1) / m
      r_u <- 1 - beta * o - beta * (m - 1) * (1 - o) / m
      a_m <- beta / m
      a_u <- beta * (1 - o) / m
      assert_true(abs((r_i - r_e) - beta * (1 / m - o)) < 1e-12, "Majority branch difference identity failed.")
      assert_true(abs((r_u - a_u) - (1 - beta)) < 1e-12, "Unanimity delay identity failed.")
      assert_true(r_e - a_m > 0, "Majority exclusion did not beat delay.")
      assert_true(r_e > 0 && r_u > 0, "Selected public proposer payoff is nonpositive.")
      if (o <= 1 / m) assert_true(r_i + 1e-12 >= r_e, "Inclusion region sign failed.")
      if (o > 1 / m) assert_true(r_e > r_i, "Exclusion region sign failed.")
      assert_true(abs((beta * o + (m - 1) * a_u + r_u) - 1) < 1e-12, "Unanimity full-pie identity failed.")
    }
  }
  inclusion_count <- choose(m - 1, k - 1)
  exclusion_count <- choose(m - 1, k)
  if (m == 2) {
    assert_true(inclusion_count == 1 && exclusion_count == 1, "m=2 coalition count failed.")
  } else if (m == 3) {
    assert_true(inclusion_count == 2 && exclusion_count == 1, "m=3 coalition count failed.")
  } else {
    assert_true(inclusion_count > 1 && exclusion_count > 1, paste("m>=4 coalition multiplicity failed at m=", m))
  }
}

# Negative schema, timing, scope, coverage, and lifecycle fixtures.
bad <- clone(candidate)
bad$informational_rent_cells$majority <- list(list(rent_record_id = "forbidden"))
expect_rejected(bad, dag, "non-null majority rent")

bad <- clone(candidate)
bad$informational_rent_contrast_cells <- list()
expect_rejected(bad, dag, "non-null rent contrast")

bad <- clone(candidate)
bad$phase <- "A"
expect_rejected(bad, dag, "new top-level phase field")

bad <- clone(candidate)
bad$public_equilibrium_cells$majority$R2$theta_1 <- NULL
expect_rejected(bad, dag, "missing public type")

bad <- clone(candidate)
bad$public_equilibrium_cells$unanimity$R1$theta_0 <- bad$public_equilibrium_cells$unanimity$R1$theta_0[-1L]
expect_rejected(bad, dag, "missing m=2 coverage")

bad <- clone(candidate)
bad$public_equilibrium_cells$majority$R1$theta_0[[1L]]$public_equilibrium_records[[1L]]$source_public_continuation_ids <- list("N7A-PUB-U-R2-T0-M2")
expect_rejected(bad, dag, "cross-rule continuation source")

bad <- clone(candidate)
bad$public_equilibrium_cells$majority$R1$theta_0[[1L]]$public_equilibrium_records[[1L]]$source_N6_interface_hash <- expected_n6_hash
expect_rejected(bad, dag, "private-source field")

bad <- clone(candidate)
bad$public_equilibrium_cells$unanimity$R1$theta_0[[1L]]$public_equilibrium_records[[1L]]$payoff_vector$hegemon_payoff <- "beta*beta*o_0"
expect_rejected(bad, dag, "double discount")

bad <- clone(candidate)
bad$public_equilibrium_cells$majority$R1$theta_0[[1L]]$public_equilibrium_records[[1L]]$outcome_distribution$delay <- 1
expect_rejected(bad, dag, "public delay")

bad <- clone(candidate)
bad$public_equilibrium_cells$majority$R1$theta_0[[2L]]$public_equilibrium_records[[1L]]$outcome_distribution$pass_with_hegemon <- 0
bad$public_equilibrium_cells$majority$R1$theta_0[[2L]]$public_equilibrium_records[[1L]]$outcome_distribution$pass_without_hegemon <- 1
expect_rejected(bad, dag, "boundary exclusion")

bad <- clone(candidate)
bad$public_equilibrium_cells$majority$R1$theta_0[[4L]]$public_equilibrium_records[[1L]]$payoff_vector$weak_nonproposer_pre_recognition_expected_value <- "cross-identity mean only"
expect_rejected(bad, dag, "loss of identity-indexed payoff correspondence")

bad <- clone(candidate)
bad$public_equilibrium_cells$majority$R2$theta_0[[1L]]$public_equilibrium_records[[1L]]$payoff_vector$hegemon_payoff <- "beta*o_0"
expect_rejected(bad, dag, "beta inside R2")

bad <- clone(candidate)
bad$public_equilibrium_cells$unanimity$R1$theta_1[[1L]]$public_equilibrium_records[[1L]]$belief_system$multiplicity <- "off-path free beliefs"
expect_rejected(bad, dag, "belief-only multiplicity")

bad_dag <- clone(dag)
n7_index <- which(vapply(bad_dag$nodes, function(node) identical(node$id, "N7"), logical(1)))
bad_dag$nodes[[n7_index]]$status <- "pass"
lifecycle_rejected <- inherits(try(validate_lifecycle(bad_dag), silent = TRUE), "try-error")
assert_true(lifecycle_rejected, "N7 pass mutation was accepted.")

# Protected-scope audit: no manuscript or historical provenance file may differ.
diff_names <- system2(
  "git", c("diff", "--name-only", "HEAD", "--"),
  stdout = TRUE, stderr = TRUE
)
protected_patterns <- c(
  "formal_model_v5", "formal_model_v6", "pivotal_response",
  "2026-08-12_essential_input_gate0_decisions.md"
)
for (pattern in protected_patterns) {
  assert_true(!any(grepl(pattern, diff_names, fixed = TRUE)), paste("Protected file changed:", pattern))
}

peeled_tag <- system2(
  "git", c("rev-parse", "pre-essential-input-2026-08-12^{}"),
  stdout = TRUE, stderr = TRUE
)
assert_true(
  length(peeled_tag) == 1L &&
    identical(peeled_tag[[1L]], "f53e6769624ce3dd6e64e21ad40d08230b0950a7"),
  "Protected pre-essential-input tag moved."
)

cat(
  paste0(
    "PASS: N7 Phase A public benchmarks contain 24 typed public records; ",
    "R2 precedes R1 within each rule/type; beta enters exactly once; m=2 and ",
    "m>=3 coverage, pure ballots, identity-indexed coalition families, public ",
    "beliefs, payoffs, outcomes, and negative fixtures verified. All rent ",
    "collections remain null, no private record is linked, protected scope is ",
    "unchanged, and N7 remains pending/unfrozen. Candidate ",
    expected_candidate_hash, ".\n"
  )
)
