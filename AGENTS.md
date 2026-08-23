# Informational Power Through Pivotality

## Project

Formal theory paper on when consensus/unanimity can benefit a hegemon in international organizations. The mechanism is informational power through pivotality: under unanimity, weak states must bargain with a privately informed hegemon and therefore face a screening problem; under majority, weak states can exclude the hegemon, so the hegemon's private information does not generate screening rents.

## Current Status

- **Essential-input chain (2026-08-21):** N1--N4, N6, and terminal N7 are
  `pass/frozen`, each on a final hash with two independent PASS 0/0/0 reviews;
  N5 is absent from the DAG. The author explicitly approved frozen N7 and
  closed Goal 4. Goal 5 was authorized, migrated, and independently reviewed.
- **Goal 5 reviewed snapshot (2026-08-22):** the two independent PASS 0/0/0
  reviews cover only commit `b5fdefb1f80090b8da893bf19e754915d557502a`
  and the exact reviewed bytes of `formal_model_v6.Rmd` (SHA-256
  `32b49f7503caac34cdf225f73d7e76ab60d1340937b095e3e611f009030f8744`)
  and `formal_model_v6.pdf` (SHA-256
  `85d24122008af9ad484a6df53679c3f455f75fb94fffc70aa9ccbd8ffb62fe17`).
  Any later edit, including a manual RStudio edit, creates a new unreviewed
  candidate. It does not alter or invalidate the reviewed historical snapshot,
  which remains recoverable at `b5fdefb`, but the edited bytes must not be
  described as covered by those PASS reviews until they are rendered and
  independently reviewed again.

> ## CURRENT ARCHITECTURE — essential-input (2026-08-12)
>
> **The governing contract is
> `quality_reports/plans/2026-08-12_essential_input_gate0.md`, status APPROVED.**
> It controls over every statement elsewhere in this file. Read it before acting.
>
> **What changed, and what in this file is now superseded:**
>
> 1. **No opt-out action.** Ballot action sets are symmetric: everyone votes
>    yes or no, nobody exits. `H`'s no is only a no, and `H` stays in the game.
>    Every statement below describing an immediate irreversible R1 opt-out for
>    `H`, or "no current or future agreement can include `H`", is **superseded**.
>    That primitive gave `H` a privilege weak states lacked and destroyed the
>    delay option that generates the dynamic informational rent.
> 2. **`o_theta` is a disagreement payoff**, realized at the end of the game if
>    nothing passes, with the same date and discount treatment as every other
>    player's. It is not accessed undiscounted in R1. The clean acceptance
>    threshold `y_theta^* = o_theta` is **superseded**; R1 reservation is the
>    continuation value, R2 threshold is `o_theta` because R2 is terminal.
> 3. **Solution concept: PBE plus stage-undominated voting**, with `T^Y` for
>    exact equality. The 2026-08-05 `pending protocol decision` about whether
>    `T^Y` supersedes undominance at equality is **RESOLVED and was a false
>    dichotomy**: at exact equality both ballot actions are payoff-identical in
>    every contingency, so undominance eliminates nothing and there is nothing
>    to supersede. The two devices have disjoint domains — undominance decides
>    strict cases, `T^Y` decides equality. Dropping undominance was the wrong
>    branch. Stage-undominated voting is a declared refinement of PBE
>    implemented as a strategy restriction, not a belief restriction; do not
>    confuse it with the weak-vote-passive assessment, which is not a refinement.
> 4. **The pie is fixed at 1**, independent of `H`'s type and of `H`'s
>    inclusion. `V(theta)` pies and inclusion-dependent pies are eliminated
>    alternatives, extensions for a different paper. Do not repropose.
> 5. **Derivation order**: `N1` R2-majority, `N2` R2-unanimity, `N3` R1-majority,
>    `N4` R1-unanimity, `N5` entry, `N6` comparison. Difficulty is concentrated
>    in `N4`. Work in `model_redesign/essential_input_*`; the
>    `power_architecture_derivations.Rmd` and `pivotal_response_*` workspaces are
>    provenance only.
>
> **The `pivotal-response` chain (12 nodes, commit `19c431a`) is closed
> provenance.** Its PASS reviews are valid only for the specification they
> reviewed. Do not migrate, cite as current evidence, or edit any of its
> artifacts. The same applies to all Goal-3 PBE-UD artifacts and the Goal-4
> handoff.
>
> **Findings default to escalation.** The burden of proof is on classifying a
> finding as technical, and the test is whether exactly one repair is forced by
> what is already written. Every ambiguity and every missing definition escalates
> to the author, without exception.

> ## DECISION 2026-08-21 — Solution concept FIXED (off-path beliefs, voting, T^Y)
>
> **Normative record: `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`
> (status APPROVED, author's decision). Read it before any N4 derivation or review.**
> Origin: the game-theory audit in `quality_reports/2026-08-21_game-theory-audit_essential_input.md`
> (two independent passes) proved that the provisional N4 proofs relied on mutually
> incompatible conventions. Full conversation record in
> `quality_reports/2026-08-21_conversa_decisao_conceito_solucao.md`.
>
> The decided package, which prevails over earlier formulations of the solution concept:
>
> 1. **Off-path beliefs: no-signaling-what-you-don't-know + structural consistency.**
>    Deviations by weak states (proposals or votes) do NOT move the public belief
>    about `theta`. Only `H`'s actions move beliefs, via Bayes given the profile,
>    including inside off-path subtrees; deviations by `H` itself leave beliefs
>    free. Discarded: literal free beliefs; path-dependent dominance (incoherent —
>    do not repropose).
>    **AMENDMENT (endpoints, Decision 1a)**: when the Bayes denominator is zero,
>    beliefs are free WITHIN the support of the prior — a type with zero prior
>    probability never receives positive posterior. At nu=0 the posterior is
>    identically 0 throughout the tree (nu=1: identically 1); endpoints coincide
>    with the complete-information games (the N7 benchmark). Discarded: structural
>    pinning to the prescribed type (an action cannot identify a nonexistent
>    type); free in [0,1] at endpoints (would resurrect the impossible type
>    off-path). Before any N4 PASS, verify that no off-path endpoint record uses
>    positive posterior on the zero-prior type. **N2 erratum registered (erratum
>    option, Codex's canonical text accepted)**: N2's effective interface is the
>    frozen artifact (`c6a65dc8...a85a2`, byte-identical) read jointly with
>    Amendment 1a — no belief multiplicity at endpoints; interior unchanged.
>    It touches `belief_system.off_path_ballot` and `existence_uniqueness_status`
>    in both cells, the matching derivation passages, claim `N2-CLM-012`, and
>    the belief-class portion of claim `N2-CLM-013`; no payoff changes. Do NOT
>    edit N2 artifacts — full
>    text in the decision record.
> 2. **Weak-state voting: as-if-pivotal.** Expected-value comparison conditional on
>    the pivotal event; when strict, it decides the vote. Pure admissibility (only
>    banning weakly dominated votes) was discarded: with ex-post public vote
>    vectors it sustains vetoes through counterfactual rows built on `H`-vote
>    deviations that never occur.
> 3. **T^Y: expected-value indifference** (integrating `theta` and the recognition
>    lottery) at the pivotal comparison ⇒ vote yes. The contingency-by-contingency
>    reading was discarded (it destroys existence of optimal proposals). This
>    REFINES item 3 of the 2026-08-12 banner: "payoff-identical in every
>    contingency" holds at terminal nodes, not in general; equality is in
>    expected value.
>
> **Accepted consequences**: S_3=(1-nu)B is no longer exact (security rises;
> rederive); payment floors in agreement classes become the current continuation
> value C, not a uniform B; the multi-veto lemma's necessity direction now holds,
> with OPEN veto boundaries (strict inequalities; at exact indifference T^Y forces
> yes); §10.3–§10.7 of the 2026-08-21 proof report must be rederived under this
> package. N1/N2 untouched; N3 needs only the audit's minor repairs (majority
> continuation is belief-free).

- **Phase**: N1--N4, N6, and N7 are `pass/frozen`; the author has closed Goal
  4. Goal 5 was authorized on 2026-08-21, migrated, and reviewed, and **remains
  open**: its terminal author approval is pending, and without it the final tag
  under the `paper-version` workflow cannot be created. The two `PASS 0/0/0`
  reviews of Goal 5 cover only the bytes of commit `b5fdefb`; the current
  manuscript bytes are later and are not covered by them.
- **Target paper for the next manuscript pass**: `formal_model_v6.Rmd`.
- **Target compiled PDF**: `formal_model_v6.pdf`.
- **Previous manuscript baseline (2026-05-15, v5)**: `formal_model_v5.Rmd` carries the fixed-pie relative-package `pi_H=0` baseline and remains the reference history for the post-referee proof repair. The next clean-baseline reset should be derived in `model_redesign/power_architecture_derivations.Rmd` first, then transported into `formal_model_v6.Rmd`, not v5. The v5 paper frames the result as a conditional institutional comparison: consensus can benefit a hegemon through pivotality-based screening, but the model does **not** contain an endogenous rule-choice/signaling stage. The R1 result is stated under a **weak-vote-passive assessment**: weak-state vote deviations are not treated as signals about `H`'s type because weak states do not observe `theta`. Do not describe this assessment as a refinement, D1, intuitive criterion, sequential-equilibrium restriction, or characterization of all PBEs. It is a maintained interpretation of the public voting protocol. The R1 statement should say the selected PBE outcome is payoff-equivalent to one of `P`, `L`, `R`; it is a selection result under the baseline voting assessment, not uniqueness over unrestricted PBEs. The tie-break among weak-proposer payoff ties minimizes `H`'s expected payoff.
- **Most recent manuscript pass**: 2026-05-15. Implemented AJPS/referee-driven exposition fixes in `formal_model_v5.Rmd`: conditional comparison language, No-Cheap-H as a natural hegemonic scope condition, numerical illustration language rather than empirical calibration, `a_0(1)` notation, and a formal rejected-history reduction lemma for R1. Two independent review agents rated the final R1 rejected-history proof **A+** and recommended no further patches. The PDF was recompiled successfully.
- **Review protocol**: the agent that implements must not be the agent that reviews. Any validation/review/audit must be done by independent agents that do not edit files. This applies to formal claims, R scripts, figures, visual quality, and final integration.
- **Most recent proof pass before manuscript integration**: 2026-05-10, focused on appendix proofs. That pass added a sufficient-conditions dominance result, calibrated formation-set nesting, and calibrated institutional classification for the previous corrected BF branch; treat it as diagnostic history unless rederived under the fixed-pie relative-package baseline.
- **Redesign decision**: after analyzing the H-proposer signaling subgame, the next version should explicitly separate three sources of power: outside-option power, veto/pivotality power, and proposal power. The main baseline sets `pi_H = 0`, so the R1 agenda is controlled by weak states / non-hegemonic bargaining coalitions. Agenda power is then reintroduced separately through the recognition probability `pi_H`.
- **Architecture reset (2026-05-11, now extension material for the next proof pass)**: abandon state-contingent feasibility as the main screening mechanism. That reset modeled proposals as relative institutional packages that are feasible in every state and used a delayed-continuation threshold:

```text
U_H(y, theta) = y + b_H(theta)
y_theta^*(mu') = beta C_H(theta, mu') - b_H(theta)
screening requires y_1^*(mu') > y_0^*(mu')
```

**2026-05-25 priority update — SUPERSEDED 2026-08-12.** That update told the
next proof pass to use `b_theta = 0` with an immediate R1 opt-out for `H`. The
opt-out was removed by the essential-input contract; `b_theta = 0` survives.
Do not derive from the opt-out specification. `max{o_theta, beta C_theta}` is
no longer an extension to be assumed: it follows from symmetric ballot actions
with `o_theta` as an end-of-game disagreement payoff.

- **Archived feasibility branch**: the old feasibility/C-B-R derivation is preserved in git tag `redesign-feasibility-branch-2026-05-11`. It is diagnostic history only. Do not import theorem statements or branch labels from that tag without rederiving them under the new relative-package architecture.
- **Manuscript status warning**: `formal_model_v6.Rmd` is the correct target for the next manuscript pass. `formal_model_v5.Rmd` has been updated to the fixed-pie relative-package baseline and remains a reference history file, but do not use it as the target for the clean-baseline reset. Do not reintroduce old feasibility/C-B-R branch labels or old random-proposer theorem language.

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

The 2026-05-11 delayed-continuation primitive was:

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

**SUPERSEDED 2026-08-12.** `b_theta=0` survives. The immediate R1 opt-out and
the threshold `y_theta^* = o_theta` do not. Under the essential-input contract,
`H`'s no is only a no, `H` stays active, and `o_theta` is the disagreement payoff
realized at the end of the game. The R2 threshold is `o_theta` because R2 is
terminal; the R1 reservation is the continuation value, so a direct cutoff in
`o_theta` is not available in R1. Screening still requires `o_1 > o_0`.

What survives unchanged: because ballots are simultaneous, `H` cannot condition
on weak votes that have not been revealed. Derive its voting IC from the payoffs
each action induces across the whole weak-vote vector. Never give `H` a new
decision after observing the ex post vector.

The delayed-continuation extension's target condition is:

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

The redesign should not be developed directly inside `formal_model_v6.Rmd`. The old proof problem arose partly because formulas from an earlier architecture remained in the manuscript after the interpretation of outside options changed.

Use this workflow instead:

1. Work in `model_redesign/power_architecture_derivations.Rmd`.
2. Keep computational checks in separate R scripts under `scripts/`.
3. Mark each result as proved, checked numerically, conjecture, pending, or rejected.
4. Compile and audit the standalone derivation document.
5. Only after the formal architecture is stable, transport results into `formal_model_v6.Rmd`.

## Historical Majority Accounting Correction From Referee

The referee was right. The old majority proof treated the hegemon's outside
option as if it reduced the institutional pie available to weak states. That
accounting is inconsistent with the model. This section records the correction
for the old random-proposer/BF architecture; its formulas are diagnostic
history for the clean reset. The invariant carried forward is that `H`'s
outside option is external to the institutional pie. Whether a majority weak
proposer excludes `H` must be rederived under the clean contract and cannot be
imposed as a primitive.

- H's outside option is external to the institutional pie.
- On the historical majority path where a weak proposer excludes H, it forms a
  coalition with other weak states.
- On that path, H receives `alpha V(theta)` externally, not as a payment from
  the majority coalition.
- Therefore weak-state payoffs on that historical no-H path do not carry the
  old `(1-alpha)` factor.

Historical corrected majority formulas:

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

Do not present these as completed until checked in the active manuscript:

- **Priority 1 for the next proof pass (2026-05-25 clean-baseline reset)**:
  **SUPERSEDED 2026-08-12.** This item required an immediate R1 opt-out, which
  the essential-input contract removed. Current priority 1 is Goal 0 of
  `quality_reports/plans/2026-08-12_essential_input_gate0.md`. `b_theta = 0` and
  `t_theta = d_theta - b_theta` as extension both survive; the opt-out and the
  `power_architecture_derivations.Rmd` workspace do not. Do not edit
  `formal_model_v6.Rmd` until Goal 4.
- Run a full independent review of the target `formal_model_v6.Rmd` after the clean-baseline reset is migrated. The v5 R1 rejected-history lemma has A+ independent review, but the target manuscript still needs its own coherence pass after changes.
- Check that every theorem statement, figure caption, and table caption uses the fixed-pie relative-package `pi_H=0` language and does not import feasibility/C-B-R branch labels.
- Reaudit Appendix C only after the binary fixed-pie model is treated as stable.
- Decide whether to add a separate appendix extension for endogenous rule choice/signaling. The main paper currently holds rule choice fixed to isolate screening; a future extension may illustrate how rule-choice signaling can reduce, leave unchanged, or amplify screening.
- Treat `pi_H>0` and H-proposer agenda power as extensions using lower bounds, selection-free bounds, or simulations. Do not fold them into the main theorem without rederivation.
- Keep No-Cheap-H as a natural hegemonic scope condition. The complementary case `a_0^M < beta/m` is mathematically possible but peripheral for hegemon/weak-state applications; if used, mark it as an extension.

The current safe theorem architecture is:

1. for the active paper: a weak-state-agenda, fixed-pie relative-package `pi_H=0` model with selected R1 outcomes under the weak-vote-passive assessment;
2. for the old random-proposer BF model: historical sufficient-conditions and calibrated results only, useful as diagnostic history but not as the current manuscript architecture.

## Files

- `formal_model_v6.Rmd`: target manuscript for the next pass. It should receive the clean-baseline reset only after separate derivation and review in `model_redesign/`.
- `formal_model_v6.pdf`: current compiled target manuscript PDF, if present.
- `formal_model_v5.Rmd`: previous manuscript baseline/reference history. Appendix contains the corrected v5 proof status.
- `formal_model_v5.pdf`: compiled v5 reference output.
- `quality_reports/2026-05-15_ajps_revision_scope_after_discussion.md`: scope and implementation notes for the AJPS/referee-driven revision pass, including weak-vote-passive language, rejected histories, No-Cheap-H, rule-choice framing, numerical illustration, and tie-break handling.
- `quality_reports/plans/2026-08-12_essential_input_gate0.md`: **the governing contract**, status APPROVED. Symmetric ballot actions with no exit, `o_theta` as end-of-game disagreement payoff, PBE plus stage-undominated voting with `T^Y` at equality, fixed pie, derivation order `N1`..`N6`, finding-escalation rule, and the Goal 0 opening prompt in Section 14.
- `quality_reports/2026-05-25_clean_baseline_priority.md`: **historical, superseded 2026-08-12**. Records the clean-baseline reset with immediate R1 opt-out. The opt-out was removed; do not derive from this note.
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
- `scripts/run_coarse_review.py`: safe wrapper for `coarse-review`; validates the OpenRouter key from macOS Keychain before running and prevents stale `OPENROUTER_API_KEY` values inherited by Codex sessions.
- `CLAUDE.md`: legacy project memory for Claude; keep broadly synced with this file.
- `formal_proofs/`: Lean files. Treat as internal safety infrastructure only.

## Compilation

For the target manuscript, use the YAML-defined bookdown format:

```r
rmarkdown::render("formal_model_v6.Rmd")
```

Do not force `output_format = "pdf_document"` unless explicitly debugging, because that bypasses the YAML/bookdown cross-reference setup.

## Coarse Review

When asked to run `coarse-review`, do **not** call `uvx ... coarse-review` directly. Use the safe wrapper:

```bash
python3 scripts/run_coarse_review.py formal_model_v6.pdf
```

The wrapper validates `OPENROUTER_API_KEY` against the OpenRouter `/api/v1/key` endpoint before launch, prefers the macOS Keychain value over any inherited environment variable, pre-extracts PDF text with `pdftotext` when available, and passes the validated key explicitly to the `coarse-review` subprocess. This prevents the recurring failure mode where a Codex session inherits an old/stale `OPENROUTER_API_KEY` even though the renewed key in the shell/Keychain is valid. If the user asks why or seems likely to run the old command manually, tell them to use the wrapper because direct `coarse-review` can silently pick up a stale environment key.

## Operating Rules for Future Sessions

- Before any substantive manuscript reset, use the `paper-version` workflow. Do not create a misleading tag on a dirty worktree; first resolve or commit the relevant state, then tag the intended snapshot.
- Start from the separate derivation in `model_redesign/power_architecture_derivations.Rmd`; when ready to migrate to the manuscript, target `formal_model_v6.Rmd`. Use `formal_model_v5.Rmd` only as reference history for the 2026-05-15 integration pass and appendix proof status.
- **SUPERSEDED 2026-08-12.** The clean-baseline reset with immediate R1 opt-out
  is no longer the priority and its central primitive was removed. Priority 1 is
  now Goal 0 of the essential-input architecture: version boundary, dependency
  map, and independent review of the contract itself, with no derivation. See
  `quality_reports/plans/2026-08-12_essential_input_gate0.md`. `b_theta = 0`
  survives; immediate opt-out does not. `max{o_theta, beta C_theta}` is now a
  consequence of the symmetric design rather than an extension to be assumed.
- Do not do "minimal correction" on formal proofs. Rederive from primitives.
- Do not add ad hoc assumptions to rescue old results.
- Do not remove a branch, case, result, or equilibrium path by adding an ad hoc
  protocol restriction or assumption. If a branch is substantively undesirable,
  either prove it is not an equilibrium under the stated game, keep it and
  interpret it honestly, or explicitly mark the issue as unresolved.
- Do not introduce a strategic option, voting history, tie-breaking convention, information structure, contract space, or continuation protocol inside a proof unless it is already a stated primitive. If a derivation requires one, stop, label the result `pending protocol decision`, explain the substantive consequence, and ask the user before proceeding.
- The baseline tie-break is `T^Y`: a responder accepts an offer exactly equal to
  its outside/continuation value. **The interaction with undominance is resolved
  and is not pending**: at exact equality both ballot actions are payoff-
  identical in every contingency, so undominance eliminates nothing and `T^Y`
  is not superseding anything. Undominance decides strict cases; `T^Y` decides
  equality. `T^Y` exists so that the set of approvable offers is closed and the
  proposer's problem has a maximum. Resolve terminal R2 without `beta` and use
  `beta*C_2` only when R2 continuation values enter R1 incentives.
- No pooling, delay, rejection path, or off-path belief can be imposed. It must be shown to be incentive-compatible under the stated extensive-form game.
- Keep majority outside options external to the pie.
- **Voting-protocol terminology**: the bargaining game is sequential and public
  **across rounds**: a proposal is made, a ballot is held, the complete vote
  vector and outcome become public, and only then does any continuation occur.
  This does **not** mean sequential roll-call voting within a ballot. Within
  each ballot, the proposer is counted as voting yes; all other states vote
  simultaneously; and individual votes are publicly revealed only after all
  ballots have been cast. Use this same ballot protocol under unanimity and
  majority, changing only the quota. A sequential roll-call protocol, in which
  later voters observe earlier votes, is a separate extension that requires an
  explicit voting order and full rederivation of beliefs and incentive
  constraints.
- Use `pi_H = 0` in every bargaining round of the main baseline, so `H` is
  never a proposer there; treat `pi_H > 0` as an extension or robustness
  exercise.
- Use the term **weak-vote-passive assessment** for the baseline belief assessment. Do not call it a refinement. The defense is informational: weak states do not observe `theta`, so their unilateral vote deviations do not directly signal `H`'s type; `H`'s own separating vote can update beliefs; on-path beliefs follow Bayes' rule.
- The `P`/`L`/`R` characterization and the rejected-history reduction lemma are
  verified results for the v5 reference architecture, not primitives of the
  clean immediate-opt-out reset. During that reset, treat them as historical
  candidates and preserve them only if they are rederived under the new
  extensive-form game. If they do survive, state R1 as a selected PBE outcome
  payoff-equivalent to `P`, `L`, or `R` under the maintained assessment, not as
  uniqueness or an all-PBE characterization. If they do not survive, record
  that result in the survival matrix and use the new characterization rather
  than imposing the old lemma.
- Maintain implementer/reviewer separation: implementation agents edit; review agents do not edit.
- For the clean-baseline reset, run two independent read-only review passes after implementation: one formal-model review and one adversarial math/game-theory audit. The implementer must not be either reviewer.
- Entry by weak states is collective/all-or-nothing.
- The v5 main body has been revised to the fixed-pie `pi_H=0` baseline, but the next target is v6 and it still needs a full independent coherence review before final submission.
- Do not edit `formal_model_v6.Rmd` to add new theorem architecture unless the result has first been derived and checked separately.
- If using agents, separate derivation agents from verification agents and iterate until a verification pass has no reservations.
- Lean is internal only; do not cite Lean in the paper.
- Paper language is English; notes and project documentation can be Portuguese.
- Use R for reproducible reports/figures unless another language is clearly better.
- In chat explanations, avoid raw LaTeX that may not render. Prefer plain-text
  equations such as `a1 = beta*d1 - b1` and step-by-step arithmetic.

## Next Session Context

The canonical executable specification is
`quality_reports/plans/2026-08-12_essential_input_gate0.md`, status APPROVED.
Its Section 14 opening prompt governed the original Gate 0 opening. Later
explicit authorial decisions authorized and closed Goal 4 through frozen N7;
see `quality_reports/2026-08-21_fechamento_autoral_goal4_n7.md`. Goal 5 was
authorized on 2026-08-21 and remains open, awaiting terminal author approval;
see `quality_reports/2026-08-21_autorizacao_goal5.md`. The canonical source for
phase status is the Gate 0 contract header.

`quality_reports/plans/2026-08-03-clean-baseline-goal.md` and the prompt below
are **historical**. They specify the immediate-opt-out architecture that was
removed on 2026-08-12. Do not execute them.

Historical opening prompt, superseded — do not run:

```text
Estamos no repo PowerBayesianPersuasion. Leia AGENTS.md, formal_model_v6.Rmd, formal_model_v5.Rmd, quality_reports/2026-05-15_ajps_revision_scope_after_discussion.md e quality_reports/2026-05-25_clean_baseline_priority.md. O alvo correto do próximo manuscrito é formal_model_v6.Rmd; formal_model_v5.Rmd é referência histórica da integração de 2026-05-15. Prioridade 1: antes de mexer no manuscrito v6, rederivar em model_redesign/power_architecture_derivations.Rmd o baseline limpo com b_theta=0 e opt-out imediato de H em R1: se H rejeita, nenhum acordo inclui H e o tipo theta recebe o_theta sem desconto. Trate delayed continuation dentro da IO, o caso hibrido max{o_theta,beta C_theta} e t_theta=d_theta-b_theta como extensões/microfundamentos. Preserve o protocolo adotado: o jogo é sequencial e público entre rodadas, mas dentro de cada ballot todos os não proponentes votam simultaneamente e os votos individuais só se tornam públicos após o fechamento; isso não é votação roll-call sequencial. Use paper-version/git tag workflow antes de qualquer reset substantivo, mas não crie tag enganosa em worktree suja. Preserve a linguagem de comparação institucional condicional, weak-state agenda pi_H=0 e weak-vote-passive assessment quando migrar para v6. Trate P/L/R e o rejected-history reduction lemma de v5 como candidatos históricos: preserve-os somente se forem rederivados no novo extensive form e, nesse caso, não alegue unicidade nem caracterização de todos os PBEs. Após implementar o reset, dois revisores independentes e sem edição devem revisar: um com formal-model review e outro com adversarial math/game-theory audit.
```
