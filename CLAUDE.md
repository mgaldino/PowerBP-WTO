# Informational Power: Bayesian Persuasion, Legislative Bargaining, and Institutional Design

## Projeto

Paper teórico sobre **por que um hegemon escolheria consenso** em organizações internacionais. O mecanismo: unanimidade força W a interagir com a informação privada de H, criando screening que gera não-convexidade no payoff de H. Bayesian Persuasion explora essa não-convexidade. Sob maioria, W exclui H da coalizão → sem screening → BP ineficaz.

### Resultado central
H prefere unanimidade não apesar das restrições, mas por causa delas. Unanimidade ativa poder informacional (BP + screening) que substitui poder de agenda. O consenso é uma tecnologia institucional de poder, não uma concessão.

## Status

- **Fase**: MODELO v2 COMPLETO (R2 + R1 + Entry + BP derivados). Falta teorema de comparação institucional. Paper deve ser REESCRITO incorporando o modelo e resultados da nota técnica.
- **Nota técnica**: `notes/2026-04-19_formalizacao_v2.Rmd` — contém toda a formalização, árvore do jogo, derivações, exemplos numéricos, gráficos. Esta nota é a BASE para reescrever o paper.
- **Paper antigo**: `formal_model.Rmd` — modelo anterior com erros identificados. Será substituído.

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
- **Maioria**: W inclui H a custo αV(θ) por convenção WLOG (indiferente entre incluir/excluir) → sem screening → V_H linear

### Screening cutoff (closed form)
μ_s = α(r-1)/(r-α). Substitui a cúbica do modelo anterior.

### Onde o screening vive
Screening acontece em R1, NÃO em R2 no equilíbrio. Se R2 é alcançado (θ=1 rejeita em R1), W sabe θ=1 com certeza — informação completa, sem screening. R2 é off-path threat.

### Resultado sem BP
Condicional à entrada: H prefere unanimidade (overpayment de θ=0), W prefere maioria. NÃO Pareto comparável. Para priors onde entry só ocorre sob maioria: M Pareto domina. BP viabiliza unanimidade induzindo entrada + explorando screening jump.

## TODOs

### PRÓXIMO PASSO (PRIORITÁRIO)
- [ ] **Inserir Lemma 1 + Theorem 1 revisados no paper** (`formal_model_v2.Rmd`)
  - Lemma 1: prova analítica completa via decomposição D_base + δ_R2 + δ_R1. Ver `notes/2026-04-21_lemma1_complete_proof.md`. Condição: α < α*(N,β). VERIFICADO numericamente.
  - Theorem 1: threshold prior p* com 4 casos e single-crossing property. Ver `notes/2026-04-21_revised_theorem1_threshold_prior.md`. S_U fully closed form. VERIFICADO numericamente (10/10).
  - Estratégias anteriores documentadas em `notes/2026-04-21_theorem1_proof_strategies.md`

### IMPORTANTES
- [ ] Condições paramétricas explícitas (β ≥ ?, α ≤ ?) para os rankings H e W
- [ ] Verificar se V_W(U) < V_W(M) é universal ou depende de parâmetros (agente encontrou inversão para β ≤ 0.5)

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

> **PAPER FUTURO** — extensão com outside options heterogêneas.

Pré-normalização: cada país tem o_i > 0 (potências médias com o_i intermediário). Pie V(S, θ) supermodular. Como potências médias alteram a escolha institucional?

## Convenções

- Notas em Markdown, modelo formal em Rmd → PDF
- Idioma: português para notas; inglês para o paper
- N genérico sempre (nunca especializar para N=3)
- x ≡ (N-1)αr como atalho notacional
