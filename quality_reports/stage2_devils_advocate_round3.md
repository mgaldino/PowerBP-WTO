# Devil's Advocate Report (Round 3): formal_model_v2.Rmd

**Date**: 2026-04-20
**Reviewer**: Devil's Advocate (automated, senior IR/Political Economy)
**Manuscript**: "Informational Power and Institutional Design: Why a Hegemon May Choose Consensus"
**File reviewed**: `formal_model_v2.Rmd` (979 lines)
**Prior reviews**: Round 1 (score: 45/100, BLOCK), Round 2 (score: 62/100, BLOCK)

---

## Part 1: Verification of Round 2 Issues

### V1 (CRITICAL: Lemma 1 proof relied on numerical verification) -- FIXED

The proof has been completely rewritten with a fully analytical $D_{\text{base}} + \delta_{R2} + \delta_{R1}$ decomposition. I verified:

- $D_{\text{base}}(1) = r[P - Q(1-\beta)]/N^2$: correct algebra. Setting $P - Q(1-\beta) = 0$ recovers $\alpha^*$.
- $D_{\text{base}}(0) = [P + Q(\beta r - 1)]/N^2$: correct.
- The key step $D_I(0) > 0$: the proof correctly handles two sub-cases ($d_0 \leq 0$ and $d_0 > 0$), and the inequality $\bar\alpha_0 > \alpha^*$ follows from $d_* - d_0 = \beta(N-1)^2(r-1) > 0$. Verified algebraically.
- $\delta_{R2}(\mu_s^{R2}) = 0$: correct (the numerator $\mu(r-\alpha) - \alpha(r-1)$ evaluated at $\mu_s^{R2} = \alpha(r-1)/(r-\alpha)$ gives $\alpha(r-1)(r-\alpha)/(r-\alpha) - \alpha(r-1) = 0$).
- $\delta_{R1}(\mu) \geq 0$ for $\mu \leq 1$: immediate.
- Assembly across three regions: each uses positive quantities. No gap.

**Verdict: Genuinely fixed.** The proof is now rigorous. No residual concern.

### V2 (alpha* restrictiveness for large N) -- FIXED

Section 9.3 now computes $\alpha^*$ for $N = 3, 5, 7, 9$ and discusses the monotonic decline with $N$. The paragraph also clarifies that $\alpha^* < 1/r$ becoming binding for large $N$ does not eliminate the mechanism entirely -- the screening jump persists even when Lemma 1 fails globally; the condition restricts when unanimity dominates *everywhere* versus *somewhere*. This is an adequate response.

**Verdict: Fixed.**

### V5 (BP commitment) -- FIXED

Section 9.3 now has a substantive paragraph with three arguments: reputation in repeated interactions, institutional transparency rules (WTO notifications, TPRs), and upper-bound interpretation. The Crawford-Sobel reference is present. This is adequate for a formal theory paper.

**Verdict: Fixed.**

### V6 (Entry cost c interpretation) -- FIXED

A new paragraph after the entry threshold discussion (Section 7) interprets $c$ as accession costs, per-round delegation costs, or political costs of engagement, and clarifies the model is most applicable to settings with genuine participation decisions (trade rounds) rather than permanent membership.

**Verdict: Fixed.**

### V7 (Missing literature) -- FIXED

Feddersen & Pesendorfer (1998) is now cited in Section 2 with a clear distinction: F&P study information *aggregation* (unanimity impedes it), while this paper studies information *design* (unanimity amplifies it). Diermeier & Myerson (1999) cited. Bardhi & Guo (2018) cited in the introduction with distinction: multi-receiver persuasion under unanimity without institutional comparison.

**Verdict: Fixed.** The positioning against F&P is well done.

### V8 (GATT/WTO illustration not discriminating) -- FIXED

Section 9.2 now includes a specific discriminating observable implication: "the hegemon's advantage from consensus should be largest in negotiations where informational asymmetry is substantial" (services, IP) versus transparent negotiations (linear tariff cuts). This is contrasted with legitimacy accounts (predict uniform consensus benefit) and self-enforcement accounts (predict consensus matters with weak enforcement, regardless of information). This gives the theory empirical bite.

**Verdict: Fixed.**

### V9 (alpha-bar undefined in Prop 3) -- FIXED

Proposition 3 now states the condition directly: "$\mu_s^{R1} > \mu_s^{R2}$ (which holds when $\Delta_1(\mu_s^{R2}) > 0$, i.e., when $\alpha$ is small enough that the R1 cutoff lies on the conservative R2 branch)." This is cleaner than defining a separate $\bar\alpha$ threshold.

**Verdict: Fixed.**

### V10 (Prop 5 proof: concavity of branches not stated) -- FIXED

Appendix B.4 now states: "Since $v(\mu, U)$ is affine on each branch (the expected payoff is linear in $\mu$ conditional on the weak proposer's strategy), the upward jump is the sole source of non-concavity." This fills the gap.

**Verdict: Fixed.**

### V11 (Corollary 2 imprecise) -- FIXED

Downgraded to Remark 2, with the comparative statics stated qualitatively ("more likely when...") under the remark label, which is appropriate.

**Verdict: Fixed.**

### V12 (Consensus vs unanimity distinction) -- FIXED

Footnote added to Definition 1 in Section 3, distinguishing formal unanimity from the WTO norm of not calling a formal vote.

**Verdict: Fixed.**

### V13 (Appendix B.6 circular reference) -- PARTIALLY FIXED

Appendix B.6 still says "The proof appears in the body of Section 8." However, it now adds a substantive one-paragraph summary of the five steps, which is a meaningful improvement. It is no longer a pure cross-reference -- it is a proof sketch in the appendix pointing to the full proof in the body. This is acceptable, though the ideal structure would be the reverse (sketch in body, full proof in appendix).

**Verdict: Acceptable. Residual concern is cosmetic.**

### V15 (alpha >= alpha* uncharacterized) -- FIXED

A new paragraph in Section 9.3 characterizes the $\alpha \geq \alpha^*$ regime: "the conditional payoff ranking is ambiguous: unanimity can dominate at low $\mu$ while majority dominates near $\mu = 1$." The paper appropriately restricts its main results to $\alpha < \alpha^*$ and explains what is lost in the other regime.

**Verdict: Fixed.**

---

## Part 2: Round 2 Issues NOT on the Verification List

### V4 (Binary types: "richer, not weaker" claim for K types) -- UNCHANGED

The conclusion still states: "With a finite number of types $K > 2$, the screening problem would generate $K-1$ cutoffs, each producing a jump---so the non-convexity structure becomes richer, not weaker." This remains an unverified claim. The paper has not added any qualification. A referee familiar with multi-cutoff screening problems will note that with $K$ types, some cutoffs could produce downward jumps (if the screening structure reverses at certain thresholds), and the aggregation of jumps is not guaranteed to preserve the non-convexity pattern. The claim is plausible but asserted without proof.

**Status: Still open. See V1 below.**

### V14 (Figure 1 single parameter set) -- UNCHANGED

Figure 1 still uses a single parameter vector. The Worked Example (new in this round) uses the same parameters. This is a minor presentational issue.

**Status: Still open. See V7 below.**

### V16 (Extension has no proposition) -- UNCHANGED

Appendix C has six subsections and substantial derivations but culminates only in Remark 1. No formal proposition.

**Status: Still open. See V8 below.**

---

## Part 3: New Issues Introduced by the Changes

### V1-NEW. The K-type claim remains unverified (MAJOR, carried from V4-R2)

**Location**: Conclusion (Section 10), paragraph 2.

**Description**: "The non-convexity structure becomes richer, not weaker" for $K > 2$ types. This is presented as a fact. With $K$ types and $K-1$ cutoffs in an asymmetric-information screening game, the direction of each jump depends on the curvature of the type distribution and the payoff structure at each cutoff. It is possible that some jumps are downward (when the screener switches from a more generous to a less generous strategy). The paper should either prove this claim for the specific payoff structure of this model or add "we conjecture" hedging.

**Severity**: Major
**Deduction**: -5 (overgeneralization beyond scope)
**Action**: REESCREVER -- weaken to "we conjecture" or prove for K=3

---

### V2-NEW. Theorem 1 case (b): $p^*$ formula requires $S_U > \lambda_M(r-1)$ but this is not verified (MODERATE)

**Location**: Theorem 1, case (b), equation for $p^*$.

**Description**: The threshold $p^* = \lambda_M/[S_U - \lambda_M(r-1)]$ is well-defined only if $S_U > \lambda_M(r-1)$. The proof establishes this implicitly: $D(p)$ is linear, $D(0) = -\lambda_M < 0$, $D(\tau(U)) > 0$, so the slope $S_U - \lambda_M(r-1)$ must be positive. But this implicit derivation should be made explicit. A reader will see the formula and immediately ask whether the denominator is positive. A single sentence ("Since $D$ goes from negative to positive, the slope $S_U - \lambda_M(r-1)$ is necessarily positive") would suffice.

**Severity**: Moderate
**Deduction**: -2 (incomplete statement of conditions)
**Action**: ADICIONAR -- one sentence in the proof or after the theorem

---

### V3-NEW. The Worked Example computes values without showing the formulas used (MINOR)

**Location**: Example 1 (after Proposition 4).

**Description**: The example states $E[V_H^{R1}] \approx 0.544$ below the cutoff, $\approx 0.602$ above, and $E[V_H^{R1}(M)] \approx 0.428$. These are numerical outputs from the R code but no closed-form expressions are given for verification. A reader cannot replicate these numbers from the formulas in the paper without running the code. Adding the formula $E[V_H^{R1}] = \mu V_H^1 + (1-\mu) V_H^0$ and plugging in the values from equations (5)--(7) and the R1 expressions would make the example self-contained.

While I verified these numbers by tracing through the code and they are consistent, the example would be stronger as a pedagogical device if it showed at least the top-level formula.

**Severity**: Minor
**Deduction**: -1 (clarity)
**Action**: ADICIONAR -- show the top-level formula and one line of substitution

---

### V4-NEW. The introduction claims the mechanism "reframes institutional design" but the model is static (MODERATE)

**Location**: Introduction, paragraph 6; Discussion, Section 9.3 "Broader implications."

**Description**: The introduction claims: "The mechanism reframes institutional design as a choice between agenda power and informational power." The broader implications paragraph pushes further: "as weaker states invest in independent analytical capacity, the informational asymmetry narrows ... the hegemon's incentive to prefer consensus weakens." These are dynamic claims. The model is strictly static: there is no learning, no investment, no evolution of information structures. The dynamic language is suggestive and interesting but entirely outside the model. A referee will note the gap between the formal results (static, one-shot) and the verbal claims (dynamic, evolutionary). The paper should either be more cautious about the dynamic framing or explicitly flag that the dynamic implications are conjectures motivated by the static mechanism but not formally derived.

**Severity**: Moderate
**Deduction**: -2 (insufficient hedging on dynamic claims)
**Action**: REESCREVER -- add explicit caveat that dynamic implications are suggestive, not derived

---

### V5-NEW. $\tau(U)$ is "characterized numerically" -- is this unavoidable? (MODERATE)

**Location**: Section 7, paragraph 3.

**Description**: The text states: "The threshold $\tau(U)$ is characterized numerically for general parameters." For a formal theory paper, this is a gap. The paper provides closed-form expressions for $\tau(M)$, for $\mu_s^{R1}$, for $\mu_s^{R2}$, and for $\alpha^*$. The entry threshold under unanimity is the one object that lacks a closed form. This is because $V_W^{R1}(\mu, U)$ is piecewise and the indifference condition $V_W^{R1}(\tau(U), U) = c$ does not simplify. But the paper should state more explicitly what makes the closed form unavailable (piecewise nature of the W payoff function and dependence on the screening regime at $\tau(U)$), and ideally provide the closed form on each branch (which would give $\tau(U)$ as a solution conditional on which regime applies at the threshold). This would make $\tau(U)$ semi-analytical rather than purely numerical.

**Severity**: Moderate
**Deduction**: -2 (incomplete characterization of a key object)
**Action**: ADICIONAR -- either provide the piecewise closed form for $\tau(U)$ or explain why it is unavailable and bound it

---

### V6-NEW. Budget identity argument in Section 8.2 needs the inequality direction spelled out (MINOR)

**Location**: Section 8.2 (The comparison without persuasion).

**Description**: The text argues: "Since Lemma 1 establishes $E[V_H(\mu, U)] > E[V_H(\mu, M)]$, it follows a fortiori that $V_W(\mu, M) > V_W(\mu, U)$." The reasoning is: under majority, $E[V_H(M)] + (N-1)V_W(M) = V_e(\mu)$; under unanimity, $E[V_H(U)] + (N-1)V_W(U) \leq V_e(\mu)$. From the first: $V_W(M) = (V_e - E[V_H(M)])/(N-1)$. From the second: $V_W(U) \leq (V_e - E[V_H(U)])/(N-1) < (V_e - E[V_H(M)])/(N-1) = V_W(M)$. The chain is correct but compressed. Making it explicit would help readers who are not used to these budget-identity manipulations.

**Severity**: Minor
**Deduction**: -1 (clarity)
**Action**: ADICIONAR -- one or two lines of algebra showing the chain

---

### V7-NEW. Figure 1 and Worked Example use same parameters -- no sensitivity shown (MINOR, carried from V14-R2)

**Location**: Figure 1, Example 1.

**Description**: Both Figure 1 and the Worked Example use $N=5, r=1.5, \alpha=0.3, \beta=0.9, c=0.1$. No alternative parameter configuration is shown visually. While Figure 2 provides parameter region plots (which are informative), a reader cannot see how the mechanism *looks* at different parameter values. A second panel in Figure 1 showing the mechanism near the boundary of the unanimity-preferred region would strengthen the visual argument.

**Severity**: Minor
**Deduction**: -1 (presentational)
**Action**: REESCREVER -- consider adding a second panel to Figure 1

---

### V8-NEW. Appendix C extension has no proposition (MINOR, carried from V16-R2)

**Location**: Appendix C, Remark 1.

**Description**: Appendix C has six subsections with full derivations but no proposition or formal result. The non-monotonic relationship between proposal bias and the R1 jump is a publishable micro-result that deserves formal statement. Even something as simple as "The R1 jump $J(p_H) = (1-\mu_s)(1-p_H)p_H\beta(r-1)$ is maximized at $p_H^* = 1/2$ when $\mu_s$ is constant in $p_H$" would add value.

**Severity**: Minor
**Deduction**: -1 (effort without formal payoff)
**Action**: REESCREVER -- upgrade Remark 1 to a proposition

---

### V9-NEW. Proposition 4 jump formula does not account for the non-proposer channel (POTENTIAL ERROR)

**Location**: Proposition 4, equation (8).

**Description**: Proposition 4 states: "Jump $= (1-\mu_s^{R1}) \cdot (N-1)\beta(r-1)/N^2 > 0$." The proof says: "Below $\mu_s^{R1}$, type $\theta=0$ receives $\beta(1+x)/N$ when $W$ proposes (aggressive: accepted at reservation). Above $\mu_s^{R1}$, type $\theta=0$ receives $\beta(r+x)/N$ (conservative: overpaid). The difference is $\beta(r-1)/N$, weighted by prob $(N-1)/N$ of $W$ proposing and by $(1-\mu_s^{R1})$ for the probability that $\theta=0$."

This derivation accounts for the change in H's payoff from the *proposing* W's offer to H. But switching from aggressive to conservative also changes the *non-proposer* W's payoff, which affects $V_W^{R2}$, which affects H's payoff when H proposes. Specifically, when R1 switches from aggressive to conservative:

- The non-proposer's payoff changes because the deal now always passes (no rejection by type 1).
- H's proposal payoff changes because $V_W^{R2}(\mu)$ does not change at the R1 cutoff (it depends on $\mu$ vs $\mu_s^{R2}$, not on R1 regime).

Wait -- actually $V_W^{R2}(\mu)$ does NOT change at $\mu_s^{R1}$. It only changes at $\mu_s^{R2}$. And $H\_prop\_\theta = (V(\theta) - (N-1)\beta V_W^{R2}(\mu))/N$ does not depend on the R1 regime. So H's payoff when H proposes is continuous at $\mu_s^{R1}$.

The jump comes exclusively from the W-proposes channel. When W proposes:
- Aggressive: type 0 gets $\beta(1+x)/N$. Type 1 gets $\beta(r+x)/N$ (via R2 after rejection).
- Conservative: type 0 gets $\beta(r+x)/N$. Type 1 gets $\beta(r+x)/N$ (accepts in R1).

So the jump for type 0 is $(N-1)/N \cdot [\beta(r+x)/N - \beta(1+x)/N] = (N-1)\beta(r-1)/N^2$.
The jump for type 1 is $(N-1)/N \cdot [\beta(r+x)/N - \beta(r+x)/N] = 0$.

Expected jump: $(1-\mu)\cdot(N-1)\beta(r-1)/N^2 + \mu \cdot 0 = (1-\mu_s^{R1})(N-1)\beta(r-1)/N^2$. This matches equation (8).

But I need to also check that the non-proposer payoff discontinuity does not affect H's payoff indirectly. The non-proposer's R1 payoff changes at $\mu_s^{R1}$ because on the aggressive branch, when another W proposes and type 1 rejects, the non-proposer goes to R2. On the conservative branch, the deal always passes. But this affects $V_W^{R1}$, not $V_H^{R1}$ directly. $V_H^{R1}$ depends on H's payoff when H proposes (continuous at $\mu_s^{R1}$) and H's payoff when W proposes (which has the jump above). So the formula is correct.

**Verdict: No error.** The formula is correct upon verification. Removing this from the vulnerability list.

---

## Part 4: Standard Quality Gates Checks

### Notation consistency

- $V_e(\mu) = 1 + \mu(r-1)$: used consistently throughout.
- $x = (N-1)\alpha r$: defined once in Section 4 and used consistently.
- $q = \lfloor N/2 \rfloor + 1$: used consistently for majority threshold.
- $\lambda_M$: defined in Section 8, used in Theorem 1 proof. Consistent.
- $S_U, S_M$: defined in Section 8, used in Theorem 1. Consistent.

No notation inconsistencies detected.

### Cross-references

- All proposition/lemma/theorem labels used in the body appear to have corresponding `\label{}` commands.
- The appendix references (A.1--A.6, B.1--B.6, C.1--C.6) are structured consistently.
- The `\@ref(fig:bp-illustration)` and `\@ref(fig:parameter-regions)` references should render correctly in bookdown.

### Citation check

All `@key` citations in the text have corresponding entries in `references.bib`. Specifically verified:
- `@bardhiguo2018` (present)
- `@feddersen1998convicting` (present)
- `@diermeier1999bicameralism` (present)
- `@crawford1982strategic` (present)
- `@fearon1995rationalist` (present)

No broken citations detected.

### R code review

The R functions `VH_R1_unanimity`, `VH_R1_majority`, `VW_R1_unanimity`, `VW_R1_majority` are internally consistent with the model's equations. The `concavify()` function uses a gift-wrapping algorithm that is correct for computing upper concave envelopes on discrete grids. The parameter region computation in Figure 2 correctly restricts to $\alpha < \alpha^*$ and $\alpha < 1/r$.

---

## Score Calculation

Starting at 100:

| # | Severity | Vulnerability | Deduction | Running total |
|---|----------|---------------|-----------|---------------|
| V1-NEW | Major | K-type claim "richer not weaker" unverified | -5 | 95 |
| V2-NEW | Moderate | $p^*$ denominator positivity not stated explicitly | -2 | 93 |
| V3-NEW | Minor | Worked Example lacks formula for replication | -1 | 92 |
| V4-NEW | Moderate | Dynamic framing not supported by static model | -2 | 90 |
| V5-NEW | Moderate | $\tau(U)$ purely numerical, could be semi-analytical | -2 | 88 |
| V6-NEW | Minor | Budget identity chain compressed | -1 | 87 |
| V7-NEW | Minor | Figure 1 single parameter set, no sensitivity | -1 | 86 |
| V8-NEW | Minor | Extension Appendix C has no proposition | -1 | 85 |

**Raw score: 85/100**

---

## Verdict

**APROVADO COM RECOMENDACOES [85/100]**

The manuscript has improved dramatically across the three rounds of review. The score progression is:

| Round | Score | Verdict |
|-------|-------|---------|
| Round 1 | 45 | BLOCK |
| Round 2 | 62 | BLOCK |
| Round 3 | 85 | PASS |

### What changed

The single most important improvement is the **analytical proof of Lemma 1** (D_base decomposition). Round 2's blocking issue -- that the paper's central result rested on numerical verification -- is now fully resolved. The proof is rigorous, with a clean three-region assembly that I verified algebraically. Combined with the new Theorem 1 (four well-defined cases, single-crossing property, closed-form $p^*$), the paper's formal apparatus is now solid.

The contextualization improvements are also substantial: the BP commitment discussion, the entry cost interpretation, the missing literature (F&P, D&M, B&G), the discriminating WTO observable implication, and the $\alpha^*$ characterization for representative $N$ values all bring the manuscript to a level appropriate for circulation.

### Remaining issues (none blocking)

1. **V1-NEW (K-type claim)**: Weaken to a conjecture or prove for K=3. This is the only remaining major issue, and it is confined to one sentence in the conclusion.
2. **V2-NEW ($p^*$ denominator)**: Add one sentence to the proof.
3. **V4-NEW (dynamic framing)**: Add a caveat that dynamic implications are suggestive.
4. **V5-NEW ($\tau(U)$ characterization)**: Either provide piecewise closed form or explain unavailability.
5. **V3, V6, V7, V8 (minor)**: Presentational improvements, can be deferred to journal R&R.

### Recommendation

The manuscript is ready for circulation and seminar presentation. The core results (Lemma 1, Theorem 1, Propositions 1--5) are correctly proved. The institutional comparison is clean and well-motivated. The contextualization is adequate for a theory paper. Before formal submission to a top journal (IO, AJPS, JoP), the five items above should be addressed -- none requires fundamental changes.

### Progress summary

| Dimension | R1 | R2 | R3 | Delta R2-R3 |
|-----------|-----|-----|-----|-------------|
| Central result (Theorem 1) | Unproved | Better structure, Lemma 1 gap | 4 cases, rigorous proof | +20 |
| Lemma 1 proof | Empty | Decomposed but numerical | Fully analytical | +20 |
| Contextualization | Absent | Partial | Adequate | +10 |
| Literature | Gaps | Still gaps | Fixed | +5 |
| BP commitment | Not discussed | Mentioned | Full paragraph | +3 |
| GATT/WTO | Window-dressing | Better but not discriminating | Discriminating OI added | +5 |
| Overall | 45 | 62 | 85 | +23 |
