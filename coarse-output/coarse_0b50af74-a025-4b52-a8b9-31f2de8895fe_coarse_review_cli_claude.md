# Informational Power and Institutional Design: When a Hegemon May Choose Consensus

**Date**: 04/22/2026
**Domain**: social_sciences/political_science
**Taxonomy**: academic/working_paper
**Filter**: Active comments

---

## Overall Feedback

Here are some overall reactions to the document.

**Outline**

The paper proposes that a hegemon may rationally prefer unanimity over majority rule because unanimity creates a screening problem — weak states must include the hegemon without knowing its type — that generates a non-convexity in the hegemon's value function, which Bayesian persuasion exploits. The main theorem establishes a single-crossing property: a unique prior threshold separates unanimity-preferred and majority-preferred regions. The mechanism is developed cleanly in a binary-type Baron-Ferejohn model with an entry stage. My concerns center on the structural dependence of the mechanism on the discrete type space, the fragility revealed by the paper's own K>2 extension, the empirical plausibility of the Bayesian persuasion commitment assumption, and the need for sharper testable implications that exploit the closed-form threshold.

The paper identifies a genuinely novel channel linking voting rules to informational power in international organizations: unanimity creates screening, screening creates non-convexity, and non-convexity enables Bayesian persuasion. Within the binary-type baseline, the formal results are correct and well-organized, and the single-crossing theorem is a clean result with usable closed-form expressions. The paper sits at a productive intersection of legislative bargaining, information design, and IO institutional theory that no existing paper occupies in the same way.

**The mechanism lives or dies with the discreteness of the type space**

The upward jump at the screening cutoff is the paper's engine. It exists because the weak proposer faces a binary choice between exactly two offers, producing a discontinuous switch at a belief threshold. With a continuous type space, the offer schedule would generically be smooth, the value function would be concave above the entry threshold, and the concavification gain from Bayesian persuasion would vanish. The paper concedes this in the conclusion but treats it as a peripheral limitation rather than a structural vulnerability. The defense that 'states typically evaluate cooperation in terms of qualitatively distinct regimes' is asserted without evidence — many trade negotiations involve continuous variation in tariff schedules, regulatory standards, or market access provisions. A stronger approach would either demonstrate that a related non-convexity arises under continuous types through a different channel (bunching in the offer schedule, for instance, as in Dworczak and Martini 2019), or provide institutional evidence that the state space is genuinely discrete in the target applications. Without one of these, the core claim — that unanimity enables informational power — holds only for a specific class of information structures, and the paper should be more forthright about this.

**The K>2 numerical exercise raises more concerns than it resolves**

Appendix D is framed as a robustness check, but its results are mixed. Table 1 reports two parameterizations where D(mu) < 0, and the paper itself prints 'Proposition D.3 is NOT confirmed by this numerical check.' The parametric restriction tightens from alpha < alpha*(N,beta) to alpha < alpha_3*(N,beta,r1,r2) with alpha_3* strictly smaller in general. The paper explains the beta=0.7 failure as violating the backbone condition, which is technically correct but also the point: the mechanism requires increasingly strong parameter restrictions as the type space grows. For K general, one expects K-1 correction terms in the decomposition, each potentially negative, and nothing in the analysis rules out alpha_K* shrinking toward zero as K increases. The paper should either prove Proposition 8 analytically — showing exactly how alpha_3* depends on the type structure and how fast the parametric support contracts — or present a frank assessment of whether the mechanism survives empirically relevant parameterizations for K >= 3. Noting that 'when alpha=0.15, all pass' is not enough; it invites the response that the mechanism works only in a narrow parameter region that shrinks with K.

**The Bayesian persuasion commitment assumption needs a serious institutional defense**

The hegemon commits to a signal structure before observing theta, meaning a state credibly pre-commits to an information revelation policy across all states of the world. This is a strong assumption even by BP standards, where senders are typically prosecutors, media outlets, or regulators with observable commitment technologies. The three defenses in Section 8.3 are thin. Reputation requires repeated interaction, but the model is one-shot. WTO transparency rules prescribe minimum disclosure, they do not constrain the set of signal structures — they are not commitment devices for arbitrary information policies. The 'upper bound' interpretation is the safest reading but also the weakest: it says the qualitative institutional comparison might survive under weaker information structures without actually verifying this. The paper would be substantially strengthened by showing that the qualitative comparison — unanimity generates screening that majority does not — holds under cheap talk or verifiable disclosure. If the institutional comparison survives without full commitment, then the BP assumption is a convenience that sharpens the result. If it does not, the paper's main claim rests on an assumption that is difficult to justify in diplomatic settings.

**The closed-form threshold is not exploited for testable predictions**

Theorem 1 provides an explicit threshold p* as a function of model parameters. This is rare in formal IR theory and should be the paper's main empirical asset, yet the paper does little with it. The GATT/WTO discussion in Section 8.2 offers the prediction that 'consensus should matter most in complex negotiations where informational asymmetry is substantial,' but this is not derived from the model's comparative statics and could follow from many theories. The paper should compute how p* responds to changes in alpha, r, N, and c, and show that at least one comparative static generates a prediction distinguishing this theory from alternatives. A calibrated example — mapping early GATT rounds (few issue dimensions, moderate N, large informational asymmetry) to one parameter region and the Doha Round (many dimensions, large N, narrower asymmetry) to another — would show the model has empirical bite. The footnote connecting K>2 to the Single Undertaking gestures in this direction but remains informal. Without worked-through comparative statics, the formal apparatus produces results that are correct but idle.

**Differentiation from Bardhi and Guo (2018) and Kim, Kim, and Van Weelden (2025) is too compressed**

The introduction handles both papers in a single sentence: 'neither offers the institutional comparison between voting rules that is central here.' For a paper at AJPS or JoP, this is insufficient. Both papers study Bayesian persuasion with veto players, which is exactly this paper's modeling setting. A referee familiar with these papers will ask: does Bardhi and Guo's unanimity analysis already produce a screening non-convexity exploitable by BP? Does Kim et al.'s veto bargaining model already generate the jump in the sender's value function? If those papers already establish the unanimity channel, then the present paper's contribution reduces to the majority comparison and the entry stage — still valuable but narrower than claimed. If their models do not produce the screening mechanism because of structural differences (e.g., no asymmetric outside options, no legislative bargaining protocol), the paper should explain which features of its setup are doing the new work. Two to three paragraphs of explicit comparison would resolve this.

**Two-round bargaining may shape features attributed to the voting rule**

The clean information revelation in the screening equilibrium — type theta=1 rejects the aggressive R1 offer, and W learns theta=1 with certainty in R2 — depends on R2 being terminal. With more rounds, rejection in round t would not fully reveal the type, because W might still prefer aggressive offers in subsequent rounds, and H's continuation value would reflect future screening opportunities rather than a fixed disagreement payoff. In an infinite-horizon Baron-Ferejohn model, the equilibrium is stationary and the screening dynamics would differ because the off-path beliefs are pinned down differently. The paper does not discuss whether the discrete jump at the R1 cutoff is a feature of the two-round structure or would persist under richer protocols. Given that WTO negotiations span years and involve many rounds of proposals, the two-round assumption is a significant abstraction. Even a brief analytical discussion of how the jump magnitude varies with T, or a simulation with T=3, would clarify whether the mechanism is robust or an artifact of the finite horizon.

**Theorem 1's threshold p* is never computed for any parameterization**

The paper's headline result is a closed-form threshold p* = lambda_M / [S_U - lambda_M(r-1)] that separates priors favoring majority from those favoring unanimity. Yet p* is never evaluated as a number anywhere in the paper. Example 1 computes the screening jump (one building block), and Figure 5 shows colored parameter regions at p=0.05, but neither traces through the full calculation: computing tau(M), tau(U), S_U, lambda_M, identifying which of the four Theorem 1 cases applies, and evaluating p*. The motivating example in Section 2 uses a simplified setup without entry costs, so no p* exists there either. For the Example 1 parameters (N=5, r=1.5, alpha=0.3, beta=0.9, c=0.1), evaluate every quantity in Theorem 1, report which case obtains, and compute p*. Show that cav v(p,U) exceeds cav v(p,M) for p above p* and the reverse below. Without this, a referee cannot tell whether p* is 0.02 or 0.6 — and the substantive interpretation changes entirely depending on the answer.

**Weak states' payoff under the hegemon's optimal institution is unexamined**

The paper frames its contribution as explaining institutional design and provides 'a distributive explanation for consensus rules.' But it analyzes only the hegemon's side of the institutional comparison. Section 7.2 establishes that V_W(mu, M) > V_W(mu, U) conditional on entry without persuasion, but never computes weak states' ex ante expected payoff under the hegemon's optimal signal. Under H's optimal BP, the signal may induce W to enter at posteriors where its expected payoff barely exceeds c, potentially making W worse off ex ante than under majority. Since the paper models institutional choice as H's unilateral decision at Stage 0, a natural question is why W would accept this rule. Compute W's expected payoff under each institution with optimal persuasion for the Example 1 parameters. If W is strictly worse off under unanimity — as seems likely given Lemma 1 — the paper needs to discuss what sustains unanimity from W's perspective: side payments, status quo bias, or package deals. This gap matters because calling consensus an 'institutional technology of power' while leaving the distributional consequences unquantified weakens the design interpretation.

**No decomposition showing entry and screening channels' relative magnitudes**

The paper's distinctive claim is that unanimity enables 'dual exploitation' of two non-convexities — the entry threshold and the screening jump — while majority offers only the entry channel (Proposition 4, Section 6.3). This is stated qualitatively but never demonstrated quantitatively. For any given parameterization, how much of the hegemon's BP gain under unanimity comes from the screening channel versus the entry channel? A clean decomposition is straightforward: compute the concavification gain with c=0 (removing the entry non-convexity, isolating screening) and separately with the screening jump smoothed out (removing the screening non-convexity, isolating entry). For the Example 1 parameters, report both components and their ratio. If one channel accounts for the vast majority of the gain, then 'dual exploitation' overstates the mechanism's novelty. If both are substantial, the decomposition is the paper's strongest quantitative evidence that the screening channel — the new ingredient — does meaningful work beyond what a simpler entry-cost model would deliver.

**Recommendation**: Major revision. The core idea — consensus as a technology of informational power, formalized through the interaction of screening and Bayesian persuasion — is novel and the binary-type model delivers it cleanly. The single-crossing result is elegant. However, the mechanism's structural dependence on discrete types is a serious concern that the paper's own K>2 extension exacerbates rather than resolves. The BP commitment assumption needs more convincing justification in the IO context, and the paper needs sharper testable predictions and more thorough engagement with the closest BP-in-bargaining work.

**Key revision targets**:

1. Resolve the K>2 fragility: either prove Proposition 8 analytically with explicit conditions showing how fast the parametric support contracts with K, or provide a rigorous argument for why the binary case is the right level of abstraction and honestly assess the mechanism's limits.
2. Verify whether the qualitative institutional comparison (unanimity generates screening, majority does not) survives under weaker information structures — cheap talk or verifiable disclosure — rather than relying solely on full BP commitment.
3. Develop calibrated comparative statics on p* that generate at least one testable prediction distinguishing this theory from legitimacy accounts (Gould 2022) and self-enforcement accounts (Maggi and Morelli 2006).
4. Expand the discussion of Bardhi and Guo (2018) and Kim, Kim, and Van Weelden (2025) to explain which structural features of the present model produce results absent in theirs.
5. Discuss whether the two-round finite horizon is essential to the screening jump, ideally through a brief analysis or simulation with T > 2 rounds.

**Status**: [Pending]

---

## Detailed Comments (10)

### 1. Crawford and Sobel cited for evidence games and verifiable disclosure

**Status**: [Pending]

**Quote**:
> —may survive under weaker information structures, such as evidence games or verifiable disclosure *(Crawford and Sobel 1982)*.
> 
> When ma

**Feedback**:
Crawford and Sobel (1982) is the foundational cheap talk model: costless, unverifiable messages from sender to receiver. It has nothing to do with evidence games or verifiable disclosure. Evidence games (Glazer and Rubinstein 2004, 2006; Hart, Kremer, and Perry 2017) involve choosing which verifiable evidence to present. Verifiable disclosure (Milgrom 1981; Grossman 1981) involves voluntary revelation of certifiable information. These are three distinct communication models, ordered by the sender's commitment power: cheap talk (none) < verifiable disclosure (partial) < Bayesian persuasion (full). The conceptual argument is sound, but attaching Crawford and Sobel to 'evidence games or verifiable disclosure' misattributes the reference. Replace with citations matching each model: e.g., cheap talk (Crawford and Sobel 1982), evidence games (Glazer and Rubinstein 2006), verifiable disclosure (Milgrom 1981).

---

### 2. Abstract and conclusion assert threshold existence unconditionally

**Status**: [Pending]

**Quote**:
> The institutional comparison reduces to a single threshold: above it, unanimity dominates; below it, majority can dominate through easier entry. The ranking never oscillates.

**Feedback**:
Theorem 1 has four cases. Cases (a) and (c) produce no threshold at all: unanimity dominates for every prior. The threshold p* appears only in cases (b) and (d), when entry is harder under unanimity. Both the conclusion and the abstract ('there is a unique prior threshold, in closed form') describe only the threshold cases, giving the impression that a crossing point always exists. The formal result says 'at most one prior at which the ranking changes,' not 'exactly one.' This matters for interpretation: one of the paper's most interesting findings is that unanimity can dominate globally, yet the conclusion buries this by defaulting to the threshold framing. Revise to: 'The institutional comparison has a single-crossing structure: when a threshold exists, unanimity dominates above it and majority below it through easier entry; when entry conditions are favorable enough, unanimity dominates at all priors.'

---

### 3. Conclusion paragraph on K>2 simultaneously understates and overstates

**Status**: [Pending]

**Quote**:
> ffs. I conjecture that each cutoff produces an upward jump in the hegemon’s value function, so that the non-convexity structure becomes richer rather than weaker—but this remains to be verified for the specific payoff structure of this model.

**Feedback**:
This paragraph has two opposite-direction errors. First, it frames K>2 jumps as an open conjecture, but Appendix D contains three formal propositions partially verifying it: Proposition 6 proves K-1 screening boundaries exist for general K, Proposition 7 proves majority remains linear for all K, and Proposition 8 proves conditional dominance for K=3 under alpha < alpha_3*. Numerical verification covers 99.7% of priors on the 2-simplex. For K=3, the conjecture is an established result of the paper, not an open question. What remains genuinely unverified is K>3. Second, the same paragraph concludes 'The mechanism is therefore robust to richer finite type spaces,' but Table 1 in Appendix D reports two parameterizations where D(mu) < 0, the paper itself prints a warning that Proposition D.3 is not confirmed, and the parametric restriction tightens from alpha < alpha* to alpha < alpha_3* with alpha_3* strictly smaller in general. An unqualified robustness claim is inconsistent with these findings. Rewrite to distinguish what is proved (K=3 under tighter conditions) from what is conjectured (general K), and acknowledge that the parameter region contracts as K grows.

---

### 4. Main text and footnote predict opposite effects of complexity on consensus

**Status**: [Pending]

**Quote**:
>  consensus should matter most in complex regulatory areas—services, intellectual property, investment—where evaluating proposals requires deep technical expertise, and

**Feedback**:
The main text predicts that complexity favors consensus via greater informational stakes. Footnote 6 argues the opposite: bundling issue dimensions increases K, tightening alpha_3* and 'diluting informational power.' The same empirical examples appear on both sides of the argument. Services, IP, and investment negotiations are informationally opaque (favoring consensus per the main text) and multi-dimensional (hurting consensus per the footnote). The paper never acknowledges this tension. A plausible resolution exists: 'complex' might mean hard to evaluate within one dimension (high r, favoring screening) while 'many bundled dimensions' means a richer type space (high K, tightening alpha_3*). But the paper's own examples sit squarely in both categories. Add a sentence after the footnote explicitly distinguishing the payoff-dispersion channel (governed by r) from the type-richness channel (governed by K) and state which one is expected to dominate in the cited applications.

---

### 5. Mapping K to bundled issue dimensions understates the threat to the mechanism

**Status**: [Pending]

**Quote**:
> s implication. As the number of relevant states increases—corresponding to negotiations that bundle multiple issue dimensions under a Single Undertaking (intellectual property, services, industrial goods, agriculture)—the parametric

**Feedback**:
K in the model indexes discrete realizations of V(theta), the aggregate value of cooperation. Bundling many independent issue areas under a Single Undertaking would, by a law-of-large-numbers effect on the sum of many components, push the aggregate value toward a near-continuous distribution rather than a larger finite K. The paper's own conclusion concedes that continuous types would eliminate the discrete screening jumps entirely. The empirically motivated mapping (more bundled issues leads to higher discrete K, mechanism weakens but survives) therefore understates the problem: extensive bundling could approximate continuity and destroy the mechanism outright, not merely tighten alpha_3*. Either justify why bundled dimensions produce a richer discrete K rather than approximate continuity, or flag this as a limitation: 'If bundling approximates a continuous state space rather than a richer discrete one, the screening mechanism may not survive.'

---

### 6. Numerical characterization evaluates at a single, extreme prior

**Status**: [Pending]

**Quote**:
> )Parameter regions where the hegemon prefers unanimity (blue) vs majority (red) at prior  $p = 0.05$ , res

**Feedback**:
Figure 5 is the paper's only visual demonstration of Theorem 1's parameter dependence, and it evaluates the comparison at p = 0.05, a 5% probability of high-value cooperation. This choice is never motivated. At such a low prior, the entry constraint is likely binding for many parameterizations, so the figure may largely show where entry is feasible under unanimity rather than where the screening mechanism is active. The broad blue region could narrow substantially at p = 0.2 or 0.4, where the entry constraint relaxes and the comparison shifts to the screening channel. A reader seeing mostly blue at p = 0.05 might infer that unanimity dominates for most parameter configurations, but this depends on whether p = 0.05 is empirically plausible for IO negotiations. Show either a second panel at a moderate prior (p = 0.3 or 0.5) or briefly justify why p = 0.05 is the relevant benchmark, perhaps by connecting it to the frequency of high-value cooperation rounds in GATT/WTO history.

---

### 7. Parenthetical wrongly claims (N-1)/N-squared peaks at intermediate values

**Status**: [Pending]

**Quote**:
> s hump-shaped in $N$ (the per-player component $(N - 1)/N^2$ peaks at intermediate values).
> 

**Feedback**:
The derivative of f(N) = (N-1)/N^2 is (2-N)/N^3, which is negative for all N > 2. Concrete values: f(3) = 2/9, f(5) = 4/25, f(10) = 9/100, all strictly decreasing. The function is maximized at N = 2, not at intermediate values. The total jump may still be hump-shaped in N because the screening cutoff mu_s^{R1} itself depends on N (from equation 7, the cutoff decreases as N grows, so the factor (1 - mu_s^{R1}) increases and can outweigh the decreasing (N-1)/N^2 at small N). But the parenthetical attributes the hump to the wrong component. Correct it to note that the hump arises from the interaction of a decreasing (N-1)/N^2 with an increasing (1 - mu_s^{R1}), not from (N-1)/N^2 alone.

---

### 8. Parenthetical gets the direction of the conservative region wrong

**Status**: [Pending]

**Quote**:
> decreases with $\mu_s^{R1}$ (larger conservative region)

**Feedback**:
The conservative region is the interval (mu_s^{R1}, 1], with length 1 - mu_s^{R1}. When the cutoff rises, this interval shrinks. The claim about the jump is right: higher mu_s^{R1} reduces the jump through the (1 - mu_s^{R1}) factor. But the parenthetical says the opposite of what happens geometrically. Replace '(larger conservative region)' with '(smaller conservative region).'

---

### 9. Higher r is payoff dispersion, not informational asymmetry

**Status**: [Pending]

**Quote**:
> The unanimity-dominance region is larger for higher  $r$  (greater informational asymmetry) and h

**Feedback**:
Informational asymmetry in this model is binary and fixed: H observes theta, W does not. It does not vary with r. What r governs is the payoff dispersion across states: V(1)/V(0) = r. Higher r raises the stakes of private information; it does not make one side more informed. Since the paper's central concept is 'informational power,' and r appears repeatedly in comparative statics, being precise about this distinction matters. Replace '(greater informational asymmetry)' with '(greater payoff dispersion across states)' or '(higher stakes of private information).'

---

### 10. Doha example conflates institutional preference with negotiation outcomes

**Status**: [Pending]

**Quote**:
> This is consistent with the contrast between focused early GATT rounds (few issue dimensions, $K$ effectively small, consensus effective) and the Doha Round (many dimensions bundled via Single Undertaking, $K$ large, consensus stalled). The
> 
> 25

**Feedback**:
The model predicts whether H prefers unanimity over majority. 'Consensus effective' versus 'consensus stalled' is about whether negotiations reach agreement under a given rule, which is a different question. Doha stalled primarily over distributional conflicts (agriculture, NAMA), not because the US switched to preferring majority. A model of H's optimal voting rule cannot directly explain breakdown under a fixed rule. The footnote could instead say: 'Under early GATT (K small), the model predicts a strong hegemonic preference for consensus. Under Doha-era bundling (K large), the predicted advantage shrinks, potentially reducing the hegemon's stake in sustaining consensus.' That phrasing maps the model's output (preference) to the empirical observation (reduced effort to make consensus work) without equating the two.

---
