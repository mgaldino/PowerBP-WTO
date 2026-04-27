# Parecer de Design do Modelo (Dixit / Varian / Board)

**Paper**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Autor**: Manoel Galdino (University of Sao Paulo)
**Data do parecer**: 2026-04-26
**Versao avaliada**: formal_model_v4.Rmd
**Framework**: Dixit (2015), Varian (1997/2016), Board & Meyer-ter-Vehn (2018)
**Critical context**: Author is deciding whether to remove Bayesian Persuasion from the body and keep only screening (Options A/B/C per `notes/2026-04-26_bp_vs_screening_decisao.md`).

---

## Score: 7.5/10

## O modelo em uma frase

A two-round Baron-Ferejohn bargaining game with binary types and voluntary entry, comparing unanimity and majority rule, where unanimity forces pivotal inclusion of the informed hegemon, creating a screening cutoff whose discrete payoff jump Bayesian persuasion can exploit.

## Tipo de contribuicao

**New political force isolated within a new lens on an existing question.**

The question is old: why would a hegemon choose consensus? The model combines three established building blocks (Baron-Ferejohn bargaining, asymmetric information, Bayesian persuasion) in a novel configuration to isolate a force --- informational power through screening under pivotal inclusion --- that has not been articulated in the formal institutional-choice literature. In Board & Meyer-ter-Vehn's taxonomy, this is a "new model" contribution (novel combination generating a previously unidentified force) with elements of "policy force" (the comparative institutional prediction is operationally new).

The honest question, however, is whether the contribution is better described as one force (screening under unanimity) or two (screening + BP amplification). This question is at the heart of the author's current decision, and the design evaluation below addresses it directly.

---

## Avaliacao por dimensao

### MD1. Qualidade da pergunta: Excelente

The puzzle is genuine and comes from the world, not from a gap in the literature. The WTO operates by consensus. The United States and EU have the material power to push for weighted voting or qualified majority, yet consensus persists and even expands. Existing accounts either claim consensus constrains powerful states (self-binding: Keohane, Ikenberry) or masks conventional power (informal agenda: Steinberg, Stone). Neither explains when and why a hegemon would *prefer* unanimity to a rule that allows coalition-based exclusion.

The paper frames this cleanly: the puzzle is not "why does consensus exist?" but "why would the actor with the most to gain from majority rule voluntarily choose unanimity?" This is a well-posed design question in the sense of Dixit (2015): the model is built to answer a specific comparative institutional question, not to describe a general environment.

Evidence from the world: GATT rounds, WTO consensus norm, the persistence of unanimity in various multilateral settings despite hegemonic capacity to impose alternatives. The paper does not over-claim --- it does not assert that this is *the* explanation for consensus, only that it identifies conditions under which consensus is a rational choice for a hegemon.

### MD2. Simplicidade e KISS: Adequado (with tension)

This is the dimension where the model's design faces its most serious challenge, and where the BP question is sharpest.

**What is genuinely simple.** The core primitives are minimal: binary types, two-round Baron-Ferejohn, symmetric proposal rights, voluntary entry. The institutional comparison is clean: the only difference between the two regimes is the voting rule. Proposal rights, discount factors, outside options, entry costs --- all identical. This is textbook KISS: isolate one variable, hold everything else constant.

**The Schelling-Spence test for BP (detailed below).** Remove BP. Does the central phenomenon disappear? No. The central phenomenon is: *the hegemon prefers unanimity because screening under pivotal inclusion gives it a higher conditional payoff at every belief*. This is Lemma 1, which is entirely commitment-free. BP amplifies and extends this result, but is not necessary for it. The phenomenon survives --- indeed, it survives more robustly --- without BP.

**Where simplicity is under stress.** The model has three interacting mechanisms:
1. Screening (the weak proposer's binary choice between aggressive and conservative offers)
2. Entry (voluntary participation with belief-dependent costs)
3. Bayesian persuasion (hegemon commits to a public signal before entry)

The interaction of these three creates considerable complexity:
- BP operates on the *net gain function* v(mu, R), which combines screening and entry.
- The entry set E_U may be disconnected (due to the downward jump in V_W at mu_s^R1).
- The concavification operates differently on connected vs. disconnected entry sets.
- The quantitative decomposition (CR8 in the coarse review) revealed that BP amplification = 0 in the paper's own Example 2 parameters.

The two-round Baron-Ferejohn structure adds another layer. The motivating example (Section 2) shows the mechanism in one round. The two-round structure adds: (a) alpha-independence of the R1 cutoff when alpha < alpha_bar, (b) a second screening cutoff (R2), (c) off-path belief updating. These are analytically interesting but raise the question of whether the two-round structure is *necessary* for the main result or is earning its complexity budget. The paper addresses this adequately in the current version (the paragraph after Definition 1 justifies two rounds), but the cost is real.

**Verdict.** The model passes KISS for the screening mechanism alone. With BP added, it is on the boundary. The three-way interaction (screening x entry x BP) creates narrative complexity that the paper struggles to communicate clearly, as evidenced by the coarse review's repeated demands for quantitative decomposition and the finding that BP amplification vanishes in the paper's showcase example.

### MD3. Isolamento do mecanismo: Adequado (but BP muddies it)

**What is well-isolated.** The screening mechanism is brilliantly isolated. The comparison between majority and unanimity is clean:
- Under majority, W excludes H from the coalition. H captures alpha V(theta). No screening, no discontinuity, payoff is affine in beliefs.
- Under unanimity, W must include H. H's private information creates a screening problem. W must choose between aggressive and conservative offers. This creates a discrete jump at the cutoff.

The causal chain is: voting rule --> pivotal inclusion --> screening --> payoff jump --> conditional dominance. Each link is tightly identified. The additive decomposition in B.5a (D_base + delta_R1 + delta_R2) is a remarkable piece of mechanism isolation: each correction operates through a different component of H's payoff, and they are independent because they affect disjoint parts of the payoff (H's proposal vs. W's proposal to H).

**Where isolation gets fuzzy.** BP adds a second mechanism on top of screening. The paper's narrative treats them as a single mechanism ("screening creates non-convexity, BP exploits it"), but they are logically distinct:
1. Screening operates within the bargaining game. It is a property of the PBE.
2. BP operates before the bargaining game. It is a property of the information-design stage.

The paper's results can be cleanly partitioned:
- *Without BP*: Lemma 1 (conditional dominance), Remark 1 (mu_bar robustness), the irony of unanimity (W accepts unanimity because veto protects against exclusion, but creates screening exposure). These are commitment-free.
- *With BP*: Theorem 1 (dominance on E_U), Theorem 2 (single-crossing), the p* threshold.

The problem is that the paper presents these as stages of a single argument rather than as a hierarchy where screening is the primary mechanism and BP is a secondary amplifier. When the coarse review asks "what does BP add?" (CR8) and finds BP amplification = 0 in Example 2, it exposes this structural issue: the two mechanisms are not tightly coupled, and the paper does not make clear when BP is doing work and when it is not.

### MD4. Riqueza de insights: Rica

The model generates a gratifyingly rich set of insights beyond the original question:

1. **The irony of unanimity**: W accepts unanimity because veto protects against exclusion, but this very protection creates the screening problem that benefits H. Formal equality is the mechanism of informational extraction. This is a deep political insight.

2. **Informational power as substitute for agenda power**: Under monopoly proposal rights, the institution collapses (V_W = 0, no entry). Under symmetric proposals with majority, H is bypassed. Under symmetric proposals with unanimity, H's information becomes a strategic asset. The model maps a trade-off between *formal power* (agenda control, which is self-defeating) and *informational power* (which requires institutional constraints to be productive).

3. **Conditional vs. entry channels**: The clean separation between "unanimity always dominates conditional on participation" (Lemma 1) and "majority can dominate through easier entry" provides a structured framework for thinking about institutional choice. It is not "unanimity is always better" --- it is "unanimity is better when cooperation is promising enough."

4. **The alpha* biconditional**: The threshold is necessary and sufficient, creating a sharp parametric frontier. This is unusual in formal IR theory and generates testable comparative statics (alpha* decreases with N, etc.).

5. **Scale dependence**: The observation that alpha* shrinks with N and that V_W ~ O(1/N) connects the mechanism to a real institutional design question: why consensus works in small clubs (early GATT) and strains in large ones (WTO with 164 members).

6. **Conservative region robustness (Remark 1)**: Even when alpha >= alpha*, the screening advantage persists over most of the belief space. The mu_bar threshold is "remarkably stable," meaning the mechanism is robust to parameter misspecification. This is a quantitative finding that strengthens the qualitative result.

### MD5. Tipo de contribuicao (Board & Meyer-ter-Vehn)

**New force isolated.** The primary contribution is the identification of a political force --- informational power through screening under pivotal inclusion --- that has not been isolated in the formal IO-design literature. This force explains a specific empirical pattern (hegemonic preference for consensus) through a mechanism distinct from existing accounts.

**Secondary: new model/lens.** The combination of Baron-Ferejohn bargaining with asymmetric information and institutional comparison is novel. The model is not a formalization of an existing verbal argument; it generates the result endogenously from the interaction of information and voting rules.

**Tertiary: important application (if BP is retained).** BP as a tool for institutional analysis in IR is relatively new. The paper would be one of the first to show how information design interacts with voting rules in multilateral settings.

### MD6. Processo de construcao: Maduro

The model shows clear signs of extensive iteration:

1. **Multiple versions**: The trajectory from v1 (with beta, spatial voting, different outside options) through v2 (current primitives) to v3/v4 (light-math presentation) reveals sustained simplification.

2. **Features removed**: No surplus destruction parameter (beta removed), no direct W benefit from theta, no spatial voting, no heterogeneous outside options. Each simplification was deliberate.

3. **WLOG normalizations**: d_W = 0 is WLOG (footnoted), pie normalized above W's common outside option. Alpha < 1/r is a natural bound. These are signs of a model that has been worked over.

4. **Sharp results**: The biconditional in Lemma 1, the single-crossing in Theorem 2, the additive decomposition in B.5a --- these are the products of a model that has been iterated to the point where the results are as clean as the setup allows.

5. **Self-awareness about limitations**: The paper is honest about K>2 fragility, about the commitment assumption, about the dependence on discrete types. The scope section (Section 8) is mature and well-calibrated.

6. **Numerical verification**: Worked examples, heatmaps, parameter sweeps. The model has been thoroughly explored computationally.

---

## Schelling-Spence Test for BP

This is the critical question the author faces. I apply the test rigorously.

### Statement of the test

If we remove Bayesian Persuasion from the model entirely --- no Stage 1 signal, no commitment, weak states enter based on prior p alone --- does the central phenomenon (hegemon prefers unanimity) disappear?

### Answer: The central phenomenon SURVIVES without BP.

**What survives:**

1. **Lemma 1** (conditional payoff dominance): For alpha < alpha*, unanimity gives H a strictly higher continuation payoff than majority at every mu in (0,1]. This is the paper's strongest result. It requires zero commitment. It is a property of the PBE of the bargaining game.

2. **The screening mechanism** (Propositions 2-3): The screening cutoff, the discrete jump, the overpayment --- all operate within the bargaining game. BP is not involved.

3. **The irony of unanimity**: W accepts unanimity for its veto protection, which creates the screening problem. This insight is commitment-free.

4. **Conditional vs. entry trade-off**: Without BP, H prefers unanimity for all p in E_U (the entry set under unanimity). Outside E_U, majority dominates because only it can induce entry. The trade-off is clean and transparent.

5. **The alpha* biconditional**: Necessary and sufficient, commitment-free, sharp.

6. **Remark 1 (mu_bar robustness)**: Even beyond alpha*, the screening advantage persists over most of the belief space. Commitment-free.

7. **Scale dependence**: alpha* decreases with N. Commitment-free.

**What is lost:**

1. **Theorem 2** (single-crossing with a closed-form p*): Without BP, the institutional comparison for p < tau(U) is simply "majority wins by default because the institution does not form under unanimity." There is no p* --- the comparison is: unanimity dominates on E_U, majority dominates on the complement. This is less elegant but equally informative.

2. **The extension of unanimity's advantage below tau(U)**: BP allows H to induce entry under unanimity at priors below tau(U). Without BP, the unanimity entry set is fixed. This narrows the domain where unanimity dominates.

3. **The non-convexity/concavification language**: Without BP, the paper cannot talk about concave envelopes, information design, or the exploitation of non-convexity. This removes an entire analytical vocabulary.

4. **The connection to the BP literature**: Without BP, the paper does not contribute to the information design literature. It becomes a pure bargaining/institutional-design paper.

### Quantitative assessment

The decision note reveals that BP amplification = 0 in the paper's own Example 2 (N=5, r=1.5, alpha=0.3, beta=0.9, c=0.14). The entire advantage of unanimity in the entry set is screening. BP amplification > 0 requires the screening jump mu_s^R1 to fall inside E_U, which requires c to be low enough. For the parameterization in the comparative statics table (c=0.12, beta=0.9, N=5, alpha=0.3), BP gains are non-zero only at r=1.5 (the lowest value).

This is not a knock-out blow against BP --- there exist parameterizations where BP contributes --- but it confirms that screening is the primary mechanism and BP is a conditional amplifier that adds value only in a subset of the parameter space.

### The Schelling-Spence verdict on BP

**BP fails the strict Schelling-Spence test.** Removing it does not make the central phenomenon disappear. The hegemon still prefers unanimity whenever the institution forms. The mechanism --- screening under pivotal inclusion --- survives intact. The insight --- consensus is a technology of informational power --- survives intact.

**But BP passes a weaker version of the test.** BP extends the domain of unanimity's advantage from E_U to a larger set. Without BP, unanimity dominates only when the institution forms; with BP, unanimity can dominate even when the institution would not form spontaneously. This is a genuine extension, not merely a mathematical decoration. Whether this extension is worth the analytical and narrative cost is a judgment call, not a logical one.

---

## Veredicto geral sobre design

The model's design is strong. The screening mechanism is clean, well-isolated, and generates rich insights. The four-link causal chain (voting rule --> pivotal inclusion --> screening --> payoff jump) is the paper's core contribution and it works without any commitment assumption.

BP adds genuine value (extending the domain of unanimity's advantage, creating a sharp p* threshold, connecting to the information design literature) but at substantial cost (commitment assumption, narrative complexity, quantitative irrelevance in the paper's own showcase example, vulnerability to the coarse review's CR3 and CR8 critiques).

The design tension is clear: the model has one mechanism that is robust, clean, and commitment-free (screening), and a second mechanism that is analytically elegant but empirically fragile (BP). The paper currently presents them as co-equal protagonists, which creates a narrative problem when the coarse review asks "how much work is BP actually doing?" and the answer, for the paper's own parameters, is "none."

---

## Sugestoes construtivas

### 1. Option B is the strongest design choice: screening primary, BP subordinate

Of the three options in the decision note (A: remove BP from body; B: keep BP subordinate to screening; C: keep as co-protagonists), Option B is the best design decision for the following reasons:

- **Screening is the primary contribution.** Lemma 1 (conditional dominance) is a sharp, commitment-free result that answers the puzzle directly. It should be the headline result.
- **BP is a natural extension, not the core.** BP extends the domain of unanimity's advantage. This is worth one proposition and a paragraph, not co-protagonist status.
- **The narrative simplifies dramatically.** "Unanimity creates screening that benefits the hegemon" is a crisp one-sentence mechanism. "Unanimity creates screening, and the screening jump creates a non-convexity that BP exploits to extend the advantage to lower priors" is two sentences, requires explaining concavification, and invites the commitment objection.
- **The paper's results *already* have this hierarchy.** Lemma 1 and Theorem 1 work without BP's concavification adding anything in E_U. Theorem 2 is the only result that requires BP to extend the advantage below tau(U).

**Concrete implementation of Option B:**
- Promote Lemma 1 to Theorem 1 (the main result).
- Present screening as the primary mechanism (Sections 4-5) and the institutional comparison (conditional dominance) as the main result (Section 6).
- Add a short section (1-2 pages) after the main result: "When the hegemon can also design information structures..." Present BP as an extension that widens the advantage. Prove the single-crossing result as a corollary.
- The commitment assumption is discussed only in this extension section, not as a paper-level vulnerability.
- The title can remain the same ("Informational Power") because the informational power is the screening mechanism, not BP.

### 2. Strengthen the screening-only narrative

Without BP as co-protagonist, the paper needs to be explicit about what happens outside E_U. The honest statement is: "Without persuasion, majority dominates below tau(U) simply because the institution does not form under unanimity. This is a participation constraint, not a bargaining advantage." This is transparent and not a weakness --- it shows that the only way majority can beat unanimity is by making entry easier, never by giving H a better conditional deal.

### 3. Sharpen the empirical predictions from screening alone

The coarse review (CR4) asks for testable predictions using the closed-form threshold. The screening mechanism alone generates these:
- **Cross-issue variation**: Screening advantage is largest when r is large (high stakes of private information). Consensus should matter most in negotiations where the value gap between outcomes is large.
- **Organization size**: alpha* decreases with N. Screening advantage is easier to sustain in small organizations.
- **Bilateral alternatives**: Higher alpha narrows the domain of unanimity's advantage. The proliferation of PTAs (increasing alpha) should weaken the case for consensus.
- **Patience**: Higher beta strengthens the screening mechanism. Consensus should be most valuable in negotiations with long time horizons.

These predictions are available without any commitment assumption.

### 4. Address the K>2 vulnerability honestly

The coarse review and the paper's own Appendix C confirm that the parametric region contracts with K. The honest framing is: "The binary model is the most favorable case for the mechanism. With K>2 types, the screening structure becomes richer (K-1 boundaries) but the parametric conditions tighten. The binary model should be understood as identifying the mechanism at its cleanest, not as a general statement about all type structures." This framing is consistent with Varian's (1997) advice that a good model should isolate a mechanism, not describe the full complexity of the world.

### 5. The two-round structure passes KISS but should be explicitly justified

The current justification paragraph (after Definition 1) is adequate. What would strengthen it further: note that the motivating example proves the mechanism operates in one round, so the two-round structure is not load-bearing for the existence of the mechanism. It adds alpha-independence, a second screening cutoff, and a richer non-convexity. This is analogous to how Rubinstein (1982) uses infinite-horizon bargaining not because real bargaining is infinite but because the stationary structure generates cleaner results than finite-horizon models with their backward-induction artifacts.

### 6. If BP is retained (even as secondary), address the commitment question head-on

The coarse review (CR3) correctly identifies commitment as the paper's most vulnerable assumption. The best defense is: (a) Lemma 1 does not require commitment; (b) BP is presented as an extension showing what happens *if* commitment is available; (c) the qualitative ranking (unanimity > majority conditional on entry) does not depend on commitment; (d) the quantitative threshold p* depends on commitment but provides an upper bound on the hegemon's informational advantage.

### 7. Compute a worked example from beginning to end

Both the coarse review (CR5, CR6) and internal reviews have noted that p* is stated but not computed from start to finish. For Option B, the analog is: compute tau(U), tau(M), D(mu) at several beliefs, and the alpha* threshold for a single parameterization, walking the reader through every step. This would replace the current Example 2 with a more complete worked example that demonstrates the screening mechanism quantitatively without requiring concavification.

---

## Summary assessment for the BP decision

| Criterion | Screening alone | Screening + BP |
|-----------|----------------|----------------|
| Schelling-Spence | PASSES | (BP fails as independent mechanism) |
| Commitment required | NO | YES |
| Central puzzle answered | YES (conditional on entry) | YES (extended below entry threshold) |
| Narrative clarity | HIGH (one mechanism) | MEDIUM (two interacting mechanisms) |
| Vulnerability to CR3 (commitment) | NONE | HIGH |
| Vulnerability to CR8 (quantitative) | NONE | HIGH (BP=0 in Example 2) |
| Connection to info design lit | WEAK | STRONG |
| Journal target | JoP, AJPS | JoP, AJPS, possibly JET/TE |
| Overall design score (estimated) | 8/10 | 7.5/10 |

The screening-only version is a *tighter* paper with a *cleaner* design. The screening+BP version is a *richer* paper with a *more vulnerable* design. The design evaluation recommends Option B (screening primary, BP subordinate) as the configuration that maximizes the ratio of insight to vulnerability.

---

## Final note on the score

The score of 7.5/10 reflects the paper *as currently written* (v4), where BP and screening are co-equal protagonists and the tension between them creates design ambiguity. If the author implements Option B --- promoting screening to primary status and subordinating BP --- the design score would rise to 8-8.5/10, because the mechanism isolation would be sharper, the narrative would be cleaner, and the vulnerability surface would shrink. The screening mechanism alone is an Excellent design; the current configuration of screening + BP as co-protagonists is an Adequate-to-Strong design with avoidable tension.
