# N7 Phase A — Independent Adversarial Game-Theory Review

- `reviewer_role`: `game_theory`
- `reviewer_id`: `review-n7-phaseA-game-2026-08-19-r1`
- `candidate_hash`: `sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`
- Review mode: independent, read-only, cold backward derivation
- Candidate lifecycle reviewed: Phase A intermediate candidate; `N7` remains `pending` and `unfrozen`
- Verdict: **PASS**

## 1. Independence and hash gate

I did not inspect or use any result from the independent `formal_design` reviewer. I did not edit any file, execute the writing builder, or use an equilibrium from `N6` or another private-information node as a premise.

The candidate SHA-256 was computed independently before substantive review and rechecked after validation:

```text
sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5
```

It matches the required frozen candidate hash exactly.

`N6` was used only to verify architectural readiness and its frozen hash. No private equilibrium formula, branch, payoff, or conclusion entered the public-game derivation.

## 2. Files reviewed in full

1. `AGENTS.md`
2. `quality_reports/plans/2026-08-12_essential_input_gate0.md`
3. `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/SKILL.md`
4. `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/references/templates.md`
5. `/Users/manoelgaldino/.codex/skills/formal-game-theory-polisci/SKILL.md`
6. `quality_reports/2026-08-19_n7_phaseA_comparison_gate_discussion.md`
7. `model_redesign/essential_input_n7_phaseA_public_benchmarks_derivation.md`
8. `model_redesign/essential_input_n7_phaseA_public_benchmarks_ledger.json`
9. `scripts/build_essential_input_n7_phaseA_public_benchmarks.R`
10. `scripts/verify_essential_input_n7_phaseA_public_benchmarks.R`
11. `model_redesign/essential_input_game_dag.json`
12. `model_redesign/essential_input_n7_phaseA_public_benchmarks_candidate_v1.json`

## 3. Cold derivation from governing primitives

Fix public `theta` and write `o=o_theta`. There are `m>=2` weak states, the recognized weak proposer counts as voting yes, and:

```text
q_M = floor((m+1)/2)+1 <= m
q_U = m+1
```

Ballots are simultaneous and sealed. Weak nonproposers are restricted to stage-undominated pure voting, with `T^Y` selecting yes at genuine equality. `H` is governed by sequential rationality and `T^Y`, not stage-undominance. R2 is terminal and in native units; R1 imports R2 payoffs with exactly one `beta`.

### 3.1 Public R2 majority

For every weak nonproposer:

- if `x_j>0`, yes weakly dominates no;
- if `x_j=0`, the actions are identical and `T^Y` selects yes.

All `m` weak votes are therefore yes after every proposal, meeting `q_M` without `H`. `H` is nonpivotal and strictly votes no because no yields `y+o`, while yes yields `y`.

The recognized proposer uniquely maximizes its payoff with:

```text
y=0
x_j=0 for every j
r_i=1
```

The proposal passes without `H`. Native R2 payoffs are:

```text
recognized proposer = 1
each weak identity before recognition = 1/m
H = o
```

There is no failure, delay, proposal mixing, payoff multiplicity, or belief multiplicity.

### 3.2 Public R2 unanimity

All weak nonproposers again vote yes after every proposal. `H` is pivotal and compares current `y` with terminal disagreement `o`, hence votes yes iff `y>=o`; `T^Y` selects yes at equality.

Because `o<1`, the unique proposer optimum is:

```text
y=o
x_j=0 for every j
r_i=1-o
```

The proposal passes with `H`. Native R2 payoffs are:

```text
recognized proposer = 1-o
each weak identity before recognition = (1-o)/m
H = o
```

Agreement strictly dominates terminal failure for the proposer.

### 3.3 R1 continuation values and complete voting strategies

The same-rule, same-type public R2 solutions give the following R1 continuation values:

```text
a_M = beta/m
a_U = beta*(1-o)/m
b   = beta*o
```

For a weak nonproposer, every nonpivotal profile gives the same payoff under yes and no, while a pivotal profile compares `x_j` with `a_g`. Therefore the unique admissible weak strategy after every R1 proposal is:

```text
majority:     yes iff x_j >= beta/m
unanimity:   yes iff x_j >= beta*(1-o)/m
```

At equality, `T^Y` selects yes.

For `H`, let `k` denote the number of prescribed weak yes votes, including the proposer. The strategy is chosen before the simultaneous ballot and never conditions on realized votes:

| Rule and prescribed weak count | Consequence | `H` action |
|---|---|---|
| Majority, `k>=q_M` | Passes without `H` | No, strictly: `y+o>y` |
| Majority, `k=q_M-1` | `H` pivotal | Yes iff `y>=beta*o` |
| Majority, `k<=q_M-2` | Failure regardless | Yes by `T^Y` |
| Unanimity, `k=m` | `H` pivotal | Yes iff `y>=beta*o` |
| Unanimity, `k<=m-1` | Failure regardless | Yes by `T^Y` |

This covers pivotal passage, nonpivotal passage, and certain failure without giving `H` access to the ex post weak-vote vector.

### 3.4 Public R1 majority

Every feasible proposal reduces to one of three payoff-relevant cases.

**Inclusion of `H`.** Buy `q_M-2` weak nonproposers and make `H` pivotal:

```text
y=beta*o
x_j=beta/m for j in C_i^I, |C_i^I|=q_M-2
x_j=0 otherwise
R_I=1-beta*o-beta*(q_M-2)/m
```

**Exclusion of `H`.** Buy `q_M-1` weak nonproposers:

```text
y=0
x_j=beta/m for j in C_i^E, |C_i^E|=q_M-1
x_j=0 otherwise
R_E=1-beta*(q_M-1)/m
```

**Failure or delay.** The recognized proposer receives `a_M=beta/m`.

The branch comparison is:

```text
R_E-R_I = beta*(o-1/m)
```

Hence inclusion is optimal for `o<1/m`, exclusion for `o>1/m`, and the branches tie at `o=1/m`. At the boundary, inclusion gives `H` only `beta*o`, whereas exclusion gives `o`; since `0<beta<1`, the authorized proposal-level tie-break selects inclusion and eliminates cross-branch mixing.

Exclusion strictly dominates delay:

```text
R_E-a_M = 1-beta*q_M/m > 0
```

because `q_M<=m` and `beta<1`. The selected agreement branch is therefore strictly better than delay everywhere. When inclusion is selected, it is feasible because `o<=1/m` implies `R_I>=R_E>0`. Overpayments, extra coalition members, and slack strictly reduce the proposer’s payoff.

### 3.5 Public R1 unanimity

Passage requires every weak nonproposer and `H`:

```text
y=beta*o
x_j=beta*(1-o)/m for every j != i
R_U=1-beta*(m-1+o)/m
```

The proposer’s delay value is `a_U`, and:

```text
R_U-a_U = 1-beta > 0
```

Thus immediate agreement uniquely dominates delay and deliberate failure. All response cutoffs bind, the full pie is used, and no proposer-identity convention between “cooperative” and “difficult” negotiators survives.

The resulting R1 payoffs are:

```text
recognized proposer = 1-beta*(m-1+o)/m
each weak identity before recognition = (1-beta*o)/m
H = beta*o
```

## 4. Deviation, feasibility, and multiplicity audit

### Responder deviations

The candidate supplies complete pure strategies after every feasible proposal. Weak cutoffs follow from the whole stage game, not merely the on-path pivotal row. `H`’s three majority cases and two unanimity cases are exhaustive and respect simultaneous voting.

### Proposer deviations

Under majority, the count of weak voters willing to approve partitions every proposal into:

1. passage without `H`;
2. pivotal inclusion of `H`;
3. failure and R2 continuation.

Reducing the first two classes to their minimum costs yields exactly exclusion and inclusion. The best passing branch strictly dominates the third class. Under unanimity, every passing proposal must meet every weak cutoff and `H`’s cutoff; all other proposals delay, and the minimum-cost passing proposal strictly dominates them.

No omitted inclusion, exclusion, failure, deliberate-delay, or slack branch can improve the proposer’s payoff.

### Full-pie and package feasibility

Every selected proposal exhausts the unit pie. The required `y` satisfies the package bound because:

```text
R2: y=o<=y_bar
R1: y=beta*o<o<=y_bar
```

All selected residuals are strictly positive in their admissible regions. `H`’s disagreement payoff remains external to the pie.

### Boundaries and tie-breaking

The candidate correctly treats:

- `o=1/m` under majority;
- exact weak-response cutoffs;
- exact `H` reservation cutoffs;
- `m=2`;
- `m=3` exclusion;
- `m>=4` exclusion;
- the strict exclusion of `beta=1`.

`T^Y` governs ballot indifference. The separate proposer tie-break governs the inclusion/exclusion payoff tie.

### Coalition and identity multiplicity

The coalition counts are correct:

- majority inclusion: unique empty coalition at `m=2`; multiple coalitions for every `m>=3`;
- majority exclusion: unique at `m=2`, unique at `m=3`, multiple for `m>=4`.

For each proposer identity, any distribution `F_i` over the optimal coalitions is sequentially rational. Degenerate distributions represent pure coalition choices; nondegenerate distributions represent mixing only among payoff-equivalent proposals within the selected branch. The candidate correctly excludes mixing between inclusion and exclusion at their boundary and excludes mixing between agreement and delay.

The identity-indexed weak payoff expression is correct:

```text
C_k = R_branch/m
      + (beta/m^2)*sum_{i!=k} Pr_{C~F_i}(k in C_i)
```

Its cross-identity mean is `(1-beta*o)/m` under inclusion and `1/m` under exclusion. Coalition multiplicity does not alter the branch, outcome, recognized-proposer payoff, or `H` payoff.

### Beliefs and payoff uniqueness

Because `theta` is public from `t=0`, beliefs remain degenerate after every on-path and zero-probability history. No off-path type belief can change responder cutoffs or proposer deviations.

The candidate correctly distinguishes:

- unique assessments in all public R2 games and public R1 unanimity;
- unique branch, outcome, proposer payoff, and `H` payoff in public R1 majority;
- possible weak-identity payoff multiplicity from coalition composition only;
- no belief-only multiplicity.

## 5. Interface and scope audit

The 24 records give exhaustive typed coverage:

```text
majority R2       4
majority R1      12
unanimity R2      4
unanimity R1      4
total            24
```

Every R1 record cites exactly the public R2 record of the same rule, type, and `m` group. R2 records have no continuation source. Payoff and outcome fields satisfy the Gate 0 schema.

The candidate and ledger contain no:

- public-private equilibrium pairing;
- `RI_M`, `RI_U`, or `DeltaRI`;
- `N7` pass/freeze action;
- `beta=1` analysis;
- Goal 5 or manuscript migration action.

The DAG retains `N7` as `pending` and `unfrozen`. The intentionally pending claim `N7A-C14` is the authorized Phase A-to-B gate, not a defect in the public derivation.

## 6. Verifier and negative-test audit

The following commands completed successfully with exit status zero:

```text
Rscript --vanilla scripts/verify_essential_input_n7_phaseA_public_benchmarks.R
Rscript --vanilla scripts/verify_essential_input_gate0.R
```

The locale emitted startup warnings only; they did not affect execution or the PASS results.

The Phase A verifier independently checks the candidate hash, record count, schema, coverage, same-rule/same-type continuation links, native R2 timing, exactly-once R1 discounting, outcome branches, public beliefs, identity-indexed weak payoffs, coalition counts, full-pie identities, delay margins, lifecycle, protected scope, and forbidden Phase A outputs.

Its negative fixtures correctly reject:

1. non-null majority rent;
2. non-null rent contrast;
3. an unauthorized top-level field;
4. a missing public type;
5. missing `m=2` coverage;
6. a cross-rule R2 continuation source;
7. a private-source field;
8. double discounting;
9. public delay;
10. exclusion at the `o=1/m` boundary;
11. loss of the identity-indexed weak payoff map;
12. `beta` inside R2;
13. off-path belief multiplicity;
14. premature advancement of `N7` to `pass`.

The numerical checks cover `m=2,...,50`, several interior `beta` values, both sides and equality of `o=1/m`, the proposer branch identities, delay inequalities, unanimity budget identity, and coalition multiplicity. The builder was inspected but not executed because it writes the candidate and ledger.

## 7. Findings

There are no findings to transcribe.

| Severity | Count |
|---|---:|
| Critical | 0 |
| Major | 0 |
| Minor | 0 |

## 8. Verdict

**PASS — 0 critical / 0 major / 0 minor.**

The candidate at `sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5` correctly and completely characterizes the authorized public benchmarks for both rules, both public types, and the `m=2` and `m>=3` domains. It is suitable to receive the independent Phase A game-theory PASS while `N7` remains `pending` and `unfrozen`.
