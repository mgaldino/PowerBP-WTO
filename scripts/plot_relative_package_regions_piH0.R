#!/usr/bin/env Rscript

# Generates publication figures for the fixed-pie relative-package pi_H = 0
# baseline. The numerical objects are deterministic and use the same formulas
# as the verification scripts.

options(scipen = 999)
set.seed(20260515)

required_packages <- c("ggplot2")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages) > 0) {
  stop(sprintf(
    "Install required package(s) before running this script: %s",
    paste(missing_packages, collapse = ", ")
  ))
}

if (requireNamespace("here", quietly = TRUE)) {
  repo_root <- here::here()
} else {
  repo_root <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
}

project_sentinels <- file.path(
  repo_root,
  c("formal_model_v5.Rmd", "scripts/verify_relative_package_R1_piH0.R")
)
if (!all(file.exists(project_sentinels))) {
  stop("Script must be run from the PowerBayesianPersuasion repository root or a here::here()-recognized subdirectory.")
}

fig_dir <- file.path(repo_root, "figures")
dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)

library(ggplot2)

tol <- 1e-10

pars <- list(
  N = 13,
  m = 12,
  beta = 0.9,
  t0 = 0.19,
  t1 = 0.285,
  o0 = 0.19,
  o1 = 0.285,
  ybar = 1
)

stopifnot(
  pars$N >= 3,
  pars$m == pars$N - 1,
  pars$beta > 0,
  pars$beta <= 1,
  pars$t0 >= 0,
  pars$t0 < pars$t1,
  pars$t1 <= pars$ybar,
  pars$ybar <= 1
)

mu2_star <- (pars$t1 - pars$t0) / (1 - pars$t0)
p2 <- function(mu) pmax((1 - mu) * (1 - pars$t0), 1 - pars$t1)
c_u <- function(mu) pars$beta * p2(mu) / pars$m
a1 <- pars$t1 - (1 - pars$beta) * pars$o1
a0_1 <- pars$t0 - pars$o0 + pars$beta * (pars$o0 + pars$t1 - pars$t0)
w_u_entry <- (1 - a1) / pars$m
w_m_entry <- 1 / pars$m
delta_h <- function(mu) a1 - ((1 - mu) * pars$o0 + mu * pars$o1)
mu_h_indiff <- uniroot(delta_h, interval = c(0, 1))$root

stopifnot(
  mu2_star > 0,
  mu2_star < 1,
  abs(a1 - 0.2565) <= 1e-12,
  abs(a0_1 - 0.2565) <= 1e-12,
  abs(w_u_entry - 0.0619583333333333) <= 1e-12,
  abs(w_m_entry - 0.0833333333333333) <= 1e-12,
  abs(mu_h_indiff - 0.7) <= 1e-10
)

palette_regions <- c(
  "Low-only package" = "#0072B2",
  "Pooling package" = "#E69F00",
  "Pooling P" = "#0072B2",
  "Low-only L" = "#009E73",
  "Rejection R" = "#D55E00",
  "Both: H prefers U" = "#0072B2",
  "Both: H prefers M" = "#D55E00",
  "Both: tie" = "#000000",
  "Only M forms" = "#999999",
  "No formation" = "#F0E442"
)

theme_paper <- function() {
  theme_minimal(base_size = 11) +
    theme(
      panel.grid.minor = element_blank(),
      legend.position = "bottom",
      legend.title = element_blank(),
      plot.title = element_text(face = "bold", size = 12),
      plot.subtitle = element_text(size = 10),
      axis.title = element_text(size = 10),
      axis.text = element_text(size = 9),
      plot.margin = margin(6, 14, 6, 6)
    )
}

save_plot <- function(plot, stem, width = 6.8, height = 4.4) {
  pdf_path <- file.path(fig_dir, paste0(stem, ".pdf"))
  png_path <- file.path(fig_dir, paste0(stem, ".png"))
  ggsave(pdf_path, plot = plot, width = width, height = height, units = "in")
  ggsave(png_path, plot = plot, width = width, height = height, units = "in", dpi = 320, bg = "white")
  invisible(c(pdf = pdf_path, png = png_path))
}

mu_grid <- seq(0, 1, length.out = 501)

baseline_check_grid <- seq(0, 1, length.out = 5001)
baseline_pi_p <- 1 - a1 - (pars$m - 1) * c_u(baseline_check_grid)
baseline_pi_r <- c_u(baseline_check_grid)
stopifnot(
  abs(a1 - a0_1) <= tol,
  all(baseline_pi_p + tol >= baseline_pi_r)
)

terminal_grid <- expand.grid(
  mu = mu_grid,
  t1 = seq(pars$t0 + 0.005, 0.7, length.out = 401)
)
terminal_grid$region <- ifelse(
  terminal_grid$mu <= (terminal_grid$t1 - pars$t0) / (1 - pars$t0) + tol,
  "Low-only package",
  "Pooling package"
)
terminal_boundary <- data.frame(
  mu = mu_grid,
  t1 = pars$t0 + mu_grid * (1 - pars$t0)
)
terminal_boundary <- terminal_boundary[terminal_boundary$t1 <= max(terminal_grid$t1), ]

terminal_plot <- ggplot(terminal_grid, aes(x = mu, y = t1, fill = region)) +
  geom_raster() +
  geom_line(data = terminal_boundary, aes(x = mu, y = t1), inherit.aes = FALSE, linewidth = 0.6) +
  annotate("point", x = mu2_star, y = pars$t1, size = 2.1, shape = 21, fill = "white") +
  scale_fill_manual(values = palette_regions[c("Low-only package", "Pooling package")]) +
  scale_x_continuous(name = expression("Belief that " * H * " is high-threshold, " * mu)) +
  scale_y_continuous(name = expression("High terminal threshold, " * t[1])) +
  labs(
    title = "Terminal unanimity regions",
    subtitle = expression("Boundary: " * mu[2]^"*" * "=(t"[1] * "-t"[0] * ")/(1-t"[0] * "); point marks the working calibration")
  ) +
  coord_cartesian(xlim = c(0, 1), ylim = range(terminal_grid$t1), expand = FALSE) +
  theme_paper()

r1_gap <- 0.04
r1_mu_grid <- seq(0, 0.9995, length.out = 1201)
r1_grid <- expand.grid(
  mu = r1_mu_grid,
  a1 = seq(0.22, 0.48, length.out = 901)
)
r1_grid$a0_1 <- r1_grid$a1 - r1_gap
r1_grid$c_mu <- c_u(r1_grid$mu)
r1_grid$c0 <- c_u(0)
r1_grid$c1 <- c_u(1)
r1_grid$pooling_feasible <- r1_grid$a1 + (pars$m - 1) * r1_grid$c_mu <= 1 + tol
r1_grid$low_only_feasible <- r1_grid$a0_1 + (pars$m - 1) * r1_grid$c0 <= 1 + tol &
  r1_grid$a0_1 + tol < r1_grid$a1
r1_grid$pi_p <- ifelse(
  r1_grid$pooling_feasible,
  1 - r1_grid$a1 - (pars$m - 1) * r1_grid$c_mu,
  -Inf
)
r1_grid$pi_l <- ifelse(
  r1_grid$low_only_feasible,
  (1 - r1_grid$mu) * (1 - r1_grid$a0_1 - (pars$m - 1) * r1_grid$c0) +
    r1_grid$mu * r1_grid$c1,
  -Inf
)
r1_grid$pi_r <- r1_grid$c_mu
r1_C0 <- function(mu) ifelse(mu <= mu2_star + tol, pars$o0, pars$o0 + pars$t1 - pars$t0)
r1_grid$H_p <- (1 - r1_grid$mu) * (pars$o0 + r1_grid$a1 - pars$t0) +
  r1_grid$mu * (pars$o1 + r1_grid$a1 - pars$t1)
r1_grid$H_l <- (1 - r1_grid$mu) * (pars$o0 + r1_grid$a0_1 - pars$t0) +
  r1_grid$mu * pars$beta * pars$o1
r1_grid$H_r <- (1 - r1_grid$mu) * pars$beta * r1_C0(r1_grid$mu) +
  r1_grid$mu * pars$beta * pars$o1

r1_values <- cbind(r1_grid$pi_p, r1_grid$pi_l, r1_grid$pi_r)
r1_H_values <- cbind(r1_grid$H_p, r1_grid$H_l, r1_grid$H_r)
r1_names <- c("Pooling P", "Low-only L", "Rejection R")
r1_selected_index <- vapply(
  seq_len(nrow(r1_values)),
  function(i) {
    best <- max(r1_values[i, ])
    argmax <- which(r1_values[i, ] >= best - tol)
    argmax[which.min(r1_H_values[i, argmax])]
  },
  integer(1)
)
r1_grid$selected <- r1_names[r1_selected_index]

stopifnot(all(c("Pooling P", "Low-only L", "Rejection R") %in% unique(r1_grid$selected)))

r1_boundary_mu <- r1_mu_grid[r1_mu_grid < 0.999]
r1_boundary_c <- c_u(r1_boundary_mu)
boundary_pr <- data.frame(
  mu = r1_boundary_mu,
  a1 = 1 - pars$m * r1_boundary_c,
  boundary = "P=R"
)
boundary_pr <- boundary_pr[
  boundary_pr$a1 + (pars$m - 1) * c_u(boundary_pr$mu) <= 1 + tol,
]

boundary_lr <- data.frame(
  mu = r1_boundary_mu,
  a1 = 1 + r1_gap - (pars$m - 1) * c_u(0) -
    (r1_boundary_c - r1_boundary_mu * c_u(1)) / (1 - r1_boundary_mu),
  boundary = "L=R"
)
boundary_lr$a0_1 <- boundary_lr$a1 - r1_gap
boundary_lr <- boundary_lr[
  boundary_lr$a0_1 + (pars$m - 1) * c_u(0) <= 1 + tol &
    boundary_lr$a0_1 + tol < boundary_lr$a1,
  c("mu", "a1", "boundary")
]

boundary_pl_mu <- r1_boundary_mu[r1_boundary_mu > 0.001]
boundary_pl <- data.frame(
  mu = boundary_pl_mu,
  a1 = (
    1 -
      (1 - boundary_pl_mu) *
        (1 + r1_gap - (pars$m - 1) * c_u(0)) -
      (pars$m - 1) * c_u(boundary_pl_mu) -
      boundary_pl_mu * c_u(1)
  ) / boundary_pl_mu,
  boundary = "P=L"
)
boundary_pl$a0_1 <- boundary_pl$a1 - r1_gap
boundary_pl <- boundary_pl[
  boundary_pl$a1 + (pars$m - 1) * c_u(boundary_pl$mu) <= 1 + tol &
    boundary_pl$a0_1 + (pars$m - 1) * c_u(0) <= 1 + tol &
    boundary_pl$a0_1 + tol < boundary_pl$a1,
  c("mu", "a1", "boundary")
]

r1_boundary_data <- rbind(
  boundary_pr[, c("mu", "a1", "boundary")],
  boundary_lr,
  boundary_pl
)
r1_boundary_data <- r1_boundary_data[
  is.finite(r1_boundary_data$a1) &
    r1_boundary_data$a1 >= min(r1_grid$a1) &
    r1_boundary_data$a1 <= max(r1_grid$a1),
]

r1_plot <- ggplot(r1_grid, aes(x = mu, y = a1, fill = selected)) +
  geom_raster() +
  geom_line(data = r1_boundary_data, aes(x = mu, y = a1, group = boundary),
            inherit.aes = FALSE, color = "white", linewidth = 0.45) +
  annotate("label", x = 0.045, y = 0.27, label = "L", size = 4.2, fill = "white") +
  annotate("label", x = 0.62, y = 0.285, label = "P", size = 4.2, fill = "white") +
  annotate("label", x = 0.56, y = 0.43, label = "R", size = 4.2, fill = "white") +
  scale_fill_manual(values = palette_regions[c("Pooling P", "Low-only L", "Rejection R")]) +
  scale_x_continuous(name = expression("Belief that " * H * " is high-threshold, " * mu)) +
  scale_y_continuous(name = expression("Pooling dynamic threshold, " * a[1])) +
  labs(
    title = "Round-1 candidate regions under unanimity",
    subtitle = expression("Display slice with strict dynamic gap " * a[1] - a[0]^1 == 0.04)
  ) +
  coord_cartesian(xlim = c(0, 1), ylim = range(r1_grid$a1), expand = FALSE) +
  theme_paper()

classification_grid <- expand.grid(
  mu = mu_grid,
  chi = seq(0, 0.1, length.out = 401)
)
classification_grid$delta_h <- delta_h(classification_grid$mu)
classification_grid$category <- ifelse(
  classification_grid$chi > w_m_entry + tol,
  "No formation",
  ifelse(
    classification_grid$chi > w_u_entry + tol,
    "Only M forms",
    ifelse(
      classification_grid$delta_h > tol,
      "Both: H prefers U",
      ifelse(
        classification_grid$delta_h < -tol,
        "Both: H prefers M",
        "Both: tie"
      )
    )
  )
)

classification_plot <- ggplot(classification_grid, aes(x = mu, y = chi, fill = category)) +
  geom_raster() +
  geom_hline(yintercept = w_u_entry, linewidth = 0.45) +
  geom_hline(yintercept = w_m_entry, linewidth = 0.45) +
  geom_vline(xintercept = mu_h_indiff, linewidth = 0.45, linetype = "dashed") +
  scale_fill_manual(values = palette_regions[c(
    "Both: H prefers U",
    "Both: H prefers M",
    "Both: tie",
    "Only M forms",
    "No formation"
  )], guide = "none") +
  annotate("label", x = 0.34, y = 0.031, label = "Both form\nH prefers U", size = 3.4, fill = "white") +
  annotate("label", x = 0.85, y = 0.031, label = "Both form\nH prefers M", size = 3.4, fill = "white") +
  annotate("label", x = 0.50, y = 0.073, label = "Only M forms", size = 3.4, fill = "white") +
  annotate("label", x = 0.50, y = 0.092, label = "No formation", size = 3.4, fill = "white") +
  scale_x_continuous(
    name = expression("Belief that " * H * " is high-threshold, " * mu),
    breaks = c(0, 0.25, 0.5, 0.75, 1)
  ) +
  scale_y_continuous(name = expression("Entry cost per weak state, " * chi)) +
  labs(
    title = "Entry and institutional classification",
    subtitle = expression("Horizontal lines: " * V[W]^U * " and " * V[W]^M * "; dashed line: " * Delta[H](mu)==0)
  ) +
  coord_cartesian(xlim = c(-0.015, 1.015), ylim = c(0, 0.1), expand = FALSE, clip = "off") +
  theme_paper()

delta_data <- data.frame(mu = mu_grid)
delta_data$Delta_H <- delta_h(delta_data$mu)
delta_plot <- ggplot(delta_data, aes(x = mu, y = Delta_H)) +
  geom_hline(yintercept = 0, linewidth = 0.45, color = "grey35") +
  geom_vline(xintercept = mu_h_indiff, linewidth = 0.45, linetype = "dashed", color = "grey35") +
  geom_line(color = "#0072B2", linewidth = 0.9) +
  geom_point(data = data.frame(mu = mu_h_indiff, Delta_H = 0), size = 2, color = "#D55E00") +
  scale_x_continuous(name = expression("Belief that " * H * " is high-threshold, " * mu)) +
  scale_y_continuous(name = expression(Delta[H](mu))) +
  labs(
    title = "Conditional payoff gap for the hegemon",
    subtitle = expression(Delta[H](mu) == 0.0665 - 0.095 * mu)
  ) +
  theme_paper()

outputs <- c(
  save_plot(terminal_plot, "relative_package_terminal_regions_piH0"),
  save_plot(r1_plot, "relative_package_R1_candidate_regions_piH0"),
  save_plot(classification_plot, "relative_package_classification_piH0"),
  save_plot(delta_plot, "relative_package_deltaH_piH0")
)

summary_table <- data.frame(
  object = c(
    "terminal_cutoff_mu2_star",
    "R1_display_gap",
    "baseline_a1",
    "baseline_a0_1",
    "weak_entry_unanimity",
    "weak_entry_majority",
    "H_indifference_mu"
  ),
  value = c(mu2_star, r1_gap, a1, a0_1, w_u_entry, w_m_entry, mu_h_indiff)
)
summary_path <- file.path(fig_dir, "relative_package_region_summary_piH0.csv")
write.csv(summary_table, summary_path, row.names = FALSE)

cat("Generated relative-package pi_H = 0 region figures:\n")
cat(paste(outputs, collapse = "\n"))
cat("\n")
cat(sprintf("Summary table: %s\n", summary_path))
