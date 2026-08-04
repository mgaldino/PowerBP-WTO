# Goal 1 status: clean immediate-opt-out baseline

**Canonical specification:**
`quality_reports/plans/2026-08-03-clean-baseline-goal.md`

**Execution dates:** 2026-08-03--2026-08-04
**Current state:** **closure gates passed**. The extensive-form Gate 0 audit
returned `PASS` on commit
`fff4a35d1572c08bb2098cae9ad264a2eba80b41`. The repaired analytical candidate
`db52b2030b4c4e8e84c845a18ea04d4c2a27ab9c` then received independent
formal-model, adversarial game-theory, and R verdicts of **`PASS` without
substantive reservation**. Phase 1 preserves the Gate 0 contract and derives
explicit PBE-existence regions, nonexistence regions, boundary multiplicity,
one-sided prior limits, and a conditional institutional comparison. All six R
verifiers pass (96/96); the standalone HTML and PDF compile; and no protocol
change has been introduced.

## Scope guardrail

The work surface is
`model_redesign/power_architecture_derivations.Rmd`. The target manuscript
`formal_model_v6.Rmd` is read-only for this Goal. Its initial SHA-256 is
`f18a999300c88e32bdc7542f3249cd258afd19a0c251c0b29c2c387a7131dbc1`.
Its closing SHA-256 remains
`f18a999300c88e32bdc7542f3249cd258afd19a0c251c0b29c2c387a7131dbc1`,
identical to the initial hash.

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

## Gate 0: complete game contract -- PASS

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

### Independent Gate 0 audit: round 2

- Reviewed commit: `fff4a35d1572c08bb2098cae9ad264a2eba80b41`.
- Reviewer: the same independent read-only agent `/root/gate0_reviewer`; it
  made no edits.
- Verdict: **`PASS` without substantive reservation**.
- Findings: no critical, major, or minor substantive findings.
- Confirmed repairs: common knowledge and PBE scope; proposal-indexed ballot
  information sets; full-history continuation values separated from beliefs;
  correct R2 positive/zero implementation-probability algebra; corrected
  checklist evidence; and explicit `z` domain.
- Repeated evidence: G01--G21 exhaustive and mutually exclusive; 36/36 machine
  checks pass; the PDF is a valid 12-page document with resolved references;
  and the v6 SHA-256 remains unchanged.

Full round-1 and round-2 opinions are archived in
`quality_reports/2026-08-04_gate0_independent_audit.md`. No analytical proof
work was promoted before this PASS.

### Phase 1 existence audit

The first backward-induction pass overclaimed global nonexistence by applying
Bayes inside a globally off-path proposal. The three read-only derivation
agents challenged that step. The corrected audit in
`quality_reports/2026-08-04_clean_optout_pbe_existence_blocker.md` distinguishes
on-path Bayes from declared weak-PBE beliefs after zero-probability proposals.

On the regular interior domain, define

```text
P     = 1 - o1
delta = beta*(m - 1)/m
a     = 1 - delta
D_U   = 1 - o0 - delta*P
G_P   = a*P
G_L   = (1 - mu)*D_U
```

Unanimity has a global PBE iff `beta*o1>=o0` and `G_P>G_L`. The inequality is
strict because an off-path low-inclusion proposal ties with a lower H payoff at
equality but cannot satisfy the higher Bayes-consistent approval price after it
becomes on path. When the PBE exists, the unique on-path payoff class is
pooling: weak total `P` and H payoff `o1`. Regular low-only disappears because
of this payment-shaving deviation. The cases `o0=0` and `beta=1` restore
existence and multiplicity; `o1=1` with a positive low outside option and an
interior prior has no PBE.

For majority, define

```text
q   = floor(N/2) + 1
k   = q - 1
c   = beta/m
E   = 1 - k*c
B_M = (1 - mu)*(1 - o0) + mu*c
F_M = max(E, B_M, P)
```

The exact regular security value is `F_M`. Majority always has a PBE for
`N=3` and `N>=5`. For `N=4` it exists iff `E>=B_M` or `P>B_M`. Large groups
admit exclusion, separating current passage, and pooling under their stated
conditions, so majority no-screening is not an all-PBE theorem. The uniform
No-Cheap-H condition changes from `o0>=beta/m` to
`o0>=(q-1)*beta/m`, and even that does not remove large-group separation.

On the derived common regular PBE domain, `F_M>=P` and every majority PBE has
weak total at least `F_M`. Hence formation nesting
`F_U subseteq F_M` survives selection-free. H receives `o1` under unanimity
and between its expected outside payoff and `o1` under majority. The
classification is conditional on formation status and on the common PBE
domain; no global dominance is claimed.

## Phase 2 verifiers -- PASS

All scripts exit zero and label grid checks as computational evidence rather
than universal proofs:

- protocol: 36/36;
- R2: 8/8;
- R1 unanimity: 11/11;
- majority: 18/18;
- entry/classification: 10/10;
- boundaries: 13/13.

Outputs are versioned under `tables/` and logs under
`quality_reports/logs/`. The repaired total is 96/96. The independent R
rereview reproduced all 96 checks, verified byte-identical CSV outputs in a
temporary clone, and added 200,000 randomized stress checks; verdict `PASS`
without substantive reservation.

## Phase 3 first independent review -- REPAIR

The first fixed candidate was commit
`70969f5f14bdc63d557bc6d7d1e27bb3aa4c5304`. Three independent read-only
reviewers examined that same state and made no edits:

- formal-model: `/root/formal_final_reviewer`, `REPAIR`;
- adversarial game theory: `/root/adversarial_final_reviewer`, `REPAIR`;
- R: `/root/r_final_reviewer`, `REPAIR`.

The full opinions are archived in:

- `quality_reports/2026-08-04_clean_optout_formal_model_review.md`;
- `quality_reports/2026-08-04_clean_optout_adversarial_game_theory_audit.md`;
- `quality_reports/2026-08-04_clean_optout_R_review.md`.

| Finding | Implementer response | File/object | Verification |
|---|---|---|---|
| Unanimity security lemma lacked the guarantee direction | Separated upper-bound completions from `G_L` and `G_P` proposals and proved approval against every rational completion | derivation Rmd, regular U lemma | formal/adversarial rereview PASS |
| Off-path belief pair and solution-concept dependence were implicit | Retained the prior at the uninformed proposer ballot, declared the pooling continuation posterior, and stated that weak PBE does not impose within-subtree consistency | belief discipline and U lemma | adversarial rereview PASS |
| `mu=0,1` were promised but not derived | Chose the Goal-authorized one-sided-limit convention and derived `L_e^R` for U and M by group size, with ties and entry implications | new endpoint-limit section | boundary checks and rereview PASS |
| Boundary results lacked autonomous proofs | Derived exact security values `K_0` and `K_1`, completions, on-path classes, ties, overpaid pooling and all single-boundary intersections | U boundary section | 13/13 boundary checks; rereview PASS |
| Majority mixing and `[F_M,1]` sufficiency were implicit | Scoped pure support classes and constructed exclusion for every payoff, including the floor tie | majority `N>=5` section | formal/adversarial rereview PASS |
| R checks contained tautologies | Reconstructed ICs/payoffs from separate primitives and branch formulas; relabeled smoke checks honestly | five R scripts | 96/96; R rereview PASS |
| Majority proposal bounds sampled a biased 1.000-row prefix | Replaced it by the full 7.560-row grid | majority verifier | 18/18 |
| Logs lacked full provenance | Added inputs, row counts, output, execution HEAD, timestamps, status and `sessionInfo()` | five verifier logs | textual inspection; R rereview PASS |

No reviewer found a counterexample to the regular interior theorems. The
formal and adversarial reviews approved Gate 0, R2, the regular majority
characterization, conditional nesting/ranking, architecture separation and
the unchanged manuscript hash. Their objections concerned proof completeness,
endpoint scope and evidence quality; the repair does not alter a game
primitive.

## Phase 4 independent rereview -- PASS

All three independent read-only reviewers examined the same repaired candidate,
commit `db52b2030b4c4e8e84c845a18ea04d4c2a27ab9c`, and made no edits:

- formal-model reviewer `/root/formal_final_reviewer`: **`PASS`**, with no
  critical, major, or minor substantive finding;
- adversarial game-theory reviewer `/root/adversarial_final_reviewer`:
  **`PASS`**, with no critical, major, or minor substantive finding;
- R reviewer `/root/r_final_reviewer`: **`PASS`**, 96/96 reproducible checks,
  byte-identical CSVs in a clean temporary clone, and no substantive finding.

The full two-round opinions are archived in the three review reports listed
above. The reviewers' three purely editorial observations were also closed:
the overpaid-pooling range now states its upper contract bound explicitly; the
proposal-support/mixing scope for `N=3,4` is explicit; and the final proof
ledger records the independent PASS status. None changes a primitive, proof
condition, payoff correspondence, verifier, or machine-readable output.

## Final compilation and artifact validation -- PASS

Commands:

```sh
Rscript --vanilla scripts/verify_clean_optout_protocol_piH0.R
Rscript --vanilla scripts/verify_clean_optout_R2_piH0.R
Rscript --vanilla scripts/verify_clean_optout_R1_piH0.R
Rscript --vanilla scripts/verify_clean_optout_majority_piH0.R
Rscript --vanilla scripts/verify_clean_optout_entry_classification_piH0.R
Rscript --vanilla scripts/verify_clean_optout_boundaries_piH0.R
```

```r
rmarkdown::render(
  "model_redesign/power_architecture_derivations.Rmd",
  output_format = "all",
  clean = TRUE
)
```

All six scripts exit zero and the repaired suite passes 96/96. Both HTML and
PDF compile without material warnings. `pdfinfo` reports a valid, unencrypted
23-page letter-size PDF; `pdftotext -layout` succeeds and contains no unresolved
reference marker. The altered analytical pages 13--23 were raster-inspected:
equations, the endpoint table, survival matrix and proof ledger are legible,
with no clipping or overflow. The continued proof-ledger header on page 23 is
immediately followed by its remaining rows.

Final closure-artifact hashes:

```text
Rmd  8fbb7edff59fb0dc6fb36571564ec94d26e66b1211496ed10e9d9191ef2f68c6
PDF  f9c0641bd1cd486a50e62e8ede31445f3bbbd21f35311638cdbe5a645cabf28e
HTML 078aa67164ef611dfe8e8b987da21b850f078d0b7aae1c0a5138efdf7ede8572
v6   f18a999300c88e32bdc7542f3249cd258afd19a0c251c0b29c2c387a7131dbc1
```

## Closure gates -- PASS

- Gate -1 provenance and authorized annotated tag: PASS.
- Gate 0 formal closure: independent PASS.
- Clean `pi_H=0`, `b_theta=0`, immediate-`o_theta` analytical rederivation:
  proved or bounded exactly as scoped; independent PASS.
- Survival matrix: complete; independent PASS.
- R2, R1 unanimity, majority, entry/nesting, classification, and boundary
  verifiers: PASS, 96/96.
- Independent R rereview: PASS without substantive reservation.
- Final HTML/PDF compilation plus textual and visual validation: PASS.
- Independent formal-model and adversarial game-theory rereviews: PASS without
  substantive reservation.
- `formal_model_v6.Rmd` preservation: PASS; initial and closing SHA-256 are
  identical.

## Claim and architecture limits

- Delayed continuation, `max{o_theta,beta C_theta}`,
  `t_theta=d_theta-b_theta`, positive `pi_H`, endogenous rule choice, and the
  archived feasibility/C-B-R branch are not baseline results.
- No uniqueness, all-PBE characterization, or global institutional dominance
  is claimed outside the exact theorem scopes.
- Numerical checks will not be represented as universal proofs.
- The literal tie, action space, ballot, and weak-PBE solution concept are
  preserved. Parameter regions without PBE are reported as results rather than
  removed by a new protocol.
