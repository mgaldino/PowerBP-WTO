# Goal 2 status — clean baseline migration to formal_model_v6.Rmd

**Date:** 2026-08-04
**Goal:** migrate and audit the coherent clean immediate-opt-out baseline in
formal_model_v6.Rmd.

## Provenance and gates

| Object | Identifier / status |
|---|---|
| Closed analytical baseline | 4467da58f99b1cf75b22e5bfca1a08ccf80d9be1 |
| Pre-session documentary state | 148cd9c5a3432ace08f9d7c1d975d01434bf08fa |
| Goal 1 tag | pre-clean-optout-goal1-2026-08-03 |
| Goal 2 matrix/specification commit | 90ebbcafef8258f91644b24e9859972613bf9b27 |
| User-approved pre-migration tag | pre-clean-optout-goal2-migration-2026-08-04 |
| Annotated-tag object | 94d60b0b6d6275c97f578f0a9bd083a6e4f78efe |
| Tag target | 90ebbcafef8258f91644b24e9859972613bf9b27 |
| Initial migration commit | 2635d1bd40765973b45e215a621d462f6635b148 |
| Gate 0 repair commit | b5a6791a250cd488dff27b1d19ed44e16bb954a0 |
| Final reviewed candidate | 1b8bda6fb6906391c65fb6425b781c123d5948be |
| Pre-migration Rmd SHA-256 | f18a999300c88e32bdc7542f3249cd258afd19a0c251c0b29c2c387a7131dbc1 |
| Final Rmd SHA-256 | 131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d |
| Final PDF SHA-256 | a7d36d5a1fb2d15ba0e40509ad846fbf001b5960232fcbf011d5b32bec298bdf |

The worktree was clean before the user-approved tag. The tag was created
before any edit to formal_model_v6.Rmd.

## Migration matrix gate

The migration matrix is
quality_reports/2026-08-04_clean_baseline_goal2_migration_matrix.md.
Its independent survival rereview returned **PASS without substantive
reservation** before the manuscript was edited.

## Baseline transported

- pi_H=0 in both rounds;
- b_0=b_1=0;
- current payoff of H equals y when an implemented agreement includes it;
- an H-no in Round 1 produces immediate, irreversible opt-out and undiscounted
  o_theta;
- an H-yes followed by weak-caused failure keeps H active and can lead to
  Round 2;
- simultaneous voting within every ballot, with the complete vector revealed
  only after closure;
- the outside payoff of H is external to the unit institutional pie;
- weak PBE under the weak-vote-passive assessment;
- collective, all-or-nothing weak-state formation;
- institutional comparisons only on the derived common PBE-existence domain.

## Main substantive changes

1. Replaced the old t_theta and dynamic-threshold contract with the clean
   immediate-opt-out extensive form.
2. Replaced the global P/L/D and rejected-history architecture with the exact
   security-value and off-path completion result.
3. Stated the regular unanimity existence theorem:
   beta*o_1 >= o_0 and G_P > G_L; every existing regular on-path outcome
   pools at y=o_1.
4. Replaced the unique majority no-screening benchmark with the exact
   group-size-dependent equilibrium correspondence and F_M=max{E,B_M,P}.
5. Replaced the old payoff-gap crossing with selection-free entry nesting and
   the bound bar o <= E[u_H^M] <= o_1=E[u_H^U].
6. Separated o_0=0, o_1=1, beta=1, majority boundary bounds, and one-sided
   prior limits from the regular interior theorem.
7. Rebuilt the timing figure, result-scope table, four 21-history panels,
   endpoint table, and notation table with numbered captions.
8. Removed the worked calibration, phase diagram, old sweep, complete-
   information benchmark, delayed-continuation microfoundation, and obsolete
   figures/chunks from the active baseline.

## Compilation

The manuscript was compiled using the YAML/bookdown definition:

    rmarkdown::render("formal_model_v6.Rmd")

The final reviewed candidate compilation exited successfully without undefined
references. The PDF has 32 pages, letter page size, six embedded/subsetted
Unicode-capable fonts, and extractable text.

## Reproducible validation

| Validation | Result |
|---|---:|
| Gate 0 protocol | 36/36 PASS |
| Terminal R2 | 8/8 PASS |
| Regular R1 unanimity | 11/11 PASS |
| Regular majority | 18/18 PASS |
| Entry and classification | 10/10 PASS |
| Boundaries | 13/13 PASS |
| Goal 2 source/PDF migration audit | 14/14 PASS |
| **Total** | **110/110 PASS** |

The Goal 2 validator is scripts/verify_clean_optout_goal2_migration.R. Its
machine-readable output is tables/clean_optout_goal2_migration_checks.csv; its
execution log is
quality_reports/logs/verify_clean_optout_goal2_migration.log.

## PDF inspection

All 32 pages were rasterized and inspected. An independent first pass found a
clipped monospaced TSV path on page 16. Commit
1b8bda6fb6906391c65fb6425b781c123d5948be moved that path to a centered
standalone line and the same reviewer repeated the complete audit. The final
PDF has no clipping, overlap, missing glyph, unreadable cross-reference,
broken table, or caption failure. The four history panels remain landscape
audit tables and intentionally display the versioned contract entries
literally.

## Independent review status

- Formal-model review: **PASS without substantive reservation**.
- Adversarial game-theory audit: **PASS without substantive reservation**.
- Independent reproducibility and PDF audit: **PASS without substantive
  reservation**.

All three independent gates reviewed the exact candidate
1b8bda6fb6906391c65fb6425b781c123d5948be and returned PASS without
substantive reservation. Goal 2 is closed.

## Deliberate limitations

- Weak PBE permits distinct beliefs at globally off-path information sets
  within an off-path subtree; no sequential-equilibrium robustness claim is
  made.
- Majority is set-valued and the comparison is conditional on common PBE
  existence and formation.
- No new numerical illustration is promoted. A future illustration requires
  its own versioned R script and independent review.
- Delayed continuation after an H-no, hybrid exit, positive recognition for H,
  endogenous rule choice, sequential roll-call voting, continuous types, and
  the archived feasibility/C-B-R branch remain outside the baseline.
