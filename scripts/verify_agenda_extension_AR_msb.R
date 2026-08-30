#!/usr/bin/env Rscript

# Mechanical falsification harness for A_R under M/S/B.
# It checks frozen-source bytes, schemas, dependency ordering and finite-grid
# identities for public agenda games, informational rents and interactions.
# It does NOT prove PBE completeness, abstract Borel factorization or
# selection-free universal statements outside the checked algebra.

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1L) {
  stop("Usage: Rscript scripts/verify_agenda_extension_AR_msb.R OUTPUT_PATH")
}

Sys.setenv(LC_ALL = "C", LANG = "C")

output_path <- args[[1L]]
dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
sink(output_path, split = TRUE)
on.exit(sink(), add = TRUE)

pass_count <- 0L
fail_count <- 0L

check <- function(label, condition) {
  condition <- isTRUE(condition)
  if (condition) {
    pass_count <<- pass_count + 1L
    cat(sprintf("PASS | %s\n", label))
  } else {
    fail_count <<- fail_count + 1L
    cat(sprintf("FAIL | %s\n", label))
  }
  invisible(condition)
}

close_num <- function(x, y, tol = 1e-10) {
  isTRUE(length(x) == length(y) && all(is.finite(x) == is.finite(y)) &&
           all(abs(x[is.finite(x)] - y[is.finite(y)]) <= tol))
}

sha256 <- function(path) {
  out <- system2("shasum", c("-a", "256", path), stdout = TRUE, stderr = TRUE)
  if (!is.null(attr(out, "status")) && attr(out, "status") != 0L) {
    return(NA_character_)
  }
  hash_line <- grep("^[0-9a-f]{64}[[:space:]]", out, value = TRUE)
  if (length(hash_line) != 1L) return(NA_character_)
  strsplit(hash_line[[1L]], "[[:space:]]+")[[1L]][[1L]]
}

check_manifest <- function(path) {
  out <- suppressWarnings(system2(
    "shasum", c("-a", "256", "-c", path), stdout = TRUE, stderr = TRUE
  ))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  lines <- grep(": OK$", out, value = TRUE)
  status == 0L && length(lines) > 0L && all(grepl("OK$", lines))
}

cat("A_R M/S/B public benchmark and rent mechanical verifier\n")
cat("Snapshot date: 2026-08-30\n")
cat("Orientation: U-M\n")
cat("Claim boundary: finite mechanical checks only; not an independent mathematical review\n\n")

source_hashes <- c(
  "quality_reports/plans/2026-08-30_autorizacao_inicio_A_R.md" =
    "0bc58b63f05de25ad9ef134dbf0fdf02d3ca2e4c50c0fd1b9627d6f0eced5e09",
  "quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md" =
    "fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4",
  "quality_reports/2026-08-27_fechamento_autoral_gate0_agenda_extension_simplified.md" =
    "0a8ccf93b6986b1a9d7ad552c8ae690ea4e0a7816ec1999bf8a3dc454c85d26d",
  "quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md" =
    "8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b",
  "model_redesign/agenda_extension_AC_msb_interface.json" =
    "ea869c023ce7426dae3b92ffad344b4c79f1f0ce220b8fffaceb011904a85249",
  "model_redesign/agenda_extension_AC_msb_results.md" =
    "8cadee000f6b8a9f94aff754fdb680f427b731bccf121ae642126a9383693d0a",
  "quality_reports/2026-08-30_A_C_msb_strengthened_terminal_approval_and_freeze.md" =
    "b331f88b7abb99c03a5a8c657d163d1e006c0cf4cb51e744abcee298ac6af557",
  "quality_reports/2026-08-30_A_C_msb_strengthened_final_gate_manifest.sha256" =
    "332d1d7be7a7b38f715c8d7d872c6f7010c22a27fc924b91e8f694199a190fe4",
  "model_redesign/essential_input_n7_complete_information_benchmark_candidate.json" =
    "4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45",
  "quality_reports/2026-08-21_fechamento_autoral_goal4_n7.md" =
    "ca7a842b3a953ab16e76dbf518692a0d05a87d1224093a53d4ccc647624545d2",
  "model_redesign/agenda_extension_goal1_external_interfaces.json" =
    "588e7da2ec7df2f208ccaf082d3bc30834ea12625484b04b25d3eae7fce20a86",
  "quality_reports/2026-08-27_fechamento_goal1_agenda_extension.md" =
    "282c2f397fd8f7ecd4b6817ceda71a17ddac1fe0a5c879201c4a54864dd9461c",
  "model_redesign/agenda_extension_game_dag_simplified.json" =
    "a2572dc8954d63535d4edcbf04158e9524d11ed4537a822713e534df580ee9e0",
  "scripts/agenda_extension_goal1_verifier_lib.R" =
    "b067fac9f4b059c5eb5638b23119601ae527dc98ac9dc17d26792711eb752492"
)

for (path in names(source_hashes)) {
  check(sprintf("frozen/source byte hash: %s", path),
        file.exists(path) && identical(sha256(path), source_hashes[[path]]))
}
check("AC final manifest verifies all frozen entries",
      check_manifest("quality_reports/2026-08-30_A_C_msb_strengthened_final_gate_manifest.sha256"))

contract_path <- "model_redesign/agenda_extension_AR_msb_contract.md"
results_path <- "model_redesign/agenda_extension_AR_msb_results.md"
interface_path <- "model_redesign/agenda_extension_AR_msb_interface.json"
ledger_path <- "model_redesign/agenda_extension_AR_msb_claim_ledger.tsv"
complete_records_path <- "model_redesign/agenda_extension_AR_msb_complete_records.json"
canonical_dag_path <- "model_redesign/agenda_extension_game_dag_simplified.json"
generic_verifier_path <- "scripts/agenda_extension_goal1_verifier_lib.R"

for (path in c(contract_path, results_path, interface_path, ledger_path,
               complete_records_path)) {
  check(sprintf("candidate artifact exists: %s", path), file.exists(path))
}

contract_text <- paste(readLines(contract_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
results_text <- paste(readLines(results_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
interface_text <- paste(readLines(interface_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
n7_text <- paste(readLines(
  "model_redesign/essential_input_n7_complete_information_benchmark_candidate.json",
  warn = FALSE, encoding = "UTF-8"
), collapse = "\n")

json_status <- vapply(c(interface_path, complete_records_path, canonical_dag_path), function(path) {
  status <- suppressWarnings(system2(
    "python3", c("-m", "json.tool", path), stdout = FALSE, stderr = FALSE
  ))
  if (is.null(status)) 0L else as.integer(status)
}, integer(1L))
check("AR interface, complete records and canonical DAG are valid JSON",
      all(json_status == 0L))

ledger <- read.delim(
  ledger_path,
  sep = "\t",
  quote = "",
  stringsAsFactors = FALSE,
  check.names = FALSE,
  encoding = "UTF-8"
)
expected_columns <- c(
  "claim_id", "node_id", "cell_id", "record_or_family_id",
  "member_domain", "claim_kind", "claim_text", "domain", "status",
  "selection_status", "assumptions_used", "source_record_ids",
  "source_hashes", "payoff_date", "evidence_path", "proof_path"
)
check("AR ledger has the exact 16-column schema", identical(names(ledger), expected_columns))
check("AR ledger has 30 unique sequential claim ids",
      nrow(ledger) == 30L && !anyDuplicated(ledger$claim_id) &&
        identical(ledger$claim_id, sprintf("AR-MSB-%03d", seq_len(30L))))
check("every AR ledger payoff is typed at date A", all(ledger$payoff_date == "A"))
check("none convention and lifecycle boundary are explicit",
      any(ledger$claim_id == "AR-MSB-027") &&
        any(ledger$claim_id == "AR-MSB-030") &&
        grepl('"manuscript_migration": false', interface_text, fixed = TRUE) &&
        grepl('"terminal_freeze": false', interface_text, fixed = TRUE))

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  check("jsonlite available for generic schema checks", FALSE)
} else {
  source(generic_verifier_path, local = TRUE)
  interface <- jsonlite::read_json(interface_path, simplifyVector = FALSE)
  complete_records <- jsonlite::read_json(complete_records_path, simplifyVector = FALSE)
  canonical_dag <- jsonlite::read_json(canonical_dag_path, simplifyVector = FALSE)
  n7_interface <- jsonlite::read_json(
    "model_redesign/essential_input_n7_complete_information_benchmark_candidate.json",
    simplifyVector = FALSE
  )

  dag_issues <- agenda_validate_dag(canonical_dag)
  check("canonical Gate 0 DAG passes the approved generic validator",
        length(dag_issues) == 0L)
  check("AR uses the canonical DAG only as immutable topology/provenance",
        identical(interface$canonical_dag$path, canonical_dag_path) &&
          identical(interface$canonical_dag$sha256, sha256(canonical_dag_path)) &&
          grepl("topology", interface$canonical_dag$role, fixed = TRUE) &&
          !file.exists("model_redesign/agenda_extension_AR_msb_game_dag.json"))

  complete_hash <- sha256(complete_records_path)
  check("summary interface pins the complete-record export",
        identical(interface$complete_records_export$path, complete_records_path) &&
          identical(interface$complete_records_export$sha256, complete_hash))
  check("abbreviated public objects are labeled economic summaries, not complete records",
        "public_economic_summaries" %in% names(interface) &&
          !"public_equilibrium_records" %in% names(interface))

  family_records <- complete_records$public_family_records
  family_ids <- vapply(family_records, function(record) record$family_record_id,
                       character(1L))
  check("complete public family IDs are unique", !anyDuplicated(family_ids))
  check("every complete public family is explicitly indexed by public type",
        all(vapply(family_records, function(record) {
          agenda_nonempty_scalar(record$public_type)
        }, logical(1L))))
  family_issues <- unlist(lapply(family_records, agenda_validate_family_record),
                          use.names = FALSE)
  check("every complete public family passes the approved generic family validator",
        length(family_issues) == 0L)

  collection_fields <- c(
    "collection_id", "node_id", "institution", "domain", "status",
    "family_record_ids", "source_complete_view_id", "cells", "proof_paths"
  )
  cell_fields <- c("cell_id", "domain", "status", "family_record_ids",
                   "none_reason", "proof_path")
  collection_issues <- unlist(lapply(
    complete_records$public_equilibrium_collections,
    function(collection) {
      issues <- agenda_missing_fields(collection, collection_fields)
      if (!length(issues)) {
        cited <- unlist(collection$family_record_ids, use.names = FALSE)
        if (!all(cited %in% family_ids)) issues <- c(issues, "unknown family ID")
        for (cell in collection$cells) {
          issues <- c(issues, agenda_missing_fields(cell, cell_fields))
          cell_ids <- unlist(cell$family_record_ids, use.names = FALSE)
          if (!all(cell_ids %in% family_ids)) issues <- c(issues, "unknown cell family ID")
        }
      }
      issues
    }
  ), use.names = FALSE)
  check("public collections and cells cite complete known family records",
        length(collection_issues) == 0L)

  derived_base_fields <- c(
    "source_ids_and_hashes", "source_binders", "native_values",
    "native_dates", "transport_factors_to_A", "beta_application_counts",
    "values_at_A", "proof_path"
  )
  benchmark_base_fields <- c(
    "source_ids_and_hashes", "source_atomic_binders", "native_values",
    "native_dates", "transport_factors_to_A", "beta_application_counts",
    "values_at_A", "proof_path"
  )
  exact_fields <- c(
    rep("exact_object_at_A", length(complete_records$benchmark_records)),
    rep("exact_rent_set_at_A", length(complete_records$agenda_rent_records)),
    "exact_contrast_set_at_A",
    rep("exact_interaction_set_at_A", length(complete_records$interaction_records)),
    "exact_interaction_set_at_A"
  )
  derived_records <- c(
    complete_records$benchmark_records,
    complete_records$agenda_rent_records,
    list(complete_records$institutional_rent_record),
    complete_records$interaction_records,
    list(complete_records$institutional_interaction_record)
  )
  derived_issues <- character()
  for (index in seq_along(derived_records)) {
    required <- if (index <= length(complete_records$benchmark_records)) {
      benchmark_base_fields
    } else {
      derived_base_fields
    }
    required <- c(required, exact_fields[[index]])
    derived_issues <- c(
      derived_issues,
      agenda_missing_fields(derived_records[[index]], required)
    )
    if (agenda_has_payoff_sentinel(derived_records[[index]])) {
      derived_issues <- c(derived_issues, "payoff sentinel")
    }
  }
  check("every derived record contains the complete source/date/transport tuple and exact object",
        length(derived_issues) == 0L)

  expected_n7_dri_cells <- c(
    "N7-DRI-CELL-II-NU-ZERO", "N7-DRI-CELL-II-NONE", "N7-DRI-CELL-II-HIGH",
    "N7-DRI-CELL-IX-NU-ZERO", "N7-DRI-CELL-IX-NONE", "N7-DRI-CELL-IX-HIGH",
    "N7-DRI-CELL-XX-NU-ZERO", "N7-DRI-CELL-XX-NONE", "N7-DRI-CELL-XX-HIGH"
  )
  n7_dri_cells <- n7_interface$informational_rent_contrast_cells
  n7_dri_ids <- vapply(n7_dri_cells, function(cell) cell$cell_id, character(1L))
  n7_dri_statuses <- vapply(
    n7_dri_cells, function(cell) cell$existence_status, character(1L)
  )
  check("frozen N7 institutional-rent source has exactly the expected 9/6/3 cells",
        length(n7_dri_ids) == 9L && !anyDuplicated(n7_dri_ids) &&
          setequal(n7_dri_ids, expected_n7_dri_cells) &&
          sum(n7_dri_statuses == "exists") == 6L &&
          sum(n7_dri_statuses == "none") == 3L)

  validate_n7_dri_map <- function(map, source_cells) {
    issues <- character()
    required <- c(
      "cell_id", "existence_status", "contrast_record_id",
      "certificate_source_cell_id"
    )
    if (!is.list(map) || length(map) != 9L) return("map is not a nine-entry list")
    map_ids <- vapply(map, function(entry) {
      if (is.null(entry$cell_id)) "" else entry$cell_id
    }, character(1L))
    source_ids <- vapply(source_cells, function(cell) cell$cell_id, character(1L))
    if (anyDuplicated(map_ids) || !setequal(map_ids, source_ids)) {
      issues <- c(issues, "map cell inventory differs from frozen N7")
    }
    source_index <- setNames(source_cells, source_ids)
    for (entry in map) {
      missing <- agenda_missing_fields(entry, required)
      if (length(missing)) {
        issues <- c(issues, paste("map entry missing", paste(missing, collapse = ",")))
        next
      }
      source_cell <- source_index[[entry$cell_id]]
      if (is.null(source_cell)) {
        issues <- c(issues, "map cites unknown N7 cell")
        next
      }
      if (!identical(entry$existence_status, source_cell$existence_status)) {
        issues <- c(issues, paste(entry$cell_id, "status mismatch"))
      }
      records <- source_cell$informational_rent_contrast_records
      record_ids <- if (length(records)) {
        vapply(records, function(record) record$contrast_record_id, character(1L))
      } else {
        character()
      }
      if (identical(source_cell$existence_status, "exists")) {
        if (length(record_ids) != 1L ||
            !identical(entry$contrast_record_id, record_ids[[1L]]) ||
            !is.null(entry$certificate_source_cell_id) ||
            !is.null(source_cell$nonexistence_certificate)) {
          issues <- c(issues, paste(entry$cell_id, "does not resolve its unique record"))
        }
      } else if (identical(source_cell$existence_status, "none")) {
        if (length(record_ids) != 0L ||
            !is.null(entry$contrast_record_id) ||
            !identical(entry$certificate_source_cell_id, entry$cell_id) ||
            is.null(source_cell$nonexistence_certificate)) {
          issues <- c(issues, paste(entry$cell_id, "does not resolve its none certificate"))
        }
      } else {
        issues <- c(issues, paste(entry$cell_id, "has an invalid frozen status"))
      }
    }
    unique(issues)
  }

  n7_dri_map <- complete_records$institutional_interaction_record$
    source_ids_and_hashes$N7_contrast_cell_map
  check("AR institutional interaction resolves all nine N7 cells, records and none certificates",
        length(validate_n7_dri_map(n7_dri_map, n7_dri_cells)) == 0L)

  bad_id_map <- agenda_clone(n7_dri_map)
  first_exists <- which(vapply(
    bad_id_map, function(entry) identical(entry$existence_status, "exists"), logical(1L)
  ))[[1L]]
  bad_id_map[[first_exists]]$contrast_record_id <- "N7-DRI-NOT-A-REAL-RECORD"
  check("negative test rejects an unknown N7 contrast record ID",
        length(validate_n7_dri_map(bad_id_map, n7_dri_cells)) > 0L)

  bad_none_record_map <- agenda_clone(n7_dri_map)
  first_none <- which(vapply(
    bad_none_record_map, function(entry) identical(entry$existence_status, "none"), logical(1L)
  ))[[1L]]
  bad_none_record_map[[first_none]]$contrast_record_id <- "N7-DRI-II-NU-ZERO"
  check("negative test rejects a record ID assigned to an N7 none cell",
        length(validate_n7_dri_map(bad_none_record_map, n7_dri_cells)) > 0L)

  bad_none_certificate_map <- agenda_clone(n7_dri_map)
  bad_none_certificate_map[[first_none]]$certificate_source_cell_id <- NULL
  check("negative test rejects a missing N7 none-certificate reference",
        length(validate_n7_dri_map(bad_none_certificate_map, n7_dri_cells)) > 0L)

  collect_hashes <- function(object) {
    if (is.list(object)) return(unlist(lapply(object, collect_hashes), use.names = FALSE))
    if (is.character(object)) return(object[grepl("^[0-9a-f]{64}$", object)])
    character()
  }
  embedded_hashes <- unique(collect_hashes(complete_records))
  known_external_hashes <- unique(unname(source_hashes))
  check("complete records contain only pinned external hashes and no self hash",
        !complete_hash %in% embedded_hashes &&
          all(embedded_hashes %in% known_external_hashes))

  claim_issues <- unlist(lapply(seq_len(nrow(ledger)), function(index) {
    agenda_validate_claim_row(as.list(ledger[index, , drop = FALSE]))
  }), use.names = FALSE)
  check("all AR ledger rows pass the approved generic claim validator",
        length(claim_issues) == 0L)
}

required_n7_records <- c(
  "N7-PUB-M-R1-T0-INCLUDE", "N7-PUB-M-R1-T0-EXCLUDE",
  "N7-PUB-M-R1-T1-INCLUDE", "N7-PUB-M-R1-T1-EXCLUDE",
  "N7-PUB-U-R1-T0", "N7-PUB-U-R1-T1",
  "N7-RI-M-II", "N7-RI-M-IX", "N7-RI-M-XX",
  "N7-RI-U-NU-ZERO", "N7-RI-U-HIGH"
)
for (record_id in required_n7_records) {
  check(sprintf("frozen N7 record exists: %s", record_id),
        grepl(record_id, n7_text, fixed = TRUE))
}

check("external-option accounting is not subtracted from the weak pie",
      grepl("w_M(o)=1/m", contract_text, fixed = TRUE) &&
        grepl("(1-o)/m", contract_text, fixed = TRUE) &&
        grepl('"external_option_accounting"', interface_text, fixed = TRUE))
check("public majority delay and pass-delay tie are retained",
      grepl("o=tau_M", results_text, fixed = TRUE) &&
        grepl('"record_id": "AR-PUB-M-EXCLUDE-TIE"', interface_text, fixed = TRUE) &&
        grepl('"record_id": "AR-PUB-M-EXCLUDE-DELAY"', interface_text, fixed = TRUE))
check("no current-proposal symmetry or new proposal tie-break is imposed",
      grepl('"current_proposal_symmetry": "not imposed', interface_text, fixed = TRUE) &&
        grepl('"proposal_tie_break": "none added', interface_text, fixed = TRUE))
check("linked type vectors precede ex-ante images",
      regexpr("RI_g^{A,theta}", results_text, fixed = TRUE)[[1L]] <
        regexpr("RI_g^{A,E}", results_text, fixed = TRUE)[[1L]])
check("agenda-rent subtraction applies zero new beta factors",
      grepl('"new_beta_applications_in_agenda_rent_subtraction": 0', interface_text, fixed = TRUE) &&
        grepl("zero novos fatores de `beta`", results_text, fixed = TRUE))
check("N7 no-agenda rent is transported once from R1 to A",
      grepl('"no_agenda_rent_transport_to_A"', interface_text, fixed = TRUE) &&
        grepl("RI_g^{N,A,01}=beta*RI_g^{N,R1,01}", results_text, fixed = TRUE))
check("none cells use null and never numeric sentinels",
      length(gregexpr('"status": "none"', interface_text, fixed = TRUE)[[1L]]) >= 3L &&
        length(gregexpr('"rent_vector": null', interface_text, fixed = TRUE)[[1L]]) == 2L &&
        grepl('"interaction_vector": null', interface_text, fixed = TRUE))

public_values <- function(N, beta, o) {
  m <- N - 1
  k <- floor(N / 2)
  c <- m - k
  z_e <- 1 - k * beta / m
  h_u <- 1 - beta + beta^2 * o
  if (o <= 1 / m) {
    w_m <- (1 - beta * o) / m
    h_m <- 1 - k * beta * (1 - beta * o) / m
    d_m <- beta^2 * o
    branch <- "include"
    agreement <- 1
    g_formula <- beta * (c / m) * (1 - beta * o)
  } else {
    w_m <- 1 / m
    d_m <- beta * o
    h_m <- max(z_e, d_m)
    if (d_m < z_e - 1e-12) {
      branch <- "exclude_pass"
      agreement <- 1
      g_formula <- beta * (c / m - beta * o)
    } else if (d_m > z_e + 1e-12) {
      branch <- "exclude_delay"
      agreement <- 0
      g_formula <- (1 - beta) * (beta * o - 1)
    } else {
      branch <- "exclude_tie"
      agreement <- NA_real_
      g_formula <- beta * (c / m - beta * o)
    }
  }
  list(
    m = m, k = k, c = c, z_e = z_e,
    w_m = w_m, r_m = beta * w_m, d_m = d_m,
    h_m = h_m, h_u = h_u, d_u = beta^2 * o,
    r_u = beta * (1 - beta * o) / m,
    g = h_m - h_u, g_formula = g_formula,
    branch = branch, agreement = agreement,
    tau = z_e / beta
  )
}

for (N in 4:15) {
  m <- N - 1
  k <- floor(N / 2)
  c <- m - k
  check(sprintf("quota identities N=%d", N),
        k == floor(N / 2) && c == m - k && k + 1 <= m && c >= 1)
  for (beta in c(0.1, 0.35, 0.6, 0.85, 0.95, 0.99)) {
    z_e <- 1 - k * beta / m
    tau <- z_e / beta
    check(sprintf("tau_M exceeds 1/m N=%d beta=%.2f", N, beta), tau > 1 / m)
    check(sprintf("Z_E exceeds c/m N=%d beta=%.2f", N, beta), z_e > c / m)

    o_grid <- sort(unique(c(
      0.001, 0.03, max(0.001, 1 / m - 1e-7), 1 / m,
      min(0.999, 1 / m + 1e-7), 0.4, 0.7, 0.95, 0.999
    )))
    o_grid <- o_grid[o_grid > 0 & o_grid < 1]
    for (o in o_grid) {
      v <- public_values(N, beta, o)
      check(sprintf("G identity N=%d beta=%.2f o=%.6f", N, beta, o),
            close_num(v$g, v$g_formula))
      check(sprintf("U pass-delay margin N=%d beta=%.2f o=%.6f", N, beta, o),
            close_num(v$h_u - v$d_u, 1 - beta) && v$h_u > v$d_u)
      if (o <= 1 / m) {
        expected_w <- (1 - beta * o) / m
        check(sprintf("include weak continuation N=%d beta=%.2f o=%.6f", N, beta, o),
              close_num(v$w_m, expected_w))
        check(sprintf("include passage strictly dominates N=%d beta=%.2f o=%.6f", N, beta, o),
              v$h_m - v$d_m > 1 - beta && v$branch == "include")
        check(sprintf("include public gap positive N=%d beta=%.2f o=%.6f", N, beta, o),
              v$g > 0)
      } else {
        check(sprintf("exclude weak continuation keeps unit pie N=%d beta=%.2f o=%.6f", N, beta, o),
              close_num(v$w_m, 1 / m))
        check(sprintf("exclude H payoff is max N=%d beta=%.2f o=%.6f", N, beta, o),
              close_num(v$h_m, max(z_e, beta * o)))
        expected_sign <- sign(c / m - beta * o)
        check(sprintf("exclude G sign N=%d beta=%.2f o=%.6f", N, beta, o),
              sign(v$g) == expected_sign)
      }
    }

    if (tau > 1 / m && tau < 1) {
      tie <- public_values(N, beta, tau)
      g_pass <- beta * (c / m - beta * tau)
      g_delay <- (1 - beta) * (beta * tau - 1)
      check(sprintf("pass-delay tie payoff N=%d beta=%.2f", N, beta),
            close_num(beta * tau, z_e) && close_num(tie$h_m, z_e))
      check(sprintf("gap formulas coincide at tie N=%d beta=%.2f", N, beta),
            close_num(g_pass, g_delay) && close_num(tie$g, g_pass))
      check(sprintf("public U beats M at pass-delay tie N=%d beta=%.2f", N, beta),
            tie$g < 0)
    }

    g_zero_o <- c / (m * beta)
    if (g_zero_o > 1 / m && g_zero_o < min(tau, 1)) {
      zero <- public_values(N, beta, g_zero_o)
      check(sprintf("public gap zero crossing N=%d beta=%.2f", N, beta),
            close_num(zero$g, 0))
    }
  }
}

# Linked rent and institutional-decomposition identities on deterministic grids.
for (nu in c(0, 0.05, 0.3, 0.7, 0.95, 1)) {
  for (N in c(4, 5, 8, 13)) {
    beta <- c(0.25, 0.55, 0.82, 0.94)[match(N, c(4, 5, 8, 13))]
    o0 <- min(0.15, 0.8 / (N - 1))
    o1 <- min(0.92, o0 + 0.47)
    p0 <- public_values(N, beta, o0)
    p1 <- public_values(N, beta, o1)
    h_m <- c(p0$h_m, p1$h_m)
    h_u <- c(p0$h_u, p1$h_u)
    g <- h_m - h_u
    v_m <- c(0.37 + 0.11 * nu, 0.61 - 0.07 * nu)
    v_u <- c(0.44 + 0.03 * nu, 0.58 + 0.06 * nu)
    ri_m <- v_m - h_m
    ri_u <- v_u - h_u
    delta <- v_u - v_m
    delta_ri <- ri_u - ri_m
    check(sprintf("DeltaRI=delta+G N=%d nu=%.2f", N, nu),
          close_num(delta_ri, delta + g))
    check(sprintf("private gap decomposition N=%d nu=%.2f", N, nu),
          close_num(delta, -g + delta_ri))
    check(sprintf("linked ex-ante rent identity N=%d nu=%.2f", N, nu),
          close_num(sum(c(1 - nu, nu) * delta_ri),
                    sum(c(1 - nu, nu) * delta) + sum(c(1 - nu, nu) * g)))
    check(sprintf("preference threshold equivalence N=%d nu=%.2f", N, nu),
          identical(delta > 0, delta_ri > g))
  }
}

# Closed unanimity agenda-rent and interaction cells.
u_pairs <- rbind(
  c(0.05, 0.15),
  c(0.15, 0.55),
  c(0.35, 0.90),
  c(0.70, 0.95)
)
for (beta in c(0.2, 0.5, 0.8, 0.95)) {
  for (i in seq_len(nrow(u_pairs))) {
    o0 <- u_pairs[i, 1]
    o1 <- u_pairs[i, 2]
    z_l <- 1 - beta + beta^2 * o0
    z_h <- 1 - beta + beta^2 * o1
    d_h <- beta^2 * o1
    d2 <- beta^2 * (o1 - o0)
    d <- beta * (o1 - o0)
    u_min <- max(z_l, d_h)

    endpoint0 <- c(0, max(z_l, d_h) - z_h)
    check(sprintf("U nu=0 agenda-rent signs beta=%.2f pair=%d", beta, i),
          close_num(endpoint0[[1]], 0) && endpoint0[[2]] < 0)
    low <- c(0, -d2)
    check(sprintf("U low agenda-rent formula beta=%.2f pair=%d", beta, i),
          close_num(low, c(0, z_l - z_h)) && low[[2]] < 0)
    hb <- c(d2, 0)
    check(sprintf("U high-offpath agenda-rent formula beta=%.2f pair=%d", beta, i),
          close_num(hb, c(z_h - z_l, 0)) && hb[[1]] > 0)

    for (u in seq(u_min, z_h, length.out = 11L)) {
      rent <- c(u - z_l, u - z_h)
      interaction <- c(u - z_l - beta * d, u - z_h)
      check(sprintf("U H0 rent signs beta=%.2f pair=%d u=%.6f", beta, i, u),
            rent[[1]] >= -1e-10 && rent[[2]] <= 1e-10 &&
              (rent[[1]] > 1e-10 || rent[[2]] < -1e-10))
      check(sprintf("U H0 interaction signs beta=%.2f pair=%d u=%.6f", beta, i, u),
            close_num(interaction[[1]], interaction[[2]]) &&
              interaction[[1]] <= 1e-10 &&
              if (u < z_h - 1e-10) interaction[[1]] < -1e-10 else close_num(interaction, c(0, 0)))
    }

    check(sprintf("N7 U rent transport beta*d=D_2 beta=%.2f pair=%d", beta, i),
          close_num(beta * d, d2))
    closed_interaction <- c(d2 - beta * d, 0)
    expected_interaction <- c(0, 0)
    check(sprintf("U HB interaction identity beta=%.2f pair=%d", beta, i),
          close_num(closed_interaction, expected_interaction))

    for (nu in c(0.01, 0.2, 0.5, 0.8, 0.99)) {
      z_e_nu <- (1 - nu) * z_l + nu * z_h
      ex_ante_bounds <- c(u_min - z_e_nu, z_h - z_e_nu)
      check(sprintf("U H0 ex-ante bounds ordered beta=%.2f pair=%d nu=%.2f", beta, i, nu),
            ex_ante_bounds[[1]] <= ex_ante_bounds[[2]] + 1e-10 &&
              close_num(ex_ante_bounds[[2]], (1 - nu) * d2))
      check(sprintf("U HB ex-ante rent beta=%.2f pair=%d nu=%.2f", beta, i, nu),
            close_num((1 - nu) * d2, sum(c(1 - nu, nu) * hb)))
    }
  }
}

# T5 corollary is a direct consequence of the AC margin and the rent identity.
for (N in 4:15) {
  m <- N - 1
  k <- floor(N / 2)
  c <- m - k
  for (beta in c(0.2, 0.5, 0.8, 0.95)) {
    max_o1 <- min(0.95, 0.9 * c / (m * beta))
    if (max_o1 <= 0.02) next
    o0 <- max_o1 / 2
    o1 <- max_o1
    g_t5 <- beta * (c / m - beta * o1)
    if (g_t5 <= 0) next
    g <- c(public_values(N, beta, o0)$g, public_values(N, beta, o1)$g)
    delta <- c(-g_t5 - 0.03, -g_t5 - 0.01)
    delta_ri <- delta + g
    check(sprintf("T5 rent-difference corollary N=%d beta=%.2f", N, beta),
          all(delta_ri <= g - g_t5 + 1e-10))
  }
}

# Named exact-layer multiplicity versus anonymous economic invariance.
for (N in 4:15) {
  m <- N - 1
  k <- floor(N / 2)
  beta <- 0.8
  o <- min(0.9 / m, 0.2)
  r <- beta * (1 - beta * o) / m
  coalition_1 <- c(rep(r, k), rep(0, m - k))
  coalition_2 <- rev(coalition_1)
  check(sprintf("named majority coalitions can differ N=%d", N),
        k == m || !identical(coalition_1, coalition_2))
  check(sprintf("anonymous majority allocation is invariant N=%d", N),
        close_num(sort(coalition_1), sort(coalition_2)) &&
          close_num(sum(coalition_1), sum(coalition_2)))
}

cat("\n")
cat(sprintf("SUMMARY | %d PASS / %d FAIL\n", pass_count, fail_count))
cat("LIMIT | Mechanical evidence only; independent formal review remains required.\n")

if (fail_count > 0L) quit(status = 1L)
