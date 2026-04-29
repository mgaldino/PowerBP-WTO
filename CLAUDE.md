# Informational Power and Institutional Design: When a Hegemon May Choose Consensus

## Projeto

Paper teórico sobre **por que um hegemon escolheria consenso** em organizações internacionais. O mecanismo: unanimidade força W a incluir H sob incerteza, criando screening que gera renda informacional. Sob maioria, W exclui H da coalizão → sem screening → payoff linear. Screening é o mecanismo central; Bayesian Persuasion aparece apenas como Remark.

### Resultado central
H prefere unanimidade não apesar das restrições, mas por causa delas. Unanimidade ativa poder informacional (screening sob pivotalidade) que substitui poder de agenda. O consenso é uma tecnologia institucional de poder, não uma concessão.

## Status

- **Fase**: ATIVO — preparando submissão. Journal target: **RIO** (Review of International Organizations).
- **Paper v5** (ATIVO): `formal_model_v5.Rmd` — screening central, BP → Remark. Seção Related Literature adicionada. Provas rigorosas no appendix.
- **Paper v4** (ARQUIVO): `formal_model_v4.Rmd` — versão com BP como co-protagonista. Preservada intacta.
- **Paper v2** (ARQUIVO): `formal_model_v2.Rmd` — versão densa com provas no corpo.

### Reviews de referência
- **Parecer simulado AJPS**: `quality_reports/parecer_AJPS_formal_model_v5.md` — Reject (resubmit). Base para pendências RIO.
- **Edmans Review v5 round 2**: `quality_reports/2026-04-27_edmans-review-v5-round2.md` (7.5/10, R&R minor — Contribution 7.0, Execution 8.0, Exposition 7.5).
- **Coarse review**: `coarse-output/coarse_0b50af74_coarse_review_cli_claude.md` — review externa.

## Especificação do Modelo

- **N jogadores** (N genérico, nunca N=3): 1 hegemon H + N-1 weak states W
- **Pie**: V(θ) ∈ {1, r}, r > 1. H observa θ, W's não.
- **d_W = 0** (normalização WLOG), **d_H = αV(θ)**, α ∈ (0, 1/r)
- **Proposta aleatória** (1/N) sob AMBAS as regras. Diferença é SÓ voting rule.
- **Barganha**: 2 rounds Baron-Ferejohn, discount β
- **Conceito de solução**: PBE

### Comparação institucional
- **Unanimidade**: W deve incluir H → screening (agressivo vs conservador) → jump em E[V_H]
- **Maioria**: W exclui H da coalizão, H captura αV(θ) bilateralmente → sem screening → V_H = λ_M · V_e(μ), afim

### Resultados-chave
- **Screening cutoff**: μ_s = α(r-1)/(r-α)
- **Theorem 1**: α < α*(N,β) iff unanimidade domina condicionalmente em todo μ ∈ (0,1]
- **Corollary**: F_U ⊆ F_M (unanimidade entry set contido no de maioria)
- **Proposition 4**: Classificação institucional — U domina em F_U, M domina em F_M \ F_U, indiferença fora de F_M
- **Remark weighted**: Screening depende de inclusão estratégica, não pivotalidade formal

## PENDÊNCIAS RIO — Comparação com Hirsch & Shotts (AJPS 2025)

Fonte: `quality_reports/2026-04-27_comparison_hirsch_shotts.md`

### 1. Introdução

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Hook (fato estilizado concreto) | H&S superior (filibuster vs puzzle abstrato WTO) | **FEITO** — OPEC case study ancora na realidade |
| Preview de resultados counterintuitivos | H&S muito superior | **FEITO** |
| Apelo ao leitor não-técnico | H&S superior (WashPost, ACA) | **FEITO** — OPEC como exemplo tangível |
| Roadmap | Ausente | **FEITO** |

### 2. Discussão da Literatura

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Título substantivo | Corrigido (2026-04-27) | **FEITO** |
| Integração com o argumento (vs. catalográfica) | H&S superior | **FEITO** (2026-04-29) — "but" clauses, Koremenos reposicionado |
| Predição discriminante | Galdino superior | **FEITO** — adicionada distinção com Koremenos V3 |
| Posicionamento papers próximos | Adequado | **FEITO** — Koremenos conflicting predictions, Kim no corpo, Bardhi footnote |

### 3. Apresentação do Modelo

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Concisão (~3pp vs H&S ~1pp) | Galdino 3x mais longo | **PARCIAL** — footnotes migradas; game tree Stage 0-1 ainda presente |
| Footnotes na Definition 1 | 4 footnotes pesadas | **FEITO** (2026-04-29) — fn2 migrada para Scope, fn4 simplificada |
| Game trees (2 landscape pages) | Stage 0-1 trivial, Stage 2 tem valor | **PENDENTE** — cortar Stage 0-1 ou mover para appendix |
| Intuição verbal ANTES de resultados | H&S superior | **FEITO** — Motivating Example precede resultados formais |
| Provas no corpo vs. appendix | Indeciso | **FEITO** — proof sketches no corpo, provas completas no appendix |

### 4. Aplicações e Exemplos

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Mapping modelo→realidade | H&S muito superior | **FEITO** — OPEC: Saudi=H, spare capacity=θ, production share=α |
| Evidência empírica | Zero | **FEITO** — OPEC case study com dados reais |
| Exemplos numéricos calibrados | Inventados, hand-waving | **FEITO** — OPEC calibrado; motivating example honestamente "illustrative" |
| Confrontar predições com padrões observados | H&S muito superior | **FEITO** — OPEC 1985-86 price war confronta predições |
| Figuras conectadas à realidade | Mundo abstrato | **FEITO** — OPEC illustration conecta |

### 5. Conclusão

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Implicações de policy | Ausentes | **FEITO** — OPEC reform (auditorias independentes), erosão endógena |
| Limites | Galdino superior em honestidade técnica | **FEITO** |
| Extensões | Adequadas | **FEITO** |

### Pendência remanescente
- [ ] Game tree Stage 0-1 — cortar ou mover para appendix

### Submissão
- [ ] Submeter ao RIO

#### Submissão
- [ ] Submeter ao RIO

#### Itens concluídos (sessão 2026-04-27b)
- [x] RIO-1: ¶ "What exactly is being compared?" no Scope
- [x] RIO-2: "Why all-or-nothing entry?" expandido (founding moments vs. rolling accession)
- [x] RIO-3: Seção Related Literature (4 ¶: consensus em OIs, legislative bargaining, information & voting, predição discriminante)
- [x] RIO-4: Mecanismo concorrente financial orgs (2 frases Discussion)
- [x] RIO-5: Proof roadmap pós-Theorem 1
- [x] RIO-6: Proof roadmap pós-Corollary (F_U ⊆ F_M)
- [x] RIO-7: B.1 Prop 1 — derivação completa em 6 steps (review: PASS)
- [x] RIO-8: B.8 Prop 4 caso (ii) — inferência corrigida: λ_M > α (review: PASS)
- [x] RIO-9: Claims já calibrados
- [x] RIO-10: Conclusão — separar robustez mecanismo vs. dominância
- [x] NC-1/2/3: Tabela de notação corrigida (μ, λ_M, E_R→F_R)
- [x] Remark supermajority + weighted voting inserido
- [x] Intro comprimida, Discussion comprimida
- [x] Bardhi-Guo e Kim-Kim-Van Weelden adicionados ao .bib e diferenciados na lit review

#### Itens concluídos (sessão 2026-04-29 — readability + Hirsch integration)
- [x] Lit Review reescrita: 2 categorias (self-binding, informal power) + Koremenos movido para closely related
- [x] Koremenos posicionado como conflicting predictions (V2 vs V3), resolvido via risk neutrality + screening
- [x] Bardhi & Guo movido para footnote; Kim et al. no corpo
- [x] Predição discriminante: distinção Koremenos V3 (risk aversion) vs. nosso mecanismo (informational power)
- [x] "argue" → "imply" para informal power accounts
- [x] Passivas eliminadas (~25) em Lit Review, Scope, e passagens α*/dominância
- [x] Em dashes reduzidos (~10) em Lit Review e Scope
- [x] Definition 1: risk neutrality adicionado; footnote 2 migrada para Scope; footnote 4 simplificada
- [x] Scope: novo ¶ "Why proportional outside options?"; "What is being compared" e "Why all-or-nothing" reescritos
- [x] Passagens α*/dominância: below/above framing; "remarkably" → "nearly"; frases simplificadas

## Puzzle central

**Por que EUA aceitam consenso na OMC?** Três camadas:
1. Por que não agenda control (H proposer exclusivo)? → Mata entrada (V_W = 0).
2. Por que não maioria? → W exclui H, H recebe só αV(θ). Sem screening.
3. Por que unanimidade? → Screening. H abre mão de poder formal para amplificar poder informacional.

## Compilação

O paper usa `bookdown::pdf_document2` (definido no YAML). Para compilar corretamente:

```r
rmarkdown::render("formal_model_v5.Rmd")
```

**NÃO** usar `output_format = "pdf_document"` — isso ignora o YAML e quebra cross-references de figuras (`\@ref(fig:...)`) gerando warnings de "undefined references". Deixar sem argumento para usar o formato do YAML.

## Referências-chave

### Barganha legislativa
- Baron & Ferejohn (1989) — Modelo base
- Kalandrakis (2006, AJPS) — Proposal rights e poder político
- Eraslan & Evdokimov (2019) — Survey

### Information and voting
- Bardhi & Guo (2018, AER) — Information design sob unanimidade (sem barganha)
- Kim, Kim & Van Weelden (2025, AJPS) — Persuasion in veto bargaining (bilateral, sem institutional choice)
- Kamenica & Gentzkow (2011, AER) — Bayesian Persuasion framework

### Design institucional
- Koremenos, Lipson & Snidal (2001) — Rational design of IOs
- Steinberg (2002) — Consensus at WTO
- Gould (2022) — Cross-section of consensus rules

## Estrutura do Repositório

```
├── CLAUDE.md                          # Este arquivo
├── formal_model_v5.Rmd               # Paper ativo (v5, screening central)
├── formal_model_v4.Rmd               # Arquivo (v4, BP co-protagonista)
├── formal_model_v2.Rmd               # Arquivo (v2, provas no corpo)
├── references.bib                     # Referências bibliográficas
├── scripts/model_functions.R          # Funções R do modelo
├── notes/                             # Notas de trabalho
├── figures/                           # Figuras geradas
├── archive/                           # Modelos abandonados
├── references/                        # PDFs de referências
├── quality_reports/                   # Relatórios de qualidade e planos
└── formal_proofs/                     # Lean 4 (segurança interna)
```

## Verificação Formal (Lean 4)

**REGRA**: Lean é ferramenta de segurança interna do PI. NÃO entra no paper, NÃO serve como base para escrita.

**Status** (2026-04-29): Formalização v5 criada em `FormalProofs/V5/` (7 arquivos, build passando, 0 sorry).

### O que o Lean verifica

- **Theorem 1** (conditional dominance iff): ÁLGEBRA COMPLETA — 19 teoremas encadeados
- **Prop 1** (majority affine + λ_M > α): ÁLGEBRA COMPLETA
- **Prop 3** (screening jump): ÁLGEBRA COMPLETA
- **Prop 2** (R1 cutoff): LÓGICA ABSTRATA — IVT correto, boundary values assumidos
- **Corollary** (F_U ⊆ F_M): LÓGICA ABSTRATA — budget identities assumidas
- **Prop 4** (classificação): LÓGICA ABSTRATA — herda gaps do Corollary
- **LemmaVWMax** (V_W global max): PARCIAL — 1/4 candidatos verificados

### O que o Lean NÃO verifica (e por quê)

- **Backward induction / PBE**: Nenhum proof assistant formalizou barganha legislativa. Estimativa: 2-4 meses. Fora do escopo.
- **LP / otimização de offers**: Mathlib não tem LP. Desnecessário (otimalidade trivial neste modelo).
- **Concavificação / BP**: Relegada a Remark no v5. Baixa prioridade.

### Próximos passos Lean

Roadmap detalhado em `quality_reports/2026-04-29_lean_v5_roadmap.md`. Resumo:

1. **Definir payoffs de equilíbrio + verificar budget identities** (~100 linhas, fecha Corollary + Prop 4)
2. **Verificar 3 candidatos restantes do LemmaVWMax** (~200 linhas, fecha gap de maior risco)
3. **Derivar boundary values de Δ₁** (~80 linhas, fecha Prop 2)

### Relatórios de referência

- Fidelidade: `quality_reports/2026-04-29_lean_fidelity_v5.md`
- Roadmap: `quality_reports/2026-04-29_lean_v5_roadmap.md`
- Game theory em Lean: `quality_reports/2026-04-29_lean4-game-theory-landscape.md`

### Skills disponíveis

- `/lean-proofs` — orquestrador: extrai do paper, monta scaffold, invoca tactic loop. **Gera Relatório de Fidelidade obrigatório** (classifica cada teorema como ÁLGEBRA COMPLETA / LÓGICA ABSTRATA / PARCIAL).
- `/lean-tactic` — loop iterativo: aplica tática por vez, lê goal state, interpreta, repete.
- `/lean-dashboard` — status de verificação.
- `/lean-setup` — configurar ambiente.

## Papers Futuros

- **Erosão endógena**: Jogo repetido, fracos investem para aprender V(θ). Projeto separado.
- **Heterogeneidade**: Outside options heterogêneas, potências médias. Movido para `/Users/manoelgaldino/Documents/DCP/Papers/heterogeneous-informational-power/`.

## Convenções

- **REGRA CRÍTICA — Pareceres completos**: Ao rodar QUALQUER skill de review, o output COMPLETO DEVE ser salvo em `quality_reports/YYYY-MM-DD_nome-do-review.md`. NUNCA truncar. NUNCA salvar apenas resumo.
- **v5 é o paper ativo para submissão**; v4 preservado intacto; v2 preservado como arquivo
- **Paper é documento atemporal**: NUNCA referenciar versões anteriores ou mudanças. Escrever como se o leitor visse pela primeira vez.
- Notas em Markdown, modelo formal em Rmd → PDF
- Idioma: português para notas; inglês para o paper
- N genérico sempre (N=3 apenas no exemplo motivador Seção 2)
- Sob maioria: W EXCLUI H (não convenção WLOG de inclusão)
- **Citações em ambientes LaTeX**: Dentro de `\begin{...}...\end{...}`, usar `[@key]` (bookdown resolve).
