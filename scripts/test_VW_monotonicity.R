# Analytical check: Is V_W(1, U) always the max of V_W under unanimity?
# If so, then for any c < max V_W, we have 1 ∈ E_U.

source("scripts/model_functions.R")

alpha_star_fn <- function(N, beta) {
  q <- floor(N / 2) + 1
  beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
}

cat("=== Is V_W(1, U) = max V_W(mu, U)? ===\n\n")

# Dense parameter grid
Ns <- c(3, 5, 7, 10, 15, 20, 50, 100)
rs <- c(1.01, 1.05, 1.1, 1.2, 1.5, 2, 3, 5, 10)
betas <- c(0.5, 0.7, 0.8, 0.9, 0.95, 0.99, 0.999)

violations <- 0
tested <- 0
worst_ratio <- 1.0  # V_W(argmax)/V_W(1)

for (N in Ns) {
  for (r in rs) {
    for (beta in betas) {
      a_star <- alpha_star_fn(N, beta)
      if (a_star <= 0.01) next
      alphas <- seq(0.001, min(a_star * 0.99, 1/r - 0.001), length.out = 10)

      for (alpha in alphas) {
        tested <- tested + 1
        mus <- seq(0.001, 1, by = 0.001)
        vws <- sapply(mus, function(mu) VW_R1_unanimity(r, alpha, mu, N, beta))
        vw_1 <- vws[length(vws)]  # mu = 1.000
        max_vw <- max(vws)

        ratio <- max_vw / vw_1
        if (ratio > worst_ratio) {
          worst_ratio <- ratio
        }

        if (max_vw > vw_1 * 1.0001) {
          violations <- violations + 1
          argmax_mu <- mus[which.max(vws)]
          if (violations <= 5) {
            cat(sprintf("  VIOLATION: N=%d r=%.2f alpha=%.4f beta=%.3f | V_W(%.3f)=%.6f > V_W(1)=%.6f (ratio %.4f)\n",
                        N, r, alpha, beta, argmax_mu, max_vw, vw_1, max_vw/vw_1))
          }
        }
      }
    }
  }
}

cat(sprintf("\nTested: %d combos\n", tested))
cat(sprintf("Violations (max V_W not at mu=1): %d\n", violations))
cat(sprintf("Worst ratio max_V_W / V_W(1): %.6f\n", worst_ratio))

# Analytical value at mu=1
cat("\n=== Analytical check at mu=1 ===\n")
cat("V_W(1, U) = r(1-beta*alpha)/N (conservative regime)\n")
# Verify for a few cases
for (N in c(3, 5, 10)) {
  for (r in c(1.5, 3)) {
    beta <- 0.9
    alpha <- 0.1
    analytic <- r * (1 - beta * alpha) / N
    numeric <- VW_R1_unanimity(r, alpha, 1, N, beta)
    cat(sprintf("  N=%d r=%.1f: analytic=%.6f numeric=%.6f match=%s\n",
                N, r, analytic, numeric, abs(analytic - numeric) < 1e-10))
  }
}
