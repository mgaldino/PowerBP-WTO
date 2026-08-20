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

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the build-script path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
check_mode <- "--check" %in% commandArgs(trailingOnly = TRUE)

n2_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_n2_r2_unanimity_interface.json"
)
interface_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_interfaces",
  "n4_r1_unanimity_candidate_v2.json"
)
ledger_path <- file.path(
  repository_root,
  "model_redesign",
  "essential_input_n4_claim_ledger_v2.json"
)

n2_hash_bare <- "c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2"
n2_hash <- paste0("sha256:", n2_hash_bare)
n2_record_ids <- list("N2-EQ-LOW-TYPE-ONLY", "N2-EQ-POOLING")

sha256_file <- function(path) {
  shasum <- Sys.which("shasum")
  assert_true(nzchar(shasum), "The 'shasum' executable is required.")
  output <- system2(
    shasum,
    c("-a", "256", path),
    stdout = TRUE,
    stderr = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  hash_lines <- grep("^[0-9a-f]{64}[[:space:]]", output, value = TRUE)
  assert_true(length(hash_lines) == 1L, paste("Could not hash", path))
  hash <- strsplit(hash_lines[[1L]], "[[:space:]]+")[[1L]][1L]
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
  writeLines(serialized, con = path, useBytes = TRUE)
}

identical_bytes <- function(path_a, path_b) {
  if (!file.exists(path_a) || !file.exists(path_b)) return(FALSE)
  size_a <- file.info(path_a)$size
  size_b <- file.info(path_b)$size
  if (!identical(size_a, size_b)) return(FALSE)
  identical(
    readBin(path_a, what = "raw", n = size_a),
    readBin(path_b, what = "raw", n = size_b)
  )
}

assert_true(file.exists(n2_path), "Frozen N2 interface is missing.")
assert_true(
  identical(sha256_file(n2_path), n2_hash_bare),
  "N4 v2 may consume only the authorized frozen N2 bytes."
)

common_domain <- c(
  "nu is the entry belief Pr(theta=1) and 0<=nu<=1",
  "N is an integer and N>=3; W is the set of weak states; m=N-1>=2",
  "0<beta<1",
  "0<o_0<o_1<1 and o_1<=y_bar<=1",
  "for recognized weak proposer i, every proposal is s=(Y,(x_ij)_{j in W\\{i}},r_i) with 0<=Y<=y_bar, every x_ij>=0, r_i>=0, and Y+sum_{j!=i}x_ij+r_i<=1",
  "ell=beta*o_0; h=beta*o_1; a=beta*(1-o_0)/m; b=beta*(1-o_1)/m; nu_star=(o_1-o_0)/(1-o_0)",
  "D=(1-nu)*a; C=max{D,b}; P=1-h-(m-1)*b; P-b=1-beta>0",
  "the only continuation records are N2-EQ-LOW-TYPE-ONLY and N2-EQ-POOLING",
  paste0("the frozen N2 interface hash is ", n2_hash),
  "all N2 continuation payoffs are multiplied by beta exactly once on transport to R1",
  "ballot actions are pure; proposal strategies may mix only over the explicitly retained proposal supports"
)

common_assumptions <- c(
  "fixed unit pie, no side payments, no exit action, iid uniform weak-state recognition, and pi_H=0",
  "unanimity quota, full execution of Y, simultaneous sealed ballots, and public revelation of the complete vote vector",
  "PBE with stage-undominated weak voting, T^Y at exact equality, and the minimum-expected-H proposal tie-break",
  "weak proposers and weak nonproposers do not observe theta; on-path weak-vote passivity is derived by P4 and is not imposed as an assessment restriction",
  "off-path beliefs are unrestricted only at zero-probability histories and are recorded as part of each assessment",
  "frozen N2 is the sole continuation and is discounted exactly once"
)

all_claim_checks <- c(
  "N4V2-CLM-001 frozen N2 import and corrected realized maps",
  "N4V2-CLM-002 subjective weak floor versus true-prior proposer continuation",
  "N4V2-CLM-003 exact m>=3 security level",
  "N4V2-CLM-004 exact m=2 F-K-M security level",
  "N4V2-CLM-005 pooling support and endpoint attainment",
  "N4V2-CLM-006 low-type-only support and endpoint attainment",
  "N4V2-CLM-007 pure delay constructors and Y projection",
  "N4V2-CLM-008 pure ballot best responses and forbidden veto maps",
  "N4V2-CLM-009 exact delay existence",
  "N4V2-CLM-010 high-only and positive-prior low-only nonexistence",
  "N4V2-CLM-011 exhaustive within-proposer mixtures",
  "N4V2-CLM-012 Cartesian proposer-identity multiplicity",
  "N4V2-CLM-013 identity-indexed weak payoff map",
  "N4V2-CLM-014 nu=0 reporting coordinates",
  "N4V2-CLM-015 R1-event outcome partition",
  "N4V2-CLM-016 Bayes and off-path belief accounting",
  "N4V2-CLM-017 slack survival and refutation of universal P0",
  "N4V2-CLM-018 exhaustive six-cell coverage and downstream closure"
)

typed_not_applicable <- list(
  status = "not_applicable",
  reason = "category_empty"
)

none_certificate <- function(claim_ids, reason, checks) {
  list(
    ledger_claim_ids = as.list(claim_ids),
    assumptions_used = as.list(common_assumptions),
    checks_performed = as.list(c(reason, checks))
  )
}

frozen_continuation <- list(
  source_records = list(
    low_type_only = paste0("N2-EQ-LOW-TYPE-ONLY at ", n2_hash),
    pooling = paste0("N2-EQ-POOLING at ", n2_hash)
  ),
  weak_realized_payoff_by_theta_after_one_discount = list(
    low_type_only = list(theta_0 = "a", theta_1 = "0"),
    pooling = list(theta_0 = "b", theta_1 = "b")
  ),
  hegemon_payoff_by_theta_after_one_discount = list(
    low_type_only = list(theta_0 = "ell", theta_1 = "h"),
    pooling = list(theta_0 = "h", theta_1 = "h")
  ),
  proposer_true_prior_value = list(
    low_type_only = "D=(1-nu)*a",
    pooling = "b",
    selected_on_path_delay = "C=max{D,b}, with low-type-only selected at D=b"
  ),
  weak_voter_subjective_value = paste0(
    "At any successor posterior lambda, frozen N2 gives max{(1-lambda)*a,b}; ",
    "therefore its global minimum is the constant b. This subjective floor is not D."
  ),
  posterior_sufficiency = "Frozen terminal N2 and iid recognition with replacement imply that every R2 history with the same successor posterior consumes the same N2 problem; no additional public-history or identity state is imposed.",
  transport_rule = "Each displayed N2 payoff is in R1 units after exactly one multiplication by beta."
)

derived_quantities <- list(
  definitions = list(
    ell = "beta*o_0",
    h = "beta*o_1",
    a = "beta*(1-o_0)/m",
    b = "beta*(1-o_1)/m",
    nu_star = "(o_1-o_0)/(1-o_0)",
    D = "(1-nu)*a",
    C = "max{D,b}",
    P = "1-h-(m-1)*b",
    U_P = "1-(m-1)*b-S=h+P-S"
  ),
  strict_relations = c(
    "0<ell<h",
    "0<b<a",
    "0<nu_star<1",
    "P-b=1-beta>0"
  ),
  n2_selection = "C=D for 0<=nu<=nu_star and C=b for nu_star<nu<=1; equality belongs to low-type-only."
)

security_level <- function(m_class) {
  if (identical(m_class, "m2")) {
    return(list(
      name = "S_2",
      formula = "S_2=max{F,K,M}",
      components = list(
        F = "1-h-a",
        R_L = "1-ell-a",
        K = "min{b,(1-nu)*R_L}",
        M = "min{P,D}"
      ),
      exact_guarantee_offers = list(
        F = "(Y,x,r)=(h,a,F), feasible only when F>=0; it forces both voters to yes",
        K = "(Y,x,r)=(ell,a,R_L); its worst admissible return is min{b,(1-nu)*R_L}",
        M = "(Y,x,r)=(h,b,P); passage pays P and any admissible rejection pays D"
      ),
      response_exhaustion = list(
        K = "The weak responder must vote yes. The admissible H responses are pooled no, paying the proposer b, or H type 0 yes and type 1 no, paying (1-nu)*R_L; every weak-no/H profile fails exact type-conditioned IC.",
        M = "At x=b, pooled continuation gives the weak responder its minimum and T^Y selects yes; any admissible rejection must use low-only continuation and pays the proposer D."
      ),
      infeasible_F_rule = "If F<0, retain F algebraically inside max{F,K,M}; do not treat (h,a,F) as feasible. Since K,M>=0, S_2 remains nonnegative.",
      upper_bound_partition = "Every feasible offer lies in x<b, b<=x<a, or x>=a; their sharp caps reduce to M, K, and F, respectively.",
      middle_region_collapse = "The strict feasibility identity 1-ell-b>a makes the remaining middle-payment/middle-H subcase collapse to min{b,D}, which cannot exceed max{F,K,M}.",
      attainment = "K and M are generated by feasible offers for every admissible parameter vector, so S_2 is an attained maximum of the three guarantee components even when F<0.",
      mandatory_binder_fixtures = list(
        F_unique = "beta=0.5,o_0=0.2,o_1=0.6,nu=0.5",
        K_unique = "beta=0.95,o_0=0.4,o_1=0.8,nu=0.7",
        M_unique = "beta=0.9,o_0=7/15,o_1=11/15,nu=0; a=0.24,b=0.12,h=0.66,P=0.22,F=0.10,K=0.12,M=0.22"
      )
    ))
  }
  list(
    name = "S_m",
    formula = "S_m=min{P,D}",
    exact_guarantee_offer = "(Y,x_ij for every j!=i,r_i)=(h,b,...,b,P)",
    low_only_rejection_constructor = paste0(
      "If rejection is needed, at least two weak responders vote no, both H types vote yes, ",
      "the current successor posterior is lambda<nu_star, and each unilateral weak yes is mapped to pooling. ",
      "Each weak no is strict, low H yes is selected by T^Y against low-only, high H yes is selected by T^Y, ",
      "and the true-prior proposer payoff is D. The construction also attains D=b at true nu=nu_star."
    ),
    forbidden_b_punishment = "When D>b, rejection at x=b cannot pay the proposer b: pooling is the minimum weak continuation, so neither a sole nor coordinated strict veto exists at that value.",
    upper_bound_partition = "Some x_ij<b permits a pooling veto; if all x_ij>=b, passage is capped by P and every admissible low-only rejection is worth D.",
    attainment = "The offer and low-only rejection construction attain min{P,D}, including D=b at true nu=nu_star by a successor belief lambda<nu_star."
  )
}

ballot_response_map <- list(
  timing = "After every feasible proposal, all nonproposer ballots are simultaneous; nobody observes another current ballot before voting.",
  weak_nonproposer_j = paste0(
    "Compare j's payoff under the two complete public vote vectors induced by its own yes and no, holding every ",
    "simultaneous ballot strategy fixed. If yes makes the proposal pass, its payoff is x_ij; if either action leaves ",
    "failure, that action's payoff is j's subjective discounted N2 value at its own successor posterior. Vote yes iff ",
    "the yes-vector payoff is at least the no-vector payoff; T^Y selects yes at equality. A nonpivotal outcome does not ",
    "make the actions payoff-identical when the two published failure vectors induce different continuation beliefs."
  ),
  hegemon_type_theta = paste0(
    "Compare type theta's payoff under the two complete public vote vectors induced by its own yes and no. If every weak ",
    "responder says yes, H is outcome-pivotal and votes yes iff Y is at least its discounted N2 continuation after no. ",
    "If a weak responder says no, both H actions leave failure but may induce different successor beliefs, so compare the ",
    "two type-conditioned N2 values directly. T^Y selects yes at equality. In every retained weak-veto delay constructor, ",
    "the high type's continuation is h after either action and exact IC plus P7 require both H types to vote yes; reverse ",
    "H separation is not inserted as a generic punishment."
  ),
  posterior_inputs = paste0(
    "The continuation record is N2-EQ-LOW-TYPE-ONLY when its successor posterior is at most nu_star and ",
    "N2-EQ-POOLING when it is above nu_star. Positive-probability histories obey Bayes; zero-probability histories ",
    "use the explicitly parameterized kappa_i(s) and eta_i(s,v)."
  ),
  constant_on_path_weak_floor = "Every pooling passage pays each weak responder at least b, never min{b,D}."
)

pooling_family <- function(m_class) {
  residual_rule <- if (identical(m_class, "m2")) {
    list(
      security_symbol = "S=S_2=max{F,K,M}",
      if_S_equals_P = "The unique package is (Y,x,r_i)=(h,b,P).",
      if_S_below_P = paste0(
        "Ordinarily r_i>S. The point Y=h,r_i=S is retained iff nu=1 or neither ",
        "B_M=[S=M=D<P] nor B_K=[S=K=(1-nu)*R_L<b] holds. Every point Y>h,r_i=S is excluded."
      ),
      binder_predicates = list(
        B_M = "S=M=D<P",
        B_K = "S=K=(1-nu)*R_L<b",
        exception = "nu=1 permits Y=h,r_i=S even when a predicate binds",
        equality_K_b = "K=b is not B_K and does not by itself exclude the endpoint"
      )
    )
  } else {
    list(
      security_symbol = "S=S_m=min{P,D}",
      if_D_at_least_P = "S=P and the unique package is (Y,x_ij for every j!=i,r_i)=(h,b,...,b,P).",
      if_D_below_P = "Ordinarily r_i>D; the sole additional equality point is nu=1,Y=h,r_i=D=0."
    )
  }
  list(
    existence_status = "exists for every admissible parameter vector",
    implemented_outcome = "R1 passage with H under both types",
    ballots = "Every weak responder and both H types vote yes.",
    support_conditions = c(
      "Y>=h",
      "x_ij>=b for every j!=i",
      "Y+sum_{j!=i}x_ij+r_i<=1",
      "the recognized proposer payoff and proposal-level tie-break obey the residual rule below"
    ),
    proposer_residual_rule = residual_rule,
    Y_projection = list(
      if_S_equals_P = "{h}; minimum and maximum both attained",
      if_S_below_P_and_y_bar_below_U_P = "[h,y_bar]; minimum and maximum both attained",
      if_S_below_P_and_y_bar_at_least_U_P = "[h,U_P); h is an attained minimum and U_P is a nonattained supremum",
      exact_cap_rule = "At y_bar=U_P the upper endpoint remains open."
    ),
    allocation_multiplicity = "All feasible slack and heterogeneous vectors (x_ij) satisfying the floors and residual rule survive; equality is not silently imposed.",
    hegemon_payoff_by_type = list(theta_0 = "Y", theta_1 = "Y"),
    local_outcome_distribution = list(
      pass_with_hegemon = "1",
      pass_without_hegemon = "0",
      failure = "0",
      delay = "0"
    )
  )
}

low_only_family <- function(m_class) {
  residual_rule <- if (identical(m_class, "m2")) {
    list(
      security_symbol = "S_0=S_2 evaluated at nu=0",
      ordinary = "r_i>=S_0",
      boundary_predicate = "B_L0=[M(0)=a=S_0<P], equivalently b<F<=a",
      boundary_rule = "Under B_L0, r_i=S_0 is retained only at Y=ell; every Y>ell requires r_i>S_0."
    )
  } else {
    list(
      if_a_below_P = "r_i>a, except that (Y,r_i)=(ell,a) is retained",
      if_a_at_least_P = "r_i>=P"
    )
  }
  list(
    existence_status = "exists iff nu=0",
    implemented_outcome = "R1 passage with H for theta=0 and counterfactual rejection by theta=1",
    ballots = "Every weak responder votes yes; H type 0 votes yes and H type 1 votes no.",
    support_conditions = c(
      "ell<=Y<h",
      "x_ij>=b for every j!=i",
      "Y+sum_{j!=i}x_ij+r_i<=1",
      "the recognized proposer payoff and proposal-level tie-break obey the residual rule below"
    ),
    proposer_residual_rule = residual_rule,
    Y_projection = list(
      interval = "[ell,h)",
      minimum = "ell, attained",
      maximum = "none",
      supremum = "h, not attained"
    ),
    allocation_multiplicity = "Every feasible slack or heterogeneous weak-payment vector satisfying x_ij>=b and the residual rule is retained.",
    hegemon_payoff_by_type = list(theta_0 = "Y", theta_1 = "h"),
    local_outcome_distribution_at_nu0 = list(
      pass_with_hegemon = "1",
      pass_without_hegemon = "0",
      failure = "0",
      delay = "0"
    )
  )
}

delay_family <- function(m_class, prior_region) {
  existence <- if (identical(m_class, "m2")) {
    "exists iff C>=F; none iff C<F"
  } else {
    "exists for every admissible prior"
  }
  h_map <- if (prior_region %in% c("nu0", "low")) {
    list(theta_0 = "ell", theta_1 = "h")
  } else {
    list(theta_0 = "h", theta_1 = "h")
  }
  multi_veto <- if (identical(m_class, "mge3") && identical(prior_region, "nu0")) {
    "exists: at least two weak responders say no, both H types say yes, and the successor posterior is below nu_star"
  } else if (identical(m_class, "mge3") && identical(prior_region, "low")) {
    "exists iff nu<nu_star; it is absent at nu=nu_star"
  } else if (identical(m_class, "m2")) {
    "none: there is only one weak responder"
  } else {
    "none: at nu>nu_star, b is the minimum weak continuation and T^Y eliminates a strict coordinated veto"
  }
  list(
    existence_status = existence,
    implemented_outcome = "R1 rejection followed by frozen N2; proposer payoff C",
    Y_projection = list(interval = "[0,y_bar]", minimum = "0 attained", maximum = "y_bar attained"),
    continuation_hegemon_payoff_by_type = h_map,
    pure_ballot_constructors = list(
      H_veto = paste0(
        "All weak responders vote yes and both H types vote no; require Y<ell when nu<=nu_star and Y<h when nu>nu_star."
      ),
      exactly_one_weak_veto = "Exactly one weak responder j votes no with x_ij<C; every other weak responder and both H types vote yes.",
      at_least_two_weak_vetoes = multi_veto
    ),
    forbidden_response = "If any weak voter vetoes, H is nonpivotal and T^Y requires both types to vote yes; reverse H separation is inadmissible.",
    package_multiplicity = "Every feasible package and linked belief system satisfying one of the pure constructors is retained, including slack packages; no full-pie equality is imposed.",
    local_outcome_distribution = list(
      pass_with_hegemon = "0",
      pass_without_hegemon = "0",
      failure = "0",
      delay = "1"
    )
  )
}

branch_coverage <- function(m_class, prior_region) {
  low_exists <- identical(prior_region, "nu0")
  delay_status <- if (identical(m_class, "m2")) "conditional" else "exists"
  multi_status <- if (identical(m_class, "m2")) {
    "none"
  } else if (identical(prior_region, "nu0")) {
    "exists"
  } else if (identical(prior_region, "low")) {
    "conditional: exists iff nu<nu_star and none at nu=nu_star"
  } else {
    "none"
  }
  list(
    pooling = list(
      status_rule = "exists",
      none_certificate = NULL
    ),
    low_type_only = list(
      status_rule = if (low_exists) "exists" else "none",
      none_certificate = if (low_exists) NULL else none_certificate(
        "N4V2-CLM-010",
        "Positive-prior low-type-only passage is impossible.",
        "Low H mimics high H's no history: low yes needs Y>=h while high no needs Y<h."
      )
    ),
    high_type_only = list(
      status_rule = "none",
      none_certificate = none_certificate(
        "N4V2-CLM-010",
        "High-type-only passage is impossible at every prior.",
        "The ordered H continuation cutoffs and T^Y preclude high yes with low no."
      )
    ),
    delay = list(
      status_rule = delay_status,
      exists_when = if (identical(m_class, "m2")) "C>=F" else "all admissible parameters",
      none_when = if (identical(m_class, "m2")) "C<F" else typed_not_applicable,
      none_certificate = if (identical(m_class, "m2")) none_certificate(
        "N4V2-CLM-009",
        "No delay equilibrium exists when m=2 and C<F.",
        "The proposer can deviate to the force-pass package (h,a,F), which strictly exceeds C."
      ) else NULL
    ),
    reverse_H_separation_inside_delay = list(
      status_rule = "none",
      none_certificate = none_certificate(
        "N4V2-CLM-008",
        "No weak-veto delay profile can prescribe H type 0 no and H type 1 yes.",
        "A weak veto makes H nonpivotal, so T^Y selects yes for both types."
      )
    ),
    at_least_two_weak_vetoes = list(
      status_rule = multi_status,
      none_certificate = if (identical(m_class, "m2")) none_certificate(
        "N4V2-CLM-008",
        "At least two weak vetoes are impossible when m=2.",
        "Only one weak responder exists."
      ) else if (identical(prior_region, "high")) none_certificate(
        "N4V2-CLM-008",
        "At least two strict weak vetoes are impossible when nu>nu_star.",
        "Pooling value b is the minimum continuation, so equality invokes T^Y=yes."
      ) else if (identical(prior_region, "low")) none_certificate(
        "N4V2-CLM-008",
        "At least two strict weak vetoes are impossible at nu=nu_star.",
        "At the frontier D=b and T^Y eliminates the proposed strict veto at the minimum continuation."
      ) else NULL
    )
  )
}

mixing_rules <- function(m_class, prior_region) {
  if (identical(prior_region, "nu0")) {
    cross <- if (identical(m_class, "m2")) {
      "L/D mixing exists iff F<=a and only at Y_L=ell,r_L=a; its delay component also pays a."
    } else {
      "L/D mixing exists and only at Y_L=ell,r_L=a; its delay component also pays a."
    }
    forbidden <- "No L/P, P/D, or triple within-proposer mixture exists at nu=0."
    h_invariance <- "At the valid L/D locus, both support elements give H the same type vector (ell,h)."
  } else if (identical(prior_region, "high")) {
    cross <- if (identical(m_class, "m2")) {
      "P/D mixing exists iff F<=b and only at Y_P=h,r_P=b; both components pay b."
    } else {
      "P/D mixing exists and only at Y_P=h,r_P=b; both components pay b."
    }
    forbidden <- "No L branch, L/P, L/D, or triple within-proposer mixture exists."
    h_invariance <- "At the valid P/D locus, both support elements give H the same type vector (h,h)."
  } else {
    cross <- "No cross-branch within-proposer mixture exists in 0<nu<=nu_star."
    forbidden <- "No L/P, L/D, P/D, or triple within-proposer mixture exists; in particular P/D is excluded at nu=nu_star."
    h_invariance <- "Not applicable because no cross-branch within-proposer mixture survives."
  }
  list(
    ballot_actions = "always pure",
    within_pooling_or_low = "A proposer may mix only among admissible packages sharing the same (Y,r_i); weak allocation and linked assessment details may vary.",
    within_delay = "A proposer may mix over arbitrary admissible delay packages and Y values because proposer and type-specific H continuation payoffs are invariant.",
    cross_branch = cross,
    cross_branch_H_payoff_invariance = h_invariance,
    excluded_cross_branch_supports = forbidden,
    no_equilibrium_distribution = "All probabilities are endogenous behavioral proposal probabilities inside one assessment, never a distribution or selection over equilibria."
  )
}

identity_rules <- function(m_class, prior_region) {
  if (identical(prior_region, "nu0")) {
    pure <- if (identical(m_class, "m2")) {
      list(
        if_F_at_most_a = paste0(
          "All six triples (k_L,k_P,k_D) are retained: ",
          "(2,0,0),(1,1,0),(1,0,1),(0,2,0),(0,1,1),(0,0,2)."
        ),
        if_F_above_a = "Exactly (2,0,0),(1,1,0),(0,2,0) are retained; k_D=0."
      )
    } else {
      list(
        enumeration = "Every (k_L,k_P,k_D) in Z_+^3 with k_L+k_P+k_D=m is retained.",
        count = "There are choose(m+2,2) pure count triples, before proposer-label permutations and within-branch package multiplicity."
      )
    }
    rho <- if (identical(m_class, "m2")) {
      paste0(
        "Pure assignments give rho_c=k_c/2. If F<=a, every fixed k_P slice also admits continuous L/D behavioral splits; ",
        "if F>a only the three discrete L/P points remain."
      )
    } else {
      "Pure assignments give rho_c=k_c/m. For each k_P=0,...,m, L/D behavioral mixing fills the full slice rho_P=k_P/m and rho_L+rho_D=1-rho_P."
    }
  } else {
    pure <- if (identical(m_class, "m2")) {
      list(
        if_C_at_least_F = "All three pairs (k_P,k_D)=(2,0),(1,1),(0,2) are retained.",
        if_C_below_F = "Only (k_P,k_D)=(2,0) is retained."
      )
    } else {
      list(
        enumeration = "Every (k_P,k_D) in Z_+^2 with k_P+k_D=m is retained.",
        count = "There are m+1 pure count pairs, before proposer-label permutations and within-branch package multiplicity."
      )
    }
    if (identical(prior_region, "high")) {
      rho <- if (identical(m_class, "m2")) {
        "If F<=b, P/D behavioral mixing fills rho_D in [0,1]; otherwise rho_D=0."
      } else {
        "P/D behavioral mixing fills the full interval rho_D in [0,1]."
      }
    } else {
      rho <- if (identical(m_class, "m2")) {
        "If C>=F, pure identities give rho_D in {0,1/2,1}; otherwise rho_D=0. No cross-branch mixing fills the gaps."
      } else {
        "Pure identities give rho_D=k_D/m for k_D=0,...,m. No cross-branch mixing fills the gaps."
      }
    }
  }
  list(
    local_branch_alphabet = if (identical(prior_region, "nu0")) {
      if (identical(m_class, "m2")) "{L,P,D} iff F<=a and {L,P} iff F>a" else "{L,P,D}"
    } else {
      if (identical(m_class, "m2")) "{P,D} iff C>=F and {P} iff C<F" else "{P,D}"
    },
    behavioral_branch_weights = if (identical(prior_region, "nu0")) {
      "For each proposer i, p_{i,L},p_{i,P},p_{i,D} are its endogenous branch probabilities, are nonnegative, sum to one, assign zero to unavailable branches, and may be jointly positive only on the declared L/D locus."
    } else {
      "For each proposer i, p_{i,L}=0 and p_{i,P},p_{i,D} are nonnegative and sum to one; both may be positive only on the declared high-prior P/D locus, otherwise the identity branch is pure."
    },
    pure_count_enumeration = pure,
    aggregate_rho_set = rho,
    labeled_completion = paste0(
      "For every retained count vector, every assignment of its branch labels to the m recognized proposer identities is retained. ",
      "Each identity carries its own proposal law, pure ballots, beliefs, and successor N2 record. The global set is the full Cartesian product."
    ),
    quotient_rule = "Only the downstream H-rent quotient may collapse identity permutations, and it must retain every source equilibrium_id and source hash."
  )
}

nu0_reporting <- function(prior_region) {
  if (!identical(prior_region, "nu0")) {
    return(list(
      applicability = "positive_prior_specialization",
      definitions = list(
        rho_L = "0 because low-type-only passage is empty at every positive prior",
        rho_P = "(1/m)*sum_i Pr_i(P)",
        rho_D = "(1/m)*sum_i Pr_i(D)",
        simplex = "rho_P>=0,rho_D>=0 and rho_P+rho_D=1",
        bar_Y_L = typed_not_applicable,
        bar_Y_P = "sum_i Pr_i(P)*E_i[Y|P] / sum_i Pr_i(P)"
      ),
      empty_category_value = typed_not_applicable,
      empty_category_evaluation = "When rho_P=0, bar_Y_P remains the typed category-empty object and the absent product rho_P*bar_Y_P is omitted, contributing exactly zero without assigning a numeric sentinel.",
      prohibition = "Never encode an empty category as 0, NA, null, an empty string, or an empty array.",
      hegemon_map = if (identical(prior_region, "low")) list(
        theta_0 = "rho_P*bar_Y_P+rho_D*ell",
        theta_1 = "rho_P*bar_Y_P+rho_D*h"
      ) else list(
        theta_0 = "rho_P*bar_Y_P+rho_D*h",
        theta_1 = "rho_P*bar_Y_P+rho_D*h"
      ),
      outcome_map = list(
        pass_with_hegemon = "rho_P",
        pass_without_hegemon = "0",
        failure = "0",
        delay = "rho_D"
      )
    ))
  }
  list(
    applicability = "required",
    definitions = list(
      rho_L = "(1/m)*sum_i Pr_i(L)",
      rho_P = "(1/m)*sum_i Pr_i(P)",
      rho_D = "(1/m)*sum_i Pr_i(D)",
      simplex = "rho_L>=0,rho_P>=0,rho_D>=0 and rho_L+rho_P+rho_D=1",
      bar_Y_L = "sum_i Pr_i(L)*E_i[Y|L] / sum_i Pr_i(L)",
      bar_Y_P = "sum_i Pr_i(P)*E_i[Y|P] / sum_i Pr_i(P)"
    ),
    empty_category_value = typed_not_applicable,
    empty_category_evaluation = "When rho_L=0 or rho_P=0, the corresponding bar_Y coordinate remains the typed category-empty object and its absent product is omitted, contributing exactly zero without assigning a numeric sentinel.",
    prohibition = "Never encode an empty category as 0, NA, null, an empty string, or an empty array.",
    hegemon_map = list(
      theta_0 = "rho_L*bar_Y_L+rho_P*bar_Y_P+rho_D*ell",
      theta_1 = "(rho_L+rho_D)*h+rho_P*bar_Y_P"
    ),
    outcome_map = list(
      pass_with_hegemon = "rho_L+rho_P",
      pass_without_hegemon = "0",
      failure = "0",
      delay = "rho_D"
    )
  )
}

belief_system <- function(prior_region) {
  list(
    entry = "Pr(theta=1)=nu.",
    positive_weight_proposal = "The weak proposer does not observe theta, so every proposal assigned positive conditional probability has ballot posterior nu by Bayes.",
    weak_vote_passivity = "Weak ballots are functions of packages, pivotality, and successor continuation values, not theta; they do not directly update beliefs about theta.",
    public_H_vote = "When H's type-contingent vote differs on a positive-probability history, the published vote updates the successor posterior by Bayes before N2 is consumed.",
    on_path_delay = "Every retained pure delay constructor has the same H action under both types, so an on-path R1 rejection preserves posterior nu and consumes N2's branch at nu.",
    zero_weight_proposal = "Every proposal assigned zero conditional probability may receive an arbitrary ballot belief kappa_i(s) in [0,1].",
    zero_probability_failure_vector = "Every zero-probability published failure vector may receive an arbitrary successor belief eta_i(s,v) in [0,1], linked to the specified pure ballots and frozen N2 response.",
    zero_prior_types = "At nu=0 or nu=1, strategies and type-conditioned payoffs remain specified for both H types; Bayes constrains only positive-probability histories.",
    subjective_object_distinction = "A pivotal weak voter compares x_ij with its subjective continuation at the relevant successor posterior, whose floor is b; a deviating proposer is evaluated under the true pre-proposal prior and receives D under low-only continuation.",
    region_check = if (identical(prior_region, "high")) {
      "On-path delay consumes N2-EQ-POOLING because nu>nu_star."
    } else {
      "On-path delay consumes N2-EQ-LOW-TYPE-ONLY because nu<=nu_star."
    }
  )
}

recognized_proposer_payoff <- function(m_class) {
  list(
    type = "identity-indexed set-valued map conditional on the retained assessment",
    security_floor = if (identical(m_class, "m2")) "S_2=max{F,K,M}" else "S_m=min{P,D}",
    by_local_branch = list(
      L = "r_i; admissible only at nu=0",
      P = "r_i",
      D = "C=max{D,b}"
    ),
    with_behavioral_probabilities = "V_i=p_{i,L}*r_{i,L}+p_{i,P}*r_{i,P}+p_{i,D}*C, with absent categories assigned probability zero and only the declared cross-branch supports allowed.",
    cross_mix_equalities = list(
      L_D = "At nu=0,Y_L=ell,r_{i,L}=a, both support elements pay a.",
      P_D = "At nu>nu_star,Y_P=h,r_{i,P}=b, both support elements pay b."
    )
  )
}

weak_payoff_map <- list(
  type = "identity-indexed pre-recognition R1 payoff map; no symmetry restriction",
  conditional_map = list(
    proposer_identity_matches_weak_k = "u_{k|i,L}=r_i; u_{k|i,P}=r_i; u_{k|i,D}=C when i=k",
    different_proposer_identity = "u_{k|i,L}=x_ik; u_{k|i,P}=x_ik; u_{k|i,D}=C when i!=k"
  ),
  by_weak_state_k = paste0(
    "U_Wk=(1/m)*sum_{i in W}[p_{i,L}*u_{k|i,L}+p_{i,P}*u_{k|i,P}+p_{i,D}*C], ",
    "where absent categories have probability zero and each retained package supplies its own r_i or x_ik."
  ),
  warning = "Do not replace this map by a representative-agent scalar and do not collapse labeled proposer identities."
)

hegemon_map <- function(prior_region) {
  if (identical(prior_region, "nu0")) {
    return(list(
      theta_0 = "rho_L*bar_Y_L+rho_P*bar_Y_P+rho_D*ell",
      theta_1 = "(rho_L+rho_D)*h+rho_P*bar_Y_P"
    ))
  }
  if (identical(prior_region, "low")) {
    return(list(
      theta_0 = "rho_P*bar_Y_P+rho_D*ell",
      theta_1 = "rho_P*bar_Y_P+rho_D*h"
    ))
  }
  list(
    theta_0 = "rho_P*bar_Y_P+rho_D*h",
    theta_1 = "rho_P*bar_Y_P+rho_D*h"
  )
}

outcome_map <- function(prior_region) {
  if (identical(prior_region, "nu0")) {
    return(list(
      pass_with_hegemon = "rho_L+rho_P",
      pass_without_hegemon = "0",
      failure = "0",
      delay = "rho_D"
    ))
  }
  list(
    pass_with_hegemon = "rho_P",
    pass_without_hegemon = "0",
    failure = "0",
    delay = "rho_D"
  )
}

selection_status <- function(m_class, prior_region) {
  paste0(
    "No equilibrium, identity, proposal, belief, or continuation selection is imposed. All local branches and full Cartesian identity assignments allowed by the displayed predicates are retained. ",
    "The proposal-level minimum-expected-H tie-break is applied only to payoff ties: pooling and low-only residual equality points obey their binder predicates; delay is retained at C=F for m=2; ",
    if (identical(prior_region, "nu0")) "L/D mixing is confined to its nu=0 equality locus. " else "",
    if (identical(prior_region, "high")) "P/D mixing is confined to its strict high-prior equality locus. " else "",
    "T^Y governs ballot equality. The only permitted downstream identity collapse is the source-preserving H-rent quotient."
  )
}

make_record <- function(cell_id, equilibrium_id, m_class, prior_region, cell_conditions) {
  list(
    equilibrium_id = equilibrium_id,
    admissibility_conditions = as.list(c(common_domain, cell_conditions)),
    branch_classification = paste0(
      "complete set-valued R1 unanimity correspondence for ",
      if (identical(m_class, "m2")) "m=2" else "m>=3",
      " in the ", prior_region, " prior region; pooling is universal and every additional branch is retained exactly under its displayed predicate"
    ),
    strategy_profile = list(
      frozen_continuation = frozen_continuation,
      derived_quantities = derived_quantities,
      exact_proposer_security = security_level(m_class),
      ballot_response_map_after_every_feasible_proposal = ballot_response_map,
      branch_candidate_coverage = branch_coverage(m_class, prior_region),
      pooling_family = pooling_family(m_class),
      low_type_only_family = low_only_family(m_class),
      delay_family = delay_family(m_class, prior_region),
      proposal_mixing = mixing_rules(m_class, prior_region),
      proposer_identity_completion = identity_rules(m_class, prior_region),
      nu0_reporting = nu0_reporting(prior_region),
      downstream_transport = list(
        N6 = "Transport the entire atomic equilibrium record, its parameter predicates, source cell_id, equilibrium_id, and N2 hash; never recombine marginal payoff or outcome coordinates.",
        N7 = "Use the type-specific H map and R1-event outcome map transported through N6; delay is not terminal failure.",
        H_rent_quotient = "May collapse only H-payoff-equivalent identity permutations while preserving every source ID and hash."
      )
    ),
    belief_system = belief_system(prior_region),
    source_continuation_record_ids = n2_record_ids,
    source_interface_hashes = list(N2 = n2_hash),
    existence_uniqueness_status = paste0(
      "Exists. Pooling makes this top-level coverage cell nonempty. The interface gives the complete parameterized family of local branches, proposal laws, pure ballots, beliefs, and labeled proposer-identity assignments; ",
      "neither strategy nor payoff is generally unique. Empty candidate branches carry typed proof certificates rather than equilibrium sentinels."
    ),
    selection_status = selection_status(m_class, prior_region),
    assumptions_used = as.list(common_assumptions),
    checks_performed = as.list(all_claim_checks),
    recognized_proposer_payoff = recognized_proposer_payoff(m_class),
    weak_nonproposer_pre_recognition_expected_value = weak_payoff_map,
    hegemon_payoff_by_type = hegemon_map(prior_region),
    outcome_distribution = outcome_map(prior_region),
    payoff_date = "R1 current units; each frozen N2 continuation payoff is multiplied by beta exactly once"
  )
}

cell_specs <- list(
  list(
    cell_id = "N4V2-CELL-M2-NU0",
    equilibrium_id = "N4V2-EQ-M2-NU0",
    m_class = "m2",
    prior_region = "nu0",
    conditions = c("m=2", "nu=0")
  ),
  list(
    cell_id = "N4V2-CELL-M2-LOW",
    equilibrium_id = "N4V2-EQ-M2-LOW",
    m_class = "m2",
    prior_region = "low",
    conditions = c("m=2", "0<nu<=nu_star")
  ),
  list(
    cell_id = "N4V2-CELL-M2-HIGH",
    equilibrium_id = "N4V2-EQ-M2-HIGH",
    m_class = "m2",
    prior_region = "high",
    conditions = c("m=2", "nu_star<nu<=1")
  ),
  list(
    cell_id = "N4V2-CELL-MGE3-NU0",
    equilibrium_id = "N4V2-EQ-MGE3-NU0",
    m_class = "mge3",
    prior_region = "nu0",
    conditions = c("m>=3", "nu=0")
  ),
  list(
    cell_id = "N4V2-CELL-MGE3-LOW",
    equilibrium_id = "N4V2-EQ-MGE3-LOW",
    m_class = "mge3",
    prior_region = "low",
    conditions = c("m>=3", "0<nu<=nu_star")
  ),
  list(
    cell_id = "N4V2-CELL-MGE3-HIGH",
    equilibrium_id = "N4V2-EQ-MGE3-HIGH",
    m_class = "mge3",
    prior_region = "high",
    conditions = c("m>=3", "nu_star<nu<=1")
  )
)

interface <- list(
  schema_ref = "equilibrium_correspondence_v1",
  function_of = list(name = "entry_belief", domain = "[0,1]"),
  correspondence_cells = lapply(cell_specs, function(spec) {
    list(
      cell_id = spec$cell_id,
      domain_conditions = as.list(c(common_domain, spec$conditions)),
      existence_status = "exists",
      equilibrium_records = list(make_record(
        spec$cell_id,
        spec$equilibrium_id,
        spec$m_class,
        spec$prior_region,
        spec$conditions
      )),
      nonexistence_certificate = NULL
    )
  })
)

all_equilibrium_ids <- vapply(cell_specs, `[[`, character(1), "equilibrium_id")

make_claim <- function(index, branch, claim, evidence_section, ids = all_equilibrium_ids) {
  list(
    claim_id = sprintf("N4V2-CLM-%03d", index),
    equilibrium_ids = as.list(ids),
    branch = branch,
    payoff_date = "R1",
    claim = claim,
    status = "proved",
    evidence = paste0(
      "model_redesign/essential_input_n4_r1_unanimity_derivation_v2.md#",
      evidence_section
    )
  )
}

claims <- list(
  make_claim(1, "continuation", paste0(
    "Frozen N2 is consumed at its exact hash and discounted once. Low-only gives each weak state the realized vector (a,0), not (a,b), while pooling gives (b,b)."
  ), "frozen-continuation-and-notation"),
  make_claim(2, "accounting", paste0(
    "A pivotal weak voter uses the subjective N2 value at its successor posterior, whose minimum is b, while a deviating proposer evaluates low-only continuation under the true prior and receives D=(1-nu)*a."
  ), "frozen-continuation-and-notation"),
  make_claim(3, "security_m_ge_3", paste0(
    "For m>=3 the exact proposer guarantee is S_m=min{P,D}; the low-prior punishment construction uses at least two strict weak vetoes, both H types voting yes, and a low-only successor posterior, never reverse H separation or a b-valued rejection when D>b."
  ), "exact-proposer-security"),
  make_claim(4, "security_m_2", paste0(
    "For m=2 the exact proposer guarantee is S_2=max{F,K,M}, with F=1-h-a, K=min{b,(1-nu)R_L}, R_L=1-ell-a, and M=min{P,D}; F may be negative and none of F,K,M may be omitted."
  ), "exact-proposer-security"),
  make_claim(5, "pooling", paste0(
    "Pooling has constant weak floor b, exact Y projection and open/closed cap stated in the interface, unique package at S=P, and the m=2 and m>=3 residual endpoint predicates stated there."
  ), "local-pure-branches"),
  make_claim(6, "low_type_only", paste0(
    "Low-type-only passage exists exactly at nu=0, has Y in [ell,h), and obeys the exact residual equality predicates stated separately for m=2 and m>=3."
  ), "local-pure-branches"),
  make_claim(7, "delay", paste0(
    "Every retained delay pays C, has full attained Y projection [0,y_bar], and is implemented by H veto, exactly one weak veto, or the stated low-prior multi-veto constructor."
  ), "local-pure-branches"),
  make_claim(8, "ballots", paste0(
    "All ballots are pure and sequentially rational under stage undominance and T^Y. Weak-veto delay makes H nonpivotal and therefore requires both H types to vote yes; multi-veto delay is impossible for m=2 and at nu>=nu_star."
  ), "local-pure-branches"),
  make_claim(9, "delay_existence", paste0(
    "Delay exists for all priors when m>=3 and exists iff C>=F when m=2, with equality retained by the proposal-level tie-break."
  ), "local-pure-branches"),
  make_claim(10, "separation_nonexistence", paste0(
    "High-type-only passage is impossible at all priors and low-type-only passage is impossible at every positive prior."
  ), "local-pure-branches"),
  make_claim(11, "proposal_mixing", paste0(
    "The only cross-branch within-proposer mixtures are L/D at nu=0,Y_L=ell,r_L=a and P/D at nu>nu_star,Y_P=h,r_P=b, with the stated m=2 feasibility predicates; no other cross mix survives."
  ), "mixtures-and-identity-closure"),
  make_claim(12, "identity_multiplicity", paste0(
    "Every admissible labeled proposer-identity assignment and within-branch proposal law is retained as a full Cartesian product; only the downstream source-preserving H-rent quotient may collapse identity permutations."
  ), "mixtures-and-identity-closure"),
  make_claim(13, "weak_payoffs", paste0(
    "The exact weak payoff object is identity-indexed: a recognized proposer receives its residual on passage and every weak state receives C after delay; no representative-agent collapse is valid."
  ), "mixtures-and-identity-closure"),
  make_claim(14, "nu0_reporting", paste0(
    "At nu=0 the interface reports every admissible rho_L,rho_P,rho_D combination, conditional bar_Y_L and bar_Y_P, typed category-empty non-applicability, and the resulting two-type H payoff map without imposing a distribution over equilibria."
  ), "nu0-reporting-coordinates"),
  make_claim(15, "outcomes", paste0(
    "The four output coordinates partition the R1 event: unanimity has no pass-without-H, terminal failure is zero, and R1 rejection is recorded as delay rather than overlaid with eventual N2 failure."
  ), "nu0-reporting-coordinates"),
  make_claim(16, "beliefs", paste0(
    "On-path proposals and weak votes do not reveal theta; public H votes update by Bayes when informative; off-path beliefs remain unrestricted only at zero-probability histories and are linked to their frozen N2 continuation."
  ), "p0-p3-p7-and-beliefs"),
  make_claim(17, "slack", paste0(
    "Universal full-pie use is false in N4: admissible accepted and delayed slack proposals survive except at the explicitly unique pooling boundary."
  ), "p0-p3-p7-and-beliefs"),
  make_claim(18, "coverage", paste0(
    "The six cells are mutually exclusive and exhaustive over m>=2 and nu in [0,1]; pooling makes every cell nonempty, every empty candidate branch has a typed certificate, and the atomic records close all N6/N7 inputs."
  ), "coverage-and-status")
)

build_outputs <- function(interface_target, ledger_target) {
  write_canonical_json(interface, interface_target)
  interface_hash <- sha256_file(interface_target)
  ledger <- list(
    ledger_schema = "essential_input_claim_ledger_v1",
    node_id = "N4",
    artifact_path = "model_redesign/essential_input_interfaces/n4_r1_unanimity_candidate_v2.json",
    artifact_hash = paste0("sha256:", interface_hash),
    node_status = "pending_independent_review",
    claims = claims
  )
  write_canonical_json(ledger, ledger_target)
  invisible(list(interface_hash = interface_hash, ledger_hash = sha256_file(ledger_target)))
}

if (check_mode) {
  interface_tmp <- tempfile("n4-v2-interface-", fileext = ".json")
  ledger_tmp <- tempfile("n4-v2-ledger-", fileext = ".json")
  on.exit(unlink(c(interface_tmp, ledger_tmp)), add = TRUE)
  hashes <- build_outputs(interface_tmp, ledger_tmp)
  assert_true(file.exists(interface_path), "Canonical N4 v2 interface is missing.")
  assert_true(file.exists(ledger_path), "Canonical N4 v2 ledger is missing.")
  assert_true(identical_bytes(interface_tmp, interface_path), "Canonical N4 v2 interface is not build-stable.")
  assert_true(identical_bytes(ledger_tmp, ledger_path), "Canonical N4 v2 ledger is not build-stable.")
  cat("PASS: N4 v2 build is byte-stable\n")
  cat("interface_sha256=", hashes$interface_hash, "\n", sep = "")
  cat("ledger_sha256=", hashes$ledger_hash, "\n", sep = "")
} else {
  dir.create(dirname(interface_path), recursive = TRUE, showWarnings = FALSE)
  hashes <- build_outputs(interface_path, ledger_path)
  cat("PASS: built N4 v2 candidate artifacts\n")
  cat("interface_sha256=", hashes$interface_hash, "\n", sep = "")
  cat("ledger_sha256=", hashes$ledger_hash, "\n", sep = "")
}
