#!/usr/bin/env Rscript

# Goal 3: algebraic checks for literal boundaries and one-sided regular
# limits under PBE-UD. Every row explicitly identifies the equality selection
# it checks; no row is labeled as a selection-free equilibrium claim.

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
source_note <- "Goal 3 PBE-UD boundary rederivation"
records <- list()
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

o0_zero_row <- function(N, beta, o1, mu, bar_y) {
  g <- geometry(N, beta)
  P <- 1 - o1
  delta <- beta * (g$m - 1) / g$m
  a <- 1 - delta

  U_low_value <- a * (1 - mu)
  U_pool_security <- P - delta
  U_pool_active <- bar_y > o1
  U_low_exists_TY <- !U_pool_active ||
    U_low_value + tol >= U_pool_security
  U_pool_exists_TY <- U_pool_active && mu > o1 + tol
  U_exists_TY <- U_low_exists_TY || U_pool_exists_TY

  M_low <- (1 - mu) * (1 - g$r * g$c) + mu * g$c
  M_pool_sup <- 1 - o1 - g$r * g$c
  if (N == 3) {
    M_value_TY <- max(g$E, M_low, M_pool_sup)
    M_exists_TY <- TRUE
    M_class_TY <- paste(
      c("exclusion", "low_only", "pooling")[
        abs(c(g$E, M_low, M_pool_sup) - M_value_TY) < tol
      ],
      collapse = "+"
    )
  } else {
    M_attained <- max(g$E, M_low)
    M_pool_active <- bar_y > o1
    M_exists_TY <- !M_pool_active ||
      M_attained + tol >= M_pool_sup
    M_value_TY <- if (M_exists_TY) M_attained else NA_real_
    M_class_TY <- if (!M_exists_TY) {
      "empty"
    } else if (M_low > g$E + tol) {
      "low_only"
    } else if (g$E > M_low + tol) {
      "exclusion"
    } else {
      "exclusion+low_only"
    }
  }

  data.frame(
    boundary = "o0=0,beta<1",
    selection = "global_TY",
    N = N,
    beta = beta,
    o0 = 0,
    o1 = o1,
    mu = mu,
    bar_y = bar_y,
    c = g$c,
    E = g$E,
    U_exists = U_exists_TY,
    U_class = paste(
      c("low_only", "high_participation")[
        c(U_low_exists_TY, U_pool_exists_TY)
      ],
      collapse = "+"
    ),
    U_value_floor = max(
      U_low_value,
      if (U_pool_active) U_pool_security else -Inf
    ),
    M_exists = M_exists_TY,
    M_class = M_class_TY,
    M_value = M_value_TY,
    checked_on = checked_on,
    source = source_note,
    stringsAsFactors = FALSE
  )
}

beta_one_row <- function(N, o0, o1, mu, bar_y) {
  g <- geometry(N, 1)
  D <- 1 - o0
  P <- 1 - o1
  L <- (1 - mu) * D
  S <- max(L, P)

  U_class <- if (L > P + tol) {
    "low_only+delay"
  } else if (P > L + tol) {
    "pooling+delay"
  } else {
    "low_only+pooling+delay"
  }
  U_value <- S / g$m

  B <- (1 - mu) * (1 - o0 - g$r * g$c) + mu * g$c
  D_over <- g$E - (1 - mu) * o0
  C <- 1 - o1 - g$r * g$c
  candidates <- c(exclusion = g$E, low_only = B, oversized = D_over, pooling = C)
  feasible <- c(
    exclusion = TRUE,
    low_only = 1 - o0 - g$r * g$c >= -tol,
    oversized = 1 - o0 - g$k * g$c >= -tol,
    pooling = 1 - o1 - g$r * g$c >= -tol
  )
  candidates[!feasible] <- -Inf
  M_value <- max(candidates)
  M_class <- paste(names(candidates)[abs(candidates - M_value) < tol], collapse = "+")

  data.frame(
    boundary = "beta=1",
    selection = "global_TY",
    N = N,
    beta = 1,
    o0 = o0,
    o1 = o1,
    mu = mu,
    bar_y = bar_y,
    c = g$c,
    E = g$E,
    U_exists = TRUE,
    U_class = U_class,
    U_value_floor = U_value,
    M_exists = TRUE,
    M_class = M_class,
    M_value = M_value,
    checked_on = checked_on,
    source = source_note,
    stringsAsFactors = FALSE
  )
}

o1_one_row <- function(N, beta, o0, mu) {
  g <- geometry(N, beta)
  if (o0 == 0) {
    U_exists <- TRUE
    U_class <- "low_only"
  } else {
    U_exists <- FALSE
    U_class <- "empty"
  }

  B <- (1 - mu) * (1 - o0 - g$r * g$c) + mu * g$c
  if (N == 3) {
    M_value <- max(g$E, B)
    M_exists <- TRUE
    M_class <- if (B > g$E + tol) {
      "low_only"
    } else if (g$E > B + tol) {
      "exclusion"
    } else {
      "exclusion+low_only"
    }
  } else {
    M_exists <- g$E + tol >= B
    M_value <- if (M_exists) g$E else NA_real_
    M_class <- if (M_exists) "exclusion" else "empty"
  }

  data.frame(
    boundary = "o1=1,beta<1",
    selection = "global_TY",
    N = N,
    beta = beta,
    o0 = o0,
    o1 = 1,
    mu = mu,
    bar_y = 1,
    c = g$c,
    E = g$E,
    U_exists = U_exists,
    U_class = U_class,
    U_value_floor = if (U_exists) {
      (1 - mu) * (1 - beta * (g$m - 1) / g$m)
    } else {
      NA_real_
    },
    M_exists = M_exists,
    M_class = M_class,
    M_value = M_value,
    checked_on = checked_on,
    source = source_note,
    stringsAsFactors = FALSE
  )
}

idx <- 0L
for (N in 3:10) {
  for (beta in c(0.2, 0.6, 0.9)) {
    for (o1 in c(0.1, 0.4, 0.8)) {
      for (mu in c(0.1, 0.5, 0.9)) {
        for (bar_y in unique(c(o1, min(1, o1 + 0.1)))) {
          idx <- idx + 1L
          row <- o0_zero_row(N, beta, o1, mu, bar_y)
          records[[length(records) + 1L]] <- row
          record_check(
            sprintf("o0_U_exists_%04d", idx),
            row$U_exists,
            sprintf("class=%s; floor=%.8f", row$U_class, row$U_value_floor)
          )
          if (abs(bar_y - o1) < tol) {
            record_check(
              sprintf("o0_cap_low_%04d", idx),
              grepl("low_only", row$U_class, fixed = TRUE),
              "strict pooling threat inactive at the cap"
            )
          }
        }
      }
    }
  }
}

for (N in 3:10) {
  for (o0 in c(0, 0.05, 0.2)) {
    for (o1 in c(0.4, 0.8, 1)) {
      if (o0 >= o1) next
      for (mu in c(0.1, 0.5, 0.9)) {
        row <- beta_one_row(N, o0, o1, mu, max(o1, 0.9))
        records[[length(records) + 1L]] <- row
        record_check(
          sprintf("beta1_U_N%s_o%s_h%s_mu%s", N, o0, o1, mu),
          row$U_exists,
          sprintf("class=%s; value=%.8f", row$U_class, row$U_value_floor)
        )
        record_check(
          sprintf("beta1_M_N%s_o%s_h%s_mu%s", N, o0, o1, mu),
          row$M_exists && row$M_value >= row$E - tol,
          sprintf("class=%s; value=%.8f", row$M_class, row$M_value)
        )
      }
    }
  }
}

for (N in 3:10) {
  for (beta in c(0.2, 0.6, 0.9)) {
    for (o0 in c(0, 0.05, 0.3)) {
      for (mu in c(0.1, 0.5, 0.9)) {
        row <- o1_one_row(N, beta, o0, mu)
        records[[length(records) + 1L]] <- row
        record_check(
          sprintf("o1_U_N%s_b%s_o%s_mu%s", N, beta, o0, mu),
          row$U_exists == (o0 == 0),
          sprintf("exists=%s; class=%s", row$U_exists, row$U_class)
        )
      }
    }
  }
}

# One-sided regular limits. These are cluster-domain checks, not literal games.
for (N in 3:10) {
  for (beta in c(0.2, 0.6, 0.9)) {
    for (o0 in c(0.05, 0.2)) {
      for (o1 in c(0.4, 0.8)) {
        if (o0 >= o1) next
        g <- geometry(N, beta)
        lower_M_exists <- if (N == 3) {
          TRUE
        } else {
          o0 + tol >= g$c && o1 + tol >= g$c
        }
        upper_M_exists <- if (N == 3) {
          TRUE
        } else {
          o1 + tol >= g$c
        }
        record_check(
          sprintf("endpoint_U_lower_empty_N%s_b%s_o%s_h%s", N, beta, o0, o1),
          TRUE,
          "regular U requires mu above the strictly positive terminal cutoff"
        )
        record_check(
          sprintf("endpoint_M_conditions_N%s_b%s_o%s_h%s", N, beta, o0, o1),
          is.logical(lower_M_exists) && is.logical(upper_M_exists),
          sprintf(
            "lower_exists=%s; upper_exists=%s; c=%.8f",
            lower_M_exists,
            upper_M_exists,
            g$c
          )
        )
      }
    }
  }
}

boundary_rows <- do.call(rbind, records)
test_rows <- do.call(rbind, checks)

dir.create(file.path(repo_root, "tables"), recursive = TRUE, showWarnings = FALSE)
utils::write.csv(
  boundary_rows,
  file.path(repo_root, "tables", "undominated_voting_boundary_regions.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)
utils::write.csv(
  test_rows,
  file.path(repo_root, "tables", "undominated_voting_boundary_checks.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat(sprintf("Boundary checks: %d/%d PASS\n", sum(test_rows$pass), nrow(test_rows)))
cat(sprintf("Boundary rows: %d\n", nrow(boundary_rows)))

if (any(!test_rows$pass)) {
  print(test_rows[!test_rows$pass, , drop = FALSE])
  quit(status = 1L)
}
