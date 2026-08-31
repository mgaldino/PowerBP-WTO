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
decision_doc <- "quality_reports/plans/2026-08-30_decisao_arquitetura_editorial_agenda_extension.md"
positioning_doc <- "quality_reports/2026-08-31_sintese_posicionamento_geb_pc_e_seminario.md"
synthesis_doc <- "reports/chatgpt_pro_packets/2026-08-30_sintese_comparacoes_agenda_informacao_tipo_baixo.md"
editorial_manifest <- "quality_reports/plans/2026-08-31_agenda_extension_migration_editorial_inputs.sha256"
round2_manifest <- "quality_reports/plans/2026-08-31_agenda_extension_migration_round2_inputs.sha256"
seminar_extract <- "quality_reports/2026-08-31_seminar_and_steinberg_migration_extract.md"
steinberg_doc <- "notes/2026-08-31_rationalist_reconstruction_steinberg_paper_note.md"
presentation_pdf <- "/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/presentations/2026-08-30_agenda_information_seminar/seminario_agenda_informacao.pdf"
presentation_rmd <- "/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/presentations/2026-08-30_agenda_information_seminar/seminario_agenda_informacao.Rmd"

expected_columns <- c(
  "migration_id", "source_node", "claim_ids", "source_artifact",
  "source_sha256", "governing_manifest", "governing_manifest_sha256",
  "current_v6_anchor", "proposed_action", "proposed_destination", "placement",
  "proof_destination", "editorial_status", "scope_guard"
)

record_check("matrix TSV exists", file.exists(matrix_path), matrix_path)
record_check("matrix explanatory document exists", file.exists(matrix_doc), matrix_doc)
record_check("editorial proposal exists", file.exists(proposal_doc), proposal_doc)
record_check("authorial architecture decision exists", file.exists(decision_doc), decision_doc)
record_check("positioning synthesis exists", file.exists(positioning_doc), positioning_doc)
record_check("additional-comparisons synthesis exists", file.exists(synthesis_doc), synthesis_doc)
record_check("editorial-input manifest exists", file.exists(editorial_manifest), editorial_manifest)
record_check("round-2 input manifest exists", file.exists(round2_manifest), round2_manifest)
record_check("seminar and Steinberg extraction exists", file.exists(seminar_extract), seminar_extract)
record_check("rationalist Steinberg note exists", file.exists(steinberg_doc), steinberg_doc)
record_check("final seminar PDF exists", file.exists(presentation_pdf), presentation_pdf)
record_check("seminar source Rmd exists", file.exists(presentation_rmd), presentation_rmd)

matrix <- read.delim(
  matrix_path,
  sep = "\t",
  quote = "",
  check.names = FALSE,
  stringsAsFactors = FALSE
)

record_check("matrix has the exact schema", identical(names(matrix), expected_columns), paste(names(matrix), collapse = ", "))
record_check("matrix has 34 migration rows", nrow(matrix) == 34L, paste("rows:", nrow(matrix)))
record_check("migration ids are unique", !anyDuplicated(matrix$migration_id), paste(matrix$migration_id, collapse = ", "))
formal_nodes <- c("A_M", "A_U", "AC", "AR", "AT")
nonformal_nodes <- c("SYNTH", "EDITORIAL", "POSITIONING", "SEMINAR", "STEINBERG")
record_check("all source nodes are allowed", all(matrix$source_node %in% c(formal_nodes, nonformal_nodes)))
record_check(
  "all rows remain unauthorized or blocked",
  all(matrix$editorial_status %in% c("PROPOSED_NOT_AUTHORIZED", "BLOCKED_PENDING_AT_FREEZE"))
)
expected_blocked <- c("MIG-AT-01", "MIG-AT-02", "MIG-AT-03", "MIG-AT-04", "MIG-AT-05", "MIG-SEM-03")
record_check(
  "exactly the AT-dependent rows are blocked pending freeze",
  setequal(matrix$migration_id[matrix$editorial_status == "BLOCKED_PENDING_AT_FREEZE"], expected_blocked),
  paste(expected_blocked, collapse = ", ")
)
record_check(
  "every other row remains proposed but unauthorized",
  all(matrix$editorial_status[!matrix$migration_id %in% expected_blocked] == "PROPOSED_NOT_AUTHORIZED")
)
record_check(
  "all actions are controlled",
  all(matrix$proposed_action %in% c(
    "ADD_EXTENSION", "PRESERVE_AND_CITE", "MOVE_TECHNICAL",
    "APPLY_EDITORIAL_DECISION", "REVISE_NARRATIVE", "ADD_TABLE"
  ))
)
record_check(
  "all placements are controlled",
  all(matrix$placement %in% c(
    "MAIN_SETUP", "MAIN_SUMMARY", "MAIN_PROPOSITION", "MAIN_COROLLARY",
    "APPENDIX_ONLY", "MAIN_PROPOSITION_PART", "MAIN_COROLLARY_FIGURE",
    "MAIN_SUMMARY_COROLLARY", "MAIN_INTUITION", "PAPER_ARCHITECTURE",
    "MAIN_NARRATIVE", "TITLE", "MAIN_POSITIONING", "MAIN_APPLICATION",
    "MAIN_TABLE", "MAIN_SCOPE"
  ))
)

ledger_paths <- c(
  A_M = "model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv",
  A_U = "model_redesign/agenda_extension_A_U_msb_claim_ledger.tsv",
  AC = "model_redesign/agenda_extension_AC_msb_claim_ledger.tsv",
  AR = "model_redesign/agenda_extension_AR_msb_claim_ledger.tsv",
  AT = "model_redesign/agenda_extension_AT_msb_claim_ledger.tsv"
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

  if (row$source_node %in% formal_nodes) {
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
  } else {
    record_check(
      paste0(prefix, "non-formal source has explicit locators"),
      nzchar(row$claim_ids) && all(nzchar(split_claims(row$claim_ids))),
      row$claim_ids
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

verified_manifests <- c(
  "quality_reports/2026-08-29_A_M_msb_two_layer_final_gate_manifest.sha256",
  "quality_reports/2026-08-30_A_U_msb_two_layer_final_gate_manifest.sha256",
  "quality_reports/2026-08-30_A_C_msb_strengthened_final_gate_manifest.sha256",
  "quality_reports/2026-08-30_A_R_msb_final_gate_manifest.sha256",
  "quality_reports/2026-08-30_AT_msb_review_gate_manifest.sha256",
  editorial_manifest,
  round2_manifest
)
for (path in verified_manifests) {
  verification <- verify_manifest(path)
  record_check(
    paste0(basename(path), " verifies"),
    verification$ok,
    verification$output
  )
}

matrix_doc_text <- readLines(matrix_doc, warn = FALSE, encoding = "UTF-8")
record_check(
  "final seminar PDF hash is fixed",
  identical(sha256(presentation_pdf), "f921ecf8a0885492a22999946dce7d6f8e4a4d13e4d58b9c5b991aacbc0e3836"),
  presentation_pdf
)
record_check(
  "seminar source Rmd hash is fixed",
  identical(sha256(presentation_rmd), "82e24a0a2ba2402becc4996640426f60db88225df925b4c9d698e909cf49f4b4"),
  presentation_rmd
)
record_check(
  "Steinberg note hash is fixed",
  identical(sha256(steinberg_doc), "b29e5dcbb79395967423cd98a409a085281faf6f596910d9a02e0a44b58a2c6c"),
  steinberg_doc
)
record_check(
  "matrix records final presentation as consumed read-only",
  any(grepl("CONSUMED_READ_ONLY_FINAL", matrix_doc_text, fixed = TRUE)),
  "CONSUMED_READ_ONLY_FINAL"
)
record_check(
  "matrix no longer records the presentation hold",
  !any(grepl("LOCATED_AWAITING_AUTHOR_OK", matrix_doc_text, fixed = TRUE)),
  "LOCATED_AWAITING_AUTHOR_OK absent"
)
record_check(
  "matrix records the absolute final presentation path",
  any(grepl(presentation_pdf, matrix_doc_text, fixed = TRUE)),
  presentation_pdf
)

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
