# Round 2, majority, active H: repaired terminal derivation

**State.** `r2_majority_active_h`  
**Dependency.** Frozen Gate 0 bundle
`sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1`  
**Solution concept.** PBE, with the Gate 0 response-at-equality rule  
**Payoff date.** Round 2 native units; no `beta` occurs here  
**Status.** Repaired candidate pending independent read-only rereview

This note rederives the terminal majority node from the frozen primitives. It
does not assume a minimal coalition, zero gifts, or common ballot completions
across proposals. The repair separates the public posterior before proposal,
`nu`, from the belief at the ballot following proposal `s`, `rho(s)`.

## 1. State, beliefs, and notation

There are `N=m+1>=3` states: the hegemon `H` and `m` weak states. Weak state
`i` is recognized uniformly to propose. The majority quota remains

```text
q = floor(N/2)+1
```

even after an `H` no. The proposer is counted as yes. The simultaneous ballot
therefore contains `H` and `n=N-2` weak nonproposers. A feasible proposal is

```text
s_i=(y,(x_j)_{j!=i}),
0<=y<=y_bar,
x_j>=0,
X=sum_{j!=i}x_j<=1-y,
r_i=1-y-X.
```

If passage includes `H`, the proposer receives `r_i`. If `H` votes no and the
weak votes alone meet `q`, `H` opts out, `y` is reabsorbed, and the proposer
receives `1-X`. A named `x_j` is paid after passage even if `j` voted no.

Let `nu` be the true public posterior at the full Round-2 history before the
proposal. Recognition and the proposer strategy are type-independent. Hence

```text
rho(s)=nu
```

at every proposal in the proposer strategy's support. At a globally off-path
proposal, PBE permits any explicitly stated `rho(s) in [0,1]`. This freedom
changes the voters' best responses; it does not change Nature's distribution.
The recognized proposer evaluates a deviation under `nu`, not under `rho(s)`.

For weak voting probabilities `p=(p_j)`, define

```text
a=q-3,                     b=q-2=a+1,
K=sum_j Y_j,               K_-j=sum_{k!=j}Y_k,
A(p)=Pr_p(K>=b),           B(p)=Pr_p(K>=b+1),
S(p)=#{j:p_j=1},           L(p)=#{j:p_j>0}.
```

All behavioral randomizations are independent conditional on the ballot
information set. Impossible count events have probability zero.

## 2. Terminal transition and complete payoff map

The four Gate 0 branches are:

| H ballot | Weak-nonproposer count | Outcome | Payoffs |
|---|---:|---|---|
| yes | `K>=b` | PR11, pass with H | `H:y`, proposer `r_i`, named `j:x_j` |
| yes | `K<=a` | PR12, active-H failure | `H:o_theta`, all weak zero |
| no | `K>=b+1` | PR13, weak-only pass after opt-out | `H:o_theta`, proposer `1-X`, named `j:x_j` |
| no | `K<=b` | PR14, failure after opt-out | `H:o_theta`, all weak zero |

For any fixed-proposal ballot profile and each type `theta`, write `h_theta`
for `H`'s yes action. The exact terminal probabilities are

```text
Pr(PR11|theta)=h_theta A,
Pr(PR12|theta)=h_theta(1-A),
Pr(PR13|theta)=(1-h_theta)B,
Pr(PR14|theta)=(1-h_theta)(1-B).
```

Consequently,

```text
u_H(theta)=o_theta+h_theta A(y-o_theta),
u_i(theta)=h_theta A r_i+(1-h_theta)B(1-X),
u_j(theta)=[h_theta A+(1-h_theta)B]x_j.
```

These formulas retain type, player identity, inclusion, opt-out, terminal
branch, and implemented-payment coordinates.

## 3. The ballot game at fixed `(s,rho)`

This section is deliberately solved before proposal optimality.

### Lemma 1: H's response

If `H` votes yes, agreement includes it exactly when `K>=b`; otherwise it
receives `o_theta`. A no always gives `o_theta`. Thus

```text
Delta_H(theta)=A(p)(y-o_theta).
```

Changing H's ballot changes at least opt-out status at every weak vote profile,
so its relevance probability is one even when `A=0`. The Gate 0 equality rule
therefore gives the unique prescribed action

```text
h_theta=1{A=0 or y>=o_theta}.
```

In particular, `H` votes yes at `y=o_theta` and both types vote yes when
`A=0`.

### Lemma 2: a weak nonproposer's response

If `H` votes yes, weak voter `j` toggles passage when `K_-j=a`. If `H` votes
no, it toggles weak-only passage when `K_-j=b`. Let

```text
t_rho(y)=(1-rho)h_0+rho h_1.
```

The exact relevance probability and monetary payoff difference are

```text
R_j=t_rho(y)Pr(K_-j=a)+(1-t_rho(y))Pr(K_-j=b),
Delta_j=x_j R_j.
```

Every other profile contributes zero. Hence `p_j=1` when `R_j>0`, including at
`x_j=0`, while any `p_j in [0,1]` is an explicit completion when `R_j=0`.

### Proposition 1: exhaustive fixed-proposal ballot correspondence

Every independent-behavioral ballot equilibrium at `(s,rho)` belongs to
exactly one of two classes.

**F. Sure active-H failure.** This class exists iff `q>=4`, equivalently
`N>=6`, and is exactly

```text
L(p)<=q-4.
```

It has `A=0`, both `H` types yes, sure PR12, type-`theta` H payoff `o_theta`,
and zero weak payoffs. At most `q-4` weak voters may use arbitrary positive
yes probabilities; every other weak voter uses zero. The class is independent
of `rho`.

**S. Secured passage under the ballot belief.** This class exists at every
proposal and has `A=1`, `h_theta=1{y>=o_theta}`, and

```text
if t_rho(y)=1: S(p)>=q-2,
if t_rho(y)<1: S(p)>=q-1.
```

Every remaining weak voter may use any independent probability in `[0,1]`.
The first condition allows `B(p)` anywhere in `[0,1]`; the second forces
`B(p)=1`.

**Proof of exhaustiveness.** If `A=0`, independence gives `L<=b-1`. At
`L=b-1`, choose a zero-probability voter. With positive probability all `L`
positive voters vote yes, putting `K_-j=b-1=a`; both H types vote yes, so this
voter is relevant and must vote yes, a contradiction. Conversely,
`L<=b-2=q-4` removes both pivotal counts from every weak voter's support.

Now suppose `A>0`. H follows the type threshold. If `t_rho=1` and fewer than
`b` voters are sure yes, `A>0` implies that some nonsure voter can face exactly
`b-1` other yes votes with positive probability. It is relevant and must be
sure yes, a contradiction. Thus `S>=b`; this also suffices. If `t_rho<1` and
`S<=b`, either a zero voter or a positive nonsure voter can face exactly `b`
other yes votes with positive probability. The H-no branch has positive
probability, so this voter must be sure yes, again a contradiction. Thus
`S>=b+1`; this also suffices. These sure-vote bounds make `A=1`, proving that
no equilibrium has `0<A<1`.

For a separating proposal `o_0<=y<o_1`, `t_rho=1-rho`. Therefore `rho=0`
allows exactly `q-2` sure weak votes and any `B in [0,1]`, while every
`rho>0` forces at least `q-1` sure weak votes and `B=1`. This discontinuity is
the reason `rho` cannot be replaced by `nu` off path.

## 4. Fixed-proposal payoffs under the true `nu`

The ballot in Proposition 1 is rational under `rho`. Proposal optimality uses

```text
g_k(s,b;nu)=(1-nu)u_k(0)+nu u_k(1).
```

For class F,

```text
g_i=0,
g_j=0 for every weak j,
g_H=o_bar(nu)=(1-nu)o_0+nu o_1.
```

For class S, define `t_nu(y)=(1-nu)h_0+nu h_1`. Then

```text
g_i=[t_nu+(1-t_nu)B](1-X)-t_nu y,
g_j=[t_nu+(1-t_nu)B]x_j,
g_H=(1-nu)[h_0 y+(1-h_0)o_0]
    +nu[h_1 y+(1-h_1)o_1].
```

At an on-path proposal, `rho=nu`. If `t_nu<1`, Proposition 1 forces `B=1`;
if `t_nu=1`, all types in the support of `nu` accept. In both cases the
on-path proposer payoff simplifies to

```text
g_i=1-X-t_nu(y)y.
```

That simplification is generally false off path. For example, when
`o_0=0<=y<o_1`, setting `rho=0` and exactly `q-2` sure weak yes votes permits
`B=0`. The true-`nu` deviation payoff is then only

```text
(1-nu)r_i,
```

even though the weak voters act under certainty of the low type.

At any positive-probability terminal history, Bayes' rule starts from
`rho(s)`, not from `nu` unless the proposal is on path:

```text
Pr(theta=1|H action d,s)
=rho(s)1{h_1=d}/[(1-rho(s))1{h_0=d}+rho(s)1{h_1=d}].
```

The weak vote vector adds no type likelihood conditional on the proposal.
Zero-probability terminal beliefs are stated, but no later player moves.

## 5. Exact proposal-stage assessment

A continuation assessment for recognized proposer `i` contains:

1. a proposal distribution `sigma_i`;
2. a belief map `rho_i(s)`, equal to `nu` on support and explicitly stated at
   every globally off-path proposal;
3. a class-F or class-S ballot element from Proposition 1 at each proposal;
4. the resulting type-conditional terminal distribution, payoffs, and terminal
   beliefs;
5. support only on maximizers of `g_i(s,b_i(s);nu)`; and
6. among those maximizers, support only on proposals minimizing
   `g_H(s,b_i(s);nu)`.

If proposer and H expected payoffs tie, differences in gifts, identities,
type-contingent outcomes, ballot completions, and terminal signatures remain
in the correspondence. This functional description is the exact
proposal-stage PBE characterization. The following propositions derive its
scalar projections and constructive support restrictions.

## 6. Proposal-stage implications for `3<=N<=5`

Here class F is unavailable, so every proposal receives a class-S completion.

### Proposition 2: `o_0>0`

The deviation `y=0,X=0` has both H types vote no under every `rho`. Because
`t_rho=0<1`, class S forces `B=1`, so this deviation gives the proposer one.
No proposal can give more than one. Hence the proposer payoff is uniquely one.

The complete tie-refined on-path condition is

```text
X=0 and t_nu(y)y=0.
```

These conditions also give H exactly `o_bar(nu)`, the lower bound supplied by
its type-specific optimality. Thus all such on-path proposals survive the
tie-break. The supported-type payoff vector gives the proposer one and every
other weak state zero, but proposal, inclusion, opt-out, off-support type
outcomes, and ballot completions may differ and are retained.

### Proposition 3: `o_0=0`

Define

```text
G=1-o_1,
L=1-nu,
D=max{G,L}.
```

The pooling deviation `y=o_1,X=0` cannot be suppressed: both H types accept
under every `rho`, so it gives `G`. At the deviation `y=0,X=0`, the low type
accepts and the high type rejects. Every ballot completion gives at least
`L`; the minimum `L` is attained with `rho=0`, exactly `q-2` sure weak yes
votes, and `B=0`. Thus every equilibrium proposer payoff satisfies `V>=D`.

These are the only unavoidable lower bounds. Any separating deviation can be
assigned `rho=0` and `B=0`, giving `(1-nu)r_i<=L`. Any pooling deviation gives
at most `G`. Moreover every `V in [D,1]` is attained on path by

```text
y=0, X=1-V,
```

with `rho=nu` and a class-S ballot completion. Therefore the exact proposer
payoff projection is

```text
[D,1].
```

For `V>D`, every on-path class-S outcome with proposer payoff `V` can be made
the unique payoff maximum by assigning all other proposals strictly less than
`V`. At `V=D`, the primitive H-payoff tie-break adds the following exact
restriction:

- if `L>G`, the unavoidable `y=0,X=0` tie gives H `o_bar(nu)`, so support
  outcomes must also give H `o_bar(nu)`;
- if `G>L`, the unavoidable `y=o_1,X=0` tie gives H `o_1`, so support outcomes
  must give H no more than `o_1`;
- if `G=L`, both ties are unavoidable and the smaller H payoff is
  `o_bar(nu)`, so support outcomes must give H `o_bar(nu)`.

If several proposals are mixed, every support proposal must have both the
same proposer payoff and the same tie-minimal H payoff. Gifts and identities
are otherwise unrestricted subject to feasibility and the displayed
conditions.

At the degenerate corner `nu=1,o_1=1`, `D=0`. The two pure proposal forms with
zero value are `y=0,X=1` and `y=1,X=0`; both give the actual high type payoff
one. Their payment and opt-out signatures remain distinct.

## 7. Proposal-stage implications for `N>=6`

Class F is available at every proposal and every `rho`. Thus an assessment can
assign zero payoff to every proposal deviation.

For every `V in (0,1]`, any on-path class-S outcome satisfying

```text
V=1-X-t_nu(y)y>0
```

is supportable by assigning F to every other proposal. Every `V` is attained,
for example, by `y=0,X=1-V`. At value zero, class-F outcomes are supportable
at arbitrary proposals. The H-payoff tie-break also permits a class-S outcome
at value zero exactly when it gives H its outside expectation:

```text
1-X-t_nu(y)y=0,
g_H=o_bar(nu).
```

Feasibility makes these two equations equivalent to either

```text
y=0, X=1,
```

or

```text
y>0, t_nu(y)=1, X=1-y,
and o_theta=y for every type with positive probability under nu.
```

Hence the proposer payoff projection is `[0,1]`. It is not the continuation
interface. For example, a zero-value F outcome pays every weak state zero,
whereas a zero-value S outcome may implement a unit of named weak gifts. Both
survive the primitive tie-break and cannot be quotiented.

## 8. Pre-recognition continuation correspondence

For each weak identity `i`, let `alpha_i` be any recognized-proposer
assessment satisfying Sections 5--7, including its proposal distribution,
`rho` map, ballot completions, type-conditional outcomes, and beliefs. Let
`U^{i,alpha_i}` denote the full resulting vector. Before uniform recognition,

```text
C2_M_active(h2)
= { (1/m) sum_{i=1}^m U^{i,alpha_i}:
    alpha_i is admissible at nu(h2) }.
```

In particular,

```text
C_H,theta=(1/m)sum_i U_H,theta^{i,alpha_i},
C_W,j,theta=(1/m)sum_i U_W,j,theta^{i,alpha_i}.
```

The same averaging retains the PR11--PR14 terminal probabilities, inclusion
and opt-out status, and implemented payment vectors. Full `h2` remains an
index even when two histories share `nu`, because their off-path `rho` and
completion maps may differ. Recognition is independent of type and history,
so it does not update `nu`.

## 9. Boundaries, existence, and invalidation

- `N=3`: `q=2,b=0`; class F is impossible. Class S requires no sure weak yes
  at `t_rho=1` and the sole weak nonproposer sure yes at `t_rho<1`.
- `N=4,5`: `q=3,b=1`; class F is impossible. Class S requires one sure weak
  yes at `t_rho=1` and two at `t_rho<1`.
- `N>=6`: class F exists exactly at `L(p)<=q-4`.
- `rho=0` at a separating proposal permits `B in [0,1]`; every `rho>0`
  forces `B=1`. This statement concerns ballot rationality.
- `nu=0` and `nu=1` govern the true proposal payoff. They never overwrite an
  explicitly different off-path `rho`.
- Both H type strategies and both type-conditional payoff vectors are retained
  even at degenerate beliefs.
- `y=o_theta` makes H vote yes. Positive weak relevance makes a weak voter vote
  yes even at `x_j=0`.
- A PBE exists for every admissible primitive vector, population, posterior,
  and full public history.

The exact candidate interface is
`model_redesign/pivotal_response_interfaces/r2_majority_active_h_v1.json`.
It remains pending independent rereview. Any change to the frozen Gate 0
bundle invalidates this node and every descendant. An R1 importer must use the
reviewed frozen replacement and apply `beta` exactly once; this R2 object uses
no discount.
