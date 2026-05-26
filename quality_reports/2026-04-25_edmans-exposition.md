# Parecer de Exposition (Framework Edmans)

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Autor**: Manoel Galdino
**Data**: 2026-04-25
**Avaliador**: Simulacao de editor de top journal CP (APSR/AJPS/JOP/IO)

---

## Score: 7.5/10

---

## Avaliacao por dimensao

### Clareza [Boa]

#### Qualidade da escrita

A prosa e geralmente limpa e profissional. Nao encontrei erros gramaticais sistematicos. Alguns pontos especificos:

1. **Typo/erros menores**: Linha 47, "relative do domestic politics" deveria ser "relative **to** domestic politics". Este e o unico typo que identifiquei, o que sinaliza cuidado editorial.

2. **Qualidade das transicoes**: As transicoes entre secoes sao funcionais mas mecanicas. O paragrafo de roadmap no final da introducao (linhas 60-61) e puramente sequencial ("Section 2 presents... Section 3 presents... Sections 4 and 5 derive..."). Editores de JOP/AJPS toleram roadmaps curtos, mas este nao acrescenta valor --- o leitor nao ganha insight sobre *por que* a estrutura e assim. Sugestao: substituir por 1-2 frases que expliquem a logica da construcao ("The argument builds in three steps: first... then... finally...") ou eliminar o roadmap.

3. **Consistencia terminologica**: O manuscrito usa "consensus" e "unanimity" de forma intercambiavel, o que e justificado na footnote 3. Porem, o titulo diz "Consensus" e o modelo e formalmente "Unanimity". Isso pode confundir um referee que espera que o paper trate de consenso como norma social (onde silencio = aprovacao), nao como regra formal de voto. A footnote resolve, mas poderia ser promovida a uma frase no corpo.

#### Significancia substantiva

Este e o ponto mais forte da exposicao. O manuscrito oferece numeros concretos e interpretaveis:

- **Exemplo motivador (Secao 2)**: jump de 0.18, "about 16% of expected surplus at the cutoff" --- excelente. Traduz algebra em magnitudes interpretaveis.
- **Example 1 (linha 406)**: "27% more than majority on the aggressive branch and 41% more on the conservative branch" --- numeros memoraveis e que comunicam a magnitude do mecanismo.
- **Abstract**: Descreve o mecanismo em linguagem substantiva, mas carece de um numero memorable. O abstract diz "screening advantage" e "trade-off" mas nao diz *quao grande* e a vantagem. Sugestao: adicionar ao abstract algo como "giving the hegemon X% more than majority" ou "a discrete jump of Y% of expected surplus".

#### Precisao da linguagem

A linguagem e geralmente precisa, mas ha momentos de vagueza:

1. **Introducao, linha 57**: "The substantive implication is that consensus is most valuable to a hegemon when the prospects of multilateral cooperation are promising enough that weaker states are willing to come to the table." Isso e correto mas tautologico --- diz que unanimidade funciona quando as condicoes para unanimidade sao atendidas. Poderia ser mais preciso: "when the prior probability that cooperation is valuable exceeds $p^*$, the threshold identified in Theorem 2."

2. **Discussion, linha 672**: "The model does not claim that the GATT/WTO was designed for this reason, or that all aspects of WTO politics reduce to this mechanism. It shows that consensus and informational asymmetry interact in a way that can benefit powerful states." Hedging excessivo. A primeira frase e um *disclaimer* que enfraquece sem necessidade. Se o modelo nao explica o design do GATT/WTO, o que ele explica? Melhor: manter o "offering one explanation" e cortar o "does not claim".

3. **Discussion, linha 674**: O paragrafo de "observable implications" (5 predictions) e denso demais --- sao 5 predictions compactadas em um unico paragrafo. Cada prediction merece pelo menos tratamento separado (bullets ou sub-paragrafos). O formato atual obscurece as predictions.

4. **Broader implications, linha 786**: "These dynamic implications are suggestive extrapolations from the static mechanism, not formal predictions of the model." Hedging correto, mas a frase "suggestive extrapolations" e vaga. Melhor: "conjectural extensions" ou simplesmente "informal extensions."

### Extensao [Adequado, com pontos de compressao]

#### Introducao

A introducao tem ~690 palavras, o que e compacto --- provavelmente 2-2.5 paginas em formatacao 12pt/1.5 spacing. Isso e excelente para um paper teorico. A estrutura segue o padrao recomendado por Edmans:

1. Paragrafo 1: Puzzle (por que um hegemon escolheria consenso?)
2. Paragrafo 2: Limitacoes das respostas existentes
3. Paragrafo 3: Contribuicao do paper + posicionamento na literatura
4. Paragrafo 4: Mecanismo do modelo
5. Paragrafo 5: Implicacao substantiva
6. Paragrafo 6: Roadmap

**Ponto positivo**: A intro nao gasta espaco dizendo que instituicoes internacionais importam ou que poder importa. Vai direto ao puzzle.

**Ponto negativo**: O paragrafo 2 (linhas 51-52) mistura contribuicao com literatura: "Existing answers do not fully resolve the puzzle... informal agenda power... self-binding... concealment for conventional power." Edmans recomenda separar: primeiro sua analise, depois a literatura. Aqui a literatura vem *antes* da contribuicao. Considerar inverter: apresentar o mecanismo (paragrafo 3 atual) imediatamente apos o puzzle, e depois posicionar contra a literatura existente.

**Paragrafo 3 (contribuicao)**: "This paper theorizes when and why a hegemon may prefer unanimity" --- bom. Mas a frase seguinte ("Using Bayesian persuasion...") entra imediatamente em jargao tecnico que interrompe o fluxo substantivo. O leitor nao-tecnico (referee 2 de JOP, especialista em IO) vai tropecar em "Bayesian persuasion" e "concavification" antes de entender o argumento substantivo. Sugestao: primeiro descrever o mecanismo em linguagem de fenomeno ("consensus forces weaker states to include the hegemon under uncertainty, creating a screening problem that generates informational rents"), e so depois nomear a ferramenta formal.

#### Notas de rodape

Contagem: 7 footnotes LaTeX + 2 footnotes Rmd = 9 footnotes no corpo (Secoes 1-9). Com o corpo ocupando provavelmente ~18-20 paginas compiladas, isso e ~0.5 footnotes por pagina --- bem dentro do limiar recomendado de ~1/pagina.

**Qualidade das footnotes**:
- Footnote 1 (d_W = 0 WLOG): necessaria, bem colocada.
- Footnote 2 (alpha V(theta) interpretation): necessaria, mas poderia ser absorvida no texto principal --- a interpretacao e central para o modelo.
- Footnote 3 (consensus vs unanimity): importante, mas como notado acima, poderia ser promovida a texto.
- Footnote sobre tie-breaking: padrao, ok.
- Footnote sobre entry cost scaling (c = c_tilde/N): relevante, ok.
- Footnote longa sobre alpha >= alpha_bar (linha 316): esta e a unica footnote problematica. Tem ~80 palavras e inclui detalhes de prova ("payoff decomposition is additive... endpoint argument establishes..."). Isso deveria ser absorvido pelo appendix, nao ficar no corpo como footnote.
- Footnote ^[Appendix C shows...] (linha 674): ok, sinaliza extensao.
- Footnote ^[Because V_W^R1...] (linha 923): pertence ao appendix, nao ao corpo.

#### Extensoes desnecessarias

1. **Appendix C (K > 2 types)**: Justificavel como robustez. Porem, o paper ja menciona isso em dois locais: conclusao (linha 795) e footnote no Discussion (linha 674). Uma mencao bastaria. A dupla referencia sinaliza incerteza sobre onde colocar o resultado.

2. **Discussion: GATT-to-WTO transition (linhas 676-680)**: Este sub-segmento de ~300 palavras aplica o modelo a uma transicao historica especifica. E bem escrito e substantivamente interessante, mas expande o escopo para alem do que o modelo formalmente suporta. O modelo e estatico; a transicao e dinamica. O autor reconhece isso ("the model suggests a structural interpretation"), mas a extensao ocupa espaco valioso que poderia ser usado para o worked example P6 que esta pendente.

3. **Discussion: "new regimes" prediction (linha 680)**: O paragrafo final do GATT-to-WTO section generaliza para "new regimes vs new organizations." Isso e um argumento verbal nao sustentado pelo modelo formal e deveria ser marcado mais claramente como especulacao ou movido para a conclusao.

4. **Broader implications (linha 786)**: O paragrafo sobre "erosao endogena do poder informacional" e paper futuro, nao resultado deste paper. E corretamente hedged, mas contribui para o sentimento de que a Discussion tenta fazer demais.

**Diagnostico global de extensao**: O corpo tem ~9400 palavras, o que e razoavel para um paper teorico. Porem, a Discussion (Secao 8) tem ~2500 palavras --- quase 27% do corpo. Isso e desproporcional. A Discussion tenta fazer tres coisas simultaneamente: (1) ilustrar com GATT/WTO, (2) mapear scope conditions, (3) oferecer broader implications. Cada uma merece atencao, mas juntas tornam a Discussion mais longa que qualquer outra secao substantiva. Comprimir para ~1800 palavras melhoraria significativamente.

### Citacoes [Precisas]

#### Analise geral

O manuscrito cita 19 referencias unicas. Para um paper teorico em CP/IO, este e um numero enxuto e disciplinado. Nenhuma referencia parece estrategica (inserida para inflar relevancia em literaturas distantes). Todas as citacoes sao relevantes ao argumento.

#### Problemas especificos

1. **Steinberg (2002) citado 5 vezes**: E a referencia principal para o puzzle, entao a alta frequencia e justificada. Porem, duas das cinco citacoes sao redundantes (linhas 49 e 666 fazem essencialmente o mesmo ponto: "o sistema opera por consenso"). Consolidar.

2. **Keohane (1984) citado 2 vezes**: Ambas na intro (linhas 49 e 51). A primeira mencao e como literature sobre consenso como self-binding; a segunda como "constraining powerful states." Sao argumentos distintos? Se sim, vale esclarecer; se nao, consolidar.

3. **Entradas orfas no .bib**: Dworczak & Martini (2019), Ali, Bernheim & Fan (2019), Diermeier & Myerson (1999), e Feddersen & Pesendorfer (1998) estao no .bib mas nao sao citados no manuscrito. Sao 4 entradas orfas que devem ser removidas.

4. **Fato institucional sem citacao necessaria**: Linha 666, "Since 1947, the multilateral trading system has operated predominantly by consensus" --- este e um fato bem estabelecido. A citacao de Steinberg aqui e defensavel (ele documenta isso sistematicamente), mas o fato em si nao e contribuicao de Steinberg.

5. **Fearon (1995)**: Citado uma vez (linha 784), descrito como "in the spirit of Fearon (1995)." O papel de Fearon no argumento e vago --- o manuscrito invoca o "rationalist framework" de Fearon, mas o mecanismo do paper nao e sobre guerra ou commitment problems. A conexao e tematica, nao mecanistica. Considerar se esta citacao e necessaria ou se apenas sinaliza "eu conheco a literatura."

6. **Glazer & Rubinstein (2004)** e **Milgrom (1981)**: Citados no Scope (linha 690) como alternativas ao commitment assumption ("evidence games", "verifiable disclosure"). Sao tecnicamente corretos, mas servem mais como referencia para o referee tecnico do que como parte do argumento. Aceitavel, mas marginal.

---

## Veredicto geral sobre exposition

O manuscrito tem boa clareza geral, uma introducao enxuta e bem estruturada, um numero disciplinado de citacoes, e usa numeros concretos para comunicar magnitudes --- um ponto forte incomum em papers teoricos de CP. Os principais problemas de exposicao sao: (1) a Discussion e desproporcionalmente longa e tenta cobrir demais (GATT ilustracao + scope + broader implications + dynamic conjectures); (2) o abstract nao captura uma magnitude memorable do resultado; (3) o paragrafo de observable implications esta compactado demais para ser efetivo; e (4) ha um typo na primeira pagina que, embora isolado, e o tipo de descuido que um referee nota imediatamente. Nenhum desses problemas e motivo de rejeicao, mas corrigi-los elevaria o manuscrito de "boa exposicao para paper teorico" para "exposicao que ajuda ativamente a comunicar a contribuicao." A escrita esta claramente acima da media de submissoes, mas a Discussion precisa de disciplina editorial.

---

## Top 5 sugestoes de melhoria

1. **Comprimir a Discussion de ~2500 para ~1800 palavras.** Os alvos principais sao: (a) o paragrafro sobre "new regimes vs new organizations" (linha 680), que e especulacao nao sustentada pelo modelo e pode ser cortado inteiramente ou movido para 2 frases na conclusao; (b) as "broader implications" sobre erosao endogena (linha 786), que e paper futuro e merece no maximo 2 frases; (c) consolidar as 5 observable implications em formato de lista (bullets) para que cada uma seja visivel e testavel. Meta: a Discussion nao deve exceder a Secao 7 (Institutional Choice) em extensao.

2. **Adicionar uma magnitude memorable ao abstract.** Atualmente o abstract descreve o mecanismo qualitativamente mas nao diz quao grande e a vantagem. Inserir algo como: "In the baseline parametrization, the screening mechanism gives the hegemon 27-41% more than majority rule, with a discrete jump equivalent to 5% of expected surplus" (usando os numeros do Example 1). Isso torna o abstract citavel e distingue contribuicao substantiva de contribuicao puramente conceitual.

3. **Corrigir o typo "relative do" -> "relative to" na linha 47 e promover a footnote 3 (consensus = unanimity) a texto no corpo.** O typo e o unico erro gramatical, mas esta na primeira pagina --- exatamente onde o editor le com mais atencao. A footnote sobre consensus/unanimity e importante demais para ficar em nota de rodape; 1-2 frases no paragrafo de definicoes resolveriam.

4. **Reestruturar a introducao para apresentar o mecanismo antes da literatura.** Atualmente: puzzle (par.1) -> literatura + gaps (par.2) -> contribuicao (par.3). Recomendado: puzzle (par.1) -> contribuicao e mecanismo (par.2) -> posicionamento na literatura (par.3). Isso segue o principio de Edmans de que o leitor deve saber *o que voce faz* antes de saber *o que outros fizeram*. O paragrafo 2 atual e competente, mas vem cedo demais na narrativa.

5. **Mover a footnote longa sobre alpha >= alpha_bar (linha 316) para o Appendix A.5.** Esta footnote contem detalhes de prova ("the payoff decomposition is additive in the R1 and R2 corrections regardless of the relative ordering...") que pertencem ao appendix. Uma footnote com detalhes de prova no corpo sinaliza que o autor nao esta seguro de onde o resultado se encaixa na hierarquia de importancia. Substituir por: "When alpha >= alpha_bar, the cutoff depends on alpha but the screening jump persists; see Appendix A.5 for the complete treatment."
