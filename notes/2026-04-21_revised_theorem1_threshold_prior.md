# Revised Theorem 1: Threshold Prior for Institutional Choice

**Date**: 2026-04-21
**Status**: VERIFIED (proof correct, minor issues fixed 2026-04-21)

---

## Revised Theorem 1: Threshold Prior for Institutional Choice

The next result replaces Theorem 1 with a sharper characterization of the comparison between unanimity and majority under Bayesian persuasion. The result is **conditional on Lemma 1**: whenever entry occurs under both rules, unanimity gives the hegemon a strictly higher conditional-on-entry continuation payoff.

Let
$$q=\lfloor N/2\rfloor+1, \qquad V_e(\mu)=1+\mu(r-1),$$
and define
$$\lambda_M \equiv \frac{N[1+(N-1)\alpha]-\beta(q-1)(1-\alpha)}{N^2}.$$
Under majority, for beliefs $\mu$ such that entry occurs,
$$v(\mu,M)=\lambda_M V_e(\mu).$$
Let
$$\kappa_M \equiv \frac{(1-\alpha)\bigl[N(N-1)+\beta(q-1)\bigr]}{N^2(N-1)}, \qquad \tau(M)=\max\left\{0,\frac{c/\kappa_M-1}{r-1}\right\}.$$
If $\tau(M)>0$, define
$$S_M \equiv \frac{v(\tau(M),M)}{\tau(M)}.$$

Under unanimity, let $\tau(U) \in (0,1)$ denote the entry threshold (assuming the institution can form for some beliefs) and define
$$S_U \equiv \max_{\mu\ge \tau(U)} \frac{v(\mu,U)}{\mu}.$$
Because $v(\mu,U)=0$ for $\mu<\tau(U)$, this is the maximal slope of a line through the origin that majorizes the unanimity value function and touches it at some posterior $\mu_U^*\ge \tau(U)$.

### Theorem 1 (Threshold prior for institutional choice)

Suppose Lemma 1 holds, so that
$$v(\mu,U)>v(\mu,M) \qquad \text{for all } \mu\in(0,1) \text{ whenever entry occurs under both rules.}$$
Then the comparison between
$$\operatorname{cav}v(p,U) \quad\text{and}\quad \operatorname{cav}v(p,M)$$
has the following structure.

#### (a) If $\tau(U)=0$

Then unanimity strictly dominates majority for every prior $p\in(0,1)$:
$$\operatorname{cav}v(p,U)>\operatorname{cav}v(p,M).$$
Equivalently, $p^*=0$.

#### (b) If $\tau(M)=0<\tau(U)$

There exists a unique threshold
$$p^* = \frac{\lambda_M}{\,S_U-\lambda_M(r-1)\,} \in(0,\tau(U)),$$
such that
$$p<p^* \;\Rightarrow\; \operatorname{cav}v(p,M)>\operatorname{cav}v(p,U),$$
$$p>p^* \;\Rightarrow\; \operatorname{cav}v(p,U)>\operatorname{cav}v(p,M).$$

#### (c) If $0<\tau(M)\le\tau(U)$ and $S_U>S_M$

Then unanimity strictly dominates majority for every prior $p\in(0,1)$:
$$\operatorname{cav}v(p,U)>\operatorname{cav}v(p,M).$$
Equivalently, $p^*=0$.

#### (d) If $0<\tau(M)\le\tau(U)$ and $S_U\le S_M$

There exists a unique threshold
$$p^* = \frac{\lambda_M}{\,S_U-\lambda_M(r-1)\,} \in[\tau(M),\tau(U)],$$
such that
$$p<p^* \;\Rightarrow\; \operatorname{cav}v(p,M)\ge \operatorname{cav}v(p,U),$$
$$p>p^* \;\Rightarrow\; \operatorname{cav}v(p,U)>\operatorname{cav}v(p,M).$$

In particular, the institutional comparison has the **single-crossing property**: there is at most one prior at which the ranking changes.

### Proof

We proceed in steps.

#### Step 1: High priors $p\ge \tau(U)$

If $p\ge \tau(U)$, then entry occurs under unanimity and, since entry is weakly easier under majority, also under majority. By Lemma 1,
$$v(p,U)>v(p,M).$$
Under majority, $v(\mu,M)$ is affine for $\mu\ge \tau(M)$, hence already concave there, so
$$\operatorname{cav}v(p,M)=v(p,M).$$
Under unanimity,
$$\operatorname{cav}v(p,U)\ge v(p,U).$$
Therefore
$$\operatorname{cav}v(p,U)\ge v(p,U)>v(p,M)=\operatorname{cav}v(p,M)$$
for all $p\ge \tau(U)$.

This proves part (a) immediately when $\tau(U)=0$.

#### Step 2: Concavification below the unanimity entry threshold

Assume now that $\tau(U)>0$.

Because $v(\mu,U)=0$ for $\mu<\tau(U)$, and because
$$S_U=\max_{\mu\ge \tau(U)}\frac{v(\mu,U)}{\mu},$$
we have
$$v(\mu,U)\le S_U \mu \qquad\text{for all }\mu\in[0,1].$$
Let $\mu_U^*\ge \tau(U)$ be a maximizer, so that
$$v(\mu_U^*,U)=S_U\mu_U^*.$$
Hence the line $L_U(p)=S_U p$ majorizes $v(\cdot,U)$ everywhere and touches it at $\mu_U^*$.

Since $v(0,U)=0$, any concave majorant $g$ of $v(\cdot,U)$ must satisfy
$$g(0)\ge 0, \qquad g(\mu_U^*)\ge v(\mu_U^*,U)=S_U\mu_U^*.$$
By concavity, for every $p\in[0,\mu_U^*]$,
$$g(p)\ge \frac{p}{\mu_U^*}g(\mu_U^*)+\left(1-\frac{p}{\mu_U^*}\right)g(0)\ge S_U p.$$
But $L_U(p)=S_U p$ is itself a feasible concave majorant. Therefore
$$\operatorname{cav}v(p,U)=S_U p \qquad\text{for all } p\in[0,\mu_U^*].$$
Since $\mu_U^*\ge \tau(U)$, it follows in particular that
$$\operatorname{cav}v(p,U)=S_U p \qquad\text{for all } p\in[0,\tau(U)].$$

Under majority, two cases arise.

If $\tau(M)=0$, then entry always occurs and
$$\operatorname{cav}v(p,M)=v(p,M)=\lambda_M V_e(p) =\lambda_M+\lambda_M(r-1)p.$$

If $\tau(M)>0$, then $v(\mu,M)=0$ below $\tau(M)$ and affine above it. Because the affine branch has positive intercept, the ratio $v(\mu,M)/\mu$ is strictly decreasing on $[\tau(M),1]$. Hence the optimal line from the origin touches at $\tau(M)$, and
$$\operatorname{cav}v(p,M)=S_M p \qquad\text{for } p<\tau(M),$$
while
$$\operatorname{cav}v(p,M)=v(p,M)=\lambda_M V_e(p) \qquad\text{for } p\ge \tau(M).$$

#### Step 3: Case $\tau(M)=0<\tau(U)$

For $p\in(0,\tau(U))$, Step 2 gives
$$\operatorname{cav}v(p,U)=S_U p, \qquad \operatorname{cav}v(p,M)=\lambda_M+\lambda_M(r-1)p.$$
Thus the difference is
$$D(p)\equiv \operatorname{cav}v(p,U)-\operatorname{cav}v(p,M) = \bigl[S_U-\lambda_M(r-1)\bigr]p-\lambda_M.$$
At $p=0$,
$$D(0)=-\lambda_M<0.$$
At $p=\tau(U)$,
$$S_U\tau(U)\ge v(\tau(U),U)>v(\tau(U),M)=\lambda_M V_e(\tau(U)),$$
where the strict inequality is from Lemma 1. Hence $D(\tau(U))>0$.

Since $D(p)$ is linear, it crosses zero exactly once, at
$$p^* = \frac{\lambda_M}{\,S_U-\lambda_M(r-1)\,}.$$
Because $D(0)<0$ and $D(\tau(U))>0$, this unique root lies in $(0,\tau(U))$. This proves part (b).

#### Step 4: Case $0<\tau(M)<\tau(U)$ with $S_U>S_M$

First consider $p<\tau(M)$. By Step 2,
$$\operatorname{cav}v(p,U)=S_U p, \qquad \operatorname{cav}v(p,M)=S_M p.$$
Since $S_U>S_M$,
$$\operatorname{cav}v(p,U)>\operatorname{cav}v(p,M) \qquad\text{for all } p\in(0,\tau(M)).$$

Next consider $p\in[\tau(M),\tau(U))$. By Step 2,
$$\operatorname{cav}v(p,U)=S_U p, \qquad \operatorname{cav}v(p,M)=\lambda_M+\lambda_M(r-1)p.$$
So again
$$D(p)=\bigl[S_U-\lambda_M(r-1)\bigr]p-\lambda_M$$
is linear. At $p=\tau(M)$,
$$D(\tau(M))=S_U\tau(M)-S_M\tau(M)>0.$$
At $p=\tau(U)$,
$$D(\tau(U))\ge v(\tau(U),U)-v(\tau(U),M)>0.$$
Hence $D(p)>0$ throughout $[\tau(M),\tau(U))$.

Finally, for $p\ge \tau(U)$, Step 1 gives
$$\operatorname{cav}v(p,U)>\operatorname{cav}v(p,M).$$
Thus unanimity strictly dominates for all $p\in(0,1)$, proving part (c).

#### Step 5: Case $0<\tau(M)<\tau(U)$ with $S_U\le S_M$

For $p<\tau(M)$, Step 2 gives
$$\operatorname{cav}v(p,U)=S_U p\le S_M p=\operatorname{cav}v(p,M).$$

For $p\in[\tau(M),\tau(U))$, as above,
$$D(p)=\bigl[S_U-\lambda_M(r-1)\bigr]p-\lambda_M.$$
At $p=\tau(M)$,
$$D(\tau(M))=S_U\tau(M)-S_M\tau(M)\le 0.$$
At $p=\tau(U)$,
$$D(\tau(U))\ge v(\tau(U),U)-v(\tau(U),M)>0.$$
Since $D(p)$ is linear, it has a unique zero on $[\tau(M),\tau(U)]$, namely
$$p^* = \frac{\lambda_M}{\,S_U-\lambda_M(r-1)\,}.$$
Therefore majority weakly dominates below $p^*$, while unanimity strictly dominates above $p^*$. For $p\ge \tau(U)$, Step 1 again implies strict dominance of unanimity. This proves part (d).

Since each case admits either no crossing or exactly one crossing, the comparison has the single-crossing property. $\square$

### Remark

This theorem is sharper than the original version in two respects.

First, it does not require the low-prior argument to be tied to a particular screening cutoff such as $\mu_s^{R1}$. What matters is the **maximal slope from the origin**, summarized by $S_U$.

Second, it yields a threshold characterization of the institutional comparison:
$$p^* = \frac{\lambda_M}{\,S_U-\lambda_M(r-1)\,}$$
whenever a crossing exists.

The remaining limitation is that the theorem is **conditional on Lemma 1**.

The slope $S_U$ admits a fully closed-form expression. Let $A = (N-(N-1)\beta)/N^2$ and $B = (N-1)\beta r(1+N\alpha)/N^2$. On the post-jump (conservative) R1 branch, $v(\mu,U) = A V_e(\mu) + B$ (affine), so $v(\mu,U)/\mu = (A+B)/\mu + A(r-1)$ is strictly decreasing. The maximizer $\mu_U^* = \max\{\tau(U), \mu_s\}$ and:

- If $\tau(U) \le \mu_s$: $S_U = (A+B)/\mu_s + A(r-1)$, where $\mu_s = (\phi - \sqrt{\phi^2-4(N-2)})/(2(N-2))$.
- If $\tau(U) > \mu_s$: $S_U = (A+B)/\tau(U) + A(r-1)$, where $\tau(U) = (N^2 c - N + \beta(r-1+Nr\alpha))/((N+\beta)(r-1))$.

The case selection is determined by $C_U \ge c$ vs $C_U < c$, where $C_U = ((N+\beta)V_e(\mu_s) - \beta r(1+N\alpha))/N^2$.
