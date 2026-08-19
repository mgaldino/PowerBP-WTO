# N7 Phase A — independent formal-design review, round 1

- `reviewer_role`: `formal_design`
- `reviewer_id`: `review-n7-phaseA-formal-2026-08-19-r1`
- `candidate_hash`: `sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`
- `verdict`: `FAIL`
- `finding_counts`: `critical=1, major=0, minor=0`

## Independence and scope

This was a read-only formal-design review. I did not edit files, inspect any current N7 game-theory review, use private N6 equilibrium records substantively, calculate rents, or analyze `beta=1`.

## Files reviewed in full

- `AGENTS.md`
- `quality_reports/plans/2026-08-12_essential_input_gate0.md`
- `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/SKILL.md`
- `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/references/templates.md`
- `/Users/manoelgaldino/.codex/skills/formal-game-theory-polisci/SKILL.md`
- `quality_reports/2026-08-19_n7_phaseA_comparison_gate_discussion.md`
- `model_redesign/essential_input_n7_phaseA_public_benchmarks_derivation.md`
- `model_redesign/essential_input_n7_phaseA_public_benchmarks_ledger.json`
- `scripts/build_essential_input_n7_phaseA_public_benchmarks.R`
- `scripts/verify_essential_input_n7_phaseA_public_benchmarks.R`
- `model_redesign/essential_input_game_dag.json`
- `model_redesign/essential_input_n7_phaseA_public_benchmarks_candidate_v1.json`

I additionally inspected the current diff of the canonical contract and Gate 0 verifier.

## Method

1. Computed the candidate SHA-256 before substantive review, independently with `shasum` and again with OpenSSL.
2. Reconstructed the public-information games directly from the contract’s primitives, ballot timing, implementation rule, payoff dates, refinement, and tie-breaks.
3. Solved public R2 before public R1 separately for each rule and type.
4. Audited the predeclared N7 schema, coverage partitions, record atomicity, payoff-role typing, continuation IDs, beliefs, boundaries, multiplicity classes, and Phase A exclusions.
5. Audited the contract amendment, lifecycle state, dependency gate, and required Phase A-to-B author stop.
6. Ran the canonical and Phase A verifiers, the dynamic-game DAG checker, an independent formula grid, forbidden-token scan, and whitespace/diff checks.

## Hash check

Both independent commands returned:

`sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`

This exactly matches the required candidate hash and the ledger.

## Detailed checks

### Public-game primitives and information

Conforming:

- `theta` is public from `t=0`; beliefs remain degenerate after every on- and off-path history.
- Only weak states propose.
- Ballots remain simultaneous, sealed, and pure.
- H’s strategy depends on the observed proposal and prescribed pure weak strategies, never on realized votes unavailable before ballot closure.
- The implementation distinction between passage with and without H is preserved, including `y+o_theta` when majority passage occurs without H.
- No opt-out, weak-only state, state-dependent pie, side payment, or historical branch was imported.

### Backward dependency and discounting

Conforming:

- Public R2 records have no continuation source and no internal `beta`.
- Every public R1 record cites all and only its same-rule, same-type public R2 record.
- R1 uses `beta` once in continuation cutoffs.
- Immediate R1 exclusion pays H `o_theta` in current units; it is not incorrectly discounted.
- The independent reconstruction produced:

  - Majority R2: passage without H at `y=0`, proposer payoff `1`, H payoff `o`.
  - Unanimity R2: passage with H at `y=o`, proposer payoff `1-o`, H payoff `o`.
  - Majority R1 weak cutoff `a_M=beta/m` and H pivotal cutoff `beta*o`.
  - Unanimity R1 weak cutoff `a_U=beta*(1-o)/m` and H pivotal cutoff `beta*o`.

### R1 branches, boundaries, and tie-breaks

Conforming:

- Majority inclusion buys `q-2` weak nonproposers and H.
- Majority exclusion buys `q-1` weak nonproposers and sets `y=0`.
- `R_E-R_I=beta*(o-1/m)`, so the partition at `o=1/m` is correct.
- At equality, the authorized proposal tie-break selects inclusion because H receives `beta*o<o`.
- Majority exclusion exceeds delay by `1-beta*q/m>0`.
- Unanimity agreement exceeds delay by `1-beta>0`.
- Consequently, no agreement-delay proposal mixture survives on the authorized `beta in (0,1)` domain.
- `T^Y` is applied only at genuine ballot indifference.

### Coverage and multiplicity

Conforming:

- Both `m=2` and `m>=3` are retained.
- Both public types are covered under both rules and rounds.
- Majority R1 retains pure and proposer-mixed distributions over payoff-equivalent coalitions.
- Symmetric uniform and pure identity-asymmetric coalition choices are preserved.
- The `m=3` exclusion singleton and `m>=4` exclusion multiplicity are explicitly distinguished inside the parameterized family.
- Unanimity correctly contains no public cooperative-versus-difficult identity convention because immediate agreement strictly dominates delay.
- No ballot mixing or cross-branch agreement-delay mixing is introduced.

### Schema, records, and payoff roles

Conforming:

- Top-level, coverage-cell, public-record, payoff-vector, and outcome fields match the existing `complete_information_benchmark_v1` schema.
- No new top-level or record field was added.
- Each parameterized majority record keeps `F_i`, the associated identity-indexed weak payoff map, selection status, outcome, and H/proposer payoff in one atomic record.
- The three payoff roles remain explicit. H’s payoff is scalar because each public record fixes `theta`.
- Public record IDs are unique, and each R1 continuation ID has the correct rule, type, and `m` domain.
- Rent collections remain present but `null`, as Phase A requires.

### Phase A boundary and discussion note

Conforming on content:

- The candidate contains no private-record link, public-private pairing, `RI_M`, `RI_U`, `DeltaRI`, manuscript reference, Goal 5 action, N7 freeze, or `beta=1` analysis.
- N7 remains `pending` and `unfrozen`.
- The discussion note distinguishes genuine proposal mixing, within-branch coalition mixing, identity-asymmetric pure strategies, and belief-only multiplicity.
- It preserves the formal `m=2` domain while identifying `m>=3` as the principal substantive domain.
- Its five author-gate questions cover domain, pure versus mixed, symmetry, outcomes versus assessments, and robust envelopes versus selection.
- The amended contract contains an explicit mandatory stop and new author authorization between Phases A and B.

The lifecycle validity of that amendment fails the separate check below.

## Tests run

- Candidate SHA-256 with `shasum`: exact match.
- Candidate SHA-256 with OpenSSL: exact match.
- `Rscript --vanilla scripts/verify_essential_input_n7_phaseA_public_benchmarks.R`: exit `0`, reported PASS.
- `Rscript --vanilla scripts/verify_essential_input_gate0.R`: exit `0`, reported PASS.
- Dynamic-game checker with execution-order audit: `VALID`; topology `[N1,N2] -> [N3,N4] -> [N6] -> [N7]`.
- Independent primitive-formula grid for `m=2,...,30`: PASS.
- Forbidden Phase A token scan of the candidate: no matches.
- `git diff --check`: clean.

These automated PASS results do not resolve the finding below: the verifiers inspect the newly pinned contract and current DAG state but do not apply Section 12.3 to the observed amendment of Section 11.

## Findings — verbatim

1. **Critical — The Phase A contract amendment invalidates the frozen dependency that the candidate immediately consumes.** The current worktree changes the canonical contract’s Section 11 by replacing the former one-stage Goal 4 review cadence with distinct Phase A review, an intervening author gate, and Phase B review (`quality_reports/plans/2026-08-12_essential_input_gate0.md`, lines 1113–1136). The same canonical contract states without exception that any alteration of Section 11 reopens the readiness Gate 0, returns every derivation node to `pending`, and invalidates prior reviews, freezing, and consumption authorization (lines 1229–1237). Nevertheless, the DAG still records `N6` as `pass/frozen`, the builder requires that state, and the ledger treats its hash as a frozen architectural dependency. The header’s statement that N6 closed and Phase A is open does not resolve the conflict because the contract’s single-source table assigns invalidation exclusively to Section 12, and no prospective-cadence or administrative-edit exception is defined there. Under the literal invalidation rule, N6 was not frozen when N7 Phase A began, so the candidate was produced before its dependency gate was satisfied and this review cannot validly supply a Phase A PASS. Treating the amendment as exempt instead requires a new substantive protocol rule. There is therefore no unique repair forced by the current text.

## Section 11.1 classification

The finding is `substantive` and creates a `pending protocol decision`.

Two materially different readings remain:

1. Apply Section 12.3 literally: reset readiness statuses and resubmit unchanged interfaces under the amended protocol.
2. Treat this future-facing cadence amendment as an administrative exception that preserves prior freezes: this exception must be authorially established in the canonical invalidation rule.

Choosing between them changes whether N6 was consumable and whether the present review cycle is valid. A reviewer or implementer cannot select the repair.

## Counts and verdict

- Critical: `1`
- Major: `0`
- Minor: `0`

`FAIL` on candidate `sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`.

The benchmark’s public-game derivation, schema, and Phase A content boundary otherwise passed the formal-design checks. The shared-contract lifecycle conflict blocks `PASS 0/0/0`; N7 must remain `pending` and `unfrozen`, and no Phase B work is authorized.
