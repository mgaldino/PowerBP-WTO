# N4 Round 7 — classificação do finding antes do reparo

**Interface revisada:** `sha256:ee61ce6f854d4393f51048592a5221a9999a8f3f7daca1e749e7f19a88927f2d`  
**Revisor:** `game_theory`, `review-n4-game-2026-08-19-r7`  
**Veredicto:** FAIL; `critical=0`, `major=0`, `minor=1`

## Finding 1 — texto original

> Minor — A prova de suficiência de `L2`, Seção 6.3 da derivação, afirma `(1-nu)*a0 < (1-nu)*q2`. Isso é falso no endpoint permitido `nu=1`. Reproduzindo com `m=2, beta=.9, o0=.2, o1=.6, nu=1`: `a0=.36`, `q2=.46`, `z=.18`, `d=0` e `e2=0`; portanto a desigualdade alegada é `0<0`. A conclusão necessária permanece correta, pois `min(d,z)=0<=e2=0`; o argumento exige `<=` ou tratamento separado de `nu=1`. A interface e a correspondência substantiva não são alteradas.

### Classificação

**Técnico, pelo teste de reparo único.** A própria derivação já estabelece
`q2>z` e `a0<q2`. Multiplicar `a0<q2` pelo fator não negativo `1-nu` produz
`(1-nu)*a0 <= (1-nu)*q2`, com igualdade exatamente possível em `nu=1`.
Essa relação fraca é suficiente para concluir `min{d,z}<=e2`; não há mudança
na interface, na correspondência, nas primitivas ou na seleção. O único reparo
é substituir o sinal estrito pelo fraco nessa etapa da prova.
