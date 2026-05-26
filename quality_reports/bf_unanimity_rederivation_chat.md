# Rederivação do modelo BF: unanimidade, maioria, sinalização e PBE

## Concise verdict

The old global H-proposer formula under unanimity is **not valid globally**. It is valid only on the accepted-pooling region

\[
p\le \bar p_P\equiv \max\left\{\alpha,\frac{N(1-\beta)}{\beta (N-1)(r-1)}\right\},
\]

truncated at one. Outside that region, the H-proposer R1 subgame has **no payoff-distinct pure-strategy PBE** under the standard BF belief discipline in which the posterior induced by the public proposal governs both the vote and the R2 continuation after rejection. Thus the paper should not use a global closed-form H-proposer payoff.

However, there is a **selection-free lower bound** for the H-proposer branch:

\[
L_H(p)=
(1-p)\frac{\beta A_0}{N}
+p\left[r-(N-1)\beta W_2(1)\right],
\]

where

\[
A_0=1+(N-1)\alpha.
\]

Using this lower bound, the calibration

\[
N=13,\quad r=1.5,\quad \alpha=0.19,\quad \beta=0.9,\quad q=7
\]

still gives unanimity strictly above majority for the hegemon for every \(p\in[0,1]\). The smallest lower-bound gap is at \(p=1\):

\[
U^{LB}_H(1)-M_H(1)
=
0.3521538462-0.3305325444
=
0.0216213018.
\]

So the calibrated substantive claim survives, but the old general theorem and the old global pooling proof do not.

---

# 1. Definitions and notation

Let

\[
m=N-1,\qquad k=N-2,
\]

where \(m\) is the number of weak states and \(k\) is the number of non-proposing weak states when a weak state proposes.

The state is

\[
\theta\in\{0,1\},
\]

with

\[
V(0)=1,\qquad V(1)=r>1.
\]

The prior probability of the high state is

\[
p=\Pr(\theta=1),
\]

and

\[
V_e(p)=1+p(r-1).
\]

The hegemon’s outside option is

\[
\alpha V(\theta),
\]

with

\[
\alpha\in(0,1/r).
\]

Define

\[
A_0=1+m\alpha,
\qquad
A_1=1+m\alpha r.
\]

Under majority rule,

\[
q=\left\lfloor \frac{N}{2}\right\rfloor+1.
\]

The R2 weak-state unanimity payoff is

\[
W_2(p)=\frac{g(p)}{N},
\]

where

\[
g(p)=\max\{(1-p)(1-\alpha),\; V_e(p)-\alpha r\}.
\]

The R2 unanimity screening cutoff is

\[
p_2=\frac{\alpha(r-1)}{r-\alpha}.
\]

Thus

\[
W_2(p)=
\begin{cases}
\dfrac{(1-p)(1-\alpha)}{N}, & p\le p_2,\\[1.2em]
\dfrac{1+p(r-1)-\alpha r}{N}, & p\ge p_2.
\end{cases}
\]

For the H-proposer R1 subgame, define the per-weak acceptance transfer at posterior \(\mu\) as

\[
w(\mu)=\beta W_2(\mu),
\]

and the total transfer needed to secure unanimous weak approval at posterior \(\mu\) as

\[
s(\mu)=m\beta W_2(\mu).
\]

Also define

\[
s_0=s(0)=m\beta\frac{1-\alpha}{N},
\]

and

\[
s_1=s(1)=m\beta\frac{r(1-\alpha)}{N}.
\]

The key fact is:

\[
W_2(\mu)\le W_2(0)
\quad\Longleftrightarrow\quad
\mu\le \alpha.
\]

This \(\alpha\)-cutoff is crucial for the H-proposer signaling game. It is distinct from the R2 screening cutoff \(p_2\).

---

# 2. Verified majority benchmark

Under majority rule, weak proposers can exclude \(H\). The hegemon’s outside option is external and does not reduce the weak coalition’s pie.

The verified R2 majority values are

\[
V_H^{R2}(\theta,M)
=
\frac{[1+m\alpha]V(\theta)}{N}
=
\frac{A_0V(\theta)}{N},
\]

and

\[
V_W^{R2}(p,M)=\frac{V_e(p)}{N}.
\]

The verified R1 majority expected hegemon payoff is

\[
M_H(p)
=
E[V_H^{R1}(p,M)]
=
\lambda_M^E V_e(p),
\]

where

\[
\lambda_M^E
=
\frac{N[1+m\alpha]-\beta(q-1)}{N^2}
=
\frac{NA_0-\beta(q-1)}{N^2}.
\]

The representative weak-state payoff under majority is

\[
V_W^{R1}(p,M)
=
\kappa_M^E V_e(p),
\]

where

\[
\kappa_M^E
=
\frac{N(N-1)+\beta(q-1)}
{N^2(N-1)}.
\]

The collective majority entry set is therefore

\[
F_M
=
\{p:\kappa_M^E V_e(p)\ge c\}.
\]

Equivalently,

\[
F_M=
\left\{
p:
\kappa_M^E[1+p(r-1)]\ge c
\right\}.
\]

---

# 3. Unanimity R2

In R2 under unanimity, a weak proposer chooses between an aggressive offer to \(H\) and a conservative offer to \(H\).

The aggressive offer pays \(H\) its low-state outside option, \(\alpha\), so only the low type accepts. The weak proposer’s expected payoff is

\[
(1-p)(1-\alpha).
\]

The conservative offer pays \(H\) its high-state outside option, \(\alpha r\), so both types accept. The weak proposer’s expected payoff is

\[
V_e(p)-\alpha r.
\]

Hence

\[
W_2(p)=
\frac{
\max\{(1-p)(1-\alpha),\; V_e(p)-\alpha r\}
}{N}.
\]

The equality condition is

\[
(1-p)(1-\alpha)=1+p(r-1)-\alpha r.
\]

Solving gives

\[
p_2=\frac{\alpha(r-1)}{r-\alpha}.
\]

The hegemon’s R2 unanimity payoffs are:

\[
H_2^1(p)=\frac{r[1+m\alpha]}{N}
=
\frac{rA_0}{N},
\]

and

\[
H_2^0(p)=
\begin{cases}
\dfrac{A_0}{N}, & \text{aggressive R2 branch},\\[1.2em]
\dfrac{A_1}{N}, & \text{conservative R2 branch}.
\end{cases}
\]

---

# 4. Unanimity R1 when a weak state proposes

When a weak state proposes in R1, it must buy approval from \(H\) and from the other \(k=N-2\) weak states.

Define

\[
h_C=\frac{\beta rA_0}{N},
\]

\[
h_A=\frac{\beta A_1}{N},
\]

and

\[
y_A=\beta W_2(0)=\frac{\beta(1-\alpha)}{N}.
\]

## 4.1 Conservative offer

A conservative R1 weak proposal pays \(H\)

\[
h_C=\frac{\beta rA_0}{N},
\]

which is enough to make the high type accept. It pays every non-proposing weak state

\[
\beta W_2(p).
\]

The proposing weak state’s payoff is

\[
C(p)=V_e(p)-h_C-k\beta W_2(p).
\]

Strict low-state BF feasibility requires

\[
h_C+k\beta W_2(p)\le 1.
\]

## 4.2 Aggressive offer

An aggressive R1 weak proposal pays \(H\)

\[
h_A=\frac{\beta A_1}{N}.
\]

This makes the low type accept when rejection would be interpreted as the high-type rejection path. The high type rejects because

\[
\frac{\beta rA_0}{N}
>
\frac{\beta A_1}{N},
\]

since

\[
rA_0-A_1=r-1>0.
\]

The non-proposing weak states receive

\[
y_A=\beta W_2(0)=\frac{\beta(1-\alpha)}{N}.
\]

The weak proposer’s payoff is

\[
A(p)
=
(1-p)[1-h_A-ky_A]
+
p\beta W_2(1).
\]

Strict low-state feasibility requires

\[
h_A+ky_A\le 1.
\]

## 4.3 Deliberate rejection

A weak proposer can also induce rejection. Its payoff is

\[
R(p)=\beta W_2(p).
\]

## 4.4 Weak-proposer value

Therefore the R1 weak-proposer payoff under unanimity is

\[
W_1^{prop}(p,U)
=
\max\left\{
A(p)\text{ if feasible},\;
C(p)\text{ if feasible},\;
R(p)
\right\}.
\]

This is not a single global cutoff rule. It is a constrained maximization over feasible aggressive, feasible conservative, and rejection branches.

---

# 5. H-proposer R1 subgame under unanimity

This is the unresolved part of the old proof.

When \(H\) proposes in R1 under unanimity, the proposal itself is a signal of \(H\)’s type. Weak states observe the proposal, form a posterior \(\mu\), and vote. A weak state accepts an offer \(y_i\) iff

\[
y_i\ge \beta W_2(\mu).
\]

Thus, at posterior \(\mu\), the least total transfer that secures unanimous weak approval is

\[
s(\mu)=m\beta W_2(\mu).
\]

Because \(W_2(1)\) is the maximum value of \(W_2(\mu)\),

\[
W_2(\mu)\le W_2(1)
\quad\text{for all }\mu\in[0,1].
\]

Therefore, a high-type \(H\) can always guarantee acceptance by offering every weak state

\[
\beta W_2(1)+\varepsilon.
\]

A low-type \(H\) cannot necessarily do this, because the total transfer may exceed the low-state pie.

---

## Lemma 1. The old pooling proposal is feasible only on a restricted region

The old pooling proposal gives every weak state

\[
\beta W_2(p),
\]

so the total weak transfer is

\[
s(p)=m\beta W_2(p).
\]

The low type’s payoff from accepted pooling is

\[
U_0^P(p)=1-s(p).
\]

The high type’s payoff from accepted pooling is

\[
U_1^P(p)=r-s(p).
\]

Accepted pooling can be a PBE only if the low type has no profitable deviation to a proposal that is either accepted more cheaply or rejected with a favorable posterior.

The relevant cutoff is \(\alpha\), not \(p_2\), because

\[
W_2(\mu)\le W_2(0)
\quad\Longleftrightarrow\quad
\mu\le \alpha.
\]

Therefore, accepted pooling exists iff

\[
p\le \alpha
\]

or, if \(p>\alpha\),

\[
1-s(p)\ge \frac{\beta A_1}{N}.
\]

For \(p>\alpha\), \(W_2(p)\) is on the conservative branch:

\[
W_2(p)=\frac{1+p(r-1)-\alpha r}{N}.
\]

Thus

\[
s(p)
=
m\beta
\frac{1+p(r-1)-\alpha r}{N}.
\]

The pooling condition becomes

\[
1-
m\beta
\frac{1+p(r-1)-\alpha r}{N}
\ge
\frac{\beta A_1}{N}.
\]

Using

\[
A_1=1+m\alpha r,
\]

this simplifies to

\[
N
\ge
\beta[N+mp(r-1)].
\]

Hence

\[
p
\le
p_P
\equiv
\frac{N(1-\beta)}{\beta m(r-1)}.
\]

So the accepted-pooling region is

\[
\boxed{
p\le \bar p_P
\equiv
\max\{\alpha,p_P\}
}
\]

with the obvious truncation at one.

### Proof

If \(p\le\alpha\), then \(W_2(p)\le W_2(0)\). Any cheaper offer can be deterred by beliefs that keep the weak-state acceptance threshold at least as high as the deviating offer. The low type’s worst rejected payoff is then

\[
\frac{\beta A_0}{N}.
\]

Since

\[
s(p)\le s(0)=m\beta\frac{1-\alpha}{N},
\]

we have

\[
s(0)+\frac{\beta A_0}{N}
=
\frac{\beta[m(1-\alpha)+A_0]}{N}
=
\frac{\beta N}{N}
=
\beta.
\]

Therefore

\[
1-s(p)\ge 1-s(0)=1-\beta+\frac{\beta A_0}{N}
\ge
\frac{\beta A_0}{N}.
\]

So pooling is sustainable for all \(p\le\alpha\).

Now suppose \(p>\alpha\). Then \(W_2(p)>W_2(0)\). Consider the off-path proposal that offers every weak state

\[
\beta W_2(0).
\]

If weak states assign posterior \(\mu\le\alpha\), then

\[
W_2(\mu)\le W_2(0),
\]

so the proposal is accepted. To prevent this deviation, beliefs must put \(\mu>\alpha\), in which case the proposal is rejected and the low type receives the conservative R2 continuation

\[
\frac{\beta A_1}{N}.
\]

Therefore accepted pooling requires

\[
1-s(p)\ge \frac{\beta A_1}{N}.
\]

Solving gives

\[
p\le p_P
=
\frac{N(1-\beta)}{\beta m(r-1)}.
\]

The high type’s acceptance constraint is weaker. If

\[
1-s(p)\ge \frac{\beta A_1}{N},
\]

then

\[
r-s(p)\ge \frac{\beta rA_0}{N},
\]

because

\[
\left[r-s(p)-\frac{\beta rA_0}{N}\right]
-
\left[1-s(p)-\frac{\beta A_1}{N}\right]
=
(r-1)\left(1-\frac{\beta}{N}\right)>0.
\]

Thus the low type’s constraint is binding. ∎

---

## Lemma 2. Accepted pooling payoff

On the accepted-pooling region,

\[
p\le \bar p_P,
\]

both types propose

\[
y_i=\beta W_2(p)
\quad
\text{for every weak state }i.
\]

The type-specific H payoffs are

\[
U_0^P(p)=1-m\beta W_2(p),
\]

and

\[
U_1^P(p)=r-m\beta W_2(p).
\]

The ex ante H payoff conditional on being the proposer is

\[
P_H(p)
=
V_e(p)-m\beta W_2(p).
\]

This is the old formula, but only on the accepted-pooling region.

Outside that region, the formula is not justified.

---

## Lemma 3. No payoff-distinct separating PBE with both types accepted

There is no payoff-distinct pure separating PBE in which both H types are accepted with different total transfers.

### Proof

Suppose the low type is accepted with total transfer \(S_0\), and the high type is accepted with total transfer \(S_1\).

The high type can mimic the low type. Since both proposals are accepted, high-type incentive compatibility requires

\[
r-S_1\ge r-S_0,
\]

so

\[
S_1\le S_0.
\]

The low type can mimic the high type whenever the high-type proposal is feasible in the low state. Low-type incentive compatibility then requires

\[
1-S_0\ge 1-S_1,
\]

so

\[
S_0\le S_1.
\]

Therefore

\[
S_0=S_1.
\]

Thus any accepted “separation” must involve the same total transfer. It is payoff-equivalent to pooling and has no screening content.

A knife-edge label-separating equilibrium with different offer vectors but the same total transfer can exist only when the low type can afford the high-posterior acceptance cost,

\[
s_1=m\beta W_2(1)\le 1,
\]

and the low type does not prefer a rejected deviation that induces a conservative posterior:

\[
1-s_1\ge \frac{\beta A_1}{N}.
\]

This condition is equivalent to

\[
\beta\le \frac{N}{1+mr}.
\]

But if this condition holds, then

\[
p_P=\frac{N(1-\beta)}{\beta m(r-1)}\ge 1,
\]

so accepted pooling already exists for all \(p\in[0,1]\). Hence these knife-edge accepted separating equilibria do not extend the equilibrium region beyond pooling. ∎

---

## Lemma 4. No pure PBE with high accepted and low rejected

There is no pure PBE in which the high type is accepted and the low type is rejected.

### Proof

If the high type is accepted at posterior \(1\), the minimum per-weak transfer is

\[
\beta W_2(1).
\]

Since \(W_2(1)\) is the maximum possible weak continuation value, the proposal

\[
y_i=\beta W_2(1)
\]

is accepted under every posterior. Therefore the high type cannot pay more than

\[
s_1=m\beta W_2(1)
\]

in equilibrium. Otherwise it would deviate to the cheaper universally accepted proposal.

Now consider the cheaper proposal

\[
y_i=\beta W_2(0)
\quad\text{for every weak state }i.
\]

If weak states assign posterior \(\mu\le\alpha\), then

\[
W_2(\mu)\le W_2(0),
\]

so the proposal is accepted. The high type would then deviate, because it pays \(s_0<s_1\).

Therefore, to deter the high type, weak states must assign posterior \(\mu>\alpha\) after this cheaper proposal. But then the proposal is rejected and the low type obtains the conservative R2 continuation

\[
\frac{\beta A_1}{N}.
\]

The low type’s on-path payoff from being rejected as the low type is only

\[
\frac{\beta A_0}{N}.
\]

Since

\[
A_1>A_0,
\]

the low type strictly prefers the rejected deviation that induces the high posterior.

Thus the same off-path belief needed to deter the high type creates a profitable deviation for the low type. No such pure PBE exists. ∎

---

## Lemma 5. No pure PBE with low accepted and high rejected

There is no pure PBE in which the low type is accepted and the high type is rejected.

### Proof

Let the low type’s accepted proposal have total transfer \(S_0\). The high type can mimic it and receive

\[
r-S_0.
\]

The high type’s rejected payoff is

\[
\frac{\beta rA_0}{N}.
\]

Thus high-type incentive compatibility requires

\[
S_0\ge r-\frac{\beta rA_0}{N}.
\]

The low type must also prefer acceptance to mimicking the high type’s rejected path. Since the high type’s rejected signal reveals the high type, the low type’s continuation from mimicking that rejected signal is

\[
\frac{\beta A_1}{N}.
\]

Thus low-type incentive compatibility requires

\[
1-S_0\ge \frac{\beta A_1}{N},
\]

or

\[
S_0\le 1-\frac{\beta A_1}{N}.
\]

But

\[
r-\frac{\beta rA_0}{N}
>
1-\frac{\beta A_1}{N},
\]

because

\[
r-\frac{\beta rA_0}{N}
-
\left(1-\frac{\beta A_1}{N}\right)
=
(r-1)\left(1-\frac{\beta}{N}\right)>0.
\]

So the two incentive constraints are mutually inconsistent. ∎

---

## Lemma 6. No pure PBE with both types rejected, for \(\beta<1\)

There is no pure PBE in which both types are rejected, assuming \(\beta<1\).

### Proof

If both types are rejected, the high type receives

\[
\frac{\beta rA_0}{N}.
\]

But the high type can offer every weak state

\[
\beta W_2(1).
\]

This proposal is accepted under every posterior because \(W_2(1)\) is the maximum weak continuation value.

The high type’s payoff from this deviation is

\[
r-s_1
=
r-m\beta W_2(1)
=
r-m\beta\frac{r(1-\alpha)}{N}.
\]

Compare this to the rejected payoff:

\[
r-s_1-\frac{\beta rA_0}{N}
=
r-
\frac{\beta r[m(1-\alpha)+A_0]}{N}.
\]

Since

\[
m(1-\alpha)+A_0
=
m(1-\alpha)+1+m\alpha
=
N,
\]

we get

\[
r-s_1-\frac{\beta rA_0}{N}
=
r-\beta r
=
r(1-\beta)>0.
\]

So the high type strictly deviates. ∎

---

## Proposition 1. Pure-strategy PBE of the H-proposer subgame

Assume \(\beta\in(0,1)\). Under the BF belief discipline described above:

1. **Accepted pooling exists iff**

\[
p\le \bar p_P
=
\max\left\{
\alpha,\frac{N(1-\beta)}{\beta (N-1)(r-1)}
\right\},
\]

with truncation at one.

2. On that region, the H-proposer payoff is

\[
P_H(p)=V_e(p)-(N-1)\beta W_2(p).
\]

3. There is no payoff-distinct pure separating equilibrium with both types accepted.

4. There is no pure PBE with high accepted and low rejected.

5. There is no pure PBE with low accepted and high rejected.

6. There is no pure PBE with both types rejected.

7. Therefore, outside the accepted-pooling region, the H-proposer subgame has no payoff-distinct pure-strategy PBE. A complete global solution requires either mixed strategies or an equilibrium payoff correspondence.

---

# 6. Selection-free lower bound for the H-proposer branch

Even when the pure PBE fails, the hegemon has a simple selection-free payoff guarantee.

## Lemma 7. Low-type guarantee

The low type can offer zero. The proposal is rejected. Whatever posterior follows, the low type’s R2 payoff is at least the aggressive-branch payoff

\[
\frac{\beta A_0}{N}.
\]

Thus the low type guarantees

\[
G_0=\frac{\beta A_0}{N}.
\]

## Lemma 8. High-type guarantee

The high type can offer every weak state

\[
\beta W_2(1)+\varepsilon.
\]

Because

\[
W_2(\mu)\le W_2(1)
\quad
\text{for all }\mu,
\]

this proposal is accepted under every posterior.

Letting \(\varepsilon\downarrow 0\), the high type guarantees

\[
G_1
=
r-m\beta W_2(1).
\]

Since

\[
W_2(1)=\frac{r(1-\alpha)}{N},
\]

this is

\[
G_1
=
r-
m\beta\frac{r(1-\alpha)}{N}.
\]

## Proposition 2. Selection-free H-proposer lower bound

The ex ante lower bound on H’s payoff conditional on H proposing is

\[
\boxed{
L_H(p)
=
(1-p)\frac{\beta A_0}{N}
+
p\left[
r-m\beta W_2(1)
\right].
}
\]

Equivalently,

\[
L_H(p)
=
(1-p)\frac{\beta A_0}{N}
+
p\left[
r-
m\beta\frac{r(1-\alpha)}{N}
\right].
\]

This bound is independent of off-path beliefs, equilibrium selection, and whether the unresolved H-proposer branch is solved in pure or mixed strategies.

---

# 7. Sufficient conditions for unanimity to dominate majority

Let

\[
H_A^W(p)
=
(1-p)\frac{\beta A_1}{N}
+
p\frac{\beta rA_0}{N}
\]

be H’s payoff when a weak proposer uses the aggressive branch.

Let

\[
H_C^W
=
\frac{\beta rA_0}{N}
\]

be H’s payoff when a weak proposer uses the conservative branch.

Let

\[
H_R^W(p)
=
\beta\left[(1-p)H_2^0(p)+pH_2^1(p)\right]
\]

be H’s payoff when a weak proposer induces rejection.

For each \(p\), define the weak-proposer optimal set

\[
\mathcal B(p)
=
\arg\max
\{
A(p)\text{ if feasible},\;
C(p)\text{ if feasible},\;
R(p)
\}.
\]

To make the comparison selection-free, define

\[
J_H(p)
=
\min_{b\in\mathcal B(p)} H_b^W(p).
\]

Then a selection-free lower bound on H’s R1 unanimity payoff is

\[
U_H^{LB}(p)
=
\frac{1}{N}L_H(p)
+
\frac{m}{N}J_H(p).
\]

Majority gives

\[
M_H(p)=\lambda_M^E V_e(p).
\]

Therefore, a sufficient condition for unanimity to dominate majority for the hegemon at belief \(p\) is

\[
\boxed{
U_H^{LB}(p)>\lambda_M^E V_e(p).
}
\]

If this inequality holds on every \(p\) in the relevant entry set, then unanimity dominates majority for \(H\) wherever unanimity forms.

Because \(L_H(p)\), \(H_A^W(p)\), \(H_C^W\), \(H_R^W(p)\), and \(M_H(p)\) are affine on each branch, it is enough to check endpoints of the intervals on which the weak-proposer branch is fixed.

---

# 8. Calibration

Now set

\[
N=13,\quad m=12,\quad k=11,\quad r=1.5,\quad \alpha=0.19,\quad \beta=0.9,\quad q=7.
\]

## 8.1 Basic objects

\[
A_0=1+12(0.19)=3.28.
\]

\[
A_1=1+12(0.19)(1.5)=4.42.
\]

\[
V_e(p)=1+0.5p.
\]

The R2 unanimity cutoff is

\[
p_2
=
\frac{0.19(0.5)}{1.5-0.19}
=
0.07251908397.
\]

## 8.2 Majority

\[
\lambda_M^E
=
\frac{13(3.28)-0.9(6)}{13^2}
=
0.2203550296.
\]

\[
\kappa_M^E
=
\frac{13(12)+0.9(6)}
{13^2(12)}
=
0.0795857988.
\]

Thus

\[
M_H(p)=0.2203550296(1+0.5p).
\]

At \(p=1\),

\[
M_H(1)=0.3305325444.
\]

The condition \(\lambda_M^E>\alpha\) holds because

\[
0.2203550296>0.19.
\]

Equivalently,

\[
\alpha
<
1-\frac{\beta(q-1)}{N}
=
1-\frac{0.9(6)}{13}
=
0.5846153846.
\]

## 8.3 H-proposer pooling threshold

The accepted-pooling cutoff is governed by

\[
p_P=
\frac{N(1-\beta)}
{\beta m(r-1)}.
\]

Substituting values,

\[
p_P
=
\frac{13(0.1)}
{0.9(12)(0.5)}
=
0.2407407407.
\]

Since

\[
\alpha=0.19,
\]

the accepted-pooling region is

\[
p\le 0.2407407407.
\]

Thus the old H-proposer pooling formula is valid only for

\[
p\le 0.240741.
\]

The low-state budget feasibility of the old pooling transfer would fail only much later, at

\[
p=0.9774074074,
\]

but incentive compatibility fails first. So feasibility alone is not enough.

## 8.4 H-proposer lower bound

The low-type guarantee is

\[
G_0
=
\frac{\beta A_0}{N}
=
\frac{0.9(3.28)}{13}
=
0.2270769231.
\]

The high-type universal-acceptance transfer is

\[
s_1
=
m\beta W_2(1)
=
12(0.9)\frac{1.5(1-0.19)}{13}
=
1.0093846154.
\]

Therefore the high-type guarantee is

\[
G_1
=
r-s_1
=
1.5-1.0093846154
=
0.4906153846.
\]

Thus

\[
L_H(p)
=
0.2270769231
+
0.2635384615p.
\]

## 8.5 Weak-proposer thresholds

The conservative H payment is

\[
h_C
=
\frac{\beta rA_0}{N}
=
\frac{0.9(1.5)(3.28)}{13}
=
0.3406153846.
\]

The aggressive H payment is

\[
h_A
=
\frac{\beta A_1}{N}
=
\frac{0.9(4.42)}{13}
=
0.3060000000.
\]

The aggressive payment to each non-proposing weak state is

\[
y_A
=
\frac{\beta(1-\alpha)}{N}
=
\frac{0.9(0.81)}{13}
=
0.0560769231.
\]

Aggressive feasibility requires

\[
h_A+ky_A\le 1.
\]

Here,

\[
h_A+11y_A
=
0.306+11(0.0560769231)
=
0.9228461538<1.
\]

So the aggressive branch is feasible for all \(p\).

The aggressive-conservative crossing is

\[
p_{AC}=0.0311882732.
\]

The conservative feasibility cutoff is

\[
p_C^F=0.3017171717.
\]

The payoff-irrelevant conservative-rejection crossing occurs at

\[
p_{CR}=0.0115424974,
\]

but \(A(p)\) dominates both there.

The aggressive-rejection crossing is

\[
p_{AR}=1,
\]

where aggressive and deliberate rejection tie.

Therefore the weak-proposer regimes are:

\[
A
\quad\text{for}\quad
0\le p\le 0.0311882732,
\]

\[
C
\quad\text{for}\quad
0.0311882732<p\le 0.3017171717,
\]

\[
A
\quad\text{for}\quad
0.3017171717<p\le 1,
\]

with \(A\) and \(R\) tied at \(p=1\).

## 8.6 H payoff under weak-proposer branches

Under aggressive weak proposals,

\[
H_A^W(p)
=
(1-p)h_A+p h_C
=
0.3060000000+0.0346153846p.
\]

Under conservative weak proposals,

\[
H_C^W
=
h_C
=
0.3406153846.
\]

At \(p=1\), aggressive and rejection give the same H payoff,

\[
0.3406153846.
\]

## 8.7 Selection-free unanimity lower bound

The selection-free R1 unanimity lower bound is

\[
U_H^{LB}(p)
=
\frac{1}{13}L_H(p)
+
\frac{12}{13}J_H(p),
\]

where \(J_H(p)\) is the lowest H payoff among weak-proposer optimal branches.

The relevant endpoint checks are:

| Region | Point | Branch used for lower bound | \(U_H^{LB}(p)-M_H(p)\) |
|---|---:|---|---:|
| \(A\) | \(0\) | \(A\) | \(0.0795739645\) |
| \(A/C\) tie | \(p_{AC}=0.0311882732\) | lower of \(A,C\), namely \(A\) | \(0.0777665210\) |
| \(C\) | just above \(p_{AC}\) | \(C\) | \(0.1087225455\) |
| \(C\) | \(p_C^F=0.3017171717\) | \(C\) | \(0.0844006467\) |
| \(A\) | just above \(p_C^F\) | \(A\) | \(0.0620886510\) |
| \(A/R\) tie | \(1\) | \(A\) or \(R\) | \(0.0216213018\) |

The smallest gap is at \(p=1\):

\[
U_H^{LB}(1)=0.3521538462,
\]

\[
M_H(1)=0.3305325444,
\]

so

\[
U_H^{LB}(1)-M_H(1)=0.0216213018>0.
\]

Therefore, in the calibration,

\[
\boxed{
U_H^{LB}(p)>M_H(p)
\quad
\text{for every }p\in[0,1].
}
\]

This is stronger than merely showing dominance on the accepted-pooling region. It holds even using the selection-free lower bound for the unresolved H-proposer branch.

---

# 9. Claims that can safely go into the paper

The following claims are globally proven under the stated BF primitives.

## Majority

1. Under majority rule, weak proposers can exclude \(H\).

2. Because \(H\)’s outside option is external, excluding \(H\) does not reduce the weak coalition’s pie.

3. Majority eliminates the screening problem because weak coalitions need not buy \(H\)’s approval.

4. The corrected majority payoffs are

\[
V_H^{R2}(\theta,M)=\frac{A_0V(\theta)}{N},
\]

\[
V_W^{R2}(p,M)=\frac{V_e(p)}{N},
\]

\[
M_H(p)=\lambda_M^E V_e(p),
\]

and

\[
V_W^{R1}(p,M)=\kappa_M^E V_e(p).
\]

## Unanimity R2

5. Under unanimity, R2 weak proposers face an aggressive-versus-conservative screening problem.

6. The R2 cutoff is

\[
p_2=\frac{\alpha(r-1)}{r-\alpha}.
\]

7. The R2 weak payoff is

\[
W_2(p)=\frac{\max\{(1-p)(1-\alpha),V_e(p)-\alpha r\}}{N}.
\]

## Unanimity R1, weak proposer

8. A weak proposer in R1 chooses among feasible aggressive, feasible conservative, and deliberate rejection branches:

\[
W_1^{prop}(p,U)
=
\max\{A(p),C(p),R(p)\},
\]

with feasibility constraints.

9. There is no single global monotone cutoff governing the R1 weak-proposer branch.

## Unanimity R1, H proposer

10. The old pooling formula

\[
V_e(p)-m\beta W_2(p)
\]

is valid only on the accepted-pooling region

\[
p\le
\max\left\{
\alpha,
\frac{N(1-\beta)}{\beta m(r-1)}
\right\}.
\]

11. Outside that region, the H-proposer branch is a genuine signaling problem.

12. There is no payoff-distinct pure separating PBE with both H types accepted.

13. There is no pure PBE with high accepted and low rejected.

14. There is no pure PBE with low accepted and high rejected.

15. There is no pure PBE with both types rejected when \(\beta<1\).

16. Therefore, outside the accepted-pooling region, the H-proposer subgame requires mixed strategies or a payoff correspondence.

## Lower-bound comparison

17. H has the selection-free H-proposer lower bound

\[
L_H(p)=
(1-p)\frac{\beta A_0}{N}
+
p\left[
r-m\beta W_2(1)
\right].
\]

18. A sufficient condition for unanimity to dominate majority is

\[
\frac{1}{N}L_H(p)+\frac{m}{N}J_H(p)
>
\lambda_M^E V_e(p),
\]

where \(J_H(p)\) is the worst H payoff among weak-proposer optimal branches.

## Calibration

19. In the calibration

\[
N=13,\quad r=1.5,\quad \alpha=0.19,\quad \beta=0.9,\quad q=7,
\]

accepted pooling in the H-proposer branch exists only for

\[
p\le 0.240741.
\]

20. In the same calibration, the selection-free unanimity lower bound exceeds majority for every \(p\in[0,1]\).

21. The minimum calibrated lower-bound gap is

\[
0.0216213018,
\]

attained at \(p=1\).

---

# 10. Claims that must be removed or marked pending

The following claims should not appear as global theorems.

1. **Remove:** the global H-proposer pooling formula

\[
V_e(p)-m\beta W_2(p)
\]

as if it applied for all \(p\).

2. **Remove:** any proof that treats the H-proposer branch as a non-signaling BF offer problem outside the accepted-pooling region.

3. **Remove or rewrite:** any theorem claiming a single global R1 unanimity cutoff.

4. **Remove or rewrite:** any claim that weak-proposer unanimity in R1 is globally conservative above one cutoff. Under strict BF feasibility, the conservative branch may become infeasible.

5. **Remove:** any majority payoff formula using

\[
(1-\alpha)V_e(p)
\]

as the weak coalition’s effective pie when \(H\) is excluded. The outside option is external and does not reduce the weak coalition’s pie.

6. **Mark pending:** a full closed-form global equilibrium characterization of the H-proposer branch outside accepted pooling. That region requires either mixed strategies or a payoff correspondence.

7. **Mark pending:** any general institutional-dominance theorem not based on explicit sufficient conditions or endpoint checks over the relevant branch regions.

8. **Rewrite:** the entry model as collective all-or-nothing entry by weak states:

\[
F_R=\{p:V_W^{R1}(p,R)\ge c\}.
\]

Do not model individual simultaneous entry.

9. **Rewrite:** the abstract’s strongest general claim. The calibrated claim survives, but the general statement should be framed as: unanimity can make the hegemon’s informational advantage productive, and in the calibration unanimity dominates majority wherever the lower-bound comparison is applied. It should not claim that the old closed-form theorem proves global dominance.

The safest paper-level replacement is a theorem of sufficient conditions plus a calibrated proposition. The calibrated proposition is strong: even after discarding the old H-proposer pooling value outside its valid region, the unanimity lower bound remains above the corrected majority payoff on the entire unit interval.
