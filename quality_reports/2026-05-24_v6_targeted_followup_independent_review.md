# Independent review of targeted v6 follow-up

Date: 2026-05-24

Protocol: implementation and review were separated. Independent no-edit reviewers were asked to inspect the targeted changes after implementation. They did not edit files. A final read-only review was run after the last implementation pass; its only residual point was a wording issue in the phase-diagram description, which was then resolved by the implementer.

## Formal Review

Result: **PASS with minor issues, all addressed.**

Checks passed:

- The abstract and introduction correctly state Strict No-Cheap-H and treat equality as a boundary requiring a tie convention.
- Appendix A.3, Step 4 correctly handles the `N=3` delay-deviation case. The possible deviation payoffs are `0`, `c(mu)`, `mu c(1)`, and `(1-mu)c(0)`, and each is bounded by `c(mu)`.
- Entry nesting is framed as a bookkeeping benchmark, not a substantive institutional-formation theorem.
- Worked-example and phase-diagram numbers are consistent with the script formulas: low-only/pooling cutoff near `0.315`, selected `Delta_H` crossing near `0.943`, majority entry payoff `1/12`, and selected unanimity entry range about `0.02667` to `0.03833`.
- Project guardrails pass: `pi_H=0` baseline preserved; weak-vote-passive assessment not mislabeled as a refinement; no old feasibility/C-B-R labels; no endogenous rule-choice language in the baseline.

Issues raised and resolved:

- The phrase “but not conversely” could imply strict inclusion for every `chi`; revised to “but not necessarily conversely.”
- The phrase `chi <= 0.0267` was tightened to `chi <= (1-a1)/m approx 0.02667`.
- The phrase “full institutional partition” slightly overstated the phase-diagram raster because the exact `Delta_H=0` tie is a zero-measure boundary marked by a dotted line rather than a separate colored region. Revised to “institutional regions ... with the zero-measure payoff-tie boundary marked separately.”

## Integration and Reproducibility Review

Result: **PASS with minor issue, addressed where appropriate.**

Checks passed:

- The phase diagram is reproducible from `scripts/revise_v5_coarse_review_checks.R`.
- The independently recomputed summary matched `tables/relative_package_phase_diagram_summary_piH0.csv` within `5e-5`.
- The figure is captioned/numbered through the R Markdown chunk and appears in the compiled PDF.
- `formal_model_v6.pdf` is current and plausibly compiled: 49 pages, created after the new figure and table artifacts.
- Final recompilation after the tie-boundary wording fix produced `formal_model_v6.pdf`, 49 pages, creation time 2026-05-24 15:30 -03.
- Script style passes the `dplyr::select` rule; no bare `select()` was found.
- The edits are concise: the PDF grows by one page, mainly because of the phase diagram.

Issue raised and resolved:

- The phrase “fixes the entry cost” was inaccurate because `chi` varies on the vertical axis; revised to “places entry cost on the vertical axis.”

Residual maintenance note:

- The prose reports selected numerical values directly rather than reading them inline from the phase-summary CSV. The values are correct after this pass. Future parameter changes should update both the script outputs and the prose.
