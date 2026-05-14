# Numeric Example: Weak-State Delay in the Fixed-Pie pi_H = 0 Model

Date: 2026-05-14

This note records a complete backward-induction example in which a weak-state
proposer deliberately induces rejection in Round 1 under unanimity. The example
uses the fixed-pie relative-package architecture with `pi_H = 0`.

The purpose is diagnostic: the example shows why a weak proposer may prefer
delay when Round-1 approval requires compensating both `H` and all other weak
voters, while terminal Round 2 gives weak voters zero outside payoff.

This is not an ad hoc protocol restriction. The branch must be kept, ruled out
by proof under stated primitives, or marked unresolved.

## Primitives

There are 13 states:

```text
N = 13
m = 12 weak states
```

Recognition is weak-state-only:

```text
pi_H = 0
```

Discount factor:

```text
beta = 0.9
```

Belief:

```text
mu = Pr(H is high type) = 0.01
```

H's terminal outside options:

```text
d0 = 0.10
d1 = 0.50
```

H's direct benefit from agreement is primitive. In this example:

```text
b0 = 0
b1 = 0
```

Thus all type difference comes from the outside option:

```text
low H outside option  = d0 = 0.10
high H outside option = d1 = 0.50
```

The weak coalition's fixed surplus is:

```text
1
```

A package `y` gives `H` payoff:

```text
H payoff if agreement passes = y + b_theta
```

Because `b0 = b1 = 0`, the terminal acceptance thresholds are:

```text
tau0 = d0 - b0 = 0.10
tau1 = d1 - b1 = 0.50
```

## Step 1: Solve Round 2

Round 2 is terminal. Weak voters have outside payoff zero, so the recognized
weak proposer only needs to pay `H`.

### Low-only package in R2

Offer:

```text
y = tau0 = 0.10
```

Low `H` accepts. High `H` rejects.

The weak proposer gets:

```text
if H is low : 1 - 0.10 = 0.90
if H is high: 0
```

Expected payoff:

```text
low-only R2 payoff = (1 - mu) * (1 - tau0)
                   = 0.99 * 0.90
                   = 0.891
```

### Pooling package in R2

Offer:

```text
y = tau1 = 0.50
```

Both H types accept.

The weak proposer gets:

```text
pooling R2 payoff = 1 - 0.50 = 0.50
```

### R2 choice

Since:

```text
0.891 > 0.50
```

the R2 proposer chooses low-only.

Therefore:

```text
p2(mu) = 0.891
```

Each weak state has probability `1/12` of being proposer in R2. Hence each
weak state's Round-1 continuation value is:

```text
c(mu) = beta * p2(mu) / 12
      = 0.9 * 0.891 / 12
      = 0.066825
```

This is what a non-proposing weak voter must receive in R1 to be willing to
vote yes.

## Step 2: Test R1 Pooling

To make both H types accept in R1, the proposer must satisfy the high type's
discounted continuation threshold:

```text
a1 = beta * d1 - b1
   = 0.9 * 0.50 - 0
   = 0.45
```

The proposer must also compensate the 11 other weak voters:

```text
11 * c(mu) = 11 * 0.066825
           = 0.735075
```

Total cost of a pooling agreement in R1:

```text
H concession + weak-voter payments
= 0.45 + 0.735075
= 1.185075
```

But the total weak surplus is only:

```text
1
```

Therefore R1 pooling is infeasible:

```text
1.185075 > 1
```

## Step 3: Test R1 Low-Only Separation

The key backward-induction point is that the low type's R1 threshold is not
the terminal low threshold `tau0 = 0.10`.

If low `H` rejects in R1, it can mimic the high type and be treated as high in
Round 2. With posterior one on the high type, the R2 proposer offers the
pooling package:

```text
y = tau1 = 0.50
```

Low `H` would accept this R2 package and receive:

```text
D0(1) = d0 + tau1 - tau0
      = 0.10 + 0.50 - 0.10
      = 0.50
```

Thus the R1 concession needed to make low `H` accept is:

```text
a0^1 = beta * D0(1) - b0
     = 0.9 * 0.50 - 0
     = 0.45
```

The high type's R1 threshold is:

```text
a1 = 0.45
```

So:

```text
a0^1 = a1 = 0.45
```

There is no interval of offers that low `H` accepts and high `H` rejects.
Low-only separation is blocked.

Any `y < 0.45` is rejected by both types. Any `y >= 0.45` is accepted by both
types, returning to pooling.

## Step 4: R1 Deliberate Rejection by a Weak Voter

The proposer can instead make a proposal that is designed to fail. For example:

```text
y = 0.45
z_r = 0 for one non-proposing weak voter r
```

The designated weak voter compares:

```text
accepting gives: 0
rejecting gives: c(mu) = 0.066825
```

So the weak voter rejects. The proposal fails.

Because the rejection comes from a weak voter, not from `H`, the public history
does not reveal H's type. The posterior remains:

```text
mu = 0.01
```

The weak proposer receives the continuation value:

```text
delay payoff = c(mu) = 0.066825
```

## Step 5: Compare Candidate Payoffs

The candidate payoffs are:

```text
R1 pooling: infeasible, because total cost is 1.185075 > 1
R1 low-only separation: blocked, because a0^1 = a1 = 0.45
R1 deliberate rejection: 0.066825
```

Thus, in this example, deliberate rejection by a weak voter is the selected
candidate among the pure-threshold candidates.

## Intuition

The proposer does not wait because beliefs improve. Beliefs do not improve in
the no-information rejection branch.

The proposer waits because the game has a terminal second round. In R2,
non-proposing weak voters have outside payoff zero. A recognized weak proposer
can keep the entire residual after paying `H`.

In R1, by contrast, non-proposing weak voters have a positive continuation
value because each may be recognized as proposer in R2. The R1 proposer must
compensate those voters to secure unanimity.

In this example, high `H` has a strong outside option. Paying `H` enough to
accept in R1 and paying all other weak voters their continuation values exceeds
the fixed surplus. Low-only separation is also blocked because low `H` can
reject and be treated as high in the continuation.

Therefore, a weak proposer rationally induces rejection and takes the R2
continuation lottery.

## Caveat for the Paper

This branch is formally meaningful under the stated finite-horizon bargaining
game, but it is not the main informational-power mechanism. It reflects
intertemporal bargaining and terminal-proposer rents.

Under the project's operating rules, this branch should not be removed by an
ad hoc protocol restriction. It should be kept and interpreted honestly, ruled
out by proof under stated primitives if possible, or marked as unresolved.
