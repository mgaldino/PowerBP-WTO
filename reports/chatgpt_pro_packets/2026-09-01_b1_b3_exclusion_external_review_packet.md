---
title: "Correção de B.1/B.3 sob a regra de exclusão"
subtitle: "Pacote autocontido para consulta técnica externa no ChatGPT Web"
date: "1 de setembro de 2026"
lang: pt-BR
geometry: margin=2.3cm
fontsize: 10pt
toc: true
numbersections: true
colorlinks: true
linkcolor: blue
urlcolor: blue
header-includes:
  - \usepackage{amsmath,amssymb}
  - \usepackage{booktabs,longtable,array}
  - \sloppy
---

# Mandato ao ChatGPT Web

Você atuará como leitor técnico externo de uma correção delimitada em um
modelo formal de barganha política. Empregue o rigor matemático esperado de
um referee de teoria formal, mas identifique seu produto como **consulta
técnica externa não formal**. Esta consulta não é um gate, não congela bytes,
não substitui as revisões internas e não autoriza alteração do manuscrito.

Não produza um parecer genérico de journal, não avalie a contribuição do
paper e não redesenhe o modelo. O objeto exclusivo é verificar se a nova
regra de exclusão — acordo e outside option são mutuamente exclusivos — foi
corretamente propagada às provas B.1 e B.3 e se os resultados downstream
realmente permanecem invariantes no sentido restrito declarado.

Duas leituras internas independentes deram `PASS 0/0/0`, e uma adjudicação
separada registrou `NO_CONFIRMED_DEFECTS`. **Não dê PASS por deferência a
essas leituras.** Tente construir um contraexemplo antes de aceitar cada
passo. Da mesma forma, não dê FAIL apenas porque as estratégias fora do
caminho mudam: verifique se o candidato limita corretamente sua alegação aos
resultados e payoffs reportados.

O manuscrito ainda contém as duas frases antigas em B.1 e B.3. Isso é
intencional: nenhuma migração foi autorizada. Compare o texto vigente com o
memorando candidato; não trate os bytes atuais do manuscrito como já
corrigidos.

## Escopo obrigatório

Audite:

1. a factibilidade do desvio que fixa `x_H=0` e transfere a parcela ao
   proponente;
2. sua lucratividade estrita para toda proposta em que os votos fracos já
   bastam;
3. a preservação da quota, dos votos fracos e da simultaneidade do ballot;
4. as respostas de `H` nos três casos `n_Y>=k`, `n_Y=k-1` e `n_Y<=k-2`;
5. a datação do limiar pivotal `beta o`;
6. o uso do desempate em favor de sim na indiferença;
7. as fórmulas `Pi_E`, `Pi_S`, `Pi_P`, seus cutoffs e knife edges;
8. a alegação de que B.2, B.4, B.5 e B.6 não exigem mudança substantiva;
9. a distinção entre a correspondência completa de assessments/estratégias
   e a correspondência reportada de resultados, payoffs, classes, cutoffs e
   multiplicidades;
10. a redação inglesa proposta para futura migração em B.1 e B.3.

Não reabra:

- a escolha entre unanimidade e maioria como comparação institucional;
- a pie unitária fixa, o espaço de propostas ou a interpretação de forum
  shopping;
- o conceito de solução, a regra as-if-pivotal, `T^Y` ou a consistência
  estrutural;
- a ausência de agenda de `H` no baseline;
- extensões de membership-dependent pie, benefícios intrínsecos,
  externalidades ou signaling de escolha institucional.

## Regras metodológicas

- Trate verificação numérica somente como diagnóstico, nunca como prova.
- Respeite que os votos são simultâneos: `H` não observa o vetor de votos
  fracos antes de votar.
- Não some `x_H` e `o` na mesma história.
- Não introduza cap sobre `x_H` além da restrição agregada da pie.
- Não infira invariância do assessment completo a partir da invariância de
  resultados ótimos.
- Se encontrar um problema, forneça localizador, contraexemplo ou derivação
  e a correção mínima. Separe diagnóstico de eventual redesign.

# Primitives, protocolo e conceito de solução — excerto exato do manuscrito

O trecho a seguir é reproduzido sem alteração dos bytes correntes do
manuscrito. Ele contém a regra nova que governa a auditoria.

## Players, information, and proposals

There is one hegemon, \(H\), and \(m\geq3\) weak states,
\(W=\{1,\ldots,m\}\), for a total of \(m+1\) states. Nature selects
\(H\)'s terminal disagreement payoff \(o\in\{\ell,h\}\), observed only by
\(H\), with \(\Pr(o=h)=p\in[0,1]\). The two possible values satisfy
\[
0<\ell<h<1.
\]

The game has two rounds. In each round, one weak state is recognized
uniformly to propose; \(H\) is never a proposer. The two recognition draws are
independent and made with replacement. Every weak state remains eligible in
Round 2, including the Round-1 proposer. A proposal by weak state \(i\) is the
allocation vector
\[
x=(x_H,(x_j)_{j\in W})\in\mathcal X,
\qquad
\mathcal X=\left\{x:x_H\geq0,\ x_j\geq0,\
x_H+\sum_{j\in W}x_j\leq1\right\}.
\]
Payments cannot be negative and side payments
outside the proposed package are unavailable. Here \(x_H\) is the
institutional concession assigned to \(H\), and \(x_j\) is weak state
\(j\)'s share, including the proposer when \(j=i\). The fixed unit pie is
exhausted on the equilibrium path. Agreement provides \(H\) no intrinsic
benefit beyond \(x_H\), which isolates informational concessions and
pivotality from any direct value of agreement.

## Ballots, timing, and payoffs

The proposer is counted as voting yes. All other states vote simultaneously;
the complete vote vector and outcome become public only after all votes have
been cast. Define
\[
k=\left\lfloor\frac{m+1}{2}\right\rfloor.
\]
Under majority, passage requires \(k\) additional yes votes beyond the
proposer's; unanimity requires every state's yes vote. The ballot protocol is
otherwise identical across rules.

If a proposal passes, its allocations are implemented among the parties to
the agreement. If \(H\) votes yes, it is a party and receives \(x_H\). If
\(H\) votes no but a majority passes the proposal without it, \(H\) is not a
party: it receives its outside option \(o\), and the share \(x_H\) is paid to
no one, because the concession is specific to \(H\) and cannot be transferred
to another player. Agreement and
disagreement payoffs are therefore mutually exclusive at every history. In
every equilibrium exclusion derived below the proposer chooses \(x_H=0\), and
the hegemon receives exactly \(o\).

If nothing passes in Round 1, no payoff is realized then and the game proceeds
to Round 2. Round-2 payoffs are multiplied by
\(\beta\in(0,1)\) when evaluated in Round-1 units. If nothing passes in Round
2, each weak state receives zero and \(H\) receives \(o\) in Round-2
units. A no vote is only a ballot action; it does not remove a player or
trigger disagreement by itself. [AUTHOR: P1] The delayed terminal disagreement
payoff represents the cost of prolonging international negotiations.

\begin{table}[H]
\centering
\caption{Transitions and payoffs in the essential-input game}
\label{tab:protocol}
\begin{tabular}{p{0.24\linewidth}p{0.25\linewidth}p{0.20\linewidth}p{0.20\linewidth}}
\toprule
Event & Weak-state payoffs & \(H\) votes yes & \(H\) votes no \\
\midrule
Proposal passes & Proposed \(x_j\), including \(x_i\) & \(x_H\) & the outside
option \(o\) alone; \(x_H\) is paid to no one, so the total distributed falls
below one when \(x_H>0\) \\
Round-1 proposal fails & No current payoff; proceed to Round 2 &
\(\beta C_H(\mathfrak h^Y)\) & \(\beta C_H(\mathfrak h^N)\) \\
Round-2 proposal fails & Zero & \(o\) & \(o\) \\
\bottomrule
\end{tabular}
\end{table}

Here \(\mathfrak h^Y\) and \(\mathfrak h^N\) denote the distinct public
histories in which \(H\) voted yes or no, and \(C_H(\mathfrak h^a)\) denotes
\(H\)'s Round-2 continuation value after history \(\mathfrak h^a\). These
continuation values need not be equal because the public vote can change
beliefs before Round 2.

\begin{figure}[H]
\centering
\resizebox{\textwidth}{!}{%
\begin{tikzpicture}[
  node distance=8mm and 10mm,
  box/.style={draw, rounded corners, align=center, inner sep=5pt},
  arr/.style={-{Latex[length=2mm]}, thick}
]
\node[box] (p1) {Weak proposer\\chooses a Round-1 package};
\node[box, right=of p1] (b1) {Simultaneous ballot\\vote vector becomes public};
\node[box, above right=7mm and 10mm of b1] (a1) {Quota met\\package implemented};
\node[box, below right=7mm and 10mm of b1] (p2) {Quota not met\\Round 2 begins};
\node[box, right=of p2] (b2) {Weak proposer chooses\\terminal package; ballot};
\node[box, above right=7mm and 10mm of b2] (a2) {Quota met\\package implemented};
\node[box, below right=7mm and 10mm of b2] (d2) {Quota not met\\terminal disagreement};
\draw[arr] (p1) -- (b1);
\draw[arr] (b1) -- (a1);
\draw[arr] (b1) -- (p2);
\draw[arr] (p2) -- (b2);
\draw[arr] (b2) -- (a2);
\draw[arr] (b2) -- (d2);
\end{tikzpicture}
}
\caption{Sequence of proposals and ballots. Within each ballot, responding
states vote simultaneously. A failed first-round proposal continues to the
terminal round; a no vote alone does not end the game.}
\label{fig:timing}
\end{figure}

## Solution concept

We use perfect Bayesian equilibrium with pure ballot strategies and three
declared disciplines. First, an action by a player who does not know
\(o\) does not change beliefs about \(o\). After an action by \(H\),
beliefs follow Bayes' rule whenever possible and otherwise satisfy structural
consistency, the restriction stated exactly in Appendix A.2. Second, a weak
responder evaluates yes and no as if its own vote
were pivotal. Third, a voter accepts when exactly indifferent in expected
value. Among proposal choices that give the proposer the same
expected payoff, the selected proposal minimizes \(H\)'s expected payoff.

Endpoint beliefs preserve the support of the prior. If \(p=0\), the posterior
assigns zero probability to \(h\) at every history; if \(p=1\), it assigns
probability one to \(h\). For \(0<p<1\), an action by \(H\) whose Bayesian
denominator is zero under the prescribed profile and the current belief may
support any posterior in
\([0,1]\). This is a condition of our solution
concept. It follows the no-signaling logic used in multistage games
[@fudenberg1991game]; support preservation is analogous to, but narrower than,
the never-dissuaded discipline discussed by @osborneRubinstein1990. Tremble
consistency motivates the restriction but is not invoked as a theorem for
degenerate priors [@kreps1982sequential].

\begin{table}[H]
\centering
\caption{Scope of the formal results}
\label{tab:scope}
\begin{tabular}{p{0.29\linewidth}p{0.62\linewidth}}
\toprule
Element & Maintained scope \\
\midrule
Players and horizon & One hegemon, \(m\geq3\) weak states, two rounds \\
Agenda & Only weak states propose in both rounds \\
Voting & Simultaneous public ballots; majority or unanimity \\
Information & Private outside option \(o\in\{\ell,h\}\); support-preserving endpoints \\
Payoffs & Unit pie, \(0<\ell<h<1\), \(0<\beta<1\); no intrinsic agreement benefit for \(H\) \\
Equilibrium & Perfect Bayesian equilibrium in pure ballot strategies with the
declared voting and proposal tie-break rules \\
\bottomrule
\end{tabular}
\end{table}


# Proposições e objetos downstream — excerto exato do manuscrito

Este bloco contém o benchmark público, o jogo terminal privado e a
correspondência privada sob maioria. As proposições ainda reportam os
resultados cuja invariância o memorando procura demonstrar.

## Complete-information benchmark

With a public type, no belief or signaling issue remains. The proposer compares
the price of \(H\)'s vote with the price of enough weak-state votes. In the
terminal round, the relevant price of \(H\) is \(o\). In the first
round, it is \(\beta o\), because rejection leads to the terminal
round.
Under majority, a weak-state vote costs \(\beta/m\) in first-round units. Under
unanimity with public disagreement payoff \(o\), each weak responder's
continuation price is \(\beta(1-o)/m\).

\begin{proposition}[Public-type benchmark]\label{prop:public}
Fix a public type with disagreement payoff \(o\). In the terminal round,
majority passes a proposal without \(H\), assigns \(x_H=0\), and gives the weak
proposer the whole unit pie; \(H\) receives \(o\). Terminal unanimity passes
with \(x_H=o\), and the weak proposer retains \(1-o\).

In Round 1, unanimity passes immediately with \(x_H=\beta o\). Majority includes
\(H\) if \(o\leq1/m\) and excludes it if \(o>1/m\). At equality the proposal
including \(H\) is selected. Consequently, the public Round-1 payoff of \(H\)
is
\[
v_M^B(o)=
\begin{cases}
\beta o,&o\leq1/m,\\
o,&o>1/m,
\end{cases}
\qquad
v_U^B(o)=\beta o.
\]
\end{proposition}

\begin{table}[H]
\centering
\caption{Complete-information outcomes by round and voting rule}
\label{tab:publicgames}
\small
\begin{tabular}{p{0.10\linewidth}p{0.15\linewidth}p{0.27\linewidth}p{0.23\linewidth}p{0.12\linewidth}}
\toprule
Round & Rule & Proposed payments & Weak proposer & \(H\) \\
\midrule
2 & Majority & \(x_H=0\); weak responders get zero & \(1\) & \(o\) \\
2 & Unanimity & \(x_H=o\); weak responders get zero & \(1-o\) & \(o\) \\
1 & Majority, \(o\leq1/m\) & \(x_H=\beta o\); \(k-1\) responders get \(\beta/m\) &
\(1-\beta o-(k-1)\beta/m\) & \(\beta o\) \\
1 & Majority, \(o>1/m\) & \(x_H=0\); \(k\) responders get \(\beta/m\) &
\(1-k\beta/m\) & \(o\) \\
1 & Unanimity & \(x_H=\beta o\); every responder gets \(\beta(1-o)/m\) &
\(1-\beta o-(m-1)\beta(1-o)/m\) & \(\beta o\) \\
\bottomrule
\end{tabular}
\end{table}

At \(o=1/m\), buying \(H\)'s vote and buying the substitute weak-state vote
cost the proposer the same amount. The proposal tie-break selects inclusion
because it gives \(H\) the lower payoff \(\beta o<o\).

## Private information in the terminal round

Let
\[
p^*=\frac{h-\ell}{1-\ell}.
\]
Under terminal majority, \(H\)'s vote is unnecessary and the belief never
enters the proposer's choice. Under terminal unanimity, the proposer compares a
low offer that succeeds only when the type is low with a high offer that both
types accept.

\begin{proposition}[Private terminal games]\label{prop:terminal}
Under majority, the unique equilibrium outcome assigns \(x_H=0\), pays no
responding weak state, and gives the full pie to the proposer. The proposal
passes without \(H\); a hegemon with outside option \(o\) receives \(o\), and a weak state
receives \(1/m\) before recognition.

Under unanimity, if \(p\leq p^*\), the proposer offers \(x_H=\ell\). The low
outside-option type accepts and the high outside-option type rejects, so the proposal succeeds with
probability \(1-p\). If \(p>p^*\), the proposer offers \(x_H=h\) and both
types accept. At \(p=p^*\), the low offer is selected.
\end{proposition}

The cutoff equates \((1-p)(1-\ell)\), the proposer's payoff from the low
offer, with \(1-h\), its payoff from pooling. Notice that no discount factor
appears inside this terminal comparison.

## Private majority in Round 1

Let \(w=\beta/m\). The proposer's payoffs from the three undominated outcome
classes are:
\[
\begin{aligned}
\Pi_E&=1-kw,\\
\Pi_S(p)&=(1-p)\left[1-(k-1)w-\beta\ell\right]+pw,\\
\Pi_P&=1-(k-1)w-\beta h.
\end{aligned}
\]
Exclusion buys \(k\) weak responders at price \(w\) each and sets \(x_H=0\).
Screening buys \(k-1\) weak responders and offers \(\beta\ell\): the low
outside-option type accepts and the high outside-option type delays. Pooling
buys \(k-1\) weak responders and offers \(\beta h\), which both types accept.
Deliberate delay is strictly worse than exclusion because
\(1-\beta(k+1)/m>0\).

When \(\ell<1/m\), define
\[
p_{S=E}=
\frac{\beta(1/m-\ell)}
{\beta(1/m-\ell)+1-\beta(k+1)/m}.
\]
When \(h<1/m\), define
\[
p_{S=P}=
\frac{\beta(h-\ell)}
{1-\beta\ell-\beta k/m}.
\]

\begin{proposition}[Private majority correspondence]\label{prop:majority}
For \(m\geq3\), the equilibrium outcome class is:

\begin{enumerate}
\item If \(h<1/m\), screening for \(p\leq p_{S=P}\) and pooling above it.
\item If \(\ell<1/m<h\), screening for \(p\leq p_{S=E}\) and exclusion
above it.
\item If \(1/m<\ell<h\), exclusion for every \(p\).
\item If \(\ell=1/m<h\), screening at \(p=0\) and exclusion for
\(p>0\).
\item If \(\ell<h=1/m\), screening for \(p\leq p_{S=E}\). Above that
cutoff, exclusion is selected when
\((1-p)\ell+ph<\beta h\), pooling is selected when the inequality is
reversed, and the entire proposal segment joining the two survives when the
two expressions are equal.
\end{enumerate}

At every cutoff involving screening, screening is selected. Permuting the
identities of identically paid weak responders generates additional
equilibria but does not change \(H\)'s payoff vector or the outcome class.
Payoffs of weak states identified by label can be permuted and, on the
residual proposal family, vary with the common proposal weight.
\end{proposition}

The last segment is genuine multiplicity. Its mixing weight is a probability
over pure proposals in the proposer's strategy, and the same weight must be
used jointly for payoffs and outcomes. It is not a license to combine
componentwise minima and maxima into an unattained rectangle.


# Appendix A.1--A.2 e Appendix B completas — bytes correntes

Este bloco preserva inclusive as duas fórmulas antigas `x_H+o` em B.1 e
B.3. Elas são o defeito a ser corrigido; não são axiomas para a auditoria.

## A.1 Complete transition and payoff rules {-}

For a proposal \(x=(x_H,x_1,\ldots,x_m)\), let \(a_H\in\{Y,N\}\) and let the weak
responders' votes be \(a_{-i}\). The proposer votes yes. If the quota is met,
the proposal is implemented among the parties. Each weak respondent receives
\(x_j\), the proposer receives \(x_i\), and \(H\) receives \(x_H\) after yes;
after no, \(H\) receives \(o\) and \(x_H\) is paid to no one. If the quota is
not met in Round 1, the public vote
vector leads to Round 2; every continuation payoff is then multiplied by
\(\beta\). If the quota is not met in Round 2, weak states receive zero and
\(H\) receives \(o\).

Agreement and disagreement payoffs are mutually exclusive at every history:
no history pays a player both an allocation from the pie and an outside
option. All equilibrium exclusions pay \(H\) exactly \(o\).

## A.2 Beliefs and ballot restrictions {-}

Uninformed weak-state proposals and votes preserve the current belief.
Structural consistency is the following restriction. Fix a profile. At each
ballot, the entering belief is the current posterior, and \(H\)'s prescribed
law is the type-contingent vote distribution the profile assigns at that
ballot. The posterior after any vote vector depends on the history only
through the entering belief, the prescribed law, and \(H\)'s realized vote; it
is therefore invariant across vote vectors of the same ballot that differ only
in weak-state votes. If \(H\)'s realized vote has positive probability under
the prescribed law and the entering belief, the posterior is the Bayes update
given that law, including at ballots reached by earlier weak-state deviations.
If the Bayes denominator is zero, the posterior is a single free value
attached to that ballot-and-vote pair, chosen within the support of the prior:
any value in \([0,1]\) for an interior prior, and the degenerate posterior at
\(p=0\) or \(p=1\). Distinct ballots may carry distinct free values. This
condition is a declared restriction of our equilibrium concept; it is not the
consistency notion of sequential equilibrium [@kreps1982sequential], and it is
narrower than the never-dissuaded discipline of @osborneRubinstein1990.

A weak responder compares its allocation with the continuation that would
follow if its vote switched passage into failure. It votes yes at equality.
\(H\) maximizes its type-contingent continuation payoff and votes yes at exact
indifference. These restrictions apply at every proposal, including
off-path proposals.

# Appendix B: Proofs {-}

## B.1 Proof of Proposition \ref{prop:public} {-}

In terminal majority, a weak responder's disagreement value is zero, so any
nonnegative allocation induces yes under the indifference-to-yes convention.
Because \(k\leq m\), the
proposer can pass without \(H\), set every payment to zero, and keep one.
\(H\) is nonpivotal and strictly votes no because no yields \(x_H+o\) rather
than \(x_H\). Moving any positive \(x_H\) to the proposer leaves passage unchanged,
so equilibrium exclusion has \(x_H=0\) and \(H\) receives \(o\).

In terminal unanimity, every weak responder accepts zero and \(H\) accepts
exactly when \(x_H\geq o\). The proposer therefore sets \(x_H=o\).

Move to Round 1. The terminal continuation of a weak state before recognition
under majority is \(1/m\), hence \(w=\beta/m\). The continuation of \(H\) is
\(\beta o\). Under unanimity, paying \(H\) exactly \(\beta o\) and each weak
responder its continuation implements immediate agreement and leaves the
proposer strictly more than delay because \(\beta<1\).

Under majority, inclusion costs \((k-1)w+\beta o\); exclusion costs
\(kw\). Inclusion is weakly cheaper exactly when \(o\leq1/m\). At equality
the proposer is indifferent, and the proposal tie-break selects inclusion
because \(H\) receives \(\beta o<o\). This gives the stated payoffs.
\(\square\)

## B.2 Proof of Proposition \ref{prop:terminal} {-}

The majority argument is the terminal-majority part of the preceding proof.
Before recognition, symmetry gives each weak state expected payoff \(1/m\).

Under unanimity, weak responders accept zero. Any accepted offer to \(H\) can
be reduced to the lowest threshold consistent with its acceptance set. The
only nonempty acceptance sets are the low type alone, implemented by
\(x_H=\ell\), and both types, implemented by \(x_H=h\). The first gives the
proposer \((1-p)(1-\ell)\); the second gives \(1-h\). The low offer is weakly
preferred exactly when
\[
p\leq\frac{h-\ell}{1-\ell}=p^*.
\]
At equality the low offer gives \(H\) the lower expected payoff and is selected.
\(\square\)

## B.3 Proof of Proposition \ref{prop:majority} {-}

A responding weak state votes yes exactly when \(x_j\geq w=\beta/m\).
Let \(n_Y\) be the number of such responders. If \(n_Y\geq k\), the weak votes
pass the proposal without \(H\); both types of \(H\) vote no and receive
\(x_H+o\). If \(n_Y=k-1\), \(H\) is pivotal and a type with outside option
\(o\) votes yes exactly when \(x_H\geq\beta o\). If \(n_Y\leq k-2\), the proposal
fails regardless of \(H\)'s vote.

Within each acceptance class, reducing weak payments to \(w\), reducing \(x_H\)
to the relevant type threshold, and assigning the remaining pie to the
proposer weakly increases its payoff. This leaves four candidates: exclusion
with payoff \(\Pi_E\), screening with payoff \(\Pi_S(p)\), pooling with payoff \(\Pi_P\),
and deliberate delay with payoff \(w\). Exclusion is always feasible and
\[
\Pi_E-w=1-\frac{\beta(k+1)}{m}>0,
\]
so delay is never selected. A screening or pooling candidate that could beat
exclusion is automatically feasible.

The decisive payoff differences are
\[
\Pi_P-\Pi_E=\beta(1/m-h)
\]
and
\[
\Pi_S(p)-\Pi_E=(1-p)\beta(1/m-\ell)
            -p(1-\beta(k+1)/m).
\]
Where pooling can beat exclusion, comparing screening with pooling yields
\(p_{S=P}\); comparing screening with exclusion yields \(p_{S=E}\).
Substituting the signs of \(\ell-1/m\) and \(h-1/m\) produces the five cases
in Proposition \ref{prop:majority}.

At screening ties, its expected payoff to \(H\) is strictly smaller than that
of the tied alternative, so the proposal tie-break selects screening. When
\(h=1/m\), exclusion and pooling give the proposer the same payoff. Their
payoffs to \(H\) determine the stated selection; exact equality leaves their
entire proposal segment. All selected proposals exhaust the pie. Finally,
permuting the identities of weak responders does not change any comparison,
which establishes the reported identity multiplicity. \(\square\)

## B.4 Proof of Proposition \ref{prop:unanimity} {-}

Transport the terminal unanimity continuation into Round-1 units. If the
posterior is \(\mu\), a weak state's continuation is
\[
W(\mu)=
\begin{cases}
(1-\mu)w_\ell^U,&\mu\leq p^*,\\
w_h^U,&\mu>p^*.
\end{cases}
\]
Thus \(W(\mu)\in[w_h^U,w_\ell^U]\), and \(x_j=w_\ell^U\) forces every weak responder to vote
yes under any admissible posterior.

At \(p=0\), support preservation fixes every posterior at zero. The proposal
\[
x_H=\beta\ell,\qquad x_j=w_\ell^U,\qquad
x_i=1-\beta\ell-(m-1)w_\ell^U=w_\ell^U+1-\beta
\]
is accepted. Each responder and \(H\) is exactly indifferent and votes yes.
Any lower payment loses a required vote; any higher payment reduces the
proposer's residual. A delay gives the proposer \(w_\ell^U\), so immediate agreement
is strictly better by \(1-\beta\).

For \(p>p^*\), the analogous pooling proposal is
\[
x_H=\beta h,\qquad x_j=w_h^U,\qquad
x_i=1-\beta h-(m-1)w_h^U=w_h^U+1-\beta.
\]
Both types of \(H\) and every weak responder accept, and immediate agreement
again exceeds delay by \(1-\beta\).

For completeness, write \(u=\min_j x_j\) after an arbitrary proposal and order
the strategy of \(H\) as low-type/high-type. At \(p=0\), posterior support is
always the low type. The profile \((Y,Y)\) is sequentially rational if
\(u<w_\ell^U\), or if \(u\geq w_\ell^U\) and \(x_H\geq\beta h\); \((N,N)\) is rational if
\(u\geq w_\ell^U\) and \(x_H<\beta\ell\); and \((Y,N)\) is rational if
\(u\geq w_\ell^U\) and \(\beta\ell\leq x_H<\beta h\). The profile \((N,Y)\) is never rational.
These cases are mutually exclusive and exhaustive.

For \(p^*<p<1\), the profile \((Y,Y)\) is rational if \(u<w_h^U\), or if
\(u\geq w_h^U\) and \(x_H\geq\beta h\); \((N,N)\) is rational if \(u\geq w_h^U\) and
\(x_H<\beta h\); and neither separating profile is rational. Bayes gives the current
prior after an on-profile pooled action. When yes is a zero-probability action,
an admissible posterior \(\mu_Y\) supports all weak yes votes exactly when
\(W(\mu_Y)\leq u\), which is possible in the stated no profile because
\(u\geq w_h^U\). At \(p=1\), support preservation fixes the posterior at one
and the same two pooled-profile conditions apply. Thus every proposal in both
existence domains has a pure, sequentially rational response completion.

It remains to show the empty cell. For \(0<p\leq p^*\), consider
\[
s^\dagger:\quad
x_H=\beta\ell,\quad x_j=w_\ell^U\ \text{for every weak responder},\quad
x_i=1-\beta\ell-(m-1)w_\ell^U.
\]
All weak responders must vote yes. Enumerate the four pure type-contingent
profiles for \(H\), ordered low/high:

\begin{enumerate}
\item Under \((Y,Y)\), the high type receives \(\beta\ell<\beta h\) and profitably votes
no to obtain continuation \(\beta h\).
\item Under \((N,N)\), the low type's no gives \(\beta\ell\), so the
indifference-to-yes convention requires yes.
\item Under \((Y,N)\), the low type can imitate the high type's no. That action
reveals the high type and yields continuation \(\beta h>\beta\ell\).
\item Under \((N,Y)\), the high type can imitate the low type's no and obtain
continuation \(\beta h\), while the prescribed comparison cannot support strict no
against yes at the offer.
\end{enumerate}

No pure profile is sequentially rational after \(s^\dagger\). Because a PBE
must specify a valid pure response after every feasible proposal, no
pure-ballot PBE exists in this cell. This also explains the discontinuity:
at \(p=0\), support preservation rules out the posterior that drives the
imitation argument; for every positive \(p\), both types are possible.
\(\square\)

## B.5 Proof of Proposition \ref{prop:privatecompare} {-}

The private majority payoff vectors for \(H\) are
\[
V_M^{B,S}=(\beta\ell,\beta h),\quad
V_M^{B,P}=(\beta h,\beta h),\quad
V_M^{B,E}=(\ell,h).
\]
The private unanimity vectors are \((\beta\ell,\beta h)\) at \(p=0\),
empty for \(0<p\leq p^*\), and
\((\beta h,\beta h)\) for \(p>p^*\). Componentwise subtraction gives
the proposition. On any proposal segment, subtraction is affine in the common
proposal weight, so the payoff set and outcome set remain atomic. \(\square\)

## B.6 Proofs of Propositions \ref{prop:rents} and \ref{prop:deltari} {-}

From Proposition \ref{prop:public}, the public payoff vectors are
\[
v_M^B=(v_M^B(\ell),v_M^B(h)),\qquad
v_U^B=(\beta\ell,\beta h).
\]
Subtracting these from each private vector gives the table in Proposition
\ref{prop:rents}. In particular, unanimity is payoff-equivalent to its public
endpoint at \(p=0\), is empty in the middle cell, and pools above the cutoff,
which yields \((\beta(h-\ell),0)\).

Subtract \(IR_M^B\) from \(IR_U^B\). In the high-belief cell, screening gives
\((\beta(h-\ell),0)\) when both types are publicly included and
\((\beta(h-\ell),(1-\beta)h)\) when only the low type is publicly included;
pooling gives zero. Exclusion gives
\((\beta h-\ell,-(1-\beta)h)\), \((\beta h-\ell,0)\), or
\((\beta(h-\ell),0)\), respectively when both types are included, only the
low type is included, or both types are excluded.
The endpoint follows by the same calculation. An empty source set remains
empty. For the residual segment, affine subtraction with its common weight
\(\lambda\) yields the one-dimensional segment stated in the propositions,
not the Cartesian product of marginal envelopes. \(\square\)


# Memorando de derivação candidato — texto integral

O documento a seguir é o objeto primário da consulta. Seu SHA-256 é
`f510f82eb0f9f6e3e7cc8a59a6d26724cea3cff7ee53da2d1eabdbb3c3264665`.

A condição de sucesso não é que a redação pareça plausível, mas que as
derivações sustentem todas as alegações restritas de invariância.

# Derivação candidata — B.1/B.3 sob a regra de exclusão mutuamente exclusiva

**Status:** IMPLEMENTER CANDIDATE — UNREVIEWED — UNFROZEN

**Manuscrito:** NÃO ALTERADO por este memorando

**Branch:** `codex/exclusion-proof-b1-b3`

**HEAD de abertura:** `e10bf08e1f994705b64430e60328cbdd952f01d4`

## 1. Mandato e limite

Este memorando rederiva apenas as partes das provas B.1 e B.3 afetadas pela
regra aprovada de exclusão. Ele também realiza uma auditoria semântica de toda
a Appendix B, mas não autoriza nem executa alterações em
`formal_model_v6.Rmd`.

A correção de payoff é:

- se `H` vota sim e a proposta passa, `H` participa e recebe `x_H`;
- se `H` vota não e a maioria aprova sem ele, `H` não participa, recebe apenas
  `o`, e `x_H` não é pago a ninguém;
- alocação de acordo e outside option nunca são somadas na mesma história.

Não são reabertos o protocolo de votação, o espaço de propostas, o conceito de
solução, a estrutura de crenças, o valor unitário da pie ou qualquer extensão.

## 2. Inputs normativos e boundary reproduzível

Os inputs lidos antes da derivação foram:

| Artefato | SHA-256 na abertura |
|---|---|
| `formal_model_v6.Rmd` | `374bbd4b381a9be797fecadeca875fcd42ba8b946191ad389bd8b7994f70ae43` |
| `quality_reports/2026-09-01_decisao_exclusao_payoffs_e_fundamentos.md` | `5b165b65e3ade3ee1ff67c714fddbd35dd030b8e5b315b447132fd7f7c6e0982` |
| `quality_reports/2026-09-01_decisao_structural_consistency_baseline.md` | `7e671effa200117228d837201a5151922c4fd014af93758de38616b04a8346d5` |
| `notes/2026-09-01_explicacao_completa_correcao_exclusao_teto.md` | `ea1cdae25e512543ded0af35456f2b2b22458a905d99a7592309dc798a1c1e0a` |

Alterações simultâneas do autor em `CLAUDE.md` e o arquivo não rastreado
`notes/2026-09-01_escopo_exit_power_exemplos_do_autor.md` foram preservados e
ficam fora do candidato aqui delimitado.

## 3. Objetos usados

Há um hegemon `H`, `m >= 3` Estados fracos e um proponente fraco. O proponente
é contado como voto sim. Sob maioria, são necessários

\[
k=\left\lfloor\frac{m+1}{2}\right\rfloor
\]

votos adicionais. A proposta é não negativa e satisfaz

\[
x_H+\sum_{j\in W}x_j\leq 1.
\]

Em Round 1, o preço de continuação de um Estado fraco sob maioria é

\[
w=\frac{\beta}{m}.
\]

Seja `n_Y` o número de respondedores fracos cuja alocação é ao menos `w` e que,
pela regra as-if-pivotal e pelo desempate em favor de sim, votam sim.

## 4. Lema de eliminação de concessão não pivotal

**Lema.** Considere uma proposta aprovada sob maioria pelos votos do
proponente e de pelo menos `k` respondedores fracos, de modo que o voto de `H`
não seja necessário. Qualquer proposta dessa classe com `x_H>0` é
estritamente subótima para o proponente.

**Prova.** Fixe uma proposta `x` dessa classe com `x_H>0`. Construa `x'` por

\[
x'_H=0,\qquad x'_i=x_i+x_H,\qquad x'_j=x_j\quad(j\neq i,H),
\]

onde `i` é o proponente. A soma das alocações não muda, portanto `x'` é
factível. As alocações e os votos dos respondedores fracos não mudam; seus
votos continuam bastando para aprovar a proposta. Uma eventual mudança do
voto de `H` também não muda a aprovação.

Sob `x`, há duas possibilidades. Se `H` vota não, `x_H` não é pago e o
proponente recebe `x_i`. Se `H` vota sim, `H` recebe `x_H`, embora seu voto seja
desnecessário, e o proponente novamente recebe `x_i`. Sob `x'`, o proponente
recebe `x_i+x_H`. Seu ganho é estritamente `x_H>0` nos dois casos. Logo `x` não
pode ser uma escolha ótima do proponente. \(\square\)

Uma formulação verbal clara do argumento é:

> Quando os votos dos Estados fracos já bastam para aprovar a proposta, o
> proponente não ganha nada ao reservar uma parcela positiva para `H`. Se `H`
> votar não, `x_H` não será pago; se votar sim, `H` receberá `x_H`, embora seu
> voto seja desnecessário para a aprovação. Em qualquer dos casos, o
> proponente pode fixar `x_H=0`, acrescentar essa parcela à própria alocação e
> manter a proposta aprovada. Portanto, nessa classe de propostas, todo
> `x_H>0` é estritamente subótimo para o proponente.

O lema usa apenas não negatividade, a restrição agregada da pie e a
especificidade de `x_H`. Não introduz cap sobre `x_H` nem requer que a pie seja
exaurida fora do caminho.

## 5. B.1 — benchmark de tipo público

### 5.1 Maioria terminal

O valor de desacordo de um respondedor fraco é zero. A regra de sim na
indiferença implica voto sim para toda alocação não negativa, inclusive zero.
Como há respondedores fracos suficientes para satisfazer a quota sem `H`, o
proponente pode aprovar oferecendo zero a todos eles.

Quando os votos fracos já bastam, `H` é não pivotal e compara:

\[
u_H(Y)=x_H,\qquad u_H(N)=o.
\]

Logo `H` vota sim se e somente se `x_H >= o`, com sim na igualdade. Não é
correto afirmar que todo tipo vota não para todo `x_H`.

Pelo lema da Seção 4, porém, qualquer `x_H>0` é estritamente subótimo para o
proponente nessa classe. A escolha ótima fixa `x_H=0`. Como `o>0`, `H` então
vota estritamente não, recebe `o`, cada respondedor fraco recebe zero e o
proponente recebe a pie inteira. Portanto, permanece válido o resultado
reportado na Proposition `prop:public` e reutilizado como resultado único na
Proposition `prop:terminal`.

### 5.2 Unanimidade terminal

Sob unanimidade, `H` é pivotal. Votar sim implementa `x_H`; votar não leva ao
desacordo terminal `o`. Assim, `H` aceita exatamente quando `x_H >= o`, e o
proponente escolhe `x_H=o`. A correção da regra de exclusão não altera este
ramo, pois uma proposta não pode passar sob unanimidade após o voto não de
`H`.

### 5.3 Round 1

Sob maioria, as duas escolhas relevantes continuam sendo:

- inclusão: comprar `k-1` votos fracos por `w=beta/m` e o voto pivotal de `H`
  por `beta o`, ao custo `(k-1)w+beta o`;
- exclusão: comprar `k` votos fracos por `w` e fixar `x_H=0`, ao custo `kw`.

Quando `H` é pivotal, votar não leva ao Round 2, no qual a maioria terminal lhe
garante `o`; em unidades de Round 1, seu limiar é `beta o`. Quando os `k` votos
fracos já bastam, o lema elimina todo `x_H>0`, e `H` recebe `o` após votar não.

Portanto, inclusão é fracamente mais barata exatamente quando

\[
(k-1)\frac{\beta}{m}+\beta o
\leq k\frac{\beta}{m}
\quad\Longleftrightarrow\quad
o\leq\frac1m.
\]

Na igualdade, o payoff do proponente coincide e o desempate entre propostas
seleciona inclusão porque ela dá a `H` o payoff menor, `beta o < o`. O cutoff,
os payoffs e as classes da Proposition `prop:public` permanecem inalterados.

### 5.4 Texto inglês candidato para B.1

O texto abaixo é apenas candidato para migração futura, depois dos gates:

> In terminal majority, a weak responder's disagreement value is zero, so any
> nonnegative allocation induces yes under the indifference-to-yes convention.
> The weak-state votes can therefore pass the proposal without \(H\). At any
> such proposal, a nonpivotal \(H\) votes yes exactly when \(x_H\geq o\): yes
> yields \(x_H\), whereas no yields \(o\). Yet every \(x_H>0\) is strictly
> suboptimal for the proposer. If \(H\) votes no, \(x_H\) is paid to no one;
> if \(H\) votes yes, it is paid for a vote that is unnecessary for passage.
> In either case, setting \(x_H=0\) and assigning that amount to the proposer
> preserves passage and raises the proposer's payoff by \(x_H\). Hence the
> unique equilibrium outcome has \(x_H=0\), the proposer keeps the unit pie,
> and \(H\) votes no and receives \(o\).

Os demais parágrafos atuais de B.1 podem permanecer, pois seus preços de voto,
comparações e desempates são os rederivados acima.

## 6. B.3 — maioria privada em Round 1

Um respondedor fraco vota sim exatamente quando `x_j >= w`. Fixada uma
proposta, há três classes exaustivas.

### 6.1 Caso `n_Y >= k`: `H` não pivotal

Os votos fracos aprovam a proposta qualquer que seja o voto de `H`. A
comparação correta de `H`, tipo a tipo, é

\[
u_H(Y\mid n_Y\geq k)=x_H,
\qquad
u_H(N\mid n_Y\geq k)=o.
\]

Logo o tipo `o` vota sim se e somente se `x_H >= o`, com sim na igualdade. A
estratégia fora do caminho, portanto, muda em relação ao texto antigo.

Para a escolha ótima do proponente, o lema elimina estritamente todo
`x_H>0`. Reduzir `x_H` a zero e transferir a diferença ao proponente preserva
os votos fracos e a aprovação. Assim, o único candidato ótimo dessa classe
fixa `x_H=0`; ambos os tipos votam estritamente não porque `ell>0`, e recebem
suas respectivas outside options. Pagando exatamente `w` a `k` respondedores
fracos, o payoff do proponente continua sendo

\[
\Pi_E=1-kw.
\]

### 6.2 Caso `n_Y = k-1`: `H` pivotal

Se `H` vota sim, a proposta passa e o tipo `o` recebe `x_H`. Se vota não, a
proposta falha e segue para a maioria terminal. Como a maioria terminal exclui
`H` e lhe entrega `o` independentemente da crença, o valor da continuação em
unidades de Round 1 é `beta o`. Portanto,

\[
u_H(Y\mid n_Y=k-1)=x_H,
\qquad
u_H(N\mid n_Y=k-1)=\beta o,
\]

e `H` vota sim exatamente quando `x_H >= beta o`.

Os candidatos de screening e pooling permanecem:

- screening: `x_H=beta ell`, aceito pelo tipo baixo e rejeitado pelo alto;
- pooling: `x_H=beta h`, aceito por ambos os tipos.

Se o tipo alto rejeita a oferta de screening, a proposta falha e ele recebe
`beta h`; esse cálculo não soma alocação e outside option.

### 6.3 Caso `n_Y <= k-2`: falha inevitável

Mesmo acrescentando o voto de `H`, a quota não é atingida. A proposta falha e
cada tipo de `H` recebe a mesma continuação de maioria terminal `beta o` após
sim ou não. Como a continuação é independente da crença, `H` é indiferente e
vota sim pela convenção de desempate. Este detalhe completa a estratégia fora
do caminho, mas não cria uma nova classe de resultado.

### 6.4 Redução aos candidatos e comparação

Dentro de cada classe relevante, reduzir pagamentos fracos a `w`, reduzir
`x_H` ao limiar pivotal aplicável e atribuir o resíduo ao proponente aumenta
fracamente — e, para uma concessão não pivotal positiva, estritamente — o
payoff do proponente. Permanecem exatamente quatro candidatos:

\[
\Pi_E=1-kw,
\]

\[
\Pi_S(p)=(1-p)[1-(k-1)w-\beta\ell]+pw,
\]

\[
\Pi_P=1-(k-1)w-\beta h,
\]

e delay, com payoff `w`.

Essas expressões e suas diferenças não usam a fórmula antiga `x_H+o`. Logo
permanecem:

\[
\Pi_E-w=1-\frac{\beta(k+1)}m>0,
\]

\[
\Pi_P-\Pi_E=\beta(1/m-h),
\]

e

\[
\Pi_S(p)-\Pi_E
=(1-p)\beta(1/m-\ell)-p[1-\beta(k+1)/m].
\]

Os cutoffs `p_{S=P}` e `p_{S=E}`, as cinco regiões da Proposition
`prop:majority`, o desempate em favor de screening, o segmento residual no
knife edge e a multiplicidade por permutação de Estados fracos permanecem
inalterados.

### 6.5 Texto inglês candidato para a abertura de B.3

> A responding weak state votes yes exactly when \(x_j\geq
> w=\beta/m\). Let \(n_Y\) be the number of such responders. If
> \(n_Y\geq k\), the weak-state votes pass the proposal without \(H\). A
> nonpivotal type with outside option \(o\) then votes yes exactly when
> \(x_H\geq o\): yes yields \(x_H\), whereas no yields \(o\). Nevertheless,
> every \(x_H>0\) in this class is strictly suboptimal for the proposer. Moving
> \(x_H\) to the proposer's own allocation preserves the weak-state votes and
> passage and raises the proposer's payoff by \(x_H\). Hence the optimal
> exclusion candidate sets \(x_H=0\); both types then vote no and receive their
> outside options. If \(n_Y=k-1\), \(H\) is pivotal and a type with outside
> option \(o\) votes yes exactly when \(x_H\geq\beta o\), because no leads to
> the terminal-majority continuation. If \(n_Y\leq k-2\), the proposal fails
> regardless of \(H\)'s vote; the two ballot actions deliver the same
> terminal-majority continuation, so the indifference-to-yes convention
> selects yes.

O restante da prova atual de B.3 pode permanecer somente se a revisão
independente confirmar que suas fórmulas e afirmações de multiplicidade não
dependem implicitamente da regra antiga.

## 7. O que muda e o que não muda

| Objeto | Diagnóstico candidato | Razão |
|---|---|---|
| Payoff de `H` após aprovação sem sua participação | **Muda** | É `o`, nunca `x_H+o`. |
| Resposta de `H` quando `n_Y>=k` e `x_H>0` | **Muda** | `H` compara `x_H` com `o`; não vota sempre não. |
| Resposta de `H` quando `n_Y<=k-2` | **É explicitada** | A continuação terminal-majoritária é igual após os dois votos; o desempate seleciona sim. |
| Escolha ótima de `x_H` sob exclusão | **Não muda** | O lema elimina estritamente todo `x_H>0`. |
| Resultado terminal-majoritário | **Não muda** | `x_H=0`, aprovação sem `H`, proponente recebe 1 e `H` recebe `o`. |
| Limiar de `H` quando pivotal em Round 1 | **Não muda** | Continua `beta o`. |
| `Pi_E`, `Pi_S`, `Pi_P` e delay | **Não mudam** | Usam `x_H=0` na exclusão e os limiares pivotais nas classes de inclusão. |
| Cutoffs e cinco regiões de `prop:majority` | **Não mudam** | Derivam das mesmas diferenças de payoff. |
| Crenças após votos fora do caminho | **A disciplina não muda** | A nova resposta deve respeitar Bayes/consistência estrutural, mas não há continuação após uma proposta que já passou. |
| Correspondência completa de estratégias | **Muda** | Há respostas diferentes de `H` em propostas não pivotais com `x_H>0`; não se deve alegar invariância da estratégia completa. |
| Correspondência reportada de resultados e payoffs | **Não muda, sujeito a revisão** | As propostas alteradas são estritamente subótimas para o proponente. |
| Multiplicidades existentes | **Não mudam, sujeito a revisão** | Persistem permutações de respondedores e o segmento residual já declarado; não surge família ótima em `x_H`. |

Portanto, a afirmação segura é de invariância das proposições reportadas sobre
resultados, payoffs, cutoffs, classes e multiplicidades já declaradas — não de
invariância da estratégia PBE completa em todas as histórias.

## 8. Auditoria semântica de toda a Appendix B

### B.1

**Afetada diretamente.** A frase que atribui `x_H+o` após não está errada. A
substituição candidata da Seção 5 corrige a resposta de `H` e prova, por
desvio estrito do proponente, por que o resultado reportado continua válido.

### B.2

**Afetada apenas por referência.** O argumento de maioria terminal remete à
parte terminal-majoritária de B.1. Lida com a B.1 corrigida, a conclusão
`x_H=0`, payoff 1 ao proponente e `o` a `H` permanece. O argumento de
unanimidade e o cutoff `p^*` não usam exclusão por maioria.

### B.3

**Afetada diretamente.** A classificação inicial das respostas de `H` precisa
ser corrigida nos três casos de `n_Y`. A redução aos quatro candidatos e todas
as comparações subsequentes permanecem, condicionadas aos pareceres
independentes.

### B.4

**Não afetada.** Trata de unanimidade. Toda proposta aprovada requer o sim de
`H`; não existe aprovação que exclua `H`. Seus argumentos de continuação,
crenças e existência não usam `x_H+o`.

### B.5

**Não afetada nos vetores reportados.** Os vetores de maioria usam `o` para a
classe de exclusão e `beta o` para as classes em que `H` é pivotal. São
exatamente os payoffs rederivados aqui. A subtração componente a componente
permanece.

### B.6

**Não afetada na álgebra reportada.** As correspondências de rents usam os
vetores de B.5 e o benchmark público. Como esses vetores permanecem, as
diferenças também permanecem. A conclusão depende, contudo, da confirmação
independente de B.1/B.3 e não recebe PASS deste memorando.

## 9. Perguntas obrigatórias para os pareceristas

1. O desvio `x_H -> 0`, `x_i -> x_i+x_H` é factível e estritamente lucrativo
   em todas as propostas nas quais os votos fracos já bastam?
2. Existe alguma história em que reduzir `x_H` altere votos fracos, a quota ou
   o payoff do proponente de forma não considerada?
3. O limiar `beta o` no ramo pivotal permanece correto sob a datação e a
   continuação terminal-majoritária atuais?
4. A indiferença no ramo `n_Y<=k-2` realmente deve selecionar sim?
5. Algum cutoff, tie-break, segmento residual ou vetor de B.5/B.6 muda?
6. O memorando distingue corretamente estratégia completa de correspondência
   reportada de resultados/payoffs?
7. Há multiplicidade adicional em propostas ótimas, crenças ou respostas que
   invalide a alegação de invariância?

## 10. Gate atual

Este documento não emite PASS e não congela nenhuma prova. O próximo gate é
obter dois pareceres independentes, um de design formal e outro game-teórico
adversarial, sobre bytes fixados por SHA-256. Somente depois da adjudicação
desses pareceres será preparado o pacote para consulta externa. Nenhuma tag,
migração para o manuscrito, merge ou push é autorizada por este memorando.

# Formato obrigatório da consulta

Produza Markdown UTF-8 com o título
`Consulta técnica externa não formal — B.1/B.3 e regra de exclusão`.
Se a interface puder criar um arquivo, nomeie-o
`2026-09-01_consulta_tecnica_chatgpt_web_b1_b3_exclusion.md`; caso
contrário, devolva o Markdown completo, sem texto introdutório fora do
documento.

Use a seguinte estrutura:

1. **Boundary e método** — declare o objeto exato e como tentou refutá-lo.
2. **Veredicto executivo** — `PASS`, `REPAIR` ou `FAIL`, sempre com contagem
   `CRITICAL / IMPORTANT / MINOR`.
3. **Reconstrução independente** — apresente a lógica do desvio, os três
   casos de `n_Y`, o limiar pivotal e a redução aos candidatos.
4. **Findings** — para cada finding, dê severidade, localizador, evidência,
   efeito sobre resultados downstream e correção mínima. Não invente
   findings para preencher a seção.
5. **Respostas às dez perguntas de escopo** — uma resposta numerada para
   cada item do mandato.
6. **Auditoria da redação candidata** — diga se os dois parágrafos ingleses
   são matematicamente completos, claros e fiéis ao protocolo; proponha
   substituição apenas se houver defeito.
7. **Blast radius B.2--B.6** — indique `UNCHANGED`, `REPAIR` ou `UNRESOLVED`
   para cada subseção, com uma frase de justificativa.
8. **Conclusão operacional** — diga explicitamente se o candidato pode
   avançar à adjudicação externa sem reparo, com reparo delimitado ou se
   permanece bloqueado.

Um `PASS` cobre apenas o memorando no hash deste pacote. Ele não cobre o
manuscrito ainda não migrado, não cria tag, não autoriza merge/push e não
substitui decisão do autor.

# Proveniência, validação e bytes exatos

- Manuscrito corrente: `374bbd4b381a9be797fecadeca875fcd42ba8b946191ad389bd8b7994f70ae43`.
- Memorando candidato: `f510f82eb0f9f6e3e7cc8a59a6d26724cea3cff7ee53da2d1eabdbb3c3264665`.
- Parecer interno de design formal: `f761ff617be28062198e6c2378c4d70a806b908a78cd46792a33ec7191b129f2` — `PASS 0/0/0`.
- Auditoria game-teórica interna: `b185d21aae71148be7ed444d2abe4256493890314ac1d59d129ecb6e8fcedd6a` — `PASS 0/0/0`.
- Adjudicação Markdown: `e863ffb525d0a064574f958e5f668f0dfc8065404ebc9d7a1da196a6e1607441` — `NO_CONFIRMED_DEFECTS`.
- Adjudicação JSON: `abcc052db68d5e2df3d29a6ad27fb093a784fd7e8a1efe179532b8d171c14408` — validada pelo schema 1.0.
- Commit do candidato: `3f0b035`.
- Commit das revisões internas: `4905170`.
- Branch: `codex/exclusion-proof-b1-b3`.

As revisões internas são informadas apenas para proveniência. Sua tarefa é
uma leitura nova. O arquivo `.sha256` ao lado deste pacote fixa o próprio
pacote e todos os inputs acima.
