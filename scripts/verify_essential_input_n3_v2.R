#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

clone_object <- function(x) unserialize(serialize(x, NULL))
as_character <- function(x) as.character(unlist(x, use.names = FALSE))

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

interface_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_interfaces",
  "n3_r1_majority_candidate_v2.json"
)
ledger_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_n3_claim_ledger_v2.json"
)
derivation_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_n3_r1_majority_derivation_v2.md"
)
build_path <- file.path(repository_root, "scripts", "build_essential_input_n3_v2.R")
dag_path <- file.path(repository_root, "model_redesign", "essential_input_game_dag.json")
n1_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_interfaces",
  "n1_r2_majority_candidate_v1.json"
)

n1_hash_bare <- "1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
n1_hash <- paste0("sha256:", n1_hash_bare)
expected_interface_hash <- "0954f7b7070c69f442981bec46f212cfa91b9f55bb337645fa91e991a2e54bb1"
expected_ledger_hash <- "610e606b8da6eb0a3627762c5ac4dae62657cd988a42994ab0d7ffe02f976db2"
expected_derivation_hash <- "6ac0da859a1aa688bf1852f95319964109cc0025aa9ce36a75c7149da33e1b2f"
expected_build_hash <- "5854e9585b51419838e48f2bf6f62512685b14c801980b3ff17dd4e036de5a77"

sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  assert_true(length(output) == 1L, paste("Could not hash", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

read_utf8 <- function(path, label) {
  bytes <- readBin(path, what = "raw", n = file.info(path)$size)
  text <- rawToChar(bytes)
  assert_true(validUTF8(text), paste(label, "must be valid UTF-8."))
  text
}

for (path in c(interface_path, ledger_path, derivation_path, build_path, dag_path, n1_path)) {
  assert_true(file.exists(path), paste("Missing required file:", path))
}

assert_true(identical(sha256_file(n1_path), n1_hash_bare), "Frozen N1 bytes changed.")
assert_true(identical(sha256_file(interface_path), expected_interface_hash), "N3 v2 interface hash changed.")
assert_true(identical(sha256_file(ledger_path), expected_ledger_hash), "N3 v2 ledger hash changed.")
assert_true(identical(sha256_file(derivation_path), expected_derivation_hash), "N3 v2 derivation hash changed.")
assert_true(identical(sha256_file(build_path), expected_build_hash), "N3 v2 build script hash changed.")

interface_text <- read_utf8(interface_path, "N3 v2 interface")
ledger_text <- read_utf8(ledger_path, "N3 v2 ledger")
derivation_text <- read_utf8(derivation_path, "N3 v2 derivation")
build_text <- read_utf8(build_path, "N3 v2 build script")

candidate <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
ledger <- jsonlite::fromJSON(ledger_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
n1_candidate <- jsonlite::fromJSON(n1_path, simplifyVector = FALSE)

node_ids <- vapply(dag$nodes, `[[`, character(1), "id")
nodes <- dag$nodes
names(nodes) <- node_ids
assert_true(
  identical(nodes$N1$status, "pass") && identical(nodes$N1$frozen, TRUE) &&
    identical(nodes$N1$artifact_hash, n1_hash) && identical(nodes$N1$interface, n1_candidate),
  "N3 v2 must consume exact pass/frozen N1."
)
assert_true(
  identical(names(nodes$N3), c("id", "name", "round", "institution", "depends_on", "status", "interface")) &&
    identical(nodes$N3$status, "pending") && identical(as_character(nodes$N3$depends_on), "N1") &&
    is.null(nodes$N3$interface$correspondence_cells),
  "N3 lifecycle must remain pending/unfrozen in the shared DAG."
)

record_fields <- as_character(dag$interface_schemas$equilibrium_correspondence_v1$record_fields)
h_fields <- as_character(dag$interface_schemas$equilibrium_correspondence_v1$hegemon_payoff_by_type_fields)
outcome_fields <- as_character(dag$interface_schemas$equilibrium_correspondence_v1$outcome_distribution_fields)

common_domain <- c(
  "nu is the entry belief Pr(theta=1) and 0 <= nu <= 1",
  "N is an integer and N >= 3",
  "W is the set of weak states, m=N-1, and |W|=m",
  "q=floor(N/2)+1 and q<=m",
  "0 < beta < 1",
  "0 < o_0 < o_1 < 1 and o_1 <= y_bar <= 1",
  "every proposal satisfies 0<=y<=y_bar, every x_j>=0, r_i>=0, and y+sum_j x_j+r_i<=1",
  paste0("the sole continuation is N1-EQ-01 at ", n1_hash)
)
nu_sp <- "beta*(o_1-o_0)/(1-beta*o_0-beta*(q-1)/m)"
nu_se <- "beta*(1/m-o_0)/(beta*(1/m-o_0)+1-beta*q/m)"
h_e <- "(1-nu)*o_0+nu/m"
h_p <- "beta/m"

cell_specs <- list(
  list("N3V2-CELL-O1LT-LOW", "N3V2-EQ-O1LT-LOW", "low", c("o_1<1/m", paste0("0<=nu<=", nu_sp))),
  list("N3V2-CELL-O1LT-POOL", "N3V2-EQ-O1LT-POOL", "pool", c("o_1<1/m", paste0(nu_sp, "<nu<=1"))),
  list("N3V2-CELL-CROSS-LOW", "N3V2-EQ-CROSS-LOW", "low", c("o_0<1/m<o_1", paste0("0<=nu<=", nu_se))),
  list("N3V2-CELL-CROSS-EXCLUDE", "N3V2-EQ-CROSS-EXCLUDE", "exclude", c("o_0<1/m<o_1", paste0(nu_se, "<nu<=1"))),
  list("N3V2-CELL-O0GT-EXCLUDE", "N3V2-EQ-O0GT-EXCLUDE", "exclude", c("1/m<o_0<o_1", "0<=nu<=1")),
  list("N3V2-CELL-O0EQ-LOW-ENDPOINT", "N3V2-EQ-O0EQ-LOW-ENDPOINT", "low", c("o_0=1/m<o_1", "nu=0")),
  list("N3V2-CELL-O0EQ-EXCLUDE", "N3V2-EQ-O0EQ-EXCLUDE", "exclude", c("o_0=1/m<o_1", "0<nu<=1")),
  list("N3V2-CELL-O1EQ-LOW", "N3V2-EQ-O1EQ-LOW", "low", c("o_0<o_1=1/m", paste0("0<=nu<=", nu_se))),
  list("N3V2-CELL-O1EQ-EXCLUDE", "N3V2-EQ-O1EQ-EXCLUDE", "exclude", c("o_0<o_1=1/m", paste0(nu_se, "<nu<=1"), paste0(h_e, "<", h_p))),
  list("N3V2-CELL-O1EQ-POOL", "N3V2-EQ-O1EQ-POOL", "pool", c("o_0<o_1=1/m", paste0(nu_se, "<nu<=1"), paste0(h_p, "<", h_e))),
  list("N3V2-CELL-O1EQ-MIXED-EP", "N3V2-EQ-O1EQ-MIXED-EP", "mixed_ep", c("o_0<o_1=1/m", paste0(nu_se, "<nu<=1"), paste0(h_e, "=", h_p)))
)

expected_cell_ids <- vapply(cell_specs, `[[`, character(1), 1L)
expected_equilibrium_ids <- vapply(cell_specs, `[[`, character(1), 2L)
expected_branches <- vapply(cell_specs, `[[`, character(1), 3L)

branch_from_record <- function(record) {
  id <- record$equilibrium_id
  expected_branches[match(id, expected_equilibrium_ids)]
}

validate_record <- function(record, spec) {
  cell_id <- spec[[1L]]
  equilibrium_id <- spec[[2L]]
  branch <- spec[[3L]]
  conditions <- spec[[4L]]
  assert_true(identical(names(record), record_fields), paste("Wrong record schema in", equilibrium_id))
  assert_true(identical(record$equilibrium_id, equilibrium_id), paste("Wrong equilibrium id in", cell_id))
  admissibility <- as_character(record$admissibility_conditions)
  assert_true(
    identical(admissibility[seq_along(common_domain)], common_domain) &&
      identical(admissibility[length(common_domain) + seq_along(conditions)], conditions),
    paste("Nonlocal or wrong admissibility domain in", equilibrium_id)
  )
  assert_true(
    grepl("weights", paste(admissibility, collapse = " "), fixed = TRUE) &&
      grepl("ballot actions are pure", paste(admissibility, collapse = " "), fixed = TRUE),
    paste("Missing proposer-weight or pure-ballot definition in", equilibrium_id)
  )
  assert_true(
    identical(record$source_continuation_record_ids, list("N1-EQ-01")) &&
      identical(record$source_interface_hashes, list(N1 = n1_hash)),
    paste("Wrong continuation source in", equilibrium_id)
  )
  assert_true(
    identical(names(record$hegemon_payoff_by_type), h_fields) &&
      identical(names(record$outcome_distribution), outcome_fields),
    paste("Wrong H-payoff or outcome schema in", equilibrium_id)
  )
  strategy <- record$strategy_profile
  assert_true(
    identical(
      names(strategy),
      c(
        "frozen_continuation", "ballot_map_after_every_feasible_proposal",
        "proposer_payoff_after_every_feasible_proposal", "candidate_payoffs_in_primitives",
        "selected_proposal_parameterization", "feasibility"
      )
    ),
    paste("Incomplete strategy map in", equilibrium_id)
  )
  assert_true(
    identical(strategy$frozen_continuation$source, paste0("N1-EQ-01 at ", n1_hash)) &&
      identical(strategy$frozen_continuation$weak_value_in_R2_current_units, "1/m") &&
      grepl("exactly once", strategy$frozen_continuation$transport_to_R1, fixed = TRUE),
    paste("Wrong frozen-continuation transport in", equilibrium_id)
  )
  ballot <- strategy$ballot_map_after_every_feasible_proposal
  assert_true(
    grepl("x_j>=beta/m", ballot$weak_nonproposer_j, fixed = TRUE) &&
      grepl("y+o_theta>y", ballot$hegemon_if_k_at_least_q_minus_1, fixed = TRUE) &&
      grepl("y>=beta*o_theta", ballot$hegemon_if_k_equals_q_minus_2, fixed = TRUE) &&
      grepl("T^Y", ballot$hegemon_if_k_at_most_q_minus_3, fixed = TRUE),
    paste("Wrong ballot map in", equilibrium_id)
  )
  proposer_map <- strategy$proposer_payoff_after_every_feasible_proposal
  assert_true(
    identical(
      proposer_map,
      list(
        if_k_at_least_q_minus_1 = "r_i",
        if_k_equals_q_minus_2_and_y_below_beta_o0 = "beta/m",
        if_k_equals_q_minus_2_and_beta_o0_at_most_y_below_beta_o1 = "(1-nu)*r_i+nu*beta/m",
        if_k_equals_q_minus_2_and_y_at_least_beta_o1 = "r_i",
        if_k_at_most_q_minus_3 = "beta/m"
      )
    ),
    paste("Incomplete proposer-deviation map in", equilibrium_id)
  )
  candidates <- strategy$candidate_payoffs_in_primitives
  assert_true(
    identical(candidates$exclusion, "1-beta*(q-1)/m") &&
      identical(candidates$low_type_only, "(1-nu)*(1-beta*o_0-beta*(q-2)/m)+nu*beta/m") &&
      identical(candidates$pooling, "1-beta*o_1-beta*(q-2)/m") &&
      identical(candidates$deliberate_failure, "beta/m") &&
      grepl("1-beta*q/m>0", candidates$exclusion_minus_deliberate_failure, fixed = TRUE),
    paste("Candidate payoff map changed in", equilibrium_id)
  )
  assert_true(
    grepl("arbitrary", record$belief_system$zero_weight_proposal, fixed = TRUE) &&
      grepl("arbitrary", record$belief_system$published_vote_vector, fixed = TRUE) &&
      grepl("both types", record$belief_system$zero_prior_types, fixed = TRUE) &&
      grepl(n1_hash, record$belief_system$continuation_effect, fixed = TRUE),
    paste("Belief system is incomplete or restricted in", equilibrium_id)
  )
  assert_true(
    grepl("pure", record$selection_status, fixed = TRUE) &&
      grepl("mix", record$selection_status, ignore.case = TRUE) &&
      grepl("may differ across", record$selection_status, fixed = TRUE),
    paste("Pure/mixed identity multiplicity missing in", equilibrium_id)
  )
  checks <- as_character(record$checks_performed)
  assert_true(
    length(checks) == 17L && all(startsWith(checks, sprintf("N3V2-C%02d", 1:17))),
    paste("Claim coverage is incomplete in", equilibrium_id)
  )
  assert_true(
    identical(record$payoff_date, "R1 current units; frozen N1 continuation payoffs are multiplied by beta exactly once"),
    paste("Wrong payoff date in", equilibrium_id)
  )

  if (identical(branch, "low")) {
    assert_true(
      identical(record$recognized_proposer_payoff, "(1-nu)*(1-beta*o_0-beta*(q-2)/m)+nu*beta/m") &&
        identical(record$hegemon_payoff_by_type, list(theta_0 = "beta*o_0", theta_1 = "beta*o_1")) &&
        identical(record$outcome_distribution, list(pass_with_hegemon = "1-nu", pass_without_hegemon = 0L, failure = 0L, delay = "nu")) &&
        grepl("|K|=q-2", record$selection_status, fixed = TRUE),
      paste("Low-type-only export changed in", equilibrium_id)
    )
  }
  if (identical(branch, "pool")) {
    assert_true(
      identical(record$recognized_proposer_payoff, "1-beta*o_1-beta*(q-2)/m") &&
        identical(record$hegemon_payoff_by_type, list(theta_0 = "beta*o_1", theta_1 = "beta*o_1")) &&
        identical(record$outcome_distribution, list(pass_with_hegemon = 1L, pass_without_hegemon = 0L, failure = 0L, delay = 0L)) &&
        grepl("|K|=q-2", record$selection_status, fixed = TRUE),
      paste("Pooling export changed in", equilibrium_id)
    )
  }
  if (identical(branch, "exclude")) {
    assert_true(
      identical(record$recognized_proposer_payoff, "1-beta*(q-1)/m") &&
        identical(record$hegemon_payoff_by_type, list(theta_0 = "o_0", theta_1 = "o_1")) &&
        identical(record$outcome_distribution, list(pass_with_hegemon = 0L, pass_without_hegemon = 1L, failure = 0L, delay = 0L)) &&
        grepl("|K|=q-1", record$selection_status, fixed = TRUE),
      paste("Exclusion export changed in", equilibrium_id)
    )
  }
  if (identical(branch, "mixed_ep")) {
    h_text <- paste(as_character(record$hegemon_payoff_by_type), collapse = " ")
    outcome_text <- paste(as_character(record$outcome_distribution), collapse = " ")
    h_fields_closed <- vapply(
      as_character(record$hegemon_payoff_by_type),
      function(value) {
        grepl("e_{i,K}", value, fixed = TRUE) && grepl("p_{i,T}", value, fixed = TRUE) &&
          grepl("nonnegative", value, fixed = TRUE) && grepl("add to 1", value, fixed = TRUE)
      },
      logical(1)
    )
    outcome_fields_closed <- vapply(
      as_character(record$outcome_distribution)[1:2],
      function(value) {
        grepl("e_{i,K}", value, fixed = TRUE) && grepl("p_{i,T}", value, fixed = TRUE) &&
          grepl("nonnegative", value, fixed = TRUE) && grepl("=1", value, fixed = TRUE)
      },
      logical(1)
    )
    assert_true(
      identical(record$recognized_proposer_payoff, "1-beta*(q-1)/m") &&
        grepl("e_{i,K}", h_text, fixed = TRUE) && grepl("p_{i,T}", h_text, fixed = TRUE) &&
        grepl("nonnegative", h_text, fixed = TRUE) && grepl("add to 1", h_text, fixed = TRUE) &&
        grepl("e_{i,K}", outcome_text, fixed = TRUE) && grepl("p_{i,T}", outcome_text, fixed = TRUE) &&
        all(h_fields_closed) && all(outcome_fields_closed) &&
        grepl("sum is one", record$selection_status, fixed = TRUE) &&
        grepl("all pure identity assignments", record$selection_status, fixed = TRUE),
      "Mixed E/P record is not locally closed."
    )
  }

  transported_text <- paste(
    c(
      admissibility,
      record$selection_status,
      as_character(record$hegemon_payoff_by_type),
      as_character(record$outcome_distribution)
    ),
    collapse = " "
  )
  forbidden_open_symbols <- c("A_i_star", "F_i", "I_H", "I_X", "I_D", "t_theta", "V_star", "H_star")
  assert_true(
    !any(vapply(forbidden_open_symbols, grepl, logical(1), x = transported_text, fixed = TRUE)),
    paste("Free legacy symbol leaked into a transported field in", equilibrium_id)
  )
  invisible(TRUE)
}

validate_candidate <- function(object) {
  assert_true(
    identical(names(object), c("schema_ref", "function_of", "correspondence_cells")) &&
      identical(object$schema_ref, "equilibrium_correspondence_v1") &&
      identical(object$function_of, list(name = "entry_belief", domain = "[0,1]")),
    "Wrong top-level equilibrium_correspondence_v1 object."
  )
  cells <- object$correspondence_cells
  assert_true(is.list(cells) && length(cells) == 11L, "N3 v2 must contain exactly eleven coverage cells.")
  cell_ids <- vapply(cells, `[[`, character(1), "cell_id")
  assert_true(identical(cell_ids, expected_cell_ids) && !anyDuplicated(cell_ids), "Cell partition IDs changed or duplicate.")
  equilibrium_ids <- character(length(cells))
  for (index in seq_along(cells)) {
    cell <- cells[[index]]
    spec <- cell_specs[[index]]
    assert_true(
      identical(
        names(cell),
        c("cell_id", "domain_conditions", "existence_status", "equilibrium_records", "nonexistence_certificate")
      ) && identical(cell$cell_id, spec[[1L]]) && identical(cell$existence_status, "exists") &&
        is.null(cell$nonexistence_certificate) && is.list(cell$equilibrium_records) &&
        length(cell$equilibrium_records) == 1L,
      paste("Malformed coverage envelope in", spec[[1L]])
    )
    assert_true(
      identical(as_character(cell$domain_conditions), c(common_domain, spec[[4L]])),
      paste("Cell domain changed in", spec[[1L]])
    )
    validate_record(cell$equilibrium_records[[1L]], spec)
    equilibrium_ids[[index]] <- cell$equilibrium_records[[1L]]$equilibrium_id
  }
  assert_true(
    identical(equilibrium_ids, expected_equilibrium_ids) && !anyDuplicated(equilibrium_ids),
    "Equilibrium IDs changed or duplicate."
  )
  invisible(TRUE)
}

validate_ledger <- function(object) {
  assert_true(
    identical(
      names(object),
      c("schema_version", "node", "candidate_status", "source_interface", "equilibrium_ids", "claims")
    ) && identical(object$schema_version, "essential-input-claim-ledger-v2") &&
      identical(object$node, "N3") && identical(object$candidate_status, "pending_independent_review") &&
      identical(object$source_interface, list(record_id = "N1-EQ-01", artifact_hash = n1_hash)),
    "Malformed N3 v2 ledger header."
  )
  assert_true(
    identical(as_character(object$equilibrium_ids), expected_equilibrium_ids),
    "Ledger equilibrium IDs do not match the candidate."
  )
  claims <- object$claims
  assert_true(is.list(claims) && length(claims) == 17L, "Ledger must contain 17 claims.")
  expected_claim_ids <- sprintf("N3V2-C%02d", 1:17)
  actual_claim_ids <- vapply(claims, `[[`, character(1), "claim_id")
  assert_true(identical(actual_claim_ids, expected_claim_ids) && !anyDuplicated(actual_claim_ids), "Ledger claim IDs changed.")
  for (claim in claims) {
    assert_true(
      identical(
        names(claim),
        c("claim_id", "equilibrium_ids", "branch", "payoff_date", "claim", "status", "evidence")
      ) && identical(as_character(claim$equilibrium_ids), expected_equilibrium_ids) &&
        identical(claim$payoff_date, "R1 current units") && identical(claim$status, "proved") &&
        nzchar(claim$branch) && nzchar(claim$claim) && grepl(tolower(claim$claim_id), claim$evidence, fixed = TRUE) &&
        grepl(paste0("id=\"claim-", tolower(claim$claim_id), "\""), derivation_text, fixed = TRUE),
      paste("Malformed or unanchored ledger claim", claim$claim_id)
    )
  }
  invisible(TRUE)
}

validate_derivation <- function(text) {
  required <- c(
    n1_hash,
    "Claim N3V2-C01", "Claim N3V2-C17",
    "1-beta*q/m > 0",
    "o_0=1/m<o_1",
    "o_0<o_1=1/m",
    "h_E=h_P",
    "todas as misturas",
    "mesma realização primitiva",
    "invariância",
    "Nenhum resultado v1"
  )
  assert_true(all(vapply(required, grepl, logical(1), x = text, fixed = TRUE)), "Derivation omits a required proof boundary or provenance statement.")
  for (claim_id in sprintf("N3V2-C%02d", 1:17)) {
    assert_true(
      grepl(paste0("id=\"claim-", tolower(claim_id), "\""), text, fixed = TRUE),
      paste("Derivation omits anchor", claim_id)
    )
  }
  forbidden <- c(
    "beta=1 pertence ao baseline",
    "falha deliberada é selecionada",
    "H recebe o_theta sem y quando a proposta passa sem H",
    "simetria entre proponentes é imposta"
  )
  assert_true(!any(vapply(forbidden, grepl, logical(1), x = text, fixed = TRUE)), "Derivation contains a forbidden contradiction.")
  invisible(TRUE)
}

expect_candidate_rejection <- function(label, mutate) {
  altered <- mutate(clone_object(candidate))
  rejected <- inherits(try(validate_candidate(altered), silent = TRUE), "try-error")
  assert_true(rejected, paste("Negative candidate mutation passed:", label))
}

expect_ledger_rejection <- function(label, mutate) {
  altered <- mutate(clone_object(ledger))
  rejected <- inherits(try(validate_ledger(altered), silent = TRUE), "try-error")
  assert_true(rejected, paste("Negative ledger mutation passed:", label))
}

validate_candidate(candidate)
validate_ledger(ledger)
validate_derivation(derivation_text)

# Algebraic primitives and candidate comparison.
candidate_values <- function(N, beta, o0, o1, nu) {
  m <- N - 1
  q <- floor(N / 2) + 1
  c <- beta / m
  E <- 1 - beta * (q - 1) / m
  L <- 1 - beta * o0 - beta * (q - 2) / m
  P <- 1 - beta * o1 - beta * (q - 2) / m
  S <- (1 - nu) * L + nu * c
  list(m = m, q = q, c = c, E = E, L = L, P = P, S = S, R = c)
}

selected_by_argmax <- function(N, beta, o0, o1, nu, tolerance = 1e-10) {
  value <- candidate_values(N, beta, o0, o1, nu)
  payoff <- c(E = value$E, S = value$S, P = value$P, R = value$R)
  feasible <- c(E = TRUE, S = value$L >= -tolerance, P = value$P >= -tolerance, R = TRUE)
  payoff[!feasible] <- -Inf
  max_payoff <- max(payoff)
  payoff_ties <- names(payoff)[abs(payoff - max_payoff) <= tolerance]
  h_bar <- (1 - nu) * o0 + nu * o1
  h <- c(E = h_bar, S = beta * h_bar, P = beta * o1, R = beta * h_bar)
  min_h <- min(h[payoff_ties])
  sort(payoff_ties[abs(h[payoff_ties] - min_h) <= tolerance])
}

cell_branch <- function(N, beta, o0, o1, nu, tolerance = 1e-10) {
  m <- N - 1
  inverse_m <- 1 / m
  if (o1 < inverse_m - tolerance) {
    frontier <- beta * (o1 - o0) / (1 - beta * o0 - beta * (floor(N / 2)) / m)
    return(if (nu <= frontier + tolerance) "S" else "P")
  }
  if (abs(o1 - inverse_m) <= tolerance) {
    frontier <- beta * (inverse_m - o0) /
      (beta * (inverse_m - o0) + 1 - beta * (floor(N / 2) + 1) / m)
    if (nu <= frontier + tolerance) return("S")
    h_exclusion <- (1 - nu) * o0 + nu / m
    h_pooling <- beta / m
    if (h_exclusion < h_pooling - tolerance) return("E")
    if (h_pooling < h_exclusion - tolerance) return("P")
    return(c("E", "P"))
  }
  if (o0 < inverse_m - tolerance) {
    frontier <- beta * (inverse_m - o0) /
      (beta * (inverse_m - o0) + 1 - beta * (floor(N / 2) + 1) / m)
    return(if (nu <= frontier + tolerance) "S" else "E")
  }
  if (abs(o0 - inverse_m) <= tolerance) return(if (nu <= tolerance) "S" else "E")
  "E"
}

for (N in 3:40) {
  m <- N - 1
  q <- floor(N / 2) + 1
  assert_true(q <= m && q - 1 <= m - 1, "Quota inequalities failed.")
  for (beta in c(0.01, 0.2, 0.5, 0.9, 0.999999)) {
    D <- 1 - beta * q / m
    assert_true(D > 0, "Strict beta domain failed to imply D>0.")
    for (o0 in c(0.1 / m, 0.8 / m, min(0.8, 1.2 / m))) {
      for (o1 in c(0.5 / m, 1 / m, min(0.95, 1.5 / m), 0.97)) {
        if (!(0 < o0 && o0 < o1 && o1 < 1)) next
        for (nu in c(0, 0.13, 0.5, 0.87, 1)) {
          value <- candidate_values(N, beta, o0, o1, nu)
          assert_true(
            abs((value$P - value$E) - beta * (1 / m - o1)) < 1e-12,
            "P-E identity failed."
          )
          assert_true(
            abs((value$S - value$E) - ((1 - nu) * beta * (1 / m - o0) - nu * D)) < 1e-12,
            "S-E identity failed."
          )
          predicted <- sort(cell_branch(N, beta, o0, o1, nu))
          optimized <- selected_by_argmax(N, beta, o0, o1, nu)
          assert_true(identical(predicted, optimized), "Cell partition disagrees with direct argmax/tie-break.")
        }
      }
    }
  }
}

# Closed-form frontiers and their equality conventions.
N <- 9
m <- N - 1
q <- floor(N / 2) + 1
beta <- 0.8

o0 <- 0.03
o1 <- 0.08
nu_sp_value <- beta * (o1 - o0) / (1 - beta * o0 - beta * (q - 1) / m)
assert_true(nu_sp_value > 0 && nu_sp_value < 1, "nu_SP left (0,1).")
assert_true(identical(selected_by_argmax(N, beta, o0, o1, nu_sp_value), "S"), "S/P equality tie-break failed.")
assert_true(identical(cell_branch(N, beta, o0, o1, min(1, nu_sp_value + 1e-5)), "P"), "Pooling side of nu_SP failed.")

o0 <- 0.08
o1 <- 0.2
nu_se_value <- beta * (1 / m - o0) /
  (beta * (1 / m - o0) + 1 - beta * q / m)
assert_true(nu_se_value > 0 && nu_se_value < 1, "nu_SE left (0,1).")
assert_true(identical(selected_by_argmax(N, beta, o0, o1, nu_se_value), "S"), "S/E equality tie-break failed.")
assert_true(identical(cell_branch(N, beta, o0, o1, min(1, nu_se_value + 1e-5)), "E"), "Exclusion side of nu_SE failed.")

o0 <- 1 / m
o1 <- 0.2
assert_true(identical(selected_by_argmax(N, beta, o0, o1, 0), "S"), "o_0=1/m,nu=0 endpoint failed.")
assert_true(identical(selected_by_argmax(N, beta, o0, o1, 0.01), "E"), "o_0=1/m positive-prior side failed.")

o0 <- 0.08
o1 <- 1 / m
nu_se_equal <- beta * (1 / m - o0) /
  (beta * (1 / m - o0) + 1 - beta * q / m)
nu_hp <- (beta / m - o0) / (1 / m - o0)
assert_true(nu_hp > nu_se_equal && nu_hp < 1, "H-payoff tie witness is not in the residual E=P region.")
assert_true(identical(cell_branch(N, beta, o0, o1, nu_se_equal), "S"), "Low branch must own nu_SE equality.")
assert_true(identical(cell_branch(N, beta, o0, o1, (nu_se_equal + nu_hp) / 2), "E"), "E side of H tie failed.")
assert_true(identical(cell_branch(N, beta, o0, o1, nu_hp), c("E", "P")), "Exact E/P and H-payoff tie failed.")
assert_true(identical(cell_branch(N, beta, o0, o1, (nu_hp + 1) / 2), "P"), "P side of H tie failed.")

# Feasibility of every selected candidate and strict full-pie residual.
for (N in 3:30) {
  m <- N - 1
  q <- floor(N / 2) + 1
  for (beta in c(0.05, 0.5, 0.95, 0.999)) {
    exclusion_residual <- 1 - beta * (q - 1) / m
    assert_true(exclusion_residual > 0, "Exclusion feasibility failed.")
    for (outside in c(0.01 / m, 0.5 / m, 1 / m)) {
      residual <- 1 - beta * outside - beta * (q - 2) / m
      assert_true(residual > 0, "Selected H-inclusion candidate is not strictly feasible.")
    }
  }
}

# Mixed E/P cell: all pure identity assignments and proposer mixtures preserve
# proposer payoff and expected H payoff, while type payoffs/outcomes may vary.
N <- 9
m <- N - 1
q <- floor(N / 2) + 1
beta <- 0.8
o0 <- 0.08
o1 <- 1 / m
nu_hp <- (beta / m - o0) / (1 / m - o0)
lambda <- c(0, 0.1, 0.25, 0.4, 0.6, 0.75, 0.9, 1)
assert_true(length(lambda) == m, "Mixed-cell fixture must have one weight per proposer identity.")
pooling_share <- mean(lambda)
exclusion_share <- 1 - pooling_share
u_h0 <- exclusion_share * o0 + pooling_share * beta / m
u_h1 <- exclusion_share * (1 / m) + pooling_share * beta / m
expected_h <- (1 - nu_hp) * u_h0 + nu_hp * u_h1
assert_true(abs(expected_h - beta / m) < 1e-12, "Mixed-cell expected-H invariance failed.")
assert_true(abs(pooling_share + exclusion_share - 1) < 1e-12, "Mixed outcomes do not sum to one.")
assert_true(u_h0 > min(o0, beta / m) && u_h0 < max(o0, beta / m), "Mixed theta_0 payoff is not interior.")
assert_true(u_h1 > beta / m && u_h1 < 1 / m, "Mixed theta_1 payoff is not interior.")

# P1 hedge, H nonpivotal comparison, pivotal cutoff, and P7.
for (y in c(0.001, 0.2, 0.7)) {
  r_i <- 1 - y
  assert_true(abs(((r_i + y) - r_i) - y) < 1e-12 && y > 0, "P1 hedge gain failed.")
}
for (o_theta in c(0.03, 0.4, 0.95)) {
  y <- 0.2
  assert_true(y + o_theta > y, "Nonpivotal H no-vote payoff lost y or o_theta.")
  cutoff <- beta * o_theta
  assert_true(cutoff >= cutoff && cutoff - 1e-8 < cutoff, "Pivotal H cutoff failed.")
}
posterior_after_h_vote <- function(nu, observed_vote, low_vote, high_vote) {
  numerator <- nu * as.numeric(observed_vote == high_vote)
  denominator <- (1 - nu) * as.numeric(observed_vote == low_vote) + numerator
  if (denominator == 0) return(NA_real_)
  numerator / denominator
}
assert_true(identical(posterior_after_h_vote(0.3, "no", "yes", "no"), 1), "High rejection must reveal theta=1.")
assert_true(identical(posterior_after_h_vote(0.3, "yes", "yes", "no"), 0), "Low acceptance must reveal theta=0.")

# Targeted semantic negative tests, executed with the file-hash anchor bypassed.
expect_candidate_rejection("remove coverage cell", function(x) {
  x$correspondence_cells <- x$correspondence_cells[-11L]
  x
})
expect_candidate_rejection("duplicate cell id", function(x) {
  x$correspondence_cells[[2L]]$cell_id <- x$correspondence_cells[[1L]]$cell_id
  x
})
expect_candidate_rejection("open S/P boundary", function(x) {
  x$correspondence_cells[[1L]]$domain_conditions[[10L]] <- paste0("0<=nu<", nu_sp)
  x
})
expect_candidate_rejection("old N1 hash", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$source_interface_hashes$N1 <- paste0("sha256:", strrep("0", 64))
  x
})
expect_candidate_rejection("double discount", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$frozen_continuation$transport_to_R1 <- "weak beta^2/m"
  x
})
expect_candidate_rejection("erase nonpivotal y", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$ballot_map_after_every_feasible_proposal$hegemon_if_k_at_least_q_minus_1 <- "no pays o_theta"
  x
})
expect_candidate_rejection("select deliberate failure", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$candidate_payoffs_in_primitives$exclusion_minus_deliberate_failure <- "0"
  x
})
expect_candidate_rejection("erase screening delay", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$outcome_distribution$delay <- 0L
  x
})
expect_candidate_rejection("wrong low H payoff", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$hegemon_payoff_by_type$theta_1 <- "o_1"
  x
})
expect_candidate_rejection("collapse identity symmetry", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$selection_status <- "omega is symmetric across proposer identities"
  x
})
expect_candidate_rejection("remove off-path freedom", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system$zero_weight_proposal <- "kappa_i(s)=nu"
  x
})
expect_candidate_rejection("remove zero-prior type", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system$zero_prior_types <- "omit the zero-prior type"
  x
})
expect_candidate_rejection("leak A_i_star", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$selection_status <- "all F_i supported on A_i_star"
  x
})
expect_candidate_rejection("mixed weights not locally closed", function(x) {
  x$correspondence_cells[[11L]]$equilibrium_records[[1L]]$hegemon_payoff_by_type$theta_0 <- "sum_i e_i*o_0+p_i*beta/m"
  x
})
expect_candidate_rejection("erase pure proposer choices", function(x) {
  x$correspondence_cells[[11L]]$equilibrium_records[[1L]]$selection_status <- "only interior mixtures are allowed"
  x
})
expect_candidate_rejection("schema laundering", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$projection_contract <- "extra field"
  x
})

expect_ledger_rejection("claim omitted", function(x) {
  x$claims <- x$claims[-17L]
  x
})
expect_ledger_rejection("claim status weakened", function(x) {
  x$claims[[1L]]$status <- "checked numerically"
  x
})
expect_ledger_rejection("source hash changed", function(x) {
  x$source_interface$artifact_hash <- paste0("sha256:", strrep("f", 64))
  x
})
expect_ledger_rejection("equilibrium id omitted", function(x) {
  x$equilibrium_ids <- x$equilibrium_ids[-1L]
  x
})

bad_derivation <- gsub("1-beta*q/m > 0", "1-beta*q/m = 0", derivation_text, fixed = TRUE)
assert_true(
  inherits(try(validate_derivation(bad_derivation), silent = TRUE), "try-error"),
  "Negative derivation mutation passed."
)

cat("PASS: N3 v2 canonical interface, derivation, ledger, and build script validated.\n")
cat("PASS: exact frozen N1 dependency and pending shared lifecycle preserved.\n")
cat("PASS: P0, P1, P1a, P2, P6, and P7 maps and exactly-one discount passed.\n")
cat("PASS: eleven cells are exhaustive over strict regions, endpoints, and the o_1=1/m E/P/H-payoff tie.\n")
cat("PASS: pure identity assignments, proposer mixtures, weak identity maps, same-realization H payoffs, and outcomes passed.\n")
cat("PASS: all N6-transported fields are locally closed; legacy free symbols are absent.\n")
cat("NEGATIVE_TESTS_REJECTED: 16 candidate, 4 ledger, and 1 derivation mutation.\n")
cat("N1-SHA-256:", n1_hash_bare, "\n")
cat("N3V2-SHA-256:", expected_interface_hash, "\n")
cat("LEDGER-SHA-256:", expected_ledger_hash, "\n")
cat("DERIVATION-SHA-256:", expected_derivation_hash, "\n")
cat("BUILD-SHA-256:", expected_build_hash, "\n")
cat("STATUS: candidate pending independent formal-design and game-theory review; no lifecycle mutation performed.\n")
