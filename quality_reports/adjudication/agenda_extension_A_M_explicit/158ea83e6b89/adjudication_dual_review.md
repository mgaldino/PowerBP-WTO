# Adjudicação da revisão dupla — `A_M`

**Adjudication ID:** `agenda-extension-A-M-explicit:158ea83e6b89:dual-review`  
**Data:** 2026-08-28  
**Veredicto:** `BLOCKED`  
**Contagens:** `CONFIRMED 3 / PARTIAL 1 / REFUTED 0 / UNRESOLVED 0`  
**Severidades:** `1 critical / 2 important / 1 minor`.

Este é um registro histórico dos dois pareceres independentes já concluídos.
Não reabre a revisão, não implementa reparos e não substitui os pareceres
anteriores.

## Identidade do artefato e do contrato

O artefato comum auditado foi a derivação atual:

| Item | Caminho | SHA-256 |
|---|---|---|
| Derivação `A_M` | `model_redesign/agenda_extension_A_M_explicit_majority_results.md` | `158ea83e6b896a6c3318643c948164757761128e7c2522b94c145a6e5547fce3` |
| Contrato simplificado aprovado | `quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md` | `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4` |
| Continuação congelada `C_M` | `model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json` | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| Decisão de conceito de solução | `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` | `9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f` |
| Emenda autoral/técnica | `/private/tmp/PowerBayesianPersuasion-agenda-private-repair/quality_reports/2026-08-28_decisao_autoral_e_emenda_tecnica_agenda_extension.md` | `e841b9d3e56864fec29742a79ebfd1b963519ef65ddfa3882508a802fa94a935` |

O contrato governante é Markdown. O schema 1.0 do validador aceita
`--contract-file` somente quando o arquivo pode ser lido como JSON. Por isso,
o JSON desta adjudicação registra a identidade do contrato em um campo
adicional `contract_reference`, mantém o objeto `contract` opcional conforme o
schema e foi validado contra o artefato com `--artifact`, sem fingir uma
verificação automática do Markdown. Essa limitação é metodológica e está
registrada, não é uma alteração do contrato.

## Fontes dos pareceres

| Revisão | Natureza | SHA-256 |
|---|---|---|
| `COLD` | revisão fria, sem acesso à derivação, pacote, script, pareceres ou adjudicações anteriores | `e6c24e06a73e70f87167606fb7383de3e7d474131dff4dbd22cebae9a09e6063` |
| `GUIDED` | revisão guiada, sem acesso ao parecer frio | `f23e5dd9b69c4cbd26db290fbc839c38f1e9e614309b59a75132a1bf0f10cc61` |

## Disposição executiva

Os quatro findings abaixo são compatíveis entre si. Os dois reparos locais
propostos pelo parecer guiado são seguros, mas não foram aplicados nesta
etapa. O finding crítico confirma que AMX-014–016 permanecem abertos; assim,
o candidato não pode receber `PASS`/freeze nem ser consumido por `AC`. Os
resultados parciais — inclusive AM-L2 no escopo reparado — não são invalidados.

## Findings adjudicados

| ID | Status | Tipo | Severidade | Disposição da proposta |
|---|---|---|---|---|
| COLD-C1 | `CONFIRMED` | `scope_or_consistency` | critical | `needs_design` |
| COLD-I1 | `PARTIAL` | `artifact/review_protocol` | important | `needs_design` condicional |
| GUIDED-I1 | `CONFIRMED` | `scope_or_consistency` | important | `safe` |
| GUIDED-M1 | `CONFIRMED` | `artifact` | minor | `safe` |

### COLD-C1 — correspondência geral ainda aberta

O parecer frio confirma que AMX-014–016 deixam sem solução, respectivamente,
a correspondência pura geral, as misturas/semipooling gerais e o conjunto
completo de payoffs. Isso bloqueia fechamento e consumo de `A_M` sob o
contrato. A conclusão não derruba AM-L2, as construções explícitas nem os
bounds parciais que sobreviveram nos seus escopos.

O contraexemplo frio é um seletor diagonal Borel dependente da proposta, com
`N=5`, `m=4`, `k=2`, `beta=.9`, `o0=.30` e `o1=.40`, somente no ramo `E`.
O payoff aprovado tem supremo `.50`, mas nenhum máximo. Isso confirma a
necessidade de uma condição de autoconsistência para atingibilidade, mas não
refuta o teto pontual de AM-L2.

**Classificação:** `CONFIRMED`; **scope_or_consistency**, **critical**;
`needs_design`. Fechar AMX-014–016 exige continuar a derivação. Restringir
`kappa`, privilegiar uma família ou relaxar a correspondência completa exigiria
decisão autoral/alteração do contrato.

### COLD-I1 — limitação do dossier frio

O material deliberadamente cego não definia `T`, `Z_E`, `\bar Z_E`, `A_g` e as
desigualdades completas. Isso é uma insuficiência confirmada do dossier frio,
mas o pacote completo contém essas definições. Portanto o finding é `PARTIAL`,
não um defeito do pacote. Só seria necessário desenho adicional se se quisesse
que a revisão fria, por si só, certificasse todos os claims.

**Classificação:** `PARTIAL`; **artifact/review_protocol**, **important**;
`needs_design` condicional.

### GUIDED-I1 — escopo interior omitido em AMX-003/AMX-007

O parecer guiado confirma que a derivação e o ledger não escrevem
`0<nu<1` nos escopos de AMX-003 e AMX-007, embora o pacote textual contenha o
escopo interior. Os endpoints devem ficar em AMX-005. Os testes fornecidos são:

- AMX-003: `N=5,m=4,k=2,beta=.9,o0=.1,o1=.7,nu=0`, com `Z_E=.55`,
  `T=.6111`, `B(0)=S`; a rejeição do tipo alto é `beta^2 o1=.567`, não
  `beta o1=.63`, e `Z_S(0)=.5905>.567`, logo o alto prefere acordo.
- AMX-007: `N=5,m=4,k=2,beta=.8,o0=.1,o1=T=.75,nu=0`, com `Z_E=.6` e
  rejeição `S=.48`; portanto o alto não mistura nesse endpoint.

A proposta registrada foi restringir AMX-003 e as construções gerais de
AMX-007 a `0<nu<1`, deixando endpoints em AMX-005 com mistura se e somente se
`Z_B(nu)=D_B(nu)(theta)`. O diagnóstico e a proposta são seguros, mas ficaram
sem implementação por instrução.

**Classificação:** `CONFIRMED`; **scope_or_consistency**, **important**;
`safe`.

### GUIDED-M1 — localizador de AMX-011

O ledger aponta `Sections 5.3 and 6`, mas a prova está na Section 5.4,
linhas 674–678. É um erro de artefato/localização, não uma falha matemática.
O reparo seguro seria corrigir o apontador.

**Classificação:** `CONFIRMED`; **artifact**, **minor**; `safe`.

## Limites, decisões e disposição

- A revisão guiada confirmou que os quatro reparos externos anteriores
  passaram; o script registrou 567 PASS/0 FAIL e o PDF tem 20 páginas. Esses
  fatos são evidência mecânica/arquivística, não uma nova prova.
- AMX-014–016 continuam abertos por desenho. Não foram avançados nesta
  adjudicação.
- Nenhuma nova decisão econômica do autor é necessária para os dois reparos
  locais GUIDED-I1/GUIDED-M1. Decisão autoral será necessária se o projeto
  quiser restringir `kappa`, privilegiar uma família ou relaxar a
  correspondência completa.
- O candidato permanece exploratório. Não recebe `PASS`, não é congelado e
  não pode ser consumido por `AC`.

## Validação

O JSON correspondente foi validado com `validate_adjudication.py` contra a
derivação atual. A tentativa de usar o contrato Markdown como
`--contract-file` não é suportada pelo schema/validador 1.0; por isso o limite
foi registrado acima e a validação foi feita somente com `--artifact`.
