# Fechamento — Goal 1 da extensão de agenda

**Data:** 2026-08-27  
**Status:** `PASS — GOAL 1 CLOSED`  
**Gate 0 simplificado:** `APPROVED — CLOSED`  
**Nós matemáticos:** `A_M`, `A_U`, `AC` e `AR` continuam `pending`  
**Pacote privado:** `NOT AUTHORIZED`

## Autorização que abriu este Goal

O autor autorizou exclusivamente:

> Autorizo exclusivamente o Goal 1 da extensão de agenda na branch
> `codex/agenda-extension-gate0`: fixar os hashes das interfaces externas,
> auditar sua consumibilidade, criar e executar o verifier e o conjunto de
> testes mecânicos previstos no contrato, obter uma revisão independente de
> código e escopo e, se houver PASS, registrar, commitar e fazer push dos
> artefatos finais do Goal 1. Se faltar informação indispensável, pare e
> reporte. Não autoriza derivar `A_M`, `A_U`, `AC` ou `AR`, editar o manuscrito
> nem abrir o pacote privado.

O trabalho permaneceu dentro desse limite.

## Entregas finais e hashes

| Artefato | SHA-256 |
|---|---|
| manifesto de interfaces externas: `model_redesign/agenda_extension_goal1_external_interfaces.json` | `588e7da2ec7df2f208ccaf082d3bc30834ea12625484b04b25d3eae7fce20a86` |
| biblioteca do verificador: `scripts/agenda_extension_goal1_verifier_lib.R` | `b067fac9f4b059c5eb5638b23119601ae527dc98ac9dc17d26792711eb752492` |
| verificador: `scripts/verify_agenda_extension_goal1.R` | `8056c1c43622262fdd3849c9bf89722c26d3703d35d365833c3c2735cefa4849` |
| conjunto de testes: `scripts/test_agenda_extension_goal1.R` | `2662ded08589e73c3a2533dc7761603175537230e72e388747f88c83cb68254d` |
| auditoria de hashes e consumibilidade: `quality_reports/2026-08-27_agenda_extension_goal1_interface_audit.md` | `a0e2dd807389d4a70839a0fc7eb07c7a26c62b08dd5574452e679ec4dfe42033` |
| revisão independente de código e escopo: `quality_reports/2026-08-27_agenda_extension_goal1_independent_code_scope_review.md` | `7da5878ca3c8442ebaec8b1e560915a9195e2f7a13f894192d371241a3ebf60e` |

## Interfaces externas fixadas

| Interface | SHA-256 |
|---|---|
| `C_M` | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| `C_U` | `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b` |
| `N7_public` | `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45` |

As três interfaces foram classificadas como estruturalmente consumíveis sem
edição dos bytes congelados. Isso significa que caminhos, hashes, células,
registros, fontes, payoffs, resultados e datas necessários à leitura futura
estão presentes. Não significa validação matemática nova.

O snapshot histórico da errata usado por N4, no hash
`94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69`,
foi resolvido no commit `1a12b749f967d460f819d8732634992ba75fdcf8`.
Ele permanece separado do arquivo normativo corrente, no hash
`9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f`.

## Evidência mecânica

```text
Rscript --vanilla scripts/verify_agenda_extension_goal1.R
SUMMARY | 31 PASS | 0 FAIL
```

```text
Rscript --vanilla scripts/test_agenda_extension_goal1.R
SUMMARY | 39 PASS | 0 FAIL
```

Os avisos de locale emitidos na inicialização do R não alteraram os hashes, o
parsing, os resultados ou os códigos de saída. Ambos os comandos terminaram
com código zero.

## Revisão independente

O revisor independente permaneceu `read-only`, recalculou os cinco hashes
submetidos, repetiu os dois comandos e inspecionou a cobertura e o limite do
código.

Veredito estrito:

```text
PASS 0/0/0
críticos: 0
importantes: 0
menores: 0
```

O parecer cobre exatamente o manifesto, os três scripts e a auditoria nos
hashes listados acima. O registro de fechamento e o próprio parecer não
alteram esses cinco bytes.

## O que este fechamento não faz

O Goal 1 não provou existência ou completude de equilíbrio, ausência de
desvios, otimalidade de misturas, limites locais de Bayes, mensurabilidade,
cobertura de famílias ou invariância. Também não:

- derivou ou preencheu `A_M`, `A_U`, `AC` ou `AR`;
- alterou o DAG ou os quatro ledgers aprovados do Gate 0;
- editou ou compilou `formal_model_v6.Rmd`;
- abriu o pacote privado;
- autorizou qualquer Goal seguinte.

## Próxima fronteira

O próximo passo possível é um novo GO autoral para o pacote privado, na ordem
`A_M`, depois reconstrução cega de `A_U`, depois `AC`, conforme o contrato.
Prontidão técnica, fechamento deste Goal e existência dos hashes não substituem
essa autorização. `AR` continua opcional e exigiria decisão posterior própria.
