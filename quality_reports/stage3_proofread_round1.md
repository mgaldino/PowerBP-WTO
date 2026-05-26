# Stage 3: Proofread — formal_model_v5.Rmd (Round 1)
Date: 2026-04-27

## Summary

The manuscript is in strong shape for submission. Grammar, notation, and cross-references are nearly all correct. The most notable issue is a clear redundancy in Section 4 (line 287), where a sentence is repeated almost verbatim within the same paragraph. All citations resolve to existing .bib keys. No compilation-blocking issues were found.

## Score Calculation

Starting score: 100

- Redundant sentence in Section 4 (line ~287) [Minor/Style]: -1
- Theorem 1 statement begins with symbol `$\alpha < \alpha^*$` (line ~416) [Minor]: -1
- Appendix B.8 heading says "Proof of Proposition (Institutional classification)" without number, inconsistent with B.1-B.3 pattern (line ~1032) [Minor]: -1
- Notation table: "Iff threshold" capitalization/clarity (line ~734) [Minor]: -1

**Score final: 96/100 -- APROVADO**

## Corrections Table

| # | Line | Current text | Proposed correction | Category | Severity |
|---|------|-------------|-------------------|----------|----------|
| 1 | ~287 | "Because the hegemon's vote is never needed, weak states never face a choice between offers that depend on inferring the hegemon's type. The hegemon's private information affects the value of the agreement but creates no strategic discontinuity. Majority transforms bargaining into coalition arithmetic: the proposer buys the cheapest votes, and the hegemon is simply paid its outside option. Under majority, the hegemon's private information affects the value of the agreement but creates no strategic discontinuity and no screening rent." | "Because the hegemon's vote is never needed, weak states never face a choice between offers that depend on inferring the hegemon's type. Majority transforms bargaining into coalition arithmetic: the proposer buys the cheapest votes, and the hegemon is simply paid its outside option. The hegemon's private information affects the value of the agreement but creates no strategic discontinuity and no screening rent." | Redundancy | Minor |
| 2 | ~416 | "$\alpha < \alpha^*(N, \beta)$ if and only if, for every $\mu \in (0,1]$," | "The condition $\alpha < \alpha^*(N, \beta)$ holds if and only if, for every $\mu \in (0,1]$," | Style (symbol at start) | Minor |
| 3 | ~1032 | "## B.8 Proof of Proposition (Institutional classification) {-}" | "## B.8 Proof of Proposition 4 (Institutional classification) {-}" | Consistency | Minor |
| 4 | ~734 | "$\alpha^*$ & Iff threshold for conditional dominance (Thm.\ 1)" | "$\alpha^*$ & Threshold for conditional dominance (Thm.\ 1): necessary and sufficient" | Clarity | Minor |

## Notes

### Items verified as correct (no issue)

1. **All citations resolve**: Every `@key` in the manuscript matches a key in `references.bib`. Keys used: gould2022consensus, baron1989bargaining, kalandrakis2006proposal, eraslan2019legislative, keohane1984after, steinberg2002shadow, koremenos2001rational, stone2011controlling, ikenberry2001after, gruber2000ruling, jawara2003behind, jones2010manoeuvring, blackhurst2000options, bhagwati2008termites, fearon1995rationalist.

2. **Cross-references**: All `\@ref()` section references (model, example, comparison, scope) match defined section labels `{#label}`. All `\ref{}` references to LaTeX labels (thm:conditional, prop:majority, prop:cutoff_R1, prop:jump, prop:classification, cor:dominance, rem:mu_bar, rem:W_prefers_M, rem:info_design, ex:magnitudes, ex:institutional, def:game, def:netgain, fig:gametree-a, fig:gametree-b, fig:screening-schematic, fig:heatmap-alpha-mu, lem:VW_max, prop:k_majority_linear, eq:cutoff_R1, eq:alpha_bar, eq:jump_R1, eq:alpha_star, eq:tau_U_con, eq:VH1_R2_U, eq:VH0_R2_agg, eq:VH0_R2_con, eq:H_prop_component, eq:R1offer_agg, eq:R1offer_con_type1, eq:W_prop_component, eq:E_bench, eq:delta_R1_derived, eq:delta_R2_derived, eq:Dbase_derived) all have matching `\label{}` definitions.

3. **R chunk figures**: `parameter-regions` (referenced via `\@ref(fig:parameter-regions)` outside LaTeX) and `heatmap-alpha-mu` (referenced via both `\@ref(fig:heatmap-alpha-mu)` outside LaTeX and `\ref{fig:heatmap-alpha-mu}` inside LaTeX remark) are correctly labeled.

4. **Notation consistency**: The symbol $\mu_s^{R1}$ is used consistently throughout for the R1 screening cutoff. The symbol $\mu_s^{R2}$ for R2 cutoff. $D(\mu)$ for the payoff difference. $V_e(\mu)$ for expected cooperation value. $\alpha^*$ for the conditional dominance threshold. No conflicting uses detected.

5. **Section numbering in roadmap** (line 61): Matches actual section ordering (1-Introduction, 2-Example, 3-Model, 4-Majority, 5-Consensus, 6-Entry, 7-Institutional Choice, 8-Discussion, 9-Conclusion).

6. **Mathematical computations verified**:
   - Motivating example: $\mu < 1/9$ derivation correct.
   - "16% of expected surplus" at $\mu=1/9$: $(8/45)/(10/9) = 0.16$. Correct.
   - Jump formula structure in Proposition 3 consistent with derivation in A.4.

7. **Consensus/unanimity usage**: Consistent with stated convention (line 67: used interchangeably, with footnote in Definition 1 explaining equivalence under binary actions).

8. **Hyphenation consistency**: "off-path" used consistently (hyphenated). "vote-buying" used consistently (hyphenated).

9. **Grammar**: Active voice throughout. No dangling modifiers detected. No comma splices. Subject-verb agreement correct throughout.

10. **LaTeX environments**: All `\begin{}` have matching `\end{}`. No unclosed environments detected.

### Observations (not deducted but worth noting)

- **Correction #2 is debatable**: Starting a theorem statement with a symbol is common in mathematics and may be preferred for formal precision. Many published papers in AJPS/JoP do this. The author may choose to keep it as-is.

- **Long paragraphs**: Lines 584 and 586 are very long single paragraphs (the Discussion section). While grammatically correct, JoP editors may request splitting for readability. This is editorial judgment, not a proofread issue.

- **`source("scripts/model_functions.R")` called twice**: Once with `local = TRUE` (line 492) and once without (line 610). Not a compilation issue, but slightly inconsistent.

- **Figure captions**: Both R chunk captions are detailed and complete. The TikZ figure captions (lines 185, 270) are also complete. All figures are referenced in the text.
