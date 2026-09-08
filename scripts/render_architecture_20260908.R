#!/usr/bin/env Rscript
# Run from the repository root. Honor the note's bookdown YAML.
# Rendering must not attempt to install or update system LaTeX packages.
options(tinytex.install_packages = FALSE)
rmarkdown::render(
  "quality_reports/architecture_2026-09-08/architecture_note.Rmd",
  quiet = TRUE
)
