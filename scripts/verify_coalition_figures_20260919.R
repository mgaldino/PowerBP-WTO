#!/usr/bin/env Rscript
# Check the numerical content of the five reused manuscript figures against
# the newly derived coalition formulas, without rewriting historical bundles.
options(encoding = "UTF-8")
out <- "quality_reports/coalition_protocol_2026-09-19/checks"
dir.create(out, recursive = TRUE, showWarnings = FALSE)
tol <- 1e-9
records <- list()
add <- function(name, count, scope) {
  records[[length(records) + 1L]] <<- data.frame(check = name, cases = count, scope = scope)
}
private_M <- function(m, beta, ell, high, p) {
  k <- floor((m + 1) / 2); w <- beta / m
  profits <- c(1 - k * w,
               (1 - p) * (1 - (k - 1) * w - beta * ell) + p * w,
               1 - (k - 1) * w - beta * high)
  h_pay <- rbind(c(ell, high), c(beta * ell, beta * high), rep(beta * high, 2))
  idx <- which(abs(profits - max(profits)) < 1e-12)
  cost_H <- h_pay[idx, , drop = FALSE] %*% c(1 - p, p)
  idx <- idx[which(abs(cost_H - min(cost_H)) < 1e-12)]
  h_pay[idx[1L], ]
}

# F1: all analytic boundaries and within-polygon paired midpoints. These are
# checked independently of the frozen function that generated the figure.
f1 <- read.csv("figures/essential_input/figure_f1_private_comparison_data.csv")
front <- f1[f1$record_type == "analytic_frontier", ]
high <- front$vertical_value / 4; ell <- .5 * high; beta <- .9; m <- 4; k <- 2
pred <- front$nu
idx <- front$region == "nu_star"; pred[idx] <- (high[idx] - ell[idx]) / (1 - ell[idx])
idx <- front$region == "nu_SP"; pred[idx] <- beta * (high[idx] - ell[idx]) /
  (1 - beta * ell[idx] - beta * k / m)
idx <- front$region == "nu_SE"; pred[idx] <- beta * (1 / m - ell[idx]) /
  (beta * (1 / m - ell[idx]) + 1 - beta * (k + 1) / m)
stopifnot(max(abs(pred - front$nu)) < tol,
          all(abs(front$vertical_value[front$region == "substitute_cost"] - 1) < tol))
add("F1_analytic_frontiers", nrow(front), "All saved boundary coordinates")
polys <- split(f1[f1$record_type == "region_polygon", ],
               f1$polygon_id[f1$record_type == "region_polygon"])
checked <- 0L
for (poly in polys) {
  n <- nrow(poly); stopifnot(n %% 2 == 0)
  for (i in seq_len(n / 2)) {
    p <- mean(poly$nu[c(i, n + 1 - i)])
    high <- poly$vertical_value[i] / 4; ell <- .5 * high
    if (abs(poly$nu[i] - poly$nu[n + 1 - i]) < 1e-7 || abs(high - .25) < 1e-7) next
    star <- (high - ell) / (1 - ell)
    if (p > 0 && p <= star) expected <- "No comparison: no PBE in pure ballot strategies" else {
      U <- if (p == 0) c(.9 * ell, .9 * high) else rep(.9 * high, 2)
      diff <- U - private_M(4, .9, ell, high, p)
      coord <- if (poly$hegemon_type[i] == "Low type") 1L else 2L
      expected <- if (abs(diff[coord]) < tol) "H indifferent" else
        if (diff[coord] > 0) "H prefers unanimity" else "H prefers majority"
    }
    stopifnot(expected == poly$region[i]); checked <- checked + 1L
  }
}
add("F1_region_midpoints", checked, "Interior paired midpoints of every saved polygon; no interpolation of empty cells")

f2 <- read.csv("figures/essential_input/figure_f2_prices_coalitions_data.csv")
checked <- 0L
for (i in seq_len(nrow(f2))) {
  z <- f2[i, ]; p <- z$nu; coord <- if (z$type == "Low type") 1L else 2L
  if (z$dataset %in% c("panel_a_payoff", "panel_a_endpoint")) {
    values <- if (z$rule == "Majority") private_M(4, .9, .1, .35, p) else
      if (p == 0) c(.09, .315) else rep(.315, 2)
    stopifnot(abs(values[coord] - z$payoff) < tol)
  } else if (z$dataset == "panel_b_outside_option") {
    stopifnot(abs(c(.1, .35)[coord] - z$payoff) < tol)
  } else {
    key <- paste(z$rule, z$segment)
    expected <- c("Majority Substitute votes" = .45, "Majority Proposer residual" = .55,
                  "Unanimity Weak-state floors" = .43875, "Unanimity Concession to H" = .315,
                  "Unanimity Proposer residual" = .24625)[key]
    stopifnot(length(expected) == 1, !is.na(expected), abs(expected - z$payoff) < tol)
  }
  checked <- checked + 1L
}
add("F2_payoffs_and_allocations", checked, "All saved prices, coalition costs, proposer residuals and outside-option entries")

f3 <- read.csv("figures/essential_input/figure_f3_power_information_data.csv")
expected <- c(.09, .35, .1, .35, .09, .315, .315, .315, .01, 0, .225, 0, .215, 0)
stopifnot(nrow(f3) == length(expected), max(abs(f3$payoff - expected)) < tol)
add("F3_public_private_rents", nrow(f3), "All example payoff and rent coordinates, including positive majority rent under private exclusion")

gap <- read.csv("figures/agenda_extension/figure_agenda_public_gap_data.csv")
o <- gap$o
M <- ifelse(o <= .25, 1 - 2 * .9 * (1 - .9 * o) / 4, pmax(.55, .9 * o))
U <- 1 - .9 + .9^2 * o
stopifnot(max(abs(gap$gap - (U - M))) < tol)
add("agenda_public_gap", nrow(gap), "Every saved gap coordinate including piecewise branch endpoints")

cells <- read.csv("figures/agenda_extension/figure_agenda_unanimity_existence_data.csv")
star <- (.35 - .1) / (1 - .1)
stopifnot(all(abs(cells$p_star - star) < tol), all(!cells$low_family_payoff_condition),
          1 - .9 + .9^2 * .1 < .9^2 * .35)
inside <- function(a, l, u, li, ui) {
  (if (li) a >= l - tol else a > l + tol) &&
    (if (ui) a <= u + tol else a < u - tol)
}
grid <- sort(unique(c(0, star - .001, star, star + .001, .7, 1)))
checked <- 0L
for (p in grid) for (mu in grid) {
  recorded <- any(vapply(seq_len(4), function(i) {
    inside(p, cells$p_lower[i], cells$p_upper[i], cells$p_lower_included[i], cells$p_upper_included[i]) &&
      inside(mu, cells$mu_off_lower[i], cells$mu_off_upper[i],
             cells$mu_off_lower_included[i], cells$mu_off_upper_included[i])
  }, logical(1)))
  derived <- (p == 0 && mu == 0) || (p == 1 && mu == 1) ||
    (p > star && p < 1 && (mu == 0 || mu > star))
  stopifnot(recorded == derived); checked <- checked + 1L
}
add("agenda_unanimity_existence", checked, "Open/closed boundaries, excluded low-prior cell, and support-preserving endpoints")
result <- do.call(rbind, records)
write.csv(result, file.path(out, "figure_checks.csv"), row.names = FALSE)
writeLines(c("PASS: five reused external figures checked against the coalition formulas.",
             "Existing PDF/PNG bundles were not rewritten; their source hashes remain historical.",
             "Numerical audit is separate from final-PDF visual inspection."),
           file.path(out, "figure_checks.txt"))
print(result[, c("check", "cases")], row.names = FALSE)
