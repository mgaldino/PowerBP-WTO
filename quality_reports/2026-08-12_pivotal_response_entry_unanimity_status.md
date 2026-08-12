# Pivotal-response rederivation — entry under unanimity

**Date:** 2026-08-12  
**Node:** `entry_unanimity`  
**Status:** **CANDIDATE — PENDING INDEPENDENT READ-ONLY REVIEW**  
**Started order:** 41  
**Implementation boundary:** stopped before independent acceptance, entry-batch
freeze, institutional comparison, or manuscript integration.

This document repairs the rejected notation/documentation candidate
`sha256:efa5933adba180bff9d1c8ffd6ff6c53b7dc5345de72b14f088a7dd2542553e8`.
Its mathematics was not changed; the endpoint-attainment notation is now
distinct from the assessment set, and the completed mechanical execution is
recorded consistently.

## Frozen dependencies

```text
Gate 0 bundle       sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1
R1 batch freeze     sha256:f4ac7b89f4c08d4ee461ca1431135286304abaae2589a337aeffdb38b5941c3a
C1-U interface      sha256:37aae1bfe7921c6c90aff5d05ed301f8729c2b899477991619bcf0cb6c96e8b5
```

These exact bytes were consumed literally. The implementation did not
rederive or alter C1/C2, run a downstream discount, select an assessment from
a scalar bound, or import a historical entry formula. The R1 batch verifier's
pre-entry frontier checks are intentionally historical after entry starts;
this node instead hashes the frozen batch and its exact C1-U dependency.

## Candidate artifacts

```text
interface
  model_redesign/pivotal_response_interfaces/entry_unanimity_v1.json
  sha256:05e39ad2b84ede134268ffae0898c8cafd8f3de01ef725ca2da6159156a83ed6

analytic note
  model_redesign/pivotal_response_nodes/entry_unanimity_v1.md
  sha256:29e9d62e272ab4ef292653d0ad0000b88c24a7da47d98c5a9d311550bff09c5a

mechanical verifier
  scripts/verify_pivotal_response_entry_unanimity.R
  sha256:7a6f53e242aa7b938ffee9202f7ddfac4eed5742bd33c01cfbe2c201ad37f76e

check table
  tables/pivotal_response_entry_unanimity_checks.csv
  sha256:8e87dc91c21e1a3aa29a508b80640527fa57fe09cd071acba7100cf458495552

full-assessment fixtures
  tables/pivotal_response_entry_unanimity_assessment_fixtures_v1.csv
  sha256:3e0fe880587a8f5694e84aa8239fd2256ad65cf19c53350f096f5e27749422ed

realized type-by-identity payoffs
  tables/pivotal_response_entry_unanimity_realized_payoffs_v1.csv
  sha256:36c21275226886873e2f963add2e63d374acce88912d66c304df64171cd2333c

endpoint logic fixtures
  tables/pivotal_response_entry_unanimity_endpoint_logic_v1.csv
  sha256:db12159a79e84388c1a921efa3467e75b2fbcfefd1fa1b21838584aabcdc5010
```

## Exact entry operator

For every complete frozen C1-U assessment `alpha`, the operator first retains
the within-recognizer `E_sigma_i` payoff and outcome coordinates, then averages
uniformly over recognizers, separately by type and player identity. It defines

```text
T_W_alpha(theta) = sum_k C1_W_alpha(theta,k),

G_U(alpha,mu)
  = [(1-mu)T_W_alpha(0)+mu T_W_alpha(1)]/m,

Z_U(alpha,mu,chi) = G_U(alpha,mu)-chi.
```

The uninformed weak coalition forms iff `G_U>=chi`; equality forms. If it
forms, weak identity `k` in realized type `theta` receives
`C1_W_alpha(theta,k)-chi`, H receives `C1_H_alpha(theta)`, and the outcome
kernel is the aligned `D1_alpha(theta)`. If it does not form, all weak states
receive zero, H receives `o_theta`, and the outcome is nonformation.

The exact output is the alpha-preserving image of the full C1-U
correspondence. Equal gross values or equal form/no-form labels do not identify
assessments with different identity payoffs, H payoffs, strategies, beliefs,
payments, continuation selections, or outcomes.

## Selection-free endpoint logic

Let the nonempty gross-value image have infimum `L_U`, supremum `U_U`, and
unambiguous endpoint-attainment indicators `a_U^-` and `a_U^+`. The assessment
correspondence retains the distinct notation `A_U(P)`. The proved logic is

```text
a_U^- = 1 iff some alpha attains L_U
a_U^+ = 1 iff some alpha attains U_U

all_form        iff L_U >= chi
possible_form   iff chi < U_U or (chi=U_U and a_U^+=1)
possible_no     iff L_U < chi
all_no          iff U_U < chi or (chi=U_U and a_U^+=0)
```

At `chi=L_U`, all assessments form even when the infimum is unattained. At
`chi=U_U`, formation is possible exactly when the supremum is attained.

Frozen C1-U directly gives `0<=G_U<=1/m`. Therefore `chi=0` implies all form,
and `chi>1/m` implies all do not form. At `chi=1/m`, possible formation
requires attainment of the upper bound. For every `N>=4`, the explicit frozen
zero-weak-value assessment proves `L_U=0` with attainment, so every positive
cost permits nonformation and rules out all-form. No corresponding general
zero-value claim is made for `N=3`.

The frozen interface does not provide general closed forms for `L_U`, `U_U`,
or upper attainment. General `N=3` endpoint attainment also remains pending.
The candidate does not replace those unknown objects by `[0,1/m]` or choose an
assessment using that coarse bound.

## Mechanical validation

Command:

```sh
Rscript --vanilla scripts/verify_pivotal_response_entry_unanimity.R
```

Result: **37/37 PASS**.

The verifier checked:

- 72 rows carrying two complete synthetic alphas across all recognizers,
  proposal-support points, types, weak identities, and aligned strategy,
  belief, payment, continuation-selection, H-payoff, and outcome components;
- 48 realized payoff rows spanning positive-net, equality, and negative-net
  entry cases;
- exact `E_sigma -> recognition -> type -> cross-weak average` accounting;
- identity asymmetry and non-quotienting of equal gross values;
- external costs, equality formation, H/nonformation payoffs, and aligned
  outcome distributions;
- seven attained/unattained endpoint cases, including the two equality
  boundaries and the singleton consistency condition;
- ten valid primitive boundaries and seven invalid-domain mutations;
- three dependency mutation guards, including C1-U and the R1 batch; and
- all 27 protected artifacts as byte-identical.

The synthetic calculations validate the operator but do not replace the
analytic proofs in the node note.

## Honest claim status

| Claim | Status |
|---|---|
| Assessment-level entry operator | proved |
| Exact alpha-preserving correspondence | proved |
| Realized type-by-identity payoff/outcome map | proved |
| Infimum/supremum formation logic | proved |
| Gross bound `[0,1/m]` | proved from frozen C1-U |
| `N>=4` zero lower endpoint and attainment | proved from frozen C1-U |
| General `N=3` endpoint values/attainment | pending; not claimed |
| General upper endpoint value/attainment | pending; not claimed |
| Closed-form cost regions | pending; not claimed |
| Independent formal acceptance | pending |

## Governance boundary

The implementer created only the exclusive entry-U interface, note, verifier,
three data tables plus the check table, and this status report. It did not edit
the DAG, proof ledger, shared Rmd, the majority entry node, Gate 0, any R1/R2
artifact, or a protected file. Independent reviewers must evaluate the exact
candidate hash before the parent marks the node PASS or freezes a downstream
batch.
