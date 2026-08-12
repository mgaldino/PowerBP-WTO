# Round 1 under unanimity

## Status and frozen dependencies

- Node: `r1_unanimity`.
- Solution concept: Perfect Bayesian equilibrium (PBE).
- Native payoff date: Round 1.
- Gate 0 bundle:
  `sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1`.
- Frozen Round-2 batch:
  `sha256:00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a`.
- Frozen active-H unanimity continuation:
  `sha256:f3ca4ebf28827d7e18d9f3a2d07d41ffd6fe57532c9af09300f20a8ab5cecf10`.
- Status: repaired candidate, pending independent read-only rereview.
- Rejected predecessor:
  `sha256:da52b135198898948ae88f919a849c76189f27fc6fff4d3f7646c4218d0f30aa`.
- Machine-readable validated export domain: `N>=3`.
- `N=3` status: `proved_consumable_pending_independent_rereview`.

This node consumes the exact Round-2 correspondence. It does not rederive a
Round-2 proposal, ballot, belief, or payoff. It also does not choose an
element of that correspondence while checking a local Round-1 deviation.
Instead, a complete Round-1 assessment states, in advance, one literal
Round-2 element after every full failed vote vector. This is the selection
that every current voter anticipates.

No result from a historical equilibrium classification is used below.

## 1. State, proposal, and simultaneous ballot

There are `N=m+1>=3` players. The active hegemon is `H`; the other `m`
players are weak states. At full public history `h1`, the public belief is

```text
mu = Pr(theta=1 | h1).
```

One weak state `i` is recognized uniformly and independently of the type and
history. It proposes

```text
s_i = (y,(x_j)_{j in J_i}),
0 <= y <= y_bar,
x_j >= 0,
r_i = 1-y-sum_j x_j >= 0,
```

where `J_i` contains the `n=N-2` weak nonproposers. The proposer is counted
yes. All voters in `J_i` and `H` then vote simultaneously. No voter observes
another current vote. The complete vector becomes public only after the
ballot closes.

Let

```text
w in {0,1}^J
```

denote the full vector of weak nonproposer votes, with one meaning yes, and
let `bold1` denote the all-yes vector. If voter `j` chooses yes independently
with probability `p_j`, then

```text
Q_p(w) = product_j p_j^w_j (1-p_j)^(1-w_j).
```

There are three action consequences.

1. `H=Y,w=bold1`: the current agreement passes. The payoff vector is
   `(r_i,(x_j),y)` in Round-1 units.
2. `H=Y,w!=bold1`: the ballot fails, `H` remains active, and the complete
   vector reaches an active-H unanimity Round-2 continuation.
3. `H=N`: `H` opts out immediately and irreversibly. It receives `o_theta`
   now, every weak state receives zero, and no continuation is reached.

In particular, a no vote by `H` is not a delayed Round-2 branch.

## 2. The literal continuation mapping

For each failed vector following an `H` yes, define the full public history

```text
h2^Y(w) = (h1,i,s_i,H=Y,w,failed ballot),  w!=bold1.
```

The Round-1 assessment contains a single map

```text
kappa_i : public h2 -> one full element of C2,U(h2;nu(h2)).
```

At the displayed history this map returns one exact object

```text
kappa_i(h2^Y(w)) = (
  nu_w,
  alpha_w,
  type/player continuation payoffs c_k,w^theta,
  type-conditional outcome distributions D_w^theta,
  all internal C2 strategies and beliefs
)
```

from `pre_recognition_C2_correspondence` in the frozen
`r2_unanimity_active_h_v1.json`, evaluated at that history's recorded
posterior. The value
`c_k,w^theta` remains in native Round-2 units. It is multiplied by `beta`
once, and only once, when this Round-1 node evaluates the failure branch.
The probabilities inside `D_w^theta` are not discounted.

Different vectors with the same posterior remain different histories. The
assessment may select different continuation elements at them. Conversely,
two such selections may be outcome-equivalent, but that must be established
from their beliefs, strategies, type/player payoffs, and outcome
distributions. A raw vector by itself is not a payoff consequence.

The map is public-history measurable and type-blind: it cannot take `theta`
as an argument. A single returned element contains both type coordinates,
all player identities, the internal strategy and belief kernels, and both
terminal-outcome kernels. In particular, it is invalid to obtain
`c_H,w^0` from one C2 element and `c_H,w^1` (or any weak coordinate) from
another. The payoff and outcome coordinates below are projections of this
one full element; they are not direct selections from the scalar
recognized-proposer payoff ranges reported inside the frozen C2 document.

This mapping is not a new equilibrium-selection rule. It is the ordinary
completion of an assessment at all continuation histories when the frozen
continuation is set-valued.

Two selected continuations count as outcome-equivalent only if their public
posterior, internal strategies and beliefs, both-type all-player payoff
vectors, and both-type terminal-outcome kernels agree. A common node label,
passage status, or scalar payoff does not establish equivalence.

## 3. Beliefs and Bayes consistency

Let `rho_i(s)` be the weak voters' belief at the ballot after proposal `s`.
Because a weak proposer does not observe `theta`, every proposal in the
support of its strategy satisfies

```text
rho_i(s)=mu.
```

At a globally off-path proposal, `rho_i(s)` is a stated assessment component.

Suppose a proposal belongs to the support of the type-independent proposal
measure `sigma_i`, `Q_p(w)>0`, and

```text
d = (1-mu)h_0 + mu h_1 > 0,
```

where `h_theta` is type `theta`'s `H`-yes action. Then a reached failed
history satisfies Bayes' rule:

```text
nu_w = mu h_1 / [(1-mu)h_0 + mu h_1].
```

The weak-vector probability cancels because the weak strategies are
type-independent. Thus all positive-probability failed vectors after the
same proposal and `H=Y` have the same posterior, although they may retain
different `kappa_i(h2^Y(w))` selections because the public histories differ.

The formula has three distinct implications which must not be collapsed:

```text
h=(1,1)  -> nu_w=mu,
h=(1,0)  -> nu_w=0,
h=(0,1)  -> nu_w=1,
```

whenever the relevant conditioning event has positive probability. In
particular, assigning `nu_w=mu` after a separating `H=Y` event violates
Bayes' rule. The posterior in this calculation, the posterior field of
`kappa_i(h2)`, its frozen-C2 membership index, and the payoff/outcome
projections must all be the same number.

If the proposal, the `H=Y` event, or the vector has zero equilibrium
probability, its successor belief is off path and must be stated explicitly.
Both type-contingent strategy and payoff vectors remain recorded when the
public belief is zero or one.

A current weak voter evaluates a deviation under its current belief `rho`.
It anticipates the strategies contained in the action-specific
`kappa_i(h2)`, and
therefore uses their type-conditional payoff vectors. A recognized proposer
evaluates a proposal deviation under the true preproposal belief `mu`, not an
off-path ballot belief assigned after that deviation.

## 4. Payoff consequences at a fixed proposal

Conditional on type `theta`, define the payoff under `H=Y` by

```text
G_i^theta(w) = r_i                         if w=bold1,
               beta c_i,w^theta            if w!=bold1;

G_j^theta(w) = x_j                         if w=bold1,
               beta c_j,w^theta            if w!=bold1;

G_H^theta(w) = y                           if w=bold1,
               beta c_H,w^theta            if w!=bold1.
```

Under `H=N`, every weak payoff is zero and `H` receives `o_theta`. These
definitions expose every payoff date. There is no `beta` inside `c`, none on
current passage, and none on immediate opt-out.

## 5. Hegemon's exact ballot incentive

### Lemma 1 (full-vector `H` response)

At a fixed proposal and weak behavioral profile, type `theta`'s expected
payoff difference between yes and no is

```text
Delta_H(theta)
  = Q_p(bold1)(y-o_theta)
    + sum_{w!=bold1} Q_p(w)(beta c_H,w^theta-o_theta).
```

Its unique prescribed action is

```text
h_theta = 1  if Delta_H(theta)>=0,
h_theta = 0  if Delta_H(theta)<0.
```

Proof. Under yes, the all-yes vector implements the current payment `y`, and
every other vector imports its own discounted continuation payoff. Under no,
every vector gives the immediate payoff `o_theta`. Subtracting and averaging
gives the displayed expression. The two actions always differ in inclusion,
immediate opt-out, or active continuation status. The comparison is therefore
relevant with probability one; equality selects yes and excludes mixing. QED.

### Corollary 1 (the direct cutoff is local to sure passage)

If `Q_p(bold1)=1`, Lemma 1 reduces to

```text
h_theta = 1{y>=o_theta}.
```

If any failure vector has positive probability, this reduction is generally
false. For example, take `o_0=0.2`, `o_1=0.6`, `beta=0.9`, `y=0.1`, and a
sure weak failure. A valid Round-2 pooling element can pay each type of `H`
`0.6`. The low type's difference is

```text
0.9(0.6)-0.2=0.34>0,
```

so it votes yes even though `y<o_0`; the high type's difference is
`0.54-0.60<0`, so it opts out. This is a fixed-proposal ballot implication,
not a claim that this proposal is optimal for the recognized proposer.

If `o_0=0`, every payoff under `H=Y` is nonnegative. Lemma 1 then makes type
zero vote yes at every proposal, with equality resolved in favor of yes.

## 6. Every weak voter's exact ballot incentive

Fix weak voter `j`. For an action `a in {0,1}` and other-voter vector
`w_-j`, define its payoff conditional on `H=Y` by

```text
g_j^theta(a,w_-j)
  = x_j                                  if (a,w_-j)=bold1,
    beta c_j,(a,w_-j)^theta              otherwise.
```

Let `lambda_0(rho)=1-rho` and `lambda_1(rho)=rho`. Voter `j`'s expected
payoff difference is

```text
Delta_j
  = sum_theta lambda_theta(rho) h_theta
      sum_w_-j Q_p,-j(w_-j)
        [g_j^theta(1,w_-j)-g_j^theta(0,w_-j)].
```

The terms with `H=N` are zero because both weak actions end at the same
immediate opt-out outcome.

Let `R_j` be the probability, under the same belief and other-player
strategies, that `H=Y` and the two action-specific outcome signatures differ.
The signature includes current implementation or the selected continuation's
beliefs, strategies, type/player payoffs, and outcome distributions.

### Lemma 2 (full-vector weak response)

The exact response is

```text
if R_j>0 and Delta_j>=0: p_j=1;
if R_j>0 and Delta_j< 0: p_j=0;
if R_j=0:                 p_j may be any number in [0,1].
```

Proof. The displayed `Delta_j` enumerates both types and every vector of the
other simultaneous votes. If relevance has positive probability, the frozen
equality convention selects yes at a tie; otherwise the strict payoff sign
selects the corresponding action. If relevance is zero, the two induced
signatures, including payoffs, agree on the assessment support, so the
expected difference is zero and either action is a completion. QED.

Two important consequences follow.

1. When all other weak voters choose yes and `H=Y`, voter `j` compares current
   `x_j` with its discounted continuation payoff after the single revealed no.
2. When another weak no already guarantees current failure, `j` may still be
   relevant: its two votes reveal different full histories and can induce two
   different `kappa_i(h2)` selections. Hence an unchanged quota outcome does not
   remove the continuation term.

For example, if both actions fail but their selected native continuation
payoffs to `j` are `0.4` after yes and `0.1` after no, the contribution is
`beta(0.4-0.1)>0`. Reversing the two selections reverses the sign. This is why
the Round-1 ballot cannot inherit the terminal Round-2 weak response formula.

## 7. Exact fixed-proposal characterization

For every feasible proposal, define a complete ballot element

```text
A_i(s) = (
  rho_i(s),
  h_0,h_1,
  (p_j)_{j in J_i},
  {(nu_w,kappa_i(h2^Y(w))):w!=bold1}
).
```

### Proposition 1 (necessary and sufficient fixed-proposal fixed point)

`A_i(s)` is sequentially rational at every current ballot information set and
every reached continuation if and only if all four conditions hold:

1. each `kappa_i(h2^Y(w))` is a literal member of the frozen
   `C2,U(h2^Y(w);nu_w)` correspondence at its recorded posterior;
2. every positive-probability failed history satisfies the Bayes formula in
   Section 3;
3. both type actions satisfy Lemma 1; and
4. every weak behavioral probability satisfies Lemma 2 over the complete
   vector space.

Proof. Necessity follows directly from continuation membership, Bayes
consistency, and one-shot deviations at each simultaneous ballot information
set. For sufficiency, the selected `kappa_i(h2)` is already a complete PBE of every
reached Round-2 continuation. Lemmas 1 and 2 eliminate every current ballot
deviation, and the belief conditions supply consistency wherever Bayes
applies. There are no other actions between the current proposal and the
terminal outcome or imported continuation. QED.

This proposition is a closed assessment-level characterization even though it
is not a scalar formula. At fixed `N` and proposal there are
`2^(N-2)-1` failed-vector slots, two current `H` actions, and `N-2`
independent current weak behavioral probabilities. Each slot nevertheless
contains a complete frozen C2 assessment element, not a scalar or a
finite-dimensional replacement for it.

### Population boundary

When `N=3`, there is one weak nonproposer. A single no changes current passage
to continuation, so its action is generally relevant. When `N>=4`, two sure
no votes make current passage impossible after either voter's unilateral
switch. Nevertheless, their actions have zero relevance only if the two
action-specific continuation elements are outcome-equivalent. The population
count alone does not prove that equivalence.

## 8. Proposal optimality and the full proposer assessment

A recognized-proposer assessment contains:

1. a Borel probability measure `sigma_i` on the feasible proposal set;
2. one complete `A_i(s)` satisfying Proposition 1 at every feasible proposal,
   including every deviation; and
3. the resulting full type/player payoff and outcome kernels.

The maps `rho_i(s)`, `h_i,theta(s)`, `p_i,j(s)`, and all current payoff and
outcome kernels are Borel measurable. The continuation selector
`kappa_i(h2)` is measurable in the public history and type-blind. These are
parts of one assessment; payoff coordinates, posterior coordinates, and
outcomes cannot be assembled from different proposal-contingent selections.

For each proposal-assessment pair, define the type-conditional payoffs

```text
U_i^theta
  = sum_w Q_p(w) h_theta
      [1{w=bold1}r_i + 1{w!=bold1}beta c_i,w^theta],

U_j^theta
  = sum_w Q_p(w) h_theta
      [1{w=bold1}x_j + 1{w!=bold1}beta c_j,w^theta],

U_H^theta
  = (1-h_theta)o_theta
    + h_theta[
        Q_p(bold1)y
        + sum_{w!=bold1}Q_p(w)beta c_H,w^theta
      ].
```

The recognized proposer's objective and the subsequent tie-break quantity are

```text
V_i(s,A;mu)    = (1-mu)U_i^0 + mu U_i^1,
Hbar(s,A;mu)   = (1-mu)U_H^0 + mu U_H^1.
```

Every support proposal must maximize `V_i` against every feasible proposal
under that proposal's preassigned assessment element. Among all proposer
maximizers, support proposals must minimize `Hbar`. If both quantities tie,
different weak payment vectors, continuation selections, beliefs, and outcome
distributions remain in the correspondence. Proposal mixing is possible only
among such double ties.

### Proposition 2 (necessary and sufficient recognized-proposer PBE)

A complete proposer assessment is a PBE if and only if:

1. every proposal-indexed ballot element satisfies Proposition 1;
2. proposal and successor beliefs satisfy Section 3; and
3. the proposal support satisfies maximization and the stated tie-break.

Proof. Proposition 1 closes all ballot and Round-2 deviations. Condition 3 is
exactly sequential rationality at the remaining Round-1 proposal node. These
conditions are therefore sufficient. Any PBE must specify behavior and beliefs
after every proposal, must be sequentially rational at every such ballot, and
must make the recognized proposer's support optimal, so they are necessary.
QED.

The proposition also gives the exact existence test: the PBE correspondence
is nonempty precisely when this proposal-indexed fixed point has a nonempty
maximizer set. Sections 9.4 and 9.5 give attained constructions for `N>=4`
and `N=3`, respectively. The `N=3` construction handles the frozen C2
nonclosed boundary without adding its missing zero endpoint.

## 9. Constructive and diagnostic subclasses

These subclasses are consequences of Propositions 1 and 2. None replaces the
full assessment.

### 9.1 Secured current passage for both types

Suppose every weak nonproposer votes yes and `y>=o_1`. Lemma 1 then gives
`h_0=h_1=1`. Voter `j`'s current yes implements `x_j`; its no reaches the
single-no continuation. Its condition is

```text
sum_theta lambda_theta(rho)
  [x_j-beta c_j,w(j=0,others=1)^theta] >= 0.
```

If every voter condition holds, the ballot fixed point implements a current
agreement for both types. It is an on-path proposer PBE only if the proposal
also satisfies global proposal optimality and the tie-break.

### 9.2 Secured current passage for the low type only

Suppose `rho<1`, all weak nonproposers vote yes, and

```text
o_0<=y<o_1.
```

Then `h_0=1,h_1=0`. Each weak condition reduces to

```text
(1-rho)
  [x_j-beta c_j,w(j=0,others=1)^0] >= 0.
```

The low type is included and the high type opts out immediately. Again,
proposal optimality is a separate necessary condition.

### 9.3 Flat-continuation failure ballot

Let `N>=4` and let at least two weak voters choose no with probability one.
Suppose the assessment assigns outcome-equivalent C2 elements across every
failed history connected by one weak voter's switch on the support of the
other votes. Every such weak action then has zero relevance. Passage has
probability zero, and Lemma 1 becomes

```text
h_theta=1
  iff beta sum_w Q_p(w)c_H,w^theta >= o_theta.
```

This supplies a constructive ballot completion that may retain `H` for
continuation even at a current payment below its outside option. It becomes a
proposer-stage PBE only if its proposer value defeats every proposal deviation
and then satisfies the tie-break.

### Proposition 3 (universal existence and attainment for `N>=4`)

For every `N>=4`, every `mu in [0,1]`, every `beta in (0,1]`, and every
admissible pair of outside options, the Round-1 unanimity PBE correspondence is
nonempty.

Proof. At every proposal set every weak nonproposer to no. Because there are
at least two such voters, a unilateral switch by any one of them still fails.
Set

```text
h_theta = 1{beta o_theta >= o_theta}.
```

The continuation selector is constructed only after its public posterior is
fixed. At every positive-probability failed history after `H=Y`, compute

```text
nu(h2)=mu h_1/[(1-mu)h_0+mu h_1]
```

and select from the frozen pre-recognition `C2,U(h2;nu(h2))`
correspondence the canonical coordinated-failure element: after every R2
proposal use the deterministic all-no weak completion, let both R2 H types
choose yes, and choose a fixed feasible R2 proposal at each recognition node.
This explicit element exists for `N>=4`, is measurable in its sole varying
belief coordinate `nu`, pays
every weak state zero, and records both H coordinates `c_H^theta=o_theta`.
At globally off-path failed histories, state a posterior and choose the same
class from the C2 correspondence at that stated posterior. Across histories
connected by one weak switch after a common proposal, choose elements with
the same posterior and outcome-equivalent strategy, belief, both-type payoff,
and terminal-outcome kernels. This defines one public-history-measurable,
type-blind `kappa_i`, not one selection per private type.

The Bayes cases are explicit. If `beta=1`, then `h=(1,1)` and every reached
failure has posterior `mu`. If `beta<1` and `o_0=0`, then `h=(1,0)` and every
reached `H=Y` failure has posterior zero—not `mu`. If `beta<1` and both
outside options are positive, `H=Y` failures are off path.

Passage is impossible. Lemma 1 therefore gives

```text
h_theta=1 iff beta o_theta>=o_theta.
```

Thus `H` votes yes only when `beta=1` or `o_theta=0`; in either case its
payoff is exactly `o_theta`. Otherwise it chooses immediate opt-out and again
gets `o_theta`. Every feasible proposal consequently gives the proposer zero
and gives `H` its expected outside payoff. Assign this same completion after
every proposal. All proposals tie in the proposer objective, and they also tie
under the frozen H-payoff rule. Any feasible support proposal therefore
satisfies Proposition 2. The construction is an actual assessment element,
not a limit, so nonemptiness is attained. QED.

### Proposition 4 (universal existence and attainment for `N=3`)

For `N=3`, every admissible `mu`, `beta`, `o_0`, and `o_1` admits an attained
Round-1 unanimity PBE.

Proof. There is one weak nonproposer. Write

```text
G=1-o_1,  D=1-o_0.
```

We first define three literal frozen C2 elements used below.

1. If `G>0`, let `c_G=G/2`. For every posterior `nu`, let
   `kappa^G_nu` be the symmetric pre-recognition C2 element in which each R2
   recognized proposer offers `y_2=o_1`, pays zero to the other weak state,
   and retains `G`. The frozen N=3 C2 theorem makes this an attained pooling
   PBE for every `nu`. Each weak identity has both type-conditional
   pre-recognition payoff `c_G`, while both H coordinates equal `o_1`.
2. If `G=0`, let `c_0=D/4`. At posterior zero, let `kappa^0_0` symmetrically
   assign each R2 recognized proposer the separating proposal

   ```text
   y_2=o_0+D/2,  x_2=0,  r_2=D/2.
   ```

   This is an attained member of the frozen interval `(0,D]`. Each weak
   identity's low-type pre-recognition payoff is `c_0`, and H's low
   coordinate is `o_0+D/2`.
3. Still when `G=0`, let `kappa^0_1` be the posterior-one C2 element with
   `y_2=1` and all weak payments zero. It gives both weak identities zero in
   both type coordinates and both H coordinates one.

All three are complete public-history-indexed, type-blind elements containing
both type coordinates. We now cover the primitive domain.

**Case 1: `G>0` and `beta<1`.** On path propose

```text
(y,x)=(o_1,beta c_G).
```

Both H types and the weak voter choose yes. A weak no has posterior `mu` and
selects `kappa^G_mu`, so the voter is paid `beta c_G` under both actions and
yes is selected at equality. The proposer obtains

```text
V=G-beta c_G=G(1-beta/2)>0.
```

After every off-path proposal set `rho=1`, choose weak no, and select
`kappa^G_1` after `H=Y`. High H strictly opts out because
`beta o_1<o_1`; hence the weak no has zero relevance. Low H may choose either
best response, but a deviation pays the proposer at most

```text
(1-mu)beta c_G <= beta G/2 < G(1-beta/2)=V.
```

Thus the on-path proposal is a strict optimum.

**Case 2: `G>0` and `beta=1`.** Define

```text
P=c_G,  R=D-c_G,  S=(1-mu)R.
```

Use pooling `(y,x)=(o_1,c_G)` when `P>S`; use separation
`(y,x)=(o_0,c_G)` when `S>=P`. The weak voter is indifferent between its
current payment and `kappa^G_mu` under pooling or `kappa^G_0` after the
low-type separating yes, and therefore chooses yes.

At every off-path proposal set `rho=1` and select `kappa^G_1` after a weak
no. If `x<c_G`, assign weak no. Both H types then choose yes into the
continuation, and the deviation gives the proposer exactly `c_G=P`. If
`x>=c_G`, assign weak yes. A pooling deviation has residual at most
`1-o_1-c_G=P`; a separating deviation has expected residual at most
`(1-mu)(1-o_0-c_G)=S`; all other deviations yield zero. Thus no deviation
exceeds `max{P,S}`. When `P=S`, separation pays H
`(1-mu)o_0+mu o_1<o_1` whenever `mu<1`, so the authorized proposer tie-break
selects it. At `mu=1`, `S=0<P`. This closes the equality boundary.

**Case 3: `G=0`, `mu<1`, and `beta<1`.** On path propose

```text
(y,x)=(o_0,beta c_0).
```

Low H and the weak voter choose yes; high H opts out. A weak no following
low H yes has Bayes posterior zero and selects `kappa^0_0`, so the voter is
indifferent and yes is selected. The proposer obtains

```text
V=(1-mu)(D-beta c_0)>0.
```

After every off-path proposal set `rho=1`, assign weak no, and select
`kappa^0_1`. High H strictly opts out because `beta<1`; the weak vote has
zero relevance. Any low-type continuation gives the proposer zero under
`kappa^0_1`, so every deviation pays zero.

**Case 4: `G=0`, `mu<1`, and `beta=1`.** On path propose
`(y,x)=(o_0,c_0)`, use `kappa^0_0` after a weak no, and obtain

```text
V=(1-mu)(D-c_0)>0.
```

At every off-path proposal with `y<1`, set `rho=1`, select `kappa^0_1`, and
assign a measurable probability `p(s)>0` satisfying, whenever the relevant
denominator is nonzero,

```text
p(s) <= 1/2,
p(s) <= D/[2(1-y)],
p(s) <= (D-c_0)/[2r(s)].
```

The first two inequalities make low H accept and high H reject; because the
weak ballot belief assigns probability one to high H, its relevance is zero
and this positive `p(s)` is a valid completion. The last inequality bounds
the true-prior deviation payoff by `V/2`. At `y=1`, feasibility forces zero
weak residual. Hence the on-path proposal is a strict optimum. The displayed
minimum of continuous positive functions (with a term omitted when its
denominator is zero) is Borel measurable.

**Case 5: `G=0` and `mu=1`.** Propose `(y,x)=(1,0)` and assign all yes. It
passes with zero weak payoff and gives H one. If `beta<1`, complete every
off-path proposal with `rho=1`, weak no, and `kappa^0_1`; high H then opts
out. If `beta=1` and `y<1`, choose any strictly positive weak-yes probability,
so high H opts out and the weak action has zero relevance; at `y=1`, choose
weak yes, and feasibility forces zero proposer residual. Therefore every
proposer payoff is zero and every supported-type H payoff is one. The proposal
and H-payoff tie conventions are satisfied for every `beta`.

The cases are exhaustive. Crucially, when `G=0` the construction never uses
the unattained zero endpoint of the posterior-below-one C2 correspondence:
it uses the positive attained `kappa^0_0` at every reached separating weak-no
history, and uses `kappa^0_1` only after globally off-path proposals. QED.

## 10. Gifts, mixing, and multiplicity

No coalition size is imposed. A positive named payment is feasible even when
its recipient is not needed to change passage. Deleting that payment creates
a new proposal information set with its own belief, ballot fixed point, and
continuation mapping; it cannot be assumed to inherit the original proposal's
completion. Hence no zero-gift conclusion follows from proposal optimality
without an additional proof.

The exact mixing possibilities are:

- `H` never mixes because its comparison is always relevant and equality
  selects yes;
- a weak voter may mix only when `R_j=0`;
- imported C2 elements retain all internal mixing permitted by the frozen
  interface; and
- the recognized proposer may mix only across elements tying in both `V_i`
  and `Hbar`.

Identity symmetry is not imposed. Isomorphic recognized-proposer nodes may
select different PBE elements.

## 11. Validated pre-recognition Round-1 interface (`N>=3`)

A complete Round-1 assessment `alpha` selects one recognized-proposer PBE
element

```text
e_i=(sigma_i,rho_i,h_i,p_i,kappa_i)
```

from Proposition 2 for every `i=1,...,m`. Selections may be asymmetric by
identity. For every player identity `k` and type coordinate `theta`, first
integrate over the proposal measure actually used by recognized proposer `i`:

```text
E_sigma_i[U_k^i(theta;e_i)]
  = integral U_k^i(theta;s,e_i) sigma_i(ds).
```

Only then integrate recognition. The full type-by-identity interface is

```text
C_1,U^alpha(h1)_{W_k}(theta)
  = (1/m) sum_i E_sigma_i[U_{W_k}^i(theta;e_i)]
```

for weak state `k`, and

```text
C_1,U^alpha(h1)_H(theta)
  = (1/m) sum_i E_sigma_i[U_H^i(theta;e_i)].
```

The ex-ante weak payoff is a separate final projection:

```text
V_{W_k,U}^alpha(h1;mu)
  = (1-mu)C_1,U^alpha(h1)_{W_k}(0)
    + mu C_1,U^alpha(h1)_{W_k}(1).
```

It is not folded into the C1 type coordinates. A cross-weak average may be
reported descriptively, but it does not replace the vector
`(V_{W_k,U}^alpha)_k` for collective entry. For each `theta`, the same
`sigma_i`, recognition weights, and `alpha` are applied to current passage,
immediate opt-out, payments, beliefs, and every type-conditional terminal
distribution imported through `kappa_i`. Equal values of `mu` at different
`h1` do not force a common selection.

This repaired export covers `N>=3`, including the attained N=3 construction
in Proposition 4. Downstream entry and institutional comparison may consume
it only after independent rereview accepts this exact candidate hash.

## 12. Selection-free bounds

Every weak payoff is nonnegative. Under current passage, total weak payoff is
`1-y<=1`; under continuation, the frozen type-conditional total is at most one
and `beta<=1`; under `H` no it is zero. Therefore, type by type and ex ante,

```text
0 <= U_k <= 1,
0 <= sum_k U_k <= 1.
```

At every reached ballot, type `theta` of `H` can choose immediate opt-out.
Sequential rationality and the unit upper bound therefore imply

```text
o_theta <= C_1,U,H(theta) <= 1.
```

These bounds do not select an assessment and cannot replace the payoff
correspondence.

### The `N=3` nonclosed endpoint is preserved, not filled

When `o_1=1` and `nu<1`, the frozen N=3 C2 proposer-value set remains
`(0,L(nu)]`: zero is an unattained infimum. Proposition 4 does not optimize
over its closure. It chooses the interior attained value `D/2` at posterior
zero, which yields `c_0=D/4` to each weak identity before recognition. At
posterior one, the separate frozen `y_2=1` element is itself attained. Thus
the R1 existence proof closes while the C2 endpoint remains nonclosed.

## 13. Survival findings for historical outcome motifs

The following statements are diagnostic only.

- If the historical label `P` denotes a both-type current agreement, its
  outcome motif survives conditionally through Section 9.1. No historical
  `P` formula is imported.
- If the historical label `L` denotes low-type current passage followed by
  high-type opt-out, its outcome motif survives conditionally through Section
  9.2. No historical `L` formula is imported.
- If the historical label `R` denotes deliberate failure followed by an
  active-H continuation, its outcome motif survives conditionally only when
  the full failed-vector mapping satisfies Propositions 1 and 2, as in
  Section 9.3. Immediate `H` opt-out is not this continuation motif.
- A theorem reducing every current PBE to three scalar labels does not survive.
  The exact object also retains immediate opt-out histories, vector-specific
  C2 selections, gifts, zero-relevance completions, double-tied proposal
  mixtures, beliefs, and full outcome distributions. Enlarging three labels
  until they contain all these objects would merely rename, not reduce, the
  assessment-level correspondence.

No historical formula or rejected-history argument is used to obtain these
findings.

## 14. Claims ledger

| Claim | Method | Status |
|---|---|---|
| Complete action-specific C2 import | direct frozen-interface construction | proved |
| Full-vector H incentive | enumeration of every weak vector | proved |
| Full-vector weak incentive | enumeration of both types and every other-vote vector | proved |
| Fixed-proposal fixed-point characterization | necessity and sufficiency proof | proved |
| Proposal-stage PBE characterization | one-shot proposal deviation proof | proved |
| Bayes update and off-path classification | direct probability calculation | proved |
| Exactly-one discount and immediate opt-out dating | branchwise payoff ledger | proved |
| Pre-recognition `E_sigma`, recognition integration, and separate `mu` projection for `N>=3` | law of iterated expectations | proved |
| Selection-free weak and H bounds | terminal accounting and H deviation option | proved |
| Conditional survival of three outcome motifs | constructive subclasses | proved |
| Global three-label reduction | counter-scope from exact correspondence | rejected |
| Universal existence and attainment for `N>=4` | Bayes-aligned coordinated-failure construction at every proposal | proved |
| Universal existence and attainment for `N=3` | exhaustive attained construction preserving the nonclosed C2 endpoint | proved |
| Validated downstream export domain | explicit machine gate | `N>=3` |
| Full-vector enumeration, Bayes/membership negatives, map/measurability export, and mutation guards | node-specific R verifier, 37/37 PASS | checked numerically |
| Independent formal/adversarial acceptance | not yet performed | pending |
| Rendered layout | not attempted | pending |

## 15. Invalidation

Any byte change to the Gate 0 bundle, the frozen Round-2 batch, or the C2-U
interface invalidates this candidate. The same is true of any change to the
simultaneous information structure, full-vector publication, proposal budget,
immediate opt-out, payoff dates, Bayes discipline, or either frozen tie
convention. Every later entry or comparison node consuming this interface must
then be reopened.
