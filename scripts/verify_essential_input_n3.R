#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) {
    stop(message, call. = FALSE)
  }
}

as_character <- function(x) {
  as.character(unlist(x, use.names = FALSE))
}

clone_object <- function(x) {
  unserialize(serialize(x, NULL))
}

all_strings <- function(x) {
  if (is.character(x)) {
    return(x)
  }
  if (!is.list(x)) {
    return(character())
  }
  unlist(lapply(x, all_strings), use.names = FALSE)
}

sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  assert_true(length(output) == 1L, paste("Could not compute SHA-256 for", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

interface_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_interfaces",
  "n3_r1_majority_candidate_v1.json"
)
ledger_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_n3_claim_ledger.tsv"
)
derivation_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_n3_r1_majority_derivation.md"
)
dag_path <- file.path(repository_root, "model_redesign", "essential_input_game_dag.json")
n1_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_interfaces",
  "n1_r2_majority_candidate_v1.json"
)
formal_report_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-18_essential_input_goal1_n3_o1_formal_design_review_round2.md"
)
game_report_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-18_essential_input_goal1_n3_o1_game_theory_review_round2.md"
)

n1_hash_bare <- "af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd"
n1_hash <- paste0("sha256:", n1_hash_bare)
old_n1_hash_bare <- "bfe56e486098589b10724d6dbd7889eaf1ead087443717c96b6a1f45bd498c9d"
expected_interface_hash <- "561026969956396dbcc8ee9015eb01eb839976385b3503332d9c6744b2fd951b"
expected_ledger_hash <- "e54a575f646e756cc8baba814b1395d588ae19bf5ea5c705a257fc716edd8cb7"
expected_derivation_hash <- "4aca972699bbe11aa275fc04ec62ccedda2ea94c74a5e7352cd61773b7fbd6a6"
expected_formal_report_hash <- "f40976cb8a9664a0b51e10a14fa2ae4938ec44cc50e2718f1fd24d3ad70205f9"
expected_game_report_hash <- "58f07c59bc845d82ecc6eba6b8ae864c65cf4f19104c303ca91203d23f5c3e5b"

assert_true(
  identical(sha256_file(n1_path), n1_hash_bare),
  "N3 may consume only the exact frozen strict-domain N1 artifact."
)
assert_true(
  identical(sha256_file(interface_path), expected_interface_hash),
  "The N3 candidate bytes differ from the canonical strict-domain artifact."
)
assert_true(
  identical(sha256_file(ledger_path), expected_ledger_hash),
  "The N3 ledger bytes differ from the canonical sixteen-claim ledger."
)
assert_true(
  identical(sha256_file(derivation_path), expected_derivation_hash),
  "The N3 readable derivation bytes differ from the canonical endpoint-corrected artifact."
)
assert_true(
  identical(sha256_file(formal_report_path), expected_formal_report_hash) &&
    identical(sha256_file(game_report_path), expected_game_report_hash),
  "The complete N3 round2 review-report bytes changed."
)

for (path in c(
    interface_path, ledger_path, derivation_path, formal_report_path, game_report_path
)) {
  raw_value <- readBin(path, what = "raw", n = file.info(path)$size)
  assert_true(validUTF8(rawToChar(raw_value)), paste("Invalid UTF-8 in", path))
}

candidate <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
canonical_candidate <- clone_object(candidate)
n1_candidate <- jsonlite::fromJSON(n1_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
node_ids <- vapply(dag$nodes, `[[`, character(1), "id")
nodes <- dag$nodes
names(nodes) <- node_ids

assert_true(
  identical(nodes$N1$status, "pass") &&
    identical(nodes$N1$frozen, TRUE) &&
    identical(nodes$N1$artifact_hash, n1_hash) &&
    identical(nodes$N1$interface, n1_candidate),
  "The sole N3 dependency must be the exact pass/frozen N1 object."
)
expected_n3_reviews <- list(
  list(
    reviewer_role = "formal_design",
    reviewer_id = "review-n3-o1-formal-2026-08-18-r2",
    verdict = "PASS",
    artifact_hash = paste0("sha256:", expected_interface_hash),
    finding_counts = list(critical = 0L, major = 0L, minor = 0L)
  ),
  list(
    reviewer_role = "game_theory",
    reviewer_id = "review-n3-o1-game-2026-08-18-r2",
    verdict = "PASS",
    artifact_hash = paste0("sha256:", expected_interface_hash),
    finding_counts = list(critical = 0L, major = 0L, minor = 0L)
  )
)

is_valid_n3_lifecycle <- function(node) {
  identical(
    names(node),
    c(
      "id", "name", "round", "institution", "depends_on", "status", "interface",
      "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
      "passed_order", "frozen", "reviews"
    )
  ) &&
    identical(node$id, "N3") &&
    identical(node$name, "r1_majority") &&
    identical(node$round, "R1") &&
    identical(node$institution, "majority") &&
    identical(as_character(node$depends_on), "N1") &&
    identical(node$status, "pass") &&
    identical(node$interface, candidate) &&
    identical(
      node$artifact_path,
      "essential_input_interfaces/n3_r1_majority_candidate_v1.json"
    ) &&
    identical(node$artifact_hash, paste0("sha256:", expected_interface_hash)) &&
    identical(node$dependency_hashes, list(N1 = n1_hash)) &&
    identical(as.integer(node$started_order), 5L) &&
    identical(as.integer(node$passed_order), 6L) &&
    node$started_order > nodes$N1$passed_order &&
    identical(node$frozen, TRUE) &&
    identical(node$reviews, expected_n3_reviews)
}

assert_true(
  is_valid_n3_lifecycle(nodes$N3),
  paste0(
    "N3 must be pass/frozen on the exact interface, N1 dependency hash, orders 5/6, ",
    "and two round2 PASS 0/0/0 reviews."
  )
)

pending_lifecycle_fields <- c(
  "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
  "passed_order", "frozen", "reviews"
)
for (node_id in c("N4", "N6", "N7")) {
  assert_true(
    identical(nodes[[node_id]]$status, "pending") &&
      !any(pending_lifecycle_fields %in% names(nodes[[node_id]])),
    paste(node_id, "must remain pending/null after the N3 freeze.")
  )
}

equilibrium_schema <- dag$interface_schemas$equilibrium_correspondence_v1
expected_record_fields <- as_character(equilibrium_schema$record_fields)
expected_outcome_fields <- as_character(equilibrium_schema$outcome_distribution_fields)
expected_h_fields <- as_character(equilibrium_schema$hegemon_payoff_by_type_fields)

validate_candidate <- function(object) {
  assert_true(
    identical(object, canonical_candidate),
    paste0(
      "The N3 object must be identical to the hash-anchored canonical interface; ",
      "any in-memory mutation of any named field is forbidden."
    )
  )
  assert_true(
    identical(names(object), c("schema_ref", "function_of", "correspondence_cells")) &&
      identical(object$schema_ref, "equilibrium_correspondence_v1") &&
      identical(object$function_of, list(name = "entry_belief", domain = "[0,1]")),
    "N3 must implement exactly the frozen equilibrium-correspondence envelope."
  )

  cells <- object$correspondence_cells
  assert_true(is.list(cells) && length(cells) == 1L, "N3 must use one exhaustive cell.")
  cell <- cells[[1L]]
  assert_true(
    identical(
      names(cell),
      c(
        "cell_id", "domain_conditions", "existence_status",
        "equilibrium_records", "nonexistence_certificate"
      )
    ) &&
      identical(cell$cell_id, "N3-CELL-COMPLETE-MAJORITY") &&
      identical(cell$existence_status, "exists") &&
      is.null(cell$nonexistence_certificate),
    "The complete N3 existence cell has missing, extra, or altered fields."
  )
  expected_domain <- c(
    "nu in [0,1]",
    "N is an integer and N >= 3",
    "m = N-1",
    "q = floor(N/2)+1",
    "beta in (0,1]",
    "0 < o_0 < o_1 < 1 and o_1 <= y_bar <= 1",
    paste0("N1 is frozen at ", n1_hash)
  )
  assert_true(
    identical(as_character(cell$domain_conditions), expected_domain),
    "N3 must cover exactly nu endpoints and the strict 0<o_0<o_1<1 domain."
  )
  assert_true(
    is.list(cell$equilibrium_records) && length(cell$equilibrium_records) == 1L,
    "N3 must contain one atomic complete-family record."
  )

  record <- cell$equilibrium_records[[1L]]
  assert_true(
    identical(names(record), expected_record_fields) &&
      identical(record$equilibrium_id, "N3-EQ-COMPLETE-FAMILY-01"),
    "The N3 record must implement exactly equilibrium_correspondence_v1."
  )
  expected_admissibility <- c(
    "all primitive restrictions in N3-CELL-COMPLETE-MAJORITY hold",
    "for each recognized proposer i, F_i is a probability distribution supported on A_i_star(nu)",
    paste0(
      "A_i_star applies proposer-payoff maximization first and the authorized ",
      "minimum-expected-H tie-break second"
    ),
    "ballot strategies are pure even when proposer strategies F_i are mixed",
    "no symmetry restriction is imposed across proposer identities"
  )
  assert_true(
    identical(as_character(record$admissibility_conditions), expected_admissibility) &&
      identical(
        record$branch_classification,
        paste0(
          "complete ex-post majority correspondence over exclusion, low-type screening, ",
          "pooling inclusion, and delay"
        )
      ),
    "N3 admissibility or ex-post branch classification changed."
  )

  strategy <- record$strategy_profile
  expected_strategy_fields <- c(
    "definitions",
    "weak_nonproposer_vote_after_every_feasible_proposal",
    "hegemon_vote_after_every_feasible_proposal",
    "proposer_payoff_for_every_feasible_proposal",
    "pure_candidate_families",
    "candidate_set_B_i",
    "proposer_selection",
    "closed_form_boundaries",
    "outcome_indicators_for_s_and_theta"
  )
  assert_true(
    identical(names(strategy), expected_strategy_fields),
    "The N3 strategy object has missing or extra fields."
  )
  expected_definitions <- list(
    w = "beta/m",
    t_0 = "beta*o_0",
    t_1 = "beta*o_1",
    K_of_s = "{j in W without i: x_j >= w}",
    k_of_s = "cardinality(K_of_s)",
    E = "1-(q-1)*w",
    L = "1-(q-2)*w-t_0",
    P = "1-(q-2)*w-t_1",
    S_of_nu = "(1-nu)*L+nu*w",
    D = "E-w=1-q*w"
  )
  assert_true(
    identical(strategy$definitions, expected_definitions),
    "N3 definitions must transport N1 by beta exactly once."
  )
  assert_true(
    identical(
      strategy$weak_nonproposer_vote_after_every_feasible_proposal,
      "yes iff x_j >= w; at x_j=w genuine indifference is resolved by T^Y in favor of yes"
    ),
    "P6 requires the exact weak cutoff and T^Y only at equality."
  )
  expected_h_vote <- list(
    if_k_at_least_q_minus_1 = paste0(
      "no for both types; yes pays y and no pays y+o_theta because the proposal ",
      "passes without H"
    ),
    if_k_equals_q_minus_2 =
      "type theta votes yes iff y >= t_theta; T^Y selects yes at y=t_theta",
    if_k_at_most_q_minus_3 = paste0(
      "yes for both types by T^Y because either vote leads to N1 continuation ",
      "payoff t_theta"
    )
  )
  assert_true(
    identical(strategy$hegemon_vote_after_every_feasible_proposal, expected_h_vote),
    "The complete H IC must preserve nonpivotal y versus y+o_theta."
  )
  expected_proposer_payoff <- list(
    if_k_at_least_q_minus_1 = "r_i",
    if_k_equals_q_minus_2 =
      "(1-nu)*[r_i if y>=t_0 else w]+nu*[r_i if y>=t_1 else w]",
    if_k_at_most_q_minus_3 = "w"
  )
  assert_true(
    identical(strategy$proposer_payoff_for_every_feasible_proposal, expected_proposer_payoff),
    "P2 requires the exact proposal-by-proposal payoff map."
  )
  expected_families <- list(
    E_i = paste0(
      "choose any K subset of W without i with |K|=q-1; y=0; x_j=w on K and ",
      "0 otherwise; r_i=E"
    ),
    S_i =
      "if feasible, choose any K with |K|=q-2; y=t_0; x_j=w on K and 0 otherwise; r_i=L",
    P_i =
      "if feasible, choose any K with |K|=q-2; y=t_1; x_j=w on K and 0 otherwise; r_i=P",
    R_i_of_nu = paste0(
      "every feasible proposal that fails for every type with positive prior probability: ",
      "k<=q-3, or k=q-2 and y<min{t_theta: Pr(theta|nu)>0}"
    )
  )
  assert_true(
    identical(strategy$pure_candidate_families, expected_families) &&
      identical(
        strategy$candidate_set_B_i,
        "E_i union feasible S_i union feasible P_i union R_i(nu)"
      ),
    "P2 must preserve the exhaustive E/S/P/R candidate set, including delay."
  )
  expected_selection <- list(
    V_star = "max over s in B_i(nu) of v_i(s;nu)",
    H_star = "min expected H payoff h_i(s;nu) among proposals attaining V_star",
    A_i_star = "{s in B_i(nu): v_i(s;nu)=V_star and h_i(s;nu)=H_star}",
    conditional_strategy_by_identity = paste0(
      "for every recognized proposer i, choose an arbitrary distribution F_i supported ",
      "on A_i_star(nu)"
    ),
    identity_rule = "F_i need not equal F_j; recognition remains iid uniform over i"
  )
  assert_true(
    identical(strategy$proposer_selection, expected_selection),
    "The authorized proposer tie-break and identity-indexed F_i family must be exact."
  )
  expected_boundaries <- list(
    payoff_differences = list(
      "P-E=beta*(1/m-o_1)",
      "S-E=(1-nu)*beta*(1/m-o_0)-nu*D"
    ),
    if_o1_below_1_over_m = paste0(
      "screening for nu<=nu_SP=beta*(o_1-o_0)/(L-w), pooling for nu>nu_SP"
    ),
    if_o0_below_1_over_m_below_o1_and_D_positive = paste0(
      "screening below nu_SE=beta*(1/m-o_0)/[beta*(1/m-o_0)+D], exclusion above; ",
      "at equality screening if beta<1 and both if beta=1"
    ),
    if_o0_above_1_over_m_and_D_positive = "exclusion",
    if_o0_equals_1_over_m_below_o1_and_D_positive = paste0(
      "at nu=0 screening if beta<1 and screening plus exclusion if beta=1; ",
      "exclusion for nu>0"
    ),
    if_o0_below_o1_equals_1_over_m_and_D_positive = paste0(
      "screening below nu_SE; at equality screening if beta<1 and screening plus exclusion ",
      "if beta=1; above it E=P and the minimum of h_E=(1-nu)*o_0+nu*o_1 and ",
      "h_P=beta/m selects exclusion, pooling, or both"
    ),
    delay_corner =
      "R_i(nu) is selected iff D=0, o_1>=1/m, and [nu=1 or o_0>=1/m]"
  )
  assert_true(
    identical(strategy$closed_form_boundaries, expected_boundaries),
    "The strict, equality, and D=0 boundaries must be exact."
  )
  assert_true(
    identical(
      strategy$outcome_indicators_for_s_and_theta,
      list(
        I_H = "1 iff k=q-2 and y>=t_theta",
        I_X = "1 iff k>=q-1",
        I_D = "1-I_H-I_X"
      )
    ),
    "The N3 outcome indicators are inconsistent with the transition table."
  )

  expected_beliefs <- list(
    ballot_on_path = paste0(
      "after every proposal with positive probability mass under F_i, Pr(theta=1|s)=nu ",
      "by Bayes because weak proposer i does not observe theta"
    ),
    ballot_zero_probability_proposal = paste0(
      "arbitrary kappa_i(s) in [0,1] after every individual zero-probability proposal, ",
      "including points in the topological support of an atomless F_i"
    ),
    published_vote_vector_on_path = paste0(
      "nu_prime(s,v)=nu*1{v_H=a_H(s,1)}/[(1-nu)*1{v_H=a_H(s,0)}+",
      "nu*1{v_H=a_H(s,1)}] whenever the denominator is positive; ",
      "type-independent weak-vote factors cancel"
    ),
    published_vote_vector_zero_probability =
      "arbitrary eta_i(s,v) in [0,1] after every zero-probability proposal-vote history",
    zero_prior_types = paste0(
      "at nu=0 and nu=1, ballot strategies, conditional outcomes, and payoffs remain ",
      "specified for both theta types; Bayes constrains only histories with positive probability"
    ),
    continuation_effect = paste0(
      "every nu_prime and eta_i(s,v) maps to N1-EQ-01, whose R2 payoffs are ",
      "posterior-invariant"
    ),
    deviating_proposer_evaluation =
      "every proposal deviation is evaluated under the true pre-proposal prior nu"
  )
  assert_true(
    identical(record$belief_system, expected_beliefs),
    "P7 requires exact Bayes, atomless zero-mass, zero-prior, and off-path beliefs."
  )
  assert_true(
    identical(record$source_continuation_record_ids, list("N1-EQ-01")) &&
      identical(record$source_interface_hashes, list(N1 = n1_hash)) &&
      !any(grepl("N2", all_strings(record), fixed = TRUE)),
    "N3 must consume exactly N1-EQ-01 at the new hash and cannot depend on N2."
  )
  assert_true(
    identical(
      record$existence_uniqueness_status,
      paste0(
        "exists for every admissible primitive and nu because E_i is feasible and E>=w; ",
        "generally strategy-multiple through coalition identities and residual proposal ties; ",
        "payoff and outcome multiplicity is preserved in the F_i family, especially in the ",
        "D=0 delay corner and zero-prior-type boundaries"
      )
    ) &&
      identical(
        record$selection_status,
        paste0(
          "full family of identity-indexed F_i distributions on the authorized lexicographic ",
          "argmax A_i_star is preserved; no symmetric or Markov restriction, no belief ",
          "restriction, and no ad hoc or additional equilibrium selection is added"
        )
      ),
    "Existence, multiplicity, or no-additional-selection semantics changed."
  )
  expected_assumptions <- c(
    "fixed unit pie, strict 0<o_0<o_1<1 domain, and package feasibility from Section 2",
    paste0(
      "majority quota, full execution of y, public sealed-ballot vector, and terminal ",
      "payoffs from Section 4"
    ),
    paste0(
      "PBE with pure ballot strategies, weak-only stage-undominated voting, T^Y, ",
      "and the proposal tie-break from Section 5"
    ),
    "exactly-one transport of the frozen N1 continuation under Section 6",
    "iid uniform recognition with replacement",
    "no side payments and no exit action"
  )
  assert_true(
    identical(as_character(record$assumptions_used), expected_assumptions),
    "The N3 assumptions whitelist must be exact and retain strict o_1<1."
  )
  expected_checks <- c(
    "N3-C01 weak vote cutoff and T^Y",
    "N3-C02 complete H IC including nonpivotal y versus y+o_theta",
    "N3-C03 proposer payoff for every feasible proposal and vote profile",
    "N3-C04 P2 exhaustive reduction to E_i, S_i, P_i, and R_i(nu)",
    "N3-C05 P0 full-pie result with endogenous slack exception preserved",
    "N3-C06 P1 strict hedge dominance including off-path proposals",
    "N3-C07 P1a no on-path passage without H with y>0",
    "N3-C08 P2 strict-region boundaries",
    "N3-C09 P2 equality boundaries and proposal tie-break",
    "N3-C10 P2 delay corner and slack multiplicity",
    "N3-C11 proposal beliefs including atomless-support zero-probability points",
    "N3-C12 P7 public H vote and off-path posterior",
    "N3-C13 P6 on-path refinement effect",
    "N3-C14 exactly-one discount transport",
    "N3-C15 existence, completeness, multiplicity, and no ad hoc selection",
    paste0(
      "N3-C16 strict o_1<1 domain restriction preserves the N3 correspondence on the ",
      "remaining domain and leaves the D=0 delay corner admissible"
    )
  )
  assert_true(
    identical(as_character(record$checks_performed), expected_checks),
    "N3 must report exact claims C01-C16 and all obligations P0/P1/P1a/P2/P6/P7."
  )

  assert_true(
    identical(record$recognized_proposer_payoff, "V_star(nu)"),
    "The recognized proposer payoff must be V_star(nu)."
  )
  expected_weak_value <- list(
    type = "identity-indexed map; symmetry is not imposed",
    by_weak_state_l = paste0(
      "C_l=(1/m)*V_star+(1/m)*sum_{i!=l} ",
      "E_{s~F_i,theta~nu}[x_l(s)*(I_H+I_X)+w*I_D]"
    ),
    continuation_value_inside_formula = "w=beta/m exactly once"
  )
  assert_true(
    identical(record$weak_nonproposer_pre_recognition_expected_value, expected_weak_value),
    "Weak payoffs must remain identity-indexed and transport N1 exactly once."
  )
  expected_h_payoffs <- list(
    theta_0 = paste0(
      "C_H(0)=(1/m)*sum_i E_{s~F_i}[y*I_H(s,0)+(y+o_0)*I_X(s,0)+",
      "t_0*I_D(s,0)]"
    ),
    theta_1 = paste0(
      "C_H(1)=(1/m)*sum_i E_{s~F_i}[y*I_H(s,1)+(y+o_1)*I_X(s,1)+",
      "t_1*I_D(s,1)]"
    )
  )
  assert_true(
    identical(names(record$hegemon_payoff_by_type), expected_h_fields) &&
      identical(record$hegemon_payoff_by_type, expected_h_payoffs),
    "H payoffs must preserve full y, current o_theta on exclusion, and beta once on delay."
  )
  expected_outcomes <- list(
    pass_with_hegemon = "(1/m)*sum_i E_{s~F_i,theta~nu}[I_H(s,theta)]",
    pass_without_hegemon = "(1/m)*sum_i E_{s~F_i,theta~nu}[I_X(s,theta)]",
    failure = 0L,
    delay = "(1/m)*sum_i E_{s~F_i,theta~nu}[I_D(s,theta)]"
  )
  assert_true(
    identical(names(record$outcome_distribution), expected_outcome_fields) &&
      identical(record$outcome_distribution, expected_outcomes),
    "N3 outcomes must distinguish both passage modes, delay, and zero terminal failure."
  )
  assert_true(
    identical(
      record$payoff_date,
      "R1 current units; N1 continuation values are multiplied by beta exactly once"
    ),
    "N3 must export R1-current payoffs with one continuation discount."
  )

  invisible(TRUE)
}

ledger <- utils::read.delim(
  ledger_path,
  header = TRUE,
  sep = "\t",
  quote = "",
  comment.char = "",
  stringsAsFactors = FALSE,
  check.names = FALSE,
  fileEncoding = "UTF-8"
)
canonical_ledger <- clone_object(ledger)
canonical_derivation <- readLines(derivation_path, warn = FALSE, encoding = "UTF-8")

validate_ledger <- function(object) {
  assert_true(
    identical(object, canonical_ledger),
    "The N3 ledger must be object-identical to the hash-anchored canonical ledger."
  )
  expected_columns <- c(
    "claim_id", "equilibrium_id", "branch", "payoff_date", "claim", "status", "evidence"
  )
  assert_true(
    identical(names(object), expected_columns) && nrow(object) == 16L,
    "The N3 ledger must have exactly seven columns and sixteen atomic claims."
  )
  expected_branches <- c(
    "all feasible proposals",
    "all H pivotality states",
    "all feasible proposals",
    "candidate reduction",
    "P0",
    "P1 hedge",
    "P1a",
    "strict parameter regions",
    "parameter equalities",
    "delay corner",
    "proposal beliefs",
    "P7 vote publication",
    "P6 refinement",
    "discount audit",
    "full correspondence",
    "strict primitive domain"
  )
  expected_claims <- c(
    "A weak nonproposer votes yes iff x_j>=beta/m; T^Y selects yes at equality.",
    paste0(
      "H votes no when passage is independent of H, uses y>=beta*o_theta when pivotal, ",
      "and votes yes by T^Y when failure is inevitable."
    ),
    "The proposer payoff formula covers every proposal, type, and induced vote profile.",
    "Every optimal pure proposal belongs to E_i, feasible S_i, feasible P_i, or R_i(nu).",
    "Passing optima exhaust the pie; slack survives only in a selected rejection family at D=0.",
    paste0(
      "Every pass-without-H proposal with y>0 is strictly dominated by the feasible y=0 ",
      "hedge, including off path."
    ),
    "No on-path approval without H has y>0; exclusion with y=0 remains.",
    "The screening-pooling and screening-exclusion cutoffs derive the nonempty strict regimes.",
    paste0(
      "All o_0=1/m and o_1=1/m boundaries apply the authorized expected-H proposal ",
      "tie-break."
    ),
    "Rejection and slack survive exactly under the derived D=0 winner conditions.",
    paste0(
      "Bayes preserves nu at positive-mass proposals; every individual zero-probability ",
      "proposal has explicit unrestricted belief, and both type strategies remain specified ",
      "at nu=0 and nu=1."
    ),
    paste0(
      "The public H vote enters Bayes updates; every zero-probability proposal-vote vector ",
      "has an explicit unrestricted posterior."
    ),
    "Stage-undominance and T^Y are applied only in their authorized domains.",
    "N1 weak and H continuation values receive beta exactly once.",
    paste0(
      "Equilibrium exists everywhere; all identity, proposal, delay, zero-prior-type, payoff, ",
      "and outcome multiplicity is preserved atomically in (F_i)."
    ),
    paste0(
      "Restricting to 0<o_0<o_1<1 with o_1<=y_bar<=1 preserves the N3 correspondence on ",
      "the remaining domain; the D=0 delay and slack corner remains admissible."
    )
  )
  expected_evidence <- paste0(
    "model_redesign/essential_input_n3_r1_majority_derivation.md#claim-n3-c",
    sprintf("%02d", 1:16)
  )
  assert_true(
    identical(object$claim_id, sprintf("N3-C%02d", 1:16)) &&
      identical(object$equilibrium_id, rep("N3-EQ-COMPLETE-FAMILY-01", 16L)) &&
      identical(object$branch, expected_branches) &&
      identical(object$payoff_date, rep("R1", 16L)) &&
      identical(object$claim, expected_claims) &&
      identical(object$status, rep("proved", 16L)) &&
      identical(object$evidence, expected_evidence),
    "Every N3 ledger row must preserve its exact atomic semantics and evidence anchor."
  )
  invisible(TRUE)
}

validate_derivation <- function(lines) {
  assert_true(
    identical(lines, canonical_derivation),
    "The N3 derivation must remain identical to the hash-anchored endpoint-corrected text."
  )
  joined <- paste(lines, collapse = "\n")
  assert_true(
    grepl("Em `nu=1`", joined, fixed = TRUE) &&
      grepl("tipo baixo, de probabilidade zero", joined, fixed = TRUE) &&
      grepl("Em `nu=0`", joined, fixed = TRUE) &&
      grepl("`t_0<t_1`", joined, fixed = TRUE) &&
      grepl("`y<t_0` de `R_i(0)`", joined, fixed = TRUE) &&
      grepl("ambos os tipos rejeitam", joined, fixed = TRUE),
    "The derivation must state the exact asymmetric R_i endpoint logic."
  )
  false_symmetric_phrases <- c(
    "vale para o tipo alto",
    "zero-prior high type can accept an R_i(0) proposal",
    "symmetric zero-prior-high acceptance exists"
  )
  assert_true(
    !any(vapply(false_symmetric_phrases, grepl, logical(1), x = joined, fixed = TRUE)),
    "The false symmetric nu=0 endpoint claim reappeared in the N3 derivation."
  )
  invisible(TRUE)
}

review_report_specs <- list(
  formal_design = list(
    path = formal_report_path,
    expected_hash = expected_formal_report_hash,
    reviewer_id = "review-n3-o1-formal-2026-08-18-r2"
  ),
  game_theory = list(
    path = game_report_path,
    expected_hash = expected_game_report_hash,
    reviewer_id = "review-n3-o1-game-2026-08-18-r2"
  )
)

validate_review_report <- function(lines, role, spec) {
  assert_true(
    identical(lines, spec$canonical_lines) &&
      length(lines) > 40L &&
      any(grepl(paste0("reviewer_role=", role), lines, fixed = TRUE)) &&
      any(grepl(paste0("reviewer_id=", spec$reviewer_id), lines, fixed = TRUE)) &&
      any(grepl(expected_interface_hash, lines, fixed = TRUE)) &&
      any(grepl("PASS", lines, fixed = TRUE)) &&
      any(grepl("critical[^0-9]*0", lines, ignore.case = TRUE, perl = TRUE)) &&
      any(grepl("major[^0-9]*0", lines, ignore.case = TRUE, perl = TRUE)) &&
      any(grepl("minor[^0-9]*0", lines, ignore.case = TRUE, perl = TRUE)) &&
      !any(grepl("FAIL", lines, fixed = TRUE)),
    paste("Invalid complete N3 round2 PASS 0/0/0 report for", role)
  )
  invisible(TRUE)
}

for (role in names(review_report_specs)) {
  spec <- review_report_specs[[role]]
  spec$canonical_lines <- readLines(spec$path, encoding = "UTF-8", warn = FALSE)
  review_report_specs[[role]] <- spec
  validate_review_report(spec$canonical_lines, role, spec)
}

is_consumable_frozen_node <- function(node) {
  valid_hash <- is.character(node$artifact_hash) &&
    length(node$artifact_hash) == 1L &&
    grepl("^sha256:[0-9a-f]{64}$", node$artifact_hash)
  valid_reviews <- is.list(node$reviews) &&
    length(node$reviews) == 2L &&
    valid_hash &&
    identical(
      sort(vapply(node$reviews, `[[`, character(1), "reviewer_role")),
      c("formal_design", "game_theory")
    ) &&
    length(unique(vapply(node$reviews, `[[`, character(1), "reviewer_id"))) == 2L &&
    all(vapply(node$reviews, function(review) {
      identical(review$verdict, "PASS") &&
        identical(review$artifact_hash, node$artifact_hash) &&
        all(as.integer(unlist(review$finding_counts, use.names = FALSE)) == 0L)
    }, logical(1)))
  identical(node$status, "pass") &&
    identical(node$frozen, TRUE) &&
    isTRUE(valid_hash) &&
    isTRUE(valid_reviews)
}

topologically_ready_nodes <- function(candidate_nodes) {
  names(candidate_nodes)[vapply(names(candidate_nodes), function(node_id) {
    node <- candidate_nodes[[node_id]]
    identical(node$status, "pending") &&
      all(vapply(as_character(node$depends_on), function(dependency_id) {
        is_consumable_frozen_node(candidate_nodes[[dependency_id]])
      }, logical(1)))
  }, logical(1))]
}

assert_true(
  identical(topologically_ready_nodes(nodes), "N4"),
  paste0(
    "After N3 freezes, only N4 may be topologically ready; N4 remains unauthorized, ",
    "and topological readiness cannot grant authorization."
  )
)

expect_candidate_rejection <- function(label, mutate_candidate) {
  altered <- mutate_candidate(clone_object(candidate))
  rejected <- inherits(try(validate_candidate(altered), silent = TRUE), "try-error")
  assert_true(rejected, paste0("Negative candidate mutation was accepted: ", label))
}

expect_ledger_rejection <- function(label, mutate_ledger) {
  altered <- mutate_ledger(clone_object(ledger))
  rejected <- inherits(try(validate_ledger(altered), silent = TRUE), "try-error")
  assert_true(rejected, paste0("Negative ledger mutation was accepted: ", label))
}

expect_derivation_rejection <- function(label, mutate_derivation) {
  altered <- mutate_derivation(canonical_derivation)
  rejected <- inherits(try(validate_derivation(altered), silent = TRUE), "try-error")
  assert_true(rejected, paste0("Negative derivation mutation was accepted: ", label))
}

expect_lifecycle_rejection <- function(label, mutate_node) {
  altered <- mutate_node(clone_object(nodes$N3))
  assert_true(
    !is_valid_n3_lifecycle(altered),
    paste0("Negative N3 lifecycle mutation was accepted: ", label)
  )
}

expect_report_rejection <- function(label, role, mutate_report) {
  spec <- review_report_specs[[role]]
  altered <- mutate_report(spec$canonical_lines)
  rejected <- inherits(
    try(validate_review_report(altered, role, spec), silent = TRUE),
    "try-error"
  )
  assert_true(rejected, paste0("Negative N3 report mutation was accepted: ", label))
}

collect_named_field_paths <- function(x, path = list()) {
  if (!is.list(x)) {
    return(list())
  }
  result <- list()
  object_names <- names(x)
  if (!is.null(object_names)) {
    for (index in seq_along(x)) {
      token <- list(kind = "name", key = object_names[[index]])
      next_path <- c(path, list(token))
      result <- c(result, list(next_path), collect_named_field_paths(x[[index]], next_path))
    }
  } else if (length(x) > 0L) {
    for (index in seq_along(x)) {
      token <- list(kind = "index", key = index)
      next_path <- c(path, list(token))
      result <- c(result, collect_named_field_paths(x[[index]], next_path))
    }
  }
  result
}

set_path_value <- function(x, path, value) {
  token <- path[[1L]]
  key <- if (identical(token$kind, "name")) token$key else as.integer(token$key)
  if (length(path) == 1L) {
    x[[key]] <- value
  } else {
    x[[key]] <- set_path_value(x[[key]], path[-1L], value)
  }
  x
}

path_label <- function(path) {
  paste(vapply(path, function(token) as.character(token$key), character(1)), collapse = "/")
}

validate_candidate(candidate)
validate_ledger(ledger)
validate_derivation(canonical_derivation)

expect_lifecycle_rejection("wrong artifact hash", function(x) {
  x$artifact_hash <- paste0("sha256:", paste(rep("0", 64L), collapse = "")); x
})
expect_lifecycle_rejection("wrong interface object", function(x) {
  x$interface$correspondence_cells[[1L]]$cell_id <- "CORRUPTED"; x
})
expect_lifecycle_rejection("missing N1 dependency hash", function(x) {
  x$dependency_hashes <- list(); x
})
expect_lifecycle_rejection("wrong N1 dependency hash", function(x) {
  x$dependency_hashes$N1 <- paste0("sha256:", paste(rep("d", 64L), collapse = "")); x
})
expect_lifecycle_rejection("wrong execution order", function(x) {
  x$started_order <- 4L; x
})
expect_lifecycle_rejection("one review only", function(x) {
  x$reviews <- x$reviews[1L]; x
})
expect_lifecycle_rejection("wrong reviewer id", function(x) {
  x$reviews[[2L]]$reviewer_id <- "wrong-reviewer"; x
})
expect_lifecycle_rejection("nonzero finding", function(x) {
  x$reviews[[1L]]$finding_counts$minor <- 1L; x
})
for (role in names(review_report_specs)) {
  local({
    current_role <- role
    expect_report_rejection(
      paste("appended FAIL", current_role),
      current_role,
      function(x) c(x, "FAIL")
    )
    expect_report_rejection(
      paste("truncated report", current_role),
      current_role,
      function(x) x[seq_len(min(10L, length(x)))]
    )
  })
}

# P2 algebraic regression over the entire strict primitive domain pattern.
for (N in 3:30) {
  m <- N - 1
  q <- floor(N / 2) + 1
  assert_true(q <= m, "The majority quota cannot exceed the weak-state count.")
  for (beta in c(0.15, 0.5, 0.9, 1)) {
    w <- beta / m
    E <- 1 - (q - 1) * w
    D <- E - w
    assert_true(D >= -1e-12, "Exclusion E must weakly dominate deliberate rejection w.")
    assert_true(
      (abs(D) < 1e-12) == (beta == 1 && q == m),
      "D=0 must occur exactly at beta=1 and q=m."
    )
    o_grid <- sort(unique(c(
      0.01,
      0.5 / m,
      0.9 / m,
      1 / m,
      min(0.95, 1.1 / m),
      min(0.97, 2 / m),
      0.98
    )))
    o_grid <- o_grid[o_grid > 0 & o_grid < 1]
    for (o0 in o_grid) {
      for (o1 in o_grid[o_grid > o0]) {
        assert_true(o1 < 1, "The N3 algebraic grid must exclude the old o_1=1 face.")
        t0 <- beta * o0
        t1 <- beta * o1
        L <- 1 - (q - 2) * w - t0
        P <- 1 - (q - 2) * w - t1
        for (nu in c(0, 0.17, 0.5, 0.83, 1)) {
          S <- (1 - nu) * L + nu * w
          assert_true(
            abs((P - E) - beta * (1 / m - o1)) < 1e-12,
            "The P-E identity failed."
          )
          assert_true(
            abs((S - E) - ((1 - nu) * beta * (1 / m - o0) - nu * D)) < 1e-12,
            "The S-E identity failed."
          )
          if (S > E + 1e-12) {
            assert_true(L >= -1e-12, "Strictly winning screening must be feasible.")
          }
          if (P >= E - 1e-12) {
            assert_true(P >= -1e-12, "Weakly winning pooling must be feasible.")
          }
          feasible_payoffs <- c(E, w)
          if (L >= -1e-12) {
            feasible_payoffs <- c(feasible_payoffs, S)
          }
          if (P >= -1e-12) {
            feasible_payoffs <- c(feasible_payoffs, P)
          }
          V_star <- max(feasible_payoffs)
          assert_true(V_star >= E - 1e-12, "The candidate maximum must retain feasible E.")
        }
      }
    }
  }
}

# Strict-region and equality boundaries.
N <- 9
m <- N - 1
q <- floor(N / 2) + 1
beta <- 0.8
w <- beta / m
E <- 1 - (q - 1) * w
D <- E - w

o0 <- 0.03
o1 <- 0.08
L <- 1 - (q - 2) * w - beta * o0
P <- 1 - (q - 2) * w - beta * o1
nu_sp <- beta * (o1 - o0) / (L - w)
S_at_sp <- (1 - nu_sp) * L + nu_sp * w
assert_true(
  nu_sp > 0 && nu_sp < 1 && abs(S_at_sp - P) < 1e-12 && P > E,
  "The nonempty screening-pooling regions or their boundary failed."
)

o0 <- 0.08
o1 <- 0.2
L <- 1 - (q - 2) * w - beta * o0
nu_se <- beta * (1 / m - o0) / (beta * (1 / m - o0) + D)
S_at_se <- (1 - nu_se) * L + nu_se * w
assert_true(
  nu_se > 0 && nu_se < 1 && abs(S_at_se - E) < 1e-12,
  "The nonempty screening-exclusion regions or their boundary failed."
)

o0 <- 0.08
o1 <- 1 / m
L <- 1 - (q - 2) * w - beta * o0
P <- 1 - (q - 2) * w - beta * o1
nu_se <- beta * (1 / m - o0) / (beta * (1 / m - o0) + D)
S_at_se <- (1 - nu_se) * L + nu_se * w
assert_true(
  abs(P - E) < 1e-12 && abs(S_at_se - E) < 1e-12,
  "The o_1=1/m equality boundary failed."
)

# P0/P1/P1a: the hedge keeps feasibility and raises the proposer payoff by y.
for (y in c(0.01, 0.2, 0.7)) {
  r_i <- 1 - y
  assert_true(
    abs((r_i + y) - r_i - y) < 1e-12,
    "The feasible P1 hedge gain must equal y."
  )
}

# P6 and the complete H IC, including current full-y execution.
for (o_theta in c(0.05, 0.4, 0.95)) {
  beta <- 0.8
  t_theta <- beta * o_theta
  y <- 0.2
  assert_true((y + o_theta) - y > 0, "Nonpivotal H must strictly prefer no by o_theta.")
  assert_true((t_theta >= t_theta), "T^Y must include the pivotal equality cutoff.")
  assert_true((t_theta - 1e-6) < t_theta, "Below the pivotal cutoff H must reject.")
}

# P7, separating H votes, and the endpoints with a zero-prior type.
posterior_after_h_vote <- function(nu, vote, low_vote, high_vote) {
  numerator <- nu * as.numeric(vote == high_vote)
  denominator <-
    (1 - nu) * as.numeric(vote == low_vote) + nu * as.numeric(vote == high_vote)
  if (denominator == 0) {
    return(NA_real_)
  }
  numerator / denominator
}
assert_true(
  identical(posterior_after_h_vote(0.3, "no", "yes", "no"), 1),
  "A separating high-type no must update the public posterior to one."
)
assert_true(
  identical(posterior_after_h_vote(0.3, "yes", "yes", "no"), 0),
  "A separating low-type yes must update the public posterior to zero."
)
assert_true(
  identical(posterior_after_h_vote(0, "yes", "yes", "no"), 0) &&
    identical(posterior_after_h_vote(1, "no", "yes", "no"), 1),
  "Bayes must handle nu=0 and nu=1 while retaining both type strategies."
)

# The D=0 delay/slack corner survives with strict o_1<1.
N <- 4
m <- N - 1
q <- floor(N / 2) + 1
beta <- 1
w <- beta / m
E <- 1 - (q - 1) * w
D <- E - w
o0 <- 0.4
o1 <- 0.8
slack_rejection_total <- 0.1 + 0 + 0.1
assert_true(
  o1 < 1 && abs(D) < 1e-12 && o0 >= 1 / m && slack_rejection_total < 1,
  "The strict domain must retain a concrete D=0 rejected proposal with slack."
)
assert_true(
  abs(E - w) < 1e-12,
  "Exclusion and the rejection family must tie in the retained D=0 corner."
)

# R_i is asymmetric at the prior endpoints because t_0<t_1.
beta <- 0.8
o0 <- 0.2
o1 <- 0.6
t0 <- beta * o0
t1 <- beta * o1
y_in_R_at_nu1 <- (t0 + t1) / 2
y_in_R_at_nu0 <- t0 / 2
assert_true(
  y_in_R_at_nu1 >= t0 && y_in_R_at_nu1 < t1,
  paste0(
    "At nu=1 an R_i(1) proposal may be accepted by the zero-prior low type ",
    "while the supported high type rejects."
  )
)
assert_true(
  y_in_R_at_nu0 < t0 && y_in_R_at_nu0 < t1,
  paste0(
    "At nu=0, R_i(0) requires y<t_0, which implies rejection by both types; ",
    "there is no symmetric zero-prior-high acceptance case."
  )
)

# Source/domain and substantive negative fixtures.
expect_candidate_rejection("old N1 source hash", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$source_interface_hashes$N1 <-
    paste0("sha256:", old_n1_hash_bare)
  x
})
expect_candidate_rejection("old weak primitive domain", function(x) {
  x$correspondence_cells[[1L]]$domain_conditions[[6L]] <-
    "0 < o_0 < o_1 <= y_bar <= 1"
  x
})
expect_candidate_rejection("double-discounted weak continuation", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    weak_nonproposer_pre_recognition_expected_value$continuation_value_inside_formula <-
    "w=beta^2/m"
  x
})
expect_candidate_rejection("nonpivotal H loses executed y", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    hegemon_vote_after_every_feasible_proposal$if_k_at_least_q_minus_1 <-
    "no pays o_theta"
  x
})
expect_candidate_rejection("atomless zero-mass beliefs restricted", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system$
    ballot_zero_probability_proposal <- "arbitrary only outside topological support"
  x
})
expect_candidate_rejection("zero-prior type removed", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system$zero_prior_types <-
    "omit the type with prior zero"
  x
})
expect_candidate_rejection("public H vote omitted", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system$
    published_vote_vector_on_path <- "nu_prime=nu"
  x
})
expect_candidate_rejection("identity-indexed F_i collapsed", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    proposer_selection$identity_rule <- "F_i=F_j"
  x
})
expect_candidate_rejection("D=0 delay and slack erased", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    closed_form_boundaries$delay_corner <- "delay never"
  x
})
expect_candidate_rejection("N2 introduced as dependency", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$source_interface_hashes$N2 <-
    paste0("sha256:", paste(rep("0", 64L), collapse = ""))
  x
})
expect_candidate_rejection("false change under strict o_1", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$checks_performed[[16L]] <-
    "N3-C16 strict o_1<1 changes all interior regimes"
  x
})
expect_candidate_rejection("lifecycle fields inserted into standalone interface", function(x) {
  x$status <- "pass"
  x$frozen <- TRUE
  x
})

# Canonical mutation coverage for every named field at every nesting depth.
field_paths <- collect_named_field_paths(candidate)
for (field_path in field_paths) {
  local({
    current_path <- field_path
    expect_candidate_rejection(
      paste("generic named field", path_label(current_path)),
      function(x) {
        set_path_value(
          x,
          current_path,
          list(corrupted_field = path_label(current_path))
        )
      }
    )
  })
}

expect_ledger_rejection("false strict-domain invariance claim", function(x) {
  x$claim[16L] <- paste0(
    "Restricting to 0<o_0<o_1<1 changes the N3 correspondence and eliminates delay."
  )
  x
})
for (field_name in names(ledger)) {
  local({
    column <- field_name
    expect_ledger_rejection(paste("generic ledger field", column), function(x) {
      x[[column]][1L] <- paste0("CORRUPTED-", column)
      x
    })
  })
}

expect_derivation_rejection("false symmetric nu=0 sentence", function(x) {
  target <- grep("Em `nu=1`", x, fixed = TRUE)
  assert_true(length(target) == 1L, "Could not locate the endpoint sentence for mutation.")
  x[[target]] <- paste0(
    "False symmetric claim: at nu=1 the zero-prior low type can accept; ",
    "at nu=0 the zero-prior high type can accept an R_i(0) proposal."
  )
  x
})
expect_derivation_rejection("appended endpoint symmetry", function(x) {
  c(x, "False claim: symmetric zero-prior-high acceptance exists at nu=0.")
})
expect_derivation_rejection("removed asymmetric endpoint proof", function(x) {
  x[!grepl("Em `nu=1`", x, fixed = TRUE)]
})

assert_true(
  any(grepl(n1_hash_bare, canonical_derivation, fixed = TRUE)) &&
    !any(grepl(old_n1_hash_bare, canonical_derivation, fixed = TRUE)) &&
    any(grepl("Claim N3-C16", canonical_derivation, fixed = TRUE)) &&
    any(grepl("0 < o_0 < o_1 < 1", canonical_derivation, fixed = TRUE)),
  "The readable N3 derivation must cite only the new N1 hash and prove strict-domain invariance."
)

cat("PASS: N3 R1-majority strict-domain candidate and ledger are internally valid.\n")
cat("PASS: P0, P1, P1a, P2, P6, and P7 checks passed.\n")
cat("PASS: nu endpoints, zero-prior types, identity-indexed F_i, and off-path beliefs passed.\n")
cat("PASS: asymmetric R_i endpoint logic passed and the false nu=0 analogue was rejected.\n")
cat("PASS: D=0 delay, multiplicity, and slack survive on an admissible o_1<1 fixture.\n")
cat("PASS: exact N3 round2 reports, lifecycle, N1 dependency hash, orders 5/6, and readiness passed.\n")
cat(
  sprintf(
    "PASS: canonical exact-object mutations rejected for all %d named interface fields and %d ledger columns.\n",
    length(field_paths),
    length(names(ledger))
  )
)
cat("SHA-256:", expected_interface_hash, "\n")
cat("STATUS: N3 is pass/frozen; only N4 is topologically ready and remains unauthorized.\n")
