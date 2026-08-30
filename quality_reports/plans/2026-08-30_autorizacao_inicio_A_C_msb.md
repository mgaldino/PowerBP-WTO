# Autorização e preflight de início — `A_C` sob M/S/B

**Data:** 2026-08-30  
**Status:** `APPROVED TO START`  
**Worktree:** `/private/tmp/PBP-am-msb`  
**Branch:** `agenda-extension-am-msb`  
**HEAD no preflight:** `f0af7a60d1cc319c393740205272ea04a6734fa0`

## 1. Autorização literal

Depois de informado de que `A_C` é o nó que compara os conjuntos completos de equilíbrios privados de `A_M` e `A_U`, e de que sua aprovação de `A_U` não iniciava automaticamente esse consumidor, o autor respondeu:

> A_c pode iniciar, autorizado.

A autorização abre somente `A_C`.

## 2. Insumos congelados

| Nó | Autoridade terminal | SHA-256 | Manifesto final | SHA-256 |
|---|---|---|---|---|
| `A_M` | `quality_reports/2026-08-29_A_M_msb_two_layer_terminal_approval_and_freeze.md` | `ca109199060f3aa775f6e2f18ef46fd9cefaff522cc3f7fdeeabfe9d5f412158` | `quality_reports/2026-08-29_A_M_msb_two_layer_final_gate_manifest.sha256` | `8eb870d5595a4373994e8f47a25a3dd137b00ac8c32fc09b947444498a32775e` |
| `A_U` | `quality_reports/2026-08-30_A_U_msb_two_layer_terminal_approval_and_freeze.md` | `e330a1956a7c071dc72c2556eda68cf32d2b81473d700100bbf7e1f6e195111b` | `quality_reports/2026-08-30_A_U_msb_two_layer_final_gate_manifest.sha256` | `b85741b2176c4480f5f3632c4464a93cebabb5dd4f71636626917b9227030180` |

Os dois manifestos passaram integralmente no preflight. A árvore estava limpa e o `HEAD` coincidia com o informado acima.

## 3. Regra de consumo

`A_C` deve:

1. formar primeiro o produto fibrado dos binders completos e das camadas exatas de `A_M` e `A_U`, no mesmo prior e na mesma fibra `(rho,nu_off)`;
2. preservar, dentro de cada regra, a ligação entre estratégias, crenças, continuações, payoffs e outcomes;
3. aplicar zero fatores adicionais de `beta`, pois as duas fontes já estão na data `A`;
4. provar, operação por operação, quando a comparação econômica é constante nas fibras de `Sum_econ` e admite fatorização mensurável;
5. calcular payoffs por tipo antes do valor ex ante;
6. manter o conjunto conjunto exato antes de envelopes e não formar produtos cartesianos de marginais que quebrem a ligação entre tipos;
7. preservar células `none` sem payoff-sentinela.

## 4. Proveniência histórica

Os artefatos `agenda_extension_AC_*_simplified` e o commit histórico `b427671efee954831901e75762988043a2df7205` pertencem ao pacote anterior que falhou auditoria. Eles podem ser usados somente para recuperar a estrutura que foi confirmada como válida — produto fibrado de binders, valores por tipo antes do prior, ausência de novo `beta` e células `none` sem sentinela. Seus hashes, fórmulas-fonte e status não são evidência de aprovação do novo `A_C`.

O novo candidato deve corrigir, por construção:

- a omissão histórica de `y_bar` no domínio;
- a ausência da diagonal comum de `(rho,nu_off)`;
- qualquer uso de payoff interino como payoff realizado por tipo;
- qualquer pretensão de consumir anonimização sem a prova específica de fatoração;
- qualquer recombinação de coordenadas pertencentes a assessments distintos.

## 5. Limite da autorização

Esta autorização não abre `A_R`, não altera `A_M` ou `A_U`, não edita o manuscrito e não autoriza tag, merge ou push. Um candidato de `A_C` permanecerá `pending/unfrozen` até revisão independente, adjudicação e aprovação autoral terminal.

DOWNSTREAM_AUTHORIZATION: A_C_ONLY  
A_R_AUTHORIZATION: NONE  
MANUSCRIPT_TAG_MERGE_PUSH: NONE
