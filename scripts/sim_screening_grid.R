# ==============================================================================
# Grid analysis: screening channel activation across (c, beta, r)
# Corrected model with Omega = V_e(mu)/3 (linear)
# ==============================================================================

mu_s_new <- function(r, beta) beta * (r - 1) / (r * (3 - 2 * beta) - beta)
tau_C_new <- function(r, beta, c) (3 * c - 1) / (2 + beta * r)
assump_P <- function(r, beta) r < (3 - beta) / (2 * beta)

params <- expand.grid(
  c = seq(0.1, 1, by = 0.1),
  beta = seq(0.7, 0.95, by = 0.05),
  r = seq(1.05, 3, by = 0.05)
)

# Filter: c > 1/3, r > 1, Assumption P satisfied
params <- params[params$c > 1/3 & params$r > 1 &
                   mapply(assump_P, params$r, params$beta), ]

params$mu_s <- mapply(mu_s_new, params$r, params$beta)
params$tau_C <- mapply(tau_C_new, params$r, params$beta, params$c)
params$active <- params$tau_C < params$mu_s

# --- Summary table: % of feasible r with screening active ---
agg <- aggregate(active ~ c + beta, data = params,
                 FUN = function(x) round(100 * mean(x)))

tbl <- reshape(agg, idvar = "c", timevar = "beta", direction = "wide")
names(tbl) <- gsub("active[.]", "beta=", names(tbl))

cat("% of feasible r values with screening channel active (tau(C) < mu_s)\n")
cat("Rows = entry cost c, Cols = discount factor beta\n\n")
print(tbl, row.names = FALSE)

# --- Max feasible r under Assumption P ---
cat("\n\nMax feasible r under corrected Assumption P:\n")
for (b in seq(0.7, 0.95, by = 0.05)) {
  cat(sprintf("  beta=%.2f: r < %.3f\n", b, (3 - b) / (2 * b)))
}

# --- Counts ---
cat("\nNumber of feasible combos per c:\n")
cat(sprintf("%-6s %-8s %-8s %-10s\n", "c", "n_total", "n_active", "pct"))
agg2 <- aggregate(active ~ c, data = params,
                  FUN = function(x) c(length(x), sum(x)))
for (i in seq_len(nrow(agg2))) {
  n <- agg2$active[i, 1]
  a <- agg2$active[i, 2]
  cat(sprintf("%-6.1f %-8d %-8d %-10.0f%%\n", agg2$c[i], n, a, 100 * a / n))
}
