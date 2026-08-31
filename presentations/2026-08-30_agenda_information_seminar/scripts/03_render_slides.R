#!/usr/bin/env Rscript

invisible(Sys.setlocale("LC_ALL", "pt_BR.UTF-8"))

input <- "presentations/2026-08-30_agenda_information_seminar/seminario_agenda_informacao.Rmd"

rmarkdown::render(input, clean = TRUE)
