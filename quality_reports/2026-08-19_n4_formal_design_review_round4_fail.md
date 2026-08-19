# N4 formal-design review — round 4

reviewer_role: formal_design  
reviewer_id: 01a0181a-26ec-7e00-a964-c9a3aa0d7f9c  
artifact_hash: sha256:2e68f57847762814786ad674a1d9c1efd4cc255a475fc54f9d98b38b10dc597c  
verdict: FAIL  
finding_counts: critical=1, major=1, minor=0  
findings:

1. **Critical — `A2(nu)` is not belief-proof, so the `m=2` none cell and six-cell correspondence are false.** After the zero-probability proposal `(y,x,r)=(beta*o0,a0,Q2)`, the contract permits a high ballot belief. Prescribing weak yes and both H types no is sequentially rational and sends both types to pooling N2, giving the deviating proposer `z`, not `A2(nu)`. A complete omitted delay PBE exists at `m=2, beta=.9, o0=.2, o1=.6, nu=.2`, which the interface classifies as none because `A2=.368 >= p=.28`. Use on-path `(y,x,r)=(0,.36,0)`, weak yes, and both H types no; delay pays `d=g=.288`. Off path, prescribe: weak no/H yes with posterior zero when `x<a0`, yielding `d`; weak yes/both H no with posterior one when `x>=a0` and `y<beta*o1`, yielding `z=.18`; and passage when `x>=a0` and `y>=beta*o1`, whose proposer residual is at most `K2=.10`. These pure ballots satisfy weak-only stage-undominance and `T^Y`; all deviations yield at most `.288`, and the payoff-tied low-posterior punishment gives H the same type-contingent continuation as on-path delay. Thus the nonexistence certificate, `Q2/A2` forcing claims, boundaries, and downstream hybrid/product partition are invalid. The verifier passes only because it assumes this disputed classifier rather than enumerating this admissible response.

2. **Major — accepted-branch records admit proposal mixtures that violate the lower-H tie-break.** They allow each `F_i` to mix over equal-`r_i` accepted packages with different `y`. For example, at `m=3, beta=.5, o0=.2, o1=.6, nu=.8`, both pooling packages `(y,x1,x2,r)=(.30,.0667,.0667,.20)` and `(.35,.0667,.0667,.20)` satisfy the stated record conditions and are feasible. They give the proposer the same payoff `.20` but H payoffs `.30` and `.35`; the mandated proposal tie-break excludes the latter. Hence the pure accepted records—and product records consuming them—contain non-equilibrium `F_i` laws. Each identity’s maximizing accepted support must be restricted to proposals attaining a common minimum expected H payoff.
