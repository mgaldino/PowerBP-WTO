# Revisão conceitual independente do requisito fora do caminho

Revisor: `/root/offpath_requirement`. Data: 2026-09-05. Transcrição da resposta final, com equações convertidas para Markdown. O revisor recebeu as primitivas e a correção autoral, sem ler uma proposta do implementador. Nenhum arquivo editado.

A condição sugerida pelo usuário identifica uma obrigação de prova relevante, mas sua formulação literal é insuficiente para garantir todo o resultado desejado.

1. **“Saber que H rejeitará” precisa ser definido na informação do proponente.** Seja `I` seu conjunto de informação, `μ_I` sua crença sobre o tipo de H e `σ_H` a estratégia de votação já derivada. A expressão significa `Pr_{μ_I,σ_H}(v_H=N | I,x)=1`. Para tipos discretos, todos os tipos com probabilidade positiva em `μ_I` rejeitam com certeza. O proponente não pode condicionar sua proposta ao tipo verdadeiro conhecido somente por H.

2. **Excluir ofertas positivas sob rejeição certa não cobre rejeição de alguns tipos.** Uma proposta pode ser aceita por um tipo e rejeitada por outro. A condição acima não é acionada, embora possa haver probabilidade positiva de aprovação acompanhada de voto não de H. Isso é uma insuficiência lógica da condição, sem afirmar que determinado perfil de votos seja um equilíbrio.

   O alvo mais forte para propostas ótimas seria demonstrar: `x_H>0 ⇒ Pr(A ∩ {v_H=N} | I,x)=0`, onde `A` significa aprovação. Assim, toda aprovação de uma proposta ótima que atribui valor positivo a H requer seu voto sim. Esse enunciado deve aparecer como resultado a demonstrar, não como uma nova restrição ao espaço de propostas.

3. **Há dois sentidos distintos de “fora do caminho”.** Racionalidade pode disciplinar a proposta ótima de um fraco em qualquer conjunto de informação, inclusive depois de uma história que o equilíbrio não produz. Ela não elimina a possibilidade física de uma proposta desviadora `x_H>0`, seguida de voto não de H e aprovação pelos fracos. Mantidos o simplex de propostas e os votos simultâneos, esse ramo continua na árvore e precisa de payoffs definidos.

   Portanto, uma prova sobre propostas ótimas, mesmo válida em todos os conjuntos de informação fora do caminho, não demonstra que esse ramo seja impossível em toda história factível.

   Existe ainda uma diferença entre uma garantia quase certa sob `μ_I` e uma garantia para todos os tipos factíveis. Um tipo com probabilidade posterior zero não entra na maximização esperada do proponente. Se o objetivo inclui esse tipo, o resultado precisa ser verificado tipo a tipo; não basta a expressão probabilística acima sob a crença local.

4. **Um resultado terminal já pode ser provado sem completar o payoff disputado de H.** Sob as primitivas fornecidas, suponha que a maioria possa ser atingida apenas pelos fracos. Na rodada terminal, cada fraco compara sua alocação não negativa com desacordo zero e vota sim na indiferença. A proposta `x_p=1`, `x_j=0` para `j≠p` passa pelos votos dos fracos e entrega 1 ao proponente. Qualquer proposta com `x_H>0` entrega ao proponente no máximo `1−x_H<1` se aprovada e zero se rejeitada. Logo, **toda proposta ótima terminal sob maioria tem `x_H=0`**, independentemente da crença e também em conjuntos de informação fora do caminho.

   A prova utiliza somente os payoffs dos fracos, a viabilidade e o desempate terminal. Não escolhe o payoff de H no ramo disputado. Sob unanimidade, aprovação e voto não de H são incompatíveis pela quota.

   Isso não resolve as rodadas anteriores: com valores de continuação positivos, outros fracos podem exigir concessões e o uso do voto de H pode alterar os custos de aprovação.

5. **O argumento geral de “desperdício” exige verificar a proposta alternativa.** Para demonstrar que oferecer valor positivo a um rejeitante certo não é ótimo, seria necessário comparar a proposta com outra que reduza `x_H` a zero e aumente a alocação do proponente. Deve-se provar que essa mudança preserva os votos relevantes, a aprovação e, quando houver rejeição, as continuações pertinentes. Nada disso deve ser presumido num jogo dinâmico.

   Além disso, se ambas as propostas forem rejeitadas com certeza e produzirem a mesma continuação, a alteração pode não gerar ganho estrito. Nesse caso, a racionalidade isolada pode permitir a proposta positiva por indiferença. A palavra “jamais” exigiria uma prova que exclua também esse caso ou uma seleção adicional explicitamente autorizada.

   Condicionalmente, se o ramo ainda disputado fosse completado com pagamento aditivo `x_H+o_θ`, então, numa votação cuja aprovação independa do voto de H, votar não renderia estritamente mais que votar sim para `o_θ>0`. A racionalidade de H favoreceria esse voto. Isso mostra por que é necessário especificar e examinar esse ramo, sem adotá-lo aqui.

Minha sugestão de redação operacional é:

> A ausência de recebimento simultâneo de alocação positiva e opção externa por H deve ser sustentada pela arquitetura econômica e pelos incentivos do jogo. Derivar as propostas ótimas dos fracos em cada conjunto de informação, alcançado ou não no equilíbrio, usando as crenças admissíveis e as continuações previamente resolvidas. Verificar se uma proposta ótima com `x_H>0` pode ser aprovada quando algum tipo de H vota não, distinguindo os tipos com probabilidade posterior positiva dos demais tipos factíveis. Demonstrar por comparação de desvios qualquer alegação de que uma concessão positiva a H é desperdício; não usar essa alegação como restrição primitiva às propostas. Payoffs e comportamento após propostas desviadoras devem estar definidos. Se a arquitetura permitir o recebimento simultâneo que se pretende excluir, registrar a incompatibilidade e apresentar a revisão substantiva necessária.

**Status:** insuficiência da condição literal e lema terminal demonstrados; extensão dinâmica e cobertura dos ramos após propostas desviadoras permanecem pendentes da arquitetura completa. Não editei arquivos nem li a proposta de redação do implementador.
