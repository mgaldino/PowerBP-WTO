# Prova analítica do Lemma X

## Resultado

**Lemma X.** Fixe $N \geq 3$, $r>1$, $\beta\in(0,1)$ e $\alpha\in(0,1/r)$. Sob unanimidade,
\[
V_W^{R1}(\mu,U) \leq V_W^{R1}(1,U)=\frac{r(1-\beta\alpha)}{N}
\qquad\text{para todo }\mu\in(0,1].
\]
A desigualdade é estrita para todo $\mu<1$.

**Corolário.** Se
\[
E_U \equiv \{\mu\in(0,1]: V_W^{R1}(\mu,U)\geq c\}
\]
é não vazio, então $1\in E_U$.

---

## Prova

Defina
\[
V_e(\mu)=1+\mu(r-1), \qquad
x=(N-1)\alpha r, \qquad
\mu_2\equiv \mu_s^{R2}=\frac{\alpha(r-1)}{r-\alpha}.
\]
Como $\alpha<1/r<1$, temos $0<\mu_2<1$. No segundo round, o payoff de continuação de um weak state é
\[
W_2^L(\mu)=\frac{(1-\mu)(1-\alpha)}{N}
\quad\text{se }\mu<\mu_2,
\]
e
\[
W_2^H(\mu)=\frac{V_e(\mu)-\alpha r}{N}
\quad\text{se }\mu\geq \mu_2.
\]

A prova não precisa usar a localização do cutoff de R1, nem o ordenamento entre $\mu_s^{R1}$ e $\mu_s^{R2}$. Basta comparar o payoff de $W$ em cada uma das quatro expressões candidatas — R1 agressivo/conservador combinado com R2 baixo/alto — com o valor em $\mu=1$.

Denote
\[
\bar V_W \equiv V_W^{R1}(1,U)=\frac{r(1-\beta\alpha)}{N}.
\]
Mostraremos que $\bar V_W - V_W^{R1}(\mu,U)\geq 0$ em todos os ramos possíveis.

### 1. R1 conservador, R2 alto

Quando a oferta conservadora é escolhida em R1 e $\mu\geq\mu_2$, a expressão fechada é
\[
V_W^C(\mu)
=\frac{(N+\beta)V_e(\mu)-\beta r(1+N\alpha)}{N^2}.
\]
Logo,
\[
\bar V_W - V_W^C(\mu)
=\frac{(N+\beta)(r-1)(1-\mu)}{N^2}\geq 0,
\]
com igualdade apenas em $\mu=1$.

### 2. R1 agressivo, R2 alto

Quando a oferta agressiva é escolhida em R1 e $\mu\geq\mu_2$, temos
\[
V_W^A(\mu)
=\frac{F_1^{agg}(\mu)}{N}
+\frac{\beta W_2^H(\mu)}{N}
+\frac{N-2}{N}\left[(1-\mu)\beta W_2^H(\mu)+\mu\beta\frac{r(1-\alpha)}{N}\right],
\]
onde
\[
F_1^{agg}(\mu)
=(1-\mu)\left[1-\frac{\beta(1+x)}{N}-(N-2)\beta W_2^H(\mu)\right]
+\mu\frac{\beta r(1-\alpha)}{N}.
\]
Substituindo $W_2^H(\mu)=[V_e(\mu)-\alpha r]/N$ e simplificando,
\[
\bar V_W - V_W^A(\mu)
=\frac{(1-\mu)(r-1)+\mu r(1-\beta)}{N}>0
\]
para todo $\mu\in[0,1]$, pois $r>1$ e $\beta<1$.

### 3. R1 conservador, R2 baixo

Este é o ramo relevante quando $\mu_s^{R1}<\mu_s^{R2}$ e a oferta conservadora em R1 pode ocorrer ainda no ramo baixo de R2. Com $W_2^L(\mu)=(1-\mu)(1-\alpha)/N$,
\[
V_W^{CL}(\mu)
=\frac{1}{N}\left[V_e(\mu)-\frac{\beta(r+x)}{N}-(N-2)\beta W_2^L(\mu)\right]
+\frac{N-1}{N}\beta W_2^L(\mu).
\]
A diferença em relação a $\bar V_W$ é affine em $\mu$:
\[
\bar V_W - V_W^{CL}(\mu)
=\frac{(r-1)(N-\alpha\beta+\beta)
+\mu\{N(1-r)-\alpha\beta+\beta\}}{N^2}.
\]
Como esta expressão é affine no intervalo $[0,\mu_2]$, basta verificar seus extremos. Em $\mu=0$,
\[
\bar V_W - V_W^{CL}(0)
=\frac{(r-1)(N-\alpha\beta+\beta)}{N^2}>0.
\]
Em $\mu=\mu_2$,
\[
\bar V_W - V_W^{CL}(\mu_2)
=\frac{r(N+\beta)(1-\alpha)(r-1)}{N^2(r-\alpha)}>0.
\]
Portanto $\bar V_W - V_W^{CL}(\mu)>0$ para todo $\mu\in[0,\mu_2]$.

### 4. R1 agressivo, R2 baixo

Com R1 agressivo e R2 baixo,
\[
V_W^{AL}(\mu)
=\frac{F_1^{agg}(\mu)}{N}
+\frac{\beta W_2^L(\mu)}{N}
+\frac{N-2}{N}\left[(1-\mu)\beta W_2^L(\mu)+\mu\beta\frac{r(1-\alpha)}{N}\right],
\]
onde
\[
F_1^{agg}(\mu)
=(1-\mu)\left[1-\frac{\beta(1+x)}{N}-(N-2)\beta W_2^L(\mu)\right]
+\mu\frac{\beta r(1-\alpha)}{N}.
\]
Substituindo $W_2^L(\mu)=(1-\mu)(1-\alpha)/N$ e simplificando,
\[
\bar V_W - V_W^{AL}(\mu)
=\frac{(r-1)(N-\alpha\beta)
+\mu\{N(1-\beta r)+\beta r-\alpha\beta\}}{N^2}.
\]
Essa expressão também é affine em $\mu$ no intervalo $[0,\mu_2]$. Nos extremos:
\[
\bar V_W - V_W^{AL}(0)
=\frac{(r-1)(N-\alpha\beta)}{N^2}>0,
\]
pois $\alpha\beta<1<N$, e
\[
\bar V_W - V_W^{AL}(\mu_2)
=\frac{r(r-1)(1-\alpha\beta)}{N(r-\alpha)}>0,
\]
pois $\alpha<1/r$ implica $\alpha\beta<1$ e $r-\alpha>0$. Assim,
\[
\bar V_W - V_W^{AL}(\mu)>0
\qquad\text{para todo }\mu\in[0,\mu_2].
\]

### 5. Conclusão

Todo valor possível de $V_W^{R1}(\mu,U)$ pertence a um dos quatro ramos acima. Em cada ramo,
\[
V_W^{R1}(\mu,U)\leq \bar V_W=V_W^{R1}(1,U),
\]
com desigualdade estrita para $\mu<1$. Logo,
\[
V_W^{R1}(\mu,U)\leq V_W^{R1}(1,U)=\frac{r(1-\beta\alpha)}{N}
\qquad\forall\mu\in(0,1].
\]
Isso prova o Lemma X.

Para o corolário, suponha que $E_U\neq\emptyset$. Então existe algum $\mu'$ tal que $V_W^{R1}(\mu',U)\geq c$. Pelo Lemma X,
\[
V_W^{R1}(1,U)\geq V_W^{R1}(\mu',U)\geq c.
\]
Portanto $1\in E_U$. $\square$

---

## Observação sobre o caminho da prova

Esta prova é mais limpa que o argumento por slopes de $V_H$. Ela evita três fontes de fragilidade:

1. não exige integrar slopes de $V_H$ ao longo dos ramos;
2. não exige tratar separadamente o salto em $\mu_s^{R1}$;
3. não depende do caso $\mu_s^{R2}<\mu_s^{R1}$.

Em particular, o caso alternativo $\mu_s^{R1}\leq\mu_s^{R2}$ já está coberto pelos ramos “R1 conservador, R2 baixo” e “R1 agressivo, R2 baixo”. Portanto o resultado vale para todo $\alpha\in(0,1/r)$, não apenas para $\alpha<\bar\alpha(r,\beta,N)$.

---

## Checagem numérica

O ambiente em que rodei esta verificação não tem `Rscript` instalado, então os scripts R anexados não puderam ser executados literalmente. Reproduzi, em Python, a mesma lógica de `scripts/model_functions.R`, `scripts/test_VW_monotonicity.R` e `scripts/test_supEU_lt_1.R`.

Resultados:

```text
test_VW_monotonicity.R equivalent:
  Tested: 4950 parameter combinations
  Violations (max V_W not at mu=1): 0
  Worst ratio max_VW / V_W(1): 1.000000

test_supEU_lt_1.R equivalent:
  Tested: 1680 parameter combinations
  Cases where sup(E_U) < 1 is possible: 0

Additional broader grid, not restricted to alpha < alpha_star:
  Tested: 9450 parameter combinations
  Violations: 0
  Worst ratio max_VW / V_W(1): 1.000000
```

These numerical checks are not used as proof; they only confirm consistency with the analytical result above.
