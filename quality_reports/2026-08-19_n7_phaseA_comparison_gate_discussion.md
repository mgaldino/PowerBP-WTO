# N7 Fase A — discussão sobre o gate de comparação

**Data:** 2026-08-19  
**Status:** documento de referência anterior à derivação dos benchmarks públicos  
**Escopo autorizado:** derivar, classificar e revisar os benchmarks públicos de
`N7`; nenhuma comparação com equilíbrios privados e nenhum cálculo de renda
informacional estão autorizados nesta fase.

## 1. Escopo substantivo e domínio formal

O escopo substantivo principal do paper é uma organização com um hegemon e
pelo menos três países fracos. Em termos da notação do contrato, isso significa
`m >= 3`, ou pelo menos quatro membros ao todo. O caso com exatamente dois
países fracos, `m = 2`, permanece integralmente coberto pelo domínio formal e
pelos artefatos de prova. Ele é, porém, secundário para a interpretação
substantiva. Essa distinção não autoriza apagar, fundir ou selecionar células do
caso `m = 2`.

## 2. O que a correspondência privada de N4 exige distinguir

`N4` tem poucas categorias gerais de ramo, mas sua correspondência é infinita.
Portanto, o nome de uma categoria — por exemplo, acordo imediato ou atraso — não
identifica sozinho um equilíbrio. Uma comparação futura precisará decidir se o
objeto relevante são avaliações completas, classes de outcome, envelopes de
payoff ou alguma seleção explicitamente autorizada.

A multiplicidade de `N4` pode ter origens distintas, que não devem ser tratadas
como se fossem o mesmo fenômeno:

1. **Estratégia mista genuína do proponente fraco entre acordo imediato e
   atraso.** Ela pode surgir apenas numa fronteira em que o proponente é
   genuinamente indiferente entre os dois ramos. A mistura altera a distribuição
   de outcomes e, em geral, os payoffs esperados.
2. **Aleatorização entre propostas payoff-equivalentes dentro de um mesmo
   ramo.** O proponente pode distribuir probabilidade entre propostas que lhe
   dão o mesmo payoff e pertencem à mesma classe de outcome. Essa aleatorização
   não é automaticamente equivalente a misturar entre acordo e atraso.
3. **Heterogeneidade pura entre identidades de proponentes, combinada com o
   sorteio exógeno de reconhecimento.** Proponentes diferentes podem escolher
   estratégias puras diferentes. A incerteza agregada vem do sorteio de quem é
   reconhecido, não de uma estratégia mista adotada por cada proponente.
4. **Multiplicidade apenas de crenças fora do caminho.** Duas avaliações podem
   ter as mesmas estratégias, outcomes e payoffs no caminho e diferir somente
   nas crenças atribuídas a histórias de probabilidade zero. Essa diferença é de
   assessment e não deve ser contada automaticamente como diferença
   substantiva de outcome ou payoff.

## 3. Papéis por identidade entre países fracos

Mesmo quando todos os países fracos têm as mesmas preferências, o mesmo poder e
a mesma opção externa, suas identidades públicas podem sustentar papéis
autorrealizáveis distintos. Um país pode adquirir o papel de negociador
“cooperativo”, associado a acordo imediato, enquanto outro assume o papel de
negociador “difícil”, associado a atraso. Se cada identidade escolhe uma ação
pura, trata-se de um **equilíbrio puro assimétrico por identidade**, e não de
uma estratégia mista.

A identidade pública permite que estratégias de resposta e crenças sejam
condicionadas ao nome do proponente reconhecido. Assim, a convenção pode ser
autorrealizável sem exigir necessariamente que cada proponente seja indiferente
entre os papéis. Também não exige, por si só, revelação de informação no caminho:
o nome do proponente é público antes da proposta e não é uma realização do tipo
privado de `H`.

Essa possibilidade deve ser preservada no artefato formal. Sua relevância para
uma comparação futura é uma decisão autoral separada.

## 4. Identidade pública sob maioria e a comparação com Baron–Ferejohn

A identidade pública do proponente é necessária para sustentar convenções por
rótulo, mas não é suficiente para produzir os mesmos papéis sob qualquer regra
de votação. Sob maioria e `beta < 1`, o proponente pode comprar uma coalizão
vencedora e forçar um acordo imediato lucrativo. Esse desvio pode destruir o
papel de “atrasador”, mesmo quando todos reconhecem a identidade do proponente.
Ainda pode existir assimetria na **composição da coalizão**: propostas puras
podem escolher países fracos diferentes para formar a maioria, e sorteios entre
coalizões payoff-equivalentes constituem outra fonte de multiplicidade.

Sob unanimidade, o proponente não pode contornar `H`. Respostas e crenças
condicionadas à identidade do proponente podem, por isso, sustentar papéis que
não sobrevivem sob maioria. Essa diferença é uma hipótese a ser examinada nos
objetos formais pertinentes; não autoriza importar resultados de
Baron–Ferejohn nem presumir que toda assimetria por identidade sobreviva.

## 5. Fragilidade e robustez das convenções por rótulo

Se estratégias e crenças fossem obrigadas a ser anônimas, convenções baseadas
apenas no rótulo público do proponente provavelmente desapareceriam, salvo em
fronteiras de indiferença. No entanto, o contrato vigente não impõe anonimato
nem simetria. Acrescentar qualquer dessas condições seria uma seleção ou
restrição adicional do espaço de avaliações, e não uma consequência silenciosa
das primitivas.

Por isso, a Fase A deve classificar separadamente equilíbrios simétricos e
assimétricos por identidade quando existirem. A eventual decisão de privilegiar
um subconjunto por robustez, interpretação ou exposição pertence ao gate
autoral entre as Fases A e B.

## 6. Decisões autorais já tomadas

As seguintes decisões governam esta Fase A:

- os registros não serão comparados automaticamente por produto cartesiano
  apenas porque o schema permite preservar correspondências completas;
- os benchmarks públicos serão resolvidos e revisados antes de qualquer
  comparação com o jogo de informação privada;
- haverá consulta obrigatória ao autor antes de cruzar registros ou calcular
  qualquer renda informacional;
- estratégias mistas do proponente entre acordo imediato e atraso não são,
  provisoriamente, uma prioridade substantiva de comparação;
- essa prioridade provisória não autoriza apagar nenhuma classe válida do
  artefato formal;
- `RI_M`, `RI_U` e `DeltaRI` não serão calculados na Fase A;
- `N7` permanecerá `pending` e `unfrozen` ao fim da Fase A.

## 7. Perguntas reservadas ao gate autoral

Depois de concluídos e revisados os benchmarks públicos, o relatório ao autor
deverá permitir uma decisão explícita sobre:

1. **Domínio:** a comparação substantiva deve se restringir a `m >= 3`, mantendo
   `m = 2` apenas como cobertura formal, ou deve apresentar ambos lado a lado?
2. **Puro versus misto:** devem-se comparar somente equilíbrios puros, também as
   misturas entre acordo e atraso, ou apenas seus envelopes de payoff e outcome?
3. **Simétrico versus assimétrico por identidade:** convenções puras por rótulo
   entram no objeto substantivo principal, numa análise de robustez ou apenas no
   registro de completude formal?
4. **Classes de outcome versus assessments:** comparações devem emparelhar
   avaliações completas ou colapsar diferenças que alteram apenas crenças fora
   do caminho, preservando separadamente diferenças de payoff e outcome?
5. **Envelopes e ordenação robusta versus seleção:** o resultado deve usar
   envelopes e afirmações válidas para toda a correspondência, ou o autor deseja
   autorizar uma regra de seleção específica? Nenhuma seleção será inferida na
   ausência dessa decisão.

## 8. Gate e condição de parada

A Fase A termina quando as correspondências dos benchmarks públicos tiverem
sido derivadas, classificadas, verificadas e submetidas ao mesmo hash por dois
revisores independentes read-only, um de desenho formal e outro de matemática e
teoria dos jogos, ambos com `PASS 0/0/0`.

Nesse ponto, o trabalho para. O autor recebe a matriz de famílias públicas, as
distinções de multiplicidade e as perguntas da Seção 7. Somente uma nova
autorização explícita poderá definir as comparações substantivamente relevantes
e abrir a Fase B. Até lá, não se cruzam registros públicos com `N6`, não se
calculam rendas, não se congela `N7`, não se abre o Goal 5 e não se toca no
manuscrito.
