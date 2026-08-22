## Parecer formal — primeira fronteira beta<1

- `reviewer_role`: `formal_design`
- `reviewer_id`: `review-n1-n2-beta-formal-2026-08-18-r1`
- Contrato: `sha256:2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- DAG: `sha256:740d0945ac2ee845331a75b7a0e5af1d49d2cc13a0c00dce98a386d8ff69fd21`

## Reconstrução fria de R2

Em R2 não existe sucessor. Aprovação ou falha encerra o jogo na data corrente; portanto `beta in (0,1)` integra apenas o domínio primitivo e não entra em incentivo, payoff, cutoff ou outcome.

Para qualquer weak nonproposer:

- se `x_j>0`, `sim` domina fracamente `não`;
- se `x_j=0`, as ações são idênticas no information set inteiro e `T^Y` seleciona `sim`.

Logo, todos os weak nonproposers votam `sim` depois de toda proposta factível.

Sob maioria, o proponente mais os `m-1` weak nonproposers fornecem `m=N-1>=q` votos. `H` é não pivotal e compara `y` com `y+o_theta`, escolhendo estritamente `não`. Toda proposta passa sem `H`; o proponente maximiza `r_i`, obtendo unicamente `(y,x,r_i)=(0,0,1)`.

Sob unanimidade, `H` é pivotal e aceita exatamente quando `y>=o_theta`. Os únicos candidatos ótimos são:

- `y=o_0`, valor `S(nu)=(1-nu)(1-o_0)`;
- `y=o_1`, valor `P=1-o_1`.

O cutoff é `nu_star=(o_1-o_0)/(1-o_0)`, estritamente entre zero e um. A oferta baixa prevalece para `nu<=nu_star`; na igualdade, o tie-break do proponente escolhe `y=o_0` porque reduz estritamente o payoff esperado de `H`. Pooling prevalece para `nu>nu_star`.

## N1 — R2 maioria

- Hash: `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`
- Veredicto: **PASS**
- Findings: **critical 0 / major 0 / minor 0**

O candidato coincide integralmente com a reconstrução:

- proposta única `y=0`, todos os `x_j=0`, `r_i=1`;
- uso integral da pie, provado a partir da desigualdade factível;
- todos os weak nonproposers votam `sim`;
- ambos os tipos de `H` votam estritamente `não`;
- passagem sem `H` com probabilidade um;
- payoff do proponente reconhecido `1`;
- valor fraco pré-reconhecimento `1/m`;
- payoff de `H` por tipo `(o_0,o_1)`;
- nenhuma falha ou delay.

P5 é demonstrado sem impor estratégia Markov: terminalidade e reconhecimento iid com reposição tornam a regra e `nu` suficientes. Nos endpoints `nu=0` e `nu=1`, a mesma estratégia e outcome permanecem válidos; tipos de probabilidade zero recebem estratégias sequencialmente racionais.

A estratégia, outcome e payoff são únicos. A multiplicidade de PBE limita-se às funções de crença arbitrárias em propostas de probabilidade zero. Essa classe está explicitamente preservada e é payoff-irrelevante. O registro mantém conjuntamente estratégia, crenças, payoff e outcome, sem recombinação marginal.

O candidato contém `beta` somente na delimitação do domínio e no claim de invariância. Não há `beta` em estratégia, crença operacional, payoff ou outcome de R2.

## N2 — R2 unanimidade

- Hash: `sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`
- Veredicto: **PASS**
- Findings: **critical 0 / major 0 / minor 0**

As duas células são corretas, não vazias, mutuamente exclusivas e exaustivas:

1. `0<=nu<=nu_star`: proposta `(o_0,0,1-o_0)`, passagem apenas para o tipo baixo, payoff do proponente `(1-nu)(1-o_0)`, outcomes `(1-nu,0,nu,0)`.
2. `nu_star<nu<=1`: proposta `(o_1,0,1-o_1)`, pooling com `H`, payoff do proponente `1-o_1`, outcomes `(1,0,0,0)`.

Os endpoints foram corretamente tratados:

- `nu=0`: a oferta baixa domina estritamente; o tipo alto de probabilidade zero ainda tem estratégia `sim` somente se `y>=o_1`.
- `nu=nu_star`: ambas as ofertas empatam para o proponente antes do tie-break; `y=o_0` é corretamente selecionada.
- `nu=1`: pooling é único porque `1-o_1>0`; propostas rejeitadas, com folga ou misturas do antigo canto não maximizam.
- O antigo canto `o_1=1,nu=1` está fora do domínio.

Não há passagem sem `H`, continuação ou delay. P0, P5 e P6 estão demonstrados. A multiplicidade limita-se novamente às crenças off-path irrestritas e payoff-irrelevantes. Cada célula mantém seu objeto completo em um único registro atômico.

`beta` aparece somente como restrição de domínio e descrição de invariância; nenhum payoff, probabilidade, cutoff ou incentivo terminal contém desconto.

## Verificadores e mutações

- N1 verifier: exit `0`, todos os testes `PASS`.
- N2 verifier: exit `0`, todos os testes `PASS`.
- N2: 105 campos da interface e 135 campos do ledger foram mutados individualmente e rejeitados.
- Gate 0: exit `0`, `PASS`.
- Checker: exit `0`, `VALID`; prontidão topológica `N1,N2`.

Além das fixtures incorporadas, neutralizei em memória a primeira igualdade com o objeto canônico e confirmei que as validações substantivas posteriores rejeitam, nos dois nós:

- domínio antigo `beta in (0,1]`;
- desconto inserido em payoff de R2;
- restrição indevida das crenças off-path;
- falsa unicidade de PBE;
- proposta com folga;
- outcome incorreto.

Em N2 também foi rejeitada a transferência da igualdade `nu=nu_star` para a célula errada.

O DAG continua exatamente `pending/null`, sem `pass`, `frozen`, hashes, reviews ou lifecycle de nó. O escopo protegido está intacto e `git diff --check` passou.

Não editei nem criei arquivos.
