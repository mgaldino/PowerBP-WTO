# Pivotal-response continuation interfaces

This directory stores immutable, versioned interfaces for the new backward
derivation. `gate0_bundle_v1.json` freezes the extensive-form contract and
every authoritative Gate 0 registry; `gate0_review_v1.json` records its
independent PASS. Gate 0 is closed on that exact bundle hash.

The three terminal continuation interfaces are also frozen without rewriting
their candidate-status fields: their approval is external and hash-specific.
`r2_batch_review_v1.json` is the dependency-complete PASS interface that
hashes the three C2 objects and their auxiliaries. The two repaired Round-1
interfaces are frozen under the same discipline by
`r1_batch_frozen_v1.json`, which records both independent hash-specific PASS
rereviews and hashes Gate 0, the R2 batch, both C1 objects, notes, candidate
status snapshots, verifiers, and tables. Both batch gates preserve the full
assessment-level correspondences and introduce no scalar selection.

Continuation files must be added rather than silently replacing a frozen
version. Current frozen files are:

- `r2_unanimity_active_h_v1.json`;
- `r2_majority_active_h_v1.json`;
- `r2_majority_weak_only_v1.json`;
- `r2_batch_review_v1.json`;
- `r1_unanimity_v1.json`;
- `r1_majority_v1.json`;
- `r1_batch_frozen_v1.json`.

Future interface targets are:

- `entry_unanimity_v1.json`;
- `entry_majority_v1.json`.

Each continuation interface must report strategies, beliefs, payoff vector or
correspondence, native payoff date, existence and multiplicity, boundary and
equality cases, assumptions, checks, status, provenance, and SHA-256. No
Round-1 interface exists at the R2 batch close.

If a Gate 0 registry or contract changes, create a new bundle version, update
its component hashes, reopen `gate0_contract`, and invalidate every downstream
node and review. Any byte change to a frozen R2 interface or auxiliary
invalidates `r2_batch_review_v1.json`, both R1 candidates, and every later
descendant. If another frozen interface changes, create a new version, reset
all descendants in
`../pivotal_response_game_dag.json` to `pending`, remove their stale hashes and
reviews, and rerun the dependency audit. At the R1 batch close, exactly the
two entry nodes are ready; neither has started or materialized an interface.
