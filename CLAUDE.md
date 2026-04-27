# Informational Power: Bayesian Persuasion, Legislative Bargaining, and Institutional Design

## Projeto

Paper teórico sobre **por que um hegemon escolheria consenso** em organizações internacionais. O mecanismo: unanimidade força W a interagir com a informação privada de H, criando screening que gera não-convexidade no payoff de H. Bayesian Persuasion explora essa não-convexidade. Sob maioria, W exclui H da coalizão → sem screening → BP ineficaz.

### Resultado central
H prefere unanimidade não apesar das restrições, mas por causa delas. Unanimidade ativa poder informacional (BP + screening) que substitui poder de agenda. O consenso é uma tecnologia institucional de poder, não uma concessão.

## Status

- **Fase**: ATIVO — implementando Opção B modificada (screening central, BP → Remark). Journal target: JoP → AJPS → RIO.
- **Paper v5** (ATIVO): `formal_model_v5.Rmd` — reescrita sem BP como co-protagonista. Screening é mecanismo central. Baseado em v4.
- **Paper v4** (ARQUIVO): `formal_model_v4.Rmd` — versão "light math" pós-proofread+fixes, com BP como co-protagonista. Preservada intacta.
- **Paper v3** (ARQUIVO): `formal_model_v3.Rmd` — versão anterior a v4. v4 divergiu significativamente (proofread, editorial revision, fixes F1-F12, reescrita motivating example, etc.).
- **Paper v2** (ARQUIVO): `formal_model_v2.Rmd` — versão densa com provas no corpo. Preservada para referência e caso pareceristas peçam detalhes.
- **Reviews v3**: `quality_reports/2026-04-22_edmans-review-v3.md` (7.3/10) + `quality_reports/2026-04-22_review-formal-model-v3.md` (7.7/10) + `quality_reports/2026-04-26_review-formal-model.md` (7.7/10, R&R minor — Design 8, Técnica 7.5, Exposição 7.5).
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

## Fixes pós-parecer (2026-04-25)

Auditoria completa: `quality_reports/2026-04-25_auditoria_parecer_v3.md`

| # | Fix | Severidade | Dificuldade | Locais afetados | Seção |
|---|-----|-----------|-------------|-----------------|-------|
| 1 | ~~**Redefinir v(μ,R) como ganho líquido**~~ | ALTA | MÉDIA | l.414, tabela notação l.833 | ✅ FEITO |
| 2 | ~~**Corrigir fórmula de BP**: Π\* = αV_e(p) + cav v(p,R)~~ | ALTA | BAIXA | l.521, l.424 | ✅ FEITO |
| 3 | ~~**λ_M → (λ_M − α) nas provas de Thm 1 e Thm 2**~~ | ALTA | BAIXA | B.6, B.8 | ✅ FEITO |
| 4 | ~~**Código R: subtrair αV_e no entry set**~~ | MÉDIA | BAIXA | l.436, l.441, l.580, l.590 | ✅ FEITO |
| 4b | ~~**Verificação pós-normalização (agente fresh)**: re-auditar provas de Thm 1 (B.6) e Thm 2 (B.8) com v redefinido como ganho líquido~~ | ALTA | MÉDIA | B.6, B.8 inteiros | ✅ FEITO |
| 5 | ~~**Captions das figuras R**: "Value functions" → "Net gain functions"~~ | MÉDIA | BAIXA | fig.cap l.426 | ✅ FEITO |
| 6 | ~~**Concavidade de Δ₁ no ramo LOW**~~ | MÉDIA | BAIXA | B.2 l.938 | ✅ FEITO |
| 7 | ~~**Derivação algébrica da decomposição D(μ)**: novo B.5a~~ | MÉDIA | MÉDIA | Novo appendix B.5a | ✅ FEITO (A+) |
| 8 | ~~**Footnote: escolha unilateral de R**~~ | — | — | — | RETIRADO (KISS: todas as simplificações são do mesmo tipo) |
| 9 | ~~**E_U é fechado**~~ | BAIXA | BAIXA | B.8 l.1041 | ✅ FEITO |
| 10 | ~~**Prop 7 (K>2): rebaixar label**~~ | BAIXA | BAIXA | App C l.1062, l.1070 | ✅ FEITO |
| 11 | ~~**Documentar model_functions.R**~~ | BAIXA | BAIXA | scripts/model_functions.R | ✅ FEITO |
| 12 | **GATT/WTO: comprimir** | MÍNIMA | BAIXA | l.676-680 | PENDENTE |
| 13 | ~~**Motivating example: nota de coerência**~~ | — | — | — | RETIRADO (example sem entry cost é pedagógico por design) |

## TODOs

### PRÓXIMO PASSO (v4, pós-review)
Ver plano detalhado: `quality_reports/plans/2026-04-22_next-steps-v3.md`
- [x] **P1**: Lemma 1 → iff (α* necessário E suficiente) — statement, prova, 7 locais atualizados
- [x] **P2**: Remark μ̄ após Lemma 1 (Remark 2, rem:mu_bar) — feito por agente paralelo
- [x] **P3**: ~~Tabela numérica μ̄ no Scope~~ — dispensado, substituído pelo heatmap (α,μ) com 4 painéis (Fig. heatmap-alpha-mu)
- [x] **P4**: τ(U) closed-form no Appendix A.7 — derivação, review (PASS), correções, inserção feitos.
- [x] **P5**: ~~Proof sketch para Prop 5~~ — dispensado, Prop 5 removida
- [x] **P6**: Worked example após Theorem 1 (Example 2, p* ≈ 0.24). FEITO.
- [x] **P7**: Ajustes de exposição — parcialmente feito na sessão 2026-04-26 (proofread, bold headers, subsections, restatements). Discussion (F7) pendente.
- [ ] Consultar coarse review antes de submeter
- [x] Limpar .bib: 21 entradas fantasma removidas, 19 citadas mantidas
- [ ] Submeter ao JoP

### Fixes pós-review 2026-04-26 (review-formal-model 7.7/10)
Review completo: `quality_reports/2026-04-26_review-formal-model.md`. Feitos: F1-F6, F8, F10, 4b (ver "CONCLUÍDO sessão 2026-04-26" abaixo). Pendentes: F7, F9, F11, F12 (ver "PENDÊNCIAS RESTANTES" abaixo).

### PENDÊNCIAS RESTANTES (v4)

#### Review-formal-model pendências
- [x] **F7**: Discussion v4 comprimida: alt explanations fundido com observable implications, erosão cortada, PTAs e biconditional redundantes cortados
- [x] **F9**: Completar tabela de notação no App A — adicionados ω(μ), κ_M, D(μ), Γ, μ̄ (5 símbolos)
- [x] **F11**: Road map em prosa na prova do Lemma 1 (domínios, sinais, endpoints de D_base, δ_R1, δ_R2)
- [x] **F12**: Appendix C reescrito como "Extension" (não "Robustness"), com Limitations paragraph honesto sobre α_K*→0

#### Coarse review pendências (gap analysis: `quality_reports/2026-04-26_coarse-review-gap-analysis.md`)
**ALTA severidade**
- [x] **CR1**: Tipo discreto — argumento de bunching + ref. Dworczak-Martini na Conclusão. Extensão contínua anotada como paper futuro.
- [x] **CR2**: K>2 assessment honesto — Limitations ¶ em App C + Conclusão qualificada ("may shrink with K", "most favorable case")
- [x] **CR3**: BP commitment — ELIMINADO (BP removido do corpo no v5)

**MÉDIA severidade**
- [x] **CR4**: Comparative statics — resolvido: 4 comp statics (r, β, α, c) verbalizados no ¶ da Figura 4 + grids em notas
- [ ] **CR5**: Diferenciação Bardhi-Guo / Kim-Kim-Van Weelden — 1 frase, review pede 2-3 ¶
- [ ] **CR6**: T>2 rounds — PÓS-SUBMISSÃO (KISS; enfrentar se parecerista demandar)
- [x] **CR7**: Payoff de W sob unanimidade — resolvido: ¶ sobre perspectiva de W (V_W(U)<V_W(M), H escolhe regra, symmetric entry, ironia do veto)
- [x] **CR8**: Decomposição entry vs. screening — ELIMINADO (BP removido, não há mais "dual exploitation")

**BAIXA severidade**
- [x] **CR9**: Threshold sempre existe — RESOLVIDO (Proposition via sets, sem p*, E_U=(0,1] é caso particular)
- [ ] **CR10**: K>2 na conclusão — não distingue provado (K=2) de conjectura (K geral)
- [ ] **CR11**: Footnote vs. main text — efeitos opostos de complexidade (consensus matters em áreas complexas vs. α_K* aperta). Precisa 1-2 frases reconciliando.
- [x] **CR12**: (N-1)/N² corrigido — "monotonically decreasing in N for N≥2" (verificado: derivada (2-N)/N³ < 0)
- [x] **CR13**: Figure antiga (p=0.05) — RESOLVIDO (substituída pelo institutional map (p,c))
- [x] **CR14**: Doha — "explains" → "provides an alternative account of a pattern not fully explained to date"

#### Submissão
- [ ] Submeter ao JoP

### CONCLUÍDO (sessão 2026-04-26 — editorial revision v4)
- [x] Review-formal-model completo (Design 8, Técnica 7.5, Exposição 7.5 → 7.7/10, R&R minor)
- [x] Proofread: 16 correções (typo "relative do", App C overpayment invertido, 5 cross-refs, voz, dash, footnotes) → 98/100
- [x] F1: Microfundar entrada (symmetric equilibrium, all-or-nothing, N = tamanho da instituição)
- [x] F2: Consenso=unanimidade movido para motivating example
- [x] F3: α* traduzido substantivamente antes do Lemma 1 (α*≈0.47 N=5, ≈0.03 N=164)
- [x] F4: Intro já compacta (~1.5pp); page break abstract→intro adicionado
- [x] F5: Definition 2 para v(μ,R); α* definido separadamente antes do Lemma 1
- [x] F6: Linguagem natural em B.5/B.5a (~35%→~55-60%), revisado A+
- [x] F8: Justificativa 2 rounds BF (homologia, robustez, off-path beliefs, α-independência)
- [x] F10: Restatements "majority is linear" reduzidos (4→1+refs)
- [x] 4b: Auditoria provas Thm 1/Thm 2 pós-normalização — PASS + 3 cosméticos corrigidos
- [x] Motivating example reescrito (style guide): bold headers removidos, prosa corrida, Preview com p*
- [x] Section 3 subsections removidas (Environment, Timing, Solution concept, Information structure) — bloco narrativo JoP
- [x] Preview 3.1 removido (redundante com Preview da Sec 2)
- [x] "Region III" → "conservative branch (μ > μ_s^{R1})"
- [x] Cross-ref quebrada no Remark 1 corrigida (\@ref → \ref dentro de LaTeX environment)
- [x] Interpretação substantiva de α* movida para antes do Lemma 1

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

## Paper Futuro: Tipos Contínuos e Bunching

> **PAPER FUTURO** — não faz parte deste paper. Caminho delineado caso parecerista do JoP exija.

Extensão a tipos contínuos (θ ~ F em [0,r]). Screening de W com tipos contínuos gera bunching (regiões de tipos recebendo a mesma oferta). Transições entre regiões produzem kinks em V_H(μ) que BP pode explorar. Desafio técnico: com tipos contínuos, V_H depende da distribuição posterior inteira, não apenas da média — a hipótese de Dworczak & Martini (2019, JPE) de que payoff depende só da média posterior **não vale** diretamente. Alternativas: (a) encontrar condições sob as quais a média é suficiente, (b) usar frameworks mais gerais (Kolotilin et al. 2022, Arieli et al. 2023 "Bi-Pooling"). Refs: Dworczak & Martini 2019 JPE; Arieli, Babichenko, Smorodinsky & Yamashita 2023 TE; Kolotilin, Mylovanov & Zapechelnyuk 2022 TE; Dworczak & Kolotilin 2024 TE.

## Paper Futuro: Heterogeneidade e Potências Médias

> **PROJETO SEPARADO** — movido para `/Users/manoelgaldino/Documents/DCP/Papers/heterogeneous-informational-power/`. Abrir sessão lá para trabalho neste paper.

## Convenções

- **REGRA CRÍTICA — Pareceres completos**: Ao rodar QUALQUER skill de review (coarse-review, edmans-review, review-formal-model, review-paper, devils-advocate, proofread, game-theory-audit, etc.), o output COMPLETO do parecer DEVE ser salvo em `quality_reports/YYYY-MM-DD_nome-do-review.md` ANTES de resumir para o usuário. Incluir todo o conteúdo: scores, comentários detalhados, sugestões, status de cada item. NUNCA truncar. NUNCA salvar apenas resumo. Pareceres que ficam só na memória da sessão são PERDIDOS ao encerrar.
- Notas em Markdown, modelo formal em Rmd → PDF
- Idioma: português para notas; inglês para o paper
- N genérico sempre (N=3 apenas no exemplo motivador Seção 2)
- x ≡ (N-1)αr como atalho notacional
- Sob maioria: W EXCLUI H (não convenção WLOG de inclusão)
- **v5 é o paper ativo para submissão**; v4 preservado intacto (pré-Opção B); v3 é versão anterior a v4 (v4 divergiu bastante); v2 preservado como arquivo
- **Estilo v3**: corpo narra o mecanismo em prosa substantiva; provas e álgebra no appendix; sem proof sketches no corpo; comparative statics em linguagem do fenômeno (não parâmetros)
- **Paper é documento atemporal**: Escrever como se o leitor visse o paper pela primeira vez. NUNCA referenciar versões anteriores, mudanças feitas durante revisão, ou estado prévio do manuscrito. Nada de "now", "previously", "we have removed", "in the revised version". Descrever o resultado como se sempre tivesse sido assim.
