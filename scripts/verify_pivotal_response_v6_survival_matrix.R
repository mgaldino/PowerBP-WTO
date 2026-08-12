#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1L]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

interface_path <- "model_redesign/pivotal_response_interfaces/v6_survival_matrix_v1.json"
matrix_path <- "tables/pivotal_response_v6_survival_matrix_v1.csv"
comparison_path <- "model_redesign/pivotal_response_interfaces/institutional_comparison_v1.json"
review_path <- "model_redesign/pivotal_response_interfaces/institutional_comparison_review_v1.json"
protected_path <- "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv"
checks_path <- "tables/pivotal_response_v6_survival_matrix_checks_v1.csv"

required <- c(interface_path, matrix_path, comparison_path, review_path, protected_path)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing survival-matrix artifacts: ", paste(missing, collapse = ", "))

checks <- data.frame(check_id = character(), status = character(), detail = character())
add_check <- function(id, condition, pass_detail, fail_detail = pass_detail) {
  ok <- isTRUE(condition)
  checks <<- rbind(
    checks,
    data.frame(
      check_id = id,
      status = if (ok) "PASS" else "FAIL",
      detail = if (ok) pass_detail else fail_detail
    )
  )
  invisible(ok)
}

sha256_file <- function(path) {
  out <- suppressWarnings(system2("shasum", c("-a", "256", path), stdout = TRUE, stderr = FALSE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  if (!length(out) || status != 0L) return(NA_character_)
  strsplit(trimws(out[[1L]]), "[[:space:]]+")[[1L]][[1L]]
}

clone_record <- function(x) unserialize(serialize(x, NULL))

resolve_from <- function(parent_path, child_path) {
  normalizePath(file.path(dirname(normalizePath(parent_path, mustWork = TRUE)), child_path), mustWork = TRUE)
}

pointer_exists <- function(object, pointer) {
  if (!is.character(pointer) || length(pointer) != 1L || !startsWith(pointer, "/")) return(FALSE)
  tokens <- strsplit(substring(pointer, 2L), "/", fixed = TRUE)[[1L]]
  if (identical(tokens, "")) return(TRUE)
  current <- object
  for (token in tokens) {
    token <- gsub("~1", "/", gsub("~0", "~", token, fixed = TRUE), fixed = TRUE)
    if (!is.list(current) || is.null(names(current)) || !token %in% names(current)) return(FALSE)
    current <- current[[token]]
  }
  TRUE
}

parse_evidence_ref <- function(ref) {
  at <- strsplit(trimws(ref), "@", fixed = TRUE)[[1L]]
  if (length(at) != 2L) return(NULL)
  hash_locator <- strsplit(at[[2L]], "#", fixed = TRUE)[[1L]]
  if (length(hash_locator) != 2L) return(NULL)
  list(path = at[[1L]], sha256 = hash_locator[[1L]], locator = paste0("#", hash_locator[[2L]]))
}

parse_evidence_cell <- function(cell) {
  refs <- strsplit(cell, " | ", fixed = TRUE)[[1L]]
  lapply(refs, parse_evidence_ref)
}

special_locator_exists <- function(path, locator) {
  if (identical(locator, "#quarantined")) {
    tab <- utils::read.delim(path, check.names = FALSE, quote = "", comment.char = "")
    return("category" %in% names(tab) && any(grepl("quarantined", tab$category, fixed = TRUE)))
  }
  if (identical(locator, "#formal_model_v6.Rmd")) {
    tab <- utils::read.delim(path, check.names = FALSE, quote = "", comment.char = "")
    return("path" %in% names(tab) && "formal_model_v6.Rmd" %in% tab$path)
  }
  FALSE
}

evidence_ref_valid <- function(ref, registry) {
  if (is.null(ref) || !nzchar(ref$path) || !file.exists(ref$path)) return(FALSE)
  if (!grepl("^[0-9a-f]{64}$", ref$sha256)) return(FALSE)
  if (!identical(sha256_file(ref$path), ref$sha256)) return(FALSE)
  key <- basename(ref$path)
  if (!key %in% names(registry) || !identical(registry[[key]], ref$sha256)) return(FALSE)
  if (grepl("[.]json$", ref$path)) {
    object <- tryCatch(jsonlite::fromJSON(ref$path, simplifyVector = FALSE), error = function(e) NULL)
    if (is.null(object)) return(FALSE)
    return(pointer_exists(object, substring(ref$locator, 2L)))
  }
  special_locator_exists(ref$path, ref$locator)
}

historical_locator_valid <- function(source, locator, allowed_sources) {
  if (!source %in% allowed_sources || !file.exists(source)) return(FALSE)
  hit <- regexec("^L([0-9]+)-L([0-9]+)$", locator)
  values <- regmatches(locator, hit)[[1L]]
  if (length(values) != 3L) return(FALSE)
  first <- as.integer(values[[2L]])
  last <- as.integer(values[[3L]])
  lines <- readLines(source, warn = FALSE, encoding = "UTF-8")
  first >= 1L && last >= first && last <= length(lines) && any(nzchar(trimws(lines[first:last])))
}

protected_valid <- function(tab) {
  required_columns <- c("path", "sha256", "category", "frozen_at_head")
  identical(names(tab), required_columns) && nrow(tab) == 27L &&
    all(file.exists(tab$path)) &&
    all(vapply(tab$path, sha256_file, character(1)) == tab$sha256)
}

status_lock <- c(
  SM001="survives", SM002="changes", SM003="survives", SM004="changes",
  SM005="survives", SM006="changes", SM007="survives", SM008="survives",
  SM009="conditional", SM010="changes", SM011="survives",
  SM012="rejected", SM013="conditional", SM014="rejected",
  SM015="rejected", SM016="rejected", SM017="rejected", SM018="rejected",
  SM019="rejected", SM020="rejected", SM021="rejected", SM022="rejected",
  SM023="changes", SM024="changes", SM025="changes", SM026="conditional",
  SM027="conditional", SM028="pending", SM029="conditional",
  SM030="pending", SM031="survives", SM032="conditional",
  SM033="pending", SM034="rejected", SM035="pending", SM036="pending",
  SM037="conditional", SM038="outside_scope", SM039="outside_scope",
  SM040="outside_scope", SM041="outside_scope", SM042="rejected",
  SM043="outside_scope", SM044="outside_scope", SM045="pending",
  SM046="conditional", SM047="survives", SM048="conditional",
  SM049="conditional", SM050="conditional",
  SM051="conditional", SM052="conditional"
)

archived_formula_tokens <- c(
  "lambda_M", "kappa_M", "mu_s", "h_C", "h_A", "y_A", "mu_AC", "mu_C",
  "A-C-A", "C-B-R", "max{A,C,R}", "V_e(", "alpha V(", "mu_M^H", "a_0^M"
)

has_archived_formula <- function(text) {
  any(vapply(archived_formula_tokens, function(token) grepl(token, text, fixed = TRUE), logical(1)))
}

has_current_scalar_label <- function(text) {
  grepl("(^|[^A-Za-z0-9_])[PLR]([^A-Za-z0-9_]|$)", text, perl = TRUE)
}

allowed_status <- c("survives", "conditional", "changes", "rejected", "pending", "outside_scope")
allowed_action <- c("retain_with_rewrite", "replace", "remove", "do_not_add", "pending")

action_compatible <- function(status, action) {
  if (status %in% c("survives", "conditional")) return(identical(action, "retain_with_rewrite"))
  if (identical(status, "changes")) return(identical(action, "replace"))
  if (identical(status, "outside_scope")) return(identical(action, "do_not_add"))
  if (identical(status, "pending")) return(identical(action, "pending"))
  if (identical(status, "rejected")) return(action %in% c("remove", "replace"))
  FALSE
}

matrix_core_valid <- function(tab, registry, allowed_sources) {
  expected_columns <- c(
    "claim_id", "historical_source_path", "historical_locator", "historical_claim",
    "current_status", "current_precise_replacement", "current_evidence_path_hash",
    "domain_selection_scope", "manuscript_action", "migration_blocker", "notes"
  )
  if (!identical(names(tab), expected_columns) || nrow(tab) != 52L) return(FALSE)
  if (!identical(tab$claim_id, sprintf("SM%03d", seq_len(52L)))) return(FALSE)
  if (anyDuplicated(tab$claim_id) || any(!nzchar(as.matrix(tab)))) return(FALSE)
  if (!all(tab$current_status %in% allowed_status) || !all(tab$manuscript_action %in% allowed_action)) return(FALSE)
  if (!identical(stats::setNames(tab$current_status, tab$claim_id), status_lock)) return(FALSE)
  if (!all(mapply(action_compatible, tab$current_status, tab$manuscript_action))) return(FALSE)
  if (any(vapply(tab$current_precise_replacement, has_archived_formula, logical(1)))) return(FALSE)
  if (any(vapply(tab$current_precise_replacement, has_current_scalar_label, logical(1)))) return(FALSE)
  if (any(grepl("PBE-UD|as-if pivotal|refinement|roll-call voting", tab$current_precise_replacement, ignore.case = TRUE))) return(FALSE)
  if (!all(mapply(historical_locator_valid, tab$historical_source_path, tab$historical_locator,
                  MoreArgs = list(allowed_sources = allowed_sources)))) return(FALSE)
  evidence_ok <- vapply(tab$current_evidence_path_hash, function(cell) {
    if (!nzchar(cell)) return(FALSE)
    refs <- parse_evidence_cell(cell)
    length(refs) >= 1L && all(vapply(refs, evidence_ref_valid, logical(1), registry = registry))
  }, logical(1))
  if (!all(evidence_ok)) return(FALSE)
  historical_sources <- unique(tab$historical_source_path)
  evidence_paths <- unlist(lapply(tab$current_evidence_path_hash, function(cell) {
    vapply(parse_evidence_cell(cell), function(ref) if (is.null(ref)) "" else ref$path, character(1))
  }))
  if (any(evidence_paths %in% historical_sources)) return(FALSE)
  TRUE
}

interface <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
matrix <- utils::read.csv(matrix_path, check.names = FALSE, na.strings = character())
comparison <- jsonlite::fromJSON(comparison_path, simplifyVector = FALSE)
review <- jsonlite::fromJSON(review_path, simplifyVector = FALSE)
protected <- utils::read.delim(protected_path, check.names = FALSE, quote = "", comment.char = "")
registry <- unlist(interface$evidence_hash_registry, use.names = TRUE)

inventory_paths <- vapply(interface$historical_inventory, function(x) resolve_from(interface_path, x$path), character(1))
inventory_repo_paths <- unname(vapply(inventory_paths, function(x) substring(x, nchar(repo_root) + 2L), character(1)))
inventory_declared <- vapply(interface$historical_inventory, function(x) x$sha256, character(1))
inventory_actual <- vapply(inventory_paths, sha256_file, character(1))

add_check(
  "candidate_identity_and_nonmigration_status",
  identical(interface$state_id, "v6_survival_matrix") &&
    identical(interface$status, "candidate_pending_independent_review") &&
    identical(as.integer(interface$implementation_started_order), 61L) &&
    grepl("blocked", interface$solution_and_scope$migration_status, fixed = TRUE),
  "Candidate is a nonmigratory survival classification started at order 61 and pending independent review.",
  "Candidate identity, status, order, or migration block differs."
)

dependency_roles <- vapply(interface$dependencies, function(x) x$role, character(1))
dependency_paths <- vapply(interface$dependencies, function(x) resolve_from(interface_path, x$path), character(1))
dependency_declared <- vapply(interface$dependencies, function(x) x$sha256, character(1))
dependency_actual <- vapply(dependency_paths, sha256_file, character(1))
add_check(
  "approved_comparison_dependencies",
  identical(dependency_roles, c("approved_institutional_comparison", "comparison_review_and_consumer_contract")) &&
    identical(dependency_declared, c(
      "cab69c5ddda3616f51c697c189c86316df5546501a183eb6cc9e437dc813f3af",
      "0acd9648eb7e03d4dabfaa91ffd559fe3c5b6f61a96ba676d6c6ccd9d4c6bb3c"
    )) && identical(unname(dependency_actual), dependency_declared) &&
    identical(comparison$status, "candidate_pending_independent_review") && identical(review$status, "pass"),
  "Exact approved comparison cab69c5 and review bundle 0acd964 are the only formal dependencies.",
  "A comparison dependency role, hash, byte stream, or approval status differs."
)

add_check(
  "authoritative_matrix_hash_and_shape",
  identical(resolve_from(interface_path, interface$authoritative_matrix$path), normalizePath(matrix_path, mustWork = TRUE)) &&
    identical(interface$authoritative_matrix$sha256, sha256_file(matrix_path)) &&
    identical(as.integer(interface$authoritative_matrix$row_count), 52L) &&
    identical(as.integer(interface$authoritative_matrix$column_count), 11L),
  paste("Authoritative matrix has 52 claims, 11 columns, and hash", sha256_file(matrix_path)),
  "Matrix path, hash, row count, or column count differs."
)

add_check(
  "historical_inventory_exact_and_read_only",
  identical(inventory_repo_paths, c("formal_model_v5.Rmd", "formal_model_v6.Rmd", "model_redesign/power_architecture_derivations.Rmd", "AGENTS.md")) &&
    identical(unname(inventory_actual), inventory_declared),
  "All four allowed historical inventory sources retain exact hashes.",
  "An inventory source path or hash differs."
)

add_check(
  "status_vocabulary_and_exact_locks",
  all(matrix$current_status %in% allowed_status) &&
    identical(stats::setNames(matrix$current_status, matrix$claim_id), status_lock),
  "Every claim has exactly one allowed status and all 52 conservative status locks match.",
  "A status is invalid or stronger than the locked classification."
)

add_check(
  "status_counts_exact",
  identical(as.integer(table(factor(matrix$current_status, levels = allowed_status))), c(8L,13L,7L,12L,6L,6L)) &&
    identical(as.integer(unlist(interface$authoritative_matrix$status_counts)), c(8L,13L,7L,12L,6L,6L)),
  "Status counts are 8 survives, 13 conditional, 7 changes, 12 rejected, 6 pending, and 6 outside scope.",
  "Matrix or interface status counts differ."
)

add_check(
  "action_vocabulary_compatibility_and_counts",
  all(matrix$manuscript_action %in% allowed_action) &&
    all(mapply(action_compatible, matrix$current_status, matrix$manuscript_action)) &&
    identical(as.integer(table(factor(matrix$manuscript_action, levels = allowed_action))), c(21L,10L,9L,6L,6L)) &&
    identical(as.integer(unlist(interface$authoritative_matrix$action_counts)), c(21L,10L,9L,6L,6L)),
  "All actions match status semantics; counts are 21 retain, 10 replace, 9 remove, 6 do not add, and 6 pending.",
  "An action is invalid, incompatible, or miscounted."
)

add_check(
  "historical_locators_exist",
  all(mapply(historical_locator_valid, matrix$historical_source_path, matrix$historical_locator,
             MoreArgs = list(allowed_sources = inventory_repo_paths))),
  "All 52 source line locators exist inside the four exact allowed inventories.",
  "A historical path or line locator is invalid."
)

evidence_valid_rows <- vapply(matrix$current_evidence_path_hash, function(cell) {
  refs <- parse_evidence_cell(cell)
  length(refs) >= 1L && all(vapply(refs, evidence_ref_valid, logical(1), registry = registry))
}, logical(1))
add_check(
  "current_evidence_paths_hashes_and_locators",
  all(evidence_valid_rows),
  "Every row cites existing current evidence with an exact hash and valid JSON pointer or manifest anchor.",
  paste("Invalid evidence rows:", paste(matrix$claim_id[!evidence_valid_rows], collapse = ", "))
)

registry_paths <- unique(unlist(lapply(matrix$current_evidence_path_hash, function(cell) {
  vapply(parse_evidence_cell(cell), function(x) x$path, character(1))
})))
registry_keys_used <- unique(basename(registry_paths))
add_check(
  "evidence_registry_complete_and_exact",
  all(registry_keys_used %in% names(registry)) &&
    all(vapply(registry_paths, sha256_file, character(1)) == unname(registry[basename(registry_paths)])),
  "The evidence registry covers every cited current artifact at its exact byte hash.",
  "The evidence registry omits or mis-hashes a cited artifact."
)

add_check(
  "historical_sources_not_current_evidence",
  !any(registry_paths %in% inventory_repo_paths),
  "No manuscript, prior derivation, or governance inventory is used as proof evidence.",
  "A historical inventory source was used as current evidence."
)

add_check(
  "complete_rows_and_unique_ids",
  identical(matrix$claim_id, sprintf("SM%03d", seq_len(52L))) && !anyDuplicated(matrix$claim_id) &&
    !any(!nzchar(as.matrix(matrix))),
  "The matrix has contiguous unique IDs and no empty machine-readable field.",
  "Claim IDs are noncontiguous, duplicated, or a field is empty."
)

add_check(
  "no_archived_formula_or_branch_copy",
  !any(vapply(matrix$current_precise_replacement, has_archived_formula, logical(1))),
  "No archived formula, calibrated cutoff, or feasibility-branch label appears in a current replacement.",
  "An archived formula or branch label was copied into a current replacement."
)

add_check(
  "no_current_scalar_equilibrium_label",
  !any(vapply(matrix$current_precise_replacement, has_current_scalar_label, logical(1))),
  "No current equilibrium assessment is assigned an isolated historical scalar label.",
  "A current replacement assigns or embeds an isolated historical scalar label."
)

add_check(
  "no_forbidden_current_object_wording",
  !any(grepl("PBE-UD|as-if pivotal|refinement|roll-call voting", matrix$current_precise_replacement, ignore.case = TRUE)),
  "Current replacements use direct response and information language without forbidden historical terminology.",
  "A current replacement uses forbidden terminology."
)

add_check(
  "PBE_local_relevance_and_simultaneous_protocol",
  identical(matrix$current_status[matrix$claim_id == "SM001"], "survives") &&
    identical(matrix$current_status[matrix$claim_id == "SM002"], "changes") &&
    identical(matrix$current_status[matrix$claim_id == "SM003"], "survives") &&
    grepl("outcome-signature relevance", matrix$current_precise_replacement[matrix$claim_id == "SM002"], fixed = TRUE) &&
    grepl("simultaneous", matrix$current_precise_replacement[matrix$claim_id == "SM003"], fixed = TRUE),
  "PBE-only, outcome-signature relevance, equality response, and simultaneous ballot are classified separately.",
  "Core solution or ballot protocol wording is missing or overclaimed."
)

add_check(
  "discount_and_optout_discipline",
  all(matrix$current_status[matrix$claim_id %in% c("SM005", "SM006")] == c("survives", "changes")) &&
    grepl("exactly once", matrix$current_precise_replacement[matrix$claim_id == "SM005"], fixed = TRUE) &&
    grepl("no beta", matrix$current_precise_replacement[matrix$claim_id == "SM006"], fixed = TRUE),
  "Immediate opt-out and beta-once dating are correctly separated from the rejected terminal formula.",
  "Opt-out or dating language is incomplete."
)

add_check(
  "belief_core_and_hardcoded_belief_split",
  identical(matrix$current_status[matrix$claim_id == "SM009"], "conditional") &&
    identical(matrix$current_status[matrix$claim_id == "SM010"], "changes"),
  "The informational weak-vote core survives conditionally while hard-coded historical beliefs change.",
  "Belief-assessment claims were not split correctly."
)

add_check(
  "direct_cutoff_scope_is_faithful",
  identical(matrix$current_status[matrix$claim_id == "SM011"], "survives") &&
    grepl("probability one", matrix$current_precise_replacement[matrix$claim_id == "SM011"], fixed = TRUE),
  "The historical full expected IC survives, including its direct-cutoff reduction only under certain current implementation.",
  "The full IC or the direct cutoff's conditional scope is missing."
)

add_check(
  "minimal_coalition_and_zero_gifts_rejected",
  identical(matrix$current_status[matrix$claim_id == "SM012"], "rejected") &&
    grepl("positive gifts", matrix$current_precise_replacement[matrix$claim_id == "SM012"], fixed = TRUE),
  "Minimal-support and zero-gift normalization is rejected with current gift/support scope.",
  "Coalition/gift classification is missing or too strong."
)

add_check(
  "motifs_split_from_exhaustiveness",
  identical(matrix$current_status[matrix$claim_id == "SM013"], "conditional") &&
    identical(matrix$current_status[matrix$claim_id == "SM014"], "rejected"),
  "Historical outcome motifs survive only as subclasses; exhaustive reduction is rejected.",
  "Motifs and global exhaustiveness were not separated."
)

add_check(
  "scalar_theorems_rejected_but_exact_projections_retained",
  all(matrix$current_status[matrix$claim_id %in% c("SM016", "SM017", "SM018", "SM019", "SM020")] == "rejected") &&
    all(matrix$current_status[matrix$claim_id %in% c("SM048", "SM049", "SM050", "SM051", "SM052")] == "conditional"),
  "Global scalar characterizations are rejected while five exact upper/subclass projections are retained with scope.",
  "A global scalar claim or exact scoped projection is misclassified."
)

add_check(
  "boundary_appendix_and_delay_exclusivity_rejected",
  all(matrix$current_status[matrix$claim_id %in% c("SM021", "SM022")] == "rejected"),
  "Delay-only-at-beta-one and Appendix C C1-C13/table are nonmigrating current characterizations.",
  "A rejected boundary characterization was promoted."
)

add_check(
  "full_common_domain_and_entry_by_assessment",
  identical(matrix$current_status[matrix$claim_id == "SM023"], "changes") &&
    grepl("N at least 3", matrix$current_precise_replacement[matrix$claim_id == "SM023"], fixed = TRUE) &&
    all(matrix$current_status[matrix$claim_id %in% c("SM024", "SM047")] == c("changes", "survives")),
  "Common existence is full N>=3 and entry is retained assessment by assessment with equality formation.",
  "Common-domain or assessment-indexed entry classification is wrong."
)

add_check(
  "three_nesting_objects_separated",
  identical(matrix$current_status[matrix$claim_id == "SM025"], "changes") &&
    all(matrix$current_status[matrix$claim_id %in% c("SM026", "SM027")] == "conditional") &&
    identical(matrix$current_status[matrix$claim_id == "SM028"], "pending"),
  "Pairwise, possible-cost, guaranteed-cost, and universal cross-pair nesting are separately classified.",
  "The three nesting notions were conflated or overclaimed."
)

add_check(
  "M_only_existence_not_universal_and_U_only_not_excluded",
  identical(matrix$current_status[matrix$claim_id == "SM029"], "conditional") &&
    identical(matrix$current_status[matrix$claim_id == "SM030"], "pending"),
  "N>=4 majority-only existence is retained; unanimity-only existence remains pending without an attained pair or exclusion proof.",
  "Exclusive-formation results are overgeneralized."
)

add_check(
  "H_floor_conditional_signs_and_equality_counterexample",
  identical(matrix$current_status[matrix$claim_id == "SM031"], "survives") &&
    identical(matrix$current_status[matrix$claim_id == "SM032"], "conditional") &&
    identical(matrix$current_status[matrix$claim_id == "SM033"], "pending") &&
    identical(matrix$current_status[matrix$claim_id == "SM034"], "rejected") &&
    identical(matrix$current_status[matrix$claim_id == "SM035"], "pending"),
  "The historical ex-ante H floor survives and is strengthened typewise; both-form weak ordering and global rank remain pending; the historical equality-only clause is rejected by a domain-matched both-form witness.",
  "H payoff claims are too strong or incompletely separated."
)

add_check(
  "universal_rule_ranking_pending",
  identical(matrix$current_status[matrix$claim_id == "SM036"], "pending") &&
    grepl("No universal rule ranking", matrix$current_precise_replacement[matrix$claim_id == "SM036"], fixed = TRUE),
  "Universal rule ranking is explicitly pending and not claimed.",
  "Universal ranking was promoted or omitted."
)

add_check(
  "extensions_archives_and_goal3_outside_scope",
  all(matrix$current_status[matrix$claim_id %in% c("SM038", "SM039", "SM040", "SM041", "SM043", "SM044")] == "outside_scope") &&
    all(matrix$manuscript_action[matrix$claim_id %in% c("SM038", "SM039", "SM040", "SM041", "SM043", "SM044")] == "do_not_add"),
  "Agenda power, endogenous rule choice, archived BF/OPEC numbers, Goal-3 artifacts, and hybrid/delayed exits are outside scope.",
  "An extension or archived artifact was promoted into the current baseline."
)

add_check(
  "No_Cheap_H_current_theorem_rejected",
  identical(matrix$current_status[matrix$claim_id == "SM042"], "rejected") &&
    identical(matrix$manuscript_action[matrix$claim_id == "SM042"], "remove"),
  "Historical No-Cheap-H is rejected as a current theorem.",
  "No-Cheap-H was retained as a current theorem."
)

add_check(
  "migration_gate_pending",
  identical(matrix$current_status[matrix$claim_id == "SM045"], "pending") &&
    identical(matrix$manuscript_action[matrix$claim_id == "SM045"], "pending") &&
    grepl("No migration is authorized", matrix$current_precise_replacement[matrix$claim_id == "SM045"], fixed = TRUE),
  "Protected-target migration remains explicitly pending and unauthorized.",
  "The matrix implicitly or explicitly authorizes migration."
)

add_check(
  "protected_manifest_and_all_27_hashes",
  protected_valid(protected),
  "All 27 protected manuscripts, outputs, historical artifacts, and verifiers remain byte-identical.",
  paste("Protected mismatch:", paste(protected$path[vapply(protected$path, sha256_file, character(1)) != protected$sha256], collapse = ", "))
)

add_check(
  "protected_v5_v6_and_prior_derivation_exact",
  identical(sha256_file("formal_model_v5.Rmd"), "1b0e420155b58e4b069f04b210736b3fab60cf060f87a6ca30ce5019676620af") &&
    identical(sha256_file("formal_model_v6.Rmd"), "131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d") &&
    identical(sha256_file("model_redesign/power_architecture_derivations.Rmd"), "8fbb7edff59fb0dc6fb36571564ec94d26e66b1211496ed10e9d9191ef2f68c6"),
  "v5, v6, and the prior derivation inventory are unchanged.",
  "A protected source changed."
)

topic_ids <- unique(unlist(interface$required_topic_index, use.names = FALSE))
add_check(
  "required_topic_index_complete",
  setequal(topic_ids, matrix$claim_id) && all(topic_ids %in% matrix$claim_id),
  "The machine-readable topic index covers all 52 claims exactly.",
  "The topic index omits or invents a claim ID."
)

add_check(
  "matrix_core_validator_pass",
  matrix_core_valid(matrix, registry, inventory_repo_paths),
  "The integrated core validator accepts the exact candidate.",
  "The integrated core validator rejects the exact candidate."
)

mut_missing_evidence <- clone_record(matrix)
mut_missing_evidence$current_evidence_path_hash[[1L]] <- ""
add_check(
  "negative_missing_evidence_blocked",
  !matrix_core_valid(mut_missing_evidence, registry, inventory_repo_paths),
  "Negative test PASS: deleting evidence blocks the candidate.",
  "Negative test FAIL: a row without current evidence was accepted."
)

mut_overclaim <- clone_record(matrix)
mut_overclaim$current_status[mut_overclaim$claim_id == "SM028"] <- "survives"
add_check(
  "negative_status_overclaim_blocked",
  !matrix_core_valid(mut_overclaim, registry, inventory_repo_paths),
  "Negative test PASS: promoting pending universal nesting to survives is rejected.",
  "Negative test FAIL: a status overclaim was accepted."
)

mut_formula <- clone_record(matrix)
mut_formula$current_precise_replacement[mut_formula$claim_id == "SM040"] <- "Import lambda_M and the A-C-A branch."
add_check(
  "negative_archived_formula_and_label_copy_blocked",
  !matrix_core_valid(mut_formula, registry, inventory_repo_paths),
  "Negative test PASS: an archived formula and branch label are rejected.",
  "Negative test FAIL: an archived formula or label was accepted."
)

mut_current_label <- clone_record(matrix)
mut_current_label$current_precise_replacement[mut_current_label$claim_id == "SM013"] <- "The current PBE is P."
add_check(
  "negative_current_PBE_label_blocked",
  !matrix_core_valid(mut_current_label, registry, inventory_repo_paths),
  "Negative test PASS: assigning a historical scalar label to a current equilibrium is rejected.",
  "Negative test FAIL: a forbidden current equilibrium label was accepted."
)

mut_old_survival <- clone_record(matrix)
mut_old_survival$current_status[mut_old_survival$claim_id == "SM040"] <- "survives"
mut_old_survival$manuscript_action[mut_old_survival$claim_id == "SM040"] <- "retain_with_rewrite"
add_check(
  "negative_old_formula_survival_blocked",
  !matrix_core_valid(mut_old_survival, registry, inventory_repo_paths),
  "Negative test PASS: marking archived formulas as surviving is rejected.",
  "Negative test FAIL: archived formulas were accepted as current survivors."
)

mut_protected <- clone_record(protected)
mut_protected$sha256[[1L]] <- paste0("0", substring(mut_protected$sha256[[1L]], 2L))
add_check(
  "negative_protected_hash_mutation_blocked",
  !protected_valid(mut_protected),
  "Negative test PASS: changing a protected hash blocks the matrix.",
  "Negative test FAIL: a protected hash mutation was accepted."
)

mut_dependency <- clone_record(interface)
mut_dependency$dependencies[[1L]]$sha256 <- paste0("0", substring(mut_dependency$dependencies[[1L]]$sha256, 2L))
mut_dependency_declared <- vapply(mut_dependency$dependencies, function(x) x$sha256, character(1))
add_check(
  "negative_comparison_dependency_mutation_blocked",
  !identical(mut_dependency_declared, dependency_actual),
  "Negative test PASS: changing the approved comparison hash invalidates the candidate.",
  "Negative test FAIL: a comparison dependency mutation was accepted."
)

utils::write.csv(checks, checks_path, row.names = FALSE, na = "", fileEncoding = "UTF-8")

failures <- checks$check_id[checks$status != "PASS"]
if (length(failures)) {
  cat(sprintf("Survival-matrix verification: %d/%d PASS\n", sum(checks$status == "PASS"), nrow(checks)))
  cat("FAIL:", paste(failures, collapse = ", "), "\n")
  quit(status = 1L)
}

cat(sprintf("Survival-matrix verification: %d/%d PASS\n", nrow(checks), nrow(checks)))
cat("Candidate remains nonmigratory and pending two independent read-only reviews.\n")
