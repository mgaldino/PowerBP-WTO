---
title: "Post-Mortem: Informational Power Through Pivotality"
subtitle: "From initial commit to RIO submission in 12 days"
date: "2026-04-30"
output:
  html_document:
    toc: true
    toc_depth: 3
    toc_float: true
    theme: flatly
    highlight: tango
    css: null
---

# Post-Mortem: Informational Power Through Pivotality

**Projeto**: "Informational Power Through Pivotality: When a Hegemon May Choose Consensus"  
**Autor**: Manoel Galdino (USP)  
**Período**: 2026-04-18 a 2026-04-30 (12 dias de trabalho intensivo)  
**Resultado**: Submetido ao RIO + preprint no SocArXiv

---

## 1. Resumo do Projeto em Números

| Métrica | Valor |
|---------|-------|
| Commits | 52 |
| Dias de trabalho | 12 (18/04 a 30/04) |
| Versões do paper | 5 (v1 → v5, mais snapshots) |
| Paper final | 1.150 linhas RMarkdown |
| Scripts R | 37 arquivos, ~8.700 linhas |
| Quality reports | 123 arquivos |
| Notas de trabalho | 97 arquivos |
| Arquivos Lean 4 | 23 arquivos, ~2.200 linhas |
| `sorry` no Lean | **0** (zero) |
| Teoremas/lemas Lean | ~147 (contagem de `theorem`/`lemma` declarations) |
| Edmans reviews | ~34 relatórios (entre rounds e subcomponentes) |
| Devil's advocate rounds | 3 |
| Proofread rounds | 4 |
| Adversarial math reviews | 3 |
| Memory entries | 27 |
| Feedback memories | 15 (regras de conduta acumuladas) |

---

## 2. Timeline: Evolução do Modelo

| Data | Marco | Decisão-chave |
|------|-------|---------------|
| 04-18 | Initial commit: modelo v1 com agenda power assimétrica | Ponto de partida: H tem proposal advantage |
| 04-20 | **Redesign fundamental (v2)**: random proposals, V(θ), αV(θ) | Isolar voting rule como ÚNICA diferença |
| 04-21 | Lean verifica 8 resultados, K=3 extensão, lit review | Confiança nas provas; extensão explorada e descartada |
| 04-22 | v3: α* iff, Lemma 1 iff, entry scaling | Resultado central afiado: bicondicional |
| 04-24-25 | Restructuring: Thm1 + Thm2, referee response, Assumption 1 eliminada | Simplificação drástica: menos assumptions |
| 04-26 | Snapshot v4; decisão BP→screening only | **Decisão mais importante**: remover BP do corpo, screening central |
| 04-27 | v5 rewrite; continuous types; Edmans 7.5; OPEC | Paper assume forma final |
| 04-28 | OPEC case study calibrado | Empiria tangível conecta modelo à realidade |
| 04-29 | Lit review integrada (Hirsch standard), Lean v5 | Polish final seguindo benchmark publicado |
| 04-30 | Submissão RIO + SocArXiv | Done |

---

## 3. O Que Funcionou Bem

### 3.1. Simulação primeiro, prova depois ("simulation-first")

A heurística mais valiosa do projeto. **Toda** formalização foi precedida por verificação numérica em R. Isso:

- Detectou erros cedo (antes de investir em provas)
- Deu confiança para avançar rápido
- Criou um "test suite" implícito (37 scripts de verificação)
- Permitiu calibrar exemplos numéricos realistas

**Evidência**: Os 37 scripts R incluem `verify_*`, `test_*`, `check_*`, `sim_*` — todos escritos ANTES das provas formais correspondentes. O script `model_functions.R` (127 linhas, 5 funções core) é a "single source of truth" numérica.

**Quick win para o futuro**: Formalizar isso como um protocolo: para cada proposição, (1) implementar em R, (2) testar em grid, (3) só então provar.

### 3.2. Lean como rede de segurança (não como produto)

A decisão de usar Lean 4 como ferramenta *interna* — nunca mencionada no paper, nunca usada como base para escrita — foi acertada. Lean pegou 0 erros nas provas finais (o que é bom!), mas a confiança que isso gerou permitiu avançar mais rápido na escrita e nos reviews.

- 23 arquivos, ~2.200 linhas, 0 sorry
- Formalização v5 completa (7 arquivos dedicados)
- Classificação transparente: ÁLGEBRA COMPLETA / LÓGICA ABSTRATA / PARCIAL

**Lição**: Lean é mais valioso como *seguro contra catástrofe* do que como ferramenta de descoberta. Num paper com provas complexas e muitas versões, saber que a álgebra está mecanicamente verificada libera atenção cognitiva para a exposição.

### 3.3. Reviews multi-camada (pipeline de qualidade)

O uso sistemático de skills de review criou um pipeline de qualidade:

1. **Code review** (R scripts) → pegou bugs numéricos
2. **Edmans review** (3 dimensões: Contribution, Execution, Exposition) → diagnóstico estruturado
3. **Devil's advocate** (3 rounds) → identificou vulnerabilidades reais
4. **Proofread** (4 rounds) → catching typos, inconsistências
5. **Adversarial math review** → stress-test das provas
6. **Comparison Hirsch & Shotts** → benchmark publicado como espelho

**Números**: ~84 relatórios de review ao todo. A progressão do Edmans review é instrutiva:

| Versão | Edmans Score | Notas |
|--------|-------------|-------|
| v2 | ~5.5 | Modelo cru, sem aplicação |
| v3 | ~6.5 | Provas mais rigorosas, mas BP confusa |
| v4 | ~7.0 | Editorial polish |
| v5 round 1 | 7.0 | Screening central, mas exposição fraca |
| v5 round 2 | **7.5** | OPEC, lit review, Hirsch standard |

### 3.4. Separação reviewer/implementador

A regra "quem fix não review, quem review não fix" (memory: `feedback_reviewer_implementer_separation.md`) foi consistentemente respeitada. Agentes separados para review e implementação evitaram viés de confirmação e mantiveram a qualidade dos pareceres.

### 3.5. Documentação obsessiva (CLAUDE.md + MEMORY.md)

O CLAUDE.md do projeto é extenso (~220 linhas) e foi atualizado em quase toda sessão. Isso permitiu:

- Recuperação rápida entre sessões (protocolo session-recovery)
- Pendências sempre rastreáveis
- Decisões documentadas com justificativa

Os 27 memory entries capturaram decisões estruturais que persistiram entre sessões (ex.: "BP removido", "random proposals em ambas", "exclusão é feature").

### 3.6. Decisão corajosa: matar BP

A decisão de 04-26 — remover Bayesian Persuasion do corpo do paper, relegando-o a um Remark, e fazer screening o mecanismo central — foi a mais importante do projeto. Isso:

- Simplificou dramaticamente o argumento
- Eliminou a confusão BP/screening que todos os reviewers identificaram
- Permitiu o v5 como paper limpo e focado

A versão v4 foi preservada como snapshot (commit `621bff0`), respeitando a heurística de never-destroy-previous-versions.

### 3.7. Benchmark externo (Hirsch & Shotts)

Usar um paper publicado em top journal (AJPS 2025) como espelho de qualidade (`comparison_hirsch_shotts.md`) foi extremamente produtivo. Transformou "melhorar a exposição" de instrução vaga em checklist concreto com 20+ itens.

---

## 4. O Que Pode Melhorar

### 4.1. Excesso de versões intermediárias

5 versões numeradas em 12 dias é muita churn. A versão v3 durou apenas ~2 dias antes de virar v4, que durou ~1 dia antes de virar v5. Melhor abordagem: manter um único arquivo ativo com snapshots via git tags, em vez de criar `formal_model_vN.Rmd` a cada iteração.

**Quick win**: Usar git tags (`v2.0`, `v3.0`, etc.) em vez de arquivos separados. Manter apenas o arquivo ativo + arquivo preservado da versão anterior.

### 4.2. Excesso de quality reports

123 quality reports é provavelmente overkill. Muitos são incrementais (round 1, round 2, round 3 do mesmo review). O pipeline de qualidade foi valioso, mas poderia ser mais seletivo:

- Edmans: 1 review completo por versão major, não por sessão
- Proofread: combinar rounds em 1 relatório cumulativo
- Adversarial: 1 por versão major

**Quick win**: Para próximos projetos, definir ex ante: 1 Edmans full review por versão major (v2, v5, etc.), não por sessão.

### 4.3. Modelo "churning" vs. "sitting with it"

O ritmo de 52 commits em 12 dias (4.3/dia) sugere iteração muito rápida. Houve momentos em que uma pausa de 1-2 dias para "sentar com o resultado" teria evitado retrabalho. Exemplos:

- A decisão BP vs. screening (04-26) poderia ter sido tomada antes se houvesse mais tempo de reflexão após o v3
- O redesign fundamental (04-20) veio 2 dias após o initial commit — talvez o v1 merecesse mais maturação

**Contraargumento**: o ritmo rápido foi possível justamente por causa das ferramentas (Claude Code + Lean + R verification). O feedback loop é tão rápido que "sentar com" o resultado pode significar simplesmente rodar mais uma simulação em vez de esperar dias.

### 4.4. OPEC tardio

O OPEC case study foi adicionado apenas em 04-28, dois dias antes da submissão. Idealmente, a ilustração empírica deveria ter sido incorporada mais cedo no processo — desde o v3 pelo menos. O case study mudou a qualidade percebida do paper dramaticamente (hook na intro, calibração, predições testáveis).

**Lição**: Conectar modelo à realidade ANTES de polir a teoria. O case study não é decoração — ele disciplina as choices do modelo.

### 4.5. Notes vs. quality_reports: fronteira borrada

97 notas + 123 quality reports = 220 documentos de apoio. A distinção entre os dois nem sempre é clara. Alguns notes são de fato derivações que deveriam estar em quality_reports, e vice-versa.

**Quick win**: Para próximos projetos, definir ex ante:
- `notes/` = working notes do autor, scratchpad, ideias
- `quality_reports/` = output de skills de review, auditorias, planos formais

### 4.6. Pendências de exposição ficaram para o final

As 5 pendências Hirsch (concisão do modelo, game tree, intuição verbal, figuras com dados, policy na conclusão) foram identificadas em 04-27 mas nem todas foram resolvidas antes da submissão. Isso sugere que a exposição foi tratada como "último passo" em vez de integrada ao processo.

**Lição**: Integrar checks de exposição (Hirsch-style) desde o v3, não apenas na fase final.

---

## 5. Heurísticas que Funcionaram

| Heurística | Origem | Impacto |
|-----------|--------|---------|
| **Simulação primeiro** | memory: `feedback_simulation_first.md` | Alto — detectou erros antes de provar |
| **Lean é segurança, não produto** | memory: `feedback_lean_purpose.md` | Alto — liberou atenção cognitiva |
| **Separação reviewer/implementador** | memory: `feedback_reviewer_implementer_separation.md` | Alto — manteve qualidade de reviews |
| **Rigor absoluto em provas** | memory: `feedback_rigor_standard.md` | Alto — nunca minimizar issues |
| **Paper é documento atemporal** | memory: `feedback_no_changelog.md` | Médio — evitou linguagem de revisão |
| **Sem puxa-saco** | memory: `feedback_no_sycophancy.md` | Alto — reviews honestos |
| **Salvar scripts antes de rodar** | memory: `feedback_save_scripts.md` | Médio — reprodutibilidade |
| **Verificar arquivo canônico** | memory: `feedback_check_canonical_file.md` | Médio — evitou editar arquivo errado |
| **Exclusão é feature, não bug** | memory: `feedback_exclusion_feature.md` | Alto — reframing fundamental do modelo |
| **Random proposals em ambas** | memory: `feedback_random_proposals.md` | Alto — comparação justa, resultado limpo |

---

## 6. Heurísticas que Faltaram / Chegaram Tarde

| Heurística | Quando deveria ter sido adotada | Quando foi | Custo |
|-----------|-------------------------------|-----------|-------|
| Benchmark externo (Hirsch) | v3 (04-22) | v5 (04-27) | ~2 dias de retrabalho de exposição |
| Case study empírico cedo | v2 (04-20) | v5 (04-28) | Calibração tardia |
| Kill your darlings (BP) | v3 (04-22) | v4-v5 (04-26-27) | ~4 dias de ambiguidade BP/screening |
| Versionamento via git tags, não arquivos | v1 (04-18) | Nunca | 5 arquivos .Rmd no repositório |

---

## 7. Análise de Tempo

### Distribuição de commits por dia

| Data | Commits | Foco principal |
|------|---------|----------------|
| 04-18 | 2 | Setup, modelo v1 |
| 04-20 | 2 | **Redesign fundamental** (v2) |
| 04-21 | 13 | Lean, K=3, provas, lit review ← **pico de produtividade** |
| 04-22 | 5 | v3, α* iff, entry scaling |
| 04-24 | 2 | Restructuring |
| 04-25 | 13 | Referee response, provas, reviews ← **pico de retrabalho** |
| 04-26 | 5 | v4 snapshot, **decisão BP→screening** |
| 04-27 | 8 | v5 rewrite, continuous types, Edmans |
| 04-28 | 1 | OPEC case study |
| 04-29 | 1 | Lit review final, Hirsch |

Os dois picos (04-21 e 04-25) têm natureza diferente. O primeiro é produção genuína (provas, extensões, verificação Lean). O segundo é retrabalho pesado em resposta a reviews — Assumption 1 eliminada, Theorem 2 reescrito, referee response. Isso sugere que o v2 (04-20) foi publicado internamente cedo demais, antes de estabilizar.

### Distribuição de commits por tipo

| Tipo | Count | % |
|------|-------|---|
| feat (new content) | 14 | 27% |
| fix (corrections) | 19 | 37% |
| refactor | 7 | 13% |
| docs | 4 | 8% |
| outros (build, snapshot) | 8 | 15% |

A predominância de `fix` (37%) sobre `feat` (27%) é saudável num projeto de teoria formal — a maior parte do trabalho é corrigir e refinar, não adicionar.

---

## 8. Análise de Riscos Realizados e Evitados

### Riscos que se materializaram

1. **Modelo v1 incorreto** — O modelo com agenda assimétrica não funcionava. Custo: 2 dias. Mitigação: redesign radical (v2).
2. **Ambiguidade BP/screening** — Tentou manter BP e screening como co-protagonistas por ~6 dias. Custo: retrabalho de exposição. Mitigação: decisão kill-BP em 04-26.
3. **Provas com gaps** — Adversarial reviews e Lean identificaram gaps em provas intermediárias. Custo: reescrita de B.5, B.7, B.8. Mitigação: pipeline de verificação.

### Riscos evitados

1. **Prova errada no paper publicado** — Lean 4 (0 sorry) + adversarial math review + simulação numérica. Três camadas independentes.
2. **Paper BP-confuso** — A decisão de matar BP antes da submissão evitou o risco #1 identificado em TODOS os devil's advocate rounds.
3. **Paper sem aplicação empírica** — O OPEC case study, embora tardio, transformou um paper puramente abstrato em algo publicável em RIO.

---

## 9. O Papel da IA (Claude Code)

### O que a IA fez bem

- **Derivações algébricas**: Manipulação de expressões longas, verificação de budget identities, simplificação
- **Lean 4**: Tradução de provas do paper para Lean, iteração tática
- **R scripts**: Implementação de funções do modelo, scripts de verificação, figuras
- **Reviews estruturados**: Edmans, Devil's advocate, proofread — feedback consistente
- **Escrita**: Rascunhos de seções, reescrita de parágrafos, style editing
- **Pesquisa bibliográfica**: Lit review, identificação de papers relacionados

### O que exigiu julgamento humano (o autor)

- **Redesign do modelo** (random proposals, exclusão como feature) — insight teórico central
- **Decisão BP→screening** — julgamento sobre o que é o "ponto" do paper
- **OPEC como caso** — escolha substantiva de ilustração empírica
- **Escolha do journal** (RIO) — avaliação do campo e do fit
- **Interpretar reviews** — distinguir feedback válido de ruído
- **Kill your darlings** — decidir o que cortar (K=3, BP, Assumption 1)

### O que não funcionou

- **Sycophancy residual**: Apesar do feedback explícito (memory: `feedback_no_sycophancy.md`), reviews iniciais tendiam a ser lenientes demais. A calibração melhorou ao longo do projeto.
- **Overproduction**: A facilidade de gerar relatórios levou a excesso (123 quality reports). Nem todos foram lidos.

---

## 10. Quick Wins para Próximos Projetos

1. **Git tags, não arquivo novo por versão** — Elimina proliferação de `formal_model_vN.Rmd`
2. **Case study na v2, não na v5** — Disciplina as escolhas do modelo desde cedo
3. **Benchmark externo na v3** — Encontrar um Hirsch & Shotts equivalente cedo no processo
4. **Cap de quality reports** — Max 1 Edmans full + 1 Devil's advocate + 1 Proofread por versão major
5. **"Sit with it" day** — Após cada versão major, 1 dia sem commits para reflexão
6. **Kill your darlings earlier** — Se um reviewer identifica confusão X em round 1, não esperar round 3 para resolver
7. **Protocolo formal de simulação-primeiro** — Template: (1) implementar em R, (2) grid test, (3) provar. Já existe informalmente; formalizar como skill.
8. **Lean from day 1** — Iniciar formalização junto com a simulação, não depois. Lean pode pegar erros que R não pega (erros de lógica vs. erros numéricos).
9. **Entry cost da nota Edmans**: definir antes da primeira sessão qual é o piso de score para submissão. Neste projeto foi implicitamente 7.0-7.5; explicitar evita decisões de "mais um round".
10. **Dashboard como ritual de sessão**: atualizar o dashboard ao final de cada sessão (não apenas quando lembra). A regra existe em `dashboard-update.md` mas nem sempre foi seguida.

---

## 11. Métricas de Processo vs. Resultado

### Processo

| Métrica | Valor | Benchmark |
|---------|-------|-----------|
| Tempo até submissão | 12 dias | Excepcional para paper teórico formal |
| Commits/dia | 4.3 | Alto (produção assistida por IA) |
| Reviews/versão | ~6-8 | Provavelmente excessivo; 3-4 seria suficiente |
| Lean sorry | 0 | Excelente |
| Erros pegos por Lean | ~0 na v5 final | O valor está na confiança, não na detecção |

### Resultado

| Métrica | Valor |
|---------|-------|
| Edmans score final | 7.5/10 (R&R minor) |
| Devil's advocate score final | ~75/100 (recalibrado) |
| Journal target | RIO (top field journal em IO governance) |
| Preprint | SocArXiv v3 |
| Contribuição principal | Mecanismo novo: screening sob pivotalidade |

---

## 12. Conclusão

O projeto demonstrou que a combinação **Claude Code + Lean 4 + R numérico + pipeline de reviews** pode comprimir dramaticamente o ciclo de produção de um paper teórico formal — de meses para dias. Mas a compressão tem custos: excesso de versões, overproduction de documentos auxiliares, e risco de "churning" sem reflexão.

As heurísticas mais valiosas — simulação primeiro, Lean como segurança, separação reviewer/implementador, rigor absoluto — são todas sobre **disciplina**, não velocidade. A IA amplifica o que você já faz bem e o que faz mal. As feedback memories acumuladas (15 regras) são, no fundo, um manual de disciplina construído iterativamente.

O paper que saiu é substantivamente diferente do que entrou (v1: agenda assimétrica → v5: screening sob pivotalidade). Isso não é fracasso do processo — é o processo funcionando. A capacidade de pivotar rapidamente, com verificação em cada passo, é o que permitiu chegar a um resultado correto em 12 dias em vez de meses.
