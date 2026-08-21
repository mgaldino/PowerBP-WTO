# Typed expression parser used by the derived N3/N4 certification layer.
#
# This file deliberately does not call parse(), eval(), source a builder, or
# know any candidate JSON path.  It accepts a small mathematical language and
# requires complete consumption of the input.

sc_abort <- function(code, message) {
  stop(paste0(code, ": ", message), call. = FALSE)
}

sc_assert <- function(condition, code, message) {
  if (!isTRUE(condition)) sc_abort(code, message)
  invisible(TRUE)
}

sc_sha256_raw <- function(value) {
  path <- tempfile("semantic-bytes-")
  on.exit(unlink(path, force = TRUE), add = TRUE)
  writeBin(value, path)
  output <- system2("shasum", c("-a", "256", shQuote(path)), stdout = TRUE,
                    env = c("LC_ALL=C", "LANG=C"))
  sc_assert(length(output) == 1L, "FAIL_BINDING", "could not hash bytes")
  sub("[[:space:]].*$", "", output[[1L]])
}

sc_sha256_text <- function(value) {
  sc_assert(is.character(value) && length(value) == 1L && !is.na(value),
            "FAIL_TYPE", "text hash requires one string")
  sc_sha256_raw(charToRaw(enc2utf8(value)))
}

sc_sha256_file <- function(path) {
  output <- system2("shasum", c("-a", "256", shQuote(path)), stdout = TRUE,
                    env = c("LC_ALL=C", "LANG=C"))
  sc_assert(length(output) == 1L, "FAIL_PACKAGE_INTEGRITY",
            paste("could not hash", path))
  hash <- sub("[[:space:]].*$", "", output[[1L]])
  sc_assert(grepl("^[0-9a-f]{64}$", hash), "FAIL_PACKAGE_INTEGRITY",
            paste("malformed SHA-256 for", path))
  hash
}

sc_assert_unique_json_keys <- function(value, pointer = "") {
  if (!is.list(value)) return(invisible(TRUE))
  object_names <- names(value)
  if (!is.null(object_names)) {
    sc_assert(!anyDuplicated(object_names), "FAIL_TYPE",
              paste("duplicate JSON key at", if (nzchar(pointer)) pointer else "/"))
  }
  for (index in seq_along(value)) {
    key <- if (is.null(object_names)) as.character(index - 1L) else object_names[[index]]
    child <- paste0(pointer, "/", gsub("/", "~1", gsub("~", "~0", key, fixed = TRUE),
                                       fixed = TRUE))
    sc_assert_unique_json_keys(value[[index]], child)
  }
  invisible(TRUE)
}

sc_read_json_strict <- function(path) {
  sc_assert(is.character(path) && length(path) == 1L && file.exists(path),
            "FAIL_BINDING", paste("JSON input is missing:", path))
  size <- file.info(path)$size
  connection <- file(path, open = "rb")
  on.exit(close(connection), add = TRUE)
  bytes <- readBin(connection, what = "raw", n = size)
  sc_assert(length(bytes) == size, "FAIL_BINDING", paste("short JSON read:", path))
  sc_assert(!(length(bytes) >= 3L && identical(as.integer(bytes[1:3]), c(239L, 187L, 191L))),
            "FAIL_PARSE", "UTF-8 BOM is forbidden in canonical JSON inputs")
  sc_assert(!any(as.integer(bytes) == 0L), "FAIL_PARSE", "NUL byte in JSON input")
  text <- rawToChar(bytes)
  sc_assert(!is.na(iconv(text, from = "UTF-8", to = "UTF-8", sub = NA_character_)),
            "FAIL_PARSE", "JSON input is not valid UTF-8")
  sc_assert(jsonlite::validate(text), "FAIL_PARSE", paste("invalid JSON:", path))
  object <- jsonlite::parse_json(text, simplifyVector = FALSE)
  sc_assert_unique_json_keys(object)
  attr(object, "source_sha256") <- sc_sha256_raw(bytes)
  attr(object, "source_bytes") <- length(bytes)
  object
}

sc_tokenize <- function(text) {
  sc_assert(is.character(text) && length(text) == 1L && !is.na(text),
            "FAIL_TYPE", "parser input must be one string")
  bytes <- charToRaw(enc2utf8(text))
  sc_assert(all(as.integer(bytes) < 128L), "FAIL_PARSE",
            "formal mathematical spans must be ASCII; UTF-8 prose is segmented outside the parser")
  source <- rawToChar(bytes)
  n <- nchar(source, type = "bytes")
  position <- 1L
  tokens <- list()
  add <- function(kind, value, begin, end) {
    tokens[[length(tokens) + 1L]] <<- list(
      kind = kind, value = value, byte_start = begin - 1L, byte_end = end - 1L
    )
  }
  while (position <= n) {
    rest <- substr(source, position, n)
    ws <- regexpr("^[[:space:]]+", rest, perl = TRUE)
    if (ws[[1L]] == 1L) {
      position <- position + attr(ws, "match.length")
      next
    }
    # AST numerals are unsigned canonical integers.  Exact fractions are
    # represented by division nodes and negative values by unary minus.  Keep
    # this lexer check independent of both the proof-kernel typechecker and the
    # replay registry: a coordinated weakening in one layer must not authorize
    # a noncanonical spelling in either of the other two.
    number <- regexpr("^(?:[0-9]+(?:\\.[0-9]*)?|\\.[0-9]+)", rest, perl = TRUE)
    if (number[[1L]] == 1L) {
      length <- attr(number, "match.length")
      value <- substr(source, position, position + length - 1L)
      sc_assert(grepl("^(?:0|[1-9][0-9]*)$", value, perl = TRUE),
                "FAIL_PARSE", paste("noncanonical numeric literal", value))
      add("number", value,
          position, position + length)
      position <- position + length
      next
    }
    identifier <- regexpr("^[A-Za-z][A-Za-z0-9_]*", rest, perl = TRUE)
    if (identifier[[1L]] == 1L) {
      length <- attr(identifier, "match.length")
      value <- substr(source, position, position + length - 1L)
      kind <- if (value %in% c("and", "or", "not", "iff", "implies")) {
        "logical"
      } else {
        "identifier"
      }
      add(kind, value, position, position + length)
      position <- position + length
      next
    }
    two <- if (position < n) substr(source, position, position + 1L) else ""
    if (two %in% c("<=", ">=", "!=", "==")) {
      add("operator", two, position, position + 2L)
      position <- position + 2L
      next
    }
    one <- substr(source, position, position)
    if (one %in% c("+", "-", "*", "/", "^", "(", ")", "[", "]",
                   "{", "}", ",", ":", "<", ">", "=", "|")) {
      add("operator", one, position, position + 1L)
      position <- position + 1L
      next
    }
    sc_abort("FAIL_PARSE", paste0("unrecognized byte at offset ", position - 1L,
                                   " in `", text, "`"))
  }
  tokens[[length(tokens) + 1L]] <- list(
    kind = "eof", value = "<EOF>", byte_start = n, byte_end = n
  )
  tokens
}

sc_parser <- function(text, symbol_sorts = list()) {
  parser <- new.env(parent = emptyenv())
  parser$text <- text
  parser$tokens <- sc_tokenize(text)
  parser$position <- 1L
  parser$symbol_sorts <- symbol_sorts
  parser
}

sc_peek <- function(parser) parser$tokens[[parser$position]]

sc_take <- function(parser, value = NULL, kind = NULL) {
  token <- sc_peek(parser)
  if (!is.null(value) && !identical(token$value, value)) {
    sc_abort("FAIL_PARSE", paste("expected", value, "but found", token$value))
  }
  if (!is.null(kind) && !identical(token$kind, kind)) {
    sc_abort("FAIL_PARSE", paste("expected", kind, "but found", token$kind))
  }
  parser$position <- parser$position + 1L
  token
}

sc_ast <- function(kind, ..., sort) {
  list(kind = kind, sort = sort, ...)
}

sc_numeric_sorts <- function() {
  c("Integer", "Rational", "Real", "Probability", "Payoff", "PayoffShare")
}
sc_is_numeric_sort <- function(sort) is.character(sort) && length(sort) == 1L &&
  sort %in% sc_numeric_sorts()
sc_assert_numeric <- function(ast, context) {
  sc_assert(sc_is_numeric_sort(ast$sort), "FAIL_TYPE",
            paste(context, "requires a numeric operand, not", ast$sort))
  invisible(TRUE)
}

# Numeric ASTs retain a semantic dimension all the way to the root.  In
# particular, Probability and Payoff are not aliases for a generic Real.  A
# PayoffShare is a dimensionless expression that the fixed-unit-pie model has
# explicitly converted into payoff units (for example beta/m).  Keeping that
# conversion explicit permits normalized continuation shares without allowing
# a bare probability such as nu to be added to a payoff.
sc_numeric_dimension <- function(ast) {
  sc_assert(is.list(ast) && !is.null(ast$sort), "FAIL_TYPE",
            "numeric dimension requires a typed AST")
  sc_assert_numeric(ast, "numeric dimension")
  if (ast$sort %in% c("Integer", "Rational", "Real")) return("Scalar")
  ast$sort
}

sc_is_scalar_dimension <- function(dimension) identical(dimension, "Scalar")
sc_is_amount_dimension <- function(dimension) dimension %in% c("Payoff", "PayoffShare")

sc_is_integer_expression <- function(ast) {
  if (!is.list(ast) || is.null(ast$kind)) return(FALSE)
  if (identical(ast$kind, "number")) {
    return(identical(ast$sort, "Rational") && grepl("^[+-]?[0-9]+$", ast$value))
  }
  if (ast$kind %in% c("symbol", "bound_symbol")) {
    return(identical(ast$sort, "Integer"))
  }
  if (identical(ast$kind, "call")) return(identical(ast$sort, "Integer"))
  if (identical(ast$kind, "unary")) return(sc_is_integer_expression(ast$argument))
  if (identical(ast$kind, "binary") && ast$operator %in% c("+", "-", "*")) {
    return(sc_is_integer_expression(ast$left) && sc_is_integer_expression(ast$right))
  }
  FALSE
}

sc_dimension_sort <- function(dimension, left = NULL, right = NULL,
                              operator = NULL) {
  if (identical(dimension, "Scalar")) {
    if (!is.null(left) && !is.null(right) && operator %in% c("+", "-", "*") &&
        sc_is_integer_expression(left) && sc_is_integer_expression(right)) {
      return("Integer")
    }
    return("Real")
  }
  dimension
}

sc_is_integer_literal <- function(ast) {
  is.list(ast) && identical(ast$kind, "number") &&
    grepl("^[0-9]+$", ast$value)
}

# Cardinality denominators are syntactically typed rather than inferred from
# their spelling alone.  This is the only operation that turns a probability
# coefficient into a normalized payoff share.  Thus beta/m is payoff-eligible,
# while beta/nu remains a probability ratio.
sc_is_cardinality_expression <- function(ast) {
  if (!is.list(ast) || is.null(ast$kind)) return(FALSE)
  if (identical(ast$kind, "symbol")) return(identical(ast$sort, "Integer"))
  if (identical(ast$kind, "number")) return(sc_is_integer_literal(ast))
  if (identical(ast$kind, "call")) {
    return(identical(ast$name, "floor") && length(ast$arguments) == 1L)
  }
  if (identical(ast$kind, "unary")) {
    return(ast$operator %in% c("+", "-") &&
             sc_is_cardinality_expression(ast$argument))
  }
  if (identical(ast$kind, "binary") && ast$operator %in% c("+", "-", "*")) {
    return(sc_is_cardinality_expression(ast$left) &&
             sc_is_cardinality_expression(ast$right))
  }
  FALSE
}

# A frozen continuation share such as 1/m is a scalar until a probability
# coefficient discounts it.  At that multiplication boundary the fixed unit
# pie gives the expression payoff-share semantics.  This is deliberately
# syntactic and narrow: arbitrary scalar expressions multiplied by a
# probability remain probabilities.
sc_is_unit_share_expression <- function(ast) {
  is.list(ast) && identical(ast$kind, "binary") &&
    identical(ast$operator, "/") &&
    is.list(ast$left) && identical(ast$left$kind, "number") &&
    identical(ast$left$value, "1") &&
    sc_is_cardinality_expression(ast$right)
}

sc_additive_dimension <- function(operator, left_dimension, right_dimension) {
  sc_assert(operator %in% c("+", "-"), "FAIL_TYPE",
            "additive dimension received a non-additive operator")

  if ((identical(left_dimension, "Probability") &&
       sc_is_amount_dimension(right_dimension)) ||
      (identical(right_dimension, "Probability") &&
       sc_is_amount_dimension(left_dimension))) {
    sc_abort("FAIL_TYPE", paste("operator", operator,
                                 "cannot combine a payoff expression with a probability expression"))
  }

  if (identical(left_dimension, "Payoff") || identical(right_dimension, "Payoff")) {
    return("Payoff")
  }
  if (identical(left_dimension, "PayoffShare") ||
      identical(right_dimension, "PayoffShare")) {
    return("PayoffShare")
  }
  if (identical(left_dimension, "Probability") ||
      identical(right_dimension, "Probability")) {
    return("Probability")
  }
  "Scalar"
}

sc_multiplicative_dimension <- function(operator, left, right) {
  left_dimension <- sc_numeric_dimension(left)
  right_dimension <- sc_numeric_dimension(right)

  if (identical(operator, "*")) {
    sc_assert(!(sc_is_amount_dimension(left_dimension) &&
                  sc_is_amount_dimension(right_dimension)),
              "FAIL_TYPE", "multiplication of two payoff-dimension expressions is forbidden")
    if ((identical(left_dimension, "Probability") &&
         identical(right_dimension, "Scalar") && sc_is_unit_share_expression(right)) ||
        (identical(right_dimension, "Probability") &&
         identical(left_dimension, "Scalar") && sc_is_unit_share_expression(left))) {
      return("PayoffShare")
    }
    if (identical(left_dimension, "Payoff") || identical(right_dimension, "Payoff")) {
      return("Payoff")
    }
    if (identical(left_dimension, "PayoffShare") ||
        identical(right_dimension, "PayoffShare")) {
      return("PayoffShare")
    }
    if (identical(left_dimension, "Probability") ||
        identical(right_dimension, "Probability")) {
      return("Probability")
    }
    return("Scalar")
  }

  sc_assert(identical(operator, "/"), "FAIL_TYPE",
            "multiplicative dimension received an unsupported operator")
  sc_assert(!sc_is_amount_dimension(right_dimension), "FAIL_TYPE",
            "division by a payoff-dimension expression is forbidden")
  if (identical(left_dimension, "Payoff")) return("Payoff")
  if (identical(left_dimension, "PayoffShare")) return("PayoffShare")
  if (identical(left_dimension, "Probability") &&
      sc_is_cardinality_expression(right)) {
    return("PayoffShare")
  }
  if (identical(left_dimension, "Probability")) return("Probability")
  "Scalar"
}

sc_numeric_binary <- function(operator, left, right) {
  sc_assert_numeric(left, paste("operator", operator))
  sc_assert_numeric(right, paste("operator", operator))
  dimension <- if (operator %in% c("+", "-")) {
    sc_additive_dimension(operator, sc_numeric_dimension(left),
                          sc_numeric_dimension(right))
  } else if (operator %in% c("*", "/")) {
    sc_multiplicative_dimension(operator, left, right)
  } else {
    sc_abort("FAIL_TYPE", paste("unsupported numeric binary operator", operator))
  }
  sc_ast("binary", operator = operator, left = left, right = right,
         sort = sc_dimension_sort(dimension, left, right, operator))
}

sc_parse_primary <- function(parser) {
  token <- sc_peek(parser)
  if (identical(token$kind, "number")) {
    sc_take(parser)
    return(sc_ast("number", value = token$value, sort = "Rational"))
  }
  if (identical(token$kind, "identifier")) {
    sc_take(parser)
    name <- token$value
    if (identical(sc_peek(parser)$value, "(")) {
      sc_take(parser, "(")
      sc_assert(name %in% c("floor", "Pr"), "FAIL_TYPE",
                paste("unauthorized function", name))
      sc_assert(!identical(sc_peek(parser)$value, ")"), "FAIL_TYPE",
                paste(name, "requires exactly one argument"))
      argument <- if (name == "Pr") sc_parse_logic(parser) else sc_parse_arithmetic(parser)
      sc_assert(!identical(sc_peek(parser)$value, ","), "FAIL_TYPE",
                paste(name, "accepts exactly one argument"))
      sc_take(parser, ")")
      if (name == "Pr") {
        sc_assert(identical(argument$sort, "Proposition"), "FAIL_TYPE",
                  "Pr requires an event proposition")
      } else {
        sc_assert(argument$sort %in% c("Integer", "Rational", "Real"), "FAIL_TYPE",
                  "floor requires a dimensionless numeric argument")
      }
      return(sc_ast("call", name = name, arguments = list(argument),
                    sort = if (name == "floor") "Integer" else "Probability"))
    }
    sc_assert(name %in% names(parser$symbol_sorts), "FAIL_TYPE",
              paste("unknown symbol", name))
    return(sc_ast("symbol", name = name, sort = parser$symbol_sorts[[name]]))
  }
  if (token$value %in% c("(", "[")) {
    open <- sc_take(parser)$value
    node <- if (open == "(") sc_parse_logic(parser) else sc_parse_arithmetic(parser)
    sc_take(parser, if (open == "(") ")" else "]")
    return(node)
  }
  sc_abort("FAIL_PARSE", paste("expected primary but found", token$value))
}

sc_parse_unary <- function(parser) {
  if (sc_peek(parser)$value %in% c("+", "-")) {
    operator <- sc_take(parser)$value
    argument <- sc_parse_unary(parser)
    sc_assert_numeric(argument, paste("unary", operator))
    sc_assert(!(identical(operator, "+") && identical(argument$kind, "number")),
              "FAIL_PARSE", paste0("noncanonical unary plus numeral +", argument$value))
    sc_assert(!(identical(operator, "-") && identical(argument$kind, "number") &&
                  identical(argument$value, "0")),
              "FAIL_PARSE", "noncanonical negative zero numeral -0")
    return(sc_ast("unary", operator = operator, argument = argument,
                  sort = argument$sort))
  }
  sc_parse_primary(parser)
}

sc_parse_power <- function(parser) {
  left <- sc_parse_unary(parser)
  if (identical(sc_peek(parser)$value, "^")) {
    sc_take(parser, "^")
    right <- sc_parse_power(parser)
    sc_assert_numeric(left, "power")
    sc_assert_numeric(right, "power")
    sc_assert(sc_is_scalar_dimension(sc_numeric_dimension(right)), "FAIL_TYPE",
              "power exponent must be dimensionless")
    left_dimension <- sc_numeric_dimension(left)
    if (sc_is_amount_dimension(left_dimension)) {
      sc_assert(sc_is_integer_literal(right) && right$value %in% c("0", "1"),
                "FAIL_TYPE", "payoff-dimension powers are limited to literal 0 or 1")
      result_dimension <- if (identical(right$value, "0")) "Scalar" else left_dimension
    } else {
      result_dimension <- left_dimension
    }
    result_sort <- if (identical(result_dimension, "Scalar") &&
                       sc_is_integer_expression(left)) "Integer" else
      sc_dimension_sort(result_dimension)
    return(sc_ast("binary", operator = "^", left = left, right = right,
                  sort = result_sort))
  }
  left
}

sc_parse_product <- function(parser) {
  node <- sc_parse_power(parser)
  while (sc_peek(parser)$value %in% c("*", "/")) {
    operator <- sc_take(parser)$value
    node <- sc_numeric_binary(operator, node, sc_parse_power(parser))
  }
  node
}

sc_parse_arithmetic <- function(parser) {
  node <- sc_parse_product(parser)
  while (sc_peek(parser)$value %in% c("+", "-")) {
    operator <- sc_take(parser)$value
    node <- sc_numeric_binary(operator, node, sc_parse_product(parser))
  }
  node
}

sc_parse_relation <- function(parser) {
  expressions <- list(sc_parse_arithmetic(parser))
  relations <- character(0)
  while (sc_peek(parser)$value %in% c("<", "<=", "=", "==", ">=", ">", "!=")) {
    relations <- c(relations, sc_take(parser)$value)
    expressions[[length(expressions) + 1L]] <- sc_parse_arithmetic(parser)
  }
  if (length(relations) == 0L) return(expressions[[1L]])
  comparisons <- lapply(seq_along(relations), function(index) {
    left <- expressions[[index]]; right <- expressions[[index + 1L]]
    operator <- if (relations[[index]] == "==") "=" else relations[[index]]
    if (operator %in% c("<", "<=", ">=", ">")) {
      sc_assert_numeric(left, paste("comparison", operator))
      sc_assert_numeric(right, paste("comparison", operator))
      left_dimension <- sc_numeric_dimension(left)
      right_dimension <- sc_numeric_dimension(right)
      incompatible <- (identical(left_dimension, "Probability") &&
                         sc_is_amount_dimension(right_dimension)) ||
        (identical(right_dimension, "Probability") &&
           sc_is_amount_dimension(left_dimension))
      sc_assert(!incompatible, "FAIL_TYPE",
                paste("incompatible comparison dimensions", left_dimension,
                      "and", right_dimension))
    } else {
      numeric_compatible <- FALSE
      if (sc_is_numeric_sort(left$sort) && sc_is_numeric_sort(right$sort)) {
        left_dimension <- sc_numeric_dimension(left)
        right_dimension <- sc_numeric_dimension(right)
        numeric_compatible <- !(
          (identical(left_dimension, "Probability") &&
             sc_is_amount_dimension(right_dimension)) ||
          (identical(right_dimension, "Probability") &&
             sc_is_amount_dimension(left_dimension))
        )
      }
      compatible <- numeric_compatible || identical(left$sort, right$sort) ||
        (left$sort == "Type" && right$kind == "number" && right$value %in% c("0", "1")) ||
        (right$sort == "Type" && left$kind == "number" && left$value %in% c("0", "1"))
      sc_assert(compatible, "FAIL_TYPE", paste("incompatible equality sorts", left$sort,
                                                "and", right$sort))
    }
    sc_ast("compare", operator = operator, left = left, right = right,
           sort = "Proposition")
  })
  if (length(comparisons) == 1L) return(comparisons[[1L]])
  sc_ast("logical", operator = "and", arguments = comparisons, sort = "Proposition")
}

sc_parse_not <- function(parser) {
  if (identical(sc_peek(parser)$value, "not")) {
    sc_take(parser, "not")
    argument <- sc_parse_not(parser)
    sc_assert(identical(argument$sort, "Proposition"), "FAIL_TYPE",
              "not requires a proposition")
    return(sc_ast("logical", operator = "not", arguments = list(argument), sort = "Proposition"))
  }
  sc_parse_relation(parser)
}

sc_parse_logic <- function(parser) {
  node <- sc_parse_not(parser)
  while (sc_peek(parser)$value %in% c("and", "or", "iff", "implies")) {
    operator <- sc_take(parser)$value
    right <- sc_parse_not(parser)
    sc_assert(identical(node$sort, "Proposition") && identical(right$sort, "Proposition"),
              "FAIL_TYPE", paste(operator, "requires proposition operands"))
    node <- sc_ast("logical", operator = operator, arguments = list(node, right),
                   sort = "Proposition")
  }
  node
}

sc_parse_complete <- function(text, symbol_sorts, expected_sort = NULL) {
  parser <- sc_parser(text, symbol_sorts)
  ast <- sc_parse_logic(parser)
  sc_assert(identical(sc_peek(parser)$kind, "eof"), "FAIL_PARSE",
            paste("trailing input after byte", sc_peek(parser)$byte_start))
  if (!is.null(expected_sort)) {
    actual <- ast$sort
    actual_dimension <- if (sc_is_numeric_sort(actual)) sc_numeric_dimension(ast) else actual
    compatible <- identical(actual, expected_sort) ||
      (identical(expected_sort, "Scalar") &&
         identical(actual_dimension, "Scalar")) ||
      (identical(expected_sort, "Payoff") &&
         actual_dimension %in% c("Scalar", "Payoff", "PayoffShare")) ||
      (identical(expected_sort, "Probability") &&
         actual_dimension %in% c("Scalar", "Probability")) ||
      (identical(expected_sort, "Real") && identical(actual_dimension, "Scalar"))
    sc_assert(compatible, "FAIL_TYPE",
              paste("expected sort", expected_sort, "but got", actual,
                    "with semantic dimension", actual_dimension))
  }
  ast
}

sc_ast_canonical <- function(ast) {
  if (ast$kind %in% c("number", "symbol")) {
    return(paste0(ast$kind, "(", if (!is.null(ast$name)) ast$name else ast$value, ")"))
  }
  if (ast$kind == "call") {
    return(paste0("call(", ast$name, ":",
                  paste(vapply(ast$arguments, sc_ast_canonical, character(1)), collapse = ","), ")"))
  }
  if (ast$kind == "unary") {
    return(paste0("unary(", ast$operator, ",", sc_ast_canonical(ast$argument), ")"))
  }
  if (ast$kind == "binary") {
    return(paste0("binary(", ast$operator, ",", sc_ast_canonical(ast$left), ",",
                  sc_ast_canonical(ast$right), ")"))
  }
  if (ast$kind == "compare") {
    return(paste0("compare(", ast$operator, ",", sc_ast_canonical(ast$left), ",",
                  sc_ast_canonical(ast$right), ")"))
  }
  if (ast$kind == "logical") {
    return(paste0("logical(", ast$operator, ":",
                  paste(vapply(ast$arguments, sc_ast_canonical, character(1)), collapse = ","), ")"))
  }
  sc_abort("FAIL_TYPE", paste("unknown AST kind", ast$kind))
}

sc_balanced_close <- function(text, open_position, open = "{", close = "}") {
  sc_assert(substr(text, open_position, open_position) == open,
            "FAIL_PARSE", "balanced scan did not start at opening delimiter")
  depth <- 0L
  n <- nchar(text, type = "chars")
  for (position in seq.int(open_position, n)) {
    character <- substr(text, position, position)
    if (character == open) depth <- depth + 1L
    if (character == close) depth <- depth - 1L
    if (depth == 0L) return(position)
  }
  sc_abort("FAIL_PARSE", paste("unclosed", open, "delimiter"))
}

sc_set_W <- function() list(kind = "set_symbol", sort = "Set<Player>", name = "W")
sc_bound <- function(name, sort) list(kind = "bound_symbol", sort = sort, name = name)
sc_W_without <- function(player) list(
  kind = "set_difference", sort = "Set<Player>", left = sc_set_W(),
  right = list(kind = "singleton", sort = "Set<Player>",
               element = sc_bound(player, "Player"))
)
sc_q_minus <- function(offset) sc_ast(
  "binary", operator = "-", left = sc_ast("symbol", name = "q", sort = "Integer"),
  right = sc_ast("number", value = as.character(offset), sort = "Rational"), sort = "Integer"
)

sc_parse_sum_binder <- function(text, alpha_index, bound_environment = list()) {
  compact <- gsub("[[:space:]]+", " ", trimws(text))
  simple <- regexec("^([iKTC]) in W$", compact, perl = TRUE)
  groups <- regmatches(compact, simple)[[1L]]
  if (length(groups)) {
    return(list(kind = "binder", variable = paste0("b", alpha_index),
                variable_sort = "Player", source_variable = groups[[2L]],
                domain = sc_set_W(), constraints = list()))
  }
  excluded <- regexec("^([iKTC]) in W, \\1!=l$", compact, perl = TRUE)
  groups <- regmatches(compact, excluded)[[1L]]
  if (length(groups)) {
    return(list(kind = "binder", variable = paste0("b", alpha_index),
                variable_sort = "Player", source_variable = groups[[2L]],
                domain = sc_set_W(), constraints = list(list(
                  kind = "not_equal_constraint", sort = "Proposition",
                  left = sc_bound(paste0("b", alpha_index), "Player"),
                  right = sc_ast("symbol", name = "l", sort = "Player")))))
  }
  # The source JSON contains a literal backslash in W\{i}.  Exact template
  # matching is less error-prone than a permissive regular expression and
  # fails closed on every unrecognized binder byte.
  for (variable in c("K", "T")) for (offset in c("1", "2")) {
    base <- paste0(variable, " subset W\\{i}, |", variable, "|=q-", offset)
    membership <- paste0(base, ", l in ", variable)
    if (identical(compact, base) || identical(compact, membership)) {
      excluded_player <- if (!is.null(bound_environment$i)) bound_environment$i else "i"
      constraints <- list(list(kind = "cardinality", value = paste0("q-", offset)))
      if (identical(compact, membership)) {
        constraints[[length(constraints) + 1L]] <- list(
          kind = "membership_constraint", sort = "Proposition",
          element = sc_ast("symbol", name = "l", sort = "Player"),
          container = sc_bound(paste0("b", alpha_index), "FiniteSet<Player>"))
      }
      constraints[[1L]] <- list(
        kind = "cardinality_constraint", sort = "Proposition",
        set = sc_bound(paste0("b", alpha_index), "FiniteSet<Player>"),
        equals = sc_q_minus(as.integer(offset)))
      return(list(kind = "binder", variable = paste0("b", alpha_index),
                  variable_sort = "FiniteSet<Player>", source_variable = variable,
                  domain = sc_W_without(excluded_player),
                  constraints = constraints))
    }
  }
  sc_abort("FAIL_PARSE", paste("unsupported indexed-sum binder:", text))
}

sc_replace_indexed_atoms <- function(text, bound_environment = list()) {
  definitions <- list()
  counter <- 0L
  repeat {
    match <- regexpr("(?:omega|e|p)_\\{[iKTC],[iKTC]\\}", text, perl = TRUE)
    if (match[[1L]] == -1L) break
    length <- attr(match, "match.length")
    value <- substr(text, match[[1L]], match[[1L]] + length - 1L)
    counter <- counter + 1L
    placeholder <- paste0("IDX", counter)
    inside <- sub("^[a-z]+_\\{", "", value)
    inside <- sub("\\}$", "", inside)
    parts <- strsplit(inside, ",", fixed = TRUE)[[1L]]
    family <- sub("_.*$", "", value)
    parts <- vapply(parts, function(index) {
      if (!is.null(bound_environment[[index]])) bound_environment[[index]] else index
    }, character(1))
    definitions[[placeholder]] <- list(kind = "indexed_symbol", sort = "Probability",
                                       family = family, indices = as.list(parts))
    before <- if (match[[1L]] > 1L) substr(text, 1L, match[[1L]] - 1L) else ""
    after_position <- match[[1L]] + length
    after <- if (after_position <= nchar(text)) substr(text, after_position, nchar(text)) else ""
    text <- paste0(before, placeholder, after)
  }
  list(text = text, definitions = definitions)
}

sc_parse_indexed_arithmetic <- function(text, symbol_sorts, depth = 0L,
                                        bound_environment = list(),
                                        contextual_binders = list()) {
  sc_assert(all(as.integer(charToRaw(enc2utf8(text))) < 128L), "FAIL_PARSE",
            "indexed mathematical spans must be ASCII")
  definitions <- list()
  contextual_counter <- 0L
  repeat {
    match <- regexpr("sum_([KTj])[[:space:]]+(?:(omega|e|p)_\\{i,([KT])\\}|x_j)",
                     text, perl = TRUE)
    if (match[[1L]] == -1L) break
    length <- attr(match, "match.length")
    source <- substr(text, match[[1L]], match[[1L]] + length - 1L)
    groups <- regmatches(source, regexec(
      "^sum_([KTj])[[:space:]]+(?:(omega|e|p)_\\{i,([KT])\\}|x_j)$",
      source, perl = TRUE))[[1L]]
    variable <- groups[[2L]]
    sc_assert(variable %in% names(contextual_binders), "FAIL_PARSE",
              paste("context-free indexed sum is forbidden for", variable))
    binder_spec <- contextual_binders[[variable]]
    sc_assert(is.list(binder_spec$domain) && !is.null(binder_spec$domain$kind) &&
                is.list(binder_spec$constraints) &&
                is.character(binder_spec$variable_sort),
              "FAIL_TYPE", paste("contextual binder", variable, "is not typed"))
    alpha_variable <- paste0("b", depth + contextual_counter + 1L)
    binder <- list(kind = "binder", variable = alpha_variable,
                   variable_sort = binder_spec$variable_sort,
                   source_variable = variable, domain = binder_spec$domain,
                   constraints = binder_spec$constraints)
    if (identical(variable, "j")) {
      body <- list(kind = "indexed_symbol", sort = "Payoff", family = "x",
                   indices = as.list(alpha_variable))
    } else {
      family <- groups[[3L]]
      indexed_variable <- groups[[4L]]
      sc_assert(identical(variable, indexed_variable), "FAIL_PARSE",
                "contextual sum binder/index mismatch")
      outer_i <- if (!is.null(bound_environment$i)) bound_environment$i else "i"
      body <- list(kind = "indexed_symbol", sort = "Probability",
                   family = family, indices = as.list(c(outer_i, alpha_variable)))
    }
    contextual_counter <- contextual_counter + 1L
    placeholder <- paste0("CTX", contextual_counter)
    definitions[[placeholder]] <- list(kind = "indexed_sum", sort = body$sort,
                                       binder = binder, body = body)
    before <- if (match[[1L]] > 1L) substr(text, 1L, match[[1L]] - 1L) else ""
    after_position <- match[[1L]] + length
    after <- if (after_position <= nchar(text)) substr(text, after_position, nchar(text)) else ""
    text <- paste0(before, placeholder, after)
  }
  sum_counter <- 0L
  repeat {
    location <- regexpr("sum_\\{", text, perl = TRUE)[[1L]]
    if (location == -1L) break
    open <- location + 4L
    close <- sc_balanced_close(text, open)
    binder_text <- substr(text, open + 1L, close - 1L)
    body_start <- close + 1L
    sc_assert(body_start <= nchar(text), "FAIL_PARSE", "sum has no summand")
    if (substr(text, body_start, body_start) == "{") {
      body_close <- sc_balanced_close(text, body_start)
      body_text <- substr(text, body_start + 1L, body_close - 1L)
      end <- body_close
    } else if (startsWith(substr(text, body_start, nchar(text)), "sum_{")) {
      # The only unbraced composite summand authorized by the N3 grammar is a
      # nested indexed sum that consumes the remainder of the prescribed math
      # span (used by the two mixed outcome formulas).
      body_text <- substr(text, body_start, nchar(text))
      end <- nchar(text)
    } else {
      atom_match <- regexpr("^(?:omega|e|p)_\\{[iKTC],[iKTC]\\}",
                            substr(text, body_start, nchar(text)), perl = TRUE)
      sc_assert(atom_match[[1L]] == 1L, "FAIL_PARSE",
                paste("unsupported summand after", binder_text))
      atom_length <- attr(atom_match, "match.length")
      body_text <- substr(text, body_start, body_start + atom_length - 1L)
      end <- body_start + atom_length - 1L
    }
    sum_counter <- sum_counter + 1L
    placeholder <- paste0("SUM", sum_counter)
    binder <- sc_parse_sum_binder(binder_text, depth + 1L, bound_environment)
    child_environment <- bound_environment
    child_environment[[binder$source_variable]] <- binder$variable
    body <- sc_parse_indexed_arithmetic(body_text, symbol_sorts, depth + 1L,
                                        child_environment, contextual_binders)
    definitions[[placeholder]] <- list(kind = "indexed_sum", sort = body$sort,
                                       binder = binder, body = body)
    before <- if (location > 1L) substr(text, 1L, location - 1L) else ""
    after <- if (end < nchar(text)) substr(text, end + 1L, nchar(text)) else ""
    text <- paste0(before, placeholder, after)
  }
  indexed <- sc_replace_indexed_atoms(text, bound_environment)
  definitions <- c(definitions, indexed$definitions)
  definition_sorts <- vapply(definitions, `[[`, character(1), "sort")
  local_sorts <- c(symbol_sorts, as.list(setNames(definition_sorts, names(definitions))))
  ast <- sc_parse_complete(indexed$text, local_sorts)
  substitute <- function(node) {
    if (is.list(node) && identical(node$kind, "symbol") && node$name %in% names(definitions)) {
      return(definitions[[node$name]])
    }
    if (!is.list(node)) return(node)
    for (name in names(node)) {
      if (name %in% c("kind", "sort", "name", "value", "operator")) next
      if (is.list(node[[name]])) {
        if (!is.null(names(node[[name]])) || (!is.null(node[[name]]$kind))) {
          node[[name]] <- substitute(node[[name]])
        } else {
          node[[name]] <- lapply(node[[name]], substitute)
        }
      }
    }
    node
  }
  substitute(ast)
}

sc_indexed_canonical <- function(ast) {
  if (identical(ast$kind, "set_symbol")) return(paste0("set(", ast$name, ")"))
  if (identical(ast$kind, "bound_symbol")) return(paste0("bound(", ast$name, ")"))
  if (identical(ast$kind, "singleton")) {
    return(paste0("singleton(", sc_indexed_canonical(ast$element), ")"))
  }
  if (identical(ast$kind, "set_difference")) {
    return(paste0("set_difference(", sc_indexed_canonical(ast$left), ",",
                  sc_indexed_canonical(ast$right), ")"))
  }
  if (identical(ast$kind, "cardinality_constraint")) {
    return(paste0("cardinality(", sc_indexed_canonical(ast$set), ")=",
                  sc_indexed_canonical(ast$equals)))
  }
  if (identical(ast$kind, "membership_constraint")) {
    return(paste0("member(", sc_indexed_canonical(ast$element), ",",
                  sc_indexed_canonical(ast$container), ")"))
  }
  if (identical(ast$kind, "not_equal_constraint")) {
    return(paste0("neq(", sc_indexed_canonical(ast$left), ",",
                  sc_indexed_canonical(ast$right), ")"))
  }
  if (identical(ast$kind, "indexed_symbol")) {
    return(paste0("idx(", ast$family, ":", paste(unlist(ast$indices), collapse = ","), ")"))
  }
  if (identical(ast$kind, "indexed_sum")) {
    constraints <- paste(vapply(ast$binder$constraints, sc_indexed_canonical,
                                character(1)), collapse = ",")
    return(paste0("sum(", ast$binder$variable, ":", ast$binder$variable_sort,
                  " in ", sc_indexed_canonical(ast$binder$domain), "[",
                  constraints, "]:", sc_indexed_canonical(ast$body), ")"))
  }
  if (identical(ast$kind, "quantifier")) {
    constraints <- paste(vapply(ast$binder$constraints, sc_indexed_canonical,
                                character(1)), collapse = ",")
    return(paste0(ast$quantifier, "(", ast$binder$variable, ":",
                  ast$binder$variable_sort, " in ",
                  sc_indexed_canonical(ast$binder$domain), "[", constraints,
                  "]:", sc_indexed_canonical(ast$body), ")"))
  }
  if (ast$kind %in% c("number", "symbol", "call", "unary", "binary", "compare", "logical")) {
    replace_children <- function(node) {
      if (identical(node$kind, "indexed_symbol") || identical(node$kind, "indexed_sum")) {
        return(sc_indexed_canonical(node))
      }
      if (!is.list(node)) return(node)
      rendered <- lapply(names(node), function(name) {
        value <- node[[name]]
        if (is.list(value) && !is.null(value$kind)) sc_indexed_canonical(value) else value
      })
      names(rendered) <- names(node)
      rendered
    }
    # A dedicated renderer is used so indexed subtrees remain typed atoms.
    if (ast$kind == "number") return(paste0("number(", ast$value, ")"))
    if (ast$kind == "symbol") return(paste0("symbol(", ast$name, ")"))
    if (ast$kind == "unary") return(paste0("unary(", ast$operator, ",",
                                            sc_indexed_canonical(ast$argument), ")"))
    if (ast$kind == "binary") return(paste0("binary(", ast$operator, ",",
                                             sc_indexed_canonical(ast$left), ",",
                                             sc_indexed_canonical(ast$right), ")"))
    if (ast$kind == "compare") return(paste0("compare(", ast$operator, ",",
                                              sc_indexed_canonical(ast$left), ",",
                                              sc_indexed_canonical(ast$right), ")"))
    if (ast$kind == "logical") return(paste0("logical(", ast$operator, ":",
                                              paste(vapply(ast$arguments, sc_indexed_canonical,
                                                           character(1)), collapse = ","), ")"))
    if (ast$kind == "call") return(paste0("call(", ast$name, ":",
                                           paste(vapply(ast$arguments, sc_indexed_canonical,
                                                        character(1)), collapse = ","), ")"))
  }
  sc_abort("FAIL_TYPE", paste("unknown indexed AST kind", ast$kind))
}

sc_typed_ast_canonical <- function(ast) {
  sc_assert(is.list(ast) && !is.null(ast$kind) && !is.null(ast$sort),
            "FAIL_TYPE", "typed AST canonicalization requires a typed AST")
  as.character(jsonlite::toJSON(ast, auto_unbox = TRUE, null = "null",
                                digits = NA, pretty = FALSE))
}

sc_assert_sha256 <- function(value, label) {
  sc_assert(is.character(value) && length(value) == 1L && !is.na(value) &&
              grepl("^[0-9a-f]{64}$", value),
            "FAIL_BINDING", paste(label, "is not a lowercase SHA-256"))
  invisible(TRUE)
}

sc_assert_symbol_sorts <- function(symbol_sorts) {
  sc_assert(is.list(symbol_sorts), "FAIL_TYPE",
            "span symbol_sorts must be a list")
  if (length(symbol_sorts) == 0L) return(invisible(TRUE))
  sc_assert(!is.null(names(symbol_sorts)) &&
              !anyNA(names(symbol_sorts)) && !anyDuplicated(names(symbol_sorts)) &&
              all(nzchar(names(symbol_sorts))),
            "FAIL_TYPE", "span symbol_sorts must be a uniquely named list")
  valid_sorts <- c(sc_numeric_sorts(), "Type", "Player", "Proposition",
                   "Set<Player>", "FiniteSet<Player>")
  sc_assert(all(vapply(symbol_sorts, function(sort) {
    is.character(sort) && length(sort) == 1L && !is.na(sort) && sort %in% valid_sorts
  }, logical(1))), "FAIL_TYPE", "span symbol_sorts contains an unsupported sort")
  invisible(TRUE)
}

sc_parse_bound_span <- function(slice_text, span) {
  required <- c("parser_kind", "symbol_sorts", "expected_sort",
                "ast_canonical", "normal_form_kind", "normal_form")
  sc_assert(all(required %in% names(span)), "FAIL_BINDING",
            paste("formal span is missing", paste(setdiff(required, names(span)), collapse = ",")))
  sc_assert(is.character(span$parser_kind) && length(span$parser_kind) == 1L &&
              span$parser_kind %in% c("scalar", "indexed"),
            "FAIL_TYPE", "formal span parser_kind must be scalar or indexed")
  sc_assert_symbol_sorts(span$symbol_sorts)
  sc_assert(is.null(span$expected_sort) ||
              (is.character(span$expected_sort) && length(span$expected_sort) == 1L &&
                 !is.na(span$expected_sort)),
            "FAIL_TYPE", "formal span expected_sort must be null or one sort")

  if (identical(span$parser_kind, "scalar")) {
    ast <- sc_parse_complete(slice_text, span$symbol_sorts, span$expected_sort)
    structural_normal_form <- sc_ast_canonical(ast)
  } else {
    contextual_binders <- if ("contextual_binders" %in% names(span)) {
      span$contextual_binders
    } else {
      list()
    }
    sc_assert(is.list(contextual_binders), "FAIL_TYPE",
              "indexed span contextual_binders must be a list")
    ast <- sc_parse_indexed_arithmetic(slice_text, span$symbol_sorts,
                                       contextual_binders = contextual_binders)
    if (!is.null(span$expected_sort)) {
      actual_dimension <- if (sc_is_numeric_sort(ast$sort)) sc_numeric_dimension(ast) else ast$sort
      compatible <- identical(ast$sort, span$expected_sort) ||
        (identical(span$expected_sort, "Scalar") &&
           identical(actual_dimension, "Scalar")) ||
        (identical(span$expected_sort, "Payoff") &&
           actual_dimension %in% c("Scalar", "Payoff", "PayoffShare")) ||
        (identical(span$expected_sort, "Probability") &&
           actual_dimension %in% c("Scalar", "Probability"))
      sc_assert(compatible, "FAIL_TYPE",
                paste("indexed span expected", span$expected_sort, "but got", ast$sort))
    }
    structural_normal_form <- sc_indexed_canonical(ast)
  }

  supplied_ast <- span$ast_canonical
  sc_assert(is.character(supplied_ast) && length(supplied_ast) == 1L &&
              !is.na(supplied_ast), "FAIL_BINDING",
            "formal span ast_canonical must be one string")
  computed_ast <- sc_typed_ast_canonical(ast)
  sc_assert(identical(supplied_ast, computed_ast), "FAIL_EQUIVALENCE",
            "formal span supplied AST does not match the parsed raw byte slice")

  sc_assert(is.character(span$normal_form_kind) &&
              length(span$normal_form_kind) == 1L &&
              span$normal_form_kind %in% c("typed_ast", "exact_rational"),
            "FAIL_TYPE", "unsupported formal span normal_form_kind")
  sc_assert(is.character(span$normal_form) && length(span$normal_form) == 1L &&
              !is.na(span$normal_form), "FAIL_BINDING",
            "formal span normal_form must be one string")
  if (identical(span$normal_form_kind, "exact_rational")) {
    sc_assert(identical(span$parser_kind, "scalar"), "FAIL_TYPE",
              "exact rational normal form is unavailable for indexed spans")
    sc_assert(exists("ea_ast_to_rat", mode = "function", inherits = TRUE) &&
                exists("ea_rat_canonical", mode = "function", inherits = TRUE),
              "FAIL_CERTIFICATE",
              "exact algebra must be loaded before validating an exact-rational span")
    computed_normal_form <- ea_rat_canonical(ea_ast_to_rat(ast))
  } else {
    computed_normal_form <- structural_normal_form
  }
  sc_assert(identical(span$normal_form, computed_normal_form), "FAIL_EQUIVALENCE",
            "formal span supplied normal form does not match the parsed raw byte slice")

  list(ast = ast, ast_canonical = computed_ast,
       normal_form_kind = span$normal_form_kind,
       normal_form = computed_normal_form)
}

sc_raw_interval <- function(raw, byte_start, byte_end) {
  sc_assert(is.integer(byte_start) && length(byte_start) == 1L && !is.na(byte_start) &&
              is.integer(byte_end) && length(byte_end) == 1L && !is.na(byte_end),
            "FAIL_COVERAGE", "byte offsets must be scalar integers")
  sc_assert(byte_end > byte_start, "FAIL_COVERAGE", "zero-length byte segment is forbidden")
  raw[(byte_start + 1L):byte_end]
}

sc_byte_complete_segments <- function(text, math_spans = list(), document_sha256 = NULL) {
  sc_assert(is.character(text) && length(text) == 1L && !is.na(text),
            "FAIL_TYPE", "segmented source must be one string")
  raw <- charToRaw(enc2utf8(text))
  total <- length(raw)
  sc_assert(total > 0L, "FAIL_COVERAGE", "empty source cannot yield positive-length segments")
  computed_document_sha256 <- sc_sha256_raw(raw)
  if (!is.null(document_sha256)) {
    sc_assert_sha256(document_sha256, "supplied document_sha256")
    sc_assert(identical(document_sha256, computed_document_sha256), "FAIL_BINDING",
              "supplied document_sha256 does not match decoded UTF-8 bytes")
  }
  sc_assert(is.list(math_spans), "FAIL_TYPE", "math_spans must be a list")

  if (length(math_spans) == 0L) {
    return(list(list(kind = "human_prose", byte_start = 0L, byte_end = total,
                     source_sha256 = computed_document_sha256,
                     document_sha256 = computed_document_sha256)))
  }

  starts <- vapply(math_spans, function(span) {
    sc_assert(is.list(span) && "byte_start" %in% names(span), "FAIL_COVERAGE",
              "formal span lacks byte_start")
    sc_assert(is.integer(span$byte_start) && length(span$byte_start) == 1L &&
                !is.na(span$byte_start), "FAIL_COVERAGE",
              "formal span byte_start must be one integer")
    span$byte_start
  }, integer(1))
  sc_assert(identical(starts, sort(starts)), "FAIL_COVERAGE",
            "formal spans must be supplied in strictly increasing byte order")
  sc_assert(!anyDuplicated(starts), "FAIL_COVERAGE",
            "formal spans have duplicate byte starts")

  cursor <- 0L
  output <- list()
  for (span in math_spans) {
    required_binding <- c("kind", "byte_start", "byte_end", "source_sha256",
                          "document_sha256")
    sc_assert(all(required_binding %in% names(span)), "FAIL_BINDING",
              paste("formal span is missing",
                    paste(setdiff(required_binding, names(span)), collapse = ",")))
    sc_assert(identical(span$kind, "formal_math"), "FAIL_TYPE",
              "math_spans may contain only formal_math records")
    sc_assert(is.integer(span$byte_end) && length(span$byte_end) == 1L &&
                !is.na(span$byte_end), "FAIL_COVERAGE",
              "formal span byte_end must be one integer")
    sc_assert(span$byte_start >= cursor && span$byte_end > span$byte_start &&
                span$byte_end <= total, "FAIL_COVERAGE",
              "overlapping, zero-length, or out-of-range formal byte span")
    sc_assert_sha256(span$source_sha256, "formal span source_sha256")
    sc_assert_sha256(span$document_sha256, "formal span document_sha256")
    sc_assert(identical(span$document_sha256, computed_document_sha256), "FAIL_BINDING",
              "formal span is not bound to the supplied source document")

    if (span$byte_start > cursor) {
      prose_raw <- sc_raw_interval(raw, cursor, span$byte_start)
      output[[length(output) + 1L]] <- list(
        kind = "human_prose", byte_start = cursor, byte_end = span$byte_start,
        source_sha256 = sc_sha256_raw(prose_raw),
        document_sha256 = computed_document_sha256
      )
    }

    formal_raw <- sc_raw_interval(raw, span$byte_start, span$byte_end)
    computed_span_sha256 <- sc_sha256_raw(formal_raw)
    sc_assert(identical(span$source_sha256, computed_span_sha256), "FAIL_BINDING",
              "formal span source_sha256 does not match its raw byte slice")
    formal_text <- rawToChar(formal_raw)
    sc_assert(!is.na(iconv(formal_text, from = "UTF-8", to = "UTF-8",
                           sub = NA_character_)),
              "FAIL_PARSE", "formal span is not valid UTF-8")
    checked <- sc_parse_bound_span(formal_text, span)
    output[[length(output) + 1L]] <- list(
      kind = "formal_math", byte_start = span$byte_start, byte_end = span$byte_end,
      source_sha256 = computed_span_sha256,
      document_sha256 = computed_document_sha256,
      parser_kind = span$parser_kind, expected_sort = span$expected_sort,
      ast_canonical = checked$ast_canonical,
      normal_form_kind = checked$normal_form_kind,
      normal_form = checked$normal_form
    )
    cursor <- span$byte_end
  }

  if (cursor < total) {
    prose_raw <- sc_raw_interval(raw, cursor, total)
    output[[length(output) + 1L]] <- list(
      kind = "human_prose", byte_start = cursor, byte_end = total,
      source_sha256 = sc_sha256_raw(prose_raw),
      document_sha256 = computed_document_sha256
    )
  }

  starts_out <- vapply(output, `[[`, integer(1), "byte_start")
  ends_out <- vapply(output, `[[`, integer(1), "byte_end")
  sc_assert(all(ends_out > starts_out), "FAIL_COVERAGE",
            "every emitted segment must have positive byte length")
  sc_assert(starts_out[[1L]] == 0L && ends_out[[length(ends_out)]] == total,
            "FAIL_COVERAGE", "segments do not cover both document boundaries")
  if (length(output) > 1L) {
    sc_assert(identical(ends_out[-length(ends_out)], starts_out[-1L]),
              "FAIL_COVERAGE", "segments contain a byte gap or overlap")
  }
  sc_assert(sum(ends_out - starts_out) == total, "FAIL_COVERAGE",
            "segments do not partition decoded UTF-8 bytes exactly once")
  output
}
