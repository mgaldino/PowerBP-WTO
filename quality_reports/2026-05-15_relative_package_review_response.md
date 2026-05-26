# Relative-package redesign review response

Date: 2026-05-15

Scope: response to independent read-only reviews of
`model_redesign/power_architecture_derivations.Rmd` and
`scripts/verify_relative_package_*.R`.

## Q&A

**Was `formal_model_v5.Rmd` edited?**  
No. The active manuscript remains frozen.

**Did independent review occur?**  
Yes. Two read-only reviewer agents inspected the redesign. One focused on
formal architecture and claim discipline; the other focused on computational
coverage. Follow-up read-only reviews checked the `rho<1` stress test, local
robustness language, and the initial-recognition `pi_H>0` bounds.

**Were all reviewer concerns treated as resolved automatically?**  
No. The implementation pass corrected the high-priority language and coverage
gaps that could be addressed immediately, and records remaining scope limits.

## Independent review findings and response

| Review finding | Severity | Response |
|---|---:|---|
| R1 used language stronger than the proof status supports, including `full R1 selected PBE`, `candidate exhaustion`, and `PBE selection`. | High | Softened throughout the Rmd. The result is now described as a selected value under the maintained weak-vote-passive pure-threshold assessment, not global PBE exhaustion. |
| Opening Q&A framed the puzzle as why `H` chooses unanimity, despite no rule-choice stage. | Medium | Reframed as a conditional institutional-payoff question. |
| The numerical section used calibration language without empirical discipline. | Medium | Renamed to illustrative numerical classification / working numerical illustration. Added explicit warning that it is not empirical calibration. |
| Majority cheap-`H` branch was not exercised by the verification script. | High | Updated `scripts/verify_relative_package_majority_piH0.R` to run both `baseline_no_cheap_H` and `cheap_H_screening_branch`, including the cutoff check when `a0_M < c_M`. |
| Robustness used one-way perturbations only, not multivariate perturbations. | High | Updated `scripts/verify_relative_package_robustness_piH0.R` to verify a 243-point multivariate grid around an interior low-only/pooling example. Output table: `tables/relative_package_open_neighborhood_piH0.csv`. This is a grid check, not a proof over every point in an open set. |
| Classification script did not include a `tau_1 = ybar` boundary despite the Rmd saying it did. | Medium | Removed the unsupported claim from the Rmd rather than overstating coverage. |
| Universal claims are proved algebraically in the Rmd but scripts only grid-check them. | Medium | Left the algebraic propositions in the Rmd; scripts are now described as checks, not substitutes for proof. |
| R2 protocol checks are partly hard-coded. | Low | Left as a low-priority script-improvement item; the payoff identities remain checked. |

## Verification rerun after response

All commands below ran successfully on 2026-05-15 with locale warnings only:

```text
Rscript --vanilla scripts/verify_relative_package_R2_piH0.R
Rscript --vanilla scripts/verify_relative_package_R1_piH0.R
Rscript --vanilla scripts/verify_relative_package_majority_piH0.R
Rscript --vanilla scripts/verify_relative_package_entry_nesting_piH0.R
Rscript --vanilla scripts/verify_relative_package_classification_piH0.R
Rscript --vanilla scripts/verify_relative_package_margins_piH0.R
Rscript --vanilla scripts/verify_relative_package_robustness_piH0.R
Rscript --vanilla scripts/verify_relative_package_rho_majority_piH0.R
Rscript --vanilla scripts/verify_relative_package_piH_bounds.R
```

The standalone derivation document also compiled successfully:

```text
Rscript --vanilla -e 'rmarkdown::render("model_redesign/power_architecture_derivations.Rmd", output_format = "all")'
```

Outputs updated:

```text
model_redesign/power_architecture_derivations.html
model_redesign/power_architecture_derivations.pdf
tables/relative_package_robustness_windows_piH0.csv
tables/relative_package_classification_sweeps_piH0.csv
tables/relative_package_open_neighborhood_piH0.csv
tables/relative_package_local_continuity_margins_piH0.csv
tables/relative_package_r1_examples_piH0.csv
tables/relative_package_delay_example_piH0.csv
tables/relative_package_rho_majority_piH0.csv
tables/relative_package_piH_bounds.csv
```

## Remaining limitations

1. The R1 result remains a selected value under the maintained
   weak-vote-passive assessment and pure-threshold candidate class. It is not a
   characterization of all unrestricted PBEs.
2. Majority now has a voting-continuation assessment for the payoff-relevant
   threshold proposals, but not a characterization of all unrestricted majority
   voting PBEs.
3. The numerical examples and the `rho<1` majority-without-Saudi extension are
   illustrative stress tests only. They are not empirical OPEC calibrations.
4. The initial-recognition `pi_H > 0` agenda-power stress test now has
   selection-free bounds, but the exact recursive `pi_H > 0` game remains
   pending.
5. Transport to `formal_model_v5.Rmd` remains pending by design until the
   remaining scope decisions are settled and the user authorizes manuscript
   integration.
