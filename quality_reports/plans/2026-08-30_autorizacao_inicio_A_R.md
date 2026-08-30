# Autorização de início — `A_R`

**Data:** 2026-08-30  
**Worktree:** `/private/tmp/PBP-am-msb`  
**Branch:** `agenda-extension-am-msb`  
**HEAD de abertura:** `cd280a5442e403accf8fca5dda54d347a28c83b9`  
**Nó autorizado:** `A_R` — benchmark público, rendas informacionais e contraste institucional  
**Status inicial:** `authorized / in progress / unfrozen`

## 1. Decisão literal

Depois da explicação de que `A_R` resolve o estágio de agenda com o tipo de `H`
público e o compara com o pacote privado de `A_C`, o autor declarou:

> Ok. Faça A_R

Essa decisão autoriza a execução completa de `A_R` dentro do Gate 0 aprovado e
dos limites abaixo.

## 2. Perguntas públicas autorizadas

O passe deve responder:

1. quais são as correspondências de equilíbrio do estágio de agenda sob
   maioria e unanimidade quando `theta` é público antes da proposta;
2. qual é, para cada regra e tipo, a diferença entre o payoff privado de `H` e
   seu benchmark público;
3. qual é a diferença institucional entre essas rendas, orientada como
   unanimidade menos maioria;
4. quais imagens ex ante seguem dos vetores por tipo, sem apagar a ligação
   entre coordenadas do mesmo binder;
5. se existe uma decomposição adicional, útil e formalmente identificada da
   interação entre agenda e informação usando apenas os objetos congelados.

O item 5 só pode ser promovido a resultado se não exigir seleção silenciosa,
acoplamento cross-world, ranking de bem-estar ou nova primitiva. Caso contrário,
deve ser registrado como não identificado ou fora de escopo.

## 3. Dependências exatas

### `A_C` privado congelado

- autoridade terminal:
  `quality_reports/2026-08-30_A_C_msb_strengthened_terminal_approval_and_freeze.md`;
- SHA-256 da autoridade:
  `b331f88b7abb99c03a5a8c657d163d1e006c0cf4cb51e744abcee298ac6af557`;
- manifesto final:
  `quality_reports/2026-08-30_A_C_msb_strengthened_final_gate_manifest.sha256`;
- SHA-256 do manifesto:
  `332d1d7be7a7b38f715c8d7d872c6f7010c22a27fc924b91e8f694199a190fe4`.

### `N7_public` congelado

- interface:
  `model_redesign/essential_input_n7_complete_information_benchmark_candidate.json`;
- SHA-256:
  `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45`;
- aprovação terminal:
  `quality_reports/2026-08-21_fechamento_autoral_goal4_n7.md`.

### Contrato da extensão

- Gate 0 simplificado aprovado:
  `quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md`;
- SHA-256:
  `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4`;
- registro de aprovação:
  `quality_reports/2026-08-27_fechamento_autoral_gate0_agenda_extension_simplified.md`;
- manifesto de interfaces externas do Goal 1:
  `model_redesign/agenda_extension_goal1_external_interfaces.json`, SHA-256
  `588e7da2ec7df2f208ccaf082d3bc30834ea12625484b04b25d3eae7fce20a86`.

## 4. Disciplina de execução

- Resolver primeiro os jogos públicos de agenda; só depois subtrair benchmarks.
- Usar `N7` apenas como continuação pública congelada, nunca como seleção dos
  jogos privados.
- Preservar correspondências, binders e células `none`; nenhuma fonte vazia
  recebe payoff convencional.
- Valores privados de `A_C` e públicos de `A_R` estão na data `A`; não há novo
  desconto na subtração.
- Calcular por tipo antes de qualquer imagem ex ante.
- Verificação mecânica não substitui prova.
- O candidato final exige dois pareceres independentes read-only sobre os
  mesmos hashes, adjudicação e decisão autoral terminal antes de congelamento.

## 5. Limites preservados

Esta autorização não permite:

- alterar `A_M`, `A_U`, `A_C`, `N1`–`N7` ou seus bytes congelados;
- usar o benchmark público para orientar retroativamente os equilíbrios
  privados;
- selecionar um equilíbrio, combinar extremos marginais ou criar um
  acoplamento cross-world ausente do jogo;
- editar ou compilar `formal_model_v6.Rmd`;
- criar tag, fazer merge ou push.

Qualquer necessidade de nova primitiva, refinamento, regra de seleção ou
operação não coberta deve ser escalada ao autor e interrompe apenas o ramo
afetado.

A_R_START_AUTHORIZATION: APPROVED  
MANUSCRIPT_AUTHORIZATION: NONE  
TAG_MERGE_PUSH_AUTHORIZATION: NONE
