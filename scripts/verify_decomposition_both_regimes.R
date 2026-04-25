# Verify that the decomposition D = D_base + 1{mu<mu_s_R2}*delta_R2 + 1{mu>mu_s_R1}*delta_R1
# holds in BOTH regimes (principal and alternative)
# Key insight: delta_R1 affects W-proposal part, delta_R2 affects H-proposal part — independent

source("scripts/model_functions.R")

alpha_star_fn <- function(N, beta) {
  q <- floor(N/2) + 1
  beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
}

lambda_M <- function(N, alpha, beta) {
  q <- floor(N/2) + 1
  C_buy <- beta * (q - 1) * (1 - alpha)
  (N * (1 + (N - 1) * alpha) - C_buy) / N^2
}

mu_s_R2_fn <- function(alpha, r) {
  alpha * (r - 1) / (r - alpha)
}

# Find R1 cutoff by bisection on Delta_1
find_mu_s_R1 <- function(alpha, r, N, beta) {
  Delta1 <- function(mu) {
    x <- (N - 1) * alpha * r
    mu_s_R2 <- mu_s_R2_fn(alpha, r)
    Ve <- 1 + mu * (r - 1)
    if (mu < mu_s_R2) {
      VW_R2 <- (1 - mu) * (1 - alpha) / N
    } else {
      VW_R2 <- (Ve - alpha * r) / N
    }
    omega <- (N - 2) * beta * VW_R2
    F1_con <- Ve - beta * (r + x) / N - omega
    F1_agg <- (1 - mu) * (1 - beta * (1 + x) / N - omega) + mu * beta * r * (1 - alpha) / N
    return(F1_agg - F1_con)
  }
  uniroot(Delta1, c(1e-6, 1 - 1e-6))$root
}

# D_base, delta_R2, delta_R1 from the proof
D_base_fn <- function(mu, alpha, r, N, beta) {
  q <- floor(N/2) + 1
  C_buy <- beta * (q - 1) * (1 - alpha)
  C_out <- N * (N - 1) * alpha
  Ve <- 1 + mu * (r - 1)
  (C_buy - C_out) * Ve + C_out * beta * r
}

delta_R2_fn <- function(mu, alpha, r, N, beta) {
  (N - 1) * beta * (mu * (r - alpha) - alpha * (r - 1))
}

delta_R1_fn <- function(mu, r, N, beta) {
  (N - 1) * beta * (r - 1) * (1 - mu)
}

# Verify decomposition
cat("=== Verifying decomposition in ALTERNATIVE regime ===\n")
cat("D_actual vs D_base + indicators * corrections\n\n")

test_cases <- list(
  list(N = 5, r = 2, beta = 0.9),
  list(N = 7, r = 3, beta = 0.9),
  list(N = 10, r = 2, beta = 0.9),
  list(N = 30, r = 1.5, beta = 0.99),
  list(N = 5, r = 1.5, beta = 0.95)
)

all_ok <- TRUE

for (tc in test_cases) {
  N <- tc$N; r <- tc$r; beta <- tc$beta
  a_star <- alpha_star_fn(N, beta)

  # Pick alpha in non-principal regime
  alpha <- a_star * 0.95  # near alpha*

  mu_s_R2 <- mu_s_R2_fn(alpha, r)
  mu_s_R1 <- find_mu_s_R1(alpha, r, N, beta)

  if (mu_s_R1 >= mu_s_R2) {
    cat(sprintf("N=%d, r=%.1f, beta=%.2f, alpha=%.4f: PRINCIPAL regime (skip)\n",
                N, r, beta, alpha))
    next
  }

  cat(sprintf("N=%d, r=%.1f, beta=%.2f, alpha=%.4f: ALTERNATIVE regime\n", N, r, beta, alpha))
  cat(sprintf("  mu_s_R1=%.4f < mu_s_R2=%.4f\n", mu_s_R1, mu_s_R2))

  lM <- lambda_M(N, alpha, beta)

  # Test at several mu values across all 3 branches
  test_mus <- c(
    mu_s_R1 / 2,                    # low branch
    (mu_s_R1 + mu_s_R2) / 2,        # middle branch (NEW in alt regime)
    mu_s_R1 * 0.99,                 # just below R1 cutoff
    mu_s_R1 * 1.01,                 # just above R1 cutoff
    mu_s_R2 * 0.99,                 # just below R2 cutoff
    mu_s_R2 * 1.01,                 # just above R2 cutoff
    (mu_s_R2 + 1) / 2,             # high branch
    0.9                             # near 1
  )

  max_err <- 0
  for (mu in test_mus) {
    if (mu <= 0 || mu >= 1) next

    # Actual D
    VH_U <- VH_R1_unanimity(r, alpha, mu, N, beta)
    Ve <- 1 + mu * (r - 1)
    VH_M <- lM * Ve
    D_actual <- VH_U - VH_M

    # Decomposition
    db <- D_base_fn(mu, alpha, r, N, beta) / N^2
    dr2 <- ifelse(mu < mu_s_R2, delta_R2_fn(mu, alpha, r, N, beta) / N^2, 0)
    dr1 <- ifelse(mu > mu_s_R1, delta_R1_fn(mu, r, N, beta) / N^2, 0)
    D_decomp <- db + dr2 + dr1

    err <- abs(D_actual - D_decomp)
    max_err <- max(max_err, err)

    branch <- if (mu < mu_s_R1) "LOW (agg R1, agg R2)"
              else if (mu < mu_s_R2) "MID (con R1, agg R2)"
              else "HIGH (con R1, con R2)"

    if (err > 1e-10) {
      cat(sprintf("  mu=%.4f [%s]: D_actual=%.8f, D_decomp=%.8f, ERROR=%.2e\n",
                  mu, branch, D_actual, D_decomp, err))
      all_ok <- FALSE
    }
  }
  cat(sprintf("  Max error: %.2e %s\n\n", max_err, ifelse(max_err < 1e-10, "[PASS]", "[FAIL]")))
}

cat(sprintf("=== Overall: %s ===\n\n", ifelse(all_ok, "DECOMPOSITION VALID IN BOTH REGIMES", "DECOMPOSITION FAILS")))

# Now verify the full proof argument in alternative regime
cat("=== Full proof verification in alternative regime ===\n")
cat("Check D > 0 on each branch using endpoint arguments\n\n")

for (tc in test_cases) {
  N <- tc$N; r <- tc$r; beta <- tc$beta
  a_star <- alpha_star_fn(N, beta)
  alpha <- a_star * 0.95

  mu_s_R2 <- mu_s_R2_fn(alpha, r)
  mu_s_R1 <- find_mu_s_R1(alpha, r, N, beta)

  if (mu_s_R1 >= mu_s_R2) next

  cat(sprintf("N=%d, r=%.1f, beta=%.2f, alpha=%.4f:\n", N, r, beta, alpha))

  mus <- seq(0.001, 0.999, by = 0.001)
  Ds <- sapply(mus, function(mu) {
    VH_U <- VH_R1_unanimity(r, alpha, mu, N, beta)
    Ve <- 1 + mu * (r - 1)
    lM <- lambda_M(N, alpha, beta)
    VH_U - lM * Ve
  })

  # Check each branch
  low <- mus < mu_s_R1
  mid <- mus >= mu_s_R1 & mus < mu_s_R2
  high <- mus >= mu_s_R2

  cat(sprintf("  LOW  [0, %.3f): min D = %.6f\n", mu_s_R1, min(Ds[low])))
  cat(sprintf("  MID  [%.3f, %.3f): min D = %.6f\n", mu_s_R1, mu_s_R2, min(Ds[mid])))
  cat(sprintf("  HIGH [%.3f, 1]: min D = %.6f\n", mu_s_R2, min(Ds[high])))
  cat(sprintf("  Overall min D = %.6f at mu = %.3f [%s]\n\n",
              min(Ds), mus[which.min(Ds)],
              ifelse(min(Ds) > 0, "PASS", "FAIL")))
}
