#!/usr/bin/env Rscript

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_argument) != 1L) stop("Could not resolve draft-figure generator path.", call. = FALSE)
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

utf8_locale <- Sys.setlocale("LC_CTYPE", "pt_BR.UTF-8")
if (is.na(utf8_locale)) stop("Could not activate a UTF-8 locale for PDF generation.", call. = FALSE)

source(file.path(repository_root, "scripts", "essential_input_formulas.R"), local = FALSE)
source(file.path(repository_root, "scripts", "region_plot_functions.R"), local = FALSE)
verify_essential_input_formula_sources(repository_root)
ei_require_ggplot2()

output_directory <- file.path(repository_root, "figures", "draft")
dir.create(output_directory, recursive = TRUE, showWarnings = FALSE)

plane_plot <- plot_essential_input_o_plane(nu = 0.35, m = 4L, beta = 0.90, resolution = 151L)
nu_plot <- plot_essential_input_nu_partition(
  o_0 = 0.10, o_1 = 0.35, m = 4L, beta = 0.90, resolution = 1201L
)
margin_plot <- plot_essential_input_margin_table(
  N = 5L, o_0 = 0.10, o_1 = 0.35, beta = 0.90, nu = 0.35
)

plane_pdf <- file.path(output_directory, "figure_c1_o_plane_n5_nu035.pdf")
nu_pdf <- file.path(output_directory, "figure_c2_nu_partition_n5.pdf")
margin_pdf <- file.path(output_directory, "table_c1_margin_n5.pdf")

portable_pdf <- function(filename, width, height, ...) {
  grDevices::pdf(
    file = filename, width = width, height = height,
    family = "Helvetica", encoding = "ISOLatin1.enc", useDingbats = FALSE
  )
}

ggplot2::ggsave(plane_pdf, plane_plot, width = 11.0, height = 7.2, units = "in", device = portable_pdf)
ggplot2::ggsave(nu_pdf, nu_plot, width = 10.5, height = 5.8, units = "in", device = portable_pdf)
ggplot2::ggsave(margin_pdf, margin_plot, width = 11.0, height = 6.2, units = "in", device = portable_pdf)

write.csv(
  attr(plane_plot, "region_data"),
  file.path(output_directory, "figure_c1_o_plane_n5_nu035_data.csv"),
  row.names = FALSE, fileEncoding = "UTF-8"
)
write.csv(
  attr(nu_plot, "region_data"),
  file.path(output_directory, "figure_c2_nu_partition_n5_data.csv"),
  row.names = FALSE, fileEncoding = "UTF-8"
)
write.csv(
  attr(margin_plot, "margin_data"),
  file.path(output_directory, "table_c1_margin_n5_data.csv"),
  row.names = FALSE, fileEncoding = "UTF-8"
)

cat("ESSENTIAL_INPUT_DRAFT_FIGURES: CREATED\n")
cat(paste(c(plane_pdf, nu_pdf, margin_pdf), collapse = "\n"), "\n")
