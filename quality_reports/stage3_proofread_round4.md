# Stage 3: Proofread Verification -- Round 4

**File**: `formal_model_v2.Rmd`
**Date**: 2026-04-20
**Purpose**: Verify that all 7 fixes from round 3 were applied; scan for remaining issues.

## Fix Verification

| # | Fix | Status |
|---|-----|--------|
| 1 | Line ~276: `\ref{R1consensus}` -> `\@ref(R1consensus)` | VERIFIED -- line 276 now uses `\@ref(R1consensus)` |
| 2 | Line ~883: `\ref{comparison}` -> `\@ref(comparison)` | VERIFIED -- line 883 now uses `\@ref(comparison)` |
| 3 | Line ~99: "have no outside option" -> "had no outside option" | VERIFIED -- line 99 now reads "had no outside option" |
| 4 | Line ~707: bare `\mu_s` -> `\mu_s^{R2}` in jump magnitude | VERIFIED -- line 707 now uses `\mu_s^{R2}` |
| 5 | Line ~839: bare `\mu_s` -> `\mu_s^{R1}` in Prop 5 proof | VERIFIED -- line 839 now uses `\mu_s^{R1}` |
| 6 | Lines ~900-913: bare `\mu_s` -> `\mu_s^{R2}` in Appendix C.1 | VERIFIED -- all occurrences in C.1 now use `\mu_s^{R2}` |
| 7 | Line ~492: "we establish" -> "I establish" | VERIFIED -- line 492 now reads "I establish" |

**All 7 fixes confirmed applied.**

## Remaining Issues Scan

### Cross-references
- All `\@ref()` section references (`R1consensus`, `comparison`, `extension`) point to existing `{#...}` anchors.
- All `\ref{}` LaTeX references (`prop:majority`, `prop:jump`, `lem:conditional`, `thm:main`) point to existing `\label{}` definitions.
- All `\eqref{}` references (`eq:VH1_R2_U`, `eq:VH0_R2_con`, `eq:cutoff_R1`, `eq:jump_R1`) point to existing equation labels.
- Figure references `\@ref(fig:bp-illustration)` and `\@ref(fig:parameter-regions)` match R chunk names `bp_illustration` and `parameter_regions`.

### Notation consistency
- No bare `\mu_s` found anywhere. All 50+ occurrences carry `^{R1}` or `^{R2}` superscript.

### Citations
- All 15 citation keys verified present in `references.bib`.

### Grammar / person consistency
- **Minor issue (line 752)**: "We conjecture" is the only occurrence of first-person plural in the paper. The rest consistently uses "I" (lines 35, 50, 54, 56, 492). Recommend changing to "I conjecture" for consistency. (-1 per rubric: formatting inconsistency)

### No other issues found
- No broken references.
- No typos detected in scanned sections.
- No equation errors found.

## Score

Starting from 100:
- (-1) "We conjecture" -> should be "I conjecture" (line 752, person inconsistency)

**Score: 99/100**

## Recommendation

Ready to commit/circulate. The single remaining issue (line 752: "We" -> "I") is cosmetic and can be fixed in a one-line edit if desired.
