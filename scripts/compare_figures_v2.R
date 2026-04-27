source("scripts/model_functions.R")

N <- 5; r <- 1.5; alpha <- 0.3; beta <- 0.9

# ══════════════════════════════════════════════
# FIGURE A: V_W curves under both rules
# ══════════════════════════════════════════════
pdf("figures/compare_figA2_vw_curves.pdf", width = 7, height = 5)

ps <- seq(0.001, 0.999, by = 0.002)

vw_U <- sapply(ps, function(p) VW_R1_unanimity(r, alpha, p, N, beta))
vw_M <- sapply(ps, function(p) VW_R1_majority(r, alpha, p, N, beta))

par(mar = c(4.5, 4.5, 2, 1))
plot(ps, vw_M, type = "l", col = "#E6550D", lwd = 2.5,
     xlab = expression(paste("Prior belief  ", p)),
     ylab = expression(paste(V[W]^{R1}, "(p, R)")),
     main = "Weak-state payoff under each rule (N=5, r=1.5, \u03b1=0.3, \u03b2=0.9)",
     ylim = range(c(vw_U, vw_M), na.rm = TRUE),
     las = 1)
lines(ps, vw_U, col = "#3182BD", lwd = 2.5)

# Example c levels
c_vals <- c(0.05, 0.10, 0.14, 0.20)
c_cols <- c("gray70", "gray55", "gray40", "gray25")
for (k in seq_along(c_vals)) {
  abline(h = c_vals[k], lty = 3, col = c_cols[k], lwd = 1)
  text(0.02, c_vals[k] + 0.003, bquote(c == .(c_vals[k])),
       cex = 0.6, col = c_cols[k], adj = 0)
}

# Shade the gap between curves lightly
polygon(c(ps, rev(ps)), c(vw_M, rev(vw_U)),
        col = adjustcolor("orange", alpha.f = 0.1), border = NA)

# Annotations
text(0.7, max(vw_M) * 0.95, expression(V[W](p, M)), col = "#E6550D", cex = 0.9, font = 2)
text(0.7, min(vw_U) + (max(vw_U) - min(vw_U)) * 0.5, expression(V[W](p, U)),
     col = "#3182BD", cex = 0.9, font = 2)

# Arrow pointing to gap
arrows(0.5, mean(c(vw_U[250], vw_M[250])) - 0.005,
       0.5, mean(c(vw_U[250], vw_M[250])) + 0.005,
       length = 0, lwd = 1, col = "gray30")
text(0.55, mean(c(vw_U[250], vw_M[250])),
     "Entry gap\n(Thm 1 + budget)", cex = 0.55, col = "gray30", adj = 0)

legend("topleft",
       c("Majority", "Unanimity", "Entry cost c"),
       col = c("#E6550D", "#3182BD", "gray40"),
       lwd = c(2.5, 2.5, 1), lty = c(1, 1, 3),
       cex = 0.7, bg = "white")

dev.off()

# ══════════════════════════════════════════════
# FIGURE B: Classification bars (same as before, improved)
# ══════════════════════════════════════════════
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

pdf("figures/compare_figB2_bars.pdf", width = 7, height = 3.5)

costs <- c(0.05, 0.10, 0.14, 0.20)
col_U    <- "#3182BDCC"
col_M    <- "#E6550DCC"
col_none <- "gray85"

par(mar = c(4, 5, 2.5, 1))
plot(NULL, xlim = c(0, 1), ylim = c(0.5, length(costs) + 0.5),
     xlab = expression(paste("Prior belief  ", p)),
     ylab = "", yaxt = "n",
     main = "Institutional classification (N=5, r=1.5, \u03b1=0.3, \u03b2=0.9)")

for (i in seq_along(costs)) {
  cc <- costs[i]
  tau_m <- compute_tau(r, alpha, N, beta, cc, "M")
  tau_u <- compute_tau(r, alpha, N, beta, cc, "U")
  if (is.na(tau_m)) tau_m <- 1
  if (is.na(tau_u)) tau_u <- 1

  # Gray: neither forms
  rect(0, i - 0.3, tau_m, i + 0.3, col = col_none, border = NA)
  # Orange: M dominates (entry only)
  if (tau_u > tau_m)
    rect(tau_m, i - 0.3, tau_u, i + 0.3, col = col_M, border = NA)
  # Blue: U dominates
  if (tau_u < 1)
    rect(tau_u, i - 0.3, 1, i + 0.3, col = col_U, border = NA)

  rect(0, i - 0.3, 1, i + 0.3, col = NA, border = "black", lwd = 0.5)

  # Tick marks
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
  if (pct_U > 8) text((tau_u + 1)/2, i, paste0(pct_U, "%"),
                       cex = 0.6, col = "white", font = 2)
  if (pct_M > 8) text((tau_m + tau_u)/2, i, paste0(pct_M, "%"),
                       cex = 0.6, col = "white", font = 2)

  axis(2, at = i, labels = bquote(c == .(cc)), las = 1, tick = FALSE)
}

legend("bottomright",
       legend = c(expression(p %in% E[U] ~ ": U dominates (Thm 1)"),
                  expression(p %in% E[M] %\% E[U] ~ ": M dominates (entry)"),
                  expression(p %notin% E[M] ~ ": neither forms")),
       fill = c(col_U, col_M, col_none),
       border = "black", cex = 0.6, bg = "white")

dev.off()

cat("Done.\n")
cat("  figures/compare_figA2_vw_curves.pdf\n")
cat("  figures/compare_figB2_bars.pdf\n")
