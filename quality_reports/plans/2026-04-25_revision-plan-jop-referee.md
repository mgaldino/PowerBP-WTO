# Plano de Revisão — Parecer JoP (2026-04-25, revisado)

**Status**: NEAR COMPLETE (11/12 itens feitos, R10 em verificação adversarial)

Parecer: `notes/parecer_jop_formal_model_v3.pdf`
Análise: `quality_reports/2026-04-25_analise_parecer_jop.md`
Comparação review/parecer: `quality_reports/2026-04-25_comparacao-review-vs-parecer.md`
Review de correção: `quality_reports/2026-04-25_correctness-review-v3.md`
Paper ativo: `formal_model_v3.Rmd`

---

## Prioridade 1 — Problemas formais (bloqueiam submissão)

### R0. Corrigir game tree — ofertas e payoffs de R1 (ref: review de correção §5.1) — ✅ FEITO

**Resolução**: Opção 2 implementada (árvore esquemática com nota na caption). Caption agora declara: "Offer labels and terminal payoffs show R2 values (where H's reservation is αV(θ)) for readability; exact R1 offer levels are βV_H^R2(θ=0, μ'=1) (aggressive) and βV_H^R2(θ=1) (conservative), derived in Appendix A.3."

---

### R1. Formalizar o "principal regime" no enunciado (ref: §3.2 do parecer) — ✅ FEITO

**Resolução**: Opção 2 implementada (α* < ᾱ NÃO vale em geral — 26.823 violações, `scripts/verify_alpha_star_vs_alpha_bar.R`). Prop 2 agora tem condição explícita α < ᾱ com equação numerada. A.5 expandido com derivação de ᾱ.

**Pendência menor**: A.5 e B.2 dizem "numerical verification confirms" para unicidade no regime alternativo. Deveria ser argumento analítico (Δ₁ quadrática com f(0)>0, f(μ_s^R2)≤0 ⇒ exatamente 1 raiz por TVI). Não bloqueia submissão.

---

### R2. Expandir prova do Lemma 1 — caso alternativo (ref: §3.3 do parecer) — ✅ FEITO

**Resolução**: B.5 expandida com ~15 linhas. Caso alternativo (μ_s^R1 < μ_s^R2) com 3 branches explícitos: Low (agg R1, agg R2), Middle (con R1, agg R2 — branch NOVO), High (con R1, con R2). Endpoints verificados em cada fronteira. Justificativa da aditividade das correções (independência R1/R2). Script: `scripts/verify_decomposition_both_regimes.R` (5 combinações, erro < 10^{-16}).

**Pendência menor**: A.5 diz "proofs use only qualitative properties" mas B.5 agora usa formulas quantitativas específicas. Wording levemente desatualizado.

---

### R3. Declarar entry como forma reduzida (ref: §3.5 do parecer) — ✅ FEITO

**Resolução**: Frase adicionada ao Stage 1 (Timing). Formulação como regra de seleção (equilíbrio Pareto-dominante), NÃO como "unique BNE" — que seria falso porque existe também o equilíbrio "ninguém entra" (jogo de coordenação sob unanimidade). Texto final: "we focus on symmetric entry: all N−1 weak states enter if and only if the expected equilibrium payoff V_W^{R1}(μ,R) ≥ c. When this participation constraint is violated, the institution does not form."

---

## Prioridade 2 — Reframing e exposição (necessários para próxima submissão)

### R4. Reframing condicional da contribuição (ref: §3.1 e §4.1 do parecer) — ✅ FEITO

**Resolução**: Recalibrado em 4 locais:
1. **Abstract**: "Why would" → "When does"; "I argue" removido; "identifies conditions under which" no lugar de afirmação geral.
2. **Introdução** (parágrafo do mecanismo): "discontinuity that BP exploits" → "conditional payoff advantage"; BP "extends" em vez de "exploits."
3. **Seção 6** (concavificação): Explicitado que BP não cria a vantagem — screening cria (Lemma 1) — BP a estende para priors abaixo do threshold de entrada.
4. **Conclusion**: "shown when and why" → "identified conditions under which"; "non-convexity... exploits" → "conditional payoff advantage... extends."

---

### R5. Observable implications para seção WTO (ref: §3.6 do parecer) — ✅ FEITO

**Resolução**: Parágrafo único expandido de 1 OI para 5, em prosa corrida estilo JoP (First... Second... Third... Fourth... Finally...), sem labels com parâmetros. OIs: (1) complexidade informacional, (2) alternativas bilaterais/PTAs, (3) maturidade do regime, (4) paciência na barganha, (5) predição discriminante vs. legitimidade e self-enforcement. Footnote sobre K>2 tipos preservada.

---

### R6. Consensus vs. unanimity — justificativa formal (ref: §4.3 do parecer) — ✅ FEITO

**Resolução**: Footnote na Definition 1 (linha 98) reescrita. Agora declara explicitamente: ações binárias {accept, reject}, sem abstenção; a distinção institucional entre consenso e unanimidade não se aplica; termos usados intercambiavelmente. Inclui nota sobre a prática da OMC.

---

### R7. Recalibrar a narrativa BP vs. conditional dominance (ref: §3.4 do parecer + review de correção) — ✅ FEITO

**Resolução**: Narrativa recalibrada em 5 locais (abstract, intro, preview, Seção 6, conclusion). Padrão consistente: screening (Lemma 1) é o motor; BP estende a vantagem para priors abaixo do threshold de entrada (Theorem 2). Parágrafo após Theorem 1 já estava bem calibrado (mantido). Mudanças específicas:
- Abstract: "BP exploits" → screening dá vantagem condicional, BP a estende
- Intro: "discontinuity that BP exploits" → "conditional payoff advantage"
- Preview: building block (3) recalibrado — BP estende, não explora
- Seção 6: "dual exploitation is the paper's distinctive contribution" → "distinctive contribution of BP is not to create the advantage but to extend it"
- Conclusion: "BP exploits that non-convexity" → "BP extends this advantage"

---

### R10. Abordar Assumption 1 (monotone entry) substantivamente (ref: §3 do parecer + review de correção)

**Problema**: Theorem 2 depende de Assumption 1 (E_U é intervalo superior). O referee diz: "essa assunção é substantiva e precisa ser mais bem justificada." Verificação numérica mostra que Assumption 1 falha em **4.9% do espaço de parâmetros** (348/7064 casos). Quando falha, E_U é desconectado — há um gap de beliefs ao redor de $\mu_s^{R1}$ onde entry não ocorre.

Porém, nos 4 casos testados com E_U desconectado, **single-crossing sobrevive** (1 sign change). Isso sugere que a assunção é suficiente mas possivelmente não necessária.

**Quando falha**: r baixo (1.2), c intermediário, qualquer β. O gap em E_U é causado pelo downward jump de V_W em $\mu_s^{R1}$: quando W passa de agressivo para conservador, H ganha (overpayment) mas W perde (paga mais a H), criando uma queda local em V_W que pode empurrar V_W abaixo de c.

**Solução** (em ordem de ambição):

1. **Mínima (suficiente para submissão)**: Expandir a justificativa da Assumption 1 com quantificação:
   - Declarar que falha quando r é baixo e c intermediário
   - Mostrar numericamente que single-crossing sobrevive em todos os casos testados com E_U desconectado
   - Adicionar: "We conjecture that the single-crossing property holds without Assumption 1, but the proof for disconnected entry sets requires tracking concavification across multiple intervals and is left to future work."

2. **Intermediária**: Provar que quando E_U tem 2 componentes conexas (o caso genérico de falha), o resultado se mantém com um argumento análogo (comparar slopes em cada componente).

3. **Ideal**: Eliminar Assumption 1. Provar single-crossing diretamente via propriedades da concavificação de v(μ,U) — que é piecewise linear com no máximo 2 não-convexidades (entry jump + screening jump). Concavificação de função com 2 não-convexidades tem envelope com no máximo 3 segmentos, o que pode ser comparado diretamente com a reta S_M·p.

**Decisão**: Opção 3 (eliminar Assumption 1). Prova proposta usa insight de que E_U ⊆ E_M garante que gaps de E_U caem em região onde m(p) é affine, então a corda que fecha o gap fica acima de m. Prova sob verificação adversarial em sessão dedicada. Verificação numérica: 0 violações em 7.200 combinações (530 com E_U desconectado). Script: `scripts/verify_R10_single_crossing_no_assumption.R`.

**Onde editar** (após aprovação da prova): Theorem 2 statement (remover Assumption 1), prova B.7 (reescrever), Assumption 1 (remover ou converter em remark).

---

## Prioridade 3 — Polimento (melhoram o paper mas não são bloqueantes)

### R8. Motivating Example — explicitar que é simplificado (ref: §2.2 do parecer) — ✅ FEITO

**Resolução**: Frase adicionada ao início da Seção 2: "consider a simplified special case with three players and one bargaining round to build intuition for the mechanism. The general model (Section 3) extends this to N players, two rounds of Baron-Ferejohn bargaining, and entry costs."

---

### R9. Notação — mover mais álgebra para appendix (ref: §4.2 do parecer) — ✅ FEITO

**Resolução**: C_buy e C_out definidos inline no Remark 1: "where C_buy ≡ β(q−1)(1−α) is the vote-buying cost under majority, C_out ≡ N(N−1)α is the aggregate outside-option cost."

### R11. Fixes menores (ref: review de correção) — ✅ FEITO

1. **Jump no exemplo motivador**: Corrigido de "$0.18$" para "$8/45 \approx 0.18$".
2. **Proposition 2**: Já resolvido por R1 (α < ᾱ explícito).

---

## Ordem de execução (revisada)

| Fase | Tasks | Status |
|------|-------|--------|
| **Fase 1** | ~~R0~~ + ~~R1~~ + ~~R2~~ + R10 (Assumption 1) | R0 ✅ R1 ✅ R2 ✅ R10 em verificação adversarial |
| **Fase 2** | ~~R3~~ + ~~R6~~ + ~~R8~~ + ~~R11~~ | Todos ✅ |
| **Fase 3** | ~~R4~~ + ~~R5~~ + ~~R7~~ | Todos ✅ |
| **Fase 4** | ~~R9~~ + polimento B.2/A.5 | R9 ✅ polimento B.2/A.5 ✅ |

### Notas sobre a ordem

- **R7 é a revisão mais delicada**: requer recalibrar a narrativa central do paper sem enfraquecer a contribuição. O ponto não é que BP é irrelevante — é que BP faz trabalho real no Theorem 2 (expandir o domínio de priors), não no Theorem 1 (conditional dominance). A narrativa deve ser: "unanimidade cria vantagem condicional (Lemma 1); BP expande essa vantagem para priors onde a instituição não formaria (Theorem 2)."
- **R10 (Assumption 1)** pode ser paralela a R1/R2 na Fase 1. Se a opção 3 (eliminar a assunção) for viável, fortalece muito o paper. Se não, opção 1 (quantificar e ser honesto) é suficiente.
- **R0 (game tree)** é isolado e rápido. Opção 2 (esquemática com nota na caption) resolve em 15 minutos.

---

## Resumo das mudanças vs. plano original

| Item | Plano original | Plano revisado |
|------|----------------|----------------|
| R0 | não existia | **NOVO**: corrigir game tree (ofertas R1 ≠ R2) |
| R7 | reescrever 1 parágrafo após Thm 1 | **AMPLIADO**: recalibrar narrativa BP em 4 locais (intro, preview, Sec 6, Thm 1) |
| R9 | genérico ("mover álgebra") | **ESPECIFICADO**: fix C_buy/C_out no Remark 1 |
| R10 | não existia | **NOVO**: abordar Assumption 1 substantivamente (5% falha, single-crossing robusto) |
| R11 | não existia | **NOVO**: jump 0.18 → ≈0.18, Prop 2 parentético |

---

## Target

Submeter versão revisada ao **AJPS** (ou JoP como new submission), com todas as 12 revisões implementadas (R0-R11). O referee elogia o mecanismo e a intuição — o paper é publicável com estas correções, desde que:
1. A prova do Lemma 1 esteja completa (R2)
2. A narrativa BP seja honesta sobre onde BP faz trabalho (R7)
3. Assumption 1 seja tratada substantivamente (R10)
