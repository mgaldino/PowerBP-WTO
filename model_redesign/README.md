# Model Redesign Workspace

This folder is the formal laboratory for the next version of the paper.

Do not edit `formal_model_v6.Rmd` while the proof architecture is unsettled.
`formal_model_v5.Rmd` is an archival/reference object. Results should remain in
this folder until they have been rederived, audited, and compiled cleanly.

Current working document:

- `power_architecture_derivations.Rmd`: working surface for the clean
  relative-package `pi_H = 0` reset. Its current body still contains the
  pre-2026-05-25 delayed-continuation architecture and must not be treated as a
  completed derivation of the immediate-opt-out baseline.

Archived reference:

- git tag `redesign-feasibility-branch-2026-05-11`: archived feasibility/C-B-R derivation before the 2026-05-11 reset. Treat it as diagnostic history only.

Current architecture:

- proposals are relative institutional packages, not fixed transfers;
- packages are feasible in every state;
- the weak coalition's institutional surplus is fixed and normalized to 1 in
  the baseline; the private state affects `H`'s participation threshold, not the
  size of the weak coalition pie;
- baseline recognition is `pi_H = 0` in every bargaining round;
- the clean baseline sets `b_theta = 0`, so an accepted package gives `H`
  payoff `y`;
- if type `theta` rejects in Round 1, it opts out immediately and receives
  `o_theta` without discount; the clean acceptance threshold is therefore
  `y_theta^* = o_theta`;
- screening in the clean baseline requires `o_1 > o_0`;
- `o_theta` is a primitive in the clean theorem; a mapping such as
  `o_theta = alpha V(theta)` belongs to an application, numerical
  illustration, or microfoundation and is not imposed by the baseline;
- `U_H(y, theta) = y + b_H(theta)`, rejection payoff
  `beta C_H(theta, mu')`, the hybrid
  `max{o_theta, beta C_H(theta, mu')}`, and the decomposition
  `t_theta = d_theta - b_theta` belong to extensions or microfoundations, not
  to the clean baseline;
- the bargaining sequence is public across rounds, but voting is not a
  sequential roll call: within each ballot the proposer counts as voting yes,
  all other states vote simultaneously, and individual votes are publicly
  revealed only after all ballots are cast; unanimity and majority use the same
  ballot protocol and differ only in the quota.

Rules for this folder:

1. Rederive from primitives; do not patch old formulas into the new model.
2. Label every result as `proved`, `checked numerically`, `conjecture`, `pending`, or `rejected`.
3. Keep R checks in separate scripts under `scripts/`.
4. Only transport material to `formal_model_v6.Rmd` after the formal results are stable.
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
9. Do not reinterpret the adopted simultaneous ballot as sequential roll-call
   voting. Any extension in which later voters observe earlier votes requires
   an explicit order and rederivation of beliefs and incentive constraints.
