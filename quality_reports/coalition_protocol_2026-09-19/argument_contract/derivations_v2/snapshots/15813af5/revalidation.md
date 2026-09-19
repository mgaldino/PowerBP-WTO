# Revalidation — derivações v1 → v2

Classificação: **substantive_scoped**. Novo argumento de prova US-1 e correção algébrica excedem revisão editorial, mesmo sem mudança dos enunciados econômicos.

Anterior: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v1/argument_contract.json`, ID `coalition-derivations-v1:b62a7c8e0235:round1`, SHA `a49fc5f5d1737b7d8661506b6e384b709314a98798cacd33e4d981ffb5b07c36`, bundle `b62a7c8e023568bf408c1b8929b5909b4e7af21c3271c95955970237801b799f`.
Atual: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v2.md`, SHA `3b8043d49de9011a60c1e7e079b4fbf876f35239d100dad82a0072b53a19b4e2`, manifesto `8f6603ff00050b6870995d4d893eeeb2bdffe13e0a90304b19b3574de8b7e9f1`; ID `coalition-derivations-v2:3b8043d49de9:round2`.

## Impacto e responsabilidades

| Alteração | Local v2 | Dependências/resultado interpretativo |
|---|---|---|
| F-001 | agenda:211–221; B617–626 | Nova decomposição da diferença pública; C12 e consumidores de gap/D, sem fórmula de resultado nova |
| F-003 | agenda:304; B709 | Probabilidade um no argmax explícita; N06 e endpoints, sem restrição topológica adicional |
| F-002/US-1 | agenda:374; B779; nota B914–1019 | Duas invocações em B.8 e classificação E.3; N08/C17; teto global e C15 não consomem a conclusão |

Macro e leitor independente leram esses blocos, seus consumidores e a nota nova integral. O diff integral agenda v1→v2 foi conferido; demais trechos são reaproveitados por igualdade de conteúdo, com deslocamentos de linhas. Contrato/R2/R1 v2 são byte-idênticos a v1. Os cinco payloads no bundle e dez arquivos do manifesto foram conferidos.

Leitura anterior preservada: `argument_contract/derivations_v1/independent_section_read.md`, SHA `991663cef8090ce773865c7b81123f0a19be3a850eddd096155b14a7507c3b29`. Nova leitura: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v2/independent_section_read.md`, SHA `422a034afd04b33e40442ce1ebec26fc489863d46bf4ec53a5356608fe27b8b1`. Nenhuma leitura nova é atribuída aos agentes nas partes intactas.

O mapa atual tem onze unidades que cobrem 1–1021; os 17 IDs centrais permanecem. N08 recebe o subclaim US-1; C12 tem evidência algébrica substituída; N06 explicita o quantificador já contratado; C17 conserva as identidades e recebe a dependência da classificação reparada. QI-01 a QI-04 são preservadas; QI-05 consta agora do texto; QI-06 reconciliou a independência de C15 em relação à conclusão US-1. Não há ambiguidade material remanescente.

Os 409 checks v1 não foram reexecutados neste gate. O script novo F-001 e o resumo dos 870 casos/4.353 verificações foram lidos como evidência declarada; não substituem revisão científica e não demonstram US-1. O manuscrito preview, sua bibliografia, patches, renderização e eventual integração pertencem a outro contrato.

Todos os checks interpretativos do gate estão satisfeitos: cobertura, âncoras, escopo, não-afirmações, especificação formal/inaplicabilidade empírica, ambiguidades e identidade da fonte. O JSON será validado pelo script da skill antes da entrega. **PASS registra fidelidade; ciência é etapa separada já autorizada.**
