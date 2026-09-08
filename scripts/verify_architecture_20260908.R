#!/usr/bin/env Rscript
# Finite checks for the conditional implementation architecture of 2026-09-08.
# Run from the repository root. No packages, random seed, or manuscript changes.
# These checks do not prove completeness of an equilibrium correspondence.
options(stringsAsFactors = FALSE)
out <- file.path("quality_reports", "architecture_2026-09-08", "checks")
dir.create(out, recursive = TRUE, showWarnings = FALSE)
results <- list()
add <- function(id, category, ok, detail) {
  results[[length(results) + 1L]] <<- data.frame(
    id = id, category = category, pass = isTRUE(ok), detail = detail)
}
near <- function(a, b) abs(a - b) < 1e-12
# Tie handling is numerical only; the note states exact weak inequalities.
vote <- function(y, n) ifelse(y >= n - 1e-12, "Y", "N")

# Independent payoff implementations: historical cancellation versus a choice
# between two uses of a single indivisible resource after a passing no vote.
old_H <- function(v, pass, x, o, round, CY = o, CN = o) {
  if (pass) return(if (v == "Y") x else o)
  if (round == 2L) return(o)
  if (v == "Y") CY else CN # already transported to current date
}
new_receipts <- function(v, pass, x, o, round, CY = o, CN = o,
                         implementation = NULL) {
  if (!pass) return(c(club = 0, external = 0,
    value = if (round == 2L) o else if (v == "Y") CY else CN))
  if (v == "Y") return(c(club = x, external = 0, value = x))
  if (is.null(implementation)) implementation <- if (x >= o) "C" else "O"
  if (implementation == "C") return(c(club = x, external = 0, value = x))
  if (implementation == "O") return(c(club = 0, external = o, value = o))
  stop("Implementation must be C or O")
}

# Both implementation actions, including suboptimal ones, obey the resource
# constraint. This is a check of the proposed technology, not its empirical fit.
for (x in c(0, .05, .1, .2, .35, .9, 1)) for (o in c(.1, .2, .35, .9)) {
  for (a in c("C", "O")) {
    r <- new_receipts("N", TRUE, x, o, 2L, implementation = a)
    add(paste("resource", x, o, a, sep = "_"), "implementation",
        !(r["club"] > 0 && r["external"] > 0), "all feasible implementation actions")
  }
  optimal <- max(new_receipts("N", TRUE, x, o, 2L, implementation = "C")["value"],
                 new_receipts("N", TRUE, x, o, 2L, implementation = "O")["value"])
  add(paste("max", x, o, sep = "_"), "implementation",
      near(optimal, max(x, o)), "optimized no-pass payoff")
}

# Exhaust all count classes and both unilateral H votes; pure weak ballots
# make the count known from the prescribed strategies at a public proposal.
for (m in 3:9) for (beta in c(.2, .5, .9, .99))
  for (o in c(.05, .1, .35, .8)) for (round in 1:2) {
  k <- floor((m + 1) / 2)
  xs <- unique(c(0, beta * o, o, (1 + o) / 2, 1))
  for (n in 0:(m - 1)) for (x in xs) {
    passes <- c(Y = n + 1 >= k, N = n >= k)
    cy <- cn <- beta * o
    a <- sapply(c("Y", "N"), function(v) old_H(v, passes[v], x, o, round, cy, cn))
    b <- sapply(c("Y", "N"), function(v)
      unname(new_receipts(v, passes[v], x, o, round, cy, cn)["value"]))
    chosen_a <- vote(a["Y"], a["N"]); chosen_b <- vote(b["Y"], b["N"])
    id <- paste(m, beta, o, round, n, x, sep = "_")
    add(paste0("vote_", id), "majority_ballot", chosen_a == chosen_b,
        "same prescribed H vote under T^Y")
    add(paste0("selected_payoff_", id), "majority_ballot",
        near(a[chosen_a], b[chosen_b]), "same payoff at prescribed H vote")
    add(paste0("unilateral_gain_", id), "majority_ballot",
        b[chosen_b] >= max(b) - 1e-12, "no profitable H vote deviation")
  }
}

# Under unanimity an approved N branch cannot occur. Allow arbitrary
# vote-dependent continuation numbers, not the majority shortcut beta*o.
for (m in 3:7) for (n in 0:(m - 1)) for (round in 1:2)
  for (x in c(0, .1, .35, 1)) for (o in c(.1, .35))
    for (cy in c(.09, .315)) for (cn in c(.09, .315)) {
  vals <- lapply(c("Y", "N"), function(v) {
    pass <- n == m - 1 && v == "Y"
    c(old_H(v, pass, x, o, round, cy, cn),
      unname(new_receipts(v, pass, x, o, round, cy, cn)["value"]))
  })
  add(paste("unanimity", m, n, round, x, o, cy, cn, sep = "_"), "unanimity_identity",
      all(vapply(vals, function(z) near(z[1], z[2]), logical(1))),
      "identity for each H action, including different continuation beliefs")
}

# Full weak allocation patterns around the threshold, plus a few positive H
# shares. Compare two feasible proposals made before the vote.
for (m in 3:7) for (beta in c(.2, .5, .9)) {
  w <- beta / m; k <- floor((m + 1) / 2)
  patterns <- as.matrix(expand.grid(rep(list(c(0, w, w + .001)), m - 1)))
  for (idx in seq_len(nrow(patterns))) for (x in c(.01, .1, .2)) {
    weak <- patterns[idx, ]; residual <- 1 - x - sum(weak)
    if (residual < -1e-12 || sum(weak >= w - 1e-12) < k) next
    alternative <- residual + x
    add(paste("dominance", m, beta, idx, x, sep = "_"), "proposal_dominance",
        alternative > residual && near(alternative + sum(weak), 1),
        "weak allocations identical; enough prescribed weak yes votes; strict proposer gain")
  }
}

# Terminal invariance and the terminal unanimity cutoff, including endpoints.
for (m in 3:9) for (l in c(.05, .1, .3)) for (h in c(.35, .6, .9)) {
  if (l >= h) next
  star <- (h - l) / (1 - l)
  for (p in unique(c(0, star / 2, star, (1 + star) / 2, 1))) {
    low <- (1 - p) * (1 - l); pool <- 1 - h
    choose_low <- p <= star
    add(paste("R2_U", m, l, h, p, sep = "_"), "terminal_unanimity",
        if (choose_low) low >= pool - 1e-12 else pool > low,
        "terminal low/pooling comparison; beta absent")
  }
}

# Targeted counterexamples: they are intended differences, not failures.
changed <- data.frame(
  example = c("passing_N_low_type", "passing_N_high_type", "revocable_yes_R2_U",
              "two_resources_joint_receipts", "divisible_resource_tie"),
  xH = c(.2, .2, 0, .2, .2), o = c(.1, .35, .1, .1, .2),
  historical = c(.1, .35, 0, NA, NA),
  candidate_or_counterfactual = c(.2, .35, .1, .3, .2),
  interpretation = c("N then club; historical terminal payoff changes",
    "N then outside; no cancellation is imposed by ballot",
    "if Y may switch to outside, zero offer is accepted in terminal unanimity",
    "joint use adds full club and outside receipts",
    "half of each use creates two positive components even at an optimal tie"))
add("offpath_difference", "counterexamples",
    !near(old_H("N", TRUE, .2, .1, 2L),
          new_receipts("N", TRUE, .2, .1, 2L)["value"]),
    "full extensive-form utilities are not identical")
add("revocable_commitment", "counterexamples", vote(max(0, .1), .1) == "Y",
    "T^Y would accept zero in R2 unanimity if yes were revocable")
add("two_resources", "counterexamples", .2 + .1 > max(.2, .1),
    "rivalry is a substantive new assumption")
add("divisibility", "counterexamples", .5 * .2 > 0 && .5 * .2 > 0,
    "indivisibility matters for no two positive receipts at every history")

# Existing worked example, recalculated from elementary candidate payoffs.
m <- 4; beta <- .9; l <- .1; h <- .35; p <- .8
k <- floor((m + 1) / 2); w <- beta / m
PE <- 1 - k * w
PS <- (1 - p) * (1 - (k - 1) * w - beta * l) + p * w
PP <- 1 - (k - 1) * w - beta * h
private_M <- c(l, h); private_U <- rep(beta * h, 2)
public_M <- c(beta * l, h); public_U <- beta * c(l, h)
add("worked_majority_exclusion", "worked_example", PE > max(PS, PP, w),
    "excluded H receives outside value with xH=0")
add("worked_rent_gap", "worked_example",
    all(near((private_U - public_U) - (private_M - public_M), c(.215, 0))),
    "linked low/high type informational rent contrast")
worked <- data.frame(type = c("low", "high"), public_M, public_U, private_M,
                     private_U, IR_M = private_M - public_M,
                     IR_U = private_U - public_U)

res <- do.call(rbind, results)
stopifnot(!anyDuplicated(res$id))
write.csv(res, file.path(out, "finite_checks.csv"), row.names = FALSE)
write.csv(changed, file.path(out, "counterexamples.csv"), row.names = FALSE)
write.csv(worked, file.path(out, "worked_example.csv"), row.names = FALSE)
summary <- aggregate(as.integer(res$pass), list(category = res$category), sum)
names(summary)[2] <- "passed"
summary$total <- as.integer(table(res$category)[summary$category])
summary$failed <- summary$total - summary$passed
write.csv(summary, file.path(out, "summary.csv"), row.names = FALSE)
capture.output(sessionInfo(), file = file.path(out, "sessionInfo.txt"))
print(summary, row.names = FALSE)
cat(sprintf("TOTAL: %s PASS | %s FAIL\n", sum(res$pass), sum(!res$pass)))
if (any(!res$pass)) stop("Finite checks failed; inspect finite_checks.csv")
