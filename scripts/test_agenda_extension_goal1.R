#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_argument) != 1L) {
  stop("Could not resolve test harness path.", call. = FALSE)
}
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repo_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
source(file.path(dirname(script_path), "agenda_extension_goal1_verifier_lib.R"))

test_results <- data.frame(
  test_id = character(),
  status = character(),
  detail = character(),
  stringsAsFactors = FALSE
)

agenda_test <- function(test_id, expression) {
  captured <- substitute(expression)
  detail <- "condition returned TRUE"
  ok <- tryCatch(
    {
      value <- eval(captured, envir = parent.frame())
      isTRUE(value)
    },
    error = function(error) {
      detail <<- conditionMessage(error)
      FALSE
    }
  )
  if (!ok && identical(detail, "condition returned TRUE")) {
    detail <- paste("condition returned:", paste(deparse(eval(captured, envir = parent.frame())), collapse = " "))
  }
  test_results <<- rbind(
    test_results,
    data.frame(
      test_id = test_id,
      status = if (ok) "PASS" else "FAIL",
      detail = detail,
      stringsAsFactors = FALSE
    )
  )
  invisible(ok)
}

absolute <- function(path) file.path(repo_root, path)
manifest <- agenda_read_json(absolute(
  "model_redesign/agenda_extension_goal1_external_interfaces.json"
))
dag <- agenda_read_json(absolute(
  "model_redesign/agenda_extension_game_dag_simplified.json"
))
C_M <- agenda_read_json(absolute(manifest$external_interfaces[[1L]]$path))
C_U <- agenda_read_json(absolute(manifest$external_interfaces[[2L]]$path))
N7_public <- agenda_read_json(absolute(manifest$external_interfaces[[3L]]$path))

hash_M <- manifest$external_interfaces[[1L]]$sha256
hash_U <- manifest$external_interfaces[[2L]]$sha256
known_hashes <- c(hash_M, hash_U, manifest$external_interfaces[[3L]]$sha256)
container_hash <- paste(rep("0", 64), collapse = "")

family_M <- stats::setNames(as.list(rep("fixture", length(agenda_required_family_fields))), agenda_required_family_fields)
family_M$family_record_id <- "F-M"
family_M$institution <- "M"
family_M$atomic_binder <- "B-M"
family_M$proof_path <- "proofs/family_M.md"
family_M$payoff_by_type_and_identity <- list(theta_0 = 0.2, theta_1 = 0.3)
family_M$outcome_distribution <- list(pass = 1, failure = 0)

family_U <- agenda_clone(family_M)
family_U$family_record_id <- "F-U"
family_U$institution <- "U"
family_U$atomic_binder <- "B-U"
family_U$proof_path <- "proofs/family_U.md"
family_index <- list("F-M" = family_M, "F-U" = family_U)

image_record <- stats::setNames(as.list(rep("fixture", length(agenda_required_image_fields))), agenda_required_image_fields)
image_record$image_id <- "IMG-M"
image_record$source_family_record_id <- "F-M"
image_record$source_atomic_binder <- "B-M"
image_record$proof_path <- "proofs/image_M.md"

comparison_record <- stats::setNames(
  as.list(rep("fixture", length(agenda_required_comparison_fields))),
  agenda_required_comparison_fields
)
comparison_record$comparison_id <- "CMP-1"
comparison_record$source_member_domains_and_binders <- list(
  list(family_record_id = "F-M", member_domain = "D-M", atomic_binder = "B-M"),
  list(family_record_id = "F-U", member_domain = "D-U", atomic_binder = "B-U")
)
comparison_record$proof_path <- "proofs/comparison.md"

claim_row <- stats::setNames(as.list(rep("", length(agenda_required_ledger_columns))), agenda_required_ledger_columns)
claim_row$claim_id <- "CLM-1"
claim_row$node_id <- "A_M"
claim_row$claim_kind <- "substantive"
claim_row$status <- "proved"
claim_row$source_record_ids <- "C-M-1"
claim_row$source_hashes <- hash_M
claim_row$proof_path <- "proofs/claim.md"

transport_A <- list(
  source_record_id = "INTERNAL-1",
  source_artifact_hash_if_external = "",
  native_value = 0.5,
  native_date = "A",
  transport_factor_to_A = 1,
  beta_application_count = 0L,
  transported_value_at_A = 0.5
)
transport_C <- list(
  source_record_id = "C-M-1",
  source_artifact_hash_if_external = paste0("sha256:", hash_M),
  native_value = 0.5,
  native_date = "C",
  transport_factor_to_A = 0.9,
  beta_application_count = 1L,
  transported_value_at_A = 0.45
)

repository_checks <- agenda_run_repository_checks(repo_root)
agenda_test("repository_positive_all_checks", nrow(repository_checks) >= 25L && all(repository_checks$status == "PASS"))
agenda_test("manifest_has_three_interfaces", length(manifest$external_interfaces) == 3L)
agenda_test("private_C_M_positive", !length(agenda_validate_private_interface(C_M)))
agenda_test("private_C_U_positive", !length(agenda_validate_private_interface(C_U)))
agenda_test("public_N7_positive", !length(agenda_validate_public_interface(N7_public)))
agenda_test("dag_positive", !length(agenda_validate_dag(dag)))
agenda_test("family_positive", !length(agenda_validate_family_record(family_M)))
agenda_test("image_binder_positive", !length(agenda_validate_image_record(image_record, family_index)))
agenda_test("comparison_binders_positive", !length(agenda_validate_comparison_record(comparison_record, family_index)))
agenda_test("claim_proof_positive", !length(agenda_validate_claim_row(claim_row)))
agenda_test("transport_A_positive", !length(agenda_validate_transport_record(transport_A, 0.9, container_hash, known_hashes)))
agenda_test("transport_C_positive", !length(agenda_validate_transport_record(transport_C, 0.9, container_hash, known_hashes)))
agenda_test("majority_quota_positive", agenda_vote_passes(5L, "M", c(1L, 1L, 0L, 0L)))
agenda_test("unanimity_quota_positive", agenda_vote_passes(5L, "U", c(1L, 1L, 1L, 1L)))
agenda_test("unanimity_one_no_negative_outcome", !agenda_vote_passes(5L, "U", c(1L, 1L, 1L, 0L)))
agenda_test("algebra_identity_positive", agenda_identity_holds(0.5 * 0.9, 0.45))
agenda_test(
  "historical_erratum_snapshot_resolves",
  identical(
    agenda_sha256_git_snapshot(
      repo_root,
      "1a12b749f967d460f819d8732634992ba75fdcf8",
      "quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md"
    ),
    "94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69"
  )
)

bad_private <- agenda_clone(C_M)
bad_private$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system <- NULL
agenda_test("reject_private_missing_required_field", length(agenda_validate_private_interface(bad_private)) > 0L)

bad_none_cell <- agenda_clone(C_U)
bad_none_cell$correspondence_cells[[2L]]$nonexistence_certificate <- NULL
agenda_test("reject_none_cell_without_certificate", length(agenda_validate_private_interface(bad_none_cell)) > 0L)

bad_public <- agenda_clone(N7_public)
bad_public$public_equilibrium_cells$majority$R2$theta_0[[1L]]$public_equilibrium_records[[1L]]$payoff_vector <- NULL
agenda_test("reject_public_missing_payoff_vector", length(agenda_validate_public_interface(bad_public)) > 0L)

bad_dag_cycle <- agenda_clone(dag)
bad_dag_cycle$edges[[length(bad_dag_cycle$edges) + 1L]] <- list(
  from = "agenda_extension:AC",
  to = "agenda_extension:A_M"
)
agenda_test("reject_dag_cycle", length(agenda_validate_dag(bad_dag_cycle)) > 0L)

bad_dag_status <- agenda_clone(dag)
bad_dag_status$nodes[[1L]]$status <- "pass"
agenda_test("reject_premature_node_pass", length(agenda_validate_dag(bad_dag_status)) > 0L)

bad_family_missing <- agenda_clone(family_M)
bad_family_missing$belief_system <- NULL
agenda_test("reject_family_missing_field", length(agenda_validate_family_record(bad_family_missing)) > 0L)

bad_family_sentinel <- agenda_clone(family_M)
bad_family_sentinel$payoff_by_type_and_identity$theta_0 <- "NA_PAYOFF"
agenda_test("reject_payoff_sentinel", length(agenda_validate_family_record(bad_family_sentinel)) > 0L)

bad_image_binder <- agenda_clone(image_record)
bad_image_binder$source_atomic_binder <- "B-WRONG"
agenda_test("reject_image_binder_mismatch", length(agenda_validate_image_record(bad_image_binder, family_index)) > 0L)

bad_image_id <- agenda_clone(image_record)
bad_image_id$source_family_record_id <- "F-UNKNOWN"
agenda_test("reject_image_unknown_source", length(agenda_validate_image_record(bad_image_id, family_index)) > 0L)

bad_comparison_binder <- agenda_clone(comparison_record)
bad_comparison_binder$source_member_domains_and_binders[[2L]]$atomic_binder <- "B-M"
agenda_test("reject_comparison_coordinate_splicing", length(agenda_validate_comparison_record(bad_comparison_binder, family_index)) > 0L)

bad_claim_proof <- agenda_clone(claim_row)
bad_claim_proof$proof_path <- ""
agenda_test("reject_proved_claim_without_proof", length(agenda_validate_claim_row(bad_claim_proof)) > 0L)

bad_claim_evidence <- agenda_clone(claim_row)
bad_claim_evidence$status <- "checked numerically"
bad_claim_evidence$proof_path <- ""
bad_claim_evidence$evidence_path <- ""
agenda_test("reject_numeric_claim_without_evidence", length(agenda_validate_claim_row(bad_claim_evidence)) > 0L)

bad_claim_source <- agenda_clone(claim_row)
bad_claim_source$source_hashes <- ""
agenda_test("reject_completed_claim_without_source_hash", length(agenda_validate_claim_row(bad_claim_source)) > 0L)

bad_double_beta <- agenda_clone(transport_C)
bad_double_beta$beta_application_count <- 2L
agenda_test("reject_double_beta", length(agenda_validate_transport_record(bad_double_beta, 0.9, container_hash, known_hashes)) > 0L)

bad_transport_factor <- agenda_clone(transport_C)
bad_transport_factor$transport_factor_to_A <- 0.81
bad_transport_factor$transported_value_at_A <- 0.405
agenda_test("reject_wrong_transport_factor", length(agenda_validate_transport_record(bad_transport_factor, 0.9, container_hash, known_hashes)) > 0L)

bad_transport_identity <- agenda_clone(transport_C)
bad_transport_identity$transported_value_at_A <- 0.44
agenda_test("reject_wrong_transported_value", length(agenda_validate_transport_record(bad_transport_identity, 0.9, container_hash, known_hashes)) > 0L)

bad_self_hash <- agenda_clone(transport_C)
bad_self_hash$source_artifact_hash_if_external <- paste0("sha256:", hash_M)
agenda_test("reject_self_referential_hash", length(agenda_validate_transport_record(bad_self_hash, 0.9, hash_M, known_hashes)) > 0L)

bad_unknown_hash <- agenda_clone(transport_C)
bad_unknown_hash$source_artifact_hash_if_external <- paste0("sha256:", paste(rep("a", 64), collapse = ""))
agenda_test("reject_unknown_external_hash", length(agenda_validate_transport_record(bad_unknown_hash, 0.9, container_hash, known_hashes)) > 0L)

agenda_test("reject_false_identity", !agenda_identity_holds(0.5 * 0.9, 0.44))
agenda_test("reject_missing_source_file", is.na(agenda_sha256_file(file.path(tempdir(), "missing-agenda-interface.json"))))

malformed_json <- tempfile("agenda-extension-malformed-", fileext = ".json")
writeLines("{not valid json", malformed_json, useBytes = TRUE)
agenda_test("reject_malformed_json", is.null(agenda_read_json(malformed_json)))
unlink(malformed_json)

bad_header <- tempfile("agenda-extension-ledger-", fileext = ".tsv")
writeLines(paste(agenda_required_ledger_columns[-1L], collapse = "\t"), bad_header, useBytes = TRUE)
agenda_test("reject_bad_ledger_header", !identical(agenda_read_ledger_header(bad_header), agenda_required_ledger_columns))
unlink(bad_header)

for (row_index in seq_len(nrow(test_results))) {
  cat(sprintf(
    "%-44s | %-4s | %s\n",
    test_results$test_id[[row_index]],
    test_results$status[[row_index]],
    test_results$detail[[row_index]]
  ))
}

pass_count <- sum(test_results$status == "PASS")
fail_count <- sum(test_results$status == "FAIL")
cat(sprintf("\nSUMMARY | %d PASS | %d FAIL\n", pass_count, fail_count))
if (fail_count > 0L) {
  quit(save = "no", status = 1L)
}
cat(
  paste0(
    "PASS: representative positive and negative mechanical tests succeeded. ",
    "No mathematical equilibrium claim was tested or proved.\n"
  )
)
