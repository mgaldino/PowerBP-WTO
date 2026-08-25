# Item O-1 — Deriva pós-pino no registro normativo do conceito de solução

**Data de abertura:** 2026-08-23
**Origem:** finding O-1 do parecer `formal_design` da rodada 1
(`quality_reports/2026-08-23_parecer_formal_design_emenda_cabecalho_gate0.md`),
confirmado de forma independente.
**Status:** `ABERTO` — diagnóstico feito, reparo **não autorizado**.
**Autorização vigente:** o autor autorizou abrir este item como investigação
separada, com autorização e revisores próprios. Nenhuma autorização foi dada
para restaurar arquivos, atualizar pinos ou alterar artefatos congelados.

---

## 1. O problema

`quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` é o
registro normativo do pacote de conceito de solução de 2026-08-21, assim
designado pelo `CLAUDE.md`. Seus bytes divergiram do valor pinado:

- **pinado:** `94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69`
- **atual:** `9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f`

A divergência está **commitada**; o `git status` do arquivo é limpo.

## 2. Consequência verificada

Cinco verificadores numéricos abortam com `Frozen formula source hash mismatch`:

```text
scripts/verify_essential_input_numeric_boundaries.R
scripts/verify_essential_input_n1_numeric.R
scripts/verify_essential_input_n2_numeric.R
scripts/verify_essential_input_n3_numeric.R
scripts/verify_essential_input_n4_numeric.R
```

Enquanto isso não for resolvido, `N1`–`N4` não têm camada de verificação
numérica viva. As interfaces congeladas e seus pareceres não são afetados: o
problema é do instrumento de verificação numérica, não dos resultados.

## 3. Diagnóstico: deriva pós-pino, em duas etapas

Rastreamento dos bytes do arquivo commit a commit:

| commit | SHA-256 (12) | leitura |
|---|---|---|
| `a6fd6bd` | `89f5700defd9` | importação inicial do registro |
| `8529e9c` | `89f5700defd9` | inalterado |
| `7a0a89e` | `73ee20685cbd` | edição |
| `b3f70f0` | `bb342c0fc683` | edição |
| `ec47406` | `75c4b4839728` | edição |
| `1a12b74` | `94062c0803d9` | **bytes que foram pinados** |
| `e29a519` | `828fe09b81a6` | **edição posterior ao pino** |
| `dae5faa` | `f067e978726f` | **segunda edição posterior ao pino** |
| corrente | `9189299798a6` | estado atual |

O pino foi tirado em `1a12b74` ("Checkpoint frozen N3 N4 for Goal 3 N6"). O
documento foi editado **duas vezes depois disso** sem que nenhum dos 17 locais
que o pinam fosse atualizado. Não há sinal de adulteração: o padrão é o de
edição legítima continuada sobre um documento que já havia sido congelado por
hash, com a atualização dos pinos esquecida.

## 4. A decisão que falta

Duas saídas, e a escolha é autoral:

1. **Deriva indevida** — as edições de `e29a519` e `dae5faa` não deveriam ter
   ocorrido sobre um documento pinado. Reparo: restaurar os bytes de `1a12b74`,
   e submeter o conteúdo perdido a decisão separada.
2. **Revisão legítima** — as edições são melhorias válidas do registro. Reparo:
   recomputar os 17 pinos para `91892997…`, com revisão independente
   verificando que as duas edições não alteram nenhuma regra normativa do
   pacote de conceito de solução.

O que decide entre as duas é o **conteúdo** das edições de `e29a519` e
`dae5faa`, que ainda não foi auditado. Essa auditoria é o primeiro passo deste
item e deve ser feita por quem não vá aplicar o reparo.

## 5. Fronteira

Este item não toca o contrato Gate 0, o verificador do Gate 0, as interfaces
congeladas de `N1`–`N7`, seus pareceres, nem o manuscrito. Ele é
deliberadamente separado da emenda de status de 2026-08-23 para que uma falha
de integridade preexistente não se misture a uma correção administrativa.
