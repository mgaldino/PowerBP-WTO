#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

n3v5_assert <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

n3v5_sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  n3v5_assert(length(output) == 1L, paste("Could not hash", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  n3v5_assert(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

n3v5_read_raw <- function(path) readBin(path, what = "raw", n = file.info(path)$size)

n3v5_read_utf8 <- function(path, label) {
  text <- rawToChar(n3v5_read_raw(path))
  n3v5_assert(validUTF8(text), paste(label, "must be valid UTF-8."))
  text
}

n3v5_first_difference <- function(actual, expected, path = "$") {
  if (is.null(actual) || is.null(expected)) {
    if (is.null(actual) && is.null(expected)) return(NULL)
    return(paste0(path, ": NULL mismatch"))
  }
  if (!identical(typeof(actual), typeof(expected))) return(paste0(path, ": type mismatch"))
  if (is.list(actual)) {
    if (!identical(names(actual), names(expected))) return(paste0(path, ": field names differ"))
    if (length(actual) != length(expected)) return(paste0(path, ": length differs"))
    if (length(actual) == 0L) return(NULL)
    actual_names <- names(actual)
    for (index in seq_along(actual)) {
      name <- if (is.null(actual_names)) NULL else actual_names[[index]]
      child <- if (is.null(name) || !nzchar(name)) {
        paste0(path, "[[", index, "]]")
      } else if (identical(path, "$")) {
        paste0("$", name)
      } else {
        paste0(path, "$", name)
      }
      difference <- n3v5_first_difference(actual[[index]], expected[[index]], child)
      if (!is.null(difference)) return(difference)
    }
    return(NULL)
  }
  if (!identical(actual, expected)) return(paste0(path, ": scalar differs"))
  NULL
}

n3v5_validate_exact <- function(actual, expected, label) {
  difference <- n3v5_first_difference(actual, expected)
  n3v5_assert(is.null(difference), paste(label, "differs at", difference))
  invisible(TRUE)
}

n3v5_transform_v4_to_v5 <- function(object) {
  if (is.list(object)) {
    result <- lapply(object, n3v5_transform_v4_to_v5)
    names(result) <- names(object)
    return(result)
  }
  if (!is.character(object)) return(object)
  object <- gsub("N3V4", "N3V5", object, fixed = TRUE)
  object <- gsub("n3v4", "n3v5", object, fixed = TRUE)
  object <- gsub("candidate_v4", "candidate_v5", object, fixed = TRUE)
  object <- gsub("ledger_v4", "ledger_v5", object, fixed = TRUE)
  object <- gsub("derivation_v4", "derivation_v5", object, fixed = TRUE)
  object <- gsub("claim-ledger-v4", "claim-ledger-v5", object, fixed = TRUE)
  object
}

n3v5_transform_v4_claims_to_v5 <- function(text) {
  gsub("v4", "v5", n3v5_transform_v4_to_v5(text), fixed = TRUE)
}

n3v5_run_builder_twice <- function(build_path) {
  temporary_root <- tempfile("n3v5-real-builds-")
  dir.create(temporary_root, recursive = TRUE)
  on.exit(unlink(temporary_root, recursive = TRUE, force = TRUE), add = TRUE)
  builds <- vector("list", 2L)
  for (index in 1:2) {
    process_root <- file.path(temporary_root, paste0("process-", index))
    dir.create(process_root, recursive = TRUE)
    candidate_path <- file.path(process_root, "candidate.json")
    ledger_path <- file.path(process_root, "ledger.json")
    output <- system2(
      "Rscript",
      c(
        "--vanilla", shQuote(build_path),
        shQuote(paste0("--interface-output=", candidate_path)),
        shQuote(paste0("--ledger-output=", ledger_path)),
        "--quiet"
      ),
      stdout = TRUE,
      stderr = TRUE
    )
    status <- attr(output, "status")
    if (is.null(status)) status <- 0L
    n3v5_assert(
      identical(as.integer(status), 0L),
      paste("Independent builder process", index, "failed:", paste(output, collapse = "\n"))
    )
    builds[[index]] <- list(
      candidate = jsonlite::fromJSON(candidate_path, simplifyVector = FALSE),
      ledger = jsonlite::fromJSON(ledger_path, simplifyVector = FALSE),
      candidate_bytes = n3v5_read_raw(candidate_path),
      ledger_bytes = n3v5_read_raw(ledger_path)
    )
  }
  n3v5_assert(
    identical(builds[[1L]]$candidate_bytes, builds[[2L]]$candidate_bytes) &&
      identical(builds[[1L]]$ledger_bytes, builds[[2L]]$ledger_bytes),
    "Two real builder subprocesses are not byte-stable."
  )
  builds
}

n3v5_normalize_source_line <- function(line) {
  line <- trimws(line)
  line <- gsub("N3V[0-9]+", "N3VX", line, perl = TRUE)
  line <- gsub("n3v[0-9]+", "n3vx", line, perl = TRUE)
  line <- gsub("n3_v[0-9]+", "n3_vx", line, perl = TRUE)
  line <- gsub("^[A-Za-z0-9_]+[[:space:]]*<-[[:space:]]*function", "FUNCTION <- function", line, perl = TRUE)
  line
}

n3v5_longest_common_source_run <- function(builder_lines, oracle_lines) {
  builder <- vapply(builder_lines, n3v5_normalize_source_line, character(1))
  oracle <- vapply(oracle_lines, n3v5_normalize_source_line, character(1))
  previous <- integer(length(oracle) + 1L)
  maximum <- 0L
  for (builder_index in seq_along(builder)) {
    current <- integer(length(oracle) + 1L)
    for (oracle_index in seq_along(oracle)) {
      if (identical(builder[[builder_index]], oracle[[oracle_index]])) {
        current[[oracle_index + 1L]] <- previous[[oracle_index]] + 1L
        if (current[[oracle_index + 1L]] > maximum) maximum <- current[[oracle_index + 1L]]
      }
    }
    previous <- current
  }
  maximum
}

n3v5_source_independence <- function(builder_text, oracle_text, maximum_allowed_run = 19L) {
  builder_lines <- strsplit(builder_text, "\n", fixed = TRUE)[[1L]]
  oracle_lines <- strsplit(oracle_text, "\n", fixed = TRUE)[[1L]]
  forbidden <- c(
    "make_n3_v5_objects", "write_canonical_json", "jsonlite::toJSON",
    "oracle_reconstruct", "common_domain <- c(", "claims <- list(",
    "build_essential_input_n3_v5.R", "sys.source("
  )
  present <- forbidden[vapply(forbidden, function(token) grepl(token, oracle_text, fixed = TRUE), logical(1))]
  longest <- n3v5_longest_common_source_run(builder_lines, oracle_lines)
  list(pass = length(present) == 0L && longest <= maximum_allowed_run, longest = longest, forbidden = present)
}

n3v5_validate_schema <- function(candidate, dag) {
  schema <- dag$interface_schemas$equilibrium_correspondence_v1
  record_fields <- as.character(unlist(schema$record_fields, use.names = FALSE))
  h_fields <- as.character(unlist(schema$hegemon_payoff_by_type_fields, use.names = FALSE))
  outcome_fields <- as.character(unlist(schema$outcome_distribution_fields, use.names = FALSE))
  n3v5_assert(
    identical(names(candidate), c("schema_ref", "function_of", "correspondence_cells")),
    "N3 v5 top-level schema differs from equilibrium_correspondence_v1."
  )
  for (cell in candidate$correspondence_cells) {
    n3v5_assert(
      identical(names(cell), c("cell_id", "domain_conditions", "existence_status", "equilibrium_records", "nonexistence_certificate")),
      paste("Coverage-cell schema changed in", cell$cell_id)
    )
    for (record in cell$equilibrium_records) {
      n3v5_assert(identical(names(record), record_fields), paste("Record schema changed in", record$equilibrium_id))
      n3v5_assert(
        identical(names(record$hegemon_payoff_by_type), h_fields) &&
          identical(names(record$outcome_distribution), outcome_fields),
        paste("Typed payoff/outcome schema changed in", record$equilibrium_id)
      )
    }
  }
  invisible(TRUE)
}

n3v5_direct_execution <- function() {
  script_arguments <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  length(script_arguments) == 1L &&
    identical(basename(sub("^--file=", "", script_arguments)), "verify_essential_input_n3_v5.R")
}

n3v5_main <- function() {
  script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  n3v5_assert(length(script_argument) == 1L, "Could not resolve N3 v5 verifier path.")
  script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
  repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
  paths <- list(
    candidate = file.path(repository_root, "model_redesign", "essential_input_interfaces", "n3_r1_majority_candidate_v5.json"),
    ledger = file.path(repository_root, "model_redesign", "essential_input_n3_claim_ledger_v5.json"),
    derivation = file.path(repository_root, "model_redesign", "essential_input_n3_r1_majority_derivation_v5.md"),
    build = file.path(repository_root, "scripts", "build_essential_input_n3_v5.R"),
    oracle = file.path(repository_root, "scripts", "oracle_essential_input_n3_v5.R"),
    common_mode = file.path(repository_root, "scripts", "test_essential_input_n3_v5_common_mode.R"),
    dag = file.path(repository_root, "model_redesign", "essential_input_game_dag.json"),
    n1 = file.path(repository_root, "model_redesign", "essential_input_interfaces", "n1_r2_majority_candidate_v1.json"),
    v4_candidate = file.path(repository_root, "model_redesign", "essential_input_interfaces", "n3_r1_majority_candidate_v4.json"),
    v4_ledger = file.path(repository_root, "model_redesign", "essential_input_n3_claim_ledger_v4.json"),
    v4_derivation = file.path(repository_root, "model_redesign", "essential_input_n3_r1_majority_derivation_v4.md")
  )
  for (path in unlist(paths, use.names = FALSE)) n3v5_assert(file.exists(path), paste("Missing verifier input:", path))

  expected_hashes <- c(
    candidate = "b30c63ac1afd29d7b1af64e9a8734270feea94bced2c8ec7e3c3bf2a94f405cb",
    ledger = "99a20b0137dbebb6d27d64e870ac11de5cdec8e1997b41dcd92cc647c521dcc1",
    derivation = "a0ac3b59c9f0219245e038c805f54b9ee15b2eb249fe2c2a97c2e295267ef6b6",
    build = "7e19d8d4cb8080d2e7042d23d4dabe1df9e3fab45bcf8cf8ff71e971001567e4",
    oracle = "b601e40df2ea566f850d1d2d311635e1c5110de71cff56060d24b057044a1cc3",
    common_mode = "b057fe1c3dada5ec6c5a32af810f674e9a13c3d6f22c794d0573259b1dfb9e6d"
  )
  n1_hash_bare <- "1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
  n1_hash <- paste0("sha256:", n1_hash_bare)
  n3v5_assert(identical(n3v5_sha256_file(paths$n1), n1_hash_bare), "Frozen N1 bytes changed.")
  n3v5_assert(
    identical(n3v5_sha256_file(paths$v4_candidate), "8e8f29bee16f65d00b8f154a434b47b3e001741760b80db4b7ee88476e7e842d") &&
      identical(n3v5_sha256_file(paths$v4_ledger), "4b733b18cf8c2680734799ed3e5df0c43e2323900edea245b0c9b3ae49143659") &&
      identical(n3v5_sha256_file(paths$v4_derivation), "94b279a98305dd0ae8aff06281ca667214cb7afaa901057431a81544044a4364"),
    "N3 v4 provenance bytes changed."
  )
  for (name in names(expected_hashes)) {
    n3v5_assert(
      identical(n3v5_sha256_file(paths[[name]]), expected_hashes[[name]]),
      paste("N3 v5 hash pin failed for", name)
    )
  }

  text_names <- c("derivation", "build", "oracle", "common_mode")
  texts <- lapply(text_names, function(name) n3v5_read_utf8(paths[[name]], paste("N3 v5", name)))
  names(texts) <- text_names
  v4_derivation_text <- n3v5_read_utf8(paths$v4_derivation, "N3 v4 derivation provenance")
  n3v5_read_utf8(paths$candidate, "N3 v5 candidate")
  n3v5_read_utf8(paths$ledger, "N3 v5 ledger")

  independence <- n3v5_source_independence(texts$build, texts$oracle)
  n3v5_assert(
    independence$pass,
    paste(
      "Builder/oracle source independence failed; longest normalized run:",
      independence$longest,
      "forbidden:",
      paste(independence$forbidden, collapse = ", ")
    )
  )
  builder_lines <- strsplit(texts$build, "\n", fixed = TRUE)[[1L]]
  oracle_lines <- strsplit(texts$oracle, "\n", fixed = TRUE)[[1L]]
  copied_oracle <- paste(c(oracle_lines, builder_lines[84:114]), collapse = "\n")
  copied_guard <- n3v5_source_independence(texts$build, copied_oracle)
  n3v5_assert(
    !copied_guard$pass && copied_guard$longest >= 20L && length(copied_guard$forbidden) == 0L,
    "Source guard failed to reject a long copied builder block on source similarity alone."
  )
  full_constructor_oracle <- paste(c(oracle_lines, builder_lines), collapse = "\n")
  full_constructor_guard <- n3v5_source_independence(texts$build, full_constructor_oracle)
  n3v5_assert(
    !full_constructor_guard$pass && full_constructor_guard$longest >= length(builder_lines) - 1L &&
      length(full_constructor_guard$forbidden) > 0L,
    "Source guard failed to reject an injected complete builder/constructor."
  )

  candidate <- jsonlite::fromJSON(paths$candidate, simplifyVector = FALSE)
  ledger <- jsonlite::fromJSON(paths$ledger, simplifyVector = FALSE)
  v4_candidate <- jsonlite::fromJSON(paths$v4_candidate, simplifyVector = FALSE)
  v4_ledger <- jsonlite::fromJSON(paths$v4_ledger, simplifyVector = FALSE)
  n1 <- jsonlite::fromJSON(paths$n1, simplifyVector = FALSE)
  dag <- jsonlite::fromJSON(paths$dag, simplifyVector = FALSE)

  node_ids <- vapply(dag$nodes, function(node) node$id, character(1))
  nodes <- dag$nodes
  names(nodes) <- node_ids
  n3v5_assert(
    identical(nodes$N1$status, "pass") && identical(nodes$N1$frozen, TRUE) &&
      identical(nodes$N1$artifact_hash, n1_hash) && identical(nodes$N1$interface, n1),
    "N3 v5 must consume exact pass/frozen N1."
  )
  n3v5_assert(
    identical(nodes$N3$status, "pending") &&
      identical(as.character(unlist(nodes$N3$depends_on, use.names = FALSE)), "N1") &&
      is.null(nodes$N3$interface$correspondence_cells) && is.null(nodes$N3$frozen) &&
      is.null(nodes$N3$artifact_hash) && is.null(nodes$N3$reviews),
    "N3 lifecycle must remain pending/unfrozen."
  )

  builds <- n3v5_run_builder_twice(paths$build)
  n3v5_validate_exact(candidate, builds[[1L]]$candidate, "N3 v5 candidate/build")
  n3v5_validate_exact(ledger, builds[[1L]]$ledger, "N3 v5 ledger/build")
  n3v5_assert(
    identical(n3v5_read_raw(paths$candidate), builds[[1L]]$candidate_bytes) &&
      identical(n3v5_read_raw(paths$candidate), builds[[2L]]$candidate_bytes) &&
      identical(n3v5_read_raw(paths$ledger), builds[[1L]]$ledger_bytes) &&
      identical(n3v5_read_raw(paths$ledger), builds[[2L]]$ledger_bytes),
    "Permanent N3 v5 bytes differ from one or both real builder subprocesses."
  )
  n3v5_validate_exact(candidate, n3v5_transform_v4_to_v5(v4_candidate), "Normalized v4->v5 candidate identity")
  n3v5_validate_exact(ledger, n3v5_transform_v4_to_v5(v4_ledger), "Normalized v4->v5 ledger identity")
  n3v5_validate_schema(candidate, dag)

  oracle_environment <- new.env(parent = baseenv())
  sys.source(paths$oracle, envir = oracle_environment)
  candidate_audit <- oracle_environment$ov5_validate_candidate(candidate, n1, n1_hash, paths$n1)
  ledger_audit <- oracle_environment$ov5_validate_ledger(ledger, candidate, n1_hash)
  derivation_audit <- oracle_environment$ov5_validate_derivation(texts$derivation)
  n3v5_validate_exact(
    oracle_environment$ov5_claim_sections(texts$derivation),
    oracle_environment$ov5_claim_sections(n3v5_transform_v4_claims_to_v5(v4_derivation_text)),
    "Normalized v4->v5 mathematical claim identity"
  )
  oracle_environment$ov5_run_numeric_audit(50000L)

  common_output <- system2("Rscript", c("--vanilla", shQuote(paths$common_mode)), stdout = TRUE, stderr = TRUE)
  common_status <- attr(common_output, "status")
  if (is.null(common_status)) common_status <- 0L
  n3v5_assert(
    identical(as.integer(common_status), 0L) &&
      any(grepl("COMMON_MODE_EXHAUSTIVE_REJECTED", common_output, fixed = TRUE)),
    paste("N3 v5 exhaustive common-mode suite failed:", paste(common_output, collapse = "\n"))
  )

  cat("PASS: N3 v5 candidate and ledger are byte-stable across two real builder subprocesses.\n")
  cat("PASS: candidate, ledger, and all 17 mathematical claim sections are semantically identical to v4 after namespace-only normalization.\n")
  cat(
    "PASS: independent parser/evaluator covered",
    candidate_audit$paths,
    "candidate paths,",
    ledger_audit$paths,
    "ledger paths, and",
    derivation_audit$claims,
    "claims.\n"
  )
  cat(
    "SOURCE_INDEPENDENCE: longest normalized builder/oracle run =",
    independence$longest,
    "lines; clean long block and complete constructor injections rejected.\n"
  )
  cat("PASS: exhaustive three-way common-mode corruption suite rejected all candidate, ledger, claim, and directed mutations.\n")
  cat("N1-SHA-256:", n1_hash_bare, "\n")
  for (name in names(expected_hashes)) cat(paste0(toupper(name), "-SHA-256:"), expected_hashes[[name]], "\n")
  cat("STATUS: N3 v5 remains pending independent formal-design and game-theory review; no lifecycle mutation performed.\n")
}

if (n3v5_direct_execution()) n3v5_main()
