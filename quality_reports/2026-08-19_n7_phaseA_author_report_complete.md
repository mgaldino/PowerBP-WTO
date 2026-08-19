# Goal 4, N7 — relatório ao autor após a Fase A

**Data:** 2026-08-19  
**Status correto:** **Fase A concluída; N7 continua `pending` e `unfrozen`; aguardando autorização autoral sobre comparações relevantes.**

## 1. O que foi concluído

A Fase A resolveu e classificou os jogos em que a situação de `H` é pública desde `t=0`, separadamente para maioria e unanimidade, nas duas rodadas e para cada situação pública de `H`.

A derivação:

- preserva o domínio formal `m>=2`, com `m>=3` como escopo substantivo principal;
- resolve R2 antes de R1;
- aplica `beta` exatamente uma vez ao importar a continuação de R2 em R1;
- mantém votos simultâneos e selados;
- usa PBE, stage-undominated voting para os fracos e `T^Y` na igualdade;
- mantém crenças degeneradas porque a situação de `H` já é pública;
- não usa nenhum equilíbrio privado de N6 como premissa;
- não calcula rendas nem seleciona comparações.

O candidato público intermediário contém 24 registros tipados e permanece exatamente em:

`sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`

Ele não é a interface completa de N7 e não foi gravado no DAG como `pass/frozen`.

## 2. Resultado dos benchmarks públicos

Escreva `o=o_theta`, `m=N-1` e `q=floor((m+1)/2)+1`.

| Regra e rodada | Resultado público | Pagamentos mínimos e payoff do proponente | Multiplicidade relevante |
|---|---|---|---|
| Maioria, R2 | Acordo imediato sem `H` | `y=0`; demais fracos recebem zero; proponente recebe `1`; `H` recebe `o` fora da coalizão | Nenhuma |
| Unanimidade, R2 | Acordo imediato com `H` | `y=o`; demais fracos recebem zero; proponente recebe `1-o`; `H` recebe `o` | Nenhuma |
| Maioria, R1, `o<1/m` | Inclusão de `H` | `y=beta*o`; compram-se `q-2` fracos a `beta/m`; proponente recebe `1-beta*o-beta*(q-2)/m` | Escolha da identidade da coalizão quando há mais de uma |
| Maioria, R1, `o=1/m` | Inclusão de `H` pelo tie-break autorizado | Mesmos pagamentos do ramo de inclusão; inclusão e exclusão empatam para o proponente, mas inclusão minimiza o payoff de `H` | Não há mistura entre os dois ramos; pode haver escolha de coalizão dentro do ramo |
| Maioria, R1, `o>1/m` | Exclusão de `H` | `y=0`; compram-se `q-1` fracos a `beta/m`; proponente recebe `1-beta*(q-1)/m`; `H` recebe `o` | Escolha da identidade da coalizão quando há mais de uma |
| Unanimidade, R1 | Acordo imediato com `H` | `y=beta*o`; cada fraco não proponente recebe `beta*(1-o)/m`; proponente recebe `1-beta*(m-1+o)/m` | Nenhuma |

Em R1, atraso ou falha deliberada não sobrevivem:

- sob maioria, a exclusão de `H` supera o atraso por `1-beta*q/m>0`;
- sob unanimidade, o acordo imediato supera o atraso por `1-beta>0`.

Portanto, não existe estratégia mista pública genuína entre acordo imediato e atraso no domínio autorizado `beta in (0,1)`. A única mistura pública remanescente é entre propostas payoff-equivalentes dentro do ramo majoritário já selecionado.

## 3. Identidade, simetria e escopo de `m`

Sob maioria, a composição da coalizão pode gerar payoffs diferentes entre identidades fracas, embora não altere o resultado institucional, o payoff do proponente reconhecido nem o payoff de `H`.

- Com `m=2`, as coalizões ótimas de inclusão e exclusão são únicas.
- Com `m=3`, há multiplicidade de inclusão, mas a coalizão de exclusão é única.
- Com `m>=4`, inclusão e exclusão podem ter múltiplas composições.
- Uma escolha determinística de identidades é um equilíbrio puro assimétrico.
- Uma loteria sobre coalizões é mistura somente entre propostas payoff-equivalentes dentro do mesmo ramo.

Sob unanimidade, o benchmark público não sustenta convenções de identidades “cooperativas” e “difíceis”: o acordo imediato domina estritamente o atraso.

## 4. Revisão independente e bateria final

Os dois revisores read-only avaliaram o mesmo hash, sem editar arquivos e sem consultar o parecer da outra função durante a revisão.

| Papel | Revisor | Veredicto | Findings |
|---|---|---|---|
| `formal_design` | `review-n7-phaseA-formal-2026-08-19-r2` | `PASS` | `0/0/0` |
| `game_theory` | `review-n7-phaseA-game-2026-08-19-r2` | `PASS` | `0/0/0` |

A bateria pós-revisão confirmou:

- Gate0 verifier: `PASS`;
- verifier dos benchmarks públicos: `PASS`;
- checker canônico com ordem de execução e candidato N7: `VALID`;
- DAG inalterado em `sha256:aafb39d47b0ae6a06f11b5a4894d82dc6c378e2f67e5d2b49176098066189507`;
- N1, N2, N3, N4 e N6 continuam `pass/frozen`, com os hashes e dois pareceres anteriores intactos;
- N7 continua `pending`, sem `frozen`, `artifact_hash` ou reviews no DAG;
- a tag protegida continua apontando, após peeling, para `f53e6769624ce3dd6e64e21ad40d08230b0950a7`;
- candidato, derivação, ledger, builder, verifier da Fase A, DAG e manuscritos permaneceram byte a byte inalterados durante o reparo normativo e a rodada 2.

## 5. Decisões reservadas ao gate autoral

Nenhuma comparação será iniciada sem uma nova decisão que responda explicitamente às perguntas abaixo.

1. **Domínio:** a comparação substantiva principal deve usar somente `m>=3`, mantendo `m=2` como cobertura formal secundária, ou deve apresentar também `m=2` no corpo principal?
2. **Puro versus misto:** a comparação deve priorizar estratégias puras e tratar loterias entre propostas payoff-equivalentes como robustez, ou deve comparar desde o início toda a correspondência pura e mista? Estratégias mistas entre acordo imediato e atraso permanecem provisoriamente fora da prioridade substantiva, sem apagar classes válidas dos artefatos.
3. **Simetria versus identidade:** a comparação deve preservar todos os equilíbrios assimétricos por identidade, selecionar apenas avaliações simétricas, ou apresentar ambos separadamente? Impor simetria seria uma seleção adicional.
4. **Objeto comparado:** o objeto substantivo deve ser classes de outcome e payoff, ou assessments completos, incluindo estratégias e crenças fora do caminho?
5. **Forma da conclusão:** a Fase B deve buscar envelopes e ordenações robustas à seleção, ou o autor deseja escolher uma seleção explícita antes de comparar?

## 6. Fronteira mantida

Até nova autorização autoral explícita:

- não cruzar registros públicos com N6;
- não calcular `RI_M`, `RI_U` ou `DeltaRI`;
- não selecionar comparações;
- não abrir a Fase B;
- não congelar N7;
- não iniciar Goal 5;
- não tratar `beta=1`;
- não migrar nem compilar manuscritos.

**Ponto de parada:** Fase A concluída; N7 continua `pending`; aguardando autorização autoral sobre quais comparações são substantivamente relevantes.
