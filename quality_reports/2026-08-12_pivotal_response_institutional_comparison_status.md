# Pivotal-response rederivation — institutional-comparison candidate status

**Date:** 2026-08-12  
**Node:** `institutional_comparison`  
**Status:** **CANDIDATE PENDING INDEPENDENT READ-ONLY REVIEW**  
**Execution:** `started_order=54`, `implementation_completed_order=55`

This implementation only constructs the institutional-comparison layer. It
does not rederive R1, C2, or entry and does not edit the DAG, proof ledger,
shared derivation Rmd, survival matrix, protected manuscripts, or quarantined
historical artifacts.

## Exact frozen dependencies

```text
Entry batch
  sha256:8817a9c505ce9e5b79deea1b38055d88a629e740e324fbcd5bca707b108b5433

Entry unanimity
  sha256:05e39ad2b84ede134268ffae0898c8cafd8f3de01ef725ca2da6159156a83ed6

Entry majority
  sha256:4eb343ce6f6fb7c34782e708a0e787908437d2682d079e91f26103706c083f21
```

The common existence domain is every primitive-admissible `N=m+1>=3` case.
Imported C1 payoffs are already in Round-1 units; the comparison applies no
new discount or entry cost.

## Candidate artifacts

```text
interface
  model_redesign/pivotal_response_interfaces/institutional_comparison_v1.json
  sha256:cab69c5ddda3616f51c697c189c86316df5546501a183eb6cc9e437dc813f3af

derivation note
  model_redesign/pivotal_response_nodes/institutional_comparison_v1.md
  sha256:e3bcb530e7a99f6fec59c5f637ae6ec4a1204904adbb8cea73157bf0b568502b

R verifier
  scripts/verify_pivotal_response_institutional_comparison.R
  sha256:cb662ca013c5c107f86ab4bbc8dc379cf8fbb193d386e2e19f0f3bb6c14e1e1c

check table
  tables/pivotal_response_institutional_comparison_checks_v1.csv
  sha256:f7bd52b924680117a7fa3f5b06590d1fe705eee2e14c7e98885e5a7c9cccdb15

complete-pair fixtures
  tables/pivotal_response_institutional_comparison_pair_fixtures_v1.csv
  sha256:8cf237c94bc42bb38058c9c0c0e7a8045d3cb4df772481fed4b8fb2a5730c46c

endpoint/status fixtures
  tables/pivotal_response_institutional_comparison_status_logic_v1.csv
  sha256:3d064c5a6670f45a414569023e516bef515297844f23d2698fd5b6ecef2b31dc

boundary fixtures
  tables/pivotal_response_institutional_comparison_boundaries_v1.csv
  sha256:9455f50ba69ee49dfd8c547c30865c536beac0b8ab74c15d51e46d2e4a13a647
```

## Exact comparison object

Because the game supplies no cross-rule selection or correlation primitive,
the comparison correspondence is indexed by the full Cartesian product

```text
A_U(P) x A_M(P).
```

Every element retains both complete assessments and both aligned outcome
distributions. For each rule `R`, pair, and cost,

```text
e_R       =1{G_R>=chi},
W_R       =e_R*(G_R-chi),
H_R(theta)=e_R*C1_R,H(theta)+(1-e_R)*o_theta.
```

H's ex ante payoff integrates the two retained type coordinates with the true
`mu`. The comparison records U-minus-M weak and H differences and one of the
four patterns `both`, `U_only`, `M_only`, or `neither`. There is no endogenous
rule-choice or signaling stage.

## Three distinct nesting objects

For one complete pair,

```text
F_R(alpha_R)=[0,G_R].
```

Thus pairwise `F_U subseteq F_M` iff `G_U<=G_M`, with strict inclusion iff the
inequality is strict and equality iff the thresholds coincide.

Within each rule, let `l_R=inf S_R`, `u_R=sup S_R`, and let `a_R^+` mark upper
attainment. The possible-cost union and guaranteed-cost intersection are

```text
K_R^exists =[0,u_R] if a_R^+=1, and [0,u_R) otherwise;
K_R^forall =[0,l_R].
```

Possible-cost U-in-M nesting requires `u_U<u_M`, or equality plus compatible
upper-attainment flags. Guaranteed-cost U-in-M nesting requires `l_U<=l_M`.
Strictness and equality conditions are recorded explicitly in the interface.

Neither projection is universal cross-assessment nesting. The latter is

```text
F_U(alpha_U) subseteq F_M(alpha_M) for every cross-pair
  iff u_U<=l_M,

F_M(alpha_M) subseteq F_U(alpha_U) for every cross-pair
  iff u_M<=l_U.
```

Strict universal inclusion additionally respects upper/lower endpoint
attainment when the separating endpoints coincide. The frozen inputs do not
generally identify `u_U<=l_M`, so universal U-in-M nesting remains pending.

## Exact status existence and conditional rankings

Formation is possible under rule `R` iff `chi<u_R`, or `chi=u_R` and the
supremum is attained. Nonformation is possible iff `l_R<chi`. Because the
comparison is the full product, the four pattern-existence conditions are the
corresponding products of these two marginal possibilities. In particular, an
unattained supremum never creates formation at equality.

The frozen H ballot best-response inequalities prove

```text
C1_R,H(theta)>=o_theta.
```

Hence H is equal across rules when neither forms, weakly favors U in a U-only
pair, and weakly favors M in an M-only pair. When both form, the H ranking is
indeterminate without the retained pair values. These comparisons are weak:
the forming rule can give H exactly its outside option. Whenever nonformation
is possible under a rule, some entry element attains H's exact outside vector;
if every assessment chooses no, all elements do.

For weak states, only the forming rule can be weakly better in an exclusive
pattern. When both form, `Delta_W=G_U-G_M`. Over the full cost axis,

```text
W_R(chi)=max{G_R-chi,0},
```

so `G_U<=G_M` iff the U weak-payoff curve lies below the M curve at every
cost. H's parallel decomposition is

```text
r_R(theta)=C1_R,H(theta)-o_theta>=0,
Delta_H(theta)=e_U*r_U(theta)-e_M*r_M(theta).
```

## Special endpoints and limits

Both rules satisfy `0<=G_R<=1/m`. Therefore:

- `chi=0`: every pair is `both`;
- `chi>1/m`: every pair is `neither` and H receives its outside vector;
- for `N>=4`, entry-U attains `l_U=0` and entry-M attains `u_M=1/m`.

At `N>=4`, these endpoints prove:

```text
K_U^exists subseteq K_M^exists=[0,1/m],
K_U^forall={0} subseteq K_M^forall=[0,l_M],
```

and, for every `0<chi<=1/m`, existence of an `M_only` pair formed from the U
zero-value assessment and the M value-one assessment. The latter gives H its
outside payoff even while majority forms, so this actual extreme pair has
`Delta_H(theta)=0`. Its weak difference is `-(1/m-chi)`, including zero at
`chi=1/m` because majority forms at equality. These are existence and
union/intersection results, not universal U-in-M nesting or institutional
selection. Since `u_M=1/m>0=l_U`, universal cross-assessment M-in-U nesting is
ruled out for `N>=4`.

At `N=3`, neither special endpoint is imported; all conclusions remain
pairwise or endpoint-conditional.

## Mechanical verification

Command:

```sh
Rscript --vanilla scripts/verify_pivotal_response_institutional_comparison.R
```

Result: **42/42 PASS**.

Coverage includes:

- exact hashes for all three direct dependencies and all 19 entry-batch
  components;
- 310 exhaustive nonempty finite value-set/cost endpoint cases;
- 9,610 finite Cartesian status-pattern cases;
- 961 finite value-set pairs for weak/strict universal nesting and distinct
  possible/guaranteed projections;
- open and closed endpoint-attainment, equality, singleton, strictness, and
  nonattainment cases;
- 96 randomized complete U/M assessment pairs with asymmetric identities,
  proposal mixtures, both H types, strategies, beliefs, continuation and
  outcome fingerprints;
- dense pairwise formation and weak-payoff-curve checks;
- the H outside-option floor, floor attainment, nonnegative-rent decomposition,
  both-form sign indeterminacy, and non-strict exclusive rankings;
- `N=3`, `N>=4`, `chi=0`, `chi=1/m`, and `chi>1/m` boundaries;
- false same-rank/coupled nesting and proposer-projection negative tests;
- three one-at-a-time dependency mutations; and
- all 27 protected hashes.

## Claim status and handoff

The exact Cartesian-product comparison, pairwise operator, three nesting
objects, endpoint-aware pattern existence, H floor, conditional rankings,
payoff decompositions, and `N>=4` existence results are proved and mechanically
checked. General numerical endpoint orderings and universal institutional
dominance are pending and not claimed.

Independent formal and adversarial reviewers must audit the exact interface
hash above and remain read-only. Until both pass, this candidate is not frozen
and no survival-matrix or manuscript consumer may promote it.
