# Goal 2: migração do baseline limpo para `formal_model_v6.Rmd`

**Projeto:** Informational Power Through Pivotality
**Data:** 2026-08-04
**Fonte formal canônica:** `model_redesign/power_architecture_derivations.Rmd`
**Alvo editorial:** `formal_model_v6.Rmd`
**Alvo compilado:** `formal_model_v6.pdf`
**Estado inicial:** matriz e auditoria de sobrevivência autorizadas; edição do
manuscrito condicionada à aprovação explícita do snapshot `paper-version`.

## Objetivo

Migrar para `formal_model_v6.Rmd`, sem ampliar o escopo provado, o baseline
limpo já fechado no laboratório formal. A migração deve substituir a
arquitetura antiga, preservar a coerência entre primitivas, resultados,
provas e exposição, compilar pelo formato YAML/bookdown e receber revisão
independente formal, adversarial, de reprodutibilidade e do PDF.

O baseline transportável contém exclusivamente:

- `pi_H=0` em todas as rodadas;
- `b_theta=0`;
- payoff corrente de `H` igual a `y` quando o acordo o inclui;
- opt-out imediato, irreversível e sem desconto `o_theta` depois de `H` votar
  não no Round 1;
- votação simultânea dentro de cada ballot, com publicação posterior do vetor;
- opção externa de `H` fora do bolo institucional;
- PBE sob a avaliação *weak-vote-passive*;
- comparação institucional condicional ao domínio comum derivado de
  existência de PBE.

Não integram este Goal: delayed continuation como payoff do voto não de `H`,
`max{o_theta,beta C_theta}`, `t_theta=d_theta-b_theta`, `pi_H>0`, escolha
endógena da regra, votação roll-call, a arquitetura de viabilidade/C-B-R,
unicidade irrestrita ou qualquer caracterização de todos os PBEs fora dos
escopos provados.

## Fontes obrigatórias

Antes de qualquer edição, ler integralmente:

1. `AGENTS.md`;
2. `quality_reports/2026-08-03_clean_baseline_goal1_status.md`;
3. `quality_reports/2026-08-04_clean_optout_findings_natural_language.Rmd`;
4. `quality_reports/2026-08-04_clean_optout_next_session_handoff.md`;
5. `model_redesign/power_architecture_derivations.Rmd`;
6. `quality_reports/2026-08-04_gate0_independent_audit.md`;
7. os três pareceres finais do Goal 1;
8. `quality_reports/plans/2026-08-03-clean-baseline-goal.md`;
9. `formal_model_v6.Rmd` e `formal_model_v5.Rmd` apenas como referências.

## Proveniência inicial verificada

- Git root: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion`.
- Worktree: limpo na verificação inicial.
- `HEAD`: `148cd9c5a3432ace08f9d7c1d975d01434bf08fa`.
- Commit analítico fechado e ancestral de `HEAD`:
  `4467da58f99b1cf75b22e5bfca1a08ccf80d9be1`.
- Tag existente: `pre-clean-optout-goal1-2026-08-03` ->
  `84a644128586d4f4d81c022cd7d3e09454ee8004`.
- SHA-256 inicial de `formal_model_v6.Rmd`:
  `f18a999300c88e32bdc7542f3249cd258afd19a0c251c0b29c2c387a7131dbc1`.
- `formal_model_v6.Rmd` não mudou entre o commit analítico e `HEAD`.

## Gate -1: snapshot `paper-version`

Este Gate precede qualquer edição de `formal_model_v6.Rmd`.

1. Concluir e versionar a matriz e a auditoria de sobrevivência.
2. Confirmar novamente `git status --short --branch`, `HEAD` e o hash de v6.
3. Solicitar aprovação explícita do usuário para a tag anotada proposta:
   `pre-clean-optout-goal2-migration-2026-08-04`.
4. Mensagem proposta: `Pre-Goal-2 snapshot after clean opt-out closure and
   migration audit, before formal_model_v6 reset`.
5. Criar a tag somente em worktree limpo e registrar o commit resolvido.
6. Não fazer push da tag sem autorização separada.

**Gate -1 PASS:** tag aprovada, criada sobre o commit pré-migração correto e
worktree limpo. Sem aprovação, o Goal permanece pausado antes do manuscrito.

## Gate 0: matriz e auditoria de sobrevivência

A matriz canônica é
`quality_reports/2026-08-04_clean_baseline_goal2_migration_matrix.md`.

Ela deve mapear cada primitivo, resultado, prova, figura, tabela, exemplo e
claim relevante do laboratório para o local correspondente em v6 e usar
exatamente uma destas classificações:

1. `sobrevive sem alteração`;
2. `sobrevive com reescrita`;
3. `precisa de nova prova`;
4. `deve ser removido do baseline`.

Um auditor independente e read-only deve confirmar que a matriz cobre todo o
manuscrito e não promove arquitetura antiga. Itens em `precisa de nova prova`
ficam fora da migração, salvo se forem primeiro derivados no workspace formal,
verificados e aprovados pelo mesmo protocolo do Goal 1.

**Gate 0 PASS:** matriz completa e veredito independente `PASS` sem ressalva
substantiva. Nenhuma edição de v6 é permitida antes desse veredito.

## Fase 1: implementação editorial controlada

Um implementador dedicado, que não participará das revisões, deve:

1. editar `formal_model_v6.Rmd`, preservando o YAML/bookdown;
2. manter `formal_model_v5.Rmd` e o laboratório formal como referências
   read-only;
3. substituir a definição do jogo por uma versão autônoma do contrato Gate 0;
4. transportar os resultados e provas na ordem de backward induction:
   R2 unanimidade, R2 maioria, R1 unanimidade, R1 maioria por tamanho do grupo,
   fronteiras, limites laterais, entry/nesting e comparação condicional;
5. preservar os domínios, quantificadores, ties, regiões de não existência e
   escopos exatos de PBE;
6. distinguir prova, bound, limite lateral e checagem numérica;
7. reescrever abstract, introdução, exemplo motivador, discussão e conclusão
   de acordo com os resultados efetivamente transportados;
8. remover o exemplo numérico, figuras, tabelas e chunks da arquitetura antiga;
9. não introduzir nova ilustração numérica sem script R separado, derivação
   identificável e revisão independente;
10. reconstruir todas as captions, tabelas e a notação para a arquitetura
    `o_theta` limpa;
11. manter textos do paper em inglês impecável e artefatos de auditoria em
    português ou inglês consistente.

### Resultados que devem aparecer

- R2 unanimidade: `S(nu)=max{P,L(nu)}`, com `P=1-o1`,
  `L(nu)=(1-nu)(1-o0)` e cutoff terminal exato.
- R2 maioria: payoff fraco per capita `1/m`, com outside option externo.
- R1 unanimidade no domínio regular: existência se e somente se
  `beta*o1>=o0` e `G_P>G_L`; quando existe, todo PBE regular tem a mesma classe
  on-path pooling `y=o1`.
- Resultados de fronteira separados para `o0=0`, `o1=1` e `beta=1`, além dos
  limites laterais para priors degenerados.
- R1 maioria: security value `F_M=max{E,B_M,P}`, existência e correspondência
  de payoffs específicas para `N=3`, `N=4` e `N>=5`.
- No-Cheap-H rederivado como condição uniforme `o0>=k*beta/m`, sem alegar que
  ela elimina separação em grupos grandes.
- Entry nesting e ranking de `H` somente no domínio comum derivado de PBE.

## Fase 2: verificações reproduzíveis

Executar os seis verificadores fechados do Goal 1 com `Rscript --vanilla` e
preservar 96/96:

- `verify_clean_optout_protocol_piH0.R`;
- `verify_clean_optout_R2_piH0.R`;
- `verify_clean_optout_R1_piH0.R`;
- `verify_clean_optout_majority_piH0.R`;
- `verify_clean_optout_entry_classification_piH0.R`;
- `verify_clean_optout_boundaries_piH0.R`.

Criar `scripts/verify_clean_optout_v6_integration.R` somente para checks de
integração do manuscrito: marcadores obrigatórios, arquitetura proibida,
claims numéricos eventualmente mantidos, labels e consistência de domínios.
O script deve usar `dplyr::select` ao selecionar colunas, falhar com status não
zero, registrar inputs, outputs, data, `HEAD` e `sessionInfo()`, e distinguir
checagem textual/computacional de prova.

Não reaproveitar tabelas ou figuras da arquitetura antiga apenas porque ainda
existem no repositório. Artefatos não usados podem permanecer como história,
mas não podem ser incluídos ou citados pelo baseline migrado.

## Fase 3: compilação e auditoria do artefato

Compilar exclusivamente pela configuração YAML/bookdown:

```r
rmarkdown::render("formal_model_v6.Rmd")
```

Não forçar `output_format="pdf_document"`.

Gates mínimos:

- todos os scripts retornam exit zero;
- `git diff --check` sem erro;
- `formal_model_v6.pdf` existe e `pdfinfo` é válido;
- `pdftotext -layout` funciona;
- nenhuma referência, citação, equação, figura ou tabela aparece não resolvida;
- todas as figuras e tabelas têm número, caption e chamada no texto;
- auditoria textual distingue usos legítimos de continuação após `H`-yes de
  usos proibidos como payoff do próprio `H`-no;
- rasterização e inspeção visual de todas as páginas, pois a migração é ampla;
- hash do Rmd e do PDF registrado no candidato revisado.

## Fase 4: revisão independente e repair loop

Fixar a implementação em um commit candidato. Quem implementa não revisa e
quem revisa não edita.

Executar em ondas independentes:

1. **Formal-model review:** três dimensões read-only — design, apresentação
   técnica e exposição — consolidadas em um veredito formal.
2. **Adversarial game-theory audit:** PBE, crenças, ICs, opt-out, ballots
   simultâneos, existência, multiplicidade, limites e comparações.
3. **Reprodutibilidade/R:** reprodução em extração limpa do commit, 96/96,
   outputs byte a byte e auditoria do verificador de integração.
4. **PDF:** inspeção textual e visual integral, incluindo captions, tabelas,
   referências, paginação, overflows e legibilidade.

Se qualquer veredito for `REPAIR` ou trouxer ressalva substantiva:

1. o implementador corrige;
2. registra `finding | resposta | arquivo/objeto | teste`;
3. cria novo commit candidato;
4. os revisores rerevisam o mesmo novo estado;
5. repetir até todos emitirem `PASS` sem ressalvas substantivas.

## Non-goals

- Não editar `formal_model_v5.Rmd`.
- Não reabrir o Goal 1 nem alterar suas primitivas.
- Não adicionar `pi_H>0`, regra endógena, delayed continuation, hybrid exit ou
  a decomposição `t_theta=d_theta-b_theta`.
- Não ressuscitar P/L/D ou P/L/R como redução global.
- Não ressuscitar o lema weak-caused-nonpivotal sem nova prova no contrato
  limpo.
- Não alegar majority no-screening, unicidade ou dominância global fora do
  escopo provado.
- Não chamar *weak-vote-passive* de refinement, D1, Intuitive Criterion ou
  sequential equilibrium.
- Não converter grids e scripts em provas universais.
- Não empurrar commits, tags ou artefatos para remotos sem autorização.

## Definition of Done

O Goal 2 só pode ser marcado como concluído quando:

1. Gate -1 registra snapshot aprovado em worktree limpo.
2. Gate 0 registra matriz completa e auditoria independente `PASS`.
3. v6 contém somente a arquitetura limpa e os escopos provados.
4. todos os resultados promovidos têm prova ou bound correspondente no
   laboratório fechado; itens que precisavam de nova prova foram omitidos.
5. os seis verificadores continuam em 96/96 e a integração passa.
6. o YAML/bookdown compila e produz PDF válido.
7. referências, captions, tabelas, figuras, equações e claims passam.
8. a auditoria textual não encontra arquitetura antiga promovida como baseline.
9. os revisores formal, adversarial, R/reprodutibilidade e PDF emitem `PASS`
   sem ressalvas substantivas sobre o mesmo commit candidato.
10. o relatório final registra commits, hashes, comandos, outputs, mudanças,
    findings, respostas e limitações.
11. `AGENTS.md` e `CLAUDE.md` são atualizados administrativamente sem alterar o
    conteúdo substantivo já revisado.

Quase conclusão, existência do PDF ou ausência de erro de compilação não
substituem esses gates.
