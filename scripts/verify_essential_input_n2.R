#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) {
    stop(message, call. = FALSE)
  }
}

as_character <- function(x) {
  as.character(unlist(x, use.names = FALSE))
}

deep_copy <- function(x) {
  unserialize(serialize(x, NULL))
}

collect_field_paths <- function(x, path = list(), label = "root") {
  if (!is.list(x) || length(x) == 0L) {
    return(list())
  }
  paths <- list()
  object_names <- names(x)
  for (index in seq_along(x)) {
    has_name <- !is.null(object_names) && nzchar(object_names[[index]])
    key <- if (has_name) object_names[[index]] else index
    child_label <- if (has_name) {
      paste0(label, ".", key)
    } else {
      paste0(label, "[[", index, "]]")
    }
    child_path <- c(path, list(key))
    paths[[child_label]] <- child_path
    child_paths <- collect_field_paths(x[[index]], child_path, child_label)
    if (length(child_paths) > 0L) {
      paths <- c(paths, child_paths)
    }
  }
  paths
}

get_path_value <- function(x, path) {
  value <- x
  for (key in path) {
    value <- value[[key]]
  }
  value
}

set_path_value <- function(x, path, value) {
  key <- path[[1L]]
  if (length(path) == 1L) {
    x[[key]] <- value
    return(x)
  }
  x[[key]] <- set_path_value(x[[key]], path[-1L], value)
  x
}

mutated_value <- function(value) {
  if (is.null(value)) {
    return("__MUTATED_NULL__")
  }
  if (is.character(value)) {
    return(paste0(value, " [MUTATED]"))
  }
  if (is.logical(value)) {
    return(!value)
  }
  if (is.numeric(value)) {
    return(value + 1)
  }
  if (is.list(value)) {
    if (length(value) == 0L) {
      return(list("__MUTATED_EMPTY_LIST__"))
    }
    mutated <- deep_copy(value)
    if (!is.null(names(mutated)) && all(nzchar(names(mutated)))) {
      mutated[["__mutation_marker__"]] <- "MUTATED"
    } else {
      mutated[[length(mutated) + 1L]] <- "MUTATED"
    }
    return(mutated)
  }
  stop("Unsupported fixture value type.", call. = FALSE)
}

expect_validation_error <- function(candidate, label) {
  failed <- FALSE
  tryCatch(
    validate_interface(candidate),
    error = function(e) {
      failed <<- TRUE
    }
  )
  assert_true(failed, paste0("Negative interface fixture was not rejected: ", label))
}

expect_ledger_validation_error <- function(candidate, label) {
  failed <- FALSE
  tryCatch(
    validate_ledger(candidate, expected_equilibrium_ids),
    error = function(e) {
      failed <<- TRUE
    }
  )
  assert_true(failed, paste0("Negative ledger fixture was not rejected: ", label))
}

expect_dag_validation_error <- function(candidate, label) {
  failed <- FALSE
  tryCatch(
    validate_dag_lifecycle(candidate),
    error = function(e) {
      failed <<- TRUE
    }
  )
  assert_true(failed, paste0("Negative DAG fixture was not rejected: ", label))
}

sha256_file <- function(path) {
  shasum <- Sys.which("shasum")
  assert_true(nzchar(shasum), "The 'shasum' executable is required for SHA-256.")
  output <- system2(shasum, c("-a", "256", path), stdout = TRUE, stderr = TRUE)
  hash_lines <- grep("^[0-9a-f]{64}[[:space:]]", output, value = TRUE)
  assert_true(length(hash_lines) == 1L, "Could not compute a unique SHA-256 line.")
  hash <- strsplit(hash_lines, "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", hash), "Malformed SHA-256 output.")
  hash
}

read_utf8_text <- function(path, label) {
  bytes <- readBin(path, what = "raw", n = file.info(path)$size)
  decoded <- rawToChar(bytes)
  converted <- iconv(decoded, from = "UTF-8", to = "UTF-8", sub = NA_character_)
  assert_true(
    length(converted) == 1L && !is.na(converted),
    paste0(label, " is not valid UTF-8.")
  )
  invisible(decoded)
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
interface_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_n2_r2_unanimity_interface.json"
)
ledger_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_n2_r2_unanimity_ledger.json"
)
derivation_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_n2_r2_unanimity_derivation.md"
)
dag_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_game_dag.json"
)

expected_interface_sha256 <- "32a2989f806af20b2557fa8f495dfbe661ac951be59ee68e583fd50735e486ed"
expected_ledger_sha256 <- "e13702a1e3f94fb2a7ea682b15cdf91befc6558497ce363b951959f71ee02049"
expected_derivation_sha256 <- "4e5e839c3d6a8186c334dde3a6484c8a29d84bfb85e72cf3b4a01bce7dc8c6fa"

read_utf8_text(interface_path, "The N2 interface")
read_utf8_text(ledger_path, "The N2 ledger")
derivation_text <- read_utf8_text(derivation_path, "The N2 derivation")

assert_true(
  identical(sha256_file(interface_path), expected_interface_sha256),
  "The N2 interface bytes differ from the independently reviewed candidate hash."
)
assert_true(
  identical(sha256_file(ledger_path), expected_ledger_sha256),
  "The N2 ledger bytes changed during a verifier-only repair."
)
assert_true(
  identical(sha256_file(derivation_path), expected_derivation_sha256),
  "The N2 derivation bytes changed during a verifier-only repair."
)

interface <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
ledger <- jsonlite::fromJSON(ledger_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
canonical_interface <- deep_copy(interface)

required_record_fields <- c(
  "equilibrium_id",
  "admissibility_conditions",
  "branch_classification",
  "strategy_profile",
  "belief_system",
  "source_continuation_record_ids",
  "source_interface_hashes",
  "existence_uniqueness_status",
  "selection_status",
  "assumptions_used",
  "checks_performed",
  "recognized_proposer_payoff",
  "weak_nonproposer_pre_recognition_expected_value",
  "hegemon_payoff_by_type",
  "outcome_distribution",
  "payoff_date"
)

expected_cell_ids <- c(
  "N2-CELL-LOW-TYPE-ONLY",
  "N2-CELL-POOLING"
)

expected_equilibrium_ids <- c(
  "N2-EQ-LOW-TYPE-ONLY",
  "N2-EQ-POOLING"
)

expected_low_domain <- paste0(
  "Primitive domain: 0 < o_0 < o_1 < 1, o_1 <= y_bar <= 1, ",
  "and 0 <= nu <= nu_star, where nu_star=(o_1-o_0)/(1-o_0) is strictly between 0 and 1."
)
expected_pool_domain <- paste0(
  "Primitive domain: 0 < o_0 < o_1 < 1, o_1 <= y_bar <= 1, ",
  "and nu_star < nu <= 1, where nu_star=(o_1-o_0)/(1-o_0) is strictly between 0 and 1."
)
expected_low_admissibility <- paste0(
  "0 < o_0 < o_1 < 1, o_1 <= y_bar <= 1, and 0 <= nu <= nu_star, ",
  "where nu_star=(o_1-o_0)/(1-o_0)."
)
expected_pool_admissibility <- paste0(
  "0 < o_0 < o_1 < 1, o_1 <= y_bar <= 1, and nu_star < nu <= 1, ",
  "where nu_star=(o_1-o_0)/(1-o_0)."
)

expected_weak_strategy <- paste0(
  "Vote yes after every feasible proposal. If x_j>0, yes weakly dominates no; ",
  "if x_j=0, the two actions are identical and T^Y selects yes."
)
expected_h_strategy <- list(
  theta_0 = "Vote yes if and only if y >= o_0.",
  theta_1 = "Vote yes if and only if y >= o_1."
)
expected_beliefs <- list(
  entry = "Pr(theta=1)=nu.",
  on_path_ballot = paste0(
    "The recognized weak proposer does not observe theta, so the on-path proposal carries no ",
    "type information and the ballot belief remains nu."
  ),
  off_path_ballot = paste0(
    "After a zero-probability proposal, any belief in [0,1] is admissible. Terminal weak and H ",
    "ballot strategies and the proposer's deviation payoff are invariant to that belief."
  )
)

expected_existence_uniqueness_status <- paste0(
  "Exists. The proposal, pure ballot strategies, outcome distribution, and payoff vector are unique. ",
  "PBE assessments are multiple only through unrestricted payoff-irrelevant beliefs after zero-probability proposals."
)
expected_low_selection_status <- paste0(
  "For nu<nu_star, y=o_0 strictly maximizes proposer payoff. At nu=nu_star, y=o_0 and y=o_1 ",
  "tie for proposer payoff before the proposal-level tie-break; the stipulated tie-break selects y=o_0 ",
  "because it gives H strictly lower expected payoff. T^Y selects yes for theta=0 at y=o_0."
)
expected_pooling_selection_status <- paste0(
  "For nu>nu_star, y=o_1 strictly maximizes proposer payoff. T^Y selects yes for theta=1 at y=o_1. ",
  "No proposal-level payoff tie occurs in this cell."
)

claim_spec <- function(claim_id, equilibrium_ids, branch, claim, evidence) {
  list(
    claim_id = claim_id,
    equilibrium_ids = as.list(equilibrium_ids),
    branch = branch,
    payoff_date = "R2",
    claim = claim,
    status = "proved",
    evidence = evidence
  )
}

both_equilibrium_ids <- c("N2-EQ-LOW-TYPE-ONLY", "N2-EQ-POOLING")
expected_claims <- list(
  claim_spec(
    "N2-CLM-001",
    both_equilibrium_ids,
    "all",
    "R2 is terminal: approval and failure pay in current R2 units, and no expression or incentive contains beta.",
    "Contract Sections 4 and 6; derivation Sections 1, 2, and 10."
  ),
  claim_spec(
    "N2-CLM-002",
    both_equilibrium_ids,
    "all",
    "Every weak nonproposer votes yes after every feasible proposal: yes weakly dominates no when x_j>0, and T^Y selects yes when x_j=0.",
    "Terminal stage-game enumeration in derivation Section 3; obligation P6."
  ),
  claim_spec(
    "N2-CLM-003",
    both_equilibrium_ids,
    "all",
    "Given unanimous yes votes by weak nonproposers, H is pivotal and type theta votes yes exactly when y>=o_theta; equality is resolved by T^Y.",
    "H best-response comparison in derivation Section 4; obligation P6."
  ),
  claim_spec(
    "N2-CLM-004",
    both_equilibrium_ids,
    "all",
    "Every maximizing proposal sets all x_j=0 and uses the pie fully; because 1-o_1>0, the optimum passes with positive probability and any slack can be added to r_i to raise proposer payoff strictly.",
    "Deviation argument in derivation Section 5; obligation P0."
  ),
  claim_spec(
    "N2-CLM-005",
    both_equilibrium_ids,
    "all",
    "The only payoff-maximal candidates are y=o_0 with payoff (1-nu)(1-o_0) and y=o_1 with payoff 1-o_1.",
    "Exhaustive piecewise proposer objective in derivation Section 5."
  ),
  claim_spec(
    "N2-CLM-006",
    both_equilibrium_ids,
    "frontier",
    "The frontier nu_star=(o_1-o_0)/(1-o_0) is strictly interior; the low-type-only offer is selected for nu<=nu_star, including equality by the proposal-level H-payoff tie-break, and pooling is selected for nu>nu_star.",
    "Payoff difference identity and proposal-level tie-break in derivation Section 6."
  ),
  claim_spec(
    "N2-CLM-007",
    "N2-EQ-POOLING",
    "former_degenerate_boundary",
    "The former o_1=1, nu=1 degenerate family is outside the primitive domain; at every admissible o_1<1 and nu=1, y=o_1 yields positive proposer payoff 1-o_1 and uniquely dominates every rejected or slack proposal.",
    "Strict-gain comparison in derivation Section 7; obligation P0."
  ),
  claim_spec(
    "N2-CLM-008",
    both_equilibrium_ids,
    "all",
    "Histories with the same entry posterior induce the same R2 maximization problem; history labels and recognized proposer identity matter only by relabeling weak states.",
    "Sufficiency proof in derivation Section 8; obligation P5."
  ),
  claim_spec(
    "N2-CLM-009",
    both_equilibrium_ids,
    "all",
    "The two coverage cells are nonempty, mutually exclusive, and exhaustive over 0<=nu<=1 under 0<o_0<o_1<1; no cell lacks equilibrium.",
    "Partition proof in derivation Section 9 and executable verifier."
  ),
  claim_spec(
    "N2-CLM-010",
    both_equilibrium_ids,
    "all",
    "Passage without H and delay both have probability zero under terminal unanimity for every equilibrium record.",
    "Quota q=N and transition rule in Contract Section 4."
  ),
  claim_spec(
    "N2-CLM-011",
    both_equilibrium_ids,
    "all",
    "Before iid uniform R2 recognition, a representative weak state receives one over m times the recognized-proposer payoff because every weak nonproposer allocation is zero.",
    "Recognition accounting in derivation Section 8."
  ),
  claim_spec(
    "N2-CLM-012",
    both_equilibrium_ids,
    "all",
    "Unrestricted beliefs after zero-probability proposals generate assessment multiplicity but cannot change ballot responses, proposer deviation payoffs, outcomes, or the payoff correspondence in R2.",
    "Belief audit in derivation Sections 3, 4, and 9."
  )
)

expected_ledger <- list(
  ledger_schema = "essential_input_claim_ledger_v1",
  node_id = "N2",
  artifact_path = "model_redesign/essential_input_n2_r2_unanimity_interface.json",
  artifact_hash = paste0("sha256:", expected_interface_sha256),
  node_status = "pending_independent_review",
  claims = expected_claims
)

validate_interface <- function(candidate) {
  assert_true(
    identical(candidate, canonical_interface),
    "The N2 interface differs from the exact canonical semantics anchored by the approved hash."
  )
  assert_true(
    identical(names(candidate), c("schema_ref", "function_of", "correspondence_cells")),
    "The N2 interface has the wrong top-level fields."
  )
  assert_true(
    identical(candidate$schema_ref, "equilibrium_correspondence_v1"),
    "The N2 interface schema is wrong."
  )
  assert_true(
    identical(names(candidate$function_of), c("name", "domain")) &&
      identical(candidate$function_of$name, "entry_belief") &&
      identical(candidate$function_of$domain, "[0,1]"),
    "The N2 interface function_of object does not preserve the full belief domain."
  )

  cells <- candidate$correspondence_cells
  assert_true(is.list(cells) && length(cells) == 2L, "N2 must have exactly two coverage cells.")
  cell_ids <- vapply(cells, `[[`, character(1), "cell_id")
  assert_true(
    identical(cell_ids, expected_cell_ids) && length(unique(cell_ids)) == 2L,
    "N2 coverage-cell ids are wrong, duplicated, or include the excluded degenerate cell."
  )
  assert_true(
    identical(cells[[1L]]$domain_conditions, expected_low_domain) &&
      identical(cells[[2L]]$domain_conditions, expected_pool_domain),
    "The strict primitive domain or the nu_star coverage frontier is wrong."
  )

  records <- list()
  for (cell in cells) {
    assert_true(
      identical(
        names(cell),
        c(
          "cell_id",
          "domain_conditions",
          "existence_status",
          "equilibrium_records",
          "nonexistence_certificate"
        )
      ),
      paste0("Malformed coverage cell: ", cell$cell_id)
    )
    assert_true(
      identical(cell$existence_status, "exists") &&
        is.list(cell$equilibrium_records) &&
        length(cell$equilibrium_records) == 1L &&
        is.null(cell$nonexistence_certificate),
      paste0("The exists envelope is malformed in ", cell$cell_id)
    )
    record <- cell$equilibrium_records[[1L]]
    assert_true(
      identical(names(record), required_record_fields),
      paste0("Wrong or reordered equilibrium fields in ", record$equilibrium_id)
    )
    assert_true(
      length(record$source_continuation_record_ids) == 0L &&
        length(record$source_interface_hashes) == 0L,
      paste0("Terminal N2 record imports a continuation: ", record$equilibrium_id)
    )
    assert_true(
      identical(record$strategy_profile$weak_nonproposer_ballot, expected_weak_strategy) &&
        identical(record$strategy_profile$hegemon_ballot_by_type, expected_h_strategy),
      paste0("A terminal ballot strategy was mutated in ", record$equilibrium_id)
    )
    assert_true(
      identical(record$belief_system, expected_beliefs),
      paste0("The N2 belief system was mutated or restricted in ", record$equilibrium_id)
    )
    assert_true(
      identical(record$existence_uniqueness_status, expected_existence_uniqueness_status),
      paste0("The existence or uniqueness semantics were mutated in ", record$equilibrium_id)
    )
    assert_true(
      identical(names(record$hegemon_payoff_by_type), c("theta_0", "theta_1")),
      paste0("Wrong H-type payoff fields in ", record$equilibrium_id)
    )
    assert_true(
      identical(
        names(record$outcome_distribution),
        c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
      ),
      paste0("Wrong outcome fields in ", record$equilibrium_id)
    )
    assert_true(
      identical(record$outcome_distribution$pass_without_hegemon, "0") &&
        identical(record$outcome_distribution$delay, "0"),
      paste0("Unanimity N2 cannot pass without H or delay: ", record$equilibrium_id)
    )
    assert_true(
      identical(record$payoff_date, "R2_current_units_no_beta"),
      paste0("Wrong payoff date in ", record$equilibrium_id)
    )
    payoff_expressions <- c(
      record$recognized_proposer_payoff,
      record$weak_nonproposer_pre_recognition_expected_value,
      as_character(record$hegemon_payoff_by_type),
      as_character(record$outcome_distribution)
    )
    assert_true(
      !any(grepl("beta", payoff_expressions, fixed = TRUE)),
      paste0("An R2 payoff or probability expression contains beta in ", record$equilibrium_id)
    )
    assumptions <- paste(as_character(record$assumptions_used), collapse = " ")
    checks <- as_character(record$checks_performed)
    assert_true(
      grepl("0 < o_0 < o_1 < 1", assumptions, fixed = TRUE) &&
        all(c("P0 full-pie test", "P5 posterior-sufficiency test", "P6 terminal refinement test") %in% checks),
      paste0("The strict domain or required P0/P5/P6 checks are missing in ", record$equilibrium_id)
    )
    records[[record$equilibrium_id]] <- record
  }

  assert_true(
    identical(names(records), expected_equilibrium_ids),
    "The equilibrium ids are wrong, duplicated, or incomplete."
  )

  low <- records[["N2-EQ-LOW-TYPE-ONLY"]]
  assert_true(
    identical(low$admissibility_conditions, expected_low_admissibility) &&
      identical(
        low$strategy_profile$recognized_weak_proposer,
        "Choose y=o_0, x_j=0 for every weak nonproposer j, and r_i=1-o_0."
      ) &&
      identical(low$recognized_proposer_payoff, "(1-nu)*(1-o_0)") &&
      identical(low$weak_nonproposer_pre_recognition_expected_value, "((1-nu)*(1-o_0))/m") &&
      identical(low$hegemon_payoff_by_type, list(theta_0 = "o_0", theta_1 = "o_1")) &&
      identical(
        low$outcome_distribution,
        list(pass_with_hegemon = "1-nu", pass_without_hegemon = "0", failure = "nu", delay = "0")
      ) &&
      identical(low$selection_status, expected_low_selection_status),
    "The low-type-only record has a wrong domain, strategy, payoff, outcome, or frontier selection."
  )

  pooling <- records[["N2-EQ-POOLING"]]
  assert_true(
    identical(pooling$admissibility_conditions, expected_pool_admissibility) &&
      identical(
        pooling$strategy_profile$recognized_weak_proposer,
        "Choose y=o_1, x_j=0 for every weak nonproposer j, and r_i=1-o_1."
      ) &&
      identical(pooling$recognized_proposer_payoff, "1-o_1") &&
      identical(pooling$weak_nonproposer_pre_recognition_expected_value, "(1-o_1)/m") &&
      identical(pooling$hegemon_payoff_by_type, list(theta_0 = "o_1", theta_1 = "o_1")) &&
      identical(
        pooling$outcome_distribution,
        list(pass_with_hegemon = "1", pass_without_hegemon = "0", failure = "0", delay = "0")
      ) &&
      identical(pooling$selection_status, expected_pooling_selection_status),
    "The pooling record has a wrong domain, strategy, payoff, outcome, or frontier selection."
  )

  invisible(TRUE)
}

validate_ledger <- function(candidate, valid_equilibrium_ids) {
  assert_true(
    identical(candidate, expected_ledger),
    "The N2 ledger differs from the exact canonical atomic claim ledger."
  )
  assert_true(
    identical(
      names(candidate),
      c("ledger_schema", "node_id", "artifact_path", "artifact_hash", "node_status", "claims")
    ),
    "The N2 ledger has the wrong top-level fields."
  )
  assert_true(
    identical(candidate$ledger_schema, "essential_input_claim_ledger_v1") &&
      identical(candidate$node_id, "N2") &&
      identical(
        candidate$artifact_path,
        "model_redesign/essential_input_n2_r2_unanimity_interface.json"
      ) &&
      grepl("^sha256:[0-9a-f]{64}$", candidate$artifact_hash) &&
      identical(candidate$node_status, "pending_independent_review"),
    "The N2 ledger identity, hash format, or pending lifecycle status is wrong."
  )
  claims <- candidate$claims
  assert_true(is.list(claims) && length(claims) == 12L, "The N2 ledger must contain exactly 12 atomic claims.")
  claim_ids <- vapply(claims, `[[`, character(1), "claim_id")
  expected_claim_ids <- vapply(expected_claims, `[[`, character(1), "claim_id")
  assert_true(
    identical(claim_ids, expected_claim_ids) && length(unique(claim_ids)) == length(claim_ids),
    "Ledger claim ids are missing, reordered, or duplicated."
  )
  for (claim_index in seq_along(claims)) {
    claim <- claims[[claim_index]]
    assert_true(
      identical(
        names(claim),
        c("claim_id", "equilibrium_ids", "branch", "payoff_date", "claim", "status", "evidence")
      ),
      paste0("Malformed ledger claim: ", claim$claim_id)
    )
    assert_true(
      identical(claim, expected_claims[[claim_index]]),
      paste0("Ledger claim content was mutated or contradicted: ", claim$claim_id)
    )
    linked_ids <- as_character(claim$equilibrium_ids)
    assert_true(
      length(linked_ids) > 0L && all(linked_ids %in% valid_equilibrium_ids),
      paste0("Ledger claim has a missing or invalid equilibrium link: ", claim$claim_id)
    )
  }
  all_claim_text <- paste(vapply(claims, `[[`, character(1), "claim"), collapse = " ")
  all_evidence <- paste(vapply(claims, `[[`, character(1), "evidence"), collapse = " ")
  assert_true(
    grepl("slack", all_claim_text, fixed = TRUE) &&
      grepl("same entry posterior", all_claim_text, fixed = TRUE) &&
      grepl("stage-game", all_evidence, fixed = TRUE) &&
      grepl("former o_1=1", all_claim_text, fixed = TRUE),
    "The ledger does not cover P0, P5, P6, and exclusion of the former corner."
  )
  invisible(TRUE)
}

validate_dag_lifecycle <- function(candidate) {
  nodes <- candidate$nodes
  node_ids <- vapply(nodes, `[[`, character(1), "id")
  assert_true(sum(node_ids == "N2") == 1L, "The DAG must contain exactly one N2 node.")
  n2 <- nodes[[which(node_ids == "N2")]]
  reviews <- n2$reviews
  assert_true(
    identical(
      names(n2),
      c(
        "id", "name", "round", "institution", "depends_on", "status", "interface",
        "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
        "passed_order", "frozen", "reviews"
      )
    ) &&
      identical(n2$name, "r2_unanimity") &&
      identical(n2$round, "R2") &&
      identical(n2$institution, "unanimity") &&
      length(n2$depends_on) == 0L &&
      identical(n2$status, "pass") &&
      identical(n2$frozen, TRUE) &&
      identical(n2$artifact_path, "essential_input_n2_r2_unanimity_interface.json") &&
      identical(n2$artifact_hash, paste0("sha256:", expected_interface_sha256)) &&
      is.list(n2$dependency_hashes) && length(n2$dependency_hashes) == 0L &&
      identical(as.integer(n2$started_order), 2L) &&
      identical(as.integer(n2$passed_order), 4L) &&
      identical(n2$interface, interface) &&
      is.list(reviews) && length(reviews) == 2L &&
      identical(vapply(reviews, `[[`, character(1), "reviewer_role"), c("formal_design", "game_theory")) &&
      identical(
        vapply(reviews, `[[`, character(1), "reviewer_id"),
        c(
          "review-n1-n2-o1-formal-2026-08-18-r3",
          "review-n1-n2-o1-game-2026-08-18-r3"
        )
      ) &&
      all(vapply(reviews, function(review) {
        identical(review$verdict, "PASS") &&
          identical(review$artifact_hash, paste0("sha256:", expected_interface_sha256)) &&
          all(as.numeric(unlist(review$finding_counts, use.names = FALSE)) == 0)
      }, logical(1))),
    "N2 must remain dependency-free and frozen on the exact r3-reviewed candidate."
  )
  invisible(TRUE)
}

validate_interface(interface)
validate_ledger(ledger, expected_equilibrium_ids)
validate_dag_lifecycle(dag)

# Algebraic and numerical boundary audit for the exhaustive proposer objective.
parameter_pairs <- list(
  c(o0 = 0.10, o1 = 0.40),
  c(o0 = 0.10, o1 = 0.90),
  c(o0 = 0.35, o1 = 0.70),
  c(o0 = 0.80, o1 = 0.95),
  c(o0 = 0.998, o1 = 0.999)
)

for (pair in parameter_pairs) {
  o0 <- unname(pair[["o0"]])
  o1 <- unname(pair[["o1"]])
  assert_true(0 < o0 && o0 < o1 && o1 < 1, "A numerical fixture left the strict primitive domain.")
  nu_star <- (o1 - o0) / (1 - o0)
  assert_true(nu_star > 0 && nu_star < 1, "nu_star must be strictly interior when o_1<1.")
  nus <- unique(c(0, nu_star / 2, nu_star, (nu_star + 1) / 2, 1))
  for (nu in nus) {
    low_value <- (1 - nu) * (1 - o0)
    pooling_value <- 1 - o1
    assert_true(
      isTRUE(all.equal(
        low_value - pooling_value,
        (1 - o0) * (nu_star - nu),
        tolerance = 1e-12
      )),
      "The proposer payoff difference identity failed."
    )
    if (nu <= nu_star + 1e-12) {
      assert_true(
        low_value + 1e-12 >= pooling_value && low_value > 0,
        "The low-type-only cell has the wrong maximizing value."
      )
      if (isTRUE(all.equal(nu, nu_star))) {
        h_low <- (1 - nu) * o0 + nu * o1
        h_pooling <- o1
        assert_true(
          h_low < h_pooling,
          "The proposal-level tie-break must select the low-type-only offer at nu_star."
        )
      }
    } else {
      assert_true(
        pooling_value > low_value && pooling_value > 0,
        "The pooling cell has the wrong maximizing value."
      )
    }

    y_grid <- sort(unique(c(
      0,
      o0 / 2,
      o0,
      (o0 + o1) / 2,
      o1,
      (o1 + 1) / 2,
      1
    )))
    proposer_objective <- vapply(
      y_grid,
      function(y) {
        if (y < o0) {
          0
        } else if (y < o1) {
          (1 - nu) * (1 - y)
        } else {
          1 - y
        }
      },
      numeric(1)
    )
    assert_true(
      isTRUE(all.equal(max(proposer_objective), max(low_value, pooling_value), tolerance = 1e-12)),
      "Grid enumeration found a proposer value outside the two candidate thresholds."
    )
  }

  # The formerly degenerate belief nu=1 is now regular and uniquely pooling.
  assert_true(
    (1 - o1) > 0 && (1 - o1) > (1 - 1) * (1 - o0),
    "At nu=1, strict o_1<1 must make pooling strictly better than rejection."
  )
}

# Proportional negative tests. Every corruption is passed through the same
# validators used for the candidate; adding these fixtures strengthens rather
# than replaces the earlier schema, terminality, transition, and formula tests.
bad_missing_field <- deep_copy(interface)
bad_missing_field$correspondence_cells[[1L]]$equilibrium_records[[1L]]$outcome_distribution$failure <- NULL
expect_validation_error(bad_missing_field, "missing required outcome field")

bad_belief_domain <- deep_copy(interface)
bad_belief_domain$function_of$domain <- "[0,1)"
expect_validation_error(bad_belief_domain, "wrong entry-belief domain")

bad_primitive_domain <- deep_copy(interface)
bad_primitive_domain$correspondence_cells[[1L]]$domain_conditions <- sub(
  "o_1 < 1",
  "o_1 <= 1",
  bad_primitive_domain$correspondence_cells[[1L]]$domain_conditions,
  fixed = TRUE
)
expect_validation_error(bad_primitive_domain, "wrong strict o_1 domain")

bad_branch_append <- deep_copy(interface)
bad_branch_append$correspondence_cells[[2L]]$equilibrium_records[[1L]]$branch_classification <- paste0(
  bad_branch_append$correspondence_cells[[2L]]$equilibrium_records[[1L]]$branch_classification,
  "; arbitrary slack or mixed proposals also survive at nu=1"
)
expect_validation_error(bad_branch_append, "contradiction appended to branch classification")

bad_assumption_o1_equal_one <- deep_copy(interface)
bad_assumption_o1_equal_one$correspondence_cells[[2L]]$equilibrium_records[[1L]]$assumptions_used[[1L]] <- paste0(
  bad_assumption_o1_equal_one$correspondence_cells[[2L]]$equilibrium_records[[1L]]$assumptions_used[[1L]],
  "; o_1=1 is also admissible"
)
expect_validation_error(bad_assumption_o1_equal_one, "o_1=1 appended to assumptions_used")

bad_checks_corner_survival <- deep_copy(interface)
bad_checks_corner_survival$correspondence_cells[[2L]]$equilibrium_records[[1L]]$checks_performed[[7L]] <-
  "Checked that the o_1=1 degenerate corner survives."
expect_validation_error(bad_checks_corner_survival, "contradiction appended to checks_performed")

bad_h_payoff <- deep_copy(interface)
bad_h_payoff$correspondence_cells[[1L]]$equilibrium_records[[1L]]$hegemon_payoff_by_type$theta_1 <- "o_0"
expect_validation_error(bad_h_payoff, "wrong high-type H disagreement payoff")

bad_transition <- deep_copy(interface)
bad_transition$correspondence_cells[[2L]]$equilibrium_records[[1L]]$outcome_distribution$pass_without_hegemon <- "1"
expect_validation_error(bad_transition, "passage without H under unanimity")

bad_outcome <- deep_copy(interface)
bad_outcome$correspondence_cells[[1L]]$equilibrium_records[[1L]]$outcome_distribution$failure <- "0"
expect_validation_error(bad_outcome, "wrong low-type-only outcome distribution")

bad_continuation <- deep_copy(interface)
bad_continuation$correspondence_cells[[1L]]$equilibrium_records[[1L]]$source_continuation_record_ids <- list("N0-EQ")
expect_validation_error(bad_continuation, "terminal node imports a continuation")

bad_discount <- deep_copy(interface)
bad_discount$correspondence_cells[[1L]]$equilibrium_records[[1L]]$recognized_proposer_payoff <- "beta*(1-nu)*(1-o_0)"
expect_validation_error(bad_discount, "beta inserted inside R2")

bad_weak_strategy <- deep_copy(interface)
bad_weak_strategy$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$weak_nonproposer_ballot <- "Vote no."
expect_validation_error(bad_weak_strategy, "mutated weak stage-undominated strategy")

bad_h_strategy <- deep_copy(interface)
bad_h_strategy$correspondence_cells[[2L]]$equilibrium_records[[1L]]$strategy_profile$hegemon_ballot_by_type$theta_1 <- "Vote yes if y > o_1."
expect_validation_error(bad_h_strategy, "mutated H equality strategy")

bad_on_path_belief <- deep_copy(interface)
bad_on_path_belief$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system$on_path_ballot <- "Update to one."
expect_validation_error(bad_on_path_belief, "mutated on-path belief")

bad_off_path_belief <- deep_copy(interface)
bad_off_path_belief$correspondence_cells[[2L]]$equilibrium_records[[1L]]$belief_system$off_path_ballot <- "Belief must equal nu."
expect_validation_error(bad_off_path_belief, "invented off-path belief restriction")

bad_frontier <- deep_copy(interface)
bad_frontier$correspondence_cells[[1L]]$domain_conditions <- sub(
  "0 <= nu <= nu_star",
  "0 <= nu < nu_star",
  bad_frontier$correspondence_cells[[1L]]$domain_conditions,
  fixed = TRUE
)
expect_validation_error(bad_frontier, "mutated equality frontier")

bad_extra_corner <- deep_copy(interface)
bad_extra_corner$correspondence_cells[[3L]] <- deep_copy(bad_extra_corner$correspondence_cells[[2L]])
bad_extra_corner$correspondence_cells[[3L]]$cell_id <- "N2-CELL-DEGENERATE-CORNER"
expect_validation_error(bad_extra_corner, "reintroduced excluded degenerate cell")

bad_atomless_uniqueness_append <- deep_copy(interface)
bad_atomless_uniqueness_append$correspondence_cells[[2L]]$equilibrium_records[[1L]]$existence_uniqueness_status <- paste0(
  bad_atomless_uniqueness_append$correspondence_cells[[2L]]$equilibrium_records[[1L]]$existence_uniqueness_status,
  " At nu=1, an atomless mixture over slack packages is also an equilibrium."
)
expect_validation_error(
  bad_atomless_uniqueness_append,
  "contradictory atomless mixing appended to uniqueness at nu=1"
)

bad_slack_selection_append <- deep_copy(interface)
bad_slack_selection_append$correspondence_cells[[2L]]$equilibrium_records[[1L]]$selection_status <- paste0(
  bad_slack_selection_append$correspondence_cells[[2L]]$equilibrium_records[[1L]]$selection_status,
  " At nu=1, slack proposals also survive the proposal-level tie-break."
)
expect_validation_error(
  bad_slack_selection_append,
  "contradictory slack survival appended to selection at nu=1"
)

bad_lifecycle <- deep_copy(ledger)
bad_lifecycle$node_status <- "pass"
expect_ledger_validation_error(bad_lifecycle, "candidate self-frozen before independent review")

bad_pending_claim <- deep_copy(ledger)
bad_pending_claim$claims[[1L]]$status <- "pending"
expect_ledger_validation_error(bad_pending_claim, "unresolved claim in submitted candidate")

bad_claim_link <- deep_copy(ledger)
bad_claim_link$claims[[1L]]$equilibrium_ids <- list("N2-EQ-DEGENERATE-CORNER-FAMILY")
expect_ledger_validation_error(bad_claim_link, "claim linked to excluded equilibrium")

bad_corner_survival_claim <- deep_copy(ledger)
bad_corner_survival_claim$claims[[7L]]$claim <- paste0(
  bad_corner_survival_claim$claims[[7L]]$claim,
  " At o_1=1, the degenerate family remains admissible and survives."
)
expect_ledger_validation_error(
  bad_corner_survival_claim,
  "false survival of the excluded o_1=1 corner appended to N2-CLM-007"
)

bad_dag_lifecycle <- deep_copy(dag)
bad_dag_ids <- vapply(bad_dag_lifecycle$nodes, `[[`, character(1), "id")
bad_dag_n2 <- which(bad_dag_ids == "N2")
bad_dag_lifecycle$nodes[[bad_dag_n2]]$reviews[[1L]]$finding_counts$minor <- 1L
expect_dag_validation_error(bad_dag_lifecycle, "DAG N2 frozen with a nonzero review finding")

# Canonical-whitelist completeness test: mutate every interface field and every
# ledger field, including containers, empty source lists, and null certificates.
# Every single in-memory mutation must be rejected by the production validator.
interface_field_paths <- collect_field_paths(interface)
assert_true(length(interface_field_paths) > 0L, "No interface fields were collected for mutation testing.")
for (field_label in names(interface_field_paths)) {
  field_path <- interface_field_paths[[field_label]]
  mutated_interface <- set_path_value(
    deep_copy(interface),
    field_path,
    mutated_value(get_path_value(interface, field_path))
  )
  expect_validation_error(mutated_interface, paste0("generic interface field mutation: ", field_label))
}

ledger_field_paths <- collect_field_paths(ledger)
assert_true(length(ledger_field_paths) > 0L, "No ledger fields were collected for mutation testing.")
for (field_label in names(ledger_field_paths)) {
  field_path <- ledger_field_paths[[field_label]]
  mutated_ledger <- set_path_value(
    deep_copy(ledger),
    field_path,
    mutated_value(get_path_value(ledger, field_path))
  )
  expect_ledger_validation_error(mutated_ledger, paste0("generic ledger field mutation: ", field_label))
}

artifact_hash <- sha256_file(interface_path)
assert_true(
  identical(ledger$artifact_hash, paste0("sha256:", artifact_hash)),
  "The ledger does not record the current N2 interface hash."
)
assert_true(
  grepl(paste0("sha256:", artifact_hash), derivation_text, fixed = TRUE),
  "The derivation does not record the current N2 interface hash."
)

cat("PASS: N2 R2-unanimity strict-interior interface, ledger, formulas, lifecycle, and negative fixtures validated.\n")
cat(
  "Canonical mutation coverage:",
  length(interface_field_paths), "interface fields and",
  length(ledger_field_paths), "ledger fields rejected when changed.\n"
)
cat("SHA-256:", artifact_hash, "\n")
