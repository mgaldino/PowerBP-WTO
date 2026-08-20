#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

oracle_assert <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

oracle_as_character <- function(x) as.character(unlist(x, use.names = FALSE))

oracle_sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  oracle_assert(length(output) == 1L, paste("Could not hash", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  oracle_assert(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

oracle_reconstruct_n3_v4_objects <- function(n1_hash) {
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
        "N3V4-C01 frozen N1 import and exactly-one discount",
        "N3V4-C02 weak voting cutoff and T^Y",
        "N3V4-C03 complete H best-response map",
        "N3V4-C04 proposer payoff map for every feasible proposal",
        "N3V4-C05 exhaustive reduction to exclusion, low-type-only, pooling, and deliberate failure",
        "N3V4-C06 P0 full-pie use through belief-invariant N1 response maps",
        "N3V4-C07 P1 strict hedge dominance and P1a",
        "N3V4-C08 deliberate failure strictly dominated because 1-beta*q/m>0",
        "N3V4-C09 candidate feasibility in every selected cell",
        "N3V4-C10 strict-region and equality-boundary partition",
        "N3V4-C11 o_1=1/m residual proposer tie and expected-H tie-break",
        "N3V4-C12 pure identity assignments and all proposer mixtures",
        "N3V4-C13 Bayes and complete off-path proposal-vote beliefs at every nu",
        "N3V4-C14 P7 public H vote and posterior update",
        "N3V4-C15 identity-indexed weak payoff map",
        "N3V4-C16 closed N6-transported fields without free symbols",
        "N3V4-C17 complete existence and endpoint coverage"
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
      cell_id = "N3V4-CELL-O1LT-LOW",
      equilibrium_id = "N3V4-EQ-O1LT-LOW",
      branch = "low",
      conditions = c("o_1<1/m", paste0("0<=nu<=", nu_sp)),
      classification = "low-type-only R1 passage with H; the high type delays to N1; the S/P payoff equality is assigned here by the minimum-expected-H proposal tie-break"
    ),
    list(
      cell_id = "N3V4-CELL-O1LT-POOL",
      equilibrium_id = "N3V4-EQ-O1LT-POOL",
      branch = "pool",
      conditions = c("o_1<1/m", paste0(nu_sp, "<nu<=1")),
      classification = "pooling R1 passage with H"
    ),
    list(
      cell_id = "N3V4-CELL-CROSS-LOW",
      equilibrium_id = "N3V4-EQ-CROSS-LOW",
      branch = "low",
      conditions = c("o_0<1/m<o_1", paste0("0<=nu<=", nu_se)),
      classification = "low-type-only R1 passage with H; the high type delays to N1; the S/E payoff equality is assigned here by the minimum-expected-H proposal tie-break"
    ),
    list(
      cell_id = "N3V4-CELL-CROSS-EXCLUDE",
      equilibrium_id = "N3V4-EQ-CROSS-EXCLUDE",
      branch = "exclude",
      conditions = c("o_0<1/m<o_1", paste0(nu_se, "<nu<=1")),
      classification = "R1 passage without H at y=0"
    ),
    list(
      cell_id = "N3V4-CELL-O0GT-EXCLUDE",
      equilibrium_id = "N3V4-EQ-O0GT-EXCLUDE",
      branch = "exclude",
      conditions = c("1/m<o_0<o_1", "0<=nu<=1"),
      classification = "R1 passage without H at y=0"
    ),
    list(
      cell_id = "N3V4-CELL-O0EQ-LOW-ENDPOINT",
      equilibrium_id = "N3V4-EQ-O0EQ-LOW-ENDPOINT",
      branch = "low",
      conditions = c("o_0=1/m<o_1", "nu=0"),
      classification = "measure-zero low-type-only endpoint; its proposer payoff ties exclusion and the minimum-expected-H proposal tie-break selects it"
    ),
    list(
      cell_id = "N3V4-CELL-O0EQ-EXCLUDE",
      equilibrium_id = "N3V4-EQ-O0EQ-EXCLUDE",
      branch = "exclude",
      conditions = c("o_0=1/m<o_1", "0<nu<=1"),
      classification = "R1 passage without H at y=0"
    ),
    list(
      cell_id = "N3V4-CELL-O1EQ-LOW",
      equilibrium_id = "N3V4-EQ-O1EQ-LOW",
      branch = "low",
      conditions = c("o_0<o_1=1/m", paste0("0<=nu<=", nu_se)),
      classification = "low-type-only R1 passage with H; the high type delays to N1; the S/(E=P) equality is assigned here by the minimum-expected-H proposal tie-break"
    ),
    list(
      cell_id = "N3V4-CELL-O1EQ-EXCLUDE",
      equilibrium_id = "N3V4-EQ-O1EQ-EXCLUDE",
      branch = "exclude",
      conditions = c("o_0<o_1=1/m", paste0(nu_se, "<nu<=1"), paste0(h_e, "<", h_p)),
      classification = "measure-zero residual E=P proposer-payoff tie; exclusion uniquely minimizes expected H payoff"
    ),
    list(
      cell_id = "N3V4-CELL-O1EQ-POOL",
      equilibrium_id = "N3V4-EQ-O1EQ-POOL",
      branch = "pool",
      conditions = c("o_0<o_1=1/m", paste0(nu_se, "<nu<=1"), paste0(h_p, "<", h_e)),
      classification = "measure-zero residual E=P proposer-payoff tie; pooling uniquely minimizes expected H payoff"
    ),
    list(
      cell_id = "N3V4-CELL-O1EQ-MIXED-EP",
      equilibrium_id = "N3V4-EQ-O1EQ-MIXED-EP",
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
    list("N3V4-C01", "continuation", "N1-EQ-01 supplies 1/m to each weak state and o_theta to H in R2 current units; beta is applied exactly once in R1."),
    list("N3V4-C02", "weak ballot", "A weak nonproposer votes yes if and only if x_j>=beta/m, with T^Y selecting yes at equality."),
    list("N3V4-C03", "H ballot", "H's complete best-response map covers nonpivotal passage, pivotal passage, and inevitable failure after every feasible proposal."),
    list("N3V4-C04", "proposer deviations", "The closed proposer-payoff map covers every feasible proposal and both types under the true prior."),
    list("N3V4-C05", "candidate reduction", "Every payoff-maximizing pure proposal reduces to exclusion, low-type-only, or pooling; deliberate failure remains in the deviation set."),
    list("N3V4-C06", "P0", "Every selected proposal exhausts the pie because increasing the proposer residual preserves the belief-invariant response and outcome maps induced by frozen N1; no on-path slack survives."),
    list("N3V4-C07", "P1 and P1a", "Every pass-without-H proposal with y>0 is strictly dominated by shifting y to r_i, so every selected exclusion proposal has y=0."),
    list("N3V4-C08", "delay", "Deliberate failure pays beta/m and is strictly dominated by exclusion by 1-beta*q/m>0; screening delay survives with probability nu in selected low-type-only cells."),
    list("N3V4-C09", "feasibility", "Every selected low-type-only, pooling, and exclusion candidate is strictly feasible in its declared cell."),
    list("N3V4-C10", "partition", "The eleven cells are mutually exclusive and exhaustive over all admissible primitives and nu, including every equality and endpoint."),
    list("N3V4-C11", "o_1=1/m", "The residual E=P proposer-payoff tie is resolved by the expected-H comparison, with both branches and every mixture retained at exact equality."),
    list("N3V4-C12", "multiplicity", "All coalition identities, pure proposer-identity assignments, and proposer mixtures are parameterized without a symmetry restriction."),
    list("N3V4-C13", "beliefs", "Positive-probability proposals obey Bayes, zero-prior type strategies remain specified, and every zero-probability proposal-vote vector has an explicit unrestricted posterior at every nu."),
    list("N3V4-C14", "P7", "The public H vote enters every positive-probability posterior update; weak votes are type-independent."),
    list("N3V4-C15", "weak payoff map", "Each record exports the complete identity-indexed pre-recognition weak payoff map."),
    list("N3V4-C16", "transport sufficiency", "Every symbol in admissibility_conditions, selection_status, hegemon_payoff_by_type, and outcome_distribution is primitive or defined inside that transported record."),
    list("N3V4-C17", "existence", "An equilibrium exists throughout the declared domain; there is no nonexistence cell under beta in (0,1).")
  )

  ledger <- list(
    schema_version = "essential-input-claim-ledger-v4",
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
          "model_redesign/essential_input_n3_r1_majority_derivation_v4.md#claim-",
          tolower(entry[[1L]])
        )
      )
    })
  )

  list(interface = interface, ledger = ledger)
}


oracle_validate_n1 <- function(n1, n1_hash, n1_path = NULL) {
  if (!is.null(n1_path)) {
    oracle_assert(
      identical(oracle_sha256_file(n1_path), sub("^sha256:", "", n1_hash)),
      "Oracle received bytes other than frozen N1."
    )
  }
  oracle_assert(identical(n1$schema_ref, "equilibrium_correspondence_v1"), "N1 schema changed.")
  oracle_assert(length(n1$correspondence_cells) == 1L, "N1 is not singleton.")
  record <- n1$correspondence_cells[[1L]]$equilibrium_records[[1L]]
  oracle_assert(identical(record$equilibrium_id, "N1-EQ-01"), "Wrong N1 record.")
  oracle_assert(identical(record$recognized_proposer_payoff, "1"), "Wrong N1 proposer value.")
  oracle_assert(
    identical(record$weak_nonproposer_pre_recognition_expected_value, "1/m"),
    "Wrong N1 weak continuation."
  )
  oracle_assert(
    identical(record$hegemon_payoff_by_type, list(theta_0 = "o_0", theta_1 = "o_1")),
    "Wrong N1 H continuation."
  )
  oracle_assert(
    identical(
      record$outcome_distribution,
      list(pass_with_hegemon = 0L, pass_without_hegemon = 1L, failure = 0L, delay = 0L)
    ),
    "Wrong N1 outcome."
  )
  oracle_assert(identical(record$payoff_date, "R2 current units"), "Wrong N1 payoff date.")
  invisible(TRUE)
}

oracle_values <- function(N, beta, o0, o1, nu) {
  m <- N - 1
  q <- floor(N / 2) + 1
  c_value <- beta / m
  e_value <- 1 - beta * (q - 1) / m
  l_value <- 1 - beta * o0 - beta * (q - 2) / m
  p_value <- 1 - beta * o1 - beta * (q - 2) / m
  s_value <- (1 - nu) * l_value + nu * c_value
  h_e <- (1 - nu) * o0 + nu * o1
  h_s <- beta * h_e
  h_p <- beta * o1
  h_r <- beta * h_e
  list(
    m = m,
    q = q,
    c = c_value,
    E = e_value,
    L = l_value,
    S = s_value,
    P = p_value,
    R = c_value,
    h = c(E = h_e, S = h_s, P = h_p, R = h_r)
  )
}

oracle_selected_branches <- function(N, beta, o0, o1, nu, tolerance = 1e-10) {
  value <- oracle_values(N, beta, o0, o1, nu)
  proposer <- c(E = value$E, S = value$S, P = value$P, R = value$R)
  feasible <- c(
    E = TRUE,
    S = beta * o0 + beta * (value$q - 2) / value$m <= 1 + tolerance,
    P = beta * o1 + beta * (value$q - 2) / value$m <= 1 + tolerance,
    R = TRUE
  )
  proposer[!feasible] <- -Inf
  maximum <- max(proposer)
  payoff_ties <- names(proposer)[abs(proposer - maximum) <= tolerance]
  minimum_h <- min(value$h[payoff_ties])
  sort(payoff_ties[abs(value$h[payoff_ties] - minimum_h) <= tolerance])
}

oracle_expected_cell <- function(N, beta, o0, o1, nu, tolerance = 1e-10) {
  m <- N - 1
  inverse_m <- 1 / m
  q <- floor(N / 2) + 1
  if (o1 < inverse_m - tolerance) {
    frontier <- beta * (o1 - o0) /
      (1 - beta * o0 - beta * (q - 1) / m)
    return(if (nu <= frontier + tolerance) "N3V4-CELL-O1LT-LOW" else "N3V4-CELL-O1LT-POOL")
  }
  if (abs(o1 - inverse_m) <= tolerance) {
    frontier <- beta * (inverse_m - o0) /
      (beta * (inverse_m - o0) + 1 - beta * q / m)
    if (nu <= frontier + tolerance) return("N3V4-CELL-O1EQ-LOW")
    h_e <- (1 - nu) * o0 + nu / m
    h_p <- beta / m
    if (h_e < h_p - tolerance) return("N3V4-CELL-O1EQ-EXCLUDE")
    if (h_p < h_e - tolerance) return("N3V4-CELL-O1EQ-POOL")
    return("N3V4-CELL-O1EQ-MIXED-EP")
  }
  if (o0 < inverse_m - tolerance && inverse_m < o1 - tolerance) {
    frontier <- beta * (inverse_m - o0) /
      (beta * (inverse_m - o0) + 1 - beta * q / m)
    return(if (nu <= frontier + tolerance) "N3V4-CELL-CROSS-LOW" else "N3V4-CELL-CROSS-EXCLUDE")
  }
  if (abs(o0 - inverse_m) <= tolerance) {
    return(if (nu <= tolerance) "N3V4-CELL-O0EQ-LOW-ENDPOINT" else "N3V4-CELL-O0EQ-EXCLUDE")
  }
  "N3V4-CELL-O0GT-EXCLUDE"
}

oracle_branch_from_cell <- function(cell_id) {
  if (grepl("MIXED-EP$", cell_id)) return("mixed_ep")
  if (grepl("LOW", cell_id)) return("low")
  if (grepl("POOL$", cell_id)) return("pool")
  if (grepl("EXCLUDE$", cell_id)) return("exclude")
  stop(paste("Unknown oracle cell:", cell_id), call. = FALSE)
}

oracle_expected_selected_set <- function(cell_id) {
  branch <- oracle_branch_from_cell(cell_id)
  switch(branch, low = "S", pool = "P", exclude = "E", mixed_ep = c("E", "P"))
}

oracle_vote_outcome <- function(N, beta, o_theta, y, weak_yes_count) {
  q <- floor(N / 2) + 1
  yes_if_h_yes <- 1 + weak_yes_count + 1
  yes_if_h_no <- 1 + weak_yes_count
  pass_if_yes <- yes_if_h_yes >= q
  pass_if_no <- yes_if_h_no >= q
  h_yes_payoff <- if (pass_if_yes) y else beta * o_theta
  h_no_payoff <- if (pass_if_no) y + o_theta else beta * o_theta
  if (h_yes_payoff > h_no_payoff) {
    h_vote <- "yes"
  } else if (h_no_payoff > h_yes_payoff) {
    h_vote <- "no"
  } else {
    h_vote <- "yes"
  }
  passes <- if (identical(h_vote, "yes")) pass_if_yes else pass_if_no
  list(
    h_vote = h_vote,
    passes = passes,
    with_h = passes && identical(h_vote, "yes"),
    without_h = passes && identical(h_vote, "no"),
    h_payoff = if (identical(h_vote, "yes")) h_yes_payoff else h_no_payoff
  )
}

oracle_weak_payoffs <- function(N, beta, x_j, other_yes_excluding_proposer_and_j) {
  m <- N - 1
  q <- floor(N / 2) + 1
  yes_count_if_yes <- 1 + other_yes_excluding_proposer_and_j + 1
  yes_count_if_no <- 1 + other_yes_excluding_proposer_and_j
  payoff_yes <- if (yes_count_if_yes >= q) x_j else beta / m
  payoff_no <- if (yes_count_if_no >= q) x_j else beta / m
  c(yes = payoff_yes, no = payoff_no)
}

oracle_stage_undominated_weak_vote <- function(N, beta, x_j) {
  profiles <- lapply(
    0:(N - 2),
    function(other_yes) oracle_weak_payoffs(N, beta, x_j, other_yes)
  )
  payoff_yes <- vapply(profiles, function(payoff) payoff[["yes"]], numeric(1))
  payoff_no <- vapply(profiles, function(payoff) payoff[["no"]], numeric(1))
  yes_dominates <- all(payoff_yes >= payoff_no) && any(payoff_yes > payoff_no)
  no_dominates <- all(payoff_no >= payoff_yes) && any(payoff_no > payoff_yes)
  if (yes_dominates) return("yes")
  if (no_dominates) return("no")
  oracle_assert(all(payoff_yes == payoff_no), "Weak actions are incomparable rather than genuinely tied.")
  "yes"
}

oracle_offer <- function(branch, N, beta, o0, o1) {
  m <- N - 1
  q <- floor(N / 2) + 1
  c_value <- beta / m
  if (identical(branch, "low")) {
    return(list(y = beta * o0, paid = q - 2, x = c_value, r = 1 - beta * o0 - beta * (q - 2) / m))
  }
  if (identical(branch, "pool")) {
    return(list(y = beta * o1, paid = q - 2, x = c_value, r = 1 - beta * o1 - beta * (q - 2) / m))
  }
  if (identical(branch, "exclude")) {
    return(list(y = 0, paid = q - 1, x = c_value, r = 1 - beta * (q - 1) / m))
  }
  stop("Mixed branch has two offer families.", call. = FALSE)
}

oracle_offer_semantics <- function(branch) {
  if (identical(branch, "low")) {
    return(list(
      payoff = "(1-nu)*(1-beta*o_0-beta*(q-2)/m)+nu*beta/m",
      family = "y=beta*o_0; x_j=beta/m iff j in K and x_j=0 otherwise; r_i=1-beta*o_0-beta*(q-2)/m.",
      coalition = "|K|=q-2"
    ))
  }
  if (identical(branch, "pool")) {
    return(list(
      payoff = "1-beta*o_1-beta*(q-2)/m",
      family = "y=beta*o_1; x_j=beta/m iff j in K and x_j=0 otherwise; r_i=1-beta*o_1-beta*(q-2)/m.",
      coalition = "|K|=q-2"
    ))
  }
  if (identical(branch, "exclude")) {
    return(list(
      payoff = "1-beta*(q-1)/m",
      family = "y=0; x_j=beta/m iff j in K and x_j=0 otherwise; r_i=1-beta*(q-1)/m.",
      coalition = "|K|=q-1"
    ))
  }
  list(
    payoff = "1-beta*(q-1)/m",
    family = "y=0",
    family_two = "y=beta/m",
    coalition = "exclusion uses |K|=q-1 and pooling uses |T|=q-2"
  )
}

oracle_weak_formula <- function(branch) {
  if (identical(branch, "low")) {
    return(paste0(
      "C_l=(1/m)*[(1-nu)*(1-beta*o_0-beta*(q-2)/m)+nu*beta/m] + ",
      "(1/m)*sum_{i in W, i!=l}{(1-nu)*(beta/m)*sum_{K subset W\\{i}, |K|=q-2, l in K}omega_{i,K} + nu*beta/m}; ",
      "for each i, omega_{i,K}>=0 and sum_{K subset W\\{i}, |K|=q-2}omega_{i,K}=1"
    ))
  }
  if (identical(branch, "pool")) {
    return(paste0(
      "C_l=(1/m)*[1-beta*o_1-beta*(q-2)/m] + ",
      "(1/m)*sum_{i in W, i!=l}{(beta/m)*sum_{K subset W\\{i}, |K|=q-2, l in K}omega_{i,K}}; ",
      "for each i, omega_{i,K}>=0 and sum_{K subset W\\{i}, |K|=q-2}omega_{i,K}=1"
    ))
  }
  if (identical(branch, "exclude")) {
    return(paste0(
      "C_l=(1/m)*[1-beta*(q-1)/m] + ",
      "(1/m)*sum_{i in W, i!=l}{(beta/m)*sum_{K subset W\\{i}, |K|=q-1, l in K}omega_{i,K}}; ",
      "for each i, omega_{i,K}>=0 and sum_{K subset W\\{i}, |K|=q-1}omega_{i,K}=1"
    ))
  }
  paste0(
    "C_l=(1/m)*[1-beta*(q-1)/m] + (1/m)*sum_{i in W, i!=l}{(beta/m)*[",
    "sum_{K subset W\\{i}, |K|=q-1, l in K}e_{i,K}+",
    "sum_{T subset W\\{i}, |T|=q-2, l in T}p_{i,T}]}; for each i all e and p are nonnegative and ",
    "sum_{K subset W\\{i}, |K|=q-1}e_{i,K}+sum_{T subset W\\{i}, |T|=q-2}p_{i,T}=1"
  )
}

oracle_h_and_outcome <- function(branch) {
  if (identical(branch, "low")) {
    return(list(
      h = list(theta_0 = "beta*o_0", theta_1 = "beta*o_1"),
      outcome = list(pass_with_hegemon = "1-nu", pass_without_hegemon = 0L, failure = 0L, delay = "nu")
    ))
  }
  if (identical(branch, "pool")) {
    return(list(
      h = list(theta_0 = "beta*o_1", theta_1 = "beta*o_1"),
      outcome = list(pass_with_hegemon = 1L, pass_without_hegemon = 0L, failure = 0L, delay = 0L)
    ))
  }
  if (identical(branch, "exclude")) {
    return(list(
      h = list(theta_0 = "o_0", theta_1 = "o_1"),
      outcome = list(pass_with_hegemon = 0L, pass_without_hegemon = 1L, failure = 0L, delay = 0L)
    ))
  }
  NULL
}

oracle_validate_record <- function(record, branch, n1_hash) {
  oracle_assert(
    identical(record$source_continuation_record_ids, list("N1-EQ-01")) &&
      identical(record$source_interface_hashes, list(N1 = n1_hash)),
    paste("Oracle found wrong N1 source in", record$equilibrium_id)
  )
  semantics <- oracle_offer_semantics(branch)
  oracle_assert(
    identical(record$recognized_proposer_payoff, semantics$payoff),
    paste("Oracle rejected proposer payoff in", record$equilibrium_id)
  )
  proposal <- record$strategy_profile$selected_proposal_parameterization
  oracle_assert(
    grepl(semantics$family, proposal$family, fixed = TRUE) &&
      identical(proposal$coalition_size, semantics$coalition),
    paste("Oracle rejected selected offer in", record$equilibrium_id)
  )
  if (identical(branch, "mixed_ep")) {
    oracle_assert(
      grepl(semantics$family_two, proposal$family, fixed = TRUE),
      "Oracle rejected the second mixed-cell offer."
    )
  }
  oracle_assert(
    identical(
      record$weak_nonproposer_pre_recognition_expected_value$by_weak_state_l,
      oracle_weak_formula(branch)
    ),
    paste("Oracle rejected identity-indexed weak map in", record$equilibrium_id)
  )
  if (!identical(branch, "mixed_ep")) {
    expected <- oracle_h_and_outcome(branch)
    oracle_assert(
      identical(record$hegemon_payoff_by_type, expected$h) &&
        identical(record$outcome_distribution, expected$outcome),
      paste("Oracle rejected H payoff or outcome in", record$equilibrium_id)
    )
  } else {
    mixed_text <- paste(
      c(
        oracle_as_character(record$hegemon_payoff_by_type),
        oracle_as_character(record$outcome_distribution)
      ),
      collapse = " "
    )
    oracle_assert(
      grepl("e_{i,K}", mixed_text, fixed = TRUE) &&
        grepl("p_{i,T}", mixed_text, fixed = TRUE) &&
        grepl("o_1=1/m", mixed_text, fixed = TRUE) &&
        grepl("add to 1", record$hegemon_payoff_by_type$theta_0, fixed = TRUE),
      "Oracle rejected mixed-cell H payoff/outcomes."
    )
  }

  belief <- record$belief_system
  oracle_assert(
    grepl("arbitrary ballot belief kappa_i(s) in [0,1]", belief$zero_weight_proposal, fixed = TRUE),
    paste("Oracle rejected proposal-stage off-path belief in", record$equilibrium_id)
  )
  oracle_assert(
    grepl("every nu in [0,1] including nu>0", belief$zero_probability_proposal_vote_vectors, fixed = TRUE) &&
      grepl("eta_i(s,v) in [0,1]", belief$zero_probability_proposal_vote_vectors, fixed = TRUE),
    paste("Oracle found incomplete proposal-vote posterior in", record$equilibrium_id)
  )
  if (identical(branch, "low")) {
    oracle_assert(
      grepl("posterior at 1", belief$published_vote_vector, fixed = TRUE) &&
        !grepl("posterior at 0", belief$published_vote_vector, fixed = TRUE),
      paste("Oracle rejected Bayes posterior after positive failure in", record$equilibrium_id)
    )
  }
  invisible(TRUE)
}

oracle_validate_candidate <- function(candidate, n1, n1_hash, n1_path = NULL) {
  oracle_validate_n1(n1, n1_hash, n1_path)
  oracle_assert(identical(candidate$schema_ref, "equilibrium_correspondence_v1"), "Wrong N3 schema.")
  oracle_assert(
    identical(candidate$function_of, list(name = "entry_belief", domain = "[0,1]")),
    "Wrong N3 function_of."
  )
  expected_cells <- c(
    "N3V4-CELL-O1LT-LOW",
    "N3V4-CELL-O1LT-POOL",
    "N3V4-CELL-CROSS-LOW",
    "N3V4-CELL-CROSS-EXCLUDE",
    "N3V4-CELL-O0GT-EXCLUDE",
    "N3V4-CELL-O0EQ-LOW-ENDPOINT",
    "N3V4-CELL-O0EQ-EXCLUDE",
    "N3V4-CELL-O1EQ-LOW",
    "N3V4-CELL-O1EQ-EXCLUDE",
    "N3V4-CELL-O1EQ-POOL",
    "N3V4-CELL-O1EQ-MIXED-EP"
  )
  actual_cells <- vapply(candidate$correspondence_cells, function(cell) cell$cell_id, character(1))
  oracle_assert(identical(actual_cells, expected_cells), "Oracle rejected the eleven-cell partition.")
  for (cell in candidate$correspondence_cells) {
    oracle_assert(
      identical(cell$existence_status, "exists") &&
        length(cell$equilibrium_records) == 1L &&
        is.null(cell$nonexistence_certificate),
      paste("Oracle rejected coverage envelope", cell$cell_id)
    )
    oracle_validate_record(
      cell$equilibrium_records[[1L]],
      oracle_branch_from_cell(cell$cell_id),
      n1_hash
    )
  }
  invisible(TRUE)
}

oracle_coalitions <- function(players, size) {
  if (size == 0L) return(list(integer(0)))
  matrix_value <- utils::combn(players, size)
  if (is.null(dim(matrix_value))) return(list(as.integer(matrix_value)))
  lapply(seq_len(ncol(matrix_value)), function(column) matrix_value[, column])
}

oracle_weights <- function(coalitions) {
  raw <- seq_along(coalitions)^2
  raw / sum(raw)
}

oracle_direct_weak_values <- function(branch, N, beta, o0, o1, nu) {
  m <- N - 1
  q <- floor(N / 2) + 1
  c_value <- beta / m
  result <- numeric(m)
  for (proposer in seq_len(m)) {
    others <- setdiff(seq_len(m), proposer)
    size <- if (identical(branch, "exclude")) q - 1 else q - 2
    coalitions <- oracle_coalitions(others, size)
    weights <- oracle_weights(coalitions)
    offer <- oracle_offer(branch, N, beta, o0, o1)
    for (weak_state in seq_len(m)) {
      if (weak_state == proposer) {
        payoff <- if (identical(branch, "low")) {
          (1 - nu) * offer$r + nu * c_value
        } else {
          offer$r
        }
      } else {
        payoff <- 0
        for (index in seq_along(coalitions)) {
          included <- weak_state %in% coalitions[[index]]
          state_zero <- if (included) c_value else 0
          state_one <- if (identical(branch, "low")) c_value else state_zero
          payoff <- payoff + weights[[index]] * ((1 - nu) * state_zero + nu * state_one)
        }
      }
      result[[weak_state]] <- result[[weak_state]] + payoff / m
    }
  }
  result
}

oracle_closed_weak_values <- function(branch, N, beta, o0, o1, nu) {
  m <- N - 1
  q <- floor(N / 2) + 1
  c_value <- beta / m
  offer <- oracle_offer(branch, N, beta, o0, o1)
  result <- numeric(m)
  for (weak_state in seq_len(m)) {
    proposer_component <- if (identical(branch, "low")) {
      (1 - nu) * offer$r + nu * c_value
    } else {
      offer$r
    }
    value <- proposer_component / m
    for (proposer in setdiff(seq_len(m), weak_state)) {
      others <- setdiff(seq_len(m), proposer)
      size <- if (identical(branch, "exclude")) q - 1 else q - 2
      coalitions <- oracle_coalitions(others, size)
      weights <- oracle_weights(coalitions)
      inclusion <- sum(weights[vapply(coalitions, function(group) weak_state %in% group, logical(1))])
      nonproposer <- if (identical(branch, "low")) {
        (1 - nu) * c_value * inclusion + nu * c_value
      } else {
        c_value * inclusion
      }
      value <- value + nonproposer / m
    }
    result[[weak_state]] <- value
  }
  result
}

oracle_run_stress <- function(draws = 50000L) {
  for (N in 3:30) {
    m <- N - 1
    q <- floor(N / 2) + 1
    oracle_assert(q <= m, "Majority quota exceeds weak states.")
    for (beta in c(0.01, 0.2, 0.5, 0.9, 0.999999)) {
      oracle_assert(1 - beta * q / m > 0, "Strict beta failed to make exclusion dominate delay.")
      for (x_j in c(0, beta / m - 1e-9, beta / m, beta / m + 1e-9, 1)) {
        if (x_j < 0) next
        expected <- if (x_j + 1e-12 >= beta / m) "yes" else "no"
        oracle_assert(
          identical(oracle_stage_undominated_weak_vote(N, beta, x_j), expected),
          "Enumerated stage game violates the beta/m weak cutoff."
        )
        for (other_yes in 0:(N - 2)) {
          payoff <- oracle_weak_payoffs(N, beta, x_j, other_yes)
          oracle_assert(
            all(is.finite(payoff)) && length(payoff) == 2L,
            "A simultaneous weak-vote profile lacks a payoff."
          )
        }
      }
      for (o_theta in c(0.01, 0.25, 0.75, 0.99)) {
        for (weak_yes in 0:(m - 1)) {
          for (y in unique(c(0, beta * o_theta / 2, beta * o_theta, min(1, beta * o_theta + 0.1)))) {
            ballot <- oracle_vote_outcome(N, beta, o_theta, y, weak_yes)
            if (weak_yes >= q - 1) {
              oracle_assert(identical(ballot$h_vote, "no") && ballot$without_h, "Nonpivotal H branch failed.")
            } else if (weak_yes == q - 2) {
              expected_vote <- if (y + 1e-12 >= beta * o_theta) "yes" else "no"
              oracle_assert(identical(ballot$h_vote, expected_vote), "Pivotal H cutoff failed.")
            } else {
              oracle_assert(identical(ballot$h_vote, "yes") && !ballot$passes, "Inevitable-failure H branch failed.")
            }
          }
        }
      }
    }
  }

  set.seed(20260819)
  for (iteration in seq_len(draws)) {
    N <- sample(3:60, 1L)
    beta <- stats::runif(1L, 0.0001, 0.9999)
    outside <- sort(stats::runif(2L, 0.0001, 0.9999))
    if (outside[[1L]] == outside[[2L]]) next
    o0 <- outside[[1L]]
    o1 <- outside[[2L]]
    nu <- stats::runif(1L)
    expected_cell <- oracle_expected_cell(N, beta, o0, o1, nu)
    expected_set <- sort(oracle_expected_selected_set(expected_cell))
    optimized <- oracle_selected_branches(N, beta, o0, o1, nu)
    oracle_assert(identical(expected_set, optimized), "Oracle region disagrees with direct argmax.")
    values <- oracle_values(N, beta, o0, o1, nu)
    oracle_assert(
      abs((values$P - values$E) - beta * (1 / values$m - o1)) < 1e-12,
      "P-E identity failed."
    )
    oracle_assert(
      abs((values$S - values$E) -
        ((1 - nu) * beta * (1 / values$m - o0) - nu * (1 - beta * values$q / values$m))) < 1e-12,
      "S-E identity failed."
    )
  }

  fixtures <- list(
    list(N = 9L, beta = 0.8, o0 = 0.03, o1 = 0.08),
    list(N = 9L, beta = 0.8, o0 = 0.08, o1 = 0.2)
  )
  for (fixture in fixtures) {
    N <- fixture$N
    m <- N - 1
    q <- floor(N / 2) + 1
    beta <- fixture$beta
    o0 <- fixture$o0
    o1 <- fixture$o1
    frontier <- if (o1 < 1 / m) {
      beta * (o1 - o0) / (1 - beta * o0 - beta * (q - 1) / m)
    } else {
      beta * (1 / m - o0) / (beta * (1 / m - o0) + 1 - beta * q / m)
    }
    oracle_assert(frontier > 0 && frontier < 1, "Frontier left the interior.")
    oracle_assert(identical(oracle_selected_branches(N, beta, o0, o1, frontier), "S"), "Closed frontier lost low branch.")
  }

  N <- 9L
  m <- N - 1
  q <- floor(N / 2) + 1
  beta <- 0.8
  o0_low <- 0.03
  o1_low <- 0.08
  nu_sp <- beta * (o1_low - o0_low) /
    (1 - beta * o0_low - beta * (q - 1) / m)
  oracle_assert(
    identical(oracle_expected_cell(N, beta, o0_low, o1_low, nu_sp), "N3V4-CELL-O1LT-LOW") &&
      identical(oracle_expected_cell(N, beta, o0_low, o1_low, min(1, nu_sp + 1e-6)), "N3V4-CELL-O1LT-POOL"),
    "nu_SP boundary ownership failed."
  )

  o0_cross <- 0.08
  o1_cross <- 0.2
  nu_se_cross <- beta * (1 / m - o0_cross) /
    (beta * (1 / m - o0_cross) + 1 - beta * q / m)
  oracle_assert(
    identical(oracle_expected_cell(N, beta, o0_cross, o1_cross, nu_se_cross), "N3V4-CELL-CROSS-LOW") &&
      identical(oracle_expected_cell(N, beta, o0_cross, o1_cross, min(1, nu_se_cross + 1e-6)), "N3V4-CELL-CROSS-EXCLUDE"),
    "nu_SE boundary ownership failed."
  )
  oracle_assert(
    identical(oracle_expected_cell(N, beta, 0.2, 0.3, 0), "N3V4-CELL-O0GT-EXCLUDE") &&
      identical(oracle_expected_cell(N, beta, 0.2, 0.3, 1), "N3V4-CELL-O0GT-EXCLUDE"),
    "Strict o_0>1/m endpoint coverage failed."
  )
  oracle_assert(
    identical(oracle_expected_cell(N, beta, 1 / m, 0.2, 0), "N3V4-CELL-O0EQ-LOW-ENDPOINT") &&
      identical(oracle_expected_cell(N, beta, 1 / m, 0.2, 1), "N3V4-CELL-O0EQ-EXCLUDE"),
    "o_0=1/m endpoint coverage failed."
  )

  o0_equal <- 0.08
  o1_equal <- 1 / m
  nu_se_equal <- beta * (1 / m - o0_equal) /
    (beta * (1 / m - o0_equal) + 1 - beta * q / m)
  nu_h <- (beta / m - o0_equal) / (1 / m - o0_equal)
  oracle_assert(nu_se_equal < nu_h && nu_h < 1, "Residual E/P tie is outside its cell.")
  oracle_assert(
    identical(oracle_expected_cell(N, beta, o0_equal, o1_equal, nu_se_equal), "N3V4-CELL-O1EQ-LOW") &&
      identical(oracle_expected_cell(N, beta, o0_equal, o1_equal, (nu_se_equal + nu_h) / 2), "N3V4-CELL-O1EQ-EXCLUDE") &&
      identical(oracle_expected_cell(N, beta, o0_equal, o1_equal, nu_h), "N3V4-CELL-O1EQ-MIXED-EP") &&
      identical(oracle_expected_cell(N, beta, o0_equal, o1_equal, (nu_h + 1) / 2), "N3V4-CELL-O1EQ-POOL"),
    "o_1=1/m low/exclusion/mixed/pooling coverage failed."
  )

  for (branch in c("low", "pool", "exclude")) {
    direct <- oracle_direct_weak_values(branch, 9L, 0.8, 0.04, 0.2, 0.37)
    closed <- oracle_closed_weak_values(branch, 9L, 0.8, 0.04, 0.2, 0.37)
    oracle_assert(max(abs(direct - closed)) < 1e-12, paste("Weak identity map failed for", branch))
  }

  o0 <- o0_equal
  o1 <- o1_equal
  pooling_share <- mean(c(0, 0.1, 0.25, 0.4, 0.6, 0.75, 0.9, 1))
  exclusion_share <- 1 - pooling_share
  h0 <- exclusion_share * o0 + pooling_share * beta / m
  h1 <- exclusion_share * o1 + pooling_share * beta / m
  expected_h <- (1 - nu_h) * h0 + nu_h * h1
  oracle_assert(abs(expected_h - beta / m) < 1e-12, "Mixed-cell expected H is not invariant.")
  oracle_assert(abs(pooling_share + exclusion_share - 1) < 1e-12, "Mixed outcomes do not sum to one.")
  invisible(TRUE)
}

oracle_direct_execution <- function() {
  script_arguments <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  length(script_arguments) == 1L &&
    identical(basename(sub("^--file=", "", script_arguments)), "oracle_essential_input_n3_v4.R")
}

oracle_main <- function() {
  script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  oracle_assert(length(script_argument) == 1L, "Could not resolve oracle path.")
  script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
  repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
  candidate_path <- file.path(
    repository_root,
    "model_redesign",
    "essential_input_interfaces",
    "n3_r1_majority_candidate_v4.json"
  )
  n1_path <- file.path(
    repository_root,
    "model_redesign",
    "essential_input_interfaces",
    "n1_r2_majority_candidate_v1.json"
  )
  n1_hash <- "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
  oracle_assert(file.exists(candidate_path) && file.exists(n1_path), "Oracle input missing.")
  candidate <- jsonlite::fromJSON(candidate_path, simplifyVector = FALSE)
  n1 <- jsonlite::fromJSON(n1_path, simplifyVector = FALSE)
  oracle_validate_candidate(candidate, n1, n1_hash, n1_path)
  oracle_run_stress()
  cat("PASS: independent N3 v4 algebraic oracle reconstructed N1 transport, ballots, offers, regions, identity maps, H payoffs, outcomes, and boundaries.\n")
}

# Preserve the local algebraic checks, then strengthen them with a complete
# independently reconstructed reference. This script never sources or reads a
# builder, a builder object, or a previous N3 candidate.
oracle_validate_candidate_local_v4 <- oracle_validate_candidate

oracle_json_roundtrip <- function(object) {
  encoded <- jsonlite::toJSON(
    object,
    auto_unbox = TRUE,
    null = "null",
    na = "null",
    digits = NA,
    pretty = FALSE
  )
  jsonlite::fromJSON(encoded, simplifyVector = FALSE)
}

oracle_child_path <- function(parent, child_name, index) {
  if (!is.null(child_name) && nzchar(child_name)) {
    if (identical(parent, "$")) paste0("$", child_name) else paste0(parent, "$", child_name)
  } else {
    paste0(parent, "[[", index, "]]")
  }
}

oracle_flatten_leaves <- function(object, path = "$") {
  if (is.null(object)) {
    return(list(list(path = path, type = "NULL", value = NULL)))
  }
  if (is.list(object)) {
    if (length(object) == 0L) {
      return(list(list(path = path, type = "empty-list", value = list())))
    }
    result <- list()
    object_names <- names(object)
    for (index in seq_along(object)) {
      child_name <- if (is.null(object_names)) NULL else object_names[[index]]
      child_path <- oracle_child_path(path, child_name, index)
      result <- c(result, oracle_flatten_leaves(object[[index]], child_path))
    }
    return(result)
  }
  if (length(object) == 0L) {
    return(list(list(path = path, type = paste0("empty-", typeof(object)), value = object)))
  }
  if (length(object) > 1L) {
    result <- list()
    for (index in seq_along(object)) {
      result <- c(result, oracle_flatten_leaves(object[[index]], paste0(path, "[[", index, "]]")))
    }
    return(result)
  }
  list(list(path = path, type = typeof(object), value = object))
}

oracle_first_difference <- function(actual, expected, path = "$") {
  if (is.null(actual) || is.null(expected)) {
    if (is.null(actual) && is.null(expected)) return(NULL)
    return(paste0(path, ": NULL mismatch"))
  }
  if (!identical(typeof(actual), typeof(expected))) {
    return(paste0(path, ": type ", typeof(actual), " != ", typeof(expected)))
  }
  if (is.list(actual)) {
    if (!identical(names(actual), names(expected))) {
      return(paste0(path, ": field names differ"))
    }
    if (length(actual) != length(expected)) {
      return(paste0(path, ": length ", length(actual), " != ", length(expected)))
    }
    if (length(actual) == 0L) return(NULL)
    object_names <- names(actual)
    for (index in seq_along(actual)) {
      child_name <- if (is.null(object_names)) NULL else object_names[[index]]
      child_path <- oracle_child_path(path, child_name, index)
      difference <- oracle_first_difference(actual[[index]], expected[[index]], child_path)
      if (!is.null(difference)) return(difference)
    }
    return(NULL)
  }
  if (!identical(actual, expected)) {
    return(paste0(
      path,
      ": ",
      paste(utils::head(as.character(actual), 2L), collapse = "|"),
      " != ",
      paste(utils::head(as.character(expected), 2L), collapse = "|")
    ))
  }
  NULL
}

oracle_assert_exact <- function(actual, expected, label) {
  difference <- oracle_first_difference(actual, expected)
  oracle_assert(is.null(difference), paste(label, "differs at", difference))
  invisible(TRUE)
}

oracle_candidate_path_category <- function(path) {
  if (grepl("\\$(schema_ref|function_of|cell_id|equilibrium_id|existence_status|nonexistence_certificate|source_continuation_record_ids|source_interface_hashes|payoff_date)", path, perl = TRUE)) {
    return("metadata_schema_source_date")
  }
  if (grepl("\\$(domain_conditions|admissibility_conditions)", path, perl = TRUE)) {
    return("domain_frontiers_endpoints")
  }
  if (grepl("\\$frozen_continuation", path, fixed = FALSE)) {
    return("frozen_continuation")
  }
  if (grepl("\\$ballot_map_after_every_feasible_proposal", path, fixed = FALSE)) {
    return("complete_ballot_map")
  }
  if (grepl("\\$(proposer_payoff_after_every_feasible_proposal|candidate_payoffs_in_primitives|recognized_proposer_payoff)", path, perl = TRUE)) {
    return("proposer_map_ESPR")
  }
  if (grepl("\\$(selected_proposal_parameterization|feasibility)", path, perl = TRUE)) {
    return("proposals_feasibility")
  }
  if (grepl("\\$belief_system", path, fixed = FALSE)) {
    return("beliefs")
  }
  if (grepl("\\$weak_nonproposer_pre_recognition_expected_value", path, fixed = FALSE)) {
    return("weak_identity_payoffs")
  }
  if (grepl("\\$hegemon_payoff_by_type", path, fixed = FALSE)) {
    return("hegemon_payoffs_mixed_coefficients")
  }
  if (grepl("\\$outcome_distribution", path, fixed = FALSE)) {
    return("outcomes")
  }
  if (grepl("\\$(branch_classification|existence_uniqueness_status|selection_status)", path, perl = TRUE)) {
    return("multiplicity_mixtures_identities")
  }
  if (grepl("\\$(assumptions_used|checks_performed)", path, perl = TRUE)) {
    return("assumptions_claim_bindings")
  }
  NA_character_
}

oracle_ledger_path_category <- function(path) {
  if (grepl("^\\$(schema_version|node|candidate_status)", path, perl = TRUE)) return("metadata")
  if (grepl("^\\$source_interface", path, perl = TRUE)) return("source")
  if (grepl("^\\$equilibrium_ids", path, perl = TRUE)) return("equilibrium_ids")
  if (grepl("^\\$claims", path, perl = TRUE)) return("claims_evidence")
  NA_character_
}

oracle_audit_path_coverage <- function(candidate, ledger = NULL) {
  candidate_leaves <- oracle_flatten_leaves(candidate)
  candidate_paths <- vapply(candidate_leaves, function(leaf) leaf$path, character(1))
  candidate_categories <- vapply(candidate_paths, oracle_candidate_path_category, character(1))
  oracle_assert(
    !anyNA(candidate_categories),
    paste(
      "Unclassified candidate semantic paths:",
      paste(candidate_paths[is.na(candidate_categories)], collapse = ", ")
    )
  )
  required_candidate_categories <- c(
    "metadata_schema_source_date",
    "domain_frontiers_endpoints",
    "frozen_continuation",
    "complete_ballot_map",
    "proposer_map_ESPR",
    "proposals_feasibility",
    "beliefs",
    "weak_identity_payoffs",
    "hegemon_payoffs_mixed_coefficients",
    "outcomes",
    "multiplicity_mixtures_identities",
    "assumptions_claim_bindings"
  )
  candidate_counts <- table(factor(candidate_categories, levels = required_candidate_categories))
  oracle_assert(all(candidate_counts > 0L), "Candidate semantic path category has zero coverage.")

  result <- list(
    candidate_paths = length(candidate_paths),
    candidate_counts = candidate_counts
  )
  if (!is.null(ledger)) {
    ledger_leaves <- oracle_flatten_leaves(ledger)
    ledger_paths <- vapply(ledger_leaves, function(leaf) leaf$path, character(1))
    ledger_categories <- vapply(ledger_paths, oracle_ledger_path_category, character(1))
    oracle_assert(
      !anyNA(ledger_categories),
      paste(
        "Unclassified ledger semantic paths:",
        paste(ledger_paths[is.na(ledger_categories)], collapse = ", ")
      )
    )
    required_ledger_categories <- c("metadata", "source", "equilibrium_ids", "claims_evidence")
    ledger_counts <- table(factor(ledger_categories, levels = required_ledger_categories))
    oracle_assert(all(ledger_counts > 0L), "Ledger semantic path category has zero coverage.")
    result$ledger_paths <- length(ledger_paths)
    result$ledger_counts <- ledger_counts
  }
  result
}

oracle_validate_candidate <- function(candidate, n1, n1_hash, n1_path = NULL) {
  oracle_validate_candidate_local_v4(candidate, n1, n1_hash, n1_path)
  reference <- oracle_reconstruct_n3_v4_objects(n1_hash)
  expected_candidate <- oracle_json_roundtrip(reference$interface)
  oracle_assert_exact(
    candidate,
    expected_candidate,
    "Independent full-leaf N3 v4 candidate reconstruction"
  )
  audit <- oracle_audit_path_coverage(candidate)
  oracle_assert(
    length(candidate$correspondence_cells) == 11L,
    "Independent reconstruction lost the eleven-cell topology."
  )
  invisible(audit)
}

oracle_validate_ledger <- function(ledger, n1_hash) {
  reference <- oracle_reconstruct_n3_v4_objects(n1_hash)
  expected_ledger <- oracle_json_roundtrip(reference$ledger)
  oracle_assert_exact(
    ledger,
    expected_ledger,
    "Independent full-leaf N3 v4 ledger reconstruction"
  )
  invisible(TRUE)
}

oracle_sha256_text <- function(text) {
  path <- tempfile("n3v4-oracle-text-", fileext = ".txt")
  on.exit(unlink(path, force = TRUE), add = TRUE)
  connection <- file(path, open = "wb")
  on.exit(close(connection), add = TRUE)
  writeBin(charToRaw(text), connection)
  close(connection)
  on.exit(NULL, add = FALSE)
  oracle_sha256_file(path)
}

oracle_claim_sections <- function(text) {
  pattern <- '<a id="claim-n3v4-c[0-9]{2}"></a>'
  positions <- gregexpr(pattern, text, perl = TRUE, useBytes = TRUE)[[1L]]
  oracle_assert(!identical(positions[[1L]], -1L), "Derivation has no claim anchors.")
  lengths <- attr(positions, "match.length")
  anchors <- substring(text, positions, positions + lengths - 1L)
  ids <- sub('.*claim-(n3v4-c[0-9]{2}).*', "\\1", anchors, perl = TRUE)
  ids <- toupper(ids)
  oracle_assert(
    length(ids) == 17L && setequal(ids, sprintf("N3V4-C%02d", 1:17)),
    "Derivation does not contain exactly the 17 required claim anchors."
  )
  sections <- vector("list", length(ids))
  names(sections) <- ids
  for (index in seq_along(ids)) {
    start <- positions[[index]]
    end <- if (index < length(ids)) positions[[index + 1L]] - 1L else nchar(text, type = "bytes")
    sections[[ids[[index]]]] <- substring(text, start, end)
  }
  sections
}

oracle_validate_derivation <- function(text) {
  expected_hash <- "94b279a98305dd0ae8aff06281ca667214cb7afaa901057431a81544044a4364"
  oracle_assert(
    identical(oracle_sha256_text(text), expected_hash),
    "Independent derivation digest rejected changed semantic prose."
  )
  sections <- oracle_claim_sections(text)
  bindings <- list(
    N3V4.C01 = c("beta/m", "beta*o_theta", "exatamente uma vez"),
    N3V4.C02 = c("x_j>=beta/m", "T^Y seleciona sim"),
    N3V4.C03 = c("k_i>=q-1", "k_i=q-2", "k_i<=q-3", "y+o_theta"),
    N3V4.C04 = c("prior verdadeiro nu", "(1-nu)*r_i+nu*beta/m"),
    N3V4.C05 = c("E = 1-beta*(q-1)/m", "S(nu)", "P = 1-beta*o_1", "R = beta/m"),
    N3V4.C06 = c("invariante à crença de ballot", "não afirma que duas propostas públicas distintas preservam"),
    N3V4.C07 = c("s'=(0,x,r_i+y)", "toda exclusão selecionada tem y=0"),
    N3V4.C08 = c("E-R = 1-beta*q/m > 0", "delay informativo"),
    N3V4.C09 = c("beta*[o_theta+(q-2)/m]", "0<=y<=y_bar"),
    N3V4.C10 = c("partição exclusiva e exaustiva", "h_E=h_P", "low-type-only"),
    N3V4.C11 = c("o_1=1/m", "todas as misturas admissíveis"),
    N3V4.C12 = c("omega_{i,K}", "e_{i,K}", "p_{i,T}", "Não há simetria imposta"),
    N3V4.C13 = c("todo nu in [0,1]", "quando nu>0", "eta_i(s,v) em [0,1]"),
    N3V4.C14 = c("posterior em um", "voto de H"),
    N3V4.C15 = c("C_l", "assimétricos entre identidades"),
    N3V4.C16 = c("U_H(0)", "pass with H", "todos os símbolos são localmente fechados"),
    N3V4.C17 = c("todo o domínio", "Não há célula none")
  )
  names(bindings) <- gsub(".", "-", names(bindings), fixed = TRUE)
  for (claim_id in names(bindings)) {
    section <- sections[[claim_id]]
    oracle_assert(!is.null(section), paste("Missing derivation section", claim_id))
    missing <- bindings[[claim_id]][!vapply(
      bindings[[claim_id]],
      function(token) grepl(token, section, fixed = TRUE, useBytes = TRUE),
      logical(1)
    )]
    oracle_assert(
      length(missing) == 0L,
      paste("Derivation claim binding failed for", claim_id, "missing", paste(missing, collapse = " | "))
    )
  }
  invisible(list(claim_sections = length(sections), digest = expected_hash))
}

oracle_main <- function() {
  script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  oracle_assert(length(script_argument) == 1L, "Could not resolve oracle path.")
  script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
  repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
  candidate_path <- file.path(
    repository_root,
    "model_redesign",
    "essential_input_interfaces",
    "n3_r1_majority_candidate_v4.json"
  )
  ledger_path <- file.path(
    repository_root,
    "model_redesign",
    "essential_input_n3_claim_ledger_v4.json"
  )
  derivation_path <- file.path(
    repository_root,
    "model_redesign",
    "essential_input_n3_r1_majority_derivation_v4.md"
  )
  n1_path <- file.path(
    repository_root,
    "model_redesign",
    "essential_input_interfaces",
    "n1_r2_majority_candidate_v1.json"
  )
  for (path in c(candidate_path, ledger_path, derivation_path, n1_path)) {
    oracle_assert(file.exists(path), paste("Oracle input missing:", path))
  }
  n1_hash <- "sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5"
  candidate <- jsonlite::fromJSON(candidate_path, simplifyVector = FALSE)
  ledger <- jsonlite::fromJSON(ledger_path, simplifyVector = FALSE)
  n1 <- jsonlite::fromJSON(n1_path, simplifyVector = FALSE)
  derivation_text <- rawToChar(readBin(
    derivation_path,
    what = "raw",
    n = file.info(derivation_path)$size
  ))
  candidate_audit <- oracle_validate_candidate(candidate, n1, n1_hash, n1_path)
  oracle_validate_ledger(ledger, n1_hash)
  full_audit <- oracle_audit_path_coverage(candidate, ledger)
  derivation_audit <- oracle_validate_derivation(derivation_text)
  oracle_run_stress()
  cat("PASS: independent N3 v4 oracle reconstructed and matched every candidate and ledger leaf.\n")
  cat(
    "SEMANTIC_PATHS_COVERED:",
    full_audit$candidate_paths,
    "candidate and",
    full_audit$ledger_paths,
    "ledger atomic paths across",
    length(full_audit$candidate_counts),
    "candidate and",
    length(full_audit$ledger_counts),
    "ledger categories.\n"
  )
  cat("DERIVATION_BINDINGS_COVERED:", derivation_audit$claim_sections, "claim sections.\n")
  invisible(candidate_audit)
}

if (oracle_direct_execution()) oracle_main()
