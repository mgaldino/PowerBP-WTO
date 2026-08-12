# Round 2 majority after the hegemon's opt-out

## Scope and frozen input

This note derives only the terminal node `r2_majority_weak_only`. Its frozen
input is `gate0_bundle_v1.json` with SHA-256
`6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1`.
No historical equilibrium result is imported. The derivation is in native
Round-2 units and applies no discount factor.

At the public history `h2`, the hegemon has already opted out irreversibly.
Its outside payoff was realized in Round 1, so its current Round-2 flow is
zero. There are `m=N-1` weak states, the original majority quota remains

`q = floor(N/2)+1`,

and a uniformly recognized weak proposer is counted as voting yes. Therefore
there are `K=m-1=N-2` simultaneous nonproposer voters and the proposal passes
if at least

`t = q-1`

of those `K` voters choose yes. For every `N>=3`, `1<=t<=K`; in particular,
the node is nonempty when `N=3`.

The recognized proposer `i` chooses nonnegative named gifts `x_j` for every
`j!=i`; the residual is

`x_i = 1 - sum_{j!=i} x_j >= 0`.

Thus a passing proposal implements a vector `x` in the unit simplex
`Delta_m`; a failed proposal gives every weak state zero. A named gift is paid
when the proposal passes even if its recipient voted no.

## Terminal ballot correspondence

Fix a public proposal and a recognized proposer. Let `p_j in [0,1]` be weak
nonproposer `j`'s independent behavioral probability of yes. Write

- `a(p)` for the number of voters with `p_j=1`;
- `c(p)` for the number with `0<p_j<1`;
- `ell(p)=a(p)+c(p)` for the number that can vote yes with positive
  probability.

For voter `j`, let `S_-j` be the number of yes votes among the other
nonproposers. Its vote is relevant exactly on `S_-j=t-1`. Therefore

`rho_j(p_-j) = Pr(S_-j=t-1)`

is its relevance probability and its ordinary expected-payoff difference is

`EU_j(yes)-EU_j(no) = x_j rho_j(p_-j) >= 0`.

The frozen response convention adds the consequential equality case: if
`rho_j>0`, yes is required even when `x_j=0`; if `rho_j=0`, the action is an
explicit completion and may be pure or mixed. Hence the exact ballot
condition is

`p_j<1 implies rho_j(p_-j)=0`.

### Proposition 1 (complete pure and behavioral ballot characterization)

A behavioral profile `p` is a terminal ballot equilibrium if and only if

`a(p)>=t` or `ell(p)<=t-2`.                                      (B)

The first class passes with probability one. The second class fails with
probability one. Consequently there is no terminal ballot equilibrium with a
nondegenerate probability of passage. For pure profiles, if `a` is the number
of nonproposer yes votes, condition (B) becomes

`a>=t` or `a<=t-2`;

the knife-edge count `a=t-1` is never an equilibrium.

**Proof.** Independent interior Bernoulli variables put positive probability
on every integer between the minimum and maximum possible yes counts. Suppose
first that `a>=t`. Every voter with `p_j<1` faces at least `t` certain yes
votes among the other voters, so `S_-j=t-1` has probability zero. Voters with
`p_j=1` satisfy the response condition. Passage is certain.

If `ell<=t-2`, even every voter who can vote yes doing so leaves fewer than
`t` nonproposer yes votes. For an interior voter, the other voters can supply
at most `ell-1<=t-3` yes votes; for a zero-probability voter they can supply at
most `ell<=t-2`. Thus every voter with `p_j<1` has zero relevance probability,
and failure is certain.

Conversely, suppose neither inequality in (B) holds: `a<t` and
`ell>=t-1`. If some voter has `p_j=0`, the support of `S_-j` contains every
integer from `a` through `ell`, including `t-1`; that voter has positive
relevance probability but does not choose yes. If no voter has probability
zero, then at least one voter is interior. Excluding that voter, the support
runs from `a` through `K-1`; because `a<=t-1` and `K>=t`, it contains `t-1`.
Again a voter with positive relevance probability fails to choose yes. Both
cases contradict the response condition. This proves necessity. QED.

The two classes in (B) are full, product-safe completions: every action profile
in the support of a passing completion passes, and every action profile in the
support of a failing completion fails. This does **not** identify the two
classes with each other. Switching several actions can cross from one class
to the other even though each switch is locally irrelevant against the
original profile.

### Small-`N` boundaries

- `N=3`: `K=t=1`. The unique ballot completion is yes and passage is certain
  at every proposal.
- `N=4`: `K=t=2`. The only behavioral completions are all-yes passage and
  all-no failure. At all no, either voter is locally irrelevant holding the
  other's no fixed, but changing both votes produces passage.
- `N=5`: `K=3`, `t=2`. Pure passage requires at least two certain yes votes;
  pure failure requires all no. With two certain yes votes, the third voter
  may use any behavioral probability because passage is already secured.

## Proposal-contingent completions and proposer optimality

For recognized proposer `i`, let `kappa_i(s)` assign a full ballot completion
to every feasible proposal `s`. Define `d_i(s)=1` if that completion belongs
to the certain-passage class of Proposition 1 and `d_i(s)=0` if it belongs to
the certain-failure class. The proposer's payoff from `s` is exactly

`g_i(s)=d_i(s) x_i(s)`.

### Proposition 2 (complete strategy characterization at a recognized node)

A continuation assessment at the recognized-proposer node is a PBE if and
only if:

1. at every proposal `s`, `kappa_i(s)` satisfies (B);
2. the completion map and proposal strategy are measurable;
3. `argmax_s g_i(s)` is nonempty; and
4. the proposer's behavioral strategy is supported on `argmax_s g_i(s)`.

No additional belief choice enters this terminal weak-only ballot. The
inherited public belief must satisfy the upstream Gate 0/Bayes requirements,
but it is payoff- and action-irrelevant here because the hegemon is absent and
no weak player observes its type.

**Proof.** Proposition 1 is necessary and sufficient for sequential
rationality at every simultaneous ballot information set. Conditional on
those ballot strategies, the proposer directly solves `max_s g_i(s)`; support
on its maximizers is necessary and sufficient for its sequential rationality.
There is no later decision and no continuation value. QED.

For `N=3`, every proposal necessarily passes. The proposer uniquely chooses
zero gift and obtains one, so the implemented vector is the unit vector `e_i`.

For every `N>=4`, both all yes and all no satisfy Proposition 1 at every
proposal. Thus proposal-contingent completions can make any selected proposal
pass and every distinct deviation fail. This yields both the all-failure PBE
and passing PBEs for every allocation in `Delta_m`. More generally,
Proposition 2 retains completion maps with several passing proposals and
requires the proposer to choose only those with maximal residual.

The project tie-break does not reduce this set. The hegemon's current payoff
is zero (and its already-realized outside payoff is the same) at every
proposal. Hence every proposer-payoff tie also ties the hegemon payoff; when
outcomes otherwise differ, the frozen contract retains the correspondence.

## Exact payoff correspondences by identity

Let `v^i` be the expected weak payoff vector conditional on recognizing
proposer `i`.

### Pure strategies

For `N=3`, `v^i=e_i`. For `N>=4`, the exact conditional pure-strategy payoff
set is

`S_i^pure = {0_m} union Delta_m`.                               (P)

The zero vector is implemented by a failing proposal; any vector in the
simplex is implemented by a passing proposal with that allocation.

### Behavioral strategies

For `N>=4`, the exact conditional behavioral payoff set is

`S_i = Delta_m union {v in R_+^m : v_i=0 and sum_j v_j<=1}`.     (M)

To prove necessity, let `M_i=max_s g_i(s)`. If `M_i>0`, every proposal in the
proposer's support passes and pays the proposer `M_i`; hence `v_i=M_i>0` and
the expected allocation sums to one. If `M_i=0`, then `v_i=0`; mixing between
passing residual-zero proposals and failing proposals can yield total
expected weak surplus anywhere in `[0,1]`.

For sufficiency, any `v in Delta_m` is supported by making its corresponding
proposal pass and all distinct proposals fail. If `v_i=0` and
`T=sum_j v_j<1`, mix with probability `T` on the passing allocation `v/T` and
with probability `1-T` on a distinct failing proposal; both give the proposer
zero. The cases `T=0` and `T=1` follow directly. This proves (M).

Before recognition, the uniformly integrated continuation interface is

`C2_M_WO(h2) = { (0_H, w_1,...,w_m) :`

`                  w=(1/m) sum_{i=1}^m v^i, v^i in S_i }`       (C)

for behavioral PBEs. For pure PBEs, replace `S_i` by `S_i^pure`. The first
coordinate in (C) is the hegemon's **current Round-2 flow**, not a second
payment of its Round-1 outside option. The formula is indexed by the full
public `h2`; its value correspondence is the same at every such history, while
the assessment-level completion maps may differ across histories.

Every vector in (C) is nonnegative and has aggregate weak value between zero
and one. Under pure proposal strategies the aggregate belongs to
`{0,1/m,...,1}`. Behavioral proposal mixing makes every aggregate in `[0,1]`
attainable: for each recognized proposer, mix with the desired probability on
a residual-zero passing allocation to a different weak state and otherwise
choose a failing proposal.

No equilibrium selection is supplied by the game. Downstream nodes must
import the full correspondence (C), or a separately proved selection-free
bound, and must not silently replace it with a scalar.

## Gifts, oversized support, and the Gate 0 counterexample

Positive outsider gifts and oversized support are genuine equilibrium
possibilities. For `N=5`, `q=3`, give each of the three nonproposers `0.2` and
leave the proposer `0.4`. Pair this proposal with two nonproposer yes votes and
one no vote. Passage is already secured, so the no voter is locally irrelevant
and receives a strictly positive outsider gift. Alternatively, pair the same
proposal with all three yes votes; the third supporting vote is oversized.
Pair every distinct proposal, including the zero-gift deviation, with all no.
The on-path proposal gives the proposer `0.4`, while every deviation fails and
gives zero. All ballot actions satisfy Proposition 1. The same construction
works for every strictly positive gift vector with positive proposer residual,
a relatively open subset of the feasible simplex. A positive gift to a
non-supporting weak voter and oversized support require `K>t`, which holds for
every `N>=5`. For `N=4`, positive gifts can still be sustained, but every
nonproposer vote is required for passage.

At all no, each isolated change to yes is locally irrelevant. Yet changing
enough no votes jointly causes passage. It is therefore invalid to delete
outsider gifts, reduce support to a minimal winning set, or quotient all
locally irrelevant actions player by player. Such a representation would
discard PBEs in (P)--(C).

## Status and invalidation

- Proposition 1: **proved** and exhaustively checked for pure profiles for
  `3<=N<=15`, and on a five-point probability grid for `3<=N<=9`.
- Proposition 2: **proved**.
- Conditional and pre-recognition payoff correspondences: **proved**.
- `N=5` gift/oversized-support construction: **proved** and checked
  numerically.
- Interface status: **candidate pending independent review**.

Any change to the frozen Gate 0 bundle, the original quota after opt-out, the
equality response convention, independent behavioral randomization, named
gift payment, or residual budget invalidates this entire node and every
descendant that imports it.
