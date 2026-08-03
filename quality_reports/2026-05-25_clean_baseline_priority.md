# Priority 1: Clean Baseline Before the Next Proof Pass

**Date:** 2026-05-25

**Status:** planning and project-memory note. This is not yet implemented in
the target manuscript, `formal_model_v6.Rmd`.

**Target manuscript:** `formal_model_v6.Rmd`. The previous manuscript
`formal_model_v5.Rmd` remains a reference/baseline history file, not the target
for the clean-baseline reset.

## Decision

The next formal proof pass should re-center the main architecture on a clean
baseline:

- set `b_theta = 0` in the baseline;
- give `H` an immediate opt-out payoff in the baseline: if `H` rejects in
  Round 1, no agreement includes `H` and type `theta` receives `o_theta`
  without discount;
- treat the current delayed-continuation interpretation as an extension: in
  that version, `H` cannot immediately exit the IO in Round 1 and therefore
  compares acceptance with a discounted Round-2 continuation;
- move the decomposition `t_theta = d_theta - b_theta` to an extension or
  microfoundation note, not the main baseline.

The core baseline should make the mechanism as stark as possible. The target
result to derive is that unanimity makes a privately informed `H` pivotal and,
when pooling is the selected admissible path, weak states pay the high threshold
and overpay the low type. Do not state this as proven until the clean benchmark
has been derived and checked.

## Interpretation To Explain

The current manuscript's dynamic formula is coherent only under a specific
timing interpretation: after rejecting in Round 1, `H` does not immediately
walk away and receive its outside option. Rejection keeps the parties inside the
institutional bargaining process and leads to a discounted continuation round.
This is a real and potentially useful friction, but it should not carry the
baseline interpretation.

In the clean baseline, the high type's outside option is not discounted away
inside the Round-1 participation constraint. If type `theta` rejects in Round 1,
its rejection payoff is `o_theta`, not `beta C_theta`. This removes the apparent
confusion in which the high type may accept less under unanimity than it would
receive when excluded under majority. Under the clean benchmark, the relevant
question is sharper: when `H` is pivotal and weak states do not know its type,
do they pay the high threshold and thereby give the low type an informational
rent?

The clean proof pass should therefore begin from the following protocol
primitive:

```text
Clean R1 opt-out primitive:
If H rejects a Round-1 proposal, no agreement includes H and type theta
receives o_theta immediately. The baseline does not also give H a discounted
continuation option.
```

In the clean theorem, `o_theta` is a primitive. A parameterization such as
`o_theta = alpha V(theta)` may be introduced later for an application,
numerical illustration, or microfoundation, but it is not part of the baseline
definition. The baseline also keeps `pi_H = 0` in every bargaining round, so
`H` is never a proposer.

**Clarification added 2026-08-03.** The direct cutoff
`y_theta^*=o_theta` applies at a ballot information set where,
under the weak voters' strategies, `H`'s yes vote implements a current
agreement that includes it with probability one. It is not a global voting
rule. Because ballots are simultaneous, if weak failure has positive
probability, the proof must derive `H`'s expected IC from the implementation,
opt-out, and continuation payoffs induced by each action; `H` cannot condition
on the ex post vote vector.

The delayed-continuation variants should be treated separately:

```text
Delayed-continuation extension: rejection payoff = beta C_theta(nu).
Hybrid exit/continuation extension: rejection payoff = max{o_theta, beta C_theta(nu)}.
```

## Voting Protocol Clarification

The clean-baseline reset preserves the common ballot protocol adopted in
`quality_reports/2026-05-11_common_voting_protocol_unanimity_majority.md`.
The bargaining game is sequential and public **across rounds**: a proposal is
made, a ballot is held, the complete vote vector and result become public, and
only then does any continuation occur. This does not mean sequential roll-call
voting within the ballot.

Within each ballot, the proposer is counted as voting yes, all other states
vote simultaneously, and individual votes are publicly revealed only after all
ballots have been cast. Unanimity and majority use the same ballot protocol and
differ only in the quota. A roll-call extension in which later voters observe
earlier votes would introduce a new informational mechanism and would require
an explicit voting order plus rederivation of beliefs and incentive
constraints.

## What the Complications Add

The delayed-continuation and `b_theta` complications are not useless. They
should be presented as extensions that show how the mechanism can weaken or
vary:

- delayed continuation may make majority preferable in some regions because
  waiting inside the IO is costly for `H`;
- heterogeneous direct agreement benefits may change the ordering of dynamic
  thresholds and generate low-only separation rather than only pooling;
- additional frictions may reduce the generality of the stark baseline result
  while preserving the mechanism that pivotal private information can create
  informational rents.

The intended message is not "the complications invalidate the mechanism." The
intended message is that the mechanism is clearest in the clean case, while
institutional frictions and richer payoff primitives modulate it.

## Workflow Requirement

Do not edit the target manuscript `formal_model_v6.Rmd` to implement this reset
directly. First rederive the clean benchmark in
`model_redesign/power_architecture_derivations.Rmd` and keep computational
checks in separate R scripts under `scripts/`. Only after the clean benchmark is
derived, checked, and reviewed should results be transported into
`formal_model_v6.Rmd`.

Before substantive edits, use the `paper-version` workflow. The 2026-05-25
inspection found a dirty worktree with many unrelated modified and untracked
files, so no truthful pre-edit git tag was created at this stage. Resolve or
commit the relevant state before tagging a future manuscript snapshot.

## Review Requirement

The implementer must not review their own changes. After implementation, run
two independent review passes, both read-only:

1. a formal-model review using the formal model review workflow, focused on
   baseline/extension separation and exposition of the clean benchmark;
2. an adversarial math/game-theory audit, focused on outside options, discounting,
   participation constraints, and claims about informational rents.

Accept the reset only after both reviewers find no conflict between the clean
baseline, the extension logic, and the project memory.
