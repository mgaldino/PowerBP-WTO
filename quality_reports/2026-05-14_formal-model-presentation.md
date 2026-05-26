# Formal Model Presentation Diagnostic

**Paper:** `formal_model_v5.Rmd`  
**Date:** 2026-05-14  
**Results analyzed:** 7  
**Checklist items assessed:** 63

## Summary statistics

- Items PRESENT: 22/63 (34.9%)
- Items PARTIAL: 16/63 (25.4%)
- Items MISSING: 25/63 (39.7%)
- Most common gap: comparative statics, region diagrams, parametric windows, and margin tables.

## Model parameter set

Core primitives: \(N\), \(m=N-1\), \(q=\lfloor N/2\rfloor+1\), \(k=q-1\), \(\mu\), \(\theta\), \(t_0,t_1\), \(\bar y\), \(\beta\), \(\pi_H=0\), \(\chi\), \(o_0,o_1\).  
Derived thresholds and values: \(c_M\), \(a_0^M,a_1^M\), \(p_2(\mu)\), \(W_2^U(\mu)\), \(C_0(\nu),C_1(\nu)\), \(c(\nu)\), \(a_0^1,a_1\), \(\Pi_P^U,\Pi_L^U,\Pi_R^U\), \(S_P^U,S_L^U,S_R^U\), \(V_W^U,V_W^M,V_H^U,V_H^M,\Delta_H\), \(F_U,F_M\).

## Per-result diagnosis

### P1: Majority no-screening benchmark

**Statement:** Majority removes screening iff the low-threshold hegemon is not cheaper than a weak voter: \(a_0^M\geq\beta/m\).

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PRESENT | The condition \(a_0^M\geq\beta/m\) is excellent and interpretable. |
| 2 | Comparative statics | PARTIAL | Add a remark: increasing \(\beta\) or decreasing \(m\) raises the weak-voter price; increasing \(a_0^M\) makes no-screening easier. |
| 3 | Phase/region diagram | MISSING | Add a 2D plot with \(a_0^M\) on x-axis and \(\beta/m\) or \(\beta\) on y-axis; shade no-screening vs majority-screening. |
| 4 | Parametric window | MISSING | Report the open set around the calibration where \(a_0^M>\beta/m\). |
| 5 | Margin table | MISSING | Add row: \(a_0^M=0.171\), boundary \(0.075\), margin \(0.096\). |
| 6 | Verbal intuition before | PRESENT | The prose before the proposition explains why buying \(H\) can substitute for a weak voter. |
| 7 | Worked example | PARTIAL | Calibration appears later; move a one-line numerical check before or right after P1. |
| 8 | Mapping to reality | PARTIAL | OPEC mapping appears later; add a short model-to-reality note in the model section. |
| 9 | Proof location | PRESENT | Proof is in Appendix A.1. |

**Comparative statics gap analysis:**  
Analyzed: \(a_0^M\), \(\beta/m\) informally.  
Not analyzed: \(N,m,q,k,\beta,a_1^M,\bar y\). Explain that \(q,k,a_1^M,\bar y\) mainly affect feasibility or dominated alternatives, while \(a_0^M,\beta,m\) drive the boundary.

**Priority actions:**  
1. Add a margin table for the no-cheap-\(H\) condition.  
2. Add a region diagram for no-screening vs majority-screening.  
3. Add comparative statics for \(a_0^M,\beta,m\).

### L1: Terminal unanimity threshold

**Statement:** In R2, weak proposers choose low-only for \(\mu\leq\mu_2^*=(t_1-t_0)/(1-t_0)\), pooling otherwise.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PRESENT | \(\mu_2^*\) is clean and interpretable. |
| 2 | Comparative statics | MISSING | State: \(\mu_2^*\) increases in \(t_1\); effect of \(t_0\) is \((t_1-1)/(1-t_0)^2<0\) when \(t_1<1\). |
| 3 | Phase/region diagram | MISSING | Add \((t_0,t_1)\) or \((\mu,t_1)\) diagram showing low-only vs pooling regions. |
| 4 | Parametric window | MISSING | Report threshold-domain window around \(t_0=0.19,t_1=0.285\). |
| 5 | Margin table | PARTIAL | Calibration reports \(\mu_2^*\), but not slack from \(0<t_0<t_1<1\). |
| 6 | Verbal intuition before | PRESENT | The text explains why only thresholds matter. |
| 7 | Worked example | PARTIAL | Motivating example has the same logic; add actual calibrated calculation in this subsection. |
| 8 | Mapping to reality | PARTIAL | OPEC maps \(t_\theta\) later; move a brief referent earlier. |
| 9 | Proof location | PRESENT | Proof is in Appendix A.2. |

**Comparative statics gap analysis:**  
Not analyzed: \(t_0,t_1,\bar y,\mu\). Add a short appendix remark with derivatives of \(\mu_2^*\).

**Priority actions:**  
1. Add comparative statics for \(\mu_2^*\).  
2. Add a small two-region figure for R2.  
3. Add a margin row for threshold-domain slack.

### T1: R1 passive-belief pure-strategy unanimity outcome

**Statement:** Under passive beliefs, selected R1 unanimity outcome is the weak-proposer argmax among \(P,L,R\), with ties minimizing \(H\)'s payoff.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PARTIAL | Candidate payoffs are closed form, but the selected regions are not expressed as clean pairwise inequalities. |
| 2 | Comparative statics | MISSING | Need how \(\beta,m,a_0^1,a_1,t_0,t_1\) shift P/L/R selection. |
| 3 | Phase/region diagram | MISSING | Plot P/L/R regions in \((\mu,a_0^1)\), \((\mu,\beta)\), or \((\mu,t_1-t_0)\). |
| 4 | Parametric window | MISSING | Report where pooling-only calibration is robust. |
| 5 | Margin table | MISSING | Add candidate payoff margins at \(\mu=0,\mu_2^*,0.5,1\). |
| 6 | Verbal intuition before | PRESENT | Candidate intuition appears before theorem. |
| 7 | Worked example | PARTIAL | Calibration states pooling for all beliefs, but does not show candidate payoff comparison as a table. |
| 8 | Mapping to reality | PARTIAL | P/L/R can map to "full concession", "test Saudi threshold", "delay"; not yet explicit. |
| 9 | Proof location | PRESENT | Proof is in Appendix A.3. |

**Comparative statics gap analysis:**  
Not analyzed: every key parameter. This is the largest presentation gap in the paper. Add an appendix "R1 candidate-region analysis" with pairwise differences \(\Pi_P-\Pi_L\), \(\Pi_P-\Pi_R\), and \(\Pi_L-\Pi_R\).

**Priority actions:**  
1. Derive and display pairwise boundaries for P/L/R.  
2. Add a P/L/R region plot.  
3. Add a candidate payoff margin table for the calibration.

### R1: Delay is endogenous

**Statement:** Rejection/continuation is a candidate outcome, not an imposed assumption.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | MISSING | Need condition under which \(R\) beats \(P\) and \(L\). |
| 2 | Comparative statics | MISSING | Analyze how \(\beta\), threshold gap, and \(m\) make delay more likely. |
| 3 | Phase/region diagram | MISSING | Add region showing where \(R\) is selected. |
| 4 | Parametric window | MISSING | Use diagnostic case with \(b_0=0.03\) only if translated into net thresholds; otherwise omit. |
| 5 | Margin table | MISSING | Add \(R-P\), \(R-L\) margins where delay occurs. |
| 6 | Verbal intuition before | PARTIAL | Current remark is short; needs a paragraph on why waiting has value. |
| 7 | Worked example | MISSING | Include a compact non-calibrated example if delay remains in body. |
| 8 | Mapping to reality | PARTIAL | Could map to postponed quota negotiations or waiting for information. |
| 9 | Proof location | PARTIAL | Proof embedded in theorem proof; no separate delay proof. |

**Priority actions:**  
1. Either move delay to scope/appendix or add a numerical example and boundary.  
2. Do not keep it as a body result without a demonstrated parameter region.

### P2: Weak-state entry nesting

**Statement:** Under no-cheap-\(H\), weak-state entry under unanimity is nested in majority: \(F_U(\chi)\subseteq F_M(\chi)\).

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PARTIAL | \(V_W^U\leq1/m\) is clear, but \(F_U\) depends on selected candidate. |
| 2 | Comparative statics | MISSING | Need how \(N,\beta,t_0,t_1,a_1,\chi\) shift \(F_U\). |
| 3 | Phase/region diagram | MISSING | Plot entry regions in \((\mu,\chi)\): no rule, only majority, both. |
| 4 | Parametric window | PARTIAL | Calibration gives \(\chi\) cutoffs; no robustness window. |
| 5 | Margin table | PARTIAL | Calibration reports min gap 0.021375 in appendix ledger; make it a table. |
| 6 | Verbal intuition before | PRESENT | Text explains collective entry. |
| 7 | Worked example | PRESENT | Calibration illustrates entry cutoffs. |
| 8 | Mapping to reality | PARTIAL | OPEC mapping present but not tied to \(\chi\). |
| 9 | Proof location | PRESENT | Proof is in Appendix A.4. |

**Priority actions:**  
1. Add \((\mu,\chi)\) institutional formation figure.  
2. Add a margin table for \(V_W^M-V_W^U\).  
3. Interpret \(\chi\) empirically as organizational participation or compliance cost.

### P3: Conditional comparison for the hegemon

**Statement:** When both rules form, \(H\)'s ranking is determined by \(\Delta_H(\mu)\).

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PARTIAL | The calibration gives \(\Delta_H=0.0665-0.095\mu\), but general boundaries are implicit. |
| 2 | Comparative statics | MISSING | Need how \(o_0,o_1,t_0,t_1,a_1\) affect \(\Delta_H\). |
| 3 | Phase/region diagram | MISSING | Plot \(\Delta_H>0\) vs \(\Delta_H<0\) in \((\mu,t_1-t_0)\) or \((\mu,o_1-o_0)\). |
| 4 | Parametric window | MISSING | Report range of threshold gaps where \(\mu^H=0.7\)-type cutoff is interior. |
| 5 | Margin table | MISSING | Add \(\Delta_H\) at \(\mu=0,0.5,0.7,1\). |
| 6 | Verbal intuition before | PARTIAL | Needs more intuition before proposition. |
| 7 | Worked example | PRESENT | Working calibration gives exact cutoff. |
| 8 | Mapping to reality | PARTIAL | OPEC maps after the result; cross-reference earlier. |
| 9 | Proof location | PRESENT | Proof is in Appendix A.5. |

**Priority actions:**  
1. Add \(\Delta_H\) graph over \(\mu\) for the calibration.  
2. Derive general sign boundary for major selected candidates.  
3. Add margin table at benchmark beliefs.

### C1: Complete institutional classification

**Statement:** The five categories partition beliefs and entry costs.

| # | Item | Status | Action |
|---|------|--------|--------|
| 1 | Closed-form boundary | PARTIAL | Sets are explicit, but not visualized as boundaries in \((\mu,\chi)\). |
| 2 | Comparative statics | MISSING | Need how category regions change with \(\chi,N,\beta,t_0,t_1\). |
| 3 | Phase/region diagram | MISSING | This result needs the main figure: \((\mu,\chi)\) classification map. |
| 4 | Parametric window | PARTIAL | Calibration table exists, but no open-set robustness. |
| 5 | Margin table | PARTIAL | Some margins in text; consolidate. |
| 6 | Verbal intuition before | PRESENT | The text explains why no only-unanimity region exists. |
| 7 | Worked example | PRESENT | Calibration table illustrates classification. |
| 8 | Mapping to reality | PARTIAL | OPEC discussion maps mechanism, but not five categories explicitly. |
| 9 | Proof location | PRESENT | Proof is in Appendix A.5. |

**Priority actions:**  
1. Create the paper's main results figure: classification in \((\mu,\chi)\).  
2. Add one paragraph mapping each category to substantive institutional outcomes.  
3. Add robustness ranges for the calibrated classification.

## Cross-result summary

| Result | 1:Boundary | 2:CompStat | 3:Region | 4:Window | 5:Margin | 6:Intuition | 7:Example | 8:Mapping | 9:Proof |
|--------|------------|------------|----------|----------|----------|-------------|-----------|-----------|---------|
| P1 Majority | PRESENT | PARTIAL | MISSING | MISSING | MISSING | PRESENT | PARTIAL | PARTIAL | PRESENT |
| L1 R2 | PRESENT | MISSING | MISSING | MISSING | PARTIAL | PRESENT | PARTIAL | PARTIAL | PRESENT |
| T1 R1 | PARTIAL | MISSING | MISSING | MISSING | MISSING | PRESENT | PARTIAL | PARTIAL | PRESENT |
| R1 Delay | MISSING | MISSING | MISSING | MISSING | MISSING | PARTIAL | MISSING | PARTIAL | PARTIAL |
| P2 Nesting | PARTIAL | MISSING | MISSING | PARTIAL | PARTIAL | PRESENT | PRESENT | PARTIAL | PRESENT |
| P3 H comparison | PARTIAL | MISSING | MISSING | MISSING | MISSING | PARTIAL | PRESENT | PARTIAL | PRESENT |
| C1 Classification | PARTIAL | MISSING | MISSING | PARTIAL | PARTIAL | PRESENT | PRESENT | PARTIAL | PRESENT |

## Global recommendations

1. **Add a notation summary table.** The paper does not yet have a complete notation table. Add Appendix C.1 before the reproducibility ledger with columns: Symbol, Type, Meaning, Where used.
2. **Upgrade the timing figure into a model figure.** Figure 1 is useful but too schematic. Add payoff objects and indicate how \(U\) makes \(H\) pivotal while \(M\) permits exclusion.
3. **Create three core visual outputs from scripts.**
   - Figure 2: R2 low-only vs pooling regions in \((\mu,t_1)\) or \((t_0,t_1)\).
   - Figure 3: R1 P/L/R candidate regions.
   - Figure 4: complete institutional classification in \((\mu,\chi)\).
4. **Add margin tables.** At minimum: no-cheap-\(H\), threshold-domain slack, R1 candidate payoff margins, weak-entry nesting gap, and \(\Delta_H\) at selected beliefs.
5. **Add comparative statics appendix.** The current paper is technically correct but under-presented. A reader needs directional claims for \(t_0,t_1,\beta,m,\chi,o_0,o_1\).
6. **Clarify delay.** Either make delay a real result with boundary/example/region, or move it fully to scope and keep T1 focused on \(P,L,R\) candidate selection.

## Highest-priority implementation sequence

1. Build a notation table.
2. Add a \((\mu,\chi)\) classification figure, because it integrates nesting and \(\Delta_H\).
3. Add margin tables from existing `verify_relative_package_*` scripts.
4. Add an appendix remark with comparative statics for \(\mu_2^*\), no-cheap-\(H\), and calibrated \(\Delta_H\).
5. Decide whether delay remains a body-level result or becomes an appendix/scope point.
