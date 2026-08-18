# N2 candidate — R2 under unanimity

**Node:** `N2`
**Status:** `pending` — implementation candidate awaiting two independent read-only reviews
**Normative source:** Sections 2, 4, 5, 6, 7.2, 8, 9, and 11 of
`quality_reports/plans/2026-08-12_essential_input_gate0.md`
**Interface:** `model_redesign/essential_input_n2_r2_unanimity_interface.json`
**Candidate interface hash:** `sha256:32a2989f806af20b2557fa8f495dfbe661ac951be59ee68e583fd50735e486ed`
**Claim ledger:** `model_redesign/essential_input_n2_r2_unanimity_ledger.json`
**Verifier:** `scripts/verify_essential_input_n2.R`

This document rederives the terminal unanimity node from the governing
contract. It does not use a continuation result or a historical formula.

## 1. State and native date

At entry to R2, let `nu=Pr(theta=1)` and `m=N-1`. A weak state `i` is
recognized uniformly from the `m` weak states and proposes

```text
s = (y, (x_j)_{j in W without i}, r_i)
```

subject to

```text
0 <= y <= y_bar,
x_j >= 0,
r_i >= 0,
y + sum_j x_j + r_i <= 1.
```

The primitive domain relevant to this node is

```text
0 <= nu <= 1,
0 < o_0 < o_1 < 1,
o_1 <= y_bar <= 1.
```

Under unanimity, the proposal passes only if `H` and every weak
nonproposer vote yes. R2 is terminal. All values below are paid at the R2 date;
`beta` does not enter any expression.

## 2. Terminal outcomes for a fixed proposal and vote profile

If all nonproposers vote yes, the proposal is implemented in full:

```text
H receives y,
i receives r_i,
each weak nonproposer j receives x_j.
```

If any nonproposer votes no, unanimity fails. The game ends with `H` receiving
`o_theta` and every weak state receiving zero. Passage without `H` is therefore
unreachable under unanimity. In particular, no ballot outcome destroys,
returns, or reallocates `y`.

## 3. Weak nonproposer ballot — P6

Fix a feasible proposal and a weak nonproposer `j`. Against a profile in which
all other nonproposers vote yes, `j` is pivotal: yes gives `x_j` and no gives
zero. Against every profile containing another no vote, the proposal fails
regardless of `j`'s action, and both actions give zero.

- If `x_j>0`, yes gives at least as much as no against every profile and more
  against the pivotal profile. Thus no is weakly dominated and inadmissible.
- If `x_j=0`, yes and no give the same payoff against every profile. Neither is
  eliminated by stage-undominance, and the genuine information-set
  indifference is resolved by `T^Y` in favor of yes.

Hence every weak nonproposer votes yes after every feasible proposal. This is
the unique weak ballot strategy admitted by PBE plus the contract's
stage-undominated restriction for weak nonproposers and `T^Y`. The conclusion
does not use a ballot belief.

## 4. H ballot — PBE and T^Y

Because all weak nonproposers vote yes, `H` is pivotal. Type `theta` compares

```text
yes: y
no:  o_theta.
```

Sequential rationality and `T^Y` therefore imply

```text
H(theta) votes yes iff y >= o_theta.
```

Since `o_0<o_1`, the passage regions for a fixed proposal are:

| Offer to H | Type 0 | Type 1 | Outcome |
|---|---|---|---|
| `y<o_0` | no | no | failure |
| `o_0<=y<o_1` | yes | no | passage only at `theta=0` |
| `y>=o_1` | yes | yes | passage for both types |

The weak states' beliefs about `theta` do not affect their ballot actions, and
`H` knows its type. Thus unrestricted beliefs after a zero-probability proposal
do not change any ballot response or proposal-deviation payoff in N2.

## 5. Recognized proposer's problem and P0

For a fixed `y`, positive payments to weak nonproposers cannot buy an
additional vote: all of them already vote yes at zero. Conditional on the
three `y` regions, the maximal expected proposer payoff is therefore

```text
y<o_0:          0,
o_0<=y<o_1:    (1-nu)*(1-y),
y>=o_1:         1-y,
```

obtained by setting every `x_j=0` and `r_i=1-y`. The objective is weakly
decreasing in `y` within each passage region. The only candidates are

```text
S(nu) = (1-nu)*(1-o_0), from y=o_0,
P      = 1-o_1,          from y=o_1.
```

The pooling candidate is strictly positive throughout the primitive domain
because `o_1<1`. Consequently every maximizing proposal passes with positive
probability. If such a proposal had budget slack, assigning the slack to
`r_i` would leave the package seen by every voter, all ballot actions, and all
terminal transitions unchanged while strictly increasing the proposer's
expected payoff. Likewise, if any `x_j>0`, shifting it to `r_i` leaves `j`
voting yes at `x_j=0` by `T^Y` and strictly increases proposer payoff whenever
the proposal passes. Hence every maximizing proposal has

```text
x_j=0 for every weak nonproposer j,
r_i=1-y,
y + sum_j x_j + r_i = 1.
```

This proves P0 from the weak inequality in the feasible set rather than
assuming equality.

## 6. Frontier and proposal-level tie-break

Define

```text
nu_star = (o_1-o_0)/(1-o_0).
```

The strict primitive restriction gives

```text
0 < nu_star < 1,
```

and direct subtraction gives

```text
S(nu)-P = (1-o_0)*(nu_star-nu).
```

Therefore `y=o_0` strictly maximizes below `nu_star`, and `y=o_1` strictly
maximizes above it. At `nu=nu_star`, both offers maximize before applying the
proposal-level tie-break. Expected payoff to `H` is

```text
y=o_0: (1-nu_star)*o_0 + nu_star*o_1,
y=o_1: o_1.
```

The first is strictly smaller because `nu_star<1` and `o_0<o_1`. The
contract's tie-break therefore selects `y=o_0`. This selection is distinct
from `T^Y`, which determines the ballot response of an indifferent voter.

The equilibrium correspondence has two cells:

1. **Low-type-only passage:** `0<=nu<=nu_star`. The proposal is
   `(y,x,r_i)=(o_0,0,1-o_0)`. The recognized proposer obtains
   `(1-nu)*(1-o_0)`. Conditional H payoffs are `(o_0,o_1)`. Passage with H has
   probability `1-nu`, and failure has probability `nu`.
2. **Pooling passage:** `nu_star<nu<=1`. The proposal is
   `(y,x,r_i)=(o_1,0,1-o_1)`. The recognized proposer obtains `1-o_1`.
   Conditional H payoffs are `(o_1,o_1)`. Passage with H has probability one.

In both cells, the proposal, pure ballot strategy profile, outcome
distribution, and payoff vector are unique. Assessments remain multiple only
because the contract leaves beliefs unrestricted after zero-probability
proposals; those beliefs are payoff-irrelevant here.

## 7. Effect of excluding the former degenerate corner

The former boundary `o_1=1, nu=1` made every rejected proposal and the accepted
proposal `y=1` yield proposer payoff zero. That zero-residual boundary admitted
the entire feasible package set, including slack packages, as an argmax.

It is outside the current primitive domain. With `o_1<1`, when `nu=1` the
pooling proposal `y=o_1` yields the strictly positive payoff `1-o_1`, whereas
every proposal with `y<o_1` is rejected by the certain high type and yields
zero. Offers above `o_1` and positive weak payments reduce the proposer payoff,
and slack can be assigned to the proposer. Thus the old degenerate family does
not survive as a boundary equilibrium in the admissible model: `nu=1` belongs
uniquely to the pooling cell with full budget use.

No other proposal or payoff multiplicity survives. Only payoff-irrelevant
off-path belief multiplicity remains, and it is recorded rather than selected.

## 8. Posterior sufficiency and weak pre-recognition value — P5

R2 has no successor state. Given an entry posterior `nu`, the payoff-relevant
objects are only the fixed primitives, the current recognized weak proposer,
the proposed package, and the terminal ballot. Recognition is iid, uniform,
and with replacement, so a prior public history neither changes eligibility nor
creates an inherited payoff or state variable. Two public histories with the
same `nu` therefore induce the same feasible set, ballot stage game, and
recognized-proposer objective. Proposer identities are equivalent by
relabeling weak states. The complete equilibrium correspondence is a function
of `nu` alone; this is a derived sufficient statistic, not a Markov-strategy
restriction.

Before R2 recognition, a representative weak state is recognized with
probability `1/m`. In both records every weak nonproposer allocation is zero,
so its pre-recognition continuation value is

```text
C_W^2(nu,U) = recognized proposer payoff / m.
```

This gives `((1-nu)*(1-o_0))/m` in the low-type-only cell and `(1-o_1)/m` in
the pooling cell.

## 9. Coverage, existence, and completeness

The interface uses two mutually exclusive cells:

```text
LOW-TYPE-ONLY: 0<=nu<=nu_star,
POOLING:       nu_star<nu<=1.
```

Because `0<nu_star<1`, both cells are nonempty and together exhaust the full
belief domain `0<=nu<=1`. Each cell has one equilibrium outcome/payoff record;
no `none` cell is needed. The piecewise proposer objective exhausts every
feasible `y`, the weak-ballot argument exhausts both pure actions for every
weak nonproposer, and the threshold argument exhausts both pure actions for
each type of `H`.

No equilibrium can pass without H under unanimity. No equilibrium delays,
because R2 is terminal. The interface preserves the only remaining
multiplicity: unrestricted payoff-irrelevant beliefs after zero-probability
proposals.

## 10. Invalidation and review status

N2 consumes no continuation interface. Any change to the contract's
primitives, terminal implementation, ballot solution concept, discount timing,
or interface schema invalidates this candidate. The node remains `pending` and
must not be consumed by N4 unless this exact interface hash receives
independent `formal_design` and `game_theory` reviews with PASS `0/0/0` and is
then recorded as `pass/frozen` under Section 11 of the contract.
