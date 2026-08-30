# Aprovação autoral terminal e congelamento — `A_U` sob M/S/B em duas camadas

**Data:** 2026-08-30  
**Natureza:** registro administrativo posterior às revisões e à adjudicação; não altera nenhum byte matemático revisado  
**Nó:** `A_U` — estágio de agenda privada sob unanimidade, com M/S/B e arquitetura de assinatura em duas camadas  
**Status deste snapshot:** `pass/frozen`

## 1. Decisão literal

Depois de receber a identificação do pacote técnico exato, os resultados das duas revisões independentes, a adjudicação final e a informação explícita de que ainda faltava a aprovação autoral terminal, o autor respondeu:

> A_U aprovado. O que é A_C mesmo?

A primeira frase aprova terminalmente `A_U`. A pergunta subsequente solicita explicação sobre `AC`; ela não autoriza iniciar `AC`.

## 2. Objeto aprovado

- branch de trabalho: `agenda-extension-am-msb`;
- commit substantivo: `b56085c436eb629c335764eb982d174e5cc2d392`;
- commit candidato da rodada 2: `8e86bab8ea10f75e6fd5aeeb230a9e260479483a`;
- manifesto do candidato da rodada 2, SHA-256:
  `1c4720e99a1d72ec1533578a141e476679650eded2a333ac3a95f87e7d441b2b`;
- manifesto do gate técnico, SHA-256:
  `d28dec54f1707953eaf0298ea56ffca6098af95a4eed565a47ccd64536c139d3`;
- contrato, SHA-256:
  `348ffc702d75e47ec8f8008bccb71338174649f57d90af8fc78e919cfd4ded26`;
- resultados, SHA-256:
  `e2e2ec8cabc3d44b0c72bfa8ae1ef3d35256078448ce688db79bb7c1a96cdc11`;
- interface, SHA-256:
  `2ee931d21e3858db6702f78a4636d1f3c4b445910c8160120921c3bfc3b4b317`;
- claim ledger, SHA-256:
  `18de37fbadf787f9217f45c9eb5ef31854c75611c9f65ba8130e06a2cd2a34c5`;
- verificador R, SHA-256:
  `1c4c319fd925b6472612ddd5730ec4ee166af64a555f7aa97e6c930e1ad45fa6`;
- output versionado, SHA-256:
  `4d30e01cc288e2a66d9e1576df2bd89d478e75a6f447f3a8135fd8b694a7d0f2`;
- DAG reparado, SHA-256:
  `1baa17353f07452133f20d20bc16a43ccd91cfb7c6f8113cf78324a20ad08120`.

O manifesto técnico passou `13/13`. O verificador matemático registra:

```text
MECHANICAL RESULT: PASS | 1110 PASS | 0 FAIL
```

Essa contagem é evidência mecânica, não a base isolada do congelamento.

## 3. Pareceres e adjudicação

Os dois pareceres foram produzidos independentemente do implementador e entre si, em modo somente leitura, sobre o mesmo candidato:

| Papel | Veredito | Contagens | SHA-256 |
|---|---|---|---|
| parecer formal independente 1 | `PASS` | `0/0/0` | `6432708aabe1694603c99eb8df4e8b1ecda196ef8df8244128fd1b8f20c5be75` |
| parecer formal independente 2 | `PASS` | `0/0/0` | `3ae8bcf4e858f10784a25d548526a88f8d66469428c7c7ab0195704659458b84` |

A adjudicação independente final concluiu:

- ID: `a-u-msb-two-layer:8e86bab8ea10:round2`;
- veredito: `NO_CONFIRMED_DEFECTS`;
- contagens: `total=0; confirmed=0; partial=0; refuted=0; unresolved=0; held_decisions=0`;
- Markdown, SHA-256:
  `7b59712364c69b7a528d913d6904ffdb2d321276909b4b2792c47872df2b78a4`;
- JSON, SHA-256:
  `27350d0be42602bed3edec37de64ef82594513300bb74dff61432250d7548e50`;
- validação do schema: `VALID` contra o manifesto da rodada 2.

## 4. Efeito do congelamento

`A_U` sob M/S/B passa a ser tratado como `pass/frozen` exclusivamente nos bytes listados neste registro e no manifesto final correspondente.

O congelamento cobre:

- a correspondência estratégica preservada de `A_U`, incluindo famílias puras e mistas, endpoints e continuations literais;
- o transporte temporal com exatamente um fator `beta` quando cabível;
- a lei conjunta por tipo antes de qualquer quociente;
- a assinatura formal exata `Sig_ex_U` pela órbita diagonal;
- o resumo econômico anônimo `Sum_econ_U` por pushforward ao quociente;
- a prova de que o resumo econômico pode identificar assessments formalmente distintos;
- o contraexemplo que impede usar o operador de Reynolds como substituto de um assessment realizável;
- a preservação do binder completo para operações sensíveis a estratégias, crenças ou comportamento off-path;
- a regra de que qualquer consumidor downstream deve formar primeiro a fibra exata e só pode usar o resumo econômico depois de provar suficiência e fatoração mensurável para a operação específica.

Qualquer mudança futura nos arquivos governados cria um novo candidato, não coberto por estes pareceres, pela adjudicação ou por esta aprovação.

## 5. Fronteira preservada

Esta aprovação não inicia nem autoriza trabalho downstream:

- `AC` permanece `pending/unfrozen` e não autorizado; a pergunta do autor pede apenas uma explicação;
- `AR` permanece fechado e exige GO autoral separado;
- nenhum resultado migra para `formal_model_v6.Rmd` sem autorização separada;
- não há criação de tag, merge ou push;
- N1–N7 e a tag `v6-essential-input-2026-08-25` permanecem intocados.

Prontidão topológica de `AC` não equivale a autorização.

TERMINAL_AUTHOR_APPROVAL: APPROVED  
A_U_STATUS: PASS_FROZEN  
DOWNSTREAM_AUTHORIZATION: NONE
