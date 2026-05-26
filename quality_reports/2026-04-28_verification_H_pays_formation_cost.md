# Verificacao analitica: extensao H paga custo de formacao

**Data**: 2026-04-28  
**Nota verificada**: `notes/2026-04-28_extension_H_pays_formation_cost.md`  
**Fontes**: `formal_model_v5.Rmd`, `scripts/model_functions.R`  
**Tipo**: Verificacao matematica, 8 claims

---

## Claim 1: W sempre entra (c_W = 0 implica V_W >= 0)

**Veredicto: PASS**

**Justificativa**: No modelo, o disagreement payoff de W e d_W = 0 (Definition 1, formal_model_v5.Rmd, linha 102). Em qualquer PBE do subgame de barganha, W pode sempre garantir pelo menos 0 rejeitando qualquer proposta. Se W rejeita em R1, o jogo vai para R2 (ou termina com d_W = 0 em R2). Em R2, W pode rejeitar e receber 0. Portanto, a sequencial racionalidade garante V_W^{R1}(p, R) >= 0 para todo p e toda regra R.

Numericamente confirmado: com (N=13, r=1.5, alpha=0.19, beta=0.9), V_W^{R1} varia de 0.058 (unanimidade, p baixo) a 0.096 (maioria, p alto). Todos estritamente positivos.

Com c_W = 0, a condicao de entrada V_W^{R1}(p,R) >= 0 e satisfeita trivialmente. W sempre entra.

---

## Claim 2: Conjuntos de formacao G_R = {p : v(p,R) >= C}

**Veredicto: PASS com ressalva**

**Justificativa**: A definicao e logicamente correta. O net gain de H ao formar a IO e:

v(p, R) = E[V_H^{R1}(p, R)] - alpha * V_e(p)

O primeiro termo e o payoff dentro da IO; o segundo e o payoff de status quo (bilateral). H forma sse v(p,R) >= C, onde C e o custo de formacao.

**Ressalva**: A nota define v(p,R) = E[V_H^{R1}] - alpha * V_e(p), que coincide exatamente com a Definition 4 (Net gain function) do paper (formal_model_v5.Rmd, linhas 399-404). A definicao esta correta. No entanto, deve-se notar que a comparacao institucional de H usa V_H(R,p), que inclui o payoff de status quo quando a IO nao forma. Quando H decide se forma a IO, o relevante e de fato v(p,R) >= C, porque se nao forma, recebe alpha*V_e(p) e nao paga C.

---

## Claim 3: Inclusao invertida G_M sube G_U

**Veredicto: PASS (condicional em alpha < alpha*)**

**Justificativa**: Pelo Theorem 1 (formal_model_v5.Rmd, linhas 423-428):

Se alpha < alpha*(N,beta), entao para todo mu em (0,1]:
  E[V_H^{R1}(mu, U)] > E[V_H^{R1}(mu, M)]

Subtraindo alpha*V_e(mu) de ambos os lados (V_e e igual sob ambas as regras):
  v(mu, U) > v(mu, M) para todo mu em (0,1]

Se p pertence a G_M, entao v(p,M) >= C. Como v(p,U) > v(p,M) >= C, temos v(p,U) >= C, logo p pertence a G_U.

Portanto G_M sube G_U. A inclusao e o oposto do modelo base (onde F_U sube F_M). A logica formal esta correta e segue diretamente do Theorem 1.

---

## Claim 4: v(p,M) e afim em p

**Veredicto: PASS**

**Justificativa**: Do Appendix B.1 (formal_model_v5.Rmd, linhas 884-892):

E[V_H^{R1}(mu, M)] = lambda_M * V_e(mu)

onde lambda_M = [N(1 + (N-1)alpha) - beta(q-1)(1-alpha)] / N^2 e uma constante.

Portanto:
v(p, M) = lambda_M * V_e(p) - alpha * V_e(p) = (lambda_M - alpha) * V_e(p)

Do Step 6 da prova (linhas 898-902):
lambda_M - alpha = (1-alpha)[N - beta(q-1)] / N^2 > 0

Desde que V_e(p) = 1 + p(r-1) e afim em p e lambda_M - alpha e constante positiva, v(p,M) e afim em p com coeficiente angular (lambda_M - alpha)(r-1) > 0.

Verificacao numerica: para N=13, r=1.5, alpha=0.19, beta=0.9, VH_R1_majority coincide exatamente com lambda_M * V_e (diferenca = 0 ate a precisao de maquina).

---

## Claim 5: v(p,U) herda o screening jump

**Veredicto: PASS**

**Justificativa**: v(p,U) = VH_R1_unanimity(p) - alpha * V_e(p). O termo alpha*V_e(p) e continuo (e afim) em p. Portanto, qualquer descontinuidade em VH_R1_unanimity(p) se transmite integralmente para v(p,U).

A Proposition 3 (Jump, formal_model_v5.Rmd, linhas 322-327) estabelece:

Jump = (1 - mu_s^{R1}) * (N-1)*beta*(r-1) / N^2 > 0

Esta e uma descontinuidade positiva (para cima) em E[V_H^{R1}] no cutoff mu_s^{R1}. O mesmo jump aparece em v(p,U).

Derivacao do jump a partir das formulas primitivas:
- Na branch conservativa: VH_0_con = H_prop_0 + (N-1)*beta*(r+x)/N^2
- Na branch agressiva: VH_0_agg = H_prop_0 + (N-1)*beta*(1+x)/N^2
- Diferenca para theta=0: (N-1)*beta*(r-1)/N^2
- Para theta=1: VH_1_con = VH_1_agg (ambos usam (r+x))
- Jump total: (1-mu) * (N-1)*beta*(r-1)/N^2

Verificacao numerica (N=13, r=1.5, alpha=0.19, beta=0.9):
- Jump em VH = 0.02991 (formula: 0.02991)
- Jump em v = identico (pois alpha*Ve e continuo)

---

## Claim 6: G_U pode ser desconexo

**Veredicto: PASS na existencia, FAIL na descricao**

**Justificativa detalhada**:

A nota afirma: "G_U pode ser desconexo para valores intermediarios de C: a IO forma abaixo de mu_s^{R1} (regime agressivo com net gain alto) e acima de algum threshold no regime conservativo, com um gap perto do cutoff."

**Existencia de desconexao: CORRETO** (sob parametros especificos). 

Para que G_U seja desconexo, e necessario que v(p,U) na branch agressiva seja DECRESCENTE em p. Isso ocorre quando alpha e suficientemente alto (especificamente quando alpha >= alpha_bar, colocando o cutoff na branch baixa de R2). Exemplo verificado numericamente:

- Parametros: r=3, alpha=0.3, N=7, beta=0.8
- Cutoff real: mu_s^{R1} ~ 0.136 (note: alpha >= alpha_bar = 0.176, logo a formula fechada nao se aplica)
- v_agg(0.001) = 0.401, v_agg(cutoff^-) = 0.394 (decrescente)
- v_con(cutoff^+) = 0.564 (jump para cima)
- Para C = 0.396: G_U = (0, 0.105) U (0.136, 0.509) -- DESCONEXO

**Descricao do mecanismo: INCORRETO em tres pontos**:

1. A nota diz "regime agressivo com net gain alto". Na verdade, o regime agressivo tem net gain MAIS BAIXO que o conservativo (v_agg ~ 0.40 vs v_con ~ 0.56 no exemplo acima). O regime com "net gain alto" e o conservativo.

2. A nota diz que o gap e "perto do cutoff". O gap de fato fica adjacente ao cutoff (entre p1 e mu_s_R1), mas a direcao esta invertida: o gap esta no LADO ESQUERDO do cutoff, nao porque v salta para baixo, mas porque v na branch agressiva desliza abaixo de C enquanto se aproxima do cutoff.

3. A nota nao menciona que a desconexao requer alpha >= alpha_bar (para que v_agg seja decrescente). Com alpha < alpha_bar e os parametros do paper (N=13, r=1.5, alpha=0.19, beta=0.9), v_agg e CRESCENTE e G_U e sempre conexo.

**Impacto na inclusao G_M sube G_U**: A nota corretamente observa que a desconexao "nao afeta a inclusao". Isso e verdade: G_M sube G_U segue do Theorem 1 pontualmente, independentemente da topologia dos conjuntos.

---

## Claim 7: Condicao alpha < alpha* ainda necessaria

**Veredicto: PASS**

**Justificativa**: Se alpha >= alpha*, o Theorem 1 estabelece que existe mu_bar acima do qual:

E[V_H^{R1}(mu, U)] < E[V_H^{R1}(mu, M)]

Equivalentemente, v(mu, M) > v(mu, U) para mu > mu_bar.

Nesse caso, G_M NAO e necessariamente subconjunto de G_U. Se C for suficientemente pequeno, pode existir p > mu_bar onde v(p,M) >= C mas v(p,U) < C.

Verificacao numerica (r=1.5, alpha=0.4, N=13, beta=0.9, alpha* = 0.257):
- D(0.86) = +0.002 > 0 (U domina)
- D(0.88) = -0.002 < 0 (M domina)
- mu_bar ~ 0.87

Consistente com Theorem 1 e com Remark 5 do paper.

---

## Claim 8: Formula do threshold tau_H^M

**Veredicto: PASS**

**Derivacao**:

v(p, M) = (lambda_M - alpha) * V_e(p) = C

(lambda_M - alpha) * (1 + p(r-1)) = C

1 + p(r-1) = C / (lambda_M - alpha)

p(r-1) = C / (lambda_M - alpha) - 1

p = [C / (lambda_M - alpha) - 1] / (r-1)

Portanto tau_H^M = (C/(lambda_M - alpha) - 1)/(r-1), conforme a nota.

**Condicoes de validade**: O threshold e bem definido quando:
- lambda_M > alpha (sempre verdade, provado no Step 6)
- C / (lambda_M - alpha) > 1, i.e., C > lambda_M - alpha (caso contrario, tau < 0 e G_M = (0,1])
- tau <= 1, i.e., C <= (lambda_M - alpha) * r (caso contrario, G_M e vazio)

Verificacao numerica (N=13, r=1.5, alpha=0.19, beta=0.9):
- lambda_M - alpha = 0.0364
- Para C = 0.05: tau_H^M = 0.7453
- v(tau, M) = 0.0500 = C (exato)

Para C = 0.03 com alpha=0.4:
- lambda_M - alpha = 0.0270
- tau_H^M = 0.2237
- v(tau, M) = 0.0300 = C (exato)

---

## Resumo

| Claim | Veredicto | Observacao |
|-------|-----------|------------|
| 1. W sempre entra | **PASS** | d_W=0, sequencial racionalidade garante V_W>=0 |
| 2. Definicao G_R | **PASS** | Coincide com Definition 4 do paper |
| 3. G_M sube G_U | **PASS** | Segue diretamente do Theorem 1 (requer alpha < alpha*) |
| 4. v(p,M) afim | **PASS** | (lambda_M - alpha)*V_e(p), verificado analiticamente e numericamente |
| 5. v(p,U) herda jump | **PASS** | alpha*V_e continuo => jump se transmite integralmente |
| 6. G_U desconexo | **PASS parcial** | Existencia correta (sob alpha>=alpha_bar), mas descricao do mecanismo errada em 3 pontos |
| 7. alpha < alpha* necessaria | **PASS** | Consistente com Theorem 1 |
| 8. Formula tau_H^M | **PASS** | Derivacao algebrica verificada, numericamente exato |

**Erros identificados (Claim 6)**:

1. A nota descreve o regime agressivo como tendo "net gain alto" -- e o contrario (conservativo tem net gain maior).
2. A desconexao nao ocorre para os parametros do paper (alpha < alpha_bar => v_agg crescente => G_U conexo). Ocorre apenas quando alpha >= alpha_bar.
3. A descricao do gap ("perto do cutoff") esta qualitativamente correta mas a direcao causal esta invertida: o gap aparece porque v_agg CALA abaixo de C ao se aproximar do cutoff (quando decrescente), nao porque o jump cria um buraco.

**Conclusao geral**: A extensao e matematicamente solida nos seus resultados centrais (claims 1-5, 7-8). O claim sobre desconexao de G_U (claim 6) requer uma correcao na descricao do mecanismo e na identificacao das condicoes parametricas necessarias.
