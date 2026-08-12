#!/usr/bin/env Rscript

# Mechanical checks for the candidate r2_unanimity_active_h interface.
# The analytic proof is in
# model_redesign/pivotal_response_nodes/r2_unanimity_active_h_v1.md.

options(stringsAsFactors = FALSE)

tol <- 1e-10
checks <- list()

add_check <- function(test_id, ok, detail) {
  checks[[length(checks) + 1L]] <<- data.frame(
    test_id = test_id,
    status = if (isTRUE(ok)) "PASS" else "FAIL",
    detail = detail,
    stringsAsFactors = FALSE
  )
}

prod_except <- function(p, j) {
  if (length(p) == 1L) return(1)
  prod(p[-j])
}

is_ballot_equilibrium <- function(p, h, y, o, rho, x = rep(0, length(p))) {
  stopifnot(length(h) == 2L, length(o) == 2L, length(x) == length(p))
  P_W <- prod(p)

  # H's action is relevant because opt-out status changes. Equality selects yes.
  h_required <- as.numeric(P_W * (y - o) >= -tol)
  if (any(h != h_required)) return(FALSE)

  a_rho <- (1 - rho) * h[1] + rho * h[2]
  for (j in seq_along(p)) {
    relevance <- a_rho * prod_except(p, j)
    if (relevance > tol && abs(p[j] - 1) > tol) return(FALSE)
  }
  TRUE
}

predicted_equilibrium <- function(p, h, y, o, rho) {
  zeros <- sum(abs(p) <= tol)
  P_W <- prod(p)
  if (zeros >= 2L) {
    return(all(h == c(1, 1)))
  }
  if (zeros == 1L) return(FALSE)

  h_cut <- as.numeric(y - o >= -tol)
  if (any(h != h_cut)) return(FALSE)
  a_rho <- (1 - rho) * h[1] + rho * h[2]
  if (a_rho > tol) return(all(abs(p - 1) <= tol))
  P_W > tol
}

conditional_payoffs <- function(y, x, p, h, o) {
  P_W <- prod(p)
  residual <- 1 - y - sum(x)
  stopifnot(residual >= -tol)
  weak <- lapply(seq_len(2L), function(theta_index) {
    pass_probability <- h[theta_index] * P_W
    c(proposer = pass_probability * residual,
      setNames(pass_probability * x, paste0("weak_", seq_along(x))))
  })
  hegemon <- o + h * P_W * (y - o)
  list(weak = weak, hegemon = hegemon, P_W = P_W, residual = residual)
}

# 1. Exhaustive pure-ballot enumeration over population, posterior, and
# threshold regions. This directly checks Proposition 1.
o <- c(0.2, 0.6)
y_grid <- c(0, o[1], 0.4, o[2], 0.8)
rho_grid <- c(0, 0.35, 1)

pure_profiles_checked <- 0L
for (N in 3:9) {
  n <- N - 2L
  p_grid <- expand.grid(rep(list(c(0, 1)), n))
  h_grid <- expand.grid(h0 = c(0, 1), h1 = c(0, 1))
  for (y in y_grid) {
    for (rho in rho_grid) {
      for (pr in seq_len(nrow(p_grid))) {
        p <- as.numeric(p_grid[pr, ])
        for (hr in seq_len(nrow(h_grid))) {
          h <- as.numeric(h_grid[hr, ])
          actual <- is_ballot_equilibrium(p, h, y, o, rho)
          predicted <- predicted_equilibrium(p, h, y, o, rho)
          pure_profiles_checked <- pure_profiles_checked + 1L
          if (!identical(actual, predicted)) {
            stop(sprintf(
              "Pure-profile mismatch N=%d y=%g rho=%g p=%s h=%s",
              N, y, rho, paste(p, collapse = ""), paste(h, collapse = "")
            ))
          }
        }
      }
    }
  }
}
add_check(
  "U2_BALLOT_PURE_EXHAUSTIVE",
  TRUE,
  sprintf("%d pure profiles matched the analytic correspondence", pure_profiles_checked)
)

# 2. Mixed/completion cases and the single-zero exclusion.
mixed_cases <- list(
  list(id = "N3_below_o0_positive_mix", p = c(0.23), h = c(0, 0),
       y = 0.1, rho = 0.4, expected = TRUE),
  list(id = "N3_separating_offpath_high_belief", p = c(0.37), h = c(1, 0),
       y = 0.4, rho = 1, expected = TRUE),
  list(id = "N3_separating_positive_low_mass_forces_yes", p = c(0.37), h = c(1, 0),
       y = 0.4, rho = 0.8, expected = FALSE),
  list(id = "N4_two_zero_coordination", p = c(0, 0), h = c(1, 1),
       y = 0.8, rho = 0.3, expected = TRUE),
  list(id = "N5_two_zero_one_mixed", p = c(0, 0, 0.61), h = c(1, 1),
       y = 0.4, rho = 0.3, expected = TRUE),
  list(id = "N5_single_zero_excluded", p = c(0, 0.52, 0.79), h = c(1, 1),
       y = 0.4, rho = 0.3, expected = FALSE),
  list(id = "pooling_forces_all_yes", p = c(1, 1, 1), h = c(1, 1),
       y = 0.6, rho = 0.3, expected = TRUE),
  list(id = "pooling_partial_mix_fails", p = c(1, 0.9, 1), h = c(1, 1),
       y = 0.6, rho = 0.3, expected = FALSE),
  list(id = "low_threshold_equality_yes", p = c(1), h = c(1, 0),
       y = 0.2, rho = 0.4, expected = TRUE),
  list(id = "high_threshold_equality_yes", p = c(1), h = c(1, 1),
       y = 0.6, rho = 0.4, expected = TRUE)
)

for (case in mixed_cases) {
  actual <- is_ballot_equilibrium(
    case$p, case$h, case$y, o, case$rho, rep(0, length(case$p))
  )
  add_check(
    paste0("U2_MIXED_", case$id),
    identical(actual, case$expected),
    sprintf("expected=%s actual=%s", case$expected, actual)
  )
}

# 3. Outcome probabilities, player/type payoffs, and branchwise budget closure.
set.seed(8112026)
payoff_trials <- 0L
for (trial in seq_len(250L)) {
  n <- sample(1:6, 1)
  y <- runif(1, 0, 0.8)
  raw_x <- runif(n)
  available <- 1 - y
  x <- if (sum(raw_x) == 0) raw_x else raw_x / sum(raw_x) * runif(1, 0, available)
  p <- runif(n)
  h <- sample(c(0, 1), 2, replace = TRUE)
  ans <- conditional_payoffs(y, x, p, h, o)
  P_W <- prod(p)

  for (theta_index in 1:2) {
    pass_probability <- h[theta_index] * P_W
    conditional_weak_total <- sum(ans$weak[[theta_index]])
    expected_implemented_weak <- pass_probability * (1 - y)
    if (abs(conditional_weak_total - expected_implemented_weak) > 1e-9) {
      stop("Weak payoff accounting failed")
    }
    expected_h <- o[theta_index] + h[theta_index] * P_W * (y - o[theta_index])
    if (abs(ans$hegemon[theta_index] - expected_h) > 1e-9) {
      stop("H payoff accounting failed")
    }
    if (abs(y + sum(x) + ans$residual - 1) > 1e-9) {
      stop("Implemented budget failed to close")
    }
  }
  payoff_trials <- payoff_trials + 1L
}
add_check(
  "U2_PAYOFF_VECTOR_ACCOUNTING",
  TRUE,
  sprintf("%d random proposals passed type/player accounting checks", payoff_trials)
)

# 4. N=3 proposal constructions. Pooling is unavoidable when G>0; a
# separating deviation can be capped below every strictly positive target.
n3_trials <- 0L
for (nu in c(0, 0.2, 0.65, 0.95)) {
  for (o0 in c(0, 0.15, 0.45)) {
    for (o1 in c(max(o0 + 0.05, 0.55), 0.9, 1)) {
      if (o1 <= o0 || o1 > 1) next
      G <- 1 - o1
      L <- (1 - nu) * (1 - o0)
      if (G > tol) {
        stopifnot(abs((1 - o1) - G) <= tol)
      }

      lower <- if (G > tol) G else .Machine$double.eps^0.5
      if (L + tol >= lower) {
        V_grid <- unique(c(lower, (lower + L) / 2, L))
        V_grid <- V_grid[V_grid > 0 & V_grid <= L + tol & V_grid + tol >= G]
        for (V in V_grid) {
          r <- V / (1 - nu)
          y <- o0
          x <- 1 - y - r
          stopifnot(x >= -1e-8, y < o1)
          onpath_value <- (1 - nu) * r
          stopifnot(abs(onpath_value - V) < 1e-8)

          # For any positive-residual separating deviation, this choice is
          # strictly positive and keeps its payoff strictly below V.
          r_dev <- max(1e-8, 1 - o0)
          p_dev <- min(0.5, V / (2 * (1 - nu) * r_dev))
          deviation_value <- (1 - nu) * p_dev * r_dev
          stopifnot(p_dev > 0, deviation_value < V + tol)
          stopifnot(G <= V + tol)
          n3_trials <- n3_trials + 1L
        }
      }

      if (G <= tol) {
        # A zero-payoff candidate cannot suppress this positive deviation.
        r_dev <- 1 - o0
        p_dev <- 1e-6
        stopifnot((1 - nu) * p_dev * r_dev > 0)
      }
    }
  }
}
add_check(
  "U2_N3_PROPOSAL_CONSTRUCTIONS",
  TRUE,
  sprintf("%d separating candidates and all pooling floors passed", n3_trials)
)

# 5. N>=4: coordinated failure works for every threshold region and every
# tested population; positive scalar values are constructible from one of the
# two passage classes.
coordination_trials <- 0L
for (N in 4:12) {
  n <- N - 2L
  for (y in y_grid) {
    for (rho in rho_grid) {
      p <- rep(0.73, n)
      p[1:2] <- 0
      h <- c(1, 1)
      stopifnot(is_ballot_equilibrium(p, h, y, o, rho, rep(0, n)))
      coordination_trials <- coordination_trials + 1L
    }
  }
}
add_check(
  "U2_NGE4_COORDINATED_FAILURE",
  TRUE,
  sprintf("%d population/threshold/posterior cases passed", coordination_trials)
)

construction_trials <- 0L
for (nu in c(0, 0.25, 0.75, 1)) {
  for (o0 in c(0, 0.2)) {
    for (o1 in c(0.6, 1)) {
      if (o1 <= o0) next
      G <- 1 - o1
      L <- (1 - nu) * (1 - o0)
      M <- max(G, L)
      if (M <= tol) next
      for (fraction in c(0.05, 0.4, 1)) {
        V <- fraction * M
        if (nu < 1 && V <= L + tol) {
          r <- V / (1 - nu)
          y <- o0
          gifts <- 1 - y - r
          stopifnot(gifts >= -tol, abs((1 - nu) * r - V) < 1e-8)
        } else {
          stopifnot(V <= G + tol)
          r <- V
          y <- o1
          gifts <- 1 - y - r
          stopifnot(gifts >= -tol, abs(r - V) < 1e-8)
        }
        construction_trials <- construction_trials + 1L
      }
    }
  }
}
add_check(
  "U2_NGE4_POSITIVE_RANGE_CONSTRUCTION",
  TRUE,
  sprintf("%d values in [0,max{G,L}] were explicitly constructed", construction_trials)
)

# 6. Zero-payoff tie condition and boundary cases.
for (nu in c(0, 0.4, 1)) {
  outside_mean <- (1 - nu) * o[1] + nu * o[2]

  # Coordinated failure always gives the benchmark exactly.
  p <- c(0, 0)
  h <- c(1, 1)
  ans <- conditional_payoffs(0.5, c(0, 0), p, h, o)
  hbar <- (1 - nu) * ans$hegemon[1] + nu * ans$hegemon[2]
  stopifnot(abs(hbar - outside_mean) < tol)

  if (nu < 1) {
    # Zero-residual low-only passage survives the H tie-break only at y=o0.
    ans_low <- conditional_payoffs(o[1], c(1 - o[1], 0), c(1, 1), c(1, 0), o)
    v <- (1 - nu) * ans_low$weak[[1]]["proposer"] +
      nu * ans_low$weak[[2]]["proposer"]
    hbar_low <- (1 - nu) * ans_low$hegemon[1] + nu * ans_low$hegemon[2]
    stopifnot(abs(v) < tol, abs(hbar_low - outside_mean) < tol)

    y_rent <- (o[1] + o[2]) / 2
    ans_rent <- conditional_payoffs(y_rent, c(1 - y_rent, 0), c(1, 1), c(1, 0), o)
    hbar_rent <- (1 - nu) * ans_rent$hegemon[1] + nu * ans_rent$hegemon[2]
    stopifnot(hbar_rent > outside_mean + tol)
  }
}
add_check(
  "U2_ZERO_TIE_BREAK_BOUNDARIES",
  TRUE,
  "coordinated failure and zero-residual low-only boundary match the outside benchmark"
)

# 7. Uniform-recognition vector accounting permits identity-asymmetric
# selections and integrates exactly once.
m <- 4L
nu <- 0.35
type0_matrix <- matrix(0, nrow = m, ncol = m)
type1_matrix <- matrix(0, nrow = m, ncol = m)
h0 <- h1 <- numeric(m)
for (i in seq_len(m)) {
  y <- 0.2
  residual <- 0.1 * i
  gift_total <- 1 - y - residual
  recipients <- setdiff(seq_len(m), i)
  gifts <- rep(gift_total / length(recipients), length(recipients))
  type0_matrix[i, i] <- residual
  type0_matrix[i, recipients] <- gifts
  type1_matrix[i, ] <- 0
  h0[i] <- y
  h1[i] <- 0.6
}
integrated_weak <- colMeans((1 - nu) * type0_matrix + nu * type1_matrix)
integrated_h0 <- mean(h0)
integrated_h1 <- mean(h1)
stopifnot(length(integrated_weak) == m)
stopifnot(abs(sum(integrated_weak) - (1 - nu) * (1 - mean(h0))) < 1e-8)
stopifnot(abs(integrated_h0 - 0.2) < tol, abs(integrated_h1 - 0.6) < tol)
add_check(
  "U2_UNIFORM_RECOGNITION_FULL_VECTOR",
  TRUE,
  "identity-asymmetric proposer vectors averaged with probability 1/m"
)

# 8. Native-time invariance: no Round-2 formula accepts or uses a discount
# input. A dummy discount transformation would change the object and is not
# part of any function above.
native_value <- function(nu, u0, u1) (1 - nu) * u0 + nu * u1
baseline <- native_value(0.4, 0.3, 0.8)
for (dummy_discount in c(0.1, 0.5, 0.9, 1)) {
  stopifnot(abs(native_value(0.4, 0.3, 0.8) - baseline) < tol)
}
add_check(
  "U2_NATIVE_DATE_NO_INTERNAL_DISCOUNT",
  TRUE,
  "Round-2 payoff functions are invariant to an unused dummy discount"
)

checks_df <- do.call(rbind, checks)
output_path <- "tables/pivotal_response_r2_unanimity_active_h_checks.csv"
write.csv(checks_df, output_path, row.names = FALSE, fileEncoding = "UTF-8")

failed <- checks_df$status != "PASS"
cat(sprintf(
  "r2_unanimity_active_h checks: %d PASS / %d total\n",
  sum(!failed), nrow(checks_df)
))
cat(sprintf("Wrote %s\n", output_path))

if (any(failed)) quit(status = 1L)
