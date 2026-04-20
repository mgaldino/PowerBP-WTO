# Reformulação do Modelo — Sessão 2026-04-19

## Contexto: por que recomeçar

Uma revisão adversarial (quality_reports/2026-04-19_adversarial-math-review.md) identificou um issue CRITICAL na derivação do R2 do paper (formal_model.Rmd): a reserva do W não-proposer sob oferta agressiva usava V_e(μ)/3 quando deveria ser 1/3 (argumento de pivotalidade). Isso torna Ω linear (não quadrático), muda todas as fórmulas, e estreita a condição de pooling.

Em vez de remendar, decidimos re-derivar o modelo do zero com premissas mais limpas.

## O que mudou em relação ao paper atual (formal_model.Rmd)

| Aspecto | Paper atual | Reformulação |
|---------|-------------|--------------|
| Disagreement payoff | d = V(θ)/N (todos recebem share igual) | d = 0 para W, outside option h(θ) para H |
| Ω(μ) | Quadrático: [3+(r-1)(μ²+2μ)]/9 | Linear: V_e(μ)/3 (ou derivado da nova spec) |
| μ_s | Raiz de uma cúbica (sem closed form) | Closed form: (h_H - h_L)/(1 - h_L) |
| Assumption P | r < N/((N-1)β) = 3/(2β) | r < (3-β)/(2β) — mais restritiva |
| Fonte do screening | R2 (Ω quadrático) | R1 (continuation value type-dependent de H) |
| H's reservation | V(θ)/N (do disagreement) | h(θ) = outside option privada |
| N | Especializado para N=3 | Geral N desde o início |

## Nova formulação (até onde chegamos)

### Setup

- N jogadores: 1 hegemon H, N-1 weak states W
- Pie normalizado = 1 (surplus acima do status quo)
- H tem outside option h(θ) ∈ {h_L, h_H}, com 0 < h_L < h_H < 1, PRIVADA
- W tem outside option = 0 (PÚBLICA)
- θ ∈ {0,1}, Pr(θ=1) = μ (posterior após sinal de BP)
- Unanimidade sob Package C, reconhecimento simétrico 1/N
- H observa θ; W's não observam

### Interpretação

H (EUA) tem alternativas fora da instituição (acordos bilaterais, poder econômico). Essas alternativas valem h(θ), que depende do estado do mundo. W's (países fracos) não têm alternativas — sem a instituição multilateral, ganham 0.

θ captura algo sobre o estado do mundo que afeta a outside option de H:
- θ=0: H tem alternativas piores → h_L (aceita ofertas menores)
- θ=1: H tem alternativas melhores → h_H (exige mais para aceitar)

W sabe os valores possíveis (h_L, h_H) mas não sabe qual H tem.

### Terminal round (R2) — DERIVADO

**Quando H propõe** (prob 1/N): oferece 0 a todos os W's (reserva 0), fica com 1.

**Quando W_j propõe** (prob 1/N): oferece 0 aos outros W's. Escolhe y_H para maximizar utilidade esperada.

W compara:
- **Agressivo** (y_H = h_L): aceito só por θ=0. EU = (1-μ)(1 - h_L)
- **Conservador** (y_H = h_H): aceito por ambos. EU = 1 - h_H

**Screening cutoff** (closed form):
```
μ_s = (h_H - h_L) / (1 - h_L)
```

W joga agressivo se μ < μ_s, conservador se μ > μ_s.

### Continuation values do terminal round

**V_W^{R2}(μ):**
- μ < μ_s: (1-μ)(1 - h_L)/N
- μ > μ_s: (1 - h_H)/N
- Contínuo em μ_s ✓

**V_H^{R2}(θ, μ):**
- θ=1: [1 + (N-1)h_H]/N **sempre** (rejeita agressivo → outside option h_H; aceita conservador h_H)
- θ=0, μ < μ_s: [1 + (N-1)h_L]/N (aceita agressivo h_L)
- θ=0, μ > μ_s: [1 + (N-1)h_H]/N (aceita conservador h_H — "overpaid")

**Jump em E[V_H^{R2}] no cutoff μ_s:**
```
Jump = (N-1)(h_H - h_L)(1 - h_H) / [N(1 - h_L)]
```
Positivo desde que h_H < 1. Vem inteiramente do tipo θ=0 ser overpaid quando W muda para conservador.

### Timing do jogo completo (a confirmar)

1. **Stage 0**: H escolhe pacote institucional R ∈ {A, C} (commitment de longo prazo, ANTES de θ)
2. **Stage 1**: Natureza sorteia θ. H observa θ. H commita a sinal público (BP). W's observam sinal, formam posterior μ, decidem se entram (pagando custo c).
3. **Stage 2**: Barganha (2 rounds? ou mais?) sob regras do pacote R.

### O que falta derivar

- [ ] **R1 sob Package C**: W propõe em R1. H tem reservation β·V_H^{R2}(θ), que é type-dependent. Screening em R1 com continuation values de R2.
- [ ] **R1 sob Package A**: H propõe. Verificar linearidade.
- [ ] **Condição de pooling em R1**: quando H propõe, pode pooler? Sob que condições?
- [ ] **Entry thresholds**: τ(A) e τ(C) com a nova spec.
- [ ] **Value functions e concavificação**: v(μ,A) vs v(μ,C).
- [ ] **Theorem 1**: comparação institucional.
- [ ] **Se H revela info em R1**: o terminal round precisaria ser re-derivado com beliefs atualizados.

## Decisões tomadas nesta sessão

1. **d=0 para W, h(θ) > 0 para H**: mais natural que d=V(θ)/N para todos.
2. **N geral** desde o início (não especializar para N=3).
3. **Lean é segurança interna**: não mencionar em reviews nem usar como base para o paper.
4. **Provas sem "informal justification"**: toda prova deve ser completa, nível APSR.
5. **Screening vem de H ter reservation privada**: a outside option type-dependent é a fonte, não o disagreement payoff.

## Referência

- Paper atual: formal_model.Rmd (na raiz do projeto)
- Paper original (provas mais completas): references/formal_model_original.Rmd
- Review adversarial: quality_reports/2026-04-19_adversarial-math-review.md
- Simulação do grid de screening: scripts/sim_screening_grid.R
- CLAUDE.md tem os TODOs pendentes
