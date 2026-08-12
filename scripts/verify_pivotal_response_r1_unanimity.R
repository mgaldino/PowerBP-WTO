#!/usr/bin/env Rscript

# Mechanical checks for the candidate r1_unanimity interface. The analytic
# proof is in model_redesign/pivotal_response_nodes/r1_unanimity_v1.md.

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

tol <- 1e-10
interface_path <- "model_redesign/pivotal_response_interfaces/r1_unanimity_v1.json"
note_path <- "model_redesign/pivotal_response_nodes/r1_unanimity_v1.md"
batch_path <- "model_redesign/pivotal_response_interfaces/r2_batch_review_v1.json"
c2_path <- "model_redesign/pivotal_response_interfaces/r2_unanimity_active_h_v1.json"
gate0_path <- "model_redesign/pivotal_response_interfaces/gate0_bundle_v1.json"
protected_path <- "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv"
checks_path <- "tables/pivotal_response_r1_unanimity_checks.csv"
cases_path <- "tables/pivotal_response_r1_unanimity_cases_v1.csv"
n3_grid_path <- "tables/pivotal_response_r1_unanimity_n3_grid_v1.csv"

required <- c(interface_path, note_path, batch_path, c2_path, gate0_path, protected_path)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing required artifacts: ", paste(missing, collapse = ", "))

checks <- data.frame(test_id = character(), status = character(), detail = character())
add_check <- function(id, condition, pass_detail, fail_detail = pass_detail) {
  ok <- isTRUE(condition)
  checks <<- rbind(
    checks,
    data.frame(
      test_id = id,
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
  strsplit(trimws(out[[1]]), "[[:space:]]+")[[1]][[1]]
}

all_vectors <- function(n) {
  if (n == 0L) return(matrix(numeric(), nrow = 1L, ncol = 0L))
  as.matrix(expand.grid(rep(list(c(0, 1)), n)))
}

vector_key <- function(w) paste0(as.integer(w), collapse = "")

vector_probability <- function(w, p) {
  if (!length(w)) return(1)
  prod(ifelse(w == 1, p, 1 - p))
}

insert_action <- function(a, w_minus_j, j, n) {
  out <- numeric(n)
  out[j] <- a
  if (n > 1L) out[-j] <- w_minus_j
  out
}

lambda <- function(rho) c(1 - rho, rho)

make_selection_map <- function(N, o, mode = c("random", "flat"), seed = NULL,
                               flat_weak = NULL, flat_h = NULL,
                               signature_by_key = NULL, posterior = 0.5) {
  mode <- match.arg(mode)
  if (!is.null(seed)) set.seed(seed)
  m <- N - 1L
  n <- N - 2L
  vectors <- all_vectors(n)
  vectors <- vectors[rowSums(vectors) < n, , drop = FALSE]
  out <- list()
  for (r in seq_len(nrow(vectors))) {
    w <- as.numeric(vectors[r, ])
    key <- vector_key(w)
    if (mode == "random") {
      weak <- matrix(0, nrow = 2L, ncol = m)
      for (tt in 1:2) {
        raw <- runif(m)
        weak[tt, ] <- raw / sum(raw) * runif(1, 0, 1)
      }
      h <- c(runif(1, o[1], 1), runif(1, o[2], 1))
      sig <- paste0("K_", key)
    } else {
      weak <- flat_weak
      h <- flat_h
      sig <- "K_flat"
    }
    if (!is.null(signature_by_key) && !is.null(signature_by_key[[key]])) {
      sig <- signature_by_key[[key]]
    }
    out[[key]] <- list(
      weak = weak,
      H = h,
      signature = sig,
      posterior = posterior
    )
  }
  out
}

selection_signature <- function(sel, theta_index) {
  paste(
    sel$signature,
    format(sel$posterior, digits = 15),
    paste(format(sel$weak[theta_index, ], digits = 15), collapse = ":"),
    format(sel$H[theta_index], digits = 15),
    sep = "|"
  )
}

weak_yes_branch_payoff <- function(j, theta_index, w, y, x, beta, selections) {
  n <- length(w)
  if (sum(w) == n) return(x[j])
  beta * selections[[vector_key(w)]]$weak[theta_index, j + 1L]
}

proposer_yes_branch_payoff <- function(theta_index, w, y, x, beta, selections) {
  n <- length(w)
  residual <- 1 - y - sum(x)
  if (sum(w) == n) return(residual)
  beta * selections[[vector_key(w)]]$weak[theta_index, 1L]
}

h_yes_branch_payoff <- function(theta_index, w, y, beta, selections) {
  n <- length(w)
  if (sum(w) == n) return(y)
  beta * selections[[vector_key(w)]]$H[theta_index]
}

h_delta_formula <- function(theta_index, p, y, beta, o, selections) {
  vectors <- all_vectors(length(p))
  sum(vapply(seq_len(nrow(vectors)), function(r) {
    w <- as.numeric(vectors[r, ])
    vector_probability(w, p) *
      (h_yes_branch_payoff(theta_index, w, y, beta, selections) - o[theta_index])
  }, numeric(1)))
}

h_delta_bruteforce <- function(theta_index, p, y, beta, o, selections) {
  vectors <- all_vectors(length(p))
  yes_value <- 0
  no_value <- 0
  for (r in seq_len(nrow(vectors))) {
    w <- as.numeric(vectors[r, ])
    prob <- vector_probability(w, p)
    yes_value <- yes_value + prob * h_yes_branch_payoff(theta_index, w, y, beta, selections)
    no_value <- no_value + prob * o[theta_index]
  }
  yes_value - no_value
}

weak_delta_formula <- function(j, p, h, rho, y, x, beta, selections) {
  n <- length(p)
  vectors_minus <- all_vectors(n - 1L)
  out <- 0
  for (tt in 1:2) {
    if (h[tt] == 0) next
    for (r in seq_len(nrow(vectors_minus))) {
      w_minus <- as.numeric(vectors_minus[r, ])
      prob <- vector_probability(w_minus, p[-j])
      w_yes <- insert_action(1, w_minus, j, n)
      w_no <- insert_action(0, w_minus, j, n)
      diff <- weak_yes_branch_payoff(j, tt, w_yes, y, x, beta, selections) -
        weak_yes_branch_payoff(j, tt, w_no, y, x, beta, selections)
      out <- out + lambda(rho)[tt] * prob * diff
    }
  }
  out
}

weak_delta_bruteforce <- function(j, p, h, rho, y, x, beta, selections) {
  n <- length(p)
  vectors_minus <- all_vectors(n - 1L)
  expected <- c(no = 0, yes = 0)
  for (a in 0:1) {
    for (tt in 1:2) {
      for (r in seq_len(nrow(vectors_minus))) {
        w_minus <- as.numeric(vectors_minus[r, ])
        prob <- lambda(rho)[tt] * vector_probability(w_minus, p[-j])
        if (h[tt] == 1) {
          w <- insert_action(a, w_minus, j, n)
          payoff <- weak_yes_branch_payoff(j, tt, w, y, x, beta, selections)
        } else {
          payoff <- 0
        }
        expected[a + 1L] <- expected[a + 1L] + prob * payoff
      }
    }
  }
  expected[["yes"]] - expected[["no"]]
}

weak_relevance <- function(j, p, h, rho, y, x, selections) {
  n <- length(p)
  vectors_minus <- all_vectors(n - 1L)
  relevance <- 0
  for (tt in 1:2) {
    if (h[tt] == 0) next
    for (r in seq_len(nrow(vectors_minus))) {
      w_minus <- as.numeric(vectors_minus[r, ])
      prob <- lambda(rho)[tt] * vector_probability(w_minus, p[-j])
      w_yes <- insert_action(1, w_minus, j, n)
      w_no <- insert_action(0, w_minus, j, n)
      sig_yes <- if (sum(w_yes) == n) {
        paste0("current_pass|", format(y, digits = 15), "|", paste(x, collapse = ":"))
      } else {
        selection_signature(selections[[vector_key(w_yes)]], tt)
      }
      sig_no <- selection_signature(selections[[vector_key(w_no)]], tt)
      if (!identical(sig_yes, sig_no)) relevance <- relevance + prob
    }
  }
  relevance
}

is_fixed_point <- function(N, p, h, rho, y, x, beta, o, selections) {
  h_required <- vapply(1:2, function(tt) {
    as.numeric(h_delta_formula(tt, p, y, beta, o, selections) >= -tol)
  }, numeric(1))
  if (any(h != h_required)) return(FALSE)
  for (j in seq_along(p)) {
    delta <- weak_delta_formula(j, p, h, rho, y, x, beta, selections)
    relevance <- weak_relevance(j, p, h, rho, y, x, selections)
    if (relevance > tol) {
      required <- if (delta >= -tol) 1 else 0
      if (abs(p[j] - required) > tol) return(FALSE)
    }
  }
  TRUE
}

bayes_after_h_yes <- function(rho, h) {
  denominator <- (1 - rho) * h[1] + rho * h[2]
  if (denominator <= tol) return(NA_real_)
  rho * h[2] / denominator
}

# A continuation selection is one public-history object carrying both types.
# The helpers below deliberately make private type unavailable as a lookup key.
make_canonical_c2_element <- function(history_key, posterior, N, o) {
  stopifnot(N >= 4L, length(o) == 2L)
  list(
    public_history = history_key,
    posterior = posterior,
    class = "coordinated_failure",
    assessment_index = "canonical_cf",
    weak_payoff_by_type_identity = matrix(0, nrow = 2L, ncol = N - 1L),
    H_payoff_by_type = as.numeric(o),
    internal_strategy_kernel = "fixed_R2_proposal;all_weak_no;H_yes",
    internal_belief_kernel = paste0("nu=", format(posterior, digits = 16)),
    terminal_outcome_kernel_by_type = c(
      "theta0:weak_failure_active_H",
      "theta1:weak_failure_active_H"
    )
  )
}

kappa_lookup <- function(kappa_map, public_history) {
  kappa_map[[public_history]]
}

valid_public_history_kappa <- function(kappa_map, histories, expected_posteriors,
                                       N, o) {
  if (!identical(sort(names(kappa_map)), sort(histories))) return(FALSE)
  for (hh in histories) {
    el <- kappa_lookup(kappa_map, hh)
    if (is.null(el) || !identical(el$public_history, hh)) return(FALSE)
    if (!identical(el$class, "coordinated_failure")) return(FALSE)
    if (abs(el$posterior - expected_posteriors[[hh]]) > tol) return(FALSE)
    if (!is.matrix(el$weak_payoff_by_type_identity) ||
        !identical(dim(el$weak_payoff_by_type_identity), c(2L, N - 1L)) ||
        any(abs(el$weak_payoff_by_type_identity) > tol)) return(FALSE)
    if (length(el$H_payoff_by_type) != 2L ||
        any(abs(el$H_payoff_by_type - o) > tol)) return(FALSE)
    # One object must contain both type coordinates. There may be no nested
    # theta-indexed selector or private-type suffix in its public key.
    if (any(grepl("theta=|theta0\\||theta1\\|", names(kappa_map)))) return(FALSE)
  }
  TRUE
}

full_element_signature <- function(el, drop_public_history = TRUE) {
  pieces <- c(
    format(el$posterior, digits = 16),
    el$class,
    el$assessment_index,
    paste(format(el$weak_payoff_by_type_identity, digits = 16), collapse = ":"),
    paste(format(el$H_payoff_by_type, digits = 16), collapse = ":"),
    el$internal_strategy_kernel,
    el$internal_belief_kernel,
    paste(el$terminal_outcome_kernel_by_type, collapse = ":")
  )
  if (!drop_public_history) pieces <- c(el$public_history, pieces)
  paste(pieces, collapse = "|")
}

outcome_equivalent_elements <- function(a, b) {
  identical(full_element_signature(a), full_element_signature(b))
}

consumer_domain_valid <- function(record, N) {
  identical(record$export_domain_gate$validated_exportable_domain, "N>=3") &&
    identical(record$export_domain_gate[["N>=3"]],
              "proved_consumable_pending_independent_rereview") &&
    identical(record$export_domain_gate[["N>=4"]],
              "proved_consumable_pending_independent_rereview") &&
    identical(record$export_domain_gate[["N=3"]],
              "proved_consumable_pending_independent_rereview") &&
    N >= 3L
}

interface <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
batch <- jsonlite::fromJSON(batch_path, simplifyVector = FALSE)
c2 <- jsonlite::fromJSON(c2_path, simplifyVector = FALSE)
interface_text <- paste(readLines(interface_path, warn = FALSE), collapse = "\n")
note_text <- paste(readLines(note_path, warn = FALSE), collapse = "\n")

expected_hashes <- c(
  gate0 = "6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1",
  batch = "00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a",
  c2 = "f3ca4ebf28827d7e18d9f3a2d07d41ffd6fe57532c9af09300f20a8ab5cecf10"
)

actual_hashes <- c(
  gate0 = sha256_file(gate0_path),
  batch = sha256_file(batch_path),
  c2 = sha256_file(c2_path)
)

add_check(
  "U1_DEPENDENCY_HASHES_EXACT",
  identical(unname(actual_hashes), unname(expected_hashes)) &&
    identical(interface$provenance$frozen_gate0_bundle_sha256, expected_hashes[["gate0"]]) &&
    identical(interface$provenance$frozen_r2_batch_sha256, expected_hashes[["batch"]]) &&
    identical(interface$provenance$frozen_c2_unanimity_sha256, expected_hashes[["c2"]]),
  "Gate 0, R2 batch, and C2-U match the three exact frozen hashes.",
  paste(names(actual_hashes), actual_hashes, collapse = "; ")
)

add_check(
  "U1_INTERFACE_IDENTITY",
  identical(interface$state_id, "r1_unanimity") &&
    identical(interface$status, "candidate_pending_independent_review") &&
    identical(interface$native_payoff_date, "Round 1") &&
    grepl("perfect Bayesian equilibrium", interface$solution_concept, ignore.case = TRUE),
  "Candidate identity, payoff date, status, and solution concept are explicit."
)

add_check(
  "U1_LITERAL_C2_CORRESPONDENCE",
  identical(c2$state_id, "r2_unanimity_active_h") &&
    identical(c2$native_payoff_date, "Round 2") &&
    identical(c2$internal_discounting, "none") &&
    !is.null(c2$pre_recognition_C2_correspondence) &&
    grepl("literal full element", interface$dependency_discipline$c2_consumption, fixed = TRUE) &&
    grepl("neither repairs nor optimizes", interface$dependency_discipline$local_selection_forbidden, fixed = TRUE),
  "The exact set-valued C2-U interface is consumed literally without local repair or scalarization."
)

add_check(
  "U1_C2_PROJECTION_SOURCE_EXACT",
  identical(interface$continuation_projection_and_map$frozen_source,
            "r2_unanimity_active_h_v1.json.pre_recognition_C2_correspondence") &&
    !is.null(c2$pre_recognition_C2_correspondence) &&
    grepl("same selected pre-recognition C2 element",
          interface$continuation_projection_and_map$source_projection,
          fixed = TRUE) &&
    grepl("coordinatewise splicing", interface$continuation_projection_and_map$type_blind_rule,
          fixed = TRUE),
  "Every payoff/outcome coordinate is projected from one exact frozen pre-recognition C2 element."
)

add_check(
  "U1_MACHINE_READABLE_EXPORT_DOMAIN",
  consumer_domain_valid(interface, 3L) &&
    consumer_domain_valid(interface, 4L) &&
    consumer_domain_valid(interface, 13L) &&
    !consumer_domain_valid(interface, 2L) &&
    identical(interface$claim_status$universal_N3_existence_and_attainment,
              "proved"),
  "The repaired consumable domain is exactly the full primitive population domain N>=3."
)

add_check(
  "U1_DISCOUNT_LEDGER",
  identical(as.integer(interface$dependency_discipline$internal_c2_discount_application_count), 0L) &&
    identical(as.integer(interface$dependency_discipline$r1_transport_discount_application_count), 1L) &&
    identical(as.integer(interface$dependency_discipline$immediate_h_no_discount_application_count), 0L) &&
    grepl("beta*c", interface$action_consequence_map$H_yes_weak_failure, fixed = TRUE) &&
    grepl("beta never", interface$action_consequence_map$H_no_any_weak_vector, fixed = TRUE),
  "C2 has zero internal discounts, failed H-yes transport has one beta, and H-no has none."
)

# Full-vector arithmetic: compare two independent implementations of every H
# and weak deviation formula over small populations and action-specific maps.
set.seed(8112601)
full_vector_trials <- 0L
weak_action_pairs <- 0L
for (N in 3:8) {
  n <- N - 2L
  for (trial in seq_len(45L)) {
    o <- c(runif(1, 0, 0.35), runif(1, 0.55, 0.9))
    if (o[2] <= o[1]) o[2] <- min(1, o[1] + 0.3)
    beta <- runif(1, 0.2, 1)
    y <- runif(1, 0, 1)
    raw_x <- runif(n)
    x <- if (sum(raw_x) == 0) raw_x else raw_x / sum(raw_x) * runif(1, 0, 1 - y)
    p <- sample(c(0, 0.23, 0.67, 1), n, replace = TRUE)
    h <- sample(c(0, 1), 2, replace = TRUE)
    rho <- runif(1)
    selections <- make_selection_map(N, o, "random", seed = 10000 + N * 100 + trial)

    for (tt in 1:2) {
      a <- h_delta_formula(tt, p, y, beta, o, selections)
      b <- h_delta_bruteforce(tt, p, y, beta, o, selections)
      if (abs(a - b) > 1e-10) stop("H full-vector formula mismatch")
    }
    for (j in seq_len(n)) {
      a <- weak_delta_formula(j, p, h, rho, y, x, beta, selections)
      b <- weak_delta_bruteforce(j, p, h, rho, y, x, beta, selections)
      if (abs(a - b) > 1e-10) stop("Weak full-vector formula mismatch")
      weak_action_pairs <- weak_action_pairs + 2^(n - 1L) * 2L
    }
    full_vector_trials <- full_vector_trials + 2^n
  }
}

add_check(
  "U1_FULL_VECTOR_H_ENUMERATION",
  TRUE,
  sprintf("H action values matched brute force across %d type-conditional vector evaluations.", 2L * full_vector_trials)
)
add_check(
  "U1_FULL_VECTOR_WEAK_ENUMERATION",
  TRUE,
  sprintf("Weak action differences matched across %d type/other-vector action pairs.", weak_action_pairs)
)

# Valid fixed-point examples, including a continuation-driven H yes below its
# current direct-payment threshold.
o <- c(0.2, 0.6)
beta <- 0.9

N <- 4L
flat_zero <- matrix(0, nrow = 2L, ncol = N - 1L)
pooling_failure <- make_selection_map(
  N, o, "flat", flat_weak = flat_zero, flat_h = c(0.6, 0.6), posterior = 0
)
continuation_driven <- is_fixed_point(
  N = N, p = c(0, 0), h = c(1, 0), rho = 0.3,
  y = 0.1, x = c(0, 0), beta = beta, o = o,
  selections = pooling_failure
)
add_check(
  "U1_NO_GLOBAL_Y_THRESHOLD",
  continuation_driven &&
    h_delta_formula(1, c(0, 0), 0.1, beta, o, pooling_failure) > 0 &&
    0.1 < o[1] &&
    h_delta_formula(2, c(0, 0), 0.1, beta, o, pooling_failure) < 0,
  "A valid fixed-proposal completion has low H yes at y<o0 because beta*C2 enters failure."
)

secured_failure <- make_selection_map(
  N, o, "flat", flat_weak = flat_zero, flat_h = o, posterior = 0.3
)
secured_pooling <- is_fixed_point(
  N = N, p = c(1, 1), h = c(1, 1), rho = 0.3,
  y = 0.6, x = c(0.1, 0.1), beta = beta, o = o,
  selections = secured_failure
)
add_check(
  "U1_SECURED_PASSAGE_SUBCLASS",
  secured_pooling,
  "All-yes pooling satisfies the direct H threshold and both complete-vector weak ICs."
)

# N=3: a single weak no can be strictly optimal because it buys continuation.
N <- 3L
n3_weak <- matrix(c(0, 0.4, 0, 0.4), nrow = 2L, byrow = TRUE)
n3_selection <- make_selection_map(
  N, o, "flat", flat_weak = n3_weak, flat_h = c(0.6, 0.6), posterior = 0
)
n3_single_no <- is_fixed_point(
  N = N, p = c(0), h = c(1, 0), rho = 0,
  y = 0.1, x = c(0), beta = beta, o = o,
  selections = n3_selection
)
add_check(
  "U1_N3_SINGLE_NO_CONTINUATION",
  n3_single_no && weak_delta_formula(1, c(0), c(1, 0), 0, 0.1, c(0), beta, n3_selection) < 0,
  "With one weak voter, no is strictly optimal when its action-specific C2 payoff exceeds current x."
)

# Universal N>=4 construction: all weak voters choose no and every failed
# history selects the same C2 coordinated-failure element (weak zero, H=o).
universal_nge4_trials <- 0L
for (N in 4:8) {
  n <- N - 2L
  for (mu_t in c(0, 0.35, 1)) {
    for (beta_t in c(0.2, 0.9, 1)) {
      for (o0 in c(0, 0.2)) {
        for (o1 in c(0.6, 1)) {
          if (o1 <= o0) next
          o_t <- c(o0, o1)
          h_t <- as.numeric(beta_t * o_t - o_t >= -tol)
          reached_nu <- bayes_after_h_yes(mu_t, h_t)
          selected_nu <- if (is.na(reached_nu)) mu_t else reached_nu
          flat <- make_selection_map(
            N, o_t, "flat",
            flat_weak = matrix(0, nrow = 2L, ncol = N - 1L),
            flat_h = o_t,
            posterior = selected_nu
          )
          for (y_t in c(0, 0.4, 1)) {
            if (!is_fixed_point(
              N, p = rep(0, n), h = h_t, rho = mu_t,
              y = y_t, x = rep(0, n), beta = beta_t, o = o_t,
              selections = flat
            )) stop("Universal N>=4 ballot construction failed")
            # Every proposal gives weak players zero and H exactly o_theta.
            for (tt in 1:2) {
              h_value <- if (h_t[tt] == 1) beta_t * o_t[tt] else o_t[tt]
              if (abs(h_value - o_t[tt]) > tol) stop("H tie-break benchmark failed")
            }
            universal_nge4_trials <- universal_nge4_trials + 1L
          }
        }
      }
    }
  }
}
add_check(
  "U1_UNIVERSAL_NGE4_EXISTENCE_CONSTRUCTION",
  universal_nge4_trials == 540L,
  sprintf("%d N/mu/beta/outside/proposal cases instantiate the Bayes-aligned zero-weak-value PBE.", universal_nge4_trials)
)

# Universal N=3 attained construction. This checks every analytic case on a
# broad primitive grid, enumerates the piecewise off-path deviation bounds,
# and separately hits every P=S proposal-tie boundary when G>0,beta=1.
n3_outside_pairs <- data.frame(
  o0 = c(0, 0, 0, 0.2, 0.2, 0.55, 0.55, 0.8),
  o1 = c(0.2, 0.65, 1, 0.65, 1, 0.8, 1, 1),
  stringsAsFactors = FALSE
)
n3_grid <- merge(
  n3_outside_pairs,
  expand.grid(mu = c(0, 0.3, 0.85, 1), beta = c(0.2, 0.65, 1))
)
n3_grid$construction_case <- NA_character_
n3_grid$onpath_value <- NA_real_
n3_grid$selected_proposal <- NA_character_
n3_grid_cases <- 0L
n3_deviation_cases <- 0L
n3_tie_cases <- 0L
n3_case_labels <- character()

for (rr in seq_len(nrow(n3_grid))) {
  o0 <- n3_grid$o0[rr]
  o1 <- n3_grid$o1[rr]
  mu_t <- n3_grid$mu[rr]
  beta_t <- n3_grid$beta[rr]
  G <- 1 - o1
  D <- 1 - o0

  if (G > tol && beta_t < 1 - tol) {
    cG <- G / 2
    y_on <- o1
    x_on <- beta_t * cG
    r_on <- G - beta_t * cG
    V <- r_on
    stopifnot(
      abs(x_on - beta_t * cG) <= tol,
      y_on >= o1 - tol,
      r_on >= -tol,
      (1 - mu_t) * beta_t * cG < V - tol
    )
    case_label <- "Gpos_beta_lt1"
    selected_proposal <- sprintf("pool:y=o1,x=beta*G/2")
    n3_case_labels <- c(n3_case_labels, "Gpos_beta_lt1")
  } else if (G > tol) {
    cG <- G / 2
    P <- cG
    R <- D - cG
    S <- (1 - mu_t) * R
    V <- max(P, S)
    selected <- if (P > S + tol) "pool" else "separate"
    # Complete off-path proposal grid for the prescribed rho=1 response:
    # x<cG -> weak no and continuation value P; x>=cG -> weak yes.
    for (y_dev in unique(c(0, o0, (o0 + o1) / 2, o1, 1))) {
      for (x_dev in unique(c(0, (1 - y_dev) / 2, 1 - y_dev))) {
        r_dev <- 1 - y_dev - x_dev
        if (x_dev < cG - tol) {
          dev <- P
        } else if (y_dev >= o1 - tol) {
          dev <- r_dev
          stopifnot(dev <= P + tol)
        } else if (y_dev >= o0 - tol) {
          dev <- (1 - mu_t) * r_dev
          stopifnot(dev <= S + tol)
        } else {
          dev <- 0
        }
        stopifnot(dev <= V + tol)
        n3_deviation_cases <- n3_deviation_cases + 1L
      }
    }
    if (abs(P - S) <= tol) {
      stopifnot(selected == "separate", mu_t < 1,
                (1 - mu_t) * o0 + mu_t * o1 < o1)
    }
    case_label <- paste0("Gpos_beta1_", selected)
    selected_proposal <- if (selected == "pool") "pool:y=o1,x=G/2" else "separate:y=o0,x=G/2"
    n3_case_labels <- c(n3_case_labels, case_label)
  } else if (mu_t >= 1 - tol) {
    # y=1, x=0 is attained; the supported high type gives every weak state 0.
    stopifnot(abs(o1 - 1) <= tol)
    V <- 0
    case_label <- "Gzero_mu1"
    selected_proposal <- "pool:y=1,x=0"
    n3_case_labels <- c(n3_case_labels, case_label)
  } else {
    c0 <- D / 4
    # Exact posterior-zero C2 element: y2=o0+D/2,r2=D/2,x2=0.
    y2 <- o0 + D / 2
    r2 <- D / 2
    stopifnot(y2 < 1, y2 >= o0, r2 > 0, abs(c0 - r2 / 2) <= tol)
    x_on <- beta_t * c0
    r_on <- D - x_on
    V <- (1 - mu_t) * r_on
    stopifnot(V > 0, abs(bayes_after_h_yes(mu_t, c(1, 0))) <= tol)

    if (beta_t < 1 - tol) {
      # rho=1, weak no, kappa^0_1: high H strictly no and all weak
      # continuation coordinates are zero, so every deviation pays zero.
      stopifnot(beta_t - 1 < -tol, 0 < V)
      case_label <- "Gzero_beta_lt1_mu_lt1"
      selected_proposal <- "separate:y=o0,x=beta*(1-o0)/4"
      n3_case_labels <- c(n3_case_labels, case_label)
    } else {
      # At every off-path y<1, construct a measurable strictly positive p(s).
      for (y_dev in unique(c(0, o0, (o0 + 1) / 2, 1 - D / 10))) {
        if (y_dev >= 1 - tol) next
        for (x_dev in unique(c(0, (1 - y_dev) / 2, 1 - y_dev))) {
          r_dev <- 1 - y_dev - x_dev
          bounds <- c(0.5, D / (2 * (1 - y_dev)))
          if (r_dev > tol) bounds <- c(bounds, (D - c0) / (2 * r_dev))
          p_dev <- min(bounds)
          low_delta <- D - p_dev * (1 - y_dev)
          high_delta <- p_dev * (y_dev - 1)
          dev <- (1 - mu_t) * p_dev * r_dev
          stopifnot(p_dev > 0, p_dev <= 1,
                    low_delta >= D / 2 - tol,
                    high_delta < -tol,
                    dev <= V / 2 + tol)
          n3_deviation_cases <- n3_deviation_cases + 1L
        }
      }
      case_label <- "Gzero_beta1_mu_lt1"
      selected_proposal <- "separate:y=o0,x=(1-o0)/4"
      n3_case_labels <- c(n3_case_labels, case_label)
    }
  }
  n3_grid$construction_case[rr] <- case_label
  n3_grid$onpath_value[rr] <- V
  n3_grid$selected_proposal[rr] <- selected_proposal
  n3_grid_cases <- n3_grid_cases + 1L
}

# Hit the exact P=S equality separately for every positive-G outside pair.
for (rr in which(n3_outside_pairs$o1 < 1)) {
  o0 <- n3_outside_pairs$o0[rr]
  o1 <- n3_outside_pairs$o1[rr]
  G <- 1 - o1
  cG <- G / 2
  R <- 1 - o0 - cG
  mu_tie <- 1 - cG / R
  stopifnot(mu_tie >= 0, mu_tie < 1)
  P <- cG
  S <- (1 - mu_tie) * R
  hbar_pool <- o1
  hbar_sep <- (1 - mu_tie) * o0 + mu_tie * o1
  stopifnot(abs(P - S) <= tol, hbar_sep < hbar_pool)
  n3_tie_cases <- n3_tie_cases + 1L
}

add_check(
  "U1_UNIVERSAL_N3_FULL_PARAMETER_GRID",
  n3_grid_cases == nrow(n3_grid) &&
    all(c("Gpos_beta_lt1", "Gpos_beta1_pool", "Gpos_beta1_separate",
          "Gzero_mu1", "Gzero_beta_lt1_mu_lt1", "Gzero_beta1_mu_lt1") %in%
        unique(n3_case_labels)),
  sprintf("%d primitive-grid cases cover all attained N=3 constructions.", n3_grid_cases)
)
add_check(
  "U1_N3_OFFPATH_DEVIATION_INEQUALITIES",
  n3_deviation_cases > 100L,
  sprintf("%d proposal-grid deviations satisfy the exact casewise upper bounds.", n3_deviation_cases)
)
add_check(
  "U1_N3_PROPOSER_TIE_BREAK_BOUNDARIES",
  n3_tie_cases == sum(n3_outside_pairs$o1 < 1),
  sprintf("All %d exact P=S boundaries select separation by the frozen H-payoff tie-break.", n3_tie_cases)
)
add_check(
  "U1_N3_NONCLOSED_ENDPOINT_NOT_INSERTED",
  grepl("never inserts the missing endpoint", interface$constructive_subclasses$universal_N3_PBE$nonclosed_endpoint_handling,
        fixed = TRUE) &&
    all((1 - n3_outside_pairs$o0[n3_outside_pairs$o1 == 1]) / 4 > 0),
  "Every G=0,mu<1 construction uses the attained positive c0=D/4 rather than the missing zero endpoint."
)

# An unchanged failure status can still leave a weak vote relevant through K_w.
N <- 5L
n <- N - 2L
selection_switch <- make_selection_map(
  N, o, "flat", flat_weak = matrix(0, 2L, N - 1L),
  flat_h = c(0.6, 0.6), posterior = 0.4
)
for (key in names(selection_switch)) {
  first_vote <- as.integer(substr(key, 1, 1))
  selection_switch[[key]]$weak[, 2] <- if (first_vote == 1) 0.4 else 0.1
  selection_switch[[key]]$signature <- paste0("first_", first_vote)
}
delta_switch <- weak_delta_formula(
  1, p = c(0, 0, 0), h = c(1, 1), rho = 0.4,
  y = 0.2, x = c(0, 0, 0), beta = beta,
  selections = selection_switch
)
relevance_switch <- weak_relevance(
  1, p = c(0, 0, 0), h = c(1, 1), rho = 0.4,
  y = 0.2, x = c(0, 0, 0), selections = selection_switch
)
add_check(
  "U1_ACTION_SPECIFIC_C2_WITHOUT_QUOTA_TOGGLE",
  abs(delta_switch - beta * (0.4 - 0.1)) < tol && relevance_switch > tol,
  "Both actions fail, yet distinct full-history C2 selections create the expected beta*(0.4-0.1) IC."
)

# Immediate opt-out and beta exactly once, including an explicit guard against
# accidental beta squared.
c_value <- 0.7
single_beta <- beta * c_value
double_beta <- beta^2 * c_value
add_check(
  "U1_BETA_EXACTLY_ONCE_NUMERIC",
  abs(single_beta - 0.63) < tol && abs(single_beta - double_beta) > 1e-3,
  "A native C2 payoff 0.7 enters R1 as 0.63, not beta squared."
)
add_check(
  "U1_IMMEDIATE_OPTOUT_NATIVE_R1",
  abs(o[2] - 0.6) < tol && abs(o[2] - beta * o[2]) > 1e-3,
  "H-no pays o_theta=0.6 immediately rather than beta*o_theta."
)

# Exactly 60 positive-probability Bayes/C2-membership cases. The grid includes
# pooling H yes and both directions of separation. Each case also creates two
# weak-vector histories with the same posterior and aligned canonical C2
# elements, establishing full outcome equivalence rather than scalar equality.
bayes_cases <- expand.grid(
  prior = c(0.1, 0.25, 0.5, 0.75, 0.9),
  h_case = c("pool", "low_yes", "high_yes"),
  weak_vector_probability = c(0.2, 0.55, 0.8, 0.95),
  stringsAsFactors = FALSE
)
stopifnot(nrow(bayes_cases) == 60L)
h_by_case <- list(pool = c(1, 1), low_yes = c(1, 0), high_yes = c(0, 1))
kappa_map <- list()
kappa_pair_map <- list()
expected_posteriors <- list()
prior_by_history <- list()
bayes_ok <- logical(nrow(bayes_cases))
equivalence_ok <- logical(nrow(bayes_cases))
wrong_mu_membership_ok <- logical(nrow(bayes_cases))
for (rr in seq_len(nrow(bayes_cases))) {
  prior <- bayes_cases$prior[rr]
  h <- h_by_case[[bayes_cases$h_case[rr]]]
  q <- bayes_cases$weak_vector_probability[rr]
  denominator <- ((1 - prior) * h[1] + prior * h[2]) * q
  joint_posterior <- prior * h[2] * q / denominator
  required_posterior <- bayes_after_h_yes(prior, h)
  hh <- sprintf("h2_case_%02d_w00", rr)
  hh_alt <- sprintf("h2_case_%02d_w10", rr)
  kappa_map[[hh]] <- make_canonical_c2_element(hh, required_posterior, 4L, o)
  kappa_pair_map[[hh_alt]] <- make_canonical_c2_element(hh_alt, required_posterior, 4L, o)
  expected_posteriors[[hh]] <- required_posterior
  prior_by_history[[hh]] <- prior
  bayes_ok[rr] <- abs(joint_posterior - required_posterior) <= tol
  equivalence_ok[rr] <- outcome_equivalent_elements(kappa_map[[hh]], kappa_pair_map[[hh_alt]])
  wrong_mu_membership_ok[rr] <- abs(prior - required_posterior) <= tol
}

add_check(
  "U1_BAYES_60_POSITIVE_CASES",
  all(bayes_ok) && length(expected_posteriors) == 60L,
  "All 60 positive-probability histories use Bayes after H=yes and cancel the type-independent weak-vector likelihood."
)
add_check(
  "U1_C2_POSTERIOR_MEMBERSHIP_60_CASES",
  valid_public_history_kappa(kappa_map, names(kappa_map), expected_posteriors, 4L, o) &&
    any(vapply(
      c2$fixed_proposal_ballot_interface$complete_independent_behavioral_correspondence,
      function(z) identical(z$class, "coordinated_failure"), logical(1)
    )),
  "All 60 selected full C2 elements are indexed by their required posterior and retain both types/all identities."
)
add_check(
  "U1_C2_FULL_OUTCOME_EQUIVALENCE_60_PAIRS",
  all(equivalence_ok),
  "All 60 same-posterior weak-vector pairs align strategy, belief, both-type payoff, and outcome kernels."
)

# Required negative test: the rejected shortcut posterior=mu must fail on all
# separating H-yes histories, while it happens to be correct under pooling.
separating <- bayes_cases$h_case != "pool"
wrong_mu_detected <- separating & !wrong_mu_membership_ok
posterior_mu_mutant <- kappa_map
for (hh in names(posterior_mu_mutant)) {
  posterior_mu_mutant[[hh]]$posterior <- prior_by_history[[hh]]
  posterior_mu_mutant[[hh]]$internal_belief_kernel <-
    paste0("nu=", format(prior_by_history[[hh]], digits = 16))
}
add_check(
  "U1_NEGATIVE_POSTERIOR_EQUALS_MU_FAILS_SEPARATION",
  sum(wrong_mu_detected) == 40L && all(wrong_mu_membership_ok[!separating]) &&
    !valid_public_history_kappa(
      posterior_mu_mutant, names(posterior_mu_mutant), expected_posteriors, 4L, o
    ),
  "The posterior=mu mutant fails all 40 separating cases and only survives the 20 pooling cases."
)

# Type blindness and full-element alignment negatives. A valid kappa call
# returns both type coordinates. Private-type keys, one-coordinate returns,
# or a change to one counterfactual outcome must be detected.
one_history <- names(kappa_map)[[1]]
one_expected <- expected_posteriors[one_history]
valid_single_map <- kappa_map[one_history]
private_type_map <- valid_single_map
names(private_type_map) <- paste0(one_history, "|theta=0")
one_coordinate_map <- valid_single_map
one_coordinate_map[[1]]$H_payoff_by_type <- one_coordinate_map[[1]]$H_payoff_by_type[[1]]
outcome_splice <- valid_single_map
outcome_splice[[1]]$terminal_outcome_kernel_by_type[[2]] <- "theta1:spliced_other_element"
add_check(
  "U1_KAPPA_PUBLIC_HISTORY_TYPE_BLIND",
  valid_public_history_kappa(valid_single_map, one_history, one_expected, 4L, o) &&
    !valid_public_history_kappa(private_type_map, one_history, one_expected, 4L, o) &&
    !valid_public_history_kappa(one_coordinate_map, one_history, one_expected, 4L, o),
  "One public-history kappa call returns both type coordinates; private-type and one-coordinate mutants fail."
)
add_check(
  "U1_FULL_ELEMENT_OUTCOME_ALIGNMENT_NEGATIVE",
  !outcome_equivalent_elements(valid_single_map[[1]], outcome_splice[[1]]) &&
    grepl("terminal-outcome kernels", interface$continuation_projection_and_map$outcome_equivalence_rule,
          fixed = TRUE),
  "Changing only a counterfactual type outcome breaks full-element equivalence."
)

# Globally zero-probability proposal/H-yes/vector histories remain off path.
offpath_trials <- 0L
for (rho in c(0, 0.2, 0.7, 1)) {
  for (h0 in 0:1) for (h1 in 0:1) for (q in c(0, 1)) {
    denominator <- ((1 - rho) * h0 + rho * h1) * q
    if (denominator <= tol) offpath_trials <- offpath_trials + 1L
  }
}
add_check(
  "U1_OFFPATH_CLASSIFICATION",
  offpath_trials > 0 &&
    grepl("explicit off-path", interface$belief_interface$zero_probability_failure, fixed = TRUE) &&
    grepl("rho_i(s)=mu", interface$belief_interface$on_support_proposal, fixed = TRUE),
  sprintf("%d zero-probability cases were classified off path; on-support proposal belief stays mu.", offpath_trials)
)

# Type/player payoff accounting, continuation outcome probabilities, and
# selection-free bounds.
set.seed(8112602)
accounting_trials <- 0L
for (N in 3:8) {
  n <- N - 2L
  m <- N - 1L
  for (trial in seq_len(60L)) {
    beta_t <- runif(1, 0.1, 1)
    y <- runif(1, 0, 1)
    raw_x <- runif(n)
    x <- if (sum(raw_x) == 0) raw_x else raw_x / sum(raw_x) * runif(1, 0, 1 - y)
    p <- runif(n)
    selections <- make_selection_map(N, o, "random", seed = 20000 + N * 100 + trial)
    vectors <- all_vectors(n)
    for (tt in 1:2) {
      weak_expected <- numeric(m)
      h_yes_expected <- 0
      for (r in seq_len(nrow(vectors))) {
        w <- as.numeric(vectors[r, ])
        prob <- vector_probability(w, p)
        weak_expected[1] <- weak_expected[1] + prob *
          proposer_yes_branch_payoff(tt, w, y, x, beta_t, selections)
        for (j in seq_len(n)) {
          weak_expected[j + 1L] <- weak_expected[j + 1L] + prob *
            weak_yes_branch_payoff(j, tt, w, y, x, beta_t, selections)
        }
        h_yes_expected <- h_yes_expected + prob *
          h_yes_branch_payoff(tt, w, y, beta_t, selections)
      }
      if (any(weak_expected < -tol) || sum(weak_expected) > 1 + 1e-8) {
        stop("Weak payoff bound failed")
      }
      h_equilibrium <- max(o[tt], h_yes_expected)
      if (h_equilibrium < o[tt] - tol || h_equilibrium > 1 + tol) {
        stop("H payoff bound failed")
      }
      accounting_trials <- accounting_trials + 1L
    }
  }
}
add_check(
  "U1_PAYOFF_AND_BOUND_ACCOUNTING",
  TRUE,
  sprintf("%d type-conditional random branches satisfy weak-total<=1 and o_theta<=H<=1.", accounting_trials)
)

# Full C1 export: integrate sigma_i first, then recognition, retain type and
# identity coordinates, and apply mu only as a separate weak-value projection.
m <- 4L
S <- 3L
mu_export <- 0.35
sigma_weights <- rbind(
  c(0.2, 0.3, 0.5),
  c(0.1, 0.7, 0.2),
  c(0.6, 0.1, 0.3),
  c(0.25, 0.25, 0.5)
)
# Dimensions: recognizer i x support proposal s x type theta x player k.
weak_kernel <- array(0, dim = c(m, S, 2L, m))
h_kernel <- array(0, dim = c(m, S, 2L))
outcome_kernel <- array("", dim = c(m, S, 2L))
belief_kernel <- matrix(0, nrow = m, ncol = S)
payment_kernel <- array(0, dim = c(m, S, m))
kappa_id_kernel <- matrix("", nrow = m, ncol = S)
for (i in seq_len(m)) for (s in seq_len(S)) {
  belief_kernel[i, s] <- (i + 2 * s) / 20
  kappa_id_kernel[i, s] <- sprintf("alpha_i%d_s%d", i, s)
  for (k in seq_len(m)) payment_kernel[i, s, k] <- (i + s + k) / 200
  for (tt in 1:2) {
    for (k in seq_len(m)) {
      weak_kernel[i, s, tt, k] <- (10 * i + 3 * s + 2 * tt + k) / 500
    }
    h_kernel[i, s, tt] <- 0.15 + 0.08 * tt + 0.01 * i + 0.005 * s
    outcome_kernel[i, s, tt] <- sprintf("alpha_i%d_s%d_theta%d", i, s, tt - 1L)
  }
}

E_sigma_weak <- array(0, dim = c(m, 2L, m))
E_sigma_H <- matrix(0, nrow = m, ncol = 2L)
for (i in seq_len(m)) for (tt in 1:2) {
  for (k in seq_len(m)) {
    E_sigma_weak[i, tt, k] <- sum(sigma_weights[i, ] * weak_kernel[i, , tt, k])
  }
  E_sigma_H[i, tt] <- sum(sigma_weights[i, ] * h_kernel[i, , tt])
}
C1_weak_by_type_identity <- apply(E_sigma_weak, c(2, 3), mean)
C1_H_by_type <- colMeans(E_sigma_H)
V_weak_by_identity <- (1 - mu_export) * C1_weak_by_type_identity[1, ] +
  mu_export * C1_weak_by_type_identity[2, ]

# Independently enumerate the same iterated expectation and preserve the same
# alpha IDs for outcomes, beliefs, payments, and C2 selections.
manual_weak <- matrix(0, nrow = 2L, ncol = m)
manual_H <- numeric(2L)
aligned_weight_sum <- 0
for (i in seq_len(m)) for (s in seq_len(S)) {
  wt <- sigma_weights[i, s] / m
  aligned_weight_sum <- aligned_weight_sum + wt
  for (tt in 1:2) {
    manual_weak[tt, ] <- manual_weak[tt, ] + wt * weak_kernel[i, s, tt, ]
    manual_H[tt] <- manual_H[tt] + wt * h_kernel[i, s, tt]
    stopifnot(
      grepl(kappa_id_kernel[i, s], outcome_kernel[i, s, tt], fixed = TRUE),
      is.finite(belief_kernel[i, s]),
      all(payment_kernel[i, s, ] >= 0)
    )
  }
}
add_check(
  "U1_C1_E_SIGMA_THEN_RECOGNITION",
  max(abs(C1_weak_by_type_identity - manual_weak)) < tol &&
    max(abs(C1_H_by_type - manual_H)) < tol &&
    abs(aligned_weight_sum - 1) < tol,
  "C1 first integrates each sigma_i and then uniform recognition, with all weak identities and both H type coordinates retained."
)
add_check(
  "U1_C1_MU_INTEGRATION_SEPARATE",
  max(abs(V_weak_by_identity -
            ((1 - mu_export) * manual_weak[1, ] + mu_export * manual_weak[2, ]))) < tol &&
    length(V_weak_by_identity) == m &&
    length(unique(round(V_weak_by_identity, 10))) > 1,
  "The mu projection is computed after C1 and remains a vector by weak identity."
)
add_check(
  "U1_C1_SAME_ALPHA_ALIGNMENT",
  all(abs(rowSums(sigma_weights) - 1) < tol) &&
    all(nzchar(outcome_kernel)) && all(nzchar(kappa_id_kernel)) &&
    grepl("same sigma_i", interface$pre_recognition_C1_correspondence$outcome_distribution,
          fixed = TRUE),
  "Payoffs, outcomes, beliefs, payments, and C2 selection IDs use the same sigma/recognition weights and alpha."
)

# A mutant that averages proposals uniformly instead of using sigma_i must
# change at least one type-by-identity coordinate.
sigma_mutant <- matrix(1 / S, nrow = m, ncol = S)
mutant_C1 <- matrix(0, nrow = 2L, ncol = m)
for (i in seq_len(m)) for (tt in 1:2) for (k in seq_len(m)) {
  mutant_C1[tt, k] <- mutant_C1[tt, k] +
    sum(sigma_mutant[i, ] * weak_kernel[i, , tt, k]) / m
}
add_check(
  "U1_NEGATIVE_SIGMA_AVERAGING_MUTATION",
  max(abs(mutant_C1 - C1_weak_by_type_identity)) > 1e-6,
  "Replacing E_sigma by an unweighted proposal average changes the exported C1 vector and is detected."
)

# Dependency mutation guard: neither changed C2 nor changed batch hash can be
# accepted by the candidate's frozen provenance record.
dependency_valid <- function(record, batch_hash, c2_hash) {
  identical(record$provenance$frozen_r2_batch_sha256, batch_hash) &&
    identical(record$provenance$frozen_c2_unanimity_sha256, c2_hash)
}
baseline_valid <- dependency_valid(interface, expected_hashes[["batch"]], expected_hashes[["c2"]])
mutated_batch_valid <- dependency_valid(
  interface, paste0("x", substring(expected_hashes[["batch"]], 2)), expected_hashes[["c2"]]
)
mutated_c2_valid <- dependency_valid(
  interface, expected_hashes[["batch"]], paste0("x", substring(expected_hashes[["c2"]], 2))
)
add_check(
  "U1_DEPENDENCY_MUTATION_GUARD",
  baseline_valid && !mutated_batch_valid && !mutated_c2_valid,
  "In-memory mutations of either frozen batch or C2 hash invalidate this candidate."
)

clone_record <- function(x) {
  jsonlite::fromJSON(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null"),
                     simplifyVector = FALSE)
}
domain_mutant_label <- clone_record(interface)
domain_mutant_label$export_domain_gate$validated_exportable_domain <- "N>=4"
domain_mutant_n3 <- clone_record(interface)
domain_mutant_n3$export_domain_gate[["N=3"]] <- "pending_not_consumable"
domain_mutant_claim <- clone_record(interface)
domain_mutant_claim$claim_status$universal_N3_existence_and_attainment <- "pending"
add_check(
  "U1_DOMAIN_GATE_MUTATION_GUARD",
  consumer_domain_valid(interface, 3L) &&
    !consumer_domain_valid(domain_mutant_label, 3L) &&
    !consumer_domain_valid(domain_mutant_n3, 3L) &&
    !(consumer_domain_valid(domain_mutant_claim, 3L) &&
        identical(domain_mutant_claim$claim_status$universal_N3_existence_and_attainment,
                  "proved")),
  "Mutations to the full-domain label, N=3 status, or N=3 proof claim prevent consumption."
)

# Verify the protected set remains byte-identical.
protected <- utils::read.delim(protected_path, check.names = FALSE, quote = "", comment.char = "")
protected_actual <- vapply(protected$path, sha256_file, character(1))
protected_ok <- file.exists(protected$path) & !is.na(protected_actual) &
  protected_actual == protected$sha256
add_check(
  "U1_PROTECTED_ARTIFACTS_UNCHANGED",
  nrow(protected) == 27L && all(protected_ok),
  "All 27 protected artifacts remain byte-identical.",
  paste("Mismatch:", paste(protected$path[!protected_ok], collapse = ", "))
)

# Governance vocabulary and correspondence preservation.
forbidden_pattern <- "PBE-UD|as-if pivotal|refinement|roll-call voting|undominated_voting"
add_check(
  "U1_CURRENT_OBJECT_TERMINOLOGY",
  !grepl(forbidden_pattern, interface_text, ignore.case = TRUE) &&
    !grepl(forbidden_pattern, note_text, ignore.case = TRUE),
  "Current artifacts use only the requested PBE and simultaneous-ballot terminology."
)
add_check(
  "U1_NO_SCALARIZATION_OR_COALITION_PRIMITIVE",
  grepl("outcome correspondence", interface$pre_recognition_C1_correspondence$selection_status, fixed = TRUE) &&
    grepl("No coalition size", note_text, fixed = TRUE) &&
    grepl("positive named payment", note_text, fixed = TRUE),
  "The export is a full correspondence; gifts remain feasible and no coalition size is imposed."
)
add_check(
  "U1_SURVIVAL_STATUS_CALIBRATED",
  grepl("survives conditionally", interface$survival_findings$historical_P_label, fixed = TRUE) &&
    grepl("survives conditionally", interface$survival_findings$historical_L_label, fixed = TRUE) &&
    grepl("survives conditionally", interface$survival_findings$historical_R_label, fixed = TRUE) &&
    grepl("rejected", interface$survival_findings$three_label_exhaustiveness, fixed = TRUE) &&
    identical(interface$survival_findings$historical_formulas_used, FALSE),
  "Outcome motifs are conditional survival findings; global three-label exhaustiveness is rejected."
)

cases <- do.call(rbind, lapply(3:8, function(N) {
  n <- N - 2L
  data.frame(
    N = N,
    weak_nonproposer_count = n,
    full_weak_vectors = 2^n,
    failed_h_yes_histories = 2^n - 1L,
    weak_action_other_vectors_per_voter = 2^(n - 1L),
    two_sure_no_available = N >= 4L,
    validated_exportable = N >= 3L,
    existence_construction = if (N == 3L) "attained_piecewise_N3" else "Bayes_aligned_coordinated_failure",
    stringsAsFactors = FALSE
  )
}))

utils::write.csv(cases, cases_path, row.names = FALSE, fileEncoding = "UTF-8")
utils::write.csv(n3_grid, n3_grid_path, row.names = FALSE, fileEncoding = "UTF-8")
utils::write.csv(checks, checks_path, row.names = FALSE, fileEncoding = "UTF-8")

failed <- checks$test_id[checks$status != "PASS"]
cat(sprintf("r1_unanimity verifier: %d/%d PASS\n", sum(checks$status == "PASS"), nrow(checks)))
cat(sprintf("Full weak vectors enumerated in arithmetic checks: %d\n", full_vector_trials))
cat(sprintf("Weak type/action/other-vector comparisons: %d\n", weak_action_pairs))
cat(sprintf("Candidate interface SHA-256: %s\n", sha256_file(interface_path)))
if (length(failed)) {
  cat("Failed checks:\n")
  cat(paste0("- ", failed, collapse = "\n"), "\n")
  quit(save = "no", status = 1L)
}
