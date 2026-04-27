# CR8: Communication of Screening vs. BP — Evaluation and Proposal

**Date**: 2026-04-26  
**Reviewer**: Claude Opus 4.6 (senior academic editor, political science methodologist)  
**Files reviewed**:
- `formal_model_v4.Rmd` (lines 393–421, 497–566, 675–710, 793–801)
- `notes/2026-04-26_CR8_decomposition_v2.md` (decomposition analysis + verification)
- `notes/2026-04-26_bp_amplification_figure.md` (proposed heatmap)

---

## 1. Evaluation of the Current Paper

### 1.1 What the paper currently communicates

The paper makes three key claims about how screening and BP relate:

1. **Line 421 (key paragraph after Prop 3)**: "The distinctive contribution of Bayesian persuasion under unanimity is not to create the conditional payoff advantage---that comes from screening (Lemma 1)---but to amplify it by exploiting this non-convexity and to extend it to priors below the entry threshold, where the institution would not otherwise form."

2. **Line 538 (after Theorem 1)**: "The screening mechanism gives the hegemon a higher conditional payoff, and majority's linearity means that concavification cannot close the gap. The only channel through which majority can dominate is the entry margin."

3. **Line 558 (after Theorem 2)**: "At sufficiently high priors, unanimity dominates because the screening mechanism gives the hegemon a conditional payoff advantage. At pessimistic priors, majority can dominate---but only through the entry margin, never through a higher conditional payoff."

4. **Conclusion (line 795)**: "Unanimity forces weak states to include the hegemon under uncertainty, creating a screening cutoff that gives the hegemon a conditional payoff advantage at every level of uncertainty. Bayesian persuasion extends this advantage to priors where the institution would not otherwise form."

### 1.2 What is well communicated

- The paper correctly identifies that screening creates the conditional payoff advantage and BP extends it. The sentence at line 421 is the clearest statement of this.
- The "only through the entry margin" framing (lines 538, 558) is precise and memorable.
- The conclusion (line 795) neatly separates the two roles: screening creates, BP extends.
- Example 1 (motivating example, lines 63–80) gives clear intuition for the screening jump and how BP exploits the resulting non-convexity.

### 1.3 What is missing or unclear

**Problem 1: No explicit decomposition.** The paper describes BP's role qualitatively ("amplify," "extend") but never decomposes the unanimity advantage into screening and BP components quantitatively. A reader who wants to understand *how much* of the advantage comes from screening vs. BP has no answer. This is a significant gap because:
- The decomposition identity `cav v(p,U) - cav v(p,M) = D(p) + [cav v(p,U) - v(p,U)]` is a tautology that requires no new machinery, yet it cleanly separates the two forces.
- In Example 2 (the paper's main worked example), BP amplification is *zero* on the entry set. The entire advantage for p in E_U is pure screening. This is a striking fact that the paper never states.

**Problem 2: The "amplification" framing is potentially misleading in Example 2.** The paragraph at line 421 says BP "amplifies" the screening advantage by "exploiting this non-convexity." But in Example 2 (the paper's own worked example), the screening jump lies *below* the unanimity entry threshold (mu_s^R1 approx 0.197 < tau(U) approx 0.33). The net-gain function v(mu, U) is affine on E_U, so BP amplification is identically zero there. The paper never tells the reader this. A reader who follows from line 421 to Example 2 could reasonably believe that the screening non-convexity at mu_s^R1 is being exploited by BP in the example --- but it is not. BP operates in Example 2 only through the entry channel (extending the screening advantage to priors below tau(U)), not through the amplification channel.

**Problem 3: No distinction between the two roles of BP.** The paper currently treats BP as a single force. But BP does two conceptually distinct things:

- **BP amplification** (within E_U): exploits the screening non-convexity at mu_s^R1 to raise payoffs at beliefs where entry already occurs. This requires mu_s^R1 to fall inside E_U, which depends on entry costs. When c is low, mu_s^R1 > tau(U) and amplification is positive. When c is high (as in Example 2), mu_s^R1 < tau(U) and amplification is zero on E_U.

- **BP extension** (below E_U): induces entry at beliefs where the institution would not otherwise form under unanimity, by designing signals that push posteriors into E_U. This operates regardless of whether mu_s^R1 is inside E_U.

The paragraph at line 421 mentions both roles ("amplify" and "extend") in a single sentence but does not distinguish when each is operative.

**Problem 4: The role of entry costs is underdeveloped.** The paper says tau(U) >= tau(M) and discusses the entry margin extensively, but never connects entry costs to the *composition* of the unanimity advantage. A reader does not learn that:
- Low c: both amplification and extension channels are active.
- High c: the screening jump falls outside E_U; only the extension channel operates; the entire advantage within E_U is pure screening.
- Very high c: entry fails entirely under unanimity and majority dominates everywhere.

This comparative static on c is clean and substantively important: it shows that BP's contribution is not uniform but depends on institutional participation costs.

**Problem 5: Non-monotonicity in r is absent.** The verification notes document that higher r increases the screening jump magnitude but also raises tau(U) via the outside option alpha*r, potentially pushing the jump outside E_U. This "double-edged sword" comparative static is absent from the paper. It belongs naturally in the Scope section or in the paragraph following Theorem 2.

### 1.4 Grade of current communication

**Grade: B+**

The paper correctly identifies screening as the source of the conditional advantage and BP as an extender/amplifier. The qualitative framing is right. But:
- The reader cannot distinguish when BP amplification is zero vs. positive.
- Example 2 illustrates an instance where BP amplification is zero on E_U, but the paper never says so, leaving a gap between the "amplification" framing of line 421 and the actual mechanism at work.
- No quantitative decomposition is provided, even though it is trivial.
- The role of entry costs in determining the composition of the advantage is not discussed.

A careful reader who works through Example 2 with the formulas would discover that v(mu, U) is affine on E_U and conclude that "amplification" means something different from what line 421 suggests. This is not wrong---but it risks confusion, which is a B-level issue.

---

## 2. Proposed Text

### 2.1 Strategy

I propose three interventions:

1. **A new Remark after Example 2** (around line 566): a formal decomposition remark that separates screening from BP amplification and notes when each is operative. This is the main addition.

2. **A one-sentence addition to Example 2** (around line 563): noting that BP amplification is zero on E_U for this example, so the entire advantage there is pure screening.

3. **A short paragraph in Scope** (around line 701): the non-monotonicity in r and the role of entry costs in determining the composition of the advantage.

No changes to line 421 are needed --- the "amplify...and extend" framing is correct, and the Remark will disambiguate.

### 2.2 Addition to Example 2

Insert at the end of the current second paragraph of Example 2 (after "Lemma 1"), before the third paragraph beginning "The transition is sharp":

> In this example, the screening cutoff $\mu_s^{R1} \approx 0.20$ lies below the unanimity entry threshold $\tau(U) \approx 0.33$. The net-gain function $v(\cdot, U)$ is therefore affine on the entry set, and Bayesian persuasion adds nothing to the hegemon's payoff at beliefs where the institution forms: the entire advantage within $E_U$ is the screening payoff difference $D(\mu)$ from Lemma~\ref{lem:conditional}. Bayesian persuasion contributes only through the entry channel, inducing participation under unanimity at priors below $\tau(U)$. The screening structure is the source of the gain; persuasion is the delivery mechanism that carries it to lower priors.

### 2.3 New Remark after Example 2

Insert after the closing `\end{example}` of Example 2 (after line 566), before "## Numerical characterization":

```latex
\begin{remark}[Decomposition of the unanimity advantage]\label{rem:decomposition}
For any prior $p$ at which entry occurs under both rules ($p \in E_U$), the unanimity advantage decomposes as
\[
\operatorname{cav} v(p, U) - \operatorname{cav} v(p, M) = \underbrace{v(p, U) - v(p, M)}_{\text{screening advantage } D(p)} + \underbrace{\operatorname{cav} v(p, U) - v(p, U)}_{\text{BP amplification}}.
\]
The first term is the conditional payoff difference from Lemma~\ref{lem:conditional}: the hegemon earns more under unanimity at every belief, even without any information design. The second term is the additional gain from optimal persuasion, which is non-negative by construction.

The relative weight of the two components depends on whether the screening cutoff $\mu_s^{R1}$ lies inside the entry set $E_U$. When entry costs are high enough that $\tau(U) > \mu_s^{R1}$, the function $v(\cdot, U)$ is affine on $E_U$ (the entire entry set lies on the conservative branch), so the BP amplification term is zero: the full advantage is the screening payoff difference $D(p)$. This is the case in Example~\ref{ex:p_star}. When entry costs are low enough that $\tau(U) < \mu_s^{R1}$, the screening jump at $\mu_s^{R1}$ falls inside the entry set, creating a non-convexity that persuasion exploits: the BP amplification term is strictly positive near the jump.

For priors below $\tau(U)$, entry does not occur without persuasion under unanimity. The hegemon uses information design to induce participation by splitting the prior into posteriors at which entry occurs and posteriors at which it does not. In this region, the screening structure generates the gain---it is what makes the posteriors inside $E_U$ valuable---and Bayesian persuasion delivers it by making entry feasible at priors where it otherwise would not be.
\end{remark}
```

### 2.4 Addition to Scope section

Insert after the paragraph ending "...clean separation between the conditional and entry channels" (after line 705), before the paragraph beginning "Figure \@ref(fig:heatmap-alpha-mu)":

> **Composition of the unanimity advantage.** The decomposition in Remark~\ref{rem:decomposition} highlights that entry costs determine not only whether unanimity dominates, but *how*. When entry costs are low, the screening jump at $\mu_s^{R1}$ falls inside the entry set, and persuasion amplifies the screening advantage by exploiting the resulting non-convexity in $v(\cdot, U)$. When entry costs are high, the screening jump lies below the entry threshold, and persuasion operates only through the entry channel. The value of cooperation plays a dual role: higher $r$ increases the magnitude of the screening jump (more separates the types), but also raises the hegemon's outside option $\alpha r$, making entry harder under unanimity. This can push the screening jump below the entry threshold, eliminating the amplification channel even as the screening advantage itself grows. The interplay between participation costs and screening value generates rich comparative statics within the unanimity-dominant region identified by Theorem~\ref{thm:crossing}.

---

## 3. Figure Recommendation

### 3.1 Evaluation of the proposed 3-panel heatmap (r vs. beta, varying c)

**Against inclusion in the paper:**

1. **Too technical for JoP body.** The heatmap requires the reader to understand mu_s^R1 vs. tau(U), the concept of "BP amplification" as a separable quantity, and the interaction between r, beta, and c. This is specialist material.

2. **Marginal insight over existing figures.** The paper already has: (a) Figure 1 (game tree), (b) Figure 2 (screening schematic with jump), (c) Figure 3 (net-gain functions and concavifications), (d) Figure 4 (parameter regions), (e) Figure 5 (heatmap alpha vs. mu). The 3-panel heatmap would be Figure 6. For a JoP paper, this is already figure-heavy, and the new figure's main message --- "entry costs determine whether BP amplification is positive" --- can be communicated in prose.

3. **The non-monotonicity in r is better communicated verbally.** A sentence in Scope ("higher r increases the screening jump but also raises the entry threshold") is more accessible than a color map.

**If any figure is warranted:**

A single-panel line plot would be cleaner and more targeted:
- x-axis: entry cost c (from 0 to the level where unanimity becomes unviable)
- y-axis: share of unanimity advantage attributable to BP amplification (= [cav v(p,U) - v(p,U)] / [cav v(p,U) - cav v(p,M)]) at a fixed prior p in E_U
- Fixed parameters: N=5, r=1.5, alpha=0.3, beta=0.9
- The plot would show a curve that starts at some positive share (when c is low and the jump is inside E_U) and drops to zero at the c where tau(U) = mu_s^R1, then stays at zero.

However, even this figure may be redundant given the prose in the Remark and Scope addition. The key message is cleanly stated verbally: "When entry costs are high enough that the screening jump falls below the entry threshold, BP amplification is zero on E_U."

**Recommendation:** Do not include the 3-panel heatmap. Do not include any new figure. The Remark and Scope paragraph are sufficient. If the referee asks for a quantitative illustration, the line plot described above can be added in revision.

---

## 4. Grade of the Proposal

### Self-assessment

The proposed text:

1. **Decomposes the advantage explicitly** (Remark): a tautological identity that is easy to verify and carries no new assumptions. Grade: A+.

2. **Distinguishes when BP amplification is zero vs. positive**: the condition (tau(U) > mu_s^R1 vs. tau(U) < mu_s^R1) is stated clearly, linked to entry costs, and illustrated by Example 2. Grade: A+.

3. **Explains BP's role below tau(U)**: "the screening structure generates the gain; persuasion delivers it." This is the right framing --- it respects the primacy of screening as the source of the advantage. Grade: A+.

4. **Non-monotonicity in r**: communicated in a single sentence in Scope, connected to the "dual role" of r (type separation vs. outside option). Grade: A.

5. **JoP style compliance**: the Remark has one equation (the decomposition identity) and the rest is prose. The Scope paragraph has no equations. The addition to Example 2 has no equations. Grade: A+.

6. **No words "visible" or "invisible"**: confirmed --- replaced with "lies inside/below the entry set." Grade: A+.

### Potential weaknesses

- The Remark introduces the notation D(p) for the screening advantage, which is already used in the paper (line 508 and Remark 1). Consistent. No issue.
- The Remark references E_U, which is defined in Theorem 1 (line 524). The Remark follows Theorem 2, so the reader has encountered E_U. No issue.
- The Remark does not provide numerical values for the decomposition at specific beliefs. This is deliberate: Example 2 already gives percentages (29% at p=0.30, 25% at p=0.50), and the addition to Example 2 notes that the entire advantage on E_U is screening. Adding numbers to the Remark would be redundant.
- The Scope paragraph mentions "higher r increases the magnitude of the screening jump" without proof. This is a comparative static that follows from the definition of mu_s^R1 (the aggressive/conservative cutoff), but a reader might want a reference. Adding "(Proposition 2)" after "screening jump" would suffice.

### Final grade of proposal

**Grade: A**

The proposal achieves A+ on decomposition clarity, BP vs. screening distinction, and style. It falls short of A+ on one dimension: it does not give a worked numerical example of the case where BP amplification *is* positive (contrasting with Example 2 where it is zero). A brief mention --- e.g., "With lower entry costs (c = 0.05), the screening jump enters the entry set and BP amplification accounts for approximately 15% of the advantage at the screening cutoff" --- would complete the picture. However, this would require running the R code to get the exact number, which should be verified computationally before inclusion.

### Recommendation for achieving A+

Add one sentence to the Scope paragraph:

> For instance, reducing entry costs in Example~\ref{ex:p_star} from $c = 0.14$ to $c = 0.05$ pulls the entry threshold below $\mu_s^{R1}$, bringing the screening jump inside the entry set and activating the amplification channel.

This requires no new computation (it follows from the verification report: at c=0.05, tau(U) < 0 < mu_s^R1 = 0.197) and gives the reader a concrete anchor for the low-c case.

---

## 5. Summary of Recommended Changes

| Location | Change | Priority |
|----------|--------|----------|
| Example 2 (line 563, after "Lemma 1") | Insert 4 sentences noting BP amplification = 0 on E_U | HIGH |
| After Example 2 (line 566) | Insert Remark on decomposition | HIGH |
| Scope (after line 705) | Insert paragraph on entry costs, r non-monotonicity | MEDIUM |
| Scope (new paragraph) | Add one-sentence low-c illustration | LOW (achieves A+) |
| No new figure | 3-panel heatmap not recommended | — |

### Note on p* value

The decomposition analysis (CR8_decomposition_v2.md, Section 7) identified that p* = 0.24 was incorrect in a prior version of Example 2. The current paper text (line 563) already reads "p* approx 0.12," so this has been corrected. The 29% advantage at p=0.30 and 25% at p=0.50 are consistent with the corrected value (verified analytically in the decomposition report, Section 7).
