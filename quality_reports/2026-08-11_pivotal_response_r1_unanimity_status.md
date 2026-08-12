# Pivotal-response rederivation — R1 unanimity candidate status

**Date:** 2026-08-11  
**Node:** `r1_unanimity`  
**Status:** **REPAIRED CANDIDATE — PENDING INDEPENDENT READ-ONLY REREVIEW**

The rejected predecessor was
`sha256:da52b135198898948ae88f919a849c76189f27fc6fff4d3f7646c4218d0f30aa`.
It is not consumable.

## Frozen dependencies consumed

```text
Gate 0 bundle       sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1
R2 batch interface  sha256:00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a
C2-U active-H       sha256:f3ca4ebf28827d7e18d9f3a2d07d41ffd6fe57532c9af09300f20a8ab5cecf10
```

The repaired candidate did not rederive, repair, or scalarize C2-U. A single
public-history-measurable and type-blind map `kappa_i(h2)` carries one literal
selected C2-U element—including both type coordinates—at every full history.

## Candidate artifacts

```text
interface
  model_redesign/pivotal_response_interfaces/r1_unanimity_v1.json
  sha256:37aae1bfe7921c6c90aff5d05ed301f8729c2b899477991619bcf0cb6c96e8b5

analytic note
  model_redesign/pivotal_response_nodes/r1_unanimity_v1.md
  sha256:f35b0ef0dfce940ffa15771c011236f7cb37474da9a9b386d14dfc05df16fda9

mechanical verifier
  scripts/verify_pivotal_response_r1_unanimity.R
  sha256:0399f956c245f1d205f23bdf24970ae2d02e9bc0c4d8b9b57b935415ec62365e

check table
  tables/pivotal_response_r1_unanimity_checks.csv
  sha256:89cad5831e1612c366d1233a264f9265a0169e01772370d0671c062448a45586

enumeration registry
  tables/pivotal_response_r1_unanimity_cases_v1.csv
  sha256:035b999dc680d7c13116034ede437e86cc8e9683b41f497a688f8a343fb7f6f3

N=3 primitive grid
  tables/pivotal_response_r1_unanimity_n3_grid_v1.csv
  sha256:2f90b396ed2bb739d4bed1582a3648ebebd79a8312f79ef49fc1d95458d15a46
```

## Main analytic findings

1. At a fixed proposal, type `theta` of `H` uses the exact full-vector IC

   ```text
   Delta_H(theta)
     = Q(bold1)(y-o_theta)
       + sum_{w!=bold1}Q(w)(beta*c_H,w^theta-o_theta).
   ```

   Hence `y>=o_theta` is valid only in the sure-weak-yes subclass. The
   verifier constructs a valid ballot completion in which the low type votes
   yes at `y<o_0` because the selected failure continuation is valuable.

2. Every weak voter compares both type states and every vector of the other
   simultaneous votes. If both of its actions reject the current proposal,
   the difference between the two history-specific C2 selections still enters
   with one `beta`. Unchanged quota status does not establish irrelevance.

3. The exact fixed-proposal object is a necessary-and-sufficient assessment
   fixed point. The exact proposal-stage object adds proposal-contingent
   completions, global proposer maximization, and the frozen H-payoff
   tie-break. It remains a full payoff/belief/outcome correspondence.

4. The historical `P`, `L`, and `R` outcome motifs—respectively, both-type
   current passage, low-type current passage, and deliberate active-H
   continuation—each survive only conditionally through explicit subclasses.
   None of their old formulas is imported. A global three-label reduction is
   rejected for this full PBE object.

5. Gifts remain feasible and no coalition-size property is imposed. `H`
   never mixes; weak voters may mix only at zero relevance; proposal mixtures
   require a double tie in both proposer and H values.

6. Universal existence and attainment are now proved on the full primitive
   population domain `N>=3`. For `N>=4`, a Bayes-aligned canonical
   coordinated-failure assessment supplies the construction. For `N=3`, five
   exhaustive cases split by `G=1-o_1`, `beta`, and `mu`. When `G=0`, the
   proof preserves the nonclosed C2 endpoint by using the attained positive
   posterior-zero element `c_0=(1-o_0)/4`, never the missing zero infimum.

7. The node proves selection-free bounds

   ```text
   0 <= each weak payoff,
   sum of weak payoffs <= 1,
   o_theta <= H type-theta payoff <= 1.
   ```

   The machine-readable validated export domain is `N>=3`, pending acceptance
   of this exact repaired hash by the independent rereviewers.

8. The C1 export first computes `E_sigma_i` separately for every player
   identity and both type coordinates, then integrates uniform recognition.
   Only afterward does it form each weak identity's ex-ante `mu` projection.
   Payoffs, beliefs, payments, continuation selections, and outcome kernels
   remain aligned under the same assessment index `alpha`.

## Mechanical verification

Command:

```sh
LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
  Rscript --vanilla scripts/verify_pivotal_response_r1_unanimity.R
```

Result: **37/37 PASS**.

The run checked:

- 5,670 full weak-vote vectors;
- 11,340 type-conditional `H` vector evaluations;
- 28,890 weak type/action/other-vector comparisons;
- 720 random type-conditional payoff-accounting branches;
- 540 cases instantiating the universal `N>=4` existence construction;
- 96 full primitive-grid `N=3` construction cases;
- 319 `N=3` off-path proposal-deviation inequalities;
- all 4 exact `P=S` proposer-tie boundaries;
- 60 positive-probability Bayes/C2-membership cases;
- a negative test that rejects `posterior=mu` in all 40 separating cases;
- type-blind `kappa`, both-type coordinate, outcome-alignment, and
  `E_sigma`-averaging mutation tests;
- exactly one `beta` on C2 imports and none on immediate opt-out;
- in-memory mutation guards for dependencies and the full-domain gate; and
- all 27 protected artifacts as byte-identical.

## Governance boundary

The implementer has not edited the DAG, shared proof ledger, shared Rmd,
Gate 0, any R2 artifact, the other R1 node, or a protected file. This candidate
must not be marked PASS or consumed by entry until independent formal and
adversarial read-only review approves its exact interface hash.

Any dependency-byte change invalidates this candidate and every descendant.
