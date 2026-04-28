# Parecer ao editor

**Recomendação: Reject, com incentivo a ressubmissão após revisão substancial.**

O paper tem uma ideia central promissora: consenso/unanimidade pode beneficiar o hegemon não apesar da inclusão obrigatória, mas justamente porque a inclusão obrigatória transforma informação privada em poder de barganha. A intuição é boa, a motivação é clara, e o exemplo simples no início ajuda bastante. O manuscrito também melhorou ao formular um resultado central mais nítido: sob a condição \(\alpha < \alpha^*(N,\beta)\), unanimidade domina maioria condicionalmente à formação da instituição, enquanto a vantagem da maioria opera pelo canal de entrada. Essa arquitetura — resultado condicional + margem de entrada + classificação institucional — é potencialmente publicável em um periódico forte de teoria formal.

Mas, no estado atual, eu não recomendaria publicação na **AJPS**. O problema não é falta de interesse. O problema é que a comparação institucional ainda depende de escolhas de modelagem fortes demais, algumas provas estão expostas de modo insuficiente para um journal top de teoria, e a conexão substantiva com organizações internacionais ainda parece mais ilustrativa do que teoricamente disciplinada.

---

## 1. Contribuição

A contribuição pretendida é clara: explicar por que um hegemon poderia preferir consenso/unanimidade a maioria. O mecanismo é que, sob maioria, weak states podem formar coalizões sem o hegemon; sob unanimidade, o hegemon é pivotal, e weak proposers precisam fazer ofertas sem observar o tipo do hegemon. Isso gera screening rent para o hegemon. O paper então mostra que, quando a instituição se forma sob unanimidade, o hegemon prefere unanimidade; maioria só vence quando torna a entrada viável onde unanimidade não torna.

Esse é um argumento interessante. Ele desloca a literatura de “consenso como restrição” ou “consenso como fachada para poder informal” para “consenso como tecnologia informacional de poder”. A diferença conceitual é real.

Ainda assim, a contribuição precisa ser apresentada com mais cautela. O paper frequentemente fala como se explicasse a preferência hegemônica por consenso em organizações como a WTO. Mas o modelo explica uma comparação muito específica: maioria simétrica, sem agenda control do hegemon, sem weighted voting, sem bargaining over institutional design, com entrada all-or-nothing, e com informação privada do hegemon sobre o valor comum da cooperação. Esse é um domínio bem mais estreito do que a linguagem do paper às vezes sugere.

---

## 2. Principal força do paper

A melhor parte do paper é a decomposição da escolha institucional.

O resultado central é elegante:

\[
U \succ M \quad \text{se } p \in \mathcal F_U,
\]

\[
M \succ U \quad \text{se } p \in \mathcal F_M \setminus \mathcal F_U,
\]

\[
U \sim M \quad \text{se } p \notin \mathcal F_M.
\]

Essa classificação é substantivamente forte porque separa dois canais:

1. **Canal distributivo/condicional:** unanimidade dá mais ao hegemon quando há entrada.
2. **Canal de viabilidade:** maioria pode ser melhor porque permite formação institucional onde unanimidade não permite.

Essa estrutura é clara e, se totalmente fechada, pode ser a espinha dorsal de um artigo bom. A Figura 4 também ajuda: mostra visualmente que a região em que unanimidade domina está aninhada na região de formação sob maioria, e que a maioria domina apenas na margem de entrada.

---

## 3. Problema maior: a comparação com maioria ainda é muito favorável ao resultado

O paper diz que está comparando consenso com majority rule. Mas a majority rule do modelo é uma maioria com proposal rights simétricos, sem agenda power do hegemon, sem voto ponderado, sem capacidade de o hegemon estruturar a coalizão, e em que weak states podem simplesmente bypass o hegemon. Isso torna a maioria uma alternativa institucional fraca para o ator poderoso.

Isso cria uma tensão com a motivação. A introdução pergunta por que um ator poderoso não escolheria maioria para “impor” sua preferência. Mas o modelo de maioria não dá ao hegemon esse poder. Pelo contrário: sob maioria, o hegemon é frequentemente excluído. Assim, a comparação efetiva não é:

> unanimidade versus maioria como instrumento de poder hegemônico.

É mais precisamente:

> unanimidade com hegemon pivotal versus maioria simétrica na qual weak states podem excluir o hegemon.

Isso ainda é uma comparação interessante, mas é menos ambiciosa do que o framing sugere.

Para AJPS, eu exigiria uma das duas soluções:

1. **Reformular a pergunta** para deixar claro que o paper compara unanimidade com uma regra majoritária simétrica, não com majority rule sob hegemonic agenda control.
2. **Adicionar uma extensão** com recognition probability assimétrica, weighted majority, ou alguma forma reduzida de agenda influence do hegemon.

Sem isso, a crítica previsível é: o paper mostra que consenso pode ser melhor que uma forma de maioria que, por construção, priva o hegemon de sua vantagem política.

---

## 4. Problema maior: entrada all-or-nothing faz muito trabalho

A entrada é simultânea, simétrica e all-or-nothing: a instituição se forma se e somente se todos os weak states entram. Além disso, o hegemon escolhe a regra antes, e os weak states apenas decidem entrar ou não.

Essa estrutura é analiticamente limpa, mas substantivamente forte. Ela elimina várias possibilidades relevantes:

- weak states poderiam negociar a regra institucional;
- weak states poderiam recusar unanimidade e demandar maioria;
- entrada parcial poderia ocorrer;
- alguns weak states poderiam entrar enquanto outros ficam fora;
- o hegemon poderia escolher \(N\) estrategicamente;
- coalizões alternativas poderiam formar uma instituição majoritária rival.

O paper reconhece que all-or-nothing é uma simplificação, mas não resolve o problema central: a vantagem institucional do hegemon depende do fato de weak states não terem uma outside option institucional. O texto diz que, se recusarem unanimidade, eles não recebem maioria; recebem nenhuma instituição. Isso é coerente dentro do modelo, mas é uma hipótese substantiva muito pesada para um argumento sobre institutional design.

Para uma revista como AJPS, isso precisa ser defendido melhor. O paper deveria explicar para quais organizações essa tecnologia de entrada é plausível e para quais não é.

---

## 5. Problemas formais que precisam ser resolvidos antes de publicação

### 5.1 Proposition 1 está subprovada

A Proposição 1 afirma que, sob maioria, não há screening e o valor esperado do hegemon é afim em \(\mu\). A prova no apêndice, pelo trecho disponível, é basicamente verbal: weak states podem excluir \(H\), logo \(H\) recebe \(\alpha V(\theta)\), logo não há screening.

Isso é insuficiente para AJPS. O paper precisa derivar explicitamente o PBE sob maioria:

- valores de continuação em R2;
- ofertas ótimas de \(H\) e de \(W\);
- quais coalizões são compradas;
- por que \(H\) recebe exatamente sua outside option quando excluído;
- como a seleção de proposer afeta o payoff esperado de \(H\);
- por que nenhuma crença posterior altera a composição da coalizão vencedora.

A proposição provavelmente está correta, mas a prova precisa ser uma derivação, não uma intuição.

### 5.2 Proposition 2 precisa de uma prova completa de existência e unicidade

A Proposição 2 afirma existência e unicidade de um cutoff de screening em R1, com closed form quando \(\alpha < \bar\alpha(r,\beta,N)\). O resultado é central, mas a prova é remetida à derivação no Apêndice A.3.

Para um journal top, isso é frágil. Uma derivação algébrica do cutoff não substitui uma prova de unicidade global. O paper precisa mostrar explicitamente:

- qual é a função de diferença entre oferta agressiva e conservadora;
- em quais branches ela é válida;
- por que ela cruza zero exatamente uma vez;
- como o argumento muda quando \(\alpha \geq \bar\alpha\);
- o que acontece nos pontos de fronteira entre branches R2.

A nota de rodapé dizendo que o cutoff “remains unique” fora do regime \(\alpha < \bar\alpha\) não é suficiente. Isso deve estar no enunciado ou em uma proposição separada.

### 5.3 Theorem 1 é promissor, mas a prova ainda precisa ser mais auditável

O Theorem 1 é o resultado mais importante: \(\alpha < \alpha^*(N,\beta)\) se e somente se unanimidade dá payoff condicional maior ao hegemon para todo \(\mu \in (0,1]\).

Esse é o tipo de resultado que pode sustentar o paper. Mas, para AJPS, a prova precisa ser apresentada de modo que o leitor consiga auditar a lógica sem confiar em “endpoint argument” genérico.

O texto diz que o caso apertado é \(\mu=1\), onde não há screening rent. A intuição é boa. Mas a prova deve explicitar:

- a expressão fechada de \(D(\mu)=E[V_H(\mu,U)]-E[V_H(\mu,M)]\) em cada branch;
- por que cada branch é afim ou tem sinal determinado;
- por que positividade nos endpoints implica positividade global;
- por que os pontos de junção não criam lacunas;
- por que o argumento cobre tanto o regime \(\alpha < \bar\alpha\) quanto \(\alpha \geq \bar\alpha\);
- por que a desigualdade é estrita em \((0,1]\) quando \(\alpha < \alpha^*\).

O paper está perto de ter isso, mas a exposição ainda exige confiança excessiva do leitor.

### 5.4 A prova de \(\mathcal F_U \subseteq \mathcal F_M\) precisa ser blindada

A inclusão \(\mathcal F_U \subseteq \mathcal F_M\) é fundamental. Sem ela, a classificação institucional não fecha.

O texto afirma que, como o payoff do hegemon é maior sob unanimidade, o payoff agregado dos weak states é menor; logo a entrada é mais difícil sob unanimidade. Isso depende de uma lógica de budget balance. Mas, em um jogo com rejeição, desconto e possíveis diferenças na probabilidade de acordo em cada branch, essa inferência não é automaticamente verdadeira. O apêndice parece tentar provar diretamente que o payoff de \(W\) sob unanimidade é menor que sob maioria e que, se há entrada sob unanimidade em algum \(\mu'\), então \(1 \in \mathcal F_U\).

Isso é bom, mas o corpo do texto ainda está excessivamente informal. A inclusão \(\mathcal F_U \subseteq \mathcal F_M\) deveria ser uma proposição própria, com uma prova curta no corpo ou um enunciado formal antes do corolário.

### 5.5 Proposition 4 tem uma inferência problemática no caso ii

No caso \(p \in \mathcal F_M \setminus \mathcal F_U\), o paper afirma que majority dominates porque a instituição forma sob maioria mas não sob unanimidade. A prova diz que, sob maioria, o payoff institucional do hegemon excede a outside option “since entry is individually rational for weak states”.

Essa inferência não é logicamente válida como escrita. O fato de a entrada ser racional para weak states não implica, por si só, que o hegemon recebe mais que sua outside option. É possível, em princípio, que todo o ganho institucional incremental vá para weak states e que \(H\) receba apenas sua outside option. Talvez no modelo, devido à probabilidade de \(H\) propor ou ao desenho das ofertas, \(H\) de fato receba estritamente mais. Mas isso precisa ser provado diretamente.

A correção é simples: substituir essa frase por uma derivação explícita de

\[
E[V_H^{R1}(\theta,p,M)] - \alpha V_e(p) > 0
\]

para todos os \(p \in \mathcal F_M\), ou qualificar o resultado se a desigualdade puder falhar em algum limite.

---

## 6. Problemas substantivos de interpretação

### 6.1 WTO/GATT ainda funciona mais como ilustração do que como evidência

A seção sobre GATT/WTO é plausível, mas ainda não faz muito trabalho inferencial. O texto diz que consenso, Green Room, drafting control e capacidade técnica são compatíveis com o mecanismo. Isso é correto, mas compatibilidade não é evidência forte.

A melhor parte da seção é a predição de que consenso deve ser menos provável onde as stakes distributivas são transparentes, como em instituições financeiras, e mais provável onde os ganhos são difíceis de avaliar ex ante, como regulação e standard-setting. Essa é uma implicação observável promissora. Mas ela aparece tarde e sem disciplina empírica suficiente.

Eu sugeriria mover essa predição para mais perto da introdução e usá-la para diferenciar claramente o mecanismo de três alternativas:

- legitimidade;
- self-binding;
- informal power.

### 6.2 O claim sobre financial organizations pode estar overextended

O paper sugere que organizações financeiras usam weighted majority porque os ganhos distributivos são transparentes e, portanto, screening rents desaparecem. Isso é interessante, mas forte. Instituições financeiras também são precisamente o domínio em que poder material e contribuições de capital são mais fáceis de traduzir em votos ponderados. Portanto, weighted voting pode decorrer diretamente da estrutura de contribuição, não da ausência de informational rents.

A predição não está errada, mas o mecanismo concorrente é óbvio. O paper precisa reconhecer isso.

### 6.3 A distinção consenso/unanimidade ainda merece mais cuidado

O paper modela consenso como unanimidade com ação binária accept/reject. Isso é aceitável como abstração, mas a equivalência não é substantivamente neutra. Em muitas organizações, consenso envolve agenda control, silence procedures, informal pressure, chair discretion e antecipação de objeções. Essas instituições podem gerar poder de agenda justamente dentro do consenso.

A solução não é abandonar o modelo. É dizer com mais precisão: o paper modela o componente veto/pivotality do consenso, não o conjunto completo de práticas consensuais.

---

## 7. Comentários de apresentação

A estrutura atual é boa: puzzle → exemplo → modelo → maioria → unanimidade → entrada → escolha institucional → discussão. O exemplo simples é útil e deve permanecer.

Mas o paper ainda tem três problemas de apresentação:

1. **O texto promete mais do que o modelo entrega.** Reduza claims amplos sobre “why consensus persists” e enfatize “one mechanism under identifiable conditions”.
2. **Os resultados formais precisam aparecer com mais fórmulas no corpo.** Especialmente Proposition 1, Theorem 1 e a inclusão \(\mathcal F_U \subseteq \mathcal F_M\).
3. **Appendix C deve ser rebaixado retoricamente.** O texto às vezes sugere que o modelo com tipos contínuos reforça a robustez, mas o próprio apêndice reconhece que dominância para \(K \geq 3\) não está estabelecida em geral.

---

## 8. Veredito

Este é um paper com um mecanismo original e potencialmente importante, mas ainda não está pronto para AJPS.

Minha recomendação é **Reject** em vez de **R&R** porque as revisões necessárias não são apenas expositivas. O autor precisa:

1. redefinir com mais precisão a comparação institucional;
2. fortalecer a defesa da entrada all-or-nothing;
3. completar a derivação formal sob maioria;
4. tornar a prova do Theorem 1 completamente auditável;
5. blindar a prova de \(\mathcal F_U \subseteq \mathcal F_M\);
6. corrigir a inferência no caso ii da Proposition 4;
7. disciplinar melhor as implicações empíricas.

Eu veria uma nova versão com interesse. O core insight é forte. Mas, na forma atual, um parecerista de teoria formal da AJPS provavelmente concluiria que a ideia é promissora, mas que o manuscrito ainda depende de uma comparação institucional muito favorável ao resultado e de provas que não estão expostas com rigor suficiente para publicação.
