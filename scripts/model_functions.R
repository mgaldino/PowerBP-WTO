# Model functions for formal_model_v2.Rmd
# Bargaining payoffs under unanimity and majority, plus concavification

VW_R1_unanimity <- function(r, alpha, mu, N, beta) {
  x <- (N - 1) * alpha * r
  mu_s_R2 <- alpha * (r - 1) / (r - alpha)
  Ve <- 1 + mu * (r - 1)
  if (mu < mu_s_R2) {
    VW_R2 <- (1 - mu) * (1 - alpha) / N
  } else {
    VW_R2 <- (Ve - alpha * r) / N
  }
  omega <- (N - 2) * beta * VW_R2
  F1_con <- Ve - beta * (r + x) / N - omega
  F1_agg <- (1 - mu) * (1 - beta * (1 + x) / N - omega) + mu * beta * r * (1 - alpha) / N
  F_proposer <- max(F1_agg, F1_con)
  if (F1_agg > F1_con) {
    # Aggressive: theta=1 rejects, R2 with mu=1
    VW_R2_1 <- r * (1 - alpha) / N
    nonprop <- beta * VW_R2 / N + (N - 2) / N * ((1 - mu) * beta * VW_R2 + mu * beta * VW_R2_1)
  } else {
    # Conservative: all deals pass
    nonprop <- (N - 1) / N * beta * VW_R2
  }
  VW_R1 <- F_proposer / N + nonprop
  return(VW_R1)
}

VW_R1_majority <- function(r, alpha, mu, N, beta) {
  Ve <- 1 + mu * (r - 1)
  # Budget identity: total surplus = Ve, so VW = (Ve - EVH) / (N-1)
  EVH <- VH_R1_majority(r, alpha, mu, N, beta)
  VW_R1_M <- (Ve - EVH) / (N - 1)
  return(VW_R1_M)
}

VH_R1_unanimity <- function(r, alpha, mu, N, beta) {
  x <- (N - 1) * alpha * r
  mu_s_R2 <- alpha * (r - 1) / (r - alpha)
  Ve <- 1 + mu * (r - 1)
  if (mu < mu_s_R2) {
    VW_R2 <- (1 - mu) * (1 - alpha) / N
  } else {
    VW_R2 <- (Ve - alpha * r) / N
  }
  omega <- (N - 2) * beta * VW_R2
  F1_con <- Ve - beta * (r + x) / N - omega
  F1_agg <- (1 - mu) * (1 - beta * (1 + x) / N - omega) + mu * beta * r * (1 - alpha) / N
  H_prop_0 <- (1 - (N - 1) * beta * VW_R2) / N
  H_prop_1 <- (r - (N - 1) * beta * VW_R2) / N
  if (F1_agg > F1_con) {
    VH_0 <- H_prop_0 + (N - 1) * beta * (1 + x) / (N^2)
    VH_1 <- H_prop_1 + (N - 1) * beta * (r + x) / (N^2)
  } else {
    VH_0 <- H_prop_0 + (N - 1) * beta * (r + x) / (N^2)
    VH_1 <- H_prop_1 + (N - 1) * beta * (r + x) / (N^2)
  }
  EVH <- mu * VH_1 + (1 - mu) * VH_0
  return(EVH)
}

VH_R1_majority <- function(r, alpha, mu, N, beta) {
  q <- floor(N/2) + 1
  Ve <- 1 + mu * (r - 1)
  VW_R2_M <- (1 - alpha) * Ve / N
  # H proposes (prob 1/N): buys q-1 weak states at beta*VW_R2_M each
  H_prop <- (Ve - (q - 1) * beta * VW_R2_M) / N
  # W proposes (prob (N-1)/N): W excludes H; H captures alpha*V(theta) bilaterally
  W_prop_H <- (N - 1) / N * alpha * Ve
  EVH <- H_prop + W_prop_H
  return(EVH)
}

# Upper concave envelope via left-to-right sweep
concavify <- function(mus, vals) {
  n <- length(mus)
  cav_vals <- numeric(n)
  cav_vals[1] <- vals[1]
  i <- 1
  while (i < n) {
    best_j <- i + 1
    best_slope <- (vals[i+1] - cav_vals[i]) / (mus[i+1] - mus[i])
    for (j in (i+2):n) {
      if (j > n) break
      slope <- (vals[j] - cav_vals[i]) / (mus[j] - mus[i])
      if (slope > best_slope) {
        best_slope <- slope
        best_j <- j
      }
    }
    for (k in (i+1):best_j) {
      t <- (mus[k] - mus[i]) / (mus[best_j] - mus[i])
      cav_vals[k] <- cav_vals[i] + t * (vals[best_j] - cav_vals[i])
    }
    i <- best_j
  }
  cav_vals <- pmax(cav_vals, vals)
  return(cav_vals)
}
