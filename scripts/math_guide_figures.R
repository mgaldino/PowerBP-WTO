plot_terminal_cutoff <- function(o0 = 0.10, o1 = 0.35) {
  stopifnot(0 < o0, o0 < o1, o1 < 1)

  nu <- seq(0, 1, length.out = 501)
  low_offer <- (1 - nu) * (1 - o0)
  pooling <- rep(1 - o1, length(nu))
  nu_star <- (o1 - o0) / (1 - o0)

  old_par <- par(no.readonly = TRUE)
  on.exit(par(old_par), add = TRUE)
  par(mar = c(4.4, 4.5, 1.0, 1.0), las = 1)

  plot(
    nu, low_offer,
    type = "l", lwd = 2.4, col = "#1f4e79",
    xlab = expression(nu),
    ylab = "Payoff esperado do proponente",
    ylim = range(c(low_offer, pooling))
  )
  lines(nu, pooling, lwd = 2.4, col = "#b24a3b")
  abline(v = nu_star, lty = 3, lwd = 1.4, col = "#555555")
  points(nu_star, 1 - o1, pch = 19, cex = 0.9)
  legend(
    "topright",
    legend = c("Oferta baixa", "Pooling", expression(nu^"*")),
    col = c("#1f4e79", "#b24a3b", "#555555"),
    lty = c(1, 1, 3), lwd = c(2.4, 2.4, 1.4),
    bty = "n", cex = 0.88
  )
}

plot_linked_segment <- function(a0 = 0.01, a1 = 0.025, d = 0.135) {
  stopifnot(a0 >= 0, a1 >= 0, d >= 0)

  endpoint_exclusion <- c(a0, a1)
  endpoint_pooling <- c(d, 0)
  lambda <- seq(0, 1, length.out = 101)
  segment <- outer(lambda, endpoint_exclusion) +
    outer(1 - lambda, endpoint_pooling)

  x_limits <- range(c(0, segment[, 1]))
  y_limits <- range(c(0, segment[, 2]))

  old_par <- par(no.readonly = TRUE)
  on.exit(par(old_par), add = TRUE)
  par(mar = c(4.5, 4.8, 1.0, 1.0), las = 1)

  plot(
    NA,
    xlim = x_limits + c(-0.03, 0.03) * diff(x_limits),
    ylim = y_limits + c(-0.08, 0.08) * diff(y_limits),
    xlab = "Componente do tipo baixo",
    ylab = "Componente do tipo alto"
  )
  rect(
    min(segment[, 1]), min(segment[, 2]),
    max(segment[, 1]), max(segment[, 2]),
    border = "#999999", lty = 3
  )
  lines(segment[, 1], segment[, 2], lwd = 3, col = "#1f4e79")
  points(
    c(endpoint_exclusion[1], endpoint_pooling[1]),
    c(endpoint_exclusion[2], endpoint_pooling[2]),
    pch = 19, col = c("#b24a3b", "#3b7f4a")
  )
  text(
    endpoint_exclusion[1], endpoint_exclusion[2],
    labels = "Exclus\u00e3o", pos = 4, cex = 0.86
  )
  text(
    endpoint_pooling[1], endpoint_pooling[2],
    labels = "Pooling", pos = 3, cex = 0.86
  )
  legend(
    "topright",
    legend = c("Segmento ating\u00edvel", "Ret\u00e2ngulo dos envelopes"),
    col = c("#1f4e79", "#999999"),
    lty = c(1, 3), lwd = c(3, 1), bty = "n", cex = 0.84
  )
}
