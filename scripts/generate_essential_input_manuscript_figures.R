#!/usr/bin/env Rscript

# Generate the permanent reader-facing figures for the essential-input
# manuscript.  All equilibrium content comes from the frozen N1--N7 sources;
# no figure performs an additional equilibrium selection.

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_argument) != 1L) {
  stop("Could not resolve manuscript-figure generator path.", call. = FALSE)
}
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
if (length(commandArgs(trailingOnly = TRUE)) > 0L) {
  stop("This final generator accepts no command-line arguments.", call. = FALSE)
}

utf8_locale <- Sys.setlocale("LC_CTYPE", "pt_BR.UTF-8")
if (is.na(utf8_locale)) {
  warning("Could not activate pt_BR.UTF-8; retaining the current UTF-8-capable locale.")
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

frozen_sources <- c(
  n6 = "a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92",
  n7 = "4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45"
)
source_paths <- c(
  n6 = "model_redesign/essential_input_n6_private_comparison_candidate.json",
  n7 = "model_redesign/essential_input_n7_complete_information_benchmark_candidate.json"
)
observed_sources <- vapply(
  source_paths,
  function(relative_path) ei_sha256_file(file.path(repository_root, relative_path)),
  character(1)
)
if (!identical(unname(observed_sources), unname(frozen_sources))) {
  stop("Frozen N6/N7 source hash mismatch.", call. = FALSE)
}

output_directory <- file.path(repository_root, "figures", "essential_input")
dir.create(output_directory, recursive = TRUE, showWarnings = FALSE)

portable_pdf <- function(filename, width, height, ...) {
  grDevices::pdf(
    file = filename, width = width, height = height,
    family = "Helvetica", encoding = "ISOLatin1.enc",
    useDingbats = FALSE, onefile = FALSE, bg = "white"
  )
}

save_figure_bundle <- function(prefix, plot, width, height) {
  relative_base <- file.path("figures", "essential_input", prefix)
  pdf_path <- file.path(repository_root, paste0(relative_base, ".pdf"))
  png_path <- file.path(repository_root, paste0(relative_base, ".png"))
  csv_path <- file.path(repository_root, paste0(relative_base, "_data.csv"))
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
    width = width, height = height, units = "in", dpi = 320,
    device = "png", bg = "white"
  )
  utils::write.csv(
    figure_data, csv_path, row.names = FALSE, fileEncoding = "UTF-8", na = ""
  )
  data.frame(
    figure = prefix,
    pdf = paste0(relative_base, ".pdf"),
    png = paste0(relative_base, ".png"),
    csv = paste0(relative_base, "_data.csv"),
    width_in = width,
    height_in = height,
    n6_sha256 = frozen_sources[["n6"]],
    n7_sha256 = frozen_sources[["n7"]],
    stringsAsFactors = FALSE
  )
}

manifest_rows <- list()
register <- function(prefix, plot, width, height) {
  manifest_rows[[length(manifest_rows) + 1L]] <<-
    save_figure_bundle(prefix, plot, width, height)
}

f1_data <- essential_input_f1_final_data(
  kappa = 0.50, m = 4L, beta = 0.90, vertical_scale = "normalized"
)
register(
  "figure_f1_private_comparison",
  plot_essential_input_f1_final(f1_data),
  11.4, 7.2
)

f2_data <- essential_input_f2_data(
  o_0 = 0.10, o_1 = 0.35, m = 4L, beta = 0.90, nu_example = 0.35,
  public_benchmark = NULL
)
register(
  "figure_f2_prices_coalitions",
  plot_essential_input_f2(f2_data),
  10.6, 10.4
)

f3_data <- essential_input_f3_final_data(
  o_0 = 0.10, o_1 = 0.35, m = 4L, beta = 0.90, nu = 0.80
)
register(
  "figure_f3_power_information",
  plot_essential_input_f3_final(f3_data),
  10.6, 9.2
)

f4_data <- essential_input_f4_data(
  o_0 = 0.10, o_1 = 0.35, m = 4L, beta = 0.90
)
register(
  "figure_f4_hegemonic_decline",
  plot_essential_input_f4(f4_data),
  9.6, 6.4
)

manifest <- do.call(rbind, manifest_rows)
manifest_path <- file.path(
  output_directory, "essential_input_manuscript_figure_manifest.csv"
)
utils::write.csv(
  manifest, manifest_path, row.names = FALSE, fileEncoding = "UTF-8"
)

cat("ESSENTIAL_INPUT_MANUSCRIPT_FIGURES: CREATED\n")
cat(paste(manifest$pdf, collapse = "\n"), "\n")
cat(
  "MANIFEST:",
  file.path("figures", "essential_input", basename(manifest_path)),
  "\n"
)
