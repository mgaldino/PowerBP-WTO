# Informational Power Through Pivotality

## Project

Formal theory paper on why a hegemon may choose consensus/unanimity in international organizations. The mechanism is informational power through pivotality: under unanimity, weak states must bargain with a privately informed hegemon and therefore face a screening problem; under majority, weak states can exclude the hegemon, so the hegemon's private information does not generate screening rents.

## Current Status

- **Phase**: post-referee proof repair, internal revision of the appendix.
- **Active paper**: `formal_model_v5.Rmd`.
- **Compiled PDF**: `formal_model_v5.pdf`.
- **Most recent proof pass**: 2026-05-10, focused only on appendix proofs.
- **Main-text warning**: the body still contains old theorem statements and exposition that rely on superseded proofs. Do not revise the body until the proof architecture is fully settled.
- **Appendix warning**: Appendix A/B now records what is verified and what is pending. Hidden LaTeX blocks retain superseded derivations in source only; they should not be cited as established results.

## Critical Correction From Referee

The referee was right. The old majority proof treated the hegemon's outside option as if it reduced the institutional pie available to weak states. That is inconsistent with the model. The corrected convention is:

- H's outside option is external to the institutional pie.
- Under majority, a weak proposer excludes H and forms a coalition with other weak states.
- H then receives `alpha V(theta)` externally, not as a payment from the majority coalition.
- Therefore weak-state majority payoffs do not carry the old `(1-alpha)` factor.

Corrected majority formulas:

```text
V_e(mu) = 1 + mu(r - 1)
q = floor(N/2) + 1

V_H^R2(theta,M) = [1 + (N-1)alpha] V(theta) / N
V_W^R2(mu,M)    = V_e(mu) / N

E[V_H^R1(theta,mu,M)] = lambda_M^E V_e(mu)
lambda_M^E = {N[1+(N-1)alpha] - beta(q-1)} / N^2

V_W^R1(mu,M) = kappa_M^E V_e(mu)
kappa_M^E = [N(N-1)+beta(q-1)] / [N^2(N-1)]
```

Important inequality:

```text
lambda_M^E > alpha  iff  alpha < 1 - beta(q-1)/N
```

This condition does not follow automatically from `alpha < 1/r`.

## Strict BF Feasibility Correction

The model is standard two-round Baron-Ferejohn bargaining. Proposals must be feasible in the realized state in which they pass. Since weak states do not know `theta`, a weak-state proposal accepted by the low type must fit inside the low-state pie.

This destroys the old global single-cutoff R1 proof. In R1 when a weak state proposes under unanimity, the correct object is a constrained choice among:

- `A(mu)`: aggressive offer, accepted by low H and rejected by high H;
- `C(mu)`: conservative offer, accepted by both H types;
- `R(mu)`: deliberate rejection / continuation to R2.

The weak proposer chooses:

```text
W_1^prop(mu,U) = max{ A(mu) if feasible, C(mu) if feasible, R(mu) }.
```

For the OPEC calibration `N=13`, `r=1.5`, `alpha=0.19`, `beta=0.9`:

```text
mu_s^R2  = 0.072519
h_C      = 0.340615
h_A      = 0.306000
y_A      = 0.056077
mu_AC    = 0.031188
mu_C^F   = 0.301717
```

The verified W-proposer regimes are:

```text
A for mu < 0.031188
C for 0.031188 < mu <= 0.301717
A for mu > 0.301717
```

Interpretation of A-C-A:

- At low beliefs, high H is unlikely, so W optimally plays aggressive.
- At intermediate beliefs, high H is sufficiently likely and the conservative offer is feasible, so W plays conservative.
- At high beliefs, the conservative offer would require transfers that do not fit in the low-state pie, so strict BF feasibility removes C from the feasible set and W reverts to A.

This is not an ad hoc assumption. It follows from feasibility in the primitive BF bargaining game.

## Verified Results in the Appendix

Verified under corrected accounting and strict BF feasibility:

- Majority produces no screening; corrected `lambda_M^E` and `kappa_M^E`.
- Unanimity R2 continuation values and cutoff:

```text
W_2(mu) = max{(1-mu)(1-alpha), V_e(mu)-alpha r} / N
mu_s^R2 = alpha(r-1)/(r-alpha)
```

- R1 weak-proposer characterization under unanimity as `max{A,C,R}` with feasibility constraints.
- H-proposer lower bound under unanimity:

```text
L_H(mu) =
  (1-mu) beta[1+(N-1)alpha]/N
  + mu [ r - (N-1) beta r(1-alpha)/N ].
```

- Calibrated lower-bound dominance for `N=13`, `r=1.5`, `alpha=0.19`, `beta=0.9`: the lower bound on unanimity exceeds corrected majority for every `mu in [0,1]`.

Endpoint gaps in the calibration:

```text
mu = 0        : 0.079574
mu = 0.031188: 0.077767
mu = 0.301717: 0.062089
mu = 1        : 0.021621
```

This is a calibrated result, not yet a general theorem.

## Pending Proof Work

Do not present these as proven until rederived:

- General conditional dominance theorem.
- Formation-set nesting `F_U subset F_M`.
- Global maximum of weak-state payoff under unanimity.
- Full institutional classification.
- Continuous-types appendix.
- Complete H-proposer pure-strategy PBE characterization outside the pooling region.

The current safe theorem architecture is either:

1. a calibrated theorem for the OPEC parameters using the verified lower bound; or
2. a new sufficient-conditions theorem based on the corrected piecewise `A/C/R` regimes.

## Files

- `formal_model_v5.Rmd`: active paper. Appendix contains the current corrected proof status.
- `formal_model_v5.pdf`: compiled output.
- `quality_reports/notas_reescrita_provas_formulas.md`: detailed external/referee-style proof concerns; input to the correction, not final proof status.
- `quality_reports/avaliacao_sobrevivencia_paper_corrigido.md`: early survivability assessment after the majority-accounting correction; partially superseded by the strict BF report.
- `quality_reports/2026-05-10_strict_bf_rederivacao_provas.md`: internal derivation and audit report for the strict BF correction.
- `CLAUDE.md`: legacy project memory for Claude; keep broadly synced with this file.
- `formal_proofs/`: Lean files. Treat as internal safety infrastructure only.

## Compilation

Use the YAML-defined bookdown format:

```r
rmarkdown::render("formal_model_v5.Rmd")
```

Do not force `output_format = "pdf_document"` unless explicitly debugging, because that bypasses the YAML/bookdown cross-reference setup.

## Operating Rules for Future Sessions

- Start from the appendix proof status, not from the main-text theorem statements.
- Do not do "minimal correction" on formal proofs. Rederive from primitives.
- Do not add ad hoc assumptions to rescue old results.
- Keep majority outside options external to the pie.
- Keep voting sequential and public in the BF sense: R1 proposal, public rejection/acceptance, random R2 proposer after rejection.
- Entry by weak states is collective/all-or-nothing.
- Main body revision comes later, after proof architecture is settled.
- If using agents, separate derivation agents from verification agents and iterate until a verification pass has no reservations.
- Lean is internal only; do not cite Lean in the paper.
- Paper language is English; notes and project documentation can be Portuguese.
- Use R for reproducible reports/figures unless another language is clearly better.

## Next Session Context

Recommended opening prompt for a fresh session:

```text
Estamos no repo PowerBayesianPersuasion. Leia AGENTS.md, formal_model_v5.Rmd Appendix A/B, e quality_reports/2026-05-10_strict_bf_rederivacao_provas.md. O corpo principal ainda está desatualizado; não mexa nele. A tarefa é continuar a rederivação das provas pendentes sob majority outside option externa e strict BF feasibility. Comece por tentar provar um teorema geral ou condições suficientes para dominância condicional usando o regime W-proposer A/C/R e o lower bound do H-proposer. Use agentes independentes para derivar e verificar cada prova.
```
