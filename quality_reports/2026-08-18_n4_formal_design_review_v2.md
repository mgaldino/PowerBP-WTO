# Goal 2 / N4 — independent formal-design review

- Role: `formal_design`
- Candidate interface: `sha256:42c525db332d854c79a2db0f6dc1af69368123cee2163eb879d10b39a683eb92`
- Candidate derivation: `sha256:6f6a2b99653428a5357ad14b19b5700d864c5db016a1d4e48e125bfc8c64d9d8`
- Candidate ledger: `sha256:a2f745c31c487a73874595d8f074baf6623542e0a3198420d3fc10410d894452`
- Frozen N2: `sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`
- Contract: `sha256:368b09eace9b1c2e68ffdcc61e6583dbc060591f1faf627f93919bae79e2241a`
- Verdict: **FAIL**
- Finding counts: `critical=1, major=2, minor=1`
- Reviewer agent: `01a017da-88d5-7312-b8fc-b98242025e11`

The reviewer was read-only and edited no repository file. The candidate hashes
matched exactly.

## Findings

1. **[CRITICAL] The five-cell/seven-family characterization is incomplete.**
   The assertion that `m=2` delay never survives is false under P6. The
   reviewer gives the concrete admissible point `m=2`, `beta=.99`, `o0=.1`,
   `o1=.9`, `nu=.95`: `nu2=.8889`, `a0=.4455`, `z=.0495`, `d=.022275`,
   `g=z`, `p=.0595`, and `(1-nu)q0=.022775<p`. A failure equilibrium can have
   the sole weak nonproposer vote no, both H types vote yes, and posterior
   `nu`; the proposer receives `z`. The weak no is not strictly worse and is
   not weakly dominated. This family is absent from the interface.

2. **[MAJOR] The m=2 `none` certificate is not a complete nonexistence proof.**
   Its evidence is limited to the tested families, while P3 requires all
   candidates, including weak rejection and off-path beliefs. The verifier
   reproduces the declared partition but does not independently enumerate that
   branch.

3. **[MAJOR] Atomless proposals remain substantively ambiguous.** The
   candidate invokes Bayes almost everywhere while also allowing arbitrary
   beliefs at probability-zero proposals. With atomless mixing every singleton
   is null; the contract must specify whether a regular-kernel Bayes-a.e.
   interpretation or pointwise arbitrary beliefs governs deviation incentives.
   These readings can change the admissible deviations.

4. **[MINOR] The verifier does not test the disputed conclusion.** It validates
   hashes, schema, IDs, prose anchors, and algebraic identities, but does not
   test sequential rationality in the `m=2` weak-rejection branch. Its PASS is
   configurational rather than a substantive proof of the characterization.

The reviewer found the formulas `a0`, `z`, `d`, `g`, `p`, and `q0`, the single
N2 discount, and true-prior proposer accounting internally consistent. The
Bayes-sign argument against pure H separation was also considered adequate;
it does not rescue the missing m=2 delay family.

## Disposition

N4 remains `pending`; no freeze evidence was added. The second assigned
`game_theory` reviewer was shut down after repeated timeouts and did not return
a verdict, so the required two-reviewer `PASS 0/0/0` gate was not met.
