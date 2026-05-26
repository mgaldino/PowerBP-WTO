# Informational Power Through Pivotality: How Consensus Can Benefit a Hegemon

**Date**: 24/05/2026, 15:28:45
**Domain**: social_sciences/political_science
**Taxonomy**: academic/research_paper
**Filter**: Active comments

---

## Overall Feedback

**The weak-vote-passive assessment**

Definition 2 carries substantial equilibrium-selection weight in the architecture of the model. By assigning specific beliefs after weak-voter deviations, after hegemon deviations from pooling prescriptions, and after failures caused by weak-state rejection, this assessment allows Lemma 2 and Proposition 2 to reduce Round-1 unanimity to the three core candidates of pooling, low-only, and delay. The text acknowledges that this does not constitute a uniqueness result under arbitrary off-path beliefs. Nevertheless, because the central contribution rests on this reduction, readers dissecting the equilibrium construction will likely look for a more robust behavioral justification for these specific belief assignments. Alternatively, the analysis could benefit from a defined sensitivity check or an explicit framing of the findings as an equilibrium construction under a deliberately imposed public-voting belief protocol, rather than leaving the assessment vulnerable to critique as a technical convenience.

**Majority exclusion and the full-surplus benchmark**

The comparison with majority rule in Section 5 assumes that weak states can exclude the hegemon while preserving the entire unit surplus, which yields $V_W^M = 1/m$. This assumption does major mechanical work: it neutralizes the hegemon's private threshold under Strict No-Cheap-H, drives the entry nesting result in Proposition 3, and positions majority as an attractive outside institutional rule for the weak coalition. A tension emerges when interpreting these mechanics through the lens of the OPEC illustration in Section 9.1. In the substantive application, Saudi participation is characterized as essential for avoiding severe collective losses. If excluding the hegemon destroys part of the cooperative surplus (as the text briefly notes might occur if $\rho < 1$), majority rule might also necessitate hegemon participation, reintroducing the screening problem. Resolving this tension requires either standardizing a compact $\rho$ benchmark in the formal comparison or sharply narrowing the empirical application to purely relative, fixed-pie institutional privileges.

**Unpacking pivotality and weak-state vetoes**

The institutional comparison organically bundles two fundamental changes in the bargaining environment. Under unanimity, the proposer must satisfy the hegemon alongside $m-1$ weak voters, which is reflected in the payoff subtractions in Section 6.2. Under majority rule, the proposer requires only $k$ additional votes and can often bypass the hegemon altogether. Consequently, the performance difference between the institutions conflates making the hegemon pivotal with the proliferation of weak-state veto constraints. Readers seeking to isolate the exact value of informational power will wonder how much of the unanimity outcome stems directly from the hegemon's pivotality as opposed to the baseline costs of weak-state unanimity. Introducing an analytical decomposition, or deploying a hybrid benchmark such as a hegemon veto combined with internal weak-state majority rule, would clarify the distinct effect of hegemonic informational power.

**The dynamic threshold order restriction**

The formulation in Section 6.2 assumes the ordering $a_0(1) \le a_1$, requiring $a_0(1) < a_1$ to achieve strict low-only separation. As demonstrated in Appendix B.4, whenever $\beta < 1$, this condition demands that the threshold gap $t_1 - t_0$ be at least as large as the outside-payoff gap $o_1 - o_0$. This inequality mathematically scopes out an important class of hegemonic profiles: those where the high-threshold type commands a high threshold precisely because it possesses vastly superior outside opportunities. If this condition fails, the ordering of dynamic acceptance thresholds flips, and the current reduction to the selected candidates may no longer accurately map behavior. Given that the OPEC discussion explicitly anchors Saudi behavior in outside opportunities, spare capacity, and price-war alternatives, this structural condition must be elevated into the main text and either substantively defended or explicitly used to delimit the intended empirical domain.

**Status**: [Pending]

---

## Detailed Comments (9)

### 1. Conflation of rent and total payoff in institutional comparison

**Status**: [Pending]

**Quote**:
> The classification therefore replaces a simple "consensus always helps the hegemon" claim with a more precise prediction: consensus helps the hegemon only where the pivotality-
screening rent exceeds the payoff from being excluded under majority.

**Feedback**:
This sentence risks conflating the screening component with the total institutional comparison. The formal condition is that the hegemon’s total payoff under unanimity exceed its payoff under majority, equivalently $\Delta_H(\mu)>0$; on the common-outside-payoff slice, this means the gross screening term must exceed the discounting offset $(1-\beta)o$, not the full majority payoff $o$.

---

### 2. Misleading claim about hegemon's preference

**Status**: [Pending]

**Quote**:
> The institutional comparison is therefore a classification, not an unconditional ranking of rules. If neither rule forms, the hegemon is indifferent. If only majority forms, majority is better. If both rules form, the hegemon's ranking is determined by the sign of $\Delta_{H}(\mu)$, the payoff gap between unanimity and majority.

**Feedback**:
The phrase “If only majority forms, majority is better” can be read as a claim about $H$'s preference, since it is placed between two sentences about the hegemon. Under the natural convention that failed unanimity leaves $H$ with the same expected outside payoff it receives when excluded under majority, $H$ would be indifferent in this region; the intended distinction seems to be that majority is the only viable institution, not that it is strictly payoff-better for $H$.

---

### 3. Candidate-switch issue in observable implications

**Status**: [Pending]

**Quote**:
> The model is not an empirical test, but it does imply patterns that distinguish informational pivotality from nearby sources of power. If pivotality under private information is doing the work, accommodation should be region-dependent: weak proposers may test the low threshold at low beliefs, pool at the high threshold when the high type is sufficiently important or testing is unattractive, or delay when accepted packages are too expensive relative to continuation bargaining. Failed consensus attempts should be informative mainly when the pivotal actor's rejection is outcome-determining. In the notation of the model, proposal generosity is governed by the selected candidate and the threshold $a_{1}$, low-only testing is live only when $a_{0}(1)<a_{1}$, and the institutional ranking changes only when the selected-path $\Delta_{H}(\mu)$ crosses zero.

**Feedback**:
The final clause appears too strong: earlier the formal classification allows the institutional ranking to change either at roots of a candidate-specific gap or at boundaries where the selected $P,L,D$ candidate changes. Because the selected $\Delta_H(\mu)$ can jump at candidate-switch boundaries, the ranking can change without the selected gap taking the value zero at that boundary.

---

### 4. Round-1 roadmap understates the domain restrictions

**Status**: [Pending]

**Quote**:
> Second, under unanimity, terminal bargaining has a threshold form: weak proposers choose a low-threshold package at low beliefs and a pooling package at higher beliefs. Third, in Round 1, under the weak-vote-passive assessment, the selected PBE outcome is payoff-equivalent to one of three candidates: pooling, low-only acceptance, and no-information delay.

**Feedback**:
The Round-1 roadmap may overstate the scope of the candidate-reduction result. Proposition 2 later relies not only on the weak-vote-passive assessment, but also on threshold-domain conditions such as High-Posterior Pooling and the R1 Dynamic Threshold Order; the introductory summary could be read as making the reduction to pooling, low-only acceptance, and no-information delay a consequence of the belief assessment alone.

---

### 5. Endogenous rule choice unravels screening

**Status**: [Pending]

**Quote**:
> If a privately informed hegemon chose unanimity or majority after observing its type, the choice of rule could itself become a signal. That signaling stage would interact with the screening mechanism studied here. It could reduce screening if rule choice reveals the type, leave screening intact if both types choose the same rule or if the rule is institutionally fixed, or amplify screening if rule choice shifts beliefs toward a high participation threshold without fully revealing the state.

**Feedback**:
The endogenous-rule-choice paragraph may overstate what follows from a literal extension that preserves the baseline payoffs and lets $H$ costlessly choose between rules. In that version, under Strict No-Cheap-H and for $\beta<1$ with positive outside payoffs, the high type's payoff under any unanimity candidate is $\beta o_1$, while majority gives $o_1$; once unanimity revealed a low type, the low type would similarly receive only $\beta o_0$ rather than $o_0$. Thus the listed possibilities of intact or amplified unanimity screening seem to require additional rule-choice payoffs, commitment, institutional constraints, or other features not in the baseline.

---

### 6. Appendix B.5 table does not show the claimed pooling rows

**Status**: [Pending]

**Quote**:
> For these parameters, strict low-only separation is blocked by $a_{0}(1)=a_{1}=0.45$. Pooling is not selected at all beliefs: it becomes feasible and eventually beats delay once beliefs are high enough. The table below reports delay at a low belief and pooling at higher beliefs. At $\mu=0.01$, terminal bargaining is very attractive to a future recognized weak proposer because the high type is unlikely, but Round-1 unanimity requires compensating both $H$ and all non-proposing weak voters. The pooling package is infeasible at this belief, and the proposer selects no-information delay.

Table 10: A non-calibrated delay example. The example demonstrates that no-information delay can be selected by backward induction; it is not used for the OPEC illustration.
| mu | a0(1) | a1 | Pi_P | Pi_L | Pi_D | Selected |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 0.01 | 0.45 | 0.45 | infeasible | blocked | 0.067 | delay |

**Feedback**:
In Appendix B.5, the text says Table 10 reports delay at a low belief and pooling at higher beliefs, but the displayed table appears to include only the $\mu=0.01$ delay row. The claimed transition to pooling is therefore not shown in the table as presented.

---

### 7. Appendix B.4 sweep grid is under-specified

**Status**: [Pending]

**Quote**:
> The sweep in Table 9 fixes $N=13$ and $o_{0}=o_{1}=o$, then varies $\beta \in\{0.45, \ldots, 0.90\}$, $t_{0} \in\{0.10, \ldots, 0.40\}, t_{1}-t_{0} \in\{0.08, \ldots, 0.35\}$, and $o \in\{0, \ldots, 0.30\}$.

**Feedback**:
The Table 9 sweep appears under-specified: the endpoints of the parameter ranges are given, but the grid increments are not. Because the table reports counts and shares from this discrete sweep, the grid resolution is needed to reproduce and interpret the robustness diagnostic.

---

### 8. Informational rents are not limited to pooling

**Status**: [Pending]

**Quote**:
> By setting $\pi_{H}=0$, the model removes formal proposal power from the hegemon and asks whether pivotality alone can create informational rents. The answer is yes under unanimity whenever weak proposers pool the hegemon's types at the high threshold. Whether that rent is large enough to make unanimity better for $H$ than majority is a separate institutional-ranking question, answered by the sign of $\Delta_{H}(\mu)$

**Feedback**:
The description of informational rents is a bit too narrow here. Pooling is a clear source of rents, but in the low-only candidate the accepted low type can also receive a dynamic informational rent because $a_0(1)$ is priced using the high-posterior continuation value. The broader institutional ranking still depends on $\Delta_H(\mu)$, but the rent mechanism is not limited to pooling at the high threshold.

---

### 9. Appendix B.4 intuition for outside payoffs seems reversed

**Status**: [Pending]

**Quote**:
> For Round 1, the key dynamic-order slack is

$$
a_{1}-a_{0}(1)=(1-\beta)\left\{t_{1}-t_{0}+o_{0}-o_{1}\right\} .
$$

Strict low-only separation requires this slack to be positive. The worked example sets $o_{0}=o_{1}$, so the slack is $(1-\beta)\left(t_{1}-t_{0}\right)>0$. More generally, increases in the threshold gap $t_{1}-t_{0}$ make strict low-only separation easier, while increases in $o_{1}-o_{0}$ make it harder because the high type's outside payoff lowers its net dynamic threshold less.

**Feedback**:
In Appendix B.4, the formula and comparative static are correct, but the verbal intuition appears reversed. Increasing $o_1$ lowers $a_1=t_1-(1-\beta)o_1$ relative to $a_0(1)$, so a larger $o_1-o_0$ makes strict low-only separation harder because the high type's outside payoff lowers its net dynamic threshold more, not less.

---
