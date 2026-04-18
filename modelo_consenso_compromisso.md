# Arquitetura do Modelo: Poder Informacional vs Poder de Agenda

**Data**: 2026-04-17
**Status**: SKETCH FORMALIZADO — pronto para simulação

---

## 1. O Puzzle

Por que um hegemon como os EUA apoiaria **consenso** em OIs como a OMC, quando poderia obter mais sob **maioria com poder de agenda**?

Sob maioria com agenda control, o hegemon forma coalizões mínimas vencedoras e extrai excedente (Baron-Ferejohn, Kalandrakis). Sob consenso, cada membro tem veto — o poder de agenda é neutralizado e o hegemon obtém o mesmo que qualquer outro (1/N).

## 2. A Resposta: Dois Tipos de Poder

O hegemon possui dois instrumentos:

| | Poder de Agenda | Poder Informacional |
|---|---|---|
| **Mecanismo** | Propõe alocações, forma coalizões | Desenha estrutura de informação (BP) |
| **Sob maioria** | Ativo: exclui membros, extrai | Parcialmente eficaz: fracos descontam futuro |
| **Sob consenso** | Neutralizado: todos têm veto | Mais eficaz: fracos confiam mais, threshold menor |

A hipótese central: **poder informacional pode substituir poder de agenda**. Sob consenso, o hegemon abre mão de agenda control mas ganha capacidade de persuasão — e, para certos parâmetros, o ganho informacional supera a perda de agenda.

## 3. Por que Maioria Requer Agenda Power (Efeito de Exclusão)

Observação técnica importante: sob maioria **sem** poder de agenda (BF com reconhecimento aleatório), o jogador com maior probabilidade de reconhecimento é **excluído** das coalizões dos outros (é caro incluí-lo). Para N=3, δ=0.9, p_H=0.6:

- v_H^{maj} = 0.452 < v_H^{unan} = 0.600

O jogador forte é **prejudicado** pela maioria sem agenda! Isso explica por que a alternativa relevante não é "maioria vs consenso", mas sim **maioria + agenda control** vs **consenso**.

Sob maioria sem agenda, H preferiria consenso trivialmente. O puzzle só existe quando maioria vem acompanhada de agenda power.

## 3.1. Pacotes Institucionais

A escolha institucional não é apenas sobre regra de votação (maioria vs consenso). É sobre **pacotes institucionais** que combinam regra de votação + controle de agenda. As combinações viáveis são:

| Pacote | Regra | Agenda | V_H | V_W | Viável? |
|---|---|---|---|---|---|
| A | Maioria | H controla | Alto | Baixo | Sim — H extrai via coalizões |
| B | Consenso | H controla | ~1 | ~0 | **Não** — destrói adesão |
| C | Consenso | Sem agenda control (aleatório) | 1/N | 1/N | Sim — veto + rotação protege W |
| D | Maioria | Sem agenda control | ~1/N | ~1/N | Possível, mas H não quer (efeito de exclusão) |

**Pacote B não é equilíbrio**: se H tem consenso + agenda control, no BF de horizonte infinito sob unanimidade com p_H=1, v_W → 0 (W nunca propõe, apenas responde, e com δ<1 aceita migalhas). Isso destrói adesão — W não entra no Estágio 1.

**Pacote D**: sob maioria sem agenda, H é excluído das coalizões (o efeito de exclusão de BF já documentado na Seção 3).

Portanto, a **comparação real é Pacote A vs Pacote C**: {maioria + agenda control} vs {consenso + sem agenda control}.

Isso corresponde à realidade: a OMC opera por consenso + member-driven (presidência rotativa, sem proposer permanente). Isso não é uma norma — é uma **configuração de equilíbrio**. Sob consenso, H voluntariamente abre mão do controle de agenda porque mantê-lo destruiria a adesão dos fracos.

O modelo simplificado já gera o resultado correto (V_H(C) = V_W(C) = 1/N) porque o status quo exógeno de 1/N substitui o papel do reconhecimento aleatório. Mas a **justificativa** muda: não é "H propõe mas não consegue melhorar sobre 1/N" — é "sob consenso, H voluntariamente abre mão do agenda control porque mantê-lo destruiria a adesão."

## 4. Jogadores

- **H** (hegemon): sender no BP + proposer na redistribuição
- **W_1, ..., W_n** (estados fracos): receivers no BP + responders na redistribuição
- N = n + 1 jogadores no total

## 5. Sequência do Jogo

### Estágio 0: Escolha Institucional
H escolhe entre dois pacotes institucionais viáveis (ver Seção 3.1):
- **Pacote A**: maioria + agenda control (H é proposer exclusivo)
- **Pacote C**: consenso + sem agenda control (reconhecimento aleatório / rotação)

Formalmente, R ∈ {A, C}. Sob A, H é o proposer no Estágio 2. Sob C, o proposer é aleatório e todos têm veto.

### Estágio 1: Bayesian Persuasion + Entrada
1. Natureza sorteia θ ∈ {0, 1}, com Pr(θ = 1) = p
   - θ = 1: o pie V é grande e H propõe termos justos (x_i é proporcional a V) → acordo não-extractivo
   - θ = 0: o pie V é pequeno ou H se apropria de quase tudo (y = V − n×x_i é máximo) → acordo extractivo
   - p baixo = fracos acreditam que H provavelmente está tentando extrair o máximo → ceticismo sobre extractividade
2. H observa θ, escolhe estrutura de informação π(s|θ)
3. Sinal público s é enviado
4. Cada W_i observa s e decide a_i ∈ {0, 1} (entrar ou não)
5. Instituição se forma se threshold de entrada é atingido

#### Estrutura de observabilidade

O pie tem tamanho V. H observa V e propõe x_i a cada estado fraco. Cada W_i observa sua oferta x_i, mas **não** observa quanto H retém para si (y = V − n×x_i). Portanto, os fracos não sabem se x_i é justo (V alto, H divide proporcionalmente) ou extractivo (V baixo, ou V alto mas H se apropria de quase tudo). Essa assimetria informacional é precisamente o que θ captura: θ = 1 quando os termos são genuinamente bons; θ = 0 quando H está extraindo o máximo possível. BP permite a H manipular a percepção de V, oferecendo x_i mais baixo e ainda assim obtendo aceitação — "comprando consentimento mais barato".

### Estágio 2: Redistribuição Intra-Institucional
Jogo de redistribuição single-round dentro da instituição (ver Seção 6).

## 6. Estágio 2: Jogo de Redistribuição (Derivado)

### Setup
- Pie de tamanho V(θ) = 1 + θδ, onde δ > 0. Quando θ=1, pie = 1+δ (acordo bom amplia o bolo); quando θ=0, pie = 1 (baseline).
- Status quo: cada membro recebe V(θ)/N (alocação igualitária default)
- H é sempre o proposer (tem agenda power)
- Proposta passa sob regra R:
  - **Maioria**: q = ⌈(N+1)/2⌉ votos (H vota por sua proposta)
  - **Consenso**: q = N votos (unanimidade)

### Solução em shares

Definimos os **shares** s_H(R) e s_W(R) do pie. Os payoffs absolutos são V(θ) × s_H(R) e V(θ) × s_W(R).

**Sob Maioria (q = ⌈(N+1)/2⌉):**

H precisa de q-1 aliados dentre n = N-1 fracos. Oferece V(θ)/N a cada aliado (iguala o status quo), dá 0 aos excluídos, fica com o resto:

$$s_H(M) = 1 - \frac{q-1}{N}, \quad s_W(M) = \frac{q-1}{N(N-1)}$$

$$V_H(R, \theta) = V(\theta) \times s_H(R), \quad V_W(R, \theta) = V(\theta) \times s_W(R)$$

Cada fraco é incluído com probabilidade (q-1)/(N-1) e recebe V(θ)/N se incluído, 0 se não.

**Sob Consenso (q = N):**

H precisa de todos. Cada fraco tem veto e exige pelo menos V(θ)/N. H não pode melhorar sobre o status quo:

$$s_H(C) = s_W(C) = \frac{1}{N}$$

### Valores dos shares para N = 2, 3, 5

| N | q_maj | s_H(M) | s_W(M) | s_H(C) | s_W(C) | Δs_H | Δs_W |
|---|-------|--------|--------|--------|--------|------|------|
| 2 | 2     | 1/2    | 1/2    | 1/2    | 1/2    | 0    | 0    |
| 3 | 2     | 2/3    | 1/6    | 1/3    | 1/3    | 1/3  | 1/6  |
| 5 | 3     | 3/5    | 1/10   | 1/5    | 1/5    | 2/5  | 1/10 |

**Nota**: N = 2 é degenerado — maioria = unanimidade (H precisa do único W em ambos os casos). O mecanismo só opera para N ≥ 3. Os payoffs absolutos são obtidos multiplicando os shares por V(θ) = 1 + θδ.

### Propriedades (q < N)

1. s_H(M) > s_H(C): H extrai share maior sob maioria ✓
2. s_W(M) < s_W(C): fracos recebem share menor sob maioria ✓
3. Esses são **resultados** do jogo, não pressupostos

## 7. Estágio 1: BP + Entrada

### Payoff dos fracos

Se W_i entra e a instituição se forma:

$$U_{W_i} = V(\theta) \times s_W(R) - c = (1 + \theta\delta) \times s_W(R) - c$$

- V(θ) × s_W(R): continuation value do Estágio 2 (pie θ-dependente vezes share)
- c > 0: custo de entrada (soberania, ajuste, compliance)

Se não entra: U_{W_i} = 0.

### Threshold de entrada

W entra iff E[θ|s] ≥ τ(R), onde:

$$\tau(R) = \frac{c/s_W(R) - 1}{\delta}$$

Derivação: W entra iff E[(1+θδ)s_W(R)] ≥ c, i.e., s_W(R)(1 + E[θ]δ) ≥ c, i.e., E[θ] ≥ (c/s_W(R) − 1)/δ.

Como s_W(M) < s_W(C): **τ(M) > τ(C)**. Entrada é mais difícil sob maioria.

**Nota sobre δ alto**: se δ é suficientemente alto, τ(A) = (c/s_W(A) − 1)/δ pode cair abaixo de zero (entrada sem persuasão). Porém, se c/s_W(A) > 1 + δ, então τ(A) > 1, e o Pacote A se torna **inviável** — nenhuma estrutura de informação consegue induzir entrada, pois o threshold excede o suporte de θ ∈ {0,1}.

### Payoff do hegemon

$$U_H = \mathbf{1}\{\text{instituição se forma}\} \times \left[g(k) + V(\theta) \times s_H(R)\right]$$

- g(k): benefício de complementaridade derivado do número de membros (ver abaixo)
- V(θ) × s_H(R): continuation value do Estágio 2
- A função-valor de H para BP: v(μ, R) = 1{μ ≥ τ(R)} × [g + (1 + μδ) × s_H(R)]

Defina A(R, θ) = g(k) + V(θ) × s_H(R): benefício total de H (θ-dependente).

### Complementaridade: g(k) é derivado, não pressuposto

O valor da instituição para H cresce com o número de membros k por complementaridades (coordenação, reciprocidade, rede de acordos, legitimidade):

$$g(k) = \lambda \cdot k^\alpha, \quad \lambda > 0, \quad 1 < \alpha < 2$$

g é **convexo** em k (g'' > 0): cada membro adicional gera **mais** valor que o anterior. Isso captura complementaridades estratégicas — coordenação, reciprocidade e legitimidade crescem de forma superlinear com a adesão.

- α ∈ (1, 2): retornos crescentes mas subquadráticos (mais lento que k²)
- α → 1: caso quase-linear (complementaridade fraca)
- α → 2: caso quadrático (tão forte quanto network effects pairwise)
- λ controla a intensidade da complementaridade
- Convexidade garante **supermodularidade** no jogo de entrada (∂²U/∂aᵢ∂aⱼ > 0)

No caso simétrico com sinal público, a entrada é all-or-none: ou todos os n fracos entram (k = n) ou nenhum (k = 0). Portanto:

$$g = g(n) = \lambda \cdot n^\alpha$$

Sob consenso (k = n obrigatório), H captura g(n) completo. Sob maioria com entrada parcial, H fica com g(m) = λm^α ≪ λn^α (pela convexidade, a perda é mais que proporcional — os membros que faltam são justamente os mais valiosos).

O parâmetro livre é λ (intensidade da complementaridade), não g em si. λ alto → instituição muito valiosa → consenso mais atraente.

### Sinal público + fracos simétricos

Com sinal público e fracos idênticos, todos fazem a mesma decisão. Sob ambas as regras, a instituição se forma iff E[θ|s] ≥ τ(R).

### Problema de BP

A função-valor de H é:

$$v(\mu, R) = \mathbf{1}\{\mu \geq \tau(R)\} \times \left[g + (1 + \mu\delta) \times s_H(R)\right]$$

Note que, diferentemente do modelo baseline, v não é uma step function pura: acima do threshold, o payoff cresce linearmente em μ (via o pie θ-dependente). Abaixo do threshold, v = 0.

**Concavificação** (para 0 < τ(R) ≤ 1):

$$\text{cav } v(\mu, R) = \frac{v(\tau(R), R)}{\tau(R)} \times \mu = \frac{g + (1 + \tau(R)\delta) \times s_H(R)}{\tau(R)} \times \mu \quad \text{para } \mu \leq \tau(R)$$

Para μ > τ(R): cav v(μ) = v(μ, R).

**Payoff ótimo de H sob BP**:

$$U_H^*(R) = \begin{cases} g + (1 + p\delta) \times s_H(R) & \text{se } \tau(R) \leq 0 \text{ ou } p \geq \tau(R) \\ \frac{v(\tau(R), R)}{\tau(R)} \times p & \text{se } 0 < p < \tau(R) \leq 1 \\ 0 & \text{se } \tau(R) > 1 \text{ (pacote inviável)} \end{cases}$$

**Condição de dominância** (caso 0 < p < τ(C) < τ(M) ≤ 1): C domina iff

$$\frac{v(\tau(C), C)}{\tau(C)} > \frac{v(\tau(M), M)}{\tau(M)}$$

Note que τ aparece tanto no numerador (via o pie avaliado em τ) quanto no denominador. Isso torna a estática comparativa em δ não-trivial.

**Sem BP** (θ não observado ou não comunicado):

$$U_H^{noBP}(R) = \begin{cases} g + (1 + p\delta) \times s_H(R) & \text{se } p \geq \tau(R) \\ 0 & \text{se } p < \tau(R) \end{cases}$$

## 8. Estágio 0: Escolha Institucional

H compara U_H*(M) vs U_H*(C) e escolhe a regra que maximiza seu payoff.

### Trade-off fundamental: Pacote A vs Pacote C

| | Pacote A (Maioria + Agenda) | Pacote C (Consenso + Sem Agenda) |
|---|---|---|
| s_H(R) | **Alto** (s_H(A) grande) | **Baixo** (s_H(C) = 1/N) |
| τ(R) = (c/s_W(R)−1)/δ | **Alto** (fracos desconfiam) | **Baixo** (fracos protegidos por veto) |
| U_H* quando p < τ | v(τ(A),A)/τ(A) × p | v(τ(C),C)/τ(C) × p |
| Fonte de extração | Agenda power (Estágio 2) | Persuasão informacional (Estágio 1) |

O trade-off fundamental: **extração via poder de agenda (Estágio 2) vs extração via poder informacional (Estágio 1)**.

### Condição para C dominar (ambos thresholds ativos, p < τ_C < τ_M ≤ 1)

C domina iff:

$$\frac{v(\tau(C), C)}{\tau(C)} > \frac{v(\tau(M), M)}{\tau(M)}$$

onde v(τ, R) = g + (1 + τδ)s_H(R). O **retorno da persuasão por unidade de threshold** é maior sob consenso. Note que τ aparece em ambos os lados da fração — tanto no pie avaliado no threshold quanto no denominador. Isso torna ∂p*/∂δ **ambíguo**: aumentar δ afeta τ (denominador) e o pie no threshold (numerador) em direções potencialmente opostas.

**Caso τ(A) > 1**: se δ é suficientemente alto que τ(A) = (c/s_W(A) − 1)/δ > 1, o Pacote A é inviável — nenhum sinal de BP consegue induzir entrada. Nesse regime, consenso domina trivialmente (desde que τ(C) ≤ 1).

## 9. Resultados Analíticos (N = 3)

Para N = 3: s_H(M) = 2/3, s_W(M) = 1/6, s_H(C) = s_W(C) = 1/3.

Thresholds:
- τ(C) = (c/(1/3) − 1)/δ = (3c − 1)/δ
- τ(M) = (c/(1/6) − 1)/δ = (6c − 1)/δ

### Caso: ambos thresholds no intervalo (0, 1]

Condição: 0 < τ(C) < τ(M) ≤ 1, i.e., c > 1/3 e δ ≥ 6c − 1.

A condição de dominância C > M é:

$$\frac{v(\tau(C), C)}{\tau(C)} > \frac{v(\tau(M), M)}{\tau(M)}$$

onde v(τ, R) = g + (1 + τδ)s_H(R). Para N = 3:

$$\frac{g + (1 + \tau(C)\delta)/3}{\tau(C)} > \frac{g + 2(1 + \tau(M)\delta)/3}{\tau(M)}$$

Substituindo τ(C) = (3c−1)/δ e τ(M) = (6c−1)/δ, o numerador de cada lado envolve termos em c e g. A expressão resultante é mais rica que no baseline: δ aparece tanto via τ quanto via o pie avaliado no threshold, tornando ∂p*/∂δ **ambíguo**.

**Interpretação**: consenso domina quando o custo de entrada é moderado relativo ao valor de complementaridade g. Mas, diferentemente do modelo baseline, o efeito de δ (tamanho do bônus do bom estado) não é monotônico.

### Crossover prior p*

O prior abaixo do qual H prefere consenso:

$$p^* = \tau(C) \times \frac{v(\tau(M), M) / \tau(M)}{v(\tau(C), C) / \tau(C)}$$

(Obtido igualando os payoffs de BP: v(τ(C),C)/τ(C) × p* = v(τ(M),M)/τ(M) × p* não determina p* — a condição de dominância é independente de p quando ambos thresholds são ativos. O crossover ocorre quando p = τ(C), i.e., quando o prior atinge o threshold de consenso e a concavificação deixa de ser necessária.)

Para p < p*: consenso domina (prior pessimista → fracos céticos → BP mais valioso)
Para p > p*: maioria domina (estado provavelmente bom → todos entram, extração via BF vale mais)

### Nota sobre δ alto

Se δ > 1/(6c − 1) (para c > 1/6), então τ(M) > 1: o Pacote A é **inviável**. Nenhum sinal de BP consegue convencer os fracos a entrar sob maioria, pois o threshold excede o suporte de θ ∈ {0,1}. Nesse regime, consenso domina trivialmente (desde que τ(C) ≤ 1, i.e., δ ≥ 3c − 1).

## 10. O que Significa "Hegemon"

**Hegemon = sender + proposer.** Duas dimensões de poder:

1. **Poder informacional** (sender no BP): observa θ, desenha π(s|θ)
2. **Poder de agenda** (proposer na redistribuição): propõe alocações, forma coalizões

Essas dimensões não são livremente combináveis — vêm em **pacotes institucionais** (ver Seção 3.1):

Sob **Pacote A (maioria + agenda)**: ambos os poderes ativos. H extrai via coalizões (Estágio 2) e persuasão (Estágio 1). Mas poder de agenda mina a credibilidade da persuasão (τ alto).

Sob **Pacote C (consenso + sem agenda)**: apenas poder informacional ativo. H **voluntariamente abre mão do agenda control** porque mantê-lo destruiria a adesão (Pacote B é inviável — ver Seção 3.1). Mas persuasão é mais eficaz (τ baixo) e H extrai via termos da entrada, não via redistribuição futura.

**Sem poder de agenda** (BF com reconhecimento aleatório sob maioria): H é excluído das coalizões (Pacote D). Maioria é pior que consenso trivialmente. Isso explica por que maioria só é viável COM agenda power — e por que a escolha real é entre Pacote A e Pacote C.

**Sem poder informacional** (sem BP): H não consegue persuadir fracos a entrar quando p < τ. A instituição não se forma. Agenda power é inútil sem participação.

O resultado central: **informational power pode ser mais valioso que agenda power** quando complementaridades são fortes (λ grande, logo g(n) grande) e o prior é pessimista (p baixo, fracos céticos e precisam ser persuadidos). H troca extração via agenda (Estágio 2) por extração via persuasão (Estágio 1).

## 11. Papel Essencial do BP

Sem BP:
- Sob maioria: se p < τ(M), nenhum fraco entra → U_H = 0
- Sob consenso: se p < τ(C), nenhum fraco entra → U_H = 0

Com BP:
- Sob maioria: U_H = A(M) × p/τ(M) > 0
- Sob consenso: U_H = A(C) × p/τ(C) > 0

BP é essencial: sem ele, a instituição não se forma quando há ceticismo sobre extractividade. E a **interação** entre BP e regra institucional gera o resultado — nenhum dos dois sozinhos explica a preferência por consenso.

## 12. Erosão Informacional e a Trajetória da OMC

### Estática comparativa em p (ceticismo sobre extractividade)

O modelo gera uma previsão dinâmica via estática comparativa no prior p:

| Período | p (ceticismo) | BP útil? | H prefere... | Resultado |
|---|---|---|---|---|
| Pré-2000 | Baixo (fracos céticos: H está extraindo?) | Sim — essencial | Consenso (BP compensa perda de agenda) | OMC funciona |
| Pós-2000 | Alto (fracos sabem avaliar os termos) | Não — acordo forma sem BP | Maioria (A(M) > A(C)) | Doha trava |

### Mecanismo de erosão

À medida que os fracos aprendem (liberalização generalizada, Washington Consensus, capacitação técnica), passam a avaliar por conta própria se os termos são extractivos:
1. O ceticismo sobre extractividade diminui — fracos sabem calcular V e identificar quando H extrai demais (p sobe)
2. O ganho de BP de H diminui (menos escopo para manipular a percepção de V)
3. Sob consenso, H obtém apenas g(n) + 1/N — sem extração via persuasão
4. A outside option de H melhora (acordos bilaterais/regionais)
5. H bloqueia ou desengaja da instituição consensual

### Formalização

Sem alterar o framework estático, basta observar que **H prefere consenso iff p < p\*(λ, c)**. Se p cruza p\* de baixo para cima ao longo do tempo:

$$p_t < p^* \implies \text{H aceita consenso} \implies \text{instituição funciona}$$
$$p_t > p^* \implies \text{H preferiria maioria} \implies \text{bloqueio sob consenso fixo}$$

Para capturar delay/blocking: adicionar outside option ū para H (não negociar). Se g(n) + 1/N < ū, H prefere não participar. Isso acontece quando:
- λ cai (instituição perde valor relativo — e.g., alternativas bilaterais)
- p sobe (informação se democratiza)
- Ambos simultaneamente (cenário OMC pós-Doha)

### Implicações empíricas

1. **Cross-section**: Consenso mais provável em áreas de alta assimetria informacional (comércio nos anos 1940-90, propriedade intelectual, regulação financeira)
2. **Temporal**: Instituições consensuais travam quando assimetria informacional se erode
3. **Substituição**: Proliferação de acordos bilaterais/regionais (onde H tem agenda power) coincide com erosão do poder informacional no fórum multilateral
4. **Predição**: Novas áreas de alta assimetria (AI governance, digital trade, climate finance) devem favorecer arranjos consensuais — até que conhecimento se difunda

## 13. Extensões Futuras

1. **Horizonte infinito**: Estágio 2 como BF de horizonte infinito (muda os payoffs de continuação mas não a lógica)
2. **Sinal privado + heterogeneidade**: fracos diferentes, sinais privados → equilíbrio de coordenação; convexidade de g(k) fortalece consenso
3. **Competição entre instituições**: fracos podem aderir a instituição rival → outside option endógena
4. **Dinâmica de p**: p evolui endogenamente (learning by doing, spillovers de informação) → modelo de quando o consenso para de funcionar
5. **Delay como equilíbrio**: framework de barganha com delay endógeno (Fearon-style) para capturar Doha stall
6. **BF de 2 rodadas com informação assimétrica sobre o tamanho do pie (V3)**: Num BF de 2 rodadas com informação assimétrica sobre V(θ), sob Pacote C emerge um canal de screening: a estratégia de proposta de W depende de μ (a crença posterior sobre θ), de modo que BP ajuda H não apenas na decisão de entrada (Estágio 1) mas também na barganha redistributiva (Estágio 2). Isso reforça o trade-off central mas não altera os resultados qualitativos. O mecanismo de screening funciona como micro-fundamento do threshold de forma reduzida capturado por s_W(R) no modelo baseline.

## Referências

- Baron & Ferejohn (1989) — BF modelo base
- Kalandrakis (2006) — Proposal rights e poder político
- Kamenica & Gentzkow (2011) — Bayesian Persuasion
- Alonso & Câmara (2016) — Persuading voters (BP com múltiplos receivers)
- Fearon (1995) — Barganha e compromisso
- Maggi & Morelli (2006) — Self-enforcing voting in IOs
