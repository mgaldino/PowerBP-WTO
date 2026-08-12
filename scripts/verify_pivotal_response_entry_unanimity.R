#!/usr/bin/env Rscript

# Mechanical checks for the candidate entry_unanimity interface. Analytic
# proofs are in model_redesign/pivotal_response_nodes/entry_unanimity_v1.md.

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1]], mustWork = TRUE)
setwd(repo_root)

if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

tol <- 1e-10
interface_path <- "model_redesign/pivotal_response_interfaces/entry_unanimity_v1.json"
note_path <- "model_redesign/pivotal_response_nodes/entry_unanimity_v1.md"
gate0_path <- "model_redesign/pivotal_response_interfaces/gate0_bundle_v1.json"
batch_path <- "model_redesign/pivotal_response_interfaces/r1_batch_frozen_v1.json"
c1_path <- "model_redesign/pivotal_response_interfaces/r1_unanimity_v1.json"
protected_path <- "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv"
checks_path <- "tables/pivotal_response_entry_unanimity_checks.csv"
fixture_path <- "tables/pivotal_response_entry_unanimity_assessment_fixtures_v1.csv"
realized_path <- "tables/pivotal_response_entry_unanimity_realized_payoffs_v1.csv"
endpoint_path <- "tables/pivotal_response_entry_unanimity_endpoint_logic_v1.csv"

required <- c(interface_path, note_path, gate0_path, batch_path, c1_path, protected_path)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing required artifacts: ", paste(missing, collapse = ", "))

expected_hashes <- c(
  gate0 = "6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1",
  batch = "f4ac7b89f4c08d4ee461ca1431135286304abaae2589a337aeffdb38b5941c3a",
  c1 = "37aae1bfe7921c6c90aff5d05ed301f8729c2b899477991619bcf0cb6c96e8b5"
)

sha256_file <- function(path) {
  out <- suppressWarnings(system2("shasum", c("-a", "256", path), stdout = TRUE, stderr = FALSE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  if (!length(out) || status != 0L) return(NA_character_)
  strsplit(trimws(out[[1]]), "[[:space:]]+")[[1]][[1]]
}

checks <- data.frame(test_id = character(), status = character(), detail = character())
add_check <- function(id, condition, pass_detail, fail_detail = pass_detail) {
  ok <- isTRUE(condition)
  checks <<- rbind(
    checks,
    data.frame(
      test_id = id,
      status = if (ok) "PASS" else "FAIL",
      detail = if (ok) pass_detail else fail_detail
    )
  )
  invisible(ok)
}

near <- function(x, y, tolerance = tol) {
  length(x) == length(y) && all(is.finite(x)) && all(is.finite(y)) &&
    max(abs(x - y)) <= tolerance
}

dependency_valid <- function(gate0_hash, batch_hash, c1_hash) {
  identical(unname(c(gate0_hash, batch_hash, c1_hash)), unname(expected_hashes))
}

interface <- jsonlite::fromJSON(interface_path, simplifyVector = TRUE)
gate0 <- jsonlite::fromJSON(gate0_path, simplifyVector = TRUE)
batch <- jsonlite::fromJSON(batch_path, simplifyVector = TRUE)
c1 <- jsonlite::fromJSON(c1_path, simplifyVector = TRUE)

observed_hashes <- c(
  gate0 = sha256_file(gate0_path),
  batch = sha256_file(batch_path),
  c1 = sha256_file(c1_path)
)

add_check(
  "EU1_DEPENDENCY_HASHES_EXACT",
  dependency_valid(observed_hashes[["gate0"]], observed_hashes[["batch"]], observed_hashes[["c1"]]),
  "Gate 0, the frozen R1 batch, and C1-U match the three exact authorized hashes."
)

add_check(
  "EU2_INTERFACE_PROVENANCE_EXACT",
  identical(interface$provenance$frozen_gate0_bundle_sha256, expected_hashes[["gate0"]]) &&
    identical(interface$provenance$frozen_r1_batch_sha256, expected_hashes[["batch"]]) &&
    identical(interface$provenance$frozen_c1_unanimity_sha256, expected_hashes[["c1"]]),
  "The candidate records the exact three dependency hashes."
)

add_check(
  "EU3_INTERFACE_IDENTITY_AND_STATUS",
  identical(interface$artifact_id, "pivotal-response-entry-unanimity-v1") &&
    identical(interface$state_id, "entry_unanimity") &&
    identical(interface$status, "candidate_pending_independent_review") &&
    identical(interface$institutional_rule, "unanimity") &&
    identical(interface$solution_concept, "perfect Bayesian equilibrium"),
  "Artifact identity, institutional rule, PBE concept, and candidate status are explicit."
)

add_check(
  "EU4_FROZEN_BATCH_IS_APPROVED_EXPORT",
  identical(batch$batch_close$status, "pass") &&
    identical(batch$batch_close$validated_common_export_domain, "N>=3") &&
    identical(batch$consumer_contract$entry_rule,
              "entry is evaluated assessment by assessment; this freeze makes no formation or institutional-comparison claim") &&
    grepl("full assessment-indexed", batch$consumer_contract$object, fixed = TRUE),
  "The exact batch authorizes assessment-by-assessment entry on N>=3 without scalarization."
)

add_check(
  "EU5_C1_PAYLOAD_IS_SUFFICIENT",
  identical(c1$pre_recognition_C1_correspondence$validated_domain,
            "N>=3 after independent acceptance of this repaired candidate") &&
    grepl("separately for every player identity", c1$pre_recognition_C1_correspondence$within_recognizer_type_payoff, fixed = TRUE) &&
    grepl("same sigma_i", c1$pre_recognition_C1_correspondence$outcome_distribution, fixed = TRUE) &&
    identical(c1$claim_status$validated_exportable_domain, "N>=3"),
  "C1-U exports E_sigma, type-by-identity payoffs, H coordinates, and aligned outcomes on N>=3."
)

add_check(
  "EU6_NO_REDERIVATION_OR_REDISCOUNT",
  isTRUE(interface$dependency_discipline$no_r1_or_c2_rederivation) &&
    isTRUE(interface$dependency_discipline$no_scalar_selection) &&
    isTRUE(as.numeric(interface$dependency_discipline$downstream_discount_application_count) == 0) &&
    grepl("no further discount", paste(readLines(note_path, warn = FALSE), collapse = " "), fixed = TRUE),
  "Entry consumes frozen C1 literally, selects no alpha, and applies no new beta."
)

# -------------------------------------------------------------------------
# Synthetic complete-assessment fixtures
# -------------------------------------------------------------------------

build_fixture <- function() {
  out <- data.frame()
  for (alpha in c("alpha_A", "alpha_B")) {
    for (recognizer in 1:3) {
      sigma_first <- 0.2 + 0.1 * recognizer
      for (support in 1:2) {
        sigma <- if (support == 1) sigma_first else 1 - sigma_first
        for (theta in 0:1) {
          current_A <- 0.20 + 0.01 * recognizer + 0.02 * support + 0.03 * theta
          optout_A <- 0.12 + 0.02 * theta
          continuation_A <- 1 - current_A - optout_A
          if (alpha == "alpha_A") {
            outcome <- c(current_A, optout_A, continuation_A)
            h_payoff <- 0.25 + 0.01 * recognizer + 0.005 * support + 0.04 * theta
          } else {
            outcome <- c(continuation_A, optout_A, current_A)
            h_payoff <- 0.27 + 0.01 * recognizer + 0.005 * support + 0.04 * theta
          }
          base_by_identity <- c(0.04, 0.07, 0.10)
          if (alpha == "alpha_B") base_by_identity <- base_by_identity[c(3, 1, 2)]
          for (weak_identity in 1:3) {
            weak_payoff <- base_by_identity[[weak_identity]] +
              0.01 * recognizer + 0.015 * support + 0.02 * theta
            out <- rbind(
              out,
              data.frame(
                alpha = alpha,
                recognizer = recognizer,
                support = paste0("s", support),
                support_index = support,
                sigma = sigma,
                theta = theta,
                weak_identity = paste0("W", weak_identity),
                weak_index = weak_identity,
                weak_payoff = weak_payoff,
                H_payoff = h_payoff,
                current_probability = outcome[[1]],
                optout_probability = outcome[[2]],
                continuation_probability = outcome[[3]],
                proposal_strategy_component = paste0(alpha, "_sigma_i", recognizer),
                ballot_strategy_component = paste0(alpha, "_ballot_i", recognizer, "_s", support),
                belief_kernel_component = paste0(alpha, "_belief_i", recognizer, "_s", support),
                payment_kernel_component = paste0(alpha, "_payment_i", recognizer, "_s", support),
                continuation_selection_component = paste0(alpha, "_kappa_i", recognizer, "_s", support),
                terminal_outcome_kernel_component = paste0(alpha, "_D_i", recognizer, "_s", support)
              )
            )
          }
        }
      }
    }
  }
  out
}

fixture <- build_fixture()
utils::write.csv(fixture, fixture_path, row.names = FALSE, fileEncoding = "UTF-8")

integrate_alpha <- function(fixture_rows, alpha_name, mu) {
  rows <- fixture_rows[fixture_rows$alpha == alpha_name, , drop = FALSE]
  recognizers <- sort(unique(rows$recognizer))
  weak_ids <- sort(unique(rows$weak_index))
  thetas <- sort(unique(rows$theta))
  m <- length(recognizers)
  if (!identical(recognizers, seq_len(m)) || !identical(weak_ids, seq_len(m)) ||
      !identical(thetas, 0:1)) stop("Malformed assessment fixture.")

  e_sigma_weak <- array(
    0,
    dim = c(m, 2L, m),
    dimnames = list(paste0("i", recognizers), paste0("theta", thetas), paste0("W", weak_ids))
  )
  e_sigma_H <- matrix(0, nrow = m, ncol = 2L)
  e_sigma_outcome <- array(0, dim = c(m, 2L, 3L))

  for (i in recognizers) {
    for (theta in thetas) {
      for (k in weak_ids) {
        cell <- rows[rows$recognizer == i & rows$theta == theta &
                       rows$weak_index == k, , drop = FALSE]
        e_sigma_weak[i, theta + 1L, k] <- sum(cell$sigma * cell$weak_payoff)
      }
      cell_H <- rows[rows$recognizer == i & rows$theta == theta &
                       rows$weak_index == 1L, , drop = FALSE]
      e_sigma_H[i, theta + 1L] <- sum(cell_H$sigma * cell_H$H_payoff)
      e_sigma_outcome[i, theta + 1L, ] <- c(
        sum(cell_H$sigma * cell_H$current_probability),
        sum(cell_H$sigma * cell_H$optout_probability),
        sum(cell_H$sigma * cell_H$continuation_probability)
      )
    }
  }

  c1_weak <- matrix(0, nrow = 2L, ncol = m,
                    dimnames = list(c("theta0", "theta1"), paste0("W", weak_ids)))
  c1_H <- numeric(2L)
  c1_outcome <- matrix(0, nrow = 2L, ncol = 3L,
                       dimnames = list(c("theta0", "theta1"),
                                       c("current", "optout", "continuation")))
  for (theta in thetas) {
    for (k in weak_ids) c1_weak[theta + 1L, k] <- mean(e_sigma_weak[, theta + 1L, k])
    c1_H[theta + 1L] <- mean(e_sigma_H[, theta + 1L])
    c1_outcome[theta + 1L, ] <- colMeans(e_sigma_outcome[, theta + 1L, , drop = FALSE], dims = 1L)
  }
  totals <- rowSums(c1_weak)
  gross <- ((1 - mu) * totals[[1]] + mu * totals[[2]]) / m

  list(
    alpha = alpha_name,
    raw_payload = rows,
    e_sigma_weak = e_sigma_weak,
    e_sigma_H = e_sigma_H,
    e_sigma_outcome = e_sigma_outcome,
    c1_weak = c1_weak,
    c1_H = c1_H,
    c1_outcome = c1_outcome,
    total_weak = totals,
    gross = gross,
    mu = mu,
    m = m,
    outcome_alpha = alpha_name
  )
}

manual_integrate <- function(fixture_rows, alpha_name, mu) {
  rows <- fixture_rows[fixture_rows$alpha == alpha_name, , drop = FALSE]
  m <- length(unique(rows$recognizer))
  weak <- matrix(NA_real_, nrow = 2L, ncol = m)
  H <- numeric(2L)
  outcome <- matrix(NA_real_, nrow = 2L, ncol = 3L)
  for (theta in 0:1) {
    for (k in seq_len(m)) {
      weighted_recognizer_values <- numeric(m)
      for (i in seq_len(m)) {
        z <- rows[rows$theta == theta & rows$weak_index == k & rows$recognizer == i, , drop = FALSE]
        weighted_recognizer_values[[i]] <- z$weak_payoff[[1]] * z$sigma[[1]] +
          z$weak_payoff[[2]] * z$sigma[[2]]
      }
      weak[theta + 1L, k] <- sum(weighted_recognizer_values) / m
    }
    h_rec <- current_rec <- optout_rec <- continuation_rec <- numeric(m)
    for (i in seq_len(m)) {
      z <- rows[rows$theta == theta & rows$weak_index == 1L & rows$recognizer == i, , drop = FALSE]
      h_rec[[i]] <- sum(z$sigma * z$H_payoff)
      current_rec[[i]] <- sum(z$sigma * z$current_probability)
      optout_rec[[i]] <- sum(z$sigma * z$optout_probability)
      continuation_rec[[i]] <- sum(z$sigma * z$continuation_probability)
    }
    H[theta + 1L] <- sum(h_rec) / m
    outcome[theta + 1L, ] <- c(sum(current_rec), sum(optout_rec), sum(continuation_rec)) / m
  }
  totals <- rowSums(weak)
  list(
    weak = weak,
    H = H,
    outcome = outcome,
    total = totals,
    gross = ((1 - mu) * totals[[1]] + mu * totals[[2]]) / m
  )
}

entry_from_c1 <- function(c1_payload, chi, outside = c(0.10, 0.55)) {
  form <- c1_payload$gross >= chi - tol
  if (form) {
    weak <- c1_payload$c1_weak - chi
    H <- c1_payload$c1_H
    outcome <- cbind(c1_payload$c1_outcome, nonformation = c(0, 0))
  } else {
    weak <- matrix(0, nrow = 2L, ncol = c1_payload$m,
                   dimnames = dimnames(c1_payload$c1_weak))
    H <- outside
    outcome <- matrix(
      c(0, 0, 0, 1, 0, 0, 0, 1),
      nrow = 2L,
      byrow = TRUE,
      dimnames = list(c("theta0", "theta1"),
                      c("current", "optout", "continuation", "nonformation"))
    )
  }
  ex_ante_outcome <- (1 - c1_payload$mu) * outcome[1, ] + c1_payload$mu * outcome[2, ]
  list(
    alpha = c1_payload$alpha,
    alpha_payload = c1_payload$raw_payload,
    outcome_alpha = c1_payload$outcome_alpha,
    gross = c1_payload$gross,
    net_decision_value = c1_payload$gross - chi,
    chi = chi,
    form = form,
    status = if (form) "form" else "no_form",
    weak = weak,
    H = H,
    outcome = outcome,
    ex_ante_outcome = ex_ante_outcome
  )
}

mu_fixture <- 0.37
c1_A <- integrate_alpha(fixture, "alpha_A", mu_fixture)
c1_B <- integrate_alpha(fixture, "alpha_B", mu_fixture)
manual_A <- manual_integrate(fixture, "alpha_A", mu_fixture)

add_check(
  "EU7_FULL_ASSESSMENT_FIXTURE_COVERAGE",
  nrow(fixture) == 72L &&
    length(unique(fixture$alpha)) == 2L &&
    length(unique(fixture$recognizer)) == 3L &&
    length(unique(fixture$support)) == 2L &&
    length(unique(fixture$theta)) == 2L &&
    length(unique(fixture$weak_identity)) == 3L &&
    all(abs(ave(fixture$sigma, fixture$alpha, fixture$recognizer, fixture$theta,
                fixture$weak_identity, FUN = sum) - 1) <= tol) &&
    all(nzchar(fixture$proposal_strategy_component)) &&
    all(nzchar(fixture$ballot_strategy_component)) &&
    all(nzchar(fixture$belief_kernel_component)) &&
    all(nzchar(fixture$payment_kernel_component)) &&
    all(nzchar(fixture$continuation_selection_component)) &&
    all(nzchar(fixture$terminal_outcome_kernel_component)),
  "The fixture carries two complete alpha payloads, all recognizers, support points, types, identities, and aligned strategy/belief/payment/continuation/outcome components."
)

add_check(
  "EU8_E_SIGMA_THEN_RECOGNITION",
  near(as.numeric(c1_A$c1_weak), as.numeric(manual_A$weak)) &&
    near(c1_A$c1_H, manual_A$H) && near(as.numeric(c1_A$c1_outcome), as.numeric(manual_A$outcome)),
  "E_sigma is computed within recognizer before uniform recognition, separately by type and identity."
)

add_check(
  "EU9_TYPE_THEN_CROSS_WEAK_AVERAGE",
  near(c1_A$total_weak, manual_A$total) && near(c1_A$gross, manual_A$gross) &&
    near(c1_A$gross,
         ((1 - mu_fixture) * sum(c1_A$c1_weak[1, ]) +
            mu_fixture * sum(c1_A$c1_weak[2, ])) / 3),
  "The prior average is applied after type-by-identity C1, and division by m occurs last."
)

add_check(
  "EU10_IDENTITY_ASYMMETRY_PRESERVED",
  length(unique(round(c1_A$c1_weak[1, ], 12))) == 3L &&
    !near(c1_A$c1_weak, c1_B$c1_weak) &&
    near(rowSums(c1_A$c1_weak), rowSums(c1_B$c1_weak)),
  "Identity-asymmetric C1 vectors remain distinct even when type totals agree."
)

add_check(
  "EU11_ALIGNED_H_AND_OUTCOME_KERNELS",
  near(rowSums(c1_A$c1_outcome), c(1, 1)) &&
    near(rowSums(c1_B$c1_outcome), c(1, 1)) &&
    !near(c1_A$c1_H, c1_B$c1_H) && !near(c1_A$c1_outcome, c1_B$c1_outcome) &&
    identical(c1_A$outcome_alpha, c1_A$alpha) && identical(c1_B$outcome_alpha, c1_B$alpha),
  "H payoffs and outcome kernels stay aligned with the same complete alpha."
)

add_check(
  "EU12_EQUAL_GROSS_DOES_NOT_QUOTIENT_ALPHA",
  near(c1_A$gross, c1_B$gross) && !identical(c1_A$raw_payload, c1_B$raw_payload) &&
    length(list(c1_A, c1_B)) == 2L,
  "Two alphas with the same scalar gross value remain two correspondence elements."
)

# Mutations of the integration operator.
rows_A <- fixture[fixture$alpha == "alpha_A", , drop = FALSE]
wrong_ignore_sigma <- matrix(0, nrow = 2L, ncol = 3L)
for (theta in 0:1) {
  for (k in 1:3) {
    z <- rows_A[rows_A$theta == theta & rows_A$weak_index == k, , drop = FALSE]
    wrong_ignore_sigma[theta + 1L, k] <- mean(z$weak_payoff)
  }
}
wrong_recognition <- 0.6 * c1_A$e_sigma_weak[1, , ] +
  0.3 * c1_A$e_sigma_weak[2, , ] + 0.1 * c1_A$e_sigma_weak[3, , ]

add_check(
  "EU13_SIGMA_MUTATION_REJECTED",
  !near(wrong_ignore_sigma, c1_A$c1_weak),
  "Ignoring proposal-support probabilities changes C1 and is detected."
)

add_check(
  "EU14_RECOGNITION_MUTATION_REJECTED",
  !near(wrong_recognition, c1_A$c1_weak),
  "Replacing uniform recognition by arbitrary weights changes C1 and is detected."
)

scalarized_early <- rowMeans(c1_A$c1_weak)
add_check(
  "EU15_IDENTITY_SCALARIZATION_REJECTED",
  length(scalarized_early) == 2L && length(c1_A$c1_weak) == 6L &&
    !identical(dim(scalarized_early), dim(c1_A$c1_weak)),
  "Early cross-weak scalarization cannot satisfy the required 2-by-m export."
)

# -------------------------------------------------------------------------
# Entry action, external costs, and realized payoffs
# -------------------------------------------------------------------------

chi_form <- c1_A$gross / 2
entry_A_form <- entry_from_c1(c1_A, chi_form)
entry_A_equal <- entry_from_c1(c1_A, c1_A$gross)
entry_A_no <- entry_from_c1(c1_A, c1_A$gross + 0.05)

add_check(
  "EU16_EXTERNAL_COST_ACCOUNTING",
  isTRUE(entry_A_form$form) && near(entry_A_form$weak, c1_A$c1_weak - chi_form) &&
    near(entry_A_form$H, c1_A$c1_H) &&
    near(entry_A_form$outcome[, 1:3], c1_A$c1_outcome) &&
    near(c1_A$gross, integrate_alpha(fixture, "alpha_A", mu_fixture)$gross),
  "Formation subtracts chi once from each weak identity without changing C1, H, or bargaining outcomes."
)

add_check(
  "EU17_EQUALITY_FORMS",
  isTRUE(entry_A_equal$form) && identical(entry_A_equal$status, "form") &&
    abs(entry_A_equal$net_decision_value) <= tol,
  "A zero collective net value selects formation exactly."
)

add_check(
  "EU18_NONFORMATION_PAYOFF_AND_OUTCOME",
  !entry_A_no$form && all(entry_A_no$weak == 0) &&
    near(entry_A_no$H, c(0.10, 0.55)) &&
    near(entry_A_no$outcome[, "nonformation"], c(1, 1)) &&
    near(rowSums(entry_A_no$outcome[, 1:3, drop = FALSE]), c(0, 0)),
  "Nonformation gives weak zero, H its type-specific outside option, and a degenerate nonformation outcome."
)

add_check(
  "EU19_ONE_ACTION_FOR_BOTH_TYPES",
  length(entry_A_form$form) == 1L && nrow(entry_A_form$weak) == 2L &&
    identical(entry_A_form$status, "form"),
  "The uninformed collective action is common across both retained type rows."
)

add_check(
  "EU20_EX_ANTE_OUTCOME_LAST",
  near(entry_A_form$ex_ante_outcome,
       (1 - mu_fixture) * entry_A_form$outcome[1, ] + mu_fixture * entry_A_form$outcome[2, ]) &&
    near(sum(entry_A_form$ex_ante_outcome), 1),
  "The type mixture of aligned entry outcomes is computed only after the type-conditional map."
)

spliced_entry <- entry_A_form
spliced_entry$outcome_alpha <- "alpha_B"
add_check(
  "EU21_OUTCOME_SPLICING_MUTATION_REJECTED",
  !identical(spliced_entry$alpha, spliced_entry$outcome_alpha) &&
    identical(entry_A_form$alpha, entry_A_form$outcome_alpha),
  "An outcome kernel taken from another alpha fails the alignment invariant."
)

realized <- data.frame()
for (alpha_name in c("alpha_A", "alpha_B")) {
  payload <- if (alpha_name == "alpha_A") c1_A else c1_B
  scenarios <- list(
    positive_net = payload$gross / 2,
    equality = payload$gross,
    negative_net = payload$gross + 0.05
  )
  for (scenario in names(scenarios)) {
    entry <- entry_from_c1(payload, scenarios[[scenario]])
    for (theta in 0:1) {
      for (k in 1:3) {
        realized <- rbind(
          realized,
          data.frame(
            alpha = alpha_name,
            scenario = scenario,
            mu = payload$mu,
            chi = entry$chi,
            gross_value = entry$gross,
            net_decision_value = entry$net_decision_value,
            status = entry$status,
            theta = theta,
            player = paste0("W", k),
            realized_payoff = entry$weak[theta + 1L, k],
            outcome_source = if (entry$form) alpha_name else "nonformation"
          )
        )
      }
      realized <- rbind(
        realized,
        data.frame(
          alpha = alpha_name,
          scenario = scenario,
          mu = payload$mu,
          chi = entry$chi,
          gross_value = entry$gross,
          net_decision_value = entry$net_decision_value,
          status = entry$status,
          theta = theta,
          player = "H",
          realized_payoff = entry$H[theta + 1L],
          outcome_source = if (entry$form) alpha_name else "nonformation"
        )
      )
    }
  }
}
utils::write.csv(realized, realized_path, row.names = FALSE, fileEncoding = "UTF-8")

add_check(
  "EU22_REALIZED_PAYOFF_TABLE_COMPLETE",
  nrow(realized) == 48L &&
    length(unique(realized$alpha)) == 2L && length(unique(realized$scenario)) == 3L &&
    length(unique(realized$theta)) == 2L && length(unique(realized$player)) == 4L,
  "The realized-payoff table records every alpha, entry region, type, weak identity, and H."
)

# -------------------------------------------------------------------------
# Endpoint and selection-free logic
# -------------------------------------------------------------------------

endpoint_logic <- function(lower, upper, a_U_minus, a_U_plus, chi) {
  if (!is.finite(lower) || !is.finite(upper) || lower > upper + tol) stop("Invalid endpoints.")
  if (abs(lower - upper) <= tol && (!isTRUE(a_U_minus) || !isTRUE(a_U_plus))) {
    stop("A nonempty singleton value set necessarily attains both endpoints.")
  }
  c(
    all_form = lower >= chi - tol,
    possible_form = chi < upper - tol || (abs(chi - upper) <= tol && isTRUE(a_U_plus)),
    possible_no_form = lower < chi - tol,
    all_no_form = upper < chi - tol || (abs(chi - upper) <= tol && !isTRUE(a_U_plus))
  )
}

endpoint_specs <- data.frame(
  case_id = c(
    "below_lower", "at_lower_unattained", "interior", "at_upper_attained",
    "at_upper_unattained", "above_upper", "singleton_equality"
  ),
  lower = c(0.10, 0.10, 0.10, 0.10, 0.10, 0.10, 0.25),
  upper = c(0.40, 0.40, 0.40, 0.40, 0.40, 0.40, 0.25),
  a_U_minus = c(TRUE, FALSE, TRUE, TRUE, FALSE, TRUE, TRUE),
  a_U_plus = c(TRUE, FALSE, TRUE, TRUE, FALSE, TRUE, TRUE),
  chi = c(0.05, 0.10, 0.25, 0.40, 0.40, 0.45, 0.25)
)
endpoint_results <- t(vapply(seq_len(nrow(endpoint_specs)), function(r) {
  endpoint_logic(
    endpoint_specs$lower[[r]], endpoint_specs$upper[[r]],
    endpoint_specs$a_U_minus[[r]], endpoint_specs$a_U_plus[[r]],
    endpoint_specs$chi[[r]]
  )
}, logical(4)))
endpoint_table <- cbind(endpoint_specs, as.data.frame(endpoint_results))
utils::write.csv(endpoint_table, endpoint_path, row.names = FALSE, fileEncoding = "UTF-8")

expected_endpoint_results <- rbind(
  c(TRUE, TRUE, FALSE, FALSE),
  c(TRUE, TRUE, FALSE, FALSE),
  c(FALSE, TRUE, TRUE, FALSE),
  c(FALSE, TRUE, TRUE, FALSE),
  c(FALSE, FALSE, TRUE, TRUE),
  c(FALSE, FALSE, TRUE, TRUE),
  c(TRUE, TRUE, FALSE, FALSE)
)

add_check(
  "EU23_ENDPOINT_LOGIC_ALL_REGIONS",
  identical(unname(endpoint_results), unname(expected_endpoint_results)),
  "All-form, possible-form, possible-no, and all-no logic matches seven endpoint regions."
)

add_check(
  "EU24_LOWER_EQUALITY_INDEPENDENT_OF_ATTAINMENT",
  isTRUE(endpoint_table$all_form[endpoint_table$case_id == "at_lower_unattained"]) &&
    !isTRUE(endpoint_table$possible_no_form[endpoint_table$case_id == "at_lower_unattained"]),
  "At chi=infimum every value forms independently of the lower-attainment indicator a_U_minus."
)

add_check(
  "EU25_UPPER_EQUALITY_DEPENDS_ON_ATTAINMENT",
  isTRUE(endpoint_table$possible_form[endpoint_table$case_id == "at_upper_attained"]) &&
    !isTRUE(endpoint_table$all_no_form[endpoint_table$case_id == "at_upper_attained"]) &&
    !isTRUE(endpoint_table$possible_form[endpoint_table$case_id == "at_upper_unattained"]) &&
    isTRUE(endpoint_table$all_no_form[endpoint_table$case_id == "at_upper_unattained"]),
  "At chi=supremum formation is possible exactly when the upper-attainment indicator a_U_plus equals one."
)

invalid_singleton_rejected <- inherits(
  try(endpoint_logic(0.25, 0.25, FALSE, FALSE, 0.25), silent = TRUE),
  "try-error"
)
add_check(
  "EU26_SINGLETON_NONATTAINMENT_MUTATION_REJECTED",
  invalid_singleton_rejected,
  "The verifier rejects an impossible nonempty singleton with unattained endpoints."
)

add_check(
  "EU27_GENERAL_ATTAINMENT_NOT_DEFAULTED",
  grepl("a_U_minus=1", interface$endpoint_interface$lower_attainment_indicator, fixed = TRUE) &&
    grepl("no general N=3 truth value", interface$endpoint_interface$lower_attainment_indicator, fixed = TRUE) &&
    grepl("a_U_plus=1", interface$endpoint_interface$upper_attainment_indicator, fixed = TRUE) &&
    grepl("no general truth value", interface$endpoint_interface$upper_attainment_indicator, fixed = TRUE) &&
    grepl("a_U_plus=1", interface$selection_free_formation_logic$possible_form, fixed = TRUE) &&
    grepl("a_U_plus=0", interface$selection_free_formation_logic$all_no_form, fixed = TRUE) &&
    grepl("pending", interface$claim_status$general_N3_endpoint_values_and_attainment, fixed = TRUE) &&
    grepl("pending", interface$claim_status$general_upper_endpoint_value_and_attainment, fixed = TRUE),
  "The unambiguous a_U_minus/a_U_plus indicators remain explicitly pending where not proved."
)

zero_c1 <- list(
  alpha = "frozen_Nge4_zero_weak_value_class",
  raw_payload = data.frame(source = "r1_unanimity_v1.universal_zero_weak_value_PBE_for_Nge4"),
  c1_weak = matrix(0, nrow = 2L, ncol = 3L),
  c1_H = c(0.10, 0.55),
  c1_outcome = matrix(c(0, 0, 1, 0, 0, 1), nrow = 2L, byrow = TRUE),
  total_weak = c(0, 0),
  gross = 0,
  mu = mu_fixture,
  m = 3L,
  outcome_alpha = "frozen_Nge4_zero_weak_value_class"
)
zero_entry_chi0 <- entry_from_c1(zero_c1, 0)
zero_entry_positive_chi <- entry_from_c1(zero_c1, 0.01)

add_check(
  "EU28_NGE4_ZERO_LOWER_ENDPOINT_ATTAINED",
  grepl("zero", c1$constructive_subclasses$universal_zero_weak_value_PBE_for_Nge4$construction, fixed = TRUE) &&
    grepl("proves nonemptiness and attainment for every N>=4",
          c1$constructive_subclasses$universal_zero_weak_value_PBE_for_Nge4$existence,
          fixed = TRUE) &&
    zero_c1$gross == 0 && isTRUE(zero_entry_chi0$form) && !zero_entry_positive_chi$form,
  "The explicit frozen N>=4 zero-weak assessment proves an attained lower endpoint of zero."
)

add_check(
  "EU29_COST_ZERO_ALL_FORM",
  isTRUE(entry_from_c1(c1_A, 0)$form) && isTRUE(entry_from_c1(c1_B, 0)$form) &&
    isTRUE(zero_entry_chi0$form),
  "At chi=0 positive and zero gross values all form, with equality respected."
)

gross_bound_ok <- all(c(c1_A$gross, c1_B$gross, zero_c1$gross) >= -tol) &&
  all(c(c1_A$gross, c1_B$gross, zero_c1$gross) <= 1 / 3 + tol)
add_check(
  "EU30_GROSS_AND_COST_BOUNDS",
  gross_bound_ok && grepl("0<=G_U(alpha,mu)<=1/m", interface$selection_free_bounds$derived_gross_bound, fixed = TRUE) &&
    grepl("chi>1/m", interface$selection_free_bounds$cost_above_upper_bound, fixed = TRUE),
  "Fixtures respect 0<=G<=1/m, and chi>1/m is classified as all no-form."
)

add_check(
  "EU31_N3_ZERO_VALUE_NOT_ASSUMED",
  grepl("no zero-value assessment", interface$selection_free_bounds$N3_warning, fixed = TRUE) &&
    grepl("parameter- and correspondence-dependent", interface$endpoint_interface$N3_attainment_status, fixed = TRUE),
  "The N>=4 zero construction is not extended to N=3."
)

# -------------------------------------------------------------------------
# Primitive-domain boundary audit
# -------------------------------------------------------------------------

valid_primitives <- function(N, mu, o0, o1, ybar, beta, chi) {
  is.finite(N) && N == as.integer(N) && N >= 3 &&
    is.finite(mu) && mu >= 0 && mu <= 1 &&
    is.finite(o0) && is.finite(o1) && is.finite(ybar) &&
    0 <= o0 && o0 < o1 && o1 <= ybar && ybar <= 1 &&
    is.finite(beta) && beta > 0 && beta <= 1 &&
    is.finite(chi) && chi >= 0
}

boundary_cases <- data.frame(
  N = c(3, 4, 5, 3, 4, 3, 7, 3, 4, 3),
  mu = c(0, 1, 0.5, 0.4, 0.7, 0.2, 0.8, 1, 0, 0.5),
  o0 = c(0, 0.1, 0, 0.2, 0.3, 0, 0.15, 0, 0.2, 0.1),
  o1 = c(0.5, 0.7, 1, 0.6, 0.8, 0.9, 0.6, 0.4, 0.9, 0.7),
  ybar = c(0.5, 1, 1, 0.9, 0.8, 0.9, 0.95, 0.4, 1, 0.7),
  beta = c(0.2, 1, 0.9, 1, 0.5, 0.75, 1, 0.3, 0.6, 1),
  chi = c(0, 0.25, 0.21, 0.5, 1 / 3, 2, 0.01, 0, 0.4, 0.5)
)
boundary_valid <- vapply(seq_len(nrow(boundary_cases)), function(r) {
  do.call(valid_primitives, as.list(boundary_cases[r, ]))
}, logical(1))

invalid_cases <- list(
  c(2, 0.5, 0, 0.5, 1, 0.9, 0),
  c(3, -0.1, 0, 0.5, 1, 0.9, 0),
  c(3, 1.1, 0, 0.5, 1, 0.9, 0),
  c(3, 0.5, 0.5, 0.5, 1, 0.9, 0),
  c(3, 0.5, 0, 0.8, 0.7, 0.9, 0),
  c(3, 0.5, 0, 0.5, 1, 0, 0),
  c(3, 0.5, 0, 0.5, 1, 0.9, -0.1)
)
invalid_rejected <- vapply(invalid_cases, function(z) {
  !do.call(valid_primitives, as.list(z))
}, logical(1))

add_check(
  "EU32_FULL_DOMAIN_AND_BOUNDARIES",
  all(boundary_valid) && all(invalid_rejected) &&
    identical(interface$validated_domain_gate$validated_common_existence_domain,
              "every primitive-admissible N>=3 case exported by frozen C1-U") &&
    length(interface$validated_domain_gate$boundary_inclusion) == 10L,
  "All listed N>=3 primitive boundaries are accepted and seven out-of-domain mutations are rejected."
)

# -------------------------------------------------------------------------
# Dependency mutations and protected artifacts
# -------------------------------------------------------------------------

mutate_hash <- function(x) paste0(ifelse(substr(x, 1, 1) == "0", "1", "0"), substr(x, 2, nchar(x)))
add_check(
  "EU33_C1_HASH_MUTATION_GUARD",
  !dependency_valid(observed_hashes[["gate0"]], observed_hashes[["batch"]],
                    mutate_hash(observed_hashes[["c1"]])),
  "A one-byte-equivalent C1-U digest mutation invalidates the entry dependency gate."
)

add_check(
  "EU34_R1_BATCH_HASH_MUTATION_GUARD",
  !dependency_valid(observed_hashes[["gate0"]], mutate_hash(observed_hashes[["batch"]]),
                    observed_hashes[["c1"]]),
  "A one-byte-equivalent R1-batch digest mutation invalidates the entry dependency gate."
)

add_check(
  "EU35_GATE0_HASH_MUTATION_GUARD",
  !dependency_valid(mutate_hash(observed_hashes[["gate0"]]), observed_hashes[["batch"]],
                    observed_hashes[["c1"]]),
  "A one-byte-equivalent Gate 0 digest mutation invalidates the entry dependency gate."
)

protected <- utils::read.delim(protected_path, check.names = FALSE, encoding = "UTF-8")
protected_exist <- nrow(protected) == 27L && all(file.exists(protected$path))
protected_match <- protected_exist && all(vapply(seq_len(nrow(protected)), function(r) {
  identical(sha256_file(protected$path[[r]]), protected$sha256[[r]])
}, logical(1)))
add_check(
  "EU36_PROTECTED_HASHES_INTACT",
  protected_match,
  "All 27 protected and quarantined artifacts remain byte-identical to the frozen manifest."
)

add_check(
  "EU37_EXCLUSIVE_OUTPUT_SCOPE",
  all(c(checks_path, fixture_path, realized_path, endpoint_path) ==
        sub("^\\.\\./\\.\\./", "",
            c(interface$provenance$check_table,
              interface$provenance$assessment_fixture_table,
              interface$provenance$realized_payoff_fixture_table,
              interface$provenance$endpoint_logic_table))) &&
    identical(interface$input_sufficiency_and_stop_rule$decision,
              "no upstream reopen is needed for the exact entry correspondence; no unavailable closed-form endpoint is claimed"),
  "The candidate declares only its exclusive tables and honestly stops short of unavailable closed-form endpoints."
)

# Write the check table only after every check has run.
utils::write.csv(checks, checks_path, row.names = FALSE, fileEncoding = "UTF-8")

failed <- checks$test_id[checks$status != "PASS"]
cat(sprintf("entry_unanimity mechanical verification: %d/%d PASS\n",
            sum(checks$status == "PASS"), nrow(checks)))
cat(sprintf("fixture rows: %d; realized payoff rows: %d; endpoint cases: %d\n",
            nrow(fixture), nrow(realized), nrow(endpoint_table)))
cat(sprintf("protected hashes checked: %d\n", nrow(protected)))
if (length(failed)) {
  cat("FAILED: ", paste(failed, collapse = ", "), "\n", sep = "")
  quit(status = 1L)
}
cat("All checks passed. Candidate remains pending independent read-only review.\n")
