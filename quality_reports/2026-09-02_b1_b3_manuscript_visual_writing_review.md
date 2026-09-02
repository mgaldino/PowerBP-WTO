# Independent manuscript-integration, formal-writing, and PDF review: B.1/B.3

**Verdict:** `PASS`

**Finding counts:** `CRITICAL 0 / IMPORTANT 0 / MINOR 0`

**Reviewer role:** independent reviewer; no source or candidate artifact was edited.

**Methodological lenses:** `formal-model-writing` (Thomson / Board and
Meyer-ter-Vehn) and `pdf` visual-integrity review.

**Independence statement:** I did not read the other manuscript-integration
review. This report evaluates the immutable candidate directly against the
approved derivation memorandum and the pre-migration tag.

## 1. Immutable review boundary

| Artifact | Verified SHA-256 / identity |
|---|---|
| `formal_model_v6.Rmd` | `7de0b2eddc20b98509f8fa37a299860f83164b7469097598532aa5cbfbd7a2a7` |
| `formal_model_v6.pdf` | `97ff2d5fa3878550a5b6ea77c642b99ad4543aec760e92ff7941495ea552ed00` |
| `quality_reports/2026-09-01_b1_b3_exclusion_derivation.md` | `2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256` |
| candidate commit | `03ab370cce3f06725d805054e6796a8e78e674b0` |
| pre-migration annotated tag | `v6-pre-b1-b3-exclusion-migration-2026-09-02` |
| commit peeled from that tag | `8be463f24e3012b75cd76623e167ac3ba1ed7904` |

`shasum -a 256 -c
quality_reports/2026-09-02_b1_b3_manuscript_migration_manifest.sha256`
returned `OK` for all four listed artifacts. The manifest therefore binds the
same bytes reviewed here.

## 2. Scope and method

I performed the following checks:

1. Read all 2,648 lines of `formal_model_v6.Rmd`, with particular attention to
   the model primitives, ballot and payoff rules, solution concept,
   Propositions 5.1--5.4, Appendices A.1--A.2, and B.1--B.4.
2. Compared commit `03ab370` with the peeled pre-migration tag. The Rmd diff is
   confined to 35 inserted and 14 deleted lines: the terminal-majority opening
   of B.1 and the opening/reduction paragraphs of B.3. No proposition,
   primitive, formula outside those proof passages, figure, table, citation,
   or cross-reference was changed.
3. Compared the migrated wording with Sections 5.4 and 6.5 of the approved
   derivation memorandum. The B.1 paragraph, the B.3 three-case paragraph, and
   the B.3 transition to the four candidates reproduce the approved English
   text without a substantive departure.
4. Checked the Rmd for the superseded expression `x_H+o` (including the spaced
   form): zero occurrences. `git diff --check` returned no error.
5. Parsed the PDF with Poppler and `pypdf`, extracted its complete text, and
   rendered pages 36--38 at 180 dpi. I additionally rendered pages 35 and 39
   to inspect the transitions from A.2 into B.1 and from the beginning of B.4
   to its continuation.

The `qpdf` executable was unavailable. This is not a defect in the candidate:
`pdfinfo` reported `Suspects: no`, and independent parsing with `pypdf`
successfully traversed every page and resource dictionary.

## 3. Formal structure relevant to the migration

The baseline has one privately informed hegemon, \(H\), and \(m\geq3\) weak
states. A recognized weak proposer chooses a nonnegative allocation from a
unit pie; the proposer votes yes and all responders vote simultaneously. The
public vote vector is observed only after the ballot. Under majority the
proposer needs \(k=\lfloor(m+1)/2\rfloor\) additional yes votes; under
unanimity every state must vote yes. If a majority passes without \(H\), \(H\)
receives only its outside option \(o\in\{\ell,h\}\), while \(x_H\) is paid to
no one. Failure in Round 1 leads to the discounted terminal game. The solution
concept is PBE in pure ballot strategies with structural consistency,
as-if-pivotal weak voting, yes at expected-value indifference, and the declared
proposal tie-break.

This structure is stated consistently in the model section and Appendix A.1.
Appendix A.2 supplies the ballot rule needed by both migrated proofs.

## 4. Integration and proof-writing assessment

### B.1 and Propositions 5.1--5.2

The migrated B.1 passage correctly establishes that there are \(m-1\) weak
responders and that
\(k=\lfloor(m+1)/2\rfloor\leq m-1\) for \(m\geq3\). It then separates two
objects that the old wording conflated:

- the nonpivotal ballot response, under which \(H\) compares \(x_H\) after yes
  with \(o\) after no and therefore votes yes exactly when \(x_H\geq o\); and
- the proposer's optimization, under which every \(x_H>0\) is strictly
  dominated by moving that amount to the proposer's own allocation while
  preserving all weak ballots and passage.

The additional observation that positive terminal payments to weak responders
can be reduced to zero is valid under the indifference-to-yes convention. The
result is exactly the outcome stated in Propositions 5.1 and 5.2: \(x_H=0\),
zero weak-responder payments, the whole pie to the proposer, passage without
\(H\), and payoff \(o\) to \(H\). The prose names the decision maker, action,
object, and consequence at each step; it removes the ambiguity that motivated
the repair.

### B.3 and Proposition 5.3

The revised proof gives an exhaustive partition by the number \(n_Y\) of weak
yes votes:

- if \(n_Y\geq k\), \(H\) is nonpivotal, compares \(x_H\) with \(o\), and the
  proposer's strict dominance argument leaves only \(x_H=0\);
- if \(n_Y=k-1\), \(H\) is pivotal and compares \(x_H\) with the correctly
  dated terminal-majority continuation \(\beta o\);
- if \(n_Y\leq k-2\), the proposal fails after either ballot action, the
  terminal-majority payoff is belief-free, and the declared
  indifference-to-yes convention selects yes.

The following paragraph cleanly distinguishes the nonpivotal dominance result
from the pivotal threshold reductions \(x_H=\beta\ell\) and
\(x_H=\beta h\). This supports the same four candidates
\(E,S,P,\) and delay, with the same payoff formulas and cutoffs reported in
Proposition 5.3. The proof does not falsely claim invariance of the complete
off-path strategy correspondence; it establishes only the unchanged reported
outcome classes and multiplicities.

### Consistency with A.1--A.2 and downstream text

The revised passages use the mutually exclusive payoff rule in A.1: passage
with a yes vote pays \(x_H\); passage without \(H\) pays \(o\) and leaves
\(x_H\) undistributed; failure invokes continuation. They also implement A.2's
yes-at-indifference rule in all three B.3 cases. The terminal-majority outcome
is belief-independent, so the pivotal threshold \(\beta o\), the weak threshold
\(w=\beta/m\), and the failure-inevitable indifference statement are mutually
consistent.

B.2's reference to B.1 remains valid. B.4 begins after a complete B.3 proof
and is substantively untouched. Propositions 5.1--5.4 and their rendered
references appear as 5.1--5.4, with no unresolved reference marker.

## 5. Scoped Thomson / Board scorecard

| Dimension | Verdict | Integration-specific assessment |
|---|---|---|
| D2. Model presentation | Excellent | The proof uses the already defined players, actions, information, payoffs, timing, and solution concept without introducing a second model. |
| D3. Notation | Excellent | \(H,x_H,o,m,k,n_Y,w,\beta,\ell,h\) retain one meaning each and are used consistently with the main text and Appendix D. |
| D4. Definitions | Adequate | No new primitive is introduced; \(n_Y\) is defined immediately before use and the three cases are exhaustive. |
| D5. Result statements | Excellent | The migrated proofs establish exactly the outcomes stated in Propositions 5.1--5.3 and do not enlarge their claims. |
| D6. Proofs | Excellent | The deviation, payoff comparisons, case partition, timing, and tie-break are expressed in natural-language steps with the mathematical thresholds visible. |
| D7. Figures and diagrams | Not applicable to this migration | No figure was changed; the proof transition and surrounding appendix hierarchy render correctly. |
| D8. Assumptions and logical structure | Excellent | The proof invokes \(m\geq3\), nonnegativity, the unit-pie constraint, ballot quotas, continuation dating, and tie-breaks exactly where needed. |
| D9. Examples and applications | Not applicable to this migration | These proof repairs require no new example and do not alter the paper's numerical illustration. |

### Affected-notation inventory

| Symbol | Meaning in the reviewed passages | Status |
|---|---|---|
| \(H\) | informed hegemon and voter | Consistent |
| \(x_H\) | actor-specific allocation paid only if \(H\) joins | Consistent |
| \(o\in\{\ell,h\}\) | type-contingent outside option | Consistent |
| \(m\) | number of weak states | Consistent |
| \(k=\lfloor(m+1)/2\rfloor\) | additional yes votes required under majority | Consistent |
| \(n_Y\) | weak responders voting yes at the current proposal | Defined before use |
| \(w=\beta/m\) | Round-1 weak-vote threshold under majority | Consistent |
| \(\Pi_E,\Pi_S,\Pi_P\) | proposer payoffs under exclusion, screening, and pooling | Unchanged and consistent |

## 6. PDF integrity and visual review

`pdfinfo` reports a 67-page, unencrypted PDF 1.7 with uniform letter pages
(612 by 792 points), zero rotation, and no suspect structure. `pypdf` confirms
67 readable pages, identical media boxes, a resource dictionary on every
page, 108,147 extracted text characters, and no blank or nearly blank page.
The complete extraction reaches the closing references on page 67.

Pages 36--38 contain the complete affected material:

- page 36: the end of A.2, the Appendix B heading, and all of B.1;
- page 37: B.2 and the revised opening/reduction of B.3;
- page 38: the remainder of B.3 and the beginning of B.4.

At original-resolution inspection, these pages have no clipping, overlap,
missing glyph, black box, crowded margin, malformed equation, or broken
hierarchy. The floor operator, inequalities, subscripts, Greek letters,
payoff symbols, and proof-ending squares all render legibly. The page break in
B.3 occurs after the four candidates have been named and resumes with
"Exclusion is always feasible"; it does not separate a heading from its text
or strand a mathematical operator. B.4 begins with sufficient text and its
first display on page 38 and continues normally on page 39. Centered page
numbers and margins remain consistent.

Text extraction from pages 36--38 contains the new responder count, the
nonpivotal comparison \(x_H\) versus \(o\), the strict transfer-to-proposer
argument, all three \(n_Y\) cases, the pivotal threshold \(\beta o\), and the
transition to the four candidates. Thus the visible PDF corresponds to the
reviewed Rmd rather than to the superseded proof.

## 7. Findings

### CRITICAL

None.

### IMPORTANT

None.

### MINOR

None.

## 8. Final verdict and authority boundary

`PASS — CRITICAL 0 / IMPORTANT 0 / MINOR 0`.

The migration is faithful to the approved memorandum, technically coherent
with the model and the affected propositions, clear in English, and visually
sound in the compiled PDF. This PASS applies only to the immutable bytes and
identities recorded in Section 1. It does **not** authorize merge, push,
promotion to `main`, or a final tag.
