#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

n3v4_assert <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

n3v4_as_character <- function(x) as.character(unlist(x, use.names = FALSE))

n3v4_sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  n3v4_assert(length(output) == 1L, paste("Could not hash", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  n3v4_assert(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

n3v4_read_raw <- function(path) {
  readBin(path, what = "raw", n = file.info(path)$size)
}

n3v4_read_utf8 <- function(path, label) {
  text <- rawToChar(n3v4_read_raw(path))
  n3v4_assert(validUTF8(text), paste(label, "must be valid UTF-8."))
  text
}

n3v4_child_path <- function(parent, child_name, index) {
  if (!is.null(child_name) && nzchar(child_name)) {
    if (identical(parent, "$")) paste0("$", child_name) else paste0(parent, "$", child_name)
  } else {
    paste0(parent, "[[", index, "]]" )
  }
}

n3v4_first_difference <- function(actual, expected, path = "$") {
  if (is.null(actual) || is.null(expected)) {
    if (is.null(actual) && is.null(expected)) return(NULL)
    return(paste0(path, ": NULL mismatch"))
  }
  if (!identical(typeof(actual), typeof(expected))) {
    return(paste0(path, ": type ", typeof(actual), " != ", typeof(expected)))
  }
  if (is.list(actual)) {
    if (!identical(names(actual), names(expected))) return(paste0(path, ": field names differ"))
    if (length(actual) != length(expected)) {
      return(paste0(path, ": length ", length(actual), " != ", length(expected)))
    }
    if (length(actual) == 0L) return(NULL)
    object_names <- names(actual)
    for (index in seq_along(actual)) {
      child_name <- if (is.null(object_names)) NULL else object_names[[index]]
      difference <- n3v4_first_difference(
        actual[[index]],
        expected[[index]],
        n3v4_child_path(path, child_name, index)
      )
      if (!is.null(difference)) return(difference)
    }
    return(NULL)
  }
  if (!identical(actual, expected)) {
    return(paste0(
      path,
      ": ",
      paste(utils::head(as.character(actual), 2L), collapse = "|"),
      " != ",
      paste(utils::head(as.character(expected), 2L), collapse = "|")
    ))
  }
  NULL
}

n3v4_validate_exact <- function(actual, expected, label) {
  difference <- n3v4_first_difference(actual, expected)
  n3v4_assert(is.null(difference), paste(label, "differs at", difference))
  invisible(TRUE)
}

n3v4_validate_candidate_structural <- function(candidate, expected_candidate) {
  n3v4_validate_exact(candidate, expected_candidate, "N3 v4 candidate")
}

n3v4_validate_ledger_structural <- function(ledger, expected_ledger) {
  n3v4_validate_exact(ledger, expected_ledger, "N3 v4 ledger")
}

n3v4_validate_schema <- function(candidate, dag) {
  schema <- dag$interface_schemas$equilibrium_correspondence_v1
  record_fields <- n3v4_as_character(schema$record_fields)
  h_fields <- n3v4_as_character(schema$hegemon_payoff_by_type_fields)
  outcome_fields <- n3v4_as_character(schema$outcome_distribution_fields)
  n3v4_assert(
    identical(names(candidate), c("schema_ref", "function_of", "correspondence_cells")),
    "N3 v4 top-level fields do not match equilibrium_correspondence_v1."
  )
  for (cell in candidate$correspondence_cells) {
    n3v4_assert(
      identical(
        names(cell),
        c("cell_id", "domain_conditions", "existence_status", "equilibrium_records", "nonexistence_certificate")
      ),
      paste("Wrong coverage-cell schema in", cell$cell_id)
    )
    for (record in cell$equilibrium_records) {
      n3v4_assert(
        identical(names(record), record_fields),
        paste("Wrong equilibrium record fields in", record$equilibrium_id)
      )
      n3v4_assert(
        identical(names(record$hegemon_payoff_by_type), h_fields) &&
          identical(names(record$outcome_distribution), outcome_fields),
        paste("Wrong typed payoff/outcome fields in", record$equilibrium_id)
      )
    }
  }
  invisible(TRUE)
}

n3v4_run_builder_twice <- function(build_path) {
  temporary_root <- tempfile("n3v4-independent-builds-")
  dir.create(temporary_root, recursive = TRUE)
  on.exit(unlink(temporary_root, recursive = TRUE, force = TRUE), add = TRUE)
  builds <- vector("list", 2L)
  for (index in 1:2) {
    build_root <- file.path(temporary_root, paste0("process-", index))
    dir.create(build_root, recursive = TRUE)
    candidate_path <- file.path(build_root, "candidate.json")
    ledger_path <- file.path(build_root, "ledger.json")
    output <- system2(
      "Rscript",
      c(
        "--vanilla",
        shQuote(build_path),
        shQuote(paste0("--interface-output=", candidate_path)),
        shQuote(paste0("--ledger-output=", ledger_path)),
        "--quiet"
      ),
      stdout = TRUE,
      stderr = TRUE
    )
    status <- attr(output, "status")
    if (is.null(status)) status <- 0L
    n3v4_assert(
      identical(as.integer(status), 0L),
      paste("Independent builder process", index, "failed:", paste(output, collapse = "\n"))
    )
    n3v4_assert(
      file.exists(candidate_path) && file.exists(ledger_path),
      paste("Independent builder process", index, "did not create both outputs.")
    )
    builds[[index]] <- list(
      process_index = index,
      candidate = jsonlite::fromJSON(candidate_path, simplifyVector = FALSE),
      ledger = jsonlite::fromJSON(ledger_path, simplifyVector = FALSE),
      candidate_bytes = n3v4_read_raw(candidate_path),
      ledger_bytes = n3v4_read_raw(ledger_path)
    )
  }
  n3v4_assert(
    identical(builds[[1L]]$candidate_bytes, builds[[2L]]$candidate_bytes) &&
      identical(builds[[1L]]$ledger_bytes, builds[[2L]]$ledger_bytes),
    "Two real independent builder processes are not byte-stable."
  )
  builds
}

n3v4_direct_execution <- function() {
  script_arguments <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  length(script_arguments) == 1L &&
    identical(basename(sub("^--file=", "", script_arguments)), "verify_essential_input_n3_v4.R")
}

n3v4_main <- function() {
  script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  n3v4_assert(length(script_argument) == 1L, "Could not resolve verifier path.")
  script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
  repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

  paths <- list(
    candidate = file.path(
      repository_root,
      "model_redesign",
      "essential_input_interfaces",
      "n3_r1_majority_candidate_v4.json"
    ),
    ledger = file.path(repository_root, "model_redesign", "essential_input_n3_claim_ledger_v4.json"),
    derivation = file.path(repository_root, "model_redesign", "essential_input_n3_r1_majority_derivation_v4.md"),
    build = file.path(repository_root, "scripts", "build_essential_input_n3_v4.R"),
    oracle = file.path(repository_root, "scripts", "oracle_essential_input_n3_v4.R"),
    common_mode = file.path(repository_root, "scripts", "test_essential_input_n3_v4_common_mode.R"),
    dag = file.path(repository_root, "model_redesign", "essential_input_game_dag.json"),
    n1 = file.path(
      repository_root,
      "model_redesign",
      "essential_input_interfaces",
      "n1_r2_majority_candidate_v1.json"
    )
  )
  for (path in unlist(paths, use.names = FALSE)) {
    n3v4_assert(file.exists(path), paste("Missing required file:", path))
  }

  n1_hash_bare <- "1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
  n1_hash <- paste0("sha256:", n1_hash_bare)
  expected_hashes <- c(
    candidate = "8e8f29bee16f65d00b8f154a434b47b3e001741760b80db4b7ee88476e7e842d",
    ledger = "4b733b18cf8c2680734799ed3e5df0c43e2323900edea245b0c9b3ae49143659",
    derivation = "94b279a98305dd0ae8aff06281ca667214cb7afaa901057431a81544044a4364",
    build = "52bdf937094fe583ead825b89159e7baa92182ca84b5d35e091029179338b492",
    oracle = "66bff2db871e0bfc2c6d938e918e6aa1da75af432698a5eb61571c09a817e59b",
    common_mode = "a5b05e0e4dde2f60fb1aad519b362c0cfdf4a6ae93bb6339fe9c51692f2039cc"
  )

  n3v4_assert(identical(n3v4_sha256_file(paths$n1), n1_hash_bare), "Frozen N1 bytes changed.")
  for (name in names(expected_hashes)) {
    n3v4_assert(
      identical(n3v4_sha256_file(paths[[name]]), expected_hashes[[name]]),
      paste("Hash pin failed for N3 v4", name)
    )
  }

  text_paths <- c("derivation", "build", "oracle", "common_mode")
  texts <- lapply(text_paths, function(name) n3v4_read_utf8(paths[[name]], paste("N3 v4", name)))
  names(texts) <- text_paths
  n3v4_read_utf8(paths$candidate, "N3 v4 candidate")
  n3v4_read_utf8(paths$ledger, "N3 v4 ledger")
  n3v4_assert(
    !grepl("sys.source(", texts$oracle, fixed = TRUE) &&
      !grepl("source(", texts$oracle, fixed = TRUE) &&
      !grepl("build_essential_input_n3_v4.R", texts$oracle, fixed = TRUE) &&
      !grepl("make_n3_v4_objects", texts$oracle, fixed = TRUE),
    "Independent oracle must not import or call any builder object or function."
  )
  n3v4_assert(
    !grepl("sys.source(", texts$build, fixed = TRUE) &&
      !grepl("build_essential_input_n3_v3.R", texts$build, fixed = TRUE) &&
      !grepl("make_n3_v3_objects", texts$build, fixed = TRUE),
    "N3 v4 builder must be standalone; N3 v2/v3 remain provenance only."
  )

  candidate <- jsonlite::fromJSON(paths$candidate, simplifyVector = FALSE)
  ledger <- jsonlite::fromJSON(paths$ledger, simplifyVector = FALSE)
  dag <- jsonlite::fromJSON(paths$dag, simplifyVector = FALSE)
  n1 <- jsonlite::fromJSON(paths$n1, simplifyVector = FALSE)

  node_ids <- vapply(dag$nodes, function(node) node$id, character(1))
  nodes <- dag$nodes
  names(nodes) <- node_ids
  n3v4_assert(
    identical(nodes$N1$status, "pass") &&
      identical(nodes$N1$frozen, TRUE) &&
      identical(nodes$N1$artifact_hash, n1_hash) &&
      identical(nodes$N1$interface, n1),
    "N3 v4 must consume exact pass/frozen N1."
  )
  n3v4_assert(
    identical(nodes$N3$status, "pending") &&
      identical(n3v4_as_character(nodes$N3$depends_on), "N1") &&
      is.null(nodes$N3$interface$correspondence_cells) &&
      is.null(nodes$N3$frozen) &&
      is.null(nodes$N3$artifact_hash) &&
      is.null(nodes$N3$reviews),
    "N3 lifecycle must remain pending/unfrozen."
  )

  builds <- n3v4_run_builder_twice(paths$build)
  n3v4_validate_candidate_structural(candidate, builds[[1L]]$candidate)
  n3v4_validate_ledger_structural(ledger, builds[[1L]]$ledger)
  n3v4_validate_schema(candidate, dag)
  n3v4_assert(
    identical(n3v4_read_raw(paths$candidate), builds[[1L]]$candidate_bytes) &&
      identical(n3v4_read_raw(paths$candidate), builds[[2L]]$candidate_bytes),
    "Permanent candidate differs from one or both independent builder processes."
  )
  n3v4_assert(
    identical(n3v4_read_raw(paths$ledger), builds[[1L]]$ledger_bytes) &&
      identical(n3v4_read_raw(paths$ledger), builds[[2L]]$ledger_bytes),
    "Permanent ledger differs from one or both independent builder processes."
  )

  oracle_environment <- new.env(parent = baseenv())
  sys.source(paths$oracle, envir = oracle_environment)
  candidate_audit <- oracle_environment$oracle_validate_candidate(candidate, n1, n1_hash, paths$n1)
  oracle_environment$oracle_validate_ledger(ledger, n1_hash)
  coverage <- oracle_environment$oracle_audit_path_coverage(candidate, ledger)
  derivation_audit <- oracle_environment$oracle_validate_derivation(texts$derivation)
  oracle_environment$oracle_run_stress(50000L)

  common_mode_output <- system2(
    "Rscript",
    c("--vanilla", shQuote(paths$common_mode)),
    stdout = TRUE,
    stderr = TRUE
  )
  common_mode_status <- attr(common_mode_output, "status")
  if (is.null(common_mode_status)) common_mode_status <- 0L
  n3v4_assert(
    identical(as.integer(common_mode_status), 0L) &&
      any(grepl("COMMON_MODE_NEGATIVES_REJECTED", common_mode_output, fixed = TRUE)),
    paste("Common-mode negative suite failed:", paste(common_mode_output, collapse = "\n"))
  )

  cat("PASS: N3 v4 permanent candidate and ledger match two real independent builder processes byte for byte.\n")
  cat("PASS: independent oracle matched every typed semantic leaf and retained the 11-cell mathematics.\n")
  cat(
    "SEMANTIC_PATHS_COVERED:",
    coverage$candidate_paths,
    "candidate and",
    coverage$ledger_paths,
    "ledger atomic paths;",
    derivation_audit$claim_sections,
    "derivation claims.\n"
  )
  cat("PASS: common-mode candidate, ledger, and derivation corruptions were rejected with structural pins neutralized.\n")
  cat("N1-SHA-256:", n1_hash_bare, "\n")
  for (name in names(expected_hashes)) {
    cat(paste0(toupper(name), "-SHA-256:"), expected_hashes[[name]], "\n")
  }
  cat("STATUS: N3 v4 remains pending independent formal-design and game-theory review; no lifecycle mutation performed.\n")
  invisible(candidate_audit)
}

if (n3v4_direct_execution()) n3v4_main()
