# Preflight pós-comparação — candidato do implementador `A_U` M/S/B

**Data:** 2026-08-29  
**Resultado:** `PASS`  
**Status substantivo:** candidato completo e hash-pinado; projeto permanece
`pending/unfrozen` até dois pareceres independentes

## Snapshot e sequência

```text
worktree: /private/tmp/PBP-am-msb
branch: agenda-extension-am-msb
HEAD de entrada da fase comparativa: c193f3b
blind-lock anterior à leitura histórica: c193f3b
```

O snapshot inicial da tarefa foi
`3da7a03afc682da2fc3d11735927da5c290f2589`. O blind-lock foi criado no
commit local `c193f3b` antes da leitura de qualquer candidato histórico. A fase
pós-comparação modificou somente novos artefatos `A_U_msb`, o novo relatório de
comparação e o novo output mecânico. Nenhum arquivo histórico foi alterado.

## Verificações finais

```text
JSON interface: válido
JSON DAG: válido
TSV ledger: 16 campos em todas as linhas
DAG com ordem de execução: VALID
R pós-comparação: 1095 PASS / 0 FAIL
git diff --check: PASS
C_U corrente: f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b
```

O novo teste adicional fixa a coordenada literal que motivou a única precisão
pós-comparação: em uma rejeição com `mu=0`, o payoff fraco contrafactual de
`theta=1` é zero. O preço de voto `a` continua sendo o valor esperado sob o
posterior zero e não substitui esse payoff realizado.

## Limites e autorização

- O R não prova completude de PBE, desvios globais, existência pointwise do
  limite local de Bayes nem mensurabilidade de binders simbólicos.
- O implementador não fez parecer e não marcou o projeto `A_U` como
  `pass/frozen`.
- Dois pareceres externos independentes sobre os mesmos hashes continuam
  obrigatórios.
- `AC` não foi derivado, revisado ou alterado.
- Não houve tag, merge, push nem edição do manuscrito.

As skills `solve-dynamic-games` e `formal-game-theory-polisci` governaram o
contrato, o DAG, a ordem reversa e os gates durante as duas fases.
