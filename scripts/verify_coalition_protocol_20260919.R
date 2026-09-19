#!/usr/bin/env Rscript
# Numerical complements to the adopted coalition proofs; not a proof certificate.
# Run from the repository root. Outputs are confined to this candidate's checks/.
options(encoding = "UTF-8")
out <- "quality_reports/coalition_protocol_2026-09-19/checks"
dir.create(out, recursive = TRUE, showWarnings = FALSE)
stopifnot(file.exists("formal_model_v6.Rmd"))
tol <- 1e-10
counts <- list()
record <- function(name, n, scope) {
  counts[[name]] <<- data.frame(check = name, cases = n, scope = scope)
}
coalitions <- function(n, proposer, quota) {
  Filter(function(C) proposer %in% C && length(C) >= quota,
         unlist(lapply(seq_len(n), function(s) combn(seq_len(n), s, simplify = FALSE)),
                recursive = FALSE))
}
simplex_grid <- function(n, budget = 4L) {
  if (n == 1L) return(matrix(0:budget, ncol = 1L))
  do.call(rbind, lapply(0:budget, function(a) {
    cbind(a, simplex_grid(n - 1L, budget - a))
  }))
}
ballots <- function(n) as.matrix(expand.grid(rep(list(c(FALSE, TRUE)), n)))

# Exhaust all coalition/allocation/ballot combinations on a small rational grid.
# Player 1 is H; player 2 is the weak proposer. No behavioral restrictions here.
n_terminal <- n_h_reject_positive <- 0L
for (m in 3:5) for (quota in unique(c(floor((m + 1) / 2) + 1L, m + 1L))) {
  n <- m + 1L
  for (C in coalitions(n, 2L, quota)) {
    allocations <- simplex_grid(length(C)) / 4
    invited <- setdiff(C, 2L)
    vv <- ballots(length(invited))
    for (a in seq_len(nrow(allocations))) {
      x <- numeric(n); x[C] <- allocations[a, ]
      for (v in seq_len(nrow(vv))) {
        pass <- all(vv[v, ])
        outside_H <- pass && !(1L %in% C)
        H_share_paid <- if (pass && 1L %in% C) x[1L] else 0
        H_outside_paid <- if (outside_H || !pass) .35 else 0
        stopifnot(!(H_share_paid > 0 && H_outside_paid > 0))
        if (pass) {
          stopifnot(sum(x) <= 1 + tol)
          if (outside_H) stopifnot(x[1L] == 0)
        }
        if (1L %in% invited && x[1L] > 0 && !vv[v, match(1L, invited)]) {
          stopifnot(!pass)
          n_h_reject_positive <- n_h_reject_positive + 1L
        }
        n_terminal <- n_terminal + 1L
      }
    }
  }
}
record("all_feasible_grid_histories", n_terminal,
       "m=3:5; all invited coalitions, quarter-pie allocations and pure ballots; includes irrational deviations")
record("positive_H_offer_rejected", n_h_reject_positive,
       "All such grid histories fail the complete package, including oversized C")

# A generic proposal evaluator uses coalition membership and all-invitee consent.
# It does not classify proposals into E/S/P.
proposal_value <- function(C, x, m, beta, ell, high, prior, round = 1L) {
  invited <- setdiff(C, 2L)
  weak <- setdiff(invited, 1L)
  weak_reserve <- if (round == 1L) beta / m else 0
  weak_yes <- all(x[weak] + tol >= weak_reserve)
  type_values <- vapply(c(ell, high), function(o) {
    H_yes <- !(1L %in% C) || (x[1L] + tol >= if (round == 1L) beta * o else o)
    pass <- weak_yes && H_yes
    if (pass) x[2L] else if (round == 1L) beta / m else 0
  }, numeric(1))
  sum(c(1 - prior, prior) * type_values)
}

comparison_rows <- list(); total_proposals <- 0L; case_no <- 0L
for (m in 3:5) for (beta in c(.2, .9, .999)) {
  k <- floor((m + 1) / 2); w <- beta / m
  type_pairs <- rbind(c(.05, .15), c(.1, 1 / m), c(1 / m, .7), c(.1, .7), c(.5, .8))
  for (pair in seq_len(nrow(type_pairs))) {
    ell <- type_pairs[pair, 1]; high <- type_pairs[pair, 2]
    priors <- c(0, .01, .3, .8, 1)
    if (ell < 1 / m) {
      priors <- c(priors, beta * (1 / m - ell) /
                    (beta * (1 / m - ell) + 1 - beta * (k + 1) / m))
    }
    if (high <= 1 / m) {
      priors <- c(priors, beta * (high - ell) / (1 - beta * ell - beta * k / m))
    }
    # Build every coalition and a price grid including underpayment, equality,
    # overpayment, surplus members, intermediate H offers and certain failure.
    candidates <- list()
    for (C in coalitions(m + 1L, 2L, k + 1L)) {
      weak <- setdiff(C, c(1L, 2L))
      grid_w <- as.matrix(expand.grid(rep(list(c(0, w / 2, w, min(1, w + .03))), length(weak))))
      grid_h <- if (1L %in% C) unique(c(0, beta * ell / 2, beta * ell,
                     beta * (ell + high) / 2, beta * high, min(1, beta * high + .03))) else 0
      for (wh in grid_h) for (row in seq_len(nrow(grid_w))) {
        x <- numeric(m + 1L); x[1L] <- wh; x[weak] <- grid_w[row, ]
        if (sum(x) > 1 + tol) next
        x[2L] <- 1 - sum(x)
        candidates[[length(candidates) + 1L]] <- list(C = C, x = x)
      }
    }
    for (prior in unique(priors)) {
      generic <- vapply(candidates, function(y) proposal_value(y$C, y$x, m, beta, ell, high, prior), numeric(1))
      E <- 1 - k * w
      S <- (1 - prior) * (1 - (k - 1) * w - beta * ell) + prior * w
      P <- 1 - (k - 1) * w - beta * high
      predicted <- max(E, S, P)
      stopifnot(abs(max(generic) - predicted) < tol, E > w)
      case_no <- case_no + 1L
      comparison_rows[[case_no]] <- data.frame(m, beta, ell, high, prior,
               proposals = length(generic), direct_max = max(generic), formula_max = predicted)
      total_proposals <- total_proposals + length(generic)
    }
  }
}
comparison <- do.call(rbind, comparison_rows)
write.csv(comparison, file.path(out, "r1_direct_proposal_grid.csv"), row.names = FALSE)
record("R1_majority_direct_proposals", total_proposals,
       paste(nrow(comparison), "parameter/prior cases; all feasible coalitions; finite price grid versus analytic maximum"))

# At the forcing unanimity offer every weak state accepts under every admissible
# posterior. Enumerate the four H profiles directly from their deviations.
u_cases <- 0L
for (m in 3:6) for (beta in c(.2, .9, .999)) for (ell in c(.02, .1, .4)) {
  high <- (1 + ell) / 2; pstar <- (high - ell) / (1 - ell)
  for (p in c(pstar / 100, pstar / 2, pstar)) {
    offer <- beta * ell
    high_reject <- beta * high
    low_NN <- beta * ell
    low_imitate_high <- beta * high
    high_imitate_low <- beta * high
    stopifnot(high_reject > offer, low_NN == offer,
              low_imitate_high > offer, high_imitate_low > offer,
              1 - offer - (m - 1) * beta * (1 - ell) / m > 0)
    u_cases <- u_cases + 1L
  }
}
record("U_forcing_offer_four_profiles", u_cases * 4L,
       "Four incentive obstructions, including T^Y equality, at 108 interior parameter cases")

# Concrete informative coalition example supplied by the new agenda derivation.
# The same allocation can pass for the low type's coalition and fail for the
# high type's coalition. Both remain feasible messages.
m <- 4L; beta <- .9; ell <- .1; high <- .9; k <- 2L
x <- c(.55, .225, .225, 0, 0)
C_low <- c(1L, 2L, 3L); C_high <- c(1L, 2L, 3L, 4L)
r0 <- beta * (1 - beta * ell) / m
r1 <- beta / m
pass_low <- all(x[setdiff(C_low, 1L)] >= r0)
pass_high <- all(x[setdiff(C_high, 1L)] >= r1)
off_bound_low <- max(1 - k * r1, beta * ell)
off_bound_high <- max(1 - k * r1, beta * high)
stopifnot(pass_low, !pass_high, abs(sum(x) - 1) < tol,
          x[1L] >= beta * ell, beta * high >= x[1L],
          x[1L] + tol >= off_bound_low, beta * high + tol >= off_bound_high)
write.csv(data.frame(type = c("low", "high"), coalition = c("H,1,2", "H,1,2,3"),
                    passage = c(pass_low, pass_high), payoff = c(x[1L], beta * high)),
          file.path(out, "agenda_same_allocation_distinct_coalitions.csv"), row.names = FALSE)
record("agenda_coalition_signal", 1L,
       "Same x, different C: low agreement/high delay with endpoint posteriors and off-path posterior 1")

summary <- do.call(rbind, counts)
write.csv(summary, file.path(out, "numerical_checks.csv"), row.names = FALSE)
writeLines(c("PASS: all assertions passed.",
             "These are finite-grid and algebraic numerical checks, not independent mathematical certification.",
             paste("Total counted cases:", sum(summary$cases))),
           file.path(out, "numerical_checks.txt"))
print(summary[, c("check", "cases")], row.names = FALSE)
