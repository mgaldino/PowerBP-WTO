# Refine feedback group 1 implementation

Date: 2026-05-24

Scope: `formal_model_v6.Rmd` and supporting computation in `scripts/revise_v5_coarse_review_checks.R`.

## Implemented Adjustments

This pass implemented the nine point-level comments from `quality_reports/refine-feedback-informational-power-through-pivotality-how-consens-2026-05-24.md`.

1. **Rent versus total payoff.** Replaced wording that compared a “screening rent” to the majority payoff with wording based on the selected unanimity payoff and the majority benchmark.

2. **Only-majority region.** Reworded the introduction so the only-majority region means majority is the only viable institution, not that `H` strictly prefers majority to failed unanimity.

3. **Candidate switches.** Reworded observable implications so institutional rankings can change either when the selected candidate changes or when the selected payoff gap crosses zero.

4. **Round-1 roadmap scope.** Added threshold-domain conditions alongside the weak-vote-passive assessment in the abstract and introduction.

5. **Endogenous rule choice.** Replaced speculative language about rule-choice signaling reducing, preserving, or amplifying screening with a narrower statement: a literal costless rule-choice extension would require additional primitives to preserve the screening object.

6. **Delay example table.** Updated `scripts/revise_v5_coarse_review_checks.R` to generate a three-row delay example. `tables/relative_package_delay_example_piH0.csv` now reports one low-belief delay row and two higher-belief pooling rows.

7. **Sweep grid increments.** Added the actual grid increments in Appendix B.4: `beta` by `0.05`, `t0` by `0.05`, `t1-t0` by `0.03`, and `o` by `0.05`.

8. **Informational rents beyond pooling.** Revised the introduction and literature discussion to state that informational rents arise both under high-threshold pooling and, in the dynamic game, under continuation-priced low-only offers.

9. **Outside-payoff intuition.** Corrected the Appendix B.4 intuition: a higher high-type outside payoff lowers the high type's net dynamic threshold more, making strict low-only separation harder.

## Style Pass

The edits also applied the `rewrite-introduction` style guide as an editing constraint:

- removed the “not because..., but because...” formulation in the opening mechanism paragraph;
- removed “speaks to” and “key design choice” phrasing;
- replaced “not ad hoc” with a positive statement that delay follows from continuation incentives;
- shortened defensive caveats in the scope section.

## Devil's Advocate Review

A no-edit Devil's Advocate agent reviewed the adjustments item by item. Initial findings:

- PASS: only-majority region, candidate switches, endogenous rule choice, delay table, sweep increments, outside-payoff intuition.
- ISSUE: remaining rent/total-payoff wording, missing abstract scope conditions, and introduction narrowing rents to pooling.
- STYLE FLAGS: defensive or generic phrasing in the opening, literature, and scope sections.

All reported issues were then addressed. A second no-edit pass confirmed:

- PASS on rent versus total payoff;
- PASS on abstract threshold-domain conditions;
- PASS on informational rents beyond pooling;
- PASS on the main style flags.

One remaining minor style issue, “speaks to,” was removed after the second pass.

## Verification

Commands run:

```bash
Rscript --vanilla scripts/revise_v5_coarse_review_checks.R
Rscript --vanilla -e 'rmarkdown::render("formal_model_v6.Rmd")'
pdfinfo formal_model_v6.pdf
pdftotext formal_model_v6.pdf - | rg -n "A non-calibrated delay example|0\\.010|0\\.350|0\\.750|pooling|delay"
```

Final PDF: `formal_model_v6.pdf`, 49 pages, created on 2026-05-24 at 15:54:43 -03.

The delay example now prints one `delay` row and two `pooling` rows in the compiled PDF.
