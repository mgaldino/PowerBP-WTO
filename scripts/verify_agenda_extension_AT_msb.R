#!/usr/bin/env Rscript

# Mechanical falsification harness for A_T.
# Checks frozen bytes, schemas, dates and finite-grid algebra for the factorial
# agenda effects. It is not an independent mathematical review and does not
# select equilibria in set-valued source correspondences.

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1L) {
  stop("Usage: Rscript scripts/verify_agenda_extension_AT_msb.R OUTPUT_PATH")
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

close_num <- function(x, y, tol = 1e-10) {
  isTRUE(length(x) == length(y) && all(abs(x - y) <= tol))
}

sha256 <- function(path) {
  out <- system2("shasum", c("-a", "256", path), stdout = TRUE, stderr = TRUE)
  if (!is.null(attr(out, "status")) && attr(out, "status") != 0L) return(NA_character_)
  hash_line <- grep("^[0-9a-f]{64}[[:space:]]", out, value = TRUE)
  if (length(hash_line) != 1L) return(NA_character_)
  sub("[[:space:]].*$", "", hash_line[[1L]])
}

check_manifest <- function(path) {
  out <- suppressWarnings(system2("shasum", c("-c", path), stdout = TRUE, stderr = TRUE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  ok_lines <- grep(": OK$", out, value = TRUE)
  status == 0L && length(ok_lines) > 0L && all(grepl("OK$", ok_lines))
}

cat("A_T total agenda-effect mechanical verifier\n")
cat("Snapshot date: 2026-08-30\n")
cat("Agenda effect orientation: with agenda minus without agenda\n")
cat("Institutional orientation: U-M\n")
cat("Claim boundary: mechanical checks only; not mathematical or editorial approval\n\n")

source_hashes <- c(
  "quality_reports/plans/2026-08-30_autorizacao_efeito_total_agenda.md" =
    "701861558cc5634f28e8ba02e364a8f8c909bbee9cec1aa09d3febf3a370044e",
  "model_redesign/agenda_extension_AR_msb_results.md" =
    "7a7913b6999a5cd69446d5f3e191f507f417582cd1c8617f7af0d5d8e8d331db",
  "model_redesign/agenda_extension_AR_msb_interface.json" =
    "62caca71f0fd221a7e17026d7518d53b97713ff9c9d7f61a62a52f312120800b",
  "model_redesign/agenda_extension_AR_msb_complete_records.json" =
    "96d6045787200153f9d77cab9279053ad97a3076d2c23782b16b8f3e2ff6cca8",
  "quality_reports/2026-08-30_A_R_msb_final_gate_manifest.sha256" =
    "a57696cac12d3b3910cd7406842ea9d270df6193e4c696e455e06722447c8e38",
  "model_redesign/essential_input_n7_complete_information_benchmark_candidate.json" =
    "4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45"
)

for (path in names(source_hashes)) {
  check(sprintf("frozen/source byte hash: %s", path),
        file.exists(path) && identical(sha256(path), source_hashes[[path]]))
}
check("A_R final manifest verifies", check_manifest(
  "quality_reports/2026-08-30_A_R_msb_final_gate_manifest.sha256"
))

candidate_paths <- c(
  "model_redesign/agenda_extension_AT_msb_contract.md",
  "model_redesign/agenda_extension_AT_msb_results.md",
  "model_redesign/agenda_extension_AT_msb_interface.json",
  "model_redesign/agenda_extension_AT_msb_complete_records.json",
  "model_redesign/agenda_extension_AT_msb_claim_ledger.tsv"
)
for (path in candidate_paths) {
  check(sprintf("candidate artifact exists: %s", path), file.exists(path))
}

json_paths <- c(
  "model_redesign/agenda_extension_AT_msb_interface.json",
  "model_redesign/agenda_extension_AT_msb_complete_records.json"
)
json_status <- vapply(json_paths, function(path) {
  status <- suppressWarnings(system2(
    "python3", c("-m", "json.tool", path), stdout = FALSE, stderr = FALSE
  ))
  if (is.null(status)) 0L else as.integer(status)
}, integer(1L))
check("AT interface and complete-record export are valid JSON", all(json_status == 0L))

ledger <- read.delim(
  "model_redesign/agenda_extension_AT_msb_claim_ledger.tsv",
  sep = "\t", quote = "", stringsAsFactors = FALSE,
  check.names = FALSE, encoding = "UTF-8"
)
expected_columns <- c(
  "claim_id", "node_id", "cell_id", "record_or_family_id",
  "member_domain", "claim_kind", "claim_text", "domain", "status",
  "selection_status", "assumptions_used", "source_record_ids",
  "source_hashes", "payoff_date", "evidence_path", "proof_path"
)
check("AT ledger has exact 16-column schema", identical(names(ledger), expected_columns))
check("AT ledger has 22 unique sequential claims",
      nrow(ledger) == 22L && !anyDuplicated(ledger$claim_id) &&
        identical(ledger$claim_id, sprintf("AT-MSB-%03d", seq_len(22L))))
check("all AT ledger claims are proved candidate claims", all(ledger$status == "proved"))
check("all AT ledger payoffs are dated A", all(ledger$payoff_date == "A"))

contract_text <- paste(readLines(candidate_paths[[1L]], warn = FALSE, encoding = "UTF-8"), collapse = "\n")
results_text <- paste(readLines(candidate_paths[[2L]], warn = FALSE, encoding = "UTF-8"), collapse = "\n")
interface_text <- paste(readLines(candidate_paths[[3L]], warn = FALSE, encoding = "UTF-8"), collapse = "\n")
complete_records_text <- paste(
  readLines(candidate_paths[[4L]], warn = FALSE, encoding = "UTF-8"),
  collapse = "\n"
)

required_contract_strings <- c(
  "T_g^theta=D_g^theta+I_g^theta",
  "DeltaT^theta=DeltaD^theta+DeltaI^theta",
  "compara dois pacotes",
  "`beta` aparece uma única vez",
  "seleção cross-world",
  "**obrigatória**"
)
for (needle in required_contract_strings) {
  check(sprintf("contract contains required guard: %s", needle),
        grepl(needle, contract_text, fixed = TRUE, useBytes = TRUE))
}

required_result_strings <- c(
  "T_U=none",
  "T_M^{01}=D_M^{01}+I_M^{01}",
  "Q_g^theta=h_g^A(o_theta)-beta*V_g^{N,R1,theta}",
  "efeito causal puro",
  "sinal geral autorizado"
)
for (needle in required_result_strings) {
  check(sprintf("results contain required result/limit: %s", needle),
        grepl(needle, results_text, fixed = TRUE, useBytes = TRUE))
}

required_interface_strings <- c(
  "with_agenda_minus_without_agenda",
  "T_g^theta=D_g^theta+I_g^theta",
  "set_valued_no_general_sign",
  "not_a_single_factor_causal_effect",
  "if any required arm is none, the composed effect is none",
  "AT-T-U-HIGH-NONE"
)
for (needle in required_interface_strings) {
  check(sprintf("interface exposes required object: %s", needle),
        grepl(needle, interface_text, fixed = TRUE, useBytes = TRUE))
}

check(
  "results enumerate high-prior none and both U zero families",
  grepl("nu_off in (0,nu_star]", results_text, fixed = TRUE, useBytes = TRUE) &&
    grepl("coordenada contrafactual do tipo alto", results_text,
          fixed = TRUE, useBytes = TRUE) &&
    grepl("membro `u=d_H`", results_text, fixed = TRUE, useBytes = TRUE)
)
check(
  "complete records retain the linked u member domain",
  grepl(
    "{(u-d_H,u-d_H): u in [max{z_L,d_H},z_H]}",
    complete_records_text, fixed = TRUE, useBytes = TRUE
  )
)

set.seed(20260830)
grid <- expand.grid(
  N = 4:15,
  beta = c(0.2, 0.5, 0.8, 0.9, 0.97),
  o = seq(0.02, 0.98, length.out = 73),
  KEEP.OUT.ATTRS = FALSE
)

grid_DU <- logical(nrow(grid))
grid_DM <- logical(nrow(grid))
grid_DM_nonnegative <- logical(nrow(grid))
grid_DeltaD <- logical(nrow(grid))
for (idx in seq_len(nrow(grid))) {
  N <- grid$N[[idx]]
  beta <- grid$beta[[idx]]
  o <- grid$o[[idx]]
  m <- N - 1
  q <- floor(N / 2) + 1
  k <- q - 1
  c_excl <- m - k
  ZE <- 1 - k * beta / m
  tau <- ZE / beta

  hA_U <- 1 - beta + beta^2 * o
  hN_U <- beta * o
  DU_raw <- hA_U - beta * hN_U
  grid_DU[[idx]] <- close_num(DU_raw, 1 - beta)

  if (o <= 1 / m) {
    hA_M <- 1 - k * beta * (1 - beta * o) / m
    hN_M <- beta * o
    DM_formula <- ZE - (c_excl / m) * beta^2 * o
    DeltaD_formula <- -beta * (c_excl / m) * (1 - beta * o)
  } else {
    hA_M <- max(ZE, beta * o)
    hN_M <- o
    DM_formula <- max(ZE - beta * o, 0)
    if (o <= tau) {
      DeltaD_formula <- beta * (o - c_excl / m)
    } else {
      DeltaD_formula <- 1 - beta
    }
  }
  DM_raw <- hA_M - beta * hN_M
  grid_DM[[idx]] <- close_num(DM_raw, DM_formula)
  grid_DM_nonnegative[[idx]] <- DM_raw >= -1e-12
  grid_DeltaD[[idx]] <- close_num(DU_raw - DM_raw, DeltaD_formula)
}
check("full grid: D_U=1-beta", all(grid_DU))
check("full grid: D_M piecewise identity", all(grid_DM))
check("full grid: D_M is nonnegative", all(grid_DM_nonnegative))
check("full grid: DeltaD piecewise identity", all(grid_DeltaD))

sample_nu0 <- logical(250L)
sample_high <- logical(250L)
sample_bounds <- logical(250L)
sample_high_fixed <- logical(250L)
sample_q_nu0 <- logical(250L)
sample_q_high <- logical(250L)
sample_factorial <- logical(250L)
for (idx in seq_len(250L)) {
  beta <- runif(1L, 0.05, 0.99)
  o0 <- runif(1L, 0.01, 0.75)
  o1 <- runif(1L, o0 + 1e-4, 0.99)
  zL <- 1 - beta + beta^2 * o0
  dH <- beta^2 * o1
  zH <- 1 - beta + beta^2 * o1
  DeltaU <- zL - dH
  umin <- max(zL, dH)
  u <- runif(1L, umin, zH)

  agenda_nu0 <- c(zL, max(zL, dH))
  no_agenda_nu0_at_A <- c(beta^2 * o0, dH)
  T_nu0 <- agenda_nu0 - no_agenda_nu0_at_A
  sample_nu0[[idx]] <- close_num(T_nu0, c(1 - beta, max(DeltaU, 0)))

  T_high <- c(u, u) - c(dH, dH)
  sample_high[[idx]] <- close_num(T_high, c(u - dH, u - dH))
  sample_bounds[[idx]] <- all(T_high >= max(DeltaU, 0) - 1e-12) &&
    all(T_high <= 1 - beta + 1e-12)

  T_high_fixed <- c(zH, zH) - c(dH, dH)
  sample_high_fixed[[idx]] <- close_num(T_high_fixed, c(1 - beta, 1 - beta))

  Q_nu0 <- c(zL, zH) - no_agenda_nu0_at_A
  sample_q_nu0[[idx]] <- close_num(Q_nu0, c(1 - beta, 1 - beta))

  Q_high <- c(zL, zH) - c(dH, dH)
  sample_q_high[[idx]] <- close_num(Q_high, c(DeltaU, 1 - beta))

  hA <- runif(1L)
  hN <- runif(1L)
  riA <- runif(1L, -0.5, 0.5)
  riN <- runif(1L, -0.5, 0.5)
  D <- hA - beta * hN
  I <- riA - beta * riN
  T_direct <- (hA + riA) - beta * (hN + riN)
  sample_factorial[[idx]] <- close_num(T_direct, D + I)
}
check("250 samples: U nu=0 total effect identity", all(sample_nu0))
check("250 samples: U high-rho-zero total effect identity", all(sample_high))
check("250 samples: U high total effect stays in proved bounds", all(sample_bounds))
check("250 samples: U high fixed effect is 1-beta", all(sample_high_fixed))
check("250 samples: U diagonal at nu=0", all(sample_q_nu0))
check("250 samples: U diagonal at high prior", all(sample_q_high))
check("250 samples: generic factorial identity T=D+I", all(sample_factorial))

check("approved v6 Rmd remains unchanged",
      identical(sha256("formal_model_v6.Rmd"),
                "00bbaa3a5768348fede3f6584bab915b7c1dbf1fd1cccbf723bb64a90188e4a6"))
check("approved v6 PDF remains unchanged",
      identical(sha256("formal_model_v6.pdf"),
                "3602b0753a8a61ddcb2450f7181ba2f8fc53b9f73ad16cdfbb46e337019182be"))

cat("\n")
cat(sprintf("SUMMARY | %d PASS | %d FAIL\n", pass_count, fail_count))
if (fail_count > 0L) quit(status = 1L)
