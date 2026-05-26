# Stage 1: Code Review — formal_model_v5.Rmd (Round 1)
Date: 2026-04-27

## Summary

The R code supporting `formal_model_v5.Rmd` consists of a sourced library (`scripts/model_functions.R`, 127 lines, 5 functions) and two inline figure chunks (parameter-regions and heatmap-alpha-mu). All core functions correctly implement the model's formulas as verified algebraically and numerically. No critical or domain bugs found. The code executes without errors and produces results consistent with the paper's claims. Five minor code quality issues identified.

## Files Reviewed

- `scripts/model_functions.R` (127 lines, 5 functions)
- `formal_model_v5.Rmd` setup chunk (lines 39–42)
- `formal_model_v5.Rmd` parameter-regions chunk (lines 484–561)
- `formal_model_v5.Rmd` heatmap-alpha-mu chunk (lines 598–678)

## Code Chunks Inventory

| Chunk | Lines | Purpose | Generates |
|-------|-------|---------|-----------|
| `setup` | 39–42 | Package loading, knitr options | — |
| `parameter-regions` | 484–561 | Institutional classification (p, c) heatmap + boundary curves | Figure 4 |
| `heatmap-alpha-mu` | 598–678 | Conditional payoff dominance in (α, μ) plane, 2x2 panel | Figure 5 |

## Score Calculation

```
Starting Score: 100
- Unnecessary tidyverse dependency (Minor):                        -2
- Code duplication VW/VH unanimity shared preamble (Minor):        -1
- Inconsistent source() call (local=TRUE vs global) (Minor):       -1
- No comments on methodological decisions in figure code (Minor):  -1
```

**Score final: 95/100 → APROVADO**

## Detailed Findings

### Critical Issues

None.

### Major Issues

None. Specifically:
- No syntax errors; script runs cleanly.
- No domain bugs; all formulas match the paper's LaTeX equations.
- No hardcoded absolute paths.
- No randomization used, so no `set.seed()` needed.
- Packages loaded at top of the document.
- No broken cross-references (verified: `\@ref(fig:parameter-regions)` and `\@ref(fig:heatmap-alpha-mu)` resolve correctly via bookdown chunk labels).
- Notation is consistent between code and paper.

### Minor Issues

#### 1. Unnecessary tidyverse dependency (-2)

`library(tidyverse)` is loaded in the setup chunk (line 40) but no tidyverse functions are used anywhere in the Rmd. All plotting is base R; `knitr::kable` is the only non-base function used elsewhere. Loading tidyverse adds ~2 seconds of compilation time and creates a potential version fragility. This is scored as -2 (mixed pipe operators rubric equivalent: unnecessary heavy dependency).

**Recommendation**: Remove `library(tidyverse)` or replace with only the needed packages (none in this case).

#### 2. Code duplication between VW_R1_unanimity and VH_R1_unanimity (-1)

Both functions share identical logic for computing `x`, `mu_s_R2`, `Ve`, `VW_R2`, `omega`, `F1_con`, and `F1_agg` (lines 31–43 in model_functions.R repeated at lines 64–75). This creates maintenance risk if one is updated without the other.

**Recommendation**: Extract shared preamble into a helper function (e.g., `unanimity_regime(r, alpha, mu, N, beta)` returning a list).

#### 3. Inconsistent source() call (-1)

The parameter-regions chunk uses `source("scripts/model_functions.R", local = TRUE)` (line 486), while the heatmap-alpha-mu chunk uses `source("scripts/model_functions.R")` without `local = TRUE` (line 600). Both work because the functions are defined at the top level regardless, but the inconsistency suggests copy-paste without harmonization.

**Recommendation**: Use `local = TRUE` in both for hygiene (avoids polluting the global environment during knitting).

#### 4. Insufficient comments on methodological decisions (-1)

The figure code contains no comments explaining:
- Why `n_grid = 150` was chosen for the heatmap resolution (line 631)
- Why `tol = 1e-6` is the convergence tolerance for bisection in `find_mu_bar` (line 614)
- Why `by = 0.005` / `by = 0.002` grid spacings were chosen in parameter-regions (lines 500–501)

These are reasonable defaults but documenting the rationale (publication resolution, numerical precision requirements) improves reproducibility.

**Recommendation**: Add 1-line comments for grid resolution and tolerance choices.

## Verification Performed

### Formula Verification (model_functions.R)

| Component | Paper Reference | Code | Match |
|-----------|----------------|------|-------|
| x = (N-1)αr | Sec. 3 notation | `(N-1)*alpha*r` | YES |
| μ_s^R2 = α(r-1)/(r-α) | App. A.2 | `alpha*(r-1)/(r-alpha)` | YES |
| V_W^R2 (aggressive) = (1-μ)(1-α)/N | App. A.2 | `(1-mu)*(1-alpha)/N` | YES |
| V_W^R2 (conservative) = (V_e-αr)/N | App. A.2 | `(Ve-alpha*r)/N` | YES |
| ω = (N-2)βV_W^R2 | App. A.3 | `(N-2)*beta*VW_R2` | YES |
| F1_con = V_e - β(r+x)/N - ω | App. A.3 | `Ve - beta*(r+x)/N - omega` | YES |
| F1_agg (full expression) | App. A.3 | matches paper | YES |
| H_prop_0 = [1-(N-1)βV_W^R2]/N | Derivation from B.5a | `(1-(N-1)*beta*VW_R2)/N` | YES |
| H_prop_1 = [r-(N-1)βV_W^R2]/N | Derivation from B.5a | `(r-(N-1)*beta*VW_R2)/N` | YES |
| VH_0 (aggressive) | B.5a Eq. (eq:R1offer_agg) | `H_prop_0 + (N-1)*beta*(1+x)/N^2` | YES |
| VH_1 (aggressive) | B.5a Eq. (eq:R1offer_con_type1) | `H_prop_1 + (N-1)*beta*(r+x)/N^2` | YES |
| VH_0 (conservative) | B.5a | `H_prop_0 + (N-1)*beta*(r+x)/N^2` | YES |
| VH_1 (conservative) | B.5a | `H_prop_1 + (N-1)*beta*(r+x)/N^2` | YES |
| λ_M (majority coefficient) | B.5, Thm. 1 | Algebraically verified ✓ | YES |
| α* formula | Eq. (eq:alpha_star) | `beta*(q-1)/(N*(N-1)-beta*(N^2-N-q+1))` | YES |
| μ_s^R1 formula | Eq. (eq:cutoff_R1), Prop. 2 | `(phi-sqrt(disc))/(2*(N-2))` | YES |
| φ definition | Eq. (eq:cutoff_R1), Prop. 2 | `(r*N-beta*(N-1+r))/(beta*(r-1))` | YES |
| VH_R1_majority total | B.5 | H_prop + W_prop = λ_M·V_e(μ) ✓ | YES |
| VW_R1_majority = (V_e - EVH)/(N-1) | Budget identity | Correct ✓ | YES |

### λ_M Algebraic Verification

Expanding `VH_R1_majority`:
```
EVH = (Ve - (q-1)*beta*(1-alpha)*Ve/N) / N + (N-1)/N * alpha * Ve
     = Ve * [N - beta*(q-1)*(1-alpha)/N + N(N-1)*alpha] / N²
     = Ve * [N(1+(N-1)α) - β(q-1)(1-α)] / N²
     = λ_M * Ve  ✓
```

### Budget Identity Verification (Numerical)

Tested at N=5, r=1.5, α=0.3, β=0.9:
- **Majority (μ=0.5)**: EVH + (N-1)·VW = 1.250 = V_e(0.5). Exact. ✓
- **Unanimity conservative (μ=0.5)**: EVH + (N-1)·VW = 1.250 = V_e(0.5). Exact. ✓
- **Unanimity aggressive (μ=0.1)**: EVH + (N-1)·VW = 1.038 ≤ V_e(0.1) = 1.050. Surplus destruction = 0.012 = (N-1)μr(1-β)/N. Correct. ✓

### Conditional Dominance D(μ) > 0 Check

With N=5, r=1.5, α=0.3, β=0.9, α < α*(5,0.9) = 0.474:
- Grid of 100 beliefs μ ∈ [0.01, 1.00]: min(D) = 0.0396, max(D) = 0.173.
- **All D > 0**: TRUE. Theorem 1 numerically confirmed. ✓

### Worked Example Verification (Example ex:magnitudes)

Paper claims (N=5, r=1.5, α=0.3, β=0.9):
- μ_s^R1 ≈ 0.197: Code gives 0.1970. ✓
- VH just below cutoff ≈ 0.544: Code gives 0.5436. ✓
- VH just above cutoff ≈ 0.602: Code gives 0.6015. ✓
- Jump ≈ 5.3% of expected surplus: Code gives 5.8/1.098 ≈ 5.3%. ✓
- VH majority at cutoff ≈ 0.428: Code gives 0.4280. ✓
- "27% more on aggressive branch": (0.544-0.428)/0.428 = 27.1%. ✓
- "41% more on conservative branch": (0.602-0.428)/0.428 = 40.6%. ✓

### Concavify Algorithm Verification

- Linear input: returns input unchanged (diff < 1e-15). ✓
- Concave input: returns input unchanged. ✓
- V-shaped input: envelope ≥ original values everywhere. ✓
- 2-point edge case: correct (no crash from loop boundary). ✓
- Algorithm: left-to-right steepest-slope sweep with `pmax` correction. Standard and correct.
- Note: the `for (j in (i+2):n)` loop generates a decreasing sequence when `i = n-1`, but the `if (j > n) break` guard prevents out-of-bounds access. Functionally correct but inelegant.

### Edge Case Testing

- μ = 0: VH_R1_unanimity returns valid value (0.5024). No NaN/Inf. ✓
- μ = 1: VH_R1_unanimity returns valid value (0.624). No NaN/Inf. ✓
- μ = 0.001: Valid. ✓
- β = 0.01 (extreme impatience): Valid. ✓
- N = 3 (minimum): Valid. ✓
- N = 200 (large organization): Valid. ✓
- r = 10, α = 0.05: Valid. ✓
- α near 1/r boundary (α = 0.65 with r = 1.5): Valid. ✓

### Cross-Reference Verification

- `\@ref(fig:parameter-regions)`: resolves to chunk `parameter-regions`. ✓
- `\@ref(fig:heatmap-alpha-mu)`: resolves to chunk `heatmap-alpha-mu`. ✓
- `\@ref(example)`, `\@ref(model)`, `\@ref(majority)`, `\@ref(consensus)`, `\@ref(entry)`, `\@ref(comparison)`, `\@ref(discussion)`, `\@ref(scope)`: all correspond to section headers with matching `{#label}` attributes. ✓
- LaTeX theorem references (`\ref{thm:conditional}`, `\ref{prop:classification}`, `\ref{cor:dominance}`, `\ref{rem:mu_bar}`, etc.): all correspond to `\label{}` in LaTeX environments. ✓

### Figure Quality Assessment

- **parameter-regions**: Publication-quality base R plot. Axis labels use `expression()` for math. Color scheme (blue/orange/gray) is colorblind-friendly. Legend present. Boundary curves traced. Screening cutoff annotated. Region labels positioned inside regions. ✓
- **heatmap-alpha-mu**: 2×2 panel layout with `par(mfrow = c(2,2))`. Each panel shows clear blue/red regions with α* dashed line and μ̄(α) curve. Legend in each panel. Title identifies parameters. Grid resolution 150×150 is adequate for publication. ✓

### Non-Proposer Payoff Logic in VW_R1_unanimity

Verified the probability decomposition:
- Focal W proposes: prob 1/N → gets F_proposer/N
- H proposes: prob 1/N → non-proposer W gets beta*VW_R2
- Other W proposes: prob (N-2)/N → depends on regime (aggressive: theta-dependent; conservative: beta*VW_R2)

Sum of probabilities: 1/N + 1/N + (N-2)/N = 1. ✓
Conservative case: nonprop = (1/N + (N-2)/N) * beta*VW_R2 = (N-1)/N * beta*VW_R2. Matches code. ✓
Aggressive case: accounts for theta=1 rejection leading to R2 with mu=1. Matches code. ✓

## Recommendations

1. Remove `library(tidyverse)` from the setup chunk — no tidyverse functions are used.
2. Harmonize `source()` calls to both use `local = TRUE`.
3. Consider extracting the shared preamble of `VW_R1_unanimity`/`VH_R1_unanimity` into a helper function to reduce maintenance risk.
4. Add brief comments explaining grid resolution and tolerance choices in figure code.
5. The `concavify()` function header comment references "formal_model_v3.Rmd" — update to "formal_model_v5.Rmd" for consistency.

None of these affect correctness or compilation. The code is ready for publication.
