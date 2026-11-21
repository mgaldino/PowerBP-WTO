# Replication README

This README documents how to reproduce the current `formal_model_v5.Rmd`
manuscript and the fixed-pie relative-package `pi_H = 0` results.

Run all commands from the repository root.

## Main manuscript

Render the active paper with:

```r
rmarkdown::render("formal_model_v5.Rmd")
```

The compiled PDF is `formal_model_v5.pdf`.

## Core verification scripts

The main formal claims in the manuscript are checked by the following scripts:

| Script | Object checked |
|---|---|
| `scripts/verify_relative_package_R2_piH0.R` | Terminal unanimity and `mu_2^*` |
| `scripts/verify_relative_package_R1_piH0.R` | Round-1 unanimity candidates, incentive constraints, and tie-break selection |
| `scripts/verify_relative_package_majority_piH0.R` | Majority no-screening iff `a_0^M >= beta/m` |
| `scripts/verify_relative_package_entry_nesting_piH0.R` | Weak-state entry nesting and `Delta_H(mu)` |
| `scripts/verify_relative_package_classification_piH0.R` | Five-way institutional classification and the working numerical illustration |
| `scripts/verify_relative_package_margins_piH0.R` | Numerical-illustration margin values reported in the manuscript |

Wrapper scripts are also available:

| Script | Purpose |
|---|---|
| `scripts/verify_relative_package_R2.R` | Runs the Round-2 verification |
| `scripts/verify_relative_package_R1.R` | Runs the Round-1 verification |
| `scripts/verify_relative_package_majority.R` | Runs the majority verification |
| `scripts/verify_relative_package_entry_nesting.R` | Runs the entry/nesting verification |
| `scripts/verify_relative_package_dominance.R` | Runs dominance and classification checks |
| `scripts/verify_relative_package_calibration.R` | Runs margin and robustness checks for the numerical illustration |

## Generated figures

The script `scripts/plot_relative_package_regions_piH0.R` generates the
publication figures used in `formal_model_v5.Rmd`:

| Output | Manuscript object |
|---|---|
| `figures/relative_package_no_cheap_H_region_piH0.pdf` | No-Cheap-H region figure |
| `figures/relative_package_terminal_regions_piH0.pdf` | Terminal unanimity regions figure |
| `figures/relative_package_R1_candidate_regions_piH0.pdf` | Round-1 candidate regions figure |
| `figures/relative_package_deltaH_piH0.pdf` | Hegemon payoff-gap figure |
| `figures/relative_package_classification_piH0.pdf` | Entry and institutional classification figure |
| `figures/relative_package_region_summary_piH0.csv` | Summary data for generated region figures |

The same script also writes PNG versions of the PDF figures.

## Generated tables

The script `scripts/verify_relative_package_robustness_piH0.R` writes the
CSV files used for robustness and diagnostic tables:

| Output | Manuscript object |
|---|---|
| `tables/relative_package_robustness_windows_piH0.csv` | One-way perturbation windows |
| `tables/relative_package_classification_sweeps_piH0.csv` | Representative classification sweeps |
| `tables/relative_package_r1_examples_piH0.csv` | Diagnostic Round-1 candidate regions |
| `tables/relative_package_delay_example_piH0.csv` | Non-calibrated delay example |
| `tables/relative_package_open_neighborhood_piH0.csv` | Multivariate local robustness checks |
| `tables/relative_package_local_continuity_margins_piH0.csv` | Local continuity margins |

Additional extension/stress-test outputs:

| Script | Output |
|---|---|
| `scripts/verify_relative_package_rho_majority_piH0.R` | `tables/relative_package_rho_majority_piH0.csv` |
| `scripts/verify_relative_package_piH_bounds.R` | `tables/relative_package_piH_bounds.csv` |

## Suggested replication sequence

```sh
Rscript --vanilla scripts/verify_relative_package_R2_piH0.R
Rscript --vanilla scripts/verify_relative_package_R1_piH0.R
Rscript --vanilla scripts/verify_relative_package_majority_piH0.R
Rscript --vanilla scripts/verify_relative_package_entry_nesting_piH0.R
Rscript --vanilla scripts/verify_relative_package_classification_piH0.R
Rscript --vanilla scripts/verify_relative_package_margins_piH0.R
Rscript --vanilla scripts/verify_relative_package_robustness_piH0.R
Rscript --vanilla scripts/verify_relative_package_rho_majority_piH0.R
Rscript --vanilla scripts/verify_relative_package_piH_bounds.R
Rscript --vanilla scripts/plot_relative_package_regions_piH0.R
Rscript --vanilla -e 'rmarkdown::render("formal_model_v5.Rmd")'
```
