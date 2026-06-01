# TODO: reduce reliance on weak-vote-passive assessment

Date: 2026-05-26

Target manuscript: `formal_model_v6.Rmd`.

## Priority proof task

Replace as much of the current weak-vote-passive assessment as possible with
endogenous no-information/no-separation lemmas.

The immediate candidate is the weak-caused failure branch in the rejected-history
reduction. If a public proposal gives at least one necessary weak voter less
than its continuation value, `H` can anticipate that the proposal fails by weak
rejection. `H`'s vote is non-outcome-determining for current passage. The proof
task is to show that this nonpivotal vote cannot support informative
pure-strategy signaling that improves on no-information delay:

- the high type's Round-2 payoff is `C_1(nu)=o_1`, independent of posterior;
- the low type weakly prefers the high posterior when terminal pooling gives
  `C_0(1)=o_0+t_1-t_0 > C_0(0)=o_0`;
- therefore any separating nonpivotal vote that induces a high posterior is
  mimicked by the low type;
- pooling nonpivotal votes leave posterior `mu`, so weak-caused failures are
  payoff-equivalent to no-information delay.

If this lemma is valid under the maintained threshold domain, the proof can
replace the statement "by weak-vote-passive assessment, posterior remains `mu`"
for weak-caused failures with an equilibrium argument.

## Remaining assessment cases to audit

1. Weak-voter deviations in accepted candidates.
   Current role: price weak-voter approval ICs in `P` and `L`. Need decide
   whether this can be replaced by a no-private-information/consistency lemma:
   weak voters do not observe `theta`, so their unilateral off-path votes should
   not update beliefs about `H`; any updating should come only from `H`'s
   simultaneously observed vote.

2. Off-path beliefs after weak-voter votes more generally.
   Current role: prevent weak votes from becoming signals about information weak
   voters do not possess.

3. Off-path deviations by `H` from pooling prescriptions.
   Current role: specify posteriors after unexpected `H` votes when both types
   were prescribed to vote yes or both were prescribed to vote no. Need check
   whether one can derive that no profitable separating deviation exists, or
   whether a limited belief protocol remains necessary.

## Documentation target

After proof audit, update:

- Appendix A.3 proof of rejected-history reduction and R1 selection;
- Definition of the belief protocol in the main text;
- Table of assessment-free vs assessment-dependent components;
- `math_guide_proofs.Rmd`, especially Sections 3.3, 3.4, and 6.
