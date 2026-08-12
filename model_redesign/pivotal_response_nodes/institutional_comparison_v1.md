# Institutional comparison on the full product of entry assessments

## Scope and exact frozen inputs

This node compares the two fixed institutional rules only after the entry
correspondences have been independently closed. It consumes literally:

```text
Entry batch      sha256:8817a9c505ce9e5b79deea1b38055d88a629e740e324fbcd5bca707b108b5433
Entry unanimity  sha256:05e39ad2b84ede134268ffae0898c8cafd8f3de01ef725ca2da6159156a83ed6
Entry majority   sha256:4eb343ce6f6fb7c34782e708a0e787908437d2682d079e91f26103706c083f21
```

The common PBE-existence domain is `N=m+1>=3`, `mu in [0,1]`,
`0<=o_0<o_1<=y_bar<=1`, `beta in (0,1]`, and `chi>=0`. C1 payoffs are
already expressed in Round-1 units. This comparison applies neither `beta`
nor the entry cost a second time.

Nothing here rederives R1, C2, or entry. Unanimity and majority remain fixed
counterfactual rules. The model has no endogenous rule-choice or signaling
stage.

## 1. Why the comparison is a Cartesian product

Let `A_U(P)` and `A_M(P)` denote the exact complete assessment sets carried by
the two approved entry interfaces at primitive-history index `P`. The game
contains no primitive that correlates equilibrium selection across
counterfactual institutions: no common random device, rank matching, shared
off-path belief, or rule-choice stage. The exact comparison index is therefore

```text
A_U(P) x A_M(P).                                                (1)
```

Every element of (1) retains both assessments whole. In particular, it keeps
all type-by-identity weak payoffs, both H type coordinates, strategies,
beliefs, continuation selections, cost ledgers, and aligned outcome kernels.
Equal scalar values do not merge assessments. Conversely, matching two
assessments by scalar rank or proposer payoff would add a coupling absent from
the game.

### Proposition 1 (exact comparison correspondence)

For fixed `P`, `mu`, and `chi`, the institutional-comparison correspondence is

```text
C(P,mu,chi)
  ={Comp(alpha_U,alpha_M;mu,chi):
      (alpha_U,alpha_M) in A_U(P) x A_M(P)}.                    (2)
```

**Proof.** Each coordinate of a comparison must be a complete entry PBE
assessment of its own fixed-rule game, which proves that any admissible pair
lies in the right side of (2). In the absence of a cross-rule selection
primitive, no restriction links an admissible U assessment to a proper subset
of admissible M assessments. Thus every cross-pair is admissible. The
comparison operator below only reads and retains the coordinates; it changes
neither assessment. QED.

## 2. Assessment-pair payoff and outcome operator

Fix one whole pair `(alpha_U,alpha_M)`. For `R in {U,M}`, import the collective
gross value

```text
G_R=G_R(alpha_R,mu)
```

from the corresponding entry element and define

```text
e_R = 1{G_R>=chi}.                                              (3)
```

Equality forms. The realized collective net payoff per weak state is

```text
W_R=e_R*(G_R-chi).                                              (4)
```

It is zero if the institution does not form. For each H type,

```text
H_R(theta)
  =e_R*C1_R,H^alpha_R(theta)+(1-e_R)*o_theta,                   (5)

H_R(mu)=(1-mu)H_R(0)+mu H_R(1).                                (6)
```

The prior in (6) is the true `mu`, not a proposal-contingent ballot belief.
Define the U-minus-M differences

```text
Delta_W       =W_U-W_M,
Delta_H(theta)=H_U(theta)-H_M(theta),
Delta_H(mu)   =H_U(mu)-H_M(mu).                                (7)
```

The formation pattern is `both`, `U_only`, `M_only`, or `neither` according
to `(e_U,e_M)=(1,1),(1,0),(0,1),(0,0)`. The comparison record retains the two
complete realized outcome distributions in addition to this label and the
payoff summaries.

## 3. Exact pairwise formation-set comparison

For a fixed assessment, define its cost-indexed formation set

```text
F_R(alpha_R)={chi>=0:e_R=1}=[0,G_R].                            (8)
```

### Proposition 2 (pairwise threshold and nesting)

For every complete cross-pair,

```text
F_U subseteq F_M  iff G_U<=G_M,
F_M subseteq F_U  iff G_M<=G_U,
F_U=F_M           iff G_U=G_M.                                 (9)
```

The corresponding inclusion is strict iff the displayed threshold inequality
is strict.

At a fixed cost,

```text
both:    0<=chi<=min{G_U,G_M},
U_only:  G_M<chi<=G_U,
M_only:  G_U<chi<=G_M,
neither: chi>max{G_U,G_M}.                                     (10)
```

The `U_only` region is nonempty exactly when `G_U>G_M`; the `M_only` region is
nonempty exactly when `G_M>G_U`.

**Proof.** Equation (8) follows directly from (3) and equality formation.
Inclusion of two closed intervals with common lower endpoint zero is equivalent
to ordering their upper endpoints, which proves (9). Intersecting the two
weak inequalities in (3), or one weak and one strict inequality for an
exclusive pattern, gives (10). QED.

The weak inequality on the forming side of each exclusive region matters. At
`chi=G_R`, rule `R` forms with zero net weak payoff.

## 4. Selection-free pattern existence and endpoint attainment

For each rule define the nonempty value set and endpoints

```text
S_R(P,mu)={G_R(alpha_R,mu):alpha_R in A_R(P)},
l_R=inf S_R,   u_R=sup S_R.
```

Let `a_R^+=1` exactly when an assessment attains `u_R`. Then

```text
PF_R(chi) := [chi<u_R] or [chi=u_R and a_R^+=1],
PN_R(chi) := [l_R<chi].                                        (11)
```

Here `PF` means that formation is possible and `PN` means that nonformation is
possible. The upper-attainment qualifier in (11) is indispensable: when
`chi=u_R` and the supremum is not attained, every assessment has `G_R<chi`.
At the lower endpoint, `PN_R` is false regardless of lower attainment because
no value can lie strictly below its infimum.

### Proposition 3 (exact status-pattern existence)

At a fixed cost,

| Pattern | Exists if and only if |
|---|---|
| both | `PF_U and PF_M` |
| U_only | `PF_U and PN_M` |
| M_only | `PN_U and PF_M` |
| neither | `PN_U and PN_M` |

**Proof.** The rule-specific status projections are exactly the sets generated
by (11). Proposition 1 makes the joint projection their Cartesian product.
Each row is therefore the conjunction of the two required marginal statuses.
QED.

The phrase “formation set” can now refer to three different objects. They must
not be conflated. Within each rule, define the costs at which at least one
assessment forms and the costs at which every assessment forms:

```text
K_R^exists =union_{alpha_R} F_R(alpha_R),
K_R^forall =intersection_{alpha_R} F_R(alpha_R).                (12)
```

### Proposition 4 (possible-cost and guaranteed-cost projections)

The exact projections are

```text
K_R^exists =[0,u_R]  if a_R^+=1,
             [0,u_R) if a_R^+=0,

K_R^forall =[0,l_R].                                           (13)
```

Consequently,

```text
K_U^exists subseteq K_M^exists
 iff u_U<u_M,
  or u_U=u_M and [a_U^+=0 or a_M^+=1];                         (14)

K_U^forall subseteq K_M^forall iff l_U<=l_M.                   (15)
```

The reverse conditions exchange `U` and `M`. The possible-cost sets are equal
iff `u_U=u_M` and `a_U^+=a_M^+`; inclusion is strict when inclusion holds and
this equality condition fails. The guaranteed-cost sets are equal iff
`l_U=l_M` and inclusion is strict iff the corresponding endpoint inequality
is strict.

**Proof.** The union in (12) contains every cost strictly below the supremum
and contains the supremum exactly when it is attained. The intersection
contains every cost weakly below the infimum, including the infimum whether or
not some assessment attains it. Inclusion and equality of the resulting
half-intervals give (14)--(15) and their reverse statements. QED.

These union/intersection projections are not the condition that every U
assessment's interval be nested in every M assessment's interval. That third,
strictly cross-assessment object is next.

### Proposition 5 (universal cross-assessment nesting)

Across every complete cross-pair,

```text
F_U(alpha_U) subseteq F_M(alpha_M) for all pairs
  iff u_U<=l_M,                                                 (16)

F_M(alpha_M) subseteq F_U(alpha_U) for all pairs
  iff u_M<=l_U.                                                 (17)
```

Let `a_R^-` record lower-endpoint attainment. Strict inclusion for **every**
cross-pair has the endpoint-sensitive characterization

```text
F_U(alpha_U) strict-subset F_M(alpha_M) for all pairs
 iff u_U<l_M,
  or u_U=l_M and not[a_U^+=1 and a_M^-=1],
```

with the symmetric condition for strict `M-in-U`. When the two separating
endpoints coincide, equality of one pair is possible exactly if both relevant
endpoints are attained. All cross-pair formation sets are equal exactly when
both value sets are the same singleton: `l_U=u_U=l_M=u_M`.

**Proof.** By Proposition 2, the left side of (16) is the statement that every
element of `S_U` is no larger than every element of `S_M`. This holds exactly
when `sup S_U<=inf S_M`. The proof of (17) is symmetric. If all cross-pair
thresholds are equal, every element of each nonempty set equals the same
number; the converse is immediate. QED.

These are exact endpoint characterizations, not numerical rankings. The
frozen interfaces do not generally identify `u_U` or `l_M`; at `N=3` they do
not generally identify the reverse pair either. Accordingly, no general
U-in-M conclusion is asserted. Same-rank or endpoint-matched checks cannot
replace the universal cross-product conditions.

## 5. H's outside-option floor and conditional rankings

### Lemma 1 (H participation floor inherited from C1)

For every complete frozen C1 assessment, rule, and type,

```text
C1_R,H^alpha_R(theta)>=o_theta.                                (18)
```

**Proof.** At every H ballot information set under either rule, voting `no`
irreversibly opts H out. For every simultaneous weak-vote realization this
action gives type `theta` exactly `o_theta`, without discount. The PBE ballot
fixed point makes H's equilibrium behavioral action a best response against
the distribution of weak ballots, so its conditional expected payoff is at
least the payoff from the available `no` action. This argument does not let H
observe the sealed weak ballots and does not reduce relevance to the quota.
Integrating the conditional inequality over the equilibrium proposal mixture
and uniform weak recognition preserves it, proving (18). QED.

Equations (5) and (18) imply `H_R(theta)>=o_theta` at entry. They yield the
following exact conditional comparisons:

| Pattern | Weak U-minus-M | H U-minus-M |
|---|---|---|
| neither | `Delta_W=0` | `Delta_H(theta)=0` for both types |
| U_only | `Delta_W=G_U-chi>=0` | `Delta_H(theta)=C1_U,H(theta)-o_theta>=0` |
| M_only | `Delta_W=-(G_M-chi)<=0` | `Delta_H(theta)=o_theta-C1_M,H(theta)<=0` |
| both | `Delta_W=G_U-G_M` | sign of `C1_U,H(theta)-C1_M,H(theta)` is undetermined |

Typewise inequalities imply their true-prior ex ante counterparts. These are
pair-conditional identities and bounds. They do not select an assessment or
establish unconditional institutional dominance.

The floor is attained whenever nonformation is possible. If `PN_R(chi)` holds,
there is a complete assessment with `G_R<chi`; its entry action is no formation
and (5) gives H exactly `(o_0,o_1)`. If all assessments choose no, every entry
element attains that vector. In particular, `chi>l_R` is the exact condition
for at least one no-form element and hence for this direct floor-attainment
argument.

There are two useful equivalent decompositions. First, over the entire cost
axis,

```text
W_R(chi)=max{G_R-chi,0}.
```

Thus `G_U<=G_M` if and only if `W_U(chi)<=W_M(chi)` for every `chi>=0`; the
curves coincide for every cost iff `G_U=G_M`. Second, define H's nonnegative
type-specific rent

```text
r_R(theta)=C1_R,H(theta)-o_theta>=0.
```

Then

```text
H_R(theta)=o_theta+e_R*r_R(theta),
Delta_H(theta)=e_U*r_U(theta)-e_M*r_M(theta).                   (19)
```

This makes clear why the H rankings in the exclusive patterns are weak, not
strict: the forming institution can give H exactly its outside option.

The common resource envelope gives the selection-free weak bounds

```text
0<=W_R<=max{1/m-chi,0},
|Delta_W|<=max{1/m-chi,0}.                                     (20)
```

Equal formation status or equal payoff does not imply equal payments,
inclusion, opt-out histories, beliefs, or outcome distributions.

## 6. Boundary and special-endpoint implications

Both frozen entry interfaces prove `0<=G_R<=1/m`. Therefore:

- At `chi=0`, every assessment forms under both rules, including at `G_R=0`.
  Every comparison pair has pattern `both`.
- At `chi>1/m`, no assessment forms under either rule. Every pair has pattern
  `neither`, every weak payoff is zero, and each H type receives `o_theta`.
- At `chi=1/m`, formation still occurs for any assessment attaining the upper
  resource bound; an unattained supremum is not enough.

For every `N>=4`, the approved U entry interface proves `l_U=0` with an
attaining assessment, while the approved M entry interface proves `u_M=1/m`
with an attaining assessment.

These endpoints imply two within-rule projection results:

```text
K_M^exists=[0,1/m], so K_U^exists subseteq K_M^exists;
K_U^forall={0},    so K_U^forall subseteq K_M^forall.           (21)
```

The first inclusion may be equality or strict depending on `u_U` and upper
attainment. The second may be equality or strict depending on `l_M`. Neither
statement is the universal cross-assessment condition in Proposition 5.

### Corollary 1 (existence of an M-only pair for `N>=4`)

For every `N>=4` and every `0<chi<=1/m`, there exists a complete cross-pair
with pattern `M_only`.

**Proof.** Pair the attained U assessment with `G_U=0` and the attained M
assessment with `G_M=1/m`. Positive cost makes U choose no. Majority forms
because `chi<=1/m`, including equality at `chi=1/m`. Proposition 1 admits this
cross-pair. QED.

The frozen M value-one construction used here gives H its type-specific
outside payoff even though majority forms. U nonformation does the same.
Therefore this actual extreme pair has

```text
Delta_H(theta)=0 for both types,
Delta_W=-(1/m-chi).
```

The weak difference is strictly negative for `0<chi<1/m` and equals zero at
`chi=1/m`, when majority forms at collective indifference. Thus even the
guaranteed `M_only` example does not imply a strict H advantage.

Because `u_M=1/m>0=l_U`, the corollary also rules out universal
cross-assessment `M-in-U` nesting for `N>=4`. Universal cross-assessment
`U-in-M` remains pending because it requires `u_U<=l_M`. The corollary does
**not** show that every pair is M-only or that the model selects majority. At
`N=3`, neither special endpoint is imported; only the general pairwise and
endpoint-conditional results apply.

## 7. Verification and status

The R verifier checks exact dependency bytes; the complete-product rather than
coupled comparison; exhaustive nonempty finite value subsets and cross-pairs;
attained and unattained endpoint boundaries; randomized full assessment
fixtures with asymmetric identities, proposal mixtures, type-specific H
coordinates, and retained outcome labels; the `N=3` and `N>=4` boundaries;
false-nesting and proposer-projection mutations; three dependency mutations;
and all 27 protected hashes.

The machine checks validate algebra and guards; they do not replace the proofs
above. This artifact remains a candidate until two independent read-only
reviews accept its exact hash. No survival-matrix or manuscript claim may use
it as frozen before then.
