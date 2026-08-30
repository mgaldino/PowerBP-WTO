# Aprovação autoral terminal e congelamento — `A_R` sob M/S/B

**Data:** 2026-08-30  
**Natureza:** registro administrativo posterior às revisões e adjudicações; não altera nenhum byte matemático revisado  
**Nó:** `A_R` — decomposição das rendas de agenda e informação sob maioria e unanimidade, com M/S/B  
**Status deste snapshot:** `pass/frozen`

## 1. Decisão literal

Depois de receber o resumo dos resultados de `A_R`, a intuição econômica, a
identificação dos próximos passos e a informação explícita de que o pacote
estava revisado, adjudicado e ainda aguardava aprovação autoral terminal, o
autor respondeu:

> ok, aprovado

Essa frase aprova terminalmente `A_R`. Ela não autoriza migração para o
manuscrito, criação de tag, merge, push ou qualquer outro trabalho downstream.

## 2. Objeto aprovado

- worktree: `/private/tmp/PBP-am-msb`;
- branch de trabalho: `agenda-extension-am-msb`;
- commit do candidato matemático final:
  `8016dacb79c382d085f23f836a1fdbf8d9b05292`;
- commit dos pareceres formais e da adjudicação formal:
  `ff9b4617004ca216b5bbed88995cc752f60bf0a9`;
- commit do status de ciclo de vida revisado:
  `497e11801c020bf505cb4104df78ed599e9adf58`;
- commit dos pareceres e da adjudicação de ciclo de vida:
  `12d336a69ecfb4da6196ec55bb767d2dfe9bfa4d`;
- manifesto do candidato matemático, SHA-256:
  `b1b483f3c31d58c3cd94807e9b55fd303e795510210914634e29faaee322a6d0`,
  com `22/22` entradas válidas;
- manifesto do gate técnico, SHA-256:
  `f326c7fbf1b70fb66f286a6b9e265b67be76a4385553cbc288d828b0c0386a6f`,
  com `27/27` entradas válidas;
- manifesto do candidato de ciclo de vida, SHA-256:
  `25ff65848bf6509050a68732d195a864f15c69da3322e5bd2174f3f0adf7f859`,
  com `5/5` entradas válidas;
- manifesto do gate final de ciclo de vida, SHA-256:
  `10bfa622dd222639b7d2493f4c8b076dba9fd87bc25bb8e6709ba7930f270695`,
  com `10/10` entradas válidas;
- contrato, SHA-256:
  `c4867a9a8ef5f8171de04ae6b628a2fc29c5d5e033678f4448d0cbc55433f7a6`;
- resultados, SHA-256:
  `7a7913b6999a5cd69446d5f3e191f507f417582cd1c8617f7af0d5d8e8d331db`;
- interface pública, SHA-256:
  `62caca71f0fd221a7e17026d7518d53b97713ff9c9d7f61a62a52f312120800b`;
- records completos, SHA-256:
  `96d6045787200153f9d77cab9279053ad97a3076d2c23782b16b8f3e2ff6cca8`;
- claim ledger, SHA-256:
  `98d3ac5acc4ea347c5c3cca4ae41ffdda589683ea1399836b9f8f37ae5814a76`;
- verificador R, SHA-256:
  `bb52b97c4a18dc997a97bf1d1b902bacdc896ff0980e44ead8301287a0334320`;
- output matemático versionado, SHA-256:
  `9dae2730685afac8d8e6e0776eeecc2cfc41475059f4ea73a85ffc7acfdf6412`;
- relatório de implementação, SHA-256:
  `50d0dfc6ed9434f586a9e898aa84c098eca3ef445d293fbf6ad1c519faf8691d`;
- DAG simplificado, SHA-256:
  `a2572dc8954d63535d4edcbf04158e9524d11ed4537a822713e534df580ee9e0`,
  usado apenas como topologia e proveniência histórica, não como fonte do
  status corrente.

O verificador matemático registra:

```text
MECHANICAL RESULT: PASS | 4372 PASS | 0 FAIL
```

O verificador de ciclo de vida, antes desta aprovação, registrou:

```text
SUMMARY | 110 PASS | 0 FAIL
```

Essas contagens são evidência mecânica. O congelamento também depende das
provas, dos pareceres independentes, das adjudicações e desta decisão autoral.

## 3. Pareceres e adjudicações

Os dois pareceres formais independentes cobriram o mesmo candidato:

| Papel | Veredito | Contagens | SHA-256 |
|---|---|---|---|
| parecer formal independente 1 | `PASS` | `0/0/0` | `f694578d0964471e599404655f7997e8fc2a72d55ce364151875ae8adb5238ec` |
| parecer formal independente 2 | `PASS` | `0/0/0` | `ec31beb38d502125115e1d33f0481ec3116be72fdba92660da4d5a2eb846473a` |

A adjudicação formal final concluiu:

- veredito: `NO_CONFIRMED_DEFECTS`;
- contagens: `confirmed=0; partial=0; unresolved=0`;
- Markdown, SHA-256:
  `f80b6fee504a902e8ed2cb104d9f07a61643f90f201456870d4061694c84ecd0`;
- JSON, SHA-256:
  `e0bd23393115cfff963c6f50945fc6f9b715767e336b573a5f255fd1265b60bb`.

Dois pareceres independentes adicionais verificaram a reconciliação de ciclo
de vida, a imutabilidade dos bytes matemáticos e a fronteira de autorização:

| Papel | Veredito | Contagens | SHA-256 |
|---|---|---|---|
| parecer de ciclo de vida independente 1 | `PASS` | `0/0/0` | `84a503f6204495e76bbcbc7ff4b09afe44723e46a50f9453ad19efd68df82e96` |
| parecer de ciclo de vida independente 2 | `PASS` | `0/0/0` | `6ec0e930f6cbb1d90a762dcfa35d8a4e7cdea9c0da65686ef1a49923b060e7da` |

A adjudicação de ciclo de vida concluiu:

- veredito: `NO_CONFIRMED_DEFECTS`;
- contagens: `confirmed=0; partial=0; unresolved=0`;
- Markdown, SHA-256:
  `583c6ab75e172ff55b924b361d19bf8f5b53aa1ed9fcdc7a3c69f4e0a0d5fc42`;
- JSON, SHA-256:
  `95def36d481b8967cb3b463cfcb079ffa5b8030c7d4e7be11612955c3106621b`.

## 4. Efeito do congelamento

`A_R` passa a ser tratado como `pass/frozen` exclusivamente nos bytes listados
neste registro e no manifesto final correspondente.

O congelamento cobre:

- os benchmarks públicos completos por regra, incluindo a escolha ótima do
  hegemon sob maioria e unanimidade;
- a possibilidade, sob maioria, de atraso deliberado da proposta do hegemon e
  a convenção de empate já provada;
- os limiares públicos `h_M(o)` e `h_U(o)` e a diferença `G(o)`;
- as rendas de agenda por tipo, sem agregar tipos antes de construir os objetos
  completos;
- a renda informacional relativa aos benchmarks públicos;
- a decomposição da diferença institucional em parcela de agenda e parcela de
  informação;
- a interação institucional ligada exatamente uma vez pelo mesmo `beta`;
- os resultados de sinal da unanimidade dentro do escopo provado;
- o mapa exato das nove células de contraste de `N7`: seis records existentes
  e três células `none` com certificado explícito;
- a proibição de seleção silenciosa de equilíbrio, de binder ou de record.

Qualquer mudança futura nos arquivos governados cria um novo candidato, não
coberto por estes pareceres, adjudicações ou aprovação.

## 5. Fronteira preservada

Esta aprovação encerra apenas `A_R`:

- nenhum resultado migra para `formal_model_v6.Rmd` sem autorização separada;
- não há criação de tag, merge ou push;
- `N1`–`N7`, `A_M`, `A_U`, `A_C` e a tag
  `v6-essential-input-2026-08-25` permanecem intocados;
- prontidão topológica ou status `pass/frozen` não inicia trabalho downstream.

TERMINAL_AUTHOR_APPROVAL: APPROVED  
A_R_STATUS: PASS_FROZEN  
DOWNSTREAM_AUTHORIZATION: NONE
