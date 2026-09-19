# Round-1 coalition interfaces and baseline result transport

Implementer `/root`. Imports `r2_interface.md`, SHA-256
`c83cf10483bf42e750e131a0792eedde60ae0eed244822c84ea2a1be285dd8a7`.
Domain and solution concept are `game_contract.md`. All values exported here
are in native R1 units. Independent review remains separate and pending.

## R1_M: complete ballot response and proposal reduction

Write w=β/m. At every feasible (C,x), each invited weak responder accepts
iff x_j≥w. Its terminal-majority continuation is 1/m, independently of every
belief and H vote. If H∈C and all invited weak responders accept, type o
accepts iff x_H≥βo. If an invited weak responder vetoes, passage is impossible:
both H actions yield βo, so T^Y selects Y for both types. If H∉C it has no
ballot action. All invited weak ballots remain the prescribed pivotal
comparison, including at proposals that fail for other reasons. Beliefs
follow `game_contract.md`; at each invited-H ballot the prescribed threshold
or pooled-Y profile supplies Bayes' likelihood. Zero-denominator values stay
within the initial support, local to the ballot and H vote. No weak action
updates beliefs, and the entire R2_M outcome and payoff completion is defined
at every such history, including composite deviations.

Any proposal with an underpaid invited weak responder, or no accepting H type
of positive current probability, gives the proposer only w. A minimal all-weak
coalition E pays w to k partners and the rest to i. It is feasible, passes,
and gives Π_E=1−kw, with Π_E−w=1−β(k+1)/m>0 because k+1≤m and β<1.
Consequently certain failure is never optimal.

For a proposal with positive passage probability, all invited weak responders
must receive at least w. If its coalition is larger than the quota, remove a
weak responder other than the proposer while retaining H if present; transfer
that responder's positive allocation to the proposer. Such a responder always
exists: a coalition containing H with |C|>k+1 has at least k weak responders;
one without H has more than k. This alternative remains feasible, preserves
all remaining votes, H's type-contingent acceptance set, and failure
continuations. The expected gain is the removed allocation times the positive
passage probability. Repeat until |C|=k+1. This is a comparison of complete
proposals made before the ballot, not a reallocation after a rejection.

For minimal coalitions, reduce every invited weak payment to w and remove all
slack by raising x_i. If H is present, reduce x_H to the lowest threshold for
its acceptance set of positive-probability types. The only candidates that
can be optimal are E (H excluded, k weak partners), S (H and k−1 weak partners,
x_H=βℓ), and P (H and k−1 weak partners, x_H=βh). The residual goes to i.
The candidate payoffs and linked H values are

| Form | Proposer payoff | H low | H high | Outcome |
|---|---|---|---|---|
| E | 1−kw | ℓ | h | R1 passes without H |
| S | (1−μ)[1−(k−1)w−βℓ]+μw | βℓ | βh | low R1 passage; high R2_M continuation |
| P | 1−(k−1)w−βh | βh | βh | R1 passage for both |
| certain failure | w | βℓ | βh | dominated by E |

An infeasible S/P cannot defeat E. For P, Π_P≥Π_E>0 ensures a positive
residual. For S, when μ<1, Π_S≥Π_E>w implies its accepted residual is >w>0;
when μ=1 screening gives w and cannot defeat E. Thus comparisons of the
three algebraic payoffs never select an infeasible allocation. The argument
does not assign probability to a current posterior-zero type; its prescribed
votes and conditional payoff coordinate are still retained in the assessment.

## Exact majority selection, equality, and multiplicity

The primary differences are

    Π_P−Π_E = β(1/m−h),
    Π_S−Π_E = (1−μ)β(1/m−ℓ) − μ[1−β(k+1)/m].

For h<1/m, E is dominated by P and the S/P crossing is
t_SP=β(h−ℓ)/(1−βℓ−βk/m). For ℓ<1/m<h, P is dominated by E and
t_SE=β(1/m−ℓ)/[β(1/m−ℓ)+1−β(k+1)/m]. These thresholds lie strictly
between zero and one. S is selected below and at the respective crossing.
If 1/m<ℓ<h, E is selected throughout. If ℓ=1/m<h, S is selected at μ=0
and E at μ>0. If ℓ<h=1/m, S is selected for μ≤t_SE=t_SP; above it E and
P tie in proposer payoff. The secondary rule selects E when
(1−μ)ℓ+μh<βh, P when >βh, and arbitrary lotteries over E and P when equal.
At every S tie its H payoff is strictly smaller than the tied alternative:
E minus S is (1−β)[(1−μ)ℓ+μh]>0, and P minus S is β(1−μ)(h−ℓ)>0.
The S/P crossing is below one, so the latter comparison is indeed strict.

For each recognized i, identities of equally priced partners may be chosen
arbitrarily or randomized. Each surviving E/P mixture uses its actual common
proposal weight to determine all payoff coordinates and histories. At R2,
any optimal winning all-weak coalition can be selected. These identity and
nominal-membership freedoms are not erased by the payoff formulas. The
economic marginal of H is the specified segment, not independent coordinate
intervals. There is no further economic proposal form.

## Anonymous majority continuation interface consumed by the agenda

This paragraph defines representatives of the baseline correspondence, not
all its history-dependent selections. Recognize i uniformly. In E choose k
weak partners uniformly; in S/P choose k−1 weak partners uniformly. Use the
threshold allocations above. In S after a high-type rejection, recognize a
new proposer independently in R2 and use the minimal all-weak uniform kernel
specified in `r2_interface.md`. Use that kernel also after every failed
off-path R1 proposal. In an E/P mixture use the same λ∈[0,1] for the E
probability at every recognized proposer and all outcome coordinates. This
produces a full literal kernel containing C, allocation, invited votes,
recognition and outcome, including the extra R2 randomization after S fails.

The compact branch-label space is {E,S,P} disjoint union ({EP}×[0,1]). Only
labels admitted by the selection just proved are allowed at a given μ.
An anonymous Borel selector χ(μ) in that correspondence is an input to the
agenda. For a weak state its interim native R1 value c_χ and H's type values
h_χ are

| χ | c_χ(μ) | h_χ,ℓ | h_χ,h |
|---|---|---|---|
| E | 1/m | ℓ | h |
| S | [(1−μ)(1−βℓ)+μβ]/m | βℓ | βh |
| P | (1−βh)/m | βh | βh |
| EP,λ | λ/m+(1−λ)(1−βh)/m | λℓ+(1−λ)βh | λh+(1−λ)βh |

The conditional weak values are 1/m for E; ((1−βℓ)/m,β/m) for S;
(1−βh)/m for both types in P; and the same common convex combination in EP.
All kernels are finite mixtures of literal deterministic records; branch
selection has Borel cells and λ enters affinely. With a Borel χ, posterior,
proposal, ballot and outcome kernels are Borel. Their complete off-path
baseline assessment uses the response map above and any admissible local
zero-denominator beliefs; choosing the entering μ for each such value gives
a Borel representative. These beliefs never affect majority continuation
payoffs. This is a closed interface; the agenda must multiply c_χ,h_χ by β
once to move from native R1 to date A.

## R1_U: complete assessment and exact institutional transport

Unanimity forces C=N at every proposal. Adding this constant label maps the
entire old U extensive form to the new one: actions, information sets, invited
votes, transitions and payoffs coincide for all profiles, including deviations.
The former cancelled-share branch never arose under unanimity. This literal
isomorphism transports its solution concept, not a majority equivalence claim.
For completeness the continuation and response completion are specified here.

Let A=β(1−ℓ)/m and B=β(1−h)/m. From R2_U a weak voter's R1 continuation at
posterior η is W(η)=(1−η)A for η≤p*, and B for η>p*. It lies in [B,A].
H's continuation is (βℓ,βh) in the low-offer branch and (βh,βh) in the
pooling branch. Let u=min_{j∈W\{i}}x_j, which does NOT include the proposer's
own allocation. Write H's pure profile in low/high order. The complete
admissible profile regions are:

* At μ=0 (initial low-only support), weak ballots are Y iff x_j≥A. H=(Y,Y)
  if u<A or [u≥A and x_H≥βh]; H=(N,N) if u≥A and x_H<βℓ; H=(Y,N) if
  u≥A and βℓ≤x_H<βh. (N,Y) never occurs. Both post-H beliefs are zero.
* At p*<μ<1, H=(Y,Y) if u<B or [u≥B and x_H≥βh]; weak ballots are Y iff
  x_j≥B and η_Y=μ. The free η_N may be any value in [0,1]. H=(N,N) if
  u≥B and x_H<βh; all weak ballots are Y, η_N=μ, and the free η_Y must
  satisfy W(η_Y)≤u. These conditions are necessary as well as sufficient.
  No separating H profile is admissible. A Borel representative sets every
  free η to μ; it satisfies the stated restriction.
* At μ=1 (initial high-only support), the same two pooled-profile regions
  hold, both post-H beliefs are one, and all support restrictions are retained.

To verify the high-belief regions, H=(Y,Y) pins η_Y=μ and hence weak threshold
B. If a weak veto prevents passage, low H receives βh after yes and at most
βh after no; high H receives βh either way, so Y is optimal with T^Y. If all
weak votes are Y, both types accept exactly when x_H≥βh. H=(N,N) pins η_N=μ,
so both types obtain βh; to sustain strict N, all weak votes must be Y and
x_H<βh. Their pivotal comparison uses W(η_Y), producing the stated condition.
Under (Y,N), η_N=1 gives both H types βh after no; low yes requires x_H≥βh
and high no requires x_H<βh, a contradiction. Under (N,Y), high yes requires
x_H≥βh, while low no offers only βℓ, again impossible; weak-veto alternatives
also violate a strict N or T^Y. The low endpoint follows directly from fixed
zero belief and the two type thresholds. At the high endpoint the same T^Y
argument excludes a separating profile involving the zero-probability type.

For 0<μ≤p*, the feasible proposal s† sets x_H=βℓ, x_j=A for all weak
responders, and x_i=1−βℓ−(m−1)A=A+1−β>0. Every weak vote must be Y because
A is the maximal continuation. None of H's four pure profiles works:
(Y,Y) lets high switch to no for βh>βℓ; (N,N) pins η_N=μ and gives low βℓ,
so T^Y requires yes; (Y,N) lets low imitate no and obtain βh; (N,Y) lets high
switch to no and obtain βh instead of βℓ. Bayes is applicable to both actions
in each separating profile because 0<μ≤p*<1. Thus the entire PBE
correspondence in pure ballots is empty, including off-path requirements.

At μ=0 the optimum is C=N, x_H=βℓ, x_j=A to each weak responder and
x_i=A+1−β. At μ>p* it is C=N, x_H=βh, x_j=B and x_i=B+1−β. Every passing
proposal must pay these relevant floors; any delay gives the proposer at
most its corresponding A or B continuation on the prescribed profile.
Agreement gains 1−β. Native H values are (βℓ,βh) at zero, and (βh,βh)
above p*. Native interim weak values before uniform recognition are
(1−βℓ)/m at zero and (1−βh)/m above p*. At μ=0 the high-type conditional weak
value is zero: if that counterfactual type occurs, R1 and R2 low offers fail.
It is retained in the literal law, not replaced by the low-type value.
Off-path free beliefs are restricted by the original support, exactly as in
the imported baseline convention. The agenda's endpoint continuation is the
declared complete endpoint assessment, as in the existing extension contract.

## Public benchmark, private comparisons, and scope of invariance

For public o, R1_U pays H=βo and each weak responder β(1−o)/m, leaving the
proposer 1−βo−(m−1)β(1−o)/m. R1_M compares inclusion cost βo+(k−1)w with
exclusion cost kw. Inclusion is selected at o≤1/m (at equality the secondary
tie-break gives βo<o to H), exclusion above. Thus H's public values remain
v_M(o)=βo for o≤1/m and o otherwise; v_U(o)=βo.

The private H vectors remain S=(βℓ,βh), P=(βh,βh), E=(ℓ,h), with linked
mixtures and U=(βℓ,βh) at zero, empty for 0<μ≤p*, (βh,βh) above p*.
Consequently all componentwise public/private differences and the baseline
institutional comparisons are unchanged, including empty cells and equality
segments. This preserves the economic formulas used in the existing figures.
It does not assert equality of nominal coalition membership, ballot vectors,
all off-path assessments, or the agenda signaling game. Majority exclusion
now means H was not invited, not that it voted against a package that passed.
Under U the exact game isomorphism is stronger and includes those histories.
