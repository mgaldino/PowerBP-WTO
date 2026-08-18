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

clone_object <- function(x) {
  unserialize(serialize(x, NULL))
}

all_strings <- function(x) {
  if (is.character(x)) {
    return(x)
  }
  if (!is.list(x)) {
    return(character())
  }
  unlist(lapply(x, all_strings), use.names = FALSE)
}

sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  assert_true(length(output) == 1L, paste("Could not compute SHA-256 for", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

interface_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_interfaces",
  "n1_r2_majority_candidate_v1.json"
)
ledger_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_n1_claim_ledger.tsv"
)
dag_path <- file.path(repository_root, "model_redesign", "essential_input_game_dag.json")

expected_interface_hash <- "af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd"
expected_ledger_hash <- "b438312588ed8af113b6a4313bf78df625aa954abfcbf3e4b4ed795630d2b990"
artifact_hash <- sha256_file(interface_path)
ledger_hash <- sha256_file(ledger_path)
assert_true(
  identical(artifact_hash, expected_interface_hash),
  "The N1 candidate bytes differ from the reviewed canonical artifact."
)
assert_true(
  identical(ledger_hash, expected_ledger_hash),
  "The N1 ledger bytes differ from the canonical ten-claim ledger."
)

interface_bytes <- readBin(interface_path, what = "raw", n = file.info(interface_path)$size)
interface_text <- rawToChar(interface_bytes)
assert_true(validUTF8(interface_text), "The N1 interface must be valid UTF-8.")

candidate <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
canonical_candidate <- clone_object(candidate)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
node_ids <- vapply(dag$nodes, `[[`, character(1), "id")
nodes <- dag$nodes
names(nodes) <- node_ids
n1_reviews <- nodes$N1$reviews
assert_true(
  identical(
    names(nodes$N1),
    c(
      "id", "name", "round", "institution", "depends_on", "status", "interface",
      "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
      "passed_order", "frozen", "reviews"
    )
  ) &&
    identical(nodes$N1$status, "pass") &&
    identical(nodes$N1$frozen, TRUE) &&
    identical(nodes$N1$artifact_path, "essential_input_interfaces/n1_r2_majority_candidate_v1.json") &&
    identical(nodes$N1$artifact_hash, paste0("sha256:", expected_interface_hash)) &&
    is.list(nodes$N1$dependency_hashes) && length(nodes$N1$dependency_hashes) == 0L &&
    identical(as.integer(nodes$N1$started_order), 1L) &&
    identical(as.integer(nodes$N1$passed_order), 3L) &&
    identical(nodes$N1$interface, candidate) &&
    is.list(n1_reviews) && length(n1_reviews) == 2L &&
    identical(vapply(n1_reviews, `[[`, character(1), "reviewer_role"), c("formal_design", "game_theory")) &&
    identical(
      vapply(n1_reviews, `[[`, character(1), "reviewer_id"),
      c(
        "review-n1-n2-o1-formal-2026-08-18-r3",
        "review-n1-n2-o1-game-2026-08-18-r3"
      )
    ) &&
    all(vapply(n1_reviews, function(review) {
      identical(review$verdict, "PASS") &&
        identical(review$artifact_hash, paste0("sha256:", expected_interface_hash)) &&
        all(as.numeric(unlist(review$finding_counts, use.names = FALSE)) == 0)
    }, logical(1))),
  "N1 must remain frozen on the exact r3-reviewed candidate in the shared DAG."
)

equilibrium_schema <- dag$interface_schemas$equilibrium_correspondence_v1
expected_record_fields <- as_character(equilibrium_schema$record_fields)
expected_outcome_fields <- as_character(equilibrium_schema$outcome_distribution_fields)
expected_hegemon_fields <- as_character(equilibrium_schema$hegemon_payoff_by_type_fields)

validate_candidate <- function(object) {
  assert_true(
    identical(object, canonical_candidate),
    paste0(
      "The N1 object must be identical to the hash-anchored canonical interface; ",
      "any in-memory mutation of any field is forbidden."
    )
  )
  assert_true(
    identical(names(object), c("schema_ref", "function_of", "correspondence_cells")),
    "The immutable N1 interface must contain exactly the three DAG interface fields."
  )
  assert_true(
    identical(object$schema_ref, "equilibrium_correspondence_v1"),
    "N1 must implement equilibrium_correspondence_v1."
  )
  assert_true(
    identical(object$function_of$name, "entry_belief") &&
      identical(names(object$function_of), c("name", "domain")) &&
      identical(object$function_of$domain, "[0,1]"),
    "N1 must expose the declared entry-belief domain."
  )

  cells <- object$correspondence_cells
  assert_true(is.list(cells) && length(cells) == 1L, "N1 must have one exhaustive coverage cell.")
  cell <- cells[[1L]]
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
    "The N1 coverage cell has missing or extra fields."
  )
  assert_true(identical(cell$cell_id, "N1-CELL-ALL-NU"), "The N1 coverage-cell id changed.")
  expected_domain_conditions <- c(
    "nu in [0,1]",
    "N is an integer and N >= 3",
    "m = N-1",
    "q = floor(N/2)+1",
    "beta in (0,1] and is payoff-irrelevant inside terminal R2",
    "0 < o_0 < o_1 < 1 and o_1 <= y_bar <= 1",
    "the proposal is feasible under y + sum_j x_j + r_i <= 1"
  )
  assert_true(
    identical(as_character(cell$domain_conditions), expected_domain_conditions),
    paste0(
      "The N1 cell must cover exactly the full belief domain, generic majority quota, ",
      "strict 0<o_0<o_1<1 primitive domain, and weak package feasibility."
    )
  )
  assert_true(identical(cell$existence_status, "exists"), "N1 must record the proved existence cell.")
  assert_true(is.null(cell$nonexistence_certificate), "An exists cell must have a null certificate.")
  assert_true(
    is.list(cell$equilibrium_records) && length(cell$equilibrium_records) == 1L,
    "The N1 exists cell must contain exactly the full parametric assessment class record."
  )

  record <- cell$equilibrium_records[[1L]]
  assert_true(
    identical(names(record), expected_record_fields),
    "The N1 equilibrium record does not exactly implement the Gate 0 field schema."
  )
  assert_true(identical(record$equilibrium_id, "N1-EQ-01"), "The N1 equilibrium id changed.")
  expected_admissibility_conditions <- c(
    "all primitive restrictions in N1-CELL-ALL-NU hold",
    "ballot strategies are pure",
    "weak nonproposer strategies satisfy stage-undominated voting",
    "T^Y selects yes only at genuine indifference"
  )
  assert_true(
    identical(as_character(record$admissibility_conditions), expected_admissibility_conditions),
    "N1 admissibility conditions must be exact and cannot append contradictory qualifications."
  )
  assert_true(
    identical(record$branch_classification, "terminal approval without H"),
    "The N1 branch must be classified ex post as terminal approval without H."
  )

  strategy <- record$strategy_profile
  recognized_proposer <- strategy$recognized_weak_proposer
  proposal <- recognized_proposer$proposal
  assert_true(
    identical(
      names(strategy),
      c(
        "recognized_weak_proposer",
        "weak_nonproposer_vote_after_every_feasible_proposal",
        "hegemon_vote_after_every_feasible_proposal"
      )
    ) &&
      identical(names(recognized_proposer), c("proposal", "proposal_is_unique_argmax")) &&
      identical(names(proposal), c("y", "x_j_for_each_weak_nonproposer", "r_i")) &&
      identical(names(strategy$hegemon_vote_after_every_feasible_proposal), c("theta_0", "theta_1")),
    "The N1 strategy profile must have the exact pure-strategy shape and cannot append proposer mixing."
  )
  assert_true(
    identical(proposal$y, "0") &&
      identical(proposal$x_j_for_each_weak_nonproposer, "0") &&
      identical(proposal$r_i, "1") &&
      identical(recognized_proposer$proposal_is_unique_argmax, TRUE),
    "P0 requires the unique full-pie proposal y=0, all x_j=0, r_i=1."
  )
  assert_true(
    identical(strategy$weak_nonproposer_vote_after_every_feasible_proposal, "yes"),
    "P6 and T^Y require every weak nonproposer to vote yes after every feasible R2 proposal."
  )
  assert_true(
    identical(strategy$hegemon_vote_after_every_feasible_proposal$theta_0, "no") &&
      identical(strategy$hegemon_vote_after_every_feasible_proposal$theta_1, "no"),
    "Nonpivotal H must strictly vote no for both types."
  )

  expected_belief_system <- list(
    entry_belief = "Pr(theta=1)=nu",
    on_path_after_proposal =
      "Pr(theta=1 | y=0, every x_j=0, r_i=1)=nu by Bayes",
    off_path_after_zero_probability_proposal = "arbitrary kappa(s) in [0,1]",
    off_path_belief_effect = "none on strategies, outcomes, or payoffs"
  )
  assert_true(
    identical(record$belief_system, expected_belief_system),
    paste0(
      "The belief system must state exact on-path Bayes and unrestricted beliefs after every ",
      "zero-probability proposal, including zero-mass points in any atomless support."
    )
  )
  assert_true(
    identical(record$source_continuation_record_ids, list()) &&
      identical(record$source_interface_hashes, list()),
    "Terminal node N1 cannot import continuation records or hashes."
  )
  expected_existence_uniqueness_status <- paste0(
    "exists; unique strategy profile, outcome, and payoff; multiplicity only in arbitrary ",
    "payoff-irrelevant off-path beliefs"
  )
  expected_selection_status <- paste0(
    "full assessment class preserved; no ad hoc equilibrium selection; proposal tie-break ",
    "inactive because the argmax is unique"
  )
  assert_true(
    identical(record$existence_uniqueness_status, expected_existence_uniqueness_status),
    "N1 existence and uniqueness semantics must be exact and contradiction-free."
  )
  assert_true(
    identical(record$selection_status, expected_selection_status),
    "N1 selection semantics must be exact and contradiction-free."
  )

  expected_assumptions <- c(
    "fixed unit pie and package feasibility from Section 2",
    "majority quota and terminal transition/payoffs from Section 4",
    "PBE with pure ballot strategies, weak-only stage-undominated voting, and T^Y from Section 5",
    "R2 native current units from Section 6",
    "iid uniform recognition with replacement"
  )
  assert_true(
    identical(as_character(record$assumptions_used), expected_assumptions),
    paste0(
      "N1 assumptions_used must equal the canonical whitelist and cannot append mixture, ",
      "slack, or o_1=1 qualifications."
    )
  )

  checks <- as_character(record$checks_performed)
  expected_checks <- c(
    "N1-C01 weak yes weakly dominates no when x_j>0",
    "N1-C02 T^Y selects weak yes when x_j=0",
    "N1-C03 H strictly votes no when nonpivotal while y is fully executed",
    "N1-C04 P0 unique full-pie proposer optimum",
    "N1-C05 sequential rationality after every feasible proposal",
    "N1-C06 exhaustive correspondence with off-path belief multiplicity preserved",
    "N1-C07 no internal discount in R2 payoffs",
    "N1-C08 P5 posterior sufficiency",
    "N1-C09 P6 on-path refinement effect",
    "N1-C10 strict o_1<1 domain restriction leaves the N1 correspondence invariant"
  )
  assert_true(
    identical(checks, expected_checks),
    paste0(
      "The interface must state the exact content of claims N1-C01 through N1-C10, ",
      "including strict-domain invariance."
    )
  )

  assert_true(
    identical(record$recognized_proposer_payoff, "1"),
    "The recognized proposer payoff must be one."
  )
  assert_true(
    identical(record$weak_nonproposer_pre_recognition_expected_value, "1/m"),
    "The symmetric pre-recognition weak-state value must be 1/m."
  )
  assert_true(
    identical(names(record$hegemon_payoff_by_type), expected_hegemon_fields) &&
      identical(record$hegemon_payoff_by_type$theta_0, "o_0") &&
      identical(record$hegemon_payoff_by_type$theta_1, "o_1"),
    "Full execution with y=0 and H's strict no requires H payoff (o_0,o_1)."
  )
  assert_true(
    identical(names(record$outcome_distribution), expected_outcome_fields),
    "The N1 outcome distribution has the wrong fields."
  )
  outcomes <- as.numeric(unlist(record$outcome_distribution, use.names = FALSE))
  assert_true(
    identical(outcomes, c(0, 1, 0, 0)) && sum(outcomes) == 1,
    "N1 must pass without H with probability one and have no failure or delay."
  )
  assert_true(
    identical(record$payoff_date, "R2 current units"),
    "N1 payoffs must remain in current R2 units."
  )
  assert_true(
    !any(grepl("\\bbeta\\b", all_strings(record), perl = TRUE)),
    "No internal beta term is permitted in an R2 equilibrium record."
  )

  invisible(TRUE)
}

validate_ledger <- function(ledger) {
  assert_true(
    identical(ledger, canonical_ledger),
    paste0(
      "The N1 ledger object must be identical to the hash-anchored canonical ledger; ",
      "any in-memory mutation is forbidden."
    )
  )
  expected_columns <- c(
    "claim_id",
    "equilibrium_id",
    "branch",
    "payoff_date",
    "claim",
    "status",
    "evidence"
  )
  assert_true(identical(names(ledger), expected_columns), "The N1 ledger has the wrong columns.")
  assert_true(nrow(ledger) == 10L, "The N1 ledger must contain ten atomic claims.")
  assert_true(
    identical(ledger$claim_id, sprintf("N1-C%02d", 1:10)),
    "The N1 ledger claim ids must be unique and exhaustive from N1-C01 to N1-C10."
  )
  expected_branches <- c(
    "all feasible proposals",
    "all feasible proposals",
    "H nonpivotal",
    "proposer optimization",
    "all feasible proposals",
    "full correspondence",
    "native-time audit",
    "posterior sufficiency",
    "on-path refinement",
    "strict primitive domain"
  )
  expected_claims <- c(
    "For x_j>0, yes weakly dominates no for every weak nonproposer.",
    "For x_j=0, yes and no are genuinely payoff-identical and T^Y selects yes.",
    paste0(
      "The weak votes meet the majority quota; full execution gives H y after yes and ",
      "y+o_theta after no, so both types strictly vote no."
    ),
    "The unique proposer optimum is y=0, every x_j=0, r_i=1; slack cannot maximize, so P0 holds.",
    paste0(
      "The specified pure strategies and admissible beliefs form a PBE satisfying weak-only ",
      "stage-undominance and T^Y."
    ),
    paste0(
      "All admissible assessments share the unique strategy, outcome, and payoff; only ",
      "payoff-irrelevant off-path beliefs vary."
    ),
    "All interface payoffs are in R2 current units with no internal discount.",
    paste0(
      "Histories with the same posterior induce the same terminal maximization; P5 holds ",
      "without a Markov restriction."
    ),
    paste0(
      "Stage-undominance removes weak no when x_j>0; at the on-path x_j=0, T^Y selects ",
      "yes under genuine indifference; P6 holds."
    ),
    paste0(
      "Restricting to 0<o_0<o_1<1 with o_1<=y_bar<=1 leaves the N1 strategy, belief class, ",
      "payoff, outcome, and multiplicity correspondence unchanged."
    )
  )
  expected_evidence <- paste0(
    "model_redesign/essential_input_n1_r2_majority_derivation.md#claim-n1-c",
    sprintf("%02d", 1:10)
  )
  assert_true(
    identical(ledger$equilibrium_id, rep("N1-EQ-01", 10L)),
    "Every N1 claim must bind exactly to N1-EQ-01."
  )
  assert_true(
    identical(ledger$branch, expected_branches),
    "Every N1 ledger branch must match its exact atomic claim."
  )
  assert_true(
    identical(ledger$payoff_date, rep("R2", 10L)),
    "Every N1 claim must use exactly the native R2 date."
  )
  assert_true(
    identical(ledger$claim, expected_claims),
    "The N1 ledger must preserve the exact semantics of all ten claims."
  )
  assert_true(
    identical(ledger$status, rep("proved", 10L)),
    "Every current N1 ledger claim must be exactly proved."
  )
  assert_true(
    identical(ledger$evidence, expected_evidence),
    "Every N1 claim must cite its exact derivation anchor."
  )
  invisible(TRUE)
}

expect_candidate_rejection <- function(label, mutate_candidate) {
  altered <- mutate_candidate(clone_object(candidate))
  rejected <- inherits(try(validate_candidate(altered), silent = TRUE), "try-error")
  assert_true(rejected, paste0("Negative test failed: ", label))
}

expect_ledger_rejection <- function(label, mutate_ledger) {
  altered <- mutate_ledger(clone_object(ledger))
  rejected <- inherits(try(validate_ledger(altered), silent = TRUE), "try-error")
  assert_true(rejected, paste0("Negative ledger test failed: ", label))
}

validate_candidate(candidate)

ledger <- utils::read.delim(
  ledger_path,
  header = TRUE,
  sep = "\t",
  quote = "",
  comment.char = "",
  stringsAsFactors = FALSE,
  check.names = FALSE,
  fileEncoding = "UTF-8"
)
canonical_ledger <- clone_object(ledger)
validate_ledger(ledger)

expect_candidate_rejection("null coverage collection", function(x) {
  x$correspondence_cells <- NULL
  x
})
expect_candidate_rejection("duplicated coverage cell", function(x) {
  x$correspondence_cells <- c(x$correspondence_cells, x$correspondence_cells)
  x
})
expect_candidate_rejection("slack proposal", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$strategy_profile$recognized_weak_proposer$proposal$r_i <- "0.9"
  x
})
expect_candidate_rejection("weak no at zero allocation", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$strategy_profile$weak_nonproposer_vote_after_every_feasible_proposal <- "no"
  x
})
expect_candidate_rejection("H yes while nonpivotal", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$strategy_profile$hegemon_vote_after_every_feasible_proposal$theta_1 <- "yes"
  x
})
expect_candidate_rejection("discarded H outside payoff", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$hegemon_payoff_by_type$theta_1 <- "0"
  x
})
expect_candidate_rejection("spurious continuation source", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$source_continuation_record_ids <- list("N0-EQ-01")
  x
})
expect_candidate_rejection("internal R2 discount", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$weak_nonproposer_pre_recognition_expected_value <- "beta/m"
  x
})
expect_candidate_rejection("failure mass", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$outcome_distribution$pass_without_hegemon <- 0
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$outcome_distribution$failure <- 1
  x
})
expect_candidate_rejection("R1 payoff date", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$payoff_date <- "R1 current units"
  x
})
expect_candidate_rejection("off-path belief selection", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$belief_system$off_path_after_zero_probability_proposal <- "kappa(s)=nu"
  x
})
expect_candidate_rejection("atomless-support belief restriction", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$belief_system$off_path_after_zero_probability_proposal <-
    "arbitrary kappa(s) in [0,1], except at zero-mass points in atomless support"
  x
})
expect_candidate_rejection("contradictory on-path Bayes posterior", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$belief_system$on_path_after_proposal <-
    "Pr(theta=1 | y=0, every x_j=0, r_i=1)=nu by Bayes; posterior=1"
  x
})
expect_candidate_rejection("arbitrary proposer mixing", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$strategy_profile$recognized_weak_proposer$mixed_strategy <-
    "arbitrary distribution over proposals"
  x
})
expect_candidate_rejection("contradictory existence status", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$existence_uniqueness_status <-
    paste0(
      x$correspondence_cells[[1]]$equilibrium_records[[1]]$existence_uniqueness_status,
      "; proposer strategies are multiple"
    )
  x
})
expect_candidate_rejection("contradictory selection status", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$selection_status <-
    paste0(
      x$correspondence_cells[[1]]$equilibrium_records[[1]]$selection_status,
      "; arbitrary equilibrium selection is permitted"
    )
  x
})
expect_candidate_rejection("assumptions_used proposer-mixing bypass", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$assumptions_used <- c(
    x$correspondence_cells[[1]]$equilibrium_records[[1]]$assumptions_used,
    list("arbitrary proposer mixtures are admissible")
  )
  x
})
expect_candidate_rejection("assumptions_used slack bypass", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$assumptions_used <- c(
    x$correspondence_cells[[1]]$equilibrium_records[[1]]$assumptions_used,
    list("slack proposals may maximize the proposer payoff")
  )
  x
})
expect_candidate_rejection("assumptions_used o_1=1 bypass", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$assumptions_used <- c(
    x$correspondence_cells[[1]]$equilibrium_records[[1]]$assumptions_used,
    list("the boundary o_1=1 is admissible")
  )
  x
})
expect_candidate_rejection("missing P5 claim", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$checks_performed[[8]] <- "posterior check omitted"
  x
})
expect_candidate_rejection("old weak o_1 boundary", function(x) {
  x$correspondence_cells[[1]]$domain_conditions[[6]] <- "0 < o_0 < o_1 <= y_bar <= 1"
  x
})
expect_candidate_rejection("missing strict-domain invariance claim", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$checks_performed[[10]] <-
    "N1-C10 omitted"
  x
})
expect_candidate_rejection("false interface claim of change under o_1<1", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$checks_performed[[10]] <-
    "N1-C10 strict o_1<1 domain restriction changes the N1 correspondence"
  x
})
expect_candidate_rejection("premature frozen status", function(x) {
  x$status <- "pass"
  x$frozen <- TRUE
  x
})
expect_candidate_rejection("schema field removed", function(x) {
  x$correspondence_cells[[1]]$equilibrium_records[[1]]$selection_status <- NULL
  x
})

# Generic mutation coverage: canonical equality must reject every interface,
# coverage-cell, and equilibrium-record field without relying on a denylist.
for (field_name in names(candidate)) {
  local({
    field <- field_name
    expect_candidate_rejection(paste("generic interface field", field), function(x) {
      x[[field]] <- list(corrupted = field)
      x
    })
  })
}
for (field_name in names(candidate$correspondence_cells[[1L]])) {
  local({
    field <- field_name
    expect_candidate_rejection(paste("generic coverage-cell field", field), function(x) {
      x$correspondence_cells[[1L]][[field]] <- list(corrupted = field)
      x
    })
  })
}
for (field_name in expected_record_fields) {
  local({
    field <- field_name
    expect_candidate_rejection(paste("generic equilibrium-record field", field), function(x) {
      x$correspondence_cells[[1L]]$equilibrium_records[[1L]][[field]] <-
        list(corrupted = field)
      x
    })
  })
}

bad_ledger <- ledger
bad_ledger$status[10] <- "pending"
ledger_rejected <- inherits(try(validate_ledger(bad_ledger), silent = TRUE), "try-error")
assert_true(ledger_rejected, "Negative test failed: a pending atomic claim passed ledger validation.")
expect_ledger_rejection("false N1-C10 change under o_1<1", function(x) {
  x$claim[10] <- paste0(
    "Restricting to 0<o_0<o_1<1 with o_1<=y_bar<=1 changes the N1 strategy, ",
    "belief class, payoff, outcome, and multiplicity correspondence."
  )
  x
})

for (field_name in names(ledger)) {
  local({
    field <- field_name
    expect_ledger_rejection(paste("generic ledger field", field), function(x) {
      x[[field]][1L] <- paste0("CORRUPTED-", field)
      x
    })
  })
}

cat("PASS: N1 R2-majority candidate interface and ledger are internally valid.\n")
cat("PASS: P0, P5, and P6 representation checks passed.\n")
cat("PASS: strict 0<o_0<o_1<1 domain and N1 invariance checks passed.\n")
cat("PASS: all proportional negative tests were rejected.\n")
cat(
  sprintf(
    paste0(
      "PASS: canonical exact-object mutations rejected for %d interface, %d cell, ",
      "%d record, and %d ledger fields.\n"
    ),
    length(names(candidate)),
    length(names(candidate$correspondence_cells[[1L]])),
    length(expected_record_fields),
    length(names(ledger))
  )
)
cat("SHA-256:", artifact_hash, "\n")
cat("STATUS: N1 is pass/frozen on the exact r3-reviewed candidate in the shared DAG.\n")
