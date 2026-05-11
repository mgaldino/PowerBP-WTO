# Model Redesign Workspace

This folder is the formal laboratory for the next version of the paper.

Do not edit `formal_model_v5.Rmd` while the proof architecture is unsettled. The active manuscript is frozen as an archival/reference object until the results in this folder have been rederived, audited, and compiled cleanly.

Current working document:

- `power_architecture_derivations.Rmd`: clean standalone derivation file for the relative-package `pi_H = 0` baseline.

Archived reference:

- git tag `redesign-feasibility-branch-2026-05-11`: archived feasibility/C-B-R derivation before the 2026-05-11 reset. Treat it as diagnostic history only.

Current architecture:

- proposals are relative institutional packages, not fixed transfers;
- packages are feasible in every state;
- baseline recognition is `pi_H = 0`;
- minimal H payoff primitive is `U_H(y, theta) = y + b_H(theta)`;
- acceptance threshold is `y_theta^*(mu') = beta C_H(theta, mu') - b_H(theta)`;
- screening requires `y_1^*(mu') > y_0^*(mu')`.

Rules for this folder:

1. Rederive from primitives; do not patch old formulas into the new model.
2. Label every result as `proved`, `checked numerically`, `conjecture`, `pending`, or `rejected`.
3. Keep R checks in separate scripts under `scripts/`.
4. Only transport material to `formal_model_v5.Rmd` after the formal results are stable.
5. Do not introduce a strategic option, voting history, tie-breaking convention,
   information structure, contract space, or continuation protocol inside a
   proof unless it is already a stated primitive. If a derivation requires such
   an object, stop and label the result `pending protocol decision`.
6. No pooling, delay, rejection, or off-path belief can be imposed. It must be
   shown to be incentive-compatible under the stated extensive-form game.
7. Before changing primitives or protocols to make a proof work, explain the
   substantive consequence to the user and obtain explicit approval.
8. Do not reuse C-B-R, high-state-only feasibility branch `B`, or A/C/R labels
   as current theorem architecture unless they are rederived under the
   relative-package primitives.
