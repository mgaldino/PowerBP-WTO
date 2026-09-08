# Informational Power Through Pivotality

## Project

Formal theory paper on when consensus/unanimity can benefit a hegemon in international organizations. The mechanism is informational power through pivotality: under unanimity, weak states must bargain with a privately informed hegemon and therefore face a screening problem; under majority, weak states can exclude the hegemon, so the hegemon's private information does not generate screening rents.

## Authority and task scope

The author confirmed on 2026-09-05 that the fundamentals approved in September govern this project. Read `quality_reports/2026-09-01_decisao_exclusao_payoffs_e_fundamentos.md` through its later same-day amendment: an allocation reserved for an excluded actor is paid to no one. These decisions supersede incompatible clauses of the August contracts, historical instructions, and `CLAUDE.md`. Preserve frozen sources and read them with their applicable amendments.

The full replacement and precedence index in `quality_reports/agents_maintenance_2026-09-05/AGENTS.proposed.md` are proposals awaiting author approval. This active file implements the separately authorized removal of historical commands and the clarification of escalation and verification rules.

## Work surfaces and version status

- The manuscript is `formal_model_v6.Rmd`; its compiled output is `formal_model_v6.pdf`. `formal_model_v5.Rmd` and `RIO submission files/` remain protected historical material.
- For a substantive formal change, locate the task's authorized derivation under `model_redesign/` or `quality_reports/`; keep derivation outside the manuscript. The old `power_architecture_derivations.Rmd`, `pivotal_response_*`, and feasibility-branch workspaces are historical.
- Determine manuscript status from the current checkout and the manifests for the relevant pass. Recent records include `quality_reports/2026-09-02_exposition_items20_28_manifest.md`, `quality_reports/2026-09-02_item13_proof_transport_manifest.md`, and `quality_reports/2026-09-02_exposition_technical_notation_revision_manifest.md`. Each review covers its own scope and exact bytes.
- For the essential-input baseline, read `quality_reports/plans/2026-08-12_essential_input_gate0.md` with the September fundamentals and solution-concept amendments below. Its dated phase header describes that historical closure; it does not override later author decisions.
- For agenda-extension status, consult `model_redesign/agenda_extension_STATUS.md` and `model_redesign/agenda_extension_status_current.json`, then the relevant contract and manifest. Do not infer current status from historical DAG fields or reuse a baseline convention in the extension without checking its contract.
- Review PASS, technical readiness, migration, tagging, merge, push, and submission have distinct scopes. An explicit authorization remains valid for its action and scope; a completed technical gate alone does not authorize a new phase.

> ## INVIOLABLE MODEL FUNDAMENTALS (2026-09-01, APPROVED)
>
> Record: `quality_reports/2026-09-01_decisao_exclusao_payoffs_e_fundamentos.md`.
> **Operating rules**: (1) every protocol, convention, or accounting proposal
> is checked against this list BEFORE escalation — a violation is not an
> escalable option, it is a reportable violation; (2) reversing a fundamental
> may only be proposed by naming itself as such ("this reverses fundamental
> #k"), outside any batch, with individual author sign-off. Origin: the D1
> decision of 2026-08-12 (x_H+o) reversed an explicit prohibition without
> announcing itself as a reversal and was caught only at the end — unwritten
> basics lose to written rationales.
>
> 1. **The frame inherited from BF/Kalandrakis is the PROTOCOL**: uniform
>    recognition among weak states, proposals over the pie, ballots,
>    discounted rounds; plus Kalandrakis 2006 as the symmetry benchmark. The
>    disagreement structure is NOT inherited (in BF it is all zeros and
>    adjudicates nothing) — it is a declared domain-specific specification.
> 2. **The institutional comparison is exclusively unanimity vs. majority**,
>    same economy, same ballot protocol.
> 3. **Exactly one informed actor, H**; weak states symmetric, with no private
>    information and no signaling channel of their own.
> 4. **Agreement and disagreement payoffs are mutually exclusive at every
>    history**: a party to a passed agreement receives its allocation; a
>    non-party (H excluded under majority, or terminal disagreement) receives
>    its outside option and nothing from the pie; an allocation to a non-party
>    is paid to no one — the concession is actor-specific and
>    non-transferable. NEVER sum an
>    allocation and an outside option (the D1 x_H+o error, superseded
>    2026-09-01).
> 5. **No restriction on the proposal space** beyond nonnegativity and
>    x_H+Σx_j ≤ 1. No caps (the `\bar x_H`/`y_bar` parameter was deleted).
> 6. **Fixed unit pie** (club surplus of the members); **H's outside option is
>    external to the pie** and invariant to agreements among others (a
>    declared simplification); o_θ is microfounded by **forum shopping** — the
>    privately known value of H's best alternative venue (bilaterals, WIPO,
>    coalitions of the willing); weak states have o=0 for lack of
>    alternatives; π_H=0 in the baseline; b_θ=0.
> 7. **Scope**: distributive club agreements inside the IO — the winning
>    coalition's package allocates benefits among its members and neither
>    binds nor conscripts non-coalition members. Decisions binding the whole
>    membership (assessments, quotas) are out of scope.
> 8. **Pure distributive game**: no externalities, no public goods, no
>    free-riding. Any argument that relies on an actor benefiting from an
>    agreement it is not a party to violates this fundamental.

## Baseline protocol

- Voting no does not give H an immediate, irreversible exit from bargaining. Ballot actions are symmetric; a failed first-round vote leads to continuation. Apply the September agreement/exclusion payoffs whenever a proposal passes.
- Proposals and ballots are sequential across rounds. Within a ballot, the proposer counts as yes; all other actors vote simultaneously, and votes become public only after the ballot closes. Do not give H a new choice after it observes the completed weak-vote vector.
- Derive terminal R2 in current-date units, without `beta`; use `beta*C_2` when those continuation values enter R1. Follow the applicable dependency graph, including its amendments, without reopening completed nodes from an old startup prompt.

> ## DECISION 2026-08-21 — Solution concept FIXED (off-path beliefs, voting, T^Y)
>
> **Normative record: `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`
> (status APPROVED, author's decision). Read it before any N4 derivation or review.**
> **Addendum 2026-09-01 (APPROVED)**: the operational codification of structural
> consistency — which histories share the off-path belief (per-ballot η_Y/η_N
> pairs, quotient over weak coordinates), the zero-Bayes-denominator trigger,
> ballot-local free values — is recorded in
> `quality_reports/2026-09-01_decisao_structural_consistency_baseline.md`.
> Read the September codification together with the August decision.
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

## Decisions and escalation

- Before escalating a finding, consult the applicable decisions and check whether the author has already authorized the relevant action. Resolve routine operational choices and deterministic repairs within the requested scope.
- Escalate unresolved choices that would alter primitives, information, payoffs, the solution concept, formal claims, or substantive interpretation. Explain the concrete alternatives and consequences. Continue work that does not depend on that choice.
- Check every formal proposal against the fundamentals. Report violations; a proposed reversal must identify the affected fundamental and receive individual author approval. Do not batch such reversals with technical corrections.
- Do not add assumptions, discard equilibrium paths, or impose beliefs or outcomes to recover a desired result. Derive the affected argument from the stated primitives and preserve unresolved branches honestly.
- If an instruction causes a pause, cite the exact file and clause and explain its relevance to this task. Distinguish a missing author decision from a routine implementation choice.

## Verification and independent review

- The implementer may compile, run authorized checks, inspect diffs and outputs, and repair problems while working. Report these as implementation checks.
- Formal certification remains independent. Implementation agents edit; review agents inspect without editing the reviewed candidate. Preserve the applicable requirement for two independent full reports on the same hashes, including formal and adversarial review, and adjudicate findings before claiming approval.
- Keep derivations separate from manuscript migration. Verify the argument and its fidelity to the approved model before transporting a new theorem architecture into `formal_model_v6.Rmd`.
- A numerical check covers its tested domain and assertions. It does not certify equilibrium completeness, all deviations, or the full manuscript. Mark results as proved, numerically checked, conjectured, pending, or rejected as appropriate.
- Changed bytes are a new candidate. A historical PASS remains valid for its reviewed snapshot and must not be attributed to edited files without the required renewed review.
- Before a substantive reset, follow `paper-version`; preserve the exact pre-change state and authorial release boundaries. Do not create a tag implying approval of unreviewed or mixed files.

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

## Code and writing

- Keep computation in separate R scripts under `scripts/`. Prefer R for reproducible figures and reports unless another language is clearly better; use `dplyr::select()` for column selection in R.
- Paper language is English; project notes may be Portuguese. Preserve precise terminology and the distinction between informational, outside-option, and agenda power.
- Keep internal node names, review states, and Lean infrastructure out of manuscript exposition. Lean remains internal verification infrastructure.
- In chat, prefer readable equations and explain internal notation when needed.

## Historical record

The complete prior instruction file is preserved byte for byte at `quality_reports/agents_maintenance_2026-09-05/AGENTS.before.md`. The companion `README.md` maps the material removed from active instructions. Consult it for provenance; historical prompts, priorities, findings, and authorizations do not create current work or override the sources above.
