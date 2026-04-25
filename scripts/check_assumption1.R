# Check when Assumption 1 (E_U is upper interval) fails
# E_U = {mu : V_W^R1(mu, U) >= c}
# Fails when V_W has a downward jump at mu_s^R1 that creates a gap

source("scripts/model_functions.R")

alpha_star_fn <- function(N, beta) {
  q <- floor(N/2) + 1
  beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
}

# Check if E_U is connected for given parameters
check_EU_connected <- function(r, alpha, N, beta, c_val) {
  mus <- seq(0.001, 0.999, by = 0.001)
  VWs <- sapply(mus, function(mu) VW_R1_unanimity(r, alpha, mu, N, beta))
  in_EU <- VWs >= c_val

  if (sum(in_EU) == 0) return(list(connected = TRUE, type = "empty"))
  if (all(in_EU)) return(list(connected = TRUE, type = "full"))

  # Check for gaps: find runs of TRUE
  rle_result <- rle(in_EU)
  n_true_runs <- sum(rle_result$values == TRUE)

  if (n_true_runs <= 1) {
    return(list(connected = TRUE, type = "interval"))
  } else {
    # Find the gap
    gap_start <- NA; gap_end <- NA
    in_gap <- FALSE
    for (i in seq_along(mus)) {
      if (in_EU[i] && !in_gap && i > 1 && !in_EU[i-1]) {
        # We just re-entered E_U after a gap
        gap_end <- mus[i]
      }
      if (!in_EU[i] && i > 1 && in_EU[i-1] && is.na(gap_start)) {
        gap_start <- mus[i]
        in_gap <- TRUE
      }
    }
    return(list(connected = FALSE, type = "disconnected",
                n_components = n_true_runs,
                gap_start = gap_start, gap_end = gap_end))
  }
}

# Systematic scan
cat("=== When does Assumption 1 fail? ===\n\n")

Ns <- c(3, 5, 7, 10, 15, 20, 30)
rs <- c(1.1, 1.2, 1.3, 1.5, 2, 3)
betas <- c(0.7, 0.8, 0.9, 0.95, 0.99)

total <- 0
failures <- 0
failure_cases <- data.frame()

for (N in Ns) {
  for (r in rs) {
    for (beta in betas) {
      a_star <- alpha_star_fn(N, beta)
      alphas <- seq(0.01, min(a_star, 1/r - 0.01), length.out = 5)

      for (alpha in alphas) {
        # Find range of c where entry is partial (not all, not none)
        mus <- seq(0.001, 0.999, by = 0.001)
        VWs <- sapply(mus, function(mu) VW_R1_unanimity(r, alpha, mu, N, beta))
        c_min <- min(VWs[VWs > 0], na.rm = TRUE)
        c_max <- max(VWs, na.rm = TRUE)

        if (c_max <= c_min) next

        cs <- seq(c_min + 0.001, c_max - 0.001, length.out = 10)

        for (c_val in cs) {
          total <- total + 1
          result <- check_EU_connected(r, alpha, N, beta, c_val)

          if (!result$connected) {
            failures <- failures + 1
            failure_cases <- rbind(failure_cases, data.frame(
              N = N, r = r, alpha = round(alpha, 4), beta = beta,
              c = round(c_val, 4),
              n_comp = result$n_components,
              gap_start = round(result$gap_start, 3),
              gap_end = round(result$gap_end, 3)
            ))
          }
        }
      }
    }
  }
}

cat(sprintf("Total parameter combinations: %d\n", total))
cat(sprintf("Assumption 1 failures: %d (%.1f%%)\n\n", failures, 100 * failures / total))

if (nrow(failure_cases) > 0) {
  cat("=== Pattern of failures ===\n\n")

  cat("By r:\n")
  print(table(failure_cases$r))
  cat("\nBy N:\n")
  print(table(failure_cases$N))
  cat("\nBy beta:\n")
  print(table(failure_cases$beta))

  cat("\n\n=== Sample failure cases ===\n")
  # Show diverse examples
  set.seed(42)
  sample_idx <- if (nrow(failure_cases) > 15) sample(nrow(failure_cases), 15) else seq_len(nrow(failure_cases))
  print(failure_cases[sort(sample_idx), ], row.names = FALSE)

  cat("\n=== Gap size statistics ===\n")
  gaps <- failure_cases$gap_end - failure_cases$gap_start
  cat(sprintf("  Min gap: %.4f\n", min(gaps, na.rm = TRUE)))
  cat(sprintf("  Median gap: %.4f\n", median(gaps, na.rm = TRUE)))
  cat(sprintf("  Max gap: %.4f\n", max(gaps, na.rm = TRUE)))
}
