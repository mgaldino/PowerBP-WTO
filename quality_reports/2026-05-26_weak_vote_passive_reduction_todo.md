# Weak-Vote-Passive Reduction: weak-caused failures

Date opened: 2026-05-26
Status updated: 2026-06-01
Target manuscript: `formal_model_v6.Rmd`

## Status

Completed for the weak-caused-failure branch.

The manuscript now replaces the old belief-assessment clause for designed
weak-caused failures with a local pure-strategy incentive-compatibility lemma.
The weak-vote-passive assessment remains in force for the other off-path cases:
weak-voter deviations and deviations by `H` from pooling prescriptions.

## Local derivation

The proposal and all weak-state allocations are public. If a public proposal
gives at least one necessary weak voter less than its continuation value, that
weak voter rejects and the ballot fails regardless of `H`'s vote. `H`'s ballot
is therefore non-outcome-determining for current passage.

The local question is whether this nonpivotal vote can sustain informative
pure-strategy signaling and create a fourth rejected-history candidate.

For an interior belief `mu in (0,1)`, a separating nonpivotal voting prescription
would assign different ballots `v_0` and `v_1` to the low and high types. Bayes'
rule would then assign posterior `0` after `v_0` and posterior `1` after `v_1`.
The continuation payoffs are:

```text
C_1(nu) = o_1
C_0(1)  = o_0 + t_1 - t_0
C_0(0)  = o_0
```

Under the Threshold Order, `t_1 > t_0`, so the low type strictly prefers the
high-posterior ballot. The low type therefore mimics any high-type vote that
induces posterior one. Separating nonpivotal voting is not incentive compatible.
If `H` pools on a nonpivotal ballot, Bayes leaves the on-path posterior at `mu`.
Thus weak-caused failures are payoff-equivalent to no-information delay `D`
within the selected pure-strategy analysis.

This is a local result only. It is not an equilibrium refinement, does not
introduce D1, Intuitive Criterion, sequential equilibrium, trembling hand,
stationarity, or a new signaling model, and does not characterize all
unrestricted PBEs.

## Manuscript changes

- `formal_model_v6.Rmd`: removed the old weak-caused-failure belief clause from
  Definition 2.
- `formal_model_v6.Rmd`: added Lemma `Weak-caused failures and nonpivotal H
  votes`.
- `formal_model_v6.Rmd`: updated the rejected-history reduction, R1 proposition,
  Appendix A.3 proof, assessment-scope table, and discussion language.
- `math_guide_proofs.Rmd`: added a Portuguese explanation of the local lemma and
  renumbered the rejected-history discussion in the guide as the next lemma.

## Independent read-only review

Reviewer 1: `game-theory-audit`, focused on PBE, voting, signaling, and
incentive compatibility.

Verdict: **APPROVED WITH ONLY NON-BLOCKING EDITORIAL ISSUES**.

Summary: The reviewer approved the IC logic. In weak-caused failures, current
passage is already impossible; a separating nonpivotal `H` ballot gives the low
type a strict incentive to mimic the high-posterior ballot, while pooling
nonpivotal ballots leave the on-path posterior at `mu` by Bayes.

Reviewer 2: adversarial formal-model-writing review, focused on algebra,
quantifiers, domain restrictions, and scope.

Verdict: **APPROVED WITH ONLY NON-BLOCKING EDITORIAL ISSUES**.

Summary: The reviewer found no substantive proof gap. The proof correctly uses
`C_1(nu)=o_1`, `C_0(1)=o_0+t_1-t_0`, and `C_0(0)=o_0`; it narrows rather than
overclaims the weak-vote-passive assessment.

## Editorial fixes after review

- Tightened the proof language so it does not claim to analyze every possible
  pooling prescription under arbitrary off-path beliefs.
- Added endpoint-belief scope language to Proposition R1.
- Clarified that the relevant weak voter rejects regardless of `H`'s ballot.

## Remaining uses of weak-vote-passive assessment

The proof repair does not remove the weak-vote-passive assessment globally.
Remaining necessary uses are:

1. Weak-voter deviations in accepted or separating candidates such as `P` and
   `L`.
2. Off-path beliefs after deviations by `H` from pooling yes or pooling no
   prescriptions.
3. The selected R1 candidate comparison outside the local weak-caused-failure
   branch.

## Compilation

Completed on 2026-06-01.

- `rmarkdown::render("formal_model_v6.Rmd")` completed successfully and created
  `formal_model_v6.pdf`.
- `rmarkdown::render("math_guide_proofs.Rmd")` completed successfully and
  created `math_guide_proofs.pdf`.
- `pdfinfo formal_model_v6.pdf`: 51 pages, creation time 2026-06-01 14:59:27
  -03.
- `pdfinfo math_guide_proofs.pdf`: 20 pages, creation time 2026-06-01 14:59:33
  -03.
