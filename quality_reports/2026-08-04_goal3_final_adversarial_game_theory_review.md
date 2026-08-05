# Independent Adversarial Game-Theory Audit — Goal 3

**Date:** 2026-08-04
**Reviewed commit:** `5bd7fbe47f63f6b94ca4085852596f1d4ad9901c`
**Mode:** independent and read-only
**Rmd SHA-256:** `2f6d77a61210fe85a8dca8f589f17e06b149c55a520668b08c87932ef0925aa2`
**PDF SHA-256:** `c4cdcd500425c96b8a3d0286713d3b1dce17a3aa49a71a615e057002628a433d`

## Post-closure scope warning — 2026-08-05

This PASS and these hashes remain valid only for the reviewed candidate. The
user later adopted `T^Y` acceptance at exact outside/continuation value and
clarified terminal timing for `beta`. The intended model therefore requires a
new Gate 0 and full rederivation. This review is historical evidence and must
not be cited as validation of a v6 migration. See
`quality_reports/2026-08-05_goal3_accept_at_equality_pending.md`.

## Verdict

**PASS — no substantive reservation.**

No payoff, support, attainment, or mixing counterexample survived the final
audit. In particular:

- terminal unanimity correctly distinguishes the sure-passage target `0.40`
  from the attained value `0.30` when joint weak passage is `3/4`;
- in the `N=3` diagnostic, an unrestricted gift `x=1/100` yields `0.69`, above
  low-only `0.65`, exclusion `0.60`, and the clean cap value `0.55`;
- that gift remains a feasible deviation and unrestricted PBE-UD possibility,
  but is not a coalition-pure baseline outcome;
- if the gift is the unique maximizer under an assessment, the coalition-pure
  correspondence is correctly empty rather than rescued by deleting the
  deviation;
- the `N=4`, `beta=1` outsider gift `1/50` reduces the proposer value from
  `0.46` to `0.441`, below low-only `0.45`;
- total weak payoff is not confused with proposer payoff: it uses the whole
  weak residual pie.

The audit also confirmed the geometry of forced-no outsiders, threshold
supporters, and weak-only support; separate treatment of suprema and
attainment; and support of proposer mixing only on attained pure maximizers.
The ballot remains simultaneous and sealed, without roll call or any ordering
of `H`.

## Repair history

The adversarial pass on the preceding candidate identified partial weak
passage in terminal unanimity and the unrestricted `N=3` gift deviation. The
implementer repaired the full proposal-contingent problem and added explicit
regressions. The complete audit was then repeated on the exact final commit.
