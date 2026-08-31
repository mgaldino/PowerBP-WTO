# Matriz auditável de migração da extensão de agenda

**Data:** 2026-08-30  
**Status:** AMPLIADA COM COMPARAÇÕES PÓS-\(A_R\), DECISÕES EDITORIAIS E
POSICIONAMENTO — NÃO AUTORIZA EDIÇÕES NO MANUSCRITO
**Worktree:** `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion-agenda-integration`  
**Branch:** `codex/agenda-extension-manuscript-integration`

## 1. Objetivo e limite

Este documento transforma os resultados congelados de \(A_M\), \(A_U\),
\(A_C\) e \(A_R\), as comparações adicionais produzidas depois desses nós, o
candidato revisto mas ainda não congelado \(A_T\) e as decisões editoriais do
autor em uma fila explícita de possíveis edições futuras de
`formal_model_v6.Rmd`. Para cada bloco, registra fonte, destino, nível de
detalhe, prova e gate ainda aberto.

A fonte canônica em nível de linha é
`quality_reports/plans/2026-08-30_agenda_extension_migration_matrix.tsv`. O TSV
tem 25 linhas. As linhas fechadas continuam `PROPOSED_NOT_AUTHORIZED`; as cinco
linhas de \(A_T\) estão `BLOCKED_PENDING_AT_FREEZE`.

Nada neste pacote:

- altera `formal_model_v6.Rmd` ou `formal_model_v6.pdf`;
- cria um novo resultado matemático;
- seleciona um equilíbrio dentro de uma correspondência;
- autoriza migração, nova revisão do manuscrito, tag ou push;
- usa a apresentação ainda em finalização como evidência ou fonte textual.

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

O nó adicional \(A_T\) está presente apenas como candidato bloqueado:

| Nó | Estado | Manifesto de revisão | SHA-256 do manifesto |
|---|---|---|---|
| \(A_T\) | `reviewed/unfrozen` | `quality_reports/2026-08-30_AT_msb_review_gate_manifest.sha256` | `52063c245390526c6f986bb6095d976eecfcd4fcbfc95cd8f054f848d0e52ad6` |

As fontes editoriais e a síntese comparativa são fixadas por
`quality_reports/plans/2026-08-31_agenda_extension_migration_editorial_inputs.sha256`.
Esse manifesto preserva proveniência; não converte decisões editoriais em
teoremas.

## 3. Leitura da matriz

Cada linha liga um conjunto de `claim_ids` a:

1. um artefato-fonte e seu hash;
2. um manifest final governante;
3. uma âncora textual já existente no v6;
4. uma ação editorial proposta;
5. um destino no texto e outro para a prova;
6. uma trava que impede extrapolações.

As ações têm cinco significados:

- `ADD_EXTENSION`: acrescentar, após autorização, um resultado novo da extensão;
- `PRESERVE_AND_CITE`: resumir no corpo sem substituir a correspondência completa congelada;
- `MOVE_TECHNICAL`: manter no apêndice o maquinário necessário para exatidão, mas dispensável à primeira leitura.
- `APPLY_EDITORIAL_DECISION`: aplicar uma escolha autoral somente depois da
  autorização da linha correspondente;
- `REVISE_NARRATIVE`: rever framing ou aplicação sem alterar o conteúdo formal.

Os identificadores `SYNTH-*`, `DEC-*` e `POS-*` são localizadores editoriais,
não novos claims matemáticos. Os claims `AT-MSB-*` pertencem ao ledger formal
de \(A_T\), mas não são migráveis enquanto o nó estiver `unfrozen`.

## 4. Síntese da migração proposta

### Texto principal

O corpo continua obedecendo à Opção 1 e deve caber em aproximadamente 3,5--5
páginas. A fila agora contém oito blocos, que devem ser fundidos numa única
seção enxuta:

1. contrato e timing da extensão, deixando intacto o benchmark sem poder de agenda;
2. resumo das correspondências privadas sob maioria e unanimidade;
3. comparação privada exata no mesmo estado do mundo, seguida da condição suficiente T5;
4. benchmarks públicos sob maioria e unanimidade e o hiato \(G(o)\);
5. rendas informacionais por tipo, agregação ex ante e decomposição institucional;
6. intuição da interação entre poder de agenda e poder informacional, sem impor sinal onde o resultado permanece conjuntista.
7. efeito causal da etapa de agenda, com \(T=D+I\), separado do ranking
   institucional \(U-M\);
8. posicionamento conciso frente a Piazolo--Vanberg e
   Glynia--Thum--Xefteris, pela pergunta, mecanismo e papel do ator informado.

A ordem recomendada é: benchmark sem agenda; timing da extensão; benchmark
público e fronteira \(\beta o=c/m\); comparação privada por tipo; efeito causal
da agenda; agregação ex ante e implicação substantiva. Na notação canônica,
\(k=q-1\) é o número de votos fracos comprado pela maioria e \(c=m-k\) é o
número de fracos que ela pode excluir. O uso local de `k` para "excluídos" na
entrevista não deve migrar para o paper.

### Apêndices

Os apêndices receberiam:

- correspondências completas, incluindo células vazias (`none`) e fronteiras;
- assinaturas de duas camadas, fatoração e envelopes;
- prova da condição T5, seu caráter apenas suficiente e o contraexemplo à necessidade;
- classes completas de equilíbrio dos benchmarks públicos;
- derivação por ramos de \(G(o)\), rendas e decomposição;
- mapa de interação com N7 e convenções de data dos payoffs.
- desenho fatorial, \(D\), \(T\), \(I\), \(\Delta T\) e o contraste diagonal
  \(Q\), mantendo seu escopo causal distinto;
- tipologia completa de posicionamento, se necessária, fora do fluxo das
  provas econômicas.

## 5. Travas substantivas

A futura migração deve invalidar a linha afetada e tudo que depende dela se qualquer fonte ou hash mudar. Além disso:

- os vetores de maioria e unanimidade só podem ser comparados na mesma economia e na mesma fibra de crença;
- não se pode montar um vetor artificial combinando coordenadas de equilíbrios diferentes;
- T5 é condição suficiente, não necessária;
- maioria pública inclui passagem, empate e atraso deliberado; unanimidade pública tem acordo imediato;
- rendas são calculadas por tipo antes da média ex ante;
- a identidade de sinais é \(\delta=U-M=-G+\Delta RI_A\), pois \(G=M-U\);
- se \(G(o_0)>0\) e um membro privado tem \(\delta_0>0\), então
  \(\Delta RI_0>G(o_0)>0\), sempre membro a membro;
- a renda positiva sob unanimidade pertence ao tipo baixo, mas a renda
  relativa a maioria permanece set-valued;
- abaixo da fronteira pública, informação é a única força que pode apontar
  para unanimidade; na fronteira ela coincide com todo o ganho líquido; acima
  dela o componente público já pode favorecer unanimidade;
- "consenso serve ao hegemon em todos os seus estados" deve virar uma frase
  condicional sobre os canais pelos quais consenso **pode** servi-lo;
- \(T\) é contraste causal estrutural dentro do modelo; \(Q\) muda agenda e
  informação simultaneamente e não é efeito causal puro;
- na interação com N7, \(\beta\) deve aparecer exatamente uma vez.

## 6. Decisões editoriais incorporadas como propostas

1. **Arquitetura:** Opção 1, com benchmark sem agenda como contribuição
   principal e extensão integrada curta.
2. **Incidência:** resultados por tipo antes da média ex ante.
3. **T5:** condição suficiente no corpo; igualdade, certificado local e
   contraexemplo à necessidade no apêndice.
4. **Decomposição:** \(\delta=-G+\Delta RI\) no corpo; sinais e
   correspondências completas no apêndice.
5. **Título proposto:** *Power and Its Shadow: When Unanimity Serves the
   Hegemon*.
6. **Posicionamento:** conceder a raiz comparativa a Piazolo--Vanberg;
   diferenciar pooling sem rejeição no caminho apenas na região de pooling,
   assimetria do hegemon, contornabilidade como interruptor da informação e
   decomposição por tipo. Tratar Glynia--Thum--Xefteris como polo de seguro
   estático, não como o mesmo mecanismo.
7. **Aplicação:** distinguir monopólio formal de propostas de influência de
   agenda de facto. Antes de atribuir criação ou escolha institucional aos
   Estados Unidos, exigir auditoria própria de fontes e linguagem de
   consistência, não identificação histórica.

## 7. Apresentação localizada, mas não consumida

| Fonte futura | Localização | Estado | Regra |
|---|---|---|---|
| apresentação do seminário | `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/presentations/2026-08-30_agenda_information_seminar/` | `LOCATED_AWAITING_AUTHOR_OK` | não abrir, ler, hashear, citar nem extrair até autorização explícita |

A localização foi registrada apenas para adiantar o trabalho. Nenhum arquivo
da apresentação foi consumido nesta ampliação. Depois do OK do autor, a versão
final deverá ser fixada por hash e triada. Elementos pedagógicos podem sugerir
ordem, figura ou intuição, mas não substituir fontes formais.

## 8. Gates antes da edição do manuscrito

1. fechar \(A_T\): decidir os seis corolários adicionais, aplicar as quatro
   precisões locais, revisar de novo e obter aprovação autoral terminal;
2. atualizar `MIG-AT-*` com o futuro manifest final;
3. obter o OK para consumir a apresentação final;
4. auditar os preprints e qualquer alegação histórica sobre EUA/OMC;
5. autorizar linha a linha o TSV, incluindo título e narrativa;
6. só então editar, compilar e revisar independentemente o novo snapshot,
   com implementador diferente dos revisores.

## 9. Uso futuro

Depois do fechamento dos gates, as linhas aprovadas podem mudar para
`AUTHORIZED`. Só então deve começar uma edição controlada do Rmd, seguida por
compilação, conferência das referências cruzadas, nova matriz de hashes e
revisão independente. Até lá, o pacote é apenas uma ponte auditável entre
resultados congelados, um candidato ainda bloqueado e possíveis edições.
