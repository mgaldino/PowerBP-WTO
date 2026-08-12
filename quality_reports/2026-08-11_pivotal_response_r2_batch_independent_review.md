# Pivotal-response R2 batch — independent review closure

**Date:** 2026-08-11  
**Batch verdict:** **PASS**  
**Gate 0:** `sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1`  
**R2 batch interface:** `sha256:00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a`

## Hash-specific node verdicts

| Node | Approved interface | Formal review | Adversarial review |
|:---|:---|:---|:---|
| R2 unanimity, H active | `f3ca4ebf28827d7e18d9f3a2d07d41ffd6fe57532c9af09300f20a8ab5cecf10` | PASS, zero findings | PASS, zero findings |
| R2 majority, H active, repaired | `a4ae73e9bb4114490bbc517732eca0ff7f5368186aee1a02388a8f85f52568b2` | PASS rereview, zero findings | PASS rereview, zero findings |
| R2 majority, weak-only | `e0ec6cd35e145f04d1a2897fc1f78157f2b0d45de478046ac5451b2df0a74b5d` | PASS, zero findings | PASS, zero findings |

Every review was read-only. The reviewers did not edit any interface, proof
note, verifier, table, Gate 0 artifact, protected file, DAG, ledger, or batch
governance artifact.

## Repair history

The initial R2 majority active-H candidate
`93fee7f50a0b2d07f584ec60f6d39339ed238cd3d1b018751bb24cdc3efb79aa`
received REPAIR from both initial reviewers at events 17--18. It incorrectly
identified the ballot belief `rho(s)` with the true preproposal posterior
`nu` at globally off-path proposals.

The repair ran at events 19--20 and produced `a4ae73...`. Both independent
rereviewers passed that exact repaired interface at events 21--22, with zero
critical, major, or minor findings. The old `93fee7...` hash is rejected
history only and is neither a batch component nor a consumable DAG
dependency.

## Execution record

| Orders | Event | Result |
|:---|:---|:---|
| 11--13 | Three R2 implementations start | started |
| 14--16 | Initial R2 implementations complete | completed |
| 17--18 | Initial formal and adversarial reviews | U PASS; M-active REPAIR; M-WO PASS |
| 19--20 | M-active repair | completed |
| 21--22 | Formal and adversarial M-active rereviews | PASS; PASS |
| 23 | R2 batch close starts | started |
| 24 | Batch mechanical verifier | PASS |
| 25 | R2 batch closes | PASS |

## Conditions of PASS

The batch PASS applies only to the exact 19 components hashed in
`r2_batch_review_v1.json`. It preserves each full assessment-level C2
correspondence and introduces no scalarization, minimal-coalition assumption,
belief repair, or new equilibrium selection. All payoffs remain in native
Round-2 units. A Round-1 consumer applies `beta` exactly once only on a
transition reaching the imported C2.

Any byte change to Gate 0, a C2, proof note, node status, verifier, or node
table invalidates the batch, both R1 candidates, and every later descendant.
The R1 nodes may become authorized and ready after event 25, but neither is
started or solved by this close.
