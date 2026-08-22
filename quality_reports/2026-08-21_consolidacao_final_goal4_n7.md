# Consolidação final do Goal 4 — N7

**Data:** 2026-08-21

**Estado:** Goal 4 encerrado; N7 `pass/frozen`; Goal 5 não autorizado

## 1. Topologia Git

A consolidação foi realizada na worktree
`/private/tmp/PowerBayesianPersuasion-post-n6-consolidation`, branch
`codex/essential-input-post-n6-consolidation`.

Ela preserva como pais:

- o checkpoint pós-N6 e de infraestrutura/documentação consolidada,
  `4899f59f795fffcd9ee1d2c29a430baeba9e32c8`;
- o checkpoint congelado de N7,
  `8ef5fa980976febb8fdf1f0dfc0cb25702ece63e`.

O merge foi automático e não produziu conflitos. Nenhum arquivo da
infraestrutura paralela foi removido ou usado para rederivar N7.

## 2. Aval e estado final

O aval literal do autor está preservado em
`quality_reports/2026-08-21_fechamento_autoral_goal4_n7.md`, SHA-256
`ca7a842b3a953ab16e76dbf518692a0d05a87d1224093a53d4ccc647624545d2`.

O Gate 0 administrativo passou a verificar esse registro exato e declara:

- N1, N2, N3, N4, N6 e N7 `pass/frozen`;
- Goal 4 encerrado;
- nenhum nó derivacional pronto;
- Goal 5, extensões com `beta=1` e migração para manuscrito não autorizados.

O novo SHA-256 do Gate 0 administrativo é
`0bd17015c39a23c7615cd3f8a27b91c65ed6763790080154ae098ff2a5376cd7`.
Essa mudança registra apenas a transição autoral pós-freeze; nenhum hash de nó,
interface ou parecer foi alterado.

## 3. Integridade matemática e de revisão

Permanecem exatos:

- interface N7:
  `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45`;
- parecer `formal_design`, `PASS 0/0/0`:
  `eca9697269589688a0bb568be96deeaa446326e2a40b8b9c3c0c919159857aad`;
- parecer `game_theory`, `PASS 0/0/0`:
  `42604ed0770923c1fa94e3a4314376a1fd3bb05f3fb024750b77fa7e9da4ae0d`;
- DAG integrado:
  `36155405a635bf6842c09dcde127907ec1f6fe61bb86ec06d932d7e472abf9ab`.

O manifesto final dos pareceres N7 passou integralmente. Todos os objetos
matemáticos/revisados do manifesto candidato N7 passaram; os dois pins
administrativos pré-promoção de DAG e Gate 0 foram corretamente excluídos da
reaplicação, conforme documentado no próprio registro de integração N7.

No manifesto final de integração N6, as dezesseis entradas matemáticas,
documentais e de revisão imutáveis continuam `OK`. Apenas os dois pins
administrativos de DAG e Gate 0 não coincidem com o snapshot N6, porque foram
legitimamente sucedidos pela promoção de N7 e pelo aval pós-freeze. O manifesto
histórico N6 não foi reescrito.

## 4. Bateria dirigida

Retornaram `PASS`:

- verificadores N1 e N2;
- verificador conjunto corrente N3/N4;
- verificador N6;
- verificador N7: 27 casos públicos, 16 equivalências de endpoint, 18 casos de
  renda e 5 negativos representativos;
- Gate 0, incluindo o registro exato de fechamento autoral;
- checker do DAG com ordem de execução: `VALID`, `Ready: none`;
- teste sintético das funções de renda: 10 blocos e 33 expectativas;
- verificador dirigido de fronteiras numéricas;
- identidade byte a byte dos artefatos N7 contra o commit `8ef5fa9`;
- `git -c core.whitespace=-trailing-space diff --cached --check`.

O check padrão de whitespace aponta somente quebras Markdown deliberadas de
dois espaços nos artefatos N7 já revisados e hashados. Elas foram preservadas,
sem normalização.

## 5. Escopo preservado

- nenhum artefato congelado N1--N7 foi editado;
- nenhum manuscrito foi editado ou compilado;
- não houve push nem tag;
- Goal 5 não foi aberto.

A próxima ação substantiva possível é a migração dos resultados congelados para
`formal_model_v6.Rmd`, mas ela exige autorização autoral explícita separada e
worktree própria.
