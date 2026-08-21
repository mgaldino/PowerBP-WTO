#!/usr/bin/env Rscript

# Closed-form results for the frozen essential-input nodes N1--N4.
#
# This module is the single formula source for the numerical harness (Task A)
# and the plotting infrastructure (Task C).  Every formula below is pinned to
# the exact frozen interface and derivation bytes listed in
# `essential_input_formula_sources()`.  The module does not consume N6 or N7.

# Used only by numerical assertions.  Cell membership and strict inequalities
# below use exact comparisons so a positive parameter is never reclassified as
# an endpoint merely because it is small.
ei_tolerance <- 1e-10

essential_input_repository_root <- function(start = getwd()) {
  current <- normalizePath(start, mustWork = TRUE)
  repeat {
    if (file.exists(file.path(current, "AGENTS.md")) &&
        file.exists(file.path(current, "model_redesign", "essential_input_game_dag.json"))) {
      return(current)
    }
    parent <- dirname(current)
    if (identical(parent, current)) {
      stop("Could not locate the PowerBayesianPersuasion repository root.", call. = FALSE)
    }
    current <- parent
  }
}

essential_input_formula_sources <- function() {
  c(
    "model_redesign/essential_input_interfaces/n1_r2_majority_candidate_v1.json" =
      "1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5",
    "model_redesign/essential_input_n1_r2_majority_derivation.md" =
      "44ef92fcd8bb76af65b937b37ff509fcb9b179bc3fa3d06a3331c346e20a761a",
    "model_redesign/essential_input_n2_r2_unanimity_interface.json" =
      "c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2",
    "model_redesign/essential_input_n2_r2_unanimity_derivation.md" =
      "3265be3379a902c4deac9db10d45babb2e6c7ad1f98a436ea113e33732cefc99",
    "model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json" =
      "ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d",
    "model_redesign/essential_input_solution_concept/n3_r1_majority_rederivation_candidate.md" =
      "75931253fd04303420b2d17552f60d9ee6fc2bf108f8b7ff03ada2eeed9201d3",
    "model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json" =
      "f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b",
    "model_redesign/essential_input_solution_concept/n4_r1_unanimity_rederivation_candidate.md" =
      "4cc246d1fadaeb18b90ae9956fa08e96d576f6e0821b521493a3ba47074dab1e",
    "quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md" =
      "94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69"
  )
}

ei_sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    stderr = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  if (length(output) != 1L) {
    stop(paste("Could not compute SHA-256 for", path), call. = FALSE)
  }
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  if (!grepl("^[0-9a-f]{64}$", hash)) {
    stop(paste("Malformed SHA-256 for", path), call. = FALSE)
  }
  hash
}

verify_essential_input_formula_sources <- function(
    repository_root = essential_input_repository_root()) {
  expected <- essential_input_formula_sources()
  observed <- vapply(
    names(expected),
    function(relative_path) {
      absolute_path <- file.path(repository_root, relative_path)
      if (!file.exists(absolute_path)) {
        stop(paste("Frozen formula source is missing:", relative_path), call. = FALSE)
      }
      ei_sha256_file(absolute_path)
    },
    character(1)
  )
  mismatch <- names(expected)[observed != unname(expected)]
  if (length(mismatch) > 0L) {
    details <- paste(
      sprintf("%s (expected %s, observed %s)", mismatch, expected[mismatch], observed[mismatch]),
      collapse = "; "
    )
    stop(paste("Frozen formula source hash mismatch:", details), call. = FALSE)
  }
  invisible(data.frame(
    source_path = names(expected),
    sha256 = unname(observed),
    stringsAsFactors = FALSE
  ))
}

validate_essential_input_parameters <- function(N, o_0, o_1, beta, nu = NULL) {
  if (length(N) != 1L || !is.finite(N) || N != as.integer(N) || N < 3L) {
    stop("N must be one integer with N >= 3.", call. = FALSE)
  }
  if (length(o_0) != 1L || length(o_1) != 1L ||
      !is.finite(o_0) || !is.finite(o_1) ||
      !(0 < o_0 && o_0 < o_1 && o_1 < 1)) {
    stop("The domain requires 0 < o_0 < o_1 < 1.", call. = FALSE)
  }
  if (length(beta) != 1L || !is.finite(beta) || !(0 < beta && beta < 1)) {
    stop("The frozen baseline requires beta in (0,1).", call. = FALSE)
  }
  if (!is.null(nu) &&
      (length(nu) != 1L || !is.finite(nu) || nu < 0 || nu > 1)) {
    stop("nu must belong to [0,1].", call. = FALSE)
  }
  invisible(TRUE)
}

essential_input_constants <- function(N, o_0, o_1, beta, nu) {
  validate_essential_input_parameters(N, o_0, o_1, beta, nu)
  m <- as.integer(N) - 1L
  q <- floor(as.integer(N) / 2) + 1L
  substitute_price <- 1 / m
  nu_star <- (o_1 - o_0) / (1 - o_0)
  w <- beta / m
  t_0 <- beta * o_0
  t_1 <- beta * o_1
  E <- 1 - (q - 1) * w
  L <- 1 - (q - 2) * w - t_0
  S <- (1 - nu) * L + nu * w
  P <- 1 - (q - 2) * w - t_1
  R <- w
  nu_SE <- if (o_0 < substitute_price) {
    beta * (substitute_price - o_0) /
      (beta * (substitute_price - o_0) + 1 - beta * q / m)
  } else {
    NA_real_
  }
  nu_SP <- if (o_1 < substitute_price) {
    beta * (o_1 - o_0) /
      (1 - beta * o_0 - beta * (q - 1) / m)
  } else {
    NA_real_
  }
  nu_EP <- if (o_1 == substitute_price) {
    (beta * o_1 - o_0) / (o_1 - o_0)
  } else {
    NA_real_
  }
  ell <- t_0
  h <- t_1
  A <- beta * (1 - o_0) / m
  B <- beta * (1 - o_1) / m
  D <- (1 - nu) * A
  C <- if (nu <= nu_star) D else B
  Q_L <- 1 - ell - (m - 1) * A
  Q_P <- 1 - h - (m - 1) * B
  list(
    N = as.integer(N), m = m, q = q, o_0 = o_0, o_1 = o_1,
    beta = beta, nu = nu, substitute_price = substitute_price,
    nu_star = nu_star, w = w, t_0 = t_0, t_1 = t_1,
    E = E, L = L, S = S, P = P, R = R,
    nu_SE = nu_SE, nu_SP = nu_SP, nu_EP = nu_EP,
    ell = ell, h = h, A = A, B = B, D = D, C = C,
    Q_L = Q_L, Q_P = Q_P
  )
}

n1_closed_form <- function(N, o_0, o_1, beta, nu) {
  z <- essential_input_constants(N, o_0, o_1, beta, nu)
  list(
    cell_id = "N1-UNIQUE",
    class = "E",
    y = 0,
    weak_payments = rep(0, z$m - 1L),
    proposer_residual = 1,
    recognized_proposer_payoff = 1,
    weak_pre_recognition_value = 1 / z$m,
    hegemon_payoff = c(theta_0 = o_0, theta_1 = o_1),
    outcome = c(pass_with_H = 0, pass_without_H = 1, failure = 0, delay = 0)
  )
}

n2_closed_form <- function(N, o_0, o_1, beta, nu) {
  z <- essential_input_constants(N, o_0, o_1, beta, nu)
  low_only <- nu <= z$nu_star
  if (low_only) {
    recognized <- (1 - nu) * (1 - o_0)
    list(
      cell_id = "N2-LOW-TYPE-ONLY",
      class = "S",
      nu_star = z$nu_star,
      y = o_0,
      proposer_residual = 1 - o_0,
      recognized_proposer_payoff = recognized,
      weak_pre_recognition_value = recognized / z$m,
      hegemon_payoff = c(theta_0 = o_0, theta_1 = o_1),
      outcome = c(pass_with_H = 1 - nu, pass_without_H = 0,
                  failure = nu, delay = 0)
    )
  } else {
    list(
      cell_id = "N2-POOLING",
      class = "P",
      nu_star = z$nu_star,
      y = o_1,
      proposer_residual = 1 - o_1,
      recognized_proposer_payoff = 1 - o_1,
      weak_pre_recognition_value = (1 - o_1) / z$m,
      hegemon_payoff = c(theta_0 = o_1, theta_1 = o_1),
      outcome = c(pass_with_H = 1, pass_without_H = 0, failure = 0, delay = 0)
    )
  }
}

n3_candidate_table <- function(N, o_0, o_1, beta, nu) {
  z <- essential_input_constants(N, o_0, o_1, beta, nu)
  data.frame(
    class = c("E", "S", "P"),
    proposer_payoff = c(z$E, z$S, z$P),
    residual = c(z$E, z$L, z$P),
    feasible = c(TRUE, z$L >= 0, z$P >= 0),
    H_theta_0 = c(o_0, z$t_0, z$t_1),
    H_theta_1 = c(o_1, z$t_1, z$t_1),
    pass_with_H = c(0, 1 - nu, 1),
    pass_without_H = c(1, 0, 0),
    failure = c(0, 0, 0),
    delay = c(0, nu, 0),
    stringsAsFactors = FALSE
  )
}

n3_closed_form_cell <- function(N, o_0, o_1, beta, nu) {
  z <- essential_input_constants(N, o_0, o_1, beta, nu)
  c0 <- z$substitute_price
  below_0 <- o_0 < c0
  equal_0 <- o_0 == c0
  below_1 <- o_1 < c0
  equal_1 <- o_1 == c0

  if (below_1) {
    if (nu <= z$nu_SP) "N3-C01-BELOW-S" else "N3-C02-BELOW-P"
  } else if (below_0 && o_1 > c0) {
    if (nu <= z$nu_SE) "N3-C03-CROSS-S" else "N3-C04-CROSS-E"
  } else if (o_0 > c0) {
    "N3-C05-ABOVE-E"
  } else if (equal_0) {
    if (nu == 0) "N3-C06-O0-EQUAL-S" else "N3-C07-O0-EQUAL-E"
  } else if (below_0 && equal_1) {
    if (nu <= z$nu_SE) {
      "N3-C08-O1-EQUAL-S"
    } else if (nu < z$nu_EP) {
      "N3-C09-O1-EQUAL-E"
    } else if (nu > z$nu_EP) {
      "N3-C10-O1-EQUAL-P"
    } else {
      "N3-C11-O1-EQUAL-EP"
    }
  } else {
    stop("N3 closed-form partition did not classify the parameter point.", call. = FALSE)
  }
}

n3_closed_form <- function(N, o_0, o_1, beta, nu) {
  z <- essential_input_constants(N, o_0, o_1, beta, nu)
  candidates <- n3_candidate_table(N, o_0, o_1, beta, nu)
  cell_id <- n3_closed_form_cell(N, o_0, o_1, beta, nu)
  selected_classes <- switch(
    cell_id,
    "N3-C01-BELOW-S" = "S",
    "N3-C02-BELOW-P" = "P",
    "N3-C03-CROSS-S" = "S",
    "N3-C04-CROSS-E" = "E",
    "N3-C05-ABOVE-E" = "E",
    "N3-C06-O0-EQUAL-S" = "S",
    "N3-C07-O0-EQUAL-E" = "E",
    "N3-C08-O1-EQUAL-S" = "S",
    "N3-C09-O1-EQUAL-E" = "E",
    "N3-C10-O1-EQUAL-P" = "P",
    "N3-C11-O1-EQUAL-EP" = c("E", "P"),
    stop("Unknown N3 cell.", call. = FALSE)
  )
  selected <- candidates$class %in% selected_classes
  selected_table <- candidates[selected, , drop = FALSE]
  maximum <- selected_table$proposer_payoff[[1L]]
  list(
    cell_id = cell_id,
    selected_classes = sort(selected_table$class),
    proposer_payoff = maximum,
    candidate_table = candidates,
    selected_table = selected_table,
    cutoffs = c(nu_SE = z$nu_SE, nu_SP = z$nu_SP, nu_EP = z$nu_EP),
    strict_exclusion_gain_over_rejection = 1 - beta * z$q / z$m
  )
}

n4_closed_form <- function(N, o_0, o_1, beta, nu) {
  z <- essential_input_constants(N, o_0, o_1, beta, nu)
  if (nu == 0) {
    list(
      cell_id = "N4-NU-ZERO",
      existence_status = "exists",
      class = "L",
      proposal = c(y = z$ell, x = z$A, r = z$Q_L),
      recognized_proposer_payoff = z$Q_L,
      weak_pre_recognition_value = (1 - z$ell) / z$m,
      hegemon_payoff = c(theta_0 = z$ell, theta_1 = z$h),
      outcome = c(pass_with_H = 1, pass_without_H = 0, failure = 0, delay = 0),
      nu_star = z$nu_star
    )
  } else if (nu <= z$nu_star) {
    list(
      cell_id = "N4-NO-PURE-PBE",
      existence_status = "none",
      class = NA_character_,
      proposal = NULL,
      recognized_proposer_payoff = NA_real_,
      weak_pre_recognition_value = NA_real_,
      hegemon_payoff = c(theta_0 = NA_real_, theta_1 = NA_real_),
      outcome = c(pass_with_H = NA_real_, pass_without_H = NA_real_,
                  failure = NA_real_, delay = NA_real_),
      nu_star = z$nu_star
    )
  } else {
    list(
      cell_id = "N4-HIGH-PRIOR",
      existence_status = "exists",
      class = "P",
      proposal = c(y = z$h, x = z$B, r = z$Q_P),
      recognized_proposer_payoff = z$Q_P,
      weak_pre_recognition_value = (1 - z$h) / z$m,
      hegemon_payoff = c(theta_0 = z$h, theta_1 = z$h),
      outcome = c(pass_with_H = 1, pass_without_H = 0, failure = 0, delay = 0),
      nu_star = z$nu_star
    )
  }
}

essential_input_margin_table <- function(N, o_0, o_1, beta, nu) {
  z <- essential_input_constants(N, o_0, o_1, beta, nu)
  data.frame(
    condition = c(
      "Hegemonia do tipo baixo: o_0 versus 1/m",
      "Hegemonia do tipo alto: o_1 versus 1/m",
      "N2/N4: nu versus nu_star",
      "N3: exclusão versus rejeição",
      "N4: acordo forçado versus continuação"
    ),
    lhs = c(o_0, o_1, nu, z$E, 1 - beta),
    rhs = c(z$substitute_price, z$substitute_price, z$nu_star, z$R, 0),
    margin = c(
      o_0 - z$substitute_price,
      o_1 - z$substitute_price,
      nu - z$nu_star,
      z$E - z$R,
      1 - beta
    ),
    status = c(
      if (o_0 < z$substitute_price) "abaixo" else if (o_0 > z$substitute_price) "acima" else "fronteira",
      if (o_1 < z$substitute_price) "abaixo" else if (o_1 > z$substitute_price) "acima" else "fronteira",
      if (nu < z$nu_star) "abaixo" else if (nu > z$nu_star) "acima" else "fronteira",
      if (z$E > z$R) "estritamente satisfeita" else "não satisfeita",
      if (beta < 1) "estritamente satisfeita" else "não satisfeita"
    ),
    stringsAsFactors = FALSE
  )
}
