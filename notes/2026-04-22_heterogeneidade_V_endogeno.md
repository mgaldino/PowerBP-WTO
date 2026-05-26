# Nota Técnica: Extensão com Heterogeneidade, V Endógeno e Discriminação Estatística

**Data**: 2026-04-22  
**Status**: DRAFT v4 — exponencial saturante + BF 2 rounds com δ (Seção 10)  
**Relação com o paper**: extensão futura (paper 2). Não entra no v3.

---

## 1. Motivação

No modelo v3, todos os W's são idênticos e o pie V(θ) ∈ {1, r} é exógeno. Isso tem duas limitações:

1. **V não depende de quem está na mesa.** O Protocolo de Kyoto com os EUA vale diferente de Kyoto sem os EUA. A contribuição de cada membro à cooperação varia.

2. **Outside options são homogêneas entre W's.** Na prática, Brasil e Chad ocupam posições muito diferentes — em capacidade analítica, em contribuição ao acordo, em outside options bilaterais.

Esta extensão resolve ambas: cada jogador $i$ tem tipo $\alpha_i$ (contribuição + outside option), $\alpha_i$ é informação privada de $i$, e o pie $V(S)$ depende endogenamente da composição $S$ da coalizão via uma power function com retornos decrescentes.

O mecanismo central se reinterpreta via **discriminação estatística**: sob maioria, o proposer exclui H porque H é um "candidato de grupo incerto" — produtividade alta mas adverse selection custosa. Sob unanimidade, a inclusão forçada de H obriga o proposer a interagir com a informação privada de H, ativando o canal de BP.

---

## 2. Modelo

### 2.1 Jogadores e Tipos

- $N$ jogadores: 1 hegemon $H$ + $(N-1)$ weak states $W_1, \ldots, W_{N-1}$.
- Cada jogador $i$ tem tipo $\alpha_i \in [\underline{\alpha}_i, \overline{\alpha}_i]$, informação privada.
- **Identidade observável**: todos sabem quem é H e quem é W (como empregador vê grupo do candidato).
- **Distribuições por grupo**:
  - $\alpha_H \sim F_H$ com $E[\alpha_H] = \mu_H$ (alto), $\text{Var}(\alpha_H) = \sigma_H^2$
  - $\alpha_{W_j} \sim F_W$ com $E[\alpha_W] = \mu_W$ (baixo), $\text{Var}(\alpha_W) = \sigma_W^2$
- **Assimetria informacional de H**: H tem prior mais tight sobre $\alpha_{W_j}$'s (vantagem USTR/inteligência). W's usam o prior público $F_H$ para $\alpha_H$.
- **Dual role de $\alpha_i$**: tipo do jogador determina tanto sua contribuição ao pie quanto sua outside option.

### 2.2 Pie Endógeno

$$V(S) = M \cdot \left(1 - e^{-\lambda A(S)}\right)$$

onde $A(S) \equiv \sum_{i \in S} \alpha_i^\gamma$ é o **agregado de contribuição**, e:

- $M > 0$: valor máximo da cooperação (saturação)
- $\lambda > 0$: velocidade com que V cresce com o agregado
- $\gamma \in (1, 2)$: expoente de contribuição individual

**Propriedades-chave:**

| Propriedade | Mecanismo |
|---|---|
| $V(\emptyset) = 0$ | Sem coalizão, sem cooperação |
| Saturação | $V \to M$ quando $A$ é grande (Kyoto 180→190 não muda V) |
| Retornos decrescentes | $V'' < 0$: côncava em $A$ (sem massa crítica, sem S-shape) |
| Grandes $\alpha_i$ contribuem mais que proporcionalmente | $\gamma > 1$: US ($\alpha = 0.25$) contribui $0.25^\gamma$; 5 países com $\alpha = 0.05$ contribuem $5 \times 0.05^\gamma < 0.25^\gamma$ |

**Derivadas úteis:**
- $V'(A) = M\lambda e^{-\lambda A}$ (contribuição marginal ao pie, decrescente)
- $V''(A) = -M\lambda^2 e^{-\lambda A} < 0$ (sempre côncava)
- Contribuição marginal de $i$: $\partial V / \partial \alpha_i = M\lambda\gamma\alpha_i^{\gamma-1} e^{-\lambda A}$

**Nota sobre $\gamma$ e nível**: para $\alpha_i < 1$, $\alpha_i^\gamma$ decresce em $\gamma$. Porém o ratio $(\alpha_H/\alpha_W)^\gamma$ cresce em $\gamma$: H contribui relativamente mais. O efeito sobre $V$ em nível depende de $M$ e $\lambda$.

**Por que não power function**: V = C·A^σ foi testada (ver Seção 8.4). Sem saturação, a contribuição marginal de H nunca vai a zero, e a exclusão sob maioria não emerge. A exponencial garante que para coalizões grandes (A alto), V ≈ M e adicionar H mal muda V → exclusão viável.

### 2.3 Outside Options

$$d_i = \alpha_i$$

O tipo $\alpha_i$ desempenha papel duplo: contribuição ao pie e outside option bilateral. Um país que contribui mais à cooperação multilateral também tem melhores alternativas fora dela (é maior, mais capaz, mais conectado).

### 2.4 Timing

1. **Desenho institucional**: regra de votação $R \in \{U, M\}$ fixada exogenamente.
2. **BP**: H observa $\alpha_H$, commita sinal público $\pi(s|\alpha_H)$.
3. **Realização**: $\alpha_i$ realizados para cada $i$, sinal $s \sim \pi(\cdot|\alpha_H)$ gerado.
4. **Barganha (BF)**: proposer sorteado (prob $1/N$ cada), propõe divisão de $V(S)$. Votação sob regra $R$. Se rejeitado, round 2 ou outside options.

**Nota de modelagem**: as seções 3–5 usam TITL (1 round) como benchmark. A Seção 10 refaz a análise com BF padrão (2 rounds, desconto δ), resolvendo o problema do free look sob maioria. O BF é o modelo correto; TITL é o stepping stone pedagógico.

### 2.5 Conceito de Solução

PBE do jogo de barganha, dado o sinal ótimo de H (Bayesian Persuasion com commitment, KG 2011).

---

## 3. Tipos Binários, W's Simétricos (Benchmark Tratável)

**Simplificação**: $\alpha_H \in \{\alpha_L, \alpha_h\}$ com $\alpha_h > \alpha_L > 0$, prior $p = \Pr(\alpha_H = \alpha_h)$. W's com $\alpha_W$ conhecido (determinístico, simétrico).

**Notação**:
- $\Delta\alpha \equiv \alpha_h - \alpha_L$ (spread de tipos de H)
- $a_h \equiv \alpha_h^\gamma$, $a_L \equiv \alpha_L^\gamma$, $a_W \equiv \alpha_W^\gamma$ (contribuições transformadas)
- $A_W \equiv (N-1)a_W$ (contribuição agregada dos W's, conhecida)
- $V_L \equiv M(1 - e^{-\lambda(a_L + A_W)})$ (pie com H tipo baixo, coalizão completa)
- $V_H \equiv M(1 - e^{-\lambda(a_h + A_W)})$ (pie com H tipo alto, coalizão completa)
- $V_{\setminus H} \equiv M(1 - e^{-\lambda A_W})$ (pie sem H)

Note que $V_H > V_L > V_{\setminus H}$ (H sempre contribui, e mais quando tipo alto).

### 3.1 Screening sob Unanimidade

Quando W propõe (prob $(N-1)/N$) sob unanimidade, deve incluir H. O proposer W oferece $x_H$ a H e $\alpha_W$ a cada outro W (mínimo para aceitação).

**Duas estratégias**:

**(a) Conservadora** (offer $x_H = \alpha_h$): sempre aceita por ambos tipos de H.

Payoff esperado do proposer W:
$$\Pi^{cons}(\mu) = E_\mu[V] - \alpha_h - (N-2)\alpha_W$$
$$= (1-\mu)V_L + \mu V_H - \alpha_h - (N-2)\alpha_W$$

**(b) Agressiva** (offer $x_H = \alpha_L$): aceita apenas por H tipo $\alpha_L$. H tipo $\alpha_h$ rejeita $\to$ instituição não forma sob unanimidade $\to$ todos recebem outside options.

Payoff esperado do proposer W:
$$\Pi^{agr}(\mu) = (1-\mu)\left[V_L - \alpha_L - (N-2)\alpha_W\right] + \mu \cdot \alpha_W$$

### 3.2 Cutoff de Screening

W prefere agressiva iff $\Pi^{agr}(\mu) > \Pi^{cons}(\mu)$:

$$(1-\mu)(V_L - \alpha_L - (N-2)\alpha_W) + \mu\alpha_W > (1-\mu)V_L + \mu V_H - \alpha_h - (N-2)\alpha_W$$

Simplificando:

$$(1-\mu)(\alpha_h - \alpha_L) > \mu(V_H - \alpha_h - (N-1)\alpha_W)$$

Definindo o **surplus líquido** de cooperação com H tipo alto:
$$\Pi \equiv V_H - \alpha_h - (N-1)\alpha_W = M(1 - e^{-\lambda(a_h + A_W)}) - \alpha_h - (N-1)\alpha_W$$

O cutoff de screening é:

$$\boxed{\mu_s = \frac{\Delta\alpha}{\Delta\alpha + \Pi}}$$

**Condição de existência**: $\mu_s \in (0,1)$ requer $\Pi > 0$, i.e., $M(1 - e^{-\lambda(a_h + A_W)}) > \alpha_h + (N-1)\alpha_W$. O pie com H alto deve exceder a soma de todas as outside options. Isso exige $M$ e $\lambda$ suficientemente grandes.

**Interpretação**: $\mu_s$ cresce com $\Delta\alpha$ (mais heterogeneidade de H $\to$ screening mais frequente) e decresce com $\Pi$ (mais surplus $\to$ conservadora mais atrativa).

### 3.3 Value Function de H

A *value function* de KG é $v(\mu)$: payoff esperado de H (média sobre tipos, ponderada por $\mu$) dado que o receiver (W proposer) tem crença $\mu$.

**Quando $\mu < \mu_s$ (offer agressiva $\alpha_L$):**
- H tipo $\alpha_L$: aceita, recebe $\alpha_L$
- H tipo $\alpha_h$: rejeita, recebe $\alpha_h$
- $v(\mu) = (1-\mu)\alpha_L + \mu\alpha_h = \alpha_L + \mu\Delta\alpha$

**Quando $\mu \geq \mu_s$ (offer conservadora $\alpha_h$):**
- Ambos tipos aceitam, recebem $\alpha_h$
- $v(\mu) = \alpha_h$

**Resultado**: 

$$v(\mu) = \begin{cases} \alpha_L + \mu\Delta\alpha & \text{se } \mu < \mu_s \\ \alpha_h & \text{se } \mu \geq \mu_s \end{cases}$$

**Jump em $\mu_s$**:
$$v(\mu_s^-) = \alpha_L + \mu_s \Delta\alpha < \alpha_h = v(\mu_s)$$
$$\text{Jump} = \Delta\alpha(1 - \mu_s) = \frac{\Delta\alpha \cdot \Pi}{\Delta\alpha + \Pi} > 0$$

A value function é não-côncava $\to$ BP tem valor positivo.

### 3.4 Concavificação e Sinal Ótimo

**Para $p < \mu_s$** (prior abaixo do cutoff — a região onde BP é ativo):

A concavificação de $v(\mu)$ é a reta de $(0, \alpha_L)$ a $(\mu_s, \alpha_h)$:

$$\text{cav } v(\mu) = \alpha_L + \frac{\mu}{\mu_s}\Delta\alpha \quad \text{para } \mu \in [0, \mu_s]$$

**Verificação**: a reta tem inclinação $\Delta\alpha/\mu_s > \Delta\alpha$ (inclinação de $v$ no regime linear), portanto está acima de $v$ em todo $[0, \mu_s)$.

**Sinal ótimo** (binário):
- $s_H$: gera posterior $\mu = \mu_s$ com probabilidade $p/\mu_s$
- $s_L$: gera posterior $\mu = 0$ com probabilidade $1 - p/\mu_s$
- Bayes-plausível: $(p/\mu_s) \cdot \mu_s + (1 - p/\mu_s) \cdot 0 = p$ ✓

**Para $p \geq \mu_s$**: W já faz offer conservadora sem BP. $v(p) = \alpha_h = \text{cav } v(p)$. BP não agrega valor.

### 3.5 Ganho do BP sob Unanimidade

Para $p < \mu_s$:

$$\text{BP gain} = \text{cav } v(p) - v(p) = p\Delta\alpha\left(\frac{1}{\mu_s} - 1\right) = p\Delta\alpha \cdot \frac{\Pi}{\Delta\alpha}$$

$$\boxed{\text{BP gain} = p \cdot \Pi = p \cdot \left[M(1 - e^{-\lambda(a_h + A_W)}) - \alpha_h - (N-1)\alpha_W\right]}$$

O ganho é proporcional a:
- **$p$**: probabilidade de H ser tipo alto
- **$\Pi$**: surplus líquido de cooperação com H alto

**Sobre a (in)dependência de $\Delta\alpha$**: a fórmula $p\Pi$ não contém $\Delta\alpha$ explicitamente. Porém $\Pi$ depende de $\alpha_h$, e $\Delta\alpha = \alpha_h - \alpha_L$. Se $\Delta\alpha$ varia via $\alpha_L$ (mantendo $\alpha_h$ fixo), BP gain é de fato independente. Se varia via $\alpha_h$, $\Pi$ muda. O que $\Delta\alpha$ afeta diretamente é $\mu_s$ — a região onde BP opera ($p < \mu_s$).

---

## 4. Maioria: Exclusão por Discriminação Estatística

### 4.1 Problema de Seleção de Coalizão

Sob maioria ($q = \lceil N/2 \rceil$), o proposer W precisa de $q-1$ votos dos $N-1$ restantes. Pode escolher:

**(a) Incluir H**: coalizão $\{W_{\text{prop}}, H, (q-2) \text{ W's}\}$. Enfrenta screening sobre $\alpha_H$.

**(b) Excluir H**: coalizão $\{W_{\text{prop}}, (q-1) \text{ W's}\}$. Sem adverse selection (W's têm $\alpha_W$ conhecido).

### 4.2 Payoff de Exclusão

$$\Pi^{excl} = V_{\setminus H}^{q} - (q-1)\alpha_W$$

onde $V_{\setminus H}^{q} \equiv M(1 - e^{-\lambda q \cdot a_W})$ é o pie da coalizão de $q$ W's.

### 4.3 Payoff de Inclusão (com screening)

Se W inclui H e usa offer agressiva ($\mu < \mu_s^M$):

$$\Pi^{incl}(\mu) = (1-\mu)\left[V_L^{q} - \alpha_L - (q-2)\alpha_W\right] + \mu\left[V_{\setminus H}^{q} - (q-1)\alpha_W\right]$$

onde $V_L^{q} = M(1 - e^{-\lambda(a_L + (q-1)a_W)})$ é o pie quando H (tipo baixo) é incluído numa coalizão de $q$ membros.

Se W inclui H e usa offer conservadora ($\mu \geq \mu_s^M$):

$$\Pi^{cons,M}(\mu) = E_\mu[V^q(\alpha_H)] - \alpha_h - (q-2)\alpha_W$$

onde $E_\mu[V^q] = (1-\mu) V_L^q + \mu V_H^q$ e $V_H^q = M(1 - e^{-\lambda(a_h + (q-1)a_W)})$.

### 4.4 Condição de Exclusão

Para a offer agressiva, exclusão domina iff:

$$V_{\setminus H}^{q} - (q-1)\alpha_W > (1-\mu)\left[V_L^{q} - \alpha_L - (q-2)\alpha_W\right] + \mu\left[V_{\setminus H}^{q} - (q-1)\alpha_W\right]$$

Simplificando (o termo com $\mu$ cancela):

$$\boxed{V_{\setminus H}^{q} - V_L^{q} > \alpha_W - \alpha_L}$$

Como $\alpha_L > \alpha_W$ (H tem outside option maior que W mesmo quando tipo baixo), o lado direito é negativo. A condição requer que a diferença de V entre excluir e incluir H tipo baixo seja maior que a economia de custo. Isso pode ocorrer quando:
1. O retorno marginal de H é baixo ($V_L^q \approx V_{\setminus H}^q$, retornos decrescentes por $\sigma < 1$)
2. O spread $\alpha_h - \alpha_L$ é grande (offer conservadora é cara)

### 4.5 BP sob Maioria

Se W exclui H: H recebe $\alpha_H$ (outside option). Não há interação com sinal $\to$ **BP não opera**.

Se W inclui H (parâmetros onde inclusão é ótima): screening funciona similarmente, BP opera parcialmente.

**Caso central**: sob maioria e parâmetros com discriminação, H é excluído, BP neutralizado.

---

## 5. Comparação Institucional

### 5.1 Payoff de H sob cada regra

**Unanimidade com BP** ($p < \mu_s$):

$$U_H^U(p) = \frac{1}{N}\left[E[V_{\text{full}}(\alpha_H)] - (N-1)\alpha_W\right] + \frac{N-1}{N}\left[\alpha_L + \frac{p}{\mu_s}\Delta\alpha\right]$$

**Maioria com exclusão**:

$$U_H^M(p) = \frac{1}{N}\left[E[V^q(\alpha_H)] - (q-1)\alpha_W\right] + \frac{N-1}{N} \cdot E[\alpha_H]$$

### 5.2 Quando H Prefere Unanimidade

A condição $U_H^U > U_H^M$ requer que o BP gain no round de W-proposes compense custos. Comparando o termo W-proposes:

$$\frac{p}{\mu_s}\Delta\alpha > E[\alpha_H] = \alpha_L + p\Delta\alpha$$

$$p\Delta\alpha\left(\frac{1}{\mu_s} - 1\right) > \alpha_L$$

$$\boxed{p \cdot \Pi > \alpha_L}$$

O ganho do BP deve exceder a outside option do tipo baixo.

### 5.3 Papel do V Endógeno (Exponencial Saturante)

Com $V(S) = M(1 - e^{-\lambda A(S)})$, a contribuição marginal de H ao pie é:

$$\Delta V_H = M e^{-\lambda A_W}(1 - e^{-\lambda a_h})$$

Essa expressão tem duas propriedades cruciais:
- **Decresce em $A_W$**: quanto mais W's na coalizão, menos H contribui marginalmente ($e^{-\lambda A_W} \to 0$). Isso é o que gera exclusão.
- **Cresce em $a_h$**: H tipo alto contribui mais que tipo baixo.

**Regimes:**
- $A_W$ pequeno ($\lambda A_W \ll 1$): $e^{-\lambda A_W} \approx 1$, H contribui quase o máximo. H pivotal.
- $A_W$ grande ($\lambda A_W \gg 1$): $e^{-\lambda A_W} \approx 0$, H contribui quase nada. V já saturou. Exclusão viável.

A transição é suave, governada por $\lambda A_W$.

---

## 6. Estática Comparativa

### 6.1 Efeito de $\gamma$ (expoente de contribuição)

$\gamma \in (1,2)$ governa a desproporção entre grandes e pequenos jogadores.

- $\gamma \to 1$: US ($\alpha = 0.25$) = 5 países com $\alpha = 0.05$. Sem vantagem de tamanho.
- $\gamma \to 2$: US contribui $0.25^2 = 0.0625$ vs. $5 \times 0.05^2 = 0.0125$. US vale 5x mais.

**Efeito sobre V em nível** (para $\alpha_i < 1$): $\gamma$ maior $\to$ $a_i = \alpha_i^\gamma$ menor $\to$ $A$ menor $\to$ $e^{-\lambda A}$ maior $\to$ $V = M(1-e^{-\lambda A})$ menor. Todos os V's caem.

**Efeito sobre contribuição RELATIVA de H**: $a_h/a_W = (\alpha_h/\alpha_W)^\gamma$ cresce com $\gamma$. H se torna relativamente mais importante.

**Efeito sobre $\Pi$**: ambíguo. $V_H$ cai (nível), mas $V_H - V_{\setminus H}$ pode subir ou cair dependendo de $\lambda$. Com $\lambda$ ajustado, o efeito relativo domina.

### 6.2 Efeito de $\lambda$ (velocidade de saturação)

- $\lambda$ pequeno: V cresce lentamente, longe da saturação. Contribuição marginal de H é significativa mesmo para coalizões grandes. Exclusão rara.
- $\lambda$ grande: V satura rapidamente. Para coalizões de W's com $A_W$ moderado, $V \approx M$. Contribuição marginal de H é ínfima. Exclusão fácil.
- **Sweet spot**: $\lambda$ tal que $\lambda A_W \sim 1$ (coalizão de W's no meio da curva). H é pivotal mas não indispensável.

### 6.3 Efeito de $N$

$N$ entra via $A_W = (N-1)\alpha_W^\gamma$:
- $N$ grande: $A_W$ cresce $\to$ coalizão de W's pode bastar $\to$ H menos pivotal $\to$ exclusão mais provável.
- $N$ pequeno: $A_W$ baixo $\to$ H pivotal $\to$ BP valioso.

### 6.4 Efeito de $\sigma_H^2$ (variância do tipo de H)

No caso binário, $\sigma_H^2 = p(1-p)(\Delta\alpha)^2$.

BP gain = $p \cdot \Pi$ não contém $\Delta\alpha$ explicitamente (ver nota na Seção 3.5). O que $\Delta\alpha$ afeta é $\mu_s$: mais spread $\to$ $\mu_s$ maior $\to$ a região onde BP opera ($p < \mu_s$) é mais ampla.

**Intuição**: H extrai exatamente o surplus $\Pi$ do tipo alto, com probabilidade $p$. O pooling no sinal ajusta as probabilidades para compensar qualquer $\Delta\alpha$.

---

## 7. Worked Example

### Parâmetros

$N = 30$, $\alpha_L = 0.10$, $\alpha_h = 0.50$, $\alpha_W = 0.05$, $\gamma = 1.5$, $M = 3$, $\lambda = 20$, $p = 0.05$.

### Contribuições transformadas

$a_L = 0.10^{1.5} = 0.03162$
$a_h = 0.50^{1.5} = 0.35355$
$a_W = 0.05^{1.5} = 0.01118$
$A_W = 29 \times 0.01118 = 0.32423$

### Pies (coalizão completa, N = 30)

$V_L = 3(1 - e^{-20 \times 0.3559}) = 3(1 - e^{-7.12}) = 2.998$

$V_H = 3(1 - e^{-20 \times 0.6778}) = 3(1 - e^{-13.56}) = 3.000$

$V_{\setminus H} = 3(1 - e^{-20 \times 0.3242}) = 3(1 - e^{-6.48}) = 2.995$

**Saturação**: com $\lambda A_W = 6.48$, a coalizão de 29 W's já está a 99.8% do máximo $M = 3$. H contribui marginalmente quase nada ao V ($V_H - V_{\setminus H} \approx 0.005$), mas custa $\alpha_h = 0.50$.

### Screening sob Unanimidade

$\Pi = V_H - \alpha_h - (N-1)\alpha_W = 3.000 - 0.50 - 1.45 = 1.050$

$\mu_s = 0.40 / (0.40 + 1.050) = 0.276$

$p = 0.05 < \mu_s = 0.276$: **BP ativo.**

**Sem BP**: $v(0.05) = 0.10 + 0.05 \times 0.40 = 0.12$

**Com BP**: $\text{cav } v(0.05) = 0.10 + (0.05/0.276) \times 0.40 = 0.173$

**BP gain** = $p \cdot \Pi = 0.05 \times 1.050 = 0.053$ ✓

**Nota**: $\Pi > 0$ apesar de H contribuir quase nada ao V. O surplus vem de $V_H \approx M = 3$ ser grande o suficiente para cobrir as outside options ($0.50 + 1.45 = 1.95$). O screening é sobre quanto oferecer a H, não sobre se H melhora o pie.

### Maioria ($q = 15$)

**Pie sem H** (coalizão de 15 W's):
$V_{\setminus H}^{q=15} = 3(1 - e^{-20 \times 15 \times 0.01118}) = 3(1 - e^{-3.35}) = 2.895$

**Payoff de exclusão**:
$\Pi^{excl} = 2.895 - 14 \times 0.05 = 2.195$

**Pie com H** (H + 14 W's):
$V_L^{q} = 3(1 - e^{-20 \times 0.1881}) = 2.930$
$V_H^{q} = 3(1 - e^{-20 \times 0.5100}) = 3.000$

**Payoff inclusão conservadora:**
$E[V^q] = 0.95 \times 2.930 + 0.05 \times 3.000 = 2.934$
$\Pi^{cons,M} = 2.934 - 0.50 - 0.65 = 1.784$

**Payoff inclusão agressiva:**
$\Pi^{agr,M} = 0.95 \times [2.930 - 0.10 - 0.65] + 0.05 \times 2.195 = 0.95 \times 2.180 + 0.110 = 2.181$

$$\Pi^{excl} = 2.195 > \Pi^{agr} = 2.181 > \Pi^{cons} = 1.784$$

**EXCLUSÃO DOMINA.** A coalizão de 15 W's já gera $V = 2.895$ (96.5% de $M$). Incluir H acrescenta pouco ao V mas custa pelo menos $\alpha_L = 0.10$ em offer (e arrisca rejeição).

### Payoff de H

**Sob unanimidade com BP:**

$E[V_{\text{full}}] = 0.95 \times 2.998 + 0.05 \times 3.000 = 2.998$

$U_H^U = \frac{1}{30}[2.998 - 1.45] + \frac{29}{30} \times 0.173 = \frac{1.548}{30} + 0.167 = 0.052 + 0.167 = 0.218$

**Sob maioria (H excluído quando W propõe):**

$E[V^q(\alpha_H)] = 0.95 \times 2.930 + 0.05 \times 3.000 = 2.934$ (quando H propõe)

$E[\alpha_H] = 0.95 \times 0.10 + 0.05 \times 0.50 = 0.12$

$U_H^M = \frac{1}{30}[2.934 - 0.70] + \frac{29}{30} \times 0.12 = \frac{2.234}{30} + 0.116 = 0.074 + 0.116 = 0.191$

### Resultado

$$U_H^U = 0.218 > U_H^M = 0.191$$

**H prefere unanimidade.** A diferença ($0.028$) vem do BP gain ($0.053$) no round de W-proposes, parcialmente compensado pelo custo de pagar 29 W's em vez de 14 quando H propõe.

**Interpretação**: V está saturado — a coalizão de W's gera quase o máximo. Sob maioria, W racionalmente exclui H (discriminação estatística: H é caro e contribui pouco marginalmente). Sob unanimidade, a inclusão forçada permite a H extrair renda via BP. O mecanismo funciona não porque H é pivotal para V, mas porque unanimidade obriga o screening — e BP explora o screening.

---

## 8. Extensões (Sketches)

### 8.1 W's com Tipos Privados

Se $\alpha_{W_j} \sim F_W$ é privado:
- **Sob unanimidade**: proposer enfrenta screening de TODOS os jogadores. Cada jogador tem cutoff individual.
- **Sob maioria**: proposer seleciona coalizão. Enfrenta adverse selection leve de cada W (baixa variância). Mas H é high-stakes.
- **Discriminação por grupo**: proposer "discrimina" entre grupo H (alta contribuição, alta incerteza relativa) e grupo W (baixa contribuição, baixa incerteza).

**Analogia trabalhista**: empregador com vagas limitadas ($q-1$ posições) seleciona entre candidatos de dois grupos. Grupo H: alta produtividade média, alto salário de reserva. Grupo W: produtividade menor, mais previsível. Empregador racionalmente discrimina contra H.

### 8.2 Tipos Contínuos

Com $\alpha_H \sim F_H$ contínuo, o screening do proposer vira optimal auction/mechanism design (Myerson 1981). O payoff de H depende do **virtual type** $\phi(\alpha_H) = \alpha_H + F_H(\alpha_H)/f_H(\alpha_H)$.

**Conjectura**: com tipos contínuos, BP explora a curvatura de $V(\alpha_H)$ em vez de um jump discreto.

### 8.3 H com Prior mais Tight sobre W's

H faz offers mais precisas quando propõe $\to$ extrai mais surplus $\to$ beneficia H sob ambas as regras, mas mais sob unanimidade (onde H precisa satisfazer N-1 W's).

### 8.4 Saturação revisitada

O worked example sugere que sem saturação a exclusão é difícil. Opções:
1. **Exponencial saturante**: $V(S) = M(1 - e^{-\lambda A(S)})$. Mantém $V(\emptyset) = 0$, satura em $M$, forçando contribuição marginal de H a zero para coalizões grandes.
2. **Power com cap**: $V(S) = \min\{C \cdot A(S)^\sigma, M\}$. Simples mas não-diferenciável no cap.
3. **Mudar outside option**: $d_H$ fixo e alto (não proporcional a $\alpha_H$), desacoplando custo de inclusão da contribuição ao pie.

---

## 9. Conexão com o Modelo Corrente (v3)

| Dimensão | Modelo v3 | Extensão |
|---|---|---|
| **Tipos** | θ ∈ {0,1} exógeno, H observa | α_i privado de cada jogador |
| **Pie** | V(θ) ∈ {1, r} exógeno | V(S) = C·A(S)^σ endógeno |
| **Outside option** | d_H = αV(θ), d_W = 0 | d_i = α_i |
| **Fonte de não-concavidade** | Screening cutoff μ_s | Mesmo mecanismo (screening sobre α_H) |
| **Mecanismo de exclusão** | W exclui H sob maioria | Discriminação estatística (requer saturação?) |
| **BP gain** | Depende de V_H, screening jump | p·Π = p·[V_H - α_h - (N-1)α_W] |
| **Heterogeneidade** | Ausente | Central: γ, distribuições de α |

**Preservação do mecanismo**: screening → non-concavity → BP → unanimidade ativa poder informacional. O mecanismo central sobrevive com V endógeno.

**Problema identificado**: sem saturação de V, a exclusão sob maioria é difícil de obter. No v3, a exclusão é "mecânica" (W monta coalizão mínima e H é caro por d_H = αV(θ)). Na extensão, H sempre contribui positivamente ao pie, e sem saturação essa contribuição não desaparece. A saturação pode ser necessária para o mecanismo de exclusão.

---

## 10. Barganha Baron-Ferejohn com 2 Rounds e Desconto δ

As seções 3–5 derivaram screening e exclusão sob TITL (take-it-or-leave-it, 1 round). A Seção 4.3 revelou o problema do **free look**: sob maioria com TITL, quando $\alpha_h$ rejeita a offer agressiva, o proposer reformula coalizão de W's no mesmo round sem custo. Com $\gamma > 1$, inclusão agressiva **sempre** domina exclusão — a exclusão não emerge.

Esta seção resolve o problema com o protocolo Baron-Ferejohn padrão: 2 rounds, desconto $\delta \in (0,1)$. A rejeição em R1 leva a R2 descontado — não a reformulação gratuita. O método segue backward induction: R2 (terminal) primeiro, depois R1.

### 10.1 Timing (BF 2 rounds)

Dado que a instituição formou com $N$ membros:

1. **R1**: proposer sorteado (prob $1/N$ cada). Propõe divisão de $V(S)$. Votação sob regra $R$. Se aceito, payoffs realizados. Se rejeitado → R2.

2. **R2 (terminal)**: novo proposer sorteado (prob $1/N$ cada). Propõe divisão. Votação. Se aceito, payoffs realizados (descontados por $\delta$ do ponto de vista de R1). Se rejeitado → **disagreement**: jogador $i$ recebe $\alpha_i$.

**Convenção**: todos os payoffs de R2 são multiplicados por $\delta$ quando avaliados em R1.

### 10.2 R2 (Terminal) sob Unanimidade

O round terminal replica a análise TITL da Seção 3: é o último round, rejeição leva a disagreement.

#### H propõe (prob $1/N$)

Oferece $\alpha_W$ a cada W (mínimo para aceitação: $\alpha_W \geq \alpha_W$, indiferente, aceita por convenção). H guarda $V(\alpha_H) - (N-1)\alpha_W$. Offer idêntica para ambos tipos — **pooling**, não revela $\alpha_H$.

- Tipo $\alpha_L$: guarda $V_L - (N-1)\alpha_W$
- Tipo $\alpha_h$: guarda $V_H - (N-1)\alpha_W$

#### W propõe (prob $(N-1)/N$)

Oferece $\alpha_W$ a cada outro W ($N-2$ pagamentos). Screening subgame com H, idêntico à Seção 3.1:

**Conservadora** ($x_H = \alpha_h$): ambos tipos aceitam. W guarda $V(\alpha_H) - \alpha_h - (N-2)\alpha_W$.

**Agressiva** ($x_H = \alpha_L$): $\alpha_L$ aceita (indiferente: $\alpha_L = \alpha_L$), $\alpha_h$ rejeita ($\alpha_L < \alpha_h$) → disagreement → todos recebem outside option.

#### Cutoff de screening em R2

Idêntico à Seção 3.2:

$$\mu_s^{R2} = \frac{\Delta\alpha}{\Delta\alpha + \Pi}$$

onde $\Pi \equiv V_H - \alpha_h - (N-1)\alpha_W$ é o surplus líquido com H tipo alto.

#### Continuation values de R2 sob unanimidade

Para cada jogador, o valor de R2 é a média sobre quem propõe (prob $1/N$ cada):

**H tipo $\alpha_h$** — recebe $\alpha_h$ de W em ambos os regimes (aceita conservative, rejeita aggressive e recebe $\alpha_h$ de outside option):

$$\boxed{v_h \equiv V_H^{R2,U}(\alpha_h) = \frac{V_H + (N-1)(\alpha_h - \alpha_W)}{N}} \quad \text{(constante em } \mu\text{)}$$

**H tipo $\alpha_L$** — depende do regime:

$$V_H^{R2,U}(\alpha_L, \mu) = \frac{V_L - (N-1)\alpha_W}{N} + \frac{N-1}{N} \times \begin{cases} \alpha_L & \text{se } \mu < \mu_s^{R2} \\[4pt] \alpha_h & \text{se } \mu \geq \mu_s^{R2} \end{cases}$$

Definimos:

$$\boxed{v_L \equiv \frac{V_L + (N-1)(\alpha_L - \alpha_W)}{N}} \qquad \boxed{v_L^{con} \equiv \frac{V_L + (N-1)(\alpha_h - \alpha_W)}{N}}$$

**Jump** em $\mu_s^{R2}$:

$$v_L^{con} - v_L = \frac{(N-1)\Delta\alpha}{N} > 0$$

**Expected H payoff**:

$$E_\mu[V_H^{R2,U}] = \begin{cases} v_L + \mu(v_h - v_L) & \mu < \mu_s^{R2} \quad \text{(linear, inclinação } v_h - v_L\text{)} \\ v_L^{con} + \mu(v_h - v_L^{con}) & \mu \geq \mu_s^{R2} \quad \text{(quase constante, pois } v_h \approx v_L^{con}\text{)} \end{cases}$$

Jump no expected: $(1-\mu_s^{R2}) \cdot \frac{(N-1)\Delta\alpha}{N}$

**W (qualquer $W_j$):**

$$V_W^{R2,U}(\mu) = \frac{1}{N}\Pi_W^{prop}(\mu) + \frac{N-1}{N}\alpha_W$$

onde $\Pi_W^{prop}(\mu)$ é o payoff de W como proposer:

$$\Pi_W^{prop}(\mu) = \begin{cases} (1-\mu)[V_L - \alpha_L - (N-2)\alpha_W] + \mu\alpha_W & \mu < \mu_s^{R2} \\[4pt] E_\mu[V] - \alpha_h - (N-2)\alpha_W & \mu \geq \mu_s^{R2} \end{cases}$$

**W em R2 sob info completa ($\alpha_h$ known, $\mu' = 1$):**

W joga conservadora (offers $\alpha_h$). Payoff como proposer: $V_H - \alpha_h - (N-2)\alpha_W$. Continuation:

$$\boxed{w_h \equiv V_W^{R2,U}(\alpha_h, \text{known}) = \frac{V_H - \alpha_h + \alpha_W}{N}}$$

### 10.3 R2 (Terminal) sob Maioria

Sob maioria em R2 terminal, a proposta requer $q = \lceil N/2 \rceil$ votos. Rejeição → disagreement. **Sem free look.**

#### H propõe (prob $1/N$)

Forma coalizão mínima vencedora: $S = \{H, q-1 \text{ W's}\}$. Oferece $\alpha_W$ a cada W. Guarda $V_H^q(\alpha_H) - (q-1)\alpha_W$.

**Viabilidade**: requer $V_H^q(\alpha_H) > (q-1)\alpha_W$. Com $M$ escalando como $mN$ e $\alpha_W$ fixo, isso requer $mN > (q-1)\alpha_W$, i.e., $m > \frac{q-1}{N}\alpha_W \approx \frac{\alpha_W}{2}$. Para $\alpha_W = 0.02$: $m > 0.01$. Satisfeito com $m = 0.05$.

#### W propõe (prob $(N-1)/N$)

Três opções:

**(a) Exclusão:** $S = \{W_{\text{prop}}, q-1 \text{ W's}\}$. Proposta sempre aprovada.

$$\Pi_W^{excl} = V_{\setminus H}^q - (q-1)\alpha_W$$

**(b) Inclusão conservadora:** $S = \{W_{\text{prop}}, H, q-2 \text{ W's}\}$. Ambos tipos aceitam.

$$\Pi_W^{cons}(\mu) = E_\mu[V^q] - \alpha_h - (q-2)\alpha_W$$

**(c) Inclusão agressiva:** $\alpha_L$ aceita, $\alpha_h$ rejeita → proposta **falha** → disagreement.

$$\Pi_W^{agr}(\mu) = (1-\mu)[V_L^q - \alpha_L - (q-2)\alpha_W] + \mu \cdot \alpha_W$$

**Comparação com TITL (Seção 4.3):** o segundo termo da agressiva era $\mu[V_{\setminus H}^q - (q-1)\alpha_W]$ (free look: W reforma coalizão). Aqui é $\mu\alpha_W$ (disagreement). A diferença é $V_{\setminus H}^q - q\alpha_W \gg 0$.

#### Condição de exclusão em R2

**Exclusão vs. agressiva** ($\Pi_W^{excl} > \Pi_W^{agr}$):

Em $\mu = 0$: $V_{\setminus H}^q - V_L^q > \alpha_W - \alpha_L$, i.e., $\Delta V_L < \alpha_L - \alpha_W$.

**Exclusão vs. conservadora** ($\Pi_W^{excl} > \Pi_W^{cons}$):

$$\alpha_h - \alpha_W > E_\mu[V^q] - V_{\setminus H}^q$$

**Regime de saturação** ($\lambda A_W^q$ grande): $V_L^q \approx V_H^q \approx V_{\setminus H}^q \approx M$. Ambas as condições são satisfeitas: H contribui marginalmente quase nada ao pie, mas custa $\alpha_H$. **W sempre exclui H em R2 sob maioria.**

Assumimos doravante o **regime de saturação** para maioria.

#### Continuation values de R2 sob maioria (regime de exclusão)

$$\boxed{V_H^{R2,M}(\alpha_H) = \frac{V_H^q(\alpha_H) - (q-1)\alpha_W}{N} + \frac{N-1}{N}\alpha_H}$$

$$\boxed{V_W^{R2,M} = \frac{V_{\setminus H}^q + (N-q)\alpha_W}{N}} \quad \text{(constante em } \mu\text{)}$$

**Derivação**: com prob $1/N$, W propõe e guarda $V_{\setminus H}^q - (q-1)\alpha_W$. Com prob $(N-1)/N$, W não propõe e recebe $\alpha_W$ (como membro de coalizão ou outside option). Total: $[V_{\setminus H}^q - (q-1)\alpha_W + (N-1)\alpha_W]/N = [V_{\setminus H}^q + (N-q)\alpha_W]/N$.

Nota: $V_W^{R2,M}$ é constante porque W exclui H sempre — beliefs sobre $\alpha_H$ não afetam a decisão.

### 10.4 R1 sob Unanimidade (backward induction)

Com os continuation values de R2, R1 segue por backward induction. Em BF, a oferta a cada jogador iguala $\delta \times$ seu continuation value de R2.

#### H propõe em R1 (prob $1/N$)

Oferece $\delta V_W^{R2,U}(\mu)$ a cada W. W aceita (indiferente: offer = $\delta \times$ R2 continuation). H guarda:

$$V(\alpha_H) - (N-1)\delta V_W^{R2,U}(\mu)$$

**Pooling**: offer idêntica para ambos tipos (depende de $\mu$, não de $\alpha_H$, pois $V_W^{R2,U}$ é função de $\mu$ apenas).

#### W propõe em R1 (prob $(N-1)/N$)

Oferece $\delta V_W^{R2,U}(\mu)$ a cada outro W ($N-2$ pagamentos). Screening sobre H.

**Offer conservadora:**

$$y_H^{con} = \delta \cdot v_h = \delta \cdot \frac{V_H + (N-1)(\alpha_h - \alpha_W)}{N}$$

Verificação:
- $\alpha_h$: $y_H^{con} = \delta v_h \geq \delta v_h$. Indiferente, aceita. ✓
- $\alpha_L$: $y_H^{con} = \delta v_h > \delta v_L$ (pois $V_H > V_L$ e $\alpha_h > \alpha_L$). Estritamente aceita. ✓

Jogo termina em R1.

**Offer agressiva:**

Após rejeição em R1, W sabe $\alpha_H = \alpha_h$ (apenas $\alpha_h$ rejeita no equilíbrio). Em R2 com info completa ($\mu' = 1 > \mu_s^{R2}$), W joga conservadora: oferece $\alpha_h$.

*Payoff de desvio de $\alpha_L$* (rejeitar agressiva → R2 com beliefs $\mu' = 1$):
- H propõe: guarda $V_L - (N-1)\alpha_W$
- W propõe (crê $\alpha_h$): oferece $\alpha_h$. $\alpha_L$ aceita $\alpha_h$ (overpaid: $\alpha_h > \alpha_L$).

$$V_H^{R2,U}(\alpha_L, \text{dev}) = \frac{V_L + (N-1)(\alpha_h - \alpha_W)}{N} = v_L^{con}$$

**Observação-chave**: $v_L^{dev} = v_L^{con}$. O payoff de desvio de $\alpha_L$ coincide com seu payoff conservador em R2 — em ambos, W oferece $\alpha_h$.

A offer agressiva é:

$$\boxed{y_H^{agg} = \delta \cdot v_L^{dev} = \delta \cdot \frac{V_L + (N-1)(\alpha_h - \alpha_W)}{N}}$$

Verificação:
- $\alpha_L$: $y_H^{agg} = \delta v_L^{dev}$. Desvio dá $\delta v_L^{dev}$. **Indiferente, aceita por convenção.** ✓
- $\alpha_h$: $y_H^{agg} = \delta v_L^{dev} < \delta v_h$ (pois $V_L < V_H$). **Rejeita.** Jogo → R2, info completa. ✓

**Gap de screening em R1:**

$$\delta(v_h - v_L^{dev}) = \frac{\delta(V_H - V_L)}{N} > 0$$

#### Payoffs de W em R1 sob unanimidade

Defina $\omega(\mu) \equiv (N-2)\delta V_W^{R2,U}(\mu)$ (pagamento total aos outros W's em R1).

**Conservadora** (ambos aceitam, jogo termina em R1):

$$F_1^{con}(\mu) = E_\mu[V] - \delta v_h - \omega(\mu)$$

**Agressiva** ($\alpha_L$ aceita em R1; $\alpha_h$ rejeita → R2 com $\delta$, info completa):

$$F_1^{agg}(\mu) = (1-\mu)\bigl[V_L - \delta v_L^{dev} - \omega(\mu)\bigr] + \mu \cdot \delta w_h$$

O primeiro termo: com prob $(1-\mu)$, $\alpha_L$ aceita. W guarda $V_L - y_H^{agg} - \omega(\mu)$.

O segundo termo: com prob $\mu$, $\alpha_h$ rejeita. W recebe $\delta w_h$ (R2 descontado, info completa).

#### Cutoff de screening em R1

$\mu_s^{R1}(\delta)$ resolve $F_1^{agg}(\mu) = F_1^{con}(\mu)$:

$$F_1^{agg} - F_1^{con} = -\mu V_H + \delta\left[\frac{(V_H - V_L) + \mu\bigl(V_L + V_H + (N-2)(\alpha_h - \alpha_W)\bigr)}{N}\right] + \mu\omega(\mu)$$

Em $\mu = 0$: $\delta(V_H - V_L)/N > 0$ → agressiva preferida para $\mu$ baixo.

Em $\mu$ alto: tipicamente negativo → conservadora preferida.

O cutoff $\mu_s^{R1}(\delta)$ existe em $(0,1)$ sob condições padrão. A álgebra é trabalhosa (pois $\omega(\mu)$ depende do regime de R2); resolver numericamente para cada conjunto de parâmetros.

**Comportamento com $\delta$:**
- $\delta \to 0$: R2 não tem valor. $F_1^{agg} \approx (1-\mu)V_L$, $F_1^{con} \approx E_\mu[V]$. Cutoff $\mu_s^{R1} \to 1$ (W sempre joga agressiva — o prêmio da conservadora está em R2, que vale zero).
- $\delta \to 1$: aproxima o caso sem fricção. Cutoff converge para o do TITL.

### 10.5 R1 sob Maioria: Exclusão com δ (resultado central)

**Esta é a seção-chave.** O desconto $\delta$ cria o custo de rejeição que faltava no TITL.

#### Opções do proposer W em R1

**(a) Exclusão:** $S = \{W, q-1 \text{ W's}\}$. Proposta sempre aprovada (sem risco de rejeição).

Oferece $\delta V_W^{R2,M}$ a cada W. Guarda:

$$\Pi_1^{excl} = V_{\setminus H}^q - (q-1)\delta V_W^{R2,M}$$

H recebe $\alpha_H$ (outside option, imediato — sem desconto, pois proposta aprovada em R1).

**(b) Inclusão agressiva:** $S = \{W, H, q-2 \text{ W's}\}$.

Oferece $\delta V_W^{R2,M}$ a cada W, $y_H^{agg,M} = \delta V_H^{R2,M}(\alpha_L)$ a H.

- $\alpha_L$ aceita (indiferente). Proposta aprovada.
- $\alpha_h$ rejeita. Proposta **falha** (precisa de $q$ votos, falta 1). → R2 com desconto $\delta$.

$$\Pi_1^{agr}(\mu) = (1-\mu)\bigl[V_L^q - \delta V_H^{R2,M}(\alpha_L) - (q-2)\delta V_W^{R2,M}\bigr] + \mu \cdot \delta V_W^{R2,M}$$

**(c) Inclusão conservadora:** ambos tipos aceitam.

$$\Pi_1^{cons}(\mu) = E_\mu[V^q] - \delta V_H^{R2,M}(\alpha_h) - (q-2)\delta V_W^{R2,M}$$

#### Decomposição: Benefício vs. Custo

Comparamos exclusão com inclusão agressiva.

**Benefício da inclusão** (quando $\alpha_L$ aceita):

$$B \equiv \bigl[V_L^q - \delta V_H^{R2,M}(\alpha_L) - (q-2)\delta V_W^{R2,M}\bigr] - \bigl[V_{\setminus H}^q - (q-1)\delta V_W^{R2,M}\bigr]$$

$$\boxed{B = \Delta V_L - \delta \cdot \Delta_{net}}$$

onde:
- $\Delta V_L \equiv V_L^q - V_{\setminus H}^q > 0$: contribuição marginal de H tipo baixo ao pie
- $\Delta_{net} \equiv V_H^{R2,M}(\alpha_L) - V_W^{R2,M}$: prêmio de continuation de H sobre W em R2

**Custo da rejeição** (quando $\alpha_h$ rejeita → R2 descontado em vez de exclusão segura):

$$C \equiv \Pi_1^{excl} - \delta V_W^{R2,M}$$

$$\boxed{C = V_{\setminus H}^q - q\delta V_W^{R2,M}}$$

**Condição de exclusão:**

$$\Pi_1^{excl} > \Pi_1^{agr}(\mu) \iff \mu C > (1-\mu) B$$

$$\boxed{\mu > \mu_{excl}(\delta) \equiv \frac{B}{B + C} = \frac{\Delta V_L - \delta\Delta_{net}}{\Delta V_L + V_{\setminus H}^q - \delta(\Delta_{net} + q V_W^{R2,M})}}$$

Para $\mu_{excl} \in (0,1)$: requer $B > 0$ e $C > 0$. $C > 0$ é sempre verdade para $\delta$ não muito próximo de 1. $B > 0$ requer $\Delta V_L > \delta \Delta_{net}$, i.e., a contribuição de H ao pie supera o custo descontado do prêmio de H em R2.

#### Por que o BF resolve o free look

No TITL com free look (Seção 4.3), quando $\alpha_h$ rejeitava, W reformulava coalizão de W's **no mesmo round, sem custo**. O custo de rejeição era:

$$C_{\text{TITL}} = \Pi^{excl} - \Pi^{excl} = 0$$

Com $C = 0$: $\Pi_1^{excl} - \Pi_1^{agr} = -(1-\mu)B < 0$ para todo $\mu$. Inclusão **sempre** domina.

No BF: $C = V_{\setminus H}^q - q\delta V_W^{R2,M} > 0$. A rejeição é custosa — W perde o pie inteiro e recebe apenas $\delta V_W^{R2,M}$ (R2 descontado). Para $\mu$ suficientemente alto (risco de $\alpha_h$ grande), o custo esperado da rejeição supera o benefício da inclusão.

**Magnitudes**: no worked example ($V_{\setminus H}^q = 4.720$, $q\delta V_W^{R2,M} = 2.326$), $C = 2.394$. Massivo comparado com $B = 0.059$. O free look escondia este custo.

### 10.6 Estática Comparativa de δ

**$\delta \to 0$ (desconto extremo):**

$$B \to \Delta V_L, \qquad C \to V_{\setminus H}^q$$

$$\mu_{excl} \to \frac{\Delta V_L}{\Delta V_L + V_{\setminus H}^q}$$

Tipicamente muito pequeno, pois $V_{\setminus H}^q \gg \Delta V_L$ (pie total muito maior que contribuição marginal de H). **Exclusão para quase todo $\mu > 0$.**

**$\delta \to 1$ (sem desconto):**

$$B \to \Delta V_L - \Delta_{net}, \qquad C \to V_{\setminus H}^q - q V_W^{R2,M}$$

Exclusão é mais difícil mas não impossível: requer saturação forte ($\Delta V_L$ pequeno) E $\Delta_{net}$ moderado.

**Predição empírica**: $\delta$ baixo (fricção alta) $\to$ mais exclusão sob maioria $\to$ maior valor da unanimidade para H. Organizações com barganha lenta e custosa (WTO, ONU) favorecem unanimidade mais do que organizações com renegociação rápida.

### 10.7 Value Function e BP sob BF 2 Rounds

#### Payoff de H sob unanimidade

Quando W propõe em R1:

$$E_\mu[\text{payoff de H} \mid W \text{ propõe}] = \begin{cases} (1-\mu)\delta v_L^{dev} + \mu\delta v_h = \delta[v_L^{dev} + \mu(v_h - v_L^{dev})] & \mu < \mu_s^{R1} \\[4pt] \delta v_h & \mu \geq \mu_s^{R1} \end{cases}$$

**Jump** em $\mu_s^{R1}$:

$$\delta v_h - \delta[v_L^{dev} + \mu_s^{R1}(v_h - v_L^{dev})] = \delta(1-\mu_s^{R1})(v_h - v_L^{dev}) = \frac{\delta(1-\mu_s^{R1})(V_H - V_L)}{N}$$

Quando H propõe: $V(\alpha_H) - (N-1)\delta V_W^{R2,U}(\mu)$, que é contínuo (nenhum jump).

**Value function completa:**

$$v(\mu) = \frac{1}{N}\bigl[E_\mu[V] - (N-1)\delta V_W^{R2,U}(\mu)\bigr] + \frac{N-1}{N} \times \begin{cases} \delta[v_L^{dev} + \mu(v_h - v_L^{dev})] & \mu < \mu_s^{R1} \\[4pt] \delta v_h & \mu \geq \mu_s^{R1} \end{cases}$$

A não-concavidade em $\mu_s^{R1}$ é a fonte do BP gain. A concavificação segue o procedimento padrão de KG.

#### Payoff de H sob maioria (com exclusão)

$$v^M(\mu) = \frac{1}{N}\bigl[E_\mu[V_H^q(\alpha_H)] - (q-1)\delta V_W^{R2,M}\bigr] + \frac{N-1}{N}E_\mu[\alpha_H]$$

$$= \frac{1}{N}\bigl[(1-\mu)V_L^q + \mu V_H^q - (q-1)\delta V_W^{R2,M}\bigr] + \frac{N-1}{N}[\alpha_L + \mu\Delta\alpha]$$

**Linear em $\mu$** → $\text{cav } v^M = v^M$ → **BP não opera sob maioria.**

#### Resumo

O mecanismo central sobrevive com BF 2 rounds:
1. **Unanimidade**: screening em R1 → jump em $v(\mu)$ → concavificação → BP gain > 0
2. **Maioria**: exclusão (viabilizada por $\delta$) → sem screening → $v^M$ linear → BP gain = 0
3. H prefere unanimidade quando o BP gain compensa os custos

O $\delta$ tem papel **duplo**: (i) viabiliza exclusão sob maioria e (ii) reduz o jump sob unanimidade (multiplica por $\delta$). O efeito líquido é positivo: sem $\delta$, não há exclusão e o mecanismo colapsa.

### 10.8 Worked Example (BF 2 rounds)

**Parâmetros:** $N = 100$, $q = 51$, $\alpha_L = 0.10$, $\alpha_h = 0.50$, $\alpha_W = 0.02$, $\gamma = 1.5$, $M = 5$ ($m = 0.05$), $\lambda = 20$, $\delta = 0.8$, $p = 0.10$.

#### Contribuições transformadas

$a_L = 0.10^{1.5} = 0.03162$, $a_h = 0.50^{1.5} = 0.35355$, $a_W = 0.02^{1.5} = 0.002828$.

$A_W = 99 \times 0.002828 = 0.2800$.

#### Pies (coalizão completa, $N = 100$)

$V_L = 5(1 - e^{-20 \times 0.3116}) = 5(1 - e^{-6.232}) = 5 \times 0.998 = 4.990$

$V_H = 5(1 - e^{-20 \times 0.6336}) = 5(1 - e^{-12.671}) \approx 5.000$

$V_{\setminus H} = 5(1 - e^{-20 \times 0.2800}) = 5(1 - e^{-5.600}) = 5 \times 0.996 = 4.982$

**Saturação**: com $\lambda A_W = 5.6$, a coalizão de 99 W's está a 99.6% de $M = 5$. H contribui marginalmente quase nada.

#### Pies ($q$-coalizão, $q = 51$)

$V_{\setminus H}^q = 5(1 - e^{-20 \times 51 \times 0.002828}) = 5(1 - e^{-2.884}) = 5 \times 0.944 = 4.720$

$V_L^q = 5(1 - e^{-20 \times 0.1730}) = 5(1 - e^{-3.461}) = 5 \times 0.969 = 4.843$

$V_H^q = 5(1 - e^{-20 \times 0.4950}) = 5(1 - e^{-9.900}) \approx 5.000$

$\Delta V_L = V_L^q - V_{\setminus H}^q = 4.843 - 4.720 = 0.123$

#### R2 continuation values (unanimidade)

$\Pi = V_H - \alpha_h - (N-1)\alpha_W = 5.000 - 0.50 - 1.98 = 2.52$

$\mu_s^{R2} = 0.40/(0.40 + 2.52) = 0.137$

$v_h = [5.000 + 99 \times 0.48]/100 = 52.52/100 = 0.5252$

$v_L = [4.990 + 99 \times 0.08]/100 = 12.91/100 = 0.1291$

$v_L^{con} = v_L^{dev} = [4.990 + 99 \times 0.48]/100 = 52.51/100 = 0.5251$

$w_h = [5.000 - 0.50 + 0.02]/100 = 4.52/100 = 0.0452$

**Jump** em $\mu_s^{R2}$: $v_L^{con} - v_L = 0.5251 - 0.1291 = 0.396$

#### R2 continuation values (maioria, regime de exclusão)

$V_W^{R2,M} = [4.720 + (100-51) \times 0.02]/100 = [4.720 + 0.98]/100 = 0.05700$

$V_H^{R2,M}(\alpha_L) = (4.843 - 50 \times 0.02)/100 + (99/100) \times 0.10 = 0.03843 + 0.099 = 0.1374$

$V_H^{R2,M}(\alpha_h) = (5.000 - 1.00)/100 + (99/100) \times 0.50 = 0.04000 + 0.495 = 0.5350$

#### Condição de exclusão (R1 sob maioria)

$\Delta_{net} = V_H^{R2,M}(\alpha_L) - V_W^{R2,M} = 0.1374 - 0.0570 = 0.0804$

$B = \Delta V_L - \delta \Delta_{net} = 0.123 - 0.8 \times 0.0804 = 0.123 - 0.064 = 0.059$

$C = V_{\setminus H}^q - q\delta V_W^{R2,M} = 4.720 - 51 \times 0.8 \times 0.0570 = 4.720 - 2.326 = 2.394$

$$\mu_{excl} = \frac{0.059}{0.059 + 2.394} = \frac{0.059}{2.453} = 0.024$$

**Com $p = 0.10 > \mu_{excl} = 0.024$: W exclui H sob maioria.** ✓

#### Verificação: TITL com free look

Sob TITL, o benefício da inclusão agressiva era:

$$B_{\text{TITL}} = \Delta V_L + \alpha_W - \alpha_L = 0.123 + 0.02 - 0.10 = 0.043 > 0$$

Com $C_{\text{TITL}} = 0$: inclusão **sempre** domina exclusão. O free look tornava a rejeição gratuita.

No BF com $\delta = 0.8$: $C = 2.394$ domina $B = 0.059$. A rejeição custa $C = 2.394$ (perder o pie e receber apenas $\delta V_W^{R2,M} = 0.046$). **O BF resolve o free look.**

#### BP sob unanimidade

Para $p = 0.10 < \mu_s^{R2} = 0.137$, o BP gain no R2 standalone é:

$v(p) = v_L + p(v_h - v_L) = 0.1291 + 0.10 \times 0.3961 = 0.1687$

$\text{cav } v(p) = v_L + \frac{p}{\mu_s^{R2}} \times (v_h - v_L) = 0.1291 + \frac{0.10}{0.137} \times 0.3961 = 0.1291 + 0.289 = 0.418$

$\text{BP gain} = 0.418 - 0.169 = 0.249 \approx p \times \Pi \times \frac{N-1}{N} = 0.10 \times 2.52 \times 0.99 = 0.249$ ✓

(O fator $(N-1)/N$ vem da prob de W propor; quando H propõe, não há screening.)

**Nota**: este é o BP gain no R2 standalone (benchmark TITL). No R1 com $\delta$, o jump e o cutoff mudam, mas a lógica é idêntica e o BP gain permanece positivo. Resolver $\mu_s^{R1}(\delta)$ numericamente para o valor exato.

#### Payoff de H: unanimidade vs. maioria (benchmark TITL)

Os payoffs abaixo usam a **estrutura TITL** (R2 como jogo único) como benchmark. No BF completo, H propõe oferecendo $\delta V_W^{R2}$ (não $\alpha_W$), o que reduz $U_H^M$ e **fortalece** a preferência de H por unanimidade. O benchmark é conservador.

**Sob unanimidade com BP (R2 benchmark):**

$U_H^U \approx \frac{1}{N}[E[V] - (N-1)\alpha_W] + \frac{N-1}{N} \times \text{cav } v(p) = \frac{1}{100}[4.991 - 1.98] + \frac{99}{100} \times 0.418 = 0.030 + 0.414 = 0.444$

**Sob maioria (H excluído quando W propõe, benchmark TITL):**

$U_H^M = \frac{1}{N}[E[V_H^q] - (q-1)\alpha_W] + \frac{N-1}{N} E[\alpha_H]$

$E[V_H^q] = 0.90 \times 4.843 + 0.10 \times 5.000 = 4.859$

$E[\alpha_H] = 0.90 \times 0.10 + 0.10 \times 0.50 = 0.14$

$U_H^M = \frac{1}{100}[4.859 - 1.00] + \frac{99}{100} \times 0.14 = 0.039 + 0.139 = 0.177$

$$\boxed{U_H^U = 0.444 > U_H^M = 0.177}$$

**H prefere unanimidade.** A diferença (0.267) vem quase inteiramente do BP gain (0.249) no round de W-proposes. Sob maioria, H é excluído e recebe apenas $E[\alpha_H] = 0.14$; sob unanimidade, BP amplia o payoff para 0.418.

#### Sensibilidade a δ

| $\delta$ | $B$ | $C$ | $\mu_{excl}$ | Exclusão? ($p = 0.10$) |
|---|---|---|---|---|
| 0.3 | 0.099 | 3.849 | 0.025 | Sim |
| 0.5 | 0.083 | 3.265 | 0.025 | Sim |
| 0.8 | 0.059 | 2.394 | 0.024 | Sim |
| 0.95 | 0.047 | 1.960 | 0.023 | Sim |
| 1.0 | 0.043 | 1.813 | 0.023 | Sim |

**Nota**: para estes parâmetros (saturação forte), a exclusão ocorre para todos os $\delta \in (0,1]$. O regime de saturação já garante $\Delta V_L$ pequeno; o $\delta$ reforça mas não é estritamente necessário. O papel do $\delta$ é mais importante quando $\lambda$ é menor (saturação parcial), caso em que $\Delta V_L$ é maior e exclusão requer $\delta$ suficientemente baixo.

### 10.9 Entry com V Endógeno: Complementaridade, Multiplicidade e BP como Coordenação (sketch exploratório)

> **Status**: ideia inicial, a ser validada. Questões em aberto marcadas com (?).

#### O problema

No v3, $V(\theta)$ é exógeno — a decisão de entry de cada W não afeta o pie. Na extensão, $V(S) = M(1 - e^{-\lambda A(S)})$ depende de *quem* entra. Entry de W's adicionais aumenta $A(S)$, aumenta $V$, e melhora o payoff de quem já entrou. Entry decisions são **complementos estratégicos**.

#### Estrutura formal (tentativa)

Jogo de entry simultâneo. Cada $W_j$ escolhe $a_j \in \{0, 1\}$ (entrar ou não). Payoff:

$$u_j(a_j, a_{-j}, \mu, R) = a_j \cdot \bigl[V_W^{R1}(\mu, R, n) - \alpha_W - c\bigr] + (1 - a_j) \cdot 0$$

onde $n = \sum_k a_k$ é o número de entrantes e $V_W^{R1}(\mu, R, n)$ é o continuation value de W quando $n$ W's entraram.

**Complementaridade**: $\partial V_W / \partial n > 0$ (?) — mais W's entram → $A(S)$ maior → $V(S)$ maior → $V_W$ maior. Se verdadeiro, $u_j$ tem diferenças crescentes em $(a_j, n)$: jogo **supermodular** no lattice $\{0,1\}^{N-1}$.

#### Multiplicidade de equilíbrios (Topkis/Milgrom-Roberts)

Jogos supermodulares em lattice têm equilíbrio de Nash puro em estratégias puras, e o conjunto de equilíbrios tem um **menor** e um **maior** equilíbrio (Topkis 1998, Thm 4.2.2; Milgrom & Roberts 1990, Thm 5):

- **Equilíbrio alto** ($n^*_H$): muitos W's entram → $V$ alto → entry justificado → self-confirming.
- **Equilíbrio baixo** ($n^*_L$): poucos W's entram → $V$ baixo → entry não justificado → self-confirming.

A multiplicidade é **genérica** (não artefato de parâmetros específicos). Para priors intermediários, ambos os equilíbrios coexistem.

#### Questões-chave (a explorar)

**Q1: A complementaridade é estrita?**

$\partial V_W^{R1} / \partial n > 0$ requer que adicionar um W à coalizão aumente $V_W$ para os demais. Com V côncavo em $A$ (retornos decrescentes) e propostas BF, o efeito sobre V é positivo mas decrescente. O efeito sobre $V_W$ per capita é ambíguo: V cresce, mas a divisão é por mais jogadores.

No v3, $V_W \sim (1-\alpha)V_e(\mu)/N \sim O(1/N)$: V_W decresce em N. Isso **destrói** complementaridade. Com V endógeno, V(N) cresce, mas V/N pode cair.

**(??) Se $V_W$ decresce em $n$ (substituibilidade estratégica), o jogo não é supermodular.** A multiplicidade dependeria de se a curva de best-response é suficientemente steep. Verificar para os parâmetros do modelo.

**Q2: A regra de votação afeta a seleção de equilíbrio?**

Se multiplicidade existe:
- Sob **unanimidade**: $V_W$ menor → equilíbrio alto é mais frágil (threshold mais alto). Bacia de atração do equilíbrio baixo é maior (?).
- Sob **maioria**: $V_W$ maior → equilíbrio alto é mais robusto.

Possível resultado: unanimidade **amplia** a região de falha de coordenação. Isso enfraqueceria o caso a favor de unanimidade — a menos que BP resolva o problema.

**Q3: BP como dispositivo de coordenação?**

No v3, BP faz duas coisas: (1) induz entry e (2) explora screening. Com multiplicidade, BP poderia fazer uma terceira: **selecionar o equilíbrio alto**.

Mecanismo conjecturado: H envia sinal $s_H$ ("α_H é alto"). W's atualizam: $\mu$ alto → $V(S)$ alto em expectativa → entry mais atrativo → coordenação no equilíbrio alto. O sinal de H funciona como *sunspot* focal.

Mas isso requer que o sinal de H seja **crível** (commitment, KG framework) e que afete V suficientemente (o que requer que H contribua significativamente ao pie — tensão com o regime de saturação onde H é marginal).

**(??) Se V é saturado e H é marginal, o sinal sobre α_H tem efeito negligível sobre V(S). O canal de coordenação via V seria fraco.** O BP funcionaria via screening (como no v3), não via coordenação.

**Q4: Scaling resolve a multiplicidade?**

Com $N$ grande e $c = \tilde{c}/N$ (per capita), cada W é atomístico. Entry torna-se decisão contra um "campo médio" $\bar{n}$. O jogo supermodular em lattice discreto converge para um jogo de campo médio com possivelmente **dois pontos fixos estáveis** (alto e baixo).

Mas se $V_W \sim O(1/N)$ e $c \sim O(1/N)$, o threshold $\tau$ é um cutoff em $\mu$ que não depende de $n$ no limite (cada W é pequeno demais para afetar V). Nesse caso, a multiplicidade **desaparece** no limite $N \to \infty$: entry é efetivamente uma decisão individual contra um ambiente exógeno.

**(??) Se N grande elimina a complementaridade, entry na extensão colapsa para o caso do v3** (threshold $\tau$, sem multiplicidade). A complicação de V endógeno seria de segunda ordem.

#### Avaliação preliminar

| Cenário | Complementaridade? | Multiplicidade? | Relevância para o paper? |
|---|---|---|---|
| N pequeno (~5), V não saturado | Possivelmente sim | Sim (Topkis) | Interessante mas fora do target ($N \sim 100$) |
| N grande (~100), V saturado | Provavelmente não (V_W ~ O(1/N)) | Não (campo médio) | **Entry ~ v3, sem complicação** |
| N moderado (~20), V parcialmente saturado | Ambíguo | A verificar | Caso mais rico, potencial para paper |

**Direção tentativa**: para $N \sim 100$ (sistema internacional), entry provavelmente **não** tem multiplicidade relevante. O modelo se comporta como v3 com threshold $\tau(R)$ e BP induzindo entry. A complementaridade estratégica e multiplicidade à la Topkis seriam relevantes para $N$ pequeno (clubs, regionais).

Se isso se confirmar, a seção de entry pode seguir a estrutura do v3 com nota de que V endógeno cria complementaridade em princípio, mas o efeito é de segunda ordem para $N$ grande.

**Próximo passo**: verificar numericamente $\partial V_W / \partial n$ para os parâmetros do worked example. Se $V_W$ é decrescente em $n$, a preocupação com multiplicidade é secundária.

---

## 11. Questões Abertas

1. ~~**Saturação**: a power function não gera exclusão facilmente.~~ **Resolvido** (Seções 8.4 + 10): exponencial saturante + BF com δ.

2. **Tipos contínuos**: derivar formalmente com Myerson.

3. ~~**BF com 2 rounds**: continuation values com tipos privados.~~ **Resolvido** (Seção 10): backward induction completo, exclusão emerge.

4. **Commitment**: antes ou depois de observar $\alpha_H$? Cheap talk vs. commitment.

5. **Heterogeneidade entre W's (tiers)**: middle powers com $\alpha_M$ intermediário.

6. **Welfare**: unanimidade é Pareto superior com V endógeno?

7. **Verificação empírica**: composição de coalizões em IOs, papel de países pivotais.

8. **Saturação parcial**: computar worked example com $\lambda$ menor onde exclusão requer $\delta$ suficientemente baixo (nem só saturação). Mapear a fronteira $(\lambda, \delta)$.

9. **R1 cutoff numérico**: resolver $\mu_s^{R1}(\delta)$ numericamente para os parâmetros do worked example. Verificar BP gain completo (com R1 + R2, não só R2 benchmark).

10. **Entry e complementaridade**: verificar numericamente $\partial V_W / \partial n$. Se $V_W$ é decrescente em $n$ (como no v3), entry não gera multiplicidade para $N$ grande e a análise colapsa para o caso standard. Se $V_W$ é crescente para algum intervalo, explorar multiplicidade à la Topkis e papel de BP como seleção de equilíbrio. Ver Seção 10.9.

---

## 12. Referências-chave

### Discriminação estatística
- Phelps (1972) — Statistical theory of racism and sexism
- Arrow (1973) — Discrimination in labor markets
- Coate & Loury (1993) — Self-fulfilling prophecies of discrimination
- Cornell & Welch (1996) — Culture, information and screening discrimination

### Bayesian Persuasion com tipos privados
- Kolotilin (2018) — Optimal information disclosure
- Kolotilin, Mylovanov, Zapechelnyuk & Li (2017) — Persuasion of a privately informed receiver
- Guo & Shmaya (2019) — The interval structure of optimal disclosure

### Barganha com informação incompleta
- Myerson (1981) — Optimal auction design
- Cramton (1992) — Strategic delay in bargaining with two-sided uncertainty

### Supermodularidade
- Topkis (1998) — Supermodularity and complementarity
- Milgrom & Roberts (1990) — Rationalizability in supermodular games

### Cooperação internacional
- Barrett (1994) — Self-enforcing international environmental agreements
- Maggi & Morelli (2006) — Self-enforcing voting in international organizations
