# Lemma X — proof that \(V_W^{R1}(1,U)\) is the global maximum

## Statement

**Lemma X.** Fix \(N\geq 3\), \(r>1\), \(\beta\in(0,1)\), and \(\alpha\in(0,1/r)\). Under unanimity,
\[
V_W^{R1}(\mu,U)\leq V_W^{R1}(1,U)=\frac{r(1-\beta\alpha)}{N}
\qquad\text{for every }\mu\in(0,1].
\]
The inequality is strict for every \(\mu<1\). Hence \(V_W^{R1}(1,U)\) is the unique global maximum of \(V_W^{R1}(\mu,U)\) on \((0,1]\).

**Corollary.** If
\[
E_U\equiv\{\mu\in(0,1]:V_W^{R1}(\mu,U)\geq c\}\neq\emptyset,
\]
then \(1\in E_U\).

---

## Proof

Let
\[
V_e(\mu)=1+\mu(r-1),
\qquad
x=(N-1)\alpha r,
\qquad
\mu_2\equiv\mu_s^{R2}=\frac{\alpha(r-1)}{r-\alpha}.
\]
Because \(r>1\) and \(\alpha\in(0,1/r)\), we have \(0<\mu_2<1\). The second-round weak-state continuation payoff is
\[
W_2^L(\mu)=\frac{(1-\mu)(1-\alpha)}{N}
\qquad\text{for }\mu<\mu_2,
\]
and
\[
W_2^H(\mu)=\frac{V_e(\mu)-\alpha r}{N}
\qquad\text{for }\mu\geq\mu_2.
\]
At \(\mu=1\), the R1 offer is conservative and the weak-state payoff is
\[
\bar V_W\equiv V_W^{R1}(1,U)=\frac{r(1-\beta\alpha)}{N}.
\]

The proof proceeds by bounding every feasible R1 payoff candidate by \(\bar V_W\). This avoids using the R1 cutoff directly. In particular, the argument does not depend on whether \(\mu_s^{R1}\) lies above or below \(\mu_s^{R2}\).

At any \(\mu\), the R1 unanimity problem has two possible offer types: conservative and aggressive. Each can be evaluated using either the low or high R2 continuation branch, depending on whether \(\mu<\mu_2\) or \(\mu\geq\mu_2\). Thus there are four payoff candidates. If each candidate is weakly below \(\bar V_W\), then the equilibrium payoff, which selects between the aggressive and conservative R1 offer payoffs, is also weakly below \(\bar V_W\).

### 1. Conservative R1 offer with high R2 continuation

For \(\mu\geq\mu_2\), the conservative R1 payoff is
\[
V_W^{CH}(\mu)
=\frac{1}{N}\left[V_e(\mu)-\frac{\beta(r+x)}{N}-(N-2)\beta W_2^H(\mu)\right]
+\frac{N-1}{N}\beta W_2^H(\mu).
\]
Substituting \(W_2^H(\mu)=[V_e(\mu)-\alpha r]/N\) gives the closed form
\[
V_W^{CH}(\mu)
=\frac{(N+\beta)V_e(\mu)-\beta r(1+N\alpha)}{N^2}.
\]
Therefore
\[
\bar V_W-V_W^{CH}(\mu)
=\frac{(N+\beta)(r-1)(1-\mu)}{N^2}\geq 0.
\]
Equality in this branch occurs only at \(\mu=1\).

### 2. Aggressive R1 offer with high R2 continuation

For \(\mu\geq\mu_2\), the aggressive R1 proposer payoff is
\[
F_1^{A,H}(\mu)
=(1-\mu)\left[1-\frac{\beta(1+x)}{N}-(N-2)\beta W_2^H(\mu)\right]
+\mu\frac{\beta r(1-\alpha)}{N}.
\]
If a weak state is not the proposer, its payoff is
\[
\frac{\beta W_2^H(\mu)}{N}
+\frac{N-2}{N}\left[(1-\mu)\beta W_2^H(\mu)
+\mu\frac{\beta r(1-\alpha)}{N}\right].
\]
Hence
\[
V_W^{AH}(\mu)
=\frac{F_1^{A,H}(\mu)}{N}
+\frac{\beta W_2^H(\mu)}{N}
+\frac{N-2}{N}\left[(1-\mu)\beta W_2^H(\mu)
+\mu\frac{\beta r(1-\alpha)}{N}\right].
\]
Substituting \(W_2^H(\mu)=[V_e(\mu)-\alpha r]/N\), the terms involving \((1-\mu)\beta W_2^H(\mu)\) cancel between the proposer and non-proposer components. After simplification,
\[
\bar V_W-V_W^{AH}(\mu)
=\frac{(1-\mu)(r-1)+\mu r(1-\beta)}{N}>0.
\]
The inequality is strict for every \(\mu\in[0,1]\), since \(r>1\), \(\beta<1\), and at least one of \(1-\mu\) and \(\mu\) is positive.

### 3. Conservative R1 offer with low R2 continuation

This case is relevant only when a conservative R1 offer is evaluated while \(\mu<\mu_2\), but the following bound is valid throughout the entire low-R2 interval. Using \(W_2^L(\mu)=(1-\mu)(1-\alpha)/N\),
\[
V_W^{CL}(\mu)
=\frac{1}{N}\left[V_e(\mu)-\frac{\beta(r+x)}{N}-(N-2)\beta W_2^L(\mu)\right]
+\frac{N-1}{N}\beta W_2^L(\mu).
\]
Equivalently,
\[
V_W^{CL}(\mu)
=\frac{V_e(\mu)}{N}-\frac{\beta(r+x)}{N^2}
+\frac{\beta(1-\mu)(1-\alpha)}{N^2}.
\]
Thus
\[
\bar V_W-V_W^{CL}(\mu)
=\frac{(r-1)(N-\alpha\beta+\beta)+\mu\{N(1-r)-\alpha\beta+\beta\}}{N^2}.
\]
This expression is affine in \(\mu\). Therefore, on \([0,\mu_2]\), its minimum is attained at one of the endpoints. At \(\mu=0\),
\[
\bar V_W-V_W^{CL}(0)
=\frac{(r-1)(N-\alpha\beta+\beta)}{N^2}>0,
\]
because \(N\geq3\) and \(\alpha\beta<1\). At \(\mu=\mu_2=\alpha(r-1)/(r-\alpha)\),
\[
\bar V_W-V_W^{CL}(\mu_2)
=\frac{r(r-1)(1-\alpha)(N+\beta)}{N^2(r-\alpha)}>0.
\]
Hence
\[
\bar V_W-V_W^{CL}(\mu)>0
\qquad\text{for every }\mu\in[0,\mu_2].
\]

### 4. Aggressive R1 offer with low R2 continuation

Finally, suppose \(\mu<\mu_2\) and the R1 offer is aggressive. The aggressive proposer payoff is
\[
F_1^{A,L}(\mu)
=(1-\mu)\left[1-\frac{\beta(1+x)}{N}-(N-2)\beta W_2^L(\mu)\right]
+\mu\frac{\beta r(1-\alpha)}{N}.
\]
The weak-state payoff is
\[
V_W^{AL}(\mu)
=\frac{F_1^{A,L}(\mu)}{N}
+\frac{\beta W_2^L(\mu)}{N}
+\frac{N-2}{N}\left[(1-\mu)\beta W_2^L(\mu)
+\mu\frac{\beta r(1-\alpha)}{N}\right].
\]
Again, the terms involving \((1-\mu)\beta W_2^L(\mu)\) cancel between the proposer and non-proposer components. Substituting \(W_2^L(\mu)=(1-\mu)(1-\alpha)/N\) gives
\[
\bar V_W-V_W^{AL}(\mu)
=\frac{(r-1)(N-\alpha\beta)+\mu\{N(1-\beta r)+\beta r-\alpha\beta\}}{N^2}.
\]
This expression is affine in \(\mu\). On \([0,\mu_2]\), it is therefore enough to check the two endpoints. At \(\mu=0\),
\[
\bar V_W-V_W^{AL}(0)
=\frac{(r-1)(N-\alpha\beta)}{N^2}>0,
\]
since \(\alpha\beta<1<N\). At \(\mu=\mu_2\),
\[
\bar V_W-V_W^{AL}(\mu_2)
=\frac{r(r-1)(1-\alpha\beta)}{N(r-\alpha)}>0,
\]
because \(\alpha<1/r\) implies \(\alpha\beta<1\), and \(r-\alpha>0\). Hence
\[
\bar V_W-V_W^{AL}(\mu)>0
\qquad\text{for every }\mu\in[0,\mu_2].
\]

### 5. Global maximum

For every \(\mu\in(0,1]\), the weak-state R1 payoff under unanimity is one of the four candidates above: \(V_W^{CH}\), \(V_W^{AH}\), \(V_W^{CL}\), or \(V_W^{AL}\), depending on the R2 continuation branch and on whether the equilibrium R1 offer is conservative or aggressive. We have shown that every such candidate is weakly below
\[
\bar V_W=V_W^{R1}(1,U)=\frac{r(1-\beta\alpha)}{N}.
\]
Moreover, equality can occur only in the conservative/high branch at \(\mu=1\). Therefore,
\[
V_W^{R1}(\mu,U)<V_W^{R1}(1,U)
\qquad\text{for every }\mu<1,
\]
and
\[
V_W^{R1}(1,U)=\max_{\mu\in(0,1]}V_W^{R1}(\mu,U).
\]
This proves Lemma X.

For the corollary, suppose \(E_U\neq\emptyset\). Then there exists \(\mu'\in(0,1]\) such that
\[
V_W^{R1}(\mu',U)\geq c.
\]
By Lemma X,
\[
V_W^{R1}(1,U)\geq V_W^{R1}(\mu',U)\geq c.
\]
Hence \(1\in E_U\). \(\square\)

---

## Notes for insertion in the appendix

1. This proof is fully analytical. No numerical verification is used.
2. The proof does not require a separate case distinction for \(\mu_s^{R1}>\mu_s^{R2}\) versus \(\mu_s^{R1}\leq\mu_s^{R2}\).
3. The proof does not use slopes of \(V_H\), the budget identity, or the discontinuity in \(V_H\) at \(\mu_s^{R1}\). It establishes the stronger statement directly: every R1 weak-state payoff candidate is bounded above by \(V_W^{R1}(1,U)\).
4. For journal submission, the numerical diagnostics should not be included as part of the proof. They can remain in replication files or an internal validation note.
