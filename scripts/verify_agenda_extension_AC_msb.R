#!/usr/bin/env Rscript

# Mechanical falsification harness for the A_C M/S/B exact-fiber comparison.
# It checks frozen-source bytes, schemas, diagonal-fiber arithmetic, imported
# A_U cells, linked type-first contrasts, envelope identities, uniform and
# low-cell bounds, the necessity counterexample and the parity identity.
# It does NOT prove source PBE completeness, abstract Borel factorization,
# setwise lifting over arbitrary correspondences, or universal optimality.

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1L) {
  stop("Usage: Rscript scripts/verify_agenda_extension_AC_msb.R OUTPUT_PATH")
}

Sys.setenv(LC_ALL = "C", LANG = "C")

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
  isTRUE(length(x) == length(y) && all(abs(x - y) <= tol))
}

sha256 <- function(path) {
  out <- system2("shasum", c("-a", "256", path), stdout = TRUE, stderr = TRUE)
  if (!is.null(attr(out, "status")) && attr(out, "status") != 0L) {
    return(NA_character_)
  }
  hash_line <- grep("^[0-9a-f]{64}[[:space:]]", out, value = TRUE)
  if (length(hash_line) != 1L) return(NA_character_)
  strsplit(hash_line[[1L]], "[[:space:]]+")[[1L]][[1L]]
}

check_manifest <- function(path) {
  out <- suppressWarnings(system2(
    "shasum",
    c("-a", "256", "-c", path),
    stdout = TRUE,
    stderr = TRUE
  ))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  check_lines <- grep(": OK$", out, value = TRUE)
  status == 0L && length(check_lines) > 0L && all(grepl("OK$", check_lines))
}

cat("A_C M/S/B exact-fiber comparison mechanical verifier\n")
cat("Snapshot date: 2026-08-30\n")
cat("Orientation: U-M\n")
cat("Claim boundary: mechanical checks only; no PBE-completeness or abstract-factorization claim\n\n")

source_hashes <- c(
  "quality_reports/plans/2026-08-30_autorizacao_inicio_A_C_msb.md" =
    "ea4e2e9b9e1296aecd64760f058f0097ff4281f6a9b301373feeea2591092f95",
  "quality_reports/plans/2026-08-30_autorizacao_fortalecimento_A_C_pos_consulta.md" =
    "131e7485879ffbf1d399f91c2b838fb05e8d64644ae2c393692ffce1888fedec",
  "model_redesign/agenda_extension_A_M_msb_results.md" =
    "7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3",
  "model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv" =
    "321cb2ed45ed1c5ebb6103a4ac567f07b735dd7a2ca8e2252925b43b8a2add9c",
  "quality_reports/2026-08-29_A_M_msb_two_layer_terminal_approval_and_freeze.md" =
    "ca109199060f3aa775f6e2f18ef46fd9cefaff522cc3f7fdeeabfe9d5f412158",
  "quality_reports/2026-08-29_A_M_msb_two_layer_final_gate_manifest.sha256" =
    "8eb870d5595a4373994e8f47a25a3dd137b00ac8c32fc09b947444498a32775e",
  "model_redesign/agenda_extension_A_U_msb_contract.md" =
    "348ffc702d75e47ec8f8008bccb71338174649f57d90af8fc78e919cfd4ded26",
  "model_redesign/agenda_extension_A_U_msb_results.md" =
    "e2e2ec8cabc3d44b0c72bfa8ae1ef3d35256078448ce688db79bb7c1a96cdc11",
  "model_redesign/agenda_extension_A_U_msb_interface.json" =
    "2ee931d21e3858db6702f78a4636d1f3c4b445910c8160120921c3bfc3b4b317",
  "model_redesign/agenda_extension_A_U_msb_claim_ledger.tsv" =
    "18de37fbadf787f9217f45c9eb5ef31854c75611c9f65ba8130e06a2cd2a34c5",
  "quality_reports/2026-08-30_A_U_msb_two_layer_terminal_approval_and_freeze.md" =
    "e330a1956a7c071dc72c2556eda68cf32d2b81473d700100bbf7e1f6e195111b",
  "quality_reports/2026-08-30_A_U_msb_two_layer_final_gate_manifest.sha256" =
    "b85741b2176c4480f5f3632c4464a93cebabb5dd4f71636626917b9227030180"
)

for (path in names(source_hashes)) {
  check(sprintf("frozen byte hash: %s", path),
        file.exists(path) && identical(sha256(path), source_hashes[[path]]))
}
check("A_M final manifest verifies all frozen entries",
      check_manifest("quality_reports/2026-08-29_A_M_msb_two_layer_final_gate_manifest.sha256"))
check("A_U final manifest verifies all frozen entries",
      check_manifest("quality_reports/2026-08-30_A_U_msb_two_layer_final_gate_manifest.sha256"))

contract_path <- "model_redesign/agenda_extension_AC_msb_contract.md"
results_path <- "model_redesign/agenda_extension_AC_msb_results.md"
interface_path <- "model_redesign/agenda_extension_AC_msb_interface.json"
ledger_path <- "model_redesign/agenda_extension_AC_msb_claim_ledger.tsv"
contract_text <- paste(readLines(contract_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
results_text <- paste(readLines(results_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
interface_text <- paste(readLines(interface_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")

json_status <- suppressWarnings(system2(
  "python3",
  c("-m", "json.tool", interface_path),
  stdout = FALSE,
  stderr = FALSE
))
check("AC interface is valid JSON", identical(json_status, 0L))

ledger <- read.delim(
  ledger_path,
  sep = "\t",
  quote = "",
  stringsAsFactors = FALSE,
  check.names = FALSE,
  encoding = "UTF-8"
)
expected_columns <- c(
  "claim_id", "node_id", "cell_id", "record_or_family_id",
  "member_domain", "claim_kind", "claim_text", "domain", "status",
  "selection_status", "assumptions_used", "source_record_ids",
  "source_hashes", "payoff_date", "evidence_path", "proof_path"
)
check("AC ledger has the exact 16-column schema",
      identical(names(ledger), expected_columns))
check("AC ledger claim ids are unique and use the AC-MSB namespace",
      !anyDuplicated(ledger$claim_id) && all(grepl("^AC-MSB-[0-9]{3}$", ledger$claim_id)))
check("AC ledger keeps every payoff at date A",
      all(ledger$payoff_date == "A"))
check("AC source paths exist or are versioned verifier references",
      all(file.exists(ledger$proof_path) |
            grepl(" Sections? | Section ", ledger$proof_path)))
strengthening_claims <- c(
  "AC-MSB-001", "AC-MSB-006", "AC-MSB-013", "AC-MSB-017",
  "AC-MSB-019", "AC-MSB-021", "AC-MSB-022", "AC-MSB-023", "AC-MSB-024"
)
strengthening_hash <-
  "131e7485879ffbf1d399f91c2b838fb05e8d64644ae2c393692ffce1888fedec"
check("strengthening authorization propagates to every changed or new ledger claim",
      all(strengthening_claims %in% ledger$claim_id) &&
        all(grepl(
          strengthening_hash,
          ledger$source_hashes[match(strengthening_claims, ledger$claim_id)],
          fixed = TRUE
        )))

check("domain carries y_bar and distinguishes it from y_H",
      grepl("o_1<=y_bar<=1", contract_text, fixed = TRUE) &&
        grepl('"typing_note": "y_bar is the A_M domain primitive', interface_text, fixed = TRUE))
check("principal comparison is on the same exact fiber",
      grepl("times_(d,eta)", results_text, fixed = TRUE) &&
        grepl('"diagonal_requirement": "A_M and A_U use the same d and the same eta"',
              interface_text, fixed = TRUE))
check("exact binders precede source economic summaries",
      regexpr("J_AC\\^bind", results_text)[[1L]] <
        regexpr("S_M\\^econ", results_text)[[1L]])
check("cross-world scope declares marginals without a general coupling rule",
      grepl('"cross_world_joint_law": "not_defined"', interface_text, fixed = TRUE) &&
        grepl('"coupling_qualification": "AC declares only ordered marginals',
              interface_text, fixed = TRUE) &&
        grepl("regra geral de acoplamento entre regras", results_text, fixed = TRUE) &&
        grepl("degenerada, o conjunto de acoplamentos", contract_text, fixed = TRUE) &&
        grepl("caso-limite", results_text, fixed = TRUE))
degenerate_p <- c(1, 0)
nondegenerate_q <- c(0.3, 0.7)
degenerate_coupling <- rbind(nondegenerate_q, c(0, 0))
frechet_11 <- c(
  max(0, degenerate_p[[1L]] + nondegenerate_q[[1L]] - 1),
  min(degenerate_p[[1L]], nondegenerate_q[[1L]])
)
check("degenerate marginal yields a unique compatible 2x2 coupling",
      close_num(rowSums(degenerate_coupling), degenerate_p) &&
        close_num(colSums(degenerate_coupling), nondegenerate_q) &&
        close_num(frechet_11[[1L]], frechet_11[[2L]]) &&
        close_num(frechet_11[[1L]], degenerate_coupling[[1L, 1L]]))
check("ex-ante values are explicitly defined before scalar envelopes",
      grepl("V_g^E(R_g)=(1-nu)*V_g^0(R_g)+nu*V_g^1(R_g)",
            results_text, fixed = TRUE) &&
        regexpr("V_g^E(R_g)=", results_text, fixed = TRUE)[[1L]] <
          regexpr("M_r={V_M^r", results_text, fixed = TRUE)[[1L]])
check("ex-ante contrast is the linked affine image of D_01",
      grepl("D_E(d,eta)", results_text, fixed = TRUE) &&
        grepl('"ex_ante_contrast_image": "D_E={(1-nu)*x_0+nu*x_1:',
              interface_text, fixed = TRUE) &&
        grepl("coincide com a soma de Minkowski", results_text, fixed = TRUE))
check("AC applies zero new beta factors",
      grepl('"new_beta_applications": 0', interface_text, fixed = TRUE) &&
        grepl("zero fatores novos de `beta`", results_text, fixed = TRUE))
check("none cells use null rather than a numeric payoff sentinel",
      !grepl('"status": "none",[[:space:]]*"payoff_vector": [0-9-]', interface_text) &&
        length(gregexpr('"status": "none"', interface_text, fixed = TRUE)[[1L]]) == 2L &&
        length(gregexpr('"payoff_vector": null', interface_text, fixed = TRUE)[[1L]]) == 2L)
check("AR and all downstream mutations remain unauthorized",
      grepl('"AR": false', interface_text, fixed = TRUE) &&
        grepl('"manuscript_migration": false', interface_text, fixed = TRUE) &&
        grepl('"tag": false', interface_text, fixed = TRUE) &&
        grepl('"merge": false', interface_text, fixed = TRUE) &&
        grepl('"push": false', interface_text, fixed = TRUE))

b_rho <- function(nu, rho) {
  if (is.infinite(rho)) return(1)
  nu * rho / (1 - nu + nu * rho)
}

rho_from_p <- function(nu, p) {
  if (p == 1) return(Inf)
  p * (1 - nu) / (nu * (1 - p))
}

for (nu in c(0.05, 0.2, 0.5, 0.8, 0.95)) {
  rho_grid <- c(0, 0.01, 0.2, 1, 7, 100, Inf)
  p_grid <- vapply(rho_grid, function(rho) b_rho(nu, rho), numeric(1L))
  check(sprintf("rho map is monotone with endpoints at nu=%.2f", nu),
        close_num(p_grid[[1L]], 0) && close_num(p_grid[[length(p_grid)]], 1) &&
          all(diff(p_grid) > 0))
  for (p in c(0, 0.01, 0.2, 0.5, 0.9, 1)) {
    rho <- rho_from_p(nu, p)
    check(sprintf("rho inverse at nu=%.2f,p=%.2f", nu, p),
          close_num(b_rho(nu, rho), p))
  }
}

classify_u <- function(nu, nu_star, Delta_U, p) {
  tol <- 1e-12
  if (close_num(nu, 0)) return("E0")
  if (close_num(nu, 1)) return("E1")
  if (nu <= nu_star + tol) {
    if (Delta_U >= -tol && close_num(p, 0)) return("L")
    return("none")
  }
  if (close_num(p, 0)) return("H0")
  if (p > nu_star + tol) return("HB")
  "none"
}

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
  q <- floor(N / 2) + 1
  k <- q - 1
  c_excluded <- m - k
  beta <- parameter_rows$beta[[row_id]]
  o_0 <- o_pairs[parameter_rows$pair[[row_id]], 1L]
  o_1 <- o_pairs[parameter_rows$pair[[row_id]], 2L]
  nu_star <- (o_1 - o_0) / (1 - o_0)
  z_L <- 1 - beta + beta^2 * o_0
  d_H <- beta^2 * o_1
  z_H <- 1 - beta + beta^2 * o_1
  Delta_U <- z_L - d_H
  u_min <- max(z_L, d_H)
  Z_E <- 1 - k * beta / m
  gap <- Z_E - z_H
  low_gap <- Z_E - z_L
  prefix <- sprintf("grid[%d]:N=%d,beta=%.2f,o=(%.2f,%.2f)",
                    row_id, N, beta, o_0, o_1)

  check(paste(prefix, "nu_star is interior"), 0 < nu_star && nu_star < 1)
  check(paste(prefix, "U payoff bounds are ordered"),
        z_H > z_L && z_H > d_H && z_H > u_min - 1e-12)
  check(paste(prefix, "T5 algebraic identity"),
        close_num(gap, beta * (c_excluded / m - beta * o_1)))
  majority_grid <- c(Z_E, (Z_E + 1) / 2, 1)
  unanimity_grid <- c(u_min, (u_min + z_H) / 2, z_H)
  pairwise_margins <- as.vector(outer(majority_grid, unanimity_grid, "-"))
  check(paste(prefix, "T5 uniform margin holds on the bound-admissible payoff grid"),
        min(pairwise_margins) >= gap - 1e-12 && close_num(min(pairwise_margins), gap))
  check(paste(prefix, "T5 sign equivalence"),
        identical(sign(gap), sign(c_excluded / m - beta * o_1)))
  check(paste(prefix, "low-cell margin identity"),
        close_num(low_gap, beta * (c_excluded / m - beta * o_0)))
  if (beta * o_0 < c_excluded / m - 1e-12) {
    check(paste(prefix, "strict low-cell region has Z_E above z_L"),
          Z_E > z_L)
  }
  expected_fraction <- if (N %% 2L == 1L) {
    1 / 2
  } else {
    (N - 2) / (2 * (N - 1))
  }
  check(paste(prefix, "parity identity for c/m"),
        close_num(c_excluded / m, expected_fraction))
  if (beta * o_1 < c_excluded / m - 1e-12) {
    check(paste(prefix, "strict T5 region has Z_E above all U values"),
          Z_E > z_H && z_H >= u_min)
  }
  if (beta * o_1 > c_excluded / m + 1e-12) {
    check(paste(prefix, "outside T5 region bound alone does not certify majority"),
          Z_E < z_H)
  }

  check(paste(prefix, "endpoint zero payoff vector below z_H"),
        max(z_L, d_H) <= z_H)
  check(paste(prefix, "endpoint one payoff vector equals z_H"),
        close_num(z_H, z_H))
  check(paste(prefix, "low cell at p=0 follows Delta condition"),
        identical(classify_u(nu_star / 2, nu_star, Delta_U, 0),
                  if (Delta_U >= 0) "L" else "none"))
  check(paste(prefix, "low positive off-path belief is none"),
        identical(classify_u(nu_star / 2, nu_star, Delta_U, nu_star / 2), "none"))
  check(paste(prefix, "high p=0 cell is H0"),
        identical(classify_u((1 + nu_star) / 2, nu_star, Delta_U, 0), "H0"))
  check(paste(prefix, "high boundary p=nu_star is none"),
        identical(classify_u((1 + nu_star) / 2, nu_star, Delta_U, nu_star), "none"))
  check(paste(prefix, "high p>nu_star cell is HB"),
        identical(classify_u((1 + nu_star) / 2, nu_star, Delta_U,
                             (1 + nu_star) / 2), "HB"))
}

for (N in 3:15) {
  m <- N - 1
  k <- floor(N / 2)
  c_excluded <- m - k
  for (beta in c(0.55, 0.75, 0.9, 0.99)) {
    equality_o_1 <- c_excluded / (m * beta)
    if (equality_o_1 < 1) {
      o_0 <- equality_o_1 / 2
      Z_E <- 1 - k * beta / m
      z_H <- 1 - beta + beta^2 * equality_o_1
      check(sprintf("T5 equality fixture N=%d,beta=%.2f is admissible", N, beta),
            0 < o_0 && o_0 < equality_o_1 && equality_o_1 < 1)
      check(sprintf("T5 equality fixture N=%d,beta=%.2f closes the bound", N, beta),
            close_num(Z_E, z_H))
    }
  }
}

for (nu in c(0, 0.1, 0.5, 0.9, 1)) {
  V_M <- c(0.31, 0.77)
  V_U <- c(0.54, 0.62)
  delta <- V_U - V_M
  delta_E <- (1 - nu) * delta[[1L]] + nu * delta[[2L]]
  difference_E <- ((1 - nu) * V_U[[1L]] + nu * V_U[[2L]]) -
    ((1 - nu) * V_M[[1L]] + nu * V_M[[2L]])
  check(sprintf("type-first contrast identity at nu=%.1f", nu),
        close_num(delta_E, difference_E))
}

M_values <- c(0.20, 0.35, 0.80)
U_values <- c(0.15, 0.50, 0.70, 0.92)
D_values <- as.vector(outer(U_values, M_values, "-"))
check("finite envelope lower identity",
      close_num(min(D_values), min(U_values) - max(M_values)))
check("finite envelope upper identity",
      close_num(max(D_values), max(U_values) - min(M_values)))

M_vectors <- rbind(c(0.2, 0.8), c(0.4, 0.6))
U_vector <- c(0.5, 0.5)
exact_differences <- t(apply(M_vectors, 1L, function(x) U_vector - x))
spliced_difference <- c(U_vector[[1L]] - min(M_vectors[, 1L]),
                        U_vector[[2L]] - min(M_vectors[, 2L]))
check("coupled type vectors produce exactly two contrast vectors",
      nrow(unique(exact_differences)) == 2L)
check("marginal splicing fabricates a vector outside the exact set",
      !any(apply(exact_differences, 1L, function(x) close_num(x, spliced_difference))))

nu_link <- 0.3
linked_ex_ante <- apply(exact_differences, 1L, function(x) {
  (1 - nu_link) * x[[1L]] + nu_link * x[[2L]]
})
independent_ex_ante <- as.vector(outer(
  (1 - nu_link) * exact_differences[, 1L],
  nu_link * exact_differences[, 2L],
  "+"
))
check("linked D_E image uses complete contrast vectors",
      length(unique(linked_ex_ante)) == 2L)
check("independent marginal recombination can fabricate ex-ante contrasts",
      any(!vapply(independent_ex_ante, function(x) {
        any(vapply(linked_ex_ante, function(y) close_num(x, y), logical(1L)))
      }, logical(1L))))

N <- 5
m <- 4
k <- 2
c_excluded <- 2
beta <- 0.9
o_0 <- 0.5
o_1 <- 0.6
y_bar <- 0.8
nu <- 0
Z_E <- 1 - k * beta / m
z_L <- 1 - beta + beta^2 * o_0
d_H <- beta^2 * o_1
check("necessity counterexample satisfies primitive domain",
      N >= 3 && 0 < beta && beta < 1 && 0 < o_0 && o_0 < o_1 &&
        o_1 <= y_bar && y_bar <= 1 && nu == 0)
check("necessity counterexample lies outside strict T5",
      beta * o_1 > c_excluded / m)
check("necessity counterexample has strict majority bound for both endpoint types",
      close_num(Z_E, 0.55) && close_num(z_L, 0.505) &&
        close_num(d_H, 0.486) && Z_E > max(z_L, d_H))

check("results state T5 is sufficient rather than necessary",
      grepl("contraexemplo", results_text, fixed = TRUE) &&
        grepl("necessidade,", results_text, fixed = TRUE))
check("results state the odd-even parity formulas",
      grepl("c/m = 1/2", results_text, fixed = TRUE) &&
        grepl("c/m = (N-2)/(2*(N-1))", results_text, fixed = TRUE))

cat("\n")
cat(sprintf("MECHANICAL RESULT: %s | %d PASS | %d FAIL\n",
            if (fail_count == 0L) "PASS" else "FAIL",
            pass_count, fail_count))
cat("UNTESTED GATES: completeness of either PBE correspondence; arbitrary continuous deviations; abstract Borel factorization; exact setwise lifting beyond the written proof; extreme-point attainment; any welfare ranking; independent formal review.\n")

if (fail_count > 0L) {
  quit(save = "no", status = 1L)
}
