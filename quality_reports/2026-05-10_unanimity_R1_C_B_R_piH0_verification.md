# Independent Verification: C-B-R R1 Under pi_H = 0

Date: 2026-05-10

Final verdict: PASS without reservations.

## Iteration Record

First verification returned FAIL. The flaw was the weak-voter IC on the
high-state-only branch. The first draft treated a weak voter's rejection as if
it revealed the high state. That does not follow from the primitives because
weak voters are uninformed.

Correction implemented:

\[
\mu y+(1-\mu)\beta W_2^U(0)\geq \beta W_2^U(\mu),
\]

so

\[
y_B(\mu)=
\frac{\beta\{g(\mu)-(1-\mu)(1-\alpha)\}}{m\mu},
\]

and

\[
T_B(\mu)
=
\beta\alpha r
+
(m-1)\frac{\beta\{g(\mu)-(1-\mu)(1-\alpha)\}}{m\mu}.
\]

The corrected proposer payoff is

\[
B(\mu)=
\mu\{r-T_B(\mu)\}
+
(1-\mu)\frac{\beta(1-\alpha)}{m}
\]

when \(1<T_B(\mu)\leq r\).

## Final Verification

After correction, the independent analytical verifier returned:

> PASS sem ressalvas.

The verifier confirmed:

- the weak-voter IC is now the uninformed IC;
- \(T_B(\mu)\) correctly depends on \(\mu\);
- the protocol note correctly limits the result to mechanical low-state
  infeasibility;
- the OPEC regimes are \(P\) through \(\mu=0.372424\) and \(B\) afterward;
- entry/nesting and H's institutional comparison are updated coherently.

The reproducible script is
`scripts/verify_unanimity_R1_C_B_R_piH0.R`.
