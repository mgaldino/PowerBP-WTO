# H-Proposer Signaling Subgame: Characterization Outside Accepted Pooling

Based on the appendix excerpt, I would state the result this way: the H-proposer branch is **not a unique payoff function outside accepted pooling**. Under standard pivotal BF voting, **no pure-strategy PBE exists outside the maximal accepted-pooling region**. With receiver mixing at acceptance cutoffs, mixed/semi-pooling PBE can exist, but their payoffs are **selection-dependent** on weak-state tie-breaking and off-path beliefs.

## 1. Core notation

Let \(m=N-1\), \(v_0=1\), \(v_1=r\), and

\[
A_0=1+m\alpha,\qquad A_1=1+m\alpha r.
\]

For posterior \(q\), define the weak-state R2 value

\[
W_2(q)=\frac{1}{N}
\max\{(1-q)(1-\alpha),\,1+q(r-1)-\alpha r\}.
\]

The R2 screening cutoff is

\[
q_s=\frac{\alpha(r-1)}{r-\alpha}.
\]

In the H-proposer R1 subgame, weak states accept a proposal only if each receives at least

\[
w(q)=\beta W_2(q).
\]

Let total minimal acceptance cost be

\[
C(q)=m\beta W_2(q).
\]

Important endpoint costs:

\[
C_0=C(0)=\frac{m\beta(1-\alpha)}{N},
\qquad
C_1=C(1)=\frac{m\beta r(1-\alpha)}{N}.
\]

If a proposal is rejected, H's discounted R2 payoffs are

\[
B_1=\frac{\beta rA_0}{N}
\]

for the high type, and

\[
B_0^A=\frac{\beta A_0}{N},
\qquad
B_0^C=\frac{\beta A_1}{N}
\]

for the low type, depending on whether R2 weak proposers play aggressive or conservative.

The high type can always guarantee

\[
P_1=r-C_1
=
r-\frac{m\beta r(1-\alpha)}{N}.
\]

The low type can guarantee at least

\[
\ell_0
=
\max\left\{
1-C_1,\,
\min\{1-C_0,\,B_0^C\}
\right\}.
\]

So a selection-free lower bound on the H-proposer branch is

\[
\underline H^{prop}(\mu)
=
(1-\mu)\ell_0+\mu P_1.
\]

This sharpens the appendix lower bound, which used only \(B_0^A\) for the low type.

## 2. Pure-strategy PBE

### Accepted pooling

A pure accepted-pooling PBE exists iff

\[
C(\mu)\le 1-\ell_0.
\]

If this holds, both H types can make the same accepted proposal. With total transfer \(T\),

\[
C(\mu)\le T\le 1-\ell_0,
\]

the type payoffs are

\[
u_0=1-T,\qquad u_1=r-T.
\]

The old pooling formula corresponds to the **minimal-transfer selection**

\[
T=C(\mu),
\]

giving

\[
u_\theta=v_\theta-C(\mu).
\]

But this is a selected payoff, not the full pooling correspondence.

### Both types accepted with different proposals

A separating accepted PBE exists iff

\[
C_1+B_0^C\le 1.
\]

Equivalently,

\[
\beta\le \frac{N}{1+(N-1)r}.
\]

In such an equilibrium, the high type must pay exactly \(C_1\), so

\[
u_1=P_1.
\]

The low type must burn enough surplus to deter high-type mimicry. Its total transfer \(T_0\) must satisfy

\[
C_1\le T_0\le 1-\max\{B_0^C,\,1-C_1\}.
\]

This separating case can only exist in a parameter region where accepted pooling also exists for all \(\mu\). Hence it never rescues the game outside the accepted-pooling region.

### High accepted, low rejected

No pure-strategy PBE.

The low type rejected at posterior \(0\) receives only \(B_0^A\), but it can profitably deviate to a low-threshold offer, or, if feasible, to the high-threshold offer. Thus low rejection is not incentive compatible.

### Low accepted, high rejected

No pure-strategy PBE.

The high type rejected receives \(B_1\), but it can always offer each weak state approximately \(\beta W_2(1)\), guaranteeing payoff arbitrarily close to

\[
P_1=r-C_1>B_1.
\]

### Both rejected

No pure-strategy PBE, by the same argument. The high type can always force near-certain acceptance at cost \(C_1\), and the low type can also improve over rejection.

## 3. Main pure-strategy conclusion

Let

\[
\mathcal P_H
=
\{\mu:C(\mu)\le 1-\ell_0\}.
\]

Then:

\[
\boxed{
\text{Outside } \mathcal P_H,\text{ there is no pure-strategy PBE.}
}
\]

Thus the H-proposer payoff outside accepted pooling is not a pure-strategy value function.

## 4. Mixed PBE and payoff selection

With receiver mixing, a proposal at posterior \(q\) and total transfer \(C(q)\) can be accepted with probability \(\rho\in[0,1]\) when weak states are exactly indifferent.

The induced type payoffs are

\[
u_0(q,\rho)
=
\rho[1-C(q)]
+
(1-\rho)D_0(q),
\]

\[
u_1(q,\rho)
=
\rho[r-C(q)]
+
(1-\rho)B_1,
\]

where

\[
D_0(q)=
\begin{cases}
B_0^A, & q<q_s,\\
B_0^C, & q>q_s,
\end{cases}
\]

with a tie-breaking convention needed at \(q=q_s\).

This produces a payoff correspondence, not a function. A canonical semi-pooling construction outside pure pooling is:

1. Low type uses a common proposal with posterior \(q\in[q_s,1)\).
2. High type mixes between that common proposal and a high-only proposal with posterior \(1\).
3. Weak states mix acceptance at the common proposal so that the high type is indifferent:

\[
\rho(q)
=
\frac{P_1-B_1}{r-C(q)-B_1}.
\]

The low-type payoff on the common proposal is

\[
u_0(q)
=
B_0^C
+
\rho(q)\bigl[1-C(q)-B_0^C\bigr].
\]

This is incentive compatible for the low type only when

\[
1-C(q)\ge B_0^C.
\]

Hence mixed outside-pooling equilibria require, at minimum,

\[
\min_q C(q)\le 1-B_0^C.
\]

When this condition holds, there is generally a continuum of mixed/semi-pooling payoffs indexed by \(q\) and \(\rho(q)\). When it fails, the canonical mixed construction breaks down; a closed-form global mixed-PBE characterization would require an explicit selection rule for off-path beliefs and weak-state tie-breaking.

## 5. Paper-ready statements

The following can be turned directly into lemmas/propositions:

**Lemma 1 — Acceptance threshold.**  
Given posterior \(q\), each weak state accepts iff its transfer is at least \(\beta W_2(q)\), up to tie-breaking.

**Lemma 2 — Robust deviation bounds.**  
Every PBE must give the high type at least \(P_1=r-C_1\) and the low type at least \(\ell_0\).

**Proposition 1 — Pure PBE classification.**  
Pure PBE are either accepted pooling or accepted separating. All rejected-type configurations fail.

**Corollary — No pure PBE outside pooling.**  
If \(C(\mu)>1-\ell_0\), no pure-strategy PBE exists.

**Proposition 2 — Selection dependence.**  
With receiver mixing, H-proposer payoffs form a correspondence indexed by weak-state mixing probabilities and off-path beliefs. Therefore the outside-pooling payoff is not unique without an equilibrium refinement or selection rule.

## 6. Refinement flags

The unresolved pieces are not algebraic; they are selection issues:

1. **Weak-state tie-breaking at equality** determines \(\rho\).
2. **R2 tie-breaking at \(q_s\)** determines whether the low type receives \(B_0^A\), \(B_0^C\), or a mixture.
3. **Off-path beliefs** determine whether low-threshold deviations are punished by high posterior beliefs or accepted under low posterior beliefs.
4. **Cho-Kreps/D1** would likely eliminate many pooling-overpayment and low-burning separating equilibria, because high types often have at least as strong an incentive to mimic cheaper accepted offers.

So the correct conclusion is:

\[
\boxed{
\text{Outside accepted pooling, H's payoff is selection-dependent; it is not a unique equilibrium payoff function.}
}
\]
