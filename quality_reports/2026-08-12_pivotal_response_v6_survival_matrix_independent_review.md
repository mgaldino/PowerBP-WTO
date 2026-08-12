# Pivotal-response rederivation — v6 survival-matrix independent review

**Date:** 2026-08-12  
**Node:** `v6_survival_matrix`  
**Reviewed interface:** `sha256:5278b14d442d49d799b93323516fc081c9e7ed57a7ad2f794bfac3e7a5a27801`  
**Reviewed matrix:** `sha256:f634c46a764f9bacef13474be1c5f31371db8c42592f9699197191b94c0e0bd8`  
**Overall verdict:** **PASS**

## Exact dependency lock

The reviewers evaluated the candidate against the exact approved comparison
and its independent-review consumer contract:

```text
institutional_comparison_v1.json
  sha256:cab69c5ddda3616f51c697c189c86316df5546501a183eb6cc9e437dc813f3af

institutional_comparison_review_v1.json
  sha256:0acd9648eb7e03d4dabfaa91ffd559fe3c5b6f61a96ba676d6c6ccd9d4c6bb3c
```

The reviewed candidate is a claim-level, non-migrating inventory. Historical
sources locate candidate claims only; exact approved current interfaces provide
the evidence for each classification.

## Independent verdicts

Dirac, the formal/cold reviewer, remained read-only and returned **PASS** at
order 63 on the exact interface and matrix hashes above, with `0` critical,
`0` major, and `0` minor findings.

The adversarial game-theory reviewer independently remained read-only and
returned **PASS** at order 64 on the same exact hashes, with `0` critical, `0`
major, and `0` minor findings. That review audited all 53 source locators,
evidence pointers, taxonomy assignments, domain and selection qualifications,
manuscript actions, and migration blocks.

Both reviewers accepted the candidate without repair. There is therefore no
rejected survival-matrix hash and no repair history.

## Accepted scope

The approvals cover exactly:

- 53 claim-level rows with 11 mandatory fields;
- the six-status taxonomy `survives`, `conditional`, `changes`, `rejected`,
  `pending`, and `outside_scope`;
- the distinction between survival of a qualitative motif and survival of an
  exact theorem, scalar formula, or exhaustive characterization;
- exact historical source locators and current-evidence hashes and pointers;
- explicit domain, selection, manuscript-action, and migration-blocker fields;
- retention of all pending institutional comparisons as pending; and
- the prohibition on using this inventory as authority to edit or compile v5
  or v6.

The approvals do not select an equilibrium assessment, couple counterfactual
rules, establish a universal institutional ranking, or migrate any result into
a manuscript.

## Mechanical evidence

Both reviewers reran the official candidate verifier on the approved bytes:

```sh
Rscript --vanilla scripts/verify_pivotal_response_v6_survival_matrix.R
```

Result: **43/43 PASS**. The adversarial review also independently confirmed
**27/27** protected hashes. The close reran both checks with the same results.

The dependency-complete review bundle is:

```text
model_redesign/pivotal_response_interfaces/v6_survival_matrix_review_v1.json
sha256:80c912ba35fc46bdb1859edeb91402dcb63f52079cd3ca8c4aeeb4b98b0077a7
```

It hashes the exact comparison dependencies, complete current-evidence chain,
six survival-candidate artifacts, protected manifest, and four historical
inventory sources.

## Closure decision

The node is frozen **PASS** at order 67 after mechanical verification at order
66. Every node in the game DAG is now `pass`, and no node is ready. This is a
non-migrating close: `formal_model_v5.Rmd`, `formal_model_v6.Rmd`, their
outputs, and the shared derivation Rmd were not edited or compiled.

