# Informational Power Through Pivotality

## Project

Formal theory paper on why a hegemon may choose consensus/unanimity in international organizations. The mechanism is informational power through pivotality: under unanimity, weak states must bargain with a privately informed hegemon and therefore face a screening problem; under majority, weak states can exclude the hegemon, so the hegemon's private information does not generate screening rents.

## Current Status

- **Phase**: model redesign after post-referee proof repair.
- **Active paper**: `formal_model_v5.Rmd`.
- **Compiled PDF**: `formal_model_v5.pdf`.
- **Most recent proof pass**: 2026-05-10, focused only on appendix proofs. The latest pass added a sufficient-conditions dominance result, calibrated formation-set nesting, and calibrated institutional classification.
- **Redesign decision**: after analyzing the H-proposer signaling subgame, the next version should explicitly separate three sources of power: outside-option power, veto/pivotality power, and proposal power. The main baseline sets `pi_H = 0`, so the R1 agenda is controlled by weak states / non-hegemonic bargaining coalitions. Agenda power is then reintroduced separately through the recognition probability `pi_H`.
- **Architecture reset (2026-05-11)**: abandon state-contingent feasibility as the main screening mechanism. The active redesign now models proposals as relative institutional packages that are feasible in every state. Screening comes from `H`'s type-dependent participation threshold:

```text
U_H(y, theta) = y + b_H(theta)
y_theta^*(mu') = beta C_H(theta, mu') - b_H(theta)
screening requires y_1^*(mu') > y_0^*(mu')
```

- **Archived feasibility branch**: the old feasibility/C-B-R derivation is preserved in git tag `redesign-feasibility-branch-2026-05-11`. It is diagnostic history only. Do not import theorem statements or branch labels from that tag without rederiving them under the new relative-package architecture.
- **Main-text warning**: the body still contains old theorem statements and exposition that rely on superseded proofs. Do not revise the body until the proof architecture is fully settled.
- **Appendix warning**: Appendix A/B now records what is verified for the old random-proposer BF architecture and what is pending. It should be treated as input to the redesign, not as final architecture. Hidden LaTeX blocks retain superseded derivations in source only; they should not be cited as established results.
- **Manuscript freeze**: do not edit `formal_model_v5.Rmd` while the redesigned proof architecture is unsettled. All new formal work should happen first in `model_redesign/power_architecture_derivations.Rmd`, then be transported to the paper only after proofs, checks, and exposition are clean.

## Redesign Decision: Separate Sources of Power

The H-proposer branch under unanimity is not a unique payoff function outside accepted pooling. The complete external check in `quality_reports/h_proposer_response_complete.md` concluded that, under standard pivotal BF voting, no pure-strategy PBE exists outside the maximal accepted-pooling region; mixed/semi-pooling equilibria are selection-dependent on receiver tie-breaking and off-path beliefs.

Do not try to rescue this branch with ad hoc assumptions or equilibrium refinements in the main model. The next version should specify a family of recognition protocols:

```text
pi_H in [0,1],    pi_W = 1 - pi_H
each weak state is recognized with unconditional probability (1 - pi_H)/(N-1)
conditional on weak-state recognition, each weak state has probability 1/(N-1)

Case 1, clean screening baseline: pi_H = 0.
Case 2, neutral BF recognition: pi_H = 1/N.
Case 3, hegemonic agenda power: pi_H > 1/N.
```

The substantive rationale is that the paper is about informational power through pivotality, not agenda power. The baseline stacks the deck against the hegemon: even without formal proposal power, unanimity may let `H` extract informational rents because weak proposers must buy its approval under asymmetric information.

The core claim should be stated as:

```text
Unanimity can favor a powerful privately informed actor not because it gives him more agenda power, but because it transforms his veto/acceptance behavior into an informational constraint on weaker states.
```

Open design choices for the next proof pass:

1. **Baseline recognition**: set `pi_H = 0` in the main model and derive exact closed-form payoffs.
2. **Outside-option stress test**: check the limiting/symmetric case in which `H`'s outside option is no stronger than weak states' outside option. Under the current normalization `d_W = 0`, this corresponds to `alpha = 0`; if the next version allows common positive outside options, state the equivalent normalization explicitly.
3. **Agenda-power extensions**: treat `pi_H = 1/N` and `pi_H > 1/N` as extensions using lower bounds, selection-free bounds, and simulations when the H-proposer signaling branch prevents a unique payoff function.

Start with the `pi_H = 0` clean benchmark unless explicitly instructed otherwise.

## Architecture Reset: Relative Institutional Packages

The next proof pass should start from the clean document
`model_redesign/power_architecture_derivations.Rmd`, not from the archived
C-B-R derivation.

The proposal is a package \(y\in[0,\bar y]\), interpreted as a relative
institutional concession to `H`: quota share, production flexibility, weaker
cut obligation, exception, monitoring/enforcement advantage, or related
institutional term. It is not a fixed transfer that may fail to fit the realized
pie.

The minimal `H` payoff primitive is:

```text
U_H(y, theta) = y + b_H(theta)
```

where `b_H(theta)` is the direct benefit of the agreement to `H`, apart from
the concession `y`. The dynamic participation constraint is:

```text
y + b_H(theta) >= beta C_H(theta, mu')
```

and the threshold is:

```text
y_theta^*(mu') = beta C_H(theta, mu') - b_H(theta)
```

The screening primitive/target condition is:

```text
y_1^*(mu') > y_0^*(mu')
```

Substantively, weak states know the proposed package but do not know how much
they must concede for `H` to prefer agreement to its continuation/outside
option. In the OPEC interpretation, Saudi Arabia knows its spare capacity,
opportunity cost, and outside option; other members observe the quota package
but not Saudi Arabia's participation threshold.

The next derivation must define the weak-state cost of `y`. The intended
reduced-form normalization is one-for-one: increasing `y` by one unit reduces
the residual surplus available to the weak coalition by one unit. Weak voters
receive their continuation values; the weak proposer keeps the residual.

## Separate Formal Workspace

The redesign should not be developed inside `formal_model_v5.Rmd`. The old proof problem arose partly because formulas from an earlier architecture remained in the manuscript after the interpretation of outside options changed.

Use this workflow instead:

1. Work in `model_redesign/power_architecture_derivations.Rmd`.
2. Keep computational checks in separate R scripts under `scripts/`.
3. Mark each result as proved, checked numerically, conjecture, pending, or rejected.
4. Compile and audit the standalone derivation document.
5. Only after the formal architecture is stable, transport results into `formal_model_v5.Rmd`.

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

## Historical Strict BF Feasibility Correction

Historical note only. This was the corrected transfer-based architecture before
the 2026-05-11 relative-package reset. Do not use the A/C/R or C-B-R branch
labels as current proof architecture.

The model was treated as standard two-round Baron-Ferejohn bargaining. Proposals must be feasible in the realized state in which they pass. Since weak states do not know `theta`, a weak-state proposal accepted by the low type must fit inside the low-state pie.

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

- Sufficient-conditions dominance theorem. With `m=N-1`, `A0=1+m alpha`, `A1=1+m alpha r`, and `q=floor(N/2)+1`, the lower-bound unanimity payoff exceeds corrected majority for every `mu in [0,1]` if:

```text
max{
  N A0 / [A0 + m A1 + q - 1],
  N m alpha / [q - 1 + N m alpha]
}
< beta <
N / [N + m alpha(r - 1)]
```

For the OPEC calibration, this reads:

```text
max{0.6842105, 0.8316498} < 0.9 < 0.9193777
```

- Calibrated lower-bound dominance for `N=13`, `r=1.5`, `alpha=0.19`, `beta=0.9`: the lower bound on unanimity exceeds corrected majority for every `mu in [0,1]`.

Endpoint gaps in the calibration:

```text
mu = 0        : 0.079574
mu = 0.031188: 0.077767
mu = 0.301717: 0.062089
mu = 1        : 0.021621
```

- Calibrated formation-set nesting for `N=13`, `r=1.5`, `alpha=0.19`, `beta=0.9`: using a selection-free upper bound on weak-state payoffs under unanimity,

```text
V_W^R1(mu,M) > V_W^R1(mu,U) for every mu in [0,1]
```

Therefore `F_U subset F_M` holds for every entry cost `c` in the calibration. The minimum upper-bound nesting gaps are:

```text
A on [0,0.031188]          : 0.021247
C on [0.031188,0.301717]   : 0.023854
A on [0.301717,1]          : 0.025476
R tie/check                : 0.022868
```

- Calibrated institutional classification is verified for the OPEC parameters because conditional dominance, calibrated nesting, and `lambda_M^E > alpha` all hold. This is calibrated/parametric, not a general theorem.

## Pending Proof Work

Do not present these as proven until rederived:

- Rebuild Appendix A/B under weak-state R1 agenda and relative institutional packages.
- Work in `model_redesign/power_architecture_derivations.Rmd`, not in the active manuscript.
- State the recognition protocol using `pi_H`, with `pi_H = 0` as the baseline.
- Decide whether R2 inherits the same recognition protocol or whether the baseline is weak-proposer-only in both rounds.
- Formalize the weak-state cost of `y` and the residual payoff for the weak proposer.
- Derive R2 unanimity under `U_H(y,theta)=y+b_H(theta)` and thresholds `y_theta^*(mu')`.
- Derive R1 unanimity as pooling/high-threshold package, low-only package, or continuation. Do not use high-state-only feasibility branch `B`.
- Recompute majority payoffs under the new agenda and relative-package protocol.
- Prove conditional dominance under the redesigned relative-package protocol.
- Reprove entry/nesting and institutional classification under the redesigned relative-package protocol.
- Recompute or remove figures that depend on the old H-proposer/random-proposer architecture.
- Rework the OPEC case study so Saudi Arabia is pivotal and privately informed, not the formal R1 agenda setter.
- Reaudit Appendix C only after the redesigned binary model is settled.
- Main-body rewrite, figures, and theorem statements. The body still reflects superseded proof architecture and should not be trusted for proof status.

The current safe theorem architecture is:

1. for the old random-proposer BF model: sufficient-conditions and calibrated results only;
2. for the next paper version: a weak-state-agenda, relative-package model that should restore exact payoffs without solving the H-proposer signaling branch.

## Files

- `formal_model_v5.Rmd`: active paper. Appendix contains the current corrected proof status.
- `formal_model_v5.pdf`: compiled output.
- `model_redesign/power_architecture_derivations.Rmd`: standalone working document for the new proof architecture. Use this as the main work surface until the formal results are clean.
- `model_redesign/README.md`: guardrails for the redesign workspace.
- `quality_reports/notas_reescrita_provas_formulas.md`: detailed external/referee-style proof concerns; input to the correction, not final proof status.
- `quality_reports/avaliacao_sobrevivencia_paper_corrigido.md`: early survivability assessment after the majority-accounting correction; partially superseded by the strict BF report.
- `quality_reports/2026-05-10_strict_bf_rederivacao_provas.md`: internal derivation and audit report for the strict BF correction.
- `quality_reports/bf_unanimity_rederivation_chat.md`: proposed rederivation checked by agents; useful input, but do not promote the global no-pure-PBE claim without the caveats in the later report.
- `quality_reports/2026-05-10_sufficient_conditions_and_nesting.md`: consolidated status after independent derivation/verification agents; current best summary of remaining proof work.
- `quality_reports/h_proposer_response_complete.md`: external ChatGPT Pro analysis of the H-proposer signaling subgame; basis for the redesign decision.
- `quality_reports/2026-05-10_model_redesign_weak_proposer_agenda.md`: current redesign note; use as the starting point for the next proof pass.
- `quality_reports/2026-05-10_power_architecture_piH.md`: refined architecture note separating outside-option power, veto/pivotality power, and agenda power through `pi_H`.
- `quality_reports/2026-05-11_relative_package_reimplementation.md`: architecture reset note; use this with the clean Rmd as the current starting point.
- git tag `redesign-feasibility-branch-2026-05-11`: archived feasibility-branch derivation before the reset. Diagnostic history only.
- `scripts/verify_sufficient_conditions_lower_bound.R`: reproduces the sufficient-conditions beta window and endpoint gaps.
- `scripts/verify_calibrated_nesting_upper_bound.R`: reproduces the calibrated formation-set nesting checks.
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
- Do not introduce a strategic option, voting history, tie-breaking convention, information structure, contract space, or continuation protocol inside a proof unless it is already a stated primitive. If a derivation requires one, stop, label the result `pending protocol decision`, explain the substantive consequence, and ask the user before proceeding.
- No pooling, delay, rejection path, or off-path belief can be imposed. It must be shown to be incentive-compatible under the stated extensive-form game.
- Keep majority outside options external to the pie.
- Under the redesign, keep voting sequential and public. Use `pi_H = 0` in the main baseline so `H` is not an R1 proposer; treat `pi_H > 0` as an extension or robustness exercise.
- Entry by weak states is collective/all-or-nothing.
- Main body revision comes later, after proof architecture is settled.
- Do not edit `formal_model_v5.Rmd` for the redesign until the standalone derivation document has been verified.
- If using agents, separate derivation agents from verification agents and iterate until a verification pass has no reservations.
- Lean is internal only; do not cite Lean in the paper.
- Paper language is English; notes and project documentation can be Portuguese.
- Use R for reproducible reports/figures unless another language is clearly better.

## Next Session Context

Recommended opening prompt for a fresh session:

```text
Estamos no repo PowerBayesianPersuasion. Leia AGENTS.md, model_redesign/power_architecture_derivations.Rmd e quality_reports/2026-05-11_relative_package_reimplementation.md. Não mexa em formal_model_v5.Rmd. A arquitetura antiga de feasibility/C-B-R foi arquivada na tag redesign-feasibility-branch-2026-05-11 e não deve ser usada como prova atual. O baseline novo usa pi_H=0 e propostas como pacotes institucionais relativos, sempre factíveis, com U_H(y,theta)=y+b_H(theta). O screening vem de thresholds y_theta^*(mu')=beta C_H(theta,mu')-b_H(theta), com y_1^*>y_0^*. Comece formalizando o custo de y para weak states e derivando R2 unanimity no documento limpo model_redesign/power_architecture_derivations.Rmd. Crie scripts novos sob scripts/verify_relative_package_*.R; não edite formal_model_v5.Rmd nem reaproveite branch labels C-B-R/B sem rederivação.
```
