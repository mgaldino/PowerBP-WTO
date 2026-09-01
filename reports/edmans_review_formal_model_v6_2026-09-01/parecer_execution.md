# Parecer de Execution (Framework Edmans)

**Candidato avaliado:** `formal_model_v6.pdf`  
**Commit:** `611727865a9e0c6e9af142c84fcae4f2e18747df`  
**SHA-256 do PDF:** `146fee55cb063b645121f2a6802a85c58816c542a5474442691c0903af5fafc4`

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
