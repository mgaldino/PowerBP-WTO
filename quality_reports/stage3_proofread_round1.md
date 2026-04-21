# Proofread Report: formal_model_v2.Rmd

## Summary

The manuscript is well-written with clear prose and logically structured arguments. The main issues are: (1) systematic proposition numbering errors in Appendix B (off by one starting at B.2, skipping Proposition 2), (2) a notation inconsistency in Theorem 1 where `v_H(mu_s^{R1})` appears instead of the established `v(mu, R)` notation, (3) inconsistent capitalization of "Bayesian Persuasion" vs "Bayesian persuasion," and (4) a minor reference imprecision in the introduction. All citations are valid. LaTeX environments are balanced. No compilation-blocking errors detected.

## Issues (by line, in order of appearance)

| Line | Original text | Problem | Suggested fix | Category | Deduction |
|------|--------------|---------|---------------|----------|-----------|
| 11-12 | `\doublespacing` then `\setstretch{1.5}` | Contradictory spacing commands; `\doublespacing` is immediately overridden by `\setstretch{1.5}` | Remove `\doublespacing` from line 11 or remove `\setstretch{1.5}` from line 12 | Formatting | -1 |
| 50 | "Drawing on Bayesian Persuasion [@kamenica2019bayesian]" | Capitalized "Persuasion" when dominant convention in the paper is lowercase ("Bayesian persuasion") | "Drawing on Bayesian persuasion [@kamenica2019bayesian]" | Consistency | -1 |
| 56 | "(Proposition 4)" referring to "non-convexity... providing a persuasion opportunity" | Proposition 4 is "Screening creates an informational rent" (the jump). The non-convexity result is Proposition 5. | "(Propositions 4 and 5)" or "(Proposition 5)" | Broken cross-reference | -5 |
| 123 | "let $x \equiv (N-1)\alpha r$ as a notational shorthand" | Minor grammar: "let X as Y" is awkward | "and define $x \equiv (N-1)\alpha r$ as a notational shorthand" or "let $x \equiv (N-1)\alpha r$ serve as a notational shorthand" | Grammar | -3 |
| 156 | "Under exclusion, the coalition of weak states divides $(1-\alpha)V(\theta)$" | The coalition does not divide the surplus -- only the proposing W keeps it (other W's get 0). | "Under exclusion, the weak proposer captures $(1-\alpha)V(\theta)$" | Imprecision (not equation error, but misleading) | -1 |
| 170 | "When $W$ proposes in R1: $W$ offers $\beta V_H^{R2}(\theta, M)$ to $H$---but since $H$'s vote is not pivotal, the exact offer to $H$ is irrelevant for passage. $H$ receives $\beta \cdot \alpha V(\theta)$ from the offer" | The claim "$H$ receives $\beta \cdot \alpha V(\theta)$ from the offer" is not quite right -- $H$'s R2 continuation is $V_H^{R2}(\theta,M) = V(\theta)[1+(N-1)\alpha]/N$, not $\alpha V(\theta)$. What $H$ receives as an *offer* vs continuation value is conflated. | Clarify: W's offer is irrelevant; H's expected payoff from W-proposing in R1 is $\beta V_H^{R2}(\theta,M)$ regardless | Imprecision in exposition | -1 |
| 313 | "the standard Bayesian Persuasion result" | Capitalized when dominant convention is lowercase | "the standard Bayesian persuasion result" | Consistency | -1 |
| 500 | `$S_U \equiv \frac{v_H(\mu_s^{R1})}{\mu_s^{R1}}$` | Notation `v_H` is undefined. The paper uses `v(\mu, R)` (defined line 291). Also asymmetric with $S_M$ which uses `v(\tau(M), M)`. | `$S_U \equiv \frac{v(\mu_s^{R1}, U)}{\mu_s^{R1}}$` | Notation inconsistency | -3 |
| 502 | "$p \in (0, \min(\tau(U), \tau(M)))$" | Since entry is always easier under majority ($\tau(M) \leq \tau(U)$, shown on line 480), $\min(\tau(U), \tau(M)) = \tau(M)$. The $\min$ is unnecessary/confusing. | "$p \in (0, \tau(M))$" | Notation/clarity | -1 |
| 642 | "Some agenda bias can displace and amplify the informational channel" | "displace" seems semantically wrong -- agenda bias displaces agenda power, not the informational channel. Likely meant "complement" or "enhance." | "Some agenda bias can complement and amplify the informational channel" | Word choice | -1 |
| 794 | "B.2 Proof of Proposition 2 (R1 cutoff existence and uniqueness)" | Proposition 2 is "Overpayment under unanimity." The R1 cutoff is Proposition 3. | "B.2 Proof of Proposition 3 (R1 cutoff existence and uniqueness)" | Broken cross-reference | -5 |
| 798 | "B.3 Proof of Proposition 3 (Jump)" | Proposition 3 is "R1 screening cutoff." The Jump is Proposition 4. | "B.3 Proof of Proposition 4 (Jump)" | Broken cross-reference | -5 |
| 802 | "B.4 Proof of Proposition 4 (Additional non-convexity)" | Proposition 4 is "Screening creates an informational rent" (Jump). The non-convexity is Proposition 5. | "B.4 Proof of Proposition 5 (Additional non-convexity)" | Broken cross-reference | -5 |
| 868 | `$y_H^{agg} = \beta[p_H + (1-p_H)\alpha r]$` | Described as the aggressive offer, but the expression equals $\beta V_H^{R2}(\theta=0, \mu>\mu_s)$ (the overpaid value). While mathematically consistent with the gap formula, it is confusing because in C.1 (line 835) $\phi = p_H + (1-p_H)\alpha$ is the *low* type's base R2 value. Adding a parenthetical like "Type $\theta=0$'s R2 continuation under conservative beliefs" would clarify. | Add clarifying note; or define $y_H^{agg} = \beta V_H^{R2}(\theta=0, \mu>\mu_s^{R2})$ explicitly | Exposition clarity | -1 |

## Consistency issues

1. **"Bayesian Persuasion" vs "Bayesian persuasion"**: The paper predominantly uses lowercase "persuasion" (7 instances in body text) but capitalizes it in 2 body-text instances (lines 50, 313) plus the section title (line 272, where capitalization is natural). Recommendation: standardize to lowercase "Bayesian persuasion" in body text throughout.

2. **"consensus" vs "unanimity"**: Used deliberately -- "consensus" for the real-world practice and broader concept; "unanimity" for the formal rule. This is consistent and appropriate. Package U is defined as "Unanimity/Consensus."

3. **Package M / Package U terminology**: Consistent throughout. Defined in Definition 1 and used uniformly.

4. **Proposition numbering in Appendix B**: Systematically off by one from B.2 onward. Appendix B skips Proposition 2 (trivial inequality needing no proof) but does not adjust subsequent numbers. This is the most significant cross-reference error in the document.

5. **Verb tense**: Consistent within sections. Present tense for model exposition and results; present tense for the GATT/WTO discussion.

6. **$\mu_s^{R1}$ vs $\mu_s^{R2}$**: Used consistently and correctly throughout.

7. **$V_e(\mu)$**: Defined on line 123 before first substantive use. Used consistently.

8. **$x \equiv (N-1)\alpha r$**: Defined on line 123. Used consistently in subsequent equations.

9. **Citation format**: Consistent use of brackets `[@key]` for parenthetical citations and `@key` for in-text citations. All keys present in references.bib.

10. **Number formatting**: Consistent (no issues found).

## Score

Starting: 100

| Issue | Deduction |
|-------|-----------|
| Broken cross-reference: Intro line 56 (Prop 4 should be Prop 5) | -5 |
| Broken cross-reference: Appendix B.2 (Prop 2 should be Prop 3) | -5 |
| Broken cross-reference: Appendix B.3 (Prop 3 should be Prop 4) | -5 |
| Broken cross-reference: Appendix B.4 (Prop 4 should be Prop 5) | -5 |
| Notation inconsistency: $v_H(\mu_s^{R1})$ undefined (line 500) | -3 |
| Grammar: "let $x$ ... as a notational shorthand" (line 123) | -3 |
| Inconsistent formatting: contradictory spacing commands (lines 11-12) | -1 |
| Inconsistent formatting: "Bayesian Persuasion" vs "Bayesian persuasion" (lines 50, 313) | -1 |
| Imprecision: "coalition divides" vs "proposer captures" (line 156) | -1 |
| Imprecision: H's R1 payoff from W proposing (line 170) | -1 |
| Unnecessary min() (line 502) | -1 |
| Word choice: "displace" (line 642) | -1 |
| Exposition clarity: y_H^{agg} in Appendix C.3 (line 868) | -1 |

**Score: 67/100**

**Status: FAIL (<80)**

## Key blocking issues

The four broken cross-references in Appendix B (systematic off-by-one error) and the introduction's incorrect Proposition reference are the most serious problems. These would confuse readers attempting to match results in the main text with their proofs in the appendix. The notation inconsistency ($v_H$ undefined) in Theorem 1 is also significant since it appears in the paper's central result.

## Recommended actions (priority order)

1. Fix Appendix B proposition numbering (either renumber B.2-B.4 to reference Props 3-5, or insert a "Proof of Proposition 2" section noting the inequality is trivial).
2. Fix introduction reference: change "(Proposition 4)" to "(Propositions 4 and 5)" on line 56.
3. Replace $v_H(\mu_s^{R1})$ with $v(\mu_s^{R1}, U)$ on line 500.
4. Standardize "Bayesian persuasion" (lowercase) in body text on lines 50 and 313.
5. Fix grammar on line 123.
6. Remove redundant `\doublespacing` on line 11.
