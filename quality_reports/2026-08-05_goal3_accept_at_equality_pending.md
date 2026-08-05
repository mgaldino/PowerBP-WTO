# Pendência pós-Goal 3 — aceitação na igualdade e timing do desconto

**Data da decisão:** 2026-08-05

**Status:** `PENDING REDERIVATION`; nenhuma conclusão do Goal 3 está autorizada
para migração ao v6.

## Decisão substantiva do usuário

O modelo adota a convenção usual de barganha segundo a qual o agente aceita
quando a oferta lhe entrega exatamente sua opção externa ou seu valor de
continuação. A convenção será denominada `T^Y`:

```text
oferta > valor relevante  => aceita;
oferta = valor relevante  => aceita por convenção;
oferta < valor relevante  => rejeita.
```

Essa convenção é um primitivo de seleção do modelo. Seu propósito é manter
fechados os conjuntos de ofertas aprováveis, garantir máximos e mínimos quando
cabível e evitar que a exposição dependa de sequências `epsilon`, ínfimos ou
supremos criados apenas pela indiferença do receptor.

O Gate 0 futuro deve declarar separadamente sua aplicação a `H` e aos weak
voters que recebem exatamente sua continuação. Não se deve voltar a tratar a
igualdade como uma correspondência sem seleção no baseline pretendido.

## Timing correto de `beta`

R2 é terminal e deve ser resolvido em unidades correntes, sem desconto interno:

```text
H aceita em R2:  y
H rejeita em R2: o_theta
```

Portanto, em R2 o threshold é `y=o_theta`, com aceitação na igualdade por
`T^Y`. O fator `beta` entra somente quando o valor terminal é transportado para
uma decisão em R1:

```text
valor de continuação visto de R1 = beta * C_2.
```

Escrever payoffs de R2 multiplicados por `beta` como mera normalização em
unidades de R1 não altera uma comparação local porque o fator é comum, mas
obscurece a indução retroativa. A próxima derivação deve solucionar R2 sem
`beta` e introduzir `beta C_2` apenas nas ICs de R1.

## O que permanece fixo

- ballots simultâneos e selados dentro de cada rodada;
- publicação do vetor completo somente depois do fechamento;
- nenhuma ordem de votação ou posição de `H`;
- `pi_H=0`, `b_theta=0` e opt-out imediato de `H` depois de `H`-no em R1;
- outside option de `H` externa à pie institucional;
- baseline coalition-pure: coalizão vencedora mínima, zero para weak outsiders
  e apoiadores necessários protegidos pelo valor de continuação;
- gifts a outsiders permanecem desvios factíveis no teste de optimalidade, mas
  não são outcomes selecionados do baseline.

## Questão formal ainda pendente

A rederivação deverá especificar como `T^Y` se relaciona com a disciplina
PBE-UD no ballot simultâneo. Em particular, é preciso decidir e provar se:

1. `T^Y` seleciona sim apenas quando ambas as ações continuam admissíveis; ou
2. a convenção de barganha substitui a eliminação PBE-UD na igualdade, inclusive
   quando vetores contrafactuais de votos fariam o sim parecer fracamente
   dominado.

Essa escolha afeta thresholds exatos em R1, existência, pooling, low-only,
mistura, condições de capacidade e a necessidade de objetos de
attainment/supremum. Ela não será resolvida por documentação nem por uma
correção local de fórmulas; exige nova indução retroativa desde Gate 0.

## Quarentena analítica

Até essa rederivação:

- `model_redesign/undominated_voting_rederivation.Rmd`, seu HTML e seu PDF são
  registros históricos da especificação sem `T^Y` global, não a arquitetura
  corrente do modelo;
- os PASS e hashes dos três pareceres finais permanecem válidos somente para o
  commit que efetivamente revisaram;
- os verificadores `verify_undominated_voting_*.R` validam apenas essa
  especificação histórica;
- a matriz de impacto e o handoff do Goal 4 estão bloqueados;
- nenhum teorema, condição de existência, fronteira ou ranking do Goal 3 deve
  ser migrado ao `formal_model_v6.Rmd`;
- v5 e v6 permanecem intocados.

## Próximo passo, quando autorizado

Reabrir a derivação autônoma a partir de um novo Gate 0 que incorpore `T^Y`,
resolva R2 em unidades correntes, desconte a continuação apenas em R1 e
rederive todos os resultados. Implementação e revisão independente devem
permanecer separadas. Esta nota apenas registra a pendência; a sessão se encerra
sem iniciar essa rederivação.
