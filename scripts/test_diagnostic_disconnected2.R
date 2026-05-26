# Diagnostic: trace a specific disconnected E_U case
# From verify_R10 output: N=3, r=1.1, alpha=0.01, beta=0.7, c=0.3267

source("scripts/model_functions.R")

N <- 3; r <- 1.1; alpha <- 0.01; beta <- 0.7; c_val <- 0.3267

mus <- seq(0, 1, length.out = 10001)

# Compute V_W under unanimity to find E_U structure
vw_u <- sapply(mus, function(mu) if (mu == 0) 0 else VW_R1_unanimity(r, alpha, mu, N, beta))

# E_U structure
E_U <- vw_u >= c_val & mus > 0
rle_eu <- rle(E_U)
cat("=== E_U structure ===\n")
pos_in_mus <- 1
for (i in seq_along(rle_eu$lengths)) {
  start <- mus[pos_in_mus]
  end_pos <- pos_in_mus + rle_eu$lengths[i] - 1
  end <- mus[end_pos]
  if (rle_eu$values[i] && mus[pos_in_mus] > 0) {
    cat(sprintf("  E_U component: [%.6f, %.6f]\n", start, end))
  }
  pos_in_mus <- end_pos + 1
}
cat(sprintf("  Number of components: %d\n", sum(rle_eu$values)))

# Find screening boundary
mu_s_R2 <- alpha * (r - 1) / (r - alpha)
cat(sprintf("\nmu_s_R2 = %.6f\n", mu_s_R2))

# Detailed V_W around the gap
cat("\nV_W around the gap:\n")
gap_mus <- seq(0.0001, 0.02, by = 0.001)
for (mu in gap_mus) {
  vw <- VW_R1_unanimity(r, alpha, mu, N, beta)
  in_eu <- vw >= c_val
  cat(sprintf("  mu=%.4f: V_W=%.6f %s\n", mu, vw, ifelse(in_eu, "IN", "out")))
}

# Now the full analysis
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

cav_U <- concavify(mus, v_U)
cav_M <- concavify(mus, v_M)
delta <- cav_U - cav_M

# Key values
a <- min(mus[E_U])
sup_eu <- max(mus[E_U])
cat(sprintf("\na = inf(E_U) = %.6f\n", a))
cat(sprintf("sup(E_U) = %.6f\n", sup_eu))

# S_U
nonzero <- mus > 0 & v_U > 0
S_U <- max(v_U[nonzero] / mus[nonzero])
cat(sprintf("S_U = %.6f\n", S_U))

# Verify delta structure
pos <- delta > 1e-12 & mus > 0
if (sum(pos) > 0) {
  first_pos <- which(pos)[1]
  last_pos <- max(which(pos))
  sc <- all(pos[first_pos:last_pos])
  cat(sprintf("\nDelta > 0 from p=%.6f to p=%.6f\n", mus[mus > 0][first_pos], mus[mus > 0][last_pos]))
  cat(sprintf("Single-crossing: %s\n", sc))
  # Also check tail
  tail_check <- all(pos[first_pos:length(pos)])
  cat(sprintf("Tail check (all positive after first positive): %s\n", tail_check))
} else {
  cat("\nDelta never positive (trivial case)\n")
}

# Check cav_U in the gap region
if (sum(rle_eu$values) >= 2) {
  cat("\n=== Checking proof logic in gap region ===\n")
  # Find gap boundaries
  components <- list()
  pos_in_mus <- 1
  for (i in seq_along(rle_eu$lengths)) {
    end_pos <- pos_in_mus + rle_eu$lengths[i] - 1
    if (rle_eu$values[i] && mus[pos_in_mus] > 0) {
      components[[length(components) + 1]] <- c(mus[pos_in_mus], mus[end_pos])
    }
    pos_in_mus <- end_pos + 1
  }

  if (length(components) >= 2) {
    b <- components[[1]][2]  # right end of first component
    d <- components[[2]][1]  # left end of second component
    cat(sprintf("Gap: (%.6f, %.6f)\n", b, d))

    # Check u(b) > m(b) and u(d) > m(d)
    b_idx <- which.min(abs(mus - b))
    d_idx <- which.min(abs(mus - d))
    cat(sprintf("cav_U(b)=%.6f, cav_M(b)=%.6f, gap=%.6f\n",
                cav_U[b_idx], cav_M[b_idx], cav_U[b_idx] - cav_M[b_idx]))
    cat(sprintf("cav_U(d)=%.6f, cav_M(d)=%.6f, gap=%.6f\n",
                cav_U[d_idx], cav_M[d_idx], cav_U[d_idx] - cav_M[d_idx]))

    # Check delta inside gap
    in_gap <- mus > b & mus < d
    if (any(in_gap)) {
      delta_gap <- delta[in_gap]
      cat(sprintf("Delta in gap: min=%.8f max=%.8f all_positive=%s\n",
                  min(delta_gap), max(delta_gap), all(delta_gap > -1e-12)))
    }
  }
}
