# Pivotal-response rederivation — majority entry candidate status

**Date:** 2026-08-12  
**Node:** `entry_majority`  
**Status:** **CANDIDATE PENDING INDEPENDENT READ-ONLY REVIEW**  
**Role separation:** this artifact was derived and implemented here; it has
not been independently reviewed by its implementer.

## Exact frozen dependencies

```text
Gate 0 bundle   sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1
R1 batch        sha256:f4ac7b89f4c08d4ee461ca1431135286304abaae2589a337aeffdb38b5941c3a
C1 majority     sha256:21c3a9dd2d6c9d25450978c2f7d9925af02e478b9c03d421d2a7b0f9aa2c77c9
```

The verifier hashes these exact inputs plus all 5 Gate 0 and 17 R1-batch
frozen components. It does not require the historical pre-entry readiness
snapshot in the R1-batch verifier to remain `24/24` after the two entry nodes
legitimately acquired their `started_order` values. One-at-a-time in-memory
mutation of any of the three direct dependency hashes invalidates this node.

No upstream, DAG, ledger, shared Rmd, parallel entry node, protected
manuscript, or quarantined historical artifact was edited by this
implementation.

## Candidate artifacts

```text
interface
  model_redesign/pivotal_response_interfaces/entry_majority_v1.json
  sha256:4eb343ce6f6fb7c34782e708a0e787908437d2682d079e91f26103706c083f21

derivation note
  model_redesign/pivotal_response_nodes/entry_majority_v1.md
  sha256:1cb38c928a362c4d93b9546db069306e068afa09e0a1a143bcd50189c55cff8f

R verifier
  scripts/verify_pivotal_response_entry_majority.R
  sha256:045838f98af6ab443e3d0ac2bfe237d4bd27ac8d74205b146fefd764c2779576

check table
  tables/pivotal_response_entry_majority_checks_v1.csv
  sha256:c145e6b192e882927ceeac8983118d1445d61e0257b55d06f4ada8dba18181cf

assessment fixtures
  tables/pivotal_response_entry_majority_assessment_fixtures_v1.csv
  sha256:8c89ea236a1970ffaa78d1eb0a1ea756712aff7f2ff7c2f878e64c053b09ff89

type-by-identity payoff fixtures
  tables/pivotal_response_entry_majority_type_identity_fixtures_v1.csv
  sha256:5db0c6d77ff7df1af4678fd09eb0ebc35d848595105d6453213d91dff14ff108

endpoint-region fixtures
  tables/pivotal_response_entry_majority_region_logic_v1.csv
  sha256:eb4ed3aa4342c134a6bb7a0af5344ff5ca2c9b68f60e6f481f7e3c43e244e592
```

## Exact entry object

For every whole identity-indexed frozen assessment `alpha`, the node computes

```text
T_W(alpha,theta)=sum_j C1_M,Wj^alpha(theta),
V_W(alpha,mu)=[(1-mu)T_W(alpha,0)+mu T_W(alpha,1)]/m.
```

The operational expectation order is proposal-mixture integration, uniform
recognition, true-type integration, and only then cross-weak averaging. The
complete `alpha` remains attached to the result. The collective weak-state
device forms if and only if `V_W>=chi`; equality forms.

If formation occurs, each named weak type payoff is its C1 payoff minus the
external sunk cost `chi`, H keeps its C1 type payoff, and the complete C1
outcome distribution is inherited. A named weak state may have a negative net
payoff under the specified collective-average criterion; no individual veto
or truncation was introduced. If formation does not occur, every weak state
gets zero, H gets `o_theta`, and no proposal or bargaining round is realized.

## Selection-free results

Let `S_M={V_W(alpha,mu)}`, `v^-_M=inf S_M`, and `v^+_M=sup S_M`, with
separate attainment flags. The proved resource envelope is

```text
0 <= v^-_M <= v^+_M <= 1/m.
```

For every `N>=4`, the frozen value-one assessment proves
`v^+_M=1/m` and upper-endpoint attainment. No universal exact lower endpoint
or lower-attainment statement is made. At `N=3`, the recognized-proposer
projection does not identify either collective endpoint.

The exact endpoint-aware entry regions are:

```text
all form       iff chi <= v^-_M
possible form  iff chi < v^+_M, or chi=v^+_M and the supremum is attained
possible no    iff chi > v^-_M
all no         iff chi > v^+_M, or chi=v^+_M and the supremum is not attained
```

Thus `chi=0` is universally all-form; `chi>1/m` is universally all-no; and
for `N>=4`, `chi=1/m` admits formation. Lower-endpoint attainment is irrelevant
at equality because equality forms; upper-endpoint attainment is essential.

## Negative proposer-projection result

For the frozen counterexample

```text
N=3, beta=.5, o_0=0, o_1=.8, mu=.9,
```

two proposals that both give the proposer `.325` and H `.72` yield collective
weak values `.275` and `.5`. Their admissible mixtures preserve both scalar
payoffs while spanning `[.275,.5]`. Therefore neither the N=3 proposer interval
nor a proposer payoff divided by `m` is an entry value.

Similarly, every displayed construction behind the proved `[0,1]` proposer
projection sets `y=0`, gives gifts totaling `1-V`, and passes. Aggregate weak
gross payoff is one for every proposer value `V`, so the entire displayed
proposer continuum maps to the same collective value `1/m`. It is not a
collective-value interval.

## Mechanical verification

Command:

```sh
Rscript --vanilla scripts/verify_pivotal_response_entry_majority.R
```

Result: **24/24 PASS**.

Coverage includes:

- the three exact direct dependencies, 5 Gate 0 components, 17 R1-batch
  components, and three one-at-a-time dependency mutation guards;
- five asymmetric/mixed assessment fixtures through the exact expectation
  order, with all named identities retained;
- a negative unweighted-mixture mutation;
- equality formation, external cost accounting, identity-level negative net
  payoff without an individual veto, and nonformation payoffs/outcome;
- `102` machine-readable assessment/status/type/player payoff rows, including
  named weak costs and H type outcomes;
- `16,000` PR04--PR07 resource-envelope draws;
- the attained `N=4` upper endpoint;
- `404` proposer-projection accounting cells and a proposer-scalar mutation;
- the exact N=3 double-tie values `.275`, `.41`, and `.5`;
- ten endpoint-region fixtures, including attained and unattained suprema; and
- all 27 protected hashes.

Numerical fixtures validate the algebra and shortcut guards; they do not
replace the proofs in the node note.

## Claim ledger

| Claim | Status |
|---|---|
| whole-assessment entry lift is necessary and sufficient | proved |
| collective value operator and expectation order | proved; checked numerically |
| external-cost and nonformation payoff map | proved; checked numerically |
| resource envelope `[0,1/m]` | proved; checked numerically |
| upper endpoint `1/m` attained for every `N>=4` | proved; checked numerically |
| universal exact lower endpoint | pending; not claimed |
| exact `N=3` collective endpoints from proposer projection | rejected |
| proposer projection as collective-value interval | rejected; negative tests pass |
| exact endpoint/attainment entry classification | proved; checked numerically |
| independent formal review | pending |
| independent adversarial review | pending |

## Handoff and invalidation

Independent reviewers should audit the exact interface hash above and remain
read-only. Any byte change to Gate 0, the frozen R1 batch, C1-M, or a frozen
transitive component invalidates this candidate and every descendant.
