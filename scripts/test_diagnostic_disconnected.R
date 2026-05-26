# Diagnostic: trace through a disconnected E_U case
# Verify each step of the proposed proof

source("scripts/model_functions.R")

# Disconnected case from the scan: N=3, r=1.1, alpha=0.01, beta=0.7
N <- 3; r <- 1.1; alpha <- 0.01; beta <- 0.7

# Find c that creates disconnected E_U
mus <- seq(0, 1, length.out = 5001)
vw_u <- sapply(mus, function(mu) if (mu == 0) 0 else VW_R1_unanimity(r, alpha, mu, N, beta))
vw_m <- sapply(mus, function(mu) if (mu == 0) 0 else VW_R1_majority(r, alpha, mu, N, beta))

# Find the jump in V_W
mu_s_R2 <- alpha * (r - 1) / (r - alpha)
cat(sprintf("mu_s_R2 = %.6f\n", mu_s_R2))

# VW has a downward jump near the R1 screening boundary
# Find it
diffs <- diff(vw_u)
jump_idx <- which(abs(diffs) == max(abs(diffs)))
cat(sprintf("Biggest jump in V_W at mu = %.4f, size = %.6f\n", mus[jump_idx], diffs[jump_idx]))

# Choose c in the gap region
vw_at_jump <- vw_u[jump_idx]
vw_after_jump <- vw_u[jump_idx + 1]
c_val <- (vw_at_jump + vw_after_jump) / 2
cat(sprintf("Chosen c = %.6f (between %.6f and %.6f)\n", c_val, vw_after_jump, vw_at_jump))

# Compute E_U, E_M
E_U <- vw_u >= c_val & mus > 0
E_M <- vw_m >= c_val & mus > 0

cat(sprintf("\nE_U components: %d\n", sum(rle(E_U)$values)))
cat(sprintf("E_M is interval: %s\n", sum(rle(E_M)$values) <= 1))

# inf E_U and tau(M)
a <- min(mus[E_U])
if (any(E_M)) tau_M <- min(mus[E_M]) else tau_M <- 1
cat(sprintf("a = inf(E_U) = %.4f\n", a))
cat(sprintf("tau(M) = %.4f\n", tau_M))
cat(sprintf("a >= tau(M): %s\n", a >= tau_M - 1e-10))

# sup E_U
sup_eu <- max(mus[E_U])
cat(sprintf("sup(E_U) = %.4f (should be 1.0)\n", sup_eu))

# Compute v(mu, U) and v(mu, M)
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
delta <- cav_U - cav_M

# Check S_U
S_U <- max(v_U[mus > 0] / mus[mus > 0])
S_U_argmax <- mus[mus > 0][which.max(v_U[mus > 0] / mus[mus > 0])]
cat(sprintf("\nS_U = %.6f (achieved at mu = %.4f)\n", S_U, S_U_argmax))

# Check S_M
if (tau_M > 0) {
  tau_M_idx <- which.min(abs(mus - tau_M))
  S_M <- v_M[tau_M_idx] / mus[tau_M_idx]
  cat(sprintf("S_M = %.6f (at tau_M = %.4f)\n", S_M, tau_M))
  cat(sprintf("S_U > S_M: %s\n", S_U > S_M))
} else {
  cat("tau(M) = 0, no S_M\n")
}

# Check Initial Ray: cav_U = S_U * p for p < a
ray_match <- all(abs(cav_U[mus < a & mus > 0] - S_U * mus[mus < a & mus > 0]) < 1e-8)
cat(sprintf("\nInitial Ray holds (cav_U = S_U*p for p < a): %s\n", ray_match))

# Check m(p)/p weakly decreasing
mp_over_p <- cav_M[mus > 0] / mus[mus > 0]
is_weakly_dec <- all(diff(mp_over_p) <= 1e-10)
cat(sprintf("m(p)/p weakly decreasing: %s\n", is_weakly_dec))

# Check conditional dominance at E_U points
vh_U_eu <- sapply(mus[E_U], function(mu) VH_R1_unanimity(r, alpha, mu, N, beta))
vh_M_eu <- sapply(mus[E_U], function(mu) VH_R1_majority(r, alpha, mu, N, beta))
cond_dom <- all(vh_U_eu > vh_M_eu)
cat(sprintf("Conditional dominance at all E_U points: %s\n", cond_dom))

# Check Part 1: delta > 0 for p >= a
part1 <- all(delta[mus >= a] > -1e-12)
cat(sprintf("\nPart 1 (delta > 0 for p >= a): %s\n", part1))
if (!part1) {
  violators <- mus[mus >= a & delta < -1e-12]
  cat(sprintf("  Violations at: %s\n", paste(round(violators[1:min(5,length(violators))], 4), collapse=", ")))
}

# Check Part 2: {p < a : delta > 0} is upper interval
below_a <- mus > 0 & mus < a
pos_below <- delta[below_a] > 1e-12
if (any(pos_below)) {
  first_pos <- which(pos_below)[1]
  part2 <- all(pos_below[first_pos:length(pos_below)])
} else {
  part2 <- TRUE  # empty set is upper interval
}
cat(sprintf("Part 2 ({p < a : delta > 0} is upper interval): %s\n", part2))

# Single-crossing check
pos <- delta[mus > 0] > 1e-12
if (sum(pos) == 0) {
  sc <- TRUE
} else {
  first_pos_idx <- which(pos)[1]
  sc <- all(pos[first_pos_idx:length(pos)])
}
cat(sprintf("\nSingle-crossing holds: %s\n", sc))

# Find the crossing point p*
if (any(pos) && !all(pos)) {
  # Last negative before first positive
  neg_before <- max(which(!pos & seq_along(pos) < first_pos_idx))
  p_star <- mus[mus > 0][neg_before]
  cat(sprintf("Crossing point p* ≈ %.4f\n", p_star))
}

# Summary of gap structure
cat("\n=== E_U gap structure ===\n")
rle_eu <- rle(E_U)
pos_in_mus <- 1
for (i in seq_along(rle_eu$lengths)) {
  start <- mus[pos_in_mus]
  end <- mus[pos_in_mus + rle_eu$lengths[i] - 1]
  if (rle_eu$values[i]) {
    cat(sprintf("  Component: [%.4f, %.4f]\n", start, end))
  } else if (start > 0) {
    cat(sprintf("  Gap: (%.4f, %.4f)\n", start, end))
  }
  pos_in_mus <- pos_in_mus + rle_eu$lengths[i]
}
