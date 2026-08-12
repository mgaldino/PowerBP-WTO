# Pivotal-response rederivation — institutional-comparison independent review

**Date:** 2026-08-12  
**Node:** `institutional_comparison`  
**Reviewed interface:** `sha256:cab69c5ddda3616f51c697c189c86316df5546501a183eb6cc9e437dc813f3af`  
**Overall verdict:** **PASS**

## Exact dependency lock

The reviewers evaluated the candidate against the exact approved inputs:

```text
entry_batch_review_v1.json
  sha256:8817a9c505ce9e5b79deea1b38055d88a629e740e324fbcd5bca707b108b5433

entry_unanimity_v1.json
  sha256:05e39ad2b84ede134268ffae0898c8cafd8f3de01ef725ca2da6159156a83ed6

entry_majority_v1.json
  sha256:4eb343ce6f6fb7c34782e708a0e787908437d2682d079e91f26103706c083f21
```

The reviewed candidate makes no change to C2, R1, or entry and adds no new
discount. Its comparison index is the full Cartesian product of whole entry
assessments under the two fixed counterfactual rules.

## Independent verdicts

The formal/cold reviewer remained read-only and returned **PASS** at order 56
on the exact interface hash above, with `0` critical, `0` major, and `0` minor
findings.

The adversarial reviewer independently remained read-only and returned
**PASS** at order 57 on the same exact hash, with `0` critical, `0` major, and
`0` minor findings.

Both reviews accepted the candidate without repair. There is therefore no
rejected comparison hash and no comparison repair history.

## Accepted scope

The approvals cover the exact set-valued comparison correspondence, including:

- the uncoupled Cartesian product of complete U and M assessments;
- pairwise formation, weak-payoff, H-type-payoff, and true-prior operators;
- pairwise formation sets, possible-cost unions, guaranteed-cost
  intersections, and universal cross-assessment nesting as distinct objects;
- endpoint-attainment logic at equality;
- the H outside-option floor and conditional rankings for `both`, `U_only`,
  `M_only`, and `neither`;
- the special `N>=4` endpoint consequences and the explicit `N=3` limits; and
- the absence of endogenous rule choice, cross-rule assessment coupling, or a
  general numerical institutional-dominance claim.

The accepted interface remains set-valued. A survival-matrix consumer may
inventory exact, conditional, rejected, and pending claims, but may not select
an assessment pair or promote an unidentified endpoint ordering.

## Mechanical evidence

The official candidate verifier was rerun on the approved bytes:

```sh
Rscript --vanilla scripts/verify_pivotal_response_institutional_comparison.R
```

Result: **42/42 PASS**. The run included exact dependency closure, 310 finite
endpoint cases, 9,610 Cartesian status cases, 961 value-set pairs, 96 complete
asymmetric assessment pairs, dependency mutations, and all 27 protected
hashes.

The dependency-complete review bundle is:

```text
model_redesign/pivotal_response_interfaces/institutional_comparison_review_v1.json
sha256:0acd9648eb7e03d4dabfaa91ffd559fe3c5b6f61a96ba676d6c6ccd9d4c6bb3c
```

It hashes the three exact dependencies, the approved comparison interface,
derivation note, immutable candidate-status snapshot, node verifier, all four
comparison tables, and the protected-artifact manifest.

## Closure decision

The node is frozen **PASS** at order 60 after mechanical closure at order 59.
Exactly `v6_survival_matrix` is authorized and ready next. It remains pending
and unstarted; no survival artifact or manuscript edit is part of this review.

