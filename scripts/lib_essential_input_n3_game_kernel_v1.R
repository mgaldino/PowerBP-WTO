# Pure proof-plan generator for N3 (R1 majority).
#
# It contains typed primitives and a dependency DAG of generic proof rules. It
# contains no N3 candidate, candidate IDs/order, expected JSON object, target
# payoff formulas, or region table. Conclusions are computed only when the
# independent proof kernel replays these steps.

n3g_symbol_sorts <- function() {
  as.list(c(
    N = "Integer", m = "Integer", q = "Integer", beta = "Probability",
    nu = "Probability", o_0 = "Payoff", o_1 = "Payoff", o_theta = "Payoff",
    y_bar = "Payoff", y = "Payoff", x_j = "Payoff", r_i = "Payoff",
    theta = "Type", C_l = "Payoff", X = "Payoff", rho = "Probability"
  ))
}

n3g_primitives <- function(
    contract_path = "quality_reports/plans/2026-08-12_essential_input_gate0.md",
    frozen_contract_hash = "1e0bb0e42f3e65eab6d297e5d7d6776abbca9e88bbeabf3fb848a3a3a4dc8c21") {
  sc_assert(is.character(contract_path) && length(contract_path) == 1L &&
              file.exists(contract_path), "FAIL_BINDING", "governing contract is missing")
  contract_hash <- sc_sha256_file(contract_path)
  sc_assert(identical(contract_hash, frozen_contract_hash), "FAIL_BINDING",
            "governing contract bytes differ from the authorized contract")
  list(
    contract = list(
      path = "quality_reports/plans/2026-08-12_essential_input_gate0.md",
      sha256 = contract_hash,
      sections = as.list(c("2", "4", "5", "6", "9:P0-P7"))
    ),
    symbols = n3g_symbol_sorts(),
    axioms = list(
      players = list(N_integer = TRUE, N_lower = 3L, m_definition = "N-1"),
      parameters = list(beta_open_unit = TRUE, outside_order = "0<o_0<o_1<1",
                        y_bar = "o_1<=y_bar<=1"),
      feasibility = list(unit_pie = TRUE, slack_allowed = TRUE,
                         nonnegative = as.list(c("y", "x_j", "r_i"))),
      majority = list(quota_rule = "floor(N/2)+1"),
      recognition = list(iid = TRUE, uniform_over_m = TRUE, replacement = TRUE),
      ballot = list(pure = TRUE, simultaneous = TRUE, sealed = TRUE,
                    proposer_counts_yes = TRUE, public_vector_after = TRUE),
      payoff = list(full_y_execution = TRUE, H_no_pass = "y+o_theta",
                    H_yes_pass = "y", weak_disagreement = "0"),
      solution = list(PBE = TRUE, weak_stage_undominated = TRUE,
                      T_Y_at_genuine_equality = TRUE, H_stage_undominated = FALSE,
                      proposal_tie_break = "min_expected_H"),
      timing = list(rounds = 2L, R2_terminal = TRUE, adjacent_discount_count = 1L)
    )
  )
}

n3g_import_n1 <- function(path, frozen_hash =
                            "1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5") {
  sc_assert(file.exists(path), "FAIL_BINDING", "frozen N1 interface is missing")
  sc_assert(identical(sc_sha256_file(path), frozen_hash), "FAIL_BINDING",
            "N1 bytes differ from the frozen dependency")
  n1 <- sc_read_json_strict(path)
  sc_assert(identical(n1$schema_ref, "equilibrium_correspondence_v1"),
            "FAIL_TYPE", "N1 schema changed")
  sc_assert(length(n1$correspondence_cells) == 1L &&
              length(n1$correspondence_cells[[1L]]$equilibrium_records) == 1L,
            "FAIL_COVERAGE", "N1 must export one posterior-invariant record")
  list(path = path, artifact_hash = paste0("sha256:", frozen_hash),
       record = n1$correspondence_cells[[1L]]$equilibrium_records[[1L]])
}

n3g_step <- function(id, rule, refs = character(0), args = list()) {
  list(step_id = id, rule = rule, refs = as.list(refs), args = args)
}

n3g_generate_proofs <- function() {
  list(
    n3g_step("S01", "IMPORT_EXACT", args = list(field = "weak_value")),
    n3g_step("S02", "IMPORT_EXACT", args = list(field = "H_theta_0")),
    n3g_step("S03", "IMPORT_EXACT", args = list(field = "H_theta_1")),
    n3g_step("S04", "DISCOUNT_ONCE", "S01"),
    n3g_step("S05", "DISCOUNT_ONCE", "S02"),
    n3g_step("S06", "DISCOUNT_ONCE", "S03"),
    n3g_step("S07", "QUOTA_EVAL"),
    n3g_step("S08", "PAYOFF_EVAL", "S04", list(problem = "weak_ballot")),
    n3g_step("S09", "BEST_RESPONSE", c("S05", "S06", "S07"), list(player = "H")),
    n3g_step("S10", "PAYOFF_EVAL", c("S04", "S05", "S06", "S07", "S08", "S09"),
              list(problem = "proposer_all_feasible_proposals")),
    n3g_step("S11", "BUDGET_SATURATION", c("S04", "S07"), list(outcome = "exclude_H")),
    n3g_step("S12", "BUDGET_SATURATION", c("S04", "S05", "S07"), list(outcome = "low_only")),
    n3g_step("S13", "BUDGET_SATURATION", c("S04", "S06", "S07"), list(outcome = "pooling")),
    n3g_step("S14", "PAYOFF_EVAL", c("S04", "S12"), list(problem = "true_prior_low_only")),
    n3g_step("S15", "PAYOFF_EVAL", "S04", list(problem = "deliberate_failure")),
    n3g_step("S16", "ALGEBRA_EQ", c("S11", "S13", "S14", "S15"),
              list(operation = "all_pairwise_differences")),
    n3g_step("S17", "SIGN_FROM_DOMAIN", c("S07", "S16"),
              list(target = "E_minus_R")),
    n3g_step("S18", "SOLVE_LINEAR_INEQUALITY", c("S16", "S17"),
              list(pair = as.list(c("S", "P")), variable = "nu")),
    n3g_step("S19", "SOLVE_LINEAR_INEQUALITY", c("S16", "S17"),
              list(pair = as.list(c("S", "E")), variable = "nu")),
    n3g_step("S20", "HEDGE_TRANSFORM", c("S08", "S09", "S10")),
    n3g_step("S21", "ARGMAX_BY_CASES", c("S11", "S13", "S14", "S15", "S16",
                                                "S17", "S18", "S19", "S20")),
    n3g_step("S22", "INTERVAL_PARTITION", "S21"),
    n3g_step("S23", "FEASIBILITY",
              c("S04", "S05", "S06", "S07", "S11", "S12", "S13", "S17", "S21")),
    n3g_step("S24", "TIE_BREAK", c("S05", "S06", "S11", "S12", "S13", "S14", "S21")),
    # Simplex support is constructed before Bayes even though its stable step
    # id is S26; S25 must consume typed positive/zero-mass strategy support.
    n3g_step("S26", "SIMPLEX_SUM", c("S07", "S21", "S23")),
    n3g_step("S25", "BAYES", c("S02", "S03", "S08", "S09", "S21", "S23", "S26")),
    n3g_step("S27", "INDEXED_SUM", c("S01", "S04", "S07", "S21", "S23", "S26")),
    n3g_step("S28", "FREE_SYMBOL_CLOSURE", c("S21", "S23", "S24", "S25", "S26", "S27")),
    n3g_step("S29", "PBE_WITNESS", c("S08", "S09", "S10", "S17", "S21", "S22",
                                           "S23", "S24", "S25", "S26", "S27", "S28"))
  )
}

n3_claim_spec_v1 <- function() {
  ids <- sprintf("N3V5-C%02d", 1:17)
  labels <- c(
    "frozen N1 import and exactly-one discount", "weak ballot cutoff and equality",
    "complete H best response", "proposer payoff after every proposal",
    "exhaustive E/S/P/R reduction", "full-pie use", "strict hedge transformation",
    "strict exclusion-over-delay and delay probability", "branch feasibility",
    "disjoint exhaustive endpoint-complete partition", "residual E/P tie",
    "identity-indexed simplexes", "Bayes and off-path beliefs", "public H-vote update",
    "identity-indexed payoffs", "typed free-symbol closure", "PBE witness in every cell"
  )
  obligation <- function(id, step, selector = "", kind) {
    list(obligation_id = id, step_id = step, selector = selector,
         expected_kind = kind)
  }
  bundles <- list(
    list(obligation("C01.import.weak", "S01", kind = "formula"),
         obligation("C01.import.H0", "S02", kind = "formula"),
         obligation("C01.import.H1", "S03", kind = "formula"),
         obligation("C01.discount.weak", "S04", kind = "formula"),
         obligation("C01.discount.H0", "S05", kind = "formula"),
         obligation("C01.discount.H1", "S06", kind = "formula")),
    list(obligation("C02.weak.cutoff", "S08", kind = "weak_best_response")),
    list(obligation("C03.H.map", "S09", kind = "H_best_response")),
    list(obligation("C04.proposer.map", "S10", kind = "proposer_map")),
    list(obligation("C05.proposer.map", "S10", kind = "proposer_map"),
         obligation("C05.hedge.reduction", "S20", kind = "hedge"),
         obligation("C05.argmax", "S21", kind = "argmax_correspondence"),
         obligation("C05.failure.deviation", "S15", kind = "formula"),
         obligation("C05.failure.dominated", "S17", kind = "strict_sign")),
    list(obligation("C06.slack.fill", "S20", "slack_fill", "object"),
         obligation("C06.selected.regions", "S21", "regions", "list"),
         obligation("C06.selected.budgets", "S23", kind = "feasibility")),
    list(obligation("C07.exclusion.transform", "S20", "exclusion_y_zero", "object"),
         obligation("C07.selected.regions", "S21", "regions", "list"),
         obligation("C07.exclusion.budget", "S23", "base_budgets/E", "budget_certificate")),
    list(obligation("C08.failure.payoff", "S15", kind = "formula"),
         obligation("C08.exclusion.strict", "S17", kind = "strict_sign"),
         obligation("C08.screening.regions", "S21", "regions", "list"),
         obligation("C08.delay.maps", "S27", "per_region", "list")),
    list(obligation("C09.feasibility", "S23", kind = "feasibility")),
    list(obligation("C10.partition", "S22", kind = "partition")),
    list(obligation("C11.tie.regions", "S21", "regions", "list"),
         obligation("C11.tie.break", "S24", kind = "tie_break"),
         obligation("C11.mixture.simplex", "S26", kind = "identity_simplexes"),
         obligation("C11.mixture.maps", "S27", kind = "indexed_payoff_outcome_maps")),
    list(obligation("C12.identity.simplexes", "S26", kind = "identity_simplexes"),
         obligation("C12.identity.maps", "S27", kind = "indexed_payoff_outcome_maps")),
    list(obligation("C13.beliefs", "S25", kind = "belief_system"),
         obligation("C13.strategy.support", "S26", kind = "identity_simplexes")),
    list(obligation("C14.weak.vote", "S08", kind = "weak_best_response"),
         obligation("C14.H.vote", "S09", kind = "H_best_response"),
         obligation("C14.public.updates", "S25", kind = "belief_system")),
    list(obligation("C15.weak.identity.payoffs", "S27", "per_region", "list"),
         obligation("C15.identity.support", "S26", kind = "identity_simplexes")),
    list(obligation("C16.record.scope", "S28", kind = "record_scoped_free_symbol_closure")),
    list(obligation("C17.domain.partition", "S22", kind = "partition"),
         obligation("C17.PBE.witnesses", "S29", kind = "PBE_witnesses"))
  )
  lapply(seq_along(ids), function(index) list(
    claim_id = ids[[index]], theorem_kind = labels[[index]],
    obligations = bundles[[index]],
    human_residual_status = "HUMAN_REVIEW_REQUIRED"
  ))
}
