#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_root_status <- attr(git_root, "status")
if (is.null(git_root_status)) git_root_status <- 0L
if (!length(git_root) || git_root_status != 0L) stop("Could not resolve the Git root.")
repo_root <- normalizePath(git_root[[1]], mustWork = TRUE)
setwd(repo_root)

required_files <- c(
  "model_redesign/pivotal_response_rederivation.Rmd",
  "model_redesign/pivotal_response_game_dag.json",
  "model_redesign/pivotal_response_interfaces/gate0_contract_v1.json",
  "model_redesign/pivotal_response_interfaces/gate0_bundle_v1.json",
  "model_redesign/pivotal_response_interfaces/gate0_review_v1.json",
  "tables/pivotal_response_gate0_transitions_v1.csv",
  "tables/pivotal_response_information_sets_v1.csv",
  "tables/pivotal_response_sufficient_states_v1.csv",
  "tables/pivotal_response_relevance_registry_v1.csv",
  "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv",
  "quality_reports/2026-08-11_pivotal_response_proof_ledger.tsv",
  "quality_reports/2026-08-11_pivotal_response_gate0_status.md",
  "quality_reports/2026-08-11_pivotal_response_gate0_independent_review.md"
)
missing_files <- required_files[!file.exists(required_files)]
if (length(missing_files)) stop("Missing Gate 0 artifacts: ", paste(missing_files, collapse = ", "))
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

checks <- data.frame(check_id = character(), status = character(), detail = character())
add_check <- function(check_id, condition, detail_pass, detail_fail = detail_pass) {
  ok <- isTRUE(condition)
  checks <<- rbind(
    checks,
    data.frame(
      check_id = check_id,
      status = if (ok) "PASS" else "FAIL",
      detail = if (ok) detail_pass else detail_fail
    )
  )
  invisible(ok)
}

sha256_file <- function(path) {
  out <- suppressWarnings(system2("shasum", c("-a", "256", path), stdout = TRUE, stderr = FALSE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  if (!length(out) || status != 0L) return(NA_character_)
  strsplit(trimws(out[[1]]), "[[:space:]]+")[[1]][[1]]
}

read_csv <- function(path) {
  utils::read.csv(path, check.names = FALSE, na.strings = character(), quote = "\"")
}

contract_path <- "model_redesign/pivotal_response_interfaces/gate0_contract_v1.json"
bundle_path <- "model_redesign/pivotal_response_interfaces/gate0_bundle_v1.json"
review_path <- "model_redesign/pivotal_response_interfaces/gate0_review_v1.json"
dag_path <- "model_redesign/pivotal_response_game_dag.json"
contract <- jsonlite::fromJSON(contract_path, simplifyVector = FALSE)
bundle <- jsonlite::fromJSON(bundle_path, simplifyVector = FALSE)
review <- jsonlite::fromJSON(review_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
transitions <- read_csv("tables/pivotal_response_gate0_transitions_v1.csv")
information_sets <- read_csv("tables/pivotal_response_information_sets_v1.csv")
sufficient_states <- read_csv("tables/pivotal_response_sufficient_states_v1.csv")
relevance <- read_csv("tables/pivotal_response_relevance_registry_v1.csv")
protected <- utils::read.delim(
  "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv",
  check.names = FALSE, quote = "", comment.char = ""
)
ledger <- utils::read.delim(
  "quality_reports/2026-08-11_pivotal_response_proof_ledger.tsv",
  check.names = FALSE, quote = "", comment.char = ""
)
rmd_text <- paste(readLines("model_redesign/pivotal_response_rederivation.Rmd", warn = FALSE), collapse = "\n")
status_text <- paste(readLines("quality_reports/2026-08-11_pivotal_response_gate0_status.md", warn = FALSE), collapse = "\n")
review_text <- paste(readLines("quality_reports/2026-08-11_pivotal_response_gate0_independent_review.md", warn = FALSE), collapse = "\n")

current_head <- system2("git", c("rev-parse", "HEAD"), stdout = TRUE)[[1]]
current_branch <- system2("git", c("branch", "--show-current"), stdout = TRUE)[[1]]
add_check("provenance_git_root", identical(repo_root, contract$provenance$git_root),
          paste("Git root:", repo_root), "Git root differs from the frozen contract.")
add_check("provenance_branch", identical(current_branch, contract$provenance$branch_at_start),
          paste("Branch remains", current_branch), paste("Branch changed to", current_branch))
add_check("provenance_head", identical(current_head, contract$provenance$head_at_start),
          paste("HEAD remains", current_head), "HEAD differs from the Gate 0 start.")

manifest_columns <- c("path", "sha256", "category", "frozen_at_head")
add_check("protected_manifest_schema", identical(names(protected), manifest_columns) && nrow(protected) == 27L,
          "Protected manifest has the required schema and 27 rows.",
          "Protected manifest schema or row count differs.")
protected_exists <- file.exists(protected$path)
add_check("protected_files_exist", all(protected_exists), "Every protected artifact exists.",
          paste("Missing:", paste(protected$path[!protected_exists], collapse = ", ")))
actual_protected_hashes <- vapply(protected$path, sha256_file, character(1))
protected_match <- !is.na(actual_protected_hashes) & actual_protected_hashes == protected$sha256
add_check("protected_hashes_unchanged", all(protected_match),
          "All 27 protected SHA-256 values match the initial manifest.",
          paste("Hash mismatch:", paste(protected$path[!protected_match], collapse = ", ")))

expected_bundle_roles <- c(
  "extensive_form_contract",
  "exhaustive_transition_registry",
  "information_set_registry",
  "sufficient_state_registry",
  "vote_relevance_registry"
)
bundle_roles <- vapply(bundle$components, function(x) x$role, character(1))
add_check("bundle_component_inventory",
          setequal(bundle_roles, expected_bundle_roles) && !anyDuplicated(bundle_roles),
          "Bundle contains the contract and four authoritative registries exactly once.",
          paste("Bundle roles:", paste(bundle_roles, collapse = ", ")))
bundle_dir <- dirname(normalizePath(bundle_path, mustWork = TRUE))
component_paths <- vapply(bundle$components, function(x) {
  normalizePath(file.path(bundle_dir, x$path), mustWork = TRUE)
}, character(1))
expected_component_paths <- normalizePath(c(
  contract_path,
  "tables/pivotal_response_gate0_transitions_v1.csv",
  "tables/pivotal_response_information_sets_v1.csv",
  "tables/pivotal_response_sufficient_states_v1.csv",
  "tables/pivotal_response_relevance_registry_v1.csv"
), mustWork = TRUE)
add_check("bundle_dependency_complete", setequal(component_paths, expected_component_paths),
          "Bundle resolves to every authoritative Gate 0 component.",
          paste("Resolved components:", paste(component_paths, collapse = ", ")))
declared_component_hashes <- vapply(bundle$components, function(x) x$sha256, character(1))
actual_component_hashes <- vapply(component_paths, sha256_file, character(1))
add_check("bundle_component_hashes", identical(unname(actual_component_hashes), declared_component_hashes),
          "Every bundle component hash matches its exact bytes.",
          paste("Mismatch:", paste(bundle_roles[actual_component_hashes != declared_component_hashes], collapse = ", ")))
bundle_hash <- paste0("sha256:", sha256_file(bundle_path))
review_hash <- paste0("sha256:", sha256_file(review_path))
contract_hash <- sha256_file(contract_path)
contract_component <- bundle$components[[which(bundle_roles == "extensive_form_contract")]]
add_check("bundle_contract_hash", identical(contract_component$sha256, contract_hash),
          paste("Contract component hash matches:", contract_hash),
          paste("Contract computes to", contract_hash))
add_check("reviewed_bundle_immutable",
          identical(bundle_hash, "sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1") &&
            identical(review$reviewed_bundle$sha256, sub("^sha256:", "", bundle_hash)) &&
            identical(review$reviewed_bundle$path, "gate0_bundle_v1.json"),
          paste("Closed review still targets exact bundle", bundle_hash),
          "The reviewed bundle hash or path changed.")

round1_review <- review$review_rounds[[1]]
round2_review <- review$review_rounds[[2]]
round2_results <- round2_review$reviews
zero_findings <- all(vapply(round2_results, function(x) {
  identical(x$verdict, "pass") &&
    identical(as.integer(x$critical_findings), 0L) &&
    identical(as.integer(x$major_findings), 0L) &&
    identical(as.integer(x$minor_findings), 0L)
}, logical(1)))
add_check("independent_review_verdicts",
          identical(review$status, "pass") &&
            identical(round1_review$verdict, "repair") &&
            identical(round1_review$sha256, "37bd422df0bafd7c93162198594c49fd3114d304750d282318d7a705348bc9bb") &&
            length(round2_results) == 2L && zero_findings,
          "Round 1 is REPAIR and both independent rereviews are PASS with zero findings.",
          "Independent review history or findings do not match the close record.")
event_orders <- vapply(review$execution_events, function(x) as.integer(x$order), integer(1))
event_names <- vapply(review$execution_events, function(x) x$event, character(1))
expected_events <- c(
  "gate0_start",
  "initial_implementation_complete",
  "review_round_1_start",
  "review_round_1_repair",
  "repair_implementation_start",
  "repaired_implementation_complete",
  "independent_rereview_start",
  "formal_review_pass",
  "adversarial_review_pass",
  "gate0_close"
)
add_check("gate0_execution_events",
          identical(event_orders, 1:10) && identical(event_names, expected_events),
          "Gate 0 execution events 1--10 are complete and ordered.",
          "Gate 0 execution event chronology differs.")

node_ids <- vapply(dag$nodes, function(node) node$id, character(1))
node_by_id <- stats::setNames(dag$nodes, node_ids)
gate0_node <- node_by_id[["gate0_contract"]]
add_check("gate0_bundle_hash",
          identical(gate0_node$artifact_path, "pivotal_response_interfaces/gate0_bundle_v1.json") &&
            identical(gate0_node$artifact_hash, bundle_hash),
          paste("Gate 0 node freezes dependency-complete bundle", bundle_hash),
          paste("Computed bundle", bundle_hash, "but DAG records", gate0_node$artifact_hash))
add_check("gate0_independent_review_close",
          identical(contract$status, "candidate_pending_independent_review") &&
            identical(bundle$status, "candidate_pending_independent_review") &&
            identical(gate0_node$status, "pass") &&
            identical(as.integer(gate0_node$started_order), 1L) &&
            identical(as.integer(gate0_node$passed_order), 10L) &&
            identical(gate0_node$review_path, "pivotal_response_interfaces/gate0_review_v1.json") &&
            identical(gate0_node$review_hash, review_hash),
          "Gate 0 PASS is supported by the hashed independent-review interface at event 10.",
          "Gate 0 close fields or review hash are inconsistent.")

expected_node_ids <- c(
  "gate0_contract",
  "r2_unanimity_active_h",
  "r2_majority_active_h",
  "r2_majority_weak_only",
  "r2_batch_review",
  "r1_unanimity",
  "r1_majority",
  "r1_batch_frozen",
  "entry_unanimity",
  "entry_majority",
  "institutional_comparison",
  "v6_survival_matrix"
)
add_check("dag_node_inventory", setequal(node_ids, expected_node_ids) && !anyDuplicated(node_ids),
          "DAG contains Gate 0, both batch gates, and all ten substantive descendants.",
          paste("Unexpected DAG inventory:", paste(node_ids, collapse = ", ")))
downstream_nodes <- dag$nodes[node_ids != "gate0_contract"]
r2_ids <- c("r2_unanimity_active_h", "r2_majority_active_h", "r2_majority_weak_only")
r2_nodes <- dag$nodes[node_ids %in% r2_ids]
later_nodes <- dag$nodes[!node_ids %in% c("gate0_contract", r2_ids)]
add_check("dag_r2_authorized_not_started",
          all(vapply(r2_nodes, function(x) identical(x$status, "pending"), logical(1))) &&
            all(vapply(r2_nodes, function(x) identical(x$authorized, TRUE), logical(1))) &&
            all(vapply(r2_nodes, function(x) is.null(x$started_order) && is.null(x$passed_order), logical(1))),
          "All three R2 nodes are authorized, pending, and unstarted.",
          "An R2 node is unauthorized, started, or no longer pending.")
add_check("dag_later_nodes_blocked",
          all(vapply(later_nodes, function(x) identical(x$status, "pending"), logical(1))) &&
            all(vapply(later_nodes, function(x) identical(x$authorized, FALSE), logical(1))) &&
            all(vapply(later_nodes, function(x) is.null(x$started_order) && is.null(x$passed_order), logical(1))),
          "Every post-R2 node remains pending, unauthorized, and unstarted.",
          "A post-R2 node was prematurely authorized or started.")
expected_dependencies <- list(
  gate0_contract = character(),
  r2_unanimity_active_h = "gate0_contract",
  r2_majority_active_h = "gate0_contract",
  r2_majority_weak_only = "gate0_contract",
  r2_batch_review = c("r2_unanimity_active_h", "r2_majority_active_h", "r2_majority_weak_only"),
  r1_unanimity = c("r2_batch_review", "r2_unanimity_active_h"),
  r1_majority = c("r2_batch_review", "r2_majority_active_h", "r2_majority_weak_only"),
  r1_batch_frozen = c("r1_unanimity", "r1_majority"),
  entry_unanimity = c("r1_batch_frozen", "r1_unanimity"),
  entry_majority = c("r1_batch_frozen", "r1_majority"),
  institutional_comparison = c("entry_unanimity", "entry_majority"),
  v6_survival_matrix = "institutional_comparison"
)
dependency_match <- all(vapply(names(expected_dependencies), function(id) {
  setequal(unlist(node_by_id[[id]]$depends_on), expected_dependencies[[id]])
}, logical(1)))
add_check("dag_dependencies", dependency_match,
          "DAG implements common R2 and R1 batch barriers plus local interfaces.",
          "At least one dependency differs from the frozen sequence.")
terminal_ids <- vapply(dag$terminal_outcomes, function(x) x$id, character(1))
add_check("terminal_outcome_inventory",
          all(c("terminal_quota_impossible_u_after_h_optout", "terminal_failure_after_h_optout") %in% terminal_ids) &&
            !"r2_unanimity_weak_only" %in% node_ids,
          "Opt-out failure outcomes are explicit and no artificial unanimity continuation exists.",
          "Terminal outcome inventory is incomplete or includes an artificial node.")

dag_checker <- "/Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py"
run_checker <- function(args) {
  out <- suppressWarnings(system2("python3", c(dag_checker, args), stdout = TRUE, stderr = TRUE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  list(status = as.integer(status), output = out)
}
dag_run <- run_checker(c(dag_path, "--require-execution-order"))
add_check("skill_dag_execution_order",
          dag_run$status == 0L && any(dag_run$output == "VALID") &&
            any(grepl("Ready: r2_majority_active_h, r2_majority_weak_only, r2_unanimity_active_h", dag_run$output, fixed = TRUE)),
          "Skill checker validates execution order and reports exactly the R2 antichain ready.",
          paste(dag_run$output, collapse = " | "))
r2_candidates <- run_checker(c(
  dag_path, "--candidate",
  "r2_unanimity_active_h", "r2_majority_active_h", "r2_majority_weak_only"
))
add_check("skill_r2_candidate_antichain",
          r2_candidates$status == 0L &&
            any(r2_candidates$output == "VALID") &&
            any(grepl("Ready: r2_majority_active_h, r2_majority_weak_only, r2_unanimity_active_h", r2_candidates$output, fixed = TRUE)),
          "Skill checker accepts the three authorized R2 nodes as one ready antichain.",
          paste(r2_candidates$output, collapse = " | "))
add_check("no_r2_interface_or_result",
          !any(file.exists(c(
            "model_redesign/pivotal_response_interfaces/r2_unanimity_active_h_v1.json",
            "model_redesign/pivotal_response_interfaces/r2_majority_active_h_v1.json",
            "model_redesign/pivotal_response_interfaces/r2_majority_weak_only_v1.json"
          ))),
          "No R2 interface or result exists at mechanical Gate 0 close.",
          "An R2 interface exists even though no R2 node started.")

deep_copy <- function(x) unserialize(serialize(x, NULL))
mark_pass <- function(manifest, ids) {
  for (id in ids) {
    idx <- which(vapply(manifest$nodes, function(x) x$id, character(1)) == id)
    node <- manifest$nodes[[idx]]
    deps <- unlist(node$depends_on)
    frozen <- list()
    for (dep in deps) {
      dep_idx <- which(vapply(manifest$nodes, function(x) x$id, character(1)) == dep)
      frozen[[dep]] <- manifest$nodes[[dep_idx]]$artifact_hash
    }
    node$status <- "pass"
    if (is.null(node$artifact_hash)) node$artifact_hash <- paste0("sha256:hypothetical-", id)
    node$dependency_hashes <- frozen
    node$artifact_path <- NULL
    manifest$nodes[[idx]] <- node
  }
  manifest
}
negative_barrier <- function(pass_ids, candidate) {
  hypothetical <- mark_pass(deep_copy(dag), pass_ids)
  tmp <- tempfile("pivotal_response_dag_", tmpdir = "model_redesign", fileext = ".json")
  jsonlite::write_json(hypothetical, tmp, auto_unbox = TRUE, pretty = TRUE, null = "null")
  on.exit(unlink(tmp), add = TRUE)
  run <- run_checker(c(tmp, "--candidate", candidate))
  list(
    ok = run$status != 0L &&
      any(grepl(paste0("candidate node is not ready: ", candidate), run$output, fixed = TRUE)),
    output = run$output
  )
}
barrier_u <- negative_barrier(c("gate0_contract", "r2_unanimity_active_h"), "r1_unanimity")
add_check("negative_barrier_only_r2_u", barrier_u$ok,
          "Passing only R2-U does not release R1-U.",
          paste(barrier_u$output, collapse = " | "))
barrier_m <- negative_barrier(
  c("gate0_contract", "r2_majority_active_h", "r2_majority_weak_only"),
  "r1_majority"
)
add_check("negative_barrier_only_two_r2_m", barrier_m$ok,
          "Passing only the two R2-M nodes does not release R1-M.",
          paste(barrier_m$output, collapse = " | "))
barrier_entry_u <- negative_barrier(
  c(
    "gate0_contract", "r2_unanimity_active_h", "r2_majority_active_h",
    "r2_majority_weak_only", "r2_batch_review", "r1_unanimity"
  ),
  "entry_unanimity"
)
add_check("negative_barrier_only_one_r1", barrier_entry_u$ok,
          "Passing only one R1 node does not release its entry node.",
          paste(barrier_entry_u$output, collapse = " | "))

canonical_transition_text <- paste(c(
  "transition_id,round,rule,h_status,h_vote,z_range,condition_code,current_outcome,h_included,h_optout,y_destination,h_native_payoff,weak_native_payoff,successor,terminal,discount_note",
  "PR01,R1,U,active,Y,m,r1_u_hy_pass,pass_with_H,yes,no,paid_to_H,y,current implemented weak allocation,terminal_current_agreement,yes,current R1 units",
  "PR02,R1,U,active,Y,1..m-1,r1_u_hy_fail,fail_weak_caused,no,no,not_implemented,beta times active-H R2 continuation,beta times active-H R2 continuation,r2_unanimity_active_h,no,apply beta only after the R2 interface is frozen",
  "PR03,R1,U,active,N,1..m,r1_u_hn_end,quota_impossible_after_optout,no,yes,not_implemented,o_theta,0,terminal_quota_impossible_u_after_h_optout,yes,immediate R1 optout has no beta",
  "PR04,R1,M,active,Y,q-1..m,r1_m_hy_pass,pass_with_H,yes,no,paid_to_H,y,current implemented weak allocation,terminal_current_agreement,yes,current R1 units",
  "PR05,R1,M,active,Y,1..q-2,r1_m_hy_fail,fail_weak_caused,no,no,not_implemented,beta times active-H R2 continuation,beta times active-H R2 continuation,r2_majority_active_h,no,empty range when q=2; otherwise beta enters only at R1 import",
  "PR06,R1,M,active,N,q..m,r1_m_hn_pass_weak,pass_weak_only,no,yes,reabsorbed_by_weak_proposer,o_theta,current weak-only allocation,terminal_current_weak_only_agreement,yes,immediate R1 optout has no beta",
  "PR07,R1,M,active,N,1..q-1,r1_m_hn_fail_weak,fail_then_weak_only_R2,no,yes,not_implemented,o_theta,beta times weak-only R2 continuation,r2_majority_weak_only,no,H receives o_theta once at R1; only weak continuation is discounted",
  "PR08,R2,U,active,Y,m,r2_u_hy_pass,pass_with_H,yes,no,paid_to_H,y,current implemented weak allocation,terminal_current_agreement,yes,native R2 units without beta",
  "PR09,R2,U,active,Y,1..m-1,r2_u_hy_fail,terminal_failure,no,no,not_implemented,o_theta,0,terminal_failure_active_h,yes,native R2 units without beta",
  "PR10,R2,U,active,N,1..m,r2_u_hn_end,quota_impossible_after_optout,no,yes,not_implemented,o_theta,0,terminal_quota_impossible_u_after_h_optout,yes,native R2 units without beta",
  "PR11,R2,M,active,Y,q-1..m,r2_m_hy_pass,pass_with_H,yes,no,paid_to_H,y,current implemented weak allocation,terminal_current_agreement,yes,native R2 units without beta",
  "PR12,R2,M,active,Y,1..q-2,r2_m_hy_fail,terminal_failure,no,no,not_implemented,o_theta,0,terminal_failure_active_h,yes,empty range when q=2; native R2 units without beta",
  "PR13,R2,M,active,N,q..m,r2_m_hn_pass_weak,pass_weak_only,no,yes,reabsorbed_by_weak_proposer,o_theta,current weak-only allocation,terminal_current_weak_only_agreement,yes,native R2 units without beta",
  "PR14,R2,M,active,N,1..q-1,r2_m_hn_fail,terminal_failure_after_optout,no,yes,not_implemented,o_theta,0,terminal_failure_after_h_optout,yes,native R2 units without beta",
  "PR15,R2,M,absent,NA,q..m,r2_m_wo_pass,pass_weak_only,no,already_complete,fixed_at_zero,0 current flow,current weak-only allocation,terminal_current_weak_only_agreement,yes,H outside payoff was already realized at R1",
  "PR16,R2,M,absent,NA,1..q-1,r2_m_wo_fail,terminal_failure_weak_only,no,already_complete,fixed_at_zero,0 current flow,0,terminal_failure_weak_only,yes,H outside payoff was already realized at R1"
), collapse = "\n")
canonical_transitions <- utils::read.csv(
  text = canonical_transition_text, check.names = FALSE, na.strings = character(), quote = "\""
)

seq_or_empty <- function(left, right) {
  if (left > right) integer() else seq.int(left, right)
}
parse_z_range <- function(spec, N) {
  m <- N - 1L
  q <- floor(N / 2) + 1L
  switch(
    spec,
    "m" = m,
    "1..m" = seq_or_empty(1L, m),
    "1..m-1" = seq_or_empty(1L, m - 1L),
    "q-1..m" = seq_or_empty(q - 1L, m),
    "1..q-2" = seq_or_empty(1L, q - 2L),
    "q..m" = seq_or_empty(q, m),
    "1..q-1" = seq_or_empty(1L, q - 1L),
    structure(integer(), parse_error = TRUE)
  )
}
expected_transition_id <- function(round, rule, h_status, h_vote, z, N) {
  m <- N - 1L
  q <- floor(N / 2) + 1L
  if (round == "R1" && rule == "U" && h_status == "active")
    return(if (h_vote == "Y") if (z == m) "PR01" else "PR02" else "PR03")
  if (round == "R1" && rule == "M" && h_status == "active")
    return(if (h_vote == "Y") if (z >= q - 1L) "PR04" else "PR05" else if (z >= q) "PR06" else "PR07")
  if (round == "R2" && rule == "U" && h_status == "active")
    return(if (h_vote == "Y") if (z == m) "PR08" else "PR09" else "PR10")
  if (round == "R2" && rule == "M" && h_status == "active")
    return(if (h_vote == "Y") if (z >= q - 1L) "PR11" else "PR12" else if (z >= q) "PR13" else "PR14")
  if (round == "R2" && rule == "M" && h_status == "absent")
    return(if (z >= q) "PR15" else "PR16")
  NA_character_
}
validate_transition_registry <- function(candidate) {
  errors <- character()
  if (!identical(names(candidate), names(canonical_transitions))) {
    errors <- c(errors, "schema")
  }
  if (!setequal(candidate$transition_id, canonical_transitions$transition_id) ||
      anyDuplicated(candidate$transition_id)) {
    errors <- c(errors, "inventory")
  }
  if (!length(errors)) {
    ordered <- candidate[match(canonical_transitions$transition_id, candidate$transition_id), , drop = FALSE]
    unequal <- names(canonical_transitions)[!vapply(names(canonical_transitions), function(col) {
      identical(as.character(ordered[[col]]), as.character(canonical_transitions[[col]]))
    }, logical(1))]
    if (length(unequal)) errors <- c(errors, paste0("canonical_fields:", paste(unequal, collapse = ",")))
  }
  used <- character()
  profile_count <- 0L
  for (N in 3:60) {
    m <- N - 1L
    profiles <- expand.grid(
      round = c("R1", "R2"), rule = c("U", "M"), h_status = "active",
      h_vote = c("Y", "N"), z = seq_len(m), stringsAsFactors = FALSE
    )
    profiles <- rbind(
      profiles,
      data.frame(round = "R2", rule = "M", h_status = "absent", h_vote = "NA",
                 z = seq_len(m), stringsAsFactors = FALSE)
    )
    for (idx in seq_len(nrow(profiles))) {
      p <- profiles[idx, ]
      metadata <- candidate$round == p$round & candidate$rule == p$rule &
        candidate$h_status == p$h_status & candidate$h_vote == p$h_vote
      range_hit <- vapply(seq_len(nrow(candidate)), function(row) {
        parsed <- parse_z_range(candidate$z_range[[row]], N)
        !isTRUE(attr(parsed, "parse_error")) && p$z %in% parsed
      }, logical(1))
      hits <- which(metadata & range_hit)
      profile_count <- profile_count + 1L
      expected_id <- expected_transition_id(p$round, p$rule, p$h_status, p$h_vote, p$z, N)
      if (length(hits) != 1L) {
        errors <- c(errors, paste0("coverage:N", N, ":", p$round, ":", p$rule, ":", p$h_vote, ":z", p$z))
      } else {
        used <- c(used, candidate$transition_id[[hits]])
        if (!identical(candidate$transition_id[[hits]], expected_id)) {
          errors <- c(errors, paste0("wrong_id:", expected_id))
        }
      }
    }
  }
  if (!setequal(unique(used), canonical_transitions$transition_id)) errors <- c(errors, "dead_rows")
  list(ok = !length(errors), errors = unique(errors), profiles = profile_count, used = unique(used))
}
transition_validation <- validate_transition_registry(transitions)
add_check("transition_registry_authoritative_validation", transition_validation$ok,
          paste(transition_validation$profiles, "profiles have exactly one fully validated authoritative row."),
          paste(head(transition_validation$errors, 12L), collapse = " | "))
add_check("transition_registry_no_dead_rows",
          setequal(transition_validation$used, canonical_transitions$transition_id),
          "Every PR01--PR16 row is reached for at least one N in 3:60.",
          "At least one transition row is unreachable.")
add_check("transition_pr14_terminal_identity",
          transitions$successor[transitions$transition_id == "PR14"] == "terminal_failure_after_h_optout",
          "PR14 uses the dedicated failure-after-H-optout terminal id.",
          "PR14 successor is not the dedicated terminal id.")

mutation_fails <- function(column, id, value) {
  mutated <- transitions
  mutated[mutated$transition_id == id, column] <- value
  !validate_transition_registry(mutated)$ok
}
add_check("mutation_pr04_range_detected", mutation_fails("z_range", "PR04", "q..m"),
          "Mutation test detects a changed PR04 range.", "PR04 range mutation escaped.")
add_check("mutation_pr06_optout_detected", mutation_fails("h_optout", "PR06", "no"),
          "Mutation test detects a changed PR06 optout field.", "PR06 optout mutation escaped.")
add_check("mutation_outcome_detected", mutation_fails("current_outcome", "PR01", "mutated_outcome"),
          "Mutation test detects a changed current outcome.", "Outcome mutation escaped.")
add_check("mutation_successor_detected", mutation_fails("successor", "PR02", "mutated_successor"),
          "Mutation test detects a changed successor.", "Successor mutation escaped.")
add_check("mutation_payoff_detected", mutation_fails("h_native_payoff", "PR09", "mutated_payoff"),
          "Mutation test detects a changed payoff.", "Payoff mutation escaped.")
add_check("transition_successors_match_r2_nodes",
          setequal(unique(transitions$successor[transitions$terminal == "no"]),
                   c("r2_unanimity_active_h", "r2_majority_active_h", "r2_majority_weak_only")),
          "Every nonterminal transition reaches exactly one terminal R2 problem.",
          "A nonterminal transition has an invalid successor.")
add_check("discount_timing_registry",
          all(grepl("without beta", transitions$discount_note[transitions$round == "R2" & transitions$h_status == "active"], fixed = TRUE)) &&
            all(grepl("already realized", transitions$discount_note[transitions$h_status == "absent"], fixed = TRUE)) &&
            grepl("only after", transitions$discount_note[transitions$transition_id == "PR02"], fixed = TRUE),
          "R2 rows are native-date objects and R1 continuation rows identify beta transport.",
          "Discount timing markers are incomplete.")

required_information_ids <- sprintf("I%02d", 0:9)
add_check("information_set_inventory",
          setequal(information_sets$information_set_id, required_information_ids) &&
            !anyDuplicated(information_sets$information_set_id),
          "Information-set registry contains I00--I09 exactly once.",
          "Information-set registry is incomplete or duplicated.")
weak_ballot <- information_sets$information_set_id %in% c("I03", "I06", "I09")
h_ballot <- information_sets$information_set_id %in% c("I04", "I07")
add_check("information_simultaneous_unobserved_votes",
          all(grepl("simultaneous", information_sets$unobserved[weak_ballot])) &&
            all(grepl("simultaneous", information_sets$unobserved[h_ballot])) &&
            all(grepl("only after all votes", information_sets$publication_after[weak_ballot | h_ballot])),
          "Every ballot mover lacks current-vote observations until closure.",
          "At least one ballot leaks a simultaneous vote.")
add_check("information_type_asymmetry",
          all(grepl("theta", information_sets$unobserved[information_sets$information_set_id %in% c("I03", "I06")])) &&
            all(information_sets$observed_private[h_ballot] == "theta"),
          "Weak voters do not observe theta and H does.",
          "Private type information is represented incorrectly.")
add_check("information_full_history",
          all(grepl("complete public", information_sets$observed_public[
            information_sets$information_set_id %in% c("I05", "I06", "I07", "I08", "I09")
          ])),
          "Every R2 information set retains the complete public history.",
          "An R2 information set compresses the history.")

required_state_ids <- c(
  "entry_pre_recognition_R", "r1_pre_recognition_R", "r1_proposer_R",
  "r1_ballot_weak_R", "r1_ballot_h_R",
  "r2_u_active_pre_recognition", "r2_u_active_proposer",
  "r2_u_active_ballot_weak", "r2_u_active_ballot_h",
  "r2_m_active_pre_recognition", "r2_m_active_proposer",
  "r2_m_active_ballot_weak", "r2_m_active_ballot_h",
  "r2_m_weak_only_pre_recognition", "r2_m_weak_only_proposer",
  "r2_m_weak_only_ballot_weak", "terminal_outcome"
)
add_check("sufficient_state_inventory",
          setequal(sufficient_states$state_id, required_state_ids) && !anyDuplicated(sufficient_states$state_id),
          "State registry contains 17 stage-specific state classes.",
          paste("State ids:", paste(sufficient_states$state_id, collapse = ", ")))
proposal_rows <- grepl("_proposer", sufficient_states$state_id)
weak_state_rows <- grepl("_ballot_weak", sufficient_states$state_id)
h_state_rows <- grepl("_ballot_h", sufficient_states$state_id)
pre_recognition_rows <- grepl("pre_recognition", sufficient_states$state_id)
add_check("state_stage_separation",
          all(!grepl("s_i", sufficient_states$state_key[proposal_rows], fixed = TRUE)) &&
            all(grepl("s_i", sufficient_states$state_key[weak_state_rows], fixed = TRUE)) &&
            all(grepl("voter j", sufficient_states$state_key[weak_state_rows], fixed = TRUE)) &&
            all(grepl("s_i", sufficient_states$state_key[h_state_rows], fixed = TRUE)) &&
            all(grepl("theta", sufficient_states$state_key[h_state_rows], fixed = TRUE)) &&
            all(!grepl("recognized i", sufficient_states$state_key[pre_recognition_rows], fixed = TRUE)),
          "Pre-recognition, proposer, weak-ballot, and H-ballot states are separate.",
          "A proposal and ballot state is mixed or lacks mover-specific information.")
c2_rows <- sufficient_states$state_id %in% c(
  "r2_u_active_pre_recognition", "r2_m_active_pre_recognition",
  "r2_m_weak_only_pre_recognition"
)
add_check("state_c2_pre_recognition_interface",
          all(grepl("integrates recognition", sufficient_states$interface_role[c2_rows], fixed = TRUE)) &&
            all(grepl("full h2", sufficient_states$state_key[c2_rows], fixed = TRUE)),
          "Each C2 consumed by R1 is a full-h2 pre-recognition correspondence integrating the draw.",
          "A C2 interface is post-recognition or lacks full h2.")
add_check("state_history_posterior_separation",
          all(grepl("full h2", sufficient_states$state_key[c2_rows], fixed = TRUE)) &&
            grepl("equal posterior", sufficient_states$compression_risk[
              sufficient_states$state_id == "r2_u_active_pre_recognition"
            ], fixed = TRUE),
          "State registry forbids posterior-only compression.",
          "State registry does not protect full-history dependence.")

required_relevance_ids <- c(sprintf("RV%02d", 1:9), sprintf("RH%02d", 1:4))
required_relevance_columns <- c(
  "relevance_id", "round", "stage", "rule", "h_status", "player_class",
  "information_set_id", "h_action_branch", "count_variable",
  "structural_condition", "condition_code", "continuation_test",
  "outcome_signature", "notes"
)
add_check("relevance_registry_schema_inventory",
          identical(names(relevance), required_relevance_columns) &&
            setequal(relevance$relevance_id, required_relevance_ids) &&
            !anyDuplicated(relevance$relevance_id),
          "Relevance registry is indexed by player, I, stage, rule, H branch, and status.",
          "Relevance registry schema or inventory is incomplete.")
parse_relevance_condition <- function(spec, w, N) {
  m <- N - 1L
  q <- floor(N / 2) + 1L
  switch(
    spec,
    "w_minus_j=m-1" = w == m - 1L,
    "never" = FALSE,
    "w_minus_j=q-2 when q-2>=1" = q - 2L >= 1L && w == q - 2L,
    "w_minus_j=q-1" = w == q - 1L,
    NA
  )
}
expected_weak_relevance <- function(rule, h_status, branch, w, N) {
  m <- N - 1L
  q <- floor(N / 2) + 1L
  if (rule == "U" && h_status == "active" && branch == "H=Y") return(w == m - 1L)
  if (rule == "U" && h_status == "active" && branch == "H=N") return(FALSE)
  if (rule == "M" && h_status == "active" && branch == "H=Y") return(w == q - 2L)
  if (rule == "M" && h_status == "active" && branch == "H=N") return(w == q - 1L)
  if (rule == "M" && h_status == "absent" && branch == "H absent") return(w == q - 1L)
  NA
}
weak_relevance_rows <- relevance$player_class == "weak_nonproposer_j"
weak_relevance_ok <- TRUE
weak_profiles <- 0L
for (row in which(weak_relevance_rows)) {
  for (N in 3:60) {
    m <- N - 1L
    for (w in seq_len(m - 1L)) {
      weak_profiles <- weak_profiles + 1L
      observed <- parse_relevance_condition(relevance$structural_condition[[row]], w, N)
      expected <- expected_weak_relevance(
        relevance$rule[[row]], relevance$h_status[[row]],
        relevance$h_action_branch[[row]], w, N
      )
      weak_relevance_ok <- weak_relevance_ok && isTRUE(identical(observed, expected))
    }
  }
}
add_check("relevance_weak_quota_enumeration", weak_relevance_ok,
          paste(weak_profiles, "weak-voter cases for N=3..60 match the frozen formulas."),
          "At least one weak-voter relevance case differs.")
n3_hy_rows <- relevance$condition_code == "weak_m_active_hy"
n3_values <- vapply(which(n3_hy_rows), function(row) {
  any(vapply(1:(3 - 2), function(w) {
    parse_relevance_condition(relevance$structural_condition[[row]], w, 3)
  }, logical(1)))
}, logical(1))
add_check("relevance_n3_empty_majority_h_yes", !any(n3_values),
          "The N=3 majority active-H H=yes structural weak set is empty.",
          "The required N=3 empty case was lost.")
h_rows <- relevance$player_class == "H_type_theta"
add_check("relevance_h_all_z",
          nrow(relevance[h_rows, ]) == 4L &&
            all(relevance$count_variable[h_rows] == "z in 1..m") &&
            all(relevance$structural_condition[h_rows] == "analyze separately for every z") &&
            all(relevance$h_status[h_rows] == "active"),
          "H is separately analyzed for every z at all active-H ballots.",
          "H relevance was reduced to a quota case.")
r1_relevance <- relevance$round == "R1"
add_check("relevance_kappa_not_raw_successor",
          all(grepl("kappa_C2", relevance$continuation_test[r1_relevance], fixed = TRUE) |
                  grepl("No C2 comparison", relevance$continuation_test[r1_relevance], fixed = TRUE)) &&
            grepl("never itself", contract$vote_relevance$outcome_map, fixed = TRUE) &&
            grepl("different full histories", contract$vote_relevance$same_continuation_class, fixed = TRUE),
          "R1 relevance compares kappa_C2(full h2), never raw successor labels.",
          "Continuation relevance is still based on a raw label.")
add_check("relevance_phi_outcomes",
          all(grepl("terminal", relevance$outcome_signature, fixed = TRUE)) &&
            all(grepl("optout", relevance$outcome_signature, fixed = TRUE)) &&
            grepl("continuation outcome/interface", contract$vote_relevance$outcome_map, fixed = TRUE),
          "Phi records terminal or assessed continuation outcomes, inclusion/optout, and payments.",
          "Phi or its registry omits a payoff-relevant component.")

add_check("formation_exact_rule",
          identical(contract$formation$gross_value,
                    "V_W^R(alpha,mu)=(1/m) E_alpha[sum_j u_j^R | formation]") &&
            identical(contract$formation$net_value, "V_W^R(alpha,mu)-chi") &&
            grepl("if and only if", contract$formation$formation_rule, fixed = TRUE) &&
            grepl("equality forms", contract$formation$formation_rule, fixed = TRUE),
          "Formation value, net cost, iff rule, and equality convention are frozen.",
          "Formation rule is incomplete.")
add_check("formation_correspondence_scope",
          grepl("assessment by assessment", contract$formation$correspondence_rule, fixed = TRUE) &&
            grepl("never choose", contract$formation$correspondence_rule, fixed = TRUE),
          "Entry operates assessment by assessment; bounds are selection-free only.",
          "Entry improperly uses a bound as a choice rule.")

n4_u_individual <- (1L < 3L) && (2L < 3L)
n4_u_joint <- (1L < 3L) && (3L >= 3L)
n4_q <- floor(4 / 2) + 1L
n4_m_individual <- (1L < n4_q) && (2L < n4_q)
n4_m_joint <- (1L < n4_q) && (3L >= n4_q)
add_check("completion_product_hazard_n4",
          n4_u_individual && n4_u_joint && n4_m_individual && n4_m_joint,
          "N=4 unanimity and weak-only majority reproduce the joint-completion hazard.",
          "The N=4 product-completion counterexamples were not reproduced.")
n5_q <- floor(5 / 2) + 1L
add_check("outsider_gift_open_set_n5",
          (1L + 3L >= n5_q) && (1L + 2L >= n5_q) &&
            (1L < n5_q) && (1L + 1L < n5_q) &&
            grepl("open set", contract$coalitions_and_deviations$open_set_implication, fixed = TRUE) &&
            grepl("not a knife-edge", contract$coalitions_and_deviations$open_set_implication, fixed = TRUE),
          "N=5 preserves the open-set gift/completion counterexample.",
          "The N=5 finding was weakened or lost.")
add_check("completion_global_equivalence",
          grepl("full assessment-level completions", contract$vote_relevance$joint_completion_equivalence, fixed = TRUE) &&
            grepl("product-safe", contract$vote_relevance$completion_invariance_obligation, fixed = TRUE) &&
            grepl("correspondence", contract$vote_relevance$completion_invariance_obligation, fixed = TRUE),
          "Only globally equivalent completions may be quotiented; otherwise correspondence survives.",
          "Contract overclaims invariance from individual irrelevance.")
add_check("independent_behavioral_randomization",
          grepl("independent", contract$ballot$behavioral_randomization, fixed = TRUE) &&
            grepl("no proof may insert correlation", contract$ballot$behavioral_randomization, fixed = TRUE),
          "Behavioral mixing is independent absent an authorized device.",
          "Contract permits unauthorized correlation.")
add_check("recognition_exactly_one",
          grepl("exactly one weak proposer is drawn uniformly", contract$primitive_domain$recognition, fixed = TRUE) &&
            grepl("independent across rounds", contract$primitive_domain$recognition, fixed = TRUE),
          "Exactly one weak proposer is uniformly drawn in each reached round.",
          "Recognition wording is ambiguous.")
add_check("no_general_minimal_coalition",
          grepl("not available", contract$coalitions_and_deviations$general_minimality_result, fixed = TRUE) &&
            grepl("proposal-contingent", contract$coalitions_and_deviations$unrestricted_completion_correspondence, fixed = TRUE) &&
            grepl("product-safe invariance or secured passage", contract$coalitions_and_deviations$minimal_winning_representation, fixed = TRUE),
          "General zero-gift/minimal-coalition claims are rejected; gifts remain deviations.",
          "Contract still imposes a minimum coalition.")

allowed_ledger_status <- c("proved", "checked numerically", "conjecture", "pending", "rejected")
add_check("proof_ledger_status_vocabulary", all(ledger$status %in% allowed_ledger_status),
          "Proof ledger uses only authorized status labels.",
          paste("Invalid:", paste(setdiff(ledger$status, allowed_ledger_status), collapse = ", ")))
add_check("proof_ledger_batch_gates",
          all(c("r2_batch_review", "r1_batch_frozen") %in% ledger$state_id) &&
            all(ledger$status[ledger$state_id %in% c("r2_batch_review", "r1_batch_frozen")] == "pending"),
          "Proof ledger contains both pending batch gates.",
          "Proof ledger omits a batch gate.")
review_round1 <- grepl("review round 1", ledger$object, ignore.case = TRUE)
add_check("proof_ledger_round1_repair",
          sum(review_round1) == 1L && ledger$status[review_round1] == "rejected" &&
            grepl("37bd422d", ledger$evidence[review_round1], fixed = TRUE),
          "Ledger records review round 1 as REPAIR/rejected for hash 37bd.",
          "Ledger does not record the first review outcome.")
rereview_row <- grepl("rereview and close", ledger$object, ignore.case = TRUE)
add_check("proof_ledger_gate0_close",
          sum(rereview_row) == 1L &&
            ledger$status[rereview_row] == "proved" &&
            ledger$started_order[rereview_row] == 7L &&
            ledger$passed_order[rereview_row] == 10L &&
            grepl("gate0_review_v1.json", ledger$evidence[rereview_row], fixed = TRUE),
          "Ledger records independent rereview PASS and Gate 0 close at event 10.",
          "Ledger does not record the closed independent rereview.")
minimality_row <- ledger$object == "General zero-gift or minimal-coalition conclusion"
add_check("proof_ledger_rejects_general_minimality",
          sum(minimality_row) == 1L && ledger$status[minimality_row] == "rejected",
          "Ledger rejects the general minimality conclusion.",
          "Ledger fails to preserve the N=5 implication.")
downstream_ledger <- ledger$state_id %in% setdiff(expected_node_ids, "gate0_contract")
add_check("proof_ledger_no_downstream_results",
          all(ledger$status[downstream_ledger] == "pending") &&
            all(is.na(ledger$started_order[downstream_ledger])) &&
            all(is.na(ledger$passed_order[downstream_ledger])),
          "Every downstream ledger node is pending and unstarted.",
          "A downstream ledger row was promoted.")

required_rmd_markers <- c(
  "STOP_BEFORE_R2",
  "Perfect Bayesian equilibrium",
  "Product-safe completion discipline",
  "Gifts to outsiders remain feasible deviations",
  "Gate 0 is **PASS**",
  "beta is applied exactly once only",
  "r2_batch_review",
  "r1_batch_frozen",
  "gate0_bundle_v1.json",
  "gate0_review_v1.json",
  "V_W^R(\\alpha,\\mu)"
)
rmd_present <- vapply(required_rmd_markers, function(x) grepl(x, rmd_text, fixed = TRUE), logical(1))
add_check("rmd_gate0_markers", all(rmd_present),
          "Rmd records the repaired contract, barriers, formation, and stop boundary.",
          paste("Missing:", paste(required_rmd_markers[!rmd_present], collapse = ", ")))
add_check("rmd_stops_before_derivation",
          !grepl("# Round 2 derivation", rmd_text, fixed = TRUE) &&
            !grepl("# Round 1 derivation", rmd_text, fixed = TRUE) &&
            grepl("STOP_BEFORE_R2", rmd_text, fixed = TRUE),
          "Rmd stops before any R2/R1 derivation.",
          "Rmd appears to contain downstream derivation.")
add_check("status_review_close_and_layout_limit",
          grepl("Review round 1", status_text, fixed = TRUE) &&
            grepl("REPAIR", status_text, fixed = TRUE) &&
            grepl("37bd422d", status_text, fixed = TRUE) &&
            grepl("zero findings", status_text, ignore.case = TRUE) &&
            grepl("passed_order=10", status_text, fixed = TRUE) &&
            grepl("layout", status_text, ignore.case = TRUE) &&
            grepl("not tested", status_text, ignore.case = TRUE),
          "Status records round-1 REPAIR, two zero-finding PASS rereviews, close order, and layout limit.",
          "Status omits the review close history or layout limit.")
add_check("status_bundle_hash",
          grepl(bundle_hash, status_text, fixed = TRUE),
          "Status records the current bundle hash.",
          "Status does not record the current bundle hash.")
add_check("independent_review_report",
          grepl("Final verdict:** **PASS", review_text, fixed = TRUE) &&
            grepl(bundle_hash, review_text, fixed = TRUE) &&
            grepl(review_hash, review_text, fixed = TRUE) &&
            grepl("zero critical", review_text, fixed = TRUE) &&
            grepl("passed_order=10", review_text, fixed = TRUE) &&
            grepl("not tested", review_text, ignore.case = TRUE),
          "Independent review report records exact hashes, zero findings, event 10, and layout scope.",
          "Independent review report is incomplete.")

output_path <- "tables/pivotal_response_gate0_checks.csv"
log_path <- "quality_reports/logs/verify_pivotal_response_gate0.log"
utils::write.csv(checks, output_path, row.names = FALSE, fileEncoding = "UTF-8")
pass_count <- sum(checks$status == "PASS")
fail_count <- sum(checks$status == "FAIL")
overall <- if (fail_count == 0L) "PASS" else "FAIL"
log_lines <- c(
  "PIVOTAL RESPONSE GATE 0 VERIFICATION",
  paste("timestamp:", format(Sys.time(), tz = "America/Sao_Paulo", usetz = TRUE)),
  paste("git_root:", repo_root),
  paste("branch:", current_branch),
  paste("head:", current_head),
  paste("contract_hash:", paste0("sha256:", contract_hash)),
  paste("bundle_hash:", bundle_hash),
  paste("review_hash:", review_hash),
  paste("checks:", nrow(checks)),
  paste("pass:", pass_count),
  paste("fail:", fail_count),
  paste("status:", overall),
  "scope: mechanical validation of independently closed Gate 0; no R2 or equilibrium derivation",
  "dag_require_execution_order_output:",
  paste(dag_run$output, collapse = "\n"),
  "r2_candidate_output:",
  paste(r2_candidates$output, collapse = "\n"),
  "sessionInfo:",
  paste(capture.output(sessionInfo()), collapse = "\n")
)
writeLines(log_lines, log_path, useBytes = TRUE)
cat(sprintf("%s: %d/%d checks passed.\nOutputs: %s; %s\n",
            overall, pass_count, nrow(checks), output_path, log_path))
if (fail_count > 0L) {
  print(checks[checks$status == "FAIL", , drop = FALSE], row.names = FALSE)
  quit(status = 1L)
}
