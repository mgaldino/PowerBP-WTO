# Pivotal-response rederivation — R1 batch status

**Date:** 2026-08-12  
**Overall status:** **PASS** at `passed_order=40`.  
**Stop boundary:** stopped before entry; both entry nodes are authorized and
ready, but remain pending, unstarted, and without interfaces. No institutional
comparison is ready or started.

## Frozen inputs and outputs

```text
Gate 0 bundle       sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1
R2 batch interface  sha256:00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a
R1 U interface      sha256:37aae1bfe7921c6c90aff5d05ed301f8729c2b899477991619bcf0cb6c96e8b5
R1 M interface      sha256:21c3a9dd2d6c9d25450978c2f7d9925af02e478b9c03d421d2a7b0f9aa2c77c9
R1 batch interface  sha256:f4ac7b89f4c08d4ee461ca1431135286304abaae2589a337aeffdb38b5941c3a
```

The batch interface freezes 17 immutable components: Gate 0, the R2 batch,
the 27-file protected manifest, both C1 interfaces, two derivation notes, two
candidate-status snapshots, two node verifiers, two node check tables, two
case tables, and two `N=3` tables. The candidate-status snapshots remain
immutable implementation handoffs; hash-specific PASS is recorded in the
batch interface, independent-review report, DAG, and proof ledger.

## Independent rereviews

At orders 36--37, independent formal and adversarial read-only reviewers
passed both exact repaired interfaces with zero critical, major, or minor
findings. The formal reviewer additionally ran a 500-cell unanimity probe, a
932-assessment majority probe, and negative domain/dependency mutations. The
adversarial reviewer reran both official verifiers and confirmed the 27
protected hashes.

The rejected predecessors remain historical and nonconsumable:

```text
R1 U rejected  sha256:da52b135198898948ae88f919a849c76189f27fc6fff4d3f7646c4218d0f30aa
R1 M rejected  sha256:b09b54bb32aab50c770847768e75d02c2f1c0e2d19cad9420fb4d86b4b6cd03e
```

## Mechanical close

Repairs complete at orders 34--35, the formal and adversarial rereviews pass
at orders 36--37, batch close starts at order 38, the mechanical verifier
passes at order 39, and the batch passes at order 40.

`scripts/verify_pivotal_response_r1_batch.R` audits:

- all 17 direct component hashes plus 5 Gate 0 and 19 R2-batch transitive
  component hashes;
- both exact C1 approvals, local check tables, review records, full-domain
  C1 exports, and rejected-hash quarantine;
- all 27 protected artifacts;
- DAG status, exact event orders, dependency hashes, proof-ledger closure,
  and absence of entry/comparison artifacts;
- one-at-a-time U, M, R2-batch, and R1-batch hash mutations; and
- the pre-freeze negative barrier and post-freeze ready antichain.

Final result: **24/24 PASS**.

Governance hashes at the successful close:

```text
batch verifier      sha256:3f61401e7246fa403f3bfb16c4c6c5c5bd99148bf365c4daffcb81625a86c9d1
batch checks        sha256:bd0c10e3ce452a9d0171f176cb7e9c771ab40cc7d69c0dcbf7dbd1dcb14d51e0
DAG                 sha256:dad334538fd43ce4407e4738ad92dc8b77a5a51ff939eb9f5d313fe35cc89feb
proof ledger        sha256:471a2be2d9bdcc7c51ac79e7f2871a4617651ab7fca045c1690da7e3840c369e
review report       sha256:a285523bb769eece7018443c64c7ada8c4502cc1fd958f040f4899153816bbf6
interface README    sha256:08db4aa44122b33f327444b921d980023b1231e256ccec3ce3d099a46e12345c
```

## Ready frontier

The execution-order checker returns:

```text
VALID
Ready: entry_majority, entry_unanimity
```

The candidate call for `entry_unanimity entry_majority` also returns `VALID`.
Exactly those two nodes are authorized and ready; they are ancestor-unrelated,
pending, and have no `started_order`. `institutional_comparison` remains
unauthorized, pending, and blocked on both entry interfaces.

## Commands

```sh
Rscript scripts/verify_pivotal_response_r1_unanimity.R
Rscript scripts/verify_pivotal_response_r1_majority.R
Rscript scripts/verify_pivotal_response_r1_batch.R

python3 /Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py \
  model_redesign/pivotal_response_game_dag.json \
  --require-execution-order

python3 /Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py \
  model_redesign/pivotal_response_game_dag.json \
  --candidate entry_unanimity entry_majority
```

## Invalidation

Any byte change to Gate 0, R2 batch, either approved C1, or a frozen auxiliary
reopens the affected node, invalidates `r1_batch_frozen`, and propagates to
every descendant. Entry must consume the full assessment-indexed C1
correspondence and may not replace it by a scalar or rediscout its Round-1
payoffs.
