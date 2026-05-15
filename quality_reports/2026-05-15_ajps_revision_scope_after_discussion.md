# AJPS referee revision scope after discussion

Date: 2026-05-15

Implementation status: completed in `formal_model_v5.Rmd` on 2026-05-15 and
compiled to `formal_model_v5.pdf`. The R1 rejected-history proof was iterated
with two independent review agents until both rated the final version A+ with no
remaining patches. This document remains the scope record for that revision
pass, not a substitute for a full-paper coherence review.

Source inputs:

- ChatGPT Pro critical comments on the redesigned formal model.
- Manoel's comments in chat on weak-vote-passive language, institutional choice,
  no-cheap-H, tie-breaking, and the role of signaling.
- Current redesign workspace:
  `model_redesign/power_architecture_derivations.Rmd`.

## Q&A

**What is this document?**  
A scope document for the next implementation pass. It translates the remaining
referee-style concerns into concrete manuscript and appendix adjustments.

**What is already settled?**  
The relative-package baseline is the working architecture. The paper should not
add a full endogenous rule-choice stage now. The main task is to make the claims
match the model: conditional institutional comparison, not a model of how the
hegemon chooses the voting rule.

**What should not be introduced?**  
Do not introduce a separate abstract label for the belief assessment. It adds
notation without analytical benefit. Use direct language: `selected PBE under
the weak-vote-passive assessment` or, when less technical language is enough,
`selected equilibrium under the weak-vote-passive assessment`.

**What is the implementation philosophy?**  
KISS. The baseline deliberately isolates screening through pivotality. Agenda
power, institutional signaling, and recursive `pi_H>0` dynamics are important
extensions, but not part of the core theorem architecture.

## Core decisions

### 1. Weak-vote-passive language

Decision: keep the weak-vote-passive assessment, but make the solution concept
language more explicit and less ambitious.

Use:

```text
selected PBE under the weak-vote-passive assessment
```

or:

```text
selected equilibrium under the weak-vote-passive assessment
```

Do not create shorthand labels for the assessment.

Rationale: the paper is already notation-heavy. A named abstract assessment
would make the text feel more artificial. The direct phrase says exactly what is
being done.

Implementation tasks:

1. Search the manuscript for unqualified `PBE`, `equilibrium`,
   `characterization`, `unique`, and `selected outcome`.
2. Replace overstrong uses with scoped language.
3. Preserve the key disclaimer: this is not a refinement, not D1, not the
   intuitive criterion, and not a characterization of all PBEs under arbitrary
   off-path beliefs.

Acceptance criterion: a referee cannot reasonably read the main R1 result as a
claim about unrestricted PBEs.

### 2. R1 rejected histories and Proposition 2 replacement

Decision: the R1 result should remain a selected-value theorem under the
weak-vote-passive assessment, but the proof needs a cleaner history taxonomy.

The current proof is directionally right, but it should separate two sources of
non-informativeness:

1. **Failure caused by weak rejection.**  
   If weak rejection already makes the proposal fail, `H`'s vote is nonpivotal.
   Non-informativeness comes from the weak-vote-passive assessment, not from
   incentive compatibility of `H`'s types.

2. **Failure caused by `H` rejection.**  
   If `H`'s rejection is pivotal for failure, then `H`'s vote can be
   informative. Here the incentive-compatibility argument for `H`'s types does
   real work.

Implementation tasks:

1. Add a formal lemma splitting rejected histories into weak-caused failures and
   H-caused failures.
2. Add a compact table of relevant histories:
   - accepted proposal;
   - failure by weak rejection;
   - failure by `H` rejection;
   - unilateral weak-voter deviation;
   - nonpivotal `H` vote;
   - histories where public allocation makes weak rejection inevitable.
3. For each history, state:
   - whether beliefs update;
   - whether Bayes' rule applies;
   - which player is pivotal;
   - which sequential-rationality condition is doing the work.
4. Keep the result scoped to the pure-threshold candidate class.

Acceptance criterion: the reader sees that P/L/R are not merely asserted; they
are the payoff-relevant candidates under the maintained assessment and scalar
relative-package order.

### 3. Institutional choice framing

Decision: do not add an endogenous rule-choice stage now. Reframe the paper as a
conditional institutional comparison.

Preferred language:

```text
The model treats the voting rule as an institutional environment, not as an
endogenous choice. This is deliberate: the goal is to isolate informational
power through pivotality, holding agenda power and institutional signaling
fixed.
```

Core reason: if a privately informed hegemon chooses the rule after observing
its type, rule choice itself can become a signal. This is realistic for Saudi
Arabia or the United States, because a hegemon often knows its outside option
before institutional design. Modeling that stage would combine two mechanisms:
institutional signaling and screening through pivotal participation.

Implementation tasks:

1. Remove or weaken claims that model endogenous rule choice unless explicitly
   framed as informal motivation.
2. Use conditional language:
   - `unanimity can favor H`;
   - `H may prefer unanimity conditional on institutional formation`;
   - `the model identifies conditions under which unanimity benefits H`;
   - `the comparison is between institutional environments`.
3. In the discussion, add a paragraph on institutional signaling:
   - signaling can reduce screening if rule choice reveals `H`'s type;
   - signaling can leave screening intact if both types choose the same rule or
     if the rule is institutionally fixed;
   - signaling can amplify screening if rule choice shifts beliefs toward a high
     participation threshold without fully revealing type.
4. Mark a future appendix exercise: parametric/simulation illustration of the
   three interaction patterns, without claiming boundary conditions or general
   predominance.

Acceptance criterion: the paper no longer needs a rule-choice stage for its main
claim, and it preempts the obvious objection that endogenous rule choice could
signal type.

### 4. Numerical illustration and calibration language

Decision: the current boundary example is acceptable as a baseline diagnostic,
but it should not be the only numerical illustration in the main text.

Problem: in the current main calibration-style example, `a_0(1)=a_1`, so the
low-only candidate is blocked. That example does not display the full
pooling/low-only/rejection mechanism.

Implementation tasks:

1. Keep the boundary example only if clearly labeled as an illustrative
   benchmark.
2. Add a nonboundary diagnostic example to the main text or a prominent
   appendix table:
   - strict `a_0(1)<a_1`;
   - nonempty low-only region;
   - pooling region;
   - no reliance on equality.
3. Do not call either example an empirical calibration unless parameters are
   externally disciplined.
4. Reuse the existing robustness scripts and tables:
   - `scripts/verify_relative_package_robustness_piH0.R`;
   - `tables/relative_package_r1_examples_piH0.csv`;
   - `tables/relative_package_open_neighborhood_piH0.csv`.

Acceptance criterion: the main text contains at least one nonboundary numerical
example that visibly displays active screening.

### 5. No-Cheap-H condition

Decision: treat No-Cheap-H as a natural scope condition for hegemonic settings,
not as a major threat to the mechanism.

Technical condition:

```text
a_0^M = beta*d_0 - b_0 >= beta/m
```

Natural-language interpretation:

```text
The hegemon is not cheaper to include in a majority coalition than a weak
member.
```

If the condition fails, then:

```text
beta*d_0 - b_0 < beta/m
```

Substantively, the low type of `H` is so cheap to buy that a weak proposer may
prefer including `H` instead of one weak voter. Then majority can also screen
`H`.

Assessment after discussion: this case is mathematically possible but
substantively peripheral for the paper's target environment. In hegemonic IO
settings, a real hegemon's outside option should normally be strong enough that
weak states cannot buy its participation more cheaply than another weak
member's support. The complementary case may matter for weak asymmetries or for
applications where the stronger actor has unusually high direct benefits from
participation, but it is not the core hegemonic setting.

Implementation tasks:

1. Explain No-Cheap-H in words in the main text.
2. State that it is a natural domain restriction for hegemonic bargaining.
3. Add a technical note or appendix remark with the majority-screening cutoff.
4. Do not expand this into a major extension unless later reviewers insist.

Suggested text:

```text
The no-cheap-H condition rules out cases in which the hegemon is effectively a
cheap coalition partner. This is the natural domain for hegemonic bargaining:
the powerful actor's outside option is sufficiently strong that weak states
cannot buy its participation more cheaply than they can buy another weak
member's support. The complementary case is mathematically possible and can
generate screening under majority as well, but it is peripheral to the
hegemonic outside-option environment the paper is designed to isolate.
```

Priority: low substantive concern, medium exposition concern.

### 6. Tie-breaking convention

Decision: keep the tie-break that minimizes `H`'s expected payoff, but present
it as a conservative boundary convention, not as a substantive engine of the
result.

Manoel's view: the convention is not rhetorically strange. It is acceptable.
However, because some numerical examples lie near equality boundaries, the
paper should avoid any appearance that the result is being generated by
tie-breaking.

Implementation tasks:

1. State that the tie-break matters only at payoff ties for the weak proposer.
2. Emphasize generic results away from ties.
3. If possible, report that small perturbations preserve the qualitative result
   without relying on the tie-break.
4. Avoid apologetic language suggesting that the convention is suspicious.

Suggested text:

```text
The tie-breaking rule is a boundary convention. Away from proposer payoff ties,
the selected candidate is pinned down by strict payoff comparisons. We use the
H-payoff-minimizing tie-break only to make boundary cases single-valued, and it
therefore works against attributing results to a pro-hegemon selection rule.
```

### 7. Equation numbering and polish

Decision: fix before circulation.

Implementation tasks:

1. Check duplicated equation labels and displayed equation numbering.
2. Avoid reusing numbers such as `(13)` after sub-equations `(13a)`, `(13b)`,
   `(13c)`.
3. Recompile PDF and inspect the proof section visually.

Priority: low conceptual importance, high professionalism.

## Implementation order

1. Update R1 proof structure in the redesign Rmd:
   - rejected-history taxonomy;
   - weak-caused vs H-caused failure lemma;
   - selected PBE language.
2. Add institutional-choice framing paragraph:
   - no endogenous rule choice in baseline;
   - KISS/isolation rationale;
   - signaling interaction deferred to discussion/appendix.
3. Add nonboundary numerical diagnostic example.
4. Rewrite No-Cheap-H exposition as natural hegemonic domain condition.
5. Clarify tie-break as boundary convention.
6. Fix numbering/cross-references.
7. Recompile and run wrappers:
   - `scripts/verify_relative_package_R1.R`;
   - `scripts/verify_relative_package_majority.R`;
   - `scripts/verify_relative_package_calibration.R`.
8. Only after the redesign text is clean, transport changes to
   `formal_model_v5.Rmd`.

## Not in scope for the next implementation pass

1. Full endogenous institutional rule-choice model.
2. Full unrestricted-PBE characterization.
3. Exact recursive `pi_H>0` game.
4. Empirical OPEC calibration.
5. General boundary-condition theorem for how institutional signaling interacts
   with screening.

These can be discussed as limitations or future extensions. The paper's main
claim should remain narrower: unanimity can create informational power through
pivotality even when agenda power and institutional signaling are held fixed.
