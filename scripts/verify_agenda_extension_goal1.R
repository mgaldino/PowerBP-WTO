#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_argument) != 1L) {
  stop("Could not resolve verifier path.", call. = FALSE)
}
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repo_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
source(file.path(dirname(script_path), "agenda_extension_goal1_verifier_lib.R"))

checks <- agenda_run_repository_checks(repo_root)
for (row_index in seq_len(nrow(checks))) {
  cat(
    sprintf(
      "%-42s | %-4s | %s\n",
      checks$check_id[[row_index]],
      checks$status[[row_index]],
      checks$detail[[row_index]]
    )
  )
}

pass_count <- sum(checks$status == "PASS")
fail_count <- sum(checks$status == "FAIL")
cat(sprintf("\nSUMMARY | %d PASS | %d FAIL\n", pass_count, fail_count))

if (fail_count > 0L) {
  cat(
    "FAIL: Goal 1 mechanical verification failed. No mathematical conclusion is authorized.\n"
  )
  quit(save = "no", status = 1L)
}

cat(
  paste0(
    "PASS: pinned external hashes, structural consumability, approved Gate 0 bytes, ",
    "schemas, DAG topology, finite quotas, date transport, and supplied finite identities ",
    "passed. This is not a proof of PBE existence, completeness, optimality, Bayes-limit ",
    "existence, measurability, family coverage, or invariance.\n"
  )
)
