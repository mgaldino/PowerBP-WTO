# Targeted follow-up to the v6 coarse review

Date: 2026-05-24

Scope: `formal_model_v6.Rmd`, not the restored `formal_model_v5.Rmd`.

## Triage

The follow-up incorporated only high-cost-benefit items from the long-timeout coarse review:

1. **Abstract precision on majority.** Incorporated in the abstract. The majority benchmark now says that weak states avoid screening when the hegemon is *strictly* more costly to buy than a weak voter, with equality treated as a boundary requiring a separate tie convention.

2. **Delay proof for `N=3`.** Incorporated in Appendix A.3, Step 4. The proof now explicitly checks the one non-proposing weak-voter case and bounds the possible deviation payoffs `0`, `c(mu)`, `mu c(1)`, and `(1-mu)c(0)` by the prescribed delay payoff `c(mu)`.

3. **Institutional phase diagram.** Incorporated in the main worked example. A new `mu x chi` figure displays the majority entry boundary, the selected unanimity entry boundary, and the selected `Delta_H(mu)=0` crossing.

4. **Entry nesting framing.** Incorporated in the body. The text now says nesting is a bookkeeping benchmark for the entry margin, not a rich theory of institutional formation by itself. The wording was tightened from “but not conversely” to “but not necessarily conversely” to avoid implying strict inclusion for every entry cost.

5. **Tie-boundary wording in the phase diagram.** Incorporated after independent review. The text now says the figure draws institutional regions and marks the zero-measure payoff-tie boundary separately, rather than calling the raster a full institutional partition.

## Computation

Updated script:

- `scripts/revise_v5_coarse_review_checks.R`

New generated artifacts:

- `figures/relative_package_institutional_phase_diagram_piH0.pdf`
- `figures/relative_package_institutional_phase_diagram_piH0.png`
- `tables/relative_package_phase_diagram_summary_piH0.csv`

Key computed values:

- Majority entry boundary: `1/12 = 0.0833333333`.
- Pooling unanimity entry payoff: `(1-a1)/m = 0.0266666667`.
- Maximum selected unanimity entry payoff: `0.0383333333`.
- Low-only to pooling cutoff: `mu = 0.3146`.
- Selected `Delta_H(mu)=0` crossing: `mu = 0.94286`.
- At `chi = 0.030`, unanimity forms on the low-only part of the example, `mu <= 0.3146`.
- At `chi = 0.035`, unanimity forms for approximately `mu <= 0.14285`.

## Items Not Incorporated

The coarse review also requested broader extensions: `rho < 1`, positive `pi_H`, alternative belief disciplines, heterogeneous weak states, nonlinear package costs, and group-size sweeps. These were not incorporated in this targeted pass. They would require new theorem architecture or a larger robustness appendix. Adding them now would likely make the paper defensive and less focused. The current pass instead addresses two concrete correctness issues and one low-cost presentation gap.

## Verification Commands

```bash
Rscript --vanilla scripts/revise_v5_coarse_review_checks.R
Rscript --vanilla -e 'rmarkdown::render("formal_model_v6.Rmd")'
pdfinfo formal_model_v6.pdf
```

The final render completed successfully and produced `formal_model_v6.pdf` with 49 pages. `pdfinfo` reports creation time 2026-05-24 15:30 -03 and file size 368316 bytes.
