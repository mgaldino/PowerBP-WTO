#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1L]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

interface_path <- "model_redesign/pivotal_response_interfaces/institutional_comparison_v1.json"
note_path <- "model_redesign/pivotal_response_nodes/institutional_comparison_v1.md"
batch_path <- "model_redesign/pivotal_response_interfaces/entry_batch_review_v1.json"
u_path <- "model_redesign/pivotal_response_interfaces/entry_unanimity_v1.json"
m_path <- "model_redesign/pivotal_response_interfaces/entry_majority_v1.json"
r1_u_path <- "model_redesign/pivotal_response_interfaces/r1_unanimity_v1.json"
r1_m_path <- "model_redesign/pivotal_response_interfaces/r1_majority_v1.json"
protected_path <- "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv"
checks_path <- "tables/pivotal_response_institutional_comparison_checks_v1.csv"
pair_path <- "tables/pivotal_response_institutional_comparison_pair_fixtures_v1.csv"
status_logic_path <- "tables/pivotal_response_institutional_comparison_status_logic_v1.csv"
boundary_path <- "tables/pivotal_response_institutional_comparison_boundaries_v1.csv"

required <- c(
  interface_path, note_path, batch_path, u_path, m_path, r1_u_path, r1_m_path,
  protected_path
)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing comparison artifacts: ", paste(missing, collapse = ", "))

expected <- c(
  entry_batch = "8817a9c505ce9e5b79deea1b38055d88a629e740e324fbcd5bca707b108b5433",
  entry_unanimity = "05e39ad2b84ede134268ffae0898c8cafd8f3de01ef725ca2da6159156a83ed6",
  entry_majority = "4eb343ce6f6fb7c34782e708a0e787908437d2682d079e91f26103706c083f21"
)

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

resolve_components <- function(parent_path, components) {
  parent_dir <- dirname(normalizePath(parent_path, mustWork = TRUE))
  vapply(components, function(x) {
    normalizePath(file.path(parent_dir, x$path), mustWork = TRUE)
  }, character(1))
}

component_hashes_match <- function(parent_path, components) {
  paths <- resolve_components(parent_path, components)
  declared <- vapply(components, function(x) x$sha256, character(1))
  actual <- unname(vapply(paths, sha256_file, character(1)))
  identical(actual, declared)
}

eq <- function(x, y, tol = 1e-11) isTRUE(abs(x - y) <= tol)

formation <- function(g, chi) as.integer(g + 1e-12 >= chi)

pattern_label <- function(e_u, e_m) {
  if (e_u == 1L && e_m == 1L) return("both")
  if (e_u == 1L && e_m == 0L) return("U_only")
  if (e_u == 0L && e_m == 1L) return("M_only")
  "neither"
}

compare_values <- function(g_u, g_m, c1h_u, c1h_m, o, mu, chi) {
  e_u <- formation(g_u, chi)
  e_m <- formation(g_m, chi)
  w_u <- e_u * (g_u - chi)
  w_m <- e_m * (g_m - chi)
  h_u <- e_u * c1h_u + (1L - e_u) * o
  h_m <- e_m * c1h_m + (1L - e_m) * o
  h_u_mu <- (1 - mu) * h_u[[1L]] + mu * h_u[[2L]]
  h_m_mu <- (1 - mu) * h_m[[1L]] + mu * h_m[[2L]]
  list(
    e_u = e_u, e_m = e_m, pattern = pattern_label(e_u, e_m),
    w_u = w_u, w_m = w_m, delta_w = w_u - w_m,
    h_u = h_u, h_m = h_m, delta_h = h_u - h_m,
    h_u_mu = h_u_mu, h_m_mu = h_m_mu, delta_h_mu = h_u_mu - h_m_mu
  )
}

possible_form <- function(lower, upper, upper_attained, chi) {
  chi < upper - 1e-12 || (eq(chi, upper) && isTRUE(upper_attained))
}

possible_no <- function(lower, upper, upper_attained, chi) {
  lower < chi - 1e-12
}

status_exists <- function(desc_u, desc_m, chi) {
  pf_u <- possible_form(desc_u$lower, desc_u$upper, desc_u$upper_attained, chi)
  pn_u <- possible_no(desc_u$lower, desc_u$upper, desc_u$upper_attained, chi)
  pf_m <- possible_form(desc_m$lower, desc_m$upper, desc_m$upper_attained, chi)
  pn_m <- possible_no(desc_m$lower, desc_m$upper, desc_m$upper_attained, chi)
  c(
    both = pf_u && pf_m,
    U_only = pf_u && pn_m,
    M_only = pn_u && pf_m,
    neither = pn_u && pn_m
  )
}

possible_cost_subset <- function(upper_a, attained_a, upper_b, attained_b) {
  upper_a < upper_b - 1e-12 ||
    (eq(upper_a, upper_b) && (!isTRUE(attained_a) || isTRUE(attained_b)))
}

possible_cost_equal <- function(upper_a, attained_a, upper_b, attained_b) {
  eq(upper_a, upper_b) && identical(isTRUE(attained_a), isTRUE(attained_b))
}

universal_strict_subset <- function(upper_a, upper_attained_a, lower_b, lower_attained_b) {
  upper_a < lower_b - 1e-12 ||
    (eq(upper_a, lower_b) && !(isTRUE(upper_attained_a) && isTRUE(lower_attained_b)))
}

in_possible_cost_set <- function(chi, upper, attained) {
  chi >= -1e-12 && (chi < upper - 1e-12 || (eq(chi, upper) && isTRUE(attained)))
}

in_guaranteed_cost_set <- function(chi, lower) {
  chi >= -1e-12 && chi <= lower + 1e-12
}

make_full_alpha <- function(id, m, o, seed_offset) {
  set.seed(91000L + seed_offset)
  z_count <- 2L
  weights <- matrix(NA_real_, nrow = m, ncol = z_count)
  weak <- array(0, dim = c(m, z_count, 2L, m))
  hegemon <- array(0, dim = c(m, z_count, 2L))
  outcomes <- array("", dim = c(m, z_count, 2L))
  for (i in seq_len(m)) {
    raw_w <- stats::runif(z_count, 0.05, 1)
    weights[i, ] <- raw_w / sum(raw_w)
    for (z in seq_len(z_count)) {
      for (theta_index in seq_len(2L)) {
        total_weak <- stats::runif(1L, 0, 1)
        identity_raw <- stats::runif(m, 0.02, 1)
        weak[i, z, theta_index, ] <- total_weak * identity_raw / sum(identity_raw)
        hegemon[i, z, theta_index] <- o[[theta_index]] +
          stats::runif(1L, 0, 1) * (1 - o[[theta_index]])
        outcomes[i, z, theta_index] <- paste(id, "i", i, "z", z, "t", theta_index - 1L, sep = "_")
      }
    }
  }
  list(
    id = id,
    m = m,
    sigma_weights = weights,
    weak_payoff = weak,
    H_payoff = hegemon,
    outcome_labels = outcomes,
    strategy_fingerprint = paste0("strategy_", id),
    belief_fingerprint = paste0("belief_", id),
    continuation_fingerprint = paste0("kappa_", id)
  )
}

integrate_alpha <- function(alpha, mu) {
  m <- alpha$m
  c1_weak <- matrix(0, nrow = 2L, ncol = m)
  c1_h <- numeric(2L)
  for (theta_index in seq_len(2L)) {
    for (i in seq_len(m)) {
      for (z in seq_len(ncol(alpha$sigma_weights))) {
        weight <- alpha$sigma_weights[i, z] / m
        c1_weak[theta_index, ] <- c1_weak[theta_index, ] +
          weight * alpha$weak_payoff[i, z, theta_index, ]
        c1_h[[theta_index]] <- c1_h[[theta_index]] +
          weight * alpha$H_payoff[i, z, theta_index]
      }
    }
  }
  type_totals <- rowSums(c1_weak)
  gross <- ((1 - mu) * type_totals[[1L]] + mu * type_totals[[2L]]) / m
  list(
    id = alpha$id,
    c1_weak = c1_weak,
    c1_h = c1_h,
    type_totals = type_totals,
    gross = gross,
    outcome_fingerprint = paste(alpha$outcome_labels, collapse = "|"),
    strategy_fingerprint = alpha$strategy_fingerprint,
    belief_fingerprint = alpha$belief_fingerprint,
    continuation_fingerprint = alpha$continuation_fingerprint
  )
}

interface <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
batch <- jsonlite::fromJSON(batch_path, simplifyVector = FALSE)
entry_u <- jsonlite::fromJSON(u_path, simplifyVector = FALSE)
entry_m <- jsonlite::fromJSON(m_path, simplifyVector = FALSE)
r1_u <- jsonlite::fromJSON(r1_u_path, simplifyVector = FALSE)
r1_m <- jsonlite::fromJSON(r1_m_path, simplifyVector = FALSE)
note_text <- paste(readLines(note_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
protected <- utils::read.delim(protected_path, check.names = FALSE, quote = "", comment.char = "")

add_check(
  "candidate_identity_domain_and_status",
  identical(interface$state_id, "institutional_comparison") &&
    identical(interface$status, "candidate_pending_independent_review") &&
    identical(as.integer(interface$implementation_started_order), 54L) &&
    identical(interface$validated_common_domain$population, "integer N=m+1>=3") &&
    identical(batch$batch_close$validated_common_existence_domain, "N>=3"),
  "Candidate identity, order 54, pending-review status, and common N>=3 domain are explicit.",
  "Candidate identity, lifecycle status, order, or common domain differs."
)

dependency_roles <- vapply(interface$dependencies, function(x) x$role, character(1))
dependency_hashes <- stats::setNames(
  vapply(interface$dependencies, function(x) x$sha256, character(1)),
  dependency_roles
)
add_check(
  "literal_dependency_inventory",
  identical(dependency_roles, c(
    "frozen_entry_batch", "approved_entry_unanimity", "approved_entry_majority"
  )) &&
    identical(unname(dependency_hashes), unname(expected)),
  "The comparison consumes exactly the entry batch, entry-U, and entry-M frozen hashes.",
  "Dependency roles, order, or hashes differ."
)

add_check(
  "exact_dependency_bytes",
  identical(sha256_file(batch_path), expected[["entry_batch"]]) &&
    identical(sha256_file(u_path), expected[["entry_unanimity"]]) &&
    identical(sha256_file(m_path), expected[["entry_majority"]]),
  "All three direct dependency files match the literal approved SHA-256 values.",
  "At least one direct dependency byte stream changed."
)

add_check(
  "entry_batch_component_closure",
  identical(batch$status, "pass") && length(batch$components) == 19L &&
    component_hashes_match(batch_path, batch$components),
  "The PASS entry batch and all 19 hashed components remain exact.",
  "The entry batch status, component inventory, or a component hash differs."
)

approved_reviews <- stats::setNames(batch$node_reviews, vapply(batch$node_reviews, function(x) x$node, character(1)))
add_check(
  "approved_entry_hashes_in_batch",
  identical(approved_reviews$entry_unanimity$approved_sha256, expected[["entry_unanimity"]]) &&
    identical(approved_reviews$entry_majority$approved_sha256, expected[["entry_majority"]]),
  "The batch independently approved the exact two entry hashes consumed here.",
  "A consumed entry hash is not the independently approved hash."
)

add_check(
  "no_upstream_rederivation_or_rediscount",
  isTRUE(entry_u$dependency_discipline$no_r1_or_c2_rederivation) &&
    identical(as.integer(entry_u$dependency_discipline$downstream_discount_application_count), 0L) &&
    grepl("no R1 or C2", entry_m$upstream_consumption$no_rederivation, fixed = TRUE) &&
    grepl("no additional beta", entry_m$upstream_consumption$discount, fixed = TRUE) &&
    grepl("no R1, C2, or entry object is rederived", interface$implementation_role, fixed = TRUE),
  "No R1/C2/entry rederivation and no downstream rediscount are encoded.",
  "The dependency discipline or payoff date is not preserved."
)

add_check(
  "Cartesian_product_and_full_payload",
  grepl("A_U(P) x A_M(P)", interface$counterfactual_comparison_protocol$comparison_index_set, fixed = TRUE) &&
    grepl("full Cartesian product", interface$counterfactual_comparison_protocol$comparison_index_set, fixed = TRUE) &&
    grepl("alpha_U and alpha_M whole", interface$counterfactual_comparison_protocol$retained_payload, fixed = TRUE) &&
    grepl("no endogenous rule-choice", interface$counterfactual_comparison_protocol$fixed_rules, fixed = TRUE),
  "The full uncoupled product retains both complete assessments under fixed rules.",
  "A coupling, scalarization, or endogenous rule-choice interpretation entered."
)

add_check(
  "exact_pair_operator_fields",
  grepl("1{G_R>=chi}", interface$pairwise_operator$formation_indicator, fixed = TRUE) &&
    grepl("e_R*(G_R-chi)", interface$pairwise_operator$weak_realized_collective_net, fixed = TRUE) &&
    grepl("e_R*C1_R,H", interface$pairwise_operator$hegemon_type_payoff, fixed = TRUE) &&
    grepl("true prior", interface$pairwise_operator$hegemon_ex_ante_payoff, fixed = TRUE) &&
    grepl("complete rule-specific", interface$pairwise_operator$outcome_retention, fixed = TRUE),
  "Formation, weak, H-type, true-prior, delta, and outcome-retention fields are exact.",
  "At least one exact pair operator coordinate is missing."
)

# Exhaust every nonempty subset of a five-point grid.
base_grid <- c(0, 0.25, 0.5, 0.75, 1)
finite_sets <- lapply(seq_len(2^length(base_grid) - 1L), function(mask) {
  base_grid[as.logical(intToBits(mask)[seq_along(base_grid)])]
})
chi_grid <- c(0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1, 1.125)

finite_status_ok <- TRUE
finite_status_count <- 0L
for (values in finite_sets) {
  desc <- list(lower = min(values), upper = max(values), upper_attained = TRUE)
  for (chi in chi_grid) {
    finite_status_count <- finite_status_count + 1L
    pf_direct <- any(values + 1e-12 >= chi)
    pn_direct <- any(values < chi - 1e-12)
    finite_status_ok <- finite_status_ok &&
      identical(possible_form(desc$lower, desc$upper, TRUE, chi), pf_direct) &&
      identical(possible_no(desc$lower, desc$upper, TRUE, chi), pn_direct)
  }
}
add_check(
  "finite_set_endpoint_logic_exhaustive",
  finite_status_ok && finite_status_count == 310L,
  "Endpoint PF/PN formulas match all 310 nonempty finite-set/cost cases.",
  paste("Finite endpoint mismatch after", finite_status_count, "cases.")
)

floor_attainment_logic_ok <- TRUE
floor_attainment_count <- 0L
for (values in finite_sets) {
  for (chi in chi_grid) {
    floor_attainment_count <- floor_attainment_count + 1L
    pn <- min(values) < chi - 1e-12
    direct_no_element <- any(values < chi - 1e-12)
    all_no <- all(values < chi - 1e-12)
    direct_all_no <- max(values) < chi - 1e-12
    floor_attainment_logic_ok <- floor_attainment_logic_ok &&
      identical(pn, direct_no_element) && identical(all_no, direct_all_no)
  }
}
add_check(
  "H_floor_attainment_on_no_form_elements",
  floor_attainment_logic_ok && floor_attainment_count == 310L,
  "All 310 finite-set cases confirm chi>l_R iff a no-form element attains H's exact outside vector.",
  "The no-form H-floor attainment condition failed."
)

cross_pattern_ok <- TRUE
cross_pattern_count <- 0L
global_nesting_ok <- TRUE
global_strict_ok <- TRUE
global_nesting_count <- 0L
projection_nesting_ok <- TRUE
for (values_u in finite_sets) {
  desc_u <- list(lower = min(values_u), upper = max(values_u), upper_attained = TRUE)
  for (values_m in finite_sets) {
    desc_m <- list(lower = min(values_m), upper = max(values_m), upper_attained = TRUE)
    global_nesting_count <- global_nesting_count + 1L
    all_u_in_m <- all(outer(values_u, values_m, `<=`))
    all_m_in_u <- all(outer(values_m, values_u, `<=`))
    global_nesting_ok <- global_nesting_ok &&
      identical(all_u_in_m, max(values_u) <= min(values_m)) &&
      identical(all_m_in_u, max(values_m) <= min(values_u))
    all_strict_u_in_m <- all(outer(values_u, values_m, `<`))
    all_strict_m_in_u <- all(outer(values_m, values_u, `<`))
    global_strict_ok <- global_strict_ok &&
      identical(all_strict_u_in_m,
                universal_strict_subset(max(values_u), TRUE, min(values_m), TRUE)) &&
      identical(all_strict_m_in_u,
                universal_strict_subset(max(values_m), TRUE, min(values_u), TRUE))
    projection_nesting_ok <- projection_nesting_ok &&
      identical(max(values_u) <= max(values_m),
                possible_cost_subset(max(values_u), TRUE, max(values_m), TRUE)) &&
      identical(max(values_m) <= max(values_u),
                possible_cost_subset(max(values_m), TRUE, max(values_u), TRUE)) &&
      identical(min(values_u) <= min(values_m),
                all(seq(0, min(values_u), length.out = 11L) <= min(values_m) + 1e-12)) &&
      identical(min(values_m) <= min(values_u),
                all(seq(0, min(values_m), length.out = 11L) <= min(values_u) + 1e-12))
    for (chi in chi_grid) {
      cross_pattern_count <- cross_pattern_count + 1L
      actual <- c(
        both = any(values_u >= chi) && any(values_m >= chi),
        U_only = any(values_u >= chi) && any(values_m < chi),
        M_only = any(values_u < chi) && any(values_m >= chi),
        neither = any(values_u < chi) && any(values_m < chi)
      )
      predicted <- status_exists(desc_u, desc_m, chi)
      cross_pattern_ok <- cross_pattern_ok && identical(unname(actual), unname(predicted))
    }
  }
}
add_check(
  "Cartesian_status_patterns_exhaustive",
  cross_pattern_ok && cross_pattern_count == 9610L,
  "The product PF/PN pattern formulas match all 9,610 finite cross-set/cost cases.",
  paste("Cross-product pattern mismatch after", cross_pattern_count, "cases.")
)
add_check(
  "global_nesting_endpoint_iff_exhaustive",
  global_nesting_ok && global_nesting_count == 961L,
  "Both global nesting iff conditions match all 961 finite value-set pairs.",
  paste("Global nesting mismatch after", global_nesting_count, "set pairs.")
)
add_check(
  "global_strict_nesting_attainment_iff",
  global_strict_ok && global_nesting_count == 961L,
  "Strict universal cross-pair nesting and its endpoint-attainment condition match all 961 finite set pairs.",
  "The strict global nesting endpoint condition failed."
)
add_check(
  "finite_possible_and_guaranteed_cost_nesting",
  projection_nesting_ok && global_nesting_count == 961L,
  "Possible-cost union and guaranteed-cost intersection nesting pass all 961 finite set pairs.",
  "A within-rule union/intersection projection was conflated with cross-pair nesting."
)

global_equal_ok <- TRUE
for (values_u in finite_sets) {
  for (values_m in finite_sets) {
    all_equal <- all(outer(values_u, values_m, `==`))
    singleton_same <- length(values_u) == 1L && length(values_m) == 1L &&
      eq(values_u[[1L]], values_m[[1L]])
    global_equal_ok <- global_equal_ok && identical(all_equal, singleton_same)
  }
}
add_check(
  "global_equality_singleton_iff",
  global_equal_ok,
  "All cross-pair formation sets are equal exactly for the same singleton threshold.",
  "The global-equality singleton characterization failed."
)

open_cases <- list(
  list(id = "closed_open_at_upper", lower = 0.1, upper = 0.6, upper_attained = FALSE,
       chi = 0.6, expected_pf = FALSE, expected_pn = TRUE),
  list(id = "open_closed_at_lower", lower = 0.1, upper = 0.6, upper_attained = TRUE,
       chi = 0.1, expected_pf = TRUE, expected_pn = FALSE),
  list(id = "open_open_below_upper", lower = 0.1, upper = 0.6, upper_attained = FALSE,
       chi = 0.59, expected_pf = TRUE, expected_pn = TRUE),
  list(id = "singleton_equality", lower = 0.3, upper = 0.3, upper_attained = TRUE,
       chi = 0.3, expected_pf = TRUE, expected_pn = FALSE),
  list(id = "singleton_above", lower = 0.3, upper = 0.3, upper_attained = TRUE,
       chi = 0.31, expected_pf = FALSE, expected_pn = TRUE)
)
open_ok <- all(vapply(open_cases, function(x) {
  identical(possible_form(x$lower, x$upper, x$upper_attained, x$chi), x$expected_pf) &&
    identical(possible_no(x$lower, x$upper, x$upper_attained, x$chi), x$expected_pn)
}, logical(1)))
add_check(
  "open_endpoint_and_attainment_boundaries",
  open_ok,
  "Attained, unattained, open-endpoint, singleton, and equality cases all obey PF/PN logic.",
  "An open or attained endpoint boundary was classified incorrectly."
)

projection_descriptor_ok <- TRUE
strict_descriptor_ok <- TRUE
projection_descriptor_count <- 0L
projection_grid <- c(0.2, 0.5, 0.8)
for (upper_u in projection_grid) for (upper_m in projection_grid) {
  for (attained_u in c(FALSE, TRUE)) for (attained_m in c(FALSE, TRUE)) {
    projection_descriptor_count <- projection_descriptor_count + 1L
    costs <- sort(unique(c(seq(0, 1, by = 0.025), upper_u, upper_m)))
    direct_u_in_m <- all(vapply(costs, function(chi) {
      !in_possible_cost_set(chi, upper_u, attained_u) ||
        in_possible_cost_set(chi, upper_m, attained_m)
    }, logical(1)))
    direct_m_in_u <- all(vapply(costs, function(chi) {
      !in_possible_cost_set(chi, upper_m, attained_m) ||
        in_possible_cost_set(chi, upper_u, attained_u)
    }, logical(1)))
    direct_equal <- all(vapply(costs, function(chi) {
      identical(
        in_possible_cost_set(chi, upper_u, attained_u),
        in_possible_cost_set(chi, upper_m, attained_m)
      )
    }, logical(1)))
    projection_descriptor_ok <- projection_descriptor_ok &&
      identical(direct_u_in_m,
                possible_cost_subset(upper_u, attained_u, upper_m, attained_m)) &&
      identical(direct_m_in_u,
                possible_cost_subset(upper_m, attained_m, upper_u, attained_u)) &&
      identical(direct_equal,
                possible_cost_equal(upper_u, attained_u, upper_m, attained_m))
  }
}
strict_endpoints <- c(0.2, 0.5, 0.8)
for (upper_a in strict_endpoints) for (lower_b in strict_endpoints) {
  for (attained_a in c(FALSE, TRUE)) for (attained_b in c(FALSE, TRUE)) {
    predicted <- universal_strict_subset(upper_a, attained_a, lower_b, attained_b)
    direct <- if (upper_a < lower_b - 1e-12) {
      TRUE
    } else if (upper_a > lower_b + 1e-12) {
      FALSE
    } else {
      !(attained_a && attained_b)
    }
    strict_descriptor_ok <- strict_descriptor_ok && identical(predicted, direct)
  }
}
lower_projection_ok <- TRUE
for (lower_u in projection_grid) for (lower_m in projection_grid) {
  costs <- seq(0, 1, by = 0.025)
  direct_u_in_m <- all(vapply(costs, function(chi) {
    !in_guaranteed_cost_set(chi, lower_u) || in_guaranteed_cost_set(chi, lower_m)
  }, logical(1)))
  direct_m_in_u <- all(vapply(costs, function(chi) {
    !in_guaranteed_cost_set(chi, lower_m) || in_guaranteed_cost_set(chi, lower_u)
  }, logical(1)))
  lower_projection_ok <- lower_projection_ok &&
    identical(direct_u_in_m, lower_u <= lower_m) &&
    identical(direct_m_in_u, lower_m <= lower_u)
}
add_check(
  "open_possible_cost_attainment_and_guaranteed_sets",
  projection_descriptor_ok && lower_projection_ok && strict_descriptor_ok &&
    projection_descriptor_count == 36L,
  "All open/closed possible, guaranteed, and strict cross-pair endpoint flags satisfy their exact conditions.",
  "A possible-cost attainment flag or guaranteed-cost endpoint condition failed."
)

# Exact pairwise threshold identities on a dense deterministic grid.
pairwise_ok <- TRUE
pairwise_count <- 0L
dense <- seq(0, 1, by = 0.05)
for (g_u in dense) {
  for (g_m in dense) {
    pairwise_count <- pairwise_count + 1L
    costs <- sort(unique(c(0, g_u, g_m, (g_u + g_m) / 2, max(g_u, g_m) + 0.01)))
    statuses <- vapply(costs, function(chi) {
      pattern_label(formation(g_u, chi), formation(g_m, chi))
    }, character(1))
    predicted <- vapply(costs, function(chi) {
      if (chi <= min(g_u, g_m) + 1e-12) return("both")
      if (chi > g_m + 1e-12 && chi <= g_u + 1e-12) return("U_only")
      if (chi > g_u + 1e-12 && chi <= g_m + 1e-12) return("M_only")
      "neither"
    }, character(1))
    pairwise_ok <- pairwise_ok && identical(statuses, predicted) &&
      identical(g_u <= g_m, all(seq(0, g_u, length.out = 11L) <= g_m + 1e-12)) &&
      identical(g_m <= g_u, all(seq(0, g_m, length.out = 11L) <= g_u + 1e-12))
  }
}
add_check(
  "pairwise_threshold_and_equality_grid",
  pairwise_ok && pairwise_count == 441L,
  "Pairwise nesting and all equality-sensitive cost regions pass 441 threshold pairs.",
  paste("Pairwise threshold mismatch after", pairwise_count, "pairs.")
)

weak_curve_order_ok <- TRUE
weak_curve_count <- 0L
curve_costs <- seq(0, 1.1, by = 0.01)
for (g_u in dense) for (g_m in dense) {
  weak_curve_count <- weak_curve_count + 1L
  w_u_curve <- pmax(g_u - curve_costs, 0)
  w_m_curve <- pmax(g_m - curve_costs, 0)
  weak_curve_order_ok <- weak_curve_order_ok &&
    identical(all(w_u_curve <= w_m_curve + 1e-12), g_u <= g_m) &&
    identical(all(abs(w_u_curve - w_m_curve) <= 1e-12), eq(g_u, g_m))
}
add_check(
  "pairwise_weak_curve_order_iff",
  weak_curve_order_ok && weak_curve_count == 441L,
  "G_U<=G_M iff W_U(chi)<=W_M(chi) for every cost in all 441 threshold pairs.",
  "The pairwise weak payoff-curve ordering equivalence failed."
)

# Random complete assessments: sigma first, recognition second, type third,
# with identities, H types, and outcome fingerprints retained.
set.seed(20260812)
pair_rows <- list()
random_ok <- TRUE
random_h_floor_ok <- TRUE
random_h_rent_ok <- TRUE
random_rank_ok <- TRUE
random_bound_ok <- TRUE
random_retention_ok <- TRUE
fixture_id <- 0L
for (case_index in seq_len(96L)) {
  m_weak <- sample(2:6, 1L)
  n_states <- m_weak + 1L
  o0 <- stats::runif(1L, 0, 0.3)
  o1 <- stats::runif(1L, o0 + 0.05, 0.95)
  outside <- c(o0, o1)
  mu <- stats::runif(1L)
  alpha_u <- make_full_alpha(paste0("U", case_index), m_weak, outside, 2L * case_index)
  alpha_m <- make_full_alpha(paste0("M", case_index), m_weak, outside, 2L * case_index + 1L)
  lift_u <- integrate_alpha(alpha_u, mu)
  lift_m <- integrate_alpha(alpha_m, mu)
  chi_candidates <- c(
    0,
    lift_u$gross,
    lift_m$gross,
    1 / m_weak,
    stats::runif(1L, 0, 1 / m_weak),
    1 / m_weak + 0.02
  )
  chi <- chi_candidates[[(case_index - 1L) %% length(chi_candidates) + 1L]]
  comp <- compare_values(
    lift_u$gross, lift_m$gross, lift_u$c1_h, lift_m$c1_h, outside, mu, chi
  )
  fixture_id <- fixture_id + 1L
  pair_rows[[fixture_id]] <- data.frame(
    fixture_id = fixture_id,
    N = n_states,
    alpha_U = lift_u$id,
    alpha_M = lift_m$id,
    mu = mu,
    chi = chi,
    G_U = lift_u$gross,
    G_M = lift_m$gross,
    e_U = comp$e_u,
    e_M = comp$e_m,
    pattern = comp$pattern,
    W_U = comp$w_u,
    W_M = comp$w_m,
    Delta_W = comp$delta_w,
    C1_H_U_0 = lift_u$c1_h[[1L]],
    C1_H_U_1 = lift_u$c1_h[[2L]],
    C1_H_M_0 = lift_m$c1_h[[1L]],
    C1_H_M_1 = lift_m$c1_h[[2L]],
    H_U_0 = comp$h_u[[1L]],
    H_U_1 = comp$h_u[[2L]],
    H_M_0 = comp$h_m[[1L]],
    H_M_1 = comp$h_m[[2L]],
    Delta_H_mu = comp$delta_h_mu,
    outcome_U_fingerprint = lift_u$outcome_fingerprint,
    outcome_M_fingerprint = lift_m$outcome_fingerprint
  )
  random_ok <- random_ok &&
    eq(sum(alpha_u$sigma_weights), m_weak) && eq(sum(alpha_m$sigma_weights), m_weak) &&
    ncol(lift_u$c1_weak) == m_weak && ncol(lift_m$c1_weak) == m_weak &&
    lift_u$gross >= -1e-12 && lift_u$gross <= 1 / m_weak + 1e-12 &&
    lift_m$gross >= -1e-12 && lift_m$gross <= 1 / m_weak + 1e-12
  random_h_floor_ok <- random_h_floor_ok &&
    all(lift_u$c1_h + 1e-12 >= outside) && all(lift_m$c1_h + 1e-12 >= outside) &&
    all(comp$h_u + 1e-12 >= outside) && all(comp$h_m + 1e-12 >= outside)
  rent_u <- lift_u$c1_h - outside
  rent_m <- lift_m$c1_h - outside
  random_h_rent_ok <- random_h_rent_ok &&
    all(rent_u >= -1e-12) && all(rent_m >= -1e-12) &&
    all(abs(comp$h_u - (outside + comp$e_u * rent_u)) <= 1e-12) &&
    all(abs(comp$h_m - (outside + comp$e_m * rent_m)) <= 1e-12) &&
    all(abs(comp$delta_h - (comp$e_u * rent_u - comp$e_m * rent_m)) <= 1e-12)
  random_bound_ok <- random_bound_ok &&
    comp$w_u >= -1e-12 && comp$w_m >= -1e-12 &&
    comp$w_u <= max(1 / m_weak - chi, 0) + 1e-12 &&
    comp$w_m <= max(1 / m_weak - chi, 0) + 1e-12 &&
    abs(comp$delta_w) <= max(1 / m_weak - chi, 0) + 1e-12
  if (comp$pattern == "neither") {
    random_rank_ok <- random_rank_ok && eq(comp$delta_w, 0) &&
      all(abs(comp$delta_h) <= 1e-12)
  } else if (comp$pattern == "U_only") {
    random_rank_ok <- random_rank_ok && comp$delta_w >= -1e-12 &&
      all(comp$delta_h >= -1e-12)
  } else if (comp$pattern == "M_only") {
    random_rank_ok <- random_rank_ok && comp$delta_w <= 1e-12 &&
      all(comp$delta_h <= 1e-12)
  } else {
    random_rank_ok <- random_rank_ok && eq(comp$delta_w, lift_u$gross - lift_m$gross)
  }
  random_retention_ok <- random_retention_ok &&
    !identical(lift_u$id, lift_m$id) &&
    !identical(lift_u$outcome_fingerprint, lift_m$outcome_fingerprint) &&
    grepl("strategy_", lift_u$strategy_fingerprint, fixed = TRUE) &&
    grepl("belief_", lift_m$belief_fingerprint, fixed = TRUE) &&
    grepl("kappa_", lift_u$continuation_fingerprint, fixed = TRUE)
}
pair_fixtures <- do.call(rbind, pair_rows)
add_check(
  "random_full_alpha_integration",
  random_ok && nrow(pair_fixtures) == 96L,
  "96 randomized full asymmetric assessments preserve sigma, recognition, type, and identity accounting.",
  "A randomized full-assessment integration or resource bound failed."
)
add_check(
  "random_alpha_and_outcome_retention",
  random_retention_ok && length(unique(pair_fixtures$alpha_U)) == 96L &&
    length(unique(pair_fixtures$alpha_M)) == 96L,
  "All random pairs retain distinct whole alpha IDs, strategies, beliefs, continuations, and outcome fingerprints.",
  "A pair was scalarized, coupled, or lost a retained assessment/outcome coordinate."
)
add_check(
  "H_floor_from_complete_assessments",
  random_h_floor_ok &&
    grepl("o_theta<=C_1,U,H(theta)", r1_u$bounds_and_boundaries$hegemon_bounds, fixed = TRUE) &&
    grepl("H:o_theta", r1_m$transition_and_payoff_map[[3L]]$payoffs_R1, fixed = TRUE) &&
    grepl("H:o_theta exactly once", r1_m$transition_and_payoff_map[[4L]]$payoffs_R1, fixed = TRUE) &&
    grepl("H_response", paste(names(r1_m$fixed_proposal_fixed_point), collapse = " "), fixed = TRUE),
  "The H outside-option floor follows from frozen no-action payoffs and best response, and holds in all fixtures.",
  "The frozen H-IC basis or a fixture violates the outside-option floor."
)
add_check(
  "conditional_H_and_weak_rankings",
  random_rank_ok,
  "All four formation patterns obey the proved conditional weak and typewise-H rankings.",
  "A conditional payoff ranking failed."
)
add_check(
  "H_nonnegative_rent_decomposition",
  random_h_rent_ok,
  "All fixtures satisfy H_R=o+e_R*r_R and Delta_H=e_U*r_U-e_M*r_M with nonnegative rents.",
  "The H rent decomposition or outside-option floor failed."
)
add_check(
  "selection_free_weak_bounds",
  random_bound_ok,
  "Random fixtures satisfy 0<=W_R<=max(1/m-chi,0) and the symmetric Delta_W bound.",
  "A selection-free weak payoff bound failed."
)

true_mu_ok <- all(vapply(seq_len(nrow(pair_fixtures)), function(i) {
  row <- pair_fixtures[i, ]
  hu <- (1 - row$mu) * row$H_U_0 + row$mu * row$H_U_1
  hm <- (1 - row$mu) * row$H_M_0 + row$mu * row$H_M_1
  eq(row$Delta_H_mu, hu - hm)
}, logical(1)))
add_check(
  "true_mu_ex_ante_H_integration",
  true_mu_ok,
  "Every H ex ante delta uses the true prior after retaining both type coordinates.",
  "A fixture used a wrong belief or dropped a H type coordinate."
)

both_positive <- compare_values(0.4, 0.4, c(0.9, 0.95), c(0.4, 0.5), c(0.1, 0.2), 0.6, 0.2)
both_negative <- compare_values(0.4, 0.4, c(0.4, 0.5), c(0.9, 0.95), c(0.1, 0.2), 0.6, 0.2)
add_check(
  "both_form_H_sign_indeterminate",
  identical(both_positive$pattern, "both") && identical(both_negative$pattern, "both") &&
    both_positive$delta_h_mu > 0 && both_negative$delta_h_mu < 0,
  "Both-form fixtures support either H ranking, so no unconditional sign is imposed.",
  "The both-form H-sign indeterminacy guard failed."
)

weak_M_only_equality <- compare_values(
  0, 0.5, c(0.1, 0.2), c(0.1, 0.2), c(0.1, 0.2), 0.4, 0.25
)
weak_U_only_equality <- compare_values(
  0.5, 0, c(0.1, 0.2), c(0.1, 0.2), c(0.1, 0.2), 0.4, 0.25
)
add_check(
  "exclusive_H_rankings_not_strict",
  identical(weak_M_only_equality$pattern, "M_only") &&
    identical(weak_U_only_equality$pattern, "U_only") &&
    all(abs(weak_M_only_equality$delta_h) <= 1e-12) &&
    all(abs(weak_U_only_equality$delta_h) <= 1e-12),
  "Exclusive formation can leave H exactly at its outside option; rankings are correctly weak.",
  "An exclusive pattern was incorrectly forced to give H a strict rent."
)

# Boundaries and special endpoints.
chi_zero_ok <- TRUE
chi_above_ok <- TRUE
for (m_weak in 2:8) {
  values <- c(0, 0.37 / m_weak, 1 / m_weak)
  for (g_u in values) for (g_m in rev(values)) {
    chi_zero_ok <- chi_zero_ok &&
      identical(pattern_label(formation(g_u, 0), formation(g_m, 0)), "both")
    chi_above_ok <- chi_above_ok &&
      identical(pattern_label(
        formation(g_u, 1 / m_weak + 1e-4),
        formation(g_m, 1 / m_weak + 1e-4)
      ), "neither")
  }
}
add_check(
  "zero_cost_all_both",
  chi_zero_ok,
  "For N=3 through N=9, chi=0 makes every envelope value form under both rules.",
  "Zero-cost equality formation failed."
)
add_check(
  "cost_above_envelope_all_neither",
  chi_above_ok,
  "For N=3 through N=9, chi>1/m makes every envelope value nonform under both rules.",
  "The cost-above-resource-envelope implication failed."
)

nge4_ok <- TRUE
nge4_rows <- list()
row_id <- 0L
for (n_states in 4:10) {
  m_weak <- n_states - 1L
  for (chi in c(1e-6, 0.37 / m_weak, 1 / m_weak)) {
    comp <- compare_values(
      0, 1 / m_weak,
      c(0.1, 0.6), c(0.1, 0.6), c(0.1, 0.6), 0.45, chi
    )
    expected_delta_w <- -(1 / m_weak - chi)
    nge4_ok <- nge4_ok && identical(comp$pattern, "M_only") &&
      all(abs(comp$delta_h) <= 1e-12) && eq(comp$delta_w, expected_delta_w)
    row_id <- row_id + 1L
    nge4_rows[[row_id]] <- data.frame(
      case_id = paste0("Nge4_M_only_", row_id), N = n_states, chi = chi,
      G_U = 0, G_M = 1 / m_weak, pattern = comp$pattern,
      claim_scope = "existence_not_universal"
    )
  }
}
add_check(
  "Nge4_M_only_existence_including_upper_equality",
  nge4_ok && row_id == 21L,
  "The U=0/M=1/m pair is M_only in 21 cases, has H equality, and has weak delta -(1/m-chi).",
  "The N>=4 special-endpoint existence construction failed."
)

nge4_projection_ok <- TRUE
for (m_weak in 3:9) {
  upper_m <- 1 / m_weak
  lower_u <- 0
  for (upper_u in c(0, 0.37 / m_weak, 1 / m_weak)) {
    for (attained_u in c(FALSE, TRUE)) {
      if (upper_u == 0 && !attained_u) next
      nge4_projection_ok <- nge4_projection_ok &&
        possible_cost_subset(upper_u, attained_u, upper_m, TRUE)
    }
  }
  for (lower_m in c(0, 0.23 / m_weak, 1 / m_weak)) {
    nge4_projection_ok <- nge4_projection_ok && lower_u <= lower_m
  }
  nge4_projection_ok <- nge4_projection_ok &&
    !(upper_m <= lower_u) # universal cross-assessment M-in-U fails
}
add_check(
  "Nge4_three_nesting_notions",
  nge4_projection_ok &&
    grepl("K_M_exists=[0,1/m]", interface$special_endpoint_consequences$Nge4_possible_cost_nesting, fixed = TRUE) &&
    grepl("K_U_forall={0}", interface$special_endpoint_consequences$Nge4_guaranteed_cost_nesting, fixed = TRUE) &&
    grepl("do not prove universal cross-assessment U-in-M", interface$special_endpoint_consequences$logical_scope, fixed = TRUE),
  "N>=4 possible-cost U-in-M, guaranteed-cost U-in-M, and failed universal M-in-U are kept distinct.",
  "The three N>=4 nesting notions were conflated or overstated."
)

n3_u <- c(0.2, 0.35)
n3_m <- c(0.1, 0.4)
n3_no_import <- min(n3_u) > 0 && max(n3_m) < 0.5 &&
  grepl("not imported at N=3", interface$special_endpoint_consequences$N3_status, fixed = TRUE)
add_check(
  "N3_special_endpoints_not_imported",
  n3_no_import,
  "An admissible N=3 synthetic correspondence shows why U=0 and M=1/m are not inferred.",
  "The N=3 boundary improperly imported N>=4 special endpoints."
)

# A same-rank coupling can hide a violating cross-pair.
false_u <- c(0.1, 0.8)
false_m <- c(0.3, 0.9)
same_rank_passes <- all(false_u <= false_m)
full_product_fails <- !all(outer(false_u, false_m, `<=`))
endpoint_detects <- max(false_u) > min(false_m)
possible_projection_passes <- max(false_u) <= max(false_m)
guaranteed_projection_passes <- min(false_u) <= min(false_m)
add_check(
  "false_nesting_coupling_negative_test",
  same_rank_passes && possible_projection_passes && guaranteed_projection_passes &&
    full_product_fails && endpoint_detects,
  "Same-rank, possible-cost, and guaranteed-cost U-in-M can all hold while universal cross-pair nesting fails.",
  "The forbidden coupling mutation was not detected."
)

proposer_value <- 0.325
proposer_same <- c(proposer_value, proposer_value)
collective_values <- c(0.275, 0.5)
proposal_statuses <- vapply(collective_values, formation, integer(1), chi = 0.4)
continuum_v <- seq(0, 1, length.out = 101L)
continuum_collective <- rep(0.5, length(continuum_v))
add_check(
  "proposer_projection_negative_tests",
  length(unique(proposer_same)) == 1L && identical(proposal_statuses, c(0L, 1L)) &&
    length(unique(continuum_v)) == 101L && length(unique(continuum_collective)) == 1L,
  "Equal proposer payoffs can imply different entry, while a proposer continuum can map to one collective value.",
  "A proposer-payoff projection incorrectly determined collective entry."
)

add_check(
  "fixed_rule_no_signaling_language",
  grepl("no endogenous rule-choice", interface$counterfactual_comparison_protocol$fixed_rules, fixed = TRUE) &&
    grepl("no endogenous rule-choice or signaling", note_text, fixed = TRUE) &&
    grepl("outside the game", interface$claim_status$endogenous_rule_choice_or_signaling, fixed = TRUE),
  "Rule choice remains fixed and no counterfactual difference is interpreted as signaling.",
  "Endogenous rule choice or signaling entered the comparison."
)

add_check(
  "claims_calibrated_to_proofs",
  identical(interface$claim_status$Cartesian_product_comparison, "proved") &&
    grepl("general numeric ordering pending", interface$claim_status$selection_free_global_nesting_iff, fixed = TRUE) &&
    identical(interface$claim_status$universal_institutional_dominance, "pending and not claimed") &&
    identical(interface$review$review_status, "pending"),
  "Proved, pending, rejected, and review statuses are calibrated to the available results.",
  "A global ranking or independent review was overstated."
)

# Dependency mutation guards: change one declared digest at a time.
dependency_valid <- function(record) {
  roles <- vapply(record$dependencies, function(x) x$role, character(1))
  hashes <- stats::setNames(vapply(record$dependencies, function(x) x$sha256, character(1)), roles)
  identical(
    unname(hashes[c("frozen_entry_batch", "approved_entry_unanimity", "approved_entry_majority")]),
    unname(expected)
  )
}
add_check(
  "dependency_baseline_valid",
  dependency_valid(interface),
  "The unmutated three-hash dependency bundle is valid.",
  "The baseline dependency validator rejected the candidate."
)
for (mutation_index in seq_along(interface$dependencies)) {
  mutated <- clone_record(interface)
  original_first <- substring(mutated$dependencies[[mutation_index]]$sha256, 1L, 1L)
  replacement_first <- if (identical(original_first, "0")) "1" else "0"
  mutated$dependencies[[mutation_index]]$sha256 <- paste0(
    replacement_first, substring(mutated$dependencies[[mutation_index]]$sha256, 2L)
  )
  add_check(
    paste0("dependency_mutation_guard_", mutation_index),
    !dependency_valid(mutated),
    paste("Mutation", mutation_index, "of 3 invalidates the comparison dependency bundle."),
    paste("Mutation", mutation_index, "was not detected.")
  )
}

manifest_columns <- c("path", "sha256", "category", "frozen_at_head")
protected_actual <- vapply(protected$path, sha256_file, character(1))
protected_ok <- file.exists(protected$path) & !is.na(protected_actual) &
  protected_actual == protected$sha256
add_check(
  "protected_manifest_and_27_hashes",
  identical(names(protected), manifest_columns) && nrow(protected) == 27L && all(protected_ok),
  "All 27 protected manuscripts, historical artifacts, and reports remain byte-identical.",
  paste("Protected mismatch:", paste(protected$path[!protected_ok], collapse = ", "))
)

# Machine-readable status-logic table: representative finite, open, and product cases.
status_rows <- list()
status_id <- 0L
for (x in open_cases) {
  status_id <- status_id + 1L
  status_rows[[status_id]] <- data.frame(
    case_id = x$id,
    set_class = "endpoint_descriptor",
    lower_U = x$lower,
    upper_U = x$upper,
    upper_U_attained = x$upper_attained,
    lower_M = x$lower,
    upper_M = x$upper,
    upper_M_attained = x$upper_attained,
    chi = x$chi,
    PF_U = possible_form(x$lower, x$upper, x$upper_attained, x$chi),
    PN_U = possible_no(x$lower, x$upper, x$upper_attained, x$chi),
    PF_M = possible_form(x$lower, x$upper, x$upper_attained, x$chi),
    PN_M = possible_no(x$lower, x$upper, x$upper_attained, x$chi),
    both_exists = status_exists(x, x, x$chi)[["both"]],
    U_only_exists = status_exists(x, x, x$chi)[["U_only"]],
    M_only_exists = status_exists(x, x, x$chi)[["M_only"]],
    neither_exists = status_exists(x, x, x$chi)[["neither"]]
  )
}
descriptor_pairs <- list(
  list(id = "M_upper_unattained", u = list(lower = 0.1, upper = 0.7, upper_attained = TRUE),
       m = list(lower = 0.2, upper = 0.7, upper_attained = FALSE), chi = 0.7),
  list(id = "U_upper_unattained", u = list(lower = 0.1, upper = 0.7, upper_attained = FALSE),
       m = list(lower = 0.2, upper = 0.7, upper_attained = TRUE), chi = 0.7),
  list(id = "interior_all_patterns", u = list(lower = 0.1, upper = 0.8, upper_attained = TRUE),
       m = list(lower = 0.2, upper = 0.9, upper_attained = TRUE), chi = 0.5),
  list(id = "lower_equal_no_possible_no", u = list(lower = 0.2, upper = 0.8, upper_attained = TRUE),
       m = list(lower = 0.2, upper = 0.9, upper_attained = TRUE), chi = 0.2)
)
for (x in descriptor_pairs) {
  status_id <- status_id + 1L
  status <- status_exists(x$u, x$m, x$chi)
  status_rows[[status_id]] <- data.frame(
    case_id = x$id,
    set_class = "cross_rule_descriptor",
    lower_U = x$u$lower,
    upper_U = x$u$upper,
    upper_U_attained = x$u$upper_attained,
    lower_M = x$m$lower,
    upper_M = x$m$upper,
    upper_M_attained = x$m$upper_attained,
    chi = x$chi,
    PF_U = possible_form(x$u$lower, x$u$upper, x$u$upper_attained, x$chi),
    PN_U = possible_no(x$u$lower, x$u$upper, x$u$upper_attained, x$chi),
    PF_M = possible_form(x$m$lower, x$m$upper, x$m$upper_attained, x$chi),
    PN_M = possible_no(x$m$lower, x$m$upper, x$m$upper_attained, x$chi),
    both_exists = status[["both"]],
    U_only_exists = status[["U_only"]],
    M_only_exists = status[["M_only"]],
    neither_exists = status[["neither"]]
  )
}
status_logic <- do.call(rbind, status_rows)

boundary_rows <- do.call(rbind, nge4_rows)
boundary_rows <- rbind(
  data.frame(
    case_id = "N3_no_special_endpoint_import", N = 3L, chi = 0.3,
    G_U = 0.2, G_M = 0.4, pattern = "M_only",
    claim_scope = "illustration_not_universal_endpoint"
  ),
  data.frame(
    case_id = "chi_zero_equality", N = 4L, chi = 0,
    G_U = 0, G_M = 0, pattern = "both", claim_scope = "universal"
  ),
  data.frame(
    case_id = "chi_above_envelope", N = 4L, chi = 0.34,
    G_U = 1 / 3, G_M = 1 / 3, pattern = "neither", claim_scope = "universal"
  ),
  boundary_rows
)

utils::write.csv(checks, checks_path, row.names = FALSE, na = "")
utils::write.csv(pair_fixtures, pair_path, row.names = FALSE, na = "")
utils::write.csv(status_logic, status_logic_path, row.names = FALSE, na = "")
utils::write.csv(boundary_rows, boundary_path, row.names = FALSE, na = "")

failures <- checks$check_id[checks$status != "PASS"]
cat(sprintf("Institutional comparison verifier: %d/%d PASS\n", sum(checks$status == "PASS"), nrow(checks)))
cat(sprintf("Finite endpoint cases: %d\n", finite_status_count))
cat(sprintf("Cartesian status cases: %d\n", cross_pattern_count))
cat(sprintf("Global nesting set pairs: %d\n", global_nesting_count))
cat(sprintf("Random complete assessment pairs: %d\n", nrow(pair_fixtures)))
cat(sprintf("Protected hashes: %d\n", sum(protected_ok)))
if (length(failures)) {
  cat("FAILED checks:\n")
  cat(paste0("- ", failures, collapse = "\n"), "\n")
  quit(status = 1L)
}
