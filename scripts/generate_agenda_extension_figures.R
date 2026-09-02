#!/usr/bin/env Rscript

# Reproducible reader-facing figures for the hegemonic-agenda extension.

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_argument) != 1L) {
  stop("Could not resolve the figure-generator path.", call. = FALSE)
}
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
if (length(commandArgs(trailingOnly = TRUE)) > 0L) {
  stop("This figure generator accepts no command-line arguments.", call. = FALSE)
}

if (!requireNamespace("ggplot2", quietly = TRUE)) {
  stop("The ggplot2 package is required.", call. = FALSE)
}

options(encoding = "UTF-8")
output_directory <- file.path(repository_root, "figures", "agenda_extension")
dir.create(output_directory, recursive = TRUE, showWarnings = FALSE)

portable_pdf <- function(filename, width, height, ...) {
  grDevices::pdf(
    file = filename,
    width = width,
    height = height,
    family = "Helvetica",
    useDingbats = FALSE,
    onefile = FALSE,
    bg = "white"
  )
}

agenda_theme <- function(base_size = 11) {
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(colour = "#E3E7EA", linewidth = 0.30),
      axis.title = ggplot2::element_text(colour = "#1D2630"),
      axis.text = ggplot2::element_text(colour = "#36434D"),
      plot.title = ggplot2::element_text(face = "bold", colour = "#1D2630"),
      plot.subtitle = ggplot2::element_text(colour = "#46515C"),
      legend.position = "none",
      plot.margin = ggplot2::margin(10, 14, 10, 10)
    )
}

save_bundle <- function(prefix, plot, data, width, height) {
  pdf_path <- file.path(output_directory, paste0(prefix, ".pdf"))
  png_path <- file.path(output_directory, paste0(prefix, ".png"))
  csv_path <- file.path(output_directory, paste0(prefix, "_data.csv"))
  ggplot2::ggsave(
    filename = pdf_path,
    plot = plot,
    width = width,
    height = height,
    units = "in",
    device = portable_pdf
  )
  ggplot2::ggsave(
    filename = png_path,
    plot = plot,
    width = width,
    height = height,
    units = "in",
    dpi = 320,
    bg = "white"
  )
  utils::write.csv(data, csv_path, row.names = FALSE, fileEncoding = "UTF-8")
  data.frame(
    figure = prefix,
    pdf = file.path("figures", "agenda_extension", basename(pdf_path)),
    png = file.path("figures", "agenda_extension", basename(png_path)),
    csv = file.path("figures", "agenda_extension", basename(csv_path)),
    width_in = width,
    height_in = height,
    stringsAsFactors = FALSE
  )
}

m <- 4L
k <- floor((m + 1L) / 2)
e <- m - k
beta <- 0.90
inclusion_cutoff <- 1 / m
zero_cutoff <- e / (m * beta)
delay_cutoff <- 1 / beta - k / m
if (!(k + e == m && inclusion_cutoff < zero_cutoff &&
      zero_cutoff < delay_cutoff && delay_cutoff < 1)) {
  stop("The public-gap thresholds are not ordered as required.", call. = FALSE)
}
if (abs(beta * (beta * zero_cutoff - e / m)) > 1e-12) {
  stop("The public-gap zero crossing failed its algebraic check.", call. = FALSE)
}
gap_at_delay_from_left <- beta * (beta * delay_cutoff - e / m)
gap_at_delay_from_right <- (1 - beta) * (1 - beta * delay_cutoff)
if (abs(gap_at_delay_from_left - gap_at_delay_from_right) > 1e-12) {
  stop("The public-gap branches do not meet at the delay cutoff.", call. = FALSE)
}

gap_branch_1 <- data.frame(
  o = seq(0, inclusion_cutoff, length.out = 251L),
  branch = "H included under majority"
)
gap_branch_1$gap <- -beta * (e / m) * (1 - beta * gap_branch_1$o)

gap_branch_2 <- data.frame(
  o = seq(inclusion_cutoff + 1e-5, min(delay_cutoff, 1), length.out = 361L),
  branch = "H excluded; majority agreement"
)
gap_branch_2$gap <- beta * (beta * gap_branch_2$o - e / m)

gap_branch_3 <- data.frame(
  o = seq(delay_cutoff, 1, length.out = 251L),
  branch = "Majority delay"
)
gap_branch_3$gap <- (1 - beta) * (1 - beta * gap_branch_3$o)

gap_data <- rbind(gap_branch_1, gap_branch_2, gap_branch_3)
gap_points <- data.frame(
  o = c(inclusion_cutoff, inclusion_cutoff),
  gap = c(
    -beta * (e / m) * (1 - beta * inclusion_cutoff),
    beta * (beta * inclusion_cutoff - e / m)
  ),
  endpoint = c("Equality value", "Right-hand limit")
)

gap_plot <- ggplot2::ggplot(
  gap_data,
  ggplot2::aes(x = o, y = gap, group = branch)
) +
  ggplot2::geom_hline(yintercept = 0, linewidth = 0.45, colour = "#525A61") +
  ggplot2::geom_vline(
    xintercept = c(inclusion_cutoff, zero_cutoff, delay_cutoff),
    linetype = c("dashed", "dotted", "dotdash"),
    linewidth = 0.45,
    colour = "#68727A"
  ) +
  ggplot2::geom_line(linewidth = 1.05, colour = "#0072B2") +
  ggplot2::geom_point(
    data = gap_points[gap_points$endpoint == "Equality value", , drop = FALSE],
    inherit.aes = FALSE,
    ggplot2::aes(x = o, y = gap),
    shape = 16,
    size = 2.8,
    colour = "#0072B2"
  ) +
  ggplot2::geom_point(
    data = gap_points[gap_points$endpoint == "Right-hand limit", , drop = FALSE],
    inherit.aes = FALSE,
    ggplot2::aes(x = o, y = gap),
    shape = 21,
    size = 3.0,
    stroke = 0.9,
    fill = "white",
    colour = "#0072B2"
  ) +
  ggplot2::annotate(
    "text",
    x = 0.80,
    y = 0.055,
    label = "Unanimity advantage",
    colour = "#005A8D",
    size = 3.4
  ) +
  ggplot2::annotate(
    "text",
    x = 0.11,
    y = -0.43,
    label = "Majority advantage",
    colour = "#005A8D",
    size = 3.4
  ) +
  ggplot2::annotate(
    "text",
    x = delay_cutoff + 0.012,
    y = -0.055,
    label = "o[M]^'*'",
    parse = TRUE,
    hjust = 0,
    colour = "#46515C",
    size = 3.4
  ) +
  ggplot2::scale_x_continuous(
    limits = c(0, 1),
    breaks = c(0, inclusion_cutoff, zero_cutoff, 1),
    labels = c("0", "1/m", "e/(m beta)", "1"),
    expand = ggplot2::expansion(mult = c(0, 0.015))
  ) +
  ggplot2::scale_y_continuous(
    breaks = seq(-0.4, 0.1, by = 0.1),
    expand = ggplot2::expansion(mult = c(0.04, 0.08))
  ) +
  ggplot2::labs(
    title = "The public institutional gap changes sign",
    subtitle = "Unanimity minus majority, m = 4, beta = 0.90, k = e = 2",
    x = "Hegemon's disagreement payoff, o",
    y = "Public payoff gap, Delta v^A(o)"
  ) +
  agenda_theme()

ell <- 0.10
h <- 0.35
p_star <- (h - ell) / (1 - ell)
low_family_exists <- (1 - beta + beta^2 * ell) >= beta^2 * h
if (!(p_star > 0 && p_star < 1) || low_family_exists) {
  stop("The existence-map parameterization does not match the documented case.", call. = FALSE)
}

existence_rectangles <- data.frame(
  xmin = c(0, p_star),
  xmax = c(p_star, 1),
  ymin = c(0, p_star),
  ymax = c(1, 1),
  status = c("No pure-strategy PBE", "PBE exists")
)
low_right_rectangle <- data.frame(
  xmin = p_star,
  xmax = 1,
  ymin = 0,
  ymax = p_star,
  status = "No pure-strategy PBE"
)
existence_areas <- rbind(existence_rectangles, low_right_rectangle)
existence_boundaries <- data.frame(
  boundary = c("prior cutoff", "off-path cutoff", "zero-posterior family"),
  value = c(p_star, p_star, 0),
  orientation = c("vertical", "horizontal", "horizontal"),
  stringsAsFactors = FALSE
)
existence_data <- rbind(
  transform(existence_areas, object = "area"),
  data.frame(
    xmin = c(0, 1), xmax = c(0, 1), ymin = c(0, 1), ymax = c(0, 1),
    status = "PBE exists", object = "support-preserving endpoint"
  )
)
existence_data$low_family_payoff_condition <- low_family_exists
existence_data$p_star <- p_star

existence_plot <- ggplot2::ggplot() +
  ggplot2::geom_rect(
    data = existence_areas,
    ggplot2::aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = status),
    colour = "white",
    linewidth = 0.25
  ) +
  ggplot2::geom_vline(
    xintercept = p_star,
    linetype = "dashed",
    linewidth = 0.55,
    colour = "#36434D"
  ) +
  ggplot2::geom_hline(
    yintercept = p_star,
    linetype = "dashed",
    linewidth = 0.55,
    colour = "#36434D"
  ) +
  ggplot2::geom_segment(
    ggplot2::aes(x = p_star, xend = 1, y = 0, yend = 0),
    linewidth = 2.2,
    colour = "#0072B2"
  ) +
  ggplot2::geom_point(
    data = data.frame(p = c(0, 1), mu_off = c(0, 1)),
    ggplot2::aes(x = p, y = mu_off),
    shape = 21,
    size = 3.2,
    stroke = 0.8,
    fill = "#0072B2",
    colour = "white"
  ) +
  ggplot2::annotate(
    "text", x = 0.64, y = 0.70, label = "PBE exists",
    colour = "white", fontface = "bold", size = 4
  ) +
  ggplot2::annotate(
    "text", x = 0.14, y = 0.52, label = "No pure-strategy\nPBE",
    colour = "#46515C", size = 3.6
  ) +
  ggplot2::annotate(
    "text", x = 0.64, y = 0.13, label = "No pure-strategy PBE",
    colour = "#46515C", size = 3.5
  ) +
  ggplot2::annotate(
    "text", x = 0.67, y = 0.035, label = "Zero-posterior family",
    colour = "#005A8D", size = 3.2, vjust = -0.3
  ) +
  ggplot2::scale_fill_manual(
    values = c("PBE exists" = "#0072B2", "No pure-strategy PBE" = "#D9D9D9")
  ) +
  ggplot2::scale_x_continuous(
    limits = c(0, 1),
    breaks = c(0, p_star, 1),
    labels = c("0", "p*", "1"),
    expand = c(0, 0)
  ) +
  ggplot2::scale_y_continuous(
    limits = c(0, 1),
    breaks = c(0, p_star, 1),
    labels = c("0", "p*", "1"),
    expand = c(0, 0)
  ) +
  ggplot2::coord_cartesian(clip = "off") +
  ggplot2::labs(
    title = "Agenda-game existence is restricted by two belief cutoffs",
    subtitle = "Running illustration: ell = 0.10, h = 0.35, beta = 0.90; p* = 0.278",
    x = "Prior probability of the high type, p",
    y = "Off-path posterior, mu^off"
  ) +
  agenda_theme()

manifest <- rbind(
  save_bundle("figure_agenda_public_gap", gap_plot, gap_data, 7.0, 4.4),
  save_bundle("figure_agenda_unanimity_existence", existence_plot, existence_data, 6.8, 5.0)
)
utils::write.csv(
  manifest,
  file.path(output_directory, "agenda_extension_figure_manifest.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("AGENDA_EXTENSION_FIGURES: CREATED\n")
cat(paste(manifest$pdf, collapse = "\n"), "\n")
