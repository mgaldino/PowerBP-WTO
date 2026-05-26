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

## Status para transporte ao paper

O resultado de delay não deve entrar como exemplo calibrado. Ele não é o
propósito central do paper e não deve deslocar a arquitetura institucional.

Classificação recomendada:

- Se o resultado for diretamente implicado pela caracterização de R1
  unanimity, apresentar como corolário curto.
- Se exigir uma condição paramétrica substantiva própria, apresentar como
  proposição auxiliar.
- Se for útil apenas para interpretar a região de rejeição/continuação,
  apresentar como remark após a proposição de R1.

A formulação mais conservadora é um remark. A formulação mais forte, caso a
prova fique limpa e geral, é um corolário da proposição de R1 unanimity.

## Cuidados

- Não dizer que o modelo "explica guerra" sem construir uma extensão com
  destruição de surplus ou custo de conflito. O paralelo correto é com o
  mecanismo de delay/conflito informacional, não com guerra diretamente.
- Não apresentar delay como hipótese ad hoc. Ele precisa continuar sendo
  derivado por backward induction a partir dos payoffs e thresholds declarados.
- Não apagar o ramo de delay por desconforto substantivo. Se o ramo existe no
  jogo, ele deve ser caracterizado; se não existe, deve ser refutado por
  incentivos, não por protocolo.

## Referências verificadas

Metadados checados em 2026-05-14. Antes de migrar ao manuscrito, converter
para BibTeX e conferir consistência com o estilo final do periódico.

### Núcleo de RI: guerra, crise e informação privada

- Banks, Jeffrey S. 1990. "Equilibrium Behavior in Crisis Bargaining Games."
  American Journal of Political Science 34(3): 599-614.
  https://doi.org/10.2307/2111390
- Brito, Dagobert L., and Michael D. Intriligator. 1985. "Conflict, War, and
  Redistribution." American Political Science Review 79(4): 943-957.
  https://doi.org/10.2307/1956242
- Fearon, James D. 1995. "Rationalist Explanations for War." International
  Organization 49(3): 379-414.
  https://doi.org/10.1017/S0020818300033324
- Filson, Darren, and Suzanne Werner. 2002. "A Bargaining Model of War and
  Peace: Anticipating the Onset, Duration, and Outcome of War." American
  Journal of Political Science 46(4): 819-837.
  https://doi.org/10.2307/3088436
- Leventoglu, Bahar, and Ahmer Tarar. 2008. "Does Private Information Lead to
  Delay or War in Crisis Bargaining?" International Studies Quarterly 52(3):
  533-553. https://doi.org/10.1111/j.1468-2478.2007.00514.x
- Powell, Robert. 2004. "Bargaining and Learning While Fighting." American
  Journal of Political Science 48(2): 344-361.
  https://doi.org/10.1111/j.0092-5853.2004.00074.x
- Sartori, Anne E. 2002. "The Might of the Pen: A Reputational Theory of
  Communication in International Disputes." International Organization 56(1):
  121-149. https://doi.org/10.1162/002081802753485151
- Schultz, Kenneth A. 1998. "Domestic Opposition and Signaling in
  International Crises." American Political Science Review 92(4): 829-844.
  https://doi.org/10.2307/2586306
- Slantchev, Branislav L. 2003. "The Principle of Convergence in Wartime
  Negotiations." American Political Science Review 97(4): 621-632.
  https://doi.org/10.1017/S0003055403000911

### Núcleo de bargaining com informação incompleta

- Admati, Anat R., and Motty Perry. 1987. "Strategic Delay in Bargaining."
  Review of Economic Studies 54(3): 345-364.
  https://doi.org/10.2307/2297563
- Cramton, Peter C. 1984. "Bargaining with Incomplete Information: An
  Infinite-Horizon Model with Two-Sided Uncertainty." Review of Economic
  Studies 51(4): 579-593. https://doi.org/10.2307/2297780
- Cramton, Peter C. 1992. "Strategic Delay in Bargaining with Two-Sided
  Uncertainty." Review of Economic Studies 59(1): 205-225.
  https://doi.org/10.2307/2297934
- Cramton, Peter C., and Joseph S. Tracy. 1992. "Strikes and Holdouts in Wage
  Bargaining: Theory and Data." American Economic Review 82(1): 100-121.
- Fudenberg, Drew, David K. Levine, and Jean Tirole. 1985. "Infinite-Horizon
  Models of Bargaining with One-Sided Incomplete Information." In
  Game-Theoretic Models of Bargaining, edited by Alvin E. Roth, 73-98.
  Cambridge: Cambridge University Press.
  https://doi.org/10.1017/CBO9780511528309.006
- Fudenberg, Drew, David K. Levine, and Jean Tirole. 1987. "Incomplete
  Information Bargaining with Outside Opportunities." Quarterly Journal of
  Economics 102(1): 37-50. https://doi.org/10.2307/1884679
- Fudenberg, Drew, and Jean Tirole. 1983. "Sequential Bargaining with
  Incomplete Information." Review of Economic Studies 50(2): 221-247.
  https://doi.org/10.2307/2297414
- Grossman, Sanford J., and Motty Perry. 1986a. "Perfect Sequential
  Equilibrium." Journal of Economic Theory 39(1): 97-119.
  https://doi.org/10.1016/0022-0531(86)90022-0
- Grossman, Sanford J., and Motty Perry. 1986b. "Sequential Bargaining under
  Asymmetric Information." Journal of Economic Theory 39(1): 120-154.
  https://doi.org/10.1016/0022-0531(86)90023-2
- Myerson, Roger B., and Mark A. Satterthwaite. 1983. "Efficient Mechanisms
  for Bilateral Trading." Journal of Economic Theory 29(2): 265-281.
  https://doi.org/10.1016/0022-0531(83)90048-0
- Rubinstein, Ariel. 1985. "A Bargaining Model with Incomplete Information
  about Time Preferences." Econometrica 53(5): 1151-1172.
  https://doi.org/10.2307/1911016
- Sobel, Joel, and Ichiro Takahashi. 1983. "A Multistage Model of Bargaining."
  Review of Economic Studies 50(3): 411-426.
  https://doi.org/10.2307/2297673
- Spier, Kathryn E. 1992. "The Dynamics of Pretrial Negotiation." Review of
  Economic Studies 59(1): 93-108. https://doi.org/10.2307/2297927

### Adjacent literature on unanimity, vetoes, and persuasion

- Bardhi, Arjada, and Yingni Guo. 2018. "Modes of Persuasion Toward
  Unanimous Consent." Theoretical Economics 13(3): 1111-1149.
  https://doi.org/10.3982/TE2834
- Kim, Jenny S., Kyungmin Kim, and Richard Van Weelden. 2025. "Persuasion in
  Veto Bargaining." American Journal of Political Science 69(3): 1115-1127.
  https://doi.org/10.1111/ajps.12914

### Correções bibliográficas registradas

- O DOI correto de Leventoglu and Tarar (2008) é
  `10.1111/j.1468-2478.2007.00514.x`.
- Grossman and Perry (1986) deve ser citado pela versão publicada no Journal
  of Economic Theory, não pelo NBER Technical Working Paper.
- Para o argumento de delay, Grossman and Perry (1986b), "Sequential
  Bargaining under Asymmetric Information", é substantivamente mais próximo
  do que Grossman and Perry (1986a), "Perfect Sequential Equilibrium".

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
