# Manutenção das instruções de PowerBayesianPersuasion

Data: 2026-09-05.

## Escopo solicitado

O autor confirmou que os fundamentos aprovados em setembro prevalecem. Autorizou retirar comandos históricos das seções operacionais, delimitar o encaminhamento de ambiguidades às decisões substantivas e distinguir verificações do implementador de certificação independente. Pediu o resumo dos fundamentos, um índice curto e uma proposta integral de `AGENTS.md` para leitura e aprovação.

O autor aprovou a proposta integral e corrigiu o item 4 em mensagens sucessivas. A decisão mais recente exige que a ausência de acúmulo de alocação positiva e opção externa decorra da arquitetura e dos incentivos, inclusive fora do caminho. `architecture_clarification.md` registra essa decisão e seu alcance. O `AGENTS.md` da raiz contém `AGENTS.approved.md`, atualizado conforme essa orientação. As alterações abrangem instruções e seu registro documental. Nenhuma prova, definição em contrato congelado ou versão do manuscrito foi modificada.

## Organização do material histórico

`AGENTS.before.md` preserva integralmente os 44.798 bytes do arquivo anterior, SHA-256 `f16229f248a648da06e0c35ade9a9959bf67be129d241ac5f9e6d66b53cb94fa`. A cópia contém tanto regras que permanecem válidas quanto instruções substituídas; consulte-a para proveniência, sem executá-la como plano atual.

A tabela registra a limpeza inicial, anterior à instalação integral aprovada. O arquivo intermediário foi preservado em `AGENTS.pre-approval.md`; a versão integral usa o resumo corrigido dos fundamentos.

| Seção anterior | Tratamento na limpeza inicial |
| --- | --- |
| `Current Status` e blocos de fechamento de Goals | Substituídos por referências aos registros de cada tarefa e à comparação com o checkout. Estados de agosto não foram promovidos a status atual. |
| `INVIOLABLE MODEL FUNDAMENTALS` | Preservado integralmente, incluindo as oito regras e a exigência de aprovação individual para reversões. |
| `CURRENT ARCHITECTURE` | Comandos de reinício e descrição superada do conceito de solução retirados. O contrato continua referenciado, com precedência explícita das decisões de setembro. |
| `DECISION 2026-08-21` | Regras de crenças e votação preservadas com referência à codificação de setembro. O relato de edições e de revisão pendente daquela sessão foi retirado do bloco operacional. |
| `Accepted consequences` | Preservado na cópia histórica; não é uma ordem nova de rederivação. |
| `Redesign Decision`, `Architecture Reset`, correções BF e `Verified Results in the Appendix` | Preservados na cópia histórica e nos documentos originais. Não são instruções para desenvolver novamente arquiteturas abandonadas. |
| `Separate Formal Workspace` | Mantida a derivação fora do manuscrito e a computação em scripts separados; a superfície de trabalho passa a ser o arquivo autorizado para a tarefa. |
| `Pending Proof Work`, prioridades antigas e prompt de `Next Session Context` | Retirados das instruções ativas. Isso não certifica os resultados nem encerra pendências científicas; seu estado depende dos registros correspondentes. |
| `Files` | Substituído por arquivos de trabalho e referências pertinentes, com histórico preservado. |
| `Compilation` e `Coarse Review` | Mantidos os comandos e os cuidados com bookdown e o wrapper existente. |
| `Operating Rules` | Mantidos os controles sobre derivação, primitivas, protocolo, revisões e versão. Atualizadas as regras sobre escolhas rotineiras e verificações do implementador conforme a autorização atual. |

## Fundamentos e emendas

O resumo aprovado está em `AGENTS.approved.md`, em oito itens, com a distinção explícita entre os pagamentos dos fracos e de H nos itens 4 e 7. A emenda de 1º de setembro substituiu a devolução ao proponente pelo cancelamento da fatia. A correção autoral mais recente exige justificar o resultado pela arquitetura e pelos incentivos e afasta o cancelamento como solução primitiva desse problema. Leia a sequência em `approval.md` e o estado vigente em `architecture_clarification.md`.

O índice aprovado indica os fundamentos de setembro, as decisões de crenças e votação, as cláusulas compatíveis do Gate 0, os registros da extensão e os manifestos do manuscrito. O índice não altera contratos congelados, não estende pareceres a novos hashes e não afirma invariância da correspondência completa de estratégias fora do caminho.

## Arquivos e validação

- `AGENTS.before.md`: arquivo anterior integral, para recuperação e auditoria.
- `AGENTS.active.diff`: diferenças da limpeza inicial.
- `AGENTS.pre-approval.md`: arquivo intermediário preservado.
- `AGENTS.approved.md`: versão integral aprovada, idêntica ao arquivo ativo da raiz.
- `AGENTS.approval.diff`: diferenças entre a proposta e a versão aprovada.
- `approval.md`: esclarecimento autoral e aprovação.
- `approval_validation.json`: conferência da instalação da versão aprovada.
- `approval_independent_review.md`: revisão da redação corrigida.
- `AGENTS.proposed.md`: proposta histórica, anterior à correção autoral.
- `independent_review.md`: parecer da etapa inicial, anterior à correção autoral.
- `validation.json`: verificações da instalação intermediária, limitadas àquela etapa.

As verificações cobrem conteúdo, referências locais e preservação dos arquivos. Não foi rodada análise R, recompilado o artigo ou realizada nova certificação das provas; esta manutenção não altera essas evidências. Também não foi executado experimento comportamental com uma nova sessão do Codex.

## Esclarecimento posterior sobre o término do jogo

O item 4 explicita que H recebe `x_H` quando vota sim e a proposta é aprovada; na rejeição que encerra o jogo, recebe a opção externa independentemente do voto. O registro autoral está em `approval.md`. A conferência dessa alteração está em `terminal_clarification_validation.json`; os pareceres e validações anteriores continuam limitados aos hashes que registraram.

## Correção posterior sobre arquitetura e racionalidade

O item 4 e a seção “Exclusão de H: obrigação de derivação” registram a exigência atual. A ausência de acúmulo ainda precisa ser estabelecida com payoffs e respostas definidos também após desvios nas propostas ou nos votos. O resultado para propostas ótimas nas duas rodadas registrado na nota tem alcance próprio e não encerra essa questão.

- `architecture_clarification.md`: decisão vigente, diagnóstico e formulação técnica candidata.
- `AGENTS.before_architecture_clarification.md`: versão do AGENTS anterior a essa correção, para proveniência.
- `architecture_clarification.diff`: diferenças desta correção nos quatro arquivos existentes.
- `architecture_review/`: pareceres e adjudicação delimitados às fontes e hashes registrados.
- `architecture_clarification_validation.json`: verificação da instalação atual; validações e pareceres anteriores cobrem somente seus próprios hashes.

A manutenção das instruções foi concluída. A definição e certificação de uma arquitetura que satisfaça integralmente o requisito permanecem abertas.
