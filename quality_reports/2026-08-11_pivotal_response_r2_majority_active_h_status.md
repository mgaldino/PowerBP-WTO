# Status — Round 2 majority with active H (repaired candidate)

Date: 2026-08-11  
Node: `r2_majority_active_h`  
Role: implementer only  
Overall status: **candidate pending independent read-only rereview**

## Frozen input and repaired scope

- Gate 0 bundle:
  `sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1`.
- The repair distinguishes the true preproposal posterior `nu` from the ballot
  belief `rho(s)`: `rho(s)=nu` on proposal support, while a globally off-path
  proposal has an explicitly stated `rho(s)`.
- Every proposer deviation is evaluated under true `nu`; only ballot best
  responses use `rho(s)`.
- The node remains in native Round-2 units and applies `beta` zero times.
- No historical equilibrium result was imported.

## Repaired candidate artifacts and exact hashes

| Role | Artifact | SHA-256 |
|---|---|---|
| continuation interface | `model_redesign/pivotal_response_interfaces/r2_majority_active_h_v1.json` | `a4ae73e9bb4114490bbc517732eca0ff7f5368186aee1a02388a8f85f52568b2` |
| derivation note | `model_redesign/pivotal_response_nodes/r2_majority_active_h_v1.md` | `7637a8cc05c9ffec1a09b4c8677ea3ff382d49d7bdbc606f1e298db04bd00e1c` |
| R verifier | `scripts/verify_pivotal_response_r2_majority_active_h.R` | `116056ae6291a8adbb83d77994ff0b448ca56428b7c10301b11d434e220958a5` |
| check table | `tables/pivotal_response_r2_majority_active_h_checks.csv` | `2df97d9eda8d7b6d83174679782b333676545fbd43f2960ab4eebb9680d19127` |

The interface hash is the repaired candidate identifier for the independent
rereviewer. It is not yet a frozen PASS interface.

## Main repaired results

At a fixed proposal, local ballot rationality is parameterized by `rho`. Let
`A=Pr(K>=q-2)`, `B=Pr(K>=q-1)`, and
`t_rho=(1-rho)h_0+rho h_1`.

- H votes yes iff `A=0` or `y>=o_theta`.
- A weak voter's relevance is
  `t_rho Pr(K_-j=q-3)+(1-t_rho)Pr(K_-j=q-2)`.
- Sure failure exists exactly when `N>=6` and exactly at
  `L(p)<=q-4`.
- Secured passage requires at least `q-2` sure weak yes votes when
  `t_rho=1`, and at least `q-1` when `t_rho<1`.
- Consequently, `B` may range over `[0,1]` at `t_rho=1`, but `B=1` at
  `t_rho<1`.

The type-conditional terminal correspondence retains all four Gate 0 branches,
player identities, named payments, H inclusion/opt-out, and both H types. True
proposal payoffs integrate these outcomes with `nu`, not `rho`.

The corrected proposal-stage projections are:

- `3<=N<=5` and `o_0>0`: proposer payoff is exactly one.
- `3<=N<=5` and `o_0=0`: proposer payoff is
  `[max{1-o_1,1-nu},1]`. Thus the previous blanket value-one claim is
  rejected on this boundary.
- `N>=6`: proposer payoff projection remains `[0,1]`; this result survives the
  repaired proof because a class-F completion is available at every proposal
  and every `rho`.

These scalar projections do not replace the full assessment correspondence.
The interface retains the proposal distribution, `rho` map, full ballot
completion, type/identity payoff vectors, terminal distribution, and beliefs.

## Candidate results ledger

| Claim | Status | Evidence |
|---|---|---|
| H and weak best responses at fixed `(s,rho)` | proved | Sections 2–3 of derivation note |
| Complete fixed-proposal F/S partition, including mixed completions | proved | Proposition 1 |
| No local equilibrium has `0<A<1` | proved | Proposition 1 exhaustiveness proof |
| Type-conditional PR11–PR14 probabilities and payoff vectors | proved | Section 2 |
| Separation of ballot `rho` from true deviation distribution `nu` | proved by Bayes consistency and construction | Sections 1, 4, and 5 |
| Pure profiles for `N=3,...,13` across five `(rho,y)` regimes | checked numerically | 20,470 profile-regime checks, zero mismatches |
| Five-point mixed grid for `N=3,...,7` across five regimes | checked numerically | 19,525 profile-regime checks, zero mismatches |
| Four Gate 0 terminal branches | checked numerically | 378 vote-count profiles, zero mismatches |
| Best-response differences use `rho` | checked numerically | 2,611 comparisons, zero mismatches |
| Type/outcome payoffs and proposal expectation use true `nu` | checked numerically | 5,622 comparisons, zero mismatches |
| F/S population and `B` boundaries | checked numerically | 140 comparisons, zero mismatches |
| Off-path `rho=0,B=0` punishment versus true `nu` | proved and checked numerically | 220 comparisons, zero mismatches |
| `N<=5,o_0>0` forces value one | proved and checked numerically | Proposition 2; 18 equilibrium-profile checks |
| `N<=5,o_0=0` gives the sharp interval | proved and checked numerically | Proposition 3; 378 comparisons |
| `N>=6` retains the `[0,1]` projection | proved and checked numerically | Section 7; 3,690 comparisons |
| Zero-value secured-passage tie characterization | proved and checked numerically | Section 7; 138 boundary-grid cases |
| Pre-recognition C2 averages uniform recognition without dropping coordinates | proved by construction | Section 8 and JSON interface |
| Independent correctness rereview | pending | implementer is not reviewer |
| Rendered layout of the Markdown note | not tested | no rendered deliverable is required at this node |

The repaired verifier completed with **17/17 checks PASS**. Numerical checks
exercise the analytic characterization; they do not replace its proofs.

## Invalidation and next gate

Any change to the Gate 0 bundle invalidates all repaired artifacts. No R1 node
may consume this candidate until an independent reviewer reconstructs the
terminal game from primitives, checks the exact interface hash above, and the
orchestrator freezes the reviewed R2 batch. This implementer did not edit the
shared DAG, proof ledger, shared Rmd, Gate 0, another R2 node, or a protected
artifact.
