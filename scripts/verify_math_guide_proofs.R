tol <- 1e-12
pass_count <- 0L

check_equal <- function(actual, expected, label, tolerance = tol) {
  if (length(actual) != length(expected) ||
      any(!is.finite(actual)) ||
      any(abs(actual - expected) > tolerance)) {
    stop(sprintf(
      "FAIL [%s]: actual=%s expected=%s",
      label,
      paste(actual, collapse = ","),
      paste(expected, collapse = ",")
    ))
  }
  pass_count <<- pass_count + 1L
}

check_true <- function(condition, label) {
  if (!isTRUE(condition)) stop(sprintf("FAIL [%s]", label))
  pass_count <<- pass_count + 1L
}

# Worked example used throughout the guide.
m <- 4
q <- 3
beta <- 0.9
o0 <- 0.10
o1 <- 0.35

w <- beta / m
t0 <- beta * o0
t1 <- beta * o1
nu_star <- (o1 - o0) / (1 - o0)
E <- 1 - (q - 1) * w
L <- 1 - (q - 2) * w - t0
P <- 1 - (q - 2) * w - t1
D <- w
nu_SE <- beta * (1 / m - o0) /
  (beta * (1 / m - o0) + 1 - beta * q / m)

check_equal(w, 0.225, "weak continuation price")
check_equal(t0, 0.09, "low threshold")
check_equal(t1, 0.315, "high threshold")
check_equal(nu_star, 0.25 / 0.90, "terminal cutoff")
check_equal(E, 0.55, "exclusion payoff")
check_equal(L, 0.685, "low-only pass payoff")
check_equal(P, 0.46, "pooling payoff")
check_equal(D, 0.225, "delay payoff")
check_equal(nu_SE, 0.135 / 0.46, "screening-exclusion cutoff")
check_equal((1 - nu_SE) * L + nu_SE * w, E,
            "screening and exclusion tie at nu_SE")

# Public benchmark: buying H replaces exactly one weak vote.
for (m_i in 3:20) {
  q_i <- floor((m_i + 1) / 2) + 1
  for (beta_i in c(0.2, 0.5, 0.9, 0.999)) {
    w_i <- beta_i / m_i
    for (o_i in c(0.01, 0.2, 1 / m_i, 0.8)) {
      inclusion <- (q_i - 2) * w_i + beta_i * o_i
      exclusion <- (q_i - 1) * w_i
      check_true(
        (inclusion <= exclusion + tol) == (o_i <= 1 / m_i + tol),
        sprintf("public cutoff m=%s beta=%s o=%s", m_i, beta_i, o_i)
      )
    }
    check_true(
      1 - beta_i * q_i / m_i > 0,
      sprintf("immediate exclusion dominates delay m=%s beta=%s", m_i, beta_i)
    )
  }
}

# Informational-rent example.
VM_private <- c(o0, o1)
VU_private <- c(beta * o1, beta * o1)
VM_public <- c(beta * o0, o1)
VU_public <- c(beta * o0, beta * o1)
RI_M <- VM_private - VM_public
RI_U <- VU_private - VU_public
Delta_RI <- RI_U - RI_M

check_equal(RI_M, c(0.01, 0), "majority informational rent")
check_equal(RI_U, c(0.225, 0), "unanimity informational rent")
check_equal(Delta_RI, c(0.215, 0), "difference of differences")

# One shared lambda must bind both coordinates of a segment.
vE <- c(0.10, 0.35)
vP <- c(0.315, 0.315)
cvec <- c(0.09, 0.315)
for (lambda in seq(0, 1, by = 0.01)) {
  lhs <- lambda * vE + (1 - lambda) * vP - cvec
  rhs <- lambda * (vE - cvec) + (1 - lambda) * (vP - cvec)
  check_equal(lhs, rhs, sprintf("affine segment lambda=%.2f", lambda))
}

cat(sprintf(
  "PASS: %d mechanical checks for math_guide_proofs; no mathematical-review claim.\n",
  pass_count
))
