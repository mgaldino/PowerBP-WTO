#!/usr/bin/env Rscript

# Adversarial common-mode checks for the independent N3 proof replay.
# Constructors are changed before both the generated proof and any helper-built
# expected objects run.  The low-level invariant checks must still reject.

source("scripts/lib_essential_input_semantic_ast_v1.R")
source("scripts/lib_essential_input_exact_algebra_v1.R")
source("scripts/lib_essential_input_schema_roles_v1.R")
source("scripts/lib_essential_input_n3_game_kernel_v1.R")
source("scripts/lib_essential_input_proof_kernel_v1.R")

primitives <- n3g_primitives()
n1 <- n3g_import_n1(
  "model_redesign/essential_input_interfaces/n1_r2_majority_candidate_v1.json"
)

replay <- function() {
  pk_replay_proofs(n3g_generate_proofs(), primitives, n1, n3_claim_spec_v1())
}

baseline <- replay()
stopifnot(identical(baseline$status, "INTERNAL_REPLAY_NOT_READY"),
          length(baseline$values) == 29L,
          length(baseline$certificates) == 17L)

# Each case is pinned to one exact independent-checker failure.  A generic
# "some FAIL happened" outcome is insufficient because it can hide a move to
# an earlier integrity check or an unrelated failure layer.
common_mode_expected <- c(
  "hedge expected gain has the wrong sign" =
    "FAIL_CERTIFICATE: slack expected gain does not equal its rule-computed expression",
  "simplex normalization equals two" =
    "FAIL_CERTIFICATE: simplex normalization is not exactly one",
  "simplex omits pure identity vertices" =
    "FAIL_CERTIFICATE: simplex identity or mixture space changed",
  "simplex imposes cross-identity symmetry" =
    "FAIL_CERTIFICATE: simplex identity or mixture space changed",
  "simplex support is declared empty" =
    "FAIL_CERTIFICATE: simplex support nonemptiness proof changed",
  "positive-mass Bayes posterior is zero" =
    "FAIL_CERTIFICATE: Bayes posterior uses an unproved denominator",
  "kappa is restricted to a singleton" =
    "FAIL_CERTIFICATE: region 1 kappa is not unrestricted on [0,1]",
  "eta is restricted at one zero-mass history" =
    "FAIL_CERTIFICATE: region 1 nu0 eta is not unrestricted on [0,1]",
  "selected strategy is a strict profitable deviation from itself" =
    "FAIL_CERTIFICATE: proposer deviation relation or domain changed",
  "weak ballot action and equality policy are inverted" =
    "FAIL_CERTIFICATE: weak best-response policy or schema changed",
  "H nonpivotal and passing-anyway actions are inverted" =
    "FAIL_CERTIFICATE: H nonpivotal response changed",
  "proposer middle payoff and k partition are corrupted" =
    "FAIL_CERTIFICATE: proposer case 3 expected payoff does not equal its rule-computed expression",
  "argmax branch and dominance labels contradict the payoff order" =
    "FAIL_CERTIFICATE: argmax branches, dominance relations, intervals, or ties changed",
  "feasibility total and residual sign derivation are corrupted" =
    "FAIL_CERTIFICATE: feasibility base budgets are not exact full-pie identities",
  "tie ownership and minimum-H selection are inverted" =
    "FAIL_CERTIFICATE: tie-break formula, frontier ownership, H trichotomy, or selection changed",
  "indexed weak coefficient, H payoff, and exclusion outcome are corrupted" =
    "FAIL_CERTIFICATE: indexed payoff/outcome record 4 changed a coefficient, type payoff, outcome, or binding",
  "free-symbol walker retains only one AST root per source step" =
    "FAIL_COVERAGE: free-symbol closure path set, cardinality, or record proof is incomplete",
  "partition constructor negates exhaustive union after validation" =
    "FAIL_CERTIFICATE: partition count, union, intersections, endpoint ownership, ties, or witnesses changed",
  "final PBE witness erases screening delay after construction" =
    "FAIL_CERTIFICATE: PBE witness 1 strategy, beliefs, payoff/outcome map, or closure binding changed",
  "coalition binder includes the proposer in its domain" =
    "FAIL_CERTIFICATE: simplex support family or indexed sum changed",
  "indexed weight duplicates the proposer index" =
    "FAIL_CERTIFICATE: simplex support family or indexed sum changed",
  "weak identity sum drops the recipient membership restriction" =
    "FAIL_CERTIFICATE: indexed payoff/outcome record 1 changed a coefficient, type payoff, outcome, or binding",
  "EP plain sum swaps q-1 and q-2 coalition cardinalities" =
    "FAIL_CERTIFICATE: indexed payoff/outcome record 6 changed a coefficient, type payoff, outcome, or binding",
  "simplex output accepts unexpected outer and regional fields" =
    "FAIL_CERTIFICATE: simplex premise is incomplete or malformed"
)
stopifnot(length(common_mode_expected) == 24L,
          !anyDuplicated(names(common_mode_expected)))
common_mode_seen <- character()

expect_constructor_rejection <- function(name, wrapper, label) {
  expected_text <- common_mode_expected[[label]]
  if (is.null(expected_text)) stop(paste("unregistered common-mode case:", label))
  original <- get(name, envir = .GlobalEnv, inherits = FALSE)
  assign(name, wrapper(original), envir = .GlobalEnv)
  on.exit(assign(name, original, envir = .GlobalEnv), add = TRUE)
  rejection_text <- tryCatch({
    replay()
    NA_character_
  }, error = function(error) {
    conditionMessage(error)
  })
  if (is.na(rejection_text)) {
    stop(paste("common-mode mutation was accepted:", label))
  }
  if (!identical(rejection_text, expected_text)) {
    stop(paste("common-mode mutation failed at the wrong checker:", label,
               rejection_text))
  }
  common_mode_seen <<- c(common_mode_seen, label)
  message("REJECTED ", label, " => ", rejection_text)
  invisible(TRUE)
}

expect_constructor_rejection(
  "pk_hedge_from_maps",
  function(original) function(refs, primitives, sorts, n1) {
    value <- original(refs, primitives, sorts, n1)
    value$slack_fill$expected_gain <- pk_formula(
      pk_mul(sc_ast("unary", operator = "-", argument = pk_num(1),
                    sort = "Rational"),
             value$slack_fill$expected_gain$ast),
      "HEDGE_TRANSFORM"
    )
    value
  },
  "hedge expected gain has the wrong sign"
)

expect_constructor_rejection(
  "pk_simplex_for_branch",
  function(original) function(branch) {
    value <- original(branch)
    value$normalization$body$right <- sc_ast(
      "number", value = "2", sort = "Rational"
    )
    value$normalization_nf <- sc_indexed_canonical(value$normalization)
    value
  },
  "simplex normalization equals two"
)

expect_constructor_rejection(
  "pk_simplex_for_branch",
  function(original) function(branch) {
    value <- original(branch)
    value$pure_vertices <- list()
    value
  },
  "simplex omits pure identity vertices"
)

expect_constructor_rejection(
  "pk_simplex_for_branch",
  function(original) function(branch) {
    value <- original(branch)
    value$mixture_space$cross_identity_constraints <- list("forced_symmetry")
    value
  },
  "simplex imposes cross-identity symmetry"
)

expect_constructor_rejection(
  "pk_simplex_for_branch",
  function(original) function(branch) {
    value <- original(branch)
    value$support_nonempty_derivation <- lapply(
      value$support_nonempty_derivation, function(derivation) list()
    )
    value
  },
  "simplex support is declared empty"
)

expect_constructor_rejection(
  "pk_bayes_from_strategy_support",
  function(original) function(refs, primitives, sorts, n1) {
    value <- original(refs, primitives, sorts, n1)
    for (index in seq_along(value$per_region)) {
      value$per_region[[index]]$after_positive_mass_proposal$posterior <-
        pk_formula(pk_num(0), "BAYES")
    }
    value
  },
  "positive-mass Bayes posterior is zero"
)

expect_constructor_rejection(
  "pk_bayes_from_strategy_support",
  function(original) function(refs, primitives, sorts, n1) {
    value <- original(refs, primitives, sorts, n1)
    value$per_region[[1L]]$zero_mass_proposal$domain$upper <- "0"
    value
  },
  "kappa is restricted to a singleton"
)

expect_constructor_rejection(
  "pk_bayes_from_strategy_support",
  function(original) function(refs, primitives, sorts, n1) {
    value <- original(refs, primitives, sorts, n1)
    public <- value$per_region[[1L]]$after_public_vote_vector
    if (identical(public$kind, "separating_H_vote")) {
      value$per_region[[1L]]$after_public_vote_vector$endpoint_zero_mass$
        nu_0_failure$domain$upper <- "0"
    } else {
      value$per_region[[1L]]$after_public_vote_vector$zero_mass_history$
        domain$upper <- "0"
    }
    value
  },
  "eta is restricted at one zero-mass history"
)

expect_constructor_rejection(
  "pk_region_deviation_certificate",
  function(original) function(region, core, sorts) {
    value <- original(region, core, sorts)
    selected <- unlist(value$selected_set, use.names = FALSE)[[1L]]
    index <- which(vapply(value$comparisons, function(comparison) {
      identical(comparison$alternative, selected)
    }, logical(1)))[[1L]]
    value$comparisons[[index]]$relation <- ">0"
    value
  },
  "selected strategy is a strict profitable deviation from itself"
)

expect_constructor_rejection(
  "pk_make_weak_br",
  function(original) function(c_value) {
    value <- original(c_value)
    value$action <- "yes iff x_j<cutoff"
    value$equality <- "no_by_T_Y"
    value
  },
  "weak ballot action and equality policy are inverted"
)

expect_constructor_rejection(
  "pk_make_H_br",
  function(original) function(a0, a1, sorts) {
    value <- original(a0, a1, sorts)
    value$cases$k_ge_q_minus_1$action <- "yes"
    value$cases$k_le_q_minus_3$action <- "no"
    value
  },
  "H nonpivotal and passing-anyway actions are inverted"
)

expect_constructor_rejection(
  "pk_make_proposer_map",
  function(original) function(c_value, a0, a1, quota, weak_br, H_br, sorts) {
    value <- original(c_value, a0, a1, quota, weak_br, H_br, sorts)
    value$cases$k_eq_q_minus_2_middle$expected <-
      pk_formula(pk_num(999), "PAYOFF_EVAL")
    value$case_partition$k[[2L]] <- "k=999"
    value
  },
  "proposer middle payoff and k partition are corrupted"
)

expect_constructor_rejection(
  "pk_argmax_regions",
  function(original) function(differences, strict_sign, frontier_SP, frontier_SE, sorts) {
    value <- original(differences, strict_sign, frontier_SP, frontier_SE, sorts)
    index <- which(vapply(value, function(region) {
      identical(region$branch, "P") && "P>S" %in% unlist(region$dominance)
    }, logical(1)))[[1L]]
    value[[index]]$branch <- "E"
    value[[index]]$dominance <- as.list(c("E>S", "P>E", "E>R"))
    value
  },
  "argmax branch and dominance labels contradict the payoff order"
)

expect_constructor_rejection(
  "pk_feasibility_from_budgets",
  function(original) function(refs, primitives, sorts, n1) {
    value <- original(refs, primitives, sorts, n1)
    value$base_budgets$E$total <- pk_formula(pk_num(2), "FEASIBILITY")
    value$witnesses[[1L]]$nonnegativity$residual$derivation <- "residual<0"
    value
  },
  "feasibility total and residual sign derivation are corrupted"
)

expect_constructor_rejection(
  "pk_tie_break_from_payoffs",
  function(original) function(refs, primitives, sorts, n1) {
    value <- original(refs, primitives, sorts, n1)
    value$proposer_ties$S_equals_P$selected <- "P"
    value$proposer_ties$E_equals_P$selected_by_relation[["h_E<h_P"]] <- "P"
    value
  },
  "tie ownership and minimum-H selection are inverted"
)

expect_constructor_rejection(
  "pk_indexed_maps_from_strategy",
  function(original) function(refs, primitives, sorts, n1) {
    value <- original(refs, primitives, sorts, n1)
    index <- which(vapply(value$per_region, function(record) {
      identical(record$branch, "E")
    }, logical(1)))[[1L]]
    record <- value$per_region[[index]]
    record$H_by_type$theta_0 <- pk_formula(pk_num(0), "INDEXED_SUM")
    record$weak_identity_map$ast$right <-
      pk_mul(pk_num(2), record$weak_identity_map$ast$right)
    record$weak_identity_map$normal_form <-
      sc_indexed_canonical(record$weak_identity_map$ast)
    record$outcomes$pass_without_hegemon <- pk_formula(pk_num(0), "INDEXED_SUM")
    record$outcomes$failure <- pk_formula(pk_num(1), "INDEXED_SUM")
    value$per_region[[index]] <- record
    value
  },
  "indexed weak coefficient, H payoff, and exclusion outcome are corrupted"
)

expect_constructor_rejection(
  "pk_ast_root_records",
  function(original) function(value, source_step, path = "") {
    records <- original(value, source_step, path)
    if (length(records) > 1L) records[1L] else records
  },
  "free-symbol walker retains only one AST root per source step"
)

expect_constructor_rejection(
  "pk_validate_partition",
  function(original) function(regions) {
    value <- original(regions)
    value$union_exhaustive <- FALSE
    value
  },
  "partition constructor negates exhaustive union after validation"
)

expect_constructor_rejection(
  "pk_pbe_witnesses",
  function(original) function(refs, primitives, sorts, n1) {
    value <- original(refs, primitives, sorts, n1)
    index <- which(vapply(value$witnesses, function(witness) {
      identical(witness$region$branch, "S")
    }, logical(1)))[[1L]]
    value$witnesses[[index]]$payoff_outcome_map$outcomes$delay <-
      pk_formula(pk_num(0), "INDEXED_SUM")
    value
  },
  "final PBE witness erases screening delay after construction"
)

expect_constructor_rejection(
  "pk_coalition_binder",
  function(original) function(source, variable, outer_player, offset,
                              require_member_l = FALSE) {
    value <- original(source, variable, outer_player, offset, require_member_l)
    value$domain <- sc_set_W()
    value
  },
  "coalition binder includes the proposer in its domain"
)

expect_constructor_rejection(
  "pk_indexed_weight",
  function(original) function(family, proposer, coalition) {
    value <- original(family, proposer, coalition)
    value$indices <- as.list(c(proposer, proposer))
    value
  },
  "indexed weight duplicates the proposer index"
)

expect_constructor_rejection(
  "pk_membership_weight_sum",
  function(original) function(family, offset, proposer = "b1", coalition = "b2") {
    pk_plain_weight_sum(family, offset, proposer, coalition)
  },
  "weak identity sum drops the recipient membership restriction"
)

expect_constructor_rejection(
  "pk_plain_weight_sum",
  function(original) function(family, offset, proposer = "b1", coalition = "b2") {
    value <- original(family, offset, proposer, coalition)
    wrong_offset <- if (offset == 1L) 2L else 1L
    value$binder$constraints[[1L]]$equals <- sc_q_minus(wrong_offset)
    value
  },
  "EP plain sum swaps q-1 and q-2 coalition cardinalities"
)

expect_constructor_rejection(
  "pk_simplexes_from_regions",
  function(original) function(refs, primitives, sorts, n1) {
    value <- original(refs, primitives, sorts, n1)
    value$unexpected_partial_field <- "open_world"
    value$per_region[[1L]]$unexpected_partial_field <- "open_world"
    value
  },
  "simplex output accepts unexpected outer and regional fields"
)

stopifnot(identical(common_mode_seen, names(common_mode_expected)))
message("N3_REPLAY_COMMON_MODE_NEGATIVES 24/24")
