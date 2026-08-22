# Exemplo motivador em `N=5` usando apenas N2 congelado

**Data:** 2026-08-21

**Escopo:** exemplo terminal de R2 sob unanimidade; não usa N6, não deriva N7 e
não contém ação de saída.

## Fonte congelada

- Interface N2: `model_redesign/essential_input_n2_r2_unanimity_interface.json`,
  SHA-256 `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`.
- Derivação N2: `model_redesign/essential_input_n2_r2_unanimity_derivation.md`,
  SHA-256 `3265be3379a902c4deac9db10d45babb2e6c7ad1f98a436ea113e33732cefc99`.
- A interface é lida junto da Emenda 1a e da errata N2 em
  `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`,
  SHA-256 `94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69`.

## Primitivas do exemplo

Há `N=5` Estados: o hegemon `H` e `m=N-1=4` Estados fracos. Um Estado fraco é
reconhecido uniformemente para propor no R2 terminal. Fixe

```text
o_0 = 0.10,   o_1 = 0.35,   y_bar >= 0.35.
```

O proponente escolhe a concessão `y` a `H`, paga zero aos três fracos
não proponentes e retém o residual `1-y`. Todos votam simultaneamente. Os
fracos não proponentes votam `sim`; `H` é pivotal e o tipo `theta` vota `sim`
exatamente quando `y>=o_theta`, com `T^Y` escolhendo `sim` na igualdade.
Como R2 é terminal, `beta` não entra nos payoffs desta rodada.

## O limiar de crença

O proponente compara duas ofertas:

```text
y = o_0 = 0.10: payoff esperado = (1-nu)(1-o_0) = 0.90(1-nu)
y = o_1 = 0.35: payoff certo    = 1-o_1          = 0.65.
```

Logo,

```text
nu_star = (o_1-o_0)/(1-o_0) = 0.25/0.90 = 5/18 = 0.277777...
```

- Se `0<=nu<=5/18`, a oferta selecionada é `y=0.10`. O tipo baixo aprova;
  o tipo alto rejeita. Na igualdade `nu=5/18`, as duas ofertas empatam para o
  proponente, e o desempate que minimiza o payoff esperado de `H` seleciona
  `y=0.10`.
- Se `5/18<nu<=1`, a oferta selecionada é `y=0.35`, e os dois tipos aprovam.

## Dois retratos concretos

Com `nu=0.20`, a oferta `0.10` rende `0.72` ao proponente, contra `0.65` da
oferta pooling. O acordo passa com probabilidade `0.80`. Condicionalmente ao
tipo, `H` recebe `0.10` quando baixo e `0.35` quando alto; no segundo caso a
proposta falha e o payoff de desacordo é realizado no fim do jogo. Antes do
sorteio de reconhecimento, cada Estado fraco tem valor esperado
`0.72/4=0.18`.

Com `nu=0.50`, a oferta `0.10` renderia apenas `0.45`, então o proponente oferece
`0.35`. O acordo passa com probabilidade um, o proponente recebe `0.65`, `H`
recebe `0.35` em ambos os tipos e cada Estado fraco tem valor esperado
`0.65/4=0.1625` antes do reconhecimento.

## Intuição

Quando o tipo alto é pouco provável, vale arriscar uma proposta barata que
passa apenas com o tipo baixo. Quando ele se torna provável o suficiente, o
proponente compra aprovação de ambos. A rejeição do tipo alto é apenas um voto
`não` no ballot terminal; não é uma ação de saída e não cria protocolo adicional.
