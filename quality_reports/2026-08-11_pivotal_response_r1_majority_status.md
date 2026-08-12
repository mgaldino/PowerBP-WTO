# Pivotal-response rederivation — R1 majority candidate status

**Date:** 2026-08-11  
**Node:** `r1_majority`  
**Status:** **CANDIDATE PENDING INDEPENDENT READ-ONLY REVIEW**  
**Role separation:** this artifact was derived and implemented here; it has
not been independently reviewed by its implementer.

This is the repaired successor to rejected candidate
`sha256:b09b54bb32aab50c770847768e75d02c2f1c0e2d19cad9420fb4d86b4b6cd03e`.
The rejected candidate incorrectly forced the `N=3,o_0=0` projection to be a
singleton.  No rejected byte is consumable downstream.

## Frozen dependencies

```text
R2 batch                 sha256:00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a
C2 majority, active H    sha256:a4ae73e9bb4114490bbc517732eca0ff7f5368186aee1a02388a8f85f52568b2
C2 majority, weak only   sha256:e0ec6cd35e145f04d1a2897fc1f78157f2b0d45de478046ac5451b2df0a74b5d
```

The verifier consumes those exact bytes and mutates each dependency hash in
memory to confirm descendant invalidation.  No C2 was rederived, repaired,
selected down to a scalar, or edited by this implementation.

## Candidate artifacts

```text
interface
  model_redesign/pivotal_response_interfaces/r1_majority_v1.json
  sha256:21c3a9dd2d6c9d25450978c2f7d9925af02e478b9c03d421d2a7b0f9aa2c77c9

derivation note
  model_redesign/pivotal_response_nodes/r1_majority_v1.md
  sha256:28a1254404fc33e02e57ef58b20cc06fec4bbec3e58fb6ea83608e50e17f4b40

R verifier
  scripts/verify_pivotal_response_r1_majority.R
  sha256:d9cd5ee3513f12b937eac227528522ee43ab26f5c6ac761bda52030137384c59

check table
  tables/pivotal_response_r1_majority_checks_v1.csv
  sha256:1f65abdab78f25b374e296a9d8c82f6a796f08f1891c05bf461b5147593c3055

enumeration cases
  tables/pivotal_response_r1_majority_cases_v1.csv
  sha256:350b56bdd6684e81a844ddd5e66347c3f2231e558a19bed13aa7d46c52da4307

N=3 projection grid
  tables/pivotal_response_r1_majority_n3_projection_v1.csv
  sha256:0c73f5a84f4728ec8cfff803854812aef54993433d115d4fcbfcff2506585b0e
```

## Derived object

The global result is a necessary-and-sufficient assessment fixed point, not a
scalar continuation.  For every proposal it retains:

- a distinct ballot belief `rho(s)` and the true proposer distribution `mu`;
- both H type actions and each weak player's independent action/completion;
- the full public history and posterior after every complete ballot vector;
- one literal active-H C2 selection for every H-yes weak-failure history;
- one literal weak-only C2 selection for every H-no weak-failure history;
- the complete type-by-identity payoff, allocation, inclusion, opt-out,
  payment, and terminal/continuation-signature distribution; and
- proposer optimality over every feasible proposal followed by the primitive
  H-payoff tie-break.

Both continuation-selection maps are public-measurable and type-blind: one
full public history selects one C2 element carrying both type coordinates.
Proposal mixing is integrated before uniform recognition, and the C1 export
retains every player identity and both type-conditional distributions.

H's IC integrates every complete weak vector.  Its no action gives
`o_theta` immediately, without `beta`, regardless of the weak count.  A yes
plus weak failure imports `beta*C2_M_active` once.  For a weak voter, a no by H
plus weak failure imports `beta*C2_M_WO` once for weak states only; H is not
paid again.  Double-failure histories compare their action-specific selected
C2 objects and are not compressed to a common node label.

## Closed propositions

1. **Fixed-proposal ballot fixed point — proved.**  The H and player-specific
   weak ICs are necessary and sufficient after literal evaluation of every
   action-specific continuation.
2. **Proposal-stage characterization — proved conditional on attained
   maximum.**  Local ballot fixed points, Bayes consistency, literal C2
   membership, proposer `argmax`, and the primitive H tie-break are necessary
   and sufficient.  Arbitrary off-path maps can be discontinuous, so no
   supremum is substituted for a maximum.
3. **`N=3` — repaired and proved.**  Let `b=beta/2`, `A=1-b`,
   `C=(1-mu)(1-o_0)+mu b`, `D=1-o_1`, `L=max(C,D)`, and
   `U=max(A,C,D)`.  The exact recognized-proposer projection is `{U}` if
   `o_0>0` and `[L,U]` if `o_0=0`.  Necessity, sufficiency for every `V`,
   proposal-contingent `rho`/completions, tie-break signatures, endpoints,
   and admissible double-tie mixing are characterized.
4. **Global existence — proved.**  For every `N>=4`, `y=0`, zero gifts, and
   all weak yes provide a value-one PBE; together with the `N=3` construction,
   PBE existence holds on the full primitive domain.
5. **Exact proposer projection `[0,1]` — proved only in two domains:**
   `N>=6`; or `N in {4,5}`, `o_0>0`, `beta<1`.  No projection claim is made
   outside those domains.
6. **Small-N `o_0=0` pathology — proved from the frozen interface.**  For
   `N in {4,5}`, the active-H recognized-proposer projection becomes
   `[max{1-o_1,1-nu},1]`.  Uniform recognition implies the public-belief
   identity bound `E_nu[C^A_W,j]>=max{1-o_1,1-nu}/m`; an on-path low-type
   revelation gives `beta/m` in R1.  Type 0 cannot be induced to choose
   immediate opt-out by a nonnegative H-yes continuation when `o_0=0`.

## Mechanical validation

Command:

```sh
LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
  Rscript --vanilla scripts/verify_pivotal_response_r1_majority.R
```

Result: **23/23 PASS**.

Coverage includes:

- exact dependency hashes and one-at-a-time mutation invalidation;
- `65,532` complete H/weak vector transitions for `N=3,...,16`;
- `500` type-specific full-vector H-IC comparisons;
- `16,388` player-specific weak action comparisons, including `4,608`
  double-failure cases in which action-specific C2 selections differ;
- current-versus-continuation payoff dates, exactly-one discount, immediate H
  opt-out, and absence of double payment;
- separate `rho` and `mu` calculations;
- `1,000` random feasible checks of the exact `N=3` upper bound;
- `48` primitive `N=3` cells and `78` singleton/interval value rows, each
  checking construction, local response, tie-break, and deviations;
- the non-singleton counterexample
  `beta=.5,o_0=0,o_1=.8,mu=.9 -> [.325,.75]`;
- a negative mutation test that validates the `.325` assessment from
  primitive branches and then confirms that the rejected singleton predicate
  fails it;
- a double-tied lower-endpoint proposal-mixing check;
- unilateral deviations in the value-one construction for `N=4,...,16`;
- the two proved `[0,1]` subclasses; and
- the frozen active-H `o_0=0` lower-bound and boundary arithmetic;
- public-measurable/type-blind `kappa_A` and `kappa_O`; and
- `sigma_i` integration plus the full type-by-identity C1 export.

Numerical enumeration checks the formulas and branch coverage; it does not
replace the proofs in the node note.

## Ledger

| Claim | Status |
|---|---|
| PR04--PR07 mixed-date payoff map | proved; checked numerically |
| H IC and relevance separate from quota | proved; checked numerically |
| player-by-player weak IC with action-specific C2 maps | proved; checked numerically |
| exact global assessment/fixed-point characterization | proved |
| general scalar continuation or global H offer threshold | rejected |
| minimal coalition or zero-gift characterization | rejected |
| `N=3,o_0>0` singleton `{U}` | proved; checked numerically |
| `N=3,o_0=0` interval `[max(C,D),max(A,C,D)]` | proved; checked numerically |
| rejected universal `N=3` singleton | rejected; negative mutation test passes |
| public-measurable/type-blind continuation selections | proved; checked structurally |
| `sigma` expectation and full type-by-identity C1 export | proved; checked numerically |
| value-one PBE for every `N>=4` | proved; checked numerically |
| `[0,1]` projection in the two stated subclasses | proved; checked numerically |
| `[0,1]` projection outside the stated subclasses | pending; not claimed |
| small-N `o_0=0` active-H pathology and identity bound | proved; checked numerically |
| independent formal review | pending |
| independent adversarial review | pending |

## Invalidation and handoff

Any byte change to the reviewed R2 batch or either C2 interface invalidates
this candidate and every descendant.  Independent reviewers should audit the
exact interface hash above and remain read-only.  The DAG, shared proof
ledger, shared Rmd, Gate 0, all R2 artifacts, the parallel R1 node, and every
protected manuscript/historical artifact were outside this implementer's edit
scope.
