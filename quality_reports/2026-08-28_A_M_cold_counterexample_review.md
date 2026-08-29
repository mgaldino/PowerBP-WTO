# Registro da revisão fria — extensão de agenda sob maioria (`A_M`)

**Data do registro:** 2026-08-28  
**Natureza:** revisão fria, somente leitura, sem acesso à derivação, ao pacote,
ao script, aos pareceres ou às adjudicações anteriores.  
**Veredicto do revisor:** `FAIL` — **1 critical / 1 important / 0 minor**.

Este documento preserva o resultado da revisão fria executada pelo novo
protocolo. Ele não é uma nova opinião minha e não altera nenhum artefato
matemático.

## Escopo, cegamento e bytes permitidos

O revisor recebeu apenas o contrato simplificado aprovado, a continuação
congelada `C_M`, a decisão de conceito de solução, a emenda técnica e a
projeção semântica do ledger. No ledger foram examinadas somente as colunas
`claim_id/kind/scope/claim`, no arquivo cujo SHA-256 integral é
`83924102e227bb3445222e52805d5f25db77badc4237164002c8a31305ba44ed`.

Ressalvas de cegamento registradas pelo revisor:

- uma linha genérica da memória mencionava histórico `FAIL`, isoladamente;
- uma busca nos insumos permitidos mostrou rótulos de caminhos da coluna
  `evidence`, mas nenhum desses caminhos foi aberto;
- não foram abertos a derivação, o pacote para o ChatGPT, o script, os
  pareceres anteriores, as adjudicações ou o PDF.

### Hashes dos insumos lidos

| Insumo permitido | Caminho | SHA-256 |
|---|---|---|
| Contrato simplificado aprovado | `quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md` | `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4` |
| Continuação congelada `C_M` | `model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json` | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| Decisão de conceito de solução | `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` | `9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f` |
| Emenda autoral/técnica | `/private/tmp/PowerBayesianPersuasion-agenda-private-repair/quality_reports/2026-08-28_decisao_autoral_e_emenda_tecnica_agenda_extension.md` | `e841b9d3e56864fec29742a79ebfd1b963519ef65ddfa3882508a802fa94a935` |
| Ledger projetado | `model_redesign/agenda_extension_A_M_explicit_majority_claim_ledger.tsv` | `83924102e227bb3445222e52805d5f25db77badc4237164002c8a31305ba44ed` |

## Método reconstruído pelo revisor

O revisor reconstruiu, a partir dos insumos permitidos, a comparação pivotal
ponto a ponto: para cada proposta e cada vetor pivotal, um Estado fraco
compara sua própria oferta com sua própria continuação transportada. A partir
disso, construiu bounds de imitação, separou construções puras de misturas e
verificou um exemplo semipooling. A reconstrução preservou o resultado de que
AM-L2 e os invariantes globais são informativos quando formulados no escopo
correto.

O ataque novo mais forte foi um seletor diagonal Borel dependente da proposta,
com `N=5`, `m=4`, `k=2`, `beta=.9`, `o0=.30` e `o1=.40`, somente no ramo `E`.
Nessa construção, o payoff aprovado do hegemon tem supremo `.50`, mas não tem
máximo. O ataque não refuta AM-L2: ele mostra que o teto pontual não pode, por
si só, classificar um `kappa` arbitrário como atingível. Alterar a proposta
pode alterar o conjunto de incidência escolhido pelo seletor, de modo que o
problema requer uma condição de ponto fixo ou uma família fixa.

## Findings registrados

### COLD-C1 — `CONFIRMED`

**Severidade:** critical.  
**Tipo:** `scope_or_consistency`.  
**Disposição da correção:** `needs_design`.

AMX-014–016 continuam sem resolver, respectivamente, a correspondência pura
geral, as misturas/semipooling gerais e o conjunto completo de payoffs. Isso
impede o fechamento e o consumo de `A_M` sob o contrato atual. O finding não
invalida AM-L2, as construções explícitas já obtidas nem os bounds parciais;
ele registra que o resultado ainda não é uma classificação/consumo completo.

### COLD-I1 — `PARTIAL`

**Severidade:** important.  
**Tipo:** `artifact/review_protocol`.  
**Disposição da correção:** `needs_design` somente se o objetivo for que a
revisão fria certifique todos os claims.

O dossier frio restrito não definia `T`, `Z_E`, `\bar Z_E`, `A_g` nem as
desigualdades completas. Essa insuficiência é real para o material deliberadamente
cego. Ela não é defeito do pacote completo, que contém essas definições. O
finding é, portanto, parcial: confirma uma limitação do protocolo frio e não
uma falha do artefato integral.

## Matriz resumida de sobrevivência

| Claim(s) | Resultado a frio | Limite registrado |
|---|---|---|
| AM-L2 | Sobrevive no escopo reconstruído | Teto pontual não classifica `kappa` arbitrário; o contraexemplo exige autoconsistência |
| AMX-001–005, AMX-007, AMX-009, AMX-011–012 | Sobrevivem nos escopos reconstruídos | Não implica fechamento da correspondência geral |
| AMX-006 | Classe não vazia sobrevive | Domínio geral não certificável a frio |
| AMX-008 | Qualitativo sobrevive | Quantitativo não certificável sem abrir o pacote completo |
| AMX-010 | Parcial | Bounds globais sobrevivem onde reconstruídos; não há certificação integral a frio |
| AMX-013 | Não lido | O script estava fora do escopo cego |
| AMX-014–016 | Abertos | São precisamente o bloqueio para uma classificação/consumo completo |

## Conclusão do registro

A revisão fria preservou AM-L2, as construções puras e os invariantes globais
nos seus escopos reconstruídos. O contraexemplo diagonal reforça a necessidade
de não confundir um teto pontual com atingibilidade. O resultado agregado é
`FAIL` porque AMX-014–016 deixam aberta a correspondência geral e, portanto,
bloqueiam fechamento/consumo de `A_M` sob o contrato. Nenhuma correção foi
implementada e nenhuma aprovação ou congelamento é emitido por este registro.
