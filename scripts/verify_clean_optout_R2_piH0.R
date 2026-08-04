#!/usr/bin/env Rscript

options(warn = 1)

started_at <- Sys.time()
script_name <- "scripts/verify_clean_optout_R2_piH0.R"
output_path <- "tables/clean_optout_R2_checks_piH0.csv"
log_path <- "quality_reports/logs/verify_clean_optout_R2_piH0.log"

checks <- data.frame(
  check_id = character(),
  passed = logical(),
  detail = character(),
  stringsAsFactors = FALSE
)

add_check <- function(check_id, passed, detail) {
  checks <<- rbind(
    checks,
    data.frame(
      check_id = check_id,
      passed = isTRUE(passed),
      detail = as.character(detail),
      stringsAsFactors = FALSE
    )
  )
}

tol <- 1e-10
near <- function(x, y) all(abs(x - y) < tol)

grid <- expand.grid(
  n_states = 3:20,
  o0 = c(0, 0.05, 0.2, 0.45),
  o1 = c(0.1, 0.3, 0.6, 0.9, 1),
  nu = c(0, 0.1, 0.35, 0.7, 0.95, 1),
  beta = c(0.2, 0.7, 1),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
grid <- grid[grid$o1 > grid$o0, , drop = FALSE]
grid$m <- grid$n_states - 1L
grid$q <- floor(grid$n_states / 2) + 1L
grid$P <- 1 - grid$o1
grid$L <- (1 - grid$nu) * (1 - grid$o0)
grid$S <- pmax(grid$P, grid$L)
grid$nu_star <- (grid$o1 - grid$o0) / (1 - grid$o0)
grid$c_majority <- grid$beta / grid$m

add_check(
  "u_terminal_value_is_max",
  all(grid$S + tol >= grid$P & grid$S + tol >= grid$L),
  sprintf("%d terminal unanimity grid rows", nrow(grid))
)
add_check(
  "u_cutoff_selects_low_below",
  all(grid$L[grid$nu < grid$nu_star] > grid$P[grid$nu < grid$nu_star]),
  "L(nu)>P below the terminal cutoff"
)
add_check(
  "u_cutoff_selects_pooling_above",
  all(grid$P[grid$nu > grid$nu_star] > grid$L[grid$nu > grid$nu_star]),
  "P>L(nu) above the terminal cutoff"
)

tie_grid <- expand.grid(
  o0 = c(0, 0.1, 0.4),
  o1 = c(0.2, 0.6, 0.95),
  KEEP.OUT.ATTRS = FALSE
)
tie_grid <- tie_grid[tie_grid$o1 > tie_grid$o0, , drop = FALSE]
tie_grid$nu <- (tie_grid$o1 - tie_grid$o0) / (1 - tie_grid$o0)
tie_grid$P <- 1 - tie_grid$o1
tie_grid$L <- (1 - tie_grid$nu) * (1 - tie_grid$o0)
add_check(
  "u_cutoff_tie_identity",
  near(tie_grid$P, tie_grid$L),
  "P=L(nu*) exactly up to numerical tolerance"
)
add_check(
  "majority_original_quota_is_feasible",
  all(grid$q <= grid$m),
  "q<=m for every N>=3"
)
add_check(
  "majority_R2_continuation_range",
  all(grid$c_majority > 0 & grid$c_majority <= 1 / grid$m + tol),
  "c=beta/m is positive and no larger than 1/m"
)

p_values <- c(0, 0.1, 0.4, 1)
y_values <- c(0, 0.2, 0.7, 1)
o_values <- c(0, 0.15, 0.65, 1)
ic_grid <- expand.grid(p = p_values, y = y_values, o = o_values)
ic_grid$beta <- 0.83
ic_grid$eu_yes <- ic_grid$beta * (
  ic_grid$p * ic_grid$y + (1 - ic_grid$p) * ic_grid$o
)
ic_grid$eu_no <- ic_grid$beta * ic_grid$o
ic_grid$difference <- ic_grid$eu_yes - ic_grid$eu_no
add_check(
  "terminal_H_IC_factorization",
  near(
    ic_grid$difference,
    ic_grid$beta * ic_grid$p * (ic_grid$y - ic_grid$o)
  ),
  "EU_H(yes) and EU_H(no) are constructed separately"
)
add_check(
  "terminal_H_zero_implementation_tie",
  all(abs(ic_grid$difference[ic_grid$p == 0]) < tol),
  "p=0 makes H indifferent, invoking tie-yes"
)

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
dir.create(dirname(log_path), recursive = TRUE, showWarnings = FALSE)
utils::write.csv(checks, output_path, row.names = FALSE, fileEncoding = "UTF-8")

ended_at <- Sys.time()
passed_n <- sum(checks$passed)
total_n <- nrow(checks)
git_sha <- tryCatch(
  system2("git", c("rev-parse", "HEAD"), stdout = TRUE, stderr = FALSE)[1],
  error = function(e) "unavailable"
)
if (length(git_sha) == 0L || is.na(git_sha)) git_sha <- "unavailable"
session_lines <- sub("[[:space:]]+$", "", capture.output(utils::sessionInfo()))
log_lines <- c(
  sprintf("script=%s", script_name),
  sprintf("git_head_at_execution=%s", git_sha),
  sprintf("started_at=%s", format(started_at, tz = "America/Sao_Paulo")),
  sprintf("ended_at=%s", format(ended_at, tz = "America/Sao_Paulo")),
  paste0(
    "inputs=n_states:3:20;o0:0,0.05,0.2,0.45;",
    "o1:0.1,0.3,0.6,0.9,1;nu:0,0.1,0.35,0.7,0.95,1;",
    "beta:0.2,0.7,1;IC_beta:0.83"
  ),
  sprintf("grid_rows=%d", nrow(grid)),
  sprintf("ic_grid_rows=%d", nrow(ic_grid)),
  sprintf("output=%s", output_path),
  sprintf("passed=%d", passed_n),
  sprintf("total=%d", total_n),
  sprintf("status=%s", if (passed_n == total_n) "PASS" else "FAIL"),
  sprintf(
    "failed_checks=%s",
    paste(checks$check_id[!checks$passed], collapse = ",")
  ),
  "session_info_begin",
  session_lines,
  "session_info_end"
)
writeLines(log_lines, log_path, useBytes = TRUE)

cat(
  sprintf(
    "R2 checks: %d/%d passed. Output: %s. Log: %s.\n",
    passed_n,
    total_n,
    output_path,
    log_path
  )
)

if (passed_n != total_n) {
  quit(status = 1L)
}
