# Visualization: μ̄(α) threshold and (α, μ) heatmap
# Shows where unanimity dominates vs majority as function of α and belief μ
# For the iff version of Lemma 1

source("scripts/model_functions.R")

# --- Core computation: D(α, μ) = VH_unanimity - VH_majority ---

D_payoff <- function(alpha, mu, r, N, beta) {
  vh_u <- tryCatch(VH_R1_unanimity(r, alpha, mu, N, beta), error = function(e) NA)
  vh_m <- tryCatch(VH_R1_majority(r, alpha, mu, N, beta), error = function(e) NA)
  if (is.na(vh_u) || is.na(vh_m)) return(NA)
  return(vh_u - vh_m)
}

# --- Find μ̄(α): the belief above which majority dominates ---

find_mu_bar <- function(alpha, r, N, beta, tol = 1e-6) {
  alpha_star <- alpha_star_fn(N, beta)
  if (alpha < alpha_star) return(NA)  # unanimity dominates everywhere

  # Check D(1)
  d1 <- D_payoff(alpha, 1, r, N, beta)
  if (is.na(d1) || d1 > 0) return(NA)  # no crossing

  # Check D at low mu
  d_low <- D_payoff(alpha, 0.01, r, N, beta)
  if (is.na(d_low) || d_low <= 0) return(0)  # majority dominates everywhere

  # Bisection
  lo <- 0.01; hi <- 1
  while (hi - lo > tol) {
    mid <- (lo + hi) / 2
    d_mid <- D_payoff(alpha, mid, r, N, beta)
    if (is.na(d_mid)) { hi <- mid; next }
    if (d_mid > 0) lo <- mid else hi <- mid
  }
  return((lo + hi) / 2)
}

alpha_star_fn <- function(N, beta) {
  q <- floor(N / 2) + 1
  beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
}

# ============================================================
# FIGURE 1: Heatmap — (α, μ) plane colored by sign of D
# ============================================================

plot_heatmap <- function(r, N, beta, n_grid = 200, main_title = NULL) {
  alpha_max <- min(1/r - 0.01, 0.5)
  alphas <- seq(0.005, alpha_max, length.out = n_grid)
  mus <- seq(0.01, 1, length.out = n_grid)

  D_matrix <- matrix(NA, nrow = n_grid, ncol = n_grid)
  for (i in seq_along(alphas)) {
    for (j in seq_along(mus)) {
      D_matrix[i, j] <- D_payoff(alphas[i], mus[j], r, N, beta)
    }
  }

  a_star <- alpha_star_fn(N, beta)

  if (is.null(main_title)) {
    main_title <- bquote(r == .(r) ~ ", " ~ beta == .(beta) ~ ", N=" ~ .(N))
  }

  # Color: blue = unanimity dominates (D > 0), red = majority (D < 0)
  cols <- ifelse(D_matrix > 0, "#3182BD80", "#E6550D80")
  cols[is.na(D_matrix)] <- "grey90"

  image(alphas, mus, D_matrix, col = NA, xlab = expression(alpha),
        ylab = expression(mu), main = main_title, cex.main = 1)

  # Plot colored rectangles
  da <- diff(alphas[1:2]); dm <- diff(mus[1:2])
  for (i in seq_along(alphas)) {
    for (j in seq_along(mus)) {
      rect(alphas[i] - da/2, mus[j] - dm/2,
           alphas[i] + da/2, mus[j] + dm/2,
           col = cols[i, j], border = NA)
    }
  }

  # Overlay μ̄(α) curve
  alpha_curve <- seq(a_star, alpha_max, length.out = 100)
  mu_bar_curve <- sapply(alpha_curve, function(a) find_mu_bar(a, r, N, beta))
  valid <- !is.na(mu_bar_curve) & mu_bar_curve > 0
  if (any(valid)) {
    lines(alpha_curve[valid], mu_bar_curve[valid], lwd = 2.5, col = "black")
  }

  # Mark α*
  abline(v = a_star, lty = 2, col = "black", lwd = 1.5)
  text(a_star, 0.05, expression(alpha * "*"), pos = 4, cex = 0.9)

  # Legend
  legend("topleft",
         legend = c("Unanimity dominates", "Majority dominates",
                    expression(bar(mu)(alpha) ~ "frontier")),
         fill = c("#3182BD80", "#E6550D80", NA),
         border = c("black", "black", NA),
         lty = c(NA, NA, 1), lwd = c(NA, NA, 2.5), col = c(NA, NA, "black"),
         merge = TRUE, cex = 0.7, bg = "white")
}

# ============================================================
# FIGURE 2: Curves — μ̄(α) for different r levels
# ============================================================

plot_mu_bar_curves <- function(N, beta, r_values, main_title = NULL) {
  cols <- c("#1b9e77", "#d95f02", "#7570b3", "#e7298a")

  if (is.null(main_title)) {
    main_title <- bquote(beta == .(beta) ~ ", N=" ~ .(N))
  }

  alpha_max <- min(1 / min(r_values) - 0.01, 0.5)
  a_star <- alpha_star_fn(N, beta)

  plot(NULL, xlim = c(0, alpha_max), ylim = c(0, 1),
       xlab = expression(alpha), ylab = expression(bar(mu)),
       main = main_title)

  # Shade α < α* region
  rect(0, 0, a_star, 1, col = "#3182BD20", border = NA)
  text(a_star / 2, 0.5, "U dominates\nfor all beliefs",
       cex = 0.7, col = "#3182BD")

  abline(v = a_star, lty = 2, col = "black", lwd = 1.5)
  text(a_star, 0.02, expression(alpha * "*"), pos = 4, cex = 0.9)

  for (k in seq_along(r_values)) {
    r <- r_values[k]
    a_max_r <- 1/r - 0.01
    alphas <- seq(a_star + 0.001, min(a_max_r, alpha_max), length.out = 200)
    mu_bars <- sapply(alphas, function(a) find_mu_bar(a, r, N, beta))
    valid <- !is.na(mu_bars) & mu_bars > 0
    if (any(valid)) {
      lines(alphas[valid], mu_bars[valid], col = cols[k], lwd = 2.5)
    }
  }

  legend("topright",
         legend = as.expression(lapply(r_values, function(rv) bquote(r == .(rv)))),
         col = cols[seq_along(r_values)], lwd = 2.5, cex = 0.85, bg = "white")
}

# ============================================================
# Generate figures
# ============================================================

# --- Heatmaps: 2x2 panel ---
pdf("figures/heatmap_alpha_mu.pdf", width = 10, height = 8)
par(mfrow = c(2, 2), mar = c(4, 4, 3, 1))
plot_heatmap(r = 1.5, N = 30,  beta = 0.9, n_grid = 150)
plot_heatmap(r = 2.0, N = 30,  beta = 0.9, n_grid = 150)
plot_heatmap(r = 1.5, N = 164, beta = 0.9, n_grid = 150)
plot_heatmap(r = 2.0, N = 164, beta = 0.9, n_grid = 150)
dev.off()

# --- Curves: 2 panels (different N) ---
pdf("figures/mu_bar_curves.pdf", width = 10, height = 5)
par(mfrow = c(1, 2), mar = c(4, 4, 3, 1))
plot_mu_bar_curves(N = 30,  beta = 0.9, r_values = c(1.2, 1.5, 2.0, 3.0))
plot_mu_bar_curves(N = 164, beta = 0.9, r_values = c(1.2, 1.5, 2.0, 3.0))
dev.off()

cat("Figures saved to figures/heatmap_alpha_mu.pdf and figures/mu_bar_curves.pdf\n")
