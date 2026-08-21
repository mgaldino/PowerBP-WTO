#!/usr/bin/env Rscript

# Synthetic, model-agnostic machinery for the informational-rent estimand.
#
# This file implements Section 1 of the Gate 0 contract without importing any
# N6 or N7 payoff.  A payoff set is a finite set of vectors with coordinates
# `theta_0` and `theta_1`.  Empty inputs remain empty; no sentinel equilibrium
# and no convexification are introduced.

ri_coordinate_names <- c("theta_0", "theta_1")

ri_empty_set <- function() {
  matrix(
    numeric(), nrow = 0L, ncol = 2L,
    dimnames = list(NULL, ri_coordinate_names)
  )
}

ri_as_payoff_set <- function(x, label = "payoff_set") {
  if (is.null(x)) return(ri_empty_set())
  if (is.list(x) && !is.data.frame(x) && !is.matrix(x)) {
    if (length(x) == 0L) return(ri_empty_set())
    element_lengths <- vapply(x, length, integer(1))
    if (any(element_lengths != 2L)) {
      stop(paste(label, "must contain only two-coordinate vectors."), call. = FALSE)
    }
    x <- do.call(rbind, lapply(x, function(vector) as.numeric(vector)))
  }
  if (is.numeric(x) && is.null(dim(x))) {
    if (length(x) == 0L) return(ri_empty_set())
    if (length(x) != 2L) {
      stop(paste(label, "must have exactly two coordinates."), call. = FALSE)
    }
    x <- matrix(x, nrow = 1L)
  }
  x <- as.matrix(x)
  if (nrow(x) == 0L) return(ri_empty_set())
  if (ncol(x) != 2L) {
    stop(paste(label, "must have exactly two columns."), call. = FALSE)
  }
  storage.mode(x) <- "double"
  if (any(!is.finite(x))) {
    stop(paste(label, "contains a non-finite payoff."), call. = FALSE)
  }
  colnames(x) <- ri_coordinate_names
  unique(x)
}

ri_is_empty <- function(payoff_set) {
  nrow(ri_as_payoff_set(payoff_set)) == 0L
}

ri_componentwise_difference_set <- function(minuend, subtrahend) {
  left <- ri_as_payoff_set(minuend, "minuend")
  right <- ri_as_payoff_set(subtrahend, "subtrahend")
  if (nrow(left) == 0L || nrow(right) == 0L) return(ri_empty_set())
  differences <- matrix(
    NA_real_, nrow = nrow(left) * nrow(right), ncol = 2L,
    dimnames = list(NULL, ri_coordinate_names)
  )
  index <- 0L
  for (left_index in seq_len(nrow(left))) {
    for (right_index in seq_len(nrow(right))) {
      index <- index + 1L
      differences[index, ] <- left[left_index, ] - right[right_index, ]
    }
  }
  unique(differences)
}

ri_validate_tolerance <- function(tolerance) {
  if (length(tolerance) != 1L || !is.finite(tolerance) || tolerance < 0) {
    stop("tolerance must be one finite nonnegative number.", call. = FALSE)
  }
  tolerance
}

ri_sign_class <- function(values, tolerance = 0) {
  tolerance <- ri_validate_tolerance(tolerance)
  if (length(values) == 0L) return("empty")
  if (all(values > tolerance)) return("robust_positive")
  if (all(values < -tolerance)) return("robust_negative")
  if (all(abs(values) <= tolerance)) return("robust_zero")
  if (all(values >= -tolerance)) return("robust_nonnegative")
  if (all(values <= tolerance)) return("robust_nonpositive")
  "sign_indeterminate"
}

ri_envelopes <- function(payoff_set, tolerance = 0) {
  tolerance <- ri_validate_tolerance(tolerance)
  set <- ri_as_payoff_set(payoff_set)
  if (nrow(set) == 0L) {
    return(data.frame(
      coordinate = ri_coordinate_names,
      lower = NA_real_, upper = NA_real_, sign_status = "empty",
      stringsAsFactors = FALSE
    ))
  }
  data.frame(
    coordinate = ri_coordinate_names,
    lower = apply(set, 2L, min),
    upper = apply(set, 2L, max),
    sign_status = vapply(
      seq_len(2L),
      function(index) ri_sign_class(set[, index], tolerance),
      character(1)
    ),
    stringsAsFactors = FALSE
  )
}

ri_ex_ante_image <- function(payoff_set, nu) {
  if (length(nu) != 1L || !is.finite(nu) || nu < 0 || nu > 1) {
    stop("nu must belong to [0,1].", call. = FALSE)
  }
  set <- ri_as_payoff_set(payoff_set)
  if (nrow(set) == 0L) return(numeric())
  sort(unique((1 - nu) * set[, "theta_0"] + nu * set[, "theta_1"]))
}

ri_robustness <- function(payoff_set, nu = NULL, tolerance = 0) {
  tolerance <- ri_validate_tolerance(tolerance)
  set <- ri_as_payoff_set(payoff_set)
  coordinate_status <- setNames(
    vapply(
      seq_len(2L),
      function(index) ri_sign_class(set[, index], tolerance),
      character(1)
    ),
    ri_coordinate_names
  )
  ex_ante_status <- if (is.null(nu)) {
    NA_character_
  } else {
    ri_sign_class(ri_ex_ante_image(set, nu), tolerance)
  }
  list(
    is_empty = nrow(set) == 0L,
    coordinate_sign = coordinate_status,
    every_coordinate_robust_positive =
      nrow(set) > 0L && all(coordinate_status == "robust_positive"),
    every_coordinate_robust_negative =
      nrow(set) > 0L && all(coordinate_status == "robust_negative"),
    ex_ante_sign = ex_ante_status
  )
}

ri_rule <- function(V_priv, V_pub, institution, nu = NULL, tolerance = 0) {
  tolerance <- ri_validate_tolerance(tolerance)
  if (length(institution) != 1L || !institution %in% c("majority", "unanimity")) {
    stop("institution must be 'majority' or 'unanimity'.", call. = FALSE)
  }
  private_set <- ri_as_payoff_set(V_priv, "V_priv")
  public_set <- ri_as_payoff_set(V_pub, "V_pub")
  rent_set <- ri_componentwise_difference_set(private_set, public_set)
  status <- if (nrow(private_set) == 0L || nrow(public_set) == 0L) "empty" else "exists"
  list(
    object = if (institution == "majority") "RI_M" else "RI_U",
    institution = institution,
    status = status,
    V_priv = private_set,
    V_pub = public_set,
    vectors = rent_set,
    tolerance = tolerance,
    envelopes = ri_envelopes(rent_set, tolerance),
    ex_ante_image = if (is.null(nu)) NULL else ri_ex_ante_image(rent_set, nu),
    robustness = ri_robustness(rent_set, nu, tolerance)
  )
}

delta_ri <- function(RI_U, RI_M, nu = NULL, tolerance = 0) {
  tolerance <- ri_validate_tolerance(tolerance)
  required_fields <- c("object", "status", "vectors")
  if (!is.list(RI_U) || !all(required_fields %in% names(RI_U)) || RI_U$object != "RI_U") {
    stop("RI_U must be an object returned by ri_rule(..., institution='unanimity').", call. = FALSE)
  }
  if (!is.list(RI_M) || !all(required_fields %in% names(RI_M)) || RI_M$object != "RI_M") {
    stop("RI_M must be an object returned by ri_rule(..., institution='majority').", call. = FALSE)
  }
  contrast_set <- if (RI_U$status == "empty" || RI_M$status == "empty") {
    ri_empty_set()
  } else {
    ri_componentwise_difference_set(RI_U$vectors, RI_M$vectors)
  }
  status <- if (nrow(contrast_set) == 0L) "empty" else "exists"
  list(
    object = "DeltaRI",
    status = status,
    vectors = contrast_set,
    tolerance = tolerance,
    envelopes = ri_envelopes(contrast_set, tolerance),
    ex_ante_image = if (is.null(nu)) NULL else ri_ex_ante_image(contrast_set, nu),
    robustness = ri_robustness(contrast_set, nu, tolerance),
    robust_institutional_ordering =
      status == "exists" &&
        ri_robustness(contrast_set, nu, tolerance)$every_coordinate_robust_positive
  )
}
