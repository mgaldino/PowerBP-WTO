# Assessment — Reescrita das Provas e Fórmulas

**Projeto:** Informational Power Through Pivotality  
**Data:** 2026-05-10  
**Base:** `quality_reports/notas_reescrita_provas_formulas.md`, `formal_model_v5.Rmd`, agentes independentes de verificação analítica.

## Veredito Executivo

O parecer procede. A contabilidade correta é: quando `H` é excluído sob maioria, `H` recebe `\alpha V(\theta)` externamente; esse payoff não sai do bolo institucional que o proponente fraco divide com a coalizão vencedora.

As fórmulas centrais corrigidas do parecer passaram na verificação independente:

\[
V_W^{R2}(\mu,M)=\frac{V_e(\mu)}{N},
\qquad
\lambda_M^{ext}
=\frac{N[1+(N-1)\alpha]-\beta(q-1)}{N^2},
\qquad
\kappa_M^{ext}
=\frac{N(N-1)+\beta(q-1)}{N^2(N-1)}.
\]

Também passou o novo threshold de dominância condicional:

\[
\alpha_{ext}^{*}(N,\beta)
=\frac{\beta(q-1)}{N(N-1)(1-\beta)}.
\]

Mas o paper ainda não está pronto para reenviar as provas. Há três bloqueios substantivos independentes da correção de majority: feasibility estado a estado, protocolo de votação/participação dos fracos não proponentes, e multiplicidade no estágio de entrada.

## Auditoria por Bloco

### 1. Majority sob Outside Option Externa

**Status:** PASS para as fórmulas novas; FAIL para o Appendix A.1/B.1 atual.

O Appendix atual ainda calcula o payoff do proponente fraco como se `\alpha V(\theta)` fosse subtraído do pie. Isso deve ser removido. Sob majority:

- se `H` propõe, compra `q-1` votos fracos a custo zero em R2;
- se `W` propõe, compra `q-1` votos fracos, exclui `H`, e fica com o pie inteiro;
- `H` recebe `\alpha V(\theta)` externamente.

A prova de que `W` exclui `H` é defensável. Inclusão conservadora é estritamente dominada porque:

\[
\Pi_C-\Pi_E
=\frac{\beta}{N}[V_e(\mu)-r(1+(N-1)\alpha)]<0.
\]

Inclusão agressiva também é estritamente dominada; a comparação no parecer usa um upper bound favorável à inclusão e ainda assim é negativa.

### 2. Teorema 1 / Dominância Condicional

**Status:** PASS para o núcleo; ajuste obrigatório para `\bar\mu^{ext}`.

A decomposição corrigida passou:

\[
D^{ext}(\mu)
=D_{base}^{ext}(\mu)
\mathbf 1\{\mu<\mu_s^{R2}\}\delta_{R2}(\mu)
\mathbf 1\{\mu>\mu_s^{R1}\}\delta_{R1}(\mu),
\]

com

\[
D_{base}^{ext}(\mu)
=\frac{(B-C)V_e(\mu)+C\beta r}{N^2},
\quad
B=\beta(q-1),
\quad
C=N(N-1)\alpha.
\]

No endpoint `\mu=1`:

\[
D^{ext}(1)=\frac{r[B-C(1-\beta)]}{N^2}.
\]

Logo, a condição `\alpha<\alpha_{ext}^*` é necessária e suficiente para dominância estrita em todo `\mu \in (0,1]`.

Ressalva: a fórmula

\[
\bar\mu^{ext}=1-\frac{|D^{ext}(1)|}{\Gamma^{ext}}
\]

é uma fronteira local do branch alto. Ela só vale diretamente quando `\mu>\max\{\mu_s^{R1},\mu_s^{R2}\}`. O texto não deve apresentá-la como fronteira global sem qualificação.

### 3. Cutoff de R1 na Calibração

**Status:** PASS para a correção do parecer.

Com `N=13`, `r=1.5`, `\alpha=0.19`, `\beta=0.9`:

\[
\bar\alpha \approx 0.17017,
\qquad
\alpha=0.19>\bar\alpha.
\]

Portanto a calibração está no branch baixo de R2. O cutoff fechado independente de `\alpha` (`0.06398`) está no branch errado. O cutoff correto é aproximadamente:

\[
\mu_s^{R1}\approx 0.06493.
\]

### 4. Formation Sets e Proposition 4

**Status:** FAIL para B.6/B.8 atuais; recuperável com novas hipóteses/provas.

O argumento antigo de budget balance sob majority é falso:

\[
E[V_H(\mu,M)]+(N-1)V_W(\mu,M)
\ne V_e(\mu).
\]

Com outside option externa:

\[
E[V_H(\mu,M)]+(N-1)V_W(\mu,M)
=\left[1+\frac{(N-1)\alpha}{N}\right]V_e(\mu).
\]

O nesting `\mathcal F_U\subseteq\mathcal F_M` parece recuperável, mas deve ser provado por comparação explícita de payoff dos fracos em cada branch de unanimity:

- conservative R1 / high R2;
- aggressive R1 / high R2;
- conservative R1 / low R2;
- aggressive R1 / low R2.

O caso `p\in\mathcal F_M\setminus\mathcal F_U` em B.8 precisa de condição adicional:

\[
\lambda_M^{ext}>\alpha
\iff
\alpha < 1-\frac{\beta(q-1)}{N}.
\]

Essa condição não é implicada por `\alpha<1/r`.

### 5. Feasibility Estado a Estado

**Status:** bloqueio real de modelo/prova.

Se propostas são divisões de `V(\theta)`, então transferências aceitas precisam ser factíveis em cada estado. O apêndice atual checa orçamento em expectativa, o que não basta.

Com os parâmetros calibrados, a oferta conservadora de `W` em R1 pode violar feasibility no estado baixo para parte relevante da região de entrada sob unanimity. Isso exige uma escolha substantiva:

1. impor feasibility estado a estado e re-solver o jogo; ou
2. redefinir propostas como transferências/utilidades prometidas não limitadas pelo realized low-state pie; ou
3. restringir o espaço paramétrico/região de aplicação às crenças onde feasibility vale.

Sem uma dessas opções, as provas de R1 sob unanimity não estão completas.

### 6. Timing das Restrições de Participação

**Status:** bloqueio real de especificação/PBE.

O pagamento mínimo a fracos não proponentes sob oferta agressiva depende do protocolo de votação e da informação revelada pela rejeição de `H`. Para preservar as fórmulas atuais, o modelo precisa assumir explicitamente que fracos não proponentes exigem `\beta V_W^{R2}(\mu,U)` no posterior corrente, independentemente da informação que a resposta de `H` venha a revelar.

Sem essa convenção reduzida, `F_1^{agg}` deve ser rederivado.

### 7. Salto no Cutoff

**Status:** ajuste de formulação.

O salto deve ser escrito por limites laterais ou com tie-breaking explícito:

\[
\lim_{\mu\downarrow\mu_s^{R1}}V_H^U(\mu)
-
\lim_{\mu\uparrow\mu_s^{R1}}V_H^U(\mu)
=
(1-\mu_s^{R1})\frac{(N-1)\beta(r-1)}{N^2}>0.
\]

No ponto exato do cutoff, sem desempate, o payoff é uma correspondência.

### 8. Entrada

**Status:** bloqueio real de equilíbrio/seleção.

Com entrada simultânea all-or-nothing, `V_W^{R1}(p,R)\ge c` garante existência de equilíbrio de entrada plena, não formação em todos os PBE. O equilíbrio sem entrada também existe em geral.

O texto deve redefinir `\mathcal F_R` como conjunto de priors em que o equilíbrio de entrada plena existe/é selecionado, ou adicionar uma hipótese de seleção: payoff-dominant equilibrium, coordenação prévia, entrada coletiva, ou mecanismo equivalente.

### 9. Tipos Contínuos

**Status:** PASS para fórmulas corrigidas; FAIL para Appendix C atual.

Sob outside option externa:

\[
V_W^{R2}(\theta,M)=\frac{\theta}{N},
\]

não `(1-\alpha)\theta/N`.

Para `\theta\sim U[1,r]`, `m=(1+r)/2`:

\[
E[V_H^{R1}(M)]
=
\frac{m[N(1+(N-1)\alpha)-\beta(q-1)]}{N^2}.
\]

A diferença corrigida é:

\[
D_{cont}^{ext}
=
\frac{1}{2N^2}
\left[
(N-1)\beta\frac{(\theta_1^*-1)^2}{r-1}
+(1+r)\beta(q-1)
-N(N-1)\alpha(1+r-2\beta r)
\right].
\]

O threshold contínuo corrigido do parecer passa, condicionado ao denominador positivo. No limite `r\to1^+`, converge para `\alpha_{ext}^*`.

## Recomendação

Não enviar novas provas ao parecerista ainda.

A ordem correta de reescrita é:

1. fixar explicitamente a convenção de outside option externa;
2. decidir a estratégia para feasibility/timing/entry selection;
3. reescrever A.1/B.1 e atualizar `lambda_M^{ext}`, `kappa_M^{ext}`;
4. reescrever Theorem 1 com `\alpha_{ext}^*` e qualificar `\bar\mu^{ext}`;
5. reescrever B.6 com comparação branchwise dos payoffs dos fracos;
6. reescrever B.8 com a condição `\lambda_M^{ext}>\alpha` ou com opção explícita de não formação;
7. atualizar Appendix C;
8. recalcular figuras e auditoria numérica;
9. submeter cada prova reescrita a novo agente independente até obter PASS sem ressalva.

