#!/usr/bin/env Rscript

# Oracle independente do ballot de R1 sob unanimidade para N4 v3.
#
# Este arquivo não constrói a interface candidata. Ele avalia assessments
# diretamente a partir das primitivas do Gate 0 e dos dois registros congelados
# de N2. Em particular, distingue:
#   1. o valor subjetivo de continuação do weak voter na história pública;
#   2. o payoff realizado, por tipo, de um weak state que chega a R2; e
#   3. o payoff de continuação de H por tipo.

n4v3_stop <- function(message) {
  stop(message, call. = FALSE)
}

n4v3_assert <- function(condition, message) {
  if (!isTRUE(condition)) {
    n4v3_stop(message)
  }
}

n4v3_close <- function(x, y, tolerance = 1e-10) {
  isTRUE(abs(x - y) <= tolerance)
}

n4v3_check_probability <- function(x, name, tolerance = 1e-10) {
  n4v3_assert(
    is.numeric(x) && length(x) == 1L && is.finite(x) &&
      x >= -tolerance && x <= 1 + tolerance,
    paste0(name, " must be a scalar in [0,1].")
  )
  min(1, max(0, as.numeric(x)))
}

n4v3_validate_primitives <- function(primitives, tolerance = 1e-10) {
  required <- c("m", "beta", "o0", "o1", "y_bar")
  n4v3_assert(
    is.list(primitives) && identical(sort(names(primitives)), sort(required)),
    "Primitives must contain exactly m, beta, o0, o1, and y_bar."
  )
  m <- primitives$m
  beta <- primitives$beta
  o0 <- primitives$o0
  o1 <- primitives$o1
  y_bar <- primitives$y_bar
  n4v3_assert(
    is.numeric(m) && length(m) == 1L && is.finite(m) &&
      n4v3_close(m, round(m), tolerance) && m >= 2,
    "m must be an integer at least two."
  )
  n4v3_assert(
    is.numeric(beta) && length(beta) == 1L && is.finite(beta) &&
      beta > 0 && beta < 1,
    "beta must lie strictly between zero and one."
  )
  n4v3_assert(
    is.numeric(o0) && is.numeric(o1) && is.numeric(y_bar) &&
      length(o0) == 1L && length(o1) == 1L && length(y_bar) == 1L &&
      is.finite(o0) && is.finite(o1) && is.finite(y_bar) &&
      o0 > 0 && o0 < o1 && o1 < 1 && o1 <= y_bar && y_bar <= 1,
    "The primitive domain requires 0 < o0 < o1 < 1 and o1 <= y_bar <= 1."
  )
  list(m = as.integer(round(m)), beta = beta, o0 = o0, o1 = o1, y_bar = y_bar)
}

n4v3_derived_primitives <- function(primitives) {
  p <- n4v3_validate_primitives(primitives)
  list(
    m = p$m,
    beta = p$beta,
    o0 = p$o0,
    o1 = p$o1,
    y_bar = p$y_bar,
    nu_star = (p$o1 - p$o0) / (1 - p$o0),
    ell = p$beta * p$o0,
    h = p$beta * p$o1,
    A = p$beta * (1 - p$o0) / p$m,
    B = p$beta * (1 - p$o1) / p$m
  )
}

n4v3_n2_continuation <- function(primitives, posterior) {
  d <- n4v3_derived_primitives(primitives)
  eta <- n4v3_check_probability(posterior, "posterior")
  if (eta <= d$nu_star) {
    list(
      record_id = "N2-EQ-LOW-TYPE-ONLY",
      posterior = eta,
      weak_subjective_value = d$A * (1 - eta),
      weak_realized_by_type = c(theta_0 = d$A, theta_1 = 0),
      hegemon_by_type = c(theta_0 = d$ell, theta_1 = d$h)
    )
  } else {
    list(
      record_id = "N2-EQ-POOLING",
      posterior = eta,
      weak_subjective_value = d$B,
      weak_realized_by_type = c(theta_0 = d$B, theta_1 = d$B),
      hegemon_by_type = c(theta_0 = d$h, theta_1 = d$h)
    )
  }
}

n4v3_enumerate_bits <- function(length_out) {
  n4v3_assert(length_out >= 0, "Bit-vector length must be nonnegative.")
  if (length_out == 0L) {
    return(matrix(logical(0), nrow = 1L, ncol = 0L))
  }
  values <- 0:(2^length_out - 1L)
  out <- lapply(
    values,
    function(value) as.logical(intToBits(value)[seq_len(length_out)])
  )
  do.call(rbind, out)
}

n4v3_vote_key <- function(votes) {
  paste0(ifelse(as.logical(votes), "Y", "N"), collapse = "")
}

n4v3_all_ballot_vectors <- function(m) {
  bits <- n4v3_enumerate_bits(m)
  colnames(bits) <- c("H", paste0("W", seq_len(m - 1L)))
  bits
}

n4v3_required_failure_keys <- function(m) {
  ballots <- n4v3_all_ballot_vectors(m)
  apply(ballots[!apply(ballots, 1L, all), , drop = FALSE], 1L, n4v3_vote_key)
}

n4v3_validate_proposal <- function(proposal, primitives, tolerance = 1e-10) {
  d <- n4v3_derived_primitives(primitives)
  required <- c("y", "x", "r")
  n4v3_assert(
    is.list(proposal) && identical(sort(names(proposal)), sort(required)),
    "Proposal must contain exactly y, x, and r."
  )
  n4v3_assert(
    is.numeric(proposal$y) && length(proposal$y) == 1L &&
      is.finite(proposal$y) && proposal$y >= -tolerance &&
      proposal$y <= d$y_bar + tolerance,
    "Proposal y violates feasibility."
  )
  n4v3_assert(
    is.numeric(proposal$x) && length(proposal$x) == d$m - 1L &&
      all(is.finite(proposal$x)) && all(proposal$x >= -tolerance),
    "Proposal x must contain one nonnegative payment per weak responder."
  )
  n4v3_assert(
    is.numeric(proposal$r) && length(proposal$r) == 1L &&
      is.finite(proposal$r) && proposal$r >= -tolerance,
    "Proposal r must be nonnegative."
  )
  n4v3_assert(
    proposal$y + sum(proposal$x) + proposal$r <= 1 + tolerance,
    "Proposal exceeds the unit pie."
  )
  list(y = proposal$y, x = proposal$x, r = proposal$r)
}

n4v3_validate_continuation_map <- function(map, primitives, tolerance = 1e-10) {
  d <- n4v3_derived_primitives(primitives)
  expected <- sort(n4v3_required_failure_keys(d$m))
  n4v3_assert(is.list(map) && !is.null(names(map)), "Continuation map must be a named list.")
  n4v3_assert(
    identical(sort(names(map)), expected),
    "Continuation map must contain every and only failing ballot vector."
  )
  normalized <- lapply(names(map), function(key) {
    state <- map[[key]]
    n4v3_assert(
      is.list(state) && identical(sort(names(state)), sort(c("record_id", "posterior"))),
      paste0("Continuation ", key, " must contain record_id and posterior.")
    )
    expected_state <- n4v3_n2_continuation(primitives, state$posterior)
    n4v3_assert(
      identical(state$record_id, expected_state$record_id),
      paste0("Continuation ", key, " uses a record inconsistent with its posterior.")
    )
    expected_state
  })
  names(normalized) <- names(map)
  normalized
}

n4v3_make_continuation_map <- function(primitives, posterior_by_key) {
  d <- n4v3_derived_primitives(primitives)
  expected <- n4v3_required_failure_keys(d$m)
  n4v3_assert(
    is.numeric(posterior_by_key) && !is.null(names(posterior_by_key)) &&
      identical(sort(names(posterior_by_key)), sort(expected)),
    "posterior_by_key must name every and only failing ballot vector."
  )
  out <- lapply(posterior_by_key, function(eta) {
    state <- n4v3_n2_continuation(primitives, eta)
    list(record_id = state$record_id, posterior = state$posterior)
  })
  names(out) <- names(posterior_by_key)
  out
}

n4v3_vector_from_actions <- function(h_vote, weak_votes) {
  c(as.logical(h_vote), as.logical(weak_votes))
}

n4v3_failure_state <- function(votes, continuation_map) {
  n4v3_assert(!all(votes), "A passing vector has no N2 continuation.")
  continuation_map[[n4v3_vote_key(votes)]]
}

n4v3_weak_payoff_at_vector <- function(votes, weak_index, proposal, continuation_map) {
  if (all(votes)) {
    return(proposal$x[[weak_index]])
  }
  n4v3_failure_state(votes, continuation_map)$weak_subjective_value
}

n4v3_hegemon_payoff_at_vector <- function(votes, theta, proposal, continuation_map) {
  if (all(votes)) {
    return(proposal$y)
  }
  key <- if (theta == 0L) "theta_0" else "theta_1"
  unname(n4v3_failure_state(votes, continuation_map)$hegemon_by_type[[key]])
}

n4v3_proposer_payoff_at_vector <- function(votes, theta, proposal, continuation_map) {
  if (all(votes)) {
    return(proposal$r)
  }
  key <- if (theta == 0L) "theta_0" else "theta_1"
  unname(n4v3_failure_state(votes, continuation_map)$weak_realized_by_type[[key]])
}

n4v3_weak_stage_table <- function(
    weak_index,
    proposal,
    continuation_map,
    primitives) {
  d <- n4v3_derived_primitives(primitives)
  n_weak <- d$m - 1L
  n4v3_assert(weak_index >= 1L && weak_index <= n_weak, "Invalid weak responder index.")
  other_weak <- setdiff(seq_len(n_weak), weak_index)
  other_profiles <- n4v3_enumerate_bits(length(other_weak) + 1L)
  rows <- vector("list", nrow(other_profiles))
  for (row_id in seq_len(nrow(other_profiles))) {
    h_vote <- other_profiles[row_id, 1L]
    weak_base <- rep(FALSE, n_weak)
    if (length(other_weak) > 0L) {
      weak_base[other_weak] <- other_profiles[row_id, -1L]
    }
    weak_yes <- weak_base
    weak_yes[[weak_index]] <- TRUE
    weak_no <- weak_base
    weak_no[[weak_index]] <- FALSE
    vector_yes <- n4v3_vector_from_actions(h_vote, weak_yes)
    vector_no <- n4v3_vector_from_actions(h_vote, weak_no)
    rows[[row_id]] <- data.frame(
      H = h_vote,
      other_weak_key = if (length(other_weak) == 0L) "" else
        n4v3_vote_key(weak_base[other_weak]),
      payoff_yes = n4v3_weak_payoff_at_vector(
        vector_yes, weak_index, proposal, continuation_map
      ),
      payoff_no = n4v3_weak_payoff_at_vector(
        vector_no, weak_index, proposal, continuation_map
      ),
      stringsAsFactors = FALSE
    )
  }
  do.call(rbind, rows)
}

n4v3_weak_undominated_actions <- function(stage_table, tolerance = 1e-10) {
  yes_ge_no <- all(stage_table$payoff_yes >= stage_table$payoff_no - tolerance)
  yes_gt_no <- any(stage_table$payoff_yes > stage_table$payoff_no + tolerance)
  no_ge_yes <- all(stage_table$payoff_no >= stage_table$payoff_yes - tolerance)
  no_gt_yes <- any(stage_table$payoff_no > stage_table$payoff_yes + tolerance)
  yes_dominates <- yes_ge_no && yes_gt_no
  no_dominates <- no_ge_yes && no_gt_yes
  n4v3_assert(!(yes_dominates && no_dominates), "Both actions cannot weakly dominate each other.")
  c(yes = !no_dominates, no = !yes_dominates)
}

n4v3_weak_sequential_payoffs <- function(
    weak_index,
    weak_votes,
    h_votes_by_type,
    ballot_belief,
    proposal,
    continuation_map) {
  lambda <- n4v3_check_probability(ballot_belief, "ballot_belief")
  weights <- c(theta_0 = 1 - lambda, theta_1 = lambda)
  payoffs <- c(yes = 0, no = 0)
  for (theta_name in names(weights)) {
    h_vote <- h_votes_by_type[[theta_name]]
    for (action_name in names(payoffs)) {
      trial <- weak_votes
      trial[[weak_index]] <- identical(action_name, "yes")
      vector <- n4v3_vector_from_actions(h_vote, trial)
      payoffs[[action_name]] <- payoffs[[action_name]] +
        weights[[theta_name]] * n4v3_weak_payoff_at_vector(
          vector, weak_index, proposal, continuation_map
        )
    }
  }
  payoffs
}

n4v3_best_response_actions <- function(payoffs, tolerance = 1e-10) {
  if (payoffs[["yes"]] > payoffs[["no"]] + tolerance) {
    return(c(yes = TRUE, no = FALSE))
  }
  if (payoffs[["no"]] > payoffs[["yes"]] + tolerance) {
    return(c(yes = FALSE, no = TRUE))
  }
  c(yes = TRUE, no = TRUE)
}

n4v3_expected_weak_action <- function(
    sequential_payoffs,
    undominated,
    tolerance = 1e-10) {
  best <- n4v3_best_response_actions(sequential_payoffs, tolerance)
  admissible <- best & undominated
  n4v3_assert(any(admissible), "No weak action survives PBE and stage-undominance.")
  if (isTRUE(admissible[["yes"]]) && isTRUE(admissible[["no"]])) {
    return(TRUE)
  }
  isTRUE(admissible[["yes"]])
}

n4v3_hegemon_action_payoffs <- function(
    theta,
    weak_votes,
    proposal,
    continuation_map) {
  yes_vector <- n4v3_vector_from_actions(TRUE, weak_votes)
  no_vector <- n4v3_vector_from_actions(FALSE, weak_votes)
  c(
    yes = n4v3_hegemon_payoff_at_vector(
      yes_vector, theta, proposal, continuation_map
    ),
    no = n4v3_hegemon_payoff_at_vector(
      no_vector, theta, proposal, continuation_map
    )
  )
}

n4v3_expected_h_action <- function(payoffs, tolerance = 1e-10) {
  if (payoffs[["yes"]] >= payoffs[["no"]] - tolerance) {
    TRUE
  } else {
    FALSE
  }
}

n4v3_bayes_requirements <- function(
    nu,
    weak_votes,
    h_votes_by_type,
    continuation_map,
    on_path_proposal,
    tolerance = 1e-10) {
  if (!isTRUE(on_path_proposal)) {
    return(list(valid = TRUE, required = list(), errors = character(0)))
  }
  prior <- n4v3_check_probability(nu, "nu")
  masses <- list()
  theta_weights <- c(theta_0 = 1 - prior, theta_1 = prior)
  theta_values <- c(theta_0 = 0, theta_1 = 1)
  for (theta_name in names(theta_weights)) {
    vector <- n4v3_vector_from_actions(h_votes_by_type[[theta_name]], weak_votes)
    if (all(vector) || theta_weights[[theta_name]] <= tolerance) {
      next
    }
    key <- n4v3_vote_key(vector)
    if (is.null(masses[[key]])) {
      masses[[key]] <- c(total = 0, high = 0)
    }
    masses[[key]][["total"]] <- masses[[key]][["total"]] + theta_weights[[theta_name]]
    masses[[key]][["high"]] <- masses[[key]][["high"]] +
      theta_weights[[theta_name]] * theta_values[[theta_name]]
  }
  errors <- character(0)
  required <- list()
  for (key in names(masses)) {
    eta <- masses[[key]][["high"]] / masses[[key]][["total"]]
    required[[key]] <- eta
    if (!n4v3_close(continuation_map[[key]]$posterior, eta, tolerance)) {
      errors <- c(
        errors,
        paste0("Bayes violation at positive-probability failure vector ", key, ".")
      )
    }
  }
  list(valid = length(errors) == 0L, required = required, errors = errors)
}

n4v3_evaluate_assessment <- function(assessment, tolerance = 1e-10) {
  required <- c(
    "primitives", "nu", "proposal", "weak_votes", "h_votes_by_type",
    "ballot_belief", "on_path_proposal", "continuation_map"
  )
  n4v3_assert(
    is.list(assessment) && identical(sort(names(assessment)), sort(required)),
    "Assessment fields are incomplete or contain unauthorized extras."
  )
  d <- n4v3_derived_primitives(assessment$primitives)
  nu <- n4v3_check_probability(assessment$nu, "nu")
  proposal <- n4v3_validate_proposal(assessment$proposal, assessment$primitives, tolerance)
  n4v3_assert(
    is.logical(assessment$weak_votes) &&
      length(assessment$weak_votes) == d$m - 1L &&
      !anyNA(assessment$weak_votes),
    "weak_votes must prescribe one pure action per weak responder."
  )
  h_votes <- assessment$h_votes_by_type
  n4v3_assert(
    is.logical(h_votes) && identical(names(h_votes), c("theta_0", "theta_1")) &&
      length(h_votes) == 2L && !anyNA(h_votes),
    "h_votes_by_type must be a named pure strategy for theta_0 and theta_1."
  )
  ballot_belief <- n4v3_check_probability(assessment$ballot_belief, "ballot_belief")
  n4v3_assert(
    is.logical(assessment$on_path_proposal) &&
      length(assessment$on_path_proposal) == 1L &&
      !is.na(assessment$on_path_proposal),
    "on_path_proposal must be a scalar logical."
  )
  if (isTRUE(assessment$on_path_proposal)) {
    n4v3_assert(
      n4v3_close(ballot_belief, nu, tolerance),
      "An on-path proposal by an uninformed weak proposer must preserve the entry prior."
    )
  }
  continuation_map <- n4v3_validate_continuation_map(
    assessment$continuation_map, assessment$primitives, tolerance
  )

  errors <- character(0)
  bayes <- n4v3_bayes_requirements(
    nu,
    assessment$weak_votes,
    h_votes,
    continuation_map,
    assessment$on_path_proposal,
    tolerance
  )
  errors <- c(errors, bayes$errors)

  h_diagnostics <- list()
  for (theta in 0:1) {
    theta_name <- if (theta == 0L) "theta_0" else "theta_1"
    payoffs <- n4v3_hegemon_action_payoffs(
      theta, assessment$weak_votes, proposal, continuation_map
    )
    expected <- n4v3_expected_h_action(payoffs, tolerance)
    prescribed <- h_votes[[theta_name]]
    h_diagnostics[[theta_name]] <- list(
      payoffs = payoffs,
      expected_yes = expected,
      prescribed_yes = prescribed
    )
    if (!identical(expected, prescribed)) {
      errors <- c(errors, paste0("H best-response/T^Y violation for ", theta_name, "."))
    }
  }

  weak_diagnostics <- vector("list", d$m - 1L)
  for (j in seq_len(d$m - 1L)) {
    table <- n4v3_weak_stage_table(
      j, proposal, continuation_map, assessment$primitives
    )
    undominated <- n4v3_weak_undominated_actions(table, tolerance)
    sequential <- n4v3_weak_sequential_payoffs(
      j,
      assessment$weak_votes,
      h_votes,
      ballot_belief,
      proposal,
      continuation_map
    )
    expected <- n4v3_expected_weak_action(sequential, undominated, tolerance)
    prescribed <- assessment$weak_votes[[j]]
    weak_diagnostics[[j]] <- list(
      stage_table = table,
      undominated = undominated,
      sequential_payoffs = sequential,
      expected_yes = expected,
      prescribed_yes = prescribed
    )
    if (!identical(expected, prescribed)) {
      errors <- c(
        errors,
        paste0("Weak responder ", j, " violates PBE/stage-undominance/T^Y.")
      )
    }
  }
  names(weak_diagnostics) <- paste0("W", seq_len(d$m - 1L))

  type_weights <- c(theta_0 = 1 - nu, theta_1 = nu)
  proposer_by_type <- c(theta_0 = NA_real_, theta_1 = NA_real_)
  hegemon_by_type <- c(theta_0 = NA_real_, theta_1 = NA_real_)
  pass_by_type <- c(theta_0 = FALSE, theta_1 = FALSE)
  for (theta in 0:1) {
    theta_name <- if (theta == 0L) "theta_0" else "theta_1"
    vector <- n4v3_vector_from_actions(h_votes[[theta_name]], assessment$weak_votes)
    pass_by_type[[theta_name]] <- all(vector)
    proposer_by_type[[theta_name]] <- n4v3_proposer_payoff_at_vector(
      vector, theta, proposal, continuation_map
    )
    hegemon_by_type[[theta_name]] <- n4v3_hegemon_payoff_at_vector(
      vector, theta, proposal, continuation_map
    )
  }
  proposer_expected <- sum(type_weights * proposer_by_type)
  pass_probability <- sum(type_weights * as.numeric(pass_by_type))

  list(
    valid = length(errors) == 0L,
    errors = unique(errors),
    bayes = bayes,
    h_diagnostics = h_diagnostics,
    weak_diagnostics = weak_diagnostics,
    payoffs = list(
      recognized_proposer_by_type = proposer_by_type,
      recognized_proposer_expected_true_prior = proposer_expected,
      hegemon_by_type = hegemon_by_type
    ),
    outcomes = list(
      pass_with_hegemon = pass_probability,
      pass_without_hegemon = 0,
      failure = 0,
      delay = 1 - pass_probability
    )
  )
}

n4v3_assert_valid_assessment <- function(assessment, tolerance = 1e-10) {
  result <- n4v3_evaluate_assessment(assessment, tolerance)
  n4v3_assert(result$valid, paste(result$errors, collapse = " | "))
  result
}
