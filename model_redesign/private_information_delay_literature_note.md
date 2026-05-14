# Nota de literatura: informação privada, delay e acordo ineficiente tardio

Data: 2026-05-14

Escopo: referência de trabalho para o redesign `fixed-pie relative-package` com
`pi_H = 0`. Esta nota não altera o modelo. Ela registra como posicionar o
resultado de delay sob unanimidade em relação à literatura de barganha com
informação privada e ao insight de Fearon (1995) de que conflito é
ineficiente ex post.

## Pergunta

O mecanismo de screening que estamos usando teria um análogo em modelos de
crise/war bargaining no estilo Fearon? A intuição é sim: informação privada
sobre outside option, custo, resolve ou valuation pode gerar delay ou conflito
mesmo quando existe um acordo que, visto ex post, teria sido melhor para todos
antes da rejeição.

## Intuição central

Com informação completa, se as partes sabem exatamente o valor mínimo que cada
lado exige, elas conseguem fechar imediatamente algum acordo dentro da zona de
acordo. Delay ou guerra ficam difíceis de racionalizar porque destroem surplus.

Com informação privada, o lado desinformado não sabe se está diante de um tipo
barato ou caro de satisfazer. Uma oferta alta compra aceitação ampla, mas deixa
renda para tipos que aceitariam menos. Uma oferta baixa economiza concessões,
mas pode ser rejeitada pelo tipo mais exigente. Essa rejeição gera delay,
conflito ou guerra. Ex post, quando se descobre que algum acordo poderia ter
sido aceito depois, o conflito anterior parece ineficiente. Ex ante, porém, a
parte desinformada pode aceitar o risco de rejeição para tentar separar tipos e
limitar rendas informacionais.

## Ponte com Fearon (1995)

Fearon argumenta que guerra é ineficiente porque, depois de pagar os custos de
conflito, normalmente existe uma divisão do objeto disputado que teria deixado
ambos os lados melhor do que lutar. O quebra-cabeça racionalista é explicar por
que atores racionais não fecham esse acordo antes.

A explicação por informação privada é que cada lado pode ter incentivo a
exagerar sua disposição de lutar. Se revelar fraqueza piora o acordo recebido,
tipos fracos tentam parecer fortes. Como cheap talk não resolve o problema, a
outra parte pode testar a reivindicação por meio de uma oferta dura. A rejeição
ou a guerra funcionam como parte do processo de screening.

No nosso modelo, a contribuição não é mostrar genericamente que informação
privada pode gerar delay. Esse é um resultado clássico. A contribuição é
institucional: unanimidade cria o ambiente de screening porque torna `H`
pivotal; majority remove ou reduz esse ambiente porque permite que os weak
states excluam `H` e implementem sem comprar sua participação.

Frase curta para o paper:

> Classic bargaining theory shows that private information can make delay an
> equilibrium price of screening. Our institutional contribution is to show
> that unanimity can endogenously create that screening problem by making the
> privately informed hegemon pivotal, while majority can switch it off by
> making the hegemon nonpivotal.

## Como isso conversa com o mecanismo do redesign

No redesign `pi_H = 0`, `H` não controla a agenda. A fonte de poder não é
proposal power. O poder vem de pivotalidade informacional:

```text
Under unanimity:
  weak proposer must buy H's acceptance
  H has private type-dependent participation threshold
  weak proposer trades off pooling rents against screening/delay

Under majority:
  weak proposer can form without H
  H's private threshold is no longer a constraint on implementation
  no screening rent is paid to H through the institutional package
```

Isso torna o achado substantivo mais forte. O poderoso pode extrair rendas não
porque escreve a proposta, mas porque sua aprovação é necessária e seu tipo é
privado.

## Literatura mais próxima

### Barganha dinâmica com informação privada

- Sobel and Takahashi (1983), Fudenberg and Tirole (1983), Fudenberg, Levine
  and Tirole (1985), Rubinstein (1985): fundamentos de bargaining com
  informação incompleta, reputação, seleção e delay.
- Cramton (1984): barganha sequencial em dois lados com informação incompleta.
  Relevante para a intuição de que atraso pode ser parte do processo de
  revelação.
- Admati and Perry (1987): strategic delay in bargaining. Relevante para a
  ideia de delay como decisão estratégica, não como falha comportamental.
- Myerson and Satterthwaite (1983): impossibilidade de eficiência plena em
  barganha bilateral com informação privada. Relevante como fundamento geral
  para ineficiência ex post sob informação privada.
- Spier (1992) e Cramton and Tracy (1992): aplicações em negociação e disputa
  em que delay pode aparecer como custo informacional.

### Barganha de crise e guerra em RI

- Fearon (1995): formula o puzzle racionalista de guerra como ineficiência
  ex post e destaca informação privada com incentivos para misrepresentação.
- Brito and Intriligator (1985): modelo clássico de conflito sob informação
  incompleta.
- Banks (1990): interação entre custo de conflito, assimetria de informação e
  surgimento de guerra.
- Leventoglu and Tarar (2008): guerra como resultado de barganha com informação
  incompleta, enfatizando o papel de incerteza estratégica.
- Powell (2004), Slantchev (2003), Filson and Werner (2002): guerra e acordo
  como processos de barganha que podem revelar informação ao longo do tempo.

### Onde nosso modelo se diferencia

A literatura de RI normalmente toma o ambiente de conflito/crise como dado e
pergunta por que informação privada gera guerra ou delay. A literatura de
barganha normalmente toma a regra de barganha como dada e pergunta como tipos
privados afetam ofertas, rejeições e atraso.

Nosso paper adiciona uma camada institucional: a regra de decisão determina se
o tipo privado de `H` entra ou não como restrição de implementação. Unanimidade
ativa o problema de screening; majority pode desativá-lo.

## Implicação para a narrativa do paper

O achado de delay deve ser apresentado como uma extensão do insight de Fearon:
o acordo alcançado depois poderia, materialmente, ter sido fechado antes; o que
impede isso não é ausência de surplus, mas o custo estratégico de revelar
informação e o desenho institucional que torna essa informação pivotal.

Em linguagem de paper:

> The inefficient delay is not a protocol artifact. It is the institutional
> expression of a standard private-information bargaining problem: when the
> hegemon's privately known participation threshold is pivotal, weak states may
> optimally risk rejection to avoid paying pooling rents. Majority rule changes
> the bargaining environment by removing that threshold from the set of
> implementation constraints.

## Cuidados

- Não dizer que o modelo "explica guerra" sem construir uma extensão com
  destruição de surplus ou custo de conflito. O paralelo correto é com o
  mecanismo de delay/conflito informacional, não com guerra diretamente.
- Não apresentar delay como hipótese ad hoc. Ele precisa continuar sendo
  derivado por backward induction a partir dos payoffs e thresholds declarados.
- Não apagar o ramo de delay por desconforto substantivo. Se o ramo existe no
  jogo, ele deve ser caracterizado; se não existe, deve ser refutado por
  incentivos, não por protocolo.
- Antes de transportar citações ao manuscrito, conferir dados bibliográficos,
  páginas e formulações exatas.

## Fontes consultadas

- Fearon, James D. 1995. "Rationalist Explanations for War." International
  Organization. https://pages.ucsd.edu/~bslantchev/courses/pdf/fearon-io1995v49n3.pdf
- Brito, Dagobert L., and Michael D. Intriligator. 1985. "Conflict, War, and
  Redistribution." American Political Science Review.
  https://www.cambridge.org/core/services/aop-cambridge-core/content/view/D81000D454A1DAA94E15EC7BC172DFD7/S0003055400237246a.pdf/conflict_war_and_redistribution.pdf
- Banks, Jeffrey S. 1990. "Equilibrium Behavior in Crisis Bargaining Games."
  American Journal of Political Science.
  https://authors.library.caltech.edu/records/dhzm3-9jy18
- Leventoglu, Bahar, and Ahmer Tarar. 2008. "Does Private Information Lead to
  Delay or War in Crisis Bargaining?" International Studies Quarterly.
  https://academic.oup.com/isq/article/52/3/533/1872544
- Cramton, Peter C. 1984. "Bargaining with Incomplete Information: An Infinite
  Horizon Model with Two-Sided Uncertainty." Review of Economic Studies.
  https://academic.oup.com/restud/article-pdf/51/4/579/4356068/51-4-579.pdf
- Grossman, Sanford J., and Motty Perry. 1986. "Perfect Sequential Equilibrium."
  NBER Technical Working Paper. https://www.nber.org/papers/t0056
- Admati, Anat R., and Motty Perry. 1987. "Strategic Delay in Bargaining."
  Review of Economic Studies.
  https://www.econbiz.de/Record/strategic-delay-in-bargaining-admati-anat/10001040819

## Output do agente de lit review

Auditoria independente solicitada em 2026-05-14. Síntese recebida:

- O paralelo mais direto vem de barganha dinâmica com informação incompleta,
  especialmente modelos em que ofertas duras geram rejeição e revelação.
- Em RI, Fearon (1995) fornece o enquadramento central: conflito é ineficiente
  ex post, mas informação privada com incentivo para misrepresentation pode
  bloquear acordo ex ante.
- O posicionamento promissor do paper é institucional: regras de decisão podem
  criar ou remover a necessidade de screening.
- A frase de contribuição recomendada é: a novidade não é que informação
  privada pode causar delay; a novidade é que unanimidade cria o problema de
  screening ao tornar o hegemon pivotal, enquanto majority o remove ao permitir
  exclusão.
