# Verify R10: single-crossing holds without Assumption 1
# Tests:
# 1. E_U ⊆ E_M in all cases
# 2. For disconnected E_U, {p : cav_v(p,U) > cav_v(p,M)} is upper interval
# 3. Gap of E_U is above τ(M)

source("scripts/model_functions.R")

alpha_star_fn <- function(N, beta) {
  q <- floor(N/2) + 1
  beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
}

VH_M_fn <- function(r, alpha, mu, N, beta) {
  VH_R1_majority(r, alpha, mu, N, beta)
}

# Find tau(M): entry threshold under majority
tau_M_fn <- function(r, alpha, N, beta, c_val) {
  q <- floor(N/2) + 1
  kappa_M <- (1 - alpha) * (N * (N - 1) + beta * (q - 1)) / (N^2 * (N - 1))
  tau <- max(0, (c_val / kappa_M - 1) / (r - 1))
  return(tau)
}

# Compute concavified payoffs and check single-crossing
check_single_crossing <- function(r, alpha, N, beta, c_val, grid_size = 2000) {
  mus <- seq(0, 1, length.out = grid_size + 1)

  # Compute value functions
  v_U <- sapply(mus, function(mu) {
    if (mu == 0) return(0)
    vw <- VW_R1_unanimity(r, alpha, mu, N, beta)
    if (vw >= c_val) VH_R1_unanimity(r, alpha, mu, N, beta) else 0
  })

  v_M <- sapply(mus, function(mu) {
    if (mu == 0) return(0)
    vw <- VW_R1_majority(r, alpha, mu, N, beta)
    if (vw >= c_val) VH_R1_majority(r, alpha, mu, N, beta) else 0
  })

  # Concavify
  cav_U <- concavify(mus, v_U)
  cav_M <- concavify(mus, v_M)

  # Difference
  delta <- cav_U - cav_M

  # Check E_U ⊆ E_M
  E_U <- v_U > 0
  E_M <- v_M > 0
  EU_subset_EM <- all(E_U <= E_M)  # If E_U[i] then E_M[i]

  # Check if E_U is connected
  if (sum(E_U) == 0) return(list(connected = TRUE, sc = TRUE, EU_subset = EU_subset_EM, type = "empty"))
  rle_EU <- rle(E_U)
  n_components <- sum(rle_EU$values)
  connected <- n_components <= 1

  # Check single-crossing: {p : delta(p) > 0} is upper interval
  pos <- delta > 1e-12
  if (sum(pos) == 0) {
    sc <- TRUE  # trivially upper interval (empty)
  } else if (all(pos[-1])) {
    sc <- TRUE  # all positive
  } else {
    # Check: once delta becomes positive, it stays positive
    first_pos <- which(pos)[1]
    sc <- all(pos[first_pos:length(pos)])
  }

  # Find inf(E_U)
  inf_EU <- mus[which(E_U)[1]]

  # Find tau(M)
  tau_M <- tau_M_fn(r, alpha, N, beta, c_val)

  # Check gaps are above tau(M)
  gaps_above_tau <- inf_EU >= tau_M

  return(list(
    connected = connected,
    n_components = n_components,
    sc = sc,
    EU_subset = EU_subset_EM,
    inf_EU = inf_EU,
    tau_M = tau_M,
    gaps_above_tau = gaps_above_tau
  ))
}

# Systematic scan — focus on cases where E_U is disconnected
cat("=== R10 Verification: Single-crossing without Assumption 1 ===\n\n")

Ns <- c(3, 5, 7, 10, 15, 20)
rs <- c(1.1, 1.2, 1.3, 1.5, 2, 3)
betas <- c(0.7, 0.8, 0.9, 0.95, 0.99)

total <- 0
disconnected <- 0
sc_violations <- 0
subset_violations <- 0
gap_violations <- 0

disc_cases <- data.frame()

for (N in Ns) {
  for (r in rs) {
    for (beta in betas) {
      a_star <- alpha_star_fn(N, beta)
      alphas <- seq(0.01, min(a_star * 0.99, 1/r - 0.01), length.out = 5)

      for (alpha in alphas) {
        # Find range of c
        mus_scan <- seq(0.001, 0.999, by = 0.005)
        VWs <- sapply(mus_scan, function(mu) VW_R1_unanimity(r, alpha, mu, N, beta))
        c_min <- min(VWs[VWs > 0], na.rm = TRUE)
        c_max <- max(VWs, na.rm = TRUE)
        if (c_max <= c_min) next

        cs <- seq(c_min + 0.001, c_max - 0.001, length.out = 8)

        for (c_val in cs) {
          total <- total + 1
          result <- check_single_crossing(r, alpha, N, beta, c_val)

          if (!result$EU_subset) subset_violations <- subset_violations + 1

          if (!result$connected) {
            disconnected <- disconnected + 1

            if (!result$sc) sc_violations <- sc_violations + 1
            if (!result$gaps_above_tau) gap_violations <- gap_violations + 1

            disc_cases <- rbind(disc_cases, data.frame(
              N = N, r = r, alpha = round(alpha, 4), beta = beta,
              c = round(c_val, 4), n_comp = result$n_components,
              inf_EU = round(result$inf_EU, 4),
              tau_M = round(result$tau_M, 4),
              SC = result$sc, EU_sub = result$EU_subset,
              gap_ok = result$gaps_above_tau
            ))
          }
        }
      }
    }
  }
}

cat(sprintf("Total tested: %d\n", total))
cat(sprintf("Disconnected E_U: %d (%.1f%%)\n", disconnected, 100 * disconnected / total))
cat(sprintf("E_U ⊆ E_M violations: %d\n", subset_violations))
cat(sprintf("Single-crossing violations: %d\n", sc_violations))
cat(sprintf("Gap below τ(M) violations: %d\n", gap_violations))

cat(sprintf("\n=== RESULT: %s ===\n",
            ifelse(sc_violations == 0 & subset_violations == 0,
                   "SINGLE-CROSSING HOLDS IN ALL CASES",
                   "VIOLATIONS FOUND")))

if (nrow(disc_cases) > 0) {
  cat(sprintf("\n=== %d disconnected cases ===\n", nrow(disc_cases)))
  cat("Sample:\n")
  n_show <- min(20, nrow(disc_cases))
  print(disc_cases[seq_len(n_show), ], row.names = FALSE)
}
