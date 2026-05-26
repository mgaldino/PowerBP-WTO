#!/usr/bin/env Rscript

# Verifies Round-2 unanimity values under the pi_H = 0 weak-state agenda.

params <- list(
  N = 13,
  r = 1.5,
  alpha = 0.19
)

compute_unanimity_R2_piH0 <- function(N, r, alpha,
                                      mu_grid = c(0, 0.07251908397, 0.5, 1)) {
  stopifnot(N >= 3, r > 1, alpha >= 0, alpha < 1 / r)

  m <- N - 1
  Ve <- function(mu) 1 + mu * (r - 1)
  G_A <- function(mu) (1 - mu) * (1 - alpha)
  G_C <- function(mu) Ve(mu) - alpha * r
  p2 <- alpha * (r - 1) / (r - alpha)

  W2 <- function(mu) pmax(G_A(mu), G_C(mu)) / m
  branch <- function(mu) {
    out <- ifelse(G_A(mu) > G_C(mu), "A", "C")
    out[abs(G_A(mu) - G_C(mu)) < sqrt(.Machine$double.eps)] <- "tie"
    out
  }

  values <- data.frame(
    mu = mu_grid,
    V_e = Ve(mu_grid),
    G_A = G_A(mu_grid),
    G_C = G_C(mu_grid),
    branch = branch(mu_grid),
    W2_unanimity = W2(mu_grid),
    H_low_A = alpha,
    H_low_C = alpha * r,
    H_high = alpha * r
  )

  list(
    N = N,
    m = m,
    r = r,
    alpha = alpha,
    p2 = p2,
    aggressive_feasible = alpha <= 1,
    conservative_feasible = alpha * r <= 1,
    values = values
  )
}

objects <- do.call(compute_unanimity_R2_piH0, params)

cat("Baseline unanimity R2 check under pi_H = 0\n")
cat(sprintf("N=%d, m=%d, r=%.6f, alpha=%.6f\n",
            objects$N, objects$m, objects$r, objects$alpha))
cat(sprintf("p2=%.12f\n", objects$p2))
cat(sprintf("aggressive feasible = %s\n", objects$aggressive_feasible))
cat(sprintf("conservative feasible = %s\n\n", objects$conservative_feasible))

print(objects$values, row.names = FALSE, digits = 12)

if (!objects$aggressive_feasible || !objects$conservative_feasible) {
  stop("At least one terminal unanimity offer is infeasible.")
}

if (abs(objects$values$G_A[2] - objects$values$G_C[2]) > 1e-8) {
  stop("The reported p2 does not equalize aggressive and conservative payoffs.")
}

cat("\nAll baseline unanimity R2 checks passed.\n")
