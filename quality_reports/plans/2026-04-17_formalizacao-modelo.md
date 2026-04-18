# Plano: Formalização do Modelo — Poder Informacional vs Poder de Agenda

**Status**: DRAFT
**Data**: 2026-04-17

## Contexto

O modelo tem arquitetura definida (3 estágios), simulação validada (N=2,3,5), e intuição clara (pacotes institucionais A vs C). Falta a formalização rigorosa: definições, proposições, provas. O objetivo é produzir um documento formal (Rmd → PDF) com o modelo completo, pronto para circular.

## Estrutura do Documento Formal

Arquivo: `formal_model.Rmd` (novo, na raiz do projeto)

### 1. Definições Formais

- **Definição 1**: Jogo Γ(N, p, λ, α, c) — jogadores, estados, ações, payoffs
- **Definição 2**: Pacote institucional R ∈ {A, C} — regra + agenda
- **Definição 3**: Estrutura de informação π(s|θ) e sinal público s
- **Definição 4**: Complementaridade g(k) = λk^α

### 2. Lemas (Stage 2 — Redistribuição)

- **Lema 1** (Payoffs de continuação): Para o jogo de redistribuição single-round com status quo 1/N e H como proposer exclusivo:
  - Sob Pacote A (maioria, q = ⌈(N+1)/2⌉): V_H(A) = 1-(q-1)/N, V_W(A) = (q-1)/(N(N-1))
  - Sob Pacote C (consenso): V_H(C) = V_W(C) = 1/N
  - *Prova*: Construção direta. Sob maioria, H inclui q-1 fracos mais baratos. Sob consenso, veto garante ≥ 1/N.
  - *Dificuldade*: Trivial

- **Lema 2** (Ordenamento de thresholds): τ(A) > τ(C) para todo N ≥ 3 e c > 1/N.
  - *Prova*: V_W(A) < V_W(C) → c - V_W(A) > c - V_W(C). Verificar V_W(A) < 1/N: (q-1)/(N(N-1)) < 1/N ↔ q-1 < N-1 ↔ q < N, verdadeiro para maioria.
  - *Dificuldade*: Trivial

### 3. Proposições (Stage 1 — BP + Entrada)

- **Proposição 1** (BP ótimo): O payoff ótimo de H sob BP é:
  - U_H*(R) = A(R) se τ(R) ≤ 0 ou p ≥ τ(R)
  - U_H*(R) = A(R) × p/τ(R) se 0 < p < τ(R)
  - onde A(R) = g(n) + V_H(R)
  - *Prova*: Aplicação direta de Kamenica-Gentzkow (2011) à step function v(μ) = A(R)×1{μ ≥ τ}. Concavificação padrão.
  - *Dificuldade*: Rotina (citar KG11, calcular concavificação)

- **Proposição 2** (Entrada all-or-none): Com sinal público e fracos simétricos, em equilíbrio todos os fracos entram ou nenhum entra.
  - *Prova*: Todos observam mesmo s, têm mesmo threshold τ(R), são simétricos. Decisão ótima é a mesma para todos.
  - *Dificuldade*: Trivial (com sinal público; não-trivial seria com sinal privado)

- **Proposição 3** (Condição de dominância — geral N): C domina A iff:
  - A(C)/τ(C) > A(M)/τ(M)
  - i.e., (g(n) + 1/N) / (c - 1/N) > (g(n) + V_H(A)) / (c - V_W(A))
  - *Prova*: Comparação direta de U_H*(C) vs U_H*(A) quando ambos thresholds bindam (p < τ(C) < τ(A)).
  - *Dificuldade*: Álgebra (mostrar condição fecha para N geral)

- **Proposição 4** (Estática comparativa):
  - (a) ∂p*/∂λ > 0: mais complementaridade → consenso domina para range maior de p
  - (b) ∂p*/∂c > 0: maior custo de entrada → consenso mais atraente
  - (c) ∂p*/∂α > 0: convexidade mais forte → consenso mais atraente
  - (d) p* é limitado: p* ∈ [p*_min, τ(A)]
  - *Prova*: Derivar p* = A(C)×τ(A)/A(M) e tomar derivadas parciais.
  - *Dificuldade*: Moderada (cuidar dos casos em que thresholds mudam de regime)

### 4. Proposições (Stage 0 — Pacotes)

- **Proposição 5** (Pacote B inviável): Sob unanimidade com H como proposer exclusivo em BF infinito-horizonte com δ < 1, v_W → 0 quando δ → 1. Portanto, τ → c e a instituição não se forma para p < c.
  - *Prova*: No BF com p_H = 1 e unanimidade: W sempre responde, nunca propõe. v_W = δv_W → v_W = 0. Threshold de entrada τ = c - 0 = c. Requer p ≥ c para entrada, que é estritamente maior que τ(C) = c - 1/N.
  - *Dificuldade*: Moderada (formalizar o argumento de BF; pode ser lema separado)

- **Proposição 6** (Pacote D dominado): Sob maioria com reconhecimento aleatório (p_H > 1/(3-δ) para N=3), v_H(maj) < v_H(unan). Portanto, H prefere unanimidade sem agenda ao invés de maioria sem agenda.
  - *Prova*: Derivar continuation values do BF para N=3 sob maioria com reconhecimento assimétrico. Mostrar v_H^{maj} = p_H(2-δ)/(2-p_Hδ) < p_H = v_H^{unan}.
  - *Dificuldade*: Moderada (álgebra do BF; para N geral, mais difícil)

### 5. Resultado Principal

- **Teorema** (Trade-off Institucional): Para N ≥ 3, existe um limiar p*(λ, c, α, N) ∈ (0, τ(A)) tal que:
  - Para p < p*: H escolhe Pacote C (consenso + sem agenda)
  - Para p ≥ p*: H escolhe Pacote A (maioria + agenda)
  - p* é crescente em λ, c e α
  - *Prova*: Combina Proposições 1-4. Mostrar que U_H*(C)/U_H*(A) é decrescente em p e cruza 1 em p*.
  - *Dificuldade*: Requer juntar todas as peças; álgebra moderada

## Ordem de Formalização

1. **Definições** → Lemas 1-2 (triviais, base para tudo)
2. **Proposição 1** (BP ótimo) → Proposição 2 (all-or-none)
3. **Proposição 3** (dominância) → Proposição 4 (estática comparativa)
4. **Proposições 5-6** (viabilidade dos pacotes)
5. **Teorema** (junta tudo)

## Arquivos a Criar/Modificar

- [ ] `formal_model.Rmd` — documento formal novo (definições, proposições, provas)
- [ ] Atualizar `references.bib` — adicionar referências de provas citadas
- [ ] `scripts/sim_consenso_bp.R` — adicionar verificação numérica de cada proposição

## Verificação

- [ ] Cada proposição verificada numericamente pela simulação existente
- [ ] Proposições 5-6: adicionar seção à simulação que verifica BF com reconhecimento
- [ ] Compilar Rmd → PDF sem erros
- [ ] Cross-check: resultados analíticos N=3 batem com simulação (já verificado)

## Escopo: O que NÃO entra neste plano

- Sinal privado / heterogeneidade (extensão futura)
- Horizonte infinito no Stage 2 (atual: single-round com status quo)
- Dinâmica de p endógena (paper futuro — erosão e Doha)
- BF com informação assimétrica no Stage 2
