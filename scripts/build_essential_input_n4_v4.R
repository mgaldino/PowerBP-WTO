#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the build-script path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
arguments <- commandArgs(trailingOnly = TRUE)
check_mode <- "--check" %in% arguments

option_value <- function(prefix) {
  matches <- arguments[startsWith(arguments, prefix)]
  assert_true(length(matches) <= 1L, paste0("Duplicate option ", prefix))
  if (length(matches) == 0L) return(NULL)
  value <- substring(matches, nchar(prefix) + 1L)
  assert_true(nzchar(value), paste0("Empty option ", prefix))
  value
}

n2_path <- file.path(
  repository_root, "model_redesign", "essential_input_n2_r2_unanimity_interface.json"
)
cold_path <- file.path(
  repository_root, "model_redesign", "essential_input_n4_r1_unanimity_cold_notes_v4.md"
)
interface_default <- file.path(
  repository_root, "model_redesign", "essential_input_interfaces",
  "n4_r1_unanimity_candidate_v4.json"
)
ledger_default <- file.path(
  repository_root, "model_redesign", "essential_input_n4_claim_ledger_v4.json"
)
interface_path <- option_value("--interface-out=")
ledger_path <- option_value("--ledger-out=")
if (is.null(interface_path)) interface_path <- interface_default
if (is.null(ledger_path)) ledger_path <- ledger_default
interface_path <- normalizePath(interface_path, mustWork = FALSE)
ledger_path <- normalizePath(ledger_path, mustWork = FALSE)

n2_hash_bare <- "c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2"
n2_hash <- paste0("sha256:", n2_hash_bare)
cold_hash_bare <- "a2f44b0ba0bdc1658406489be0605ffbb626d023ed0abb478530b96cec56e4c7"
cold_hash <- paste0("sha256:", cold_hash_bare)
n2_record_ids <- c("N2-EQ-LOW-TYPE-ONLY", "N2-EQ-POOLING")

sha256_file <- function(path) {
  executable <- Sys.which("shasum")
  assert_true(nzchar(executable), "The 'shasum' executable is required.")
  output <- system2(
    executable,
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
  "N4 v4 may consume only the authorized frozen N2 bytes."
)
assert_true(file.exists(cold_path), "Sealed N4 v4 cold note is missing.")
assert_true(
  identical(sha256_file(cold_path), cold_hash_bare),
  "The sealed N4 v4 cold-note bytes changed."
)

common_domain <- c(
  "nu is the entry belief Pr(theta=1) and 0<=nu<=1",
  "N is an integer and N>=3; W is the set of weak states; m=N-1>=2",
  "0<beta<1",
  "0<o_0<o_1<1 and o_1<=y_bar<=1",
  "for recognized weak proposer i, every proposal is s=(Y,(x_ij)_{j in W\\{i}},r_i) with 0<=Y<=y_bar, every x_ij>=0, r_i>=0, and Y+sum_{j!=i}x_ij+r_i<=1",
  "nu_star=(o_1-o_0)/(1-o_0); ell=beta*o_0; h=beta*o_1; A=beta*(1-o_0)/m; B=beta*(1-o_1)/m",
  "D=(1-nu)*A; C=D when nu<=nu_star and C=B when nu>nu_star",
  "Q_L=1-ell-A; Q_P=1-h-A; R_0=min{D,B}; R_L=min{(1-nu)*Q_L,B}; R_P=max{0,Q_P}",
  "the only continuation records are N2-EQ-LOW-TYPE-ONLY and N2-EQ-POOLING",
  paste0("the frozen N2 interface hash is ", n2_hash),
  "every N2 continuation payoff is transported to R1 with exactly one factor beta",
  "ballot actions are pure; proposal strategies mix only over the explicitly retained supports"
)

common_assumptions <- c(
  "fixed unit pie, no side payments, no exit action, iid uniform weak-state recognition, and pi_H=0",
  "unanimity quota, simultaneous sealed ballots, and public revelation of the complete vote vector only after the ballot closes",
  "PBE with stage-undominated weak voting, T^Y after elimination and at genuine equality, and the minimum-expected-H proposal tie-break",
  "weak proposers and weak nonproposers do not observe theta; on-path weak-action passivity is derived rather than imposed",
  "off-path beliefs are unrestricted only at zero-probability histories and are explicit components of the assessment",
  "frozen N2 is the sole continuation and is discounted exactly once"
)

all_claim_checks <- paste0(
  "N4V4-CLM-", sprintf("%03d", 1:22), " ",
  c(
    "frozen N2 import", "complete ballot oracle", "P/L/D exhaustion",
    "weak response bounds", "m>=3 security", "m=2 security supremum",
    "attainment and H_tie", "pooling family", "low-only family",
    "delay family", "nonexistence certificates", "multi-veto multiplicity",
    "proposal mixtures", "identity completion", "weak payoff vector",
    "H payoff and outcome maps", "Bayes and beliefs", "slack preservation",
    "six-cell coverage", "v3 repair provenance", "directed negative fixtures",
    "full semantic leaf certification"
  )
)

typed_not_applicable <- list(status = "not_applicable", reason = "category_empty")

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
  weak_subjective_value_after_one_discount = list(
    low_type_only = "A*(1-eta) for 0<=eta<=nu_star",
    pooling = "B for nu_star<eta<=1"
  ),
  weak_realized_payoff_by_theta_after_one_discount = list(
    low_type_only = list(theta_0 = "A", theta_1 = "0"),
    pooling = list(theta_0 = "B", theta_1 = "B")
  ),
  hegemon_payoff_by_theta_after_one_discount = list(
    low_type_only = list(theta_0 = "ell", theta_1 = "h"),
    pooling = list(theta_0 = "h", theta_1 = "h")
  ),
  proposer_true_prior_value = list(
    low_type_only = "D=(1-nu)*A",
    pooling = "B",
    on_path_delay = "C=D for nu<=nu_star and C=B for nu>nu_star"
  ),
  object_separation = "Weak sequential voting uses the subjective value; proposer deviations use realized type payoffs integrated under the true pre-proposal nu; H uses its type-conditioned vector.",
  posterior_sufficiency = "Terminal N2 plus iid recognition with replacement makes the successor posterior sufficient without imposing a Markov restriction.",
  transport_rule = "All displayed quantities are in current R1 units after exactly one multiplication by beta."
)

derived_quantities <- function(m_class) {
  list(
    definitions = list(
      nu_star = "(o_1-o_0)/(1-o_0)",
      ell = "beta*o_0",
      h = "beta*o_1",
      A = "beta*(1-o_0)/m",
      B = "beta*(1-o_1)/m",
      D = "(1-nu)*A",
      C = "D if nu<=nu_star; B if nu>nu_star",
      Q_L = "1-ell-A",
      Q_P = "1-h-A",
      R_0 = "min{D,B}",
      R_L = "min{(1-nu)*Q_L,B}",
      R_P = "max{0,Q_P}",
      S = if (m_class == "m2") "S_2=max{R_0,R_L,R_P}" else "S_3=(1-nu)*B",
      U_P = "1-(m-1)*B-S"
    ),
    strict_relations = as.list(c(
      "0<ell<h<beta<1", "0<B<A", "0<nu_star<1",
      "Q_L>0", "1-h-(m-1)*B-B=1-beta>0", "S<1-h-(m-1)*B"
    )),
    n2_selection = "Low-type-only is selected at eta<=nu_star, including equality; pooling is selected only at eta>nu_star."
  )
}

oracle_specification <- list(
  implementation = "scripts/oracle_essential_input_n4_v4.R",
  candidate_independence = "The oracle neither reads the N4 candidate nor imports any candidate security formula.",
  ballot_coverage = "For m ballot voters it enumerates every one of the 2^m vectors and requires a continuation at every one of the 2^m-1 failure vectors.",
  weak_test = "For each weak responder j, compare yes/no against all 2^(m-1) profiles of H and the other weak responders; eliminate weakly dominated actions before sequential best response and T^Y.",
  H_test = "For each theta, compare the two public vectors induced by H=yes/no at the prescribed weak vector; apply PBE and then T^Y, never stage-undominance.",
  Bayes_test = "Every positive-probability failure vector under an on-path proposal receives its exact Bayes posterior; zero-probability vectors remain free.",
  proposer_test = "The proposer payoff uses N2 realized payoffs by theta and the true nu, never the ballot belief.",
  directed_fixtures = as.list(c(
    "accept the valid m=3 (h,B,B,1-h-2B) multi-veto assessment that pays B",
    "accept the valid m=2 (h,A,1-h-A) weak-veto assessment that pays (1-nu)A",
    "reject m=2 high-prior H-veto with x<B because no weakly dominates yes",
    "reject the on-path m=3 high-prior two-veto fixture with x_1=x_2=.30>B=.12",
    "accept the same on-path fixture at the exact boundary x_1=x_2=B=.12"
  ))
)

security_level <- function(m_class) {
  if (m_class == "mge3") {
    return(list(
      name = "S_3",
      formula = "S_3(nu)=(1-nu)*B",
      topology = "attained maximum guarantee",
      upper_bound_assessment = "After every zero-probability proposal, all m-1 weak responders vote no, H0 votes no into pooling, H1 votes yes into low-type-only, H=yes continuation values rise strictly with the number of weak vetoes, H=no failures use pooling, and the ballot belief is one.",
      upper_bound_payoff_by_type = list(theta_0 = "B", theta_1 = "0"),
      lower_bound_offer = "Y=0 guarantees at least (B,0) by type under every admissible response.",
      implication = "No proposal forces passage when m-1>=2; coordinated weak vetoes survive stage-undominance."
    ))
  }
  list(
    name = "S_2",
    formula = "S_2(nu)=max{R_0(nu),R_L(nu),R_P}",
    topology = "supremum; it need not be attained by an off-path deviation",
    components = list(
      R_0 = "min{D,B}; always attained at x=A by common H-veto failure",
      R_L = "min{(1-nu)*Q_L,B}; for nu<1 attained iff (1-nu)*Q_L>B, and at equality or below only a supremum; at nu=1 its zero value is attained",
      R_P = "max{0,Q_P}; if positive it is a nonattained supremum because force passage requires x>A; zero is trivially attained"
    ),
    response_partition = list(
      x_below_A = "A separating punishment pays the proposer (B,0), hence (1-nu)B.",
      x_equal_A = "The separating punishment is destroyed by T^Y; common low-type-only or pooling failure gives R_0.",
      x_above_A = "W is forced to yes; y<ell gives R_0, ell<=y<h gives R_L in the capacity limit, and y>=h gives R_P in the capacity limit."
    ),
    tie_witness = list(
      H_L = "(1-nu)*ell+nu*h",
      H_tie = "H_L if S_2=R_0=D<B; h if an attained component equals S_2 and the first case fails; +infinity if only nonattained components attain the supremum",
      interpretation = "+infinity means that no deviation ties S_2, so a current proposal paying S_2 faces no additional H-payoff restriction."
    )
  )
}

ballot_response_map <- function(m_class, prior_region) {
  list(
    timing = "Every nonproposer ballot is simultaneous and sealed; the complete vector is published only after all votes are cast.",
    weak_nonproposer_j = "For every profile of all other voters, compare passage payoff x_ij with the continuation attached to j=no and compare the two distinct continuations when both actions fail. Eliminate domination globally, then impose sequential best response, then T^Y at a surviving genuine tie.",
    hegemon_type_theta = "Compare y on passage with the type-conditioned continuation after H=no when all weak responders say yes; with a weak veto compare the two type-conditioned N2 continuations. H1 says yes under any weak veto; H0 says no only if H=yes maps to low-type-only and H=no maps to pooling.",
    passage_floor = "P and L require x_ij>=B for every weak responder; equality is retained by a pooling failure map and T^Y.",
    H_veto_weak_bounds = if (m_class == "mge3") {
      "Every feasible weak-payment vector is sustainable by crossed continuation comparisons."
    } else if (prior_region == "high") {
      "The unique weak responder requires x>=B."
    } else {
      "The unique weak responder requires x>=0 for nu<nu_star and x>=B at nu=nu_star."
    },
    weak_veto_bounds = "A sole weak veto k requires x_ik<=C, including equality. With at least two weak vetoes and m>=3, nu<nu_star imposes no additional payment bound beyond feasibility, whereas nu>=nu_star requires x_ik<=B for every veto k, including equality; no additional bound applies to nonvetoing responders.",
    continuation_inputs = "Each failure vector explicitly records eta and thereby one of the two frozen N2 records; no common-continuation shortcut is imposed."
  )
}

branch_coverage <- function(m_class, prior_region) {
  l_exists <- prior_region == "nu0"
  delay_rule <- if (m_class == "mge3") "exists" else "conditional"
  list(
    pooling = list(status_rule = "exists", none_certificate = NULL),
    low_type_only = if (l_exists) {
      list(status_rule = "exists", none_certificate = NULL)
    } else {
      list(
        status_rule = "none",
        none_certificate = none_certificate(
          "N4V4-CLM-011",
          "Low-type-only passage does not exist at a positive prior.",
          "H0 can mimic the H1 failure history and receive h, contradicting Y<h."
        )
      )
    },
    high_type_only = list(
      status_rule = "none",
      none_certificate = none_certificate(
        "N4V4-CLM-011",
        "High-type-only passage never exists.",
        "It would require Y<ell for H0=no and Y>=h for H1=yes although ell<h."
      )
    ),
    delay = list(
      status_rule = delay_rule,
      exists_when = if (m_class == "mge3") "all admissible parameters" else "C>=S_2",
      none_when = if (m_class == "mge3") NULL else "C<S_2",
      none_certificate = if (m_class == "mge3") NULL else none_certificate(
        "N4V4-CLM-010",
        "No delay equilibrium exists when m=2 and C<S_2.",
        "The proposer has deviations with returns arbitrarily close to S_2>C."
      )
    ),
    H_separation_with_weak_veto = list(
      status_rule = "none",
      none_certificate = none_certificate(
        "N4V4-CLM-011",
        "H cannot separate on path after a weak veto.",
        "H1 always says yes; Bayes makes any candidate H0=no prefer the H1 vector."
      )
    ),
    at_least_two_weak_vetoes = if (m_class == "mge3") {
      list(
        status_rule = "exists at nu<nu_star for every feasible package; at nu>=nu_star iff every veto k satisfies x_ik<=B",
        none_certificate = NULL
      )
    } else {
      list(
        status_rule = "none",
        none_certificate = none_certificate(
          "N4V4-CLM-012",
          "At least two weak vetoes are impossible when m=2.",
          "Only one weak responder exists."
        )
      )
    }
  )
}

pooling_family <- function(m_class) {
  list(
    existence_status = "exists for every admissible parameter vector",
    implemented_outcome = "R1 passage with H under both types",
    ballots = "Every weak responder and both H types vote yes.",
    support_conditions = as.list(c(
      "h<=Y<=y_bar", "x_ij>=B for every j!=i", "r_i>=S",
      "Y+sum_{j!=i}x_ij+r_i<=1", "the endpoint r_i=S obeys the tie rule below"
    )),
    proposer_residual_rule = if (m_class == "mge3") {
      list(
        security_symbol = "S=S_3=(1-nu)B",
        strict_above = "If r_i>S, every feasible Y survives.",
        equality = "If r_i=S, the minimum-expected-H proposal tie-break requires Y=h."
      )
    } else {
      list(
        security_symbol = "S=S_2=max{R_0,R_L,R_P}",
        strict_above = "If r_i>S, every feasible Y survives.",
        equality = "If r_i=S, require Y<=H_tie: no pooling equality point when H_tie<h; only Y=h when H_tie=h; no additional restriction when H_tie=+infinity."
      )
    },
    Y_projection = list(
      lower = "h, always an attained minimum",
      budget_cap = "U_P=1-(m-1)B-S, with U_P>h",
      primitive_cap = "If y_bar<U_P, y_bar is an attained maximum using r_i>S.",
      exact_budget_endpoint = if (m_class == "m2") {
        "If y_bar>=U_P, U_P is attained exactly when H_tie=+infinity; otherwise it is a nonattained supremum."
      } else {
        "If y_bar>=U_P, U_P is a nonattained supremum because r_i=S would have Y>h."
      }
    ),
    allocation_multiplicity = "All feasible slack and heterogeneous weak-payment vectors satisfying the floors and residual rule survive; equality of the budget is not imposed.",
    hegemon_payoff_by_type = list(theta_0 = "Y", theta_1 = "Y"),
    local_outcome_distribution = list(
      pass_with_hegemon = "1", pass_without_hegemon = "0", failure = "0", delay = "0"
    )
  )
}

low_only_family <- function(prior_region) {
  if (prior_region != "nu0") {
    return(list(
      existence_status = "none",
      none_certificate = none_certificate(
        "N4V4-CLM-011",
        "Low-type-only passage is impossible for nu>0.",
        "The H1 failure vector reveals theta=1 and lets H0 obtain h by mimicking."
      )
    ))
  }
  list(
    existence_status = "exists exactly at nu=0",
    implemented_outcome = "R1 passage with H for theta=0 and counterfactual rejection by the zero-prior theta=1 type",
    ballots = "Every weak responder says yes; H0 says yes and H1 says no.",
    support_conditions = as.list(c(
      "ell<=Y<h", "x_ij>=B for every j!=i", "r_i>=S",
      "Y+sum_{j!=i}x_ij+r_i<=1"
    )),
    endpoint_rule = "The endpoint r_i=S survives for every feasible Y in [ell,h); its expected H payoff is below the relevant pooling security witness.",
    Y_projection = "[ell,h): ell is an attained minimum and h a nonattained supremum.",
    hegemon_payoff_by_type = list(theta_0 = "Y", theta_1 = "h"),
    local_outcome_distribution = list(
      pass_with_hegemon = "1", pass_without_hegemon = "0", failure = "0", delay = "0"
    ),
    none_certificate = NULL
  )
}

delay_family <- function(m_class, prior_region) {
  low_region <- prior_region != "high"
  list(
    existence_status = if (m_class == "mge3") {
      "exists for every admissible parameter vector"
    } else {
      "exists iff C>=S_2; none iff C<S_2"
    },
    proposer_payoff = if (low_region) "C=D=(1-nu)A" else "C=B",
    hegemon_payoff_by_type = if (low_region) {
      list(theta_0 = "ell", theta_1 = "h")
    } else {
      list(theta_0 = "h", theta_1 = "h")
    },
    overall_Y_projection = "[0,y_bar], with both endpoints attained across the union of delay constructors",
    H_veto = list(
      ballots = "Every weak responder says yes; H0 and H1 say no.",
      Y_condition = if (low_region) "0<=Y<ell" else "0<=Y<h",
      weak_payment_condition = if (m_class == "mge3") {
        "Every feasible nonnegative weak-payment vector."
      } else if (prior_region == "high") {
        "x>=B."
      } else {
        "x>=0 for nu<nu_star; x>=B at nu=nu_star."
      }
    ),
    one_weak_veto = list(
      ballots = "H0=H1=yes; exactly one weak responder k says no and every other weak responder says yes.",
      condition = "x_ik<=C, including equality; all other proposal coordinates need only satisfy feasibility."
    ),
    multiple_weak_vetoes = if (m_class == "mge3") {
      list(
        status = "exists",
        ballots = "H0=H1=yes and any labeled subset of at least two weak responders says no.",
        condition = "For nu<nu_star there is no payment restriction beyond proposal feasibility. For nu>=nu_star every veto k requires x_ik<=B, including equality; nonvetoing responders have no additional bound. Identity and every linked failure-vector belief remain part of the source assessment.",
        security_separation = "This on-path Bayes restriction does not constrain the zero-probability punishment establishing S_3=(1-nu)B."
      )
    } else {
      list(
        status = "not_applicable",
        reason = "only_one_weak_responder"
      )
    },
    tie_break = "When m=2 and C=S_2, delay is retained: in the low region its H payoff is no larger than the attained security witness, and in the high region it is h, equal to or below the relevant witness.",
    local_outcome_distribution = list(
      pass_with_hegemon = "0", pass_without_hegemon = "0", failure = "0", delay = "1"
    )
  )
}

proposal_mixing <- function(m_class, prior_region) {
  list(
    ballot_mixing = "none; all ballot actions are pure",
    within_family = "A proposer may mix only among packages with the same proposer payoff and the same minimum expected H payoff among maximizers; linked beliefs and ballots remain attached to each support point.",
    cross_branch = if (prior_region == "nu0") {
      list(
        support = "L at (Y,r_i)=(ell,A) and D",
        availability = if (m_class == "mge3") "always" else "iff C=A>=S_2",
        H_payoff_invariance = "Every support point gives H the vector (ell,h).",
        probability = "arbitrary behavioral probability inside the assessment"
      )
    } else if (prior_region == "high") {
      list(
        support = "P at (Y,r_i)=(h,B) and D",
        availability = if (m_class == "mge3") "always" else "iff C=B>=S_2",
        H_payoff_invariance = "Every support point gives H the vector (h,h).",
        probability = "arbitrary behavioral probability inside the assessment"
      )
    } else {
      list(status = "none", reason = "no_cross_branch_payoff_tie")
    },
    exclusions = as.list(c(
      "no L/P cross mix", "no P/D cross mix at nu<=nu_star",
      "no L/D cross mix away from nu=0", "no triple cross mix"
    )),
    interpretation = "Behavioral probabilities are equilibrium strategies, never a distribution over equilibria."
  )
}

identity_completion <- list(
  recognition = "Each weak state is recognized with probability 1/m, independently across rounds.",
  source_multiplicity = "For each labeled proposer i choose any locally admissible pure family or valid mixed support, package, ballot map, belief map, and N2 continuation. The full Cartesian product across identities is retained.",
  no_symmetry_selection = "Different identities may use different branches and packages because zero-probability responses can condition on proposer identity.",
  assessment_weights = "For every assessment define rho_c=(1/m)*sum_i Pr_i(c) over recognition and proposer i's own behavioral support, using only locally available c in {L,P,D}; rho values sum to one. For every nonempty passage category, bar_Y_c is the corresponding recognition- and strategy-weighted conditional mean; an empty category is typed not_applicable/category_empty. These are derived weights inside one assessment, never a distribution over equilibria.",
  pure_conventions = "At nu=0 enumerate every integer triple (k_L,k_P,k_D) with nonnegative entries summing to m; rho_c=k_c/m. At other priors use the available P/D alphabet.",
  quotient_boundary = "Identity permutations may be collapsed only downstream for an exactly equal H-payoff vector, preserving every source ID and hash."
)

nu0_reporting <- list(
  coordinates = list(
    shares = "rho_L>=0,rho_P>=0,rho_D>=0 and rho_L+rho_P+rho_D=1",
    conditional_means = "bar_Y_L and bar_Y_P are recognition- and strategy-weighted means within nonempty L and P categories",
    empty_category = typed_not_applicable
  ),
  full_image = "Enumerate every value induced by the correspondence, including k/m pure identity shares and continuous slices generated only by valid within-assessment L/D mixing.",
  H_payoff = list(
    theta_0 = "rho_L*bar_Y_L+rho_P*bar_Y_P+rho_D*ell",
    theta_1 = "(rho_L+rho_D)*h+rho_P*bar_Y_P"
  ),
  outcome = list(
    pass_with_hegemon = "rho_L+rho_P", pass_without_hegemon = "0",
    failure = "0", delay = "rho_D"
  ),
  interpretation = "These are reporting coordinates, not primitives, equilibrium-selection weights, empirical frequencies, or the equal-area measure over outside options."
)

belief_system <- function(prior_region) {
  list(
    entry = "nu=Pr(theta=1) before a weak proposer is recognized",
    positive_weight_proposal = "Because the weak proposer does not observe theta, Bayes preserves nu at every on-path proposal.",
    weak_action_passivity = "At an on-path ballot, every weak action is type-independent; observing weak votes adds no information beyond the proposal and prior public history.",
    public_H_vote = "H's published vote updates the posterior when its on-path strategy differs by type; every positive-probability failure vector uses Bayes.",
    on_path_delay = if (prior_region == "high") {
      "A nonrevealing delay has posterior nu>nu_star and consumes N2-EQ-POOLING."
    } else {
      "A nonrevealing delay has posterior nu<=nu_star and consumes N2-EQ-LOW-TYPE-ONLY, including equality."
    },
    zero_weight_proposal = "The ballot belief after a zero-probability proposal is an explicit free component in [0,1].",
    zero_probability_failure_vector = "Each zero-probability public vote vector has its own explicit posterior eta in [0,1] and consumes the N2 record determined by eta.",
    zero_prior_types = "At nu=0 or nu=1, strategies and sequential rationality for the zero-probability type remain specified; Bayes constrains only positive-probability histories.",
    completeness = "No belief is inferred merely from branch labels; the assessment contains the proposal belief and the continuation posterior for every public failure vector."
  )
}

weak_payoff_map <- list(
  type = "identity_indexed_pre_recognition_vector",
  conditional_map = list(
    recognized_proposer = "R_i=r_i in P/L and R_i=C in D",
    nonproposer = "w_ik=x_ik in P/L and w_ik=C in D"
  ),
  by_weak_state_k = "V_Wk=(R_k+sum_{i!=k}w_ik)/m, with expectations inside each valid proposal mixture",
  warning = "Do not replace this labeled vector by a representative-agent scalar or recombine marginals from different assessments."
)

hegemon_map <- function(prior_region) {
  if (prior_region == "nu0") {
    return(list(
      theta_0 = "rho_L*bar_Y_L+rho_P*bar_Y_P+rho_D*ell",
      theta_1 = "(rho_L+rho_D)*h+rho_P*bar_Y_P"
    ))
  }
  if (prior_region == "low") {
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
  if (prior_region == "nu0") {
    return(list(
      pass_with_hegemon = "rho_L+rho_P", pass_without_hegemon = "0",
      failure = "0", delay = "rho_D"
    ))
  }
  list(
    pass_with_hegemon = "rho_P", pass_without_hegemon = "0",
    failure = "0", delay = "rho_D"
  )
}

recognized_proposer_payoff <- function(m_class) {
  list(
    type = "identity_and_branch_indexed_correspondence",
    security_floor = if (m_class == "m2") {
      "S_2=max{R_0,R_L,R_P}, a supremum that may be nonattained by deviations"
    } else {
      "S_3=(1-nu)B, attained"
    },
    by_local_branch = list(P = "r_i>=S", L = "r_i>=S at nu=0", D = "C"),
    with_behavioral_probabilities = "Take the expectation over a proposer's own valid support only after verifying equal proposer payoff at every support point.",
    true_prior_rule = "Every failed proposal is evaluated from its realized N2 payoff vector under nu, never under an arbitrary ballot belief."
  )
}

selection_status <- function(m_class) {
  paste0(
    "No equilibrium, identity, branch, package, ballot, belief, continuation, or distribution over equilibria is selected. ",
    "All admissible pure families, linked assessments, proposal mixtures, slack packages, and labeled identity assignments are retained. ",
    if (m_class == "m2") {
      "The proposal-level tie-break uses H_tie only when r_i=S_2; nonattained security components are not converted into fictitious deviations. "
    } else {
      "At r_i=S_3 the proposal-level tie-break retains pooling only at Y=h. "
    },
    "Stage-undominance precedes T^Y, and the only permitted downstream collapse is the source-preserving exact H-payoff quotient."
  )
}

make_record <- function(spec) {
  conditions <- c(common_domain, spec$conditions)
  list(
    equilibrium_id = spec$equilibrium_id,
    admissibility_conditions = as.list(conditions),
    branch_classification = paste0(
      "complete parameterized R1-unanimity equilibrium correspondence for ",
      spec$m_label, " in the ", spec$prior_label,
      " prior cell; P is universal and every L/D/mixture/identity branch is retained exactly under its displayed predicate"
    ),
    strategy_profile = list(
      frozen_continuation = frozen_continuation,
      derived_quantities = derived_quantities(spec$m_class),
      independent_ballot_oracle = oracle_specification,
      exact_proposer_security = security_level(spec$m_class),
      ballot_response_map_after_every_feasible_proposal = ballot_response_map(
        spec$m_class, spec$prior_region
      ),
      branch_candidate_coverage = branch_coverage(spec$m_class, spec$prior_region),
      pooling_family = pooling_family(spec$m_class),
      low_type_only_family = low_only_family(spec$prior_region),
      delay_family = delay_family(spec$m_class, spec$prior_region),
      proposal_mixing = proposal_mixing(spec$m_class, spec$prior_region),
      proposer_identity_completion = identity_completion,
      nu0_reporting = if (spec$prior_region == "nu0") nu0_reporting else typed_not_applicable,
      downstream_transport = "N6 must preserve the complete parameterized record and every linked source assessment. N7 may quotient only exactly equal H-payoff vectors while retaining source IDs and hashes."
    ),
    belief_system = belief_system(spec$prior_region),
    source_continuation_record_ids = as.list(n2_record_ids),
    source_interface_hashes = list(N2 = n2_hash),
    existence_uniqueness_status = "Exists because pooling is nonempty. The correspondence is generally neither strategy-unique nor payoff-unique; conditional nonexistence applies only to explicitly certified candidate families.",
    selection_status = selection_status(spec$m_class),
    assumptions_used = as.list(common_assumptions),
    checks_performed = as.list(all_claim_checks),
    recognized_proposer_payoff = recognized_proposer_payoff(spec$m_class),
    weak_nonproposer_pre_recognition_expected_value = weak_payoff_map,
    hegemon_payoff_by_type = hegemon_map(spec$prior_region),
    outcome_distribution = outcome_map(spec$prior_region),
    payoff_date = "R1 current units; each frozen N2 continuation payoff is multiplied by beta exactly once"
  )
}

cell_specs <- list(
  list(
    cell_id = "N4V4-CELL-M2-NU0", equilibrium_id = "N4V4-EQ-M2-NU0",
    m_class = "m2", m_label = "m=2", prior_region = "nu0",
    prior_label = "nu=0", conditions = c("m=2", "nu=0")
  ),
  list(
    cell_id = "N4V4-CELL-M2-LOW", equilibrium_id = "N4V4-EQ-M2-LOW",
    m_class = "m2", m_label = "m=2", prior_region = "low",
    prior_label = "0<nu<=nu_star", conditions = c("m=2", "0<nu<=nu_star")
  ),
  list(
    cell_id = "N4V4-CELL-M2-HIGH", equilibrium_id = "N4V4-EQ-M2-HIGH",
    m_class = "m2", m_label = "m=2", prior_region = "high",
    prior_label = "nu_star<nu<=1", conditions = c("m=2", "nu_star<nu<=1")
  ),
  list(
    cell_id = "N4V4-CELL-MGE3-NU0", equilibrium_id = "N4V4-EQ-MGE3-NU0",
    m_class = "mge3", m_label = "m>=3", prior_region = "nu0",
    prior_label = "nu=0", conditions = c("m>=3", "nu=0")
  ),
  list(
    cell_id = "N4V4-CELL-MGE3-LOW", equilibrium_id = "N4V4-EQ-MGE3-LOW",
    m_class = "mge3", m_label = "m>=3", prior_region = "low",
    prior_label = "0<nu<=nu_star", conditions = c("m>=3", "0<nu<=nu_star")
  ),
  list(
    cell_id = "N4V4-CELL-MGE3-HIGH", equilibrium_id = "N4V4-EQ-MGE3-HIGH",
    m_class = "mge3", m_label = "m>=3", prior_region = "high",
    prior_label = "nu_star<nu<=1", conditions = c("m>=3", "nu_star<nu<=1")
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
      equilibrium_records = list(make_record(spec)),
      nonexistence_certificate = NULL
    )
  })
)

all_equilibrium_ids <- vapply(cell_specs, `[[`, character(1), "equilibrium_id")

make_claim <- function(index, branch, claim, evidence_section, status = "proved") {
  list(
    claim_id = sprintf("N4V4-CLM-%03d", index),
    equilibrium_ids = as.list(all_equilibrium_ids),
    branch = branch,
    payoff_date = "R1",
    claim = claim,
    status = status,
    evidence = paste0(
      "model_redesign/essential_input_n4_r1_unanimity_derivation_v4.md#",
      evidence_section
    )
  )
}

claims <- list(
  make_claim(1, "continuation", "N4 consumes only frozen N2 at its exact hash; low-type-only has weak realized vector (A,0), pooling has (B,B), and discount enters exactly once.", "importacao-fechada-de-n2"),
  make_claim(2, "oracle", "The independent R oracle enumerates every simultaneous ballot vector and applies weak stage-undominance before sequential best response and T^Y.", "oracle-vetorial-do-ballot", "checked numerically"),
  make_claim(3, "exhaustion", "The on-path pure classes are exactly P, L at nu=0, and D; high-only never exists.", "classes-on-path-exaustivas"),
  make_claim(4, "weak_ballots", "P/L require x_j>=B; H-veto and weak-veto bounds are the exact piecewise restrictions stated in the interface.", "respostas-weak-exatas"),
  make_claim(5, "security_m_ge_3", "For m>=3 the exact attained proposer security is S_3=(1-nu)B; no proposal forces passage.", "security-para-m3"),
  make_claim(6, "security_m_2", "For m=2 the exact security supremum is S_2=max{R_0,R_L,R_P}, with the three components and x-region exhaustion stated in the interface.", "security-para-m2"),
  make_claim(7, "topology", "R_0 is attained, positive R_P is not, R_L has the exact strict attainment condition, and H_tie governs only proposal-payoff equality.", "security-para-m2"),
  make_claim(8, "pooling", "Pooling exists universally with exact floors, residual rule, Y cap, endpoint topology, slack, and heterogeneous allocations preserved.", "familias-puras-e-endpoints"),
  make_claim(9, "low_type_only", "Low-type-only exists exactly at nu=0 with Y in [ell,h), x_j>=B, r_i>=S, and its full endpoint rule.", "familias-puras-e-endpoints"),
  make_claim(10, "delay", "Delay exists universally for m>=3 and iff C>=S_2 for m=2, with equality retained and every H/weak-veto constructor parameterized.", "familias-puras-e-endpoints"),
  make_claim(11, "nonexistence", "High-only, positive-prior low-only, and H separation with a weak veto are impossible under PBE, Bayes, and T^Y.", "classes-on-path-exaustivas"),
  make_claim(12, "multi_veto", "For m>=3 and at least two weak vetoes, every feasible package is sustainable when nu<nu_star; when nu>=nu_star sustainability holds exactly when every veto k receives x_ik<=B, including equality. This on-path bound does not alter the zero-probability security punishment; m=2 has no such set.", "respostas-weak-e-correcao-multi-veto"),
  make_claim(13, "proposal_mixing", "The only cross-branch proposer mixtures are L/D at nu=0 and P/D above nu_star on the exact equal-payoff loci, conditional on delay availability.", "multiplicidade-misturas-e-payoffs"),
  make_claim(14, "identity", "The full Cartesian product of locally admissible labeled proposer-identity assessments is retained without symmetry or equilibrium selection.", "multiplicidade-misturas-e-payoffs"),
  make_claim(15, "weak_payoffs", "Weak pre-recognition payoffs are the identity-indexed vector V_Wk=(R_k+sum_{i!=k}w_ik)/m.", "multiplicidade-misturas-e-payoffs"),
  make_claim(16, "H_and_outcomes", "H payoffs and R1 outcomes are the exact identity/strategy averages of the local P/L/D maps; passage without H and terminal R1 failure are zero.", "multiplicidade-misturas-e-payoffs"),
  make_claim(17, "beliefs", "On-path weak actions are noninformative; every positive-probability failure uses Bayes and every zero-probability vector retains an explicit free posterior.", "p0-e-p3-p7"),
  make_claim(18, "slack", "P0 is refuted as universal: slack proposals survive because filling slack changes the exact proposal and may change its off-path response.", "p0-e-p3-p7"),
  make_claim(19, "coverage", "Six mutually exclusive and exhaustive cells cover m>=2 and nu in [0,1]; pooling makes every top-level cell nonempty and missing families carry certificates.", "cobertura-e-transporte"),
  make_claim(20, "provenance", "The sealed v4 cold derivation preserves every v3 result confirmed by both reviews and applies only the localized on-path multi-veto repair plus independent full semantic certification.", "lifecycle-e-fronteira"),
  make_claim(21, "negative_fixtures", "Independent executable fixtures reject the on-path m=3 high-prior two-veto package at x_1=x_2=.30>B=.12, accept the exact boundary x_1=x_2=B=.12, preserve the v3 ballot fixtures, and reject Bayes, N2, domain, endpoint, payoff, and primitive corruption.", "fixture-de-fronteira", "checked numerically"),
  make_claim(22, "semantic_certificate", "Every scalar or null leaf of the candidate and ledger is certified exactly once by an independent structural or parsed-semantic rule; AST normal forms reject coordinated candidate-builder corruption, self-negation, and fixture-vanishing polynomial terms.", "interface-preservada-e-certificacao-integral", "checked numerically")
)

build_outputs <- function(interface_target, ledger_target) {
  write_canonical_json(interface, interface_target)
  interface_hash <- sha256_file(interface_target)
  ledger <- list(
    ledger_schema = "essential_input_claim_ledger_v1",
    node_id = "N4",
    artifact_path = "model_redesign/essential_input_interfaces/n4_r1_unanimity_candidate_v4.json",
    artifact_hash = paste0("sha256:", interface_hash),
    cold_note_path = "model_redesign/essential_input_n4_r1_unanimity_cold_notes_v4.md",
    cold_note_hash = cold_hash,
    node_status = "pending_independent_review",
    claims = claims
  )
  write_canonical_json(ledger, ledger_target)
  invisible(list(
    interface_hash = interface_hash,
    ledger_hash = sha256_file(ledger_target)
  ))
}

if (check_mode) {
  interface_tmp <- tempfile("n4-v4-interface-", fileext = ".json")
  ledger_tmp <- tempfile("n4-v4-ledger-", fileext = ".json")
  on.exit(unlink(c(interface_tmp, ledger_tmp)), add = TRUE)
  hashes <- build_outputs(interface_tmp, ledger_tmp)
  assert_true(file.exists(interface_path), "Canonical N4 v4 interface is missing.")
  assert_true(file.exists(ledger_path), "Canonical N4 v4 ledger is missing.")
  assert_true(
    identical_bytes(interface_tmp, interface_path),
    "Canonical N4 v4 interface is not build-stable."
  )
  assert_true(
    identical_bytes(ledger_tmp, ledger_path),
    "Canonical N4 v4 ledger is not build-stable."
  )
  cat("PASS: N4 v4 build is byte-stable\n")
  cat("interface_sha256=", hashes$interface_hash, "\n", sep = "")
  cat("ledger_sha256=", hashes$ledger_hash, "\n", sep = "")
} else {
  dir.create(dirname(interface_path), recursive = TRUE, showWarnings = FALSE)
  dir.create(dirname(ledger_path), recursive = TRUE, showWarnings = FALSE)
  hashes <- build_outputs(interface_path, ledger_path)
  cat("PASS: built N4 v4 candidate artifacts\n")
  cat("interface_sha256=", hashes$interface_hash, "\n", sep = "")
  cat("ledger_sha256=", hashes$ledger_hash, "\n", sep = "")
}
