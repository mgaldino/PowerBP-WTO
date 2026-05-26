# Fixed-pie R2 audit

Date: 2026-05-11

Status: local audit after fixed-pie correction.

## Verdict

PASS for the current R2 object in `model_redesign/power_architecture_derivations.Rmd`.

The prior state-dependent weak-pie residue has been removed from the active Rmd
and from `scripts/verify_relative_package_R2_piH0.R`.

## Checks performed

Searched the active Rmd, README, and R2 verification script for residues:

```text
V_e
Ve(
V(0)
V(1)
V(theta)
V(\theta)
r >
r>
r - tau
1.5
alpha
```

The only remaining `V_e`, `V(theta)`, or `r` mention in the active Rmd is the
ledger note stating that those prior formulas were deleted and must not be used.

## Current R2 primitives

```text
B = 1
weak coalition surplus after accepted y = 1 - y
theta affects H's participation threshold, not the weak coalition pie
0 <= tau0 < tau1 <= ybar <= 1
```

## Current R2 derived objects

```text
low-only payoff = (1 - mu) * (1 - tau0)
pooling payoff = 1 - tau1
mu2_star = (tau1 - tau0) / (1 - tau0)
```

The cutoff is derived, not primitive.

## Script verification

`scripts/verify_relative_package_R2_piH0.R` passed.

For the smoke-test parameters:

```text
tau0 = 0.19
tau1 = 0.285
mu2_star = 0.117283950617
```

The script includes the cutoff in the grid and verifies that conservative
tie-breaking selects low-only at the cutoff.

## Remaining caution before R1

R2 is now clean under the stated fixed-pie baseline. R1 should still not be
derived by importing any formula from the superseded state-dependent-pie
reports. The main R1 issue is protocol-specific: weak voters' R1 acceptance
constraints depend on voting order and on the posterior generated after `H`
rejects a candidate package.
