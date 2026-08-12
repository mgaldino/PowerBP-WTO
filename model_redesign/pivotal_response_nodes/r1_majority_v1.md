# Round 1 majority with an active hegemon

## Scope and frozen continuations

This note derives only `r1_majority`.  It consumes, without repairing or
selecting inside the proof, the independently reviewed Round-2 batch

```text
R2 batch                 sha256:00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a
C2 majority, active H    sha256:a4ae73e9bb4114490bbc517732eca0ff7f5368186aee1a02388a8f85f52568b2
C2 majority, weak only   sha256:e0ec6cd35e145f04d1a2897fc1f78157f2b0d45de478046ac5451b2df0a74b5d
```

The solution concept is PBE under the Gate 0 response-at-equality rule.  A
ballot is simultaneous and sealed.  No coalition restriction, zero-gift
restriction, common completion, or scalar continuation is imposed.  Every C2
payoff below is in native Round-2 units and is multiplied by `beta` exactly
once only on a branch that reaches Round 2.

## 1. State, proposal, beliefs, and assessment objects

There are `N=m+1>=3` states, `H` and `m` weak states.  Before recognition the
public state is

```text
(M, round=1, H=active, full h1, mu(h1)).
```

A weak proposer `i` is recognized uniformly.  After recognition it proposes

```text
s=(y,(x_j)_{j!=i}),       0<=y<=y_bar,
x_j>=0,                   X=sum_{j!=i}x_j<=1-y,
r_i=1-y-X.
```

There are `n=m-1=N-2` weak nonproposers.  The proposer is counted as yes.  A
complete nonproposer vector is `a in {0,1}^n`, with

```text
z(a)=1+sum_j a_j
```

total weak yes votes.  The majority quota is
`q=floor(N/2)+1`.

The ballot belief after proposal `s` is `rho(s)`.  On the support of the
uninformed weak proposer's strategy, `rho(s)=mu`.  At a globally off-path
proposal, `rho(s)` is an explicit assessment component.  Voters use `rho(s)`;
the proposer evaluates every deviation under the true preproposal `mu`.
These two objects are not interchangeable.

Let `p_j(s)` be weak voter `j`'s independent probability of yes.  The response
rule below makes each H type's action pure; write it as `h_theta(s) in {Y,N}`.
For every complete action-specific failed history, the assessment also fixes

```text
kappa_A(h2) in C2_M_active(h2),
kappa_O(h2) in C2_M_WO(h2).
```

The first selection contains the complete type-by-identity payoff vector,
proposal and ballot assessment, terminal-signature distribution, and beliefs
from the frozen active-H interface.  The second contains the complete
weak-only object from the frozen post-opt-out interface.  Selections are made
as parts of the strategy assessment before any current ballot is observed;
they are not choices granted to a voter after seeing the vector.  Equal raw
successor labels do not identify selections at distinct full histories.

Both selection maps are public-measurable and type-blind.  Their argument is
the complete public history `h2`, never the privately known `theta`.  If one
public history is compatible with both types, one and the same selected C2
element governs both types and carries its own type-conditional payoff and
outcome coordinates.  Thus notation such as `C^A_{k,theta}(h2)` selects the
`theta` coordinate of `kappa_A(h2)`; it does not denote a type-contingent
choice of `kappa_A`.  The same restriction applies to `kappa_O`.

At a positive-probability history following H action `d`, Bayes' rule gives

```text
nu(h2)=rho Pr(d|theta=1,s) /
       [(1-rho)Pr(d|theta=0,s)+rho Pr(d|theta=1,s)].
```

The weak vector has no type likelihood conditional on `s`.  A history that
has zero probability under the complete local strategy receives an explicit
off-path posterior.  This includes a history reached only after a pure-action
deviation.  Each `kappa_A(h2)` must belong to the active-H C2 correspondence at
that exact full history and posterior.  `kappa_O(h2)` remains indexed by the
full history even though type is payoff-irrelevant after opt-out.

## 2. Exhaustive transition and mixed-date payoff map

For player `k`, type `theta`, H action `d`, and weak vector `a`, define
`U_k^d(theta,a;s)` in Round-1 units as follows.

| H action | Weak count | Gate 0 branch | Round-1 payoff |
|---|---:|---|---|
| `Y` | `z>=q-1` | PR04, current passage with H | `H:y`; proposer `r_i`; named weak `j:x_j` |
| `Y` | `z<=q-2` | PR05, active-H C2 | `beta C^A_{k,theta}(h2^Y_a)` |
| `N` | `z>=q` | PR06, current weak-only passage | `H:o_theta`; proposer `1-X`; named weak `j:x_j` |
| `N` | `z<=q-1` | PR07, weak-only C2 | `H:o_theta`; weak `k:beta C^O_k(h2^N_a)` |

Thus an H no pays `o_theta` immediately and exactly once.  It never receives
`beta C2_M_WO` and never receives `o_theta+beta o_theta`.  The weak players,
and only the weak players, receive `beta C2_M_WO` on PR07.  On PR05 every
player receives the active-H continuation discounted once.  Current passage
uses current payoffs and no discount.

For a fixed proposal assessment, let

```text
P_p(a)=product_j p_j^a_j (1-p_j)^(1-a_j).
```

The type-conditional payoff and full outcome distribution are obtained by
integrating the displayed four-branch vector over `a`; the true proposer
payoff is

```text
G_i(s;mu)=(1-mu) E_p[U_i^{h_0}(0,a;s)]
          +mu E_p[U_i^{h_1}(1,a;s)].                 (1)
```

The corresponding `G_H` and every identity-specific `G_j` use the same joint
distribution.  The interface retains those vectors and the PR04--PR07,
inclusion, opt-out, implemented-payment, public-history, and C2-signature
coordinates; equation (1) is only a scalar projection.

## 3. H's exact voting condition

Fix `s`, `p`, all action-specific beliefs, and both C2 selection maps.  For
type `theta`, H's monetary difference between yes and no is

```text
Delta_H(theta)
 = sum_{a:z(a)>=q-1} P_p(a) [y-o_theta]
 + sum_{a:z(a)<=q-2} P_p(a)
       [beta C^A_{H,theta}(h2^Y_a)-o_theta].          (H-IC)
```

`kappa_O` does not enter H-IC: no realizes `o_theta` now irrespective of
whether the weak ballot currently passes.  H's action changes at least
opt-out status for every `a`, including profiles where the weak quota is
already secured and profiles where both actions have the same monetary
payoff.  H therefore has relevance probability one and the prescribed action
is

```text
h_theta=Y iff Delta_H(theta)>=0; otherwise h_theta=N. (H-BR)
```

There is no mixed H action at equality.  Unlike terminal R2, this is generally
not a global threshold in `y`: every failed-vector continuation selection in
(H-IC) can matter.

## 4. Each weak voter's exact voting condition

Fix weak nonproposer `j` and a vector `a_-j`; let

```text
z0=1+sum_{k!=j}a_k
```

be the total weak yes count when `j` votes no.  Define the action-specific
monetary differences `delta_j^d(theta,a_-j)`.

For H yes,

```text
delta_j^Y = 0,
  if z0>=q-1;

delta_j^Y = x_j-beta C^A_{j,theta}(h2^Y_{a_j=N}),
  if z0=q-2;

delta_j^Y = beta[C^A_{j,theta}(h2^Y_{a_j=Y})
                 -C^A_{j,theta}(h2^Y_{a_j=N})],
  if z0<=q-3.                                      (W-Y)
```

For H no,

```text
delta_j^N = 0,
  if z0>=q;

delta_j^N = x_j-beta C^O_j(h2^N_{a_j=N}),
  if z0=q-1;

delta_j^N = beta[C^O_j(h2^N_{a_j=Y})
                 -C^O_j(h2^N_{a_j=N})],
  if z0<=q-2.                                      (W-N)
```

Empty ranges are ignored.  In particular, the structural H-yes toggle is
empty at `N=3`.  Let `P_-j(a_-j)` be the independent probability of the other
weak vector.  The weak voter's exact expected monetary difference is

```text
D_j = sum_theta rho_theta sum_{a_-j} P_-j(a_-j)
      [1{h_theta=Y} delta_j^Y(theta,a_-j)
       +1{h_theta=N} delta_j^N(theta,a_-j)].          (W-IC)
```

Separately, let `R_j` be the probability, under the same distribution, that
the two action-specific **full Gate 0 outcome signatures** differ.  On a
double-failure profile, this comparison is between
`kappa(h2_{a_j=Y})` and `kappa(h2_{a_j=N})`, not between two raw node labels.
It includes continuation outcomes, beliefs when relevant, inclusion, opt-out,
payments, and payoff distributions.  The response condition is

```text
if R_j>0: p_j=1 when D_j>=0 and p_j=0 when D_j<0;
if R_j=0: any p_j in [0,1] is an explicit completion. (W-BR)
```

Thus an interior weak randomization can only be a zero-relevance completion.
The condition does not imply zero gifts, minimal support, or common
completions across proposals.

### Proposition 1 (fixed-proposal ballot fixed point)

For fixed `s`, `rho`, posterior map, and admissible action-specific C2
selection maps, a ballot profile is sequentially rational if and only if
(H-BR) holds for both types and (W-BR) holds for every weak nonproposer.

**Proof.**  The four rows in Section 2 exhaust Gate 0 transitions.  Holding
others' simultaneous actions fixed, subtracting H's no payoff gives (H-IC).
For a weak voter, direct subtraction in the three exhaustive count regions
for each H action gives (W-Y) and (W-N).  Integrating at that information set
gives (W-IC).  Gate 0 then prescribes (H-BR) and (W-BR), including equality
and zero-relevance completions.  No later choice remains inside the R1
ballot.  QED.

## 5. Exact proposal-stage PBE characterization

For recognized proposer `i`, a majority-R1 assessment consists of:

1. a proposal distribution `sigma_i`;
2. a belief map `rho_i(s)`, equal to `mu` on support and explicit elsewhere;
3. type actions, independent weak ballot probabilities, and full-profile
   completions satisfying Proposition 1 at every proposal;
4. a posterior map at every complete public `h2`, Bayesian whenever that
   history has positive probability;
5. one literal `kappa_A(h2)` or `kappa_O(h2)` from the appropriate frozen C2
   interface at every action-specific failure history;
6. the complete type-by-identity payoff and outcome distributions; and
7. proposer support contained in

```text
argmax_s G_i(s;mu),                                  (P-OPT)
```

with a nonempty maximum.

After proposer-payoff maximization, only maximizers minimizing `G_H(s;mu)`
are retained.  If proposer and H payoffs tie while allocations, identities,
type outcomes, histories, completion maps, or C2 signatures differ, the
correspondence remains.  Proposal mixing is possible only among elements with
the same maximal proposer payoff and the same tie-minimal H payoff.

For a possibly mixed proposal strategy, the payoff of player `k`, conditional
on type `theta`, is the expectation over the proposal draw,

```text
U_k^{i,theta}(alpha_i)
  = integral U_k^theta(s,A_i(s)) d sigma_i(s).        (SIGMA)
```

Consequently, proposer maximization and the H tie-break apply to each support
element, while the exported type-by-identity vector and outcome distribution
integrate those double-tied elements using `sigma_i`.  Mixing never turns two
nonmaximizing pure proposals into a maximizing lottery.

### Proposition 2 (necessity and sufficiency)

The seven conditions above are necessary and sufficient for a recognized-
proposer PBE assessment, provided `(P-OPT)` has a maximum.  They are the exact
global characterization; no generally valid scalar continuation or global
offer threshold exists.

**Proof.**  Proposition 1 is necessary and sufficient at every ballot
information set.  Frozen C2 membership is necessary and sufficient after
every failed history.  Bayes' rule supplies on-path consistency.  Conditional
on the complete continuation strategy map, (1) is the proposer's payoff from
every feasible deviation, so `(P-OPT)` plus the primitive tie-break is exactly
its sequential-rationality condition.  These conditions also construct a
complete strategy and belief assessment.  QED.

The explicit `argmax` clause is material: arbitrary off-path belief and
completion maps can make a continuum-action payoff function discontinuous.
The game supplies no compactness/continuity selection rule that would permit
the proof to replace nonattainment by a supremum.  The constructive subclasses
below establish nonempty PBEs without such an assumption.

## 6. Exact closed boundary `N=3`

When `N=3`, `q=2` and there is one weak nonproposer.  H yes always implements
the current agreement, so active-H C2 is never reached.  H follows the direct
threshold `h_theta=Y iff y>=o_theta`.  If H no, the weak voter compares current
`x_j` with the unique weak-only continuation `b=beta/2`: it votes yes iff
`x_j>=b` whenever rejection has positive ballot-belief probability; if all
believed types accept, its action is a completion.

Define

```text
b = beta/2,
A = 1-b,
C = (1-mu)(1-o_0)+mu b,
D = 1-o_1,
L = max{C,D},
U = max{A,C,D}.                                      (N3)
```

### Proposition 3 (exact proposer-payoff projection for `N=3`)

The exact recognized-proposer payoff projection is

```text
{U},       if o_0>0;
[L,U],     if o_0=0.                                 (N3-PROJ)
```

A PBE exists for every primitive vector, every `mu`, and every value in the
applicable projection.

**Necessity: deviation lower bounds.**  The proposal `y=o_0,x_j=0` gives at
least `C` under every off-path `rho` and completion: weak no gives `C`, while
weak yes replaces the high-type continuation `b` by the current weak-only
payoff one.  Pooling at `y=o_1,x_j=0` gives `D`.  Hence every PBE value is at
least `L`.

If `o_0>0`, there is also a genuine both-reject proposal
`y=0,x_j=b`.  Rejection then has probability one under every `rho`; the weak
vote is relevant, equality prescribes yes, and the proposer receives `A`.
Thus every PBE value is at least `U` when `o_0>0`.  This argument is
unavailable when `o_0=0`: at `y=0` the low type accepts, so the proposal is
separating rather than both-reject.  An off-path assessment may set `rho=0`
and complete the weak vote with no.  The deviation then yields

```text
(1-mu)A+mu b <= C,
```

and does not force `A`.

**Necessity: upper bound.**  Partition an on-support proposal, where
`rho=mu`, into the same three regions.  In a both-reject region (which exists
only when `o_0>0`), weak yes gives at most `A`, while weak no gives `b<=A`.
At a separating proposal, if `mu>0`, weak yes gives

```text
1-x_j-(1-mu)y <= A,
```

and weak no gives at most `C`; if `mu=0`, the vote is a completion and the
true payoff is at most `1-o_0=C`.  Pooling gives at most `D`.  Hence no PBE
value exceeds `U`.

**Sufficiency when `o_0=0`.**  Fix any `V in [L,U]`.  At every distinct
off-path separating proposal set `rho=0` and complete the weak vote with no.
Such a deviation gives

```text
(1-mu)(1-y-x_j)+mu b <= C <= V.
```

Every off-path pooling deviation gives at most `D<=V`.  There is no
both-reject region.  Put one of the following proposals on path with
`rho=mu`:

1. if `V<=A`, use `y=0,x_j=1-V` and weak yes;
2. if `A<V<=max{A,C}`, necessarily `C>A` and `mu<1`; use
   `y=0,x_j=(C-V)/(1-mu)<b` and weak no;
3. if `V>max{A,C}`, the interval restrictions imply
   `V=D>max{A,C}`; use pooling `y=o_1,x_j=0`.

The first proposal has `x_j>=b`, the second has `x_j<b`, and the third makes
the weak action irrelevant.  Direct substitution gives proposer payoff `V`
in each case.  These on-path actions are sequentially rational, and the
stated proposal-contingent off-path map bounds every deviation by `V`.
Literal public-measurable `kappa_O(h2)` selections complete every failed
history; no active-H continuation is reached at `N=3`.

**Sufficiency when `o_0>0`.**  The preceding upper bound is `U`.  A candidate
attaining whichever of `A`, `C`, or `D` equals `U` is, respectively,
`(y,x_j)=(0,b)`, `(o_0,0)`, or `(o_1,0)`.  Complete every distinct off-path
both-reject proposal with its required threshold response, every separating
proposal with `rho=0` and weak no, and every pooling proposal arbitrarily.
Their payoffs are bounded by `A`, `C`, and `D`, respectively.  This constructs
value `U` and proves the singleton.  QED.

### Tie-break, endpoints, and mixing signatures

For `o_0>0`, let `o_bar=(1-mu)o_0+mu o_1`.  Candidates `A` and `C` attain
`o_bar`.  If `D>max{A,C}`, only the pooling value attains `U` and the
tie-minimal H payoff is `o_1`; otherwise the tie-minimal H payoff is `o_bar`.
A tied pooling signature survives only when it also ties that H payoff, which
under `o_0<o_1` requires `mu=1`.

For `o_0=0`, define `M=max{A,C}`.  At any equilibrium value `V<=M`, a
separating `y=0` implementation gives H the lower bound `mu o_1`; the
tie-break retains only value-`V` signatures attaining that bound.  Pooling
signatures are then eliminated unless `mu=1`, when their H payoff can tie.
If `D>M`, the projection collapses to the endpoint `{D}` and its tie-minimal
implementation is pooling at `y=o_1,x_j=0`, with H payoff `o_1`.  These rules
cover `mu=0`, `mu=1`, `beta=1`, `V=L`, `V=U`, and all equality surfaces.

Proposal mixing is permitted only among support proposals that separately
attain the same `V` and the same tie-minimal H payoff.  It is not used to
average unequal pure payoffs.  For example, at
`beta=.5,o_0=0,o_1=.8,mu=.9`, both separating proposals
`(y,x_j)=(0,0)` with weak no and `(0,.675)` with weak yes give the lower
endpoint `.325` and H payoff `.72`; any mixture of those double-tied
signatures is admissible under the common on-support belief `rho=.9`.
The exact projection in this example is `[.325,.75]`, not the singleton
`{.75}`.

## 7. Constructive results for `N>=4`

### Proposition 4 (a value-one PBE for every `N>=4`)

For every admissible primitive vector, `beta`, and `mu`, there is a PBE in
which the proposer offers `y=0,X=0`, all weak nonproposers vote yes, type
`theta` H votes yes exactly when `o_theta=0`, and the current proposal passes.
The proposer receives one in every type and H receives its outside payoff.

For `N>=5`, a unilateral weak no leaves both current H-yes and H-no branches
passing, so every weak action is a completion.  For `N=4`, a weak no after H
no reaches weak-only C2; choose the admissible zero-vector C2-M-WO selection.
The voter then compares zero with zero and yes is prescribed because the
outcome is relevant.  Every H type compares `y=0` with `o_theta`.  No proposer
deviation can exceed one, and the construction already gives H its minimum
type-specific payoff.  This also supplies a complete off-path map: use all
weak yes at every proposal (and zero-vector weak-only selections for the
`N=4` toggle histories).

Hence the global PBE correspondence is nonempty for every `N>=3`, including
all boundary beliefs and `beta=1`.  Value one is an existence result, not a
selection imposed on the rest of the correspondence.

### Proposition 5 (proved `[0,1]` proposer projections)

The exact recognized-proposer payoff projection is `[0,1]` in either of the
following subclasses:

```text
(i) N>=6;
(ii) N in {4,5}, o_0>0, and beta<1.
```

For any `V in [0,1]`, put on path `y=0`, gifts totaling `X=1-V`, and all weak
yes.  Current passage gives the proposer `V` in every type.  Assign all weak
no to every distinct proposal deviation.

In subclass (i), after all weak no and any unilateral weak deviation both H
actions still fail the current ballot.  Select a class-F active-H C2 outcome
with weak vector zero and H payoff `o_theta`, and select the zero-vector
weak-only C2 outcome.  The weak actions are product-safe zero-payoff
completions; H chooses no when `(beta-1)o_theta<0` and yes at equality.  Every
off-path proposal gives the proposer zero.

In subclass (ii), select the active-H C2 element with type payoff `o_theta`.
Because `beta<1` and `o_0>0`, both H types strictly choose immediate no after
all weak no; the zero-vector weak-only selection then gives every weak player
zero.  Again every deviation gives the proposer zero.  At `V=0`, the
proposal and every deviation tie in proposer payoff and give H its outside
payoff, so the primitive tie-break retains the construction.  Feasibility
gives the selection-free upper bound one, completing the proof.

Outside these subclasses, Proposition 2 remains exact; `[0,1]` is not
asserted.

## 8. The `o_0=0` active-H continuation pathology

For `N in {4,5}`, the frozen active-H C2 interface changes discontinuously at
`o_0=0`.  Conditional on recognizing a Round-2 proposer, its payoff projection
is

```text
[D_A(nu),1],       D_A(nu)=max{1-o_1,1-nu},          (A0)
```

instead of the singleton `{1}` obtained when `o_0>0`.  Uniform recognition
and nonnegative weak payoffs imply the assessment-independent, public-belief
bound

```text
E_nu[C^A_{W_j}(h2)] >= D_A(nu(h2))/m                (A1)
```

for every weak identity `j`.  The bound collapses only at the degenerate
corner `nu=1,o_1=1`.  If an on-path separating H-yes action reveals the low
type, `nu(h2)=0`, so (A1) equals `1/m` and enters R1 as `beta/m`, exactly once.

Moreover, when `o_0=0`, type 0 compares immediate no payoff zero with a
nonnegative active-H continuation on every H-yes failure profile.  The
response-at-equality rule makes it vote yes at equality.  Therefore the
all-failure punishment used in Proposition 5(ii) cannot make the low type opt
out.  At `beta=1,o_0>0`, the analogous outside-payoff C2 selection also makes
every type vote yes at equality.  These are genuine boundary changes, not
permission to choose another C2 element or to replace (A0)--(A1) by a scalar.

Because `nu(h2)`, the recognized Round-2 identity, full allocations, and
off-path completions vary by history, this pathology enters (H-IC), (W-Y),
and proposer optimality through the literal selection maps.  No global
continuation number, minimal coalition, or universal offer threshold survives.

## 9. Pre-recognition interface, existence, and invalidation

For each Round-1 weak identity `i`, let `alpha_i` be an assessment satisfying
Proposition 2 and the proposal tie-break, including a proposal distribution
`sigma_i`.  First integrate every type-by-identity coordinate and outcome
distribution over that proposal draw as in (SIGMA).  Before uniform
recognition, for every player identity `k` and type `theta`,

```text
C1_M,k^alpha(theta|h1)
  = (1/m) sum_i U_k^{i,theta}(alpha_i),

C1_M,k^alpha(h1)
  = (1-mu)C1_M,k^alpha(0|h1)
    +mu C1_M,k^alpha(1|h1),

C1_M(h1)={the resulting full vectors and distributions over all admissible
           identity-indexed alpha=(alpha_1,...,alpha_m)}.       (C1-M)
```

The same `1/m` and `sigma_i` expectations apply to each type-conditional
distribution over PR04--PR07, inclusion, opt-out, payment destinations, full
public histories, and terminal/continuation signatures.  The average retains
every weak identity separately; it does not average weak players into a
representative weak state.  It also retains proposal mixing, `rho` maps,
complete ballot vectors, public-measurable action-specific C2 selections, and
posteriors.  Equal-posterior public histories remain distinct indices.  The
scalar proposer results in Sections 6--8 are implications of this object, not
substitutes for it.

PBE existence is proved for every admissible primitive vector: Proposition 3
covers `N=3` and Proposition 4 covers `N>=4`.  Multiplicity is generally
large.  Exact scalar projections are proved only where stated; elsewhere the
necessary-and-sufficient assessment fixed point is the result.

Any byte change to the Gate 0 bundle, either C2 interface, or the reviewed R2
batch invalidates this entire node and every descendant.  A downstream node
must consume the reviewed frozen replacement of this JSON interface.  It may
not rederive a continuation, silently select one, or apply another `beta` to
the already Round-1-dated values exported here.
