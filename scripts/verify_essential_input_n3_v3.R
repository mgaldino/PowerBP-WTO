#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

n3v3_assert <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

n3v3_clone <- function(x) unserialize(serialize(x, NULL))
n3v3_as_character <- function(x) as.character(unlist(x, use.names = FALSE))

n3v3_sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  n3v3_assert(length(output) == 1L, paste("Could not hash", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  n3v3_assert(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

n3v3_read_utf8 <- function(path, label) {
  bytes <- readBin(path, what = "raw", n = file.info(path)$size)
  text <- rawToChar(bytes)
  n3v3_assert(validUTF8(text), paste(label, "must be valid UTF-8."))
  text
}

n3v3_read_raw <- function(path) {
  readBin(path, what = "raw", n = file.info(path)$size)
}

n3v3_first_difference <- function(actual, expected, path = "$") {
  if (!identical(typeof(actual), typeof(expected))) {
    return(paste0(path, ": type ", typeof(actual), " != ", typeof(expected)))
  }
  if (is.list(actual)) {
    if (!identical(names(actual), names(expected))) {
      return(paste0(path, ": field names differ"))
    }
    if (length(actual) != length(expected)) {
      return(paste0(path, ": length ", length(actual), " != ", length(expected)))
    }
    if (length(actual) == 0L) return(NULL)
    for (index in seq_along(actual)) {
      child_name <- names(actual)[[index]]
      child_path <- if (is.null(child_name) || !nzchar(child_name)) {
        paste0(path, "[[", index, "]]")
      } else {
        paste0(path, "$", child_name)
      }
      difference <- n3v3_first_difference(actual[[index]], expected[[index]], child_path)
      if (!is.null(difference)) return(difference)
    }
    return(NULL)
  }
  if (!identical(actual, expected)) {
    actual_text <- paste(utils::head(as.character(actual), 3L), collapse = "|")
    expected_text <- paste(utils::head(as.character(expected), 3L), collapse = "|")
    return(paste0(path, ": ", actual_text, " != ", expected_text))
  }
  NULL
}

n3v3_validate_exact <- function(actual, expected, label) {
  difference <- n3v3_first_difference(actual, expected)
  n3v3_assert(is.null(difference), paste(label, "differs from canonical object at", difference))
  invisible(TRUE)
}

n3v3_validate_candidate_structural <- function(object, expected_candidate) {
  n3v3_validate_exact(object, expected_candidate, "N3 v3 candidate")
}

n3v3_validate_ledger_structural <- function(object, expected_ledger) {
  n3v3_validate_exact(object, expected_ledger, "N3 v3 ledger")
}

n3v3_validate_schema <- function(candidate, dag) {
  schema <- dag$interface_schemas$equilibrium_correspondence_v1
  record_fields <- n3v3_as_character(schema$record_fields)
  h_fields <- n3v3_as_character(schema$hegemon_payoff_by_type_fields)
  outcome_fields <- n3v3_as_character(schema$outcome_distribution_fields)
  n3v3_assert(
    identical(names(candidate), c("schema_ref", "function_of", "correspondence_cells")),
    "N3 v3 top-level fields do not match equilibrium_correspondence_v1."
  )
  for (cell in candidate$correspondence_cells) {
    n3v3_assert(
      identical(
        names(cell),
        c("cell_id", "domain_conditions", "existence_status", "equilibrium_records", "nonexistence_certificate")
      ),
      paste("Wrong coverage-cell schema in", cell$cell_id)
    )
    for (record in cell$equilibrium_records) {
      n3v3_assert(
        identical(names(record), record_fields),
        paste("Wrong equilibrium record fields in", record$equilibrium_id)
      )
      n3v3_assert(
        identical(names(record$hegemon_payoff_by_type), h_fields) &&
          identical(names(record$outcome_distribution), outcome_fields),
        paste("Wrong typed payoff/outcome fields in", record$equilibrium_id)
      )
    }
  }
  invisible(TRUE)
}

n3v3_validate_derivation_semantics <- function(text) {
  required <- c(
    "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5",
    "Claim N3V3-C01",
    "Claim N3V3-C17",
    "E-R = 1-beta*q/m > 0",
    "o_0=1/m<o_1",
    "o_0<o_1=1/m",
    "h_E=h_P",
    "todas as misturas",
    "invariante à crença de ballot",
    "não afirma que duas propostas públicas distintas preservam",
    "todo nu in [0,1]",
    "quando nu>0",
    "eta_i(s,v) em [0,1]",
    "oracle não importa o objeto esperado",
    "C_l=999",
    "resultado v2 foi apagado"
  )
  n3v3_assert(
    all(vapply(
      required,
      function(pattern) grepl(pattern, text, fixed = TRUE, useBytes = TRUE),
      logical(1)
    )),
    "Derivation omits a required proof, belief, oracle, or provenance statement."
  )
  for (claim_id in sprintf("N3V3-C%02d", 1:17)) {
    anchor <- paste0("id=\"claim-", tolower(claim_id), "\"")
    n3v3_assert(
      grepl(anchor, text, fixed = TRUE, useBytes = TRUE),
      paste("Derivation omits anchor", claim_id)
    )
  }
  forbidden <- c(
    "elevar r_i preserva literalmente a crença",
    "aumentar r_i preservaria crenças",
    "beta=1 pertence ao baseline",
    "falha deliberada é selecionada",
    "H recebe o_theta sem y quando a proposta passa sem H",
    "simetria entre proponentes é imposta",
    "posterior zero na falha positiva é admissível"
  )
  n3v3_assert(
    !any(vapply(
      forbidden,
      function(pattern) grepl(pattern, text, fixed = TRUE, useBytes = TRUE),
      logical(1)
    )),
    "Derivation contains a forbidden semantic contradiction."
  )
  invisible(TRUE)
}

n3v3_load_canonical <- function(repository_root, n1_hash) {
  build_path <- file.path(repository_root, "scripts", "build_essential_input_n3_v3.R")
  builder_environment <- new.env(parent = baseenv())
  sys.source(build_path, envir = builder_environment)
  objects <- builder_environment$make_n3_v3_objects(n1_hash)

  temporary_root <- tempfile("n3v3-canonical-")
  dir.create(temporary_root, recursive = TRUE)
  on.exit(unlink(temporary_root, recursive = TRUE, force = TRUE), add = TRUE)
  paths <- lapply(1:2, function(index) {
    interface_path <- file.path(temporary_root, paste0("candidate-", index, ".json"))
    ledger_path <- file.path(temporary_root, paste0("ledger-", index, ".json"))
    builder_environment$write_canonical_json(objects$interface, interface_path)
    builder_environment$write_canonical_json(objects$ledger, ledger_path)
    list(interface = interface_path, ledger = ledger_path)
  })
  n3v3_assert(
    identical(n3v3_read_raw(paths[[1L]]$interface), n3v3_read_raw(paths[[2L]]$interface)) &&
      identical(n3v3_read_raw(paths[[1L]]$ledger), n3v3_read_raw(paths[[2L]]$ledger)),
    "Two independent canonical builds are not byte-stable."
  )
  list(
    candidate = jsonlite::fromJSON(paths[[1L]]$interface, simplifyVector = FALSE),
    ledger = jsonlite::fromJSON(paths[[1L]]$ledger, simplifyVector = FALSE),
    candidate_bytes = n3v3_read_raw(paths[[1L]]$interface),
    ledger_bytes = n3v3_read_raw(paths[[1L]]$ledger)
  )
}

n3v3_direct_execution <- function() {
  script_arguments <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  length(script_arguments) == 1L &&
    identical(basename(sub("^--file=", "", script_arguments)), "verify_essential_input_n3_v3.R")
}

n3v3_main <- function() {
  script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  n3v3_assert(length(script_argument) == 1L, "Could not resolve verifier path.")
  script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
  repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

  paths <- list(
    candidate = file.path(
      repository_root,
      "model_redesign",
      "essential_input_interfaces",
      "n3_r1_majority_candidate_v3.json"
    ),
    ledger = file.path(repository_root, "model_redesign", "essential_input_n3_claim_ledger_v3.json"),
    derivation = file.path(repository_root, "model_redesign", "essential_input_n3_r1_majority_derivation_v3.md"),
    build = file.path(repository_root, "scripts", "build_essential_input_n3_v3.R"),
    oracle = file.path(repository_root, "scripts", "oracle_essential_input_n3_v3.R"),
    negative = file.path(repository_root, "scripts", "test_essential_input_n3_v3_negative.R"),
    dag = file.path(repository_root, "model_redesign", "essential_input_game_dag.json"),
    n1 = file.path(
      repository_root,
      "model_redesign",
      "essential_input_interfaces",
      "n1_r2_majority_candidate_v1.json"
    )
  )
  for (path in unlist(paths, use.names = FALSE)) {
    n3v3_assert(file.exists(path), paste("Missing required file:", path))
  }

  n1_hash_bare <- "1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
  n1_hash <- paste0("sha256:", n1_hash_bare)
  expected_hashes <- c(
    candidate = "8b47f6ed3ecf8e63f868bafd51f87fc76fff05545ebf9977ef5c1b27276005a9",
    ledger = "0c37f76c522fd88e41882a8cab20404cc413bac67153282c1cf7e7820cec0a0f",
    derivation = "c1d4f2e46b2528097fecf91204d3587318f90a604090fef1540c1effa64d1927",
    build = "1f18708bb96d5da5f427a4c21aa3c16633eb33d01ec64c475bb86a5d7022e71c",
    oracle = "93d2d23d3b95e1817db0e59cbc70c934e21b6e7bc93901e9ee2bb1cff168ac71",
    negative = "cea9ceae0599429bf44284dbcd2fbfe6a1ff945b5d2a69b0433e7049ba6611f0"
  )

  n3v3_assert(identical(n3v3_sha256_file(paths$n1), n1_hash_bare), "Frozen N1 bytes changed.")
  for (name in names(expected_hashes)) {
    n3v3_assert(
      identical(n3v3_sha256_file(paths[[name]]), expected_hashes[[name]]),
      paste("Hash pin failed for N3 v3", name)
    )
  }

  texts <- lapply(names(paths)[names(paths) %in% c("derivation", "build", "oracle", "negative")], function(name) {
    n3v3_read_utf8(paths[[name]], paste("N3 v3", name))
  })
  names(texts) <- c("derivation", "build", "oracle", "negative")
  n3v3_read_utf8(paths$candidate, "N3 v3 candidate")
  n3v3_read_utf8(paths$ledger, "N3 v3 ledger")

  candidate <- jsonlite::fromJSON(paths$candidate, simplifyVector = FALSE)
  ledger <- jsonlite::fromJSON(paths$ledger, simplifyVector = FALSE)
  dag <- jsonlite::fromJSON(paths$dag, simplifyVector = FALSE)
  n1 <- jsonlite::fromJSON(paths$n1, simplifyVector = FALSE)

  node_ids <- vapply(dag$nodes, function(node) node$id, character(1))
  nodes <- dag$nodes
  names(nodes) <- node_ids
  n3v3_assert(
    identical(nodes$N1$status, "pass") &&
      identical(nodes$N1$frozen, TRUE) &&
      identical(nodes$N1$artifact_hash, n1_hash) &&
      identical(nodes$N1$interface, n1),
    "N3 v3 must consume exact pass/frozen N1."
  )
  n3v3_assert(
    identical(nodes$N3$status, "pending") &&
      identical(n3v3_as_character(nodes$N3$depends_on), "N1") &&
      is.null(nodes$N3$interface$correspondence_cells) &&
      is.null(nodes$N3$frozen) &&
      is.null(nodes$N3$artifact_hash) &&
      is.null(nodes$N3$reviews),
    "N3 lifecycle must remain pending/unfrozen."
  )

  canonical <- n3v3_load_canonical(repository_root, n1_hash)
  n3v3_validate_candidate_structural(candidate, canonical$candidate)
  n3v3_validate_ledger_structural(ledger, canonical$ledger)
  n3v3_validate_schema(candidate, dag)
  n3v3_assert(
    identical(n3v3_read_raw(paths$candidate), canonical$candidate_bytes),
    "Candidate is structurally equal but not byte-identical to canonical build."
  )
  n3v3_assert(
    identical(n3v3_read_raw(paths$ledger), canonical$ledger_bytes),
    "Ledger is structurally equal but not byte-identical to canonical build."
  )
  n3v3_validate_derivation_semantics(texts$derivation)

  oracle_environment <- new.env(parent = baseenv())
  sys.source(paths$oracle, envir = oracle_environment)
  oracle_environment$oracle_validate_candidate(candidate, n1, n1_hash, paths$n1)
  oracle_environment$oracle_run_stress(50000L)

  negative_output <- system2(
    "Rscript",
    c("--vanilla", shQuote(paths$negative)),
    stdout = TRUE,
    stderr = TRUE
  )
  negative_status <- attr(negative_output, "status")
  if (is.null(negative_status)) negative_status <- 0L
  n3v3_assert(
    identical(as.integer(negative_status), 0L) &&
      any(grepl("NEGATIVE_TESTS_REJECTED", negative_output, fixed = TRUE)),
    paste("Directed negative suite failed:", paste(negative_output, collapse = "\n"))
  )

  cat("PASS: N3 v3 exact canonical candidate and ledger match every field, cell, record, and claim.\n")
  cat("PASS: two canonical builds are byte-stable UTF-8 and all v3 artifact pins match.\n")
  cat("PASS: independent algebraic oracle reconstructed frozen N1 transport, simultaneous ballot vectors, offers, frontiers, regions, identity maps, H payoffs, outcomes, and endpoints.\n")
  cat("PASS: complete off-path proposal-vote beliefs cover every nu, while positive-probability low-type-only failure has Bayes posterior one.\n")
  cat("PASS: directed in-memory semantic corruptions were rejected with external hash pins bypassed.\n")
  cat("N1-SHA-256:", n1_hash_bare, "\n")
  for (name in names(expected_hashes)) {
    cat(paste0(toupper(name), "-SHA-256:"), expected_hashes[[name]], "\n")
  }
  cat("STATUS: N3 v3 remains pending independent formal-design and game-theory review; no lifecycle mutation performed.\n")
}

if (n3v3_direct_execution()) n3v3_main()
