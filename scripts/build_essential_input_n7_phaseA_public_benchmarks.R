#!/usr/bin/env Rscript

# Build the public-benchmark-only intermediate candidate for N7 Phase A.
# The script derives no object from private-equilibrium records and leaves all
# informational-rent collections null. N7 remains pending and unfrozen.

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

args <- commandArgs(trailingOnly = TRUE)
repo <- if (length(args) >= 1L) {
  normalizePath(args[[1L]], mustWork = TRUE)
} else {
  normalizePath(".", mustWork = TRUE)
}

path_dag <- file.path(repo, "model_redesign", "essential_input_game_dag.json")
path_candidate <- file.path(
  repo, "model_redesign",
  "essential_input_n7_phaseA_public_benchmarks_candidate_v1.json"
)
path_ledger <- file.path(
  repo, "model_redesign",
  "essential_input_n7_phaseA_public_benchmarks_ledger.json"
)

expected_n6_hash <- paste0(
  "sha256:",
  "e5a71e29720598f829beb4f720bc966a64d2b04569ded0ba404cdd03b81b3f2a"
)

read_utf8_json <- function(path) {
  jsonlite::fromJSON(path, simplifyVector = FALSE)
}

write_utf8_json <- function(object, path) {
  jsonlite::write_json(
    object, path, auto_unbox = TRUE, pretty = TRUE, null = "null",
    digits = NA, dataframe = "rows", force = TRUE
  )
}

sha256_file <- function(path) {
  out <- system2(
    "shasum", c("-a", "256", shQuote(path)), stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  if (length(out) != 1L) stop("Could not hash: ", path, call. = FALSE)
  digest <- strsplit(out[[1L]], "[[:space:]]+")[[1L]][1L]
  if (!grepl("^[0-9a-f]{64}$", digest)) {
    stop("Malformed hash: ", path, call. = FALSE)
  }
  paste0("sha256:", digest)
}

find_node <- function(dag, node_id) {
  hits <- Filter(function(node) identical(node$id, node_id), dag$nodes)
  if (length(hits) != 1L) stop("DAG node not unique: ", node_id, call. = FALSE)
  hits[[1L]]
}

dag <- read_utf8_json(path_dag)
n6 <- find_node(dag, "N6")
n7 <- find_node(dag, "N7")
stopifnot(
  identical(n6$status, "pass"),
  identical(n6$frozen, TRUE),
  identical(n6$artifact_hash, expected_n6_hash),
  identical(n7$status, "pending"),
  is.null(n7$frozen),
  is.null(n7$artifact_hash),
  is.null(n7$reviews)
)

theta_tag <- function(theta) paste0("T", theta)
theta_name <- function(theta) paste0("theta_", theta)
o_name <- function(theta) paste0("o_", theta)

common_domain <- function(theta) {
  list(
    paste0("theta=", theta, " is public from t=0"),
    "beta in (0,1)",
    "0<o_0<o_1<1 and o_1<=y_bar<=1",
    "m=N-1 is an integer and m>=2",
    paste0("write o=", o_name(theta), " in this public game")
  )
}

belief_system <- function(theta) {
  list(
    type_information = paste0("theta=", theta, " is common knowledge from t=0"),
    on_path = paste0("Pr(theta=", theta, ")=1 after every on-path history"),
    off_path = paste0(
      "Pr(theta=", theta,
      ")=1 after every zero-probability proposal and vote history; no free type belief remains"
    ),
    multiplicity = "none: belief differences do not generate additional public assessments"
  )
}

record <- function(
    equilibrium_id, institution, round, theta, admissibility_conditions,
    branch_classification, strategy_profile, source_public_continuation_ids,
    existence_uniqueness_status, selection_status, assumptions_used,
    checks_performed, payoff_vector, outcome_distribution, payoff_date) {
  list(
    public_equilibrium_id = equilibrium_id,
    institution = institution,
    round = round,
    theta = theta,
    admissibility_conditions = admissibility_conditions,
    branch_classification = branch_classification,
    strategy_profile = strategy_profile,
    belief_system = belief_system(theta),
    source_public_continuation_ids = source_public_continuation_ids,
    existence_uniqueness_status = existence_uniqueness_status,
    selection_status = selection_status,
    assumptions_used = assumptions_used,
    checks_performed = checks_performed,
    payoff_vector = payoff_vector,
    outcome_distribution = outcome_distribution,
    payoff_date = payoff_date
  )
}

cell <- function(cell_id, domain_conditions, equilibrium_record) {
  list(
    cell_id = cell_id,
    domain_conditions = domain_conditions,
    existence_status = "exists",
    public_equilibrium_records = list(equilibrium_record),
    nonexistence_certificate = NULL
  )
}

r2_record_id <- function(institution, theta, m_group) {
  paste(
    "N7A-PUB",
    if (identical(institution, "majority")) "M" else "U",
    "R2", theta_tag(theta), toupper(m_group), sep = "-"
  )
}

make_r2_majority <- function(theta, m_group) {
  o <- o_name(theta)
  id <- r2_record_id("majority", theta, m_group)
  m_condition <- if (identical(m_group, "m2")) "m=2" else "m>=3"
  rec <- record(
    equilibrium_id = id,
    institution = "majority",
    round = "R2",
    theta = theta,
    admissibility_conditions = c(common_domain(theta), list(m_condition)),
    branch_classification = list(
      outcome_branch = "immediate passage without H",
      equilibrium_form = "unique pure proposal and pure ballot strategies",
      identity_symmetry = "symmetric",
      parameter_location = "terminal solution; y=0 is the lower feasibility boundary and there is no branch-parameter frontier",
      payoff_or_outcome_difference = "none within the public correspondence",
      belief_only_multiplicity = "none"
    ),
    strategy_profile = list(
      proposer = "For every recognized weak proposer i: y=0, every x_j=0, r_i=1.",
      weak_nonproposers = "Vote yes after every proposal; positive x_j weakly favors yes and x_j=0 is resolved to yes by T^Y.",
      hegemon = paste0(
        "Before the simultaneous ballot, the proposal-induced pure weak strategies prescribe all m weak yes votes, which meet q<=m; vote no because no yields y+",
        o, " rather than y."
      ),
      proposal_mixing = "none"
    ),
    source_public_continuation_ids = list(),
    existence_uniqueness_status = "unique assessment, outcome, and payoff vector",
    selection_status = "Phase A public benchmark only; no additional selection and no public-private pairing",
    assumptions_used = c(common_domain(theta), list(
      "q=floor((m+1)/2)+1<=m",
      "R2 is terminal and contains no beta"
    )),
    checks_performed = list("N7A-C01", "N7A-C02", "N7A-C13"),
    payoff_vector = list(
      recognized_proposer_payoff = "1",
      weak_nonproposer_pre_recognition_expected_value = "1/m",
      hegemon_payoff = o
    ),
    outcome_distribution = list(
      pass_with_hegemon = 0,
      pass_without_hegemon = 1,
      failure = 0,
      delay = 0
    ),
    payoff_date = "t=2 native units; no beta"
  )
  cell(
    paste0(id, "-CELL"),
    c(common_domain(theta), list(m_condition)),
    rec
  )
}

make_r2_unanimity <- function(theta, m_group) {
  o <- o_name(theta)
  id <- r2_record_id("unanimity", theta, m_group)
  m_condition <- if (identical(m_group, "m2")) "m=2" else "m>=3"
  rec <- record(
    equilibrium_id = id,
    institution = "unanimity",
    round = "R2",
    theta = theta,
    admissibility_conditions = c(common_domain(theta), list(m_condition)),
    branch_classification = list(
      outcome_branch = "immediate passage with H",
      equilibrium_form = "unique pure proposal and pure ballot strategies",
      identity_symmetry = "symmetric",
      parameter_location = paste0("offer boundary y=", o, "; proposer strictly prefers agreement because 1-", o, ">0"),
      payoff_or_outcome_difference = "none within the public correspondence",
      belief_only_multiplicity = "none"
    ),
    strategy_profile = list(
      proposer = paste0(
        "For every recognized weak proposer i: y=", o,
        ", every x_j=0, r_i=1-", o, "."
      ),
      weak_nonproposers = "Vote yes after every proposal by terminal stage-undominance and T^Y at x_j=0.",
      hegemon = paste0(
        "Before the simultaneous ballot, all pure weak strategies prescribe yes; vote yes iff y>=",
        o, "; T^Y selects yes at equality. H never conditions on realized votes."
      ),
      proposal_mixing = "none"
    ),
    source_public_continuation_ids = list(),
    existence_uniqueness_status = "unique assessment, outcome, and payoff vector",
    selection_status = "Phase A public benchmark only; no additional selection and no public-private pairing",
    assumptions_used = c(common_domain(theta), list(
      "unanimity quota q=m+1",
      "R2 is terminal and contains no beta",
      paste0(o, "<1 leaves strictly positive weak residual")
    )),
    checks_performed = list("N7A-C01", "N7A-C03", "N7A-C13"),
    payoff_vector = list(
      recognized_proposer_payoff = paste0("1-", o),
      weak_nonproposer_pre_recognition_expected_value = paste0("(1-", o, ")/m"),
      hegemon_payoff = o
    ),
    outcome_distribution = list(
      pass_with_hegemon = 1,
      pass_without_hegemon = 0,
      failure = 0,
      delay = 0
    ),
    payoff_date = "t=2 native units; no beta"
  )
  cell(
    paste0(id, "-CELL"),
    c(common_domain(theta), list(m_condition)),
    rec
  )
}

majority_region_condition <- function(theta, m_group, region) {
  o <- o_name(theta)
  threshold <- if (identical(m_group, "m2")) "1/2" else "1/m"
  sign <- switch(region, lt = "<", eq = "=", gt = ">")
  paste(o, sign, threshold)
}

majority_coalition_text <- function(m_group, branch) {
  if (identical(m_group, "m2")) {
    if (identical(branch, "inclusion")) {
      return("C_i^I is the unique empty set of size q-2=0; equivalently F_i is degenerate on that set, with no proposal mixing.")
    }
    return("C_i^E is the unique other weak state of size q-1=1; equivalently F_i is degenerate on that set, with no proposal mixing.")
  }
  if (identical(branch, "inclusion")) {
    return(paste0(
      "For each identity i, F_i is any probability distribution over subsets ",
      "C_i^I of W\\{i} with size q-2. Degenerate F_i are pure identity-asymmetric ",
      "coalition choices; uniform F_i is symmetric; all mixing is within the inclusion branch."
    ))
  }
  paste0(
    "For each identity i, F_i is any probability distribution over subsets ",
    "C_i^E of W\\{i} with size q-1. The set is singleton at m=3 and has multiple ",
    "members at m>=4; all mixing is within the exclusion branch."
  )
}

make_r1_majority <- function(theta, m_group, region) {
  o <- o_name(theta)
  branch <- if (region %in% c("lt", "eq")) "inclusion" else "exclusion"
  region_word <- switch(region, lt = "strict inclusion region", eq = "inclusion-exclusion boundary", gt = "strict exclusion region")
  domain_tag <- paste0(toupper(m_group), "-", toupper(region))
  id <- paste("N7A-PUB-M-R1", theta_tag(theta), domain_tag, sep = "-")
  m_condition <- if (identical(m_group, "m2")) "m=2" else "m>=3"
  region_condition <- majority_region_condition(theta, m_group, region)
  r_expr <- if (identical(branch, "inclusion")) {
    paste0("1-beta*", o, "-beta*(q-2)/m")
  } else {
    "1-beta*(q-1)/m"
  }
  h_expr <- if (identical(branch, "inclusion")) paste0("beta*", o) else o
  coalition_size <- if (identical(branch, "inclusion")) "q-2" else "q-1"
  coalition_name <- if (identical(branch, "inclusion")) "C_i^I" else "C_i^E"
  y_expr <- if (identical(branch, "inclusion")) paste0("beta*", o) else "0"
  pass_with_h <- if (identical(branch, "inclusion")) 1 else 0
  pass_without_h <- 1 - pass_with_h
  multiplicity <- majority_coalition_text(m_group, branch)
  weak_value <- list(
    type = "identity-indexed map; symmetry is not imposed when F_i varies",
    by_weak_state_k = paste0(
      "C_k=(1/m)*(", r_expr,
      ")+(beta/m^2)*sum_{i!=k} Pr_{C~F_i}(k in ", coalition_name, ")"
    ),
    symmetric_uniform_special_case = paste0(
      "Use uniform F_i over size-", coalition_size,
      " coalitions for an anonymous symmetric benchmark."
    ),
    cross_identity_mean = if (identical(branch, "inclusion")) {
      paste0("(1-beta*", o, ")/m")
    } else {
      "1/m"
    }
  )
  if (identical(m_group, "m2")) {
    uniqueness <- "unique assessment, outcome, and full payoff vector"
  } else if (identical(branch, "exclusion")) {
    uniqueness <- paste0(
      "unique branch, outcome, H payoff, and proposer payoff; full weak payoff vector ",
      "is unique at m=3 and set-valued by coalition composition at m>=4"
    )
  } else {
    uniqueness <- paste0(
      "unique branch, outcome, H payoff, and proposer payoff; full weak payoff vector ",
      "is set-valued by coalition composition"
    )
  }
  boundary_note <- if (identical(region, "eq")) {
    paste0(
      "The authorized proposal tie-break selects inclusion because beta*", o,
      "<", o, "; exclusion and cross-branch mixing are not selected."
    )
  } else {
    "The selected branch is strictly cheaper for the proposer."
  }
  rec <- record(
    equilibrium_id = id,
    institution = "majority",
    round = "R1",
    theta = theta,
    admissibility_conditions = c(
      common_domain(theta), list(m_condition, region_condition),
      list("q=floor((m+1)/2)+1")
    ),
    branch_classification = list(
      outcome_branch = paste0("immediate passage ", if (pass_with_h == 1) "with H" else "without H"),
      equilibrium_form = if (identical(m_group, "m2")) {
        "unique pure proposal and pure ballot strategies"
      } else {
        "pure or mixed proposer strategies over payoff-equivalent coalitions; pure ballot strategies"
      },
      identity_symmetry = if (identical(m_group, "m2")) {
        "symmetric"
      } else {
        "symmetric uniform and identity-asymmetric coalition strategies are both retained"
      },
      parameter_location = region_word,
      payoff_or_outcome_difference = if (identical(m_group, "m2")) {
        "none"
      } else {
        "coalition choice may change weak identity payoffs only; branch, outcome, H payoff, and proposer payoff are invariant"
      },
      agreement_delay_mixing = "none because 1-beta*q/m>0",
      belief_only_multiplicity = "none"
    ),
    strategy_profile = list(
      proposer = paste0(
        "For recognized i: choose ", coalition_name, " of size ", coalition_size,
        "; set y=", y_expr,
        ", x_j=beta/m for j in ", coalition_name,
        ", x_j=0 otherwise, and r_i=", r_expr, "."
      ),
      coalition_correspondence = multiplicity,
      weak_nonproposers = "Vote yes iff x_j>=beta/m; T^Y selects yes at equality.",
      hegemon = paste0(
        "Before the simultaneous ballot, use the pure weak-vote count prescribed by the public proposal: vote no if the quota passes without H; ",
        "if pivotal vote yes iff y>=beta*", o,
        "; if the quota fails regardless, T^Y selects yes. H never conditions on realized votes."
      ),
      boundary_selection = boundary_note,
      proposal_mixing = if (identical(m_group, "m2")) {
        "none"
      } else {
        "allowed only among payoff-equivalent coalition proposals inside the selected branch"
      }
    ),
    source_public_continuation_ids = list(r2_record_id("majority", theta, m_group)),
    existence_uniqueness_status = uniqueness,
    selection_status = paste0(
      "Phase A public benchmark only. Proposer payoff is maximized first and expected H payoff is minimized second; ",
      "no symmetry restriction, no agreement-delay selection, and no public-private pairing is added."
    ),
    assumptions_used = c(
      common_domain(theta), list(m_condition, region_condition),
      list(
        "R2 majority continuation is the same-rule same-type public record cited in source_public_continuation_ids",
        "beta enters exactly once when R2 enters R1",
        "ballot strategies are pure"
      )
    ),
    checks_performed = list(
      "N7A-C01", "N7A-C04", "N7A-C05", "N7A-C06", "N7A-C07",
      "N7A-C08", "N7A-C09", "N7A-C11", "N7A-C12", "N7A-C13"
    ),
    payoff_vector = list(
      recognized_proposer_payoff = r_expr,
      weak_nonproposer_pre_recognition_expected_value = weak_value,
      hegemon_payoff = h_expr
    ),
    outcome_distribution = list(
      pass_with_hegemon = pass_with_h,
      pass_without_hegemon = pass_without_h,
      failure = 0,
      delay = 0
    ),
    payoff_date = "t=1 current units; each R2 continuation threshold contains exactly one beta"
  )
  cell(
    paste0(id, "-CELL"),
    c(common_domain(theta), list(m_condition, region_condition)),
    rec
  )
}

make_r1_unanimity <- function(theta, m_group) {
  o <- o_name(theta)
  id <- paste("N7A-PUB-U-R1", theta_tag(theta), toupper(m_group), sep = "-")
  m_condition <- if (identical(m_group, "m2")) "m=2" else "m>=3"
  r_expr <- paste0("1-beta*(m-1+", o, ")/m")
  rec <- record(
    equilibrium_id = id,
    institution = "unanimity",
    round = "R1",
    theta = theta,
    admissibility_conditions = c(common_domain(theta), list(m_condition)),
    branch_classification = list(
      outcome_branch = "immediate passage with H",
      equilibrium_form = "unique pure proposal and pure ballot strategies",
      identity_symmetry = "symmetric",
      parameter_location = "all response cutoffs bind; agreement-delay margin is the strict interior value 1-beta>0",
      payoff_or_outcome_difference = "none within the public correspondence",
      agreement_delay_mixing = "none because 1-beta>0",
      belief_only_multiplicity = "none"
    ),
    strategy_profile = list(
      proposer = paste0(
        "For every recognized weak proposer i: y=beta*", o,
        ", every x_j=beta*(1-", o, ")/m, r_i=", r_expr, "."
      ),
      weak_nonproposers = paste0(
        "Vote yes iff x_j>=beta*(1-", o,
        ")/m; T^Y selects yes at equality."
      ),
      hegemon = paste0(
        "Before the simultaneous ballot, if the public proposal induces all pure weak strategies to prescribe yes, vote yes iff y>=beta*", o,
        "; if the prescribed weak profile makes failure certain regardless, T^Y selects yes. H never conditions on realized votes."
      ),
      proposal_mixing = "none",
      identity_roles = "no cooperative-versus-difficult proposer convention survives because immediate agreement beats delay strictly"
    ),
    source_public_continuation_ids = list(r2_record_id("unanimity", theta, m_group)),
    existence_uniqueness_status = "unique assessment, outcome, and full payoff vector",
    selection_status = "Phase A public benchmark only; no additional selection and no public-private pairing",
    assumptions_used = c(
      common_domain(theta), list(m_condition),
      list(
        "R2 unanimity continuation is the same-rule same-type public record cited in source_public_continuation_ids",
        "beta enters exactly once when R2 enters R1",
        "ballot strategies are pure"
      )
    ),
    checks_performed = list(
      "N7A-C01", "N7A-C04", "N7A-C05", "N7A-C06", "N7A-C10",
      "N7A-C11", "N7A-C12", "N7A-C13"
    ),
    payoff_vector = list(
      recognized_proposer_payoff = r_expr,
      weak_nonproposer_pre_recognition_expected_value = paste0("(1-beta*", o, ")/m"),
      hegemon_payoff = paste0("beta*", o)
    ),
    outcome_distribution = list(
      pass_with_hegemon = 1,
      pass_without_hegemon = 0,
      failure = 0,
      delay = 0
    ),
    payoff_date = "t=1 current units; each R2 continuation threshold contains exactly one beta"
  )
  cell(
    paste0(id, "-CELL"),
    c(common_domain(theta), list(m_condition)),
    rec
  )
}

theta_keys <- c("theta_0", "theta_1")
m_groups <- c("m2", "mge3")
regions <- c("lt", "eq", "gt")

public_cells <- list(
  majority = list(R2 = list(), R1 = list()),
  unanimity = list(R2 = list(), R1 = list())
)

for (theta in 0:1) {
  key <- theta_name(theta)
  public_cells$majority$R2[[key]] <- lapply(
    m_groups, function(group) make_r2_majority(theta, group)
  )
  public_cells$unanimity$R2[[key]] <- lapply(
    m_groups, function(group) make_r2_unanimity(theta, group)
  )
  public_cells$majority$R1[[key]] <- unlist(
    lapply(m_groups, function(group) {
      lapply(regions, function(region) make_r1_majority(theta, group, region))
    }),
    recursive = FALSE
  )
  public_cells$unanimity$R1[[key]] <- lapply(
    m_groups, function(group) make_r1_unanimity(theta, group)
  )
}

candidate <- list(
  schema_ref = "complete_information_benchmark_v1",
  function_of = list(name = "prior_mu", domain = "[0,1]"),
  public_equilibrium_cells = public_cells,
  informational_rent_cells = list(majority = NULL, unanimity = NULL),
  informational_rent_contrast_cells = NULL
)

write_utf8_json(candidate, path_candidate)
candidate_hash <- sha256_file(path_candidate)

claims <- list(
  list(claim_id = "N7A-C01", status = "proved", statement = "Public theta fixes a unique degenerate belief after every history."),
  list(claim_id = "N7A-C02", status = "proved", statement = "R2 majority uniquely passes without H at y=0, x=0, r_i=1."),
  list(claim_id = "N7A-C03", status = "proved", statement = "R2 unanimity uniquely passes with H at y=o_theta, x=0, r_i=1-o_theta."),
  list(claim_id = "N7A-C04", status = "proved", statement = "R2 is in native units and beta enters exactly once in R1 thresholds."),
  list(claim_id = "N7A-C05", status = "proved", statement = "R1 weak cutoffs are beta/m under majority and beta*(1-o_theta)/m under unanimity."),
  list(claim_id = "N7A-C06", status = "proved", statement = "The full H best response covers nonpivotal passage, pivotal passage, and certain failure."),
  list(claim_id = "N7A-C07", status = "proved", statement = "R1 majority reduces exhaustively to minimum-cost H inclusion or exclusion."),
  list(claim_id = "N7A-C08", status = "proved", statement = "The majority boundary is o_theta=1/m and the authorized proposal tie-break selects inclusion."),
  list(claim_id = "N7A-C09", status = "proved", statement = "Majority exclusion beats delay by 1-beta*q/m>0."),
  list(claim_id = "N7A-C10", status = "proved", statement = "Unanimity immediate agreement beats delay by 1-beta>0."),
  list(claim_id = "N7A-C11", status = "proved", statement = "All surviving proposer mixing is within a branch over payoff-equivalent coalitions; ballots remain pure."),
  list(claim_id = "N7A-C12", status = "proved", statement = "Formal coverage retains m=2 and m>=3; the principal substantive scope is m>=3."),
  list(claim_id = "N7A-C13", status = "proved", statement = "The Phase A candidate contains no private-record link and leaves all rent collections null."),
  list(claim_id = "N7A-C14", status = "pending", statement = "The author must choose substantively relevant public-private comparisons before Phase B.")
)

ledger <- list(
  schema_version = "essential-input-n7-phaseA-claim-ledger-v1",
  node_id = "N7",
  phase = "A",
  lifecycle_status = "intermediate_candidate_pending_unfrozen",
  candidate_path = "model_redesign/essential_input_n7_phaseA_public_benchmarks_candidate_v1.json",
  candidate_hash = candidate_hash,
  derivation_path = "model_redesign/essential_input_n7_phaseA_public_benchmarks_derivation.md",
  comparison_gate_path = "quality_reports/2026-08-19_n7_phaseA_comparison_gate_discussion.md",
  architectural_dependency = list(
    node_id = "N6",
    frozen_hash = expected_n6_hash,
    use_in_phase_A = "readiness only; no private equilibrium record is read or combined"
  ),
  forbidden_outputs = list(
    "public-private record pairing",
    "RI_M",
    "RI_U",
    "DeltaRI",
    "N7 pass or frozen lifecycle",
    "Goal 5 or manuscript migration",
    "beta=1 analysis"
  ),
  public_record_count = 24,
  claims = claims,
  review_state = "awaiting exactly two independent read-only reviews on candidate_hash",
  stop_condition = "After two PASS 0/0/0 reviews, report to the author and await explicit Phase B authorization."
)

write_utf8_json(ledger, path_ledger)

cat(candidate_hash, "\n", sep = "")
