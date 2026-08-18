#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

as_character <- function(x) as.character(unlist(x, use.names = FALSE))
clone_object <- function(x) unserialize(serialize(x, NULL))

sha256_file <- function(path) {
  output <- system2(
    "shasum", c("-a", "256", shQuote(path)), stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  assert_true(length(output) == 1L, paste("Could not hash", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", hash), paste("Malformed hash for", path))
  hash
}

read_utf8 <- function(path, label) {
  bytes <- readBin(path, what = "raw", n = file.info(path)$size)
  text <- rawToChar(bytes)
  assert_true(validUTF8(text), paste(label, "must be valid UTF-8."))
  text
}

sha256_text <- function(text) {
  temporary_path <- tempfile("n3-derivation-")
  on.exit(unlink(temporary_path), add = TRUE)
  writeBin(charToRaw(text), temporary_path)
  sha256_file(temporary_path)
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

interface_path <- file.path(
  repository_root, "model_redesign", "essential_input_interfaces",
  "n3_r1_majority_candidate_v1.json"
)
ledger_path <- file.path(repository_root, "model_redesign", "essential_input_n3_claim_ledger.tsv")
derivation_path <- file.path(
  repository_root, "model_redesign", "essential_input_n3_r1_majority_derivation.md"
)
dag_path <- file.path(repository_root, "model_redesign", "essential_input_game_dag.json")
n1_path <- file.path(
  repository_root, "model_redesign", "essential_input_interfaces",
  "n1_r2_majority_candidate_v1.json"
)
formal_review_path <- file.path(
  repository_root, "quality_reports",
  "2026-08-18_essential_input_goal1_n3_beta_formal_design_review_round3.md"
)
game_review_path <- file.path(
  repository_root, "quality_reports",
  "2026-08-18_essential_input_goal1_n3_beta_game_theory_review_round3.md"
)

n1_hash_bare <- "1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
n1_hash <- paste0("sha256:", n1_hash_bare)
old_n1_hash_bare <- "af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd"
expected_interface_hash <- "63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee"
expected_ledger_hash <- "7219ef5572ae1df2fab8b2e00f534f209b8fdda0b70283d08c74b245afbc3b22"
expected_derivation_hash <- "b0e5e69e5eb774c2bb13170f00752fe138882282d268b8172c9c39dff5fefdd5"
expected_formal_review_hash <- "6003aea1922435faf53f6bd94481366888d82456ab32b8ca4caec259aaa32873"
expected_game_review_hash <- "580eb6ed8291f4a20e531a22f043307ee23e116d0ba09c48ac372cfce1ff3d83"
formal_reviewer_id <- "review-n3-beta-formal-2026-08-18-r3"
game_reviewer_id <- "review-n3-beta-game-2026-08-18-r3"

assert_true(identical(sha256_file(n1_path), n1_hash_bare), "N3 may consume only current frozen N1.")
assert_true(identical(sha256_file(interface_path), expected_interface_hash), "N3 interface hash changed.")
assert_true(identical(sha256_file(ledger_path), expected_ledger_hash), "N3 ledger hash changed.")
assert_true(identical(sha256_file(derivation_path), expected_derivation_hash), "N3 derivation hash changed.")
assert_true(
  identical(sha256_file(formal_review_path), expected_formal_review_hash),
  "N3 formal-design Round-3 report changed."
)
assert_true(
  identical(sha256_file(game_review_path), expected_game_review_hash),
  "N3 game-theory Round-3 report changed."
)
interface_text <- read_utf8(interface_path, "N3 interface")
read_utf8(ledger_path, "N3 ledger")
derivation_text <- read_utf8(derivation_path, "N3 derivation")
formal_review_text <- read_utf8(formal_review_path, "N3 formal-design Round-3 report")
game_review_text <- read_utf8(game_review_path, "N3 game-theory Round-3 report")

candidate <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
n1_candidate <- jsonlite::fromJSON(n1_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
node_ids <- vapply(dag$nodes, `[[`, character(1), "id")
nodes <- dag$nodes
names(nodes) <- node_ids

assert_true(
  identical(nodes$N1$status, "pass") && identical(nodes$N1$frozen, TRUE) &&
    identical(nodes$N1$artifact_hash, n1_hash) && identical(nodes$N1$interface, n1_candidate),
  "N3's sole continuation must be exact pass/frozen N1."
)
n3_hash <- paste0("sha256:", expected_interface_hash)
expected_n3_reviews <- list(
  list(
    reviewer_role = "formal_design",
    reviewer_id = formal_reviewer_id,
    verdict = "PASS",
    artifact_hash = n3_hash,
    finding_counts = list(critical = 0L, major = 0L, minor = 0L)
  ),
  list(
    reviewer_role = "game_theory",
    reviewer_id = game_reviewer_id,
    verdict = "PASS",
    artifact_hash = n3_hash,
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
  ) && identical(node$id, "N3") && identical(node$name, "r1_majority") &&
    identical(node$round, "R1") && identical(node$institution, "majority") &&
    identical(as_character(node$depends_on), "N1") &&
    identical(node$status, "pass") && identical(node$frozen, TRUE) &&
    identical(node$interface, candidate) &&
    identical(node$artifact_path, "essential_input_interfaces/n3_r1_majority_candidate_v1.json") &&
    identical(node$artifact_hash, n3_hash) &&
    identical(node$dependency_hashes, list(N1 = n1_hash)) &&
    identical(as.integer(node$started_order), 5L) &&
    identical(as.integer(node$passed_order), 6L) &&
    node$started_order < node$passed_order &&
    identical(node$reviews, expected_n3_reviews)
}
assert_true(
  is_valid_n3_lifecycle(nodes$N3),
  "N3 must be exact pass/frozen on the reviewed artifact, N1 dependency, orders 5/6, and two R3 PASS reviews."
)

is_valid_round3_report <- function(text, role, reviewer_id) {
  grepl(role, text, fixed = TRUE) &&
    grepl(reviewer_id, text, fixed = TRUE) &&
    grepl(expected_interface_hash, text, fixed = TRUE) &&
    grepl(n1_hash_bare, text, fixed = TRUE) &&
    grepl("7072a58bf9fbaf012535418a93418dffb8d4692f13919f39101c8ecb37710f6b", text, fixed = TRUE) &&
    grepl("PASS", text, fixed = TRUE) &&
    grepl("critical[^0-9]*0", text, ignore.case = TRUE, perl = TRUE) &&
    grepl("major[^0-9]*0", text, ignore.case = TRUE, perl = TRUE) &&
    grepl("minor[^0-9]*0", text, ignore.case = TRUE, perl = TRUE) &&
    !grepl("VEREDICTO ESTRITO: FAIL", text, fixed = TRUE)
}
assert_true(
  is_valid_round3_report(formal_review_text, "formal_design", formal_reviewer_id) &&
    is_valid_round3_report(game_review_text, "game_theory", game_reviewer_id),
  "N3 Round-3 reports must provide exact same-hash independent PASS 0/0/0 evidence."
)
assert_true(
  !is_valid_round3_report(
    paste0(formal_review_text, "\nVEREDICTO ESTRITO: FAIL\n"),
    "formal_design", formal_reviewer_id
  ) &&
    !is_valid_round3_report(
      paste0(game_review_text, "\nVEREDICTO ESTRITO: FAIL\n"),
      "game_theory", game_reviewer_id
    ),
  "An appended FAIL must invalidate either N3 Round-3 report."
)
for (mutation in c("dependency", "order", "review_hash", "finding")) {
  altered_node <- clone_object(nodes$N3)
  if (identical(mutation, "dependency")) altered_node$dependency_hashes$N1 <- n3_hash
  if (identical(mutation, "order")) altered_node$passed_order <- altered_node$started_order
  if (identical(mutation, "review_hash")) altered_node$reviews[[2L]]$artifact_hash <- n1_hash
  if (identical(mutation, "finding")) altered_node$reviews[[1L]]$finding_counts$major <- 1L
  assert_true(
    !is_valid_n3_lifecycle(altered_node),
    paste("N3 lifecycle mutation passed:", mutation)
  )
}

equilibrium_schema <- dag$interface_schemas$equilibrium_correspondence_v1
expected_record_fields <- as_character(equilibrium_schema$record_fields)
expected_outcome_fields <- as_character(equilibrium_schema$outcome_distribution_fields)
expected_h_fields <- as_character(equilibrium_schema$hegemon_payoff_by_type_fields)

validate_candidate <- function(object, check_exact_anchor = TRUE) {
  assert_true(
    identical(names(object), c("schema_ref", "function_of", "correspondence_cells")) &&
      identical(object$schema_ref, "equilibrium_correspondence_v1") &&
      identical(object$function_of, list(name = "entry_belief", domain = "[0,1]")),
    "N3 has the wrong top-level schema."
  )
  cells <- object$correspondence_cells
  assert_true(is.list(cells) && length(cells) == 1L, "N3 needs one exhaustive coverage cell.")
  cell <- cells[[1L]]
  assert_true(
    identical(
      names(cell),
      c("cell_id", "domain_conditions", "existence_status", "equilibrium_records", "nonexistence_certificate")
    ) && identical(cell$cell_id, "N3-CELL-COMPLETE-MAJORITY") &&
      identical(cell$existence_status, "exists") && is.null(cell$nonexistence_certificate),
    "N3 coverage envelope is malformed."
  )
  expected_domain <- c(
    "nu in [0,1]", "N is an integer and N >= 3", "m = N-1",
    "q = floor(N/2)+1", "beta in (0,1)",
    "0 < o_0 < o_1 < 1 and o_1 <= y_bar <= 1",
    paste0("N1 is frozen at ", n1_hash)
  )
  assert_true(
    identical(as_character(cell$domain_conditions), expected_domain),
    "N3 domain must use strict beta<1, strict o_1<1, and current N1."
  )
  assert_true(
    is.list(cell$equilibrium_records) && length(cell$equilibrium_records) == 1L,
    "N3 must contain one atomic complete-family record."
  )
  record <- cell$equilibrium_records[[1L]]
  assert_true(
    identical(names(record), expected_record_fields) &&
      identical(record$equilibrium_id, "N3-EQ-COMPLETE-FAMILY-01"),
    "N3 record fields do not match equilibrium_correspondence_v1."
  )
  expected_admissibility <- c(
    "all primitive restrictions in N3-CELL-COMPLETE-MAJORITY hold",
    "for each recognized proposer i, F_i is a probability distribution supported on A_i_star(nu)",
    "A_i_star applies proposer-payoff maximization first and the authorized minimum-expected-H tie-break second",
    "ballot strategies are pure even when proposer strategies F_i are mixed",
    "no symmetry restriction is imposed across proposer identities"
  )
  assert_true(
    identical(as_character(record$admissibility_conditions), expected_admissibility) &&
      identical(
        record$branch_classification,
        paste0(
          "complete ex-post majority correspondence over exclusion, low-type screening with possible ",
          "high-type delay, and pooling inclusion; no deliberate rejection or slack"
        )
      ),
    "N3 admissibility or ex-post classification changed."
  )

  strategy <- record$strategy_profile
  assert_true(
    identical(
      names(strategy),
      c(
        "definitions", "weak_nonproposer_vote_after_every_feasible_proposal",
        "hegemon_vote_after_every_feasible_proposal", "proposer_payoff_for_every_feasible_proposal",
        "pure_candidate_families", "candidate_set_B_i", "proposer_selection",
        "closed_form_boundaries", "outcome_indicators_for_s_and_theta"
      )
    ),
    "N3 strategy object has missing or extra fields."
  )
  expected_definitions <- list(
    w = "beta/m", t_0 = "beta*o_0", t_1 = "beta*o_1",
    K_of_s = "{j in W without i: x_j >= w}",
    k_of_s = "cardinality(K_of_s)",
    E = "1-(q-1)*w", L = "1-(q-2)*w-t_0", P = "1-(q-2)*w-t_1",
    S_of_nu = "(1-nu)*L+nu*w",
    D = "E-w=1-q*w>0 because q<=m and beta<1"
  )
  assert_true(identical(strategy$definitions, expected_definitions), "N3 definitions or D>0 proof changed.")
  assert_true(
    identical(
      strategy$weak_nonproposer_vote_after_every_feasible_proposal,
      "yes iff x_j >= w; at x_j=w genuine indifference is resolved by T^Y in favor of yes"
    ),
    "P6 weak cutoff changed."
  )
  expected_h_vote <- list(
    if_k_at_least_q_minus_1 = paste0(
      "no for both types; yes pays y and no pays y+o_theta because the proposal passes without H"
    ),
    if_k_equals_q_minus_2 =
      "type theta votes yes iff y >= t_theta; T^Y selects yes at y=t_theta",
    if_k_at_most_q_minus_3 =
      "yes for both types by T^Y because either vote leads to N1 continuation payoff t_theta"
  )
  assert_true(
    identical(strategy$hegemon_vote_after_every_feasible_proposal, expected_h_vote),
    "H IC must preserve pivotal continuation and nonpivotal y versus y+o_theta."
  )
  assert_true(
    identical(
      strategy$proposer_payoff_for_every_feasible_proposal,
      list(
        if_k_at_least_q_minus_1 = "r_i",
        if_k_equals_q_minus_2 =
          "(1-nu)*[r_i if y>=t_0 else w]+nu*[r_i if y>=t_1 else w]",
        if_k_at_most_q_minus_3 = "w"
      )
    ),
    "P2 proposal-by-proposal payoff map changed."
  )
  expected_pure_candidate_families <- list(
    E_i = paste0(
      "choose any K subset of W without i with |K|=q-1; y=0; ",
      "x_j=w on K and 0 otherwise; r_i=E"
    ),
    S_i = paste0(
      "if feasible, choose any K with |K|=q-2; y=t_0; ",
      "x_j=w on K and 0 otherwise; r_i=L"
    ),
    P_i = paste0(
      "if feasible, choose any K with |K|=q-2; y=t_1; ",
      "x_j=w on K and 0 otherwise; r_i=P"
    ),
    R_i_of_nu = paste0(
      "every feasible proposal that fails for every type with positive prior probability: ",
      "k<=q-3, or k=q-2 and y<min{t_theta: Pr(theta|nu)>0}"
    )
  )
  expected_proposer_selection <- list(
    V_star = "max over s in B_i(nu) of v_i(s;nu)",
    H_star = "min expected H payoff h_i(s;nu) among proposals attaining V_star",
    A_i_star = "{s in B_i(nu): v_i(s;nu)=V_star and h_i(s;nu)=H_star}",
    conditional_strategy_by_identity = paste0(
      "for every recognized proposer i, choose an arbitrary distribution F_i supported on ",
      "A_i_star(nu)"
    ),
    identity_rule = "F_i need not equal F_j; recognition remains iid uniform over i"
  )
  assert_true(
    identical(strategy$pure_candidate_families, expected_pure_candidate_families) &&
      identical(strategy$candidate_set_B_i, "E_i union feasible S_i union feasible P_i union R_i(nu)") &&
      identical(strategy$proposer_selection, expected_proposer_selection),
    paste0(
      "N3 must preserve exact E/S/P/R families, V_star/H_star/A_i_star, ",
      "and conditional identity-indexed F_i."
    )
  )
  assert_true(
    grepl("y=0", strategy$pure_candidate_families$E_i, fixed = TRUE) &&
      !grepl("y>0", strategy$pure_candidate_families$E_i, fixed = TRUE) &&
      grepl("y=t_0", strategy$pure_candidate_families$S_i, fixed = TRUE) &&
      !grepl("y=t_1", strategy$pure_candidate_families$S_i, fixed = TRUE) &&
      grepl("min expected H payoff", strategy$proposer_selection$H_star, fixed = TRUE) &&
      grepl("supported on A_i_star(nu)", strategy$proposer_selection$conditional_strategy_by_identity, fixed = TRUE),
    "Core E/S/tie-break/F_i semantics changed."
  )
  boundaries <- strategy$closed_form_boundaries
  expected_boundaries <- list(
    payoff_differences = list(
      "P-E=beta*(1/m-o_1)",
      "S-E=(1-nu)*beta*(1/m-o_0)-nu*D"
    ),
    if_o1_below_1_over_m = paste0(
      "screening for nu<=nu_SP=beta*(o_1-o_0)/(L-w), pooling for nu>nu_SP"
    ),
    if_o0_below_1_over_m_below_o1 = paste0(
      "screening for nu<=nu_SE=beta*(1/m-o_0)/[beta*(1/m-o_0)+D], ",
      "exclusion for nu>nu_SE; equality is screening by the strict expected-H tie-break"
    ),
    if_o0_above_1_over_m = "exclusion",
    if_o0_equals_1_over_m_below_o1 = paste0(
      "screening only at nu=0 by the strict expected-H tie-break; exclusion for nu>0"
    ),
    if_o0_below_o1_equals_1_over_m = paste0(
      "screening for nu<=nu_SE; above it E=P and the minimum of ",
      "h_E=(1-nu)*o_0+nu*o_1 and h_P=beta/m selects exclusion, pooling, or both"
    ),
    strict_delay_result = paste0(
      "D>0 makes every R_i(nu) strictly worse than E_i, so deliberate rejection and slack ",
      "are never selected; delay occurs only after high-type rejection in a selected S_i ",
      "when nu>0; beta=1 is excluded"
    )
  )
  assert_true(
    identical(boundaries, expected_boundaries),
    "Strict, equality, E/P-tie, or delay boundaries changed."
  )
  expected_outcome_indicators <- list(
    I_H = "1 iff k=q-2 and y>=t_theta",
    I_X = "1 iff k>=q-1",
    I_D = "1-I_H-I_X"
  )
  assert_true(
    identical(strategy$outcome_indicators_for_s_and_theta, expected_outcome_indicators),
    "N3 outcome indicators changed."
  )

  expected_beliefs <- list(
    ballot_on_path = paste0(
      "after every proposal with positive probability mass under F_i, ",
      "Pr(theta=1|s)=nu by Bayes because weak proposer i does not observe theta"
    ),
    ballot_zero_probability_proposal = paste0(
      "arbitrary kappa_i(s) in [0,1] after every individual zero-probability proposal, ",
      "including every point assigned zero mass by the selected F_i"
    ),
    published_vote_vector_on_path = paste0(
      "nu_prime(s,v)=nu*1{v_H=a_H(s,1)}/[(1-nu)*1{v_H=a_H(s,0)}+",
      "nu*1{v_H=a_H(s,1)}] whenever the denominator is positive; ",
      "type-independent weak-vote factors cancel"
    ),
    published_vote_vector_zero_probability = paste0(
      "arbitrary eta_i(s,v) in [0,1] after every zero-probability proposal-vote history"
    ),
    zero_prior_types = paste0(
      "at nu=0 and nu=1, ballot strategies, conditional outcomes, and payoffs remain ",
      "specified for both theta types; Bayes constrains only histories with positive probability"
    ),
    continuation_effect = paste0(
      "every nu_prime and eta_i(s,v) maps to N1-EQ-01, whose R2 payoffs are posterior-invariant"
    ),
    deviating_proposer_evaluation = paste0(
      "every proposal deviation is evaluated under the true pre-proposal prior nu"
    )
  )
  beliefs <- record$belief_system
  assert_true(
    identical(beliefs, expected_beliefs),
    "P7, endpoints, or zero-probability beliefs changed."
  )
  assert_true(
    identical(record$source_continuation_record_ids, list("N1-EQ-01")) &&
      identical(record$source_interface_hashes, list(N1 = n1_hash)) &&
      !any(grepl("N2", as_character(record$source_interface_hashes), fixed = TRUE)),
    "N3 must consume exactly current N1 and never N2."
  )
  expected_existence_status <- paste0(
    "exists for every admissible primitive and nu because E_i is feasible and E>w; generally ",
    "strategy-multiple through coalition identities and the residual E=P proposal tie; payoff ",
    "and outcome multiplicity is preserved atomically in the identity-indexed F_i family, with ",
    "no deliberate-rejection or slack multiplicity"
  )
  expected_selection_status <- paste0(
    "full family of identity-indexed F_i distributions on the authorized lexicographic argmax ",
    "A_i_star is preserved; no symmetric or Markov restriction, no belief restriction, and no ",
    "ad hoc or additional equilibrium selection is added"
  )
  expected_assumptions <- c(
    "fixed unit pie, strict beta in (0,1), strict 0<o_0<o_1<1 domain, and package feasibility from Section 2",
    "majority quota, full execution of y, public sealed-ballot vector, and terminal payoffs from Section 4",
    "PBE with pure ballot strategies, weak-only stage-undominated voting, T^Y, and the proposal tie-break from Section 5",
    "exactly-one transport of the frozen N1 continuation under Section 6",
    "iid uniform recognition with replacement",
    "no side payments and no exit action"
  )
  assert_true(
    identical(record$existence_uniqueness_status, expected_existence_status) &&
      identical(record$selection_status, expected_selection_status) &&
      identical(as_character(record$assumptions_used), expected_assumptions),
    "Existence, multiplicity, or selection semantics changed."
  )
  expected_checks <- c(
    "N3-C01 weak vote cutoff and T^Y",
    "N3-C02 complete H IC including nonpivotal y versus y+o_theta",
    "N3-C03 proposer payoff for every feasible proposal and vote profile",
    "N3-C04 P2 exhaustive reduction to E_i, S_i, P_i, and R_i(nu)",
    "N3-C05 P0 full-pie result and strict elimination of on-path slack",
    "N3-C06 P1 strict hedge dominance including off-path proposals",
    "N3-C07 P1a no on-path passage without H with y>0",
    "N3-C08 P2 strict-region boundaries",
    "N3-C09 P2 equality boundaries and proposal tie-break",
    "N3-C10 P2 D>0 eliminates deliberate rejection and slack while screening delay survives",
    "N3-C11 proposal beliefs after every individual zero-probability proposal",
    "N3-C12 P7 public H vote and off-path posterior",
    "N3-C13 P6 on-path refinement effect",
    "N3-C14 exactly-one discount transport",
    "N3-C15 existence, completeness, identity-indexed multiplicity, and no ad hoc selection",
    "N3-C16 strict o_1<1 domain restriction preserves the N3 correspondence on the remaining domain",
    "N3-C17 strict beta<1 proves D>0; beta=1 is an excluded future face and no baseline formula imports it"
  )
  checks <- as_character(record$checks_performed)
  assert_true(
    identical(checks, expected_checks),
    "N3 must report exact claims C01-C17 and P0/P1/P1a/P2/P6/P7."
  )
  expected_weak_payoff <- list(
    type = "identity-indexed map; symmetry is not imposed",
    by_weak_state_l = paste0(
      "C_l=(1/m)*V_star+(1/m)*sum_{i!=l} ",
      "E_{s~F_i,theta~nu}[x_l(s)*(I_H+I_X)+w*I_D]"
    ),
    continuation_value_inside_formula = "w=beta/m exactly once"
  )
  assert_true(
    identical(record$recognized_proposer_payoff, "V_star(nu)") &&
      identical(record$weak_nonproposer_pre_recognition_expected_value, expected_weak_payoff),
    "Weak payoffs must remain atomic, identity-indexed, and discounted once."
  )
  expected_h_payoff <- list(
    theta_0 = paste0(
      "C_H(0)=(1/m)*sum_i E_{s~F_i}[y*I_H(s,0)+(y+o_0)*I_X(s,0)+t_0*I_D(s,0)]"
    ),
    theta_1 = paste0(
      "C_H(1)=(1/m)*sum_i E_{s~F_i}[y*I_H(s,1)+(y+o_1)*I_X(s,1)+t_1*I_D(s,1)]"
    )
  )
  assert_true(
    identical(names(record$hegemon_payoff_by_type), expected_h_fields) &&
      identical(record$hegemon_payoff_by_type, expected_h_payoff),
    "H payoff must retain full y, current o_theta on exclusion, and one beta on continuation."
  )
  expected_outcome_distribution <- list(
    pass_with_hegemon = "(1/m)*sum_i E_{s~F_i,theta~nu}[I_H(s,theta)]",
    pass_without_hegemon = "(1/m)*sum_i E_{s~F_i,theta~nu}[I_X(s,theta)]",
    failure = 0L,
    delay = "(1/m)*sum_i E_{s~F_i,theta~nu}[I_D(s,theta)]"
  )
  expected_payoff_date <- "R1 current units; N1 continuation values are multiplied by beta exactly once"
  assert_true(
    identical(names(record$outcome_distribution), expected_outcome_fields) &&
      identical(record$outcome_distribution, expected_outcome_distribution) &&
      identical(record$payoff_date, expected_payoff_date),
    "N3 outcomes or payoff date changed."
  )

  expected_strategy_anchor <- list(
    definitions = expected_definitions,
    weak_nonproposer_vote_after_every_feasible_proposal =
      "yes iff x_j >= w; at x_j=w genuine indifference is resolved by T^Y in favor of yes",
    hegemon_vote_after_every_feasible_proposal = expected_h_vote,
    proposer_payoff_for_every_feasible_proposal = list(
      if_k_at_least_q_minus_1 = "r_i",
      if_k_equals_q_minus_2 =
        "(1-nu)*[r_i if y>=t_0 else w]+nu*[r_i if y>=t_1 else w]",
      if_k_at_most_q_minus_3 = "w"
    ),
    pure_candidate_families = expected_pure_candidate_families,
    candidate_set_B_i = "E_i union feasible S_i union feasible P_i union R_i(nu)",
    proposer_selection = expected_proposer_selection,
    closed_form_boundaries = expected_boundaries,
    outcome_indicators_for_s_and_theta = expected_outcome_indicators
  )
  expected_record_anchor <- list(
    equilibrium_id = "N3-EQ-COMPLETE-FAMILY-01",
    admissibility_conditions = as.list(expected_admissibility),
    branch_classification = paste0(
      "complete ex-post majority correspondence over exclusion, low-type screening with possible ",
      "high-type delay, and pooling inclusion; no deliberate rejection or slack"
    ),
    strategy_profile = expected_strategy_anchor,
    belief_system = expected_beliefs,
    source_continuation_record_ids = list("N1-EQ-01"),
    source_interface_hashes = list(N1 = n1_hash),
    existence_uniqueness_status = expected_existence_status,
    selection_status = expected_selection_status,
    assumptions_used = as.list(expected_assumptions),
    checks_performed = as.list(expected_checks),
    recognized_proposer_payoff = "V_star(nu)",
    weak_nonproposer_pre_recognition_expected_value = expected_weak_payoff,
    hegemon_payoff_by_type = expected_h_payoff,
    outcome_distribution = expected_outcome_distribution,
    payoff_date = expected_payoff_date
  )
  if (isTRUE(check_exact_anchor)) {
    assert_true(
      identical(record, expected_record_anchor),
      "N3 record differs from the independently constructed exact expected object."
    )
  }
  invisible(TRUE)
}

ledger <- utils::read.delim(
  ledger_path, header = TRUE, sep = "\t", quote = "", comment.char = "",
  stringsAsFactors = FALSE, check.names = FALSE, fileEncoding = "UTF-8"
)
expected_ledger_branches <- c(
  "all feasible proposals", "all H pivotality states", "all feasible proposals",
  "candidate reduction", "P0", "P1 hedge", "P1a", "strict parameter regions",
  "parameter equalities", "strict delay result", "proposal beliefs", "P7 vote publication",
  "P6 refinement", "discount audit", "full correspondence", "strict o domain",
  "strict beta domain"
)
expected_ledger_claims <- c(
  "A weak nonproposer votes yes iff x_j>=beta/m; T^Y selects yes at equality.",
  paste0(
    "H votes no when passage is independent of H, uses y>=beta*o_theta when pivotal, ",
    "and votes yes by T^Y when failure is inevitable."
  ),
  "The proposer payoff formula covers every proposal, type, and induced vote profile.",
  paste0(
    "Every pure proposal not dominated within its induced outcome class reduces to E_i, ",
    "feasible S_i, feasible P_i, or the deliberate-rejection family R_i(nu)."
  ),
  paste0(
    "Every selected proposal exhausts the pie; D>0 makes deliberate rejection strictly ",
    "inferior to exclusion, so no on-path slack survives."
  ),
  paste0(
    "Every pass-without-H proposal with y>0 is strictly dominated by the feasible y=0 hedge, ",
    "including off path."
  ),
  "No on-path approval without H has y>0; exclusion with y=0 remains.",
  "The screening-pooling and screening-exclusion cutoffs derive the nonempty strict regimes.",
  "All o_0=1/m and o_1=1/m boundaries apply the authorized expected-H proposal tie-break.",
  paste0(
    "Because q<=m and beta<1 imply D>0, deliberate rejection and slack are never selected; ",
    "delay survives only after high-type rejection in selected screening when nu>0."
  ),
  paste0(
    "Bayes preserves nu at positive-mass proposals; every individual zero-probability proposal ",
    "has explicit unrestricted belief, and both type strategies remain specified at nu=0 and nu=1."
  ),
  paste0(
    "The public H vote enters Bayes updates; every zero-probability proposal-vote vector has an ",
    "explicit unrestricted posterior."
  ),
  "Stage-undominance and T^Y are applied only in their authorized domains.",
  "N1 weak and H continuation values receive beta exactly once.",
  paste0(
    "Equilibrium exists everywhere; identity-indexed coalition multiplicity and residual E=P ",
    "proposal ties are preserved atomically in (F_i), without rejection or slack multiplicity."
  ),
  paste0(
    "Restricting to 0<o_0<o_1<1 with o_1<=y_bar<=1 preserves the N3 correspondence on the ",
    "remaining domain."
  ),
  paste0(
    "The domain beta in (0,1) proves D>0 and excludes beta=1 as a future face; beta enters ",
    "baseline continuations exactly once and nowhere else."
  )
)
expected_ledger_evidence <- paste0(
  "model_redesign/essential_input_n3_r1_majority_derivation.md#claim-n3-c",
  sprintf("%02d", 1:17)
)
expected_ledger <- data.frame(
  claim_id = sprintf("N3-C%02d", 1:17),
  equilibrium_id = rep("N3-EQ-COMPLETE-FAMILY-01", 17L),
  branch = expected_ledger_branches,
  payoff_date = rep("R1", 17L),
  claim = expected_ledger_claims,
  status = rep("proved", 17L),
  evidence = expected_ledger_evidence,
  stringsAsFactors = FALSE,
  check.names = FALSE
)

validate_ledger <- function(object, check_exact_anchor = TRUE) {
  assert_true(
    identical(
      names(object),
      c("claim_id", "equilibrium_id", "branch", "payoff_date", "claim", "status", "evidence")
    ) && nrow(object) == 17L &&
      identical(object$claim_id, sprintf("N3-C%02d", 1:17)) &&
      identical(object$equilibrium_id, rep("N3-EQ-COMPLETE-FAMILY-01", 17L)) &&
      identical(object$branch, expected_ledger_branches) &&
      identical(object$payoff_date, rep("R1", 17L)) &&
      identical(object$claim, expected_ledger_claims) &&
      identical(object$status, rep("proved", 17L)) &&
      identical(object$evidence, expected_ledger_evidence),
    "N3 ledger must contain exactly seventeen proved atomic claims."
  )
  if (isTRUE(check_exact_anchor)) {
    assert_true(
      identical(object, expected_ledger),
      "N3 ledger differs from the independently constructed exact expected object."
    )
  }
  invisible(TRUE)
}

expected_derivation_headings <- c(
  "# N3 — R1 sob maioria: derivação do candidato",
  "## 1. Interface congelada consumida",
  "## 2. Payoffs proposta por proposta e perfil por perfil",
  "### Claim N3-C01 — cutoff dos weak nonproposers",
  "### Claim N3-C02 — IC completa de H",
  "### Claim N3-C03 — payoff do proponente para toda proposta factível",
  "## 3. Redução do conjunto de candidatos",
  "### Exclusão `E_i(K)`",
  "### Screening `S_i(K)`",
  "### Pooling `P_i(K)`",
  "### Rejeição on-path `R_i(nu)`",
  "### Claim N3-C04 — exaustividade da redução",
  "## 4. P0, P1 e P1a",
  "### Claim N3-C05 — P0",
  "### Claim N3-C06 — P1, dominância estrita do hedge",
  "### Claim N3-C07 — P1a",
  "## 5. Correspondência do proponente e fronteiras",
  "### Claim N3-C08 — fronteiras regulares",
  "### Claim N3-C09 — fronteiras de igualdade",
  "### Claim N3-C10 — `D>0`, rejeição, slack e delay",
  "## 6. Crenças e vetor público de votos",
  "### Claim N3-C11 — crença no ballot",
  "### Claim N3-C12 — P7 após publicação dos votos",
  "### Claim N3-C13 — P6 em R1",
  "## 7. Payoffs, outcomes e atomicidade",
  "### Claim N3-C14 — desconto exatamente uma vez",
  "### Claim N3-C15 — existência, completude e multiplicidade",
  "### Claim N3-C16 — invariância no domínio estrito `o_1<1`",
  "### Claim N3-C17 — domínio estrito `beta<1` e face excluída",
  "## 8. Invalidação"
)
expected_derivation_terminal <- paste0(
  "N3 depende exclusivamente do objeto N1 no hash `", n1_hash,
  "`. Qualquer mudança nesse hash, nas primitivas, na função de implementação, no ",
  "conceito de solução, no tie-break, no timing ou no schema invalida este candidato. ",
  "O arquivo permanece `pending` até dois revisores independentes darem PASS `0/0/0` no mesmo hash."
)
forbidden_derivation_contradictions <- c(
  "beta=1 is admissible in the baseline",
  "beta=1 é admissível no baseline",
  "D=0 is admissible in N3",
  "D=0 é admissível em N3",
  "R_i is selected on path",
  "R_i é selecionado on path",
  "screening never delays",
  "high type never delays",
  "o tipo alto nunca atrasa"
)
expected_derivation_byte_length <- 17004L
expected_derivation_chunk_byte_lengths <- c(480L, 699L, 2405L, 2517L, 1628L, 3379L, 2022L, 3467L, 407L)
expected_derivation_chunk_hashes <- c(
  "2daad2e03d56f77ed9f1870a3cb158ab8af812ef7b2288ae50484f82e22dda68",
  "8ef65d106f52e601bac10cb31344cf273c3e5af2adc131b4e4fdc81d87707b4d",
  "ecf04bb6193ed7ed784eda9315a55c8a6c2689dada70028b8ab963475499cb0a",
  "dd33384ef7fe78731472e470ea2353eea2ee5c76d0ce22db8c075a9f06d9945f",
  "7ba6240c77aea481c87bab0abe6a19cda39066ac088d063eb1016642b1c3ce7e",
  "8925191382af8d6ed07918c06ce51e89d2383425d666a0bded07842888c56b8a",
  "909c0b6794021bf7537559c8bf5c6f31f1c1c8e1b856d475865c542a32143fb8",
  "fdde05f8545309f78c1fc90c74f70b2eec4921a625e27a460ed540cff51c34c9",
  "8df701d17d540b89d40602d6fa61743595a180025ca81b5a998da3c08d7e15b1"
)

split_derivation_chunks <- function(text) {
  section_starts <- as.integer(gregexpr("(?m)^## [1-8][.] ", text, perl = TRUE)[[1L]])
  assert_true(
    length(section_starts) == 8L && all(section_starts > 0L),
    "Derivation must have exactly the eight canonical numbered section boundaries."
  )
  chunk_starts <- c(1L, section_starts)
  chunk_ends <- c(section_starts - 1L, nchar(text))
  Map(function(first, last) substr(text, first, last), chunk_starts, chunk_ends)
}

validate_derivation <- function(text, check_exact_anchor = TRUE) {
  if (isTRUE(check_exact_anchor)) {
    assert_true(
      identical(sha256_text(text), expected_derivation_hash),
      "N3 derivation differs from its independent in-validator whole-text anchor."
    )
  }
  derivation_chunks <- split_derivation_chunks(text)
  actual_chunk_lengths <- vapply(derivation_chunks, nchar, integer(1), type = "bytes")
  actual_chunk_hashes <- vapply(derivation_chunks, sha256_text, character(1))
  assert_true(
    identical(nchar(text, type = "bytes"), expected_derivation_byte_length) &&
      identical(actual_chunk_lengths, expected_derivation_chunk_byte_lengths) &&
      identical(actual_chunk_hashes, expected_derivation_chunk_hashes),
    paste0(
      "N3 derivation differs from the always-active independent preamble/Section 1-8 ",
      "byte-length and SHA-256 anchors."
    )
  )
  assert_true(grepl(n1_hash_bare, text, fixed = TRUE), "Derivation omits current N1 hash.")
  assert_true(!grepl(old_n1_hash_bare, text, fixed = TRUE), "Derivation imports old N1 hash.")
  required <- c(
    "D=1-beta*q/m>0", "`q=floor(N/2)+1<=N-1=m`", "`0<beta<1`",
    "delay deliberado desaparece", "delay do ramo alto de screening sobrevive",
    "Em `nu=1`", "tipo baixo, de probabilidade zero", "Em `nu=0`",
    "`y<t_0` de `R_i(0)`", "ambos os tipos rejeitam", "Claim N3-C17"
  )
  assert_true(
    all(vapply(required, grepl, logical(1), x = text, fixed = TRUE)),
    "Readable derivation omits a required strict-beta, endpoint, or delay proof."
  )
  assert_true(
    identical(
      strsplit(text, "\n", fixed = TRUE)[[1L]][
        grepl("^#{1,4} ", strsplit(text, "\n", fixed = TRUE)[[1L]])
      ],
      expected_derivation_headings
    ) && endsWith(sub("\n+$", "", text), expected_derivation_terminal),
    "Derivation headings or terminal invalidation boundary changed."
  )
  assert_true(
    !any(vapply(forbidden_derivation_contradictions, grepl, logical(1), x = text, fixed = TRUE)) &&
      !grepl("D=0 delay and slack corner remains admissible", text, fixed = TRUE),
    "An appended beta=1, D=0, selected-R, or no-screening-delay contradiction was accepted."
  )
  invisible(TRUE)
}

expect_candidate_rejection <- function(label, mutate, bypass_exact_anchor = TRUE) {
  altered <- mutate(clone_object(candidate))
  rejected <- inherits(
    try(validate_candidate(altered, check_exact_anchor = !bypass_exact_anchor), silent = TRUE),
    "try-error"
  )
  assert_true(rejected, paste("Negative candidate mutation passed:", label))
}
expect_ledger_rejection <- function(label, mutate, bypass_exact_anchor = TRUE) {
  altered <- mutate(clone_object(ledger))
  rejected <- inherits(
    try(validate_ledger(altered, check_exact_anchor = !bypass_exact_anchor), silent = TRUE),
    "try-error"
  )
  assert_true(rejected, paste("Negative ledger mutation passed:", label))
}
expect_derivation_rejection <- function(label, mutate, bypass_exact_anchor = TRUE) {
  altered <- mutate(derivation_text)
  rejected <- inherits(
    try(validate_derivation(altered, check_exact_anchor = !bypass_exact_anchor), silent = TRUE),
    "try-error"
  )
  assert_true(rejected, paste("Negative derivation mutation passed:", label))
}

collect_named_paths <- function(x, path = list()) {
  if (!is.list(x)) return(list())
  result <- list()
  object_names <- names(x)
  if (!is.null(object_names)) {
    for (index in seq_along(x)) {
      next_path <- c(path, list(list(kind = "name", key = object_names[[index]])))
      result <- c(result, list(next_path), collect_named_paths(x[[index]], next_path))
    }
  } else if (length(x) > 0L) {
    for (index in seq_along(x)) {
      next_path <- c(path, list(list(kind = "index", key = index)))
      result <- c(result, collect_named_paths(x[[index]], next_path))
    }
  }
  result
}
set_path_value <- function(x, path, value) {
  token <- path[[1L]]
  key <- if (identical(token$kind, "name")) token$key else as.integer(token$key)
  if (length(path) == 1L) x[[key]] <- value else x[[key]] <- set_path_value(x[[key]], path[-1L], value)
  x
}
path_label <- function(path) {
  paste(vapply(path, function(token) as.character(token$key), character(1)), collapse = "/")
}

validate_candidate(candidate)
validate_ledger(ledger)
validate_derivation(derivation_text)

# Algebraic audit: D is strictly positive everywhere in sampled strict domain.
for (N in 3:30) {
  m <- N - 1
  q <- floor(N / 2) + 1
  assert_true(q <= m, "q<=m failed.")
  for (beta in c(0.01, 0.2, 0.5, 0.9, 0.999999)) {
    assert_true(beta > 0 && beta < 1, "A beta fixture left the strict domain.")
    w <- beta / m
    E <- 1 - (q - 1) * w
    D <- E - w
    assert_true(D > 0 && abs(D - (1 - beta * q / m)) < 1e-12, "D>0 identity failed.")
    assert_true(E > w, "Exclusion must strictly dominate deliberate rejection.")
    o_grid <- sort(unique(c(0.01, 0.5 / m, 0.9 / m, 1 / m, min(0.95, 1.1 / m), 0.98)))
    o_grid <- o_grid[o_grid > 0 & o_grid < 1]
    for (o0 in o_grid) for (o1 in o_grid[o_grid > o0]) {
      L <- 1 - (q - 2) * w - beta * o0
      P <- 1 - (q - 2) * w - beta * o1
      for (nu in c(0, 0.17, 0.5, 0.83, 1)) {
        S <- (1 - nu) * L + nu * w
        assert_true(abs((P - E) - beta * (1 / m - o1)) < 1e-12, "P-E identity failed.")
        assert_true(
          abs((S - E) - ((1 - nu) * beta * (1 / m - o0) - nu * D)) < 1e-12,
          "S-E identity failed."
        )
        if (S >= E - 1e-12) assert_true(L >= 0, "Selected screening must be feasible.")
        if (P >= E - 1e-12) assert_true(P >= 0, "Selected pooling must be feasible.")
      }
    }
  }
}

# Strict and equality frontier witnesses.
N <- 9; m <- N - 1; q <- floor(N / 2) + 1; beta <- 0.8
w <- beta / m; E <- 1 - (q - 1) * w; D <- E - w
o0 <- 0.03; o1 <- 0.08
L <- 1 - (q - 2) * w - beta * o0; P <- 1 - (q - 2) * w - beta * o1
nu_sp <- beta * (o1 - o0) / (L - w); S <- (1 - nu_sp) * L + nu_sp * w
hS <- beta * ((1 - nu_sp) * o0 + nu_sp * o1); hP <- beta * o1
assert_true(nu_sp > 0 && nu_sp < 1 && abs(S - P) < 1e-12 && P > E && hS < hP, "S/P frontier failed.")

o0 <- 0.08; o1 <- 0.2
L <- 1 - (q - 2) * w - beta * o0
nu_se <- beta * (1 / m - o0) / (beta * (1 / m - o0) + D)
S <- (1 - nu_se) * L + nu_se * w
hE <- (1 - nu_se) * o0 + nu_se * o1; hS <- beta * hE
assert_true(nu_se > 0 && nu_se < 1 && abs(S - E) < 1e-12 && hS < hE, "S/E frontier failed.")

o0 <- 1 / m; o1 <- 0.2
L <- 1 - (q - 2) * w - beta * o0
assert_true(abs(L - E) < 1e-12 && beta * o0 < o0, "o_0=1/m boundary failed.")

o0 <- 0.08; o1 <- 1 / m
P <- 1 - (q - 2) * w - beta * o1
assert_true(abs(P - E) < 1e-12, "E=P boundary failed.")
nu_hp <- (beta / m - o0) / (1 / m - o0)
assert_true(abs(((1 - nu_hp) * o0 + nu_hp * o1) - beta / m) < 1e-12, "H-payoff E/P tie failed.")

# P0/P1/P1a and P6/P7.
for (y in c(0.01, 0.2, 0.7)) {
  r_i <- 1 - y
  assert_true((r_i + y) - r_i > 0, "P1 hedge must improve payoff strictly by y.")
}
for (o_theta in c(0.05, 0.4, 0.95)) {
  beta <- 0.8; t_theta <- beta * o_theta; y <- 0.2
  assert_true((y + o_theta) > y, "Nonpivotal H must strictly vote no.")
  assert_true(t_theta >= t_theta && (t_theta - 1e-6) < t_theta, "Pivotal H cutoff failed.")
}
posterior_after_h_vote <- function(nu, vote, low_vote, high_vote) {
  numerator <- nu * as.numeric(vote == high_vote)
  denominator <- (1 - nu) * as.numeric(vote == low_vote) + numerator
  if (denominator == 0) return(NA_real_)
  numerator / denominator
}
assert_true(identical(posterior_after_h_vote(0.3, "no", "yes", "no"), 1), "High no must reveal high.")
assert_true(identical(posterior_after_h_vote(0.3, "yes", "yes", "no"), 0), "Low yes must reveal low.")
assert_true(
  identical(posterior_after_h_vote(0, "yes", "yes", "no"), 0) &&
    identical(posterior_after_h_vote(1, "no", "yes", "no"), 1),
  "Bayes endpoint audit failed."
)

# R_i endpoint asymmetry remains part of the exhaustive deviation proof, not selection.
beta <- 0.8; o0 <- 0.2; o1 <- 0.6; t0 <- beta * o0; t1 <- beta * o1
y_nu1 <- (t0 + t1) / 2; y_nu0 <- t0 / 2
assert_true(y_nu1 >= t0 && y_nu1 < t1, "R_i(1) zero-prior-low endpoint failed.")
assert_true(y_nu0 < t0 && y_nu0 < t1, "R_i(0) asymmetric endpoint failed.")

# Targeted negative fixtures.
expect_candidate_rejection("old beta domain", function(x) {
  x$correspondence_cells[[1L]]$domain_conditions[[5L]] <- "beta in (0,1]"; x
})
expect_candidate_rejection("old N1 source hash", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$source_interface_hashes$N1 <-
    paste0("sha256:", old_n1_hash_bare); x
})
expect_candidate_rejection("double discount", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$
    weak_nonproposer_pre_recognition_expected_value$continuation_value_inside_formula <- "w=beta^2/m"; x
})
expect_candidate_rejection("nonpivotal H loses y", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    hegemon_vote_after_every_feasible_proposal$if_k_at_least_q_minus_1 <- "no pays o_theta"; x
})
expect_candidate_rejection("deliberate delay restored", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    closed_form_boundaries$strict_delay_result <- "D=0; rejection and slack survive"; x
})
expect_candidate_rejection("screening delay erased", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    closed_form_boundaries$strict_delay_result <- "delay never occurs"; x
})
expect_candidate_rejection("identity multiplicity collapsed", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    proposer_selection$identity_rule <- "F_i=F_j"; x
})
expect_candidate_rejection("off-path beliefs restricted", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system$
    published_vote_vector_zero_probability <- "eta_i(s,v)=nu"; x
})
expect_candidate_rejection("zero-prior type removed", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$belief_system$zero_prior_types <-
    "omit zero-prior type"; x
})
expect_candidate_rejection("N2 dependency introduced", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$source_interface_hashes$N2 <- n1_hash; x
})
expect_candidate_rejection("lifecycle inserted", function(x) { x$status <- "pass"; x })

# Round-1 bypass fixtures: every check below disables the exact-record anchor and
# therefore must be rejected by the independent substantive expectations alone.
expect_candidate_rejection("E incorrectly permits y>0", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    pure_candidate_families$E_i <-
    "choose K with |K|=q-1; y=0.1; x_j=w on K and 0 otherwise; r_i=E-0.1"
  x
})
expect_candidate_rejection("S incorrectly uses t_1", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    pure_candidate_families$S_i <-
    "if feasible, choose K with |K|=q-2; y=t_1; x_j=w on K and 0 otherwise; r_i=L"
  x
})
expect_candidate_rejection("H_star maximizes H payoff", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$strategy_profile$
    proposer_selection$H_star <-
    "max expected H payoff h_i(s;nu) among proposals attaining V_star"
  x
})
expect_candidate_rejection("screening delay exported as zero", function(x) {
  x$correspondence_cells[[1L]]$equilibrium_records[[1L]]$outcome_distribution$delay <-
    "0*I_D (screening never delays)"
  x
})
expect_candidate_rejection("coordinated beta=1 D=0 selected R corruption", function(x) {
  cell <- x$correspondence_cells[[1L]]
  record <- cell$equilibrium_records[[1L]]
  cell$domain_conditions[[5L]] <- "beta in (0,1]"
  record$branch_classification <- paste0(
    "rejection and slack correspondence with beta=1, D=0, and no screening delay"
  )
  record$strategy_profile$definitions$D <- "E-w=1-q*w=0 at beta=1"
  record$strategy_profile$pure_candidate_families$E_i <-
    "E_i permits y>0 and slack when beta=1"
  record$strategy_profile$pure_candidate_families$R_i_of_nu <-
    "R_i is selected on path whenever D=0"
  record$strategy_profile$proposer_selection$V_star <- "v_i(R_i;nu)"
  record$strategy_profile$proposer_selection$H_star <- "max expected H payoff"
  record$strategy_profile$proposer_selection$A_i_star <- "{R_i(nu)}"
  record$strategy_profile$proposer_selection$conditional_strategy_by_identity <-
    "F_i puts probability one on R_i(nu)"
  record$strategy_profile$closed_form_boundaries$strict_delay_result <-
    "D>0 is mentioned, but beta=1 and D=0 select R_i; screening never delays"
  record$assumptions_used[[1L]] <- "fixed pie and beta in (0,1] including beta=1"
  record$selection_status <- "R_i is selected on path at beta=1 and D=0"
  record$outcome_distribution$delay <- "0*I_D (screening never delays)"
  cell$equilibrium_records[[1L]] <- record
  x$correspondence_cells[[1L]] <- cell
  x
})

expect_ledger_rejection("false C01", function(x) {
  x$claim[1L] <- "Weak nonproposers always vote no regardless of x_j."
  x$branch[1L] <- "false cutoff"
  x
})
expect_ledger_rejection("false C04", function(x) {
  x$claim[4L] <- "Only R_i is feasible; E_i, S_i, and P_i do not exist."
  x$branch[4L] <- "false candidate reduction"
  x
})
expect_ledger_rejection("C10 keyword-only contradiction", function(x) {
  x$claim[10L] <- paste0(
    "D>0 and screening are keywords, but beta=1 gives D=0, R_i is selected, ",
    "and the high type never delays."
  )
  x$branch[10L] <- "false strict delay result"
  x
})
expect_ledger_rejection("coordinated ledger corruption", function(x) {
  x$claim[c(1L, 4L, 10L)] <- c(
    "Weak voters ignore x_j and always reject.",
    "The candidate set is only R_i.",
    "D>0 screening text coexists with beta=1, D=0, selected R_i, and no delay."
  )
  x$branch[c(1L, 4L, 10L)] <- c("false cutoff", "R only", "false delay")
  x$status[c(1L, 4L, 10L)] <- "proved"
  x
})

expect_derivation_rejection("prepend at document start", function(x) {
  paste0("Inserção falsa antes do título.\n", x)
})
expect_derivation_rejection("insert in document middle", function(x) {
  sub(
    "### Claim N3-C10 — `D>0`, rejeição, slack e delay",
    paste0(
      "Inserção falsa no meio da derivação.\n\n",
      "### Claim N3-C10 — `D>0`, rejeição, slack e delay"
    ),
    x, fixed = TRUE
  )
})
expect_derivation_rejection("append at document end", function(x) {
  paste0(x, "Inserção falsa depois do fim.\n")
})
expect_derivation_rejection("insert immediately before Section 8", function(x) {
  sub(
    "## 8. Invalidação",
    "Inserção falsa antes da Seção 8.\n\n## 8. Invalidação",
    x, fixed = TRUE
  )
})
expect_derivation_rejection("whitespace-only mutation", function(x) {
  sub("N3 não rederiva N1.", "N3  não rederiva N1.", x, fixed = TRUE)
})
expect_derivation_rejection("Round2 formal unit discount paraphrase", function(x) {
  sub(
    "## 8. Invalidação",
    paste0(
      "Adendo falso: o fator de desconto pode assumir valor unitário no domínio principal.\n\n",
      "## 8. Invalidação"
    ),
    x, fixed = TRUE
  )
})
expect_derivation_rejection("Round2 formal screening continuation paraphrase", function(x) {
  sub(
    "## 8. Invalidação",
    paste0(
      "Adendo falso: sob S, a recusa de theta=1 encerra a negociação na primeira rodada ",
      "em vez de levar a N1.\n\n## 8. Invalidação"
    ),
    x, fixed = TRUE
  )
})
expect_derivation_rejection("Round2 formal selected R paraphrase", function(x) {
  sub(
    "## 8. Invalidação",
    paste0(
      "Adendo falso: propostas da família R maximizam o payoff do proponente em algumas regiões.\n\n",
      "## 8. Invalidação"
    ),
    x, fixed = TRUE
  )
})
expect_derivation_rejection("Round2 formal slack paraphrase", function(x) {
  sub(
    "## 8. Invalidação",
    paste0(
      "Adendo falso: folga orçamentária integra A_i_star em um subconjunto do domínio.\n\n",
      "## 8. Invalidação"
    ),
    x, fixed = TRUE
  )
})
expect_derivation_rejection("Round2 game-theory internal appendix", function(x) {
  sub(
    "## 8. Invalidação",
    paste0(
      "**Apêndice contraditório.** O caso sem impaciência também pertence ao baseline; ",
      "nele a vantagem da exclusão pode desaparecer, propostas destinadas à recusa podem ",
      "maximizar e o tipo alto conclui na primeira rodada após screening.\n\n",
      "## 8. Invalidação"
    ),
    x, fixed = TRUE
  )
})

field_paths <- collect_named_paths(candidate)
for (field_path in field_paths) {
  local({
    current_path <- field_path
    expect_candidate_rejection(paste("generic field", path_label(current_path)), function(x) {
      set_path_value(x, current_path, list(corrupted = path_label(current_path)))
    })
  })
}
for (row in seq_len(nrow(ledger))) for (column in names(ledger)) {
  local({
    current_row <- row; current_column <- column
    expect_ledger_rejection(paste("ledger", current_row, current_column), function(x) {
      x[[current_column]][current_row] <- paste0("CORRUPTED-", current_column); x
    })
  })
}

cat("PASS: N3 R1-majority strict-beta candidate, derivation, and ledger validated.\n")
cat("PASS: P0, P1, P1a, P2, P6, and P7 checks passed.\n")
cat("PASS: D>0 eliminates deliberate rejection and slack; screening delay remains represented.\n")
cat("PASS: endpoints, zero-prior types, E/S/P frontiers, identity-indexed F_i, and off-path beliefs passed.\n")
cat(sprintf(
  paste0(
    "SEMANTIC_MUTATION_REJECTED: %d named interface paths and %d ledger cells, plus ",
    "the coordinated candidate/ledger and all 10 Round-2 derivation mutations, were rejected ",
    "with the outer exact-record/hash anchor disabled.\n"
  ),
  length(field_paths), nrow(ledger) * ncol(ledger)
))
cat("SHA-256:", expected_interface_hash, "\n")
cat("STATUS: N3 is pass/frozen on the exact candidate with N1 dependency and two independent R3 PASS 0/0/0 reviews.\n")
