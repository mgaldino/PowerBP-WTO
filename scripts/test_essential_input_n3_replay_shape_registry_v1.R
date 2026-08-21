#!/usr/bin/env Rscript

# Generated adversarial tests for the closed S01--S29 replay grammar.  The raw
# traversal that selects mutation targets does not consult the registry.

source("scripts/lib_essential_input_semantic_ast_v1.R")
source("scripts/lib_essential_input_exact_algebra_v1.R")
source("scripts/lib_essential_input_schema_roles_v1.R")
source("scripts/lib_essential_input_n3_game_kernel_v1.R")
source("scripts/lib_essential_input_proof_kernel_v1.R")

expect_rejection <- function(thunk, expected_code, expected_message, label) {
  stopifnot(is.character(expected_code), length(expected_code) == 1L,
            is.character(expected_message), length(expected_message) == 1L,
            nzchar(expected_message))
  message_text <- tryCatch({
    thunk()
    NULL
  }, error = function(error) conditionMessage(error))
  if (is.null(message_text)) stop(paste("shape mutation was accepted:", label))
  expected_text <- paste0("FAIL_", expected_code, ": ", expected_message)
  if (!identical(message_text, expected_text)) {
    stop(paste("shape mutation failed in the wrong layer:", label, message_text))
  }
  invisible(message_text)
}

# The numeral language has three independent implementations: the semantic
# lexer/parser, the proof-kernel AST checker, and the literal shape registry.
# The clean replay contains only the canonical unsigned integer literals
# 0, 1, 2, and 3; fractions and negatives are represented by AST operators.
noncanonical_numerals <- list(
  leading_zero = list(literal = "01",
                      parser = "noncanonical numeric literal 01"),
  unary_plus = list(literal = "+1",
                    parser = "noncanonical unary plus numeral +1"),
  trailing_decimal = list(literal = "1.",
                          parser = "noncanonical numeric literal 1."),
  double_zero = list(literal = "00",
                     parser = "noncanonical numeric literal 00"),
  negative_zero = list(literal = "-0",
                       parser = "noncanonical negative zero numeral -0")
)
number_leaf_registry <- pk_replay_shape_registry_v1()
number_leaf_names <- names(number_leaf_registry$leaves)[vapply(
  number_leaf_registry$leaves,
  function(spec) identical(spec$edge, "K:number/value"), logical(1))]
stopifnot(length(number_leaf_names) == 1L)
number_leaf_schema <- paste0("L:", number_leaf_names[[1L]])
for (case_name in names(noncanonical_numerals)) {
  case <- noncanonical_numerals[[case_name]]
  ast <- list(kind = "number", sort = "Rational", value = case$literal)
  path <- paste0("/fixture/canonical_number/", case_name)
  expect_rejection(
    function() sc_parse_complete(case$literal, list(), "Rational"),
    "PARSE", case$parser, paste("semantic numeral", case_name))
  expect_rejection(
    function() pk_assert_typed_ast_independent(ast, path = path),
    "TYPE", paste("AST_TYPECHECK malformed number at", path),
    paste("proof numeral", case_name))
  registry_path <- paste0(path, "/value")
  expect_rejection(
    function() pk_validate_shape_leaf(
      case$literal, number_leaf_schema, registry_path, "K:number", ast),
    "COVERAGE", paste("SHAPE_REGISTRY leaf grammar changed at", registry_path),
    paste("registry numeral", case_name))
}
message("CANONICAL_NUMERAL_THREE_LAYER_DIRECT 15/15")
for (literal in c("4", "999", "4294967296")) {
  ast <- list(kind = "number", sort = "Rational", value = literal)
  parsed <- sc_parse_complete(literal, list(), "Rational")
  stopifnot(identical(parsed, ast))
  pk_assert_typed_ast_independent(ast, path = "/fixture/canonical_integer")
  pk_validate_shape_leaf(literal, number_leaf_schema,
                         "/fixture/canonical_integer/value", "K:number", ast)
}
message("CANONICAL_NUMERAL_NONOBSERVED_POSITIVES 9/9")

# Exact-algebra objects are validated recursively before any gmp operation.
# In particular, a forged bigq class is rejected before dispatching a gmp
# printer, which is unsafe on arbitrary raw buffers.
for (literal in c("0", "1", "-1", "4294967296", "-4294967296",
                  "4294967296/3", "1/4294967296")) {
  ea_assert_bigq_scalar(gmp::as.bigq(literal), paste("clean coefficient", literal))
}
ea_assert_poly(ea_poly_constant(1), "clean polynomial")
ea_assert_rat(ea_rat_constant(1), "clean rational")
large_literal_rat <- ea_ast_to_rat(
  list(kind = "number", sort = "Rational", value = "4294967296"))
stopifnot(identical(ea_rat_canonical(large_literal_rat),
                    "rat(4294967296@1)/(1@1)"))
zero_denominator_bigq <- gmp::as.bigq("1")
zero_denominator_raw <- gmp::as.bigq("0")
attributes(zero_denominator_raw) <- NULL
attr(zero_denominator_bigq, "denominator") <- zero_denominator_raw
bad_coefficients <- list(
  na_bigq = gmp::as.bigq(NA_character_),
  nan_numeric = NaN,
  inf_numeric = Inf,
  non_bigq = 1,
  forged_bigq = structure(as.raw(1L), class = "bigq",
                          denominator = as.raw(1L)),
  zero_denominator = zero_denominator_bigq
)
for (case_name in names(bad_coefficients)) {
  label <- paste("fixture", case_name)
  bad_poly <- structure(setNames(list(bad_coefficients[[case_name]]), "1"),
                        class = "ea_poly")
  expect_rejection(
    function() ea_assert_poly(bad_poly, label), "TYPE",
    paste(label, "coefficient 1 is not a canonical finite bigq scalar"),
    paste("algebra coefficient", case_name))
}
malformed_monomial <- structure(
  setNames(list(gmp::as.bigq("1")), "x^01"), class = "ea_poly")
expect_rejection(function() ea_assert_poly(malformed_monomial, "fixture monomial"),
                 "TYPE", "fixture monomial contains a malformed monomial",
                 "malformed monomial")
explicit_zero_term <- structure(
  setNames(list(gmp::as.bigq("0")), "1"), class = "ea_poly")
expect_rejection(function() ea_assert_poly(explicit_zero_term, "fixture zero"),
                 "TYPE", "fixture zero coefficient 1 is a forbidden zero coefficient",
                 "explicit zero coefficient")
recursive_bad_rat <- structure(
  list(numerator = structure(setNames(list(NaN), "1"), class = "ea_poly"),
       denominator = ea_poly_constant(1)), class = "ea_rat")
expect_rejection(function() ea_assert_rat(recursive_bad_rat, "fixture rational"),
                 "TYPE",
                 paste("fixture rational numerator coefficient 1 is not a",
                       "canonical finite bigq scalar"),
                 "recursive malformed rational coefficient")
wrong_class_rat <- unclass(ea_rat_constant(1))
expect_rejection(function() ea_assert_rat(wrong_class_rat, "fixture rational class"),
                 "TYPE", "fixture rational class is not an ea_rat object",
                 "malformed rational class")
expect_rejection(
  function() ea_poly(list(`x^2147483648` = "1")), "TYPE",
  "polynomial contains a malformed monomial",
  "constructor rejects exponent above integer range")
max_exponent_poly <- ea_poly(list(`x^2147483647` = "1"))
expect_rejection(
  function() ea_poly_multiply(max_exponent_poly, max_exponent_poly), "TYPE",
  "polynomial exponent sum exceeds exact integer range",
  "multiplication rejects exponent sum overflow")
bad_monomial_exponents <- list(
  overflow = 2147483648,
  missing = NA_integer_,
  negative = -1L,
  fractional = 1.5
)
for (case_name in names(bad_monomial_exponents)) {
  expect_rejection(
    function() ea_monomial(c(x = bad_monomial_exponents[[case_name]])), "TYPE",
    paste("monomial exponent for x must be a canonical integer in",
          "[0, .Machine$integer.max]"),
    paste("monomial API", case_name))
}
stopifnot(identical(ea_monomial(c(y = 2L, z = 0L, x = 1L)), "x^1*y^2"))
bad_decoder_keys <- list(
  vector = c("x^1", "y^2"),
  empty = character(0),
  noncharacter = 1
)
for (case_name in names(bad_decoder_keys)) {
  expect_rejection(
    function() ea_decode_monomial(bad_decoder_keys[[case_name]]), "TYPE",
    "malformed monomial reached the decoder",
    paste("monomial decoder", case_name))
}
stopifnot(identical(ea_decode_monomial("x^1*y^2"), c(x = 1L, y = 2L)))
message("EXACT_ALGEBRA_RECURSIVE_DIRECT 19/19")

sorts <- n3g_symbol_sorts()
beta_ast <- pk_sym("beta", sorts); nu_ast <- pk_sym("nu", sorts)
o0_ast <- pk_sym("o_0", sorts); o1_ast <- pk_sym("o_1", sorts)
m_ast <- pk_sym("m", sorts)
stopifnot(identical(pk_mul(beta_ast, o0_ast)$sort, "Payoff"),
          identical(pk_div(beta_ast, m_ast)$sort, "PayoffShare"),
          identical(pk_mul(beta_ast, pk_div(pk_num(1), m_ast))$sort,
                    "PayoffShare"))
expect_rejection(function() pk_add(pk_add(o0_ast, o1_ast), nu_ast), "TYPE",
                 "operator + cannot combine a payoff expression with a probability expression",
                 "nested payoff plus probability")
expect_rejection(function() pk_add(pk_num(2), pk_add(o0_ast, nu_ast)), "TYPE",
                 "operator + cannot combine a payoff expression with a probability expression",
                 "nested scalar cannot erase payoff dimension")
expect_rejection(function() sc_parse_complete("o_0", sorts, "Probability"), "TYPE",
                 "expected sort Probability but got Payoff with semantic dimension Payoff",
                 "payoff atom is not probability")
expect_rejection(function() sc_parse_complete("nu", sorts, "Payoff"), "TYPE",
                 "expected sort Payoff but got Probability with semantic dimension Probability",
                 "probability atom is not payoff")
pr_ast <- sc_parse_complete("Pr(theta=1)", sorts, "Probability")
stopifnot(identical(pr_ast$kind, "call"), identical(pr_ast$name, "Pr"),
          identical(pr_ast$sort, "Probability"))
message("DIMENSIONAL_AST_NEGATIVES_OK")

primitives <- n3g_primitives()
n1 <- n3g_import_n1(
  "model_redesign/essential_input_interfaces/n1_r2_majority_candidate_v1.json"
)
coherent_bad_numeral_formula <- function(clean_formula, literal) {
  value <- clean_formula
  value$ast$left$value <- literal
  coefficient <- suppressWarnings(gmp::as.bigq(literal))
  value$rational$numerator <- structure(
    setNames(list(coefficient), "1"), class = "ea_poly")
  value$normal_form <- paste0("rat(", as.character(coefficient),
                              "@1)/(1@m^1)")
  value
}
clean_s01 <- pk_dispatch(n3g_generate_proofs()[[1L]], list(), primitives, n1, sorts)
for (case_name in names(noncanonical_numerals)) {
  bad_formula <- coherent_bad_numeral_formula(
    clean_s01, noncanonical_numerals[[case_name]]$literal)
  label <- paste0("coherent_", case_name)
  expect_rejection(
    function() pk_assert_formula_consistent(bad_formula, label), "TYPE",
    paste0("AST_TYPECHECK malformed number at /formula/", label, "/ast/left"),
    paste("coherent AST/NF/rational", case_name))
}
message("COHERENT_NUMERAL_FORMULA_DIRECT 5/5")
baseline <- pk_replay_proofs(
  n3g_generate_proofs(), primitives, n1, n3_claim_spec_v1()
)
stopifnot(identical(baseline$status, "INTERNAL_REPLAY_NOT_READY"),
          identical(baseline$shape_audit$status, "SHAPE_REGISTRY_CLOSED"),
          baseline$shape_audit$node_count == 15161L,
          baseline$shape_audit$atomic_leaf_count == 35273L,
          length(baseline$certificates) == 17L)

shape <- pk_assert_closed_replay_shapes(baseline$values, collect_nodes = TRUE)
raw_shape <- pk_raw_replay_inventory(baseline$values, keep_nodes = TRUE)
stopifnot(length(shape$nodes) == 15161L, length(raw_shape$nodes) == 15161L,
          length(raw_shape$leaf_nodes) == 35273L,
          identical(raw_shape$paths, shape$paths),
          identical(raw_shape$leaf_paths, shape$leaf_paths))
registry <- pk_replay_shape_registry_v1()
shape_by_path <- setNames(shape$nodes, vapply(shape$nodes, `[[`, character(1), "path"))
raw_nodes <- lapply(raw_shape$nodes, function(raw_node) {
  owned <- shape_by_path[[raw_node$path]]
  stopifnot(!is.null(owned), identical(raw_node$node_class,
                                      if (identical(owned$schema_id, "RAT")) "rat" else
                                        if (identical(owned$schema_id, "POLY")) "poly" else
                                          "generic"))
  owned$value <- raw_node$value
  owned
})

mutate_extra <- function(value, schema_id) {
  value[["unexpected_shape"]] <- TRUE
  value
}

is_maximal_ast <- function(node) {
  key <- if (startsWith(node$schema_id, "K:")) substring(node$schema_id, 3L) else ""
  !isTRUE(node$inside_ast) &&
    (key %in% registry$ast_kinds || key %in% c("domain_one", "domain_two"))
}

expected_shape_mutation <- function(node) {
  if (is_maximal_ast(node)) {
    return(list(code = "TYPE",
                message = paste("AST_TYPECHECK exact keys changed at", node$path)))
  }
  if (identical(node$schema_id, "RAT")) {
    return(list(code = "COVERAGE",
                message = paste("SHAPE_REGISTRY malformed ea_rat at", node$path)))
  }
  if (identical(node$schema_id, "POLY")) {
    return(list(code = "COVERAGE",
                message = paste("SHAPE_REGISTRY malformed ea_poly at", node$path)))
  }
  node_type <- pk_shape_schema_spec(node$schema_id, registry)$node_type
  message <- switch(node_type,
    array = paste("SHAPE_REGISTRY array shape changed at", node$path),
    positional_array = paste("SHAPE_REGISTRY positional array changed at", node$path),
    object = paste("SHAPE_REGISTRY object keys changed at", node$path),
    stop(paste("unowned mutation-test node type", node_type, node$path))
  )
  list(code = "COVERAGE", message = message)
}

direct_extra_rejections <- 0L
for (node in raw_nodes) {
  mutated <- mutate_extra(node$value, node$schema_id)
  expected <- expected_shape_mutation(node)
  expect_rejection(function() {
    pk_validate_replay_shape_node(
      mutated, node$schema_id, node$path, registry, collector = NULL,
      recursive = FALSE, inside_ast = node$inside_ast, ast_scope = node$ast_scope
    )
  }, expected$code, expected$message,
     paste("extra field at", node$path))
  direct_extra_rejections <- direct_extra_rejections + 1L
}
stopifnot(direct_extra_rejections == 15161L)
message("REJECTED_DIRECT_EXTRA_FIELDS 15161/15161")

# A representative missing/type-swap mutation for every schema exercised by
# the baseline.  Fixture-only AST schemas are tested separately below.
first_by_schema <- raw_nodes[!duplicated(vapply(
  raw_nodes, `[[`, character(1), "schema_id"
))]
representative_shape_rejections <- 0L
for (node in first_by_schema) {
  value <- node$value
  if (identical(node$schema_id, "RAT")) {
    mutated <- unclass(value)
  } else if (identical(node$schema_id, "POLY")) {
    mutated <- unclass(value)
  } else if (!is.null(names(value))) {
    mutated <- value[-length(value)]
  } else {
    mutated <- list(type_swap = TRUE)
  }
  expected <- expected_shape_mutation(node)
  expect_rejection(function() {
    pk_validate_replay_shape_node(
      mutated, node$schema_id, node$path, registry, collector = NULL,
      recursive = FALSE, inside_ast = node$inside_ast, ast_scope = node$ast_scope
    )
  }, expected$code, expected$message,
     paste("representative missing/type swap", node$schema_id))
  representative_shape_rejections <- representative_shape_rejections + 1L
}
message("REJECTED_REPRESENTATIVE_SCHEMA_MUTATIONS ",
        representative_shape_rejections, "/", length(first_by_schema))

find_node <- function(predicate, label) {
  hits <- Filter(predicate, raw_nodes)
  if (!length(hits)) stop(paste("missing baseline fixture:", label))
  hits[[1L]]
}

# Context-selected indexed-formula variants cannot be swapped by adding or
# deleting the domain member.
plain_indexed <- find_node(function(node) {
  identical(node$schema_id, "K:indexed_formula_plain") &&
    startsWith(node$path, "/S27/")
}, "plain indexed formula")
plain_mutated <- plain_indexed$value
plain_mutated$domain <- "forged_domain"
expect_rejection(function() {
  pk_validate_replay_shape_node(plain_mutated, plain_indexed$schema_id,
                                plain_indexed$path, registry, recursive = FALSE)
}, "COVERAGE", paste("SHAPE_REGISTRY object keys changed at", plain_indexed$path),
   "plain indexed formula gains a domain")

domain_indexed <- find_node(function(node) {
  identical(node$schema_id, "K:indexed_formula_domain") &&
    startsWith(node$path, "/S27/")
}, "domain indexed formula")
domain_mutated <- domain_indexed$value[-which(names(domain_indexed$value) == "domain")]
expect_rejection(function() {
  pk_validate_replay_shape_node(domain_mutated, domain_indexed$schema_id,
                                domain_indexed$path, registry, recursive = FALSE)
}, "COVERAGE", paste("SHAPE_REGISTRY object keys changed at", domain_indexed$path),
   "domain indexed formula loses its domain")

# Branch is validated before it selects the budget child schema.
feasibility_E <- find_node(function(node) {
  identical(node$schema_id, "O:feasibility_record") &&
    identical(node$value$branch, "E") && startsWith(node$path, "/S23/")
}, "E feasibility record")
budget_mutated <- feasibility_E$value
budget_mutated$budgets$P <- budget_mutated$budgets$E
expect_rejection(function() {
  pk_validate_replay_shape_node(budget_mutated, feasibility_E$schema_id,
                                feasibility_E$path, registry, recursive = TRUE)
}, "COVERAGE", "SHAPE_REGISTRY object keys changed at /S23/witnesses/4/budgets",
   "E budget is swapped to EP keys")

# The validated closure-record path/source context selects the exact local
# definition schema; the observed child keys never select their own variant.
empty_closure <- find_node(function(node) {
  identical(node$schema_id, "O:closure_record") &&
    is.list(node$value$local_definitions) &&
    length(node$value$local_definitions) == 0L
}, "empty local definitions")
local_mutated <- empty_closure$value
local_mutated$local_definitions <- list(W = "Set<Player>")
expect_rejection(function() {
  pk_validate_replay_shape_node(local_mutated, empty_closure$schema_id,
                                empty_closure$path, registry, recursive = TRUE)
}, "COVERAGE", paste0("SHAPE_REGISTRY array shape changed at ",
                       empty_closure$path, "/local_definitions"),
   "empty local definitions become W definitions")

# NULL, empty array, and scalar remain disjoint.
nullable_region <- find_node(function(node) {
  identical(node$schema_id, "O:region") && is.null(node$value$tie)
}, "nullable region tie")
null_mutated <- nullable_region$value
null_mutated$tie <- list()
expect_rejection(function() {
  pk_validate_replay_shape_node(null_mutated, nullable_region$schema_id,
                                nullable_region$path, registry, recursive = TRUE)
}, "COVERAGE", paste0("SHAPE_REGISTRY expected present NULL at ",
                       nullable_region$path, "/tie"),
   "NULL tie becomes empty array")

# Named atomic vectors have an exact type, length, names, and order.
payoff_table <- find_node(function(node) identical(node$schema_id, "O:weak_payoff_table"),
                          "weak payoff table")
atomic_mutated <- payoff_table$value
atomic_mutated$pivotal <- unname(atomic_mutated$pivotal)
expect_rejection(function() {
  pk_validate_replay_shape_node(atomic_mutated, payoff_table$schema_id,
                                payoff_table$path, registry, recursive = TRUE)
}, "COVERAGE", paste0("SHAPE_REGISTRY malformed yes/no payoff vector at ",
                       payoff_table$path, "/pivotal"),
   "named yes/no vector loses names")

# The independent raw walker, not the registry collector, selects each scalar
# mutation target.  The registry supplies only the already-pinned owner after
# the raw path has been chosen.
raw_leaf_by_path <- setNames(raw_shape$leaf_nodes,
                             vapply(raw_shape$leaf_nodes, `[[`, character(1), "path"))
leaf_schema_by_path <- setNames(shape$leaf_schema_ids, shape$leaf_paths)

# Every target below comes first from the independent raw walker.  Only after
# that selection do we attach its audited owner and immediate container.  This
# prevents the registry from choosing which leaves receive adversarial tests.
stopifnot(length(raw_leaf_by_path) == 35273L,
          !anyDuplicated(names(raw_leaf_by_path)),
          identical(names(raw_leaf_by_path), shape$leaf_paths),
          identical(names(raw_leaf_by_path), names(leaf_schema_by_path)))

leaf_targets <- lapply(seq_along(raw_shape$leaf_nodes), function(index) {
  raw_leaf <- raw_shape$leaf_nodes[[index]]
  path <- raw_leaf$path
  parent_path <- sub("/[^/]+$", "", path)
  label <- sub("^.*/", "", path)
  parent <- shape_by_path[[parent_path]]
  schema_id <- leaf_schema_by_path[[path]]
  stopifnot(is.list(parent), is.list(parent$value), nzchar(parent_path),
            is.character(schema_id), length(schema_id) == 1L)
  list(
    path = path,
    schema_id = schema_id,
    atomic_type = pk_shape_schema_spec(schema_id, registry)$atomic_type,
    spec = pk_shape_schema_spec(schema_id, registry),
    value = raw_leaf$value,
    parent_path = parent_path,
    parent_schema = parent$schema_id,
    parent_value = parent$value,
    label = label
  )
})
stopifnot(length(leaf_targets) == 35273L,
          length(unique(vapply(leaf_targets, `[[`, character(1), "schema_id"))) == 217L)
clean_numeral_values <- vapply(Filter(
  function(target) identical(target$spec$edge, "K:number/value"), leaf_targets),
  `[[`, character(1), "value")
clean_numeral_counts <- table(factor(clean_numeral_values,
                                     levels = c("0", "1", "2", "3")))
stopifnot(identical(sort(unique(clean_numeral_values)), c("0", "1", "2", "3")),
          identical(as.integer(clean_numeral_counts), c(404L, 1136L, 241L, 1L)))
message("CANONICAL_NUMERAL_BASELINE_INVENTORY 1782/1782 [0,1,2,3]")

replace_parent_leaf <- function(target, mutated) {
  parent <- target$parent_value
  if (is.null(names(parent))) {
    index <- suppressWarnings(as.integer(target$label))
    stopifnot(!is.na(index), index >= 1L, index <= length(parent))
    parent[[index]] <- mutated
  } else {
    stopifnot(target$label %in% names(parent))
    parent[[target$label]] <- mutated
  }
  parent
}

structural_leaf_expectation <- function(target) {
  if (identical(target$atomic_type, "source_steps")) {
    return(list(code = "COVERAGE",
                message = paste("SHAPE_REGISTRY source-step vector changed at",
                                target$path)))
  }
  if (startsWith(target$atomic_type, "weak_payoff_")) {
    return(list(code = "COVERAGE",
                message = paste("SHAPE_REGISTRY malformed yes/no payoff vector at",
                                target$path)))
  }
  list(code = "COVERAGE",
       message = paste("SHAPE_REGISTRY malformed typed leaf at", target$path))
}

wrong_typeof <- function(value) {
  out <- switch(typeof(value),
    character = rep.int(TRUE, length(value)),
    logical = rep.int("TRUE", length(value)),
    integer = rep.int("1", length(value)),
    double = rep.int("1", length(value)),
    stop(paste("unowned raw leaf typeof", typeof(value)))
  )
  attributes(out) <- attributes(value)
  stopifnot(!identical(typeof(out), typeof(value)), length(out) == length(value),
            identical(names(out), names(value)),
            identical(names(attributes(out)), names(attributes(value))))
  out
}

wrong_length <- function(value) {
  out <- if (length(value) == 1L) c(value, value) else value[-length(value)]
  stopifnot(!identical(length(out), length(value)), identical(typeof(out), typeof(value)))
  out
}

wrong_names <- function(value) {
  out <- value
  names(out) <- paste0("forged_", seq_along(out))
  stopifnot(identical(typeof(out), typeof(value)), length(out) == length(value),
            !identical(names(out), names(value)))
  out
}

wrong_attributes <- function(value) {
  out <- value
  attr(out, "forged") <- TRUE
  stopifnot(identical(typeof(out), typeof(value)), length(out) == length(value),
            identical(names(out), names(value)),
            "forged" %in% names(attributes(out)))
  out
}

wrong_na_or_inf <- function(value) {
  out <- value
  out[[1L]] <- switch(typeof(value),
    character = NA_character_, logical = NA, integer = NA_integer_, double = Inf,
    stop(paste("unowned raw leaf typeof", typeof(value)))
  )
  stopifnot(identical(typeof(out), typeof(value)), length(out) == length(value),
            identical(names(out), names(value)),
            identical(names(attributes(out)), names(attributes(value))),
            anyNA(out) || (is.double(out) && any(!is.finite(out))))
  out
}

structural_mutators <- list(
  wrong_typeof = wrong_typeof,
  wrong_length = wrong_length,
  wrong_names = wrong_names,
  wrong_attributes = wrong_attributes,
  wrong_na_or_inf = wrong_na_or_inf
)
structural_counts <- setNames(integer(length(structural_mutators)),
                              names(structural_mutators))
structural_roles <- c(malformed_typed_leaf = 0L, source_steps = 0L,
                      payoff_vectors = 0L)
for (target in leaf_targets) {
  if (identical(target$atomic_type, "source_steps")) {
    structural_roles[["source_steps"]] <- structural_roles[["source_steps"]] + 1L
  } else if (startsWith(target$atomic_type, "weak_payoff_")) {
    structural_roles[["payoff_vectors"]] <- structural_roles[["payoff_vectors"]] + 1L
  } else {
    structural_roles[["malformed_typed_leaf"]] <-
      structural_roles[["malformed_typed_leaf"]] + 1L
  }
  expected <- structural_leaf_expectation(target)
  for (mutation_id in names(structural_mutators)) {
    mutated <- structural_mutators[[mutation_id]](target$value)
    mutated_parent <- replace_parent_leaf(target, mutated)
    expect_rejection(function() {
      pk_validate_shape_leaf(mutated, target$schema_id, target$path,
                             target$parent_schema, mutated_parent,
                             collector = NULL)
    }, expected$code, expected$message,
       paste(mutation_id, "at", target$path))
    structural_counts[[mutation_id]] <- structural_counts[[mutation_id]] + 1L
  }
}
stopifnot(identical(unname(structural_counts), rep.int(35273L, 5L)),
          identical(unname(structural_roles), c(35190L, 80L, 3L)))
for (mutation_id in names(structural_counts)) {
  message("ATOMIC_LEAF_", toupper(mutation_id), " ",
          structural_counts[[mutation_id]], "/35273")
}
message("ATOMIC_LEAF_STRUCTURAL_ROLES malformed_typed_leaf=35190 ",
        "source_steps=80 payoff_vectors=3")
message("ATOMIC_LEAF_NONFINITE_APPLICABLE 0; TYPED_NA_APPLICABLE 35273")

adjacent_context_mutation <- function(target) {
  value <- target$value
  rule <- target$spec$semantic_rule
  edge <- target$spec$edge
  if (identical(rule, "BINDER_SOURCE_SORT")) {
    mutated <- if (identical(target$label, "variable_sort")) {
      if (identical(value, "Player")) "FiniteSet<Player>" else "Player"
    } else if (identical(value, "i")) "K" else "i"
    return(list(value = mutated, code = "TYPE",
                message = paste("AST_TYPECHECK binder source-sort mismatch at",
                                target$path)))
  }
  if (identical(rule, "INTERVAL_ENDPOINT_OWNERSHIP")) {
    return(list(value = !value, code = "BINDING",
                message = paste("SHAPE_REGISTRY interval endpoint ownership changed at",
                                target$path)))
  }
  if (identical(rule, "FRONTIER_DOMAIN")) {
    mutated <- if (identical(value, "o_0<o_1<1/m")) "o_0<1/m" else "o_0<o_1<1/m"
    return(list(value = mutated, code = "BINDING",
                message = paste("SHAPE_REGISTRY frontier pair/domain mismatch at",
                                target$path)))
  }
  if (identical(rule, "TYPE_PROBABILITY_ENDPOINT")) {
    mutated <- if (identical(value, "0")) "1" else "0"
    return(list(value = mutated, code = "TYPE",
                message = paste("SHAPE_REGISTRY endpoint likelihood vector changed at",
                                target$path)))
  }
  if (identical(rule, "FREE_BELIEF_NAME")) {
    mutated <- if (identical(value, "kappa_i(s)")) "eta_i(s,v)" else "kappa_i(s)"
    return(list(value = mutated, code = "BINDING",
                message = paste("SHAPE_REGISTRY free belief name/domain mismatch at",
                                target$path)))
  }
  if (identical(rule, "FREE_BELIEF_DOMAIN")) {
    alternatives <- c("individual proposal has zero strategy mass",
                      "proposal-vote history has zero probability")
    mutated <- alternatives[alternatives != value][[1L]]
    return(list(value = mutated, code = "BINDING",
                message = paste("SHAPE_REGISTRY free belief name/domain mismatch at",
                                target$path)))
  }
  if (identical(rule, "LOCAL_DEFINITION") && identical(edge, "O:local_W/W")) {
    alternatives <- c("weak-player set local to the identity simplex",
                      "weak-player set local to the labeled aggregation record")
    mutated <- alternatives[alternatives != value][[1L]]
    return(list(value = mutated, code = "BINDING",
                message = paste("SHAPE_REGISTRY local-W path/value mismatch at",
                                target$path)))
  }
  if (!is.null(target$spec$allowed_values)) {
    allowed <- target$spec$allowed_values
    mutated <- switch(typeof(value),
      character = "__FORGED_DOMAIN__",
      logical = !value,
      integer = {
        candidate <- value + 1L
        while (any(vapply(allowed, function(item) identical(candidate, item), logical(1)))) {
          candidate <- candidate + 1L
        }
        candidate
      },
      double = {
        candidate <- value + 1
        while (any(vapply(allowed, function(item) identical(candidate, item), logical(1)))) {
          candidate <- candidate + 1
        }
        candidate
      }, stop(paste("unowned context scalar typeof", typeof(value))))
    stopifnot(!any(vapply(allowed, function(item) identical(mutated, item), logical(1))))
    return(list(value = mutated, code = "COVERAGE",
                message = paste("SHAPE_REGISTRY closed leaf domain changed at",
                                target$path)))
  }
  stopifnot(is.character(value), !is.null(target$spec$pattern))
  if (identical(target$spec$pattern, "^.+$")) {
    return(list(value = "", code = "COVERAGE",
                message = paste("SHAPE_REGISTRY malformed typed leaf at", target$path)))
  }
  list(value = "!", code = "COVERAGE",
       message = paste("SHAPE_REGISTRY leaf grammar changed at", target$path))
}

adjacent_leaf_mutation <- function(target) {
  path_message <- function(stem) paste(stem, "at", target$path)
  if (identical(target$atomic_type, "context_scalar")) {
    return(adjacent_context_mutation(target))
  }
  value <- target$value
  leaf <- target$atomic_type
  result <- switch(leaf,
    interval_endpoint = list(value = "2", code = "COVERAGE",
      message = path_message("SHAPE_REGISTRY interval endpoint grammar changed")),
    weak_payoff_pivotal = { out <- value; out[[1L]] <- "x_j_forged"; list(
      value = out, code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY pivotal payoff vector changed")) },
    weak_payoff_pass_anyway = { out <- value; out[[1L]] <- "x_j_forged"; list(
      value = out, code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY passing payoff vector changed")) },
    weak_payoff_fail_anyway = { out <- value; out[[1L]] <- "rat(forged)"; list(
      value = out, code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY failure payoff vector changed")) },
    source_steps = { out <- value; out[[1L]] <- "S29"; list(
      value = out, code = "COVERAGE",
      message = path_message("SHAPE_REGISTRY source-step vector changed")) },
    step_id = list(value = "S00", code = "BINDING",
      message = path_message("SHAPE_REGISTRY premise step id changed")),
    indexed_index = list(value = "b0", code = "TYPE",
      message = path_message("AST_TYPECHECK indexed-symbol index changed")),
    inequality_chain_atom = list(value = paste0(value, "__forged"), code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY inequality chain changed")),
    frontier_pair_atom = list(value = "R", code = "BINDING",
      message = path_message("SHAPE_REGISTRY frontier pair changed")),
    proposer_k_partition_atom = list(value = paste0(value, "__forged"), code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY proposer k partition changed")),
    proposer_y_partition_atom = list(value = paste0(value, "__forged"), code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY proposer y partition changed")),
    slack_domain_atom = list(value = paste0(value, "__forged"), code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY slack domain changed")),
    ballot_coordinate_atom = list(value = paste0(value, "__forged"), code = "BINDING",
      message = path_message("SHAPE_REGISTRY ballot coordinates changed")),
    H_trichotomy_atom = list(value = paste0(value, "__forged"), code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY H trichotomy changed")),
    closure_source_step = list(value = "S22", code = "BINDING",
      message = path_message("SHAPE_REGISTRY closure source-step set changed")),
    free_symbol_identifier = list(value = "ZZ", code = "TYPE",
      message = path_message("AST_TYPECHECK symbol identifier set changed")),
    primitive_symbol_identifier = list(value = "ZZ", code = "TYPE",
      message = path_message("AST_TYPECHECK symbol identifier set changed")),
    dominance_atom = list(value = "forged", code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY dominance atom changed")),
    factor_atom = list(value = "forged", code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY sign factor changed")),
    support_derivation_atom = list(value = paste0(value, "__forged"), code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY support derivation changed")),
    sha256_atom = list(value = strrep("g", 64L), code = "BINDING",
      message = path_message("SHAPE_REGISTRY SHA-256 atom changed")),
    selected_branch_atom = list(value = "R", code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY selected branch changed")),
    sign_atom = list(value = "forged", code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY comparison sign atom changed")),
    region_tie_relation = list(value = "forged", code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY tie relation changed")),
    domain_sources_SE = list(value = "forged", code = "EQUIVALENCE",
      message = path_message("SHAPE_REGISTRY S=E domain source changed")),
    stop(paste("unowned adjacent raw leaf validator", leaf, target$path))
  )
  result
}

adjacent_counts <- c(COVERAGE = 0L, TYPE = 0L, BINDING = 0L, EQUIVALENCE = 0L)
for (target in leaf_targets) {
  mutation <- adjacent_leaf_mutation(target)
  mutated <- mutation$value
  stopifnot(identical(typeof(mutated), typeof(target$value)),
            length(mutated) == length(target$value),
            identical(names(mutated), names(target$value)),
            identical(names(attributes(mutated)), names(attributes(target$value))))
  mutated_parent <- replace_parent_leaf(target, mutated)
  expect_rejection(function() {
    pk_validate_shape_leaf(mutated, target$schema_id, target$path,
                           target$parent_schema, mutated_parent, collector = NULL)
  }, mutation$code, mutation$message,
     paste("adjacent domain/literal at", target$path))
  adjacent_counts[[mutation$code]] <- adjacent_counts[[mutation$code]] + 1L
}
stopifnot(identical(unname(adjacent_counts), c(32499L, 1681L, 778L, 315L)),
          sum(adjacent_counts) == 35273L,
          sum(structural_counts) + sum(adjacent_counts) == 211638L)
message("ATOMIC_LEAF_ADJACENT 35273/35273 COVERAGE=32499 TYPE=1681 ",
        "BINDING=778 EQUIVALENCE=315")
message("ATOMIC_LEAF_GENERATED_NEGATIVES 211638/211638")

# Indexed symbols have an ordered, distinct (Player, FiniteSet<Player>) pair;
# binder sources have exact sorts and cannot shadow an active proposer binder.
indexed_node <- find_node(function(node) identical(node$schema_id, "K:indexed_symbol"),
                          "indexed symbol")
indexed_reordered <- indexed_node$value
indexed_reordered$indices <- rev(indexed_reordered$indices)
expect_rejection(function() {
  pk_assert_typed_ast_independent(indexed_reordered, indexed_node$ast_scope,
                                  indexed_node$path)
}, "TYPE", paste("AST_TYPECHECK indexed symbol scope at", indexed_node$path),
   "indexed symbol reverses proposer and coalition indices")
indexed_duplicate <- indexed_node$value
indexed_duplicate$indices[[2L]] <- indexed_duplicate$indices[[1L]]
expect_rejection(function() {
  pk_assert_typed_ast_independent(indexed_duplicate, indexed_node$ast_scope,
                                  indexed_node$path)
}, "TYPE", paste("AST_TYPECHECK indexed symbol scope at", indexed_node$path),
   "indexed symbol duplicates its proposer index")
proposer_binder <- find_node(function(node) {
  identical(node$schema_id, "K:binder") &&
    grepl("/proposer_binder$", node$path)
}, "proposer binder")
source_sort_mutated <- proposer_binder$value
source_sort_mutated$source_variable <- "K"
expect_rejection(function() {
  pk_assert_typed_ast_independent(source_sort_mutated, proposer_binder$ast_scope,
                                  proposer_binder$path)
}, "TYPE", paste("AST_TYPECHECK binder declaration at", proposer_binder$path),
   "Player binder claims a finite-set source")
coalition_binder <- find_node(function(node) {
  identical(node$schema_id, "K:binder") &&
    node$value$source_variable %in% c("K", "T") && "b1" %in% names(node$ast_scope)
}, "nested coalition binder")
shadow_mutated <- coalition_binder$value
shadow_mutated$variable <- "b1"
expect_rejection(function() {
  pk_assert_typed_ast_independent(shadow_mutated, coalition_binder$ast_scope,
                                  coalition_binder$path)
}, "TYPE", paste("AST_TYPECHECK binder declaration at", coalition_binder$path),
   "coalition binder shadows the proposer")
message("INDEXED_SYMBOL_TYPE_NEGATIVES 4/4")

# The quota oracle is a separate literal parity derivation.  A forged lower
# bound is rejected by full-object comparison, without invoking the producer.
quota_999 <- baseline$values$S07
quota_999$bounds$q_lower <- 999L
expect_rejection(function() pk_assert_quota(quota_999, primitives, sorts),
                 "CERTIFICATE", "quota proof object differs from exact parity replay",
                 "quota lower bound is forged as 999")
message("INDEPENDENT_QUOTA_ORACLE_NEGATIVE_OK")

# Recursive typing catches sort spoofing, unknown operators, and a deeply
# nested extra member before algebraic conversion.
binary_root <- find_node(function(node) {
  identical(node$schema_id, "K:binary") && !isTRUE(node$inside_ast)
}, "maximal binary AST")
sort_mutated <- binary_root$value
sort_mutated$sort <- if (identical(sort_mutated$sort, "Payoff")) "Probability" else "Payoff"
expect_rejection(function() {
  pk_validate_replay_shape_node(sort_mutated, binary_root$schema_id,
                                binary_root$path, registry, recursive = TRUE,
                                ast_scope = binary_root$ast_scope)
}, "TYPE", paste("AST_TYPECHECK binary result sort at", binary_root$path,
                  sort_mutated$sort, "!=", binary_root$value$sort),
   "binary AST result sort is spoofed")

operator_mutated <- binary_root$value
operator_mutated$operator <- "%%"
expect_rejection(function() {
  pk_validate_replay_shape_node(operator_mutated, binary_root$schema_id,
                                binary_root$path, registry, recursive = TRUE,
                                ast_scope = binary_root$ast_scope)
}, "TYPE", paste("AST_TYPECHECK unknown binary operator at", binary_root$path, "%%"),
   "binary AST operator is unknown")

nested_mutated <- binary_root$value
cursor <- nested_mutated
if (is.list(cursor$left)) cursor$left$ghost <- TRUE else cursor$ghost <- TRUE
nested_mutated <- cursor
expect_rejection(function() {
  pk_validate_replay_shape_node(nested_mutated, binary_root$schema_id,
                                binary_root$path, registry, recursive = TRUE,
                                ast_scope = binary_root$ast_scope)
}, "TYPE", paste0("AST_TYPECHECK exact keys changed at ", binary_root$path, "/left"),
   "nested AST gains a ghost member")

# Every root is checked as post-dispatch output, independently of which rule
# constructed it.
root_rejections <- 0L
for (step_id in names(baseline$values)) {
  mutated_values <- baseline$values
  mutated_values[[step_id]][["unexpected_shape"]] <- TRUE
  expect_rejection(function() pk_assert_closed_replay_shapes(mutated_values),
                   "COVERAGE", paste("SHAPE_REGISTRY object keys changed at",
                                     paste0("/", step_id)),
                   paste("post-dispatch root", step_id))
  root_rejections <- root_rejections + 1L
}
stopifnot(root_rejections == 29L)
message("REJECTED_POST_DISPATCH_ROOTS 29/29")

# Fixture-only kinds are literal and remain subject to exact keys/arity.
fixture_extra <- list(
  kind = "call", sort = "Integer", name = "floor",
  arguments = list(list(kind = "number", sort = "Rational", value = "1")),
  unexpected_shape = TRUE
)
expect_rejection(function() {
  pk_validate_replay_shape_node(fixture_extra, "AST", "/fixture/call_extra",
                                registry, recursive = TRUE)
}, "TYPE", "AST_TYPECHECK exact keys changed at /fixture/call_extra",
   "fixture-only call gains an extra field")

message("SHAPE_REGISTRY_ADVERSARIAL_TESTS_OK")

registry_mutated <- registry
registry_mutated$expected_node_count <- registry_mutated$expected_node_count + 1L
expect_rejection(function() pk_replay_shape_registry_lint(registry_mutated),
                 "PACKAGE_INTEGRITY", "SHAPE_REGISTRY literal bytes changed",
                 "literal registry hash pin changes")
message("SHAPE_REGISTRY_HASH_PIN_NEGATIVE_OK")

# The post-S29 certification layer has independent literal denominators.  These
# mutations target the loaded registries and replay-owned results, not the
# producer that assembled the clean objects.
claim_registry_41 <- pk_claim_obligation_registry_v1()
claim_registry_41[[17L]]$obligations <-
  claim_registry_41[[17L]]$obligations[-2L]
expect_rejection(function() pk_claim_obligation_registry_lint(claim_registry_41),
                 "COVERAGE",
                 "POST_S29 claim registry must contain 42 unique obligations",
                 "independent claim registry contains only 41 obligations")

expect_rejection(function() pk_ledger_formal_span_registry_lint(list()),
                 "COVERAGE",
                 "POST_S29 ledger span registry must contain 11 spans",
                 "formal span registry is emptied")

invalid_nu_witness <- baseline$values$S29$witnesses[[1L]]$domain_witness
invalid_nu_witness$nu <- "999"
expect_rejection(function() {
  pk_assert_nonvacuity_witness_independent(
    baseline$values$S21$regions[[1L]], invalid_nu_witness,
    pk_s29_nonvacuity_registry_v1()[[1L]], "W01")
}, "CERTIFICATE", "POST_S29 W01 assignment differs from the pinned witness",
   "domain witness changes nu to 999")

forged_registry <- baseline$claim_registry
forged_registry$forged_extra <- TRUE
expect_rejection(function() {
  pk_assert_claim_registry_postload(
    forged_registry, pk_expected_core(primitives, sorts, n1), sorts)
}, "COVERAGE", "POST_S29 loaded claim registry root is open or incomplete",
   "loaded claim registry gains a forged field")

forged_certificate <- baseline$certificates
forged_certificate[[1L]]$source_binding$forged_extra <- TRUE
expect_rejection(function() {
  pk_assert_certificates_postload(
    forged_certificate, pk_claim_obligation_registry_v1(), baseline$values,
    baseline$claim_registry)
}, "COVERAGE", "POST_S29 certificate source binding is open or incomplete",
   "certificate source binding gains a forged field")

message("POST_S29_DIRECT_NEGATIVES 5/5")

# Representative full replays run in fresh R processes.  Each child injects
# exactly one mutation at the production post-dispatch gate, after deriving all
# values from primitives and frozen N1.  The switch is literal; no parsed code,
# serialized baseline, or registry-derived mutation is executed.
fresh_case <- function(code, message) list(code = code, message = message)
fresh_cases <- list(
  indexed_symbol_order_spoof = fresh_case(
    "CERTIFICATE", "simplex support family or indexed sum changed"),
  quota_lower_bound_spoof = fresh_case(
    "CERTIFICATE", "quota proof object differs from exact parity replay"),
  claim_obligation_41 = fresh_case(
    "COVERAGE", "POST_S29 claim registry must contain 42 unique obligations"),
  zero_span_registry = fresh_case(
    "COVERAGE", "POST_S29 ledger span registry must contain 11 spans"),
  nonvacuity_nu_999 = fresh_case(
    "CERTIFICATE", "POST_S29 witness 1 assignment differs from the pinned witness"),
  loaded_registry_extra = fresh_case(
    "COVERAGE", "POST_S29 loaded claim registry root is open or incomplete"),
  certificate_binding_extra = fresh_case(
    "COVERAGE", "POST_S29 certificate source binding is open or incomplete"),
  certificate_hash_forge = fresh_case(
    "CERTIFICATE", "POST_S29 full certificate hash changed at 1"),
  early_formula_extra = fresh_case(
    "COVERAGE", "SHAPE_REGISTRY object keys changed at /S01"),
  belief_record_extra = fresh_case(
    "COVERAGE", "SHAPE_REGISTRY object keys changed at /S25/per_region/1"),
  simplex_empty_container_swap = fresh_case(
    "COVERAGE",
    "SHAPE_REGISTRY array shape changed at /S26/identity_symmetry_constraints"),
  indexed_formula_variant_swap = fresh_case(
    "COVERAGE",
    "SHAPE_REGISTRY object keys changed at /S27/per_region/1/weak_identity_map"),
  closure_local_definition_swap = fresh_case(
    "COVERAGE",
    "SHAPE_REGISTRY array shape changed at /S28/records/1/local_definitions"),
  pbe_known_kind_swap = fresh_case(
    "COVERAGE",
    paste0("SHAPE_REGISTRY expected kind separating_H_vote at ",
           "/S29/witnesses/1/beliefs/after_public_vote_vector")),
  rational_class_spoof = fresh_case(
    "COVERAGE", "SHAPE_REGISTRY malformed ea_rat at /S01/rational"),
  ast_result_sort_spoof = fresh_case(
    "TYPE", "AST_TYPECHECK binary result sort at /S01/ast Payoff != Real"),
  canonical_number_leading_zero = fresh_case(
    "TYPE", "AST_TYPECHECK malformed number at /S01/ast/left"),
  canonical_number_unary_plus = fresh_case(
    "TYPE", "AST_TYPECHECK malformed number at /S01/ast/left"),
  canonical_number_trailing_decimal = fresh_case(
    "TYPE", "AST_TYPECHECK malformed number at /S01/ast/left"),
  canonical_number_double_zero = fresh_case(
    "TYPE", "AST_TYPECHECK malformed number at /S01/ast/left"),
  canonical_number_negative_zero = fresh_case(
    "TYPE", "AST_TYPECHECK malformed number at /S01/ast/left")
)
source_lines <- c(
  "source('scripts/lib_essential_input_semantic_ast_v1.R')",
  "source('scripts/lib_essential_input_exact_algebra_v1.R')",
  "source('scripts/lib_essential_input_schema_roles_v1.R')",
  "source('scripts/lib_essential_input_n3_game_kernel_v1.R')",
  "source('scripts/lib_essential_input_proof_kernel_v1.R')"
)
fresh_bad_numeral_helper <- paste0(
  "coherent_bad_numeral_for_fresh<-function(value,literal){",
  "value$ast$left$value<-literal;",
  "coefficient<-suppressWarnings(gmp::as.bigq(literal));",
  "value$rational$numerator<-structure(setNames(list(coefficient),'1'),",
  "class='ea_poly');",
  "value$normal_form<-paste0('rat(',as.character(coefficient),",
  "'@1)/(1@m^1)');value}"
)
mutation_switch <- paste0(c(
  "switch(mutation_case,",
  paste0(" indexed_symbol_order_spoof={original<-pk_indexed_weight;",
         "pk_indexed_weight<-function(family,proposer,coalition){",
         "x<-original(family,proposer,coalition);x$indices<-rev(x$indices);x}},"),
  paste0(" quota_lower_bound_spoof={original<-pk_quota_from_primitives;",
         "pk_quota_from_primitives<-function(primitives,sorts){",
         "x<-original(primitives,sorts);x$bounds$q_lower<-999L;x}},"),
  paste0(" claim_obligation_41={original<-pk_claim_obligation_registry_v1;",
         "pk_claim_obligation_registry_v1<-function(){x<-original();",
         "x[[17L]]$obligations<-x[[17L]]$obligations[-2L];x}},"),
  " zero_span_registry={pk_ledger_formal_span_registry_v1<-function()list()},",
  paste0(" nonvacuity_nu_999={original<-pk_region_domain_witness;",
         "pk_region_domain_witness<-function(region){x<-original(region);",
         "x$nu<-'999';x}},"),
  paste0(" loaded_registry_extra={original<-pk_load_claim_registry;",
         "pk_load_claim_registry<-function(core,sorts,path=",
         "'model_redesign/essential_input_n3_claim_ledger_v5.json'){",
         "x<-original(core,sorts,path);x$forged_extra<-TRUE;x}},"),
  paste0(" certificate_binding_extra={original<-pk_certificate_source_binding;",
         "pk_certificate_source_binding<-function(source){x<-original(source);",
         "x$forged_extra<-TRUE;x}},"),
  paste0(" certificate_hash_forge={original<-pk_assert_certificates_postload;",
         "pk_assert_certificates_postload<-function(certificates,specification,",
         "values,claim_registry){certificates[[1L]]$certificate_hash<-",
         "paste(rep('0',64L),collapse='');original(certificates,specification,",
         "values,claim_registry)}},"),
  paste0(" early_formula_extra={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "values$S01$unexpected_shape<-TRUE;",
         "original(values,collect_nodes=collect_nodes)}},"),
  paste0(" belief_record_extra={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "values$S25$per_region[[1L]]$unexpected_shape<-TRUE;",
         "original(values,collect_nodes=collect_nodes)}},"),
  paste0(" simplex_empty_container_swap={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "values$S26$identity_symmetry_constraints<-list(unexpected_shape=TRUE);",
         "original(values,collect_nodes=collect_nodes)}},"),
  paste0(" indexed_formula_variant_swap={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "values$S27$per_region[[1L]]$weak_identity_map$domain<-",
         "'unexpected_domain';original(values,collect_nodes=collect_nodes)}},"),
  paste0(" closure_local_definition_swap={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "i<-which(vapply(values$S28$records,function(x)",
         "length(x$local_definitions)==0L,logical(1)))[[1L]];",
         "values$S28$records[[i]]$local_definitions<-list(W='Set<Player>');",
         "original(values,collect_nodes=collect_nodes)}},"),
  paste0(" pbe_known_kind_swap={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "i<-which(vapply(values$S29$witnesses,function(x)",
         "identical(x$beliefs$branch,'S'),logical(1)))[[1L]];",
         "values$S29$witnesses[[i]]$beliefs$after_public_vote_vector$kind<-",
         "'nonseparating_H_vote';original(values,collect_nodes=collect_nodes)}},"),
  paste0(" rational_class_spoof={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "values$S01$rational<-unclass(values$S01$rational);",
         "original(values,collect_nodes=collect_nodes)}},"),
  paste0(" ast_result_sort_spoof={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "values$S01$ast$sort<-'Payoff';",
         "original(values,collect_nodes=collect_nodes)}},"),
  paste0(" canonical_number_leading_zero={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "values$S01<-coherent_bad_numeral_for_fresh(values$S01,'01');",
         "original(values,collect_nodes=collect_nodes)}},"),
  paste0(" canonical_number_unary_plus={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "values$S01<-coherent_bad_numeral_for_fresh(values$S01,'+1');",
         "original(values,collect_nodes=collect_nodes)}},"),
  paste0(" canonical_number_trailing_decimal={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "values$S01<-coherent_bad_numeral_for_fresh(values$S01,'1.');",
         "original(values,collect_nodes=collect_nodes)}},"),
  paste0(" canonical_number_double_zero={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "values$S01<-coherent_bad_numeral_for_fresh(values$S01,'00');",
         "original(values,collect_nodes=collect_nodes)}},"),
  paste0(" canonical_number_negative_zero={original<-pk_assert_closed_replay_shapes;",
         "pk_assert_closed_replay_shapes<-function(values,collect_nodes=FALSE){",
         "values$S01<-coherent_bad_numeral_for_fresh(values$S01,'-0');",
         "original(values,collect_nodes=collect_nodes)}})" )
), collapse = "")
for (case_name in names(fresh_cases)) {
  expected <- fresh_cases[[case_name]]
  child_code <- paste(c(
    source_lines,
    fresh_bad_numeral_helper,
    sprintf("mutation_case<-%s", deparse(case_name)),
    mutation_switch,
    sprintf("expected_text<-%s", deparse(paste0(
      "FAIL_", expected$code, ": ", expected$message))),
    "primitives<-n3g_primitives()",
    paste0("n1<-n3g_import_n1('model_redesign/essential_input_interfaces/",
           "n1_r2_majority_candidate_v1.json')"),
    paste0("message_text<-tryCatch({pk_replay_proofs(n3g_generate_proofs(),",
           "primitives,n1,n3_claim_spec_v1());NA_character_},",
           "error=function(error)conditionMessage(error))"),
    paste0("if(is.na(message_text)||!identical(message_text,expected_text))",
           "stop(paste('unexpected fresh-process result',message_text))"),
    sprintf("cat('FRESH_PROCESS_REJECTED %s',message_text,'\\n')", case_name)
  ), collapse = ";")
  output <- system2(file.path(R.home("bin"), "Rscript"),
                    c("--vanilla", "-e", shQuote(child_code)),
                    stdout = TRUE, stderr = TRUE)
  status <- attr(output, "status")
  if (is.null(status)) status <- 0L
  if (status != 0L) {
    stop(paste("fresh-process shape case failed:", case_name,
               paste(output, collapse = "\n")))
  }
  result_line <- output[grepl("^FRESH_PROCESS_REJECTED ", output)]
  if (length(result_line) != 1L) {
    stop(paste("fresh-process result line missing:", case_name,
               paste(output, collapse = "\n")))
  }
  message(result_line)
}
message("N3_REPLAY_SHAPE_FRESH_PROCESS 21/21")
