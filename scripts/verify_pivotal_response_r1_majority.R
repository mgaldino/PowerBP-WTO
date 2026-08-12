#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1L]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

interface_path <- "model_redesign/pivotal_response_interfaces/r1_majority_v1.json"
note_path <- "model_redesign/pivotal_response_nodes/r1_majority_v1.md"
batch_path <- "model_redesign/pivotal_response_interfaces/r2_batch_review_v1.json"
c2a_path <- "model_redesign/pivotal_response_interfaces/r2_majority_active_h_v1.json"
c2o_path <- "model_redesign/pivotal_response_interfaces/r2_majority_weak_only_v1.json"
transition_path <- "tables/pivotal_response_gate0_transitions_v1.csv"
out_path <- "tables/pivotal_response_r1_majority_checks_v1.csv"
cases_path <- "tables/pivotal_response_r1_majority_cases_v1.csv"
n3_cases_path <- "tables/pivotal_response_r1_majority_n3_projection_v1.csv"

expected <- c(
  reviewed_R2_batch = "00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a",
  C2_majority_active_H = "a4ae73e9bb4114490bbc517732eca0ff7f5368186aee1a02388a8f85f52568b2",
  C2_majority_weak_only = "e0ec6cd35e145f04d1a2897fc1f78157f2b0d45de478046ac5451b2df0a74b5d"
)

required <- c(
  interface_path, note_path, batch_path, c2a_path, c2o_path, transition_path
)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing R1-majority artifacts: ", paste(missing, collapse = ", "))

sha256_file <- function(path) {
  out <- suppressWarnings(system2("shasum", c("-a", "256", path), stdout = TRUE, stderr = FALSE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  if (!length(out) || status != 0L) return(NA_character_)
  strsplit(trimws(out[[1L]]), "[[:space:]]+")[[1L]][[1L]]
}

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

bits_matrix <- function(n) {
  if (n == 0L) return(matrix(integer(), nrow = 1L, ncol = 0L))
  as.matrix(expand.grid(rep(list(0:1), n), KEEP.OUT.ATTRS = FALSE))
}

profile_probability <- function(bits, prob) {
  if (!length(bits)) return(1)
  prod(ifelse(bits == 1L, prob, 1 - prob))
}

branch_id <- function(N, h_yes, bits) {
  q <- floor(N / 2) + 1L
  z <- 1L + sum(bits)
  if (h_yes && z >= q - 1L) return("PR04")
  if (h_yes) return("PR05")
  if (z >= q) return("PR06")
  "PR07"
}

interface <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
batch <- jsonlite::fromJSON(batch_path, simplifyVector = FALSE)
c2a <- jsonlite::fromJSON(c2a_path, simplifyVector = FALSE)
c2o <- jsonlite::fromJSON(c2o_path, simplifyVector = FALSE)
transitions <- utils::read.csv(transition_path, check.names = FALSE, na.strings = character())

actual <- c(
  reviewed_R2_batch = sha256_file(batch_path),
  C2_majority_active_H = sha256_file(c2a_path),
  C2_majority_weak_only = sha256_file(c2o_path)
)
declared <- stats::setNames(
  vapply(interface$dependencies, function(x) x$sha256, character(1)),
  vapply(interface$dependencies, function(x) x$role, character(1))
)

add_check(
  "dependency_hashes_exact",
  identical(actual[names(expected)], expected) &&
    identical(declared[names(expected)], expected) &&
    identical(batch$status, "pass"),
  "Reviewed R2 batch and both literal majority C2 hashes match exact bytes.",
  paste("actual:", paste(names(actual), actual, collapse = "; "))
)

deps_valid <- function(x) identical(x[names(expected)], expected)
mutation_results <- vapply(names(expected), function(nm) {
  mutated <- expected
  last <- substr(mutated[[nm]], 64L, 64L)
  substr(mutated[[nm]], 64L, 64L) <- if (last == "0") "1" else "0"
  !deps_valid(mutated)
}, logical(1))
add_check(
  "dependency_mutation_invalidates",
  all(mutation_results),
  "In-memory mutation of batch, active-H C2, or weak-only C2 invalidates the dependency predicate.",
  paste(names(mutation_results), mutation_results, collapse = "; ")
)

add_check(
  "interface_identity_and_date",
  identical(interface$state_id, "r1_majority") &&
    identical(interface$status, "candidate_pending_independent_review") &&
    identical(interface$native_payoff_date, "Round 1") &&
    grepl("perfect Bayesian equilibrium", interface$solution_concept, ignore.case = TRUE),
  paste("Candidate interface sha256", sha256_file(interface_path)),
  "Interface identity, status, solution concept, or native date differs."
)

gate_r1 <- transitions[transitions$round == "R1" & transitions$rule == "M", , drop = FALSE]
expected_gate <- c("PR04", "PR05", "PR06", "PR07")
add_check(
  "gate0_transition_registry_literal",
  identical(gate_r1$transition_id, expected_gate) &&
    identical(gate_r1$successor, c(
      "terminal_current_agreement", "r2_majority_active_h",
      "terminal_current_weak_only_agreement", "r2_majority_weak_only"
    )),
  "PR04--PR07 and their two literal successor interfaces match Gate 0.",
  paste(gate_r1$transition_id, gate_r1$successor, collapse = "; ")
)

# Exhaust every complete weak ballot vector for N=3,...,16 and compare the
# four branch formulas with direct total-yes quota accounting.
transition_total <- 0L
transition_errors <- 0L
case_rows <- list()
for (N in 3:16) {
  n <- N - 2L
  q <- floor(N / 2) + 1L
  profiles <- bits_matrix(n)
  branch_counts <- stats::setNames(integer(4L), expected_gate)
  for (row in seq_len(nrow(profiles))) {
    a <- as.integer(profiles[row, ])
    for (h_yes in c(FALSE, TRUE)) {
      derived <- branch_id(N, h_yes, a)
      total_yes <- 1L + sum(a) + as.integer(h_yes)
      passes <- total_yes >= q
      direct <- if (passes && h_yes) {
        "PR04"
      } else if (!passes && h_yes) {
        "PR05"
      } else if (passes) {
        "PR06"
      } else {
        "PR07"
      }
      transition_total <- transition_total + 1L
      transition_errors <- transition_errors + as.integer(derived != direct)
      branch_counts[[derived]] <- branch_counts[[derived]] + 1L
    }
  }
  case_rows[[length(case_rows) + 1L]] <- data.frame(
    N = N,
    q = q,
    weak_nonproposers = n,
    full_action_profiles = 2L * nrow(profiles),
    PR04 = branch_counts[["PR04"]],
    PR05 = branch_counts[["PR05"]],
    PR06 = branch_counts[["PR06"]],
    PR07 = branch_counts[["PR07"]]
  )
}
cases <- do.call(rbind, case_rows)
add_check(
  "full_vector_transition_enumeration",
  transition_errors == 0L && sum(cases$full_action_profiles) == transition_total,
  sprintf("Enumerated %d complete H/weak action profiles for N=3..16 with zero branch mismatches.", transition_total),
  sprintf("mismatches=%d", transition_errors)
)
add_check(
  "N3_active_failure_empty",
  cases$PR05[cases$N == 3L] == 0L,
  "At N=3, q=2 and PR05 is empty exactly as the interface states.",
  paste("N=3 PR05 count", cases$PR05[cases$N == 3L])
)

# Deterministic, history-specific continuation coordinates.  They are not
# equilibrium claims; they are sentinels for checking the R1 payoff algebra.
key_bits <- function(bits) paste0(bits, collapse = "")
cA <- function(player, theta, bits) {
  code <- sum((seq_along(bits) + 1) * bits)
  base <- switch(player, H = 0.20, i = 0.11, j = 0.07, 0.05)
  min(0.95, base + 0.09 * theta + 0.013 * code)
}
cO <- function(player, bits) {
  code <- sum((seq_along(bits) + 2) * bits)
  base <- switch(player, i = 0.17, j = 0.09, 0.04)
  min(0.95, base + 0.011 * code)
}

payoff_R1 <- function(player, N, h_yes, bits, theta, y, X, xj, beta, outside) {
  branch <- branch_id(N, h_yes, bits)
  if (branch == "PR04") {
    return(if (player == "H") y else if (player == "i") 1 - y - X else xj)
  }
  if (branch == "PR05") return(beta * cA(player, theta, bits))
  if (branch == "PR06") {
    return(if (player == "H") outside[[theta + 1L]] else if (player == "i") 1 - X else xj)
  }
  if (player == "H") return(outside[[theta + 1L]])
  beta * cO(player, bits)
}

# H-IC: brute-force subtraction over all weak vectors versus the displayed
# two-region formula, retaining a distinct active-H selection for every vector.
set.seed(20260811)
h_total <- 0L
h_errors <- 0L
for (draw in seq_len(250L)) {
  N <- sample(3:10, 1L)
  n <- N - 2L
  q <- floor(N / 2) + 1L
  profiles <- bits_matrix(n)
  p <- runif(n)
  o0 <- runif(1L, 0, 0.45)
  o1 <- runif(1L, o0 + 1e-5, 0.95)
  outside <- c(o0, o1)
  y <- runif(1L, 0, 1)
  beta <- runif(1L, 0.05, 1)
  for (theta in 0:1) {
    brute <- 0
    formula <- 0
    for (row in seq_len(nrow(profiles))) {
      a <- as.integer(profiles[row, ])
      pa <- profile_probability(a, p)
      brute <- brute + pa * (
        payoff_R1("H", N, TRUE, a, theta, y, 0, 0, beta, outside) -
          payoff_R1("H", N, FALSE, a, theta, y, 0, 0, beta, outside)
      )
      z <- 1L + sum(a)
      term <- if (z >= q - 1L) {
        y - outside[[theta + 1L]]
      } else {
        beta * cA("H", theta, a) - outside[[theta + 1L]]
      }
      formula <- formula + pa * term
    }
    h_total <- h_total + 1L
    h_errors <- h_errors + as.integer(abs(brute - formula) > 1e-12)
  }
}
add_check(
  "H_IC_full_vectors",
  h_errors == 0L,
  sprintf("Compared %d type-specific H ICs over all complete weak vectors with zero mismatches.", h_total),
  sprintf("mismatches=%d", h_errors)
)

# Weak IC: compare direct action subtraction with the three count regions in
# W-Y and W-N.  Every h2 receives a different sentinel continuation.
w_total <- 0L
w_errors <- 0L
double_failure_changes <- 0L
for (N in 3:11) {
  n <- N - 2L
  q <- floor(N / 2) + 1L
  if (n < 1L) next
  for (j in seq_len(n)) {
    other_profiles <- bits_matrix(n - 1L)
    for (row in seq_len(nrow(other_profiles))) {
      a_minus <- as.integer(other_profiles[row, ])
      make_a <- function(vote) {
        ans <- integer(n)
        ans[j] <- vote
        ans[-j] <- a_minus
        ans
      }
      a_no <- make_a(0L)
      a_yes <- make_a(1L)
      z0 <- 1L + sum(a_minus)
      for (theta in 0:1) {
        outside <- c(0.18, 0.71)
        beta <- 0.83
        xj <- 0.14
        for (h_yes in c(FALSE, TRUE)) {
          brute <- payoff_R1("j", N, h_yes, a_yes, theta, 0.31, 0.4, xj, beta, outside) -
            payoff_R1("j", N, h_yes, a_no, theta, 0.31, 0.4, xj, beta, outside)
          formula <- if (h_yes) {
            if (z0 >= q - 1L) {
              0
            } else if (z0 == q - 2L) {
              xj - beta * cA("j", theta, a_no)
            } else {
              beta * (cA("j", theta, a_yes) - cA("j", theta, a_no))
            }
          } else {
            if (z0 >= q) {
              0
            } else if (z0 == q - 1L) {
              xj - beta * cO("j", a_no)
            } else {
              beta * (cO("j", a_yes) - cO("j", a_no))
            }
          }
          w_total <- w_total + 1L
          w_errors <- w_errors + as.integer(abs(brute - formula) > 1e-12)
          both_fail <- if (h_yes) z0 <= q - 3L else z0 <= q - 2L
          if (both_fail && abs(brute) > 1e-12) {
            double_failure_changes <- double_failure_changes + 1L
          }
        }
      }
    }
  }
}
add_check(
  "weak_IC_action_specific_C2",
  w_errors == 0L && double_failure_changes > 0L,
  sprintf("Compared %d weak action differences with zero mismatches; %d double-failure comparisons detect distinct h2 selections.", w_total, double_failure_changes),
  sprintf("mismatches=%d double-failure changes=%d", w_errors, double_failure_changes)
)

# Explicit mixed-date accounting sentinels.
beta <- 0.73
outside <- c(0.19, 0.77)
N <- 6L
q <- floor(N / 2) + 1L
a_fail <- rep(0L, N - 2L)
a_pass_h <- c(rep(1L, q - 2L), rep(0L, N - 2L - (q - 2L)))
a_pass_o <- c(rep(1L, q - 1L), rep(0L, N - 2L - (q - 1L)))
pr05 <- payoff_R1("i", N, TRUE, a_fail, 1L, 0.3, 0.2, 0.05, beta, outside)
pr07_H <- payoff_R1("H", N, FALSE, a_fail, 1L, 0.3, 0.2, 0.05, beta, outside)
pr07_W <- payoff_R1("j", N, FALSE, a_fail, 1L, 0.3, 0.2, 0.05, beta, outside)
pr04 <- payoff_R1("i", N, TRUE, a_pass_h, 1L, 0.3, 0.2, 0.05, beta, outside)
pr06 <- payoff_R1("i", N, FALSE, a_pass_o, 1L, 0.3, 0.2, 0.05, beta, outside)
add_check(
  "beta_exactly_once_mixed_dates",
  abs(pr05 - beta * cA("i", 1L, a_fail)) < 1e-12 &&
    abs(pr07_W - beta * cO("j", a_fail)) < 1e-12 &&
    abs(pr04 - (1 - 0.3 - 0.2)) < 1e-12 &&
    abs(pr06 - (1 - 0.2)) < 1e-12,
  "PR05 and weak PR07 receive one beta; PR04 and PR06 remain current-date payoffs.",
  paste(pr05, pr07_W, pr04, pr06)
)
add_check(
  "immediate_H_optout_no_double_payment",
  abs(pr07_H - outside[[2L]]) < 1e-12 &&
    grepl("exactly once without beta", interface$transition_and_payoff_map[[4L]]$payoffs_R1, fixed = TRUE),
  "On PR07 H receives o_theta now, without beta and without a second C2 flow.",
  paste("computed H PR07", pr07_H)
)

# The same local strategy/payoff vector demonstrates the separation between
# ballot belief rho and true proposal distribution mu.
u_type <- c(0.16, 0.84)
rho_a <- 0.2
rho_b <- 0.8
mu_a <- 0.35
mu_b <- 0.65
weak_a <- (1 - rho_a) * u_type[[1L]] + rho_a * u_type[[2L]]
weak_b <- (1 - rho_b) * u_type[[1L]] + rho_b * u_type[[2L]]
prop_a <- (1 - mu_a) * u_type[[1L]] + mu_a * u_type[[2L]]
prop_same_after_rho_change <- (1 - mu_a) * u_type[[1L]] + mu_a * u_type[[2L]]
prop_b <- (1 - mu_b) * u_type[[1L]] + mu_b * u_type[[2L]]
add_check(
  "rho_separate_from_true_mu",
  abs(weak_a - weak_b) > 1e-8 &&
    abs(prop_a - prop_same_after_rho_change) < 1e-12 &&
    abs(prop_a - prop_b) > 1e-8,
  "Changing rho changes voter expectation; holding mu fixed leaves proposer integration unchanged; changing mu changes proposer integration.",
  paste(weak_a, weak_b, prop_a, prop_b)
)

# N=3 exact projection.  These functions evaluate strategies from primitive
# branches; the checker does not assume the candidate projection in order to
# validate a constructed assessment.
n3_bounds <- function(beta, o0, o1, mu) {
  b <- beta / 2
  A <- 1 - b
  C <- (1 - mu) * (1 - o0) + mu * b
  D <- 1 - o1
  c(b = b, A = A, C = C, D = D, L = max(C, D), U = max(A, C, D))
}

n3_rejection_probability <- function(y, o0, o1, rho) {
  (1 - rho) * as.numeric(y < o0 - 1e-12) +
    rho * as.numeric(y < o1 - 1e-12)
}

n3_weak_action_allowed <- function(beta, o0, o1, rho, y, x, weak_yes) {
  reject_prob <- n3_rejection_probability(y, o0, o1, rho)
  if (reject_prob <= 1e-12) return(TRUE)
  identical(isTRUE(weak_yes), x + 1e-12 >= beta / 2)
}

n3_proposer_payoff <- function(beta, o0, o1, mu, y, x, weak_yes) {
  b <- beta / 2
  type_payoff <- vapply(c(o0, o1), function(outside) {
    if (y + 1e-12 >= outside) return(1 - y - x)
    if (weak_yes) return(1 - x)
    b
  }, numeric(1L))
  (1 - mu) * type_payoff[[1L]] + mu * type_payoff[[2L]]
}

n3_H_payoff <- function(o0, o1, mu, y) {
  type_payoff <- c(if (y + 1e-12 >= o0) y else o0,
                   if (y + 1e-12 >= o1) y else o1)
  (1 - mu) * type_payoff[[1L]] + mu * type_payoff[[2L]]
}

n3_tiebreak_min <- function(beta, o0, o1, mu) {
  z <- n3_bounds(beta, o0, o1, mu)
  if (z[["D"]] > max(z[["A"]], z[["C"]]) + 1e-12) return(o1)
  (1 - mu) * o0 + mu * o1
}

n3_construct_value <- function(beta, o0, o1, mu, V) {
  z <- n3_bounds(beta, o0, o1, mu)
  if (o0 > 1e-12) {
    if (abs(V - z[["U"]]) > 1e-9) stop("o0>0 construction requires V=U")
    if (z[["A"]] >= z[["U"]] - 1e-12) {
      return(list(y = 0, x = z[["b"]], weak_yes = TRUE, signature = "A"))
    }
    if (z[["C"]] >= z[["U"]] - 1e-12) {
      return(list(y = o0, x = 0, weak_yes = FALSE, signature = "C"))
    }
    return(list(y = o1, x = 0, weak_yes = TRUE, signature = "D"))
  }
  if (V <= z[["A"]] + 1e-12) {
    return(list(y = 0, x = 1 - V, weak_yes = TRUE, signature = "separating_yes"))
  }
  if (V <= max(z[["A"]], z[["C"]]) + 1e-12) {
    if (mu >= 1 - 1e-12) stop("C>A construction cannot have mu=1")
    return(list(
      y = 0,
      x = (z[["C"]] - V) / (1 - mu),
      weak_yes = FALSE,
      signature = "separating_no"
    ))
  }
  list(y = o1, x = 0, weak_yes = TRUE, signature = "pooling_D")
}

# The proposal-contingent punishment map used in the constructive proof.
n3_offpath_action <- function(beta, o0, o1, y, x) {
  if (y < o0 - 1e-12) return(x + 1e-12 >= beta / 2)
  if (y < o1 - 1e-12) return(FALSE) # rho=0: weak action is a completion
  FALSE                              # pooling: weak action is a completion
}

# A random upper-bound check uses the actual on-support action condition.
set.seed(20260812)
n3_total <- 0L
n3_errors <- 0L
for (draw in seq_len(1000L)) {
  beta <- runif(1L, 0.01, 1)
  o0 <- runif(1L, 0, 0.85)
  o1 <- runif(1L, o0 + 1e-7, 1)
  mu <- runif(1L)
  y <- runif(1L, 0, o1)
  x <- runif(1L, 0, 1 - y)
  reject_prob <- n3_rejection_probability(y, o0, o1, mu)
  weak_yes <- if (reject_prob > 1e-12) x + 1e-12 >= beta / 2 else sample(c(FALSE, TRUE), 1L)
  G <- n3_proposer_payoff(beta, o0, o1, mu, y, x, weak_yes)
  z <- n3_bounds(beta, o0, o1, mu)
  n3_total <- n3_total + 1L
  n3_errors <- n3_errors + as.integer(G > z[["U"]] + 1e-10)
}
add_check(
  "N3_random_onpath_upper_bound",
  n3_errors == 0L,
  sprintf("Checked %d random feasible on-support proposals against U=max(A,C,D).", n3_total),
  sprintf("violations=%d", n3_errors)
)

# At least 48 primitive cells, with every endpoint and two interior values
# when the projection is nondegenerate.  Each row checks local rationality,
# feasibility, payoff, the tie-break, and a dense grid of distinct deviations
# under the stated proposal-contingent rho/completion map.
primitive_grid <- expand.grid(
  beta = c(0.2, 0.5, 1),
  o0 = c(0, 0.2),
  o1 = c(0.55, 0.9),
  mu = c(0, 0.25, 0.9, 1),
  KEEP.OUT.ATTRS = FALSE
)
n3_rows <- list()
n3_grid_errors <- 0L
for (g in seq_len(nrow(primitive_grid))) {
  pars <- primitive_grid[g, ]
  z <- n3_bounds(pars$beta, pars$o0, pars$o1, pars$mu)
  target_values <- if (pars$o0 > 0) {
    z[["U"]]
  } else {
    unique(c(z[["L"]], (2 * z[["L"]] + z[["U"]]) / 3,
             (z[["L"]] + 2 * z[["U"]]) / 3, z[["U"]]))
  }
  for (V in target_values) {
    con <- n3_construct_value(pars$beta, pars$o0, pars$o1, pars$mu, V)
    local_ok <- con$y >= -1e-12 && con$x >= -1e-12 &&
      con$y + con$x <= 1 + 1e-12 &&
      n3_weak_action_allowed(
        pars$beta, pars$o0, pars$o1, pars$mu,
        con$y, con$x, con$weak_yes
      )
    realized <- n3_proposer_payoff(
      pars$beta, pars$o0, pars$o1, pars$mu,
      con$y, con$x, con$weak_yes
    )
    Hbar <- n3_H_payoff(pars$o0, pars$o1, pars$mu, con$y)
    Hmin <- n3_tiebreak_min(pars$beta, pars$o0, pars$o1, pars$mu)

    max_grid_deviation <- -Inf
    for (y_dev in sort(unique(c(0, pars$o0, pars$o1, seq(0, pars$o1, length.out = 9))))) {
      x_points <- sort(unique(c(
        0, seq(0, 1 - y_dev, length.out = 9),
        if (pars$beta / 2 <= 1 - y_dev + 1e-12) pars$beta / 2 else numeric()
      )))
      for (x_dev in x_points) {
        if (abs(y_dev - con$y) < 1e-12 && abs(x_dev - con$x) < 1e-12) next
        action <- n3_offpath_action(pars$beta, pars$o0, pars$o1, y_dev, x_dev)
        max_grid_deviation <- max(
          max_grid_deviation,
          n3_proposer_payoff(
            pars$beta, pars$o0, pars$o1, pars$mu,
            y_dev, x_dev, action
          )
        )
      }
    }
    analytic_offpath_envelope <- if (pars$o0 > 0) z[["U"]] else z[["L"]]
    row_ok <- local_ok && abs(realized - V) < 1e-9 &&
      abs(Hbar - Hmin) < 1e-9 &&
      max_grid_deviation <= V + 1e-9 &&
      analytic_offpath_envelope <= V + 1e-9
    n3_grid_errors <- n3_grid_errors + as.integer(!row_ok)
    n3_rows[[length(n3_rows) + 1L]] <- data.frame(
      beta = pars$beta,
      o0 = pars$o0,
      o1 = pars$o1,
      mu = pars$mu,
      L = z[["L"]],
      U = z[["U"]],
      V = V,
      signature = con$signature,
      y = con$y,
      x = con$x,
      weak_yes = con$weak_yes,
      proposer_payoff = realized,
      H_payoff = Hbar,
      max_grid_deviation = max_grid_deviation,
      analytic_offpath_envelope = analytic_offpath_envelope,
      check = if (row_ok) "PASS" else "FAIL"
    )
  }
}
n3_projection_cases <- do.call(rbind, n3_rows)
add_check(
  "N3_exact_projection_grid_48plus",
  nrow(primitive_grid) >= 48L && n3_grid_errors == 0L &&
    all(n3_projection_cases$check == "PASS"),
  sprintf(
    "Validated singleton/interval necessity constructions on %d primitive cells and %d value rows.",
    nrow(primitive_grid), nrow(n3_projection_cases)
  ),
  sprintf("primitive cells=%d value rows=%d errors=%d",
          nrow(primitive_grid), nrow(n3_projection_cases), n3_grid_errors)
)

# Non-tautological counterexample and negative mutation: the assessment is
# evaluated from actions and deviation payoffs, then deliberately submitted to
# the rejected legacy predicate that forced V=U.
ce <- list(beta = 0.5, o0 = 0, o1 = 0.8, mu = 0.9)
ce_z <- do.call(n3_bounds, ce)
ce_con <- do.call(n3_construct_value, c(ce, list(V = ce_z[["L"]])))
ce_payoff <- do.call(
  n3_proposer_payoff,
  c(ce, list(y = ce_con$y, x = ce_con$x, weak_yes = ce_con$weak_yes))
)
ce_local <- n3_weak_action_allowed(
  ce$beta, ce$o0, ce$o1, ce$mu,
  ce_con$y, ce_con$x, ce_con$weak_yes
)
ce_deviation_envelope <- max(ce_z[["C"]], ce_z[["D"]])
ce_is_valid_assessment <- ce_local && abs(ce_payoff - 0.325) < 1e-12 &&
  ce_deviation_envelope <= ce_payoff + 1e-12
legacy_singleton_accepts <- abs(ce_payoff - ce_z[["U"]]) < 1e-12
add_check(
  "N3_counterexample_325_to_750",
  ce_is_valid_assessment && abs(ce_z[["L"]] - 0.325) < 1e-12 &&
    abs(ce_z[["U"]] - 0.75) < 1e-12,
  "Primitive branch evaluation validates beta=.5,o1=.8,mu=.9 projection [.325,.75].",
  paste("L", ce_z[["L"]], "U", ce_z[["U"]], "payoff", ce_payoff)
)
add_check(
  "negative_legacy_N3_singleton_mutation",
  ce_is_valid_assessment && !legacy_singleton_accepts,
  "The valid .325 assessment is rejected by the mutated legacy predicate V=max(A,C,D)=.75.",
  paste("valid", ce_is_valid_assessment, "legacy accepted", legacy_singleton_accepts)
)

# Endpoint and mixing signature check at the same counterexample.  Each pure
# support proposal is separately optimal and tie-minimal; mixing only averages
# double-tied support elements.
mix_no <- list(y = 0, x = 0, weak_yes = FALSE)
mix_yes <- list(y = 0, x = 0.675, weak_yes = TRUE)
mix_payoffs <- vapply(list(mix_no, mix_yes), function(s) {
  n3_proposer_payoff(ce$beta, ce$o0, ce$o1, ce$mu, s$y, s$x, s$weak_yes)
}, numeric(1L))
mix_H <- vapply(list(mix_no, mix_yes), function(s) {
  n3_H_payoff(ce$o0, ce$o1, ce$mu, s$y)
}, numeric(1L))
mix_actions_allowed <- vapply(list(mix_no, mix_yes), function(s) {
  n3_weak_action_allowed(
    ce$beta, ce$o0, ce$o1, ce$mu,
    s$y, s$x, s$weak_yes
  )
}, logical(1L))
lambda <- 0.37
add_check(
  "N3_tiebreak_endpoints_and_double_tie_mixing",
  all(mix_actions_allowed) && all(abs(mix_payoffs - 0.325) < 1e-12) &&
    all(abs(mix_H - 0.72) < 1e-12) &&
    abs(lambda * mix_payoffs[[1L]] + (1 - lambda) * mix_payoffs[[2L]] - 0.325) < 1e-12 &&
    abs(lambda * mix_H[[1L]] + (1 - lambda) * mix_H[[2L]] - 0.72) < 1e-12,
  "Two distinct lower-endpoint signatures tie in proposer and H payoffs; their mixture preserves both.",
  paste(mix_payoffs, mix_H)
)

# Value-one construction.  A unilateral weak no either leaves current passage
# secured or, only at N=4 after H no, toggles to a selected zero C2-M-WO.
value_one_errors <- 0L
value_one_cases <- 0L
for (N in 4:16) {
  n <- N - 2L
  q <- floor(N / 2) + 1L
  all_yes <- rep(1L, n)
  for (j in seq_len(n)) {
    dev <- all_yes
    dev[[j]] <- 0L
    h_yes_passes <- branch_id(N, TRUE, dev) == "PR04"
    h_no_branch <- branch_id(N, FALSE, dev)
    weak_difference_h_no <- if (h_no_branch == "PR06") 0 else 0 - 0.8 * 0
    value_one_errors <- value_one_errors + as.integer(!h_yes_passes || weak_difference_h_no < -1e-12)
    value_one_cases <- value_one_cases + 1L
  }
}
add_check(
  "N4plus_value_one_construction",
  value_one_errors == 0L,
  sprintf("Checked %d unilateral weak deviations in the value-one construction for N=4..16.", value_one_cases),
  sprintf("violations=%d", value_one_errors)
)

# [0,1] constructions in the two proved domains.
interval_errors <- 0L
interval_cases <- 0L
for (N in 6:12) {
  q <- floor(N / 2) + 1L
  n <- N - 2L
  for (V in seq(0, 1, by = 0.1)) {
    X <- 1 - V
    onpath_payoff <- 1 - X
    offpath <- rep(0L, n)
    one_dev <- offpath
    one_dev[[1L]] <- 1L
    all_failure <- branch_id(N, TRUE, offpath) == "PR05" &&
      branch_id(N, TRUE, one_dev) == "PR05" &&
      branch_id(N, FALSE, offpath) == "PR07" &&
      branch_id(N, FALSE, one_dev) == "PR07"
    interval_errors <- interval_errors + as.integer(
      abs(onpath_payoff - V) > 1e-12 || !all_failure
    )
    interval_cases <- interval_cases + 1L
  }
}
for (N in 4:5) {
  n <- N - 2L
  beta <- 0.8
  outside <- c(0.2, 0.7)
  offpath <- rep(0L, n)
  for (theta in 0:1) {
    delta_H <- beta * outside[[theta + 1L]] - outside[[theta + 1L]]
    interval_errors <- interval_errors + as.integer(delta_H >= 0)
    interval_cases <- interval_cases + 1L
  }
}
add_check(
  "proved_zero_to_one_subclasses",
  interval_errors == 0L,
  sprintf("Checked %d V/profile or H-strict-optout cases for N>=6 and N=4,5 with o0>0,beta<1.", interval_cases),
  sprintf("violations=%d", interval_errors)
)

# Frozen active-H pathology and the uniform-recognition identity lower bound.
pathology_ok <- grepl(
  "[D,1]", c2a$proposal_stage_characterization$N_3_to_5_o0_zero$proposer_payoff_projection,
  fixed = TRUE
) && identical(
  c2a$proposal_stage_characterization$N_3_to_5_o0_positive$proposer_payoff_projection,
  "{1}"
)
pathology_grid <- expand.grid(o1 = c(0.2, 0.7, 1), nu = c(0, 0.4, 1), m = c(3, 4))
pathology_grid$D <- pmax(1 - pathology_grid$o1, 1 - pathology_grid$nu)
pathology_grid$identity_lower_bound <- pathology_grid$D / pathology_grid$m
collapse_rows <- pathology_grid$D == 0
add_check(
  "o0_zero_active_H_pathology_literal",
  pathology_ok && all(pathology_grid$identity_lower_bound >= 0) &&
    all(collapse_rows == (pathology_grid$o1 == 1 & pathology_grid$nu == 1)) &&
    all(pathology_grid$D[pathology_grid$nu == 0] == 1),
  "Frozen small-N active-H C2 has [max(1-o1,1-nu),1], identity bound D/m, and collapse only at nu=1,o1=1.",
  "The frozen C2 pathology or its boundary arithmetic differs."
)

add_check(
  "H_relevance_separate_from_quota",
  identical(interface$fixed_proposal_fixed_point$H_relevance,
    "one: yes versus no changes at least opt-out status for every weak vector, independently of whether the weak quota is met") &&
    grepl("every `a`", paste(readLines(note_path, warn = FALSE), collapse = "\n"), fixed = TRUE),
  "H relevance is one for every weak vector and is not reduced to quota pivotality.",
  "H relevance statement is missing or altered."
)

add_check(
  "full_correspondence_not_scalar",
  grepl("no_scalarization", paste(readLines(interface_path, warn = FALSE), collapse = "\n"), fixed = TRUE) &&
    grepl("different admissible selections", interface$continuation_selection_maps$distinct_histories, fixed = TRUE) &&
    grepl("set-valued", interface$pre_recognition_interface$selection_status, fixed = TRUE),
  "Interface retains proposal-contingent completions, rho maps, histories, identities, and literal set-valued C2 selections.",
  "A scalarization or history compression may have entered the interface."
)

# Public measurability/type blindness is a restriction on the selection map:
# one public-history key carries both type coordinates.  It is not two hidden
# type-indexed choices that happen to have the same label.
public_selection_sentinel <- list(
  public_h2 = "h2=(h1,i,s,H=Y,a=00,failed)",
  selected_element = "C2-active-element-17",
  type_payoff = c(theta0 = 0.21, theta1 = 0.64)
)
add_check(
  "public_measurable_type_blind_kappa",
  length(public_selection_sentinel$selected_element) == 1L &&
    length(public_selection_sentinel$type_payoff) == 2L &&
    grepl("complete public h2", interface$continuation_selection_maps$public_measurability, fixed = TRUE) &&
    grepl("one selected C2 element governs both", interface$continuation_selection_maps$type_blind_selection, fixed = TRUE),
  "One public h2 selects one C2 element carrying both type coordinates; kappa_A/O cannot observe theta.",
  "Public-measurable, type-blind continuation-selection contract is missing."
)

# Proposal mixing is integrated before recognition, and recognition preserves
# every named player identity and both type coordinates.
sigma_by_i <- list(c(0.25, 0.75), c(0.6, 0.4))
# Matrices have rows (H,W1,W2) and columns (theta0,theta1), one matrix per
# proposal; the two lists correspond to recognized proposer identities i=1,2.
proposal_payoffs <- list(
  list(
    matrix(c(0.10, 0.30, 0.20, 0.60, 0.40, 0.25), nrow = 3L,
           dimnames = list(c("H", "W1", "W2"), c("theta0", "theta1"))),
    matrix(c(0.50, 0.10, 0.35, 0.80, 0.20, 0.45), nrow = 3L,
           dimnames = list(c("H", "W1", "W2"), c("theta0", "theta1")))
  ),
  list(
    matrix(c(0.20, 0.55, 0.15, 0.70, 0.25, 0.40), nrow = 3L,
           dimnames = list(c("H", "W1", "W2"), c("theta0", "theta1"))),
    matrix(c(0.45, 0.05, 0.50, 0.65, 0.35, 0.30), nrow = 3L,
           dimnames = list(c("H", "W1", "W2"), c("theta0", "theta1")))
  )
)
integrated_by_i <- lapply(seq_along(proposal_payoffs), function(i) {
  sigma_by_i[[i]][[1L]] * proposal_payoffs[[i]][[1L]] +
    sigma_by_i[[i]][[2L]] * proposal_payoffs[[i]][[2L]]
})
c1_type_identity <- (integrated_by_i[[1L]] + integrated_by_i[[2L]]) / 2
mu_export <- 0.37
c1_exante_identity <- (1 - mu_export) * c1_type_identity[, "theta0"] +
  mu_export * c1_type_identity[, "theta1"]
manual_W1 <- (1 - mu_export) * (
  (0.25 * proposal_payoffs[[1L]][[1L]]["W1", "theta0"] +
     0.75 * proposal_payoffs[[1L]][[2L]]["W1", "theta0"] +
     0.60 * proposal_payoffs[[2L]][[1L]]["W1", "theta0"] +
     0.40 * proposal_payoffs[[2L]][[2L]]["W1", "theta0"]) / 2
) + mu_export * (
  (0.25 * proposal_payoffs[[1L]][[1L]]["W1", "theta1"] +
     0.75 * proposal_payoffs[[1L]][[2L]]["W1", "theta1"] +
     0.60 * proposal_payoffs[[2L]][[1L]]["W1", "theta1"] +
     0.40 * proposal_payoffs[[2L]][[2L]]["W1", "theta1"]) / 2
)
add_check(
  "sigma_expectation_and_full_type_identity_C1_export",
  abs(c1_exante_identity[["W1"]] - manual_W1) < 1e-12 &&
    abs(c1_exante_identity[["W1"]] - c1_exante_identity[["W2"]]) > 1e-8 &&
    all(dim(c1_type_identity) == c(3L, 2L)) &&
    grepl("integral", interface$pre_recognition_interface$sigma_expectation, fixed = TRUE) &&
    grepl("every H or named weak identity", interface$pre_recognition_interface$type_by_identity_correspondence, fixed = TRUE) &&
    grepl("type-conditional", interface$pre_recognition_interface$outcome_distribution, fixed = TRUE),
  "sigma is integrated first; uniform recognition then exports every named identity, both types, ex-ante payoffs, and outcome distributions.",
  "The sigma expectation or full type-by-identity C1 export is incomplete."
)

utils::write.csv(cases, cases_path, row.names = FALSE, quote = TRUE, fileEncoding = "UTF-8")
utils::write.csv(n3_projection_cases, n3_cases_path, row.names = FALSE, quote = TRUE, fileEncoding = "UTF-8")
utils::write.csv(checks, out_path, row.names = FALSE, quote = TRUE, fileEncoding = "UTF-8")

failed <- checks$check_id[checks$status != "PASS"]
cat(sprintf("R1-majority checks: %d/%d PASS\n", sum(checks$status == "PASS"), nrow(checks)))
cat(sprintf("Interface sha256: %s\n", sha256_file(interface_path)))
cat(sprintf("Derivation note sha256: %s\n", sha256_file(note_path)))
cat(sprintf("Cases table: %s\n", cases_path))
cat(sprintf("N3 projection table: %s\n", n3_cases_path))
cat(sprintf("Checks table: %s\n", out_path))
if (length(failed)) stop("Failed checks: ", paste(failed, collapse = ", "))
