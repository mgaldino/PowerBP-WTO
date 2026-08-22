# Parecer adversarial — Round 3

`reviewer_role=game_theory`  
`reviewer_id=review-n1-n2-o1-game-2026-08-18-r3`

Auditoria estritamente read-only, usando como norma apenas o contrato atual.
Nenhum arquivo foi alterado pelo revisor.

## Evidência operacional

- Branch: `codex/essential-input-o1-interior`
- Contrato: `7b52f332aff353bf54a36992b0944ab3ff016a1c90e56a05e4853d26d92dab82`
- Gate 0: `PASS`; todos os nós permanecem `pending` e não congelados.

Hashes confirmados:

| Nó | Artefato revisado | Verifier |
|---|---|---|
| N1 | `af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd` | `f9e5bd11b739f2ea49891d9309b059835f0609a9989357f1e64dc482cb3776f9` |
| N2 | `32a2989f806af20b2557fa8f495dfbe661ac951be59ee68e583fd50735e486ed` | `2eb997943ad68075ed021c246b80a33da5cc9a01e669480e534d2c68550c2cfe` |

Hashes auxiliares:

- N1 derivação: `18d94e73c7b3f20285847c7c422dbbb410e6f0a3dde887e7f557a470fb4684cf`
- N1 ledger: `b438312588ed8af113b6a4313bf78df625aa954abfcbf3e4b4ed795630d2b990`
- N2 derivação: `4e5e839c3d6a8186c334dde3a6484c8a29d84bfb85e72cf3b4a01bce7dc8c6fa`
- N2 ledger: `e13702a1e3f94fb2a7ea682b15cdf91befc6558497ce363b951959f71ee02049`

## N1 — R2 maioria

### Reconstrução independente

Para qualquer weak nonproposer `j`:

- Se `x_j>0`, votar sim é pelo menos tão bom em todo perfil dos demais votos e
  estritamente melhor no perfil em que `j` é pivotal. Portanto, não é fracamente
  dominado.
- Se `x_j=0`, sim e não geram o mesmo payoff em todas as contingências.
  Stage-undominance não elimina ação alguma e `T^Y` seleciona sim por
  indiferença genuína.

Com o proponente contado como sim e os `N-2` weak nonproposers votando sim, há
`N-1=m>=q` votos fracos para todo `N>=3`. Assim, `H` é não pivotal em toda
proposta factível sob a estratégia admissível dos weak states.

Para cada tipo de `H`:

- sim produz `y`;
- não, com aprovação sem `H`, produz `y+o_theta`.

Como `o_theta>0`, não é estritamente ótimo. Isso decorre de racionalidade
sequencial de `H`, não da restrição de stage-undominance, que é weak-only.
`T^Y` não é acionado para `H`.

A proposta passa sem `H` independentemente de `theta`. O payoff do proponente é
`r_i`; sob `y+sum(x_j)+r_i<=1`, o máximo único é:

`y=0`, todos os `x_j=0`, `r_i=1`.

Logo:

- payoff do proponente reconhecido: `1`;
- valor fraco pré-reconhecimento: `1/m`;
- payoff de `H`: `(o_0,o_1)`;
- aprovação sem `H`: probabilidade `1`;
- falha e delay: probabilidade `0`.

Não há `beta` dentro de R2. A proposta on-path é independente do tipo e preserva
`nu` por Bayes. Crenças após qualquer proposta de probabilidade zero são
arbitrárias, inclusive em pontos de massa zero de suportes atomless, mas não
alteram estratégias, outcomes ou payoffs.

A correspondência é completa: há uma única estratégia, outcome e vetor de
payoffs; a única multiplicidade é a de crenças off-path payoff-irrelevantes. A
restrição `o_1<1` não altera essa correspondência.

### Verifier e mutações

O verifier oficial passou, inclusive P0, P5, P6, domínio estrito, ledger e
lifecycle. A igualdade recursiva com o objeto canônico cobre todos os campos, e
os testes internos cobrem 3 campos de interface, 5 de célula, 16 de registro e
7 colunas do ledger, além de mutações aninhadas dirigidas.

Foram rejeitadas:

- contradições anexadas a unicidade, seleção e `assumptions_used`;
- proposta coordenada com slack e payoffs ajustados;
- proposer mixing acompanhado de nova classificação e seleção;
- restrição coordenada do domínio e da crença;
- claim C10 falso no ledger;
- troca de `"1"` por número `1` ou por `"1.0"`;
- lifecycle alterado para `passed`.

Em um harness somente em memória, neutralizei apenas a primeira barreira
`identical` para verificar que o script não depende exclusivamente do hash.
Ainda assim, foram rejeitadas separadamente mutações de P0, Bayes/P5,
ballot/P6, fórmula de payoff e formato com proposal mixing.

### Findings N1

Nenhum finding.

- critical: `0`
- major: `0`
- minor: `0`

**Veredicto N1:** `PASS`  
**Hash:** `af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd`

## N2 — R2 unanimidade

### Reconstrução independente

Os weak nonproposers obedecem à mesma comparação completa de contingências:

- se `x_j>0`, sim domina fracamente não, com ganho estrito no perfil pivotal;
- se `x_j=0`, as ações são idênticas em todo o information set e `T^Y`
  seleciona sim.

Com todos os weak states votando sim, `H` é pivotal. O tipo `theta` compara:

- sim: `y`;
- não: falha terminal e payoff `o_theta`.

Portanto, `H` vota sim se e somente se `y>=o_theta`; a igualdade é indiferença
genuína e `T^Y` seleciona sim. Stage-undominance não é aplicado a `H`.

Como `o_1<1` e `y_bar>=o_1`, a proposta pooling `y=o_1` é factível e dá payoff
positivo `1-o_1`. Todo maximizador passa com probabilidade positiva. Qualquer
slack poderia ser atribuído ao proponente sem mudar os votos e elevar seu
payoff; logo P0 implica uso integral da pie e `x_j=0`.

As únicas candidatas ótimas são:

- low-type-only: `y=o_0`, payoff `S(nu)=(1-nu)(1-o_0)`;
- pooling: `y=o_1`, payoff `P=1-o_1`.

O cutoff é `nu_star=(o_1-o_0)/(1-o_0)`, com `0<nu_star<1`.
Como `S(nu)-P=(1-o_0)(nu_star-nu)`:

- `0<=nu<nu_star`: low-type-only é estritamente ótimo;
- `nu>nu_star`: pooling é estritamente ótimo;
- `nu=nu_star`: as duas propostas empatam para o weak proposer.

Na igualdade, o tie-break do proponente minimiza o payoff esperado de `H`.
`y=o_0` dá `(1-nu_star)o_0+nu_star o_1`, estritamente menor que `o_1`; logo
seleciona low-type-only. Não sobrevive mixed proposal strategy.

Resultados:

- `0<=nu<=nu_star`: proposta `y=o_0`, aprovação com `H` de probabilidade
  `1-nu`, falha `nu`, payoff do proponente `(1-nu)(1-o_0)` e valor fraco
  pré-reconhecimento dividido por `m`;
- `nu_star<nu<=1`: proposta `y=o_1`, aprovação com `H` de probabilidade `1`,
  payoff do proponente `1-o_1` e valor fraco pré-reconhecimento `(1-o_1)/m`.

Não há aprovação sem `H`, delay ou desconto interno em R2. On-path, a proposta
do weak proposer não informa `theta`; Bayes preserva `nu`. Crenças após propostas
de probabilidade zero permanecem arbitrárias e payoff-irrelevantes.

A fronteira inclui `nu=0`, `nu=nu_star` e `nu=1`. Em particular, `nu=1`
continua admissível. Com `o_1<1`, pooling oferece payoff estritamente positivo
`1-o_1`, eliminando toda a multiplicidade substantiva do antigo ponto
`o_1=1,nu=1`: propostas que falham dão zero, e slack ou pagamentos fracos
reduzem o payoff. A proposta pooling de orçamento integral é única. Apenas a
multiplicidade de crenças off-path permanece.

### Verifier e mutações

O verifier oficial passou. Sua cobertura recursiva rejeitou alterações em 101
campos da interface e 125 campos do ledger. Derivação, interface, ledger,
fórmulas numéricas e lifecycle são verificados separadamente.

Foram rejeitadas:

- as antigas inserções em `assumptions_used`, `checks_performed` e
  `branch_classification`;
- slack com fórmulas e assumptions coordenados;
- proposer mixing com unicidade, seleção e ramo reescritos;
- remoção coordenada de `nu=1`;
- inversão coordenada da atribuição de `nu=nu_star`;
- claim falso sobre o antigo corner;
- fórmulas algebricamente equivalentes com texto diferente;
- reformulação semântica do domínio e reordenação de campos;
- lifecycle alterado para `passed` ou `frozen`.

Neutralizando somente a primeira barreira canônica em memória, o restante do
verifier ainda rejeitou isoladamente violações de P0, Bayes/P5, ballot
fraco/P6, cutoff de `H`, fórmula do payoff low-type-only e cobertura do cutoff.
Portanto, o resultado não é mero hash pinning.

### Findings N2

Nenhum finding.

- critical: `0`
- major: `0`
- minor: `0`

**Veredicto N2:** `PASS`  
**Hash:** `32a2989f806af20b2557fa8f495dfbe661ac951be59ee68e583fd50735e486ed`

## Conclusão

Os dois candidatos satisfazem as primitivas, PBE, a restrição weak-only de
stage-undominated voting, `T^Y`, P0/P5/P6, exaustividade da correspondência,
preservação das crenças off-path, contabilidade externa de `o_theta`, ausência
de desconto em R2 e lifecycle `pending`. Os verificadores rejeitam tanto os
bypasses dos rounds anteriores quanto mutações coordenadas e tentativas de
contornar igualdade exata.

**Resultado final da fronteira:**

- N1: `PASS`, contagem `0/0/0`.
- N2: `PASS`, contagem `0/0/0`.
