# N4 game-theory review — round 4

reviewer_role: game_theory  
reviewer_id: 01a0181a-2678-7191-841b-881db5a42d4f  
artifact_hash: sha256:2e68f57847762814786ad674a1d9c1efd4cc255a475fc54f9d98b38b10dc597c  
verdict: FAIL  
finding_counts: critical=0, major=2, minor=0  
findings:

1. A valid one-weak-rejector delay family is missing for `m>=3` at every prior. Prescribe exactly one weak nonproposer `j` to vote no, all other weak voters and both H types to vote yes, and choose `x_j<g(nu)`. Then `j` receives `g(nu)` from rejection but only `x_j` if it switches to yes and makes the proposal pass, so no is strict and stage-undominated. The remaining voters and H can be supported by the permitted complete-vector beliefs and `T^Y`; null proposals remain punishable at `d(nu)<=g(nu)`. For the reviewer values `m=3, beta=.9, o_0=.2, o_1=.6, nu=.8`, `nu_2=.5` and `g=z=.12`; setting `x_j=.06` makes no strictly optimal. Thus weak-rejection delay survives at and above `nu_2` when there is exactly one rejector. The interface includes only H-rejection there and omits these pure-delay, hybrid, and identity-product assessments.

2. The accepted-family records admit invalid within-identity proposal mixtures under the mandatory lower-H proposal tie-break. They require equal proposer payoffs across `F_i` support but do not require equal, tie-break-minimal H payoffs. At `m=3, beta=.9, o_0=.2, o_1=.6, nu=.2`, `d=.192`, `z=.12`, and `p=.22`. The pooling packages `(y,x_1,x_2,r)=(.54,.12,.12,.20)` and `(.55,.12,.12,.20)` both satisfy the stated record and are feasible, but give H `.54` and `.55`. A law assigning positive probability to both is expressly admitted, yet the proposal tie-break selects only the first. The same overinclusion propagates to low-only and Cartesian-product records. Within each proposer identity, accepted support must additionally be restricted to proposals attaining the minimum expected H payoff among proposer maximizers.
