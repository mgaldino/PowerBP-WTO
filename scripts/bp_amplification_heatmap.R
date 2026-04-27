source("scripts/model_functions.R")

# Fixed parameters
N <- 5
alpha <- 0.3
c_vals <- c(0.05, 0.10, 0.12)

# Screening cutoff R1 (from closed form: phi method)
get_mu_s_R1 <- function(r, alpha, N, beta) {
  if (r <= 1 || beta <= 0 || beta >= 1) return(NA)
  phi <- (r * N - beta * (N - 1 + r)) / (beta * (r - 1))
  disc <- phi^2 - 4 * (N - 2)
  if (disc < 0) return(NA)
  mu_s <- (phi - sqrt(disc)) / (2 * (N - 1))
  if (mu_s > 0 && mu_s < 1) return(mu_s) else return(NA)
}

# Entry threshold under unanimity (binary search)
get_tau_U <- function(r, alpha, N, beta, c_val) {
  for (mu in seq(0.001, 0.999, by = 0.001)) {
    vw <- tryCatch(VW_R1_unanimity(r, alpha, mu, N, beta), error = function(e) NA)
    if (!is.na(vw) && vw >= c_val) return(mu)
  }
  return(NA)
}

# Grid
r_vals <- seq(1.1, 3.0, length.out = 40)
beta_vals <- seq(0.3, 0.99, length.out = 40)

compute_bp_matrix <- function(c_val) {
  bp_matrix <- matrix(NA, nrow = length(r_vals), ncol = length(beta_vals))
  for (i in seq_along(r_vals)) {
    for (j in seq_along(beta_vals)) {
      r <- r_vals[i]
      beta <- beta_vals[j]
      if (alpha >= 1/r) { bp_matrix[i, j] <- NA; next }
      mu_s <- get_mu_s_R1(r, alpha, N, beta)
      if (is.na(mu_s)) { bp_matrix[i, j] <- 0; next }
      tau_U <- get_tau_U(r, alpha, N, beta, c_val)
      if (is.na(tau_U)) { bp_matrix[i, j] <- 0; next }
      if (mu_s <= tau_U) { bp_matrix[i, j] <- 0; next }
      mu_grid <- seq(0.001, 0.999, by = 0.002)
      v_U <- numeric(length(mu_grid))
      for (k in seq_along(mu_grid)) {
        mu <- mu_grid[k]
        vw <- tryCatch(VW_R1_unanimity(r, alpha, mu, N, beta), error = function(e) NA)
        vh <- tryCatch(VH_R1_unanimity(r, alpha, mu, N, beta), error = function(e) NA)
        Ve <- 1 + mu * (r - 1)
        if (!is.na(vw) && !is.na(vh) && vw >= c_val) {
          v_U[k] <- vh - alpha * Ve
        } else {
          v_U[k] <- 0
        }
      }
      cav_result <- tryCatch(concavify(mu_grid, v_U), error = function(e) NULL)
      if (is.null(cav_result)) { bp_matrix[i, j] <- 0; next }
      bp_amp <- cav_result - v_U
      bp_matrix[i, j] <- max(bp_amp, na.rm = TRUE)
    }
  }
  bp_matrix[is.na(bp_matrix)] <- 0
  return(bp_matrix)
}

plot_panel <- function(bp_plot, c_val, global_zlim, cols) {
  image(r_vals, beta_vals, bp_plot,
        col = cols, zlim = global_zlim,
        xlab = "", ylab = "",
        main = paste0("c = ", c_val),
        cex.main = 1.3)
  max_bp <- max(bp_plot, na.rm = TRUE)
  if (max_bp > 0.01) {
    lvls <- pretty(c(0, global_zlim[2]), n = 6)
    lvls <- lvls[lvls > 0 & lvls < global_zlim[2]]
    if (length(lvls) > 0) {
      contour(r_vals, beta_vals, bp_plot,
              levels = lvls, add = TRUE, col = "grey30", labcex = 0.7)
    }
  }
  # Red boundary
  boundary_r <- numeric(length(beta_vals))
  for (j in seq_along(beta_vals)) {
    pos <- which(bp_plot[, j] > 0.01)
    if (length(pos) > 0) boundary_r[j] <- r_vals[min(pos)]
    else boundary_r[j] <- NA
  }
  valid_b <- !is.na(boundary_r)
  if (any(valid_b)) {
    lines(boundary_r[valid_b], beta_vals[valid_b], col = "red", lwd = 3)
  }
}

# Compute all panels
results <- list()
for (cc in seq_along(c_vals)) {
  cat("Panel", cc, "/ 3 (c =", c_vals[cc], ")... ")
  results[[cc]] <- compute_bp_matrix(c_vals[cc])
  cat("max =", round(max(results[[cc]]), 3), "\n")
}

# Global color scale
global_max <- max(sapply(results, max, na.rm = TRUE))
global_zlim <- c(0, global_max)
n_colors <- 100
cols <- colorRampPalette(c("white", "#deebf7", "#9ecae1", "#3182bd", "#08519c"))(n_colors)

# PDF
pdf("figures/bp_amplification_r_beta.pdf", width = 14, height = 5)
par(mfrow = c(1, 3), mar = c(5, 4.5, 3, 1), oma = c(2, 2, 2, 0))
for (cc in seq_along(c_vals)) {
  plot_panel(results[[cc]], c_vals[cc], global_zlim, cols)
  if (cc == 1) mtext(expression(beta ~ " (discount factor)"), side = 2, line = 3, cex = 0.9)
}
mtext(expression(italic(r) ~ " (payoff dispersion)"), side = 1, line = 0, outer = TRUE, cex = 0.9)
mtext(expression("BP amplification: " ~ max[mu] ~ (cav ~ v(mu, U) - v(mu, U))),
      side = 3, line = 0, outer = TRUE, cex = 1.1)
mtext(paste0("N=", N, ", alpha=", alpha, "  |  Red: boundary mu_s^R1 > tau(U)"),
      side = 1, line = 0.8, outer = TRUE, cex = 0.8)
dev.off()
cat("Saved PDF\n")

# PNG
png("figures/bp_amplification_r_beta.png", width = 1400, height = 500)
par(mfrow = c(1, 3), mar = c(5, 4.5, 3, 1), oma = c(2, 2, 2, 0))
for (cc in seq_along(c_vals)) {
  plot_panel(results[[cc]], c_vals[cc], global_zlim, cols)
  if (cc == 1) mtext(expression(beta ~ " (discount factor)"), side = 2, line = 3, cex = 0.9)
}
mtext(expression(italic(r) ~ " (payoff dispersion)"), side = 1, line = 0, outer = TRUE, cex = 0.9)
mtext(expression("BP amplification: " ~ max[mu] ~ (cav ~ v(mu, U) - v(mu, U))),
      side = 3, line = 0, outer = TRUE, cex = 1.1)
mtext(paste0("N=", N, ", alpha=", alpha, "  |  Red: boundary mu_s^R1 > tau(U)"),
      side = 1, line = 0.8, outer = TRUE, cex = 0.8)
dev.off()
cat("Saved PNG\n")
