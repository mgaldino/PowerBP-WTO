# Test: Can sup(E_U) < 1 happen?
# If V_W(1, U) < c but V_W(1, M) >= c, then 1 ∈ E_M but 1 ∉ E_U.
# The proposed proof assumes all gaps in E_U are interior (bounded by E_U points on both sides).
# This fails if the rightmost component of E_U doesn't reach 1.

source("scripts/model_functions.R")

alpha_star_fn <- function(N, beta) {
  q <- floor(N / 2) + 1
  beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
}

cat("=== Test: Can sup(E_U) < 1? ===\n\n")

# For each parameter combo, check if V_W(1, U) < V_W(1, M) and find c values where 1 ∉ E_U
Ns <- c(3, 5, 7, 10, 15, 20)
rs <- c(1.1, 1.2, 1.3, 1.5, 2, 3, 5)
betas <- c(0.7, 0.8, 0.9, 0.95, 0.99)

found <- 0
tested <- 0
cases <- data.frame()

for (N in Ns) {
  for (r in rs) {
    for (beta in betas) {
      a_star <- alpha_star_fn(N, beta)
      alphas <- seq(0.01, min(a_star * 0.99, 1/r - 0.01), length.out = 8)

      for (alpha in alphas) {
        tested <- tested + 1

        # V_W at mu = 1 under both rules
        vw_u_1 <- VW_R1_unanimity(r, alpha, 1, N, beta)
        vw_m_1 <- VW_R1_majority(r, alpha, 1, N, beta)

        # V_W at various mu under unanimity to find max
        mus <- seq(0.001, 0.999, by = 0.001)
        vw_u_all <- sapply(mus, function(mu) VW_R1_unanimity(r, alpha, mu, N, beta))
        max_vw_u <- max(vw_u_all)
        max_vw_u_mu <- mus[which.max(vw_u_all)]

        # Is max achieved away from mu=1?
        if (max_vw_u > vw_u_1 * 1.001) {
          # There exist c values where V_W(1,U) < c <= max V_W(U)
          # i.e., E_U doesn't include 1

          # Also check: for such c, is 1 in E_M?
          if (vw_m_1 > vw_u_1) {
            # Window: c in (V_W(1,U), min(max_vw_u, V_W(1,M)))
            c_lo <- vw_u_1
            c_hi <- min(max_vw_u, vw_m_1)

            if (c_hi > c_lo + 1e-6) {
              c_test <- (c_lo + c_hi) / 2

              # Verify: 1 not in E_U, 1 in E_M
              in_eu_1 <- vw_u_1 >= c_test
              in_em_1 <- vw_m_1 >= c_test

              if (!in_eu_1 && in_em_1) {
                found <- found + 1

                # Find sup E_U
                in_eu <- vw_u_all >= c_test
                if (any(in_eu)) {
                  sup_eu <- max(mus[in_eu])
                } else {
                  sup_eu <- NA
                }

                cases <- rbind(cases, data.frame(
                  N = N, r = r, alpha = round(alpha, 4), beta = beta,
                  VW_U_1 = round(vw_u_1, 5), VW_M_1 = round(vw_m_1, 5),
                  max_VW_U = round(max_vw_u, 5), max_mu = round(max_vw_u_mu, 3),
                  c = round(c_test, 5), sup_EU = round(sup_eu, 3),
                  gap = round(1 - sup_eu, 3)
                ))
              }
            }
          }
        }
      }
    }
  }
}

cat(sprintf("Tested: %d parameter combos\n", tested))
cat(sprintf("Cases where sup(E_U) < 1 is possible: %d\n\n", found))

if (found > 0) {
  cat("=== Cases where 1 ∈ E_M but 1 ∉ E_U ===\n")
  n_show <- min(30, nrow(cases))
  print(cases[seq_len(n_show), ], row.names = FALSE)

  cat(sprintf("\n=== Gap (1 - sup E_U) statistics ===\n"))
  cat(sprintf("  Min: %.4f\n", min(cases$gap, na.rm = TRUE)))
  cat(sprintf("  Median: %.4f\n", median(cases$gap, na.rm = TRUE)))
  cat(sprintf("  Max: %.4f\n", max(cases$gap, na.rm = TRUE)))

  # For these cases, check if single-crossing breaks
  cat("\n=== Single-crossing check for these edge cases ===\n")
  sc_fail <- 0
  for (i in seq_len(nrow(cases))) {
    row <- cases[i, ]
    grid <- seq(0, 1, length.out = 3000)
    v_U <- sapply(grid, function(mu) {
      if (mu == 0) return(0)
      vw <- VW_R1_unanimity(row$r, row$alpha, mu, row$N, row$beta)
      if (vw >= row$c) VH_R1_unanimity(row$r, row$alpha, mu, row$N, row$beta) else 0
    })
    v_M <- sapply(grid, function(mu) {
      if (mu == 0) return(0)
      vw <- VW_R1_majority(row$r, row$alpha, mu, row$N, row$beta)
      if (vw >= row$c) VH_R1_majority(row$r, row$alpha, mu, row$N, row$beta) else 0
    })
    cav_U <- concavify(grid, v_U)
    cav_M <- concavify(grid, v_M)
    delta <- cav_U - cav_M
    pos <- delta > 1e-12

    # Check upper interval property
    if (sum(pos) == 0) next
    first_pos <- which(pos)[1]
    is_upper <- all(pos[first_pos:length(pos)])

    if (!is_upper) {
      sc_fail <- sc_fail + 1
      # Find where it breaks
      last_pos <- max(which(pos))
      first_neg_after <- min(which(!pos & seq_along(pos) > first_pos), na.rm = TRUE)
      cat(sprintf("  VIOLATION: N=%d r=%.1f alpha=%.4f beta=%.2f c=%.5f\n",
                  row$N, row$r, row$alpha, row$beta, row$c))
      cat(sprintf("    Delta positive at p=%.4f, negative at p=%.4f, then positive at p=%.4f?\n",
                  grid[first_pos], grid[first_neg_after], grid[last_pos]))
      cat(sprintf("    Delta at p=1: %.6f\n", delta[length(delta)]))
    }
  }

  cat(sprintf("\nSingle-crossing violations in edge cases: %d / %d\n", sc_fail, nrow(cases)))
} else {
  cat("No edge cases found — sup(E_U) = 1 always holds in the tested range.\n")
}
