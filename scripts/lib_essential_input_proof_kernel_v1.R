# Generic replay kernel for the N3 proof plan.  A step's claimed status or
# conclusion is never trusted: the dispatcher computes its conclusion from
# primitive context and already replayed references.

pk_canonical_json <- function(object) {
  jsonlite::toJSON(object, auto_unbox = TRUE, null = "null", digits = NA,
                   pretty = FALSE, force = TRUE)
}
pk_object_hash <- function(object) sc_sha256_text(pk_canonical_json(pk_public_value(object)))

# Independent numeral recognizer for the proof TCB.  It deliberately does not
# call the semantic lexer or consult the replay registry.  The accepted
# language is exactly zero or an unsigned base-10 integer without leading zero.
pk_is_canonical_numeral_independent <- function(value) {
  if (!is.character(value) || length(value) != 1L || is.na(value) || !nzchar(value)) {
    return(FALSE)
  }
  bytes <- utf8ToInt(value)
  if (identical(value, "0")) return(TRUE)
  length(bytes) >= 1L && bytes[[1L]] >= utf8ToInt("1") &&
    bytes[[1L]] <= utf8ToInt("9") &&
    (length(bytes) == 1L || all(bytes[-1L] >= utf8ToInt("0") &
                                  bytes[-1L] <= utf8ToInt("9")))
}

pk_num <- function(value) {
  value <- as.character(value)
  sc_assert(pk_is_canonical_numeral_independent(value), "FAIL_TYPE",
            "AST_TYPECHECK malformed number at /pk_num")
  sc_ast("number", value = value, sort = "Rational")
}
pk_sym <- function(name, sorts) sc_ast("symbol", name = name, sort = sorts[[name]])
pk_bin <- function(operator, left, right) sc_numeric_binary(operator, left, right)
pk_add <- function(a, b) pk_bin("+", a, b)
pk_sub <- function(a, b) pk_bin("-", a, b)
pk_mul <- function(a, b) pk_bin("*", a, b)
pk_div <- function(a, b) pk_bin("/", a, b)

# Independent structural/type replay for ASTs.  This checker never calls
# pk_bin() or sc_numeric_binary(); it recomputes the result sort from literal
# operator tables and recursively checked children.  It therefore detects a
# coordinated producer mutation that stamps an internally inconsistent sort.
pk_ast_symbol_sorts_v1 <- function() {
  as.list(c(
    N = "Integer", m = "Integer", q = "Integer", beta = "Probability",
    nu = "Probability", o_0 = "Payoff", o_1 = "Payoff", o_theta = "Payoff",
    y_bar = "Payoff", y = "Payoff", x_j = "Payoff", r_i = "Payoff",
    theta = "Type", C_l = "Payoff", X = "Payoff", rho = "Probability",
    t = "Integer", lambda_s = "Probability", l = "Player"
  ))
}

pk_ast_exact_keys <- function(ast, keys, path) {
  sc_assert(is.list(ast) && !is.null(names(ast)) && !anyNA(names(ast)) &&
              !anyDuplicated(names(ast)) && identical(names(ast), keys),
            "FAIL_TYPE", paste("AST_TYPECHECK exact keys changed at", path))
  invisible(TRUE)
}

pk_ast_numeric_dimension_independent <- function(sort, path) {
  sc_assert(sort %in% c("Integer", "Rational", "Real", "Probability",
                        "Payoff", "PayoffShare"),
            "FAIL_TYPE", paste("AST_TYPECHECK nonnumeric sort at", path, sort))
  if (sort %in% c("Integer", "Rational", "Real")) "Scalar" else sort
}

pk_ast_integer_expression_independent <- function(ast) {
  kind <- ast[["kind", exact = TRUE]]
  if (identical(kind, "number")) {
    return(identical(ast[["sort", exact = TRUE]], "Rational") &&
             grepl("^[+-]?[0-9]+$", ast[["value", exact = TRUE]]))
  }
  if (kind %in% c("symbol", "bound_symbol")) {
    return(identical(ast[["sort", exact = TRUE]], "Integer"))
  }
  if (identical(kind, "call")) {
    return(identical(ast[["name", exact = TRUE]], "floor"))
  }
  if (identical(kind, "unary")) {
    return(pk_ast_integer_expression_independent(ast[["argument", exact = TRUE]]))
  }
  if (identical(kind, "binary") &&
      ast[["operator", exact = TRUE]] %in% c("+", "-", "*")) {
    return(pk_ast_integer_expression_independent(ast[["left", exact = TRUE]]) &&
             pk_ast_integer_expression_independent(ast[["right", exact = TRUE]]))
  }
  FALSE
}

pk_ast_cardinality_expression_independent <- function(ast) {
  pk_ast_integer_expression_independent(ast)
}

pk_ast_unit_share_expression_independent <- function(ast) {
  is.list(ast) && identical(ast[["kind", exact = TRUE]], "binary") &&
    identical(ast[["operator", exact = TRUE]], "/") &&
    is.list(ast[["left", exact = TRUE]]) &&
    identical(ast[["left", exact = TRUE]][["kind", exact = TRUE]], "number") &&
    identical(ast[["left", exact = TRUE]][["value", exact = TRUE]], "1") &&
    pk_ast_cardinality_expression_independent(ast[["right", exact = TRUE]])
}

pk_ast_binary_sort_independent <- function(operator, left, right, path) {
  left_sort <- left$sort; right_sort <- right$sort
  left_dimension <- pk_ast_numeric_dimension_independent(left_sort, path)
  right_dimension <- pk_ast_numeric_dimension_independent(right_sort, path)
  amount <- function(x) x %in% c("Payoff", "PayoffShare")
  if (operator %in% c("+", "-")) {
    sc_assert(!((identical(left_dimension, "Probability") && amount(right_dimension)) ||
                  (identical(right_dimension, "Probability") && amount(left_dimension))),
              "FAIL_TYPE", paste("AST_TYPECHECK incompatible additive dimensions at", path))
    dimension <- if ("Payoff" %in% c(left_dimension, right_dimension)) "Payoff" else
      if ("PayoffShare" %in% c(left_dimension, right_dimension)) "PayoffShare" else
        if ("Probability" %in% c(left_dimension, right_dimension)) "Probability" else
          "Scalar"
  } else if (identical(operator, "*")) {
    sc_assert(!(amount(left_dimension) && amount(right_dimension)),
              "FAIL_TYPE", paste("AST_TYPECHECK multiplied payoff dimensions at", path))
    discounted_unit_share <-
      (identical(left_dimension, "Probability") &&
         identical(right_dimension, "Scalar") &&
         pk_ast_unit_share_expression_independent(right$ast)) ||
      (identical(right_dimension, "Probability") &&
         identical(left_dimension, "Scalar") &&
         pk_ast_unit_share_expression_independent(left$ast))
    dimension <- if (discounted_unit_share) "PayoffShare" else
      if ("Payoff" %in% c(left_dimension, right_dimension)) "Payoff" else
      if ("PayoffShare" %in% c(left_dimension, right_dimension)) "PayoffShare" else
        if ("Probability" %in% c(left_dimension, right_dimension)) "Probability" else
          "Scalar"
  } else if (identical(operator, "/")) {
    sc_assert(!amount(right_dimension), "FAIL_TYPE",
              paste("AST_TYPECHECK payoff denominator at", path))
    dimension <- if (identical(left_dimension, "Payoff")) "Payoff" else
      if (identical(left_dimension, "PayoffShare")) "PayoffShare" else
        if (identical(left_dimension, "Probability") &&
            pk_ast_cardinality_expression_independent(right$ast)) "PayoffShare" else
          if (identical(left_dimension, "Probability")) "Probability" else "Scalar"
  } else if (identical(operator, "^")) {
    sc_assert(pk_ast_integer_expression_independent(right$ast) &&
                identical(right$ast[["kind", exact = TRUE]], "number") &&
                grepl("^[0-9]+$", right$ast[["value", exact = TRUE]]),
              "FAIL_TYPE", paste("AST_TYPECHECK nonliteral exponent at", path))
    if (amount(left_dimension)) {
      sc_assert(right$ast[["value", exact = TRUE]] %in% c("0", "1"),
                "FAIL_TYPE", paste("AST_TYPECHECK payoff power at", path))
      dimension <- if (identical(right$ast[["value", exact = TRUE]], "0"))
        "Scalar" else left_dimension
    } else dimension <- left_dimension
  } else {
    sc_abort("FAIL_TYPE", paste("AST_TYPECHECK unknown binary operator at", path, operator))
  }
  if (identical(dimension, "Scalar")) {
    if (operator %in% c("+", "-", "*") &&
        pk_ast_integer_expression_independent(left$ast) &&
        pk_ast_integer_expression_independent(right$ast)) "Integer" else "Real"
  } else dimension
}

pk_assert_typed_ast_independent <- function(ast, scope = list(), path = "/ast") {
  sc_assert(is.list(ast) && !is.null(names(ast)) && "kind" %in% names(ast),
            "FAIL_TYPE", paste("AST_TYPECHECK missing exact kind at", path))
  kind <- ast[["kind", exact = TRUE]]
  sc_assert(is.character(kind) && length(kind) == 1L && !is.na(kind),
            "FAIL_TYPE", paste("AST_TYPECHECK invalid kind discriminator at", path))
  known_symbols <- pk_ast_symbol_sorts_v1()
  checked <- function(sort) list(sort = sort, ast = ast)
  child <- function(value, suffix, child_scope = scope) {
    pk_assert_typed_ast_independent(value, child_scope, paste0(path, suffix))
  }
  if (identical(kind, "number")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "value"), path)
    value <- ast[["value", exact = TRUE]]
    sc_assert(identical(ast[["sort", exact = TRUE]], "Rational") &&
                pk_is_canonical_numeral_independent(value),
              "FAIL_TYPE", paste("AST_TYPECHECK malformed number at", path))
    return(checked("Rational"))
  }
  if (identical(kind, "symbol")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "name"), path)
    name <- ast[["name", exact = TRUE]]; sort <- ast[["sort", exact = TRUE]]
    sc_assert(is.character(name) && length(name) == 1L && name %in% names(known_symbols) &&
                identical(sort, known_symbols[[name]]),
              "FAIL_TYPE", paste("AST_TYPECHECK unknown or wrongly sorted symbol at", path))
    return(checked(sort))
  }
  if (identical(kind, "bound_symbol")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "name"), path)
    name <- ast[["name", exact = TRUE]]; sort <- ast[["sort", exact = TRUE]]
    sc_assert(is.character(name) && length(name) == 1L && name %in% names(scope) &&
                identical(sort, scope[[name]]),
              "FAIL_TYPE", paste("AST_TYPECHECK unbound or wrongly sorted variable at", path))
    return(checked(sort))
  }
  if (identical(kind, "set_symbol")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "name"), path)
    sc_assert(identical(ast[["name", exact = TRUE]], "W") &&
                identical(ast[["sort", exact = TRUE]], "Set<Player>"),
              "FAIL_TYPE", paste("AST_TYPECHECK unknown set symbol at", path))
    return(checked("Set<Player>"))
  }
  if (identical(kind, "binary")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "operator", "left", "right"), path)
    left <- child(ast[["left", exact = TRUE]], "/left")
    right <- child(ast[["right", exact = TRUE]], "/right")
    expected <- pk_ast_binary_sort_independent(ast[["operator", exact = TRUE]],
                                               left, right, path)
    sc_assert(identical(ast[["sort", exact = TRUE]], expected), "FAIL_TYPE",
              paste("AST_TYPECHECK binary result sort at", path,
                    ast[["sort", exact = TRUE]], "!=", expected))
    return(checked(expected))
  }
  if (identical(kind, "unary")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "operator", "argument"), path)
    sc_assert(ast[["operator", exact = TRUE]] %in% c("+", "-"), "FAIL_TYPE",
              paste("AST_TYPECHECK unknown unary operator at", path))
    argument <- child(ast[["argument", exact = TRUE]], "/argument")
    pk_ast_numeric_dimension_independent(argument$sort, path)
    sc_assert(identical(ast[["sort", exact = TRUE]], argument$sort), "FAIL_TYPE",
              paste("AST_TYPECHECK unary result sort at", path))
    return(checked(argument$sort))
  }
  if (identical(kind, "compare")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "operator", "left", "right"), path)
    operator <- ast[["operator", exact = TRUE]]
    sc_assert(operator %in% c("<", "<=", "=", ">=", ">", "!="), "FAIL_TYPE",
              paste("AST_TYPECHECK unknown comparison at", path))
    left <- child(ast[["left", exact = TRUE]], "/left")
    right <- child(ast[["right", exact = TRUE]], "/right")
    numeric <- left$sort %in% sc_numeric_sorts() && right$sort %in% sc_numeric_sorts()
    if (numeric) {
      ld <- pk_ast_numeric_dimension_independent(left$sort, path)
      rd <- pk_ast_numeric_dimension_independent(right$sort, path)
      amount <- function(x) x %in% c("Payoff", "PayoffShare")
      sc_assert(!((identical(ld, "Probability") && amount(rd)) ||
                    (identical(rd, "Probability") && amount(ld))),
                "FAIL_TYPE", paste("AST_TYPECHECK comparison dimensions at", path))
    } else {
      type_literal <- (identical(left$sort, "Type") &&
                         identical(right$ast[["kind", exact = TRUE]], "number") &&
                         right$ast[["value", exact = TRUE]] %in% c("0", "1")) ||
        (identical(right$sort, "Type") &&
           identical(left$ast[["kind", exact = TRUE]], "number") &&
           left$ast[["value", exact = TRUE]] %in% c("0", "1"))
      sc_assert(identical(left$sort, right$sort) || type_literal,
                "FAIL_TYPE", paste("AST_TYPECHECK incompatible comparison at", path))
    }
    sc_assert(identical(ast[["sort", exact = TRUE]], "Proposition"), "FAIL_TYPE",
              paste("AST_TYPECHECK comparison result sort at", path))
    return(checked("Proposition"))
  }
  if (identical(kind, "logical")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "operator", "arguments"), path)
    operator <- ast[["operator", exact = TRUE]]; arguments <- ast[["arguments", exact = TRUE]]
    arity <- if (identical(operator, "not")) 1L else 2L
    sc_assert(operator %in% c("not", "and", "or", "iff", "implies") &&
                is.list(arguments) && is.null(names(arguments)) && length(arguments) == arity,
              "FAIL_TYPE", paste("AST_TYPECHECK logical operator/arity at", path))
    for (index in seq_along(arguments)) {
      result <- child(arguments[[index]], paste0("/arguments/", index))
      sc_assert(identical(result$sort, "Proposition"), "FAIL_TYPE",
                paste("AST_TYPECHECK logical child at", path))
    }
    sc_assert(identical(ast[["sort", exact = TRUE]], "Proposition"), "FAIL_TYPE",
              paste("AST_TYPECHECK logical result at", path))
    return(checked("Proposition"))
  }
  if (identical(kind, "call")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "name", "arguments"), path)
    name <- ast[["name", exact = TRUE]]; arguments <- ast[["arguments", exact = TRUE]]
    sc_assert(name %in% c("floor", "Pr") && is.list(arguments) &&
                is.null(names(arguments)) && length(arguments) == 1L,
              "FAIL_TYPE", paste("AST_TYPECHECK call name/arity at", path))
    argument <- child(arguments[[1L]], "/arguments/1")
    expected <- if (identical(name, "Pr")) "Probability" else "Integer"
    if (identical(name, "Pr")) {
      sc_assert(identical(argument$sort, "Proposition"), "FAIL_TYPE",
                paste("AST_TYPECHECK Pr event at", path))
    } else {
      sc_assert(argument$sort %in% c("Integer", "Rational", "Real"), "FAIL_TYPE",
                paste("AST_TYPECHECK floor argument at", path))
    }
    sc_assert(identical(ast[["sort", exact = TRUE]], expected), "FAIL_TYPE",
              paste("AST_TYPECHECK call result at", path))
    return(checked(expected))
  }
  if (identical(kind, "binder")) {
    pk_ast_exact_keys(ast, c("kind", "variable", "variable_sort", "source_variable",
                            "domain", "constraints"), path)
    variable <- ast[["variable", exact = TRUE]]
    variable_sort <- ast[["variable_sort", exact = TRUE]]
    source_variable <- ast[["source_variable", exact = TRUE]]
    source_sort <- switch(source_variable,
      i = "Player",
      K = "FiniteSet<Player>", T = "FiniteSet<Player>",
      sc_abort("FAIL_TYPE", paste("AST_TYPECHECK unknown binder source at", path)))
    sc_assert(is.character(variable) && length(variable) == 1L &&
                grepl("^b[1-9][0-9]*$", variable) &&
                variable_sort %in% c("Player", "FiniteSet<Player>") &&
                identical(variable_sort, source_sort) &&
                !(variable %in% names(scope)),
              "FAIL_TYPE", paste("AST_TYPECHECK binder declaration at", path))
    domain <- child(ast[["domain", exact = TRUE]], "/domain")
    sc_assert(identical(domain$sort, "Set<Player>"), "FAIL_TYPE",
              paste("AST_TYPECHECK binder domain at", path))
    constraints <- ast[["constraints", exact = TRUE]]
    sc_assert(is.list(constraints) && is.null(names(constraints)) && length(constraints) <= 2L,
              "FAIL_TYPE", paste("AST_TYPECHECK binder constraints at", path))
    inner_scope <- scope; inner_scope[[variable]] <- variable_sort
    for (index in seq_along(constraints)) {
      result <- child(constraints[[index]], paste0("/constraints/", index), inner_scope)
      sc_assert(identical(result$sort, "Proposition"), "FAIL_TYPE",
                paste("AST_TYPECHECK binder constraint at", path))
    }
    return(list(sort = "Binder", ast = ast, bound_scope = inner_scope))
  }
  if (identical(kind, "indexed_symbol")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "family", "indices"), path)
    indices <- ast[["indices", exact = TRUE]]
    sc_assert(identical(ast[["sort", exact = TRUE]], "Probability") &&
                ast[["family", exact = TRUE]] %in% c("omega", "e", "p") &&
                is.list(indices) && is.null(names(indices)) && length(indices) == 2L &&
                length(unique(unlist(indices, use.names = FALSE))) == 2L &&
                all(vapply(indices, function(index) is.character(index) && length(index) == 1L &&
                             !is.na(index) && index %in% names(scope), logical(1))) &&
                identical(scope[[indices[[1L]]]], "Player") &&
                identical(scope[[indices[[2L]]]], "FiniteSet<Player>"),
              "FAIL_TYPE", paste("AST_TYPECHECK indexed symbol scope at", path))
    return(checked("Probability"))
  }
  if (kind %in% c("indexed_sum", "quantifier")) {
    keys <- if (identical(kind, "indexed_sum")) c("kind", "sort", "binder", "body") else
      c("kind", "quantifier", "sort", "binder", "body")
    pk_ast_exact_keys(ast, keys, path)
    if (identical(kind, "quantifier")) {
      sc_assert(identical(ast[["quantifier", exact = TRUE]], "forall"), "FAIL_TYPE",
                paste("AST_TYPECHECK quantifier at", path))
    }
    binder <- child(ast[["binder", exact = TRUE]], "/binder")
    body <- child(ast[["body", exact = TRUE]], "/body", binder$bound_scope)
    expected <- if (identical(kind, "indexed_sum")) "Real" else "Proposition"
    if (identical(kind, "indexed_sum")) {
      pk_ast_numeric_dimension_independent(body$sort, path)
    } else sc_assert(identical(body$sort, "Proposition"), "FAIL_TYPE",
                     paste("AST_TYPECHECK quantified body at", path))
    sc_assert(identical(ast[["sort", exact = TRUE]], expected), "FAIL_TYPE",
              paste("AST_TYPECHECK binder result sort at", path))
    return(checked(expected))
  }
  if (identical(kind, "set_difference")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "left", "right"), path)
    left <- child(ast[["left", exact = TRUE]], "/left")
    right <- child(ast[["right", exact = TRUE]], "/right")
    sc_assert(identical(left$sort, "Set<Player>") && identical(right$sort, "Set<Player>") &&
                identical(ast[["sort", exact = TRUE]], "Set<Player>"),
              "FAIL_TYPE", paste("AST_TYPECHECK set difference at", path))
    return(checked("Set<Player>"))
  }
  if (identical(kind, "singleton")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "element"), path)
    element <- child(ast[["element", exact = TRUE]], "/element")
    sc_assert(identical(element$sort, "Player") &&
                identical(ast[["sort", exact = TRUE]], "Set<Player>"),
              "FAIL_TYPE", paste("AST_TYPECHECK singleton at", path))
    return(checked("Set<Player>"))
  }
  if (identical(kind, "cardinality_constraint")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "set", "equals"), path)
    set <- child(ast[["set", exact = TRUE]], "/set")
    equals <- child(ast[["equals", exact = TRUE]], "/equals")
    sc_assert(identical(set$sort, "FiniteSet<Player>") &&
                pk_ast_integer_expression_independent(equals$ast) &&
                identical(ast[["sort", exact = TRUE]], "Proposition"),
              "FAIL_TYPE", paste("AST_TYPECHECK cardinality constraint at", path))
    return(checked("Proposition"))
  }
  if (identical(kind, "membership_constraint")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "element", "container"), path)
    element <- child(ast[["element", exact = TRUE]], "/element")
    container <- child(ast[["container", exact = TRUE]], "/container")
    sc_assert(identical(element$sort, "Player") &&
                identical(container$sort, "FiniteSet<Player>") &&
                identical(ast[["sort", exact = TRUE]], "Proposition"),
              "FAIL_TYPE", paste("AST_TYPECHECK membership at", path))
    return(checked("Proposition"))
  }
  if (identical(kind, "not_equal_constraint")) {
    pk_ast_exact_keys(ast, c("kind", "sort", "left", "right"), path)
    left <- child(ast[["left", exact = TRUE]], "/left")
    right <- child(ast[["right", exact = TRUE]], "/right")
    sc_assert(identical(left$sort, right$sort) &&
                identical(ast[["sort", exact = TRUE]], "Proposition"),
              "FAIL_TYPE", paste("AST_TYPECHECK inequality constraint at", path))
    return(checked("Proposition"))
  }
  if (identical(kind, "domain")) {
    pk_ast_exact_keys(ast, c("kind", "constraints"), path)
    constraints <- ast[["constraints", exact = TRUE]]
    sc_assert(is.list(constraints) && is.null(names(constraints)) && length(constraints) <= 2L,
              "FAIL_TYPE", paste("AST_TYPECHECK domain constraints at", path))
    for (index in seq_along(constraints)) {
      result <- child(constraints[[index]], paste0("/constraints/", index))
      sc_assert(identical(result$sort, "Proposition"), "FAIL_TYPE",
                paste("AST_TYPECHECK domain proposition at", path))
    }
    return(checked("Domain"))
  }
  sc_abort("FAIL_TYPE", paste("AST_TYPECHECK unknown kind at", path, kind))
}

pk_formula <- function(ast, rule, premises = character(0)) {
  pk_assert_typed_ast_independent(ast)
  rational <- ea_ast_to_rat(ast)
  list(kind = "formula", ast = ast, rational = rational,
       normal_form = ea_rat_canonical(rational), rule = rule,
       premises = as.list(premises))
}

pk_assert_formula_consistent <- function(value, label) {
  sc_assert(is.list(value) &&
              identical(names(value), c("kind", "ast", "rational", "normal_form",
                                         "rule", "premises")) &&
              identical(value$kind, "formula") && !is.null(value$ast),
            "FAIL_CERTIFICATE", paste(label, "is not a formula result"))
  pk_assert_typed_ast_independent(value$ast, path = paste0("/formula/", label, "/ast"))
  recomputed_rat <- ea_ast_to_rat(value$ast)
  ea_assert_rat(recomputed_rat, paste(label, "AST rational"))
  ea_assert_rat(value$rational, paste(label, "cached rational"))
  sc_assert(ea_rat_equal(recomputed_rat, value$rational), "FAIL_CERTIFICATE",
            paste(label, "cached rational was not computed from its AST"))
  recomputed <- ea_rat_canonical(recomputed_rat)
  sc_assert(identical(recomputed, value$normal_form), "FAIL_CERTIFICATE",
            paste(label, "normal form was not computed from its AST"))
  invisible(TRUE)
}

pk_assert_formula_equivalent <- function(value, expected_ast, label) {
  pk_assert_formula_consistent(value, label)
  expected <- ea_ast_to_rat(expected_ast)
  actual <- ea_ast_to_rat(value$ast)
  sc_assert(ea_rat_equal(actual, expected), "FAIL_CERTIFICATE",
            paste(label, "does not equal its rule-computed expression"))
  invisible(TRUE)
}

pk_ast_divisors <- function(ast) {
  sc_assert(is.list(ast) && !is.null(ast$kind), "FAIL_TYPE",
            "malformed AST while collecting denominators")
  children <- switch(ast$kind,
    number = list(), symbol = list(), indexed_symbol = list(),
    unary = list(ast$argument),
    binary = list(ast$left, ast$right),
    compare = list(ast$left, ast$right),
    logical = ast$arguments,
    call = ast$arguments,
    indexed_sum = list(ast$body),
    sc_abort("FAIL_TYPE", paste("unknown AST kind while collecting denominators", ast$kind))
  )
  own <- if (identical(ast$kind, "binary") && identical(ast$operator, "/")) {
    list(ast$right)
  } else list()
  c(own, unlist(lapply(children, pk_ast_divisors), recursive = FALSE))
}

pk_ast_substitute <- function(ast, symbol, replacement) {
  sc_assert(is.list(ast) && !is.null(ast$kind), "FAIL_TYPE",
            "malformed AST during exact substitution")
  if (identical(ast$kind, "symbol") && identical(ast$name, symbol)) return(replacement)
  if (ast$kind %in% c("number", "symbol", "bound_symbol", "set_symbol",
                      "indexed_symbol")) return(ast)
  fields <- switch(ast$kind,
    unary = "argument", binary = c("left", "right"), compare = c("left", "right"),
    logical = "arguments", call = "arguments", singleton = "element",
    set_difference = c("left", "right"),
    cardinality_constraint = c("set", "equals"),
    membership_constraint = c("element", "container"),
    not_equal_constraint = c("left", "right"),
    indexed_sum = "body", quantifier = "body",
    sc_abort("FAIL_TYPE", paste("unsupported AST substitution kind", ast$kind)))
  for (field in fields) {
    if (is.list(ast[[field]]) && is.null(ast[[field]]$kind)) {
      ast[[field]] <- lapply(ast[[field]], pk_ast_substitute,
                             symbol = symbol, replacement = replacement)
    } else {
      ast[[field]] <- pk_ast_substitute(ast[[field]], symbol, replacement)
    }
  }
  if (identical(ast$kind, "binary")) {
    ast <- sc_numeric_binary(ast$operator, ast$left, ast$right)
  } else if (identical(ast$kind, "unary")) {
    ast$sort <- ast$argument$sort
  }
  ast
}

pk_trusted_domain_fact <- function(fact_id, denominator_ast, proposition_ast,
                                   constraints, source_step_ids, source_object) {
  list(fact_id = fact_id,
       denominator_nf = ea_rat_canonical(ea_ast_to_rat(denominator_ast)),
       proposition_ast = proposition_ast,
       domain_ast = list(kind = "domain", constraints = constraints),
       source_step_ids = as.character(source_step_ids),
       source_object_hash = pk_object_hash(source_object))
}

pk_trusted_m_fact <- function(quota, sorts) {
  m <- pk_sym("m", sorts); zero <- pk_num(0)
  fact <- pk_trusted_domain_fact(
    "D.m.positive", m, pk_compare(">", m, zero),
    list(pk_compare(">=", m, pk_num(2))), "S07", quota)
  ea_validate_trusted_domain_fact(fact, fact$denominator_nf, "m positivity")
  fact
}

pk_assert_only_positive_m_divisors <- function(formulas, sorts, quota) {
  if (!is.list(formulas) || identical(formulas$kind, "formula")) formulas <- list(formulas)
  expected_m <- ea_ast_to_rat(pk_sym("m", sorts))
  divisors <- unlist(lapply(formulas, function(formula) {
    pk_assert_formula_consistent(formula, "denominator premise")
    pk_ast_divisors(formula$ast)
  }), recursive = FALSE)
  for (divisor in divisors) {
    sc_assert(ea_rat_equal(ea_ast_to_rat(divisor), expected_m), "FAIL_CERTIFICATE",
              "a payoff formula contains an unproved denominator")
  }
  fact <- pk_trusted_m_fact(quota, sorts)
  list(kind = "trusted_denominator_provenance", fact = fact,
       occurrence_count = length(divisors))
}

pk_compare <- function(operator, left, right) {
  sc_ast("compare", operator = operator, left = left, right = right,
         sort = "Proposition")
}

# Recompute the majority-quota lemma from the primitive rule by an integer
# parity split.  Downstream callers compare this complete proof object, so a
# copied or partially corrupted bound cannot be used as a premise.
pk_quota_from_primitives <- function(primitives, sorts) {
  sc_assert(identical(primitives$axioms$majority$quota_rule,
                      "floor(N/2)+1"),
            "FAIL_CERTIFICATE", "majority quota primitive changed")
  t <- sc_ast("symbol", name = "t", sort = "Integer")
  N <- pk_sym("N", sorts); q <- pk_sym("q", sorts); m <- pk_sym("m", sorts)
  twice_t <- pk_mul(pk_num(2), t)
  even_q <- pk_add(t, pk_num(1)); even_m <- pk_sub(twice_t, pk_num(1))
  odd_N <- pk_add(twice_t, pk_num(1)); odd_q <- pk_add(t, pk_num(1)); odd_m <- twice_t
  even_margin <- pk_formula(pk_sub(even_m, even_q), "QUOTA_EVAL")
  odd_margin <- pk_formula(pk_sub(odd_m, odd_q), "QUOTA_EVAL")
  pk_assert_formula_equivalent(even_margin, pk_sub(t, pk_num(2)),
                               "even-parity m-q margin")
  pk_assert_formula_equivalent(odd_margin, pk_sub(t, pk_num(1)),
                               "odd-parity m-q margin")
  parity_certificate <- list(
    kind = "integer_parity_case_split",
    primitive_domain = list(N_sort = "Integer", lower = pk_compare(">=", N, pk_num(3))),
    cases = list(
      even = list(
        assumptions = list(pk_compare("=", N, twice_t), pk_compare(">=", t, pk_num(2))),
        substitutions = list(pk_compare("=", q, even_q), pk_compare("=", m, even_m)),
        q_lower = pk_compare(">=", even_q, pk_num(2)),
        q_le_m_margin = even_margin,
        q_le_m = pk_compare(">=", even_margin$ast, pk_num(0))),
      odd = list(
        assumptions = list(pk_compare("=", N, odd_N), pk_compare(">=", t, pk_num(1))),
        substitutions = list(pk_compare("=", q, odd_q), pk_compare("=", m, odd_m)),
        q_lower = pk_compare(">=", odd_q, pk_num(2)),
        q_le_m_margin = odd_margin,
        q_le_m = pk_compare(">=", odd_margin$ast, pk_num(0)))),
    conclusions = list(
      q_lower = pk_compare(">=", q, pk_num(2)),
      m_lower = pk_compare(">=", m, pk_num(2)),
      q_le_m = pk_compare("<=", q, m),
      exclusion_support = list(pk_compare(">=", pk_sub(q, pk_num(1)), pk_num(1)),
                               pk_compare("<=", pk_sub(q, pk_num(1)),
                                          pk_sub(m, pk_num(1)))),
      inclusion_support = list(pk_compare(">=", pk_sub(q, pk_num(2)), pk_num(0)),
                               pk_compare("<=", pk_sub(q, pk_num(2)),
                                          pk_sub(m, pk_num(1)))))
  )
  list(kind = "quota", q_rule = primitives$axioms$majority$quota_rule,
       parity_certificate = parity_certificate,
       bounds = list(q_lower = 2L, m_lower = 2L,
                     q_le_m = parity_certificate$conclusions$q_le_m,
                     exclusion_support = parity_certificate$conclusions$exclusion_support,
                     inclusion_support = parity_certificate$conclusions$inclusion_support),
       exclude_weak_votes = pk_sub(q, pk_num(1)),
       include_weak_votes = pk_sub(q, pk_num(2)))
}

# Independent quota oracle.  This function deliberately does not call
# pk_quota_from_primitives(): QUOTA_EVAL may construct the proof object, but a
# second literal parity derivation owns acceptance of its complete value.
pk_quota_oracle_v1 <- function(primitives, sorts) {
  sc_assert(identical(primitives$axioms$majority$quota_rule,
                      "floor(N/2)+1"),
            "FAIL_CERTIFICATE", "quota oracle lost the frozen majority rule")
  t <- list(kind = "symbol", sort = "Integer", name = "t")
  N <- list(kind = "symbol", sort = "Integer", name = "N")
  q <- list(kind = "symbol", sort = "Integer", name = "q")
  m <- list(kind = "symbol", sort = "Integer", name = "m")
  number <- function(value) list(kind = "number", sort = "Rational",
                                 value = as.character(value))
  binary <- function(operator, left, right, sort = "Integer") {
    list(kind = "binary", sort = sort, operator = operator,
         left = left, right = right)
  }
  compare <- function(operator, left, right) {
    list(kind = "compare", sort = "Proposition", operator = operator,
         left = left, right = right)
  }
  twice_t <- binary("*", number(2), t)
  even_q <- binary("+", t, number(1)); even_m <- binary("-", twice_t, number(1))
  odd_N <- binary("+", twice_t, number(1)); odd_q <- binary("+", t, number(1))
  odd_m <- twice_t
  make_margin <- function(left, right, reduced) {
    ast <- binary("-", left, right)
    rational <- ea_ast_to_rat(ast); expected <- ea_ast_to_rat(reduced)
    sc_assert(ea_rat_equal(rational, expected), "FAIL_CERTIFICATE",
              "quota oracle parity margin failed exact algebra")
    list(kind = "formula", ast = ast, rational = rational,
         normal_form = ea_rat_canonical(rational), rule = "QUOTA_EVAL",
         premises = list())
  }
  even_margin <- make_margin(even_m, even_q, binary("-", t, number(2)))
  odd_margin <- make_margin(odd_m, odd_q, binary("-", t, number(1)))
  parity <- list(
    kind = "integer_parity_case_split",
    primitive_domain = list(N_sort = "Integer",
                            lower = compare(">=", N, number(3))),
    cases = list(
      even = list(
        assumptions = list(compare("=", N, twice_t), compare(">=", t, number(2))),
        substitutions = list(compare("=", q, even_q), compare("=", m, even_m)),
        q_lower = compare(">=", even_q, number(2)),
        q_le_m_margin = even_margin,
        q_le_m = compare(">=", even_margin$ast, number(0))),
      odd = list(
        assumptions = list(compare("=", N, odd_N), compare(">=", t, number(1))),
        substitutions = list(compare("=", q, odd_q), compare("=", m, odd_m)),
        q_lower = compare(">=", odd_q, number(2)),
        q_le_m_margin = odd_margin,
        q_le_m = compare(">=", odd_margin$ast, number(0)))),
    conclusions = list(
      q_lower = compare(">=", q, number(2)),
      m_lower = compare(">=", m, number(2)),
      q_le_m = compare("<=", q, m),
      exclusion_support = list(
        compare(">=", binary("-", q, number(1)), number(1)),
        compare("<=", binary("-", q, number(1)), binary("-", m, number(1)))),
      inclusion_support = list(
        compare(">=", binary("-", q, number(2)), number(0)),
        compare("<=", binary("-", q, number(2)), binary("-", m, number(1)))))
  )
  result <- list(
    kind = "quota", q_rule = "floor(N/2)+1", parity_certificate = parity,
    bounds = list(q_lower = 2L, m_lower = 2L,
                  q_le_m = parity$conclusions$q_le_m,
                  exclusion_support = parity$conclusions$exclusion_support,
                  inclusion_support = parity$conclusions$inclusion_support),
    exclude_weak_votes = binary("-", q, number(1)),
    include_weak_votes = binary("-", q, number(2)))
  pk_assert_typed_ast_independent(result$exclude_weak_votes,
                                  path = "/quota_oracle/exclude_weak_votes")
  pk_assert_typed_ast_independent(result$include_weak_votes,
                                  path = "/quota_oracle/include_weak_votes")
  result
}

pk_assert_quota <- function(quota, primitives, sorts) {
  expected <- pk_quota_oracle_v1(primitives, sorts)
  sc_assert(identical(pk_canonical_json(pk_public_value(quota)),
                      pk_canonical_json(pk_public_value(expected))),
            "FAIL_CERTIFICATE", "quota proof object differs from exact parity replay")
  invisible(TRUE)
}

pk_sign_e_minus_r <- function(difference, quota, primitives, sorts) {
  expected <- pk_sub(pk_num(1), pk_div(pk_mul(pk_sym("beta", sorts),
                                                pk_sym("q", sorts)),
                                      pk_sym("m", sorts)))
  pk_assert_formula_equivalent(difference, expected, "E-R")
  pk_assert_quota(quota, primitives, sorts)
  denominator <- pk_assert_only_positive_m_divisors(difference, sorts, quota)
  list(kind = "strict_sign", formula = difference, relation = ">0",
       domain = list(beta = "0<beta<1", quota = "2<=q<=m", m = "m>=2"),
       inequality_chain = as.list(c("0<beta*q", "beta*q<q", "q<=m",
                                    "0<m-beta*q", "0<(m-beta*q)/m")),
       denominator = denominator)
}

pk_frontier_certificate <- function(solution, pair, differences, strict_sign, sorts) {
  sc_assert(identical(strict_sign$kind, "strict_sign") &&
              identical(strict_sign$relation, ">0"),
            "FAIL_CERTIFICATE", "frontier requires the replayed strict D sign")
  beta <- pk_sym("beta", sorts); m <- pk_sym("m", sorts)
  o0 <- pk_sym("o_0", sorts); o1 <- pk_sym("o_1", sorts)
  w <- pk_div(pk_num(1), m)
  D <- strict_sign$formula$ast
  if (identical(pair, c("S", "P"))) {
    expected_numerator <- pk_mul(beta, pk_sub(o1, o0))
    expected_positive_denominator <- pk_add(expected_numerator,
      pk_add(pk_mul(beta, pk_sub(w, o1)), D))
    required_order <- "o_0<o_1<1/m"
    target <- differences$S_minus_P
  } else if (identical(pair, c("S", "E"))) {
    expected_numerator <- pk_mul(beta, pk_sub(w, o0))
    expected_positive_denominator <- pk_add(expected_numerator, D)
    required_order <- "o_0<1/m"
    target <- differences$S_minus_E
  } else sc_abort("FAIL_CERTIFICATE", "unknown frontier comparison")
  components <- pk_affine_components(target, "nu")
  positive_denominator <- ea_poly_negate(components$slope)
  positive_denominator_rat <- ea_rat(positive_denominator,
                                     components$inherited_denominator)
  sc_assert(ea_rat_equal(positive_denominator_rat,
                         ea_ast_to_rat(expected_positive_denominator)),
            "FAIL_CERTIFICATE",
            paste(paste(pair, collapse = "-"),
                  "frontier denominator was not derived from the payoff difference"))
  expected_root <- ea_rat_divide(ea_ast_to_rat(expected_numerator),
                                 ea_ast_to_rat(expected_positive_denominator))
  sc_assert(ea_rat_equal(solution$rational, expected_root), "FAIL_CERTIFICATE",
            "linear solution is not the exact frontier")
  list(kind = "frontier_certificate", pair = as.list(pair),
       domain = required_order, numerator = ea_rat_canonical(ea_ast_to_rat(expected_numerator)),
       denominator = ea_rat_canonical(positive_denominator_rat),
       denominator_sign = ">0", root_interval = "0<root<1",
       root_below_one_reason = if (pair[[2L]] == "P")
         "denominator-numerator=P-w>D>0" else "denominator-numerator=D>0")
}

pk_affine_components <- function(formula, variable = "nu") {
  pk_assert_formula_consistent(formula, "affine premise")
  rational <- formula$rational
  denominator_has_variable <- any(vapply(names(rational$denominator), function(key) {
    exponents <- ea_decode_monomial(key)
    variable %in% names(exponents) && exponents[[variable]] != 0L
  }, logical(1)))
  sc_assert(!denominator_has_variable, "FAIL_CERTIFICATE",
            "linear solver denominator contains target variable")
  constant_terms <- list()
  slope_terms <- list()
  for (key in names(rational$numerator)) {
    exponents <- ea_decode_monomial(key)
    exponent <- if (variable %in% names(exponents)) exponents[[variable]] else 0L
    sc_assert(exponent <= 1L, "FAIL_CERTIFICATE", "linear solver received nonlinear polynomial")
    if (exponent == 1L) exponents <- exponents[names(exponents) != variable]
    target_key <- ea_monomial(exponents)
    target <- if (exponent == 0L) constant_terms else slope_terms
    target[[target_key]] <- if (is.null(target[[target_key]])) {
      rational$numerator[[key]]
    } else target[[target_key]] + rational$numerator[[key]]
    if (exponent == 0L) constant_terms <- target else slope_terms <- target
  }
  list(constant = ea_poly(constant_terms), slope = ea_poly(slope_terms),
       inherited_denominator = rational$denominator)
}

pk_solve_affine_zero <- function(formula, variable = "nu") {
  components <- pk_affine_components(formula, variable)
  sc_assert(length(components$slope) > 0L, "FAIL_CERTIFICATE", "linear equation has zero slope")
  root <- ea_rat(ea_poly_negate(components$constant), components$slope)
  list(kind = "linear_solution", variable = variable, rational = root,
       normal_form = ea_rat_canonical(root), slope = components$slope,
       constant = components$constant,
       denominator_obligation = list(kind = "strict_nonzero", polynomial = components$slope))
}

pk_require_axioms <- function(primitives) {
  exact_names <- function(value, expected, label) {
    sc_assert(is.list(value) && identical(names(value), expected), "FAIL_CERTIFICATE",
              paste(label, "schema has missing, extra, or reordered fields"))
  }
  exact_names(primitives, c("contract", "symbols", "axioms"), "primitive context")
  exact_names(primitives$contract, c("path", "sha256", "sections"), "contract binding")
  sc_assert(identical(primitives$symbols, n3g_symbol_sorts()), "FAIL_TYPE",
            "primitive symbol sorts differ from the closed game environment")
  sc_assert(identical(primitives$contract$path,
                      "quality_reports/plans/2026-08-12_essential_input_gate0.md") &&
              identical(primitives$contract$sha256,
                        "1e0bb0e42f3e65eab6d297e5d7d6776abbca9e88bbeabf3fb848a3a3a4dc8c21") &&
              identical(unlist(primitives$contract$sections, use.names = FALSE),
                        c("2", "4", "5", "6", "9:P0-P7")),
            "FAIL_BINDING", "primitive context is not bound to the authorized contract")
  a <- primitives$axioms
  exact_names(a, c("players", "parameters", "feasibility", "majority", "recognition",
                   "ballot", "payoff", "solution", "timing"), "axiom registry")
  exact_names(a$players, c("N_integer", "N_lower", "m_definition"), "player axioms")
  exact_names(a$parameters, c("beta_open_unit", "outside_order", "y_bar"),
              "parameter axioms")
  exact_names(a$feasibility, c("unit_pie", "slack_allowed", "nonnegative"),
              "feasibility axioms")
  exact_names(a$majority, "quota_rule", "majority axioms")
  exact_names(a$recognition, c("iid", "uniform_over_m", "replacement"),
              "recognition axioms")
  exact_names(a$ballot, c("pure", "simultaneous", "sealed", "proposer_counts_yes",
                          "public_vector_after"), "ballot axioms")
  exact_names(a$payoff, c("full_y_execution", "H_no_pass", "H_yes_pass",
                          "weak_disagreement"), "payoff axioms")
  exact_names(a$solution, c("PBE", "weak_stage_undominated", "T_Y_at_genuine_equality",
                            "H_stage_undominated", "proposal_tie_break"),
              "solution axioms")
  exact_names(a$timing, c("rounds", "R2_terminal", "adjacent_discount_count"),
              "timing axioms")
  sc_assert(isTRUE(a$players$N_integer) && identical(a$players$N_lower, 3L) &&
              identical(a$players$m_definition, "N-1"),
            "FAIL_CERTIFICATE", "player-count primitives changed")
  sc_assert(isTRUE(a$parameters$beta_open_unit) &&
              identical(a$parameters$outside_order, "0<o_0<o_1<1") &&
              identical(a$parameters$y_bar, "o_1<=y_bar<=1"),
            "FAIL_CERTIFICATE", "parameter domain changed")
  sc_assert(isTRUE(a$feasibility$unit_pie) && isTRUE(a$feasibility$slack_allowed) &&
              identical(unlist(a$feasibility$nonnegative, use.names = FALSE),
                        c("y", "x_j", "r_i")),
            "FAIL_CERTIFICATE", "proposal feasibility primitives changed")
  sc_assert(identical(names(a$majority), "quota_rule") &&
              identical(a$majority$quota_rule, "floor(N/2)+1"),
            "FAIL_CERTIFICATE", "majority quota primitives changed")
  sc_assert(isTRUE(a$recognition$iid) && isTRUE(a$recognition$uniform_over_m) &&
              isTRUE(a$recognition$replacement),
            "FAIL_CERTIFICATE", "recognition primitives changed")
  sc_assert(isTRUE(a$ballot$pure) && isTRUE(a$ballot$simultaneous) &&
              isTRUE(a$ballot$sealed) && isTRUE(a$ballot$proposer_counts_yes) &&
              isTRUE(a$ballot$public_vector_after),
            "FAIL_CERTIFICATE", "ballot protocol primitives changed")
  sc_assert(isTRUE(a$payoff$full_y_execution) &&
              identical(a$payoff$H_no_pass, "y+o_theta") &&
              identical(a$payoff$H_yes_pass, "y") &&
              identical(a$payoff$weak_disagreement, "0"),
            "FAIL_CERTIFICATE", "payoff primitives changed")
  sc_assert(identical(a$timing$rounds, 2L) &&
              identical(a$timing$adjacent_discount_count, 1L) &&
              isTRUE(a$timing$R2_terminal),
            "FAIL_CERTIFICATE", "discount timing changed")
  sc_assert(isTRUE(a$solution$PBE) && isTRUE(a$solution$weak_stage_undominated) &&
              isTRUE(a$solution$T_Y_at_genuine_equality) &&
              identical(a$solution$H_stage_undominated, FALSE) &&
              identical(a$solution$proposal_tie_break, "min_expected_H"),
            "FAIL_CERTIFICATE", "solution concept changed")
  invisible(TRUE)
}

pk_expected_step_schema <- function() {
  ids <- sprintf("S%02d", 1:29)
  rules <- c(
    rep("IMPORT_EXACT", 3), rep("DISCOUNT_ONCE", 3), "QUOTA_EVAL",
    "PAYOFF_EVAL", "BEST_RESPONSE", "PAYOFF_EVAL",
    rep("BUDGET_SATURATION", 3), rep("PAYOFF_EVAL", 2), "ALGEBRA_EQ",
    "SIGN_FROM_DOMAIN", rep("SOLVE_LINEAR_INEQUALITY", 2), "HEDGE_TRANSFORM",
    "ARGMAX_BY_CASES", "INTERVAL_PARTITION", "FEASIBILITY", "TIE_BREAK",
    "BAYES", "SIMPLEX_SUM", "INDEXED_SUM", "FREE_SYMBOL_CLOSURE", "PBE_WITNESS"
  )
  refs <- list(
    character(), character(), character(), "S01", "S02", "S03", character(),
    "S04", c("S05", "S06", "S07"),
    c("S04", "S05", "S06", "S07", "S08", "S09"),
    c("S04", "S07"), c("S04", "S05", "S07"), c("S04", "S06", "S07"),
    c("S04", "S12"), "S04", c("S11", "S13", "S14", "S15"),
    c("S07", "S16"), c("S16", "S17"),
    c("S16", "S17"), c("S08", "S09", "S10"),
    c("S11", "S13", "S14", "S15", "S16", "S17", "S18", "S19", "S20"),
    "S21", c("S04", "S05", "S06", "S07", "S11", "S12", "S13", "S17", "S21"),
    c("S05", "S06", "S11", "S12", "S13", "S14", "S21"),
    c("S02", "S03", "S08", "S09", "S21", "S23", "S26"),
    c("S07", "S21", "S23"),
    c("S01", "S04", "S07", "S21", "S23", "S26"),
    c("S21", "S23", "S24", "S25", "S26", "S27"),
    c("S08", "S09", "S10", "S17", "S21", "S22", "S23", "S24", "S25",
      "S26", "S27", "S28")
  )
  args <- replicate(29L, list(), simplify = FALSE)
  args[[1L]] <- list(field = "weak_value")
  args[[2L]] <- list(field = "H_theta_0")
  args[[3L]] <- list(field = "H_theta_1")
  args[[8L]] <- list(problem = "weak_ballot")
  args[[9L]] <- list(player = "H")
  args[[10L]] <- list(problem = "proposer_all_feasible_proposals")
  args[[11L]] <- list(outcome = "exclude_H")
  args[[12L]] <- list(outcome = "low_only")
  args[[13L]] <- list(outcome = "pooling")
  args[[14L]] <- list(problem = "true_prior_low_only")
  args[[15L]] <- list(problem = "deliberate_failure")
  args[[16L]] <- list(operation = "all_pairwise_differences")
  args[[17L]] <- list(target = "E_minus_R")
  args[[18L]] <- list(pair = as.list(c("S", "P")), variable = "nu")
  args[[19L]] <- list(pair = as.list(c("S", "E")), variable = "nu")
  output <- lapply(seq_along(ids), function(index) {
    list(step_id = ids[[index]], rule = rules[[index]], refs = refs[[index]],
         args = args[[index]])
  })
  names(output) <- ids
  output
}

pk_validate_step_schema <- function(steps) {
  expected <- pk_expected_step_schema()
  ids <- vapply(steps, `[[`, character(1), "step_id")
  sc_assert(setequal(ids, names(expected)) && length(ids) == length(expected),
            "FAIL_CERTIFICATE", "proof plan has missing or extra step ids")
  for (step in steps) {
    sc_assert(identical(names(step), c("step_id", "rule", "refs", "args")),
              "FAIL_CERTIFICATE", paste("proof step schema changed at", step$step_id))
    target <- expected[[step$step_id]]
    sc_assert(identical(step$rule, target$rule), "FAIL_CERTIFICATE",
              paste("wrong rule at", step$step_id))
    actual_refs <- unlist(step$refs, use.names = FALSE)
    if (is.null(actual_refs)) actual_refs <- character(0)
    sc_assert(identical(actual_refs, target$refs), "FAIL_CERTIFICATE",
              paste("wrong, extra, or reordered refs at", step$step_id))
    sc_assert(identical(step$args, target$args), "FAIL_CERTIFICATE",
              paste("wrong, missing, or extra args at", step$step_id))
  }
  invisible(TRUE)
}

pk_reload_frozen_n1 <- function(n1) {
  expected_path <- "model_redesign/essential_input_interfaces/n1_r2_majority_candidate_v1.json"
  expected_hash <- "1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
  sc_assert(is.list(n1) && identical(n1$path, expected_path), "FAIL_BINDING",
            "N1 replay input does not name the frozen dependency path")
  sc_assert(file.exists(expected_path) && identical(sc_sha256_file(expected_path), expected_hash),
            "FAIL_BINDING", "frozen N1 bytes changed during replay")
  fresh <- sc_read_json_strict(expected_path)
  sc_assert(identical(fresh$schema_ref, "equilibrium_correspondence_v1") &&
              length(fresh$correspondence_cells) == 1L &&
              length(fresh$correspondence_cells[[1L]]$equilibrium_records) == 1L,
            "FAIL_BINDING", "frozen N1 structure changed during replay")
  fresh_record <- fresh$correspondence_cells[[1L]]$equilibrium_records[[1L]]
  sc_assert(identical(pk_canonical_json(pk_public_value(n1$record)),
                      pk_canonical_json(pk_public_value(fresh_record))),
            "FAIL_BINDING", "caller-supplied N1 record differs from frozen bytes")
  sc_assert(identical(n1$artifact_hash, paste0("sha256:", expected_hash)),
            "FAIL_BINDING", "caller-supplied N1 hash label changed")
  list(path = expected_path, artifact_hash = paste0("sha256:", expected_hash),
       record = fresh_record)
}

pk_import_n1_formula <- function(field, n1, sorts) {
  record <- n1$record
  text <- switch(field,
    weak_value = record$weak_nonproposer_pre_recognition_expected_value,
    H_theta_0 = record$hegemon_payoff_by_type$theta_0,
    H_theta_1 = record$hegemon_payoff_by_type$theta_1,
    sc_abort("FAIL_CERTIFICATE", paste("unknown N1 import field", field))
  )
  expected_sort <- if (identical(field, "weak_value")) "Scalar" else "Payoff"
  pk_formula(sc_parse_complete(text, sorts, expected_sort), "IMPORT_EXACT")
}

pk_order_cases <- function() {
  grid <- expand.grid(r0 = -1:1, r1 = -1:1, KEEP.OUT.ATTRS = FALSE,
                      stringsAsFactors = FALSE)
  # With o_0<o_1, their signs relative to 1/m are weakly ordered; both
  # cannot equal the reference point.  Filtering the Cartesian sign set by
  # those two primitive facts derives the five cases without a target table.
  grid[with(grid, r0 <= r1 & !(r0 == 0L & r1 == 0L)), , drop = FALSE]
}

pk_order_label <- function(r0, r1) {
  if (r0 == -1L && r1 == -1L) return("o_0<o_1<1/m")
  if (r0 == -1L && r1 == 0L) return("o_0<o_1=1/m")
  if (r0 == -1L && r1 == 1L) return("o_0<1/m<o_1")
  if (r0 == 0L && r1 == 1L) return("o_0=1/m<o_1")
  if (r0 == 1L && r1 == 1L) return("1/m<o_0<o_1")
  sc_abort("FAIL_CERTIFICATE", "inconsistent outside-option order")
}

pk_expected_core <- function(primitives, sorts, n1) {
  quota <- pk_quota_from_primitives(primitives, sorts)
  one <- pk_num(1); beta <- pk_sym("beta", sorts); nu <- pk_sym("nu", sorts)
  q <- pk_sym("q", sorts)
  imported_c <- pk_import_n1_formula("weak_value", n1, sorts)
  imported_o0 <- pk_import_n1_formula("H_theta_0", n1, sorts)
  imported_o1 <- pk_import_n1_formula("H_theta_1", n1, sorts)
  c_value <- pk_formula(pk_mul(beta, imported_c$ast), "DISCOUNT_ONCE", "S01")
  a0 <- pk_formula(pk_mul(beta, imported_o0$ast), "DISCOUNT_ONCE", "S02")
  a1 <- pk_formula(pk_mul(beta, imported_o1$ast), "DISCOUNT_ONCE", "S03")
  E <- pk_formula(pk_sub(one, pk_add(pk_num(0),
                                     pk_mul(pk_sub(q, one), c_value$ast))),
                  "BUDGET_SATURATION", c("S04", "S07"))
  L <- pk_formula(pk_sub(one, pk_add(a0$ast,
                                     pk_mul(pk_sub(q, pk_num(2)), c_value$ast))),
                  "BUDGET_SATURATION", c("S04", "S05", "S07"))
  P <- pk_formula(pk_sub(one, pk_add(a1$ast,
                                     pk_mul(pk_sub(q, pk_num(2)), c_value$ast))),
                  "BUDGET_SATURATION", c("S04", "S06", "S07"))
  S <- pk_formula(pk_add(pk_mul(pk_sub(one, nu), L$ast),
                         pk_mul(nu, c_value$ast)),
                  "PAYOFF_EVAL", c("S04", "S12"))
  R <- c_value
  difference <- function(left, right) pk_formula(pk_sub(left$ast, right$ast),
                                                  "ALGEBRA_EQ",
                                                  c("S11", "S13", "S14", "S15"))
  differences <- list(kind = "differences", E_minus_R = difference(E, R),
                      P_minus_E = difference(P, E), S_minus_E = difference(S, E),
                      S_minus_P = difference(S, P))
  strict <- pk_sign_e_minus_r(differences$E_minus_R, quota, primitives, sorts)
  frontier <- function(pair, field) {
    solution <- pk_solve_affine_zero(differences[[field]], "nu")
    solution$sign_certificate <- pk_frontier_certificate(
      solution, pair, differences, strict, sorts)
    solution$orientation <- "target_ge_zero_below_or_at_root"
    solution
  }
  frontier_SP <- frontier(c("S", "P"), "S_minus_P")
  frontier_SE <- frontier(c("S", "E"), "S_minus_E")
  regions <- pk_argmax_regions(differences, strict, frontier_SP, frontier_SE, sorts)
  list(quota = quota, imported_c = imported_c, imported_o0 = imported_o0,
       imported_o1 = imported_o1, c_value = c_value, a0 = a0, a1 = a1,
       E = E, L = L, P = P, S = S, R = R, differences = differences,
       strict = strict, frontier_SP = frontier_SP, frontier_SE = frontier_SE,
       regions = regions)
}

pk_core_argmax <- function(core) {
  list(kind = "argmax_correspondence",
       candidates = list(E = core$E, P = core$P, S = core$S, R = core$R),
       frontier_SP = core$frontier_SP, frontier_SE = core$frontier_SE,
       regions = core$regions)
}

pk_core_budget_witness <- function(core, outcome) {
  if (identical(outcome, "exclude_H")) {
    y <- pk_num(0); count <- core$quota$exclude_weak_votes
    premises <- c("S04", "S07")
  } else if (identical(outcome, "low_only")) {
    y <- core$a0$ast; count <- core$quota$include_weak_votes
    premises <- c("S04", "S05", "S07")
  } else if (identical(outcome, "pooling")) {
    y <- core$a1$ast; count <- core$quota$include_weak_votes
    premises <- c("S04", "S06", "S07")
  } else sc_abort("FAIL_CERTIFICATE", "unknown core budget outcome")
  residual <- pk_formula(pk_sub(pk_num(1),
                                pk_add(y, pk_mul(count, core$c_value$ast))),
                         "BUDGET_SATURATION", premises)
  list(kind = "budget_witness", outcome = outcome, y = y, weak_count = count,
       weak_price = core$c_value, residual = residual, slack = pk_num(0))
}

pk_make_weak_br <- function(c_value) {
  list(kind = "weak_best_response", cutoff = c_value,
       action = "yes iff x_j>=cutoff", equality = "yes_by_T_Y",
       payoff_table = list(
         pivotal = c(yes = "x_j", no = c_value$normal_form),
         pass_anyway = c(yes = "x_j", no = "x_j"),
         fail_anyway = c(yes = c_value$normal_form, no = c_value$normal_form)))
}

pk_assert_weak_br_complete <- function(value, core) {
  sc_assert(is.list(value) &&
              identical(names(value), c("kind", "cutoff", "action", "equality",
                                         "payoff_table")) &&
              identical(value$kind, "weak_best_response") &&
              identical(value$action, "yes iff x_j>=cutoff") &&
              identical(value$equality, "yes_by_T_Y") &&
              identical(names(value$payoff_table),
                        c("pivotal", "pass_anyway", "fail_anyway")),
            "FAIL_CERTIFICATE", "weak best-response policy or schema changed")
  pk_assert_formula_equivalent(value$cutoff, core$c_value$ast,
                               "weak best-response cutoff")
  cutoff_nf <- core$c_value$normal_form
  expected_table <- list(
    pivotal = c(yes = "x_j", no = cutoff_nf),
    pass_anyway = c(yes = "x_j", no = "x_j"),
    fail_anyway = c(yes = cutoff_nf, no = cutoff_nf)
  )
  sc_assert(identical(value$payoff_table, expected_table), "FAIL_CERTIFICATE",
            "weak ballot payoff contingencies changed")
  invisible(TRUE)
}

pk_make_H_br <- function(a0, a1, sorts) {
  y <- pk_sym("y", sorts); o0 <- pk_sym("o_0", sorts); o1 <- pk_sym("o_1", sorts)
  no_gain_0 <- pk_formula(pk_sub(pk_add(y, o0), y), "BEST_RESPONSE")
  no_gain_1 <- pk_formula(pk_sub(pk_add(y, o1), y), "BEST_RESPONSE")
  pivotal_0 <- pk_formula(pk_sub(y, a0$ast), "BEST_RESPONSE")
  pivotal_1 <- pk_formula(pk_sub(y, a1$ast), "BEST_RESPONSE")
  list(kind = "H_best_response", cases = list(
    k_ge_q_minus_1 = list(action = "no",
                          strict_gain = list(theta_0 = no_gain_0, theta_1 = no_gain_1),
                          sign_domain = "0<o_0<o_1"),
    k_eq_q_minus_2 = list(action = "yes iff y-continuation>=0",
                          continuation = list(theta_0 = a0, theta_1 = a1),
                          yes_minus_no = list(theta_0 = pivotal_0, theta_1 = pivotal_1),
                          equality = "yes_by_T_Y"),
    k_le_q_minus_3 = list(action = "yes_by_T_Y",
                          yes_payoff = list(theta_0 = a0, theta_1 = a1),
                          no_payoff = list(theta_0 = a0, theta_1 = a1))))
}

pk_assert_H_br_complete <- function(value, core, sorts) {
  sc_assert(is.list(value) && identical(names(value), c("kind", "cases")) &&
              identical(value$kind, "H_best_response") &&
              identical(names(value$cases),
                        c("k_ge_q_minus_1", "k_eq_q_minus_2", "k_le_q_minus_3")),
            "FAIL_CERTIFICATE", "H best-response schema or case partition changed")
  y <- pk_sym("y", sorts); o0 <- pk_sym("o_0", sorts); o1 <- pk_sym("o_1", sorts)
  nonpivotal <- value$cases$k_ge_q_minus_1
  sc_assert(identical(names(nonpivotal), c("action", "strict_gain", "sign_domain")) &&
              identical(nonpivotal$action, "no") &&
              identical(nonpivotal$sign_domain, "0<o_0<o_1") &&
              identical(names(nonpivotal$strict_gain), c("theta_0", "theta_1")),
            "FAIL_CERTIFICATE", "H nonpivotal response changed")
  pk_assert_formula_equivalent(nonpivotal$strict_gain$theta_0,
                               pk_sub(pk_add(y, o0), y), "H nonpivotal theta 0 gain")
  pk_assert_formula_equivalent(nonpivotal$strict_gain$theta_1,
                               pk_sub(pk_add(y, o1), y), "H nonpivotal theta 1 gain")
  pivotal <- value$cases$k_eq_q_minus_2
  sc_assert(identical(names(pivotal),
                      c("action", "continuation", "yes_minus_no", "equality")) &&
              identical(pivotal$action, "yes iff y-continuation>=0") &&
              identical(pivotal$equality, "yes_by_T_Y") &&
              identical(names(pivotal$continuation), c("theta_0", "theta_1")) &&
              identical(names(pivotal$yes_minus_no), c("theta_0", "theta_1")),
            "FAIL_CERTIFICATE", "H pivotal response or equality policy changed")
  pk_assert_formula_equivalent(pivotal$continuation$theta_0, core$a0$ast,
                               "H pivotal theta 0 continuation")
  pk_assert_formula_equivalent(pivotal$continuation$theta_1, core$a1$ast,
                               "H pivotal theta 1 continuation")
  pk_assert_formula_equivalent(pivotal$yes_minus_no$theta_0,
                               pk_sub(y, core$a0$ast), "H pivotal theta 0 gain")
  pk_assert_formula_equivalent(pivotal$yes_minus_no$theta_1,
                               pk_sub(y, core$a1$ast), "H pivotal theta 1 gain")
  passing_anyway <- value$cases$k_le_q_minus_3
  sc_assert(identical(names(passing_anyway), c("action", "yes_payoff", "no_payoff")) &&
              identical(passing_anyway$action, "yes_by_T_Y") &&
              identical(names(passing_anyway$yes_payoff), c("theta_0", "theta_1")) &&
              identical(names(passing_anyway$no_payoff), c("theta_0", "theta_1")),
            "FAIL_CERTIFICATE", "H passing-anyway response changed")
  for (theta in c("theta_0", "theta_1")) {
    expected <- if (theta == "theta_0") core$a0$ast else core$a1$ast
    pk_assert_formula_equivalent(passing_anyway$yes_payoff[[theta]], expected,
                                 paste("H passing-anyway yes", theta))
    pk_assert_formula_equivalent(passing_anyway$no_payoff[[theta]], expected,
                                 paste("H passing-anyway no", theta))
  }
  invisible(TRUE)
}

pk_make_proposer_map <- function(c_value, a0, a1, quota, weak_br, H_br, sorts) {
  sc_assert(identical(quota$kind, "quota") &&
              identical(weak_br$kind, "weak_best_response") &&
              identical(H_br$kind, "H_best_response"),
            "FAIL_CERTIFICATE", "proposer map lacks typed ballot premises")
  pk_assert_formula_equivalent(weak_br$cutoff, c_value$ast,
                               "proposer weak cutoff")
  pk_assert_formula_equivalent(
    H_br$cases$k_eq_q_minus_2$continuation$theta_0, a0$ast,
    "proposer H low cutoff")
  pk_assert_formula_equivalent(
    H_br$cases$k_eq_q_minus_2$continuation$theta_1, a1$ast,
    "proposer H high cutoff")
  nu <- pk_sym("nu", sorts); one <- pk_num(1); ri <- pk_sym("r_i", sorts)
  middle <- pk_formula(pk_add(pk_mul(pk_sub(one, nu), ri),
                              pk_mul(nu, c_value$ast)),
                       "PAYOFF_EVAL", c("S04", "S05", "S06", "S07", "S08", "S09"))
  list(kind = "proposer_map", cases = list(
    k_ge_q_minus_1 = list(domain = "k>=q-1", theta_payoffs = list(ri, ri),
                          expected = pk_formula(ri, "PAYOFF_EVAL")),
    k_eq_q_minus_2_y_lt_a0 = list(domain = "k=q-2 and y<a0",
                                  theta_payoffs = list(c_value, c_value),
                                  expected = c_value),
    k_eq_q_minus_2_middle = list(domain = "k=q-2 and a0<=y<a1",
                                 theta_payoffs = list(pk_formula(ri, "PAYOFF_EVAL"), c_value),
                                 expected = middle),
    k_eq_q_minus_2_y_ge_a1 = list(domain = "k=q-2 and y>=a1",
                                  theta_payoffs = list(pk_formula(ri, "PAYOFF_EVAL"),
                                                       pk_formula(ri, "PAYOFF_EVAL")),
                                  expected = pk_formula(ri, "PAYOFF_EVAL")),
    k_le_q_minus_3 = list(domain = "k<=q-3", theta_payoffs = list(c_value, c_value),
                          expected = c_value)),
    case_partition = list(k = as.list(c("k>=q-1", "k=q-2", "k<=q-3")),
                          y_when_pivotal = as.list(c("y<a0", "a0<=y<a1", "y>=a1"))),
    cutoffs = list(a0 = a0, a1 = a1))
}

pk_assert_proposer_map_complete <- function(value, core, sorts) {
  sc_assert(is.list(value) && identical(names(value),
              c("kind", "cases", "case_partition", "cutoffs")) &&
              identical(value$kind, "proposer_map") &&
              identical(names(value$cases), c("k_ge_q_minus_1",
                "k_eq_q_minus_2_y_lt_a0", "k_eq_q_minus_2_middle",
                "k_eq_q_minus_2_y_ge_a1", "k_le_q_minus_3")),
            "FAIL_CERTIFICATE", "proposer map schema or case coverage changed")
  ri <- pk_sym("r_i", sorts); nu <- pk_sym("nu", sorts); one <- pk_num(1)
  middle <- pk_add(pk_mul(pk_sub(one, nu), ri), pk_mul(nu, core$c_value$ast))
  expected_domains <- c("k>=q-1", "k=q-2 and y<a0", "k=q-2 and a0<=y<a1",
                        "k=q-2 and y>=a1", "k<=q-3")
  expected_theta <- list(
    list(ri, ri),
    list(core$c_value, core$c_value),
    list(pk_formula(ri, "PAYOFF_EVAL"), core$c_value),
    list(pk_formula(ri, "PAYOFF_EVAL"), pk_formula(ri, "PAYOFF_EVAL")),
    list(core$c_value, core$c_value)
  )
  expected_payoffs <- list(ri, core$c_value$ast, middle, ri, core$c_value$ast)
  for (index in seq_along(value$cases)) {
    case <- value$cases[[index]]
    sc_assert(identical(names(case), c("domain", "theta_payoffs", "expected")) &&
                identical(case$domain, expected_domains[[index]]) &&
                length(case$theta_payoffs) == 2L,
              "FAIL_CERTIFICATE", paste("proposer case", index, "domain changed"))
    for (theta in 1:2) {
      actual <- case$theta_payoffs[[theta]]
      expected <- expected_theta[[index]][[theta]]
      if (is.list(actual) && identical(actual$kind, "formula")) {
        expected_ast <- if (is.list(expected) && identical(expected$kind, "formula")) {
          expected$ast
        } else expected
        pk_assert_formula_equivalent(actual, expected_ast,
          paste("proposer case", index, "theta payoff", theta))
      } else {
        sc_assert(identical(sc_ast_canonical(actual), sc_ast_canonical(expected)),
                  "FAIL_CERTIFICATE",
                  paste("proposer case", index, "theta payoff", theta, "changed"))
      }
    }
    pk_assert_formula_equivalent(case$expected, expected_payoffs[[index]],
                                 paste("proposer case", index, "expected payoff"))
  }
  sc_assert(identical(value$case_partition,
              list(k = as.list(c("k>=q-1", "k=q-2", "k<=q-3")),
                   y_when_pivotal = as.list(c("y<a0", "a0<=y<a1", "y>=a1")))),
            "FAIL_CERTIFICATE", "proposer case partition changed")
  sc_assert(identical(names(value$cutoffs), c("a0", "a1")), "FAIL_CERTIFICATE",
            "proposer cutoff schema changed")
  pk_assert_formula_equivalent(value$cutoffs$a0, core$a0$ast, "proposer cutoff a0")
  pk_assert_formula_equivalent(value$cutoffs$a1, core$a1$ast, "proposer cutoff a1")
  invisible(TRUE)
}

pk_hedge_from_maps <- function(refs, primitives, sorts, n1) {
  core <- pk_expected_core(primitives, sorts, n1)
  pk_assert_weak_br_complete(refs[[1L]], core)
  pk_assert_H_br_complete(refs[[2L]], core, sorts)
  pk_assert_proposer_map_complete(refs[[3L]], core, sorts)
  one <- pk_num(1); y <- pk_sym("y", sorts); X <- pk_sym("X", sorts)
  r <- pk_sym("r_i", sorts); rho <- pk_sym("rho", sorts)
  slack <- pk_formula(pk_sub(one, pk_add(y, pk_add(X, r))), "HEDGE_TRANSFORM")
  slack_residual <- pk_formula(pk_add(r, slack$ast), "HEDGE_TRANSFORM")
  slack_expected_gain <- pk_formula(pk_mul(rho, slack$ast), "HEDGE_TRANSFORM")
  pk_assert_formula_equivalent(slack_residual, pk_sub(one, pk_add(y, X)),
                               "slack-filled residual")
  original_budget <- pk_formula(pk_add(y, pk_add(X, r)), "HEDGE_TRANSFORM")
  exclusion_budget <- pk_formula(pk_add(pk_num(0), pk_add(X, pk_add(r, y))),
                                 "HEDGE_TRANSFORM")
  sc_assert(ea_rat_equal(ea_ast_to_rat(original_budget$ast),
                         ea_ast_to_rat(exclusion_budget$ast)),
            "FAIL_CERTIFICATE", "exclusion hedge does not preserve total budget")
  exclusion_gain <- pk_formula(pk_sub(pk_add(r, y), r), "HEDGE_TRANSFORM")
  pk_assert_formula_equivalent(exclusion_gain, y, "exclusion hedge gain")
  list(
    kind = "hedge",
    slack_fill = list(delta = slack, residual_after = slack_residual,
                      expected_gain = slack_expected_gain,
                      strict_domain = as.list(c("delta>0", "rho>0")),
                      ballot_coordinates_held_fixed = as.list(c("y", "x"))),
    exclusion_y_zero = list(original_budget = original_budget,
                            transformed_budget = exclusion_budget,
                            transformed_y = pk_num(0), transformed_residual = pk_add(r, y),
                            gain = exclusion_gain, strict_domain = "y>0",
                            quota_case = "k>=q-1",
                            ballot_coordinates_held_fixed = as.list(c("x", "k"))))
}

pk_assert_hedge_complete <- function(value, sorts) {
  sc_assert(is.list(value) && identical(value$kind, "hedge") &&
              identical(names(value), c("kind", "slack_fill", "exclusion_y_zero")),
            "FAIL_CERTIFICATE", "hedge result has a malformed schema")
  one <- pk_num(1); zero <- pk_num(0); y <- pk_sym("y", sorts)
  X <- pk_sym("X", sorts); r <- pk_sym("r_i", sorts); rho <- pk_sym("rho", sorts)
  delta <- pk_sub(one, pk_add(y, pk_add(X, r)))
  slack <- value$slack_fill
  sc_assert(identical(names(slack), c("delta", "residual_after", "expected_gain",
                                      "strict_domain", "ballot_coordinates_held_fixed")),
            "FAIL_CERTIFICATE", "slack-fill certificate schema changed")
  pk_assert_formula_equivalent(slack$delta, delta, "slack delta")
  pk_assert_formula_equivalent(slack$residual_after, pk_add(r, delta),
                               "slack residual")
  pk_assert_formula_equivalent(slack$expected_gain, pk_mul(rho, delta),
                               "slack expected gain")
  sc_assert(identical(unlist(slack$strict_domain, use.names = FALSE), c("delta>0", "rho>0")) &&
              identical(unlist(slack$ballot_coordinates_held_fixed, use.names = FALSE),
                        c("y", "x")),
            "FAIL_CERTIFICATE", "slack-fill domain or fixed coordinates changed")
  exclusion <- value$exclusion_y_zero
  sc_assert(identical(names(exclusion), c("original_budget", "transformed_budget",
                                          "transformed_y", "transformed_residual", "gain",
                                          "strict_domain", "quota_case",
                                          "ballot_coordinates_held_fixed")),
            "FAIL_CERTIFICATE", "exclusion hedge schema changed")
  pk_assert_formula_equivalent(exclusion$original_budget,
                               pk_add(y, pk_add(X, r)), "hedge original budget")
  pk_assert_formula_equivalent(exclusion$transformed_budget,
                               pk_add(zero, pk_add(X, pk_add(r, y))),
                               "hedge transformed budget")
  sc_assert(identical(sc_ast_canonical(exclusion$transformed_y),
                      sc_ast_canonical(zero)) &&
              identical(sc_ast_canonical(exclusion$transformed_residual),
                        sc_ast_canonical(pk_add(r, y))),
            "FAIL_CERTIFICATE", "exclusion transformation coordinates changed")
  pk_assert_formula_equivalent(exclusion$gain, y, "exclusion strict gain")
  sc_assert(identical(exclusion$strict_domain, "y>0") &&
              identical(exclusion$quota_case, "k>=q-1") &&
              identical(unlist(exclusion$ballot_coordinates_held_fixed, use.names = FALSE),
                        c("x", "k")),
            "FAIL_CERTIFICATE", "exclusion hedge domain changed")
  invisible(TRUE)
}

pk_assert_argmax_regions_independent <- function(regions, core) {
  interval <- function(lower, upper, lower_closed, upper_closed,
                       lower_rational = NULL, upper_rational = NULL) {
    list(kind = "interval", lower = lower, upper = upper,
         lower_closed = lower_closed, upper_closed = upper_closed,
         lower_rational = lower_rational, upper_rational = upper_rational)
  }
  expected <- list()
  add <- function(order_case, prior, branch, tie = NULL, dominance) {
    expected[[length(expected) + 1L]] <<- list(
      order_case = order_case, prior = prior, tie = tie, branch = branch,
      dominance = as.list(dominance)
    )
  }
  cases <- pk_order_cases()
  for (row in seq_len(nrow(cases))) {
    r0 <- cases$r0[[row]]; r1 <- cases$r1[[row]]
    order <- pk_order_label(r0, r1)
    if (r1 == -1L) {
      lower <- interval("0", core$frontier_SP$normal_form, TRUE, TRUE,
                        upper_rational = core$frontier_SP$rational)
      upper <- interval(core$frontier_SP$normal_form, "1", FALSE, TRUE,
                        lower_rational = core$frontier_SP$rational)
      add(order, lower, "S", dominance = c("S>=P", "P>E", "E>R"))
      add(order, upper, "P", dominance = c("P>S", "P>E", "E>R"))
    } else if (r1 == 1L && r0 == -1L) {
      lower <- interval("0", core$frontier_SE$normal_form, TRUE, TRUE,
                        upper_rational = core$frontier_SE$rational)
      upper <- interval(core$frontier_SE$normal_form, "1", FALSE, TRUE,
                        lower_rational = core$frontier_SE$rational)
      add(order, lower, "S", dominance = c("S>=E", "E>P", "E>R"))
      add(order, upper, "E", dominance = c("E>S", "E>P", "E>R"))
    } else if (r1 == 1L && r0 == 0L) {
      add(order, interval("0", "0", TRUE, TRUE), "S",
          dominance = c("S=E", "E>P", "E>R", "tie_break:S"))
      add(order, interval("0", "1", FALSE, TRUE), "E",
          dominance = c("E>S", "E>P", "E>R"))
    } else if (r1 == 1L && r0 == 1L) {
      add(order, interval("0", "1", TRUE, TRUE), "E",
          dominance = c("E>S", "E>P", "E>R"))
    } else {
      lower <- interval("0", core$frontier_SE$normal_form, TRUE, TRUE,
                        upper_rational = core$frontier_SE$rational)
      upper <- interval(core$frontier_SE$normal_form, "1", FALSE, TRUE,
                        lower_rational = core$frontier_SE$rational)
      add(order, lower, "S", dominance = c("S>=E=P", "E>R"))
      add(order, upper, "E", "h_E<h_P",
          c("E=P>S", "E>R", "tie_break:E"))
      add(order, upper, "P", "h_P<h_E",
          c("E=P>S", "E>R", "tie_break:P"))
      add(order, upper, "EP", "h_E=h_P",
          c("E=P>S", "E>R", "tie_break:all_mixtures"))
    }
  }
  sc_assert(length(regions) == length(expected), "FAIL_CERTIFICATE",
            "argmax region count differs from the independently derived partition")
  sc_assert(identical(pk_canonical_json(pk_public_value(regions)),
                      pk_canonical_json(pk_public_value(expected))),
            "FAIL_CERTIFICATE",
            "argmax branches, dominance relations, intervals, or ties changed")
  invisible(TRUE)
}

pk_assert_argmax_complete <- function(value, core, sorts) {
  sc_assert(is.list(value) && identical(value$kind, "argmax_correspondence"),
            "FAIL_CERTIFICATE", "argmax premise is malformed")
  for (name in c("E", "P", "S", "R")) {
    pk_assert_formula_equivalent(value$candidates[[name]], core[[name]]$ast,
                                 paste("argmax", name, "candidate"))
  }
  for (name in c("frontier_SP", "frontier_SE")) {
    actual <- value[[name]]; expected <- core[[name]]
    sc_assert(is.list(actual) && identical(actual$kind, "linear_solution"),
              "FAIL_CERTIFICATE", paste(name, "is malformed"))
    ea_assert_rat(actual$rational, paste(name, "root"))
    sc_assert(ea_rat_equal(actual$rational, expected$rational) &&
                identical(actual$normal_form, ea_rat_canonical(actual$rational)) &&
                ea_poly_equal(actual$slope, expected$slope) &&
                ea_poly_equal(actual$constant, expected$constant) &&
                identical(pk_canonical_json(pk_public_value(actual$sign_certificate)),
                          pk_canonical_json(pk_public_value(expected$sign_certificate))) &&
                identical(actual$orientation, expected$orientation),
              "FAIL_CERTIFICATE", paste(name, "differs from exact linear replay"))
  }
  sc_assert(identical(pk_canonical_json(pk_public_value(value$regions)),
                      pk_canonical_json(pk_public_value(core$regions))),
            "FAIL_CERTIFICATE", "argmax regions differ from computed sign partition")
  pk_assert_argmax_regions_independent(value$regions, core)
  invisible(TRUE)
}

pk_assert_feasibility_binding <- function(value, core) {
  sc_assert(is.list(value) && identical(value$kind, "feasibility") &&
              length(value$witnesses) == length(core$regions) &&
              identical(value$witness_count, length(core$regions)),
            "FAIL_CERTIFICATE", "feasibility premise is incomplete")
  for (index in seq_along(core$regions)) {
    witness <- value$witnesses[[index]]; region <- core$regions[[index]]
    sc_assert(identical(witness$region_hash, pk_object_hash(region)) &&
                identical(witness$branch, region$branch),
              "FAIL_CERTIFICATE", "feasibility witness copied a wrong region or branch")
  }
  invisible(TRUE)
}

pk_assert_simplexes_complete <- function(value, core, feasibility) {
  sc_assert(is.list(value) &&
              identical(names(value), c("kind", "per_region", "count", "recognition",
                                         "identity_symmetry_constraints")) &&
              identical(value$kind, "identity_simplexes") &&
              identical(value$count, length(core$regions)) &&
              length(value$per_region) == length(core$regions) &&
              identical(value$recognition, "iid_uniform_1_over_m") &&
              identical(value$identity_symmetry_constraints, list()),
            "FAIL_CERTIFICATE", "simplex premise is incomplete or malformed")
  pk_assert_feasibility_binding(feasibility, core)
  for (index in seq_along(core$regions)) {
    actual <- value$per_region[[index]]
    region <- core$regions[[index]]
    expected_simplex <- pk_simplex_for_branch(region$branch)
    sc_assert(identical(names(actual), c("region_hash", "branch", "simplex")) &&
                identical(actual$region_hash, pk_object_hash(region)) &&
                identical(actual$branch, region$branch) &&
                identical(pk_canonical_json(pk_public_value(actual$simplex)),
                          pk_canonical_json(pk_public_value(expected_simplex))),
              "FAIL_CERTIFICATE", "simplex differs from its computed labeled branch space")
  }
  pk_assert_simplex_invariants(value, core)
  invisible(TRUE)
}

pk_assert_simplex_invariants <- function(value, core) {
  for (index in seq_along(core$regions)) {
    wrapper <- value$per_region[[index]]; simplex <- wrapper$simplex
    branch <- core$regions[[index]]$branch
    expected_families <- switch(branch, E = "omega", S = "omega", P = "omega",
                                EP = c("e", "p"))
    expected_offsets <- switch(branch, E = 1L, S = 2L, P = 2L, EP = c(1L, 2L))
    expected_variables <- if (branch == "EP") c("b2", "b3") else "b2"
    expected_sources <- if (branch == "EP") c("K", "T") else "K"
    sc_assert(identical(simplex$kind, "identity_simplex") &&
                identical(simplex$branch, branch) &&
                identical(names(simplex), c("kind", "branch", "proposer_binder",
                  "support_families", "nonnegative", "normalization",
                  "normalization_nf", "pure_vertices", "mixture_space",
                  "support_nonempty_derivation")) &&
                length(simplex$support_families) == length(expected_families),
              "FAIL_CERTIFICATE", "simplex invariant schema or family count changed")
    proposer <- simplex$proposer_binder
    sc_assert(identical(proposer$kind, "binder") && identical(proposer$variable, "b1") &&
                identical(proposer$variable_sort, "Player") &&
                identical(proposer$source_variable, "i") &&
                identical(proposer$domain$kind, "set_symbol") &&
                identical(proposer$domain$name, "W") && length(proposer$constraints) == 0L,
              "FAIL_CERTIFICATE", "simplex proposer binder changed")
    sums <- vector("list", length(expected_families))
    for (family_index in seq_along(expected_families)) {
      family <- simplex$support_families[[family_index]]
      expected_binder <- pk_literal_coalition_binder(
        expected_sources[[family_index]], expected_variables[[family_index]],
        "b1", expected_offsets[[family_index]], FALSE)
      expected_weight <- pk_literal_indexed_weight(
        expected_families[[family_index]], "b1", expected_variables[[family_index]])
      expected_sum <- pk_literal_sum(expected_binder, expected_weight)
      sc_assert(identical(family$family, expected_families[[family_index]]) &&
                  identical(family$offset, expected_offsets[[family_index]]) &&
                  identical(pk_canonical_json(pk_public_value(family$binder)),
                            pk_canonical_json(pk_public_value(expected_binder))) &&
                  identical(pk_canonical_json(pk_public_value(family$weight)),
                            pk_canonical_json(pk_public_value(expected_weight))) &&
                  identical(pk_canonical_json(pk_public_value(family$sum)),
                            pk_canonical_json(pk_public_value(expected_sum))),
                "FAIL_CERTIFICATE", "simplex support family or indexed sum changed")
      cardinality <- family$binder$constraints[[1L]]
      sc_assert(length(family$binder$constraints) == 1L &&
                  identical(cardinality$kind, "cardinality_constraint") &&
                  ea_rat_equal(ea_ast_to_rat(cardinality$equals),
                               ea_ast_to_rat(pk_sub(pk_sym("q", n3g_symbol_sorts()),
                                                    pk_num(expected_offsets[[family_index]])))),
                "FAIL_CERTIFICATE", "simplex coalition cardinality changed")
      nonnegative <- simplex$nonnegative[[family_index]]
      expected_nonnegative <- list(
        kind = "quantifier", quantifier = "forall", sort = "Proposition",
        binder = proposer,
        body = list(
          kind = "quantifier", quantifier = "forall", sort = "Proposition",
          binder = expected_binder,
          body = list(kind = "compare", sort = "Proposition", operator = ">=",
                      left = expected_weight,
                      right = list(kind = "number", sort = "Rational", value = "0"))))
      sc_assert(identical(pk_canonical_json(pk_public_value(nonnegative)),
                          pk_canonical_json(pk_public_value(expected_nonnegative))),
                "FAIL_CERTIFICATE", "simplex nonnegativity condition changed")
      sums[[family_index]] <- expected_sum
      expected_support <- if (expected_offsets[[family_index]] == 1L) {
        c("q<=m", "q-1<=m-1")
      } else c("q>=2", "q-2>=0", "q-2<=m-1")
      sc_assert(identical(unlist(simplex$support_nonempty_derivation[[family_index]],
                                 use.names = FALSE), expected_support),
                "FAIL_CERTIFICATE", "simplex support nonemptiness proof changed")
    }
    normalization <- simplex$normalization
    expected_total <- sums[[1L]]
    if (length(sums) == 2L) {
      expected_total <- sc_ast("binary", operator = "+", left = sums[[1L]],
                               right = sums[[2L]], sort = "Real")
    }
    sc_assert(length(simplex$nonnegative) == length(sums) &&
                identical(normalization$kind, "quantifier") &&
                identical(normalization$quantifier, "forall") &&
                identical(pk_canonical_json(pk_public_value(normalization$binder)),
                          pk_canonical_json(pk_public_value(proposer))) &&
                identical(normalization$body$kind, "compare") &&
                identical(normalization$body$operator, "=") &&
                identical(sc_indexed_canonical(normalization$body$left),
                          sc_indexed_canonical(expected_total)) &&
                ea_rat_equal(ea_ast_to_rat(normalization$body$right),
                             ea_ast_to_rat(pk_num(1))) &&
                identical(simplex$normalization_nf, sc_indexed_canonical(normalization)),
              "FAIL_CERTIFICATE", "simplex normalization is not exactly one")
    sc_assert(identical(simplex$pure_vertices,
                        list(kind = "cartesian_identity_assignment",
                             one_support_element_per_proposer = "independently chosen")) &&
                identical(simplex$mixture_space,
                          list(kind = "full_labeled_simplex",
                               cross_identity_constraints = list())),
              "FAIL_CERTIFICATE", "simplex identity or mixture space changed")
  }
  invisible(TRUE)
}

pk_interval <- function(lower, upper, lower_closed, upper_closed,
                        lower_rational = NULL, upper_rational = NULL) {
  list(kind = "interval", lower = lower, upper = upper,
       lower_closed = lower_closed, upper_closed = upper_closed,
       lower_rational = lower_rational, upper_rational = upper_rational)
}

pk_argmax_regions <- function(differences, strict_sign, frontier_SP, frontier_SE, sorts) {
  sc_assert(identical(frontier_SP$sign_certificate$domain, "o_0<o_1<1/m") &&
              identical(frontier_SE$sign_certificate$domain, "o_0<1/m") &&
              identical(frontier_SP$sign_certificate$root_interval, "0<root<1") &&
              identical(frontier_SE$sign_certificate$root_interval, "0<root<1"),
            "FAIL_CERTIFICATE", "argmax received an uncertified frontier")
  beta <- pk_sym("beta", sorts); nu <- pk_sym("nu", sorts)
  m <- pk_sym("m", sorts); o0 <- pk_sym("o_0", sorts); o1 <- pk_sym("o_1", sorts)
  w <- pk_div(pk_num(1), m)
  expected_PE <- pk_mul(beta, pk_sub(w, o1))
  expected_SE <- pk_sub(pk_mul(pk_sub(pk_num(1), nu),
                               pk_mul(beta, pk_sub(w, o0))),
                        pk_mul(nu, strict_sign$formula$ast))
  pk_assert_formula_equivalent(differences$P_minus_E, expected_PE, "P-E")
  pk_assert_formula_equivalent(differences$S_minus_E, expected_SE, "S-E")
  # S-P is recomputed from the two preceding differences, preventing a
  # separately supplied frontier or branch table from becoming an oracle.
  recomputed_SP <- pk_formula(pk_sub(differences$S_minus_E$ast,
                                     differences$P_minus_E$ast), "ALGEBRA_EQ")
  sc_assert(ea_rat_equal(recomputed_SP$rational, differences$S_minus_P$rational),
            "FAIL_CERTIFICATE", "S-P is inconsistent with S-E and P-E")
  regions <- list()
  add <- function(order_case, prior, branch, tie = NULL, dominance) {
    regions[[length(regions) + 1L]] <<- list(
      order_case = order_case, prior = prior, tie = tie, branch = branch,
      dominance = as.list(dominance)
    )
  }
  cases <- pk_order_cases()
  for (row in seq_len(nrow(cases))) {
    r0 <- cases$r0[[row]]; r1 <- cases$r1[[row]]; order <- pk_order_label(r0, r1)
    # r1 is the sign of o_1-1/m, hence the opposite sign of P-E.
    # r0 is the sign of o_0-1/m, hence the opposite sign of S(0)-E.
    if (r1 == -1L) {
      # P strictly beats E. S(0)>P because o_1>o_0, and S-P is affine
      # decreasing, so the computed S=P root partitions the prior.
      lower <- pk_interval("0", frontier_SP$normal_form, TRUE, TRUE,
                           upper_rational = frontier_SP$rational)
      upper <- pk_interval(frontier_SP$normal_form, "1", FALSE, TRUE,
                           lower_rational = frontier_SP$rational)
      add(order, lower, "S", dominance = c("S>=P", "P>E", "E>R"))
      add(order, upper, "P", dominance = c("P>S", "P>E", "E>R"))
    } else if (r1 == 1L && r0 == -1L) {
      # E strictly beats P; S(0)>E and S-E decreases through its root.
      lower <- pk_interval("0", frontier_SE$normal_form, TRUE, TRUE,
                           upper_rational = frontier_SE$rational)
      upper <- pk_interval(frontier_SE$normal_form, "1", FALSE, TRUE,
                           lower_rational = frontier_SE$rational)
      add(order, lower, "S", dominance = c("S>=E", "E>P", "E>R"))
      add(order, upper, "E", dominance = c("E>S", "E>P", "E>R"))
    } else if (r1 == 1L && r0 == 0L) {
      # S(0)=E and its slope is negative. The proposal tie-break owns nu=0.
      add(order, pk_interval("0", "0", TRUE, TRUE), "S",
          dominance = c("S=E", "E>P", "E>R", "tie_break:S"))
      add(order, pk_interval("0", "1", FALSE, TRUE), "E",
          dominance = c("E>S", "E>P", "E>R"))
    } else if (r1 == 1L && r0 == 1L) {
      # E beats both P and S already at nu=0, and S-E decreases.
      add(order, pk_interval("0", "1", TRUE, TRUE), "E",
          dominance = c("E>S", "E>P", "E>R"))
    } else {
      # r1=0 implies E=P. Below S=E, S wins; above it the proposer is
      # indifferent between E and P and the expected-H tie-break partitions.
      lower <- pk_interval("0", frontier_SE$normal_form, TRUE, TRUE,
                           upper_rational = frontier_SE$rational)
      upper <- pk_interval(frontier_SE$normal_form, "1", FALSE, TRUE,
                           lower_rational = frontier_SE$rational)
      add(order, lower, "S", dominance = c("S>=E=P", "E>R"))
      add(order, upper, "E", "h_E<h_P",
          dominance = c("E=P>S", "E>R", "tie_break:E"))
      add(order, upper, "P", "h_P<h_E",
          dominance = c("E=P>S", "E>R", "tie_break:P"))
      add(order, upper, "EP", "h_E=h_P",
          dominance = c("E=P>S", "E>R", "tie_break:all_mixtures"))
    }
  }
  regions
}

pk_region_domain_witness <- function(region) {
  base <- list(N = "3", m = "2", q = "2", y_bar = "1")
  if (identical(region$order_case, "o_0<o_1<1/m")) {
    base <- c(base, list(beta = "1/2", o_0 = "1/8", o_1 = "1/4"))
    nu <- if (region$branch == "S") "0" else "1"
  } else if (identical(region$order_case, "o_0<1/m<o_1")) {
    base <- c(base, list(beta = "1/2", o_0 = "1/4", o_1 = "3/4"))
    nu <- if (region$branch == "S") "0" else "1"
  } else if (identical(region$order_case, "o_0=1/m<o_1")) {
    base <- c(base, list(beta = "1/2", o_0 = "1/2", o_1 = "3/4"))
    nu <- if (region$branch == "S") "0" else "1/2"
  } else if (identical(region$order_case, "1/m<o_0<o_1")) {
    base <- c(base, list(beta = "1/2", o_0 = "2/3", o_1 = "3/4"))
    nu <- "1/2"
  } else if (identical(region$order_case, "o_0<o_1=1/m")) {
    base <- c(base, list(beta = "9/10", o_0 = "1/10", o_1 = "1/2"))
    nu <- if (region$branch == "S") "0" else if (identical(region$tie, "h_E<h_P")) {
      "4/5"
    } else if (identical(region$tie, "h_P<h_E")) {
      "9/10"
    } else "7/8"
  } else sc_abort("FAIL_CERTIFICATE", "unknown region order case")
  assignment <- c(base, list(nu = nu))
  values <- lapply(assignment, ea_q)
  names(values) <- names(assignment)
  w <- ea_q(1) / values$m
  order_ok <- switch(region$order_case,
    `o_0<o_1<1/m` = values$o_0 < values$o_1 && values$o_1 < w,
    `o_0<o_1=1/m` = values$o_0 < values$o_1 && values$o_1 == w,
    `o_0<1/m<o_1` = values$o_0 < w && w < values$o_1,
    `o_0=1/m<o_1` = values$o_0 == w && w < values$o_1,
    `1/m<o_0<o_1` = w < values$o_0 && values$o_0 < values$o_1,
    FALSE)
  sc_assert(isTRUE(order_ok) && values$beta > 0 && values$beta < 1 &&
              values$nu >= 0 && values$nu <= 1 && values$o_0 > 0 &&
              values$o_1 < 1 && values$o_1 <= values$y_bar,
            "FAIL_CERTIFICATE", "region has no valid exact domain witness")
  interval <- region$prior
  lower <- if (!is.null(interval$lower_rational)) {
    ea_rat_evaluate(interval$lower_rational, values)
  } else ea_q(interval$lower)
  upper <- if (!is.null(interval$upper_rational)) {
    ea_rat_evaluate(interval$upper_rational, values)
  } else ea_q(interval$upper)
  lower_ok <- if (isTRUE(interval$lower_closed)) values$nu >= lower else values$nu > lower
  upper_ok <- if (isTRUE(interval$upper_closed)) values$nu <= upper else values$nu < upper
  sc_assert(lower_ok && upper_ok, "FAIL_CERTIFICATE",
            "exact nonvacuity witness is outside its prior interval")
  if (!is.null(region$tie)) {
    hE <- (ea_q(1) - values$nu) * values$o_0 + values$nu / values$m
    hP <- values$beta / values$m
    tie_ok <- switch(region$tie,
      `h_E<h_P` = hE < hP,
      `h_P<h_E` = hP < hE,
      `h_E=h_P` = hE == hP,
      FALSE)
    sc_assert(isTRUE(tie_ok), "FAIL_CERTIFICATE",
              "residual tie subdomain has no valid exact witness")
  }
  lapply(values, as.character)
}

# Literal, reviewable witnesses for the eleven nonempty semantic cells.  The
# table fixes identity/order only; acceptance is owned by the independent
# evaluator below, which never calls pk_region_domain_witness().
pk_s29_nonvacuity_registry_v1 <- local({
  registry <- NULL
  function() {
    if (!is.null(registry)) return(registry)
    assignment <- function(beta, o0, o1, nu) {
      list(N = "3", m = "2", q = "2", y_bar = "1", beta = beta,
           o_0 = o0, o_1 = o1, nu = nu)
    }
    record <- function(index, order_case, prior_class, branch, tie, values) {
      list(witness_id = sprintf("PBE-W%02d", index),
           order_case = order_case, prior_class = prior_class,
           branch = branch, tie = tie, assignment = values)
    }
    registry <<- list(
      record(1, "o_0<o_1<1/m", "lower_cell", "S", NULL,
             assignment("1/2", "1/8", "1/4", "0")),
      record(2, "o_0<o_1<1/m", "upper_cell", "P", NULL,
             assignment("1/2", "1/8", "1/4", "1")),
      record(3, "o_0<o_1=1/m", "lower_cell", "S", NULL,
             assignment("9/10", "1/10", "1/2", "0")),
      record(4, "o_0<o_1=1/m", "upper_cell", "E", "h_E<h_P",
             assignment("9/10", "1/10", "1/2", "4/5")),
      record(5, "o_0<o_1=1/m", "upper_cell", "P", "h_P<h_E",
             assignment("9/10", "1/10", "1/2", "9/10")),
      record(6, "o_0<o_1=1/m", "upper_cell", "EP", "h_E=h_P",
             assignment("9/10", "1/10", "1/2", "7/8")),
      record(7, "o_0<1/m<o_1", "lower_cell", "S", NULL,
             assignment("1/2", "1/4", "3/4", "0")),
      record(8, "o_0<1/m<o_1", "upper_cell", "E", NULL,
             assignment("1/2", "1/4", "3/4", "1")),
      record(9, "o_0=1/m<o_1", "singleton_zero", "S", NULL,
             assignment("1/2", "1/2", "3/4", "0")),
      record(10, "o_0=1/m<o_1", "upper_cell", "E", NULL,
             assignment("1/2", "1/2", "3/4", "1/2")),
      record(11, "1/m<o_0<o_1", "full_interval", "E", NULL,
             assignment("1/2", "2/3", "3/4", "1/2")))
    registry
  }
})

pk_s29_nonvacuity_registry_sha256_v1 <- function() {
  "70dc9a3eaab2047b27eb0d40e2e44ea2aed3571ef8353868be19b885f5cb5339"
}

pk_s29_nonvacuity_registry_lint <- function(
    registry = pk_s29_nonvacuity_registry_v1()) {
  sc_assert(is.list(registry) && is.null(names(registry)) && length(registry) == 11L,
            "FAIL_COVERAGE", "POST_S29 nonvacuity registry must contain 11 records")
  for (index in seq_along(registry)) {
    record <- registry[[index]]
    sc_assert(identical(names(record), c("witness_id", "order_case", "prior_class",
                                         "branch", "tie", "assignment")) &&
                identical(record$witness_id, sprintf("PBE-W%02d", index)) &&
                record$order_case %in% c("o_0<o_1<1/m", "o_0<o_1=1/m",
                                         "o_0<1/m<o_1", "o_0=1/m<o_1",
                                         "1/m<o_0<o_1") &&
                record$prior_class %in% c("lower_cell", "upper_cell",
                                          "singleton_zero", "full_interval") &&
                record$branch %in% c("E", "S", "P", "EP") &&
                (is.null(record$tie) || record$tie %in%
                   c("h_E<h_P", "h_P<h_E", "h_E=h_P")) &&
                identical(names(record$assignment),
                          c("N", "m", "q", "y_bar", "beta", "o_0", "o_1", "nu")) &&
                all(vapply(record$assignment, function(value) {
                  is.character(value) && length(value) == 1L && !is.na(value) &&
                    grepl("^[0-9]+(?:/[1-9][0-9]*)?$", value)
                }, logical(1))),
              "FAIL_COVERAGE", paste("POST_S29 malformed nonvacuity record", index))
  }
  hash <- sc_sha256_text(pk_canonical_json(registry))
  sc_assert(identical(hash, pk_s29_nonvacuity_registry_sha256_v1()),
            "FAIL_PACKAGE_INTEGRITY", "POST_S29 nonvacuity registry literal hash changed")
  list(status = "S29_NONVACUITY_REGISTRY_LINTED", witness_count = 11L,
       sha256 = hash)
}

pk_prior_interval_class_independent <- function(interval) {
  sc_assert(is.list(interval) && identical(interval$kind, "interval"),
            "FAIL_CERTIFICATE", "POST_S29 region prior is not an interval")
  if (identical(interval$lower, "0") && identical(interval$upper, "0") &&
      isTRUE(interval$lower_closed) && isTRUE(interval$upper_closed)) {
    return("singleton_zero")
  }
  if (identical(interval$lower, "0") && identical(interval$upper, "1") &&
      isTRUE(interval$lower_closed) && isTRUE(interval$upper_closed)) {
    return("full_interval")
  }
  if (identical(interval$lower, "0") && isTRUE(interval$lower_closed) &&
      isTRUE(interval$upper_closed)) return("lower_cell")
  if (identical(interval$upper, "1") && !isTRUE(interval$lower_closed) &&
      isTRUE(interval$upper_closed)) return("upper_cell")
  sc_abort("FAIL_CERTIFICATE", "POST_S29 interval has no literal cell class")
}

pk_assert_nonvacuity_witness_independent <- function(region, witness, specification,
                                                       label) {
  sc_assert(identical(names(witness),
                      c("N", "m", "q", "y_bar", "beta", "o_0", "o_1", "nu")) &&
              identical(witness, specification$assignment),
            "FAIL_CERTIFICATE", paste("POST_S29", label,
                                       "assignment differs from the pinned witness"))
  values <- lapply(witness, ea_q)
  integer_text <- vapply(witness[c("N", "m", "q")],
                         function(value) grepl("^[0-9]+$", value), logical(1))
  sc_assert(all(integer_text), "FAIL_TYPE", paste("POST_S29", label,
                                                   "quota values are not integers"))
  N_integer <- as.integer(witness$N); m_integer <- as.integer(witness$m)
  q_integer <- as.integer(witness$q)
  sc_assert(N_integer >= 3L && m_integer == N_integer - 1L &&
              q_integer == floor(N_integer / 2) + 1L && values$y_bar == ea_q(1) &&
              values$beta > 0 && values$beta < 1 &&
              values$nu >= 0 && values$nu <= 1 &&
              values$o_0 > 0 && values$o_0 < values$o_1 &&
              values$o_1 < 1 && values$o_1 <= values$y_bar,
            "FAIL_CERTIFICATE", paste("POST_S29", label,
                                       "violates the primitive domain or quota"))
  one_over_m <- ea_q(1) / values$m
  order_ok <- switch(specification$order_case,
    `o_0<o_1<1/m` = values$o_0 < values$o_1 && values$o_1 < one_over_m,
    `o_0<o_1=1/m` = values$o_0 < values$o_1 && values$o_1 == one_over_m,
    `o_0<1/m<o_1` = values$o_0 < one_over_m && one_over_m < values$o_1,
    `o_0=1/m<o_1` = values$o_0 == one_over_m && one_over_m < values$o_1,
    `1/m<o_0<o_1` = one_over_m < values$o_0 && values$o_0 < values$o_1,
    FALSE)
  sc_assert(isTRUE(order_ok) && identical(region$order_case, specification$order_case) &&
              identical(region$branch, specification$branch) &&
              identical(region$tie, specification$tie) &&
              identical(pk_prior_interval_class_independent(region$prior),
                        specification$prior_class),
            "FAIL_CERTIFICATE", paste("POST_S29", label,
                                       "order, branch, tie, or prior cell changed"))
  lower <- if (is.null(region$prior$lower_rational)) ea_q(region$prior$lower) else {
    ea_assert_rat(region$prior$lower_rational, paste(label, "lower interval"))
    ea_rat_evaluate(region$prior$lower_rational, values)
  }
  upper <- if (is.null(region$prior$upper_rational)) ea_q(region$prior$upper) else {
    ea_assert_rat(region$prior$upper_rational, paste(label, "upper interval"))
    ea_rat_evaluate(region$prior$upper_rational, values)
  }
  lower_ok <- if (isTRUE(region$prior$lower_closed)) values$nu >= lower else values$nu > lower
  upper_ok <- if (isTRUE(region$prior$upper_closed)) values$nu <= upper else values$nu < upper
  sc_assert(lower_ok && upper_ok, "FAIL_CERTIFICATE",
            paste("POST_S29", label, "is outside the exact prior interval"))
  E <- ea_q(1) - values$beta * (values$q - 1) / values$m
  S <- (ea_q(1) - values$nu) *
    (ea_q(1) - values$beta * values$o_0 -
       values$beta * (values$q - 2) / values$m) +
    values$nu * values$beta / values$m
  P <- ea_q(1) - values$beta * values$o_1 -
    values$beta * (values$q - 2) / values$m
  R <- values$beta / values$m
  branch_ok <- switch(specification$branch,
    E = E >= S && E >= P && E >= R,
    S = S >= E && S >= P && S >= R,
    P = P >= E && P >= S && P >= R,
    EP = E == P && E >= S && E >= R,
    FALSE)
  sc_assert(isTRUE(branch_ok), "FAIL_CERTIFICATE",
            paste("POST_S29", label, "does not witness its selected argmax"))
  if (!is.null(specification$tie)) {
    hE <- (ea_q(1) - values$nu) * values$o_0 + values$nu / values$m
    hP <- values$beta / values$m
    tie_ok <- switch(specification$tie,
      `h_E<h_P` = hE < hP, `h_P<h_E` = hP < hE, `h_E=h_P` = hE == hP,
      FALSE)
    sc_assert(isTRUE(tie_ok), "FAIL_CERTIFICATE",
              paste("POST_S29", label, "does not witness its residual H tie relation"))
  }
  invisible(TRUE)
}

pk_assert_nonvacuity_layer <- function(regions, partition_witnesses, pbe_witnesses) {
  registry <- pk_s29_nonvacuity_registry_v1()
  lint <- pk_s29_nonvacuity_registry_lint(registry)
  sc_assert(length(regions) == 11L && length(partition_witnesses) == 11L &&
              length(pbe_witnesses) == 11L,
            "FAIL_COVERAGE", "POST_S29 nonvacuity layer is not an 11-cell bijection")
  for (index in seq_len(11L)) {
    specification <- registry[[index]]
    pbe <- pbe_witnesses[[index]]
    sc_assert(identical(pbe$witness_id, specification$witness_id) &&
                identical(pk_canonical_json(pk_public_value(pbe$region)),
                          pk_canonical_json(pk_public_value(regions[[index]]))) &&
                identical(pk_canonical_json(pk_public_value(pbe$domain_witness)),
                          pk_canonical_json(pk_public_value(partition_witnesses[[index]]))),
              "FAIL_BINDING", paste("POST_S29 domain witness binding changed at", index))
    pk_assert_nonvacuity_witness_independent(
      regions[[index]], partition_witnesses[[index]], specification,
      paste0("witness ", index))
  }
  list(status = "NONVACUITY_REPLAYED", witness_count = 11L,
       registry_sha256 = lint$sha256,
       witness_hashes = as.list(vapply(partition_witnesses, pk_object_hash,
                                       character(1))))
}

pk_validate_partition <- function(regions) {
  sc_assert(length(regions) == 11L, "FAIL_CERTIFICATE",
            "algorithmic order/prior split did not produce eleven regions")
  sc_assert(length(unique(vapply(regions, pk_object_hash, character(1)))) == length(regions),
            "FAIL_CERTIFICATE", "duplicate semantic region")
  cases <- pk_order_cases()
  labels <- vapply(seq_len(nrow(cases)), function(row) pk_order_label(cases$r0[[row]], cases$r1[[row]]),
                   character(1))
  sc_assert(setequal(unique(vapply(regions, `[[`, character(1), "order_case")), labels),
            "FAIL_CERTIFICATE", "outside-option partition is incomplete")
  for (label in labels) {
    group <- regions[vapply(regions, function(r) r$order_case == label, logical(1))]
    interval_hash <- vapply(group, function(r) pk_object_hash(r$prior), character(1))
    unique_intervals <- group[!duplicated(interval_hash)]
    if (length(unique_intervals) == 1L) {
      interval <- unique_intervals[[1L]]$prior
      sc_assert(identical(interval$lower, "0") && identical(interval$upper, "1") &&
                  isTRUE(interval$lower_closed) && isTRUE(interval$upper_closed),
                "FAIL_CERTIFICATE", paste("single interval is not [0,1] in", label))
    } else {
      sc_assert(length(unique_intervals) == 2L, "FAIL_CERTIFICATE",
                paste("prior partition has wrong cardinality in", label))
      intervals <- lapply(unique_intervals, `[[`, "prior")
      lower_index <- which(vapply(intervals, function(x) identical(x$lower, "0") &&
                                    isTRUE(x$lower_closed), logical(1)))
      upper_index <- which(vapply(intervals, function(x) identical(x$upper, "1") &&
                                    isTRUE(x$upper_closed), logical(1)))
      sc_assert(length(lower_index) == 1L && length(upper_index) == 1L,
                "FAIL_CERTIFICATE", paste("prior endpoints are not uniquely owned in", label))
      lower <- intervals[[lower_index[[1L]]]]
      upper <- intervals[[upper_index[[1L]]]]
      sc_assert(!is.null(lower) && !is.null(upper) && identical(lower$upper, upper$lower) &&
                  isTRUE(lower$upper_closed) && !isTRUE(upper$lower_closed),
                "FAIL_CERTIFICATE", paste("intervals overlap or leave a gap in", label))
    }
  }
  tie_regions <- regions[vapply(regions, function(r) !is.null(r$tie), logical(1))]
  sc_assert(setequal(vapply(tie_regions, `[[`, character(1), "tie"),
                           c("h_E<h_P", "h_P<h_E", "h_E=h_P")),
            "FAIL_CERTIFICATE", "residual E/P tie partition is incomplete")
  witnesses <- lapply(regions, pk_region_domain_witness)
  list(kind = "partition", region_count = length(regions),
       order_case_count = length(labels), prior_union = "[0,1]",
       intersections_empty = TRUE, union_exhaustive = TRUE,
       endpoint_ownership = "lower_closed", tie_relation_partition = TRUE,
       exact_nonvacuity_witnesses = witnesses)
}

pk_assert_partition_invariants <- function(value, regions, core) {
  pk_assert_argmax_regions_independent(regions, core)
  labels <- vapply(seq_len(nrow(pk_order_cases())), function(row) {
    cases <- pk_order_cases()
    pk_order_label(cases$r0[[row]], cases$r1[[row]])
  }, character(1))
  witnesses <- lapply(regions, pk_region_domain_witness)
  expected <- list(
    kind = "partition", region_count = length(regions),
    order_case_count = length(labels), prior_union = "[0,1]",
    intersections_empty = TRUE, union_exhaustive = TRUE,
    endpoint_ownership = "lower_closed", tie_relation_partition = TRUE,
    exact_nonvacuity_witnesses = witnesses
  )
  sc_assert(identical(pk_canonical_json(pk_public_value(value)),
                      pk_canonical_json(pk_public_value(expected))),
            "FAIL_CERTIFICATE",
            "partition count, union, intersections, endpoint ownership, ties, or witnesses changed")
  invisible(TRUE)
}

pk_validate_saturated_budget <- function(witness, expected_outcome, weak_price, sorts, quota) {
  sc_assert(identical(witness$kind, "budget_witness") &&
              identical(witness$outcome, expected_outcome),
            "FAIL_CERTIFICATE", paste("wrong budget witness for", expected_outcome))
  sc_assert(ea_rat_equal(witness$weak_price$rational, weak_price$rational),
            "FAIL_CERTIFICATE", "budget weak price differs from replayed continuation")
  total <- pk_formula(pk_add(witness$y,
                             pk_add(pk_mul(witness$weak_count, weak_price$ast),
                                    witness$residual$ast)), "FEASIBILITY")
  pk_assert_formula_equivalent(total, pk_num(1), paste(expected_outcome, "budget"))
  sc_assert(identical(sc_ast_canonical(witness$slack), sc_ast_canonical(pk_num(0))),
            "FAIL_CERTIFICATE", paste(expected_outcome, "budget has nonzero slack"))
  denominator <- pk_assert_only_positive_m_divisors(
    list(weak_price, witness$residual), sorts, quota)
  list(kind = "budget_certificate", outcome = expected_outcome, total = total,
       slack = witness$slack, denominator = denominator,
       full_pie_reason = "exact_budget_identity_and_zero_slack")
}

pk_assert_budget_witness_complete <- function(witness, outcome, expected_y,
                                              expected_count, expected_residual,
                                              expected_price, label) {
  sc_assert(is.list(witness) && identical(witness$kind, "budget_witness") &&
              identical(witness$outcome, outcome),
            "FAIL_CERTIFICATE", paste(label, "has a wrong budget identity"))
  sc_assert(identical(sc_ast_canonical(witness$y), sc_ast_canonical(expected_y)) &&
              identical(sc_ast_canonical(witness$weak_count),
                        sc_ast_canonical(expected_count)) &&
              identical(sc_ast_canonical(witness$slack), sc_ast_canonical(pk_num(0))),
            "FAIL_CERTIFICATE", paste(label, "changed y, coalition size, or slack"))
  pk_assert_formula_equivalent(witness$weak_price, expected_price$ast,
                               paste(label, "weak price"))
  pk_assert_formula_equivalent(witness$residual, expected_residual$ast,
                               paste(label, "residual"))
  invisible(TRUE)
}

pk_feasibility_from_budgets <- function(refs, primitives, sorts, n1) {
  c_value <- refs[[1L]]; quota <- refs[[4L]]
  E <- refs[[5L]]; L <- refs[[6L]]; P <- refs[[7L]]
  D <- refs[[8L]]; argmax <- refs[[9L]]
  core <- pk_expected_core(primitives, sorts, n1)
  pk_assert_formula_equivalent(c_value, core$c_value$ast, "feasibility continuation")
  pk_assert_formula_equivalent(refs[[2L]], core$a0$ast, "feasibility low cutoff")
  pk_assert_formula_equivalent(refs[[3L]], core$a1$ast, "feasibility high cutoff")
  pk_assert_quota(quota, primitives, sorts)
  pk_assert_budget_witness_complete(E, "exclude_H", pk_num(0),
                                    core$quota$exclude_weak_votes, core$E,
                                    core$c_value, "feasibility E budget")
  pk_assert_budget_witness_complete(L, "low_only", core$a0$ast,
                                    core$quota$include_weak_votes, core$L,
                                    core$c_value, "feasibility S budget")
  pk_assert_budget_witness_complete(P, "pooling", core$a1$ast,
                                    core$quota$include_weak_votes, core$P,
                                    core$c_value, "feasibility P budget")
  sc_assert(identical(D$kind, "strict_sign") && identical(D$relation, ">0") &&
              identical(D$domain, core$strict$domain) &&
              identical(D$inequality_chain, core$strict$inequality_chain) &&
              identical(D$denominator, core$strict$denominator),
            "FAIL_CERTIFICATE", "feasibility strict-sign proof shape differs from replay")
  pk_assert_formula_equivalent(D$formula, core$strict$formula$ast,
                               "feasibility strict-sign formula")
  pk_assert_argmax_complete(argmax, core, sorts)
  base <- list(
    E = pk_validate_saturated_budget(E, "exclude_H", c_value, sorts, quota),
    S = pk_validate_saturated_budget(L, "low_only", c_value, sorts, quota),
    P = pk_validate_saturated_budget(P, "pooling", c_value, sorts, quota)
  )
  q <- pk_sym("q", sorts); m <- pk_sym("m", sorts); beta <- pk_sym("beta", sorts)
  o0 <- pk_sym("o_0", sorts); o1 <- pk_sym("o_1", sorts)
  w <- pk_div(pk_num(1), m)
  pk_assert_formula_equivalent(E$residual,
    pk_sub(pk_num(1), pk_mul(pk_sub(q, pk_num(1)), c_value$ast)), "E residual")
  pk_assert_formula_equivalent(L$residual,
    pk_sub(pk_num(1), pk_add(pk_mul(beta, o0),
                             pk_mul(pk_sub(q, pk_num(2)), c_value$ast))), "S residual")
  pk_assert_formula_equivalent(P$residual,
    pk_sub(pk_num(1), pk_add(pk_mul(beta, o1),
                             pk_mul(pk_sub(q, pk_num(2)), c_value$ast))), "P residual")
  pk_assert_formula_equivalent(E$residual, pk_add(c_value$ast, D$formula$ast),
                               "E positive decomposition")
  L_minus_E <- pk_formula(pk_sub(L$residual$ast, E$residual$ast), "FEASIBILITY")
  P_minus_E <- pk_formula(pk_sub(P$residual$ast, E$residual$ast), "FEASIBILITY")
  pk_assert_formula_equivalent(L_minus_E, pk_mul(beta, pk_sub(w, o0)),
                               "L-E feasibility margin")
  pk_assert_formula_equivalent(P_minus_E, pk_mul(beta, pk_sub(w, o1)),
                               "P-E feasibility margin")
  certificates <- lapply(seq_along(argmax$regions), function(index) {
    region <- argmax$regions[[index]]
    selected <- switch(region$branch, E = "E", S = "S", P = "P", EP = c("E", "P"),
                       sc_abort("FAIL_CERTIFICATE", "unknown selected feasibility branch"))
    if ("S" %in% selected) {
      sc_assert(region$order_case %in% c("o_0<o_1<1/m", "o_0<1/m<o_1",
                                         "o_0=1/m<o_1", "o_0<o_1=1/m"),
                "FAIL_CERTIFICATE", "screening selected where its residual sign is unproved")
    }
    if ("P" %in% selected) {
      sc_assert(region$order_case %in% c("o_0<o_1<1/m", "o_0<o_1=1/m"),
                "FAIL_CERTIFICATE", "pooling selected where its residual sign is unproved")
    }
    list(witness_id = paste0("FEAS-", index), region_hash = pk_object_hash(region),
         branch = region$branch, budgets = base[selected],
         nonnegativity = list(
           weak_price = list(expression = c_value$normal_form, derivation = "beta>0,m>=2"),
           weak_count = list(expression = if ("E" %in% selected) "q-1" else "q-2",
                             derivation = "q>=2"),
           residual = list(derivation = if (region$branch == "E")
             "E=R+D with R>0,D>0" else if (region$branch == "S")
               "L=E+beta*(1/m-o_0) on selected order domain" else
               "P=E+beta*(1/m-o_1) on selected order domain"),
           concession = list(derivation = if (region$branch == "E") "y=0" else
             "0<beta*o_theta<o_theta<=y_bar")))
  })
  list(kind = "feasibility", base_budgets = base, witnesses = certificates,
       witness_count = length(certificates))
}

pk_assert_feasibility_invariants <- function(value, core, sorts) {
  sc_assert(is.list(value) &&
              identical(names(value),
                        c("kind", "base_budgets", "witnesses", "witness_count")) &&
              identical(value$kind, "feasibility") &&
              identical(names(value$base_budgets), c("E", "S", "P")) &&
              identical(value$witness_count, length(core$regions)) &&
              length(value$witnesses) == length(core$regions),
            "FAIL_CERTIFICATE", "feasibility coverage or schema changed")
  budget_witnesses <- list(
    E = pk_core_budget_witness(core, "exclude_H"),
    S = pk_core_budget_witness(core, "low_only"),
    P = pk_core_budget_witness(core, "pooling")
  )
  expected_base <- list(
    E = pk_validate_saturated_budget(budget_witnesses$E, "exclude_H",
                                     core$c_value, sorts, core$quota),
    S = pk_validate_saturated_budget(budget_witnesses$S, "low_only",
                                     core$c_value, sorts, core$quota),
    P = pk_validate_saturated_budget(budget_witnesses$P, "pooling",
                                     core$c_value, sorts, core$quota)
  )
  sc_assert(identical(pk_canonical_json(pk_public_value(value$base_budgets)),
                      pk_canonical_json(pk_public_value(expected_base))),
            "FAIL_CERTIFICATE", "feasibility base budgets are not exact full-pie identities")
  for (index in seq_along(core$regions)) {
    region <- core$regions[[index]]; witness <- value$witnesses[[index]]
    selected <- switch(region$branch, E = "E", S = "S", P = "P",
                       EP = c("E", "P"),
                       sc_abort("FAIL_CERTIFICATE", "unknown feasibility branch"))
    residual_reason <- if (region$branch == "E") {
      "E=R+D with R>0,D>0"
    } else if (region$branch == "S") {
      "L=E+beta*(1/m-o_0) on selected order domain"
    } else {
      "P=E+beta*(1/m-o_1) on selected order domain"
    }
    expected <- list(
      witness_id = paste0("FEAS-", index),
      region_hash = pk_object_hash(region), branch = region$branch,
      budgets = expected_base[selected],
      nonnegativity = list(
        weak_price = list(expression = core$c_value$normal_form,
                          derivation = "beta>0,m>=2"),
        weak_count = list(expression = if ("E" %in% selected) "q-1" else "q-2",
                          derivation = "q>=2"),
        residual = list(derivation = residual_reason),
        concession = list(derivation = if (region$branch == "E") "y=0" else
          "0<beta*o_theta<o_theta<=y_bar")
      )
    )
    sc_assert(identical(pk_canonical_json(pk_public_value(witness)),
                        pk_canonical_json(pk_public_value(expected))),
              "FAIL_CERTIFICATE",
              paste("feasibility witness", index,
                    "changed its budget, branch, or nonnegativity derivation"))
  }
  invisible(TRUE)
}

pk_tie_break_from_payoffs <- function(refs, primitives, sorts, n1) {
  a0 <- refs[[1L]]; a1 <- refs[[2L]]; E <- refs[[3L]]$residual
  L <- refs[[4L]]$residual; P <- refs[[5L]]$residual; S <- refs[[6L]]
  argmax <- refs[[7L]]
  core <- pk_expected_core(primitives, sorts, n1)
  pk_assert_formula_equivalent(a0, core$a0$ast, "tie-break low continuation")
  pk_assert_formula_equivalent(a1, core$a1$ast, "tie-break high continuation")
  pk_assert_formula_equivalent(E, core$E$ast, "tie-break E payoff")
  pk_assert_formula_equivalent(L, core$L$ast, "tie-break S low payoff")
  pk_assert_formula_equivalent(P, core$P$ast, "tie-break P payoff")
  pk_assert_formula_equivalent(S, core$S$ast, "tie-break S expected payoff")
  pk_assert_argmax_complete(argmax, core, sorts)
  sc_assert(identical(argmax$kind, "argmax_correspondence") &&
              identical(primitives$axioms$solution$proposal_tie_break, "min_expected_H"),
            "FAIL_CERTIFICATE", "tie-break rule or argmax premise changed")
  nu <- pk_sym("nu", sorts); beta <- pk_sym("beta", sorts)
  o0 <- pk_sym("o_0", sorts); o1 <- pk_sym("o_1", sorts)
  one <- pk_num(1); m <- pk_sym("m", sorts)
  pk_assert_formula_equivalent(a0, pk_mul(beta, o0), "H theta-0 continuation")
  pk_assert_formula_equivalent(a1, pk_mul(beta, o1), "H theta-1 continuation")
  pk_assert_formula_equivalent(S,
    pk_add(pk_mul(pk_sub(one, nu), L$ast),
           pk_mul(nu, pk_div(beta, m))), "screening proposer payoff")
  hE <- pk_formula(pk_add(pk_mul(pk_sub(one, nu), o0), pk_mul(nu, o1)), "TIE_BREAK")
  hS <- pk_formula(pk_add(pk_mul(pk_sub(one, nu), a0$ast), pk_mul(nu, a1$ast)),
                    "TIE_BREAK")
  hP <- a1
  hP_minus_hS <- pk_formula(pk_sub(hP$ast, hS$ast), "TIE_BREAK")
  hE_minus_hS <- pk_formula(pk_sub(hE$ast, hS$ast), "TIE_BREAK")
  pk_assert_formula_equivalent(hP_minus_hS,
    pk_mul(pk_sub(one, nu), pk_sub(a1$ast, a0$ast)), "hP-hS")
  pk_assert_formula_equivalent(hE_minus_hS,
    pk_mul(pk_sub(one, beta), hE$ast), "hE-hS")
  proposer_SP <- pk_formula(pk_sub(S$ast, P$ast), "TIE_BREAK")
  proposer_SE <- pk_formula(pk_sub(S$ast, E$ast), "TIE_BREAK")
  proposer_PE <- pk_formula(pk_sub(P$ast, E$ast), "TIE_BREAK")
  reconstructed_SP <- pk_formula(pk_sub(argmax$candidates$S$ast,
                                        argmax$candidates$P$ast), "TIE_BREAK")
  reconstructed_SE <- pk_formula(pk_sub(argmax$candidates$S$ast,
                                        argmax$candidates$E$ast), "TIE_BREAK")
  sc_assert(ea_rat_equal(proposer_SP$rational, reconstructed_SP$rational) &&
              ea_rat_equal(proposer_SE$rational, reconstructed_SE$rational),
            "FAIL_CERTIFICATE", "tie expressions differ from replayed argmax candidates")
  solved_SP <- pk_solve_affine_zero(proposer_SP, "nu")
  solved_SE <- pk_solve_affine_zero(proposer_SE, "nu")
  sc_assert(ea_rat_equal(solved_SP$rational, argmax$frontier_SP$rational) &&
              ea_rat_equal(solved_SE$rational, argmax$frontier_SE$rational),
            "FAIL_CERTIFICATE", "proposer tie locus differs from replayed frontier")
  expected_PE <- pk_mul(beta, pk_sub(pk_div(one, m), o1))
  pk_assert_formula_equivalent(proposer_PE, expected_PE, "P-E")
  PE_on_equality <- pk_formula(pk_ast_substitute(proposer_PE$ast, "o_1",
                                                 pk_div(one, m)), "TIE_BREAK")
  pk_assert_formula_equivalent(PE_on_equality, pk_num(0), "P-E on o_1=1/m")
  hE_minus_hP_raw <- pk_formula(pk_sub(hE$ast, hP$ast), "TIE_BREAK")
  hE_minus_hP <- pk_formula(pk_ast_substitute(hE_minus_hP_raw$ast, "o_1",
                                              pk_div(one, m)), "TIE_BREAK")
  pk_assert_formula_equivalent(hE_minus_hP,
    pk_sub(pk_add(pk_mul(pk_sub(one, nu), o0), pk_div(nu, m)),
           pk_div(beta, m)), "hE-hP on o_1=1/m")
  tie_regions <- argmax$regions[vapply(argmax$regions, function(region) !is.null(region$tie),
                                       logical(1))]
  sc_assert(length(tie_regions) == 3L &&
              setequal(vapply(tie_regions, `[[`, character(1), "tie"),
                       c("h_E<h_P", "h_P<h_E", "h_E=h_P")),
            "FAIL_CERTIFICATE", "residual H-payoff trichotomy is incomplete")
  for (region in tie_regions) {
    expected_branch <- switch(region$tie, `h_E<h_P` = "E", `h_P<h_E` = "P",
                              `h_E=h_P` = "EP")
    sc_assert(identical(region$branch, expected_branch), "FAIL_CERTIFICATE",
              "minimum-H tie-break selected the wrong branch")
  }
  list(
    kind = "tie_break",
    proposer_ties = list(
      S_equals_P = list(difference = proposer_SP,
                        frontier = argmax$frontier_SP$normal_form,
                        selected = "S", H_margin = hP_minus_hS,
                        sign_certificate = list(
                          factors = as.list(c("1-nu", "beta", "o_1-o_0")),
                          domain_sources = list(root = argmax$frontier_SP$sign_certificate,
                                                primitives = "0<beta and o_0<o_1"))),
      S_equals_E = list(difference = proposer_SE,
                        frontier = argmax$frontier_SE$normal_form,
                        selected = "S", H_margin = hE_minus_hS,
                        sign_certificate = list(
                          factors = as.list(c("1-beta", "h_E")),
                          domain_sources = "beta<1 and h_E>0 from o_0>0")),
      E_equals_P = list(difference = proposer_PE,
                        exact_zero_under_domain = PE_on_equality,
                        H_E = hE, H_P = hP, H_difference = hE_minus_hP,
                        H_trichotomy = as.list(c("h_E<h_P", "h_P<h_E", "h_E=h_P")),
                        selected_by_relation = list(`h_E<h_P` = "E",
                                                    `h_P<h_E` = "P",
                                                    `h_E=h_P` = "all_E_P_mixtures"))
    ),
    residual_tie_region_hashes = as.list(vapply(tie_regions, pk_object_hash, character(1)))
  )
}

pk_assert_tie_invariants <- function(value, core, argmax, sorts) {
  nu <- pk_sym("nu", sorts); beta <- pk_sym("beta", sorts)
  o0 <- pk_sym("o_0", sorts); o1 <- pk_sym("o_1", sorts)
  one <- pk_num(1); m <- pk_sym("m", sorts)
  hE <- pk_formula(pk_add(pk_mul(pk_sub(one, nu), o0), pk_mul(nu, o1)), "TIE_BREAK")
  hS <- pk_formula(pk_add(pk_mul(pk_sub(one, nu), core$a0$ast),
                           pk_mul(nu, core$a1$ast)), "TIE_BREAK")
  hP <- core$a1
  hP_minus_hS <- pk_formula(pk_sub(hP$ast, hS$ast), "TIE_BREAK")
  hE_minus_hS <- pk_formula(pk_sub(hE$ast, hS$ast), "TIE_BREAK")
  proposer_SP <- pk_formula(pk_sub(core$S$ast, core$P$ast), "TIE_BREAK")
  proposer_SE <- pk_formula(pk_sub(core$S$ast, core$E$ast), "TIE_BREAK")
  proposer_PE <- pk_formula(pk_sub(core$P$ast, core$E$ast), "TIE_BREAK")
  PE_on_equality <- pk_formula(pk_ast_substitute(
    proposer_PE$ast, "o_1", pk_div(one, m)), "TIE_BREAK")
  hE_minus_hP_raw <- pk_formula(pk_sub(hE$ast, hP$ast), "TIE_BREAK")
  hE_minus_hP <- pk_formula(pk_ast_substitute(
    hE_minus_hP_raw$ast, "o_1", pk_div(one, m)), "TIE_BREAK")
  tie_regions <- argmax$regions[vapply(argmax$regions, function(region) {
    !is.null(region$tie)
  }, logical(1))]
  expected <- list(
    kind = "tie_break",
    proposer_ties = list(
      S_equals_P = list(
        difference = proposer_SP, frontier = core$frontier_SP$normal_form,
        selected = "S", H_margin = hP_minus_hS,
        sign_certificate = list(
          factors = as.list(c("1-nu", "beta", "o_1-o_0")),
          domain_sources = list(root = core$frontier_SP$sign_certificate,
                                primitives = "0<beta and o_0<o_1"))
      ),
      S_equals_E = list(
        difference = proposer_SE, frontier = core$frontier_SE$normal_form,
        selected = "S", H_margin = hE_minus_hS,
        sign_certificate = list(
          factors = as.list(c("1-beta", "h_E")),
          domain_sources = "beta<1 and h_E>0 from o_0>0")
      ),
      E_equals_P = list(
        difference = proposer_PE, exact_zero_under_domain = PE_on_equality,
        H_E = hE, H_P = hP, H_difference = hE_minus_hP,
        H_trichotomy = as.list(c("h_E<h_P", "h_P<h_E", "h_E=h_P")),
        selected_by_relation = list(`h_E<h_P` = "E", `h_P<h_E` = "P",
                                    `h_E=h_P` = "all_E_P_mixtures")
      )
    ),
    residual_tie_region_hashes = as.list(vapply(tie_regions, pk_object_hash, character(1)))
  )
  sc_assert(identical(pk_canonical_json(pk_public_value(value)),
                      pk_canonical_json(pk_public_value(expected))),
            "FAIL_CERTIFICATE",
            "tie-break formula, frontier ownership, H trichotomy, or selection changed")
  invisible(TRUE)
}

pk_player_binder <- function(variable = "b1", source = "i") {
  list(kind = "binder", variable = variable, variable_sort = "Player",
       source_variable = source, domain = sc_set_W(), constraints = list())
}

pk_coalition_binder <- function(source, variable, outer_player, offset,
                                require_member_l = FALSE) {
  constraints <- list(list(
    kind = "cardinality_constraint", sort = "Proposition",
    set = sc_bound(variable, "FiniteSet<Player>"), equals = sc_q_minus(offset)))
  if (isTRUE(require_member_l)) {
    constraints[[2L]] <- list(
      kind = "membership_constraint", sort = "Proposition",
      element = sc_ast("symbol", name = "l", sort = "Player"),
      container = sc_bound(variable, "FiniteSet<Player>"))
  }
  list(kind = "binder", variable = variable, variable_sort = "FiniteSet<Player>",
       source_variable = source, domain = sc_W_without(outer_player),
       constraints = constraints)
}

pk_indexed_weight <- function(family, proposer, coalition) {
  list(kind = "indexed_symbol", sort = "Probability", family = family,
       indices = as.list(c(proposer, coalition)))
}

pk_sum_over <- function(binder, body) {
  list(kind = "indexed_sum", sort = "Real", binder = binder, body = body)
}

pk_forall <- function(binder, body) {
  list(kind = "quantifier", quantifier = "forall", sort = "Proposition",
       binder = binder, body = body)
}

# Literal AST constructors used only by the independent indexed checkers.
# They intentionally do not call pk_coalition_binder, pk_indexed_weight,
# pk_membership_weight_sum, or pk_plain_weight_sum.
pk_literal_bound <- function(name, sort) {
  list(kind = "bound_symbol", sort = sort, name = name)
}

pk_literal_W <- function() {
  list(kind = "set_symbol", sort = "Set<Player>", name = "W")
}

pk_literal_W_without <- function(player) {
  list(kind = "set_difference", sort = "Set<Player>", left = pk_literal_W(),
       right = list(kind = "singleton", sort = "Set<Player>",
                    element = pk_literal_bound(player, "Player")))
}

pk_literal_q_minus <- function(offset) {
  list(kind = "binary", sort = "Integer", operator = "-",
       left = list(kind = "symbol", sort = "Integer", name = "q"),
       right = list(kind = "number", sort = "Rational",
                    value = as.character(offset)))
}

pk_literal_coalition_binder <- function(source, variable, proposer, offset,
                                        require_member_l = FALSE) {
  constraints <- list(list(
    kind = "cardinality_constraint", sort = "Proposition",
    set = pk_literal_bound(variable, "FiniteSet<Player>"),
    equals = pk_literal_q_minus(offset)))
  if (isTRUE(require_member_l)) {
    constraints[[2L]] <- list(
      kind = "membership_constraint", sort = "Proposition",
      element = list(kind = "symbol", sort = "Player", name = "l"),
      container = pk_literal_bound(variable, "FiniteSet<Player>"))
  }
  list(kind = "binder", variable = variable, variable_sort = "FiniteSet<Player>",
       source_variable = source, domain = pk_literal_W_without(proposer),
       constraints = constraints)
}

pk_literal_indexed_weight <- function(family, proposer, coalition) {
  list(kind = "indexed_symbol", sort = "Probability", family = family,
       indices = as.list(c(proposer, coalition)))
}

pk_literal_sum <- function(binder, body) {
  list(kind = "indexed_sum", sort = "Real", binder = binder, body = body)
}

pk_literal_membership_weight_sum <- function(family, offset, proposer = "b1",
                                             coalition = "b2") {
  source <- if (offset == 1L) "K" else "T"
  binder <- pk_literal_coalition_binder(source, coalition, proposer, offset, TRUE)
  pk_literal_sum(binder, pk_literal_indexed_weight(family, proposer, coalition))
}

pk_literal_plain_weight_sum <- function(family, offset, proposer = "b1",
                                        coalition = "b2") {
  source <- if (offset == 1L) "K" else "T"
  binder <- pk_literal_coalition_binder(source, coalition, proposer, offset, FALSE)
  pk_literal_sum(binder, pk_literal_indexed_weight(family, proposer, coalition))
}

pk_literal_other_player_binder <- function() {
  list(kind = "binder", variable = "b1", variable_sort = "Player",
       source_variable = "i", domain = pk_literal_W(), constraints = list(list(
         kind = "not_equal_constraint", sort = "Proposition",
         left = pk_literal_bound("b1", "Player"),
         right = list(kind = "symbol", sort = "Player", name = "l"))))
}

pk_simplex_for_branch <- function(branch) {
  i_binder <- pk_player_binder("b1", "i")
  make_family <- function(source, variable, offset, family) {
    binder <- pk_coalition_binder(source, variable, "b1", offset)
    weight <- pk_indexed_weight(family, "b1", variable)
    nonnegative <- pk_forall(binder, sc_ast(
      "compare", operator = ">=", left = weight,
      right = sc_ast("number", value = "0", sort = "Rational"),
      sort = "Proposition"))
    list(binder = binder, weight = weight, sum = pk_sum_over(binder, weight),
         nonnegative = nonnegative, family = family, offset = offset)
  }
  families <- if (branch == "EP") {
    list(make_family("K", "b2", 1L, "e"), make_family("T", "b3", 2L, "p"))
  } else if (branch == "E") {
    list(make_family("K", "b2", 1L, "omega"))
  } else if (branch %in% c("S", "P")) {
    list(make_family("K", "b2", 2L, "omega"))
  } else sc_abort("FAIL_CERTIFICATE", "unknown simplex branch")
  total <- families[[1L]]$sum
  if (length(families) == 2L) {
    total <- sc_ast("binary", operator = "+", left = total, right = families[[2L]]$sum,
                    sort = "Real")
  }
  normalization <- pk_forall(i_binder, sc_ast(
    "compare", operator = "=", left = total,
    right = sc_ast("number", value = "1", sort = "Rational"),
    sort = "Proposition"))
  nonnegative <- lapply(families, function(family) pk_forall(i_binder, family$nonnegative))
  list(kind = "identity_simplex", branch = branch, proposer_binder = i_binder,
       support_families = lapply(families, function(family) {
         family[c("binder", "weight", "sum", "family", "offset")]
       }),
       nonnegative = nonnegative, normalization = normalization,
       normalization_nf = sc_indexed_canonical(normalization),
       pure_vertices = list(kind = "cartesian_identity_assignment",
                            one_support_element_per_proposer = "independently chosen"),
       mixture_space = list(kind = "full_labeled_simplex",
                            cross_identity_constraints = list()),
       support_nonempty_derivation = lapply(families, function(family) {
         if (family$offset == 1L) as.list(c("q<=m", "q-1<=m-1")) else
           as.list(c("q>=2", "q-2>=0", "q-2<=m-1"))
       }))
}

pk_simplexes_from_regions <- function(refs, primitives, sorts, n1) {
  quota <- refs[[1L]]; argmax <- refs[[2L]]; feasibility <- refs[[3L]]
  core <- pk_expected_core(primitives, sorts, n1)
  pk_assert_quota(quota, primitives, sorts)
  pk_assert_argmax_complete(argmax, core, sorts)
  pk_assert_feasibility_binding(feasibility, core)
  sc_assert(identical(argmax$kind, "argmax_correspondence") &&
              identical(feasibility$kind, "feasibility"),
            "FAIL_CERTIFICATE",
            "simplex rule lacks quota/argmax/feasibility premises")
  sc_assert(length(feasibility$witnesses) == length(argmax$regions), "FAIL_CERTIFICATE",
            "simplex rule received incomplete feasibility support")
  simplexes <- lapply(seq_along(argmax$regions), function(index) {
    region <- argmax$regions[[index]]
    witness <- feasibility$witnesses[[index]]
    sc_assert(identical(witness$region_hash, pk_object_hash(region)) &&
                identical(witness$branch, region$branch),
              "FAIL_CERTIFICATE", "simplex region is not bound to feasibility witness")
    simplex <- pk_simplex_for_branch(region$branch)
    free <- ea_ast_free_symbols(simplex$normalization)
    sc_assert(all(free %in% c("W", "q")), "FAIL_CERTIFICATE",
              "simplex normalization introduced unauthorized free symbols")
    list(region_hash = witness$region_hash, branch = region$branch, simplex = simplex)
  })
  list(kind = "identity_simplexes", per_region = simplexes,
       count = length(simplexes), recognition = "iid_uniform_1_over_m",
       identity_symmetry_constraints = list())
}

pk_bayes_fraction <- function(prior_one, likelihood_zero, likelihood_one, rule = "BAYES") {
  one <- pk_num(1)
  numerator_one <- pk_formula(pk_mul(prior_one, likelihood_one), rule)
  numerator_zero <- pk_formula(pk_mul(pk_sub(one, prior_one), likelihood_zero), rule)
  denominator <- pk_formula(pk_add(numerator_zero$ast, numerator_one$ast), rule)
  posterior <- pk_formula(pk_div(numerator_one$ast, denominator$ast), rule)
  list(kind = "bayes_fraction", numerator_one = numerator_one,
       numerator_zero = numerator_zero, denominator = denominator, posterior = posterior)
}

pk_assert_bayes_posterior <- function(fraction, expected_ast, registry_kind,
                                      weak_br, H_br, simplexes, sorts) {
  nu <- pk_sym("nu", sorts); zero <- pk_num(0); one <- pk_num(1)
  if (identical(registry_kind, "positive_proposal_support")) {
    lambda <- sc_ast("symbol", name = "lambda_s", sort = "Probability")
    expected_denominator <- lambda
    constraints <- list(pk_compare(">", lambda, zero))
    fact_id <- "D.lambda_s.positive"
    steps <- c("S26", "S25")
    source <- simplexes
  } else if (identical(registry_kind, "low_only_failure_positive_mass")) {
    expected_denominator <- nu
    constraints <- list(pk_compare(">", nu, zero), pk_compare("<=", nu, one))
    fact_id <- "D.nu.positive_failure_history"
    steps <- c("S08", "S09", "S25")
    source <- list(weak_br = weak_br, H_br = H_br)
  } else if (identical(registry_kind, "low_only_pass_positive_mass")) {
    expected_denominator <- pk_sub(one, nu)
    constraints <- list(pk_compare(">=", nu, zero), pk_compare("<", nu, one))
    fact_id <- "D.one_minus_nu.positive_pass_history"
    steps <- c("S08", "S09", "S25")
    source <- list(weak_br = weak_br, H_br = H_br)
  } else sc_abort("FAIL_CERTIFICATE", "unknown closed Bayes denominator registry kind")
  pk_assert_formula_equivalent(fraction$denominator, expected_denominator,
                               paste(registry_kind, "denominator"))
  fact <- pk_trusted_domain_fact(
    fact_id, fraction$denominator$ast,
    pk_compare(">", fraction$denominator$ast, zero), constraints, steps, source)
  ea_validate_trusted_domain_fact(fact, fact$denominator_nf, registry_kind)
  divisors <- ea_ast_divisor_nfs(fraction$posterior$ast)
  sc_assert(length(divisors) == 1L && identical(divisors[[1L]], fact$denominator_nf),
            "FAIL_CERTIFICATE", "Bayes posterior uses an unproved denominator")
  sc_assert(ea_rat_equal(ea_ast_to_rat(fraction$posterior$ast),
                         ea_ast_to_rat(expected_ast)),
            "FAIL_EQUIVALENCE", paste(registry_kind, "posterior is algebraically wrong"))
  fact
}

pk_bayes_from_strategy_support <- function(refs, primitives, sorts, n1) {
  imported_o0 <- refs[[1L]]; imported_o1 <- refs[[2L]]
  weak_br <- refs[[3L]]; H_br <- refs[[4L]]; argmax <- refs[[5L]]
  feasibility <- refs[[6L]]; simplexes <- refs[[7L]]
  core <- pk_expected_core(primitives, sorts, n1)
  pk_assert_formula_equivalent(imported_o0, pk_sym("o_0", sorts),
                               "Bayes imported theta-0 payoff")
  pk_assert_formula_equivalent(imported_o1, pk_sym("o_1", sorts),
                               "Bayes imported theta-1 payoff")
  pk_assert_weak_br_complete(weak_br, core)
  pk_assert_H_br_complete(H_br, core, sorts)
  pk_assert_argmax_complete(argmax, core, sorts)
  pk_assert_feasibility_binding(feasibility, core)
  pk_assert_simplexes_complete(simplexes, core, feasibility)
  sc_assert(identical(weak_br$kind, "weak_best_response") &&
              identical(H_br$kind, "H_best_response") &&
              identical(argmax$kind, "argmax_correspondence") &&
              identical(feasibility$kind, "feasibility") &&
              identical(simplexes$kind, "identity_simplexes"),
            "FAIL_CERTIFICATE", "Bayes rule lacks typed strategy/support premises")
  sc_assert(length(argmax$regions) == length(feasibility$witnesses) &&
              length(argmax$regions) == length(simplexes$per_region),
            "FAIL_CERTIFICATE", "Bayes support coverage is incomplete")
  pk_assert_formula_equivalent(imported_o0, pk_sym("o_0", sorts), "imported H theta 0")
  pk_assert_formula_equivalent(imported_o1, pk_sym("o_1", sorts), "imported H theta 1")
  nu <- pk_sym("nu", sorts); one <- pk_num(1)
  lambda <- sc_ast("symbol", name = "lambda_s", sort = "Probability")
  proposal_update <- pk_bayes_fraction(nu, lambda, lambda)
  proposal_fact <- pk_assert_bayes_posterior(
    proposal_update, nu, "positive_proposal_support",
    weak_br, H_br, simplexes, sorts)
  proposal_update$denominator_certificate <- proposal_fact

  low_failure <- pk_bayes_fraction(nu, pk_num(0), pk_num(1))
  failure_fact <- pk_assert_bayes_posterior(
    low_failure, pk_num(1), "low_only_failure_positive_mass",
    weak_br, H_br, simplexes, sorts)
  low_failure$denominator_certificate <- failure_fact

  low_pass <- pk_bayes_fraction(nu, pk_num(1), pk_num(0))
  pass_fact <- pk_assert_bayes_posterior(
    low_pass, pk_num(0), "low_only_pass_positive_mass",
    weak_br, H_br, simplexes, sorts)
  low_pass$denominator_certificate <- pass_fact

  free_kappa <- list(kind = "free_probability", name = "kappa_i(s)",
                     domain = list(kind = "closed_interval", lower = "0", upper = "1"),
                     activation = "individual proposal has zero strategy mass")
  free_eta <- list(kind = "free_probability", name = "eta_i(s,v)",
                   domain = list(kind = "closed_interval", lower = "0", upper = "1"),
                   activation = "proposal-vote history has zero probability")
  region_updates <- lapply(seq_along(argmax$regions), function(index) {
    region <- argmax$regions[[index]]
    feasible <- feasibility$witnesses[[index]]
    simplex <- simplexes$per_region[[index]]
    region_hash <- pk_object_hash(region)
    sc_assert(identical(feasible$region_hash, region_hash) &&
                identical(simplex$region_hash, region_hash),
              "FAIL_CERTIFICATE", "Bayes update copied support from a different region")
    public_vote <- if (identical(region$branch, "S")) {
      list(kind = "separating_H_vote", weak_vote_likelihood_type_invariant = weak_br$cutoff,
           H_likelihoods = list(pass = list(theta_0 = "1", theta_1 = "0"),
                                failure = list(theta_0 = "0", theta_1 = "1")),
           positive_mass = list(pass = low_pass, failure = low_failure),
           endpoint_zero_mass = list(nu_0_failure = free_eta, nu_1_pass = free_eta))
    } else {
      list(kind = "nonseparating_H_vote",
           weak_vote_likelihood_type_invariant = weak_br$cutoff,
           posterior_on_positive_history = proposal_update,
           zero_mass_history = free_eta)
    }
    list(region_hash = region_hash, branch = region$branch,
         proposal_support_hash = pk_object_hash(simplex$simplex$normalization_nf),
         after_positive_mass_proposal = proposal_update,
         after_public_vote_vector = public_vote,
         zero_mass_proposal = free_kappa,
         deviating_proposer_prior = nu)
  })
  list(kind = "belief_system", per_region = region_updates,
       weak_strategy_type_independence = list(
         source = "single weak best-response map from x_j and frozen continuation",
         cutoff = weak_br$cutoff),
       endpoints = list(
         nu_0 = list(type_probabilities = list(theta_0 = "1", theta_1 = "0"),
                     zero_mass_type_1_histories = free_eta),
         nu_1 = list(type_probabilities = list(theta_0 = "0", theta_1 = "1"),
                     zero_mass_type_0_histories = free_eta)),
       imported_H_values = list(theta_0 = imported_o0, theta_1 = imported_o1))
}

pk_assert_free_probability <- function(value, expected_name, expected_activation, label) {
  sc_assert(is.list(value) && identical(value$kind, "free_probability") &&
              identical(value$name, expected_name) &&
              identical(value$domain,
                        list(kind = "closed_interval", lower = "0", upper = "1")) &&
              identical(value$activation, expected_activation),
            "FAIL_CERTIFICATE", paste(label, "is not unrestricted on [0,1]"))
  invisible(TRUE)
}

pk_assert_bayes_fraction_invariant <- function(value, prior, likelihood_zero,
                                               likelihood_one, expected_posterior,
                                               registry_kind, weak_br, H_br,
                                               simplexes, sorts, label) {
  sc_assert(is.list(value) && identical(value$kind, "bayes_fraction") &&
              identical(names(value), c("kind", "numerator_one", "numerator_zero",
                                         "denominator", "posterior",
                                         "denominator_certificate")),
            "FAIL_CERTIFICATE", paste(label, "Bayes fraction schema changed"))
  one <- pk_num(1)
  pk_assert_formula_equivalent(value$numerator_one, pk_mul(prior, likelihood_one),
                               paste(label, "type-one numerator"))
  pk_assert_formula_equivalent(value$numerator_zero,
                               pk_mul(pk_sub(one, prior), likelihood_zero),
                               paste(label, "type-zero numerator"))
  pk_assert_formula_equivalent(value$denominator,
                               pk_add(value$numerator_zero$ast,
                                      value$numerator_one$ast),
                               paste(label, "denominator sum"))
  expected_fact <- pk_assert_bayes_posterior(
    value, expected_posterior, registry_kind, weak_br, H_br, simplexes, sorts)
  sc_assert(identical(pk_canonical_json(pk_public_value(value$denominator_certificate)),
                      pk_canonical_json(pk_public_value(expected_fact))),
            "FAIL_CERTIFICATE", paste(label, "denominator provenance changed"))
  invisible(TRUE)
}

pk_assert_belief_invariants <- function(value, core, weak_br, H_br, argmax,
                                        feasibility, simplexes, sorts) {
  sc_assert(is.list(value) && identical(value$kind, "belief_system") &&
              length(value$per_region) == length(core$regions),
            "FAIL_CERTIFICATE", "belief system has malformed region coverage")
  one <- pk_num(1); zero <- pk_num(0); nu <- pk_sym("nu", sorts)
  lambda <- sc_ast("symbol", name = "lambda_s", sort = "Probability")
  pk_assert_formula_equivalent(value$weak_strategy_type_independence$cutoff,
                               core$c_value$ast, "belief weak-strategy cutoff")
  sc_assert(identical(value$weak_strategy_type_independence$source,
    "single weak best-response map from x_j and frozen continuation"),
    "FAIL_CERTIFICATE", "weak type-independence source changed")
  pk_assert_formula_equivalent(value$imported_H_values$theta_0,
                               core$imported_o0$ast, "belief imported H0")
  pk_assert_formula_equivalent(value$imported_H_values$theta_1,
                               core$imported_o1$ast, "belief imported H1")
  for (index in seq_along(core$regions)) {
    region <- core$regions[[index]]; update <- value$per_region[[index]]
    region_hash <- pk_object_hash(region)
    sc_assert(identical(update$region_hash, region_hash) &&
                identical(update$branch, region$branch) &&
                identical(update$proposal_support_hash,
                          pk_object_hash(simplexes$per_region[[index]]$simplex$normalization_nf)) &&
                identical(sc_ast_canonical(update$deviating_proposer_prior),
                          sc_ast_canonical(nu)),
              "FAIL_CERTIFICATE", "belief record is not bound to its region/support/prior")
    pk_assert_bayes_fraction_invariant(
      update$after_positive_mass_proposal, nu, lambda, lambda, nu,
      "positive_proposal_support", weak_br, H_br, simplexes, sorts,
      paste("region", index, "proposal update"))
    pk_assert_free_probability(update$zero_mass_proposal, "kappa_i(s)",
      "individual proposal has zero strategy mass", paste("region", index, "kappa"))
    public <- update$after_public_vote_vector
    pk_assert_formula_equivalent(public$weak_vote_likelihood_type_invariant,
                                 core$c_value$ast,
                                 paste("region", index, "weak-vote likelihood"))
    if (identical(region$branch, "S")) {
      sc_assert(identical(public$kind, "separating_H_vote") &&
                  identical(public$H_likelihoods,
                    list(pass = list(theta_0 = "1", theta_1 = "0"),
                         failure = list(theta_0 = "0", theta_1 = "1"))),
                "FAIL_CERTIFICATE", "separating public-H likelihoods changed")
      pk_assert_bayes_fraction_invariant(
        public$positive_mass$pass, nu, one, zero, zero,
        "low_only_pass_positive_mass", weak_br, H_br, simplexes, sorts,
        paste("region", index, "pass update"))
      pk_assert_bayes_fraction_invariant(
        public$positive_mass$failure, nu, zero, one, one,
        "low_only_failure_positive_mass", weak_br, H_br, simplexes, sorts,
        paste("region", index, "failure update"))
      pk_assert_free_probability(public$endpoint_zero_mass$nu_0_failure,
        "eta_i(s,v)", "proposal-vote history has zero probability",
        paste("region", index, "nu0 eta"))
      pk_assert_free_probability(public$endpoint_zero_mass$nu_1_pass,
        "eta_i(s,v)", "proposal-vote history has zero probability",
        paste("region", index, "nu1 eta"))
    } else {
      sc_assert(identical(public$kind, "nonseparating_H_vote"),
                "FAIL_CERTIFICATE", "nonseparating public-H update changed")
      pk_assert_bayes_fraction_invariant(
        public$posterior_on_positive_history, nu, lambda, lambda, nu,
        "positive_proposal_support", weak_br, H_br, simplexes, sorts,
        paste("region", index, "public positive-history update"))
      pk_assert_free_probability(public$zero_mass_history, "eta_i(s,v)",
        "proposal-vote history has zero probability", paste("region", index, "eta"))
    }
  }
  pk_assert_free_probability(value$endpoints$nu_0$zero_mass_type_1_histories,
    "eta_i(s,v)", "proposal-vote history has zero probability", "nu=0 endpoint eta")
  pk_assert_free_probability(value$endpoints$nu_1$zero_mass_type_0_histories,
    "eta_i(s,v)", "proposal-vote history has zero probability", "nu=1 endpoint eta")
  sc_assert(identical(value$endpoints$nu_0$type_probabilities,
                      list(theta_0 = "1", theta_1 = "0")) &&
              identical(value$endpoints$nu_1$type_probabilities,
                        list(theta_0 = "0", theta_1 = "1")),
            "FAIL_CERTIFICATE", "endpoint type probabilities changed")
  invisible(TRUE)
}

pk_membership_weight_sum <- function(family, offset, proposer = "b1",
                                     coalition = "b2") {
  binder <- pk_coalition_binder(if (offset == 1L) "K" else "T", coalition,
                                proposer, offset, require_member_l = TRUE)
  pk_sum_over(binder, pk_indexed_weight(family, proposer, coalition))
}

pk_plain_weight_sum <- function(family, offset, proposer = "b1",
                                coalition = "b2") {
  binder <- pk_coalition_binder(if (offset == 1L) "K" else "T", coalition,
                                proposer, offset, require_member_l = FALSE)
  pk_sum_over(binder, pk_indexed_weight(family, proposer, coalition))
}

pk_indexed_maps_from_strategy <- function(refs, primitives, sorts, n1) {
  recognition <- refs[[1L]]; c_value <- refs[[2L]]; quota <- refs[[3L]]
  argmax <- refs[[4L]]; feasibility <- refs[[5L]]; simplexes <- refs[[6L]]
  core <- pk_expected_core(primitives, sorts, n1)
  pk_assert_formula_equivalent(recognition, pk_div(pk_num(1), pk_sym("m", sorts)),
                               "indexed recognition premise")
  pk_assert_formula_equivalent(c_value, core$c_value$ast,
                               "indexed continuation premise")
  pk_assert_quota(quota, primitives, sorts)
  pk_assert_argmax_complete(argmax, core, sorts)
  pk_assert_feasibility_binding(feasibility, core)
  pk_assert_simplexes_complete(simplexes, core, feasibility)
  sc_assert(identical(quota$kind, "quota") && identical(argmax$kind, "argmax_correspondence") &&
              identical(feasibility$kind, "feasibility") &&
              identical(simplexes$kind, "identity_simplexes"),
            "FAIL_CERTIFICATE", "indexed payoff rule lacks strategy/simplex premises")
  m <- pk_sym("m", sorts); beta <- pk_sym("beta", sorts); nu <- pk_sym("nu", sorts)
  o0 <- pk_sym("o_0", sorts); o1 <- pk_sym("o_1", sorts); one <- pk_num(1)
  one_over_m <- pk_div(one, m)
  pk_assert_formula_equivalent(recognition, one_over_m, "uniform recognition weight")
  pk_assert_formula_equivalent(c_value, pk_div(beta, m), "transported weak continuation")
  other_i_binder <- sc_parse_sum_binder("i in W, i!=l", 1L)
  all_i_binder <- sc_parse_sum_binder("i in W", 1L)
  per_region <- lapply(seq_along(argmax$regions), function(index) {
    region <- argmax$regions[[index]]
    feasible <- feasibility$witnesses[[index]]
    simplex <- simplexes$per_region[[index]]
    region_hash <- pk_object_hash(region)
    sc_assert(identical(feasible$region_hash, region_hash) &&
                identical(simplex$region_hash, region_hash),
              "FAIL_CERTIFICATE", "indexed map copied a different region's strategy")
    branch <- region$branch
    proposer_value <- switch(branch,
      E = argmax$candidates$E, S = argmax$candidates$S,
      P = argmax$candidates$P,
      EP = {
        EP_difference <- pk_formula(pk_sub(argmax$candidates$E$ast,
                                           argmax$candidates$P$ast), "INDEXED_SUM")
        EP_on_domain <- pk_formula(pk_ast_substitute(EP_difference$ast, "o_1",
                                                     one_over_m), "INDEXED_SUM")
        pk_assert_formula_equivalent(EP_on_domain, pk_num(0),
                                     "mixed E/P proposer indifference")
        argmax$candidates$E
      }, sc_abort("FAIL_CERTIFICATE", "unknown indexed-payoff branch"))
    membership_term <- if (branch == "E") {
      pk_mul(c_value$ast, pk_membership_weight_sum("omega", 1L))
    } else if (branch == "P") {
      pk_mul(c_value$ast, pk_membership_weight_sum("omega", 2L))
    } else if (branch == "S") {
      pk_add(pk_mul(pk_mul(pk_sub(one, nu), c_value$ast),
                    pk_membership_weight_sum("omega", 2L)),
             pk_mul(nu, c_value$ast))
    } else {
      pk_mul(c_value$ast,
             pk_add(pk_membership_weight_sum("e", 1L, coalition = "b2"),
                    pk_membership_weight_sum("p", 2L, coalition = "b3")))
    }
    other_sum <- pk_sum_over(other_i_binder, membership_term)
    weak_rhs <- pk_add(pk_mul(one_over_m, proposer_value$ast),
                       pk_mul(one_over_m, other_sum))
    weak_equation <- sc_ast(
      "compare", operator = "=",
      left = sc_ast("symbol", name = "C_l", sort = "Payoff"),
      right = weak_rhs, sort = "Proposition")

    if (branch == "E") {
      H0 <- pk_formula(o0, "INDEXED_SUM"); H1 <- pk_formula(o1, "INDEXED_SUM")
      outcomes <- list(pass_with_hegemon = pk_formula(pk_num(0), "INDEXED_SUM"),
                       pass_without_hegemon = pk_formula(pk_num(1), "INDEXED_SUM"),
                       failure = pk_formula(pk_num(0), "INDEXED_SUM"),
                       delay = pk_formula(pk_num(0), "INDEXED_SUM"))
    } else if (branch == "P") {
      H0 <- argmax$candidates$P
      # Pooling concession is beta*o_1 for both H types, not the proposer residual.
      H0 <- pk_formula(pk_mul(beta, o1), "INDEXED_SUM"); H1 <- H0
      outcomes <- list(pass_with_hegemon = pk_formula(pk_num(1), "INDEXED_SUM"),
                       pass_without_hegemon = pk_formula(pk_num(0), "INDEXED_SUM"),
                       failure = pk_formula(pk_num(0), "INDEXED_SUM"),
                       delay = pk_formula(pk_num(0), "INDEXED_SUM"))
    } else if (branch == "S") {
      H0 <- pk_formula(pk_mul(beta, o0), "INDEXED_SUM")
      H1 <- pk_formula(pk_mul(beta, o1), "INDEXED_SUM")
      outcomes <- list(pass_with_hegemon = pk_formula(pk_sub(one, nu), "INDEXED_SUM"),
                       pass_without_hegemon = pk_formula(pk_num(0), "INDEXED_SUM"),
                       failure = pk_formula(pk_num(0), "INDEXED_SUM"),
                       delay = pk_formula(nu, "INDEXED_SUM"))
    } else {
      sum_e <- pk_plain_weight_sum("e", 1L, coalition = "b2")
      sum_p <- pk_plain_weight_sum("p", 2L, coalition = "b3")
      H0_ast <- pk_mul(one_over_m, pk_sum_over(all_i_binder,
        pk_add(pk_mul(o0, sum_e), pk_mul(c_value$ast, sum_p))))
      H1_ast <- pk_mul(one_over_m, pk_sum_over(all_i_binder,
        pk_add(pk_mul(one_over_m, sum_e), pk_mul(c_value$ast, sum_p))))
      H0 <- list(kind = "indexed_formula", ast = H0_ast,
                 normal_form = sc_indexed_canonical(H0_ast))
      H1 <- list(kind = "indexed_formula", ast = H1_ast,
                 normal_form = sc_indexed_canonical(H1_ast),
                 domain = "o_1=1/m")
      pass_H_ast <- pk_mul(one_over_m, pk_sum_over(all_i_binder, sum_p))
      pass_X_ast <- pk_mul(one_over_m, pk_sum_over(all_i_binder, sum_e))
      outcomes <- list(
        pass_with_hegemon = list(kind = "indexed_formula", ast = pass_H_ast,
                                 normal_form = sc_indexed_canonical(pass_H_ast)),
        pass_without_hegemon = list(kind = "indexed_formula", ast = pass_X_ast,
                                    normal_form = sc_indexed_canonical(pass_X_ast)),
        failure = pk_formula(pk_num(0), "INDEXED_SUM"),
        delay = pk_formula(pk_num(0), "INDEXED_SUM"))
    }
    list(region_hash = region_hash, branch = branch,
         recognized_proposer = proposer_value,
         weak_identity_map = list(kind = "indexed_formula", ast = weak_equation,
                                  normal_form = sc_indexed_canonical(weak_equation)),
         H_by_type = list(theta_0 = H0, theta_1 = H1), outcomes = outcomes,
         simplex_hash = pk_object_hash(simplex$simplex$normalization_nf))
  })
  list(kind = "indexed_payoff_outcome_maps", per_region = per_region,
       recognition = recognition, weak_continuation = c_value)
}

pk_assert_indexed_invariants <- function(value, core, argmax, simplexes, sorts) {
  sc_assert(is.list(value) && identical(names(value),
              c("kind", "per_region", "recognition", "weak_continuation")) &&
              identical(value$kind, "indexed_payoff_outcome_maps") &&
              length(value$per_region) == length(core$regions),
            "FAIL_CERTIFICATE", "indexed payoff/outcome coverage or schema changed")
  m <- pk_sym("m", sorts); beta <- pk_sym("beta", sorts); nu <- pk_sym("nu", sorts)
  o0 <- pk_sym("o_0", sorts); o1 <- pk_sym("o_1", sorts); one <- pk_num(1)
  one_over_m <- pk_div(one, m)
  pk_assert_formula_equivalent(value$recognition, one_over_m,
                               "indexed invariant recognition")
  pk_assert_formula_equivalent(value$weak_continuation, pk_div(beta, m),
                               "indexed invariant weak continuation")
  other_i_binder <- pk_literal_other_player_binder()
  all_i_binder <- list(kind = "binder", variable = "b1", variable_sort = "Player",
                       source_variable = "i", domain = pk_literal_W(), constraints = list())
  for (index in seq_along(core$regions)) {
    region <- core$regions[[index]]; branch <- region$branch
    actual <- value$per_region[[index]]
    proposer_value <- switch(branch, E = core$E, S = core$S, P = core$P,
                             EP = core$E,
                             sc_abort("FAIL_CERTIFICATE", "unknown indexed branch"))
    membership_term <- if (branch == "E") {
      pk_mul(core$c_value$ast, pk_literal_membership_weight_sum("omega", 1L))
    } else if (branch == "P") {
      pk_mul(core$c_value$ast, pk_literal_membership_weight_sum("omega", 2L))
    } else if (branch == "S") {
      pk_add(pk_mul(pk_mul(pk_sub(one, nu), core$c_value$ast),
                    pk_literal_membership_weight_sum("omega", 2L)),
             pk_mul(nu, core$c_value$ast))
    } else {
      pk_mul(core$c_value$ast,
             pk_add(pk_literal_membership_weight_sum("e", 1L, coalition = "b2"),
                    pk_literal_membership_weight_sum("p", 2L, coalition = "b3")))
    }
    other_sum <- pk_literal_sum(other_i_binder, membership_term)
    weak_rhs <- pk_add(pk_mul(one_over_m, proposer_value$ast),
                       pk_mul(one_over_m, other_sum))
    weak_equation <- sc_ast(
      "compare", operator = "=", left = sc_ast("symbol", name = "C_l", sort = "Payoff"),
      right = weak_rhs, sort = "Proposition")
    if (branch == "E") {
      H0 <- pk_formula(o0, "INDEXED_SUM"); H1 <- pk_formula(o1, "INDEXED_SUM")
      outcomes <- list(
        pass_with_hegemon = pk_formula(pk_num(0), "INDEXED_SUM"),
        pass_without_hegemon = pk_formula(pk_num(1), "INDEXED_SUM"),
        failure = pk_formula(pk_num(0), "INDEXED_SUM"),
        delay = pk_formula(pk_num(0), "INDEXED_SUM"))
    } else if (branch == "P") {
      H0 <- pk_formula(pk_mul(beta, o1), "INDEXED_SUM"); H1 <- H0
      outcomes <- list(
        pass_with_hegemon = pk_formula(pk_num(1), "INDEXED_SUM"),
        pass_without_hegemon = pk_formula(pk_num(0), "INDEXED_SUM"),
        failure = pk_formula(pk_num(0), "INDEXED_SUM"),
        delay = pk_formula(pk_num(0), "INDEXED_SUM"))
    } else if (branch == "S") {
      H0 <- pk_formula(pk_mul(beta, o0), "INDEXED_SUM")
      H1 <- pk_formula(pk_mul(beta, o1), "INDEXED_SUM")
      outcomes <- list(
        pass_with_hegemon = pk_formula(pk_sub(one, nu), "INDEXED_SUM"),
        pass_without_hegemon = pk_formula(pk_num(0), "INDEXED_SUM"),
        failure = pk_formula(pk_num(0), "INDEXED_SUM"),
        delay = pk_formula(nu, "INDEXED_SUM"))
    } else {
      sum_e <- pk_literal_plain_weight_sum("e", 1L, coalition = "b2")
      sum_p <- pk_literal_plain_weight_sum("p", 2L, coalition = "b3")
      H0_ast <- pk_mul(one_over_m, pk_literal_sum(all_i_binder,
        pk_add(pk_mul(o0, sum_e), pk_mul(core$c_value$ast, sum_p))))
      H1_ast <- pk_mul(one_over_m, pk_literal_sum(all_i_binder,
        pk_add(pk_mul(one_over_m, sum_e), pk_mul(core$c_value$ast, sum_p))))
      H0 <- list(kind = "indexed_formula", ast = H0_ast,
                 normal_form = sc_indexed_canonical(H0_ast))
      H1 <- list(kind = "indexed_formula", ast = H1_ast,
                 normal_form = sc_indexed_canonical(H1_ast), domain = "o_1=1/m")
      pass_H_ast <- pk_mul(one_over_m, pk_literal_sum(all_i_binder, sum_p))
      pass_X_ast <- pk_mul(one_over_m, pk_literal_sum(all_i_binder, sum_e))
      outcomes <- list(
        pass_with_hegemon = list(kind = "indexed_formula", ast = pass_H_ast,
                                 normal_form = sc_indexed_canonical(pass_H_ast)),
        pass_without_hegemon = list(kind = "indexed_formula", ast = pass_X_ast,
                                    normal_form = sc_indexed_canonical(pass_X_ast)),
        failure = pk_formula(pk_num(0), "INDEXED_SUM"),
        delay = pk_formula(pk_num(0), "INDEXED_SUM"))
    }
    expected <- list(
      region_hash = pk_object_hash(region), branch = branch,
      recognized_proposer = proposer_value,
      weak_identity_map = list(kind = "indexed_formula", ast = weak_equation,
                               normal_form = sc_indexed_canonical(weak_equation)),
      H_by_type = list(theta_0 = H0, theta_1 = H1), outcomes = outcomes,
      simplex_hash = pk_object_hash(simplexes$per_region[[index]]$simplex$normalization_nf)
    )
    sc_assert(identical(pk_canonical_json(pk_public_value(actual)),
                        pk_canonical_json(pk_public_value(expected))),
              "FAIL_CERTIFICATE",
              paste("indexed payoff/outcome record", index,
                    "changed a coefficient, type payoff, outcome, or binding"))
  }
  invisible(TRUE)
}

pk_assert_full_object <- function(actual, expected, label) {
  sc_assert(identical(pk_canonical_json(pk_public_value(actual)),
                      pk_canonical_json(pk_public_value(expected))),
            "FAIL_CERTIFICATE", paste(label, "differs from independent replay"))
  invisible(TRUE)
}

pk_expected_late_objects <- function(primitives, sorts, n1) {
  core <- pk_expected_core(primitives, sorts, n1)
  argmax <- pk_core_argmax(core)
  E <- pk_core_budget_witness(core, "exclude_H")
  L <- pk_core_budget_witness(core, "low_only")
  P <- pk_core_budget_witness(core, "pooling")
  feasibility <- pk_feasibility_from_budgets(
    list(core$c_value, core$a0, core$a1, core$quota, E, L, P,
         core$strict, argmax), primitives, sorts, n1)
  simplexes <- pk_simplexes_from_regions(list(core$quota, argmax, feasibility),
                                         primitives, sorts, n1)
  weak_br <- pk_make_weak_br(core$c_value)
  H_br <- pk_make_H_br(core$a0, core$a1, sorts)
  proposer_map <- pk_make_proposer_map(core$c_value, core$a0, core$a1,
                                       core$quota, weak_br, H_br, sorts)
  tie <- pk_tie_break_from_payoffs(
    list(core$a0, core$a1, E, L, P, core$S, argmax),
    primitives, sorts, n1)
  beliefs <- pk_bayes_from_strategy_support(
    list(core$imported_o0, core$imported_o1, weak_br, H_br, argmax,
         feasibility, simplexes), primitives, sorts, n1)
  indexed <- pk_indexed_maps_from_strategy(
    list(core$imported_c, core$c_value, core$quota, argmax, feasibility, simplexes),
    primitives, sorts, n1)
  list(core = core, argmax = argmax, E = E, L = L, P = P,
       weak_br = weak_br, H_br = H_br, proposer_map = proposer_map,
       feasibility = feasibility,
       tie = tie, simplexes = simplexes, beliefs = beliefs, indexed = indexed)
}

pk_ast_root_records <- function(value, source_step, path = "") {
  ast_kinds <- c("number", "symbol", "bound_symbol", "set_symbol", "singleton",
                 "set_difference", "cardinality_constraint", "membership_constraint",
                 "not_equal_constraint", "indexed_symbol", "indexed_sum", "quantifier",
                 "unary", "binary", "compare", "logical", "call")
  records <- list()
  walk <- function(node, here, parent_name = "") {
    if (!is.list(node)) return(invisible(NULL))
    is_ast <- !is.null(node$kind) && node$kind %in% ast_kinds
    if (is_ast && parent_name %in% c("ast", "normalization", "slack",
                                    "deviating_proposer_prior")) {
      records[[length(records) + 1L]] <<- list(
        source_step = source_step, path = here, ast = node)
      return(invisible(NULL))
    }
    node_names <- names(node)
    for (index in seq_along(node)) {
      part <- if (!is.null(node_names) && nzchar(node_names[[index]])) {
        node_names[[index]]
      } else as.character(index)
      walk(node[[index]], paste0(here, "/", part), part)
    }
    invisible(NULL)
  }
  walk(value, paste0("/", source_step))
  records
}

# A second traversal is intentionally kept separate from pk_ast_root_records.
# It is the coverage oracle for S28, so changing the proof-producing walker
# cannot change both the closure record set and its expected path set.
pk_collect_ast_roots_independent <- function(value, source_step) {
  ast_kinds <- c("number", "symbol", "bound_symbol", "set_symbol", "singleton",
                 "set_difference", "cardinality_constraint", "membership_constraint",
                 "not_equal_constraint", "indexed_symbol", "indexed_sum", "quantifier",
                 "unary", "binary", "compare", "logical", "call")
  root_fields <- c("ast", "normalization", "slack", "deviating_proposer_prior")
  records <- list()
  visit <- function(node, path, parent_field) {
    if (!is.list(node)) return(invisible(NULL))
    if (!is.null(node$kind) && node$kind %in% ast_kinds &&
        parent_field %in% root_fields) {
      records[[length(records) + 1L]] <<- list(
        source_step = source_step, path = path, ast = node)
      return(invisible(NULL))
    }
    fields <- names(node)
    for (index in seq_along(node)) {
      field <- if (!is.null(fields) && nzchar(fields[[index]])) {
        fields[[index]]
      } else as.character(index)
      visit(node[[index]], paste0(path, "/", field), field)
    }
    invisible(NULL)
  }
  visit(value, paste0("/", source_step), "")
  records
}

pk_record_environment <- function(record, sorts) {
  base <- names(sorts)
  path <- record$path
  locals <- character(0)
  definitions <- list()
  if (grepl("^/S25/", path) &&
      grepl("after_positive_mass_proposal|posterior_on_positive_history", path)) {
    locals <- c(locals, "lambda_s")
    definitions$lambda_s <- "positive-mass proposal likelihood local to this history"
  }
  if (grepl("^/S26/", path)) {
    locals <- c(locals, "W")
    definitions$W <- "weak-player set local to the identity simplex"
  }
  if (grepl("^/S27/.*/weak_identity_map/", path)) {
    locals <- c(locals, "W", "l", "C_l")
    definitions$W <- "weak-player set local to the identity record"
    definitions$l <- "weak payoff recipient fixed by this record"
    definitions$C_l <- "left-hand payoff defined by this identity record"
  } else if (grepl("^/S27/.*/(H_by_type|outcomes)/", path)) {
    locals <- c(locals, "W")
    definitions$W <- "weak-player set local to the labeled aggregation record"
  }
  list(allowed = sort(unique(c(base, locals))), local_definitions = definitions)
}

pk_free_symbol_closure <- function(refs, primitives, sorts, n1) {
  expected <- pk_expected_late_objects(primitives, sorts, n1)
  names(refs) <- c("S21", "S23", "S24", "S25", "S26", "S27")
  pk_assert_argmax_complete(refs$S21, expected$core, sorts)
  pk_assert_full_object(refs$S23, expected$feasibility, "S28 feasibility premise")
  pk_assert_full_object(refs$S24, expected$tie, "S28 tie-break premise")
  pk_assert_full_object(refs$S26, expected$simplexes, "S28 simplex premise")
  pk_assert_simplex_invariants(refs$S26, expected$core)
  pk_assert_belief_invariants(refs$S25, expected$core, expected$weak_br,
    expected$H_br, refs$S21, refs$S23, refs$S26, sorts)
  pk_assert_full_object(refs$S25, expected$beliefs, "S28 belief premise")
  pk_assert_full_object(refs$S27, expected$indexed, "S28 indexed-map premise")
  records <- unlist(lapply(names(refs), function(id) pk_ast_root_records(refs[[id]], id)),
                    recursive = FALSE)
  sc_assert(length(records) > 0L, "FAIL_COVERAGE", "closure received no typed AST records")
  checked <- lapply(records, function(record) {
    environment <- pk_record_environment(record, sorts)
    free <- ea_ast_free_symbols(record$ast)
    unauthorized <- setdiff(free, environment$allowed)
    sc_assert(length(unauthorized) == 0L, "FAIL_CERTIFICATE",
              paste("out-of-scope free symbol at", record$path,
                    paste(unauthorized, collapse = ",")))
    list(source_step = record$source_step, path = record$path,
         ast_hash = pk_object_hash(record$ast), free_symbols = as.list(free),
         primitive_symbols = as.list(intersect(free, names(sorts))),
         local_definitions = environment$local_definitions,
         status = "FREE_SYMBOLS_CLOSED")
  })
  list(kind = "record_scoped_free_symbol_closure", records = checked,
       record_count = length(checked), source_steps = as.list(names(refs)))
}

pk_assert_closure_invariants <- function(value, refs, sorts) {
  expected_sources <- c("S21", "S23", "S24", "S25", "S26", "S27")
  sc_assert(identical(names(refs), expected_sources), "FAIL_COVERAGE",
            "closure checker received a changed source-step set")
  roots <- unlist(lapply(expected_sources, function(id) {
    pk_collect_ast_roots_independent(refs[[id]], id)
  }), recursive = FALSE)
  paths <- vapply(roots, `[[`, character(1), "path")
  sc_assert(length(roots) > 0L && length(unique(paths)) == length(paths),
            "FAIL_COVERAGE", "independent AST root path set is empty or duplicated")
  expected <- lapply(roots, function(record) {
    environment <- pk_record_environment(record, sorts)
    free <- ea_ast_free_symbols(record$ast)
    unauthorized <- setdiff(free, environment$allowed)
    sc_assert(length(unauthorized) == 0L, "FAIL_CERTIFICATE",
              paste("out-of-scope free symbol at", record$path,
                    paste(unauthorized, collapse = ",")))
    list(source_step = record$source_step, path = record$path,
         ast_hash = pk_object_hash(record$ast), free_symbols = as.list(free),
         primitive_symbols = as.list(intersect(free, names(sorts))),
         local_definitions = environment$local_definitions,
         status = "FREE_SYMBOLS_CLOSED")
  })
  sc_assert(is.list(value) &&
              identical(names(value), c("kind", "records", "record_count", "source_steps")) &&
              identical(value$kind, "record_scoped_free_symbol_closure") &&
              identical(value$record_count, length(expected)) &&
              length(value$records) == length(expected) &&
              identical(unlist(value$source_steps, use.names = FALSE), expected_sources) &&
              identical(vapply(value$records, `[[`, character(1), "path"), paths) &&
              identical(pk_canonical_json(pk_public_value(value$records)),
                        pk_canonical_json(pk_public_value(expected))),
            "FAIL_COVERAGE",
            "free-symbol closure path set, cardinality, or record proof is incomplete")
  invisible(TRUE)
}

pk_region_deviation_certificate <- function(region, core, sorts) {
  selected <- switch(region$branch, E = "E", S = "S", P = "P",
                     EP = c("E", "P"),
                     sc_abort("FAIL_CERTIFICATE", "unknown PBE witness branch"))
  representative <- selected[[1L]]
  comparisons <- lapply(c("E", "S", "P", "R"), function(alternative) {
    difference <- pk_formula(pk_sub(core[[representative]]$ast,
                                    core[[alternative]]$ast), "PBE_WITNESS")
    list(alternative = alternative, difference = difference,
         relation = if (alternative %in% selected) "=0" else ">=0",
         domain = list(order_case = region$order_case, prior = region$prior,
                       tie = region$tie),
         sign_atoms = region$dominance,
         derivation = list(rule = "ARGMAX_BY_CASES",
                           region_hash = pk_object_hash(region)))
  })
  if (identical(region$branch, "EP")) {
    equality <- pk_formula(pk_sub(core$E$ast, core$P$ast), "PBE_WITNESS")
    equality_on_domain <- pk_formula(pk_ast_substitute(
      equality$ast, "o_1", pk_div(pk_num(1), pk_sym("m", sorts))),
      "PBE_WITNESS")
    pk_assert_formula_equivalent(equality_on_domain, pk_num(0),
                                 "E/P mixture indifference")
  } else equality_on_domain <- NULL
  list(selected_set = as.list(selected), comparisons = comparisons,
       mixture_indifference = equality_on_domain,
       source_region_hash = pk_object_hash(region))
}

pk_assert_deviation_invariants <- function(value, region, core, sorts) {
  selected <- switch(region$branch, E = "E", S = "S", P = "P",
                     EP = c("E", "P"),
                     sc_abort("FAIL_CERTIFICATE", "unknown deviation-check branch"))
  sc_assert(is.list(value) &&
              identical(names(value), c("selected_set", "comparisons",
                                         "mixture_indifference", "source_region_hash")) &&
              identical(unlist(value$selected_set, use.names = FALSE), selected) &&
              identical(value$source_region_hash, pk_object_hash(region)) &&
              length(value$comparisons) == 4L,
            "FAIL_CERTIFICATE", "proposer deviation certificate schema changed")
  representative <- selected[[1L]]
  alternatives <- c("E", "S", "P", "R")
  for (index in seq_along(alternatives)) {
    alternative <- alternatives[[index]]; comparison <- value$comparisons[[index]]
    expected_relation <- if (alternative %in% selected) "=0" else ">=0"
    sc_assert(identical(comparison$alternative, alternative) &&
                identical(comparison$relation, expected_relation) &&
                identical(comparison$domain,
                          list(order_case = region$order_case, prior = region$prior,
                               tie = region$tie)) &&
                identical(comparison$sign_atoms, region$dominance) &&
                identical(comparison$derivation,
                          list(rule = "ARGMAX_BY_CASES",
                               region_hash = pk_object_hash(region))),
              "FAIL_CERTIFICATE", "proposer deviation relation or domain changed")
    pk_assert_formula_equivalent(
      comparison$difference,
      pk_sub(core[[representative]]$ast, core[[alternative]]$ast),
      paste("deviation", representative, "minus", alternative))
    if (alternative == representative) {
      pk_assert_formula_equivalent(comparison$difference, pk_num(0),
                                   "selected self-deviation")
    }
  }
  if (identical(region$branch, "EP")) {
    sc_assert(!is.null(value$mixture_indifference), "FAIL_CERTIFICATE",
              "E/P mixture lacks an indifference certificate")
    pk_assert_formula_equivalent(value$mixture_indifference, pk_num(0),
                                 "E/P mixture indifference invariant")
  } else {
    sc_assert(is.null(value$mixture_indifference), "FAIL_CERTIFICATE",
              "nonmixed branch exported a mixture certificate")
  }
  invisible(TRUE)
}

pk_pbe_witnesses <- function(refs, primitives, sorts, n1) {
  names(refs) <- c("S08", "S09", "S10", "S17", "S21", "S22", "S23",
                   "S24", "S25", "S26", "S27", "S28")
  expected <- pk_expected_late_objects(primitives, sorts, n1)
  pk_assert_weak_br_complete(refs$S08, expected$core)
  pk_assert_H_br_complete(refs$S09, expected$core, sorts)
  pk_assert_proposer_map_complete(refs$S10, expected$core, sorts)
  pk_assert_full_object(refs$S08, expected$weak_br, "PBE weak response")
  pk_assert_full_object(refs$S09, expected$H_br, "PBE H response")
  pk_assert_full_object(refs$S10, expected$proposer_map, "PBE proposer map")
  pk_assert_full_object(refs$S17, expected$core$strict, "PBE strict sign")
  pk_assert_argmax_complete(refs$S21, expected$core, sorts)
  expected_partition <- pk_validate_partition(expected$core$regions)
  pk_assert_full_object(refs$S22, expected_partition, "PBE domain partition")
  pk_assert_full_object(refs$S23, expected$feasibility, "PBE feasibility")
  pk_assert_full_object(refs$S24, expected$tie, "PBE tie break")
  pk_assert_full_object(refs$S25, expected$beliefs, "PBE beliefs")
  pk_assert_full_object(refs$S26, expected$simplexes, "PBE simplexes")
  pk_assert_simplex_invariants(refs$S26, expected$core)
  pk_assert_belief_invariants(refs$S25, expected$core, expected$weak_br,
    expected$H_br, refs$S21, refs$S23, refs$S26, sorts)
  pk_assert_full_object(refs$S27, expected$indexed, "PBE payoff/outcome maps")
  expected_closure <- pk_free_symbol_closure(
    list(expected$argmax, expected$feasibility, expected$tie, expected$beliefs,
         expected$simplexes, expected$indexed), primitives, sorts, n1)
  pk_assert_full_object(refs$S28, expected_closure, "PBE free-symbol closure")

  witnesses <- lapply(seq_along(expected$core$regions), function(index) {
    region <- expected$core$regions[[index]]
    region_hash <- pk_object_hash(region)
    feasibility <- expected$feasibility$witnesses[[index]]
    simplex <- expected$simplexes$per_region[[index]]
    beliefs <- expected$beliefs$per_region[[index]]
    maps <- expected$indexed$per_region[[index]]
    sc_assert(all(vapply(list(feasibility, simplex, beliefs, maps), function(object) {
      identical(object$region_hash, region_hash) && identical(object$branch, region$branch)
    }, logical(1))), "FAIL_CERTIFICATE",
    "PBE witness components are not bound to one computed region")
    if (identical(region$branch, "S")) {
      pk_assert_formula_equivalent(maps$outcomes$delay, pk_sym("nu", sorts),
                                   "screening delay probability")
    }
    deviations <- pk_region_deviation_certificate(region, expected$core, sorts)
    pk_assert_deviation_invariants(deviations, region, expected$core, sorts)
    list(
      witness_id = paste0("PBE-W", sprintf("%02d", index)),
      region = region,
      domain_witness = refs$S22$exact_nonvacuity_witnesses[[index]],
      strategy = list(feasibility = feasibility, simplex = simplex,
                      proposer_map_hash = pk_object_hash(expected$proposer_map)),
      beliefs = beliefs,
      sequential_rationality = list(
        weak_response_hash = pk_object_hash(expected$weak_br),
        H_response_hash = pk_object_hash(expected$H_br),
        proposer_deviations = deviations),
      payoff_outcome_map = maps,
      closure_records = as.list(vapply(
        expected_closure$records[
          vapply(expected_closure$records, function(record) {
            grepl(paste0("/", index, "/"), record$path, fixed = TRUE)
          }, logical(1))], `[[`, character(1), "ast_hash")))
  })
  region_hashes <- vapply(expected$core$regions, pk_object_hash, character(1))
  witness_regions <- vapply(witnesses, function(witness) pk_object_hash(witness$region),
                            character(1))
  sc_assert(identical(witness_regions, region_hashes) &&
              length(unique(vapply(witnesses, `[[`, character(1), "witness_id"))) ==
                length(region_hashes),
            "FAIL_CERTIFICATE", "PBE witness coverage is not a region bijection")
  list(kind = "PBE_witnesses", witnesses = witnesses, count = length(witnesses),
       coverage = list(partition_hash = pk_object_hash(expected_partition),
                       region_hashes = as.list(region_hashes),
                       witness_region_hashes = as.list(witness_regions),
                       partition_domain_witness_hashes = as.list(vapply(
                         refs$S22$exact_nonvacuity_witnesses, pk_object_hash,
                         character(1))),
                       witness_domain_witness_hashes = as.list(vapply(
                         witnesses, function(witness) {
                           pk_object_hash(witness$domain_witness)
                         }, character(1)))))
}

pk_assert_pbe_invariants <- function(value, refs, primitives, sorts, n1) {
  expected_sources <- c("S08", "S09", "S10", "S17", "S21", "S22", "S23",
                        "S24", "S25", "S26", "S27", "S28")
  names(refs) <- expected_sources
  core <- pk_expected_core(primitives, sorts, n1)
  pk_assert_weak_br_complete(refs$S08, core)
  pk_assert_H_br_complete(refs$S09, core, sorts)
  pk_assert_proposer_map_complete(refs$S10, core, sorts)
  sc_assert(identical(pk_canonical_json(pk_public_value(refs$S17)),
                      pk_canonical_json(pk_public_value(core$strict))),
            "FAIL_CERTIFICATE", "PBE strict-sign premise changed")
  pk_assert_argmax_complete(refs$S21, core, sorts)
  pk_assert_partition_invariants(refs$S22, core$regions, core)
  pk_assert_feasibility_invariants(refs$S23, core, sorts)
  pk_assert_tie_invariants(refs$S24, core, refs$S21, sorts)
  pk_assert_simplex_invariants(refs$S26, core)
  pk_assert_belief_invariants(refs$S25, core, refs$S08, refs$S09,
                              refs$S21, refs$S23, refs$S26, sorts)
  pk_assert_indexed_invariants(refs$S27, core, refs$S21, refs$S26, sorts)
  closure_refs <- refs[c("S21", "S23", "S24", "S25", "S26", "S27")]
  pk_assert_closure_invariants(refs$S28, closure_refs, sorts)
  sc_assert(is.list(value) &&
              identical(names(value), c("kind", "witnesses", "count", "coverage")) &&
              identical(value$kind, "PBE_witnesses") &&
              identical(value$count, length(core$regions)) &&
              length(value$witnesses) == length(core$regions),
            "FAIL_CERTIFICATE", "PBE witness coverage or schema changed")
  region_hashes <- vapply(core$regions, pk_object_hash, character(1))
  for (index in seq_along(core$regions)) {
    region <- core$regions[[index]]; witness <- value$witnesses[[index]]
    expected_closure <- as.list(vapply(
      refs$S28$records[vapply(refs$S28$records, function(record) {
        grepl(paste0("/", index, "/"), record$path, fixed = TRUE)
      }, logical(1))], `[[`, character(1), "ast_hash"))
    sc_assert(identical(names(witness),
                        c("witness_id", "region", "domain_witness", "strategy", "beliefs",
                          "sequential_rationality", "payoff_outcome_map",
                          "closure_records")) &&
                identical(witness$witness_id, paste0("PBE-W", sprintf("%02d", index))) &&
                identical(pk_canonical_json(pk_public_value(witness$region)),
                          pk_canonical_json(pk_public_value(region))) &&
                identical(pk_canonical_json(pk_public_value(witness$domain_witness)),
                          pk_canonical_json(pk_public_value(
                            refs$S22$exact_nonvacuity_witnesses[[index]]))),
              "FAIL_CERTIFICATE", paste("PBE witness", index, "identity or region changed"))
    expected_strategy <- list(
      feasibility = refs$S23$witnesses[[index]],
      simplex = refs$S26$per_region[[index]],
      proposer_map_hash = pk_object_hash(refs$S10))
    sc_assert(identical(pk_canonical_json(pk_public_value(witness$strategy)),
                        pk_canonical_json(pk_public_value(expected_strategy))) &&
                identical(pk_canonical_json(pk_public_value(witness$beliefs)),
                          pk_canonical_json(pk_public_value(refs$S25$per_region[[index]]))) &&
                identical(pk_canonical_json(pk_public_value(witness$payoff_outcome_map)),
                          pk_canonical_json(pk_public_value(refs$S27$per_region[[index]]))) &&
                identical(witness$closure_records, expected_closure),
              "FAIL_CERTIFICATE",
              paste("PBE witness", index,
                    "strategy, beliefs, payoff/outcome map, or closure binding changed"))
    rationality <- witness$sequential_rationality
    sc_assert(identical(names(rationality),
                        c("weak_response_hash", "H_response_hash",
                          "proposer_deviations")) &&
                identical(rationality$weak_response_hash, pk_object_hash(refs$S08)) &&
                identical(rationality$H_response_hash, pk_object_hash(refs$S09)),
              "FAIL_CERTIFICATE", paste("PBE witness", index, "response binding changed"))
    pk_assert_deviation_invariants(rationality$proposer_deviations,
                                   region, core, sorts)
    if (identical(region$branch, "S")) {
      pk_assert_formula_equivalent(witness$payoff_outcome_map$outcomes$delay,
                                   pk_sym("nu", sorts),
                                   paste("PBE witness", index, "screening delay"))
    }
  }
  witness_region_hashes <- vapply(value$witnesses, function(witness) {
    pk_object_hash(witness$region)
  }, character(1))
  expected_coverage <- list(
    partition_hash = pk_object_hash(refs$S22),
    region_hashes = as.list(region_hashes),
    witness_region_hashes = as.list(region_hashes),
    partition_domain_witness_hashes = as.list(vapply(
      refs$S22$exact_nonvacuity_witnesses, pk_object_hash, character(1))),
    witness_domain_witness_hashes = as.list(vapply(
      value$witnesses, function(witness) pk_object_hash(witness$domain_witness),
      character(1))))
  sc_assert(identical(witness_region_hashes, region_hashes) &&
              identical(pk_canonical_json(pk_public_value(value$coverage)),
                        pk_canonical_json(pk_public_value(expected_coverage))),
            "FAIL_COVERAGE", "PBE region bijection or partition binding changed")
  invisible(TRUE)
}

pk_dispatch <- function(step, values, primitives, n1, sorts) {
  refs <- lapply(unlist(step$refs, use.names = FALSE), function(id) values[[id]])
  names(refs) <- unlist(step$refs, use.names = FALSE)
  rule <- step$rule
  if (rule == "IMPORT_EXACT") return(pk_import_n1_formula(step$args$field, n1, sorts))
  if (rule == "DISCOUNT_ONCE") {
    sc_assert(length(refs) == 1L, "FAIL_CERTIFICATE", "DISCOUNT_ONCE needs one premise")
    return(pk_formula(pk_mul(pk_sym("beta", sorts), refs[[1L]]$ast), rule,
                      unlist(step$refs, use.names = FALSE)))
  }
  if (rule == "QUOTA_EVAL") {
    return(pk_quota_from_primitives(primitives, sorts))
  }
  if (rule == "PAYOFF_EVAL" && step$args$problem == "weak_ballot") {
    c_value <- refs[[1L]]
    core <- pk_expected_core(primitives, sorts, n1)
    pk_assert_formula_equivalent(c_value, core$c_value$ast,
                                 "weak-ballot continuation premise")
    result <- pk_make_weak_br(c_value)
    pk_assert_weak_br_complete(result, core)
    return(result)
  }
  if (rule == "BEST_RESPONSE") {
    expected <- pk_expected_core(primitives, sorts, n1)
    pk_assert_formula_equivalent(refs[[1L]], expected$a0$ast,
                                 "H theta-0 discounted continuation")
    pk_assert_formula_equivalent(refs[[2L]], expected$a1$ast,
                                 "H theta-1 discounted continuation")
    pk_assert_quota(refs[[3L]], primitives, sorts)
    result <- pk_make_H_br(refs[[1L]], refs[[2L]], sorts)
    pk_assert_H_br_complete(result, expected, sorts)
    return(result)
  }
  if (rule == "PAYOFF_EVAL" && step$args$problem == "proposer_all_feasible_proposals") {
    c_value <- refs[[1L]]; a0 <- refs[[2L]]; a1 <- refs[[3L]]
    core <- pk_expected_core(primitives, sorts, n1)
    pk_assert_formula_equivalent(c_value, core$c_value$ast, "proposer continuation")
    pk_assert_formula_equivalent(a0, core$a0$ast, "proposer low cutoff")
    pk_assert_formula_equivalent(a1, core$a1$ast, "proposer high cutoff")
    pk_assert_quota(refs[[4L]], primitives, sorts)
    pk_assert_weak_br_complete(refs[[5L]], core)
    pk_assert_H_br_complete(refs[[6L]], core, sorts)
    result <- pk_make_proposer_map(c_value, a0, a1, refs[[4L]], refs[[5L]],
                                   refs[[6L]], sorts)
    pk_assert_proposer_map_complete(result, core, sorts)
    return(result)
  }
  if (rule == "BUDGET_SATURATION") {
    c_value <- refs[[1L]]; quota <- refs[[length(refs)]]
    one <- pk_num(1); zero <- pk_num(0)
    if (step$args$outcome == "exclude_H") {
      y <- zero; weak_count <- quota$exclude_weak_votes
    } else if (step$args$outcome == "low_only") {
      y <- refs[[2L]]$ast; weak_count <- quota$include_weak_votes
    } else if (step$args$outcome == "pooling") {
      y <- refs[[2L]]$ast; weak_count <- quota$include_weak_votes
    } else sc_abort("FAIL_CERTIFICATE", "unknown budget outcome")
    residual <- pk_formula(pk_sub(one, pk_add(y, pk_mul(weak_count, c_value$ast))),
                           rule, unlist(step$refs, use.names = FALSE))
    return(list(kind = "budget_witness", outcome = step$args$outcome, y = y,
                weak_count = weak_count, weak_price = c_value, residual = residual,
                slack = pk_num(0)))
  }
  if (rule == "PAYOFF_EVAL" && step$args$problem == "true_prior_low_only") {
    c_value <- refs[[1L]]; low <- refs[[2L]]$residual
    nu <- pk_sym("nu", sorts); one <- pk_num(1)
    return(pk_formula(pk_add(pk_mul(pk_sub(one, nu), low$ast), pk_mul(nu, c_value$ast)),
                      rule, unlist(step$refs, use.names = FALSE)))
  }
  if (rule == "PAYOFF_EVAL" && step$args$problem == "deliberate_failure") {
    core <- pk_expected_core(primitives, sorts, n1)
    pk_assert_formula_equivalent(refs[[1L]], core$c_value$ast,
                                 "deliberate-failure continuation premise")
    return(refs[[1L]])
  }
  if (rule == "ALGEBRA_EQ") {
    E <- refs[[1L]]$residual; P <- refs[[2L]]$residual; S <- refs[[3L]]; R <- refs[[4L]]
    difference <- function(a, b) pk_formula(pk_sub(a$ast, b$ast), rule,
                                             unlist(step$refs, use.names = FALSE))
    return(list(kind = "differences", E_minus_R = difference(E, R),
                P_minus_E = difference(P, E), S_minus_E = difference(S, E),
                S_minus_P = difference(S, P)))
  }
  if (rule == "SIGN_FROM_DOMAIN") {
    difference <- refs[[2L]]$E_minus_R
    return(pk_sign_e_minus_r(difference, refs[[1L]], primitives, sorts))
  }
  if (rule == "SOLVE_LINEAR_INEQUALITY") {
    differences <- refs[[1L]]
    pair <- unlist(step$args$pair, use.names = FALSE)
    target <- if (identical(pair, c("S", "P"))) {
      differences$S_minus_P
    } else differences$S_minus_E
    solution <- pk_solve_affine_zero(target, step$args$variable)
    solution$sign_certificate <- pk_frontier_certificate(solution, pair, differences,
                                                         refs[[2L]], sorts)
    solution$orientation <- "target_ge_zero_below_or_at_root"
    return(solution)
  }
  if (rule == "HEDGE_TRANSFORM") {
    result <- pk_hedge_from_maps(refs, primitives, sorts, n1)
    pk_assert_hedge_complete(result, sorts)
    return(result)
  }
  if (rule == "ARGMAX_BY_CASES") {
    core <- pk_expected_core(primitives, sorts, n1)
    pk_assert_budget_witness_complete(refs[[1L]], "exclude_H", pk_num(0),
      core$quota$exclude_weak_votes, core$E, core$c_value, "argmax E premise")
    pk_assert_budget_witness_complete(refs[[2L]], "pooling", core$a1$ast,
      core$quota$include_weak_votes, core$P, core$c_value, "argmax P premise")
    pk_assert_formula_equivalent(refs[[3L]], core$S$ast, "argmax S premise")
    pk_assert_formula_equivalent(refs[[4L]], core$R$ast, "argmax R premise")
    pk_assert_full_object(refs[[5L]], core$differences, "argmax differences premise")
    pk_assert_full_object(refs[[6L]], core$strict, "argmax sign premise")
    pk_assert_full_object(refs[[7L]], core$frontier_SP, "argmax S/P frontier premise")
    pk_assert_full_object(refs[[8L]], core$frontier_SE, "argmax S/E frontier premise")
    pk_assert_hedge_complete(refs[[9L]], sorts)
    expected_weak <- pk_make_weak_br(core$c_value)
    expected_H <- pk_make_H_br(core$a0, core$a1, sorts)
    expected_proposer <- pk_make_proposer_map(core$c_value, core$a0, core$a1,
      core$quota, expected_weak, expected_H, sorts)
    expected_hedge <- pk_hedge_from_maps(
      list(expected_weak, expected_H, expected_proposer), primitives, sorts, n1)
    pk_assert_full_object(refs[[9L]], expected_hedge, "argmax hedge premise")
    result <- list(kind = "argmax_correspondence",
                   candidates = list(E = refs[[1L]]$residual, P = refs[[2L]]$residual,
                                     S = refs[[3L]], R = refs[[4L]]),
                   frontier_SP = refs[[7L]], frontier_SE = refs[[8L]],
                   regions = pk_argmax_regions(refs[[5L]], refs[[6L]],
                                               refs[[7L]], refs[[8L]], sorts))
    pk_assert_argmax_complete(result, core, sorts)
    return(result)
  }
  if (rule == "INTERVAL_PARTITION") {
    result <- pk_validate_partition(refs[[1L]]$regions)
    pk_assert_partition_invariants(result, refs[[1L]]$regions,
                                   pk_expected_core(primitives, sorts, n1))
    return(result)
  }
  if (rule == "FEASIBILITY") {
    result <- pk_feasibility_from_budgets(refs, primitives, sorts, n1)
    pk_assert_feasibility_invariants(result, pk_expected_core(primitives, sorts, n1), sorts)
    return(result)
  }
  if (rule == "TIE_BREAK") {
    result <- pk_tie_break_from_payoffs(refs, primitives, sorts, n1)
    pk_assert_tie_invariants(result, pk_expected_core(primitives, sorts, n1),
                             refs[[7L]], sorts)
    return(result)
  }
  if (rule == "BAYES") {
    return(pk_bayes_from_strategy_support(refs, primitives, sorts, n1))
  }
  if (rule == "SIMPLEX_SUM") {
    return(pk_simplexes_from_regions(refs, primitives, sorts, n1))
  }
  if (rule == "INDEXED_SUM") {
    result <- pk_indexed_maps_from_strategy(refs, primitives, sorts, n1)
    pk_assert_indexed_invariants(result, pk_expected_core(primitives, sorts, n1),
                                 refs[[4L]], refs[[6L]], sorts)
    return(result)
  }
  if (rule == "FREE_SYMBOL_CLOSURE") {
    result <- pk_free_symbol_closure(refs, primitives, sorts, n1)
    pk_assert_closure_invariants(result, refs, sorts)
    return(result)
  }
  if (rule == "PBE_WITNESS") {
    result <- pk_pbe_witnesses(refs, primitives, sorts, n1)
    pk_assert_pbe_invariants(result, refs, primitives, sorts, n1)
    return(result)
  }
  sc_abort("FAIL_CERTIFICATE", paste("unsupported proof rule", rule))
}

pk_claim_obligation_registry_v1 <- local({
  registry <- NULL
  function() {
    if (!is.null(registry)) return(registry)
    obligation <- function(id, step, selector = "", kind) {
      list(obligation_id = id, step_id = step, selector = selector,
           expected_kind = kind)
    }
    claim <- function(id, theorem_kind, obligations) {
      list(claim_id = id, theorem_kind = theorem_kind,
           obligations = obligations,
           human_residual_status = "HUMAN_REVIEW_REQUIRED")
    }
    registry <<- list(
      claim("N3V5-C01", "frozen N1 import and exactly-one discount", list(
        obligation("C01.import.weak", "S01", kind = "formula"),
        obligation("C01.import.H0", "S02", kind = "formula"),
        obligation("C01.import.H1", "S03", kind = "formula"),
        obligation("C01.discount.weak", "S04", kind = "formula"),
        obligation("C01.discount.H0", "S05", kind = "formula"),
        obligation("C01.discount.H1", "S06", kind = "formula"))),
      claim("N3V5-C02", "weak ballot cutoff and equality", list(
        obligation("C02.weak.cutoff", "S08", kind = "weak_best_response"))),
      claim("N3V5-C03", "complete H best response", list(
        obligation("C03.H.map", "S09", kind = "H_best_response"))),
      claim("N3V5-C04", "proposer payoff after every proposal", list(
        obligation("C04.proposer.map", "S10", kind = "proposer_map"))),
      claim("N3V5-C05", "exhaustive E/S/P/R reduction", list(
        obligation("C05.proposer.map", "S10", kind = "proposer_map"),
        obligation("C05.hedge.reduction", "S20", kind = "hedge"),
        obligation("C05.argmax", "S21", kind = "argmax_correspondence"),
        obligation("C05.failure.deviation", "S15", kind = "formula"),
        obligation("C05.failure.dominated", "S17", kind = "strict_sign"))),
      claim("N3V5-C06", "full-pie use", list(
        obligation("C06.slack.fill", "S20", "slack_fill", "object"),
        obligation("C06.selected.regions", "S21", "regions", "list"),
        obligation("C06.selected.budgets", "S23", kind = "feasibility"))),
      claim("N3V5-C07", "strict hedge transformation", list(
        obligation("C07.exclusion.transform", "S20", "exclusion_y_zero", "object"),
        obligation("C07.selected.regions", "S21", "regions", "list"),
        obligation("C07.exclusion.budget", "S23", "base_budgets/E",
                   "budget_certificate"))),
      claim("N3V5-C08", "strict exclusion-over-delay and delay probability", list(
        obligation("C08.failure.payoff", "S15", kind = "formula"),
        obligation("C08.exclusion.strict", "S17", kind = "strict_sign"),
        obligation("C08.screening.regions", "S21", "regions", "list"),
        obligation("C08.delay.maps", "S27", "per_region", "list"))),
      claim("N3V5-C09", "branch feasibility", list(
        obligation("C09.feasibility", "S23", kind = "feasibility"))),
      claim("N3V5-C10", "disjoint exhaustive endpoint-complete partition", list(
        obligation("C10.partition", "S22", kind = "partition"))),
      claim("N3V5-C11", "residual E/P tie", list(
        obligation("C11.tie.regions", "S21", "regions", "list"),
        obligation("C11.tie.break", "S24", kind = "tie_break"),
        obligation("C11.mixture.simplex", "S26", kind = "identity_simplexes"),
        obligation("C11.mixture.maps", "S27", kind = "indexed_payoff_outcome_maps"))),
      claim("N3V5-C12", "identity-indexed simplexes", list(
        obligation("C12.identity.simplexes", "S26", kind = "identity_simplexes"),
        obligation("C12.identity.maps", "S27", kind = "indexed_payoff_outcome_maps"))),
      claim("N3V5-C13", "Bayes and off-path beliefs", list(
        obligation("C13.beliefs", "S25", kind = "belief_system"),
        obligation("C13.strategy.support", "S26", kind = "identity_simplexes"))),
      claim("N3V5-C14", "public H-vote update", list(
        obligation("C14.weak.vote", "S08", kind = "weak_best_response"),
        obligation("C14.H.vote", "S09", kind = "H_best_response"),
        obligation("C14.public.updates", "S25", kind = "belief_system"))),
      claim("N3V5-C15", "identity-indexed payoffs", list(
        obligation("C15.weak.identity.payoffs", "S27", "per_region", "list"),
        obligation("C15.identity.support", "S26", kind = "identity_simplexes"))),
      claim("N3V5-C16", "typed free-symbol closure", list(
        obligation("C16.record.scope", "S28",
                   kind = "record_scoped_free_symbol_closure"))),
      claim("N3V5-C17", "PBE witness in every cell", list(
        obligation("C17.domain.partition", "S22", kind = "partition"),
        obligation("C17.PBE.witnesses", "S29", kind = "PBE_witnesses")))
    )
    registry
  }
})

pk_claim_obligation_registry_sha256_v1 <- function() {
  "e5b0ab40bab6c6302a4a84d083b076c45a012c8799fcb6639689c8c600c4635d"
}

pk_claim_obligation_registry_lint <- function(registry =
                                                pk_claim_obligation_registry_v1()) {
  sc_assert(is.list(registry) && is.null(names(registry)) && length(registry) == 17L,
            "FAIL_COVERAGE", "POST_S29 claim registry must contain exactly 17 claims")
  expected_claim_ids <- sprintf("N3V5-C%02d", 1:17)
  all_obligations <- list()
  for (index in seq_along(registry)) {
    record <- registry[[index]]
    sc_assert(identical(names(record), c("claim_id", "theorem_kind", "obligations",
                                         "human_residual_status")) &&
                identical(record$claim_id, expected_claim_ids[[index]]) &&
                is.character(record$theorem_kind) && length(record$theorem_kind) == 1L &&
                nzchar(record$theorem_kind) &&
                is.list(record$obligations) && is.null(names(record$obligations)) &&
                length(record$obligations) > 0L &&
                identical(record$human_residual_status, "HUMAN_REVIEW_REQUIRED"),
              "FAIL_COVERAGE", paste("POST_S29 malformed claim registry record", index))
    for (obligation in record$obligations) {
      sc_assert(identical(names(obligation),
                          c("obligation_id", "step_id", "selector", "expected_kind")) &&
                  is.character(obligation$obligation_id) &&
                  length(obligation$obligation_id) == 1L &&
                  startsWith(obligation$obligation_id,
                             sprintf("C%02d.", index)) &&
                  obligation$step_id %in% sprintf("S%02d", 1:29) &&
                  is.character(obligation$selector) &&
                  length(obligation$selector) == 1L &&
                  is.character(obligation$expected_kind) &&
                  length(obligation$expected_kind) == 1L &&
                  nzchar(obligation$expected_kind),
                "FAIL_COVERAGE",
                paste("POST_S29 malformed obligation in", record$claim_id))
      all_obligations[[length(all_obligations) + 1L]] <- obligation
    }
  }
  obligation_ids <- vapply(all_obligations, `[[`, character(1), "obligation_id")
  sc_assert(length(all_obligations) == 42L && !anyDuplicated(obligation_ids),
            "FAIL_COVERAGE", "POST_S29 claim registry must contain 42 unique obligations")
  hash <- sc_sha256_text(pk_canonical_json(registry))
  sc_assert(identical(hash, pk_claim_obligation_registry_sha256_v1()),
            "FAIL_PACKAGE_INTEGRITY", "POST_S29 claim registry literal hash changed")
  list(status = "CLAIM_OBLIGATION_REGISTRY_LINTED", claim_count = 17L,
       obligation_count = 42L, obligation_ids = obligation_ids, sha256 = hash)
}

pk_ledger_formal_span_registry_v1 <- local({
  registry <- NULL
  function() {
    if (!is.null(registry)) return(registry)
    span <- function(id, claim, claim_ordinal, ordinal, start, end, text,
                     source_sha256, sort, normal_form, semantic_rule, refs) {
      list(span_id = id, claim_id = claim,
           claim_ordinal = as.integer(claim_ordinal), ordinal = as.integer(ordinal),
           byte_start = as.integer(start), byte_end = as.integer(end),
           exact_utf8 = text, source_sha256 = source_sha256, sort = sort,
           expected_normal_form = normal_form, semantic_rule = semantic_rule,
           obligation_ids = as.list(refs), binding_role = "FORMAL_SUBCLAIM")
    }
    registry <<- list(
      span("LEDGER-SPAN-01", "N3V5-C01", 1, 1, 18, 21, "1/m",
           "22bcf6396e37ddbc8da98843ab7f544e851a39180a57877e2af94282e6d21bc6",
           "Payoff", "binary(/,number(1),symbol(m))", "EXACT_ALGEBRA",
           "C01.import.weak"),
      span("LEDGER-SPAN-02", "N3V5-C01", 1, 2, 45, 52, "o_theta",
           "f0ddf54263ffdde4cc8b22d8ede5958fdbda3eb3634c3a95a344d80de4617771",
           "Payoff", "symbol(o_theta)", "TYPED_SYMBOL",
           c("C01.import.H0", "C01.import.H1")),
      span("LEDGER-SPAN-03", "N3V5-C01", 1, 3, 79, 83, "beta",
           "f44e64e75f3948e9f73f8dfa94721c4ce8cbb4f265c4790c702b2d41cfbf2753",
           "Probability", "symbol(beta)", "TYPED_SYMBOL",
           c("C01.discount.weak", "C01.discount.H0", "C01.discount.H1")),
      span("LEDGER-SPAN-04", "N3V5-C02", 2, 1, 44, 55, "x_j>=beta/m",
           "036920b47120f6a1c62a8c76b246cc741fe858c3c7351d2f2b710500398a0887",
           "Proposition", "compare(>=,symbol(x_j),binary(/,symbol(beta),symbol(m)))",
           "EXACT_COMPARISON",
           "C02.weak.cutoff"),
      span("LEDGER-SPAN-05", "N3V5-C07", 7, 1, 35, 38, "y>0",
           "0dcb2824833a57b86e0884cc474d856e52b3360379c0b44427fb674278fb1c66",
           "Proposition", "compare(>,symbol(y),number(0))", "EXACT_COMPARISON",
           "C07.exclusion.transform"),
      span("LEDGER-SPAN-06", "N3V5-C07", 7, 2, 124, 127, "y=0",
           "c49641d768f5b8cbcc21a5240d08377e53cb8f8901b935eb2f91cd7ac670a0f7",
           "Proposition", "compare(=,symbol(y),number(0))", "EXACT_COMPARISON",
           "C07.exclusion.transform"),
      span("LEDGER-SPAN-07", "N3V5-C08", 8, 1, 24, 30, "beta/m",
           "48603e01264781ad752f0aa76923bee1c1c139369780916a326a6250fb275841",
           "Payoff", "binary(/,symbol(beta),symbol(m))", "EXACT_ALGEBRA",
           "C08.failure.payoff"),
      span("LEDGER-SPAN-08", "N3V5-C08", 8, 2, 73, 85, "1-beta*q/m>0",
           "efed0dfc350a768d9d53723feb9933ebc95514fc0b0b30854649406e03502308",
           "Proposition",
           "compare(>,binary(-,number(1),binary(/,binary(*,symbol(beta),symbol(q)),symbol(m))),number(0))",
           "EXACT_COMPARISON",
           "C08.exclusion.strict"),
      span("LEDGER-SPAN-09", "N3V5-C08", 8, 3, 129, 131, "nu",
           "3086cf468ccca87cc7840e0755947526a039eea35f486002d7f1c53d7c58686a",
           "Probability", "symbol(nu)", "TYPED_SYMBOL",
           "C08.delay.maps"),
      span("LEDGER-SPAN-10", "N3V5-C11", 11, 1, 13, 16, "E=P",
           "393dbbc38ab9c09e0a0ea83eba459f91310181dc0335863dd51a26afb08666e2",
           "Proposition", "compare(=,symbol(E),symbol(P))", "EXACT_COMPARISON",
           "C11.tie.break"),
      span("LEDGER-SPAN-11", "N3V5-C17", 17, 1, 90, 103, "beta in (0,1)",
           "d3af80e669f72032022d92932c3c56befd932f8339ef36d67057a20a4113ebdc",
           "Proposition", "in(symbol[Probability](beta),interval(open,0,1,open))",
           "INTERVAL_MEMBERSHIP",
           "C17.domain.partition"))
    registry
  }
})

pk_ledger_formal_span_registry_sha256_v1 <- function() {
  "41429a0fca9e2f1b4d73a7b5159eee4eafe42df39f584548e86cc4231d88afd5"
}

pk_ledger_formal_span_registry_lint <- function(
    registry = pk_ledger_formal_span_registry_v1(), claim_lint =
      pk_claim_obligation_registry_lint()) {
  sc_assert(is.list(registry) && is.null(names(registry)) && length(registry) == 11L,
            "FAIL_COVERAGE", "POST_S29 ledger span registry must contain 11 spans")
  span_ids <- character(0); keys <- character(0)
  for (index in seq_along(registry)) {
    span <- registry[[index]]
    sc_assert(identical(names(span), c("span_id", "claim_id", "claim_ordinal", "ordinal",
                                       "byte_start", "byte_end", "exact_utf8",
                                       "source_sha256", "sort", "expected_normal_form",
                                       "semantic_rule", "obligation_ids", "binding_role")) &&
                identical(span$span_id, sprintf("LEDGER-SPAN-%02d", index)) &&
                identical(span$claim_id, sprintf("N3V5-C%02d", span$claim_ordinal)) &&
                is.integer(span$claim_ordinal) && length(span$claim_ordinal) == 1L &&
                span$claim_ordinal %in% 1:17 &&
                is.integer(span$ordinal) && length(span$ordinal) == 1L &&
                span$ordinal >= 1L && is.integer(span$byte_start) &&
                is.integer(span$byte_end) && span$byte_start >= 0L &&
                span$byte_end > span$byte_start && is.character(span$exact_utf8) &&
                length(span$exact_utf8) == 1L && nzchar(span$exact_utf8) &&
                identical(sc_sha256_text(span$exact_utf8), span$source_sha256) &&
                span$sort %in% c("Payoff", "Probability", "Proposition") &&
                is.character(span$expected_normal_form) &&
                length(span$expected_normal_form) == 1L &&
                span$semantic_rule %in% c("EXACT_ALGEBRA", "TYPED_SYMBOL",
                                          "EXACT_COMPARISON", "INTERVAL_MEMBERSHIP") &&
                is.list(span$obligation_ids) && is.null(names(span$obligation_ids)) &&
                length(span$obligation_ids) >= 1L &&
                all(vapply(span$obligation_ids, function(id) {
                  is.character(id) && length(id) == 1L &&
                    id %in% claim_lint$obligation_ids &&
                    startsWith(id, sprintf("C%02d.", span$claim_ordinal))
                }, logical(1))) && identical(span$binding_role, "FORMAL_SUBCLAIM"),
              "FAIL_BINDING", paste("POST_S29 malformed ledger span", index))
    span_ids <- c(span_ids, span$span_id)
    keys <- c(keys, paste(span$claim_ordinal, span$ordinal, sep = ":"))
  }
  sc_assert(!anyDuplicated(span_ids) && !anyDuplicated(keys), "FAIL_COVERAGE",
            "POST_S29 ledger span IDs or claim ordinals are duplicated")
  hash <- sc_sha256_text(pk_canonical_json(registry))
  sc_assert(identical(hash, pk_ledger_formal_span_registry_sha256_v1()),
            "FAIL_PACKAGE_INTEGRITY", "POST_S29 ledger span registry literal hash changed")
  list(status = "LEDGER_FORMAL_SPAN_REGISTRY_LINTED", span_count = 11L,
       span_ids = span_ids, sha256 = hash)
}

pk_ledger_span_map <- function() {
  registry <- pk_ledger_formal_span_registry_v1()
  output <- list()
  for (entry in registry) {
    key <- as.character(entry$claim_ordinal)
    if (is.null(output[[key]])) output[[key]] <- list()
    output[[key]][[length(output[[key]]) + 1L]] <- list(
      entry$byte_start, entry$byte_end, entry$sort,
      entry$obligation_ids, entry$span_id, entry$binding_role)
  }
  output
}

pk_raw_slice_text <- function(raw, byte_start, byte_end) {
  sc_assert(byte_start >= 0L && byte_end > byte_start && byte_end <= length(raw),
            "FAIL_BINDING", "invalid ledger byte span")
  rawToChar(raw[(byte_start + 1L):byte_end])
}

pk_parse_open_interval_membership <- function(text, sorts) {
  # This production is intentionally exact and consumes the complete span;
  # there is no prose or token fallback inside the formal interval.
  sc_assert(identical(text, "beta in (0,1)"), "FAIL_PARSE",
            "open-interval membership does not match its path grammar")
  sc_assert(identical(sorts$beta, "Probability"), "FAIL_TYPE",
            "beta lost its probability sort")
  list(kind = "interval_membership", sort = "Proposition",
       element = pk_sym("beta", sorts), interval = list(
         kind = "interval", endpoint_sort = "Probability",
         lower = pk_num(0), upper = pk_num(1),
         lower_closed = FALSE, upper_closed = FALSE))
}

pk_ledger_expected_ast <- function(index, ordinal, core, sorts) {
  zero <- pk_num(0)
  if (index == 1L && ordinal == 1L) return(core$imported_c$ast)
  if (index == 1L && ordinal == 2L) return(pk_sym("o_theta", sorts))
  if (index == 1L && ordinal == 3L) return(pk_sym("beta", sorts))
  if (index == 2L) return(pk_compare(">=", pk_sym("x_j", sorts), core$c_value$ast))
  if (index == 7L && ordinal == 1L) return(pk_compare(">", pk_sym("y", sorts), zero))
  if (index == 7L && ordinal == 2L) return(pk_compare("=", pk_sym("y", sorts), zero))
  if (index == 8L && ordinal == 1L) return(core$c_value$ast)
  if (index == 8L && ordinal == 2L) {
    return(pk_compare(">", core$strict$formula$ast, zero))
  }
  if (index == 8L && ordinal == 3L) return(pk_sym("nu", sorts))
  if (index == 11L) {
    local <- sorts; local$E <- "Payoff"; local$P <- "Payoff"
    return(pk_compare("=", pk_sym("E", local), pk_sym("P", local)))
  }
  if (index == 17L) return(pk_parse_open_interval_membership("beta in (0,1)", sorts))
  sc_abort("FAIL_CERTIFICATE", "unknown ledger formal obligation")
}

pk_ledger_ast_nf <- function(ast) {
  if (identical(ast$kind, "interval_membership")) {
    return("in(symbol[Probability](beta),interval(open,0,1,open))")
  }
  sc_ast_canonical(ast)
}

pk_parse_ledger_span <- function(text, index, ordinal, expected_sort, core, sorts) {
  local <- sorts
  if (index == 11L) { local$E <- "Payoff"; local$P <- "Payoff" }
  actual <- if (index == 17L) {
    pk_parse_open_interval_membership(text, local)
  } else sc_parse_complete(text, local, expected_sort)
  expected <- pk_ledger_expected_ast(index, ordinal, core, local)
  equivalent <- if (identical(actual$kind, "compare") &&
                    identical(expected$kind, "compare")) {
    identical(actual$operator, expected$operator) &&
      ea_rat_equal(ea_ast_to_rat(actual$left), ea_ast_to_rat(expected$left)) &&
      ea_rat_equal(ea_ast_to_rat(actual$right), ea_ast_to_rat(expected$right))
  } else if (identical(actual$kind, "interval_membership") &&
             identical(expected$kind, "interval_membership")) {
    identical(pk_ledger_ast_nf(actual), pk_ledger_ast_nf(expected))
  } else {
    ea_rat_equal(ea_ast_to_rat(actual), ea_ast_to_rat(expected))
  }
  sc_assert(isTRUE(equivalent),
            "FAIL_EQUIVALENCE", "ledger formula span differs from its kernel obligation")
  list(ast = actual, normal_form = pk_ledger_ast_nf(actual))
}

pk_ledger_claim_segments <- function(text, index, core, sorts, document_hash) {
  raw <- charToRaw(enc2utf8(text)); total <- length(raw)
  specs <- pk_ledger_span_map()[[as.character(index)]]
  if (is.null(specs)) {
    return(list(list(kind = "human_prose", byte_start = 0L, byte_end = total,
                          source_sha256 = sc_sha256_text(text),
                          document_sha256 = document_hash,
                          status = "HUMAN_REVIEW_REQUIRED")))
  }
  segments <- list(); cursor <- 0L
  for (ordinal in seq_along(specs)) {
    spec <- specs[[ordinal]]; start <- spec[[1L]]; end <- spec[[2L]]
    sc_assert(start >= cursor && end > start && end <= total, "FAIL_BINDING",
              "ledger formal spans overlap, vanish, or leave the string")
    if (start > cursor) {
      prose <- pk_raw_slice_text(raw, cursor, start)
      segments[[length(segments) + 1L]] <- list(
        kind = "human_prose", byte_start = cursor, byte_end = start,
        source_sha256 = sc_sha256_text(prose), document_sha256 = document_hash,
        status = "HUMAN_REVIEW_REQUIRED")
    }
    formal <- pk_raw_slice_text(raw, start, end)
    parsed <- pk_parse_ledger_span(formal, index, ordinal, spec[[3L]], core, sorts)
    segments[[length(segments) + 1L]] <- list(
      kind = "formal_math", byte_start = start, byte_end = end,
      source_sha256 = sc_sha256_text(formal), document_sha256 = document_hash,
      sort = spec[[3L]], ast = parsed$ast, normal_form = parsed$normal_form,
      span_id = spec[[5L]], obligation_ids = spec[[4L]],
      binding_role = spec[[6L]], status = "EXACTLY_BOUND")
    cursor <- end
  }
  if (cursor < total) {
    prose <- pk_raw_slice_text(raw, cursor, total)
    segments[[length(segments) + 1L]] <- list(
      kind = "human_prose", byte_start = cursor, byte_end = total,
      source_sha256 = sc_sha256_text(prose), document_sha256 = document_hash,
      status = "HUMAN_REVIEW_REQUIRED")
  }
  starts <- vapply(segments, `[[`, integer(1), "byte_start")
  ends <- vapply(segments, `[[`, integer(1), "byte_end")
  sc_assert(starts[[1L]] == 0L && ends[[length(ends)]] == total &&
              all(ends > starts) &&
              (length(segments) == 1L || all(starts[-1L] == ends[-length(ends)])),
            "FAIL_COVERAGE", "ledger claim bytes are not partitioned exactly once")
  segments
}

pk_load_claim_registry <- function(core, sorts,
    path = "model_redesign/essential_input_n3_claim_ledger_v5.json") {
  frozen_hash <- "99a20b0137dbebb6d27d64e870ac11de5cdec8e1997b41dcd92cc647c521dcc1"
  sc_assert(identical(path, "model_redesign/essential_input_n3_claim_ledger_v5.json") &&
              file.exists(path) && identical(sc_sha256_file(path), frozen_hash),
            "FAIL_BINDING", "claim ledger is not the frozen source")
  ledger <- sc_read_json_strict(path)
  sc_assert(identical(names(ledger), c("schema_version", "node", "candidate_status",
                                       "source_interface", "equilibrium_ids", "claims")) &&
              identical(ledger$schema_version, "essential-input-claim-ledger-v5") &&
              identical(ledger$node, "N3") &&
              identical(ledger$candidate_status, "pending_independent_review") &&
              identical(ledger$source_interface$record_id, "N1-EQ-01") &&
              identical(ledger$source_interface$artifact_hash,
                        "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5") &&
              length(ledger$equilibrium_ids) == 11L && length(ledger$claims) == 17L,
            "FAIL_BINDING", "claim ledger header or cardinality changed")
  expected_ids <- sprintf("N3V5-C%02d", 1:17)
  expected_branches <- c("continuation", "weak ballot", "H ballot", "proposer deviations",
                         "candidate reduction", "P0", "P1 and P1a", "delay",
                         "feasibility", "partition", "o_1=1/m", "multiplicity",
                         "beliefs", "P7", "weak payoff map", "transport sufficiency",
                         "existence")
  records <- lapply(seq_along(ledger$claims), function(index) {
    claim <- ledger$claims[[index]]
    sc_assert(identical(names(claim), c("claim_id", "equilibrium_ids", "branch",
                                        "payoff_date", "claim", "status", "evidence")) &&
                identical(claim$claim_id, expected_ids[[index]]) &&
                identical(claim$equilibrium_ids, ledger$equilibrium_ids) &&
                identical(claim$branch, expected_branches[[index]]) &&
                identical(claim$payoff_date, "R1 current units") &&
                identical(claim$status, "proved") &&
                identical(claim$evidence, paste0(
                  "model_redesign/essential_input_n3_r1_majority_derivation_v5.md#claim-n3v5-c",
                  sprintf("%02d", index))),
              "FAIL_BINDING", paste("claim registry structure changed at", index))
    list(claim_id = claim$claim_id, ordinal = index, branch = claim$branch,
         payoff_date = claim$payoff_date, equilibrium_ids = claim$equilibrium_ids,
         source_pointer = paste0("/claims/", index - 1L, "/claim"),
         source_sha256 = sc_sha256_text(claim$claim),
         document_sha256 = frozen_hash,
         segments = pk_ledger_claim_segments(claim$claim, index, core, sorts, frozen_hash),
         machine_scope = "FORMAL_SPANS_AND_STRUCTURAL_BINDING_ONLY",
         human_residual_status = "HUMAN_REVIEW_REQUIRED")
  })
  list(path = path, sha256 = frozen_hash, records = records,
       equilibrium_ids = ledger$equilibrium_ids)
}

pk_assert_claim_registry_postload <- function(registry, core, sorts) {
  claim_lint <- pk_claim_obligation_registry_lint()
  span_lint <- pk_ledger_formal_span_registry_lint(claim_lint = claim_lint)
  frozen_path <- "model_redesign/essential_input_n3_claim_ledger_v5.json"
  frozen_hash <- "99a20b0137dbebb6d27d64e870ac11de5cdec8e1997b41dcd92cc647c521dcc1"
  expected_equilibrium_ids <- as.list(c(
    "N3V5-EQ-O1LT-LOW", "N3V5-EQ-O1LT-POOL", "N3V5-EQ-CROSS-LOW",
    "N3V5-EQ-CROSS-EXCLUDE", "N3V5-EQ-O0GT-EXCLUDE",
    "N3V5-EQ-O0EQ-LOW-ENDPOINT", "N3V5-EQ-O0EQ-EXCLUDE",
    "N3V5-EQ-O1EQ-LOW", "N3V5-EQ-O1EQ-EXCLUDE", "N3V5-EQ-O1EQ-POOL",
    "N3V5-EQ-O1EQ-MIXED-EP"))
  sc_assert(is.list(registry) &&
              identical(names(registry), c("path", "sha256", "records",
                                            "equilibrium_ids")) &&
              identical(registry$path, frozen_path) &&
              identical(registry$sha256, frozen_hash) &&
              identical(registry$equilibrium_ids, expected_equilibrium_ids) &&
              is.list(registry$records) && is.null(names(registry$records)) &&
              length(registry$records) == 17L,
            "FAIL_COVERAGE", "POST_S29 loaded claim registry root is open or incomplete")
  sc_assert(file.exists(frozen_path) && identical(sc_sha256_file(frozen_path), frozen_hash),
            "FAIL_BINDING", "POST_S29 frozen ledger bytes changed")
  ledger <- sc_read_json_strict(frozen_path)
  sc_assert(identical(ledger$equilibrium_ids, expected_equilibrium_ids) &&
              length(ledger$claims) == 17L,
            "FAIL_BINDING", "POST_S29 frozen ledger identity set changed")
  span_registry <- pk_ledger_formal_span_registry_v1()
  expected_segment_counts <- c(7L, 3L, 1L, 1L, 1L, 1L, 5L, 7L, 1L,
                               1L, 3L, 1L, 1L, 1L, 1L, 1L, 3L)
  branch_literals <- c("continuation", "weak ballot", "H ballot",
                       "proposer deviations", "candidate reduction", "P0",
                       "P1 and P1a", "delay", "feasibility", "partition",
                       "o_1=1/m", "multiplicity", "beliefs", "P7",
                       "weak payoff map", "transport sufficiency", "existence")
  formal_count <- 0L; human_count <- 0L
  for (index in seq_len(17L)) {
    record <- registry$records[[index]]; source <- ledger$claims[[index]]
    sc_assert(identical(names(record),
                        c("claim_id", "ordinal", "branch", "payoff_date",
                          "equilibrium_ids", "source_pointer", "source_sha256",
                          "document_sha256", "segments", "machine_scope",
                          "human_residual_status")) &&
                identical(record$claim_id, sprintf("N3V5-C%02d", index)) &&
                identical(record$ordinal, index) && identical(record$branch,
                                                               branch_literals[[index]]) &&
                identical(record$payoff_date, "R1 current units") &&
                identical(record$equilibrium_ids, expected_equilibrium_ids) &&
                identical(record$source_pointer,
                          paste0("/claims/", index - 1L, "/claim")) &&
                identical(record$source_sha256, sc_sha256_text(source$claim)) &&
                identical(record$document_sha256, frozen_hash) &&
                is.list(record$segments) && is.null(names(record$segments)) &&
                length(record$segments) == expected_segment_counts[[index]] &&
                identical(record$machine_scope,
                          "FORMAL_SPANS_AND_STRUCTURAL_BINDING_ONLY") &&
                identical(record$human_residual_status, "HUMAN_REVIEW_REQUIRED"),
              "FAIL_COVERAGE", paste("POST_S29 claim record shape changed at", index))
    raw <- charToRaw(enc2utf8(source$claim)); total <- length(raw)
    formal_specs <- Filter(function(entry) entry$claim_ordinal == index,
                           span_registry)
    expected_parts <- list(); cursor <- 0L
    for (entry in formal_specs) {
      if (entry$byte_start > cursor) {
        expected_parts[[length(expected_parts) + 1L]] <-
          list(kind = "human_prose", start = cursor, end = entry$byte_start,
               span = NULL)
      }
      expected_parts[[length(expected_parts) + 1L]] <-
        list(kind = "formal_math", start = entry$byte_start,
             end = entry$byte_end, span = entry)
      cursor <- entry$byte_end
    }
    if (cursor < total) {
      expected_parts[[length(expected_parts) + 1L]] <-
        list(kind = "human_prose", start = cursor, end = total, span = NULL)
    }
    if (!length(expected_parts)) {
      expected_parts <- list(list(kind = "human_prose", start = 0L,
                                  end = total, span = NULL))
    }
    sc_assert(length(expected_parts) == length(record$segments), "FAIL_COVERAGE",
              paste("POST_S29 segment partition cardinality changed at", index))
    for (part_index in seq_along(expected_parts)) {
      expected <- expected_parts[[part_index]]; actual <- record$segments[[part_index]]
      slice <- pk_raw_slice_text(raw, expected$start, expected$end)
      if (identical(expected$kind, "human_prose")) {
        sc_assert(identical(names(actual),
                            c("kind", "byte_start", "byte_end", "source_sha256",
                              "document_sha256", "status")) &&
                    identical(actual$kind, "human_prose") &&
                    identical(actual$byte_start, expected$start) &&
                    identical(actual$byte_end, expected$end) &&
                    identical(actual$source_sha256, sc_sha256_text(slice)) &&
                    identical(actual$document_sha256, frozen_hash) &&
                    identical(actual$status, "HUMAN_REVIEW_REQUIRED"),
                  "FAIL_BINDING", paste("POST_S29 human segment changed at", index,
                                         part_index))
        human_count <- human_count + 1L
      } else {
        span <- expected$span
        sc_assert(identical(names(actual),
                            c("kind", "byte_start", "byte_end", "source_sha256",
                              "document_sha256", "sort", "ast", "normal_form",
                              "span_id", "obligation_ids", "binding_role", "status")) &&
                    identical(actual$kind, "formal_math") &&
                    identical(actual$byte_start, span$byte_start) &&
                    identical(actual$byte_end, span$byte_end) &&
                    identical(slice, span$exact_utf8) &&
                    identical(actual$source_sha256, span$source_sha256) &&
                    identical(actual$document_sha256, frozen_hash) &&
                    identical(actual$sort, span$sort) &&
                    identical(actual$normal_form, span$expected_normal_form) &&
                    identical(actual$span_id, span$span_id) &&
                    identical(actual$obligation_ids, span$obligation_ids) &&
                    identical(actual$binding_role, "FORMAL_SUBCLAIM") &&
                    identical(actual$status, "EXACTLY_BOUND"),
                  "FAIL_BINDING", paste("POST_S29 formal segment binding changed at",
                                         span$span_id))
        parsed <- pk_parse_ledger_span(slice, index, span$ordinal, span$sort,
                                       core, sorts)
        sc_assert(identical(sc_typed_ast_canonical(actual$ast),
                            sc_typed_ast_canonical(parsed$ast)) &&
                    identical(parsed$normal_form, span$expected_normal_form),
                  "FAIL_EQUIVALENCE", paste("POST_S29 formal segment AST changed at",
                                             span$span_id))
        formal_count <- formal_count + 1L
      }
    }
  }
  sc_assert(formal_count == 11L && human_count == 28L,
            "FAIL_COVERAGE", "POST_S29 ledger segmentation must be 11 formal plus 28 human")
  list(status = "CLAIM_REGISTRY_POSTLOAD_CHECKED", claim_count = 17L,
       formal_segment_count = formal_count, human_segment_count = human_count,
       claim_registry_sha256 = claim_lint$sha256,
       span_registry_sha256 = span_lint$sha256)
}

pk_resolve_selector <- function(value, selector) {
  if (!nzchar(selector)) return(value)
  parts <- strsplit(selector, "/", fixed = TRUE)[[1L]]
  current <- value
  for (part in parts) {
    sc_assert(is.list(current) && part %in% names(current), "FAIL_CERTIFICATE",
              paste("claim obligation selector is missing", selector))
    current <- current[[part]]
  }
  current
}

pk_validate_obligation_kind <- function(value, expected_kind, obligation_id) {
  if (expected_kind == "list") {
    sc_assert(is.list(value), "FAIL_CERTIFICATE",
              paste(obligation_id, "is not a list obligation"))
  } else if (expected_kind == "object") {
    sc_assert(is.list(value) && length(value) > 0L, "FAIL_CERTIFICATE",
              paste(obligation_id, "is not a typed object obligation"))
  } else {
    sc_assert(is.list(value) && identical(value$kind, expected_kind),
              "FAIL_CERTIFICATE", paste(obligation_id, "has wrong obligation kind"))
  }
  invisible(TRUE)
}

pk_certificate_source_binding <- function(source) {
  formal <- Filter(function(segment) identical(segment$kind, "formal_math"),
                   source$segments)
  list(pointer = source$source_pointer,
       leaf_sha256 = source$source_sha256,
       document_sha256 = source$document_sha256,
       span_ids = lapply(formal, `[[`, "span_id"),
       formal_span_hashes = lapply(formal, `[[`, "source_sha256"),
       claim_obligation_registry_sha256 =
         pk_claim_obligation_registry_sha256_v1(),
       ledger_span_registry_sha256 = pk_ledger_formal_span_registry_sha256_v1())
}

pk_certificate_payload <- function(certificate) {
  list(certificate_id = certificate$certificate_id,
       claim_id = certificate$claim_id,
       theorem_kind = certificate$theorem_kind,
       obligations = certificate$obligations,
       source_binding = certificate$source_binding,
       machine_scope = certificate$machine_scope,
       human_residual_status = certificate$human_residual_status,
       status = certificate$status)
}

# This post-load checker deliberately does not call
# pk_certificate_source_binding(): that function belongs to assembly.  Exact
# keys and values are reconstructed here from the frozen source record and the
# independently linted literal registries, so a common-mode constructor edit
# cannot enlarge or redirect the certificate binding.
pk_assert_certificate_source_binding_independent <- function(binding, source) {
  sc_assert(is.list(binding) &&
              identical(names(binding),
                        c("pointer", "leaf_sha256", "document_sha256",
                          "span_ids", "formal_span_hashes",
                          "claim_obligation_registry_sha256",
                          "ledger_span_registry_sha256")),
            "FAIL_COVERAGE",
            "POST_S29 certificate source binding is open or incomplete")
  formal <- Filter(function(segment) identical(segment$kind, "formal_math"),
                   source$segments)
  claim_lint <- pk_claim_obligation_registry_lint()
  span_lint <- pk_ledger_formal_span_registry_lint(claim_lint = claim_lint)
  expected <- list(
    pointer = source$source_pointer,
    leaf_sha256 = source$source_sha256,
    document_sha256 = source$document_sha256,
    span_ids = lapply(formal, `[[`, "span_id"),
    formal_span_hashes = lapply(formal, `[[`, "source_sha256"),
    claim_obligation_registry_sha256 = claim_lint$sha256,
    ledger_span_registry_sha256 = span_lint$sha256)
  sc_assert(identical(binding, expected), "FAIL_BINDING",
            "POST_S29 certificate source binding differs from frozen registries")
  invisible(TRUE)
}

# Independent hash payload reconstruction.  The assembler may use
# pk_certificate_payload(), but the verifier never trusts that helper.
pk_certificate_payload_independent <- function(certificate) {
  list(certificate_id = certificate$certificate_id,
       claim_id = certificate$claim_id,
       theorem_kind = certificate$theorem_kind,
       obligations = certificate$obligations,
       source_binding = certificate$source_binding,
       machine_scope = certificate$machine_scope,
       human_residual_status = certificate$human_residual_status,
       status = certificate$status)
}

pk_assert_certificates_postload <- function(certificates, specification, values,
                                             claim_registry) {
  sc_assert(is.list(certificates) && is.null(names(certificates)) &&
              length(certificates) == 17L,
            "FAIL_COVERAGE", "POST_S29 certificate list must contain 17 records")
  obligation_count <- 0L
  for (index in seq_len(17L)) {
    certificate <- certificates[[index]]; spec <- specification[[index]]
    source <- claim_registry$records[[index]]
    sc_assert(identical(names(certificate),
                        c("certificate_id", "claim_id", "theorem_kind", "obligations",
                          "certificate_hash", "source_binding", "machine_scope",
                          "human_residual_status", "status")) &&
                identical(certificate$certificate_id,
                          paste0("CERT-", spec$claim_id)) &&
                identical(certificate$claim_id, spec$claim_id) &&
                identical(certificate$theorem_kind, spec$theorem_kind) &&
                is.list(certificate$obligations) &&
                is.null(names(certificate$obligations)) &&
                length(certificate$obligations) == length(spec$obligations) &&
                is.list(certificate$source_binding) &&
                identical(certificate$machine_scope,
                          "FORMAL_SPANS_AND_STRUCTURAL_BINDING_ONLY") &&
                identical(certificate$human_residual_status,
                          "HUMAN_REVIEW_REQUIRED") &&
                identical(certificate$status, "FORMAL_COMPONENTS_REPLAYED"),
              "FAIL_COVERAGE", paste("POST_S29 certificate shape changed at", index))
    pk_assert_certificate_source_binding_independent(
      certificate$source_binding, source)
    for (ordinal in seq_along(spec$obligations)) {
      obligation <- certificate$obligations[[ordinal]]
      expected <- spec$obligations[[ordinal]]
      sc_assert(identical(names(obligation),
                          c("obligation_id", "step_id", "selector", "expected_kind",
                            "conclusion_hash", "status")) &&
                  identical(obligation$obligation_id, expected$obligation_id) &&
                  identical(obligation$step_id, expected$step_id) &&
                  identical(obligation$selector, expected$selector) &&
                  identical(obligation$expected_kind, expected$expected_kind) &&
                  identical(obligation$status, "FORMAL_OBLIGATION_REPLAYED"),
                "FAIL_BINDING", paste("POST_S29 certificate obligation changed at",
                                       spec$claim_id, ordinal))
      value <- pk_resolve_selector(values[[expected$step_id]], expected$selector)
      pk_validate_obligation_kind(value, expected$expected_kind,
                                  expected$obligation_id)
      sc_assert(identical(obligation$conclusion_hash, pk_object_hash(value)),
                "FAIL_CERTIFICATE", paste("POST_S29 conclusion hash changed for",
                                           expected$obligation_id))
      obligation_count <- obligation_count + 1L
    }
    sc_assert(is.character(certificate$certificate_hash) &&
                length(certificate$certificate_hash) == 1L &&
                grepl("^[0-9a-f]{64}$", certificate$certificate_hash) &&
                identical(certificate$certificate_hash,
                          pk_object_hash(pk_certificate_payload_independent(certificate))),
              "FAIL_CERTIFICATE", paste("POST_S29 full certificate hash changed at", index))
  }
  sc_assert(obligation_count == 42L, "FAIL_COVERAGE",
            "POST_S29 certificates must contain exactly 42 obligations")
  list(status = "CERTIFICATES_POSTLOAD_CHECKED", certificate_count = 17L,
       obligation_count = obligation_count)
}

pk_assert_final_replay_wrapper <- function(result, primitives, n1) {
  sc_assert(is.list(result) &&
              identical(names(result), c("values", "certificates", "claim_registry",
                                          "shape_audit", "regions", "partition",
                                          "witnesses", "status")) &&
              identical(result$status, "INTERNAL_REPLAY_NOT_READY"),
            "FAIL_COVERAGE", "POST_S29 final replay wrapper is open or reordered")
  sc_assert(identical(result$regions, result$values$S21$regions) &&
              identical(result$partition, result$values$S22) &&
              identical(result$witnesses, result$values$S29$witnesses),
            "FAIL_BINDING", "POST_S29 final aliases are not replay-owned values")
  sc_assert(is.list(result$shape_audit) &&
              identical(result$shape_audit$status, "SHAPE_REGISTRY_CLOSED") &&
              identical(result$shape_audit$node_count,
                        pk_replay_shape_registry_v1()$expected_node_count),
            "FAIL_COVERAGE", "POST_S29 value-shape audit is missing or stale")
  core <- pk_expected_core(primitives, primitives$symbols, n1)
  registry_audit <- pk_assert_claim_registry_postload(
    result$claim_registry, core, primitives$symbols)
  specification <- pk_claim_obligation_registry_v1()
  certificate_audit <- pk_assert_certificates_postload(
    result$certificates, specification, result$values, result$claim_registry)
  nonvacuity_audit <- pk_assert_nonvacuity_layer(
    result$values$S21$regions,
    result$values$S22$exact_nonvacuity_witnesses,
    result$values$S29$witnesses)
  sc_assert(identical(registry_audit$formal_segment_count, 11L) &&
              identical(registry_audit$human_segment_count, 28L) &&
              identical(certificate_audit$obligation_count, 42L) &&
              identical(nonvacuity_audit$witness_count, 11L),
            "FAIL_COVERAGE", "POST_S29 certification denominator changed")
  invisible(TRUE)
}

# Context-owned scalar leaves for the S01--S29 representation.  The table is
# literal and exhaustive: every object field without a container child owns a
# distinct leaf schema.  No leaf role is inferred from a replayed value.
pk_replay_context_leaf_contract_v1 <- local({
  contract <- NULL
  function() {
    if (!is.null(contract)) return(contract)
    entries <- list()
    add <- function(edges, storage_type = "character", allowed = NULL,
                    pattern = NULL, rule = "SCALAR_DOMAIN") {
      for (edge in edges) {
        sc_assert(is.null(entries[[edge]]), "FAIL_COVERAGE",
                  paste("LEAF_CONTRACT duplicate edge", edge))
        entries[[edge]] <<- list(
          node_type = "leaf", atomic_type = "context_scalar", edge = edge,
          storage_type = storage_type,
          allowed_values = if (is.null(allowed)) NULL else as.list(allowed),
          pattern = pattern, semantic_rule = rule)
      }
    }
    kind_values <- c(
      formula = "formula", number = "number", symbol = "symbol",
      bound_symbol = "bound_symbol", set_symbol = "set_symbol", binary = "binary",
      unary = "unary", compare = "compare", logical = "logical", call = "call",
      indexed_symbol = "indexed_symbol", indexed_sum = "indexed_sum",
      quantifier = "quantifier", binder = "binder",
      set_difference = "set_difference", singleton = "singleton",
      cardinality_constraint = "cardinality_constraint",
      membership_constraint = "membership_constraint",
      not_equal_constraint = "not_equal_constraint", domain_one = "domain",
      domain_two = "domain", quota = "quota",
      integer_parity_case_split = "integer_parity_case_split",
      weak_best_response = "weak_best_response", H_best_response = "H_best_response",
      proposer_map = "proposer_map", budget_witness = "budget_witness",
      differences = "differences", strict_sign = "strict_sign",
      trusted_denominator_provenance = "trusted_denominator_provenance",
      linear_solution = "linear_solution", strict_nonzero = "strict_nonzero",
      frontier_certificate = "frontier_certificate", hedge = "hedge",
      argmax_correspondence = "argmax_correspondence", interval = "interval",
      partition = "partition", feasibility = "feasibility",
      budget_certificate = "budget_certificate", tie_break = "tie_break",
      identity_simplexes = "identity_simplexes", identity_simplex = "identity_simplex",
      cartesian_identity_assignment = "cartesian_identity_assignment",
      full_labeled_simplex = "full_labeled_simplex", bayes_fraction = "bayes_fraction",
      free_probability = "free_probability", closed_interval = "closed_interval",
      separating_H_vote = "separating_H_vote",
      nonseparating_H_vote = "nonseparating_H_vote", belief_system = "belief_system",
      indexed_formula_plain = "indexed_formula",
      indexed_formula_domain = "indexed_formula",
      indexed_payoff_outcome_maps = "indexed_payoff_outcome_maps",
      record_scoped_free_symbol_closure = "record_scoped_free_symbol_closure",
      PBE_witnesses = "PBE_witnesses")
    for (name in names(kind_values)) {
      add(paste0("K:", name, "/kind"), allowed = kind_values[[name]],
          rule = "EXACT_KIND_DISCRIMINATOR")
    }
    add("K:formula/normal_form", pattern = "^.+$", rule = "FORMULA_NF")
    add("K:formula/rule", allowed = c("IMPORT_EXACT", "DISCOUNT_ONCE", "QUOTA_EVAL",
      "PAYOFF_EVAL", "BEST_RESPONSE", "ALGEBRA_EQ", "SIGN_FROM_DOMAIN",
      "BUDGET_SATURATION", "HEDGE_TRANSFORM", "ARGMAX_BY_CASES",
      "SOLVE_LINEAR_INEQUALITY", "INTERVAL_PARTITION", "FEASIBILITY", "TIE_BREAK",
      "BAYES", "SIMPLEX_SUM", "INDEXED_SUM", "FREE_SYMBOL_CLOSURE", "PBE_WITNESS"),
      rule = "FORMULA_RULE")
    add("K:number/sort", allowed = "Rational", rule = "AST_SORT")
    # Third independent enforcement of the canonical numeral language.  This
    # literal is registry-owned and hash-pinned; it is not obtained from either
    # parser or proof-typechecker code.
    add("K:number/value", pattern = "^(?:0|[1-9][0-9]*)$",
        rule = "CANONICAL_NUMBER")
    add(c("K:symbol/sort", "K:bound_symbol/sort"),
        allowed = c("Integer", "Rational", "Real", "Probability", "Payoff",
                    "PayoffShare", "Player", "Type", "FiniteSet<Player>"),
        rule = "AST_SORT")
    add(c("K:symbol/name", "K:bound_symbol/name"), pattern = "^[A-Za-z][A-Za-z0-9_]*$",
        rule = "AST_SCOPED_NAME")
    add("K:set_symbol/sort", allowed = "Set<Player>", rule = "AST_SORT")
    add("K:set_symbol/name", allowed = "W", rule = "AST_SET_W")
    add(c("K:binary/sort", "K:unary/sort"),
        allowed = c("Integer", "Rational", "Real", "Probability", "Payoff",
                    "PayoffShare"), rule = "AST_RESULT_SORT")
    add("K:binary/operator", allowed = c("+", "-", "*", "/", "^"),
        rule = "AST_OPERATOR")
    add("K:unary/operator", allowed = c("+", "-"), rule = "AST_OPERATOR")
    add("K:compare/sort", allowed = "Proposition", rule = "AST_SORT")
    add("K:compare/operator", allowed = c("<", "<=", "=", ">=", ">", "!="),
        rule = "AST_OPERATOR")
    add("K:logical/sort", allowed = "Proposition", rule = "AST_SORT")
    add("K:logical/operator", allowed = c("not", "and", "or", "iff", "implies"),
        rule = "AST_OPERATOR")
    add("K:call/sort", allowed = c("Integer", "Probability"), rule = "AST_RESULT_SORT")
    add("K:call/name", allowed = c("floor", "Pr"), rule = "AST_CALL")
    add("K:indexed_symbol/sort", allowed = "Probability", rule = "INDEXED_SORT")
    add("K:indexed_symbol/family", allowed = c("omega", "e", "p"),
        rule = "INDEXED_FAMILY")
    add("K:indexed_sum/sort", allowed = "Real", rule = "INDEXED_SUM_SORT")
    add("K:quantifier/quantifier", allowed = "forall", rule = "QUANTIFIER")
    add("K:quantifier/sort", allowed = "Proposition", rule = "AST_SORT")
    add("K:binder/variable", pattern = "^b[1-9][0-9]*$", rule = "BINDER_VARIABLE")
    add("K:binder/variable_sort", allowed = c("Player", "FiniteSet<Player>"),
        rule = "BINDER_SOURCE_SORT")
    add("K:binder/source_variable", allowed = c("i", "K", "T"),
        rule = "BINDER_SOURCE_SORT")
    add(c("K:set_difference/sort", "K:singleton/sort"), allowed = "Set<Player>",
        rule = "AST_SORT")
    add(c("K:cardinality_constraint/sort", "K:membership_constraint/sort",
          "K:not_equal_constraint/sort"), allowed = "Proposition", rule = "AST_SORT")

    add("K:quota/q_rule", allowed = "floor(N/2)+1", rule = "QUOTA_RULE")
    add("K:weak_best_response/action", allowed = "yes iff x_j>=cutoff",
        rule = "WEAK_ACTION")
    add("K:weak_best_response/equality", allowed = "yes_by_T_Y", rule = "TIE_POLICY")
    add("K:budget_witness/outcome", allowed = c("exclude_H", "low_only", "pooling"),
        rule = "BUDGET_OUTCOME")
    add("K:strict_sign/relation", allowed = ">0", rule = "STRICT_RELATION")
    add("K:trusted_denominator_provenance/occurrence_count", "integer",
        allowed = 2L, rule = "DIVISOR_COUNT")
    add("K:linear_solution/variable", allowed = "nu", rule = "FRONTIER_VARIABLE")
    add("K:linear_solution/normal_form", pattern = "^.+$", rule = "FRONTIER_NF")
    add("K:linear_solution/orientation", allowed = "target_ge_zero_below_or_at_root",
        rule = "FRONTIER_ORIENTATION")
    add("K:frontier_certificate/domain", allowed = c("o_0<o_1<1/m", "o_0<1/m"),
        rule = "FRONTIER_DOMAIN")
    add(c("K:frontier_certificate/numerator", "K:frontier_certificate/denominator"),
        pattern = "^.+$", rule = "FRONTIER_POLYNOMIAL")
    add("K:frontier_certificate/denominator_sign", allowed = ">0",
        rule = "FRONTIER_SIGN")
    add("K:frontier_certificate/root_interval", allowed = "0<root<1",
        rule = "FRONTIER_INTERVAL")
    add("K:frontier_certificate/root_below_one_reason", pattern = "^.+$",
        rule = "FRONTIER_REASON")
    add(c("K:interval/lower_closed", "K:interval/upper_closed"), "logical",
        rule = "INTERVAL_ENDPOINT_OWNERSHIP")
    add("K:partition/region_count", "integer", allowed = 11L, rule = "EXACT_COUNT")
    add("K:partition/order_case_count", "integer", allowed = 5L, rule = "EXACT_COUNT")
    add("K:partition/prior_union", allowed = "[0,1]", rule = "PRIOR_UNION")
    add(c("K:partition/intersections_empty", "K:partition/union_exhaustive",
          "K:partition/tie_relation_partition"), "logical", allowed = TRUE,
        rule = "EXACT_TRUE")
    add("K:partition/endpoint_ownership", allowed = "lower_closed",
        rule = "ENDPOINT_POLICY")
    add("K:feasibility/witness_count", "integer", allowed = 11L, rule = "EXACT_COUNT")
    add("K:budget_certificate/outcome", allowed = c("exclude_H", "low_only", "pooling"),
        rule = "BUDGET_OUTCOME")
    add("K:budget_certificate/full_pie_reason", pattern = "^.+$", rule = "FULL_PIE_REASON")
    add(c("K:identity_simplexes/count", "K:PBE_witnesses/count"), "integer",
        allowed = 11L, rule = "EXACT_COUNT")
    add("K:identity_simplexes/recognition", allowed = "iid_uniform_1_over_m",
        rule = "RECOGNITION_RULE")
    add("K:identity_simplex/branch", allowed = c("E", "S", "P", "EP"),
        rule = "BRANCH")
    add("K:identity_simplex/normalization_nf", pattern = "^.+$",
        rule = "SIMPLEX_NORMALIZATION_NF")
    add("K:cartesian_identity_assignment/one_support_element_per_proposer",
        allowed = "independently chosen", rule = "IDENTITY_ASSIGNMENT_RULE")
    add("K:free_probability/name", allowed = c("kappa_i(s)", "eta_i(s,v)"),
        rule = "FREE_BELIEF_NAME")
    add("K:free_probability/activation", allowed = c(
      "individual proposal has zero strategy mass",
      "proposal-vote history has zero probability"), rule = "FREE_BELIEF_DOMAIN")
    add(c("K:closed_interval/lower", "K:closed_interval/upper"),
        allowed = c("0", "1"), rule = "CLOSED_INTERVAL_ENDPOINT")
    add(c("K:indexed_formula_plain/normal_form", "K:indexed_formula_domain/normal_form"),
        pattern = "^.+$", rule = "INDEXED_NF")
    add("K:indexed_formula_domain/domain", allowed = "o_1=1/m",
        rule = "INDEXED_DOMAIN")
    add("K:record_scoped_free_symbol_closure/record_count", "integer",
        allowed = 273L, rule = "EXACT_COUNT")

    add("O:parity_domain/N_sort", allowed = "Integer", rule = "PRIMITIVE_SORT")
    add(c("O:quota_bounds/q_lower", "O:quota_bounds/m_lower"), "integer",
        allowed = 2L, rule = "QUOTA_BOUND")
    add("O:H_case_ge/action", allowed = "no", rule = "H_ACTION")
    add("O:H_case_ge/sign_domain", allowed = "0<o_0<o_1", rule = "H_DOMAIN")
    add("O:H_case_eq/action", allowed = "yes iff y-continuation>=0", rule = "H_ACTION")
    add("O:H_case_eq/equality", allowed = "yes_by_T_Y", rule = "TIE_POLICY")
    add("O:H_case_le/action", allowed = "yes_by_T_Y", rule = "H_ACTION")
    add(c("O:theta_probabilities/theta_0", "O:theta_probabilities/theta_1"),
        "character", allowed = c("0", "1"), rule = "TYPE_PROBABILITY_ENDPOINT")
    add("O:proposer_case/domain", pattern = "^.+$", rule = "PROPOSER_CASE_DOMAIN")
    add("O:strict_sign_domain/beta", allowed = "0<beta<1", rule = "STRICT_DOMAIN")
    add("O:strict_sign_domain/quota", allowed = "2<=q<=m", rule = "STRICT_DOMAIN")
    add("O:strict_sign_domain/m", allowed = "m>=2", rule = "STRICT_DOMAIN")
    add("O:domain_fact/fact_id", allowed = c("D.m.positive", "D.lambda_s.positive",
      "D.nu.positive_failure_history", "D.one_minus_nu.positive_pass_history"),
      rule = "DOMAIN_FACT_ID")
    add("O:domain_fact/denominator_nf", pattern = "^.+$", rule = "DOMAIN_DENOMINATOR_NF")
    add("O:domain_fact/source_object_hash", pattern = "^[0-9a-f]{64}$", rule = "SHA256")
    add("O:exclusion_y_zero/strict_domain", allowed = "y>0", rule = "HEDGE_DOMAIN")
    add("O:exclusion_y_zero/quota_case", allowed = "k>=q-1", rule = "HEDGE_QUOTA_CASE")
    add("O:region/order_case", allowed = c("o_0<o_1<1/m", "o_0<o_1=1/m",
      "o_0<1/m<o_1", "o_0=1/m<o_1", "1/m<o_0<o_1"), rule = "ORDER_CASE")
    add("O:region/branch", allowed = c("E", "S", "P", "EP"), rule = "BRANCH")
    add(paste0("O:domain_witness/", c("N", "m", "q", "y_bar", "beta", "o_0",
                                                "o_1", "nu")),
        pattern = "^[0-9]+(?:/[1-9][0-9]*)?$", rule = "CANONICAL_RATIONAL_WITNESS")
    add("O:feasibility_record/witness_id", pattern = "^FEAS-(?:[1-9]|1[01])$",
        rule = "FEASIBILITY_ID")
    add("O:feasibility_record/region_hash", pattern = "^[0-9a-f]{64}$", rule = "SHA256")
    add("O:feasibility_record/branch", allowed = c("E", "S", "P", "EP"),
        rule = "BRANCH")
    add(c("O:expression_derivation/expression", "O:expression_derivation/derivation",
          "O:derivation_only/derivation"), pattern = "^.+$", rule = "DERIVATION_LITERAL")
    add("O:tie_frontier/frontier", pattern = "^.+$", rule = "FRONTIER_NF")
    add("O:tie_frontier/selected", allowed = "S", rule = "TIE_SELECTED")
    add("O:domain_sources/primitives", allowed = "0<beta and o_0<o_1",
        rule = "DOMAIN_PRIMITIVES")
    add("O:selected_by_relation/h_E<h_P", allowed = "E", rule = "TIE_SELECTION")
    add("O:selected_by_relation/h_P<h_E", allowed = "P", rule = "TIE_SELECTION")
    add("O:selected_by_relation/h_E=h_P", allowed = "all_E_P_mixtures",
        rule = "TIE_SELECTION")
    add("O:simplex_record/region_hash", pattern = "^[0-9a-f]{64}$", rule = "SHA256")
    add("O:simplex_record/branch", allowed = c("E", "S", "P", "EP"), rule = "BRANCH")
    add("O:support_family/family", allowed = c("omega", "e", "p"),
        rule = "INDEXED_FAMILY")
    add("O:support_family/offset", "integer", allowed = c(1L, 2L),
        rule = "COALITION_OFFSET")
    add("O:weak_type_independence/source", pattern = "^.+$", rule = "WEAK_TYPE_SOURCE")
    add(c("O:belief_record/region_hash", "O:belief_record/proposal_support_hash",
          "O:indexed_record/region_hash", "O:indexed_record/simplex_hash",
          "O:closure_record/ast_hash", "O:pbe_strategy/proposer_map_hash",
          "O:sequential_rationality/weak_response_hash",
          "O:sequential_rationality/H_response_hash",
          "O:proposer_deviations/source_region_hash",
          "O:comparison_derivation/region_hash", "O:pbe_coverage/partition_hash"),
        pattern = "^[0-9a-f]{64}$", rule = "SHA256")
    add(c("O:belief_record/branch", "O:indexed_record/branch"),
        allowed = c("E", "S", "P", "EP"), rule = "BRANCH")
    add("O:closure_record/source_step", allowed = c("S21", "S23", "S24", "S25",
                                                     "S26", "S27"),
        rule = "CLOSURE_SOURCE_STEP")
    add("O:closure_record/path", pattern = "^/S(?:21|23|24|25|26|27)/.+$",
        rule = "CLOSURE_PATH")
    add("O:closure_record/status", allowed = "FREE_SYMBOLS_CLOSED",
        rule = "CLOSURE_STATUS")
    add("O:local_W/W", allowed = c(
      "weak-player set local to the identity simplex",
      "weak-player set local to the labeled aggregation record"),
      rule = "LOCAL_DEFINITION")
    add("O:local_W_l_C/W", allowed = "weak-player set local to the identity record",
        rule = "LOCAL_DEFINITION")
    add("O:local_W_l_C/l", allowed = "weak payoff recipient fixed by this record",
        rule = "LOCAL_DEFINITION")
    add("O:local_W_l_C/C_l", allowed = "left-hand payoff defined by this identity record",
        rule = "LOCAL_DEFINITION")
    add("O:local_lambda/lambda_s",
        allowed = "positive-mass proposal likelihood local to this history",
        rule = "LOCAL_DEFINITION")
    add("O:pbe_witness/witness_id", pattern = "^PBE-W(?:0[1-9]|1[01])$",
        rule = "PBE_WITNESS_ID")
    add("O:deviation_comparison/alternative", allowed = c("E", "S", "P", "R"),
        rule = "DEVIATION_ALTERNATIVE")
    add("O:deviation_comparison/relation", allowed = c("=0", ">=0"),
        rule = "DEVIATION_RELATION")
    add("O:comparison_domain/order_case", allowed = c("o_0<o_1<1/m",
      "o_0<o_1=1/m", "o_0<1/m<o_1", "o_0=1/m<o_1", "1/m<o_0<o_1"),
      rule = "ORDER_CASE")
    add("O:comparison_derivation/rule", allowed = "ARGMAX_BY_CASES",
        rule = "DERIVATION_RULE")
    sc_assert(length(entries) == 201L, "FAIL_COVERAGE",
              paste("LEAF_CONTRACT expected 201 edges, got", length(entries)))
    edge_ids <- setNames(sprintf("L:context_%03d", seq_along(entries)), names(entries))
    leaves <- entries
    names(leaves) <- substring(unname(edge_ids), 3L)
    contract <<- list(edge_to_schema = edge_ids, leaves = leaves,
                     expected_edge_count = 201L)
    contract
  }
})

# Closed structural grammar for every replay value emitted by S01--S29.  This
# registry is deliberately declarative: no entry is learned from a clean
# replay, from a constructor, or from a serialized companion.  Mathematical
# validity is checked by the rule-specific replay above; this layer makes the
# representation fail closed (object/array, exact ordered keys, cardinality,
# and recursive child role) so an ignored extra field cannot hide beside a
# proved value.
pk_replay_shape_registry_v1 <- local({
  registry <- NULL
  function() {
    if (!is.null(registry)) return(registry)
    leaf_contract <- pk_replay_context_leaf_contract_v1()
    O <- function(keys, children, kind_value = NULL) {
      if (is.character(keys)) keys <- list(keys)
      sc_assert(length(keys) == 1L && length(unique(keys[[1L]])) == length(keys[[1L]]),
                "FAIL_COVERAGE", "SHAPE_REGISTRY object schema must have one exact key vector")
      sc_assert(is.list(children) && (length(children) == 0L ||
                  (!is.null(names(children)) && !anyNA(names(children)) &&
                   !anyDuplicated(names(children)) && all(names(children) %in% keys[[1L]]))),
                "FAIL_COVERAGE", "SHAPE_REGISTRY object children must be explicit")
      list(node_type = "object", key_variants = keys, children = children,
           kind_value = kind_value)
    }
    A <- function(lengths, element) {
      sc_assert(!is.null(element) || all(as.integer(lengths) == 0L),
                "FAIL_COVERAGE", "SHAPE_REGISTRY nonempty array needs an explicit element")
      list(node_type = "array", lengths = as.integer(lengths), element = element)
    }
    kinds <- list(
      formula = O(c("kind", "ast", "rational", "normal_form", "rule", "premises"),
                  list(ast = "AST", rational = "RAT", premises = "R:formula_premises")),
      number = O(c("kind", "sort", "value"), list()),
      symbol = O(c("kind", "sort", "name"), list()),
      bound_symbol = O(c("kind", "sort", "name"), list()),
      set_symbol = O(c("kind", "sort", "name"), list()),
      binary = O(c("kind", "sort", "operator", "left", "right"),
                 list(left = "AST", right = "AST")),
      unary = O(c("kind", "sort", "operator", "argument"),
                list(argument = "AST")),
      compare = O(c("kind", "sort", "operator", "left", "right"),
                  list(left = "AST", right = "AST")),
      logical = O(c("kind", "sort", "operator", "arguments"),
                  list(arguments = "A:ast_1_4")),
      call = O(c("kind", "sort", "name", "arguments"),
               list(arguments = "A:ast_0_4")),
      indexed_symbol = O(c("kind", "sort", "family", "indices"),
                         list(indices = "A:indexed_indices2")),
      indexed_sum = O(c("kind", "sort", "binder", "body"),
                      list(binder = "K:binder", body = "AST")),
      quantifier = O(c("kind", "quantifier", "sort", "binder", "body"),
                     list(binder = "K:binder", body = "AST")),
      binder = O(c("kind", "variable", "variable_sort", "source_variable",
                   "domain", "constraints"),
                 list(domain = "AST", constraints = "R:binder_constraints")),
      set_difference = O(c("kind", "sort", "left", "right"),
                         list(left = "AST", right = "AST")),
      singleton = O(c("kind", "sort", "element"), list(element = "AST")),
      cardinality_constraint = O(c("kind", "sort", "set", "equals"),
                                 list(set = "AST", equals = "AST")),
      membership_constraint = O(c("kind", "sort", "element", "container"),
                                list(element = "AST", container = "AST")),
      not_equal_constraint = O(c("kind", "sort", "left", "right"),
                               list(left = "AST", right = "AST")),
      domain_one = O(c("kind", "constraints"), list(constraints = "A:ast1"),
                     kind_value = "domain"),
      domain_two = O(c("kind", "constraints"), list(constraints = "A:ast2"),
                     kind_value = "domain"),
      quota = O(c("kind", "q_rule", "parity_certificate", "bounds",
                  "exclude_weak_votes", "include_weak_votes"),
                list(parity_certificate = "K:integer_parity_case_split",
                     bounds = "O:quota_bounds", exclude_weak_votes = "AST",
                     include_weak_votes = "AST")),
      integer_parity_case_split = O(c("kind", "primitive_domain", "cases",
                                       "conclusions"),
                                    list(primitive_domain = "O:parity_domain",
                                         cases = "O:parity_cases",
                                         conclusions = "O:quota_conclusions")),
      weak_best_response = O(c("kind", "cutoff", "action", "equality",
                               "payoff_table"),
                             list(cutoff = "K:formula",
                                  payoff_table = "O:weak_payoff_table")),
      H_best_response = O(c("kind", "cases"), list(cases = "O:H_cases")),
      proposer_map = O(c("kind", "cases", "case_partition", "cutoffs"),
                       list(cases = "O:proposer_cases",
                            case_partition = "O:proposer_partition",
                            cutoffs = "O:cutoffs")),
      budget_witness = O(c("kind", "outcome", "y", "weak_count", "weak_price",
                           "residual", "slack"),
                         list(y = "AST", weak_count = "AST",
                              weak_price = "K:formula", residual = "K:formula",
                              slack = "AST")),
      differences = O(c("kind", "E_minus_R", "P_minus_E", "S_minus_E",
                        "S_minus_P"),
                      list(E_minus_R = "K:formula", P_minus_E = "K:formula",
                           S_minus_E = "K:formula", S_minus_P = "K:formula")),
      strict_sign = O(c("kind", "formula", "relation", "domain",
                        "inequality_chain", "denominator"),
                      list(formula = "K:formula", domain = "O:strict_sign_domain",
                           inequality_chain = "A:inequality_chain5",
                           denominator = "K:trusted_denominator_provenance")),
      trusted_denominator_provenance = O(c("kind", "fact", "occurrence_count"),
                                         list(fact = "O:domain_fact")),
      linear_solution = O(c("kind", "variable", "rational", "normal_form", "slope",
                            "constant", "denominator_obligation", "sign_certificate",
                            "orientation"),
                          list(rational = "RAT", slope = "POLY", constant = "POLY",
                               denominator_obligation = "K:strict_nonzero",
                               sign_certificate = "K:frontier_certificate")),
      strict_nonzero = O(c("kind", "polynomial"), list(polynomial = "POLY")),
      frontier_certificate = O(c("kind", "pair", "domain", "numerator",
                                 "denominator", "denominator_sign", "root_interval",
                                 "root_below_one_reason"),
                               list(pair = "A:frontier_pair2")),
      hedge = O(c("kind", "slack_fill", "exclusion_y_zero"),
                list(slack_fill = "O:slack_fill",
                     exclusion_y_zero = "O:exclusion_y_zero")),
      argmax_correspondence = O(c("kind", "candidates", "frontier_SP",
                                  "frontier_SE", "regions"),
                                list(candidates = "O:candidates",
                                     frontier_SP = "K:linear_solution",
                                     frontier_SE = "K:linear_solution",
                                     regions = "A:regions11")),
      interval = O(c("kind", "lower", "upper", "lower_closed", "upper_closed",
                     "lower_rational", "upper_rational"),
                   list(lower = "L:interval_endpoint", upper = "L:interval_endpoint",
                        lower_rational = "R:interval_rational_cache",
                        upper_rational = "R:interval_rational_cache")),
      partition = O(c("kind", "region_count", "order_case_count", "prior_union",
                      "intersections_empty", "union_exhaustive", "endpoint_ownership",
                      "tie_relation_partition", "exact_nonvacuity_witnesses"),
                    list(exact_nonvacuity_witnesses = "A:domain_witnesses11")),
      feasibility = O(c("kind", "base_budgets", "witnesses", "witness_count"),
                      list(base_budgets = "O:base_budgets",
                           witnesses = "A:feasibility11")),
      budget_certificate = O(c("kind", "outcome", "total", "slack", "denominator",
                               "full_pie_reason"),
                             list(total = "K:formula", slack = "AST",
                                  denominator = "K:trusted_denominator_provenance")),
      tie_break = O(c("kind", "proposer_ties", "residual_tie_region_hashes"),
                    list(proposer_ties = "O:proposer_ties",
                         residual_tie_region_hashes = "A:sha256_3")),
      identity_simplexes = O(c("kind", "per_region", "count", "recognition",
                              "identity_symmetry_constraints"),
                            list(per_region = "A:simplex_records11",
                                 identity_symmetry_constraints = "A:empty")),
      identity_simplex = O(c("kind", "branch", "proposer_binder", "support_families",
                             "nonnegative", "normalization", "normalization_nf",
                             "pure_vertices", "mixture_space",
                             "support_nonempty_derivation"),
                           list(proposer_binder = "K:binder",
                                support_families = "R:support_families",
                                nonnegative = "R:simplex_nonnegative",
                                normalization = "K:quantifier",
                                pure_vertices = "K:cartesian_identity_assignment",
                                mixture_space = "K:full_labeled_simplex",
                                support_nonempty_derivation =
                                  "R:support_nonempty_derivation")),
      cartesian_identity_assignment = O(c("kind", "one_support_element_per_proposer"),
                                        list()),
      full_labeled_simplex = O(c("kind", "cross_identity_constraints"),
                               list(cross_identity_constraints = "A:empty")),
      bayes_fraction = O(c("kind", "numerator_one", "numerator_zero", "denominator",
                           "posterior", "denominator_certificate"),
                         list(numerator_one = "K:formula", numerator_zero = "K:formula",
                              denominator = "K:formula", posterior = "K:formula",
                              denominator_certificate = "O:domain_fact")),
      free_probability = O(c("kind", "name", "domain", "activation"),
                           list(domain = "K:closed_interval")),
      closed_interval = O(c("kind", "lower", "upper"), list()),
      separating_H_vote = O(c("kind", "weak_vote_likelihood_type_invariant",
                              "H_likelihoods", "positive_mass", "endpoint_zero_mass"),
                            list(weak_vote_likelihood_type_invariant = "K:formula",
                                 H_likelihoods = "O:H_likelihoods",
                                 positive_mass = "O:positive_mass",
                                 endpoint_zero_mass = "O:endpoint_zero_mass")),
      nonseparating_H_vote = O(c("kind", "weak_vote_likelihood_type_invariant",
                                 "posterior_on_positive_history", "zero_mass_history"),
                               list(weak_vote_likelihood_type_invariant = "K:formula",
                                    posterior_on_positive_history = "K:bayes_fraction",
                                    zero_mass_history = "K:free_probability")),
      belief_system = O(c("kind", "per_region", "weak_strategy_type_independence",
                          "endpoints", "imported_H_values"),
                        list(per_region = "A:belief_records11",
                             weak_strategy_type_independence = "O:weak_type_independence",
                             endpoints = "O:endpoints",
                             imported_H_values = "O:theta_formulas_regular")),
      indexed_formula_plain = O(c("kind", "ast", "normal_form"),
                                list(ast = "AST"), kind_value = "indexed_formula"),
      indexed_formula_domain = O(c("kind", "ast", "normal_form", "domain"),
                                 list(ast = "AST"), kind_value = "indexed_formula"),
      indexed_payoff_outcome_maps = O(c("kind", "per_region", "recognition",
                                        "weak_continuation"),
                                      list(per_region = "A:indexed_records11",
                                           recognition = "K:formula",
                                           weak_continuation = "K:formula")),
      record_scoped_free_symbol_closure = O(c("kind", "records", "record_count",
                                              "source_steps"),
                                            list(records = "A:closure_records273",
                                                 source_steps = "A:source_steps6")),
      PBE_witnesses = O(c("kind", "witnesses", "count", "coverage"),
                        list(witnesses = "A:pbe_witnesses11",
                             coverage = "O:pbe_coverage"))
    )

    objects <- list(
      parity_domain = O(c("N_sort", "lower"), list(lower = "AST")),
      parity_cases = O(c("even", "odd"),
                       list(even = "O:parity_case", odd = "O:parity_case")),
      parity_case = O(c("assumptions", "substitutions", "q_lower", "q_le_m_margin",
                        "q_le_m"),
                      list(assumptions = "A:ast2", substitutions = "A:ast2",
                           q_lower = "AST", q_le_m_margin = "K:formula",
                           q_le_m = "AST")),
      quota_conclusions = O(c("q_lower", "m_lower", "q_le_m", "exclusion_support",
                              "inclusion_support"),
                            list(q_lower = "AST", m_lower = "AST", q_le_m = "AST",
                                 exclusion_support = "A:ast2",
                                 inclusion_support = "A:ast2")),
      quota_bounds = O(c("q_lower", "m_lower", "q_le_m", "exclusion_support",
                         "inclusion_support"),
                       list(q_le_m = "AST", exclusion_support = "A:ast2",
                            inclusion_support = "A:ast2")),
      weak_payoff_table = O(c("pivotal", "pass_anyway", "fail_anyway"),
                            list(pivotal = "L:weak_payoff_pivotal",
                                 pass_anyway = "L:weak_payoff_pass_anyway",
                                 fail_anyway = "L:weak_payoff_fail_anyway")),
      H_cases = O(c("k_ge_q_minus_1", "k_eq_q_minus_2", "k_le_q_minus_3"),
                  list(k_ge_q_minus_1 = "O:H_case_ge",
                       k_eq_q_minus_2 = "O:H_case_eq",
                       k_le_q_minus_3 = "O:H_case_le")),
      H_case_ge = O(c("action", "strict_gain", "sign_domain"),
                    list(strict_gain = "O:theta_formulas_regular")),
      H_case_eq = O(c("action", "continuation", "yes_minus_no", "equality"),
                    list(continuation = "O:theta_formulas_regular",
                         yes_minus_no = "O:theta_formulas_regular")),
      H_case_le = O(c("action", "yes_payoff", "no_payoff"),
                    list(yes_payoff = "O:theta_formulas_regular",
                         no_payoff = "O:theta_formulas_regular")),
      theta_formulas_regular = O(c("theta_0", "theta_1"),
                                 list(theta_0 = "K:formula", theta_1 = "K:formula")),
      theta_indexed_EP = O(c("theta_0", "theta_1"),
                           list(theta_0 = "K:indexed_formula_plain",
                                theta_1 = "K:indexed_formula_domain")),
      theta_probabilities = O(c("theta_0", "theta_1"), list()),
      proposer_cases = O(c("k_ge_q_minus_1", "k_eq_q_minus_2_y_lt_a0",
                           "k_eq_q_minus_2_middle", "k_eq_q_minus_2_y_ge_a1",
                           "k_le_q_minus_3"),
                         list(k_ge_q_minus_1 = "O:proposer_case",
                              k_eq_q_minus_2_y_lt_a0 = "O:proposer_case",
                              k_eq_q_minus_2_middle = "O:proposer_case",
                              k_eq_q_minus_2_y_ge_a1 = "O:proposer_case",
                              k_le_q_minus_3 = "O:proposer_case")),
      proposer_case = O(c("domain", "theta_payoffs", "expected"),
                        list(theta_payoffs = "A:payoff_pair",
                             expected = "K:formula")),
      proposer_partition = O(c("k", "y_when_pivotal"),
                             list(k = "A:proposer_k_partition3",
                                  y_when_pivotal = "A:proposer_y_partition3")),
      cutoffs = O(c("a0", "a1"), list(a0 = "K:formula", a1 = "K:formula")),
      strict_sign_domain = O(c("beta", "quota", "m"), list()),
      domain_fact = O(c("fact_id", "denominator_nf", "proposition_ast", "domain_ast",
                        "source_step_ids", "source_object_hash"),
                      list(proposition_ast = "AST", domain_ast = "R:fact_domain",
                           source_step_ids = "L:source_steps")),
      slack_fill = O(c("delta", "residual_after", "expected_gain", "strict_domain",
                       "ballot_coordinates_held_fixed"),
                     list(delta = "K:formula", residual_after = "K:formula",
                          expected_gain = "K:formula",
                          strict_domain = "A:slack_strict_domain2",
                          ballot_coordinates_held_fixed = "A:ballot_coords2")),
      exclusion_y_zero = O(c("original_budget", "transformed_budget", "transformed_y",
                             "transformed_residual", "gain", "strict_domain",
                             "quota_case", "ballot_coordinates_held_fixed"),
                           list(original_budget = "K:formula",
                                transformed_budget = "K:formula",
                                transformed_y = "AST", transformed_residual = "AST",
                                gain = "K:formula",
                                ballot_coordinates_held_fixed = "A:ballot_coords2")),
      candidates = O(c("E", "P", "S", "R"),
                     list(E = "K:formula", P = "K:formula", S = "K:formula",
                          R = "K:formula")),
      region = O(c("order_case", "prior", "tie", "branch", "dominance"),
                 list(prior = "K:interval", tie = "R:region_tie",
                      dominance = "A:dominance_2_4")),
      domain_witness = O(c("N", "m", "q", "y_bar", "beta", "o_0", "o_1", "nu"),
                         list()),
      base_budgets = O(c("E", "S", "P"),
                       list(E = "K:budget_certificate", S = "K:budget_certificate",
                            P = "K:budget_certificate")),
      feasibility_record = O(c("witness_id", "region_hash", "branch", "budgets",
                                "nonnegativity"),
                              list(budgets = "R:branch_budgets",
                                   nonnegativity = "O:nonnegativity")),
      budgets_E = O(c("E"), list(E = "K:budget_certificate")),
      budgets_S = O(c("S"), list(S = "K:budget_certificate")),
      budgets_P = O(c("P"), list(P = "K:budget_certificate")),
      budgets_EP = O(c("E", "P"),
                     list(E = "K:budget_certificate", P = "K:budget_certificate")),
      nonnegativity = O(c("weak_price", "weak_count", "residual", "concession"),
                        list(weak_price = "O:expression_derivation",
                             weak_count = "O:expression_derivation",
                             residual = "O:derivation_only",
                             concession = "O:derivation_only")),
      expression_derivation = O(c("expression", "derivation"), list()),
      derivation_only = O(c("derivation"), list()),
      proposer_ties = O(c("S_equals_P", "S_equals_E", "E_equals_P"),
                        list(S_equals_P = "O:tie_frontier",
                             S_equals_E = "O:tie_frontier",
                             E_equals_P = "O:tie_EP")),
      tie_frontier = O(c("difference", "frontier", "selected", "H_margin",
                         "sign_certificate"),
                       list(difference = "K:formula", H_margin = "K:formula",
                            sign_certificate = "R:sign_certificate_variant")),
      sign_certificate_SP = O(c("factors", "domain_sources"),
                              list(factors = "A:factors_2_3",
                                   domain_sources = "O:domain_sources")),
      sign_certificate_SE = O(c("factors", "domain_sources"),
                              list(factors = "A:factors_2_3",
                                   domain_sources = "L:domain_sources_SE")),
      domain_sources = O(c("root", "primitives"),
                         list(root = "K:frontier_certificate")),
      tie_EP = O(c("difference", "exact_zero_under_domain", "H_E", "H_P",
                   "H_difference", "H_trichotomy", "selected_by_relation"),
                 list(difference = "K:formula", exact_zero_under_domain = "K:formula",
                      H_E = "K:formula", H_P = "K:formula",
                      H_difference = "K:formula", H_trichotomy = "A:H_trichotomy3",
                      selected_by_relation = "O:selected_by_relation")),
      selected_by_relation = O(c("h_E<h_P", "h_P<h_E", "h_E=h_P"), list()),
      simplex_record = O(c("region_hash", "branch", "simplex"),
                         list(simplex = "K:identity_simplex")),
      support_family = O(c("binder", "weight", "sum", "family", "offset"),
                         list(binder = "K:binder", weight = "K:indexed_symbol",
                              sum = "K:indexed_sum")),
      weak_type_independence = O(c("source", "cutoff"),
                                 list(cutoff = "K:formula")),
      endpoints = O(c("nu_0", "nu_1"),
                    list(nu_0 = "O:endpoint_nu0", nu_1 = "O:endpoint_nu1")),
      endpoint_nu0 = O(c("type_probabilities", "zero_mass_type_1_histories"),
                       list(type_probabilities = "O:theta_probabilities",
                            zero_mass_type_1_histories = "K:free_probability")),
      endpoint_nu1 = O(c("type_probabilities", "zero_mass_type_0_histories"),
                       list(type_probabilities = "O:theta_probabilities",
                            zero_mass_type_0_histories = "K:free_probability")),
      belief_record = O(c("region_hash", "branch", "proposal_support_hash",
                          "after_positive_mass_proposal", "after_public_vote_vector",
                          "zero_mass_proposal", "deviating_proposer_prior"),
                        list(after_positive_mass_proposal = "K:bayes_fraction",
                             after_public_vote_vector = "R:public_vote_belief",
                             zero_mass_proposal = "K:free_probability",
                             deviating_proposer_prior = "AST")),
      H_likelihoods = O(c("pass", "failure"),
                        list(pass = "O:theta_probabilities",
                             failure = "O:theta_probabilities")),
      positive_mass = O(c("pass", "failure"),
                        list(pass = "K:bayes_fraction", failure = "K:bayes_fraction")),
      endpoint_zero_mass = O(c("nu_0_failure", "nu_1_pass"),
                             list(nu_0_failure = "K:free_probability",
                                  nu_1_pass = "K:free_probability")),
      indexed_record = O(c("region_hash", "branch", "recognized_proposer",
                           "weak_identity_map", "H_by_type", "outcomes", "simplex_hash"),
                         list(recognized_proposer = "K:formula",
                              weak_identity_map = "K:indexed_formula_plain",
                              H_by_type = "R:indexed_H_by_type",
                              outcomes = "R:indexed_outcomes")),
      outcomes_regular = O(c("pass_with_hegemon", "pass_without_hegemon", "failure",
                             "delay"),
                           list(pass_with_hegemon = "K:formula",
                                pass_without_hegemon = "K:formula",
                                failure = "K:formula", delay = "K:formula")),
      outcomes_EP = O(c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay"),
                      list(pass_with_hegemon = "K:indexed_formula_plain",
                           pass_without_hegemon = "K:indexed_formula_plain",
                           failure = "K:formula", delay = "K:formula")),
      closure_record = O(c("source_step", "path", "ast_hash", "free_symbols",
                           "primitive_symbols", "local_definitions", "status"),
                         list(free_symbols = "A:free_symbols_0_8",
                              primitive_symbols = "A:primitive_symbols_0_6",
                              local_definitions = "R:local_definitions")),
      local_W = O(c("W"), list()),
      local_W_l_C = O(c("W", "l", "C_l"), list()),
      local_lambda = O(c("lambda_s"), list()),
      pbe_witness = O(c("witness_id", "region", "domain_witness", "strategy", "beliefs",
                        "sequential_rationality", "payoff_outcome_map",
                        "closure_records"),
                      list(region = "O:region", domain_witness = "O:domain_witness",
                           strategy = "O:pbe_strategy",
                           beliefs = "O:belief_record",
                           sequential_rationality = "O:sequential_rationality",
                           payoff_outcome_map = "O:indexed_record",
                           closure_records = "A:closure_hashes")),
      pbe_strategy = O(c("feasibility", "simplex", "proposer_map_hash"),
                       list(feasibility = "O:feasibility_record",
                            simplex = "O:simplex_record")),
      sequential_rationality = O(c("weak_response_hash", "H_response_hash",
                                   "proposer_deviations"),
                                 list(proposer_deviations = "O:proposer_deviations")),
      proposer_deviations = O(c("selected_set", "comparisons", "mixture_indifference",
                                "source_region_hash"),
                              list(selected_set = "A:selected_1_2",
                                   comparisons = "A:comparisons4",
                                   mixture_indifference = "R:mixture_indifference")),
      deviation_comparison = O(c("alternative", "difference", "relation", "domain",
                                 "sign_atoms", "derivation"),
                               list(difference = "K:formula", domain = "O:comparison_domain",
                                    sign_atoms = "A:sign_atoms_2_4",
                                    derivation = "O:comparison_derivation")),
      comparison_domain = O(c("order_case", "prior", "tie"),
                            list(prior = "K:interval", tie = "R:comparison_tie")),
      comparison_derivation = O(c("rule", "region_hash"), list()),
      pbe_coverage = O(c("partition_hash", "region_hashes", "witness_region_hashes",
                         "partition_domain_witness_hashes",
                         "witness_domain_witness_hashes"),
                       list(region_hashes = "A:sha256_11",
                            witness_region_hashes = "A:sha256_11",
                            partition_domain_witness_hashes = "A:sha256_11",
                            witness_domain_witness_hashes = "A:sha256_11"))
    )

    bind_context_leaves <- function(entries, prefix) {
      for (schema_name in names(entries)) {
        children <- entries[[schema_name]]$children
        missing_fields <- setdiff(entries[[schema_name]]$key_variants[[1L]],
                                  names(children))
        for (field in missing_fields) {
          edge <- paste0(prefix, ":", schema_name, "/", field)
          sc_assert(edge %in% names(leaf_contract$edge_to_schema),
                    "FAIL_COVERAGE", paste("SHAPE_REGISTRY unregistered leaf edge", edge))
          children[[field]] <- leaf_contract$edge_to_schema[[edge]]
        }
        entries[[schema_name]]$children <- children
      }
      entries
    }
    kinds <- bind_context_leaves(kinds, "K")
    objects <- bind_context_leaves(objects, "O")
    bound_edges <- c(unlist(lapply(names(kinds), function(name) {
      fields <- names(kinds[[name]]$children)[vapply(kinds[[name]]$children,
        function(ref) is.character(ref) && length(ref) == 1L && startsWith(ref, "L:context_"),
        logical(1))]
      if (length(fields)) paste0("K:", name, "/", fields) else character(0)
    }), use.names = FALSE), unlist(lapply(names(objects), function(name) {
      fields <- names(objects[[name]]$children)[vapply(objects[[name]]$children,
        function(ref) is.character(ref) && length(ref) == 1L && startsWith(ref, "L:context_"),
        logical(1))]
      if (length(fields)) paste0("O:", name, "/", fields) else character(0)
    }), use.names = FALSE))
    sc_assert(length(bound_edges) == 201L &&
                setequal(bound_edges, names(leaf_contract$edge_to_schema)),
              "FAIL_COVERAGE", paste0(
                "SHAPE_REGISTRY context-leaf ownership is not 201/201: bound=",
                length(bound_edges), "; missing=",
                paste(setdiff(names(leaf_contract$edge_to_schema), bound_edges), collapse = ","),
                "; extra=", paste(setdiff(bound_edges,
                                           names(leaf_contract$edge_to_schema)),
                                    collapse = ",")))

    arrays <- list(
      empty = A(0, NULL),
      premises0 = A(0, NULL), premises1 = A(1, "L:step_id"),
      premises4 = A(4, "L:step_id"),
      premises_payoff = A(c(0, 2, 6), "L:step_id"),
      premises_budget = A(c(2, 3), "L:step_id"),
      indexed_indices2 = A(2, "L:indexed_index"),
      inequality_chain5 = A(5, "L:inequality_chain_atom"),
      frontier_pair2 = A(2, "L:frontier_pair_atom"),
      proposer_k_partition3 = A(3, "L:proposer_k_partition_atom"),
      proposer_y_partition3 = A(3, "L:proposer_y_partition_atom"),
      slack_strict_domain2 = A(2, "L:slack_domain_atom"),
      ballot_coords2 = A(2, "L:ballot_coordinate_atom"),
      H_trichotomy3 = A(3, "L:H_trichotomy_atom"),
      source_steps6 = A(6, "L:closure_source_step"),
      free_symbols_0_8 = A(0:8, "L:free_symbol_identifier"),
      primitive_symbols_0_6 = A(0:6, "L:primitive_symbol_identifier"),
      sha256_3 = A(3, "L:sha256_atom"),
      sha256_11 = A(11, "L:sha256_atom"),
      ast0 = A(0, "AST"), ast1 = A(1, "AST"), ast2 = A(2, "AST"),
      ast_0_4 = A(0:4, "AST"), ast_1_4 = A(1:4, "AST"),
      payoff_pair = A(2, c("K:formula", "K:symbol")),
      dominance_2_4 = A(2:4, "L:dominance_atom"),
      factors_2_3 = A(2:3, "L:factor_atom"),
      regions11 = A(11, "O:region"),
      domain_witnesses11 = A(11, "O:domain_witness"),
      feasibility11 = A(11, "O:feasibility_record"),
      simplex_records11 = A(11, "O:simplex_record"),
      support_families1 = A(1, "O:support_family"),
      support_families2 = A(2, "O:support_family"),
      quantifiers1 = A(1, "K:quantifier"), quantifiers2 = A(2, "K:quantifier"),
      support_derivations1_short = A(1, "A:support_derivation2"),
      support_derivations1_long = A(1, "A:support_derivation3"),
      support_derivations2 = list(node_type = "positional_array", lengths = 2L,
                                  elements = c("A:support_derivation2",
                                               "A:support_derivation3")),
      support_derivation2 = A(2, "L:support_derivation_atom"),
      support_derivation3 = A(3, "L:support_derivation_atom"),
      belief_records11 = A(11, "O:belief_record"),
      indexed_records11 = A(11, "O:indexed_record"),
      closure_records273 = A(273, "O:closure_record"),
      pbe_witnesses11 = A(11, "O:pbe_witness"),
      closure_hashes = A(c(21, 23, 25), "L:sha256_atom"),
      selected_1_2 = A(1:2, "L:selected_branch_atom"),
      comparisons4 = A(4, "O:deviation_comparison"),
      sign_atoms_2_4 = A(2:4, "L:sign_atom")
    )

    leaves <- c(leaf_contract$leaves, list(
      interval_endpoint = list(node_type = "leaf", atomic_type = "interval_endpoint"),
      weak_payoff_pivotal = list(node_type = "leaf", atomic_type = "weak_payoff_pivotal"),
      weak_payoff_pass_anyway = list(node_type = "leaf",
                                     atomic_type = "weak_payoff_pass_anyway"),
      weak_payoff_fail_anyway = list(node_type = "leaf",
                                     atomic_type = "weak_payoff_fail_anyway"),
      source_steps = list(node_type = "leaf", atomic_type = "source_steps")
      ,step_id = list(node_type = "leaf", atomic_type = "step_id")
      ,indexed_index = list(node_type = "leaf", atomic_type = "indexed_index")
      ,inequality_chain_atom = list(node_type = "leaf",
                                    atomic_type = "inequality_chain_atom")
      ,frontier_pair_atom = list(node_type = "leaf", atomic_type = "frontier_pair_atom")
      ,proposer_k_partition_atom = list(node_type = "leaf",
                                        atomic_type = "proposer_k_partition_atom")
      ,proposer_y_partition_atom = list(node_type = "leaf",
                                        atomic_type = "proposer_y_partition_atom")
      ,slack_domain_atom = list(node_type = "leaf", atomic_type = "slack_domain_atom")
      ,ballot_coordinate_atom = list(node_type = "leaf",
                                     atomic_type = "ballot_coordinate_atom")
      ,H_trichotomy_atom = list(node_type = "leaf", atomic_type = "H_trichotomy_atom")
      ,closure_source_step = list(node_type = "leaf", atomic_type = "closure_source_step")
      ,free_symbol_identifier = list(node_type = "leaf",
                                     atomic_type = "free_symbol_identifier")
      ,primitive_symbol_identifier = list(node_type = "leaf",
                                          atomic_type = "primitive_symbol_identifier")
      ,dominance_atom = list(node_type = "leaf", atomic_type = "dominance_atom")
      ,factor_atom = list(node_type = "leaf", atomic_type = "factor_atom")
      ,support_derivation_atom = list(node_type = "leaf",
                                      atomic_type = "support_derivation_atom")
      ,sha256_atom = list(node_type = "leaf", atomic_type = "sha256_atom")
      ,selected_branch_atom = list(node_type = "leaf",
                                   atomic_type = "selected_branch_atom")
      ,sign_atom = list(node_type = "leaf", atomic_type = "sign_atom")
      ,region_tie_relation = list(node_type = "leaf",
                                  atomic_type = "region_tie_relation")
      ,domain_sources_SE = list(node_type = "leaf",
                                atomic_type = "domain_sources_SE")))

    step_schemas <- c(
      S01 = "K:formula", S02 = "K:formula", S03 = "K:formula",
      S04 = "K:formula", S05 = "K:formula", S06 = "K:formula",
      S07 = "K:quota", S08 = "K:weak_best_response",
      S09 = "K:H_best_response", S10 = "K:proposer_map",
      S11 = "K:budget_witness", S12 = "K:budget_witness",
      S13 = "K:budget_witness", S14 = "K:formula", S15 = "K:formula",
      S16 = "K:differences", S17 = "K:strict_sign",
      S18 = "K:linear_solution", S19 = "K:linear_solution", S20 = "K:hedge",
      S21 = "K:argmax_correspondence", S22 = "K:partition",
      S23 = "K:feasibility", S24 = "K:tie_break",
      S26 = "K:identity_simplexes", S25 = "K:belief_system",
      S27 = "K:indexed_payoff_outcome_maps",
      S28 = "K:record_scoped_free_symbol_closure", S29 = "K:PBE_witnesses")
    ast_kinds <- c("number", "symbol", "bound_symbol", "set_symbol", "binary",
                   "unary", "compare", "logical", "call", "indexed_symbol",
                   "indexed_sum", "quantifier", "binder", "set_difference",
                   "singleton", "cardinality_constraint", "membership_constraint",
                   "not_equal_constraint")
    observed_kinds <- setdiff(names(kinds), c("unary", "logical", "call", "domain"))
    expected_per_step <- list(
      S01 = c(all = 8L, rat = 1L, poly = 2L, generic = 5L),
      S02 = c(all = 6L, rat = 1L, poly = 2L, generic = 3L),
      S03 = c(all = 6L, rat = 1L, poly = 2L, generic = 3L),
      S04 = c(all = 10L, rat = 1L, poly = 2L, generic = 7L),
      S05 = c(all = 8L, rat = 1L, poly = 2L, generic = 5L),
      S06 = c(all = 8L, rat = 1L, poly = 2L, generic = 5L),
      S07 = c(all = 181L, rat = 2L, poly = 4L, generic = 175L),
      S08 = c(all = 12L, rat = 1L, poly = 2L, generic = 9L),
      S09 = c(all = 98L, rat = 10L, poly = 20L, generic = 68L),
      S10 = c(all = 152L, rat = 15L, poly = 30L, generic = 107L),
      S11 = c(all = 34L, rat = 2L, poly = 4L, generic = 28L),
      S12 = c(all = 38L, rat = 2L, poly = 4L, generic = 32L),
      S13 = c(all = 38L, rat = 2L, poly = 4L, generic = 32L),
      S14 = c(all = 32L, rat = 1L, poly = 2L, generic = 29L),
      S15 = c(all = 10L, rat = 1L, poly = 2L, generic = 7L),
      S16 = c(all = 153L, rat = 4L, poly = 8L, generic = 141L),
      S17 = c(all = 37L, rat = 1L, poly = 2L, generic = 34L),
      S18 = c(all = 10L, rat = 1L, poly = 5L, generic = 4L),
      S19 = c(all = 10L, rat = 1L, poly = 5L, generic = 4L),
      S20 = c(all = 82L, rat = 6L, poly = 12L, generic = 64L),
      S21 = c(all = 160L, rat = 14L, poly = 34L, generic = 112L),
      S22 = c(all = 13L, rat = 0L, poly = 0L, generic = 13L),
      S23 = c(all = 746L, rat = 15L, poly = 30L, generic = 701L),
      S24 = c(all = 273L, rat = 9L, poly = 18L, generic = 246L),
      S26 = c(all = 947L, rat = 0L, poly = 0L, generic = 947L),
      S25 = c(all = 2042L, rat = 118L, poly = 236L, generic = 1688L),
      S27 = c(all = 1586L, rat = 75L, poly = 150L, generic = 1361L),
      S28 = c(all = 1095L, rat = 0L, poly = 0L, generic = 1095L),
      S29 = c(all = 7366L, rat = 285L, poly = 570L, generic = 6511L)
    )
    registry <<- list(kinds = kinds, objects = objects, arrays = arrays,
                      leaves = leaves,
                      context_leaf_edges = leaf_contract$edge_to_schema,
                      step_schemas = step_schemas, ast_kinds = ast_kinds,
                      required_kind_schemas = paste0("K:", observed_kinds),
                      expected_node_count = 15161L,
                      expected_class_counts = c(generic = 13436L, rat = 571L,
                                                poly = 1154L),
                      expected_generic_counts = c(object = 11563L, array = 1873L),
                      expected_null_count = 142L,
                      expected_atomic_vector_count = 55L,
                      expected_atomic_leaf_count = 35273L,
                      expected_empty_array_count = 745L,
                      expected_per_step = expected_per_step)
    registry
  }
})

pk_replay_shape_registry_sha256_v1 <- function() {
  "532e0aa93c7bd91a76e551d53b83e992412a9d54df9946b72af8ec66de1eb8be"
}

pk_shape_schema_spec <- function(schema_id, registry = pk_replay_shape_registry_v1()) {
  if (startsWith(schema_id, "K:")) {
    key <- substring(schema_id, 3L)
    sc_assert(key %in% names(registry$kinds), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY unknown kind schema", key))
    return(registry$kinds[[key]])
  }
  if (startsWith(schema_id, "O:")) {
    key <- substring(schema_id, 3L)
    sc_assert(key %in% names(registry$objects), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY unknown object schema", key))
    return(registry$objects[[key]])
  }
  if (startsWith(schema_id, "A:")) {
    key <- substring(schema_id, 3L)
    sc_assert(key %in% names(registry$arrays), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY unknown array schema", key))
    return(registry$arrays[[key]])
  }
  if (startsWith(schema_id, "L:")) {
    key <- substring(schema_id, 3L)
    sc_assert(key %in% names(registry$leaves), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY unknown leaf schema", key))
    return(registry$leaves[[key]])
  }
  sc_abort("FAIL_COVERAGE", paste("SHAPE_REGISTRY unknown schema reference", schema_id))
}

pk_shape_resolve_route <- function(route, parent_schema, parent_value, field, path) {
  exact <- function(name) parent_value[[name, exact = TRUE]]
  if (identical(route, "R:interval_rational_cache")) {
    endpoint_field <- switch(field, lower_rational = "lower", upper_rational = "upper",
                             sc_abort("FAIL_COVERAGE",
                               paste("SHAPE_REGISTRY interval cache field changed at", path)))
    endpoint <- exact(endpoint_field)
    sc_assert(is.character(endpoint) && length(endpoint) == 1L && !is.na(endpoint),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY interval endpoint unavailable at", path))
    return(if (endpoint %in% c("0", "1")) "NULL" else "RAT")
  }
  if (identical(route, "R:region_tie")) {
    order_case <- exact("order_case"); branch <- exact("branch")
    sc_assert(order_case %in% c("o_0<o_1<1/m", "o_0<o_1=1/m", "o_0<1/m<o_1",
                                "o_0=1/m<o_1", "1/m<o_0<o_1") &&
                branch %in% c("E", "S", "P", "EP"),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY region discriminator changed at", path))
    return(if (identical(order_case, "o_0<o_1=1/m") && branch %in% c("E", "P", "EP"))
      "L:region_tie_relation" else "NULL")
  }
  if (identical(route, "R:comparison_tie")) {
    witness_match <- regexec("^/S29/witnesses/([1-9]|1[01])/", path)
    capture <- regmatches(path, witness_match)[[1L]]
    sc_assert(length(capture) == 2L, "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY comparison tie lacks witness ordinal at", path))
    witness_ordinal <- as.integer(capture[[2L]])
    expected_order <- c("o_0<o_1<1/m", "o_0<o_1<1/m", "o_0<o_1=1/m",
      "o_0<o_1=1/m", "o_0<o_1=1/m", "o_0<o_1=1/m", "o_0<1/m<o_1",
      "o_0<1/m<o_1", "o_0=1/m<o_1", "o_0=1/m<o_1", "1/m<o_0<o_1")
    sc_assert(identical(exact("order_case"), expected_order[[witness_ordinal]]),
              "FAIL_BINDING", paste("SHAPE_REGISTRY comparison order/witness mismatch at", path))
    return(if (witness_ordinal %in% 4:6) "L:region_tie_relation" else "NULL")
  }
  if (identical(route, "R:mixture_indifference")) {
    selected_raw <- exact("selected_set")
    selected <- unlist(selected_raw, use.names = FALSE)
    sc_assert(is.list(selected_raw) && is.null(names(selected_raw)) &&
                is.character(selected) && length(selected) %in% 1:2 &&
                (length(selected) == 1L || identical(selected, c("E", "P"))),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY selected-set discriminator changed at", path))
    return(if (identical(selected, c("E", "P"))) "K:formula" else "NULL")
  }
  if (identical(route, "R:formula_premises")) {
    rule <- exact("rule")
    return(switch(rule,
      IMPORT_EXACT = "A:premises0", DISCOUNT_ONCE = "A:premises1",
      QUOTA_EVAL = "A:premises0", BEST_RESPONSE = "A:premises0",
      PAYOFF_EVAL = "A:premises_payoff", BUDGET_SATURATION = "A:premises_budget",
      ALGEBRA_EQ = "A:premises4", HEDGE_TRANSFORM = "A:premises0",
      FEASIBILITY = "A:premises0", TIE_BREAK = "A:premises0",
      BAYES = "A:premises0", INDEXED_SUM = "A:premises0",
      PBE_WITNESS = "A:premises0",
      sc_abort("FAIL_COVERAGE", paste("SHAPE_REGISTRY unknown formula rule at", path,
                                      as.character(rule)))))
  }
  if (identical(route, "R:binder_constraints")) {
    source <- exact("source_variable")
    if (identical(source, "i")) {
      return(if (grepl("/weak_identity_map/", path, fixed = TRUE)) "A:ast1" else "A:ast0")
    }
    sc_assert(source %in% c("K", "T"), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY unknown binder source at", path))
    return(if (grepl("/weak_identity_map/", path, fixed = TRUE)) "A:ast2" else "A:ast1")
  }
  if (identical(route, "R:fact_domain")) {
    fact_id <- exact("fact_id")
    if (fact_id %in% c("D.m.positive", "D.lambda_s.positive")) return("K:domain_one")
    if (fact_id %in% c("D.nu.positive_failure_history",
                       "D.one_minus_nu.positive_pass_history")) return("K:domain_two")
    sc_abort("FAIL_COVERAGE", paste("SHAPE_REGISTRY unknown domain fact at", path, fact_id))
  }
  if (identical(route, "R:branch_budgets")) {
    return(switch(exact("branch"), E = "O:budgets_E", S = "O:budgets_S",
                  P = "O:budgets_P", EP = "O:budgets_EP",
                  sc_abort("FAIL_COVERAGE", paste("SHAPE_REGISTRY unknown budget branch at",
                                                  path))))
  }
  if (identical(route, "R:public_vote_belief")) {
    branch <- exact("branch")
    sc_assert(branch %in% c("E", "S", "P", "EP"), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY unknown belief branch at", path))
    return(if (identical(branch, "S")) "K:separating_H_vote" else
      "K:nonseparating_H_vote")
  }
  if (identical(route, "R:indexed_H_by_type")) {
    branch <- exact("branch")
    sc_assert(branch %in% c("E", "S", "P", "EP"), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY unknown indexed-H branch at", path))
    return(if (identical(branch, "EP")) "O:theta_indexed_EP" else
      "O:theta_formulas_regular")
  }
  if (identical(route, "R:indexed_outcomes")) {
    branch <- exact("branch")
    sc_assert(branch %in% c("E", "S", "P", "EP"), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY unknown indexed-outcome branch at", path))
    return(if (identical(branch, "EP")) "O:outcomes_EP" else
      "O:outcomes_regular")
  }
  if (route %in% c("R:support_families", "R:simplex_nonnegative",
                   "R:support_nonempty_derivation")) {
    branch <- exact("branch")
    sc_assert(branch %in% c("E", "S", "P", "EP"), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY unknown simplex branch at", path))
    ep <- identical(branch, "EP")
    if (identical(route, "R:support_families")) {
      return(if (ep) "A:support_families2" else "A:support_families1")
    }
    if (identical(route, "R:simplex_nonnegative")) {
      return(if (ep) "A:quantifiers2" else "A:quantifiers1")
    }
    if (ep) return("A:support_derivations2")
    return(if (identical(branch, "E")) "A:support_derivations1_short" else
      "A:support_derivations1_long")
  }
  if (identical(route, "R:sign_certificate_variant")) {
    if (grepl("/S_equals_P/sign_certificate$", path)) return("O:sign_certificate_SP")
    if (grepl("/S_equals_E/sign_certificate$", path)) return("O:sign_certificate_SE")
    sc_abort("FAIL_COVERAGE", paste("SHAPE_REGISTRY unknown sign-certificate context at", path))
  }
  if (identical(route, "R:local_definitions")) {
    record_path <- exact("path")
    source_step <- exact("source_step")
    sc_assert(is.character(record_path) && length(record_path) == 1L &&
                is.character(source_step) && length(source_step) == 1L &&
                source_step %in% sprintf("S%02d", 1:29) &&
                startsWith(record_path, paste0("/", source_step, "/")),
              "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY closure path/source mismatch at", path))
    if (grepl("^/S25/", record_path) &&
        grepl("after_positive_mass_proposal|posterior_on_positive_history", record_path)) {
      return("O:local_lambda")
    }
    if (grepl("^/S26/", record_path)) return("O:local_W")
    if (grepl("^/S27/.*/weak_identity_map/", record_path)) return("O:local_W_l_C")
    if (grepl("^/S27/.*/(H_by_type|outcomes)/", record_path)) return("O:local_W")
    return("A:empty")
  }
  sc_abort("FAIL_COVERAGE", paste("SHAPE_REGISTRY unresolved route", route,
                                  "from", parent_schema, "at", path))
}

pk_shape_select_schema <- function(value, expected,
                                   registry = pk_replay_shape_registry_v1(), path = "") {
  sc_assert(length(expected) >= 1L, "FAIL_COVERAGE",
            paste("SHAPE_REGISTRY empty expected schema at", path))
  if (length(expected) > 1L) {
    # Only intrinsically tagged/disjoint unions are permitted here.  Object
    # keys or array length are never consulted to select the alternative.
    if (setequal(expected, c("RAT", "NULL"))) {
      return(if (is.null(value)) "NULL" else "RAT")
    }
    if (setequal(expected, c("K:formula", "K:symbol"))) {
      sc_assert(is.list(value) && "kind" %in% names(value), "FAIL_COVERAGE",
                paste("SHAPE_REGISTRY missing tagged union kind at", path))
      kind <- value[["kind", exact = TRUE]]
      sc_assert(kind %in% c("formula", "symbol"), "FAIL_COVERAGE",
                paste("SHAPE_REGISTRY wrong tagged union kind at", path))
      return(paste0("K:", kind))
    }
    sc_abort("FAIL_COVERAGE", paste("SHAPE_REGISTRY forbidden observed-value union at", path,
                                    paste(expected, collapse = "|")))
  }
  schema_id <- expected[[1L]]
  if (identical(schema_id, "NULL")) {
    sc_assert(is.null(value), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY expected present NULL at", path))
    return(schema_id)
  }
  if (identical(schema_id, "AST")) {
    sc_assert(is.list(value) && !is.null(names(value)) && "kind" %in% names(value),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY AST lacks exact kind at", path))
    kind <- value[["kind", exact = TRUE]]
    sc_assert(is.character(kind) && length(kind) == 1L && !is.na(kind) &&
                kind %in% registry$ast_kinds,
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY unknown AST kind at", path))
    return(paste0("K:", kind))
  }
  if (schema_id %in% c("RAT", "POLY")) return(schema_id)
  if (startsWith(schema_id, "K:")) {
    spec <- pk_shape_schema_spec(schema_id, registry)
    expected_kind <- if (!is.null(spec$kind_value)) spec$kind_value else substring(schema_id, 3L)
    sc_assert(is.list(value) && !is.null(names(value)) && "kind" %in% names(value) &&
                identical(value[["kind", exact = TRUE]], expected_kind),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY expected kind", expected_kind, "at", path))
  }
  schema_id
}

pk_validate_shape_leaf <- function(value, schema_id, path, parent_schema,
                                   parent_value, collector = NULL) {
  spec <- pk_shape_schema_spec(schema_id)
  leaf <- spec$atomic_type
  scalar_base <- function(expected_type = NULL) {
    sc_assert(!is.null(value) && is.atomic(value) && length(value) == 1L &&
                is.null(names(value)) && is.null(attributes(value)) &&
                typeof(value) %in% c("character", "logical", "integer", "double") &&
                (is.null(expected_type) || identical(typeof(value), expected_type)) &&
                !is.na(value) &&
                (!is.character(value) || nzchar(value)) &&
                (!is.numeric(value) || is.finite(value)),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY malformed typed leaf at", path))
  }
  exact_member <- function(actual, allowed) {
    any(vapply(allowed, function(candidate) identical(actual, candidate), logical(1)))
  }
  if (identical(leaf, "context_scalar")) {
    scalar_base(spec$storage_type)
    if (!is.null(spec$allowed_values)) {
      sc_assert(exact_member(value, spec$allowed_values), "FAIL_COVERAGE",
                paste("SHAPE_REGISTRY closed leaf domain changed at", path))
    }
    if (!is.null(spec$pattern)) {
      sc_assert(is.character(value) && grepl(spec$pattern, value, perl = TRUE),
                "FAIL_COVERAGE", paste("SHAPE_REGISTRY leaf grammar changed at", path))
    }
    if (identical(spec$semantic_rule, "BINDER_SOURCE_SORT")) {
      sc_assert(identical(parent_schema, "K:binder"), "FAIL_TYPE",
                paste("AST_TYPECHECK binder leaf lost parent at", path))
      source <- parent_value[["source_variable", exact = TRUE]]
      variable_sort <- parent_value[["variable_sort", exact = TRUE]]
      sc_assert((identical(source, "i") && identical(variable_sort, "Player")) ||
                  (source %in% c("K", "T") &&
                     identical(variable_sort, "FiniteSet<Player>")),
                "FAIL_TYPE", paste("AST_TYPECHECK binder source-sort mismatch at", path))
    }
    if (identical(spec$semantic_rule, "INTERVAL_ENDPOINT_OWNERSHIP")) {
      capture <- regmatches(path, regexec(
        "^/(?:S21/regions|S29/witnesses)/([1-9]|1[01])(?:/region|/sequential_rationality/proposer_deviations/comparisons/[1-4]/domain)?/prior/(?:lower_closed|upper_closed)$",
        path))[[1L]]
      sc_assert(length(capture) == 2L, "FAIL_BINDING",
                paste("SHAPE_REGISTRY interval endpoint lost region ordinal at", path))
      ordinal <- as.integer(capture[[2L]])
      expected_lower <- ordinal %in% c(1L, 3L, 7L, 9L, 11L)
      expected <- if (endsWith(path, "/lower_closed")) expected_lower else TRUE
      sc_assert(identical(value, expected), "FAIL_BINDING",
                paste("SHAPE_REGISTRY interval endpoint ownership changed at", path))
    }
    if (identical(spec$semantic_rule, "FRONTIER_DOMAIN")) {
      pair <- unlist(parent_value[["pair", exact = TRUE]], use.names = FALSE)
      expected <- if (identical(pair, c("S", "P"))) "o_0<o_1<1/m" else
        if (identical(pair, c("S", "E"))) "o_0<1/m" else NA_character_
      sc_assert(!is.na(expected) && identical(value, expected), "FAIL_BINDING",
                paste("SHAPE_REGISTRY frontier pair/domain mismatch at", path))
    }
    if (identical(spec$semantic_rule, "TYPE_PROBABILITY_ENDPOINT")) {
      vector <- unlist(parent_value[c("theta_0", "theta_1")], use.names = FALSE)
      sc_assert(identical(vector, c("1", "0")) || identical(vector, c("0", "1")),
                "FAIL_TYPE", paste("SHAPE_REGISTRY endpoint likelihood vector changed at", path))
    }
    if (spec$semantic_rule %in% c("FREE_BELIEF_NAME", "FREE_BELIEF_DOMAIN")) {
      name <- parent_value[["name", exact = TRUE]]
      activation <- parent_value[["activation", exact = TRUE]]
      expected_activation <- switch(name,
        `kappa_i(s)` = "individual proposal has zero strategy mass",
        `eta_i(s,v)` = "proposal-vote history has zero probability",
        NA_character_)
      sc_assert(!is.na(expected_activation) && identical(activation, expected_activation),
                "FAIL_BINDING", paste("SHAPE_REGISTRY free belief name/domain mismatch at", path))
    }
    if (identical(spec$semantic_rule, "LOCAL_DEFINITION") &&
        identical(spec$edge, "O:local_W/W")) {
      capture <- regmatches(path, regexec("^/S28/records/([1-9][0-9]*)/local_definitions/W$",
                                         path))[[1L]]
      sc_assert(length(capture) == 2L, "FAIL_BINDING",
                paste("SHAPE_REGISTRY local-W definition lost record ordinal at", path))
      ordinal <- as.integer(capture[[2L]])
      simplex_ordinals <- 173:183
      aggregation_ordinals <- unlist(lapply(0:10, function(index) 186:191 + 8L * index),
                                     use.names = FALSE)
      expected <- if (ordinal %in% simplex_ordinals)
        "weak-player set local to the identity simplex" else
        if (ordinal %in% aggregation_ordinals)
          "weak-player set local to the labeled aggregation record" else NA_character_
      sc_assert(!is.na(expected) && identical(value, expected), "FAIL_BINDING",
                paste("SHAPE_REGISTRY local-W path/value mismatch at", path))
    }
  } else if (identical(leaf, "interval_endpoint")) {
    scalar_base("character")
    sc_assert(value %in% c("0", "1") || grepl("^rat\\(", value),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY interval endpoint grammar changed at", path))
  } else if (leaf %in% c("weak_payoff_pivotal", "weak_payoff_pass_anyway",
                         "weak_payoff_fail_anyway")) {
    sc_assert(is.character(value) && length(value) == 2L && !anyNA(value) &&
                identical(names(value), c("yes", "no")) &&
                identical(names(attributes(value)), "names"),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY malformed yes/no payoff vector at", path))
    if (identical(leaf, "weak_payoff_pivotal")) {
      sc_assert(identical(unname(value[[1L]]), "x_j") &&
                  grepl("^rat\\(", unname(value[[2L]])), "FAIL_EQUIVALENCE",
                paste("SHAPE_REGISTRY pivotal payoff vector changed at", path))
    } else if (identical(leaf, "weak_payoff_pass_anyway")) {
      sc_assert(identical(unname(value), c("x_j", "x_j")), "FAIL_EQUIVALENCE",
                paste("SHAPE_REGISTRY passing payoff vector changed at", path))
    } else {
      sc_assert(identical(unname(value[[1L]]), unname(value[[2L]])) &&
                  grepl("^rat\\(", unname(value[[1L]])), "FAIL_EQUIVALENCE",
                paste("SHAPE_REGISTRY failure payoff vector changed at", path))
    }
  } else if (identical(leaf, "source_steps")) {
    sc_assert(identical(parent_schema, "O:domain_fact") && is.list(parent_value),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY source steps lost parent at", path))
    fact_id <- parent_value[["fact_id", exact = TRUE]]
    expected <- switch(fact_id,
      D.m.positive = "S07",
      D.lambda_s.positive = c("S26", "S25"),
      D.nu.positive_failure_history = c("S08", "S09", "S25"),
      D.one_minus_nu.positive_pass_history = c("S08", "S09", "S25"),
      sc_abort("FAIL_COVERAGE", paste("SHAPE_REGISTRY unknown source-step fact at", path)))
    sc_assert(is.character(value) && is.null(names(value)) &&
                is.null(attributes(value)) && !anyNA(value) &&
                identical(value, expected), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY source-step vector changed at", path))
  } else if (identical(leaf, "step_id")) {
    scalar_base("character")
    sc_assert(grepl("^S(?:0[1-9]|1[0-9]|2[0-9])$", value), "FAIL_BINDING",
              paste("SHAPE_REGISTRY premise step id changed at", path))
  } else if (identical(leaf, "indexed_index")) {
    scalar_base("character")
    sc_assert(grepl("^b[1-9][0-9]*$", value), "FAIL_TYPE",
              paste("AST_TYPECHECK indexed-symbol index changed at", path))
  } else if (identical(leaf, "inequality_chain_atom")) {
    scalar_base("character")
    expected <- c("0<beta*q", "beta*q<q", "q<=m", "0<m-beta*q", "0<(m-beta*q)/m")
    sc_assert(identical(unlist(parent_value, use.names = FALSE), expected),
              "FAIL_EQUIVALENCE", paste("SHAPE_REGISTRY inequality chain changed at", path))
  } else if (identical(leaf, "frontier_pair_atom")) {
    scalar_base("character")
    expected <- if (grepl("(?:^/S18/|frontier_SP|S_equals_P)", path))
      c("S", "P") else c("S", "E")
    sc_assert(identical(unlist(parent_value, use.names = FALSE), expected),
              "FAIL_BINDING", paste("SHAPE_REGISTRY frontier pair changed at", path))
  } else if (identical(leaf, "proposer_k_partition_atom")) {
    scalar_base("character")
    sc_assert(identical(unlist(parent_value, use.names = FALSE),
                        c("k>=q-1", "k=q-2", "k<=q-3")),
              "FAIL_EQUIVALENCE", paste("SHAPE_REGISTRY proposer k partition changed at", path))
  } else if (identical(leaf, "proposer_y_partition_atom")) {
    scalar_base("character")
    sc_assert(identical(unlist(parent_value, use.names = FALSE),
                        c("y<a0", "a0<=y<a1", "y>=a1")),
              "FAIL_EQUIVALENCE", paste("SHAPE_REGISTRY proposer y partition changed at", path))
  } else if (identical(leaf, "slack_domain_atom")) {
    scalar_base("character")
    sc_assert(identical(unlist(parent_value, use.names = FALSE), c("delta>0", "rho>0")),
              "FAIL_EQUIVALENCE", paste("SHAPE_REGISTRY slack domain changed at", path))
  } else if (identical(leaf, "ballot_coordinate_atom")) {
    scalar_base("character")
    expected <- if (grepl("/slack_fill/", path, fixed = TRUE)) c("y", "x") else c("x", "k")
    sc_assert(identical(unlist(parent_value, use.names = FALSE), expected),
              "FAIL_BINDING", paste("SHAPE_REGISTRY ballot coordinates changed at", path))
  } else if (identical(leaf, "H_trichotomy_atom")) {
    scalar_base("character")
    sc_assert(identical(unlist(parent_value, use.names = FALSE),
                        c("h_E<h_P", "h_P<h_E", "h_E=h_P")),
              "FAIL_EQUIVALENCE", paste("SHAPE_REGISTRY H trichotomy changed at", path))
  } else if (identical(leaf, "closure_source_step")) {
    scalar_base("character")
    sc_assert(identical(unlist(parent_value, use.names = FALSE),
                        c("S21", "S23", "S24", "S25", "S26", "S27")),
              "FAIL_BINDING", paste("SHAPE_REGISTRY closure source-step set changed at", path))
  } else if (leaf %in% c("free_symbol_identifier", "primitive_symbol_identifier")) {
    scalar_base("character")
    allowed <- if (identical(leaf, "free_symbol_identifier"))
      c("C_l", "W", "beta", "l", "lambda_s", "m", "nu", "o_0", "o_1", "q") else
      c("C_l", "beta", "m", "nu", "o_0", "o_1", "q")
    values <- unlist(parent_value, use.names = FALSE)
    sc_assert(value %in% allowed && identical(values, sort(unique(values))),
              "FAIL_TYPE", paste("AST_TYPECHECK symbol identifier set changed at", path))
  } else if (identical(leaf, "dominance_atom")) {
    scalar_base("character")
    allowed <- c("E=P>S", "E>R", "tie_break:E", "tie_break:P",
      "tie_break:all_mixtures", "E>S", "E>P", "P>S", "P>E", "S=E",
      "tie_break:S", "S>=E=P", "S>=E", "S>=P")
    sc_assert(value %in% allowed,
              "FAIL_EQUIVALENCE", paste("SHAPE_REGISTRY dominance atom changed at", path))
  } else if (identical(leaf, "factor_atom")) {
    scalar_base("character")
    sc_assert(value %in% c("1-nu", "beta", "o_1-o_0", "1-beta", "h_E"),
              "FAIL_EQUIVALENCE", paste("SHAPE_REGISTRY sign factor changed at", path))
    expected <- if (grepl("/S_equals_P/", path, fixed = TRUE))
      c("1-nu", "beta", "o_1-o_0") else c("1-beta", "h_E")
    sc_assert(identical(unlist(parent_value, use.names = FALSE), expected),
              "FAIL_EQUIVALENCE", paste("SHAPE_REGISTRY sign factor sequence changed at", path))
  } else if (identical(leaf, "support_derivation_atom")) {
    scalar_base("character")
    allowed_sets <- list(c("q<=m", "q-1<=m-1"),
                         c("q>=2", "q-2>=0", "q-2<=m-1"))
    actual <- unlist(parent_value, use.names = FALSE)
    sc_assert(any(vapply(allowed_sets, function(candidate) identical(actual, candidate),
                         logical(1))),
              "FAIL_EQUIVALENCE", paste("SHAPE_REGISTRY support derivation changed at", path))
  } else if (identical(leaf, "sha256_atom")) {
    scalar_base("character")
    sc_assert(grepl("^[0-9a-f]{64}$", value), "FAIL_BINDING",
              paste("SHAPE_REGISTRY SHA-256 atom changed at", path))
  } else if (identical(leaf, "selected_branch_atom")) {
    scalar_base("character")
    actual <- unlist(parent_value, use.names = FALSE)
    sc_assert(value %in% c("E", "S", "P") &&
                (length(actual) == 1L || identical(actual, c("E", "P"))),
              "FAIL_EQUIVALENCE",
              paste("SHAPE_REGISTRY selected branch changed at", path))
  } else if (identical(leaf, "sign_atom")) {
    scalar_base("character")
    allowed <- c("E=P>S", "E>R", "tie_break:E", "tie_break:P",
      "tie_break:all_mixtures", "E>S", "E>P", "P>S", "P>E", "S=E",
      "tie_break:S", "S>=E=P", "S>=E", "S>=P")
    sc_assert(value %in% allowed, "FAIL_EQUIVALENCE",
              paste("SHAPE_REGISTRY comparison sign atom changed at", path))
  } else if (identical(leaf, "region_tie_relation")) {
    scalar_base("character")
    sc_assert(value %in% c("h_E<h_P", "h_P<h_E", "h_E=h_P"),
              "FAIL_EQUIVALENCE", paste("SHAPE_REGISTRY tie relation changed at", path))
  } else if (identical(leaf, "domain_sources_SE")) {
    scalar_base("character")
    sc_assert(identical(value, "beta<1 and h_E>0 from o_0>0"),
              "FAIL_EQUIVALENCE", paste("SHAPE_REGISTRY S=E domain source changed at", path))
  } else {
    sc_abort("FAIL_COVERAGE", paste("SHAPE_REGISTRY unknown leaf validator at", path,
                                    schema_id))
  }
  if (!is.null(collector)) {
    collector$leaf_paths <- c(collector$leaf_paths, path)
    collector$leaf_schema_ids <- c(collector$leaf_schema_ids, schema_id)
    registry_signature <- paste0(
      "typeof=", typeof(value), ";length=", length(value),
      ";names=", if (is.null(names(value))) "<NULL>" else
        paste(names(value), collapse = "\x1f"),
      ";attributes=", if (is.null(attributes(value))) "<NULL>" else
        paste(names(attributes(value)), collapse = "\x1f"),
      ";anyNA=", anyNA(value),
      ";finite=", if (is.numeric(value)) all(is.finite(value)) else "NA")
    collector$leaf_type_signatures <- c(collector$leaf_type_signatures,
                                         registry_signature)
    if (length(value) != 1L || !is.null(names(value))) {
      collector$atomic_vector_paths <- c(collector$atomic_vector_paths, path)
    }
  }
  invisible(TRUE)
}

pk_validate_replay_shape_node <- function(value, schema_id, path = "",
                                          registry = pk_replay_shape_registry_v1(),
                                          collector = NULL, recursive = TRUE,
                                          parent_schema = NULL,
                                          parent_value = NULL, field = NULL,
                                          inside_ast = FALSE,
                                          ast_scope = list()) {
  if (length(schema_id) == 1L && startsWith(schema_id, "R:")) {
    sc_assert(!is.null(parent_schema) && !is.null(parent_value) && !is.null(field),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY route lacks parent at", path))
    schema_id <- pk_shape_resolve_route(schema_id, parent_schema, parent_value,
                                        field, path)
  }
  schema_id <- pk_shape_select_schema(value, schema_id, registry, path)
  if (identical(schema_id, "NULL")) {
    if (!is.null(collector)) collector$null_paths <- c(collector$null_paths, path)
    return(invisible(TRUE))
  }
  if (startsWith(schema_id, "L:")) {
    return(pk_validate_shape_leaf(value, schema_id, path, parent_schema,
                                  parent_value, collector))
  }
  if (!is.null(collector)) {
    collector$count <- collector$count + 1L
    collector$paths <- c(collector$paths, path)
    collector$schema_ids <- c(collector$schema_ids, schema_id)
    node_class <- if (identical(schema_id, "RAT")) "rat" else
      if (identical(schema_id, "POLY")) "poly" else "generic"
    collector$node_classes <- c(collector$node_classes, node_class)
    if (isTRUE(collector$keep_nodes)) {
      collector$nodes[[length(collector$nodes) + 1L]] <-
        list(path = path, schema_id = schema_id, value = value,
             inside_ast = inside_ast, ast_scope = ast_scope)
    }
  }
  if (identical(schema_id, "RAT")) {
    sc_assert(inherits(value, "ea_rat") &&
                identical(names(value), c("numerator", "denominator")),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY malformed ea_rat at", path))
    ea_assert_rat(value, paste("shape registry rational at", path))
    if (isTRUE(recursive)) {
      pk_validate_replay_shape_node(value$numerator, "POLY", paste0(path, "/numerator"),
                                    registry, collector, TRUE, "RAT", value,
                                    "numerator", inside_ast, ast_scope)
      pk_validate_replay_shape_node(value$denominator, "POLY", paste0(path, "/denominator"),
                                    registry, collector, TRUE, "RAT", value,
                                    "denominator", inside_ast, ast_scope)
    }
    return(invisible(TRUE))
  }
  if (identical(schema_id, "POLY")) {
    keys <- names(value)
    valid_key <- function(key) {
      if (identical(key, "1")) return(TRUE)
      pieces <- strsplit(key, "*", fixed = TRUE)[[1L]]
      all(grepl("^[A-Za-z][A-Za-z0-9_.]*\\^[1-9][0-9]*$", pieces))
    }
    sc_assert(inherits(value, "ea_poly") &&
                (length(value) == 0L || (!is.null(keys) &&
                   all(vapply(keys, valid_key, logical(1))))),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY malformed ea_poly at", path))
    ea_assert_poly(value, paste("shape registry polynomial at", path))
    return(invisible(TRUE))
  }
  spec <- pk_shape_schema_spec(schema_id, registry)
  node_kind <- if (is.list(value) && !is.null(names(value)) &&
                       "kind" %in% names(value)) value[["kind", exact = TRUE]] else NULL
  ast_node <- is.character(node_kind) && length(node_kind) == 1L && !is.na(node_kind) &&
    node_kind %in% c(registry$ast_kinds, "domain")
  if (isTRUE(ast_node) && !isTRUE(inside_ast)) {
    pk_assert_typed_ast_independent(value, scope = ast_scope, path = path)
  }
  child_inside_ast <- isTRUE(inside_ast) || isTRUE(ast_node)
  if (identical(spec$node_type, "array")) {
    sc_assert(identical(class(value), "list") && is.null(names(value)) &&
                length(value) %in% spec$lengths,
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY array shape changed at", path))
    if (!is.null(collector) && length(value) == 0L) {
      collector$empty_array_paths <- c(collector$empty_array_paths, path)
    }
    if (isTRUE(recursive) && length(value)) {
      for (index in seq_along(value)) {
        pk_validate_replay_shape_node(value[[index]], spec$element,
          paste0(path, "/", index), registry, collector, TRUE, schema_id,
          value, as.character(index), child_inside_ast, ast_scope)
      }
    }
    return(invisible(TRUE))
  }
  if (identical(spec$node_type, "positional_array")) {
    sc_assert(identical(class(value), "list") && is.null(names(value)) &&
                length(value) == spec$lengths &&
                length(spec$elements) == spec$lengths,
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY positional array changed at", path))
    if (isTRUE(recursive) && length(value)) {
      for (index in seq_along(value)) {
        pk_validate_replay_shape_node(value[[index]], spec$elements[[index]],
          paste0(path, "/", index), registry, collector, TRUE, schema_id,
          value, as.character(index), child_inside_ast, ast_scope)
      }
    }
    return(invisible(TRUE))
  }
  sc_assert(identical(spec$node_type, "object") && identical(class(value), "list") &&
              !is.null(names(value)) && !anyNA(names(value)) &&
              !anyDuplicated(names(value)) && !any(names(value) == "") &&
              any(vapply(spec$key_variants, function(keys) identical(names(value), keys),
                         logical(1))),
            "FAIL_COVERAGE", paste("SHAPE_REGISTRY object keys changed at", path))
  if (startsWith(schema_id, "K:")) {
    expected_kind <- if (!is.null(spec$kind_value)) spec$kind_value else
      substring(schema_id, 3L)
    sc_assert(identical(value[["kind", exact = TRUE]], expected_kind), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY kind changed at", path))
  }
  if (isTRUE(recursive)) {
    for (field in names(value)) {
      child_path <- paste0(path, "/", field)
      sc_assert(field %in% names(spec$children), "FAIL_COVERAGE",
                paste("SHAPE_REGISTRY unowned child at", child_path))
      child_scope <- ast_scope
      if (identical(schema_id, "K:identity_simplex") &&
          identical(field, "support_families")) {
        proposer_binder <- value[["proposer_binder", exact = TRUE]]
        sc_assert(is.list(proposer_binder) &&
                    identical(proposer_binder[["kind", exact = TRUE]], "binder"),
                  "FAIL_TYPE", paste("AST_TYPECHECK simplex proposer scope at", path))
        child_scope[[proposer_binder[["variable", exact = TRUE]]]] <-
          proposer_binder[["variable_sort", exact = TRUE]]
      }
      if (identical(schema_id, "O:support_family") && identical(field, "weight")) {
        coalition_binder <- value[["binder", exact = TRUE]]
        sc_assert(is.list(coalition_binder) &&
                    identical(coalition_binder[["kind", exact = TRUE]], "binder"),
                  "FAIL_TYPE", paste("AST_TYPECHECK coalition scope at", path))
        child_scope[[coalition_binder[["variable", exact = TRUE]]]] <-
          coalition_binder[["variable_sort", exact = TRUE]]
      }
      pk_validate_replay_shape_node(value[[field]], spec$children[[field]], child_path,
                                    registry, collector, TRUE, schema_id, value,
                                    field, child_inside_ast, child_scope)
    }
  }
  invisible(TRUE)
}

pk_replay_shape_registry_lint <- function(registry = pk_replay_shape_registry_v1()) {
  prefixes <- list(K = registry$kinds, O = registry$objects,
                   A = registry$arrays, L = registry$leaves)
  schema_ids <- unlist(Map(function(prefix, entries) paste0(prefix, ":", names(entries)),
                           names(prefixes), prefixes), use.names = FALSE)
  sc_assert(length(schema_ids) == length(unique(schema_ids)), "FAIL_COVERAGE",
            "SHAPE_REGISTRY duplicate schema ids")
  route_ids <- c(
    "R:interval_rational_cache", "R:region_tie", "R:comparison_tie",
    "R:mixture_indifference", "R:formula_premises", "R:binder_constraints",
    "R:fact_domain", "R:sign_certificate_variant",
    "R:branch_budgets", "R:public_vote_belief", "R:indexed_H_by_type",
    "R:indexed_outcomes", "R:support_families", "R:simplex_nonnegative",
    "R:support_nonempty_derivation", "R:local_definitions"
  )
  special_ids <- c("AST", "RAT", "POLY", "NULL")
  validate_ref <- function(ref, context) {
    sc_assert(is.character(ref) && length(ref) >= 1L && !anyNA(ref),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY malformed ref at", context))
    if (length(ref) > 1L) {
      safe_union <- setequal(ref, c("RAT", "NULL")) ||
        setequal(ref, c("K:formula", "K:symbol"))
      sc_assert(safe_union, "FAIL_COVERAGE",
                paste("SHAPE_REGISTRY untagged union at", context))
      invisible(lapply(ref, validate_ref, context = context))
      return(invisible(TRUE))
    }
    sc_assert(ref %in% c(schema_ids, route_ids, special_ids), "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY unresolved ref", ref, "at", context))
    invisible(TRUE)
  }
  for (schema_id in schema_ids) {
    spec <- pk_shape_schema_spec(schema_id, registry)
    sc_assert(identical(names(spec)[[1L]], "node_type") &&
                spec$node_type %in% c("object", "array", "positional_array", "leaf"),
              "FAIL_COVERAGE", paste("SHAPE_REGISTRY invalid node type", schema_id))
    if (identical(spec$node_type, "object")) {
      sc_assert(length(spec$key_variants) == 1L &&
                  is.character(spec$key_variants[[1L]]) &&
                  length(spec$key_variants[[1L]]) > 0L &&
                  !anyNA(spec$key_variants[[1L]]) &&
                  !anyDuplicated(spec$key_variants[[1L]]) &&
                  !any(spec$key_variants[[1L]] == "") &&
                  setequal(names(spec$children), spec$key_variants[[1L]]),
                "FAIL_COVERAGE", paste("SHAPE_REGISTRY open object schema", schema_id))
      if (startsWith(schema_id, "K:")) {
        sc_assert(identical(spec$key_variants[[1L]][[1L]], "kind") &&
                    (is.null(spec$kind_value) ||
                       (is.character(spec$kind_value) && length(spec$kind_value) == 1L &&
                          !is.na(spec$kind_value) && nzchar(spec$kind_value))),
                  "FAIL_COVERAGE", paste("SHAPE_REGISTRY invalid kind schema", schema_id))
      }
      for (field in names(spec$children)) {
        validate_ref(spec$children[[field]], paste0(schema_id, "/", field))
      }
    } else if (identical(spec$node_type, "array")) {
      sc_assert(is.integer(spec$lengths) && length(spec$lengths) >= 1L &&
                  all(spec$lengths >= 0L) &&
                  identical(spec$lengths, sort(unique(spec$lengths))),
                "FAIL_COVERAGE", paste("SHAPE_REGISTRY invalid array cardinality", schema_id))
      if (!is.null(spec$element)) {
        validate_ref(spec$element, paste0(schema_id, "/*"))
      } else {
        sc_assert(all(spec$lengths == 0L), "FAIL_COVERAGE",
                  paste("SHAPE_REGISTRY nonempty array lacks typed element", schema_id))
      }
    } else if (identical(spec$node_type, "positional_array")) {
      sc_assert(is.integer(spec$lengths) && length(spec$lengths) == 1L &&
                  spec$lengths >= 0L && length(spec$elements) == spec$lengths,
                "FAIL_COVERAGE", paste("SHAPE_REGISTRY invalid positional array", schema_id))
      for (index in seq_along(spec$elements)) {
        validate_ref(spec$elements[[index]], paste0(schema_id, "/", index))
      }
    } else {
      allowed_leaf_types <- c(
        "context_scalar", "interval_endpoint", "weak_payoff_pivotal",
        "weak_payoff_pass_anyway", "weak_payoff_fail_anyway", "source_steps",
        "step_id", "indexed_index", "inequality_chain_atom", "frontier_pair_atom",
        "proposer_k_partition_atom", "proposer_y_partition_atom",
        "slack_domain_atom", "ballot_coordinate_atom", "H_trichotomy_atom",
        "closure_source_step", "free_symbol_identifier",
        "primitive_symbol_identifier", "dominance_atom", "factor_atom",
        "support_derivation_atom", "sha256_atom", "selected_branch_atom",
        "sign_atom", "region_tie_relation", "domain_sources_SE")
      sc_assert(schema_id %in% paste0("L:", names(registry$leaves)) &&
                  spec$atomic_type %in% allowed_leaf_types,
                "FAIL_COVERAGE", paste("SHAPE_REGISTRY invalid leaf", schema_id))
    }
  }
  sc_assert(is.character(registry$step_schemas) &&
              identical(names(registry$step_schemas),
                        c(sprintf("S%02d", 1:24), "S26", "S25", "S27", "S28", "S29")),
            "FAIL_COVERAGE", "SHAPE_REGISTRY root grammar changed")
  invisible(lapply(seq_along(registry$step_schemas), function(index) {
    validate_ref(registry$step_schemas[[index]], names(registry$step_schemas)[[index]])
  }))
  route_targets <- c(
    "NULL", "RAT", "K:formula", "L:region_tie_relation",
    "O:sign_certificate_SP", "O:sign_certificate_SE",
    "A:premises0", "A:premises1",
    "A:premises4", "A:premises_payoff", "A:premises_budget", "A:ast0",
    "A:ast1", "A:ast2", "K:domain_one", "K:domain_two",
    "O:budgets_E", "O:budgets_S", "O:budgets_P", "O:budgets_EP",
    "K:separating_H_vote", "K:nonseparating_H_vote", "O:theta_indexed_EP",
    "O:theta_formulas_regular", "O:outcomes_EP", "O:outcomes_regular",
    "A:support_families1", "A:support_families2", "A:quantifiers1",
    "A:quantifiers2", "A:support_derivations1_short",
    "A:support_derivations1_long", "A:support_derivations2",
    "O:domain_sources", "O:local_lambda", "O:local_W", "O:local_W_l_C",
    "A:empty"
  )
  invisible(lapply(route_targets, validate_ref, context = "route target"))
  child_refs <- function(schema_id) {
    spec <- pk_shape_schema_spec(schema_id, registry)
    refs <- if (identical(spec$node_type, "object")) {
      unlist(spec$children, use.names = FALSE)
    } else if (identical(spec$node_type, "array")) {
      spec$element
    } else if (identical(spec$node_type, "positional_array")) {
      spec$elements
    } else character(0)
    refs[refs %in% schema_ids]
  }
  queue <- c(unname(registry$step_schemas), route_targets,
             paste0("K:", registry$ast_kinds))
  reachable <- character(0)
  while (length(queue)) {
    current <- queue[[1L]]; queue <- queue[-1L]
    if (current %in% c(special_ids, route_ids) || current %in% reachable) next
    sc_assert(current %in% schema_ids, "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY reachability found unknown schema", current))
    reachable <- c(reachable, current)
    spec <- pk_shape_schema_spec(current, registry)
    refs <- if (identical(spec$node_type, "object")) {
      unlist(spec$children, use.names = FALSE)
    } else if (identical(spec$node_type, "array")) spec$element else
      if (identical(spec$node_type, "positional_array")) spec$elements else character(0)
    if ("AST" %in% refs) refs <- c(refs, paste0("K:", registry$ast_kinds))
    queue <- c(queue, refs[refs %in% schema_ids])
  }
  sc_assert(setequal(reachable, schema_ids), "FAIL_COVERAGE",
            paste("SHAPE_REGISTRY unreachable schemas:",
                  paste(setdiff(schema_ids, reachable), collapse = ",")))
  sc_assert(length(registry$context_leaf_edges) == 201L &&
              !anyDuplicated(names(registry$context_leaf_edges)) &&
              !anyDuplicated(unname(registry$context_leaf_edges)) &&
              all(unname(registry$context_leaf_edges) %in% schema_ids),
            "FAIL_COVERAGE", "SHAPE_REGISTRY literal context-leaf map is not bijective 201/201")
  registry_literal <- pk_canonical_json(registry)
  sc_assert(!grepl("L:scalar|__CONTEXT_LEAF__|nullable_scalar|nullable_formula",
                   registry_literal, perl = TRUE),
            "FAIL_COVERAGE", "SHAPE_REGISTRY contains a generic leaf/default route")

  # Outside the explicitly recursive AST placeholder, the representation
  # graph must be acyclic.  This rejects accidental self-reference and schema
  # aliases that would otherwise evade finite exhaustive traversal.
  state <- setNames(integer(length(schema_ids)), schema_ids)
  visit <- function(schema_id) {
    if (state[[schema_id]] == 2L) return(invisible(TRUE))
    sc_assert(state[[schema_id]] == 0L, "FAIL_COVERAGE",
              paste("SHAPE_REGISTRY non-AST schema cycle at", schema_id))
    state[[schema_id]] <<- 1L
    for (child in child_refs(schema_id)) visit(child)
    state[[schema_id]] <<- 2L
    invisible(TRUE)
  }
  invisible(lapply(schema_ids, visit))
  registry_hash <- sc_sha256_text(registry_literal)
  sc_assert(identical(registry_hash, pk_replay_shape_registry_sha256_v1()),
            "FAIL_PACKAGE_INTEGRITY", "SHAPE_REGISTRY literal bytes changed")
  list(status = "SHAPE_REGISTRY_LINTED", schema_count = length(schema_ids),
       route_count = length(route_ids), reachable_schema_count = length(reachable),
       registry_sha256 = registry_hash)
}

# This traversal is intentionally ignorant of the registry.  Its only job is
# to enumerate the raw in-memory container graph so registry coverage can be
# compared as a path/class bijection rather than accepted from a self-reported
# count.  Algebra is recognized only by its class and then checked separately;
# polynomial coefficients are opaque big rationals, not JSON containers.
pk_raw_replay_inventory <- function(values, keep_nodes = FALSE) {
  inventory <- new.env(parent = emptyenv())
  inventory$paths <- character(0); inventory$classes <- character(0)
  inventory$object_paths <- character(0); inventory$array_paths <- character(0)
  inventory$empty_array_paths <- character(0); inventory$null_paths <- character(0)
  inventory$atomic_vector_paths <- character(0); inventory$leaf_paths <- character(0)
  inventory$leaf_type_signatures <- character(0); inventory$nodes <- list()
  inventory$leaf_nodes <- list()
  walk <- function(value, path) {
    if (is.null(value)) {
      inventory$null_paths <- c(inventory$null_paths, path)
      return(invisible(NULL))
    }
    if (!is.list(value)) {
      raw_signature <- paste0(
        "typeof=", typeof(value), ";length=", length(value),
        ";names=", if (is.null(names(value))) "<NULL>" else
          paste(names(value), collapse = "\x1f"),
        ";attributes=", if (is.null(attributes(value))) "<NULL>" else
          paste(names(attributes(value)), collapse = "\x1f"),
        ";anyNA=", anyNA(value),
        ";finite=", if (is.numeric(value)) all(is.finite(value)) else "NA")
      inventory$leaf_paths <- c(inventory$leaf_paths, path)
      inventory$leaf_type_signatures <- c(inventory$leaf_type_signatures,
                                           raw_signature)
      if (isTRUE(keep_nodes)) {
        inventory$leaf_nodes[[length(inventory$leaf_nodes) + 1L]] <-
          list(path = path, value = value, type_signature = raw_signature)
      }
      if (length(value) != 1L || !is.null(names(value))) {
        inventory$atomic_vector_paths <- c(inventory$atomic_vector_paths, path)
      }
      return(invisible(NULL))
    }
    node_class <- if (inherits(value, "ea_rat")) "rat" else
      if (inherits(value, "ea_poly")) "poly" else "generic"
    inventory$paths <- c(inventory$paths, path)
    inventory$classes <- c(inventory$classes, node_class)
    if (isTRUE(keep_nodes)) {
      inventory$nodes[[length(inventory$nodes) + 1L]] <-
        list(path = path, node_class = node_class, value = value)
    }
    if (identical(node_class, "poly")) return(invisible(NULL))
    if (identical(node_class, "generic")) {
      if (is.null(names(value))) {
        inventory$array_paths <- c(inventory$array_paths, path)
        if (length(value) == 0L) {
          inventory$empty_array_paths <- c(inventory$empty_array_paths, path)
        }
      } else inventory$object_paths <- c(inventory$object_paths, path)
    }
    if (length(value)) {
      for (index in seq_along(value)) {
        label <- if (is.null(names(value))) as.character(index) else names(value)[[index]]
        walk(value[[index]], paste0(path, "/", label))
      }
    }
    invisible(NULL)
  }
  for (step_id in names(values)) walk(values[[step_id]], paste0("/", step_id))
  per_step <- lapply(names(values), function(step_id) {
    prefix <- paste0("/", step_id)
    owned <- inventory$paths == prefix |
      startsWith(inventory$paths, paste0(prefix, "/"))
    classes <- inventory$classes[owned]
    c(all = sum(owned), rat = sum(classes == "rat"),
      poly = sum(classes == "poly"), generic = sum(classes == "generic"))
  })
  names(per_step) <- names(values)
  list(paths = inventory$paths, classes = inventory$classes,
       object_paths = inventory$object_paths, array_paths = inventory$array_paths,
       empty_array_paths = inventory$empty_array_paths,
       null_paths = inventory$null_paths,
       atomic_vector_paths = inventory$atomic_vector_paths,
       leaf_paths = inventory$leaf_paths,
       leaf_type_signatures = inventory$leaf_type_signatures,
       per_step = per_step, nodes = inventory$nodes,
       leaf_nodes = inventory$leaf_nodes)
}

pk_shape_registry_fixture_audit <- function(registry = pk_replay_shape_registry_v1()) {
  fixtures <- list(
    unary = list(kind = "unary", sort = "Probability", operator = "-",
                 argument = list(kind = "symbol", sort = "Probability", name = "beta")),
    logical = list(
      kind = "logical", sort = "Proposition", operator = "and",
      arguments = list(
        list(kind = "compare", sort = "Proposition", operator = ">",
             left = list(kind = "symbol", sort = "Probability", name = "beta"),
             right = list(kind = "number", sort = "Rational", value = "0")),
        list(kind = "compare", sort = "Proposition", operator = "<",
             left = list(kind = "symbol", sort = "Probability", name = "beta"),
             right = list(kind = "number", sort = "Rational", value = "1"))
      )),
    call = list(
      kind = "call", sort = "Integer", name = "floor",
      arguments = list(
        list(kind = "binary", sort = "Real", operator = "/",
             left = list(kind = "symbol", sort = "Integer", name = "N"),
             right = list(kind = "number", sort = "Rational", value = "2"))))
  )
  collector <- new.env(parent = emptyenv())
  collector$count <- 0L; collector$paths <- character(0)
  collector$schema_ids <- character(0); collector$node_classes <- character(0)
  collector$keep_nodes <- FALSE; collector$nodes <- list()
  collector$leaf_paths <- character(0); collector$leaf_schema_ids <- character(0)
  collector$leaf_type_signatures <- character(0)
  collector$atomic_vector_paths <- character(0); collector$null_paths <- character(0)
  collector$empty_array_paths <- character(0)
  for (name in names(fixtures)) {
    pk_validate_replay_shape_node(fixtures[[name]], "AST", paste0("/fixture/", name),
                                  registry, collector, TRUE)
  }
  sc_assert(all(c("K:unary", "K:logical", "K:call", "A:ast_0_4", "A:ast_1_4") %in%
                  collector$schema_ids), "FAIL_COVERAGE",
            "SHAPE_REGISTRY AST fixture coverage changed")
  list(status = "SHAPE_REGISTRY_FIXTURES_CHECKED", fixture_count = length(fixtures),
       schema_ids = unique(c(collector$schema_ids, collector$leaf_schema_ids)))
}

pk_assert_closed_replay_shapes <- function(values, collect_nodes = FALSE) {
  registry <- pk_replay_shape_registry_v1()
  lint <- pk_replay_shape_registry_lint(registry)
  sc_assert(is.list(values) && identical(names(values), names(registry$step_schemas)),
            "FAIL_COVERAGE",
            "SHAPE_REGISTRY step path/order bijection changed")
  collector <- new.env(parent = emptyenv())
  collector$count <- 0L; collector$paths <- character(0)
  collector$schema_ids <- character(0); collector$keep_nodes <- isTRUE(collect_nodes)
  collector$node_classes <- character(0); collector$nodes <- list()
  collector$leaf_paths <- character(0); collector$leaf_schema_ids <- character(0)
  collector$leaf_type_signatures <- character(0)
  collector$atomic_vector_paths <- character(0); collector$null_paths <- character(0)
  collector$empty_array_paths <- character(0)
  for (step_id in names(registry$step_schemas)) {
    pk_validate_replay_shape_node(values[[step_id]], registry$step_schemas[[step_id]],
                                  paste0("/", step_id), registry, collector, TRUE)
  }
  sc_assert(collector$count == registry$expected_node_count,
            "FAIL_COVERAGE", paste("SHAPE_REGISTRY node coverage changed:",
                                    collector$count, "!=", registry$expected_node_count))
  sc_assert(length(unique(collector$paths)) == collector$count,
            "FAIL_COVERAGE", "SHAPE_REGISTRY duplicate recursive paths")
  raw <- pk_raw_replay_inventory(values, keep_nodes = FALSE)
  sc_assert(identical(collector$paths, raw$paths) &&
              identical(collector$node_classes, raw$classes),
            "FAIL_COVERAGE", "SHAPE_REGISTRY path/class bijection changed")
  sc_assert(identical(collector$leaf_paths, raw$leaf_paths) &&
              identical(collector$leaf_type_signatures,
                        raw$leaf_type_signatures) &&
              length(unique(collector$leaf_paths)) == length(collector$leaf_paths) &&
              length(raw$leaf_paths) == registry$expected_atomic_leaf_count,
            "FAIL_COVERAGE", "SHAPE_REGISTRY raw atomic-leaf bijection changed")
  class_counts <- c(generic = sum(raw$classes == "generic"),
                    rat = sum(raw$classes == "rat"),
                    poly = sum(raw$classes == "poly"))
  generic_counts <- c(object = length(raw$object_paths), array = length(raw$array_paths))
  sc_assert(identical(class_counts, registry$expected_class_counts) &&
              identical(generic_counts, registry$expected_generic_counts),
            "FAIL_COVERAGE", "SHAPE_REGISTRY container class totals changed")
  sc_assert(identical(collector$null_paths, raw$null_paths) &&
              length(raw$null_paths) == registry$expected_null_count,
            "FAIL_COVERAGE", "SHAPE_REGISTRY NULL ownership changed")
  sc_assert(identical(collector$atomic_vector_paths, raw$atomic_vector_paths) &&
              length(raw$atomic_vector_paths) == registry$expected_atomic_vector_count,
            "FAIL_COVERAGE", "SHAPE_REGISTRY atomic-vector ownership changed")
  sc_assert(identical(collector$empty_array_paths, raw$empty_array_paths) &&
              length(raw$empty_array_paths) == registry$expected_empty_array_count,
            "FAIL_COVERAGE", "SHAPE_REGISTRY empty-array ownership changed")
  sc_assert(identical(raw$per_step, registry$expected_per_step), "FAIL_COVERAGE",
            "SHAPE_REGISTRY per-step path/class checksum changed")
  missing_kinds <- setdiff(registry$required_kind_schemas, unique(collector$schema_ids))
  sc_assert(length(missing_kinds) == 0L, "FAIL_COVERAGE",
            paste("SHAPE_REGISTRY mandatory kind paths unexercised:",
                  paste(missing_kinds, collapse = ",")))
  fixtures <- pk_shape_registry_fixture_audit(registry)
  all_schema_ids <- c(paste0("K:", names(registry$kinds)),
                      paste0("O:", names(registry$objects)),
                      paste0("A:", names(registry$arrays)),
                      paste0("L:", names(registry$leaves)))
  exercised <- unique(c(collector$schema_ids, collector$leaf_schema_ids,
                        fixtures$schema_ids))
  sc_assert(all(all_schema_ids %in% exercised), "FAIL_COVERAGE",
            paste("SHAPE_REGISTRY schemas lack baseline/fixture exercise:",
                  paste(setdiff(all_schema_ids, exercised), collapse = ",")))
  list(node_count = collector$count, class_counts = class_counts,
       generic_counts = generic_counts, null_count = length(raw$null_paths),
       atomic_vector_count = length(raw$atomic_vector_paths),
       atomic_leaf_count = length(raw$leaf_paths),
       empty_array_count = length(raw$empty_array_paths),
       paths = collector$paths,
       schema_ids = collector$schema_ids, leaf_paths = collector$leaf_paths,
       leaf_schema_ids = collector$leaf_schema_ids,
       leaf_type_signatures = collector$leaf_type_signatures,
       nodes = collector$nodes, registry_lint = lint, fixture_audit = fixtures,
       status = "SHAPE_REGISTRY_CLOSED")
}

pk_replay_proofs <- function(steps, primitives, n1, claim_spec) {
  pk_require_axioms(primitives)
  n1 <- pk_reload_frozen_n1(n1)
  pk_validate_step_schema(steps)
  allowed <- c("IMPORT_EXACT", "DISCOUNT_ONCE", "QUOTA_EVAL", "PAYOFF_EVAL",
               "BEST_RESPONSE", "ALGEBRA_EQ", "SIGN_FROM_DOMAIN", "BUDGET_SATURATION",
               "HEDGE_TRANSFORM", "ARGMAX_BY_CASES", "SOLVE_LINEAR_INEQUALITY",
               "INTERVAL_PARTITION", "FEASIBILITY", "TIE_BREAK", "BAYES", "SIMPLEX_SUM",
               "INDEXED_SUM", "FREE_SYMBOL_CLOSURE", "PBE_WITNESS")
  ids <- vapply(steps, `[[`, character(1), "step_id")
  sc_assert(length(unique(ids)) == length(ids), "FAIL_CERTIFICATE", "duplicate proof step ids")
  sc_assert(!any(vapply(steps, function(step) step$rule %in% c("ASSUME", "TARGET"), logical(1))),
            "FAIL_CERTIFICATE", "assumption/target-as-premise rule is forbidden")
  values <- list()
  for (step in steps) {
    sc_assert(step$rule %in% allowed, "FAIL_CERTIFICATE", paste("unknown rule", step$rule))
    refs <- unlist(step$refs, use.names = FALSE)
    sc_assert(all(refs %in% names(values)), "FAIL_CERTIFICATE",
              paste("step", step$step_id, "has unresolved/cyclic refs"))
    values[[step$step_id]] <- pk_dispatch(step, values, primitives, n1, primitives$symbols)
  }
  # Representation closure is checked only after every independently replayed
  # rule has produced its value and before any claim bundle is assembled.
  # Consequently no certificate can hash or select an ignored open-world field.
  shape_audit <- pk_assert_closed_replay_shapes(values, collect_nodes = FALSE)
  expected_spec <- pk_claim_obligation_registry_v1()
  pk_claim_obligation_registry_lint(expected_spec)
  sc_assert(identical(pk_canonical_json(claim_spec), pk_canonical_json(expected_spec)),
            "FAIL_BINDING", "claim theorem registry differs from the independent literal registry")
  claim_spec <- expected_spec
  obligation_steps <- unlist(lapply(claim_spec, function(spec) {
    vapply(spec$obligations, `[[`, character(1), "step_id")
  }), use.names = FALSE)
  sc_assert(all(obligation_steps %in% names(values)), "FAIL_CERTIFICATE",
            "claim bundle references a missing proof step")
  used <- unique(c(unlist(lapply(steps, `[[`, "refs"), use.names = FALSE),
                   obligation_steps))
  sc_assert(setequal(used, ids), "FAIL_CERTIFICATE", "orphan proof step detected")
  core <- pk_expected_core(primitives, primitives$symbols, n1)
  registry <- pk_load_claim_registry(core, primitives$symbols)
  pk_assert_claim_registry_postload(registry, core, primitives$symbols)
  sc_assert(identical(vapply(registry$records, `[[`, character(1), "claim_id"),
                      vapply(claim_spec, `[[`, character(1), "claim_id")),
            "FAIL_BINDING", "ledger and theorem registry claim ids differ")
  # Certificate assembly is deliberately scoped inside the completed replay.
  # There is no global assembler that can be fed caller-created values.  The
  # package verifier must rerun this function and compare the full bundle.
  certificates <- lapply(seq_along(claim_spec), function(index) {
    spec <- claim_spec[[index]]; source <- registry$records[[index]]
    sc_assert(identical(spec$claim_id, source$claim_id), "FAIL_BINDING",
              "claim theorem bundle is not bound to ledger order")
    obligations <- lapply(spec$obligations, function(obligation) {
      value <- pk_resolve_selector(values[[obligation$step_id]], obligation$selector)
      pk_validate_obligation_kind(value, obligation$expected_kind,
                                  obligation$obligation_id)
      list(obligation_id = obligation$obligation_id,
           step_id = obligation$step_id, selector = obligation$selector,
           expected_kind = obligation$expected_kind,
           conclusion_hash = pk_object_hash(value),
           status = "FORMAL_OBLIGATION_REPLAYED")
    })
    source_binding <- pk_certificate_source_binding(source)
    payload <- list(
      certificate_id = paste0("CERT-", spec$claim_id), claim_id = spec$claim_id,
      theorem_kind = spec$theorem_kind, obligations = obligations,
      source_binding = source_binding, machine_scope = source$machine_scope,
      human_residual_status = source$human_residual_status,
      status = "FORMAL_COMPONENTS_REPLAYED")
    list(certificate_id = payload$certificate_id, claim_id = payload$claim_id,
         theorem_kind = payload$theorem_kind, obligations = payload$obligations,
         certificate_hash = pk_object_hash(payload),
         source_binding = payload$source_binding, machine_scope = payload$machine_scope,
         human_residual_status = payload$human_residual_status,
         status = payload$status)
  })
  pk_assert_certificates_postload(certificates, expected_spec, values, registry)
  result <- list(values = values, certificates = certificates,
                 claim_registry = registry, shape_audit = shape_audit,
                 regions = values$S21$regions, partition = values$S22,
                 witnesses = values$S29$witnesses,
                 status = "INTERNAL_REPLAY_NOT_READY")
  pk_assert_final_replay_wrapper(result, primitives, n1)
  result
}

pk_public_value <- function(value) {
  if (inherits(value, "bigq") || inherits(value, "bigz")) return(as.character(value))
  if (inherits(value, "ea_poly")) return(ea_poly_canonical(value))
  if (inherits(value, "ea_rat")) return(ea_rat_canonical(value))
  if (!is.list(value)) return(value)
  output <- lapply(value, pk_public_value)
  names(output) <- names(value)
  output
}
