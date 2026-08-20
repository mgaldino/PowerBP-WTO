#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

oracle_assert <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

oracle_as_character <- function(x) as.character(unlist(x, use.names = FALSE))

oracle_sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  oracle_assert(length(output) == 1L, paste("Could not hash", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  oracle_assert(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

oracle_validate_n1 <- function(n1, n1_hash, n1_path = NULL) {
  if (!is.null(n1_path)) {
    oracle_assert(
      identical(oracle_sha256_file(n1_path), sub("^sha256:", "", n1_hash)),
      "Oracle received bytes other than frozen N1."
    )
  }
  oracle_assert(identical(n1$schema_ref, "equilibrium_correspondence_v1"), "N1 schema changed.")
  oracle_assert(length(n1$correspondence_cells) == 1L, "N1 is not singleton.")
  record <- n1$correspondence_cells[[1L]]$equilibrium_records[[1L]]
  oracle_assert(identical(record$equilibrium_id, "N1-EQ-01"), "Wrong N1 record.")
  oracle_assert(identical(record$recognized_proposer_payoff, "1"), "Wrong N1 proposer value.")
  oracle_assert(
    identical(record$weak_nonproposer_pre_recognition_expected_value, "1/m"),
    "Wrong N1 weak continuation."
  )
  oracle_assert(
    identical(record$hegemon_payoff_by_type, list(theta_0 = "o_0", theta_1 = "o_1")),
    "Wrong N1 H continuation."
  )
  oracle_assert(
    identical(
      record$outcome_distribution,
      list(pass_with_hegemon = 0L, pass_without_hegemon = 1L, failure = 0L, delay = 0L)
    ),
    "Wrong N1 outcome."
  )
  oracle_assert(identical(record$payoff_date, "R2 current units"), "Wrong N1 payoff date.")
  invisible(TRUE)
}

oracle_values <- function(N, beta, o0, o1, nu) {
  m <- N - 1
  q <- floor(N / 2) + 1
  c_value <- beta / m
  e_value <- 1 - beta * (q - 1) / m
  l_value <- 1 - beta * o0 - beta * (q - 2) / m
  p_value <- 1 - beta * o1 - beta * (q - 2) / m
  s_value <- (1 - nu) * l_value + nu * c_value
  h_e <- (1 - nu) * o0 + nu * o1
  h_s <- beta * h_e
  h_p <- beta * o1
  h_r <- beta * h_e
  list(
    m = m,
    q = q,
    c = c_value,
    E = e_value,
    L = l_value,
    S = s_value,
    P = p_value,
    R = c_value,
    h = c(E = h_e, S = h_s, P = h_p, R = h_r)
  )
}

oracle_selected_branches <- function(N, beta, o0, o1, nu, tolerance = 1e-10) {
  value <- oracle_values(N, beta, o0, o1, nu)
  proposer <- c(E = value$E, S = value$S, P = value$P, R = value$R)
  feasible <- c(
    E = TRUE,
    S = beta * o0 + beta * (value$q - 2) / value$m <= 1 + tolerance,
    P = beta * o1 + beta * (value$q - 2) / value$m <= 1 + tolerance,
    R = TRUE
  )
  proposer[!feasible] <- -Inf
  maximum <- max(proposer)
  payoff_ties <- names(proposer)[abs(proposer - maximum) <= tolerance]
  minimum_h <- min(value$h[payoff_ties])
  sort(payoff_ties[abs(value$h[payoff_ties] - minimum_h) <= tolerance])
}

oracle_expected_cell <- function(N, beta, o0, o1, nu, tolerance = 1e-10) {
  m <- N - 1
  inverse_m <- 1 / m
  q <- floor(N / 2) + 1
  if (o1 < inverse_m - tolerance) {
    frontier <- beta * (o1 - o0) /
      (1 - beta * o0 - beta * (q - 1) / m)
    return(if (nu <= frontier + tolerance) "N3V3-CELL-O1LT-LOW" else "N3V3-CELL-O1LT-POOL")
  }
  if (abs(o1 - inverse_m) <= tolerance) {
    frontier <- beta * (inverse_m - o0) /
      (beta * (inverse_m - o0) + 1 - beta * q / m)
    if (nu <= frontier + tolerance) return("N3V3-CELL-O1EQ-LOW")
    h_e <- (1 - nu) * o0 + nu / m
    h_p <- beta / m
    if (h_e < h_p - tolerance) return("N3V3-CELL-O1EQ-EXCLUDE")
    if (h_p < h_e - tolerance) return("N3V3-CELL-O1EQ-POOL")
    return("N3V3-CELL-O1EQ-MIXED-EP")
  }
  if (o0 < inverse_m - tolerance && inverse_m < o1 - tolerance) {
    frontier <- beta * (inverse_m - o0) /
      (beta * (inverse_m - o0) + 1 - beta * q / m)
    return(if (nu <= frontier + tolerance) "N3V3-CELL-CROSS-LOW" else "N3V3-CELL-CROSS-EXCLUDE")
  }
  if (abs(o0 - inverse_m) <= tolerance) {
    return(if (nu <= tolerance) "N3V3-CELL-O0EQ-LOW-ENDPOINT" else "N3V3-CELL-O0EQ-EXCLUDE")
  }
  "N3V3-CELL-O0GT-EXCLUDE"
}

oracle_branch_from_cell <- function(cell_id) {
  if (grepl("MIXED-EP$", cell_id)) return("mixed_ep")
  if (grepl("LOW", cell_id)) return("low")
  if (grepl("POOL$", cell_id)) return("pool")
  if (grepl("EXCLUDE$", cell_id)) return("exclude")
  stop(paste("Unknown oracle cell:", cell_id), call. = FALSE)
}

oracle_expected_selected_set <- function(cell_id) {
  branch <- oracle_branch_from_cell(cell_id)
  switch(branch, low = "S", pool = "P", exclude = "E", mixed_ep = c("E", "P"))
}

oracle_vote_outcome <- function(N, beta, o_theta, y, weak_yes_count) {
  q <- floor(N / 2) + 1
  yes_if_h_yes <- 1 + weak_yes_count + 1
  yes_if_h_no <- 1 + weak_yes_count
  pass_if_yes <- yes_if_h_yes >= q
  pass_if_no <- yes_if_h_no >= q
  h_yes_payoff <- if (pass_if_yes) y else beta * o_theta
  h_no_payoff <- if (pass_if_no) y + o_theta else beta * o_theta
  if (h_yes_payoff > h_no_payoff) {
    h_vote <- "yes"
  } else if (h_no_payoff > h_yes_payoff) {
    h_vote <- "no"
  } else {
    h_vote <- "yes"
  }
  passes <- if (identical(h_vote, "yes")) pass_if_yes else pass_if_no
  list(
    h_vote = h_vote,
    passes = passes,
    with_h = passes && identical(h_vote, "yes"),
    without_h = passes && identical(h_vote, "no"),
    h_payoff = if (identical(h_vote, "yes")) h_yes_payoff else h_no_payoff
  )
}

oracle_weak_payoffs <- function(N, beta, x_j, other_yes_excluding_proposer_and_j) {
  m <- N - 1
  q <- floor(N / 2) + 1
  yes_count_if_yes <- 1 + other_yes_excluding_proposer_and_j + 1
  yes_count_if_no <- 1 + other_yes_excluding_proposer_and_j
  payoff_yes <- if (yes_count_if_yes >= q) x_j else beta / m
  payoff_no <- if (yes_count_if_no >= q) x_j else beta / m
  c(yes = payoff_yes, no = payoff_no)
}

oracle_stage_undominated_weak_vote <- function(N, beta, x_j) {
  profiles <- lapply(
    0:(N - 2),
    function(other_yes) oracle_weak_payoffs(N, beta, x_j, other_yes)
  )
  payoff_yes <- vapply(profiles, function(payoff) payoff[["yes"]], numeric(1))
  payoff_no <- vapply(profiles, function(payoff) payoff[["no"]], numeric(1))
  yes_dominates <- all(payoff_yes >= payoff_no) && any(payoff_yes > payoff_no)
  no_dominates <- all(payoff_no >= payoff_yes) && any(payoff_no > payoff_yes)
  if (yes_dominates) return("yes")
  if (no_dominates) return("no")
  oracle_assert(all(payoff_yes == payoff_no), "Weak actions are incomparable rather than genuinely tied.")
  "yes"
}

oracle_offer <- function(branch, N, beta, o0, o1) {
  m <- N - 1
  q <- floor(N / 2) + 1
  c_value <- beta / m
  if (identical(branch, "low")) {
    return(list(y = beta * o0, paid = q - 2, x = c_value, r = 1 - beta * o0 - beta * (q - 2) / m))
  }
  if (identical(branch, "pool")) {
    return(list(y = beta * o1, paid = q - 2, x = c_value, r = 1 - beta * o1 - beta * (q - 2) / m))
  }
  if (identical(branch, "exclude")) {
    return(list(y = 0, paid = q - 1, x = c_value, r = 1 - beta * (q - 1) / m))
  }
  stop("Mixed branch has two offer families.", call. = FALSE)
}

oracle_offer_semantics <- function(branch) {
  if (identical(branch, "low")) {
    return(list(
      payoff = "(1-nu)*(1-beta*o_0-beta*(q-2)/m)+nu*beta/m",
      family = "y=beta*o_0; x_j=beta/m iff j in K and x_j=0 otherwise; r_i=1-beta*o_0-beta*(q-2)/m.",
      coalition = "|K|=q-2"
    ))
  }
  if (identical(branch, "pool")) {
    return(list(
      payoff = "1-beta*o_1-beta*(q-2)/m",
      family = "y=beta*o_1; x_j=beta/m iff j in K and x_j=0 otherwise; r_i=1-beta*o_1-beta*(q-2)/m.",
      coalition = "|K|=q-2"
    ))
  }
  if (identical(branch, "exclude")) {
    return(list(
      payoff = "1-beta*(q-1)/m",
      family = "y=0; x_j=beta/m iff j in K and x_j=0 otherwise; r_i=1-beta*(q-1)/m.",
      coalition = "|K|=q-1"
    ))
  }
  list(
    payoff = "1-beta*(q-1)/m",
    family = "y=0",
    family_two = "y=beta/m",
    coalition = "exclusion uses |K|=q-1 and pooling uses |T|=q-2"
  )
}

oracle_weak_formula <- function(branch) {
  if (identical(branch, "low")) {
    return(paste0(
      "C_l=(1/m)*[(1-nu)*(1-beta*o_0-beta*(q-2)/m)+nu*beta/m] + ",
      "(1/m)*sum_{i in W, i!=l}{(1-nu)*(beta/m)*sum_{K subset W\\{i}, |K|=q-2, l in K}omega_{i,K} + nu*beta/m}; ",
      "for each i, omega_{i,K}>=0 and sum_{K subset W\\{i}, |K|=q-2}omega_{i,K}=1"
    ))
  }
  if (identical(branch, "pool")) {
    return(paste0(
      "C_l=(1/m)*[1-beta*o_1-beta*(q-2)/m] + ",
      "(1/m)*sum_{i in W, i!=l}{(beta/m)*sum_{K subset W\\{i}, |K|=q-2, l in K}omega_{i,K}}; ",
      "for each i, omega_{i,K}>=0 and sum_{K subset W\\{i}, |K|=q-2}omega_{i,K}=1"
    ))
  }
  if (identical(branch, "exclude")) {
    return(paste0(
      "C_l=(1/m)*[1-beta*(q-1)/m] + ",
      "(1/m)*sum_{i in W, i!=l}{(beta/m)*sum_{K subset W\\{i}, |K|=q-1, l in K}omega_{i,K}}; ",
      "for each i, omega_{i,K}>=0 and sum_{K subset W\\{i}, |K|=q-1}omega_{i,K}=1"
    ))
  }
  paste0(
    "C_l=(1/m)*[1-beta*(q-1)/m] + (1/m)*sum_{i in W, i!=l}{(beta/m)*[",
    "sum_{K subset W\\{i}, |K|=q-1, l in K}e_{i,K}+",
    "sum_{T subset W\\{i}, |T|=q-2, l in T}p_{i,T}]}; for each i all e and p are nonnegative and ",
    "sum_{K subset W\\{i}, |K|=q-1}e_{i,K}+sum_{T subset W\\{i}, |T|=q-2}p_{i,T}=1"
  )
}

oracle_h_and_outcome <- function(branch) {
  if (identical(branch, "low")) {
    return(list(
      h = list(theta_0 = "beta*o_0", theta_1 = "beta*o_1"),
      outcome = list(pass_with_hegemon = "1-nu", pass_without_hegemon = 0L, failure = 0L, delay = "nu")
    ))
  }
  if (identical(branch, "pool")) {
    return(list(
      h = list(theta_0 = "beta*o_1", theta_1 = "beta*o_1"),
      outcome = list(pass_with_hegemon = 1L, pass_without_hegemon = 0L, failure = 0L, delay = 0L)
    ))
  }
  if (identical(branch, "exclude")) {
    return(list(
      h = list(theta_0 = "o_0", theta_1 = "o_1"),
      outcome = list(pass_with_hegemon = 0L, pass_without_hegemon = 1L, failure = 0L, delay = 0L)
    ))
  }
  NULL
}

oracle_validate_record <- function(record, branch, n1_hash) {
  oracle_assert(
    identical(record$source_continuation_record_ids, list("N1-EQ-01")) &&
      identical(record$source_interface_hashes, list(N1 = n1_hash)),
    paste("Oracle found wrong N1 source in", record$equilibrium_id)
  )
  semantics <- oracle_offer_semantics(branch)
  oracle_assert(
    identical(record$recognized_proposer_payoff, semantics$payoff),
    paste("Oracle rejected proposer payoff in", record$equilibrium_id)
  )
  proposal <- record$strategy_profile$selected_proposal_parameterization
  oracle_assert(
    grepl(semantics$family, proposal$family, fixed = TRUE) &&
      identical(proposal$coalition_size, semantics$coalition),
    paste("Oracle rejected selected offer in", record$equilibrium_id)
  )
  if (identical(branch, "mixed_ep")) {
    oracle_assert(
      grepl(semantics$family_two, proposal$family, fixed = TRUE),
      "Oracle rejected the second mixed-cell offer."
    )
  }
  oracle_assert(
    identical(
      record$weak_nonproposer_pre_recognition_expected_value$by_weak_state_l,
      oracle_weak_formula(branch)
    ),
    paste("Oracle rejected identity-indexed weak map in", record$equilibrium_id)
  )
  if (!identical(branch, "mixed_ep")) {
    expected <- oracle_h_and_outcome(branch)
    oracle_assert(
      identical(record$hegemon_payoff_by_type, expected$h) &&
        identical(record$outcome_distribution, expected$outcome),
      paste("Oracle rejected H payoff or outcome in", record$equilibrium_id)
    )
  } else {
    mixed_text <- paste(
      c(
        oracle_as_character(record$hegemon_payoff_by_type),
        oracle_as_character(record$outcome_distribution)
      ),
      collapse = " "
    )
    oracle_assert(
      grepl("e_{i,K}", mixed_text, fixed = TRUE) &&
        grepl("p_{i,T}", mixed_text, fixed = TRUE) &&
        grepl("o_1=1/m", mixed_text, fixed = TRUE) &&
        grepl("add to 1", record$hegemon_payoff_by_type$theta_0, fixed = TRUE),
      "Oracle rejected mixed-cell H payoff/outcomes."
    )
  }

  belief <- record$belief_system
  oracle_assert(
    grepl("arbitrary ballot belief kappa_i(s) in [0,1]", belief$zero_weight_proposal, fixed = TRUE),
    paste("Oracle rejected proposal-stage off-path belief in", record$equilibrium_id)
  )
  oracle_assert(
    grepl("every nu in [0,1] including nu>0", belief$zero_probability_proposal_vote_vectors, fixed = TRUE) &&
      grepl("eta_i(s,v) in [0,1]", belief$zero_probability_proposal_vote_vectors, fixed = TRUE),
    paste("Oracle found incomplete proposal-vote posterior in", record$equilibrium_id)
  )
  if (identical(branch, "low")) {
    oracle_assert(
      grepl("posterior at 1", belief$published_vote_vector, fixed = TRUE) &&
        !grepl("posterior at 0", belief$published_vote_vector, fixed = TRUE),
      paste("Oracle rejected Bayes posterior after positive failure in", record$equilibrium_id)
    )
  }
  invisible(TRUE)
}

oracle_validate_candidate <- function(candidate, n1, n1_hash, n1_path = NULL) {
  oracle_validate_n1(n1, n1_hash, n1_path)
  oracle_assert(identical(candidate$schema_ref, "equilibrium_correspondence_v1"), "Wrong N3 schema.")
  oracle_assert(
    identical(candidate$function_of, list(name = "entry_belief", domain = "[0,1]")),
    "Wrong N3 function_of."
  )
  expected_cells <- c(
    "N3V3-CELL-O1LT-LOW",
    "N3V3-CELL-O1LT-POOL",
    "N3V3-CELL-CROSS-LOW",
    "N3V3-CELL-CROSS-EXCLUDE",
    "N3V3-CELL-O0GT-EXCLUDE",
    "N3V3-CELL-O0EQ-LOW-ENDPOINT",
    "N3V3-CELL-O0EQ-EXCLUDE",
    "N3V3-CELL-O1EQ-LOW",
    "N3V3-CELL-O1EQ-EXCLUDE",
    "N3V3-CELL-O1EQ-POOL",
    "N3V3-CELL-O1EQ-MIXED-EP"
  )
  actual_cells <- vapply(candidate$correspondence_cells, function(cell) cell$cell_id, character(1))
  oracle_assert(identical(actual_cells, expected_cells), "Oracle rejected the eleven-cell partition.")
  for (cell in candidate$correspondence_cells) {
    oracle_assert(
      identical(cell$existence_status, "exists") &&
        length(cell$equilibrium_records) == 1L &&
        is.null(cell$nonexistence_certificate),
      paste("Oracle rejected coverage envelope", cell$cell_id)
    )
    oracle_validate_record(
      cell$equilibrium_records[[1L]],
      oracle_branch_from_cell(cell$cell_id),
      n1_hash
    )
  }
  invisible(TRUE)
}

oracle_coalitions <- function(players, size) {
  if (size == 0L) return(list(integer(0)))
  matrix_value <- utils::combn(players, size)
  if (is.null(dim(matrix_value))) return(list(as.integer(matrix_value)))
  lapply(seq_len(ncol(matrix_value)), function(column) matrix_value[, column])
}

oracle_weights <- function(coalitions) {
  raw <- seq_along(coalitions)^2
  raw / sum(raw)
}

oracle_direct_weak_values <- function(branch, N, beta, o0, o1, nu) {
  m <- N - 1
  q <- floor(N / 2) + 1
  c_value <- beta / m
  result <- numeric(m)
  for (proposer in seq_len(m)) {
    others <- setdiff(seq_len(m), proposer)
    size <- if (identical(branch, "exclude")) q - 1 else q - 2
    coalitions <- oracle_coalitions(others, size)
    weights <- oracle_weights(coalitions)
    offer <- oracle_offer(branch, N, beta, o0, o1)
    for (weak_state in seq_len(m)) {
      if (weak_state == proposer) {
        payoff <- if (identical(branch, "low")) {
          (1 - nu) * offer$r + nu * c_value
        } else {
          offer$r
        }
      } else {
        payoff <- 0
        for (index in seq_along(coalitions)) {
          included <- weak_state %in% coalitions[[index]]
          state_zero <- if (included) c_value else 0
          state_one <- if (identical(branch, "low")) c_value else state_zero
          payoff <- payoff + weights[[index]] * ((1 - nu) * state_zero + nu * state_one)
        }
      }
      result[[weak_state]] <- result[[weak_state]] + payoff / m
    }
  }
  result
}

oracle_closed_weak_values <- function(branch, N, beta, o0, o1, nu) {
  m <- N - 1
  q <- floor(N / 2) + 1
  c_value <- beta / m
  offer <- oracle_offer(branch, N, beta, o0, o1)
  result <- numeric(m)
  for (weak_state in seq_len(m)) {
    proposer_component <- if (identical(branch, "low")) {
      (1 - nu) * offer$r + nu * c_value
    } else {
      offer$r
    }
    value <- proposer_component / m
    for (proposer in setdiff(seq_len(m), weak_state)) {
      others <- setdiff(seq_len(m), proposer)
      size <- if (identical(branch, "exclude")) q - 1 else q - 2
      coalitions <- oracle_coalitions(others, size)
      weights <- oracle_weights(coalitions)
      inclusion <- sum(weights[vapply(coalitions, function(group) weak_state %in% group, logical(1))])
      nonproposer <- if (identical(branch, "low")) {
        (1 - nu) * c_value * inclusion + nu * c_value
      } else {
        c_value * inclusion
      }
      value <- value + nonproposer / m
    }
    result[[weak_state]] <- value
  }
  result
}

oracle_run_stress <- function(draws = 50000L) {
  for (N in 3:30) {
    m <- N - 1
    q <- floor(N / 2) + 1
    oracle_assert(q <= m, "Majority quota exceeds weak states.")
    for (beta in c(0.01, 0.2, 0.5, 0.9, 0.999999)) {
      oracle_assert(1 - beta * q / m > 0, "Strict beta failed to make exclusion dominate delay.")
      for (x_j in c(0, beta / m - 1e-9, beta / m, beta / m + 1e-9, 1)) {
        if (x_j < 0) next
        expected <- if (x_j + 1e-12 >= beta / m) "yes" else "no"
        oracle_assert(
          identical(oracle_stage_undominated_weak_vote(N, beta, x_j), expected),
          "Enumerated stage game violates the beta/m weak cutoff."
        )
        for (other_yes in 0:(N - 2)) {
          payoff <- oracle_weak_payoffs(N, beta, x_j, other_yes)
          oracle_assert(
            all(is.finite(payoff)) && length(payoff) == 2L,
            "A simultaneous weak-vote profile lacks a payoff."
          )
        }
      }
      for (o_theta in c(0.01, 0.25, 0.75, 0.99)) {
        for (weak_yes in 0:(m - 1)) {
          for (y in unique(c(0, beta * o_theta / 2, beta * o_theta, min(1, beta * o_theta + 0.1)))) {
            ballot <- oracle_vote_outcome(N, beta, o_theta, y, weak_yes)
            if (weak_yes >= q - 1) {
              oracle_assert(identical(ballot$h_vote, "no") && ballot$without_h, "Nonpivotal H branch failed.")
            } else if (weak_yes == q - 2) {
              expected_vote <- if (y + 1e-12 >= beta * o_theta) "yes" else "no"
              oracle_assert(identical(ballot$h_vote, expected_vote), "Pivotal H cutoff failed.")
            } else {
              oracle_assert(identical(ballot$h_vote, "yes") && !ballot$passes, "Inevitable-failure H branch failed.")
            }
          }
        }
      }
    }
  }

  set.seed(20260819)
  for (iteration in seq_len(draws)) {
    N <- sample(3:60, 1L)
    beta <- stats::runif(1L, 0.0001, 0.9999)
    outside <- sort(stats::runif(2L, 0.0001, 0.9999))
    if (outside[[1L]] == outside[[2L]]) next
    o0 <- outside[[1L]]
    o1 <- outside[[2L]]
    nu <- stats::runif(1L)
    expected_cell <- oracle_expected_cell(N, beta, o0, o1, nu)
    expected_set <- sort(oracle_expected_selected_set(expected_cell))
    optimized <- oracle_selected_branches(N, beta, o0, o1, nu)
    oracle_assert(identical(expected_set, optimized), "Oracle region disagrees with direct argmax.")
    values <- oracle_values(N, beta, o0, o1, nu)
    oracle_assert(
      abs((values$P - values$E) - beta * (1 / values$m - o1)) < 1e-12,
      "P-E identity failed."
    )
    oracle_assert(
      abs((values$S - values$E) -
        ((1 - nu) * beta * (1 / values$m - o0) - nu * (1 - beta * values$q / values$m))) < 1e-12,
      "S-E identity failed."
    )
  }

  fixtures <- list(
    list(N = 9L, beta = 0.8, o0 = 0.03, o1 = 0.08),
    list(N = 9L, beta = 0.8, o0 = 0.08, o1 = 0.2)
  )
  for (fixture in fixtures) {
    N <- fixture$N
    m <- N - 1
    q <- floor(N / 2) + 1
    beta <- fixture$beta
    o0 <- fixture$o0
    o1 <- fixture$o1
    frontier <- if (o1 < 1 / m) {
      beta * (o1 - o0) / (1 - beta * o0 - beta * (q - 1) / m)
    } else {
      beta * (1 / m - o0) / (beta * (1 / m - o0) + 1 - beta * q / m)
    }
    oracle_assert(frontier > 0 && frontier < 1, "Frontier left the interior.")
    oracle_assert(identical(oracle_selected_branches(N, beta, o0, o1, frontier), "S"), "Closed frontier lost low branch.")
  }

  N <- 9L
  m <- N - 1
  q <- floor(N / 2) + 1
  beta <- 0.8
  o0_low <- 0.03
  o1_low <- 0.08
  nu_sp <- beta * (o1_low - o0_low) /
    (1 - beta * o0_low - beta * (q - 1) / m)
  oracle_assert(
    identical(oracle_expected_cell(N, beta, o0_low, o1_low, nu_sp), "N3V3-CELL-O1LT-LOW") &&
      identical(oracle_expected_cell(N, beta, o0_low, o1_low, min(1, nu_sp + 1e-6)), "N3V3-CELL-O1LT-POOL"),
    "nu_SP boundary ownership failed."
  )

  o0_cross <- 0.08
  o1_cross <- 0.2
  nu_se_cross <- beta * (1 / m - o0_cross) /
    (beta * (1 / m - o0_cross) + 1 - beta * q / m)
  oracle_assert(
    identical(oracle_expected_cell(N, beta, o0_cross, o1_cross, nu_se_cross), "N3V3-CELL-CROSS-LOW") &&
      identical(oracle_expected_cell(N, beta, o0_cross, o1_cross, min(1, nu_se_cross + 1e-6)), "N3V3-CELL-CROSS-EXCLUDE"),
    "nu_SE boundary ownership failed."
  )
  oracle_assert(
    identical(oracle_expected_cell(N, beta, 0.2, 0.3, 0), "N3V3-CELL-O0GT-EXCLUDE") &&
      identical(oracle_expected_cell(N, beta, 0.2, 0.3, 1), "N3V3-CELL-O0GT-EXCLUDE"),
    "Strict o_0>1/m endpoint coverage failed."
  )
  oracle_assert(
    identical(oracle_expected_cell(N, beta, 1 / m, 0.2, 0), "N3V3-CELL-O0EQ-LOW-ENDPOINT") &&
      identical(oracle_expected_cell(N, beta, 1 / m, 0.2, 1), "N3V3-CELL-O0EQ-EXCLUDE"),
    "o_0=1/m endpoint coverage failed."
  )

  o0_equal <- 0.08
  o1_equal <- 1 / m
  nu_se_equal <- beta * (1 / m - o0_equal) /
    (beta * (1 / m - o0_equal) + 1 - beta * q / m)
  nu_h <- (beta / m - o0_equal) / (1 / m - o0_equal)
  oracle_assert(nu_se_equal < nu_h && nu_h < 1, "Residual E/P tie is outside its cell.")
  oracle_assert(
    identical(oracle_expected_cell(N, beta, o0_equal, o1_equal, nu_se_equal), "N3V3-CELL-O1EQ-LOW") &&
      identical(oracle_expected_cell(N, beta, o0_equal, o1_equal, (nu_se_equal + nu_h) / 2), "N3V3-CELL-O1EQ-EXCLUDE") &&
      identical(oracle_expected_cell(N, beta, o0_equal, o1_equal, nu_h), "N3V3-CELL-O1EQ-MIXED-EP") &&
      identical(oracle_expected_cell(N, beta, o0_equal, o1_equal, (nu_h + 1) / 2), "N3V3-CELL-O1EQ-POOL"),
    "o_1=1/m low/exclusion/mixed/pooling coverage failed."
  )

  for (branch in c("low", "pool", "exclude")) {
    direct <- oracle_direct_weak_values(branch, 9L, 0.8, 0.04, 0.2, 0.37)
    closed <- oracle_closed_weak_values(branch, 9L, 0.8, 0.04, 0.2, 0.37)
    oracle_assert(max(abs(direct - closed)) < 1e-12, paste("Weak identity map failed for", branch))
  }

  o0 <- o0_equal
  o1 <- o1_equal
  pooling_share <- mean(c(0, 0.1, 0.25, 0.4, 0.6, 0.75, 0.9, 1))
  exclusion_share <- 1 - pooling_share
  h0 <- exclusion_share * o0 + pooling_share * beta / m
  h1 <- exclusion_share * o1 + pooling_share * beta / m
  expected_h <- (1 - nu_h) * h0 + nu_h * h1
  oracle_assert(abs(expected_h - beta / m) < 1e-12, "Mixed-cell expected H is not invariant.")
  oracle_assert(abs(pooling_share + exclusion_share - 1) < 1e-12, "Mixed outcomes do not sum to one.")
  invisible(TRUE)
}

oracle_direct_execution <- function() {
  script_arguments <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  length(script_arguments) == 1L &&
    identical(basename(sub("^--file=", "", script_arguments)), "oracle_essential_input_n3_v3.R")
}

oracle_main <- function() {
  script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  oracle_assert(length(script_argument) == 1L, "Could not resolve oracle path.")
  script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
  repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
  candidate_path <- file.path(
    repository_root,
    "model_redesign",
    "essential_input_interfaces",
    "n3_r1_majority_candidate_v3.json"
  )
  n1_path <- file.path(
    repository_root,
    "model_redesign",
    "essential_input_interfaces",
    "n1_r2_majority_candidate_v1.json"
  )
  n1_hash <- "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
  oracle_assert(file.exists(candidate_path) && file.exists(n1_path), "Oracle input missing.")
  candidate <- jsonlite::fromJSON(candidate_path, simplifyVector = FALSE)
  n1 <- jsonlite::fromJSON(n1_path, simplifyVector = FALSE)
  oracle_validate_candidate(candidate, n1, n1_hash, n1_path)
  oracle_run_stress()
  cat("PASS: independent N3 v3 algebraic oracle reconstructed N1 transport, ballots, offers, regions, identity maps, H payoffs, outcomes, and boundaries.\n")
}

if (oracle_direct_execution()) oracle_main()
