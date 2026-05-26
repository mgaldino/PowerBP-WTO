# Verify the "up to 35%" claim in the abstract
# and reconcile with Example 4 numbers (27% aggressive, 41% conservative)

source("scripts/model_functions.R")

# Parameters from Example 4
N <- 5; r <- 1.5; alpha <- 0.3; beta <- 0.9

# R2 screening cutoff (formula)
mu_s_R2 <- alpha * (r - 1) / (r - alpha)
cat("R2 screening cutoff mu_s_R2 =", mu_s_R2, "\n")

# Find R1 screening cutoff numerically (where F1_agg = F1_con)
find_R1_cutoff <- function(r, alpha, N, beta) {
  f <- function(mu) {
    x <- (N - 1) * alpha * r
    mu_s_R2 <- alpha * (r - 1) / (r - alpha)
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
  # Search in the region above mu_s_R2
  mus <- seq(mu_s_R2 + 1e-6, 0.99, by = 0.0001)
  vals <- sapply(mus, f)
  # Find sign change
  for (i in 1:(length(vals) - 1)) {
    if (vals[i] > 0 && vals[i + 1] <= 0) {
      return(uniroot(f, c(mus[i], mus[i + 1]))$root)
    }
  }
  # Also search below mu_s_R2
  mus2 <- seq(0.001, mu_s_R2, by = 0.0001)
  vals2 <- sapply(mus2, f)
  for (i in 1:(length(vals2) - 1)) {
    if (vals2[i] > 0 && vals2[i + 1] <= 0) {
      return(uniroot(f, c(mus2[i], mus2[i + 1]))$root)
    }
  }
  return(NA)
}

mu_s_R1 <- find_R1_cutoff(r, alpha, N, beta)
cat("R1 screening cutoff mu_s_R1 =", mu_s_R1, "\n\n")

# Evaluate just below and just above the R1 cutoff
eps <- 1e-4
mu_below <- mu_s_R1 - eps
mu_above <- mu_s_R1 + eps

VH_U_below <- VH_R1_unanimity(r, alpha, mu_below, N, beta)
VH_U_above <- VH_R1_unanimity(r, alpha, mu_above, N, beta)
VH_M_below <- VH_R1_majority(r, alpha, mu_below, N, beta)
VH_M_above <- VH_R1_majority(r, alpha, mu_above, N, beta)

cat("--- At mu just below R1 cutoff (aggressive branch) ---\n")
cat("VH unanimity =", round(VH_U_below, 3), "\n")
cat("VH majority  =", round(VH_M_below, 3), "\n")
cat("% advantage  =", round((VH_U_below / VH_M_below - 1) * 100, 1), "%\n\n")

cat("--- At mu just above R1 cutoff (conservative branch) ---\n")
cat("VH unanimity =", round(VH_U_above, 3), "\n")
cat("VH majority  =", round(VH_M_above, 3), "\n")
cat("% advantage  =", round((VH_U_above / VH_M_above - 1) * 100, 1), "%\n\n")

# Jump in VH_U at the cutoff
cat("--- Jump at R1 cutoff ---\n")
cat("VH_U below =", round(VH_U_below, 3), "\n")
cat("VH_U above =", round(VH_U_above, 3), "\n")
Ve_at_cutoff <- 1 + mu_s_R1 * (r - 1)
cat("Jump as % of Ve =", round((VH_U_above - VH_U_below) / Ve_at_cutoff * 100, 1), "%\n\n")

# Scan full range for maximum advantage
mus <- seq(0.001, 0.999, by = 0.001)
results <- data.frame(
  mu = mus,
  VH_U = sapply(mus, function(m) VH_R1_unanimity(r, alpha, m, N, beta)),
  VH_M = sapply(mus, function(m) VH_R1_majority(r, alpha, m, N, beta))
)
results$pct_advantage <- (results$VH_U / results$VH_M - 1) * 100

cat("--- Maximum % advantage across all mu ---\n")
idx <- which.max(results$pct_advantage)
cat("Max =", round(results$pct_advantage[idx], 1), "% at mu =", results$mu[idx], "\n\n")

# Show advantage at a few key beliefs
cat("--- Advantage at selected beliefs ---\n")
for (m in c(0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.50, 0.70, 0.90)) {
  vh_u <- VH_R1_unanimity(r, alpha, m, N, beta)
  vh_m <- VH_R1_majority(r, alpha, m, N, beta)
  cat(sprintf("mu=%.2f: VH_U=%.3f VH_M=%.3f adv=%.1f%%\n", m, vh_u, vh_m, (vh_u/vh_m - 1)*100))
}
