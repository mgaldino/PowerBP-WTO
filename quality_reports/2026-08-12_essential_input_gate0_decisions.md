# Decisões do autor sobre os findings do Gate 0 — essential-input

**Data:** 2026-08-12
**Status:** decisões tomadas pelo autor; contrato a ser editado por implementador
**Contrato afetado:** `quality_reports/plans/2026-08-12_essential_input_gate0.md`

Todos os oito findings escalados foram decididos. Nenhum permanece
`pending protocol decision`. As decisões abaixo são normativas e devem ser
incorporadas ao contrato antes de o Goal 1 abrir.

---

## D1 e D2 — implementação, destino de `y`, e data do payoff de desacordo

**Decisão.** A proposta é uma alocação da pie unitária. Se aprovada pela regra
vigente, é implementada exatamente como proposta. Não há pagamentos laterais.

Se `H` vota não e a proposta passa mesmo assim, `H` não integra o acordo, recebe
`o_theta`, **e recebe `y` como escrito na proposta**. A alocação é executada
integralmente. Nada é destruído e nada é realocado.

**Justificativa, e por que as alternativas foram descartadas.** Esta é a única
leitura compatível com as duas primitivas já decididas:

- *`y` destruído, fracos ficam com `1-y`*: descartada porque aloca apenas `1-y`
  no ramo de exclusão, fazendo a pie encolher e contradizendo a pie fixa.
- *`y` revertido ao residual do proponente*: descartada porque exige realocar
  conforme quem acabou na coalizão, o que é contrato contingente ao resultado do
  ballot — precisamente a segunda decisão pós-voto que foi descartada.

Propostas cuja soma seja inferior a 1 não são de equilíbrio. Isso é conclusão
sobre comportamento, não restrição imposta, e deve ser derivada.

**Alcance do ramo, a provar e não a assumir.** Sob unanimidade o ramo não
existe: o `não` de `H` derruba a proposta e nada é implementado. Sob maioria,
oferecer `y>0` comprando `q-1` votos fracos é estritamente dominado por oferecer
`y=0`, já que `H` não é necessário e embolsaria `y+o_theta` votando não. O ramo
não ocorre no caminho de equilíbrio.

**Consequência que a derivação deve tratar.** Quando `H` não é pivotal sob
maioria, votar não dá `y+o_theta` e votar sim dá `y`, então sim não domina.
Com estratégias puras e undominância a pivotalidade de `H` é determinística no
caminho, dado o que o proponente comprou. Fora do caminho, e na construção da IC
de `H` sob maioria, esse termo entra e não pode ser suprimido.

**Data.** Todos são pagos quando o jogo termina. O jogo termina quando uma
proposta é aprovada, em R1 ou R2, ou quando R2 falha. Se uma proposta é aprovada
sem `H`, `H` recebe `o_theta` naquela data, sem desconto, exatamente como os
weak states recebem suas alocações naquela data.

**Consequência a provar, não a assumir.** Sob maioria, oferecer `y>0` e ao mesmo
tempo comprar `q-1` votos fracos de reserva é estritamente dominado por oferecer
`y=0` com os mesmos `q-1` votos: paga-se `y` em todo estado do mundo e não se
ganha nada, porque `H` não acrescenta valor à pie. Restam duas jogadas sob
maioria — excluir com `y=0` e `q-1` fracos, ou substituir com `y>0` e `q-2`
fracos, apostando na aceitação de `H`. `N3` deve provar essa dominância.

Nota de dependência: esse argumento repousa sobre a pie ser independente da
inclusão de `H`. É aqui que aquela decisão faz trabalho estrutural.

---

## D3 — maioria não é benchmark de no-screening por construção

**Decisão.** A caracterização "sob maioria a informação privada fica inerte",
presente na Seção 7 do contrato, é **removida**. Era afirmação de resultado
escrita como orientação de derivação, e as próprias primitivas a contradizem.

Com `a` denotando o preço de um voto fraco em R1 sob maioria:

```text
o_0 e o_1 ambos acima de a   -> H caro nos dois tipos; exclusão; sem screening
o_0 e o_1 ambos abaixo de a  -> H barato nos dois tipos; inclusão; sem screening
o_0 < a < o_1                -> screening sob maioria
```

Na faixa intermediária o proponente enfrenta genuíno problema de screening sob
maioria. `N3` deve derivar as três regiões sem orientação prévia sobre qual
prevalece.

Isso dá domínio explícito ao contraste essencial-versus-substituível em vez de
afirmação geral, e é fortalecimento, não enfraquecimento.

---

## D4 — `T^Y` vale em toda igualdade; estratégias puras no ballot

**Decisão do autor.** A convenção de aceitação na igualdade vale **em toda
igualdade**, inclusive quando o valor comparado é continuação endógena. Não se
admitem mixed strategies no ballot, sob nenhuma rodada. A alternativa —
restringir `T^Y` a comparações contra valor exógeno e permitir mixing onde a
indiferença é endógena — foi considerada e **descartada**, para não abrir
exceção que exigiria justificar por que o resto do jogo permanece em puras.

**Consequência esperada, a derivar em `N4` e não a assumir.** Sob essa
convenção, R1 unanimidade não admite equilíbrio separating. Em qualquer
candidato separating a rejeição é on path, Bayes leva a crença a 1, R2 oferece
`o_1`, e o low type prefere imitar. O preço que compra o low type também compra
o high type, porque na igualdade `T^Y` obriga aceitação. Restam pooling e falha
deliberada.

**Consequência substantiva.** No jogo estático o proponente screena quando o
prior é baixo, e nessa região o low type fica apenas com sua opção externa. Com
duas rodadas o screening desaparece e a renda informacional `beta*(o_1-o_0)` é
estritamente positiva para todo prior. O mecanismo é que a possibilidade de
esperar força o pooling ainda que ninguém espere: opção nunca exercida que
mesmo assim precifica o acordo.

**Resposta à pergunta 1 da Seção 1 do contrato.** Não há atraso em equilíbrio.
Isso decorre da restrição a estratégias puras e deve ser declarado como tal no
paper, em remark ou nota. Formulação recomendada: o modelo restringe-se a
estratégias puras no ballot; sob essa restrição não há atraso em equilíbrio, e a
renda vem da opção de atraso, não do seu exercício.

---

## D5 — renda informacional definida por contrafactual, não por excesso

**Decisão.** Renda informacional é definida como diferença contra o mesmo jogo
com `theta` público, e não como excesso sobre `o_theta`.

Sob informação completa, o proponente oferece exatamente a reserva do tipo que
enfrenta e `H` aceita por `T^Y`, ficando na reserva. Isso vale sob as duas
regras. Logo qualquer excesso sobre esse benchmark é atribuível à informação
privada.

**Entrega obrigatória.** Cada nó exporta também o benchmark de informação
completa da sua regra. A renda é reportada como diferença, nunca inferida.

Pergunta de alinhamento adotada: retirada a informação privada e mantido todo o
resto idêntico, a renda dita informacional desaparece, e a diferença entre as
regras continua vindo da substituibilidade de `H`?

---

## D6 — reconhecimento, crenças, e suficiência do estado

**Reconhecimento.** Sorteios independentes com reposição a cada rodada, uniforme
entre os `m` weak states, todos elegíveis, incluindo quem propôs na rodada
anterior. Convenção Baron-Ferejohn.

**Crenças.** O weak-vote-passive assessment deixa de ser suposição mantida e
passa a ser **lema derivado**. Sob `pi_H=0`, nenhum jogador fraco observa
`theta`, inclusive o proponente, logo nenhuma ação fraca pode condicionar em
`theta`, logo por Bayes votos fracos são não informativos sobre `theta` e o
posterior depende apenas do voto do próprio `H`. `N4` deve provar isso, não
declará-lo.

**Suficiência do estado.** Continua obrigação de prova. O argumento correto não é
a ausência de transferências após falha: é que R2 é terminal, portanto o
proponente de R2 maximiza o próprio payoff e não tem motivo para condicionar em
identidade ou histórico a não ser através da crença.

---

## D7 — entry sai do baseline

**Decisão.** A decisão coletiva de formação sai do modelo base. O nó `N5` é
removido do mapa de dependências e o schema de interface perde a coordenada de
formação. A cadeia passa a ter cinco nós:

```text
N1 r2_majority     sem dependências
N2 r2_unanimity    sem dependências
N3 r1_majority     consome N1
N4 r1_unanimity    consome N2
N6 comparison      consome N3 e N4
```

**Justificativa e limite.** Entry é decisão anterior à barganha, avaliada com os
valores da barganha. Como é coletiva e tudo-ou-nada, ou a organização se forma
com todos e o jogo de barganha é exatamente o derivado, ou não se forma e não há
barganha. Logo entry não restringe equilíbrios da barganha: ela decide se o jogo
é jogado. Acrescentá-la depois é puramente aditivo.

**Escopo que isso impõe ao paper.** A comparação institucional passa a ser
condicional à organização existir sob as duas regras. Isso deve ser declarado
explicitamente. A tensão de que a regra preferida por `H` é a que mais ameaça a
existência da organização vai para a discussão como intuição e para extensão
futura como resultado formal.

---

## D8 — `o_0` estritamente positivo

**Decisão.** O domínio de primitivas passa de `0 <= o_0 < o_1 <= y_bar <= 1`
para:

```text
0 < o_0 < o_1 <= y_bar <= 1
```

**Justificativa substantiva, não conveniência.** `H` é mais poderoso que os weak
states e depende menos do acordo, o que se reflete em payoff de desacordo
estritamente superior ao deles, que está normalizado em zero. É primitiva do
ambiente hegemônico.

**Consequência.** O caso limite que gerava `a_U = a_M` desaparece, e a
desigualdade `a_U < a_M` vale estritamente. Isso **não** elimina D3: a faixa
`o_0 < a < o_1` continua existindo para `o_0` pequeno e `N` pequeno.

---

## D9 — empate no nível da proposta

**Lacuna identificada durante a decisão de D4, não presente nos findings do
revisor.** `T^Y` governa o respondente comparando oferta com valor. Não governa
proponente indiferente entre duas propostas distintas com o mesmo payoff, que é
empate de outra natureza.

**Decisão provisória, sujeita a revisão do autor.** Entre propostas que
maximizam o payoff do proponente, selecionar a que minimiza o payoff esperado de
`H`. É a regra da v5, e é conservadora: seleciona contra o resultado que o paper
quer, de modo que nenhum resultado dependa favoravelmente do tie-break.

---

## Edições requeridas no contrato

1. Seção 2: `0 < o_0`, conforme D8.
2. Seção 2 e 4: destino de `y` na exclusão e data do payoff de desacordo,
   conforme D1/D2.
3. Seção 4: reconhecimento independente com reposição, conforme D6.
4. Seção 5: `T^Y` em toda igualdade e restrição a estratégias puras no ballot,
   conforme D4; acrescentar tie-break de proposta, conforme D9.
5. Seção 7: remover a caracterização de informação inerte sob maioria, conforme
   D3; remover `N5` e renumerar, conforme D7.
6. Seção 7.2: remover coordenada de formação; acrescentar benchmark de
   informação completa como saída obrigatória, conforme D5.
7. Seção 1: registrar que a resposta à pergunta 1 decorre da restrição a puras.
8. Seções 4 e 9: acrescentar as obrigações de prova de D1, D3, D4 e D6.

Nenhuma dessas edições autoriza derivação. Depois de aplicadas, o contrato volta
aos dois revisores para confirmação de que as decisões foram incorporadas sem
introduzir novo problema.
