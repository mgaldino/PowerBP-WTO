# Parecer de Contribution (Framework Edmans)

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"  
**Autor**: Manoel Galdino (University of Sao Paulo)  
**Versao**: formal_model_v3.Rmd  
**Data do parecer**: 2026-04-25  
**Avaliador**: Editor simulado (APSR/AJPS/JoP/IO/BJPS)

---

## Score: 7.0 / 10

---

## Resumo da contribuicao alegada

O paper propoe que o consenso (unanimidade) pode ser uma tecnologia de poder hegemonico, e nao uma concessao. O mecanismo central e que, sob unanimidade, estados fracos devem incluir o hegemon em toda proposta, o que gera um problema de screening (porque nao conhecem o tipo do hegemon). Esse screening cria uma nao-convexidade no payoff do hegemon que Bayesian Persuasion pode explorar. Sob maioria, estados fracos excluem o hegemon da coalizao, eliminando o screening. A comparacao institucional se reduz a um trade-off entre vantagem condicional de screening (unanimidade) e condicoes de entrada mais faceis (maioria), com um threshold unico que separa as regioes de dominancia.

---

## Avaliacao por dimensao

### Novidade [Forte]

O resultado principal e genuinamente novo e nao-trivial. A literatura existente sobre consenso em organizacoes internacionais oferece duas narrativas: (1) consenso como auto-restricao do hegemon (Keohane, Ikenberry), ou (2) consenso como fachada para poder informal (Steinberg, Stone). Nenhuma oferece uma razao distributiva para o hegemon preferir unanimidade. O paper identifica um terceiro canal --- poder informacional amplificado por screening --- que e logicamente distinto dos anteriores.

A combinacao de Baron-Ferejohn bargaining com Bayesian Persuasion nao e trivial nem previsivel. A literatura de BP em politica (Schnakenberg 2015/2017, Alonso e Camara 2016) nao examina a interacao com voting rules em barganha legislativa. Bardhi e Guo (2018) analisam BP com unanimidade, e Kim, Kim e Van Weelden (2025) examinam BP em barganha bilateral com veto, mas nenhum oferece a comparacao institucional entre regras de votacao que e central aqui. O paper ocupa, portanto, um nicho genuino.

O insight de que unanimidade gera nao-convexidade exploravel por BP enquanto maioria produz linearidade e elegante e nao-obvio. Um leitor informado atualizaria significativamente suas crencas: antes da leitura, a intuicao padrao e que unanimidade constrange o hegemon; apos a leitura, entende-se que pode ser o oposto sob condicoes especificas.

Ponto de atencao: o resultado depende criticamente de tipos discretos. O proprio autor reconhece (Conclusao) que com tipos continuos, o schedule de ofertas seria genericamente smooth, eliminando os jumps discretos. Isso limita a novidade a uma classe de modelos, nao a um principio geral.

### Importancia [Adequada]

O resultado e relevante para uma questao central em RI e design institucional: por que potencias aceitam regras que aparentemente limitam seu poder? Essa e uma questao de primeira ordem (Koremenos, Lipson e Snidal 2001).

A aplicacao ao GATT/WTO e pertinente e bem desenvolvida: a transicao historica de maioria formal para consenso na pratica, a coincidencia temporal com a expansao de membros (e aumento da assimetria informacional), e a previsao de que o mecanismo deveria ser mais forte em areas regulatorias complexas (servicos, propriedade intelectual) do que em cortes tarifarios lineares. As implicacoes observaveis sao especificas o suficiente para distinguir o mecanismo de explicacoes alternativas.

No entanto, o resultado nao muda fundamentalmente como entendemos instituicoes internacionais. E uma explicacao adicional --- elegante e rigorosa --- mas complementar as existentes, nao substitutiva. Um survey da area citaria este resultado, mas provavelmente como um mecanismo entre varios, nao como a explicacao central. Um policymaker ou negociador dificilmente mudaria decisoes com base nele, embora o paper ofereca um framework util para pensar sobre o valor estrategico da informacao em negociacoes multilaterais.

O paper seria mais impactante se demonstrasse empiricamente (ou ao menos com dados estilizados) que o mecanismo tem bite quantitativo. O worked example (N=5, r=1.5, alpha=0.3, beta=0.9) mostra um screening rent de ~5.3% do surplus esperado --- nao e trivial, mas tambem nao e transformador. A ausencia de qualquer calibracao ou teste empirico limita a avaliacao de importancia pratica.

### Adequacao ao escopo [Adequada]

A bibliografia e predominantemente de CP e RI: Baron e Ferejohn (barganha legislativa), Koremenos/Lipson/Snidal (design racional de IOs), Steinberg (consenso na OMC), Maggi e Morelli (self-enforcement), Kamenica e Gentzkow (BP). As referencias a economia (Bayesian persuasion) sao naturais e necessarias dado o ferramental.

Para o JoP, o paper esta bem posicionado: e teoria formal aplicada a uma questao de design institucional em RI, com estilo similar a Hirsch (2023), Hill (2022) e Tyson et al. (2024) --- corpo narrativo, provas no appendix. Para IO, a aplicacao OMC e diretamente relevante. Para APSR/AJPS, a generalizacao seria um desafio --- o modelo e bastante especifico ao contexto de IOs com assimetria informacional.

O paper e de interesse para teoricos formais em CP e para scholars de organizacoes internacionais, mas provavelmente nao para a audiencia geral de um top journal generalista. O escopo e mais adequado a um journal de campo (JoP, IO) do que a um generalista (APSR, AJPS).

### Generalizabilidade [Adequada]

O modelo e formalmente geral (N jogadores, parametros livres), nao um estudo de caso. As comparative statics sao informativas: alpha* diminui com N (unanimidade mais cara em organizacoes grandes), o mecanismo e mais forte com r alto (informacao mais consequente) e beta alto (mais paciencia).

A aplicabilidade para alem do GATT/WTO e discutida: PTAs, Conselho de Seguranca da ONU, e qualquer IO com assimetria informacional e votacao por consenso. A previsao de que o mecanismo deveria ser mais fraco em organizacoes novas (onde entry e o binding constraint) e mais forte em organizacoes maduras e testavel cross-sectionally.

Limitacoes de generalizabilidade:
1. **Tipos discretos**: O mecanismo depende de jumps discretos. Com tipos continuos, desaparece (reconhecido pelo autor).
2. **Informacao unilateral**: Somente H tem informacao privada. Se W tambem tivesse informacao privada (o que e realista), a analise muda substancialmente.
3. **Pie exogeno**: V(theta) e dado pela natureza. Em muitos contextos de IO, o valor da cooperacao e parcialmente endogeno (negociacoes moldam o que sera acordado).
4. **Commitment**: BP requer commitment do hegemon a uma estrutura de sinais. Embora o autor discuta tres razoes para plausibilidade (reputacao, regras de transparencia, upper bound), e uma suposicao forte.

### Trade-offs [Parcial]

O paper identifica um trade-off central: screening advantage (unanimidade) vs. easier entry (maioria). Isso esta bem desenvolvido --- o Theorem 2 formaliza a single-crossing property que separa as regioes.

No entanto, ha custos da unanimidade que nao sao totalmente explorados:

1. **Custos de transacao**: Unanimidade com N=164 (WTO) e operacionalmente cara. O modelo abstracts away completamente dos custos de negociacao multilateral com muitos veto players.
2. **Holdout e extorsao**: Com unanimidade, cada membro e um veto player. O modelo assume tipos binarios, mas na realidade, membros podem usar o veto estrategicamente para extrair side-payments --- um custo de unanimidade bem documentado na literatura.
3. **Status quo bias**: Unanimidade gera paralisia decisoria (Tsebelis 2002), que pode ser custosa para o hegemon se prefere mudanca.
4. **Welfare**: O paper e inteiramente do ponto de vista de H. Uma analise de welfare (eficiencia agregada) esta ausente. E possivel que unanimidade seja Pareto inferior?

O paper reconhece que "unanimity leaves less surplus for weak states, making entry harder" --- o trade-off para W esta parcialmente documentado. Mas nao ha uma discussao sistematica dos custos alem do entry margin.

### Hipoteses [Claras e direcionais]

As hipoteses sao claras, direcionais e baseadas em teoria:

1. **Lemma 1**: alpha < alpha* sse unanimidade domina condicionalmente (bicondicional --- forte).
2. **Theorem 1**: Para todo prior no entry set de unanimidade, unanimidade domina (dominancia pointwise).
3. **Theorem 2**: Single-crossing --- existe p* tal que unanimidade domina acima, maioria abaixo.

As comparative statics sao derivadas, nao assumidas:
- Mecanismo mais forte com r alto (informacao mais consequente).
- Mecanismo mais forte com beta alto (mais paciencia).
- alpha* decresce com N (unanimidade mais cara em organizacoes grandes).

As implicacoes observaveis na Secao 8 sao direcionais e especificas:
- Consenso mais valioso em areas regulatorias complexas (alta assimetria informacional).
- Preferencia por consenso enfraquece com proliferacao de PTAs (aumento de alpha).
- Consenso emerge em regimes maduros, nao em regimes novos.
- Consenso mais valioso em negociacoes com horizonte temporal longo.

Este e um dos pontos fortes do paper: o modelo gera previsoes especificas e testaveis que distinguem o mecanismo proposto de explicacoes alternativas.

---

## Veredicto geral sobre contribution

O paper apresenta uma contribuicao solida e genuinamente nova para a teoria de design institucional em organizacoes internacionais. O mecanismo --- unanimidade como tecnologia de poder informacional, nao como concessao --- e elegante, bem formalizado e nao-obvio. A combinacao de Baron-Ferejohn bargaining com Bayesian Persuasion sob diferentes regras de votacao e original e produz insights que nenhuma das duas literaturas oferece isoladamente.

A principal forca do paper e a clareza do mecanismo e a capacidade de gerar previsoes testaveis e especificas. A principal fraqueza e a dependencia de tipos discretos (sem os quais o mecanismo desaparece) e a ausencia de qualquer evidencia --- mesmo estilizada --- de que o mecanismo tem relevancia quantitativa. O paper opera inteiramente no plano da possibilidade logica ("quando pode um hegemon preferir consenso?") sem estabelecer a relevancia empirica do mecanismo. Para um top journal, isso e um risco: o leitor termina convencido de que o mecanismo existe, mas nao de que importa.

A adequacao ao escopo e boa para JoP ou IO, mais questionavel para APSR/AJPS. O estilo "light math" com provas no appendix esta bem executado para o publico-alvo. Os trade-offs estao parcialmente documentados --- o entry margin esta formalizado, mas outros custos de unanimidade (holdout, paralisia, custos de transacao) sao omitidos.

No quadro Edmans, a contribuicao e uma ideia genuinamente nova (Novidade Forte) aplicada a uma questao importante mas com impacto incremental sobre o entendimento geral (Importancia Adequada). Para publicacao em um top journal de campo (JoP, IO), o paper esta proximo do threshold. Para um generalista (APSR), seria necessario fortalecer substancialmente a motivacao empirica ou generalizar o mecanismo para alem de tipos discretos.

---

## Sugestoes construtivas

1. **Worked example com calibracao**: O exemplo numerico (N=5, r=1.5, alpha=0.3) e util mas arbitrario. Uma calibracao informal ao GATT/WTO --- com N=23 (membros originais), N=164 (WTO atual), e valores de r e alpha informados pela literatura empirica sobre ganhos de comercio e outside options bilaterais --- tornaria o mecanismo mais convincente. Quanto screening rent (em % do surplus) o modelo preve para parametros empiricamente plausiveis?

2. **Discutir robustez a tipos continuos de forma mais substantiva**: A nota na Conclusao de que tipos continuos eliminam o mecanismo e honesta mas potencialmente fatal para um referee cético. Vale explorar: (a) com tipos quasi-discretos (distribuicao concentrada em dois pontos com pequeno spread), o mecanismo sobrevive aproximadamente? (b) Com K tipos (Appendix C), o mecanismo se fortalece ou enfraquece? Se K -> infinito reproduz tipos continuos, em que velocidade o mecanismo desaparece? Isso daria ao leitor uma ideia de quao robusto e o resultado.

3. **Incluir uma discussao explicita de welfare**: O paper e inteiramente sobre a preferencia de H. Mas o leitor natural de IO ou JoP quer saber: unanimidade e socialmente eficiente ou apenas distributivamente favoravel a H? Se unanimidade gera surplus destruction (via aggressive offers que falham), pode ser Pareto inferior a maioria. Isso nao invalida o resultado, mas muda a interpretacao normativa --- e editores se importam com normative implications.

4. **Confrontar mais diretamente a critica de commitment**: A suposicao de BP commitment e a vulnerabilidade mais obvia. Em vez de tres paragrafos de defesa geral, considere: (a) resolver o modelo sem commitment (cheap talk) e mostrar que o screening advantage persiste mesmo sem BP; (b) ou mostrar que sob commitment parcial (verifiable disclosure / evidence game), a comparacao institucional se mantem qualitativamente. Isso reduziria a dependencia da suposicao mais forte do modelo.

5. **Fortalecer a comparacao com explicacoes alternativas**: A Secao 8 menciona legitimidade, self-enforcement e issue linkage em um paragrafo. Uma tabela comparativa sistematica --- mecanismo, previsao central, previsao diferencial --- permitiria ao leitor avaliar onde cada teoria falha e este paper acerta. As cinco implicacoes observaveis ja estao la, mas nao estao organizadas como teste discriminante contra alternativas especificas.

6. **Abordar holdout e extorsao**: Um referee de RI/IO ira perguntar imediatamente por que o modelo nao inclui a possibilidade de veto estrategico por W. Com unanimidade, qualquer W pode ameacar vetar para extrair side-payments. O modelo assume que W so escolhe entre aggressive e conservative offers, mas na realidade, unanimidade cria oportunidades de extorsao bilateral que podem neutralizar o screening advantage. Uma discussao de por que holdout nao e modelado --- e se o incluiria mudaria os resultados --- fortaleceria o paper.

7. **Considerar a tensao entre N grande e o mecanismo**: O paper nota que alpha* decresce com N e que V_W ~ O(1/N). Para N=164, alpha* e muito pequeno. O footnote sobre c = c_tilde/N e uma solucao parcial, mas a tensao permanece: para o caso empiricamente mais saliente (WTO com 164 membros), o mecanismo opera em uma faixa parametrica estreita. Seria util ser explicito sobre isso: o mecanismo e mais relevante para organizacoes de tamanho moderado (5-30 membros) ou tambem para organizacoes grandes? Se a resposta e "moderado", a aplicacao ao WTO fica mais fragil, mas o paper ganha aplicacoes a PTAs, blocos regionais, Conselho de Seguranca, etc.
