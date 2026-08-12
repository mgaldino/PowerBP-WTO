#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE)

root <- normalizePath(".", winslash = "/", mustWork = TRUE)
gate_path <- file.path(
  root,
  "model_redesign/pivotal_response_interfaces/gate0_bundle_v1.json"
)
interface_path <- file.path(
  root,
  "model_redesign/pivotal_response_interfaces/r2_majority_active_h_v1.json"
)
out_path <- file.path(
  root,
  "tables/pivotal_response_r2_majority_active_h_checks.csv"
)

expected_gate_hash <-
  "6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1"
tol <- 1e-10

checks <- list()
add_check <- function(id, status, detail) {
  checks[[length(checks) + 1L]] <<- data.frame(
    check_id = id,
    status = if (isTRUE(status)) "PASS" else "FAIL",
    detail = as.character(detail),
    stringsAsFactors = FALSE
  )
}

sha256 <- function(path) {
  ans <- system2("shasum", c("-a", "256", path), stdout = TRUE)
  strsplit(ans[[1L]], "[[:space:]]+")[[1L]][[1L]]
}

poisson_binomial <- function(prob) {
  ans <- 1
  if (length(prob) == 0L) return(ans)
  for (p in prob) {
    ans <- c(ans * (1 - p), 0) + c(0, ans * p)
  }
  ans
}

prob_equal <- function(prob, k) {
  if (k < 0L || k > length(prob)) return(0)
  poisson_binomial(prob)[[k + 1L]]
}

prob_at_least <- function(prob, k) {
  if (k <= 0L) return(1)
  if (k > length(prob)) return(0)
  sum(poisson_binomial(prob)[seq.int(k + 1L, length(prob) + 1L)])
}

expand_grid_prob <- function(levels, n) {
  if (n == 0L) return(matrix(numeric(), nrow = 1L, ncol = 0L))
  as.matrix(expand.grid(rep(list(levels), n), KEEP.OUT.ATTRS = FALSE))
}

ballot_objects <- function(prob, N, rho, y, o0, o1) {
  q <- floor(N / 2) + 1L
  A <- prob_at_least(prob, q - 2L)
  B <- prob_at_least(prob, q - 1L)
  h0 <- as.integer(A <= tol || y >= o0)
  h1 <- as.integer(A <= tol || y >= o1)
  t_rho <- (1 - rho) * h0 + rho * h1
  relevance <- vapply(seq_along(prob), function(j) {
    others <- prob[-j]
    t_rho * prob_equal(others, q - 3L) +
      (1 - t_rho) * prob_equal(others, q - 2L)
  }, numeric(1L))
  weak_ok <- all(prob >= 1 - tol | relevance <= tol)
  list(
    ok = weak_ok,
    A = A,
    B = B,
    h = c(h0, h1),
    t_rho = t_rho,
    relevance = relevance
  )
}

theorem_ballot <- function(prob, N, rho, y, o0, o1) {
  q <- floor(N / 2) + 1L
  obj <- ballot_objects(prob, N, rho, y, o0, o1)
  sure <- sum(prob >= 1 - tol)
  positive <- sum(prob > tol)
  if (obj$A <= tol) {
    return(q >= 4L && positive <= q - 4L)
  }
  if (abs(obj$t_rho - 1) <= tol) {
    return(sure >= q - 2L)
  }
  sure >= q - 1L
}

type_payoffs <- function(prob, N, y, X, x, o0, o1) {
  obj <- ballot_objects(prob, N, rho = 0.37, y, o0, o1)
  # H's actions depend on A and own type, not on the placeholder rho above.
  q <- floor(N / 2) + 1L
  A <- prob_at_least(prob, q - 2L)
  B <- prob_at_least(prob, q - 1L)
  h <- c(
    as.integer(A <= tol || y >= o0),
    as.integer(A <= tol || y >= o1)
  )
  outside <- c(o0, o1)
  residual <- 1 - y - X
  uH <- outside + h * A * (y - outside)
  ui <- h * A * residual + (1 - h) * B * (1 - X)
  uj <- lapply(seq_along(x), function(j) {
    (h * A + (1 - h) * B) * x[[j]]
  })
  list(A = A, B = B, h = h, uH = uH, ui = ui, uj = uj)
}

add_check(
  "dependency_gate0_hash",
  identical(sha256(gate_path), expected_gate_hash),
  paste0("gate0 sha256=", sha256(gate_path))
)
add_check(
  "interface_exists",
  file.exists(interface_path),
  basename(interface_path)
)

# Exhaust all pure ballot profiles through N=13 across all three H-acceptance
# regimes. The regimes can be induced by (rho,y), including rho=0 and rho=1.
pure_total <- 0L
pure_mismatch <- 0L
regimes <- list(
  list(rho = 0.4, y = 0.1, o0 = 0.2, o1 = 0.8), # t_rho=0
  list(rho = 0.37, y = 0.4, o0 = 0.2, o1 = 0.8), # t_rho=0.63
  list(rho = 0, y = 0.4, o0 = 0.2, o1 = 0.8),    # t_rho=1 separating
  list(rho = 1, y = 0.4, o0 = 0.2, o1 = 0.8),    # t_rho=0 separating
  list(rho = 0.6, y = 0.8, o0 = 0.2, o1 = 0.8)  # t_rho=1 pooling
)
for (N in 3:13) {
  profiles <- expand_grid_prob(c(0, 1), N - 2L)
  for (regime in regimes) {
    for (r in seq_len(nrow(profiles))) {
      p <- as.numeric(profiles[r, ])
      lhs <- ballot_objects(
        p, N, regime$rho, regime$y, regime$o0, regime$o1
      )$ok
      rhs <- theorem_ballot(
        p, N, regime$rho, regime$y, regime$o0, regime$o1
      )
      pure_total <- pure_total + 1L
      pure_mismatch <- pure_mismatch + as.integer(lhs != rhs)
    }
  }
}
add_check(
  "fixed_rho_pure_exhaustion_N3_N13",
  pure_mismatch == 0L,
  sprintf("profile-regimes=%d mismatches=%d", pure_total, pure_mismatch)
)

# Exhaust a mixed probability grid through N=7.
mixed_total <- 0L
mixed_mismatch <- 0L
for (N in 3:7) {
  profiles <- expand_grid_prob(c(0, 0.25, 0.5, 0.75, 1), N - 2L)
  for (regime in regimes) {
    for (r in seq_len(nrow(profiles))) {
      p <- as.numeric(profiles[r, ])
      lhs <- ballot_objects(
        p, N, regime$rho, regime$y, regime$o0, regime$o1
      )$ok
      rhs <- theorem_ballot(
        p, N, regime$rho, regime$y, regime$o0, regime$o1
      )
      mixed_total <- mixed_total + 1L
      mixed_mismatch <- mixed_mismatch + as.integer(lhs != rhs)
    }
  }
}
add_check(
  "fixed_rho_mixed_grid_N3_N7",
  mixed_mismatch == 0L,
  sprintf("profile-regimes=%d mismatches=%d", mixed_total, mixed_mismatch)
)

# Verify all four Gate 0 terminal branches by direct vote counting.
transition_total <- 0L
transition_errors <- 0L
for (N in 3:20) {
  q <- floor(N / 2) + 1L
  for (K in 0:(N - 2L)) {
    for (h_yes in c(FALSE, TRUE)) {
      derived <- if (h_yes && K >= q - 2L) {
        "PR11"
      } else if (h_yes) {
        "PR12"
      } else if (K >= q - 1L) {
        "PR13"
      } else {
        "PR14"
      }
      total_yes <- 1L + K + as.integer(h_yes)
      direct_pass <- total_yes >= q
      direct <- if (direct_pass && h_yes) {
        "PR11"
      } else if (!direct_pass && h_yes) {
        "PR12"
      } else if (direct_pass) {
        "PR13"
      } else {
        "PR14"
      }
      transition_total <- transition_total + 1L
      transition_errors <- transition_errors + as.integer(derived != direct)
    }
  }
}
add_check(
  "terminal_branch_enumeration",
  transition_errors == 0L,
  sprintf("profiles=%d mismatches=%d", transition_total, transition_errors)
)

# Independently enumerate best-response differences. Weak voters integrate H's
# strategies with rho; proposal payoffs below integrate type outcomes with nu.
set.seed(20260811)
br_total <- 0L
br_errors <- 0L
payoff_total <- 0L
payoff_errors <- 0L
for (draw in seq_len(400L)) {
  N <- sample(3:10, 1L)
  n <- N - 2L
  q <- floor(N / 2) + 1L
  p <- runif(n)
  rho <- runif(1L)
  nu <- runif(1L)
  o0 <- runif(1L, 0, 0.45)
  o1 <- runif(1L, o0 + 1e-4, 0.9)
  y <- runif(1L, 0, 1)
  X <- runif(1L, 0, 1 - y)
  raw_x <- runif(n)
  x <- if (sum(raw_x) == 0) raw_x else raw_x / sum(raw_x) * X

  A <- prob_at_least(p, q - 2L)
  B <- prob_at_least(p, q - 1L)
  h <- c(
    as.integer(A <= tol || y >= o0),
    as.integer(A <= tol || y >= o1)
  )
  t_rho <- (1 - rho) * h[[1L]] + rho * h[[2L]]
  dist_K <- poisson_binomial(p)

  for (theta in 0:1) {
    outside <- c(o0, o1)[[theta + 1L]]
    brute_H <- 0
    for (K in 0:n) {
      yes_pay <- if (K >= q - 2L) y else outside
      brute_H <- brute_H + dist_K[[K + 1L]] * (yes_pay - outside)
    }
    closed_H <- A * (y - outside)
    br_total <- br_total + 1L
    br_errors <- br_errors + as.integer(abs(brute_H - closed_H) > tol)
  }

  for (j in seq_len(n)) {
    others <- p[-j]
    dist_other <- poisson_binomial(others)
    brute_W <- 0
    for (theta in 0:1) {
      belief_prob <- c(1 - rho, rho)[[theta + 1L]]
      for (Kj in 0:length(others)) {
        no_pass <- 1L + Kj + h[[theta + 1L]] >= q
        yes_pass <- 2L + Kj + h[[theta + 1L]] >= q
        brute_W <- brute_W + belief_prob * dist_other[[Kj + 1L]] *
          x[[j]] * (as.integer(yes_pass) - as.integer(no_pass))
      }
    }
    closed_W <- x[[j]] * (
      t_rho * prob_equal(others, q - 3L) +
        (1 - t_rho) * prob_equal(others, q - 2L)
    )
    br_total <- br_total + 1L
    br_errors <- br_errors + as.integer(abs(brute_W - closed_W) > tol)
  }

  formula <- type_payoffs(p, N, y, X, x, o0, o1)
  for (theta in 0:1) {
    outside <- c(o0, o1)[[theta + 1L]]
    brute_H <- 0
    brute_i <- 0
    brute_j <- rep(0, n)
    for (K in 0:n) {
      pk <- dist_K[[K + 1L]]
      if (h[[theta + 1L]] == 1L && K >= q - 2L) {
        brute_H <- brute_H + pk * y
        brute_i <- brute_i + pk * (1 - y - X)
        brute_j <- brute_j + pk * x
      } else if (h[[theta + 1L]] == 0L && K >= q - 1L) {
        brute_H <- brute_H + pk * outside
        brute_i <- brute_i + pk * (1 - X)
        brute_j <- brute_j + pk * x
      } else {
        brute_H <- brute_H + pk * outside
      }
    }
    payoff_total <- payoff_total + 2L + n
    payoff_errors <- payoff_errors + as.integer(
      abs(brute_H - formula$uH[[theta + 1L]]) > tol
    ) + as.integer(
      abs(brute_i - formula$ui[[theta + 1L]]) > tol
    ) + sum(vapply(seq_len(n), function(j) {
      abs(brute_j[[j]] - formula$uj[[j]][[theta + 1L]]) > tol
    }, logical(1L)))
  }

  brute_true_nu <- (1 - nu) * formula$ui[[1L]] + nu * formula$ui[[2L]]
  t_nu <- (1 - nu) * h[[1L]] + nu * h[[2L]]
  closed_true_nu <- (t_nu * A) * (1 - y - X) +
    (1 - t_nu) * B * (1 - X)
  payoff_total <- payoff_total + 1L
  payoff_errors <- payoff_errors + as.integer(
    abs(brute_true_nu - closed_true_nu) > tol
  )
}
add_check(
  "rho_best_response_enumeration",
  br_errors == 0L,
  sprintf("comparisons=%d mismatches=%d", br_total, br_errors)
)
add_check(
  "true_nu_outcome_payoff_enumeration",
  payoff_errors == 0L,
  sprintf("comparisons=%d mismatches=%d", payoff_total, payoff_errors)
)

# Check F/S boundary implications, including B at t_rho=1 versus t_rho<1.
boundary_total <- 0L
boundary_errors <- 0L
for (N in 3:30) {
  q <- floor(N / 2) + 1L
  n <- N - 2L
  boundary_total <- boundary_total + 1L
  boundary_errors <- boundary_errors + as.integer((q >= 4L) != (N >= 6L))
  p_t1 <- c(rep(1, q - 2L), rep(0, n - (q - 2L)))
  obj_t1 <- ballot_objects(p_t1, N, rho = 0, y = 0.4, o0 = 0.2, o1 = 0.8)
  boundary_total <- boundary_total + 2L
  boundary_errors <- boundary_errors + as.integer(!obj_t1$ok) +
    as.integer(abs(obj_t1$B) > tol)
  p_tlt1 <- c(rep(1, q - 1L), rep(0, n - (q - 1L)))
  obj_tlt1 <- ballot_objects(
    p_tlt1, N, rho = 0.4, y = 0.4, o0 = 0.2, o1 = 0.8
  )
  boundary_total <- boundary_total + 2L
  boundary_errors <- boundary_errors + as.integer(!obj_tlt1$ok) +
    as.integer(abs(obj_tlt1$B - 1) > tol)
}
add_check(
  "F_S_population_and_B_boundaries",
  boundary_errors == 0L,
  sprintf("comparisons=%d mismatches=%d", boundary_total, boundary_errors)
)

# The repaired counterexample: voters use rho=0, but the deviation payoff is
# integrated with true nu. The same proposal on path at nu>0 forces B=1.
split_total <- 0L
split_errors <- 0L
for (N in 3:12) {
  q <- floor(N / 2) + 1L
  n <- N - 2L
  p_off <- c(rep(1, q - 2L), rep(0, n - (q - 2L)))
  off <- ballot_objects(p_off, N, rho = 0, y = 0, o0 = 0, o1 = 0.8)
  for (nu in c(0, 0.2, 0.7, 1)) {
    payoff_off <- (1 - nu) + nu * off$B
    split_total <- split_total + 4L
    split_errors <- split_errors + as.integer(!off$ok) +
      as.integer(abs(off$A - 1) > tol) +
      as.integer(abs(off$B) > tol) +
      as.integer(abs(payoff_off - (1 - nu)) > tol)
    p_on <- c(rep(1, q - 1L), rep(0, n - (q - 1L)))
    on <- ballot_objects(p_on, N, rho = nu, y = 0, o0 = 0, o1 = 0.8)
    if (nu > 0) {
      split_total <- split_total + 2L
      split_errors <- split_errors + as.integer(!on$ok) +
        as.integer(abs(on$B - 1) > tol)
    }
  }
}
add_check(
  "rho_nu_separation_and_B0_punishment",
  split_errors == 0L,
  sprintf("comparisons=%d mismatches=%d", split_total, split_errors)
)

# For N<=5 and o0>0, y=0,X=0 forces value one under every ballot belief.
positive_o0_total <- 0L
positive_o0_errors <- 0L
for (N in 3:5) {
  profiles <- expand_grid_prob(c(0, 1), N - 2L)
  for (rho in c(0, 0.4, 1)) {
    for (r in seq_len(nrow(profiles))) {
      p <- as.numeric(profiles[r, ])
      obj <- ballot_objects(p, N, rho, y = 0, o0 = 0.2, o1 = 0.8)
      if (obj$ok) {
        positive_o0_total <- positive_o0_total + 1L
        positive_o0_errors <- positive_o0_errors +
          as.integer(abs(obj$B - 1) > tol)
      }
    }
  }
}
add_check(
  "N3_N5_o0_positive_forced_value_one",
  positive_o0_errors == 0L,
  sprintf("equilibrium profiles=%d mismatches=%d", positive_o0_total,
          positive_o0_errors)
)

# For N<=5 and o0=0, verify the sharp lower bound D and construction [D,1].
interval_total <- 0L
interval_errors <- 0L
for (N in 3:5) {
  q <- floor(N / 2) + 1L
  n <- N - 2L
  p_off <- c(rep(1, q - 2L), rep(0, n - (q - 2L)))
  for (nu in c(0, 0.2, 0.6, 1)) {
    for (o1 in c(0.3, 0.8, 1)) {
      G <- 1 - o1
      L <- 1 - nu
      D <- max(G, L)
      off <- ballot_objects(p_off, N, rho = 0, y = 0, o0 = 0, o1 = o1)
      zero_deviation <- (1 - nu) + nu * off$B
      interval_total <- interval_total + 3L
      interval_errors <- interval_errors + as.integer(abs(zero_deviation - L) > tol) +
        as.integer(G > D + tol) + as.integer(L > D + tol)
      for (V in unique(c(D, (D + 1) / 2, 1))) {
        X <- 1 - V
        p_on <- rep(1, n)
        on <- ballot_objects(p_on, N, rho = nu, y = 0, o0 = 0, o1 = o1)
        h <- on$h
        t_nu <- (1 - nu) * h[[1L]] + nu * h[[2L]]
        actual <- (t_nu + (1 - t_nu) * on$B) * (1 - X)
        interval_total <- interval_total + 3L
        interval_errors <- interval_errors + as.integer(!on$ok) +
          as.integer(abs(actual - V) > tol) +
          as.integer(X < -tol || X > 1 + tol)
      }
    }
  }
}
add_check(
  "N3_N5_o0_zero_sharp_interval",
  interval_errors == 0L,
  sprintf("comparisons=%d mismatches=%d", interval_total, interval_errors)
)

# For N>=6, all-no weak behavior supplies F at every proposal and y=0
# constructs every positive proposer value in [0,1].
largeN_total <- 0L
largeN_errors <- 0L
for (N in 6:20) {
  n <- N - 2L
  for (rho in c(0, 0.5, 1)) {
    failure <- ballot_objects(rep(0, n), N, rho, y = 0.4, o0 = 0.2, o1 = 0.8)
    largeN_total <- largeN_total + 2L
    largeN_errors <- largeN_errors + as.integer(!failure$ok) +
      as.integer(abs(failure$A) > tol)
  }
  for (o0 in c(0, 0.2)) {
    for (nu in c(0, 0.4, 1)) {
      for (V in seq(0.05, 1, by = 0.05)) {
        X <- 1 - V
        passage <- ballot_objects(rep(1, n), N, nu, y = 0, o0 = o0, o1 = 0.8)
        h <- passage$h
        t_nu <- (1 - nu) * h[[1L]] + nu * h[[2L]]
        actual <- (t_nu + (1 - t_nu) * passage$B) * (1 - X)
        largeN_total <- largeN_total + 2L
        largeN_errors <- largeN_errors + as.integer(!passage$ok) +
          as.integer(abs(actual - V) > tol)
      }
    }
  }
}
add_check(
  "N_ge_6_failure_and_interval_constructions",
  largeN_errors == 0L,
  sprintf("comparisons=%d mismatches=%d", largeN_total, largeN_errors)
)

# Check the value-zero S characterization on a boundary grid.
zero_total <- 0L
zero_errors <- 0L
for (nu in c(0, 0.25, 1)) {
  for (o0 in c(0, 0.2)) {
    for (o1 in c(0.6, 0.9)) {
      for (y in unique(c(0, o0, o1, seq(0, 1, by = 0.1)))) {
        if (y > 1) next
        h <- c(as.integer(y >= o0), as.integer(y >= o1))
        t_nu <- (1 - nu) * h[[1L]] + nu * h[[2L]]
        X <- 1 - t_nu * y
        feasible <- X >= -tol && X <= 1 - y + tol
        h_gap <- (1 - nu) * h[[1L]] * (y - o0) +
          nu * h[[2L]] * (y - o1)
        lhs <- feasible && abs(h_gap) <= tol
        support_equal <-
          (nu == 1 || (h[[1L]] == 0L || abs(y - o0) <= tol)) &&
          (nu == 0 || (h[[2L]] == 0L || abs(y - o1) <= tol))
        rhs <- (abs(y) <= tol && abs(X - 1) <= tol) ||
          (y > tol && abs(t_nu - 1) <= tol &&
             abs(X - (1 - y)) <= tol && support_equal)
        zero_total <- zero_total + 1L
        zero_errors <- zero_errors + as.integer(lhs != rhs)
      }
    }
  }
}
add_check(
  "zero_value_S_tie_characterization",
  zero_errors == 0L,
  sprintf("grid cases=%d mismatches=%d", zero_total, zero_errors)
)

# Static contract checks for the repaired interface.
interface_text <- paste(readLines(interface_path, warn = FALSE), collapse = "\n")
add_check(
  "explicit_rho_nu_layers",
  grepl('"on_support_proposal": "rho(s)=nu', interface_text, fixed = TRUE) &&
    grepl('"deviation_distribution": "the proposer evaluates every proposal deviation under the true preproposal distribution nu',
          interface_text, fixed = TRUE),
  "interface distinguishes ballot belief rho from true deviation distribution nu"
)
add_check(
  "native_R2_discount_zero",
  grepl('"discount_application_count": 0', interface_text, fixed = TRUE),
  "interface declares zero discount applications in native Round-2 units"
)
add_check(
  "candidate_rereview_status",
  grepl('"status": "candidate_pending_independent_review"',
        interface_text, fixed = TRUE) &&
    grepl('"independent_review": "pending rereview of repaired candidate"',
          interface_text, fixed = TRUE),
  "repaired interface remains pending independent rereview"
)
add_check(
  "full_identity_type_terminal_coordinates",
  grepl('"weak_coordinate_by_identity_and_type"', interface_text, fixed = TRUE) &&
    grepl('"H_coordinate_by_type"', interface_text, fixed = TRUE) &&
    grepl('"terminal_signature_coordinate"', interface_text, fixed = TRUE),
  "pre-recognition interface retains identity, type, and terminal coordinates"
)

check_df <- do.call(rbind, checks)
write.csv(check_df, out_path, row.names = FALSE, fileEncoding = "UTF-8")

failed <- check_df$check_id[check_df$status != "PASS"]
cat(sprintf(
  "r2_majority_active_h repaired verification: %d/%d checks PASS\n",
  sum(check_df$status == "PASS"), nrow(check_df)
))
cat(sprintf("Wrote %s\n", out_path))
if (length(failed) > 0L) {
  stop(sprintf("Failed checks: %s", paste(failed, collapse = ", ")))
}
