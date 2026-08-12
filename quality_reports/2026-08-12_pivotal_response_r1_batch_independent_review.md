# Pivotal-response R1 batch — independent review closure

**Date:** 2026-08-12  
**Batch verdict:** **PASS**  
**Gate 0:** `sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1`  
**R2 batch:** `sha256:00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a`

## Hash-specific verdicts

| Node | Approved interface | Formal rereview | Adversarial rereview |
|:---|:---|:---|:---|
| R1 unanimity, repaired | `37aae1bfe7921c6c90aff5d05ed301f8729c2b899477991619bcf0cb6c96e8b5` | PASS, 0 critical / 0 major / 0 minor | PASS, 0 critical / 0 major / 0 minor |
| R1 majority, repaired | `21c3a9dd2d6c9d25450978c2f7d9925af02e478b9c03d421d2a7b0f9aa2c77c9` | PASS, 0 critical / 0 major / 0 minor | PASS, 0 critical / 0 major / 0 minor |

Both reviews were strictly read-only and independent of the implementers. No
reviewer edited an interface, derivation note, verifier, table, protected
artifact, DAG, proof ledger, or batch-governance artifact.

## Formal rereview

The formal reviewer approved the full-domain `N>=3` unanimity construction,
including all attained `N=3` cases, the posterior-zero continuation used after
on-path low-type separation, the treatment of the open C2 endpoint, and the
public-history-measurable, type-blind `kappa(h2)` export. The official
unanimity verifier returned **37/37 PASS**; a separate 500-cell cold probe
passed; and a mutation of the `N>=3` domain gate was rejected with nonzero
exit.

For majority, the reviewer independently recovered, for `N=3`,
`b=beta/2`, `A=1-b`, `C=(1-mu)(1-o_0)+mu*b`, and `D=1-o_1`. The approved
projection is `{max(A,C,D)}` when `o_0>0` and
`[max(C,D),max(A,C,D)]` when `o_0=0`. The official verifier returned
**23/23 PASS**, an additional 932-assessment probe passed, and an R2-hash
mutation was rejected with nonzero exit.

## Adversarial rereview

The adversarial reviewer separately returned PASS on both exact repaired
hashes, with zero critical, major, or minor findings. The reviewer reran the
official verifiers (**37/37** for unanimity and **23/23** for majority),
checked the belief/information-set and action-specific continuation logic,
and confirmed all 27 protected artifacts byte-identical.

## Repair history and quarantine

The first R1 unanimity candidate
`da52b135198898948ae88f919a849c76189f27fc6fff4d3f7646c4218d0f30aa`
received REPAIR because its `N=3` existence/export boundary, full C1 export,
and Bayes construction test were incomplete. The first R1 majority candidate
`b09b54bb32aab50c770847768e75d02c2f1c0e2d19cad9420fb4d86b4b6cd03e`
received REPAIR because it falsely reduced the `N=3,o_0=0` proposer-value
correspondence to a singleton. Both hashes remain rejected history only and
are nonconsumable.

## Execution record

| Order | Event | Result |
|:---:|:---|:---|
| 34 | Majority repair completes | completed |
| 35 | Unanimity repair completes | completed |
| 36 | Independent formal rereview | PASS on U and M |
| 37 | Independent adversarial rereview | PASS on U and M |
| 38 | R1 batch close starts | started |
| 39 | Batch mechanical verifier | PASS |
| 40 | R1 batch closes | PASS |

## Conditions of PASS

The PASS is hash-specific and freezes the full assessment-level C1
correspondence under each rule. It adds no scalarization, equilibrium
selection, coalition restriction, formation result, or institutional
comparison. Any byte change to Gate 0, R2 batch, either approved C1, or a
hashed auxiliary reopens the affected node and invalidates all descendants.

After the batch close, exactly `entry_majority` and `entry_unanimity` are
ready. They form a dependency antichain, remain pending without
`started_order`, and no comparison node is ready or started.
