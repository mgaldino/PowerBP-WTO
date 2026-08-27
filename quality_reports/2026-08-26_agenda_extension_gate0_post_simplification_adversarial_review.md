# Parecer adversarial pós-simplificação

**Data:** 2026-08-26  
**Natureza:** revisão independente, estritamente `read-only`  
**Candidato coberto:** Gate 0 simplificado da extensão de agenda

O revisor leu primeiro o parecer adversarial inicial e depois comparou
integralmente o contrato, o DAG e os quatro ledgers históricos com o novo
conjunto simplificado. Nenhum arquivo foi criado ou alterado pelo revisor.

## Findings

- **Críticos:** 0.
- **Importantes:** 0.
- **Menores:** 0.

Há duas limitações residuais, mas não são defeitos do candidato:

- **Matemática:** caracterizar a correspondência completa com propostas
  Borelianas e Bayes local continuará difícil. Agora isso está corretamente
  declarado como obrigação de prova humana, não como promessa do programa.
- **Administrativa:** durante a produção do pacote privado, `A_M`, `A_U` e
  `AC` permanecerão candidatos até a revisão conjunta. Isso é executável porque
  `AC` deve citar os hashes exatos de `A_M` e `A_U`, e qualquer alteração
  invalida os consumidores. Não é necessário novo estado administrativo nem
  freeze intermediário.

## Respostas às perguntas da auditoria

1. **A simplificação respondeu às críticas iniciais?** Sim. Removeu as
   alegações impossíveis do verifier, reduziu schemas, eliminou cópia de
   payloads, tornou `AR` opcional e concentrou autorizações e pareceres em
   fronteiras científicas.
2. **Preservou o conteúdo substantivo?** Sim. Permanecem jogadores, tipos,
   ações, informação, factibilidade, implementação, payoffs, datas, aplicação
   única de `beta`, PBE com votação as-if-pivotal e aceitação na indiferença,
   Bayes local, correspondência completa e conjunta, family records, binder
   atômico e continuação literal completa, pública e comum aos tipos.
3. **A separação entre código e prova humana é executável?** Sim. O programa
   fica limitado a estrutura, hashes, schemas, quotas, transições finitas,
   datas, desconto, consistência de IDs/binders e testes de fórmulas fornecidas.
   Existência, completude, desvios no contínuo, mensurabilidade e Bayes local
   ficam explicitamente com prova e revisão humana.
4. **`AR` opcional e revisão conjunta de `A_M/A_U/AC` preservam rigor?** Sim.
   `AR` não é necessário para responder à comparação privada central, e o
   contrato proíbe migrar afirmações sobre benchmark público, renda ou
   interação sem o `AR` correspondente. O pacote privado mantém duas revisões
   finais independentes, uma delas com reconstrução cega de `A_U`, além da
   invalidação por hashes.
5. **Há motivo para outra rodada de simplificação?** Não. A complexidade
   remanescente decorre das escolhas substantivas expressamente preservadas,
   não de burocracia supérflua. Outra passada correria mais risco de remover
   proteção matemática do que de gerar economia relevante.

## Matriz das críticas iniciais

| Crítica inicial | Estado | Avaliação |
|---|---|---|
| Verifier pretendia certificar PBE, completude e desvios no contínuo | **Fechada** | A nova fronteira entre teste mecânico e prova humana é explícita. |
| Mistura entre regras do jogo, prova e administração | **Fechada** | As três camadas agora estão separadas. |
| Medidas Borelianas arbitrárias ampliavam excessivamente a carga | **Parcial** | A carga matemática permanece por decisão autoral, mas deixou de ser falsa obrigação do código. |
| Bayes local era apresentado como necessidade técnica neutra | **Fechada** | Agora é honestamente chamado de disciplina autoral mais forte que Bayes quase em toda parte. |
| `kappa` sobre história completa gerava grande multiplicidade | **Parcial** | A correspondência completa foi preservada; compressão por estado suficiente é permitida quando provada. |
| Benchmarks, rendas e interação eram todos obrigatórios | **Fechada** | `AR` tornou-se opcional e pode ser limitado à pergunta necessária. |
| Payloads completos eram copiados entre nós | **Fechada** | O transporte usa IDs e hashes. |
| Lifecycle tinha campos e certificados redundantes | **Fechada** | Restaram `status`, artefato, hashes de dependências e caminhos dos pareceres. |
| Até 14 pareceres e vários freezes/autorizações | **Fechada** | Revisões foram concentradas no código, pacote matemático, fase pública opcional e manuscrito. |
| Schemas e ledgers excessivamente extensos | **Fechada** | O ledger caiu para 16 campos; os schemas restantes representam coordenadas substantivas. |

## Proteções preservadas

1. Regras econômicas, datas e aplicação única de `beta`, com fontes presas por
   hashes.
2. Correspondência completa e conjunta, binder atômico e proibição de combinar
   coordenadas de equilíbrios diferentes.
3. Revisão matemática independente, incluindo reconstrução cega de `A_U`.

## Verificações mecânicas

- DAG: JSON válido, quatro nós, seis arestas e acíclico.
- Ledgers: quatro cabeçalhos idênticos, com 16 campos cada.
- Hashes confirmados antes e depois:
  - parecer inicial: `c802bf389669b36ef53e4f244828a639eec2a0eee40a23a679e68d51cf022c67`;
  - contrato simplificado: `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4`;
  - DAG simplificado: `a2572dc8954d63535d4edcbf04158e9524d11ed4537a822713e534df580ee9e0`;
  - cada ledger simplificado: `3bd87820cd88b1ffe25f562c4e7952d91a028813a610c8ab728389eed1e6e580`.

## Veredito

**APPROVE AS IS — 0 crítico / 0 importante / 0 menor.**

- **Overengineering antes:** 8/10.
- **Overengineering depois:** 3/10.

**Recomendação ao autor:** aprovar este candidato depois do segundo parecer de
preservação formal/game-theoretic sobre exatamente os mesmos hashes. Só depois
decidir separadamente se autoriza o Goal 1.
