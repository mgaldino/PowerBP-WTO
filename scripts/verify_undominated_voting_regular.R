#!/usr/bin/env Rscript

# Goal 3: reproducible checks for the regular-domain PBE-UD
# characterizations. This verifier does not source or alter any closed
# Goal 1/2 artifact.

options(stringsAsFactors = FALSE)

args_full <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args_full, value = TRUE)
if (length(file_arg) == 1L) {
  script_path <- sub("^--file=", "", file_arg)
  repo_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
} else {
  repo_root <- normalizePath(".", mustWork = TRUE)
}

tol <- 1e-10
checked_on <- "2026-08-04"
source_note <- "Goal 3 PBE-UD analytical rederivation"
checks <- list()

record_check <- function(id, pass, detail) {
  checks[[length(checks) + 1L]] <<- data.frame(
    check_id = id,
    pass = isTRUE(pass),
    detail = detail,
    checked_on = checked_on,
    source = source_note,
    stringsAsFactors = FALSE
  )
  invisible(pass)
}

geometry <- function(N, beta) {
  m <- N - 1
  q <- floor(N / 2) + 1
  k <- q - 1
  r <- q - 2
  c_value <- beta / m
  list(
    m = m,
    q = q,
    k = k,
    r = r,
    c = c_value,
    E = 1 - k * c_value
  )
}

regular_values <- function(N, beta, o0, o1, mu, bar_y) {
  stopifnot(
    N >= 3,
    beta > 0, beta < 1,
    o0 > 0, o0 < o1, o1 < 1,
    mu > 0, mu < 1,
    bar_y >= o1, bar_y <= 1
  )

  g <- geometry(N, beta)
  B <- (1 - mu) * (1 - o0 - g$r * g$c) + mu * g$c
  C <- 1 - o1 - g$r * g$c
  pool_threat <- bar_y > o1

  if (N == 3) {
    M_exists_TY <- TRUE
    M_value_TY <- max(g$E, B, C)
    M_class_TY <- paste(
      c("exclusion", "low_only", "pooling")[
        abs(c(g$E, B, C) - M_value_TY) < tol
      ],
      collapse = "+"
    )
  } else {
    M_exists_TY <- g$E + tol >= B &&
      (!pool_threat || g$E + tol >= C)
    M_value_TY <- if (M_exists_TY) g$E else NA_real_
    M_class_TY <- if (M_exists_TY) "exclusion" else "empty"
  }

  D <- 1 - o0
  P <- 1 - o1
  delta <- beta * (g$m - 1) / g$m
  a <- 1 - delta
  S_mu <- max((1 - mu) * D, P)
  K_low <- a * (1 - mu) * D
  K_pool <- P - delta * D
  K <- max(K_low, if (pool_threat) K_pool else -Inf)
  TY_limit <- P - delta * S_mu
  U_exists_TY <- pool_threat && TY_limit > K + tol
  eta_upper <- if (U_exists_TY) {
    min(bar_y - o1, TY_limit - K)
  } else {
    0
  }

  data.frame(
    N = N,
    m = g$m,
    q = g$q,
    k = g$k,
    r = g$r,
    beta = beta,
    o0 = o0,
    o1 = o1,
    mu = mu,
    bar_y = bar_y,
    c = g$c,
    M_E = g$E,
    M_B_sup = B,
    M_C_sup = C,
    M_pool_threat = pool_threat,
    M_exists_TY = M_exists_TY,
    M_value_TY = M_value_TY,
    M_class_TY = M_class_TY,
    U_D = D,
    U_P = P,
    U_delta = delta,
    U_S_mu = S_mu,
    U_K_low = K_low,
    U_K_pool = K_pool,
    U_K = K,
    U_TY_limit = TY_limit,
    U_exists_TY = U_exists_TY,
    U_eta_upper = eta_upper,
    checked_on = checked_on,
    source = source_note,
    stringsAsFactors = FALSE
  )
}

# Enumerate the endogenous number of c-paid supporters under majority.
enumerate_majority_classes <- function(row) {
  supporters <- 0:(row$m - 1)
  out <- list()
  for (s in supporters) {
    if (s >= row$k) {
      out[[length(out) + 1L]] <- data.frame(
        class = "exclusion",
        supporters = s,
        limiting_value = 1 - s * row$c
      )
    }

    low_residual <- 1 - row$o0 - s * row$c
    if (low_residual >= -tol) {
      low_value <- if (s == row$r) {
        (1 - row$mu) * low_residual + row$mu * row$c
      } else if (s >= row$k) {
        1 - s * row$c - (1 - row$mu) * row$o0
      } else {
        row$c
      }
      out[[length(out) + 1L]] <- data.frame(
        class = "low_only",
        supporters = s,
        limiting_value = low_value
      )
    }

    pool_residual <- 1 - row$o1 - s * row$c
    if (row$bar_y > row$o1 && pool_residual >= -tol) {
      pool_value <- if (s == row$r) pool_residual else if (s >= row$k) {
        1 - row$o1 - s * row$c
      } else {
        row$c
      }
      out[[length(out) + 1L]] <- data.frame(
        class = "pooling",
        supporters = s,
        limiting_value = pool_value
      )
    }
  }
  do.call(rbind, out)
}

# Evaluate one U candidate from the exact reduced system. This function is a
# numerical witness checker, not a proof of non-existence when a finite grid
# finds no candidate.
u_candidate <- function(N, beta, o0, o1, mu, bar_y, nu, A, y, extra = 0) {
  g <- geometry(N, beta)
  D <- 1 - o0
  P <- 1 - o1
  delta <- beta * (g$m - 1) / g$m
  a <- 1 - delta
  S_nu <- max((1 - nu) * D, P)
  c_nu <- beta * S_nu / g$m
  B_h <- (1 - mu) / (1 - nu)
  h1 <- nu * (1 - mu) / (mu * (1 - nu))
  residual <- 1 - y - delta * S_nu - extra
  proposer <- B_h * (A * residual + (1 - A) * c_nu)
  high_ic <- A * y + (1 - A) * beta * o1 - o1
  K_low <- a * (1 - mu) * D
  K_pool <- P - delta * D
  K <- max(K_low, if (bar_y > o1) K_pool else -Inf)
  semi <- nu < mu - tol
  feasible <- nu > 0 && nu <= mu + tol &&
    A > 0 && A <= 1 + tol &&
    y > o1 && y <= bar_y + tol &&
    residual >= -tol &&
    proposer + tol >= K &&
    high_ic >= -tol &&
    (!semi || abs(high_ic) < 1e-8)
  data.frame(
    N = N,
    beta = beta,
    o0 = o0,
    o1 = o1,
    mu = mu,
    bar_y = bar_y,
    nu = nu,
    A = A,
    y = y,
    extra = extra,
    h1 = h1,
    B_h = B_h,
    S_nu = S_nu,
    c_nu = c_nu,
    residual = residual,
    high_ic = high_ic,
    K = K,
    proposer = proposer,
    candidate_type = if (semi) "semi_pooling_H" else if (A < 1 - tol) {
      "pure_H_pooling_weak_mix"
    } else {
      "pure_pooling_TY"
    },
    feasible = feasible,
    checked_on = checked_on,
    source = source_note,
    stringsAsFactors = FALSE
  )
}

grid <- expand.grid(
  N = 3:10,
  beta = c(0.2, 0.5, 0.9),
  o0 = c(0.05, 0.2, 0.5),
  o1 = c(0.3, 0.6, 0.9),
  mu = c(0.1, 0.5, 0.9),
  capacity_gap = c(0, 0.05),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
grid <- grid[grid$o0 < grid$o1, , drop = FALSE]
grid$bar_y <- pmin(1, grid$o1 + grid$capacity_gap)
regions <- do.call(rbind, lapply(seq_len(nrow(grid)), function(idx) {
  g <- grid[idx, ]
  regular_values(g$N, g$beta, g$o0, g$o1, g$mu, g$bar_y)
}))

for (idx in seq_len(nrow(regions))) {
  row <- regions[idx, ]
  classes <- enumerate_majority_classes(row)

  max_E <- max(classes$limiting_value[classes$class == "exclusion"], -Inf)
  record_check(
    sprintf("M_min_support_%04d", idx),
    abs(max_E - row$M_E) < tol,
    sprintf("enumerated=%.8f; E=%.8f", max_E, row$M_E)
  )

  low_r <- classes[
    classes$class == "low_only" & classes$supporters == row$r,
    ,
    drop = FALSE
  ]
  low_r_feasible <- 1 - row$o0 - row$r * row$c >= -tol
  record_check(
    sprintf("M_low_r_branch_%04d", idx),
    if (low_r_feasible) {
      nrow(low_r) == 1L && abs(low_r$limiting_value - row$M_B_sup) < tol
    } else {
      nrow(low_r) == 0L && row$M_B_sup <= row$M_E + tol
    },
    sprintf(
      "feasible=%s; enumerated=%s; B=%.8f",
      low_r_feasible,
      if (nrow(low_r) == 1L) sprintf("%.8f", low_r$limiting_value) else "absent",
      row$M_B_sup
    )
  )

  pool_r <- classes[
    classes$class == "pooling" & classes$supporters == row$r,
    ,
    drop = FALSE
  ]
  pool_r_feasible <- row$M_pool_threat &&
    1 - row$o1 - row$r * row$c >= -tol
  record_check(
    sprintf("M_pool_r_branch_%04d", idx),
    if (pool_r_feasible) {
      nrow(pool_r) == 1L && abs(pool_r$limiting_value - row$M_C_sup) < tol
    } else {
      nrow(pool_r) == 0L &&
        (!row$M_pool_threat || row$M_C_sup <= row$M_E + tol)
    },
    sprintf(
      "active_feasible=%s; enumerated=%s; C=%.8f",
      pool_r_feasible,
      if (nrow(pool_r) == 1L) sprintf("%.8f", pool_r$limiting_value) else "absent",
      row$M_C_sup
    )
  )

  pool_weak_only <- classes[
    classes$class == "pooling" & classes$supporters >= row$k,
    ,
    drop = FALSE
  ]
  possible_supporters <- row$k:(row$m - 1)
  expected_pool_supporters <- if (row$M_pool_threat) {
    possible_supporters[
      1 - row$o1 - possible_supporters * row$c >= -tol
    ]
  } else {
    integer(0)
  }
  actual_pool_supporters <- pool_weak_only$supporters
  pool_support_values_match <- nrow(pool_weak_only) == 0L || all(
    abs(
      pool_weak_only$limiting_value -
        (1 - row$o1 - actual_pool_supporters * row$c)
    ) < tol
  )
  record_check(
    sprintf("M_pool_weak_support_branch_%04d", idx),
    identical(as.integer(actual_pool_supporters), as.integer(expected_pool_supporters)) &&
      pool_support_values_match,
    sprintf(
      "actual=%s; expected=%s",
      paste(actual_pool_supporters, collapse = ","),
      paste(expected_pool_supporters, collapse = ",")
    )
  )

  if (row$N >= 4) {
    expected <- row$M_E + tol >= row$M_B_sup &&
      (!row$M_pool_threat || row$M_E + tol >= row$M_C_sup)
    record_check(
      sprintf("M_exists_Nge4_%04d", idx),
      identical(row$M_exists_TY, expected),
      sprintf(
        "exists=%s; E=%.8f; B=%.8f; C=%.8f; pool=%s",
        row$M_exists_TY,
        row$M_E,
        row$M_B_sup,
        row$M_C_sup,
        row$M_pool_threat
      )
    )
    record_check(
      sprintf("M_pool_identity_%04d", idx),
      abs((row$M_E - row$M_C_sup) - (row$o1 - row$c)) < tol,
      sprintf("E-C=%.8f; o1-c=%.8f", row$M_E - row$M_C_sup, row$o1 - row$c)
    )
    if (row$o0 < row$c) {
      cutoff <- (row$c - row$o0) / (row$M_E - row$o0)
      record_check(
        sprintf("M_prior_cutoff_%04d", idx),
        cutoff > 0 && cutoff < 1 &&
          ((row$M_E + tol >= row$M_B_sup) == (row$mu + tol >= cutoff)),
        sprintf("cutoff=%.8f; mu=%.8f", cutoff, row$mu)
      )
    } else {
      record_check(
        sprintf("M_o0_ge_c_%04d", idx),
        row$M_E + tol >= row$M_B_sup,
        sprintf("o0=%.8f; c=%.8f", row$o0, row$c)
      )
    }
  } else {
    record_check(
      sprintf("M_N3_TY_%04d", idx),
      row$M_exists_TY &&
        abs(row$M_value_TY - max(row$M_E, row$M_B_sup, row$M_C_sup)) < tol,
      sprintf("value=%.8f", row$M_value_TY)
    )
  }

  record_check(
    sprintf("U_cap_empty_TY_%04d", idx),
    if (abs(row$bar_y - row$o1) < tol) !row$U_exists_TY else TRUE,
    sprintf("bar_y=%.8f; o1=%.8f", row$bar_y, row$o1)
  )
  record_check(
    sprintf("U_TY_condition_%04d", idx),
    row$U_exists_TY ==
      (row$bar_y > row$o1 && row$U_TY_limit > row$U_K + tol),
    sprintf("limit=%.8f; K=%.8f", row$U_TY_limit, row$U_K)
  )
}

# Closed-form examples used in the derivation.
pure_example <- u_candidate(
  N = 3, beta = 0.2, o0 = 0.05, o1 = 0.4, mu = 0.5,
  bar_y = 0.5, nu = 0.5, A = 1, y = 0.42
)
record_check(
  "U_pure_overpaid_witness",
  pure_example$feasible && abs(pure_example$proposer - 0.52) < 1e-8,
  sprintf("Pi=%.8f; K=%.8f", pure_example$proposer, pure_example$K)
)

weak_mix_example <- u_candidate(
  N = 4, beta = 0.5, o0 = 0.01, o1 = 0.16, mu = 0.23,
  bar_y = 0.2, nu = 0.23, A = 0.9, y = 0.168888888888889
)
record_check(
  "U_pure_H_weak_mix_endpoint",
  weak_mix_example$feasible &&
    abs(weak_mix_example$proposer - weak_mix_example$K) < 1e-7,
  sprintf("Pi=%.8f; K=%.8f", weak_mix_example$proposer, weak_mix_example$K)
)

semi_example <- u_candidate(
  N = 9, beta = 0.9, o0 = 0.05, o1 = 0.15, mu = 0.5,
  bar_y = 0.2, nu = 0.49, A = 0.95,
  y = 0.9 * 0.15 + 0.1 * 0.15 / 0.95
)
record_check(
  "U_semi_pooling_witness",
  semi_example$feasible &&
    abs(semi_example$h1 - 0.96078431372549) < 1e-8,
  sprintf(
    "Pi=%.8f; K=%.8f; h1=%.8f",
    semi_example$proposer,
    semi_example$K,
    semi_example$h1
  )
)

# Diagnostic N=5, q=3: one c-paid weak supporter includes H; two exclude H.
diag <- regular_values(
  N = 5, beta = 0.9, o0 = 0.05, o1 = 0.4, mu = 0.1, bar_y = 0.4
)
record_check(
  "M_N5_q3_support_geometry",
  diag$q == 3 && diag$r == 1 && diag$k == 2 &&
    abs((diag$o1 + diag$r * diag$c) - (diag$o1 + diag$c)) < tol &&
    abs(diag$k * diag$c - 2 * diag$c) < tol,
  sprintf(
    "include_cost=%.8f; exclude_cost=%.8f",
    diag$o1 + diag$r * diag$c,
    diag$k * diag$c
  )
)
record_check(
  "M_N5_nonexistence_witness",
  !diag$M_exists_TY && diag$M_B_sup > diag$M_E,
  sprintf("E=%.8f; B=%.8f", diag$M_E, diag$M_B_sup)
)

tests <- do.call(rbind, checks)
candidate_examples <- rbind(pure_example, weak_mix_example, semi_example)

dir.create(file.path(repo_root, "tables"), recursive = TRUE, showWarnings = FALSE)
utils::write.csv(
  regions,
  file.path(repo_root, "tables", "undominated_voting_regular_regions.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)
utils::write.csv(
  candidate_examples,
  file.path(repo_root, "tables", "undominated_voting_unanimity_candidates.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)
utils::write.csv(
  tests,
  file.path(repo_root, "tables", "undominated_voting_regular_checks.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat(sprintf("Regular-domain checks: %d/%d PASS\n", sum(tests$pass), nrow(tests)))
cat(sprintf("Parameter rows: %d\n", nrow(regions)))
cat(sprintf("U candidate witnesses: %d\n", nrow(candidate_examples)))

if (any(!tests$pass)) {
  print(tests[!tests$pass, , drop = FALSE])
  quit(status = 1L)
}
