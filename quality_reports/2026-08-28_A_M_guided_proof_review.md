# Registro da revisão guiada — extensão de agenda sob maioria (`A_M`)

**Data do registro:** 2026-08-28  
**Natureza:** revisão guiada, somente leitura, sem acesso ao parecer frio.  
**Veredicto do revisor:** `FAIL` — **0 critical / 1 important / 1 minor**.

Este documento preserva fielmente o resultado da revisão guiada executada pelo
novo protocolo. Não é uma nova opinião minha e não implementa os reparos
propostos pelo revisor.

## Bytes auditados e método

O revisor percorreu a derivação, o ledger, o script, o pacote para o ChatGPT e
o PDF exatamente nos hashes abaixo. A leitura foi guiada pelos claims
AM-L2/AMX-001–016 e pelas correções externas anteriores; o parecer frio não
foi consultado.

| Artefato auditado | SHA-256 |
|---|---|
| Derivação | `158ea83e6b896a6c3318643c948164757761128e7c2522b94c145a6e5547fce3` |
| Ledger | `83924102e227bb3445222e52805d5f25db77badc4237164002c8a31305ba44ed` |
| Script R | `6b615da5a0caf9e25ea5381b8e108b245aadc6705c79d39d5c232c3db9e50040` |
| Pacote textual | `41064624e5a6e397e0477536c60219e4adbc196280b13638c125e78958b29658` |
| PDF | `7f243257a9262bf6bda4c50f6f933a7204837c90a156f40209c752e022e6bfbc` |

O script terminou com **567 PASS / 0 FAIL**. Essa saída é uma verificação
mecânica, não uma prova independente de todos os claims. O PDF tinha 20
páginas; os hashes permaneceram íntegros e a inspeção visual não substitui a
revisão matemática.

## Findings registrados

### GUIDED-I1 — `CONFIRMED`

**Severidade:** important.  
**Tipo:** `scope_or_consistency`.  
**Disposição da correção:** `safe`.

AMX-003 e AMX-007 omitem `0<nu<1` na derivação e no ledger, embora o pacote
textual dê o escopo interior correto. Os endpoints precisam permanecer em
AMX-005. O revisor registrou os seguintes contraexemplos mecânicos:

1. **AMX-003:** `N=5`, `m=4`, `k=2`, `beta=.9`, `o0=.1`, `o1=.7`, `nu=0`.
   Tem-se `Z_E=.55` e `T=.6111`; `B(0)=S`. A rejeição do tipo alto vale
   `beta^2 o1=.567`, e não `beta o1=.63`. Como `Z_S(0)=.5905>.567`, o tipo
   alto prefere o acordo; a construção de separação indicada para o domínio
   interior não vale nesse endpoint.
2. **AMX-007:** `N=5`, `m=4`, `k=2`, `beta=.8`, `o0=.1`, `o1=T=.75`, `nu=0`.
   Tem-se `Z_E=.6`, enquanto a rejeição `S=.48`; logo o tipo alto não fica
   indiferente e não mistura nesse endpoint.

O reparo proposto é restringir AMX-003 e as construções gerais de AMX-007 a
`0<nu<1`. Os endpoints ficam em AMX-005, com mistura se e somente se
`Z_B(nu)=D_B(nu)(theta)`. Esse reparo não foi aplicado nesta etapa.

### GUIDED-M1 — `CONFIRMED`

**Severidade:** minor.  
**Tipo:** `artifact`.  
**Disposição da correção:** `safe`.

O ledger de AMX-011 aponta `Sections 5.3 and 6`, mas a prova está na Section
5.4, linhas 674–678. Trata-se de um localizador incorreto, não de uma falha
matemática. O reparo proposto é corrigir o apontador; ele não foi aplicado.

## Matriz resumida

| Claim(s) | Resultado da revisão guiada |
|---|---|
| AM-L2 | `PASS` no escopo reparado |
| AMX-001–002, AMX-004–006, AMX-008–012 | `PASS` nos escopos corretos |
| AMX-003 e AMX-007 | `FAIL` como registrados: endpoints omitidos |
| AMX-013 | Evidência mecânica presente; o script não substitui revisão matemática |
| AMX-014–016 | Abertos por desenho |

Os quatro reparos externos anteriores — teto pontual versus atingibilidade,
subfamília globalmente constante, família fixa entre posteriors e prova de
`K(s)<1` — passaram nesta leitura guiada. Isso não fecha AMX-014–016.

## Limites e conclusão

O resultado `FAIL` decorre de um importante problema de domínio (GUIDED-I1) e
de um problema menor de localização (GUIDED-M1). A execução mecânica alcançou
567/0 e o PDF permaneceu íntegro, mas esses fatos não certificam a
correspondência geral. Nenhum reparo, aprovação ou congelamento foi realizado
com base neste registro.
