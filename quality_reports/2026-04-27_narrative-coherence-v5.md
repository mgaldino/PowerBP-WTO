# Narrative Coherence Review: formal_model_v5.Rmd

**Date**: 2026-04-27  
**Reviewer**: Fresh editorial reviewer (JoP-style)  
**Purpose**: Verify that BP removal is clean and narrative reads as if screening was always the sole mechanism  
**File**: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v5.Rmd`

---

## 1. Abstract (lines 36--36)

**PASS**

- No mention of Bayesian Persuasion, concavification, or information design.
- Correctly describes: (1) screening mechanism under unanimity (uncertainty works in hegemon's favor, weaker states pay more than necessary), (2) majority eliminates this advantage, (3) entry trade-off (majority can dominate below threshold because it makes participation easier).
- Clean, self-contained summary of the paper's argument.

---

## 2. Introduction (lines 47--61)

**PASS**

- No reference to BP, concavification, information design, signal design, or commitment.
- Contribution claim: "consensus can make informational power more politically productive than the coalition arithmetic of majority rule" -- matches Theorem 1 (conditional dominance) + Proposition (institutional classification).
- Road map (line 61): "Section 2 motivating example... Section 3 model... Sections 4 and 5 majority + unanimity... Section 6 entry... Section 7 main result... Section 8 discussion/GATT/WTO... Section 9 conclusion" -- matches actual section structure exactly.
- No transitional language ("we used to", "previously", etc.).

---

## 3. Motivating Example, Section 2 (lines 63--81)

**PASS**

- No BP paragraph, no concavification, no signal design.
- Forward-references: "Theorem~\ref{thm:conditional}" (line 78) and "Proposition~\ref{prop:classification}" (line 80) -- both correct.
- Narrative cleanly previews screening mechanism in 3-player, 1-round setting, then explains how the general model enriches it (N players, 2 rounds, entry).

---

## 4. Model, Section 3 (lines 82--117)

**PASS**

- Stage 0: Institutional choice (voting rule).
- Stage 1: Entry (weak states pay cost c). No signal design, no information structure, no commitment.
- Stage 2: Bargaining (2-round Baron-Ferejohn).
- No mention of signal pi, information structure, or commitment anywhere in the model section.
- Game tree figure caption (line 179) has an HTML comment `% (Signal design node removed -- no Bayesian persuasion in v5)` -- this is invisible in rendered output but **is a code-level artifact**. Not a narrative problem.
- Figure captions (lines 183, 268): clean, no BP language.

---

## 5. Sections 4--5 (Majority + Unanimity, lines 273--378)

**PASS**

- Section 4 (Majority): Clean. Describes linear payoff, no screening, no strategic discontinuity.
- Section 5 (Consensus): Clean. Describes screening cutoff, jump, overpayment. No BP language.
- Example 1 (line 376): Clean. Shows screening jump magnitudes without any BP computation.
- Screening schematic figure (line 373): Caption references Theorem 1 and screening rent. No BP.

---

## 6. Section 6 (Entry and Institutional Viability, lines 381--394)

**PASS**

- Section title: "Entry and Institutional Viability" -- correct, no BP.
- No concave envelopes, no bp-illustration figure.
- Net gain function (Definition 2, line 387): present, well-motivated, useful for institutional comparison.
- Clean of BP language throughout.

---

## 7. Section 7 (Institutional Choice, lines 397--476 + 478--675)

**PASS with 1 issue**

- Theorem 1 (line 411, `thm:conditional`): Conditional payoff dominance -- correctly promoted as the main result.
- Corollary (line 438, `cor:dominance`): Unanimity dominance on the entry set -- correctly derived from Theorem 1.
- Proposition (line 452, `prop:classification`): Institutional classification -- correctly replaces old Theorem 2.
- Remark on Information Design (line 468, `rem:info_design`): Placed AFTER the Proposition -- correct placement.
  - Content is appropriate: explains why the model is "hospitable" to information design without making BP a protagonist. Mentions "Kamenica and Gentzkow 2011" and "nonconcavities" -- acceptable in a contained Remark.
  - **Minor issue**: The citation "Kamenica and Gentzkow 2011" is plain text, not a proper `@kamenica2011bayesian` citation. It will not generate a bibliography entry. *Severity: LOW.*
- Example 2 (line 472): Shows E_U and E_M correctly, no BP computation.

---

## 8. Discussion and Conclusion (lines 563--688)

**PASS**

- Discussion (GATT/WTO, Scope): Clean of BP language. No reference to p* as a concavification threshold. References to Theorem 1 and Proposition are correct.
- Conclusion (lines 679--688): Clean. No BP. Correctly summarizes the screening mechanism and institutional classification. Extensions paragraph mentions open questions without invoking BP.

---

## 9. Appendices (lines 690--1067)

**PASS with 2 issues**

- B.5 (line 934): Labeled "Proof of Theorem 1 (Conditional payoff dominance)" -- **correct**.
- B.6 (line 991): Labeled "Proof of Corollary (Unanimity dominance on the entry set)" -- **correct**.
- B.8 (line 1019): Labeled "Proof of Proposition (Institutional classification)" -- **correct**, 3 cases (i, ii, iii).
- B.4 (line 840): HTML comment `<!-- B.4 (Proof of Proposition 4) deleted: Proposition 4 removed in v5. -->` -- invisible in output, acceptable.
- B.5a (line 842): Derivation of payoff decomposition -- clean, no BP.
- Appendix C (line 1030): Extension to K>2 types -- clean, no BP.

**Issue 1 (line 728, notation table)**: `$\lambda_M$` is listed as "Defined in: Thm. 2". There is no Theorem 2 in this paper. Should be "App. B.5" (where $\lambda_M$ is defined in the proof of Theorem 1). *Severity: MEDIUM -- incorrect cross-reference to nonexistent result.*

**Issue 2 (line 729, notation table)**: `$E_R$` is listed as "Defined in: Prop." which is ambiguous -- there are 4 Propositions (Props 1-3 and the Institutional Classification Proposition). Should specify which one, likely "Cor." (Corollary) or "Sec. 7" where E_R is first defined at line 436. *Severity: LOW.*

---

## 10. Overall Coherence

**PASS with 1 issue**

- The paper reads as if screening was always the sole mechanism. No trace of "we used to have BP" or transitional language.
- No "now", "previously", "we have removed", "in the revised version" anywhere.
- The code-level TikZ comment at line 179 (`% (Signal design node removed -- no Bayesian persuasion in v5)`) is invisible in rendered output but would be visible to anyone reading the .Rmd source. Not a narrative coherence issue for readers, but a code hygiene issue.

**Issue (line 705, notation table)**: `$\mu$` is defined as "Posterior belief $\Pr(\theta=1 \mid s)$". The conditioning on signal $s$ is a leftover from the BP framework. In the v5 model without BP, there is no signal $s$. The posterior equals the prior $p$ at entry and may be updated after R1 rejection (to $\mu' = 1$), but never through a signal. Should be "$\Pr(\theta=1 \mid \text{history})$" or simply "$\Pr(\theta=1)$" with a note that it may differ from $p$ after R1 rejection. *Severity: MEDIUM -- conceptual residue from BP framework.*

---

## Summary Table

| Section | Verdict | Issues |
|---------|---------|--------|
| 1. Abstract | PASS | None |
| 2. Introduction | PASS | None |
| 3. Motivating Example (Sec 2) | PASS | None |
| 4. Model (Sec 3) | PASS | Code comment (cosmetic) |
| 5. Majority + Unanimity (Secs 4-5) | PASS | None |
| 6. Entry (Sec 6) | PASS | None |
| 7. Institutional Choice (Sec 7) | PASS | 1 minor (citation format) |
| 8. Discussion + Conclusion (Secs 8-9) | PASS | None |
| 9. Appendices | PASS | 2 issues (notation table) |
| 10. Overall | PASS | 1 issue (notation table) |

## Issues to Fix (ordered by severity)

### MEDIUM

1. **Line 705**: Notation table defines $\mu$ as "$\Pr(\theta=1 \mid s)$" -- the signal $s$ is a BP residue. Fix: change to "$\Pr(\theta=1 \mid \text{history})$" or "$\Pr(\theta=1)$".

2. **Line 728**: Notation table says $\lambda_M$ is "Defined in: Thm. 2" -- no Theorem 2 exists. Fix: change to "App. B.5".

### LOW

3. **Line 729**: Notation table says $E_R$ is "Defined in: Prop." -- ambiguous. Fix: change to "Sec. 7" or "Cor." depending on intended reference.

4. **Line 469**: "Kamenica and Gentzkow 2011" is plain text, not a proper citation (`@kamenica2011bayesian`). Fix: use proper citation syntax.

5. **Line 179**: Code comment in TikZ says "Signal design node removed -- no Bayesian persuasion in v5". Invisible in output but visible in source. Fix: remove or change to a neutral comment.

6. **Line 595**: Figure caption says "Remark 1" as plain text rather than `\ref{rem:mu_bar}`. If Remark numbering ever changes, this will break. Fix: use `\ref{rem:mu_bar}`.

### PRE-EXISTING (not caused by BP removal)

7. **Line 323**: Claims "$(N-1)/N^2$ peaks at intermediate $N$" -- this function is monotonically decreasing for $N \geq 3$. The full jump expression includes $(1-\mu_s^{R1})$ which depends on $N$, so the claim about the joint expression may or may not be correct. Flagged in CLAUDE.md as CR12.

---

## Verdict

**The BP removal is clean.** The paper reads coherently as a screening-only story from front to back. The 5 actionable issues are all in the notation table (Appendix A) or minor formatting matters, none in the narrative body. No section fails the coherence check.
