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

contains_fixed_utf8 <- function(text, fragment) {
  grepl(enc2utf8(fragment), enc2utf8(text), fixed = TRUE, useBytes = TRUE)
}

expected_beta_primitive <- "Desconto       beta in (0,1)"
expected_contract_hash <- "e6c663806f40b43c30ae8d8847ba4268fc4714fc3dfedc9b74b22505a24248b3"
expected_contract_region_hashes <- c(
  authorization_header = "a52f7367b56b1f857be64eff86fb4016f245bfd83f9599091532a2d554d8c4f2",
  beta_primitive = "bb7ee3390b0f63a4d293fe8deab7d33fea725d280ad43121c615375f96bf41b4",
  delay_cost_decision = "3c4483859bc7cdaf36c8fe3c4a1c2d54a278e40980eacdaba2fb9b684ebb8f2a"
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
  primitives_start <- unique_exact_line(lines, "## 2. Primitivas")
  primitives_end <- unique_matching_line(
    lines,
    function(line) startsWith(line, "## 3. Decis")
  )
  if (
    any(is.na(c(header_start, header_end, delay_start, delay_end))) ||
      header_start >= header_end || delay_start >= delay_end ||
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
    delay_cost_decision = delay_cost_decision
  )
}

is_valid_reopened_authorization <- function(text) {
  regions <- extract_normative_contract_regions(text)
  !is.null(regions) &&
    identical(
      sha256_text(regions$authorization_header),
      unname(expected_contract_region_hashes[["authorization_header"]])
    ) &&
    grepl("O Goal 1 fechou", regions$authorization_header, fixed = TRUE) &&
    grepl("`pass/frozen`", regions$authorization_header, fixed = TRUE) &&
    grepl("Goal 2 exclusivamente para `N4`", regions$authorization_header, fixed = TRUE) &&
    grepl("O Goal 2 fechou com `N4`", regions$authorization_header, fixed = TRUE) &&
    grepl(
      "Goal 3 autorizado pelo autor exclusivamente para `N6`",
      regions$authorization_header,
      fixed = TRUE
    ) &&
    grepl("O Goal 3 fechou com `N6` `pass/frozen`", regions$authorization_header, fixed = TRUE) &&
    grepl("Fase A do Goal 4", regions$authorization_header, fixed = TRUE) &&
    grepl("benchmarks", regions$authorization_header, fixed = TRUE) &&
    grepl("`RI_M`, `RI_U` ou", regions$authorization_header, fixed = TRUE) &&
    grepl("`DeltaRI`", regions$authorization_header, fixed = TRUE) &&
    grepl("`N7` permanece `pending` e `unfrozen`", regions$authorization_header, fixed = TRUE) &&
    grepl("nova autoriza", regions$authorization_header, fixed = TRUE) &&
    grepl("autoral expl", regions$authorization_header, fixed = TRUE) &&
    grepl("fechamento e o congelamento", regions$authorization_header, fixed = TRUE) &&
    grepl("Goal 5", regions$authorization_header, fixed = TRUE) &&
    grepl("fronteira `beta=1`", regions$authorization_header, fixed = TRUE) &&
    grepl("manuscrito continuam", regions$authorization_header, fixed = TRUE) &&
    grepl("autorizados", regions$authorization_header, fixed = TRUE) &&
    grepl("reabriu **exclusivamente `N6`**", regions$authorization_header, fixed = TRUE) &&
    grepl("`N6` retorna a", regions$authorization_header, fixed = TRUE) &&
    grepl("sem hash nem pareceres correntes", regions$authorization_header, fixed = TRUE) &&
    grepl("obsoleta", regions$authorization_header, fixed = TRUE) &&
    grepl("`N1`, `N2`, `N3` e `N4`", regions$authorization_header, fixed = TRUE) &&
    grepl("permanecem byte a byte `pass/frozen`", regions$authorization_header, fixed = TRUE) &&
    grepl("`N7` permanece `pending` e `unfrozen`", regions$authorization_header, fixed = TRUE) &&
    grepl("Goal 4 fica pausado", regions$authorization_header, fixed = TRUE) &&
    grepl("schema, topologia, jogo", regions$authorization_header, fixed = TRUE) &&
    grepl("`N7`, Goal 5", regions$authorization_header, fixed = TRUE) &&
    grepl("escolheu a **Op", regions$authorization_header, fixed = TRUE) &&
    grepl("reabriu exclusivamente `N3` e `N4`", regions$authorization_header, fixed = TRUE) &&
    grepl("`N1` e `N2` byte a byte", regions$authorization_header, fixed = TRUE) &&
    grepl("objeto a objeto nos estados `pass/frozen`", regions$authorization_header, fixed = TRUE) &&
    grepl("`N3` continua consumindo somente `N1`", regions$authorization_header, fixed = TRUE) &&
    grepl("`N4`, somente `N2`", regions$authorization_header, fixed = TRUE) &&
    grepl("rederiva", regions$authorization_header, fixed = TRUE) &&
    grepl("publica", regions$authorization_header, fixed = TRUE) &&
    grepl("novos candidatos", regions$authorization_header, fixed = TRUE) &&
    grepl("revis", regions$authorization_header, fixed = TRUE) &&
    grepl("independente de", regions$authorization_header, fixed = TRUE) &&
    grepl("ambos antes de qualquer retomada de `N6`", regions$authorization_header, fixed = TRUE) &&
    grepl("`N3` e `N4`", regions$authorization_header, fixed = TRUE) &&
    grepl("novamente `pass/frozen`", regions$authorization_header, fixed = TRUE) &&
    grepl("exatamente dois pareceres", regions$authorization_header, fixed = TRUE) &&
    grepl("independentes `PASS 0/0/0`", regions$authorization_header, fixed = TRUE) &&
    grepl("`N6` fica autorizado", regions$authorization_header, fixed = TRUE) &&
    grepl("contingentemente", regions$authorization_header, fixed = TRUE) &&
    grepl("reconstru", regions$authorization_header, fixed = TRUE) &&
    grepl("retoma-se a Fase B de `N7`", regions$authorization_header, fixed = TRUE) &&
    grepl("`N7` permanece", regions$authorization_header, fixed = TRUE) &&
    grepl("aval", regions$authorization_header, fixed = TRUE) &&
    grepl("final do autor", regions$authorization_header, fixed = TRUE) &&
    grepl("executa `N6` nem `N7`", regions$authorization_header, fixed = TRUE) &&
    grepl("`beta=1`", regions$authorization_header, fixed = TRUE) &&
    grepl("Todo PDF de deriva", regions$authorization_header, fixed = TRUE) &&
    grepl("permanente, hashado e referenciado", regions$authorization_header, fixed = TRUE) &&
    grepl("manuscrito v5/v6", regions$authorization_header, fixed = TRUE) &&
    grepl("conven", regions$authorization_header, fixed = TRUE) &&
    grepl("reporte em `nu=0`", regions$authorization_header, fixed = TRUE) &&
    grepl("seleciona equil", regions$authorization_header, fixed = TRUE) &&
    grepl("cria distribui", regions$authorization_header, fixed = TRUE) &&
    grepl("`sim, autorizo`", regions$authorization_header, fixed = TRUE) &&
    grepl("`N4-V2-ACCOUNTING-01`", regions$authorization_header, fixed = TRUE) &&
    grepl("ramo realizado `theta=1`", regions$authorization_header, fixed = TRUE) &&
    grepl("low-only de `N2`, payoff", regions$authorization_header, fixed = TRUE) &&
    grepl("realizado `0` para cada weak state", regions$authorization_header, fixed = TRUE) &&
    grepl("interface congelada de `N2` e n", regions$authorization_header, fixed = TRUE) &&
    grepl("altera primitivas, factibilidade, payoffs", regions$authorization_header, fixed = TRUE) &&
    grepl("PBE, stage-undominated voting", regions$authorization_header, fixed = TRUE) &&
    grepl("stage-undominated voting, `T^Y`, `beta in (0,1)`", regions$authorization_header, fixed = TRUE) &&
    grepl("`0 < o_0 < o_1 < 1`, schema ou topologia", regions$authorization_header, fixed = TRUE) &&
    grepl("Ela n", regions$authorization_header, fixed = TRUE) &&
    grepl("seleciona nem predetermina", regions$authorization_header, fixed = TRUE) &&
    grepl("garantias", regions$authorization_header, fixed = TRUE) &&
    grepl("`m=2` e `m>=3`", regions$authorization_header, fixed = TRUE) &&
    grepl("natureza atingida ou", regions$authorization_header, fixed = TRUE) &&
    grepl("todos os endpoints", regions$authorization_header, fixed = TRUE) &&
    grepl("de `Y`, as condi", regions$authorization_header, fixed = TRUE) &&
    grepl("de delay, as misturas e a multiplicidade", regions$authorization_header, fixed = TRUE) &&
    grepl("diverg", regions$authorization_header, fixed = TRUE) &&
    grepl("ambiguidade ou defini", regions$authorization_header, fixed = TRUE) &&
    grepl("novo STOP", regions$authorization_header, fixed = TRUE) &&
    grepl("`N4` permanece `pending` e `unfrozen`", regions$authorization_header, fixed = TRUE) &&
    grepl("exatamente dois", regions$authorization_header, fixed = TRUE) &&
    grepl("independentes read-only `PASS 0/0/0`", regions$authorization_header, fixed = TRUE) &&
    grepl("mesmo novo hash", regions$authorization_header, fixed = TRUE) &&
    grepl("mesmo novo hash; `N3`", regions$authorization_header, fixed = TRUE) &&
    grepl("permanece `pending` em seu pr", regions$authorization_header, fixed = TRUE) &&
    grepl("ciclo. `N6` n", regions$authorization_header, fixed = TRUE) &&
    grepl("`N3` e `N4` estarem ambos novamente `pass/frozen`", regions$authorization_header, fixed = TRUE) &&
    grepl("`N7` permanece igualmente", regions$authorization_header, fixed = TRUE) &&
    grepl("depende do novo congelamento de `N6`", regions$authorization_header, fixed = TRUE) &&
    grepl("inalterados os limites da Fase A, a regra", regions$authorization_header, fixed = TRUE) &&
    grepl("permanente de PDFs", regions$authorization_header, fixed = TRUE) &&
    grepl("fechamento do Goal 5", regions$authorization_header, fixed = TRUE) &&
    grepl("manuscritos v5/v6", regions$authorization_header, fixed = TRUE) &&
    contains_fixed_utf8(
      regions$authorization_header,
      "`Autorizo o reparo N3 recomendado e a Op"
    ) &&
    contains_fixed_utf8(
      regions$authorization_header,
      "as cren"
    ) &&
    contains_fixed_utf8(regions$authorization_header, "off-path j") &&
    contains_fixed_utf8(
      regions$authorization_header,
      "estrutural integral e oracle alg"
    ) &&
    contains_fixed_utf8(regions$authorization_header, "testes negativos dirigidos") &&
    contains_fixed_utf8(
      regions$authorization_header,
      "fria desde as primitivas, P6 e a interface congelada de `N2`, com"
    ) &&
    contains_fixed_utf8(
      regions$authorization_header,
      "de todos os vetores simult"
    ) &&
    contains_fixed_utf8(regions$authorization_header, "de votos relevantes") &&
    contains_fixed_utf8(
      regions$authorization_header,
      "preservar `S_m`, `S_2`, o componente `F` ou qualquer f"
    ) &&
    contains_fixed_utf8(
      regions$authorization_header,
      "`N1`, `N2`, o candidato intermedi"
    ) &&
    contains_fixed_utf8(regions$authorization_header, "da Fase A e a tag protegida") &&
    contains_fixed_utf8(
      regions$authorization_header,
      "`N3` e `N4` continuam `pending` e `unfrozen`"
    ) &&
    contains_fixed_utf8(
      regions$authorization_header,
      "exatamente dois revisores independentes read-only"
    ) &&
    contains_fixed_utf8(regions$authorization_header, "`formal_design` e `game_theory`") &&
    contains_fixed_utf8(
      regions$authorization_header,
      "abre `N6`, `N7`, Goal 5, manuscrito, figuras, PDFs ou `beta=1`"
    ) &&
    contains_fixed_utf8(
      regions$authorization_header,
      "faltante ou pluralidade de reparos substantivos aciona"
    )
}

is_valid_phaseA_cadence <- function(text) {
  grepl("Goal 4, Fase A", text, fixed = TRUE) &&
    grepl("Gate autoral entre as Fases A e B", text, fixed = TRUE) &&
    grepl("Goal 4, Fase B", text, fixed = TRUE) &&
    grepl("nenhuma renda", text, fixed = TRUE) &&
    grepl("calculada e `N7`", text, fixed = TRUE) &&
    grepl("permanece `pending` e `unfrozen`", text, fixed = TRUE) &&
    grepl("Somente nova autoriza", text, fixed = TRUE) &&
    grepl("calcular `RI_M`, `RI_U` e `DeltaRI`", text, fixed = TRUE)
}

is_valid_single_phaseA_protocol_exception <- function(text) {
  required_fragments <- c(
    "administrativa",
    "autorizada pelo autor em 2026-08-19",
    "exclusivamente nesta",
    "Goal 4 em Fase A",
    "benchmarks",
    "gate autoral",
    "Fase B",
    "retrospectivamente os estados",
    "`pass/frozen`, hashes, pareceres",
    "`N3`, `N4` e `N6`",
    "estritamente administrativa",
    "sem mudar jogo, primitivas, factibilidade",
    "revisores, regra de mesmo hash",
    "passada ou futura da Se",
    "item 3 continua integralmente",
    "interfaces ou hashes congelados",
    "reclassificar findings, reduzir testes",
    "continua `pending` e `unfrozen`",
    "candidato",
    "cruzar o candidato",
    "com `N6`",
    "calcular `RI_M`, `RI_U` ou",
    "`DeltaRI`, selecionar compara",
    "abrir a Fase B, congelar `N7`",
    "Goal 5, tratar `beta=1`",
    "manuscritos"
  )
  all(vapply(
    required_fragments,
    function(fragment) contains_fixed_utf8(text, fragment),
    logical(1)
  ))
}

is_valid_lifecycle_applications <- function(text) {
  required_fragments <- c(
    "rica anterior, autorizada pelo autor em 2026-08-19",
    "reabertura exclusiva de `N6`",
    "lifecycle deste item",
    "`N6` voltou a `pending` e `unfrozen`",
    "hash e seus pareceres anteriores",
    "obsoleta",
    "`N7`, seu",
    "descendente, permanece",
    "`N1`--`N4` mudou",
    "permanecem `pass/frozen` nos mesmos bytes",
    "arquivos do antigo `N6`",
    "candidato intermedi",
    "da Fase A",
    "regra geral deste item",
    "corrente autorizada pelo autor em 2026-08-19",
    "reabertura simult",
    "`N3` e `N4` voltam a `pending` e `unfrozen`",
    "`artifact_path`, `artifact_hash`, `dependency_hashes`, ordens",
    "de cobertura retornam a `null`",
    "`N6` e `N7`",
    "descendentes transitivos",
    "`N1` e `N2` est",
    "byte a byte e objeto a objeto `pass/frozen`",
    "`N3` depende somente de `N1` e `N4` somente de `N2`",
    "rederiva",
    "publica",
    "candidatos e a revis",
    "ambos antes de qualquer retomada de `N6`",
    "Quando ambos voltarem a `pass/frozen`",
    "exatamente dois",
    "pareceres independentes `PASS 0/0/0`",
    "`N6` fica",
    "autorizado contingentemente",
    "reconstru",
    "Fase B de `N7`",
    "`N7` permanece `pending` e `unfrozen`",
    "aval final do autor",
    "ato administrativo corrente",
    "executa `N6` ou `N7`",
    "PDFs do manuscrito v5/v6"
  )
  all(vapply(
    required_fragments,
    function(fragment) contains_fixed_utf8(text, fragment),
    logical(1)
  ))
}

is_valid_nu0_reporting_decision <- function(text) {
  required_fragments <- c(
    "Coordenadas de reporte em `nu=0`",
    "`(rho_L,rho_P,rho_D)`",
    "`rho_L+rho_P+rho_D=1`",
    "`bar_Y_L` e `bar_Y_P`",
    "enumera toda a imagem admiss",
    "sem atribuir propor",
    "aos seus pontos",
    "de identidades podem ser colapsadas somente na proje",
    "estimando de payoff de `H`",
    "preserva os IDs e hashes dos",
    "registros fonte",
    "explicitamente **",
    "aplic",
    "nunca se usa zero, `NA`, string vazia",
    "distinta da agrega",
    "equal-area sobre `(o_0,o_1)`",
    "uniforme sobre outside options",
    "acrescenta campo ao schema"
  )
  all(vapply(
    required_fragments,
    function(fragment) contains_fixed_utf8(text, fragment),
    logical(1)
  ))
}

is_valid_pdf_and_goal5_rules <- function(text) {
  required_fragments <- c(
    "Regra permanente de persist",
    "Todo PDF efetivamente gerado",
    "caminho permanente dentro do reposit",
    "SHA-256 de seus bytes registrado",
    "cache ou preview",
    "auditoria ou companion",
    "PDFs do manuscrito v5/v6 permanecem proibidos",
    "prospectivo de figuras no Goal 5",
    "Quando e somente quando o",
    "Goal 5 for aberto",
    "figuras e suas fontes dever",
    "hashadas no reporte do Goal 5",
    "criada, alterada ou compilada"
  )
  all(vapply(
    required_fragments,
    function(fragment) contains_fixed_utf8(text, fragment),
    logical(1)
  ))
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
    is_valid_phaseA_cadence(text) &&
    is_valid_single_phaseA_protocol_exception(text) &&
    is_valid_lifecycle_applications(text) &&
    is_valid_nu0_reporting_decision(text) &&
    is_valid_pdf_and_goal5_rules(text)
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
manifest_path <- file.path(repository_root, "model_redesign", "essential_input_game_dag.json")
manifest_dir <- dirname(manifest_path)

expected_manifest_hash <- "0be4ff7eac0c0dfcb15338a8dd6ac7a1069089f6a24a644c28172c0feb6bcd94"
expected_manifest_object_hash <- "54f52de9dbd2961577f972941a057323c2415d38b013db1a37f266dd8732a9fb"
assert_true(
  identical(sha256_file(manifest_path), expected_manifest_hash),
  "The Gate 0 manifest bytes differ from the approved Option-A N3/N4-reopened lifecycle snapshot."
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
  "The manifest must be recursively identical to the complete canonical Option-A lifecycle object."
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
  "The canonical contract bytes differ from the author-approved Option-A reopening snapshot."
)
contract_text <- paste0(
  paste(readLines(contract_path, encoding = "UTF-8", warn = FALSE), collapse = "\n"),
  "\n"
)
assert_true(
  is_valid_contract_semantics(contract_text),
  paste0(
    "The canonical authorization header, beta primitive, complete strict-delay ",
    "decision, Phase A protocol exception, Option-A reopening, nu=0 reporting, or persistent-output rule differs from its exact ",
    "author-approved object/hash."
  )
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

pending_node_ids <- c("N3", "N4", "N6", "N7")
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
for (node_id in c("N1", "N2", "N3", "N4", "N6")) {
  pending_fixture_nodes[[node_id]]$status <- "pending"
  pending_fixture_nodes[[node_id]]$interface <- expected_pending_interfaces[[node_id]]
  pending_fixture_nodes[[node_id]][c(
    "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
    "passed_order", "frozen", "reviews"
  )] <- NULL
  assert_true(
    is_valid_pending_interface(node_id, pending_fixture_nodes[[node_id]]),
    paste("Synthetic pending fixture is invalid for", node_id)
  )
}

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
    is.list(records) && length(records) > 0L && all(vapply(records, function(record) {
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

expected_n6_source_hashes <- list(
  N3 = "sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee",
  N4 = "sha256:ee61ce6f854d4393f51048592a5221a9999a8f3f7daca1e749e7f19a88927f2d"
)

is_valid_n6_private_record <- function(record, institution, source_hash) {
  is.list(record) &&
    identical(
      names(record),
      as_character(comparison_schema$private_rule_record_fields)
    ) &&
    identical(record$institution, institution) &&
    is.character(record$private_rule_record_id) &&
    length(record$private_rule_record_id) == 1L &&
    nzchar(record$private_rule_record_id) &&
    is.character(record$source_equilibrium_cell_id) &&
    length(record$source_equilibrium_cell_id) == 1L &&
    nzchar(record$source_equilibrium_cell_id) &&
    is.character(record$source_equilibrium_id) &&
    length(record$source_equilibrium_id) == 1L &&
    nzchar(record$source_equilibrium_id) &&
    identical(record$source_interface_hash, source_hash) &&
    identical(
      names(record$private_payoff_vector),
      as_character(comparison_schema$private_rule_payoff_vector_fields)
    ) &&
    identical(
      names(record$private_outcome_distribution),
      as_character(comparison_schema$private_rule_outcome_distribution_fields)
    ) &&
    !is.null(record$selection_status) &&
    !is.null(record$checks_performed)
}

is_valid_n6_comparison_record <- function(record) {
  is.list(record) &&
    identical(names(record), as_character(comparison_schema$record_fields)) &&
    is.character(record$comparison_id) &&
    length(record$comparison_id) == 1L &&
    nzchar(record$comparison_id) &&
    identical(
      names(record$source_equilibrium_ids),
      as_character(comparison_schema$source_equilibrium_id_fields)
    ) &&
    all(vapply(record$source_equilibrium_ids, function(value) {
      is.character(value) && length(value) == 1L && nzchar(value)
    }, logical(1))) &&
    identical(
      names(record$source_interface_hashes),
      as_character(comparison_schema$source_interface_hash_fields)
    ) &&
    identical(record$source_interface_hashes, expected_n6_source_hashes) &&
    identical(
      names(record$private_payoff_vectors_by_rule),
      as_character(comparison_schema$private_payoff_vector_rule_fields)
    ) &&
    all(vapply(record$private_payoff_vectors_by_rule, function(value) {
      is.list(value) && identical(
        names(value),
        as_character(comparison_schema$payoff_vector_type_fields)
      )
    }, logical(1))) &&
    identical(
      names(record$private_outcome_distributions_by_rule),
      as_character(comparison_schema$private_outcome_distribution_rule_fields)
    ) &&
    all(vapply(record$private_outcome_distributions_by_rule, function(value) {
      is.list(value) && identical(
        names(value),
        as_character(comparison_schema$outcome_distribution_fields)
      )
    }, logical(1))) &&
    !is.null(record$private_rule_contrasts) &&
    !is.null(record$selection_status) &&
    !is.null(record$checks_performed)
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

  source_map <- list(
    majority = list(hash = expected_n6_source_hashes$N3),
    unanimity = list(hash = expected_n6_source_hashes$N4)
  )
  private_record_ids <- character()
  private_source_ids <- list(majority = character(), unanimity = character())
  valid_private <- all(vapply(names(source_map), function(institution) {
    cells <- interface$private_rule_cells[[institution]]
    if (!is_valid_coverage_cells(cells, "private_rule_records")) {
      return(FALSE)
    }
    records <- unlist(lapply(cells, `[[`, "private_rule_records"), recursive = FALSE)
    if (length(records) == 0L) {
      return(TRUE)
    }
    valid <- all(vapply(records, function(record) {
      is_valid_n6_private_record(
        record,
        institution,
        source_map[[institution]]$hash
      )
    }, logical(1)))
    private_record_ids <<- c(
      private_record_ids,
      vapply(records, `[[`, character(1), "private_rule_record_id")
    )
    private_source_ids[[institution]] <<- vapply(
      records,
      `[[`,
      character(1),
      "source_equilibrium_id"
    )
    isTRUE(valid)
  }, logical(1)))
  if (!isTRUE(valid_private) || anyDuplicated(private_record_ids)) {
    return(FALSE)
  }

  comparison_cells <- interface$comparison_cells
  if (!is_valid_coverage_cells(comparison_cells, "comparison_records")) {
    return(FALSE)
  }
  comparison_records <- unlist(
    lapply(comparison_cells, `[[`, "comparison_records"),
    recursive = FALSE
  )
  if (length(comparison_records) == 0L) {
    return(TRUE)
  }
  comparison_ids <- vapply(
    comparison_records,
    `[[`,
    character(1),
    "comparison_id"
  )
  isTRUE(all(vapply(comparison_records, function(record) {
    is_valid_n6_comparison_record(record) &&
      record$source_equilibrium_ids$majority %in% private_source_ids$majority &&
      record$source_equilibrium_ids$unanimity %in% private_source_ids$unanimity
  }, logical(1)))) &&
    !anyDuplicated(comparison_ids)
}

# Frozen N1/N2 are consumable only on exact artifact bytes, object-identical
# interfaces, lifecycle fields, and same-hash PASS 0/0/0 reviews. Former
# N3/N4/N6 candidates remain hash-pinned provenance only.
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
    artifact_path = "essential_input_interfaces/n3_r1_majority_candidate_v1.json",
    artifact_hash = "sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee",
    dependency_hashes = list(
      N1 = "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
    ),
    started_order = 5L,
    passed_order = 6L,
    formal_reviewer_id = "review-n3-beta-formal-2026-08-18-r3",
    game_reviewer_id = "review-n3-beta-game-2026-08-18-r3"
  ),
  N4 = list(
    artifact_path = "essential_input_n4_r1_unanimity_interface.json",
    artifact_hash = "sha256:ee61ce6f854d4393f51048592a5221a9999a8f3f7daca1e749e7f19a88927f2d",
    dependency_hashes = list(
      N2 = "sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2"
    ),
    started_order = 7L,
    passed_order = 8L,
    formal_reviewer_id = "review-n4-formal-2026-08-19-r8",
    game_reviewer_id = "review-n4-game-2026-08-19-r8"
  ),
  N6 = list(
    artifact_path = "essential_input_n6_private_information_comparison_v1.json",
    artifact_hash = "sha256:e5a71e29720598f829beb4f720bc966a64d2b04569ded0ba404cdd03b81b3f2a",
    dependency_hashes = expected_n6_source_hashes,
    started_order = 9L,
    passed_order = 10L,
    formal_reviewer_id = "review-n6-formal-2026-08-19-r1",
    game_reviewer_id = "review-n6-game-2026-08-19-r1"
  )
)

current_frozen_ids <- c("N1", "N2")

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

for (node_id in c("N3", "N4", "N6")) {
  assert_true(
    identical(leaf_specs[[node_id]]$computed_hash, leaf_specs[[node_id]]$artifact_hash),
    paste(node_id, "obsolete candidate bytes changed instead of remaining provenance.")
  )
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

for (node_id in current_frozen_ids) {
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

n3_review_report_specs <- list(
  formal_design = list(
    path = file.path(
      repository_root, "quality_reports",
      "2026-08-18_essential_input_goal1_n3_beta_formal_design_review_round3.md"
    ),
    expected_hash = "6003aea1922435faf53f6bd94481366888d82456ab32b8ca4caec259aaa32873",
    reviewer_id = leaf_specs$N3$formal_reviewer_id
  ),
  game_theory = list(
    path = file.path(
      repository_root, "quality_reports",
      "2026-08-18_essential_input_goal1_n3_beta_game_theory_review_round3.md"
    ),
    expected_hash = "580eb6ed8291f4a20e531a22f043307ee23e116d0ba09c48ac372cfce1ff3d83",
    reviewer_id = leaf_specs$N3$game_reviewer_id
  )
)

is_valid_n3_review_report <- function(lines, role, spec) {
  identical(lines, spec$canonical_lines) &&
    length(lines) > 40L &&
    any(grepl(role, lines, fixed = TRUE)) &&
    any(grepl(spec$reviewer_id, lines, fixed = TRUE)) &&
    any(grepl(sub("^sha256:", "", leaf_specs$N3$artifact_hash), lines, fixed = TRUE)) &&
    any(grepl(sub("^sha256:", "", leaf_specs$N3$dependency_hashes$N1), lines, fixed = TRUE)) &&
    any(grepl("7072a58bf9fbaf012535418a93418dffb8d4692f13919f39101c8ecb37710f6b", lines, fixed = TRUE)) &&
    any(grepl("PASS", lines, fixed = TRUE)) &&
    any(grepl("critical[^0-9]*0", lines, ignore.case = TRUE, perl = TRUE)) &&
    any(grepl("major[^0-9]*0", lines, ignore.case = TRUE, perl = TRUE)) &&
    any(grepl("minor[^0-9]*0", lines, ignore.case = TRUE, perl = TRUE)) &&
    !any(grepl("VEREDICTO ESTRITO: FAIL", lines, fixed = TRUE))
}

for (role in names(n3_review_report_specs)) {
  spec <- n3_review_report_specs[[role]]
  assert_true(file.exists(spec$path), paste("Missing saved N3 Round-3 report for", role))
  assert_true(
    identical(sha256_file(spec$path), spec$expected_hash),
    paste("The complete saved N3 Round-3 report changed for", role)
  )
  spec$canonical_lines <- readLines(spec$path, encoding = "UTF-8", warn = FALSE)
  n3_review_report_specs[[role]] <- spec
  assert_true(
    is_valid_n3_review_report(spec$canonical_lines, role, spec),
    paste("The N3 Round-3 report lacks exact same-hash PASS 0/0/0 evidence for", role)
  )
}

n4_verifier_path <- file.path(repository_root, "scripts", "verify_essential_input_n4.R")
expected_n4_verifier_hash <- "0bb26aeac0860f9b37c507c6bb8586d2fa9efb67361670a0f24365d8872976d6"
assert_true(file.exists(n4_verifier_path), "Missing preserved obsolete N4 verifier.")
assert_true(
  identical(sha256_file(n4_verifier_path), expected_n4_verifier_hash),
  "The obsolete N4 verifier changed instead of remaining preserved as provenance."
)

n4_review_report_specs <- list(
  formal_design = list(
    path = file.path(
      repository_root, "quality_reports",
      "2026-08-19_n4_formal_design_review_round8.md"
    ),
    expected_hash = "ba759c1c1eee3ebaf52fc68aca7dc4d4e6bc543e5c0e90c082928658b010143f",
    reviewer_id = leaf_specs$N4$formal_reviewer_id
  ),
  game_theory = list(
    path = file.path(
      repository_root, "quality_reports",
      "2026-08-19_n4_game_theory_review_round8.md"
    ),
    expected_hash = "89a38bcaea025f6c06c10688cae6967a61fe62c6e801f15e803bd89c3159071d",
    reviewer_id = leaf_specs$N4$game_reviewer_id
  )
)

is_valid_n4_review_report <- function(lines, role, spec) {
  identical(lines, spec$canonical_lines) &&
    length(lines) >= 7L &&
    any(lines == paste0("reviewer_role: ", role)) &&
    any(lines == paste0("reviewer_id: ", spec$reviewer_id)) &&
    any(lines == paste0("artifact_hash: ", leaf_specs$N4$artifact_hash)) &&
    any(lines == "verdict: PASS") &&
    any(lines == "finding_counts: critical=0, major=0, minor=0") &&
    any(lines == "findings:") &&
    any(lines == "none") &&
    !any(grepl("FAIL", lines, fixed = TRUE))
}

for (role in names(n4_review_report_specs)) {
  spec <- n4_review_report_specs[[role]]
  assert_true(file.exists(spec$path), paste("Missing saved N4 Round-8 report for", role))
  assert_true(
    identical(sha256_file(spec$path), spec$expected_hash),
    paste("The complete saved N4 Round-8 report changed for", role)
  )
  spec$canonical_lines <- readLines(spec$path, encoding = "UTF-8", warn = FALSE)
  n4_review_report_specs[[role]] <- spec
  assert_true(
    is_valid_n4_review_report(spec$canonical_lines, role, spec),
    paste("The N4 Round-8 report lacks exact same-hash PASS 0/0/0 evidence for", role)
  )
}

n6_verifier_path <- file.path(repository_root, "scripts", "verify_essential_input_n6.R")
expected_n6_verifier_hash <- "7cf5db2ed94cfe09eb70d0ae3c41a797c70deac999f5a781da9d43f165e6ead5"
assert_true(file.exists(n6_verifier_path), "Missing preserved obsolete N6 verifier.")
assert_true(
  identical(sha256_file(n6_verifier_path), expected_n6_verifier_hash),
  "The obsolete N6 verifier changed instead of remaining preserved as provenance."
)
n6_verifier_output <- system2(
  "Rscript",
  c("--vanilla", shQuote(n6_verifier_path)),
  stdout = TRUE,
  stderr = TRUE
)
n6_verifier_status <- attr(n6_verifier_output, "status")
if (is.null(n6_verifier_status)) {
  n6_verifier_status <- 0L
}
assert_true(
  identical(as.integer(n6_verifier_status), 0L) &&
    any(grepl("PASS: six negative mutation tests rejected.", n6_verifier_output, fixed = TRUE)),
  "The preserved obsolete N6 verifier must still reproduce its historical checks."
)

n6_support_specs <- list(
  builder = list(
    path = file.path(repository_root, "scripts", "build_essential_input_n6.R"),
    expected_hash = "30198bc5ad3e37b9a9fa8a3a27710dcf73fb2df17d97f7bf3054daa5adfb75e3"
  ),
  ledger = list(
    path = file.path(
      repository_root,
      "model_redesign",
      "essential_input_n6_private_information_comparison_ledger.json"
    ),
    expected_hash = "e68ab1efe0e41becf98682cac6ecfa453b0ee702e9300ecf2454c74818f28d00"
  ),
  derivation = list(
    path = file.path(
      repository_root,
      "model_redesign",
      "essential_input_n6_private_information_comparison_derivation.md"
    ),
    expected_hash = "8a11621b073732b48a647ddb4d484f27ec2d1d1134c6d2d0648330afd18702e5"
  )
)
for (support_name in names(n6_support_specs)) {
  spec <- n6_support_specs[[support_name]]
  assert_true(file.exists(spec$path), paste("Missing N6", support_name, "artifact."))
  assert_true(
    identical(sha256_file(spec$path), spec$expected_hash),
    paste("The obsolete N6", support_name, "artifact changed instead of remaining preserved.")
  )
}

n6_review_report_specs <- list(
  formal_design = list(
    path = file.path(
      repository_root,
      "quality_reports",
      "2026-08-19_n6_formal_design_review.md"
    ),
    expected_hash = "b7f992e225b5beb4500cbfd2642e5d9a374da5df3e64c29440129f28e2530bfc",
    reviewer_id = leaf_specs$N6$formal_reviewer_id
  ),
  game_theory = list(
    path = file.path(
      repository_root,
      "quality_reports",
      "2026-08-19_n6_game_theory_review.md"
    ),
    expected_hash = "21b62b38b1078b20195fcf356bdd0253fd2a22846e23fce56ec5d4de414cfdea",
    reviewer_id = leaf_specs$N6$game_reviewer_id
  )
)

is_valid_n6_review_report <- function(lines, role, spec) {
  identical(lines, spec$canonical_lines) &&
    length(lines) >= 20L &&
    any(grepl(paste0("**Papel:** `", role, "`"), lines, fixed = TRUE)) &&
    any(grepl("read-only; implementador", lines, fixed = TRUE)) &&
    any(grepl("revisor", lines, fixed = TRUE)) &&
    any(grepl(leaf_specs$N6$artifact_hash, lines, fixed = TRUE)) &&
    any(grepl("PASS", lines, fixed = TRUE)) &&
    any(grepl("critical 0 / major 0 / minor 0", lines, fixed = TRUE)) &&
    !any(grepl("FAIL", lines, fixed = TRUE))
}

for (role in names(n6_review_report_specs)) {
  spec <- n6_review_report_specs[[role]]
  assert_true(file.exists(spec$path), paste("Missing saved N6 review report for", role))
  assert_true(
    identical(sha256_file(spec$path), spec$expected_hash),
    paste("The complete saved N6 review report changed for", role)
  )
  spec$canonical_lines <- readLines(spec$path, encoding = "UTF-8", warn = FALSE)
  n6_review_report_specs[[role]] <- spec
  assert_true(
    is_valid_n6_review_report(spec$canonical_lines, role, spec),
    paste("The preserved obsolete N6 report lacks its historical same-hash PASS 0/0/0 evidence for", role)
  )
}

for (node_id in current_frozen_ids) {
  spec <- leaf_specs[[node_id]]
  mutate_and_reject_leaf <- function(label, mutate_node) {
    altered <- mutate_node(clone_object(nodes[[node_id]]))
    assert_true(
      !is_valid_current_leaf(node_id, altered, spec),
      paste("Negative frozen-leaf mutation passed:", node_id, label)
    )
  }
  mutate_and_reject_leaf("wrong artifact hash", function(x) {
    x$artifact_hash <- paste0("sha256:", paste(rep("0", 64L), collapse = "")); x
  })
  mutate_and_reject_leaf("wrong interface object", function(x) {
    x$interface$correspondence_cells[[1L]]$cell_id <- "CORRUPTED"; x
  })
  mutate_and_reject_leaf("wrong artifact path", function(x) {
    x$artifact_path <- "wrong.json"; x
  })
  mutate_and_reject_leaf("spurious dependency", function(x) {
    x$dependency_hashes$N0 <- spec$artifact_hash; x
  })
  if (length(spec$dependency_hashes) > 0L) {
    mutate_and_reject_leaf("wrong dependency hash", function(x) {
      dependency_id <- names(spec$dependency_hashes)[[1L]]
      x$dependency_hashes[[dependency_id]] <- spec$artifact_hash
      x
    })
  }
  mutate_and_reject_leaf("wrong execution order", function(x) {
    x$passed_order <- x$started_order; x
  })
  mutate_and_reject_leaf("wrong reviewer id", function(x) {
    x$reviews[[2L]]$reviewer_id <- "wrong-reviewer"; x
  })
  mutate_and_reject_leaf("wrong review hash", function(x) {
    x$reviews[[2L]]$artifact_hash <- paste0("sha256:", paste(rep("f", 64L), collapse = "")); x
  })
  mutate_and_reject_leaf("nonzero finding", function(x) {
    x$reviews[[1L]]$finding_counts$minor <- 1L; x
  })
  mutate_and_reject_leaf("extra review", function(x) {
    x$reviews[[3L]] <- x$reviews[[2L]]; x$reviews[[3L]]$reviewer_id <- "extra-reviewer"; x
  })
}
for (role in names(review_report_specs)) {
  spec <- review_report_specs[[role]]
  assert_true(
    !is_valid_review_report(c(spec$canonical_lines, "FAIL"), role, spec),
    paste("An appended FAIL must invalidate the saved report for", role)
  )
}
for (role in names(n3_review_report_specs)) {
  spec <- n3_review_report_specs[[role]]
  assert_true(
    !is_valid_n3_review_report(c(spec$canonical_lines, "VEREDICTO ESTRITO: FAIL"), role, spec),
    paste("An appended FAIL must invalidate the N3 Round-3 report for", role)
  )
}

for (role in names(n4_review_report_specs)) {
  spec <- n4_review_report_specs[[role]]
  assert_true(
    !is_valid_n4_review_report(c(spec$canonical_lines, "FAIL"), role, spec),
    paste("An appended FAIL must invalidate the N4 Round-8 report for", role)
  )
}

for (role in names(n6_review_report_specs)) {
  spec <- n6_review_report_specs[[role]]
  assert_true(
    !is_valid_n6_review_report(c(spec$canonical_lines, "FAIL"), role, spec),
    paste("An appended FAIL must invalidate the preserved obsolete N6 report for", role)
  )
}

# Reopened N3/N4 and their pending descendants N6/N7 retain exact null envelopes.
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

collect_named_field_paths <- function(x, path = list()) {
  if (!is.list(x)) {
    return(list())
  }
  result <- list()
  object_names <- names(x)
  if (!is.null(object_names)) {
    for (index in seq_along(x)) {
      token <- list(kind = "name", key = object_names[[index]])
      next_path <- c(path, list(token))
      result <- c(result, list(next_path), collect_named_field_paths(x[[index]], next_path))
    }
  } else if (length(x) > 0L) {
    for (index in seq_along(x)) {
      token <- list(kind = "index", key = index)
      next_path <- c(path, list(token))
      result <- c(result, collect_named_field_paths(x[[index]], next_path))
    }
  }
  result
}

set_path_value <- function(x, path, value) {
  token <- path[[1L]]
  key <- if (identical(token$kind, "name")) token$key else as.integer(token$key)
  if (length(path) == 1L) {
    x[[key]] <- value
  } else {
    x[[key]] <- set_path_value(x[[key]], path[-1L], value)
  }
  x
}

path_label <- function(path) {
  paste(vapply(path, function(token) as.character(token$key), character(1)), collapse = "/")
}

manifest_field_paths <- collect_named_field_paths(manifest)
assert_true(
  length(manifest_field_paths) > 0L,
  "The recursive manifest mutation fixture found no named fields."
)
for (field_path in manifest_field_paths) {
  altered_manifest <- set_path_value(
    clone_object(manifest),
    field_path,
    list(corrupted_manifest_field = path_label(field_path))
  )
  assert_true(
    !is_valid_canonical_manifest(altered_manifest),
    paste("Recursive full-manifest mutation passed:", path_label(field_path))
  )
}

current_pending_ids <- c("N3", "N4", "N6", "N7")
assert_true(
  all(vapply(current_pending_ids, function(node_id) {
    is_valid_current_pending_node(node_id, nodes[[node_id]])
  }, logical(1))),
  "N3, N4, N6, and N7 must retain the exact pending/null lifecycle after the Option-A reopening."
)

# Current-state mutations cannot smuggle a stale result, lifecycle fact, or
# nonempty interface back into the reopened Gate 0.
for (node_id in current_pending_ids) {
  current <- nodes[[node_id]]

  stale_status <- clone_object(current)
  stale_status$status <- "pass"
  assert_true(
    !is_valid_current_pending_node(node_id, stale_status),
    paste("A stale PASS status must fail for", node_id)
  )

  stale_hash <- clone_object(current)
  stale_hash$artifact_hash <- paste0("sha256:", paste(rep("a", 64L), collapse = ""))
  stale_hash$frozen <- TRUE
  stale_hash$reviews <- list()
  assert_true(
    !is_valid_current_pending_node(node_id, stale_hash),
    paste("Stale lifecycle fields must fail for", node_id)
  )

  extra_authorization <- clone_object(current)
  extra_authorization$authorized <- TRUE
  assert_true(
    !is_valid_current_pending_node(node_id, extra_authorization),
    paste("An extra authorized=true field must fail for", node_id)
  )

  arbitrary_extra <- clone_object(current)
  arbitrary_extra$unexpected_field <- "forbidden"
  assert_true(
    !is_valid_current_pending_node(node_id, arbitrary_extra),
    paste("Every extra pending-node field must fail for", node_id)
  )

  interface_authorization <- clone_object(current)
  interface_authorization$interface$authorized <- TRUE
  assert_true(
    !is_valid_current_pending_node(node_id, interface_authorization),
    paste("An interface-level authorized field must fail for", node_id)
  )

  function_authorization <- clone_object(current)
  function_authorization$interface$function_of$authorized <- TRUE
  assert_true(
    !is_valid_current_pending_node(node_id, function_authorization),
    paste("A function_of-level authorized field must fail for", node_id)
  )

  nested_interface_extra <- clone_object(current)
  if (identical(node_id, "N6")) {
    nested_interface_extra$interface$private_rule_cells["unexpected_field"] <- list(NULL)
  } else if (identical(node_id, "N7")) {
    nested_interface_extra$interface$public_equilibrium_cells$majority["unexpected_field"] <- list(NULL)
  } else {
    nested_interface_extra$interface$function_of$unexpected_field <- "forbidden"
  }
  assert_true(
    !is_valid_current_pending_node(node_id, nested_interface_extra),
    paste("Every nested pending-interface extra field must fail for", node_id)
  )

  filled_interface <- clone_object(current)
  if (node_id %in% c("N1", "N2", "N3", "N4")) {
    filled_interface$interface$correspondence_cells <- list(list(stale = TRUE))
  } else if (identical(node_id, "N6")) {
    filled_interface$interface$private_rule_cells$majority <- list(list(stale = TRUE))
  } else {
    filled_interface$interface$informational_rent_cells$majority <- list(list(stale = TRUE))
  }
  assert_true(
    !is_valid_current_pending_node(node_id, filled_interface),
    paste("A stale nonempty interface must fail for", node_id)
  )

  field_paths <- collect_named_field_paths(current)
  for (field_path in field_paths) {
    altered <- set_path_value(
      clone_object(current),
      field_path,
      list(corrupted_field = path_label(field_path))
    )
    assert_true(
      !is_valid_current_pending_node(node_id, altered),
      paste("Recursive pending-node mutation passed:", node_id, path_label(field_path))
    )
  }
}

assert_true(
    is_valid_contract_semantics(contract_text),
  paste0(
    "The contract must retain strict beta<1, byte-identical frozen N1/N2, the Option-A N3/N4 reopening, ",
    "conditional N6/N7 continuation, nu=0 reporting coordinates, persistent PDFs, and explicit exclusion of Goal 5/beta=1/manuscript migration."
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
  "`DeltaRI`. Ao fim da Fase A",
  "`DeltaRI`, que pode ser calculado na Fase A. Ao fim da Fase A",
  contract_text,
  fixed = TRUE
)
assert_true(
  !is_valid_reopened_authorization(expanded_authorization),
  "Expanding Phase A to informational-rent calculation must fail."
)

broadened_protocol_exception <- sub(
  "não se aplica a nenhuma outra alteração passada ou futura da Seção 11",
  "também se aplica a outras alterações administrativas passadas ou futuras da Seção 11",
  contract_text,
  fixed = TRUE,
  useBytes = TRUE
)
assert_true(
  !is_valid_single_phaseA_protocol_exception(broadened_protocol_exception) &&
    !is_valid_contract_semantics(broadened_protocol_exception),
  "The one-time Section 11 administrative exception must not generalize."
)

phaseB_via_protocol_exception <- sub(
  "cruzar o candidato",
  "cruzar livremente o candidato",
  contract_text,
  fixed = TRUE,
  useBytes = TRUE
)
assert_true(
  !is_valid_single_phaseA_protocol_exception(phaseB_via_protocol_exception) &&
    !is_valid_contract_semantics(phaseB_via_protocol_exception),
  "The administrative exception must not authorize Phase B comparisons."
)

n7_freeze_via_protocol_exception <- sub(
  "continua `pending` e `unfrozen`",
  "pode passar e ser congelado",
  contract_text,
  fixed = TRUE,
  useBytes = TRUE
)
assert_true(
  !is_valid_single_phaseA_protocol_exception(n7_freeze_via_protocol_exception) &&
    !is_valid_contract_semantics(n7_freeze_via_protocol_exception),
  "The administrative exception must not authorize N7 pass or freeze."
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
    text = "AUTORIZAÇÃO POSTERIOR: a Fase B e as rendas podem começar sem novo gate."
  ),
  list(
    region = "delay",
    text = "A referência de Eraslan e Evdokimov demonstra o sinal positivo de D."
  ),
  list(
    region = "header",
    text = "DECISÃO POSTERIOR: desconto unitário integra o benchmark e N7 pode ser congelado na Fase A."
  )
)
formal_reviewer_mutations <- list(
  list(
    region = "header",
    text = "**Autorizacao corrente adicional:** Fase B, freeze de N7 e beta=1 estao autorizados agora."
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
  n7_authorization_in_header = function(text) {
    insert_in_authorization_header(
      text,
      "Autorizacao adicional: a Fase B e o freeze de N7 podem comecar imediatamente."
    )
  },
  n7_authorization_in_section_11 = function(text) {
    insert_before_matching_line(
      text,
      function(line) startsWith(line, "## 12. Invalida"),
      "Autorizacao adicional da Secao 11: Fase B, rendas e freeze de N7 estao liberados."
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
      "Autorizacao corrente adicional: Fase B, freeze de N7 e beta=1 estao autorizados."
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
  function(mutate) is_valid_contract_semantics(mutate(contract_text)),
  logical(1)
)
assert_true(
  all(!r3_contract_mutation_results),
  "At least one of the nine Round 3 full-contract mutations was accepted."
)

coordinated_r3_contract_mutation <- r3_contract_mutations$beta_exception_after_primitive(
  contract_text
)
coordinated_r3_contract_mutation <- r3_contract_mutations$n7_authorization_in_section_11(
  coordinated_r3_contract_mutation
)
assert_true(
  !is_valid_contract_semantics(coordinated_r3_contract_mutation),
  "The coordinated Section 2 plus Section 11 Round 3 mutation must fail."
)

manifest_with_authorized_nodes <- clone_object(manifest)
manifest_with_authorized_nodes$authorized_nodes <- list("N6")
assert_true(
  !is_valid_manifest_top_level(manifest_with_authorized_nodes) &&
    !is_valid_canonical_manifest(manifest_with_authorized_nodes),
  "The manifest envelope must reject an extra authorized_nodes field."
)

nested_manifest_mutations <- list(
  invalidation_rule_extra = local({
    candidate <- clone_object(manifest)
    candidate$invalidation_rule$authorized_nodes <- list("N6")
    candidate
  }),
  freeze_gate_schema_extra = local({
    candidate <- clone_object(manifest)
    candidate$freeze_gate_schema$authorized_goal <- "Goal 3"
    candidate
  }),
  interface_schema_extra = local({
    candidate <- clone_object(manifest)
    candidate$interface_schemas$private_information_comparison_v1$authorized_nodes <- list("N6")
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
coordinated_manifest_mutation$nodes[[6L]]$authorized <- TRUE
assert_true(
  !is_valid_contract_semantics(coordinated_contract_mutation) &&
    !is_valid_current_pending_node("N7", coordinated_manifest_mutation$nodes[[6L]]) &&
    !is_valid_canonical_manifest(coordinated_manifest_mutation),
  "The coordinated contract-plus-N7 authorization mutation must fail both validators."
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
  identical(sort(topologically_ready_nodes(nodes)), c("N3", "N4")),
  paste0(
    "With only N1 and N2 frozen after the Option-A reopening, exactly N3 and N4 must be topologically ready. ",
    "Topological readiness does not freeze either node or bypass the two-review gates before N6."
  )
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
    "MUTATION_REJECTED: the independent full-contract identity returned FALSE for all 9 ",
    "Round 3 mutations when only the first external pin was bypassed; regional diagnostics, ",
    "the coordinated Section 2/Section 11 mutation, full-manifest recursive identity/hash, ",
    "nested invalidation/freeze/interface-schema extras, interface/function_of authorized ",
    "fields, stale lifecycle, and every recursively mutated manifest field also failed.\n"
  )
)

cat(
  paste0(
    "PASS: strict o_1 < 1 and beta < 1 contract with byte/object-identical N1/N2 pass/frozen on exact reviewed artifacts; ",
    "the author-approved Section 12.2 Option-A lifecycle reopening makes N3/N4 pending/unfrozen and leaves their descendants N6/N7 pending/unfrozen; ",
    "the old N3/N4/N6 hashes/reviews and the Phase A candidate remain obsolete provenance. N3 and N4 are topologically ready and authorized for cold rederivation/review; ",
    "N6 is authorized conditionally after both refreeze, then the already authorized N7 Phase B resumes while N7 stays pending/unfrozen until final author approval. ",
    "The nu=0 reporting coordinates and permanent hashed-PDF rule are pinned; Goal 5 figures, beta=1, and v5/v6 manuscript migration/compilation remain unauthorized. ",
    "Typed coverage cells for empty and ",
    "nonempty correspondences, independent RI_M and RI_U with a separate DeltaRI ",
    "contrast, role-typed public payoffs, terminal complete-information benchmark, ",
    "two-review freeze gates, byte-identical N1/N2 integration, N3/N4 readiness, negative schema tests, and ",
    "invalidation rules verified. Topological ",
    "readiness does not grant author authorization; Section 11 controls.\n"
  )
)
