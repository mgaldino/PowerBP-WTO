#!/usr/bin/env Rscript

# Publication-oriented region diagrams for the frozen N3/N4 formulas.
# The functions return ggplot objects; the draft generator controls filenames.

ei_require_ggplot2 <- function() {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required for essential-input region plots.", call. = FALSE)
  }
  invisible(TRUE)
}

ei_plot_palette <- c(
  "Screening (S)" = "#2F6BFF",
  "Pooling (P)" = "#E07A2D",
  "Exclusão (E)" = "#2A9D6F",
  "Empate E/P" = "#7E57C2",
  "Acordo low-only (L)" = "#9B5DE5",
  "No pure-vote PBE" = "#ECE7DF"
)

ei_n3_display_class <- function(classes) {
  if (identical(classes, "S")) return("Screening (S)")
  if (identical(classes, "P")) return("Pooling (P)")
  if (identical(classes, "E")) return("Exclusão (E)")
  if (identical(classes, "E+P")) return("Empate E/P")
  stop(paste("Unknown N3 class:", classes), call. = FALSE)
}

essential_input_o_plane_data <- function(nu, m, beta, resolution = 121L) {
  if (m != as.integer(m) || m < 2L) stop("m must be an integer with m >= 2.", call. = FALSE)
  if (resolution < 40L) stop("resolution must be at least 40.", call. = FALSE)
  epsilon <- 1 / (resolution + 2)
  values <- seq(epsilon, 1 - epsilon, length.out = resolution)
  grid <- expand.grid(o_0 = values, o_1 = values, KEEP.OUT.ATTRS = FALSE)
  grid <- grid[grid$o_0 < grid$o_1, , drop = FALSE]
  N <- as.integer(m) + 1L
  n3_classes <- vapply(seq_len(nrow(grid)), function(index) {
    fit <- n3_closed_form(N, grid$o_0[[index]], grid$o_1[[index]], beta, nu)
    ei_n3_display_class(paste(fit$selected_classes, collapse = "+"))
  }, character(1))
  n4_classes <- vapply(seq_len(nrow(grid)), function(index) {
    fit <- n4_closed_form(N, grid$o_0[[index]], grid$o_1[[index]], beta, nu)
    if (fit$existence_status == "none") {
      "No pure-vote PBE"
    } else if (fit$class == "L") {
      "Acordo low-only (L)"
    } else {
      "Pooling (P)"
    }
  }, character(1))
  rbind(
    data.frame(grid, panel = "N3 - maioria em R1", region = n3_classes, stringsAsFactors = FALSE),
    data.frame(grid, panel = "N4 - unanimidade em R1", region = n4_classes, stringsAsFactors = FALSE)
  )
}

essential_input_o_plane_hatching <- function(data, resolution) {
  none <- data[
    data$panel == "N4 - unanimidade em R1" & data$region == "No pure-vote PBE",
    , drop = FALSE
  ]
  if (nrow(none) == 0L) return(none)
  step <- 1 / (resolution + 1)
  keep <- seq_len(nrow(none)) %% 7L == 0L
  none <- none[keep, , drop = FALSE]
  none$x <- none$o_0 - 0.42 * step
  none$xend <- none$o_0 + 0.42 * step
  none$y <- none$o_1 - 0.42 * step
  none$yend <- none$o_1 + 0.42 * step
  none
}

plot_essential_input_o_plane <- function(
    nu, m, beta, resolution = 121L,
    figure_number = "Figura C.1") {
  ei_require_ggplot2()
  data <- essential_input_o_plane_data(nu, m, beta, resolution)
  hatch <- essential_input_o_plane_hatching(data, resolution)
  none_region <- data[
    data$panel == "N4 - unanimidade em R1" & data$region == "No pure-vote PBE",
    , drop = FALSE
  ]
  substitute_price <- 1 / m
  plot <- ggplot2::ggplot(data, ggplot2::aes(x = o_0, y = o_1, fill = region)) +
    ggplot2::geom_raster() +
    ggplot2::geom_abline(intercept = 0, slope = 1, colour = "white", linewidth = 0.6) +
    ggplot2::geom_hline(
      yintercept = substitute_price,
      colour = "#1D2630", linewidth = 0.8, linetype = "longdash"
    ) +
    ggplot2::facet_wrap(~panel, ncol = 2) +
    ggplot2::coord_equal(xlim = c(0, 1), ylim = c(0, 1), expand = FALSE) +
    ggplot2::scale_fill_manual(values = ei_plot_palette, drop = FALSE) +
    ggplot2::labs(
      title = paste0(figure_number, ". Partição institucional no plano das opções externas"),
      subtitle = sprintf("Prior nu = %.2f; m = %d Estados fracos; beta = %.2f", nu, m, beta),
      x = expression(paste("Opção externa do tipo baixo  ", o[0])),
      y = expression(paste("Opção externa do tipo alto  ", o[1])),
      fill = "Região",
      caption = paste0(
        "A linha tracejada marca o limiar de hegemonia o_1 = 1/m. ",
        "Na faceta de unanimidade, a área hachurada identifica a célula sem PBE em votos puros.\n",
        "Domínio: 0 < o_0 < o_1 < 1. Fonte: interfaces e derivações ",
        "congeladas de N1-N4; figura de rascunho, não destinada ao manuscrito."
      )
    ) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(
      legend.position = "bottom",
      legend.box = "vertical",
      panel.spacing.x = grid::unit(2.50, "lines"),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(colour = "#FFFFFF", linewidth = 0.25),
      strip.text = ggplot2::element_text(face = "bold"),
      plot.title = ggplot2::element_text(face = "bold", size = 14),
      plot.subtitle = ggplot2::element_text(colour = "#46515C"),
      plot.caption = ggplot2::element_text(hjust = 0, colour = "#46515C", size = 8),
      plot.margin = ggplot2::margin(12, 14, 12, 12)
    )
  if (nrow(hatch) > 0L) {
    plot <- plot + ggplot2::geom_segment(
      data = hatch,
      ggplot2::aes(x = x, xend = xend, y = y, yend = yend),
      inherit.aes = FALSE,
      colour = "#85807A", linewidth = 0.25, alpha = 0.85
    )
  }
  if (nrow(none_region) > 0L) {
    plot <- plot + ggplot2::geom_label(
      data = data.frame(
        o_0 = mean(none_region$o_0), o_1 = mean(none_region$o_1),
        panel = "N4 - unanimidade em R1"
      ),
      ggplot2::aes(x = o_0, y = o_1, label = "No pure-vote PBE"),
      inherit.aes = FALSE,
      size = 3.2, linewidth = 0.2, fill = grDevices::adjustcolor("white", alpha.f = 0.82)
    )
  }
  attr(plot, "region_data") <- data
  plot
}

essential_input_nu_partition_data <- function(
    o_0, o_1, m, beta, resolution = 1001L) {
  N <- as.integer(m) + 1L
  nu_values <- seq(0, 1, length.out = resolution)
  n3_classes <- vapply(nu_values, function(nu) {
    fit <- n3_closed_form(N, o_0, o_1, beta, nu)
    ei_n3_display_class(paste(fit$selected_classes, collapse = "+"))
  }, character(1))
  n4_classes <- vapply(nu_values, function(nu) {
    fit <- n4_closed_form(N, o_0, o_1, beta, nu)
    if (fit$existence_status == "none") {
      "No pure-vote PBE"
    } else if (fit$class == "L") {
      "Acordo low-only (L)"
    } else {
      "Pooling (P)"
    }
  }, character(1))
  rbind(
    data.frame(nu = nu_values, panel = "N3 - maioria em R1", region = n3_classes),
    data.frame(nu = nu_values, panel = "N4 - unanimidade em R1", region = n4_classes)
  )
}

plot_essential_input_nu_partition <- function(
    o_0, o_1, m, beta, resolution = 1001L,
    figure_number = "Figura C.2") {
  ei_require_ggplot2()
  N <- as.integer(m) + 1L
  z <- essential_input_constants(N, o_0, o_1, beta, 0.5)
  data <- essential_input_nu_partition_data(o_0, o_1, m, beta, resolution)
  data$panel_y <- ifelse(data$panel == "N3 - maioria em R1", 2, 1)
  none <- data[data$region == "No pure-vote PBE", , drop = FALSE]
  if (nrow(none) > 0L) none <- none[seq_len(nrow(none)) %% 19L == 0L, , drop = FALSE]

  plot <- ggplot2::ggplot(data, ggplot2::aes(x = nu, y = panel_y, fill = region)) +
    ggplot2::geom_tile(width = 1 / (resolution - 1), height = 0.72) +
    ggplot2::geom_vline(
      xintercept = z$nu_star,
      colour = "#1D2630", linewidth = 0.8, linetype = "longdash"
    ) +
    ggplot2::scale_y_continuous(
      breaks = c(1, 2), labels = c("N4 - unanimidade", "N3 - maioria"),
      limits = c(0.55, 2.45), expand = c(0, 0)
    ) +
    ggplot2::scale_x_continuous(breaks = seq(0, 1, by = 0.2), expand = c(0, 0)) +
    ggplot2::coord_cartesian(xlim = c(0, 1), clip = "on") +
    ggplot2::scale_fill_manual(values = ei_plot_palette, drop = FALSE) +
    ggplot2::labs(
      title = paste0(figure_number, ". Partição em nu sob maioria e unanimidade"),
      subtitle = sprintf("o_0 = %.3f; o_1 = %.3f; m = %d; beta = %.2f", o_0, o_1, m, beta),
      x = expression(paste("Prior do tipo alto  ", nu)), y = NULL, fill = "Região",
      caption = paste0(
        "A linha tracejada marca nu* = (o_1-o_0)/(1-o_0). A faixa hachurada é a célula sem PBE em votos puros.\n",
        "Os limites de maioria nu_SE/nu_SP são ",
        "aplicados apenas em seus domínios. Fonte: interfaces e derivações ",
        "congeladas de N1-N4; figura de rascunho."
      )
    ) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(
      legend.position = "bottom",
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_text(face = "bold"),
      plot.title = ggplot2::element_text(face = "bold", size = 14),
      plot.caption = ggplot2::element_text(hjust = 0, colour = "#46515C", size = 8),
      plot.margin = ggplot2::margin(12, 14, 12, 12)
    )
  if (nrow(none) > 0L) {
    plot <- plot + ggplot2::geom_segment(
      data = none,
      ggplot2::aes(
        x = nu - 0.008, xend = nu + 0.008,
        y = panel_y - 0.27, yend = panel_y + 0.27
      ),
      inherit.aes = FALSE,
      colour = "#85807A", linewidth = 0.3
    )
    plot <- plot + ggplot2::geom_label(
      data = data.frame(nu = mean(none$nu), panel_y = 1),
      ggplot2::aes(x = nu, y = panel_y, label = "No pure-vote PBE"),
      inherit.aes = FALSE,
      size = 3.1, linewidth = 0.2, fill = grDevices::adjustcolor("white", alpha.f = 0.82)
    )
  }
  attr(plot, "region_data") <- data
  plot
}

plot_essential_input_margin_table <- function(
    N, o_0, o_1, beta, nu, table_number = "Tabela C.1") {
  ei_require_ggplot2()
  table <- essential_input_margin_table(N, o_0, o_1, beta, nu)
  table$row <- rev(seq_len(nrow(table)))
  table$lhs_text <- sprintf("%.4f", table$lhs)
  table$rhs_text <- sprintf("%.4f", table$rhs)
  table$margin_text <- sprintf("%+.4f", table$margin)
  plot <- ggplot2::ggplot(table, ggplot2::aes(y = row)) +
    ggplot2::geom_tile(
      ggplot2::aes(x = 3.5, width = 7, height = 0.86, fill = row %% 2L == 0L),
      colour = "white", linewidth = 0.35, show.legend = FALSE
    ) +
    ggplot2::scale_fill_manual(values = c("TRUE" = "#F1F4F7", "FALSE" = "#FFFFFF")) +
    ggplot2::geom_text(ggplot2::aes(x = 0.08, label = condition), hjust = 0, size = 3.2) +
    ggplot2::geom_text(ggplot2::aes(x = 3.75, label = lhs_text), family = "mono", size = 3.1) +
    ggplot2::geom_text(ggplot2::aes(x = 4.65, label = rhs_text), family = "mono", size = 3.1) +
    ggplot2::geom_text(ggplot2::aes(x = 5.55, label = margin_text), family = "mono", size = 3.1) +
    ggplot2::geom_text(ggplot2::aes(x = 6.25, label = status), hjust = 0, size = 3.0) +
    ggplot2::annotate("text", x = 0.08, y = 6.0, label = "Condição", hjust = 0, fontface = "bold", size = 3.4) +
    ggplot2::annotate("text", x = 3.75, y = 6.0, label = "LHS", fontface = "bold", size = 3.4) +
    ggplot2::annotate("text", x = 4.65, y = 6.0, label = "Fronteira", fontface = "bold", size = 3.4) +
    ggplot2::annotate("text", x = 5.55, y = 6.0, label = "Margem", fontface = "bold", size = 3.4) +
    ggplot2::annotate("text", x = 6.25, y = 6.0, label = "Status", hjust = 0, fontface = "bold", size = 3.4) +
    ggplot2::coord_cartesian(xlim = c(0, 7), ylim = c(0.35, 6.35), clip = "off") +
    ggplot2::labs(
      title = paste0(table_number, ". Margens das fronteiras essenciais"),
      subtitle = sprintf("N=%d; o_0=%.3f; o_1=%.3f; beta=%.2f; nu=%.2f", N, o_0, o_1, beta, nu),
      caption = paste0(
        "Margem = LHS - fronteira. Sinais devem ser interpretados conforme a ",
        "condição indicada, não como uma única direção substantiva. Fonte: ",
        "fórmulas congeladas de N1-N4; tabela de rascunho."
      )
    ) +
    ggplot2::theme_void(base_size = 11) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", size = 14),
      plot.subtitle = ggplot2::element_text(colour = "#46515C"),
      plot.caption = ggplot2::element_text(hjust = 0, colour = "#46515C", size = 8),
      plot.margin = ggplot2::margin(12, 14, 12, 12)
    )
  attr(plot, "margin_data") <- table
  plot
}
