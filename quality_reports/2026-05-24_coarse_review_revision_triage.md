# Coarse Review Revision Triage

Date: 2026-05-24

Manuscript: `formal_model_v5.Rmd`  
Review input: `coarse-output/formal_model_v5_review.html`  
Revision goal: respond concisely but substantively to the highest-return coarse-review critiques while preserving the fixed-pie relative-package `pi_H=0` baseline, weak-state agenda, weak-vote-passive assessment, and conditional institutional comparison.

## Summary of decisions

| Item | Decision | Implementation |
|---|---|---|
| Main worked example | Replace body flagship example | Replaced the boundary OPEC-style numerical illustration with a nonboundary worked example: `N=13`, `beta=0.6`, `t0=0.35`, `t1=0.70`, `o0=o1=0.05`. It has `a0(1)=0.540<a1=0.680`, low-only for `mu <= 0.3146`, pooling above, and selected `Delta_H=0` at `mu ~= 0.94286`. |
| Comparative statics of `Delta_H(mu)` | Insert in body and expand in appendix | Added explicit formulas for `Delta_H^P`, `Delta_H^L`, and piecewise `Delta_H^D` in the body. Added the common-outside-payoff slice `o0=o1=o`, with signs in terms of `g=t1-t0`, to Appendix B.4. |
| Bridge to nearby models | Body paragraph plus appendix | Added a body paragraph after the Piazolo-Vanberg / Glynia-Thum-Xefteris comparison. Added Appendix B.3 one-shot limit showing terminal low-only and pooling survive, while dynamic delay, `a0(1)`, `a1`, and entry classification require the two-round continuation. |
| No-private-information benchmark | Appendix | Added Appendix B.3 complete-information benchmark. Pooling and low-only collapse to one known-threshold acceptance package; `Delta_H^{CI,theta}=-(1-beta)o_theta`, so any remaining gap is noninformational discounting, not screening rent. |
| Parameter-region map | Appendix table, not body | Added `scripts/revise_v5_coarse_review_checks.R` and new sweep tables. Appendix B.4 reports a compact sweep on the common-outside-payoff slice under the maintained domain conditions. |
| Independent review findings | Incorporated | A first no-edit review found four targeted issues. The manuscript/script were patched, recompiled, and a second no-edit review passed with no findings. See `quality_reports/2026-05-24_coarse_review_revision_independent_review.md`. |
| Alternative public-history assessments | Not incorporated now | Deferred. It would require changing the equilibrium object beyond the current weak-vote-passive selected-PBE architecture. The current revision instead sharpens assessment-conditional language and adds formal benchmarks without changing theorem scope. |
| Reduced-surplus majority / coalition-cost variant | Not incorporated now | Deferred to avoid expanding the paper beyond the requested high-priority formal additions. The body already labels entry nesting as close to accounting and keeps the comparison conditional. |
| Footnotes | None added | The incorporated material fit better as body text and Appendix B subsections. No new footnote was necessary. |

## Computation added

New script:

- `scripts/revise_v5_coarse_review_checks.R`

New generated tables:

- `tables/relative_package_main_worked_example_piH0.csv`
- `tables/relative_package_main_worked_example_margins_piH0.csv`
- `tables/relative_package_main_worked_example_points_piH0.csv`
- `tables/relative_package_complete_info_benchmark_piH0.csv`
- `tables/relative_package_one_shot_bridge_piH0.csv`
- `tables/relative_package_region_sweep_piH0.csv`
- `tables/relative_package_region_sweep_summary_piH0.csv`
- `figures/relative_package_terminal_regions_piH0.pdf`
- `figures/relative_package_terminal_regions_piH0.png`

Key computed outputs:

- Main worked example:
  - `mu2_star = 0.5384615`
  - `a0(1) = 0.540`
  - `a1 = 0.680`
  - `a1 - a0(1) = 0.140`
  - `a0_M = 0.330 > beta/m = 0.050`
  - selected regions: low-only on `[0, 0.3146]`, pooling on `[0.31461, 1]`
  - selected `Delta_H` root: `mu ~= 0.94286`
  - `V_W^M = 0.08333`; selected `V_W^U` ranges from `0.02667` to `0.03833`

- Common-outside-payoff sweep:
  - valid retained grid points: `4440`
  - low-only plus pooling: `3342` vectors (`75.3%` of valid grid)
  - delay plus pooling: `1074` vectors (`24.2%`)
  - all three candidates: `24` vectors (`0.5%`)
  - among low-only plus pooling vectors, `80.4%` have an interior `Delta_H` crossing.

## Manuscript text inserted or replaced

Body:

- Abstract now highlights the nonboundary worked example rather than the old boundary illustration.
- Introduction now describes the example as nonboundary and conditional, without OPEC-style calibration language.
- Literature section now includes a formal bridge paragraph to one-shot models.
- R1 exposition now points to the nonboundary worked example and no longer uses the old detached diagnostic as the main body example.
- Entry/comparison section now includes explicit `Delta_H^P`, `Delta_H^L`, and `Delta_H^D` formulas plus the common-outside-payoff comparative statics.
- Former "Working Numerical Illustration" section was replaced by "Main Worked Example".
- OPEC discussion now treats the worked example as non-calibrated and updates all numerical claims.

Appendix:

- Appendix B.3 now contains the one-shot bridge, no-private-information benchmark, and extensions not used in the baseline.
- Appendix B.4 now contains the comparative statics and the systematic region-sweep table.
- Delay example remains in Appendix B.5.

## Verification

Commands run:

```bash
Rscript --vanilla scripts/revise_v5_coarse_review_checks.R
Rscript --vanilla -e 'rmarkdown::render("formal_model_v5.Rmd")'
pdftotext formal_model_v5.pdf - | rg -n "Main Worked Example|Nonboundary worked example|One-shot bridge|Complete-information benchmark|Systematic region sweep|0\\.943|low-only"
pdfinfo formal_model_v5.pdf | sed -n '1,40p'
```

Results:

- The R script regenerated all new tables without errors.
- `rmarkdown::render("formal_model_v5.Rmd")` completed successfully.
- `formal_model_v5.pdf` was recreated on 2026-05-24 at 11:53 local time after the independent-review fixes.
- `pdfinfo` reports a valid 47-page PDF.
- `pdftotext` confirms the new worked example, one-shot bridge, complete-information benchmark, sweep table, and `0.943` payoff-gap cutoff are present in the compiled PDF.
- Follow-up `pdftotext` confirms the collapsed type-space benchmark, one-shot boundary tie, conditional payoff-gap sweep language, and terminal-region caption using `t0=0.35` are present in the compiled PDF.

Limitation:

- `qpdf --check formal_model_v5.pdf` could not be run because `qpdf` is not installed in the environment.
