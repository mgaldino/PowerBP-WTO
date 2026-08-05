# Goal 3 Status — Simultaneous-Ballot PBE-UD Repair

**Date:** 2026-08-04
**Status:** CLOSED
**Entry tag:** `pre-undominated-voting-repair-2026-08-04`
**Protected entry commit:** `8692a6b31539d117134a580009d4e4dbe783403d`
**Final reviewed candidate:** `5bd7fbe47f63f6b94ca4085852596f1d4ad9901c`

## Outcome

The clean `pi_H=0` baseline has been rederived under PBE plus local
admissibility of weakly undominated ballot actions. Every ballot remains
simultaneous and sealed; the complete vote vector becomes public only after
closure. No public voting order or order of `H` exists anywhere in the result.

The user's distributed-pie restriction is implemented as a separately named
**coalition-pure PBE-UD** baseline:

- intended winning support is inclusion-minimal;
- every weak outsider receives zero;
- every necessary supporter receives at least continuation;
- equality at continuation preserves both admissible ballot actions;
- unrestricted gift proposals remain feasible deviations and are never erased
  from proposer optimality.

Thus the baseline has no payments to countries outside the winning coalition,
while the proof still checks whether such an offer could profitably upset a
candidate equilibrium. If only a non-coalition-pure gift proposal maximizes,
the coalition-pure correspondence is empty under that assessment.

## Main formal findings

- Terminal correspondences are proposal-contingent and require attainment;
  weak support and `H` acceptance are handled separately.
- In the regular majority game with `N>=4`, equilibrium existence is governed
  by the new exclusion, low-only, and pooling gates; existing outcomes are
  payoff-equivalent to exclusion.
- `N=3` has a separate proposal-complete cap correspondence and can exhibit
  unrestricted gift outcomes that are excluded from the coalition-pure
  baseline.
- Regular unanimity requires `bar_y>o_1` and the derived prior threshold;
  strict pooling, weak mixing, and semi-pooling are characterized without exact
  threshold voting being imposed.
- On the common regular existence domain, weak states strictly prefer majority
  and their formation set properly contains the unanimity set; `H` weakly
  prefers unanimity.
- Boundary and one-sided-limit results are reported separately from regular
  theorems.

## Reproducible evidence

| Object | Result |
|---|---:|
| Gate 0 finite-ballot checks | 137/137 PASS |
| Regular-domain checks | 10086/10086 PASS |
| Boundary checks | 2882/2882 PASS |
| Generated analytical CSVs | 6/6 byte-identical |
| PDF visual audit | 21/21 pages PASS |
| Independent final reviews | 3/3 PASS |

The final artifact hashes are:

```text
Rmd   2f6d77a61210fe85a8dca8f589f17e06b149c55a520668b08c87932ef0925aa2
PDF   c4cdcd500425c96b8a3d0286713d3b1dce17a3aa49a71a615e057002628a433d
HTML  d3bf56d56f8bce4bd13e6dffa88db92c2a732139163f2bf8c11dd05e689e1eee
```

## Protected artifacts

The following hashes equal the entry snapshot, and the files have no diff from
the protected commit:

```text
formal_model_v6.Rmd
131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d

formal_model_v6.pdf
a7d36d5a1fb2d15ba0e40509ad846fbf001b5960232fcbf011d5b32bec298bdf

model_redesign/power_architecture_derivations.Rmd
8fbb7edff59fb0dc6fb36571564ec94d26e66b1211496ed10e9d9191ef2f68c6
```

No v5/v6 file was edited or compiled. No push was performed.

## Independent review ledger

- BF/formal: PASS without substantive reservation.
- Adversarial game theory: PASS without substantive reservation.
- R/reproducibility/PDF: PASS without substantive reservation.

All three reviewers were read-only and reviewed the exact same candidate. The
closure documents added afterward change no formula, script, generated table,
HTML, or PDF from that reviewed candidate.

## Next authorization boundary

Migration to `formal_model_v6.Rmd` is not part of Goal 3. It may begin only
after a separate Goal 4 authorization, using the impact matrix and handoff
plan. A new versioning gate and fresh independent manuscript reviews are
required.
