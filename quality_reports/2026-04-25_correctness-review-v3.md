# Correctness & Exposition Review: formal_model_v3.Rmd

**Date**: 2026-04-25
**Scope**: Lemma 1, Theorem 1, Theorem 2 (statements + proofs), R code, exposition for JoP
**Verdict**: All three results are **mathematically correct**. Two exposition issues require attention before submission.

---

## 1. Lemma 1 (Conditional payoff dominance) — CORRECT

### Statement
> $\alpha < \alpha^*(N,\beta)$ if and only if $E_\theta[V_H^{R1}(\theta,\mu,U)] > E_\theta[V_H^{R1}(\theta,\mu,M)]$ for every $\mu \in (0,1]$.

The biconditional (iff) is correctly stated. $\alpha^*$ is the unique root of $C_{\text{buy}} - C_{\text{out}}(1-\beta) = 0$, which gives the formula in the paper.

### Proof (Appendix B.5) — line-by-line verification

**Decomposition**: $D(\mu) = D_{\text{base}} + \mathbf{1}\{\mu < \mu_s^{R2}\}\delta_{R2} + \mathbf{1}\{\mu > \mu_s^{R1}\}\delta_{R1}$.

- $D_{\text{base}}(\mu) = [(C_{\text{buy}} - C_{\text{out}})V_e(\mu) + C_{\text{out}}\beta r]/N^2$ — verified. This captures the payoff difference on the middle branch (aggressive R1, conservative R2).
- $\delta_{R2}(\mu) = (N-1)\beta[\mu(r-\alpha) - \alpha(r-1)]/N^2$ — verified. Vanishes at $\mu_s^{R2} = \alpha(r-1)/(r-\alpha)$. Captures the V_W^R2 difference between aggressive and conservative R2 branches, which affects H's payoff via the H-proposes term.
- $\delta_{R1}(\mu) = (N-1)\beta(r-1)(1-\mu)/N^2 \geq 0$ — verified. This is exactly the overpayment rent from conservative R1 offers.

**Critical subtlety confirmed**: The R1 aggressive offer is $y_H = \beta V_H^{R2}(\theta=0, \mu'=1) = \beta(1+x)/N$ (using the OFF-PATH posterior $\mu=1$ after rejection reveals $\theta=1$), NOT $\beta V_H^{R2}(\theta=0, \mu)$. This is why the R1 offer doesn't depend on the current R2 branch and the decomposition works cleanly.

**Step 2 ($D_{\text{base}} > 0$)**:
- At $\mu=1$: $D_{\text{base}}(1) = r[C_{\text{buy}} - C_{\text{out}}(1-\beta)]/N^2 > 0$ under $\alpha < \alpha^*$. Verified algebraically.
- At $\mu=0$: The tighter condition $D_I(0) = [\beta(q-1) - \alpha d_0]/N^2 > 0$ is checked, where $d_0 = N(N-1) - \beta[(N-1)^2 r + N - q]$. The proof shows $\bar\alpha_0 = \beta(q-1)/d_0 > \alpha^*$ because $d_* - d_0 = \beta(N-1)^2(r-1) > 0$. Verified.

**Necessity (Step 4)**: At $\mu=1$, both corrections vanish, so $D(1) = D_{\text{base}}(1)$. For $\alpha \geq \alpha^*$, $D(1) \leq 0$. Clean and correct.

### Numerical validation
- **144/144** parameter combinations tested ($r \in \{1.2, 1.5, 2, 3\}$, $\alpha \in \{0.05, 0.1, 0.2, 0.3\}$, $N \in \{5, 10, 30\}$, $\beta \in \{0.7, 0.9, 0.99\}$): $\min D(\mu) > 0$ for all testable cases (those with $\alpha < \alpha^*$).
- **Necessity**: 12 cases with $\alpha$ just above $\alpha^*$: $D(1) < 0$ in all cases.

### Verdict: **PASS**

---

## 2. Theorem 1 (Dominance of unanimity) — CORRECT

### Statement
> If $\alpha < \alpha^*(N,\beta)$ and $p \in E_U$, then $\Pi_H^*(U,p) > \Pi_H^*(M,p)$.

### Proof (Appendix B.6)

**Step 1**: $E_U \subseteq E_M$. Uses budget identity under majority ($E[V_H] + (N-1)V_W = V_e$) and inequality under unanimity ($\leq V_e$, with strict on aggressive branch due to discounting). Combined with Lemma 1 ($E[V_H(\mu,U)] > E[V_H(\mu,M)]$), this gives $V_W(\mu,U) < V_W(\mu,M)$, hence $E_U \subseteq E_M$. Verified.

**Step 2**: $\text{cav}\, v(p,M) = v(p,M)$ for $p \in E_M$. Key insight: $v(\mu,M) = \lambda_M V_e(\mu)$ is affine on $E_M$, so no experiment can improve the majority payoff above $v(p,M)$. The proof uses the decomposition of any Bayes-plausible experiment and bounds $\sum_{s \in A} \pi_s \leq 1$ and $\sum_{s \in A} \pi_s \mu_s \leq p$. Verified. Numerically confirmed: $\max |cav_M - v_M|$ in $E_M$ is $< 10^{-15}$ across tested parameters.

**Step 3**: Chain $\Pi_H^*(U,p) = \text{cav}\,v(p,U) \geq v(p,U) > v(p,M) = \text{cav}\,v(p,M) = \Pi_H^*(M,p)$. Each inequality is justified: first by definition of concavification, second by Lemma 1, third by Step 2.

### Numerical validation
- **80/80** testable parameter combinations: $\text{cav}\,v(p,U) > \text{cav}\,v(p,M)$ for all $p \in E_U$.

### Verdict: **PASS**

---

## 3. Theorem 2 (Single-crossing institutional comparison) — CORRECT

### Statement
The comparison $\Pi_H^*(U,p) - \Pi_H^*(M,p)$ changes sign at most once, with majority dominating at low priors (through the entry margin) and unanimity at high priors.

### Proof (Appendix B.7)

**Step 1 (Concavification below thresholds)**: For $p < \tau(U)$, $\text{cav}\,v(p,U) = S_U \cdot p$ where $S_U = \max_{\mu \in E_U} v(\mu,U)/\mu$. Standard result for value functions that are zero below a threshold. Same for $S_M$ when $\tau(M) > 0$. Verified.

**Step 2 (Case $\tau(M)=0$)**: $D(p) = S_U p - \lambda_M V_e(p)$ is affine on $(0, \tau(U))$. $D(0) = -\lambda_M < 0$. At $p = \tau(U)$, the limit $S_U \tau(U) - \lambda_M V_e(\tau(U)) > 0$ follows because $S_U \geq v(\tau(U),U)/\tau(U) > v(\tau(U),M)/\tau(U) = \lambda_M V_e(\tau(U))/\tau(U)$ (by Lemma 1). So unique crossing $p^* \in (0, \tau(U))$.

**Note**: The proof text invokes "by Theorem 1, $D(\tau(U)) > 0$" which refers to $\text{cav}\,v(\tau(U),U) - \text{cav}\,v(\tau(U),M) > 0$, not directly to the affine formula. This is technically correct but could be made more explicit by noting that the limit of the affine $D$ at $\tau(U)^-$ is also positive (via $S_U \geq v(\tau(U),U)/\tau(U)$ and Lemma 1). **Minor expository gap**, not a logical error.

**Steps 3-5**: Cases $S_U > S_M$, $S_U = S_M$, $S_U < S_M$ follow the same affine-with-opposite-endpoints logic. Each is correct.

### Numerical validation
- **81/81** testable cases: at most 1 sign change in $\text{cav}\,v(p,U) - \text{cav}\,v(p,M)$.

### Verdict: **PASS**

---

## 4. R Code (scripts/model_functions.R) — CORRECT

All four functions (`VH_R1_unanimity`, `VW_R1_unanimity`, `VH_R1_majority`, `VW_R1_majority`) and `concavify` produce results consistent with the analytical formulas.

**Key verification**:
- R1 aggressive offer correctly uses $\beta(1+x)/N$ (off-path R2 continuation for $\theta=0$ at $\mu'=1$), not $\alpha$. This is subtle but right.
- Budget identity: exact match ($<10^{-15}$) on conservative branch; surplus destruction $(N-1)\mu r(1-\beta)/N$ exactly matches on aggressive branch.
- Cutoff $\mu_s^{R1}$: computed from quadratic, matches `F1_agg > F1_con` switch point in code.

---

## 5. Issues Found

### 5.1 MAJOR (exposition): Game tree offers mislabeled (Figure 2)

**Location**: Figure 2 (`fig:gametree-b`), lines 220-277.

**Problem**: The game tree labels the R1 aggressive offer as $y_H = \alpha$ and the R1 conservative offer as $y_H = \alpha r$. These are the **R2 offers** (where the comparison is against disagreement payoffs $\alpha V(\theta)$). In R1, the offers are:
- Aggressive: $y_H = \beta(1 + x)/N$ (matching $\theta=0$'s off-path R2 continuation)
- Conservative: $y_H = \beta(r + x)/N$ (matching $\theta=1$'s R2 continuation)

Numerically, for the Example parameters ($N=5, r=1.5, \alpha=0.3, \beta=0.9$): the R1 aggressive offer is 0.504, not 0.3; the R1 conservative offer is 0.594, not 0.45.

The terminal payoffs in the tree are also R2-style: $(\alpha, 1-\alpha-c)$ for aggressive acceptance and $(\alpha r, V(\theta)-\alpha r-c)$ for conservative, rather than the actual R1 equilibrium payoffs.

**Impact**: A careful referee with pen and paper will catch this. It doesn't affect any results (proofs use the correct formulas), but creates confusion about the equilibrium.

**Fix**: Either (a) label the offers correctly as $y_H = \beta V_H^{R2}(\theta=0)$ and $y_H = \beta V_H^{R2}(\theta=1)$, updating terminal payoffs accordingly; or (b) add a note that the tree is schematic and shows offer *logic* rather than exact payoff levels, deferring precise expressions to Appendix A.3.

### 5.2 MINOR: Remark 1 uses proof-internal notation

**Location**: Remark 1 (`rem:mu_bar`), lines 505-511.

**Problem**: The remark uses $C_{\text{buy}}$ and $C_{\text{out}}$ without defining them. These are introduced in the proof of Lemma 1 (Appendix B.5), but a reader encountering the remark in the body (Section 7) would need to jump to the appendix to parse the formula. JoP body text should be self-contained.

**Fix**: Either define $C_{\text{buy}} \equiv \beta(q-1)(1-\alpha)$ and $C_{\text{out}} \equiv N(N-1)\alpha$ inline in the remark, or replace the formula with the verbal description: "$D(1) \leq 0$ when the cost of buying $N-1$ votes exceeds the bargaining advantage from screening."

### 5.3 MINOR: Motivating example jump approximation

**Location**: Section 2, line 76.

**Problem**: "The jump at $\mu^* = 1/9$ is $0.18$." The exact jump is $8/45 \approx 0.1778$, not $0.18$. The rounding is acceptable for a motivating example but could trip up a referee who verifies. The "16%" figure is accurate (16.0%).

**Fix**: Change to "$\approx 0.18$" or use the exact fraction $8/45$.

### 5.4 MINOR: Proposition 2 "principal regime" undefined in body

**Location**: Proposition 2, line 308.

**Problem**: "In the principal regime, the cutoff is..." but the principal regime condition ($\alpha < \bar\alpha(r,\beta,N)$, or equivalently $\Delta_1(\mu_s^{R2}) > 0$) is only stated in Appendix A.5. A referee may ask: when does the non-principal regime apply?

**Fix**: Add a parenthetical after "In the principal regime": "(which holds whenever $\alpha < \bar\alpha$; see Appendix A.5 for verification that this covers the empirically relevant range)."

---

## 6. Exposition Quality Assessment for JoP

### Comparison with JoP benchmarks (Hirsch 2023, Hill 2022, Tyson et al. 2024)

| Criterion | Status | Notes |
|-----------|--------|-------|
| Proofs in appendix, not body | PASS | All 7 proofs say "See Appendix B.x" |
| Body narrates mechanism in prose | PASS | Intuition paragraphs after each result |
| No proof sketches in body | PASS | Clean separation |
| Motivating example before model | PASS | Section 2 with N=3, effective |
| Notation table | PASS | Appendix A, comprehensive |
| Application section | PASS | GATT/WTO well-integrated |
| Preview of main result | PASS | End of Section 3, good for reader orientation |
| Introduction structure | PASS | Puzzle -> mechanism -> result -> roadmap |
| Length | ADEQUATE | Body ~14pp to Theorem 2, total ~30pp with appendices |

### Substantive exposition strengths
- The transition from motivating example (1-round, N=3) to general model (2-round BF, N generic) is well-motivated
- The "three building blocks" narrative (majority linearity, unanimity screening, BP exploitation) is clear and JoP-appropriate
- Scope conditions are honest about limitations ($\alpha^*$ decreasing in $N$, commitment assumption)
- The GATT-to-WTO transition paragraph is excellent JoP-level applied theory

### Exposition weaknesses beyond the issues above
- The Discussion section is long (~2.5pp). Hirsch 2023 keeps discussion to ~1.5pp. Consider compressing the "Alternative explanations" paragraph into the Scope subsection.
- Appendix C ($K>2$ types) has a proof sketch for Proposition 6, which is fine for an appendix but feels underdeveloped. The sketch says "equating the payoffs..." without showing the algebra. A referee might ask for the full derivation.

---

## 7. Summary

| Component | Correctness | Issues |
|-----------|-------------|--------|
| Lemma 1 (statement) | CORRECT | — |
| Lemma 1 (proof B.5) | CORRECT | — |
| Theorem 1 (statement) | CORRECT | — |
| Theorem 1 (proof B.6) | CORRECT | — |
| Theorem 2 (statement) | CORRECT | — |
| Theorem 2 (proof B.7) | CORRECT | Minor expository gap in Step 2 |
| R code | CORRECT | — |
| Game tree (Fig 2) | MISLABELED | R1 offers shown as R2 offers |
| Motivating example | MINOR IMPRECISION | Jump 8/45 shown as 0.18 |
| Body exposition | JoP-READY | Two minor notation issues |

**Overall assessment**: The mathematical content is sound. The proofs are complete, the code matches the analytics, and the results are numerically validated across 144+ parameter combinations. Before submission, fix the game tree labels (5.1) and the Remark 1 notation (5.2). The other issues are cosmetic.
