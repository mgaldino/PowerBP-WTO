#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

near <- function(x, y, tolerance = 1e-10) abs(x - y) <= tolerance
deep_copy <- function(x) unserialize(serialize(x, NULL))
as_character <- function(x) as.character(unlist(x, use.names = FALSE))

sha256_file <- function(path) {
  executable <- Sys.which("shasum")
  assert_true(nzchar(executable), "The shasum executable is required.")
  output <- system2(executable, c("-a", "256", path), stdout = TRUE, stderr = TRUE)
  lines <- grep("^[0-9a-f]{64}[[:space:]]", output, value = TRUE)
  assert_true(length(lines) == 1L, paste("Could not hash", path))
  strsplit(lines[[1L]], "[[:space:]]+")[[1L]][[1L]]
}

read_utf8_text <- function(path, label) {
  bytes <- readBin(path, what = "raw", n = file.info(path)$size)
  decoded <- rawToChar(bytes)
  checked <- iconv(decoded, from = "UTF-8", to = "UTF-8", sub = NA_character_)
  assert_true(length(checked) == 1L && !is.na(checked), paste(label, "is not UTF-8."))
  decoded
}

collect_field_paths <- function(x, path = list(), label = "root") {
  if (!is.list(x) || length(x) == 0L) return(list())
  output <- list()
  object_names <- names(x)
  for (index in seq_along(x)) {
    named <- !is.null(object_names) && nzchar(object_names[[index]])
    key <- if (named) object_names[[index]] else index
    child_label <- if (named) paste0(label, ".", key) else paste0(label, "[[", index, "]]" )
    child_path <- c(path, list(key))
    output[[child_label]] <- child_path
    descendants <- collect_field_paths(x[[index]], child_path, child_label)
    if (length(descendants) > 0L) output <- c(output, descendants)
  }
  output
}

set_path_value <- function(x, path, value) {
  key <- path[[1L]]
  if (length(path) == 1L) {
    x[[key]] <- value
    return(x)
  }
  x[[key]] <- set_path_value(x[[key]], path[-1L], value)
  x
}

get_path_value <- function(x, path) {
  value <- x
  for (key in path) value <- value[[key]]
  value
}

mutated_value <- function(value) {
  if (is.null(value)) return("__MUTATED_NULL__")
  if (is.character(value)) return(paste0(value, " [MUTATED]"))
  if (is.logical(value)) return(!value)
  if (is.numeric(value)) return(value + 1)
  if (is.list(value)) {
    changed <- deep_copy(value)
    if (length(changed) == 0L) return(list("__MUTATED_EMPTY__"))
    if (!is.null(names(changed)) && all(nzchar(names(changed)))) {
      changed[["__mutation_marker__"]] <- "MUTATED"
    } else {
      changed[[length(changed) + 1L]] <- "MUTATED"
    }
    return(changed)
  }
  stop("Unsupported mutation type.", call. = FALSE)
}

script_arg <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_arg) == 1L, "Could not resolve verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_arg), mustWork = TRUE)
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

interface_path <- file.path(root, "model_redesign", "essential_input_n4_r1_unanimity_interface.json")
ledger_path <- file.path(root, "model_redesign", "essential_input_n4_r1_unanimity_ledger.json")
derivation_path <- file.path(root, "model_redesign", "essential_input_n4_r1_unanimity_derivation.md")
n2_path <- file.path(root, "model_redesign", "essential_input_n2_r2_unanimity_interface.json")
dag_path <- file.path(root, "model_redesign", "essential_input_game_dag.json")
contract_path <- file.path(root, "quality_reports", "plans", "2026-08-12_essential_input_gate0.md")
formal_review_path <- file.path(root, "quality_reports", "2026-08-19_n4_formal_design_review_round8.md")
game_review_path <- file.path(root, "quality_reports", "2026-08-19_n4_game_theory_review_round8.md")

expected_interface_hash <- "ee61ce6f854d4393f51048592a5221a9999a8f3f7daca1e749e7f19a88927f2d"
expected_ledger_hash <- "85101437ff0241f7383a5acbed9f102049477eb3544a29c273cfcff488fb9bf1"
expected_derivation_hash <- "9cc1088005ae203356c2769f3ff6755b1a9cba3480ed4a7c4404085c72180a0a"
expected_n2_hash <- "c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2"
expected_contract_hash <- "368b09eace9b1c2e68ffdcc61e6583dbc060591f1faf627f93919bae79e2241a"
expected_dag_hash <- "3753dcdd9c61e545c3bb70099a55b443425695e626e4905a16f97f85edc3b4ab"
expected_formal_review_hash <- "ba759c1c1eee3ebaf52fc68aca7dc4d4e6bc543e5c0e90c082928658b010143f"
expected_game_review_hash <- "89a38bcaea025f6c06c10688cae6967a61fe62c6e801f15e803bd89c3159071d"

interface_text <- read_utf8_text(interface_path, "N4 interface")
ledger_text <- read_utf8_text(ledger_path, "N4 ledger")
derivation_text <- read_utf8_text(derivation_path, "N4 derivation")
invisible(read_utf8_text(n2_path, "N2 interface"))
formal_review_text <- read_utf8_text(formal_review_path, "N4 formal-design review")
game_review_text <- read_utf8_text(game_review_path, "N4 game-theory review")

assert_true(unname(sha256_file(interface_path)) == expected_interface_hash, "N4 interface hash mismatch.")
assert_true(unname(sha256_file(ledger_path)) == expected_ledger_hash, "N4 ledger hash mismatch.")
assert_true(unname(sha256_file(derivation_path)) == expected_derivation_hash, "N4 derivation hash mismatch.")
assert_true(unname(sha256_file(n2_path)) == expected_n2_hash, "Frozen N2 hash mismatch.")
assert_true(unname(sha256_file(contract_path)) == expected_contract_hash, "Contract hash mismatch.")
assert_true(unname(sha256_file(dag_path)) == expected_dag_hash, "Frozen DAG hash mismatch.")
assert_true(unname(sha256_file(formal_review_path)) == expected_formal_review_hash, "Formal-design review hash mismatch.")
assert_true(unname(sha256_file(game_review_path)) == expected_game_review_hash, "Game-theory review hash mismatch.")

interface <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
ledger <- jsonlite::fromJSON(ledger_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
canonical_interface <- deep_copy(interface)
canonical_ledger <- deep_copy(ledger)

required_record_fields <- c(
  "equilibrium_id", "admissibility_conditions", "branch_classification", "strategy_profile", "belief_system",
  "source_continuation_record_ids", "source_interface_hashes", "existence_uniqueness_status", "selection_status",
  "assumptions_used", "checks_performed", "recognized_proposer_payoff", "weak_nonproposer_pre_recognition_expected_value",
  "hegemon_payoff_by_type", "outcome_distribution", "payoff_date"
)
required_cell_fields <- c(
  "cell_id", "domain_conditions", "existence_status", "equilibrium_records", "nonexistence_certificate"
)
expected_cell_ids <- c(
  "N4-CELL-M2-NU0",
  "N4-CELL-M2-LOW",
  "N4-CELL-M2-HIGH",
  "N4-CELL-MGE3-NU0",
  "N4-CELL-MGE3-LOW",
  "N4-CELL-MGE3-HIGH"
)
expected_equilibrium_ids <- c(
  "N4-EQ-COMPLETE-M2-NU0",
  "N4-EQ-COMPLETE-M2-LOW",
  "N4-EQ-COMPLETE-M2-HIGH",
  "N4-EQ-COMPLETE-MGE3-NU0",
  "N4-EQ-COMPLETE-MGE3-LOW",
  "N4-EQ-COMPLETE-MGE3-HIGH"
)

validate_interface_semantics <- function(candidate) {
  assert_true(is.list(candidate), "Interface must be an object.")
  assert_true(
    identical(names(candidate), c("schema_ref", "function_of", "correspondence_cells")),
    "N4 top-level fields must be exact."
  )
  assert_true(identical(candidate$schema_ref, "equilibrium_correspondence_v1"), "Wrong schema_ref.")
  assert_true(
    identical(candidate$function_of, list(name = "entry_belief", domain = "[0,1]")),
    "Wrong function_of object."
  )
  cells <- candidate$correspondence_cells
  assert_true(is.list(cells) && length(cells) == 6L, "N4 requires six coverage cells.")
  assert_true(
    identical(vapply(cells, `[[`, character(1), "cell_id"), expected_cell_ids),
    "Wrong coverage cell ids or order."
  )

  observed_record_ids <- character()
  for (index in seq_along(cells)) {
    cell <- cells[[index]]
    assert_true(identical(names(cell), required_cell_fields), paste("Wrong cell fields", index))
    assert_true(identical(cell$existence_status, "exists"), "Every N4 cell must exist.")
    assert_true(is.null(cell$nonexistence_certificate), "Existing cells require a null certificate.")
    assert_true(is.list(cell$equilibrium_records) && length(cell$equilibrium_records) == 1L, "Each cell needs one complete record.")
    record <- cell$equilibrium_records[[1L]]
    assert_true(identical(names(record), required_record_fields), paste("Wrong record fields", record$equilibrium_id))
    assert_true(identical(record$equilibrium_id, expected_equilibrium_ids[[index]]), "Wrong complete record id.")
    assert_true(
      identical(as_character(record$source_continuation_record_ids), c("N2-EQ-LOW-TYPE-ONLY", "N2-EQ-POOLING")),
      paste("Wrong N2 source records", record$equilibrium_id)
    )
    assert_true(
      identical(record$source_interface_hashes, list(N2 = paste0("sha256:", expected_n2_hash))),
      paste("Wrong N2 source hash", record$equilibrium_id)
    )
    assert_true(identical(names(record$hegemon_payoff_by_type), c("theta_0", "theta_1")), "Wrong H payoff coordinates.")
    assert_true(
      identical(names(record$outcome_distribution), c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")),
      "Wrong outcome coordinates."
    )
    assert_true(identical(record$outcome_distribution$pass_without_hegemon, "0"), "Unanimity cannot pass without H.")
    assert_true(grepl("R1_current_units", record$payoff_date, fixed = TRUE), "Wrong payoff date.")
    assert_true(is.list(record$strategy_profile) && is.list(record$belief_system), "Strategies and beliefs must be structured.")
    assert_true(
      grepl("common", record$selection_status, ignore.case = TRUE) && grepl("Y_i", record$selection_status, fixed = TRUE),
      paste("Common tie-break-minimal accepted offer missing", record$equilibrium_id)
    )
    checks <- as_character(record$checks_performed)
    for (required_check in c(
      "Proposal-level lower-H tie audit", "Identity-product closure audit", "True-prior deviation audit",
      "Atomless pointwise/Bayes-a.e. audit", "Exactly-once discount audit",
      "Off-path nonpivotal H-separation audit"
    )) {
      assert_true(required_check %in% checks, paste("Missing check", required_check, record$equilibrium_id))
    }
    assert_true(grepl("pointwise", record$belief_system$atomless_convention, fixed = TRUE), "Pointwise atomless rule missing.")
    assert_true(grepl("Cartesian", record$strategy_profile$proposal_mixing, fixed = TRUE), "Identity Cartesian closure missing.")
    observed_record_ids <- c(observed_record_ids, record$equilibrium_id)
  }
  assert_true(identical(observed_record_ids, expected_equilibrium_ids), "Record order mismatch.")
  assert_true(!anyDuplicated(observed_record_ids), "Equilibrium ids must be unique.")
  assert_true(!grepl('"existence_status": "none"', jsonlite::toJSON(candidate, auto_unbox = TRUE), fixed = TRUE), "No none cell is admissible.")
  invisible(TRUE)
}

validate_interface <- function(candidate) {
  validate_interface_semantics(candidate)
  assert_true(identical(candidate, canonical_interface), "Interface differs from the exact hashed candidate.")
  invisible(TRUE)
}

validate_ledger_semantics <- function(candidate) {
  assert_true(
    identical(names(candidate), c("ledger_schema", "node_id", "artifact_path", "artifact_hash", "node_status", "claims")),
    "Ledger envelope must be exact."
  )
  assert_true(identical(candidate$ledger_schema, "essential_input_claim_ledger_v1"), "Wrong ledger schema.")
  assert_true(identical(candidate$node_id, "N4"), "Wrong ledger node.")
  assert_true(identical(candidate$artifact_path, "model_redesign/essential_input_n4_r1_unanimity_interface.json"), "Wrong ledger artifact path.")
  assert_true(identical(candidate$artifact_hash, paste0("sha256:", expected_interface_hash)), "Wrong interface hash in ledger.")
  assert_true(identical(candidate$node_status, "pending_independent_review"), "N4 ledger must remain pending.")
  claims <- candidate$claims
  assert_true(is.list(claims) && length(claims) == 14L, "Exactly fourteen claims are required.")
  assert_true(
    identical(vapply(claims, `[[`, character(1), "claim_id"), sprintf("N4-CLM-%03d", seq_len(14L))),
    "Claim ids or order are wrong."
  )
  for (claim in claims) {
    assert_true(
      identical(names(claim), c("claim_id", "equilibrium_ids", "branch", "payoff_date", "claim", "status", "evidence")),
      paste("Wrong claim fields", claim$claim_id)
    )
    assert_true(identical(claim$status, "proved") && identical(claim$payoff_date, "R1"), paste("Wrong claim status/date", claim$claim_id))
    ids <- as_character(claim$equilibrium_ids)
    assert_true(length(ids) > 0L && all(ids %in% expected_equilibrium_ids), paste("Unknown equilibrium id", claim$claim_id))
  }
  assert_true(grepl("nonpivotal off-path", claims[[5L]]$claim, fixed = TRUE), "Corrected m=2 off-path bound claim missing.")
  assert_true(grepl("pooling exists at every prior", claims[[6L]]$claim, fixed = TRUE), "Universal m=2 pooling claim missing.")
  assert_true(grepl("exactly-one-weak-rejector", claims[[8L]]$claim, fixed = TRUE), "High-prior one-rejector claim missing.")
  assert_true(grepl("no none cell", claims[[14L]]$claim, fixed = TRUE), "No-none coverage result missing.")
  invisible(TRUE)
}

validate_ledger <- function(candidate) {
  validate_ledger_semantics(candidate)
  assert_true(identical(candidate, canonical_ledger), "Ledger differs from the exact hashed candidate.")
  invisible(TRUE)
}

validate_interface(interface)
validate_ledger(ledger)

expected_review_record <- function(role, reviewer_id) {
  list(
    reviewer_role = role,
    reviewer_id = reviewer_id,
    verdict = "PASS",
    artifact_hash = paste0("sha256:", expected_interface_hash),
    finding_counts = list(critical = 0L, major = 0L, minor = 0L)
  )
}

expected_reviews <- list(
  expected_review_record("formal_design", "review-n4-formal-2026-08-19-r8"),
  expected_review_record("game_theory", "review-n4-game-2026-08-19-r8")
)

validate_review_text <- function(text, role, reviewer_id) {
  lines <- strsplit(text, "\n", fixed = TRUE)[[1L]]
  assert_true(any(lines == paste0("reviewer_role: ", role)), paste("Wrong reviewer role for", role))
  assert_true(any(lines == paste0("reviewer_id: ", reviewer_id)), paste("Wrong reviewer id for", role))
  assert_true(
    any(lines == paste0("artifact_hash: sha256:", expected_interface_hash)),
    paste("Wrong reviewed interface hash for", role)
  )
  assert_true(any(lines == "verdict: PASS"), paste("Missing PASS for", role))
  assert_true(
    any(lines == "finding_counts: critical=0, major=0, minor=0"),
    paste("Nonzero or malformed finding counts for", role)
  )
  assert_true(any(lines == "none"), paste("Findings are not empty for", role))
  assert_true(!any(grepl("FAIL", lines, fixed = TRUE)), paste("FAIL appears in final review for", role))
  invisible(TRUE)
}

validate_review_text(formal_review_text, "formal_design", "review-n4-formal-2026-08-19-r8")
validate_review_text(game_review_text, "game_theory", "review-n4-game-2026-08-19-r8")

derivation_anchors <- c(
  "The raw term `(1-nu)*q2` is not a belief-proof deviation bound.",
  "L2(nu) = max{k2,e2(nu)}",
  "Pooling is consequently never eliminated by the `m=2` deviation test.",
  "L3(nu)=s(nu)=(1-nu)*z",
  "nonpivotal off-path separation",
  "exactly-one-weak-rejector delay family survives at every prior",
  "a common expected-H",
  "full Cartesian product",
  "P0 is refuted as universal",
  "Every cell has a nonempty correspondence.",
  "beta*C_W^2(nu,U)",
  "pointwise",
  "true pre-proposal prior"
)
for (anchor in derivation_anchors) {
  assert_true(grepl(anchor, derivation_text, fixed = TRUE), paste("Missing derivation anchor:", anchor))
}
assert_true(
  grepl("(1-nu)*a0<=(1-nu)*q2", derivation_text, fixed = TRUE),
  "Round-7 endpoint repair is missing from the derivation."
)
forbidden_anchors <- c(
  "A2(nu) is belief-proof",
  "The only none cell",
  "weak-vote-passive assessment is imposed",
  "stage-undominated voting applies to H"
)
for (anchor in forbidden_anchors) {
  assert_true(!grepl(anchor, derivation_text, fixed = TRUE), paste("Rejected derivation anchor remains:", anchor))
}

calc_values <- function(m, beta, o0, o1, nu) {
  nu2 <- (o1 - o0) / (1 - o0)
  a0 <- beta * (1 - o0) / m
  z <- beta * (1 - o1) / m
  d <- (1 - nu) * a0
  g <- max(d, z)
  p <- 1 - beta * o1 - (m - 1) * z
  u0 <- 1 - beta * o0 - (m - 1) * z
  s <- (1 - nu) * z
  output <- list(nu2 = nu2, a0 = a0, z = z, d = d, g = g, p = p, u0 = u0, s = s)
  if (m == 2L) {
    q2 <- 1 - beta * o0 - a0
    k2 <- max(0, 1 - beta * o1 - a0)
    endpoint_raw <- (1 - nu) * q2
    e2 <- min(z, endpoint_raw)
    L2 <- max(k2, e2)
    output <- c(output, list(q2 = q2, k2 = k2, endpoint_raw = endpoint_raw, e2 = e2, L2 = L2))
  } else {
    output$L3 <- s
  }
  output
}

m2_constructed_cap <- function(v, beta, o0, o1, nu, y, x, r) {
  assert_true(y >= -1e-12 && x >= -1e-12 && r >= -1e-12 && y + x + r <= 1 + 1e-10, "Infeasible m=2 cap test package.")
  if (x < v$a0 - 1e-12) {
    return(v$s)
  }
  if (y >= beta * o0 - 1e-12 && y < beta * o1 - 1e-12 && x >= v$a0 - 1e-12) {
    return(min((1 - nu) * r, v$z))
  }
  if (y < beta * o0 - 1e-12 && x >= v$a0 - 1e-12) {
    return(min(v$d, v$z))
  }
  if (y >= beta * o1 - 1e-12 && x >= v$a0 - 1e-12) {
    return(r)
  }
  stop("Uncovered m=2 proposal in constructed cap.", call. = FALSE)
}

classify_cell <- function(m, nu, nu2, tolerance = 1e-10) {
  if (m == 2L && near(nu, 0, tolerance)) return("N4-CELL-M2-NU0")
  if (m == 2L && nu <= nu2 + tolerance) return("N4-CELL-M2-LOW")
  if (m == 2L) return("N4-CELL-M2-HIGH")
  if (near(nu, 0, tolerance)) return("N4-CELL-MGE3-NU0")
  if (nu <= nu2 + tolerance) return("N4-CELL-MGE3-LOW")
  "N4-CELL-MGE3-HIGH"
}

primitive_pairs <- list(c(0.05, 0.20), c(0.20, 0.60), c(0.60, 0.90))
grid_count <- 0L
seen_cells <- character()
for (m in c(2L, 3L, 4L, 9L)) {
  for (beta in c(0.15, 0.60, 0.90, 0.99)) {
    for (pair in primitive_pairs) {
      o0 <- pair[[1L]]
      o1 <- pair[[2L]]
      nu2 <- (o1 - o0) / (1 - o0)
      nu_grid <- unique(c(0, nu2 / 2, nu2, (nu2 + 1) / 2, 1))
      for (nu in nu_grid) {
        v <- calc_values(m, beta, o0, o1, nu)
        assert_true(v$nu2 > 0 && v$nu2 < 1, "nu_2 left the strict interior.")
        assert_true(v$z > 0 && v$a0 > v$z, "Continuation ordering failed.")
        assert_true(near(v$p, v$z + 1 - beta), "Pooling residual identity failed.")
        assert_true(v$p > v$z && v$u0 > v$p, "Residual ordering failed.")
        assert_true(near(v$g, if (nu <= nu2) v$d else v$z), "N2 continuation branch failed.")
        if (m == 2L) {
          assert_true(v$q2 > 0, "Endpoint residual must be positive.")
          assert_true(v$k2 < v$p, "Forced-passage bound must be below p.")
          assert_true(v$e2 <= v$z + 1e-10, "Endpoint guarantee was not truncated at z.")
          assert_true(v$s <= v$e2 + 1e-10, "Nonpivotal H separation did not fall below e2.")
          assert_true(v$L2 < v$p - 1e-10, "m=2 pooling support became empty.")
          if (near(nu, 0)) assert_true(v$L2 <= v$u0 + 1e-10, "Endpoint low-only support became empty.")
          low_h_boundary <- nu < 1 - 1e-10 && near(v$L2, v$endpoint_raw) && v$endpoint_raw < v$z - 1e-10
          if (low_h_boundary) assert_true(v$L2 < v$p - 1e-10, "An open lower-H boundary emptied pooling support.")
          delay_exists <- v$k2 <= v$g + 1e-10
          assert_true(identical(delay_exists, !(v$k2 > v$g + 1e-10)), "m=2 delay classifier failed.")
          y_grid <- unique(c(0, beta * o0 / 2, beta * o0, (beta * o0 + beta * o1) / 2, beta * o1, min(1, beta * o1 + (1 - beta * o1) / 2)))
          for (y in y_grid) {
            if (y > 1 + 1e-12) next
            x_grid <- unique(c(0, v$z / 2, v$z, (v$z + v$a0) / 2, v$a0, max(0, 1 - y)))
            for (x in x_grid) {
              if (x < -1e-12 || y + x > 1 + 1e-10) next
              residual <- max(0, 1 - y - x)
              for (r in unique(c(0, residual / 2, residual))) {
                cap <- m2_constructed_cap(v, beta, o0, o1, nu, y, x, r)
                assert_true(cap <= v$L2 + 1e-10, "The explicit m=2 response kernel exceeded L2.")
              }
            }
          }
        } else {
          assert_true(near(v$L3, (1 - nu) * v$z), "m>=3 lower bound failed.")
          assert_true(v$L3 <= v$g + 1e-10, "m>=3 delay should always survive.")
          assert_true(v$L3 < v$p - 1e-10, "m>=3 pooling interval is empty.")
        }
        seen_cells <- c(seen_cells, classify_cell(m, nu, nu2))
        grid_count <- grid_count + 1L
      }
    }
  }
}
assert_true(setequal(unique(seen_cells), expected_cell_ids), "Executable coverage missed a cell.")

# Formal-design reviewer regression: the former A2 none-cell classification is false.
review_m2 <- calc_values(m = 2L, beta = 0.9, o0 = 0.2, o1 = 0.6, nu = 0.2)
assert_true(near(review_m2$a0, 0.36), "m=2 reviewer a0 regression failed.")
assert_true(near(review_m2$z, 0.18), "m=2 reviewer z regression failed.")
assert_true(near(review_m2$d, 0.288), "m=2 reviewer d regression failed.")
assert_true(near(review_m2$p, 0.28), "m=2 reviewer p regression failed.")
assert_true(near(review_m2$endpoint_raw, 0.368), "m=2 raw endpoint regression failed.")
assert_true(near(review_m2$e2, 0.18), "m=2 truncated endpoint regression failed.")
assert_true(near(review_m2$k2, 0.10), "m=2 k2 regression failed.")
assert_true(near(review_m2$s, 0.144), "m=2 nonpivotal-separation regression failed.")
assert_true(near(review_m2$L2, 0.18), "m=2 exact lower-bound regression failed.")
assert_true(review_m2$k2 <= review_m2$g, "Reviewer delay counterexample must survive.")
assert_true(review_m2$L2 <= review_m2$p, "Reviewer counterexample must also retain pooling.")
assert_true(0.20 > review_m2$L2 && 0.20 <= review_m2$p, "Round-6 omitted m=2 pooling payoff was not restored.")

# Round-5 game-theory regression: high-N2 deviations must use the low continuation when d<z.
review_m2_high <- calc_values(m = 2L, beta = 0.9, o0 = 0.2, o1 = 0.6, nu = 0.8)
assert_true(near(review_m2_high$d, 0.072), "Round-5 high-N2 d regression failed.")
assert_true(near(review_m2_high$e2, 0.092), "Round-5 high-N2 e2 regression failed.")
assert_true(near(review_m2_high$L2, 0.10), "Round-5 high-N2 L2 regression failed.")
round5_cap_1 <- m2_constructed_cap(review_m2_high, 0.9, 0.2, 0.6, 0.8, 0.30, 0.10, 0.60)
round5_cap_2 <- m2_constructed_cap(review_m2_high, 0.9, 0.2, 0.6, 0.8, 0.30, 0.20, 0.50)
assert_true(near(round5_cap_1, 0.036) && near(round5_cap_2, 0.036), "Round-6 nonpivotal-separation kernel failed.")
assert_true(round5_cap_1 <= review_m2_high$L2 && round5_cap_2 <= review_m2_high$L2, "Round-5 deviations still exceed L2.")

# Game-theory reviewer regression: one weak rejector survives in the high N2 region.
review_m3 <- calc_values(m = 3L, beta = 0.9, o0 = 0.2, o1 = 0.6, nu = 0.8)
review_x <- 0.06
assert_true(review_m3$nu2 < 0.8, "High-region reviewer regression is not high.")
assert_true(near(review_m3$g, 0.12), "m>=3 reviewer g regression failed.")
assert_true(review_x < review_m3$g, "Exactly-one-rejector strict inequality failed.")
assert_true(review_m3$L3 <= review_m3$g, "High-prior delay no-deviation condition failed.")

# Round-6 formal-design regression: off-path nonpivotal H separation lowers both bounds.
review_m3_low <- calc_values(m = 3L, beta = 0.9, o0 = 0.2, o1 = 0.6, nu = 0.2)
assert_true(near(review_m3_low$a0, 0.24) && near(review_m3_low$z, 0.12), "Round-6 m>=3 continuation regression failed.")
assert_true(near(review_m3_low$d, 0.192) && near(review_m3_low$L3, 0.096), "Round-6 m>=3 lower-bound regression failed.")
assert_true(0.15 > review_m3_low$L3 && 0.15 <= review_m3_low$p, "Round-6 omitted m>=3 pooling payoff was not restored.")
rho <- 0.5
weak_no_value <- (1 - rho) * review_m2$z + rho * review_m2$a0
weak_yes_value <- (1 - rho) * review_m2$z + rho * review_m2$z
assert_true(weak_no_value > weak_yes_value, "Nonpivotal H-separation weak-no IC failed.")
assert_true(0.9 * 0.6 > 0.9 * 0.2, "Nonpivotal low-H no IC failed.")

# Round-6 minor regression: H-rejection delay at nu=nu_2 needs x>=z for m=2.
review_m2_tie <- calc_values(m = 2L, beta = 0.9, o0 = 0.2, o1 = 0.6, nu = 0.5)
assert_true(near(review_m2_tie$g, review_m2_tie$z), "nu_2 delay equality regression failed.")
assert_true(0.10 < review_m2_tie$z, "nu_2 weak-yes coordinate counterexample failed.")

# Round-7 minor regression: multiplying a0<q2 by 1-nu gives a weak inequality at nu=1.
review_m2_endpoint <- calc_values(m = 2L, beta = 0.9, o0 = 0.2, o1 = 0.6, nu = 1)
assert_true(near(review_m2_endpoint$d, 0) && near(review_m2_endpoint$e2, 0), "nu=1 endpoint values failed.")
assert_true(
  (1 - 1) * review_m2_endpoint$a0 <= (1 - 1) * review_m2_endpoint$q2,
  "Round-7 weak endpoint inequality failed."
)

# Frozen dependency and reviewed-node audit.
dag_nodes <- dag$nodes
n2_nodes <- Filter(function(node) identical(node$id, "N2"), dag_nodes)
n4_nodes <- Filter(function(node) identical(node$id, "N4"), dag_nodes)
assert_true(length(n2_nodes) == 1L && length(n4_nodes) == 1L, "DAG must contain unique N2 and N4 nodes.")
assert_true(identical(n2_nodes[[1L]]$status, "pass") && isTRUE(n2_nodes[[1L]]$frozen), "N2 is not pass/frozen.")
assert_true(identical(n2_nodes[[1L]]$artifact_hash, paste0("sha256:", expected_n2_hash)), "DAG N2 hash mismatch.")
n4_node <- n4_nodes[[1L]]
expected_n4_fields <- c(
  "id", "name", "round", "institution", "depends_on", "status", "interface",
  "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
  "passed_order", "frozen", "reviews"
)
assert_true(identical(names(n4_node), expected_n4_fields), "Frozen N4 fields or order changed.")
assert_true(
  identical(n4_node$id, "N4") && identical(n4_node$name, "r1_unanimity") &&
    identical(n4_node$round, "R1") && identical(n4_node$institution, "unanimity"),
  "Frozen N4 identity fields changed."
)
assert_true(identical(as_character(n4_node$depends_on), "N2"), "N4 must consume only N2.")
assert_true(identical(n4_node$status, "pass") && identical(n4_node$frozen, TRUE), "N4 is not pass/frozen.")
assert_true(identical(n4_node$interface, canonical_interface), "DAG N4 interface differs from the reviewed artifact.")
assert_true(
  identical(n4_node$artifact_path, "essential_input_n4_r1_unanimity_interface.json") &&
    identical(n4_node$artifact_hash, paste0("sha256:", expected_interface_hash)),
  "DAG N4 artifact pin changed."
)
assert_true(
  identical(n4_node$dependency_hashes, list(N2 = paste0("sha256:", expected_n2_hash))),
  "DAG N4 dependency hash changed."
)
assert_true(
  identical(as.integer(n4_node$started_order), 7L) &&
    identical(as.integer(n4_node$passed_order), 8L) &&
    n2_nodes[[1L]]$passed_order < n4_node$started_order,
  "N4 lifecycle order must be 7/8 after frozen N2."
)
assert_true(identical(n4_node$reviews, expected_reviews), "DAG N4 reviews differ from the two same-hash PASS 0/0/0 records.")

# Every serialized field is bound to the exact reviewed candidate.
interface_paths <- collect_field_paths(canonical_interface)
ledger_paths <- collect_field_paths(canonical_ledger)
mutation_count <- 0L
for (path in interface_paths) {
  candidate <- deep_copy(canonical_interface)
  candidate <- set_path_value(candidate, path, mutated_value(get_path_value(candidate, path)))
  rejected <- inherits(try(validate_interface(candidate), silent = TRUE), "try-error")
  assert_true(rejected, "An interface field mutation was not rejected.")
  mutation_count <- mutation_count + 1L
}
for (path in ledger_paths) {
  candidate <- deep_copy(canonical_ledger)
  candidate <- set_path_value(candidate, path, mutated_value(get_path_value(candidate, path)))
  rejected <- inherits(try(validate_ledger(candidate), silent = TRUE), "try-error")
  assert_true(rejected, "A ledger field mutation was not rejected.")
  mutation_count <- mutation_count + 1L
}

targeted_candidates <- list()
candidate <- deep_copy(canonical_interface)
candidate$correspondence_cells[[2L]]$existence_status <- "none"
targeted_candidates[[1L]] <- candidate
candidate <- deep_copy(canonical_interface)
candidate$correspondence_cells[[3L]]$equilibrium_records[[1L]]$source_interface_hashes$N2 <- "sha256:wrong"
targeted_candidates[[2L]] <- candidate
candidate <- deep_copy(canonical_interface)
candidate$correspondence_cells[[6L]]$equilibrium_records[[1L]]$outcome_distribution$pass_without_hegemon <- "positive"
targeted_candidates[[3L]] <- candidate
candidate <- deep_copy(canonical_interface)
candidate$correspondence_cells[[5L]]$equilibrium_records[[1L]]$selection_status <- "No common Y restriction."
targeted_candidates[[4L]] <- candidate
candidate <- deep_copy(canonical_interface)
candidate$correspondence_cells[[6L]]$equilibrium_records[[1L]]$strategy_profile$proposal_mixing <- "Cross-assessment recombination."
targeted_candidates[[5L]] <- candidate
candidate <- deep_copy(canonical_interface)
candidate$correspondence_cells[[1L]]$equilibrium_records[[1L]]$payoff_date <- "R2"
targeted_candidates[[6L]] <- candidate

for (candidate in targeted_candidates) {
  rejected <- inherits(try(validate_interface(candidate), silent = TRUE), "try-error")
  assert_true(rejected, "A targeted interface mutation was not rejected.")
}

cat("Essential-input N4 verification: PASS\n")
cat("Interface hash:", expected_interface_hash, "\n")
cat("Derivation hash:", expected_derivation_hash, "\n")
cat("Ledger hash:", expected_ledger_hash, "\n")
cat("Frozen N2 hash:", expected_n2_hash, "\n")
cat("Contract hash:", expected_contract_hash, "\n")
cat("DAG hash:", expected_dag_hash, "\n")
cat("Independent reviews: formal_design PASS 0/0/0; game_theory PASS 0/0/0\n")
cat("Coverage cells: 6; complete records: 6; none cells: 0\n")
cat("Numerical primitive/belief grid cases:", grid_count, "\n")
cat("Reviewer regressions: exact nonpivotal-H-separation bounds, expanded pooling supports, nu_2 weak coordinate, and high-prior one-rejector PASS\n")
cat("Exact serialized field mutations rejected:", mutation_count, "\n")
cat("Targeted semantic mutations rejected:", length(targeted_candidates), "\n")
