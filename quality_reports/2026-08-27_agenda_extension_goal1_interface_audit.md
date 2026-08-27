# Goal 1 da extensão de agenda — hashes, consumibilidade e testes mecânicos

**Data:** 2026-08-27  
**Branch de destino:** `codex/agenda-extension-gate0`  
**Base desta implementação:** `7f1c1188b045555e48eb4d1758a9ca3c97bf8cab`  
**Status deste relatório:** `IMPLEMENTED — MECHANICAL PASS — INDEPENDENT REVIEW PENDING`  
**Escopo:** exclusivamente a infraestrutura mínima do Goal 1.

## Resultado em linguagem direta

As três interfaces externas necessárias estão presentes, podem ser lidas por
código e não precisam ser corrigidas ou completadas para que uma fase futura
possa citá-las. Seus bytes foram presos por SHA-256. O verificador passou em
31 verificações do repositório, e o conjunto de testes passou em 39 casos
positivos e negativos.

Isso não resolve nenhum equilíbrio novo. Nenhum resultado de `A_M`, `A_U`,
`AC` ou `AR` foi escrito, e nenhum ledger deixou o cabeçalho vazio aprovado no
Gate 0.

## Interfaces fixadas

| Interface | Função futura | SHA-256 corrente |
|---|---|---|
| `C_M` | continuação privada sob maioria | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| `C_U` | continuação privada sob unanimidade | `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b` |
| `N7_public` | benchmarks de tipo público, apenas se `AR` receber autorização futura | `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45` |

O manifesto reproduzível é
`model_redesign/agenda_extension_goal1_external_interfaces.json`, SHA-256
`588e7da2ec7df2f208ccaf082d3bc30834ea12625484b04b25d3eae7fce20a86`.
Além das três interfaces, ele prende o plano da extensão, os dois contratos
normativos, o DAG de `essential-input`, as dependências diretas declaradas e os
seis artefatos aprovados do Gate 0 simplificado.

## O que “consumível” quer dizer aqui

O teste foi propositalmente limitado. Uma interface é consumível quando:

1. o caminho existe e o arquivo é JSON válido;
2. o hash calculado coincide com o hash fixado;
3. células que contêm membros existentes os distinguem por identificador e
   expõem, em conjunto, estratégia, crenças, fontes, payoffs, resultados e
   data do payoff;
4. uma célula que declara ausência não inventa um payoff substituto: ela fica
   sem membro e traz um certificado de não existência;
5. os identificadores e hashes de dependências declaradas podem ser
   resolvidos sem editar o arquivo congelado.

Esse teste não afirma que a descrição matemática dentro dos campos está
correta ou completa. Essa autoridade continua pertencendo à prova e à revisão
matemática futura.

### `C_M`

`C_M` possui uma célula de correspondência com registro completo. O registro
expõe a estratégia, as crenças, os identificadores e hashes da continuação de
origem, os payoffs de `H` separados por tipo, a distribuição de resultados e a
data do payoff. Resultado mecânico: `consumable_without_edit`.

### `C_U`

`C_U` possui duas células com membros completos e uma célula `none` acompanhada
de certificado. Essa célula `none` é conteúdo substantivo da interface
congelada; não é campo ausente e não foi substituída por zero, `NA` ou outro
valor artificial. O Goal 1 apenas confirma que uma fase futura consegue ler
essa distinção. Ele não deriva suas consequências para `A_U`.

Há uma diferença de versões que precisa permanecer visível. `C_U` foi revisado
com a versão da decisão sobre suporte do prior no SHA-256
`94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69`.
Esses bytes continuam recuperáveis no commit
`1a12b749f967d460f819d8732634992ba75fdcf8`. O arquivo normativo corrente teve
acréscimos posteriores e hoje possui SHA-256
`9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f`.
O manifesto registra os dois snapshots separadamente; não estende a revisão de
N4 para bytes posteriores.

### `N7_public`

`N7_public` expõe células por instituição, rodada e tipo público. Os registros
contêm estratégias, crenças, identificadores de continuação, vetores de payoff,
resultados e datas. Resultado mecânico: `consumable_without_edit`. O arquivo
continua sem uso ativo porque `AR` é opcional e não foi autorizado.

## Verificador e testes

Artefatos executáveis:

| Artefato | SHA-256 |
|---|---|
| `scripts/agenda_extension_goal1_verifier_lib.R` | `b067fac9f4b059c5eb5638b23119601ae527dc98ac9dc17d26792711eb752492` |
| `scripts/verify_agenda_extension_goal1.R` | `8056c1c43622262fdd3849c9bf89722c26d3703d35d365833c3c2735cefa4849` |
| `scripts/test_agenda_extension_goal1.R` | `2662ded08589e73c3a2533dc7761603175537230e72e388747f88c83cb68254d` |

Comandos executados:

```text
Rscript --vanilla scripts/verify_agenda_extension_goal1.R
Rscript --vanilla scripts/test_agenda_extension_goal1.R
```

Ambiente observado: R 4.4.2 e `jsonlite` 2.0.0. O macOS emitiu apenas avisos de
locale ao iniciar o R; ambos os processos terminaram com código zero.

Resultado do verificador:

```text
SUMMARY | 31 PASS | 0 FAIL
PASS: pinned external hashes, structural consumability, approved Gate 0 bytes,
schemas, DAG topology, finite quotas, date transport, and supplied finite
identities passed.
```

Resultado do conjunto de testes:

```text
SUMMARY | 39 PASS | 0 FAIL
PASS: representative positive and negative mechanical tests succeeded.
```

Os testes negativos rejeitam, entre outros casos: JSON malformado, fonte
inexistente, hash não fixado, hash autorreferente, campo obrigatório ausente,
payoff-sentinela, célula `none` sem certificado, ciclo no DAG, nó liberado antes
da hora, binder incompatível, combinação de coordenadas de famílias distintas,
claim provado sem prova, claim numérico sem evidência, aplicação dupla de
`beta`, fator temporal incorreto e identidade algébrica falsa.

## Limites explícitos

O verificador não prova:

- existência ou completude de Perfect Bayesian Equilibrium;
- ausência de desvio lucrativo em todo o espaço contínuo de propostas;
- otimalidade de estratégia mista;
- existência do limite local de Bayes em todo ponto disciplinado;
- mensurabilidade de função simbólica arbitrária;
- necessidade e suficiência de gerador de membros;
- cobertura de todas as famílias de equilíbrio;
- invariância de resultado numa família contínua.

## Preservação do Gate 0 e da fronteira autoral

Os seis artefatos aprovados do Gate 0 continuam nos hashes cobertos pela
aprovação terminal. O DAG ainda mantém `A_M`, `A_U`, `AC` e `AR` como
`pending`; nenhum campo de passagem foi acrescentado. Não houve edição do
manuscrito, compilação, derivação, cálculo de equilíbrio nem abertura do pacote
privado.

O próximo passo deste Goal 1 é exclusivamente a revisão independente de código
e escopo sobre os hashes acima. O Goal 1 só poderá ser registrado como fechado
se essa revisão terminar em PASS sem findings.
