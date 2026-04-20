# Sessão 2026-04-19 — Redesign do Modelo v2

## Decisões tomadas

### 1. Especificação do modelo

- **Pie**: V(θ) ∈ {1, r}, depende do estado. H observa θ, W's não.
- **Outside option de W**: d_W = 0. **Normalização sem perda de generalidade**: basta que d_W < d_H e simétrica entre fracos. Redefinimos o pie como excedente acima do piso comum dos fracos.
- **Outside option de H**: d_H = αV(θ), com α < 1/r. Alternativas bilaterais proporcionais ao valor da cooperação multilateral. Mesmo percentual α, pie maior → reserva maior em termos absolutos.
- **N genérico** sempre. Nunca especializar para N=3.

### 2. Comparação institucional: proposta aleatória sob ambas as regras

A comparação relevante é **unanimidade vs maioria, ambas com proposta aleatória (1/N cada)**. A diferença é APENAS a regra de votação.

**Por que não agenda control (H proposer exclusivo)?**
Com d_W = 0 e H como proposer exclusivo, V_W = 0 sob AMBAS as regras. Ninguém entra. Agenda control mata a instituição.

**Maioria com proposta aleatória:**
- H propõe (1/N): compra q-1 votos baratos (W's, reserva 0), exclui o resto. Fica com V(θ).
- W propõe ((N-1)/N): exclui H (mais caro), forma coalizão com outros W's. H recebe αV(θ) (alternativa bilateral).
- V_H(maioria) = V(θ)[1+(N-1)α]/N — **linear em μ, sem screening**.
- V_W(maioria) = V_e(μ)/N (W pode capturar o pie inteiro quando propõe).

**Unanimidade com proposta aleatória:**
- H propõe (1/N): precisa de todos, oferece 0, fica com V(θ). Mesmo payoff.
- W propõe ((N-1)/N): deve incluir H. Screening — oferta agressiva vs conservadora.
- V_H(unanimidade) ≥ V_H(maioria) pointwise (θ=0 é overpaid no branch conservador).
- V_W(unanimidade) < V_W(maioria) (W tem que pagar H, não pode excluí-lo).
- **Jump em E[V_H] no screening cutoff μ_s** — não-convexidade que BP explora.

### 3. O trade-off genuíno

- **Maioria**: V_W maior → entrada mais fácil. Mas V_H linear → BP sem screening channel.
- **Unanimidade**: V_W menor → entrada mais difícil. Mas V_H tem jump → BP mais eficaz.

H troca facilidade de entrada por poder informacional mais eficaz. Para certos parâmetros (g alto, α e r certos), o screening channel sob unanimidade supera a desvantagem de entrada.

### 4. Screening sobrevive em R1 (múltiplos rounds)

Com V(θ)-dependent pie, screening funciona em TODOS os rounds (não só no terminal). Razão: quando H propõe, captura V(θ). θ=1 fica com r, θ=0 fica com 1. Gap estrutural (r-1)/N que θ=0 não consegue replicar blefando. 

Contraste com h(θ) privado e pie fixo: ambos os tipos capturam pie = 1 quando propõem → gap fecha → screening impossível em rounds não-terminais.

### 5. Estrutura do puzzle (narrativa do paper)

O puzzle tem camadas:

**Camada 1**: Por que H não escolhe agenda control (H proposer exclusivo)? Parece maximizar extração. Mas V_W = 0 → ninguém entra → IO não se forma.

**Camada 2**: OK, sem agenda control. Por que não maioria? Sob maioria, H pode excluir W's quando propõe. Mas W's também excluem H quando propõem → H recebe apenas αV(θ) na maioria das vezes.

**Camada 3**: H escolhe unanimidade. Parece constraining (W's têm veto, H não pode excluir). Mas unanimidade força W a interagir com a informação privada de H → screening → jump → BP mais eficaz. H extrai MAIS que sob maioria (overpayment) E tem non-convexidade para explorar com BP.

**Resultado contraintuitivo**: H voluntariamente abre mão de agenda control E de maioria. Agenda control é muito forte (mata entrada). Maioria expõe H a exclusão. Unanimidade, que parece limitar H, na verdade maximiza o valor do poder informacional.

### 6. Screening cutoff (closed form)

μ_s = α(r-1)/(r-α)

Derivado da comparação aggressive vs conservative no terminal round com V(θ) pie e d_H = αV(θ).

### 7. Pontos a resolver

- [ ] Re-derivar R1 completo com V(θ) pie, d_W = 0, d_H = αV(θ), proposta aleatória
- [ ] Verificar se o direct benefit θ para W é necessário (entry condition μ + V_W ≥ c vs apenas V_W ≥ c)
- [ ] Se direct benefit é necessário: qual a interpretação? θ como valor intrínseco do acordo?
- [ ] Derivar V_W sob ambas as regras e comparar entry thresholds
- [ ] Verificar direção do BP: H quer μ alto (para entry) ou baixo?
- [ ] Condição para H preferir unanimidade: quando o screening channel supera a desvantagem de entrada?
- [ ] Feasibility das ofertas absolutas quando V(θ) é desconhecido por W
- [ ] Extensão 1 (discussão no paper): H conhece espaço factível de propostas, W não
- [ ] Extensão 2 (paper futuro): outside options heterogêneas o_i, pie V(S,θ) supermodular, potências médias

### 8. Insight sobre V(θ) vs h(θ)

V(θ) no pie é essencial por DUAS razões:
1. **BP funciona**: W se beneficia de θ alto (pie maior), então H pode sinalizar para encorajar entrada.
2. **Screening cross-round**: quando H propõe, captura V(θ) — vantagem estrutural de θ=1 que impede blefe perfeito de θ=0. Com pie fixo e h(θ), essa vantagem desaparece e screening só funciona no terminal round.

### 9. Normalização de d_W = 0

d_W = 0 NÃO é "fracos não têm alternativas". É normalização: o pie já está medido como excedente acima do piso comum dos fracos. Condições: (i) outside option dos fracos < outside option de H, (ii) simétrica entre fracos. Essas condições são fracas e plausíveis.
