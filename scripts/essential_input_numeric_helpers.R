#!/usr/bin/env Rscript

# Primitive numerical solvers and deterministic parameter grids for Task A.
# Closed-form formulas live only in `essential_input_formulas.R`.

ei_assert_true <- function(condition, message) {
  if (!isTRUE(condition)) {
    stop(message, call. = FALSE)
  }
}

ei_assert_close <- function(observed, expected, label, tolerance = 1e-9) {
  if (length(observed) != length(expected) ||
      any(is.na(observed) != is.na(expected)) ||
      any(abs(observed[!is.na(observed)] - expected[!is.na(expected)]) > tolerance)) {
    stop(
      sprintf(
        "%s mismatch: observed=[%s], expected=[%s]",
        label,
        paste(signif(observed, 14), collapse = ","),
        paste(signif(expected, 14), collapse = ",")
      ),
      call. = FALSE
    )
  }
  invisible(TRUE)
}

ei_assert_set_equal <- function(observed, expected, label) {
  observed <- sort(unique(as.character(observed)))
  expected <- sort(unique(as.character(expected)))
  if (!identical(observed, expected)) {
    stop(
      sprintf(
        "%s mismatch: observed={%s}, expected={%s}",
        label,
        paste(observed, collapse = ","),
        paste(expected, collapse = ",")
      ),
      call. = FALSE
    )
  }
  invisible(TRUE)
}

ei_is_direct_script <- function(filename) {
  argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  length(argument) == 1L && identical(basename(sub("^--file=", "", argument)), filename)
}

ei_o_pair_grid <- function(N) {
  m <- as.integer(N) - 1L
  c_m <- 1 / m
  above <- function(fraction) c_m + fraction * (1 - c_m)
  data.frame(
    pair_id = c(
      "below", "o1_equal_low", "o1_equal_mid", "cross",
      "o0_equal", "above", "wide_cross", "o1_below_tiny",
      "o1_above_tiny", "o0_below_tiny", "o0_above_tiny"
    ),
    o_0 = c(
      0.25 * c_m,
      0.25 * c_m,
      0.50 * c_m,
      0.50 * c_m,
      c_m,
      above(0.20),
      0.10 * c_m,
      0.50 * c_m,
      0.50 * c_m,
      c_m - 1e-12,
      c_m + 1e-12
    ),
    o_1 = c(
      0.50 * c_m,
      c_m,
      c_m,
      above(0.25),
      above(0.25),
      above(0.45),
      above(0.70),
      c_m - 1e-12,
      c_m + 1e-12,
      above(0.25),
      above(0.25)
    ),
    stringsAsFactors = FALSE
  )
}

ei_add_cutoff_neighborhood <- function(
    values, cutoff, epsilons = c(1e-14, 1e-12, 1e-8, 1e-7)) {
  if (!is.finite(cutoff) || cutoff < 0 || cutoff > 1) {
    return(values)
  }
  c(
    values,
    cutoff,
    unlist(lapply(epsilons, function(epsilon) {
      c(max(0, cutoff - epsilon), min(1, cutoff + epsilon))
    }), use.names = FALSE)
  )
}

ei_nu_grid <- function(N, o_0, o_1, beta) {
  base <- c(
    0, 1e-14, 1e-12, 1e-8, 0.05, 0.25, 0.5, 0.75, 0.95,
    1 - 1e-8, 1 - 1e-12, 1 - 1e-14, 1
  )
  z <- essential_input_constants(N, o_0, o_1, beta, 0.5)
  values <- ei_add_cutoff_neighborhood(base, z$nu_star)
  values <- ei_add_cutoff_neighborhood(values, z$nu_SE)
  values <- ei_add_cutoff_neighborhood(values, z$nu_SP)
  values <- ei_add_cutoff_neighborhood(values, z$nu_EP)
  values <- pmin(1, pmax(0, values))
  sort(unique(values))
}

ei_parameter_grid <- function() {
  rows <- list()
  index <- 0L
  for (N in c(5L, 7L)) {
    pairs <- ei_o_pair_grid(N)
    for (pair_index in seq_len(nrow(pairs))) {
      for (beta in c(0.5, 0.9, 0.99)) {
        nu_values <- ei_nu_grid(N, pairs$o_0[[pair_index]], pairs$o_1[[pair_index]], beta)
        for (nu in nu_values) {
          index <- index + 1L
          rows[[index]] <- data.frame(
            N = N,
            pair_id = pairs$pair_id[[pair_index]],
            o_0 = pairs$o_0[[pair_index]],
            o_1 = pairs$o_1[[pair_index]],
            beta = beta,
            nu = nu,
            stringsAsFactors = FALSE
          )
        }
      }
    }
  }
  do.call(rbind, rows)
}

ei_run_boundary_regression_checks <- function() {
  N <- 5L
  o_0 <- 0.10
  o_1 <- 0.35
  beta <- 0.90
  z <- essential_input_constants(N, o_0, o_1, beta, 0)
  tiny <- 5e-11

  ei_assert_true(
    n4_closed_form(N, o_0, o_1, beta, tiny)$existence_status == "none",
    "A strictly positive tiny prior must not be classified as the N4 nu=0 endpoint."
  )
  ei_assert_true(
    n2_closed_form(N, o_0, o_1, beta, z$nu_star + tiny)$class == "P",
    "A prior strictly above nu_star must not be classified in the lower N2 cell."
  )
  ei_assert_true(
    n4_closed_form(N, o_0, o_1, beta, z$nu_star + tiny)$class == "P",
    "A prior strictly above nu_star must not be classified in the empty N4 cell."
  )
  ei_assert_close(
    ei_support_restricted_posterior_candidates(
      "yes", c("no", "yes"), tiny, z$nu_star
    ),
    1,
    "Bayes posterior after a positive-probability high-type action near nu=0"
  )
  ei_assert_close(
    ei_support_restricted_posterior_candidates(
      "yes", c("yes", "no"), 1 - tiny, z$nu_star
    ),
    0,
    "Bayes posterior after a positive-probability low-type action near nu=1"
  )
  invisible(TRUE)
}

ei_support_restricted_posterior_candidates <- function(action, profile, nu, nu_star) {
  ei_assert_true(action %in% c("yes", "no"), "Unknown H action.")
  ei_assert_true(length(profile) == 2L, "H profile must have one action per type.")
  probability <- (1 - nu) * as.numeric(profile[[1L]] == action) +
    nu * as.numeric(profile[[2L]] == action)
  if (probability > 0) {
    posterior <- nu * as.numeric(profile[[2L]] == action) / probability
    return(posterior)
  }
  if (nu == 0) return(0)
  if (nu == 1) return(1)
  sort(unique(c(0, nu_star, min(1, nu_star + 1e-7), 1)))
}

ei_n2_weak_value_r1 <- function(eta, z) {
  if (eta <= z$nu_star) (1 - eta) * z$A else z$B
}

ei_n2_H_value_r1 <- function(theta, eta, z) {
  if (theta == 1L) return(z$h)
  if (eta <= z$nu_star) z$ell else z$h
}

ei_tie_yes_best_response <- function(yes_payoff, no_payoff) {
  if (yes_payoff >= no_payoff) "yes" else "no"
}

ei_n4_ballot_profiles <- function(N, o_0, o_1, beta, nu, y, x) {
  z <- essential_input_constants(N, o_0, o_1, beta, nu)
  ei_assert_true(length(x) == z$m - 1L, "N4 requires one payment per weak responder.")
  profile_list <- list(c("yes", "yes"), c("no", "no"), c("yes", "no"), c("no", "yes"))
  rows <- list()
  row_index <- 0L
  for (profile in profile_list) {
    eta_yes_values <- ei_support_restricted_posterior_candidates("yes", profile, nu, z$nu_star)
    eta_no_values <- ei_support_restricted_posterior_candidates("no", profile, nu, z$nu_star)
    for (eta_yes in eta_yes_values) {
      for (eta_no in eta_no_values) {
        pivotal_weak_value <- ei_n2_weak_value_r1(eta_yes, z)
        weak_votes_yes <- x >= pivotal_weak_value
        all_weak_yes <- all(weak_votes_yes)
        best_actions <- character(2L)
        for (theta_index in 1:2) {
          theta <- theta_index - 1L
          yes_payoff <- if (all_weak_yes) {
            y
          } else {
            ei_n2_H_value_r1(theta, eta_yes, z)
          }
          no_payoff <- ei_n2_H_value_r1(theta, eta_no, z)
          best_actions[[theta_index]] <- ei_tie_yes_best_response(yes_payoff, no_payoff)
        }
        if (identical(profile, best_actions)) {
          row_index <- row_index + 1L
          rows[[row_index]] <- data.frame(
            profile = paste0(substr(profile[[1L]], 1, 1), substr(profile[[2L]], 1, 1)),
            eta_yes = eta_yes,
            eta_no = eta_no,
            weak_yes_count = sum(weak_votes_yes),
            all_weak_yes = all_weak_yes,
            stringsAsFactors = FALSE
          )
        }
      }
    }
  }
  if (length(rows) == 0L) {
    return(data.frame(
      profile = character(), eta_yes = numeric(), eta_no = numeric(),
      weak_yes_count = integer(), all_weak_yes = logical(),
      stringsAsFactors = FALSE
    ))
  }
  unique(do.call(rbind, rows))
}

ei_n1_primitive_solver <- function(N, o_0, o_1, beta, nu) {
  z <- essential_input_constants(N, o_0, o_1, beta, nu)
  weak_payment_checks <- c(0, 0.1 / z$m, 1 / z$m)
  weak_votes <- vapply(weak_payment_checks, function(x) x >= 0, logical(1))
  ei_assert_true(all(weak_votes), "N1 primitive ballot did not select yes for every weak payment.")
  ei_assert_true(o_0 > 0 && o_1 > 0, "N1 requires H to strictly prefer no when nonpivotal.")
  list(
    class = "E",
    y = 0,
    proposer_residual = 1,
    recognized_proposer_payoff = 1,
    weak_pre_recognition_value = 1 / z$m,
    hegemon_payoff = c(theta_0 = o_0, theta_1 = o_1),
    outcome = c(pass_with_H = 0, pass_without_H = 1, failure = 0, delay = 0)
  )
}

ei_n2_primitive_solver <- function(N, o_0, o_1, beta, nu) {
  z <- essential_input_constants(N, o_0, o_1, beta, nu)
  y_values <- sort(unique(c(
    0, o_0 / 2, o_0, (o_0 + o_1) / 2, o_1, (o_1 + 1) / 2, 1
  )))
  table <- do.call(rbind, lapply(y_values, function(y) {
    residual <- 1 - y
    pass_0 <- y >= o_0
    pass_1 <- y >= o_1
    proposer_payoff <- (1 - nu) * residual * pass_0 + nu * residual * pass_1
    H_0 <- if (pass_0) y else o_0
    H_1 <- if (pass_1) y else o_1
    data.frame(
      y = y,
      proposer_residual = residual,
      proposer_payoff = proposer_payoff,
      H_theta_0 = H_0,
      H_theta_1 = H_1,
      pass_with_H = (1 - nu) * pass_0 + nu * pass_1,
      failure = 1 - ((1 - nu) * pass_0 + nu * pass_1),
      stringsAsFactors = FALSE
    )
  }))
  maximum <- max(table$proposer_payoff)
  payoff_ties <- table$proposer_payoff == maximum
  if (nu == z$nu_star) {
    payoff_ties <- table$y %in% c(o_0, o_1)
  }
  expected_H <- (1 - nu) * table$H_theta_0 + nu * table$H_theta_1
  minimum_H <- min(expected_H[payoff_ties])
  selected <- table[payoff_ties & expected_H == minimum_H, , drop = FALSE]
  selected$class <- ifelse(selected$y == o_0, "S",
                           ifelse(selected$y == o_1, "P", "OTHER"))
  selected
}

ei_n3_primitive_solver <- function(N, o_0, o_1, beta, nu) {
  z <- essential_input_constants(N, o_0, o_1, beta, nu)
  rows <- list()
  index <- 0L
  y_values <- sort(unique(c(0, z$t_0, z$t_1)))
  for (k in 0:(z$m - 1L)) {
    for (y in y_values) {
      residual <- 1 - k * z$w - y
      if (residual < 0) next
      residual <- max(0, residual)
      if (k >= z$q - 1L) {
        pass_0 <- TRUE
        pass_1 <- TRUE
        with_H_0 <- FALSE
        with_H_1 <- FALSE
      } else if (k == z$q - 2L) {
        pass_0 <- y >= z$t_0
        pass_1 <- y >= z$t_1
        with_H_0 <- pass_0
        with_H_1 <- pass_1
      } else {
        pass_0 <- FALSE
        pass_1 <- FALSE
        with_H_0 <- FALSE
        with_H_1 <- FALSE
      }
      proposer_0 <- if (pass_0) residual else z$w
      proposer_1 <- if (pass_1) residual else z$w
      H_0 <- if (pass_0 && with_H_0) y else if (pass_0) y + o_0 else z$t_0
      H_1 <- if (pass_1 && with_H_1) y else if (pass_1) y + o_1 else z$t_1
      class <- "OTHER"
      if (k == z$q - 1L && y == 0) class <- "E"
      if (k == z$q - 2L && y == z$t_0) class <- "S"
      if (k == z$q - 2L && y == z$t_1) class <- "P"
      if (k <= z$q - 3L) class <- "R"
      index <- index + 1L
      rows[[index]] <- data.frame(
        class = class,
        k = k,
        y = y,
        proposer_residual = residual,
        proposer_payoff = (1 - nu) * proposer_0 + nu * proposer_1,
        H_theta_0 = H_0,
        H_theta_1 = H_1,
        pass_with_H = (1 - nu) * with_H_0 + nu * with_H_1,
        pass_without_H = (1 - nu) * (pass_0 && !with_H_0) +
          nu * (pass_1 && !with_H_1),
        failure = 0,
        delay = (1 - nu) * (!pass_0) + nu * (!pass_1),
        stringsAsFactors = FALSE
      )
    }
  }
  table <- do.call(rbind, rows)
  maximum <- max(table$proposer_payoff)
  payoff_ties <- table$proposer_payoff == maximum
  if (o_1 < z$substitute_price && is.finite(z$nu_SP) && nu == z$nu_SP) {
    payoff_ties <- payoff_ties | table$class %in% c("S", "P")
  }
  if (o_0 < z$substitute_price && o_1 >= z$substitute_price &&
      is.finite(z$nu_SE) && nu == z$nu_SE) {
    payoff_ties <- payoff_ties | table$class %in% c("S", "E")
  }
  if (o_1 == z$substitute_price && is.finite(z$nu_SE) && nu >= z$nu_SE) {
    payoff_ties <- payoff_ties | table$class %in% c("E", "P")
  }
  if (o_0 == z$substitute_price && nu == 0) {
    payoff_ties <- payoff_ties | table$class %in% c("S", "E")
  }
  expected_H <- (1 - nu) * table$H_theta_0 + nu * table$H_theta_1
  minimum_H <- min(expected_H[payoff_ties])
  selected <- table[payoff_ties & expected_H == minimum_H, , drop = FALSE]
  if (o_1 == z$substitute_price && is.finite(z$nu_SE) && nu > z$nu_SE &&
      is.finite(z$nu_EP) && nu == z$nu_EP) {
    selected <- table[payoff_ties & table$class %in% c("E", "P"), , drop = FALSE]
  }
  selected <- selected[selected$class %in% c("E", "S", "P", "R"), , drop = FALSE]
  selected[order(selected$class, selected$k, selected$y), , drop = FALSE]
}
