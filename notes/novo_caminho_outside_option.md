# Novo Caminho: Outside Option como Informação Privada + Bayesian Persuasion

**Data**: 2026-04-06
**Status**: EXPLORATÓRIO — não formalizado ainda

---

## 1. Problema do modelo atual (v4)

O modelo atual (BF com pie size ω ∈ {L, H}) sofre de **linearidade fundamental**:

- Sob unanimidade, o payoff do Sender é **δω/N** — determinado pelo estado verdadeiro, não pelas crenças
- Como o payoff depende apenas de ω (que S conhece), nenhuma estrutura de sinais altera E[payoff]
- BP tem valor zero sob unanimidade (Prop 2: "Neutralidade Informacional")
- O Curse of Knowledge (Prop 1) segue de contagem aritmética, não de tradeoff estratégico
- A não-linearidade necessária para BP ter valor positivo **não existe** no modelo

**Diagnóstico técnico**: com utilidade risk-neutral e transferências contínuas, o payoff do Sender é linear nas crenças sobre qualquer parâmetro que entra linearmente na reserva dos jogadores. Isso vale tanto para pie size quanto para outside option em modelos ingênuos.

## 2. Por que trocar pie size por outside option não basta

Substituir incerteza sobre ω (pie size) por incerteza sobre b (outside option) **não resolve automaticamente** a linearidade:

- Se o Receiver é risk-neutral: V_R(μ) = E[b|μ] = μb_H + (1−μ)b_L → linear
- Se o Sender controla sinal **E** oferta: ajusta x a cada posterior → lineariza
- Se o outside option é automático (sem escolha de exercício): mesmo problema

A linearidade vem da **estrutura do jogo**, não da fonte de incerteza.

## 3. O que funciona: informação privada + screening do proponente

### Mecanismo-chave

A não-linearidade emerge quando:

1. **S conhece b** (informação privada sobre sua own outside option)
2. **Outro jogador propõe** (S não controla a oferta)
3. O proponente enfrenta um **problema de screening**: oferecer alto (b_H, seguro) ou baixo (b_L, arriscado)
4. A **decisão binária** do proponente (screen vs. pool) é uma **função-degrau** das crenças sobre b
5. Essa descontinuidade cria não-linearidade → BP tem valor positivo para S

### Por que funciona

No modelo com pie size:
- S sabe ω → reserva de S = δω/N → determinada pelo estado verdadeiro
- Nenhum sinal muda δω/N

No modelo com outside option como info privada:
- S sabe b → mas o **payoff de S depende da ação do proponente** (oferta alta vs. baixa)
- Quando o proponente oferece b_H, S recebe b_H **mesmo quando b = b_L** (renda informacional)
- O payoff de S depende da **interação estado × ação do proponente**, não só do estado

A diferença técnica fundamental: **o payoff de S não é mais função apenas do estado verdadeiro, mas também da ação endógena de outro jogador, que depende das crenças**.

## 4. Exemplo numérico: 2 jogadores, TITL

### Setup

- P1 (proponente) oferece x a P2 (Sender, conhece b)
- P2: Aceita → (1−x, x) | Rejeita → (0, b)
- b ∈ {b_L=0.2, b_H=0.6}, prior p = Pr(b_H) = 0.3
- P2 comete-se a sinal π(s|b) antes de b ser realizado (BP com commitment)

### Limiar de screening do proponente

P1 escolhe entre:
- Oferecer b_H = 0.6: sempre aceito, P1 ganha 0.4
- Oferecer b_L = 0.2: aceito só se b = b_L (prob 1−μ), P1 ganha (1−μ) × 0.8

P1 prefere screening iff (1−μ) × 0.8 > 0.4, i.e., μ < μ* = 0.5

### Payoff de S (P2) como função das crenças μ

```
v(μ) = { E[b|μ] = 0.2 + 0.4μ    se μ < 0.5  (proponente faz screening)
        { b_H = 0.6               se μ ≥ 0.5  (proponente faz pooling)
```

v tem um **salto para cima** em μ* = 0.5:
- v(0.5⁻) = 0.2 + 0.4×0.5 = 0.4
- v(0.5⁺) = 0.6
- Salto = 0.2

Isso torna v **não-côncava** → concavificação estrita → BP tem valor positivo.

### Sem BP (prior p = 0.3 < μ* = 0.5)

Proponente faz screening (oferece b_L = 0.2):
- b = b_L (prob 0.7): S recebe 0.2 (aceita)
- b = b_H (prob 0.3): S recebe 0.6 (rejeita, exerce outside option)
- **E[P2] = 0.32**

### Com BP ótimo

Sinal ótimo: dividir prior em μ₁ = 0 e μ₂ = 0.5 (= μ*)

Estrutura do sinal:
- Quando b = b_L: revela com prob 4/7 (s_L), esconde com prob 3/7 (s_H)
- Quando b = b_H: sempre envia s_H

Resultados por sinal:
- s_L (prob 0.4): μ = 0, proponente oferece 0.2. S recebe 0.2.
- s_H (prob 0.6): μ = 0.5 = μ*, proponente oferece 0.6. S recebe **0.6 independente do verdadeiro b**.

**E[P2] = 0.4 × 0.2 + 0.6 × 0.6 = 0.44**

### Ganho de BP

**Δ = 0.44 − 0.32 = 0.12 = p(1 − b_H) = 0.3 × 0.4**

Aumento de 37.5% no payoff de S.

### Interpretação

S sacrifica transparência em alguns estados (revela b_L quando é baixo) para tornar o sinal de "não-revelação" (s_H) crível o suficiente para empurrar μ até μ*. Quando s_H é realizado, metade das vezes b é na verdade b_L — e S recebe 0.6 mesmo assim. Essa é a **renda informacional**.

## 5. Extensão para N jogadores: unanimidade vs. maioria

### Setup BF com outside option

- N jogadores, um deles é S (Sender, conhece b)
- b ∈ {b_L, b_H}: outside option de S (valor de sair da barganha)
- S comete-se a sinal público π(s|b) antes do jogo
- Reconhecimento aleatório (prob 1/N cada)
- Proposta divide pie de tamanho 1

### Quando S propõe (prob 1/N)

S controla sinal **E** oferta → linearização → BP não agrega valor neste round.

### Quando outro jogador propõe (prob (N−1)/N)

O proponente precisa incluir S na coalizão (ou não). Dois regimes:

**Sob unanimidade**: proponente **deve** incluir S → enfrenta problema de screening sobre b → decisão binária do proponente (oferta alta vs. baixa) → **BP tem valor positivo para S**.

**Sob maioria (N ≥ 3)**: proponente **pode excluir** S da coalizão → escolhe parceiros uninformed (sem adverse selection, mais baratos) → **BP é inútil** porque S está fora.

### Resultado esperado

- **Sob unanimidade**: poder informacional de S opera em (N−1)/N dos rounds. BP tem valor positivo crescente com N.
- **Sob maioria**: S é excluído (Curse of Knowledge reinterpretado). BP tem valor zero.
- **S prefere unanimidade**: garante inclusão + ativa poder informacional.

### Conexão com a intuição OMC

- EUA (Sender) têm vantagem analítica → info privada sobre b (custo de "no deal")
- Sob unanimidade/consenso: EUA não podem ser excluídos, BP extrai renda informacional
- Sob maioria: EUA seriam excluídos (muito caros) apesar de sua info
- **Consenso maximiza o retorno da vantagem informacional ao menor custo**
- EUA aceitam abrir mão do poder de proposta porque o poder informacional é mais valioso sob unanimidade

## 6. Fórmula geral do ganho de BP (2 jogadores, TITL)

Para b_L < b_H, prior p, limiar μ* = (b_H − b_L)/(1 − b_L):

- Se p < μ*: **BP gain = p(1 − b_H)**
- Se p ≥ μ*: BP gain = 0 (proponente já oferece alto)

Concavificação de v(μ):
```
cav(v)(μ) = b_L + μ(b_H − b_L)/μ*   para μ ∈ [0, μ*]
cav(v)(μ) = b_H                       para μ ∈ [μ*, 1]
```

Sinal ótimo: dividir em μ₁ = 0, μ₂ = μ* com pesos λ = 1 − p/μ*, 1−λ = p/μ*.

## 7. Comparação com o modelo v4 (pie size)

| Dimensão | Modelo v4 (pie size ω) | Novo caminho (outside option b) |
|---|---|---|
| **Fonte de incerteza** | Tamanho da pie ω ∈ {L,H} | Outside option de S: b ∈ {b_L, b_H} |
| **Info privada de S** | S sabe ω | S sabe b |
| **Payoff de S sob unanimidade** | δω/N (determinado por estado) | Depende da ação do proponente |
| **BP sob unanimidade** | Valor zero (linearidade) | **Valor positivo** (screening cria não-linearidade) |
| **Mecanismo de exclusão sob maioria** | Contagem aritmética (S caro) | Adverse selection (S cria problema de screening) |
| **Curse of Knowledge** | Mecânico (aritmético) | **Estratégico** (proponente evita adverse selection) |
| **Resultado institucional** | S prefere unanimidade (escapa exclusão) | S prefere unanimidade (escapa exclusão **+** ativa BP) |
| **Riqueza do tradeoff** | Não há tradeoff; exclusão é automática | Tradeoff entre custo de screening e benefício de incluir S |

## 8. Comparação com Prop 4 do modelo v4 (surplus destruction β > 0)

A Prop 4 do modelo v4 já tentava resolver o problema de linearidade introduzindo um parâmetro exógeno β de destruição de surplus quando propostas infeasíveis falham. Vale comparar sistematicamente.

### Como a Prop 4 funciona

- Quando c > ω (proposta agressiva, estado baixo), fração β do surplus é destruída
- O payoff de S passa a ter dois segmentos: V_safe(μ) = δE[ω|μ]/N vs. V_agg(μ) = μδH/N + (1−μ)δ(1−β)L/N
- O proponente troca de safe para agressivo em μ*, criando kink
- Sinal ótimo: **full revelation** (μ ∈ {0, 1})
- BP gain = (N−1)(1−p)δβL/N²

### Comparação

| Dimensão | Prop 4 (β > 0) | Novo caminho (outside option) |
|---|---|---|
| **Fonte de não-linearidade** | Destruição exógena de surplus (β) | Screening endógeno do proponente |
| **Parâmetro extra** | Sim (β > 0, arbitrário) | Não (info privada é padrão em barganha) |
| **Não-linearidade em β=0** | Desaparece (volta linearidade) | **Persiste** (inerente ao modelo) |
| **Sinal ótimo** | Full revelation | **Partial revelation** (genuína persuasão) |
| **Propósito do BP** | Evitar desperdício (cooperativo) | Extrair renda informacional (estratégico) |
| **Natureza do mecanismo** | S corrige erro do proponente | S explora incerteza do proponente |
| **Avaliação do próprio paper v4** | "Secondary channel" | Seria canal primário |
| **Tradeoff estratégico** | Não (full revelation domina) | Sim (revelar bad news vs. manter ambiguidade) |

### Diagnóstico

A Prop 4 é um **patch**: introduz não-linearidade via parâmetro exógeno para compensar a linearidade estrutural do modelo. Tem três problemas fundamentais:

1. **Ad hoc**: β é um parâmetro livre sem microfundamento claro. "Political capital is destroyed" é narrativa, não modelo.

2. **Full revelation não é persuasão**: Se o sinal ótimo é revelar tudo, não há design informacional genuíno. O Sender não persuade — apenas informa. Isso contradiz a premissa do paper (informational POWER via BP).

3. **Canal secundário por construção**: O próprio paper reconhece que β amplifica mas não gera a preferência institucional. "The core preference is structural, not informational."

O novo caminho resolve os três problemas:

1. **Microfundamento**: Info privada sobre outside option é standard em barganha (Cramton 1992, Kennan & Wilson 1993).

2. **Persuasão genuína**: Sinal ótimo é partial revelation — S estrategicamente cria ambiguidade. Isso É Bayesian Persuasion no sentido de KG (2011).

3. **Canal primário**: BP é o motor do resultado institucional, não amplificador. Sob unanimidade, BP dá renda informacional; sob maioria, BP é neutralizado pela exclusão. A preferência institucional É informacional.

### Possível continuidade

Não é necessário descartar β completamente. No novo modelo, surplus destruction poderia ser um **efeito secundário** de rejection quando a outside option é exercida (por exemplo, comércio retaliatory destrói surplus). Mas o resultado central não dependeria de β — existiria com β = 0.

## 9. Questões abertas

1. **Formalizar o modelo de 2 jogadores TITL** — estabelecer lemas e proposição limpa
2. **Embeddar no BF com N jogadores** — resolver equilíbrio com outside option + info privada
3. **Verificar que o Curse of Knowledge se mantém** sob maioria (agora via adverse selection, não contagem)
4. **Estática comparativa**: como o ganho de BP varia com N, δ, b_H − b_L, p?
5. **Rubinstein vs. TITL**: a dinâmica de alternância de ofertas muda o resultado?
6. **Múltiplos Senders**: se K jogadores têm info privada, como interagem?
7. **Relação com Prop 4 (β > 0)**: o surplus destruction exógeno é substituído pelo mecanismo endógeno de screening?

## 9. Referências adicionais relevantes

- Binmore, Shaked & Sutton (1989) — Outside options in Rubinstein bargaining
- Shaked (1994) — Opting out
- Grossman (1981), Milgrom (1981) — Voluntary disclosure
- Cramton (1992) — Bargaining with incomplete information
- Kim, Kim & Van Weelden (2025, AJPS) — Persuasion in Veto Bargaining (complementar)
