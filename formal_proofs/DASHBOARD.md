# Lean Verification Dashboard

**Project**: Informational Power: Bayesian Persuasion, Legislative Bargaining, and Institutional Design  
**Last updated**: 2026-05-10  
**Status**: STALE_REQUIRES_RECLASSIFICATION  
**Reason**: The previous dashboard used generic `VERIFIED` labels. The 2026-05-10 post-mortem showed that this is unsafe because some Lean proofs formalized old formulas or conditional logic rather than the current paper's economic claims.

## Current Summary

| Status | Count |
|--------|------:|
| END_TO_END_VERIFIED | 0 |
| ALGEBRA_VERIFIED_FROM_FORMULAS | 0 |
| CONDITIONAL_VERIFIED | 0 |
| PARTIAL | 0 |
| STALE | 8 |
| FAILED | 0 |
| NOT_FORMALIZED | 0 |
| **Total previously listed results** | **8** |

No previous `VERIFIED` claim should be cited until the result is reclassified under the new pipeline.
Three old v1 entries remain in `.proof_index.json` under `archived_results`; they are not part of the active dashboard counts.

## Required Reclassification

| # | Result | Previous Lean files | Current status | Required before upgrade |
|---|--------|---------------------|----------------|-------------------------|
| 1 | Proposition 1 (Majority: no screening) | `Props/Prop1.lean`, `V5/Prop1.lean` | STALE | Recheck majority formulas under external outside option; derive exclusion and weak-state continuation values. |
| 2 | Proposition 2 (Overpayment under unanimity) | `Props/Prop2.lean`, `V5/Prop2.lean` | STALE | Recheck branch conditions and current statement. |
| 3 | Proposition 3 (R1 screening cutoff) | `Props/Prop3.lean`, `V5/Prop3.lean` | STALE | Recheck branch-dependent cutoff and tie-breaking/limits. |
| 4 | Proposition 4 (Screening rent / institutional classification) | `Props/Prop4.lean`, `V5/Prop4.lean`, `V5/Corollary.lean` | STALE | Reprove formation-set nesting and `lambda_M_ext > alpha` condition; no generic budget identity. |
| 5 | Proposition 5 (Persuasion/non-convexity) | `Props/Prop5.lean` | STALE | Recheck value function statement against current paper. |
| 6 | Lemma/Theorem conditional payoff dominance | `Lemma1/*.lean`, `V5/Theorem1.lean` | STALE | Replace old `P = beta(q-1)(1-alpha)` and old `alpha_star`; prove corrected external-option threshold. |
| 7 | Theorem 1 (Threshold prior / institutional choice) | `Theorem1/*.lean` | STALE | Reclassify conditional hypotheses and concavification assumptions; adversarial pass required. |
| 8 | Proposition 6 (Agenda influence) | `Props/Prop6.lean` | STALE | Recheck statement and dependencies against current paper. |

## New Gates

Each result must record:

- `paper_statement_hash`
- `paper_definitions_hash`
- `lean_file_hash`
- qualified status: `END_TO_END_VERIFIED`, `ALGEBRA_VERIFIED_FROM_FORMULAS`, `CONDITIONAL_VERIFIED`, `PARTIAL`, `STALE`, `FAILED`, or `NOT_FORMALIZED`
- unverified assumptions, if any
- numeric audit script/status when applicable
- adversarial report path/status

No verified-like status is valid without `PASS_SEM_RESSALVAS` from a Lean adversarial review.
