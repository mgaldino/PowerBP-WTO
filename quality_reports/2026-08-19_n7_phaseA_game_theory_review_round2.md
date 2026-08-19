# N7 Phase A Public Benchmarks — Independent Game-Theory Review, Round 2

reviewer_role: game_theory  
reviewer_id: review-n7-phaseA-game-2026-08-19-r2  
candidate_hash: sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5  
review_mode: independent, adversarial, read-only  
verdict: PASS  
finding_counts: critical=0, major=0, minor=0

## 1. Independence and object identity

I did not edit any file, execute the writing builder, or inspect any Round-2 `formal_design` review or verdict.

Before the substantive review, I independently computed the candidate SHA-256:

```text
db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5
```

This exactly matches:

```text
sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5
```

I recomputed the hash after all read-only tests; it remained identical. The candidate also has no diff from `HEAD`.

## 2. Files and authority reviewed

I reviewed:

- `AGENTS.md`
- `quality_reports/plans/2026-08-12_essential_input_gate0.md`
- the exact current diff to that contract
- the explicit author decision supplied in the current turn
- `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/SKILL.md`
- `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/references/templates.md`
- `/Users/manoelgaldino/.codex/skills/formal-game-theory-polisci/SKILL.md`
- `quality_reports/2026-08-19_n7_phaseA_comparison_gate_discussion.md`
- `model_redesign/essential_input_n7_phaseA_public_benchmarks_derivation.md`
- `model_redesign/essential_input_n7_phaseA_public_benchmarks_ledger.json`
- `model_redesign/essential_input_n7_phaseA_public_benchmarks_candidate_v1.json`
- `scripts/build_essential_input_n7_phaseA_public_benchmarks.R`
- `scripts/verify_essential_input_n7_phaseA_public_benchmarks.R`
- `scripts/verify_essential_input_gate0.R`
- `model_redesign/essential_input_game_dag.json`
- the exact predecessor artifact hashes for `N1`, `N2`, `N3`, `N4`, and `N6`

## 3. Section 12.3 administrative exception

The repair faithfully records the author’s narrowly limited decision in Section 12, the contract’s sole canonical source for invalidation.

The exception:

- applies only to the specific 2026-08-19 change splitting Goal 4 into Phase A, a mandatory author gate, and Phase B;
- preserves the already reviewed `pass/frozen` states, hashes, reviews, and consumption readiness of `N1`, `N2`, `N3`, `N4`, and `N6`;
- gives an expressly administrative and prospective rationale;
- does not alter the game, primitives, feasibility, actions, information, implementation, payoffs, solution concept, discounting, topology, schemas, proof obligations, review standards, reviewer count or independence, same-hash rule, or freeze requirements;
- does not apply to any other past or future Section 11 change;
- does not permit predecessor-interface changes, finding reclassification, reduced testing, or waived review;
- leaves `N7` `pending` and `unfrozen`;
- does not authorize public-private pairing, Phase B, rents, comparison selection, `N7` freeze, Goal 5, `beta=1`, or manuscript work.

The working-tree diff contains only:

1. the 20-line Section 12.3 exception; and
2. technically forced Gate 0 verifier changes: the new exact contract hash, validation of the unique exception, three targeted negative mutations, and an updated diagnostic message.

`git diff --check` passed. No candidate, derivation, ledger, DAG, schema, predecessor interface, manuscript, or protected provenance artifact changed.

The current contract hash is:

```text
sha256:6900b8a87f224bd8ae4f4e9a231b5a60aae45a1639283aaf1ef09bd26605d63e
```

The Gate 0 verifier combines that complete byte-level contract identity with semantic checks. Its added negative fixtures reject:

- generalizing the exception to other Section 11 changes;
- using it to authorize public-private linkage or Phase B;
- using it to pass or freeze `N7`.

Because complete contract identity is also pinned, an untested textual qualification cannot be added while retaining validation.

## 4. Lifecycle and predecessor audit

The DAG remains byte-identical at:

```text
sha256:aafb39d47b0ae6a06f11b5a4894d82dc6c378e2f67e5d2b49176098066189507
```

The exact frozen predecessor artifacts remain:

| Node | Status | Frozen | Artifact hash |
|---|---:|---:|---|
| `N1` | `pass` | `true` | `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` |
| `N2` | `pass` | `true` | `sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2` |
| `N3` | `pass` | `true` | `sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee` |
| `N4` | `pass` | `true` | `sha256:ee61ce6f854d4393f51048592a5221a9999a8f3f7daca1e749e7f19a88927f2d` |
| `N6` | `pass` | `true` | `sha256:e5a71e29720598f829beb4f720bc966a64d2b04569ded0ba404cdd03b81b3f2a` |

For each node, the current Gate 0 verifier checked the exact artifact bytes, object-identical DAG interface, dependency hashes, execution order, two distinct reviewer roles and IDs, same-hash `PASS`, and zero critical, major, and minor findings.

`N7` remains exactly:

- `status = pending`;
- without `frozen`, `artifact_hash`, `artifact_path`, or `reviews`;
- with all DAG interface collections still null.

`N6` is used in Phase A only as the frozen architectural prerequisite. The public candidate contains no `N6` hash, private record ID, private equilibrium ID, public-private pair, or rent object. The ledger labels `N6` use as “readiness only; no private equilibrium record is read or combined.”

## 5. Cold derivation from public-game primitives

I rederived the benchmark without treating `N6` or any private-information equilibrium as a premise. Fix public `theta` and write `o=o_theta`.

Let:

```text
m = N-1 >= 2
q = floor((m+1)/2)+1 <= m
a_M = beta/m
a_U = beta*(1-o)/m
b   = beta*o
```

### R2 majority

Every weak nonproposer votes yes after every proposal:

- if `x_j>0`, yes weakly dominates no;
- if `x_j=0`, the actions are identical and `T^Y` selects yes.

The `m` weak votes, including the proposer, already meet `q`. Therefore `H` is nonpivotal and strictly votes no because no pays `y+o` while yes pays `y`.

The unique proposer optimum is:

```text
y=0
x_j=0 for every weak nonproposer
r_i=1
```

It passes without `H`. Payoffs are proposer `1`, each weak identity ex ante `1/m`, and `H=o`, all in native R2 units with no `beta`.

### R2 unanimity

Weak nonproposers again vote yes after every proposal. `H` is pivotal and votes yes iff `y>=o`, with `T^Y` selecting yes at equality.

Because `o<1`, the unique optimum is:

```text
y=o
x_j=0 for every weak nonproposer
r_i=1-o
```

It passes with `H`. Payoffs are proposer `1-o`, each weak identity ex ante `(1-o)/m`, and `H=o`, with no R2 discount factor.

### Complete R1 voting strategies

Because public `theta` is fixed and the R2 public solution is payoff-unique, every failed R1 ballot under a fixed rule leads to the same continuation value. Thus a weak nonproposer votes:

```text
majority:   yes iff x_j >= beta/m
unanimity: yes iff x_j >= beta*(1-o)/m
```

Strict cases follow stage-undominance; equality is genuine and `T^Y` selects yes.

Let `k` be the total number of prescribed weak yes votes, including the proposer. Before the simultaneous sealed ballot, `H` knows the proposal and the induced pure weak strategies but does not observe realized votes.

Under majority:

```text
k >= q:     H is nonpivotal and votes no
k = q-1:    H is pivotal and votes yes iff y >= beta*o
k <= q-2:   failure is certain and T^Y selects yes
```

Under unanimity:

```text
k = m:      H is pivotal and votes yes iff y >= beta*o
k < m:      failure is certain and T^Y selects yes
```

These strategies cover every proposal and every pivotal, nonpivotal, and certain-failure case without introducing roll-call observation.

### R1 majority proposer problem

Minimum-cost inclusion buys `q-2` weak nonproposers and `H`:

```text
y=beta*o
x_j=beta/m for q-2 selected weak states
x_j=0 otherwise
R_I=1-beta*o-beta*(q-2)/m
```

Minimum-cost exclusion buys `q-1` weak nonproposers:

```text
y=0
x_j=beta/m for q-1 selected weak states
x_j=0 otherwise
R_E=1-beta*(q-1)/m
```

The branch difference is:

```text
R_E-R_I = beta*(o-1/m)
```

Therefore:

- `o<1/m`: inclusion;
- `o>1/m`: exclusion;
- `o=1/m`: proposer payoff tie.

At equality, the stipulated proposal tie-break selects inclusion because `H` receives `beta*o` under inclusion and `o` under exclusion, with `beta<1` and `o>0`.

Exclusion strictly dominates deliberate delay:

```text
R_E-a_M = 1-beta*q/m > 0
```

Hence the selected agreement branch also strictly dominates delay. Failure, agreement-delay mixing, excess payments, extra coalition members, positive `y` under exclusion, and budget slack cannot maximize proposer payoff.

### R1 unanimity proposer problem

All `m-1` weak nonproposers and `H` must be bought at their exact continuations:

```text
y=beta*o
x_j=beta*(1-o)/m for every j != i
R_U=1-beta*(m-1+o)/m
```

This proposal is feasible, exhausts the pie, and passes immediately with `H`. It strictly dominates delay because:

```text
R_U-a_U = 1-beta > 0
```

Thus there is no failure, delay, or agreement-delay mixing.

### Feasibility, beliefs, and multiplicity

All selected offers are feasible because `o<=o_1<=y_bar`, `beta<1`, and `q<=m`. Any slack or payment above a binding response cutoff can be transferred to the proposer without changing the ballot outcome, so an optimal public proposal uses the full pie.

Public `theta` makes beliefs degenerate after every on-path and zero-probability history. Belief variation therefore cannot generate additional public assessments.

Multiplicity is classified correctly:

- `m=2`: both majority inclusion and exclusion coalitions are unique;
- `m>=3`: majority inclusion has multiple coalition identities;
- majority exclusion is unique at `m=3` and multiple at `m>=4`;
- any proposer randomization is confined to payoff-equivalent coalitions inside the already selected branch;
- unanimity proposals and full payoff vectors are unique;
- majority coalition composition can change weak identity payoffs, but not the branch, outcome, proposer payoff, or `H` payoff.

The identity-indexed weak payoff formulas and their cross-identity means are correct. All ballots remain pure.

## 6. Candidate completeness

The candidate contains exactly 24 typed public records:

- four majority R2 records;
- twelve majority R1 records covering both types, `m=2`/`m>=3`, and `<`, `=`, `>` relative to `1/m`;
- four unanimity R2 records;
- four unanimity R1 records.

Every R1 record cites exactly the same-rule, same-type, same-`m`-group R2 record. The `theta=0` and `theta=1` records correctly substitute `o_0` and `o_1`. R2 contains no discount factor; every R1 continuation threshold contains exactly one `beta`.

All rent collections are null. The candidate contains no `RI_M`, `RI_U`, `DeltaRI`, private source, `N6` source, Goal 5, manuscript target, or `beta=1` object.

## 7. Verifier and negative-test audit

The following read-only commands both exited successfully:

```text
Rscript --vanilla scripts/verify_essential_input_n7_phaseA_public_benchmarks.R
Rscript --vanilla scripts/verify_essential_input_gate0.R
```

The Phase A verifier confirmed the exact candidate hash, 24-record partition, public beliefs, same-rule/type continuations, formulas, pure ballots, identity-indexed coalition families, timing, protected scope, null rents, and pending/unfrozen lifecycle.

Its negative fixtures reject:

- non-null rent or contrast collections;
- extra schema fields;
- missing type or `m=2` coverage;
- cross-rule continuation IDs;
- private-source fields;
- double discounting;
- surviving delay;
- boundary exclusion at `o=1/m`;
- loss of identity-indexed weak payoffs;
- `beta` inside R2;
- belief-only multiplicity;
- advancement of `N7` to `pass`.

The Gate 0 verifier confirmed the exact repaired contract, unchanged complete DAG, exact predecessor artifacts and reviews, `N7`’s null pending envelope, protected files and tag, recursive schema rejection, same-hash freeze requirements, topological readiness, and invalidation descendants. Its unique-exception mutations reject generalization, Phase B linkage, and `N7` freeze.

The only runtime messages were locale startup warnings; both verifiers returned exit status zero and their required `PASS` diagnostics.

## 8. Findings under Section 11.1

None. There is no ambiguity or missing definition requiring escalation and no critical, major, or minor finding to transcribe.

## 9. Finding counts

```text
critical: 0
major:    0
minor:    0
```

## 10. Verdict

**PASS — 0/0/0.**

The same immutable Phase A candidate is game-theoretically correct and complete on its authorized public-benchmark scope. The narrowly authorized Section 12.3 exception repairs the lifecycle issue without changing the candidate or model. This verdict does not authorize Phase B, public-private pairing, `RI_M`, `RI_U`, `DeltaRI`, comparison selection, `N7` freeze, Goal 5, `beta=1`, or manuscript work.

candidate_hash: sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5
