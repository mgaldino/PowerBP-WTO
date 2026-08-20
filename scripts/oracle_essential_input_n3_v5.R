#!/usr/bin/env Rscript

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("The independent semantic evaluator requires jsonlite.", call. = FALSE)
}

ov5_assert <- function(condition, message) {
  valid <- length(condition) == 1L && !is.na(condition) && condition
  if (!valid) stop(message, call. = FALSE)
}

ov5_sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    stderr = FALSE,
    env = "LC_ALL=C"
  )
  ov5_assert(length(output) == 1L, paste("Could not hash", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  ov5_assert(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

ov5_child_path <- function(parent, name, index) {
  if (!is.null(name) && nzchar(name)) {
    if (identical(parent, "$")) paste0("$", name) else paste0(parent, "$", name)
  } else {
    paste0(parent, "[[", index, "]]")
  }
}

ov5_leaf_entries <- function(object, path = "$", keys = list()) {
  if (is.null(object)) {
    return(list(list(path = path, keys = keys, type = "NULL", value = NULL)))
  }
  if (is.list(object)) {
    if (length(object) == 0L) {
      return(list(list(path = path, keys = keys, type = "empty-list", value = list())))
    }
    result <- list()
    object_names <- names(object)
    for (index in seq_along(object)) {
      child_name <- if (is.null(object_names)) NULL else object_names[[index]]
      child_key <- if (is.null(child_name) || !nzchar(child_name)) index else child_name
      result <- c(
        result,
        ov5_leaf_entries(
          object[[index]],
          ov5_child_path(path, child_name, index),
          c(keys, list(child_key))
        )
      )
    }
    return(result)
  }
  if (length(object) > 1L) {
    result <- list()
    for (index in seq_along(object)) {
      result <- c(
        result,
        ov5_leaf_entries(object[[index]], paste0(path, "[[", index, "]]"), c(keys, list(index)))
      )
    }
    return(result)
  }
  list(list(path = path, keys = keys, type = typeof(object), value = object))
}

ov5_new_context <- function(object) {
  entries <- ov5_leaf_entries(object)
  paths <- vapply(entries, function(entry) entry$path, character(1))
  ov5_assert(length(unique(paths)) == length(paths), "Atomic paths are not unique.")
  context <- new.env(parent = emptyenv())
  context$all_paths <- paths
  context$validated_paths <- character(0)
  context
}

ov5_mark <- function(context, object, path) {
  paths <- vapply(ov5_leaf_entries(object, path), function(entry) entry$path, character(1))
  context$validated_paths <- union(context$validated_paths, paths)
  invisible(TRUE)
}

ov5_finish_coverage <- function(context, label) {
  missing <- setdiff(context$all_paths, context$validated_paths)
  spurious <- setdiff(context$validated_paths, context$all_paths)
  ov5_assert(
    length(missing) == 0L && length(spurious) == 0L,
    paste(
      label,
      "semantic coverage mismatch; missing:",
      paste(missing, collapse = ", "),
      "spurious:",
      paste(spurious, collapse = ", ")
    )
  )
  length(context$all_paths)
}

ov5_require_text <- function(text, required, label, forbidden = character(0)) {
  ov5_assert(is.character(text) && length(text) == 1L && nzchar(text), paste(label, "is not text."))
  missing <- required[!vapply(required, function(token) grepl(token, text, fixed = TRUE), logical(1))]
  present_forbidden <- forbidden[vapply(
    forbidden,
    function(token) grepl(token, text, fixed = TRUE),
    logical(1)
  )]
  ov5_assert(
    length(missing) == 0L && length(present_forbidden) == 0L,
    paste(
      label,
      "failed semantic tokens; missing:",
      paste(missing, collapse = " | "),
      "forbidden:",
      paste(present_forbidden, collapse = " | ")
    )
  )
  invisible(TRUE)
}

ov5_scalar <- function(value, expected, label) {
  ov5_assert(identical(value, expected), paste(label, "has an invalid scalar value."))
  invisible(TRUE)
}

ov5_formula_ast <- function(text, symbols = c("beta", "m", "q", "nu", "o_0", "o_1", "r_i")) {
  ov5_assert(is.character(text) && length(text) == 1L, "Formula is not a scalar string.")
  expression <- try(parse(text = text, keep.source = FALSE)[[1L]], silent = TRUE)
  ov5_assert(!inherits(expression, "try-error"), paste("Formula does not parse:", text))
  walk <- function(node) {
    if (is.numeric(node) || is.integer(node)) return(invisible(TRUE))
    if (is.name(node)) {
      ov5_assert(as.character(node) %in% symbols, paste("Formula uses unauthorized symbol:", as.character(node)))
      return(invisible(TRUE))
    }
    ov5_assert(is.call(node), paste("Formula has unauthorized AST node:", text))
    operator <- as.character(node[[1L]])
    ov5_assert(operator %in% c("+", "-", "*", "/", "("), paste("Formula uses unauthorized operator:", operator))
    if (length(node) > 1L) {
      for (index in 2:length(node)) walk(node[[index]])
    }
    invisible(TRUE)
  }
  walk(expression)
  expression
}

ov5_formula_fixtures <- function() {
  list(
    list(beta = 0.21, m = 2, q = 2, nu = 0, o_0 = 0.07, o_1 = 0.31, r_i = 0.43),
    list(beta = 0.64, m = 4, q = 3, nu = 0.29, o_0 = 0.04, o_1 = 0.18, r_i = 0.37),
    list(beta = 0.83, m = 8, q = 5, nu = 0.71, o_0 = 0.03, o_1 = 0.12, r_i = 0.22),
    list(beta = 0.97, m = 12, q = 7, nu = 1, o_0 = 0.02, o_1 = 0.09, r_i = 0.51)
  )
}

ov5_eval_formula <- function(expression, values) {
  environment <- list2env(values, parent = baseenv())
  value <- eval(expression, envir = environment)
  ov5_assert(is.numeric(value) && length(value) == 1L && is.finite(value), "Formula did not evaluate to a finite scalar.")
  as.numeric(value)
}

ov5_assert_formula <- function(text, expected_function, label, fixtures = ov5_formula_fixtures()) {
  expression <- ov5_formula_ast(text)
  for (values in fixtures) {
    actual <- ov5_eval_formula(expression, values)
    expected <- expected_function(values)
    ov5_assert(
      is.numeric(expected) && length(expected) == 1L && is.finite(expected) &&
        abs(actual - expected) <= 1e-12,
      paste(label, "fails independent numeric evaluation.")
    )
  }
  invisible(TRUE)
}

ov5_values <- function(values) {
  with(values, {
    continuation <- beta / m
    exclusion <- 1 - beta * (q - 1) / m
    low_pass <- 1 - beta * o_0 - beta * (q - 2) / m
    pooling <- 1 - beta * o_1 - beta * (q - 2) / m
    screening <- (1 - nu) * low_pass + nu * continuation
    list(c = continuation, E = exclusion, L = low_pass, S = screening, P = pooling, R = continuation)
  })
}

ov5_nu_sp <- function(values) {
  with(values, beta * (o_1 - o_0) / (1 - beta * o_0 - beta * (q - 1) / m))
}

ov5_nu_se <- function(values) {
  with(values, beta * (1 / m - o_0) / (beta * (1 / m - o_0) + 1 - beta * q / m))
}

ov5_validate_n1 <- function(n1, n1_hash, n1_path = NULL) {
  if (!is.null(n1_path)) {
    ov5_assert(
      identical(ov5_sha256_file(n1_path), sub("^sha256:", "", n1_hash)),
      "Semantic evaluator received bytes other than frozen N1."
    )
  }
  ov5_scalar(n1$schema_ref, "equilibrium_correspondence_v1", "N1 schema")
  ov5_assert(length(n1$correspondence_cells) == 1L, "N1 must be singleton.")
  record <- n1$correspondence_cells[[1L]]$equilibrium_records[[1L]]
  ov5_scalar(record$equilibrium_id, "N1-EQ-01", "N1 equilibrium id")
  ov5_scalar(record$recognized_proposer_payoff, "1", "N1 proposer payoff")
  ov5_scalar(record$weak_nonproposer_pre_recognition_expected_value, "1/m", "N1 weak payoff")
  ov5_scalar(record$hegemon_payoff_by_type$theta_0, "o_0", "N1 H low payoff")
  ov5_scalar(record$hegemon_payoff_by_type$theta_1, "o_1", "N1 H high payoff")
  ov5_scalar(record$outcome_distribution$pass_with_hegemon, 0L, "N1 pass-with-H")
  ov5_scalar(record$outcome_distribution$pass_without_hegemon, 1L, "N1 pass-without-H")
  ov5_scalar(record$outcome_distribution$failure, 0L, "N1 failure")
  ov5_scalar(record$outcome_distribution$delay, 0L, "N1 delay")
  ov5_scalar(record$payoff_date, "R2 current units", "N1 payoff date")
  invisible(TRUE)
}

ov5_cell_specs <- function() {
  list(
    list(id = "N3V5-CELL-O1LT-LOW", eq = "N3V5-EQ-O1LT-LOW", branch = "low", region = c("o1_lt", "nu_le_sp"), class = c("low-type-only", "high type delays", "S/P payoff equality")),
    list(id = "N3V5-CELL-O1LT-POOL", eq = "N3V5-EQ-O1LT-POOL", branch = "pool", region = c("o1_lt", "nu_gt_sp"), class = c("pooling", "R1 passage with H")),
    list(id = "N3V5-CELL-CROSS-LOW", eq = "N3V5-EQ-CROSS-LOW", branch = "low", region = c("cross", "nu_le_se"), class = c("low-type-only", "high type delays", "S/E payoff equality")),
    list(id = "N3V5-CELL-CROSS-EXCLUDE", eq = "N3V5-EQ-CROSS-EXCLUDE", branch = "exclude", region = c("cross", "nu_gt_se"), class = c("without H", "y=0")),
    list(id = "N3V5-CELL-O0GT-EXCLUDE", eq = "N3V5-EQ-O0GT-EXCLUDE", branch = "exclude", region = c("o0_gt", "all_nu"), class = c("without H", "y=0")),
    list(id = "N3V5-CELL-O0EQ-LOW-ENDPOINT", eq = "N3V5-EQ-O0EQ-LOW-ENDPOINT", branch = "low", region = c("o0_eq", "nu_zero"), class = c("low-type-only endpoint", "ties exclusion", "tie-break")),
    list(id = "N3V5-CELL-O0EQ-EXCLUDE", eq = "N3V5-EQ-O0EQ-EXCLUDE", branch = "exclude", region = c("o0_eq", "nu_positive"), class = c("without H", "y=0")),
    list(id = "N3V5-CELL-O1EQ-LOW", eq = "N3V5-EQ-O1EQ-LOW", branch = "low", region = c("o1_eq", "nu_le_se"), class = c("low-type-only", "high type delays", "S/(E=P) equality")),
    list(id = "N3V5-CELL-O1EQ-EXCLUDE", eq = "N3V5-EQ-O1EQ-EXCLUDE", branch = "exclude", region = c("o1_eq", "nu_gt_se", "he_lt_hp"), class = c("E=P", "exclusion", "minimizes expected H")),
    list(id = "N3V5-CELL-O1EQ-POOL", eq = "N3V5-EQ-O1EQ-POOL", branch = "pool", region = c("o1_eq", "nu_gt_se", "hp_lt_he"), class = c("E=P", "pooling", "minimizes expected H")),
    list(id = "N3V5-CELL-O1EQ-MIXED-EP", eq = "N3V5-EQ-O1EQ-MIXED-EP", branch = "mixed_ep", region = c("o1_eq", "nu_gt_se", "he_eq_hp"), class = c("E=P", "expected-H tie", "every pure proposer-identity assignment", "every proposer mixture"))
  )
}

ov5_claim_specs <- function() {
  branches <- c(
    "continuation", "weak ballot", "H ballot", "proposer deviations",
    "candidate reduction", "P0", "P1 and P1a", "delay", "feasibility",
    "partition", "o_1=1/m", "multiplicity", "beliefs", "P7",
    "weak payoff map", "transport sufficiency", "existence"
  )
  tokens <- list(
    c("N1-EQ-01", "1/m", "o_theta", "exactly once"),
    c("weak nonproposer", "x_j>=beta/m", "T^Y", "equality"),
    c("complete best-response", "nonpivotal", "pivotal", "inevitable failure"),
    c("proposer-payoff map", "every feasible proposal", "true prior"),
    c("exclusion", "low-type-only", "pooling", "deliberate failure"),
    c("exhausts the pie", "belief-invariant response", "no on-path slack"),
    c("pass-without-H", "y>0", "shifting y to r_i", "y=0"),
    c("beta/m", "1-beta*q/m>0", "screening delay", "probability nu"),
    c("low-type-only", "pooling", "exclusion", "strictly feasible"),
    c("eleven cells", "mutually exclusive", "exhaustive", "endpoint"),
    c("E=P", "expected-H comparison", "every mixture", "exact equality"),
    c("coalition identities", "pure proposer-identity", "mixtures", "without a symmetry restriction"),
    c("Bayes", "zero-prior", "zero-probability proposal-vote vector", "every nu"),
    c("public H vote", "posterior update", "weak votes", "type-independent"),
    c("identity-indexed", "pre-recognition weak payoff map"),
    c("admissibility_conditions", "selection_status", "hegemon_payoff_by_type", "outcome_distribution"),
    c("equilibrium exists", "declared domain", "no nonexistence cell", "beta in (0,1)")
  )
  lapply(seq_len(17L), function(index) {
    list(id = sprintf("N3V5-C%02d", index), branch = branches[[index]], tokens = tokens[[index]])
  })
}

ov5_validate_common_domain <- function(values, context, base_path, n1_hash) {
  ov5_assert(is.list(values) && length(values) >= 8L, paste(base_path, "does not contain the common domain."))
  checks <- list(
    list(tokens = c("nu", "Pr(theta=1)", "0 <= nu <= 1"), forbidden = c("nu < 0", "nu > 1")),
    list(tokens = c("N", "integer", "N >= 3"), forbidden = c("N >= 2")),
    list(tokens = c("W", "m=N-1", "|W|=m"), forbidden = character(0)),
    list(tokens = c("q=floor(N/2)+1", "q<=m"), forbidden = c("q>m")),
    list(tokens = c("0 < beta < 1"), forbidden = c("beta=1", "beta <= 1")),
    list(tokens = c("0 < o_0 < o_1 < 1", "o_1 <= y_bar <= 1"), forbidden = c("o_1=1")),
    list(tokens = c("0<=y<=y_bar", "x_j>=0", "r_i>=0", "y+sum_j x_j+r_i<=1"), forbidden = c("<=2")),
    list(tokens = c("sole continuation", "N1-EQ-01", n1_hash), forbidden = c("N2-EQ"))
  )
  for (index in seq_len(8L)) {
    ov5_require_text(
      values[[index]],
      checks[[index]]$tokens,
      paste(base_path, "common-domain item", index),
      checks[[index]]$forbidden
    )
    ov5_mark(context, values[[index]], paste0(base_path, "[[", index, "]]"))
  }
  invisible(TRUE)
}

ov5_frontier_fixtures <- function() {
  list(
    list(beta = 0.72, m = 8, q = 5, nu = 0.2, o_0 = 0.03, o_1 = 0.08, r_i = 0.4),
    list(beta = 0.86, m = 12, q = 7, nu = 0.6, o_0 = 0.02, o_1 = 0.06, r_i = 0.2),
    list(beta = 0.55, m = 4, q = 3, nu = 0.4, o_0 = 0.05, o_1 = 0.16, r_i = 0.3)
  )
}

ov5_extract_prefix_formula <- function(text, prefix, suffix, label) {
  ov5_assert(startsWith(text, prefix) && endsWith(text, suffix), paste(label, "has wrong boundary syntax."))
  substring(text, nchar(prefix) + 1L, nchar(text) - nchar(suffix))
}

ov5_validate_region_condition <- function(text, tag, label) {
  if (identical(tag, "o1_lt")) {
    ov5_scalar(text, "o_1<1/m", label)
  } else if (identical(tag, "cross")) {
    ov5_scalar(text, "o_0<1/m<o_1", label)
  } else if (identical(tag, "o0_gt")) {
    ov5_scalar(text, "1/m<o_0<o_1", label)
  } else if (identical(tag, "o0_eq")) {
    ov5_scalar(text, "o_0=1/m<o_1", label)
  } else if (identical(tag, "o1_eq")) {
    ov5_scalar(text, "o_0<o_1=1/m", label)
  } else if (identical(tag, "all_nu")) {
    ov5_scalar(text, "0<=nu<=1", label)
  } else if (identical(tag, "nu_zero")) {
    ov5_scalar(text, "nu=0", label)
  } else if (identical(tag, "nu_positive")) {
    ov5_scalar(text, "0<nu<=1", label)
  } else if (tag %in% c("nu_le_sp", "nu_gt_sp", "nu_le_se", "nu_gt_se")) {
    is_lower <- startsWith(tag, "nu_le")
    formula <- if (is_lower) {
      ov5_extract_prefix_formula(text, "0<=nu<=", "", label)
    } else {
      ov5_extract_prefix_formula(text, "", "<nu<=1", label)
    }
    expected <- if (endsWith(tag, "sp")) ov5_nu_sp else ov5_nu_se
    ov5_assert_formula(formula, expected, label, ov5_frontier_fixtures())
  } else if (tag %in% c("he_lt_hp", "hp_lt_he", "he_eq_hp")) {
    operator <- if (identical(tag, "he_eq_hp")) "=" else "<"
    parts <- strsplit(text, operator, fixed = TRUE)[[1L]]
    ov5_assert(length(parts) == 2L, paste(label, "does not expose both H-payoff sides."))
    expected_left <- if (identical(tag, "hp_lt_he")) {
      function(values) values$beta / values$m
    } else {
      function(values) (1 - values$nu) * values$o_0 + values$nu / values$m
    }
    expected_right <- if (identical(tag, "hp_lt_he")) {
      function(values) (1 - values$nu) * values$o_0 + values$nu / values$m
    } else {
      function(values) values$beta / values$m
    }
    ov5_assert_formula(parts[[1L]], expected_left, paste(label, "left side"), ov5_frontier_fixtures())
    ov5_assert_formula(parts[[2L]], expected_right, paste(label, "right side"), ov5_frontier_fixtures())
  } else {
    stop(paste("Unknown region tag", tag), call. = FALSE)
  }
  invisible(TRUE)
}

ov5_validate_region <- function(values, region_tags, context, base_path) {
  ov5_assert(length(values) == length(region_tags), paste(base_path, "has wrong region-condition count."))
  for (index in seq_along(region_tags)) {
    ov5_validate_region_condition(values[[index]], region_tags[[index]], paste(base_path, region_tags[[index]]))
    ov5_mark(context, values[[index]], paste0(base_path, "[[", index, "]]"))
  }
  invisible(TRUE)
}

ov5_validate_weight_condition <- function(text, branch, label) {
  if (branch %in% c("low", "pool")) {
    ov5_require_text(
      text,
      c("omega_{i,K}>=0", "K subset W\\{i}", "|K|=q-2", "sum_K omega_{i,K}=1", "may differ by i"),
      label,
      c("|K|=q-1", "symmetric")
    )
  } else if (identical(branch, "exclude")) {
    ov5_require_text(
      text,
      c("omega_{i,K}>=0", "K subset W\\{i}", "|K|=q-1", "sum_K omega_{i,K}=1", "may differ by i"),
      label,
      c("symmetric")
    )
  } else {
    ov5_require_text(
      text,
      c("e_{i,K}>=0", "|K|=q-1", "p_{i,T}>=0", "|T|=q-2", "sum_K e_{i,K}+sum_T p_{i,T}=1", "independently for each i"),
      label,
      c("symmetric")
    )
  }
  invisible(TRUE)
}

ov5_validate_admissibility <- function(values, spec, context, base_path, n1_hash) {
  expected_length <- 8L + length(spec$region) + 3L
  ov5_assert(length(values) == expected_length, paste(base_path, "has wrong admissibility length."))
  ov5_validate_common_domain(values[seq_len(8L)], context, base_path, n1_hash)
  region_indices <- 8L + seq_along(spec$region)
  region_values <- values[region_indices]
  region_path <- paste0(base_path, "-region")
  for (index in seq_along(spec$region)) {
    actual_index <- region_indices[[index]]
    ov5_validate_region_condition(
      region_values[[index]],
      spec$region[[index]],
      paste(base_path, "region", spec$region[[index]])
    )
    ov5_mark(context, region_values[[index]], paste0(base_path, "[[", actual_index, "]]"))
  }
  extra_start <- 8L + length(spec$region)
  weight_index <- extra_start + 1L
  ballot_index <- extra_start + 2L
  outcome_index <- extra_start + 3L
  ov5_validate_weight_condition(values[[weight_index]], spec$branch, paste(base_path, "weight condition"))
  ov5_mark(context, values[[weight_index]], paste0(base_path, "[[", weight_index, "]]"))
  ov5_require_text(
    values[[ballot_index]],
    c("ballot actions are pure", "only the weak proposer's proposal may be mixed", "finite weights"),
    paste(base_path, "ballot/proposal mixing condition")
  )
  ov5_mark(context, values[[ballot_index]], paste0(base_path, "[[", ballot_index, "]]"))
  ov5_require_text(
    values[[outcome_index]],
    c("four outcome coordinates partition", "delay records R1 failure followed by N1", "failure records terminal failure"),
    paste(base_path, "outcome partition condition")
  )
  ov5_mark(context, values[[outcome_index]], paste0(base_path, "[[", outcome_index, "]]"))
  invisible(region_path)
}

ov5_validate_frozen_continuation <- function(object, context, path, n1_hash) {
  ov5_assert(
    identical(
      names(object),
      c(
        "source", "weak_value_in_R2_current_units", "hegemon_value_in_R2_current_units",
        "transport_to_R1", "posterior_invariance"
      )
    ),
    "Frozen-continuation fields changed."
  )
  ov5_require_text(object$source, c("N1-EQ-01", n1_hash), "Frozen continuation source")
  ov5_assert_formula(object$weak_value_in_R2_current_units, function(values) 1 / values$m, "N1 weak continuation")
  ov5_assert(
    identical(names(object$hegemon_value_in_R2_current_units), c("theta_0", "theta_1")),
    "Typed N1 H continuation fields changed."
  )
  ov5_assert_formula(object$hegemon_value_in_R2_current_units$theta_0, function(values) values$o_0, "N1 H theta0 continuation")
  ov5_assert_formula(object$hegemon_value_in_R2_current_units$theta_1, function(values) values$o_1, "N1 H theta1 continuation")
  ov5_require_text(
    object$transport_to_R1,
    c("weak continuation beta/m", "H continuation beta*o_theta", "discounted exactly once"),
    "R1 transport",
    c("beta^2", "twice")
  )
  ov5_require_text(
    object$posterior_invariance,
    c("N1-EQ-01", "same record", "every R2 entry posterior in [0,1]"),
    "N1 posterior invariance"
  )
  ov5_mark(context, object, path)
  invisible(TRUE)
}

ov5_validate_ballot_map <- function(object, context, path) {
  expected_names <- c(
    "definitions", "weak_nonproposer_j", "hegemon_if_k_at_least_q_minus_1",
    "hegemon_if_k_equals_q_minus_2", "hegemon_if_k_at_most_q_minus_3"
  )
  ov5_assert(identical(names(object), expected_names), "Complete ballot-map fields changed.")
  ov5_require_text(
    object$definitions,
    c("K_i(s)", "x_j>=beta/m", "k_i(s)=|K_i(s)|", "W\\{i}"),
    "Ballot definitions"
  )
  ov5_require_text(
    object$weak_nonproposer_j,
    c("vote yes iff x_j>=beta/m", "at equality T^Y selects yes"),
    "Weak ballot rule",
    c("x_j>=0", "vote no iff x_j>=beta/m")
  )
  ov5_require_text(
    object$hegemon_if_k_at_least_q_minus_1,
    c("both types vote no", "passage is independent of H", "no pays y+o_theta>y"),
    "Nonpivotal H ballot",
    c("vote yes", "no pays o_theta")
  )
  ov5_require_text(
    object$hegemon_if_k_equals_q_minus_2,
    c("type theta votes yes iff y>=beta*o_theta", "T^Y selects yes at equality"),
    "Pivotal H ballot",
    c("y>=o_theta", "beta^2")
  )
  ov5_require_text(
    object$hegemon_if_k_at_most_q_minus_3,
    c("both types vote yes by T^Y", "either H action", "posterior-invariant N1 continuation"),
    "Inevitable-failure H ballot",
    c("both types vote no")
  )
  ov5_mark(context, object, path)
  invisible(TRUE)
}

ov5_validate_proposer_map <- function(object, context, path) {
  expected_names <- c(
    "if_k_at_least_q_minus_1",
    "if_k_equals_q_minus_2_and_y_below_beta_o0",
    "if_k_equals_q_minus_2_and_beta_o0_at_most_y_below_beta_o1",
    "if_k_equals_q_minus_2_and_y_at_least_beta_o1",
    "if_k_at_most_q_minus_3"
  )
  ov5_assert(identical(names(object), expected_names), "Complete proposer-payoff map fields changed.")
  expected_functions <- list(
    function(values) values$r_i,
    function(values) values$beta / values$m,
    function(values) (1 - values$nu) * values$r_i + values$nu * values$beta / values$m,
    function(values) values$r_i,
    function(values) values$beta / values$m
  )
  for (index in seq_along(expected_names)) {
    ov5_assert_formula(
      object[[expected_names[[index]]]],
      expected_functions[[index]],
      paste("Proposer payoff case", expected_names[[index]])
    )
  }
  ov5_mark(context, object, path)
  invisible(TRUE)
}

ov5_validate_candidate_payoffs <- function(object, context, path) {
  expected_names <- c(
    "exclusion", "low_type_only", "pooling", "deliberate_failure",
    "exclusion_minus_deliberate_failure", "pooling_minus_exclusion",
    "low_type_only_minus_exclusion"
  )
  ov5_assert(identical(names(object), expected_names), "E/S/P/R payoff-map fields changed.")
  expected_functions <- list(
    function(values) ov5_values(values)$E,
    function(values) ov5_values(values)$S,
    function(values) ov5_values(values)$P,
    function(values) ov5_values(values)$R
  )
  for (index in 1:4) {
    ov5_assert_formula(object[[index]], expected_functions[[index]], paste("Candidate payoff", expected_names[[index]]))
  }
  difference_text <- object$exclusion_minus_deliberate_failure
  ov5_require_text(difference_text, c(">0", "q<=m", "beta<1"), "E-R positivity certificate")
  difference_formula <- sub(">0.*$", "", difference_text)
  ov5_assert_formula(
    difference_formula,
    function(values) ov5_values(values)$E - ov5_values(values)$R,
    "E-R algebra"
  )
  ov5_assert_formula(
    object$pooling_minus_exclusion,
    function(values) ov5_values(values)$P - ov5_values(values)$E,
    "P-E algebra"
  )
  ov5_assert_formula(
    object$low_type_only_minus_exclusion,
    function(values) ov5_values(values)$S - ov5_values(values)$E,
    "S-E algebra"
  )
  ov5_mark(context, object, path)
  invisible(TRUE)
}

ov5_formula_occurrences <- function(text, prefix, terminator_pattern) {
  pattern <- paste0(prefix, "([^", terminator_pattern, "]+)")
  matches <- gregexpr(pattern, text, perl = TRUE)[[1L]]
  if (identical(matches[[1L]], -1L)) return(character(0))
  pieces <- regmatches(text, list(matches))[[1L]]
  sub(paste0("^", prefix), "", pieces, perl = TRUE)
}

ov5_validate_selected_proposal <- function(object, branch, context, path) {
  ov5_assert(
    identical(names(object), c("family", "coalition_size", "pure_and_mixed")),
    "Selected-proposal fields changed."
  )
  family <- object$family
  if (branch %in% c("low", "pool", "exclude")) {
    y_values <- ov5_formula_occurrences(family, "y=", ";")
    r_values <- ov5_formula_occurrences(family, "r_i=", ".")
    ov5_assert(length(y_values) == 1L && length(r_values) == 1L, "Pure-family offer grammar is incomplete.")
    expected_y <- switch(
      branch,
      low = function(values) values$beta * values$o_0,
      pool = function(values) values$beta * values$o_1,
      exclude = function(values) 0
    )
    expected_r <- switch(
      branch,
      low = function(values) 1 - values$beta * values$o_0 - values$beta * (values$q - 2) / values$m,
      pool = function(values) 1 - values$beta * values$o_1 - values$beta * (values$q - 2) / values$m,
      exclude = function(values) 1 - values$beta * (values$q - 1) / values$m
    )
    ov5_assert_formula(trimws(y_values[[1L]]), expected_y, paste(branch, "selected y"))
    ov5_assert_formula(trimws(r_values[[1L]]), expected_r, paste(branch, "selected residual"))
    paid_size <- if (identical(branch, "exclude")) "|K|=q-1" else "|K|=q-2"
    opposite_size <- if (identical(branch, "exclude")) "|K|=q-2" else "|K|=q-1"
    ov5_require_text(
      family,
      c("x_j=beta/m iff j in K", "x_j=0 otherwise"),
      paste(branch, "selected proposal family")
    )
    ov5_require_text(object$coalition_size, paid_size, paste(branch, "coalition size"), opposite_size)
    ov5_require_text(
      object$pure_and_mixed,
      c("degenerate", "pure", "nondegenerate", "mixture", "coalition identities"),
      paste(branch, "pure/mixed parameterization"),
      c("must be symmetric")
    )
  } else {
    ov5_require_text(
      family,
      c("e_{i,K}>0", "y=0", "|K|=q-1", "p_{i,T}>0", "y=beta/m", "|T|=q-2", "r_i=1-beta*(q-1)/m"),
      "Mixed-cell proposal families",
      c("must choose exclusion", "symmetric")
    )
    ov5_require_text(
      object$coalition_size,
      c("exclusion", "|K|=q-1", "pooling", "|T|=q-2"),
      "Mixed-cell coalition sizes"
    )
    ov5_require_text(
      object$pure_and_mixed,
      c("pure iff exactly one", "Every other", "proposer mixture", "may differ across proposer identities"),
      "Mixed-cell pure/mixed parameterization",
      c("symmetric", "must choose exclusion")
    )
  }
  ov5_mark(context, object, path)
  invisible(TRUE)
}

ov5_validate_feasibility <- function(text, branch, context, path) {
  if (identical(branch, "low")) {
    ov5_require_text(text, c("strictly feasible", "o_0<=1/m", "beta*[o_0+(q-2)/m]", "beta*(q-1)/m < 1", "beta*o_0<o_0<y_bar"), "Low feasibility")
  } else if (identical(branch, "pool")) {
    ov5_require_text(text, c("strictly feasible", "o_1<=1/m", "beta*[o_1+(q-2)/m]", "beta*(q-1)/m < 1", "beta*o_1<o_1<=y_bar"), "Pooling feasibility")
  } else if (identical(branch, "exclude")) {
    ov5_require_text(text, c("strictly feasible", "y=0<=y_bar", "beta*(q-1)/m<1"), "Exclusion feasibility")
  } else {
    ov5_require_text(text, c("Both support families", "o_1=1/m", "beta*(q-1)/m<1", "pooling y=beta*o_1", "exclusion y=0"), "Mixed feasibility")
  }
  ov5_mark(context, text, path)
  invisible(TRUE)
}

ov5_validate_strategy <- function(object, branch, context, path, n1_hash) {
  expected_names <- c(
    "frozen_continuation", "ballot_map_after_every_feasible_proposal",
    "proposer_payoff_after_every_feasible_proposal", "candidate_payoffs_in_primitives",
    "selected_proposal_parameterization", "feasibility"
  )
  ov5_assert(identical(names(object), expected_names), "Strategy-profile fields changed.")
  ov5_validate_frozen_continuation(object$frozen_continuation, context, paste0(path, "$frozen_continuation"), n1_hash)
  ov5_validate_ballot_map(object$ballot_map_after_every_feasible_proposal, context, paste0(path, "$ballot_map_after_every_feasible_proposal"))
  ov5_validate_proposer_map(object$proposer_payoff_after_every_feasible_proposal, context, paste0(path, "$proposer_payoff_after_every_feasible_proposal"))
  ov5_validate_candidate_payoffs(object$candidate_payoffs_in_primitives, context, paste0(path, "$candidate_payoffs_in_primitives"))
  ov5_validate_selected_proposal(object$selected_proposal_parameterization, branch, context, paste0(path, "$selected_proposal_parameterization"))
  ov5_validate_feasibility(object$feasibility, branch, context, paste0(path, "$feasibility"))
  invisible(TRUE)
}

ov5_validate_beliefs <- function(object, branch, context, path, n1_hash) {
  expected_names <- c(
    "entry", "positive_weight_proposal", "zero_weight_proposal", "published_vote_vector",
    "zero_probability_proposal_vote_vectors", "weak_vote_information", "zero_prior_types",
    "continuation_effect", "deviating_proposer_evaluation"
  )
  ov5_assert(identical(names(object), expected_names), "Belief-system fields changed.")
  ov5_require_text(object$entry, c("Pr(theta=1)=nu"), "Entry belief")
  ov5_require_text(
    object$positive_weight_proposal,
    c("does not observe theta", "positive conditional weight", "posterior nu by Bayes"),
    "Positive-weight proposal belief"
  )
  ov5_require_text(
    object$zero_weight_proposal,
    c("zero conditional weight", "arbitrary ballot belief kappa_i(s) in [0,1]"),
    "Zero-weight proposal belief"
  )
  if (identical(branch, "low")) {
    ov5_require_text(
      object$published_vote_vector,
      c("nu>0", "unique positive-probability", "H voting no only under theta=1", "posterior at 1"),
      "Positive low-branch failure posterior",
      c("posterior at 0")
    )
  } else {
    ov5_require_text(
      object$published_vote_vector,
      c("selected proposal passes in R1", "no positive-probability R1 failure"),
      "No positive failure outside low branch"
    )
  }
  ov5_require_text(
    object$zero_probability_proposal_vote_vectors,
    c("every proposal s", "complete published vote vector v", "probability zero", "every nu in [0,1] including nu>0", "both endpoints", "eta_i(s,v) in [0,1]"),
    "Complete off-path proposal-vote beliefs",
    c("only at nu=0")
  )
  ov5_require_text(
    object$weak_vote_information,
    c("Weak votes", "deterministic functions of x_j", "never of theta", "positive-probability history"),
    "Weak-vote information"
  )
  ov5_require_text(
    object$zero_prior_types,
    c("nu=0 or nu=1", "strategies", "both types", "Bayes constrains only positive-probability histories"),
    "Zero-prior type completion"
  )
  ov5_require_text(
    object$continuation_effect,
    c("on-path or off-path R2 posterior", "same frozen N1-EQ-01", n1_hash),
    "Belief continuation effect"
  )
  ov5_require_text(
    object$deviating_proposer_evaluation,
    c("proposal deviation", "true pre-proposal prior nu", "not the off-path ballot belief"),
    "Deviating proposer evaluation"
  )
  ov5_mark(context, object, path)
  invisible(TRUE)
}

ov5_validate_existence_text <- function(text, branch, label) {
  if (identical(branch, "mixed_ep")) {
    ov5_require_text(
      text,
      c("exists", "type-specific H payoff", "outcome multiple", "pure identity assignments", "proposer mixtures", "all multiplicity is parameterized"),
      label,
      c("unique")
    )
  } else {
    ov5_require_text(
      text,
      c("exists", "selected branch", "recognized-proposer payoff", "type-specific H payoff", "outcome distribution are unique", "strategy multiplicity", "off-path beliefs"),
      label
    )
  }
}

ov5_validate_selection_text <- function(text, branch, label) {
  if (branch %in% c("low", "pool", "exclude")) {
    coalition <- if (identical(branch, "exclude")) "|K|=q-1" else "|K|=q-2"
    ov5_require_text(
      text,
      c("All and only arrays", "omega_{i,K}>=0", coalition, "sum_K omega_{i,K}=1", "degenerate", "pure", "nondegenerate", "mixing", "No", "selection"),
      label,
      c("symmetric across")
    )
    if (identical(branch, "low")) {
      ov5_require_text(text, c("minimum-expected-H tie-break", "low-type-only", "payoff boundary"), label)
    } else {
      ov5_require_text(text, c("uniquely minimizes expected H payoff", "No further selection"), label)
    }
  } else {
    ov5_require_text(
      text,
      c("For each i", "e_{i,K}", "|K|=q-1", "p_{i,T}", "|T|=q-2", "total sum is one", "pure iff exactly one", "proposer mixes", "all pure identity assignments", "all proposer mixtures", "no symmetry or further selection"),
      label,
      c("must choose")
    )
  }
}

ov5_validate_assumptions <- function(values, context, path) {
  ov5_assert(length(values) == 5L, "Assumptions list must have five entries.")
  requirements <- list(
    c("fixed unit pie", "beta in (0,1)", "0<o_0<o_1<1", "contract Section 2"),
    c("majority quota", "full execution of y", "simultaneous sealed ballots", "public vote vector", "contract Section 4"),
    c("PBE", "pure ballot strategies", "weak-only stage-undominated voting", "T^Y", "minimum-expected-H proposal tie-break", "contract Section 5"),
    c("exactly one multiplication by beta", "frozen N1 continuation", "contract Section 6"),
    c("iid uniform weak-state recognition", "with replacement", "no side payments", "no exit action")
  )
  for (index in seq_len(5L)) {
    ov5_require_text(values[[index]], requirements[[index]], paste("Assumption", index))
    ov5_mark(context, values[[index]], paste0(path, "[[", index, "]]"))
  }
  invisible(TRUE)
}

ov5_check_tokens <- function() {
  list(
    c("frozen N1 import", "exactly-one discount"),
    c("weak voting cutoff", "T^Y"),
    c("complete H best-response map"),
    c("proposer payoff map", "every feasible proposal"),
    c("exhaustive reduction", "exclusion", "low-type-only", "pooling", "deliberate failure"),
    c("P0", "belief-invariant N1 response maps"),
    c("P1", "strict hedge dominance", "P1a"),
    c("deliberate failure strictly dominated", "1-beta*q/m>0"),
    c("candidate feasibility", "every selected cell"),
    c("strict-region", "equality-boundary partition"),
    c("o_1=1/m", "expected-H tie-break"),
    c("pure identity assignments", "all proposer mixtures"),
    c("Bayes", "complete off-path proposal-vote beliefs", "every nu"),
    c("public H vote", "posterior update"),
    c("identity-indexed weak payoff map"),
    c("closed N6-transported fields", "without free symbols"),
    c("complete existence", "endpoint coverage")
  )
}

ov5_validate_checks <- function(values, context, path) {
  ov5_assert(length(values) == 17L, "Checks-performed list must bind all 17 claims.")
  requirements <- ov5_check_tokens()
  for (index in seq_len(17L)) {
    ov5_require_text(
      values[[index]],
      c(sprintf("N3V5-C%02d", index), requirements[[index]]),
      paste("Check binding", index),
      c("false", "not checked")
    )
    ov5_mark(context, values[[index]], paste0(path, "[[", index, "]]"))
  }
  invisible(TRUE)
}

ov5_validate_recognized_payoff <- function(text, branch, context, path) {
  expected <- switch(
    branch,
    low = function(values) ov5_values(values)$S,
    pool = function(values) ov5_values(values)$P,
    exclude = function(values) ov5_values(values)$E,
    mixed_ep = function(values) ov5_values(values)$E
  )
  ov5_assert_formula(text, expected, paste(branch, "recognized proposer payoff"))
  ov5_mark(context, text, path)
  invisible(TRUE)
}

ov5_validate_weak_map <- function(object, branch, context, path) {
  ov5_assert(
    identical(names(object), c("type", "by_weak_state_l")),
    "Weak-payoff-map fields changed."
  )
  ov5_require_text(
    object$type,
    c("identity-indexed", "pre-recognition R1 payoff map", "no symmetry restriction"),
    "Weak map type",
    c("symmetric")
  )
  formula <- object$by_weak_state_l
  common <- c("C_l=(1/m)", "sum_{i in W, i!=l}", "beta/m", "for each i")
  if (identical(branch, "low")) {
    ov5_require_text(
      formula,
      c(common, "(1-nu)", "nu*beta/m", "omega_{i,K}", "|K|=q-2", "l in K", "sum_{K subset W\\{i}, |K|=q-2}omega_{i,K}=1"),
      "Low identity map",
      c("|K|=q-1", "C_l=999")
    )
  } else if (identical(branch, "pool")) {
    ov5_require_text(
      formula,
      c(common, "1-beta*o_1-beta*(q-2)/m", "omega_{i,K}", "|K|=q-2", "l in K", "sum_{K subset W\\{i}, |K|=q-2}omega_{i,K}=1"),
      "Pooling identity map",
      c("nu*beta/m", "|K|=q-1", "C_l=999")
    )
  } else if (identical(branch, "exclude")) {
    ov5_require_text(
      formula,
      c(common, "1-beta*(q-1)/m", "omega_{i,K}", "|K|=q-1", "l in K", "sum_{K subset W\\{i}, |K|=q-1}omega_{i,K}=1"),
      "Exclusion identity map",
      c("|K|=q-2", "C_l=999")
    )
  } else {
    ov5_require_text(
      formula,
      c(common, "1-beta*(q-1)/m", "e_{i,K}", "|K|=q-1", "p_{i,T}", "|T|=q-2", "l in K", "l in T", "nonnegative", "=1"),
      "Mixed identity map",
      c("C_l=999", "symmetric")
    )
  }
  balance <- cumsum(utf8ToInt(formula) == utf8ToInt("{")) - cumsum(utf8ToInt(formula) == utf8ToInt("}"))
  ov5_assert(length(balance) > 0L && utils::tail(balance, 1L) == 0L && all(balance >= 0L), "Weak-map braces are unbalanced.")
  ov5_mark(context, object, path)
  invisible(TRUE)
}

ov5_validate_hegemon_payoff <- function(object, branch, context, path) {
  ov5_assert(identical(names(object), c("theta_0", "theta_1")), "Typed H-payoff fields changed.")
  if (identical(branch, "low")) {
    ov5_assert_formula(object$theta_0, function(values) values$beta * values$o_0, "Low branch H theta0")
    ov5_assert_formula(object$theta_1, function(values) values$beta * values$o_1, "Low branch H theta1")
  } else if (identical(branch, "pool")) {
    ov5_assert_formula(object$theta_0, function(values) values$beta * values$o_1, "Pooling H theta0")
    ov5_assert_formula(object$theta_1, function(values) values$beta * values$o_1, "Pooling H theta1")
  } else if (identical(branch, "exclude")) {
    ov5_assert_formula(object$theta_0, function(values) values$o_0, "Exclusion H theta0")
    ov5_assert_formula(object$theta_1, function(values) values$o_1, "Exclusion H theta1")
  } else {
    ov5_require_text(
      object$theta_0,
      c("(1/m)*sum_{i in W}", "o_0*sum_{K", "e_{i,K}", "(beta/m)*sum_{T", "p_{i,T}", "add to 1"),
      "Mixed H theta0",
      c("2*o_0", "beta^2", "symmetric")
    )
    ov5_require_text(
      object$theta_1,
      c("(1/m)*sum_{i in W}", "(1/m)*sum_{K", "e_{i,K}", "(beta/m)*sum_{T", "p_{i,T}", "o_1=1/m", "add to 1"),
      "Mixed H theta1",
      c("2*(1/m)", "beta^2", "symmetric")
    )
    low_matches <- gregexpr("o_0\\*sum_", object$theta_0, perl = TRUE)[[1L]]
    pool_matches <- gregexpr("\\(beta/m\\)\\*sum_", object$theta_0, perl = TRUE)[[1L]]
    ov5_assert(
      !identical(low_matches[[1L]], -1L) && length(low_matches) == 1L &&
        !identical(pool_matches[[1L]], -1L) && length(pool_matches) == 1L,
      "Mixed H theta0 coefficients are not unique."
    )
  }
  ov5_mark(context, object, path)
  invisible(TRUE)
}

ov5_validate_outcome <- function(object, branch, context, path) {
  expected_names <- c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
  ov5_assert(identical(names(object), expected_names), "Outcome-distribution fields changed.")
  if (identical(branch, "low")) {
    ov5_assert_formula(object$pass_with_hegemon, function(values) 1 - values$nu, "Low pass-with-H")
    ov5_scalar(object$pass_without_hegemon, 0L, "Low pass-without-H")
    ov5_scalar(object$failure, 0L, "Low terminal failure")
    ov5_assert_formula(object$delay, function(values) values$nu, "Low delay")
  } else if (identical(branch, "pool")) {
    ov5_scalar(object$pass_with_hegemon, 1L, "Pooling pass-with-H")
    ov5_scalar(object$pass_without_hegemon, 0L, "Pooling pass-without-H")
    ov5_scalar(object$failure, 0L, "Pooling failure")
    ov5_scalar(object$delay, 0L, "Pooling delay")
  } else if (identical(branch, "exclude")) {
    ov5_scalar(object$pass_with_hegemon, 0L, "Exclusion pass-with-H")
    ov5_scalar(object$pass_without_hegemon, 1L, "Exclusion pass-without-H")
    ov5_scalar(object$failure, 0L, "Exclusion failure")
    ov5_scalar(object$delay, 0L, "Exclusion delay")
  } else {
    ov5_require_text(object$pass_with_hegemon, c("(1/m)*sum_{i in W}", "|T|=q-2", "p_{i,T}", "nonnegative", "=1"), "Mixed pass-with-H")
    ov5_require_text(object$pass_without_hegemon, c("(1/m)*sum_{i in W}", "|K|=q-1", "e_{i,K}", "nonnegative", "=1"), "Mixed pass-without-H")
    ov5_scalar(object$failure, 0L, "Mixed failure")
    ov5_scalar(object$delay, 0L, "Mixed delay")
  }
  ov5_mark(context, object, path)
  invisible(TRUE)
}

ov5_validate_branch_classification <- function(text, spec, context, path) {
  ov5_require_text(text, spec$class, paste(spec$id, "branch classification"), c("deliberate failure selected"))
  if (identical(spec$branch, "low")) {
    ov5_require_text(text, c("low-type-only", "H"), paste(spec$id, "low classification"))
  } else if (identical(spec$branch, "pool")) {
    ov5_require_text(text, c("pooling"), paste(spec$id, "pool classification"))
  } else if (identical(spec$branch, "exclude")) {
    if (grepl("without H", text, fixed = TRUE)) {
      ov5_require_text(text, c("without H", "y=0"), paste(spec$id, "exclusion classification"))
    } else {
      ov5_require_text(text, c("exclusion", "E=P"), paste(spec$id, "residual exclusion classification"))
    }
  } else {
    ov5_require_text(text, c("every pure proposer-identity assignment", "every proposer mixture"), paste(spec$id, "mixed classification"))
  }
  ov5_mark(context, text, path)
  invisible(TRUE)
}

ov5_validate_record <- function(record, spec, context, path, n1_hash) {
  record_fields <- c(
    "equilibrium_id", "admissibility_conditions", "branch_classification",
    "strategy_profile", "belief_system", "source_continuation_record_ids",
    "source_interface_hashes", "existence_uniqueness_status", "selection_status",
    "assumptions_used", "checks_performed", "recognized_proposer_payoff",
    "weak_nonproposer_pre_recognition_expected_value", "hegemon_payoff_by_type",
    "outcome_distribution", "payoff_date"
  )
  ov5_assert(identical(names(record), record_fields), paste(spec$id, "record schema changed."))
  ov5_scalar(record$equilibrium_id, spec$eq, paste(spec$id, "equilibrium id"))
  ov5_mark(context, record$equilibrium_id, paste0(path, "$equilibrium_id"))
  ov5_validate_admissibility(record$admissibility_conditions, spec, context, paste0(path, "$admissibility_conditions"), n1_hash)
  ov5_validate_branch_classification(record$branch_classification, spec, context, paste0(path, "$branch_classification"))
  ov5_validate_strategy(record$strategy_profile, spec$branch, context, paste0(path, "$strategy_profile"), n1_hash)
  ov5_validate_beliefs(record$belief_system, spec$branch, context, paste0(path, "$belief_system"), n1_hash)
  ov5_assert(
    identical(record$source_continuation_record_ids, list("N1-EQ-01")),
    paste(spec$id, "source record changed.")
  )
  ov5_mark(context, record$source_continuation_record_ids, paste0(path, "$source_continuation_record_ids"))
  ov5_assert(
    identical(record$source_interface_hashes, list(N1 = n1_hash)),
    paste(spec$id, "source hash changed.")
  )
  ov5_mark(context, record$source_interface_hashes, paste0(path, "$source_interface_hashes"))
  ov5_validate_existence_text(record$existence_uniqueness_status, spec$branch, paste(spec$id, "existence/uniqueness"))
  ov5_mark(context, record$existence_uniqueness_status, paste0(path, "$existence_uniqueness_status"))
  ov5_validate_selection_text(record$selection_status, spec$branch, paste(spec$id, "selection status"))
  ov5_mark(context, record$selection_status, paste0(path, "$selection_status"))
  ov5_validate_assumptions(record$assumptions_used, context, paste0(path, "$assumptions_used"))
  ov5_validate_checks(record$checks_performed, context, paste0(path, "$checks_performed"))
  ov5_validate_recognized_payoff(record$recognized_proposer_payoff, spec$branch, context, paste0(path, "$recognized_proposer_payoff"))
  ov5_validate_weak_map(record$weak_nonproposer_pre_recognition_expected_value, spec$branch, context, paste0(path, "$weak_nonproposer_pre_recognition_expected_value"))
  ov5_validate_hegemon_payoff(record$hegemon_payoff_by_type, spec$branch, context, paste0(path, "$hegemon_payoff_by_type"))
  ov5_validate_outcome(record$outcome_distribution, spec$branch, context, paste0(path, "$outcome_distribution"))
  ov5_scalar(
    record$payoff_date,
    "R1 current units; frozen N1 continuation payoffs are multiplied by beta exactly once",
    paste(spec$id, "payoff date")
  )
  ov5_mark(context, record$payoff_date, paste0(path, "$payoff_date"))
  invisible(TRUE)
}

ov5_validate_cell <- function(cell, spec, context, path, n1_hash) {
  ov5_assert(
    identical(
      names(cell),
      c("cell_id", "domain_conditions", "existence_status", "equilibrium_records", "nonexistence_certificate")
    ),
    paste(spec$id, "cell schema changed.")
  )
  ov5_scalar(cell$cell_id, spec$id, paste(spec$id, "cell id"))
  ov5_mark(context, cell$cell_id, paste0(path, "$cell_id"))

  expected_domain_length <- 8L + length(spec$region)
  ov5_assert(length(cell$domain_conditions) == expected_domain_length, paste(spec$id, "domain length changed."))
  ov5_validate_common_domain(cell$domain_conditions[seq_len(8L)], context, paste0(path, "$domain_conditions"), n1_hash)
  for (index in seq_along(spec$region)) {
    actual_index <- 8L + index
    value <- cell$domain_conditions[[actual_index]]
    ov5_validate_region_condition(value, spec$region[[index]], paste(spec$id, "domain", spec$region[[index]]))
    ov5_mark(context, value, paste0(path, "$domain_conditions[[", actual_index, "]]"))
  }

  ov5_scalar(cell$existence_status, "exists", paste(spec$id, "existence status"))
  ov5_mark(context, cell$existence_status, paste0(path, "$existence_status"))
  ov5_assert(length(cell$equilibrium_records) == 1L, paste(spec$id, "must carry one record."))
  ov5_validate_record(
    cell$equilibrium_records[[1L]],
    spec,
    context,
    paste0(path, "$equilibrium_records[[1]]"),
    n1_hash
  )
  ov5_assert(is.null(cell$nonexistence_certificate), paste(spec$id, "must not have a none certificate."))
  ov5_mark(context, cell$nonexistence_certificate, paste0(path, "$nonexistence_certificate"))
  invisible(TRUE)
}

ov5_validate_candidate <- function(candidate, n1, n1_hash, n1_path = NULL) {
  ov5_validate_n1(n1, n1_hash, n1_path)
  context <- ov5_new_context(candidate)
  ov5_assert(
    identical(names(candidate), c("schema_ref", "function_of", "correspondence_cells")),
    "N3 v5 top-level schema changed."
  )
  ov5_scalar(candidate$schema_ref, "equilibrium_correspondence_v1", "N3 v5 schema")
  ov5_mark(context, candidate$schema_ref, "$schema_ref")
  ov5_assert(
    identical(names(candidate$function_of), c("name", "domain")),
    "N3 v5 function_of fields changed."
  )
  ov5_scalar(candidate$function_of$name, "entry_belief", "N3 v5 function name")
  ov5_scalar(candidate$function_of$domain, "[0,1]", "N3 v5 function domain")
  ov5_mark(context, candidate$function_of, "$function_of")

  specs <- ov5_cell_specs()
  ov5_assert(length(candidate$correspondence_cells) == length(specs), "N3 v5 must contain exactly eleven cells.")
  actual_ids <- vapply(candidate$correspondence_cells, function(cell) cell$cell_id, character(1))
  expected_ids <- vapply(specs, function(spec) spec$id, character(1))
  ov5_assert(identical(actual_ids, expected_ids), "N3 v5 cell order or identity changed.")
  for (index in seq_along(specs)) {
    ov5_validate_cell(
      candidate$correspondence_cells[[index]],
      specs[[index]],
      context,
      paste0("$correspondence_cells[[", index, "]]"),
      n1_hash
    )
  }
  covered <- ov5_finish_coverage(context, "N3 v5 candidate")
  categories <- ov5_category_audit(
    context$all_paths,
    ov5_candidate_category,
    c(
      "metadata_schema_source_date", "domain_frontiers_endpoints", "frozen_continuation",
      "complete_ballot_map", "proposer_map_ESPR", "proposals_feasibility", "beliefs",
      "weak_identity_payoffs", "hegemon_payoffs_mixed_coefficients", "outcomes",
      "multiplicity_mixtures_identities", "assumptions_claim_bindings"
    ),
    "N3 v5 candidate"
  )
  invisible(list(paths = covered, cells = length(specs), categories = categories))
}

ov5_dummy_context <- function() {
  context <- new.env(parent = emptyenv())
  context$validated_paths <- character(0)
  context$all_paths <- character(0)
  context
}

ov5_validate_candidate_path <- function(candidate, n1, n1_hash, path) {
  ov5_validate_n1(n1, n1_hash)
  if (identical(path, "$schema_ref")) {
    ov5_scalar(candidate$schema_ref, "equilibrium_correspondence_v1", "Candidate schema path")
    return(invisible(TRUE))
  }
  if (startsWith(path, "$function_of")) {
    ov5_assert(
      identical(candidate$function_of, list(name = "entry_belief", domain = "[0,1]")),
      "Candidate function_of path failed."
    )
    return(invisible(TRUE))
  }
  matched <- regexec("^\\$correspondence_cells\\[\\[([0-9]+)\\]\\](.*)$", path, perl = TRUE)
  pieces <- regmatches(path, matched)[[1L]]
  ov5_assert(length(pieces) == 3L, paste("Unknown candidate path:", path))
  cell_index <- as.integer(pieces[[2L]])
  suffix <- pieces[[3L]]
  specs <- ov5_cell_specs()
  ov5_assert(cell_index >= 1L && cell_index <= length(specs), "Candidate path has invalid cell index.")
  cell <- candidate$correspondence_cells[[cell_index]]
  spec <- specs[[cell_index]]
  context <- ov5_dummy_context()
  base <- paste0("$correspondence_cells[[", cell_index, "]]" )

  if (identical(suffix, "$cell_id")) {
    ov5_scalar(cell$cell_id, spec$id, "Candidate cell-id path")
  } else if (startsWith(suffix, "$domain_conditions")) {
    ov5_assert(length(cell$domain_conditions) == 8L + length(spec$region), "Candidate domain path has wrong length.")
    ov5_validate_common_domain(cell$domain_conditions[seq_len(8L)], context, paste0(base, "$domain_conditions"), n1_hash)
    for (index in seq_along(spec$region)) {
      ov5_validate_region_condition(
        cell$domain_conditions[[8L + index]],
        spec$region[[index]],
        paste(spec$id, "targeted region")
      )
    }
  } else if (identical(suffix, "$existence_status")) {
    ov5_scalar(cell$existence_status, "exists", "Candidate cell-existence path")
  } else if (identical(suffix, "$nonexistence_certificate")) {
    ov5_assert(is.null(cell$nonexistence_certificate), "Candidate none certificate path failed.")
  } else {
    record_match <- regexec("^\\$equilibrium_records\\[\\[1\\]\\](.*)$", suffix, perl = TRUE)
    record_pieces <- regmatches(suffix, record_match)[[1L]]
    ov5_assert(length(record_pieces) == 2L, paste("Unknown record path:", path))
    record_suffix <- record_pieces[[2L]]
    record <- cell$equilibrium_records[[1L]]
    record_base <- paste0(base, "$equilibrium_records[[1]]")
    if (identical(record_suffix, "$equilibrium_id")) {
      ov5_scalar(record$equilibrium_id, spec$eq, "Targeted equilibrium id")
    } else if (startsWith(record_suffix, "$admissibility_conditions")) {
      ov5_validate_admissibility(record$admissibility_conditions, spec, context, paste0(record_base, "$admissibility_conditions"), n1_hash)
    } else if (identical(record_suffix, "$branch_classification")) {
      ov5_validate_branch_classification(record$branch_classification, spec, context, paste0(record_base, "$branch_classification"))
    } else if (startsWith(record_suffix, "$strategy_profile")) {
      strategy <- record$strategy_profile
      if (grepl("\\$frozen_continuation", record_suffix)) {
        ov5_validate_frozen_continuation(strategy$frozen_continuation, context, "$target$frozen_continuation", n1_hash)
      } else if (grepl("\\$ballot_map_after_every_feasible_proposal", record_suffix)) {
        ov5_validate_ballot_map(strategy$ballot_map_after_every_feasible_proposal, context, "$target$ballot")
      } else if (grepl("\\$proposer_payoff_after_every_feasible_proposal", record_suffix)) {
        ov5_validate_proposer_map(strategy$proposer_payoff_after_every_feasible_proposal, context, "$target$proposer")
      } else if (grepl("\\$candidate_payoffs_in_primitives", record_suffix)) {
        ov5_validate_candidate_payoffs(strategy$candidate_payoffs_in_primitives, context, "$target$candidates")
      } else if (grepl("\\$selected_proposal_parameterization", record_suffix)) {
        ov5_validate_selected_proposal(strategy$selected_proposal_parameterization, spec$branch, context, "$target$proposal")
      } else if (grepl("\\$feasibility", record_suffix)) {
        ov5_validate_feasibility(strategy$feasibility, spec$branch, context, "$target$feasibility")
      } else {
        stop(paste("Unknown strategy path:", path), call. = FALSE)
      }
    } else if (startsWith(record_suffix, "$belief_system")) {
      ov5_validate_beliefs(record$belief_system, spec$branch, context, "$target$beliefs", n1_hash)
    } else if (startsWith(record_suffix, "$source_continuation_record_ids")) {
      ov5_assert(identical(record$source_continuation_record_ids, list("N1-EQ-01")), "Targeted source record failed.")
    } else if (startsWith(record_suffix, "$source_interface_hashes")) {
      ov5_assert(identical(record$source_interface_hashes, list(N1 = n1_hash)), "Targeted source hash failed.")
    } else if (identical(record_suffix, "$existence_uniqueness_status")) {
      ov5_validate_existence_text(record$existence_uniqueness_status, spec$branch, "Targeted existence text")
    } else if (identical(record_suffix, "$selection_status")) {
      ov5_validate_selection_text(record$selection_status, spec$branch, "Targeted selection text")
    } else if (startsWith(record_suffix, "$assumptions_used")) {
      ov5_validate_assumptions(record$assumptions_used, context, "$target$assumptions")
    } else if (startsWith(record_suffix, "$checks_performed")) {
      ov5_validate_checks(record$checks_performed, context, "$target$checks")
    } else if (identical(record_suffix, "$recognized_proposer_payoff")) {
      ov5_validate_recognized_payoff(record$recognized_proposer_payoff, spec$branch, context, "$target$recognized")
    } else if (startsWith(record_suffix, "$weak_nonproposer_pre_recognition_expected_value")) {
      ov5_validate_weak_map(record$weak_nonproposer_pre_recognition_expected_value, spec$branch, context, "$target$weak")
    } else if (startsWith(record_suffix, "$hegemon_payoff_by_type")) {
      ov5_validate_hegemon_payoff(record$hegemon_payoff_by_type, spec$branch, context, "$target$H")
    } else if (startsWith(record_suffix, "$outcome_distribution")) {
      ov5_validate_outcome(record$outcome_distribution, spec$branch, context, "$target$outcome")
    } else if (identical(record_suffix, "$payoff_date")) {
      ov5_scalar(
        record$payoff_date,
        "R1 current units; frozen N1 continuation payoffs are multiplied by beta exactly once",
        "Targeted payoff date"
      )
    } else {
      stop(paste("Unknown candidate semantic path:", path), call. = FALSE)
    }
  }
  invisible(TRUE)
}

ov5_validate_claim_semantics <- function(text, claim_spec, label) {
  ov5_require_text(
    text,
    claim_spec$tokens,
    label,
    c(
      "beta twice", "beta^2", "selected deliberate failure", "posterior at 0",
      "symmetry is imposed", "nonexistence throughout", "H vote is ignored"
    )
  )
  invisible(TRUE)
}

ov5_validate_ledger <- function(ledger, candidate, n1_hash) {
  context <- ov5_new_context(ledger)
  ov5_assert(
    identical(
      names(ledger),
      c("schema_version", "node", "candidate_status", "source_interface", "equilibrium_ids", "claims")
    ),
    "N3 v5 ledger top-level fields changed."
  )
  ov5_scalar(ledger$schema_version, "essential-input-claim-ledger-v5", "Ledger schema version")
  ov5_mark(context, ledger$schema_version, "$schema_version")
  ov5_scalar(ledger$node, "N3", "Ledger node")
  ov5_mark(context, ledger$node, "$node")
  ov5_scalar(ledger$candidate_status, "pending_independent_review", "Ledger lifecycle")
  ov5_mark(context, ledger$candidate_status, "$candidate_status")

  ov5_assert(
    identical(names(ledger$source_interface), c("record_id", "artifact_hash")),
    "Ledger source fields changed."
  )
  ov5_scalar(ledger$source_interface$record_id, "N1-EQ-01", "Ledger source record")
  ov5_scalar(ledger$source_interface$artifact_hash, n1_hash, "Ledger source hash")
  ov5_mark(context, ledger$source_interface, "$source_interface")

  expected_ids <- vapply(ov5_cell_specs(), function(spec) spec$eq, character(1))
  actual_candidate_ids <- vapply(
    candidate$correspondence_cells,
    function(cell) cell$equilibrium_records[[1L]]$equilibrium_id,
    character(1)
  )
  ov5_assert(identical(actual_candidate_ids, expected_ids), "Candidate equilibrium IDs do not match semantic cell specs.")
  ov5_assert(
    identical(as.character(unlist(ledger$equilibrium_ids, use.names = FALSE)), expected_ids),
    "Ledger equilibrium IDs do not match candidate cells."
  )
  ov5_mark(context, ledger$equilibrium_ids, "$equilibrium_ids")

  claim_specs <- ov5_claim_specs()
  ov5_assert(length(ledger$claims) == 17L, "Ledger must contain exactly 17 claims.")
  for (index in seq_len(17L)) {
    claim <- ledger$claims[[index]]
    spec <- claim_specs[[index]]
    path <- paste0("$claims[[", index, "]]" )
    ov5_assert(
      identical(
        names(claim),
        c("claim_id", "equilibrium_ids", "branch", "payoff_date", "claim", "status", "evidence")
      ),
      paste(spec$id, "ledger fields changed.")
    )
    ov5_scalar(claim$claim_id, spec$id, paste(spec$id, "claim id"))
    ov5_mark(context, claim$claim_id, paste0(path, "$claim_id"))
    ov5_assert(
      identical(as.character(unlist(claim$equilibrium_ids, use.names = FALSE)), expected_ids),
      paste(spec$id, "does not bind all equilibrium IDs.")
    )
    ov5_mark(context, claim$equilibrium_ids, paste0(path, "$equilibrium_ids"))
    ov5_scalar(claim$branch, spec$branch, paste(spec$id, "branch"))
    ov5_mark(context, claim$branch, paste0(path, "$branch"))
    ov5_scalar(claim$payoff_date, "R1 current units", paste(spec$id, "payoff date"))
    ov5_mark(context, claim$payoff_date, paste0(path, "$payoff_date"))
    ov5_validate_claim_semantics(claim$claim, spec, paste(spec$id, "claim text"))
    ov5_mark(context, claim$claim, paste0(path, "$claim"))
    ov5_scalar(claim$status, "proved", paste(spec$id, "status"))
    ov5_mark(context, claim$status, paste0(path, "$status"))
    expected_evidence <- paste0(
      "model_redesign/essential_input_n3_r1_majority_derivation_v5.md#claim-",
      tolower(spec$id)
    )
    ov5_scalar(claim$evidence, expected_evidence, paste(spec$id, "evidence link"))
    ov5_mark(context, claim$evidence, paste0(path, "$evidence"))
  }
  covered <- ov5_finish_coverage(context, "N3 v5 ledger")
  categories <- ov5_category_audit(
    context$all_paths,
    ov5_ledger_category,
    c("metadata", "source", "equilibrium_ids", "claims_evidence"),
    "N3 v5 ledger"
  )
  invisible(list(paths = covered, claims = length(claim_specs), categories = categories))
}

ov5_derivation_claim_tokens <- function() {
  list(
    c("beta/m", "beta*o_theta", "exatamente uma vez"),
    c("x_j>=beta/m", "T^Y seleciona sim"),
    c("k_i>=q-1", "k_i=q-2", "k_i<=q-3", "y+o_theta"),
    c("prior verdadeiro nu", "(1-nu)*r_i+nu*beta/m"),
    c("E = 1-beta*(q-1)/m", "S(nu)", "P = 1-beta*o_1", "R = beta/m"),
    c("invariante à crença de ballot", "não afirma que duas propostas públicas distintas preservam"),
    c("s'=(0,x,r_i+y)", "toda exclusão selecionada tem y=0"),
    c("E-R = 1-beta*q/m > 0", "delay informativo"),
    c("beta*[o_theta+(q-2)/m]", "0<=y<=y_bar"),
    c("partição exclusiva e exaustiva", "h_E=h_P", "low-type-only"),
    c("o_1=1/m", "todas as misturas admissíveis"),
    c("omega_{i,K}", "e_{i,K}", "p_{i,T}", "Não há simetria imposta"),
    c("todo nu in [0,1]", "quando nu>0", "eta_i(s,v) em [0,1]"),
    c("posterior em um", "voto de H"),
    c("C_l", "assimétricos entre identidades"),
    c("U_H(0)", "pass with H", "todos os símbolos são localmente fechados"),
    c("todo o domínio", "Não há célula none")
  )
}

ov5_claim_sections <- function(text) {
  pattern <- '<a id="claim-n3v5-c[0-9]{2}"></a>'
  positions <- gregexpr(pattern, text, perl = TRUE)[[1L]]
  ov5_assert(!identical(positions[[1L]], -1L), "Derivation has no N3 v5 claim anchors.")
  lengths <- attr(positions, "match.length")
  anchors <- substring(text, positions, positions + lengths - 1L)
  ids <- toupper(sub('.*claim-(n3v5-c[0-9]{2}).*', "\\1", anchors, perl = TRUE))
  ov5_assert(
    length(ids) == 17L && setequal(ids, sprintf("N3V5-C%02d", 1:17)),
    "Derivation does not contain exactly the 17 N3 v5 anchors."
  )
  sections <- vector("list", length(ids))
  names(sections) <- ids
  for (index in seq_along(ids)) {
    start <- positions[[index]]
    next_anchor <- if (index < length(ids)) positions[[index + 1L]] - 1L else nchar(text)
    after_anchor <- substring(text, start)
    next_level_two <- regexpr("\n## ", after_anchor, fixed = TRUE)[[1L]]
    next_heading <- if (next_level_two < 0L) nchar(text) else start + next_level_two - 2L
    end <- min(next_anchor, next_heading)
    sections[[ids[[index]]]] <- substring(text, start, end)
  }
  sections
}

ov5_validate_derivation <- function(text) {
  ov5_assert(is.character(text) && length(text) == 1L && validUTF8(text), "Derivation must be one UTF-8 string.")
  ov5_require_text(
    text,
    c(
      "# N3 v5", "equilibrium_correspondence_v1",
      "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5",
      "não reconstrói o JSON", "AST", "todas as folhas", "duas execuções reais",
      "semanticamente idênticos", "a v4"
    ),
    "N3 v5 derivation metadata",
    c("oracle v5 reconstrói o JSON", "beta=1 pertence ao baseline", "falha deliberada é selecionada")
  )
  sections <- ov5_claim_sections(text)
  requirements <- ov5_derivation_claim_tokens()
  for (index in seq_len(17L)) {
    claim_id <- sprintf("N3V5-C%02d", index)
    ov5_require_text(
      sections[[claim_id]],
      c(paste("Claim", claim_id), requirements[[index]]),
      paste(claim_id, "derivation section"),
      c("CONTRADICTION", "beta^2", "posterior at 0", "simetria é imposta")
    )
  }
  invisible(list(claims = length(sections)))
}

ov5_candidate_category <- function(path) {
  if (grepl("\\$(schema_ref|function_of|cell_id|equilibrium_id|existence_status|nonexistence_certificate|source_continuation_record_ids|source_interface_hashes|payoff_date)", path, perl = TRUE)) return("metadata_schema_source_date")
  if (grepl("\\$(domain_conditions|admissibility_conditions)", path, perl = TRUE)) return("domain_frontiers_endpoints")
  if (grepl("\\$frozen_continuation", path)) return("frozen_continuation")
  if (grepl("\\$ballot_map_after_every_feasible_proposal", path)) return("complete_ballot_map")
  if (grepl("\\$(proposer_payoff_after_every_feasible_proposal|candidate_payoffs_in_primitives|recognized_proposer_payoff)", path, perl = TRUE)) return("proposer_map_ESPR")
  if (grepl("\\$(selected_proposal_parameterization|feasibility)", path, perl = TRUE)) return("proposals_feasibility")
  if (grepl("\\$belief_system", path)) return("beliefs")
  if (grepl("\\$weak_nonproposer_pre_recognition_expected_value", path)) return("weak_identity_payoffs")
  if (grepl("\\$hegemon_payoff_by_type", path)) return("hegemon_payoffs_mixed_coefficients")
  if (grepl("\\$outcome_distribution", path)) return("outcomes")
  if (grepl("\\$(branch_classification|existence_uniqueness_status|selection_status)", path, perl = TRUE)) return("multiplicity_mixtures_identities")
  if (grepl("\\$(assumptions_used|checks_performed)", path, perl = TRUE)) return("assumptions_claim_bindings")
  NA_character_
}

ov5_ledger_category <- function(path) {
  if (grepl("^\\$(schema_version|node|candidate_status)", path, perl = TRUE)) return("metadata")
  if (grepl("^\\$source_interface", path)) return("source")
  if (grepl("^\\$equilibrium_ids", path)) return("equilibrium_ids")
  if (grepl("^\\$claims", path)) return("claims_evidence")
  NA_character_
}

ov5_category_audit <- function(paths, classifier, required, label) {
  categories <- vapply(paths, classifier, character(1))
  ov5_assert(!anyNA(categories), paste(label, "has unclassified paths:", paste(paths[is.na(categories)], collapse = ", ")))
  counts <- table(factor(categories, levels = required))
  ov5_assert(all(counts > 0L), paste(label, "has an empty semantic category."))
  counts
}

ov5_expected_cell_id <- function(N, beta, o0, o1, nu, tolerance = 1e-10) {
  m <- N - 1
  q <- floor(N / 2) + 1
  inverse_m <- 1 / m
  if (o1 < inverse_m - tolerance) {
    frontier <- beta * (o1 - o0) / (1 - beta * o0 - beta * (q - 1) / m)
    return(if (nu <= frontier + tolerance) "N3V5-CELL-O1LT-LOW" else "N3V5-CELL-O1LT-POOL")
  }
  if (abs(o1 - inverse_m) <= tolerance) {
    frontier <- beta * (inverse_m - o0) / (beta * (inverse_m - o0) + 1 - beta * q / m)
    if (nu <= frontier + tolerance) return("N3V5-CELL-O1EQ-LOW")
    h_e <- (1 - nu) * o0 + nu / m
    h_p <- beta / m
    if (h_e < h_p - tolerance) return("N3V5-CELL-O1EQ-EXCLUDE")
    if (h_p < h_e - tolerance) return("N3V5-CELL-O1EQ-POOL")
    return("N3V5-CELL-O1EQ-MIXED-EP")
  }
  if (o0 < inverse_m - tolerance && inverse_m < o1 - tolerance) {
    frontier <- beta * (inverse_m - o0) / (beta * (inverse_m - o0) + 1 - beta * q / m)
    return(if (nu <= frontier + tolerance) "N3V5-CELL-CROSS-LOW" else "N3V5-CELL-CROSS-EXCLUDE")
  }
  if (abs(o0 - inverse_m) <= tolerance) {
    return(if (nu <= tolerance) "N3V5-CELL-O0EQ-LOW-ENDPOINT" else "N3V5-CELL-O0EQ-EXCLUDE")
  }
  "N3V5-CELL-O0GT-EXCLUDE"
}

ov5_direct_selected_branches <- function(N, beta, o0, o1, nu, tolerance = 1e-10) {
  values <- list(beta = beta, m = N - 1, q = floor(N / 2) + 1, nu = nu, o_0 = o0, o_1 = o1, r_i = 0)
  payoff <- ov5_values(values)
  proposer <- c(E = payoff$E, S = payoff$S, P = payoff$P, R = payoff$R)
  feasible <- c(
    E = TRUE,
    S = beta * o0 + beta * (values$q - 2) / values$m <= 1 + tolerance,
    P = beta * o1 + beta * (values$q - 2) / values$m <= 1 + tolerance,
    R = TRUE
  )
  proposer[!feasible] <- -Inf
  h <- c(
    E = (1 - nu) * o0 + nu * o1,
    S = beta * ((1 - nu) * o0 + nu * o1),
    P = beta * o1,
    R = beta * ((1 - nu) * o0 + nu * o1)
  )
  maxima <- names(proposer)[abs(proposer - max(proposer)) <= tolerance]
  minimum_h <- min(h[maxima])
  sort(maxima[abs(h[maxima] - minimum_h) <= tolerance])
}

ov5_set_from_cell <- function(cell_id) {
  if (grepl("MIXED-EP$", cell_id)) return(c("E", "P"))
  if (grepl("LOW", cell_id)) return("S")
  if (grepl("POOL$", cell_id)) return("P")
  if (grepl("EXCLUDE$", cell_id)) return("E")
  stop(paste("Unknown semantic cell", cell_id), call. = FALSE)
}

ov5_weak_vote_from_stage_game <- function(N, beta, x_j) {
  m <- N - 1
  q <- floor(N / 2) + 1
  other_counts <- 0:(m - 1)
  yes_payoff <- vapply(other_counts, function(other_yes) {
    if (1 + other_yes + 1 >= q) x_j else beta / m
  }, numeric(1))
  no_payoff <- vapply(other_counts, function(other_yes) {
    if (1 + other_yes >= q) x_j else beta / m
  }, numeric(1))
  if (all(yes_payoff >= no_payoff) && any(yes_payoff > no_payoff)) return("yes")
  if (all(no_payoff >= yes_payoff) && any(no_payoff > yes_payoff)) return("no")
  ov5_assert(identical(yes_payoff, no_payoff), "Weak ballots are incomparable at a claimed tie.")
  "yes"
}

ov5_h_ballot_from_payoffs <- function(N, beta, o_theta, y, weak_yes) {
  q <- floor(N / 2) + 1
  pass_yes <- 1 + weak_yes + 1 >= q
  pass_no <- 1 + weak_yes >= q
  yes_payoff <- if (pass_yes) y else beta * o_theta
  no_payoff <- if (pass_no) y + o_theta else beta * o_theta
  if (yes_payoff > no_payoff) "yes" else if (no_payoff > yes_payoff) "no" else "yes"
}

ov5_coalitions <- function(players, size) {
  if (size == 0L) return(list(integer(0)))
  matrix_value <- utils::combn(players, size)
  if (is.null(dim(matrix_value))) return(list(as.integer(matrix_value)))
  lapply(seq_len(ncol(matrix_value)), function(column) matrix_value[, column])
}

ov5_identity_check <- function(branch, N = 9L, beta = 0.81, o0 = 0.04, o1 = 0.18, nu = 0.37) {
  m <- N - 1
  q <- floor(N / 2) + 1
  continuation <- beta / m
  direct <- numeric(m)
  closed <- numeric(m)
  size <- if (identical(branch, "exclude")) q - 1 else q - 2
  proposer_payoff <- switch(
    branch,
    low = (1 - nu) * (1 - beta * o0 - beta * (q - 2) / m) + nu * continuation,
    pool = 1 - beta * o1 - beta * (q - 2) / m,
    exclude = 1 - beta * (q - 1) / m
  )
  for (proposer in seq_len(m)) {
    coalitions <- ov5_coalitions(setdiff(seq_len(m), proposer), size)
    raw_weights <- seq_along(coalitions)^2
    weights <- raw_weights / sum(raw_weights)
    for (state in seq_len(m)) {
      if (state == proposer) {
        payoff <- proposer_payoff
      } else {
        inclusion <- sum(weights[vapply(coalitions, function(group) state %in% group, logical(1))])
        payoff <- if (identical(branch, "low")) {
          (1 - nu) * continuation * inclusion + nu * continuation
        } else {
          continuation * inclusion
        }
      }
      direct[[state]] <- direct[[state]] + payoff / m
    }
  }
  for (state in seq_len(m)) {
    value <- proposer_payoff / m
    for (proposer in setdiff(seq_len(m), state)) {
      coalitions <- ov5_coalitions(setdiff(seq_len(m), proposer), size)
      raw_weights <- seq_along(coalitions)^2
      weights <- raw_weights / sum(raw_weights)
      inclusion <- sum(weights[vapply(coalitions, function(group) state %in% group, logical(1))])
      value <- value + if (identical(branch, "low")) {
        ((1 - nu) * continuation * inclusion + nu * continuation) / m
      } else {
        continuation * inclusion / m
      }
    }
    closed[[state]] <- value
  }
  ov5_assert(max(abs(direct - closed)) < 1e-12, paste("Identity payoff projection failed for", branch))
  invisible(TRUE)
}

ov5_run_numeric_audit <- function(draws = 50000L) {
  for (N in 3:24) {
    m <- N - 1
    q <- floor(N / 2) + 1
    ov5_assert(q <= m, "Majority quota exceeds weak states.")
    for (beta in c(0.01, 0.37, 0.8, 0.999999)) {
      ov5_assert(1 - beta * q / m > 0, "Exclusion failed to dominate deliberate delay.")
      for (x_j in c(0, beta / m - 1e-9, beta / m, beta / m + 1e-9, 1)) {
        if (x_j < 0) next
        expected <- if (x_j + 1e-12 >= beta / m) "yes" else "no"
        ov5_assert(identical(ov5_weak_vote_from_stage_game(N, beta, x_j), expected), "Weak cutoff failed enumeration.")
      }
      for (o_theta in c(0.02, 0.25, 0.7, 0.98)) {
        for (weak_yes in 0:(m - 1)) {
          for (y in unique(c(0, beta * o_theta / 2, beta * o_theta, min(1, beta * o_theta + 0.1)))) {
            vote <- ov5_h_ballot_from_payoffs(N, beta, o_theta, y, weak_yes)
            expected <- if (weak_yes >= q - 1) {
              "no"
            } else if (weak_yes == q - 2) {
              if (y + 1e-12 >= beta * o_theta) "yes" else "no"
            } else {
              "yes"
            }
            ov5_assert(identical(vote, expected), "H ballot map failed payoff enumeration.")
          }
        }
      }
    }
  }

  set.seed(20260820)
  for (iteration in seq_len(draws)) {
    N <- sample(3:60, 1L)
    beta <- stats::runif(1L, 0.0001, 0.9999)
    outside <- sort(stats::runif(2L, 0.0001, 0.9999))
    if (outside[[1L]] == outside[[2L]]) next
    o0 <- outside[[1L]]
    o1 <- outside[[2L]]
    nu <- stats::runif(1L)
    cell <- ov5_expected_cell_id(N, beta, o0, o1, nu)
    selected <- ov5_direct_selected_branches(N, beta, o0, o1, nu)
    ov5_assert(identical(sort(ov5_set_from_cell(cell)), selected), "Cell partition disagrees with direct argmax/tie-break.")
  }

  N <- 9L
  m <- N - 1
  q <- floor(N / 2) + 1
  beta <- 0.8
  o0 <- 0.08
  o1 <- 1 / m
  nu_se <- beta * (1 / m - o0) / (beta * (1 / m - o0) + 1 - beta * q / m)
  nu_h <- (beta / m - o0) / (1 / m - o0)
  ov5_assert(identical(ov5_expected_cell_id(N, beta, o0, o1, nu_se), "N3V5-CELL-O1EQ-LOW"), "Closed nu_SE ownership failed.")
  ov5_assert(identical(ov5_expected_cell_id(N, beta, o0, o1, nu_h), "N3V5-CELL-O1EQ-MIXED-EP"), "Mixed H tie endpoint failed.")
  ov5_assert(identical(ov5_expected_cell_id(N, beta, 1 / m, 0.2, 0), "N3V5-CELL-O0EQ-LOW-ENDPOINT"), "o0 endpoint failed.")
  ov5_assert(identical(ov5_expected_cell_id(N, beta, 1 / m, 0.2, 1), "N3V5-CELL-O0EQ-EXCLUDE"), "o0 positive-prior endpoint failed.")
  for (branch in c("low", "pool", "exclude")) ov5_identity_check(branch)

  pooling_shares <- c(0, 0.09, 0.27, 0.5, 0.74, 1)
  for (pooling_share in pooling_shares) {
    exclusion_share <- 1 - pooling_share
    h0 <- exclusion_share * o0 + pooling_share * beta / m
    h1 <- exclusion_share * o1 + pooling_share * beta / m
    ex_ante <- (1 - nu_h) * h0 + nu_h * h1
    ov5_assert(abs(ex_ante - beta / m) < 1e-12, "Mixed H expected payoff is not invariant.")
    ov5_assert(abs(pooling_share + exclusion_share - 1) < 1e-12, "Mixed outcomes fail to sum to one.")
  }
  invisible(TRUE)
}

ov5_direct_execution <- function() {
  script_arguments <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  length(script_arguments) == 1L &&
    identical(basename(sub("^--file=", "", script_arguments)), "oracle_essential_input_n3_v5.R")
}

ov5_main <- function() {
  script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  ov5_assert(length(script_argument) == 1L, "Could not resolve N3 v5 oracle path.")
  script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
  repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
  paths <- list(
    candidate = file.path(repository_root, "model_redesign", "essential_input_interfaces", "n3_r1_majority_candidate_v5.json"),
    ledger = file.path(repository_root, "model_redesign", "essential_input_n3_claim_ledger_v5.json"),
    derivation = file.path(repository_root, "model_redesign", "essential_input_n3_r1_majority_derivation_v5.md"),
    n1 = file.path(repository_root, "model_redesign", "essential_input_interfaces", "n1_r2_majority_candidate_v1.json")
  )
  for (path in unlist(paths, use.names = FALSE)) ov5_assert(file.exists(path), paste("Missing oracle input:", path))
  n1_hash <- "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
  candidate <- jsonlite::fromJSON(paths$candidate, simplifyVector = FALSE)
  ledger <- jsonlite::fromJSON(paths$ledger, simplifyVector = FALSE)
  n1 <- jsonlite::fromJSON(paths$n1, simplifyVector = FALSE)
  derivation <- rawToChar(readBin(paths$derivation, what = "raw", n = file.info(paths$derivation)$size))
  candidate_audit <- ov5_validate_candidate(candidate, n1, n1_hash, paths$n1)
  ledger_audit <- ov5_validate_ledger(ledger, candidate, n1_hash)
  derivation_audit <- ov5_validate_derivation(derivation)
  ov5_run_numeric_audit(50000L)
  cat("PASS: N3 v5 semantic evaluator parsed every exported leaf without a builder-equivalent reference object.\n")
  cat(
    "SEMANTIC_PATHS_COVERED:",
    candidate_audit$paths,
    "candidate across",
    length(candidate_audit$categories),
    "categories and",
    ledger_audit$paths,
    "ledger across",
    length(ledger_audit$categories),
    "categories.\n"
  )
  cat("DERIVATION_CLAIMS_COVERED:", derivation_audit$claims, "\n")
}

if (ov5_direct_execution()) ov5_main()
