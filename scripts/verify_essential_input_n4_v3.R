#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

source(file.path(repository_root, "scripts", "lib_essential_input_n4_v3_semantic_validator.R"))

paths <- list(
  contract = file.path(repository_root, "quality_reports", "plans", "2026-08-12_essential_input_gate0.md"),
  N2 = file.path(repository_root, "model_redesign", "essential_input_n2_r2_unanimity_interface.json"),
  cold = file.path(repository_root, "model_redesign", "essential_input_n4_r1_unanimity_cold_notes_v3.md"),
  derivation = file.path(repository_root, "model_redesign", "essential_input_n4_r1_unanimity_derivation_v3.md"),
  candidate = file.path(repository_root, "model_redesign", "essential_input_interfaces", "n4_r1_unanimity_candidate_v3.json"),
  ledger = file.path(repository_root, "model_redesign", "essential_input_n4_claim_ledger_v3.json"),
  builder = file.path(repository_root, "scripts", "build_essential_input_n4_v3.R"),
  oracle = file.path(repository_root, "scripts", "oracle_essential_input_n4_v3.R"),
  semantic_library = file.path(repository_root, "scripts", "lib_essential_input_n4_v3_semantic_validator.R"),
  boundaries = file.path(repository_root, "scripts", "test_essential_input_n4_v3_boundaries.R"),
  integration = file.path(repository_root, "scripts", "test_essential_input_n4_v3_integration.R"),
  negative = file.path(repository_root, "scripts", "test_essential_input_n4_v3_negative.R"),
  common_mode = file.path(repository_root, "scripts", "test_essential_input_n4_v3_common_mode.R")
)

expected_hashes <- c(
  contract = "e6c663806f40b43c30ae8d8847ba4268fc4714fc3dfedc9b74b22505a24248b3",
  N2 = "c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2",
  cold = "5c4065fa5ff7baa4abae80e28d0d0643714f425ac3c62e560c2b309a7b7ba2f3",
  derivation = "eb7e75f960ed0be6e2689e09d57b261549cad65c9cb77d28f60e835dd93657ac",
  candidate = "6c199f961ba2b8e1f55719c8d678decf752fb7bcda042bf796a585f2a4278905",
  ledger = "e8b61d50eacf5c289990530ba6ca3e976a72f3ce00bac0e3b132b44f06ad0487",
  builder = "8b9f6b13262e84bd8f555e58c36649b89852281ab0d3cdcd1843f1cb9648639e",
  oracle = "279bb6c337374190dc17ab965dec03e56bdaed421c9430f666f6fd0d2b9009c3",
  semantic_library = "92a42f3ea62016b1e273fe82e5e026287b1fff8ac65466e7e9c8a6e4869810ba",
  boundaries = "eb7e2f58b5cd20588a5efe396bea4ead65629df6b5f939fa11afb0899189b5e2",
  integration = "0ea564fe19f66117409d87cff475b7c6827dff5b908eb081ccab36345f7dc5f2",
  negative = "b39a7840ef5d2b584a39456266313a491ff8de6e54bbbaa006d898f2cafa943d",
  common_mode = "82a1ef1aad251911f4ab6c4b8c3ac14166cdcd3c88c05b0b1cab09c5e6f181f3"
)

sha256_file <- function(path) {
  executable <- Sys.which("shasum")
  assert_true(nzchar(executable), "The 'shasum' executable is required.")
  output <- system2(
    executable, c("-a", "256", path), stdout = TRUE, stderr = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  lines <- grep("^[0-9a-f]{64}[[:space:]]", output, value = TRUE)
  assert_true(length(lines) == 1L, paste("Could not hash", path))
  strsplit(lines[[1L]], "[[:space:]]+")[[1L]][1L]
}

sha256_lines <- function(lines) {
  target <- tempfile("n4-v3-manifest-")
  on.exit(unlink(target), add = TRUE)
  writeLines(enc2utf8(lines), target, useBytes = TRUE)
  sha256_file(target)
}

for (name in names(paths)) {
  assert_true(file.exists(paths[[name]]), paste0("Missing N4 v3 artifact: ", name))
  observed <- sha256_file(paths[[name]])
  assert_true(
    identical(observed, expected_hashes[[name]]),
    paste0("Hash mismatch for ", name, ": ", observed)
  )
}

candidate <- jsonlite::fromJSON(paths$candidate, simplifyVector = FALSE)
ledger <- jsonlite::fromJSON(paths$ledger, simplifyVector = FALSE)
builder_text <- paste(
  readLines(paths$builder, warn = FALSE, encoding = "UTF-8"),
  collapse = "\n"
)

semantic_errors <- n4v3_validate_candidate_semantics(candidate, ledger, builder_text)
assert_true(
  length(semantic_errors) == 0L,
  paste("Independent N4 v3 semantic validation failed:", paste(semantic_errors, collapse = " | "))
)
assert_true(
  identical(ledger$artifact_hash, paste0("sha256:", expected_hashes[["candidate"]])),
  "Ledger does not bind the exact N4 v3 candidate hash."
)
assert_true(
  identical(ledger$cold_note_hash, paste0("sha256:", expected_hashes[["cold"]])),
  "Ledger does not bind the sealed cold-note hash."
)

expected_candidate_category_count <- c(
  belief_system = 54L,
  candidate_header = 3L,
  cell_existence = 12L,
  cell_identity_domain = 90L,
  record_assumptions_checks = 162L,
  record_hegemon_payoff = 12L,
  record_identity_domain = 96L,
  record_outcome = 24L,
  record_payoff_date = 6L,
  record_proposer_payoff = 42L,
  record_sources = 18L,
  record_status_selection = 12L,
  record_weak_payoff = 30L,
  strategy_ballot_map = 42L,
  strategy_ballot_oracle = 60L,
  strategy_branch_coverage = 260L,
  strategy_delay = 105L,
  strategy_derived_quantities = 126L,
  strategy_frozen_continuation = 108L,
  strategy_identity = 36L,
  strategy_low_only = 72L,
  strategy_mixing = 62L,
  strategy_nu0_reporting = 32L,
  strategy_pooling = 132L,
  strategy_security = 60L,
  strategy_transport = 6L
)

expected_candidate_category_hash <- c(
  belief_system = "610a3e9a9f25e8b464c1a74afe573a8a473ab05c67ea5af0dbe2b23390a29c69",
  candidate_header = "1af558bbd6b1e3e14ca4d23366fdb59d29c1528c42c1422aed44ed4488a6db96",
  cell_existence = "09611380d2abe493b39bcc78f828d398cbc8958a1bff85b232d4e7fbb5a65516",
  cell_identity_domain = "70345040404c66b5fe57cec5ace54d80e638464135c4f9f1baa6928dbc92e551",
  record_assumptions_checks = "fc26f6e566b2fcb55669d850f2de8aa656c07723bda8955c39998759eb6e489a",
  record_hegemon_payoff = "858a8e15997bd7cf07c4888764f6a50c804af6c7c1a68fbb2d150970bdf4df4e",
  record_identity_domain = "02e93cf7cd114a0b43a4cf97dd4d03ea51a2a6ba4a33811786ad6683f4db645d",
  record_outcome = "f4bf329aed2d28a1b3ec07078bc0efe9299f656aa9004ed15344d4c80764a00b",
  record_payoff_date = "2b0b2a014d1ae3178938457eef63833d3e803ec5c6080ae7d6a665c113b26171",
  record_proposer_payoff = "4ea7ba0da259cf8cffc14234899e0596e6aa42b30f59d8d88517f9ecd3bd4a67",
  record_sources = "56fc9ff088e252423000b7935422eec332c7ae0971a0ef25bcdc8f0f40ed62af",
  record_status_selection = "157e33da903017090c3f8260a481b894e0b3ef3048758364e301a9cb88b36731",
  record_weak_payoff = "db4c8144907b4457e7bdd3f5ce3daa697861979caee089e488d97cf09d98bc96",
  strategy_ballot_map = "fb5accf7f588827c7d8a6e56cca0de4f47f2d496e275c320aba28ce3f76b645d",
  strategy_ballot_oracle = "b22749bff09b84e58bb7c5f896077d7754921f1d0245c981683bc5cc66de97d8",
  strategy_branch_coverage = "0560b3545cfe9db4a4d726d00c24f4e3ef60e69ddcc43b6aeaeace0d7ad2508b",
  strategy_delay = "e3482a9765b4b2788d02af4fc705df405da92a68ad9426d2433451cac403eef2",
  strategy_derived_quantities = "b698c17f6124b43a0a5c004be597af2346c6ef08548a4fcf9eafd720199f8528",
  strategy_frozen_continuation = "26d68c291e7f6a339674762f87f379e0a644b0cb87519ddf555b5a67a3ff7b64",
  strategy_identity = "440355ceaa7b4d09bb4a1cc2a6133aa660831977b3fcffbc3054fd8193b7a610",
  strategy_low_only = "1ed1ca737ee2d27af2919a9f536d3d1724f3401a0b0c87d87898c1f3cf88cd2f",
  strategy_mixing = "8b79a576448fbc6947f70ad1a098b3a43ad936a1fe1342dda48e9b572e006aae",
  strategy_nu0_reporting = "710a05a2427bc2a3d346cf5d4331e64415b4a3db14c2f6d8f665cb9c10f4199e",
  strategy_pooling = "c0e8c1716a7af44b0e1b4485df8ef01eca8c782b47a9cd4fca718a2964246762",
  strategy_security = "209e26b5e38439b6cdf024660f6dddb6a741eba28da430c54c908c2edf0a826f",
  strategy_transport = "706d11db158f2635e7eed2e0f23255a030f8013cc99018f085046611532801e2"
)

expected_ledger_category_count <- c(
  ledger_claim_content = 42L,
  ledger_claim_identity = 210L,
  ledger_header = 7L
)
expected_ledger_category_hash <- c(
  ledger_claim_content = "9ccd1ca6bbbceed080810f3edc1386c65181493535f26b29163704f80a4c5eb8",
  ledger_claim_identity = "8ad0a7139841cc1aed54c7e3d00088a6ef2dd4077521a72a3a0635b3167f0867",
  ledger_header = "1091c714ef4e3dcfe944f4687bb1960d9a7e9fd0e3cb61654cdef73507719f21"
)

verify_leaf_manifest <- function(
    object,
    artifact,
    expected_leaf_count,
    expected_path_hash,
    expected_manifest_hash,
    expected_category_count,
    expected_category_hash) {
  coverage <- n4v3_audit_path_coverage(object, artifact)
  assert_true(coverage$valid, paste0("Uncovered ", artifact, " semantic leaf path."))
  leaves <- coverage$leaves
  assert_true(nrow(leaves) == expected_leaf_count, paste0("Wrong ", artifact, " leaf count."))
  assert_true(
    identical(sha256_lines(sort(leaves$path)), expected_path_hash),
    paste0("Wrong ", artifact, " path-set hash.")
  )
  manifest_lines <- paste(leaves$category, leaves$path, leaves$value, sep = "\t")
  assert_true(
    identical(sha256_lines(manifest_lines), expected_manifest_hash),
    paste0("Wrong ", artifact, " full semantic-manifest hash.")
  )
  observed_categories <- sort(unique(leaves$category))
  assert_true(
    identical(observed_categories, sort(names(expected_category_count))),
    paste0("Wrong ", artifact, " semantic category set.")
  )
  for (category in names(expected_category_count)) {
    subset <- leaves[leaves$category == category, , drop = FALSE]
    assert_true(
      nrow(subset) == expected_category_count[[category]],
      paste0("Wrong leaf count for ", artifact, "/", category, ".")
    )
    observed_hash <- sha256_lines(paste(subset$path, subset$value, sep = "\t"))
    assert_true(
      identical(observed_hash, expected_category_hash[[category]]),
      paste0("Wrong semantic category hash for ", artifact, "/", category, ".")
    )
  }
  invisible(TRUE)
}

verify_leaf_manifest(
  candidate, "candidate", 1662L,
  "5cd3701d3d1b61ecc56823af2fc3e226389f944e62d57ba51edb2cd862579253",
  "74f17f6854a4263ef8f9337d849d13e73489c25543b9f7b8ee659fccc16462d6",
  expected_candidate_category_count,
  expected_candidate_category_hash
)
verify_leaf_manifest(
  ledger, "ledger", 259L,
  "e18876cb2cbc8d815229a33c7247b64663c3624ac31ef9412a601fd1b7e796cb",
  "df1d0c89089ca42af6de6dcdc39885a5e2aa429ec6d0c9a8a15d2baa05b935e9",
  expected_ledger_category_count,
  expected_ledger_category_hash
)

run_R_script <- function(path, arguments = character(0)) {
  rscript <- file.path(R.home("bin"), "Rscript")
  output <- system2(
    rscript,
    c("--vanilla", path, arguments),
    stdout = TRUE,
    stderr = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  status <- attr(output, "status")
  if (is.null(status)) status <- 0L
  assert_true(status == 0L, paste0(
    "Sub-verification failed for ", basename(path), ":\n",
    paste(output, collapse = "\n")
  ))
  pass_lines <- grep("^PASS:", output, value = TRUE)
  assert_true(length(pass_lines) >= 1L, paste0("No PASS marker from ", basename(path), "."))
  invisible(pass_lines)
}

run_R_script(paths$builder, "--check")
run_R_script(paths$negative)
run_R_script(paths$boundaries)
run_R_script(paths$integration)
run_R_script(paths$common_mode)

cat("PASS: N4 v3 candidate is byte-pinned, schema-valid, semantically covered, and oracle-verified\n")
cat("candidate_sha256=", expected_hashes[["candidate"]], "\n", sep = "")
cat("ledger_sha256=", expected_hashes[["ledger"]], "\n", sep = "")
cat("candidate_semantic_leaves=1662\n")
cat("ledger_semantic_leaves=259\n")
