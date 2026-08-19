# N7 Fase A — relatório ao autor e decisão de protocolo pendente

**Data:** 2026-08-19  
**Estado:** bloqueado por finding substantivo de ciclo de vida  
**Hash público revisado:**
`sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`  
**N7:** `pending` e `unfrozen`  
**Fase B:** não autorizada

## 1. O que foi produzido

A Fase A produziu um candidato intermediário com 24 registros públicos:

- maioria e unanimidade;
- R2 antes de R1;
- situação baixa e situação alta de `H` públicas desde `t=0`;
- cobertura formal separada de `m=2` e `m>=3`;
- estratégias puras e aleatorização do proponente apenas entre coalizões
  payoff-equivalentes;
- payoffs por papel, outcomes, crenças, multiplicidade e fronteiras;
- nenhuma ligação com registros privados e nenhuma renda informacional.

O candidato, a derivação, o ledger e o verifier passaram nos testes locais. O
checker canônico manteve `N7` topologicamente pronto e o DAG manteve `N7`
`pending`.

## 2. Conclusão matemática provisória

O parecer independente de matemática e teoria dos jogos retornou `PASS 0/0/0`.
Sua rederivação fria confirmou:

- em R2-maioria, acordo imediato sem `H`, com `y=0`;
- em R2-unanimidade, acordo imediato com `H`, com `y=o_theta`;
- em R1-maioria, inclusão de `H` quando `o_theta<=1/m` e exclusão quando
  `o_theta>1/m`; a igualdade pertence à inclusão pelo tie-break do proponente;
- em R1-unanimidade, acordo imediato com `H` em todo o domínio;
- maioria supera atraso pelo ganho `1-beta*q/m>0`;
- unanimidade supera atraso pelo ganho `1-beta>0`;
- não há, no benchmark público, atraso, falha, mistura entre acordo e atraso ou
  multiplicidade apenas de crenças;
- a única correspondência não trivial é a escolha, sob maioria, entre coalizões
  payoff-equivalentes, que pode gerar assimetria de payoff entre identidades
  fracas sem alterar o outcome nem os payoffs de `H` e do proponente.

Essa conclusão permanece provisória porque o ciclo exigia dois PASS e o parecer
de desenho formal identificou o conflito abaixo.

## 3. Pareceres independentes sobre o mesmo hash

| Papel | Revisor | Veredicto | Critical | Major | Minor |
|---|---|---:|---:|---:|---:|
| `formal_design` | `review-n7-phaseA-formal-2026-08-19-r1` | FAIL | 1 | 0 | 0 |
| `game_theory` | `review-n7-phaseA-game-2026-08-19-r1` | PASS | 0 | 0 | 0 |

Os pareceres completos estão em:

- `quality_reports/2026-08-19_n7_phaseA_formal_design_review_round1.md`;
- `quality_reports/2026-08-19_n7_phaseA_game_theory_review_round1.md`.

## 4. Finding crítico transcrito integralmente

> **Critical — The Phase A contract amendment invalidates the frozen dependency
> that the candidate immediately consumes.** The current worktree changes the
> canonical contract’s Section 11 by replacing the former one-stage Goal 4
> review cadence with distinct Phase A review, an intervening author gate, and
> Phase B review (`quality_reports/plans/2026-08-12_essential_input_gate0.md`,
> lines 1113–1136). The same canonical contract states without exception that
> any alteration of Section 11 reopens the readiness Gate 0, returns every
> derivation node to `pending`, and invalidates prior reviews, freezing, and
> consumption authorization (lines 1229–1237). Nevertheless, the DAG still
> records `N6` as `pass/frozen`, the builder requires that state, and the ledger
> treats its hash as a frozen architectural dependency. The header’s statement
> that N6 closed and Phase A is open does not resolve the conflict because the
> contract’s single-source table assigns invalidation exclusively to Section 12,
> and no prospective-cadence or administrative-edit exception is defined there.
> Under the literal invalidation rule, N6 was not frozen when N7 Phase A began,
> so the candidate was produced before its dependency gate was satisfied and
> this review cannot validly supply a Phase A PASS. Treating the amendment as
> exempt instead requires a new substantive protocol rule. There is therefore
> no unique repair forced by the current text.

## 5. Classificação conforme a Seção 11.1

O finding é **substantivo** e cria uma `pending protocol decision`. Ele não é
um erro técnico com reparo único. A tensão é entre duas instruções normativas:

1. a nova autorização exigiu inserir na Seção 11 uma Fase A, um gate autoral e
   uma Fase B, preservando `N6` como dependência congelada;
2. a Seção 12.3 vigente diz que qualquer alteração da Seção 11 reabre o Gate 0
   de prontidão e devolve todos os nós a `pending`.

O implementador não pode decidir qual regra prevalece sem autorização autoral.

## 6. Leituras disponíveis e consequências

### Leitura A — aplicar literalmente a Seção 12.3

- A alteração da cadência reabre o Gate 0 de prontidão.
- `N1`, `N2`, `N3`, `N4`, `N6` e `N7` voltam administrativamente a `pending`.
- O conteúdo matemático congelado não é apagado, mas as interfaces inalteradas
  precisam ser novamente submetidas ao protocolo novo antes de consumo.
- Somente depois de restaurar o freeze válido de `N6` a Fase A pode ser
  reexecutada ou ratificada e novamente revisada.

### Leitura B — autorizar exceção administrativa prospectiva

- A divisão futura do Goal 4 em Fases A e B é declarada uma alteração de
  cadência que não invalida freezes já obtidos em `N1`–`N6`.
- A exceção precisa ser escrita pelo autor na fonte canônica de invalidação da
  Seção 12; não pode ser inferida pelo implementador.
- Com a exceção autorizada, `N6` permanece consumível, o mesmo hash público pode
  voltar aos dois revisores e o ciclo da Fase A pode buscar dois PASS.

As duas leituras mudam a validade temporal do consumo de `N6`; por isso não são
reparos editoriais equivalentes.

## 7. Pergunta ao autor

Qual regra deve governar esta alteração de cadência?

1. **Aplicar a Seção 12.3 literalmente**, resetando e ressubmetendo os freezes
   administrativos; ou
2. **Autorizar uma exceção prospectiva explícita**, preservando os freezes de
   `N1`–`N6` para esta divisão do Goal 4 em Fases A e B?

Até essa decisão, a Fase A não está concluída. Não haverá comparação com N6,
cálculo de `RI_M`, `RI_U` ou `DeltaRI`, freeze de N7, Goal 5, `beta=1` ou ação
em manuscritos.
