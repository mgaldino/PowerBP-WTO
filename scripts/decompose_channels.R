# Quantitative decomposition of BP gain into entry and screening channels
# For the paper "Informational Power and Institutional Design"
#
# The total advantage of unanimity over majority in concavified net gains is:
#   Total(p) = cav v(p, U) - cav v(p, M)
#
# We decompose this into:
#   Entry channel:     cav v_flat(p, U) - cav v(p, M)
#   Screening channel: cav v(p, U) - cav v_flat(p, U)
#
# where v_flat(mu, U) is the counterfactual net-gain function under unanimity
# with the screening jump removed (affine on the entry set, connecting
# (tau(U), 0) to (1, v(1, U))).
#
# Two parameterizations:
#   Scenario A (c=0.10): Figure 2 params, screening jump inside E_U
#   Scenario B (c=0.14): Example 2 params, screening jump below E_U

source("scripts/model_functions.R")

# =====================================================================
# Decomposition function (reusable for different parameterizations)
# =====================================================================
decompose_channels <- function(N, r, alpha, beta, c_val, label = "") {

  mus <- seq(0.001, 0.999, by = 0.001)
  n_grid <- length(mus)

  # --- Compute v(mu, U) and v(mu, M) ---
  v_U <- sapply(mus, function(m) {
    vw <- VW_R1_unanimity(r, alpha, m, N, beta)
    Ve <- 1 + m * (r - 1)
    if (vw >= c_val) VH_R1_unanimity(r, alpha, m, N, beta) - alpha * Ve else 0
  })

  v_M <- sapply(mus, function(m) {
    vw <- VW_R1_majority(r, alpha, m, N, beta)
    Ve <- 1 + m * (r - 1)
    if (vw >= c_val) VH_R1_majority(r, alpha, m, N, beta) - alpha * Ve else 0
  })

  # --- Entry thresholds ---
  entry_U_idx <- which(v_U > 0)
  entry_M_idx <- which(v_M > 0)
  tau_U <- if (length(entry_U_idx) > 0) mus[min(entry_U_idx)] else NA
  tau_M <- if (length(entry_M_idx) > 0) mus[min(entry_M_idx)] else NA

  # --- v_flat(mu, U): affine on E_U, connecting (tau(U),0) to (1, v(1,U)) ---
  v_at_1_U <- v_U[n_grid]

  v_flat_U <- sapply(mus, function(m) {
    if (is.na(tau_U) || m < tau_U) {
      0
    } else {
      (m - tau_U) / (1 - tau_U) * v_at_1_U
    }
  })

  # --- Concavify ---
  cav_U    <- concavify(mus, v_U)
  cav_M    <- concavify(mus, v_M)
  cav_flat <- concavify(mus, v_flat_U)

  # --- Screening cutoff ---
  mu_s_R2 <- alpha * (r - 1) / (r - alpha)
  phi_val <- (r * N - beta * (N - 1 + r)) / (beta * (r - 1))
  disc <- phi_val^2 - 4 * (N - 2)
  mu_s_R1 <- if (disc > 0) (phi_val - sqrt(disc)) / (2 * (N - 2)) else NA

  # --- Print header ---
  cat(sprintf("\n========================================================\n"))
  cat(sprintf("Scenario %s: N=%d, r=%.1f, alpha=%.1f, beta=%.1f, c=%.2f\n",
              label, N, r, alpha, beta, c_val))
  cat(sprintf("========================================================\n"))
  cat(sprintf("tau(U) = %.4f, tau(M) = %.4f\n", tau_U, tau_M))
  cat(sprintf("mu_s^R1 = %.4f, mu_s^R2 = %.4f\n", mu_s_R1, mu_s_R2))
  cat(sprintf("v(1, U) = %.6f, v(1, M) = %.6f\n", v_at_1_U, v_M[n_grid]))

  # Jump magnitude (if jump is in entry set)
  if (!is.na(mu_s_R1)) {
    idx_below <- which.min(abs(mus - (mu_s_R1 - 0.002)))
    idx_above <- which.min(abs(mus - (mu_s_R1 + 0.002)))
    cat(sprintf("v(mu_s-eps, U) = %.6f, v(mu_s+eps, U) = %.6f, jump = %.6f\n",
                v_U[idx_below], v_U[idx_above], v_U[idx_above] - v_U[idx_below]))
  }

  # --- Decomposition table ---
  priors <- c(0.05, 0.10, 0.15, 0.20, 0.30, 0.40, 0.50, 0.70)

  cat(sprintf("\n%-8s  %-10s  %-10s  %-10s  %-10s  %-8s  %-8s\n",
              "Prior", "cav_U", "cav_flat", "cav_M", "Total", "Entry%", "Screen%"))
  cat(paste(rep("-", 78), collapse = ""), "\n")

  for (p in priors) {
    idx <- which.min(abs(mus - p))
    cu <- cav_U[idx]
    cf <- cav_flat[idx]
    cm <- cav_M[idx]

    total     <- cu - cm
    entry_ch  <- cf - cm
    screen_ch <- cu - cf

    if (abs(total) > 1e-10) {
      entry_pct  <- entry_ch / total * 100
      screen_pct <- screen_ch / total * 100
    } else {
      entry_pct  <- NA
      screen_pct <- NA
    }

    cat(sprintf("p=%.2f    %.6f    %.6f    %.6f    %+.6f   %6.1f%%   %6.1f%%\n",
                p, cu, cf, cm, total, entry_pct, screen_pct))
  }

  # --- Verification ---
  cat("\n--- Verification (entry + screening = total) ---\n")
  all_pass <- TRUE
  for (p in priors) {
    idx <- which.min(abs(mus - p))
    cu <- cav_U[idx]; cf <- cav_flat[idx]; cm <- cav_M[idx]
    total <- cu - cm; sum_ch <- (cf - cm) + (cu - cf)
    err <- abs(sum_ch - total)
    pass <- err < 1e-12
    if (!pass) all_pass <- FALSE
    cat(sprintf("  p=%.2f: error=%.2e %s\n", p, err, ifelse(pass, "PASS", "FAIL")))
  }
  cat(sprintf("Overall: %s\n", ifelse(all_pass, "ALL PASS", "SOME FAILED")))

  # Return for plotting
  invisible(list(mus = mus, v_U = v_U, v_M = v_M, v_flat_U = v_flat_U,
                 cav_U = cav_U, cav_M = cav_M, cav_flat = cav_flat,
                 tau_U = tau_U, tau_M = tau_M, mu_s_R1 = mu_s_R1))
}

# =====================================================================
# Run both scenarios
# =====================================================================

# Scenario A: c=0.10 (Figure 2 parameterization — jump inside E_U)
res_A <- decompose_channels(N = 5, r = 1.5, alpha = 0.3, beta = 0.9,
                            c_val = 0.10, label = "A (c=0.10)")

# Scenario B: c=0.14 (Example 2 parameterization — jump below E_U)
res_B <- decompose_channels(N = 5, r = 1.5, alpha = 0.3, beta = 0.9,
                            c_val = 0.14, label = "B (c=0.14)")

# =====================================================================
# Plot: Scenario A (where both channels are visible)
# =====================================================================
pdf("figures/decomposition_channels.pdf", width = 9, height = 5)
par(mar = c(4.5, 4.5, 2, 1))

with(res_A, {
  plot(mus, cav_U, type = "l", col = "blue", lwd = 2.5,
       xlab = expression(paste("Prior ", italic(p))),
       ylab = "Concavified net gain",
       ylim = range(c(cav_U, cav_M, cav_flat)),
       las = 1, main = "")

  lines(mus, cav_M, col = "red", lwd = 2.5)
  lines(mus, cav_flat, col = "blue", lwd = 2, lty = 2)

  # Shade screening channel (between cav_U and cav_flat)
  polygon(c(mus, rev(mus)),
          c(pmax(cav_U, cav_flat), rev(cav_flat)),
          col = adjustcolor("blue", alpha.f = 0.15), border = NA)

  # Shade entry channel (between cav_flat and cav_M)
  polygon(c(mus, rev(mus)),
          c(pmax(cav_flat, cav_M), rev(cav_M)),
          col = adjustcolor("orange", alpha.f = 0.15), border = NA)

  # Mark screening cutoff
  if (!is.na(mu_s_R1)) {
    abline(v = mu_s_R1, col = "gray50", lty = 3)
    text(mu_s_R1 + 0.03, max(cav_U) * 0.85,
         expression(mu[s]^{R1}), col = "gray40", cex = 0.9)
  }

  legend("topleft",
         c(expression(cav ~ v(p, U)),
           expression(cav ~ v[flat](p, U)),
           expression(cav ~ v(p, M)),
           "Screening channel",
           "Entry channel"),
         col = c("blue", "blue", "red",
                 adjustcolor("blue", alpha.f = 0.3),
                 adjustcolor("orange", alpha.f = 0.3)),
         lwd = c(2.5, 2, 2.5, 8, 8),
         lty = c(1, 2, 1, 1, 1),
         cex = 0.85, bg = "white")
})

dev.off()
cat("\nFigure saved to figures/decomposition_channels.pdf\n")

# =====================================================================
# Summary for paper text
# =====================================================================
cat("\n\n=== SUMMARY FOR PAPER TEXT (Scenario A, c=0.10) ===\n")
with(res_A, {
  for (p in c(0.10, 0.20, 0.30, 0.50)) {
    idx <- which.min(abs(mus - p))
    cu <- cav_U[idx]; cf <- cav_flat[idx]; cm <- cav_M[idx]
    total <- cu - cm; entry_ch <- cf - cm; screen_ch <- cu - cf
    if (abs(total) > 1e-10) {
      cat(sprintf("p=%.2f: total=%.4f, entry=%.4f (%4.0f%%), screening=%.4f (%4.0f%%)\n",
                  p, total, entry_ch, entry_ch/total*100, screen_ch, screen_ch/total*100))
    } else {
      cat(sprintf("p=%.2f: total=%.4f (no advantage)\n", p, total))
    }
  }
})
