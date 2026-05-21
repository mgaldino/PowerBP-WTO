# Technical Presentation Review (Thomson / Board)

**Methodological references**: Thomson (1999), Board & Meyer-ter-Vehn (2018), Dixit (2015), Varian (1997/2016).

## Score: 8/10

## Model Structure
The paper presents a two-round bargaining model with one hegemon `H` and `m=N-1` weak states. Nature draws `theta in {0,1}`; `H` observes the type, weak states share belief `mu`. Weak proposers choose fixed-pie packages `(y,x_1,...,x_m)`. Under unanimity, `H` is pivotal; under majority, weak states may exclude `H` if No-Cheap-H holds. Payoffs come from weak residual surplus and `H`'s type-dependent net participation threshold. The equilibrium object is a selected pure-strategy PBE outcome under the weak-vote-passive assessment.

---

## Scorecard

| Dimension | Verdict | Synthetic Comment |
|---|---|---|
| D2. Model Presentation | Adequate | Canonical ingredients are all present, but Definition 1 is overloaded. |
| D3. Notation | Needs improvement | Mostly mnemonic, but `R`, `H_K`, and duplicate equation tags create avoidable friction. |
| D4. Definitions | Adequate | Definitions are explicit, but formal primitives, protocol, and interpretation are bundled together. |
| D5. Result Statements | Adequate | Results are scoped and understandable; R1 statement remains condition-heavy. |
| D6. Proofs | Strong | Appendix proofs are stepwise, readable, and mostly in the right place. |
| D7. Figures | Strong | Timing, logic, region, and classification figures are useful and now cleaner. |
| D8. Assumptions | Needs improvement | Conditions are named, but no main-text assumption-to-result map exists. |
| D9. Examples | Adequate | The OPEC illustration is useful but boundary-based; nonboundary example is relegated to appendix. |

---

## Detailed Analysis

### D2. Model Presentation

**Diagnosis**: The model section at `formal_model_v5.Rmd:88` states players, actions, feasibility, preferences, thresholds, recognition, voting, coalition selection, and entry inside one definition. It is complete, but too dense.

**Impact**: A competent reader can reconstruct the game, but a busy reader cannot easily separate primitives from protocol rules and derived continuation objects.

**Concrete suggestion**: Split Definition 1 into three blocks: `Primitives and payoffs`, `Bargaining and voting protocol`, `Entry protocol`. Keep the weak-vote-passive assessment as Definition 2.

**Reference**: Thomson recommends separating formal definitions from interpretation; Board & Meyer-ter-Vehn favor a clean baseline model before analysis.

### D3. Notation

**Diagnosis**: The notation is generally mnemonic, but three issues matter. First, `R` denotes both rule membership in `R in {U,M}` and the rejection candidate `R`. Second, `H_K(mu)` reads too much like the actor `H`, not a payoff. Third, equation tag `(14)` is used twice: once for `bar Pi^U` at `formal_model_v5.Rmd:393`, and again for `S_P^U` at `formal_model_v5.Rmd:447`.

**Impact**: These do not threaten the model, but they increase parsing cost and can create citation confusion in the PDF.

**Concrete suggestion**: Rename rejection `R` to `D` or `Wait`; rename `H_K(mu)` to `V_{H,K}^U(mu)`; fix manual equation tags after R1 so numbering is unique.

**Reference**: Thomson's central rule is that notation should be guessable and unambiguous.

### D8. Assumptions and Logical Structure

**Diagnosis**: The paper has good named conditions: Threshold Order, Majority Threshold Order, No-Cheap-H, High-Posterior Pooling, R1 Dynamic Threshold Order, weak-vote-passive assessment. But their relationship is scattered across sections.

**Impact**: The reader may experience the assumptions as accumulating rather than as a controlled baseline domain.

**Concrete suggestion**: Add a short table after Definition 2:

| Condition | Role | Used in |
|---|---|---|
| Threshold Order | terminal package ranking | Lemma R2 |
| Majority Threshold Order | majority thresholds | Prop. majority |
| No-Cheap-H | majority no-screening | Prop. majority, nesting |
| High-Posterior Pooling | posterior-one continuation | R1 lemma/proposition |
| R1 Dynamic Threshold Order | rules out high-only branch | rejected-history lemma, R1 |
| Weak-vote-passive assessment | belief discipline | R1 |

**Reference**: Thomson recommends stating assumptions in a structured order and clarifying logical dependence.

---

## Notation Inventory

| Symbol | Meaning | Introduced | Used In | Problem? |
|---|---|---|---|---|
| `N`, `m=N-1` | total states, weak states | Model | all formal sections | OK |
| `H`, `W_i`, `W_p` | hegemon, weak states, proposer | Model | all | OK |
| `theta` | H type | Model | all | OK |
| `mu`, `nu` | prior/posterior belief | Model/R1 | R1, proofs | OK |
| `y`, `x_i` | package for H, weak allocation | Model | all | OK |
| `t_theta` | terminal threshold | Model | all | OK |
| `o_theta` | outside/external payoff | Model | majority/unanimity | OK |
| `a_theta(nu)` | dynamic threshold | Model | R1 | OK |
| `a_0(1)`, `a_1` | R1 unanimity thresholds | R1 | R1, examples | OK, but visually heavy |
| `a_0^M`, `a_1^M` | majority thresholds | Majority | majority | OK |
| `C_theta(nu)` | H continuation payoff | Unanimity | R1/proofs | OK |
| `p_2(mu)` | terminal weak proposer value | R2 | R1/appendix | OK |
| `c(mu)`, `c_M` | weak voter continuation values | Majority/R1 | R1 | OK |
| `P,L,R` | pooling, low-only, rejection | R1 | R1/proofs | `R` ambiguous |
| `K`, `mathcal K(mu)` | candidate/candidate set | R1 | R1 | OK |
| `S_K^U` | total weak payoff under U | Entry | nesting | OK |
| `H_K(mu)` | H payoff under U candidate | Entry | comparison | Rename |
| `F_U`, `F_M` | formation sets | Entry | classification | OK |
| `Delta_H` | H payoff gap | Entry | comparison | OK |
| `chi` | entry cost | Model/Entry | classification | OK |
| `pi_H` | recognition probability of H | Model | scope | OK |
| `R in {U,M}` | institutional rule | Model | entry | conflicts with rejection `R` |

### Notational Simplifications

1. Replace `R` candidate with `D`:
   `P,L,D = pooling, low-only, delay/no-information rejection`.
2. Replace `H_K(mu)` with:
   `V_{H,K}^U(mu)`.
3. Avoid referencing `c_M`, `c(mu)`, `c(0)` inside Definition 1 before they are defined; introduce them later where used.
4. Fix duplicate manual equation tag `(14)`.

---

## Result-by-Result Analysis

### Proposition: Majority no-screening benchmark

| Criterion | Present? | Quality |
|---|---|---|
| Context before result | Yes | Clear majority setup precedes it. |
| Self-contained statement | Yes | Strong iff statement. |
| Intuition after | Yes | No-Cheap-H paragraph is useful. |
| Proof location | Yes | Appendix is appropriate. |
| Implications | Yes | Establishes majority as no-screening benchmark. |

**Must or might?** Must: if and only if No-Cheap-H holds, no-H path dominates.

**Takeaway**: Majority removes screening exactly when H is not cheaper to buy than a weak voter.

### Lemma: Terminal unanimity threshold

| Criterion | Present? | Quality |
|---|---|---|
| Context before result | Yes | Terminal comparison is set up cleanly. |
| Self-contained statement | Yes | Very readable. |
| Intuition after | Yes | Comparative statics help. |
| Proof location | Yes | Appendix is fine. |
| Implications | Yes | Feeds R1 thresholds. |

**Must or might?** Must.

**Takeaway**: In terminal unanimity, weak proposers test low type at low beliefs and pool at high beliefs.

### Lemma: Rejected-history reduction

| Criterion | Present? | Quality |
|---|---|---|
| Context before result | Partial | Reader needs more roadmap before the lemma. |
| Self-contained statement | Mostly | Long but scoped. |
| Intuition after | Partial | Proof gives the intuition, but body could preview it. |
| Proof location | Yes | Appendix is appropriate. |
| Implications | Yes | Supports P/L/R exhaustion. |

**Must or might?** Must under maintained assessment.

**Takeaway**: Under weak-vote-passive beliefs, rejected histories do not create a fourth relevant R1 candidate.

### Proposition: R1 outcome under weak-vote-passive assessment

| Criterion | Present? | Quality |
|---|---|---|
| Context before result | Yes | P/L/R are defined just before. |
| Self-contained statement | Partial | Hypothesis list is heavy. |
| Intuition after | Yes | Figure and delay remark help. |
| Proof location | Yes | Appendix proof is central but well structured. |
| Implications | Yes | Drives entry and comparison. |

**Must or might?** Must under the maintained assessment and candidate class.

**Takeaway**: R1 unanimity selects the best admissible candidate among pooling, low-only, and no-information rejection.

### Proposition: Weak-state entry nesting

| Criterion | Present? | Quality |
|---|---|---|
| Context before result | Yes | Entry payoff objects are defined. |
| Self-contained statement | Yes | Clean inequality and set inclusion. |
| Intuition after | Yes | Accounting explanation is strong. |
| Proof location | Yes | Appendix is fine. |
| Implications | Yes | Explains why majority can form when unanimity cannot. |

**Must or might?** Must.

**Takeaway**: Majority has weakly larger weak-state formation set than unanimity.

### Proposition: Conditional comparison for the hegemon

| Criterion | Present? | Quality |
|---|---|---|
| Context before result | Yes | `Delta_H` defined immediately before. |
| Self-contained statement | Yes | Almost definitional. |
| Intuition after | Partial | Could be folded into classification. |
| Proof location | Yes | Short appendix proof is fine. |
| Implications | Yes | Determines H's institutional ranking. |

**Must or might?** Must by definition.

**Takeaway**: When both rules form, H prefers the rule with the higher payoff.

### Corollary: Institutional classification

| Criterion | Present? | Quality |
|---|---|---|
| Context before result | Yes | Formation sets and gap are defined. |
| Self-contained statement | Yes | Exhaustive partition is clear. |
| Intuition after | Yes | Good caution against unconditional ranking. |
| Proof location | Yes | Appendix is fine. |
| Implications | Yes | Main classification result. |

**Must or might?** Must.

**Takeaway**: The baseline yields five exhaustive institutional cases: no rule, only majority, or both rules with H preferring U, tying, or preferring M.

---

## Constructive Suggestions

1. Split Definition 1 into primitives/payoffs, bargaining-voting protocol, and entry protocol.
2. Add a main-text assumption-to-result table after the model.
3. Rename the R1 rejection candidate from `R` to `D` or `Wait`.
4. Rename `H_K(mu)` to `V_{H,K}^U(mu)`.
5. Fix duplicate equation tag `(14)`.
6. Move the nonboundary R1 example slightly closer to the R1 proposition or mention its table more prominently.
7. Keep proofs in the appendix, but add a one-paragraph proof roadmap before the rejected-history lemma.
