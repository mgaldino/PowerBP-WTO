#!/usr/bin/env Rscript

# Reproducible checks for the 2026-05 coarse-review revision of
# formal_model_v5.Rmd. The script uses the fixed-pie relative-package pi_H = 0
# baseline and writes manuscript-ready tables under tables/.

options(scipen = 999)

required_packages <- c("dplyr", "ggplot2")
missing_packages <- required_packages[
  !vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)
]
if (length(missing_packages) > 0) {
  stop(sprintf(
    "Install required package(s) before running this script: %s",
    paste(missing_packages, collapse = ", ")
  ))
}

repo_root <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
sentinels <- file.path(repo_root, c("formal_model_v5.Rmd", "AGENTS.md"))
if (!all(file.exists(sentinels))) {
  stop("Run this script from the PowerBayesianPersuasion repository root.")
}

tables_dir <- file.path(repo_root, "tables")
dir.create(tables_dir, recursive = TRUE, showWarnings = FALSE)
figures_dir <- file.path(repo_root, "figures")
dir.create(figures_dir, recursive = TRUE, showWarnings = FALSE)

tol <- 1e-10

compute_piH0 <- function(N, beta, t0, t1, o0, o1, ybar = 1,
                         mu_grid = seq(0, 1, length.out = 5001),
                         tol = 1e-10) {
  stopifnot(
    N >= 3,
    beta > 0,
    beta <= 1,
    t0 >= 0,
    t0 < t1,
    t1 <= ybar,
    ybar <= 1,
    all(mu_grid >= 0),
    all(mu_grid <= 1)
  )

  m <- N - 1
  q <- floor(N / 2) + 1
  k <- q - 1
  mu2_star <- (t1 - t0) / (1 - t0)

  p2 <- function(mu) {
    pmax((1 - mu) * (1 - t0), 1 - t1)
  }
  cU <- function(mu) {
    beta * p2(mu) / m
  }
  C0 <- function(mu) {
    ifelse(mu <= mu2_star + tol, o0, o0 + t1 - t0)
  }

  a1 <- t1 - (1 - beta) * o1
  a0_post1 <- t0 - o0 + beta * (o0 + t1 - t0)
  a0_M <- t0 - (1 - beta) * o0
  a1_M <- t1 - (1 - beta) * o1
  c_M <- beta / m

  domains <- list(
    threshold_order = t0 >= -tol && t0 + tol < t1 &&
      t1 <= ybar + tol && ybar <= 1 + tol,
    high_posterior_pooling = mu2_star < 1 - tol,
    r1_dynamic_order = a0_post1 >= -tol && a0_post1 + tol < a1 &&
      a1 <= ybar + tol,
    majority_threshold_order = a0_M >= -tol && a0_M + tol < a1_M &&
      a1_M <= ybar + tol,
    strict_no_cheap_H = a0_M > c_M + tol,
    quota_feasible = q * c_M <= 1 + tol
  )

  mu <- mu_grid
  c_mu <- cU(mu)
  c0 <- cU(0)
  c1 <- cU(1)

  Pi_P <- ifelse(
    a1 + (m - 1) * c_mu <= 1 + tol,
    1 - a1 - (m - 1) * c_mu,
    -Inf
  )
  Pi_L <- if (a0_post1 + (m - 1) * c0 <= 1 + tol &&
              a0_post1 + tol < a1) {
    (1 - mu) * (1 - a0_post1 - (m - 1) * c0) + mu * c1
  } else {
    rep(-Inf, length(mu))
  }
  Pi_D <- c_mu

  H_P <- (1 - mu) * (o0 + a1 - t0) + mu * (o1 + a1 - t1)
  H_L <- (1 - mu) * (o0 + a0_post1 - t0) + mu * beta * o1
  H_D <- (1 - mu) * beta * C0(mu) + mu * beta * o1
  H_M <- (1 - mu) * o0 + mu * o1

  value_matrix <- cbind(Pi_P, Pi_L, Pi_D)
  H_matrix <- cbind(H_P, H_L, H_D)
  candidate_names <- c("pooling", "low_only", "delay")
  selected_index <- vapply(
    seq_along(mu),
    function(i) {
      best <- max(value_matrix[i, ])
      argmax <- which(value_matrix[i, ] >= best - tol)
      argmax[which.min(H_matrix[i, argmax])]
    },
    integer(1)
  )

  weak_total <- cbind(
    pooling = rep(1 - a1, length(mu)),
    low_only = (1 - mu) * (1 - a0_post1) + mu * beta * p2(1),
    delay = beta * p2(mu)
  )

  values <- data.frame(
    mu = mu,
    p2 = p2(mu),
    c_mu = c_mu,
    Pi_P = Pi_P,
    Pi_L = Pi_L,
    Pi_D = Pi_D,
    Delta_P = H_P - H_M,
    Delta_L = H_L - H_M,
    Delta_D = H_D - H_M,
    selected_candidate = candidate_names[selected_index],
    selected_value = value_matrix[cbind(seq_along(mu), selected_index)],
    selected_Delta_H = H_matrix[cbind(seq_along(mu), selected_index)] - H_M,
    selected_weak_entry = weak_total[cbind(seq_along(mu), selected_index)] / m,
    stringsAsFactors = FALSE
  )

  list(
    params = list(N = N, m = m, q = q, k = k, beta = beta, t0 = t0,
                  t1 = t1, o0 = o0, o1 = o1, ybar = ybar),
    domains = domains,
    mu2_star = mu2_star,
    a0_post1 = a0_post1,
    a1 = a1,
    a0_M = a0_M,
    a1_M = a1_M,
    c_M = c_M,
    c0 = c0,
    c1 = c1,
    values = values
  )
}

summarise_regions <- function(values, column = "selected_candidate") {
  runs <- rle(values[[column]])
  ends <- cumsum(runs$lengths)
  starts <- c(1, head(ends, -1) + 1)
  data.frame(
    candidate = runs$values,
    mu_min = values$mu[starts],
    mu_max = values$mu[ends],
    rows = runs$lengths,
    stringsAsFactors = FALSE
  )
}

find_roots <- function(x, y, tol = 1e-10) {
  roots <- numeric(0)
  for (i in seq_len(length(x) - 1)) {
    y0 <- y[i]
    y1 <- y[i + 1]
    if (!is.finite(y0) || !is.finite(y1)) {
      next
    }
    if (abs(y0) <= tol) {
      roots <- c(roots, x[i])
    }
    if (y0 * y1 < 0) {
      roots <- c(roots, uniroot(
        stats::approxfun(x[c(i, i + 1)], y[c(i, i + 1)]),
        interval = x[c(i, i + 1)]
      )$root)
    }
  }
  if (abs(y[length(y)]) <= tol) {
    roots <- c(roots, x[length(x)])
  }
  sort(unique(round(roots, 10)))
}

write_csv <- function(dat, filename) {
  utils::write.csv(dat, file.path(tables_dir, filename), row.names = FALSE)
}

save_plot <- function(plot, filename, width = 6.8, height = 4.4) {
  ggplot2::ggsave(
    file.path(figures_dir, paste0(filename, ".pdf")),
    plot = plot,
    width = width,
    height = height,
    units = "in"
  )
  ggplot2::ggsave(
    file.path(figures_dir, paste0(filename, ".png")),
    plot = plot,
    width = width,
    height = height,
    units = "in",
    dpi = 320,
    bg = "white"
  )
}

main <- compute_piH0(
  N = 13,
  beta = 0.6,
  t0 = 0.35,
  t1 = 0.70,
  o0 = 0.05,
  o1 = 0.05,
  mu_grid = seq(0, 1, length.out = 100001)
)

terminal_grid <- expand.grid(
  mu = seq(0, 1, length.out = 501),
  t1 = seq(main$params$t0 + 0.005, 0.95, length.out = 501)
)
terminal_grid$region <- ifelse(
  terminal_grid$mu <= (terminal_grid$t1 - main$params$t0) /
    (1 - main$params$t0) + tol,
  "Low-only package",
  "Pooling package"
)
terminal_boundary <- data.frame(mu = seq(0, 1, length.out = 501))
terminal_boundary$t1 <- main$params$t0 +
  terminal_boundary$mu * (1 - main$params$t0)
terminal_boundary <- terminal_boundary[terminal_boundary$t1 <= 0.95, ]

terminal_plot <- ggplot2::ggplot(
  terminal_grid,
  ggplot2::aes(x = mu, y = t1, fill = region)
) +
  ggplot2::geom_raster() +
  ggplot2::geom_line(
    data = terminal_boundary,
    ggplot2::aes(x = mu, y = t1),
    inherit.aes = FALSE,
    linewidth = 0.6
  ) +
  ggplot2::annotate(
    "point",
    x = main$mu2_star,
    y = main$params$t1,
    size = 2.1,
    shape = 21,
    fill = "white"
  ) +
  ggplot2::scale_fill_manual(
    values = c("Low-only package" = "#0072B2", "Pooling package" = "#E69F00"),
    name = NULL
  ) +
  ggplot2::scale_x_continuous(name = "Belief that H is high-threshold, mu") +
  ggplot2::scale_y_continuous(name = "High terminal threshold, t1") +
  ggplot2::labs(
    title = "Terminal unanimity regions",
    subtitle = "Boundary: mu2*=(t1-t0)/(1-t0); point marks the worked example"
  ) +
  ggplot2::coord_cartesian(xlim = c(0, 1), ylim = range(terminal_grid$t1), expand = FALSE) +
  ggplot2::theme_minimal(base_size = 11) +
  ggplot2::theme(
    panel.grid.minor = ggplot2::element_blank(),
    legend.position = "bottom",
    plot.title = ggplot2::element_text(face = "bold", size = 12),
    plot.subtitle = ggplot2::element_text(size = 10)
  )
save_plot(terminal_plot, "relative_package_terminal_regions_piH0")

required_domains <- c(
  "threshold_order",
  "high_posterior_pooling",
  "r1_dynamic_order",
  "majority_threshold_order",
  "strict_no_cheap_H",
  "quota_feasible"
)
if (!all(unlist(main$domains[required_domains]))) {
  stop("Main worked example fails a maintained domain condition.")
}

main_regions <- summarise_regions(main$values)
main_region_table <- data.frame(
  candidate = main_regions$candidate,
  mu_min = main_regions$mu_min,
  mu_max = main_regions$mu_max,
  rows = main_regions$rows,
  stringsAsFactors = FALSE
)
write_csv(main_region_table, "relative_package_main_worked_example_piH0.csv")

main_margins <- data.frame(
  object = c(
    "N",
    "m",
    "beta",
    "t0",
    "t1",
    "o0",
    "o1",
    "mu2_star",
    "a0_1",
    "a1",
    "a1_minus_a0_1",
    "a0_M",
    "beta_over_m",
    "no_cheap_H_margin",
    "c0",
    "c1",
    "V_W_M",
    "max_V_W_U",
    "min_entry_gap_M_minus_U",
    "Delta_H_selected_roots"
  ),
  value = c(
    main$params$N,
    main$params$m,
    main$params$beta,
    main$params$t0,
    main$params$t1,
    main$params$o0,
    main$params$o1,
    main$mu2_star,
    main$a0_post1,
    main$a1,
    main$a1 - main$a0_post1,
    main$a0_M,
    main$c_M,
    main$a0_M - main$c_M,
    main$c0,
    main$c1,
    1 / main$params$m,
    max(main$values$selected_weak_entry),
    min(1 / main$params$m - main$values$selected_weak_entry),
    paste(find_roots(main$values$mu, main$values$selected_Delta_H),
          collapse = "; ")
  ),
  stringsAsFactors = FALSE
)
write_csv(main_margins, "relative_package_main_worked_example_margins_piH0.csv")

point_targets <- c(0, 0.25, 0.5, 0.75, 0.95, 1)
point_rows <- vapply(
  point_targets,
  function(target) which.min(abs(main$values$mu - target)),
  integer(1)
)
selected_points <- main$values[point_rows, ]
selected_points <- dplyr::select(
  selected_points,
  mu,
  selected_candidate,
  selected_value,
  selected_weak_entry,
  Delta_P,
  Delta_L,
  Delta_D,
  selected_Delta_H
)
write_csv(selected_points, "relative_package_main_worked_example_points_piH0.csv")

delta_roots <- find_roots(main$values$mu, main$values$selected_Delta_H)
main_delta_root <- if (length(delta_roots) > 0) delta_roots[1] else NA_real_
phase_grid <- expand.grid(
  mu = seq(0, 1, length.out = 1001),
  chi = seq(0, 0.095, length.out = 601)
)
phase_grid$weak_entry <- stats::approx(
  x = main$values$mu,
  y = main$values$selected_weak_entry,
  xout = phase_grid$mu,
  rule = 2
)$y
phase_grid$delta_H <- stats::approx(
  x = main$values$mu,
  y = main$values$selected_Delta_H,
  xout = phase_grid$mu,
  rule = 2
)$y
phase_grid$classification <- ifelse(
  phase_grid$chi > 1 / main$params$m + tol,
  "No institution",
  ifelse(
    phase_grid$chi > phase_grid$weak_entry + tol,
    "Majority only",
    ifelse(
      phase_grid$delta_H > tol,
      "Both: H prefers unanimity",
      "Both: H prefers majority"
    )
  )
)
phase_grid$classification <- factor(
  phase_grid$classification,
  levels = c(
    "Both: H prefers unanimity",
    "Both: H prefers majority",
    "Majority only",
    "No institution"
  )
)
phase_curve <- dplyr::select(
  main$values,
  mu,
  selected_weak_entry
)
phase_summary <- data.frame(
  object = c(
    "majority_entry_boundary",
    "pooling_unanimity_entry_payoff",
    "maximum_unanimity_entry_payoff",
    "low_only_to_pooling_cutoff",
    "Delta_H_zero",
    "unanimity_mu_max_at_chi_0_030",
    "unanimity_mu_max_at_chi_0_035"
  ),
  value = c(
    1 / main$params$m,
    (1 - main$a1) / main$params$m,
    max(main$values$selected_weak_entry),
    main_region_table$mu_max[main_region_table$candidate == "low_only"][1],
    main_delta_root,
    max(main$values$mu[
      main$values$selected_weak_entry >= 0.030 - tol &
        main$values$selected_candidate == "low_only"
    ]),
    max(main$values$mu[
      main$values$selected_weak_entry >= 0.035 - tol &
        main$values$selected_candidate == "low_only"
    ])
  ),
  stringsAsFactors = FALSE
)
write_csv(phase_summary, "relative_package_phase_diagram_summary_piH0.csv")

phase_plot <- ggplot2::ggplot(
  phase_grid,
  ggplot2::aes(x = mu, y = chi, fill = classification)
) +
  ggplot2::geom_raster() +
  ggplot2::geom_line(
    data = phase_curve,
    ggplot2::aes(x = mu, y = selected_weak_entry),
    inherit.aes = FALSE,
    linewidth = 0.7,
    color = "black"
  ) +
  ggplot2::geom_hline(
    yintercept = 1 / main$params$m,
    linewidth = 0.6,
    linetype = "dashed",
    color = "black"
  ) +
  ggplot2::geom_vline(
    xintercept = main_delta_root,
    linewidth = 0.6,
    linetype = "dotted",
    color = "black"
  ) +
  ggplot2::scale_fill_manual(
    values = c(
      "Both: H prefers unanimity" = "#1B9E77",
      "Both: H prefers majority" = "#7570B3",
      "Majority only" = "#E6AB02",
      "No institution" = "#BDBDBD"
    ),
    name = NULL
  ) +
  ggplot2::scale_x_continuous(
    name = "Prior belief, mu",
    expand = c(0, 0)
  ) +
  ggplot2::scale_y_continuous(
    name = "Entry cost, chi",
    expand = c(0, 0)
  ) +
  ggplot2::coord_cartesian(xlim = c(0, 1), ylim = c(0, 0.095), expand = FALSE) +
  ggplot2::theme_minimal(base_size = 11) +
  ggplot2::guides(fill = ggplot2::guide_legend(nrow = 2, byrow = TRUE)) +
  ggplot2::theme(
    panel.grid.minor = ggplot2::element_blank(),
    legend.position = "bottom",
    legend.box = "vertical",
    plot.margin = ggplot2::margin(5.5, 12, 5.5, 5.5)
  )
save_plot(
  phase_plot,
  "relative_package_institutional_phase_diagram_piH0",
  width = 7.1,
  height = 4.6
)

complete_info_rows <- lapply(
  list(low = c(t = main$params$t0, o = main$params$o0),
       high = c(t = main$params$t1, o = main$params$o1)),
  function(par) {
    t <- unname(par["t"])
    o <- unname(par["o"])
    a <- t - (1 - main$params$beta) * o
    c_theta <- main$params$beta * (1 - t) / main$params$m
    accept_value <- 1 - a - (main$params$m - 1) * c_theta
    delay_value <- c_theta
    data.frame(
      known_type = names(par["t"]),
      t = t,
      o = o,
      a = a,
      continuation_payment = c_theta,
      accept_value = accept_value,
      delay_value = delay_value,
      selected = ifelse(accept_value >= delay_value, "complete_info_accept", "delay"),
      Delta_H = -(1 - main$params$beta) * o,
      stringsAsFactors = FALSE
    )
  }
)
complete_info <- do.call(rbind, complete_info_rows)
complete_info$known_type <- c("low", "high")
complete_info <- dplyr::select(
  complete_info,
  known_type,
  t,
  o,
  a,
  continuation_payment,
  accept_value,
  delay_value,
  selected,
  Delta_H
)
write_csv(complete_info, "relative_package_complete_info_benchmark_piH0.csv")

one_shot <- data.frame(
  candidate = c("low_only", "pooling", "rejection"),
  selected_beliefs = c(
    "mu <= (t1 - t0) / (1 - t0)",
    "mu > (t1 - t0) / (1 - t0)",
    "never strictly selected when t1 < 1; boundary tie possible at t1 = 1, mu = 1"
  ),
  weak_proposer_value = c("(1 - mu)(1 - t0)", "1 - t1", "0"),
  Delta_H = c("0", "(1 - mu)(t1 - t0)", "0"),
  interpretation = c(
    "Testing survives without Round 2.",
    "Pooling survives and gives the low type an informational rent.",
    "Endogenous no-information delay requires valued continuation."
  ),
  stringsAsFactors = FALSE
)
one_shot <- dplyr::select(
  one_shot,
  candidate,
  selected_beliefs,
  weak_proposer_value,
  Delta_H,
  interpretation
)
write_csv(one_shot, "relative_package_one_shot_bridge_piH0.csv")

delay_example_case <- compute_piH0(
  N = 13,
  beta = 0.9,
  t0 = 0.10,
  t1 = 0.50,
  o0 = 0.10,
  o1 = 0.50,
  mu_grid = seq(0, 1, length.out = 100001)
)
delay_targets <- c(0.01, 0.35, 0.75)
delay_rows <- vapply(
  delay_targets,
  function(target) which.min(abs(delay_example_case$values$mu - target)),
  integer(1)
)
delay_example <- delay_example_case$values[delay_rows, ]
delay_example <- data.frame(
  mu = delay_example$mu,
  beta = delay_example_case$params$beta,
  t0 = delay_example_case$params$t0,
  t1 = delay_example_case$params$t1,
  o0 = delay_example_case$params$o0,
  o1 = delay_example_case$params$o1,
  a0_post1 = delay_example_case$a0_post1,
  a1 = delay_example_case$a1,
  Pi_P = delay_example$Pi_P,
  Pi_L = delay_example$Pi_L,
  Pi_D = delay_example$Pi_D,
  selected = delay_example$selected_candidate,
  stringsAsFactors = FALSE
)
delay_example <- dplyr::select(
  delay_example,
  mu,
  beta,
  t0,
  t1,
  o0,
  o1,
  a0_post1,
  a1,
  Pi_P,
  Pi_L,
  Pi_D,
  selected
)
write_csv(delay_example, "relative_package_delay_example_piH0.csv")

sweep_grid <- expand.grid(
  beta = seq(0.45, 0.90, by = 0.05),
  t0 = seq(0.10, 0.40, by = 0.05),
  gap = seq(0.08, 0.35, by = 0.03),
  o = seq(0.00, 0.30, by = 0.05)
)

sweep_rows <- vector("list", nrow(sweep_grid))
row_id <- 1
for (i in seq_len(nrow(sweep_grid))) {
  beta <- sweep_grid$beta[i]
  t0 <- sweep_grid$t0[i]
  t1 <- t0 + sweep_grid$gap[i]
  o <- sweep_grid$o[i]
  if (t1 >= 1) {
    next
  }
  obj <- try(
    compute_piH0(
      N = 13,
      beta = beta,
      t0 = t0,
      t1 = t1,
      o0 = o,
      o1 = o,
      mu_grid = seq(0, 1, length.out = 1001)
    ),
    silent = TRUE
  )
  if (inherits(obj, "try-error")) {
    next
  }
  valid <- all(unlist(obj$domains[required_domains]))
  if (!valid) {
    next
  }
  candidates <- sort(unique(obj$values$selected_candidate))
  pattern <- paste(candidates, collapse = "+")
  if (identical(candidates, "pooling")) {
    pattern <- "pooling_only"
  } else if (identical(candidates, c("low_only", "pooling"))) {
    pattern <- "low_only_plus_pooling"
  } else if (identical(candidates, c("delay", "pooling"))) {
    pattern <- "delay_plus_pooling"
  } else if (identical(candidates, c("delay", "low_only", "pooling"))) {
    pattern <- "all_three"
  }
  sweep_rows[[row_id]] <- data.frame(
    beta = beta,
    t0 = t0,
    t1 = t1,
    o = o,
    mu2_star = obj$mu2_star,
    a0_1 = obj$a0_post1,
    a1 = obj$a1,
    no_cheap_H_margin = obj$a0_M - obj$c_M,
    candidate_pattern = pattern,
    any_H_prefers_U = any(obj$values$selected_Delta_H > tol),
    interior_Delta_crossing = min(obj$values$selected_Delta_H) < -tol &&
      max(obj$values$selected_Delta_H) > tol,
    mu_share_H_prefers_U = mean(obj$values$selected_Delta_H > tol),
    max_V_W_U = max(obj$values$selected_weak_entry),
    min_entry_gap_M_minus_U = min(1 / obj$params$m - obj$values$selected_weak_entry),
    stringsAsFactors = FALSE
  )
  row_id <- row_id + 1
}
sweep <- do.call(rbind, sweep_rows[seq_len(row_id - 1)])
sweep <- dplyr::select(
  sweep,
  beta,
  t0,
  t1,
  o,
  mu2_star,
  a0_1,
  a1,
  no_cheap_H_margin,
  candidate_pattern,
  any_H_prefers_U,
  interior_Delta_crossing,
  mu_share_H_prefers_U,
  max_V_W_U,
  min_entry_gap_M_minus_U
)
write_csv(sweep, "relative_package_region_sweep_piH0.csv")

summary_by_pattern <- dplyr::summarise(
  dplyr::group_by(sweep, candidate_pattern),
  parameter_vectors = dplyr::n(),
  percent_valid_grid = 100 * dplyr::n() / nrow(sweep),
  share_with_H_prefers_U_somewhere = mean(any_H_prefers_U),
  share_with_interior_Delta_crossing = mean(interior_Delta_crossing),
  median_mu_share_H_prefers_U = stats::median(mu_share_H_prefers_U),
  min_no_cheap_H_margin = min(no_cheap_H_margin),
  .groups = "drop"
)
summary_by_pattern <- dplyr::arrange(
  summary_by_pattern,
  dplyr::desc(parameter_vectors)
)
summary_by_pattern <- dplyr::select(
  summary_by_pattern,
  candidate_pattern,
  parameter_vectors,
  percent_valid_grid,
  share_with_H_prefers_U_somewhere,
  share_with_interior_Delta_crossing,
  median_mu_share_H_prefers_U,
  min_no_cheap_H_margin
)
write_csv(summary_by_pattern, "relative_package_region_sweep_summary_piH0.csv")

cat("Wrote coarse-review revision tables:\n")
cat(" - tables/relative_package_main_worked_example_piH0.csv\n")
cat(" - tables/relative_package_main_worked_example_margins_piH0.csv\n")
cat(" - tables/relative_package_main_worked_example_points_piH0.csv\n")
cat(" - tables/relative_package_phase_diagram_summary_piH0.csv\n")
cat(" - tables/relative_package_complete_info_benchmark_piH0.csv\n")
cat(" - tables/relative_package_one_shot_bridge_piH0.csv\n")
cat(" - tables/relative_package_delay_example_piH0.csv\n")
cat(" - tables/relative_package_region_sweep_piH0.csv\n")
cat(" - tables/relative_package_region_sweep_summary_piH0.csv\n")
cat(" - figures/relative_package_institutional_phase_diagram_piH0.pdf\n")
