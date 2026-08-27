#!/usr/bin/env Rscript

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("Package 'jsonlite' is required.", call. = FALSE)
}

agenda_expected_manifest_sha256 <- "588e7da2ec7df2f208ccaf082d3bc30834ea12625484b04b25d3eae7fce20a86"

agenda_required_ledger_columns <- c(
  "claim_id", "node_id", "cell_id", "record_or_family_id",
  "member_domain", "claim_kind", "claim_text", "domain", "status",
  "selection_status", "assumptions_used", "source_record_ids",
  "source_hashes", "payoff_date", "evidence_path", "proof_path"
)

agenda_required_family_fields <- c(
  "family_record_id", "institution", "cell_id", "parameter_domain",
  "member_parameter_or_selector", "member_generator",
  "necessary_and_sufficient_membership_rule", "strategy_by_type",
  "weak_vote_strategy", "belief_system", "continuation_rule",
  "payoff_by_type_and_identity", "outcome_distribution", "atomic_binder",
  "source_ids_and_hashes", "selection_status", "refinement_status",
  "payoff_date", "proof_path"
)

agenda_required_image_fields <- c(
  "image_id", "source_family_record_id", "source_atomic_binder",
  "prior_and_type_weights", "type_values_at_A", "ex_ante_value_formula",
  "exact_image_set", "proof_path"
)

agenda_required_comparison_fields <- c(
  "comparison_id", "common_domain", "source_A_M_ids_and_hashes",
  "source_A_U_ids_and_hashes", "source_member_domains_and_binders",
  "necessary_and_sufficient_compatibility_rule",
  "source_value_transport_records", "exact_joint_value_and_outcome_set_at_A",
  "derived_envelopes", "proof_path"
)

agenda_required_transport_fields <- c(
  "source_record_id", "source_artifact_hash_if_external", "native_value",
  "native_date", "transport_factor_to_A", "beta_application_count",
  "transported_value_at_A"
)

agenda_private_record_fields <- c(
  "equilibrium_id", "strategy_profile", "belief_system",
  "source_continuation_record_ids", "source_interface_hashes",
  "hegemon_payoff_by_type", "outcome_distribution", "payoff_date"
)

agenda_public_record_fields <- c(
  "public_equilibrium_id", "institution", "round", "theta",
  "strategy_profile", "belief_system", "source_public_continuation_ids",
  "payoff_vector", "outcome_distribution", "payoff_date"
)

agenda_is_sha256 <- function(value) {
  is.character(value) && length(value) == 1L &&
    grepl("^[0-9a-f]{64}$", value)
}

agenda_nonempty_scalar <- function(value) {
  is.character(value) && length(value) == 1L && nzchar(value)
}

agenda_missing_fields <- function(object, required_fields) {
  if (!is.list(object) || is.null(names(object))) {
    return(required_fields)
  }
  setdiff(required_fields, names(object))
}

agenda_clone <- function(object) {
  unserialize(serialize(object, NULL))
}

agenda_sha256_file <- function(path) {
  if (!file.exists(path)) {
    return(NA_character_)
  }
  output <- suppressWarnings(system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    stderr = FALSE,
    env = c("LC_ALL=C", "LANG=C")
  ))
  status <- attr(output, "status")
  if (is.null(status)) status <- 0L
  if (status != 0L || length(output) != 1L) {
    return(NA_character_)
  }
  hash <- strsplit(trimws(output[[1L]]), "[[:space:]]+")[[1L]][[1L]]
  if (!agenda_is_sha256(hash)) NA_character_ else hash
}

agenda_sha256_git_snapshot <- function(repo_root, commit, path) {
  if (!grepl("^[0-9a-f]{40}$", commit)) {
    return(NA_character_)
  }
  temporary_path <- tempfile("agenda-extension-git-snapshot-")
  on.exit(unlink(temporary_path), add = TRUE)
  specification <- paste0(commit, ":", path)
  status <- suppressWarnings(system2(
    "git",
    c("-C", shQuote(repo_root), "show", shQuote(specification)),
    stdout = temporary_path,
    stderr = FALSE
  ))
  if (!identical(status, 0L)) {
    return(NA_character_)
  }
  agenda_sha256_file(temporary_path)
}

agenda_read_json <- function(path) {
  tryCatch(
    jsonlite::read_json(path, simplifyVector = FALSE),
    error = function(error) NULL
  )
}

agenda_has_payoff_sentinel <- function(object) {
  forbidden_strings <- c(
    "NA_PAYOFF", "PAYOFF_SENTINEL", "MISSING_PAYOFF", "UNDEFINED_PAYOFF",
    "-999", "-9999", "-99999"
  )
  recurse <- function(value, field_path = "") {
    if (is.list(value)) {
      child_names <- names(value)
      if (is.null(child_names)) child_names <- rep("", length(value))
      return(any(vapply(seq_along(value), function(index) {
        child_path <- paste(c(field_path, child_names[[index]]), collapse = ".")
        recurse(value[[index]], child_path)
      }, logical(1))))
    }
    payoff_field <- grepl("payoff|value", field_path, ignore.case = TRUE)
    if (!payoff_field || length(value) != 1L) {
      return(FALSE)
    }
    if (is.character(value)) {
      return(toupper(trimws(value)) %in% forbidden_strings)
    }
    is.numeric(value) && is.finite(value) && abs(value) >= 1e15
  }
  recurse(object)
}

agenda_validate_private_interface <- function(interface) {
  issues <- character()
  required_top <- c("schema_ref", "function_of", "correspondence_cells")
  missing_top <- agenda_missing_fields(interface, required_top)
  if (length(missing_top)) {
    return(c(issues, paste("missing top fields:", paste(missing_top, collapse = ", "))))
  }
  if (!identical(interface$schema_ref, "equilibrium_correspondence_v1")) {
    issues <- c(issues, "unexpected private interface schema_ref")
  }
  if (!identical(interface$function_of$name, "entry_belief") ||
      !identical(interface$function_of$domain, "[0,1]")) {
    issues <- c(issues, "private interface function_of is not entry_belief on [0,1]")
  }
  cells <- interface$correspondence_cells
  if (!is.list(cells) || !length(cells)) {
    return(c(issues, "private interface has no correspondence cells"))
  }
  cell_ids <- character()
  for (cell in cells) {
    required_cell <- c(
      "cell_id", "domain_conditions", "existence_status",
      "equilibrium_records", "nonexistence_certificate"
    )
    missing_cell <- agenda_missing_fields(cell, required_cell)
    if (length(missing_cell)) {
      issues <- c(issues, paste("private cell missing:", paste(missing_cell, collapse = ", ")))
      next
    }
    cell_ids <- c(cell_ids, cell$cell_id)
    if (!cell$existence_status %in% c("exists", "none")) {
      issues <- c(issues, paste("invalid existence_status in", cell$cell_id))
    } else if (identical(cell$existence_status, "exists")) {
      if (!is.list(cell$equilibrium_records) || !length(cell$equilibrium_records)) {
        issues <- c(issues, paste("exists cell has no record:", cell$cell_id))
      }
      if (!is.null(cell$nonexistence_certificate)) {
        issues <- c(issues, paste("exists cell has a nonexistence certificate:", cell$cell_id))
      }
      for (record in cell$equilibrium_records) {
        missing_record <- agenda_missing_fields(record, agenda_private_record_fields)
        if (length(missing_record)) {
          issues <- c(
            issues,
            paste(cell$cell_id, "record missing:", paste(missing_record, collapse = ", "))
          )
          next
        }
        if (!all(c("theta_0", "theta_1") %in% names(record$hegemon_payoff_by_type))) {
          issues <- c(issues, paste(cell$cell_id, "does not expose both H type payoffs"))
        }
        if (!all(c("failure", "delay") %in% names(record$outcome_distribution))) {
          issues <- c(issues, paste(cell$cell_id, "does not expose failure and delay outcomes"))
        }
        if (agenda_has_payoff_sentinel(record)) {
          issues <- c(issues, paste(cell$cell_id, "contains a payoff sentinel"))
        }
      }
    } else {
      if (length(cell$equilibrium_records)) {
        issues <- c(issues, paste("none cell contains equilibrium records:", cell$cell_id))
      }
      if (!is.list(cell$nonexistence_certificate) ||
          !length(cell$nonexistence_certificate)) {
        issues <- c(issues, paste("none cell lacks a certificate:", cell$cell_id))
      }
    }
  }
  if (anyDuplicated(cell_ids)) {
    issues <- c(issues, "private interface has duplicate cell IDs")
  }
  unique(issues)
}

agenda_public_cells <- function(interface) {
  cells <- list()
  for (institution in names(interface$public_equilibrium_cells)) {
    rounds <- interface$public_equilibrium_cells[[institution]]
    for (round_name in names(rounds)) {
      types <- rounds[[round_name]]
      for (type_name in names(types)) {
        for (cell in types[[type_name]]) {
          cells[[length(cells) + 1L]] <- list(
            institution = institution,
            round = round_name,
            type = type_name,
            cell = cell
          )
        }
      }
    }
  }
  cells
}

agenda_validate_public_interface <- function(interface) {
  issues <- character()
  required_top <- c(
    "schema_ref", "function_of", "public_equilibrium_cells",
    "informational_rent_cells", "informational_rent_contrast_cells"
  )
  missing_top <- agenda_missing_fields(interface, required_top)
  if (length(missing_top)) {
    return(c(issues, paste("missing top fields:", paste(missing_top, collapse = ", "))))
  }
  if (!identical(
    interface$schema_ref,
    "complete_information_benchmark_v1"
  )) {
    issues <- c(issues, "unexpected public interface schema_ref")
  }
  expected_institutions <- c("majority", "unanimity")
  if (!setequal(names(interface$public_equilibrium_cells), expected_institutions)) {
    issues <- c(issues, "public interface does not expose majority and unanimity")
  }
  cells <- agenda_public_cells(interface)
  if (!length(cells)) {
    return(c(issues, "public interface has no equilibrium cells"))
  }
  cell_ids <- character()
  for (entry in cells) {
    cell <- entry$cell
    required_cell <- c(
      "cell_id", "domain_conditions", "existence_status",
      "public_equilibrium_records", "nonexistence_certificate"
    )
    missing_cell <- agenda_missing_fields(cell, required_cell)
    if (length(missing_cell)) {
      issues <- c(issues, paste("public cell missing:", paste(missing_cell, collapse = ", ")))
      next
    }
    cell_ids <- c(cell_ids, cell$cell_id)
    if (!cell$existence_status %in% c("exists", "none")) {
      issues <- c(issues, paste("invalid public existence_status in", cell$cell_id))
      next
    }
    if (identical(cell$existence_status, "exists")) {
      if (!length(cell$public_equilibrium_records)) {
        issues <- c(issues, paste("public exists cell has no record:", cell$cell_id))
      }
      for (record in cell$public_equilibrium_records) {
        missing_record <- agenda_missing_fields(record, agenda_public_record_fields)
        if (length(missing_record)) {
          issues <- c(
            issues,
            paste(cell$cell_id, "public record missing:", paste(missing_record, collapse = ", "))
          )
          next
        }
        if (!identical(record$institution, entry$institution) ||
            !identical(record$round, entry$round)) {
          issues <- c(issues, paste(cell$cell_id, "record coordinates disagree with its cell"))
        }
        if (!"hegemon_payoff" %in% names(record$payoff_vector)) {
          issues <- c(issues, paste(cell$cell_id, "does not expose H payoff"))
        }
        if (agenda_has_payoff_sentinel(record)) {
          issues <- c(issues, paste(cell$cell_id, "contains a payoff sentinel"))
        }
      }
    } else if (!is.list(cell$nonexistence_certificate) ||
               !length(cell$nonexistence_certificate)) {
      issues <- c(issues, paste("public none cell lacks a certificate:", cell$cell_id))
    }
  }
  if (anyDuplicated(cell_ids)) {
    issues <- c(issues, "public interface has duplicate cell IDs")
  }
  unique(issues)
}

agenda_is_acyclic <- function(node_ids, edges) {
  if (!length(node_ids)) return(FALSE)
  internal_edges <- Filter(function(edge) {
    edge$from %in% node_ids && edge$to %in% node_ids
  }, edges)
  indegree <- stats::setNames(integer(length(node_ids)), node_ids)
  adjacency <- stats::setNames(vector("list", length(node_ids)), node_ids)
  for (edge in internal_edges) {
    indegree[[edge$to]] <- indegree[[edge$to]] + 1L
    adjacency[[edge$from]] <- c(adjacency[[edge$from]], edge$to)
  }
  queue <- names(indegree)[indegree == 0L]
  visited <- 0L
  while (length(queue)) {
    current <- queue[[1L]]
    queue <- queue[-1L]
    visited <- visited + 1L
    for (neighbor in adjacency[[current]]) {
      indegree[[neighbor]] <- indegree[[neighbor]] - 1L
      if (indegree[[neighbor]] == 0L) queue <- c(queue, neighbor)
    }
  }
  identical(visited, length(node_ids))
}

agenda_validate_dag <- function(dag) {
  issues <- character()
  required_top <- c(
    "schema_version", "namespace", "nodes", "external_inputs", "edges",
    "minimal_family_schema", "continuation_rule", "verifier_scope",
    "proof_obligations", "review_policy"
  )
  missing_top <- agenda_missing_fields(dag, required_top)
  if (length(missing_top)) {
    return(c(issues, paste("DAG missing:", paste(missing_top, collapse = ", "))))
  }
  if (!identical(dag$namespace, "agenda_extension")) {
    issues <- c(issues, "unexpected DAG namespace")
  }
  node_ids <- vapply(dag$nodes, function(node) node$node_id, character(1))
  expected_nodes <- c("A_M", "A_U", "AC", "AR")
  if (!setequal(node_ids, expected_nodes) || anyDuplicated(node_ids)) {
    issues <- c(issues, "DAG node inventory differs from A_M, A_U, AC, AR")
  }
  if (!all(vapply(dag$nodes, function(node) identical(node$status, "pending"), logical(1)))) {
    issues <- c(issues, "an extension node left pending during Goal 1")
  }
  forbidden_pass_fields <- c(
    "artifact_path", "artifact_hash", "dependency_hashes", "review_paths"
  )
  if (any(vapply(dag$nodes, function(node) {
    any(forbidden_pass_fields %in% names(node))
  }, logical(1)))) {
    issues <- c(issues, "a pending node contains pass-only lifecycle fields")
  }
  edge_keys <- vapply(dag$edges, function(edge) {
    paste(edge$from, edge$to, sep = " -> ")
  }, character(1))
  expected_edges <- c(
    "essential_input:C_M -> agenda_extension:A_M",
    "essential_input:C_U -> agenda_extension:A_U",
    "agenda_extension:A_M -> agenda_extension:AC",
    "agenda_extension:A_U -> agenda_extension:AC",
    "agenda_extension:AC -> agenda_extension:AR",
    "essential_input:N7_public -> agenda_extension:AR"
  )
  if (!setequal(edge_keys, expected_edges) || anyDuplicated(edge_keys)) {
    issues <- c(issues, "DAG edge inventory differs from the approved topology")
  }
  prefixed_nodes <- paste0("agenda_extension:", node_ids)
  if (!agenda_is_acyclic(prefixed_nodes, dag$edges)) {
    issues <- c(issues, "DAG contains a cycle")
  }
  required_family <- unlist(
    dag$minimal_family_schema$required_fields,
    use.names = FALSE
  )
  if (!identical(required_family, agenda_required_family_fields)) {
    issues <- c(issues, "DAG minimal family schema differs from the approved schema")
  }
  unique(issues)
}

agenda_vote_passes <- function(N, institution, weak_votes) {
  if (!is.numeric(N) || length(N) != 1L || N < 3 || N != floor(N)) {
    stop("N must be an integer at least 3.", call. = FALSE)
  }
  if (!institution %in% c("M", "U")) {
    stop("institution must be M or U.", call. = FALSE)
  }
  if (length(weak_votes) != N - 1L ||
      !all(weak_votes %in% c(0L, 1L, FALSE, TRUE))) {
    stop("weak_votes must contain N-1 binary votes.", call. = FALSE)
  }
  quota <- if (institution == "M") floor(N / 2) + 1L else N
  1L + sum(as.integer(weak_votes)) >= quota
}

agenda_validate_transport_record <- function(
    record,
    beta,
    container_hash,
    known_external_hashes,
    tolerance = 1e-12) {
  issues <- character()
  missing_fields <- agenda_missing_fields(record, agenda_required_transport_fields)
  if (length(missing_fields)) {
    return(paste("transport missing:", paste(missing_fields, collapse = ", ")))
  }
  if (!is.numeric(beta) || length(beta) != 1L || beta <= 0 || beta >= 1) {
    issues <- c(issues, "beta must be in (0,1)")
  }
  expected_count <- if (identical(record$native_date, "A")) {
    0L
  } else if (identical(record$native_date, "C")) {
    1L
  } else {
    issues <- c(issues, "native_date must be A or C")
    NA_integer_
  }
  expected_factor <- if (identical(record$native_date, "A")) 1 else beta
  if (!is.na(expected_count) &&
      !identical(as.integer(record$beta_application_count), expected_count)) {
    issues <- c(issues, "beta_application_count is not the unique permitted count")
  }
  if (!is.numeric(record$transport_factor_to_A) ||
      abs(record$transport_factor_to_A - expected_factor) > tolerance) {
    issues <- c(issues, "transport_factor_to_A is inconsistent with native_date")
  }
  if (!is.numeric(record$native_value) ||
      !is.numeric(record$transported_value_at_A) ||
      abs(
        record$transported_value_at_A -
          record$native_value * record$transport_factor_to_A
      ) > tolerance) {
    issues <- c(issues, "transported value does not equal native value times factor")
  }
  source_hash <- record$source_artifact_hash_if_external
  if (!is.null(source_hash) && length(source_hash) && nzchar(source_hash)) {
    source_hash <- sub("^sha256:", "", source_hash)
    if (!agenda_is_sha256(source_hash)) {
      issues <- c(issues, "external source hash is malformed")
    } else {
      if (identical(source_hash, sub("^sha256:", "", container_hash))) {
        issues <- c(issues, "external source hash is self-referential")
      }
      if (!source_hash %in% sub("^sha256:", "", known_external_hashes)) {
        issues <- c(issues, "external source hash is not pinned")
      }
    }
  }
  if (agenda_has_payoff_sentinel(record)) {
    issues <- c(issues, "transport record contains a payoff sentinel")
  }
  unique(issues)
}

agenda_validate_family_record <- function(record) {
  issues <- character()
  missing_fields <- agenda_missing_fields(record, agenda_required_family_fields)
  if (length(missing_fields)) {
    issues <- c(issues, paste("family missing:", paste(missing_fields, collapse = ", ")))
  }
  if (!length(missing_fields) && !agenda_nonempty_scalar(record$atomic_binder)) {
    issues <- c(issues, "family atomic_binder is empty")
  }
  if (!length(missing_fields) && !agenda_nonempty_scalar(record$proof_path)) {
    issues <- c(issues, "family proof_path is empty")
  }
  if (agenda_has_payoff_sentinel(record)) {
    issues <- c(issues, "family contains a payoff sentinel")
  }
  unique(issues)
}

agenda_validate_image_record <- function(record, family_index) {
  issues <- character()
  missing_fields <- agenda_missing_fields(record, agenda_required_image_fields)
  if (length(missing_fields)) {
    return(paste("image missing:", paste(missing_fields, collapse = ", ")))
  }
  family <- family_index[[record$source_family_record_id]]
  if (is.null(family)) {
    issues <- c(issues, "image cites an unknown family record")
  } else if (!identical(record$source_atomic_binder, family$atomic_binder)) {
    issues <- c(issues, "image binder does not match its source family")
  }
  if (!agenda_nonempty_scalar(record$proof_path)) {
    issues <- c(issues, "image proof_path is empty")
  }
  unique(issues)
}

agenda_validate_comparison_record <- function(record, family_index) {
  issues <- character()
  missing_fields <- agenda_missing_fields(record, agenda_required_comparison_fields)
  if (length(missing_fields)) {
    return(paste("comparison missing:", paste(missing_fields, collapse = ", ")))
  }
  bindings <- record$source_member_domains_and_binders
  if (!is.list(bindings) || length(bindings) < 2L) {
    issues <- c(issues, "comparison lacks both source member bindings")
  } else {
    for (binding in bindings) {
      required_binding <- c("family_record_id", "member_domain", "atomic_binder")
      missing_binding <- agenda_missing_fields(binding, required_binding)
      if (length(missing_binding)) {
        issues <- c(issues, paste("comparison binding missing:", paste(missing_binding, collapse = ", ")))
        next
      }
      family <- family_index[[binding$family_record_id]]
      if (is.null(family)) {
        issues <- c(issues, "comparison cites an unknown family record")
      } else if (!identical(binding$atomic_binder, family$atomic_binder)) {
        issues <- c(issues, "comparison binder does not match its source family")
      }
    }
  }
  if (!agenda_nonempty_scalar(record$proof_path)) {
    issues <- c(issues, "comparison proof_path is empty")
  }
  unique(issues)
}

agenda_validate_claim_row <- function(row) {
  issues <- character()
  missing_fields <- agenda_missing_fields(row, agenda_required_ledger_columns)
  if (length(missing_fields)) {
    return(paste("claim missing:", paste(missing_fields, collapse = ", ")))
  }
  allowed_status <- c(
    "proved", "checked numerically", "conjecture", "pending", "rejected"
  )
  allowed_kind <- c(
    "substantive", "D1", "intuitive_criterion", "integration", "coverage"
  )
  if (!row$status %in% allowed_status) issues <- c(issues, "invalid claim status")
  if (!row$claim_kind %in% allowed_kind) issues <- c(issues, "invalid claim kind")
  has_source <- agenda_nonempty_scalar(row$source_record_ids) &&
    agenda_nonempty_scalar(row$source_hashes)
  has_evidence <- agenda_nonempty_scalar(row$evidence_path)
  has_proof <- agenda_nonempty_scalar(row$proof_path)
  if (identical(row$status, "proved") && !has_proof) {
    issues <- c(issues, "proved claim lacks proof_path")
  }
  if (identical(row$status, "checked numerically") && !has_evidence) {
    issues <- c(issues, "numerically checked claim lacks evidence_path")
  }
  if (row$status %in% c("proved", "checked numerically") && !has_source) {
    issues <- c(issues, "completed claim lacks source IDs and hashes")
  }
  unique(issues)
}

agenda_identity_holds <- function(lhs, rhs, tolerance = 1e-12) {
  is.numeric(lhs) && is.numeric(rhs) && length(lhs) == 1L &&
    length(rhs) == 1L && is.finite(lhs) && is.finite(rhs) &&
    abs(lhs - rhs) <= tolerance
}

agenda_read_ledger_header <- function(path) {
  if (!file.exists(path)) return(character())
  lines <- readLines(path, n = 1L, warn = FALSE, encoding = "UTF-8")
  if (length(lines) != 1L) return(character())
  strsplit(lines[[1L]], "\t", fixed = TRUE)[[1L]]
}

agenda_make_check_table <- function() {
  data.frame(
    check_id = character(),
    status = character(),
    detail = character(),
    stringsAsFactors = FALSE
  )
}

agenda_add_check <- function(checks, check_id, condition, detail_pass, detail_fail) {
  rbind(
    checks,
    data.frame(
      check_id = check_id,
      status = if (isTRUE(condition)) "PASS" else "FAIL",
      detail = if (isTRUE(condition)) detail_pass else detail_fail,
      stringsAsFactors = FALSE
    )
  )
}

agenda_run_repository_checks <- function(
    repo_root,
    manifest_path = "model_redesign/agenda_extension_goal1_external_interfaces.json") {
  repo_root <- normalizePath(repo_root, mustWork = TRUE)
  absolute <- function(path) file.path(repo_root, path)
  checks <- agenda_make_check_table()
  absolute_manifest_path <- absolute(manifest_path)
  manifest <- agenda_read_json(absolute_manifest_path)
  checks <- agenda_add_check(
    checks, "manifest_json", !is.null(manifest),
    "Goal 1 interface manifest is valid JSON.",
    "Goal 1 interface manifest is missing or malformed."
  )
  if (is.null(manifest)) return(checks)
  checks <- agenda_add_check(
    checks, "manifest_exact_hash",
    identical(
      agenda_sha256_file(absolute_manifest_path),
      agenda_expected_manifest_sha256
    ),
    paste("Goal 1 interface manifest matches", agenda_expected_manifest_sha256),
    "Goal 1 interface manifest differs from the pinned Goal 1 snapshot."
  )

  required_manifest <- c(
    "schema_version", "goal_id", "status", "date", "hash_algorithm",
    "approved_gate_0_snapshot", "normative_sources",
    "upstream_dependency_snapshots", "external_interfaces", "scope_limits"
  )
  missing_manifest <- agenda_missing_fields(manifest, required_manifest)
  checks <- agenda_add_check(
    checks, "manifest_schema", !length(missing_manifest),
    "Manifest has every required top-level field.",
    paste("Manifest missing:", paste(missing_manifest, collapse = ", "))
  )
  checks <- agenda_add_check(
    checks, "manifest_scope", identical(manifest$goal_id, "agenda_extension_goal_1") &&
      grepl("no A_M", manifest$authorization_scope, fixed = TRUE) &&
      length(manifest$scope_limits) == 3L,
    "Manifest states the Goal 1 boundary and the verifier's non-claims.",
    "Manifest does not state the approved Goal 1 boundary completely."
  )

  check_artifact_group <- function(checks, group, prefix) {
    for (entry in group) {
      path <- absolute(entry$path)
      actual <- agenda_sha256_file(path)
      ok <- file.exists(path) && agenda_is_sha256(entry$sha256) &&
        identical(actual, entry$sha256)
      checks <- agenda_add_check(
        checks,
        paste0(prefix, "_", entry[[1L]]),
        ok,
        paste(entry$path, "matches", entry$sha256),
        paste(entry$path, "is missing or differs from", entry$sha256)
      )
    }
    checks
  }
  checks <- check_artifact_group(
    checks, manifest$approved_gate_0_snapshot, "gate0_hash"
  )
  checks <- check_artifact_group(
    checks, manifest$normative_sources, "normative_hash"
  )

  for (entry in manifest$upstream_dependency_snapshots) {
    actual <- if (identical(entry$resolution, "working_tree")) {
      agenda_sha256_file(absolute(entry$path))
    } else if (identical(entry$resolution, "git_snapshot")) {
      agenda_sha256_git_snapshot(repo_root, entry$git_commit, entry$path)
    } else {
      NA_character_
    }
    checks <- agenda_add_check(
      checks,
      paste0("upstream_snapshot_", entry$source_id),
      identical(actual, entry$sha256),
      paste(entry$source_id, "resolves to", entry$sha256, "via", entry$resolution),
      paste(entry$source_id, "does not resolve to its declared snapshot")
    )
  }

  interface_ids <- vapply(
    manifest$external_interfaces,
    function(entry) entry$input_id,
    character(1)
  )
  checks <- agenda_add_check(
    checks, "external_interface_inventory",
    setequal(interface_ids, c("C_M", "C_U", "N7_public")) &&
      !anyDuplicated(interface_ids),
    "The manifest pins C_M, C_U, and N7_public exactly once.",
    "External interface inventory is incomplete or duplicated."
  )

  interface_objects <- list()
  for (entry in manifest$external_interfaces) {
    path <- absolute(entry$path)
    actual_hash <- agenda_sha256_file(path)
    interface <- agenda_read_json(path)
    interface_objects[[entry$input_id]] <- interface
    checks <- agenda_add_check(
      checks,
      paste0("external_hash_", entry$input_id),
      identical(actual_hash, entry$sha256),
      paste(entry$input_id, "matches", entry$sha256),
      paste(entry$input_id, "is missing or differs from its pinned hash")
    )
    issues <- if (identical(entry$input_id, "N7_public")) {
      agenda_validate_public_interface(interface)
    } else {
      agenda_validate_private_interface(interface)
    }
    checks <- agenda_add_check(
      checks,
      paste0("consumability_", entry$input_id),
      !length(issues) && identical(entry$audit_status, "consumable_without_edit"),
      paste(entry$input_id, "is structurally consumable without editing its frozen bytes."),
      paste(entry$input_id, "issues:", paste(issues, collapse = "; "))
    )
  }

  dag <- agenda_read_json(absolute(
    "model_redesign/agenda_extension_game_dag_simplified.json"
  ))
  dag_issues <- if (is.null(dag)) "DAG JSON is malformed" else agenda_validate_dag(dag)
  checks <- agenda_add_check(
    checks, "dag_schema_topology_acyclicity", !length(dag_issues),
    "DAG namespace, nodes, edges, pending lifecycle, schemas, and acyclicity pass.",
    paste("DAG issues:", paste(dag_issues, collapse = "; "))
  )

  if (!is.null(dag)) {
    dag_external <- stats::setNames(
      vapply(dag$external_inputs, function(entry) entry$path, character(1)),
      vapply(dag$external_inputs, function(entry) entry$input_id, character(1))
    )
    manifest_external <- stats::setNames(
      vapply(manifest$external_interfaces, function(entry) entry$path, character(1)),
      interface_ids
    )
    checks <- agenda_add_check(
      checks, "dag_manifest_external_paths",
      identical(dag_external[sort(names(dag_external))],
                manifest_external[sort(names(manifest_external))]),
      "DAG external paths and pinned manifest paths agree.",
      "DAG external paths differ from the Goal 1 manifest."
    )
  }

  ledger_paths <- vapply(
    dag$nodes,
    function(node) node$claim_ledger,
    character(1)
  )
  ledger_headers_ok <- all(vapply(ledger_paths, function(path) {
    identical(agenda_read_ledger_header(absolute(path)), agenda_required_ledger_columns)
  }, logical(1)))
  checks <- agenda_add_check(
    checks, "empty_ledger_schemas", ledger_headers_ok,
    "All four empty ledgers have the approved 16-column header.",
    "At least one empty ledger header differs from the approved schema."
  )

  vote_checks <- logical()
  for (N in 3:7) {
    grids <- expand.grid(rep(list(c(0L, 1L)), N - 1L))
    for (institution in c("M", "U")) {
      for (row_index in seq_len(nrow(grids))) {
        votes <- as.integer(grids[row_index, , drop = TRUE])
        quota <- if (institution == "M") floor(N / 2) + 1L else N
        expected <- 1L + sum(votes) >= quota
        vote_checks <- c(
          vote_checks,
          identical(agenda_vote_passes(N, institution, votes), expected)
        )
      }
    }
  }
  checks <- agenda_add_check(
    checks, "finite_vote_transitions", all(vote_checks),
    "Every weak-vote vector for N=3,...,7 matches q_M and q_U with H's automatic yes.",
    "A finite weak-vote transition disagrees with the approved quota."
  )

  beta <- 0.9
  known_hashes <- vapply(
    manifest$external_interfaces,
    function(entry) entry$sha256,
    character(1)
  )
  transport_A <- list(
    source_record_id = "INTERNAL-1",
    source_artifact_hash_if_external = "",
    native_value = 0.4,
    native_date = "A",
    transport_factor_to_A = 1,
    beta_application_count = 0L,
    transported_value_at_A = 0.4
  )
  transport_C <- list(
    source_record_id = "C-M-1",
    source_artifact_hash_if_external = paste0("sha256:", known_hashes[[1L]]),
    native_value = 0.4,
    native_date = "C",
    transport_factor_to_A = beta,
    beta_application_count = 1L,
    transported_value_at_A = 0.36
  )
  transport_ok <- !length(agenda_validate_transport_record(
    transport_A, beta, paste(rep("0", 64), collapse = ""), known_hashes
  )) && !length(agenda_validate_transport_record(
    transport_C, beta, paste(rep("0", 64), collapse = ""), known_hashes
  ))
  checks <- agenda_add_check(
    checks, "date_and_beta_transport_examples", transport_ok,
    "Agreement at A is undiscounted and C-to-A transport applies beta exactly once.",
    "A representative date or beta transport record failed."
  )

  checks <- agenda_add_check(
    checks, "supplied_algebraic_identities",
    agenda_identity_holds(0.4 * beta, 0.36) &&
      agenda_identity_holds(floor(5 / 2) + 1, 3),
    "Supplied finite algebraic identities pass.",
    "A supplied finite algebraic identity failed."
  )

  checks
}
