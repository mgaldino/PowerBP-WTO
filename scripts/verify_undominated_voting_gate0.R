#!/usr/bin/env Rscript

# Goal 3: finite-ballot verification for the PBE-UD Gate 0.
# This script is independent of the closed Goal 1/2 verifiers.

options(stringsAsFactors = FALSE)

# Resolve paths from the script location when invoked with Rscript.
args_full <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args_full, value = TRUE)
if (length(file_arg) == 1L) {
  script_path <- sub("^--file=", "", file_arg)
  repo_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
} else {
  repo_root <- normalizePath(".", mustWork = TRUE)
}

out_path <- file.path(repo_root, "tables", "undominated_voting_gate0_checks.csv")
checked_on <- "2026-08-04"
source_note <- "Goal 3 PBE-UD finite-ballot verification"

records <- list()
record_check <- function(id, domain, pass, detail) {
  records[[length(records) + 1L]] <<- data.frame(
    check_id = id,
    domain = domain,
    pass = isTRUE(pass),
    detail = detail,
    checked_on = checked_on,
    source = source_note,
    stringsAsFactors = FALSE
  )
  invisible(pass)
}

quota <- function(N, rule) {
  if (identical(rule, "U")) N else floor(N / 2) + 1
}

passes_active <- function(N, rule, weak_yes, h_vote) {
  q <- quota(N, rule)
  if (identical(h_vote, "Y")) {
    weak_yes + 1L >= q
  } else if (identical(rule, "M")) {
    weak_yes >= q
  } else {
    FALSE
  }
}

passes_weak_only <- function(N, weak_yes) {
  weak_yes >= quota(N, "M")
}

tol <- 1e-12

# Lemma G0.1: weak voter at every reachable terminal quota.
for (N in 3:10) {
  m <- N - 1L
  for (rule in c("U", "M")) {
    for (active_h in c(TRUE, FALSE)) {
      if (!active_h && identical(rule, "U")) next
      other_max <- m - 2L
      for (x in c(0, 0.2)) {
        deltas <- numeric()
        for (other_yes in 0:other_max) {
          h_votes <- if (active_h) c("Y", "N") else "absent"
          for (h_vote in h_votes) {
            weak_yes_y <- 1L + other_yes + 1L
            weak_yes_n <- 1L + other_yes
            if (active_h) {
              pass_y <- passes_active(N, rule, weak_yes_y, h_vote)
              pass_n <- passes_active(N, rule, weak_yes_n, h_vote)
            } else {
              pass_y <- passes_weak_only(N, weak_yes_y)
              pass_n <- passes_weak_only(N, weak_yes_n)
            }
            u_y <- if (pass_y) x else 0
            u_n <- if (pass_n) x else 0
            deltas <- c(deltas, u_y - u_n)
          }
        }
        expected <- if (x == 0) {
          all(abs(deltas) < tol)
        } else {
          all(deltas >= -tol) && any(deltas > tol)
        }
        id <- sprintf("G0.1_N%s_%s_H%s_x%s", N, rule, active_h, x)
        detail <- sprintf("min_delta=%.3f; max_delta=%.3f", min(deltas), max(deltas))
        record_check(id, "terminal weak voter", expected, detail)
      }
    }
  }
}

# Lemma G0.2: terminal H sign is exactly the sign of y-o_theta.
for (N in 3:10) {
  m <- N - 1L
  for (rule in c("U", "M")) {
    o_theta <- 0.4
    for (y in c(0.3, 0.4, 0.5)) {
      deltas <- vapply(1:m, function(z) {
        u_y <- if (passes_active(N, rule, z, "Y")) y else o_theta
        u_n <- o_theta
        u_y - u_n
      }, numeric(1))
      expected <- if (y < o_theta) {
        all(deltas <= tol) && any(deltas < -tol)
      } else if (y > o_theta) {
        all(deltas >= -tol) && any(deltas > tol)
      } else {
        all(abs(deltas) < tol)
      }
      id <- sprintf("G0.2_N%s_%s_y%s", N, rule, y)
      detail <- sprintf("min_delta=%.3f; max_delta=%.3f", min(deltas), max(deltas))
      record_check(id, "terminal H", expected, detail)
    }
  }
}

# Corollary G0.4a: at y=o_theta, discounted weak-caused failure makes H-yes
# weakly dominated in R1 whenever beta<1, a failure vector is feasible, and
# that continuation pays no more than o_theta. This is a conditional result.
for (N in 3:10) {
  m <- N - 1L
  for (rule in c("U", "M")) {
    beta <- 0.9
    o_theta <- 0.4
    y <- o_theta
    deltas <- vapply(1:m, function(z) {
      u_y <- if (passes_active(N, rule, z, "Y")) y else beta * o_theta
      u_n <- o_theta
      u_y - u_n
    }, numeric(1))
    failure_feasible <- identical(rule, "U") || quota(N, rule) >= 3L
    expected <- if (failure_feasible) {
      all(deltas <= tol) && any(deltas < -tol) && any(abs(deltas) < tol)
    } else {
      all(abs(deltas) < tol)
    }
    id <- sprintf("G0.4a_N%s_%s", N, rule)
    detail <- sprintf(
      "failure_feasible=%s; min_delta=%.3f; max_delta=%.3f",
      failure_feasible,
      min(deltas),
      max(deltas)
    )
    record_check(id, "R1 H exact threshold", expected, detail)
  }
}

# Counterexample to treating the preceding continuation inequality as
# automatic. Under terminal U pooling, the low type can receive beta*o1>o0
# after weak-caused failure, so neither R1 action dominates at y=o0.
beta_counter <- 0.9
o0_counter <- 0.1
o1_counter <- 0.2
deltas_counter <- c(
  implementation = o0_counter - o0_counter,
  weak_failure = beta_counter * o1_counter - o0_counter
)
record_check(
  "G0.4b_U_pooling_counterexample",
  "R1 H exact-threshold caveat",
  all(deltas_counter >= -tol) && any(deltas_counter > tol),
  sprintf(
    "implementation_delta=%.3f; failure_delta=%.3f",
    deltas_counter[["implementation"]],
    deltas_counter[["weak_failure"]]
  )
)

# Lemma G0.3: scalar pivotal comparison.
for (x in c(0.1, 0.2, 0.3)) {
  c_j <- 0.2
  pivotal_probabilities <- c(0, 0.25, 1)
  deltas <- pivotal_probabilities * (x - c_j)
  expected <- if (x < c_j) {
    all(deltas <= tol) && any(deltas < -tol)
  } else if (x > c_j) {
    all(deltas >= -tol) && any(deltas > tol)
  } else {
    all(abs(deltas) < tol)
  }
  id <- sprintf("G0.3_x%s", x)
  detail <- sprintf("min_delta=%.3f; max_delta=%.3f", min(deltas), max(deltas))
  record_check(id, "scalar weak voter", expected, detail)
}

# Feasible-but-zero-probability pivotality is not enough for strict interim
# dominance. With a degenerate posterior assigning zero probability to every
# pivotal state, both votes remain payoff-equivalent even when x != c_j.
zero_pivotal_deltas <- c(0, 0, 0) * (0.3 - 0.2)
record_check(
  "G0.3_zero_interim_pivotality",
  "scalar weak voter caveat",
  all(abs(zero_pivotal_deltas) < tol),
  "feasible pivotal state has zero interim mass; no action is strictly dominated"
)

# Terminal-U cap regression: partial high acceptance can make the attained cap
# value strictly smaller than S while still beating the low-only target.
o0_cap <- 0.2
o1_cap <- 0.6
nu_cap <- 0.75
lambda1_cap <- 0.5
L_cap <- (1 - nu_cap) * (1 - o0_cap)
P_cap <- 1 - o1_cap
S_cap_slack <- max(L_cap, P_cap)
J_cap <- (1 - nu_cap + nu_cap * lambda1_cap) * P_cap
record_check(
  "R2_U_cap_partial_value",
  "terminal U cap",
  J_cap + tol >= L_cap && J_cap < S_cap_slack - tol,
  sprintf("L=%.3f; J=%.3f; slack_S=%.3f", L_cap, J_cap, S_cap_slack)
)

# Proposal-complete terminal-U cap formula. Both high-H acceptance and the
# joint weak passage probability may vary at equality across cap proposals.
nu_cap_grid <- 0.75
R_cap_grid <- 0.4
for (A_cap_grid in c(0.25, 0.75, 1)) {
  for (lambda_cap_grid in c(0, 0.5, 1)) {
    reduced <- A_cap_grid *
      (1 - nu_cap_grid + nu_cap_grid * lambda_cap_grid) * R_cap_grid
    enumerated <- (1 - nu_cap_grid) * A_cap_grid * R_cap_grid +
      nu_cap_grid * lambda_cap_grid * A_cap_grid * R_cap_grid
    record_check(
      sprintf(
        "R2_U_cap_joint_formula_A%s_l%s",
        A_cap_grid,
        lambda_cap_grid
      ),
      "terminal U cap",
      abs(reduced - enumerated) < tol,
      sprintf("reduced=%.3f; enumerated=%.3f", reduced, enumerated)
    )
  }
}

# Adversarial regression: a zero-transfer cap with partial weak passage can be
# an attained maximizer even though the sure-passage target is not attained.
o0_weak_mix <- 1 / 5
o1_weak_mix <- 3 / 5
nu_weak_mix <- 3 / 4
A_weak_mix <- 3 / 4
lambda_weak_mix <- 1
P_weak_mix <- 1 - o1_weak_mix
L_weak_mix <- (1 - nu_weak_mix) * (1 - o0_weak_mix)
J_sure_weak_mix <- (1 - nu_weak_mix +
  nu_weak_mix * lambda_weak_mix) * P_weak_mix
J_actual_weak_mix <- A_weak_mix * J_sure_weak_mix
record_check(
  "R2_U_cap_partial_weak_maximizer",
  "terminal U cap",
  abs(L_weak_mix - 1 / 5) < tol &&
    abs(J_sure_weak_mix - 2 / 5) < tol &&
    abs(J_actual_weak_mix - 3 / 10) < tol &&
    J_sure_weak_mix > J_actual_weak_mix + tol &&
    J_actual_weak_mix > L_weak_mix + tol,
  sprintf(
    "L=%.3f; sure_J=%.3f; actual_J=%.3f",
    L_weak_mix,
    J_sure_weak_mix,
    J_actual_weak_mix
  )
)

# Terminal-U zero-surplus exception: rejection is an attained maximizer even
# when neither boundary class is implemented.
o0_zero_value <- 0.2
o1_zero_value <- 1
nu_zero_value <- 1
lambda1_zero_value <- 0
L_zero_value <- (1 - nu_zero_value) * (1 - o0_zero_value)
J_zero_value <- (1 - nu_zero_value +
  nu_zero_value * lambda1_zero_value) * (1 - o1_zero_value)
record_check(
  "R2_U_cap_zero_value_rejection",
  "terminal U cap",
  abs(L_zero_value) < tol &&
    abs(J_zero_value) < tol &&
    abs(max(0, L_zero_value, J_zero_value)) < tol,
  sprintf(
    "L=%.3f; J=%.3f; rejection=0 is attained",
    L_zero_value,
    J_zero_value
  )
)

# Terminal-M free support can include H only at the degenerate low posterior
# with o0=0 and a sure yes equality action. This saves exactly one weak vote.
for (N in 3:10) {
  q_value <- quota(N, "M")
  k_value <- q_value - 1L
  r_value <- q_value - 2L
  pass_with_h <- 1L + 1L + r_value >= q_value
  fail_without_h <- 1L + r_value < q_value
  record_check(
    sprintf("R2_M_free_H_support_N%s", N),
    "terminal M degenerate low posterior",
    pass_with_h && fail_without_h && r_value == k_value - 1L,
    sprintf("q=%s; weak_with_H=%s; regular_weak=%s", q_value, r_value, k_value)
  )
}

results <- do.call(rbind, records)
dir.create(dirname(out_path), recursive = TRUE, showWarnings = FALSE)
utils::write.csv(results, out_path, row.names = FALSE, fileEncoding = "UTF-8")

failed <- results[!results$pass, , drop = FALSE]
cat(sprintf("Gate 0 checks: %d/%d PASS\n", sum(results$pass), nrow(results)))
cat(sprintf("Output: %s\n", out_path))

if (nrow(failed) > 0L) {
  print(failed)
  quit(status = 1L)
}
