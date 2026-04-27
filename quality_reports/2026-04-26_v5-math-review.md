# Mathematical Review: formal_model_v5.Rmd (post-BP-removal)

**Date**: 2026-04-26
**Reviewer**: Fresh mathematical reviewer (Claude)
**File**: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v5.Rmd`

---

## Item 1: Theorem 1 Statement (Conditional Payoff Dominance)

**Verdict: PASS**

**Location**: Lines 411--416 (`\begin{theorem}[Conditional payoff dominance of unanimity]\label{thm:conditional}`)

The biconditional is correctly stated:

> $\alpha < \alpha^*(N, \beta)$ if and only if, for every $\mu \in (0,1]$, $E_\theta[V_H^{R1}(\theta, \mu, U)] > E_\theta[V_H^{R1}(\theta, \mu, M)]$.

The threshold $\alpha^*$ is defined at line 407 (eq. \ref{eq:alpha_star}):
$$\alpha^*(N, \beta) \equiv \frac{\beta(q-1)}{N(N-1) - \beta(N^2 - N - q + 1)}, \qquad q = \lfloor N/2 \rfloor + 1.$$

**Match with proof (Appendix B.5, lines 934--989)**:
- Sufficiency (Steps 1--3): The proof decomposes $D(\mu) = D_{\text{base}} + \mathbf{1}\{\mu < \mu_s^{R2}\}\delta_{R2} + \mathbf{1}\{\mu > \mu_s^{R1}\}\delta_{R1}$, shows each component is affine, and checks positivity at endpoints. The key binding constraint is $D_{\text{base}}(1) > 0$, which holds iff $\alpha < \alpha^*$. Verified: $D_{\text{base}}(1) = r[C_{\text{buy}} - C_{\text{out}}(1-\beta)]/N^2$, and setting $C_{\text{buy}} = C_{\text{out}}(1-\beta)$ yields $\alpha^*$. The low-endpoint check $D_I(0) > 0$ is handled correctly by showing $\bar\alpha_0 > \alpha^*$.
- Necessity (Step 4): At $\mu = 1$, both corrections vanish, so $D(1) = D_{\text{base}}(1)$. For $\alpha \geq \alpha^*$, $D(1) \leq 0$. Correct.
- The derivation in B.5a (lines 842--931) is algebraically verified. The additivity argument (corrections affect disjoint payoff components) is sound.

**No issues found.**

---

## Item 2: Corollary Statement and Proof (Unanimity Dominance on the Entry Set)

**Verdict: PASS (with one minor imprecision)**

**Location**: Lines 438--448 (`\begin{corollary}[Unanimity dominance on the entry set]\label{cor:dominance}`)

### 2a. Does B.6 correctly establish $E_U \subseteq E_M$?

**Yes.** The proof (lines 991--995) uses:
1. Under majority: $E[V_H(\mu, M)] + (N-1)V_W(\mu, M) = V_e(\mu)$ (exact budget identity; verified in A.6, line 804).
2. Under unanimity: $E[V_H(\mu, U)] + (N-1)V_W(\mu, U) \leq V_e(\mu)$ (surplus destruction from discounting on aggressive branch; verified in A.6).
3. Theorem 1 gives $E[V_H(\mu, U)] > E[V_H(\mu, M)]$ for all $\mu \in (0,1]$.

From (1) and (2): $(N-1)V_W(\mu, U) \leq V_e(\mu) - E[V_H(\mu, U)] < V_e(\mu) - E[V_H(\mu, M)] = (N-1)V_W(\mu, M)$. Hence $V_W(\mu, U) < V_W(\mu, M)$.

**Note:** The inequality chain uses (2) as weak inequality and (3) as strict inequality, which is valid. However, the argument implicitly assumes that on the conservative branch (where the budget identity holds as equality), the strict inequality in Theorem 1 still gives $V_W(\mu, U) < V_W(\mu, M)$. This works because Theorem 1 gives strict inequality at every $\mu \in (0,1]$, and on the conservative branch $E[V_H] + (N-1)V_W = V_e(\mu)$ holds exactly, so $V_W(\mu, U) = [V_e(\mu) - E[V_H(\mu, U)]]/(N-1) < [V_e(\mu) - E[V_H(\mu, M)]]/(N-1) = V_W(\mu, M)$. On the aggressive branch, the weak inequality makes the argument even stronger. The proof is correct.

### 2b. Is "weak states' aggregate payoff is weakly lower under U when H's payoff is higher" correct?

**Yes**, via the budget identity. The budget identity under majority is exact (zero surplus destruction). Under unanimity it holds with inequality (weak). Combined with Theorem 1's strict inequality for H, this forces V_W(U) < V_W(M) strictly.

### 2c. Does V_H(U,p) > V_H(M,p) follow?

**Yes.** Since $p \in E_U$, the institution forms under both rules (because $E_U \subseteq E_M$). Both payoffs are the expected bargaining payoffs, and Theorem 1 applies directly.

**Minor imprecision (non-blocking):** The proof at line 993 writes the budget identities using $E[V_H(\mu, R)]$ notation but switches to $V_W(\mu, R)$ without subscript, which could momentarily confuse whether $V_W$ is per-weak-state or aggregate. Context makes it clear it is per-weak-state (since the $(N-1)$ multiplier is explicit), but adding "per weak state" once would help.

---

## Item 3: Proposition Statement and Proof (Institutional Classification)

**Verdict: PASS (with one minor note on Case ii)**

**Location**: Lines 452--464 (`\begin{proposition}[Institutional classification]\label{prop:classification}`) and proof at lines 1019--1027 (B.8).

### 3a. Are the 3 cases exhaustive?

**Yes.** The three sets $E_U$, $E_M \setminus E_U$, and $(0,1] \setminus E_M$ partition $(0,1]$ because $E_U \subseteq E_M$ (Corollary). This is stated explicitly at line 1021.

### 3b. Case (ii): Is $V_H(M,p) > \alpha V_e(p)$ correct?

**Yes.** Under majority, $V_H(M,p) = \lambda_M V_e(p)$. I verified algebraically that $\lambda_M > \alpha$:

$$\lambda_M - \alpha = \frac{(1-\alpha)[N - \beta(q-1)]}{N^2} > 0$$

since $\alpha < 1$ and $N > \beta(q-1)$ (because $q - 1 < N$ and $\beta < 1$). So $V_H(M,p) = \lambda_M V_e(p) > \alpha V_e(p) = V_H(U,p)$.

**Note on the proof text (line 1025):** The proof says $V_H(M,p) > \alpha V_e(p)$ "since entry is individually rational for weak states (which requires positive surplus above outside options)." This justification is imprecise -- the result follows directly from $\lambda_M > \alpha$, which is an algebraic fact about the bargaining game, not directly from the entry condition. The entry condition is only needed to establish that the institution forms. The conclusion is correct; the justification is slightly misleading but not wrong (entry being rational does require positive surplus, which does imply $\lambda_M > \alpha$).

### 3c. Case (iii): Is the logic correct?

**Yes.** If $p \notin E_M$, then $p \notin E_U$ (since $E_U \subseteq E_M$). Neither institution forms. Both payoffs equal $\alpha V_e(p)$. $U \sim M$. Correct.

---

## Item 4: Remark (Information Design)

**Verdict: PASS**

**Location**: Lines 468--470 (`\begin{remark}[Information design]\label{rem:info_design}`)

### 4a. Is the claim that majority's payoff is affine correct?

**Yes.** Under majority, $V_H(M, \mu) = \lambda_M V_e(\mu)$, which is affine in $\mu$ (since $V_e(\mu) = 1 + \mu(r-1)$ is affine). The concavification of an affine function is the function itself, so no Bayesian persuasion gain is possible.

### 4b. Is the claim about screening discontinuity under unanimity correct?

**Yes.** The upward jump at $\mu_s^{R1}$ (Proposition 3, line 312) creates a non-concavity in the hegemon's payoff. When entry thresholds further create a kink at the entry boundary, this generates the kind of non-concavity that information design can exploit. The remark is carefully hedged: "information design *would* matter differently" and "persuasion is not necessary for the paper's main result."

**Reference:** The remark cites "Kamenica and Gentzkow 2011" but uses an inline citation rather than `@kamenica2011` BibTeX format. This is a formatting inconsistency but not a mathematical error. Check whether this reference is in the .bib file.

---

## Item 5: Cross-References

**Verdict: PASS -- no broken references to old labels**

**Searched for:** `thm:dominance`, `thm:crossing`, `cor:global`, `prop:nonconvexity`, `lem:conditional`, `fig:bp-illustration`

**Result:** None of these old labels appear anywhere in the file.

**All \ref{} targets verified against \label{} definitions:**

| Label | Type | Defined | Referenced |
|-------|------|---------|------------|
| `def:game` | Definition | Line 84 | -- |
| `fig:gametree-a` | Figure | Line 183 | Line 116 |
| `fig:gametree-b` | Figure | Line 268 | Line 116 |
| `prop:majority` | Proposition | Line 277 | Line 268 |
| `prop:cutoff_R1` | Proposition | Line 294 | Line 100 |
| `eq:cutoff_R1` | Equation | Line 296 | Line 786 |
| `eq:alpha_bar` | Equation | Line 300 | Line 796 |
| `prop:jump` | Proposition | Line 312 | Line 422 |
| `eq:jump_R1` | Equation | Line 314 | Line 790 |
| `fig:screening-schematic` | Figure | Line 373 | -- |
| `ex:magnitudes` | Example | Line 376 | Line 473 |
| `def:netgain` | Definition | Line 387 | -- |
| `eq:alpha_star` | Equation | Line 406 | Line 721 |
| `thm:conditional` | Theorem | Line 411 | Lines 78, 80, 303, 372, 394, 422, 475, 560, 587, 591, 800, 993, 995, 1064 |
| `rem:mu_bar` | Remark | Line 426 | Line 593 |
| `cor:dominance` | Corollary | Line 438 | Lines 466, 560, 1023 |
| `prop:classification` | Proposition | Line 452 | Line 80 |
| `rem:info_design` | Remark | Line 468 | -- |
| `ex:institutional` | Example | Line 472 | -- |
| `lem:VW_max` | Lemma | Line 999 | Line 817 |
| `prop:k_majority_linear` | Proposition | Line 1054 | Lines 1032, 1062 |

**Section cross-refs** (`\@ref()`): All point to valid section labels: `model`, `example`, `comparison`, `scope`.

**No broken cross-references found.**

---

## Item 6: Residual BP Language

**Verdict: PASS**

**Searched for (case-insensitive):** `persuasion`, `concavif`, `cav `, `\Pi_H^*`, `signal structure`

**Results:**
1. Line 179: `% (Signal design node removed -- no Bayesian persuasion in v5)` -- This is an HTML/LaTeX comment. Not visible in output. **Acceptable.**
2. Line 469: "As in standard Bayesian persuasion (Kamenica and Gentzkow 2011)" -- This appears inside the Information Design remark. Per the review instructions, this is the **allowed exception**. **Acceptable.**
3. Line 112: "Perfect Bayesian Equilibrium" -- This is the solution concept name, not BP language. **Not an issue.**

No instances of `concavif`, `cav ` (with trailing space), `\Pi_H^*`, or `signal structure` found.

---

## Additional Findings (unsolicited but relevant)

### A. $(N-1)/N^2$ monotonicity claim (Line 323)

**Issue: INCORRECT claim.**

The text states: "$(N-1)/N^2$ peaks at intermediate $N$."

**Mathematical check:** Let $f(N) = (N-1)/N^2$. Then $f'(N) = (2-N)/N^3$. For $N \geq 3$ (the model's domain), $f'(N) < 0$. The function is **monotonically decreasing** on $N \geq 3$. It does not peak at intermediate $N$.

**Severity:** Minor (the qualitative interpretation is misleading but does not affect any formal result).

**Note:** This issue was already identified in the project's CLAUDE.md as CR12.

### B. Notation table: `Prop.` without number for $E_R$ (Line 729)

The entry for $E_R$ in the notation table (line 729) says "Defined in: Prop." without a number. Should reference "Prop. 4" or "Cor. 1" or "Sec. 6" as appropriate.

### C. Kamenica-Gentzkow citation format (Line 469)

The Remark on Information Design cites "Kamenica and Gentzkow 2011" in plain text rather than using `@kamenica2011bayesian` or similar BibTeX key. This will not generate a proper link in the compiled PDF. Should be checked against `references.bib`.

### D. Numbering of propositions

The paper has:
- Proposition 1 (Majority, no screening) -- `prop:majority`
- Proposition 2 (R1 cutoff) -- `prop:cutoff_R1`
- Proposition 3 (Jump) -- `prop:jump`
- Theorem 1 (Conditional dominance) -- `thm:conditional`
- Corollary 1 (Unanimity dominance on entry set) -- `cor:dominance`
- Proposition 4 (Institutional classification) -- `prop:classification`

Appendix B references: B.1 = "Proof of Proposition 1", B.2 = "Proof of Proposition 2", B.3 = "Proof of Proposition 3", B.5 = "Proof of Theorem 1", B.6 = "Proof of Corollary", B.8 = "Proof of Proposition". The B.8 heading says "Proof of Proposition (Institutional classification)" without a number. Since it is the 4th proposition in the paper, it would be Proposition 4. The heading should include the number for clarity.

### E. B.4 deleted (Line 840)

Line 840 has a comment: `<!-- B.4 (Proof of Proposition 4) deleted: Proposition 4 removed in v5. -->`. This is fine as an internal note but creates a gap in the appendix numbering (B.3 then B.5a, B.5). The B.5a label also suggests it was inserted between B.5 and B.6, which may confuse readers. Consider renumbering.

---

## Summary

| # | Item | Verdict | Issues |
|---|------|---------|--------|
| 1 | Theorem 1 statement & proof | **PASS** | None |
| 2 | Corollary statement & proof | **PASS** | Minor imprecision in per-state notation |
| 3 | Proposition statement & proof | **PASS** | Case (ii) justification imprecise but correct |
| 4 | Remark (Information design) | **PASS** | Citation format issue (non-math) |
| 5 | Cross-references | **PASS** | No broken refs to old labels |
| 6 | Residual BP language | **PASS** | Only in allowed contexts |
| A | $(N-1)/N^2$ monotonicity | **FAIL (minor)** | Claim of "peaks at intermediate N" is wrong; monotonically decreasing for N>=3 |
| B | Notation table | **MINOR** | $E_R$ missing proposition number |
| C | Citation format | **MINOR** | Inline citation in Remark should use BibTeX |
| D | Appendix heading | **MINOR** | B.8 missing proposition number |
| E | Appendix numbering gap | **MINOR** | B.4 deleted, gap in sequence |

**Overall mathematical verdict: All 6 requested items PASS.** The formal results (Theorem 1, Corollary, Proposition) are correctly stated and their proofs are sound. The one substantive error found is the monotonicity claim (Item A), which is a previously-known issue that does not affect any formal result.
