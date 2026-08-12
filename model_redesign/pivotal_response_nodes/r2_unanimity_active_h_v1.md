# Round 2 under unanimity with an active hegemon

## Status and provenance

- Node: `r2_unanimity_active_h`.
- Solution concept: Perfect Bayesian equilibrium (PBE).
- Frozen dependency: `gate0_bundle_v1.json`,
  `sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1`.
- Native payoff date: Round 2.
- Discounting inside this node: none.
- Status: candidate, pending independent read-only review.

This derivation uses only the frozen Gate 0 primitives and registries. It does
not import an equilibrium formula or classification from a historical
derivation. In particular, it does not delete weakly dominated actions, impose
a coalition size, remove gifts, or identify several locally irrelevant votes
with one joint completion.

## 1. The terminal decision problem

There are `N=m+1>=3` players: the active hegemon `H` and `m` weak states.
Weak state `i` is the recognized proposer. It is counted as voting yes. The
remaining

```text
n = m-1 = N-2 >= 1
```

weak states and `H` vote simultaneously. A proposal is

```text
s_i = (y,(x_j)_{j!=i}),
0 <= y <= y_bar,
x_j >= 0,
r_i = 1-y-sum_{j!=i}x_j >= 0.
```

Unanimity passes only if `H` and every weak nonproposer vote yes. Passage pays
`y` to `H`, `x_j` to weak nonproposer `j`, and `r_i` to the proposer. Every
failure pays zero to all weak states and `o_theta` to type `theta` of `H`.
An `H`-no additionally implements immediate opt-out; an `H`-yes followed by a
weak-caused failure does not. This opt-out distinction is part of the Gate 0
outcome signature even though the two failure branches give `H` the same
monetary payoff.

Let `nu` be the public belief before proposal recognition, and let `rho(s)` be
the weak voters' belief at the ballot following proposal `s`. Because the weak
proposer has no private information, every proposal in the support of its
strategy has `rho(s)=nu`. At a globally zero-probability proposal, PBE permits
the assessment to state any `rho(s) in [0,1]`. A deviating proposer nevertheless
evaluates its deviation using the true preproposal distribution `nu`.

## 2. Exact ballot correspondence at a fixed proposal

For weak nonproposer `j`, let `p_j in [0,1]` be its independent behavioral
probability of yes. Define

```text
P_W = product_j p_j,
h_theta in {0,1} = H type theta's yes action,
a_rho = (1-rho)h_0 + rho h_1.
```

No correlation device is used.

### Lemma 1 (hegemon response)

At every fixed proposal and weak behavioral profile,

```text
h_theta = 1{P_W=0 or y>=o_theta}.
```

Proof. If all weak nonproposers vote yes, an `H`-yes changes its payoff from
`o_theta` to `y`. Otherwise an `H`-yes ends in weak-caused failure and pays
`o_theta`, just like `H`-no. Hence the monetary difference is

```text
Delta_H(theta) = P_W (y-o_theta).
```

Changing `H`'s action changes opt-out status at every weak vote profile, so
relevance has positive probability even when `P_W=0`. The Gate 0 equality
rule then selects yes at a zero monetary difference. If `P_W>0`, it selects
yes exactly when `y>=o_theta`. There is no type mixing at either threshold.

### Lemma 2 (weak response)

For weak nonproposer `j`, let `P_-j=product_{k!=j}p_k`. Its vote is relevant
with probability `a_rho P_-j`. On this event, yes pays `x_j>=0` and no pays
zero. Thus

```text
if a_rho P_-j > 0, then p_j=1;
if a_rho P_-j = 0, any p_j in [0,1] is a local completion.
```

At a positive relevance probability, `x_j=0` still leads to yes by the
equality rule. When relevance has probability zero, no universal yes
completion is imposed.

### Proposition 1 (complete fixed-proposal ballot PBE set)

Let `Z={j:p_j=0}`. The complete independent-behavioral ballot correspondence
is exactly the union of the following two classes.

1. **Positive-product class.** `Z` is empty, so `P_W>0`. The hegemon uses the
   threshold `h_theta=1{y>=o_theta}`. If `a_rho>0`, every `p_j=1`. If
   `a_rho=0`, each `p_j` may be any number in `(0,1]` independently.
2. **Coordinated-failure class.** `|Z|>=2`. Then `P_W=0`, both types of `H`
   vote yes, and all positive components of `p` may be arbitrary in `(0,1]`.

A profile with exactly one zero component is never an equilibrium. With that
single voter held at no, every other weak action may be locally irrelevant,
but the lone no voter faces positive relevance because all other weak voters
and both types of `H` vote yes; equality or a positive offer makes it vote
yes.

Proof. Lemma 1 pins down `H`. If `P_W=0`, it makes both types vote yes. A lone
zero then violates Lemma 2; two or more zeros make every weak voter's
relevance probability zero and hence satisfy it. If `P_W>0`, Lemma 1 gives
the type thresholds. Lemma 2 forces all weak probabilities to one whenever
the posterior-weighted hegemon acceptance probability is positive, and
otherwise leaves every strictly positive probability as a completion. These
cases exhaust `[0,1]^n`.

The condition `a_rho=0` in the positive-product class occurs precisely when:

- `y<o_0` (both types of `H` vote no), for any `rho`; or
- `o_0<=y<o_1` and `rho=1` (only the off-support low type votes yes).

The coordinated-failure class exists if and only if `n>=2`, equivalently
`N>=4`. This is the sole population split needed at the ballot stage.

### Pure profiles and mixed completions

The pure ballot profiles are particularly transparent:

- all weak nonproposers vote yes and `H` follows the direct type threshold; or
- when `N>=4`, at least two weak nonproposers vote no and both types of `H`
  vote yes.

The mixed positive-product completions in Proposition 1 are substantive for
the full assessment when a zero-probability ballot belief puts probability
one on the high type. If the true preproposal belief assigns positive
probability to the low type, its proposal may pass with probability `P_W`
even though the weak voters' off-path belief makes their individual relevance
zero. Therefore these probabilities may not be quotiented out before proposal
optimality is evaluated.

## 3. Full outcome and payoff vector

For any ballot element `(p,h_0,h_1)` in Proposition 1 and each type `theta`,
the conditional terminal distribution is

```text
Pr(pass with H | theta)              = h_theta P_W,
Pr(weak-caused failure | theta)      = h_theta (1-P_W),
Pr(quota-impossible opt-out | theta) = 1-h_theta.
```

The complete type-conditional expected payoff vector is

```text
u_i(theta) = h_theta P_W r_i,
u_j(theta) = h_theta P_W x_j                  for each j!=i,
u_H(theta) = o_theta + h_theta P_W(y-o_theta).
```

The proposal-stage expected payoff of the recognized proposer and `H` are

```text
v_i(s,b;nu) = (1-nu)u_i(0) + nu u_i(1),
hbar(s,b;nu)= (1-nu)u_H(0) + nu u_H(1).
```

These formulas preserve every named weak payoff and both type-specific
hegemon payoffs. They also preserve the opt-out/inclusion distribution above;
monetarily equal failure branches are not collapsed.

## 4. Proposal optimality as an assessment-level object

A recognized-proposer continuation assessment consists of:

1. a proposal distribution `sigma_i`;
2. a ballot belief `rho_i(s)` at every proposal, equal to `nu` on the support
   of `sigma_i` and unrestricted by Bayes at a globally off-path proposal;
3. one ballot element `b_i(s)` from Proposition 1 at every proposal;
4. support proposals that maximize `v_i(s,b_i(s);nu)`; and
5. after that maximization, support only among maximizers minimizing
   `hbar(s,b_i(s);nu)`. If both quantities tie, different payment vectors,
   ballot distributions, and terminal outcomes remain in the correspondence.

This parameterization is an exact characterization of all proposal-stage
PBEs. The next two propositions give closed-form implications without
discarding the assessment-level correspondence.

## 5. The special case `N=3`

With `N=3`, there is one weak nonproposer. The coordinated-failure class is
unavailable. At an on-path proposal:

- if `y<o_0`, both types of `H` vote no; the weak yes probability can be any
  number in `(0,1]`, and the proposal fails;
- if `o_0<=y<o_1` and `nu<1`, the weak voter votes yes, the low type accepts,
  and the high type opts out;
- if `o_0<=y<o_1` and `nu=1`, the weak yes probability can be any number in
  `(0,1]`; the actual high type opts out, while the counterfactual low-type
  payoff retains that probability;
- if `y>=o_1`, both types and the weak voter vote yes.

Define

```text
G = 1-o_1,
L(nu) = (1-nu)(1-o_0).
```

`G` is the proposer payoff forced by the deviation `(y=o_1,x=0)`: with a
single weak nonproposer, its zero offer is relevant and equality forces yes.
A separating off-path proposal can instead be assigned `rho=1` and any
strictly positive weak yes probability. Its deviation payoff can be made
arbitrarily small, but not exactly zero when `nu<1` and its residual is
positive.

### Proposition 2 (recognized-proposer PBEs for `N=3`)

If `nu<1`:

1. When `G>0`, the canonical pooling proposal `(y=o_1,x=0)` is always a PBE
   proposal outcome and gives the proposer `G`.
2. A separating PBE proposal outcome exists for every value `V` satisfying

   ```text
   0<V<=L(nu),  V>=G.
   ```

   It has

   ```text
   r_i = V/(1-nu),
   o_0 <= y < o_1,
   y+r_i <= 1,
   x = 1-y-r_i,
   ```

   all weak voters yes, low-type passage, and high-type opt-out. At `V=G>0`,
   the forced pooling deviation ties the proposer but pays more to `H`, so the
   proposal tie-break selects the separating proposal. If `L(nu)<G`, this
   separating set is empty.
3. When `G=0` (equivalently `o_1=1`), the canonical pooling proposal is not a
   PBE for `nu<1`: some positive-residual separating deviation has a strictly
   positive payoff under every admissible positive-product completion. The
   separating payoff set is the nonclosed interval `(0,L(nu)]`.

The canonical pooling outcome in item 1 can coexist across assessments with
separating outcomes whose value exceeds or equals `G`. In the pooling
assessment, every off-path separating proposal is assigned `rho=1` and a
small enough positive weak yes probability to give strictly less than `G`.
In a separating assessment with `V=G`, the pooling proposal is an unavoidable
tie and the lower expected payment to `H` selects separation. This asymmetry
is a consequence of proposal-contingent off-path completions, not an
additional selection rule.

If `nu=1`:

1. when `G>0`, the canonical pooling proposal is the unique on-path monetary
   outcome and gives the proposer `G`, the other weak state zero, and the high
   type of `H` `o_1`;
2. when `G=0`, every fixed-proposal ballot equilibrium in Proposition 1 is a
   proposal-stage PBE outcome. All actual weak payoffs are zero and the actual
   high type receives `o_1=1`; proposal mixtures and counterfactual low-type
   continuations remain part of the correspondence.

For `nu<1`, nontrivial proposal mixing does not add an outcome class. A
pooling and separating proposal with the same proposer payoff give strictly
different expected payoffs to `H`, so the proposal tie-break retains only the
lower one if both are maximizers in the same assessment. Two separating
support proposals with the same proposer and `H` payoffs have the same `y`,
residual, and (because there is one recipient) transfer.

Proof. The fixed-proposal outcomes follow from Proposition 1 with `n=1`.
Pooling deviations cannot be suppressed and have maximum residual `G`.
At an off-path separating proposal with residual `r>0`, choosing `rho=1` and
`p in (0,1]` produces deviation payoff `(1-nu)pr`; for any target `V>0`, `p`
can be chosen small enough to keep this payoff below `V`. It cannot be made
zero if `nu<1`. These facts yield the necessity and constructions above.
The stated comparison of expected hegemon payoffs applies the only authorized
proposal tie-break.

## 6. The general case `N>=4`

At every feasible proposal, including every deviation, at least two weak
nonproposers can be assigned probability zero of yes. Proposition 1 then makes
both types of `H` vote yes and gives every weak voter zero relevance. This
coordination-failure completion gives the proposer zero, all weak states zero,
and type `theta` of `H` its outside payoff. Thus every proposal deviation can
be held to zero without changing the primitive action space or deleting any
gift.

Let again

```text
G=1-o_1,
L(nu)=(1-nu)(1-o_0),
M(nu)=max{G,L(nu)}.
```

### Proposition 3 (recognized-proposer PBEs for `N>=4`)

Every proposer payoff `V in [0,M(nu)]` occurs in a PBE, but this scalar range
does not replace the payoff-vector correspondence.

For `V>0`, every pure on-path outcome belongs to one of these passage classes:

1. **Separating passage** (available only if `nu<1`):

   ```text
   0<V<=L(nu),
   r_i=V/(1-nu),
   o_0<=y<o_1,
   y+r_i<=1,
   sum_{j!=i}x_j=1-y-r_i.
   ```

   Every weak nonproposer votes yes, the low type accepts, and the high type
   opts out. Conditional payoffs are `(r_i,(x_j),y)` for type zero and
   `(0,(0_j),o_1)` for type one.
2. **Pooling passage**:

   ```text
   0<V<=G,
   r_i=V,
   o_1<=y<=min{y_bar,1-V},
   sum_{j!=i}x_j=1-y-V.
   ```

   Every voter and both types of `H` vote yes. Conditional payoffs are
   `(V,(x_j),y)` for both types.

Any one such positive-payoff proposal is made a strict proposal optimum by
assigning coordinated failure to every off-support proposal. Gifts and
oversized unanimous support therefore survive whenever they are embedded in
the chosen feasible vector; no minimum coalition conclusion follows.

For `V=0`, a fixed-proposal ballot outcome is proposal-stage admissible if and
only if

```text
v_i(s,b;nu)=0
and
hbar(s,b;nu)=(1-nu)o_0+nu o_1.
```

The second equality is required by the proposal tie-break because an
off-support coordinated-failure proposal necessarily ties the proposer at
zero and pays `H` exactly its expected outside option. This zero class contains:

- every terminal-failure ballot completion;
- if `nu<1`, a separating passage outcome only when `r_i=0` and `y=o_0`;
- if `nu=1`, every separating positive-product completion, and a pooling
  passage outcome exactly when `y=o_1` and `r_i=0` (arbitrary feasible named
  gifts may consume `1-o_1`).

Proposal mixtures are possible only over support elements with the same
proposer payoff and the same minimal expected payoff to `H`. Within a positive
separating support this fixes `y`, the residual, and the total gifts but may
leave their distribution across named recipients free. The analogous result
holds within a pooling support. At zero, mixtures over different failure or
passage outcomes remain whenever both displayed equalities hold. These joint
distributions are retained rather than quotiented by player-by-player local
irrelevance.

Proof. Proposition 1 supplies coordinated failure after every proposal, so a
chosen positive payoff is strict against all deviations. The two passage
classes and their feasibility bounds follow directly from the full payoff
formula. Conversely, positive proposer payoff requires passage with positive
probability. At an on-path belief `nu<1`, any posterior-supported accepting
type makes every weak voter choose yes, so separating or pooling passage is
deterministic conditional on the accepting types; at `nu=1`, only pooling can
give the actual proposer a positive payoff. These are exactly the two listed
classes. At payoff zero, an unavoidable coordinated-failure deviation pins
down the tie-break benchmark for `H`, yielding the two displayed equalities
and the concrete subclasses.

## 7. Pre-recognition continuation interface

The object imported by Round 1 is pre-recognition and integrates the uniform
draw. A complete Round-2 assessment `alpha` selects, for every recognized weak
proposer `i`, a proposal-stage PBE element `e_i` characterized above. For weak
state `k` and type `theta`, write `u_k^i(theta;e_i)` for the full payoff formula
in Section 3. Then

```text
C_2,U^alpha(h_2)_k
  = (1/m) sum_i [(1-nu)u_k^i(0;e_i)+nu u_k^i(1;e_i)],

C_2,U^alpha(h_2)_H(theta)
  = (1/m) sum_i u_H^i(theta;e_i).
```

The interface also carries the corresponding uniform mixture of the three
terminal-outcome probabilities for each type. The assessment may be
identity-asymmetric: isomorphic proposer nodes can select different elements
of the same correspondence. Symmetry is available but is not imposed.

This averaging is the only operation performed at pre-recognition. No beta is
used in Round 2. A Round-1 predecessor must multiply the selected frozen
Round-2 payoff vector by beta exactly once where its own transition requires
that continuation.

## 8. Beliefs, existence, multiplicity, and boundaries

- **Bayes on path.** Every support proposal has ballot belief `rho=nu`.
- **Off path.** Every zero-probability proposal records an explicit `rho` and
  a full ballot element from Proposition 1. The payoff from a proposal
  deviation is still integrated using `nu`.
- **After the ballot.** The game is terminal. The public vector can reveal
  `H`'s type, but no successor belief enters a payoff or action.
- **Existence.** A PBE exists for every `N>=3`, `nu in [0,1]`, and
  `0<=o_0<o_1<=y_bar<=1`.
- **Multiplicity.** Off-path completions are generally multiple. On-path
  payoff multiplicity is exactly as described in Propositions 2 and 3.
- **`o_0=0`.** The region `y<o_0` is empty; all other formulas remain valid.
- **`o_1=1`.** `G=0`. For `N=3,nu<1`, the proposer payoff set is nonclosed at
  zero; for `N>=4`, coordinated failure restores the zero endpoint.
- **`nu=0`.** Proposition 2 applies through its `nu<1` branch; separating and
  pooling are both possible across assessments. Proposition 3 is unchanged.
- **`nu=1`.** Counterfactual low-type strategies and payoffs remain recorded
  even though proposal optimality uses only the actual high type.
- **`y_bar=o_1`.** The pooling rent interval above `o_1` disappears, but the
  canonical pooling proposal remains feasible. Separating feasibility is
  unaffected because `y<o_1<=y_bar`.
- **Equality.** `y=o_theta` makes type `theta` vote yes. A relevant weak voter
  offered zero votes yes. No additional threshold convention is used.

## 9. Claims ledger

| Claim | Method | Status |
|---|---|---|
| Exact fixed-proposal independent ballot correspondence | analytic fixed-point proof | proved |
| H threshold when all weak votes have positive probability | direct expected-payoff difference | proved |
| H yes under sure weak failure | outcome-signature relevance plus equality rule | proved |
| `N=3` recognized-proposer correspondence | analytic deviation construction and necessity | proved |
| `N>=4` recognized-proposer correspondence | analytic coordinated-failure construction and necessity | proved |
| Full type/player payoff and outcome vectors | direct terminal accounting | proved |
| Uniform pre-recognition integration | law of total expectation | proved |
| Pure-ballot enumeration and boundary checks | `verify_pivotal_response_r2_unanimity_active_h.R` | checked numerically |
| Independent formal/adversarial acceptance | not yet performed | pending |
| Rendered document layout | not attempted for this node note | pending |

## 10. Invalidation rule

Any change to the frozen Gate 0 bundle, proposal budget, outcome signature,
equality convention, simultaneous-information structure, belief discipline,
or opt-out/failure payoff reopens this node. Every Round-1 or later artifact
that imports this interface must then be invalidated and rederived from the
new content hash.
