# Goal 2 / N4 — formal-design review, round 3

- Role: `formal_design`
- Reviewer agent: `01a017fd-3fca-7911-aded-79bcafc28fa1`
- Interface: `sha256:cc63ec861c391223f868de16f234e7e7e3ffe475e73a97f3a2118d9e1df36b44`
- Derivation: `sha256:1ed5d5915eeec920bc04c2c547c729fd4951b993c9126c485f2a29ff0d682983`
- Ledger: `sha256:1a11de2b11de7ee388a61b66493120b51ed9d1e50883fc4a27bfd133b9148e9e`
- Verifier: `sha256:086f44f799ddeef1744ab806df9ae674f34e2c3212f3093e1262625b96a6b38b`
- Frozen N2: `sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`
- Contract: `sha256:368b09eace9b1c2e68ffdcc61e6583dbc060591f1faf627f93919bae79e2241a`
- Verdict: **FAIL**
- Finding counts: `critical=1, major=0, minor=0`

The reviewer was read-only and changed no file.

## Critical finding

The forced-passage lemma is false for `m>=3`. With at least two weak
nonproposers voting no, each is nonpivotal. A low posterior after the prescribed
multiple-no vector gives `a0`; a high posterior after one rejecting voter
deviates to yes still leaves another no and gives `z<a0`. Hence each no is
strict and undominated regardless of its proposed `x_j`. `T^Y` does not remove
the strict no, and both H types can be supported on yes once weak rejection
already blocks passage.

Consequently, paying every weak voter at least `a0` does not force passage for
`m>=3`; the candidate's global `Q`, `K`, and `A` lower bounds and the resulting
pooling, delay, none, endpoint, and coverage claims fail. The previous `m=2`
counterexample is correctly retained; the defect is precisely the omitted
multiple-rejector construction for `m>=3`.

N4 remains pending and was not frozen.
