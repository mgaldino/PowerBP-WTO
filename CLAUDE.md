# Informational Power: Bayesian Persuasion, Legislative Bargaining, and Institutional Design

## Projeto

Paper teórico sobre **por que um hegemon escolheria consenso** em organizações internacionais. O mecanismo: unanimidade força W a interagir com a informação privada de H, criando screening que gera não-convexidade no payoff de H. Bayesian Persuasion explora essa não-convexidade. Sob maioria, W exclui H da coalizão → sem screening → BP ineficaz.

### Resultado central
H prefere unanimidade não apesar das restrições, mas por causa delas. Unanimidade ativa poder informacional (BP + screening) que substitui poder de agenda. O consenso é uma tecnologia institucional de poder, não uma concessão.

## Status

- **Fase**: REVISÃO PÓS-REVIEW v3. Journal target: JoP → AJPS → RIO.
- **Paper v3** (ATIVO): `formal_model_v3.Rmd` — versão "light math" para submissão. Corpo conta a história, provas no appendix. Estilo JoP (Hirsch 2023, Hill 2022, Tyson et al. 2024).
- **Paper v2** (ARQUIVO): `formal_model_v2.Rmd` — versão densa com provas no corpo. Preservada para referência e caso pareceristas peçam detalhes.
- **Reviews v3**: `quality_reports/2026-04-22_edmans-review-v3.md` (7.3/10) + `quality_reports/2026-04-22_review-formal-model-v3.md` (7.7/10).
- **Coarse review**: `coarse-output/coarse_0b50af74_coarse_review_cli_claude.md` — review externa importante, consultar antes de submeter.
- **Resultado novo**: α* é iff (necessário E suficiente). Nota: `notes/2026-04-22_alpha_star_iff.md`. Verificado.
- **Next steps**: `quality_reports/plans/2026-04-22_next-steps-v3.md` — 7 prioridades ordenadas.
- **Nota técnica**: `notes/2026-04-19_formalizacao_v2.Rmd` — derivações base (superseded pelo paper).
- **Prova do Lemma 1**: `notes/2026-04-21_lemma1_complete_proof.md` — prova completa verificada.

## Especificação do Modelo v2

- **N jogadores** (N genérico, nunca N=3): 1 hegemon H + N-1 weak states W
- **Pie**: V(θ) ∈ {1, r}, r > 1. H observa θ, W's não.
- **d_W = 0**: normalização WLOG (pie é excedente acima do piso comum dos fracos)
- **d_H = αV(θ)**: alternativas bilaterais proporcionais ao valor da cooperação, α ∈ (0, 1/r)
- **Proposta aleatória** (1/N) sob AMBAS as regras. Diferença é SÓ voting rule.
- **Barganha**: 2 rounds Baron-Ferejohn
- **Conceito de solução**: PBE
- **Sem g** (payoff de participação removido)
- **Sem benefício direto θ para W** (removido)

### Comparação institucional
- **Unanimidade**: W deve incluir H → screening (agressivo vs conservador) → jump em E[V_H]
- **Maioria**: W exclui H da coalizão, H captura αV(θ) bilateralmente → sem screening → V_H linear

### Screening cutoff (closed form)
μ_s = α(r-1)/(r-α). Substitui a cúbica do modelo anterior.

### Onde o screening vive
Screening acontece em R1, NÃO em R2 no equilíbrio. Se R2 é alcançado (θ=1 rejeita em R1), W sabe θ=1 com certeza — informação completa, sem screening. R2 é off-path threat.

### Resultado sem BP
Condicional à entrada: H prefere unanimidade (overpayment de θ=0), W prefere maioria. NÃO Pareto comparável. Para priors onde entry só ocorre sob maioria: M Pareto domina. BP viabiliza unanimidade induzindo entrada + explorando screening jump.

## TODOs

### PRÓXIMO PASSO (v3, pós-review)
Ver plano detalhado: `quality_reports/plans/2026-04-22_next-steps-v3.md`
- [x] **P1**: Lemma 1 → iff (α* necessário E suficiente) — statement, prova, 7 locais atualizados
- [x] **P2**: Remark μ̄ após Lemma 1 (Remark 2, rem:mu_bar) — feito por agente paralelo
- [x] **P3**: ~~Tabela numérica μ̄ no Scope~~ — dispensado, substituído pelo heatmap (α,μ) com 4 painéis (Fig. heatmap-alpha-mu)
- [x] **P4**: τ(U) closed-form no Appendix A.7 — derivação, review (PASS), correções, inserção feitos. Lean não necessário (inversão algébrica, não resultado novo).
- [x] **P5**: ~~Proof sketch para Prop 5~~ — dispensado, Prop 5 removida (não acrescentava, só falava do jump, não do payoff total de H)
- [ ] **P6**: Worked example após Theorem 1 (computar p*)
- [ ] **P7**: Ajustes de exposição (harmonizar termos, comprimir Discussion, magnitudes no abstract)
- [ ] Consultar coarse review antes de submeter
- [x] Limpar .bib: 21 entradas fantasma removidas, 19 citadas mantidas
- [ ] Submeter ao JoP

### CONCLUÍDO (sessão 2026-04-22 — Lemma 1 iff + limpeza bib + entry scaling)
- [x] .bib limpo: 40 → 19 entradas (21 fantasma removidas, 0 órfãs)
- [x] Lemma 1 → bicondicional (iff): statement, prova (Step 4 Necessity), parágrafo interpretativo, Scope, figure caption, notation table — 7 edits
- [x] Remark μ̄ (rem:mu_bar) inserido por agente paralelo: D(μ) = D(1) + (1-μ)Γ, μ̄ closed-form
- [x] τ(U) derivado analytically: regime conservador affine (verificado a machine precision), regime agressivo quadrático. Nota: `notes/2026-04-22_tau_U_closed_form.md`. Review: `notes/2026-04-22_tau_U_review.md` (PASS WITH CORRECTIONS). Correções aplicadas (entry set desconectado documentado).
- [x] Issue N-grande identificado e resolvido: V_W ~ O(1/N), entry requer c ~ 1/N. Footnote adicionado: c = c̃/N, N·V_W ~ O(1), cutoffs são scale-invariant.

### CONCLUÍDO (sessão 2026-04-21 — v3 light math)
- [x] v3 criado: corpo leve, provas no appendix (estilo JoP: Hirsch 2023, Hill 2022, Tyson et al. 2024)
- [x] Majority: 2 subsections com equações → 1 parágrafo + Prop 1 + intuição
- [x] Unanimity: mecanismo descrito por referência ao motivating example, sem repetir offers. Provas no appendix
- [x] Entry/BP: 3 subsections → bloco corrido compacto
- [x] Theorem 1: sem bloco de notação (λ_M, κ_M, S_U, S_M), sem prova no corpo, statement simplificado (2 cases, não 4)
- [x] Seção 3 (Institutional Comparison) eliminada — d_W/d_H viram footnotes, design justifications vão para Scope
- [x] Tie-breaking → footnote
- [x] Todas as intuições reescritas em linguagem substantiva (estilo Hirsch: sem parênteses com variáveis)
- [x] Ganho: ~5 páginas (Theorem 1 ~p.13-14 vs ~p.18-19 no v2)
- [x] Papers de referência baixados: references/jop_examples/

### CONCLUÍDO (sessão 2026-04-21 — editorial review)
- [x] Editorial review completo (Design 8, Técnica 7, Exposição 7 → 7.5/10, R&R minor)
- [x] Seção 2 verbal → exemplo motivador N=3 (V(0)=1, V(1)=2, α=0.2, cutoff 1/9)
- [x] Convenção inclusão WLOG → exclusão explícita sob maioria (nenhuma equação mudou)
- [x] Prova Lemma 1: corpo → proof sketch 3 frases, prova completa em App B.5
- [x] Notação: φ conflito resolvido (App C → ψ), p_H → ρ_H, tabela de notação em App A
- [x] P,Q → C_buy, C_out (nomes mnemônicos na prova Lemma 1)
- [x] Proposition 2 (Overpayment) demovida a Remark
- [x] Definition 1 (Packages) absorvida na Definition 2 (Game) — "one model"
- [x] Frases iniciando com símbolo corrigidas (3 ocorrências)
- [x] Código R extraído para scripts/model_functions.R (source() no Rmd)
- [x] Game tree TikZ: 2 figuras (Stages 0-1 + bargaining unanimidade)
- [x] Screening schematic TikZ: jump anotado, branches agressivo/conservador, BP gains
- [x] Figura α*(N,β) vs N (10-150) + interpretação PTAs/Bhagwati na Scope
- [x] Bug fix: anotação screening invertida no game tree

### CONCLUÍDO (sessão 2026-04-20/21)
- [x] Pipeline completo: Code Review (98/100) + Devil's Advocate (85/100) + Proofread (100/100)
- [x] Lemma 1 prova analítica (D_base + δ_R2 + δ_R1 decomposition)
- [x] Theorem 1 reescrito (4 cases, single-crossing, closed-form p*)
- [x] Bugs corrigidos: 3 majority functions, concavify, VW_R1_unanimity, budget identity
- [x] Condição α < α*(N,β) adicionada ao Lemma 1 e Theorem 1
- [x] Introdução calibrada (when/why, não universalizante)
- [x] Literatura: Feddersen & Pesendorfer, Diermeier & Myerson, Bardhi & Guo, Kim Kim & Van Weelden, Gould
- [x] Worked Example, BP commitment, entry cost c, GATT/WTO observable implication

### EXTENSÕES (não para este paper)
- [ ] Extensão 1 (discussão): H conhece espaço factível de propostas, W não
- [ ] Extensão 2 (paper futuro): outside options heterogêneas, pie supermodular, potências médias

## Puzzle central

**Por que EUA aceitam consenso na OMC?** Três camadas:
1. Por que não agenda control (H proposer exclusivo)? → Mata entrada (V_W = 0).
2. Por que não maioria? → W exclui H, H recebe só αV(θ). Sem screening.
3. Por que unanimidade? → Screening + BP. H abre mão de poder formal para amplificar poder informacional.

## Referências-chave

### Barganha legislativa
- Baron & Ferejohn (1989) — Modelo base
- Kalandrakis (2006, AJPS) — Proposal rights e poder político
- Eraslan & Evdokimov (2019) — Survey
- Baranski & Reuben (2023) — Exclusion effect + competição por proposta (experimental)

### Bayesian Persuasion
- Kamenica & Gentzkow (2011) — O framework
- Alonso & Câmara (2016) — Persuading voters
- Schnakenberg (2015, 2017) — BP em política

### Design institucional
- Koremenos, Lipson & Snidal (2001) — Rational design of IOs
- Steinberg (2002) — Consensus at WTO
- Maggi & Morelli (2006) — Self-enforcing voting in IOs

## Estrutura do Repositório

```
├── CLAUDE.md                          # Este arquivo
├── formal_model.Rmd                   # Paper formal — A SER REESCRITO com modelo v2
├── references.bib                     # Referências bibliográficas
├── notes/
│   ├── 2026-04-19_formalizacao_v2.Rmd # NOTA TÉCNICA PRINCIPAL — base para reescrita
│   ├── 2026-04-19_formalizacao_v2.md  # Versão markdown
│   ├── 2026-04-19_sessao_redesign_v2.md # Decisões de design da sessão
│   └── 2026-04-19_reformulacao_modelo.md # Reformulação inicial (superada pela v2)
├── scripts/                           # Simulações
├── figures/                           # Figuras geradas
├── archive/                           # Modelos abandonados
├── references/                        # PDFs de referências
├── quality_reports/                   # Relatórios de qualidade
└── formal_proofs/                     # Lean 4 (segurança interna, NÃO mencionar em reviews)
```

## Verificação Formal (Lean 4)

**REGRA**: Lean é ferramenta de segurança interna do PI. NÃO entra no paper, NÃO serve como base para escrita. O paper deve se sustentar sozinho.

**Status**: Provas do modelo anterior. Precisam ser ATUALIZADAS para o modelo v2 quando o paper for reescrito.

## Paper Futuro: Erosão Endógena do Poder Informacional

> **PAPER FUTURO** — não faz parte deste paper.

Jogo repetido dentro de instituição consensual. Fracos investem para aprender V(θ). Poder informacional de H se erode endogenamente. Explica fracasso de Doha.

## Paper Futuro: Heterogeneidade e Potências Médias

> **PAPER FUTURO** — extensão com outside options heterogêneas, V endógeno, discriminação estatística.

### Nota técnica principal
`notes/2026-04-22_heterogeneidade_V_endogeno.md` — modelo com α_i privado, V(S) endógeno, screening, BP, discriminação estatística sob maioria. Derivações com tipos binários, worked examples.

### Decisões de design (2026-04-22)
- **V(S) = M·(1 - e^{-λA(S)})** com A(S) = Σ α_i^γ, γ ∈ (1,2). Exponencial saturante.
- Power function V = C·A^σ testada e **descartada**: sem saturação, exclusão sob maioria não emerge (H sempre contribui positivamente). Documentado no worked example da nota.
- Mecanismo de exclusão requer que contribuição marginal de H vá a zero para coalizões grandes (saturação).
- Cada jogador tem α_i privado (contribuição + outside option). H tem α_H maior.
- Screening: W proposer faz offer a H → cutoff μ_s → jump → BP tem valor positivo.
- Discriminação estatística: sob maioria, W exclui H (adverse selection custosa). Sob unanimidade, forced inclusion ativa BP.
- Inspiração: modelos de discriminação no mercado de trabalho (Phelps 1972, Arrow 1973).

### Plano antigo (descartado)
`quality_reports/plans/2026-04-18_heterogeneous-W-plan.md` — usava modelo v1 com entry costs c_L/c_H e complementarity g(k). Pode ter erros matemáticos. Superseded pela nota de 2026-04-22.

## Convenções

- **REGRA CRÍTICA — Pareceres completos**: Ao rodar QUALQUER skill de review (coarse-review, edmans-review, review-formal-model, review-paper, devils-advocate, proofread, game-theory-audit, etc.), o output COMPLETO do parecer DEVE ser salvo em `quality_reports/YYYY-MM-DD_nome-do-review.md` ANTES de resumir para o usuário. Incluir todo o conteúdo: scores, comentários detalhados, sugestões, status de cada item. NUNCA truncar. NUNCA salvar apenas resumo. Pareceres que ficam só na memória da sessão são PERDIDOS ao encerrar.
- Notas em Markdown, modelo formal em Rmd → PDF
- Idioma: português para notas; inglês para o paper
- N genérico sempre (N=3 apenas no exemplo motivador Seção 2)
- x ≡ (N-1)αr como atalho notacional
- Sob maioria: W EXCLUI H (não convenção WLOG de inclusão)
- **v3 é o paper ativo para submissão**; v2 preservado como arquivo
- **Estilo v3**: corpo narra o mecanismo em prosa substantiva; provas e álgebra no appendix; sem proof sketches no corpo; comparative statics em linguagem do fenômeno (não parâmetros)
- **Paper é documento atemporal**: Escrever como se o leitor visse o paper pela primeira vez. NUNCA referenciar versões anteriores, mudanças feitas durante revisão, ou estado prévio do manuscrito. Nada de "now", "previously", "we have removed", "in the revised version". Descrever o resultado como se sempre tivesse sido assim.
