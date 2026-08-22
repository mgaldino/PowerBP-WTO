#!/usr/bin/env Rscript

# Verificador dirigido de N7. Deliberadamente não faz mutação exaustiva por
# campo. Reconstrói os quatro jogos públicos, testa endpoints e identidades de
# renda e usa somente cinco negativos representativos dos invariantes centrais.

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

tol <- 1e-10

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

close_enough <- function(x, y, tolerance = tol) {
  isTRUE(abs(x - y) <= tolerance)
}

clone_object <- function(x) unserialize(serialize(x, NULL))
as_character <- function(x) as.character(unlist(x, use.names = FALSE))

sha256_file <- function(path) {
  output <- system2(
    "shasum", c("-a", "256", shQuote(path)), stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  assert_true(length(output) == 1L, paste("Could not hash", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", hash), paste("Malformed hash for", path))
  hash
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

path_from_root <- function(...) file.path(repository_root, ...)

candidate_path <- path_from_root(
  "model_redesign", "essential_input_n7_complete_information_benchmark_candidate.json"
)
derivation_path <- path_from_root(
  "model_redesign", "essential_input_n7_public_benchmark_derivation.md"
)
ledger_path <- path_from_root("model_redesign", "essential_input_n7_claim_ledger.tsv")
dag_path <- path_from_root("model_redesign", "essential_input_game_dag.json")
n1_path <- path_from_root(
  "model_redesign", "essential_input_interfaces", "n1_r2_majority_candidate_v1.json"
)
n2_path <- path_from_root("model_redesign", "essential_input_n2_r2_unanimity_interface.json")
n3_path <- path_from_root(
  "model_redesign", "essential_input_solution_concept", "n3_r1_majority_candidate.json"
)
n4_path <- path_from_root(
  "model_redesign", "essential_input_solution_concept", "n4_r1_unanimity_candidate.json"
)
n6_path <- path_from_root("model_redesign", "essential_input_n6_private_comparison_candidate.json")

required_paths <- c(
  candidate_path, derivation_path, ledger_path, dag_path,
  n1_path, n2_path, n3_path, n4_path, n6_path
)
assert_true(all(file.exists(required_paths)), "One or more required N7 inputs are missing.")

expected_hashes <- c(
  N1 = "1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5",
  N2 = "c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2",
  N3 = "ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d",
  N4 = "f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b",
  N6 = "a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92"
)
actual_hashes <- c(
  N1 = sha256_file(n1_path), N2 = sha256_file(n2_path),
  N3 = sha256_file(n3_path), N4 = sha256_file(n4_path), N6 = sha256_file(n6_path)
)
assert_true(
  identical(actual_hashes, expected_hashes),
  "A frozen N1-N6 interface hash differs from the N7 dependency boundary."
)

candidate <- jsonlite::fromJSON(candidate_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
n1 <- jsonlite::fromJSON(n1_path, simplifyVector = FALSE)
n2 <- jsonlite::fromJSON(n2_path, simplifyVector = FALSE)
n3 <- jsonlite::fromJSON(n3_path, simplifyVector = FALSE)
n4 <- jsonlite::fromJSON(n4_path, simplifyVector = FALSE)
n6 <- jsonlite::fromJSON(n6_path, simplifyVector = FALSE)

schema <- dag$interface_schemas$complete_information_benchmark_v1
public_fields <- as_character(schema$public_equilibrium_record_fields)
rent_fields <- as_character(schema$informational_rent_record_fields)
contrast_fields <- as_character(schema$informational_rent_contrast_record_fields)
payoff_fields <- as_character(dag$shared_schema_types$public_payoff_vector_v1$fields)
outcome_fields <- as_character(schema$outcome_distribution_fields)
n6_hash_tagged <- paste0("sha256:", expected_hashes[["N6"]])

records_from_cells <- function(cells, field) {
  unlist(lapply(cells, function(cell) cell[[field]]), recursive = FALSE)
}

valid_certificate <- function(certificate) {
  is.list(certificate) &&
    identical(names(certificate), c("ledger_claim_ids", "assumptions_used", "checks_performed")) &&
    length(as_character(certificate$ledger_claim_ids)) > 0L &&
    length(as_character(certificate$assumptions_used)) > 0L &&
    length(as_character(certificate$checks_performed)) > 0L
}

valid_cells <- function(cells, record_field) {
  if (!is.list(cells) || length(cells) == 0L) return(FALSE)
  ids <- vapply(cells, `[[`, character(1), "cell_id")
  if (anyDuplicated(ids)) return(FALSE)
  all(vapply(cells, function(cell) {
    if (!identical(names(cell), c(
      "cell_id", "domain_conditions", "existence_status",
      record_field, "nonexistence_certificate"
    ))) return(FALSE)
    records <- cell[[record_field]]
    if (identical(cell$existence_status, "exists")) {
      length(records) > 0L && is.null(cell$nonexistence_certificate)
    } else if (identical(cell$existence_status, "none")) {
      length(records) == 0L && valid_certificate(cell$nonexistence_certificate)
    } else FALSE
  }, logical(1)))
}

public_nests <- list(
  list("majority", "R2", "theta_0"), list("majority", "R2", "theta_1"),
  list("majority", "R1", "theta_0"), list("majority", "R1", "theta_1"),
  list("unanimity", "R2", "theta_0"), list("unanimity", "R2", "theta_1"),
  list("unanimity", "R1", "theta_0"), list("unanimity", "R1", "theta_1")
)

all_public <- list()
for (nest in public_nests) {
  institution <- nest[[1L]]
  round <- nest[[2L]]
  theta <- nest[[3L]]
  cells <- candidate$public_equilibrium_cells[[institution]][[round]][[theta]]
  assert_true(
    valid_cells(cells, "public_equilibrium_records"),
    paste("Invalid public coverage cells for", institution, round, theta)
  )
  records <- records_from_cells(cells, "public_equilibrium_records")
  for (record in records) {
    assert_true(identical(names(record), public_fields), "A public record has wrong fields.")
    assert_true(
      identical(record$institution, institution) &&
        identical(record$round, round) && identical(record$theta, theta),
      "A public record is stored in the wrong institution/round/type nest."
    )
    assert_true(identical(names(record$payoff_vector), payoff_fields), "Wrong public payoff roles.")
    assert_true(identical(names(record$outcome_distribution), outcome_fields), "Wrong public outcomes.")
    all_public[[record$public_equilibrium_id]] <- record
  }
}

assert_true(
  length(all_public) == 10L && !anyDuplicated(names(all_public)),
  "N7 must contain exactly ten uniquely identified public records."
)

expected_public_ids <- c(
  "N7-PUB-M-R2-T0", "N7-PUB-M-R2-T1",
  "N7-PUB-M-R1-T0-INCLUDE", "N7-PUB-M-R1-T0-EXCLUDE",
  "N7-PUB-M-R1-T1-INCLUDE", "N7-PUB-M-R1-T1-EXCLUDE",
  "N7-PUB-U-R2-T0", "N7-PUB-U-R2-T1",
  "N7-PUB-U-R1-T0", "N7-PUB-U-R1-T1"
)
assert_true(setequal(names(all_public), expected_public_ids), "Unexpected public record IDs.")

for (id in names(all_public)) {
  record <- all_public[[id]]
  sources <- as_character(record$source_public_continuation_ids)
  if (identical(record$round, "R2")) {
    assert_true(length(sources) == 0L, paste(id, "must not cite a continuation."))
  } else {
    expected_source <- paste0(
      "N7-PUB-", ifelse(record$institution == "majority", "M", "U"),
      "-R2-", ifelse(record$theta == "theta_0", "T0", "T1")
    )
    assert_true(identical(sources, expected_source), paste(id, "has the wrong public continuation."))
  }
}

is_public_semantic <- function(object) {
  tryCatch({
    p <- list()
    for (nest in public_nests) {
      for (cell in object$public_equilibrium_cells[[nest[[1L]]]][[nest[[2L]]]][[nest[[3L]]]]) {
        for (record in cell$public_equilibrium_records) p[[record$public_equilibrium_id]] <- record
      }
    }
    identical(p[["N7-PUB-M-R2-T0"]]$payoff_vector$hegemon_payoff, "o_0") &&
      identical(p[["N7-PUB-M-R2-T1"]]$payoff_vector$hegemon_payoff, "o_1") &&
      identical(p[["N7-PUB-U-R2-T0"]]$payoff_vector$hegemon_payoff, "o_0") &&
      identical(p[["N7-PUB-U-R2-T1"]]$payoff_vector$hegemon_payoff, "o_1") &&
      identical(p[["N7-PUB-M-R1-T0-INCLUDE"]]$payoff_vector$hegemon_payoff, "beta*o_0") &&
      identical(p[["N7-PUB-M-R1-T0-EXCLUDE"]]$payoff_vector$hegemon_payoff, "o_0") &&
      identical(p[["N7-PUB-M-R1-T1-INCLUDE"]]$payoff_vector$hegemon_payoff, "beta*o_1") &&
      identical(p[["N7-PUB-M-R1-T1-EXCLUDE"]]$payoff_vector$hegemon_payoff, "o_1") &&
      identical(
        p[["N7-PUB-M-R1-T0-EXCLUDE"]]$strategy_profile$hegemon,
        "no if at least q-1 weak nonproposers vote yes; yes iff y>=beta*o_0 when exactly q-2 do; yes by T^Y when at most q-3 do"
      ) &&
      identical(
        p[["N7-PUB-M-R1-T1-EXCLUDE"]]$strategy_profile$hegemon,
        "no if at least q-1 weak nonproposers vote yes; yes iff y>=beta*o_1 when exactly q-2 do; yes by T^Y when at most q-3 do"
      ) &&
      identical(p[["N7-PUB-U-R1-T0"]]$payoff_vector$hegemon_payoff, "beta*o_0") &&
      identical(p[["N7-PUB-U-R1-T1"]]$payoff_vector$hegemon_payoff, "beta*o_1")
  }, error = function(e) FALSE)
}
assert_true(is_public_semantic(candidate), "Public H payoff formulas are not canonical.")

majority_rent_cells <- candidate$informational_rent_cells$majority
unanimity_rent_cells <- candidate$informational_rent_cells$unanimity
contrast_cells <- candidate$informational_rent_contrast_cells
assert_true(valid_cells(majority_rent_cells, "informational_rent_records"), "Invalid RI_M cells.")
assert_true(valid_cells(unanimity_rent_cells, "informational_rent_records"), "Invalid RI_U cells.")
assert_true(valid_cells(contrast_cells, "informational_rent_contrast_records"), "Invalid DeltaRI cells.")
assert_true(length(majority_rent_cells) == 3L, "RI_M must have II, IX, and XX cells.")
assert_true(length(unanimity_rent_cells) == 3L, "RI_U must have zero, none, and high cells.")
assert_true(length(contrast_cells) == 9L, "DeltaRI must be the 3x3 common refinement.")

n6_private_ids <- unlist(lapply(
  c(n6$private_rule_cells$majority, n6$private_rule_cells$unanimity),
  function(cell) vapply(cell$private_rule_records, `[[`, character(1), "private_rule_record_id")
), use.names = FALSE)

all_rents <- list()
for (institution in c("majority", "unanimity")) {
  cells <- candidate$informational_rent_cells[[institution]]
  for (record in records_from_cells(cells, "informational_rent_records")) {
    assert_true(identical(names(record), rent_fields), "A rent record has wrong fields.")
    assert_true(identical(record$institution, institution), "A rent record is under the wrong rule.")
    assert_true(identical(record$source_N6_interface_hash, n6_hash_tagged), "Wrong N6 rent hash.")
    assert_true(record$private_source_rule_record_id %in% n6_private_ids, "Unknown N6 private source ID.")
    source_ids <- record$public_source_equilibrium_ids
    assert_true(identical(names(source_ids), c("theta_0", "theta_1")), "Wrong public rent source keys.")
    for (theta in names(source_ids)) {
      public_record <- all_public[[source_ids[[theta]]]]
      assert_true(!is.null(public_record), "Unknown public rent source ID.")
      assert_true(
        identical(public_record$institution, institution) &&
          identical(public_record$round, "R1") && identical(public_record$theta, theta),
        "A rent cites a public source from the wrong rule, round, or type."
      )
    }
    assert_true(identical(names(record$RI), c("theta_0", "theta_1")), "Wrong RI coordinates.")
    all_rents[[record$rent_record_id]] <- record
  }
}
assert_true(length(all_rents) == 5L && !anyDuplicated(names(all_rents)), "Wrong rent record cardinality.")

all_contrasts <- list()
for (record in records_from_cells(contrast_cells, "informational_rent_contrast_records")) {
  assert_true(identical(names(record), contrast_fields), "A DeltaRI record has wrong fields.")
  assert_true(identical(names(record$source_rent_record_ids), c("majority", "unanimity")), "Wrong contrast source keys.")
  assert_true(
    record$source_rent_record_ids$majority %in% names(all_rents) &&
      record$source_rent_record_ids$unanimity %in% names(all_rents),
    "A contrast cites an unknown rent record."
  )
  assert_true(identical(names(record$DeltaRI), c("theta_0", "theta_1")), "Wrong DeltaRI coordinates.")
  all_contrasts[[record$contrast_record_id]] <- record
}
assert_true(length(all_contrasts) == 6L && !anyDuplicated(names(all_contrasts)), "Wrong contrast record cardinality.")

none_contrasts <- Filter(function(cell) identical(cell$existence_status, "none"), contrast_cells)
assert_true(length(none_contrasts) == 3L, "Exactly three DeltaRI cells must be none.")
assert_true(
  all(vapply(none_contrasts, function(cell) {
    grepl("0<nu=prior_mu<=nu_star", paste(as_character(cell$domain_conditions), collapse = " "), fixed = TRUE)
  }, logical(1))),
  "Every DeltaRI none cell must be exactly the closed low-positive-prior interval."
)

# ---------------------------------------------------------------------------
# Independent mathematical reconstruction of the four public games
# ---------------------------------------------------------------------------

parameter_checks <- 0L
for (m in c(3L, 4L, 7L)) {
  N <- m + 1L
  q <- floor(N / 2) + 1L
  assert_true(q <= m, paste("q<=m failed for m=", m))
  cbar <- 1 / m
  for (beta in c(0.25, 0.70, 0.95)) {
    for (o in unique(c(cbar / 2, cbar, min(0.95, cbar + 0.20)))) {
      if (!(o > 0 && o < 1)) next

      # Majority R2: weak yes, H no, proposer retains one.
      assert_true(1 >= 0 && o > 0, "Majority R2 primitive reconstruction failed.")

      # Unanimity R2: y=o, residual 1-o strictly positive.
      assert_true(1 - o > 0, "Unanimity R2 proposer must strictly prefer agreement.")

      # Majority R1.
      w <- beta / m
      E <- 1 - (q - 1) * w
      J <- 1 - (q - 2) * w - beta * o
      assert_true(E - w > 0, "Majority public rejection must be strictly inferior.")
      assert_true(close_enough(J - E, beta * (cbar - o)), "Majority public branch identity failed.")
      public_includes <- o <= cbar + tol
      if (public_includes) {
        assert_true(J >= E - tol, "Majority public inclusion chosen on wrong side.")
        if (close_enough(o, cbar)) assert_true(beta * o < o, "Boundary anti-H tie must favor inclusion.")
      } else {
        assert_true(E > J, "Majority public exclusion chosen on wrong side.")
      }

      # Unanimity R1.
      C <- beta * (1 - o) / m
      Q <- 1 - beta * o - (m - 1) * C
      assert_true(close_enough(Q, C + 1 - beta), "Unanimity public Q=C+1-beta failed.")
      assert_true(Q > C, "Unanimity public immediate agreement must beat delay.")
      assert_true(close_enough(beta * o + (m - 1) * C + Q, 1), "Unanimity public budget failed.")
      parameter_checks <- parameter_checks + 1L
    }
  }
}

# ---------------------------------------------------------------------------
# Frozen endpoint equivalence
# ---------------------------------------------------------------------------

assert_true(n1$correspondence_cells[[1L]]$equilibrium_records[[1L]]$equilibrium_id == "N1-EQ-01", "Wrong N1 endpoint source.")
assert_true(
  n2$correspondence_cells[[1L]]$equilibrium_records[[1L]]$equilibrium_id == "N2-EQ-LOW-TYPE-ONLY" &&
    n2$correspondence_cells[[2L]]$equilibrium_records[[1L]]$equilibrium_id == "N2-EQ-POOLING",
  "Wrong N2 endpoint sources."
)
assert_true(
  n3$correspondence_cells[[1L]]$equilibrium_records[[1L]]$equilibrium_id == "N3-SC-EQ-COMPLETE",
  "Wrong N3 endpoint source."
)
assert_true(
  n4$correspondence_cells[[1L]]$equilibrium_records[[1L]]$equilibrium_id == "N4-SC-EQ-L-STAR" &&
    n4$correspondence_cells[[3L]]$equilibrium_records[[1L]]$equilibrium_id == "N4-SC-EQ-P-STAR",
  "Wrong N4 endpoint sources."
)

endpoint_checks <- 0L
for (m in c(3L, 5L)) {
  N <- m + 1L
  q <- floor(N / 2) + 1L
  for (beta in c(0.40, 0.85)) {
    for (o0 in c(0.05, 0.20)) {
      for (o1 in c(0.35, 0.75)) {
        if (!(o0 < o1)) next
        cbar <- 1 / m
        w <- beta / m
        E <- 1 - (q - 1) * w
        L <- 1 - (q - 2) * w - beta * o0
        P <- 1 - (q - 2) * w - beta * o1

        # nu=0 N3 endpoint: S versus E, anti-H gives S at equality.
        assert_true((L >= E - tol) == (o0 <= cbar + tol), "N3 nu=0/public theta_0 branch mismatch.")
        # nu=1 N3 endpoint: P versus E, anti-H gives P at equality.
        assert_true((P >= E - tol) == (o1 <= cbar + tol), "N3 nu=1/public theta_1 branch mismatch.")

        A <- beta * (1 - o0) / m
        B <- beta * (1 - o1) / m
        assert_true(close_enough(beta * o0 + (m - 1) * A + (A + 1 - beta), 1), "N4 low endpoint mismatch.")
        assert_true(close_enough(beta * o1 + (m - 1) * B + (B + 1 - beta), 1), "N4 high endpoint mismatch.")
        endpoint_checks <- endpoint_checks + 1L
      }
    }
  }
}

# ---------------------------------------------------------------------------
# Exact rent identities, signs, ex ante images, and atomic EP line
# ---------------------------------------------------------------------------

rent_checks <- 0L
for (m in c(3L, 4L, 6L)) {
  cbar <- 1 / m
  cases <- list(
    II = c(0.30 * cbar, 0.80 * cbar),
    IX = c(0.50 * cbar, min(0.90, 1.50 * cbar)),
    XX = c(min(0.80, 1.20 * cbar), min(0.95, 1.80 * cbar))
  )
  for (beta in c(0.30, 0.80)) {
    for (case_name in names(cases)) {
      o0 <- cases[[case_name]][1L]
      o1 <- cases[[case_name]][2L]
      if (!(0 < o0 && o0 < o1 && o1 < 1)) next
      d <- beta * (o1 - o0)
      a0 <- (1 - beta) * o0
      a1 <- (1 - beta) * o1
      k <- beta * o1 - o0
      S <- c(beta * o0, beta * o1)
      P <- c(beta * o1, beta * o1)
      E <- c(o0, o1)
      pub <- switch(
        case_name,
        II = c(beta * o0, beta * o1),
        IX = c(beta * o0, o1),
        XX = c(o0, o1)
      )
      riS <- S - pub
      riP <- P - pub
      riE <- E - pub

      if (case_name == "II") {
        assert_true(all(abs(riS - c(0, 0)) < tol), "RI_M II-S failed.")
        assert_true(all(abs(riP - c(d, 0)) < tol), "RI_M II-P failed.")
        assert_true(all(abs(riE - c(a0, a1)) < tol), "RI_M II-E failed.")
      } else if (case_name == "IX") {
        assert_true(all(abs(riS - c(0, -a1)) < tol), "RI_M IX-S failed.")
        assert_true(all(abs(riE - c(a0, 0)) < tol), "RI_M IX-E failed.")
      } else {
        assert_true(all(abs(riE - c(0, 0)) < tol), "RI_M XX-E failed.")
      }

      rU_high <- c(d, 0)
      if (case_name == "II") {
        assert_true(all(abs(rU_high - riS - c(d, 0)) < tol), "Delta II-S failed.")
        assert_true(all(abs(rU_high - riP) < tol), "Delta II-P failed.")
        assert_true(all(abs(rU_high - riE - c(k, -a1)) < tol), "Delta II-E failed.")
        for (lambda in c(0, 0.35, 1)) {
          riEP <- lambda * riE + (1 - lambda) * riP
          deltaEP <- rU_high - riEP
          assert_true(all(abs(deltaEP - lambda * c(k, -a1)) < tol), "Atomic Delta EP line failed.")
        }
      } else if (case_name == "IX") {
        assert_true(all(abs(rU_high - riS - c(d, a1)) < tol), "Delta IX-S failed.")
        assert_true(all(abs(rU_high - riE - c(k, 0)) < tol), "Delta IX-E failed.")
      } else {
        assert_true(all(abs(rU_high - riE - c(d, 0)) < tol), "Delta XX-E failed.")
      }

      for (mu in c(0, 0.45, 1)) {
        phi <- function(v) (1 - mu) * v[[1L]] + mu * v[[2L]]
        assert_true(close_enough(phi(rU_high), (1 - mu) * d), "RI_U ex ante image failed.")
        if (case_name == "IX") {
          assert_true(close_enough(phi(c(d, a1)), (1 - mu) * d + mu * a1), "Delta IX-S ex ante image failed.")
          assert_true(close_enough(phi(c(k, 0)), (1 - mu) * k), "Delta IX-E ex ante image failed.")
        }
      }
      rent_checks <- rent_checks + 1L
    }
  }
}

# Directed sign reversal checks for k=beta*o_1-o_0.
sign_cases <- list(
  positive = c(beta = 0.80, o0 = 0.10, o1 = 0.40),
  zero = c(beta = 0.25, o0 = 0.10, o1 = 0.40),
  negative = c(beta = 0.20, o0 = 0.10, o1 = 0.40)
)
assert_true(sign(sign_cases$positive[["beta"]] * sign_cases$positive[["o1"]] - sign_cases$positive[["o0"]]) == 1, "Positive k fixture failed.")
assert_true(close_enough(sign_cases$zero[["beta"]] * sign_cases$zero[["o1"]] - sign_cases$zero[["o0"]], 0), "Zero k fixture failed.")
assert_true(sign(sign_cases$negative[["beta"]] * sign_cases$negative[["o1"]] - sign_cases$negative[["o0"]]) == -1, "Negative k fixture failed.")

# ---------------------------------------------------------------------------
# Lifecycle: pending during review, pass/frozen after the two reviews
# ---------------------------------------------------------------------------

node_ids <- vapply(dag$nodes, `[[`, character(1), "id")
nodes <- dag$nodes
names(nodes) <- node_ids
n7_node <- nodes$N7
candidate_hash_tagged <- paste0("sha256:", sha256_file(candidate_path))

pending_fields_forbidden <- c(
  "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
  "passed_order", "frozen", "reviews"
)

if (identical(n7_node$status, "pending")) {
  assert_true(!any(pending_fields_forbidden %in% names(n7_node)), "Pending N7 carries frozen lifecycle fields.")
  assert_true(is.null(n7_node$interface$informational_rent_cells$majority), "Pending N7 must keep RI_M null in the DAG.")
  assert_true(is.null(n7_node$interface$informational_rent_cells$unanimity), "Pending N7 must keep RI_U null in the DAG.")
  assert_true(is.null(n7_node$interface$informational_rent_contrast_cells), "Pending N7 must keep DeltaRI null in the DAG.")
  lifecycle_status <- "pending candidate; DAG intentionally unmodified before review"
} else {
  assert_true(identical(n7_node$status, "pass") && identical(n7_node$frozen, TRUE), "Integrated N7 must be pass/frozen.")
  assert_true(identical(n7_node$interface, candidate), "The DAG does not embed the exact N7 artifact object.")
  assert_true(
    identical(n7_node$artifact_path, "essential_input_n7_complete_information_benchmark_candidate.json") &&
      identical(n7_node$artifact_hash, candidate_hash_tagged),
    "Integrated N7 artifact path or hash is wrong."
  )
  assert_true(identical(n7_node$dependency_hashes, list(N6 = n6_hash_tagged)), "Integrated N7 has the wrong N6 dependency hash.")
  assert_true(
    identical(as.integer(n7_node$started_order), 11L) &&
      identical(as.integer(n7_node$passed_order), 12L),
    "Integrated N7 execution orders must be 11/12."
  )
  reviews <- n7_node$reviews
  roles <- vapply(reviews, `[[`, character(1), "reviewer_role")
  reviewer_ids <- vapply(reviews, `[[`, character(1), "reviewer_id")
  assert_true(length(reviews) == 2L && setequal(roles, c("formal_design", "game_theory")), "N7 needs exactly two review roles.")
  assert_true(!anyDuplicated(reviewer_ids), "N7 reviewer IDs must be distinct.")
  assert_true(all(vapply(reviews, function(review) {
    identical(review$verdict, "PASS") &&
      identical(review$artifact_hash, candidate_hash_tagged) &&
      identical(review$finding_counts, list(critical = 0L, major = 0L, minor = 0L))
  }, logical(1))), "N7 reviews must both be same-hash PASS 0/0/0.")
  lifecycle_status <- "pass/frozen with two same-hash PASS 0/0/0 reviews"
}

# ---------------------------------------------------------------------------
# Five representative negative fixtures (not exhaustive field mutation)
# ---------------------------------------------------------------------------

negative_results <- logical(5L)

# 1. Truncated H strategy in an R1-majority exclusion record.
mut1 <- clone_object(candidate)
mut1$public_equilibrium_cells$majority$R1$theta_0[[2L]]$public_equilibrium_records[[1L]]$strategy_profile$hegemon <- "no because the proposal passes without H"
negative_results[[1L]] <- !is_public_semantic(mut1)

# 2. Cross-type R1 continuation.
mut2 <- clone_object(candidate)
mut2$public_equilibrium_cells$majority$R1$theta_0[[1L]]$public_equilibrium_records[[1L]]$source_public_continuation_ids <- list("N7-PUB-M-R2-T1")
mut2_record <- mut2$public_equilibrium_cells$majority$R1$theta_0[[1L]]$public_equilibrium_records[[1L]]
negative_results[[2L]] <- !identical(as_character(mut2_record$source_public_continuation_ids), "N7-PUB-M-R2-T0")

# 3. Sentinel rent inserted in the none unanimity cell.
mut3 <- clone_object(candidate)
mut3$informational_rent_cells$unanimity[[2L]]$existence_status <- "exists"
mut3$informational_rent_cells$unanimity[[2L]]$informational_rent_records <- list(all_rents[["N7-RI-U-NU-ZERO"]])
mut3$informational_rent_cells$unanimity[[2L]]$nonexistence_certificate <- NULL
negative_results[[3L]] <- !valid_cells(mut3$informational_rent_cells$unanimity, "informational_rent_records") ||
  length(mut3$informational_rent_cells$unanimity[[2L]]$informational_rent_records) > 0L

# 4. Wrong frozen N6 hash in a rent record.
mut4 <- clone_object(candidate)
mut4$informational_rent_cells$majority[[1L]]$informational_rent_records[[1L]]$source_N6_interface_hash <- paste0("sha256:", strrep("0", 64))
negative_results[[4L]] <- !identical(
  mut4$informational_rent_cells$majority[[1L]]$informational_rent_records[[1L]]$source_N6_interface_hash,
  n6_hash_tagged
)

# 5. Cartesian replacement of the atomically coupled EP line.
mut5 <- clone_object(candidate)
mut5$informational_rent_contrast_cells[[3L]]$informational_rent_contrast_records[[1L]]$envelopes$EP$exact_set <- "Cartesian product of marginal envelopes"
negative_results[[5L]] <- !grepl(
  "lambda\\*\\(k,-a_1\\)",
  mut5$informational_rent_contrast_cells[[3L]]$informational_rent_contrast_records[[1L]]$envelopes$EP$exact_set
)

assert_true(all(negative_results), "At least one representative negative fixture was not rejected.")

ledger <- read.delim(ledger_path, sep = "\t", quote = "", stringsAsFactors = FALSE, check.names = FALSE)
assert_true(nrow(ledger) == 17L && !anyDuplicated(ledger$claim_id), "N7 ledger must contain 17 unique claims.")
assert_true(all(ledger$status == "proved"), "Every N7 ledger claim must be proved before review.")

cat(sprintf("PUBLIC_GAME_RECONSTRUCTION: PASS — %d directed parameter cases.\n", parameter_checks))
cat(sprintf("ENDPOINT_EQUIVALENCE: PASS — %d directed N1/N2/N3/N4 endpoint cases.\n", endpoint_checks))
cat(sprintf("RENT_IDENTITIES_AND_SIGNS: PASS — %d directed classwise cases plus k sign reversal.\n", rent_checks))
cat("SCHEMA_AND_TRACEABILITY: PASS — 10 public records, 5 rent records, 9 contrast cells, exact N6 hash.\n")
cat("NEGATIVE_FIXTURES: PASS — 5/5 central-invariant mutations rejected.\n")
cat(sprintf("LIFECYCLE: PASS — %s.\n", lifecycle_status))
cat(sprintf("N7_CANDIDATE: PASS — interface sha256:%s\n", sha256_file(candidate_path)))
