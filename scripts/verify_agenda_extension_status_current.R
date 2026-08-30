#!/usr/bin/env Rscript

# Mechanical lifecycle reconciliation check for the agenda extension.
# This script verifies hashes and authorization boundaries. It is not a new
# mathematical review of A_M, A_U, AC, or AR.

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("Package 'jsonlite' is required.", call. = FALSE)
}

root <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
status_path <- file.path(root, "model_redesign/agenda_extension_status_current.json")

pass_count <- 0L
fail_count <- 0L

record_check <- function(condition, label) {
  if (isTRUE(condition)) {
    pass_count <<- pass_count + 1L
    cat(sprintf("PASS | %s\n", label))
  } else {
    fail_count <<- fail_count + 1L
    cat(sprintf("FAIL | %s\n", label))
  }
}

sha256 <- function(relative_path) {
  absolute_path <- file.path(root, relative_path)
  if (!file.exists(absolute_path)) return(NA_character_)
  output <- suppressWarnings(system2(
    "shasum",
    c("-a", "256", absolute_path),
    stdout = TRUE,
    stderr = TRUE
  ))
  if (length(output) < 1L) return(NA_character_)
  hash_lines <- grep("^[0-9a-f]{64}", output, value = TRUE)
  if (length(hash_lines) < 1L) return(NA_character_)
  match <- regmatches(hash_lines[[1L]], regexpr("^[0-9a-f]{64}", hash_lines[[1L]]))
  if (length(match) == 0L || identical(match, "")) NA_character_ else match
}

node_by_id <- function(status, node_id) {
  hits <- Filter(function(node) identical(node$node_id, node_id), status$nodes)
  if (length(hits) != 1L) return(NULL)
  hits[[1L]]
}

legacy_a_m_status <- function(relative_path) {
  legacy <- jsonlite::fromJSON(
    file.path(root, relative_path),
    simplifyVector = FALSE
  )
  nodes <- if (!is.null(legacy$nodes)) legacy$nodes else legacy$produced_nodes
  hits <- Filter(function(node) identical(node$node_id, "A_M"), nodes)
  if (length(hits) != 1L) return(NA_character_)
  hits[[1L]]$status
}

record_check(file.exists(status_path), "current structured status exists")
status <- jsonlite::fromJSON(status_path, simplifyVector = FALSE)

record_check(
  identical(status$schema_version, "agenda_extension_lifecycle_status_v1"),
  "status schema is agenda_extension_lifecycle_status_v1"
)
record_check(identical(status$as_of, "2026-08-29"), "status date is pinned")
record_check(
  identical(status$authority$sha256,
            "ca109199060f3aa775f6e2f18ef46fd9cefaff522cc3f7fdeeabfe9d5f412158"),
  "terminal authority hash is pinned"
)
record_check(
  identical(status$authority$final_gate_manifest_sha256,
            "8eb870d5595a4373994e8f47a25a3dd137b00ac8c32fc09b947444498a32775e"),
  "final gate manifest hash is pinned"
)
record_check(
  identical(status$snapshot$candidate_manifest_sha256,
            "4130c09b9a7d504e0dd18f63c8793a0f6ce5f239369c585d924c48742177c0aa"),
  "candidate manifest hash is pinned"
)
record_check(
  identical(status$snapshot$terminal_closure_commit,
            "e191099a378a32bd2192d437455493e5e3300816"),
  "terminal closure commit is pinned"
)

record_check(
  identical(sha256(status$authority$path), status$authority$sha256),
  "terminal authority bytes match"
)
record_check(
  identical(sha256(status$authority$final_gate_manifest_path),
            status$authority$final_gate_manifest_sha256),
  "final gate manifest bytes match"
)
record_check(
  identical(sha256(status$snapshot$candidate_manifest_path),
            status$snapshot$candidate_manifest_sha256),
  "candidate manifest bytes match"
)

a_m <- node_by_id(status, "A_M")
a_u <- node_by_id(status, "A_U")
ac <- node_by_id(status, "AC")
ar <- node_by_id(status, "AR")

record_check(!is.null(a_m), "A_M has exactly one current status record")
record_check(!is.null(a_u), "A_U has exactly one current status record")
record_check(!is.null(ac), "AC has exactly one current status record")
record_check(!is.null(ar), "AR has exactly one current status record")
record_check(
  identical(a_m$status, "pass") && isTRUE(a_m$frozen) &&
    identical(a_m$authorization, "terminal_author_approval"),
  "A_M is pass/frozen with terminal author approval"
)
record_check(
  identical(a_u$status, "pending") && identical(a_u$frozen, FALSE) &&
    identical(a_u$authorization, "none"),
  "A_U remains pending/unfrozen and unauthorized"
)
record_check(
  identical(ac$status, "pending") && identical(ac$frozen, FALSE) &&
    identical(ac$authorization, "none"),
  "AC remains pending/unfrozen and unauthorized"
)
record_check(
  identical(ar$status, "pending") && identical(ar$frozen, FALSE) &&
    identical(ar$authorization, "none"),
  "AR remains pending/unfrozen and unauthorized"
)

expected_frozen_hashes <- c(
  "model_redesign/agenda_extension_A_M_msb_results.md" =
    "7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3",
  "model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv" =
    "321cb2ed45ed1c5ebb6103a4ac567f07b735dd7a2ca8e2252925b43b8a2add9c",
  "scripts/verify_agenda_extension_A_M_msb.R" =
    "b3133ab97870cf9c5730c57da40c2c9f4d68912226bb8d8f080022653e2a8391",
  "quality_reports/verification_outputs/2026-08-29_A_M_msb_two_layer_signature_verifier_output.txt" =
    "3a242732c07b3d6ed5c508ca0238d1665c42de9d4f00f857b4030fe724ce7628"
)

status_frozen_hashes <- setNames(
  vapply(a_m$frozen_artifacts, function(x) x$sha256, character(1L)),
  vapply(a_m$frozen_artifacts, function(x) x$path, character(1L))
)
record_check(
  identical(status_frozen_hashes[names(expected_frozen_hashes)], expected_frozen_hashes),
  "structured status lists the four exact frozen A_M artifact hashes"
)
for (relative_path in names(expected_frozen_hashes)) {
  record_check(
    identical(sha256(relative_path), unname(expected_frozen_hashes[[relative_path]])),
    sprintf("frozen bytes match: %s", relative_path)
  )
}

dependency <- a_m$depends_on[[1L]]
record_check(
  identical(dependency$sha256,
            "ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d") &&
    identical(sha256(dependency$path), dependency$sha256),
  "frozen C_M dependency matches its pinned hash"
)

expected_review_hashes <- c(
  "quality_reports/2026-08-29_A_M_msb_two_layer_signature_formal_review_1.md" =
    "1b71c06b52b26f7455f75d58df1896ffe325f90af6aa24dbef63db331af01519",
  "quality_reports/2026-08-29_A_M_msb_two_layer_signature_formal_review_2.md" =
    "ff78147c2cd20f764d6ba70fee433a925054ac99c80bb32f4b5967e88ebb5cc3"
)
review_hashes <- setNames(
  vapply(a_m$reviews, function(x) x$sha256, character(1L)),
  vapply(a_m$reviews, function(x) x$path, character(1L))
)
record_check(
  identical(review_hashes[names(expected_review_hashes)], expected_review_hashes),
  "structured status lists both exact formal-review hashes"
)
record_check(
  all(vapply(a_m$reviews, function(x) {
    identical(x$verdict, "PASS") && identical(x$findings, "0/0/0")
  }, logical(1L))),
  "both formal reviews are recorded as PASS 0/0/0"
)
for (relative_path in names(expected_review_hashes)) {
  record_check(
    identical(sha256(relative_path), unname(expected_review_hashes[[relative_path]])),
    sprintf("review bytes match: %s", relative_path)
  )
}

record_check(
  identical(a_m$adjudication$verdict, "NO_CONFIRMED_DEFECTS") &&
    identical(a_m$adjudication$counts$confirmed, 0L) &&
    identical(a_m$adjudication$counts$partial, 0L) &&
    identical(a_m$adjudication$counts$unresolved, 0L),
  "adjudication verdict and zero counts are preserved"
)
record_check(
  identical(sha256(a_m$adjudication$markdown_path),
            a_m$adjudication$markdown_sha256),
  "adjudication Markdown bytes match"
)
record_check(
  identical(sha256(a_m$adjudication$json_path),
            a_m$adjudication$json_sha256),
  "adjudication JSON bytes match"
)

expected_legacy_hashes <- c(
  "model_redesign/agenda_extension_game_dag.json" =
    "9644151b8441ed5d09d1a870c3a2f5b94437c2376c7af6fb419c17297ebd5cd6",
  "model_redesign/agenda_extension_game_dag_simplified.json" =
    "a2572dc8954d63535d4edcbf04158e9524d11ed4537a822713e534df580ee9e0",
  "scripts/verify_agenda_extension_A_M_mechanical.R" =
    "1512fe8b31b65d44ef58fcbba2c58e345e3631f767aac9a0f363f897c7d28747"
)
legacy_hashes <- setNames(
  vapply(status$legacy_status_sources, function(x) x$sha256, character(1L)),
  vapply(status$legacy_status_sources, function(x) x$path, character(1L))
)
record_check(
  identical(legacy_hashes[names(expected_legacy_hashes)], expected_legacy_hashes),
  "structured status pins the preserved legacy sources"
)
for (relative_path in names(expected_legacy_hashes)) {
  record_check(
    identical(sha256(relative_path), unname(expected_legacy_hashes[[relative_path]])),
    sprintf("legacy provenance bytes remain unchanged: %s", relative_path)
  )
}
record_check(
  identical(legacy_a_m_status("model_redesign/agenda_extension_game_dag.json"), "pending"),
  "pre-M/S/B DAG still records its historical A_M pending state"
)
record_check(
  identical(legacy_a_m_status("model_redesign/agenda_extension_game_dag_simplified.json"), "pending"),
  "simplified pre-M/S/B DAG still records its historical A_M pending state"
)

record_check(
  identical(status$downstream$authorization, "none") &&
    identical(status$downstream$manuscript_migration_authorized, FALSE) &&
    identical(status$downstream$tag_authorized, FALSE) &&
    identical(status$downstream$merge_authorized, FALSE) &&
    identical(status$downstream$push_authorized, FALSE),
  "no downstream, manuscript, tag, merge, or push authorization is introduced"
)

status_md <- readLines(
  file.path(root, status$human_readable_status),
  warn = FALSE,
  encoding = "UTF-8"
)
record_check(
  any(grepl("A_M.*pass/frozen", status_md, fixed = FALSE, useBytes = TRUE)),
  "human-readable status identifies A_M as pass/frozen"
)
record_check(
  any(grepl("A_U.*pending/unfrozen", status_md, fixed = FALSE, useBytes = TRUE)),
  "human-readable status preserves A_U as pending/unfrozen"
)

cat(sprintf("SUMMARY | %d PASS | %d FAIL\n", pass_count, fail_count))
if (fail_count > 0L) quit(status = 1L)
