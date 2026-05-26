# Parecer de Exposition (Framework Edmans) -- v5 Round 2

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"  
**Arquivo**: `formal_model_v5.Rmd`  
**Data**: 2026-04-27  
**Framework**: Edmans (2025), "Learnings From 1,000 Rejections" -- dimensao Exposition, adaptado para CP  
**Avaliador**: Editor simulado, top journal CP (JoP/AJPS/IO/BJPS)  

---

## Score: 7.5 / 10

---

## Avaliacao por dimensao

### Clareza [Boa]

#### Qualidade da escrita

A escrita e limpa e profissional ao nivel da frase. Nao identifiquei typos ou erros gramaticais no corpo do texto. A prosa flui bem e as transicoes entre secoes sao suaves. O uso de em-dashes e eficaz para inserir qualificacoes sem quebrar o fluxo. As equacoes sao numeradas sistematicamente e as cross-references (Theorem, Proposition, Remark) sao consistentes internamente.

**Problemas especificos**:

1. **Repeticao no paragrafo pos-Proposition 1** (l.285-287). O paragrafo contem duas formulacoes quase identicas em sequencia: "Because the hegemon's vote is never needed, weak states never face a choice between offers that depend on inferring the hegemon's type" e, duas frases depois, "The hegemon's private information affects the value of the agreement but creates no strategic discontinuity and no screening rent." A segunda frase adiciona apenas "and no screening rent" ao que ja foi dito. Dentro de um paragrafo de 5 linhas, essa repeticao sinaliza uma revisao que nao foi totalmente polida.

2. **Frase longa na intro** (l.57). O segundo paragrafo de contribuicao contem uma frase de ~117 palavras que comeca "The central difference is that the two rules reward this informational advantage differently" e termina com "majority's only advantage is wider institutional viability." Embora gramaticalmente correta, a frase forca o leitor a manter muitas clausulas na memoria de trabalho. Quebrar em 2-3 frases melhoraria a legibilidade.

3. **Paragrafo de justificativa do BF 2-round** (l.101). Este paragrafo de ~140 palavras defende a escolha de modelagem de 2 rounds. Sua localizacao -- entre a Definition 1 e a descricao dos Stages -- interrompe o fluxo do modelo. Deveria ser uma nota de rodape ou estar no Scope (Secao 8.2).

4. **"Screening rent" vs. "screening jump"**. O texto usa ambos os termos como quase-sinonimos, mas eles se referem a conceitos distintos: "jump" e a descontinuidade na funcao de payoff; "rent" e o excedente capturado. A Figure 3 usa "Screening rent" como label da seta de anotacao, o que e preciso, mas o corpo as vezes os intercala sem distinguir (e.g., l.323: "screening rent" como sinonimo do jump).

#### Significancia substantiva

**Pontos fortes**: O paper fornece numeros concretos e memoraveis em varios momentos criticos:
- Example 2 (l.377): "27% more than majority on the aggressive branch and 41% more on the conservative branch" -- excelente ancora quantitativa.
- Alpha-star (l.426): "$\alpha^* \approx 0.47$ when $N = 5$ but falls to $\approx 0.03$ when $N = 164$" -- comunica o scope condition de forma imediata e memoravel.
- Example 3 (l.483): "at $p = 0.50$, the hegemon's payoff under unanimity exceeds majority by 25%" -- concreto.
- Remark 1 (l.433): "increasing $\alpha$ from $0.05$ to $0.49$ (an 18-fold increase beyond $\alpha^*$) only lowers $\bar\mu$ from $0.87$ to $0.71$" -- forma forte de comunicar robustez.

**Problema principal**: O abstract NAO contem nenhum numero. A frase chave -- "weaker states pay more than necessary to secure agreement" -- e precisa mas generica. Todo paper sobre screening ou informacao assimetrica em barganha diz algo equivalente. O que torna este paper distinto e que o *voting rule* e que ativa ou desativa o screening, e o *quanto* importa. Para um reviewer que le 20 abstracts por semana, um numero concreto faria diferenca substancial. Sugestao: adicionar "In calibrated examples, the screening mechanism gives the hegemon 27--41% higher payoffs than majority rule."

#### Precisao da linguagem

**Pontos fortes**: 
- A linguagem e geralmente precisa. Afirmacoes como "unanimity dominates wherever it can sustain entry" sao claras e nao ambiguas.
- O autor distingue cuidadosamente entre dominancia condicional e dominancia total, o que e critico para o argumento.
- A qualificacao "The model does not claim that the GATT/WTO was designed for this reason" (l.580) e exatamente o tipo de hedging preciso que editores valorizam.

**Problemas**:

1. **"Informational power" nao e formalmente definido.** O titulo do paper usa o conceito, a intro usa repetidamente, mas nao ha uma definicao explicita em uma frase. A frase mais proxima de uma definicao e "By informational power I mean the bargaining advantage that a privately informed actor derives from being pivotal" (l.55), mas esta enterrada no meio de um paragrafo denso. Merece destaque -- italico, frase separada, ou tratamento formal.

2. **"Institutional technology of power"** (l.55). Frase memoravel mas vaga. O que e uma "technology of power"? O autor define indiretamente na frase seguinte, mas a frase de efeito precede a substancia, o que pode gerar ceticismo antes que o leitor entenda o mecanismo.

3. **"Promising enough"** (abstract, l.36; intro l.59). Vago. Comparar com a precisao de "at every level of uncertainty" na mesma frase do abstract. Poderia dizer "once the expected value of cooperation exceeds the unanimity entry threshold."

4. **Remark 4 (Information design), l.477**: Referencia a Kamenica & Gentzkow (2011) usando `[@kamenica2011bayesian]` dentro de um ambiente LaTeX. Precisa verificar se pandoc/bookdown resolve a citacao corretamente dentro de `\begin{remark}...\end{remark}`. Potencial citacao quebrada.

---

### Extensao [Adequado, com uma secao excessiva]

#### Introducao

A introducao tem ~4 paragrafos (l.49-59), estimada em ~1.5 paginas. Bem dentro do limite de 6 paginas.

**Estrutura**:
1. Puzzle (l.49) -- 1 paragrafo
2. Posicionamento na literatura (l.51) -- 1 paragrafo
3. Critica das respostas existentes (l.53) -- 1 paragrafo
4. Contribuicao e mecanismo (l.55-57) -- 2 paragrafos
5. Implicacao substantiva (l.59) -- 1 paragrafo

**Pontos fortes**:
- Nao ha paragrafo desperdicado dizendo "international institutions matter" ou "the design of IOs has been debated for decades." O autor assume que o leitor sabe por que isso importa e ataca o puzzle diretamente.
- A literatura e tratada antes da contribuicao, seguindo a estrutura recomendada por Edmans.
- O puzzle e formulado de forma incisiva: "Why would a powerful state ever prefer consensus over majority rule?"

**Problemas**:
1. **Dois paragrafos de literature gap (l.51 e l.53) onde um bastaria.** O l.51 apresenta a tensao (bargaining theory vs. IOs); o l.53 critica respostas existentes (self-binding vs. informal power). Ambos fazem o mesmo trabalho -- posicionar o paper contra a literatura. Fundindo-os em um unico paragrafo de 6-8 linhas, a intro ganha meia pagina e o leitor chega a contribuicao mais rapido.

2. **Ausencia de road map.** A intro nao menciona os resultados formais por nome (Theorem 1, Proposition) nem antecipa a estrutura do paper. Isso e aceitavel em CP (diferente de economia), mas um "road map" de uma frase no fim da intro ajudaria o leitor. O Motivating Example (Secao 2) termina com um paragrafo de preview (l.81), mas a intro nao tem equivalente.

3. **Ausencia do scope condition na intro.** O resultado principal tem uma condicao parametrica critica ($\alpha < \alpha^*$) que nao e mencionada na intro. Um reviewer atento perguntara imediatamente "em que condicoes?" A versao mais forte da intro incluiria: "The result holds when the hegemon's bilateral alternatives are moderate relative to multilateral cooperation -- a condition easily satisfied in small organizations but demanding in large ones."

#### Motivating Example (Secao 2)

**Ponto forte**: O exemplo e pedagogicamente eficaz. Usa N=3, um round, e numeros simples (alpha=0.2, r=2, cutoff 1/9). O leitor entende o mecanismo antes de ver notacao pesada. A transicao para o modelo geral (l.81) e bem feita.

**Problema menor**: O paragrafo final do exemplo (l.81) e um preview do modelo geral que lista resultados formais (Theorem, Proposition). Isso e ligeiramente redundante com a intro e com o inicio das secoes subsequentes. Poderia ser encurtado para 2 frases.

#### Discussion/GATT (Secao 8.1)

**Problema principal de extensao**. A secao de GATT/WTO (l.572-584) e a secao mais longa do corpo do paper, ocupando estimadamente 2-2.5 paginas em 4 paragrafos longos. Para um paper teorico, isso e desproporcional -- a Discussion nao deveria ser mais longa que a secao de resultados.

Problemas especificos:

1. **Mega-paragrafo de previsao discriminante** (l.582). Um unico paragrafo de ~300 palavras que tenta fazer 5 coisas: (a) gerar a previsao (negative association consensus/transparent stakes); (b) dar exemplos (financial institutions vs. regulatory bodies); (c) distinguir de alternativas (legitimacy, self-binding, informal power); (d) apontar dados existentes (Gould 2022); (e) sugerir testes futuros. Isso deveria ser 2-3 paragrafos mais curtos.

2. **Redundancia entre l.582 e l.584.** O paragrafo l.584 distingue o mecanismo informacional de alternativas -- tarefa identica a que l.582 ja faz parcialmente. A frase "Legitimacy accounts predict consensus where binding obligations require broad-based assent" aparece como pensamento original em l.584, mas o ponto ja foi implicado em l.582.

3. **Paragrafo de capacity asymmetry** (l.576). Informativo mas nao essencial. Poderia ser reduzido a 2 frases: "The model's information asymmetry assumption finds support in the WTO context, where major powers maintain large delegations with deep sectoral expertise while many developing country delegations operate with far smaller teams (Jawara & Kwa 2003; Jones et al. 2010; Blackhurst et al. 2000)."

4. **Repeticao com a intro.** A frase "informational power becomes most valuable" (l.580) repete quase verbatim a implicacao substantiva da intro (l.59).

**Sugestao**: Cortar a Discussion/GATT de ~2.5 para ~1.5 paginas. Comprimir capacity asymmetry a 2 frases; separar o mega-paragrafo de previsao em dois; eliminar repeticao com l.584.

#### Scope (Secao 8.2)

**Ponto forte**: Bem estruturada com perguntas em bold seguidas de respostas concisas. Informativa sem ser excessiva.

**Problema menor**: Ha redundancia entre Scope e o corpo principal. O ponto sobre "When majority dominates" (l.598) repete informacao ja coberta na Proposition 4 e no Example 3 (l.480-484). Poderia ser encurtado. Igualmente, o ponto sobre "Why simultaneous entry?" (l.592) repete a justificativa da footnote no l.107.

#### Notas de rodape

Contagem: 9 footnotes no corpo (l.92 x2, l.95, l.107, l.113, l.303, l.377, l.385, l.582) + 1 no appendix (l.828). Para um paper de ~20 paginas de corpo, ~0.5/pagina -- bem dentro do aceitavel.

**Problema**: Varias footnotes sao excessivamente longas:

- **Footnote l.95** (consensus vs unanimity equivalence): ~5 linhas. Este e um ponto substantivo que ja aparece no corpo (l.66-67, "I model consensus as unanimity..."). A footnote repete e expande. Deveria ser absorvida no texto do corpo ou encurtada.

- **Footnote l.107** (all-or-nothing entry): ~5 linhas. Justifica uma escolha de modelagem que TAMBEM e discutida no Scope (l.592, "Why simultaneous entry?"). Redundante.

- **Footnote l.385** (entry cost interpretation e scaling com N): ~6 linhas. Trata de um ponto tecnico importante (scaling O(1/N)) que deveria estar no appendix ou no Scope, nao em uma footnote no corpo.

- **Footnote l.303** (alpha >= alpha_bar regime): ~5 linhas. Discute um caso tecnico alternativo e ja referencia o appendix. Deveria estar inteiramente no appendix.

**Regra pratica**: Se uma footnote tem mais de 3 linhas, provavelmente nao e footnote -- e ou texto do corpo ou material de appendix.

#### Extensoes

- **Appendix C (K>2 types)**: Extensao genuina que endereça preocupacao real (robustez a tipos binarios). Bem calibrada. O C.4 (continuous types) e particularmente valioso.

- **Remark 4 (Information design, l.476-478)**: Vestigio da arquitetura anterior onde BP era central. E curto (1 paragrafo) e faz um ponto relevante, mas sua colocacao -- entre o Corollary e a Proposition de classificacao -- interrompe o climax argumentativo do paper. Ficaria melhor na Discussion ou como footnote.

---

### Citacoes [Precisas]

A bibliografia tem 16 citacoes unicas no texto (de 19 entradas no .bib). Para um paper teorico de CP/RI, e enxuto e apropriado.

#### Analise das citacoes

**Citacoes bem colocadas**:
- Baron & Ferejohn (1989), Kalandrakis (2006), Eraslan & Evdokimov (2019): baseline de barganha legislativa. Essenciais para o modelo.
- Kamenica & Gentzkow (2011): referencia de BP no Remark 4. Precisa e minimal.
- Steinberg (2002), Koremenos et al. (2001), Keohane (1984), Ikenberry (2001): posicionamento na literatura de design institucional. Necessarias.
- Gould (2022): dado empirico sobre prevalencia de consensus. Sem este paper, a afirmacao empirica central nao teria fonte.
- Jawara & Kwa (2003), Jones et al. (2010), Blackhurst et al. (2000): evidencia de capacity asymmetry na WTO. Adequadas para substanciar o assumption de assimetria informacional.

**Possiveis problemas**:

1. **Fearon (1995)** (l.584): citado como "cf. @fearon1995rationalist" para invocar o "rationalist framework common to all of them." Fearon (1995) e sobre explicacoes racionalistas para *guerra*, nao para design institucional. O uso e para invocar um framework geral, o que e um stretch. O paper de Fearon nao contribui substancialmente para o argumento aqui. Nao e mis-citacao, mas e uso frouxo.

2. **Bhagwati (2008)** (l.584): citado sobre PTAs e outside options. A citacao e precisa mas a frase e uma observacao lateral. Poderia ser removida sem perda.

**Teste contrafactual**: Todas as 16 citacoes passam o teste "se o paper citado nao existisse, o manuscrito poderia fazer a mesma afirmacao?" com duas excecoes:
- Gould (2022): necessaria para a afirmacao empirica sobre prevalencia de consensus.
- Baron & Ferejohn (1989): necessaria como baseline do modelo.

As demais citacoes na intro sao de posicionamento -- removiveis individualmente, mas coletivamente necessarias para situar o paper.

**Nao ha**:
- Citacoes por metodo padrao (nao aplicavel a paper teorico).
- Citacoes por fatos institucionais que eram conhecidos antes do paper citado.
- Citacoes estrategicas inflando relevancia conectando a literaturas nao relacionadas.
- Bibliografia excessiva (16 citacoes e parcimonioso).

**Nota sobre o .bib**: O .bib tem 19 entradas, mas o texto cita 16. As 3 entradas orfas devem ser identificadas e removidas antes da submissao. (Nota: a contagem original no CLAUDE.md indica que o .bib foi limpo para 19 entradas, entao as orfas podem ser residuais de edicoes recentes.)

---

## Veredicto geral sobre exposition

O manuscrito tem exposicao globalmente boa. A introducao e eficiente e bem estruturada; o motivating example e pedagogicamente forte e resolve o dilema de acessibilidade vs. rigor de forma elegante; os resultados formais sao apresentados em sequencia logica com prosa conectiva adequada; e as citacoes sao parcimoniosas e precisas. Os dois problemas principais sao: (1) a Discussion/GATT e desproporcionalmente longa para um paper teorico, com redundancias internas e repeticao de pontos ja feitos no corpo, e deveria ser cortada em ~40%; (2) o abstract e preciso mas carece de um numero memoravel -- o leitor termina o abstract sabendo *que* unanimidade pode dominar, mas nao *quanto*, o que reduz o impacto de primeira impressao em um journal de alta competicao. Problemas secundarios incluem footnotes longas na Definition 1 que deveriam ser absorvidas no texto ou movidas ao appendix; a falta de definicao formal do conceito titular "informational power"; e o Remark sobre information design que interrompe o climax argumentativo entre o Corollary e a Proposition de classificacao. Nenhum desses problemas obscurece a contribuicao ou impede a avaliacao da execucao tecnica. Sao problemas de polimento final que podem ser resolvidos em uma revisao editorial de um dia.

---

## Top 5 sugestoes de melhoria

1. **Adicionar um numero concreto ao abstract.** A frase "weaker states pay more than necessary" deveria ser acompanhada de uma magnitude. Sugestao de reescrita: "In calibrated examples, the screening mechanism gives the hegemon 27--41% higher payoffs than under majority rule, even though both rules grant symmetric proposal rights." Isso torna o abstract memoravel e distingue o paper de claims genericas sobre informational advantage. E a mudanca de maior impacto para primeira impressao.

2. **Comprimir a Discussion/GATT de ~2.5 para ~1.5 paginas.** Acoes concretas: (a) reduzir o paragrafo de capacity asymmetry (l.576) a 2 frases; (b) separar o mega-paragrafo de discriminating prediction (l.582) em dois paragrafos mais curtos -- um para a previsao, outro para a distincao de mecanismos alternativos; (c) eliminar a redundancia entre l.582 e l.584, que repetem a distincao de legitimacy/self-binding/informal power; (d) cortar a repeticao com a intro ("informational power becomes most valuable").

3. **Definir "informational power" explicitamente na intro.** O conceito titular do paper deveria ter uma definicao clara e destacada. Sugestao: abrir o paragrafo de contribuicao (l.55) com "I define *informational power* as the bargaining advantage a privately informed actor derives from being pivotal under uncertainty: when other players must secure its approval without knowing its type, uncertainty itself becomes a source of rent." A frase ja existe quase verbatim no texto -- so precisa ser destacada com italico e posicionada como definicao explicita.

4. **Reduzir ou realocar as 4 footnotes longas no corpo.** (a) Absorver a footnote sobre consensus=unanimity (l.95) no paragrafo do corpo em l.66-67, onde o ponto ja e feito informalmente; (b) eliminar a footnote sobre all-or-nothing entry (l.107), que e redundante com o Scope (l.592); (c) mover as footnotes tecnicas sobre alpha_bar (l.303) e scaling com N (l.385) para o appendix. Regra: footnotes com mais de 3 linhas devem virar texto principal ou material de appendix.

5. **Mover o Remark 4 (Information design) para a Discussion ou para uma footnote.** Sua localizacao atual -- entre o Corollary (resultado principal) e a Proposition de classificacao (resultado de fechamento) -- interrompe o climax argumentativo do paper. O ponto e valioso mas nao e necessario para o argumento central; ficaria naturalmente na Discussion (Secao 8) como observacao sobre por que o mecanismo e relevante para a literatura de information design.

---

## Observacoes adicionais (menores)

- **Data no YAML**: `date: "\`r Sys.Date()\`"` gera data dinamica. Fixar para submissao.
- **Road map ausente na intro**: Adicionar uma frase final na intro com a estrutura do paper. Nao precisa ser mecanica ("Section 2 presents..."); pode ser substantiva: "I build the argument in stages: a motivating example (Section 2), the general model (Sections 3-6), the institutional comparison (Section 7), and a discussion of scope and empirical implications (Section 8)."
- **Scope condition ausente na intro**: O resultado principal tem a condicao $\alpha < \alpha^*$. Mencionar na intro para antecipar perguntas de scope.
- **Appendix C.2 "Claim" sem prova**: O Claim sobre screening boundaries para K geral (l.1052) nao tem prova formal. Rotular explicitamente como "Claim (proof omitted)" ou adicionar uma prova breve.
- **Paragrafo sobre preferencia de W** (l.456): O paragrafo de ~150 palavras sobre por que weak states participam sob unanimidade apesar de preferirem majority e interessante mas expande o escopo alem da questao central (preferencia do hegemon). Poderia ser encurtado para 3 frases.
