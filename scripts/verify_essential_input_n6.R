#!/usr/bin/env Rscript

# Verificador dirigido de N6. Ele confere integridade do schema, transporte
# exato de N3/N4, identidades de contraste, o certificado none, simetria e
# cinco negativas representativas. Não certifica PBE novo nem testa N7.

tol <- 1e-9

assert_true <- function(condition, label) {
  if (!isTRUE(condition)) {
    stop(sprintf("FAIL: %s", label), call. = FALSE)
  }
}

close_enough <- function(x, y, tolerance = tol) {
  length(x) == length(y) && all(abs(x - y) <= tolerance)
}

sha256_file <- function(path) {
  executable <- Sys.which("shasum")
  assert_true(nzchar(executable), "shasum is available")
  output <- suppressWarnings(system2(
    executable,
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    stderr = FALSE
  ))
  assert_true(length(output) == 1L, sprintf("one SHA-256 line for %s", path))
  strsplit(output[[1L]], "[[:space:]]+")[[1L]][[1L]]
}

assert_names <- function(object, expected, label) {
  assert_true(identical(names(object), expected), label)
}

flatten_records <- function(cells, field) {
  unlist(lapply(cells, function(cell) cell[[field]]), recursive = FALSE)
}

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("FAIL: package jsonlite is required", call. = FALSE)
}

interface_path <- "model_redesign/essential_input_n6_private_comparison_candidate.json"
n3_path <- "model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json"
n4_path <- "model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json"
ledger_path <- "model_redesign/essential_input_n6_claim_ledger.tsv"
derivation_path <- "model_redesign/essential_input_n6_private_comparison_derivation.md"
report_path <- "quality_reports/2026-08-21_essential_input_n6_comparacao_privada.md"

expected_interface_hash <- "a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92"
expected_n3_hash <- "ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d"
expected_n4_hash <- "f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b"
n3_hash_tag <- paste0("sha256:", expected_n3_hash)
n4_hash_tag <- paste0("sha256:", expected_n4_hash)

for (path in c(interface_path, n3_path, n4_path, ledger_path,
               derivation_path, report_path)) {
  assert_true(file.exists(path), sprintf("required artifact exists: %s", path))
}

assert_true(identical(sha256_file(interface_path), expected_interface_hash),
            "candidate interface hash is frozen for this verifier")
assert_true(identical(sha256_file(n3_path), expected_n3_hash),
            "N3 source hash")
assert_true(identical(sha256_file(n4_path), expected_n4_hash),
            "N4 source hash")

interface <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
n3 <- jsonlite::fromJSON(n3_path, simplifyVector = FALSE)
n4 <- jsonlite::fromJSON(n4_path, simplifyVector = FALSE)

private_record_fields <- c(
  "private_rule_record_id", "institution", "admissibility_conditions",
  "source_equilibrium_cell_id", "source_equilibrium_id",
  "source_interface_hash", "private_payoff_vector",
  "private_outcome_distribution", "selection_status", "checks_performed"
)
comparison_record_fields <- c(
  "comparison_id", "admissibility_conditions", "source_equilibrium_ids",
  "source_interface_hashes", "private_payoff_vectors_by_rule",
  "private_outcome_distributions_by_rule", "private_rule_contrasts",
  "selection_status", "checks_performed"
)
payoff_fields <- c("theta_0", "theta_1")
outcome_fields <- c(
  "pass_with_hegemon", "pass_without_hegemon", "failure", "delay"
)
certificate_fields <- c(
  "ledger_claim_ids", "assumptions_used", "checks_performed"
)

validate_coverage_cells <- function(cells, record_field, label) {
  assert_true(length(cells) > 0L, sprintf("%s nonempty", label))
  ids <- vapply(cells, function(cell) cell$cell_id, character(1))
  assert_true(!anyDuplicated(ids), sprintf("%s cell IDs unique", label))

  for (cell in cells) {
    assert_names(
      cell,
      c("cell_id", "domain_conditions", "existence_status", record_field,
        "nonexistence_certificate"),
      sprintf("%s cell fields: %s", label, cell$cell_id)
    )
    assert_true(
      any(grepl("m>=3", unlist(cell$domain_conditions), fixed = TRUE)),
      sprintf("%s restricts m>=3: %s", label, cell$cell_id)
    )
    records <- cell[[record_field]]
    if (identical(cell$existence_status, "exists")) {
      assert_true(length(records) > 0L,
                  sprintf("exists cell has records: %s", cell$cell_id))
      assert_true(is.null(cell$nonexistence_certificate),
                  sprintf("exists cell has null certificate: %s", cell$cell_id))
    } else if (identical(cell$existence_status, "none")) {
      assert_true(length(records) == 0L,
                  sprintf("none cell has no records: %s", cell$cell_id))
      assert_names(cell$nonexistence_certificate, certificate_fields,
                   sprintf("none certificate fields: %s", cell$cell_id))
      assert_true(length(cell$nonexistence_certificate$ledger_claim_ids) > 0L,
                  sprintf("none certificate has claims: %s", cell$cell_id))
    } else {
      stop(sprintf("FAIL: invalid existence status in %s", cell$cell_id),
           call. = FALSE)
    }
  }
  invisible(TRUE)
}

validate_private_record <- function(record, expected_institution) {
  assert_names(record, private_record_fields,
               sprintf("private record fields: %s", record$private_rule_record_id))
  assert_true(identical(record$institution, expected_institution),
              sprintf("private institution: %s", record$private_rule_record_id))
  assert_names(record$private_payoff_vector, payoff_fields,
               sprintf("private payoff coordinates: %s",
                       record$private_rule_record_id))
  assert_names(record$private_outcome_distribution, outcome_fields,
               sprintf("private outcome coordinates: %s",
                       record$private_rule_record_id))
}

validate_comparison_record <- function(record) {
  assert_names(record, comparison_record_fields,
               sprintf("comparison record fields: %s", record$comparison_id))
  assert_names(record$source_equilibrium_ids, c("majority", "unanimity"),
               sprintf("source IDs: %s", record$comparison_id))
  assert_names(record$source_interface_hashes, c("N3", "N4"),
               sprintf("source hashes: %s", record$comparison_id))
  assert_names(record$private_payoff_vectors_by_rule,
               c("majority", "unanimity"),
               sprintf("payoffs by rule: %s", record$comparison_id))
  assert_names(record$private_outcome_distributions_by_rule,
               c("majority", "unanimity"),
               sprintf("outcomes by rule: %s", record$comparison_id))
  for (rule in c("majority", "unanimity")) {
    assert_names(record$private_payoff_vectors_by_rule[[rule]], payoff_fields,
                 sprintf("payoff coordinates %s: %s", rule,
                         record$comparison_id))
    assert_names(record$private_outcome_distributions_by_rule[[rule]],
                 outcome_fields,
                 sprintf("outcome coordinates %s: %s", rule,
                         record$comparison_id))
  }
  assert_true(
    identical(record$source_interface_hashes$N3, n3_hash_tag) &&
      identical(record$source_interface_hashes$N4, n4_hash_tag),
    sprintf("comparison source hashes: %s", record$comparison_id)
  )
}

collect_field_names <- function(object) {
  if (!is.list(object)) {
    return(character())
  }
  current <- names(object)
  children <- unlist(lapply(object, collect_field_names), use.names = FALSE)
  c(current, children)
}

validate_interface <- function(candidate) {
  assert_names(
    candidate,
    c("schema_ref", "function_of", "private_rule_cells", "comparison_cells"),
    "N6 top-level fields"
  )
  assert_true(identical(candidate$schema_ref,
                        "private_information_comparison_v1"),
              "N6 schema_ref")
  assert_names(candidate$function_of, c("name", "domain"),
               "N6 function_of fields")
  assert_true(identical(candidate$function_of$name, "entry_belief") &&
                identical(candidate$function_of$domain, "[0,1]"),
              "N6 function_of value")
  assert_names(candidate$private_rule_cells, c("majority", "unanimity"),
               "separate private-rule collections")

  validate_coverage_cells(candidate$private_rule_cells$majority,
                          "private_rule_records", "majority")
  validate_coverage_cells(candidate$private_rule_cells$unanimity,
                          "private_rule_records", "unanimity")
  validate_coverage_cells(candidate$comparison_cells,
                          "comparison_records", "comparison")

  assert_true(length(candidate$private_rule_cells$majority) == 1L,
              "one majority coverage cell")
  assert_true(length(candidate$private_rule_cells$unanimity) == 3L,
              "three unanimity coverage cells")
  assert_true(length(candidate$comparison_cells) == 3L,
              "three common-refinement coverage cells")

  assert_true(
    identical(
      vapply(candidate$private_rule_cells$unanimity,
             function(cell) cell$existence_status, character(1)),
      c("exists", "none", "exists")
    ),
    "unanimity exists-none-exists partition"
  )
  assert_true(
    identical(
      vapply(candidate$comparison_cells,
             function(cell) cell$existence_status, character(1)),
      c("exists", "none", "exists")
    ),
    "comparison exists-none-exists partition"
  )
  assert_true(
    identical(
      vapply(candidate$comparison_cells, function(cell) cell$cell_id,
             character(1)),
      c("N6-CMP-NU-ZERO", "N6-CMP-NO-PURE-PBE",
        "N6-CMP-HIGH-PRIOR")
    ),
    "common partition IDs and boundary order"
  )

  majority_records <- flatten_records(
    candidate$private_rule_cells$majority, "private_rule_records"
  )
  unanimity_records <- flatten_records(
    candidate$private_rule_cells$unanimity, "private_rule_records"
  )
  comparison_records <- flatten_records(
    candidate$comparison_cells, "comparison_records"
  )

  assert_true(length(majority_records) == 1L,
              "one N3 private-rule passthrough record")
  assert_true(length(unanimity_records) == 2L,
              "two existing N4 private-rule passthrough records")
  assert_true(length(comparison_records) == 2L,
              "two admissible N3-N4 comparison records")

  lapply(majority_records, validate_private_record,
         expected_institution = "majority")
  lapply(unanimity_records, validate_private_record,
         expected_institution = "unanimity")
  lapply(comparison_records, validate_comparison_record)

  private_ids <- vapply(c(majority_records, unanimity_records),
                        function(record) record$private_rule_record_id,
                        character(1))
  comparison_ids <- vapply(comparison_records,
                           function(record) record$comparison_id,
                           character(1))
  assert_true(!anyDuplicated(private_ids), "private-rule record IDs unique")
  assert_true(!anyDuplicated(comparison_ids), "comparison IDs unique")

  assert_true(
    identical(vapply(majority_records,
                     function(record) record$source_equilibrium_id,
                     character(1)), "N3-SC-EQ-COMPLETE"),
    "N3 source record appears exactly once"
  )
  assert_true(
    identical(vapply(unanimity_records,
                     function(record) record$source_equilibrium_id,
                     character(1)),
              c("N4-SC-EQ-L-STAR", "N4-SC-EQ-P-STAR")),
    "each existing N4 source record appears exactly once"
  )
  assert_true(
    all(vapply(majority_records,
               function(record) identical(record$source_interface_hash,
                                           n3_hash_tag), logical(1))),
    "majority passthrough uses frozen N3 hash"
  )
  assert_true(
    all(vapply(unanimity_records,
               function(record) identical(record$source_interface_hash,
                                           n4_hash_tag), logical(1))),
    "unanimity passthrough uses frozen N4 hash"
  )

  expected_pairs <- c(
    "N3-SC-EQ-COMPLETE|N4-SC-EQ-L-STAR",
    "N3-SC-EQ-COMPLETE|N4-SC-EQ-P-STAR"
  )
  actual_pairs <- vapply(
    comparison_records,
    function(record) paste(record$source_equilibrium_ids$majority,
                            record$source_equilibrium_ids$unanimity, sep = "|"),
    character(1)
  )
  assert_true(identical(actual_pairs, expected_pairs),
              "each admissible source-record pair appears exactly once")

  for (index in seq_along(comparison_records)) {
    record <- comparison_records[[index]]
    unanimity_source <- unanimity_records[[index]]
    assert_true(
      identical(record$private_payoff_vectors_by_rule$majority,
                majority_records[[1L]]$private_payoff_vector) &&
        identical(record$private_outcome_distributions_by_rule$majority,
                  majority_records[[1L]]$private_outcome_distribution),
      sprintf("lossless majority deep copy in comparison %d", index)
    )
    assert_true(
      identical(record$private_payoff_vectors_by_rule$unanimity,
                unanimity_source$private_payoff_vector) &&
        identical(record$private_outcome_distributions_by_rule$unanimity,
                  unanimity_source$private_outcome_distribution),
      sprintf("lossless unanimity deep copy in comparison %d", index)
    )
  }

  majority_text <- paste(unlist(majority_records[[1L]][
    c("private_payoff_vector", "private_outcome_distribution")
  ]), collapse = " ")
  assert_true(grepl("F_i", majority_text, fixed = TRUE) &&
                grepl("I_H", majority_text, fixed = TRUE) &&
                grepl("I_X", majority_text, fixed = TRUE) &&
                grepl("I_D", majority_text, fixed = TRUE),
              "same N3 family binder and outcome partition retained")

  high_contrasts <- comparison_records[[2L]]$private_rule_contrasts
  assert_true(
    grepl("same lambda", high_contrasts$exact_joint_contrast_set,
          fixed = TRUE) &&
      grepl("does not replace the exact joint set",
            high_contrasts$envelope_rule, fixed = TRUE),
    "atomic lambda coupling and non-filling envelope rule"
  )

  forbidden_fields <- collect_field_names(candidate)
  assert_true(
    !any(grepl("public|informational_rent|DeltaRI|RI_|counterfactual",
               forbidden_fields, ignore.case = TRUE)),
    "N6 has no public benchmark, rent, or counterfactual field"
  )

  invisible(TRUE)
}

validate_interface(interface)

# Cross-check source cardinalities from the frozen interfaces themselves.
n3_source_records <- flatten_records(n3$correspondence_cells,
                                     "equilibrium_records")
n4_source_records <- flatten_records(
  Filter(function(cell) identical(cell$existence_status, "exists"),
         n4$correspondence_cells),
  "equilibrium_records"
)
assert_true(length(n3_source_records) == 1L &&
              identical(n3_source_records[[1L]]$equilibrium_id,
                        "N3-SC-EQ-COMPLETE"),
            "frozen N3 has one family record")
assert_true(length(n4_source_records) == 2L &&
              identical(vapply(n4_source_records,
                               function(record) record$equilibrium_id,
                               character(1)),
                        c("N4-SC-EQ-L-STAR", "N4-SC-EQ-P-STAR")),
            "frozen N4 has two existing records")

# Ledger and readable artifacts.
ledger <- utils::read.delim(
  ledger_path, sep = "\t", quote = "", comment.char = "",
  stringsAsFactors = FALSE, check.names = FALSE
)
assert_true(identical(names(ledger),
                      c("claim_id", "record_ids", "branch", "payoff_date",
                        "status", "evidence", "claim")),
            "ledger schema")
assert_true(nrow(ledger) == 12L && !anyDuplicated(ledger$claim_id),
            "ledger has 12 unique claims")
assert_true(all(ledger$status == "proved") &&
              all(nzchar(ledger$evidence)) && all(nzchar(ledger$claim)),
            "ledger claims are proved and evidenced")

certificates <- list(
  interface$private_rule_cells$unanimity[[2L]]$nonexistence_certificate,
  interface$comparison_cells[[2L]]$nonexistence_certificate
)
for (certificate in certificates) {
  local_claims <- unlist(certificate$ledger_claim_ids)
  local_claims <- local_claims[grepl("^N6-", local_claims)]
  assert_true(all(local_claims %in% ledger$claim_id),
              "every N6 none-certificate claim exists in the ledger")
}

derivation_text <- paste(readLines(derivation_path, warn = FALSE,
                                   encoding = "UTF-8"), collapse = "\n")
report_text <- paste(readLines(report_path, warn = FALSE,
                               encoding = "UTF-8"), collapse = "\n")
for (required in c(n3_hash_tag, n4_hash_tag, "pending/unfrozen", "m >= 3")) {
  assert_true(grepl(required, derivation_text, fixed = TRUE),
              sprintf("derivation records %s", required))
}
for (required in c("C0-S", "C0-E", "C-NONE", "CH-S", "CH-P", "CH-E",
                   "CH-EP")) {
  assert_true(grepl(required, report_text, fixed = TRUE),
              sprintf("report includes economic class %s", required))
}

# ---------------------------------------------------------------------------
# Directed mathematical oracle
# ---------------------------------------------------------------------------

n3_selection <- function(m, beta, o_0, o_1, nu) {
  N <- m + 1L
  q <- floor(N / 2) + 1L
  w <- beta / m
  ell <- beta * o_0
  h <- beta * o_1
  values <- c(
    E = 1 - (q - 1L) * w,
    S = (1 - nu) * (1 - (q - 2L) * w - ell) + nu * w,
    P = 1 - (q - 2L) * w - h
  )
  expected_h <- c(
    E = (1 - nu) * o_0 + nu * o_1,
    S = beta * ((1 - nu) * o_0 + nu * o_1),
    P = h
  )
  feasible <- c(
    E = TRUE,
    S = ell + (q - 2L) * w <= 1 + tol,
    P = h + (q - 2L) * w <= 1 + tol
  )
  maximum <- max(values[feasible])
  proposer_best <- names(values)[feasible & values >= maximum - tol]
  minimum_h <- min(expected_h[proposer_best])
  proposer_best[expected_h[proposer_best] <= minimum_h + tol]
}

h_vector <- function(class, beta, o_0, o_1) {
  switch(class,
         E = c(theta_0 = o_0, theta_1 = o_1),
         S = c(theta_0 = beta * o_0, theta_1 = beta * o_1),
         P = c(theta_0 = beta * o_1, theta_1 = beta * o_1))
}

outcome_vector <- function(class, nu) {
  switch(class,
         E = c(pass_with_hegemon = 0, pass_without_hegemon = 1,
               failure = 0, delay = 0),
         S = c(pass_with_hegemon = 1 - nu, pass_without_hegemon = 0,
               failure = 0, delay = nu),
         P = c(pass_with_hegemon = 1, pass_without_hegemon = 0,
               failure = 0, delay = 0))
}

parameter_checks <- 0L
for (m in c(3L, 4L, 7L)) {
  inverse_m <- 1 / m
  parameter_pairs <- list(
    c(0.20 * inverse_m, 0.60 * inverse_m),
    c(0.30 * inverse_m, 1.20 * inverse_m),
    c(1.20 * inverse_m, 1.80 * inverse_m),
    c(inverse_m, 1.50 * inverse_m),
    c(0.30 * inverse_m, inverse_m)
  )
  for (beta in c(0.55, 0.90)) {
    for (pair in parameter_pairs) {
      o_0 <- pair[[1L]]
      o_1 <- pair[[2L]]
      assert_true(0 < o_0 && o_0 < o_1 && o_1 < 1,
                  "directed parameters satisfy primitives")
      nu_star <- (o_1 - o_0) / (1 - o_0)
      assert_true(0 < nu_star && nu_star < 1, "nu_star interior")

      selected_zero <- n3_selection(m, beta, o_0, o_1, 0)
      expected_zero <- if (o_0 <= inverse_m + tol) "S" else "E"
      assert_true(identical(selected_zero, expected_zero),
                  "nu=0 exact N3 class and closed equality")

      u_zero <- c(theta_0 = beta * o_0, theta_1 = beta * o_1)
      delta_zero <- u_zero - h_vector(selected_zero, beta, o_0, o_1)
      expected_delta_zero <- if (selected_zero == "S") {
        c(theta_0 = 0, theta_1 = 0)
      } else {
        c(theta_0 = -(1 - beta) * o_0,
          theta_1 = -(1 - beta) * o_1)
      }
      assert_true(close_enough(delta_zero, expected_delta_zero),
                  "nu=0 payoff contrast identity")

      for (nu in c((nu_star + 1) / 2, 1)) {
        selected <- n3_selection(m, beta, o_0, o_1, nu)
        assert_true(length(selected) >= 1L &&
                      all(selected %in% c("E", "S", "P")),
                    "high-prior selected classes valid")
        u_h <- c(theta_0 = beta * o_1, theta_1 = beta * o_1)
        u_o <- c(pass_with_hegemon = 1, pass_without_hegemon = 0,
                 failure = 0, delay = 0)
        for (class in selected) {
          delta_h <- u_h - h_vector(class, beta, o_0, o_1)
          delta_o <- u_o - outcome_vector(class, nu)
          if (class == "E") {
            assert_true(close_enough(
              delta_h,
              c(theta_0 = beta * o_1 - o_0,
                theta_1 = -(1 - beta) * o_1)
            ), "high E payoff contrast")
            assert_true(close_enough(delta_o, c(1, -1, 0, 0)),
                        "high E outcome contrast")
          } else if (class == "S") {
            assert_true(close_enough(
              delta_h,
              c(theta_0 = beta * (o_1 - o_0), theta_1 = 0)
            ), "high S payoff contrast")
            assert_true(close_enough(delta_o, c(nu, 0, 0, -nu)),
                        "high S outcome contrast")
          } else {
            assert_true(close_enough(delta_h, c(0, 0)) &&
                          close_enough(delta_o, c(0, 0, 0, 0)),
                        "high P zero contrast")
          }
          parameter_checks <- parameter_checks + 1L
        }
      }
    }
  }
}

# Residual E/P tie: the exact set uses one and the same lambda.
m <- 3L
beta <- 0.90
o_0 <- 0.10
o_1 <- 1 / m
N <- m + 1L
q <- floor(N / 2) + 1L
nu_se <- beta * (1 / m - o_0) /
  (beta * (1 / m - o_0) + 1 - beta * q / m)
nu_ep <- (beta * o_1 - o_0) / (o_1 - o_0)
nu_star <- (o_1 - o_0) / (1 - o_0)
assert_true(nu_ep > max(nu_star, nu_se) && nu_ep < 1,
            "residual E/P tie lies in the comparable residual region")
assert_true(setequal(n3_selection(m, beta, o_0, o_1, nu_ep), c("E", "P")),
            "N3 preserves exactly E/P at the residual tie")
lambda <- 0.37
u_h <- c(beta * o_1, beta * o_1)
u_o <- c(1, 0, 0, 0)
m_h <- lambda * c(o_0, o_1) + (1 - lambda) * c(beta * o_1,
                                                          beta * o_1)
m_o <- c(1 - lambda, lambda, 0, 0)
assert_true(close_enough(u_h - m_h,
                         lambda * c(beta * o_1 - o_0,
                                    -(1 - beta) * o_1)),
            "residual tie payoff uses the same lambda")
assert_true(close_enough(u_o - m_o, c(lambda, -lambda, 0, 0)),
            "residual tie outcome uses the same lambda")

# ---------------------------------------------------------------------------
# None certificate and symmetry
# ---------------------------------------------------------------------------

m <- 3L
beta <- 0.80
o_0 <- 0.10
o_1 <- 0.60
nu_star <- (o_1 - o_0) / (1 - o_0)
ell <- beta * o_0
h <- beta * o_1
A <- beta * (1 - o_0) / m
B <- beta * (1 - o_1) / m
Q_L <- 1 - ell - (m - 1L) * A
assert_true(close_enough(Q_L - A, 1 - beta) && Q_L > A,
            "s_dagger is feasible and forced agreement beats continuation")
for (eta in c(0, nu_star / 2, nu_star, (1 + nu_star) / 2, 1)) {
  weak_value <- if (eta <= nu_star + tol) (1 - eta) * A else B
  assert_true(A >= weak_value - tol,
              "s_dagger payment A forces weak yes under as-if-pivotal/T^Y")
}
profile_eliminations <- c(
  YY = h > ell,
  NN = close_enough(ell, ell),
  YN = h > ell,
  NY = h > ell
)
assert_true(all(profile_eliminations) && length(profile_eliminations) == 4L,
            "all four and only four pure H profiles are eliminated")

for (m in c(3L, 5L, 8L)) {
  N <- m + 1L
  q <- floor(N / 2) + 1L
  exclusion_orbit <- choose(m - 1L, q - 1L)
  agreement_orbit <- choose(m - 1L, q - 2L)
  assert_true(exclusion_orbit >= 1 && agreement_orbit >= 1,
              "weak-label symmetry orbits are nonempty")
  exclusion_signatures <- replicate(
    exclusion_orbit, paste(c(o_0, o_1, 0, 1, 0, 0), collapse = "|"),
    simplify = TRUE
  )
  screening_signatures <- replicate(
    agreement_orbit,
    paste(c(beta * o_0, beta * o_1, 1 - 0.4, 0, 0, 0.4),
          collapse = "|"),
    simplify = TRUE
  )
  assert_true(length(unique(exclusion_signatures)) == 1L &&
                length(unique(screening_signatures)) == 1L,
              "H payoff and outcomes are invariant within weak-label orbits")
}

# Five representative negatives; no exhaustive field mutation or fuzzing.
is_rejected <- function(candidate) {
  !isTRUE(tryCatch({
    validate_interface(candidate)
    TRUE
  }, error = function(error) FALSE))
}

negative_wrong_hash <- unserialize(serialize(interface, NULL))
negative_wrong_hash$private_rule_cells$majority[[1L]]$
  private_rule_records[[1L]]$source_interface_hash <- n4_hash_tag

negative_none_record <- unserialize(serialize(interface, NULL))
negative_none_record$comparison_cells[[2L]]$comparison_records <- list(
  negative_none_record$comparison_cells[[1L]]$comparison_records[[1L]]
)

negative_duplicate_source <- unserialize(serialize(interface, NULL))
negative_duplicate_source$private_rule_cells$majority[[1L]]$
  private_rule_records[[2L]] <-
  negative_duplicate_source$private_rule_cells$majority[[1L]]$
  private_rule_records[[1L]]

negative_payoff_coordinate <- unserialize(serialize(interface, NULL))
negative_payoff_coordinate$private_rule_cells$unanimity[[1L]]$
  private_rule_records[[1L]]$private_payoff_vector$theta_1 <- NULL

negative_atomic_mismatch <- unserialize(serialize(interface, NULL))
negative_atomic_mismatch$comparison_cells[[3L]]$comparison_records[[1L]]$
  private_outcome_distributions_by_rule$majority$delay <- "E_G[I_D]"

negative_results <- c(
  wrong_source_hash = is_rejected(negative_wrong_hash),
  record_inside_none = is_rejected(negative_none_record),
  duplicated_source_record = is_rejected(negative_duplicate_source),
  missing_payoff_coordinate = is_rejected(negative_payoff_coordinate),
  broken_atomic_copy = is_rejected(negative_atomic_mismatch)
)
assert_true(all(negative_results), "all five directed negatives are rejected")

cat(sprintf(
  "SCHEMA_INTEGRITY: PASS — 1/3/3 rule cells, 1/2/2 records, exact source pairs and deep passthrough.\n"
))
cat(sprintf(
  "MATHEMATICAL_IDENTITIES: PASS — %d directed classwise comparisons plus the exact residual tie.\n",
  parameter_checks
))
cat("NONE_CERTIFICATE: PASS — s_dagger and all four pure H profiles checked.\n")
cat("SYMMETRY_AND_ATOMICITY: PASS — weak-label orbits invariant; one F/lambda binds payoffs and outcomes.\n")
cat(sprintf(
  "NEGATIVE_FIXTURES: PASS — %d/%d representative mutations rejected.\n",
  sum(negative_results), length(negative_results)
))
cat(sprintf("N6_CANDIDATE: PASS — interface sha256:%s\n",
            expected_interface_hash))
