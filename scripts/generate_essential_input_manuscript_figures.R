#!/usr/bin/env Rscript

# Generate the reader-facing private-information figure set.
#
# Usage:
#   Rscript --vanilla scripts/generate_essential_input_manuscript_figures.R
#   Rscript --vanilla scripts/generate_essential_input_manuscript_figures.R --skip-f1
#   Rscript --vanilla scripts/generate_essential_input_manuscript_figures.R --include-example-slice

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_argument) != 1L) {
  stop("Could not resolve manuscript-figure generator path.", call. = FALSE)
}
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
arguments <- commandArgs(trailingOnly = TRUE)
skip_f1 <- "--skip-f1" %in% arguments
include_example_slice <- "--include-example-slice" %in% arguments
unknown <- setdiff(arguments, c("--skip-f1", "--include-example-slice"))
if (length(unknown) > 0L) {
  stop(paste("Unknown argument(s):", paste(unknown, collapse = ", ")), call. = FALSE)
}

utf8_locale <- Sys.setlocale("LC_CTYPE", "pt_BR.UTF-8")
if (is.na(utf8_locale)) {
  stop("Could not activate the UTF-8 locale required by the source modules.", call. = FALSE)
}
options(encoding = "UTF-8")
source(file.path(repository_root, "scripts", "essential_input_formulas.R"), local = FALSE)
source(
  file.path(repository_root, "scripts", "essential_input_manuscript_figure_functions.R"),
  local = FALSE
)
ei_require_manuscript_figure_packages()
verify_essential_input_formula_sources(repository_root)
verify_essential_input_n6_figure_source(repository_root)

output_directory <- file.path(repository_root, "figures", "draft")
dir.create(output_directory, recursive = TRUE, showWarnings = FALSE)

portable_pdf <- function(filename, width, height, ...) {
  grDevices::pdf(
    file = filename, width = width, height = height,
    family = "Helvetica", encoding = "ISOLatin1.enc",
    useDingbats = FALSE, onefile = FALSE
  )
}

save_figure_bundle <- function(prefix, plot, width, height) {
  pdf_path <- file.path(output_directory, paste0(prefix, ".pdf"))
  png_path <- file.path(output_directory, paste0(prefix, ".png"))
  csv_path <- file.path(output_directory, paste0(prefix, "_data.csv"))
  figure_data <- attr(plot, "figure_data")
  if (is.null(figure_data) || !is.data.frame(figure_data) || nrow(figure_data) == 0L) {
    stop(paste("Missing figure_data for", prefix), call. = FALSE)
  }
  ggplot2::ggsave(
    filename = pdf_path, plot = plot,
    width = width, height = height, units = "in", device = portable_pdf
  )
  ggplot2::ggsave(
    filename = png_path, plot = plot,
    width = width, height = height, units = "in", dpi = 320, device = "png"
  )
  utils::write.csv(
    figure_data, csv_path, row.names = FALSE, fileEncoding = "UTF-8",
    na = ""
  )
  data.frame(
    figure = prefix,
    pdf = pdf_path,
    png = png_path,
    csv = csv_path,
    width_in = width,
    height_in = height,
    stringsAsFactors = FALSE
  )
}

manifest_rows <- list()
manifest_index <- 0L
register <- function(...) {
  manifest_index <<- manifest_index + 1L
  manifest_rows[[manifest_index]] <<- save_figure_bundle(...)
}

if (!skip_f1) {
  slices <- c(0.50, 0.25, 0.75)
  if (include_example_slice) slices <- c(slices, 2 / 7)
  for (kappa in slices) {
    checked_points <- ei_verify_f1_ex_ante_partition(
      kappa = kappa, m = 4L, beta = 0.90
    )
    cat(sprintf(
      "F1_EX_ANTE_PRIOR_IMAGE: PASS — kappa=%.6f, checked_points=%d\n",
      kappa, checked_points
    ))
    for (vertical_scale in c("raw", "normalized")) {
      example <- NULL
      if (abs(kappa - 2 / 7) < 1e-12) {
        example <- list(nu = 0.35, o_0 = 0.10, o_1 = 0.35)
      }
      data_object <- essential_input_f1_data(
        kappa = kappa, m = 4L, beta = 0.90,
        vertical_scale = vertical_scale, example = example
      )
      figure_label <- if (abs(kappa - 2 / 7) < 1e-12) {
        "Figure F1 (worked-example slice)"
      } else {
        "Figure F1"
      }
      plot <- plot_essential_input_f1(data_object, figure_label = figure_label)
      kappa_code <- sprintf("%03d", round(100 * kappa))
      register(
        prefix = paste0(
          "figure_f1_institutional_map_kappa", kappa_code, "_", vertical_scale
        ),
        plot = plot, width = 14.5, height = 8.0
      )
    }
  }
}

f2_data <- essential_input_f2_data(
  o_0 = 0.10, o_1 = 0.35, m = 4L, beta = 0.90, nu_example = 0.35,
  public_benchmark = NULL
)
register(
  prefix = "figure_f2_prices_coalition_anatomy_n5",
  plot = plot_essential_input_f2(f2_data),
  width = 10.6, height = 10.4
)

for (x_scale in c("raw", "normalized")) {
  register(
    prefix = paste0("figure_f3_power_information_decomposition_", x_scale, "_placeholder"),
    plot = plot_essential_input_f3(
      point_data = NULL, contrast_data = NULL, m = 4L,
      x_scale = x_scale, nu_fixed = 0.80
    ),
    width = 10.6, height = 9.2
  )
}

f4_data <- essential_input_f4_data(o_0 = 0.10, o_1 = 0.35, m = 4L, beta = 0.90)
register(
  prefix = "figure_f4_hegemonic_decline_n5",
  plot = plot_essential_input_f4(f4_data),
  width = 9.6, height = 6.4
)

appendix_data <- essential_input_appendix_c1_data(
  nu = 0.35, m = 4L, beta = 0.90,
  example = c(o_0 = 0.10, o_1 = 0.35)
)
register(
  prefix = "figure_c1_o_plane_n5_nu035",
  plot = plot_essential_input_appendix_c1(appendix_data),
  width = 10.8, height = 7.2
)

manifest <- do.call(rbind, manifest_rows)
manifest_path <- file.path(output_directory, "essential_input_manuscript_figure_manifest.csv")
utils::write.csv(
  manifest, manifest_path, row.names = FALSE, fileEncoding = "UTF-8"
)

cat("ESSENTIAL_INPUT_MANUSCRIPT_FIGURES: CREATED\n")
cat(paste(manifest$pdf, collapse = "\n"), "\n")
cat("MANIFEST:", manifest_path, "\n")
