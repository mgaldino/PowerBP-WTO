# Theoretical Framing Diagnosis: Informational Power Through Pivotality: How Consensus Can Benefit a Hegemon

**Version read:** `formal_model_v6.Rmd`, commit `8ce59e5fdd463914ff3ce19dd868a5b6d7746866`, SHA-256 `34082366207b4f9571179cef324da593430121853dc314ea1c3933858ba0070b`. The worktree was clean when inspected. These live bytes differ only in the abstract from the reviewed Goal 5 snapshot at commit `b5fdefb1f80090b8da893bf19e754915d557502a` (Rmd SHA-256 `32b49f7503caac34cdf225f73d7e76ab60d1340937b095e3e611f009030f8744`); the current version should therefore not be described as covered by those earlier PASS reviews.

---

## 1. Research-question diagnosis

### Current question

> “We address a narrower theoretical puzzle: when can consensus advantage a hegemon over majority despite equal votes and no hegemonic agenda control, and when does that advantage arise from private information rather than veto power alone?” (`formal_model_v6.Rmd`, lines 52–56)

### Problem identified

The quoted question is close to the model, but the preceding three-part question asks why a hegemon accepts no agenda control, a stricter rule, and consensus (lines 47–52). Because the rule is fixed, the paper cannot explain institutional adoption or acceptance. That opening creates a choice-theory promise that the model immediately withdraws.

“Advantage” is also underspecified. The manuscript contains three distinct objects: the direct private-information payoff comparison across rules, informational rent within each rule relative to public information, and the difference between those rents. They need not have the same sign. In particular, a positive high-type component of `Delta RI` can arise even when the high type obtains no direct payoff gain from consensus.

Finally, the most informative result is hidden by the generic word “hegemon.” In the equilibrium cells where consensus produces a direct gain, that gain accrues to the low-disagreement type whose strength is overestimated. The high-disagreement type's direct consensus-minus-majority payoff is never positive.

### Suggested reformulated question

> When does making a privately informed actor’s approval non-substitutable allow that actor to monetize information that majority rule would otherwise discipline through coalition substitution?

### Justification for the reformulation

This question matches the fixed-rule comparison, travels beyond OPEC and the WTO, and names the paper's genuinely distinctive object: institutional substitutability. It also invites the key distributional follow-up—*which type receives the rent?*—without promising endogenous rule choice. The IO application then becomes: formal equality can coexist with asymmetric informational power because consensus makes one actor’s approval indispensable.

---

## 2. Epistemic positioning: generate or test theory?

### Diagnosis of the current state

This is a formal theory paper. OPEC and the WTO are explicitly illustrations, not tests (lines 761–784), and there is no empirical estimand or identification design. The manuscript is appropriately candid about that, but it sometimes borrows a design-of-institutions motivation that exceeds its formal object.

### Recommendation: Theory generation through a disciplined mechanism comparison

### Detailed justification

1. **Theoretical maturity of the field.** The components are mature: legislative bargaining, veto power, private disagreement values, and dynamic bargaining under one-sided information. Moreover, two very close recent papers already compare majority and unanimity under incomplete information. [Piazolo and Vanberg (2025)](https://doi.org/10.1016/j.geb.2025.07.010) show that responders are more expensive under unanimity because rejection can signal a high disagreement value; [Glynia, Thum, and Xefteris (2026)](https://doi.org/10.1007/s11127-026-01383-9) show in a one-shot setting that incomplete information can reverse conventional rankings of transfers and passage. The paper therefore should not claim a first theory of unanimity under private information. Its contribution is the hierarchical IO application, the removal of hegemonic agenda power, the substitutability comparison, and the explicit private-versus-public rent decomposition.

2. **Strength of the design.** The formal design is strong for isolating a mechanism: identical primitives, fixed pie, only weak-state proposers, and the rule changing only the quota. The proof evidence supports conditional equilibrium claims. It does not constitute an empirical test of OPEC, the WTO, hegemonic decline, or institutional selection.

3. **Properties of the cases.** OPEC and the WTO are useful motivating settings because they combine formal equality with material hierarchy. They cannot adjudicate the mechanism without process evidence on proposals, substitutable coalitions, private disagreement values, and alternative sources of influence.

4. **Structure of the evidence.** There is no case-plus-cross-national hybrid. The paper should present cases after the mechanism as disciplined illustrations and derive observable implications for later work.

5. **Marginal contribution.** The highest-value contribution is not a new screening technology. It is the claim that voting rules structure a market for approval: majority preserves substitutes for an informed vote, while consensus removes them. That institutional difference determines whether private strength can be monetized even when the informed actor never proposes.

### Implications for the paper’s structure

- **Claims:** assertive about the formal conditional result; restrained about real institutions and endogenous design.
- **Sections:** puzzle → negative-control public benchmark → substitutability mechanism → type-specific result → limits/applications.
- **Qualitative evidence:** illustration and scope mapping, not process tracing.
- **Conclusion:** a mechanism and its boundary conditions, followed by an agenda for endogenous choice and empirical testing.

---

## 3. Reconstructed theoretical argument

### 3a. Key concepts requiring refinement

| Concept | Definition in the paper | Problem | Suggested definition | Source |
|---|---|---|---|---|
| Hegemon | One privately informed actor with positive type-dependent disagreement payoff | The label implies material contribution, coercion, or agenda power, all excluded from the baseline | In the theorem, “privately informed pivotal actor”; in the IO interpretation, “hegemon” is a scope mapping requiring private disagreement information and potentially indispensable approval | Manuscript, lines 143–170 and 786–794 |
| Disagreement payoff | `o_theta`, also called outside option, reservation value, and threshold | These are not interchangeable; `beta o_theta` is an R1 threshold, while `o_theta` is the primitive terminal disagreement payoff and also the payoff upon R1 exclusion | Use “terminal disagreement payoff” for `o_theta`; reserve “acceptance threshold” for its date-specific implication | Manuscript, lines 146–149, 191–197, 301–306 |
| Pivotality | A vote can change passage | The sellable mechanism is not pivotality alone but *non-substitutability*: whether another coalition can replace the informed vote | “Institutional non-substitutability of approval”: no feasible passing coalition can bypass the actor | [Winter (1996)](https://doi.org/10.2307/2945844); manuscript, lines 72–79 |
| Informational rent | `RI_g = V_g^priv - V_g^pub` | Readers may mistake it for the direct payoff difference across rules or for payoff above `o_theta` | The payoff increment caused by privacy within a fixed rule, holding primitives and the public-type counterfactual constant | Manuscript, lines 572–586 |
| Institutional informational-rent contrast | `Delta RI = RI_U - RI_M` | A positive component need not mean the type directly prefers unanimity | The rule-induced difference in the *effect of privacy*, distinct from `V_U^priv - V_M^priv` | Manuscript, lines 574–586 |
| Veto power | Unanimity makes approval necessary under complete information | Necessity exists, but under the current agenda and timing it does not yield a positive payoff premium to the hegemon | Call this the “complete-information institutional effect”; report its sign before calling it power | Public benchmark, lines 308–327 |
| Essential input | The hegemon’s vote has no substitute under unanimity | “Input” can be misread as material capability or productive contribution | An essential *approval input*: indispensable to passage, while material contribution is fixed out | Manuscript, lines 72–79 and 724–737 |

### 3b. Causal mechanism

**Channel proposed by the paper:**

The rule changes the substitutability of the informed actor’s vote. Under majority, a weak proposer can buy an additional uninformed weak-state vote and pass without the hegemon, capping the price of hegemonic approval. Under unanimity, bypass is impossible. Rejection can then raise the continuation price by making the high-disagreement type more likely, so the low-disagreement type wants to imitate the high type. Where a pure equilibrium exists at high beliefs, the proposer pools at the high threshold and overpays the low type by the entire discounted type gap.

**Channels identified in the literature:**

- **Channel 1: Voting-rule substitutability under private information**
  - Logic: majority permits exclusion; unanimity makes every responder indispensable.
  - Evidence: Piazolo and Vanberg derive signaling incentives and greater responder expense under unanimity; their [laboratory companion](https://doi.org/10.1016/j.jebo.2025.107171) supports the positive signaling incentive under unanimity, though several majority predictions receive mixed behavioral support.
  - Relevance: **very high**. This is the closest mechanism family and must receive explicit differentiation.
  - Distinguishable from this paper’s channel? **Only narrowly**: the present model has one structurally distinct informed hegemon, no hegemonic proposal power, and an explicit rent decomposition.

- **Channel 2: Dynamic bargaining, signaling, and reputation**
  - Logic: an informed responder rejects to influence future beliefs and offers; screening, pooling, delay, and mixing are standard dynamic responses.
  - Evidence: [Sobel and Takahashi (1983)](https://doi.org/10.2307/2297673) and Fudenberg, Levine, and Tirole (1985) establish the broader bargaining logic.
  - Relevance: **high**. The paper’s pooling and pure-strategy nonexistence should be positioned inside, not outside, this literature.
  - Distinguishable? **Yes**, through the cross-rule availability of a coalition substitute.

- **Channel 3: Complete-information veto power**
  - Logic: a necessary vote can receive distributive rents even without private information.
  - Evidence: [Winter (1996)](https://doi.org/10.2307/2945844), Miller, Montero, and Vanberg (2018), and [Nunnari (2021)](https://doi.org/10.1016/j.geb.2020.11.006).
  - Relevance: **high as a benchmark**, not as the paper’s contribution.
  - Distinguishable? **Yes**: the public-type games isolate this component.

- **Channel 4: Agenda and persuasion power**
  - Logic: proposal rights, drafting, or information design let an agenda setter shape what is voted on.
  - Evidence: Kalandrakis (2006), McCarty (2000), [Bardhi and Guo (2018)](https://doi.org/10.3982/TE2834), and [Kim, Kim, and Van Weelden (2025)](https://doi.org/10.1111/ajps.12914).
  - Relevance: **high as an excluded alternative**.
  - Distinguishable? **Yes**: the hegemon never proposes or designs information.

- **Channel 5: Outside-option and informal structural power**
  - Logic: powerful states obtain concessions through exit, material resources, coercion, or “go-it-alone” capacity even when their strength is public.
  - Evidence: [Gruber (2000)](https://www.jstor.org/stable/j.ctt7s8w1), [Stone (2011)](https://doi.org/10.1017/CBO9780511793943.003), and [Steinberg (2002)](https://doi.org/10.1162/002081802320005504).
  - Relevance: **high for IO positioning**.
  - Distinguishable? **Yes in the model** through the public benchmark; difficult in field data without process evidence.

- **Channel 6: Endogenous institutional choice, legitimacy, and compliance**
  - Logic: states select unanimity to solve enforcement, distribution, legitimacy, or participation problems.
  - Evidence: [Koremenos, Lipson, and Snidal (2001)](https://doi.org/10.1162/002081801317193592) and [Maggi and Morelli (2006)](https://doi.org/10.1257/aer.96.4.1137).
  - Relevance: **medium as the motivating literature, outside the baseline game**.
  - Distinguishable? **Yes formally** because the rule is fixed; not automatically in observational evidence.

- **Channel 7: Information aggregation**
  - Logic: multiple voters aggregate dispersed signals about a common state.
  - Evidence: Feddersen and Pesendorfer (1998) and [Bouton et al. (2024)](https://doi.org/10.1093/jeea/jvae035).
  - Relevance: **low except as a contrast**.
  - Distinguishable? **Yes**: weak states have no private signals; the outcome is a transfer/rent, not decision accuracy.

**Critical assessment:**

The manuscript occasionally conflates a structurally necessary vote with a positive distributive return to veto power. Under its own public benchmark, `V_U^pub - V_M^pub` is zero when majority includes the type and negative when majority excludes it. The benchmark should therefore be presented as a negative control: public indispensability alone does not make consensus pay more under weak-state agenda control. The surprising result is that private information can reverse that comparison for the low-disagreement type.

The manuscript must also separate the direct institutional payoff effect from `Delta RI`. The claim that consensus “benefits the high type” is misleading when the direct high-type payoff is unchanged and only the benchmark-adjusted informational component is positive.

**Suggested restructuring of the mechanism:**

1. **Identification:** hold agenda, pie, players, and disagreement values fixed; vary only whether the informed vote has a substitute.
2. **Negative control:** with public information, consensus produces no positive hegemonic payoff premium.
3. **Information channel:** when approval is indispensable, rejecting a low offer can improve beliefs and continuation terms, making cheap separation unstable.
4. **Distributional result:** pooling pays the high threshold to both types, so the overestimated low-disagreement type captures `beta(o_1-o_0)`; the high type does not obtain a direct consensus premium.
5. **Boundaries:** majority pooling erases the contrast, exclusion makes the sign conditional, and the intermediate-belief cell is undefined under pure ballot strategies.

### 3c. Mechanism-to-estimand connection

There is no empirical ATT, ATE, LATE, or CATE. The formal target objects are:

- `RI_g`, the effect of private rather than public information within rule `g`;
- `Delta RI`, the difference in that privacy effect between unanimity and majority;
- separately, `V_U^priv - V_M^priv`, the direct institutional payoff contrast.

`Delta RI` isolates the information channel but is not the total payoff effect of consensus. This distinction is mathematically present but not narratively salient. A claim that a type “benefits from consensus” should be tied to the direct contrast; a claim about “more informational power under consensus” should be tied to `Delta RI`.

---

## 4. Scope conditions derived from the estimand

### Estimand identified

The componentwise correspondence `Delta RI = (V_U^priv - V_U^pub) - (V_M^priv - V_M^pub)`, preserving empty sets and linked multiplicity.

### Implicit target population

Institutional bargaining environments with one privately informed, potentially indispensable responder; divisible concessions; public proposals and ballots; and a feasible substitute coalition under majority but not unanimity. OPEC and the WTO are candidate applications, not the target population itself.

### Scope conditions derived from the estimand

1. **Same primitives across counterfactuals** — otherwise the rent difference does not isolate information.
2. **Fixed institutional rule within each game** — the object does not include selection into rules.
3. **Type-contingent payoffs** — aggregation across types is not the reported baseline object.
4. **Existence under the maintained concept** — if a source correspondence is empty, the rent or contrast is empty.
5. **Two-round, pure-ballot PBE with declared belief and pivotality disciplines** — the result does not automatically extend to mixed ballots or longer horizons.
6. **No hegemonic proposal power, fixed unit pie, and zero intrinsic agreement benefit** — these isolate approval rents from agenda and productive power.

### Scope conditions that should be explicit in the theory

1. **Coalition substitutability under majority** — weak votes must be purchasable alternatives to hegemonic approval.
2. **Private information about the actor’s own acceptance/disagreement value** — not dispersed information about policy quality.
3. **Public observability across rounds** — the informed vote can affect beliefs and continuation offers.
4. **No alternative side-payment technology** — external inducements could recreate substitutes under consensus.
5. **The hegemon’s material contribution is not essential** — only its approval is; real-world applications must separate these channels.
6. **Timing of exclusion and disagreement payoffs** — the sign under majority exclusion depends on when `o_theta` is realized.

### Coherence test

The formal scope is internally coherent and unusually explicit. The main framing mismatch is external: “hegemon” evokes capabilities and institutional design, while the model isolates a privately informed responder. The second mismatch is the opening rule-choice question. Neither requires changing the model; both require narrowing the claim. The dual role and timing of `o_theta` should be acknowledged because it is load-bearing for signs under exclusion.

---

## 5. Suggested hypotheses

| # | Hypothesis | Logical derivation | Testable with the paper’s design? | Available evidence |
|---|---|---|---|---|
| H1 | With public disagreement values, unanimity gives the hegemon no positive payoff premium over majority under weak-state agenda control | The proposer buys the known type at its discounted threshold; majority can instead exclude expensive types | Yes, formally | Proposition 1 |
| H2 | Above the unanimity pooling cutoff, the low-disagreement type captures the entire discounted type gap `beta(o_1-o_0)` | Non-substitutability prevents a cheap separating offer from surviving; pooling uses the high threshold | Yes, formally | Propositions 4 and 6 |
| H3 | The low-type informational-rent advantage is positive when majority screens, zero when majority already pools, and conditional under exclusion | Majority’s substitute changes its equilibrium class and price cap | Yes, formally | Propositions 5–7 |
| H4 | The high-disagreement type receives no positive direct payoff gain from consensus | Unanimity pays `beta o_1`; majority pays `beta o_1` or `o_1` | Yes, formally | Propositions 4–5 |
| H5 | Within a pooling cell, the low-type rent grows with patience and the gap between possible disagreement values | The rent is `beta(o_1-o_0)` | Yes, locally/formally | Closed-form result |
| H6 | For intermediate beliefs, the unanimity game has no PBE in pure ballot strategies under the maintained disciplines | Every pure type-contingent response fails after a feasible proposal | Yes, within scope | Proposition 4 and Appendix B.4 |
| H7 | Empirically, opacity about a non-substitutable actor’s disagreement value should raise concessions relative to comparable settings with replaceable approval | Translation of H2–H3 | No, not with the current paper | Future empirical design |

### Hypotheses the paper should test but does not

For the present paper, these are future-work questions rather than missing baseline tests: ex ante rule preference, weak-state welfare and gridlock, robustness to mixed ballot strategies, productive hegemonic contribution, and endogenous rule choice. None should be imported into the current baseline without a separately authorized formal extension.

---

## 6. Theory–evidence consistency diagnosis

| # | Claim in the paper | Evidence mobilized | Verdict |
|---|---|---|---|
| 1 | Consensus can benefit a hegemon without agenda control | Direct private payoff correspondences | **Suggests** — true conditionally for the low-disagreement type, not generically for the hegemon |
| 2 | Unanimity “adds veto power” under complete information | Public benchmark | **Does not support** a positive payoff premium; it supports structural necessity, with a zero or negative payoff difference |
| 3 | Private information creates an additional institutional advantage | `RI_U`, `RI_M`, and `Delta RI` | **Supports**, conditional on type, majority class, and existence |
| 4 | The high type can be “benefited” in the positive `Delta RI` cell | Benchmark-adjusted rent contrast | **Does not support** as a direct payoff claim; the direct high-type rule contrast is zero there |
| 5 | The private threshold shapes the unanimity proposal | Pooling and nonexistence results | **Suggests** — the high threshold shapes pooling; the model does not deliver separating proposals in the interior |
| 6 | OPEC and WTO illustrate the mechanism | Short institutional discussions | **Suggests** only plausibility; there is no field test distinguishing information from agenda, material, or informal power |
| 7 | The empty cell represents institutional instability under contested decline | Pure-strategy nonexistence | **Does not support** as a real-world claim without additional theory or evidence; it is a solution-concept-specific boundary |

**Verdict legend:**

- **Supports**: directly established by the formal comparison.
- **Suggests**: consistent but conditional, interpretive, or externally untested.
- **Does not support**: exceeds or misstates the formal object.

### Claims that need moderation

- Replace “unanimity adds veto power” with: “unanimity makes approval necessary, but under weak-state agenda control that necessity alone creates no positive payoff premium.”
- Replace generic “a hegemon benefits” with: “an overestimated, low-disagreement hegemon can benefit.”
- Replace “also benefits the high type” with: “raises the high-type informational-rent contrast relative to a negative public benchmark, without raising its direct payoff.”
- Keep endogenous institutional adoption as a motivating question for future work, not as the paper’s explained outcome.

### Underused evidence

The manuscript underuses four powerful facts already in its results:

1. the public-information rule contrast is a negative control, not a positive veto premium;
2. the low type captures the full discounted type gap under unanimity pooling;
3. in the worked example, the low type receives `0.315` under unanimity versus `0.10` under majority, and `Delta RI` is `0.215`;
4. direct payoffs, within-rule rents, and the rent contrast can point in different directions.

These facts can replace much of the cell-by-cell prose with a single contribution narrative.

---

## 7. Alternative explanations

| # | Alternative explanation | Addressed? | How the design handles it | Sufficient? | Suggestion |
|---|---|---|---|---|---|
| 1 | Strong public outside option | Yes | Public benchmark and same `o_theta` across information regimes | Mostly | Present it as the control, not the informational mechanism |
| 2 | Hegemonic agenda power | Yes | `H` never proposes | Yes formally | Make this exclusion a contribution, not merely a limitation |
| 3 | Material contribution to the agreement | By restriction | Fixed pie and `b_theta=0` | Yes for isolation; limited externally | Say “essential approval input,” not materially essential actor |
| 4 | Endogenous rule choice or strategic restraint | No | Rule fixed | No for the opening design question | Move to conclusion/future extension |
| 5 | Informal coercion, drafting, or vote buying | No | Excluded from action space | No empirically | Use Stone, Steinberg, and aid/vote-buying work as rival mechanisms |
| 6 | Information aggregation or persuasion | Yes by information structure | Weak states have no private signals; H does not design information | Yes formally | Explain the contrast explicitly |
| 7 | Mixed-strategy skimming in dynamic bargaining | No by solution concept | Pure ballots only | No beyond baseline scope | Treat the empty cell as a boundary, not a substantive decline prediction |
| 8 | Timing/calendar effect under exclusion | Partially | `o_theta` is realized when majority passes without H | Formally explicit but narratively underdeveloped | Flag its role in signs under exclusion |
| 9 | Legitimacy or compliance benefits of unanimity | No | Passage payoff does not depend on breadth of support | No externally | List as a separate mechanism for future empirical discrimination |

---

## 8. Literature gaps

### Literature engaged but insufficiently

| Cited reference | Current use | How it should be used |
|---|---|---|
| Miller, Montero, and Vanberg (2018) | Called a benchmark for “heterogeneous voting rules” | Correct to heterogeneous disagreement values—the exact primitive privatized here |
| Piazolo and Vanberg (2025) | Named as close, without differentiation | State their result—responders become more expensive under unanimity through signaling—and distinguish one hegemon, no proposal power, and the rent decomposition |
| Glynia, Thum, and Xefteris (2026) | Named as a one-shot neighbor | State that uncertainty can reverse conventional transfer and passage rankings; distinguish the dynamic, hierarchical, type-contingent object here |
| Koremenos, Lipson, and Snidal (2001) | Generic complementarity | Use to delimit the paper: they explain institutional design; this paper explains distributional consequences conditional on a rule |
| Steinberg (2002) and Stone (2011) | Broad informal-power motivation | Treat agenda control, material power, and informal governance as rival mechanisms deliberately switched off |
| Feddersen and Pesendorfer (1998) | Grouped with bargaining | Use only as the contrast between dispersed-signal aggregation and one actor’s private disagreement value |

### Relevant literature absent from the manuscript

| Reference | Relevance to the argument |
|---|---|
| [Maggi and Morelli (2006)](https://doi.org/10.1257/aer.96.4.1137) | Canonical formal treatment of unanimity versus majority in self-enforcing IOs; clarifies that rule choice is a distinct question |
| [Gruber (2000)](https://www.jstor.org/stable/j.ctt7s8w1) | “Go-it-alone power” is the clean outside-option alternative to informational power; already present in `references.bib` but uncited |
| [Sobel and Takahashi (1983)](https://doi.org/10.2307/2297673) and Fudenberg, Levine, and Tirole (1985) | Place pooling, screening, and pure-strategy difficulties inside dynamic bargaining with one-sided information |
| McCarty (2000) and [Kim, Kim, and Van Weelden (2025)](https://doi.org/10.1111/ajps.12914) | Separate veto bargaining and persuasion/agenda power from responder-held private information |
| [Bardhi and Guo (2018)](https://doi.org/10.3982/TE2834) | Contrasts informational persuasion toward unanimous consent with rent extraction by an informed responder |
| [Daßler, Heinkelmann-Wild, and Huysmans (2025)](https://doi.org/10.1093/isq/sqae146) | Shows that IO veto and exit safeguards can insure weak states, disciplining any broad claim that consensus favors hegemons |
| [Sommerer et al. (2022)](https://doi.org/10.1007/s11558-021-09445-x) | Links majoritarian pooling to IO decision output, useful for the efficiency trade-off outside the current payoff focus |

The key positioning sentence should be explicit: the paper is not first on private information under unanimity; it is a theory of how *institutional substitutability of one hierarchically distinct actor’s vote* changes the rents from that actor’s private disagreement value when the actor has no agenda power.

---

## 9. Suggested revision roadmap

### High priority (the paper does not advance without this)

1. **Lead with the fixed-rule question.** Remove the three-part endogenous-design question from the opening or move it to the conclusion. The paper explains consequences of a given rule, not its adoption.
2. **Make the overestimated type the protagonist.** State in title, abstract, introduction, synthesis result, and conclusion that the direct gain goes to the low-disagreement hegemon pooled with the high type.
3. **Turn the public benchmark into a negative control.** Say that complete-information indispensability yields no positive hegemonic payoff premium under weak-state agenda control; private information is what can reverse the ranking.
4. **Separate the three payoff objects.** Use distinct verbal labels for direct private payoff contrast, within-rule informational rent, and `Delta RI`. Never describe a positive `Delta RI` component as a direct payoff benefit without checking the first object.
5. **Replace the catalogue with a synthesis.** Organize existing propositions around four statements: public control; substitute versus essential approval; low-type pooling rent; zero/reversal/empty boundaries. This is exposition, not new formal content.
6. **Differentiate the nearest papers.** Give Piazolo–Vanberg and Glynia–Thum–Xefteris one full sentence each: what they model, what they find, and what this paper uniquely isolates.
7. **Rewrite the live abstract from a controlled baseline.** The current post-review abstract (lines 31–32) contains visible typos and removes the sharp “essential input” language. It should not be treated as the reviewed Goal 5 text.

**Recommended title:** *Informational Power Through Pivotality: When Consensus Rewards an Overestimated Hegemon*.

**More general alternative:** *The Informational Value of an Indispensable Vote*.

### Medium priority (substantially strengthens the paper)

1. **Put one memorable magnitude in the introduction.** The worked example’s `0.10` versus `0.315` communicates the result better than a list of vectors.
2. **Derive observable implications without claiming a test.** The distinctive empirical interaction is uncertainty about the hegemon’s disagreement value × absence of a substitute coalition.
3. **Clarify why “hegemon” is appropriate.** State that the baseline isolates approval power; finance, productive capacity, coercion, and agenda control are deliberately excluded rival channels.
4. **Consolidate scope language.** One clear paragraph is stronger than repeated warnings about calibration, empty cells, and unattained Cartesian products.
5. **Keep pure-strategy nonexistence in proportion.** If the solution concept remains fixed, present it as a boundary of the baseline and avoid using it as evidence of historical hegemonic decline.
6. **Move knife-edge multiplicity to the appendix.** The `o_1=1/m` segment demonstrates rigor but should not organize the contribution.

### Low priority (nice to have)

1. Use the OPEC and WTO paragraphs to specify what process evidence would distinguish informational rents from agenda power, material indispensability, or vote buying.
2. Rename “difference of differences” to “net informational-rent contrast” to avoid an empirical DiD association.
3. Retain only figures that advance the substitute/essential-input narrative or visualize the type-specific payoff result.

### What NOT to change

- Do not reintroduce hegemonic proposal power, type-dependent pie size, immediate opt-out, or endogenous rule choice merely to make the story more intuitive.
- Do not erase the empty correspondence, interpolate payoffs, or add mixed ballots without a separately authorized derivation and review cycle.
- Do not collapse type-contingent vectors into an average in the baseline.
- Do not turn OPEC or the WTO into alleged empirical tests.
- Preserve the same-primitives comparison and the public-information benchmark; they are the identification strategy of the theory.

---

## 10. Synthesis: insight, mechanism, cut

### Core insight (one sentence)

> Consensus creates informational power not by rewarding strength itself, but by making an informed actor’s approval non-substitutable, allowing a hegemon whose strength is overestimated to be paid as if it were strong even without agenda control.

### The simple but interesting mechanism

> Majority gives proposers a way to buy around the hegemon, which caps the price of its approval. Consensus removes that substitute; rejection can improve the inferred type and the next offer, so cheap screening becomes unstable and, where a pure equilibrium exists, the proposer pools at the high threshold. The informational rent then accrues to the low-disagreement type, not to the genuinely high type.

### What should be removed from the framing

- **The opening promise to explain why the hegemon chooses or builds consensus** — the rule is fixed.
- **The generic claim that consensus benefits “the hegemon”** — the direct gain is type-specific.
- **Positive-payoff language about the complete-information veto component** — structural necessity does not generate a positive premium in this baseline.
- **Any statement that a positive high-type `Delta RI` means a direct high-type payoff gain** — it can reflect subtraction of a negative public benchmark.
- **A hegemonic-decline narrative built from the empty pure-strategy cell** — it exceeds the maintained solution concept.
- **Long body treatment of knife-edge multiplicity and repeated defensive caveats** — they dilute the main mechanism.
- **Undifferentiated citations to rational design, informal power, and the two closest incomplete-information papers** — each should clarify a distinct channel or boundary.

