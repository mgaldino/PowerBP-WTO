# Pivotal-response rederivation — R2 batch status

**Date:** 2026-08-11  
**Overall status:** **PASS** at `passed_order=25`.  
**Stop boundary:** stopped before R1; no R1 interface, result, or
`started_order` exists.

## Frozen inputs

```text
Gate 0 bundle       sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1
R2 U active-H       sha256:f3ca4ebf28827d7e18d9f3a2d07d41ffd6fe57532c9af09300f20a8ab5cecf10
R2 M active-H       sha256:a4ae73e9bb4114490bbc517732eca0ff7f5368186aee1a02388a8f85f52568b2
R2 M weak-only      sha256:e0ec6cd35e145f04d1a2897fc1f78157f2b0d45de478046ac5451b2df0a74b5d
R2 batch interface  sha256:00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a
```

The batch interface hashes 19 immutable components: Gate 0 and its review,
the 27-file protected manifest, all three C2 interfaces, three proof notes,
three node status reports, three node verifiers, three node check tables, and
the M-WO case table. The batch close did not edit or rerun any node-specific
artifact or the historical Gate 0 check table.

## Review and repair history

At events 17--18, both independent read-only reviewers passed U and M-WO with
zero findings and returned REPAIR on the initial M-active hash
`93fee7f50a0b2d07f584ec60f6d39339ed238cd3d1b018751bb24cdc3efb79aa`.
The repair at events 19--20 separated off-path ballot belief `rho(s)` from
the true `nu`. Both rereviewers passed the repaired `a4ae73...`
interface with zero findings at events 21--22.

The full event record and conditions are in
`model_redesign/pivotal_response_interfaces/r2_batch_review_v1.json` and
`quality_reports/2026-08-11_pivotal_response_r2_batch_independent_review.md`.

## Mechanical close

`r2_batch_review` starts at event 23, the batch verifier passes at event
24, and the node passes at event 25. The batch verifier audits:

- exact Gate 0, C2, auxiliary, and protected hashes;
- all node check tables;
- PBE and native Round-2 dating with no internal `beta`;
- two independent verdicts per accepted node and the M-active REPAIR history;
- DAG execution order and literal dependency hashes;
- absence of any R1 interface or start; and
- in-memory mutations proving that changing any C2 or batch hash invalidates
  both R1 candidates.

Final verifier result: **30/30 PASS**.

Governance-output hashes at the successful run:

```text
batch verifier      3900ef11e60fd4adeea6279c13789b30b044387eda85484147103b4cc3cab598
batch checks        2a5fc67b520af3f984d9203b33a88b9706fa8a2d58e3c10811e4dbe44094c055
DAG                 5b54076e8997b1ca12747435f8bc5cd2b3bf5a35720ecd74a9e332b5e15da532
interface README    5544768b28aec0719bf8d7d7f8a3a4cb9092795c2008a579ada2e837cc190276
proof ledger        b75c04c986425961b1c29b1bd067ed0391acf3ffb70d9e932a966b3fe0cdc0df
review report       d800f71ce13e5475a4eb1982584f95e886de39e951f005b30a0b8e8c5911f205
```

The skill DAG checker must return:

```text
VALID
Ready: r1_majority, r1_unanimity
```

The candidate call for `r1_unanimity r1_majority` must also return
`VALID`. Exactly those two pending nodes are authorized; every later node
remains unauthorized and blocked.

## Commands

```sh
Rscript scripts/verify_pivotal_response_r2_batch.R

python3 /Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py \
  model_redesign/pivotal_response_game_dag.json \
  --require-execution-order

python3 /Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py \
  model_redesign/pivotal_response_game_dag.json \
  --candidate r1_unanimity r1_majority
```

## Invalidation

Any byte change to a frozen component reopens the affected R2 node and
`r2_batch_review`, invalidates both R1 candidates, and propagates to every
descendant. Neither R1 may locally repair, select, or rederive a C2.
