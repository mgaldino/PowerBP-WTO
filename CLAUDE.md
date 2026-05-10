# Informational Power and Institutional Design: When a Hegemon May Choose Consensus

## Projeto

Paper teórico sobre **por que um hegemon escolheria consenso** em organizações internacionais. O mecanismo: unanimidade força W a incluir H sob incerteza, criando screening que gera renda informacional. Sob maioria, W exclui H da coalizão → sem screening → payoff linear. Screening é o mecanismo central; Bayesian Persuasion aparece apenas como Remark.

### Resultado central
H prefere unanimidade não apesar das restrições, mas por causa delas. Unanimidade ativa poder informacional (screening sob pivotalidade) que substitui poder de agenda. O consenso é uma tecnologia institucional de poder, não uma concessão.

## Status

- **Fase**: pós-parecer técnico das provas; revisão interna do appendix em andamento. A versão submetida ao RIO deve ser tratada como superada para fins de prova formal.
- **Paper v5** (ATIVO): `formal_model_v5.Rmd` — screening central, BP → Remark. O appendix foi corrigido em 2026-05-10 para majority outside option externa e strict BF feasibility. O corpo principal ainda precisa ser revisado depois.
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

### Resultados-chave — status após correção das provas

**Verificados no appendix corrigido (2026-05-10):**
- Maioria não gera screening quando H's outside option é externa ao pie.
- Coeficientes corrigidos: `lambda_M^E = {N[1+(N-1)alpha] - beta(q-1)}/N^2`; `kappa_M^E = [N(N-1)+beta(q-1)]/[N^2(N-1)]`.
- R2 de unanimidade: `mu_s^R2 = alpha(r-1)/(r-alpha)`.
- R1 quando W propõe sob unanimidade: escolha restrita por factibilidade entre `A(mu)` agressivo, `C(mu)` conservador e `R(mu)` rejeição deliberada.
- Calibração OPEC (`N=13`, `r=1.5`, `alpha=.19`, `beta=.9`): regime W-proposer `A-C-A`, com cortes `0.031188` e `0.301717`; lower bound de unanimidade domina majority corrigida em todo `mu in [0,1]`.

**Pendentes; não tratar como provados:**
- Theorem 1 geral de dominância condicional.
- Corollary `F_U subset F_M`.
- Proposition 4 de classificação institucional.
- Máximo global do payoff dos fracos sob unanimidade.
- Appendix C de tipos contínuos.
- PBE completo do ramo em que H propõe fora da região de pooling.

**Remark weighted**: Screening depende de inclusão estratégica, não pivotalidade formal.

### Correção crítica das provas (2026-05-10)

O parecerista estava correto: o appendix antigo calculava payoffs de maioria como se a outside option de H fosse paga pela coalizão majoritária. Isso é errado no modelo. Sob maioria, W exclui H; H recebe `alpha V(theta)` externamente; o pie institucional disponível aos fracos não é reduzido por `(1-alpha)`.

Inequality importante:

```text
lambda_M^E > alpha  iff  alpha < 1 - beta(q-1)/N
```

Essa condição não segue automaticamente de `alpha < 1/r`.

Sob strict BF, W não pode propor mais do que cabe no estado baixo quando a proposta pode passar nesse estado. Por isso o antigo cutoff único de R1 é supersedido por `max{A,C,R}`. Na calibração, isso gera `A-C-A`: agressivo em crenças baixas, conservador em crenças intermediárias, agressivo novamente em crenças altas porque a oferta conservadora deixa de ser factível.

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
| Concisão (~3pp vs H&S ~1pp) | Galdino 3x mais longo | **PENDENTE** — footnotes migradas, mas modelo ainda longo demais |
| Footnotes na Definition 1 | 4 footnotes pesadas | **FEITO** (2026-04-29) — fn2 migrada para Scope, fn4 simplificada |
| Game trees (2 landscape pages) | Stage 0-1 trivial, Stage 2 tem valor | **PENDENTE** — cortar Stage 0-1 ou mover para appendix |
| Intuição verbal ANTES de resultados | H&S superior | **PARCIAL** — Motivating Example existe, mas falta intuição antes de cada proposição no corpo |
| Provas no corpo vs. appendix | Indeciso | **FEITO** — padrão Hirsch: sem proof sketches no corpo, roadmap migrado para B.5 |

### 4. Aplicações e Exemplos

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Mapping modelo→realidade | H&S muito superior | **FEITO** — OPEC: Saudi=H, spare capacity=θ, production share=α |
| Evidência empírica | Zero | **FEITO** — OPEC case study com dados reais |
| Exemplos numéricos calibrados | Inventados, hand-waving | **FEITO** — OPEC calibrado; motivating example honestamente "illustrative" |
| Confrontar predições com padrões observados | H&S muito superior | **FEITO** — OPEC 1985-86 price war, Angola/UAE exits confrontam Prop 4 |
| Figuras conectadas à realidade | Mundo abstrato | **PARCIAL** — calibradas para OPEC, mas sem dados empíricos reais (cf. H&S Figure 6) |

### 5. Conclusão

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Implicações de policy | Ausentes | **PENDENTE** |
| Limites | Galdino superior em honestidade técnica | **FEITO** |
| Extensões | Adequadas | **FEITO** |

### Pendências remanescentes (pré-submissão RIO)

**Exposição (padrão Hirsch & Shotts)**
- [ ] Concisão do modelo — ~3pp, reduzir. Candidatos: parágrafo justificando 2 rounds (l.112), descrição dos 3 stages
- [ ] Game tree Stage 0-1 — cortar ou mover para appendix (trivial, ocupa 1 página landscape)
- [ ] Intuição verbal ANTES de cada proposição no corpo — Motivating Example existe, mas Props 1-3 no corpo não têm setup intuitivo antes do enunciado formal
- [x] Provas sem sketch no corpo — padrão Hirsch: roadmap pós-Thm 1 migrado para B.5 (2026-04-29)
- [ ] Figuras conectadas à realidade — calibradas para OPEC, mas sem dados empíricos reais (cf. H&S Figure 6 com Nominate scores)
- [ ] Implicações de policy na conclusão — OPEC reform e erosão estão na Discussion, não migram para Conclusion

**Arquivos de submissão (`RIO submission files/`)**
- [x] Corrigir 13 cross-refs quebradas no appendix — resolvido via `\usepackage{xr}` + `\externaldocument{01_manuscript}` (2026-04-30)
- [x] Remover frase "The decomposition is derived in Appendix B.5a." — removida do Rmd e do .tex (2026-04-30)
- [x] TikZ inline → `\includegraphics` — figuras standalone em `figures/fig{1,2}_*.tex`, script copia PDFs (2026-04-30)
- [x] Bib duplicada no appendix — removida; appendix sem seção References (2026-04-30)
- [x] Recompilar ambos os .tex — compilado 2x, 0 undefined refs (2026-04-30)
- [x] Submeter ao RIO — submetido 2026-04-30
- [x] Preprint no SocArXiv — upload 2026-04-30, aguardando moderação

#### Histórico de itens concluídos
Sessões 2026-04-27b e 2026-04-29: RIO-1 a RIO-10 (Scope, Lit Review, provas B.1/B.8, calibração, Conclusão), notação corrigida, Remark weighted voting, readability (passivas, em dashes, footnotes), Hirsch integration (Koremenos, Bardhi, Kim, predição discriminante). Sessão 2026-04-30: cross-refs appendix, TikZ→includegraphics, bib duplicada, recompilação final, submissão RIO + preprint SocArXiv. Detalhes em `git log`.

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
├── AGENTS.md                          # Memória operacional para Codex (fonte principal atual)
├── CLAUDE.md                          # Memória legada para Claude; manter sincronizada com AGENTS.md
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

**Status** (2026-05-10): As provas Lean existentes verificam a arquitetura anterior e devem ser tratadas como segurança interna legada. Elas precisam ser atualizadas antes de qualquer uso substantivo, porque a correção de majority outside option externa e strict BF feasibility invalidou partes centrais da prova antiga.

### O que o Lean verificava antes da correção de 2026-05-10

- **Theorem 1** (conditional dominance iff): ÁLGEBRA COMPLETA — 19 teoremas encadeados
- **Prop 1** (majority affine + λ_M > α): ÁLGEBRA COMPLETA
- **Prop 3** (screening jump): ÁLGEBRA COMPLETA
- **Prop 2** (R1 cutoff): LÓGICA ABSTRATA — IVT correto, boundary values assumidos
- **Corollary** (F_U ⊆ F_M): LÓGICA ABSTRATA — budget identities assumidas
- **Prop 4** (classificação): LÓGICA ABSTRATA — herda gaps do Corollary
- **LemmaVWMax** (V_W global max): PARCIAL — 1/4 candidatos verificados

**Não usar esse status como evidência atual.** A nova arquitetura precisa formalizar `lambda_M^E`, `kappa_M^E`, o regime `A/C/R`, a factibilidade BF e o lower bound do ramo H-proposer.

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

- **AGENTS.md é a fonte operacional principal para Codex**. Atualizar `AGENTS.md` e `CLAUDE.md` quando o status das provas mudar.
- **Não confiar no corpo principal para status das provas** até a próxima rodada de revisão textual; o appendix corrigido é a referência atual.
- **REGRA CRÍTICA — Pareceres completos**: Ao rodar QUALQUER skill de review, o output COMPLETO DEVE ser salvo em `quality_reports/YYYY-MM-DD_nome-do-review.md`. NUNCA truncar. NUNCA salvar apenas resumo.
- **v5 é o paper ativo para revisão e eventual nova submissão**; v4 preservado intacto; v2 preservado como arquivo
- **Paper é documento atemporal**: NUNCA referenciar versões anteriores ou mudanças. Escrever como se o leitor visse pela primeira vez.
- Notas em Markdown, modelo formal em Rmd → PDF
- Idioma: português para notas; inglês para o paper
- N genérico sempre (N=3 apenas no exemplo motivador Seção 2)
- Sob maioria: W EXCLUI H (não convenção WLOG de inclusão)
- **Citações em ambientes LaTeX**: Dentro de `\begin{...}...\end{...}`, usar `[@key]` (bookdown resolve).
