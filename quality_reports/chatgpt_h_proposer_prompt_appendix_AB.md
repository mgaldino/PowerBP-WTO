---
title: "H-Proposer Signaling Subgame: Prompt and Appendix A/B"
author: ""
date: "2026-05-10"
output:
  bookdown::pdf_document2:
    number_sections: true
    toc: true
    latex_engine: xelatex
header-includes:
  - \usepackage{setspace}
  - \setstretch{1.15}
  - \usepackage{parskip}
  - \setlength{\parskip}{6pt}
  - \setlength{\parindent}{0pt}
  - \usepackage{float}
  - \usepackage{amsmath,amssymb,amsthm}
  - \newtheorem{definition}{Definition}
  - \newtheorem{lemma}{Lemma}
  - \newtheorem{proposition}{Proposition}
  - \newtheorem{theorem}{Theorem}
  - \newtheorem{corollary}{Corollary}
  - \newtheorem{assumption}{Assumption}
  - \newtheorem{remark}{Remark}
  - \newtheorem{example}{Example}
  - \usepackage{booktabs}
fontsize: 11pt
geometry: margin=2.5cm
mainfont: Times New Roman
---

# Prompt for ChatGPT Pro

We are working on a formal theory paper. The main body is known to be outdated; use only the appendix excerpt below as proof status.

Note: cross-references to the main body may appear in the excerpt, but they are not needed for this task. Treat the primitives and formulas stated in Appendix A/B as self-contained.

Task: solve, or characterize as far as possible, the R1 subgame in which the hegemon $H$ proposes under unanimity.

Goal: determine whether the H-proposer payoff outside the accepted-pooling region is a unique equilibrium payoff function, a non-singleton payoff correspondence, or not characterizable without an equilibrium refinement/selection rule.

Please do the following:

1. Formalize the H-proposer signaling subgame precisely.
2. Characterize all pure-strategy PBE: accepted pooling; both types accepted with different proposals; high accepted/low rejected; low accepted/high rejected; both rejected.
3. For nonexistence results, handle BF feasibility carefully: a proposal feasible for the high type need not be feasible for the low type.
4. If pure-strategy PBE do not exist outside accepted pooling, analyze whether mixed-strategy PBE exist and characterize the payoff correspondence if possible.
5. State whether H's payoff outside pooling is unique or selection-dependent.
6. If exact characterization is too hard, derive the tightest possible upper and lower bounds on H's payoff, with explicit parameter conditions.
7. Identify which pieces can be turned into paper-ready lemmas.
8. Flag assumptions about off-path beliefs, tie-breaking, and refinements such as Cho-Kreps/D1.

Do not rescue old theorem statements. Rederive from primitives.

\newpage

# Appendix Excerpt

# Appendix A: Bargaining Derivations {-}

## Notation summary {-}

\begin{table}[H]
\centering\small
\begin{tabular}{lll}
\toprule
Symbol & Meaning & Defined in \\
\midrule
$N$ & Number of players ($1$ hegemon $+ N-1$ weak states) & Def.\ 1 \\
$\theta \in \{0,1\}$ & State of the world & Def.\ 1 \\
$p$ & Prior $\Pr(\theta=1)$ & Def.\ 1 \\
$\mu$ & Posterior belief $\Pr(\theta=1 \mid \text{history})$; equals $p$ at entry, updated after R1 rejection & Sec.\ 3 \\
$V(\theta)$ & Value of cooperation: $V(0)=1$, $V(1)=r$ & Def.\ 1 \\
$r > 1$ & High-type value & Def.\ 1 \\
$\alpha \in (0, 1/r)$ & Outside-option share: $d_H = \alpha V(\theta)$ & Def.\ 1 \\
$\beta \in (0,1)$ & Common discount factor & Def.\ 1 \\
$c > 0$ & Entry cost per weak state & Def.\ 1 \\
$V_e(\mu)$ & Expected cooperation value $1 + \mu(r-1)$ & Sec.\ 3 \\
$x$ & Shorthand $(N-1)\alpha r$ & Sec.\ 3 \\
$q$ & Majority quota $\lfloor N/2 \rfloor + 1$ & Def.\ 1 \\
$R \in \{M, U\}$ & Voting rule (majority / unanimity) & Def.\ 1 \\
$\mu_s^{R2}$ & R2 screening cutoff & App.\ A.2 \\
$\mu_s^{R1}$ & Superseded single-cutoff object; replaced by constrained A/C/R regimes & App.\ A.3--A.4 \\
$\phi$ & Superseded auxiliary for the old single-cutoff formula & App.\ A.3--A.4 \\
$\tau(R)$ & Entry threshold under rule $R$ & Sec.\ 6 \\
$v(\mu, R)$ & Hegemon's net gain from institution: $E[V_H^{R1}] - \alpha V_e(\mu)$ if entry, $0$ otherwise & Sec.\ 6 \\
$\bar\alpha$ & Regime threshold for $\alpha$-independent R1 cutoff & Prop.\ 2 \\
$\alpha^*$ & Threshold for conditional dominance (Thm.\ 1): necessary and sufficient & main-text threshold equation (not included here) \\
$\omega(\mu)$ & R2 continuation shorthand: $(N\!-\!2)\beta V_W^{R2}(\mu)$ & App.\ A.3 \\
$\kappa_M^E$ & Corrected majority weak-state coefficient: $[N(N\!-\!1)\!+\!\beta(q\!-\!1)]/[N^2(N\!-\!1)]$ & App.\ A.1 \\
$D(\mu)$ & Conditional payoff difference $V_H^{R1}(\mu,U) - V_H^{R1}(\mu,M)$ & Thm.\ 1 \\
$\Gamma$ & Marginal value of uncertainty for unanimity & Remark 1 \\
$\bar\mu$ & Belief threshold above which majority dominates: $1 - |D(1)|/\Gamma$ & Remark 1 \\
$C_{\text{buy}}, C_{\text{out}}$ & Vote-buying cost, outside-option cost (proof) & App.\ B.5 \\
$\lambda_M^E$ & Corrected majority payoff coefficient & App.\ A.1--B.1 \\
$\mathcal{F}_R$ & Formation set under rule $R$: $\{p : V_W^{R1}(p, R) \geq c\}$ & Sec.\ 7 \\
\bottomrule
\end{tabular}
\end{table}

## A.1 Majority: R2 and R1 under external outside options {-}

\paragraph{Status.} Verified under the corrected accounting convention. When a weak proposer excludes $H$ under majority, $H$ receives $\alpha V(\theta)$ from an outside option external to the institutional pie. This payoff is not paid by the weak coalition.

Under majority, weak proposers can form a winning coalition from other weak states. Since including $H$ requires a strictly positive transfer and excluding $H$ does not reduce the institutional pie available to the weak coalition, weak proposers exclude $H$ in both rounds. The hegemon's private information therefore does not create a screening problem under majority.

R2 continuation values:
\begin{align}
V_H^{R2}(\theta, M) &= \frac{V(\theta)[1+(N-1)\alpha]}{N}, \\
V_W^{R2}(\mu, M) &= \frac{V_e(\mu)}{N}. \label{eq:VW_R2_M_ext}
\end{align}

The previous expression $V_W^{R2}(\mu,M)=(1-\alpha)V_e(\mu)/N$ treated $H$'s outside option as if it were subtracted from the weak coalition's pie. That expression is not consistent with the model's external outside-option interpretation.

In R1, if $H$ proposes, it buys $q-1$ weak votes at cost $\beta V_W^{R2}(\mu,M)$ each. If a weak state proposes, it excludes $H$ and $H$ receives $\alpha V(\theta)$ externally. Thus:
\begin{align}
E_\theta[V_H^{R1}(\theta,\mu,M)]
&= \frac{1}{N}\left[V_e(\mu)-(q-1)\beta\frac{V_e(\mu)}{N}\right]
   +\frac{N-1}{N}\alpha V_e(\mu) \nonumber\\
&= \lambda_M^E V_e(\mu), \label{eq:lambda_M_ext}
\end{align}
where
\[
\lambda_M^E \equiv \frac{N[1+(N-1)\alpha]-\beta(q-1)}{N^2}.
\]

The representative weak-state payoff is:
\begin{equation}\label{eq:kappa_M_ext}
V_W^{R1}(\mu,M)=\kappa_M^E V_e(\mu),
\qquad
\kappa_M^E
=\frac{N(N-1)+\beta(q-1)}{N^2(N-1)}.
\end{equation}

Finally,
\[
\lambda_M^E>\alpha
\quad\Longleftrightarrow\quad
\alpha<1-\frac{\beta(q-1)}{N}.
\]
This condition is not automatic and must be imposed whenever the comparison requires majority bargaining to dominate the outside option.

## A.2 Unanimity: R2 {-}

\paragraph{Status.} Verified, up to tie-breaking at the cutoff.

When $H$ proposes in R2, it offers zero to all weak states and keeps $V(\theta)$. When $W$ proposes, the proposer compares an aggressive offer, accepted only by the low type, with a conservative offer, accepted by both types:
\[
g(\mu)\equiv
\max\{(1-\mu)(1-\alpha),\,V_e(\mu)-\alpha r\}.
\]
The R2 weak-state continuation value is:
\begin{equation}\label{eq:W2_U_compact}
W_2(\mu)\equiv V_W^{R2}(\mu,U)=\frac{g(\mu)}{N}.
\end{equation}
The screening cutoff is:
\begin{equation}\label{eq:cutoff_R2}
\mu_s^{R2}=\frac{\alpha(r-1)}{r-\alpha}.
\end{equation}
Below the cutoff, $W$ plays aggressive; above it, $W$ plays conservative. At $\mu_s^{R2}$, $W$ is indifferent and the equilibrium requires an explicit tie-breaking convention.

The hegemon's R2 continuation values under unanimity are:
\begin{align}
V_H^{R2}(\theta=1, \mu) &= \frac{r[1+(N-1)\alpha]}{N} \quad \text{(constant in $\mu$)}, \label{eq:VH1_R2_U} \\
V_H^{R2}(\theta=0, \mu < \mu_s^{R2}) &= \frac{1 + (N-1)\alpha}{N}, \label{eq:VH0_R2_agg} \\
V_H^{R2}(\theta=0, \mu > \mu_s^{R2}) &= \frac{1 + (N-1)\alpha r}{N} \quad \text{(overpaid)}. \label{eq:VH0_R2_con}
\end{align}

Equivalently, weak states' R2 continuation values are:
\begin{align}
V_W^{R2}(\mu < \mu_s^{R2}) &= \frac{(1-\mu)(1-\alpha)}{N}, \\
V_W^{R2}(\mu > \mu_s^{R2}) &= \frac{V_e(\mu) - \alpha r}{N}.
\end{align}

Continuity at $\mu_s^{R2}$ is verified by direct substitution.

## A.3 Unanimity: R1 when a weak state proposes {-}

\paragraph{Status.} Verified under strict BF feasibility. The previous single-cutoff derivation is superseded.

Let
\[
A_0\equiv 1+(N-1)\alpha,\qquad
A_1\equiv 1+(N-1)\alpha r,\qquad
k\equiv N-2.
\]
When a weak state proposes in R1 under unanimity, it must secure $H$'s vote and the votes of the $k$ non-proposing weak states. Since the weak proposer does not know $\theta$, any accepted proposal that can pass in the low state must fit inside the low-state pie.

\paragraph{Conservative offer.} A conservative offer is accepted by both types of $H$. The high type binds, so the transfer to $H$ is:
\[
h_C=\frac{\beta r A_0}{N}.
\]
Each non-proposing weak state receives its discounted R2 continuation value, $\beta W_2(\mu)$. The conservative proposer payoff is:
\begin{equation}\label{eq:R1_W_C}
C(\mu)=V_e(\mu)-h_C-k\beta W_2(\mu),
\end{equation}
and the offer is feasible iff:
\begin{equation}\label{eq:R1_W_C_feas}
h_C+k\beta W_2(\mu)\le 1.
\end{equation}

\paragraph{Aggressive offer.} An aggressive offer is accepted by the low type and rejected by the high type. Because a high-type rejection is public and leads to posterior one in R2, the low type must receive:
\[
h_A=\frac{\beta A_1}{N}.
\]
Under standard BF voting with public vote profiles, a non-proposing weak state is pivotal only when $H$ accepts, i.e., in the low state. Thus its binding transfer is:
\[
y_A=\beta W_2(0)=\frac{\beta(1-\alpha)}{N}.
\]
The aggressive proposer payoff is:
\begin{equation}\label{eq:R1_W_A}
A(\mu)=(1-\mu)\left[1-h_A-k y_A\right]+\mu\beta W_2(1),
\end{equation}
and the offer is feasible iff:
\begin{equation}\label{eq:R1_W_A_feas}
h_A+k y_A\le 1.
\end{equation}

\paragraph{Deliberate rejection.} The proposer can also make an offer that both types reject, yielding:
\begin{equation}\label{eq:R1_W_R}
R(\mu)=\beta W_2(\mu).
\end{equation}

Therefore, the verified R1 weak-proposer value is:
\begin{equation}\label{eq:R1_W_choice}
W^{prop}_1(\mu,U)=
\max\{A(\mu)\ \text{if feasible},\ C(\mu)\ \text{if feasible},\ R(\mu)\}.
\end{equation}

This is the key correction. Strict BF feasibility can remove the conservative option at high beliefs, so R1 screening is not generally represented by a single monotone aggressive-to-conservative cutoff.

## A.4 Unanimity: R1 when the hegemon proposes {-}

\paragraph{Status.} Partly verified. The old pooling formula is valid only on the pooling branch. A selection-free lower bound is verified and used below; a complete pure-strategy PBE characterization outside the pooling region remains pending.

The old H-proposer expression assumes that both types of $H$ offer each weak state $\beta W_2(\mu)$ and that the offer is accepted. This pooling expression,
\[
V(\theta)-(N-1)\beta W_2(\mu),
\]
is valid only if the low-state proposal is feasible and both types prefer agreement to rejection.

A verified selection-free lower bound is:
\begin{equation}\label{eq:H_prop_lower_bound}
L_H(\mu)
=(1-\mu)\frac{\beta A_0}{N}
+\mu\left[r-(N-1)\frac{\beta r(1-\alpha)}{N}\right].
\end{equation}

To see this, the low type can offer zero. If the offer is accepted, it receives $1\ge \beta A_0/N$; if it is rejected, its R2 continuation is at least $\beta A_0/N$. The high type can offer each weak state $\beta W_2(1)+\varepsilon$. Since $W_2(q)\le W_2(1)$ for all posteriors $q$, this offer is accepted for any beliefs. Letting $\varepsilon\downarrow 0$ gives the high-type term in \eqref{eq:H_prop_lower_bound}.

## A.5 Calibrated R1 weak-proposer regimes {-}

\paragraph{Status.} Verified for the calibration $N=13$, $r=1.5$, $\alpha=0.19$, $\beta=0.9$.

For this calibration:
\[
\mu_s^{R2}=0.072519,\quad
h_C=0.340615,\quad
h_A=0.306000,\quad
y_A=0.056077.
\]
The aggressive offer is feasible:
\[
h_A+11y_A=0.922846<1.
\]
The aggressive and conservative payoffs cross at:
\[
\mu_{AC}=0.031188.
\]
The conservative offer is feasible only up to:
\[
\mu_C^F=0.301717.
\]
Hence the weak-proposer regime is:
\[
A \quad\text{for}\quad \mu<0.031188,
\]
\[
C \quad\text{for}\quad 0.031188<\mu\le 0.301717,
\]
\[
A \quad\text{for}\quad \mu>0.301717.
\]
Here $A$ means the aggressive offer and $C$ means the conservative offer. The final return to $A$ is not a new screening cutoff; it is caused by strict low-state feasibility. At high beliefs, the conservative offer would require transfers that do not fit inside the low-state pie.

## A.6 Budget checks {-}

\paragraph{Status.} The old budget-balance argument is superseded.

Under corrected majority accounting,
\[
E[V_H(\mu,M)]+(N-1)V_W(\mu,M)
\]
includes $H$'s external outside-option payoff when $H$ is excluded. It is therefore not an identity for division of the institutional pie. Any proof of $\mathcal F_U\subseteq \mathcal F_M$ must compare weak-state payoffs directly or impose separate sufficient conditions; it cannot follow from the old budget-balance step.

## A.7 Entry thresholds {-}

\paragraph{Status.} Majority entry is verified. Unanimity entry must be rederived from the corrected R1 subgame and the H-proposer branch.

With collective all-or-nothing entry by weak states, majority forms iff:
\[
V_W^{R1}(\mu,M)=\kappa_M^E V_e(\mu)\ge c,
\]
where $\kappa_M^E$ is defined in \eqref{eq:kappa_M_ext}. Thus:
\[
\mathcal F_M^E=\{\mu\in(0,1]:\kappa_M^E[1+\mu(r-1)]\ge c\}.
\]
Equivalently, with the usual truncation,
\[
\tau_M^E=\frac{c/\kappa_M^E-1}{r-1}.
\]

The unanimity entry set remains pending because the weak-state R1 payoff must incorporate the corrected weak-proposer regimes and the unresolved H-proposer signaling branch. The old closed-form conservative threshold from the superseded draft is therefore not used in the corrected proof architecture.



# Appendix B: Proofs {-}

\paragraph{Correction note.} This appendix records the proof status under the corrected model: external outside options under majority and strict BF feasibility in every proposal. Results marked as pending are not used as established results in the corrected proof architecture.

## B.1 Proof of Proposition 1 (Majority produces no screening) {-}

\paragraph{Status.} Verified after correcting the outside-option accounting.

In R2, if $H$ proposes, it buys $q-1$ weak votes at zero cost and keeps $V(\theta)$. If a weak state proposes, it can form a winning coalition with other weak states and exclude $H$. Since $H$'s outside option is external, exclusion does not reduce the weak coalition's institutional pie. Including $H$ would require a strictly positive transfer, so exclusion is optimal.

Therefore:
\[
V_H^{R2}(\theta,M)=\frac{[1+(N-1)\alpha]V(\theta)}{N},
\qquad
V_W^{R2}(\mu,M)=\frac{V_e(\mu)}{N}.
\]

In R1, if $H$ proposes, it pays $(q-1)\beta V_e(\mu)/N$ to weak coalition partners. If a weak state proposes, it again excludes $H$, so $H$ receives $\alpha V(\theta)$ externally. Hence:
\[
E_\theta[V_H^{R1}(\theta,\mu,M)]
=\lambda_M^E V_e(\mu),
\qquad
\lambda_M^E=
\frac{N[1+(N-1)\alpha]-\beta(q-1)}{N^2}.
\]
This is affine in $\mu$. Since weak proposers exclude $H$ at every belief, they never choose between aggressive and conservative offers to $H$; hence there is no screening cutoff under majority. $\square$

The representative weak-state payoff is:
\[
V_W^{R1}(\mu,M)=\kappa_M^E V_e(\mu),
\qquad
\kappa_M^E
=\frac{N(N-1)+\beta(q-1)}{N^2(N-1)}.
\]

The auxiliary inequality needed for the entry-comparison case in which majority forms but unanimity does not is:
\[
\lambda_M^E>\alpha
\quad\Longleftrightarrow\quad
\alpha<1-\frac{\beta(q-1)}{N}.
\]
Unlike the old proof, this inequality does not follow automatically from $\alpha<1/r$.

## B.2 Corrected R1 weak-proposer characterization under unanimity {-}

\paragraph{Status.} Verified.

Appendix A.3 derives the three feasible weak-proposer options in R1 under unanimity:
\[
C(\mu)=V_e(\mu)-h_C-(N-2)\beta W_2(\mu),
\qquad
h_C=\frac{\beta r[1+(N-1)\alpha]}{N},
\]
with feasibility condition
\[
h_C+(N-2)\beta W_2(\mu)\le 1;
\]
\[
A(\mu)=(1-\mu)\left[1-h_A-(N-2)y_A\right]+\mu\beta W_2(1),
\]
where
\[
h_A=\frac{\beta[1+(N-1)\alpha r]}{N},
\qquad
y_A=\frac{\beta(1-\alpha)}{N},
\]
with feasibility condition
\[
h_A+(N-2)y_A\le 1;
\]
and the deliberate-rejection option
\[
R(\mu)=\beta W_2(\mu).
\]

Thus the weak proposer chooses:
\[
W_1^{prop}(\mu,U)=
\max\{A(\mu)\ \text{if feasible},\ C(\mu)\ \text{if feasible},\ R(\mu)\}.
\]
This replaces the old proof of a unique monotone R1 cutoff. A single cutoff may exist on a subset where both accepted offers are feasible and dominate deliberate rejection, but it is not a global property of the strict BF subgame.

## B.3 Selection-free H-proposer lower bound under unanimity {-}

\paragraph{Status.} Verified. The complete H-proposer signaling subgame remains pending outside the pooling region, but the following lower bound does not rely on equilibrium selection.

For any posterior $q$,
\[
W_2(q)\le W_2(1)=\frac{r(1-\alpha)}{N}.
\]
The low type of $H$ can offer zero. If the offer is accepted, it receives $1$; if rejected, it receives at least $\beta[1+(N-1)\alpha]/N$ in R2. Since $1\ge \beta[1+(N-1)\alpha]/N$, the low type guarantees
\[
\frac{\beta[1+(N-1)\alpha]}{N}.
\]
The high type can offer each weak state $\beta W_2(1)+\varepsilon$, which is accepted under any posterior because $W_2(q)\le W_2(1)$. Letting $\varepsilon\downarrow0$, the high type guarantees
\[
r-(N-1)\frac{\beta r(1-\alpha)}{N}.
\]
Therefore the H-proposer branch is bounded below by:
\[
L_H(\mu)
=(1-\mu)\frac{\beta[1+(N-1)\alpha]}{N}
+\mu\left[r-(N-1)\frac{\beta r(1-\alpha)}{N}\right].
\]

## B.4 Calibrated lower-bound dominance check {-}

\paragraph{Status.} Verified for the calibration $N=13$, $r=1.5$, $\alpha=0.19$, $\beta=0.9$.

For this calibration, $q=7$ and
\[
\lambda_M^E=0.220355029586.
\]
The verified weak-proposer regimes are:
\[
A \text{ on } [0,0.031188),\qquad
C \text{ on } (0.031188,0.301717],\qquad
A \text{ on } (0.301717,1].
\]
When $W$ proposes, $H$ receives
\[
H_A(\mu)=(1-\mu)h_A+\mu h_C
\]
on the aggressive branch and
\[
H_C(\mu)=h_C
\]
on the conservative branch, where
\[
h_A=0.306000,\qquad h_C=0.340615.
\]

Define the lower-bound unanimity payoff:
\[
U_{LB}(\mu)=\frac{1}{N}L_H(\mu)+\frac{N-1}{N}H_W(\mu),
\]
where $H_W(\mu)=H_A(\mu)$ on the aggressive intervals and $H_W(\mu)=H_C(\mu)$ on the conservative interval. Majority is:
\[
M(\mu)=\lambda_M^E V_e(\mu).
\]
On each interval, $U_{LB}(\mu)-M(\mu)$ is affine, so endpoint checks suffice. The endpoint gaps are:
\[
U_{LB}(0)-M(0)=0.079574,
\]
\[
U_{LB}(0.031188)-M(0.031188)=0.077767,
\]
\[
U_{LB}(0.301717)-M(0.301717)=0.062089,
\]
\[
U_{LB}(1)-M(1)=0.021621.
\]
All are positive. Hence the lower bound on unanimity exceeds the corrected majority payoff for every $\mu\in[0,1]$ in this calibration. This is a calibrated/parametric result, not a general theorem.

## B.5 Sufficient condition for conditional dominance {-}

\paragraph{Status.} Verified as a sufficient-conditions result. The old sharp global theorem remains superseded, but the following condition is enough to establish conditional payoff dominance using only the corrected majority payoff, strict BF feasibility, and the selection-free H-proposer lower bound.

Let $m\equiv N-1$ and define:
\[
A_0=1+m\alpha,\qquad A_1=1+m\alpha r,\qquad
\lambda_M^E=\frac{NA_0-\beta(q-1)}{N^2}.
\]
Suppose:
\begin{equation}\label{eq:suff_beta_window}
\max\left\{
\frac{NA_0}{A_0+mA_1+q-1},
\frac{Nm\alpha}{q-1+Nm\alpha}
\right\}
<\beta<
\frac{N}{N+m\alpha(r-1)}.
\end{equation}
Then the lower bound on the hegemon's R1 payoff under unanimity exceeds the corrected majority payoff for every $\mu\in[0,1]$:
\[
\underline U_H(\mu)> \lambda_M^E V_e(\mu).
\]

\paragraph{Proof.} The upper bound in \eqref{eq:suff_beta_window} is equivalent to:
\[
h_A+m y_A<1,
\]
where $h_A=\beta A_1/N$ and $y_A=\beta(1-\alpha)/N$. Hence the aggressive weak-proposer offer is feasible, since its actual feasibility requirement is $h_A+(N-2)y_A\le 1$.

The same condition implies that aggressive play weakly dominates deliberate rejection for the weak proposer. For $\mu\le\mu_s^{R2}$:
\[
A(\mu)-R(\mu)
=(1-\mu)(1-h_A-my_A)+\mu r y_A>0.
\]
For $\mu\ge\mu_s^{R2}$, $A(\mu)-R(\mu)$ is affine, is positive at $\mu_s^{R2}$, and equals zero at $\mu=1$. Thus deliberate rejection is not strictly optimal except at the terminal tie, where it gives $H$ the same payoff as aggressive play.

If the conservative offer is chosen, $H$ receives $h_C=\beta rA_0/N$, which is weakly above its aggressive-branch expected payoff:
\[
H_A^W(\mu)=(1-\mu)h_A+\mu h_C
=\frac{\beta[A_1+\mu(r-1)]}{N},
\]
because $h_C-h_A=\beta(r-1)/N>0$. Therefore every optimal weak-proposer branch gives $H$ at least $H_A^W(\mu)$.

Combining this weak-proposer lower bound with the H-proposer lower bound from Appendix B.3 gives:
\[
\underline U_H(\mu)
=\frac{1}{N}L_H(\mu)
+\frac{m}{N}\frac{\beta[A_1+\mu(r-1)]}{N}.
\]
The difference
\[
D(\mu)\equiv \underline U_H(\mu)-\lambda_M^E V_e(\mu)
\]
is affine in $\mu$. At the endpoints:
\[
D(0)=
\frac{\beta(A_0+mA_1+q-1)-NA_0}{N^2},
\]
and
\[
D(1)=
\frac{r[\beta(q-1)-Nm\alpha(1-\beta)]}{N^2}.
\]
The two lower bounds in \eqref{eq:suff_beta_window} are exactly the conditions $D(0)>0$ and $D(1)>0$. Since $D$ is affine, $D(\mu)>0$ for every $\mu\in[0,1]$. $\square$

For the calibration $N=13$, $r=1.5$, $\alpha=0.19$, $\beta=0.9$, $q=7$:
\[
\max\{0.6842105,\ 0.8316498\}<0.9<0.9193777.
\]
Thus the sufficient condition holds. The endpoint gaps are $D(0)=0.079574$ and $D(1)=0.021621$.

## B.6 Calibrated formation-set nesting {-}

\paragraph{Status.} Verified for the calibration $N=13$, $r=1.5$, $\alpha=0.19$, $\beta=0.9$. A general proof of $\mathcal F_U\subseteq\mathcal F_M$ remains pending because the H-proposer payoff correspondence outside the accepted-pooling region has not been fully characterized.

The corrected majority payoff for a representative weak state is:
\[
V_W^{R1}(\mu,M)=\kappa_M^E V_e(\mu),
\qquad
\kappa_M^E
=\frac{N(N-1)+\beta(q-1)}{N^2(N-1)}.
\]
To bound weak-state payoffs under unanimity without selecting an H-proposer equilibrium, use the H lower bound $L_H(\mu)$ from Appendix B.3. Conditional on $H$ proposing, the representative weak-state payoff is bounded above by:
\[
\overline V_W^{Hprop}(\mu)=\frac{V_e(\mu)-L_H(\mu)}{N-1}.
\]
Conditional on a weak state proposing, define the aggregate weak-state payoff under branch $b\in\{A,C,R\}$ as:
\[
\Omega_A(\mu)=(1-\mu)(1-h_A)+\mu(N-1)\beta W_2(1),
\]
\[
\Omega_C(\mu)=V_e(\mu)-h_C,
\]
\[
\Omega_R(\mu)=(N-1)\beta W_2(\mu).
\]
Therefore:
\[
\overline V_W^{U}(\mu;b)=
\frac{V_e(\mu)-L_H(\mu)}{N(N-1)}
+\frac{\Omega_b(\mu)}{N}
\]
is a selection-free upper bound on the representative weak-state payoff under unanimity for branch $b$.

For the calibration, $\kappa_M^E=0.0795858$. The verified weak-proposer regimes are $A$ on $[0,0.031188]$, $C$ on $[0.031188,0.301717]$, and $A$ on $[0.301717,1]$, with $A$ and $R$ tied at $\mu=1$. On the relevant branch intervals, the smallest gaps
\[
V_W^{R1}(\mu,M)-\overline V_W^U(\mu;b)
\]
are:
\[
\begin{array}{ll}
A\text{ on }[0,0.031188]: & 0.021247,\\
C\text{ on }[0.031188,0.301717]: & 0.023854,\\
A\text{ on }[0.301717,1]: & 0.025476,\\
R\text{ tie/check}: & 0.022868.
\end{array}
\]
All are strictly positive. Hence, for this calibration:
\[
V_W^{R1}(\mu,M)>V_W^{R1}(\mu,U)
\quad\text{for every }\mu\in[0,1],
\]
and therefore $\mathcal F_U\subseteq\mathcal F_M$ for every entry cost $c$.

## B.7 Pending: global maximum of weak-state payoff under unanimity {-}

\paragraph{Status.} Pending. The old lemma used the old aggressive and conservative R1 payoff branches and the old H-proposer formula. It must be rechecked using the corrected weak-proposer regime $A/C/R$ and the H-proposer branch or a valid bound for weak-state payoffs.

## B.8 Calibrated institutional classification {-}

\paragraph{Status.} Verified for the calibration $N=13$, $r=1.5$, $\alpha=0.19$, $\beta=0.9$. The general institutional classification remains pending.

For the calibration, Appendix B.4 establishes conditional dominance of unanimity over majority for $H$ using the selection-free lower bound. Appendix B.6 establishes $\mathcal F_U\subseteq\mathcal F_M$. Finally,
\[
\lambda_M^E=0.220355>0.19=\alpha,
\]
equivalently:
\[
\alpha<1-\frac{\beta(q-1)}{N}.
\]
Therefore, for any entry cost $c$, the calibrated institutional comparison is:

1. If $\mu\in\mathcal F_U$, both institutions form and $U\succ M$ for $H$.
2. If $\mu\in\mathcal F_M\setminus\mathcal F_U$, only majority forms and $M\succ U$ for $H$.
3. If $\mu\notin\mathcal F_M$, neither institution forms and $U\sim M$.

This calibrated classification should not be generalized without either a general proof of formation-set nesting or an explicit condition that rules out the case in which unanimity forms but majority does not.


