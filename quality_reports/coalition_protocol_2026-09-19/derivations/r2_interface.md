# Native-date terminal interfaces: R2 majority and unanimity

Implementer `/root`; governing extensive form `game_contract.md`. Domain:
m≥3, 0<ℓ<h<1, posterior μ∈[0,1], with the preserved support discipline.
These interfaces contain no discount factor. Independent review is pending.

## R2_M: strategies and all deviations

Every invited weak voter has disagreement value zero and accepts every
nonnegative allocation, including zero under T^Y. Since q_M=k+1≤m, the
recognized weak proposer can choose C⊆W with i∈C and |C|≥q_M and x=e_i.
This passes and gives the proposer one, the maximal feasible payoff.

If H is invited, all other invited players accept; type o accepts exactly
when x_H≥o. A proposal accepted with positive probability and x_H>0 yields
strictly less than one on that event. A proposal rejected with positive
probability also yields strictly less than one in expectation. In particular,
inviting H with x_H=0 is rejected by every possible type and cannot attain one.
Any positive payment to another weak player or undistributed slack similarly
reduces the proposer's payoff. These statements apply with degenerate beliefs
without assigning positive probability to an impossible type. Thus all
optimal proposals have C⊆W, x=e_i, and all invited ballots Y.

The allocation, date, and type-payoff outcome are unique; nominal membership
is not: every winning all-weak C containing i is optimal, including oversized
C. Off-path H ballots use the threshold o, not a comparison with βo. Weak
proposals and weak votes preserve belief. If H is invited, Bayes and the
ballot-local free values follow `game_contract.md`; these values affect no
R2 payoff or vote. All terminal failures pay (o,0,…,0), whatever the votes.

Native values before recognition are H=(ℓ,h), and 1/m for each weak player.
One anonymous literal representative recognizes i uniformly, chooses k
partners uniformly from W\{i}, proposes e_i to C={i}∪T, and records those
invited Y votes. Other optimal nominal C choices are retained as baseline
multiplicity; this representative will be used in the agenda kernel.

## R2_U: strategies, beliefs, and the threshold

The only feasible coalition is N. Every weak responder accepts zero; H accepts
iff x_H≥o. Trimming any responding weak payment to zero and any H offer to the
lowest threshold with the same acceptance set weakly improves the proposer,
strictly whenever passage has positive probability and a positive amount is
trimmed. Certain failure gives zero and is dominated by the feasible pooling
offer h<1. The only optimal candidates are x_H=ℓ and x_H=h, assigning the
residual to i. Their expected proposer payoffs are (1−μ)(1−ℓ) and 1−h.

Let p*=(h−ℓ)/(1−ℓ). For μ≤p* the low offer is selected; for μ>p* the high
offer is selected. At p* the proposer is indifferent and the low offer gives
H strictly lower expected payoff: (1−p*)ℓ+p*h<h, so the secondary tie-break
selects it. This also establishes the degenerate-belief choices μ=0 and μ=1.
The voting rules stated above complete every feasible off-path proposal.
Post-vote beliefs use the preserved Bayes/local-free discipline and never
enter terminal payoffs. There is no earlier-round parameter in these choices.

Native type-contingent H values are (ℓ,h) for μ≤p*, and (h,h) for μ>p*.
Before recognition each weak player's interim value is

    c2_U(μ) = (1−μ)(1−ℓ)/m   if μ≤p*,
              (1−h)/m        if μ>p*.

Its conditional values by H type are ((1−ℓ)/m,0) in the low-offer branch,
and ((1−h)/m,(1−h)/m) in the pooling branch. The linked outcome law recognizes
i uniformly, proposes the stated vector, records all weak votes Y and H's
threshold vote, and either passes or terminates in disagreement. Belief
multiplicity has no economic effect; no type-contingent coordinates are
discarded merely because their current probability is zero.

## Public types and transport

For a known o, R2_M values are (o,1/m,…,1/m); R2_U pays H=o and weak values
(1−o)/m. R1 imports exactly β times each value. No discount appears in either
leaf solution. Under U this new game is the old extensive form with the
constant proposal label C=N added; the argument above also derives it directly.
