#!/usr/bin/env Rscript

# Goal 3 orchestration wrapper. Runs only the new PBE-UD verifiers and stops
# at the first nonzero exit status.

options(stringsAsFactors = FALSE)

args_full <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args_full, value = TRUE)
if (length(file_arg) == 1L) {
  script_path <- normalizePath(sub("^--file=", "", file_arg), mustWork = TRUE)
  repo_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
} else {
  repo_root <- normalizePath(".", mustWork = TRUE)
}

scripts <- file.path(
  repo_root,
  "scripts",
  c(
    "verify_undominated_voting_gate0.R",
    "verify_undominated_voting_regular.R",
    "verify_undominated_voting_boundaries.R"
  )
)

for (script in scripts) {
  cat(sprintf("\nRunning %s\n", basename(script)))
  status <- system2(
    command = file.path(R.home("bin"), "Rscript"),
    args = shQuote(script)
  )
  if (!identical(status, 0L)) {
    stop(sprintf("Verifier failed: %s", script), call. = FALSE)
  }
}

cat("\nAll Goal 3 PBE-UD verifiers passed.\n")
