if (!requireNamespace("gmp", quietly = TRUE)) {
  stop("Package 'gmp' is required for exact semantic certification.", call. = FALSE)
}

ea_assert_bigq_scalar <- function(value, label = "coefficient") {
  # Do not dispatch a gmp method until both raw bigz buffers have been checked.
  # A caller can attach class "bigq" to arbitrary raw bytes, and gmp's printer
  # is not memory-safe on such a forged buffer.  The scalar serialization is
  # [vector length, limb count, sign, little-endian 32-bit limbs].
  raw_word <- function(bytes, offset) {
    sum(as.numeric(bytes[offset + 0:3L]) * c(1, 256, 65536, 16777216))
  }
  valid_bigz_raw <- function(bytes, require_positive = FALSE) {
    if (!is.raw(bytes) || length(bytes) < 16L || length(bytes) %% 4L != 0L) {
      return(FALSE)
    }
    vector_length <- raw_word(bytes, 1L)
    limb_count <- raw_word(bytes, 5L)
    sign_word <- raw_word(bytes, 9L)
    if (!identical(vector_length, 1) || limb_count < 1 ||
        limb_count != (length(bytes) - 12L) / 4L ||
        !(sign_word %in% c(0, 1, 4294967295))) return(FALSE)
    limb_bytes <- bytes[13:length(bytes)]
    is_zero <- all(limb_bytes == as.raw(0))
    if (is_zero) {
      return(!require_positive && sign_word == 0 && limb_count == 1)
    }
    sign_ok <- if (require_positive) sign_word == 1 else sign_word %in% c(1, 4294967295)
    # Canonicality is established by the round trip below, so this structural
    # safety check deliberately makes no assumption about physical limb order.
    isTRUE(sign_ok)
  }
  attributes_ok <- is.raw(value) &&
    identical(attributes(value)[["class", exact = TRUE]], "bigq") &&
    identical(names(attributes(value)), c("class", "denominator")) &&
    is.raw(attr(value, "denominator", exact = TRUE))
  numerator_bytes <- value
  attributes(numerator_bytes) <- NULL
  denominator_bytes <- attr(value, "denominator", exact = TRUE)
  representation_ok <- isTRUE(attributes_ok) &&
    valid_bigz_raw(numerator_bytes, require_positive = FALSE) &&
    valid_bigz_raw(denominator_bytes, require_positive = TRUE)
  rendered <- if (representation_ok) {
    tryCatch(as.character(value), error = function(error) NA_character_)
  } else {
    NA_character_
  }
  representation_ok <- isTRUE(representation_ok) &&
    length(rendered) == 1L && !is.na(rendered) &&
    grepl("^(?:0|-?[1-9][0-9]*)(?:/[1-9][0-9]*)?$", rendered, perl = TRUE)
  roundtrip_ok <- isTRUE(representation_ok) &&
    identical(value, gmp::as.bigq(rendered))
  sc_assert(isTRUE(roundtrip_ok), "FAIL_TYPE",
            paste(label, "is not a canonical finite bigq scalar"))
  invisible(TRUE)
}

ea_q <- function(value) {
  if (inherits(value, "bigq")) {
    ea_assert_bigq_scalar(value, "exact rational input")
    return(value)
  }
  if (is.numeric(value)) {
    sc_assert(length(value) == 1L && !is.na(value) && is.finite(value),
              "FAIL_PARSE", "invalid nonfinite exact rational input")
    value <- format(value, scientific = FALSE, trim = TRUE)
  }
  value <- as.character(value)
  sc_assert(length(value) == 1L && !is.na(value), "FAIL_PARSE",
            "invalid exact rational input cardinality")
  if (grepl("^(?:0|-?[1-9][0-9]*)$", value, perl = TRUE)) {
    result <- gmp::as.bigq(value)
    ea_assert_bigq_scalar(result, "parsed exact integer")
    return(result)
  }
  if (grepl("^-?(?:0|[1-9][0-9]*)\\.[0-9]*[1-9]$", value, perl = TRUE)) {
    sign <- if (substr(value, 1L, 1L) == "-") -1L else 1L
    unsigned <- sub("^-", "", value)
    pieces <- strsplit(unsigned, ".", fixed = TRUE)[[1L]]
    whole <- pieces[[1L]]
    fraction <- pieces[[2L]]
    numerator <- paste0(whole, fraction)
    denominator <- paste0("1", paste(rep("0", nchar(fraction)), collapse = ""))
    result <- gmp::as.bigq(sign * gmp::as.bigz(numerator), gmp::as.bigz(denominator))
    ea_assert_bigq_scalar(result, "parsed exact decimal")
    return(result)
  }
  if (grepl("^(?:0|-?[1-9][0-9]*)/[1-9][0-9]*$", value, perl = TRUE)) {
    result <- gmp::as.bigq(value)
    ea_assert_bigq_scalar(result, "parsed exact fraction")
    return(result)
  }
  sc_abort("FAIL_PARSE", paste("invalid exact rational", value))
}

ea_q_zero <- function(value) {
  ea_assert_bigq_scalar(value, "zero-test coefficient")
  identical(as.character(value), "0")
}

ea_is_supported_exponent_text <- function(value) {
  if (!is.character(value) || length(value) != 1L || is.na(value) ||
      !grepl("^(?:0|[1-9][0-9]*)$", value, perl = TRUE)) return(FALSE)
  parsed <- tryCatch(gmp::as.bigz(value), error = function(error) NULL)
  !is.null(parsed) && length(parsed) == 1L && !is.na(parsed) &&
    parsed <= gmp::as.bigz(.Machine$integer.max)
}

ea_exponent_integer <- function(value, label = "polynomial exponent") {
  text <- if (is.integer(value) && length(value) == 1L && !is.na(value)) {
    as.character(value)
  } else if (is.double(value) && length(value) == 1L && !is.na(value) &&
             is.finite(value) && value == floor(value)) {
    format(value, scientific = FALSE, trim = TRUE)
  } else if (is.character(value) && length(value) == 1L) {
    value
  } else {
    NA_character_
  }
  sc_assert(!is.na(text) && ea_is_supported_exponent_text(text), "FAIL_TYPE",
            paste(label, "must be a canonical integer in [0, .Machine$integer.max]"))
  as.integer(text)
}

ea_assert_poly <- function(value, label = "polynomial") {
  expected_attributes <- if (is.list(value) && length(value) > 0L) {
    list(names = names(value), class = "ea_poly")
  } else {
    list(class = "ea_poly")
  }
  sc_assert(inherits(value, "ea_poly") && identical(class(value), "ea_poly") &&
              is.list(value) && identical(attributes(value), expected_attributes), "FAIL_TYPE",
            paste(label, "is not an ea_poly object"))
  keys <- names(value)
  if (length(value) == 0L) {
    sc_assert(is.null(keys) || length(keys) == 0L, "FAIL_TYPE",
              paste(label, "zero polynomial has malformed names"))
    return(invisible(TRUE))
  }
  sc_assert(!is.null(keys) && length(keys) == length(value) &&
              !anyNA(keys) && !anyDuplicated(keys) && identical(keys, sort(keys)),
            "FAIL_TYPE", paste(label, "has noncanonical or duplicate monomials"))
  valid_key <- function(key) {
    if (identical(key, "1")) return(TRUE)
    parts <- strsplit(key, "*", fixed = TRUE)[[1L]]
    variables <- sub("\\^.*$", "", parts)
    exponents <- sub("^.*\\^", "", parts)
    length(parts) > 0L && all(nzchar(parts)) &&
      all(grepl("^[A-Za-z][A-Za-z0-9_.]*\\^[1-9][0-9]*$", parts)) &&
      all(vapply(exponents, ea_is_supported_exponent_text, logical(1))) &&
      !anyDuplicated(variables) && identical(variables, sort(variables))
  }
  sc_assert(all(vapply(keys, valid_key, logical(1))), "FAIL_TYPE",
            paste(label, "contains a malformed monomial"))
  for (index in seq_along(value)) {
    coefficient_label <- paste(label, "coefficient", keys[[index]])
    ea_assert_bigq_scalar(value[[index]], coefficient_label)
    sc_assert(!ea_q_zero(value[[index]]), "FAIL_TYPE",
              paste(coefficient_label, "is a forbidden zero coefficient"))
  }
  invisible(TRUE)
}

ea_assert_rat <- function(value, label = "rational expression") {
  expected_attributes <- list(names = c("numerator", "denominator"),
                              class = "ea_rat")
  sc_assert(inherits(value, "ea_rat") && identical(class(value), "ea_rat") &&
              is.list(value) && identical(attributes(value), expected_attributes) &&
              identical(names(value), c("numerator", "denominator")),
            "FAIL_TYPE", paste(label, "is not an ea_rat object"))
  ea_assert_poly(value$numerator, paste(label, "numerator"))
  ea_assert_poly(value$denominator, paste(label, "denominator"))
  sc_assert(length(value$denominator) > 0L, "FAIL_TYPE",
            paste(label, "has a zero denominator polynomial"))
  invisible(TRUE)
}

ea_monomial <- function(exponents = integer(0)) {
  if (length(exponents) == 0L) return("1")
  variable_names <- names(exponents)
  sc_assert(!is.null(variable_names) && length(variable_names) == length(exponents) &&
              !anyNA(variable_names) && all(nzchar(variable_names)) &&
              !anyDuplicated(variable_names) &&
              all(grepl("^[A-Za-z][A-Za-z0-9_.]*$", variable_names)),
            "FAIL_TYPE", "monomial variables are malformed")
  parsed <- vapply(seq_along(exponents), function(index) {
    ea_exponent_integer(exponents[[index]],
                        paste("monomial exponent for", variable_names[[index]]))
  }, integer(1))
  names(parsed) <- variable_names
  exponents <- parsed[parsed != 0L]
  if (length(exponents) == 0L) return("1")
  exponents <- exponents[order(names(exponents))]
  paste(paste0(names(exponents), "^", exponents), collapse = "*")
}

ea_decode_monomial <- function(key) {
  sc_assert(is.character(key) && length(key) == 1L && !is.na(key) && nzchar(key),
            "FAIL_TYPE", "malformed monomial reached the decoder")
  if (identical(key, "1")) return(integer(0))
  parts <- strsplit(key, "*", fixed = TRUE)[[1L]]
  variables <- sub("\\^.*$", "", parts)
  exponent_text <- sub("^.*\\^", "", parts)
  sc_assert(length(parts) > 0L && all(nzchar(parts)) &&
              all(grepl("^[A-Za-z][A-Za-z0-9_.]*\\^[1-9][0-9]*$", parts)) &&
              all(vapply(exponent_text, ea_is_supported_exponent_text, logical(1))) &&
              !anyDuplicated(variables) && identical(variables, sort(variables)),
            "FAIL_TYPE", "malformed monomial reached the decoder")
  result <- integer(length(parts))
  names(result) <- variables
  result[] <- vapply(exponent_text, ea_exponent_integer, integer(1),
                     label = "monomial exponent")
  result
}

ea_poly <- function(terms = list()) {
  if (length(terms) == 0L) {
    result <- structure(list(), class = "ea_poly")
    ea_assert_poly(result)
    return(result)
  }
  combined <- list()
  term_names <- names(terms)
  for (index in seq_along(terms)) {
    key <- term_names[[index]]
    value <- ea_q(terms[[index]])
    combined[[key]] <- if (is.null(combined[[key]])) value else combined[[key]] + value
  }
  combined <- combined[!vapply(combined, ea_q_zero, logical(1))]
  if (length(combined) == 0L) {
    result <- structure(list(), class = "ea_poly")
    ea_assert_poly(result)
    return(result)
  }
  combined <- combined[order(names(combined))]
  result <- structure(combined, class = "ea_poly")
  ea_assert_poly(result)
  result
}

ea_poly_constant <- function(value) ea_poly(list(`1` = ea_q(value)))
ea_poly_symbol <- function(name) ea_poly(setNames(list(ea_q(1)), paste0(name, "^1")))

ea_poly_add <- function(left, right) {
  ea_assert_poly(left, "left polynomial"); ea_assert_poly(right, "right polynomial")
  ea_poly(c(unclass(left), unclass(right)))
}
ea_poly_negate <- function(value) {
  ea_assert_poly(value)
  ea_poly(lapply(unclass(value), function(coefficient) -coefficient))
}
ea_poly_subtract <- function(left, right) ea_poly_add(left, ea_poly_negate(right))

ea_poly_multiply <- function(left, right) {
  ea_assert_poly(left, "left polynomial"); ea_assert_poly(right, "right polynomial")
  if (length(left) == 0L || length(right) == 0L) return(ea_poly())
  terms <- list()
  for (left_key in names(left)) for (right_key in names(right)) {
    exponents <- c(ea_decode_monomial(left_key), ea_decode_monomial(right_key))
    if (length(exponents)) {
      variables <- sort(unique(names(exponents)))
      summed <- vapply(variables, function(variable) {
        total <- gmp::as.bigz(0)
        for (term in exponents[names(exponents) == variable]) {
          total <- total + gmp::as.bigz(as.character(term))
        }
        sc_assert(total <= gmp::as.bigz(.Machine$integer.max), "FAIL_TYPE",
                  "polynomial exponent sum exceeds exact integer range")
        as.integer(as.character(total))
      }, integer(1))
      names(summed) <- variables
      exponents <- summed
    }
    key <- ea_monomial(exponents)
    coefficient <- left[[left_key]] * right[[right_key]]
    terms[[key]] <- if (is.null(terms[[key]])) coefficient else terms[[key]] + coefficient
  }
  ea_poly(terms)
}

ea_poly_power <- function(value, exponent) {
  ea_assert_poly(value)
  exponent <- ea_exponent_integer(exponent)
  result <- ea_poly_constant(1)
  if (exponent == 0L) return(result)
  base <- value
  remaining <- exponent
  while (remaining > 0L) {
    if (remaining %% 2L == 1L) result <- ea_poly_multiply(result, base)
    remaining <- remaining %/% 2L
    if (remaining > 0L) base <- ea_poly_multiply(base, base)
  }
  result
}

ea_rat <- function(numerator, denominator = ea_poly_constant(1)) {
  ea_assert_poly(numerator, "rational numerator")
  ea_assert_poly(denominator, "rational denominator")
  sc_assert(length(denominator) > 0L, "FAIL_TYPE", "zero rational denominator")
  result <- structure(list(numerator = numerator, denominator = denominator), class = "ea_rat")
  ea_assert_rat(result)
  result
}

ea_rat_constant <- function(value) ea_rat(ea_poly_constant(value))
ea_rat_symbol <- function(name) ea_rat(ea_poly_symbol(name))

ea_rat_add <- function(left, right) {
  ea_assert_rat(left, "left rational"); ea_assert_rat(right, "right rational")
  ea_rat(ea_poly_add(ea_poly_multiply(left$numerator, right$denominator),
                     ea_poly_multiply(right$numerator, left$denominator)),
         ea_poly_multiply(left$denominator, right$denominator))
}
ea_rat_negate <- function(value) {
  ea_assert_rat(value)
  ea_rat(ea_poly_negate(value$numerator), value$denominator)
}
ea_rat_subtract <- function(left, right) ea_rat_add(left, ea_rat_negate(right))
ea_rat_multiply <- function(left, right) {
  ea_assert_rat(left, "left rational"); ea_assert_rat(right, "right rational")
  ea_rat(ea_poly_multiply(left$numerator, right$numerator),
         ea_poly_multiply(left$denominator, right$denominator))
}
ea_rat_divide <- function(left, right) {
  ea_assert_rat(left, "left rational"); ea_assert_rat(right, "right rational")
  sc_assert(length(right$numerator) > 0L, "FAIL_TYPE", "division by zero expression")
  ea_rat(ea_poly_multiply(left$numerator, right$denominator),
         ea_poly_multiply(left$denominator, right$numerator))
}

ea_ast_to_rat <- function(ast) {
  if (ast$kind == "number") return(ea_rat_constant(ast$value))
  if (ast$kind == "symbol") return(ea_rat_symbol(ast$name))
  if (ast$kind == "unary") {
    value <- ea_ast_to_rat(ast$argument)
    return(if (ast$operator == "-") ea_rat_negate(value) else value)
  }
  if (ast$kind == "binary") {
    left <- ea_ast_to_rat(ast$left)
    right <- ea_ast_to_rat(ast$right)
    if (ast$operator == "+") return(ea_rat_add(left, right))
    if (ast$operator == "-") return(ea_rat_subtract(left, right))
    if (ast$operator == "*") return(ea_rat_multiply(left, right))
    if (ast$operator == "/") return(ea_rat_divide(left, right))
    if (ast$operator == "^") {
      sc_assert(ast$right$kind == "number" &&
                  ea_is_supported_exponent_text(ast$right$value),
                "FAIL_TYPE", "only literal nonnegative integer powers are supported")
      exponent <- ea_exponent_integer(ast$right$value, "literal power exponent")
      return(ea_rat(ea_poly_power(left$numerator, exponent),
                    ea_poly_power(left$denominator, exponent)))
    }
  }
  sc_abort("FAIL_TYPE", paste("AST is not rational arithmetic:", sc_ast_canonical(ast)))
}

ea_poly_equal <- function(left, right) {
  ea_assert_poly(left, "left polynomial"); ea_assert_poly(right, "right polynomial")
  difference <- ea_poly_subtract(left, right)
  length(difference) == 0L
}

ea_rat_equal <- function(left, right) {
  ea_assert_rat(left, "left rational"); ea_assert_rat(right, "right rational")
  ea_poly_equal(ea_poly_multiply(left$numerator, right$denominator),
                ea_poly_multiply(right$numerator, left$denominator))
}

ea_poly_canonical <- function(poly) {
  ea_assert_poly(poly)
  if (length(poly) == 0L) return("0")
  paste(vapply(names(poly), function(key) paste0(as.character(poly[[key]]), "@", key),
               character(1)), collapse = "+")
}

ea_rat_canonical <- function(value) {
  ea_assert_rat(value)
  paste0("rat(", ea_poly_canonical(value$numerator), ")/(",
         ea_poly_canonical(value$denominator), ")")
}

ea_poly_variables <- function(poly) {
  ea_assert_poly(poly)
  sort(unique(unlist(lapply(names(poly), function(key) names(ea_decode_monomial(key))),
                     use.names = FALSE)))
}

ea_rat_variables <- function(value) {
  ea_assert_rat(value)
  sort(unique(c(ea_poly_variables(value$numerator),
                ea_poly_variables(value$denominator))))
}

ea_poly_evaluate <- function(poly, assignment) {
  ea_assert_poly(poly)
  variables <- ea_poly_variables(poly)
  sc_assert(all(variables %in% names(assignment)), "FAIL_CERTIFICATE",
            paste("missing exact assignment for", paste(setdiff(variables, names(assignment)),
                                                         collapse = ",")))
  if (length(poly) == 0L) return(ea_q(0))
  total <- ea_q(0)
  for (key in names(poly)) {
    exponents <- ea_decode_monomial(key)
    term <- poly[[key]]
    if (length(exponents)) {
      for (name in names(exponents)) {
        term <- term * (ea_q(assignment[[name]]) ^ as.integer(exponents[[name]]))
      }
    }
    total <- total + term
  }
  total
}

ea_rat_evaluate <- function(value, assignment) {
  ea_assert_rat(value)
  numerator <- ea_poly_evaluate(value$numerator, assignment)
  denominator <- ea_poly_evaluate(value$denominator, assignment)
  sc_assert(!ea_q_zero(denominator), "FAIL_CERTIFICATE",
            "rational expression denominator vanishes at exact witness")
  numerator / denominator
}

ea_q_sign <- function(value) {
  value <- ea_q(value)
  if (value > 0) return(1L)
  if (value < 0) return(-1L)
  0L
}

ea_rat_sign_at <- function(value, assignment) ea_q_sign(ea_rat_evaluate(value, assignment))

ea_ast_free_symbols <- function(ast, bound = character(0)) {
  sc_assert(is.list(ast) && !is.null(ast$kind), "FAIL_TYPE", "malformed AST in free-symbol walk")
  if (ast$kind == "number") return(character(0))
  if (ast$kind == "symbol") return(if (ast$name %in% bound) character(0) else ast$name)
  if (ast$kind == "bound_symbol") {
    return(if (ast$name %in% bound) character(0) else ast$name)
  }
  if (ast$kind == "set_symbol") return(if (ast$name %in% bound) character(0) else ast$name)
  if (ast$kind == "singleton") return(ea_ast_free_symbols(ast$element, bound))
  if (ast$kind == "set_difference") {
    return(sort(unique(c(ea_ast_free_symbols(ast$left, bound),
                         ea_ast_free_symbols(ast$right, bound)))))
  }
  if (ast$kind == "cardinality_constraint") {
    return(sort(unique(c(ea_ast_free_symbols(ast$set, bound),
                         ea_ast_free_symbols(ast$equals, bound)))))
  }
  if (ast$kind == "membership_constraint") {
    return(sort(unique(c(ea_ast_free_symbols(ast$element, bound),
                         ea_ast_free_symbols(ast$container, bound)))))
  }
  if (ast$kind == "not_equal_constraint") {
    return(sort(unique(c(ea_ast_free_symbols(ast$left, bound),
                         ea_ast_free_symbols(ast$right, bound)))))
  }
  if (ast$kind == "indexed_symbol") {
    indices <- unlist(ast$indices, use.names = FALSE)
    return(sort(unique(indices[!indices %in% bound])))
  }
  if (ast$kind == "indexed_sum") {
    binder <- ast$binder
    newly_bound <- unique(c(bound, binder$variable, binder$source_variable))
    domain_symbols <- ea_ast_free_symbols(binder$domain, bound)
    constraint_symbols <- unlist(lapply(binder$constraints, ea_ast_free_symbols,
                                        bound = newly_bound), use.names = FALSE)
    return(sort(unique(c(domain_symbols, constraint_symbols,
                         ea_ast_free_symbols(ast$body, newly_bound)))))
  }
  if (ast$kind == "quantifier") {
    binder <- ast$binder
    newly_bound <- unique(c(bound, binder$variable, binder$source_variable))
    domain_symbols <- ea_ast_free_symbols(binder$domain, bound)
    constraint_symbols <- unlist(lapply(binder$constraints, ea_ast_free_symbols,
                                        bound = newly_bound), use.names = FALSE)
    return(sort(unique(c(domain_symbols, constraint_symbols,
                         ea_ast_free_symbols(ast$body, newly_bound)))))
  }
  children <- switch(ast$kind,
    unary = list(ast$argument),
    binary = list(ast$left, ast$right),
    compare = list(ast$left, ast$right),
    logical = ast$arguments,
    call = ast$arguments,
    sc_abort("FAIL_TYPE", paste("unknown AST kind in free-symbol walk", ast$kind))
  )
  sort(unique(unlist(lapply(children, ea_ast_free_symbols, bound = bound),
                     use.names = FALSE)))
}

ea_ast_divisor_nfs <- function(ast) {
  sc_assert(is.list(ast) && !is.null(ast$kind), "FAIL_TYPE",
            "malformed AST in denominator audit")
  children <- switch(ast$kind,
    number = list(), symbol = list(), bound_symbol = list(), set_symbol = list(),
    indexed_symbol = list(),
    unary = list(ast$argument), binary = list(ast$left, ast$right),
    compare = list(ast$left, ast$right), logical = ast$arguments, call = ast$arguments,
    singleton = list(ast$element), set_difference = list(ast$left, ast$right),
    cardinality_constraint = list(ast$set, ast$equals),
    membership_constraint = list(ast$element, ast$container),
    not_equal_constraint = list(ast$left, ast$right),
    indexed_sum = list(ast$body), quantifier = list(ast$body),
    sc_abort("FAIL_TYPE", paste("unknown AST kind in denominator audit", ast$kind))
  )
  own <- if (identical(ast$kind, "binary") && identical(ast$operator, "/")) {
    ea_rat_canonical(ea_ast_to_rat(ast$right))
  } else character(0)
  sort(unique(c(own, unlist(lapply(children, ea_ast_divisor_nfs), use.names = FALSE))))
}

ea_domain_constraints <- function(domain_ast) {
  sc_assert(is.list(domain_ast) && identical(domain_ast$kind, "domain") &&
              identical(names(domain_ast), c("kind", "constraints")) &&
              is.list(domain_ast$constraints) && length(domain_ast$constraints) > 0L,
            "FAIL_CERTIFICATE", "denominator fact has no typed, nonempty domain")
  sc_assert(all(vapply(domain_ast$constraints, function(constraint) {
    is.list(constraint) && identical(constraint$kind, "compare") &&
      constraint$operator %in% c("<", "<=", ">", ">=", "=", "!=")
  }, logical(1))), "FAIL_CERTIFICATE", "denominator domain has a non-comparison atom")
  domain_ast$constraints
}

ea_ast_rat_equal <- function(left, right) {
  ea_rat_equal(ea_ast_to_rat(left), ea_ast_to_rat(right))
}

ea_constraint_implies <- function(constraint, proposition) {
  if (identical(sc_ast_canonical(constraint), sc_ast_canonical(proposition))) return(TRUE)
  zero <- sc_ast("number", value = "0", sort = "Rational")
  prop_zero <- ea_ast_rat_equal(proposition$right, zero)
  if (!prop_zero) return(FALSE)
  # A strict sign is sufficient for nonzero; a weak bound is sufficient only
  # when its exact numeric endpoint is itself strictly on the required side.
  same_left <- ea_ast_rat_equal(constraint$left, proposition$left)
  constraint_zero <- ea_ast_rat_equal(constraint$right, zero)
  if (same_left && constraint_zero &&
      identical(constraint$operator, proposition$operator)) return(TRUE)
  if (same_left && constraint_zero && proposition$operator == "!=" &&
      constraint$operator %in% c(">", "<")) return(TRUE)
  if (same_left && proposition$operator %in% c(">", "!=") &&
      constraint$operator == ">=") {
    endpoint <- try(ea_ast_to_rat(constraint$right), silent = TRUE)
    if (!inherits(endpoint, "try-error") && length(ea_rat_variables(endpoint)) == 0L) {
      return(ea_rat_evaluate(endpoint, list()) > 0)
    }
  }
  if (same_left && proposition$operator %in% c("<", "!=") &&
      constraint$operator == "<=") {
    endpoint <- try(ea_ast_to_rat(constraint$right), silent = TRUE)
    if (!inherits(endpoint, "try-error") && length(ea_rat_variables(endpoint)) == 0L) {
      return(ea_rat_evaluate(endpoint, list()) < 0)
    }
  }
  # The frequent probability complement case: nu<1 entails 1-nu>0.
  if (proposition$operator %in% c(">", "!=") && constraint$operator == "<") {
    complement <- sc_ast("binary", operator = "-",
                         left = sc_ast("number", value = "1", sort = "Rational"),
                         right = constraint$left, sort = "Real")
    if (ea_ast_rat_equal(proposition$left, complement) &&
        ea_ast_rat_equal(constraint$right,
                         sc_ast("number", value = "1", sort = "Rational"))) return(TRUE)
  }
  FALSE
}

ea_validate_trusted_domain_fact <- function(fact, denominator_nf, label) {
  sc_assert(is.list(fact) && identical(names(fact),
              c("fact_id", "denominator_nf", "proposition_ast", "domain_ast",
                "source_step_ids", "source_object_hash")),
            "FAIL_CERTIFICATE", paste(label, "has malformed denominator provenance"))
  sc_assert(is.character(fact$fact_id) && length(fact$fact_id) == 1L &&
              nzchar(fact$fact_id) && identical(fact$denominator_nf, denominator_nf) &&
              is.character(fact$source_step_ids) && length(fact$source_step_ids) > 0L &&
              all(grepl("^S[0-9]{2}$", fact$source_step_ids)) &&
              is.character(fact$source_object_hash) &&
              grepl("^[0-9a-f]{64}$", fact$source_object_hash),
            "FAIL_CERTIFICATE", paste(label, "denominator provenance is not replay-bound"))
  proposition <- fact$proposition_ast
  sc_assert(is.list(proposition) && identical(proposition$kind, "compare") &&
              proposition$operator %in% c("!=", ">", "<"),
            "FAIL_CERTIFICATE", paste(label, "nonzero proposition is not typed"))
  zero <- sc_ast("number", value = "0", sort = "Rational")
  sc_assert(ea_ast_rat_equal(proposition$right, zero) &&
              identical(ea_rat_canonical(ea_ast_to_rat(proposition$left)), denominator_nf),
            "FAIL_CERTIFICATE", paste(label, "proposition does not prove this denominator"))
  constraints <- ea_domain_constraints(fact$domain_ast)
  sc_assert(any(vapply(constraints, ea_constraint_implies, logical(1),
                       proposition = proposition)),
            "FAIL_CERTIFICATE", paste(label, "local domain does not imply denominator nonzero"))
  invisible(TRUE)
}

ea_reject_unscoped_division <- function(ast, label) {
  required <- ea_ast_divisor_nfs(ast)
  sc_assert(length(required) == 0L, "FAIL_CERTIFICATE",
            paste(label, "contains division; use a closed proof-kernel rule that",
                  "reconstructs its local domain and denominator fact"))
  invisible(TRUE)
}

ea_compare_exact <- function(actual_ast, expected_ast, label = "expression") {
  ea_reject_unscoped_division(actual_ast, paste(label, "actual"))
  ea_reject_unscoped_division(expected_ast, paste(label, "expected"))
  actual <- ea_ast_to_rat(actual_ast)
  expected <- ea_ast_to_rat(expected_ast)
  sc_assert(ea_rat_equal(actual, expected), "FAIL_EQUIVALENCE",
            paste(label, "is not exactly symbolically equivalent"))
  list(method = "exact_cross_multiplication",
       actual_nf = ea_rat_canonical(actual), expected_nf = ea_rat_canonical(expected))
}
