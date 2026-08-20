#!/usr/bin/env Rscript

# Standalone N3 v5 builder. It imports no N3 v2/v3 object or function; the
# earlier versions remain provenance only. Its sole semantic dependency is the
# byte-pinned frozen N1 interface.

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  assert_true(length(output) == 1L, paste("Could not hash", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

write_canonical_json <- function(object, path) {
  serialized <- jsonlite::toJSON(
    object,
    auto_unbox = TRUE,
    null = "null",
    na = "null",
    digits = NA,
    pretty = TRUE
  )
  Encoding(serialized) <- "UTF-8"
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  writeLines(serialized, con = path, useBytes = TRUE)
}

make_n3_v5_objects <- function(n1_hash) {
  common_domain <- c(
    "nu is the entry belief Pr(theta=1) and 0 <= nu <= 1",
    "N is an integer and N >= 3",
    "W is the set of weak states, m=N-1, and |W|=m",
    "q=floor(N/2)+1 and q<=m",
    "0 < beta < 1",
    "0 < o_0 < o_1 < 1 and o_1 <= y_bar <= 1",
    "every proposal satisfies 0<=y<=y_bar, every x_j>=0, r_i>=0, and y+sum_j x_j+r_i<=1",
    paste0("the sole continuation is N1-EQ-01 at ", n1_hash)
  )

  common_assumptions <- c(
    "fixed unit pie, strict beta in (0,1), strict 0<o_0<o_1<1, and package feasibility from contract Section 2",
    "majority quota, full execution of y, simultaneous sealed ballots, public vote vector, and terminal payoffs from contract Section 4",
    "PBE with pure ballot strategies, weak-only stage-undominated voting, T^Y, and the minimum-expected-H proposal tie-break from contract Section 5",
    "exactly one multiplication by beta when the frozen N1 continuation enters R1 incentives under contract Section 6",
    "iid uniform weak-state recognition with replacement, no side payments, and no exit action"
  )

  branch_weight_condition <- function(branch) {
    if (branch %in% c("low", "pool")) {
      return(paste0(
        "for every recognized proposer i in W, omega_{i,K}>=0 is defined for every ",
        "K subset W\\{i} with |K|=q-2 and sum_K omega_{i,K}=1; the arrays may differ by i"
      ))
    }
    if (identical(branch, "exclude")) {
      return(paste0(
        "for every recognized proposer i in W, omega_{i,K}>=0 is defined for every ",
        "K subset W\\{i} with |K|=q-1 and sum_K omega_{i,K}=1; the arrays may differ by i"
      ))
    }
    paste0(
      "for every recognized proposer i in W, e_{i,K}>=0 is defined for every exclusion ",
      "coalition K subset W\\{i} with |K|=q-1 and p_{i,T}>=0 for every pooling coalition ",
      "T subset W\\{i} with |T|=q-2; sum_K e_{i,K}+sum_T p_{i,T}=1, independently for each i"
    )
  }

  selected_proposals <- function(branch) {
    if (identical(branch, "low")) {
      return(list(
        family = "For every i and every K with omega_{i,K}>0: y=beta*o_0; x_j=beta/m iff j in K and x_j=0 otherwise; r_i=1-beta*o_0-beta*(q-2)/m.",
        coalition_size = "|K|=q-2",
        pure_and_mixed = "A degenerate omega array is a pure proposal. Any nondegenerate omega array is an admissible proposer mixture over coalition identities."
      ))
    }
    if (identical(branch, "pool")) {
      return(list(
        family = "For every i and every K with omega_{i,K}>0: y=beta*o_1; x_j=beta/m iff j in K and x_j=0 otherwise; r_i=1-beta*o_1-beta*(q-2)/m.",
        coalition_size = "|K|=q-2",
        pure_and_mixed = "A degenerate omega array is a pure proposal. Any nondegenerate omega array is an admissible proposer mixture over coalition identities."
      ))
    }
    if (identical(branch, "exclude")) {
      return(list(
        family = "For every i and every K with omega_{i,K}>0: y=0; x_j=beta/m iff j in K and x_j=0 otherwise; r_i=1-beta*(q-1)/m.",
        coalition_size = "|K|=q-1",
        pure_and_mixed = "A degenerate omega array is a pure proposal. Any nondegenerate omega array is an admissible proposer mixture over coalition identities."
      ))
    }
    list(
      family = paste0(
        "For every i, e_{i,K}>0 supports y=0, x_j=beta/m iff j in K with |K|=q-1, ",
        "and r_i=1-beta*(q-1)/m. The weight p_{i,T}>0 supports y=beta/m, ",
        "x_j=beta/m iff j in T with |T|=q-2, and the same r_i=1-beta*(q-1)/m."
      ),
      coalition_size = "exclusion uses |K|=q-1 and pooling uses |T|=q-2",
      pure_and_mixed = paste0(
        "The strategy of proposer i is pure iff exactly one of its e or p weights equals one. ",
        "Every other admissible weight array is a proposer mixture. Pure choices and mixtures may differ across proposer identities."
      )
    )
  }

  common_strategy <- function(branch) {
    list(
      frozen_continuation = list(
        source = paste0("N1-EQ-01 at ", n1_hash),
        weak_value_in_R2_current_units = "1/m",
        hegemon_value_in_R2_current_units = list(theta_0 = "o_0", theta_1 = "o_1"),
        transport_to_R1 = "weak continuation beta/m and H continuation beta*o_theta, each discounted exactly once",
        posterior_invariance = "N1-EQ-01 is the same record for every R2 entry posterior in [0,1]"
      ),
      ballot_map_after_every_feasible_proposal = list(
        definitions = paste0(
          "For proposer i and proposal s=(y,(x_j)_{j in W\\{i}},r_i), let ",
          "K_i(s)={j in W\\{i}: x_j>=beta/m} and k_i(s)=|K_i(s)|."
        ),
        weak_nonproposer_j = "vote yes iff x_j>=beta/m; at equality T^Y selects yes",
        hegemon_if_k_at_least_q_minus_1 = "both types vote no because passage is independent of H and no pays y+o_theta>y",
        hegemon_if_k_equals_q_minus_2 = "type theta votes yes iff y>=beta*o_theta; T^Y selects yes at equality",
        hegemon_if_k_at_most_q_minus_3 = "both types vote yes by T^Y because either H action leads to the posterior-invariant N1 continuation"
      ),
      proposer_payoff_after_every_feasible_proposal = list(
        if_k_at_least_q_minus_1 = "r_i",
        if_k_equals_q_minus_2_and_y_below_beta_o0 = "beta/m",
        if_k_equals_q_minus_2_and_beta_o0_at_most_y_below_beta_o1 = "(1-nu)*r_i+nu*beta/m",
        if_k_equals_q_minus_2_and_y_at_least_beta_o1 = "r_i",
        if_k_at_most_q_minus_3 = "beta/m"
      ),
      candidate_payoffs_in_primitives = list(
        exclusion = "1-beta*(q-1)/m",
        low_type_only = "(1-nu)*(1-beta*o_0-beta*(q-2)/m)+nu*beta/m",
        pooling = "1-beta*o_1-beta*(q-2)/m",
        deliberate_failure = "beta/m",
        exclusion_minus_deliberate_failure = "1-beta*q/m>0 because q<=m and beta<1",
        pooling_minus_exclusion = "beta*(1/m-o_1)",
        low_type_only_minus_exclusion = "(1-nu)*beta*(1/m-o_0)-nu*(1-beta*q/m)"
      ),
      selected_proposal_parameterization = selected_proposals(branch),
      feasibility = switch(
        branch,
        low = paste0(
          "Every selected low-type-only proposal is strictly feasible because its cell has o_0<=1/m, ",
          "so beta*[o_0+(q-2)/m] <= beta*(q-1)/m < 1; also 0<beta*o_0<o_0<y_bar."
        ),
        pool = paste0(
          "Every selected pooling proposal is strictly feasible because its cell has o_1<=1/m, ",
          "so beta*[o_1+(q-2)/m] <= beta*(q-1)/m < 1; also 0<beta*o_1<o_1<=y_bar."
        ),
        exclude = "Every exclusion proposal is strictly feasible because y=0<=y_bar and beta*(q-1)/m<1.",
        mixed_ep = paste0(
          "Both support families are strictly feasible: o_1=1/m makes pooling cost beta*(q-1)/m, ",
          "the same cost as exclusion, beta*(q-1)/m<1, and pooling y=beta*o_1<o_1<=y_bar while exclusion y=0."
        )
      )
    )
  }

  belief_system <- function(branch) {
    positive_failure <- if (identical(branch, "low")) {
      paste0(
        "For nu>0, the unique positive-probability R1 failure after a selected low-type-only proposal ",
        "has H voting no only under theta=1; Bayes therefore fixes the published R2 posterior at 1."
      )
    } else {
      "The selected proposal passes in R1, so it generates no positive-probability R1 failure."
    }
    list(
      entry = "Pr(theta=1)=nu.",
      positive_weight_proposal = "The weak proposer does not observe theta, so every proposal assigned positive conditional weight has ballot posterior nu by Bayes.",
      zero_weight_proposal = "Every individual proposal assigned zero conditional weight receives an arbitrary ballot belief kappa_i(s) in [0,1].",
      published_vote_vector = positive_failure,
      zero_probability_proposal_vote_vectors = paste0(
        "For every proposal s and complete published vote vector v such that (s,v) has probability zero ",
        "under the assessment, at every nu in [0,1] including nu>0 and both endpoints, the R2 posterior ",
        "is explicitly an arbitrary eta_i(s,v) in [0,1]."
      ),
      weak_vote_information = "Weak votes are deterministic functions of x_j and never of theta; they add no type information beyond the proposal and H vote on every positive-probability history.",
      zero_prior_types = "At nu=0 or nu=1, ballot strategies and conditional payoffs remain specified for both types; Bayes constrains only positive-probability histories.",
      continuation_effect = paste0(
        "Every on-path or off-path R2 posterior consumes the same frozen N1-EQ-01 at ",
        n1_hash, "."
      ),
      deviating_proposer_evaluation = "Every proposal deviation is evaluated under the true pre-proposal prior nu, not the off-path ballot belief."
    )
  }

  recognized_proposer_payoff <- function(branch) {
    switch(
      branch,
      low = "(1-nu)*(1-beta*o_0-beta*(q-2)/m)+nu*beta/m",
      pool = "1-beta*o_1-beta*(q-2)/m",
      exclude = "1-beta*(q-1)/m",
      mixed_ep = "1-beta*(q-1)/m"
    )
  }

  weak_payoff_map <- function(branch) {
    if (identical(branch, "low")) {
      return(list(
        type = "identity-indexed pre-recognition R1 payoff map; no symmetry restriction",
        by_weak_state_l = paste0(
          "C_l=(1/m)*[(1-nu)*(1-beta*o_0-beta*(q-2)/m)+nu*beta/m] + ",
          "(1/m)*sum_{i in W, i!=l}{(1-nu)*(beta/m)*sum_{K subset W\\{i}, |K|=q-2, l in K}omega_{i,K} + nu*beta/m}; ",
          "for each i, omega_{i,K}>=0 and sum_{K subset W\\{i}, |K|=q-2}omega_{i,K}=1"
        )
      ))
    }
    if (identical(branch, "pool")) {
      return(list(
        type = "identity-indexed pre-recognition R1 payoff map; no symmetry restriction",
        by_weak_state_l = paste0(
          "C_l=(1/m)*[1-beta*o_1-beta*(q-2)/m] + ",
          "(1/m)*sum_{i in W, i!=l}{(beta/m)*sum_{K subset W\\{i}, |K|=q-2, l in K}omega_{i,K}}; ",
          "for each i, omega_{i,K}>=0 and sum_{K subset W\\{i}, |K|=q-2}omega_{i,K}=1"
        )
      ))
    }
    if (identical(branch, "exclude")) {
      return(list(
        type = "identity-indexed pre-recognition R1 payoff map; no symmetry restriction",
        by_weak_state_l = paste0(
          "C_l=(1/m)*[1-beta*(q-1)/m] + ",
          "(1/m)*sum_{i in W, i!=l}{(beta/m)*sum_{K subset W\\{i}, |K|=q-1, l in K}omega_{i,K}}; ",
          "for each i, omega_{i,K}>=0 and sum_{K subset W\\{i}, |K|=q-1}omega_{i,K}=1"
        )
      ))
    }
    list(
      type = "identity-indexed pre-recognition R1 payoff map; no symmetry restriction",
      by_weak_state_l = paste0(
        "C_l=(1/m)*[1-beta*(q-1)/m] + (1/m)*sum_{i in W, i!=l}{(beta/m)*[",
        "sum_{K subset W\\{i}, |K|=q-1, l in K}e_{i,K}+",
        "sum_{T subset W\\{i}, |T|=q-2, l in T}p_{i,T}]}; for each i all e and p are nonnegative and ",
        "sum_{K subset W\\{i}, |K|=q-1}e_{i,K}+sum_{T subset W\\{i}, |T|=q-2}p_{i,T}=1"
      )
    )
  }

  hegemon_payoff <- function(branch) {
    if (identical(branch, "low")) return(list(theta_0 = "beta*o_0", theta_1 = "beta*o_1"))
    if (identical(branch, "pool")) return(list(theta_0 = "beta*o_1", theta_1 = "beta*o_1"))
    if (identical(branch, "exclude")) return(list(theta_0 = "o_0", theta_1 = "o_1"))
    list(
      theta_0 = paste0(
        "(1/m)*sum_{i in W}{o_0*sum_{K subset W\\{i}, |K|=q-1}e_{i,K} + ",
        "(beta/m)*sum_{T subset W\\{i}, |T|=q-2}p_{i,T}}, where for each i all e and p are nonnegative and the two displayed sums add to 1"
      ),
      theta_1 = paste0(
        "(1/m)*sum_{i in W}{(1/m)*sum_{K subset W\\{i}, |K|=q-1}e_{i,K} + ",
        "(beta/m)*sum_{T subset W\\{i}, |T|=q-2}p_{i,T}}, where o_1=1/m and for each i all e and p are nonnegative and the two displayed sums add to 1"
      )
    )
  }

  outcome_distribution <- function(branch) {
    if (identical(branch, "low")) {
      return(list(pass_with_hegemon = "1-nu", pass_without_hegemon = 0, failure = 0, delay = "nu"))
    }
    if (identical(branch, "pool")) {
      return(list(pass_with_hegemon = 1, pass_without_hegemon = 0, failure = 0, delay = 0))
    }
    if (identical(branch, "exclude")) {
      return(list(pass_with_hegemon = 0, pass_without_hegemon = 1, failure = 0, delay = 0))
    }
    definition <- paste0(
      "for each i all e_{i,K} and p_{i,T} are nonnegative and ",
      "sum_{K subset W\\{i}, |K|=q-1}e_{i,K}+sum_{T subset W\\{i}, |T|=q-2}p_{i,T}=1"
    )
    list(
      pass_with_hegemon = paste0(
        "(1/m)*sum_{i in W}sum_{T subset W\\{i}, |T|=q-2}p_{i,T}, where ", definition
      ),
      pass_without_hegemon = paste0(
        "(1/m)*sum_{i in W}sum_{K subset W\\{i}, |K|=q-1}e_{i,K}, where ", definition
      ),
      failure = 0,
      delay = 0
    )
  }

  selection_status <- function(branch) {
    if (identical(branch, "low")) {
      return(paste0(
        "All and only arrays omega_{i,K}>=0 over K subset W\\{i}, |K|=q-2, with sum_K omega_{i,K}=1 for each i are retained. ",
        "A degenerate array is a pure proposal and a nondegenerate array is proposer mixing; arrays may differ across i. ",
        "The minimum-expected-H tie-break selects low-type-only at every included payoff boundary. No symmetry or further selection is imposed."
      ))
    }
    if (identical(branch, "pool")) {
      return(paste0(
        "All and only arrays omega_{i,K}>=0 over K subset W\\{i}, |K|=q-2, with sum_K omega_{i,K}=1 for each i are retained. ",
        "A degenerate array is pure and a nondegenerate array is proposer mixing; arrays may differ across i. ",
        "Pooling uniquely minimizes expected H payoff among proposer-payoff maximizers in this cell. No further selection is imposed."
      ))
    }
    if (identical(branch, "exclude")) {
      return(paste0(
        "All and only arrays omega_{i,K}>=0 over K subset W\\{i}, |K|=q-1, with sum_K omega_{i,K}=1 for each i are retained. ",
        "A degenerate array is pure and a nondegenerate array is proposer mixing; arrays may differ across i. ",
        "Exclusion uniquely minimizes expected H payoff among proposer-payoff maximizers in this cell. No further selection is imposed."
      ))
    }
    paste0(
      "For each i, retain every nonnegative array e_{i,K} over |K|=q-1 exclusion coalitions and p_{i,T} over |T|=q-2 pooling coalitions whose total sum is one. ",
      "The strategy is pure iff exactly one weight equals one for every i; otherwise the corresponding proposer mixes. ",
      "Arrays may differ across proposer identities. Because proposer payoff and expected H payoff tie exactly in this cell, all pure identity assignments and all proposer mixtures over exclusion and pooling are retained, with no symmetry or further selection."
    )
  }

  existence_status <- function(branch) {
    if (identical(branch, "mixed_ep")) {
      return(paste0(
        "exists; strategy, type-specific H payoff, and outcome multiple through arbitrary pure identity assignments and proposer mixtures between exclusion and pooling, ",
        "plus coalition-identity mixing and payoff-irrelevant off-path beliefs; all multiplicity is parameterized in this record"
      ))
    }
    paste0(
      "exists; selected branch, recognized-proposer payoff, type-specific H payoff, and outcome distribution are unique in this cell; ",
      "strategy multiplicity remains through coalition identities, arbitrary proposer mixing over those identities, and payoff-irrelevant off-path beliefs"
    )
  }

  make_record <- function(region) {
    branch <- region$branch
    list(
      equilibrium_id = region$equilibrium_id,
      admissibility_conditions = c(
        common_domain,
        region$conditions,
        branch_weight_condition(branch),
        "ballot actions are pure; only the weak proposer's proposal may be mixed through the explicitly parameterized finite weights",
        "the four outcome coordinates partition the R1 event: delay records R1 failure followed by N1, while failure records terminal failure after the two-round game"
      ),
      branch_classification = region$classification,
      strategy_profile = common_strategy(branch),
      belief_system = belief_system(branch),
      source_continuation_record_ids = list("N1-EQ-01"),
      source_interface_hashes = list(N1 = n1_hash),
      existence_uniqueness_status = existence_status(branch),
      selection_status = selection_status(branch),
      assumptions_used = common_assumptions,
      checks_performed = c(
        "N3V5-C01 frozen N1 import and exactly-one discount",
        "N3V5-C02 weak voting cutoff and T^Y",
        "N3V5-C03 complete H best-response map",
        "N3V5-C04 proposer payoff map for every feasible proposal",
        "N3V5-C05 exhaustive reduction to exclusion, low-type-only, pooling, and deliberate failure",
        "N3V5-C06 P0 full-pie use through belief-invariant N1 response maps",
        "N3V5-C07 P1 strict hedge dominance and P1a",
        "N3V5-C08 deliberate failure strictly dominated because 1-beta*q/m>0",
        "N3V5-C09 candidate feasibility in every selected cell",
        "N3V5-C10 strict-region and equality-boundary partition",
        "N3V5-C11 o_1=1/m residual proposer tie and expected-H tie-break",
        "N3V5-C12 pure identity assignments and all proposer mixtures",
        "N3V5-C13 Bayes and complete off-path proposal-vote beliefs at every nu",
        "N3V5-C14 P7 public H vote and posterior update",
        "N3V5-C15 identity-indexed weak payoff map",
        "N3V5-C16 closed N6-transported fields without free symbols",
        "N3V5-C17 complete existence and endpoint coverage"
      ),
      recognized_proposer_payoff = recognized_proposer_payoff(branch),
      weak_nonproposer_pre_recognition_expected_value = weak_payoff_map(branch),
      hegemon_payoff_by_type = hegemon_payoff(branch),
      outcome_distribution = outcome_distribution(branch),
      payoff_date = "R1 current units; frozen N1 continuation payoffs are multiplied by beta exactly once"
    )
  }

  make_cell <- function(region) {
    list(
      cell_id = region$cell_id,
      domain_conditions = c(common_domain, region$conditions),
      existence_status = "exists",
      equilibrium_records = list(make_record(region)),
      nonexistence_certificate = NULL
    )
  }

  nu_sp <- "beta*(o_1-o_0)/(1-beta*o_0-beta*(q-1)/m)"
  nu_se <- "beta*(1/m-o_0)/(beta*(1/m-o_0)+1-beta*q/m)"
  h_e <- "(1-nu)*o_0+nu/m"
  h_p <- "beta/m"

  regions <- list(
    list(
      cell_id = "N3V5-CELL-O1LT-LOW",
      equilibrium_id = "N3V5-EQ-O1LT-LOW",
      branch = "low",
      conditions = c("o_1<1/m", paste0("0<=nu<=", nu_sp)),
      classification = "low-type-only R1 passage with H; the high type delays to N1; the S/P payoff equality is assigned here by the minimum-expected-H proposal tie-break"
    ),
    list(
      cell_id = "N3V5-CELL-O1LT-POOL",
      equilibrium_id = "N3V5-EQ-O1LT-POOL",
      branch = "pool",
      conditions = c("o_1<1/m", paste0(nu_sp, "<nu<=1")),
      classification = "pooling R1 passage with H"
    ),
    list(
      cell_id = "N3V5-CELL-CROSS-LOW",
      equilibrium_id = "N3V5-EQ-CROSS-LOW",
      branch = "low",
      conditions = c("o_0<1/m<o_1", paste0("0<=nu<=", nu_se)),
      classification = "low-type-only R1 passage with H; the high type delays to N1; the S/E payoff equality is assigned here by the minimum-expected-H proposal tie-break"
    ),
    list(
      cell_id = "N3V5-CELL-CROSS-EXCLUDE",
      equilibrium_id = "N3V5-EQ-CROSS-EXCLUDE",
      branch = "exclude",
      conditions = c("o_0<1/m<o_1", paste0(nu_se, "<nu<=1")),
      classification = "R1 passage without H at y=0"
    ),
    list(
      cell_id = "N3V5-CELL-O0GT-EXCLUDE",
      equilibrium_id = "N3V5-EQ-O0GT-EXCLUDE",
      branch = "exclude",
      conditions = c("1/m<o_0<o_1", "0<=nu<=1"),
      classification = "R1 passage without H at y=0"
    ),
    list(
      cell_id = "N3V5-CELL-O0EQ-LOW-ENDPOINT",
      equilibrium_id = "N3V5-EQ-O0EQ-LOW-ENDPOINT",
      branch = "low",
      conditions = c("o_0=1/m<o_1", "nu=0"),
      classification = "measure-zero low-type-only endpoint; its proposer payoff ties exclusion and the minimum-expected-H proposal tie-break selects it"
    ),
    list(
      cell_id = "N3V5-CELL-O0EQ-EXCLUDE",
      equilibrium_id = "N3V5-EQ-O0EQ-EXCLUDE",
      branch = "exclude",
      conditions = c("o_0=1/m<o_1", "0<nu<=1"),
      classification = "R1 passage without H at y=0"
    ),
    list(
      cell_id = "N3V5-CELL-O1EQ-LOW",
      equilibrium_id = "N3V5-EQ-O1EQ-LOW",
      branch = "low",
      conditions = c("o_0<o_1=1/m", paste0("0<=nu<=", nu_se)),
      classification = "low-type-only R1 passage with H; the high type delays to N1; the S/(E=P) equality is assigned here by the minimum-expected-H proposal tie-break"
    ),
    list(
      cell_id = "N3V5-CELL-O1EQ-EXCLUDE",
      equilibrium_id = "N3V5-EQ-O1EQ-EXCLUDE",
      branch = "exclude",
      conditions = c("o_0<o_1=1/m", paste0(nu_se, "<nu<=1"), paste0(h_e, "<", h_p)),
      classification = "measure-zero residual E=P proposer-payoff tie; exclusion uniquely minimizes expected H payoff"
    ),
    list(
      cell_id = "N3V5-CELL-O1EQ-POOL",
      equilibrium_id = "N3V5-EQ-O1EQ-POOL",
      branch = "pool",
      conditions = c("o_0<o_1=1/m", paste0(nu_se, "<nu<=1"), paste0(h_p, "<", h_e)),
      classification = "measure-zero residual E=P proposer-payoff tie; pooling uniquely minimizes expected H payoff"
    ),
    list(
      cell_id = "N3V5-CELL-O1EQ-MIXED-EP",
      equilibrium_id = "N3V5-EQ-O1EQ-MIXED-EP",
      branch = "mixed_ep",
      conditions = c("o_0<o_1=1/m", paste0(nu_se, "<nu<=1"), paste0(h_e, "=", h_p)),
      classification = "measure-zero residual E=P proposer-payoff and expected-H tie; every pure proposer-identity assignment and every proposer mixture over exclusion and pooling is admissible"
    )
  )

  interface <- list(
    schema_ref = "equilibrium_correspondence_v1",
    function_of = list(name = "entry_belief", domain = "[0,1]"),
    correspondence_cells = lapply(regions, make_cell)
  )

  equilibrium_ids <- vapply(regions, function(region) region$equilibrium_id, character(1))
  claims <- list(
    list("N3V5-C01", "continuation", "N1-EQ-01 supplies 1/m to each weak state and o_theta to H in R2 current units; beta is applied exactly once in R1."),
    list("N3V5-C02", "weak ballot", "A weak nonproposer votes yes if and only if x_j>=beta/m, with T^Y selecting yes at equality."),
    list("N3V5-C03", "H ballot", "H's complete best-response map covers nonpivotal passage, pivotal passage, and inevitable failure after every feasible proposal."),
    list("N3V5-C04", "proposer deviations", "The closed proposer-payoff map covers every feasible proposal and both types under the true prior."),
    list("N3V5-C05", "candidate reduction", "Every payoff-maximizing pure proposal reduces to exclusion, low-type-only, or pooling; deliberate failure remains in the deviation set."),
    list("N3V5-C06", "P0", "Every selected proposal exhausts the pie because increasing the proposer residual preserves the belief-invariant response and outcome maps induced by frozen N1; no on-path slack survives."),
    list("N3V5-C07", "P1 and P1a", "Every pass-without-H proposal with y>0 is strictly dominated by shifting y to r_i, so every selected exclusion proposal has y=0."),
    list("N3V5-C08", "delay", "Deliberate failure pays beta/m and is strictly dominated by exclusion by 1-beta*q/m>0; screening delay survives with probability nu in selected low-type-only cells."),
    list("N3V5-C09", "feasibility", "Every selected low-type-only, pooling, and exclusion candidate is strictly feasible in its declared cell."),
    list("N3V5-C10", "partition", "The eleven cells are mutually exclusive and exhaustive over all admissible primitives and nu, including every equality and endpoint."),
    list("N3V5-C11", "o_1=1/m", "The residual E=P proposer-payoff tie is resolved by the expected-H comparison, with both branches and every mixture retained at exact equality."),
    list("N3V5-C12", "multiplicity", "All coalition identities, pure proposer-identity assignments, and proposer mixtures are parameterized without a symmetry restriction."),
    list("N3V5-C13", "beliefs", "Positive-probability proposals obey Bayes, zero-prior type strategies remain specified, and every zero-probability proposal-vote vector has an explicit unrestricted posterior at every nu."),
    list("N3V5-C14", "P7", "The public H vote enters every positive-probability posterior update; weak votes are type-independent."),
    list("N3V5-C15", "weak payoff map", "Each record exports the complete identity-indexed pre-recognition weak payoff map."),
    list("N3V5-C16", "transport sufficiency", "Every symbol in admissibility_conditions, selection_status, hegemon_payoff_by_type, and outcome_distribution is primitive or defined inside that transported record."),
    list("N3V5-C17", "existence", "An equilibrium exists throughout the declared domain; there is no nonexistence cell under beta in (0,1).")
  )

  ledger <- list(
    schema_version = "essential-input-claim-ledger-v5",
    node = "N3",
    candidate_status = "pending_independent_review",
    source_interface = list(record_id = "N1-EQ-01", artifact_hash = n1_hash),
    equilibrium_ids = as.list(equilibrium_ids),
    claims = lapply(claims, function(entry) {
      list(
        claim_id = entry[[1L]],
        equilibrium_ids = as.list(equilibrium_ids),
        branch = entry[[2L]],
        payoff_date = "R1 current units",
        claim = entry[[3L]],
        status = "proved",
        evidence = paste0(
          "model_redesign/essential_input_n3_r1_majority_derivation_v5.md#claim-",
          tolower(entry[[1L]])
        )
      )
    })
  )

  list(interface = interface, ledger = ledger)
}

direct_execution <- function() {
  script_arguments <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  length(script_arguments) == 1L &&
    identical(basename(sub("^--file=", "", script_arguments)), "build_essential_input_n3_v5.R")
}

option_value <- function(arguments, prefix, default) {
  matches <- arguments[startsWith(arguments, prefix)]
  if (length(matches) == 0L) return(default)
  assert_true(length(matches) == 1L, paste("Option repeated:", prefix))
  sub(prefix, "", matches[[1L]], fixed = TRUE)
}

main <- function() {
  script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  assert_true(length(script_argument) == 1L, "Could not resolve build-script path.")
  script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
  repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
  arguments <- commandArgs(trailingOnly = TRUE)

  n1_path <- file.path(
    repository_root,
    "model_redesign",
    "essential_input_interfaces",
    "n1_r2_majority_candidate_v1.json"
  )
  default_interface_path <- file.path(
    repository_root,
    "model_redesign",
    "essential_input_interfaces",
    "n3_r1_majority_candidate_v5.json"
  )
  default_ledger_path <- file.path(
    repository_root,
    "model_redesign",
    "essential_input_n3_claim_ledger_v5.json"
  )
  interface_path <- option_value(arguments, "--interface-output=", default_interface_path)
  ledger_path <- option_value(arguments, "--ledger-output=", default_ledger_path)
  quiet <- "--quiet" %in% arguments

  n1_hash_bare <- "1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
  n1_hash <- paste0("sha256:", n1_hash_bare)
  assert_true(file.exists(n1_path), "Frozen N1 interface is missing.")
  assert_true(
    identical(sha256_file(n1_path), n1_hash_bare),
    "N3 v5 may consume only the authorized frozen N1 bytes."
  )

  objects <- make_n3_v5_objects(n1_hash)
  write_canonical_json(objects$interface, interface_path)
  write_canonical_json(objects$ledger, ledger_path)

  if (!quiet) {
    cat("BUILT:", interface_path, "\n")
    cat("BUILT:", ledger_path, "\n")
    cat("N1-SHA-256:", n1_hash_bare, "\n")
    cat("N3V5-SHA-256:", sha256_file(interface_path), "\n")
    cat("LEDGER-SHA-256:", sha256_file(ledger_path), "\n")
  }
}

if (direct_execution()) main()
