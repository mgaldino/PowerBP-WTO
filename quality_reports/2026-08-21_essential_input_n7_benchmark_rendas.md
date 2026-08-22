# N7 — benchmark público e rendas informacionais

**Data:** 2026-08-21  
**Estado deste relatório:** candidato `pending/unfrozen`, antes dos pareceres  
**Escopo:** Goal 4 exclusivamente N7, `m>=3`, `beta in (0,1)` e ballots puros

## Resultado em linguagem corrente

Quando o tipo de `H` é conhecido, a informação deixa de ser uma fonte de poder.
Sob unanimidade, os Estados fracos pagam exatamente a continuação descontada de
`H` em R1 e exatamente sua opção externa em R2. Sob maioria, eles incluem `H`
somente quando isso custa no máximo comprar mais um voto fraco; caso contrário,
formam o acordo sem `H`.

Os quatro jogos públicos têm equilíbrio puro. Seus resultados coincidem, tipo a
tipo e regra a regra, com os endpoints `nu=0` e `nu=1` das interfaces privadas
congeladas. A comparação não encontrou erro numa primitiva ou fonte
compartilhada.

## Os quatro jogos públicos

| Regra e rodada | Resultado | Payoff de `H` |
|---|---|---:|
| maioria, R2 | os fracos aprovam sem `H`; o proponente fica com toda a pie | `o_theta` |
| unanimidade, R2 | o proponente paga `o_theta` a `H`; aprovação com `H` | `o_theta` |
| maioria, R1 | inclui `H` se `o_theta<=1/m`; exclui se `o_theta>1/m` | `beta*o_theta` se inclui; `o_theta` se exclui |
| unanimidade, R1 | paga `beta*o_theta` a `H` e `beta*(1-o_theta)/m` a cada fraco respondente | `beta*o_theta` |

Na fronteira `o_theta=1/m`, inclusão e exclusão empatam para o proponente. O
desempate já autorizado escolhe inclusão porque ela dá `beta*o_theta`, e não
`o_theta`, a `H`.

Sob maioria há multiplicidade de coalizões rotuladas: diferentes conjuntos de
Estados fracos podem fornecer os votos necessários. Essa multiplicidade pode
mudar o payoff individual de um Estado fraco antes do sorteio de reconhecimento,
mas não muda o payoff de `H`, o payoff do proponente reconhecido, a média entre
os fracos nem o outcome. A interface preserva a família completa de coalizões.

## Payoffs públicos de `H`

Defina:

```text
p_M(o)=beta*o, se o<=1/m;
p_M(o)=o,      se o>1/m.
```

Então os conjuntos públicos são singletons:

```text
V_M_pub={(p_M(o_0),p_M(o_1))};
V_U_pub={(beta*o_0,beta*o_1)}.
```

## Renda sob unanimidade

Escreva `nu_star=(o_1-o_0)/(1-o_0)` e
`d=beta*(o_1-o_0)>0`.

```text
nu=0:             RI_U={(0,0)};
0<nu<=nu_star:    RI_U=empty;
nu_star<nu<=1:    RI_U={(d,0)}.
```

Assim, na região alta do prior, a informação privada beneficia apenas o tipo
baixo sob unanimidade: ele recebe a oferta construída para acomodar o tipo alto.
O tipo alto continua exatamente em sua reserva pública.

Na região `0<nu<=nu_star`, a interface privada de unanimidade não tem PBE puro.
Por isso a renda de unanimidade e a diferença entre regras são vazias. Isso não
apaga a renda de maioria e não autoriza afirmar um ranking robusto.

## Renda sob maioria

Use:

```text
a_0=(1-beta)*o_0>0;
a_1=(1-beta)*o_1>0;
d=beta*(o_1-o_0)>0.
```

Há três regiões públicas:

1. `o_1<=1/m`: ambos os tipos seriam incluídos com informação pública;
2. `o_0<=1/m<o_1`: o tipo baixo seria incluído e o alto, excluído;
3. `1/m<o_0`: ambos seriam excluídos.

Subtraindo o benchmark público das classes privadas congeladas:

| Região pública | Classe privada | `RI_M(theta_0,theta_1)` |
|---|---|---|
| ambos incluídos | screening | `(0,0)` |
| ambos incluídos | pooling | `(d,0)` |
| ambos incluídos | exclusão | `(a_0,a_1)` |
| baixo incluído, alto excluído | screening | `(0,-a_1)` |
| baixo incluído, alto excluído | exclusão | `(a_0,0)` |
| ambos excluídos | exclusão | `(0,0)` |

No único empate privado residual entre exclusão e pooling, a renda é o segmento
exato entre os dois vetores correspondentes. A mesma massa de exclusão liga as
duas coordenadas; não se forma um retângulo recombinando os envelopes.

## Onde a diferença das diferenças liga e desliga

Defina `k=beta*o_1-o_0`.

Em `nu=0`, a coordenada do tipo baixo é sempre zero. A coordenada do tipo alto
é positiva e igual a `(1-beta)*o_1` somente quando a maioria pública incluiria
o tipo baixo e excluiria o alto; nas outras regiões ela é zero. Como o tipo alto
tem massa zero nesse endpoint, a imagem ex ante continua zero.

Em `0<nu<=nu_star`, `DeltaRI` é vazio e não há ordenação robusta.

Em `nu_star<nu<=1`, os sinais são:

| Benchmark público de maioria | Classe privada de maioria | Tipo baixo | Tipo alto |
|---|---|---|---|
| ambos incluídos | screening | positivo | zero |
| ambos incluídos | pooling | zero | zero |
| ambos incluídos | exclusão | sinal de `k` | negativo |
| baixo incluído, alto excluído | screening | positivo | positivo |
| baixo incluído, alto excluído | exclusão | sinal de `k` | zero |
| ambos excluídos | exclusão | positivo | zero |

No empate entre exclusão e pooling, o segmento inclui zero. Para qualquer massa
positiva de exclusão, o tipo alto tem diferença negativa; o tipo baixo acompanha
o sinal de `k`. Como o ponto de pooling puro permanece no conjunto, não existe
sinal estrito robusto sobre o segmento inteiro.

## Imagem ex ante

Cada vetor é ponderado pelo mesmo prior `mu=nu`:

```text
(1-mu)*valor_do_tipo_baixo + mu*valor_do_tipo_alto.
```

Na região alta, a imagem da renda de unanimidade é `(1-mu)d`: positiva quando
`mu<1` e zero quando `mu=1`. Quando a diferença entre regras é `(k,0)`, sua
imagem é `(1-mu)k`; quando é `(d,a_1)`, a imagem é estritamente positiva. No
segmento residual, zero sempre pertence à imagem e impede uma ordenação ex ante
estrita robusta.

## Evidência e parada

O candidato contém dez registros públicos, cinco registros de renda e nove
células para a diferença das diferenças. O verificador dirigido reconstrói os
quatro jogos, confere os endpoints, as identidades de renda e cinco negativos
representativos. Ele não faz mutação exaustiva de campos.

N7 continua `pending/unfrozen` até dois pareceres independentes read-only,
`formal_design` e `game_theory`, incidirem no mesmo hash com `PASS 0/0/0`.
Mesmo após eventual freeze, o Goal 4 só fecha com aval explícito posterior do
autor. Nenhum manuscrito, Goal 5, push, merge ou tag integra este trabalho.
