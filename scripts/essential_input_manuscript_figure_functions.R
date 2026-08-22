#!/usr/bin/env Rscript

# Reader-facing manuscript figures for the frozen private-information model.
#
# This file consumes the closed-form N1--N4 module and the frozen N6
# comparison interface. It does not read N7 or any public-benchmark artifact.

ei_n6_interface_source <- function() {
  c(
    "model_redesign/essential_input_n6_private_comparison_candidate.json" =
      "a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92"
  )
}

verify_essential_input_n6_figure_source <- function(repository_root) {
  expected <- ei_n6_interface_source()
  observed <- vapply(
    names(expected),
    function(relative_path) {
      ei_sha256_file(file.path(repository_root, relative_path))
    },
    character(1)
  )
  if (!identical(unname(observed), unname(expected))) {
    stop("Frozen N6 interface hash mismatch.", call. = FALSE)
  }
  invisible(data.frame(
    source_path = names(expected),
    sha256 = unname(observed),
    stringsAsFactors = FALSE
  ))
}

ei_require_manuscript_figure_packages <- function() {
  required <- c("ggplot2", "gtable")
  missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing) > 0L) {
    stop(paste("Missing R package(s):", paste(missing, collapse = ", ")), call. = FALSE)
  }
  invisible(TRUE)
}

ei_response_palette <- c(
  "H prefers unanimity" = "#0072B2",
  "H indifferent" = "#E69F00",
  "H prefers majority" = "#D55E00",
  "No comparison: no pure-vote PBE (unanimity)" = "#D9D9D9"
)

ei_type_palette <- c(
  "Low type" = "#0072B2",
  "High type" = "#D55E00"
)

ei_allocation_palette <- c(
  "Proposer residual" = "#56B4E9",
  "Substitute votes" = "#009E73",
  "Weak-state floors" = "#E69F00",
  "Concession to H" = "#CC79A7"
)

ei_manuscript_theme <- function(base_size = 10.5) {
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(colour = "#E4E8EB", linewidth = 0.30),
      strip.text = ggplot2::element_text(face = "bold", colour = "#1D2630"),
      axis.title = ggplot2::element_text(colour = "#1D2630"),
      axis.text = ggplot2::element_text(colour = "#36434D"),
      legend.position = "bottom",
      legend.title = ggplot2::element_text(face = "bold"),
      plot.title = ggplot2::element_text(face = "bold", size = base_size + 2.5),
      plot.subtitle = ggplot2::element_text(colour = "#46515C"),
      plot.caption = ggplot2::element_text(
        hjust = 0, colour = "#46515C", size = base_size - 2.4, lineheight = 0.98
      ),
      plot.margin = ggplot2::margin(10, 12, 10, 10)
    )
}

ei_wrap_text <- function(text, width = 145L) {
  paste(strwrap(text, width = width), collapse = "\n")
}

ei_compose_vertical <- function(plots, heights, title, caption) {
  if (length(plots) != length(heights)) {
    stop("plots and heights must have equal length.", call. = FALSE)
  }
  plot_grobs <- lapply(plots, ggplot2::ggplotGrob)
  title_grob <- grid::textGrob(
    title, x = grid::unit(0, "npc"), hjust = 0,
    gp = grid::gpar(fontsize = 14, fontface = "bold", col = "#1D2630")
  )
  caption_grob <- grid::textGrob(
    ei_wrap_text(caption), x = grid::unit(0, "npc"), hjust = 0, vjust = 1,
    gp = grid::gpar(fontsize = 8.2, col = "#46515C", lineheight = 0.98)
  )
  layout <- gtable::gtable(
    widths = grid::unit(1, "null"),
    heights = do.call(
      grid::unit.c,
      c(
        list(grid::unit(1.6, "lines")),
        lapply(heights, grid::unit, units = "null"),
        list(grid::unit(8.4, "lines"))
      )
    )
  )
  layout <- gtable::gtable_add_grob(layout, title_grob, t = 1, l = 1)
  for (index in seq_along(plot_grobs)) {
    layout <- gtable::gtable_add_grob(layout, plot_grobs[[index]], t = index + 1L, l = 1)
  }
  gtable::gtable_add_grob(layout, caption_grob, t = length(plot_grobs) + 2L, l = 1)
}

ei_curve_band_polygon <- function(
    y_values, left_function, right_function, region, hegemon_type, polygon_id,
    y_multiplier = 1) {
  if (length(y_values) < 2L) return(NULL)
  left <- left_function(y_values)
  right <- right_function(y_values)
  keep <- is.finite(left) & is.finite(right) & right >= left
  y_values <- y_values[keep]
  left <- left[keep]
  right <- right[keep]
  if (length(y_values) < 2L) return(NULL)
  data.frame(
    nu = c(left, rev(right)),
    vertical_value = c(y_values, rev(y_values)) * y_multiplier,
    region = region,
    hegemon_type = hegemon_type,
    polygon_id = polygon_id,
    record_type = "region_polygon",
    stringsAsFactors = FALSE
  )
}

ei_safe_rbind <- function(objects) {
  objects <- Filter(function(object) !is.null(object) && nrow(object) > 0L, objects)
  if (length(objects) == 0L) return(data.frame())
  do.call(rbind, objects)
}

ei_f1_cutoff_functions <- function(kappa, m, beta) {
  q <- floor((m + 1L) / 2) + 1L
  list(
    q = q,
    nu_star = function(o_1) (1 - kappa) * o_1 / (1 - kappa * o_1),
    nu_SP = function(o_1) {
      beta * (1 - kappa) * o_1 /
        (1 - beta * kappa * o_1 - beta * (q - 1) / m)
    },
    nu_SE = function(o_1) {
      beta * (1 / m - kappa * o_1) /
        (beta * (1 / m - kappa * o_1) + 1 - beta * q / m)
    }
  )
}

ei_f1_crossing_o1 <- function(kappa, m, beta, functions) {
  lower <- 1 / m + 1e-7
  upper <- min(1, 1 / (m * kappa)) - 1e-7
  difference <- function(o_1) functions$nu_SE(o_1) - functions$nu_star(o_1)
  if (upper <= lower) return(lower)
  values <- c(difference(lower), difference(upper))
  if (!all(is.finite(values)) || values[[1L]] * values[[2L]] > 0) return(lower)
  stats::uniroot(difference, interval = c(lower, upper), tol = 1e-12)$root
}

essential_input_f1_data <- function(
    kappa, m = 4L, beta = 0.90, vertical_scale = c("raw", "normalized"),
    resolution = 501L, example = NULL) {
  vertical_scale <- match.arg(vertical_scale)
  if (!(kappa > 0 && kappa < 1)) stop("kappa must belong to (0,1).", call. = FALSE)
  if (!(kappa < beta)) {
    stop("This reader-facing partition requires the displayed slices to satisfy kappa < beta.", call. = FALSE)
  }
  functions <- ei_f1_cutoff_functions(kappa, m, beta)
  multiplier <- if (vertical_scale == "normalized") m else 1
  epsilon <- 1e-5
  substitute_cost <- 1 / m
  crossing_upper <- min(1, 1 / (m * kappa))
  crossing_root <- ei_f1_crossing_o1(kappa, m, beta, functions)

  low_o1 <- seq(epsilon, substitute_cost, length.out = resolution)
  high_o1 <- seq(substitute_cost, 1 - epsilon, length.out = resolution)
  crossing_low <- seq(substitute_cost, crossing_root, length.out = resolution)
  crossing_high <- seq(crossing_root, 1 - epsilon, length.out = resolution)
  all_o1 <- seq(epsilon, 1 - epsilon, length.out = resolution)

  none_region <- lapply(c("Low type", "High type"), function(type) {
    ei_curve_band_polygon(
      all_o1, function(y) rep(0, length(y)), functions$nu_star,
      "No comparison: no pure-vote PBE (unanimity)", type,
      paste0("none_", gsub(" ", "_", tolower(type))), multiplier
    )
  })

  low_type_regions <- list(
    ei_curve_band_polygon(
      low_o1, functions$nu_star, functions$nu_SP,
      "H prefers unanimity", "Low type", "low_u_below", multiplier
    ),
    ei_curve_band_polygon(
      low_o1, functions$nu_SP, function(y) rep(1, length(y)),
      "H indifferent", "Low type", "low_i_below", multiplier
    ),
    ei_curve_band_polygon(
      high_o1, functions$nu_star, function(y) rep(1, length(y)),
      "H prefers unanimity", "Low type", "low_u_above", multiplier
    )
  )

  high_type_regions <- list(
    ei_curve_band_polygon(
      low_o1, functions$nu_star, function(y) rep(1, length(y)),
      "H indifferent", "High type", "high_i_below", multiplier
    ),
    ei_curve_band_polygon(
      crossing_low, functions$nu_star, functions$nu_SE,
      "H indifferent", "High type", "high_i_cross", multiplier
    ),
    ei_curve_band_polygon(
      crossing_low, functions$nu_SE, function(y) rep(1, length(y)),
      "H prefers majority", "High type", "high_m_cross", multiplier
    ),
    ei_curve_band_polygon(
      crossing_high, functions$nu_star, function(y) rep(1, length(y)),
      "H prefers majority", "High type", "high_m_above", multiplier
    )
  )

  regions <- ei_safe_rbind(c(none_region, low_type_regions, high_type_regions))

  frontier_rows <- list()
  add_frontier <- function(name, y_values, x_values) {
    do.call(rbind, lapply(c("Low type", "High type"), function(type) {
      data.frame(
        nu = x_values,
        vertical_value = y_values * multiplier,
        region = name,
        hegemon_type = type,
        polygon_id = NA_character_,
        record_type = "analytic_frontier",
        stringsAsFactors = FALSE
      )
    }))
  }
  frontier_rows[[1L]] <- add_frontier("nu_star", all_o1, functions$nu_star(all_o1))
  frontier_rows[[2L]] <- add_frontier("nu_SP", low_o1, functions$nu_SP(low_o1))
  valid_se_o1 <- seq(substitute_cost, crossing_upper - epsilon, length.out = resolution)
  frontier_rows[[3L]] <- add_frontier("nu_SE", valid_se_o1, functions$nu_SE(valid_se_o1))
  frontier_rows[[4L]] <- add_frontier(
    "substitute_cost", c(substitute_cost, substitute_cost), c(0, 1)
  )
  frontiers <- ei_safe_rbind(frontier_rows)

  endpoint_threshold <- min(1, 1 / (m * kappa))
  endpoint <- ei_safe_rbind(list(
    data.frame(
      nu = 0, vertical_value = c(epsilon, endpoint_threshold) * multiplier,
      region = "H indifferent", hegemon_type = rep(c("Low type", "High type"), each = 2L),
      polygon_id = NA_character_, record_type = "endpoint_segment",
      stringsAsFactors = FALSE
    )[0, , drop = FALSE]
  ))
  endpoint <- do.call(rbind, lapply(c("Low type", "High type"), function(type) {
    pieces <- list(data.frame(
      nu = c(0, 0), vertical_value = c(epsilon, endpoint_threshold) * multiplier,
      region = "H indifferent", hegemon_type = type,
      polygon_id = paste0("endpoint_i_", type), record_type = "endpoint_segment",
      stringsAsFactors = FALSE
    ))
    if (endpoint_threshold < 1) {
      pieces[[2L]] <- data.frame(
        nu = c(0, 0), vertical_value = c(endpoint_threshold, 1 - epsilon) * multiplier,
        region = "H prefers majority", hegemon_type = type,
        polygon_id = paste0("endpoint_m_", type), record_type = "endpoint_segment",
        stringsAsFactors = FALSE
      )
    }
    do.call(rbind, pieces)
  }))

  hatch_rows <- list()
  hatch_index <- 0L
  for (type in c("Low type", "High type")) {
    for (o_1 in seq(0.04, 0.96, by = 0.045)) {
      maximum <- functions$nu_star(o_1)
      if (!is.finite(maximum) || maximum - 0.018 < 0.012) next
      candidates <- seq(0.012, maximum - 0.018, by = 0.043)
      if (length(candidates) == 0L || any(!is.finite(candidates))) next
      for (x_value in candidates) {
        hatch_index <- hatch_index + 1L
        hatch_rows[[hatch_index]] <- data.frame(
          x = x_value, xend = min(x_value + 0.018, maximum - 0.002),
          y = (o_1 - 0.011) * multiplier,
          yend = (o_1 + 0.011) * multiplier,
          hegemon_type = type,
          stringsAsFactors = FALSE
        )
      }
    }
  }
  hatch <- ei_safe_rbind(hatch_rows)

  example_rows <- data.frame()
  if (!is.null(example)) {
    required <- c("nu", "o_0", "o_1")
    if (!all(required %in% names(example))) stop("example is missing required fields.", call. = FALSE)
    if (abs(example$o_0 / example$o_1 - kappa) > 1e-10) {
      stop("The worked example does not belong to the requested kappa slice.", call. = FALSE)
    }
    example_rows <- data.frame(
      nu = rep(example$nu, 2L),
      vertical_value = rep(example$o_1 * multiplier, 2L),
      region = "Worked example",
      hegemon_type = c("Low type", "High type"),
      polygon_id = NA_character_, record_type = "worked_example",
      stringsAsFactors = FALSE
    )
  }

  list(
    regions = regions,
    frontiers = frontiers,
    endpoint = endpoint,
    hatch = hatch,
    example = example_rows,
    constants = list(
      kappa = kappa, m = m, beta = beta, q = functions$q,
      substitute_cost = substitute_cost, vertical_scale = vertical_scale,
      multiplier = multiplier, crossing_root = crossing_root
    )
  )
}

plot_essential_input_f1 <- function(data_object, figure_label = "Figure F1") {
  constants <- data_object$constants
  functions <- ei_f1_cutoff_functions(constants$kappa, constants$m, constants$beta)
  y_max <- constants$multiplier
  y_label <- if (constants$vertical_scale == "raw") {
    "Strong type's outside option, o1"
  } else {
    "Relative hegemonic power, m x o1"
  }
  threshold_caption <- if (constants$vertical_scale == "raw") {
    "The dashed horizontal line is the substitute cost o1 = 1/m. "
  } else {
    "The dashed horizontal line is the hegemony threshold m x o1 = 1. "
  }
  plot <- ggplot2::ggplot() +
    ggplot2::geom_polygon(
      data = data_object$regions,
      ggplot2::aes(
        x = nu, y = vertical_value, group = polygon_id, fill = region
      ),
      colour = NA
    ) +
    ggplot2::geom_segment(
      data = data_object$hatch,
      ggplot2::aes(x = x, xend = xend, y = y, yend = yend),
      colour = "#6D6D6D", linewidth = 0.28, inherit.aes = FALSE
    ) +
    ggplot2::geom_line(
      data = data_object$frontiers[data_object$frontiers$region != "substitute_cost", ],
      ggplot2::aes(
        x = nu, y = vertical_value, group = interaction(hegemon_type, region),
        linetype = region
      ),
      colour = "#1D2630", linewidth = 0.58
    ) +
    ggplot2::geom_line(
      data = data_object$frontiers[data_object$frontiers$region == "substitute_cost", ],
      ggplot2::aes(x = nu, y = vertical_value, group = hegemon_type),
      colour = "#1D2630", linewidth = 0.62, linetype = "longdash"
    ) +
    ggplot2::geom_line(
      data = data_object$endpoint,
      ggplot2::aes(
        x = nu, y = vertical_value, group = polygon_id, colour = region
      ),
      linewidth = 2.1, show.legend = FALSE
    ) +
    ggplot2::facet_wrap(
      ~factor(hegemon_type, levels = c("Low type", "High type")), nrow = 1
    ) +
    ggplot2::scale_fill_manual(values = ei_response_palette, drop = FALSE) +
    ggplot2::scale_colour_manual(values = ei_response_palette, drop = FALSE) +
    ggplot2::scale_linetype_manual(
      values = c(nu_star = "solid", nu_SP = "22", nu_SE = "42")
    ) +
    ggplot2::scale_x_continuous(
      limits = c(0, 1), breaks = seq(0, 1, by = 0.2), expand = c(0, 0)
    ) +
    ggplot2::scale_y_continuous(
      limits = c(0, y_max),
      breaks = if (constants$vertical_scale == "raw") seq(0, 1, by = 0.2) else 0:constants$m,
      expand = c(0, 0)
    ) +
    ggplot2::labs(
      title = paste0(figure_label, ". Institutional preference depends on type and substitutability"),
      subtitle = sprintf(
        "Outside-option slice o0 = %.3f x o1; m = %d weak states; beta = %.2f",
        constants$kappa, constants$m, constants$beta
      ),
      x = "Prior probability of the strong type, nu",
      y = y_label,
      fill = "Private-rule comparison",
      linetype = "Analytical boundary",
      caption = ei_wrap_text(paste0(
        "Colored polygons report the type-specific payoff comparison between unanimity and majority. ",
        "The neutral hatched region has no comparison because unanimity has no pure-vote PBE. ",
        "The left-edge segments report the distinct complete-information endpoint at nu = 0. ",
        "Boundaries are nu* = (1-kappa)o1/(1-kappa o1), nu_SP = beta(1-kappa)o1/[1-beta kappa o1-beta(q-1)/m], ",
        "and nu_SE = beta(1/m-kappa o1)/[beta(1/m-kappa o1)+1-beta q/m]. ",
        threshold_caption,
        "Note: Model-generated regions; all boundaries closed-form."
      ), width = 150L)
    ) +
    ei_manuscript_theme(10.3) +
    ggplot2::theme(
      panel.spacing.x = grid::unit(2.0, "lines"),
      legend.box = "vertical",
      plot.caption = ggplot2::element_text(hjust = 0, size = 7.6)
    )

  label_data <- data.frame(
    nu = c(
      0.50,
      0.82,
      0.55,
      0.82,
      0.55,
      0.74
    ),
    vertical_value = c(0.60, 0.08, 0.91, 0.08, 0.91, 0.62) * y_max,
    hegemon_type = c("Low type", "Low type", "Low type", "High type", "High type", "High type"),
    label = c(
      "Unanimity", "Indifferent", "No comparison",
      "Indifferent", "No comparison", "Majority"
    ),
    stringsAsFactors = FALSE
  )
  plot <- plot + ggplot2::geom_label(
    data = label_data,
    ggplot2::aes(x = nu, y = vertical_value, label = label),
    inherit.aes = FALSE, size = 2.75, linewidth = 0.18,
    fill = grDevices::adjustcolor("white", alpha.f = 0.82)
  )

  star_o1 <- 0.72
  sp_o1 <- 0.18
  se_upper <- min(1, 1 / (constants$m * constants$kappa))
  se_o1 <- (constants$substitute_cost + se_upper) / 2
  formula_labels <- data.frame(
    nu = c(
      functions$nu_star(star_o1),
      functions$nu_SP(sp_o1),
      functions$nu_SE(se_o1),
      0.78
    ),
    vertical_value = c(
      star_o1, sp_o1, se_o1, constants$substitute_cost
    ) * constants$multiplier,
    hegemon_type = c("Low type", "Low type", "High type", "High type"),
    label = c(
      "nu* = (1-kappa)o1 /\n(1-kappa o1)",
      "nu_SP = beta(1-kappa)o1 /\n[1-beta kappa o1-beta(q-1)/m]",
      "nu_SE = beta(1/m-kappa o1) /\n[beta(1/m-kappa o1)+1-beta q/m]",
      if (constants$vertical_scale == "raw") {
        "substitute cost: o1 = 1/m"
      } else {
        "hegemony threshold: m x o1 = 1"
      }
    ),
    hjust = c(1, 0, 0, 0),
    vjust = c(-0.08, -0.08, -0.08, -0.12),
    stringsAsFactors = FALSE
  )
  plot <- plot + ggplot2::geom_label(
    data = formula_labels,
    ggplot2::aes(
      x = nu, y = vertical_value, label = label, hjust = hjust, vjust = vjust
    ),
    inherit.aes = FALSE, size = 2.2, linewidth = 0.16,
    fill = grDevices::adjustcolor("white", alpha.f = 0.84),
    label.padding = grid::unit(0.10, "lines")
  )

  if (nrow(data_object$example) > 0L) {
    plot <- plot +
      ggplot2::geom_point(
        data = data_object$example,
        ggplot2::aes(x = nu, y = vertical_value),
        inherit.aes = FALSE, shape = 21, size = 3.2, stroke = 0.9,
        fill = "white", colour = "black"
      ) +
      ggplot2::geom_text(
        data = data_object$example,
        ggplot2::aes(x = nu, y = vertical_value, label = "worked example"),
        inherit.aes = FALSE, nudge_x = 0.035, nudge_y = 0.025 * y_max,
        hjust = 0, size = 2.7
      )
  }
  attr(plot, "figure_data") <- ei_safe_rbind(list(
    data_object$regions, data_object$frontiers, data_object$endpoint, data_object$example
  ))
  plot
}

essential_input_f2_data <- function(
    o_0 = 0.10, o_1 = 0.35, m = 4L, beta = 0.90, nu_example = 0.35,
    public_benchmark = NULL) {
  N <- m + 1L
  constants <- essential_input_constants(N, o_0, o_1, beta, nu_example)
  majority_cutoff <- constants$nu_SE
  if (!is.finite(majority_cutoff)) {
    stop("The requested F2 anatomy expects the crossing case o0 < 1/m < o1.", call. = FALSE)
  }
  screening_nu <- seq(0, majority_cutoff, length.out = 250L)
  exclusion_nu <- seq(majority_cutoff + 1e-6, 1, length.out = 250L)
  pooling_nu <- seq(constants$nu_star + 1e-6, 1, length.out = 300L)
  line_data <- rbind(
    data.frame(
      rule = "Majority", type = "Low type", segment = "screening",
      nu = screening_nu, payoff = constants$ell
    ),
    data.frame(
      rule = "Majority", type = "High type", segment = "screening",
      nu = screening_nu, payoff = constants$h
    ),
    data.frame(
      rule = "Majority", type = "Low type", segment = "exclusion",
      nu = exclusion_nu, payoff = o_0
    ),
    data.frame(
      rule = "Majority", type = "High type", segment = "exclusion",
      nu = exclusion_nu, payoff = o_1
    ),
    data.frame(
      rule = "Unanimity", type = "Low type", segment = "pooling",
      nu = pooling_nu, payoff = constants$h
    ),
    data.frame(
      rule = "Unanimity", type = "High type", segment = "pooling",
      nu = pooling_nu, payoff = constants$h
    )
  )
  endpoint_data <- data.frame(
    rule = "Unanimity", type = c("Low type", "High type"), segment = "endpoint",
    nu = 0, payoff = c(constants$ell, constants$h), stringsAsFactors = FALSE
  )
  if (!is.null(public_benchmark)) {
    required <- c("rule", "type", "nu", "payoff")
    if (!all(required %in% names(public_benchmark))) {
      stop("public_benchmark must contain rule, type, nu, and payoff.", call. = FALSE)
    }
  }

  allocation <- data.frame(
    rule = c("Majority", "Majority", "Unanimity", "Unanimity", "Unanimity"),
    component = c(
      "Substitute votes", "Proposer residual",
      "Weak-state floors", "Concession to H", "Proposer residual"
    ),
    share = c(
      (constants$q - 1) * constants$w,
      constants$E,
      (m - 1) * constants$B,
      constants$h,
      constants$Q_P
    ),
    order = c(1, 2, 1, 2, 3),
    stringsAsFactors = FALSE
  )
  allocation$component <- factor(
    allocation$component,
    levels = c("Substitute votes", "Weak-state floors", "Concession to H", "Proposer residual")
  )
  outside_markers <- data.frame(
    rule = "Majority", x = 0.62,
    type = c("Low type", "High type"), payoff = c(o_0, o_1),
    stringsAsFactors = FALSE
  )
  list(
    lines = line_data,
    endpoints = endpoint_data,
    public_benchmark = public_benchmark,
    allocation = allocation,
    outside_markers = outside_markers,
    constants = constants,
    parameters = list(o_0 = o_0, o_1 = o_1, m = m, beta = beta, nu_example = nu_example)
  )
}

ei_rectangle_hatch <- function(xmin, xmax, ymin, ymax, panel, spacing = 0.045) {
  x_values <- seq(xmin + spacing / 2, xmax - spacing / 2, by = spacing)
  y_values <- seq(ymin + spacing / 3, ymax - spacing / 3, by = spacing)
  if (length(x_values) == 0L || length(y_values) == 0L) return(data.frame())
  grid <- expand.grid(x = x_values, y = y_values, KEEP.OUT.ATTRS = FALSE)
  grid$xend <- pmin(grid$x + 0.018, xmax - 0.002)
  grid$yend <- pmin(grid$y + 0.018, ymax - 0.002)
  grid$rule <- panel
  grid
}

plot_essential_input_f2 <- function(data_object) {
  constants <- data_object$constants
  parameters <- data_object$parameters
  no_pbe_rect <- data.frame(
    rule = "Unanimity", xmin = 0, xmax = constants$nu_star,
    ymin = 0, ymax = 0.40
  )
  rent_rect <- data.frame(
    rule = "Unanimity", xmin = constants$nu_star, xmax = 1,
    ymin = constants$ell, ymax = constants$h
  )
  hatch <- ei_rectangle_hatch(
    0, constants$nu_star, 0, 0.40, "Unanimity", spacing = 0.04
  )
  cutoff_data <- data.frame(
    rule = c("Majority", "Unanimity"),
    cutoff = c(constants$nu_SE, constants$nu_star),
    label = c("nu_SE", "nu*"),
    stringsAsFactors = FALSE
  )

  panel_a <- ggplot2::ggplot() +
    ggplot2::geom_rect(
      data = no_pbe_rect,
      ggplot2::aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
      fill = "#D9D9D9", colour = NA, inherit.aes = FALSE
    ) +
    ggplot2::geom_rect(
      data = rent_rect,
      ggplot2::aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
      fill = "#F0E442", alpha = 0.24, colour = NA, inherit.aes = FALSE
    ) +
    ggplot2::geom_segment(
      data = hatch,
      ggplot2::aes(x = x, xend = xend, y = y, yend = yend),
      inherit.aes = FALSE, colour = "#707070", linewidth = 0.25
    ) +
    ggplot2::geom_vline(
      data = cutoff_data,
      ggplot2::aes(xintercept = cutoff),
      colour = "#1D2630", linetype = "longdash", linewidth = 0.65
    ) +
    ggplot2::geom_line(
      data = data_object$lines,
      ggplot2::aes(
        x = nu, y = payoff, colour = type, linetype = type,
        group = interaction(rule, type, segment)
      ),
      linewidth = 0.9
    ) +
    ggplot2::geom_point(
      data = data_object$endpoints,
      ggplot2::aes(x = nu, y = payoff, colour = type, shape = type),
      size = 2.9, stroke = 0.8
    ) +
    ggplot2::geom_text(
      data = cutoff_data,
      ggplot2::aes(x = cutoff, y = 0.392, label = label),
      inherit.aes = FALSE, hjust = -0.08, vjust = 1, size = 2.8
    ) +
    ggplot2::geom_segment(
      data = data.frame(rule = "Unanimity"),
      ggplot2::aes(
        x = 0.70, xend = 0.70, y = constants$ell, yend = constants$h
      ),
      inherit.aes = FALSE, colour = "#8A6D00", linewidth = 0.7
    ) +
    ggplot2::geom_segment(
      data = data.frame(rule = "Unanimity"),
      ggplot2::aes(x = 0.68, xend = 0.72, y = constants$ell, yend = constants$ell),
      inherit.aes = FALSE, colour = "#8A6D00", linewidth = 0.7
    ) +
    ggplot2::geom_segment(
      data = data.frame(rule = "Unanimity"),
      ggplot2::aes(x = 0.68, xend = 0.72, y = constants$h, yend = constants$h),
      inherit.aes = FALSE, colour = "#8A6D00", linewidth = 0.7
    ) +
    ggplot2::geom_text(
      data = data.frame(rule = "Unanimity"),
      ggplot2::aes(
        x = 0.73, y = (constants$ell + constants$h) / 2,
        label = "low type's pooling rent\n(h - ell)"
      ),
      inherit.aes = FALSE, hjust = 0, size = 2.6, colour = "#6F5700"
    ) +
    ggplot2::geom_label(
      data = data.frame(
        rule = "Unanimity", nu = constants$nu_star / 2, payoff = 0.205,
        label = "no pure-vote PBE"
      ),
      ggplot2::aes(x = nu, y = payoff, label = label),
      inherit.aes = FALSE, size = 2.65, linewidth = 0.18,
      fill = grDevices::adjustcolor("white", alpha.f = 0.82)
    ) +
    ggplot2::facet_wrap(~rule, nrow = 1) +
    ggplot2::scale_colour_manual(values = ei_type_palette) +
    ggplot2::scale_linetype_manual(values = c("Low type" = "solid", "High type" = "22")) +
    ggplot2::scale_shape_manual(values = c("Low type" = 21, "High type" = 24)) +
    ggplot2::scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2), expand = c(0, 0)) +
    ggplot2::scale_y_continuous(limits = c(0, 0.40), breaks = seq(0, 0.4, by = 0.1), expand = c(0, 0)) +
    ggplot2::coord_cartesian(clip = "off") +
    ggplot2::labs(
      title = "A. Prices paid to the hegemon",
      x = "Prior probability of the strong type, nu",
      y = "Hegemon payoff in round 1",
      colour = "Hegemon type", linetype = "Hegemon type", shape = "Hegemon type"
    ) +
    ei_manuscript_theme(9.7) +
    ggplot2::theme(legend.position = "bottom")

  if (!is.null(data_object$public_benchmark)) {
    panel_a <- panel_a + ggplot2::geom_line(
      data = data_object$public_benchmark,
      ggplot2::aes(x = nu, y = payoff, colour = type, group = interaction(rule, type)),
      linetype = "dotted", linewidth = 0.8
    )
  }

  panel_b <- ggplot2::ggplot(
    data_object$allocation,
    ggplot2::aes(x = rule, y = share, fill = component)
  ) +
    ggplot2::geom_col(width = 0.56, colour = "white", linewidth = 0.35) +
    ggplot2::geom_point(
      data = data_object$outside_markers,
      ggplot2::aes(x = x, y = payoff, shape = type),
      inherit.aes = FALSE, size = 3.0, stroke = 0.85,
      fill = "white", colour = "#1D2630"
    ) +
    ggplot2::geom_text(
      data = data.frame(x = 0.48, y = 0.47, label = "outside option\n(external to the pie)"),
      ggplot2::aes(x = x, y = y, label = label),
      inherit.aes = FALSE, hjust = 0.5, size = 2.7, colour = "#36434D"
    ) +
    ggplot2::scale_fill_manual(values = ei_allocation_palette, drop = FALSE) +
    ggplot2::scale_shape_manual(values = c("Low type" = 21, "High type" = 24)) +
    ggplot2::scale_x_discrete(expand = ggplot2::expansion(add = c(0.65, 0.35))) +
    ggplot2::scale_y_continuous(
      limits = c(0, 1), breaks = seq(0, 1, by = 0.2), expand = c(0, 0)
    ) +
    ggplot2::labs(
      title = "B. Coalition anatomy at the worked example",
      subtitle = "Under majority the pie buys substitutes; under unanimity it buys the hegemon",
      x = NULL, y = "Share of the unit institutional surplus",
      fill = "Allocation", shape = "Hegemon type"
    ) +
    ei_manuscript_theme(9.7) +
    ggplot2::theme(
      panel.grid.major.x = ggplot2::element_blank(),
      legend.position = "bottom",
      legend.box = "vertical"
    )

  caption <- sprintf(
    paste0(
      "Figure F2. Majority caps the hegemon's price by buying substitute votes; unanimity pays the hegemon directly. ",
      "Panel A plots type-specific round-1 payoffs. Majority pays beta x o0 and beta x o1 through nu_SE, then exclusion leaves H with its outside option; unanimity has no pure-vote PBE for 0 < nu <= nu* and pools at h = beta x o1 above nu*. ",
      "The yellow span is the low type's pooling rent h - ell, not the public-benchmark rent estimand. ",
      "Panel B decomposes the unit surplus at nu = %.2f: majority buys q-1 substitutes at beta/m and keeps H's outside option external to the pie; unanimity pays m-1 weak-state floors, h, and the proposer residual. ",
      "Parameters: o0 = %.3f, o1 = %.3f, m = %d, beta = %.2f. Note: Model-generated regions; all boundaries closed-form."
    ),
    parameters$nu_example, parameters$o_0, parameters$o_1, parameters$m, parameters$beta
  )
  combined <- ei_compose_vertical(
    list(panel_a, panel_b), heights = c(1.45, 1),
    title = "Figure F2. Prices and coalition anatomy",
    caption = caption
  )
  figure_data <- rbind(
    transform(data_object$lines, dataset = "panel_a_payoff"),
    transform(data_object$endpoints, dataset = "panel_a_endpoint"),
    data.frame(
      rule = as.character(data_object$allocation$rule),
      type = NA_character_, segment = as.character(data_object$allocation$component),
      nu = parameters$nu_example, payoff = data_object$allocation$share,
      dataset = "panel_b_allocation", stringsAsFactors = FALSE
    ),
    data.frame(
      rule = data_object$outside_markers$rule,
      type = data_object$outside_markers$type,
      segment = "outside_option_external_to_pie",
      nu = parameters$nu_example,
      payoff = data_object$outside_markers$payoff,
      dataset = "panel_b_outside_option",
      stringsAsFactors = FALSE
    )
  )
  attr(combined, "figure_data") <- figure_data
  combined
}

essential_input_f3_synthetic_inputs <- function(m = 4L) {
  points <- data.frame(
    type = rep(c("Low type", "High type"), each = 4L),
    rule = rep(rep(c("Majority", "Unanimity"), each = 2L), 2L),
    information = rep(c("Public", "Private"), 4L),
    payoff = c(0.12, 0.15, 0.14, 0.24, 0.35, 0.36, 0.35, 0.42),
    stringsAsFactors = FALSE
  )
  o_1 <- seq(0.05, 0.75, length.out = 240L)
  contrast <- data.frame(
    o_1 = o_1,
    delta_RI = ifelse(o_1 < 1 / m, 0.025 + 0.035 * o_1, 0.075 + 0.018 * (o_1 - 1 / m)),
    stringsAsFactors = FALSE
  )
  list(points = points, contrast = contrast)
}

plot_essential_input_f3 <- function(
    point_data = NULL, contrast_data = NULL, m = 4L,
    x_scale = c("raw", "normalized"), nu_fixed = 0.80) {
  x_scale <- match.arg(x_scale)
  placeholder <- is.null(point_data) || is.null(contrast_data)
  if (placeholder) {
    synthetic <- essential_input_f3_synthetic_inputs(m)
    point_data <- synthetic$points
    contrast_data <- synthetic$contrast
  }
  required_points <- c("type", "rule", "information", "payoff")
  required_contrast <- c("o_1", "delta_RI")
  if (!all(required_points %in% names(point_data))) {
    stop("point_data is missing required columns.", call. = FALSE)
  }
  if (!all(required_contrast %in% names(contrast_data))) {
    stop("contrast_data is missing required columns.", call. = FALSE)
  }
  point_data$x <- ifelse(point_data$rule == "Majority", 1, 2) +
    ifelse(point_data$information == "Public", -0.10, 0.10)
  point_data$type <- factor(point_data$type, levels = c("Low type", "High type"))

  brackets <- do.call(rbind, lapply(split(point_data, interaction(point_data$type, point_data$rule)), function(block) {
    public <- block$payoff[block$information == "Public"][[1L]]
    private <- block$payoff[block$information == "Private"][[1L]]
    base_x <- if (block$rule[[1L]] == "Majority") 1 else 2
    data.frame(
      type = block$type[[1L]], rule = block$rule[[1L]], x = base_x + 0.25,
      ymin = min(public, private), ymax = max(public, private),
      label = if (block$rule[[1L]] == "Majority") "RI_M" else "RI_U",
      stringsAsFactors = FALSE
    )
  }))
  deltas <- do.call(rbind, lapply(split(brackets, brackets$type), function(block) {
    majority <- block$ymax[block$rule == "Majority"] - block$ymin[block$rule == "Majority"]
    unanimity <- block$ymax[block$rule == "Unanimity"] - block$ymin[block$rule == "Unanimity"]
    data.frame(
      type = block$type[[1L]], x = 1.5, y = max(block$ymax) + 0.035,
      label = sprintf("DeltaRI = %.3f (synthetic)", unanimity - majority),
      stringsAsFactors = FALSE
    )
  }))

  panel_a <- ggplot2::ggplot(point_data, ggplot2::aes(x = x, y = payoff)) +
    ggplot2::geom_segment(
      data = reshape(
        point_data[, c("type", "rule", "information", "payoff")],
        idvar = c("type", "rule"), timevar = "information", direction = "wide"
      ),
      ggplot2::aes(
        x = ifelse(rule == "Majority", 0.90, 1.90),
        xend = ifelse(rule == "Majority", 1.10, 2.10),
        y = payoff.Public, yend = payoff.Private
      ),
      inherit.aes = FALSE, colour = "#7A8791", linewidth = 0.65
    ) +
    ggplot2::geom_point(
      ggplot2::aes(shape = information, fill = rule),
      size = 3.2, colour = "#1D2630", stroke = 0.7
    ) +
    ggplot2::geom_segment(
      data = brackets,
      ggplot2::aes(x = x, xend = x, y = ymin, yend = ymax),
      inherit.aes = FALSE, colour = "#1D2630", linewidth = 0.62
    ) +
    ggplot2::geom_text(
      data = brackets,
      ggplot2::aes(x = x + 0.03, y = (ymin + ymax) / 2, label = label),
      inherit.aes = FALSE, hjust = 0, size = 2.7
    ) +
    ggplot2::geom_text(
      data = deltas,
      ggplot2::aes(x = x, y = y, label = label),
      inherit.aes = FALSE, fontface = "bold", size = 2.65
    ) +
    ggplot2::facet_wrap(~type, nrow = 1) +
    ggplot2::scale_x_continuous(breaks = c(1, 2), labels = c("Majority", "Unanimity"), limits = c(0.68, 2.38)) +
    ggplot2::scale_shape_manual(values = c(Public = 21, Private = 24)) +
    ggplot2::scale_fill_manual(values = c(Majority = "#56B4E9", Unanimity = "#CC79A7")) +
    ggplot2::guides(
      fill = ggplot2::guide_legend(
        override.aes = list(shape = 22, colour = "#1D2630")
      ),
      shape = ggplot2::guide_legend(override.aes = list(fill = "white"))
    ) +
    ggplot2::labs(
      title = "A. Difference-in-differences structure",
      x = NULL, y = "Synthetic payoff (arbitrary units)",
      shape = "Information", fill = "Rule"
    ) +
    ei_manuscript_theme(9.7)

  contrast_plot <- contrast_data
  contrast_plot$x <- if (x_scale == "normalized") m * contrast_plot$o_1 else contrast_plot$o_1
  threshold <- if (x_scale == "normalized") 1 else 1 / m
  x_label <- if (x_scale == "normalized") "Relative hegemonic power, m x o1" else "Strong type's outside option, o1"
  panel_b <- ggplot2::ggplot(contrast_plot, ggplot2::aes(x = x, y = delta_RI)) +
    ggplot2::geom_vline(
      xintercept = threshold, linetype = "longdash", colour = "#1D2630", linewidth = 0.68
    ) +
    ggplot2::geom_line(colour = "#0072B2", linewidth = 1.0) +
    ggplot2::annotate(
      "text", x = threshold, y = max(contrast_plot$delta_RI) * 0.98,
      label = if (x_scale == "normalized") "m x o1 = 1" else "o1 = 1/m",
      hjust = -0.08, vjust = 1, size = 2.8
    ) +
    ggplot2::labs(
      title = "B. Institutional information-rent contrast",
      subtitle = sprintf("Synthetic discontinuity layout; nu fixed at %.2f above nu*", nu_fixed),
      x = x_label, y = "Synthetic DeltaRI (arbitrary units)"
    ) +
    ei_manuscript_theme(9.7)

  if (placeholder) {
    watermark <- data.frame(x = 1.5, y = mean(range(point_data$payoff)))
    panel_a <- panel_a + ggplot2::geom_text(
      data = watermark,
      ggplot2::aes(x = x, y = y, label = "PLACEHOLDER - awaiting N7"),
      inherit.aes = FALSE, angle = 22, size = 8.5, fontface = "bold",
      colour = grDevices::adjustcolor("#5E6870", alpha.f = 0.24)
    )
    panel_b <- panel_b + ggplot2::annotate(
      "text", x = mean(range(contrast_plot$x)), y = mean(range(contrast_plot$delta_RI)),
      label = "PLACEHOLDER - awaiting N7", angle = 18, size = 8.5,
      fontface = "bold", colour = grDevices::adjustcolor("#5E6870", alpha.f = 0.24)
    )
  }

  caption <- paste0(
    "Figure F3. Placeholder architecture for separating institutional power from informational power. ",
    "Panel A shows the intended four-point comparison of public and private information under majority and unanimity for each hegemon type; vertical brackets define RI_M and RI_U, and their difference defines DeltaRI. ",
    "Panel B shows the intended discontinuity-style display of DeltaRI against hegemonic power at a prior above nu*. ",
    "All displayed values are synthetic and carry no substantive interpretation; the plotting function accepts real public/private and contrast data as arguments once the public benchmark is available. ",
    "Note: Synthetic placeholder only; no public-benchmark result is consumed."
  )
  combined <- ei_compose_vertical(
    list(panel_a, panel_b), heights = c(1.15, 1),
    title = "Figure F3. Power versus information decomposition",
    caption = caption
  )
  point_export <- transform(point_data, dataset = "panel_a_synthetic_points")
  contrast_export <- data.frame(
    type = NA_character_, rule = NA_character_, information = NA_character_, payoff = NA_real_,
    x = contrast_plot$x, dataset = "panel_b_synthetic_contrast",
    o_1 = contrast_plot$o_1, delta_RI = contrast_plot$delta_RI,
    stringsAsFactors = FALSE
  )
  point_export$o_1 <- NA_real_
  point_export$delta_RI <- NA_real_
  attr(combined, "figure_data") <- rbind(point_export, contrast_export)
  combined
}

essential_input_f4_data <- function(
    o_0 = 0.10, o_1 = 0.35, m = 4L, beta = 0.90) {
  constants <- essential_input_constants(m + 1L, o_0, o_1, beta, 0.35)
  payoff_line <- rbind(
    data.frame(nu = 0, payoff = constants$ell, segment = "endpoint"),
    data.frame(
      nu = seq(constants$nu_star + 1e-6, 1, length.out = 350L),
      payoff = constants$h, segment = "pooling"
    )
  )
  regions <- data.frame(
    region = c("Instability", "Pooling"),
    xmin = c(0, constants$nu_star), xmax = c(constants$nu_star, 1),
    ymin = 0, ymax = 0.40,
    stringsAsFactors = FALSE
  )
  list(
    payoff_line = payoff_line, regions = regions, constants = constants,
    parameters = list(o_0 = o_0, o_1 = o_1, m = m, beta = beta)
  )
}

plot_essential_input_f4 <- function(data_object) {
  constants <- data_object$constants
  parameters <- data_object$parameters
  hatch <- ei_rectangle_hatch(0, constants$nu_star, 0, 0.40, "Unanimity", spacing = 0.038)
  plot <- ggplot2::ggplot() +
    ggplot2::geom_rect(
      data = data_object$regions,
      ggplot2::aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = region),
      colour = NA
    ) +
    ggplot2::geom_segment(
      data = hatch,
      ggplot2::aes(x = x, xend = xend, y = y, yend = yend),
      inherit.aes = FALSE, colour = "#696969", linewidth = 0.26
    ) +
    ggplot2::geom_vline(
      xintercept = constants$nu_star, linetype = "longdash",
      linewidth = 0.70, colour = "#1D2630"
    ) +
    ggplot2::geom_line(
      data = data_object$payoff_line[data_object$payoff_line$segment == "pooling", ],
      ggplot2::aes(x = nu, y = payoff),
      colour = "#0072B2", linewidth = 1.0
    ) +
    ggplot2::geom_point(
      data = data_object$payoff_line[data_object$payoff_line$segment == "endpoint", ],
      ggplot2::aes(x = nu, y = payoff),
      shape = 21, size = 3.4, stroke = 0.9, fill = "white", colour = "#0072B2"
    ) +
    ggplot2::annotate(
      "segment", x = 0.90, xend = 0.58, y = 0.385, yend = 0.385,
      arrow = grid::arrow(length = grid::unit(0.10, "inches")),
      colour = "#36434D", linewidth = 0.7
    ) +
    ggplot2::annotate(
      "text", x = 0.74, y = 0.395,
      label = "Read hegemonic decline from right to left", size = 3.0, vjust = 0
    ) +
    ggplot2::annotate(
      "label", x = constants$nu_star / 2, y = 0.205,
      label = "no stable pure voting\npattern (instability)",
      size = 3.0, linewidth = 0.18,
      fill = grDevices::adjustcolor("white", alpha.f = 0.84)
    ) +
    ggplot2::annotate(
      "label", x = (1 + constants$nu_star) / 2, y = 0.35,
      label = "pooling: low type receives\nthe high type's price",
      size = 3.0, linewidth = 0.18,
      fill = grDevices::adjustcolor("white", alpha.f = 0.84)
    ) +
    ggplot2::annotate(
      "label", x = 0.035, y = 0.055,
      label = "common-knowledge weakness:\nH bought at reservation",
      hjust = 0, vjust = 0.5, size = 2.75, linewidth = 0.18,
      fill = grDevices::adjustcolor("white", alpha.f = 0.84)
    ) +
    ggplot2::annotate(
      "text", x = constants$nu_star + 0.012, y = 0.015,
      label = "nu* = (o1-o0)/(1-o0)", hjust = 0, vjust = 0,
      size = 2.7, colour = "#36434D"
    ) +
    ggplot2::annotate(
      "segment", x = 0.78, xend = 0.78, y = constants$ell, yend = constants$h,
      colour = "#8A6D00", linewidth = 0.72
    ) +
    ggplot2::annotate(
      "text", x = 0.80, y = (constants$ell + constants$h) / 2,
      label = "pooling rent h - ell", hjust = 0, size = 2.8, colour = "#6F5700"
    ) +
    ggplot2::scale_fill_manual(
      values = c(Instability = "#D9D9D9", Pooling = "#E69F00"),
      labels = c(
        Instability = "No stable pure voting pattern",
        Pooling = "Pooling under unanimity"
      )
    ) +
    ggplot2::scale_x_continuous(
      limits = c(0, 1), breaks = seq(0, 1, by = 0.2), expand = c(0, 0)
    ) +
    ggplot2::scale_y_continuous(
      limits = c(0, 0.42), breaks = seq(0, 0.4, by = 0.1), expand = c(0, 0)
    ) +
    ggplot2::coord_cartesian(clip = "off") +
    ggplot2::labs(
      title = "Figure F4. Hegemonic decline moves from pooling through instability to an isolated endpoint",
      subtitle = sprintf(
        "o0 = %.3f; o1 = %.3f; m = %d weak states; beta = %.2f",
        parameters$o_0, parameters$o_1, parameters$m, parameters$beta
      ),
      x = "Prior probability of the strong type, nu",
      y = "Low type's payoff under unanimity",
      fill = "Region",
      caption = ei_wrap_text(paste0(
        "The figure should be read from high to low nu. Above nu*, pooling pays the low type h = beta x o1, creating the rent h - ell relative to its reservation price ell = beta x o0. ",
        "For 0 < nu <= nu*, the hatched area records the absence of a stable pure voting pattern; nu = 0 is an isolated complete-information endpoint, not an interval, and the low type is bought at reservation. ",
        "This is a qualitative interpretation analogous to Edgeworth-cycle instability, not a theorem that the game cycles. ",
        "Note: Model-generated regions; all boundaries closed-form."
      ), width = 145L)
    ) +
    ei_manuscript_theme(10.5) +
    ggplot2::theme(plot.caption = ggplot2::element_text(hjust = 0, size = 7.8))
  export <- rbind(
    data.frame(
      record_type = "region", region = data_object$regions$region,
      nu = data_object$regions$xmin, nu_end = data_object$regions$xmax,
      payoff = NA_real_, segment = NA_character_
    ),
    data.frame(
      record_type = "payoff", region = NA_character_,
      nu = data_object$payoff_line$nu, nu_end = NA_real_,
      payoff = data_object$payoff_line$payoff, segment = data_object$payoff_line$segment
    )
  )
  attr(plot, "figure_data") <- export
  plot
}

ei_clip_polygon_halfplane <- function(polygon, a, b, c, tolerance = 1e-12) {
  if (is.null(polygon) || nrow(polygon) < 3L) return(NULL)
  value <- function(point) a * point[[1L]] + b * point[[2L]] + c
  output <- list()
  output_index <- 0L
  for (index in seq_len(nrow(polygon))) {
    current <- as.numeric(polygon[index, c("o_0", "o_1")])
    previous_index <- if (index == 1L) nrow(polygon) else index - 1L
    previous <- as.numeric(polygon[previous_index, c("o_0", "o_1")])
    current_value <- value(current)
    previous_value <- value(previous)
    current_inside <- current_value >= -tolerance
    previous_inside <- previous_value >= -tolerance
    intersection <- function() {
      denominator <- previous_value - current_value
      if (abs(denominator) < tolerance) return(current)
      fraction <- previous_value / denominator
      previous + fraction * (current - previous)
    }
    if (current_inside) {
      if (!previous_inside) {
        output_index <- output_index + 1L
        output[[output_index]] <- intersection()
      }
      output_index <- output_index + 1L
      output[[output_index]] <- current
    } else if (previous_inside) {
      output_index <- output_index + 1L
      output[[output_index]] <- intersection()
    }
  }
  if (length(output) < 3L) return(NULL)
  matrix <- do.call(rbind, output)
  data.frame(o_0 = matrix[, 1L], o_1 = matrix[, 2L])
}

ei_clip_polygon <- function(polygon, halfplanes) {
  result <- polygon
  for (halfplane in halfplanes) {
    result <- ei_clip_polygon_halfplane(
      result, halfplane[[1L]], halfplane[[2L]], halfplane[[3L]]
    )
    if (is.null(result)) return(NULL)
  }
  result
}

essential_input_appendix_c1_data <- function(
    nu = 0.35, m = 4L, beta = 0.90, example = c(o_0 = 0.10, o_1 = 0.35)) {
  q <- floor((m + 1L) / 2) + 1L
  c_sub <- 1 / m
  boundary_constant <- nu
  boundary_slope <- 1 - nu
  sp_constant <- nu / beta - nu * (q - 1) / m
  sp_slope <- 1 - nu
  d_value <- 1 - beta * q / m
  o0_se <- c_sub - nu * d_value / (beta * (1 - nu))
  domain <- data.frame(o_0 = c(0, 0, 1), o_1 = c(0, 1, 1))
  comparable <- list(c(boundary_slope, -1, boundary_constant))
  none <- list(c(-boundary_slope, 1, -boundary_constant))
  below <- list(c(0, -1, c_sub))
  above_o1 <- list(c(0, 1, -c_sub))
  below_o0 <- list(c(-1, 0, c_sub))
  above_o0 <- list(c(1, 0, -c_sub))
  screening_sp <- list(c(-sp_slope, 1, -sp_constant))
  pooling_sp <- list(c(sp_slope, -1, sp_constant))
  screening_se <- list(c(-1, 0, o0_se))
  exclusion_se <- list(c(1, 0, -o0_se))
  low_prefers_u <- list(c(-1, beta, 0))
  low_prefers_m <- list(c(1, -beta, 0))

  source_polygons <- list(
    none = ei_clip_polygon(domain, none),
    screening_below = ei_clip_polygon(domain, c(comparable, below, screening_sp)),
    pooling_below = ei_clip_polygon(domain, c(comparable, below, pooling_sp)),
    screening_cross = ei_clip_polygon(domain, c(comparable, above_o1, below_o0, screening_se)),
    exclusion_cross = ei_clip_polygon(domain, c(comparable, above_o1, below_o0, exclusion_se)),
    exclusion_above = ei_clip_polygon(domain, c(comparable, above_o0))
  )

  rows <- list()
  row_index <- 0L
  add_polygon <- function(polygon, type, region, id, extra_halfplanes = list()) {
    if (length(extra_halfplanes) > 0L) polygon <- ei_clip_polygon(polygon, extra_halfplanes)
    if (is.null(polygon) || nrow(polygon) < 3L) return(NULL)
    polygon$hegemon_type <- type
    polygon$region <- region
    polygon$polygon_id <- id
    polygon$record_type <- "region_polygon"
    polygon
  }
  for (type in c("Low type", "High type")) {
    row_index <- row_index + 1L
    rows[[row_index]] <- add_polygon(
      source_polygons$none, type,
      "No comparison: no pure-vote PBE (unanimity)", paste0("none_", type)
    )
    for (name in c("screening_below", "screening_cross")) {
      row_index <- row_index + 1L
      rows[[row_index]] <- add_polygon(
        source_polygons[[name]], type,
        if (type == "Low type") "H prefers unanimity" else "H indifferent",
        paste0(name, "_", type)
      )
    }
    row_index <- row_index + 1L
    rows[[row_index]] <- add_polygon(
      source_polygons$pooling_below, type, "H indifferent", paste0("pooling_", type)
    )
    for (name in c("exclusion_cross", "exclusion_above")) {
      if (type == "High type") {
        row_index <- row_index + 1L
        rows[[row_index]] <- add_polygon(
          source_polygons[[name]], type, "H prefers majority", paste0(name, "_", type)
        )
      } else {
        row_index <- row_index + 1L
        rows[[row_index]] <- add_polygon(
          source_polygons[[name]], type, "H prefers unanimity",
          paste0(name, "_u_", type), low_prefers_u
        )
        row_index <- row_index + 1L
        rows[[row_index]] <- add_polygon(
          source_polygons[[name]], type, "H prefers majority",
          paste0(name, "_m_", type), low_prefers_m
        )
      }
    }
  }
  regions <- ei_safe_rbind(rows)

  x <- seq(0, 1, length.out = 500L)
  sp_x <- seq(0, 1, length.out = 500L)
  sp_y <- sp_constant + sp_slope * sp_x
  sp_keep <- sp_y <= c_sub & sp_y >= sp_x & sp_y >= 0
  frontiers <- ei_safe_rbind(list(
    data.frame(
      o_0 = x, o_1 = boundary_constant + boundary_slope * x,
      boundary = "nu = nu*", record_type = "analytic_frontier"
    ),
    data.frame(
      o_0 = sp_x[sp_keep], o_1 = sp_y[sp_keep],
      boundary = "nu = nu_SP", record_type = "analytic_frontier"
    ),
    data.frame(
      o_0 = c(o0_se, o0_se), o_1 = c(c_sub, 1),
      boundary = "nu = nu_SE", record_type = "analytic_frontier"
    ),
    data.frame(
      o_0 = c(0, 1), o_1 = c(c_sub, c_sub),
      boundary = "o1 = 1/m", record_type = "analytic_frontier"
    ),
    data.frame(
      o_0 = c(c_sub, c_sub), o_1 = c(c_sub, 1),
      boundary = "o0 = 1/m", record_type = "analytic_frontier"
    ),
    data.frame(
      o_0 = beta * x, o_1 = x,
      boundary = "o0 = beta o1", record_type = "analytic_frontier"
    )
  ))
  frontiers <- frontiers[
    frontiers$o_0 >= 0 & frontiers$o_0 <= 1 &
      frontiers$o_1 >= 0 & frontiers$o_1 <= 1 &
      frontiers$o_0 <= frontiers$o_1,
    , drop = FALSE
  ]
  frontiers <- do.call(rbind, lapply(c("Low type", "High type"), function(type) {
    block <- frontiers
    if (type == "High type") {
      block <- block[block$boundary != "o0 = beta o1", , drop = FALSE]
    }
    transform(block, hegemon_type = type, region = boundary, polygon_id = NA_character_)
  }))

  hatch <- expand.grid(
    o_0 = seq(0.03, 0.92, by = 0.055),
    o_1 = seq(0.08, 0.96, by = 0.055),
    KEEP.OUT.ATTRS = FALSE
  )
  hatch <- hatch[
    hatch$o_1 >= boundary_constant + boundary_slope * hatch$o_0 + 0.02 &
      hatch$o_1 <= 0.98,
    , drop = FALSE
  ]
  hatch$xend <- pmin(hatch$o_0 + 0.025, 0.98)
  hatch$yend <- pmin(hatch$o_1 + 0.025, 0.99)
  hatch <- do.call(rbind, lapply(c("Low type", "High type"), function(type) {
    transform(hatch, hegemon_type = type)
  }))
  example_rows <- data.frame(
    o_0 = example[["o_0"]], o_1 = example[["o_1"]],
    hegemon_type = c("Low type", "High type"),
    region = "Worked example", polygon_id = NA_character_,
    record_type = "worked_example", stringsAsFactors = FALSE
  )
  list(
    regions = regions, frontiers = frontiers, hatch = hatch, example = example_rows,
    constants = list(nu = nu, m = m, beta = beta, q = q, o0_se = o0_se)
  )
}

plot_essential_input_appendix_c1 <- function(data_object) {
  frontier_styles <- c(
    "nu = nu*" = "solid", "nu = nu_SP" = "22", "nu = nu_SE" = "42",
    "o1 = 1/m" = "longdash", "o0 = 1/m" = "longdash", "o0 = beta o1" = "dotted"
  )
  plot <- ggplot2::ggplot() +
    ggplot2::geom_polygon(
      data = data_object$regions,
      ggplot2::aes(x = o_0, y = o_1, group = polygon_id, fill = region),
      colour = NA
    ) +
    ggplot2::geom_segment(
      data = data_object$hatch,
      ggplot2::aes(x = o_0, xend = xend, y = o_1, yend = yend),
      inherit.aes = FALSE, colour = "#6D6D6D", linewidth = 0.25
    ) +
    ggplot2::geom_line(
      data = data_object$frontiers,
      ggplot2::aes(
        x = o_0, y = o_1, group = interaction(hegemon_type, boundary),
        linetype = boundary
      ),
      colour = "#1D2630", linewidth = 0.58
    ) +
    ggplot2::geom_point(
      data = data_object$example,
      ggplot2::aes(x = o_0, y = o_1),
      inherit.aes = FALSE, shape = 21, size = 3.2, stroke = 0.9,
      fill = "white", colour = "black"
    ) +
    ggplot2::geom_text(
      data = data_object$example,
      ggplot2::aes(x = o_0, y = o_1, label = "worked example"),
      inherit.aes = FALSE, nudge_x = 0.025, nudge_y = 0.025,
      hjust = 0, size = 2.7
    ) +
    ggplot2::facet_wrap(
      ~factor(hegemon_type, levels = c("Low type", "High type")), nrow = 1
    ) +
    ggplot2::scale_fill_manual(values = ei_response_palette, drop = FALSE) +
    ggplot2::scale_linetype_manual(values = frontier_styles) +
    ggplot2::coord_equal(xlim = c(0, 1), ylim = c(0, 1), expand = FALSE) +
    ggplot2::labs(
      title = "Appendix Figure C.1. Institutional comparison in the outside-option plane",
      subtitle = sprintf(
        "Prior nu = %.2f; m = %d weak states; beta = %.2f",
        data_object$constants$nu, data_object$constants$m, data_object$constants$beta
      ),
      x = "Low type's outside option, o0",
      y = "Strong type's outside option, o1",
      fill = "Private-rule comparison",
      linetype = "Analytical boundary",
      caption = ei_wrap_text(paste0(
        "The triangular domain satisfies 0 < o0 < o1 < 1. Colored polygons report the type-specific payoff comparison between unanimity and majority; the neutral hatched polygon has no comparison because unanimity has no pure-vote PBE. ",
        "The worked example is o0 = 0.100 and o1 = 0.350. All boundaries are evaluated analytically rather than filled by a classification grid. ",
        "Note: Model-generated regions; all boundaries closed-form."
      ), width = 150L)
    ) +
    ei_manuscript_theme(10.2) +
    ggplot2::theme(
      panel.spacing.x = grid::unit(2.1, "lines"),
      legend.box = "vertical",
      plot.caption = ggplot2::element_text(hjust = 0, size = 7.7)
    )
  export <- ei_safe_rbind(list(
    data_object$regions,
    data.frame(
      o_0 = data_object$frontiers$o_0,
      o_1 = data_object$frontiers$o_1,
      hegemon_type = data_object$frontiers$hegemon_type,
      region = data_object$frontiers$boundary,
      polygon_id = NA_character_,
      record_type = "analytic_frontier",
      stringsAsFactors = FALSE
    ),
    data_object$example
  ))
  attr(plot, "figure_data") <- export
  plot
}
