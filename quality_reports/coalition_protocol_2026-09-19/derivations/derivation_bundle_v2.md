# Coalition derivation candidate v2

This frozen bundle reproduces five mathematical sources verbatim. The first three are byte-identical to v1; agenda_transport corrects F001 and F003 and imports the new F002 lemma. Source hashes are in reviews/derivation_candidate_v2.json. Code-style relative references inside copied notes use the original derivations/ logical root unless their current file is explicit. Independent review of these repaired bytes is pending.


<!-- BEGIN derivations/v2/game_contract.md sha256=ac78634ea0da03b422a6d92930680d1bb1f94deee0d3c33b68dc9d9791a7d058 -->

# Coalition protocol: extensive form and dependency contract

Author decision: `../author_decision.md`, 19 September 2026. Implementer: `/root`.
This is the adopted candidate, not an assertion that the former quota ballot is
the same game. Mathematical closure below is distinct from independent review.

## Primitives, histories, and information sets

There are players N={H}∪W, |W|=m≥3. Nature chooses o∈{ℓ,h},
0<ℓ<h<1, with probability p of h. Only H observes o. The common discount
factor is 0<β<1. Every baseline round begins with independent uniform
recognition of one weak state i. The two institutions share the same protocol:
q_M=k+1, k=floor((m+1)/2), and q_U=m+1. The proposer selects y=(C,x), where
i∈C⊆N, |C|≥q, x∈R_+^{m+1}, sum x≤1, and x_j=0 for j∉C. All invitees
other than i vote simultaneously, with i counted yes. Noninvitees do not vote.
The proposal and coalition are public before voting; the entire invited vote
vector is public only after the ballot. H's type is never directly observed.

| History | Mover and observed information | Action / transition |
|---|---|---|
| Before R1/R2 recognition | Nature; all observe round and full public past | i uniform in W |
| Proposal in round t | i observes the public past, own recognition, current belief; not o | choose feasible (C,x) |
| Ballot in round t | invitees observe (C,x) and public past; H additionally knows o | simultaneous Y/N; pass iff every invitee consents |
| Pass | no further decision | implement x automatically; terminate |
| Failure R1 | all observe the invited vote vector | no current payoff; enter R2 |
| Failure R2 | no further decision | terminal disagreement |

On passage each weak state receives x_j, including zero for excluded states.
H receives x_H if H∈C and o if H∉C. On terminal disagreement H receives o
and all weak states receive zero. R2 outcomes are measured in R2 units; R1
failure imports them with exactly one factor β. A no vote alone triggers no
outside-option payment or irreversible exit. In particular, excluding H in
an R1 agreement pays o at R1, whereas an R1 failure pays only the discounted
continuation. The unit pie is fixed and does not depend on C or o. The outside
option is outside that pie and independent of the agreement among weak states.
There is no additional individual action to implement or obtain an allocation.

## Beliefs and solution concept

Maintain PBE with pure ballots, as-if-pivotal weak voting, acceptance at exact
expected-value indifference (T^Y), and a proposer tie-break minimizing H's
expected payoff among its own payoff-maximizing proposals. Proposal mixtures
survive only where both comparisons tie; the same weights determine all
payoffs and outcome laws. Weak actions, including both components (C,x), carry
no information about o. If H∉C the entire weak ballot preserves the entering
belief. If H∈C, after any invited vote vector the posterior is determined by
the entering belief, the profile's type-contingent H vote law at that ballot,
and H's realized vote. Bayes applies when the denominator is positive,
including ballots reached by a weak deviation. Otherwise one free value is
attached to that ballot-and-H-vote pair within the support of the original
prior. All vectors in that ballot with the same H vote share that value.
Distinct ballots, including different C, may have different free values.
This is the August/September declared discipline, adapted only to H's absence
from ballots of coalitions that exclude it. It is not sequential-equilibrium
consistency, nor unrestricted belief choice after weak deviations.

The as-if-pivotal comparison applies to invited weak voters after every
proposal. Their no changes passage to failure in the pivotal comparison.
When the profile makes H's affirmative action a zero-probability event, the
approved local belief attached to that action supplies its continuation
comparison, as in the existing unanimity correspondence. This does not add a
new belief restriction. H best responds to the prescribed weak votes; if a
weak veto makes passage impossible, it compares the two belief-dependent
continuations and uses T^Y at equality.

## Payoff completeness and nonaccumulation

Every feasible proposal and every vote vector has exactly one transition in
the table. If H∈C and votes no, passage is impossible, including in oversized
coalitions. If H∉C and the contract passes, x_H=0 by feasibility. If H∈C and
the contract passes, it consented and receives its proposed share. Thus no
history pays H a positive share of an implemented contract and its outside
option. This uses the author-adopted contract and support restrictions, not
optimality, removal of an inconvenient history, cancellation after passage,
or a repayment to the proposer. The conclusion covers arbitrary proposal and
vote deviations, not merely optimal proposals. Feasible oversized coalitions
and zero-payment invitees remain in the action space.

## Sufficient states and dependencies

For baseline payoff formulas retain (round,institution,current belief,
original support,recognized proposer). Complete assessments retain the full
public history so that allowed local free beliefs and identity-dependent
selections are not erased. R2 majority values are belief-free; R2 unanimity
values are functions of the posterior. The unanimity coalition is always N.
Only the explicitly specified anonymous representatives used by the agenda
extension compress baseline outcome kernels to the posterior and the selected
branch. This is a declared continuation restriction, not a theorem about all
history-dependent baseline assessments.

The acyclic dependency order is R2_M→R1_M and R2_U→R1_U, then public/private
comparisons and agenda A. Here the arrow means 'is consumed by'. Terminal
interfaces are closed and hashed before R1 is derived. R1 interfaces are closed
and hashed before the agenda implementer closes its parameterized work. The
execution manifest is `game_dag.json`. 'pass' there means a mathematically
specified, stable implementation interface; independent review status is
recorded separately, without promotion of historical reviews to this candidate.

Changing any interface invalidates its descendants and their associated review
claims until they are rederived/rechecked against the new hash. Under U,
adding/removing the constant label C=N is an extensive-form isomorphism with
the previous U game. Under M, neither all strategies nor all deviations are
claimed to be equivalent to the previous game.

<!-- END derivations/v2/game_contract.md -->


<!-- BEGIN derivations/v2/r2_interface.md sha256=c83cf10483bf42e750e131a0792eedde60ae0eed244822c84ea2a1be285dd8a7 -->

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

<!-- END derivations/v2/r2_interface.md -->


<!-- BEGIN derivations/v2/r1_interface.md sha256=a07a14a115de877411319568a2982e6b5e6e6a8d03c550ead82a6e7078b487e0 -->

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

<!-- END derivations/v2/r1_interface.md -->


<!-- BEGIN derivations/v2/agenda_transport.md sha256=223d70575f64ca60b8807ab6e0bff5fec8819328a8a4d91fc10f22825f3f6c04 -->

# Agenda sob contratos de coalizão: derivação, limites de transporte e leis completas

Data: 2026-09-19. Implementador: `agenda_source_read`. Documento fora do manuscrito, destinado a revisão independente. A nova autoridade é `quality_reports/coalition_protocol_2026-09-19/author_decision.md`; A1–A3 não são adotadas. Fonte histórica: `formal_model_v6.Rmd`, SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`, HEAD observado `c6dfab61a5a3b44d09ba389911df47726f81b51e`. A leitura histórica em `quality_reports/peio_2027_2026-09-19/source_reads/agenda.md` permanece aplicável à identificação de claims, não ao novo protocolo.

**Candidata v2, sem aprovação independente:** incorpora F-001 e F-002, confirmados em `adjudication/preliminary_v1.json`, e a precisão de F-003/QI-05, confirmada pelo coordenador a partir de `reviews/formal_derivations_v1.md` e do contrato v1. F-001 corrige a álgebra de A-C5; F-002 é demonstrado em `v2/unanimity_support_lemma.md` e fecha as duas invocações de \(x^h\) em B.8. F-003 explicita a probabilidade um no argmax já exigida por A14, sem acrescentar contenção do suporte topológico nem novo refinamento. As cópias v2 de contrato/R2/R1 são idênticas aos bytes v1. Os 409 checks descritos na seção 12 continuam sendo o registro histórico v1; não foram reexecutados. Os novos checks de F-001 estão separados em `v2/repaired_algebra_checks.py` e seu JSON. Os demais pontos permanecem fora desta intervenção.

## 1. Resultado e fronteira lógica

Sob maioria, a extensão deve ser formulada sobre sinais públicos `(C,x)`, pois a identidade dos convidados pode informar o tipo de H. Não há equivalência de jogos com a formulação histórica cujo sinal era somente x. Há dois fatos concretos:

1. Em qualquer proposta de A que passa, os convidados fracos recebem parcelas estritamente positivas; portanto C é recuperável de x **nesse ramo**. Com a interface econômica E/S/P abaixo, toda proposta aprovada usada em equilíbrio tem exatamente k convidados fracos, quase certamente sob a lei de cada tipo.
2. A mesma alocação pode passar com uma coalizão e fracassar com outra que acrescente um convidado com parcela zero. Essas são mensagens públicas distintas. A seção 7 constrói um equilíbrio puro no qual os tipos usam o mesmo x e se separam apenas por C. Também constrói um equilíbrio histórico com pequena parcela para um fraco dispensável cujo vetor x não pode passar em nenhuma coalizão factível nova.

Apesar dessa mudança da correspondência estratégica, as condições de **payoff** das formas puras de maioria são novamente deriváveis, assim como o critério exato de membership de medidas Borel no espaço novo. Os benchmarks públicos, o limite majoritário seguro, a região suficiente de vantagem da maioria e o exemplo de reversão informacional conservam suas fórmulas, desde que a interface completa do novo baseline seja a descrita abaixo. A afirmação é uma nova derivação no novo espaço; não é transporte literal de todas as estratégias ou leis antigas.

Sob unanimidade, C é sempre o conjunto de todos os jogadores. Acrescentar/remover essa etiqueta constante é um isomorfismo da árvore inteira, inclusive desvios e payoffs. A agenda unânime e seu baseline histórico podem ser transportados por esse mapa, condicionadamente à correção dos resultados históricos citados.

**Fechamento como candidata de implementação:** as interfaces completas R2/R1 do coordenador foram recebidas, lidas integralmente e tiveram seus hashes conferidos antes de fechar a solução da agenda. Seus identificadores estão na seção 13. Elas coincidem com a interface parametrizada usada nas provas e especificam os votos/crenças off-path e kernels que faltavam ao trabalho estrutural inicial. Este fechamento depende desses bytes e de sua correção; não é PASS de revisão independente. A ordem respeita `solve-dynamic-games`: o trabalho anterior ao recebimento limitou-se ao contrato e aos teoremas parametrizados, sem promover a continuação a resultado certificado.

## 2. Contrato do estágio A

Há H e W={1,…,m}, m≥3, e N={H}∪W. O tipo de H é o∈{ℓ,h}, 0<ℓ<h<1, com prior p∈[0,1]. H conhece seu tipo. O fator de desconto é β∈(0,1). Escreva k=⌊(m+1)/2⌋ e q=k+1. Em A, H propõe obrigatoriamente.

As coalizões admissíveis em A são

\[
\mathcal C_M^A=\{C\subseteq N:H\in C,\ |C|\ge q\},
\qquad \mathcal C_U^A=\{N\}.
\]

Para cada C, defina

\[
X_C=\{x\in\mathbb R_+^{m+1}:\sum_{i\in N}x_i\le1,
\ x_i=0\text{ se }i\notin C\},\qquad
Y_g=\bigsqcup_{C\in\mathcal C_g^A}(\{C\}\times X_C).
\tag{A1}
\]

O sinal público é y=(C,x). Cada componente tem a topologia euclidiana relativa; coalizões distintas são componentes distintas. Essa é a extensão tipada da disciplina de sinais existente: uma coalizão pública não pode ser esquecida antes da atualização de crenças. A união é finita de simplexes compactos, portanto Y_g é compacto metrizable e padrão Borel. Pode-se usar uma métrica que coincida com a euclidiana em cada componente e separe coalizões distintas por distância maior que o diâmetro de um simplex. Uma permutação de nomes fracos age por isometria.

| Nó | Informação/ações | Transição/payoffs |
|---|---|---|
| H propõe em A | Observa tipo e história pública; escolhe qualquer y∈Y_g. | Proposta e coalizão tornam-se públicas. O proponente conta como sim. |
| Consentimento | Cada j∈C\{H} observa y; votos simultâneos e puros. Não convidados não votam. | Só o consentimento de todos os convidados implementa o pacote. |
| Passagem | Nenhuma decisão adicional de execução. | H recebe x_H; convidados fracos recebem x_j; excluídos recebem zero. Como H é proponente, H pertence a C. |
| Recusa de algum convidado | Vetor dos votos efetivos e resultado tornam-se públicos. | Nenhum pagamento em A; entra-se em um assessment completo de R1 sob a mesma instituição e posterior. |

É conveniente codificar a participação no vetor de votos por `⊥` para não convidados; `⊥` não é voto não nem ação adicional. Uma recusa de convidado rejeita inclusive uma coalizão superdimensionada. Não existe opção de H escolher C sem si, votar outra vez em A, saltar a proposta, ou executar uma alternativa depois da aprovação.

Mantêm-se as restrições específicas da extensão histórica: seleção pública, anônima e Markov da continuação por instituição, estágio e posterior; disciplina local de Bayes no suporte dos sinais; um único μ^off=b_ρ(p) fora do suporte; e votos fracos as-if-pivotal com sim na igualdade. Não se impõem essas restrições Markov/off-support às crenças internas do baseline. A fonte completa importada continua seguindo a disciplina própria do baseline.

Se σ_ℓ,σ_h∈P(Y_g) são leis Borel e \(\bar\sigma=(1-p)\sigma_\ell+p\sigma_h\), seja S=supp(\barσ). Para p interior, a condição local passa a ser

\[
\mu(C,x)=\lim_{\varepsilon\downarrow0}
\frac{p\,\sigma_h(B_{Y_g}((C,x),\varepsilon))}
     {\bar\sigma(B_{Y_g}((C,x),\varepsilon))}
\quad\text{para todo }(C,x)\in S.
\tag{A2}
\]

O denominador é positivo no suporte; a existência do limite em todos os pontos, inclusive limites de massa zero, é requisito mantido. Fora de S, μ=μ^off. Nos endpoints, μ=p em todo Y_g e o tipo de probabilidade zero ainda recebe estratégia e payoff contrafactual. O mesmo argumento Borel por razões de medidas de bolas e limites pontuais usado na fonte histórica aplica-se em cada uma das finitíssimas faces; logo μ é Borel. Bayes também satisfaz a identidade de medidas \(\int_E\mu\,d\bar\sigma=p\sigma_h(E)\) para conjuntos Borel E. Não se usa posterior calculado da projeção x se C também é observado.

## 3. Interface de continuação e ordem de dependência

Denote por B_g^C(μ) a correspondência completa do **novo** baseline na crença de entrada μ, com suas convenções de suporte e endpoints. A seleção κ_g(μ) precisa devolver um membro literal completo admissível, público e comum aos tipos compatíveis com a história. Esse membro contém estratégias, crenças, reconhecimento, coalizões, votos efetivos, payoffs e leis de terminais. Seu kernel realizado e os mapas usados a seguir devem ser Borel. Não basta fornecer c e h como números.

A ordem de dependência é

\[
\text{novo R2}_g\to\text{novo R1}_g\to
\kappa_g(\mu)\to\text{votos em A}\to
\text{propostas de H}\to\Gamma_g\to
\text{assinaturas/comparações}.
\]

Não se rederiva aqui R1/R2. A interface econômica conferida no pacote fechado do coordenador é:

| Estado majoritário selecionado ξ | Valor nativo comum de um fraco c_ξ(μ) | Vetor nativo de H h_ξ=(h_ℓ,h_h) |
|---|---|---|
| E: exclusão | 1/m | (ℓ,h) |
| S: screening | `[(1−μ)(1−βℓ)+μβ]/m` | (βℓ,βh) |
| P: pooling | (1−βh)/m | (βh,βh) |
| EP: mistura residual | λc_E+(1−λ)c_P | λh_E+(1−λ)h_P |

Na interface, S só é selecionado quando Π_S≥Π_E; P só é selecionado quando h≤1/m; EP só na igualdade residual autorizada, usando **o mesmo λ** nos payoffs, propostas, coalizões e kernel. O representante anônimo fechado pelo coordenador reconhece i uniformemente e sorteia uniformemente k parceiros fracos em E e k−1 em S/P; R2 majoritário usa uma coalizão mínima de q fracos, também uniformemente. A eventual multiplicidade de outras coalizões de R2 não é removida do jogo: esse representante é a seleção específica consumida pela extensão.

Escreva χ(μ) para o estado e suas escolhas literais. Os valores na data A são

\[
r_\chi(\mu)=\beta c_\chi(\mu),\qquad
d_{\chi,o}(\mu)=\beta h_{\chi,o}(\mu).
\tag{A3}
\]

Há exatamente um β entre R1 e A. Nenhum pagamento é realizado em A quando há recusa. Sob unanimidade, a interface histórica é transportada pelo isomorfismo da seção 9: seu domínio é \(\{0\}\cup(p^*,1]\), com \(p^*=(h-\ell)/(1-\ell)\), sujeito à validade da caracterização histórica. Os valores de rejeição são β²ℓ para o baixo em μ=0, β²h para o alto em μ=0 e β²h para ambos em μ>p*.

## 4. Votos, coalizões e garantias: provas locais

### Proposição A-C1: regra de consentimento

Dado y=(C,x) e posterior μ, cada fraco convidado j aceita se e somente se x_j≥r_χ(μ), com igualdade aceita. Assim

\[
a_M(C,x)=\prod_{j\in C\setminus\{H\}}
1\{x_j\ge r_\chi(\mu(C,x))\}.
\tag{A4}
\]

**Prova.** Sob a comparação pivotal prescrita, seu sim entrega x_j se todos os demais convidados consentem e seu não entrega o valor da continuação de R1, transportado uma vez. O seletor Markov usa o mesmo posterior após qualquer recusa fraca: a recusa não informa o tipo e o seletor não depende de C, x ou do vetor de recusas além de μ. Portanto a diferença relevante é x_j−r_χ(μ). Sim na igualdade conclui. A regra é aplicada também quando outro voto prescrito faz a pivotalidade factual ter probabilidade zero, conforme a disciplina as-if-pivotal mantida. Não convidados não fazem comparação nem emitem voto. □

### Proposição A-C2: recuperação de C no ramo que passa

Se r_χ(μ)>0 e y passa, então

\[
C=\{H\}\cup\{j\in W:x_j>0\}.
\tag{A5}
\]

**Prova.** Todo convidado fraco que consente recebe ao menos r>0. Todo não convidado tem parcela zero pela factibilidade. H pertence a C por ser proponente, independentemente de x_H. □

Isso não é definição do espaço de ações. Coalizões com convidados de parcela zero continuam factíveis e são rejeitadas em A. A identidade não autoriza atualizar crenças apenas por x antes de saber que se trata de um ramo que passa, nem autoriza omitir C de terminais rejeitados.

### Proposição A-C3: escolha ótima a posterior fixado

Se 0<r≤β/m, a melhor proposta que passa **a um posterior dado** compra exatamente k votos fracos, paga r a cada um e deixa

\[
a_\chi^{pass}(\mu)=1-k r_\chi(\mu)
\tag{A6}
\]

a H. Toda parcela z∈[0,a^pass(μ)] pode ser implementada por uma coalizão mínima: pague r aos k convidados e deixe o orçamento restante não alocado. Uma proposta com x_H=1 e parcelas fracas zero, em qualquer C admissível, é rejeitada e produz d_χ,o(μ).

**Prova.** Se há s≥k convidados fracos, passagem exige custo pelo menos sr, estritamente crescente em s. Com k convidados o limite é atingido e a soma é um; com share z menor, a soma é no máximo um. Na proposta de rejeição cada convidado fraco prefere estritamente a continuação, pois r>0. □

A conclusão de melhor oferta condicionada a μ não prova que toda proposta de equilíbrio privado maximize a parcela a esse μ: uma alteração de mensagem pode alterar a crença. A próxima proposição fornece um argumento independente das crenças contra passagem com coalizão superdimensionada.

### Proposição A-C4: limite uniforme e exclusão de passagem superdimensionada usada em equilíbrio

Na interface da seção 3, escreva w=β/m. Então, para todo posterior e estado selecionável,

\[
\frac{1-w}{m}\le c_\chi(\mu)\le\frac1m,
\qquad w(1-w)\le r_\chi(\mu)\le w.
\tag{A7}
\]

Em todo assessment de agenda existente e para cada tipo,

\[
V_M^A(o)\ge v_M^{safe}:=1-kw.
\tag{A8}
\]

Uma proposta aprovada com pelo menos k+1 convidados fracos dá a H estritamente menos que v_M^safe. Logo não é um desvio lucrativo contra um assessment existente e não pode ser usada com probabilidade positiva por nenhum tipo em equilíbrio. Em particular, toda proposta aprovada usada em equilíbrio tem |C|=k+1, quase certamente.

**Prova do limite.** Em E, c=1/m. Em P, h≤1/m implica 1−βh≥1−w. Para S, ponha t=βℓ. As utilidades do proponente na interface são

\[
\Pi_E=1-kw,\qquad
\Pi_S=(1-\mu)[1-(k-1)w-t]+\mu w.
\]

Uma identidade direta dá

\[
mc_S-(1-w)=(\Pi_S-\Pi_E)+\mu(\beta-kw)\ge0,
\tag{A9}
\]

pois S só é selecionável quando Π_S≥Π_E e k<m. Os limites superiores seguem das fórmulas; EP preserva ambos por convexidade com o mesmo peso. Multiplique por β para obter (A7).

**Prova da garantia e da cardinalidade.** H pode convidar quaisquer k fracos, pagar w a cada um e ficar com 1−kw. Essa proposta passa qualquer que seja o posterior, pois todos os preços são no máximo w. Portanto (A8) independe de crenças. Se há pelo menos k+1 convidados e passagem, (A7) e factibilidade dão

\[
x_H\le1-(k+1)w(1-w)
<1-kw,
\tag{A10}
\]

porque a diferença entre o lado direito de (A8) e o primeiro limite de (A10) é \(w[1-(k+1)w]>0\); k+1≤m e β<1. Isso exclui a proposta do argmax de cada tipo. Em medidas Borel, a igualdade de melhor resposta vale quase certamente; não se afirma que todo ponto de massa zero do suporte seja um argmax. □

Coalizões superdimensionadas **rejeitadas** não são excluídas. Sua recusa rende d_o no posterior que a mensagem induz, e C pode sinalizar o tipo. Não se pode substituir uma recusa por acordo com uma subcoalizão dos convidados originais: a proposta autorizada fracassa integralmente.

Também existe a garantia \(V_M^A(o)\ge\beta^2o\): uma proposta com parcelas fracas zero sempre rejeita e, em E/S/P/EP, o payoff de rejeição é ao menos β²o. Consequentemente

\[
V_M^A(o)\ge\max\{v_M^{safe},\beta^2o\}.
\tag{A11}
\]

## 5. Informação pública e condições de payoff das formas puras privadas

### Proposição A-C5: benchmarks públicos

Condicionalmente à interface pública de R1, as fórmulas públicas são

\[
v_U^A(o)=1-\beta+\beta^2o,
\qquad
v_M^A(o)=
\begin{cases}
1-k\beta(1-\beta o)/m,&o\le1/m,\\
\max\{1-k\beta/m,\beta o\},&o>1/m.
\end{cases}
\tag{A12}
\]

**Prova.** Com o público, os valores nativos de R1 são c=(1−βo)/m e h=βo quando a continuação inclui H, e c=1/m e h=o quando a maioria o exclui. Use (A3) e (A6). No primeiro ramo majoritário,

\[
1-k\beta(1-\beta o)/m-\beta^2o
=1-k\beta/m-\beta^2o(1-k/m)>1-\beta>0.
\]

A primeira desigualdade é estrita porque a diferença para \(1-\beta\) é \(\beta(1-k/m)(1-\beta o)>0\), usando \(k<m\), \(0<\beta<1\) e \(0<o<1\).

No segundo, compare passagem segura a βo. Toda proposta que passa e é ótima compra exatamente k convidados a seu cutoff; toda proposta rejeitada entrega a mesma continuação pública. No empate, qualquer medida sobre esses argmax é permitida, com o mesmo peso ligando sinal, passagem e payoff. Sob unanimidade, H precisa pagar todos os m fracos e passagem vence rejeição β²o por 1−β. □

Assim, o cutoff \(o_M^*=1/\beta-k/m\), o gap público e D_g da seção 6/E.6–E.8/E.12 conservam as fórmulas. A correspondência de **propostas rejeitadas** majoritárias passa a incluir C e não é literalmente a antiga. Sob maioria pública, as coalizões aprovadas ótimas continuam mínimas.

### Proposição A-C6: payoff das formas puras de maioria privada

Fixe χ e p interior. Defina

\[
A_t=a_\chi^{pass}(t),\quad d_{o,t}=d_{\chi,o}(t),\quad
O_o=\max\{A_{\mu^{off}},d_{o,\mu^{off}}\},\qquad t\in\{0,p,1\}.
\]

Sob a interface da seção 3, as condições necessárias e suficientes para existência de cada **forma pura e vetor de payoff** são:

| Forma | Condições | Vetor |
|---|---|---|
| Pooling com acordo | `O_h≤A_p`; z∈[O_h,A_p] | (z,z) |
| Pooling com recusa | `d_ℓ,p≥O_ℓ` e `d_h,p≥O_h` | (d_ℓ,p,d_h,p) |
| Separação, ambos acordam | `O_h≤min{A_0,A_1}`; z nesse intervalo | (z,z) |
| Baixo acorda, alto recusa | `d_h,1≥O_h`; `max{d_ℓ,1,O_ℓ}≤z≤min{A_0,d_h,1}` | (z,d_h,1) |
| Baixo recusa, alto acorda | Impossível | ∅ |
| Separação, ambos recusam | `d_ℓ,0≥d_ℓ,1`, `d_h,1≥d_h,0`, `d_ℓ,0≥O_ℓ`, `d_h,1≥O_h` | (d_ℓ,0,d_h,1) |

**Prova.** Um perfil puro tem no máximo dois sinais y. Em cada face X_C há infinitas propostas que recusam. A oferta mínima que passa em μ^off pode ser aproximada por ofertas que diminuem x_H por ε>0, preservam os k pagamentos e evitam os finitíssimos sinais em suporte. Assim o supremo off-support é exatamente O_o, mesmo que o pacote maximizador esteja no suporte. `O_h≥O_ℓ` pois o termo de passagem é comum e a rejeição do alto é fracamente maior.

No pooling, a crença é p; acordo produz z comum e recusa produz d_o,p. As condições da tabela são factibilidade e proteção contra off-support. Na separação, as crenças são 0 e 1. Se ambos os sinais passam, cada tipo pode copiar o par **(C,x)** do outro e obter sua parcela; imitação bilateral exige z comum. Se só o baixo passa, as duas restrições de imitação são z≥d_ℓ,1 e d_h,1≥z, acrescidas de factibilidade/off-support. O padrão reverso exigiria d_ℓ,0≥z≥d_h,0, impossível porque d_h,0>d_ℓ,0 na interface endpoint. Se ambos recusam, a imitação compara os dois d por tipo.

Para suficiência, construa acordos em coalizões mínimas conforme A-C3 e recusas com parcela zero para algum convidado. Os sinais separadores podem ser escolhidos distintos: há mais de uma coalizão mínima porque k<m; há também um contínuo de sinais rejeitados. Não é necessário apagar ou identificar coalizões superdimensionadas rejeitadas. Prescreva posterior 0/1 nos dois átomos, ou p no átomo pooling, e μ^off fora; cada face tem a topologia especificada em (A2), e Bayes nos átomos satisfaz a disciplina. As desigualdades excluem todas as propostas fora do suporte e toda imitação, e os votos são (A4). □

A tabela caracteriza payoffs e existência de formas. Um catálogo completo de **estratégias** deve ainda deixar variar todos os pares (C,x) que realizam cada forma e obedecem aos votos e à factibilidade. Não se deve substituir essa família por uma lista de propostas canônicas.

### Existência majoritária para algum ρ

Ponha T=v_M^safe/β. A construção histórica tem análogos factíveis novos:

- Se h≤T, use μ^off=p (ρ=1), χ fixado e pooling na proposta mínima que passa ao posterior p. A rejeição em E é no máximo βh≤v_safe; em S/P é no máximo β²h<v_safe; EP preserva a comparação. O acordo maximizador vence esses desvios.
- Se ℓ≤T≤h, use μ^off=1, faça o baixo passar com z=v_safe e o alto enviar proposta rejeitada. A tabela dá as condições: d_ℓ,1=βℓ≤v_safe≤βh=d_h,1, e A_0≥v_safe.
- Se T≤ℓ, o baseline exclui H em todos os posteriores, pois T>1/m. Ambos podem propor a mesma recusa e receber βo≥v_safe para qualquer ρ.

Os empates são retidos e endpoints são tratados pelo argmax. Isso prova existência para **algum** ρ em toda economia da interface, não para todo ρ fixado nem identidade com a correspondência histórica de leis.

## 6. Correspondência Borel exata no novo espaço

Um binder de maioria R_M^C contém, no mínimo,

\[
(\rho,\mu^{off},\sigma_\ell,\sigma_h,\bar\sigma,\mu,
\kappa_M,\chi,b_M,a_M,u_\ell,u_h,
K^D,\Gamma_\ell,\Gamma_h),
\]

onde σ_o∈P(Y_M), b_M:Y_M→{Y,N,⊥}^m é o vetor de votos efetivos dos fracos, a_M é passagem, κ_M é a seleção completa e K^D seu kernel literal. Todas as coordenadas pertencem ao mesmo binder. Escreva

\[
u_o(C,x)=a_M(C,x)x_H+[1-a_M(C,x)]d_{\chi,o}(\mu(C,x)),
\qquad V_o=\int_{Y_M}u_o\,d\sigma_o.
\tag{A13}
\]

O mapa u_o^off avalia y usando μ^off e a mesma seleção. Com S=supp(\barσ), defina

\[
\mathfrak O_o(S)=\sup_{y\notin S}u_o^{off}(y),
\]

com supremo do vazio −∞.

### Teorema A-C7: membership por ponto e por medida

Dada uma seleção admissível completa de continuacões, Bayes (A2), a regra (A4) e os payoffs (A13), um binder é equilíbrio exatamente quando, para ambos os tipos,

\[
u_o(y)\le V_o\quad\forall y\in S,\qquad
u_o(y)=V_o\quad\sigma_o\text{-q.c.},\qquad
V_o\ge\mathfrak O_o(S).
\tag{A14}
\]

**Prova.** Qualquer y, com qualquer C admissível, é desvio disponível a qualquer tipo. A primeira desigualdade elimina desvios no suporte, incluindo sinais do outro tipo e pontos limite de massa zero. A última elimina todos os desvios fora do suporte, incluindo convites extras destinados a obter uma recusa. Uma mistura de melhores respostas é apoiada no argmax quase certamente, produzindo a igualdade. Reciprocamente, as três condições eliminam qualquer proposta desviante; a regra pivotal determina os votos em toda proposta; e a interface importada determina comportamento sequencialmente racional após qualquer recusa. A parte de crenças já foi incluída nas hipóteses. □

A Borelidade segue por composição: μ e χ são Borel; os custos por estado são Borel; os conjuntos {y:x_j≥r_χ(μ(y))} são Borel como pré-imagens de [0,∞) pelo mapa Borel x_j−r_χ∘μ; produtos finitos e indicadores de componentes C são Borel; u_o é Borel. As integrais e kernels usados abaixo são, portanto, bem definidos. Não é alegada igualdade ponto a ponto de payoff em todo suporte: apenas desigualdade ponto a ponto e igualdade quase certamente.

Nos endpoints, posterior é fixado em p e cada σ_o pode ser qualquer medida que atribua probabilidade um ao argmax de u_o no novo Y_M, isto é, \(\sigma_o(\operatorname{argmax}_{Y_M}u_o)=1\). Seu valor é \(\max\{A_p,d_{o,p}\}\). A estratégia do tipo de probabilidade zero é incluída. Um ponto de suporte de massa zero precisa apenas satisfazer a ausência de desvio lucrativo, \(u_o(y)\le V_o\); a igualdade é exigida \(\sigma_o\)-quase certamente, não em todo ponto do suporte topológico. Não se exige \(\operatorname{supp}(\sigma_o)\subseteq\operatorname{argmax}_{Y_M}u_o\). Este critério é uma caracterização exata funcional, não uma enumeração finita de todos os suportes, e não acrescenta refinamento a A14.

## 7. Coalizão como sinal: duas contraprovas de equivalência literal

### Exemplo A-EX1: mesmo x, tipos separados por C

Tome m=4, k=2, β=.9, ℓ=.1, h=.9 e qualquer p interior. Use μ^off=1. Defina

\[
x=(.55,.225,.225,0,0),\quad
y_\ell=(\{H,1,2\},x),\quad
y_h=(\{H,1,2,3\},x).
\]

O baixo propõe y_ℓ e o alto y_h. Bayes no par observado dá μ(y_ℓ)=0 e μ(y_h)=1. Em zero, r_0=.20475, portanto 1 e 2 aceitam y_ℓ. Em um, r_1=.225; o convidado 3 recebe zero e recusa y_h, rejeitando o pacote inteiro. Os payoffs são (.55,.81).

O baixo que copia y_h recebe βℓ=.09<.55. O alto que copia y_ℓ recebe .55<.81. Fora do suporte, o melhor acordo deixa .55 e a rejeição dá .09 ao baixo e .81 ao alto; logo nenhum tipo melhora. Todos os votos fora do caminho seguem (A4). As propostas são factíveis e Bayes tem átomos isolados em componentes distintos. Assim o perfil satisfaz A-C7, condicionalmente à interface completa.

Esquecer C faz ambas as leis de proposta virarem o mesmo átomo x e perde tanto a revelação do tipo quanto a distinção acordo/recusa. Logo a projeção x não transporta este assessment para um assessment histórico com as mesmas leis, crenças e outcomes. O exemplo não afirma que seu vetor de payoffs fosse impossível em outra estratégia antiga.

### Exemplo A-EX2: parcela pequena ao fraco dispensável no jogo antigo

Tome m=4, k=2, β=.9, ℓ=.1, h=.6, p=.1 e μ^off=1. A continuação em p é S, pois p≤p_SE. Seu preço fraco é r=.204525. No jogo histórico, ambos os tipos podem propor

\[
x=(.56,.204525,.204525,.01,0).
\]

A soma é .97905. Dois fracos aceitam; o fraco com .01 recusa, mas o limiar majoritário é atingido. Ambos os tipos recebem .56. Fora do suporte, μ=1 implica melhor passagem .55 e rejeição (.09,.54), logo nenhum tipo melhora. O pooling é um assessment histórico admitido pela tabela E.2, com seus votos fora do caminho e a continuação selecionada.

No novo protocolo, qualquer C factível para esse mesmo x deve conter os fracos 1,2,3. A parcela .01 do terceiro é inferior ao custo de consentimento; ele recusa e o pacote inteiro fracassa. Não há coalizão factível que implemente esse x. Esse exemplo demonstra que nem toda law histórica de acordos é transportável preservando as alocações. Uma nova proposta pode conservar .56 e eliminar a pequena parcela deixando-a não alocada, mas isso é outro sinal e requer suas próprias crenças/IC; igualdade de payoffs não equivale a identidade de estratégias.

## 8. Testemunha para a tabela de reversão informacional do manuscrito

O exemplo da seção 6 (`formal_model_v6.Rmd`, 1001–1020) pode ser realizado no novo protocolo sem alterar seus números. Use m=4, β=.9, ℓ=.1, h=.9, p=.95 e **μ^off=0 sob ambas as regras**, isto é, a mesma fibra ρ=0.

Sob maioria, o baixo propõe C={H,1,2} e

\[
x^\ell=(.5905,.20475,.20475,0,0).
\]

O alto propõe, na mesma coalizão, x^h=(1,0,0,0,0), que fracassa. Os posteriores são 0 e 1. O payoff do alto é .81. A oferta baixa é a melhor passagem em posterior zero; desvios off-support dão ao baixo no máximo .5905 e ao alto no máximo max{.5905,.729}=.729. Imitação do alto pelo baixo dá .09; imitação do baixo pelo alto dá .5905. As IC são satisfeitas.

Sob unanimidade, ambos propõem C=N e

\[
x^U=(.729,.06775,.06775,.06775,.06775).
\]

O posterior é p=.95>p*=8/9. O custo por fraco nesse posterior é .04275, e a proposta passa. Em μ^off=0, a melhor passagem deixa .181 e o alto pode rejeitar para obter .729. Logo o pooling em .729 satisfaz as IC de ambos os tipos. O baixo tem payoff público majoritário .5905 e unânime .181; sua renda privada sob unanimidade é .548 e sob maioria zero. Os contrastes são

\[
\Delta v^A(\ell)=-.4095,\qquad
\Delta V^A(\ell)=+.1385,\qquad
\Delta IR^A(\ell)=+.5480.
\]

Essa é uma testemunha concreta de um par de assessments na mesma economia e fibra, não uma seleção imposta ao conjunto inteiro. Seus binders completos dependem das continuações importadas, cujos hashes estão registrados na seção 13.

## 9. Unanimidade: isomorfismo integral, incluindo off-path

### Teorema A-C8

O novo jogo unânime, tanto no baseline quanto no estágio A, é isomorfo ao histórico pela aplicação que acrescenta C=N em toda proposta e sua inversa que remove essa etiqueta.

**Prova.** A quota força C=N. Logo a restrição x_{−C}=0 é vazia e o espaço de alocações é exatamente o simplex histórico. A votação em unanimidade já exigia sim de todos os respondedores, com proponente sim e votos simultâneos. Assim, para qualquer vetor de votos, a proposta passa nos dois jogos exatamente nas mesmas circunstâncias. Se passa, todos recebem x e H recebe x_H. Se fracassa, seguem-se a mesma rodada ou o mesmo desacordo terminal, nas mesmas datas. O ramo histórico “H não e proposta passa” é impossível sob unanimidade. Todas as informações, ações, sinais, atualizações e desempates são preservados, incluindo propostas ou votos desviantes. A aplicação entre histórias e estratégias é bijetiva, preserva payoffs ponto a ponto e é homeomorfismo nas componentes de propostas. Portanto preserva suportes, bolas relativas, limites locais de Bayes e pushforwards. □

Isso permite transportar B.8/E.3 e os resultados unânimes E.9/E.13/F.2 sem inventar uma arquitetura de execução. O transporte não é uma nova prova da correção histórica de B.4/B.8: é uma prova de que a mudança aprovada não altera esses jogos. Seus claims de não existência continuam restritos aos votos puros e à disciplina aprovada.

O atalho histórico de B.8 que trata \(x^h\) como necessariamente fora do suporte é corrigido separadamente no [lema de suporte unânime](unanimity_support_lemma.md). Sob \(\mu^{off}>p^*\), o lema demonstra \(V=z_H\) também quando \(x^h\) pertence ao suporte com massa zero, recorrendo à identidade média de Bayes e à admissibilidade do limite local. Ele se aplica tanto à exclusão de um posterior off-support alto na família com \(\lambda_0>0\) quanto à determinação da solução \(\delta_{x^h}\) na família com \(\lambda_0=0\). O reparo mantém as células de existência e os payoffs; é uma candidata sujeita à revisão independente de v2.

## 10. Kernels, leis completas e assinaturas no espaço novo

### 10.1 Objetos e mensurabilidade

O kernel de continuação deve registrar a coalizão proposta em cada rodada, a alocação, o reconhecido, o vetor de votos efetivos (com ⊥ para não convidados), aprovação/recusa, data terminal e payoffs. Seja Ω_D^{g,C} um espaço ambiente compacto que acomode essas histórias terminais finitas: uma união finita de produtos de simplexes de alocação, conjuntos finitos de coalizões/votos/identidades/datas e intervalos compactos de posterior/payoff. Usar um espaço ambiente evita identificar o conjunto de realizacões de um kernel descontínuo com um subconjunto fechado sem prova. O kernel K_{o,ξ}^{D,C} toma valores em P(Ω_D^{g,C}).

Defina

\[
\Omega_T^{g,C}=(\{\mathsf A\}\times Y_g)\sqcup
(\{\mathsf D\}\times\Omega_D^{g,C}),
\qquad
Z_g^C=Y_g\times[0,1]\times\{0,1\}\times\mathfrak C_g
\times\Omega_T^{g,C}.
\tag{A15}
\]

Aqui \(\mathfrak C_M=\{E,S,P\}\sqcup(\{EP\}\times[0,1])\) e \(\mathfrak C_U=\{L,P\}\) codificam os representantes selecionados. Toda multiplicidade de crenças/estratégias off-path que não está nesses rótulos continua no binder literal κ_g; não é eliminada por (A15).

Para y=(C,x), escreva ξ_g(y)=χ_g(μ(y)). A lei condicional terminal é

\[
L_o^R(d\omega\mid y)=a_g(y)\delta_{(\mathsf A,y)}(d\omega)
+[1-a_g(y)]\widetilde K_{o,\xi_g(y)}^{D,C}(d\omega),
\tag{A16}
\]

e a law realizada completa por tipo é

\[
\Gamma_o^{g,C,R}(E)=\int_{Y_g}\int_{\Omega_T^{g,C}}
1_E(y,\mu(y),a_g(y),\xi_g(y),\omega)
L_o^R(d\omega\mid y)\,\sigma_o(dy).
\tag{A17}
\]

Se os kernels importados são Borel em seu estado/seleção, (A16) é kernel Borel, e (A17) é probabilidade Borel em Z_g^C. O termo de passagem usa o sinal inteiro y, inclusive C. Não se adiciona desconto à law; o extrator de payoffs aplica a data correta, com um β na entrada do baseline. O exemplo A-EX1 prova que projetar y para x antes de formar (A17) pode identificar outcomes distintos.

No representante majoritário importado, a Borelidade do **kernel realizado** pode ser conferida diretamente: para primitivas fixas, há finitíssimas identidades e coalizões ótimas; sorteios uniformes têm pesos constantes; E/P têm kernels fixos; S usa o ramo correspondente ao tipo de H e o novo sorteio uniforme de R2 após recusa; EP é a mistura dos kernels E/P com o mesmo λ. A média interina dos fracos varia com μ em S, mas o kernel condicional a cada tipo é fixo nesse estado. A completude das estratégias que geram esses kernels é fornecida em `r1_interface.md` e `r2_interface.md`; não é substituída por essa observação sobre leis realizadas.

Para explicitar a compatibilidade da implementação literal: em cada R1_M, o respondedor fraco convidado usa x_j≥β/m; H convidado usa x_H≥βo quando todos os demais aceitam e vota Y quando alguma recusa fraca torna ambos os seus votos equivalentes. H não convidado não vota. Toda recusa entra no representante R2_M importado, no qual os convidados fracos aceitam qualquer parcela não negativa e H, se convidado, aceita x_H≥o. Nas crenças de denominador zero, escolher o posterior de entrada constitui o representante Borel especificado na interface; ele permanece no suporte permitido. Essas regras são definidas em todas as coalizões e alocações factíveis e usam apenas quantidades invariantes sob nomes fracos. Os sorteios uniformes são transportados por permutação para sorteios uniformes na coalizão renomeada. Isso verifica a equivariância do representante completo usado aqui, inclusive seu complemento off-path, sem declarar equivalência com o representante histórico majoritário.

### 10.2 Ação dos nomes e fatorização

Se τ∈G=S_m permuta os fracos, sua ação em y é

\[
T_\tau(C,x)=(\{H\}\cup\tau(C\setminus\{H\}),\tau x),
\]

fixando a coordenada de H. Ela também permuta todo nome fraco da história terminal: reconhecido, coalizões, alocações e votos, preservando ⊥ como indicador de não convite. A ação é homeomorfismo no espaço ambiente e deixa datas, tipo, posterior, estado econômico e payoffs anônimos invariantes. Sob seletores anônimos equivariantes, os kernels satisfazem o relabeling correspondente. Essa propriedade deve ser conferida nas estratégias completas importadas, não apenas nos valores c/h.

Ponha γ=(Γ_ℓ,Γ_h)∈P(Z_g^C)^2. Defina a lei da órbita diagonal

\[
\Lambda_\gamma=\frac1{|G|}\sum_{\tau\in G}\delta_{\tau\gamma}.
\]

Então a assinatura nova é \(Sig_g^{ex,C}(R)=(\rho,\mu^{off},\Lambda_\gamma)\), com (*,p) nos endpoints. O mapa γ↦Λ_γ é Borel porque para qualquer conjunto Borel B sua massa é a soma finita \(|G|^{-1}\sum_\tau1_B(\tau\gamma)\). É invariante; se duas leis de órbita coincidem, o singleton do segundo par de laws tem massa positiva na primeira e, portanto, pertence à mesma órbita. Isso prova completude do invariante de relabeling diagonal.

Escolha uma transversal Borel q_g^C das órbitas finitas de Z_g^C. O resumo econômico é

\[
Sum_g^{econ,C}(R)=(\rho,\mu^{off},(q_g^C)_\#\Gamma_\ell,
(q_g^C)_\#\Gamma_h).
\tag{A18}
\]

Todo observável Borel invariante f sobre a tupla realizada é constante na órbita, logo tem fator único \(f=\bar f\circ q_g^C\). Se integrável, sua integral pode ser tomada na law pushforward. Isso inclui payoff de H, passagem/atraso, law de posterior, multiconjunto de pagamentos fracos e tamanho de C. O operador institucional é aplicado primeiro a pares de binders completos na mesma economia/off-path; só depois esses extratores fatoram pelos resumos.

Esse argumento prova a extensão de B.9/F.1 **no novo espaço**, sujeito ao kernel/selector importado. Não afirma `Sig^{ex,C}=Sig^{ex,old}` nem identifica os binders por igualdade de payoffs. Sob maioria, A-EX1 e A-EX2 impedem tal identidade global. Sob unanimidade, A-C8 fornece a aplicação explícita entre espaços e laws.

Off-path continua fora da assinatura realizada: duas funções de crenças ou planos de continuação podem gerar a mesma Γ. Qualquer operação sensível a tais funções continua consumindo o binder completo. O conjunto de pares de laws entre instituições é composto de marginais contrafactuais; não se cria um sorteio comum entre M/U nem colagem de coordenadas de binders diferentes.

## 11. Consequências precisas para seção 6, B.7–B.9 e E–F

| Objeto histórico | Tratamento no novo protocolo | Prova/limite nesta nota |
|---|---|---|
| Protocolo de agenda e espaço de propostas, E.1 | Substituir x por (C,x), convidar apenas C e exigir consentimento de todos. | Seção 2; não é edição terminológica apenas. |
| Melhor passagem a posterior fixado e preços, B.7 | Mesmos números na interface, nova regra de passagem (produto sobre C). | A-C1/A-C3. |
| Propostas superdimensionadas | Passagem usada em equilíbrio é mínima; recusas superdimensionadas permanecem. | A-C4; vale quase certamente, não eliminação de todas as histórias. |
| Tabela pura E.2 | Condições de payoff e existência conservadas por nova prova; mensagens completas passam a variar em Y_M. | A-C6; não equivalência de toda proposta histórica. |
| Membership misto E.2/B.7 | Reescrever sobre medidas em Y_M e posterior do par (C,x). | A-C7. Não há alegação de bijeção com medidas em X. |
| Existência de maioria para algum ρ e limite seguro | Preservados na interface. | A-C4 e três testemunhas da seção 5. |
| Unanimidade B.8/E.3 | Transporte via C=N constante na árvore inteira. | A-C8; depende da correção histórica, não de A1–A3. |
| Assinaturas/laws B.9, E.2/E.3/F.1 | Novos espaços, coalizões/votos efetivos e kernels literais; mesma construção abstrata de órbitas. | Seção 10. Só U tem isomorfismo literal demonstrado. |
| Benchmark público E.6–E.8 e figura do gap | Fórmulas preservadas condicionalmente à interface pública baseline. | A-C5. |
| Região suficiente `βh<e/m` | Preservada: A-C4 dá limite inferior M e U transportada dá superior `1−β+β²h`. | `V_U−V_M≤−β(e/m−βh)`; exige ambos os binders existentes. |
| Incidência de renda unânime e figura de existência | Preservadas via isomorfismo U. | A-C8 e benchmarks públicos. |
| Exemplo numérico de reversão | Testemunha concreta nova na mesma fibra ρ=0. | Seção 8; números históricos reproduzidos exatamente. |
| Comparação exata M/U | Formar nova correspondência de pares completos em Y_M/Y_U. | Não substituir por produto de marginais nem alegar igualdade global de conjuntos antigos/novos. |
| `IR`, `D`, `I`, `T`, `Q` e identidades | Mesmas definições contábeis e uma conversão β; imagens devem usar as novas fontes. | Unanimidade transportada; maioria continua exata/set-valued pelo novo critério. |
| Afirmações genéricas de transportabilidade de outcomes | Não autorizadas por igualdade das fórmulas. | A-EX1/A-EX2 são contraprovas concretas. |

O resultado de vantagem majoritária usa apenas os dois limites, logo independe de uma bijeção entre correspondências antigas e novas. Similarmente, a identidade `T=D+I` é álgebra uma vez definidos os novos vetores. Nenhuma dessas observações certifica existência em célula que perdeu uma fonte; o vazio continua propagando-se.

## 12. Verificação e limites

O script `agenda_checks.py` usa frações exatas e grava `agenda_checks.json`. Foram executados **409 checks, todos aprovados**, abrangendo a identidade (A9) e o limite estrito de superdimensionamento para m=3,…,12 e pontos de fronteira; factibilidade, passagem e IC dos dois contraexemplos; e o par concreto que reproduz a tabela de reversão. Os checks são finitos e condicionais à interface declarada. Não verificam todas as leis Borel, a existência de cada seletor completo ou toda a prova do baseline.

As provas de A-C1–A-C7 explicitam dependência da interface; A-C8 é isomorfismo da forma extensiva. Mensurabilidade/fatorização são demonstradas no espaço novo na seção 10, consumindo os kernels completos Borel e equivariantes importados e verificados contra os hashes da seção 13. Não foi realizada revisão independente deste arquivo pelo implementador.

Variações de timing, informação ou forma de payoff são testes de escopo, não alterações propostas: permitir saltar A muda a garantia/valor do jogo; omitir C da observação pública muda Bayes e elimina A-EX1; permitir pagamentos positivos fora de C restaura a factibilidade de A-EX2 e invalida (A5). Esses três fatos indicam quais hipóteses sustentam o resultado sem abrir extensões não autorizadas.

## 13. Ledger de dependências e fechamento

| Nó | Estado nesta versão | Dependência |
|---|---|---|
| Contrato do novo estágio A e Y_g | Derivado da decisão autoral | `author_decision.md`; parâmetros históricos mantidos. |
| A-C8: isomorfismo U | Demonstrado estruturalmente | Formas extensivas históricas e nova decisão. |
| Interface majoritária E/S/P/EP completa | Recebida, lida e hashes conferidos | Novo R2/R1, estratégias/crenças e kernels completos. |
| A-C1–A-C7 e fórmulas M | Candidata de implementação fechada | Interface da seção 3 nos bytes abaixo; revisão independente pendente. |
| Kernels/Γ/assinaturas | Construção e provas fechadas como candidata | Kernel completo Borel/equivariante do baseline; novo espaço Y; revisão independente pendente. |
| Checks finitos | Executados: 409 PASS, 0 FAIL | Fórmulas da interface explícita e casos declarados. |
| Revisão independente | Pendente | Agente distinto; hashes finais comuns. |

Interfaces efetivamente consumidas, todas em `quality_reports/coalition_protocol_2026-09-19/derivations/`:

| Arquivo | SHA-256 verificado | Escopo consumido |
|---|---|---|
| `game_contract.md` | `ac78634ea0da03b422a6d92930680d1bb1f94deee0d3c33b68dc9d9791a7d058` | Primitivas, informação, suporte, consentimento, payoffs e disciplina de solução. |
| `r2_interface.md` | `c83cf10483bf42e750e131a0792eedde60ae0eed244822c84ea2a1be285dd8a7` | Respostas completas terminais, desacordo, sorteio uniforme e kernels em unidades R2. |
| `r1_interface.md` | `a07a14a115de877411319568a2982e6b5e6e6a8d03c550ead82a6e7078b487e0` | Respostas completas de R1, seleções E/S/P/EP, vetor por tipo, representante Borel e interface literal U. |

Antes do recebimento dessas interfaces, A-C1–A-C7 e a construção de laws eram somente teoremas parametrizados. Depois do recebimento, cada requisito da seção 3 foi conferido: mesmos preços, domínios, prioridades de empate, tipo de probabilidade zero, uma aplicação de β, respostas em propostas desviantes, kernels e escolhas Borel. Nenhuma dependência foi rederivada ou modificada por este implementador. A revisão científica deverá receber as três interfaces e este arquivo nos mesmos hashes.

Qualquer mudança no conjunto de coalizões, observação de C, consentimento de todos os convidados, disciplina de crenças de agenda, estado de seleção ou interface baseline reabre os descendentes pertinentes. Uma alteração de lei terminal que preserve c/h pode ainda invalidar Γ e as assinaturas. Uma alteração apenas de nomes por permutação é coberta pela ação definida acima; uma seleção de coalizões diferente com mesmo payoff não é automaticamente a mesma assinatura.

<!-- END derivations/v2/agenda_transport.md -->


<!-- BEGIN derivations/v2/unanimity_support_lemma.md sha256=1491acd877ae5d3ca4eda2c6c9cacd10bffe9221fe52964f11cd7d962d5068ef -->

# Lema de suporte para a proposta unânime de preço alto

Data: 2026-09-19. Candidata de implementação de F-002, confirmada em `adjudication/preliminary_v1.json`; aguarda revisão independente. O manuscrito e todas as notas v1 permanecem intactos. Este documento fecha somente as duas invocações de \(x^h\) em B.8, não reabre QI-05 nem certifica os demais resultados.

## Premissas consumidas

Usam-se a interface unânime de `r1_interface.md` e o contrato de agenda de `agenda_transport.md`, copiados para v2. Sob unanimidade, \(C=N\) é constante e identificamos \((N,x)\) com \(x\) no simplex compacto \(\mathcal X\). Fixe \(0<p<1\), \(0<\ell<h<1\) e \(0<\beta<1\). Escreva

\[
p^*=\frac{h-\ell}{1-\ell}\in(0,1),\qquad
\mathcal P_C=\{0\}\cup(p^*,1],
\]

\[
r_U(o)=\frac{\beta(1-\beta o)}m,\qquad
z_L=1-\beta+\beta^2\ell,\quad
z_H=1-\beta+\beta^2h,\quad d=\beta^2h,
\]

\[
x^h=(z_H,r_U(h),\ldots,r_U(h)).
\]

Sejam \(\sigma_\ell,\sigma_h\) leis Borel de propostas, \(\bar\sigma=(1-p)\sigma_\ell+p\sigma_h\), \(S=\operatorname{supp}(\bar\sigma)\) e \(\mu\) o posterior público. Em cada ponto de \(S\), inclusive pontos de massa zero, o contrato exige existência do limite local de Bayes por bolas euclidianas relativas e \(\mu(x)\in\mathcal P_C\). Fora de \(S\), \(\mu(x)=\mu^{off}\in\mathcal P_C\).

A primeira redução de B.8 já fornece o valor comum \(V_\ell=V_h=V\). Cada lei atribui probabilidade um aos melhores retornos do respectivo tipo, e as desigualdades contra desvios valem em **todo** ponto de \(\mathcal X\). Além disso,

\[
d\le V\le z_H.
\tag{US1}
\]

Para o limite inferior, o alto pode propor \((1,0,\ldots,0)\), obter recusa e receber \(d\) em qualquer posterior admissível. Para o superior, qualquer proposta aprovada paga a cada fraco ao menos \(r_U(h)\), enquanto toda recusa dá a cada tipo no máximo \(d<z_H\). Esses limites não supõem que uma proposta particular esteja fora do suporte.

## Identidade média de Bayes nas bolas

A medida finita \(p\sigma_h\) é absolutamente contínua em relação a \(\bar\sigma\). Ponha

\[
f=\frac{d(p\sigma_h)}{d\bar\sigma},\qquad 0\le f\le1
\quad\bar\sigma\text{-quase certamente}.
\]

As medidas são Borel finitas em um simplex euclidiano compacto. Estendendo-as por zero ao espaço euclidiano ambiente, o teorema de diferenciação de medidas por bolas identifica o limite local da razão com \(f\), \(\bar\sigma\)-quase certamente. As bolas relativas são exatamente as interseções das bolas ambientes com o simplex, de modo que a mesma razão é usada pelo contrato. Como \(\mu\) é esse limite em todo o suporte, \(\mu=f\) quase certamente. Portanto, para **todo** conjunto Borel \(E\),

\[
p\sigma_h(E)=\int_E\mu(x)\,\bar\sigma(dx).
\tag{US2}
\]

Em particular, \(\sigma_h(\{\mu=0\})=0\). O argumento não exige que as leis tenham densidades de Lebesgue, átomos ou suporte finito.

## Lema US-1

**Enunciado.** Em qualquer assessment admissível que satisfaça as premissas acima, se \(\mu^{off}>p^*\), então

\[
V=z_H,\qquad
\sigma_\ell=\sigma_h=\delta_{x^h}.
\tag{US3}
\]

Consequentemente, \(\mu(x^h)=p>p^*\). O enunciado abrange o caso em que, antes de impor os incentivos, \(x^h\) pertence ao suporte topológico com massa zero.

**Prova.** Suponha, para obter contradição, que \(V<z_H\). A coordenada \(x\mapsto x_H\) é contínua. Logo existe \(\varepsilon_0>0\) tal que

\[
x_H>V\quad\text{em }B_{\mathcal X}(x^h,\varepsilon_0).
\tag{US4}
\]

Se \(x^h\notin S\), seu posterior é \(\mu^{off}>p^*\). Os fracos aceitam suas parcelas \(r_U(h)\), inclusive na igualdade, e ambos os tipos recebem \(z_H>V\). Isso viola a desigualdade contra desvios. Resta o caso \(x^h\in S\), sem presumir massa positiva no singleton.

Considere o conjunto Borel

\[
E_0=B_{\mathcal X}(x^h,\varepsilon_0)\cap\{\mu=0\}.
\]

Por (US2), \(\sigma_h(E_0)=0\). O baixo também não pode atribuir massa positiva a \(E_0\). Em sua parte aprovada, ele receberia \(x_H>V\); em sua parte rejeitada, receberia \(\beta^2\ell<d\le V\). Nenhum desses retornos é igual a \(V\), como deve ocorrer \(\sigma_\ell\)-quase certamente. Assim,

\[
\sigma_\ell(E_0)=\sigma_h(E_0)=\bar\sigma(E_0)=0.
\tag{US5}
\]

Para cada \(0<\varepsilon\le\varepsilon_0\), a bola \(B_\varepsilon=B_{\mathcal X}(x^h,\varepsilon)\) tem massa pública positiva, pois \(x^h\in S\). Como \(\bar\sigma\) se concentra em \(S\), a admissibilidade e (US5) implicam \(\mu>p^*\), \(\bar\sigma\)-quase certamente nessa bola. Aplicando (US2),

\[
\frac{p\sigma_h(B_\varepsilon)}{\bar\sigma(B_\varepsilon)}
=\frac{\int_{B_\varepsilon}\mu\,d\bar\sigma}
       {\bar\sigma(B_\varepsilon)}
>p^*.
\tag{US6}
\]

O limite exigido no ponto \(x^h\) satisfaz, portanto, \(\mu(x^h)\ge p^*\). Não se troca indevidamente essa conclusão por uma desigualdade estrita de limites. A estriteza vem da admissibilidade: \(p^*>0\) exclui o posterior zero, e \(p^*\notin\mathcal P_C\) exclui a igualdade. Assim \(\mu(x^h)>p^*\). Nesse posterior, \(x^h\) passa e entrega \(z_H>V\), contradizendo a condição de desvio **no próprio ponto de suporte**, mesmo que tenha massa zero.

Logo \(V\ge z_H\), e (US1) dá \(V=z_H\). Uma proposta rejeitada rende no máximo \(d<z_H\), de modo que ambas as leis se concentram em propostas aprovadas com \(x_H=z_H\). Um posterior zero permitiria no máximo \(z_L<z_H\); no posterior alto, cada parcela fraca precisa ser ao menos \(r_U(h)\). Como \(z_H+mr_U(h)=1\), a factibilidade força cada parcela fraca a ser exatamente \(r_U(h)\). A única proposta usada é, portanto, \(x^h\). Bayes no átomo comum dá \(\mu(x^h)=p\), cuja admissibilidade e positividade implicam \(p>p^*\). Isso prova (US3). □

## As duas aplicações em B.8

1. **Massa positiva em posterior zero.** Se \(\lambda_0=\bar\sigma(\{\mu=0\})>0\), a segunda redução de B.8 fornece \(d\le V\le z_L\). Caso \(\mu^{off}>p^*\), US-1 exigiria \(V=z_H>z_L\), uma contradição. A admissibilidade deixa apenas \(\mu^{off}=0\). Este passo substitui a invocação original nas linhas 1889–1893 e não presume que \(x^h\) esteja fora do suporte.
2. **Massa zero em posterior zero.** Se \(\lambda_0=0\) e \(\mu^{off}>p^*\), US-1 dá diretamente \(V=z_H\) e \(\sigma_\ell=\sigma_h=\delta_{x^h}\), substituindo o atalho das linhas 1938–1943. A identificação \((N,x)\leftrightarrow x\) transporta o mesmo argumento para o protocolo aprovado.

As linhas citadas pertencem à fonte histórica SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`. O patch puro `../proof_repairs_manuscript_patch.py` prepara a inserção do lema e as duas substituições, sem aplicar a migração nem recompor qualquer preview. A prova usa identidades de medidas; os checks aritméticos de F-001 não a validam numericamente.

<!-- END derivations/v2/unanimity_support_lemma.md -->
