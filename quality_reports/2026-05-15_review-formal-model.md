# Editorial Letter - Formal Model Review

**References**: Thomson (1999), Board & Meyer-ter-Vehn (2018), Dixit (2015), Varian (1997/2016)

## Decision: R&R major

## Consolidated Scores

| Dimension | Score | Rating |
|---|---:|---|
| Model design | 8/10 | Strong |
| Technical presentation | 7.5/10 | Good but needs tightening |
| Exposition | 8/10 | Strong but too heavy |
| **Global** | **7.8/10** | **Promising major revision** |

## Editorial Synthesis

The manuscript has a strong and publishable conceptual core: consensus can benefit a powerful privately informed actor not by giving it agenda power, but by making its participation threshold pivotal. The model's best design choice is the weak-state-agenda baseline with `pi_H=0`, which sharply separates proposal power from pivotality-based informational power. All three reviewers agree that the main mechanism is clear, politically interesting, and well motivated by the OPEC-style illustration.

The main weakness is not the idea. It is the presentation burden created by the current architecture. The manuscript now carries many scope conditions, derived thresholds, diagnostic tables, and caveats around the weak-vote-passive assessment. These are mostly defensible, but they make the paper feel closer to a carefully repaired proof dossier than a streamlined top-journal theory article. The paper should now be revised less as a proof-repair exercise and more as a final presentation of a clean model.

## Hierarchy Applied: Design > Presentation > Exposition

The design is strong enough to justify serious investment in revision. The bottleneck is not contribution or mechanism isolation. The bottleneck is technical presentation: the model definition is overloaded, notation is locally dense, assumptions are scattered, and the main R1 result arrives late and with a long list of conditions. Exposition reinforces the same issue: the introduction and examples are strong, but the main text spends too much space defending boundary cases and documenting robustness diagnostics.

Because the design is strong, this is not a reject-and-redesign decision. It is a major revision focused on compression, assumption mapping, notation cleanup, and a clearer division between the core mechanism and supporting diagnostics.

## Revision Priorities

1. Add a short "Baseline Domain" table immediately after the model. List Threshold Order, No-Cheap-H, High-Posterior Pooling, R1 Dynamic Threshold Order, and weak-vote-passive assessment, with columns for role and result used in.

2. Split the main model definition into primitives/preferences, proposal and voting protocol, and entry protocol. The current Definition 1 is complete but too dense.

3. Reduce notation collisions. In particular, avoid using `R` both as a rule variable and as the rejection candidate; rename the no-information rejection candidate to `D`, `W`, or `Wait`. Rename `H_K(mu)` to something like `V_{H,K}^U(mu)`.

4. Make the minimal mechanism dominant in the main text: private thresholds + fixed-pie packages + hegemon pivotality. Entry and institutional classification should be presented as the payoff/formation layer built on that core, not as part of the irreducible mechanism.

5. Compress the main-body diagnostics. Keep the motivating example, the core propositions, the main OPEC-style classification, and the most informative figure/table. Move robustness windows, classification sweeps, and repeated boundary caveats to the appendix.

6. Consider adding or foregrounding an interior numerical example in which `P`, `L`, and `R` are all visibly live. Keep the OPEC-style illustration, but do not let the boundary `a_0(1)=a_1` example carry the full burden of explaining the R1 geometry.

## Strategic Recommendation To The Author

Revise for a top-field or strong general political science outlet if the target audience is receptive to formal theory. The paper's conceptual move is real and worth pursuing: it isolates a politically important channel that is distinct from agenda control and self-binding. The revision should not expand the model. It should reduce the visible load of the current architecture, move proof containment into the appendix, and make the paper read like a clean theory contribution rather than a record of all repaired branches.

---

## Full Review - Model Design

# Model Design Report (Dixit / Varian / Board)

## Score: 8/10

## The Model In One Sentence

A fixed-pie bargaining model in which weak states hold proposal power, but unanimity makes a privately informed hegemon pivotal, forcing weak proposers to choose between pooling, testing the low-threshold type, or delaying, while majority can remove the hegemon from the winning coalition under a No-Cheap-H condition.

## Contribution Type (Board & Meyer-ter-Vehn)

The main contribution is a new lens plus an isolated political force: consensus can generate power through pivotality-based screening even without hegemonic agenda power. It is not mainly a technical contribution. Its value comes from separating outside-option power, veto/pivotality power, and proposal power in a way that speaks to institutional design and informal power in IOs.

## Evaluation By Dimension

### MD1. Question Quality: Excellent

The question is politically genuine and easy to state: why might a powerful state prefer consensus when majority seems to offer more control? This passes the Varian interest test. A non-specialist can understand the puzzle: unanimity gives every state a veto, yet the hegemon may still benefit.

The manuscript also answers "why should I care?" better than most formal drafts: the OPEC interpretation makes the mechanism concrete, and the literature section clearly distinguishes the paper from self-binding and informal agenda-control accounts. The main caveat is that the paper should keep stressing that this is not a claim about endogenous rule choice; it is a conditional institutional comparison.

### MD2. Simplicity And KISS: Adequate

The strongest KISS choice is setting `pi_H=0`. That is a disciplined and useful simplification: if the hegemon benefits even without proposal power, the mechanism cannot be agenda control. The fixed-pie relative-package structure is also a major improvement over a feasibility-based transfer architecture because it keeps the bargaining object feasible in every state.

Still, the model is no longer extremely simple. The reader must absorb two rounds, entry, majority versus unanimity, binary types, dynamic thresholds, weak-vote-passive beliefs, No-Cheap-H, R1 candidate selection, and formation sets. These components mostly do analytical work, but the design is near the upper bound of what a clean theory paper should carry.

The Schelling-Spence test is mostly passed: remove private thresholds or pivotality and the mechanism disappears. Remove entry, however, and the central informational-power result survives. Entry is useful for institutional classification, but it is not essential to the core mechanism.

### MD3. Mechanism Isolation: Excellent

The central mechanism is sharply isolated: unanimity makes `H`'s approval necessary; `H` privately knows its participation threshold; weak proposers must pay an informational rent when they pool types. Majority removes that screening channel when weak states can form without `H` and `H` is not cheaper than a weak voter.

The design's best feature is the separation of proposal power from pivotality. That is exactly the kind of stark assumption Dixit would endorse: `pi_H=0` is unrealistic in many real organizations, but it clarifies the force being studied.

The main residual vulnerability is the weak-vote-passive assessment. It is defensible and clearly scoped, but it is a maintained protocol interpretation rather than an unrestricted equilibrium characterization. That does not destroy the design, but it means the paper's conceptual claim should always be phrased as "under this public-voting assessment," not as a fully general property of consensus bargaining.

### MD4. Richness Of Insights: Rich

The model generates more than the baseline answer. It shows that consensus can help the powerful actor only conditionally; majority can be better; weak-state entry under unanimity is nested in majority; and the key comparison depends on the payoff gap `Delta_H(mu)`. That is richer than a simple "consensus helps hegemon" result.

The insight is transferable. The same logic can apply to climate clubs, cartel governance, security councils, lending institutions, or any organization where one actor's participation threshold is privately known and institutionally pivotal.

The most interesting comparative insight is the separation between institutional viability for weak states and institutional preference for `H`. Consensus can generate rents for `H` but still be harder to form. That trade-off is politically meaningful.

The weak point is that the working numerical illustration lies on the boundary `a0(1)=a1`, so strict low-only separation is blocked. This makes the live calibrated example less rich than the general R1 architecture. The paper handles this honestly, but design-wise a nonboundary primary illustration would better display the mechanism's full menu.

### MD5. Contribution Type: New Lens / Isolated Political Force

The paper's strongest contribution is isolating a political force: informational power through pivotality. It also offers a new lens on consensus rules by showing that formal equality can create asymmetric informational rents.

The application to OPEC is important but should remain an illustration unless the paper adds empirical measurement. The paper should not oversell the numerical case as calibration. The technical contribution is secondary; the formal machinery is valuable because it disciplines the argument, not because it introduces a new solution method.

### MD6. Construction Process: Mature

The manuscript looks iterated and refined. It starts with a simple three-state motivating example, then generalizes to the full two-round model. It separates baseline from extensions, explicitly excludes `pi_H>0` and endogenous rule choice, and records scope conditions.

The reproducibility ledger and diagnostic examples also signal mature construction. The author has clearly discovered and contained earlier modeling risks rather than hiding them.

The remaining process issue is architectural compression. The paper now has a clean baseline, but the reader still feels the history of proof repair in the number of caveats. Some of that is necessary, but the main text could more aggressively distinguish "core model" from "equilibrium/proof containment."

## Overall Design Verdict

The design is strong and publishable in concept. The paper asks a real political question, isolates a clean mechanism, and makes a valuable modeling move by stripping agenda power away from the hegemon. The main design risk is not irrelevance; it is that the mechanism is surrounded by enough scope conditions and equilibrium-assessment language that readers may wonder whether the result is fragile. That risk is manageable if the paper keeps the one-round intuition dominant, treats the weak-vote-passive assessment as a protocol condition, and avoids selling the boundary numerical illustration as the main evidence of robustness.

## Constructive Suggestions

1. Make the minimal mechanism even more prominent: one paragraph should say that the irreducible model needs only private thresholds, fixed-pie packages, and `H` pivotality.

2. Consider moving entry language slightly later in the narrative. Entry is useful, but the core contribution is screening through pivotality.

3. Use a nonboundary numerical illustration as the primary diagnostic if possible, so `P`, `L`, and `R` are visibly live away from `a0(1)=a1`.

4. Keep `pi_H=0` as a virtue, not a limitation: it is the stark assumption that proves the result is not agenda power.

5. State the contribution as a conditional institutional classification, not as "consensus benefits hegemons" in general.

---

## Full Review - Technical Presentation

# Technical Presentation Review (Thomson / Board)

## Score: 7.5/10

## Model Structure

The model has one hegemon `H`, `m=N-1` weak states, and Nature drawing a private hegemon type `theta in {0,1}`. Weak states choose collective entry; in each bargaining round a weak proposer chooses a fixed-pie package `(y, x_1,...,x_m)`; states then vote under unanimity or majority. The hegemon privately observes its participation threshold; weak states share prior `mu`. Payoffs combine weak residual surplus and the hegemon's net acceptance payoff `o_theta + y - t_theta`, with dynamic continuation values in Round 1. The equilibrium object is a selected pure-strategy PBE outcome under the maintained weak-vote-passive assessment and a tie-break against `H` among weak-proposer payoff ties.

## Scorecard

| Dimension | Verdict | Comment |
|---|---|---|
| D2. Model presentation | Adequate | Canonical order is mostly respected, but the main definition is overloaded and some domain assumptions appear only when needed later. |
| D3. Notation | Needs improvement | Most notation is mnemonic, but several symbols are overloaded or introduced before they become meaningful. |
| D4. Definitions | Needs improvement | The key definitions are explicit, but too much is packed into Definition 1 and the weak-vote-passive assessment needs a cleaner formal object. |
| D5. Result statements | Adequate | The main results are self-contained, but Proposition R1 carries too many hypotheses and the conditional-comparison proposition is nearly definitional. |
| D6. Proofs | Adequate | Proofs are readable and often stepwise; the R1 proof is strong, but the body needs more proof roadmaps before sending readers to the appendix. |
| D7. Figures and diagrams | Excellent | The paper uses timing, logic, region, payoff-gap, and classification figures with informative captions. |
| D8. Assumptions and logic | Needs improvement | Assumptions are named and motivated, but not collected into a single domain map showing which result uses which condition. |
| D9. Examples and applications | Adequate | The OPEC interpretation is useful, but the main numerical illustration lies on a boundary that blocks strict low-only separation. |

## Detailed Analysis

### D3. Notation

**Diagnosis:** The notation is mostly guessable: `H`, `W`, `mu`, `theta`, `y`, `t_theta`, `beta`, `P/L/R`, and `Delta_H` are good. The main problems are overload and local proliferation. `R` denotes both a rule variable in `R in {U,M}` and the no-information rejection candidate. `H` is both the hegemon and appears in `H_K(mu)` as a payoff function. `C_theta`, `c(nu)`, and `mathcal C` are all different objects. The notation table helps, but the reader meets many objects before Appendix C.

**Impact:** A competent reader can reconstruct the model, but only by tracking several layers of derived notation. This raises the cost of reading the analysis section.

**Concrete suggestion:** Rename the rejection candidate from `R` to `D` or `Wait`, or reserve `R` only for the institutional rule. Rename `H_K(mu)` to `V_{H,K}^U(mu)`. Add a short notation block before the Round 1 proposition with only the objects needed there: `c(nu)`, `a_1`, `a_0(1)`, `Pi_P`, `Pi_L`, `Pi_D`, `mathcal K`.

**Reference:** Thomson Sec. 3: the best notation is notation that can be guessed, and functional dependencies should be dropped only when no ambiguity is created.

### D4. Definitions

**Diagnosis:** Definition 1 does too much: players, proposals, feasibility, residual assignment, thresholds, dynamic acceptance, recognition, voting rules, majority selection, and entry. Definition 2 is substantively crucial but is stated as a list of belief restrictions rather than as a formally typed assessment mapping histories to posteriors.

**Impact:** The model is complete, but the reader cannot easily separate primitives from derived objects, protocol rules, and equilibrium-selection conventions.

**Concrete suggestion:** Split Definition 1 into three parts: primitives and preferences; proposal/voting protocol; entry protocol. Then define the weak-vote-passive assessment as a named assessment `sigma, mu(h)` with five clauses. Keep the interpretation paragraph after it.

**Reference:** Thomson Sec. 4: when defining a new term, make clear what type of object it is and separate formal definition from interpretation.

### D8. Assumptions and Logical Structure

**Diagnosis:** The paper has good named conditions: Threshold Order, Majority Threshold Order, No-Cheap-H, High-Posterior Pooling, R1 Dynamic Threshold Order, weak-vote-passive assessment. But they are scattered across sections, and the reader does not get a single map of which result requires which condition.

**Impact:** The formal architecture is defensible, but readers may experience the conditions as accumulating locally rather than as a controlled baseline domain.

**Concrete suggestion:** Add a "Baseline Domain" table after the model:

| Condition | Role | Used in |
|---|---|---|
| Threshold Order | terminal screening | Lemma R2 |
| No-Cheap-H | majority no-screening | Prop. majority, nesting |
| R1 Dynamic Threshold Order | rules out high-only acceptance | Lemma rejected histories, Prop. R1 |
| Weak-vote-passive assessment | belief discipline | Lemma rejected histories, Prop. R1 |

Also add one early existence example satisfying all maintained conditions.

**Reference:** Thomson Sec. 5 recommends ordering assumptions by generality/plausibility and clarifying logical implication relations.

### D9. Examples

**Diagnosis:** The motivating example is clean, and the OPEC mapping is well chosen. The weakness is that the working numerical illustration has `a_0(1)=a_1`, so strict low-only separation is blocked. The paper acknowledges this, which is good, but the main example does not display all three R1 candidates.

**Impact:** The model's most interesting Round 1 geometry is shown in a diagnostic/non-calibrated example rather than in the headline illustration.

**Concrete suggestion:** Present two examples explicitly: a "clean interior example" for the formal mechanism, with `P`, `L`, and `R` all live; and the OPEC-style boundary illustration as the substantive application.

**Reference:** Thomson favors examples that illuminate the general structure; Board emphasizes that examples should make the takeaway easier, not add qualifications.

## Notation Inventory

| Symbol | Meaning | Introduced in | Used in | Problem? |
|---|---|---|---|---|
| `H` | hegemon | Model | all formal sections | OK, but conflicts slightly with `H_K` |
| `W_i`, `W_p` | weak state, weak proposer | Model | model/proofs | OK |
| `N`, `m=N-1` | total states, weak states | Model | all sections | OK |
| `theta` | hegemon type | Model | all sections | OK |
| `mu`, `nu` | prior/posterior belief | Model/R1 | unanimity/proofs | OK |
| `y`, `bar y` | package, max package | Model | all sections | OK |
| `x_i` | weak allocation | Model | model/proofs | OK |
| `t_theta` | terminal threshold | Model | all sections | OK |
| `o_theta` | external payoff | Model | majority/unanimity | OK |
| `u_H^theta` | H payoff from acceptance | Model | model only | Could be folded into prose |
| `beta` | discount factor | Model | all sections | OK |
| `pi_H` | H recognition probability | Model | scope/extensions | OK |
| `U`, `M` | unanimity, majority | Model | entry/comparison | OK |
| `R` | rule variable and rejection candidate | Model/R1 | entry/R1 | Ambiguous |
| `q`, `k=q-1` | majority quota, extra votes | Majority | majority proof | OK |
| `W_2^M`, `W_2^U` | terminal representative weak value | Majority/R2 | results | OK |
| `c_M`, `c(nu)` | weak continuation values | Majority/R1 | R1/proofs | OK |
| `a_theta(nu)` | dynamic threshold | Model | R1 | OK |
| `a_0^M`, `a_1^M` | majority H-inclusion thresholds | Majority | Prop. majority | OK |
| `a_0(1)`, `a_1` | R1 unanimity thresholds | R1 | Prop. R1 | OK; explanation helps |
| `p_2(mu)` | terminal weak-proposer value | R2 | R1/entry | OK |
| `C_theta(nu)` | H continuation payoff | R2 | R1/proofs | OK |
| `P`, `L`, `R` | pooling, low-only, rejection | R1 | R1/entry | Rename `R` |
| `Pi_K^U(mu)` | weak proposer payoff under candidate | R1 | Prop. R1 | OK |
| `mathcal K(mu)` | admissible candidate set | R1 | Prop. R1 | OK |
| `bar Pi^U(mu)` | selected proposer value | Prop. R1 | R1 | OK |
| `k^*(mu)` | selected unanimity candidate | Entry | entry/comparison | OK |
| `S_K^U(mu)` | total weak payoff under candidate | Entry | nesting | OK |
| `V_W^R`, `V_H^R` | representative weak/H payoff under rule | Entry | comparison | OK |
| `H_K(mu)` | H payoff under unanimity candidate | Entry | comparison | Rename to `V_{H,K}^U` |
| `Delta_H(mu)` | H payoff gap | Entry | classification | OK |
| `F_U`, `F_M` | entry formation sets | Entry | classification | OK |
| `chi` | entry cost | Model/Entry | classification | OK |
| `mathcal C_0`, `mathcal C_M`, etc. | institutional categories | Corollary | discussion | OK but heavy |
| `M_NC` | No-Cheap-H margin | Majority | comparative statics | OK |
| `rho` | reduced majority surplus extension | Majority | one paragraph | Maybe unnecessary |
| `d_theta`, `b_theta` | threshold microfoundation terms | App. B | appendix only | OK |

## Result-by-Result Analysis

| Result | Board Criteria | Assessment | Takeaway |
|---|---|---|---|
| Proposition: Majority no-screening | Context yes; statement self-contained; proof appendix; implication clear | Strong, but condition could be listed in baseline-domain table | Majority must avoid screening iff `a_0^M >= beta/m`. |
| Lemma: Terminal unanimity threshold | Context yes; clean statement; intuition follows | Excellent | Terminal unanimity switches from low-only to pooling at `mu_2^*`. |
| Lemma: Rejected-history reduction | Context partially; statement long; proof well structured | Good but technically dense | Under the maintained assessment, rejected histories add no fourth payoff-relevant candidate. |
| Proposition: R1 outcome | Context yes; statement too condition-loaded; proof in right place | Adequate | Selected R1 unanimity outcome must be payoff-equivalent to `P`, `L`, or `R`. |
| Proposition: Weak-state entry nesting | Context yes; statement clean; proof short | Strong | If No-Cheap-H holds, weak-state entry under unanimity is nested in majority entry. |
| Proposition: Conditional comparison | Context yes; statement self-contained; proof tautological | Weak as a proposition | On the both-form region, H's ranking is exactly the sign of `Delta_H`. |
| Corollary: Institutional classification | Context yes; formal set partition; implication clear | Strong | The belief space partitions into no formation, only majority, and three both-form H-ranking regions. |

## Constructive Suggestions

1. Add a one-page "Baseline Domain and Assumption Map" immediately after the model.

2. Split Definition 1 into primitives, protocol, and entry. This will make the model easier to scan.

3. Rename the no-information rejection candidate `R` to avoid collision with the rule variable `R in {U,M}`.

4. Replace `H_K(mu)` with `V_{H,K}^U(mu)` to keep `H` reserved for the actor.

5. Add a short proof roadmap before Proposition R1: candidate exhaustion, IC pricing, rejected-history reduction, maximization/tie-break.

6. Demote the conditional-comparison proposition to prose or strengthen it by combining it with the classification result.

7. Use an interior numerical example before the OPEC-style boundary illustration, so all three R1 candidates are visibly active.

8. Keep Appendix C's notation table, but add a shorter "local notation" table before the R1 analysis.

---

## Full Review - Exposition

# Formal Model Exposition Review (Varian / Thomson / Board)

## Score: 8/10

## Assessment by Dimension

### ME1. Paper Structure [Adequate]

The paper is well organized: puzzle, mechanism, model, majority benchmark, unanimity result, entry/classification, numerical illustration, discussion, conclusion. The baseline is solved before extensions, and the appendices carry the mechanical proofs.

The hook is strong: "When can consensus benefit a powerful state?" is clear and immediate. The main formal R1 result appears on PDF p.15, which is exactly at the Board / Meyer-ter-Vehn threshold, but not comfortably before it. The classification result arrives later, around pp.19-20. The introduction does summarize the results early, so the reader knows where the paper is going.

Main improvement: move a compact "Results Roadmap" or one visual summary of the majority/unanimity comparison before the full model definition, or shorten the model setup so Proposition 2 lands around p.12-13.

### ME2. Introduction [Excellent]

The introduction is one of the strongest parts. The contribution is clear in the first two paragraphs: consensus can benefit a hegemon through informational pivotality, not agenda power. It explains agents, actions, information, and the mechanism before the literature review.

The introduction avoids an excessive "importance of institutions" opening. It also avoids a literature-first structure. The paragraph beginning "The model produces four results" is useful and disciplined, not a laundry list.

One issue: four results plus the numerical OPEC classification may be slightly too much for the introduction. The core message is Pivotality creates screening rents under unanimity; majority removes them under No-Cheap-H; institutional choice is conditional. The entry nesting result can be folded into the classification sentence.

### ME3. Writing and Style [Adequate]

Checklist:

- Short sentences: mostly good. The prose is much cleaner than typical formal-theory exposition.
- No sentence beginning with notation: I did not find a serious issue in the main text.
- Voice and tense: consistent present tense; mostly "this paper/the model," with limited first person in the abstract.
- Technical terms: generally precise. "Selection result under the baseline voting assessment, not uniqueness over unrestricted PBEs" is especially good.
- Footnotes: effectively absent; important definitions are not buried.
- Appendix: narrative and useful, not a dumping ground.

Main weakness: the paper sometimes over-defends itself. Examples include repeated caveats around weak-vote-passive assessment, boundary cases, non-calibration, and scope. These are substantively important, but the repetition can make the exposition feel defensive. For example, the numerical illustration section repeatedly states that the boundary case "should not be hidden," "not an empirical calibration," "not a proof of an open robustness neighborhood," and "not the robust object." Keep the caveat once in the body, then move repeated cautionary language to Appendix B.

### ME4. Length and Knowing When to Stop [Long]

The main body is about 29 PDF pages before references/appendices, and the full PDF is 42 pages. For a formal-theory paper, this is not excessive, but it is longer than the Varian/Board ideal. The paper has a strong core, but it spends too much main-text space on robustness windows, diagnostic tables, and defensive scope management.

The biggest candidate for compression is Section 8. Tables 1-5 are useful; Tables 6-7 may be better placed in the appendix, with only one sentence in the body: "Appendix B shows that the classification survives several one-way perturbations, although all-belief pooling is boundary-specific."

The OPEC discussion is valuable, but it could be tighter. Table 8 is useful. Table 9 is somewhat repetitive because the institutional categories have already been formally defined and numerically classified.

### ME5. Use of Examples and Intuition [Excellent]

The three-state motivating example is excellent. It gives the reader the mechanism before the full model: majority avoids H, unanimity must satisfy H, pooling creates an informational rent. This is exactly the kind of example Varian and Dixit would recommend.

Each result is followed by intuition in plain English. Figure 5 is especially useful because it makes the paper look more like a talk: majority/no-H path versus unanimity/P-L-R candidates.

The only limitation is that the main numerical illustration sits on the boundary `a0(1)=a1`, so it does not display the full P/L/R logic in the calibrated example. The paper handles this honestly, but exposition would improve if the body emphasized Figure 4 as the conceptual geometry and treated the OPEC numbers as a classification illustration, not the main intuition for all candidate regions.

## Overall Verdict on Exposition

The exposition is strong and unusually transparent for a formal model after proof repair. The reader can understand the mechanism within the first few pages, and the paper repeatedly distinguishes the main claim from stronger claims it does not prove. The main remaining problem is not clarity but weight: the body carries too many caveats, diagnostic tables, and robustness qualifications. A busy reader will understand the model, but may feel that the paper is still documenting its repair process rather than presenting only the final architecture.

## Top 5 Improvement Suggestions

1. Move the main R1 result earlier. Compress the model definition and weak-vote-passive discussion so Proposition 2 appears before PDF p.15, ideally by p.12-13.

2. Reduce defensive repetition. Keep the key caveat once: "This is a selected PBE outcome under the weak-vote-passive assessment, not a uniqueness result over unrestricted PBEs." Move repeated scope qualifications to Appendix B.

3. Trim Section 8. Keep Example 1, Figure 6, Table 5, and maybe one margin table. Move robustness windows and classification sweeps to the appendix.

4. Make Figure 5 do more work. Introduce it before or immediately after Proposition 2 as the paper's "talk slide" for the entire mechanism.

5. Tighten the OPEC section. Keep the mapping table and two paragraphs on Saudi pivotality; consider moving the five-category OPEC interpretation table to the appendix or shortening it to prose.
