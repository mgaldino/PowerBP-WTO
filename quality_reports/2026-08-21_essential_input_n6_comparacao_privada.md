# Relatório legível de N6 — comparação privada

**Data:** 2026-08-21
**Status do candidato:** `pending/unfrozen`
**Escopo:** `m>=3`; somente jogos com informação privada e ballots puros
**Orientação dos contrastes:** `unanimidade - maioria`

## Resultado em linguagem direta

A comparação possui três regiões, e somente duas admitem comparação efetiva:

| Prior de entrada | Maioria | Unanimidade | Estatuto de N6 |
|---|---|---|---|
| `nu=0` | PBE puro existe | PBE puro existe | comparável |
| `0<nu<=nu_*` | PBE puro existe | PBE puro não existe | `none`, sem payoff |
| `nu_*<nu<=1` | PBE puro existe | PBE puro existe | comparável |

Aqui `nu_*=(o_1-o_0)/(1-o_0)`. A igualdade pertence à região `none`; a
região alta começa estritamente acima dela.

## O que ocorre em `nu=0`

Sob unanimidade, há acordo imediato com o tipo baixo e o vetor de payoff de H
é `(beta*o_0,beta*o_1)`.

Sob maioria:

- se `o_0<=1/m`, a regra seleciona screening. Payoffs de H e outcomes
  coincidem com unanimidade, de modo que o contraste é zero;
- se `o_0>1/m`, a regra seleciona exclusão. Unanimidade então reduz o payoff
  de ambos os tipos de H em `(1-beta)*o_theta` e substitui passagem sem H por
  passagem com H.

## Por que a região intermediária é `none`

Em `0<nu<=nu_*`, a interface frozen de N4 contém uma proposta factível que
força todos os weak states a votar `sim` em seu cálculo as-if-pivotal. Nenhum
dos quatro perfis puros de voto de H é sequencialmente racional: cada perfil
gera uma atualização/continuação que induz desvio de algum tipo de H ou, na
igualdade, aciona `T^Y` em favor de `sim`.

Isso fecha tecnicamente o ciclo entre o voto informativo de H e a continuação
usada pelos weak states. Como o ballot fora do caminho não pode ser completado
com estratégias puras, não há PBE puro sob unanimidade. N6 preserva o PBE de
maioria na coleção própria da regra, mas não atribui payoff à unanimidade e não
cria registro de comparação.

Nenhuma estratégia mista de ballot é derivada, simulada ou deixada como
agenda. As distribuições `F_i` entre propostas empatadas são apenas a
correspondência N3 frozen, preservada sem nova análise.

## O que ocorre em `nu_*<nu<=1`

Sob unanimidade, há pooling imediato: ambos os tipos de H recebem
`beta*o_1`, o acordo passa com H e não há delay.

O resultado relativo depende da classe selecionada sob maioria:

| Maioria | Payoff de H: unanimidade menos maioria | Outcome: unanimidade menos maioria |
|---|---|---|
| exclusão | `(beta*o_1-o_0, -(1-beta)*o_1)` | mais passagem com H, menos passagem sem H |
| screening | `(beta*(o_1-o_0), 0)` | mais passagem imediata com H, menos delay |
| pooling | `(0,0)` | nenhum contraste |

Assim:

- o tipo alto nunca ganha com unanimidade nessa região: empata sob screening
  ou pooling e perde estritamente quando a maioria o exclui;
- o tipo baixo ganha sob screening, empata sob pooling e pode ganhar ou perder
  sob exclusão, conforme o sinal de `beta*o_1-o_0`;
- delay aparece apenas quando a maioria seleciona screening; unanimidade o
  elimina nas células comparáveis;
- falha tem probabilidade zero em ambos os jogos comparáveis.

Não existe uma ordenação escalar uniforme de payoff de H em todo o domínio.
Essa ausência de ranking é um resultado da comparação, não uma média ou uma
seleção adicional.

## Partição econômica dentro das três células do schema

O schema contém três células de cobertura e dois registros de comparação,
porque N3 exporta um único registro familiar e ele não pode ser duplicado. A
partição simbólica interna, usada para ler os contrastes, tem seis classes
comparáveis e uma classe `none`:

| Classe | Condição adicional | Resultado de maioria |
|---|---|---|
| `C0-S` | `nu=0`, `o_0<=1/m` | screening |
| `C0-E` | `nu=0`, `o_0>1/m` | exclusão |
| `C-NONE` | `0<nu<=nu_*` | comparação inexistente |
| `CH-S` | `nu>nu_*` e região N3 de screening | screening |
| `CH-P` | `nu>nu_*` e região N3 de pooling | pooling |
| `CH-E` | `nu>nu_*` e região N3 de exclusão | exclusão |
| `CH-EP` | `nu>nu_*`, empate residual completo `E/P` | distribuições preservadas entre exclusão e pooling |

As fronteiras `nu_SP` e `nu_SE` pertencem a screening. `nu=nu_*` pertence a
`C-NONE`. No empate `CH-EP`, se `lambda` é a massa agregada de exclusão:

```text
payoff de H sob maioria = lambda*(o_0,o_1)+(1-lambda)*(beta*o_1,beta*o_1)
outcome de maioria      = (1-lambda,lambda,0,0)
contraste U-M de H      = lambda*(beta*o_1-o_0, -(1-beta)*o_1)
contraste U-M de outcome= (lambda,-lambda,0,0)
```

O mesmo `lambda` governa payoff e outcome.

## Multiplicidade e classes de simetria

N3 preserva a identidade do proponente, a coalizão comprada e, em um empate
residual, a distribuição entre exclusão e pooling. A interface N6 conserva a
família atômica `F=(F_i)_i` e usa a mesma distribuição para payoffs e outcomes.

Para exposição, coalizões que diferem somente por permutação dos nomes dos
weak states podem ser agrupadas:

| Classe | Coalizões rotuladas por proponente reconhecido | Invariante no quociente |
|---|---:|---|
| exclusão | `choose(m-1,q-1)` | payoff de H e outcome |
| screening | `choose(m-1,q-2)` | payoff de H e outcome |
| pooling | `choose(m-1,q-2)` | payoff de H e outcome |

O agrupamento é válido porque uma permutação preserva quota, orçamento,
reconhecimento uniforme, payoff de H e outcome. Ele não apaga IDs nem
substitui os registros atômicos. Em particular, uma mudança na massa entre
exclusão e pooling não é mera permutação e permanece visível.

## Conjuntos e envelopes

Quando N3 admite mais de uma proposta lexicograficamente ótima, N6 reporta o
conjunto conjunto exato de `(payoff de H, outcome)` usando a mesma massa de
probabilidade nos dois componentes. Os envelopes são apenas mínimos e máximos
coordenada a coordenada desse conjunto.

O envelope não convexifica, não preenche lacunas e não autoriza combinar o
payoff de uma seleção com o outcome de outra. Valores internos só pertencem ao
conjunto quando a própria interface N3 admite a correspondente distribuição
sobre propostas ótimas.

## O que este Goal não fez

Não houve benchmark público, cálculo de `RI_M`, `RI_U` ou `DeltaRI`, média
sobre parâmetros, análise de `beta=1`, extensão, manuscrito, push, merge ou
tag. N7 permanece `pending/null` e exige autorização autoral própria.
