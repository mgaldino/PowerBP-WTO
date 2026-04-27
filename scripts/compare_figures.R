source("scripts/model_functions.R")

# ── Helper: compute tau(R) via binary search ──
compute_tau <- function(r, alpha, N, beta, c, rule = "U") {
  vw_fn <- if (rule == "U") VW_R1_unanimity else VW_R1_majority
  lo <- 0.001; hi <- 1
  vw_hi <- tryCatch(vw_fn(r, alpha, hi, N, beta), error = function(e) NA)
  if (is.na(vw_hi) || vw_hi < c) return(NA)
  vw_lo <- tryCatch(vw_fn(r, alpha, lo, N, beta), error = function(e) NA)
  if (is.na(vw_lo)) return(NA)
  if (vw_lo >= c) return(lo)
  for (iter in 1:50) {
    mid <- (lo + hi) / 2
    vw_mid <- tryCatch(vw_fn(r, alpha, mid, N, beta), error = function(e) NA)
    if (is.na(vw_mid)) { hi <- mid; next }
    if (vw_mid >= c) hi <- mid else lo <- mid
  }
  return((lo + hi) / 2)
}

alpha_star_fn <- function(N, beta) {
  q <- floor(N/2) + 1
  beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
}

# ══════════════════════════════════════════════
# FIGURE A: Heatmap of tau(U) (current design)
# ══════════════════════════════════════════════
pdf("figures/compare_figA_heatmap.pdf", width = 9, height = 4.5)

N <- 5; beta <- 0.9; c_val <- 0.1
a_star_val <- alpha_star_fn(N, beta)

rs <- seq(1.1, 3, by = 0.05)
alphas <- seq(0.01, 0.48, by = 0.01)

par(mfrow = c(1, 2), mar = c(4, 4, 2.5, 1))

# Panel 1: r vs alpha
mat1 <- matrix(NA, length(rs), length(alphas))
for (i in seq_along(rs)) {
  for (j in seq_along(alphas)) {
    if (alphas[j] < 1/rs[i]) {
      mat1[i, j] <- tryCatch(compute_tau(rs[i], alphas[j], N, beta, c_val, "U"),
                              error = function(e) NA)
    }
  }
}

image(rs, alphas, mat1,
      col = colorRampPalette(c("steelblue4", "steelblue2", "lightyellow",
                                "firebrick2", "firebrick4"))(100),
      xlab = "r (type gap)", ylab = expression(alpha),
      main = expression(paste(beta, "=0.9, N=5, c=0.1")), las = 1)
curve(1/x, from = 1.1, to = 3, add = TRUE, lty = 2, lwd = 1.5)
abline(h = a_star_val, lty = 3, lwd = 1.5, col = "gray40")
legend("topright",
       c(expression(alpha == 1/r ~ " (model boundary)"),
         expression(alpha^"*" ~ " (Thm 1 threshold)")),
       lty = c(2, 3), lwd = 1.5, col = c("black", "gray40"),
       cex = 0.6, bg = "white")
mtext("White = outside model domain", side = 1, line = -1, adj = 0.95, cex = 0.55, col = "gray40")

# Panel 2: beta vs r
betas <- seq(0.5, 0.99, by = 0.01)
mat2 <- matrix(NA, length(betas), length(rs))
for (i in seq_along(betas)) {
  for (j in seq_along(rs)) {
    if (0.3 < 1/rs[j]) {
      mat2[i, j] <- tryCatch(compute_tau(rs[j], 0.3, N, betas[i], c_val, "U"),
                              error = function(e) NA)
    }
  }
}

image(betas, rs, mat2,
      col = colorRampPalette(c("steelblue4", "steelblue2", "lightyellow",
                                "firebrick2", "firebrick4"))(100),
      xlab = expression(beta), ylab = "r",
      main = expression(paste(alpha, "=0.3, N=5, c=0.1")), las = 1)
legend("topleft",
       c(expression(paste("Blue: low ", tau(U), " (U viable widely)")),
         expression(paste("Red: high ", tau(U), " (U viable only at high p)"))),
       fill = c("steelblue4", "firebrick4"), cex = 0.55, bg = "white")

dev.off()

# ══════════════════════════════════════════════
# FIGURE B: 1D classification bars (proposed)
# ══════════════════════════════════════════════
pdf("figures/compare_figB_bars.pdf", width = 7, height = 4)

N <- 5; r <- 1.5; alpha <- 0.3; beta <- 0.9
costs <- c(0.05, 0.10, 0.14, 0.20)

par(mar = c(4, 5, 3, 8), xpd = TRUE)
plot(NULL, xlim = c(0, 1), ylim = c(0.5, length(costs) + 0.5),
     xlab = expression(paste("Prior belief  ", p == Pr(theta == 1))),
     ylab = "", yaxt = "n",
     main = "Institutional classification (N=5, r=1.5, \u03b1=0.3, \u03b2=0.9)")

col_U   <- "#3182BDCC"
col_M   <- "#E6550DCC"
col_none <- "gray85"

for (i in seq_along(costs)) {
  cc <- costs[i]
  tau_m <- compute_tau(r, alpha, N, beta, cc, "M")
  tau_u <- compute_tau(r, alpha, N, beta, cc, "U")

  if (is.na(tau_m)) tau_m <- 1
  if (is.na(tau_u)) tau_u <- 1

  # Gray: neither forms
  rect(0, i - 0.3, tau_m, i + 0.3, col = col_none, border = NA)
  # Orange: M dominates (entry only)
  if (tau_u > tau_m) {
    rect(tau_m, i - 0.3, tau_u, i + 0.3, col = col_M, border = NA)
  }
  # Blue: U dominates
  if (tau_u < 1) {
    rect(tau_u, i - 0.3, 1, i + 0.3, col = col_U, border = NA)
  }

  # Border
  rect(0, i - 0.3, 1, i + 0.3, col = NA, border = "black", lwd = 0.5)

  # Tick marks for thresholds
  if (tau_m > 0.01 & tau_m < 0.99) {
    segments(tau_m, i - 0.35, tau_m, i + 0.35, lwd = 1.5)
    text(tau_m, i + 0.42, expression(tau(M)), cex = 0.5)
  }
  if (tau_u > 0.01 & tau_u < 0.99) {
    segments(tau_u, i - 0.35, tau_u, i + 0.35, lwd = 1.5)
    text(tau_u, i + 0.42, expression(tau(U)), cex = 0.5)
  }

  # Percentage labels
  pct_U <- round((1 - tau_u) * 100)
  pct_M <- round((tau_u - tau_m) * 100)
  if (pct_U > 5) text((tau_u + 1)/2, i, paste0(pct_U, "%"), cex = 0.6, col = "white", font = 2)
  if (pct_M > 5) text((tau_m + tau_u)/2, i, paste0(pct_M, "%"), cex = 0.6, col = "white", font = 2)

  # y-axis label
  axis(2, at = i, labels = bquote(c == .(cc)), las = 1, tick = FALSE)
}

legend(1.02, length(costs) + 0.3,
       legend = c(expression(p %in% E[U] ~ ": U dominates"),
                  expression(p %in% E[M]~"\\"~ E[U] ~ ": M dominates (entry)"),
                  expression(p %notin% E[M] ~ ": neither forms")),
       fill = c(col_U, col_M, col_none),
       border = "black", cex = 0.65, bg = "white", bty = "n")

dev.off()

cat("Done. Files saved:\n")
cat("  figures/compare_figA_heatmap.pdf\n")
cat("  figures/compare_figB_bars.pdf\n")
