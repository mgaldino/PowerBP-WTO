# Diagnose the "2 crossings" result — likely numerical artifact near p=0
source("scripts/model_functions.R")

alpha_star_fn <- function(N, beta) {
  q <- floor(N/2) + 1
  beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
}

# Pick a specific case
N <- 3; r <- 1.1; alpha <- 0.01; beta <- 0.5; c_val <- 0.3281

cat(sprintf("Parameters: N=%d, r=%.2f, alpha=%.4f, beta=%.2f, c=%.4f\n\n", N, r, alpha, beta, c_val))

grid_size <- 2000
mus <- seq(0, 1, length.out = grid_size)

# Compute v(mu, U) and v(mu, M)
v_U <- numeric(grid_size)
v_M <- numeric(grid_size)

# Entry sets
VW_U <- sapply(mus[-c(1, grid_size)], function(mu) VW_R1_unanimity(r, alpha, mu, N, beta))
VW_M <- sapply(mus[-c(1, grid_size)], function(mu) VW_R1_majority(r, alpha, mu, N, beta))

in_EU <- c(FALSE, VW_U >= c_val, FALSE)
in_EM <- c(FALSE, VW_M >= c_val, FALSE)

cat("E_U range: ")
eu_mus <- mus[in_EU]
if (length(eu_mus) > 0) cat(sprintf("[%.4f, %.4f]", min(eu_mus), max(eu_mus)))
cat("\n")

# Check if E_U is disconnected
diffs <- diff(c(FALSE, in_EU, FALSE))
starts <- which(diffs == 1) - 1
ends <- which(diffs == -1) - 2
cat(sprintf("E_U components: %d\n", length(starts)))
for (i in seq_along(starts)) {
  cat(sprintf("  Component %d: [%.4f, %.4f]\n", i, mus[starts[i]], mus[ends[i]]))
}

tau_M <- if (any(in_EM)) mus[min(which(in_EM))] else Inf
cat(sprintf("tau(M) = %.4f\n\n", tau_M))

# Compute v vectors
for (i in seq_along(mus)) {
  mu <- mus[i]
  v_U[i] <- if (in_EU[i]) VH_R1_unanimity(r, alpha, mu, N, beta) else 0
  v_M[i] <- if (in_EM[i]) VH_R1_majority(r, alpha, mu, N, beta) else 0
}

# Concavify
cav_U <- concavify(mus, v_U)
cav_M <- concavify(mus, v_M)

D <- cav_U - cav_M

# Show D near p=0 and at key points
cat("D(p) near p=0:\n")
idx <- 1:20
for (i in idx) {
  cat(sprintf("  p=%.4f: D=%.8f  cav_U=%.8f  cav_M=%.8f\n", mus[i], D[i], cav_U[i], cav_M[i]))
}

cat("\nD(p) around tau(M):\n")
tau_idx <- which.min(abs(mus - tau_M))
for (i in max(1, tau_idx-3):min(grid_size, tau_idx+3)) {
  cat(sprintf("  p=%.4f: D=%.8f  cav_U=%.8f  cav_M=%.8f\n", mus[i], D[i], cav_U[i], cav_M[i]))
}

# Count sign changes, skipping p near 0
cat("\nSign changes analysis:\n")
for (start_p in c(0, 0.001, 0.005, 0.01)) {
  valid <- mus > start_p
  D_valid <- D[valid]
  tol <- 1e-10
  signs <- ifelse(D_valid > tol, 1, ifelse(D_valid < -tol, -1, 0))
  nonzero <- signs[signs != 0]
  if (length(nonzero) > 1) {
    sc <- sum(diff(nonzero) != 0)
  } else {
    sc <- 0
  }
  cat(sprintf("  Starting from p=%.4f: %d sign changes\n", start_p, sc))
}

# Find where D changes sign
cat("\nSign change locations:\n")
tol <- 1e-10
for (i in 2:grid_size) {
  if ((D[i-1] < -tol & D[i] > tol) || (D[i-1] > tol & D[i] < -tol)) {
    cat(sprintf("  p=%.4f: D goes from %.8f to %.8f\n", mus[i], D[i-1], D[i]))
  }
}
