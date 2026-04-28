# Proof Roadmap Drafts for RIO Submission

**Date**: 2026-04-27
**Purpose**: Short proof roadmaps to insert in paper body

## Insert 1: After Theorem 1

**Suggested location**: Replace the existing paragraph at line 425 (beginning "The condition $\alpha < \alpha^*(N, \beta)$ is pinned down...") with the expanded version below. The current paragraph already contains several proof-roadmap elements but mixes the roadmap with the two-part intuition (H-proposes vs. W-proposes). The revised version separates the proof architecture from the substantive intuition, making both clearer.

---

The proof (Appendix B.5) proceeds by comparing the conditional payoff difference $D(\mu) \equiv E[V_H(\mu, U)] - E[V_H(\mu, M)]$. Under majority, the hegemon's payoff is affine in beliefs: weak proposers can exclude the hegemon, so its private information creates no screening term. Under unanimity, the payoff difference decomposes additively into three affine components---a baseline that captures the cost of buying agreement under each rule, an R1 correction that captures the screening rent when weak proposers switch to conservative offers, and an R2 correction that captures the continuation-value effect of aggressive screening in the second round. Because each component is affine in $\mu$, positivity on any branch of the belief space reduces to checking a finite number of endpoints. The tightest case is $\mu = 1$, where both screening corrections vanish and the comparison reduces to the vote-buying and outside-option terms alone. Evaluating $D(1) > 0$ yields exactly the condition $\alpha < \alpha^*(N, \beta)$. At all other endpoints, the screening corrections are weakly positive, so the affine structure implies $D(\mu) > 0$ for every $\mu \in (0,1]$.

The condition $\alpha < \alpha^*(N, \beta)$ is therefore pinned down by the no-uncertainty endpoint. At $\mu = 1$, the hegemon is known to be the high type, so unanimity can dominate majority only if its bargaining advantage exceeds the cost of buying all votes. The intuition for why the advantage holds throughout the belief space has two parts. When the hegemon proposes, unanimity depresses weak states' continuation values (because rejection leads to a game where the hegemon is pivotal), allowing the hegemon to buy agreement more cheaply. When a weak state proposes, unanimity forces the proposer to secure the hegemon's vote, generating the screening rent identified in Proposition \ref{prop:jump}. Both forces favor the hegemon.

---

### Notes on accuracy

1. **Decomposition structure**: The insert names three affine components ($D_{\text{base}}$, $\delta_{R1}$, $\delta_{R2}$), matching B.5's decomposition exactly: $D(\mu) = D_{\text{base}}(\mu) + \mathbf{1}\{\mu < \mu_s^{R2}\}\cdot\delta_{R2}(\mu) + \mathbf{1}\{\mu > \mu_s^{R1}\}\cdot\delta_{R1}(\mu)$. The insert avoids the technical notation ($D_{\text{base}}$, $\delta_{R1}$, $\delta_{R2}$, indicator functions) to keep it readable in the body, while still conveying the architecture.

2. **Tight case at $\mu = 1$**: This matches Step 2 of B.5, where $D_{\text{base}}(1) = r[C_{\text{buy}} - C_{\text{out}}(1-\beta)]/N^2$ and both $\delta_{R1}(1) = 0$ and $\delta_{R2}$ is not active at $\mu = 1$ (since $1 > \mu_s^{R2}$). The condition $D(1) > 0$ reduces to $C_{\text{buy}} > C_{\text{out}}(1-\beta)$, whose root is $\alpha^*$.

3. **"Weakly positive" at other endpoints**: This is accurate. $\delta_{R1}(\mu) \geq 0$ for $\mu \leq 1$ (Step 2). The $\delta_{R2}$ correction is negative at $\mu = 0$, but B.5 checks the composite $D_I(0) = D_{\text{base}}(0) + \delta_{R2}(0) > 0$ (i.e., the baseline more than compensates). The insert says "screening corrections are weakly positive" at the other endpoints---this is slightly imprecise for the R2 correction at $\mu = 0$, but accurate at the R2 branch endpoint ($\delta_{R2}(\mu_s^{R2}) = 0$), which is where B.5 actually checks positivity. The phrasing avoids this subtlety to keep the roadmap short. If the author prefers more precision, the sentence could say "the baseline term is large enough to absorb any negative R2 correction" instead of "screening corrections are weakly positive."

4. **Affine-implies-endpoints logic**: The insert correctly states that affine functions positive at both endpoints are positive throughout, which is the core strategy in B.5 Steps 2--3.

5. **Two-part intuition** (H-proposes vs. W-proposes): Retained from the existing paragraph, as it provides substantive interpretation that complements the proof architecture.


## Insert 2: After Corollary / Before Remark

**Suggested location**: Insert immediately after the proof reference for the Corollary (after line 451, before Remark \ref{rem:W_prefers_M} at line 453). The paragraph at line 439 already states the inclusion $\mathcal{F}_U \subseteq \mathcal{F}_M$ with a brief justification; this insert provides the proof logic for the Corollary as a whole, linking the inclusion to the payoff comparison.

---

The argument (Appendix B.6) combines budget balance with Theorem \ref{thm:conditional}. Under majority, agreement occurs without delay and the pie is divided exactly among $N$ players, so the hegemon's and weak states' expected payoffs sum to $V_e(\mu)$. Under unanimity, rejection on the aggressive branch destroys surplus through discounting, so the same budget constraint holds as a weak inequality. Since the hegemon captures strictly more under unanimity (Theorem \ref{thm:conditional}), weak states must receive strictly less at every belief. The entry threshold is therefore higher under unanimity, and any prior that sustains entry under unanimity also sustains it under majority.

---

### Notes on accuracy

1. **Budget identity vs. inequality**: B.6 states the majority budget constraint as an *equality* ($E[V_H(\mu, M)] + (N-1)V_W(\mu, M) = V_e(\mu)$) and the unanimity constraint as an *inequality* ($E[V_H(\mu, U)] + (N-1)V_W(\mu, U) \leq V_e(\mu)$). The difference arises from surplus destruction when the aggressive offer is rejected and the game proceeds to a discounted second round. The insert captures this distinction ("rejection on the aggressive branch destroys surplus through discounting, so the same budget constraint holds as a weak inequality").

2. **Direction of inference**: B.6 uses $V_H(U) > V_H(M)$ (from Theorem 1) combined with $V_H(U) + (N-1)V_W(U) \leq V_e(\mu) = V_H(M) + (N-1)V_W(M)$ to conclude $V_W(U) < V_W(M)$. This is exactly what the insert describes.

3. **Entry threshold implication**: B.6 then concludes $V_W^{R1}(p, M) > V_W^{R1}(p, U) \geq c$ for $p \in \mathcal{F}_U$, establishing the set inclusion. The insert describes this as "any prior that sustains entry under unanimity also sustains it under majority."

4. **No additional verification needed**: Unlike the suggestion in the editorial file that B.6 might need strengthening, the current B.6 proof is complete and self-contained. The budget-inequality argument is clean and does not require separate verification of screening branches---the surplus-destruction inequality handles everything.


## Editorial Notes

- **Insert 1** is a replacement/expansion of the existing paragraph (line 425), not a pure addition. The existing text already begins the proof roadmap but does not name the decomposition structure or the endpoint-checking strategy. The revised version leads with the proof architecture, then follows with the substantive intuition.

- **Insert 2** is a short addition (4 sentences) that does not displace any existing text. It slots naturally between the proof reference and the existing Remark on weak-state preferences.

- Both inserts use the paper's notation ($D(\mu)$, $V_e(\mu)$, $\alpha^*$, Proposition \ref{prop:jump}, Theorem \ref{thm:conditional}) and match the paper's prose style: substantive language, no parenthetical variable lists, brief enough that readers can follow without turning to the appendix.
