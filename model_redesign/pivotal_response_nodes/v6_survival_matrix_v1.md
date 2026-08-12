# v6 survival matrix: claim-level, nonmigratory classification

## Scope and frozen dependencies

This node classifies historical manuscript claims against the approved current
correspondences. It is a provenance matrix, not a new derivation and not a
manuscript rewrite. Its only formal comparison dependencies are:

```text
Institutional comparison
  sha256:cab69c5ddda3616f51c697c189c86316df5546501a183eb6cc9e437dc813f3af

Independent comparison review bundle
  sha256:0acd9648eb7e03d4dabfaa91ffd559fe3c5b6f61a96ba676d6c6ccd9d4c6bb3c
```

The current object is PBE under local outcome-signature relevance, yes at
payoff-relevant equality, and explicit full-profile completion when a vote has
zero outcome relevance. It is not described by an imported historical label.
The comparison domain is the full primitive-admissible `N>=3` domain exported
by the frozen entry interfaces, with no cross-rule assessment selection.

Historical material was read only to locate claims. The four inventories and
their frozen hashes are `formal_model_v5.Rmd` (`1b0e420...`),
`formal_model_v6.Rmd` (`131cc235...`),
`model_redesign/power_architecture_derivations.Rmd` (`8fbb7ed...`), and
`AGENTS.md` (`2164d247...`). None supplies current proof evidence.

## Machine-readable result

The authoritative CSV contains 52 source-claim-granular rows and exactly 11
columns. Every row records its historical path and inclusive line locator,
plain-language historical claim, one allowed status, precise current
replacement, one or more current `path@sha256#pointer` references, domain and
selection scope, manuscript action, migration blocker, and notes.

Status counts are:

| Status | Claims |
|---|---:|
| `survives` | 8 |
| `conditional` | 13 |
| `changes` | 7 |
| `rejected` | 12 |
| `pending` | 6 |
| `outside_scope` | 6 |

Manuscript-action counts are 21 `retain_with_rewrite`, 10 `replace`, 9
`remove`, 6 `do_not_add`, and 6 `pending`. These are future migration
instructions only. They do not authorize a manuscript edit.

## Main classification results

### Solution, ballot, timing, and beliefs

- PBE, the simultaneous sealed ballot, weak-state agenda with `pi_H=0`, the
  immediate Round-1 opt-out, external H outside options, and formation at
  equality survive.
- The old pivotal-vote shorthand changes to outcome-signature relevance. The
  twenty-one-history Gate 0 table changes to the frozen transition,
  information-set, and relevance registries.
- Terminal payoffs are solved in terminal units, without an internal discount;
  a terminal continuation is discounted exactly once when imported into a
  Round-1 incentive comparison.
- The informational principle that uninformed weak ballots do not directly
  reveal H's type survives conditionally. Hard-coded historical off-path
  posteriors change to explicit assessment components.
- The full simultaneous-vote incentive comparison and its reduction to a
  direct package cutoff only under certain implementation already appear
  together historically and survive together.

### Equilibrium correspondences and historical reductions

- All-weak approval, zero gifts, and unit proposer retention are rejected as a
  terminal-majority characterization. Current correspondences admit positive
  gifts, oversized support, and distinct outcome distributions.
- Historical pooling, low-only, and rejection or continuation motifs survive
  only as fully proved subclasses. Their exhaustive reduction is rejected.
- Global scalar and uniqueness characterizations for terminal and Round-1
  bargaining are rejected. Exact small-domain projections are retained only
  where the frozen interfaces prove them: the terminal-unanimity attained upper
  envelope, the active-H terminal-majority unit proposer projection for
  `3<=N<=5` with positive low-type outside option, the exact `N=3` weak-only
  continuation, the attainable `N>=4` weak-only upper endpoint, and the
  `N=3` Round-1 majority proposer projection under its stated boundary.
- The old boundary Appendix C characterization and its equation/table system do
  not migrate. Boundary claims must be rebuilt from the current full
  correspondences.

### Entry and three distinct nesting notions

Entry is assessment-by-assessment on the full `N>=3` common domain. Three
different nesting objects are kept separate:

1. pairwise formation-set nesting, exactly determined by the two retained gross
   values;
2. possible-cost and guaranteed-cost projections within each rule; and
3. universal nesting across every cross-rule assessment pair.

For `N>=4`, the possible-cost and guaranteed-cost U-in-M projections survive
conditionally, and at each positive cost through the resource ceiling there
exists an M-only pair. Universal U-in-M nesting remains pending. The current
interfaces also neither prove nor exclude an attained U-only pair, so the old
no-U-only statement remains pending rather than rejected.

### H payoffs and institutional ranking

The historical ex-ante outside-option floor survives and is strengthened by
the current type-by-type floor. Neither the floor nor common formation supplies
an unconditional rule ranking.

Conditional formation-pattern identities survive: neither-form gives H its
outside option under both rules; in an exclusive pattern the forming rule
weakly benefits H relative to the nonforming rule. When both form, the sign of
the retained payoff difference is unidentified without the pair values. The
historical weak ordering therefore remains pending.

The separate historical claim that equality in a both-form comparison occurs
only in one named majority class is rejected. At `N>=4` and zero entry cost,
attained U zero-weak-value and M value-one assessments both form and give H its
outside option. This refutes the equality-only clause but does not resolve the
weak ordering. Universal H dominance and a universal institutional ranking
remain pending.

### Quarantined and extension material

Positive H recognition, endogenous rule choice, delayed-continuation and hybrid
exit architectures, old random-proposer formulas, historical OPEC calibration,
and closed Goal-3 artifacts are outside the current game or quarantined
provenance. They are not current evidence and must not be added to v6 from this
matrix. No current No-Cheap-H restriction selects one majority assessment.

## Verification and migration block

Run:

```sh
Rscript --vanilla scripts/verify_pivotal_response_v6_survival_matrix.R
```

Result: **42/42 PASS**.

The verifier checks every source locator, every evidence hash and JSON pointer,
the exact status/action locks and counts, all 27 protected hashes, and full
topic coverage. Negative mutations confirm that missing evidence, a stronger
status, a protected-hash change, an archived formula or branch label in a
current replacement, a forbidden historical label assigned to a current PBE,
promotion of an old formula, or mutation of either approved comparison
dependency blocks the candidate.

This candidate remains nonmigratory and pending two independent read-only
reviews. `formal_model_v6.Rmd`, `formal_model_v5.Rmd`, the prior derivation,
their outputs, the shared Rmd, DAG, and proof ledger were not edited or
compiled. No protected-target migration is authorized.
