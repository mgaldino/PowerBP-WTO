# Superseded R2 protocol closure note

Date: 2026-05-11

Status: superseded by the fixed-pie reset.

This note previously recorded a Round-2 protocol closure under a state-dependent
weak surplus formulation. That formulation has been rejected. The current
working document is `model_redesign/power_architecture_derivations.Rmd`, where
the weak coalition surplus is fixed and normalized to 1.

Do not use any prior R2 cutoff, strategy region, value function, or continuation
value from the superseded note. Round 2 must be rederived from the fixed-pie
primitives:

```text
B = 1
weak coalition surplus after accepted package y = 1 - y
theta affects H's participation threshold, not the weak coalition pie
```

The following protocol conventions remain available as primitives for the next
clean derivation:

1. `H` accepts in indifference.
2. Weak voters accept in indifference.
3. If a weak proposer is indifferent between payoff-maximizing proposals, the
   baseline selects the proposal that minimizes `H`'s expected payoff under the
   current belief.

These conventions are not themselves a derivation of R2 values.
