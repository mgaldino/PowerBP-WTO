# Proofread: formal_model_v5.Rmd --- Notation Change E -> F

**Date**: 2026-04-27
**Reviewer**: Claude (proofread skill)
**File**: `formal_model_v5.Rmd`

## Summary

The primary notation change from E_U/E_M/E_R to \mathcal{F}_U/\mathcal{F}_M/\mathcal{F}_R has been executed thoroughly. Zero remnants of the old E_U/E_M/E_R notation were found anywhere in the file -- not in main text, LaTeX environments, figure captions, R code, footnotes, or appendix proofs. The notation table correctly uses "Formation set" for \mathcal{F}_R. However, there are several residual uses of the old descriptive term "entry set" that conflict with the new "formation set" terminology, and three spelling errors on line 67.

## Old notation remnants found (E_U, E_M, E_R)

| Line | Content | Issue |
|------|---------|-------|
| --- | --- | **NONE FOUND. The replacement is complete.** |

All occurrences of `\mathcal{F}_U`, `\mathcal{F}_M`, `\mathcal{F}_R` were verified in: main text (lines 438, 441, 445, 452, 459--463, 470, 477, 479, 563), notation table (line 732), and appendix proofs B.6 (lines 996, 1003, 1019), B.8 (lines 1024, 1026, 1028, 1030). No stale E_U/E_M/E_R symbols remain.

The `$E_\theta[...]$` notation (expectation over theta) appears at lines 280, 392, 416, 998, 1028, 1058 and is correct -- this is the standard expectation operator, not the old entry-set notation.

## Inconsistencies in new notation

| Line | Content | Issue |
|------|---------|-------|
| 436 | `## Entry sets and institutional comparison` | Subsection heading says **"Entry sets"** but text defines them as **"formation set"**. Should be "Formation sets and institutional comparison". |
| 440 | `\begin{corollary}[Unanimity dominance on the entry set]` | Corollary title says **"entry set"** but should say **"formation set"** to match the \mathcal{F} notation. |
| 820 | `the entry set $\{\mu : V_W^{R1} \geq c\}$ can be disconnected` | Footnote uses **"entry set"** as a descriptive term for the set; should say **"formation set"** for consistency. |
| 994 | `## B.6 Proof of Corollary (Unanimity dominance on the entry set) {-}` | Proof header uses **"entry set"**; should match the corollary title, which itself should say **"formation set"**. |

## Other issues found

| Line | Content | Issue | Suggestion |
|------|---------|-------|------------|
| 67 | `unanimiy (everyone must explitcly consent...consensus (no one explictly blocks` | Three typos: **"unanimiy"** (missing t), **"explitcly"** (transposed letters), **"explictly"** (missing i) | `unanimity (everyone must explicitly consent...consensus (no one explicitly blocks` |
| 473 | `(Kamenica and Gentzkow 2011)` | Plain-text citation inside a `\begin{remark}` LaTeX environment. Will not generate a hyperlink or appear in the reference list processing. | Use `\cite{kamenica2011bayesian}` or `\citep{kamenica2011bayesian}` depending on the citation package. Alternatively, since bookdown processes pandoc citations, test whether `[@kamenica2011bayesian]` works inside the remark environment. |
| 484 | `fig.cap="...unanimity formation set disconnected."` | The figure caption correctly uses "formation set" -- consistent with new notation. No issue, noted for completeness. | --- |
| 493--495 | `# p in F_U: U dominates` / `# p in F_M \ F_U` / `# p not in F_M` | R code comments use shorthand `F_U`, `F_M`. Acceptable as code-internal abbreviations since `echo=FALSE`. | No change needed, but if the author prefers full consistency, comments could say "formation set F_U" etc. |

## Cross-reference audit

All `\ref{}` and `\@ref()` cross-references were checked:

- `\ref{thm:conditional}` -- resolves to Theorem 1 (label at line 413). OK.
- `\ref{prop:majority}` -- resolves to Proposition 1 (label at line 279). OK.
- `\ref{prop:cutoff_R1}` -- resolves to Proposition 2 (label at line 296). OK.
- `\ref{prop:jump}` -- resolves to Proposition 3 (label at line 314). OK.
- `\ref{prop:classification}` -- resolves to Proposition 4 (label at line 456). OK.
- `\ref{prop:k_majority_linear}` -- resolves to Proposition 5 in Appendix C (label at line 1057). OK.
- `\ref{cor:dominance}` -- resolves to Corollary (label at line 440). OK.
- `\ref{rem:mu_bar}` -- resolves to Remark 1 (label at line 428). OK.
- `\ref{rem:info_design}` -- resolves to Remark 2 (label at line 472). OK.
- `\ref{lem:VW_max}` -- resolves to Lemma in Appendix B.7 (label at line 1002). OK.
- `\ref{ex:magnitudes}` -- resolves to Example 1 (label at line 378). OK.
- `\ref{ex:institutional}` -- resolves to Example 2 (label at line 476). OK.
- `\ref{def:game}` -- resolves to Definition 1 (label at line 86). OK.
- `\ref{def:netgain}` -- resolves to Definition 2 (label at line 389). OK.
- `\@ref(model)`, `\@ref(example)`, `\@ref(comparison)`, `\@ref(scope)` -- resolve to section anchors. OK.
- Figure refs: `\ref{fig:gametree-a}`, `\ref{fig:gametree-b}`, `\ref{fig:screening-schematic}`, `\ref{fig:heatmap-alpha-mu}`, `\@ref(fig:parameter-regions)` -- all have matching labels. OK.
- Equation refs: `\eqref{eq:cutoff_R1}`, `\eqref{eq:alpha_bar}`, `\eqref{eq:jump_R1}`, `\eqref{eq:alpha_star}`, `\eqref{eq:tau_U_con}`, and all B.5a equation refs -- all have matching labels. OK.
- Notation table references ("Prop. 2", "Sec. 7", "Thm. 1", "Remark 1", etc.) match the actual numbering. OK.

Section numbering in the road map (line 61) matches actual section order:
1=Intro, 2=Example, 3=Model, 4=Majority, 5=Consensus, 6=Entry, 7=Institutional Choice, 8=Discussion, 9=Conclusion. OK.

Appendix C reference to "Section 4" (line 1039) correctly refers to the Majority Rule section. OK.

## Notation table completeness check

The notation table (lines 699--733) includes $\mathcal{F}_R$ with the correct description "Formation set under rule $R$". All symbols used in the main text appear in the table.

## Score

Starting from 100:

- 3 typos on line 67 ("unanimiy", "explitcly", "explictly"): -3 (minor, -1 each)
- 4 residual "entry set" inconsistencies (lines 436, 440, 820, 994): -3 (notation inconsistency, major -3)
- 1 plain-text citation in LaTeX environment (line 473): -1 (minor formatting)

**Score: 93/100** -- ready to circulate/submit after fixing the 8 issues above.

## Summary of required fixes

1. **Line 67**: Fix three typos: unanimiy -> unanimity, explitcly -> explicitly, explictly -> explicitly
2. **Line 436**: Rename subsection heading from "Entry sets" to "Formation sets"
3. **Line 440**: Change corollary title from "entry set" to "formation set"
4. **Line 820**: Change footnote text from "entry set" to "formation set"
5. **Line 994**: Change proof header from "entry set" to "formation set"
6. **Line 473**: Convert plain-text citation to proper LaTeX citation command
