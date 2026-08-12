# Candidate status: `r2_unanimity_active_h`

## Outcome

The terminal active-`H` unanimity node has been rederived from the frozen Gate
0 bundle and serialized as a set-valued continuation interface. It is an
implementation candidate, not an independently accepted result.

The derivation establishes:

- the exact pure and independently mixed fixed-proposal ballot
  correspondence;
- the distinction between `N=3` and `N>=4` created by the feasibility of two
  simultaneous weak no completions;
- full type-conditional outcome probabilities and player-specific payoffs;
- proposal optimality with arbitrary named gifts and proposal-contingent
  off-path beliefs/completions;
- all posterior and outside-option boundary cases;
- the pre-recognition correspondence after the uniform weak-proposer draw;
- native Round-2 payoffs with no internal discounting.

No historical equilibrium result was imported. No manuscript, shared DAG,
shared ledger, Gate 0 artifact, other node, or protected file was edited by
this implementer.

## Candidate artifacts and hashes

| Role | Artifact | SHA-256 |
|---|---|---|
| frozen input | `model_redesign/pivotal_response_interfaces/gate0_bundle_v1.json` | `6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1` |
| continuation interface | `model_redesign/pivotal_response_interfaces/r2_unanimity_active_h_v1.json` | `f3ca4ebf28827d7e18d9f3a2d07d41ffd6fe57532c9af09300f20a8ab5cecf10` |
| analytic derivation | `model_redesign/pivotal_response_nodes/r2_unanimity_active_h_v1.md` | `cdc25327f51d66d62685fd680f14c6f24ed26d8b874d684df2e9cba672d8755e` |
| R verifier | `scripts/verify_pivotal_response_r2_unanimity_active_h.R` | `4072483a11534ad3b342cb5e724463faeb9167124b30a3a3cede270159c837d0` |
| check table | `tables/pivotal_response_r2_unanimity_active_h_checks.csv` | `a86b40f6e2577b9a4019252296ce15bc81372b0bb2c6f9ef8d3fa8f1aea436f7` |

The interface hash is over the exact UTF-8 bytes of the JSON. It is deliberately
reported outside that file to avoid a self-referential digest.

## Mechanical validation

Command:

```bash
LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 Rscript --vanilla scripts/verify_pivotal_response_r2_unanimity_active_h.R
```

Result:

```text
r2_unanimity_active_h checks: 18 PASS / 18 total
Wrote tables/pivotal_response_r2_unanimity_active_h_checks.csv
```

Coverage includes 15,240 exhaustively enumerated pure ballot profiles,
explicit mixed-completion cases, 250 random full-vector accounting checks, 78
`N=3` separating constructions, 135 coordinated-failure cases, 42 positive
payoff constructions for `N>=4`, equality boundaries, uniform recognition,
and native-date invariance.

JSON validation and interface hashing:

```bash
python3 -m json.tool model_redesign/pivotal_response_interfaces/r2_unanimity_active_h_v1.json
python3 /Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/hash_artifact.py model_redesign/pivotal_response_interfaces/r2_unanimity_active_h_v1.json
```

## Review boundary

Status: `candidate_pending_independent_review`.

An independent read-only reviewer must cold-reconstruct the terminal ballot
and proposal-deviation logic against the frozen Gate 0 bundle. In particular,
the review should stress-test:

1. the equality response of `H` when sure weak failure leaves monetary payoffs
   equal but changes opt-out status;
2. the exact fixed point with zero, one, or at least two zero weak yes
   probabilities;
3. the nonclosed `N=3`, `o_1=1`, `nu<1` proposer-payoff set;
4. the proposal tie-break at zero payoff and at a separating/pooling tie;
5. the preservation of counterfactual-type vectors at degenerate posteriors;
6. the uniform pre-recognition averaging and the absence of internal
   discounting.

No descendant may consume this candidate as a passed interface until that
review closes on the exact interface hash above.
