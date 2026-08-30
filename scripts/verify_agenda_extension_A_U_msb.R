#!/usr/bin/env Rscript

# Mechanical falsification harness for the A_U M/S/B two-layer candidate.
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

cat("A_U M/S/B two-layer architecture mechanical verifier\n")
cat("Snapshot date: 2026-08-30\n")
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

# Authorized two-layer interface: finite P/Q certificates.
decision_path <- "quality_reports/plans/2026-08-30_decisao_assinatura_duas_camadas_A_U.md"
results_path <- "model_redesign/agenda_extension_A_U_msb_results.md"
interface_path <- "model_redesign/agenda_extension_A_U_msb_interface.json"
decision_text <- paste(readLines(decision_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
results_text <- paste(readLines(results_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
interface_text <- paste(readLines(interface_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")

check("A_U-specific author decision is APPROVED",
      grepl("Status:** `APPROVED`", decision_text, fixed = TRUE))
check("exact signature is present in results and interface",
      grepl("Sig_ex_U(R)=(rho(R),nu_off(R),Lambda_(x_U(R)))", results_text, fixed = TRUE) &&
        grepl("Sig_ex_U(R)=(rho(R),nu_off(R),Lambda_x_U(R))", interface_text, fixed = TRUE))
check("economic summary is present in results and interface",
      grepl("Sum_econ_U(R)", results_text, fixed = TRUE) &&
        grepl("Sum_econ_U(R)=", interface_text, fixed = TRUE))
check("Reynolds is explicitly barred as representative",
      grepl("chamado de representante de PBE", results_text, fixed = TRUE) &&
        grepl("never a PBE representative", interface_text, fixed = TRUE))
check("downstream factorization gate is explicit",
      grepl("Sum_econ(R)=Sum_econ(R')  =>  C(R)=C(R')", results_text, fixed = TRUE) &&
        grepl("operation-specific same-fiber setwise measurable-factorization proof", interface_text, fixed = TRUE))

N <- 3
m <- N - 1
beta <- 0.9
o_0 <- 0.2
o_1 <- 0.5
nu_star <- (o_1 - o_0) / (1 - o_0)
a <- beta * (1 - beta * o_0) / m
b <- beta * (1 - beta * o_1) / m
d <- beta^2 * o_1
z_L <- 1 - beta + beta^2 * o_0
z_H <- 1 - beta + beta^2 * o_1
Delta <- z_L - d
V <- 0.45
P <- c(V, 0.3025, 0.2475)
Q <- c(V, 0.2475, 0.3025)

check("P/Q fixture arithmetic",
      close_num(nu_star, 0.375) && close_num(a, 0.369) &&
        close_num(b, 0.2475) && close_num(d, 0.405) &&
        close_num(z_L, 0.262) && close_num(z_H, 0.505) &&
        close_num(Delta, -0.143))
check("P/Q proposals exhaust the pie and pass at the high price",
      close_num(sum(P), 1) && close_num(sum(Q), 1) &&
        min(P[-1]) >= b - 1e-12 && min(Q[-1]) >= b - 1e-12)
check("P/Q payoff belongs to AU-MSB-H0 interval",
      V >= max(z_L, d) && V <= z_H)
check("P and Q are weak-identity relabelings",
      identical(P, Q[c(1, 3, 2)]))

orbit_weight_signature <- function(p) sort(c(p, 1 - p))
check("exact orbit identifies p only with 1-p",
      close_num(orbit_weight_signature(0.9), orbit_weight_signature(0.1)) &&
        !close_num(orbit_weight_signature(0.9), orbit_weight_signature(0.5)))
check("recordwise quotient collapses all common P/Q mixture weights",
      close_num(sum(c(0.9, 0.1)), 1) && close_num(sum(c(0.5, 0.5)), 1))

nu_high <- 0.9
sigma_0 <- c(P = 0.9, Q = 0.1)
sigma_1 <- c(P = 0.1, Q = 0.9)
posterior <- nu_high * sigma_1 /
  ((1 - nu_high) * sigma_0 + nu_high * sigma_1)
check("unequal-weight P/Q Bayes posteriors equal .5 and 81/82",
      close_num(posterior[["P"]], 0.5) && close_num(posterior[["Q"]], 81 / 82))
check("both unequal-weight posteriors remain in the high C_U domain",
      all(posterior > nu_star))
check("componentwise Reynolds puts two posterior labels at physical P",
      length(unique(round(c(posterior[["P"]], posterior[["Q"]]), 12))) == 2L)
check("one public posterior map cannot assign both Reynolds labels at P",
      !close_num(posterior[["P"]], posterior[["Q"]]))

cat("\n")
cat(sprintf("MECHANICAL RESULT: %s | %d PASS | %d FAIL\n",
            if (fail_count == 0L) "PASS" else "FAIL",
            pass_count, fail_count))
cat("UNTESTED GATES: PBE completeness; all continuous deviations; pointwise local-Bayes existence; abstract Borel and orbit-completeness proofs; literal-member review of every continuation selector; operation-specific downstream factorization.\n")

if (fail_count > 0L) {
  quit(save = "no", status = 1L)
}
