# Aprovação autoral terminal e congelamento — `A_T` sob M/S/B

**Data:** 2026-08-31  
**Natureza:** registro administrativo posterior às revisões e adjudicações; não altera nenhum byte matemático revisado  
**Nó:** `A_T` — efeito estrutural total da etapa obrigatória de agenda  
**Status deste snapshot:** `pass/frozen`

## 1. Decisão literal

Depois de receber a explicação de que `A_T` havia passado a verificação
mecânica, dois pareceres formais independentes e a adjudicação sem defeitos
confirmados, mas continuava retido da migração exclusivamente por falta de
aprovação autoral terminal, o autor respondeu:

> A_t aprovado então.

Essa frase aprova terminalmente o candidato formal de `A_T` identificado
abaixo. Ela autoriza seu congelamento e seu consumo pela transição já
autorizada para o manuscrito. Não autoriza rederivar os jogos-fonte, selecionar
silenciosamente membros de correspondências, criar tag, fazer merge, push ou
alterar os bytes matemáticos congelados.

## 2. Objeto aprovado

- branch do candidato: `codex/agenda-total-effect`;
- commit do candidato matemático final:
  `7033063a4b737cc0acc087ac71261e25805c689d`;
- manifesto do candidato matemático:
  `quality_reports/2026-08-30_AT_msb_candidate_manifest.sha256`;
- SHA-256 do manifesto do candidato:
  `ca3248fb8ef63a2dcc008b5e30ffda1a8e170806ea172969e069daef1e9629cd`;
- integridade do candidato: `11/11 OK`;
- manifesto do gate de revisão:
  `quality_reports/2026-08-30_AT_msb_review_gate_manifest.sha256`;
- SHA-256 do manifesto do gate de revisão:
  `52063c245390526c6f986bb6095d976eecfcd4fcbfc95cd8f054f848d0e52ad6`;
- verificação mecânica fresca em 2026-08-31: `50 PASS / 0 FAIL`;
- parecer matemático final: `PASS 0/0/0`;
- parecer adversarial final: `PASS 0/0/0`;
- adjudicação formal final: `NO_CONFIRMED_DEFECTS`.

O diff entre o candidato `7033063a` e o commit imediatamente anterior a este
registro confirmou que contrato, resultados, interface, registros completos,
ledger, verificador e output versionado de `A_T` permaneceram byte a byte
inalterados depois das revisões formais.

## 3. Escopo matemático congelado

O congelamento cobre, nos domínios e correspondências exatos do candidato:

- o desenho fatorial `2 x 2` entre agenda e informação;
- o efeito direto da agenda sob informação completa, `D_g`;
- o efeito total da agenda sob informação privada, `T_g`;
- a interação entre agenda e informação, `I_g`;
- as identidades `T_g=D_g+I_g` e
  `DeltaT=DeltaD+DeltaI`;
- as fórmulas por ramo de `D_U`, `D_M` e `DeltaD`;
- as correspondências exatas de `T_U` e `T_M`, inclusive as células `none`;
- os sinais robustos já demonstrados no candidato;
- o contraste diagonal `Q_g`, expressamente distinto de um efeito causal de um
  único fator;
- a aplicação única de `beta` nas comparações entre as datas `A` e `R1`;
- a proibição de seleção cross-world e de recombinação de marginais fora das
  tuplas completas admissíveis.

Qualquer mudança futura nesses artefatos cria um novo candidato, não coberto
pelos pareceres ou por esta aprovação.

## 4. Consulta externa posterior

A consulta técnica externa não formal preservada em
`quality_reports/external_reviews/2026-08-30_consulta_tecnica_externa_nao_formal_chatgpt_AT_msb.md`
não encontrou defeito matemático em `A_T`. Ela recomendou quatro precisões
locais de exposição e derivou seis corolários adicionais (`WEB-AT-F010` a
`WEB-AT-F015`).

Esta aprovação congela o candidato formal já revisado. As precisões expositivas
podem orientar a redação do manuscrito sem mudar as fórmulas congeladas. Os
seis corolários adicionais não são convertidos retroativamente em claims
congelados de `A_T`; sua eventual promoção a resultados formais continua
exigindo registro e revisão próprios.

## 5. Efeito downstream

Com esta aprovação, deixam de estar retidas apenas por falta de congelamento de
`A_T` as linhas `MIG-AT-01` a `MIG-AT-05` e `MIG-SEM-03` da matriz de migração.
A transição do manuscrito já havia sido autorizada separadamente pelo autor.

Ao consumir essas linhas, a reescrita deve:

- usar os hashes do manifesto final de `A_T`;
- preservar conjuntos e correspondências, sem criar um equilíbrio selecionado;
- respeitar literalmente os domínios e as células `none`;
- distinguir o efeito causal estrutural de agenda `T` do contraste diagonal
  `Q`;
- incorporar as quatro precisões de exposição da consulta externa;
- não apresentar `WEB-AT-F010` a `WEB-AT-F015` como teoremas congelados sem um
  gate adicional.

TERMINAL_AUTHOR_APPROVAL: APPROVED  
A_T_STATUS: PASS_FROZEN  
MIGRATION_AUTHORIZATION: EXISTING_TRANSITION_ONLY  
TAG_MERGE_PUSH_AUTHORIZATION: NONE
