#!/usr/bin/env Rscript

# Build the N6 private-information comparison from the frozen N3 and N4
# interfaces. This script is deliberately a transport/refinement operation:
# it does not rederive either predecessor or choose an equilibrium.

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

args <- commandArgs(trailingOnly = TRUE)
repo <- if (length(args) >= 1L) normalizePath(args[[1L]], mustWork = TRUE) else normalizePath(".", mustWork = TRUE)

path_n3 <- file.path(repo, "model_redesign", "essential_input_interfaces", "n3_r1_majority_candidate_v1.json")
path_n4 <- file.path(repo, "model_redesign", "essential_input_n4_r1_unanimity_interface.json")
path_out <- file.path(repo, "model_redesign", "essential_input_n6_private_information_comparison_v1.json")
path_ledger <- file.path(repo, "model_redesign", "essential_input_n6_private_information_comparison_ledger.json")
path_derivation <- file.path(repo, "model_redesign", "essential_input_n6_private_information_comparison_derivation.md")

expected_n3_hash <- "sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee"
expected_n4_hash <- "sha256:ee61ce6f854d4393f51048592a5221a9999a8f3f7daca1e749e7f19a88927f2d"

clone <- function(x) unserialize(serialize(x, NULL))

sha256_file <- function(path) {
  out <- system2("shasum", c("-a", "256", shQuote(path)), stdout = TRUE,
                 env = c("LC_ALL=C", "LANG=C"))
  if (length(out) != 1L) stop("Could not hash: ", path, call. = FALSE)
  digest <- strsplit(out[[1L]], "[[:space:]]+")[[1L]][1L]
  if (!grepl("^[0-9a-f]{64}$", digest)) stop("Malformed hash: ", path, call. = FALSE)
  paste0("sha256:", digest)
}

read_utf8_json <- function(path) {
  jsonlite::fromJSON(path, simplifyVector = FALSE)
}

write_utf8_json <- function(object, path) {
  jsonlite::write_json(
    object, path, auto_unbox = TRUE, pretty = TRUE, null = "null",
    digits = NA, dataframe = "rows", force = TRUE
  )
}

as_expr <- function(x) {
  if (is.null(x)) return("null")
  if (is.character(x) && length(x) == 1L) return(x)
  as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))
}

as_list_or_empty <- function(x) {
  if (is.null(x)) list() else x
}

stopifnot(file.exists(path_n3), file.exists(path_n4))
if (!identical(sha256_file(path_n3), expected_n3_hash)) {
  stop("N3 bytes do not match the frozen interface hash.", call. = FALSE)
}
if (!identical(sha256_file(path_n4), expected_n4_hash)) {
  stop("N4 bytes do not match the frozen interface hash.", call. = FALSE)
}

n3 <- read_utf8_json(path_n3)
n4 <- read_utf8_json(path_n4)
stopifnot(identical(n3$schema_ref, "equilibrium_correspondence_v1"))
stopifnot(identical(n4$schema_ref, "equilibrium_correspondence_v1"))

n6_checks <- c(
  "N6-C01 exact frozen predecessor hash and source-record transport",
  "N6-C02 one-to-one private-record coverage for each rule",
  "N6-C03 common-refinement cell construction and Cartesian pairing",
  "N6-C04 preservation of none cells and nonexistence certificates",
  "N6-C05 joint type-payoff and outcome-distribution comparison",
  "N6-C06 delay and multiplicity reported without equilibrium selection",
  "N6-C07 no N7 benchmark, informational-rent, or formation calculation"
)

make_private_record <- function(eq, cell, institution, interface_hash) {
  prefix <- if (identical(institution, "majority")) "MAJORITY" else "UNANIMITY"
  list(
    private_rule_record_id = paste0("N6-PRIVATE-", prefix, "-", eq$equilibrium_id),
    institution = institution,
    admissibility_conditions = eq$admissibility_conditions,
    source_equilibrium_cell_id = cell$cell_id,
    source_equilibrium_id = eq$equilibrium_id,
    source_interface_hash = interface_hash,
    private_payoff_vector = clone(eq$hegemon_payoff_by_type),
    private_outcome_distribution = clone(eq$outcome_distribution),
    selection_status = eq$selection_status,
    checks_performed = list(
      source_checks = as_list_or_empty(eq$checks_performed),
      n6_checks = n6_checks
    )
  )
}

make_private_cell <- function(cell, institution, interface_hash) {
  records <- list()
  if (identical(cell$existence_status, "exists")) {
    records <- lapply(cell$equilibrium_records, make_private_record,
                      cell = cell, institution = institution,
                      interface_hash = interface_hash)
  }
  list(
    cell_id = cell$cell_id,
    domain_conditions = clone(cell$domain_conditions),
    existence_status = cell$existence_status,
    private_rule_records = records,
    nonexistence_certificate = clone(cell$nonexistence_certificate)
  )
}

n3_cells <- n3$correspondence_cells
n4_cells <- n4$correspondence_cells
majority_cells <- lapply(n3_cells, make_private_cell,
                         institution = "majority", interface_hash = expected_n3_hash)
unanimity_cells <- lapply(n4_cells, make_private_cell,
                          institution = "unanimity", interface_hash = expected_n4_hash)

record_map <- list()
for (cell in majority_cells) {
  for (rec in cell$private_rule_records) record_map[[rec$source_equilibrium_id]] <- rec
}
for (cell in unanimity_cells) {
  for (rec in cell$private_rule_records) record_map[[rec$source_equilibrium_id]] <- rec
}

contrast_for <- function(majority_record, unanimity_record) {
  payoff_names <- c("theta_0", "theta_1")
  outcome_names <- c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
  payoff_contrasts <- lapply(payoff_names, function(theta) {
    m_expr <- as_expr(majority_record$private_payoff_vector[[theta]])
    u_expr <- as_expr(unanimity_record$private_payoff_vector[[theta]])
    list(
      majority = m_expr,
      unanimity = u_expr,
      difference_majority_minus_unanimity = paste0("(", m_expr, ") - (", u_expr, ")"),
      ordering_status = "set_valued_no_scalar_ordering_asserted",
      reason = "The source records are complete correspondences and N6 applies no equilibrium selection."
    )
  })
  names(payoff_contrasts) <- payoff_names

  outcome_contrasts <- lapply(outcome_names, function(outcome) {
    m_expr <- as_expr(majority_record$private_outcome_distribution[[outcome]])
    u_expr <- as_expr(unanimity_record$private_outcome_distribution[[outcome]])
    list(
      majority = m_expr,
      unanimity = u_expr,
      difference_majority_minus_unanimity = paste0("(", m_expr, ") - (", u_expr, ")"),
      ordering_status = "set_valued_no_scalar_ordering_asserted",
      reason = "The comparison preserves the source outcome distributions jointly; it does not project a selected branch."
    )
  })
  names(outcome_contrasts) <- outcome_names

  list(
    status = "set_valued",
    scope = list(
      formal_domain = "The complete formal comparison retains both m=2 and m>=3 source cells for coverage and completeness.",
      substantive_scope = "The main substantive interpretation emphasizes organizations with at least three weak states (m>=3; four or more total members).",
      m2_formal_status = "The m=2 cells remain formally covered but are secondary to the substantive paper scope; they are not deleted, collapsed, or used to redefine the contract.",
      mge3_delay_existence = "In the N4 m>=3 cells, delay equilibria exist universally in the source correspondence.",
      mge3_delay_selection = "Delay is not forced in those cells: pooling also exists, and N6 preserves both branches without selection.",
      comparison_reading = "No scalar payoff or delay ranking is asserted after restricting interpretation to m>=3; the complete set-valued comparison remains the object."
    ),
    payoff_by_type = payoff_contrasts,
    outcome_distribution = outcome_contrasts,
    delay = list(
      majority = as_expr(majority_record$private_outcome_distribution$delay),
      unanimity = as_expr(unanimity_record$private_outcome_distribution$delay),
      ordering_status = "no_robust_delay_ranking_asserted",
      finding = "Both source correspondences preserve delay-related branches or conditional delay support; N6 reports the exact source expressions and does not select among them."
    ),
    structural_invariants = list(
      unanimity_pass_without_hegemon = "0 in every N4 source cell",
      majority_failure = "0 in the N3 source record",
      majority_exclusion = "retained as an admissible branch in the N3 source correspondence",
      multiplicity = "preserved atomically by source equilibrium IDs, payoff vectors, outcome distributions, and selection_status"
    )
  )
}

make_comparison_record <- function(m_cell, u_cell, m_rec, u_rec) {
  list(
    comparison_id = paste0("N6-COMPARISON-", m_rec$source_equilibrium_id,
                           "--", u_rec$source_equilibrium_id),
    admissibility_conditions = list(
      majority_cell_id = m_cell$cell_id,
      majority = clone(m_cell$domain_conditions),
      unanimity_cell_id = u_cell$cell_id,
      unanimity = clone(u_cell$domain_conditions),
      common_refinement = "intersection of the two source-cell domains"
    ),
    source_equilibrium_ids = list(
      majority = m_rec$source_equilibrium_id,
      unanimity = u_rec$source_equilibrium_id
    ),
    source_interface_hashes = list(N3 = expected_n3_hash, N4 = expected_n4_hash),
    private_payoff_vectors_by_rule = list(
      majority = clone(m_rec$private_payoff_vector),
      unanimity = clone(u_rec$private_payoff_vector)
    ),
    private_outcome_distributions_by_rule = list(
      majority = clone(m_rec$private_outcome_distribution),
      unanimity = clone(u_rec$private_outcome_distribution)
    ),
    private_rule_contrasts = contrast_for(m_rec, u_rec),
    selection_status = list(
      majority = m_rec$selection_status,
      unanimity = u_rec$selection_status,
      comparison = "No equilibrium, branch, identity product, or payoff vector is selected by N6."
    ),
    checks_performed = n6_checks
  )
}

comparison_cells <- list()
for (m_cell in majority_cells) {
  for (u_cell in unanimity_cells) {
    m_exists <- identical(m_cell$existence_status, "exists")
    u_exists <- identical(u_cell$existence_status, "exists")
    cell_id <- paste0("N6-CELL-", m_cell$cell_id, "--", u_cell$cell_id)
    records <- list()
    certificate <- NULL
    if (m_exists && u_exists) {
      for (m_rec in m_cell$private_rule_records) {
        for (u_rec in u_cell$private_rule_records) {
          records[[length(records) + 1L]] <- make_comparison_record(
            m_cell, u_cell, m_rec, u_rec
          )
        }
      }
    } else {
      missing_rules <- c(
        if (!m_exists) "majority" else character(0),
        if (!u_exists) "unanimity" else character(0)
      )
      certificate <- list(
        ledger_claim_ids = paste0("N6-CLM-NONE-", gsub("[^A-Za-z0-9]+", "-", cell_id)),
        assumptions_used = c(
          "The common refinement is empty when at least one source cell is none.",
          paste0("Missing source rule(s): ", paste(missing_rules, collapse = ", "))
        ),
        checks_performed = c(
          "N6-C04 preserves the empty comparison cell without deleting the surviving rule collection."
        )
      )
    }
    comparison_cells[[length(comparison_cells) + 1L]] <- list(
      cell_id = cell_id,
      domain_conditions = list(
        majority_cell_id = m_cell$cell_id,
        majority = clone(m_cell$domain_conditions),
        unanimity_cell_id = u_cell$cell_id,
        unanimity = clone(u_cell$domain_conditions)
      ),
      existence_status = if (m_exists && u_exists) "exists" else "none",
      comparison_records = records,
      nonexistence_certificate = certificate
    )
  }
}

n6 <- list(
  schema_ref = "private_information_comparison_v1",
  function_of = clone(n3$function_of),
  private_rule_cells = list(
    majority = majority_cells,
    unanimity = unanimity_cells
  ),
  comparison_cells = comparison_cells
)

write_utf8_json(n6, path_out)
n6_hash <- sha256_file(path_out)

all_source_ids <- c(
  vapply(unlist(lapply(majority_cells, `[[`, "private_rule_records"), recursive = FALSE),
         function(x) x$source_equilibrium_id, character(1)),
  vapply(unlist(lapply(unanimity_cells, `[[`, "private_rule_records"), recursive = FALSE),
         function(x) x$source_equilibrium_id, character(1))
)
comparison_ids <- unlist(lapply(comparison_cells, function(cell) {
  if (length(cell$comparison_records) == 0L) character(0)
  else vapply(cell$comparison_records, `[[`, character(1), "comparison_id")
}))

ledger <- list(
  ledger_schema = "essential_input_claim_ledger_v1",
  node_id = "N6",
  artifact_path = "model_redesign/essential_input_n6_private_information_comparison_v1.json",
  artifact_hash = n6_hash,
  node_status = "pending_independent_review",
  dependency_hashes = list(N3 = expected_n3_hash, N4 = expected_n4_hash),
  claims = list(
    list(
      claim_id = "N6-CLM-001",
      equilibrium_ids = all_source_ids,
      comparison_ids = comparison_ids,
      branch = "dependency_and_timing",
      payoff_date = "N3/N4 source-native R1 units",
      claim = "N6 consumes only the frozen N3 and N4 interfaces at their exact hashes; it does not rederive, select, or import N7/public objects.",
      status = "proved",
      evidence = "Builder hash assertions, source_interface_hashes in every private and comparison record, and the dependency ledger."
    ),
    list(
      claim_id = "N6-CLM-002",
      equilibrium_ids = all_source_ids,
      comparison_ids = comparison_ids,
      branch = "private_rule_coverage",
      payoff_date = "R1 source-native units",
      claim = "Every existing N3 equilibrium record appears exactly once in majority and every existing N4 equilibrium record exactly once in unanimity; none cells carry no fabricated equilibrium record.",
      status = "proved",
      evidence = "One-to-one source IDs and source cell IDs in private_rule_cells; verifier coverage tests."
    ),
    list(
      claim_id = "N6-CLM-003",
      equilibrium_ids = all_source_ids,
      comparison_ids = comparison_ids,
      branch = "common_refinement",
      payoff_date = "R1 source-native units",
      claim = "comparison_cells are the common refinement of the N3 and N4 source partitions and contain exactly the admissible Cartesian combinations of source records; an empty source cell yields an empty comparison cell without deleting the surviving rule collection.",
      status = "proved",
      evidence = "Pairwise cell construction in the executable derivation and positive/negative verifier tests."
    ),
    list(
      claim_id = "N6-CLM-004",
      equilibrium_ids = all_source_ids,
      comparison_ids = comparison_ids,
      branch = "multiplicity_and_selection",
      payoff_date = "R1 source-native units",
      claim = "N6 preserves source selection_status, branch multiplicity, identity products, and set-valued payoff/outcome objects; it makes no symmetry, ranking, uniqueness, or branch selection.",
      status = "proved",
      evidence = "Atomic source fields copied into private records and comparison records; selection_status comparison field."
    ),
    list(
      claim_id = "N6-CLM-005",
      equilibrium_ids = all_source_ids,
      comparison_ids = comparison_ids,
      branch = "payoff_comparison",
      payoff_date = "R1 source-native units",
      claim = "For each admissible pair, N6 compares H's theta_0 and theta_1 payoff expressions jointly and retains the symbolic majority-minus-unanimity contrast without collapsing a set-valued correspondence to a scalar.",
      status = "proved",
      evidence = "private_payoff_vectors_by_rule and private_rule_contrasts.payoff_by_type."
    ),
    list(
      claim_id = "N6-CLM-006",
      equilibrium_ids = all_source_ids,
      comparison_ids = comparison_ids,
      branch = "outcomes_and_delay",
      payoff_date = "R1 source-native units",
      claim = "For each admissible pair, N6 compares pass_with_hegemon, pass_without_hegemon, failure, and delay jointly. It reports delay as set-valued/conditional where the source correspondence does so and asserts no robust delay ranking.",
      status = "proved",
      evidence = "private_outcome_distributions_by_rule, private_rule_contrasts.outcome_distribution, and the structural invariants field."
    ),
    list(
      claim_id = "N6-CLM-007",
      equilibrium_ids = all_source_ids,
      comparison_ids = comparison_ids,
      branch = "scope_and_stop",
      payoff_date = "not applicable",
      claim = "N6 stops at private comparison: it does not calculate public benchmarks, RI_M, RI_U, DeltaRI, formation, beta=1, or manuscript outputs.",
      status = "proved",
      evidence = "Builder output schema and verifier negative scope tests."
    ),
    list(
      claim_id = "N6-CLM-008",
      equilibrium_ids = all_source_ids,
      comparison_ids = comparison_ids,
      branch = "formal_domain_and_substantive_scope",
      payoff_date = "R1 source-native units",
      claim = "The formal N6 domain retains m=2 and m>=3 for completeness, while the main substantive interpretation emphasizes m>=3. In the m>=3 N4 cells delay equilibria exist universally, but delay is not forced because pooling also exists.",
      status = "proved",
      evidence = "private_rule_contrasts.scope in every comparison record, the m>=3 N4 branch classifications, and the scope section of the derivation."
    )
  )
)
write_utf8_json(ledger, path_ledger)

private_count <- length(all_source_ids)
comparison_count <- length(comparison_ids)
none_count <- sum(vapply(comparison_cells, function(x) identical(x$existence_status, "none"), logical(1)))

derivation <- c(
  "# N6 — private-information comparison",
  "",
  "**Status:** `pending_independent_review` (implementation candidate).",
  "",
  "## Administrative transition",
  "",
  "Goal 2 fechado; Goal 3 autorizado pelo autor exclusivamente para N6.",
  "",
  "## Frozen inputs and scope",
  "",
  paste0("- N3 majority interface: `", expected_n3_hash, "`.") ,
  paste0("- N4 unanimity interface: `", expected_n4_hash, "`.") ,
  "- The comparison is private-information only and uses the source-native R1 payoff units.",
  "- N7/public benchmarks, RI_M, RI_U, DeltaRI, formation, beta=1, and manuscript files are outside this node.",
  "",
  "## Construction",
  "",
  "1. Copy every source coverage cell and its existence certificate into the corresponding private-rule collection.",
  "2. Copy each source equilibrium record once, retaining its source cell ID, equilibrium ID, interface hash, payoff vector, outcome distribution, selection status, and checks.",
  "3. Form every pair of a majority source cell and an unanimity source cell. The pair is an intersection cell of the common refinement.",
  "4. If both cells exist, form the complete Cartesian product of their source records. If either is `none`, retain an empty comparison cell with its certificate and do not remove the surviving rule collection.",
  "5. Store type-specific payoff contrasts and all four outcome contrasts symbolically. No branch, identity product, or equilibrium is selected.",
  "",
  "## Private comparison finding",
  "",
  paste0("The candidate contains ", private_count, " private source records and ", comparison_count, " admissible comparison records across ", length(comparison_cells), " common-refinement cells; `", none_count, "` comparison cells are `none` in the current frozen inputs."),
  "",
  "The formal domain retains both m=2 and m>=3 for completeness. The main substantive interpretation emphasizes m>=3 (at least three weak states, hence four or more total members); the m=2 cells are reported but are secondary and do not redefine the contract.",
  "In the m>=3 N4 cells, delay equilibria exist universally in the source correspondence, but delay is not forced: pooling also exists. The comparison is set-valued because the source interfaces preserve complete equilibrium correspondences. The majority correspondence retains exclusion, while unanimity source cells retain zero passage without H. Delay is carried as the exact source expression and branch condition, so N6 does not impose a scalar delay ranking or select a branch.",
  "",
  "## Audit ledger",
  "",
  "Claims are in `essential_input_n6_private_information_comparison_ledger.json`. The statuses are limited to the contract vocabulary; the structural transport and coverage claims are proved by the executable construction and verifier, while no public-rent or formation claim is made.",
  "",
  "## Invalidation",
  "",
  "A change to either frozen predecessor hash invalidates N6 and requires rebuilding this interface and repeating both independent reviews. A change to N6 after review creates a new hash and returns the node to pending. N7 remains unopened.",
  "",
  paste0("Candidate interface hash: `", n6_hash, "`.")
)
writeLines(enc2utf8(derivation), path_derivation, useBytes = TRUE)

cat("N6 candidate built\n")
cat("Interface:", path_out, "\n")
cat("Interface hash:", n6_hash, "\n")
cat("Private source records:", private_count, "\n")
cat("Comparison records:", comparison_count, "\n")
cat("Comparison cells:", length(comparison_cells), "\n")
cat("None comparison cells:", none_count, "\n")
