# k3_concavification.R
#
# Tasks 4 and 5: Concavification on the 2-simplex + ternary heatmap figures.
#
# For each prior p on the simplex, H can design any Bayes-plausible signal
# (mixture of posteriors averaging to p).  The supremum of H's expected payoff
# is the concave envelope (cav) of the raw value function v(mu).
#
# Figures produced:
#   figures/k3_heatmap_institutional.pdf  — cav v(U) - cav v(M) heatmap
#   figures/k3_value_surfaces.pdf         — two-panel raw value functions
#
# Parameters: r1=1.5, r2=2.5, N=5, alpha=0.3, beta=0.9, c_entry=0.1

# =============================================================================
# 0. DEPENDENCIES
# =============================================================================

# Source K=3 screening functions (skip built-in verification block)
k3_screening_skip_verify <- TRUE

# Resolve path relative to this script's location
.script_dir <- tryCatch(
  dirname(normalizePath(sys.frame(1)$ofile)),
  error = function(e) {
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- grep("--file=", args, value = TRUE)
    if (length(file_arg) > 0) {
      dirname(normalizePath(sub("--file=", "", file_arg[1])))
    } else {
      getwd()
    }
  }
)
source(file.path(.script_dir, "k3_screening.R"))

# Install lpSolve if needed
if (!requireNamespace("lpSolve", quietly = TRUE)) {
  install.packages("lpSolve", repos = "https://cloud.r-project.org")
}
library(lpSolve)

cat("=== K=3 Concavification on the 2-simplex ===\n\n")


# =============================================================================
# 1. SIMPLEX GRID GENERATOR
# =============================================================================

#' Generate a grid of points on the 2-simplex.
#'
#' @param n_per_side  Number of steps per side.
#' @param interior_only  If TRUE, exclude exact boundary points (any mu = 0).
#' @return Matrix with 3 columns (mu0, mu1, mu2), one row per grid point.
simplex_grid <- function(n_per_side, interior_only = TRUE) {
  pts <- list()
  for (i in 0:n_per_side) {
    for (j in 0:(n_per_side - i)) {
      k <- n_per_side - i - j
      mu <- c(i, j, k) / n_per_side
      if (interior_only && any(mu < 1e-6)) next
      pts[[length(pts) + 1]] <- mu
    }
  }
  do.call(rbind, pts)
}


# =============================================================================
# 2. VALUE FUNCTIONS ON SIMPLEX GRID (with entry threshold)
# =============================================================================

#' Compute raw value functions at every grid point.
#'
#' Entry occurs only when the W's expected payoff meets or exceeds c_entry.
#' If W does not find it worth participating, H gets 0 under that rule.
#'
#' @param grid     Matrix (n x 3) of simplex points.
#' @param r1,r2   Type values (1 < r1 < r2).
#' @param alpha    Outside-option share.
#' @param beta     Discount factor.
#' @param N        Number of players (1 H + N-1 Ws).
#' @param c_entry  Minimum payoff W needs to enter.
#' @return data.frame with columns mu0, mu1, mu2, v_U, v_M, vw_U, vw_M.
compute_values_on_grid <- function(grid, r1, r2, alpha, beta, N, c_entry) {
  n <- nrow(grid)
  v_U <- v_M <- vw_U <- vw_M <- numeric(n)
  for (i in 1:n) {
    mu <- grid[i, ]
    vw_U[i] <- VW_R1_k3_unanimity(mu, r1, r2, alpha, beta, N)
    vw_M[i] <- VW_R1_k3_majority(mu, r1, r2, alpha, beta, N)
    v_U[i]  <- if (vw_U[i] >= c_entry) VH_R1_k3_unanimity(mu, r1, r2, alpha, beta, N) else 0
    v_M[i]  <- if (vw_M[i] >= c_entry) VH_R1_k3_majority(mu, r1, r2, alpha, beta, N) else 0
  }
  data.frame(mu0 = grid[, 1], mu1 = grid[, 2], mu2 = grid[, 3],
             v_U = v_U, v_M = v_M, vw_U = vw_U, vw_M = vw_M)
}


# =============================================================================
# 3. LP-BASED CONCAVIFICATION
# =============================================================================

#' Compute the concave envelope (cav f) at query points via LP.
#'
#' For each query point p, solves:
#'   max  sum_i w_i * f(mu_i)
#'   s.t. sum_i w_i * mu_i[1] = p[1]   (Bayes plausibility, coord 1)
#'        sum_i w_i * mu_i[2] = p[2]   (Bayes plausibility, coord 2)
#'        sum_i w_i = 1                 (weights sum to 1)
#'        w_i >= 0
#'
#' The third simplex coordinate is determined by the first two constraints
#' together with the sum-to-one constraint.
#'
#' @param grid    Matrix (n x 3) of support points for the LP.
#' @param f_vals  Numeric vector of length n: f(mu_i) at each support point.
#' @param query   Matrix (m x 3) of points where cav f is evaluated.
#'                Defaults to grid itself.
#' @return Numeric vector of length m: cav f values at query points.
concavify_simplex <- function(grid, f_vals, query = grid) {
  n <- nrow(grid)
  m <- nrow(query)

  # Constraint matrix: 3 rows (Bayes-plausible in mu0, mu1, sum=1)
  A <- rbind(grid[, 1],    # row 1: mu0 coordinates
             grid[, 2],    # row 2: mu1 coordinates
             rep(1, n))    # row 3: sum of weights

  cav_vals <- numeric(m)
  for (i in 1:m) {
    p <- query[i, ]
    rhs <- c(p[1], p[2], 1)
    result <- lp("max", f_vals, A, rep("=", 3), rhs)
    cav_vals[i] <- if (result$status == 0) result$objval else NA
  }
  cav_vals
}


# =============================================================================
# 4. BARYCENTRIC → CARTESIAN CONVERSION AND TERNARY AXES
# =============================================================================

#' Convert barycentric coordinates to Cartesian for an equilateral triangle.
#'
#' Vertex placement:
#'   mu0 at bottom-left  (0, 0)
#'   mu1 at bottom-right (1, 0)
#'   mu2 at top          (0.5, sqrt(3)/2)
#'
#' @param mu0,mu1,mu2  Barycentric coordinates (each in [0,1], sum to 1).
#' @return Two-column matrix of (x, y) Cartesian coordinates.
bary_to_cart <- function(mu0, mu1, mu2) {
  x <- mu1 + mu2 / 2
  y <- mu2 * sqrt(3) / 2
  cbind(x, y)
}


#' Draw the equilateral triangle frame for a ternary plot.
#'
#' @param labels  Length-3 character/expression vector for vertex labels.
ternary_axes <- function(labels = c(expression(p[0]), expression(p[1]), expression(p[2]))) {
  plot(NULL, xlim = c(-0.08, 1.08), ylim = c(-0.08, sqrt(3)/2 + 0.08),
       asp = 1, axes = FALSE, xlab = "", ylab = "")
  polygon(c(0, 1, 0.5), c(0, 0, sqrt(3)/2), border = "black", lwd = 1.5)
  text(-0.06, -0.04, labels[1], cex = 1.1)
  text( 1.06, -0.04, labels[2], cex = 1.1)
  text( 0.50, sqrt(3)/2 + 0.06, labels[3], cex = 1.1)
}


# =============================================================================
# 5. PARAMETERS AND GRID CONSTRUCTION
# =============================================================================

r1      <- 1.5
r2      <- 2.5
N       <- 5
alpha   <- 0.3
beta    <- 0.9
c_entry <- 0.1

n_per_side <- 60   # ~1,830 points; reduce to 40 if too slow

cat(sprintf("Parameters: r1=%.1f, r2=%.1f, N=%d, alpha=%.1f, beta=%.1f, c_entry=%.1f\n",
            r1, r2, N, alpha, beta, c_entry))

# Build grid including boundary; nudge exact zeros to avoid degenerate LPs
cat(sprintf("Building simplex grid (n_per_side=%d)...\n", n_per_side))
grid_raw <- simplex_grid(n_per_side, interior_only = FALSE)
grid_raw[grid_raw < 1e-6] <- 1e-6
grid_raw <- grid_raw / rowSums(grid_raw)   # re-normalise after nudge

cat(sprintf("Grid points: %d\n\n", nrow(grid_raw)))


# =============================================================================
# 6. COMPUTE RAW VALUE FUNCTIONS
# =============================================================================

cat("Computing value functions on grid...\n")
t0 <- proc.time()
vals <- compute_values_on_grid(grid_raw, r1, r2, alpha, beta, N, c_entry)
t1 <- proc.time()
cat(sprintf("  Done in %.1f s\n\n", (t1 - t0)["elapsed"]))


# =============================================================================
# 7. CONCAVIFICATION VIA LP
# =============================================================================

cat(sprintf("Running LP concavification (%d LPs with %d variables each)...\n",
            nrow(grid_raw), nrow(grid_raw)))
t0 <- proc.time()
cav_U <- concavify_simplex(grid_raw, vals$v_U)
cav_M <- concavify_simplex(grid_raw, vals$v_M)
t1 <- proc.time()
cat(sprintf("  Done in %.1f s\n\n", (t1 - t0)["elapsed"]))


# =============================================================================
# 8. VERIFICATION
# =============================================================================

cat("--- Verification ---\n")

# (a) cav >= v pointwise
gap_U <- cav_U - vals$v_U
gap_M <- cav_M - vals$v_M
tol   <- -1e-6   # allow tiny numerical slack

ok_U <- all(gap_U > tol, na.rm = TRUE)
ok_M <- all(gap_M > tol, na.rm = TRUE)
cat(sprintf("cav v(U) >= v(U) everywhere: %s  (min gap = %.2e)\n",
            ifelse(ok_U, "YES", "NO"), min(gap_U, na.rm = TRUE)))
cat(sprintf("cav v(M) >= v(M) everywhere: %s  (min gap = %.2e)\n",
            ifelse(ok_M, "YES", "NO"), min(gap_M, na.rm = TRUE)))

# (b) Institutional comparison
diff_cav <- cav_U - cav_M
n_valid  <- sum(!is.na(diff_cav))
pct_U    <- 100 * mean(diff_cav > 0, na.rm = TRUE)
pct_M    <- 100 * mean(diff_cav < 0, na.rm = TRUE)
pct_tie  <- 100 * mean(diff_cav == 0, na.rm = TRUE)

cat(sprintf("\nInstitutional comparison (cav v(U) vs cav v(M)):\n"))
cat(sprintf("  Unanimity dominates (U > M): %.1f%% of grid points\n", pct_U))
cat(sprintf("  Majority dominates  (M > U): %.1f%% of grid points\n", pct_M))
cat(sprintf("  Tie (U = M):                 %.1f%% of grid points\n", pct_tie))
cat(sprintf("  min(cav U - cav M) = %.4f\n", min(diff_cav, na.rm = TRUE)))
cat(sprintf("  max(cav U - cav M) = %.4f\n", max(diff_cav, na.rm = TRUE)))
cat(sprintf("  mean(cav U - cav M)= %.4f\n\n", mean(diff_cav, na.rm = TRUE)))


# =============================================================================
# 9. FIGURE D.1 — HEATMAP: cav v(U) - cav v(M)
# =============================================================================

figures_dir <- file.path(.script_dir, "..", "figures")
if (!dir.exists(figures_dir)) dir.create(figures_dir, recursive = TRUE)

fig1_path <- file.path(figures_dir, "k3_heatmap_institutional.pdf")
cat(sprintf("Saving Figure D.1 to %s ...\n", fig1_path))

pdf(fig1_path, width = 6, height = 5.5)

# Diverging blue-white-red palette
n_colors <- 201
cmap <- colorRampPalette(c("#2166AC", "#92C5DE", "#F7F7F7",
                            "#F4A582", "#D6604D"))(n_colors)

# Map diff_cav to colour index
d_min  <- min(diff_cav, na.rm = TRUE)
d_max  <- max(diff_cav, na.rm = TRUE)
# Symmetric colour scale centred at 0
d_abs  <- max(abs(d_min), abs(d_max))
d_lo   <- -d_abs
d_hi   <-  d_abs

col_idx <- pmin(n_colors,
                pmax(1L, as.integer((diff_cav - d_lo) / (d_hi - d_lo) * (n_colors - 1)) + 1L))
pt_cols <- cmap[col_idx]

# Cartesian coordinates
cart <- bary_to_cart(vals$mu0, vals$mu1, vals$mu2)

ternary_axes(labels = c(expression(p[0]), expression(p[1]), expression(p[2])))
title(main = expression("cav" ~ italic(v)(bold(p), U) - "cav" ~ italic(v)(bold(p), M)),
      cex.main = 1.0)
points(cart[, 1], cart[, 2], col = pt_cols, pch = 16,
       cex = max(0.3, 50 / n_per_side))

# Colour legend (vertical bar on the right)
legend_x <- 1.02; legend_y_bot <- 0.05; legend_y_top <- sqrt(3)/2 - 0.05
legend_h  <- legend_y_top - legend_y_bot
n_leg     <- 100
leg_cols  <- cmap[round(seq(1, n_colors, length.out = n_leg))]
rect_h    <- legend_h / n_leg
for (k in seq_len(n_leg)) {
  rect(legend_x, legend_y_bot + (k-1)*rect_h,
       legend_x + 0.03, legend_y_bot + k*rect_h,
       col = leg_cols[k], border = NA)
}
rect(legend_x, legend_y_bot, legend_x + 0.03, legend_y_top, border = "black", lwd = 0.5)
text(legend_x + 0.04, legend_y_bot,  sprintf("%.2f", d_lo), adj = 0, cex = 0.7)
text(legend_x + 0.04, (legend_y_bot + legend_y_top)/2, "0", adj = 0, cex = 0.7)
text(legend_x + 0.04, legend_y_top, sprintf("%.2f", d_hi), adj = 0, cex = 0.7)
text(legend_x + 0.015, legend_y_top + 0.05, "U-M", cex = 0.7, adj = 0.5)

# Annotation: percent of simplex where U dominates
mtext(sprintf("U dominant: %.0f%% | M dominant: %.0f%%", pct_U, pct_M),
      side = 1, line = -1, cex = 0.75)

dev.off()
cat("  Saved.\n")


# =============================================================================
# 10. FIGURE D.2 — TWO-PANEL RAW VALUE SURFACES
# =============================================================================

fig2_path <- file.path(figures_dir, "k3_value_surfaces.pdf")
cat(sprintf("Saving Figure D.2 to %s ...\n", fig2_path))

pdf(fig2_path, width = 11, height = 5.5)
par(mfrow = c(1, 2), mar = c(2, 2, 3, 4))

# ---------- Panel (a): v(mu, U) ----------
v_U_vals <- vals$v_U
v_U_min  <- min(v_U_vals, na.rm = TRUE)
v_U_max  <- max(v_U_vals, na.rm = TRUE)
n_col_U  <- 256
cmap_U   <- colorRampPalette(c("#DEEBF7", "#08306B"))(n_col_U)   # light-to-dark blue

col_idx_U <- pmin(n_col_U,
                  pmax(1L, as.integer((v_U_vals - v_U_min) /
                                        (v_U_max - v_U_min + 1e-12) *
                                        (n_col_U - 1)) + 1L))
pt_cols_U <- cmap_U[col_idx_U]

ternary_axes(labels = c(expression(p[0]), expression(p[1]), expression(p[2])))
title(main = expression("(a) " * italic(v)(bold(p), U) ~ " (Unanimity)"),
      cex.main = 1.0)
points(cart[, 1], cart[, 2], col = pt_cols_U, pch = 16,
       cex = max(0.3, 50 / n_per_side))

# Legend bar
legend_x <- 1.02
leg_cols_U <- cmap_U[round(seq(1, n_col_U, length.out = n_leg))]
for (k in seq_len(n_leg)) {
  rect(legend_x, legend_y_bot + (k-1)*rect_h,
       legend_x + 0.03, legend_y_bot + k*rect_h,
       col = leg_cols_U[k], border = NA)
}
rect(legend_x, legend_y_bot, legend_x + 0.03, legend_y_top, border = "black", lwd = 0.5)
text(legend_x + 0.04, legend_y_bot,  sprintf("%.2f", v_U_min), adj = 0, cex = 0.7)
text(legend_x + 0.04, legend_y_top,  sprintf("%.2f", v_U_max), adj = 0, cex = 0.7)

mtext("Color discontinuities = screening jumps", side = 1, line = -1, cex = 0.65)

# ---------- Panel (b): v(mu, M) ----------
v_M_vals <- vals$v_M
v_M_min  <- min(v_M_vals, na.rm = TRUE)
v_M_max  <- max(v_M_vals, na.rm = TRUE)
n_col_M  <- 256
cmap_M   <- colorRampPalette(c("#FEE0D2", "#67000D"))(n_col_M)   # light-to-dark red

col_idx_M <- pmin(n_col_M,
                  pmax(1L, as.integer((v_M_vals - v_M_min) /
                                        (v_M_max - v_M_min + 1e-12) *
                                        (n_col_M - 1)) + 1L))
pt_cols_M <- cmap_M[col_idx_M]

ternary_axes(labels = c(expression(p[0]), expression(p[1]), expression(p[2])))
title(main = expression("(b) " * italic(v)(bold(p), M) ~ " (Majority)"),
      cex.main = 1.0)
points(cart[, 1], cart[, 2], col = pt_cols_M, pch = 16,
       cex = max(0.3, 50 / n_per_side))

leg_cols_M <- cmap_M[round(seq(1, n_col_M, length.out = n_leg))]
for (k in seq_len(n_leg)) {
  rect(legend_x, legend_y_bot + (k-1)*rect_h,
       legend_x + 0.03, legend_y_bot + k*rect_h,
       col = leg_cols_M[k], border = NA)
}
rect(legend_x, legend_y_bot, legend_x + 0.03, legend_y_top, border = "black", lwd = 0.5)
text(legend_x + 0.04, legend_y_bot,  sprintf("%.2f", v_M_min), adj = 0, cex = 0.7)
text(legend_x + 0.04, legend_y_top,  sprintf("%.2f", v_M_max), adj = 0, cex = 0.7)

mtext("Smooth (affine in E[V(theta)])", side = 1, line = -1, cex = 0.65)

dev.off()
cat("  Saved.\n\n")

cat("=== Done. Both PDFs written to figures/ ===\n")
