testthat::test_that("singleton rents are componentwise differences", {
  RI_M <- ri_rule(c(3, 5), c(1, 2), institution = "majority", nu = 0.4)
  testthat::expect_identical(RI_M$status, "exists")
  testthat::expect_equal(unname(RI_M$vectors), matrix(c(2, 3), nrow = 1L))
  testthat::expect_equal(RI_M$ex_ante_image, 2.4)
  testthat::expect_true(RI_M$robustness$every_coordinate_robust_positive)
})

testthat::test_that("multiplicity uses the full Cartesian product without convexification", {
  private <- rbind(c(4, 8), c(7, 6))
  public <- rbind(c(1, 2), c(3, 5))
  RI_U <- ri_rule(private, public, institution = "unanimity")
  expected <- rbind(c(3, 6), c(1, 3), c(6, 4), c(4, 1))
  colnames(expected) <- ri_coordinate_names
  testthat::expect_setequal(
    apply(RI_U$vectors, 1L, paste, collapse = ","),
    apply(expected, 1L, paste, collapse = ",")
  )
  testthat::expect_equal(RI_U$envelopes$lower, c(1, 1))
  testthat::expect_equal(RI_U$envelopes$upper, c(6, 6))
  testthat::expect_false(any(apply(RI_U$vectors, 1L, function(row) all(row == c(2, 2)))))
})

testthat::test_that("empty private or public sets make the rule rent empty", {
  empty_private <- ri_rule(ri_empty_set(), c(1, 2), institution = "majority")
  empty_public <- ri_rule(c(1, 2), ri_empty_set(), institution = "unanimity")
  testthat::expect_identical(empty_private$status, "empty")
  testthat::expect_identical(empty_public$status, "empty")
  testthat::expect_equal(nrow(empty_private$vectors), 0L)
  testthat::expect_equal(nrow(empty_public$vectors), 0L)
  testthat::expect_identical(empty_private$robustness$coordinate_sign[[1L]], "empty")
})

testthat::test_that("DeltaRI is empty if either rule rent is empty", {
  RI_U <- ri_rule(c(4, 5), c(1, 1), institution = "unanimity")
  RI_M <- ri_rule(ri_empty_set(), c(1, 1), institution = "majority")
  contrast <- delta_ri(RI_U, RI_M, nu = 0.5)
  testthat::expect_identical(contrast$status, "empty")
  testthat::expect_equal(nrow(contrast$vectors), 0L)
  testthat::expect_false(contrast$robust_institutional_ordering)
  testthat::expect_length(contrast$ex_ante_image, 0L)
})

testthat::test_that("DeltaRI preserves multiplicity and reports robust coordinate signs", {
  RI_U <- ri_rule(rbind(c(7, 8), c(8, 9)), c(1, 2), institution = "unanimity")
  RI_M <- ri_rule(rbind(c(3, 3), c(4, 4)), c(1, 1), institution = "majority")
  contrast <- delta_ri(RI_U, RI_M, nu = 0.25)
  testthat::expect_identical(contrast$status, "exists")
  testthat::expect_true(contrast$robustness$every_coordinate_robust_positive)
  testthat::expect_true(contrast$robust_institutional_ordering)
  testthat::expect_identical(contrast$robustness$ex_ante_sign, "robust_positive")
})

testthat::test_that("sign robustness is coordinatewise rather than based on one envelope corner", {
  set <- rbind(c(1, 2), c(-1, 3))
  robustness <- ri_robustness(set, nu = 0.5)
  testthat::expect_identical(robustness$coordinate_sign[["theta_0"]], "sign_indeterminate")
  testthat::expect_identical(robustness$coordinate_sign[["theta_1"]], "robust_positive")
  testthat::expect_false(robustness$every_coordinate_robust_positive)
})

testthat::test_that("prior endpoints select the matching payoff coordinate", {
  set <- rbind(c(2, 10), c(4, 20))
  testthat::expect_equal(ri_ex_ante_image(set, 0), c(2, 4))
  testthat::expect_equal(ri_ex_ante_image(set, 1), c(10, 20))
})

testthat::test_that("duplicate Cartesian differences are retained only once", {
  difference <- ri_componentwise_difference_set(
    rbind(c(2, 3), c(2, 3)),
    rbind(c(1, 1), c(1, 1))
  )
  testthat::expect_equal(nrow(difference), 1L)
  testthat::expect_equal(unname(difference), matrix(c(1, 2), nrow = 1L))
})

testthat::test_that("strict signs remain strict below conventional numerical tolerances", {
  tiny_positive <- matrix(c(1e-13, 2e-13), nrow = 1L)
  exact <- ri_robustness(tiny_positive)
  approximate <- ri_robustness(tiny_positive, tolerance = 1e-12)
  testthat::expect_true(exact$every_coordinate_robust_positive)
  testthat::expect_identical(exact$coordinate_sign[["theta_0"]], "robust_positive")
  testthat::expect_identical(approximate$coordinate_sign[["theta_0"]], "robust_zero")
})

testthat::test_that("malformed payoff lists and invalid tolerances are rejected", {
  testthat::expect_error(
    ri_as_payoff_set(list(c(1, 2), 3)),
    "only two-coordinate vectors",
    fixed = TRUE
  )
  testthat::expect_error(
    ri_sign_class(c(1, 2), tolerance = -1),
    "finite nonnegative",
    fixed = TRUE
  )
})
