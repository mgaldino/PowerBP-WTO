# Goal: weak-caused failures without heavy refinements

Target paper: `formal_model_v6.Rmd`

Target proof area: Appendix A.3, especially the rejected-history reduction and
the no-information delay branch.

## Goal prompt

Implement a proof repair that makes the treatment of weak-caused failures more
robust while avoiding equilibrium refinements the author does not want to rely
on.

The current manuscript uses the weak-vote-passive assessment to say that, when a
public proposal is designed to fail because at least one necessary weak voter
gets less than its continuation value, `H`'s nonpivotal vote is not used as a
signal and the posterior remains `mu`. The revision should reduce this
assumption where possible.

Derive and, if valid, insert a local lemma for weak-caused failures:

1. The proposal and all weak-state allocations are public.
2. If at least one necessary weak voter receives less than its continuation
   value, `H` knows that the proposal will fail by weak rejection.
3. `H`'s vote is therefore non-outcome-determining for current passage.
4. Check whether a nonpivotal `H` vote can sustain informative pure-strategy
   signaling that gives the proposer a fourth payoff-relevant rejected-history
   candidate.
5. Use the model's continuation payoffs:
   - `C_1(nu)=o_1` for the high type;
   - under high-posterior pooling, `C_0(1)=o_0+t_1-t_0` and `C_0(0)=o_0`.
6. Show, if the inequalities support it, that a separating nonpivotal vote is
   not incentive compatible because the low type mimics any vote that induces
   the high posterior, while pooling nonpivotal votes leave beliefs uninformative.
7. Conclude only what is proven: weak-caused failures are payoff-equivalent to
   no-information delay in the selected pure-strategy analysis. Do not claim a
   general refinement result and do not characterize all unrestricted PBEs.

## Required edits if the lemma works

- Update `formal_model_v6.Rmd` Appendix A.3.
- Narrow the main-text description of the weak-vote-passive assessment so it is
  used only where still necessary.
- Update the assessment-scope table.
- Update `math_guide_proofs.Rmd` and recompile `math_guide_proofs.pdf`.
- Update `quality_reports/2026-05-26_weak_vote_passive_reduction_todo.md` with
  the result of the proof audit.

## Non-goals

- Do not introduce Intuitive Criterion, D1, sequential equilibrium, trembling
  hand, or stationarity as a new foundation.
- Do not add a new signaling model. If the local proof above fails, do not edit
  the paper; document the failure in `quality_reports/` and leave the manuscript
  proof unchanged.
- Do not try to remove the weak-vote-passive assessment globally. The goal is
  only to reduce its use in the weak-caused-failure branch if a clean local
  proof works.
- Do not attempt to resolve the other off-path cases in this goal. Those cases
  remain outside scope.
- Do not state uniqueness over all PBEs.

## Review protocol

The implementer cannot be a reviewer. Reviewers do not edit files.

Use the relevant skills:

- `formal-game-theory-polisci` for the implementer's derivation and proof
  architecture.
- `game-theory-audit` for one independent read-only reviewer focused on PBE,
  voting, signaling, and incentive compatibility.
- A second independent read-only adversarial math/formal-model reviewer, using
  `formal-model-writing`, `review-formal-model`, or an equivalent formal-model
  skill, focused on algebra, quantifiers, domain restrictions, and whether the
  new lemma really reduces reliance on the assessment.

Minimum acceptance standard:

- Both reviewers must explicitly approve the weak-caused-failure lemma or list
  only non-blocking editorial issues.
- If either reviewer finds a substantive gap, leave the manuscript proof
  unchanged or mark the lemma as pending in `quality_reports/`.

## Final deliverables

- Edited manuscript and updated math guide only if the proof passes review.
- A short quality report documenting the derivation, reviewer comments, and any
  remaining uses of weak-vote-passive assessment.
- Recompiled PDF outputs.
