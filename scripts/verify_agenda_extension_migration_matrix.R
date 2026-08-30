#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
output_path <- if (length(args) >= 1L) args[[1L]] else NA_character_

checks <- list()
record_check <- function(label, condition, detail = "") {
  condition <- isTRUE(condition)
  checks[[length(checks) + 1L]] <<- list(
    label = label,
    status = if (condition) "PASS" else "FAIL",
    detail = detail
  )
  invisible(condition)
}

sha256 <- function(path) {
  result <- system2("shasum", c("-a", "256", path), stdout = TRUE, stderr = TRUE)
  if (!identical(attr(result, "status"), NULL) && attr(result, "status") != 0L) {
    return(NA_character_)
  }
  hash_line <- grep("^[0-9a-f]{64}[[:space:]]", result, value = TRUE)
  if (length(hash_line) != 1L) return(NA_character_)
  sub("[[:space:]].*$", "", hash_line[[1L]])
}

split_claims <- function(x) {
  trimws(unlist(strsplit(x, ";", fixed = TRUE)))
}

verify_manifest <- function(path) {
  result <- system2("shasum", c("-c", path), stdout = TRUE, stderr = TRUE)
  status <- attr(result, "status")
  ok <- is.null(status) || identical(status, 0L)
  list(ok = ok, output = paste(result, collapse = " | "))
}

matrix_path <- "quality_reports/plans/2026-08-30_agenda_extension_migration_matrix.tsv"
matrix_doc <- "quality_reports/plans/2026-08-30_agenda_extension_migration_matrix.md"
proposal_doc <- "quality_reports/plans/2026-08-30_proposta_arquitetura_editorial_agenda_extension.md"

expected_columns <- c(
  "migration_id", "source_node", "claim_ids", "source_artifact",
  "source_sha256", "governing_manifest", "governing_manifest_sha256",
  "current_v6_anchor", "proposed_action", "proposed_destination", "placement",
  "proof_destination", "editorial_status", "scope_guard"
)

record_check("matrix TSV exists", file.exists(matrix_path), matrix_path)
record_check("matrix explanatory document exists", file.exists(matrix_doc), matrix_doc)
record_check("editorial proposal exists", file.exists(proposal_doc), proposal_doc)

matrix <- read.delim(
  matrix_path,
  sep = "\t",
  quote = "",
  check.names = FALSE,
  stringsAsFactors = FALSE
)

record_check("matrix has the exact schema", identical(names(matrix), expected_columns), paste(names(matrix), collapse = ", "))
record_check("matrix has 13 migration rows", nrow(matrix) == 13L, paste("rows:", nrow(matrix)))
record_check("migration ids are unique", !anyDuplicated(matrix$migration_id), paste(matrix$migration_id, collapse = ", "))
record_check("all source nodes are allowed", all(matrix$source_node %in% c("A_M", "A_U", "AC", "AR")))
record_check("all rows remain unauthorized proposals", all(matrix$editorial_status == "PROPOSED_NOT_AUTHORIZED"))
record_check(
  "all actions are controlled",
  all(matrix$proposed_action %in% c("ADD_EXTENSION", "PRESERVE_AND_CITE", "MOVE_TECHNICAL"))
)
record_check(
  "all placements are controlled",
  all(matrix$placement %in% c(
    "MAIN_SETUP", "MAIN_SUMMARY", "MAIN_PROPOSITION", "MAIN_COROLLARY",
    "APPENDIX_ONLY", "MAIN_PROPOSITION_PART", "MAIN_COROLLARY_FIGURE",
    "MAIN_SUMMARY_COROLLARY", "MAIN_INTUITION"
  ))
)

ledger_paths <- c(
  A_M = "model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv",
  A_U = "model_redesign/agenda_extension_A_U_msb_claim_ledger.tsv",
  AC = "model_redesign/agenda_extension_AC_msb_claim_ledger.tsv",
  AR = "model_redesign/agenda_extension_AR_msb_claim_ledger.tsv"
)

ledgers <- lapply(ledger_paths, function(path) {
  read.delim(path, sep = "\t", quote = "", check.names = FALSE, stringsAsFactors = FALSE)
})

for (i in seq_len(nrow(matrix))) {
  row <- matrix[i, ]
  prefix <- paste0(row$migration_id, ": ")

  record_check(
    paste0(prefix, "source artifact exists"),
    file.exists(row$source_artifact),
    row$source_artifact
  )
  record_check(
    paste0(prefix, "source artifact hash matches"),
    identical(sha256(row$source_artifact), row$source_sha256),
    row$source_sha256
  )
  record_check(
    paste0(prefix, "governing manifest hash matches"),
    identical(sha256(row$governing_manifest), row$governing_manifest_sha256),
    row$governing_manifest_sha256
  )

  ledger <- ledgers[[row$source_node]]
  ledger_claim_column <- intersect(c("claim_id", "claim"), names(ledger))
  record_check(
    paste0(prefix, "ledger exposes a claim-id column"),
    length(ledger_claim_column) == 1L,
    paste(names(ledger), collapse = ", ")
  )
  if (length(ledger_claim_column) == 1L) {
    claims <- split_claims(row$claim_ids)
    record_check(
      paste0(prefix, "all claims exist in the source ledger"),
      all(claims %in% ledger[[ledger_claim_column]]),
      paste(claims, collapse = ", ")
    )
  }
}

v6_text <- readLines("formal_model_v6.Rmd", warn = FALSE, encoding = "UTF-8")
for (i in seq_len(nrow(matrix))) {
  row <- matrix[i, ]
  record_check(
    paste0(row$migration_id, ": current-v6 anchor exists"),
    any(grepl(row$current_v6_anchor, v6_text, fixed = TRUE)),
    row$current_v6_anchor
  )
}

expected_snapshot <- c(
  "formal_model_v6.Rmd" = "00bbaa3a5768348fede3f6584bab915b7c1dbf1fd1cccbf723bb64a90188e4a6",
  "formal_model_v6.pdf" = "3602b0753a8a61ddcb2450f7181ba2f8fc53b9f73ad16cdfbb46e337019182be"
)
for (path in names(expected_snapshot)) {
  record_check(
    paste0(path, " remains on the approved snapshot"),
    identical(sha256(path), unname(expected_snapshot[[path]])),
    unname(expected_snapshot[[path]])
  )
}

final_manifests <- c(
  "quality_reports/2026-08-29_A_M_msb_two_layer_final_gate_manifest.sha256",
  "quality_reports/2026-08-30_A_U_msb_two_layer_final_gate_manifest.sha256",
  "quality_reports/2026-08-30_A_C_msb_strengthened_final_gate_manifest.sha256",
  "quality_reports/2026-08-30_A_R_msb_final_gate_manifest.sha256"
)
for (path in final_manifests) {
  verification <- verify_manifest(path)
  record_check(
    paste0(basename(path), " verifies"),
    verification$ok,
    verification$output
  )
}

pass_count <- sum(vapply(checks, function(x) x$status == "PASS", logical(1)))
fail_count <- length(checks) - pass_count
lines <- c(
  "Agenda-extension migration-matrix verifier",
  "This is a mechanical integrity check; it is not mathematical or editorial approval.",
  "",
  vapply(checks, function(x) {
    detail <- if (nzchar(x$detail)) paste0(" | ", x$detail) else ""
    paste0(x$status, " | ", x$label, detail)
  }, character(1)),
  "",
  sprintf("SUMMARY | %d PASS | %d FAIL", pass_count, fail_count)
)

writeLines(lines, con = stdout(), useBytes = TRUE)
if (!is.na(output_path)) {
  writeLines(lines, con = output_path, useBytes = TRUE)
}

if (fail_count > 0L) quit(status = 1L)
