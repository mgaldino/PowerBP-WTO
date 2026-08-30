# Matriz auditável de migração da extensão de agenda

**Data:** 2026-08-30  
**Status:** PREPARADA — NÃO AUTORIZA EDIÇÕES NO MANUSCRITO  
**Worktree:** `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion-agenda-integration`  
**Branch:** `codex/agenda-extension-manuscript-integration`

## 1. Objetivo e limite

Este documento transforma os resultados congelados de \(A_M\), \(A_U\), \(A_C\) e \(A_R\) em uma fila explícita de possíveis edições futuras de `formal_model_v6.Rmd`. Ele responde, para cada bloco de resultados, quatro perguntas: de onde vem, em que ponto do manuscrito poderia entrar, quanto detalhe pertence ao texto principal e qual prova deve permanecer no apêndice.

A fonte canônica em nível de linha é `quality_reports/plans/2026-08-30_agenda_extension_migration_matrix.tsv`. O arquivo TSV não contém seleção editorial silenciosa: todas as linhas têm status `PROPOSED_NOT_AUTHORIZED`.

Nada neste pacote:

- altera `formal_model_v6.Rmd` ou `formal_model_v6.pdf`;
- cria um novo resultado matemático;
- seleciona um equilíbrio dentro de uma correspondência;
- autoriza migração, nova revisão do manuscrito, tag ou push.

## 2. Fronteira de integração verificada

A worktree foi criada a partir do topo congelado da extensão de agenda, commit `9739504db4758145b0c401d756bee223a04e9ecb`, e recebeu por merge explícito a branch `codex/essential-input`, commit `43307074d3f13e3457be3925b651f6f4557b58cb`. O merge sem conflitos é o commit `04719edb18adda656197831c2223348b86068109`.

O manuscrito continua exatamente no snapshot aprovado:

| Artefato | SHA-256 preservado |
|---|---|
| `formal_model_v6.Rmd` | `00bbaa3a5768348fede3f6584bab915b7c1dbf1fd1cccbf723bb64a90188e4a6` |
| `formal_model_v6.pdf` | `3602b0753a8a61ddcb2450f7181ba2f8fc53b9f73ad16cdfbb46e337019182be` |

Os quatro nós de agenda são consumidos apenas por seus manifests finais:

| Nó | Manifest final | SHA-256 do manifest |
|---|---|---|
| \(A_M\) | `quality_reports/2026-08-29_A_M_msb_two_layer_final_gate_manifest.sha256` | `8eb870d5595a4373994e8f47a25a3dd137b00ac8c32fc09b947444498a32775e` |
| \(A_U\) | `quality_reports/2026-08-30_A_U_msb_two_layer_final_gate_manifest.sha256` | `b85741b2176c4480f5f3632c4464a93cebabb5dd4f71636626917b9227030180` |
| \(A_C\) | `quality_reports/2026-08-30_A_C_msb_strengthened_final_gate_manifest.sha256` | `332d1d7be7a7b38f715c8d7d872c6f7010c22a27fc924b91e8f694199a190fe4` |
| \(A_R\) | `quality_reports/2026-08-30_A_R_msb_final_gate_manifest.sha256` | `a57696cac12d3b3910cd7406842ea9d270df6193e4c696e455e06722447c8e38` |

## 3. Leitura da matriz

Cada linha liga um conjunto de `claim_ids` a:

1. um artefato-fonte e seu hash;
2. um manifest final governante;
3. uma âncora textual já existente no v6;
4. uma ação editorial proposta;
5. um destino no texto e outro para a prova;
6. uma trava que impede extrapolações.

As ações têm três significados:

- `ADD_EXTENSION`: acrescentar, após autorização, um resultado novo da extensão;
- `PRESERVE_AND_CITE`: resumir no corpo sem substituir a correspondência completa congelada;
- `MOVE_TECHNICAL`: manter no apêndice o maquinário necessário para exatidão, mas dispensável à primeira leitura.

## 4. Síntese da migração proposta

### Texto principal

O corpo precisaria apenas de seis blocos:

1. contrato e timing da extensão, deixando intacto o benchmark sem poder de agenda;
2. resumo das correspondências privadas sob maioria e unanimidade;
3. comparação privada exata no mesmo estado do mundo, seguida da condição suficiente T5;
4. benchmarks públicos sob maioria e unanimidade e o hiato \(G(o)\);
5. rendas informacionais por tipo, agregação ex ante e decomposição institucional;
6. intuição da interação entre poder de agenda e poder informacional, sem impor sinal onde o resultado permanece conjuntista.

### Apêndices

Os apêndices receberiam:

- correspondências completas, incluindo células vazias (`none`) e fronteiras;
- assinaturas de duas camadas, fatoração e envelopes;
- prova da condição T5, seu caráter apenas suficiente e o contraexemplo à necessidade;
- classes completas de equilíbrio dos benchmarks públicos;
- derivação por ramos de \(G(o)\), rendas e decomposição;
- mapa de interação com N7 e convenções de data dos payoffs.

## 5. Travas substantivas

A futura migração deve invalidar a linha afetada e tudo que depende dela se qualquer fonte ou hash mudar. Além disso:

- os vetores de maioria e unanimidade só podem ser comparados na mesma economia e na mesma fibra de crença;
- não se pode montar um vetor artificial combinando coordenadas de equilíbrios diferentes;
- T5 é condição suficiente, não necessária;
- maioria pública inclui passagem, empate e atraso deliberado; unanimidade pública tem acordo imediato;
- rendas são calculadas por tipo antes da média ex ante;
- a identidade de sinais é \(\delta=U-M=-G+\Delta RI_A\), pois \(G=M-U\);
- na interação com N7, \(\beta\) deve aparecer exatamente uma vez.

## 6. Uso futuro

Depois de uma decisão autoral sobre a arquitetura editorial, as linhas aprovadas podem mudar para `AUTHORIZED`. Só então deve começar uma edição controlada do Rmd, seguida por compilação, conferência das referências cruzadas, nova matriz de hashes e revisão independente do novo snapshot. Até lá, o pacote é apenas uma ponte auditável entre resultados congelados e possíveis edições.
