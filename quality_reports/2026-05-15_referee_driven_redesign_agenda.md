# Referee-driven redesign agenda

Date: 2026-05-15

Source report: `quality_reports/parecer_referee_tecnico_AJPS_formal_model.md`

Target workspace: `model_redesign/power_architecture_derivations.Rmd`

Manuscript status: `formal_model_v5.Rmd` remains frozen until the redesign is
proved, checked, and independently reviewed.

## Q&A

**What is the immediate purpose of this agenda?**  
Convert the AJPS-style technical referee report into a concrete redesign
checklist for the relative-package architecture.

**Should any referee criticism be treated as already resolved?**  
No. The current working assumption is that the referee saw the latest paper
version. All items below are treated as open until they are rederived, checked,
and reviewed in the redesign workspace.

**What is the substantive target?**  
Show that unanimity can generate informational power for a pivotal privately
informed hegemon even when the hegemon has no formal proposal power in the main
baseline.

**What is the formal target?**  
Replace the fragile fixed-transfer / feasibility-branch architecture with a
clean relative-package model in which proposals are always feasible and
screening comes from type-dependent participation thresholds:

```text
U_H(y, theta) = y + b_H(theta)
y_theta^*(mu') = beta C_H(theta, mu') - b_H(theta)
screening condition: y_1^*(mu') > y_0^*(mu')
```

## Operating constraints

1. Do not edit `formal_model_v5.Rmd` during this proof pass.
2. Work first in `model_redesign/power_architecture_derivations.Rmd`.
3. Keep computations in separate R scripts under `scripts/`.
4. Use new script names, preferably `scripts/verify_relative_package_*.R`.
5. Preserve the distinction between implementer and reviewer. Derivation and
   verification should not be done by the same agent or pass.
6. Do not import branch labels or theorem statements from the archived
   feasibility branch without rederiving them under the relative-package model.
7. Treat `pi_H = 0` as the main baseline. Treat `pi_H > 0` as an extension or
   robustness exercise.
8. Use the term `weak-vote-passive assessment` only as a maintained assessment,
   not as a refinement or characterization of all PBEs.

## Item 1: Equilibrium architecture

Referee problem: the equilibrium concept is insufficiently disciplined. The
`weak-vote-passive assessment` fixes off-path beliefs and candidate selection in
ways that materially affect payoffs.

Required work:

1. Specify the full extensive-form game:
   - players;
   - types;
   - recognition probabilities;
   - proposal space;
   - voting protocol;
   - information sets;
   - failure histories;
   - continuation values;
   - terminal payoffs.
2. Separate primitives from equilibrium objects.
3. Define the maintained assessment explicitly:
   - which weak-state deviations do not update beliefs over `theta`;
   - which `H` votes can update beliefs;
   - which failures are treated as uninformative;
   - which histories use Bayes' rule.
4. State the solution concept in modest language:
   - acceptable: selected outcome under maintained assessment;
   - acceptable: existence of a PBE supporting a selected payoff;
   - not acceptable without proof: uniqueness over unrestricted PBEs;
   - not acceptable without proof: characterization of all PBEs.
5. For every proposed result, provide complete strategies and beliefs.
6. Verify sequential rationality for all players at all relevant histories.
7. Verify Bayesian consistency wherever the history is on path.

Completion criterion: a reader can reconstruct the assessment, strategy profile,
belief system, and continuation payoff after any relevant proposal or voting
history.

## Item 2: R1 unanimity / Proposition 2 replacement

Referee problem: the current Proposition 2 compares candidates but does not
prove strategic exhaustion.

Required work:

1. Retire the old `P/L/R` result as a theorem statement until rederived.
2. Rebuild R1 unanimity under the relative-package primitives.
3. Define the candidate packages from thresholds:
   - pooling/high-threshold package;
   - low-only package;
   - continuation/rejection package.
4. Derive each candidate's weak-proposer payoff from primitives.
5. State when low-only is feasible and incentive-compatible.
6. Prove that the selected candidate is optimal under the maintained
   assessment, or weaken the claim to an existence/selection result.
7. Avoid any claim that no other PBE payoff exists unless the full unrestricted
   equilibrium set has been characterized.

Completion criterion: the new R1 result says exactly what is proved: payoff
selection under a maintained assessment, not global uniqueness.

## Item 3: Institutional choice and framing

Referee problem: the paper asks why a hegemon chooses consensus, but the model
does not contain a rule-choice stage by the hegemon.

Required work:

1. Decide whether the next version will:
   - add an institutional rule-choice stage; or
   - reframe the paper as conditional institutional preference.
2. If no rule-choice stage is added, revise the main claim to:
   - `H` may prefer unanimity conditional on institutional formation;
   - unanimity can favor `H` by making its private information pivotal;
   - the baseline isolates pivotality from proposal power.
3. If a rule-choice stage is added later, specify:
   - who proposes the rule;
   - who must consent to the rule;
   - whether entry is all-or-nothing;
   - how costs are paid;
   - how the selected rule affects subsequent bargaining.

Completion criterion: the title, abstract, propositions, and interpretation do
not claim that `H` chooses consensus unless the game actually contains that
choice.

## Item 4: Calibration and numerical examples

Referee problem: the main calibration is a boundary example that blocks strict
low-only separation.

Required work:

1. Do not use a boundary case as the central demonstration of screening.
2. Construct an interior numerical example in which:
   - `y_1^*(mu') > y_0^*(mu')`;
   - low-only is admissible for a nonempty belief interval, if the theory
     requires an active screening region;
   - pooling, low-only, and continuation regions are not artifacts of equality.
3. Reproduce all numerical thresholds in R.
4. Check open parameter neighborhoods, not only unilateral perturbations.
5. Label any non-empirical parameter exercise as an illustrative numerical
   example, not as an empirical calibration.
6. Document exact parameter values, source of any empirical discipline, and date
   accessed if public data or external sources are used.

Completion criterion: every numerical figure or table is reproducible, and the
central example demonstrates the mechanism it is used to illustrate.

## Item 5: Majority benchmark and institutional comparison

Referee problem: majority is cleaner than unanimity, but the benchmark scope and
complementary screening region are underdeveloped.

Required work:

1. Recompute majority under the relative-package protocol.
2. Keep `H`'s outside option external to the institutional pie.
3. State the new analogue of No-Cheap-H, if any.
4. Characterize the region in which majority excludes `H`.
5. Either characterize or explicitly bracket the region in which majority may
   also screen `H`.
6. Rebuild conditional dominance under the new model.
7. Rebuild entry/nesting under the new model.
8. Avoid selling fixed-pie nesting as a deep substantive result if it follows
   mechanically from normalization.

Completion criterion: the institutional comparison is stated with its exact
scope conditions, and the contrast between majority and unanimity does not rely
on an unexamined complementary region.

## Item 6: OPEC interpretation

Referee problem: the OPEC section currently works as motivation, not as
evidence or disciplined calibration.

Required work:

1. Treat OPEC as an interpretation of the mechanism unless parameters are
   empirically disciplined.
2. Explain that `pi_H = 0` is a clean benchmark that stacks the deck against
   Saudi agenda power.
3. Make Saudi Arabia pivotal and privately informed, not the formal agenda
   setter in the baseline.
4. Consider a majority-without-Saudi value parameter such as `rho < 1`.
5. Connect thresholds and outside options to observable or literature-based
   quantities if the text continues to use calibration language.
6. Avoid implying that majority without Saudi Arabia preserves the full
   coordination surplus unless that assumption is defended.

Completion criterion: the empirical interpretation no longer carries more
weight than the model and numbers can support.

## Item 7: Exposition, notation, figures, and robustness

Referee problem: several exposition choices make the formal result look stronger
than it is.

Required work:

1. Replace language like `selected Round-1 outcome` with language that states
   selection under the maintained assessment.
2. Keep these objects distinct:
   - direct agreement benefit: `b_H(theta)`;
   - outside or continuation payoff: `C_H(theta, mu')` or `o_H(theta)`;
   - dynamic threshold: `y_theta^*(mu')`.
3. Avoid ambiguous notation such as `a_0^1`; use a notation that encodes the
   posterior or continuation state directly.
4. Restrict Bayesian arguments to `mu in (0,1)` when endpoint beliefs create
   zero-probability type histories.
5. Revise figures so that they do not display a geometry stronger than the
   theorem being proved.
6. Report robustness as open neighborhoods when possible; when impossible,
   state that local robustness is limited.
7. Ensure all tables and figures are numbered and captioned before any result is
   transported to the manuscript.

Completion criterion: exposition, notation, and visual evidence match the exact
formal status of the result.

## Recommended execution order

1. Protocol and primitives.
2. Round-2 unanimity.
3. Round-1 unanimity.
4. Majority benchmark.
5. Conditional dominance.
6. Entry and nesting.
7. Numerical example and robustness checks.
8. OPEC interpretation.
9. Independent verification.
10. Manuscript transport only after verification has no material reservations.

## Minimum files expected from the redesign pass

1. `model_redesign/power_architecture_derivations.Rmd`
2. `scripts/verify_relative_package_R2.R`
3. `scripts/verify_relative_package_R1.R`
4. `scripts/verify_relative_package_majority.R`
5. `scripts/verify_relative_package_dominance.R`
6. `scripts/verify_relative_package_entry_nesting.R`
7. `scripts/verify_relative_package_calibration.R`
8. At least one independent review report under `quality_reports/`

## Stop conditions

Stop and label the result `pending protocol decision` if a proof requires a
voting history, off-path belief, recognition rule, continuation protocol,
tie-breaking rule, or information structure that is not already stated as a
primitive.

Stop and label the result `conjecture` if the algebra suggests a result but no
complete equilibrium strategy/belief verification has been written.

Stop and label the result `illustrative only` if a numerical example is not tied
to open parameter neighborhoods or empirical discipline.
