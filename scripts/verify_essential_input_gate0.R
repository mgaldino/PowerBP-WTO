#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) {
    stop(message, call. = FALSE)
  }
}

as_character <- function(x) {
  as.character(unlist(x, use.names = FALSE))
}

clone_object <- function(x) {
  unserialize(serialize(x, NULL))
}

sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  assert_true(length(output) == 1L, paste("Could not compute SHA-256 for", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

sha256_text <- function(text) {
  path <- tempfile("essential-input-gate0-region-")
  on.exit(unlink(path), add = TRUE)
  connection <- file(path, open = "wb")
  writeBin(charToRaw(enc2utf8(text)), connection)
  close(connection)
  sha256_file(path)
}

contract_lines <- function(text) {
  strsplit(enc2utf8(text), "\n", fixed = TRUE)[[1L]]
}

unique_exact_line <- function(lines, marker) {
  indexes <- which(lines == marker)
  if (length(indexes) != 1L) {
    return(NA_integer_)
  }
  indexes[[1L]]
}

unique_matching_line <- function(lines, predicate) {
  indexes <- which(vapply(lines, predicate, logical(1)))
  if (length(indexes) != 1L) {
    return(NA_integer_)
  }
  indexes[[1L]]
}

identical_utf8_text <- function(x, y) {
  is.character(x) && length(x) == 1L &&
    is.character(y) && length(y) == 1L &&
    identical(charToRaw(enc2utf8(x)), charToRaw(enc2utf8(y)))
}

expected_beta_primitive <- "Desconto       beta in (0,1)"
expected_contract_hash <- "5c013e55b2c619b02975aaa47b0623ed86355ae652c094430d876fcf8cd86c0e"
expected_contract_region_hashes <- c(
  authorization_header = "1be8f7dfeb46d86ec5f845c70ea8398130d372430129687597a317df8d59925e",
  beta_primitive = "bb7ee3390b0f63a4d293fe8deab7d33fea725d280ad43121c615375f96bf41b4",
  delay_cost_decision = "3c4483859bc7cdaf36c8fe3c4a1c2d54a278e40980eacdaba2fb9b684ebb8f2a",
  protected_artifacts = "0f3b64ac2c54ea7ecc2c7896488ce8082405d115a3ec990100d28733b504f8e8"
)

extract_normative_contract_regions <- function(text) {
  lines <- contract_lines(text)
  header_start <- unique_exact_line(lines, "**Data:** 2026-08-12")
  header_end <- unique_matching_line(
    lines,
    function(line) startsWith(line, "### Regra de fonte normativa")
  )
  delay_start <- unique_matching_line(
    lines,
    function(line) {
      startsWith(line, "### Decis") &&
        grepl("custo estrito de atraso no baseline", line, fixed = TRUE)
    }
  )
  delay_end <- unique_matching_line(
    lines,
    function(line) {
      startsWith(line, "### Decis") &&
        grepl("conceito de solu", line, fixed = TRUE)
    }
  )
  protected_start <- unique_matching_line(
    lines,
    function(line) startsWith(line, "## 13. Fronteira de vers")
  )
  protected_end <- unique_matching_line(
    lines,
    function(line) startsWith(line, "## 14. Prompt de abertura")
  )
  primitives_start <- unique_exact_line(lines, "## 2. Primitivas")
  primitives_end <- unique_matching_line(
    lines,
    function(line) startsWith(line, "## 3. Decis")
  )
  if (
    any(is.na(c(
      header_start, header_end, delay_start, delay_end,
      protected_start, protected_end
    ))) ||
      header_start >= header_end || delay_start >= delay_end ||
      protected_start >= protected_end ||
      is.na(primitives_start) || is.na(primitives_end) ||
      primitives_start >= primitives_end
  ) {
    return(NULL)
  }
  authorization_header <- paste(
    lines[header_start:(header_end - 1L)],
    collapse = "\n"
  )
  delay_cost_decision <- paste(
    lines[delay_start:(delay_end - 1L)],
    collapse = "\n"
  )
  protected_artifacts <- paste(
    lines[protected_start:(protected_end - 1L)],
    collapse = "\n"
  )
  primitive_lines <- lines[(primitives_start + 1L):(primitives_end - 1L)]
  beta_lines <- primitive_lines[grepl("^Desconto[[:space:]]+", primitive_lines)]
  if (
    is.null(authorization_header) || is.null(delay_cost_decision) ||
      length(beta_lines) != 1L
  ) {
    return(NULL)
  }
  list(
    authorization_header = authorization_header,
    beta_primitive = beta_lines[[1L]],
    delay_cost_decision = delay_cost_decision,
    protected_artifacts = protected_artifacts
  )
}

# DECISAO AUTORAL 2026-08-23 sobre a fronteira beta=1 (finding S-2, rodada 2).
# A Secao 12 (invalidacao) NAO recebe pino regional. A cobertura de beta=1 por
# `beta_primitive`, por `delay_cost_decision` e pelo hash de arquivo inteiro foi
# julgada suficiente, e a rota de insercao pela Secao 12 e aceita como risco
# conhecido. Motivo: um pino regional compra legibilidade do diff, nao uma
# fronteira de seguranca nova -- o hash integral ja rejeita a mutacao --, e
# acrescentar pinos caso a caso gera regresso sem ganho. Nao repropor sem nova
# decisao autoral.

# Pino de regiao da Secao 13 (fronteira de versao e artefatos protegidos).
# Existe para dar segunda camada, independente do hash de arquivo inteiro, a
# mutacoes inseridas na Secao 13 -- notadamente a que autorizaria a tag final
# do Goal 5 sem aval autoral.
is_valid_protected_artifacts <- function(text) {
  regions <- extract_normative_contract_regions(text)
  !is.null(regions) &&
    identical(
      sha256_text(regions$protected_artifacts),
      unname(expected_contract_region_hashes[["protected_artifacts"]])
    )
}

# NOTA SOBRE OS grepl ABAIXO. Eles NAO constituem defesa semantica contra quem
# edite o cabecalho e recalcule os hashes: sao avaliados depois de uma igualdade
# SHA-256 exata sobre a mesma string, logo nunca decidem nada, e `grepl` testa
# presenca e nao ausencia, de modo que um ataque aditivo os satisfaz. Sua funcao
# aqui e documental: tornar legivel, a quem audite o script, qual conteudo o
# cabecalho pinado deve conter. A protecao efetiva e composta por hashes exatos,
# testes de regressao e revisao independente do diff.
is_valid_reopened_authorization <- function(text) {
  regions <- extract_normative_contract_regions(text)
  !is.null(regions) &&
    identical(
      sha256_text(regions$authorization_header),
      unname(expected_contract_region_hashes[["authorization_header"]])
    ) &&
    grepl("permanece aberto", regions$authorization_header, fixed = TRUE) &&
    grepl("falta o aval", regions$authorization_header, fixed = TRUE) &&
    grepl("b5fdefb", regions$authorization_header, fixed = TRUE) &&
    grepl("sem aval autoral", regions$authorization_header, fixed = TRUE) &&
    grepl("agenda informal", regions$authorization_header, fixed = TRUE)
}

is_valid_strict_beta_contract <- function(text) {
  regions <- extract_normative_contract_regions(text)
  !is.null(regions) &&
    identical_utf8_text(regions$beta_primitive, expected_beta_primitive) &&
    identical(
      sha256_text(regions$beta_primitive),
      unname(expected_contract_region_hashes[["beta_primitive"]])
    ) &&
    identical(
      sha256_text(regions$delay_cost_decision),
      unname(expected_contract_region_hashes[["delay_cost_decision"]])
    )
}

is_valid_contract_semantics <- function(text) {
  identical(sha256_text(text), expected_contract_hash) &&
    is_valid_reopened_authorization(text) &&
    is_valid_strict_beta_contract(text) &&
    is_valid_protected_artifacts(text)
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
manifest_path <- file.path(repository_root, "model_redesign", "essential_input_game_dag.json")
manifest_dir <- dirname(manifest_path)

expected_manifest_hash <- "36155405a635bf6842c09dcde127907ec1f6fe61bb86ec06d932d7e472abf9ab"
expected_manifest_object_hash <- "4981280db8592bfe1a61676df5bb76526cdd6cbc464e8b1a6799691fec8f1784"
assert_true(
  identical(sha256_file(manifest_path), expected_manifest_hash),
  "The Gate 0 manifest bytes differ from the approved beta<1 N1-N4/N6/N7 lifecycle snapshot."
)
manifest <- jsonlite::fromJSON(manifest_path, simplifyVector = FALSE)
canonical_manifest <- clone_object(manifest)
canonical_manifest_json <- function(candidate_manifest) {
  as.character(jsonlite::toJSON(
    candidate_manifest,
    auto_unbox = TRUE,
    null = "null",
    pretty = FALSE,
    digits = NA
  ))
}
is_valid_canonical_manifest <- function(candidate_manifest) {
  if (!is.list(candidate_manifest)) {
    return(FALSE)
  }
  identical_object <- identical(candidate_manifest, canonical_manifest)
  identical_object_hash <- identical(
    sha256_text(canonical_manifest_json(candidate_manifest)),
    expected_manifest_object_hash
  )
  isTRUE(identical_object) && isTRUE(identical_object_hash)
}
expected_manifest_fields <- c(
  "schema_version",
  "contract_path",
  "interface_hashing",
  "freeze_gate_schema",
  "invalidation_rule",
  "shared_schema_types",
  "interface_schemas",
  "nodes"
)
is_valid_manifest_top_level <- function(candidate_manifest) {
  is.list(candidate_manifest) &&
    identical(names(candidate_manifest), expected_manifest_fields)
}
assert_true(
  is_valid_manifest_top_level(manifest) && is_valid_canonical_manifest(manifest),
  "The manifest must be identical to the complete canonical N1-N4/N6/N7 lifecycle object."
)
nodes <- manifest$nodes
node_ids <- vapply(nodes, `[[`, character(1), "id")
names(nodes) <- node_ids

contract_path <- normalizePath(
  file.path(dirname(manifest_path), manifest$contract_path),
  mustWork = TRUE
)
assert_true(
  identical(sha256_file(contract_path), expected_contract_hash),
  "The canonical contract bytes differ from the author-approved strict-beta snapshot."
)
contract_text <- paste0(
  paste(readLines(contract_path, encoding = "UTF-8", warn = FALSE), collapse = "\n"),
  "\n"
)
assert_true(
  is_valid_contract_semantics(contract_text),
  paste0(
    "One of the four pinned regions -- authorization header, beta primitive, ",
    "complete strict-delay decision, or Section 13 protected artifacts -- differs ",
    "from its exact author-approved regional object/hash."
  )
)

integration_record_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_integracao_administrativa_n3_n4.md"
)
expected_integration_record_hash <- "0f654b62eb6532a8f02ead123215b49f7d6f702946362dba2b5af69da7e7009c"
assert_true(
  file.exists(integration_record_path) &&
    identical(sha256_file(integration_record_path), expected_integration_record_hash),
  "The posterior author-authorization and N3/N4 administrative integration record changed."
)

n6_authorization_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_autorizacao_goal3_n6.md"
)
expected_n6_authorization_hash <- "4c18e9bfd244b8024f2d707f714d3ce57f7b635d603def1577430899bf3951cd"
assert_true(
  file.exists(n6_authorization_path) &&
    identical(sha256_file(n6_authorization_path), expected_n6_authorization_hash),
  "The posterior author authorization limited to N6 changed."
)

n6_candidate_manifest_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_n6_candidate_review_manifest.sha256"
)
expected_n6_candidate_manifest_hash <- "a59b4db15b84ffa06d4ced1e2cc0b9b31e62be2e40502df8d339a6977f00316e"
assert_true(
  file.exists(n6_candidate_manifest_path) &&
    identical(sha256_file(n6_candidate_manifest_path), expected_n6_candidate_manifest_hash),
  "The same-hash N6 candidate review manifest changed."
)

n6_final_review_manifest_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_n6_final_review_manifest.sha256"
)
expected_n6_final_review_manifest_hash <- "eaafd074f66ab0bd5cec1c7fdc55f8d970642a55cae7a26be0586b40733fff4f"
assert_true(
  file.exists(n6_final_review_manifest_path) &&
    identical(sha256_file(n6_final_review_manifest_path), expected_n6_final_review_manifest_hash),
  "The exact N6 final review manifest changed."
)

n6_integration_record_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_integracao_final_n6.md"
)
expected_n6_integration_record_hash <- "b5ceb80cf573147a810d2e816d4cdcdfeb9703f55f0956f38a33864e23600956"
assert_true(
  file.exists(n6_integration_record_path) &&
    identical(sha256_file(n6_integration_record_path), expected_n6_integration_record_hash),
  "The final N6 integration and stop record changed."
)

n7_candidate_manifest_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_n7_candidate_review_manifest.sha256"
)
expected_n7_candidate_manifest_hash <- "a54c86df332780756c52a170f6e8f0aef113683c04402ee668a4a92c6d987b09"
assert_true(
  file.exists(n7_candidate_manifest_path) &&
    identical(sha256_file(n7_candidate_manifest_path), expected_n7_candidate_manifest_hash),
  "The same-hash N7 candidate review manifest changed."
)

n7_final_review_manifest_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_n7_final_review_manifest.sha256"
)
expected_n7_final_review_manifest_hash <- "56669e62160fb7718992170555dcca8ad46e40dd41123ad2f07d9484283bae0e"
assert_true(
  file.exists(n7_final_review_manifest_path) &&
    identical(sha256_file(n7_final_review_manifest_path), expected_n7_final_review_manifest_hash),
  "The exact N7 final review manifest changed."
)

n7_integration_record_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_integracao_final_n7.md"
)
expected_n7_integration_record_hash <- "bd4136ae84084d089905344a41edf24d6bcd91bf6e095f7b58ccb0d04a296bfc"
assert_true(
  file.exists(n7_integration_record_path) &&
    identical(sha256_file(n7_integration_record_path), expected_n7_integration_record_hash),
  "The final N7 integration and author-approval stop record changed."
)

goal4_author_closure_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_fechamento_autoral_goal4_n7.md"
)
expected_goal4_author_closure_hash <- "ca7a842b3a953ab16e76dbf518692a0d05a87d1224093a53d4ccc647624545d2"
assert_true(
  file.exists(goal4_author_closure_path) &&
    identical(sha256_file(goal4_author_closure_path), expected_goal4_author_closure_hash),
  "The exact post-freeze author approval and Goal 4 closure record changed."
)

goal5_authorization_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_autorizacao_goal5.md"
)
expected_goal5_authorization_hash <- "10e0d6d94d205e97863d908d7f4b4e99206d521636cbe30d9f76bcb6b2e68f37"
assert_true(
  file.exists(goal5_authorization_path) &&
    identical(sha256_file(goal5_authorization_path), expected_goal5_authorization_hash),
  "The author authorization that scopes the still-open Goal 5 changed."
)

assert_true(
  identical(manifest$schema_version, "essential-input-gate0-v3"),
  "The manifest must use the terminal-benchmark Gate 0 schema version."
)

freeze_gate <- manifest$freeze_gate_schema
assert_true(
  identical(freeze_gate$canonical_source, "contract Section 11"),
  "The executable freeze gate must point to the sole canonical protocol source."
)
assert_true(
  identical(
    as_character(freeze_gate$required_node_fields),
    c("status", "frozen", "artifact_hash", "reviews")
  ) &&
    identical(freeze_gate$status_value, "pass") &&
    identical(freeze_gate$frozen_value, TRUE),
  "The executable freeze gate has the wrong required node facts."
)
assert_true(
  identical(as.integer(freeze_gate$review_count), 2L) &&
    identical(
      as_character(freeze_gate$review_record_fields),
      c("reviewer_role", "reviewer_id", "verdict", "artifact_hash", "finding_counts")
    ) &&
    identical(as_character(freeze_gate$reviewer_roles), c("formal_design", "game_theory")) &&
    identical(freeze_gate$reviewer_ids_must_be_distinct, TRUE) &&
    identical(freeze_gate$verdict_value, "PASS"),
  "The executable freeze gate has the wrong two-review schema."
)
assert_true(
  identical(
    as_character(freeze_gate$finding_count_fields),
    c("critical", "major", "minor")
  ) &&
    identical(as.integer(freeze_gate$finding_count_value), 0L) &&
    grepl("exactly matches", freeze_gate$review_hash_rule, fixed = TRUE),
  "The executable freeze gate must require same-hash PASS 0/0/0 reviews."
)
assert_true(
  grepl("never sufficient author authorization", freeze_gate$topological_readiness_scope, fixed = TRUE) &&
    grepl("Section 11", freeze_gate$topological_readiness_scope, fixed = TRUE),
  "Topological readiness must not be represented as author authorization."
)

shared_types <- manifest$shared_schema_types
assert_true(
  identical(names(shared_types), c("coverage_cell_v1", "public_payoff_vector_v1")),
  "The manifest has the wrong shared schema registry."
)

coverage_schema <- shared_types$coverage_cell_v1
assert_true(
  identical(
    as_character(coverage_schema$base_fields),
    c("cell_id", "domain_conditions", "existence_status", "nonexistence_certificate")
  ) &&
    identical(as_character(coverage_schema$existence_status_values), c("exists", "none")),
  "The coverage-cell base schema is incomplete."
)
assert_true(
  identical(
    as_character(coverage_schema$nonexistence_certificate_fields),
    c("ledger_claim_ids", "assumptions_used", "checks_performed")
  ) &&
    identical(coverage_schema$partition_required, TRUE) &&
    identical(coverage_schema$cell_ids_unique_within_collection, TRUE),
  "Coverage cells must partition the domain and carry unique ids and typed certificates."
)
assert_true(
  grepl("nonempty list", coverage_schema$exists_rule, fixed = TRUE) &&
    grepl("empty list", coverage_schema$none_rule, fixed = TRUE) &&
    grepl("nonempty ledger_claim_ids", coverage_schema$none_rule, fixed = TRUE) &&
    grepl("mutually exclusive and exhaustive", coverage_schema$domain_rule, fixed = TRUE),
  "The exists/none coverage-cell invariants are incomplete."
)

public_payoff_schema <- shared_types$public_payoff_vector_v1
assert_true(
  identical(
    as_character(public_payoff_schema$fields),
    c(
      "recognized_proposer_payoff",
      "weak_nonproposer_pre_recognition_expected_value",
      "hegemon_payoff"
    )
  ) &&
    grepl("Scalar", public_payoff_schema$hegemon_payoff_rule, fixed = TRUE) &&
    grepl("fixes theta", public_payoff_schema$hegemon_payoff_rule, fixed = TRUE),
  "The public payoff vector must be typed by roles with scalar H payoff."
)

expected_ids <- c("N1", "N2", "N3", "N4", "N6", "N7")
expected_names <- c(
  N1 = "r2_majority",
  N2 = "r2_unanimity",
  N3 = "r1_majority",
  N4 = "r1_unanimity",
  N6 = "private_information_comparison",
  N7 = "complete_information_benchmark"
)
expected_rounds <- c(
  N1 = "R2",
  N2 = "R2",
  N3 = "R1",
  N4 = "R1",
  N6 = "comparison",
  N7 = "post_model_benchmark"
)
expected_institutions <- c(
  N1 = "majority",
  N2 = "unanimity",
  N3 = "majority",
  N4 = "unanimity",
  N6 = "majority_vs_unanimity",
  N7 = "majority_vs_unanimity"
)
expected_dependencies <- list(
  N1 = character(),
  N2 = character(),
  N3 = "N1",
  N4 = "N2",
  N6 = c("N3", "N4"),
  N7 = "N6"
)

assert_true(
  identical(node_ids, expected_ids),
  "The DAG must contain exactly N1, N2, N3, N4, N6, and N7 in order."
)
assert_true(length(unique(node_ids)) == 6L, "The six node ids must be unique.")
assert_true(!("N5" %in% node_ids), "N5 entry must remain absent from the baseline DAG.")

schemas <- manifest$interface_schemas
expected_schema_names <- c(
  "equilibrium_correspondence_v1",
  "private_information_comparison_v1",
  "complete_information_benchmark_v1"
)
assert_true(
  identical(names(schemas), expected_schema_names),
  "The manifest has the wrong interface schema registry."
)

equilibrium_schema <- schemas$equilibrium_correspondence_v1
assert_true(
  identical(as_character(equilibrium_schema$applies_to), c("N1", "N2", "N3", "N4")),
  "The equilibrium schema must apply exactly to N1-N4."
)
assert_true(
  identical(equilibrium_schema$cell_schema_ref, "coverage_cell_v1") &&
    identical(equilibrium_schema$cell_record_field, "equilibrium_records"),
  "The equilibrium schema must use typed coverage cells."
)
assert_true(
  identical(
    as_character(equilibrium_schema$record_fields),
    c(
      "equilibrium_id",
      "admissibility_conditions",
      "branch_classification",
      "strategy_profile",
      "belief_system",
      "source_continuation_record_ids",
      "source_interface_hashes",
      "existence_uniqueness_status",
      "selection_status",
      "assumptions_used",
      "checks_performed",
      "recognized_proposer_payoff",
      "weak_nonproposer_pre_recognition_expected_value",
      "hegemon_payoff_by_type",
      "outcome_distribution",
      "payoff_date"
    )
  ),
  "The equilibrium record schema does not preserve the required joint object."
)
assert_true(
  identical(as_character(equilibrium_schema$hegemon_payoff_by_type_fields), c("theta_0", "theta_1")),
  "The equilibrium record has the wrong H-type fields."
)
assert_true(
  identical(
    as_character(equilibrium_schema$outcome_distribution_fields),
    c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
  ),
  "The equilibrium record has the wrong outcome fields."
)

comparison_schema <- schemas$private_information_comparison_v1
assert_true(
  identical(as_character(comparison_schema$applies_to), "N6"),
  "The private comparison schema must apply exactly to N6."
)
assert_true(
  identical(comparison_schema$cell_schema_ref, "coverage_cell_v1") &&
    identical(comparison_schema$private_rule_cell_record_field, "private_rule_records") &&
    identical(comparison_schema$cell_record_field, "comparison_records"),
  "The private comparison schema must use typed coverage cells."
)
assert_true(
  identical(
    as_character(comparison_schema$private_rule_record_fields),
    c(
      "private_rule_record_id",
      "institution",
      "admissibility_conditions",
      "source_equilibrium_cell_id",
      "source_equilibrium_id",
      "source_interface_hash",
      "private_payoff_vector",
      "private_outcome_distribution",
      "selection_status",
      "checks_performed"
    )
  ),
  "The private-rule passthrough record has the wrong fields."
)
assert_true(
  identical(
    as_character(comparison_schema$record_fields),
    c(
      "comparison_id",
      "admissibility_conditions",
      "source_equilibrium_ids",
      "source_interface_hashes",
      "private_payoff_vectors_by_rule",
      "private_outcome_distributions_by_rule",
      "private_rule_contrasts",
      "selection_status",
      "checks_performed"
    )
  ),
  "The private comparison record has the wrong fields."
)
assert_true(
  identical(as_character(comparison_schema$institution_fields), c("majority", "unanimity")),
  "The private comparison schema has the wrong institution fields."
)
assert_true(
  identical(
    comparison_schema$private_rule_source_node_map,
    list(majority = "N3", unanimity = "N4")
  ) &&
    identical(
      as_character(comparison_schema$private_rule_payoff_vector_fields),
      c("theta_0", "theta_1")
    ) &&
    identical(
      as_character(comparison_schema$private_rule_outcome_distribution_fields),
      c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
    ) &&
    identical(comparison_schema$unique_private_rule_id_field, "private_rule_record_id"),
  "The N6 private-rule passthrough maps or fields are incomplete."
)
assert_true(
  grepl("exactly once", comparison_schema$private_rule_passthrough_rule, fixed = TRUE) &&
    grepl("one rule may be nonempty", comparison_schema$private_rule_passthrough_rule, fixed = TRUE),
  "N6 must preserve each private rule independently under partial existence."
)
assert_true(
  identical(as_character(comparison_schema$source_node_fields), c("N3", "N4")),
  "The private comparison schema has the wrong source-node fields."
)
assert_true(
  identical(
    as_character(comparison_schema$source_equilibrium_id_fields),
    c("majority", "unanimity")
  ) &&
    identical(as_character(comparison_schema$source_interface_hash_fields), c("N3", "N4")),
  "The private comparison schema must type the exact source ids and hashes."
)
assert_true(
  identical(
    as_character(comparison_schema$private_payoff_vector_rule_fields),
    c("majority", "unanimity")
  ) &&
    identical(
      as_character(comparison_schema$private_outcome_distribution_rule_fields),
      c("majority", "unanimity")
    ),
  "The private comparison maps must contain exactly the two institutional rules."
)
assert_true(
  identical(as_character(comparison_schema$payoff_vector_type_fields), c("theta_0", "theta_1")),
  "Each private payoff vector must have exactly the two type coordinates."
)
assert_true(
  identical(
    as_character(comparison_schema$outcome_distribution_fields),
    c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
  ) &&
    identical(comparison_schema$unique_comparison_id_field, "comparison_id"),
  "The private comparison schema has the wrong outcome fields."
)
assert_true(
  grepl("exactly one N3", comparison_schema$source_cardinality_rule, fixed = TRUE) &&
    grepl("exactly one N4", comparison_schema$source_cardinality_rule, fixed = TRUE) &&
    grepl("exactly once", comparison_schema$source_cardinality_rule, fixed = TRUE),
  "The private comparison schema must fix source cardinality and completeness."
)
assert_true(
  grepl("common refinement", comparison_schema$comparison_refinement_rule, fixed = TRUE) &&
    grepl("none wherever either", comparison_schema$comparison_refinement_rule, fixed = TRUE) &&
    grepl("without changing either", comparison_schema$comparison_refinement_rule, fixed = TRUE),
  "N6 comparison cells must not erase the surviving private-rule collection."
)

benchmark_schema <- schemas$complete_information_benchmark_v1
assert_true(
  identical(as_character(benchmark_schema$applies_to), "N7"),
  "The complete-information benchmark schema must apply exactly to N7."
)
assert_true(
  identical(benchmark_schema$cell_schema_ref, "coverage_cell_v1") &&
    identical(
      benchmark_schema$public_equilibrium_cell_record_field,
      "public_equilibrium_records"
    ) &&
    identical(
      benchmark_schema$informational_rent_cell_record_field,
      "informational_rent_records"
    ) &&
    identical(
      benchmark_schema$informational_rent_contrast_cell_record_field,
      "informational_rent_contrast_records"
    ),
  "The benchmark schema must type public, rent, and rent-contrast coverage cells."
)
assert_true(
  identical(
    as_character(benchmark_schema$public_equilibrium_record_fields),
    c(
      "public_equilibrium_id",
      "institution",
      "round",
      "theta",
      "admissibility_conditions",
      "branch_classification",
      "strategy_profile",
      "belief_system",
      "source_public_continuation_ids",
      "existence_uniqueness_status",
      "selection_status",
      "assumptions_used",
      "checks_performed",
      "payoff_vector",
      "outcome_distribution",
      "payoff_date"
    )
  ),
  "The public-equilibrium record has the wrong fields."
)
assert_true(
  identical(
    as_character(benchmark_schema$informational_rent_record_fields),
    c(
      "rent_record_id",
      "institution",
      "admissibility_conditions",
      "private_source_rule_record_id",
      "public_source_equilibrium_ids",
      "source_N6_interface_hash",
      "RI",
      "ex_ante_images",
      "envelopes",
      "selection_status",
      "robustness_indicators"
    )
  ),
  "The informational-rent record has the wrong fields."
)
assert_true(
  identical(
    as_character(benchmark_schema$informational_rent_contrast_record_fields),
    c(
      "contrast_record_id",
      "admissibility_conditions",
      "source_rent_record_ids",
      "DeltaRI",
      "ex_ante_images",
      "envelopes",
      "selection_status",
      "robustness_indicators"
    )
  ),
  "The informational-rent contrast record has the wrong fields."
)
assert_true(
  identical(as_character(benchmark_schema$institution_fields), c("majority", "unanimity")),
  "The benchmark schema has the wrong institution fields."
)
assert_true(
  identical(as_character(benchmark_schema$round_fields), c("R2", "R1")),
  "The benchmark schema must distinguish R2 from R1."
)
assert_true(
  identical(as_character(benchmark_schema$type_fields), c("theta_0", "theta_1")),
  "The benchmark schema has the wrong type fields."
)
assert_true(
  identical(
    as_character(benchmark_schema$public_record_nesting),
    c("institution", "round", "type")
  ) &&
    identical(benchmark_schema$unique_public_id_field, "public_equilibrium_id") &&
    identical(benchmark_schema$public_payoff_vector_schema_ref, "public_payoff_vector_v1"),
  "Public equilibrium records must be nested by institution, round, and type."
)
assert_true(
  grepl("R2 source_public_continuation_ids is empty", benchmark_schema$public_continuation_rule, fixed = TRUE) &&
    grepl("same institution and type", benchmark_schema$public_continuation_rule, fixed = TRUE),
  "The public continuation-id target is not fully specified."
)
assert_true(
  identical(as_character(benchmark_schema$rent_cell_nesting), "institution") &&
  identical(
    as_character(benchmark_schema$rent_public_source_nesting),
    "type"
  ) &&
    identical(benchmark_schema$rent_private_source_id_field, "private_source_rule_record_id") &&
    identical(
      as_character(benchmark_schema$rent_public_source_id_fields),
      c("theta_0", "theta_1")
    ) &&
    identical(benchmark_schema$rent_source_interface_hash_field, "source_N6_interface_hash"),
  "Rent records must identify same-rule private and public sources by type."
)
assert_true(
  identical(as_character(benchmark_schema$rent_vector_fields), c("theta_0", "theta_1")) &&
    identical(benchmark_schema$unique_rent_id_field, "rent_record_id"),
  "Each informational-rent vector must have exactly the two type coordinates."
)
assert_true(
  grepl("Exactly one rent record", benchmark_schema$rent_tuple_rule, fixed = TRUE) &&
    grepl("two R1 public equilibrium ids", benchmark_schema$rent_tuple_rule, fixed = TRUE) &&
    grepl("frozen N6 interface hash", benchmark_schema$rent_tuple_rule, fixed = TRUE) &&
    grepl("remain independent", benchmark_schema$rent_tuple_rule, fixed = TRUE) &&
    grepl("either may be nonempty", benchmark_schema$rent_independence_rule, fixed = TRUE),
  "The rent-record tuple and cardinality rule is incomplete."
)
assert_true(
  identical(
    as_character(benchmark_schema$contrast_source_rent_id_fields),
    c("majority", "unanimity")
  ) &&
    identical(as_character(benchmark_schema$contrast_vector_fields), c("theta_0", "theta_1")) &&
    identical(benchmark_schema$unique_contrast_id_field, "contrast_record_id") &&
    grepl("Exactly one contrast record", benchmark_schema$contrast_tuple_rule, fixed = TRUE) &&
    grepl("none wherever either", benchmark_schema$contrast_tuple_rule, fixed = TRUE) &&
    grepl("without changing either", benchmark_schema$contrast_tuple_rule, fixed = TRUE),
  "DeltaRI must use a separate contrast collection without erasing either RI_g."
)
assert_true(
  identical(
    as_character(benchmark_schema$outcome_distribution_fields),
    c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
  ),
  "The benchmark schema has the wrong outcome fields."
)

is_valid_nonexistence_certificate <- function(certificate) {
  is.list(certificate) &&
    identical(
      names(certificate),
      as_character(coverage_schema$nonexistence_certificate_fields)
    ) &&
    length(as_character(certificate$ledger_claim_ids)) > 0L &&
    !any(!nzchar(as_character(certificate$ledger_claim_ids))) &&
    !is.null(certificate$assumptions_used) &&
    !is.null(certificate$checks_performed)
}

is_valid_coverage_cell <- function(cell, record_field) {
  expected_fields <- c(
    "cell_id",
    "domain_conditions",
    "existence_status",
    record_field,
    "nonexistence_certificate"
  )
  if (!is.list(cell) || !identical(names(cell), expected_fields)) {
    return(FALSE)
  }
  if (!is.character(cell$cell_id) || length(cell$cell_id) != 1L || !nzchar(cell$cell_id)) {
    return(FALSE)
  }
  if (is.null(cell$domain_conditions) || length(cell$domain_conditions) == 0L) {
    return(FALSE)
  }
  if (
    !is.character(cell$existence_status) ||
      length(cell$existence_status) != 1L ||
      !(cell$existence_status %in% as_character(coverage_schema$existence_status_values))
  ) {
    return(FALSE)
  }

  records <- cell[[record_field]]
  if (!is.list(records)) {
    return(FALSE)
  }
  if (identical(cell$existence_status, "exists")) {
    return(length(records) > 0L && is.null(cell$nonexistence_certificate))
  }
  length(records) == 0L && is_valid_nonexistence_certificate(cell$nonexistence_certificate)
}

is_valid_coverage_cells <- function(cells, record_field) {
  if (!is.list(cells) || length(cells) == 0L) {
    return(FALSE)
  }
  if (!all(vapply(cells, is_valid_coverage_cell, logical(1), record_field = record_field))) {
    return(FALSE)
  }
  cell_ids <- vapply(cells, `[[`, character(1), "cell_id")
  length(unique(cell_ids)) == length(cell_ids)
}

is_valid_public_payoff_vector <- function(payoff_vector) {
  is.list(payoff_vector) &&
    identical(names(payoff_vector), as_character(public_payoff_schema$fields)) &&
    !any(vapply(payoff_vector, is.null, logical(1)))
}

equilibrium_pending_interface <- list(
  schema_ref = "equilibrium_correspondence_v1",
  function_of = list(name = "entry_belief", domain = "[0,1]"),
  correspondence_cells = NULL
)
expected_pending_interfaces <- list(
  N1 = equilibrium_pending_interface,
  N2 = equilibrium_pending_interface,
  N3 = equilibrium_pending_interface,
  N4 = equilibrium_pending_interface,
  N6 = list(
    schema_ref = "private_information_comparison_v1",
    function_of = list(name = "entry_belief", domain = "[0,1]"),
    private_rule_cells = list(majority = NULL, unanimity = NULL),
    comparison_cells = NULL
  ),
  N7 = list(
    schema_ref = "complete_information_benchmark_v1",
    function_of = list(name = "prior_mu", domain = "[0,1]"),
    public_equilibrium_cells = list(
      majority = list(
        R2 = list(theta_0 = NULL, theta_1 = NULL),
        R1 = list(theta_0 = NULL, theta_1 = NULL)
      ),
      unanimity = list(
        R2 = list(theta_0 = NULL, theta_1 = NULL),
        R1 = list(theta_0 = NULL, theta_1 = NULL)
      )
    ),
    informational_rent_cells = list(majority = NULL, unanimity = NULL),
    informational_rent_contrast_cells = NULL
  )
)

is_valid_pending_interface <- function(node_id, node) {
  node_id %in% names(expected_pending_interfaces) &&
    is.list(node) &&
    "interface" %in% names(node) &&
    identical(node$interface, expected_pending_interfaces[[node_id]])
}

for (node_id in expected_ids) {
  node <- nodes[[node_id]]
  assert_true(
    identical(node$name, unname(expected_names[[node_id]])),
    paste(node_id, "has the wrong name.")
  )
  assert_true(
    identical(node$round, unname(expected_rounds[[node_id]])) &&
      identical(node$institution, unname(expected_institutions[[node_id]])),
    paste(node_id, "has the wrong round or institution label.")
  )
  dependencies <- as_character(node$depends_on)
  assert_true(
    identical(dependencies, expected_dependencies[[node_id]]),
    paste(node_id, "has the wrong dependencies.")
  )
}

pending_node_ids <- character()
for (node_id in pending_node_ids) {
  node <- nodes[[node_id]]
  assert_true(identical(node$status, "pending"), paste(node_id, "must remain pending."))
  forbidden_fields <- c(
    "result", "artifact_path", "artifact_hash", "dependency_hashes",
    "started_order", "passed_order", "frozen", "review", "reviews"
  )
  assert_true(
    !any(forbidden_fields %in% names(node)),
    paste(node_id, "contains a result or execution field.")
  )
  assert_true(
    is_valid_pending_interface(node_id, node),
    paste(node_id, "has the wrong pending interface schema or a filled coverage-cell collection.")
  )
}

# Synthetic all-pending state retained only for negative lifecycle/readiness tests.
pending_fixture_nodes <- clone_object(nodes)
for (node_id in c("N1", "N2", "N3", "N4")) {
  pending_fixture_nodes[[node_id]]$status <- "pending"
  pending_fixture_nodes[[node_id]]$interface["correspondence_cells"] <- list(NULL)
  pending_fixture_nodes[[node_id]][c(
    "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
    "passed_order", "frozen", "reviews"
  )] <- NULL
  assert_true(
    is_valid_pending_interface(node_id, pending_fixture_nodes[[node_id]]),
    paste("Synthetic pending fixture is invalid for", node_id)
  )
}
pending_fixture_nodes$N6$status <- "pending"
pending_fixture_nodes$N6$interface <- clone_object(expected_pending_interfaces$N6)
pending_fixture_nodes$N6[c(
  "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
  "passed_order", "frozen", "reviews"
)] <- NULL
assert_true(
  is_valid_pending_interface("N6", pending_fixture_nodes$N6),
  "Synthetic pending fixture is invalid for N6."
)
pending_fixture_nodes$N7$status <- "pending"
pending_fixture_nodes$N7$interface <- clone_object(expected_pending_interfaces$N7)
pending_fixture_nodes$N7[c(
  "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
  "passed_order", "frozen", "reviews"
)] <- NULL
assert_true(
  is_valid_pending_interface("N7", pending_fixture_nodes$N7),
  "Synthetic pending fixture is invalid for N7."
)

# Coverage-cell and public-payoff schema regression tests.
valid_exists_cell <- list(
  cell_id = "cell-exists",
  domain_conditions = list(expression = "mu in [0,1]"),
  existence_status = "exists",
  equilibrium_records = list(list(equilibrium_id = "eq-1")),
  nonexistence_certificate = NULL
)
valid_none_cell <- list(
  cell_id = "cell-none",
  domain_conditions = list(expression = "mu in empty-region"),
  existence_status = "none",
  equilibrium_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-equilibrium"),
    assumptions_used = list(),
    checks_performed = list("exhaustive-deviation-check")
  )
)
assert_true(
  is_valid_coverage_cells(list(valid_exists_cell, valid_none_cell), "equilibrium_records"),
  "A typed partition with existing and nonexistent regions must validate."
)

none_with_sentinel <- valid_none_cell
none_with_sentinel$equilibrium_records <- list(list(equilibrium_id = "forbidden-sentinel"))
assert_true(
  !is_valid_coverage_cells(list(none_with_sentinel), "equilibrium_records"),
  "A nonexistent region must not contain a sentinel equilibrium record."
)

none_without_certificate <- valid_none_cell
none_without_certificate$nonexistence_certificate <- NULL
assert_true(
  !is_valid_coverage_cells(list(none_without_certificate), "equilibrium_records"),
  "A nonexistent region without a certificate must fail validation."
)

exists_without_record <- valid_exists_cell
exists_without_record$equilibrium_records <- list()
assert_true(
  !is_valid_coverage_cells(list(exists_without_record), "equilibrium_records"),
  "An existing region without an equilibrium record must fail validation."
)

duplicate_cell_id <- valid_none_cell
duplicate_cell_id$cell_id <- valid_exists_cell$cell_id
assert_true(
  !is_valid_coverage_cells(
    list(valid_exists_cell, duplicate_cell_id),
    "equilibrium_records"
  ),
  "Coverage-cell ids must be unique within a collection."
)

valid_public_payoff <- list(
  recognized_proposer_payoff = "symbolic-proposer-payoff",
  weak_nonproposer_pre_recognition_expected_value = "symbolic-weak-value",
  hegemon_payoff = "symbolic-H-payoff"
)
assert_true(
  is_valid_public_payoff_vector(valid_public_payoff),
  "A public payoff vector typed by the three roles must validate."
)
untyped_public_payoff <- list(payoff = "ambiguous")
assert_true(
  !is_valid_public_payoff_vector(untyped_public_payoff),
  "An untyped public payoff vector must fail validation."
)
missing_h_public_payoff <- valid_public_payoff
missing_h_public_payoff$hegemon_payoff <- NULL
assert_true(
  !is_valid_public_payoff_vector(missing_h_public_payoff),
  "A public payoff vector without H's scalar payoff must fail validation."
)

# Partial-existence regression: one rule's RI survives while the joint
# comparison and DeltaRI remain empty.
majority_private_exists <- list(
  cell_id = "majority-private-exists",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "exists",
  private_rule_records = list(list(private_rule_record_id = "private-M-1")),
  nonexistence_certificate = NULL
)
unanimity_private_none <- list(
  cell_id = "unanimity-private-none",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "none",
  private_rule_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-private-U"),
    assumptions_used = list(),
    checks_performed = list("source-cell-propagation")
  )
)
comparison_none <- list(
  cell_id = "comparison-none",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "none",
  comparison_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-joint-comparison"),
    assumptions_used = list(),
    checks_performed = list("common-refinement-check")
  )
)
assert_true(
  is_valid_coverage_cells(list(majority_private_exists), "private_rule_records") &&
    is_valid_coverage_cells(list(unanimity_private_none), "private_rule_records") &&
    is_valid_coverage_cells(list(comparison_none), "comparison_records"),
  "N6 must represent one surviving private rule without fabricating a joint comparison."
)

majority_rent_exists <- list(
  cell_id = "majority-rent-exists",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "exists",
  informational_rent_records = list(list(rent_record_id = "RI-M-1")),
  nonexistence_certificate = NULL
)
unanimity_rent_none <- list(
  cell_id = "unanimity-rent-none",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "none",
  informational_rent_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-RI-U"),
    assumptions_used = list(),
    checks_performed = list("same-rule-source-check")
  )
)
contrast_none <- list(
  cell_id = "contrast-none",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "none",
  informational_rent_contrast_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-DeltaRI"),
    assumptions_used = list(),
    checks_performed = list("rent-refinement-check")
  )
)
assert_true(
  is_valid_coverage_cells(list(majority_rent_exists), "informational_rent_records") &&
    is_valid_coverage_cells(list(unanimity_rent_none), "informational_rent_records") &&
    is_valid_coverage_cells(
      list(contrast_none),
      "informational_rent_contrast_records"
    ),
  "N7 must preserve RI_M when RI_U and DeltaRI are empty."
)

# Negative Gate 0 tests: pending interfaces must reject filled, old, marginal,
# or cross-family fields.
filled_private <- pending_fixture_nodes$N1
filled_private$interface$correspondence_cells <- list(valid_exists_cell)
assert_true(
  !is_valid_pending_interface("N1", filled_private),
  "A pending private node with filled correspondence cells must fail validation."
)

old_private_shape <- pending_fixture_nodes$N1
old_private_shape$interface["joint_records"] <- list(NULL)
assert_true(
  !is_valid_pending_interface("N1", old_private_shape),
  "The superseded joint-record interface must fail validation."
)

marginal_private <- pending_fixture_nodes$N1
marginal_private$interface$hegemon_payoff_by_type <- list(theta_0 = NULL, theta_1 = NULL)
assert_true(
  !is_valid_pending_interface("N1", marginal_private),
  "A private node with a marginal payoff field must fail validation."
)

benchmark_in_private <- pending_fixture_nodes$N1
benchmark_in_private$interface$complete_information_benchmark <- list()
assert_true(
  !is_valid_pending_interface("N1", benchmark_in_private),
  "A benchmark field in a private interface must fail validation."
)

filled_n6 <- pending_fixture_nodes$N6
filled_n6$interface$comparison_cells <- list(list(
  cell_id = "comparison-cell",
  domain_conditions = list(expression = "mu in [0,1]"),
  existence_status = "exists",
  comparison_records = list(list(comparison_id = "forbidden-at-gate0")),
  nonexistence_certificate = NULL
))
assert_true(
  !is_valid_pending_interface("N6", filled_n6),
  "A pending N6 with filled comparison cells must fail validation."
)

filled_n6_private_rule <- pending_fixture_nodes$N6
filled_n6_private_rule$interface$private_rule_cells$majority <- list(majority_private_exists)
assert_true(
  !is_valid_pending_interface("N6", filled_n6_private_rule),
  "A pending N6 with a filled private-rule collection must fail validation."
)

benchmark_in_n6 <- pending_fixture_nodes$N6
benchmark_in_n6$interface$public_equilibrium_cells <- list()
assert_true(
  !is_valid_pending_interface("N6", benchmark_in_n6),
  "A public-benchmark field in N6 must fail validation."
)

wrong_n7_schema <- nodes$N7
wrong_n7_schema$interface$schema_ref <- "equilibrium_correspondence_v1"
assert_true(
  !is_valid_pending_interface("N7", wrong_n7_schema),
  "N7 must reject the private equilibrium schema."
)

filled_n7 <- nodes$N7
filled_n7$interface$public_equilibrium_cells$majority$R2$theta_0 <- list(list(
  cell_id = "public-cell",
  domain_conditions = list(expression = "mu in [0,1]"),
  existence_status = "none",
  public_equilibrium_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-public-equilibrium"),
    assumptions_used = list(),
    checks_performed = list("equilibrium-existence-check")
  )
))
assert_true(
  !is_valid_pending_interface("N7", filled_n7),
  "A pending N7 with filled public-equilibrium cells must fail validation."
)

filled_n7_rent <- nodes$N7
filled_n7_rent$interface$informational_rent_cells$majority <- list(majority_rent_exists)
assert_true(
  !is_valid_pending_interface("N7", filled_n7_rent),
  "A pending N7 with filled informational-rent cells must fail validation."
)

filled_n7_contrast <- nodes$N7
filled_n7_contrast$interface$informational_rent_contrast_cells <- list(contrast_none)
assert_true(
  !is_valid_pending_interface("N7", filled_n7_contrast),
  "A pending N7 with filled DeltaRI contrast cells must fail validation."
)

assert_true(identical(manifest$interface_hashing$algorithm, "sha256"), "Interface hashing must use SHA-256.")
assert_true(
  grepl("empty correspondence", manifest$interface_hashing$artifact_rule, fixed = TRUE) &&
    grepl("nonexistence certificate", manifest$interface_hashing$artifact_rule, fixed = TRUE) &&
    grepl("null coverage-cell collections", manifest$interface_hashing$pending_rule, fixed = TRUE),
  "Hashing and pending-state rules must preserve certified empty correspondences."
)
assert_true(
  grepl("transitive descendant", manifest$invalidation_rule$interface_change, fixed = TRUE),
  "The invalidation rule must cover all transitive descendants."
)
assert_true(
  grepl("pending", manifest$invalidation_rule$descendant_reset, fixed = TRUE),
  "Invalidated descendants must return to pending."
)
assert_true(
  grepl("N7 has no derivation descendants", manifest$invalidation_rule$terminal_benchmark, fixed = TRUE),
  "The invalidation rule must isolate the terminal benchmark."
)

is_valid_finding_counts <- function(finding_counts) {
  is.list(finding_counts) &&
    identical(names(finding_counts), as_character(freeze_gate$finding_count_fields)) &&
    all(vapply(finding_counts, function(value) {
      is.numeric(value) && length(value) == 1L && !is.na(value) &&
        value == freeze_gate$finding_count_value
    }, logical(1)))
}

is_valid_review <- function(review, node_hash) {
  is.list(review) &&
    identical(names(review), as_character(freeze_gate$review_record_fields)) &&
    is.character(review$reviewer_role) && length(review$reviewer_role) == 1L &&
    review$reviewer_role %in% as_character(freeze_gate$reviewer_roles) &&
    is.character(review$reviewer_id) && length(review$reviewer_id) == 1L &&
    nzchar(review$reviewer_id) &&
    identical(review$verdict, freeze_gate$verdict_value) &&
    identical(review$artifact_hash, node_hash) &&
    is_valid_finding_counts(review$finding_counts)
}

is_frozen <- function(node) {
  valid_hash <-
    is.character(node$artifact_hash) &&
    length(node$artifact_hash) == 1L &&
    grepl("^sha256:[0-9a-f]{64}$", node$artifact_hash)
  reviews <- node$reviews
  valid_reviews <-
    is.list(reviews) &&
    length(reviews) == as.integer(freeze_gate$review_count) &&
    valid_hash &&
    all(vapply(reviews, is_valid_review, logical(1), node_hash = node$artifact_hash))

  if (isTRUE(valid_reviews)) {
    reviewer_roles <- vapply(reviews, `[[`, character(1), "reviewer_role")
    reviewer_ids <- vapply(reviews, `[[`, character(1), "reviewer_id")
    valid_reviews <-
      identical(sort(reviewer_roles), sort(as_character(freeze_gate$reviewer_roles))) &&
      length(unique(reviewer_ids)) == as.integer(freeze_gate$review_count)
  }

  identical(node$status, freeze_gate$status_value) &&
    identical(node$frozen, freeze_gate$frozen_value) &&
    isTRUE(valid_hash) &&
    isTRUE(valid_reviews)
}

is_valid_filled_equilibrium_interface <- function(interface) {
  cells <- interface$correspondence_cells
  valid_records <- is.list(cells) && length(cells) > 0L && all(vapply(cells, function(cell) {
    records <- cell$equilibrium_records
    if (!is.list(records)) {
      return(FALSE)
    }
    if (identical(cell$existence_status, "none")) {
      return(length(records) == 0L)
    }
    length(records) > 0L && all(vapply(records, function(record) {
      is.list(record) &&
        identical(names(record), as_character(equilibrium_schema$record_fields)) &&
        identical(
          names(record$hegemon_payoff_by_type),
          as_character(equilibrium_schema$hegemon_payoff_by_type_fields)
        ) &&
        identical(
          names(record$outcome_distribution),
          as_character(equilibrium_schema$outcome_distribution_fields)
        )
    }, logical(1)))
  }, logical(1)))

  is.list(interface) &&
    identical(names(interface), c("schema_ref", "function_of", "correspondence_cells")) &&
    identical(interface$schema_ref, "equilibrium_correspondence_v1") &&
    identical(names(interface$function_of), c("name", "domain")) &&
    identical(interface$function_of$name, "entry_belief") &&
    identical(interface$function_of$domain, "[0,1]") &&
    is_valid_coverage_cells(cells, "equilibrium_records") &&
    isTRUE(valid_records)
}

# N6 uses a different schema from the four equilibrium-correspondence leaves.
# This validator checks its live structural contract; exact bytes and complete
# object identity are pinned separately by is_valid_current_leaf().
is_valid_private_rule_record <- function(record, institution) {
  is.list(record) &&
    identical(
      names(record),
      as_character(comparison_schema$private_rule_record_fields)
    ) &&
    identical(record$institution, institution) &&
    identical(
      names(record$private_payoff_vector),
      as_character(comparison_schema$private_rule_payoff_vector_fields)
    ) &&
    identical(
      names(record$private_outcome_distribution),
      as_character(comparison_schema$private_rule_outcome_distribution_fields)
    ) &&
    is.character(record$source_equilibrium_cell_id) &&
    length(record$source_equilibrium_cell_id) == 1L &&
    nzchar(record$source_equilibrium_cell_id) &&
    is.character(record$source_equilibrium_id) &&
    length(record$source_equilibrium_id) == 1L &&
    nzchar(record$source_equilibrium_id) &&
    is.character(record$source_interface_hash) &&
    length(record$source_interface_hash) == 1L &&
    grepl("^sha256:[0-9a-f]{64}$", record$source_interface_hash)
}

is_valid_comparison_record <- function(record) {
  is.list(record) &&
    identical(names(record), as_character(comparison_schema$record_fields)) &&
    identical(
      names(record$source_equilibrium_ids),
      as_character(comparison_schema$source_equilibrium_id_fields)
    ) &&
    identical(
      names(record$source_interface_hashes),
      as_character(comparison_schema$source_interface_hash_fields)
    ) &&
    identical(
      names(record$private_payoff_vectors_by_rule),
      as_character(comparison_schema$private_payoff_vector_rule_fields)
    ) &&
    identical(
      names(record$private_outcome_distributions_by_rule),
      as_character(comparison_schema$private_outcome_distribution_rule_fields)
    ) &&
    all(vapply(
      record$private_payoff_vectors_by_rule,
      function(x) {
        identical(names(x), as_character(comparison_schema$payoff_vector_type_fields))
      },
      logical(1)
    )) &&
    all(vapply(
      record$private_outcome_distributions_by_rule,
      function(x) {
        identical(names(x), as_character(comparison_schema$outcome_distribution_fields))
      },
      logical(1)
    ))
}

records_from_cells <- function(cells, field) {
  unname(do.call(c, lapply(cells, function(cell) cell[[field]])))
}

is_valid_filled_private_comparison_interface <- function(interface) {
  if (
    !is.list(interface) ||
      !identical(
        names(interface),
        c("schema_ref", "function_of", "private_rule_cells", "comparison_cells")
      ) ||
      !identical(interface$schema_ref, "private_information_comparison_v1") ||
      !identical(names(interface$function_of), c("name", "domain")) ||
      !identical(interface$function_of$name, "entry_belief") ||
      !identical(interface$function_of$domain, "[0,1]") ||
      !identical(names(interface$private_rule_cells), c("majority", "unanimity"))
  ) {
    return(FALSE)
  }

  majority_cells <- interface$private_rule_cells$majority
  unanimity_cells <- interface$private_rule_cells$unanimity
  comparison_cells <- interface$comparison_cells
  if (
    !is_valid_coverage_cells(majority_cells, "private_rule_records") ||
      !is_valid_coverage_cells(unanimity_cells, "private_rule_records") ||
      !is_valid_coverage_cells(comparison_cells, "comparison_records") ||
      length(majority_cells) != 1L ||
      length(unanimity_cells) != 3L ||
      length(comparison_cells) != 3L
  ) {
    return(FALSE)
  }

  majority_records <- records_from_cells(majority_cells, "private_rule_records")
  unanimity_records <- records_from_cells(unanimity_cells, "private_rule_records")
  comparison_records <- records_from_cells(comparison_cells, "comparison_records")
  all_cells <- c(majority_cells, unanimity_cells, comparison_cells)
  length(majority_records) == 1L &&
    length(unanimity_records) == 2L &&
    length(comparison_records) == 2L &&
    all(vapply(
      majority_records,
      is_valid_private_rule_record,
      logical(1),
      institution = "majority"
    )) &&
    all(vapply(
      unanimity_records,
      is_valid_private_rule_record,
      logical(1),
      institution = "unanimity"
    )) &&
    all(vapply(comparison_records, is_valid_comparison_record, logical(1))) &&
    all(vapply(all_cells, function(cell) {
      any(grepl("m>=3", as_character(cell$domain_conditions), fixed = TRUE))
    }, logical(1)))
}

# N7 is checked here only at the terminal interface boundary. Its standalone
# verifier reconstructs the games and rent identities; this administrative
# validator checks typed collections, exact source direction, and cardinality.
is_valid_public_equilibrium_record <- function(record, institution, round, theta) {
  sources <- as_character(record$source_public_continuation_ids)
  expected_source <- paste0(
    "N7-PUB-", ifelse(identical(institution, "majority"), "M", "U"),
    "-R2-", ifelse(identical(theta, "theta_0"), "T0", "T1")
  )
  valid_sources <- if (identical(round, "R2")) {
    length(sources) == 0L
  } else {
    identical(sources, expected_source)
  }
  is.list(record) &&
    identical(names(record), as_character(benchmark_schema$public_equilibrium_record_fields)) &&
    identical(record$institution, institution) &&
    identical(record$round, round) &&
    identical(record$theta, theta) &&
    identical(names(record$payoff_vector), as_character(public_payoff_schema$fields)) &&
    identical(
      names(record$outcome_distribution),
      as_character(benchmark_schema$outcome_distribution_fields)
    ) &&
    isTRUE(valid_sources)
}

is_valid_informational_rent_record <- function(record, institution) {
  is.list(record) &&
    identical(names(record), as_character(benchmark_schema$informational_rent_record_fields)) &&
    identical(record$institution, institution) &&
    identical(
      record$source_N6_interface_hash,
      "sha256:a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92"
    ) &&
    length(as_character(record$public_source_equilibrium_ids)) > 0L &&
    is.character(record$private_source_rule_record_id) &&
    length(record$private_source_rule_record_id) == 1L &&
    nzchar(record$private_source_rule_record_id)
}

is_valid_informational_rent_contrast_record <- function(record) {
  is.list(record) &&
    identical(
      names(record),
      as_character(benchmark_schema$informational_rent_contrast_record_fields)
    ) &&
    length(as_character(record$source_rent_record_ids)) > 0L
}

is_valid_filled_complete_information_interface <- function(interface) {
  if (
    !is.list(interface) ||
      !identical(
        names(interface),
        c(
          "schema_ref", "function_of", "public_equilibrium_cells",
          "informational_rent_cells", "informational_rent_contrast_cells"
        )
      ) ||
      !identical(interface$schema_ref, "complete_information_benchmark_v1") ||
      !identical(names(interface$function_of), c("name", "domain")) ||
      !identical(interface$function_of$name, "prior_mu") ||
      !identical(interface$function_of$domain, "[0,1]") ||
      !identical(names(interface$public_equilibrium_cells), c("majority", "unanimity")) ||
      !identical(names(interface$informational_rent_cells), c("majority", "unanimity"))
  ) {
    return(FALSE)
  }

  expected_public_counts <- list(
    majority = list(R2 = c(theta_0 = 1L, theta_1 = 1L), R1 = c(theta_0 = 2L, theta_1 = 2L)),
    unanimity = list(R2 = c(theta_0 = 1L, theta_1 = 1L), R1 = c(theta_0 = 1L, theta_1 = 1L))
  )
  public_records <- list()
  for (institution in c("majority", "unanimity")) {
    institution_cells <- interface$public_equilibrium_cells[[institution]]
    if (!identical(names(institution_cells), c("R2", "R1"))) return(FALSE)
    for (round in c("R2", "R1")) {
      round_cells <- institution_cells[[round]]
      if (!identical(names(round_cells), c("theta_0", "theta_1"))) return(FALSE)
      for (theta in c("theta_0", "theta_1")) {
        cells <- round_cells[[theta]]
        if (!is_valid_coverage_cells(cells, "public_equilibrium_records")) return(FALSE)
        records <- records_from_cells(cells, "public_equilibrium_records")
        if (length(records) != expected_public_counts[[institution]][[round]][[theta]]) return(FALSE)
        if (!all(vapply(
          records,
          is_valid_public_equilibrium_record,
          logical(1),
          institution = institution,
          round = round,
          theta = theta
        ))) return(FALSE)
        public_records <- c(public_records, records)
      }
    }
  }
  public_ids <- vapply(public_records, `[[`, character(1), "public_equilibrium_id")
  if (length(public_ids) != 10L || anyDuplicated(public_ids)) return(FALSE)

  rent_records <- list()
  expected_rent_cell_counts <- c(majority = 3L, unanimity = 3L)
  expected_rent_record_counts <- c(majority = 3L, unanimity = 2L)
  for (institution in c("majority", "unanimity")) {
    cells <- interface$informational_rent_cells[[institution]]
    if (
      !is_valid_coverage_cells(cells, "informational_rent_records") ||
        length(cells) != expected_rent_cell_counts[[institution]]
    ) return(FALSE)
    records <- records_from_cells(cells, "informational_rent_records")
    if (
      length(records) != expected_rent_record_counts[[institution]] ||
        !all(vapply(
          records,
          is_valid_informational_rent_record,
          logical(1),
          institution = institution
        ))
    ) return(FALSE)
    rent_records <- c(rent_records, records)
  }
  rent_ids <- vapply(rent_records, `[[`, character(1), "rent_record_id")
  if (length(rent_ids) != 5L || anyDuplicated(rent_ids)) return(FALSE)

  contrast_cells <- interface$informational_rent_contrast_cells
  if (
    !is_valid_coverage_cells(contrast_cells, "informational_rent_contrast_records") ||
      length(contrast_cells) != 9L
  ) return(FALSE)
  contrast_records <- records_from_cells(
    contrast_cells,
    "informational_rent_contrast_records"
  )
  contrast_ids <- vapply(contrast_records, `[[`, character(1), "contrast_record_id")
  length(contrast_records) == 6L &&
    !anyDuplicated(contrast_ids) &&
    all(vapply(
      contrast_records,
      is_valid_informational_rent_contrast_record,
      logical(1)
    ))
}

# Frozen N1-N4, N6, and N7 are consumable only on exact artifact bytes, object-identical
# interfaces, dependency hashes, lifecycle fields, and same-hash PASS 0/0/0 reviews.
expected_frozen_node_fields <- c(
  "id", "name", "round", "institution", "depends_on", "status", "interface",
  "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
  "passed_order", "frozen", "reviews"
)
formal_reviewer_id <- "review-n1-n2-beta-formal-2026-08-18-r1"
game_reviewer_id <- "review-n1-n2-beta-game-2026-08-18-r1"
leaf_specs <- list(
  N1 = list(
    artifact_path = "essential_input_interfaces/n1_r2_majority_candidate_v1.json",
    artifact_hash = "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5",
    dependency_hashes = list(),
    started_order = 1L,
    passed_order = 3L,
    formal_reviewer_id = formal_reviewer_id,
    game_reviewer_id = game_reviewer_id
  ),
  N2 = list(
    artifact_path = "essential_input_n2_r2_unanimity_interface.json",
    artifact_hash = "sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2",
    dependency_hashes = list(),
    started_order = 2L,
    passed_order = 4L,
    formal_reviewer_id = formal_reviewer_id,
    game_reviewer_id = game_reviewer_id
  ),
  N3 = list(
    artifact_path = "essential_input_solution_concept/n3_r1_majority_candidate.json",
    artifact_hash = "sha256:ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d",
    dependency_hashes = list(
      N1 = "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
    ),
    started_order = 5L,
    passed_order = 7L,
    formal_reviewer_id = "codex-formal-design-n3-final-20260821",
    game_reviewer_id = "codex-game-theory-n3-final-20260821"
  ),
  N4 = list(
    artifact_path = "essential_input_solution_concept/n4_r1_unanimity_candidate.json",
    artifact_hash = "sha256:f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b",
    dependency_hashes = list(
      N2 = "sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2"
    ),
    started_order = 6L,
    passed_order = 8L,
    formal_reviewer_id = "codex-formal-design-n4-final-exclusive-20260821",
    game_reviewer_id = "codex-game-theory-n4-final-20260821"
  ),
  N6 = list(
    artifact_path = "essential_input_n6_private_comparison_candidate.json",
    artifact_hash = "sha256:a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92",
    dependency_hashes = list(
      N3 = "sha256:ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d",
      N4 = "sha256:f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b"
    ),
    started_order = 9L,
    passed_order = 10L,
    formal_reviewer_id = "codex-formal-design-n6-private-final-20260821",
    game_reviewer_id = "codex-game-theory-n6-pure-final-20260821"
  ),
  N7 = list(
    artifact_path = "essential_input_n7_complete_information_benchmark_candidate.json",
    artifact_hash = "sha256:4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45",
    dependency_hashes = list(
      N6 = "sha256:a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92"
    ),
    started_order = 11L,
    passed_order = 12L,
    formal_reviewer_id = "codex-formal-design-n7-final-20260821",
    game_reviewer_id = "codex-game-theory-n7-final-20260821"
  )
)

for (node_id in names(leaf_specs)) {
  spec <- leaf_specs[[node_id]]
  spec$artifact_full_path <- normalizePath(
    file.path(manifest_dir, spec$artifact_path),
    mustWork = TRUE
  )
  spec$artifact_object <- jsonlite::fromJSON(spec$artifact_full_path, simplifyVector = FALSE)
  spec$computed_hash <- paste0("sha256:", sha256_file(spec$artifact_full_path))
  leaf_specs[[node_id]] <- spec
}

expected_reviews <- function(spec) {
  list(
    list(
      reviewer_role = "formal_design",
      reviewer_id = spec$formal_reviewer_id,
      verdict = "PASS",
      artifact_hash = spec$artifact_hash,
      finding_counts = list(critical = 0L, major = 0L, minor = 0L)
    ),
    list(
      reviewer_role = "game_theory",
      reviewer_id = spec$game_reviewer_id,
      verdict = "PASS",
      artifact_hash = spec$artifact_hash,
      finding_counts = list(critical = 0L, major = 0L, minor = 0L)
    )
  )
}

is_valid_current_leaf <- function(node_id, node, spec) {
  valid_dependency_hashes <- if (length(spec$dependency_hashes) == 0L) {
    is.list(node$dependency_hashes) && length(node$dependency_hashes) == 0L
  } else {
    identical(node$dependency_hashes, spec$dependency_hashes)
  }
  valid_interface <- if (identical(node_id, "N6")) {
    is_valid_filled_private_comparison_interface(node$interface)
  } else if (identical(node_id, "N7")) {
    is_valid_filled_complete_information_interface(node$interface)
  } else {
    is_valid_filled_equilibrium_interface(node$interface)
  }
  identical(names(node), expected_frozen_node_fields) &&
    identical(node$id, node_id) &&
    identical(node$name, unname(expected_names[[node_id]])) &&
    identical(node$round, unname(expected_rounds[[node_id]])) &&
    identical(node$institution, unname(expected_institutions[[node_id]])) &&
    identical(as_character(node$depends_on), expected_dependencies[[node_id]]) &&
    identical(node$status, "pass") &&
    identical(node$frozen, TRUE) &&
    identical(node$artifact_path, spec$artifact_path) &&
    identical(node$artifact_hash, spec$artifact_hash) &&
    identical(node$artifact_hash, spec$computed_hash) &&
    isTRUE(valid_dependency_hashes) &&
    identical(as.integer(node$started_order), spec$started_order) &&
    identical(as.integer(node$passed_order), spec$passed_order) &&
    node$started_order < node$passed_order &&
    identical(node$interface, spec$artifact_object) &&
    isTRUE(valid_interface) &&
    identical(node$reviews, expected_reviews(spec)) &&
    is_frozen(node)
}

for (node_id in names(leaf_specs)) {
  assert_true(
    is_valid_current_leaf(node_id, nodes[[node_id]], leaf_specs[[node_id]]),
    paste(
      node_id,
      "must match its exact beta<1 artifact, dependency hashes, lifecycle, and PASS 0/0/0 reviews."
    )
  )
}
assert_true(
  identical(
    c(
      as.integer(nodes$N1$started_order),
      as.integer(nodes$N2$started_order),
      as.integer(nodes$N1$passed_order),
      as.integer(nodes$N2$passed_order)
    ),
    1:4
  ) && nodes$N2$started_order < nodes$N1$passed_order,
  "The parallel first frontier must record starts 1/2 and passes 3/4."
)
assert_true(
  identical(as.integer(nodes$N3$started_order), 5L) &&
    identical(as.integer(nodes$N3$passed_order), 7L) &&
    nodes$N2$passed_order < nodes$N3$started_order &&
    nodes$N3$started_order < nodes$N3$passed_order,
  "N3 must record start/pass orders 5/7, strictly after the first frontier passed."
)
assert_true(
  identical(as.integer(nodes$N4$started_order), 6L) &&
    identical(as.integer(nodes$N4$passed_order), 8L) &&
    nodes$N2$passed_order < nodes$N4$started_order &&
    nodes$N4$started_order < nodes$N4$passed_order &&
    nodes$N3$started_order < nodes$N4$started_order &&
    nodes$N3$passed_order < nodes$N4$passed_order,
  "N4 must record start/pass orders 6/8, after N2 passed and in the reviewed R1 frontier order."
)
assert_true(
  identical(as.integer(nodes$N6$started_order), 9L) &&
    identical(as.integer(nodes$N6$passed_order), 10L) &&
    nodes$N4$passed_order < nodes$N6$started_order &&
    nodes$N6$started_order < nodes$N6$passed_order,
  "N6 must record start/pass orders 9/10 after both private R1 interfaces passed."
)
assert_true(
  identical(as.integer(nodes$N7$started_order), 11L) &&
    identical(as.integer(nodes$N7$passed_order), 12L) &&
    nodes$N6$passed_order < nodes$N7$started_order &&
    nodes$N7$started_order < nodes$N7$passed_order,
  "N7 must record start/pass orders 11/12 after the frozen N6 comparison."
)

review_report_specs <- list(
  formal_design = list(
    path = file.path(
      repository_root,
      "quality_reports",
      "2026-08-18_essential_input_goal1_n1_n2_beta_formal_design_review_round1.md"
    ),
    expected_hash = "291e7616982828b17f496734de8515d482e0cca9c1e1b741bfe566327931dc07",
    reviewer_id = formal_reviewer_id
  ),
  game_theory = list(
    path = file.path(
      repository_root,
      "quality_reports",
      "2026-08-18_essential_input_goal1_n1_n2_beta_game_theory_review_round1.md"
    ),
    expected_hash = "b7f9764b4641e21846defdd7d119d659c6ec60fe0360b2e4f0192351c4679d59",
    reviewer_id = game_reviewer_id
  )
)

report_section <- function(lines, start_pattern, end_pattern) {
  start <- grep(start_pattern, lines)
  if (length(start) != 1L) {
    return(character())
  }
  later_end <- grep(end_pattern, lines)
  later_end <- later_end[later_end > start]
  end <- if (length(later_end) == 0L) length(lines) else later_end[[1L]] - 1L
  lines[start:end]
}

is_valid_review_report <- function(lines, role, spec) {
  if (!identical(lines, spec$canonical_lines)) {
    return(FALSE)
  }
  sections <- list(
    N1 = report_section(lines, "^## N1", "^## N2"),
    N2 = report_section(lines, "^## N2", "^## (Verificadores|Conclus)")
  )
  expected_hashes <- c(
    N1 = sub("^sha256:", "", leaf_specs$N1$artifact_hash),
    N2 = sub("^sha256:", "", leaf_specs$N2$artifact_hash)
  )
  valid_sections <- all(vapply(names(sections), function(node_id) {
    section <- sections[[node_id]]
    length(section) > 0L &&
      any(grepl(expected_hashes[[node_id]], section, fixed = TRUE)) &&
      any(grepl("PASS", section, fixed = TRUE)) &&
      any(grepl("critical[^0-9]*0", section, ignore.case = TRUE, perl = TRUE)) &&
      any(grepl("major[^0-9]*0", section, ignore.case = TRUE, perl = TRUE)) &&
      any(grepl("minor[^0-9]*0", section, ignore.case = TRUE, perl = TRUE)) &&
      !any(grepl("FAIL", section, fixed = TRUE))
  }, logical(1)))
  length(lines) > 40L &&
    any(grepl(role, lines, fixed = TRUE)) &&
    any(grepl(spec$reviewer_id, lines, fixed = TRUE)) &&
    isTRUE(valid_sections)
}

for (role in names(review_report_specs)) {
  spec <- review_report_specs[[role]]
  assert_true(file.exists(spec$path), paste("Missing saved beta<1 review report for", role))
  assert_true(
    identical(sha256_file(spec$path), spec$expected_hash),
    paste("The complete saved beta<1 review report changed for", role)
  )
  spec$canonical_lines <- readLines(spec$path, encoding = "UTF-8", warn = FALSE)
  review_report_specs[[role]] <- spec
  assert_true(
    is_valid_review_report(spec$canonical_lines, role, spec),
    paste("The saved report lacks separate same-hash PASS 0/0/0 evidence for", role)
  )
}

node_review_report_specs <- list(
  N3 = list(
    manifest_hash = "90d6d8bfc4f1ef18c7edf5f9e1ea08870aec0385e625573e31b1b63a5a3d2bd4",
    formal_design = list(
      path = file.path(
        repository_root, "quality_reports",
        "2026-08-21_n3_final_formal_design_review.md"
      ),
      expected_hash = "0863f748fe6927794a7fa8cd14b99176dcfbc1092c60a8fee6f1189a30663b7c",
      reviewer_id = leaf_specs$N3$formal_reviewer_id
    ),
    game_theory = list(
      path = file.path(
        repository_root, "quality_reports",
        "2026-08-21_n3_final_game_theory_review.md"
      ),
      expected_hash = "b90efd428c24884ffc32a1bc713d9f77f4b88efb98a903fd3606e28b1436e99f",
      reviewer_id = leaf_specs$N3$game_reviewer_id
    )
  ),
  N4 = list(
    manifest_hash = "5c252aca20ee980a6f3faef7f97570f0bc9590c86b7b216a615afede31dbd93c",
    formal_design = list(
      path = file.path(
        repository_root, "quality_reports",
        "2026-08-21_n4_final_formal_design_review.md"
      ),
      expected_hash = "69c64a2519e044a95f0ee765324b15165cca09d782d392d118adb07d81e2719a",
      reviewer_id = leaf_specs$N4$formal_reviewer_id
    ),
    game_theory = list(
      path = file.path(
        repository_root, "quality_reports",
        "2026-08-21_n4_final_game_theory_review.md"
      ),
      expected_hash = "008cd1c673354e6da4fe6827f4ac7ce48cd81ee7a82070fadd4251fd571c497d",
      reviewer_id = leaf_specs$N4$game_reviewer_id
    )
  ),
  N6 = list(
    manifest_hash = "a59b4db15b84ffa06d4ced1e2cc0b9b31e62be2e40502df8d339a6977f00316e",
    formal_design = list(
      path = file.path(
        repository_root, "quality_reports",
        "2026-08-21_n6_final_formal_design_review.md"
      ),
      expected_hash = "dc788a4aa1e9eab1559a3926526477cc1d6e2154bf904edb3aa72aa174f383fb",
      reviewer_id = leaf_specs$N6$formal_reviewer_id
    ),
    game_theory = list(
      path = file.path(
        repository_root, "quality_reports",
        "2026-08-21_n6_final_game_theory_review.md"
      ),
      expected_hash = "a85e2e5d83900d1d8564a1e9d6b79939cb8499d079abb9f4388a6a175fc86513",
      reviewer_id = leaf_specs$N6$game_reviewer_id
    )
  ),
  N7 = list(
    manifest_hash = "a54c86df332780756c52a170f6e8f0aef113683c04402ee668a4a92c6d987b09",
    formal_design = list(
      path = file.path(
        repository_root, "quality_reports",
        "2026-08-21_n7_final_formal_design_review.md"
      ),
      expected_hash = "eca9697269589688a0bb568be96deeaa446326e2a40b8b9c3c0c919159857aad",
      reviewer_id = leaf_specs$N7$formal_reviewer_id
    ),
    game_theory = list(
      path = file.path(
        repository_root, "quality_reports",
        "2026-08-21_n7_final_game_theory_review.md"
      ),
      expected_hash = "42604ed0770923c1fa94e3a4314376a1fd3bb05f3fb024750b77fa7e9da4ae0d",
      reviewer_id = leaf_specs$N7$game_reviewer_id
    )
  )
)

is_valid_node_review_report <- function(lines, node_id, role, spec, manifest_hash) {
  dependency_hashes <- unname(unlist(
    leaf_specs[[node_id]]$dependency_hashes,
    recursive = TRUE,
    use.names = FALSE
  ))
  valid_dependencies <- length(dependency_hashes) == 0L || all(vapply(
    dependency_hashes,
    function(dependency_hash) {
      any(grepl(sub("^sha256:", "", dependency_hash), lines, fixed = TRUE))
    },
    logical(1)
  ))
  identical(lines, spec$canonical_lines) &&
    length(lines) > 40L &&
    any(grepl(role, lines, fixed = TRUE)) &&
    any(grepl(spec$reviewer_id, lines, fixed = TRUE)) &&
    any(grepl(sub("^sha256:", "", leaf_specs[[node_id]]$artifact_hash), lines, fixed = TRUE)) &&
    any(grepl(manifest_hash, lines, fixed = TRUE)) &&
    isTRUE(valid_dependencies) &&
    any(grepl("PASS", lines, fixed = TRUE)) &&
    any(grepl("critical[^0-9]*0|0[^0-9]*critical", lines, ignore.case = TRUE, perl = TRUE)) &&
    any(grepl("major[^0-9]*0|0[^0-9]*major", lines, ignore.case = TRUE, perl = TRUE)) &&
    any(grepl("minor[^0-9]*0|0[^0-9]*minor", lines, ignore.case = TRUE, perl = TRUE)) &&
    !any(grepl("VEREDICTO ESTRITO: FAIL", lines, fixed = TRUE))
}

for (node_id in names(node_review_report_specs)) {
  node_specs <- node_review_report_specs[[node_id]]
  manifest_hash <- node_specs$manifest_hash
  for (role in c("formal_design", "game_theory")) {
    spec <- node_specs[[role]]
    assert_true(file.exists(spec$path), paste("Missing saved final report for", node_id, role))
    assert_true(
      identical(sha256_file(spec$path), spec$expected_hash),
      paste("The complete saved final report changed for", node_id, role)
    )
    spec$canonical_lines <- readLines(spec$path, encoding = "UTF-8", warn = FALSE)
    node_review_report_specs[[node_id]][[role]] <- spec
    assert_true(
      is_valid_node_review_report(spec$canonical_lines, node_id, role, spec, manifest_hash),
      paste("The final report lacks exact same-hash PASS 0/0/0 evidence for", node_id, role)
    )
  }
}

# Five representative N6 mutations exercise source integrity, typed none,
# same-hash review, lifecycle order, and exact artifact bytes. Exact byte and
# canonical-object pins above cover every other manifest field without an
# exhaustive verifier-of-verifier mutation pass.
n6_negative_fixtures <- list(
  wrong_artifact_hash = local({
    x <- clone_object(nodes$N6)
    x$artifact_hash <- paste0("sha256:", paste(rep("0", 64L), collapse = ""))
    x
  }),
  wrong_source_hash = local({
    x <- clone_object(nodes$N6)
    x$dependency_hashes$N3 <- x$artifact_hash
    x
  }),
  none_with_record = local({
    x <- clone_object(nodes$N6)
    none_index <- which(vapply(
      x$interface$comparison_cells,
      function(cell) identical(cell$existence_status, "none"),
      logical(1)
    ))
    x$interface$comparison_cells[[none_index]]$comparison_records <-
      list(x$interface$comparison_cells[[1L]]$comparison_records[[1L]])
    x
  }),
  wrong_review_hash = local({
    x <- clone_object(nodes$N6)
    x$reviews[[2L]]$artifact_hash <-
      paste0("sha256:", paste(rep("f", 64L), collapse = ""))
    x
  }),
  wrong_execution_order = local({
    x <- clone_object(nodes$N6)
    x$passed_order <- x$started_order
    x
  })
)
assert_true(
  all(!vapply(n6_negative_fixtures, function(node) {
    is_valid_current_leaf("N6", node, leaf_specs$N6)
  }, logical(1))),
  "A directed N6 lifecycle, source, none, review, or artifact mutation passed."
)
n7_negative_fixtures <- list(
  wrong_artifact_hash = local({
    x <- clone_object(nodes$N7)
    x$artifact_hash <- paste0("sha256:", paste(rep("0", 64L), collapse = ""))
    x
  }),
  wrong_source_hash = local({
    x <- clone_object(nodes$N7)
    x$dependency_hashes$N6 <- x$artifact_hash
    x
  }),
  truncated_hegemon_strategy = local({
    x <- clone_object(nodes$N7)
    x$interface$public_equilibrium_cells$majority$R1$theta_0[[2L]]$
      public_equilibrium_records[[1L]]$strategy_profile$hegemon <-
      "no because the proposal passes without H"
    x
  }),
  none_with_record = local({
    x <- clone_object(nodes$N7)
    x$interface$informational_rent_cells$unanimity[[2L]]$
      informational_rent_records <- list(
        x$interface$informational_rent_cells$unanimity[[1L]]$
          informational_rent_records[[1L]]
      )
    x
  }),
  wrong_review_hash = local({
    x <- clone_object(nodes$N7)
    x$reviews[[2L]]$artifact_hash <-
      paste0("sha256:", paste(rep("f", 64L), collapse = ""))
    x
  })
)
assert_true(
  all(!vapply(n7_negative_fixtures, function(node) {
    is_valid_current_leaf("N7", node, leaf_specs$N7)
  }, logical(1))),
  "A directed N7 artifact, source, strategy, none, or review mutation passed."
)
for (role in names(review_report_specs)) {
  spec <- review_report_specs[[role]]
  assert_true(
    !is_valid_review_report(c(spec$canonical_lines, "FAIL"), role, spec),
    paste("An appended FAIL must invalidate the saved report for", role)
  )
}
for (node_id in names(node_review_report_specs)) {
  manifest_hash <- node_review_report_specs[[node_id]]$manifest_hash
  for (role in c("formal_design", "game_theory")) {
    spec <- node_review_report_specs[[node_id]][[role]]
    assert_true(
      !is_valid_node_review_report(
        c(spec$canonical_lines, "VEREDICTO ESTRITO: FAIL"),
        node_id,
        role,
        spec,
        manifest_hash
      ),
      paste("An appended FAIL must invalidate the final report for", node_id, role)
    )
  }
}

# The exact pending/null N7 envelope is retained as a synthetic lifecycle fixture.
expected_pending_node_fields <- c(
  "id", "name", "round", "institution", "depends_on", "status", "interface"
)

is_valid_current_pending_node <- function(node_id, node) {
  forbidden_fields <- c(
    "result", "artifact_path", "artifact_hash", "dependency_hashes",
    "started_order", "passed_order", "frozen", "review", "reviews", "authorized"
  )
  identical(names(node), expected_pending_node_fields) &&
    identical(node$id, node_id) &&
    identical(node$name, unname(expected_names[[node_id]])) &&
    identical(node$round, unname(expected_rounds[[node_id]])) &&
    identical(node$institution, unname(expected_institutions[[node_id]])) &&
    identical(as_character(node$depends_on), expected_dependencies[[node_id]]) &&
    identical(node$status, "pending") &&
    !any(forbidden_fields %in% names(node)) &&
    is_valid_pending_interface(node_id, node)
}

assert_true(
  is_valid_current_pending_node("N7", pending_fixture_nodes$N7),
  "The synthetic N7 fixture must retain the exact pending/null lifecycle."
)

# Directed manifest mutations replace recursive field/leaf fuzzing. The exact
# byte hash plus canonical object identity remain the live acceptance rule.
targeted_manifest_mutations <- list(
  n6_source_hash = local({
    x <- clone_object(manifest)
    x$nodes[[5L]]$dependency_hashes$N3 <- x$nodes[[5L]]$artifact_hash
    x
  }),
  n6_none_with_record = local({
    x <- clone_object(manifest)
    cells <- x$nodes[[5L]]$interface$comparison_cells
    none_index <- which(vapply(
      cells,
      function(cell) identical(cell$existence_status, "none"),
      logical(1)
    ))
    x$nodes[[5L]]$interface$comparison_cells[[none_index]]$comparison_records <-
      list(cells[[1L]]$comparison_records[[1L]])
    x
  }),
  n6_review_hash = local({
    x <- clone_object(manifest)
    x$nodes[[5L]]$reviews[[2L]]$artifact_hash <-
      paste0("sha256:", paste(rep("f", 64L), collapse = ""))
    x
  }),
  n6_execution_order = local({
    x <- clone_object(manifest)
    x$nodes[[5L]]$passed_order <- x$nodes[[5L]]$started_order
    x
  }),
  n7_truncated_strategy = local({
    x <- clone_object(manifest)
    x$nodes[[6L]]$interface$public_equilibrium_cells$majority$R1$theta_0[[2L]]$
      public_equilibrium_records[[1L]]$strategy_profile$hegemon <-
      "no because the proposal passes without H"
    x
  })
)
assert_true(
  all(!vapply(targeted_manifest_mutations, is_valid_canonical_manifest, logical(1))),
  "A directed source, none, review, lifecycle, or N7-strategy manifest mutation passed."
)

stale_n7 <- clone_object(pending_fixture_nodes$N7)
stale_n7$status <- "pass"
assert_true(
  !is_valid_current_pending_node("N7", stale_n7),
  "A stale PASS status must fail for N7."
)
authorized_n7 <- clone_object(pending_fixture_nodes$N7)
authorized_n7$authorized <- TRUE
assert_true(
  !is_valid_current_pending_node("N7", authorized_n7),
  "An extra authorized=true field must fail for N7."
)
filled_current_n7 <- clone_object(pending_fixture_nodes$N7)
filled_current_n7$interface$informational_rent_cells$majority <- list(list(stale = TRUE))
assert_true(
  !is_valid_current_pending_node("N7", filled_current_n7),
  "A stale nonempty interface must fail for N7."
)

assert_true(
  is_valid_contract_semantics(contract_text),
  paste0(
    "The governing contract must retain strict beta<1 across all four pinned ",
    "regions, including the Section 13 protected artifacts."
  )
)

insert_before_matching_line <- function(text, predicate, addition) {
  lines <- contract_lines(text)
  insertion_index <- unique_matching_line(lines, predicate)
  if (is.na(insertion_index)) {
    return(NA_character_)
  }
  result <- paste(
    append(lines, addition, after = insertion_index - 1L),
    collapse = "\n"
  )
  if (endsWith(text, "\n")) paste0(result, "\n") else result
}

insert_after_matching_line <- function(text, predicate, addition) {
  lines <- contract_lines(text)
  insertion_index <- unique_matching_line(lines, predicate)
  if (is.na(insertion_index)) {
    return(NA_character_)
  }
  result <- paste(
    append(lines, addition, after = insertion_index),
    collapse = "\n"
  )
  if (endsWith(text, "\n")) paste0(result, "\n") else result
}

replace_matching_line <- function(text, predicate, replacement) {
  lines <- contract_lines(text)
  replacement_index <- unique_matching_line(lines, predicate)
  if (is.na(replacement_index)) {
    return(NA_character_)
  }
  lines[[replacement_index]] <- replacement
  result <- paste(lines, collapse = "\n")
  if (endsWith(text, "\n")) paste0(result, "\n") else result
}

insert_in_authorization_header <- function(text, addition) {
  insert_before_matching_line(
    text,
    function(line) startsWith(line, "**Substitui:**"),
    addition
  )
}

insert_in_delay_cost_decision <- function(text, addition) {
  insert_before_matching_line(
    text,
    function(line) {
      startsWith(line, "### Decis") &&
        grepl("conceito de solu", line, fixed = TRUE)
    },
    addition
  )
}

old_beta_domain <- sub(
  "Desconto       beta in (0,1)",
  "Desconto       beta in (0,1]",
  contract_text,
  fixed = TRUE
)
assert_true(
  !is_valid_strict_beta_contract(old_beta_domain),
  "The old beta in (0,1] primitive-domain mutation must fail."
)

missing_delay_cost <- sub(
  "implica `D>0`",
  "permite D=0 no baseline",
  contract_text,
  fixed = TRUE
)
assert_true(
  !is_valid_strict_beta_contract(missing_delay_cost),
  "A mutation that restores the beta=1 delay corner to the baseline must fail."
)

expanded_authorization <- sub(
  "agenda informal",
  "nenhuma fronteira adicional",
  contract_text,
  fixed = TRUE
)
assert_true(
  !is_valid_reopened_authorization(expanded_authorization),
  "Removing the explicit beta=1 and agenda-extension exclusions must fail."
)

game_reviewer_paraphrases <- list(
  list(
    region = "delay",
    text = "REGRA POSTERIOR: beta = 1 também pertence ao baseline principal."
  ),
  list(
    region = "delay",
    text = "REGRA POSTERIOR: desconto unitário integra o domínio principal."
  ),
  list(
    region = "delay",
    text = "REGRA POSTERIOR: o ganho D pode ser não positivo no baseline."
  ),
  list(
    region = "header",
    text = "AUTORIZAÇÃO POSTERIOR: o Goal 5 está encerrado e a tag final liberada."
  ),
  list(
    region = "delay",
    text = "A referência de Eraslan e Evdokimov demonstra o sinal positivo de D."
  ),
  list(
    region = "header",
    text = "DECISÃO POSTERIOR: desconto unitário integra o benchmark e a extensão de agenda está liberada."
  )
)
formal_reviewer_mutations <- list(
  list(
    region = "header",
    text = "**Autorizacao corrente adicional:** a extensao de agenda, beta=1 e a tag final do Goal 5 estao autorizados agora."
  ),
  list(
    region = "delay",
    text = "- **Resultado importado e premissa corrente:** D>0 e assumido sem rederivacao em N3."
  ),
  list(
    region = "delay",
    text = "- **Prova importada:** Eraslan-Evdokimov demonstram D>0 e o equilibrio deste modelo."
  )
)
semantic_mutations <- c(game_reviewer_paraphrases, formal_reviewer_mutations)
semantic_mutation_results <- vapply(semantic_mutations, function(mutation) {
  altered_contract <- if (identical(mutation$region, "header")) {
    insert_in_authorization_header(contract_text, mutation$text)
  } else {
    insert_in_delay_cost_decision(contract_text, mutation$text)
  }
  # Nao-vacuidade: ancora morta devolve NA_character_, cujo sha256 e um hash
  # valido dos bytes "NA". Sem esta assercao a mutacao "passaria" em silencio.
  assert_true(
    !is.na(altered_contract) && !identical(altered_contract, contract_text),
    "A regional semantic mutation produced no change; its anchor is dead."
  )
  is_valid_contract_semantics(altered_contract)
}, logical(1))
assert_true(
  all(!semantic_mutation_results),
  "At least one of the nine regional semantic contradictions was accepted."
)

r3_contract_mutations <- list(
  beta_exception_after_primitive = function(text) {
    insert_after_matching_line(
      text,
      function(line) startsWith(line, "Desconto       beta in (0,1)"),
      "Excecao corrente: beta=1 tambem pertence ao baseline principal."
    )
  },
  unit_discount_in_rounds_primitive = function(text) {
    replace_matching_line(
      text,
      function(line) startsWith(line, "Rodadas        duas; R2 terminal"),
      "Rodadas        duas; R2 terminal; desconto unitario permitido no baseline"
    )
  },
  beta_exception_at_end_of_section_2 = function(text) {
    insert_before_matching_line(
      text,
      function(line) startsWith(line, "## 3. Decis"),
      "Regra adicional da Secao 2: beta=1 permanece admissivel no baseline."
    )
  },
  goal5_closure_in_header = function(text) {
    insert_after_matching_line(
      text,
      function(line) startsWith(line, "**Alcance da emenda de status"),
      "Autorizacao adicional: o Goal 5 esta encerrado e dispensa aval autoral."
    )
  },
  goal5_terminal_approval_in_header = function(text) {
    insert_in_authorization_header(
      text,
      "Aval autoral terminal do Goal 5 concedido; tag final autorizada."
    )
  },
  goal5_reviews_extended_to_current_bytes = function(text) {
    insert_in_authorization_header(
      text,
      "Os pareceres PASS 0/0/0 do Goal 5 cobrem tambem os bytes correntes."
    )
  },
  agenda_authorization_in_section_11 = function(text) {
    insert_before_matching_line(
      text,
      function(line) startsWith(line, "## 12. Invalida"),
      "Autorizacao adicional da Secao 11: a extensao de agenda esta liberada."
    )
  },
  beta_exception_in_section_12 = function(text) {
    insert_before_matching_line(
      text,
      function(line) startsWith(line, "## 13. Fronteira de vers"),
      "Excecao de invalidacao: beta=1 pode ser usado sem reabrir o Gate 0."
    )
  },
  citation_as_proof_in_section_13 = function(text) {
    insert_before_matching_line(
      text,
      function(line) startsWith(line, "## 14. Prompt de abertura"),
      "Eraslan-Evdokimov demonstram D>0 e o equilibrio deste modelo."
    )
  },
  contradiction_inside_hashed_header = function(text) {
    insert_in_authorization_header(
      text,
      "Autorizacao corrente adicional: extensao de agenda e beta=1 autorizados."
    )
  },
  final_tag_without_approval_in_section_13 = function(text) {
    insert_before_matching_line(
      text,
      function(line) startsWith(line, "## 14. Prompt de abertura"),
      "A tag final do Goal 5 pode ser criada sem aval autoral explicito."
    )
  },
  imported_premise_inside_hashed_delay_decision = function(text) {
    insert_in_delay_cost_decision(
      text,
      "Resultado importado: D>0 e premissa corrente e dispensa rederivacao em N3."
    )
  }
)
r3_contract_mutation_results <- vapply(
  r3_contract_mutations,
  function(mutate) {
    mutated <- mutate(contract_text)
    # Ver nota de nao-vacuidade acima: falha de ancora e muda sem esta assercao.
    assert_true(
      !is.na(mutated) && !identical(mutated, contract_text),
      "A Round 3 contract mutation produced no change; its anchor is dead."
    )
    is_valid_contract_semantics(mutated)
  },
  logical(1)
)
assert_true(
  all(!r3_contract_mutation_results),
  "At least one of the twelve Round 3 full-contract mutations was accepted."
)

# Segunda camada, independente do hash de arquivo inteiro, para a fronteira
# viva do Goal 5 alojada na Secao 13.
section13_tag_mutation <- r3_contract_mutations$final_tag_without_approval_in_section_13(
  contract_text
)
assert_true(
  !is_valid_protected_artifacts(section13_tag_mutation),
  paste0(
    "A Section 13 insertion authorizing the Goal 5 final tag without author ",
    "approval must fail the regional pin, not only the whole-file hash."
  )
)

# NOTA SOBRE OS TRES CANARIOS ABAIXO. Eles mutam o texto integral e avaliam
# `is_valid_reopened_authorization`, que decide por igualdade SHA-256 exata da
# regiao do cabecalho. Portanto verificam apenas que a string-ancora ocorre em
# algum ponto dessa regiao -- propriedade ja implicada pelo pino que os precede.
# Nao sao defesa contra quem edite o cabecalho e recalcule os hashes: uma linha
# isca contendo as ancoras permite apagar a clausula com os tres passando em
# silencio. Sua funcao e a mesma dos grepl: documentar qual conteudo o cabecalho
# pinado deve conter. A protecao efetiva continua sendo hashes exatos, testes de
# regressao e revisao independente do diff. Finding S-2 da rodada 3
# (`quality_reports/2026-08-23_parecer_game_theory_rodada3.md`) permanece aberto
# quanto a um redesenho; nao redesenhar sem decisao autoral.
removed_v5_protection <- sub(
  "RIO submission files/",
  "nenhuma pasta",
  contract_text,
  fixed = TRUE
)
assert_true(
  !is_valid_reopened_authorization(removed_v5_protection),
  "Removing the RIO submission files clause from the protection must fail."
)

removed_v5_manuscript_protection <- sub(
  "formal_model_v5.Rmd",
  "nenhum manuscrito",
  contract_text,
  fixed = TRUE
)
assert_true(
  !is_valid_reopened_authorization(removed_v5_manuscript_protection),
  "Removing formal_model_v5.Rmd from the header protection clause must fail."
)

removed_frozen_artifact_protection <- sub(
  "artefatos congelados de",
  "nenhum artefato de",
  contract_text,
  fixed = TRUE
)
assert_true(
  !is_valid_reopened_authorization(removed_frozen_artifact_protection),
  "Removing the frozen artifacts clause from the header protection must fail."
)

coordinated_r3_contract_mutation <- r3_contract_mutations$beta_exception_after_primitive(
  contract_text
)
coordinated_r3_contract_mutation <- r3_contract_mutations$agenda_authorization_in_section_11(
  coordinated_r3_contract_mutation
)
assert_true(
  !is_valid_contract_semantics(coordinated_r3_contract_mutation),
  "The coordinated Section 2 plus Section 11 Round 3 mutation must fail."
)

manifest_with_authorized_nodes <- clone_object(manifest)
manifest_with_authorized_nodes$authorized_nodes <- list("N4")
assert_true(
  !is_valid_manifest_top_level(manifest_with_authorized_nodes) &&
    !is_valid_canonical_manifest(manifest_with_authorized_nodes),
  "The manifest envelope must reject an extra authorized_nodes field."
)

nested_manifest_mutations <- list(
  invalidation_rule_extra = local({
    candidate <- clone_object(manifest)
    candidate$invalidation_rule$authorized_nodes <- list("N4")
    candidate
  }),
  freeze_gate_schema_extra = local({
    candidate <- clone_object(manifest)
    candidate$freeze_gate_schema$authorized_goal <- "Goal 2"
    candidate
  }),
  interface_schema_extra = local({
    candidate <- clone_object(manifest)
    candidate$interface_schemas$equilibrium_correspondence_v1$authorized_nodes <- list("N4")
    candidate
  })
)
assert_true(
  all(!vapply(nested_manifest_mutations, is_valid_canonical_manifest, logical(1))),
  "Nested extras in invalidation, freeze-gate, or interface schemas must fail."
)

coordinated_contract_mutation <- insert_in_authorization_header(
  contract_text,
  game_reviewer_paraphrases[[6L]]$text
)
coordinated_manifest_mutation <- clone_object(manifest)
coordinated_manifest_mutation$nodes[[4L]]$authorized <- TRUE
assert_true(
  !is_valid_contract_semantics(coordinated_contract_mutation) &&
    !is_valid_current_leaf("N4", coordinated_manifest_mutation$nodes[[4L]], leaf_specs$N4) &&
    !is_valid_canonical_manifest(coordinated_manifest_mutation),
  "The coordinated contract-plus-N4 authorization mutation must fail both validators."
)

topologically_ready_nodes <- function(candidate_nodes) {
  candidate_ids <- names(candidate_nodes)
  candidate_ids[vapply(candidate_ids, function(node_id) {
    node <- candidate_nodes[[node_id]]
    identical(node$status, "pending") &&
      all(vapply(as_character(node$depends_on), function(dependency_id) {
        is_frozen(candidate_nodes[[dependency_id]])
      }, logical(1)))
  }, logical(1))]
}

frozen_hash <- paste0("sha256:", paste(rep("a", 64L), collapse = ""))
make_review <- function(reviewer_role, reviewer_id, artifact_hash = frozen_hash) {
  list(
    reviewer_role = reviewer_role,
    reviewer_id = reviewer_id,
    verdict = "PASS",
    artifact_hash = artifact_hash,
    finding_counts = list(critical = 0L, major = 0L, minor = 0L)
  )
}

freeze_node <- function(
    candidate_nodes,
    node_id,
    include_hash = TRUE,
    status = "pass",
    include_frozen = TRUE,
    include_reviews = TRUE) {
  candidate_nodes[[node_id]]$status <- status
  if (isTRUE(include_hash)) {
    candidate_nodes[[node_id]]$artifact_hash <- frozen_hash
  }
  if (isTRUE(include_frozen)) {
    candidate_nodes[[node_id]]$frozen <- TRUE
  }
  if (isTRUE(include_reviews)) {
    candidate_nodes[[node_id]]$reviews <- list(
      make_review("formal_design", "reviewer-formal-design"),
      make_review("game_theory", "reviewer-game-theory")
    )
  }
  candidate_nodes
}

assert_true(
  length(topologically_ready_nodes(nodes)) == 0L,
  "After the terminal N7 freeze, no derivation node may remain topologically ready."
)
assert_true(
  identical(sort(topologically_ready_nodes(pending_fixture_nodes)), c("N1", "N2")),
  "The synthetic all-pending lifecycle must retain N1 and N2 as the initial ready antichain."
)

# Missing any freeze fact prevents consumption.
n1_unhashed <- freeze_node(pending_fixture_nodes, "N1", include_hash = FALSE)
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_unhashed)),
  "N1 without a frozen hash must not release N3."
)
n2_unhashed <- freeze_node(pending_fixture_nodes, "N2", include_hash = FALSE)
assert_true(
  !("N4" %in% topologically_ready_nodes(n2_unhashed)),
  "N2 without a frozen hash must not release N4."
)

n1_pass_hash_only <- freeze_node(
  pending_fixture_nodes,
  "N1",
  include_frozen = FALSE,
  include_reviews = FALSE
)
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_pass_hash_only)),
  "PASS plus a hash without frozen and reviews must not release N3."
)

n1_without_reviews <- freeze_node(pending_fixture_nodes, "N1", include_reviews = FALSE)
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_without_reviews)),
  "A frozen flag and hash without reviews must not release N3."
)

n1_one_review <- freeze_node(pending_fixture_nodes, "N1")
n1_one_review$N1$reviews <- n1_one_review$N1$reviews[1]
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_one_review)),
  "Exactly one review must not release N3."
)

n1_wrong_review_hash <- freeze_node(pending_fixture_nodes, "N1")
n1_wrong_review_hash$N1$reviews[[2]]$artifact_hash <- paste0(
  "sha256:", paste(rep("b", 64L), collapse = "")
)
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_wrong_review_hash)),
  "A review of a different hash must not release N3."
)

n1_nonzero_finding <- freeze_node(pending_fixture_nodes, "N1")
n1_nonzero_finding$N1$reviews[[1]]$finding_counts$minor <- 1L
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_nonzero_finding)),
  "A review with any nonzero finding count must not release N3."
)

n1_duplicate_reviewer <- freeze_node(pending_fixture_nodes, "N1")
n1_duplicate_reviewer$N1$reviews[[2]]$reviewer_id <-
  n1_duplicate_reviewer$N1$reviews[[1]]$reviewer_id
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_duplicate_reviewer)),
  "Two review roles carried by the same reviewer id must not release N3."
)

# Frozen leaves release only their direct private-model consumers.
n1_frozen <- freeze_node(pending_fixture_nodes, "N1")
assert_true(
  "N3" %in% topologically_ready_nodes(n1_frozen),
  "Frozen N1 must make N3 topologically ready."
)
n2_frozen <- freeze_node(pending_fixture_nodes, "N2")
assert_true(
  "N4" %in% topologically_ready_nodes(n2_frozen),
  "Frozen N2 must make N4 topologically ready."
)
assert_true(
  !("N7" %in% topologically_ready_nodes(n1_frozen)),
  "A frozen N1 must not make N7 topologically ready."
)
assert_true(
  !("N7" %in% topologically_ready_nodes(n2_frozen)),
  "A frozen N2 must not make N7 topologically ready."
)

# N6 requires both R1 interfaces; either one alone is insufficient.
both_leaves_frozen <- freeze_node(freeze_node(pending_fixture_nodes, "N1"), "N2")
n3_only <- freeze_node(both_leaves_frozen, "N3")
assert_true(
  !("N6" %in% topologically_ready_nodes(n3_only)),
  "N3 alone must not make N6 topologically ready."
)
n4_only <- freeze_node(both_leaves_frozen, "N4")
assert_true(
  !("N6" %in% topologically_ready_nodes(n4_only)),
  "N4 alone must not make N6 topologically ready."
)

n3_unhashed_with_n4 <- freeze_node(n4_only, "N3", include_hash = FALSE)
assert_true(
  !("N6" %in% topologically_ready_nodes(n3_unhashed_with_n4)),
  "N3 without a frozen hash must not release N6 even when N4 is frozen."
)
n4_unhashed_with_n3 <- freeze_node(n3_only, "N4", include_hash = FALSE)
assert_true(
  !("N6" %in% topologically_ready_nodes(n4_unhashed_with_n3)),
  "N4 without a frozen hash must not release N6 even when N3 is frozen."
)

both_r1_frozen <- freeze_node(n3_only, "N4")
assert_true(
  "N6" %in% topologically_ready_nodes(both_r1_frozen),
  "Frozen N3 and N4 must make N6 topologically ready."
)
assert_true(
  !("N7" %in% topologically_ready_nodes(both_r1_frozen)),
  "Frozen N3 and N4 must not bypass N6 to make N7 topologically ready."
)

# N7 is terminal and requires N6 itself to be frozen.
n6_unhashed <- freeze_node(both_r1_frozen, "N6", include_hash = FALSE)
assert_true(
  !("N7" %in% topologically_ready_nodes(n6_unhashed)),
  "N6 without a frozen hash must not make N7 topologically ready."
)
n6_hash_without_pass <- freeze_node(both_r1_frozen, "N6", include_hash = TRUE, status = "pending")
assert_true(
  !("N7" %in% topologically_ready_nodes(n6_hash_without_pass)),
  "An N6 hash without PASS must not make N7 topologically ready."
)
n6_frozen <- freeze_node(both_r1_frozen, "N6")
assert_true(
  "N7" %in% topologically_ready_nodes(n6_frozen),
  "Only frozen N6 must make N7 topologically ready."
)
n7_frozen <- freeze_node(n6_frozen, "N7")
assert_true(
  length(topologically_ready_nodes(n7_frozen)) == 0L,
  "Freezing terminal N7 must leave no derivation node ready."
)

direct_dependents <- function(candidate_nodes, node_id) {
  names(candidate_nodes)[vapply(candidate_nodes, function(node) {
    node_id %in% as_character(node$depends_on)
  }, logical(1))]
}

descendants <- function(candidate_nodes, changed_id) {
  found <- character()
  frontier <- changed_id
  while (length(frontier) > 0L) {
    children <- unique(unlist(lapply(
      frontier,
      function(node_id) direct_dependents(candidate_nodes, node_id)
    ), use.names = FALSE))
    children <- setdiff(children, found)
    found <- c(found, children)
    frontier <- children
  }
  sort(found)
}

expected_invalidations <- list(
  N1 = c("N3", "N6", "N7"),
  N2 = c("N4", "N6", "N7"),
  N3 = c("N6", "N7"),
  N4 = c("N6", "N7"),
  N6 = "N7",
  N7 = character()
)
for (node_id in expected_ids) {
  assert_true(
    identical(descendants(nodes, node_id), expected_invalidations[[node_id]]),
    paste(node_id, "has the wrong invalidation descendants.")
  )
}

cat(
  paste0(
    "MUTATION_REJECTED: the independent full-contract identity returned FALSE for all 12 ",
    "Round 3 mutations when only the first external pin was bypassed; regional diagnostics, ",
    "the coordinated Section 2/Section 11 mutation, exact full-manifest identity/hash, ",
    "nested invalidation/freeze/interface-schema extras, five directed N6 mutations, five ",
    "directed N7 mutations, and the synthetic pending-N7 lifecycle mutations also failed.\n"
  )
)

cat(
  paste0(
    "PASS: strict o_1 < 1 and beta < 1 contract with N1/N2/N3/N4/N6/N7 pass/frozen on exact reviewed artifacts; ",
    "no derivation node is topologically ready. The author's exact post-freeze approval is pinned; Goals 1-4 are closed; ",
    "Goal 5 is authorized, migrated, and reviewed but still open, with its terminal author approval and final tag pending ",
    "and its PASS reviews covering only b5fdefb. Beta=1 extensions and any declaration of Goal 5 ",
    "closure remain unauthorized, as is approval of the agenda-extension Gate 0 contract and every ",
    "later goal in that chain; the author's 2026-08-23 GO covers only drafting that contract. Editing ",
    "formal_model_v5.Rmd, RIO submission files/, or the frozen N1/N2/N3/N4/N6/N7 artifacts is ",
    "unauthorized by the header itself. Writing any script of the agenda-extension chain, including ",
    "that chain's Gate 0 verifier, is unauthorized; the 2026-08-23 GO covers only drafting the ",
    "contract document. Four contract regions are pinned, Section 13 among them. ",
    "Typed coverage cells for empty and ",
    "nonempty correspondences, independent RI_M and RI_U with a separate DeltaRI ",
    "contrast, role-typed public payoffs, terminal complete-information benchmark, ",
    "two-review freeze gates, topological readiness, negative schema tests, and ",
    "invalidation rules verified. Topological ",
    "readiness does not grant author authorization; Section 11 controls.\n"
  )
)
