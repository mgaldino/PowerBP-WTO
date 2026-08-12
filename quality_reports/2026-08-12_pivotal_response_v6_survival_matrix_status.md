# Pivotal-response rederivation — v6 survival-matrix candidate status

**Date:** 2026-08-12  
**Node:** `v6_survival_matrix`  
**Status:** **CANDIDATE PENDING TWO INDEPENDENT READ-ONLY REVIEWS**  
**Execution:** `implementation_started_order=61`, `candidate_serialized_order=62`

This implementation is limited to source-claim-granular survival
classification. It does not rederive a theorem, migrate text, edit or compile a
protected manuscript, or update the DAG, proof ledger, or shared derivation
Rmd.

## Exact approved dependencies

```text
Institutional comparison
  sha256:cab69c5ddda3616f51c697c189c86316df5546501a183eb6cc9e437dc813f3af

Independent comparison review bundle
  sha256:0acd9648eb7e03d4dabfaa91ffd559fe3c5b6f61a96ba676d6c6ccd9d4c6bb3c
```

## Candidate contents

- authoritative CSV: 53 claims, 11 exact columns;
- JSON consumer interface with frozen dependency, inventory, and evidence
  hashes;
- human-readable classification report;
- R verifier and generated check table;
- protected-target migration row explicitly `pending`.

```text
JSON interface
  model_redesign/pivotal_response_interfaces/v6_survival_matrix_v1.json
  sha256:5278b14d442d49d799b93323516fc081c9e7ed57a7ad2f794bfac3e7a5a27801

Authoritative CSV
  tables/pivotal_response_v6_survival_matrix_v1.csv
  sha256:f634c46a764f9bacef13474be1c5f31371db8c42592f9699197191b94c0e0bd8

Human-readable report
  model_redesign/pivotal_response_nodes/v6_survival_matrix_v1.md
  sha256:518a752388679dd51951299a8d9b13250945da53b21b80d122d47aacff23760b

R verifier
  scripts/verify_pivotal_response_v6_survival_matrix.R
  sha256:751c0d94c021a2bcd45e6aaaa081a52c95fc632041442b4e9fee6e4ebb080ed2

Check table
  tables/pivotal_response_v6_survival_matrix_checks_v1.csv
  sha256:6ec075d25f8c4cf121426a201e0a48a03e2f2026cf4594bdc7ab034bd1945370
```

Status counts are 9 `survives`, 13 `conditional`, 7 `changes`, 12 `rejected`,
6 `pending`, and 6 `outside_scope`. Action counts are 22
`retain_with_rewrite`, 10 `replace`, 9 `remove`, 6 `do_not_add`, and 6
`pending`.

## Verification

Command:

```sh
Rscript --vanilla scripts/verify_pivotal_response_v6_survival_matrix.R
```

Result: **43/43 PASS**.

The 43 checks include exact comparison dependencies, CSV shape and hash, all
historical locators, all current evidence hashes and JSON pointers, evidence
registry completeness, exact status/action locks, topic coverage, all 27
protected hashes, and seven blocking negative mutations.

## Handoff and migration block

The candidate is not frozen and is not consumable by manuscript integration.
Two independent reviewers must audit the exact candidate bytes read-only: one
formal-model review and one adversarial mathematical/game-theory review. Any
change to the CSV, JSON interface, comparison dependencies, cited evidence, or
protected inventory invalidates the candidate and requires both reviews again.

`formal_model_v6.Rmd` remains byte-identical at
`131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d`.
No migration, protected edit, or compilation occurred.
