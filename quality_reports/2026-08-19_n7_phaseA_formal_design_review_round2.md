# N7 Phase A — Independent Formal-Design Review, Round 2

- `reviewer_role`: `formal_design`
- `reviewer_id`: `review-n7-phaseA-formal-2026-08-19-r2`
- `review_mode`: independent, read-only
- `candidate_hash`: `sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`
- `verdict`: `PASS`

## 1. Independence and scope

I performed this review without editing any file, without spawning another agent, and without inspecting or inferring the verdict of the N7 Phase A game-theory round-2 reviewer.

The review covers:

1. the author’s explicit current-turn decision;
2. the strictly limited Section 12.3 administrative exception;
3. preservation of the frozen N1–N6 dependency chain;
4. the unchanged N7 Phase A public candidate;
5. formal-design, schema, timing, information, coverage, and scope requirements;
6. the mandatory Phase A-to-B author gate.

The candidate was independently hashed before substantive review. The result was exactly:

`sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`

## 2. Files and sources reviewed

- `AGENTS.md`
- `quality_reports/plans/2026-08-12_essential_input_gate0.md`
- the complete current diff of that contract
- the author’s exact current-turn decision, beginning “DECISÃO AUTORAL EXPLÍCITA E ESTRITAMENTE LIMITADA”
- `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/SKILL.md`
- `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/references/templates.md`
- `/Users/manoelgaldino/.codex/skills/formal-game-theory-polisci/SKILL.md`
- `scripts/verify_essential_input_gate0.R`
- `scripts/verify_essential_input_n7_phaseA_public_benchmarks.R`
- `scripts/build_essential_input_n7_phaseA_public_benchmarks.R`
- `model_redesign/essential_input_game_dag.json`
- `model_redesign/essential_input_n7_phaseA_public_benchmarks_candidate_v1.json`
- `model_redesign/essential_input_n7_phaseA_public_benchmarks_derivation.md`
- `model_redesign/essential_input_n7_phaseA_public_benchmarks_ledger.json`
- `quality_reports/2026-08-19_n7_phaseA_comparison_gate_discussion.md`

## 3. Method

I used dependency-safe backward review:

1. independently fixed the reviewed object by SHA-256;
2. compared the author’s eight-item decision against the exact Section 12.3 exception;
3. audited the contract and verifier diff for unauthorized expansion;
4. checked exact frozen artifacts, hashes, lifecycle fields, and prior same-hash reviews for N1, N2, N3, N4, and N6;
5. confirmed that N7 remains absent from the frozen DAG lifecycle;
6. reconstructed the public R2 solutions before checking the public R1 solutions;
7. checked simultaneous sealed-ballot information sets and the impossibility of conditioning on realized votes;
8. checked schema, atomicity, parameterized multiplicity, role-typed payoffs, beliefs, boundaries, tie-breaking, and discount timing;
9. checked complete coverage across rule, round, type, `m` class, proposal class, and identity symmetry;
10. audited the Phase A boundary and mandatory author stop;
11. ran the canonical and independent read-only tests listed below.

## 4. Resolution of the round-1 lifecycle finding

The prior finding is resolved exactly as authorized.

The current contract adds one exception under Section 12.3. It is expressly limited to the already-identified 2026-08-19 change that divided Goal 4 into:

- Phase A public benchmarks;
- a mandatory author gate;
- Phase B authorized comparisons.

The exception faithfully preserves only the previously established `pass/frozen` states, hashes, reviews, and consumption authorization of N1, N2, N3, N4, and N6. It states that the cadence split changed none of the following:

- game or primitives;
- feasibility or actions;
- information or payoffs;
- solution concept or discounting;
- topology or schemas;
- proof obligations;
- review criteria;
- number or independence of reviewers;
- same-hash rule;
- freezing requirements.

The exception also states that it does not apply to any other past or future Section 11 change. The general Section 12.3 invalidation rule therefore remains fully operative outside this precisely identified occurrence.

The worktree evidence matches the author’s implementation limit:

- only the canonical contract and Gate0 verifier differ from `HEAD`;
- the contract diff contains the single exception;
- the verifier changes pin the new exact contract hash, validate the exception, and add negative tests against generalization, Phase B authorization, and N7 freezing;
- no candidate, derivation, ledger, discussion note, DAG, frozen interface, Phase A builder, or Phase A verifier changed.

The author’s remaining restrictions are also preserved:

- the candidate remains on the reviewed hash;
- N7 remains `pending` and `unfrozen`;
- no Phase B comparison or rent computation is authorized;
- this review cannot itself close Phase A or substitute for the second independent PASS and subsequent author consultation.

## 5. Frozen dependency chain

The live artifact hashes are:

| Node | Status | Frozen | Exact artifact hash | Reviews |
|---|---:|---:|---|---|
| N1 | `pass` | `true` | `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` | exactly two, distinct roles and IDs, both `PASS 0/0/0` |
| N2 | `pass` | `true` | `sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2` | exactly two, distinct roles and IDs, both `PASS 0/0/0` |
| N3 | `pass` | `true` | `sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee` | exactly two, distinct roles and IDs, both `PASS 0/0/0` |
| N4 | `pass` | `true` | `sha256:ee61ce6f854d4393f51048592a5221a9999a8f3f7daca1e749e7f19a88927f2d` | exactly two, distinct roles and IDs, both `PASS 0/0/0` |
| N6 | `pass` | `true` | `sha256:e5a71e29720598f829beb4f720bc966a64d2b04569ded0ba404cdd03b81b3f2a` | exactly two, distinct roles and IDs, both `PASS 0/0/0` |
| N7 | `pending` | field absent | field absent | field absent |

The DAG itself remains byte-identical at SHA-256 `aafb39d47b0ae6a06f11b5a4894d82dc6c378e2f67e5d2b49176098066189507`.

Thus the exception preserves already-valid lifecycle evidence; it does not manufacture or relax any freeze fact.

## 6. Formal-design checks

### 6.1 Primitive and concept fidelity

The public benchmark retains the canonical game:

- fixed unit pie;
- `m >= 2` weak states and one hegemon;
- weak-only recognition;
- no exit or opt-out action;
- `o_theta` external to the pie;
- two rounds with terminal R2;
- `beta in (0,1)`;
- PBE with pure ballot strategies;
- stage-undominated voting only for weak nonproposers;
- `T^Y` at genuine equality;
- the proposal-level tie-break minimizing expected H payoff among proposer optima.

No discarded primitive or historical architecture is imported.

### 6.2 Public information and beliefs

Each record fixes `theta` publicly from `t=0`. Beliefs remain degenerate at the public type after every on-path and zero-probability history. There is consequently no free type-belief multiplicity capable of supporting additional public assessments.

The public prior `mu` remains only the interface argument needed for later ex ante images. It does not alter the type-specific public equilibrium.

### 6.3 Simultaneous sealed ballot

The candidate consistently states that H chooses before the simultaneous ballot closes and uses the pure weak-vote count induced by the public proposal and strategies. H never conditions on a realized weak-vote vector.

The complete H response covers:

- passage without H, where `no` strictly yields `y+o_theta` instead of `y`;
- H pivotality, where acceptance uses the relevant reservation cutoff;
- certain failure, where genuine indifference is resolved by `T^Y`.

This preserves simultaneous sealed voting rather than introducing a roll-call or ex post decision.

### 6.4 R2 before R1

Every R2 record has an empty continuation list and contains no `beta`.

Every R1 record cites exactly one public R2 record of the same:

- institution;
- type;
- `m=2` or `m>=3` group.

No R1 record cites N6, a private equilibrium, the other rule, or the other type.

### 6.5 Public R2 benchmarks

Under majority, weak votes alone meet the quota. H is nonpivotal and votes no. The unique proposer optimum is:

`y=0`, every `x_j=0`, `r_i=1`.

The proposal passes without H; H receives `o_theta`.

Under unanimity, H is pivotal and accepts exactly when `y >= o_theta`. Since `o_theta<1`, the unique proposer optimum is:

`y=o_theta`, every `x_j=0`, `r_i=1-o_theta`.

The proposal passes with H. These results are correctly recorded for both types and both `m` groups.

### 6.6 Public R1 majority

The weak cutoff is `a_M=beta/m`, and H’s pivotal cutoff is `beta*o_theta`.

Minimum-cost inclusion gives:

`R_I = 1-beta*o_theta-beta*(q-2)/m`.

Minimum-cost exclusion gives:

`R_E = 1-beta*(q-1)/m`.

Their difference is correctly represented:

`R_E-R_I = beta*(o_theta-1/m)`.

Therefore:

- inclusion is selected for `o_theta<1/m`;
- exclusion is selected for `o_theta>1/m`;
- at `o_theta=1/m`, the authorized proposal tie-break selects inclusion because H obtains `beta*o_theta<o_theta`.

Exclusion strictly dominates delay because:

`R_E-beta/m = 1-beta*q/m > 0`.

Hence no public agreement-delay mixture survives. Multiplicity is limited to distributions over payoff-equivalent coalition identities within the selected branch.

### 6.7 Public R1 unanimity

The weak cutoff is `a_U=beta*(1-o_theta)/m`, and H’s cutoff is `beta*o_theta`. The minimum-cost proposal gives:

`R_U = 1-beta*(m-1+o_theta)/m`.

The immediate-agreement margin is:

`R_U-a_U = 1-beta > 0`.

Thus immediate agreement is strictly preferred to delay throughout the authorized domain. The candidate correctly reports a unique symmetric proposal and no identity-role or agreement-delay multiplicity.

### 6.8 Exactly-once discounting

R2 payoffs are in native terminal units and contain no `beta`. R1 continuation thresholds contain one factor of `beta`.

The independent identities checked include:

- `R_E-R_I = beta*(o_theta-1/m)`;
- `R_U-a_U = 1-beta`;
- `beta*o_theta + (m-1)a_U + R_U = 1`.

No `beta*beta` term or double discount appears.

### 6.9 Coverage and multiplicity

The candidate contains 24 unique records:

- majority R2: 4;
- majority R1: 12;
- unanimity R2: 4;
- unanimity R1: 4.

Coverage is complete for:

- `theta=0` and `theta=1`;
- `m=2` and `m>=3`;
- majority inclusion, boundary, and exclusion regions;
- pure proposals;
- proposer mixing only over payoff-equivalent coalitions;
- symmetric uniform and admissible identity-asymmetric coalition classes;
- the singleton exclusion coalition at `m=3`;
- multiple exclusion coalitions at `m>=4`.

Ballot mixing remains excluded.

### 6.10 Schema and record coherence

The candidate uses the existing `complete_information_benchmark_v1` schema without added fields.

Every public cell:

- has `existence_status=exists`;
- contains exactly one parameterized family record;
- has a null nonexistence certificate;
- retains strategies, beliefs, payoffs, outcomes, sources, assumptions, checks, and selection status atomically.

The parameterized `F_i` representation preserves the full coalition family without splitting or recombining marginal objects.

Public payoffs are correctly typed by role:

- recognized proposer payoff;
- weak pre-recognition payoff;
- scalar hegemon payoff because each record fixes `theta`.

Where coalition identity matters, the weak payoff coordinate is an explicit identity-indexed map, with its symmetric special case and cross-identity mean separately identified.

### 6.11 Phase A boundary

All rent collections remain null. The candidate contains no:

- private source field;
- N6 source hash;
- private equilibrium ID;
- `RI_M`;
- `RI_U`;
- `DeltaRI`;
- comparison selection;
- N7 freeze;
- Goal 5 authority;
- `beta=1` analysis;
- manuscript reference or migration.

The ledger uses N6 only as a frozen readiness dependency and explicitly states that no private record is read or combined.

### 6.12 Discussion note and author gate

The discussion note preserves the formal `m=2` domain while identifying `m>=3` as the main substantive scope. It distinguishes:

- genuine agreement-delay mixing;
- within-branch proposal randomization;
- pure identity-asymmetric strategies;
- belief-only multiplicity.

It supplies the five required author questions concerning:

1. domain;
2. pure versus mixed comparisons;
3. symmetric versus identity-asymmetric classes;
4. assessments versus outcome classes;
5. robust envelopes versus selection.

Its stop condition is explicit: after two same-hash independent `PASS 0/0/0` reviews, work stops for author consultation. It does not imply Phase B authority.

## 7. Read-only verification results

| Check | Result |
|---|---|
| Independent candidate SHA-256 | exact assigned hash |
| Canonical Gate0 verifier | `PASS`; full-contract and mutation rejection checks passed |
| N7 Phase A verifier | `PASS`; 24 typed records and negative fixtures passed |
| Dynamic-game DAG checker | `VALID`; batches `[N1,N2] -> [N3,N4] -> [N6] -> [N7]`; only N7 ready |
| Independent formula grid, `m=2..30` | `PASS` |
| Exact N1/N2/N3/N4/N6 artifact hashes | all matched |
| N1–N6 lifecycle and review audit | each exact node has two distinct-role `PASS 0/0/0` reviews |
| N7 lifecycle audit | `pending`; no frozen, hash, artifact, or review fields |
| `git diff --check` | clean |
| Protected Phase A and frozen-artifact diff against `HEAD` | no differences |
| Worktree scope | only canonical contract and Gate0 verifier modified |
| Unique exception marker | exactly one |
| Candidate forbidden-token scan | no matches |
| Phase A protected-scope checks | passed |

R emitted harmless C-locale startup warnings. One supplemental locale-sensitive UTF-8 marker count was rerun with byte-safe `rg`; the final check found exactly one exception marker. The canonical verifiers were unaffected.

## 8. Findings under Section 11.1

none

## 9. Finding counts

- `critical`: 0
- `major`: 0
- `minor`: 0

## 10. Verdict

`PASS`

The reviewed object is exactly:

`sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`

This verdict applies only to the unchanged N7 Phase A public-benchmark candidate and the precisely authorized administrative lifecycle repair. It does not freeze N7, close Phase A by itself, authorize Phase B, authorize rents or comparisons, open Goal 5, admit `beta=1`, or authorize manuscript work.
