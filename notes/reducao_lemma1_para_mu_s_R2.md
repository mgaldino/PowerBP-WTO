# Redução do Lemma 1 ao ponto \(\mu_s^{R2}\)

## Objetivo

Defina
\[
D(\mu)\equiv E[V_H^{R1}(\mu,U)]-E[V_H^{R1}(\mu,M)].
\]

O objetivo do Lemma 1 é mostrar que, sob
\[
\alpha<\alpha^*(N,\beta)
\equiv
\frac{\beta(q-1)}{N(N-1)-\beta(N^2-N-q+1)},
\]
vale
\[
D(\mu)>0
\qquad \forall \mu\in(0,1).
\]

---

## 1. Estrutura piecewise affine

A diferença \(D(\mu)\) é afim por partes em três regiões:

- **Região I:** \(\mu\in(0,\mu_s^{R2})\)
- **Região II:** \(\mu\in(\mu_s^{R2},\mu_s^{R1})\)
- **Região III:** \(\mu\in(\mu_s^{R1},1)\)

Logo, basta controlar os endpoints relevantes de cada trecho.

---

## 2. Região III

Na Região III,
\[
D_{III}(\mu)=D(1)+s_{III}(\mu-1),
\]
com
\[
D(1)
=
\frac{r}{N^2}
\Big[
\beta(q-1)-\alpha\big((1-\beta)N(N-1)+\beta(q-1)\big)
\Big]
\]

e
\[
s_{III}
=
-\frac{r-1}{N^2}
\Big[
\alpha N(N-1)+\beta(N-q)-\alpha\beta(q-1)
\Big].
\]

Como o colchete é estritamente positivo, segue que
\[
s_{III}<0.
\]
Portanto, a Região III é sempre decrescente, e seu mínimo ocorre em \(\mu=1\).

Assim, sob \(\alpha<\alpha^*(N,\beta)\), temos
\[
D(1)>0
\quad \Longrightarrow \quad
D_{III}(\mu)>0
\qquad \forall \mu\in(\mu_s^{R1},1].
\]

---

## 3. Salto em \(\mu_s^{R1}\)

No cutoff de R1, a diferença apresenta um salto para cima:
\[
D(\mu_s^{R1+})-D(\mu_s^{R1-})
=
\frac{(N-1)\beta(r-1)(1-\mu_s^{R1})}{N^2}>0.
\]

Além disso, vale a identidade
\[
D(\mu_s^{R1-})
=
D(1)
+
\frac{(1-\mu_s^{R1})(r-1)}{N^2}
\Big[
\alpha N(N-1)-\beta(q-1)(1-\alpha)
\Big].
\]

Defina
\[
K\equiv \alpha N(N-1)-\beta(q-1)(1-\alpha).
\]

Então
\[
D(\mu_s^{R1-})
=
D(1)+\frac{(1-\mu_s^{R1})(r-1)}{N^2}K.
\]

---

## 4. Região II

Na Região II,
\[
D_{II}(\mu)=a_{II}+s_{II}\mu,
\]
com inclinação
\[
s_{II}
=
-\frac{r-1}{N^2}
\Big[
\alpha N(N-1)-\beta(q-1)(1-\alpha)
\Big]
=
-\frac{r-1}{N^2}K.
\]

Logo:

- se \(K\ge 0\), então \(s_{II}\le 0\), e a Região II é decrescente;
- se \(K<0\), então \(s_{II}>0\), e a Região II é crescente.

### Caso 1: \(K\ge 0\)

Como
\[
D(\mu_s^{R1-})
=
D(1)+\frac{(1-\mu_s^{R1})(r-1)}{N^2}K
\ge D(1)>0,
\]
segue que o extremo direito da Região II é positivo. Como a região é decrescente, isso implica
\[
D_{II}(\mu)>0
\qquad \forall \mu\in(\mu_s^{R2},\mu_s^{R1}).
\]

### Caso 2: \(K<0\)

Nesse caso, a Região II é crescente, e seu mínimo ocorre no extremo esquerdo. Logo, para fechar a Região II, basta mostrar
\[
D(\mu_s^{R2})>0.
\]

---

## 5. Região I

Na Região I,
\[
D_I(\mu)=D_I(0)+s_I\mu,
\]
com
\[
D_I(0)
=
\frac{
\beta(q-1)-\alpha\Big[N(N-1)-\beta\big(r(N-1)^2+N-q\big)\Big]
}{N^2}.
\]

O threshold que zera \(D_I(0)\) é
\[
\bar\alpha_0
=
\frac{\beta(q-1)}{N(N-1)-\beta\big(r(N-1)^2+N-q\big)}.
\]

Como
\[
N(N-1)-\beta\big(r(N-1)^2+N-q\big)
<
N(N-1)-\beta(N^2-N-q+1),
\]
segue que
\[
\bar\alpha_0>\alpha^*(N,\beta).
\]

Portanto, sob \(\alpha<\alpha^*\), automaticamente
\[
D_I(0)>0.
\]

Assim, para fechar a Região I, só falta controlar o outro endpoint, isto é,
\[
D(\mu_s^{R2})>0.
\]

---

## 6. Redução final

Com os passos acima, o Lemma 1 fica reduzido da seguinte forma:

### Já está controlado sob \(\alpha<\alpha^*\)

- \(D(1)>0\);
- \(D_I(0)>0\);
- a Região III inteira é positiva;
- a Região II inteira é positiva quando \(K\ge 0\).

### O único ponto realmente pendente

Mostrar
\[
D(\mu_s^{R2})>0.
\]

Mais precisamente:

- se \(K\ge 0\), isso já vem automaticamente porque a Região II inteira é positiva;
- se \(K<0\), então este é o único subcaso que resta.

---

## 7. Conclusão operacional

A prova do Lemma 1 foi reduzida a um único gargalo técnico:
\[
D(\mu_s^{R2})>0.
\]

Todo o restante já foi reorganizado em uma estrutura analítica limpa:

1. positividade em \(\mu=1\);
2. negatividade da inclinação na Região III;
3. identidade em \(\mu_s^{R1-}\);
4. dicotomia pelo sinal de
   \[
   K=\alpha N(N-1)-\beta(q-1)(1-\alpha);
   \]
5. positividade automática em \(\mu=0\).

Assim, o problema restante não é mais global; ele é local e concentrado no cutoff de R2.
