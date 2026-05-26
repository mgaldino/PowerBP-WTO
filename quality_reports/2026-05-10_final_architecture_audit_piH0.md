# Final Architecture Audit: Baseline pi_H = 0

Date: 2026-05-10

Superseded status note: this PASS record is no longer the current proof status
for the full baseline architecture. The later protocol discipline correction in
`quality_reports/2026-05-10_protocol_discipline_status_correction.md` retracts
the R1 pooling-or-delay branch to `pending protocol decision` because the
no-information delay continuation was not yet derived from a stated primitive.

Target: `model_redesign/power_architecture_derivations.Rmd`, section
`Verified Baseline Results`.

Auditor: independent analytical subagent.

Verdict: PASS without reservations.

## Scope

The audit checked the consolidated baseline architecture for the model in which
the hegemon has no proposal recognition in either bargaining round:

```text
pi_H = 0 in R1 and R2.
```

The audited claims cover:

- majority pass branch under weak-state agenda;
- unanimity R2 continuation values;
- unanimity R1 pooling-or-delay characterization;
- the collapse of the strict low-accepted/high-rejected R1 branch under the
  maintained accept tie-breaking convention;
- alpha = 0 outside-option-neutral stress test;
- entry and nesting;
- conditional institutional dominance for H;
- calibrated institutional classification for the OPEC parameters.

## Verdict

The auditor found the consolidated architecture faithful to the independently
verified results M1, U2, U1, E1, C1, I1, and S1. It found no substantive
overclaim, denominator error, payoff-correspondence error, or extrapolation
beyond the verified domain.

The reproducibility scripts `scripts/verify_baseline_*_piH0.R` ran and
reproduced the key numbers:

- OPEC majority pass feasibility is global;
- `mu_2^* = 0.072519`;
- R1 pooling feasibility ends at `mu = 0.372424`;
- the conditional dominance cutoff is `mu = 0.7`;
- `V_H^U = 0.2565` in the OPEC calibration;
- the minimum nesting gap is `0.021375`;
- the rent is zero when `alpha = 0`.

## Caveats To Preserve

The following caveats are not reservations against the result. They are the
frontier of the verified architecture and should be preserved in any external
packet or manuscript transport.

1. Majority remains a pass-branch result. Outside `P_M^F`, the majority
   delay/rejection branch has not been derived. The global OPEC conclusion is
   valid because `(M-F)` holds for every `mu in [0,1]` in the calibration.

2. The unanimity R1 characterization maintains acceptance in indifference.
   Without that convention, the aggressive low-accepted/high-rejected branch can
   reappear as a knife-edge selection, but not as a robust payoff-distinct
   branch.

3. The OPEC classification must be stated as follows: in `F_U`, unanimity is
   strictly preferred by H for `mu < 0.7`, majority is strictly preferred for
   `mu > 0.7`, and H is indifferent at `mu = 0.7`; in
   `F_M^{pass} \ F_U`, H is payoff indifferent absent an institutional
   formation tie-break.

4. The positive rent is ex ante and relative to H's expected outside option.
   The high type does not receive more than its undiscounted outside option
   when `beta <= 1`.

5. The alpha = 0 stress test shows that pivotality plus private information
   alone do not generate positive rent in this baseline. The positive rent
   requires the type-dependent outside option.

## Questions For External Review

These are useful questions for the next ChatGPT 5.5 Pro pass.

1. Is the no-information delay construction a PBE under the intended
   sequential/public voting protocol? In particular, what beliefs are required
   if a proposal fails by weak-voter rejection and H's action is or is not
   observed?

2. Is the exclusion of the low-accepted/high-rejected R1 branch robust to all
   PBE-consistent off-path beliefs under acceptance in indifference?

3. Does the nesting result use the right weak-state payoff concept under
   collective all-or-nothing entry, or would individual participation constraints
   require a different formation set?

4. Should the majority delay branch outside `P_M^F` be derived, or should the
   external packet preserve the pass-branch domain restriction?

5. In the paper prose, should `beta alpha r - alpha V_e(mu)` be called an
   informational rent, or should it be described more narrowly as an ex ante
   payoff premium from pooling relative to the expected outside option?
