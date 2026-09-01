# Carta Editorial — Framework Edmans (Contribution, Execution, Exposition)

**Candidato avaliado:** `formal_model_v6.pdf`  
**Commit:** `611727865a9e0c6e9af142c84fcae4f2e18747df`  
**SHA-256 do PDF:** `146fee55cb063b645121f2a6802a85c58816c542a5474442691c0903af5fafc4`

## Decisão: Reject-and-Resubmit

## Scores consolidados

| Dimensão | Score | Rating |
|---|---:|---|
| Contribution | 6/10 | Adequada, mas ainda insuficientemente focalizada para top journal |
| Execution | 7/10 | Forte no benchmark; carga de prova incompleta na extensão |
| Exposition | 5/10 | Fraca e ainda não pronta para submissão |
| **Global** | **6/10** | **Promissor, mas requer reformulação substantiva e editorial** |

## Síntese editorial

O manuscrito contém uma ideia publicável: quando somente o hegemon conhece seu payoff de desacordo, maioria e unanimidade não diferem apenas no número de votos necessários. Maioria permite substituir o único ator informado; unanimidade transforma sua aprovação em insumo essencial e pode pagar ao tipo baixo o preço do tipo alto. Essa é a principal força do paper e o benchmark a executa com disciplina rara: domínios, tipos, multiplicidade e células vazias são preservados, sem converter ausência de equilíbrio em efeito zero ou envelopes marginais em combinações inatingíveis.

O candidato atual, porém, ainda não entrega essa ideia na forma exigida por um top journal. A introdução interrompe o parágrafo de resultados em “I show that..”, mantém o marcador `[AUTHOR: P1]` e omite a seção de agenda no roteiro. A contribuição também se dispersa: a extensão de agenda acrescenta uma arquitetura Borel extensa, mas vários resultados permanecem set-valued, dependentes do fiber off-path ou sem sinal geral. Além disso, o PDF afirma completude e exaustividade da correspondência da extensão sem apresentar uma prova proporcionalmente auditável. O problema não é que tenha sido encontrada uma contradição matemática no resultado central; é que a ambição formal e editorial da versão supera a evidência e a exposição visíveis no próprio manuscrito.

A principal força é, portanto, o mecanismo do benchmark — substituição sob maioria versus aprovação informada indispensável sob unanimidade. A principal fraqueza é a falta de hierarquia: o paper trata como co-centrais o mecanismo, uma decomposição contábil útil, uma extensão de agenda de grande complexidade e uma aplicação à WTO que ilustra consequências, mas não explica escolha institucional. O resultado é um manuscrito rigoroso em partes, porém ainda sem um pitch editorial acabado.

## Hierarquia Edmans aplicada

**Contribution > Execution > Exposition.** A contribuição supera o limiar para justificar nova rodada: ela não é um mero resultado geográfico nem uma trivialidade completa, e a forma como a regra liga ou desliga a única informação privada relevante é suficientemente distintiva. Ainda assim, sua novidade é moderada porque combina elementos próximos já presentes nas literaturas de votos caros, signaling, pooling e screening. A revisão deve provar que essa recombinação produz um resultado que os modelos vizinhos não conseguem gerar.

A execução do benchmark sustenta a afirmação condicional “unanimity can favor the hegemon”. Não sustenta, por si só, um ranking geral, uma explicação da criação da WTO ou uma conclusão sobre todo o domínio de crenças. Na extensão, a carga de prova passa a ser o gargalo: ou o paper fornece a demonstração de exaustividade/completude compatível com as alegações, ou reduz essas alegações e leva a maquinaria de representação para um suplemento técnico.

A exposição é o bloqueio imediato, mas não o único. Corrigir “I show that..” e os resíduos internos é necessário e relativamente barato; isso não resolverá a contribuição dispersa nem a lacuna entre a caracterização completa alegada e a prova publicada. Por isso, a decisão não é R&R minor. Também não é rejeição definitiva: o mecanismo central é forte o bastante para justificar uma reapresentação substancialmente reconstruída.

## Prioridades para revisão

1. **Entregar o paper no primeiro contato.** Reescrever abstract e introdução com três resultados hierarquizados; remover todos os marcadores e termos de workflow interno; atualizar o roteiro; fazer copyedit e revisão visual integral. O PDF atual não deve ser submetido.
2. **Escolher o benchmark como contribuição dominante.** Enunciar claramente o contraste com Piazolo–Vanberg, Glynia–Thum–Xefteris e Miller–Montero–Vanberg: quem é informado, quem propõe, se uma coalizão pode excluir todos os informados e qual resultado novo surge. Tratar \(T=D+I\) como decomposição organizacional, não como descoberta comportamental independente.
3. **Redimensionar ou completar a extensão de agenda.** Manter no corpo apenas resultados economicamente interpretáveis e selection-free. Para conservar as alegações de correspondência Borel completa, acrescentar prova explícita de exaustividade, existência global das crenças/seletores, mensurabilidade e ausência de desvios não enumerados. Caso contrário, estreitar o claim e mover binders, assinaturas, órbitas e fatorizações para suplemento técnico.
4. **Explicitar a robustez ao conceito de solução.** Separar resultados invariantes, resultados de fronteira e resultados que dependem de indiferença-to-yes, suporte do prior, tie-break de proposta e fiber off-path. Caracterizar ballots mistos na célula vazia ou declarar essa limitação em todos os teoremas e claims comparativos relevantes.
5. **Alinhar a relevância institucional ao que o modelo identifica.** Ou endogeneizar escolha da regra, ou reformular o puzzle como consequência distributiva do consenso. Derivar quem paga a renda — payoffs dos estados fracos, probabilidade de acordo, atraso e excedente — e transformar a discussão da WTO em hipóteses observáveis com fontes primárias e pinpoints adequados.

## Recomendação estratégica ao autor

Vale a pena revisar, sobretudo para *International Organization* ou um periódico de teoria política formal. O benchmark tem uma intuição memorável e uma execução suficientemente séria para sobreviver a uma rodada major. A estratégia mais eficiente não é adicionar ainda mais generalidade: é proteger a contribuição central, reduzir a superfície de claims e fazer a prova publicada corresponder exatamente à força da linguagem.

Para APSR/AJPS, a versão ainda precisaria aumentar o payoff político geral — por exemplo, conectar a distribuição entre hegemon e estados fracos a escolha institucional, eficiência e observáveis comparativos. Para *IO*, uma versão focalizada no mecanismo de essential input, com a extensão subordinada e a aplicação WTO documentalmente precisa, parece um caminho mais plausível. A reapresentação deve ser tratada como reconstrução substancial, não como limpeza cosmética.

---

## Parecer completo — Contribution

# Parecer de Contribution (Framework Edmans)

## Score: 6/10

## Resumo da contribuição alegada

O manuscrito propõe que a unanimidade pode beneficiar um hegemon mesmo sem lhe conferir poder formal de agenda: como seu voto não pode ser substituído, sua informação privada sobre o valor do desacordo transforma-se em restrição informacional e, em certas regiões, em renda. O paper separa esse mecanismo do valor público da pivotalidade e, numa extensão, decompõe o efeito do poder de agenda em efeito direto e interação com informação privada.

## Avaliação por dimensão

### Novidade [Adequada]

Há uma novidade real na organização da informação. Nos modelos próximos, o proponente desinformado compra votos de vários respondentes informados; aqui, somente o hegemon é informado e a maioria pode formar uma coalizão inteiramente com votantes desinformados. A regra de aprovação funciona, portanto, como um interruptor que torna a única informação privada relevante dispensável ou indispensável (pp. 5–7 e 29–30). A decomposição entre valor público do voto necessário e renda informacional, seguida da extensão de agenda, também é útil (pp. 18–29).

A atualização bayesiana do leitor, contudo, é moderada, não radical. O próprio manuscrito reconhece que Miller, Montero e Vanberg já estabelecem a vantagem de um voto publicamente caro, Piazolo e Vanberg mostram que a indispensabilidade recompensa reputação de “tipo difícil”, e Glynia, Thum e Xefteris estudam pooling e screening sob diferentes regras (pp. 5–7). A inovação é uma recombinação não trivial desses elementos, mas ainda precisa demonstrar mais claramente por que não é apenas uma variação bem construída de mecanismos conhecidos.

Duas limitações reduzem a força do resultado novo. Primeiro, a correspondência sob unanimidade é vazia em estratégias puras para \(0<p\leq p^*\) (pp. 15–16), justamente uma região central para o problema informacional. Segundo, muitos resultados da extensão de agenda permanecem set-valued e sem sinal geral (pp. 26–29). A identidade \(T=D+I\) é organizacionalmente esclarecedora, mas, por ser obtida por definição e subtração dos quatro braços do modelo, não deve ser vendida como a principal descoberta comportamental.

### Importância [Adequada]

A pergunta é de primeira ordem para Relações Internacionais: como regras formalmente igualitárias podem coexistir com resultados favoráveis a uma potência dominante? A distinção entre possuir um voto caro e possuir informação privada sobre o preço desse voto merece aparecer em surveys sobre desenho institucional, bargaining e poder informal.

A importância substantiva ainda não está plenamente convertida em resultado decisório. O modelo não explica por que o hegemon escolhe a unanimidade, pois a regra é exógena; o próprio manuscrito esclarece que não identifica por que Estados Unidos e Comunidade Europeia desenharam a WTO (pp. 31–33). Tampouco produz uma recomendação institucional geral: a unanimidade pode ajudar ou prejudicar cada tipo, há células sem comparação e a extensão de agenda conserva multiplicidade.

Além disso, a avaliação concentra-se no payoff do hegemon. Sem resultados sistemáticos sobre payoff dos estados fracos, probabilidade de acordo, custo do atraso e excedente total, não se pode concluir se unanimidade melhora ou piora o desenho institucional. Um policymaker aprenderia a prestar atenção à substituibilidade do voto e à opacidade da outside option, mas ainda não receberia uma regra operacional para escolher entre maioria e unanimidade.

### Adequação ao escopo [Adequada]

O paper está bem situado em *International Organization* e economia política formal. A bibliografia combina o núcleo de desenho institucional e poder informal — Krasner, Koremenos, Steinberg, Stone e Voeten — com bargaining legislativo e informação incompleta — Baron–Ferejohn, Kalandrakis, Miller–Montero–Vanberg, Piazolo–Vanberg e Glynia–Thum–Xefteris (pp. 4–7 e 65–66).

O encaixe em um periódico generalista de Ciência Política é mais incerto. O mecanismo tem interesse amplo, mas o candidato dedica grande espaço a correspondências, binders, fibras e convenções técnicas, enquanto a implicação política permanece concentrada numa aplicação ilustrativa à WTO. A arquitetura atual parece mais naturalmente dirigida à *International Organization* ou a um periódico de teoria política formal do que à APSR/AJPS, salvo se o payoff substantivo for trazido para o primeiro plano.

### Generalizabilidade [Limitada]

A lógica de “aprovação sem substituto” é conceitualmente generalizável e o modelo comporta um número geral de estados fracos. As implicações da seção 7.2 — maior poder informacional quando o voto é insubstituível, a outside option é difícil de precificar e o contrato admite compensação — poderiam viajar para outras organizações e negociações (pp. 31–32).

Os resultados formais, entretanto, dependem de um ambiente estreito: um único ator informado, estados fracos simétricos e desinformados, dois tipos, dois rounds, pie fixo e transferível, votação simultânea, agenda exógena no benchmark, extensão com proposta obrigatória e estratégias puras. A inexistência de PBE puro numa região não degenerada e a multiplicidade da extensão restringem adicionalmente a portabilidade. A WTO é apresentada honestamente como aplicação teórica, não teste ou calibração; não há uma segunda aplicação que mostre que o mecanismo sobrevive a instituições diferentes.

### Trade-offs [Parcial]

O manuscrito é cuidadoso ao não afirmar uma vantagem universal da unanimidade. Ele compara maioria e unanimidade, informação pública e privada, tipos baixo e alto, acordo e atraso, e poder de agenda presente e ausente. Essa disciplina é uma virtude importante.

Mas o trade-off institucional é avaliado principalmente do ponto de vista distributivo do hegemon. Faltam os demais lados relevantes: payoffs agregados dos estados fracos, eficiência, probabilidade de acordo, duração esperada da barganha e possíveis custos de conceder renda ao tipo baixo. A Figura 2 apresenta a anatomia da coalizão, porém não transforma essa anatomia em análise de bem-estar ou escolha institucional. Assim, o paper mostra quem pode ganhar, mas ainda não responde quando unanimidade é social ou politicamente preferível.

### Hipóteses [Claras e direcionais]

Para um paper formal, as proposições cumprem a função de hipóteses. O mecanismo é explícito e produz previsões condicionais: maioria limita o preço do hegemon por meio de votos substitutos; unanimidade pode pagar ao tipo baixo o preço do tipo alto; pooling pode gerar acordo sem rejeição observável; mecanismos reputacionais baseados em signaling devem produzir atraso ou propostas fracassadas (pp. 13–22 e 31–32). As condições paramétricas e os sinais são claramente declarados.

Essas previsões ainda não estão organizadas como hipóteses substantivas prontas para confronto empírico. A seção de aplicação contém boas implicações observáveis, mas faltam definição de observáveis, unidade de análise e contraste entre explicações rivais. Mais gravemente, a introdução interrompe a apresentação exatamente em “I show that..” (p. 3), omitindo os resultados principais e até a descrição da seção de agenda. O marcador editorial “[AUTHOR: P1]” permanece no texto (p. 9). Esses sinais de candidato incompleto impedem que as hipóteses formalmente claras sejam comunicadas como uma contribuição editorialmente acabada.

## Veredicto geral sobre contribution

O mecanismo de “informational power through pivotality” é promissor e suficientemente distinto para justificar desenvolvimento adicional. A melhor contribuição é o contraste simples: maioria pode contornar o único ator informado; unanimidade precisa precificar sua aprovação. Isso oferece uma interpretação interessante de como igualdade formal pode produzir vantagem informal.

No candidato atual, porém, a contribuição ainda não supera convincentemente o limiar de um top journal. O manuscrito abre com o grande puzzle da criação da WTO, mas depois reconhece corretamente que o modelo não explica a escolha da regra nem identifica o mecanismo historicamente. A extensão de agenda acrescenta sofisticação, porém dispersa a mensagem em correspondências complexas e resultados sem sinal geral. A ausência da principal frase de resultados na introdução é especialmente séria: o paper literalmente não apresenta ao editor, no lugar decisivo, o que demonstrou. Meu veredicto seria rejeição com encorajamento substantivo à reformulação, não rejeição da ideia central.

## Sugestões construtivas

1. Reescrever imediatamente o núcleo da introdução. Substituir “I show that..” por três resultados hierarquizados: mecanismo principal, condição institucional e implicação de agenda. Atualizar o roteiro para incluir a seção 6, remover “[AUTHOR: P1]” e corrigir “OMC” para “WTO” no texto em inglês.
2. Escolher uma contribuição dominante. O benchmark de essential input é mais claro e surpreendente do que a maquinaria completa da extensão. A extensão deve ou gerar um teorema substantivo simples que altere a conclusão do benchmark, ou migrar parcialmente para o apêndice/um paper separado. A identidade \(T=D+I\) deve ser apresentada como ferramenta de organização, não como descoberta autônoma.
3. Demonstrar novidade por contraste contrafactual. Uma tabela curta deveria mostrar, para cada paper próximo, quem é informado, quem propõe, se uma coalizão pode excluir todos os informados e qual resultado isso impede. Idealmente, adicionar um resultado que prove que o mecanismo de “informação desligada por substituição” não pode aparecer nas arquiteturas vizinhas.
4. Completar o trade-off institucional. Derivar payoffs dos estados fracos, probabilidade de aprovação, atraso esperado e excedente total. Isso permitiria dizer não apenas quando unanimidade remunera o hegemon, mas quem paga essa renda e quando a regra é desejável.
5. Não prometer explicar o desenho da WTO sem endogeneizar a escolha da regra. Há duas rotas coerentes: formular uma etapa de rule choice e derivar condições de escolha, ou reformular a abertura como explicação de consequências distributivas do consenso, não de sua origem histórica.
6. Tratar a inexistência em estratégias puras como questão central de robustez. Caracterizar estratégias mistas, oferecer um argumento de que os resultados economicamente relevantes sobrevivem à mistura, ou reduzir as reivindicações ao domínio em que a correspondência existe. Uma faixa vazia ampla enfraquece a generalidade do mecanismo.
7. Converter a seção 7.2 em hipóteses observáveis: insubstituibilidade do voto, incerteza sobre a outside option, flexibilidade contratual, concessões compatíveis com o tipo forte e presença ou ausência de rejeição. Indicar casos comparativos além da WTO ajudaria a demonstrar que o mecanismo é geral e distinguível empiricamente.
8. Simplificar o pitch editorial. O abstract e as primeiras páginas devem enfatizar a surpresa política — consenso pode aumentar, não apenas restringir, o poder do hegemon — antes de introduzir correspondências, células vazias e binders. A precisão técnica deve permanecer, mas não pode substituir a demonstração de importância.

---

## Parecer completo — Execution

# Parecer de Execution (Framework Edmans)

## Score: 7/10

## Tipo de paper: Teórico

## Resumo da estratégia

O paper constrói um jogo de barganha em dois rounds com um hegemon privadamente informado sobre seu payoff de desacordo e compara maioria e unanimidade, primeiro sem poder de agenda do hegemon e depois com um estágio anterior e obrigatório de proposta. A estratégia analítica separa o valor público da pivotalidade do rent informacional e preserva correspondências de equilíbrio, vetores ligados por tipo e células sem PBE em estratégias puras.

## Princípio “Dados vs. Evidência”

No análogo teórico do princípio de Edmans, fórmulas, scripts e ilustrações numéricas são “dados”; tornam-se evidência apenas quando uma prova estabelece que sustentam a conclusão alegada em todo o domínio declarado.

Nesse padrão, o benchmark sem agenda oferece evidência convincente para alegações condicionais: os resultados são fechados, os domínios são explícitos e as provas permitem reconstruir a lógica econômica (pp. 12–22 e 36–40). As ilustrações são corretamente apresentadas como exemplos, não como calibração ou prova de um ranking global (pp. 7–8, 23 e 25).

A extensão de agenda ainda não oferece no próprio PDF evidência igualmente forte para todas as alegações de completude. O texto declara condições necessárias e suficientes, correspondências Borel completas, exaustividade das famílias e fatorizações mensuráveis (pp. 43–50 e 59–61), mas a demonstração publicada é muito mais curta que o objeto afirmado. O próprio manuscrito reconhece que os scripts não provam completude de PBE, mensurabilidade, fatorização universal ou ausência de desvios não enumerados (p. 61). Portanto, o leitor pode confiar nas conclusões da extensão como resultados condicionais da arquitetura declarada, mas ainda não consegue auditar plenamente, a partir do paper, a alegação mais forte de que a correspondência apresentada é completa.

## Avaliação por dimensões

### T.1 Distância premissas–conclusões: Suficiente — 8/10

Há distância substantiva entre as premissas e os resultados. A unanimidade tornar o voto do hegemon indispensável é uma característica institucional imposta, mas não determina por si só:

- quando o proposer faz screening, pooling ou exclui o hegemon;
- qual tipo captura rent informacional;
- o sinal da comparação unanimidade–maioria;
- a não existência de PBE pura;
- o efeito do estágio de agenda.

Esses resultados decorrem endogenamente de preços de continuação, crenças, composição da coalizão e escolha ótima da proposta. Em particular, o ganho do tipo baixo sob pooling, o termo \(\beta(h-\ell)\), e a mudança de sinal quando maioria exclui, governada por \(\beta h-\ell\), não estão simplesmente assumidos (pp. 17–22).

A ressalva é que parte do resultado público é muito próxima da tecnologia institucional: maioria fornece substitutos, enquanto unanimidade não. A contribuição executada com maior distância é, portanto, a incidência do rent informacional e sua interação com pivotalidade, não o fato básico de que um voto indispensável pode ser mais caro.

### T.2 Parcimônia: Parcimonioso no benchmark, excessivamente complexo na extensão — 6/10

O benchmark é bem desenhado para isolar o mecanismo: dois tipos, dois rounds, pie fixo, proposers fracos e um único ator informado. A decomposição entre payoff público, payoff privado e rent informacional esclarece qual premissa produz qual resultado.

A extensão de agenda, porém, introduz uma maquinaria desproporcionalmente pesada: medidas Borel de propostas, likelihood ratio off-path, seletores Markov, binders indivisíveis, pushforwards de leis realizadas, órbitas diagonais, camadas “exact” e “economic” e fiber products (pp. 43–50 e 59–60). Parte disso é necessária para impedir recombinações ilegítimas sob multiplicidade, um ponto forte real. Mas a complexidade torna difícil identificar quais elementos são economicamente essenciais e quais são infraestrutura de representação.

O maior problema de parcimônia não é apenas expositivo: quanto mais rica a arquitetura, maior a carga de prova para demonstrar que todas as classes e desvios foram cobertos. O paper atualmente paga o custo de leitura dessa generalidade sem fornecer no PDF uma prova proporcional de completude.

### T.3 Caminho causal: Correto, com ressalva sobre o tratamento de agenda — 7/10

No benchmark, variáveis situadas no mecanismo permanecem endógenas: proposta, preço pago ao hegemon, coalizão, inclusão, screening, pooling, exclusão e atraso são resultados do jogo. A regra de votação e o protocolo de reconhecimento são mantidos exógenos, o que é apropriado porque o paper não afirma explicar a escolha endógena da regra. O texto também evita transformar a aplicação à WTO em identificação histórica (pp. 31–33).

A ressalva central está no contraste \(T_g\). O “tratamento” não acrescenta apenas poder de agenda: acrescenta um estágio mais cedo, torna a proposta obrigatória e não permite que o hegemon decline da oportunidade preservando o payoff na mesma data. Assim, \(T_g\) combina timing, obrigação de mover e direito de propor. O próprio paper reconhece isso (pp. 28 e 61), mas ainda chama o objeto de efeito estrutural da agenda. O resultado público \(D_U=1-\beta\) mostra que parte do ganho vem mecanicamente da antecipação temporal. Se a conclusão substantiva pretende ser sobre “agenda power”, seria preciso um contrafactual na mesma data ou um direito opcional de proposta.

### Suficiência e escopo das provas: Forte no benchmark; incompleta para a alegação de completude da extensão — 6/10

As provas do benchmark são econômicas e rastreáveis. A prova da não existência na célula intermediária, por exemplo, constrói uma proposta factível e elimina os quatro perfis puros de votação do hegemon (pp. 38–39). As diferenças de payoff e os cutoffs de maioria também são derivados explicitamente (p. 37).

Na extensão, a Tabela 8 e as famílias AU-MSB-L e AU-MSB-H são apresentadas como necessárias, suficientes e exaustivas, inclusive para misturas Borel e suportes sem átomos (pp. 45–49). Falta, contudo, uma demonstração explícita de:

1. exaustividade das famílias;
2. inexistência de outras configurações semi-separadoras;
3. existência e consistência global dos mapas de crença em pontos-limite de massa zero;
4. mensurabilidade dos seletores e das fatorizações;
5. ausência de desvios não enumerados.

Isso não é uma alegação de que os resultados estejam errados. É uma lacuna entre a força da conclusão — “complete correspondence”, “necessary and sufficient”, “there is no third family” — e a evidência formal visível no manuscrito.

### Dependência de disciplinas, tie-breaks e crenças off-path: Transparente, mas substantiva — 6/10

O paper declara três disciplinas adicionais ao PBE: ausência de sinalização por ações de atores desinformados, votação fraca “as if pivotal” e aceitação na indiferença; acrescenta ainda um tie-break de proposta que minimiza o payoff esperado do hegemon (p. 10). Essa transparência é um ponto forte.

Essas convenções, porém, não são inócuas:

- a aceitação na indiferença é usada diretamente para excluir o perfil pooling-no e sustentar a não existência da PBE pura (pp. 15 e 38–39);
- a preservação do suporte do prior produz a descontinuidade entre \(p=0\) e qualquer \(p>0\) (pp. 15, 39–40);
- o tie-break seleciona inclusão em \(o=1/m\), screening nos cutoffs e o segmento residual (pp. 12, 14–15 e 37);
- a seleção congelada na fronteira \(o=1/m\) gera o salto do efeito público de agenda (p. 56);
- na extensão, existência e payoff dependem do fiber off-path \((\rho,\mu^{off})\), e maioria existe para algum \(\rho\), não necessariamente para todo \(\rho\) fixado (p. 46).

O manuscrito deveria separar resultados robustos a essas convenções daqueles que mudam apenas em fronteiras e daqueles — como a célula vazia — cuja própria existência depende delas. A sigla “M/S/B” também deve ser expandida e definida antes de ser usada para qualificar o domínio dos resultados.

### Não existência de PBE em células: Tratamento honesto, limitação material

A não existência para \(0<p\leq p^*\) é cuidadosamente provada dentro do espaço de ballots puros, e o paper corretamente não preenche a célula com zero, interpolação ou payoff fictício (pp. 15–16, 30 e 40–41). Essa disciplina é exemplar.

Mas essa célula cobre uma região inteira do prior, não apenas uma fronteira. Como equilíbrios com ballots mistos não são caracterizados, o paper não estabelece o ranking institucional nessa parte substantiva do domínio. A conclusão “unanimity can favor the hegemon” permanece sustentada como afirmação existencial e condicional em células não vazias; não sustenta um ranking geral ao longo de todas as crenças.

### Correspondência set-valued da extensão: Forte e corretamente limitada — 8/10

Este é um dos pontos de execução mais cuidadosos do paper. O manuscrito:

- preserva os vetores low/high ligados;
- mantém o mesmo peso em payoffs e outcomes;
- não transforma envelopes marginais em retângulos inatingíveis;
- propaga fontes vazias como \(\varnothing\);
- exige comparação no mesmo fiber;
- distingue diferenças member-specific de dominância setwise;
- evita inventar uma distribuição contrafactual conjunta (pp. 26, 45, 50–51 e 58–61).

Assim, as conclusões principais não extrapolam sistematicamente o domínio provado. O exemplo de reversão informacional na p. 25 é explicitamente um membro, não um ranking global. A melhoria necessária é justificar melhor por que acoplar os contrafactuais pelo mesmo \((\rho,\mu^{off})\) é o contrafactual estrutural apropriado, dado que crenças off-path são objetos de equilíbrio, e mostrar a sensibilidade do resultado à união sobre fibers admissíveis.

## Veredicto geral sobre execution

O leitor pode tirar conclusões precisas do benchmark: sob as disciplinas declaradas e nas células com PBE pura, unanimidade pode gerar rent informacional para o tipo baixo porque torna o único ator informado indispensável, enquanto maioria pode substituí-lo. O paper é especialmente forte ao não converter multiplicidade, células vazias ou ilustrações em rankings universais.

A execução ainda não alcança o mesmo padrão na extensão de agenda. O obstáculo principal não é um resultado contraditório, mas a distância entre a ambição formal da caracterização — correspondências Borel completas e exatas — e a prova efetivamente apresentada. Além disso, o contraste denominado “agenda” é uma intervenção composta por agenda, timing e obrigatoriedade. Portanto, o resultado central “can” está sustentado; um teorema geral sobre o valor do poder de agenda ou sobre todo o domínio de crenças ainda não está.

## Sugestões construtivas

1. Converter a extensão em proposições formais com uma prova de exaustividade claramente identificável: classes possíveis, eliminação das restantes, existência, incentivos globais e condições de mensurabilidade.
2. Incluir uma matriz de robustez do conceito de solução: o que sobrevive à mudança do tie-break, à votação no empate, a crenças off-path alternativas e à admissão de ballots mistos.
3. Ou caracterizar os equilíbrios com ballots mistos na célula vazia, ou elevar a restrição de domínio ao enunciado do principal teorema e de todas as conclusões comparativas.
4. Renomear \(T_g\) como “efeito do estágio anterior e obrigatório de proposta hegemônica”. Se o objetivo é identificar poder de agenda puro, acrescentar um contrafactual na mesma data ou com proposta opcional.
5. Manter no corpo principal apenas os resultados selection-free e member-specific economicamente interpretáveis. Mover binders, órbitas e fatorização para um apêndice técnico acompanhado de um mapa de prova.
6. Justificar a comparação same-fiber como parte do contrafactual estrutural e reportar quais conclusões permanecem válidas uniformemente sobre todos os fibers admissíveis.

---

## Parecer completo — Exposition

