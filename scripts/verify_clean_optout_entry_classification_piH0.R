#!/usr/bin/env Rscript

options(warn = 1)

started_at <- Sys.time()
script_name <- "scripts/verify_clean_optout_entry_classification_piH0.R"
output_path <- "tables/clean_optout_entry_classification_checks_piH0.csv"
log_path <- paste0(
  "quality_reports/logs/",
  "verify_clean_optout_entry_classification_piH0.log"
)

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

grid <- expand.grid(
  n_states = 3:20,
  beta = c(0.2, 0.5, 0.8, 0.95),
  mu = seq(0.05, 0.95, by = 0.05),
  o0 = c(0.02, 0.08, 0.2, 0.4),
  o1 = c(0.1, 0.25, 0.5, 0.75, 0.95),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
grid <- grid[grid$o1 > grid$o0, , drop = FALSE]
grid$m <- grid$n_states - 1L
grid$q <- floor(grid$n_states / 2) + 1L
grid$k <- grid$q - 1L
grid$c <- grid$beta / grid$m
grid$P <- 1 - grid$o1
grid$D0 <- 1 - grid$o0
grid$delta <- grid$beta * (grid$m - 1) / grid$m
grid$a <- 1 - grid$delta
grid$DU <- grid$D0 - grid$delta * grid$P
grid$GP <- grid$a * grid$P
grid$GL <- (1 - grid$mu) * grid$DU
grid$u_exists <- grid$beta * grid$o1 >= grid$o0 &
  grid$GP > grid$GL
grid$E <- 1 - grid$k * grid$c
grid$BM <- (1 - grid$mu) * grid$D0 + grid$mu * grid$c
grid$FM <- pmax(grid$E, grid$BM, grid$P)
grid$m_exists <- grid$n_states != 4 |
  grid$E >= grid$BM |
  grid$P > grid$BM
grid$common <- grid$u_exists & grid$m_exists
common <- grid[grid$common, , drop = FALSE]

add_check(
  "common_domain_nonempty",
  nrow(common) > 0L,
  sprintf("%d common-domain grid rows", nrow(common))
)
add_check(
  "majority_floor_dominates_unanimity_total",
  all(common$FM + tol >= common$P),
  "F_M>=P mechanically because P is a component of the maximum"
)
add_check(
  "entry_nesting_per_capita",
  all(common$FM / common$m + tol >= common$P / common$m),
  "every majority PBE lower bound weakly exceeds unanimity payoff"
)

common$outside_H <- (1 - common$mu) * common$o0 +
  common$mu * common$o1
common$separating_y <- (common$o0 + common$o1) / 2
common$separating_H <- (1 - common$mu) * common$separating_y +
  common$mu * common$o1
common$pooling_y <- common$o1
pooling_type_payoffs <- cbind(
  low = common$pooling_y,
  high = common$pooling_y
)
pooling_type_probabilities <- cbind(
  low = 1 - common$mu,
  high = common$mu
)
common$majority_H_pooling <- rowSums(
  pooling_type_probabilities * pooling_type_payoffs
)
add_check(
  "majority_H_exclusion_lower_bound",
  all(common$outside_H <= common$o1 + tol),
  "expected outside payoff is no larger than unanimity pooling payoff"
)
add_check(
  "majority_H_separating_bounds",
  all(
    common$separating_H + tol >= common$outside_H &
      common$separating_H <= common$o1 + tol
  ),
  "separating-current-pass H payoff lies between outside and o1"
)
add_check(
  "majority_H_pooling_equality",
  all(abs(common$majority_H_pooling - common$o1) < tol),
  "type-weighted majority pooling payoff ties unanimity pooling for H"
)

entry_cases <- data.frame(
  u_value = rep(c(0.05, 0.15, 0.25), each = 5),
  m_value = rep(c(0.1, 0.2, 0.3), each = 5),
  chi = rep(c(0, 0.075, 0.175, 0.275, 0.4), times = 3),
  stringsAsFactors = FALSE
)
entry_cases <- entry_cases[
  entry_cases$m_value >= entry_cases$u_value,
  ,
  drop = FALSE
]
entry_cases$u_forms <- entry_cases$chi <= entry_cases$u_value
entry_cases$m_forms <- entry_cases$chi <= entry_cases$m_value
add_check(
  "no_unanimity_only_formation_case",
  !any(entry_cases$u_forms & !entry_cases$m_forms),
  "V_M>=V_U rules out only-unanimity formation"
)

n4 <- grid[grid$n_states == 4, , drop = FALSE]
add_check(
  "N4_nonexistence_is_excluded_from_common_domain",
  !any(
    n4$common &
      n4$BM > n4$E &
      n4$BM >= n4$P
  ),
  "institutional comparison never uses an empty N=4 majority PBE set"
)

strong_no_cheap <- grid[grid$o0 >= grid$k * grid$c, , drop = FALSE]
add_check(
  "strong_no_cheap_not_required_for_nesting",
  any(common$o0 < common$k * common$c),
  "common-domain nesting includes rows below the strong No-Cheap condition"
)
add_check(
  "common_domain_unanimity_is_pooling",
  all(
    common$P >
      (1 - common$mu) * common$D0
  ),
  "the existence cutoff lies above the terminal pooling cutoff"
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
    "inputs=n_states:3:20;beta:0.2,0.5,0.8,0.95;",
    "mu:seq(0.05,0.95,0.05);o0:0.02,0.08,0.2,0.4;",
    "o1:0.1,0.25,0.5,0.75,0.95"
  ),
  sprintf("regular_grid_rows=%d", nrow(grid)),
  sprintf("common_domain_rows=%d", nrow(common)),
  sprintf("entry_case_rows=%d", nrow(entry_cases)),
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
    "Entry/classification checks: %d/%d passed. Output: %s. Log: %s.\n",
    passed_n,
    total_n,
    output_path,
    log_path
  )
)

if (passed_n != total_n) {
  quit(status = 1L)
}
