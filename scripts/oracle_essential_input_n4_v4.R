#!/usr/bin/env Rscript

# Independent ballot kernel for N4 v4. It consumes primitives and frozen-N2
# continuation semantics only; it never reads or executes the N4 builder,
# candidate, ledger, verifier, or expected manifests.

n4v4_assert <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

n4v4_close <- function(x, y, tolerance = 1e-10) {
  isTRUE(length(x) == 1L && length(y) == 1L && is.finite(x) && is.finite(y) &&
           abs(x - y) <= tolerance)
}

n4v4_probability <- function(x, name, tolerance = 1e-10) {
  n4v4_assert(
    is.numeric(x) && length(x) == 1L && is.finite(x) &&
      x >= -tolerance && x <= 1 + tolerance,
    paste0(name, " must lie in [0,1].")
  )
  min(1, max(0, as.numeric(x)))
}

n4v4_primitives <- function(x, tolerance = 1e-10) {
  required <- c("m", "beta", "o0", "o1", "y_bar")
  n4v4_assert(is.list(x) && identical(sort(names(x)), sort(required)),
              "Primitives must contain exactly m,beta,o0,o1,y_bar.")
  n4v4_assert(is.numeric(x$m) && length(x$m) == 1L && is.finite(x$m) &&
                n4v4_close(x$m, round(x$m), tolerance) && x$m >= 2,
              "m must be an integer at least two.")
  n4v4_assert(is.numeric(x$beta) && length(x$beta) == 1L && is.finite(x$beta) &&
                x$beta > 0 && x$beta < 1, "beta must be in (0,1).")
  n4v4_assert(
    all(vapply(x[c("o0", "o1", "y_bar")], function(z) {
      is.numeric(z) && length(z) == 1L && is.finite(z)
    }, logical(1))) && x$o0 > 0 && x$o0 < x$o1 && x$o1 < 1 &&
      x$o1 <= x$y_bar && x$y_bar <= 1,
    "Outside options require 0<o0<o1<1 and o1<=y_bar<=1."
  )
  list(m = as.integer(round(x$m)), beta = x$beta, o0 = x$o0,
       o1 = x$o1, y_bar = x$y_bar)
}

n4v4_derived <- function(primitives) {
  p <- n4v4_primitives(primitives)
  list(
    m = p$m, beta = p$beta, o0 = p$o0, o1 = p$o1, y_bar = p$y_bar,
    nu_star = (p$o1 - p$o0) / (1 - p$o0),
    ell = p$beta * p$o0,
    h = p$beta * p$o1,
    A = p$beta * (1 - p$o0) / p$m,
    B = p$beta * (1 - p$o1) / p$m
  )
}

n4v4_n2_continuation <- function(primitives, posterior) {
  d <- n4v4_derived(primitives)
  eta <- n4v4_probability(posterior, "posterior")
  if (eta <= d$nu_star) {
    return(list(
      record_id = "N2-EQ-LOW-TYPE-ONLY", posterior = eta,
      weak_subjective = d$A * (1 - eta),
      weak_realized = c(theta_0 = d$A, theta_1 = 0),
      hegemon = c(theta_0 = d$ell, theta_1 = d$h)
    ))
  }
  list(
    record_id = "N2-EQ-POOLING", posterior = eta,
    weak_subjective = d$B,
    weak_realized = c(theta_0 = d$B, theta_1 = d$B),
    hegemon = c(theta_0 = d$h, theta_1 = d$h)
  )
}

n4v4_bits <- function(n) {
  n4v4_assert(n >= 0L, "Bit length must be nonnegative.")
  if (n == 0L) return(matrix(logical(0), nrow = 1L, ncol = 0L))
  do.call(rbind, lapply(0:(2^n - 1L), function(value) {
    as.logical(intToBits(value)[seq_len(n)])
  }))
}

n4v4_key <- function(votes) paste0(ifelse(votes, "Y", "N"), collapse = "")

n4v4_ballots <- function(m) {
  out <- n4v4_bits(m)
  colnames(out) <- c("H", paste0("W", seq_len(m - 1L)))
  out
}

n4v4_failure_keys <- function(m) {
  x <- n4v4_ballots(m)
  apply(x[!apply(x, 1L, all), , drop = FALSE], 1L, n4v4_key)
}

n4v4_make_map <- function(primitives, posterior_by_key) {
  expected <- sort(n4v4_failure_keys(n4v4_derived(primitives)$m))
  n4v4_assert(is.numeric(posterior_by_key) && !is.null(names(posterior_by_key)) &&
                identical(sort(names(posterior_by_key)), expected),
              "Posterior map must name every and only failure vector.")
  out <- lapply(posterior_by_key, function(eta) {
    state <- n4v4_n2_continuation(primitives, eta)
    list(record_id = state$record_id, posterior = state$posterior)
  })
  names(out) <- names(posterior_by_key)
  out
}

n4v4_validate_map <- function(map, primitives) {
  expected <- sort(n4v4_failure_keys(n4v4_derived(primitives)$m))
  n4v4_assert(is.list(map) && !is.null(names(map)) &&
                identical(sort(names(map)), expected),
              "Continuation map must contain every and only failure vector.")
  out <- lapply(names(map), function(key) {
    x <- map[[key]]
    n4v4_assert(is.list(x) && identical(sort(names(x)), c("posterior", "record_id")),
                paste0("Malformed continuation at ", key, "."))
    state <- n4v4_n2_continuation(primitives, x$posterior)
    n4v4_assert(identical(x$record_id, state$record_id),
                paste0("N2 record/posterior mismatch at ", key, "."))
    state
  })
  names(out) <- names(map)
  out
}

n4v4_proposal <- function(x, primitives, tolerance = 1e-10) {
  d <- n4v4_derived(primitives)
  n4v4_assert(is.list(x) && identical(sort(names(x)), c("r", "x", "y")),
              "Proposal must contain y,x,r.")
  n4v4_assert(is.numeric(x$y) && length(x$y) == 1L && is.finite(x$y) &&
                x$y >= -tolerance && x$y <= d$y_bar + tolerance,
              "Proposal y is infeasible.")
  n4v4_assert(is.numeric(x$x) && length(x$x) == d$m - 1L &&
                all(is.finite(x$x)) && all(x$x >= -tolerance),
              "Proposal x is infeasible.")
  n4v4_assert(is.numeric(x$r) && length(x$r) == 1L && is.finite(x$r) &&
                x$r >= -tolerance && x$y + sum(x$x) + x$r <= 1 + tolerance,
              "Proposal residual is infeasible.")
  list(y = x$y, x = x$x, r = x$r)
}

n4v4_vector <- function(h_vote, weak_votes) c(as.logical(h_vote), as.logical(weak_votes))

n4v4_state <- function(votes, continuation_map) {
  n4v4_assert(!all(votes), "Passing vectors have no continuation.")
  continuation_map[[n4v4_key(votes)]]
}

n4v4_weak_payoff <- function(votes, j, proposal, map) {
  if (all(votes)) proposal$x[[j]] else n4v4_state(votes, map)$weak_subjective
}

n4v4_H_payoff <- function(votes, theta, proposal, map) {
  if (all(votes)) return(proposal$y)
  unname(n4v4_state(votes, map)$hegemon[[if (theta == 0L) "theta_0" else "theta_1"]])
}

n4v4_proposer_payoff <- function(votes, theta, proposal, map) {
  if (all(votes)) return(proposal$r)
  unname(n4v4_state(votes, map)$weak_realized[[if (theta == 0L) "theta_0" else "theta_1"]])
}

n4v4_weak_stage_table <- function(j, proposal, map, primitives) {
  m <- n4v4_derived(primitives)$m
  weak_n <- m - 1L
  n4v4_assert(j >= 1L && j <= weak_n, "Invalid weak responder index.")
  others <- setdiff(seq_len(weak_n), j)
  profiles <- n4v4_bits(length(others) + 1L)
  rows <- lapply(seq_len(nrow(profiles)), function(row) {
    h <- profiles[row, 1L]
    base <- rep(FALSE, weak_n)
    if (length(others)) base[others] <- profiles[row, -1L]
    yes <- no <- base
    yes[[j]] <- TRUE
    no[[j]] <- FALSE
    data.frame(
      H = h,
      other_weak = if (length(others)) n4v4_key(base[others]) else "",
      yes = n4v4_weak_payoff(n4v4_vector(h, yes), j, proposal, map),
      no = n4v4_weak_payoff(n4v4_vector(h, no), j, proposal, map),
      stringsAsFactors = FALSE
    )
  })
  do.call(rbind, rows)
}

n4v4_undominated <- function(stage, tolerance = 1e-10) {
  yes_dominates <- all(stage$yes >= stage$no - tolerance) &&
    any(stage$yes > stage$no + tolerance)
  no_dominates <- all(stage$no >= stage$yes - tolerance) &&
    any(stage$no > stage$yes + tolerance)
  n4v4_assert(!(yes_dominates && no_dominates), "Mutual weak dominance is impossible.")
  c(yes = !no_dominates, no = !yes_dominates)
}

n4v4_weak_sequential <- function(j, weak_votes, h_votes, belief, proposal, map) {
  lambda <- n4v4_probability(belief, "ballot belief")
  weights <- c(theta_0 = 1 - lambda, theta_1 = lambda)
  out <- c(yes = 0, no = 0)
  for (theta_name in names(weights)) {
    for (action in names(out)) {
      trial <- weak_votes
      trial[[j]] <- action == "yes"
      votes <- n4v4_vector(h_votes[[theta_name]], trial)
      out[[action]] <- out[[action]] + weights[[theta_name]] *
        n4v4_weak_payoff(votes, j, proposal, map)
    }
  }
  out
}

n4v4_best <- function(payoffs, tolerance = 1e-10) {
  if (payoffs[["yes"]] > payoffs[["no"]] + tolerance) return(c(yes = TRUE, no = FALSE))
  if (payoffs[["no"]] > payoffs[["yes"]] + tolerance) return(c(yes = FALSE, no = TRUE))
  c(yes = TRUE, no = TRUE)
}

n4v4_weak_action <- function(sequential, undominated, tolerance = 1e-10) {
  admissible <- n4v4_best(sequential, tolerance) & undominated
  n4v4_assert(any(admissible), "No weak action survives PBE and stage-undominance.")
  if (all(admissible)) return(TRUE)
  isTRUE(admissible[["yes"]])
}

n4v4_H_action_payoffs <- function(theta, weak_votes, proposal, map) {
  c(
    yes = n4v4_H_payoff(n4v4_vector(TRUE, weak_votes), theta, proposal, map),
    no = n4v4_H_payoff(n4v4_vector(FALSE, weak_votes), theta, proposal, map)
  )
}

n4v4_H_action <- function(payoffs, tolerance = 1e-10) {
  payoffs[["yes"]] >= payoffs[["no"]] - tolerance
}

n4v4_bayes <- function(nu, weak_votes, h_votes, map, on_path, tolerance = 1e-10) {
  if (!isTRUE(on_path)) return(list(errors = character(0), required = list()))
  prior <- n4v4_probability(nu, "nu")
  weights <- c(theta_0 = 1 - prior, theta_1 = prior)
  high <- c(theta_0 = 0, theta_1 = 1)
  masses <- list()
  for (theta_name in names(weights)) {
    votes <- n4v4_vector(h_votes[[theta_name]], weak_votes)
    if (all(votes) || weights[[theta_name]] <= tolerance) next
    key <- n4v4_key(votes)
    if (is.null(masses[[key]])) masses[[key]] <- c(total = 0, high = 0)
    masses[[key]][["total"]] <- masses[[key]][["total"]] + weights[[theta_name]]
    masses[[key]][["high"]] <- masses[[key]][["high"]] + weights[[theta_name]] * high[[theta_name]]
  }
  required <- lapply(masses, function(x) x[["high"]] / x[["total"]])
  errors <- unlist(lapply(names(required), function(key) {
    if (n4v4_close(map[[key]]$posterior, required[[key]], tolerance)) character(0) else
      paste0("Bayes violation at ", key, ".")
  }), use.names = FALSE)
  list(errors = errors, required = required)
}

n4v4_evaluate <- function(assessment, tolerance = 1e-10) {
  required <- c("primitives", "nu", "proposal", "weak_votes", "h_votes_by_type",
                "ballot_belief", "on_path_proposal", "continuation_map")
  n4v4_assert(is.list(assessment) && identical(sort(names(assessment)), sort(required)),
              "Assessment fields are incomplete or contain extras.")
  d <- n4v4_derived(assessment$primitives)
  nu <- n4v4_probability(assessment$nu, "nu")
  proposal <- n4v4_proposal(assessment$proposal, assessment$primitives, tolerance)
  weak_votes <- assessment$weak_votes
  h_votes <- assessment$h_votes_by_type
  n4v4_assert(is.logical(weak_votes) && length(weak_votes) == d$m - 1L && !anyNA(weak_votes),
              "Weak ballots must be pure and complete.")
  n4v4_assert(is.logical(h_votes) && identical(names(h_votes), c("theta_0", "theta_1")) &&
                length(h_votes) == 2L && !anyNA(h_votes),
              "H ballots must be pure and type complete.")
  belief <- n4v4_probability(assessment$ballot_belief, "ballot belief")
  n4v4_assert(is.logical(assessment$on_path_proposal) &&
                length(assessment$on_path_proposal) == 1L && !is.na(assessment$on_path_proposal),
              "on_path_proposal must be logical.")
  if (assessment$on_path_proposal) {
    n4v4_assert(n4v4_close(belief, nu, tolerance), "On-path proposal belief must equal nu.")
  }
  map <- n4v4_validate_map(assessment$continuation_map, assessment$primitives)
  bayes <- n4v4_bayes(nu, weak_votes, h_votes, map, assessment$on_path_proposal, tolerance)
  errors <- bayes$errors

  H_diagnostics <- list()
  for (theta in 0:1) {
    name <- if (theta == 0L) "theta_0" else "theta_1"
    payoffs <- n4v4_H_action_payoffs(theta, weak_votes, proposal, map)
    expected <- n4v4_H_action(payoffs, tolerance)
    H_diagnostics[[name]] <- list(payoffs = payoffs, expected_yes = expected,
                                  prescribed_yes = h_votes[[name]])
    if (!identical(expected, h_votes[[name]])) {
      errors <- c(errors, paste0("H best-response/TY violation for ", name, "."))
    }
  }

  weak_diagnostics <- vector("list", d$m - 1L)
  for (j in seq_len(d$m - 1L)) {
    stage <- n4v4_weak_stage_table(j, proposal, map, assessment$primitives)
    undominated <- n4v4_undominated(stage, tolerance)
    sequential <- n4v4_weak_sequential(j, weak_votes, h_votes, belief, proposal, map)
    expected <- n4v4_weak_action(sequential, undominated, tolerance)
    weak_diagnostics[[j]] <- list(stage = stage, undominated = undominated,
                                  sequential = sequential, expected_yes = expected,
                                  prescribed_yes = weak_votes[[j]])
    if (!identical(expected, weak_votes[[j]])) {
      errors <- c(errors, paste0("Weak responder ", j, " violates PBE/UD/TY."))
    }
  }
  names(weak_diagnostics) <- paste0("W", seq_len(d$m - 1L))

  proposer <- H_payoff <- c(theta_0 = NA_real_, theta_1 = NA_real_)
  passed <- c(theta_0 = FALSE, theta_1 = FALSE)
  for (theta in 0:1) {
    name <- if (theta == 0L) "theta_0" else "theta_1"
    votes <- n4v4_vector(h_votes[[name]], weak_votes)
    passed[[name]] <- all(votes)
    proposer[[name]] <- n4v4_proposer_payoff(votes, theta, proposal, map)
    H_payoff[[name]] <- n4v4_H_payoff(votes, theta, proposal, map)
  }
  weights <- c(theta_0 = 1 - nu, theta_1 = nu)
  list(
    valid = !length(errors), errors = unique(errors), bayes = bayes,
    H_diagnostics = H_diagnostics, weak_diagnostics = weak_diagnostics,
    payoffs = list(
      proposer_by_type = proposer,
      proposer_expected_true_prior = sum(weights * proposer),
      hegemon_by_type = H_payoff
    ),
    outcomes = list(
      pass_with_hegemon = sum(weights * as.numeric(passed)),
      pass_without_hegemon = 0, failure = 0,
      delay = 1 - sum(weights * as.numeric(passed))
    )
  )
}

n4v4_assert_valid <- function(assessment, tolerance = 1e-10) {
  result <- n4v4_evaluate(assessment, tolerance)
  n4v4_assert(result$valid, paste(result$errors, collapse = " | "))
  result
}

n4v4_multiveto_bound <- function(primitives, nu, veto_payments, on_path = TRUE,
                                  tolerance = 1e-10) {
  d <- n4v4_derived(primitives)
  prior <- n4v4_probability(nu, "nu")
  n4v4_assert(d$m >= 3L, "Multi-veto bound requires m>=3.")
  n4v4_assert(is.numeric(veto_payments) && length(veto_payments) >= 2L &&
                length(veto_payments) <= d$m - 1L && all(is.finite(veto_payments)) &&
                all(veto_payments >= -tolerance),
              "veto_payments must contain every and only designated veto payment.")
  if (!isTRUE(on_path) || prior < d$nu_star - tolerance) {
    return(list(valid = TRUE, bound = "feasibility_only", B = d$B))
  }
  list(
    valid = all(veto_payments <= d$B + tolerance),
    bound = "each_veto_payment_at_most_B", B = d$B
  )
}

n4v4_high_multiveto_map <- function(primitives, nu, veto_indices) {
  d <- n4v4_derived(primitives)
  prior <- n4v4_probability(nu, "nu")
  n4v4_assert(d$m >= 3L && prior >= d$nu_star,
              "High/frontier multi-veto witness requires m>=3 and nu>=nu_star.")
  veto_indices <- sort(unique(as.integer(veto_indices)))
  n4v4_assert(length(veto_indices) >= 2L && all(veto_indices >= 1L) &&
                all(veto_indices <= d$m - 1L), "Invalid designated veto set.")
  actual_weak <- rep(TRUE, d$m - 1L)
  actual_weak[veto_indices] <- FALSE
  actual_key <- n4v4_key(n4v4_vector(TRUE, actual_weak))
  keys <- n4v4_failure_keys(d$m)
  eta <- vapply(keys, function(key) {
    votes <- strsplit(key, "", fixed = TRUE)[[1L]]
    if (identical(key, actual_key)) return(prior)
    if (votes[[1L]] == "Y") return(1)
    weak_no <- which(votes[-1L] == "N")
    if (identical(weak_no, veto_indices)) 0 else 1
  }, numeric(1))
  n4v4_make_map(primitives, setNames(eta, keys))
}
