#!/usr/bin/env Rscript

# Generate a compact Markdown packet for external mathematical review.
# It contains the ChatGPT Pro prompt plus the current Appendix A/B excerpt,
# with hidden superseded LaTeX blocks removed.

source_file <- "formal_model_v5.Rmd"
output_file <- "quality_reports/chatgpt_h_proposer_prompt_appendix_AB.md"

lines <- readLines(source_file, encoding = "UTF-8", warn = FALSE)

start <- grep("^# Appendix A:", lines)[1]
end <- grep("^# Appendix C:", lines)[1] - 1
if (is.na(start) || is.na(end) || end <= start) {
  stop("Could not locate Appendix A/B boundaries in ", source_file)
}

appendix <- lines[start:end]

remove_hidden_latex <- function(x) {
  out <- character()
  i <- 1
  while (i <= length(x)) {
    starts_hidden <- i + 2 <= length(x) &&
      identical(x[i], "```{=latex}") &&
      grepl("\\\\iffalse", x[i + 1])

    if (starts_hidden) {
      i <- i + 3
      while (i <= length(x)) {
        ends_hidden <- i + 2 <= length(x) &&
          identical(x[i], "```{=latex}") &&
          grepl("\\\\fi", x[i + 1])
        if (ends_hidden) {
          i <- i + 3
          break
        }
        i <- i + 1
      }
    } else {
      out <- c(out, x[i])
      i <- i + 1
    }
  }
  out
}

appendix <- remove_hidden_latex(appendix)
appendix <- gsub(
  "Eq\\.\\\\ \\\\eqref\\{eq:alpha_star\\}",
  "main-text threshold equation (not included here)",
  appendix
)

header <- c(
  "---",
  'title: "H-Proposer Signaling Subgame: Prompt and Appendix A/B"',
  'author: ""',
  'date: "2026-05-10"',
  "output:",
  "  bookdown::pdf_document2:",
  "    number_sections: true",
  "    toc: true",
  "    latex_engine: xelatex",
  "header-includes:",
  "  - \\usepackage{setspace}",
  "  - \\setstretch{1.15}",
  "  - \\usepackage{parskip}",
  "  - \\setlength{\\parskip}{6pt}",
  "  - \\setlength{\\parindent}{0pt}",
  "  - \\usepackage{float}",
  "  - \\usepackage{amsmath,amssymb,amsthm}",
  "  - \\newtheorem{definition}{Definition}",
  "  - \\newtheorem{lemma}{Lemma}",
  "  - \\newtheorem{proposition}{Proposition}",
  "  - \\newtheorem{theorem}{Theorem}",
  "  - \\newtheorem{corollary}{Corollary}",
  "  - \\newtheorem{assumption}{Assumption}",
  "  - \\newtheorem{remark}{Remark}",
  "  - \\newtheorem{example}{Example}",
  "  - \\usepackage{booktabs}",
  "fontsize: 11pt",
  "geometry: margin=2.5cm",
  "mainfont: Times New Roman",
  "---",
  "",
  "# Prompt for ChatGPT Pro",
  "",
  "We are working on a formal theory paper. The main body is known to be outdated; use only the appendix excerpt below as proof status.",
  "",
  "Note: cross-references to the main body may appear in the excerpt, but they are not needed for this task. Treat the primitives and formulas stated in Appendix A/B as self-contained.",
  "",
  "Task: solve, or characterize as far as possible, the R1 subgame in which the hegemon $H$ proposes under unanimity.",
  "",
  "Goal: determine whether the H-proposer payoff outside the accepted-pooling region is a unique equilibrium payoff function, a non-singleton payoff correspondence, or not characterizable without an equilibrium refinement/selection rule.",
  "",
  "Please do the following:",
  "",
  "1. Formalize the H-proposer signaling subgame precisely.",
  "2. Characterize all pure-strategy PBE: accepted pooling; both types accepted with different proposals; high accepted/low rejected; low accepted/high rejected; both rejected.",
  "3. For nonexistence results, handle BF feasibility carefully: a proposal feasible for the high type need not be feasible for the low type.",
  "4. If pure-strategy PBE do not exist outside accepted pooling, analyze whether mixed-strategy PBE exist and characterize the payoff correspondence if possible.",
  "5. State whether H's payoff outside pooling is unique or selection-dependent.",
  "6. If exact characterization is too hard, derive the tightest possible upper and lower bounds on H's payoff, with explicit parameter conditions.",
  "7. Identify which pieces can be turned into paper-ready lemmas.",
  "8. Flag assumptions about off-path beliefs, tie-breaking, and refinements such as Cho-Kreps/D1.",
  "",
  "Do not rescue old theorem statements. Rederive from primitives.",
  "",
  "\\newpage",
  "",
  "# Appendix Excerpt",
  ""
)

dir.create(dirname(output_file), recursive = TRUE, showWarnings = FALSE)
writeLines(c(header, appendix), output_file, useBytes = TRUE)

message("Wrote ", output_file)
