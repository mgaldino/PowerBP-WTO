# R2 majority weak-only implementation status

## Decision

`r2_majority_weak_only` is **candidate pending independent read-only review**.
The implementer has not reviewed or approved the node.

## Frozen dependency

- Gate 0 bundle:
  `sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1`.
- Payoff date: native Round 2.
- Discount applications inside this node: zero.

## Candidate artifacts

| Role | Artifact | SHA-256 |
|---|---|---|
| Frozen downstream interface | `model_redesign/pivotal_response_interfaces/r2_majority_weak_only_v1.json` | `e0ec6cd35e145f04d1a2897fc1f78157f2b0d45de478046ac5451b2df0a74b5d` |
| Proof note | `model_redesign/pivotal_response_nodes/r2_majority_weak_only_v1.md` | `ab2dba442e7104c26a5188aae9060475b3c77577ce219ff5fefea2471f91fcf1` |
| Reproducible verifier | `scripts/verify_pivotal_response_r2_majority_weak_only.R` | `b7a5562fa69f3f431f1b8baba0ac378b10f83a82cb0e7371d1da3f11c7d98821` |
| Check results | `tables/pivotal_response_r2_majority_weak_only_checks_v1.csv` | `1e0f3a5560bdbaf82fddeed6c9ebe9fb6a7974491d4e26906388ceb71971550b` |
| Boundary cases | `tables/pivotal_response_r2_majority_weak_only_cases_v1.csv` | `882e8b2ea556e826f2b783bae26a64ce865cd4506988ff8b9f7f557d0e4a9f90` |

The interface hash is computed over the exact UTF-8 JSON bytes and is the
candidate hash that a reviewer must cite. It is not embedded recursively in
the interface itself.

## Implemented results

1. The exact behavioral ballot condition is
   `a>=t or ell<=t-2`, where `a` counts certain yes voters, `ell` counts voters
   with positive yes probability, and `t=q-1`.
2. Every equilibrium ballot completion has deterministic passage or
   deterministic failure; there is no stochastic-passage ballot equilibrium.
3. The `N=3` node has a unique passing outcome. For every `N>=4`, both pass
   and failure completions exist at every proposal.
4. Proposal optimality is retained as a proposal-contingent completion map
   followed by maximization of `d_i(s)x_i(s)`; no minimal coalition or
   zero-gift restriction is imposed.
5. Conditional payoff correspondences are given by identity, and the
   pre-recognition interface integrates them under the uniform proposer draw.
6. Positive outsider gifts, oversized support, the `N=4` joint-completion
   hazard, and the `N=5` open-set gift construction survive.

## Mechanical validation

Command:

```text
LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 Rscript --vanilla scripts/verify_pivotal_response_r2_majority_weak_only.R
```

Result: **PASS, 13/13 checks**.

Coverage includes exhaustive pure-profile enumeration for `3<=N<=15`, a
five-point independent-probability grid for `3<=N<=9`, deterministic-outcome
checks, `N=3`, `N=4`, and `N=5` boundary checks, and constructive payoff and
gift examples. Python JSON parsing also passed.

## Review gate

No DAG node should be marked `pass` from this implementation report. An
independent reviewer must reconstruct the terminal ballot and proposer problem
from the frozen Gate 0 primitives, cite candidate interface hash
`sha256:e0ec6cd35e145f04d1a2897fc1f78157f2b0d45de478046ac5451b2df0a74b5d`,
and issue a read-only decision. Any repair changes the candidate hash and
requires a new review.
