# Formal Model Presentation Diagnostic

**Paper:** `formal_model_v5.Rmd`
**Date:** 2026-05-15
**Commit reviewed:** `a6e0fe9`
**Results analyzed:** 8
**Checklist items assessed:** 72

## Summary statistics

- Items PRESENT: 27/72 (37.5%)
- Items PARTIAL: 29/72 (40.3%)
- Items MISSING: 16/72 (22.2%)
- Most common gap: phase/region diagrams are missing for every result.

This diagnostic reads the current manuscript as a presentation object after the proof-repair commit. It does not re-audit algebraic validity. The paper is much stronger than the pre-repair version on scope discipline, proof location, notation, and calibration margins. The remaining presentation gap is systematic: the reader can see the formal objects, but cannot yet see the parameter regions and comparative statics that make the results memorable and robust.

## Formal Result Inventory

| ID | Result | Location | Statement summary | Proof location |
|---|---|---:|---|---|
| P1 | Majority no-screening benchmark | `formal_model_v5.Rmd:186` | Majority avoids screening iff the low-threshold hegemon is not cheaper than a weak voter: `a_0^M >= beta/m`. | Appendix A.1 |
| L1 | Terminal unanimity threshold | `formal_model_v5.Rmd:223` | Terminal unanimity uses low-only package below `mu_2^*` and pooling above it. | Appendix A.2 |
| P2 | R1 outcome under passive-belief assessment | `formal_model_v5.Rmd:318` | Under the stated passive assessment and threshold conditions, the selected R1 candidate lies in `{P,L,R}`. | Appendix A.3 |
| R1 | Delay is endogenous | `formal_model_v5.Rmd:328` | No-information rejection is a feasible candidate and may be selected when continuation beats accepted packages. | Embedded in Appendix A.3 |
| P3 | Weak-state entry nesting | `formal_model_v5.Rmd:360` | Under the maintained domains and No-Cheap-H, `F_U(chi) subseteq F_M(chi)`. | Appendix A.4 |
| P4 | Conditional comparison for the hegemon | `formal_model_v5.Rmd:403` | Conditional on both rules forming, the sign of `Delta_H(mu)` determines H's institutional ranking. | Appendix A.5 |
| C1 | Institutional classification | `formal_model_v5.Rmd:408` | Five sets partition beliefs into no formation, only majority, and three both-form H-ranking regions. | Appendix A.5 |
| E1 | Working calibration | `formal_model_v5.Rmd:439` | OPEC-style calibration: unanimity forms up to `chi=0.0619583`, majority up to `0.0833333`, and H prefers unanimity for `mu<0.7`. | Reproducibility ledger/scripts |

## Model Parameter Set

**Primitive and structural objects:** `N`, `m=N-1`, `q`, `k=q-1`, `theta in {0,1}`, `mu`, `y`, `x_i`, `t_theta`, `ybar`, `beta`, `pi_H=0`, `chi`, `o_theta`, fixed weak surplus equal to one, weak-only recognition, two rounds, simultaneous public voting, passive-belief assessment, and H-payoff-minimizing tie-break among weak-proposer payoff ties.

**Derived objects:** `a_theta(nu)`, `a_0^M`, `a_1^M`, `a_0^1`, `a_1`, `p_2(mu)`, `C_theta(nu)`, `c(nu)`, `P`, `L`, `R`, `K(mu)`, `S_K^U(mu)`, `V_W^U(mu)`, `V_W^M(mu)`, `V_H^U(mu)`, `V_H^M(mu)`, `F_U(chi)`, `F_M(chi)`, and `Delta_H(mu)`.

**Maintained domains and scope conditions:** Threshold Order, High-Posterior Pooling, R1 Dynamic Threshold Order, Majority Threshold Order, No-Cheap-H, weak approval at pivotal constraints, and passive-belief assessment.

## Per-Result Diagnostic

### P1: Majority No-Screening Benchmark

**Statement:** Majority produces no screening exactly when the low type of H is not cheaper to buy than a weak voter: `a_0^M >= beta/m`.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PRESENT | Keep the iff boundary and primitive form. Add a one-line interpretation of each term in `t_0-(1-beta)o_0 >= beta/m`. |
| 2 | Comparative statics | PARTIAL | Add an appendix remark deriving how No-Cheap-H moves with `t_0`, `o_0`, `beta`, and `m`. |
| 3 | Phase/region diagram | MISSING | Add a two-dimensional region plot, preferably `(t_0, beta)` or `(o_0, beta)`, shading where No-Cheap-H holds. |
| 4 | Parametric window | PARTIAL | Convert the baseline margin into intervals: for example, the admissible ranges of `t_0`, `o_0`, or `beta` holding other calibration values fixed. |
| 5 | Margin table | PRESENT | Table 1 reports `a_0^M=0.171`, `beta/m=0.075`, margin `0.096`. |
| 6 | Verbal intuition before | PRESENT | The pre-proposition prose clearly explains why majority removes screening only if H is not a cheap coalition partner. |
| 7 | Worked example | PARTIAL | The calibration later illustrates the condition. Add a compact example immediately before or inside the majority section. |
| 8 | Mapping to reality | PARTIAL | The OPEC mapping is present later. Add one sentence in this section explaining what a "cheap H" means empirically. |
| 9 | Proof location | PRESENT | Proof is in Appendix A.1 and the main text includes a pointer. |

**Comparative statics gap analysis:**
Parameters analyzed: none formally; the text gives qualitative intuition for `a_0^M` versus `beta/m`.
Parameters NOT analyzed for this result: `t_0` (higher facilitates No-Cheap-H), `o_0` (higher undermines it when `beta<1` because `a_0^M=t_0-(1-beta)o_0` falls), `beta` (effect depends on `o_0-1/m`), `m` (higher `m` lowers `beta/m` and facilitates No-Cheap-H), `ybar` (only through feasibility of thresholds), and `q/k` (used in the proof but not in the final boundary).

**Priority actions (ranked):**
1. Add a comparative-statics remark for No-Cheap-H, including the conditional beta effect.
2. Add a region plot for the no-screening domain.
3. Add a one-paragraph empirical interpretation of the failure case `a_0^M < beta/m`.

### L1: Terminal Unanimity Threshold

**Statement:** Terminal unanimity chooses the low-threshold package for `mu <= mu_2^*` and pooling for `mu > mu_2^*`, where `mu_2^*=(t_1-t_0)/(1-t_0)`.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PRESENT | The cutoff is clean and interpretable. |
| 2 | Comparative statics | PARTIAL | Add explicit derivatives of `mu_2^*` with respect to `t_0` and `t_1`; state that `m` affects representative value but not the terminal package choice. |
| 3 | Phase/region diagram | MISSING | Add a region diagram with `mu` on the x-axis and either `t_1` or `t_1-t_0` on the y-axis, showing low-only versus pooling. |
| 4 | Parametric window | PARTIAL | The threshold domain is stated, but the text does not report open intervals for pooling/low-only around the calibration. |
| 5 | Margin table | PARTIAL | The threshold-domain table reports `t_0`, `t_1`, and `ybar` slacks, but no row reports `mu_2^*` or distance from the terminal switching point. |
| 6 | Verbal intuition before | PRESENT | The section explains why only `t_0` and `t_1` matter in terminal bargaining. |
| 7 | Worked example | PRESENT | The motivating example gives the same terminal screening logic before the full model. |
| 8 | Mapping to reality | PARTIAL | The OPEC section maps `y` and `t_theta`, but the terminal threshold result itself is not tied to a concrete institutional choice. |
| 9 | Proof location | PRESENT | Proof is in Appendix A.2 and the main text includes a pointer. |

**Comparative statics gap analysis:**
Parameters analyzed: `t_0` and `t_1` appear in the cutoff but their effects are not discussed formally.
Parameters NOT analyzed for this result: `t_1` (higher raises `mu_2^*`, making low-only optimal over a larger belief range), `t_0` (higher lowers `mu_2^*` when `t_1<1`), `m` (reduces representative continuation value but not package choice), `ybar` (feasibility only), and `beta`, `o_0`, `o_1` (not relevant in terminal acceptance except through later dynamic thresholds).

**Priority actions (ranked):**
1. Add a short terminal comparative-statics remark.
2. Add a row for `mu_2^*` and a terminal switching-margin row in the calibration section.
3. Add a simple terminal region plot; this is the easiest figure to implement and would orient readers before R1.

### P2: R1 Outcome Under the Passive-Belief Assessment

**Statement:** Under the stated threshold domains, passive-belief assessment, weak approval rule, and tie-break, the selected R1 candidate is the maximizer among feasible `P`, `L`, and `R`.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PARTIAL | Candidate payoffs and feasibility conditions are explicit, but the paper does not give closed-form switching boundaries such as `Pi_P >= Pi_L`, `Pi_P >= Pi_R`, and `Pi_L >= Pi_R`. |
| 2 | Comparative statics | MISSING | Add an appendix remark or table showing how R1 candidate regions change with `mu`, `beta`, `m`, `t_0`, `t_1`, `o_0`, and `o_1`. |
| 3 | Phase/region diagram | MISSING | Add an R1 `P/L/R` region plot, preferably with `mu` on the x-axis and a threshold-gap or discount-factor parameter on the y-axis. |
| 4 | Parametric window | PARTIAL | The calibration is on the boundary `a_0^1=a_1`; the manuscript should also report an open nearby parameter window where the same qualitative R1 selection remains valid or state that the calibration is intentionally boundary-based. |
| 5 | Margin table | PRESENT | Table 2 gives P feasibility, R feasibility, the strict-L boundary, and P-versus-R margins. |
| 6 | Verbal intuition before | PRESENT | The text usefully frames R1 as "insure agreement, test the low threshold, or wait." |
| 7 | Worked example | PARTIAL | The calibration demonstrates P selection, but it appears after the result and lies on a strict-low-only boundary. Add a compact pre-result R1 example with nonboundary values. |
| 8 | Mapping to reality | PARTIAL | The OPEC mapping clarifies `y` and `t_theta`, but the three R1 candidates are not translated into concrete OPEC packages. |
| 9 | Proof location | PRESENT | Proof is in Appendix A.3 and the main text includes a pointer. |

**Comparative statics gap analysis:**
Parameters analyzed: no systematic R1 comparative statics. The calibration shows one boundary case with `a_0^1=a_1`.
Parameters NOT analyzed for this result: `mu` (moves selection through candidate payoffs and continuation values), `beta` (raises continuation values and changes dynamic thresholds), `m` (dilutes continuation values but increases the number of paid weak voters), `t_0` and `t_1` (move package costs and the terminal cutoff), `o_0` and `o_1` (move dynamic acceptance thresholds), `ybar` (feasibility), and the tie-break (affects selection at equality).

**Priority actions (ranked):**
1. Derive and display pairwise R1 switching inequalities: `P` versus `L`, `P` versus `R`, and `L` versus `R`.
2. Create an R1 phase diagram. This is the main missing presentation device in the paper.
3. Add a nonboundary worked example where `a_0^1<a_1` and low-only is admissible somewhere, even if only in an appendix.

### R1: Delay Is Endogenous

**Statement:** The no-information rejection candidate is feasible and may be selected when continuation is better for the weak proposer than accepted packages.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PARTIAL | `R` is always feasible, but the selection boundary for delay is not stated: it requires `Pi_R >= Pi_P` and `Pi_R >= Pi_L` among admissible candidates. |
| 2 | Comparative statics | MISSING | Add a focused delay remark: when do higher `beta`, higher threshold gaps, or larger `m` make delay more attractive? |
| 3 | Phase/region diagram | MISSING | Let the R1 region plot explicitly label any delay region; if none appears in the baseline calibration, show an appendix parameterization where delay occurs. |
| 4 | Parametric window | MISSING | The text says delay can arise but does not give an open parameter set where it is actually selected. |
| 5 | Margin table | PARTIAL | Table 2 shows that `P` beats `R` in the calibration, but it does not give conditions or margins for a case where `R` wins. |
| 6 | Verbal intuition before | PRESENT | The remark states the intuition that delay follows from incentives, not assumption. |
| 7 | Worked example | PARTIAL | The calibration shows delay is not selected. Add a small example where `R` is selected or soften the wording to "available candidate" rather than "can arise" unless illustrated. |
| 8 | Mapping to reality | MISSING | Add a sentence mapping `R` to a failed OPEC package, postponed meeting, or non-informative breakdown. |
| 9 | Proof location | PARTIAL | Appendix A.3 Step 4 proves implementability, but the remark itself has no proof pointer. Add "See Appendix A.3, Step 4." |

**Comparative statics gap analysis:**
Parameters analyzed: none.
Parameters NOT analyzed for this result: `beta` (higher continuation value tends to make delay more attractive), `mu` (changes `c(mu)` and accepted-package probabilities), `m` (changes continuation per weak voter and required payments), `t_0`, `t_1`, `o_0`, and `o_1` (change accepted-package costs and future payoff from delay).

**Priority actions (ranked):**
1. Either add an explicit parameter example where `R` is selected, or restate the remark more conservatively as an implementable candidate.
2. Add pairwise delay inequalities in Appendix A.3.
3. Add an empirical mapping for no-information rejection.

### P3: Weak-State Entry Nesting

**Statement:** Under the maintained domains and No-Cheap-H, representative weak-state payoff under unanimity is no larger than under majority, so `F_U(chi) subseteq F_M(chi)`.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PRESENT | The set-inclusion statement and payoff inequality are clean. |
| 2 | Comparative statics | PARTIAL | The text explains the accounting logic but does not analyze how the entry boundary moves with `chi`, `m`, `beta`, or thresholds. |
| 3 | Phase/region diagram | MISSING | Add a `(mu, chi)` plot with the majority and unanimity formation regions. |
| 4 | Parametric window | PARTIAL | The result is general under conditions, but the manuscript does not report parameter intervals over which the calibrated nesting gap remains positive. |
| 5 | Margin table | PRESENT | Table 3 reports `V_W^M - V_W^U = 0.021375`. |
| 6 | Verbal intuition before | PRESENT | The text correctly says nesting is close to accounting under fixed pie. |
| 7 | Worked example | PARTIAL | The calibration illustrates the result, but it appears after all institutional-choice results rather than before the nesting proposition. |
| 8 | Mapping to reality | PARTIAL | Entry costs are mapped to formation/compliance/participation costs, but the collective-entry assumption deserves a concrete OPEC interpretation. |
| 9 | Proof location | PRESENT | Proof is in Appendix A.4 and the main text includes a pointer. |

**Comparative statics gap analysis:**
Parameters analyzed: none formally; the text gives the fixed-pie intuition.
Parameters NOT analyzed for this result: `chi` (shifts formation sets mechanically), `m` (changes representative payoff scale), `beta` (changes delayed weak payoffs), `t_0`, `t_1`, `o_0`, `o_1` (affect selected unanimity candidate and weak surplus), and `mu` (matters through `k*(mu)` and selected total weak payoff).

**Priority actions (ranked):**
1. Add the `(mu, chi)` formation plot. This is the natural figure for entry nesting.
2. Report a calibrated parametric window for the nesting gap, especially around `t_1` and `beta`.
3. Move or preview the calibration example before the proposition if the target journal rewards example-first exposition.

### P4: Conditional Comparison for the Hegemon

**Statement:** On beliefs where both institutions form, H prefers unanimity, is indifferent, or prefers majority according to the sign of `Delta_H(mu)`.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PARTIAL | The sign boundary is clear, but `Delta_H(mu)` is not expanded into closed form by selected candidate in the main text. |
| 2 | Comparative statics | MISSING | Add candidate-specific comparative statics for `Delta_H`, especially under pooling, since the calibration selects pooling for all beliefs. |
| 3 | Phase/region diagram | MISSING | Add a plot of `Delta_H(mu)` and, ideally, a `(mu, chi)` plot showing both-form regions with H's preferred rule. |
| 4 | Parametric window | PARTIAL | The calibration gives a threshold at `mu=0.7`, but not the parameter interval over which the zero crossing remains inside `[0,1]`. |
| 5 | Margin table | PRESENT | Table 4 reports `Delta_H(mu)` at `0`, `0.5`, `0.7`, and `1`. |
| 6 | Verbal intuition before | PRESENT | The preceding paragraph explains that nesting is not the substantive comparison; `Delta_H` is. |
| 7 | Worked example | PARTIAL | The calibration gives a concrete example after the formal result; a brief preview before the proposition would help. |
| 8 | Mapping to reality | PARTIAL | The OPEC section maps the payoff gap concept but could state what makes the gap positive in substantive terms. |
| 9 | Proof location | PRESENT | Proof is in Appendix A.5 and the main text includes a pointer. |

**Comparative statics gap analysis:**
Parameters analyzed: no general comparative statics; the calibration shows `Delta_H(mu)=0.0665-0.095mu`.
Parameters NOT analyzed for this result: `mu` (directly determines the sign in the calibration), `t_0`, `t_1`, `o_0`, `o_1` (move H's accepted-package rents and majority outside payoff), `beta` (changes dynamic thresholds and delay payoffs), `m` (affects weak payments and entry), and `chi` (does not change `Delta_H` but determines whether the comparison is relevant because both rules must form).

**Priority actions (ranked):**
1. Expand `Delta_H` in the main text for the selected candidate, at least for the pooling-calibration case.
2. Add a `Delta_H(mu)` line plot with the zero crossing marked at `mu=0.7`.
3. Report a parametric window for the zero crossing: values for which H prefers unanimity over a nonempty subset of both-form beliefs.

### C1: Institutional Classification Under the Baseline Assessment

**Statement:** The belief space is partitioned into no formation, only majority, both with H preferring unanimity, both with H indifferent, and both with H preferring majority.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PRESENT | The five sets are explicitly defined. |
| 2 | Comparative statics | MISSING | Add a classification comparative-statics appendix: how do the five regions move with `chi`, `beta`, `m`, and threshold gap? |
| 3 | Phase/region diagram | MISSING | Add the full `(mu, chi)` classification plot. This is the natural visual summary of the paper. |
| 4 | Parametric window | PARTIAL | The calibration gives intervals in `chi`, but no robustness window for the five-way classification. |
| 5 | Margin table | PARTIAL | Tables 3 and 5 support classification, but there is no single table listing all active classification boundaries and margins. |
| 6 | Verbal intuition before | PRESENT | The text clearly warns that the classification is weaker than an unconditional ranking theorem. |
| 7 | Worked example | PARTIAL | The working calibration provides an example, but it appears after the corollary. |
| 8 | Mapping to reality | PARTIAL | The OPEC mapping supports classification, but the five regions are not translated into five observable institutional cases. |
| 9 | Proof location | PRESENT | Proof is in Appendix A.5 and the main text includes a pointer. |

**Comparative statics gap analysis:**
Parameters analyzed: none formally.
Parameters NOT analyzed for this result: `chi` (moves no-formation and only-majority regions), `mu` (moves H-ranking regions through `Delta_H`), `beta`, `m`, `t_0`, `t_1`, `o_0`, and `o_1` (move formation and payoff-gap boundaries).

**Priority actions (ranked):**
1. Add a full `(mu, chi)` classification figure with the five regions labeled.
2. Add a robustness table showing how the two entry thresholds and `Delta_H=0` threshold move under parameter changes.
3. Translate the five formal categories into OPEC-style institutional scenarios.

### E1: Working Calibration

**Statement:** The calibration uses `N=13`, `beta=0.9`, `t_0=0.19`, `t_1=0.285`, `o_0=t_0`, and `o_1=t_1`; it selects pooling in R1, gives `V_W^U=0.0619583`, `V_W^M=0.0833333`, and `Delta_H(mu)=0.0665-0.095mu`.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PRESENT | The calibration reports all active numerical thresholds and the linear payoff-gap boundary. |
| 2 | Comparative statics | MISSING | Add one robustness table or appendix figure sweeping each calibrated parameter one at a time. |
| 3 | Phase/region diagram | MISSING | Add R2, R1, entry, and classification plots generated from scripts. |
| 4 | Parametric window | MISSING | The calibration is a single point and lies on `a_0^1=a_1`; report open intervals where the core classification survives. |
| 5 | Margin table | PRESENT | The paper now has strong margin tables for domain, R1, entry, and H-gap quantities. |
| 6 | Verbal intuition before | PRESENT | The calibration text explains the knife-edge and the substantive reading. |
| 7 | Worked example | PRESENT | This is a worked numerical example. |
| 8 | Mapping to reality | PRESENT | The OPEC mapping table and discussion provide a clear empirical interpretation. |
| 9 | Proof location | PARTIAL | The reproducibility ledger identifies scripts, but the text should state which script reproduces each calibration table. |

**Comparative statics gap analysis:**
Parameters analyzed: none beyond the baseline point.
Parameters NOT analyzed for this result: all calibrated primitives: `N/m`, `beta`, `t_0`, `t_1`, `o_0`, `o_1`, `ybar`, and `chi`. The most important robustness questions are whether pooling remains selected, whether `F_U subset F_M` remains strict, and whether `Delta_H` crosses zero inside `[0,1]`.

**Priority actions (ranked):**
1. Add a robustness/window table: vary `beta`, `t_0`, `t_1`, and the threshold gap while holding the others fixed.
2. Add a classification plot from the existing script infrastructure.
3. Make the script-to-table mapping explicit in the caption notes or reproducibility ledger.

## Cross-Result Summary Table

| Result | 1:Boundary | 2:CompStat | 3:Region | 4:Window | 5:Margin | 6:Intuition | 7:Example | 8:Mapping | 9:Proof |
|--------|------------|------------|----------|----------|----------|-------------|-----------|-----------|---------|
| P1 Majority | PRESENT | PARTIAL | MISSING | PARTIAL | PRESENT | PRESENT | PARTIAL | PARTIAL | PRESENT |
| L1 Terminal U | PRESENT | PARTIAL | MISSING | PARTIAL | PARTIAL | PRESENT | PRESENT | PARTIAL | PRESENT |
| P2 R1 P/L/R | PARTIAL | MISSING | MISSING | PARTIAL | PRESENT | PRESENT | PARTIAL | PARTIAL | PRESENT |
| R1 Delay remark | PARTIAL | MISSING | MISSING | MISSING | PARTIAL | PRESENT | PARTIAL | MISSING | PARTIAL |
| P3 Entry nesting | PRESENT | PARTIAL | MISSING | PARTIAL | PRESENT | PRESENT | PARTIAL | PARTIAL | PRESENT |
| P4 H comparison | PARTIAL | MISSING | MISSING | PARTIAL | PRESENT | PRESENT | PARTIAL | PARTIAL | PRESENT |
| C1 Classification | PRESENT | MISSING | MISSING | PARTIAL | PARTIAL | PRESENT | PARTIAL | PARTIAL | PRESENT |
| E1 Calibration | PRESENT | MISSING | MISSING | MISSING | PRESENT | PRESENT | PRESENT | PRESENT | PARTIAL |

## Global Recommendations

### 1. Notation summary table

The paper already has a useful notation table in Appendix C.1. This is a major improvement and should be kept. To make it fully complete, add `a_theta(nu)`, `C_theta(nu)`, `K(mu)`, `S_K^U(mu)`, `H_K(mu)`, and the names of the maintained conditions: Threshold Order, High-Posterior Pooling, R1 Dynamic Threshold Order, Majority Threshold Order, and No-Cheap-H.

### 2. Game tree or timeline diagram

The paper has a timing diagram, which is adequate for the basic game. The next upgrade is not another generic timeline but a result-oriented diagram: a compact branch diagram showing the R1 candidate comparison under unanimity (`P`, `L`, `R`) and the majority no-screening path. This would help readers see why the paper is not claiming an unrestricted PBE characterization.

### 3. Most critical gaps across all results

The highest-leverage missing item is phase/region visualization. Add three figures in this order:

1. R1 `P/L/R` region plot.
2. `(mu, chi)` entry and institutional classification plot.
3. `Delta_H(mu)` plot with the zero crossing marked.

The second systematic gap is comparative statics. The fastest path is not to prove every derivative in the main text. Add an appendix "Comparative Statics and Robustness" with compact remarks and tables:

1. No-Cheap-H comparative statics.
2. Terminal cutoff comparative statics for `mu_2^*`.
3. R1 pairwise candidate boundaries.
4. Calibration windows for `beta`, `t_0`, `t_1`, and `t_1-t_0`.
5. Classification robustness: entry thresholds and `Delta_H=0` under parameter sweeps.

The third gap is example placement. The manuscript has a good motivating example and a strong working calibration, but most formal results appear before the numerical objects that make them intuitive. Consider adding one short "running calibration preview" paragraph before the institutional-choice results, while leaving the detailed tables in the calibration section.

## Highest-Priority Implementation Plan

1. **Create scripts for region plots and windows.** Build on the existing `verify_relative_package_*_piH0.R` scripts. Add one script that outputs: terminal region data, R1 candidate-region data, `(mu, chi)` classification data, and parameter-window tables.
2. **Add an R1 candidate-boundary subsection.** Show the inequalities for `P >= L`, `P >= R`, and `L >= R`. Even if the expressions are piecewise, a reader should not have to infer the regimes from a max operator.
3. **Add a robustness/window table for the calibration.** The present calibration is transparent but sits on `a_0^1=a_1`. Report which results survive in an open neighborhood and which are intentionally boundary-based.
4. **Upgrade classification presentation.** The five-set corollary is clean but abstract. A `(mu, chi)` figure would become the paper's main takeaway visual.
5. **Tie scripts to tables.** In Appendix C.2, list which script reproduces each table and figure by label, not only by object class.

## Bottom Line

After commit `a6e0fe9`, the manuscript is formally disciplined enough that the main presentation problem is no longer proof location or notation. The proof pointers, appendix proofs, passive-assessment scope, and margin tables are mostly in place. The remaining weakness is that the reader sees one calibrated point and several max/set definitions, but not the geometry of the model. To reach the Kenkel-Paine/Hirsch-Shotts standard, the paper needs region plots, comparative-statics remarks, and open parameter windows, especially for R1 candidate selection and the final institutional classification.
