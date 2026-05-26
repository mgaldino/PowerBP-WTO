#!/usr/bin/env Rscript

# Numerical checks for the R1 unanimity characterization under pi_H = 0
# when weak proposers may make offers that are feasible only in the high state.

params <- list(
  N = 13,
  r = 1.5,
  alpha = 0.19,
  beta = 0.9
)

compute_unanimity_R1_C_B_R_piH0 <- function(N, r, alpha, beta,
                                             mu_grid = c(0, 0.07251908397,
                                                         0.37242424242,
                                                         0.7, 1),
                                             tol = 1e-10) {
  stopifnot(N >= 3, r > 1, alpha > 0, alpha < 1 / r,
            beta > 0, beta <= 1)

  m <- N - 1
  k <- m - 1
  Ve <- function(mu) 1 + mu * (r - 1)
  G_A2 <- function(mu) (1 - mu) * (1 - alpha)
  G_C2 <- function(mu) Ve(mu) - alpha * r
  g <- function(mu) pmax(G_A2(mu), G_C2(mu))
  W2 <- function(mu) g(mu) / m
  p2 <- alpha * (r - 1) / (r - alpha)

  h_C <- beta * alpha * r
  y_C <- function(mu) beta * W2(mu)
  C_cost_low <- function(mu) h_C + k * y_C(mu)
  C_feasible <- function(mu) C_cost_low(mu) <= 1 + tol
  C_prop <- function(mu) Ve(mu) - C_cost_low(mu)
  C_weak <- function(mu) (Ve(mu) - h_C) / m
  C_H <- function(mu) h_C + 0 * mu

  h_B <- beta * alpha * r
  low_continuation <- beta * (1 - alpha) / m
  y_B <- function(mu) {
    ifelse(mu <= tol, 0,
           beta * (g(mu) - (1 - mu) * (1 - alpha)) / (m * mu))
  }
  T_B_min <- function(mu) h_B + k * y_B(mu)
  B_exact_minimum <- function(mu) T_B_min(mu) > 1 + tol
  B_total <- function(mu) pmax(1, T_B_min(mu))
  B_feasible <- function(mu) T_B_min(mu) <= r + tol & r > 1
  B_prop <- function(mu) {
    ifelse(B_feasible(mu),
           mu * (r - B_total(mu)) + (1 - mu) * low_continuation,
           -Inf)
  }
  B_weak <- function(mu) {
    ((1 - mu) * beta * (1 - alpha) + mu * (r - h_B)) / m
  }
  B_H <- function(mu) beta * alpha * Ve(mu)

  R_prop <- function(mu) beta * W2(mu)
  R_weak <- function(mu) beta * g(mu) / m
  R_H <- function(mu) ifelse(mu < p2 - tol,
                             beta * alpha * Ve(mu),
                             beta * alpha * r)

  M_weak <- function(mu) Ve(mu) / m
  M_H <- function(mu) alpha * Ve(mu)

  choose_branch <- function(mu) {
    values <- c(
      C = if (C_feasible(mu)) C_prop(mu) else -Inf,
      B = B_prop(mu),
      R = R_prop(mu)
    )
    names(values)[which.max(values)]
  }

  branch <- function(mu) vapply(mu, choose_branch, character(1))

  U_weak <- function(mu) {
    b <- branch(mu)
    out <- numeric(length(mu))
    out[b == "C"] <- C_weak(mu[b == "C"])
    out[b == "B"] <- B_weak(mu[b == "B"])
    out[b == "R"] <- R_weak(mu[b == "R"])
    out
  }

  U_H <- function(mu) {
    b <- branch(mu)
    out <- numeric(length(mu))
    out[b == "C"] <- C_H(mu[b == "C"])
    out[b == "B"] <- B_H(mu[b == "B"])
    out[b == "R"] <- R_H(mu[b == "R"])
    out
  }

  grid <- seq(0, 1, length.out = 10001)
  feasible_grid <- C_feasible(grid)

  if (any(!B_feasible(grid))) {
    stop("High-state-only branch is not feasible for the calibration.")
  }

  if (any(C_prop(grid[feasible_grid]) + tol < B_prop(grid[feasible_grid]))) {
    stop("C should dominate B where C is feasible in the OPEC calibration.")
  }

  if (any(C_prop(grid[feasible_grid]) + tol < R_prop(grid[feasible_grid]))) {
    stop("C should dominate R where C is feasible in the OPEC calibration.")
  }

  if (any(B_prop(grid[!feasible_grid]) + tol < R_prop(grid[!feasible_grid]))) {
    stop("B should dominate R where C is infeasible in the OPEC calibration.")
  }

  branches <- branch(grid)
  if (any(branches[feasible_grid] != "C")) {
    stop("Branch should be C throughout the C-feasible region.")
  }

  if (any(branches[!feasible_grid] != "B")) {
    stop("Branch should be B throughout the C-infeasible region.")
  }

  if (any(!B_exact_minimum(grid[branches == "B"]))) {
    stop("B should be exact, not merely a supremum, where it is chosen.")
  }

  feasibility_boundary <- if (all(feasible_grid)) {
    1
  } else {
    stats::uniroot(function(mu) C_cost_low(mu) - 1,
                   c(p2, 1))$root
  }

  rent_boundary <- if (beta * r > 1) {
    (beta * r - 1) / (r - 1)
  } else {
    NA_real_
  }

  B_exact_boundary <- stats::uniroot(function(mu) T_B_min(mu) - 1,
                                     c(p2 + 1e-8, 1))$root

  c_region <- grid[branches == "C"]
  b_region <- grid[branches == "B"]
  gap_H <- U_H(grid) - M_H(grid)
  gap_weak <- M_weak(grid) - U_weak(grid)

  if (any(gap_weak < -tol)) {
    stop("Weak-state nesting gap should be nonnegative.")
  }

  if (any(gap_H[branches == "C"] <= tol)) {
    stop("H should strictly prefer unanimity on the C branch in OPEC.")
  }

  if (any(gap_H[branches == "B"] >= -tol)) {
    stop("H should strictly prefer majority on the B branch in OPEC.")
  }

  values <- data.frame(
    mu = mu_grid,
    branch = branch(mu_grid),
    V_e = Ve(mu_grid),
    C_feasible = C_feasible(mu_grid),
    C_prop = C_prop(mu_grid),
    B_prop = B_prop(mu_grid),
    R_prop = R_prop(mu_grid),
    U_weak = U_weak(mu_grid),
    M_weak = M_weak(mu_grid),
    weak_gap_M_minus_U = M_weak(mu_grid) - U_weak(mu_grid),
    U_H = U_H(mu_grid),
    M_H = M_H(mu_grid),
    H_gap_U_minus_M = U_H(mu_grid) - M_H(mu_grid)
  )

  list(
    N = N,
    m = m,
    k = k,
    r = r,
    alpha = alpha,
    beta = beta,
    p2 = p2,
    h_C = h_C,
    y_B_at_feasibility_boundary = y_B(feasibility_boundary),
    y_B_at_one = y_B(1),
    T_B_at_feasibility_boundary = T_B_min(feasibility_boundary),
    T_B_at_one = T_B_min(1),
    B_exact_boundary = B_exact_boundary,
    feasibility_boundary = feasibility_boundary,
    rent_boundary = rent_boundary,
    min_C_minus_B_on_C_region = min(C_prop(c_region) - B_prop(c_region)),
    min_C_minus_R_on_C_region = min(C_prop(c_region) - R_prop(c_region)),
    min_B_minus_R_on_B_region = min(B_prop(b_region) - R_prop(b_region)),
    min_weak_gap = min(gap_weak),
    max_H_gap_on_B = max(gap_H[branches == "B"]),
    min_H_gap_on_C = min(gap_H[branches == "C"]),
    values = values
  )
}

objects <- do.call(compute_unanimity_R1_C_B_R_piH0, params)

cat("Baseline unanimity R1 C-B-R check under pi_H = 0\n")
cat(sprintf("N=%d, m=%d, k=%d, r=%.6f, alpha=%.6f, beta=%.6f\n",
            objects$N, objects$m, objects$k,
            objects$r, objects$alpha, objects$beta))
cat(sprintf("p2=%.12f\n", objects$p2))
cat(sprintf("h_C=h_B=%.12f\n", objects$h_C))
cat(sprintf("B exact-minimum boundary=%.12f\n",
            objects$B_exact_boundary))
cat(sprintf("y_B at pooling boundary=%.12f\n",
            objects$y_B_at_feasibility_boundary))
cat(sprintf("y_B at mu=1=%.12f\n", objects$y_B_at_one))
cat(sprintf("T_B at pooling boundary=%.12f\n",
            objects$T_B_at_feasibility_boundary))
cat(sprintf("T_B at mu=1=%.12f\n", objects$T_B_at_one))
cat(sprintf("pooling feasibility boundary=%.12f\n",
            objects$feasibility_boundary))
cat(sprintf("old pooling rent boundary=%.12f\n",
            objects$rent_boundary))
cat(sprintf("min C-minus-B on C region=%.12f\n",
            objects$min_C_minus_B_on_C_region))
cat(sprintf("min C-minus-R on C region=%.12f\n",
            objects$min_C_minus_R_on_C_region))
cat(sprintf("min B-minus-R on B region=%.12f\n",
            objects$min_B_minus_R_on_B_region))
cat(sprintf("min weak nesting gap M-U=%.12f\n",
            objects$min_weak_gap))
cat(sprintf("min H gap U-M on C region=%.12f\n",
            objects$min_H_gap_on_C))
cat(sprintf("max H gap U-M on B region=%.12f\n\n",
            objects$max_H_gap_on_B))

print(objects$values, row.names = FALSE, digits = 12)

cat("\nAll baseline unanimity R1 C-B-R checks passed for the OPEC calibration.\n")
