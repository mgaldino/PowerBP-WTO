# Independent Review of Coarse-Review Revision

Date: 2026-05-24

Scope: no-edit review of the implemented revision to `formal_model_v5.Rmd`, `scripts/revise_v5_coarse_review_checks.R`, generated tables, and compiled `formal_model_v5.pdf`.

Review protocol: implementer and reviewer were separated. The independent agents did not edit files.

## Review 1: Full No-Edit Check

Verdict: pass with targeted revisions.

Findings:

1. Medium: complete-information benchmark needed clearer distinction from degenerate priors.
   - Issue: Appendix benchmark was correct as a one-known-type game, but could be confused with taking `mu=0` or `mu=1` inside the original two-type weak-vote-passive assessment.
   - Action taken after review: Appendix B.3 now states that this is a collapsed type-space benchmark, not the endpoint of the two-type assessment.

2. Medium: sweep table slightly overstated "H preferring unanimity" because it was not conditioned on entry.
   - Issue: the sweep computed selected-path payoff gaps over the belief grid without imposing an entry cost.
   - Action taken after review: manuscript now labels the sweep as a selected-path/payoff-gap diagnostic; positive gaps imply a preference for unanimity only conditional on both institutions forming.

3. Low: terminal-region figure retained old-looking `t0=0.19` display.
   - Issue: not a formal error, but visually looked like residue from the older boundary illustration.
   - Action taken after review: script regenerates the terminal-region figure using the worked-example `t0=0.35`, and the caption says so.

4. Low: one-shot bridge overstated rejection as never selected when `t1 <= 1`.
   - Issue: at `t1=1` and `mu=1`, rejection can tie pooling at zero.
   - Action taken after review: script/table and text now say rejection is never strictly selected when `t1<1`, with a boundary tie possible at `t1=1, mu=1`.

Architecture check from reviewer:

- No architecture-breaking issue found.
- The revision preserves the fixed-pie relative-package `pi_H=0` baseline, weak-state agenda, weak-vote-passive assessment, conditional institutional comparison, and R1 as selected PBE outcome payoff-equivalent to `P/L/D`.
- No old C-B-R/A-C-A feasibility branch labels were reintroduced in `formal_model_v5.Rmd`.
- The new main worked example is internally consistent: `a0(1)=0.540<a1=0.680`, low-only is selected up to about `0.315`, pooling thereafter, and selected `Delta_H` crosses near `0.943`.
- The `Delta_H^P`, `Delta_H^L`, and piecewise `Delta_H^D` formulas check out algebraically.

## Review 2: Follow-Up No-Edit Check After Targeted Fixes

Verdict: pass.

Findings:

- No issues found in the four targeted fixes.
- Complete-information benchmark is explicitly framed as collapsed type-space, not the `mu=0`/`mu=1` endpoint of the two-type assessment.
- Sweep language is correctly scoped as selected-path/payoff-gap diagnostic conditional on both institutions forming.
- One-shot bridge now handles the `t1=1, mu=1` boundary tie.
- Terminal-region figure and caption now use the worked-example `t0=0.35`.
- The compiled PDF reflects these changes.
- No architecture-breaking language was reintroduced.

Final independent-review status: pass.
