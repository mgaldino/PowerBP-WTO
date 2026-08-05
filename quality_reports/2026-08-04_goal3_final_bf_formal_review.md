# Independent BF/Formal Review — Goal 3

**Date:** 2026-08-04
**Reviewed commit:** `5bd7fbe47f63f6b94ca4085852596f1d4ad9901c`
**Mode:** independent and read-only
**Rmd SHA-256:** `2f6d77a61210fe85a8dca8f589f17e06b149c55a520668b08c87932ef0925aa2`
**PDF SHA-256:** `c4cdcd500425c96b8a3d0286713d3b1dce17a3aa49a71a615e057002628a433d`

## Verdict

**PASS — no substantive reservation.**

The final review confirmed that coalition purity restricts only on-path
outcomes: winning support is inclusion-minimal, weak outsiders receive zero,
and necessary supporters receive at least continuation. Gifts remain feasible
in the unrestricted proposal space and therefore remain in every proposer
deviation test.

The reviewer separately verified:

- terminal unanimity at the cap, including partial weak passage,
  high-type mixing, zero-value rejection, attainment, and total weak payoff;
- the proposal-complete `N=3` majority cap correspondence `Q_x(kappa)`;
- the `beta=1` residual, which subtracts every named offer, including an offer
  to a forced-no outsider;
- support enumeration, suprema, attainment, and the iff existence statements;
- simultaneous sealed ballots with no order of `H`.

The `N=4`, `beta=1` regression with an outsider gift of `1/50` gives proposer
value `441/1000`, below the low-only value `9/20`, while the canonical
coalition-pure package gives `46/100`.

Read-only diagnostics returned Gate 0 `137/137`, regular `10086/10086`, and
boundaries `2882/2882` PASS. Independent numeric identities had maximum error
`1.11e-16`. The worktree remained clean.

## Repair history

The first review cycle exposed incomplete terminal-attainment and boundary
accounting. A later pass exposed omission of outsider offers from the general
residual. The implementer repaired those points in commits `4e5c433` and
`5bd7fbe`; the reviewer then repeated the complete read-only audit on the exact
final candidate.
