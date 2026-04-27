# Parecer de Contribution (Framework Edmans)

## Score: 6.5/10

## Resumo da contribuicao alegada

The paper claims that a hegemon may rationally prefer consensus (unanimity) over majority rule in international organizations because unanimity creates a screening problem that amplifies the hegemon's informational advantage. The central mechanism is that unanimity forces weak states to include the hegemon in every proposal without knowing its type, generating overpayment (a "screening rent") that makes the hegemon strictly better off than under majority, conditional on institutional entry. The paper presents this as a distributive-informational explanation for consensus rules in organizations such as the WTO.

## Avaliacao por dimensao

### Novidade [Adequada]

The paper offers a genuinely novel mechanism linking voting rules to information exploitation. The insight that unanimity creates a screening problem while majority eliminates it---because weak states can bypass the hegemon under majority---is original and non-obvious. This is not a convex combination of existing results: Baron-Ferejohn bargaining has been extensively studied, and Bayesian persuasion has been applied to voting, but the specific connection between unanimity as an institution that activates screening rents from private information is new.

However, several factors temper the novelty assessment. First, the idea that unanimity gives veto players leverage is well-established in the institutional design literature (Tsebelis 2002 on veto players, Maggi and Morelli 2006 on self-enforcing voting). The paper's contribution is to formalize a specific *informational* channel through which this leverage operates, which is more incremental than paradigm-shifting. Second, the screening mechanism itself---that an uninformed party offering to an informed party faces a lemons-like problem---is a textbook adverse selection result (Rothschild-Stiglitz 1976, in insurance; analogous structures appear throughout mechanism design). The contribution is in embedding this in an institutional-choice context, not in the screening logic per se. Third, the paper originally had Bayesian persuasion as a co-protagonist (earlier versions) and has now demoted it to a remark (Remark 4), which narrows the novelty footprint. The remaining result---screening under unanimity generates higher payoffs for H---is clean but narrower than the original dual-channel contribution.

A reader already familiar with legislative bargaining under incomplete information would update beliefs moderately upon reading this paper. The Bayesian update is real but bounded: the *direction* of the result (unanimity can benefit the informed party) is intuitive once stated, even if the precise conditions and the cleanness of the comparison are not.

### Importancia [Adequada / Fraca]

The paper addresses a genuine puzzle: why powerful states accept consensus. This is a question of first-order importance in the study of international institutions. However, several aspects limit the importance of the contribution as delivered.

First, the practical relevance is uncertain. The model shows that H *may* prefer unanimity under specific parametric conditions ($\alpha < \alpha^*$), and the paper acknowledges that $\alpha^*$ becomes very small for large organizations ($\alpha^* \approx 0.03$ for $N = 164$). For a WTO-sized institution, the condition requires that bilateral alternatives capture only a tiny fraction of multilateral surplus. This is a strong requirement, and the paper does not establish empirically that it holds. A policymaker reading this paper would learn that there *exists* a theoretical channel through which consensus benefits a hegemon, but the conditions under which it operates at scale are demanding and unverified.

Second, the result is conditional on a specific modeling architecture: two types, two rounds of Baron-Ferejohn bargaining, all-or-nothing entry, and symmetric proposal rights. The paper is transparent about these choices, but the robustness to relaxing them is largely unaddressed. The $K > 2$ extension (Appendix C) honestly acknowledges that the parametric region may shrink---potentially to zero---as $K$ increases. This is a significant qualification for a paper whose substantive claim involves real-world institutions where uncertainty is high-dimensional.

Third, would a survey paper on institutional design in international organizations cite this result? Likely yes, as one mechanism among several, but it would not be the centerpiece. The paper does not overturn existing explanations (self-binding, legitimacy, informal power); it adds one more channel. The Discussion section (Section 8) explicitly positions the mechanism as complementary to existing accounts, which is intellectually honest but diminishes the perceived importance.

Fourth, the mechanism has limited *actionable* implications. A legislator or trade negotiator would not change behavior based on this result, because the model's conditions are hard to verify in practice and the mechanism operates through equilibrium forces that actors cannot easily manipulate. The observable implications (Section 8.1) are suggestive but not sharp enough to discriminate empirically against alternatives.

### Adequacao ao escopo [Adequada]

The bibliography is appropriate for a political science audience: Baron-Ferejohn, Kalandrakis, Eraslan-Evdokimov (legislative bargaining), Koremenos-Lipson-Snidal, Steinberg, Stone (international institutions), Fearon (rationalist explanations), Maggi-Morelli (self-enforcing voting), Kamenica-Gentzkow (Bayesian persuasion). The paper sits at the intersection of formal political theory and international political economy, which is a natural fit for JoP or AJPS.

The paper is of interest to the formal theory community and the IO/IPE community, though perhaps not to the broader political science audience. A comparativist or Americanist would find limited direct applicability. The paper reads as a theory paper in the tradition of Hirsch (2023, JoP) or Schnakenberg (2017)---technically sophisticated, substantively motivated, but narrowly targeted.

### Generalizabilidade [Limitada]

The model is built around a specific institutional context (international organizations with a hegemon) and specific structural features (binary types, Baron-Ferejohn bargaining, all-or-nothing entry). Several of these choices limit generalizability:

1. **Binary types.** The paper's results are sharpest for $K = 2$ and may not extend to richer type spaces. The paper is honest about this (Appendix C, Conclusion), but it means the mechanism is demonstrated in the case most favorable to it.

2. **Two rounds of bargaining.** The paper argues this is sufficient for robustness beyond the one-shot case, but the relationship between the number of rounds and the screening advantage is not characterized. With $T$ rounds, the strategic dynamics become more complex, and it is unclear whether the screening advantage grows, shrinks, or is non-monotone in $T$.

3. **All-or-nothing entry.** The assumption that all $N-1$ weak states must enter simultaneously is strong. In practice, coalition formation at the entry stage is itself strategic. The paper justifies this as appropriate for broad-membership institutions, but it precludes analysis of partial entry, which is relevant for understanding actual institution formation.

4. **Symmetric weak states.** All weak states are identical. Heterogeneity in outside options or information would substantially enrich (and potentially undermine) the results. The paper mentions this as a future extension.

5. **Application specificity.** The GATT/WTO application is suggestive but illustrative. The mechanism could in principle apply to any setting with a veto player who has private information, but the paper does not develop applications beyond international trade.

### Trade-offs [Parcial]

The paper recognizes the key trade-off: unanimity gives H a higher conditional payoff but makes entry harder for weak states. This is clearly articulated in the formation-set analysis (Section 7.2) and the institutional classification (Proposition 4). The paper also notes that weak states always prefer majority (Corollary discussion), which is an important cost of unanimity from the perspective of institutional welfare.

However, several trade-offs are underexplored:

1. **Efficiency.** The paper notes that unanimity destroys surplus through discounting on the aggressive branch (Appendix A.6), but does not systematically compare total welfare across rules. Is unanimity Pareto-dominated? When? The paper's focus on H's payoff leaves the welfare comparison incomplete.

2. **Dynamic costs.** The Conclusion mentions endogenous erosion of informational power and learning, but these are deferred to future work. If the screening advantage erodes over time, the long-run case for unanimity weakens, potentially reversing the short-run advantage. This is noted but not analyzed.

3. **Costs of the modeling choices themselves.** The all-or-nothing entry, symmetric weak states, and binary types all simplify in ways that may favor the mechanism. The paper does not discuss what would happen if these assumptions were relaxed in ways that work against the result.

### Hipoteses [Claras e direcionais]

The paper has a clear theoretical mechanism: unanimity makes H pivotal, creating a screening problem that generates rents for H. The hypothesis is directional: H prefers unanimity when $\alpha < \alpha^*$ and entry is feasible. The model generates precise comparative statics: the screening advantage increases with $r$ and $\beta$, decreases with $N$ and $\alpha$, and the entry advantage of majority increases with $c$.

The theoretical mechanism is grounded in well-understood economics (adverse selection under incomplete information) applied to a well-specified institutional choice. This is a strength. The hypotheses are not vague or kitchen-sink; they derive from a single mechanism with clear predictions.

The one qualification is that the observable implications (Section 8.1) are somewhat generic. The prediction that the mechanism matters more in complex negotiations and less in transparent ones is consistent with many information-based theories and does not uniquely identify this particular mechanism.

## Veredicto geral sobre contribution

The paper presents a technically competent model that identifies a novel mechanism linking voting rules to informational advantage in international organizations. The core insight---that unanimity creates screening rents while majority eliminates them---is clean, well-formalized, and substantively interesting. The paper is honest about its limitations, particularly the sensitivity to binary types and the demanding parametric conditions for large organizations.

As a contribution to the field, the paper falls in the "adequate but not compelling" range for a top-5 political science journal. The mechanism is original and the formalization is rigorous, but the result adds one more channel to an already crowded literature on institutional design without overturning existing explanations. The practical relevance is limited by demanding parametric conditions ($\alpha^*$ small for large $N$), the restriction to binary types, and the lack of empirical discrimination against alternatives. The paper would be a solid contribution to a specialized formal theory journal or a field journal in international political economy, but for JoP or AJPS, the contribution needs to be more clearly differentiated from the existing literature and the mechanism's relevance needs to be established more convincingly for realistic institutional environments.

The score of 6.5 reflects a paper with genuine novelty and technical quality that nonetheless falls short of the contribution threshold for a top general-interest political science journal. The mechanism is interesting but narrow; the conditions for it to operate at scale are restrictive; and the observable implications, while suggestive, do not clearly separate this explanation from alternatives. A stronger empirical or computational exercise demonstrating the mechanism's relevance under realistic parameterizations---or a sharper theoretical result that does not depend on binary types---would substantially strengthen the case.

## Sugestoes construtivas

1. **Establish empirical plausibility of the parametric conditions.** The most damaging weakness is that $\alpha^*$ becomes very small for large $N$. The paper should provide evidence (or at least a calibration exercise) showing that plausible values of $\alpha$ for real-world hegemons fall within the mechanism's domain. What is $\alpha$ for the US in the WTO? For the EU in other institutions? Without this, the mechanism risks being a theoretical curiosum.

2. **Sharpen the empirical predictions.** The observable implications (Section 8.1) are suggestive but not unique to this theory. Identify at least one prediction that distinguishes the informational-screening mechanism from (a) legitimacy accounts, (b) self-enforcing accounts, and (c) informal-power accounts. Ideally, point to a case or dataset where this prediction could be tested.

3. **Address the $K > 2$ limitation more aggressively.** The honest acknowledgment that the binary model is "the most favorable case" is commendable, but it raises the question of whether the mechanism survives in realistic settings. A computational exercise showing that $\alpha_K^*$ remains non-trivial for $K = 3, 4, 5$ would be highly valuable. If $\alpha_K^* \to 0$ rapidly, the paper should address this directly rather than leaving it as an "open question."

4. **Develop the welfare comparison.** The paper focuses on H's payoff but the institutional design question involves all players. Under what conditions is unanimity Pareto-dominated? When H chooses unanimity, how much total surplus is destroyed? This would add depth to the normative implications and connect to the institutional design literature (Koremenos et al. 2001) more substantively.

5. **Consider relaxing symmetric proposal rights.** The assumption of equal recognition probabilities is clean but unrealistic. If the hegemon has even moderate agenda-setting advantage under both rules, does the mechanism survive? A brief analysis (even as an appendix) showing robustness to asymmetric recognition would significantly strengthen the result.

6. **Differentiate more sharply from Bardhi-Guo (2018) and Kim-Kim-Van Weelden (2025).** These papers study persuasion in voting and veto bargaining settings. The current paper cites them but does not clearly articulate what is different about the institutional-choice question versus the information-design question. Two to three paragraphs explaining why this paper's results cannot be derived from or subsumed by these existing frameworks would strengthen the contribution claim.

7. **Reconsider the target journal.** The paper's strengths---technical rigor, clean formalization, tight results---are well-suited to formal theory venues. JoP accepts formal theory but favors papers with broader substantive engagement. AJPS values methodological innovation with empirical bite. The paper might receive a more sympathetic reception at a journal like *Games and Economic Behavior*, *Journal of Theoretical Politics*, or *Journal of Economic Theory*, where the technical contribution would be evaluated on its own terms.
