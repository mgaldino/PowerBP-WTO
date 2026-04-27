# Parecer de Execution (Framework Edmans) -- formal_model_v5.Rmd

**Data**: 2026-04-27
**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: v5 (formal_model_v5.Rmd)
**Avaliador**: Edmans Execution Framework, adaptado para CP

---

## Score: 7.5 / 10
## Tipo de paper: Teorico

---

## Resumo da estrategia

O paper desenvolve um modelo formal de escolha institucional em que um hegemon com informacao privada sobre o valor da cooperacao multilateral escolhe entre unanimidade e maioria como regra de votacao. A estrategia de execucao e puramente dedutiva: premissas sobre a estrutura de barganha (Baron-Ferejohn, 2 rounds, proposta aleatoria, tipo binario) levam, por backward induction, a resultados sobre screening sob unanimidade, linearidade sob maioria, e um teorema de dominancia condicional. A comparacao institucional e reduzida a duas forcas: vantagem de screening (favorece unanimidade) versus viabilidade de entrada (favorece maioria).

---

## Principio "Dados vs. Evidencia"

Em papers teoricos, o analogo do principio "dados nao sao evidencia" e: **premissas nao sao resultados**. Premissas que garantem o resultado por construcao nao constituem demonstracao de um mecanismo -- elas apenas o descrevem. A questao central e se as conclusoes do modelo sao logicamente distantes das premissas, ou se as premissas ja carregam o resultado.

No presente caso, o paper produz resultados nao-triviais a partir das premissas. O screening cutoff, sua independencia de alpha (quando alpha < alpha_bar), a forma fechada do jump, a decomposicao aditiva D_base + delta_R1 + delta_R2, e a bicondicionalidade de alpha* sao derivacoes genuinas que nao sao obvias a partir da especificacao do modelo. A passagem premissas-conclusoes e substantiva.

Entretanto, ha um aspecto em que as premissas fazem trabalho pesado: a escolha de tipos binarios (K=2) e central para que o screening gere um unico cutoff limpo e que a dominancia condicional seja global. O proprio paper reconhece isso (Appendix C, Conclusion), mas a tensao merece destaque: o resultado principal (Theorem 1) e um resultado do caso K=2, e o paper nao pode afirmar que o mecanismo escala para ambientes mais ricos sem qualificacao substantiva. Esse reconhecimento honesto e um ponto a favor da execucao.

---

## Avaliacao por dimensao

### T.1 Distancia premissas-conclusoes (nao esta assumindo o resultado?)

**Rating: 7.5/10**

A questao critica e: as premissas do modelo ja determinam que unanimidade domina, ou o resultado emerge de interacoes nao-obvias?

**Pontos fortes:**
- A premissa central -- tipo binario + unanimidade torna H pivotal -- nao implica automaticamente que unanimidade domina. Sob unanimidade, H tambem paga mais para comprar votos (N-1 vs q-1). A dominancia condicional depende de que o screening rent supere esse custo adicional, e o threshold alpha* que separa os dois regimes e derivado, nao assumido.
- A decomposicao aditiva (B.5a) e um resultado tecnico genuino: a independencia entre as correcoes R1 e R2 nao e obvia a priori e depende de propriedades estruturais do Baron-Ferejohn (identidade do proposer separa os canais).
- A bicondicionalidade de alpha* (Step 4 da prova do Theorem 1) mostra que o resultado e afiado: a condicao e necessaria E suficiente, nao apenas suficiente.

**Preocupacoes:**
- A assimetria informacional e perfeitamente unilateral: H sabe theta com certeza, W nao sabe nada. Em equacoes, isso e `H observa theta; W hold prior p`. Isso maximiza o screening rent por construcao. Nao ha nenhum grau de informacao parcial de W. A questao e: o que acontece se W tem um sinal ruidoso sobre theta? O paper nao aborda sinais intermediarios.
- A opcao exterior do hegemon e d_H = alpha * V(theta), proporcional ao valor da cooperacao. Isso e funcional para o modelo, mas tambem garante que a opcao exterior seja mais valiosa quando theta=1, maximizando a tensao no screening problem. Se d_H fosse constante (d_H = d), o screening desapareceria? Provavelmente nao inteiramente, mas a magnitude seria diferente. O paper nao discute a sensibilidade a essa forma funcional.
- A entrada e all-or-nothing e simultanea. Isso elimina hold-out e renegociacao, simplificando enormemente a analise. A footnote reconhece, mas nao aborda o que aconteceria com entrada sequencial ou parcial.

**Veredicto T.1**: O resultado nao e trivialmente embutido nas premissas. A distancia e real, especialmente na decomposicao e na bicondicionalidade. Mas a arquitetura do modelo (K=2, informacao perfeitamente unilateral, entrada all-or-nothing) e talhada para maximizar a nitidez do resultado. Dentro dessas premissas, a execucao e limpa.

---

### T.2 Parcimonia (mecanismos claros?)

**Rating: 8.5/10**

**Pontos fortes:**
- O mecanismo central e extraordinariamente limpo: unanimidade forca screening porque H e pivotal; maioria elimina screening porque H nao e pivotal. Essa assimetria e capturada em uma unica variavel: se H e necessario para a coalizao ou nao.
- O modelo isola o efeito da regra de votacao mantendo tudo mais constante (proposta aleatoria, mesmos payoffs, mesmo discount factor). A comparacao e justa.
- O paper define cuidadosamente o que o modelo NAO faz: nao modela agenda informal, nao modela repeticao, nao modela T>2 rounds. A parcimonia e consciente.
- A reducao da comparacao institucional a {F_U, F_M \ F_U, complemento de F_M} e elegante e transparente.

**Preocupacao menor:**
- A restricao alpha < 1/r e necessaria para garantir que d_H < V(theta) para todo theta, mas na pratica essa restricao e muito frouxa (para r=1.5, alpha < 0.67). A restricao que realmente morde e alpha < alpha*, que para N grande fica muito apertada. Isso levanta a questao de se o modelo e parcimonioso o suficiente para gerar previsoes empiricas com bite em organizacoes grandes. O paper aborda isso honestamente (Scope section), o que e bom.

**Veredicto T.2**: Mecanismo limpo, isolamento adequado, premissas justificadas. A parcimonia e um dos pontos fortes do paper.

---

### T.3 Caminho causal (variaveis endogenas no path estao livres?)

**Rating: 6.5/10**

Este e o ponto mais vulneravel da execucao.

**Preocupacoes substanciais:**

1. **Endogeneidade da regra de votacao ao nivel de informacao assimetrica.** O modelo trata a informacao privada de H como exogena e a regra de votacao como escolha otima dado esse ambiente informacional. Mas em equilibrio, a regra de votacao pode afetar os incentivos de W para adquirir informacao. Se W sabe que unanimidade sera escolhida, W tem incentivos para investir em inteligencia sobre theta -- precisamente porque o screening e custoso. O paper menciona isso como "paper futuro" (erosao endogena), mas nao aborda como esse canal retroativo afeta a validade do resultado presente. A questao nao e apenas "o que acontece no longo prazo", mas "o equilíbrio do modelo de um jogo e consistente com a premissa de que W nao sabe nada sobre theta?"

2. **Endogeneidade da entrada ao mecanismo.** O modelo assume que W entra se V_W >= c, onde c e exogeno. Mas o custo de entrada pode depender da regra de votacao (lobbying, preparacao de delegacoes sob unanimidade vs maioria pode ter custos diferentes). Se c_U > c_M, a vantagem de maioria no canal de entrada se amplifica. O paper trata c como uniforme entre regras.

3. **Alpha como exogeno.** A forca da opcao exterior bilateral (alpha) e tratada como parametro exogeno. Mas alpha e plausivelmente endogeno a acao de H: H pode investir em alternativas bilaterais (PTAs, por exemplo) para fortalecer sua posicao. Se H escolhe alpha antes de escolher R, o jogo muda substancialmente. O Scope menciona PTAs (Bhagwati), mas nao modela essa endogeneidade.

4. **N como exogeno.** O numero de membros e parametro do modelo. Mas H escolhe a regra de votacao -- por que nao escolhe tambem N? Se H pode escolher N (quantos estados convidar), o problema se torna bidimensional (N, R), e o tradeoff pode mudar. O paper menciona "N is the size of the institution the hegemon proposes to create" mas nao modela essa escolha.

**Pontos atenuantes:**
- Nenhuma dessas endogeneidades invalida o mecanismo dentro do modelo. A questao e de escopo, nao de erro logico.
- O paper e honesto sobre limitacoes (Scope, Conclusion, footnotes).
- Para um paper de teoria pura no JoP, tratar essas variaveis como exogenas e aceitavel se o autor sinaliza consciencia -- o que este paper faz.

**Veredicto T.3**: O caminho causal interno ao modelo e limpo (backward induction, sem circularidade). Mas variaveis tratadas como exogenas (informacao de W, custo de entrada, alpha, N) sao plausivelmente endogenas ao mecanismo, e a discussao dessas endogeneidades e superficial. Isso nao e um erro formal, mas limita a forca do argumento como teoria institucional.

---

## Veredicto geral sobre execution

A execucao tecnica do paper e solida. O mecanismo central -- screening sob unanimidade, ausencia de screening sob maioria -- e derivado rigorosamente a partir de premissas explicitas, com resultados de forma fechada, uma bicondicionalidade que afia o resultado principal, e uma decomposicao algébrica que isola os canais de forma transparente. O modelo e parcimonioso: mantem constante tudo exceto a regra de votacao e deixa o screening emergir da interacao entre assimetria informacional e pivotalidade. A distancia entre premissas e conclusoes e real, nao trivial.

As fragilidades concentram-se em duas areas. Primeiro, a arquitetura do modelo (tipos binarios, informacao perfeitamente unilateral, entrada all-or-nothing) e otimizada para produzir resultados limpos, e a generalizacao a ambientes mais ricos (K>2, sinais parciais, entrada parcial) e reconhecida mas nao resolvida. Segundo, e mais importante para a avaliacao de execution, varias variaveis no caminho causal (nivel de assimetria informacional, custo de entrada, forca da opcao exterior, tamanho da organizacao) sao plausivelmente endogenas ao mecanismo, e a discussao dessas endogeneidades e insuficiente para um paper que aspira a fazer afirmacoes sobre design institucional no mundo real. O mecanismo funciona perfeitamente dentro do modelo, mas a ponte entre o modelo e a aplicacao empirica (GATT/WTO) requer mais cuidado com a endogeneidade dos parametros tratados como exogenos.

O score de 7.5 reflete uma execucao tecnica forte (facilmente 8-8.5 no eixo puramente formal) penalizada por um caminho causal que, ao ser aplicado a fenomenos reais, deixa endogeneidades substantivas sem tratamento adequado.

---

## Sugestoes construtivas

1. **Sinal ruidoso de W sobre theta.** Adicionar um paragrafo na Discussion ou Scope sobre o que acontece se W recebe um sinal parcial sobre theta antes da entrada. Se W observa um sinal s com precisao q in (0.5, 1), o screening problem sobrevive mas o rent diminui. Discutir qualitativamente se o mecanismo e monotono na assimetria informacional ou se ha nao-monotonicidade. Isso nao requer formalizacao, mas a ausencia de qualquer discussao e uma lacuna.

2. **Endogeneidade da informacao.** Na Discussion, adicionar 2-3 frases reconhecendo que a escolha de unanimidade pode afetar os incentivos de W para adquirir informacao sobre theta, e que isso cria um jogo de dois estagios (escolha de regra -> investimento em informacao -> barganha) cujo equilibrio pode diferir do modelo presente. Mesmo sem resolver, sinalizar consciencia desta retroalimentacao fortaleceria a credibilidade.

3. **Heterogeneidade em c.** Se c_U != c_M (unanimidade e mais custosa em termos de preparacao), a fronteira F_U encolhe mais rapido. Uma nota de robustez qualitativa sobre essa possibilidade fortaleceria T.3.

4. **Alpha endogeno como extensao.** Ja mencionado na Discussion via PTAs, mas merece uma frase explicita: "If the hegemon can invest in strengthening its bilateral alternatives before choosing the voting rule, the interaction between alpha and R becomes a two-dimensional design problem that may alter the tradeoff identified here."

5. **Fortalecer o argumento K>2.** O Appendix C e honesto sobre limitacoes, mas a Conclusion poderia ser mais incisiva: distinguir claramente entre (a) o que esta provado (K=2), (b) o que generaliza sem qualificacao (maioria e linear para todo K), e (c) o que e conjectura (unanimidade domina para K>2 com parametros empiricos). Atualmente, a distincao existe mas poderia ser mais afiada.

6. **Robustez a T>2 rounds.** O paper argumenta que 2 rounds e suficiente e robusto, mas nao aborda o limite T -> infinito (Baron-Ferejohn padrao). Uma nota indicando se o screening cutoff converge ou diverge com T seria informativa, mesmo se informal.
