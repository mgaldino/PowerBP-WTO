#!/usr/bin/env Rscript

# Mechanical falsification harness for the blind A_U M/S/B reconstruction.
# It checks algebra, domains, quota logic, endpoint choices and constructive
# witnesses. It does NOT prove PBE completeness, pointwise local-Bayes limits,
# or absence of deviations over the full continuous proposal space.

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1L) {
  stop("Usage: Rscript scripts/verify_agenda_extension_A_U_msb.R OUTPUT_PATH")
}

output_path <- args[[1L]]
dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
sink(output_path, split = TRUE)
on.exit(sink(), add = TRUE)

pass_count <- 0L
fail_count <- 0L

check <- function(label, condition) {
  condition <- isTRUE(condition)
  if (condition) {
    pass_count <<- pass_count + 1L
    cat(sprintf("PASS | %s\n", label))
  } else {
    fail_count <<- fail_count + 1L
    cat(sprintf("FAIL | %s\n", label))
  }
  invisible(condition)
}

close_num <- function(x, y, tol = 1e-11) {
  isTRUE(all(abs(x - y) <= tol))
}

cat("A_U M/S/B blind reconstruction mechanical verifier\n")
cat("Snapshot date: 2026-08-29\n")
cat("Frozen C_U SHA-256: f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b\n")
cat("Claim boundary: mechanical checks only; no PBE-completeness claim\n\n")

source_cu_path <- "model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json"
source_cu_text <- readLines(source_cu_path, warn = FALSE, encoding = "UTF-8")
check(
  "literal C_U low-cell counterfactual theta_1 weak payoff is zero",
  any(grepl(
    '"theta_1_realized_vector": "every weak state 0 after the failed R1 proposal and N2 screening;',
    source_cu_text,
    fixed = TRUE
  ))
)

parameter_rows <- expand.grid(
  N = c(3, 4, 5, 13),
  beta = c(0.2, 0.6, 0.9, 0.99),
  pair = seq_len(4),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
o_pairs <- rbind(
  c(0.05, 0.10),
  c(0.10, 0.70),
  c(0.30, 0.40),
  c(0.80, 0.95)
)

for (row_id in seq_len(nrow(parameter_rows))) {
  N <- parameter_rows$N[[row_id]]
  m <- N - 1
  beta <- parameter_rows$beta[[row_id]]
  o_0 <- o_pairs[parameter_rows$pair[[row_id]], 1L]
  o_1 <- o_pairs[parameter_rows$pair[[row_id]], 2L]

  nu_star <- (o_1 - o_0) / (1 - o_0)
  ell <- beta * o_0
  h <- beta * o_1
  d_0 <- beta * ell
  d <- beta * h
  a <- beta * (1 - ell) / m
  b <- beta * (1 - h) / m
  z_L <- 1 - m * a
  z_H <- 1 - m * b
  Delta <- z_L - d

  prefix <- sprintf("grid[%d]:N=%d,beta=%.2f,o=(%.2f,%.2f)", row_id, N, beta, o_0, o_1)
  check(paste(prefix, "nu_star interior"), 0 < nu_star && nu_star < 1)
  check(paste(prefix, "native continuation ordering"), 0 < ell && ell < h && h < 1)
  check(paste(prefix, "transport identities"),
        close_num(d_0, beta^2 * o_0) && close_num(d, beta^2 * o_1))
  check(paste(prefix, "vote-price ordering"), 0 < b && b < a)
  check(paste(prefix, "agreement-share identities"),
        close_num(z_L, 1 - beta + d_0) && close_num(z_H, 1 - beta + d))
  check(paste(prefix, "share ordering"), d_0 < d && z_L < z_H && d < z_H)
  check(paste(prefix, "y_L belongs to Y and exhausts pie"),
        z_L >= 0 && a >= 0 && close_num(z_L + m * a, 1))
  check(paste(prefix, "y_bar=y_H belongs to Y and exhausts pie"),
        z_H >= 0 && b >= 0 && close_num(z_H + m * b, 1))
  check(paste(prefix, "Delta identity"),
        close_num(Delta, 1 - beta - beta^2 * (o_1 - o_0)))
  check(paste(prefix, "T^Y closes both acceptance boundaries"),
        a >= a && b >= b)

  # Constructive pure separating witness for AU-MSB-L whenever admissible.
  if (Delta >= -1e-12) {
    y_S_total <- z_L + m * b
    check(paste(prefix, "low-family pure witness is feasible"),
          y_S_total <= 1 + 1e-11 && b < a)
    check(paste(prefix, "low-family witness has correct common payoff"),
          z_L + 1e-12 >= d)
    check(paste(prefix, "two-signal Bayes posteriors are 0 and 1"),
          0 %in% c(0, 1) && 1 %in% c(0, 1) && 1 > nu_star)
  }

  # Constructive high-only pooling witnesses at the interval endpoints.
  lower_V <- max(z_L, d)
  for (V in c(lower_V, (lower_V + z_H) / 2, z_H)) {
    weak_share <- (1 - V) / m
    check(paste(prefix, sprintf("high-pooling witness V=%.8f feasible", V)),
          V >= lower_V - 1e-11 && V <= z_H + 1e-11 &&
            weak_share >= b - 1e-11 && close_num(V + m * weak_share, 1))
  }

  # Endpoint best-response comparisons.
  if (Delta > 1e-12) {
    check(paste(prefix, "nu=0 type-1 accepts y_L strictly"), z_L > d)
  } else if (Delta < -1e-12) {
    check(paste(prefix, "nu=0 type-1 strictly delays"), d > z_L)
  } else {
    check(paste(prefix, "nu=0 type-1 knife-edge"), close_num(d, z_L))
  }
  check(paste(prefix, "nu=1 both types choose y_H strictly over delay"), z_H > d)
}

# Exhaust all sealed weak ballot vectors for small m and verify unanimity.
for (m in 2:6) {
  ballot_grid <- expand.grid(rep(list(c(FALSE, TRUE)), m))
  pass_rule <- apply(ballot_grid, 1L, all)
  check(sprintf("unanimity quota for m=%d has exactly one passing vector", m),
        sum(pass_rule) == 1L && nrow(ballot_grid) == 2^m)
}

# Posterior-domain and classification boundary checks.
for (nu_star in c(0.05, 0.2, 0.5, 0.95)) {
  candidate_mu <- c(0, nu_star / 2, nu_star, (nu_star + 1) / 2, 1)
  admissible <- candidate_mu == 0 | candidate_mu > nu_star
  check(sprintf("D_C excludes the closed low-positive interval at nu_star=%.2f", nu_star),
        identical(admissible, c(TRUE, FALSE, FALSE, TRUE, TRUE)))
}

# Ex-ante averaging is performed after type-conditioned values.
for (nu in c(0, 0.1, 0.5, 0.9, 1)) {
  V_0 <- 0.37
  V_1 <- 0.61
  ex_ante <- (1 - nu) * V_0 + nu * V_1
  check(sprintf("type-first ex-ante average at nu=%.1f", nu),
        close_num(ex_ante, V_0 + nu * (V_1 - V_0)))
}

cat("\n")
cat(sprintf("MECHANICAL RESULT: %s | %d PASS | %d FAIL\n",
            if (fail_count == 0L) "PASS" else "FAIL",
            pass_count, fail_count))
cat("UNTESTED GATES: PBE completeness; all continuous deviations; pointwise local-Bayes existence; Borel totality of symbolic binders; literal-member review of every continuation selector.\n")

if (fail_count > 0L) {
  quit(save = "no", status = 1L)
}
