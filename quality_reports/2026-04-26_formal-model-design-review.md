# Parecer de Design do Modelo (Dixit / Varian / Board)

**Paper**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Autor**: Manoel Galdino (USP)
**Data do parecer**: 2026-04-26
**Versao avaliada**: formal_model_v3.Rmd

## Score: 8/10

## O modelo em uma frase

A two-round Baron-Ferejohn bargaining game with binary private information and voluntary entry, comparing unanimity and majority rule, where unanimity forces weak states to screen the hegemon's type, creating a discrete payoff jump that Bayesian persuasion exploits.

## Tipo de contribuicao (Board & Meyer-ter-Vehn)

**New lens on an existing question + isolation of a new political force.**

The question---why a hegemon would choose consensus---is old (Steinberg 2002, Koremenos et al. 2001, Ikenberry 2001). The contribution is a new lens: combining legislative bargaining, asymmetric information, and Bayesian persuasion to isolate a specific force (informational power through screening) that has not been articulated in this institutional-choice setting. This is not a pure "new question" paper; it is a "new mechanism for an old puzzle" paper. The Board & Meyer-ter-Vehn taxonomy would classify it as "new model" (a novel combination of existing building blocks that generates a previously unidentified force) with elements of "policy force" (the comparative institutional prediction is new).

The paper is honest about this: the introduction carefully distinguishes its mechanism from prior accounts (informal agenda power, self-binding, legitimacy). The mechanism---that unanimity makes the hegemon pivotal, creating a screening problem whose non-convexity Bayesian persuasion exploits---is genuinely new in the formal institutional design literature on IOs. This is an appropriate contribution for a top field journal (JoP, AJPS).

## Avaliacao por dimensao

### MD1. Qualidade da pergunta [Excelente]

The puzzle is first-rate: why would a powerful state voluntarily adopt a rule that gives every other participant a veto? This is a genuine empirical puzzle (WTO consensus, GATT history, broader IO design). It is comprehensible to non-specialists---any political scientist can grasp the tension between power and self-constraint. The paper passes Varian's "interest test": a game theorist, an IR theorist, and an empirical IO scholar would each find something to engage with.

The paper does a good job of sharpening the puzzle into three layers (why not monopoly agenda? why not majority? why unanimity?) in the introduction. This tripartite decomposition is effective pedagogy and immediately communicates that the answer is non-trivial.

**Insight novelty vs. formalization**: The intuition that consensus might benefit powerful states is not entirely new---Steinberg (2002) argues that major trading powers benefit from consensus through informal agenda power, and the rational-design literature (Koremenos et al. 2001) has noted that voting rules serve distributional functions. However, the specific mechanism here---that unanimity creates a screening problem whose non-convexity makes information strategically productive---is new. The paper is not merely formalizing an existing verbal argument; it is identifying a qualitatively different channel (informational power through screening) that prior work has not articulated. The distinction between "informal influence persists under consensus" (Steinberg) and "consensus creates the strategic environment in which informational advantage becomes most valuable" (this paper) is substantive, not merely semantic.

One area for improvement: the paper could state more explicitly in the introduction that the novelty lies in the mechanism, not the broad claim that consensus can benefit powerful states. The current framing occasionally reads as if no one has previously suggested that hegemons benefit from consensus.

### MD2. Simplicidade e KISS [Adequado]

The model is well-disciplined but not minimal. Let me apply the Schelling-Spence test systematically:

**Essential components (removing kills the phenomenon):**
- Binary types (theta in {0,1}): Essential. Creates the discrete screening cutoff. Continuous types would generically smooth the jump.
- Unanimity vs. majority comparison: Essential. The entire paper is an institutional comparison.
- Private information for H: Essential. Without it, no screening, no BP gains.
- Voluntary entry with cost c: Essential for the entry-margin channel that creates the single-crossing result (Theorem 2). Without entry, Theorem 1 (conditional dominance) still holds, but the institutional comparison becomes trivial (unanimity always dominates when alpha < alpha*).
- Bayesian persuasion: Essential. Without it, unanimity dominates only when the institution would form under both rules. BP extends the dominance to priors below the entry threshold.

**Potentially non-essential components:**
- Two rounds of bargaining (Baron-Ferejohn): This is the component I would scrutinize most. The R1 screening cutoff, the R1 jump, and the conditional dominance result all depend on the two-round structure. But the motivating example (Section 2) achieves the same qualitative phenomenon with a single take-it-or-leave-it offer. The second round provides richer non-convexity (two screening cutoffs instead of one) and makes the cutoff independent of alpha when alpha < alpha_bar, which is analytically convenient. But the core mechanism---screening under unanimity, no screening under majority---is already present in the one-round version. The two-round structure adds analytical richness but also significant complexity (R2 branches, case selection, two cutoffs, the alpha_bar regime threshold). A referee might ask: could you get Theorems 1 and 2 with a single round?

- N players (general N): Appropriate. The paper uses N=3 only in the motivating example, and the general-N results reveal the comparative statics with respect to organization size (alpha* decreasing in N, the (N-1)/N^2 term in the jump magnitude). This is a case where generality adds insight.

- Random proposer under both rules: Good KISS discipline. By fixing proposal rights to be symmetric, the paper isolates the voting-rule comparison. The paper explicitly discusses why monopoly agenda control is self-defeating (Section 8, Scope). This is a well-motivated simplification.

- Discount factor beta: Necessary for the two-round structure to have bite. In a one-round model, beta would be irrelevant.

**Assessment**: The model is enunciable in about 3 pages (Sections 3-3.2), passing the Board test. The main tension is the two-round bargaining structure: it is not the simplest model that generates the screening mechanism, but it is arguably the simplest model that generates the full set of results (including the alpha-independence of the cutoff and the richer non-convexity). The tradeoff is reasonable but not optimal. The paper would be slightly stronger if it either (a) derived the main results in a single-round model and presented the two-round version as a robustness extension, or (b) more explicitly justified why two rounds are needed for the main results (not just for analytical convenience).

### MD3. Isolamento do mecanismo [Excelente]

This is the paper's greatest strength. The mechanism is precisely isolated: unanimity makes H pivotal, which forces W to screen H's type, which creates a discrete jump in H's payoff at the screening cutoff, which creates a non-convexity that Bayesian persuasion exploits. The causal chain has four links, each cleanly identified:

1. Voting rule --> pivotal inclusion (unanimity) vs. exclusion (majority)
2. Pivotal inclusion + private information --> screening cutoff
3. Screening cutoff --> discrete payoff jump (non-convexity)
4. Non-convexity --> gains from Bayesian persuasion

The decomposition in Appendix B.5a (D = D_base + delta_R2 + delta_R1) is an excellent piece of mechanism isolation: it shows that the R1 and R2 corrections are independent and affect disjoint components of the payoff. This is exactly the kind of clean separation that Dixit emphasizes.

The institutional comparison is also cleanly isolated. Under majority, the hegemon's payoff is linear in beliefs---no screening, no jump, no non-convexity. Under unanimity, the payoff is piecewise linear with a discrete upward jump. The entire paper is about this structural difference.

The one area where isolation could be sharper is the entry channel. The paper argues that majority can dominate only through easier entry, never through higher conditional payoffs (when alpha < alpha*). This is clean. But the interaction between the entry channel and the screening channel under Bayesian persuasion is somewhat opaque: how exactly does concavification operate when E_U is disconnected? The paper acknowledges this possibility (footnote on disconnected E_U in A.7, Theorem 2 proof in B.8) but the interaction is technically handled rather than intuitively explained.

### MD4. Riqueza de insights [Rica]

The model generates several insights beyond the core institutional comparison:

1. **Alpha* is if and only if** (Lemma 1): The biconditional character---alpha < alpha* is both necessary and sufficient for conditional dominance---is a sharp result that maps directly to the empirical prediction about bilateral alternatives.

2. **Single-crossing** (Theorem 2): The institutional ranking never oscillates. This is a strong structural result that is not obvious ex ante---one might expect the comparison to oscillate as the screening and entry channels interact at different priors.

3. **The screening cutoff is independent of alpha** (when alpha < alpha_bar): This is a substantively important comparative static. The hegemon's bilateral alternative strength does not affect how aggressively weak states screen---only the uncertainty about the value of cooperation, the discount factor, and the number of players matter.

4. **Remark on mu_bar**: The belief threshold above which majority dominates (when alpha > alpha*) is remarkably stable across alpha. This robustness result extends the mechanism's relevance beyond the alpha < alpha* domain.

5. **PTA/Bhagwati prediction**: The proliferation of bilateral alternatives (increasing alpha) shifts the hegemon's preference away from consensus. This is a testable cross-time prediction.

6. **K > 2 types** (Appendix C): Unanimity generates K-1 screening boundaries while majority remains linear. The mechanism gets richer, not weaker, with more types.

7. **Entry set disconnectedness**: The possibility that E_U is disconnected is a non-trivial structural feature that emerges naturally from the model.

**Counter-intuitive results**: The core result is moderately counter-intuitive: a powerful state prefers the rule that constrains it most. The paper argues persuasively that this is counter-intuitive from the perspective of coalition-arithmetic models (Baron-Ferejohn), where veto power for all players is bad for the most powerful player. The paper could push this counter-intuition further by noting that even in the model's own terms, unanimity is strictly worse for H absent private information (at mu = 1, the conditional advantage is smallest). The mechanism only works because uncertainty is present.

**Transferability**: The mechanism is potentially transferable to other settings where a powerful actor has private information and faces a choice between inclusive and exclusive institutional rules: corporate governance (shareholder unanimity vs. majority), EU Council voting, security alliances. The paper mentions some of these in the conclusion and discussion but does not develop them extensively---this is appropriate for a focused paper.

### MD5. Tipo de contribuicao [New mechanism for an old puzzle --- strong]

This is primarily a "new model" contribution in Board & Meyer-ter-Vehn's taxonomy: a novel combination of known building blocks (Baron-Ferejohn, binary screening, Bayesian persuasion) that isolates a previously unidentified political force (informational power through pivotal inclusion). Secondarily, it generates new empirical predictions (cross-issue variation in the value of consensus, effect of bilateral alternatives on institutional preferences).

The contribution is well-positioned. It does not claim to explain all consensus institutions or to supersede existing accounts. It claims to identify a specific mechanism---informational power through screening---that is absent from prior formal models of IO design. This positioning is appropriate and defensible.

The paper does not make a significant technical contribution in the Bayesian persuasion literature; the concavification technique is standard. The contribution is entirely in the application and the institutional comparison, which is appropriate for a political science audience.

### MD6. Processo de construcao [Maduro]

The paper shows clear signs of iterative refinement:

1. **Example before generality**: The motivating example (Section 2) presents the full mechanism in a three-player, one-round setting before the general model. This follows Varian's "work an example" principle exactly. The example is effective: it builds intuition for screening, the jump, overpayment, and BP gains in a setting where all quantities are computed by hand.

2. **Baseline + extensions**: The paper builds systematically: majority first (linear, no screening), then unanimity (screening, jump), then entry and BP (non-convexity, concavification), then the institutional comparison. Each section adds one building block. This is excellent expository discipline.

3. **Special cases informing the general result**: The paper uses beta = 1 (cutoff simplifies to 1/(N-2)), the alpha < alpha_bar regime (alpha-independent cutoff), and the E_U = (0,1] case (global dominance corollary) as special cases that illuminate the general result.

4. **Numerical examples**: Example 1 (magnitudes), Example 2 (computing p*), and the parameter-region figures provide concrete quantitative grounding. The use of multiple parameter configurations in the figures (strong mechanism vs. weak mechanism) shows a model that has been explored computationally.

5. **Case selection handled explicitly**: The paper identifies the alpha_bar regime threshold and treats both cases (alpha < alpha_bar and alpha >= alpha_bar) in the proofs. This suggests the model has been pushed to its corners.

6. **Mature scope discussion**: The scope section addresses symmetric proposal rights, monopoly agenda control, commitment, and the alpha* boundary with specificity. The alternative-explanations paragraph is well-calibrated. These are signs of a model that has been scrutinized and defended.

One sign of maturity that is particularly notable: the paper explicitly identifies where the mechanism fails (alpha > alpha*, near mu = 1, continuous types) and characterizes these failure modes precisely. This is the hallmark of a well-understood model.

## Veredicto geral sobre design

This is a well-designed model that isolates a genuine and novel mechanism for an important puzzle in international political economy. The question is excellent (why would a hegemon choose consensus?), the mechanism is precisely identified (screening through pivotal inclusion creates non-convexity that Bayesian persuasion exploits), and the institutional comparison is sharp (single-crossing, biconditional threshold). The model passes the Schelling-Spence test on all essential components: removing any of the five key ingredients (binary types, unanimity-majority comparison, private information, voluntary entry, Bayesian persuasion) eliminates or qualitatively changes the result.

The main tension in the design is the two-round Baron-Ferejohn structure, which adds analytical richness at the cost of complexity. The core mechanism is already present in the one-round motivating example, and a referee might reasonably ask whether two rounds are necessary for the main theorems or merely convenient. The paper would benefit from a clearer statement of what the second round buys beyond the first.

The model generates a rich set of insights: the biconditional alpha* threshold, the single-crossing result, the alpha-independence of the screening cutoff, the robustness of mu_bar, the disconnected entry set, and testable predictions about bilateral alternatives and cross-issue variation. The mechanism is transferable to other institutional-choice settings. The paper is iteratively refined, with concrete examples preceding general results, explicit treatment of edge cases, and a mature scope discussion.

The score of 8 reflects a model that is strong on all dimensions except simplicity, where the two-round structure creates a non-trivial gap between the minimal model that generates the mechanism and the model actually presented. This gap is not fatal---the two-round model generates richer results---but it creates an expository burden that the paper does not fully justify.

## Sugestoes construtivas

1. **Justify the two-round structure explicitly.** The motivating example uses one round and generates the same qualitative mechanism. State clearly in Section 3 (or in a remark after Definition 1) what the second round adds: (a) alpha-independence of the screening cutoff when alpha < alpha_bar, (b) a richer non-convexity structure with two cutoffs, (c) the off-path continuation game that pins down beliefs after rejection. If the main theorems hold with one round (as I suspect they do), acknowledge this and position the two-round model as the richer version. If they do not hold with one round, explain why.

2. **Sharpen the novelty claim in the introduction.** The introduction could more clearly distinguish between the broad claim (consensus can benefit powerful states---not new) and the specific mechanism (screening through pivotal inclusion under uncertainty creates non-convexity that makes information strategically productive---new). A sentence such as "Prior work has argued that powerful states benefit from consensus through informal influence [Steinberg] or legitimacy [Ikenberry]. This paper identifies a distinct channel: consensus creates the strategic environment in which private information becomes a source of distributional advantage" would help.

3. **Clarify the entry-BP interaction intuitively.** The proof of Theorem 2 handles the disconnected entry set technically (B.8), but the paper would benefit from a short intuitive explanation of why the single-crossing result survives disconnectedness. The key insight---that the unanimity concave envelope starts from the origin and must eventually dominate the majority line because v(mu, U) > v(mu, M) at every entry point---could be stated in plain English before the theorem.

4. **Consider a one-round benchmark in an appendix.** Derive the screening jump, conditional dominance, and single-crossing result in a one-round model. This would (a) show that the mechanism is robust to the bargaining structure, (b) provide a simpler entry point for readers who find the two-round derivations heavy, and (c) clarify exactly what the second round adds.

5. **Push the counter-intuition harder.** The paper could note more forcefully that even within the model, unanimity is worst for H when there is no uncertainty (mu = 1): the screening rent is zero, and the cost of buying all votes is highest. The mechanism works precisely because uncertainty is present, and unanimity makes uncertainty valuable. This sharpens the insight: consensus is not generically good for powerful states; it is good precisely when information is asymmetric and the prospects of cooperation are uncertain.

6. **Consider discussing what "information" means in practice.** The model assumes H observes theta (the value of cooperation). In the WTO application, this corresponds to knowing the distributive consequences of proposed agreements. The paper could be more specific about what kind of information the hegemon has: is it about the aggregate gains from a tariff schedule, about the distribution of gains across members, or about the long-term implications of rule changes? Different interpretations have different empirical implications and different degrees of plausibility.

7. **Address the commitment assumption more directly.** The Bayesian persuasion results rest on the hegemon's ability to commit to an information structure before observing theta. The scope section discusses this (reputation, institutional transparency rules, upper-bound interpretation), but the discussion is somewhat defensive. A more direct approach: state that Theorems 1 and 2 are about the conditional comparison (which does not require BP commitment at all), and that BP amplifies the result by extending it below the entry threshold. The conditional dominance result (Lemma 1) is entirely commitment-free, and this should be emphasized as the paper's primary contribution, with BP as a natural extension.
