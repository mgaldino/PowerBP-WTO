# Goal 1 status: clean immediate-opt-out baseline

**Canonical specification:**
`quality_reports/plans/2026-08-03-clean-baseline-goal.md`

**Execution dates:** 2026-08-03--2026-08-04
**Current state:** Gate 0 candidate fixed locally; independent extensive-form
audit pending. Analytical results remain blocked until that audit returns
`PASS` without substantive reservation.

## Scope guardrail

The work surface is
`model_redesign/power_architecture_derivations.Rmd`. The target manuscript
`formal_model_v6.Rmd` is read-only for this Goal. Its initial SHA-256 is
`f18a999300c88e32bdc7542f3249cd258afd19a0c251c0b29c2c387a7131dbc1`.
The final hash will be recorded before closure.

## Gate -1: provenance and snapshot -- PASS

- Git root: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion`.
- The pre-reset worktree was clean.
- Baseline commit:
  `84a644128586d4f4d81c022cd7d3e09454ee8004`.
- User-approved annotated tag:
  `pre-clean-optout-goal1-2026-08-03`.
- Tag message: `Pre-Goal-1 snapshot before clean immediate-opt-out baseline
  reset`.
- The tag resolves to the baseline commit above.

## Gate 0: complete game contract -- CANDIDATE, REVIEW PENDING

### Implemented contract

The candidate specification fixes, without presuming equilibrium results:

- two rounds, with R2 terminal;
- `pi_H=0` in every round and uniform recognition `1/m` among weak states;
- a common simultaneous public ballot under unanimity and majority;
- `b_0=b_1=0`, current agreement payoff `y`, and an immediate irreversible
  type-specific opt-out `o_theta` after an H-no vote;
- a distinct H-yes/weak-failure continuation in which H remains active;
- the original majority quota after opt-out and no weak-only unanimity
  continuation;
- conditional reabsorption of `y` by the proposer in a majority agreement
  that excludes H, with the outside option external to the unit pie;
- expected voting ICs over simultaneous vote vectors, with the direct cutoff
  `y=o_theta` restricted to certain-implementation information sets;
- public-history beliefs, Bayes updating where applicable, and the maintained
  weak-vote-passive assessment;
- only the two authorized tie rules.

The versioned history source
`tables/clean_optout_gate0_histories_piH0.tsv` contains 21 exhaustive history
classes (G01--G21) and all required timing, implementation, payoff, belief,
and continuation fields.

### Gate 0 machine checks

Command:

```sh
LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
  Rscript --vanilla scripts/verify_clean_optout_protocol_piH0.R
```

Result: `PASS`, 26/26 mandatory checks. Outputs:

- `tables/clean_optout_protocol_checks_piH0.csv`;
- `quality_reports/logs/verify_clean_optout_protocol_piH0.log`.

The first diagnostic run returned 25/26 because the dependency guard used an
overbroad regular expression: the phrase `read-only audit` was paired with a
later prose mention of `formal_model_v6.Rmd`. The guard was narrowed to actual
R read/source/include calls and all invariants then passed. No game primitive
was changed in response to that diagnostic.

### Diagnostic compilation

Command:

```r
rmarkdown::render(
  "model_redesign/power_architecture_derivations.Rmd",
  output_format = "all",
  clean = TRUE
)
```

Result: HTML and PDF created successfully. The candidate PDF has 8 pages.
An initial table-label mismatch and missing LaTeX equation labels were repaired;
the repeated diagnostic render then completed without cross-reference or
LaTeX warnings.

### Independent Gate 0 audit

Pending. The specification, history table, verifier, generated checks, and
status record must first be fixed in a candidate commit. A read-only reviewer
who did not edit these files will then audit timing, actions, information,
recognition, quotas, implementation, budgets, terminal payoffs, time units,
beliefs, and incentive-constraint definitions. No analytical proof work will
be promoted before a `PASS` on that commit.

## Later phases -- BLOCKED BY GATE 0

- Clean analytical rederivation: pending.
- Survival matrix: pending.
- R2, R1 unanimity, majority, entry/nesting, classification, margins, and
  robustness verifiers: pending.
- Independent R review: pending.
- Final HTML/PDF textual and visual validation: pending.
- Independent formal-model and adversarial game-theory reviews: pending.

## Claim and architecture limits

- Delayed continuation, `max{o_theta,beta C_theta}`,
  `t_theta=d_theta-b_theta`, positive `pi_H`, endogenous rule choice, and the
  archived feasibility/C-B-R branch are not baseline results.
- No uniqueness, all-PBE characterization, or global institutional dominance
  is currently claimed.
- Numerical checks will not be represented as universal proofs.
- There is no `pending protocol decision` in the Gate 0 candidate; the
  independent audit remains authoritative on whether the contract is complete.
