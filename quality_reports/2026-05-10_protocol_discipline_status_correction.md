# Protocol Discipline Status Correction

Date: 2026-05-10

## Status

The previous `pi_H = 0` baseline packet is superseded as a verified theorem
packet.

## Reason

The R1 unanimity pooling-or-delay characterization used a no-information delay
payoff

```text
R(mu) = beta g(mu) / m
```

as if the proposer could always reach Round 2 without revealing H's type. That
continuation is algebraically well-defined conditional on such a history, but
the history itself was not stated as a primitive of the original extensive-form
game.

Therefore the result cannot be treated as a verified equilibrium
characterization. Pooling, delay, rejection histories, and off-path beliefs must
be derived from the stated protocol. They may not be imposed inside a proof.

## What Remains Verified

- The majority pass-branch accounting under `pi_H = 0`.
- The unanimity R2 continuation calculation, subject to explicit domain and
  contract-space restrictions.
- The warning that the strict low-accepted/high-rejected R1 branch collapses to
  a tie under the maintained acceptance-in-indifference convention.

## What Is Pending

- R1 unanimity equilibrium characterization.
- Whether any no-information delay path is endogenous under the intended BF
  protocol.
- Entry/nesting, conditional dominance, and institutional classification under
  the corrected R1 protocol.

## New Rule

Do not introduce a strategic option, voting history, tie-breaking convention,
information structure, contract space, or continuation protocol inside a proof
unless it is already a stated primitive. If a derivation requires such an
object, stop, label the result `pending protocol decision`, explain the
substantive consequence to the user, and obtain explicit approval before
proceeding.

