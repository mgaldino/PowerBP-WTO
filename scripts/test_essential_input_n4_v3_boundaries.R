#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

assert_close <- function(actual, expected, message, tolerance = 1e-10) {
  assert_true(
    is.finite(actual) && is.finite(expected) && abs(actual - expected) <= tolerance,
    message
  )
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the boundary-test path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
source(file.path(repository_root, "scripts", "oracle_essential_input_n4_v3.R"))

candidate_path <- file.path(
  repository_root, "model_redesign", "essential_input_interfaces",
  "n4_r1_unanimity_candidate_v3.json"
)
assert_true(file.exists(candidate_path), "N4 v3 candidate is missing.")
candidate <- jsonlite::fromJSON(candidate_path, simplifyVector = FALSE)

quantities <- function(m, beta, o0, o1, nu) {
  p <- list(m = m, beta = beta, o0 = o0, o1 = o1, y_bar = max(o1, 0.9))
  d <- n4v3_derived_primitives(p)
  D <- (1 - nu) * d$A
  C <- if (nu <= d$nu_star) D else d$B
  Q_L <- 1 - d$ell - d$A
  Q_P <- 1 - d$h - d$A
  R_0 <- min(D, d$B)
  R_L_capacity <- (1 - nu) * Q_L
  R_L <- min(R_L_capacity, d$B)
  R_P <- max(0, Q_P)
  S_2 <- max(R_0, R_L, R_P)
  S_3 <- (1 - nu) * d$B
  P_cap <- 1 - d$h - (m - 1) * d$B
  list(
    m = m, beta = beta, o0 = o0, o1 = o1, nu = nu,
    nu_star = d$nu_star, ell = d$ell, h = d$h, A = d$A, B = d$B,
    D = D, C = C, Q_L = Q_L, Q_P = Q_P,
    R_0 = R_0, R_L_capacity = R_L_capacity, R_L = R_L, R_P = R_P,
    S_2 = S_2, S_3 = S_3, P_cap = P_cap
  )
}

component_attainment <- function(q, tolerance = 1e-10) {
  list(
    R_0 = TRUE,
    R_L = q$nu >= 1 - tolerance || q$R_L_capacity > q$B + tolerance,
    R_P = q$R_P <= tolerance
  )
}

H_tie_class <- function(q, tolerance = 1e-10) {
  if (abs(q$S_2 - q$R_0) <= tolerance &&
      abs(q$R_0 - q$D) <= tolerance && q$D < q$B - tolerance) {
    return("H_L")
  }
  attained <- component_attainment(q, tolerance)
  tied_attained <-
    (abs(q$S_2 - q$R_0) <= tolerance && attained$R_0) ||
    (abs(q$S_2 - q$R_L) <= tolerance && attained$R_L) ||
    (abs(q$S_2 - q$R_P) <= tolerance && attained$R_P)
  if (tied_attained) "h" else "infinity"
}

# Exhaustive deterministic grid over interiors, the N2 frontier, and prior
# endpoints. It checks identities analytically used by every candidate cell.
grid_rows <- list()
index <- 0L
for (m in 2:7) {
  for (beta in c(0.15, 0.5, 0.83, 0.97)) {
    for (o0 in c(0.03, 0.2, 0.55)) {
      for (o1 in c((o0 + 1) / 2, 0.98)) {
        if (!(o0 < o1 && o1 < 1)) next
        q0 <- quantities(m, beta, o0, o1, 0)
        priors <- unique(c(0, q0$nu_star / 2, q0$nu_star,
                           (1 + q0$nu_star) / 2, 1))
        for (nu in priors) {
          index <- index + 1L
          q <- quantities(m, beta, o0, o1, nu)
          grid_rows[[index]] <- q
          assert_true(q$B > 0 && q$B < q$A, "The strict weak-payoff ordering failed.")
          assert_true(q$ell > 0 && q$ell < q$h && q$h < 1,
                      "The strict H-continuation ordering failed.")
          assert_true(q$Q_L > 0, "Q_L must be strictly positive.")
          assert_close(q$P_cap - q$B, 1 - beta,
                       "The exact pooling-cap identity P-B=1-beta failed.")
          if (abs(nu - q$nu_star) <= 1e-10) {
            assert_close(q$D, q$B, "D=B failed at nu_star.")
            assert_close(q$C, q$B, "C=B failed at nu_star.")
          }
          if (nu <= q$nu_star + 1e-10) {
            assert_true(q$D >= q$B - 1e-10, "Low-region D must weakly exceed B.")
          } else {
            assert_true(q$D < q$B, "High-region D must be below B.")
          }
          if (m >= 3) {
            assert_true(q$S_3 < q$P_cap, "m>=3 security must lie below passage capacity.")
            assert_true(q$C > q$S_3, "m>=3 delay must strictly beat security.")
          } else {
            assert_true(q$S_2 < q$P_cap, "m=2 security supremum must lie below passage capacity.")
            delay_direct <- q$C >= q$S_2 - 1e-10
            delay_reduced <- if (nu <= q$nu_star + 1e-10) {
              q$D >= q$R_P - 1e-10
            } else {
              q$B >= q$R_P - 1e-10
            }
            assert_true(
              identical(delay_direct, delay_reduced),
              "The reduced m=2 delay predicate is not equivalent to C>=S_2."
            )
          }
        }
      }
    }
  }
}
assert_true(length(grid_rows) > 400L, "Boundary grid is unexpectedly small.")

# Every topology named in H_tie must occur on an admissible numerical fixture.
topology_seen <- c(H_L = FALSE, h = FALSE, infinity = FALSE)
delay_seen <- c(exists = FALSE, none = FALSE, equality = FALSE)
search_values <- seq(0.02, 0.98, length.out = 25)
for (beta in c(0.1, 0.25, 0.5, 0.75, 0.95)) {
  for (o0 in search_values[search_values < 0.75]) {
    for (o1 in search_values[search_values > o0 & search_values < 1]) {
      base <- quantities(2, beta, o0, o1, 0)
      for (nu in unique(c(0, base$nu_star / 2, base$nu_star,
                          (1 + base$nu_star) / 2, 0.99, 1))) {
        q <- quantities(2, beta, o0, o1, nu)
        topology_seen[[H_tie_class(q)]] <- TRUE
        gap <- q$C - q$S_2
        if (gap > 1e-8) delay_seen[["exists"]] <- TRUE
        if (gap < -1e-8) delay_seen[["none"]] <- TRUE
        if (abs(gap) <= 1e-8) delay_seen[["equality"]] <- TRUE
      }
    }
  }
}
assert_true(all(topology_seen), "The numerical boundary search missed an H_tie topology.")
assert_true(all(delay_seen), "The numerical boundary search missed a delay boundary status.")

# Structural guards must be present in the canonical interface rather than
# living only in prose or tests.
candidate_text <- paste(
  readLines(candidate_path, warn = FALSE, encoding = "UTF-8"),
  collapse = "\n"
)
required_guards <- c(
  "S_3(nu)=(1-nu)*B",
  "S_2(nu)=max{R_0(nu),R_L(nu),R_P}",
  "at equality or below only a supremum",
  "If r_i=S, require Y<=H_tie",
  "H_tie=+infinity",
  "exists iff C>=S_2; none iff C<S_2",
  "x>=B at nu=nu_star",
  "x_ik<=C, including equality",
  "at least two weak responders says no",
  "No payment restriction beyond proposal feasibility",
  "category_empty",
  "full Cartesian product",
  "failure\": \"0",
  "eliminate weakly dominated actions before sequential best response and T^Y"
)
for (guard in required_guards) {
  assert_true(
    grepl(guard, candidate_text, fixed = TRUE),
    paste0("Candidate is missing boundary guard: ", guard)
  )
}

cat("PASS: N4 v3 analytic boundaries, topology, and candidate guards\n")
