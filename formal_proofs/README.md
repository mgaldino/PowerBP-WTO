# Lean proof pipeline

This directory contains internal Lean checks for the paper. A passing Lean build is not, by itself, evidence that the paper's proofs are correct.

## Required status labels

Use only these labels in dashboards and reports:

- `END_TO_END_VERIFIED`: Lean derives the conclusion from model primitives, the current paper hashes match, and adversarial review passes without reservations.
- `ALGEBRA_VERIFIED_FROM_FORMULAS`: Lean verifies algebra from explicit formulas, but the economic derivation of those formulas is outside Lean.
- `CONDITIONAL_VERIFIED`: Lean verifies a conditional theorem whose assumptions are explicit and accepted by adversarial review.
- `PARTIAL`: there are `sorry`s, omitted cases, missing numeric checks, or missing adversarial review.
- `STALE`: the paper statement or model definitions no longer match the Lean formalization.
- `FAILED`: scaffold, proof, or build fails.
- `NOT_FORMALIZED`: no Lean formalization exists.

Do not use a generic `VERIFIED` status.

## Gates

Every formal result must pass these gates before being reported as verified in any qualified sense:

1. **Fidelity gate**: identify the canonical paper file, statement lines, model definitions, paper hash, definitions hash, Lean files, and theorem names.
2. **Primitive-first gate**: if a result depends on payoff formulas, define primitives and derive coefficients from them whenever feasible. If formulas are assumed, the maximum status is `ALGEBRA_VERIFIED_FROM_FORMULAS`.
3. **Build gate**: `lake build` must pass with no `sorry` for any verified-like status.
4. **Numeric gate**: algebraic identities, thresholds, branches, endpoints, budget identities, and feasibility constraints need an R contracheck when applicable.
5. **Adversarial gate**: a separate adversarial reviewer must return `PASS_SEM_RESSALVAS` for the exact status claimed. Any material reservation blocks the pipeline.
6. **Dashboard gate**: `DASHBOARD.md` and `.proof_index.json` must record the qualified status, hashes, unverified assumptions, numeric audit status, and adversarial review path.

The adversarial pass is status-specific: a reviewer may pass `CONDITIONAL_VERIFIED` if all assumptions are explicit and the report does not claim more than conditional logic.
