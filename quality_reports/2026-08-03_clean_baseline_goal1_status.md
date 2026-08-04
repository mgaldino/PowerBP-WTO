# Goal 1 status: clean immediate-opt-out baseline

**Canonical specification:**
`quality_reports/plans/2026-08-03-clean-baseline-goal.md`

**Execution dates:** 2026-08-03--2026-08-04
**Current state:** the first independent Gate 0 audit returned `REPAIR` on
commit `3e3af6a907c6e64224df052032991ffa4f691dac`. The corrective candidate passes
its expanded mechanical checks and compiles; a new commit and independent
rereview are pending. Analytical results remain blocked until Gate 0 receives
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

## Gate 0: complete game contract -- REPAIR ROUND 1, REREVIEW PENDING

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
- common knowledge of the full contract and PBE as the solution concept, with
  the exact equilibrium scope required in every future result;
- ballot information sets indexed by both prior history and public proposal,
  and continuation values indexed by the full revealed history separately
  from its posterior;
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

Current result: `PASS`, 36/36 mandatory checks. Outputs:

- `tables/clean_optout_protocol_checks_piH0.csv`;
- `quality_reports/logs/verify_clean_optout_protocol_piH0.log`.

The first diagnostic run returned 25/26 because the dependency guard used an
overbroad regular expression: the phrase `read-only audit` was paired with a
later prose mention of `formal_model_v6.Rmd`. The guard was narrowed to actual
R read/source/include calls and all invariants then passed. No game primitive
was changed in response to that diagnostic.

The repair round added exhaustive/exclusive partition checks over every
admissible tuple for `N=3,...,60`, distinct full-history continuation checks,
and positive- and zero-implementation-probability controls for the terminal R2
IC.

### Diagnostic compilation

Command:

```r
rmarkdown::render(
  "model_redesign/power_architecture_derivations.Rmd",
  output_format = "all",
  clean = TRUE
)
```

Result: HTML and PDF created successfully. The repaired candidate PDF has 12
pages. An initial table-label mismatch and missing LaTeX equation labels were
repaired. A later visual check found the original 19-column PDF table clipped;
the canonical TSV remains a single exhaustive table, while the PDF now renders
the same rows and columns in four legible keyed panels. The repeated diagnostic
render completed without cross-reference or LaTeX warnings, and all four panels
were raster-inspected.

### Independent Gate 0 audit: round 1

- Reviewed commit: `3e3af6a907c6e64224df052032991ffa4f691dac`.
- Reviewer: independent read-only agent `/root/gate0_reviewer`; it made no
  edits.
- Verdict: `REPAIR`.
- Approved components: the G01--G21 partition is exhaustive and mutually
  exclusive; timing, recognition, quotas, implementation, budget closure,
  terminal payoffs, time units, opt-out irreversibility, and the two tie rules
  are correct. The reviewer independently reconfirmed the unchanged v6 hash.

| Finding | Severity | Implementer response | File/object | Test |
|---|---|---|---|---|
| Common knowledge and the PBE solution concept were not explicit | major | Added a dedicated common-knowledge/PBE section and required every result to state its equilibrium scope | derivation Rmd, Gate 0 | fixed markers plus rereview |
| Ballot ICs omitted the proposal from the information set and continuation payoff was incorrectly collapsed to the posterior | major | Defined `I=(h,s_i)` and full post-ballot `h2`; indexed vote distributions by `I`, continuation values by `h2`, and beliefs separately by `nu(h2)` | derivation Rmd; G02/G06 | full-history machine check plus rereview |
| The prose incorrectly said the R2 cutoff algebra required certain implementation | major | Derived `EU_yes-EU_no=beta*p*(y-o_theta)`; distinguished `p>0`, `p=0`, and the Goal's local `p=1` threshold statement | derivation Rmd | two R2 probability controls plus rereview |
| Checklist cited H-yes rows as no-reinclusion evidence and omitted post-opt-out rows | editorial | Corrected evidence to G03/G04, G07--G09, G12/G13, and G16--G21; post-opt-out evidence now cites G19--G21 | derivation Rmd checklist | textual inspection |
| Domain of `z` was implicit | editorial | Stated `z in {1,...,m}` | derivation Rmd history section | exhaustive partition check |

The same corrected state will be fixed in a new candidate commit and returned
to an independent read-only rereview. No analytical proof work has been
promoted during this repair round.

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
