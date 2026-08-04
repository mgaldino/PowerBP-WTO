# Independent Formal-Model Review — Goal 2 Migration

**Date:** 2026-08-04
**Reviewed commit:** 1b8bda6fb6906391c65fb6425b781c123d5948be
**Rmd SHA-256:** 131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d
**PDF SHA-256:** a7d36d5a1fb2d15ba0e40509ad846fbf001b5960232fcbf011d5b32bec298bdf
**Reviewer status:** three independent, read-only reviewers; none edited files.

## Editorial decision

**PASS — no substantive reservation.**

The migrated manuscript cleanly isolates informational power through
pivotality under weak-state agenda control. Its extensive form, beliefs,
result domains, proofs, boundary cases, and conditional institutional
comparison match the closed clean derivation. No excluded architecture is
promoted into the baseline.

## Consolidated scores

| Dimension | Score | Verdict |
|---|---:|---|
| Model design | 8.0/10 | PASS |
| Technical presentation | 9.0/10 | PASS after repair and rereview |
| Exposition | 8.7/10 | PASS |
| **Editorial assessment** | **8.6/10** | **PASS** |

## Editorial synthesis

The paper asks a clear and politically relevant question: why can consensus
benefit a powerful state even when that state lacks proposal power? The clean
model answers by separating private outside-option power, institutional
pivotality, and agenda power. The terminal example introduces the mechanism
parsimoniously; the dynamic model earns its additional complexity by producing
derived equilibrium-existence failures, regular pooling under unanimity,
group-size-dependent majority correspondences, and conditional entry and
payoff comparisons.

The strongest design feature is the disciplined baseline. The hegemon is
never proposer; its no vote is an immediate and irreversible opt-out; weak
votes are simultaneous; its outside payoff stays outside the institutional
pie; and comparisons occur only on the common PBE-existence domain. The
manuscript is explicit that globally off-path beliefs under weak PBE are freer
than under sequential equilibrium.

The first technical pass identified missing Gate-0 statements in the body,
even though the formulas and proofs matched the canonical derivation. The
implementer restored those statements in a separate repair commit. All three
reviewers then rereviewed that repaired commit and returned PASS. A final
read-only delta review confirmed that the later PDF-layout repair changed no
primitive, equation, result, proof, scope condition, label, caption, or table.

## Repair-and-rereview ledger

### Initial technical verdict

The first technical reviewer returned REPAIR on candidate
2635d1bd40765973b45e215a621d462f6635b148 because five Gate-0 requirements
were implicit or confined to the appendix:

1. the payoff branch after nonformation;
2. post-opt-out proposals fixing y=0;
3. terminal Round-2 failure payoffs and absence of a second flow;
4. common knowledge, complete assessment inventory, sequential rationality,
   and Bayes consistency;
5. definition of the proposal-indexed weak-vote distribution and evaluation
   of deviations under the true prior.

### Repair

Commit b5a6791a250cd488dff27b1d19ed44e16bb954a0 added those statements to the
body without changing primitives, result formulas, theorem domains, or proofs.
The manuscript recompiled cleanly and all 110 automated checks passed.

### Rereview

- Design reviewer: PASS.
- Technical-presentation reviewer: PASS without substantive reservation.
- Exposition reviewer: PASS without substantive reservation.

### Final layout delta

Commit 1b8bda6fb6906391c65fb6425b781c123d5948be moved the Appendix A.2 TSV
path to a centered standalone line after the independent PDF reviewer found
right-edge clipping on page 16. The final formal delta review found this
change mathematically inert. Pages 1--15 and 17--32 remained pixel-identical;
the repaired page 16 is complete and legible within the text area.

**Delta verdict:** PASS.

## Review 1 — Model design

### Score

8.0/10.

### Model in one sentence

A two-round bargaining game assigns proposal power exclusively to weak states
and gives a privately informed hegemon an immediate opt-out, allowing a
comparison of how unanimity and majority convert its private outside payoff
into bargaining leverage through pivotality.

### Findings

- **Question:** excellent. The puzzle is clear, surprising, and relevant to
  institutional design.
- **Parsimony:** adequate to strong. Binary private information, two rounds, a
  unit weak pie, and a one-dimensional participation package are purposeful.
  The 21 history classes are a cost of the simultaneous-ballot protocol, not
  decorative complexity.
- **Mechanism isolation:** excellent. Outside-option power, pivotality, and
  agenda power are separated in primitives and implementation.
- **Insights:** rich. The model derives unanimity nonexistence regions,
  regular pooling, majority correspondences by group size, entry nesting, and
  hegemon payoff bounds.
- **Contribution:** a new conceptual lens and an isolated political force,
  rather than a new equilibrium technique.
- **Construction:** mature. A minimal terminal example precedes the full
  model; regular results, boundaries, and excluded extensions remain separate.

The delta rereview confirmed that the Gate-0 repair strengthened conceptual
closure without adding mechanisms. It found no type-specific t/a architecture,
delayed continuation as the payoff from H-no, global P/L/R reduction,
feasibility/C-B-R branch, unrestricted uniqueness, majority no-screening
claim, or unconditional institutional ranking.

**Verdict:** PASS.

## Review 2 — Technical presentation

### Score

9.0/10.

### Scorecard

| Object | Verdict |
|---|---|
| Players, type, prior, fixed pie, and external option | Excellent |
| Contract space and H-including/weak-only budgets | Excellent |
| Immediate opt-out and legitimate continuation | Excellent |
| Simultaneous ballot and original quotas | Excellent |
| Formation and nonformation payoffs | Excellent |
| Common knowledge and complete PBE assessment | Excellent |
| Off-path beliefs and true-prior deviation payoffs | Excellent |
| H and weak-voter incentive constraints | Excellent |
| Regular and boundary theorem domains | Excellent |
| Proof/result correspondence | Excellent |
| Captions, figure, tables, and cross-references | Good |
| Baseline/extension scope discipline | Excellent |

The reviewer checked every main result against the canonical derivation:

- terminal unanimity and majority;
- unanimity existence iff beta times o1 is at least o0 and G_P exceeds G_L;
- equality nonexistence and pooling payoffs;
- majority security value and N=3, N=4, and N at least 5 cases;
- revised No-Cheap-H condition and its limited consequences;
- selection-free entry nesting and conditional H payoff bounds;
- zero-low, no-terminal-surplus, no-discounting, majority-boundary, and
  one-sided-limit statements.

Minor cosmetic observations were nonblocking: the contract tables retain
literal ASCII payoff expressions, and the notation table continues by one row
onto the following page.

**Verdict:** PASS without substantive reservation.

## Review 3 — Exposition

### Score

8.7/10.

### Findings

- **Structure:** excellent. The order puzzle, literature, terminal example,
  model, backward induction, institutional comparison, discussion, and
  conclusion is clear. The main theorem appears before page 15.
- **Introduction:** excellent. The mechanism and four results are stated
  early and with correct domains.
- **Writing:** excellent. The distinction between H-no and H-yes followed by
  weak-caused failure is consistent in prose, equations, and Figure 1.
- **Length:** adequate. The 32-page length is justified by the auditable
  protocol, proofs, and boundary cases.
- **Examples and intuition:** adequate. The terminal example and OPEC
  interpretation are concrete without claiming literal protocol realism.
- **PDF:** complete and readable, with no clipping, overlap, missing glyphs,
  broken references, or caption failures.

The delta rereview found that the Gate-0 repair improved exposition by moving
contractual and assessment details into the reader-visible body. It did not
alter the baseline/extension boundary.

Optional future editorial improvements are not closure gates: add a short
group-size intuition after the majority proposition; name the
weak-vote-passive assessment directly in the abstract; replace internal
migration language in the scope section; typeset the audit table expressions;
and reduce the final notation-table orphan.

**Verdict:** PASS without substantive reservation.

## Final formal-review verdict

The migration is formally coherent on reviewed commit
1b8bda6fb6906391c65fb6425b781c123d5948be.

**PASS — no substantive reservation.**
