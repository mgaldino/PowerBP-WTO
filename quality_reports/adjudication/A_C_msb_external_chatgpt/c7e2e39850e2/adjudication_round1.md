# Adjudicação da consulta técnica externa não formal — `A_C` M/S/B

**Adjudication ID:** `a-c-msb-external-chatgpt:68eeefe86b8a:round1`  
**Data/hora:** `2026-08-30T12:32:37-03:00`  
**Modo:** read-only quanto aos artefatos matemáticos de `A_C`  
**Branch:** `agenda-extension-am-msb`  
**HEAD inspecionado:** `f6a58dbd2fc3a21fff1510366089c8e8269176e8`  
**Manifesto do candidato:** `quality_reports/2026-08-30_AC_msb_terminal_gate_candidate_manifest.sha256`  
**SHA-256 do manifesto:** `68eeefe86b8ade64266c1c8c9901ef070742aa2821e356371a5736dabfceaf64`

## 1. Disposição executiva

A consulta externa confirma a arquitetura matemática central de `A_C`, inclusive
T1--T5, condicionada aos resultados congelados de `A_M` e `A_U`. A adjudicação
encontrou dois reparos locais tecnicamente justificados:

1. qualificar as duas formulações absolutas do contrato que dizem que o
   acoplamento ou a lei conjunta cross-world é “inexistente”; e
2. definir explicitamente a coordenada `V_g^E` antes de usá-la nos envelopes.

A primeira crítica é apenas parcial: o arquivo de resultados já diz “não se
define” e a interface registra `not_defined`, formulações compatíveis com a
arquitetura. O erro está nas duas frases absolutas do contrato, não na decisão
modelística de deixar o acoplamento sem identificação.

As recomendações sobre não vacuidade de T5, Borelidade fiberwise e casco
intervalar não identificam defeitos atuais: o texto já restringe T5 a pares
comparáveis, formula T3 na fibra fixa e explicita tanto o intervalo fechado
`[inf D_r,sup D_r]` quanto a limitação dos conjuntos.

A margem uniforme de T5 e o corolário da célula baixa são implicações corretas,
mas são resultados adicionais opcionais. Sua inclusão é decisão autoral e não
faz parte do reparo mínimo.

## 2. Identidade e integridade

A resposta externa foi preservada byte a byte em
`quality_reports/external_reviews/2026-08-30_consulta_tecnica_externa_nao_formal_chatgpt_AC_msb.md`,
com SHA-256
`c7e2e39850e23ae6e0353d5b4ff0c15d88e1d23035717e4fa751c5d4b4aea796`.

O manifesto terminal passou 12/12 verificações. Os três artefatos diretamente
afetados pelas observações externas permaneceram íntegros durante a
adjudicação:

| Artefato | SHA-256 |
|---|---|
| `model_redesign/agenda_extension_AC_msb_contract.md` | `d09958a447cc440586c000f92c10982ae1f786a94845c602d714c6ff284a8b14` |
| `model_redesign/agenda_extension_AC_msb_results.md` | `479c0089a1ed6a08dc9ffd8061933d248505c9b753a036f812f5b163586d8e77` |
| `model_redesign/agenda_extension_AC_msb_interface.json` | `103b564bd15af69dbb45c6b57cd16a0228d3c60a24b758ad779f6b75e7fe2cdf` |

Não existe argument-contract JSON compatível com o validador. Por isso, o
registro estruturado usa `contract.required=false`.

## 3. Findings normalizados

| ID | Finding candidato | Estado | Severidade | Disposição |
|---|---|---|---|---|
| `WEB-AC-F001` | “Não existe” lei conjunta cross-world é forte demais | `PARTIAL` | minor | Reparar somente as duas frases absolutas do contrato; preservar `not_defined` e a ausência de lei model-implied |
| `WEB-AC-F002` | T5 precisa declarar não vacuidade | `REFUTED` | minor | Nenhuma correção necessária; “todo par comparável” e as regras de `none` já excluem leitura econômica da fibra vazia |
| `WEB-AC-F003` | Falta definição geral de `V_g^E` | `CONFIRMED` | minor | Inserir definição local antes dos envelopes e manter a imagem ligada de `D_E` |
| `WEB-AC-F004` | T3 é ambíguo sobre a origem de `nu` | `REFUTED` | minor | T3 já é explicitamente fiberwise, com `d` e `eta` fixos; sobrescrito opcional não é reparo necessário |
| `WEB-AC-F005` | O envelope precisa dizer “fechado” e declarar limitação | `REFUTED` | minor | O intervalo usa colchetes e a frase anterior já diz “conjuntos limitados” |
| `WEB-AC-F006` | T5 entrega margem uniforme explícita | `CONFIRMED` | minor | Resultado novo opcional; inclusão depende do autor |
| `WEB-AC-F007` | Célula baixa, contraexemplo à necessidade e paridade fortalecem T5 | `CONFIRMED` | minor | Resultados novos opcionais; inclusão depende do autor |

## 4. Evidência e raciocínio

### `WEB-AC-F001` — `PARTIAL`

O contrato afirma “Acoplamento probabilístico cross-world | inexistente e não
presumido” e “Não existe lei conjunta cross-world”. As marginais admitem ao
menos o acoplamento-produto nas estruturas usuais; logo “inexistente” é uma
afirmação matemática excessiva.

Entretanto, o restante do pacote já formula corretamente a escolha modelística:

- `agenda_extension_AC_msb_results.md:63` diz que o modelo não possui
  dispositivo de correlação cross-world;
- `agenda_extension_AC_msb_results.md:452` diz que a probabilidade conjunta
  “não se define”;
- a interface registra `cross_world_joint_law: not_defined` e
  `joint_probability_between_rules: not_defined`.

Portanto, a crítica não invalida `O_AC`, T1 ou o produto fibrado. O reparo seguro
é substituir somente a linguagem de inexistência por: o jogo e `A_C` não
induzem, selecionam nem identificam uma lei conjunta; impor um acoplamento
acrescentaria uma convenção cross-world.

### `WEB-AC-F002` — `REFUTED`

T5 conclui “em todo par comparável”. Antes dele, T4 define exatamente quando
`J_AC^bind` é não vazio; a Seção 7 determina que, se `J_AC` é vazio, não há sinal
institucional e a classificação é `none`; e o teto de `A_U` é enunciado “em toda
fibra existente”. A hipótese explícita de não vacuidade seria uma repetição útil
para leitores, mas sua ausência não produz o defeito alegado.

### `WEB-AC-F003` — `CONFIRMED`

O texto define `delta_E` e usa valores ex ante específicos de `A_U`, mas a
Seção 9 passa de “coordenada escalar `r`” para `M_r` e `U_r` e depois inclui
`r in {0,1,E}` sem ter definido em geral
`V_g^E(R_g)=(1-nu)V_g^0(R_g)+nu V_g^1(R_g)`. A interpretação é recuperável de
T2, mas a notação deve ser total antes de ser usada.

O reparo mínimo é uma definição local. A observação de que `D_E` é a imagem
linear do conjunto ligado `D_01`, e não uma combinação independente das duas
marginais, apenas torna explícita uma restrição que a Seção 7 já preserva.

### `WEB-AC-F004` — `REFUTED`

O domínio começa com “Fixe `d=(...,nu)`”; os resumos carregam `eta`; o contrato
exige a fatorização “dentro da mesma fibra”; e T3 começa “Na mesma fibra
`eta`”. Assim, `nu` é constante no teorema fiberwise. Escrever
`C_bar_econ^{d,eta}` seria uma precisão tipográfica possível, não a correção de
uma falha de mensurabilidade.

### `WEB-AC-F005` — `REFUTED`

A Seção 9 já diz que as identidades valem para “conjuntos limitados” e escreve o
objeto como `[inf D_r,sup D_r]`, isto é, um intervalo fechado. Chamá-lo de
“casco intervalar fechado” é estilisticamente mais explícito, mas não muda a
afirmação nem fecha uma lacuna formal.

### `WEB-AC-F006` — `CONFIRMED`, decisão autoral

Da própria prova de T5,

```text
V_M^theta-V_U^theta
 >= Z_E-z_H
 = beta*(c/m-beta*o_1).
```

Logo a margem uniforme por tipo e ex ante é válida. O enunciado atual já prova
o sinal necessário; promover a desigualdade quantitativa a corolário é uma
escolha de exposição e escopo, não reparo forçado.

### `WEB-AC-F007` — `CONFIRMED`, decisão autoral

Nas células baixas existentes, `V_U^0=V_U^1=z_L`, de modo que

```text
Z_E-z_L=beta*(c/m-beta*o_0).
```

Assim, `beta*o_0<c/m` basta para dominância estrita de maioria dos dois tipos
nessas células; em `nu=0`, basta para a vantagem ex ante. O exemplo
`N=5`, `beta=0.9`, `o_0=0.5`, `o_1=0.6` reproduz
`Z_E=0.55>0.505=max{z_L,d_H}` embora T5 falhe porque
`beta*o_1=0.54>c/m=0.5`. Isso é contraexemplo à necessidade, não à suficiência.

A identidade de paridade também é correta:

```text
c/m = 1/2                         se N é ímpar,
c/m = (N-2)/(2*(N-1))             se N é par.
```

A aritmética do exemplo e a identidade foram reproduzidas mecanicamente; a
última passou para todos os inteiros `N=3,...,100`. Esses resultados ampliam a
apresentação econômica de T5 e, portanto, dependem de decisão autoral.

## 5. Escopo de uma eventual implementação

O reparo mínimo tecnicamente determinado alteraria apenas:

1. as duas formulações absolutas em
   `model_redesign/agenda_extension_AC_msb_contract.md`; e
2. a definição de `V_g^E` em
   `model_redesign/agenda_extension_AC_msb_results.md`, com sincronização da
   interface/ledger/verificador somente se seus contratos de rastreabilidade
   exigirem novos registros.

Não se deve implementar automaticamente a margem uniforme, o corolário da
célula baixa, o contraexemplo ou a interpretação de paridade. Tampouco se deve
alterar T1--T5, o produto fibrado, a diagonal de crenças, as correspondências de
`A_M`/`A_U` ou introduzir um acoplamento cross-world.

Qualquer modificação criará novos bytes não cobertos pelos dois pareceres
formais anteriores. Será necessário novo manifesto, reexecução dos checks e
novas revisões independentes antes de aprovação terminal.

## 6. Veredito

`READY_FOR_IMPLEMENTATION` significa apenas que os dois reparos locais estão
tecnicamente determinados. Não é autorização para editar, não é PASS formal,
não congela `A_C` e não autoriza `A_R`, manuscrito, tag, merge ou push.

ADJUDICATION_VERDICT: READY_FOR_IMPLEMENTATION  
COUNTS: TOTAL 7 | CONFIRMED 3 | PARTIAL 1 | REFUTED 3 | UNRESOLVED 0 | HELD_DECISIONS 2
