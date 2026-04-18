# Informational Power: Bayesian Persuasion, Legislative Bargaining, and Institutional Design

## Projeto

Paper teórico unificando **mensuração de poder informacional** (via Bayesian Persuasion no framework de Kalandrakis/Baron-Ferejohn) com **explicação de variação institucional** (por que legislaturas usam maioria + proposal power, enquanto OIs usam consenso + informational power).

### Resultado central: Pacotes Institucionais e Poder Informacional
Hegemon = sender (info) + proposer (agenda). A escolha institucional não é apenas regra de votação, mas **pacotes institucionais**: {maioria + agenda control} (Pacote A) vs {consenso + sem agenda control} (Pacote C). Pacotes intermediários não são viáveis (consenso + agenda destrói adesão; maioria sem agenda → efeito de exclusão). Sob Pacote A, H extrai via coalizões mas fracos antecipam exploração → threshold de entrada alto. Sob Pacote C, H voluntariamente abre mão do agenda control (mantê-lo destruiria adesão) mas BP é mais eficaz → threshold baixo. O trade-off fundamental: **extração via agenda power (Estágio 2) vs extração via poder informacional (Estágio 1)**. H prefere consenso quando g (valor intrínseco) é alto e p (prior) é baixo.

## Status

- **Fase**: MODELO EM DESENVOLVIMENTO. Arquitetura de 3 estágios definida, simulação validada para N=2,3,5.
- **Modelo v4 (pie size)**: Abandonado por linearidade fundamental.
- **Caminho A (outside option)**: Abandonado — outside option privada é implausível.
- **Caminho B (multidimensional)**: Não formalizado.
- **Modelo atual (consenso como compromisso)**: 3 estágios — escolha de regra → BP + entrada → redistribuição. Stage 2 derivado (não pressuposto). Simulação confirma trade-off. Ver `modelo_consenso_compromisso.md`.
- **Target**: formalizar proposições analíticas, estender para horizonte infinito.

## Resultados do modelo v4 (pie size — ABANDONADO)

O modelo v4 inteiro (incluindo todas as proposições) está abandonado por linearidade fundamental. Não há extensão β — surplus destruction foi descartado por violar KISS e não produzir persuasão genuína.

## Caminho A: outside option como info privada

Mecanismo funciona: screening do proponente cria não-linearidade → BP gain > 0 sob unanimidade, = 0 sob maioria. Simulado para N até 1001. **Problema conceitual**: outside option privada ("S sabe seu próprio custo de no-deal, outros não") é implausível. Status quo não é privado.

**Detalhes**: ver `novo_caminho_outside_option.md`, `sim_titl_2player.R`, `sim_bf_nplayer.R`, `report_bf_results.Rmd`.

## Caminho B: acordo multidimensional + conhecimento de preferências

S sabe as preferências/reservas de cada jogador. O acordo é multidimensional (R^K). S identifica o conjunto factível e escolhe o acordo ótimo para si. O valor dessa informação é maior sob unanimidade (factível = interseção, difícil de achar) que sob maioria (factível = união de coalizões, fácil de achar). **Problema formal**: como simplificar sem spatial voting?

**Detalhes**: ver `alternativa_multidimensional.md`.

## Puzzle central

**Por que EUA aceitam consenso na OMC?** Sob maioria+agenda, extrairiam mais via coalizões. A resposta: poder informacional (BP) substitui poder de agenda sob consenso. O consenso torna a persuasão mais eficaz ao proteger fracos de exploração futura, reduzindo o threshold de entrada.

## Modelo atual: Pacotes Institucionais e Poder Informacional (V(θ)-dependent pie)

**Pacotes institucionais**: a escolha não é apenas regra de votação, mas pacotes que combinam regra + agenda. Pacote A = {maioria + agenda control}. Pacote C = {consenso + sem agenda control}. Pacote B (consenso + agenda) é inviável (destrói adesão). Pacote D (maioria sem agenda) é dominado (efeito de exclusão).

**Info privada**: θ ∈ {0,1} = qualidade do acordo cooperativo. H sabe θ (capacidade analítica, inteligência). Plausível e simples.

**Pie θ-dependente (DEFINITIVO)**: o tamanho do pie no Estágio 2 depende do estado: V(θ) = 1 + θδ. Quando θ=1, pie = 1+δ (acordo bom amplia o bolo); quando θ=0, pie = 1 (baseline). Isso substitui o modelo baseline com pie constante = 1.

**Não-linearidade**: decisão binária de entrada (threshold) — não é divisão de pie (que seria linear sob TU).

**Resultados-chave com V(θ)**:
- Threshold de entrada: τ(R) = (c/s_W(R) − 1)/δ, onde s_W(R) é o share de W no Estágio 2. τ depende de δ.
- Condição de dominância: envolve v(τ,R)/τ — τ aparece tanto no numerador quanto no denominador.
- ∂p*/∂δ é **ambíguo** — resultado não-trivial novo. δ alto não necessariamente favorece consenso.
- Para δ alto, τ(A) > 1 → Pacote A se torna **inviável** (threshold ultrapassa o suporte de θ). Nesse regime, consenso domina trivialmente.

**Trade-off fundamental**: extração via agenda power (Estágio 2, Pacote A) vs extração via poder informacional (Estágio 1, Pacote C). Sob consenso, H voluntariamente abre mão do agenda control porque mantê-lo destruiria a adesão dos fracos.

**Arquitetura**: ver `modelo_consenso_compromisso.md` para especificação completa.

## Referências-chave

### Barganha legislativa
- Kalandrakis (2006, AJPS) — Proposal rights e poder político
- Baron & Ferejohn (1989) — Modelo base
- Eraslan & Evdokimov (2019) — Survey

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
├── modelo_consenso_compromisso.md     # Arquitetura formal do modelo (companion)
├── substack_note.Rmd / .html          # Nota para Substack (público informado)
├── references.bib                     # Referências bibliográficas
├── scripts/
│   ├── sim_consenso_bp.R              # Simulação principal (N=2,3,5)
│   ├── sim_titl_2player.R             # Caminho A: TITL 2-player
│   └── sim_bf_nplayer.R               # Caminho A: BF N-player
├── figures/                           # Figuras geradas pelos scripts
│   ├── fig_payoff_by_N.png
│   ├── fig_regiao_by_N.png
│   ├── fig_crossover_by_N.png
│   ├── fig_bp_gain_by_N.png
│   ├── fig_exclusion_bf.png
│   └── fig_crossover_vs_alpha.png
├── notes/                             # Notas exploratórias e caminhos anteriores
├── formal_model.Rmd                   # Modelo formal ATUAL (V(θ)-dependent pie)
├── archive/
│   ├── formal_model_v1_baseline.Rmd   # Modelo baseline antigo (pie constante = 1)
│   └── ...                            # Modelos abandonados (v4, Caminho A)
├── references/                        # PDFs de referências
├── quality_reports/                   # Planos e relatórios de qualidade
└── formal_proofs/                     # Verificação formal em Lean 4
    ├── FormalProofs/Basic.lean         # Definições do modelo (GameParams, V_e, etc.)
    ├── FormalProofs/Prop1.lean         # Proposição 1: screening cutoff (N=3)
    └── FormalProofs.lean              # Import hub
```

## Verificação Formal (Lean 4)

Provas formais dos resultados estão em `formal_proofs/`.

- **Verificar**: `cd formal_proofs && lake build`
- **Adicionar módulo**: criar arquivo em `formal_proofs/FormalProofs/` e importar em `FormalProofs.lean`
- **Atualizar Mathlib**: `cd formal_proofs && lake update && lake exe cache get`

Use `/lean-proofs` para formalizar proposições e teoremas do paper.

### Status atual

| Resultado | Arquivo | Status |
|-----------|---------|--------|
| Prop 1 — Affinity (Package A) | Prop1.lean | VERIFIED |
| Prop 1 — Screening cutoff exists | Prop1.lean | VERIFIED (IVT) |
| Prop 1 — Screening cutoff unique | Prop1.lean | sorry (single-crossing) |
| Prop 1 — Jump positive | Prop1.lean | VERIFIED |

## Paper Futuro: Erosão Endógena do Poder Informacional e o Fracasso de Doha

> **PAPER FUTURO** — não faz parte do modelo atual. Ideia para paper subsequente.

**Premissa**: Assume o resultado do modelo atual — H aceitou consenso (Pacote C). Modela o que acontece DEPOIS, num jogo repetido de rodadas comerciais.

**Setup**: Jogo repetido dentro de uma instituição consensual. Cada rodada: natureza sorteia θ independente. H observa θ, usa BP para persuadir. Fracos recebem x_i.

**Mecanismo — aprendizado endógeno**: A cada rodada, o agente representativo fraco decide se investe uma fração dos ganhos x_i para aprender o valor de V (e indiretamente, o take de H). Em equilíbrio, investem um pouco por rodada. Isso vai reduzindo a variância das crenças sobre V/H ao longo do tempo. O poder informacional de H se erode — BP fica menos eficaz. H extrai cada vez menos.

**Mecanismo de colapso**: H tem custo de manter o bem público (financiar a OMC, participar). Se o custo de H é maior que dos demais, em algum momento futuro a extração via BP cai abaixo desse custo. H abandona a organização porque consenso não é mais vantajoso. **O sucesso de cada rodada cria as sementes da própria destruição da organização.**

**Punchline**: Explica o fracasso de Doha. Rodadas iniciais do GATT/OMC funcionaram porque H extraía via poder informacional. Cada rodada bem-sucedida ensinou os fracos sobre V e a extração de H. Eventualmente, os fracos aprenderam o suficiente para que H não consiga extrair surplus suficiente para justificar o custo de manutenção. Doha trava não por má-fé, mas porque o mecanismo que fazia consenso funcionar (assimetria informacional) foi endogenamente erodido pelo sucesso da instituição.

**Notas técnicas**: Conceito de solução: PBE no jogo repetido. Aprendizado dos fracos é atualização bayesiana com aquisição custosa de informação. Resultado-chave: existe T* finito após o qual H prefere sair. Literatura relacionada: aquisição endógena de informação (Persico 2004, Martinelli 2006), decadência institucional.

## Convenções

- Notas em Markdown, modelo formal em Rmd → PDF
- Idioma: português para notas; inglês para o paper
