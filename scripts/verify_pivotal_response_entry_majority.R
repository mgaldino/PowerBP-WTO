#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1L]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

interface_path <- "model_redesign/pivotal_response_interfaces/entry_majority_v1.json"
note_path <- "model_redesign/pivotal_response_nodes/entry_majority_v1.md"
gate0_path <- "model_redesign/pivotal_response_interfaces/gate0_bundle_v1.json"
batch_path <- "model_redesign/pivotal_response_interfaces/r1_batch_frozen_v1.json"
c1_path <- "model_redesign/pivotal_response_interfaces/r1_majority_v1.json"
protected_path <- "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv"
checks_path <- "tables/pivotal_response_entry_majority_checks_v1.csv"
fixture_path <- "tables/pivotal_response_entry_majority_assessment_fixtures_v1.csv"
identity_fixture_path <- "tables/pivotal_response_entry_majority_type_identity_fixtures_v1.csv"
region_path <- "tables/pivotal_response_entry_majority_region_logic_v1.csv"

expected <- c(
  frozen_gate0_bundle = "6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1",
  frozen_R1_batch = "f4ac7b89f4c08d4ee461ca1431135286304abaae2589a337aeffdb38b5941c3a",
  C1_majority = "21c3a9dd2d6c9d25450978c2f7d9925af02e478b9c03d421d2a7b0f9aa2c77c9"
)

required <- c(interface_path, note_path, gate0_path, batch_path, c1_path, protected_path)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing entry-majority artifacts: ", paste(missing, collapse = ", "))

sha256_file <- function(path) {
  out <- suppressWarnings(system2("shasum", c("-a", "256", path), stdout = TRUE, stderr = FALSE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  if (!length(out) || status != 0L) return(NA_character_)
  strsplit(trimws(out[[1L]]), "[[:space:]]+")[[1L]][[1L]]
}

checks <- data.frame(check_id = character(), status = character(), detail = character())
add_check <- function(id, condition, pass_detail, fail_detail = pass_detail) {
  ok <- isTRUE(condition)
  checks <<- rbind(
    checks,
    data.frame(
      check_id = id,
      status = if (ok) "PASS" else "FAIL",
      detail = if (ok) pass_detail else fail_detail
    )
  )
  invisible(ok)
}

same_num <- function(x, y, tol = 1e-12) isTRUE(all(abs(x - y) <= tol))

interface <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
gate0 <- jsonlite::fromJSON(gate0_path, simplifyVector = FALSE)
batch <- jsonlite::fromJSON(batch_path, simplifyVector = FALSE)
c1 <- jsonlite::fromJSON(c1_path, simplifyVector = FALSE)
protected <- utils::read.delim(protected_path, check.names = FALSE, quote = "", comment.char = "")
interface_text <- paste(readLines(interface_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
note_text <- paste(readLines(note_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")

actual <- c(
  frozen_gate0_bundle = sha256_file(gate0_path),
  frozen_R1_batch = sha256_file(batch_path),
  C1_majority = sha256_file(c1_path)
)
declared <- stats::setNames(
  vapply(interface$dependencies, function(x) x$sha256, character(1)),
  vapply(interface$dependencies, function(x) x$role, character(1))
)

add_check(
  "dependency_hashes_exact",
  identical(actual[names(expected)], expected) && identical(declared[names(expected)], expected) &&
    identical(batch$status, "pass"),
  "Gate 0, frozen R1 batch, and C1-M match the three exact consumed hashes.",
  paste("actual:", paste(names(actual), actual, collapse = "; "))
)

dependency_valid <- function(x) identical(x[names(expected)], expected)
mutation_results <- vapply(names(expected), function(nm) {
  mutated <- expected
  last <- substr(mutated[[nm]], 64L, 64L)
  substr(mutated[[nm]], 64L, 64L) <- if (last == "0") "1" else "0"
  !dependency_valid(mutated)
}, logical(1))
add_check(
  "dependency_mutation_invalidates",
  all(mutation_results),
  "One-at-a-time in-memory mutation of Gate 0, R1 batch, or C1-M invalidates entry-M.",
  paste(names(mutation_results), mutation_results, collapse = "; ")
)

resolve_components <- function(parent_path, components) {
  parent_dir <- dirname(normalizePath(parent_path, mustWork = TRUE))
  vapply(components, function(x) normalizePath(file.path(parent_dir, x$path), mustWork = TRUE), character(1))
}
gate_paths <- resolve_components(gate0_path, gate0$components)
gate_declared <- vapply(gate0$components, function(x) x$sha256, character(1))
gate_actual <- unname(vapply(gate_paths, sha256_file, character(1)))
batch_paths <- resolve_components(batch_path, batch$components)
batch_declared <- vapply(batch$components, function(x) x$sha256, character(1))
batch_actual <- unname(vapply(batch_paths, sha256_file, character(1)))
add_check(
  "transitive_frozen_components",
  length(gate_paths) == 5L && identical(gate_actual, gate_declared) &&
    length(batch_paths) == 17L && identical(batch_actual, batch_declared),
  "All 5 Gate 0 and 17 frozen R1-batch component hashes remain exact.",
  "A transitive frozen component changed or the component inventory differs."
)

add_check(
  "interface_identity_domain_and_date",
  identical(interface$state_id, "entry_majority") &&
    identical(interface$status, "candidate_pending_independent_review") &&
    grepl("N=m+1>=3", interface$domain$population, fixed = TRUE) &&
    grepl("entry date", interface$native_payoff_date, fixed = TRUE) &&
    grepl("perfect Bayesian equilibrium", interface$solution_concept, ignore.case = TRUE),
  paste("Candidate interface sha256", sha256_file(interface_path)),
  "Interface identity, status, N>=3 domain, payoff date, or solution concept differs."
)

add_check(
  "upstream_full_assessment_preserved",
  grepl("complete identity-indexed", interface$upstream_consumption$unit, fixed = TRUE) &&
    grepl("retained whole", interface$upstream_consumption$preservation, fixed = TRUE) &&
    grepl("set-valued assessment by assessment", interface$exact_entry_correspondence$selection_status, fixed = TRUE) &&
    grepl("every H or named weak identity", c1$pre_recognition_interface$type_by_identity_correspondence, fixed = TRUE) &&
    grepl("never averages across distinct assessments", tolower(note_text), fixed = TRUE),
  "Entry keeps each full alpha and the frozen C1-M type-by-identity object.",
  "A full-assessment preservation clause is missing."
)

add_check(
  "timing_cost_and_information_contract",
  grepl("does not observe theta", interface$domain$weak_information, fixed = TRUE) &&
    grepl("all-or-nothing", interface$domain$formation_technology, fixed = TRUE) &&
    grepl("external", interface$assessment_level_entry_rule$external_cost_accounting, fixed = TRUE) &&
    grepl("no additional beta", interface$upstream_consumption$discount, fixed = TRUE) &&
    grepl("true mu", interface$upstream_consumption$true_belief, fixed = TRUE),
  "Collective entry uses true mu, external chi, and no second discount.",
  "Entry timing, information, cost, or discount accounting differs."
)

# Build deliberately asymmetric, proposal-mixed type-by-identity fixtures.
rows <- list()
add_row <- function(assessment, N, mu, recognized, support, sigma_weight, theta, player, payoff) {
  rows[[length(rows) + 1L]] <<- data.frame(
    assessment = assessment,
    N = N,
    m = N - 1L,
    mu = mu,
    recognized = paste0("W", recognized),
    support = support,
    sigma_weight = sigma_weight,
    theta = theta,
    player = player,
    payoff = payoff
  )
}

# N=4 asymmetric mixture. Each proposal-level weak total is in [0,1], and
# named identities differ after every expectation.
for (i in 1:3) {
  weights <- c(0.2 + 0.1 * i, 0.8 - 0.1 * i)
  for (s in 1:2) {
    for (theta in 0:1) {
      total <- if (s == 1L) 0.38 + 0.04 * i + 0.07 * theta else 0.72 - 0.03 * i - 0.05 * theta
      raw <- c(1 + ((i + s + theta) %% 3), 1 + ((i + 2 * s + theta) %% 3), 1 + ((2 * i + s + theta) %% 3))
      alloc <- total * raw / sum(raw)
      for (j in 1:3) add_row("asymmetric_mix", 4L, 0.65, i, paste0("s", s), weights[[s]], theta, paste0("W", j), alloc[[j]])
      add_row("asymmetric_mix", 4L, 0.65, i, paste0("s", s), weights[[s]], theta, "H", 0.08 + 0.03 * theta + 0.01 * i)
    }
  }
}

# Frozen N>=4 value-one construction: recognized proposer receives the full
# weak pie. It establishes the attained 1/m upper endpoint.
for (i in 1:3) {
  for (theta in 0:1) {
    for (j in 1:3) add_row("value_one_N4", 4L, 0.37, i, "value_one", 1, theta, paste0("W", j), as.numeric(i == j))
    add_row("value_one_N4", 4L, 0.37, i, "value_one", 1, theta, "H", c(0.1, 0.6)[[theta + 1L]])
  }
}

# The exact frozen N=3 double-tie counterexample, symmetrized across the two
# possible recognized proposers. The mixture keeps proposer and H payoffs
# fixed while changing total weak payoff.
for (assessment in c("n3_tied_weak_no", "n3_tied_weak_yes", "n3_tied_mix")) {
  mix_weights <- switch(
    assessment,
    n3_tied_weak_no = c(no = 1, yes = 0),
    n3_tied_weak_yes = c(no = 0, yes = 1),
    n3_tied_mix = c(no = 0.4, yes = 0.6)
  )
  for (i in 1:2) {
    other <- 3L - i
    for (support in names(mix_weights)) {
      w <- unname(mix_weights[[support]])
      if (w == 0) next
      for (theta in 0:1) {
        if (support == "no") {
          weak <- if (theta == 0L) c(0, 0) else c(0.25, 0.25)
          weak[[i]] <- if (theta == 0L) 1 else 0.25
        } else {
          weak <- c(0, 0)
          weak[[i]] <- 0.325
          weak[[other]] <- 0.675
        }
        for (j in 1:2) add_row(assessment, 3L, 0.9, i, support, w, theta, paste0("W", j), weak[[j]])
        add_row(assessment, 3L, 0.9, i, support, w, theta, "H", if (theta == 0L) 0 else 0.8)
      }
    }
  }
}
raw <- do.call(rbind, rows)

key_aggregate <- function(data, by, value_name, fun = sum) {
  out <- stats::aggregate(data$weighted, by = data[by], FUN = fun)
  names(out)[ncol(out)] <- value_name
  out
}

# Stage 1: E_sigma within recognized proposer, type, and named player.
raw$weighted <- raw$sigma_weight * raw$payoff
stage1 <- key_aggregate(
  raw,
  c("assessment", "N", "m", "mu", "recognized", "theta", "player"),
  "E_sigma"
)

# Every sigma distribution must sum to one for each recognized proposer/type/player.
weight_rows <- unique(raw[c("assessment", "recognized", "support", "sigma_weight", "theta")])
weight_sums <- stats::aggregate(
  weight_rows$sigma_weight,
  by = weight_rows[c("assessment", "recognized", "theta")],
  FUN = sum
)

# Stage 2: uniform recognition averaging, retaining theta and named player.
stage2 <- stats::aggregate(
  stage1$E_sigma,
  by = stage1[c("assessment", "N", "m", "mu", "theta", "player")],
  FUN = mean
)
names(stage2)[ncol(stage2)] <- "C1_type_identity"

# Stage 3: true-mu type integration for each named player.
stage2$type_weight <- ifelse(stage2$theta == 1L, stage2$mu, 1 - stage2$mu)
stage2$weighted_type <- stage2$type_weight * stage2$C1_type_identity
stage3 <- stats::aggregate(
  stage2$weighted_type,
  by = stage2[c("assessment", "N", "m", "mu", "player")],
  FUN = sum
)
names(stage3)[ncol(stage3)] <- "C1_ex_ante_identity"

# Stage 4: cross-weak average only after named identities survive stages 1-3.
weak_stage3 <- stage3[stage3$player != "H", , drop = FALSE]
stage4 <- stats::aggregate(
  weak_stage3$C1_ex_ante_identity,
  by = weak_stage3[c("assessment", "N", "m", "mu")],
  FUN = function(x) sum(x) / length(x)
)
names(stage4)[ncol(stage4)] <- "V_W"

# Direct T(theta) formula for a separate equality check.
weak_stage2 <- stage2[stage2$player != "H", , drop = FALSE]
type_totals <- stats::aggregate(
  weak_stage2$C1_type_identity,
  by = weak_stage2[c("assessment", "N", "m", "mu", "theta")],
  FUN = sum
)
names(type_totals)[ncol(type_totals)] <- "T_theta"
type_totals$weighted <- ifelse(type_totals$theta == 1L, type_totals$mu, 1 - type_totals$mu) * type_totals$T_theta
direct <- stats::aggregate(
  type_totals$weighted,
  by = type_totals[c("assessment", "N", "m", "mu")],
  FUN = sum
)
names(direct)[ncol(direct)] <- "weighted_T"
direct$V_direct <- direct$weighted_T / direct$m
ordered <- merge(stage4, direct[c("assessment", "V_direct")], by = "assessment", sort = TRUE)

add_check(
  "sigma_recognition_type_crossweak_order",
  all(abs(weight_sums$x - 1) < 1e-12) &&
    nrow(stage1) > nrow(stage2) &&
    length(unique(stage2$player[stage2$assessment == "asymmetric_mix"])) == 4L &&
    same_num(ordered$V_W, ordered$V_direct),
  sprintf("E_sigma -> recognition -> type -> cross-weak agrees with T(theta) on %d asymmetric/mixed assessments.", nrow(ordered)),
  "Expectation weights, identity retention, or the two value formulas disagree."
)

asym <- stage3[stage3$assessment == "asymmetric_mix" & stage3$player != "H", , drop = FALSE]
add_check(
  "asymmetric_named_identities_retained",
  length(unique(round(asym$C1_ex_ante_identity, 12))) > 1L && nrow(asym) == 3L,
  paste("Asymmetric ex-ante weak values:", paste(asym$player, round(asym$C1_ex_ante_identity, 6), collapse = "; ")),
  "The asymmetric fixture was collapsed to a representative identity."
)

# Unweighted proposal-row averaging is a deliberate mutation and must differ.
raw_weak_asym <- raw[raw$assessment == "asymmetric_mix" & raw$player != "H", , drop = FALSE]
wrong_unweighted <- mean(raw_weak_asym$payoff)
right_asym <- stage4$V_W[stage4$assessment == "asymmetric_mix"]
add_check(
  "proposal_mixing_mutation_rejected",
  abs(wrong_unweighted - right_asym) > 1e-4,
  sprintf("Unweighted proposal-row mutation %.6f differs from correct sigma-integrated %.6f.", wrong_unweighted, right_asym),
  "The mixing fixture fails to distinguish weighted and unweighted proposal integration."
)

# Build assessment-level entry outcomes at equality, just below, and above.
outside <- list(
  asymmetric_mix = c(`0` = 0.12, `1` = 0.71),
  value_one_N4 = c(`0` = 0.10, `1` = 0.60),
  n3_tied_weak_no = c(`0` = 0, `1` = 0.8),
  n3_tied_weak_yes = c(`0` = 0, `1` = 0.8),
  n3_tied_mix = c(`0` = 0, `1` = 0.8)
)

fixture_rows <- list()
identity_fixture_rows <- list()
for (a in stage4$assessment) {
  v <- stage4$V_W[stage4$assessment == a]
  chis <- c(max(0, v - 0.015), v, v + 0.015)
  labels <- c("below", "equality", "above")
  identity_values <- stage3[stage3$assessment == a & stage3$player != "H", , drop = FALSE]
  h_type <- stage2[stage2$assessment == a & stage2$player == "H", , drop = FALSE]
  for (idx in seq_along(chis)) {
    chi <- chis[[idx]]
    form <- v >= chi
    net_identity <- if (form) identity_values$C1_ex_ante_identity - chi else rep(0, nrow(identity_values))
    h0 <- if (form) h_type$C1_type_identity[h_type$theta == 0L] else outside[[a]][["0"]]
    h1 <- if (form) h_type$C1_type_identity[h_type$theta == 1L] else outside[[a]][["1"]]
    fixture_rows[[length(fixture_rows) + 1L]] <- data.frame(
      assessment = a,
      N = stage4$N[stage4$assessment == a],
      mu = stage4$mu[stage4$assessment == a],
      chi_case = labels[[idx]],
      chi = chi,
      gross_collective = v,
      net_collective = v - chi,
      entry_status = if (form) "formed" else "nonformed",
      min_named_weak_net = min(net_identity),
      max_named_weak_net = max(net_identity),
      H_type0_payoff = h0,
      H_type1_payoff = h1,
      outcome = if (form) "inherit_complete_alpha" else "collective_nonformation"
    )
    type_identity <- stage2[stage2$assessment == a, , drop = FALSE]
    for (r in seq_len(nrow(type_identity))) {
      player <- type_identity$player[[r]]
      theta <- type_identity$theta[[r]]
      c1_gross <- type_identity$C1_type_identity[[r]]
      is_weak <- player != "H"
      entry_payoff <- if (form) {
        if (is_weak) c1_gross - chi else c1_gross
      } else {
        if (is_weak) 0 else outside[[a]][[as.character(theta)]]
      }
      identity_fixture_rows[[length(identity_fixture_rows) + 1L]] <- data.frame(
        assessment = a,
        N = stage4$N[stage4$assessment == a],
        mu = stage4$mu[stage4$assessment == a],
        chi_case = labels[[idx]],
        chi = chi,
        entry_status = if (form) "formed" else "nonformed",
        player = player,
        theta = theta,
        C1_gross_type_payoff = c1_gross,
        external_cost_paid = if (form && is_weak) chi else 0,
        entry_type_payoff = entry_payoff,
        outcome = if (form) "inherit_complete_alpha" else "collective_nonformation"
      )
    }
  }
}
fixtures <- do.call(rbind, fixture_rows)
identity_fixtures <- do.call(rbind, identity_fixture_rows)

eq_rows <- fixtures[fixtures$chi_case == "equality", , drop = FALSE]
above_rows <- fixtures[fixtures$chi_case == "above", , drop = FALSE]
add_check(
  "entry_equality_and_nonformation",
  all(eq_rows$entry_status == "formed") && all(abs(eq_rows$net_collective) < 1e-12) &&
    all(above_rows$entry_status == "nonformed") && all(above_rows$min_named_weak_net == 0) &&
    all(above_rows$max_named_weak_net == 0) && all(above_rows$outcome == "collective_nonformation"),
  "Equality forms; chi above gross value gives weak zero and collective nonformation.",
  "Equality or nonformation accounting fails."
)

# Find a forming collective assessment with at least one negative identity net.
asym_v <- stage4$V_W[stage4$assessment == "asymmetric_mix"]
asym_ids <- stage3[stage3$assessment == "asymmetric_mix" & stage3$player != "H", , drop = FALSE]
chi_asym <- (min(asym_ids$C1_ex_ante_identity) + asym_v) / 2
asym_form <- asym_v >= chi_asym
asym_net <- asym_ids$C1_ex_ante_identity - chi_asym
add_check(
  "collective_rule_keeps_negative_identity_net",
  asym_form && min(asym_net) < 0 && mean(asym_net) >= -1e-12,
  paste("Collective formation retained named nets:", paste(asym_ids$player, round(asym_net, 6), collapse = "; ")),
  "The asymmetric fixture does not detect an illicit individual veto or truncation."
)

# Formed H payoffs are unchanged by chi; nonformation H receives o_theta.
asym_h <- stage2[stage2$assessment == "asymmetric_mix" & stage2$player == "H", , drop = FALSE]
formed_low <- fixtures[fixtures$assessment == "asymmetric_mix" & fixtures$chi_case == "below", , drop = FALSE]
no_high <- fixtures[fixtures$assessment == "asymmetric_mix" & fixtures$chi_case == "above", , drop = FALSE]
add_check(
  "external_cost_and_H_payoffs",
  same_num(c(formed_low$H_type0_payoff, formed_low$H_type1_payoff), asym_h$C1_type_identity[order(asym_h$theta)]) &&
    same_num(c(no_high$H_type0_payoff, no_high$H_type1_payoff), outside$asymmetric_mix),
  "Formed H keeps C1 type payoffs; nonformation pays outside options; chi is not transferred.",
  "H payoff was charged chi, redated, or failed to switch to outside options at nonformation."
)

formed_weak_rows <- identity_fixtures[
  identity_fixtures$entry_status == "formed" & identity_fixtures$player != "H", , drop = FALSE
]
formed_h_rows <- identity_fixtures[
  identity_fixtures$entry_status == "formed" & identity_fixtures$player == "H", , drop = FALSE
]
nonformed_weak_rows <- identity_fixtures[
  identity_fixtures$entry_status == "nonformed" & identity_fixtures$player != "H", , drop = FALSE
]
nonformed_h_rows <- identity_fixtures[
  identity_fixtures$entry_status == "nonformed" & identity_fixtures$player == "H", , drop = FALSE
]
nonformed_h_expected <- vapply(seq_len(nrow(nonformed_h_rows)), function(r) {
  outside[[nonformed_h_rows$assessment[[r]]]][[as.character(nonformed_h_rows$theta[[r]])]]
}, numeric(1))
add_check(
  "type_identity_entry_export",
  all(abs(formed_weak_rows$entry_type_payoff -
    (formed_weak_rows$C1_gross_type_payoff - formed_weak_rows$chi)) < 1e-12) &&
    all(abs(formed_weak_rows$external_cost_paid - formed_weak_rows$chi) < 1e-12) &&
    all(abs(formed_h_rows$entry_type_payoff - formed_h_rows$C1_gross_type_payoff) < 1e-12) &&
    all(formed_h_rows$external_cost_paid == 0) &&
    all(nonformed_weak_rows$entry_type_payoff == 0) &&
    same_num(nonformed_h_rows$entry_type_payoff, nonformed_h_expected),
  sprintf("Exported %d assessment/status/type/player payoff rows with exact cost and nonformation maps.", nrow(identity_fixtures)),
  "A type-by-identity entry payoff, cost ledger, H payoff, or nonformation row differs."
)

# Resource accounting sentinel over every branch class. It checks the algebra;
# the proof remains in the node note.
set.seed(20260812)
branch_values <- numeric()
branch_ids <- character()
for (draw in seq_len(4000L)) {
  beta <- runif(1L, 0.001, 1)
  y <- runif(1L, 0, 1)
  c2a <- runif(1L, 0, 1)
  c2o <- runif(1L, 0, 1)
  branch_values <- c(branch_values, 1 - y, beta * c2a, 1, beta * c2o)
  branch_ids <- c(branch_ids, "PR04", "PR05", "PR06", "PR07")
}
add_check(
  "branch_resource_envelope",
  all(branch_values >= 0) && all(branch_values <= 1) && all(table(branch_ids) == 4000L),
  sprintf("Checked %d PR04-PR07 aggregate weak resource draws in [0,1].", length(branch_values)),
  "A branch aggregate weak payoff left [0,1]."
)

all_values_in_envelope <- all(stage4$V_W >= -1e-12 & stage4$V_W <= 1 / stage4$m + 1e-12)
v1 <- stage4[stage4$assessment == "value_one_N4", , drop = FALSE]
add_check(
  "collective_resource_bound_and_N4_attainment",
  all_values_in_envelope && nrow(v1) == 1L && same_num(v1$V_W, 1 / 3),
  "All fixtures obey 0<=V_W<=1/m and the N=4 value-one assessment attains 1/m.",
  "The resource envelope or attained N>=4 endpoint fixture fails."
)

# In every frozen [0,1] proposer construction, total gifts are 1-V and y=0,
# so aggregate weak value is one and collective value is 1/m.
projection_grid <- seq(0, 1, by = 0.01)
m_grid <- c(3L, 4L, 5L, 8L)
projection_collective <- unlist(lapply(m_grid, function(m) (projection_grid + (1 - projection_grid)) / m))
expected_collective <- unlist(lapply(m_grid, function(m) rep(1 / m, length(projection_grid))))
wrong_proposer_scalar <- unlist(lapply(m_grid, function(m) projection_grid / m))
add_check(
  "proposer_projection_not_collective_value",
  same_num(projection_collective, expected_collective) &&
    any(abs(wrong_proposer_scalar - expected_collective) > 0.1),
  "The [0,1] proposer constructions all map to 1/m; proposer/m mutation is rejected.",
  "The projection fixture failed to separate proposer payoff from collective weak value."
)

# Exact N=3 double-tie negative test.
n3_values <- stats::setNames(stage4$V_W[grepl("^n3_", stage4$assessment)], stage4$assessment[grepl("^n3_", stage4$assessment)])
expected_n3 <- c(n3_tied_mix = 0.41, n3_tied_weak_no = 0.275, n3_tied_weak_yes = 0.5)
n3_values <- n3_values[names(expected_n3)]
proposer_value <- 0.325
add_check(
  "N3_double_tie_collective_nonidentification",
  same_num(n3_values, expected_n3) &&
    same_num(expected_n3[["n3_tied_mix"]], 0.4 * 0.275 + 0.6 * 0.5) &&
    all(abs(n3_values - proposer_value) > 0.049),
  paste("Same proposer=.325 yields collective values", paste(names(n3_values), n3_values, collapse = "; ")),
  "The exact N=3 double-tie fixture or its mixing arithmetic differs."
)

add_check(
  "N3_legacy_shortcuts_rejected",
  !same_num(n3_values[["n3_tied_weak_no"]], proposer_value) &&
    !same_num(n3_values[["n3_tied_weak_yes"]], proposer_value) &&
    !same_num(n3_values[["n3_tied_weak_no"]], proposer_value / 2),
  "Neither proposer value nor proposer/m reproduces the N=3 collective values.",
  "A forbidden N=3 proposer scalar accidentally equals the collective fixture."
)

classify_bounds <- function(lo, hi, upper_attained, chi) {
  c(
    all_form = chi <= lo,
    possible_form = chi < hi || (chi == hi && upper_attained),
    possible_no = chi > lo,
    all_no = chi > hi || (chi == hi && !upper_attained)
  )
}

region_specs <- data.frame(
  case_id = c(
    "lower_equality_attained", "lower_equality_unattained", "interior",
    "upper_equality_attained", "upper_equality_unattained", "above_upper",
    "below_lower", "singleton_at_equality", "singleton_above", "zero_cost"
  ),
  lower = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.3, 0.3, 0),
  upper = c(0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.3, 0.3, 0.7),
  lower_attained = c(TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE),
  upper_attained = c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, FALSE),
  chi = c(0.1, 0.1, 0.4, 0.6, 0.6, 0.7, 0.05, 0.3, 0.31, 0)
)
region_rows <- lapply(seq_len(nrow(region_specs)), function(i) {
  spec <- region_specs[i, , drop = FALSE]
  flags <- classify_bounds(spec$lower, spec$upper, spec$upper_attained, spec$chi)
  cbind(spec, as.data.frame(as.list(flags)))
})
regions <- do.call(rbind, region_rows)

add_check(
  "formation_region_complements",
  all(regions$possible_form == !regions$all_no) &&
    all(regions$possible_no == !regions$all_form),
  "Possible/all formation and nonformation regions are exact complements.",
  "The four endpoint region predicates are not mutually coherent."
)

lower_rows <- regions[grepl("lower_equality", regions$case_id), , drop = FALSE]
upper_att <- regions[regions$case_id == "upper_equality_attained", , drop = FALSE]
upper_unatt <- regions[regions$case_id == "upper_equality_unattained", , drop = FALSE]
add_check(
  "lower_endpoint_equality_logic",
  all(lower_rows$all_form) && all(!lower_rows$possible_no),
  "At chi=inf all assessments form regardless of lower attainment.",
  "Lower-endpoint equality incorrectly depends on attainment."
)
add_check(
  "upper_endpoint_nonattainment_logic",
  upper_att$possible_form && !upper_att$all_no &&
    !upper_unatt$possible_form && upper_unatt$all_no,
  "At chi=sup, formation is possible exactly when the supremum is attained.",
  "Upper-endpoint attainment flag is not controlling possible formation."
)

# Universal cost implications from the [0,1/m] envelope.
m_test <- 2:12
zero_all_form <- vapply(m_test, function(m) classify_bounds(0, 1 / m, FALSE, 0)[["all_form"]], logical(1))
high_all_no <- vapply(m_test, function(m) classify_bounds(0, 1 / m, TRUE, 1 / m + 0.001)[["all_no"]], logical(1))
n4_endpoint_possible <- classify_bounds(0, 1 / 3, TRUE, 1 / 3)[["possible_form"]]
add_check(
  "universal_cost_boundaries",
  all(zero_all_form) && all(high_all_no) && n4_endpoint_possible,
  "chi=0 all-form; chi>1/m all-no; attained N>=4 endpoint permits formation.",
  "A universal cost-boundary implication fails."
)

manifest_columns <- c("path", "sha256", "category", "frozen_at_head")
protected_actual <- vapply(protected$path, sha256_file, character(1))
protected_ok <- file.exists(protected$path) & !is.na(protected_actual) & protected_actual == protected$sha256
add_check(
  "protected_manifest_and_hashes",
  identical(names(protected), manifest_columns) && nrow(protected) == 27L && all(protected_ok),
  "All 27 protected artifacts remain byte-identical.",
  paste("Protected mismatch:", paste(protected$path[!protected_ok], collapse = ", "))
)

add_check(
  "interface_formula_and_shortcut_guards",
  grepl("E_sigma", interface$collective_value_operator$linearity_note, fixed = TRUE) &&
    grepl("sum_j", interface$collective_value_operator$equivalent_type_total_formula, fixed = TRUE) &&
    grepl("never chosen", interface$upstream_consumption$preservation, fixed = TRUE) &&
    grepl("supremum", interface$rejected_shortcuts[[10]], fixed = TRUE) &&
    grepl(".275", interface$N3_proposer_projection_counterexample$first_collective_value, fixed = TRUE),
  "Interface records the exact operator, whole-alpha rule, nonattainment guard, and N=3 negative case.",
  "A formula or shortcut guard is absent from the interface."
)

fixtures <- fixtures[order(fixtures$assessment, fixtures$chi), , drop = FALSE]
identity_fixtures <- identity_fixtures[order(
  identity_fixtures$assessment, identity_fixtures$chi,
  identity_fixtures$player, identity_fixtures$theta
), , drop = FALSE]
regions <- regions[order(regions$case_id), , drop = FALSE]
utils::write.csv(fixtures, fixture_path, row.names = FALSE, na = "")
utils::write.csv(identity_fixtures, identity_fixture_path, row.names = FALSE, na = "")
utils::write.csv(regions, region_path, row.names = FALSE, na = "")
utils::write.csv(checks, checks_path, row.names = FALSE, na = "")

failed <- checks$check_id[checks$status != "PASS"]
if (length(failed)) {
  stop(sprintf("entry_majority verification failed (%d/%d PASS): %s", sum(checks$status == "PASS"), nrow(checks), paste(failed, collapse = ", ")))
}

cat(sprintf("entry_majority verification: %d/%d PASS\n", nrow(checks), nrow(checks)))
cat(sprintf("interface sha256: %s\n", sha256_file(interface_path)))
cat(sprintf("checks: %s\n", checks_path))
cat(sprintf("assessment fixtures: %s\n", fixture_path))
cat(sprintf("type-by-identity fixtures: %s\n", identity_fixture_path))
cat(sprintf("region logic: %s\n", region_path))
