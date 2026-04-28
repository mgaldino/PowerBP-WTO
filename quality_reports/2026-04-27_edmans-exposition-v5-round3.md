# Parecer de Exposition (Framework Edmans) -- formal_model_v5.Rmd, Round 3

**Manuscrito**: "Informational Power Through Pivotality: When a Hegemon May Choose Consensus"
**Autor**: Manoel Galdino (USP)
**Arquivo avaliado**: `formal_model_v5.Rmd`
**Data**: 2026-04-27
**Avaliador**: Editor simulado (APSR/IO/AJPS standard)

---

## Score: 7.5 / 10

---

## Avaliacao por dimensao

### Clareza [Boa]

#### Qualidade da escrita

A prosa e geralmente limpa e profissional. Nao encontrei typos evidentes ou erros gramaticais significativos no corpo principal. Algumas observacoes:

1. **Escrita e enxuta na maior parte do texto.** Frases como "Consensus, in this account, is not a concession to weaker states but an institutional arrangement that makes informational advantage politically productive" (abstract) sao precisas e memoraveis. O paper evita jargao desnecessario e mantem um tom academico sem ser obscuro.

2. **Pequenas questoes de formatacao/convencao.** O titulo da data e gerado automaticamente via `Sys.Date()` (linha 4), o que e fine para working paper mas pode causar estranheza em submissao (datas rotativas). Para RIO, fixar a data ou remover.

3. **Escolha terminologica "screening" vs. "signaling".** O paper usa "screening" consistentemente para descrever o mecanismo em que weak states (uninformed) definem cutoffs -- o que esta correto na terminologia de teoria de contratos (Rothschild-Stiglitz). Porem, a audiencia de IO/CP pode nao ter essa distincao automatizada. O paper nao define formalmente "screening" em nenhum momento; assume que o leitor conhece o termo. **Sugestao**: uma frase explicitando que "screening" refere-se ao lado desinformado filtrando tipos (em contraste com signaling, em que o lado informado age).

4. **Frase longa no abstract.** O abstract tem 7 frases, com a 6a sendo particularmente longa e densa: "In calibrated examples, unanimity gives the hegemon between 27% and 41% higher payoffs than majority rule near the screening cutoff, with the advantage declining as uncertainty decreases." Esta e a frase com numeros concretos -- excelente que estejam la -- mas poderia ser quebrada em duas para facilitar leitura.

#### Significancia substantiva

**Ponto forte.** O paper fornece magnitudes concretas em varios momentos:

- Abstract: "27% and 41% higher payoffs than majority rule near the screening cutoff" -- memoravel e concreto.
- Example 1 (OPEC calibration, line 387): "35% more than majority on the aggressive branch and 48% more on the conservative branch" -- excelente.
- Line 87: "jump is 8/45 ~ 0.18, about 16% of expected surplus" -- bom, ancora o leitor.
- Remark 1 (line 445): "increasing alpha from 0.05 to 0.49... only lowers mu_bar from 0.87 to 0.71" -- demonstra robustez com numeros.

**Ponto a melhorar.** Os numeros 27% e 41% do abstract nao sao facilmente localizaveis no corpo do paper. O Example 1 reporta 35% e 48%, nao 27% e 41%. Isso cria uma desconexao. O leitor que busca a fonte do "27-41%" no abstract pode nao encontra-la. **Sugestao**: unificar os numeros do abstract com os do Example 1, ou adicionar uma referencia explicita de onde vem cada cifra.

**Nota**: Os numeros "27% and 41%" parecem referir-se a uma computacao diferente dos 35%/48% do Example 1. Se sao numeros de uma versao anterior ou de uma parametrizacao diferente, isso precisa ser corrigido ou explicitado. Inconsistencia numerica entre abstract e corpo e um red flag para referees.

#### Precisao da linguagem

1. **"Informational power"** e definido na intro (line 54): "the bargaining advantage that a privately informed actor derives from being pivotal: when other players must secure its approval without knowing its type, uncertainty itself becomes a source of rent." Esta e uma definicao precisa e operacional. Excelente.

2. **"Institutional technology of power"** (line 54): linguagem evocativa mas nao totalmente precisa. O que e uma "technology of power" formalmente? O paper nao define. E retorica, nao definicao. Em um paper teorico para CP, isso pode funcionar como slogan, mas nao substituiria uma definicao. Como o paper tem a definicao operacional logo em seguida, isso e aceitavel -- mas poderia ser removido sem perda.

3. **"Consensus is most valuable to a hegemon when the prospects of multilateral cooperation are promising enough"** (line 58): "promising enough" e vago. O Theorem 1 da condicoes precisas (alpha < alpha*); o Proposition 4 da a classificacao completa. A frase da intro deveria apontar mais diretamente para o resultado formal. Compare com: "Unanimity dominates wherever it can sustain entry (Proposition 4); majority dominates only through wider institutional viability."

4. **"Calibrated examples"** (abstract): O paper tem UM exemplo calibrado (OPEC). O plural "examples" e tecnicamente incorreto ou misleading. Se o autor refere-se a variacoes parametricas sobre a mesma calibracao, deveria dizer "calibrated parameter ranges" ou similar.

5. **Linha 111**: "A single round would reduce the game to a one-shot ultimatum, and one might question whether the screening mechanism depends on that special structure." -- Quem questiona? A passagem deveria ser mais assertiva: "A single round reduces the game to an ultimatum, in which the screening mechanism is trivially present but fragile. Two rounds confirm that it survives..."

---

### Extensao [Adequado, tendendo a Longo]

#### Introducao

A introducao ocupa as linhas 48-59, ou seja, cerca de 12 paragrafos/frases. Com 1.5 line spacing e 12pt Times New Roman, isso deve ocupar cerca de 2-2.5 paginas. **Dentro do limite aceitavel** de ~6 paginas para a intro.

Estrutura da intro:
- P1 (line 50): Puzzle -- por que hegemonia + consenso? Bom.
- P2 (line 52): O que maioria e unanimidade fazem; lacuna na literatura. Bom.
- P3 (line 54): Central claim + definicao de "informational power". Bom.
- P4 (line 56): Mecanismo do modelo -- como funciona o screening. Bom, mas longo (um paragrafo unico que cobre maioria, unanimidade, cutoff, classificacao). Poderia ser quebrado em dois.
- P5 (line 58): Implicacao substantiva. Bom.

**Problema estrutural**: A intro termina no paragrafo 5 (line 58-59) com uma implicacao generica, sem road map do paper. Para um paper teorico com esta complexidade, a ausencia de um paragrafo final tipo "The remainder of the paper is organized as follows..." e notavel. O leitor nao sabe que vem a seguir: um motivating example? A lit review? O modelo direto? **Sugestao**: Adicionar um paragrafo-mapa breve (2-3 linhas) ao final da intro.

**Segundo problema**: A lit review (Section 2, lines 61-70) esta SEPARADA da intro. Isso segue a recomendacao Edmans de nao intercalar contribuicao com literatura. Bom. Porem, a intro nao menciona como o paper se diferencia de papers especificos -- fala apenas em categorias ("self-binding", "irrelevant", "rational design"). Edmans sugere que a intro deve conter a diferenciacao em pelo menos 1-2 frases. Compare com: "Unlike Bardhi & Guo (2018), who study information design under unanimity without bargaining, the present paper shows that the voting rule itself determines whether screening occurs."

#### Notas de rodape

O paper tem **9 footnotes** no corpo principal (pre-appendix, lines 1-724). O corpo principal ocupa estimativamente ~20-25 paginas compiladas (dado 1.5 spacing, figuras, tikz diagrams, R plots). Isso da **~0.4 footnotes/pagina**, bem dentro do limite de ~1/pagina. 

**Qualidade das footnotes**: A maioria e substantiva e necessaria:
- Fn 1 (line 102): WLOG normalization -- essencial.
- Fn 2 (line 102): Proportional form justification -- essencial.
- Fn 3 (line 105): Consensus vs. unanimity distinction -- essencial e bem colocada.
- Fn 4 (line 117): All-or-nothing entry justification -- essencial.
- Fn 5 (line 123): Tie-breaking convention -- curta e padrao.
- Fn 6 (line 313): High-alpha regime -- tecnica mas necessaria para completude.
- Fn 7 (line 387): OPEC calibration source -- essencial.
- Fn 8 (line 395): Entry cost interpretation + scaling -- essencial.
- Fn 9 (line 594): Pointer to Appendix C -- essencial.
- Fn 10 (line 853, appendix): Technical note on disconnected formation set.

Nenhuma footnote e descartavel. Excelente disciplina.

#### Extensoes desnecessarias

1. **Remark 3 (Information design, line 496-498)**: Este remark discute Bayesian Persuasion como extensao. Ocupa ~10 linhas. E relevante como ponte para a literatura de BP, e o paper decide explicitamente NAO desenvolver BP como resultado. O remark e conciso e funcional. Aceitavel.

2. **Remark 2 (Weighted voting, line 490-494)**: Este e o remark mais longo do paper (~25 linhas). Discute supermajority e weighted voting como extensoes. Embora nao gere resultado formal, responde a uma objecao previsivel ("por que nao comparar com supermajority?"). A discussao sobre strategic inclusion (w_H*) e particularmente valiosa: mostra que o mecanismo e mais geral do que unanimidade vs. maioria simples. Aceitavel, mas poderia ser mais compacto.

3. **Appendix C (Continuous Types, lines 1105-1228)**: ~120 linhas. Este e o material mais longo que nao esta no corpo principal. Responde a uma objecao seria (binary types e restritivo?), e o resultado (alpha*_cont >= alpha*) fortalece o argumento. Essencial.

4. **Secao Discussion/OPEC (lines 592-604)**: ~75 linhas para a ilustracao OPEC. Esta secao e detalhada -- talvez excessivamente. A conexao com o modelo e clara, mas os dois paragrafos finais (Angola/UAE exits, lines 602-603, e limitations, line 604) poderiam ser comprimidos. Em particular, a frase sobre Angola e UAE saindo do OPEC inclui detalhes factuais (350,000 barrels per day, 5 million bpd capacity, 3.2 million quota) que, embora ilustrativos, nao testam diretamente o mecanismo. **Sugestao**: Comprimir os exits para 1-2 frases, focando na predicao do modelo (F_U contrai quando outside option melhora), sem os numeros de barris.

5. **Secao Scope (lines 606-620)**: ~60 linhas de Q&A format. Cada pergunta e relevante e responde a objecoes previsiveis. A estrutura Q&A e eficaz. Porem, "Why not compare consensus with hegemonic agenda control?" (line 612-613) poderia ser integrado na intro como 1 frase, em vez de ocupar um bloco separado na Discussion. "Why binary types?" ja e respondido pelo Appendix C e repete informacao.

**Veredicto sobre extensao**: O corpo principal esta razoavelmente enxuto. O maior risco de extensao excessiva esta na secao OPEC da Discussion. O Scope e funcional mas tem sobreposicao com material ja coberto.

---

### Citacoes [Precisas]

#### Analise geral

O paper cita **18 trabalhos unicos** (excluindo @ref e @usp que sao cross-references e email). Para um paper de teoria em CP/RI, este e um numero muito baixo -- e isso e POSITIVO. A bibliografia nao esta inflada.

#### Problemas especificos

1. **Nenhuma citacao claramente desnecessaria.** Cada referencia desempenha um papel especifico:
   - Baron & Ferejohn (1989), Kalandrakis (2006), Eraslan & Evdokimov (2019): modelo base e literatura de bargaining.
   - Gould (2016), Steinberg (2002), Koremenos et al. (2001): evidencia empirica e rational design.
   - Keohane (1984), Ikenberry (2001): self-binding account.
   - Stone (2011), Gruber (2000): informal power account.
   - Bardhi & Guo (2018), Kim, Kim & Van Weelden (2025): papers mais proximos formalmente.
   - Kamenica & Gentzkow (2011): BP framework (Remark 3).
   - Griffin & Neilson (1994), Alhajji & Huettner (2000), Fattouh & Mahadeva (2013), Nakov & Nuno (2013), Simmons (2005), Yergin (1991): OPEC illustration.

2. **Possivel mis-citacao**: Eraslan & Evdokimov (2019) e publicado na *Annual Review of Economics*, citado como survey. No texto (line 65): "Eraslan & Evdokimov (2019) survey the broader literature." Verificar: este paper e realmente um survey? Se sim, ok. A revista sugere que sim (Annual Reviews).

3. **Fato institucional sem necessidade de citacao?** Line 50: "Most international organizations operate by consensus" cita Gould (2016). Neste caso, a citacao e necessaria porque Gould DOCUMENTA empiricamente este fato de forma sistematica -- nao e um fato que "todos sabiam". A citacao e apropriada.

4. **Gould (2016) e working paper (unpublished).** Citado 2 vezes (lines 50, 69). Para submissao a RIO, um working paper de 2016 que nao foi publicado ate 2026 pode levantar questoes de verificabilidade. Verificar se foi publicado entretanto.

5. **OPEC citations (5 referencias)**: Cinco citacoes para uma ilustracao (~75 linhas) e proporcional. Nenhuma e descartavel -- cada apoia um claim factual especifico.

6. **Citacoes estrategicas?** Nao identifico nenhuma tentativa de inflar relevancia. O paper nao cita literaturas nao-relacionadas para parecer mais amplo. A lit review e focada e honesta sobre o que cada paper faz e o que nao faz.

**Possivel omissao**: O paper nao cita nenhum trabalho sobre screening em bargaining (Cramton 1992; Fudenberg & Tirole 1983; Sobel & Takahashi 1983). Dado que "screening" e o mecanismo central, a ausencia de referencia aos fundamentos de screening em bargaining theory e notavel. Embora o modelo seja autocontido, um referee familiarizado com esta literatura poderia notar a lacuna.

---

## Veredicto geral sobre exposition

O manuscrito esta bem escrito para um paper de teoria formal em CP/RI. A prosa e precisa, a estrutura e logica, e o uso de exemplos concretos (motivating example + OPEC) ancora eficazmente os resultados abstratos. A bibliografia e disciplinada. As footnotes sao poucas e substantivas. 

Os principais problemas de exposition sao de calibragem, nao de competencia. Primeiro, os numeros do abstract (27-41%) nao correspondem visivelmente aos numeros do corpo (35-48%), criando uma inconsistencia que um referee notaria. Segundo, a secao OPEC e detalhada demais para uma "ilustracao" -- parece querer ser uma aplicacao empirica sem ter dados suficientes para sustentar esse peso. Terceiro, o abstract e intro poderiam ser mais agressivos em diferenciar o paper dos mais proximos (Bardhi & Guo 2018, Kim et al. 2025). Quarto, o termo "screening" deveria ser explicitamente definido para a audiencia de CP/RI. Quinto, a ausencia de um road map no final da intro e incomum para este tipo de paper.

Nenhum destes problemas e motivo de rejeicao por si so, mas juntos reduzem o impacto da exposicao de "muito bom" para "bom". Com ajustes pontuais, a exposition poderia facilmente atingir 8.5+.

---

## Top 5 sugestoes de melhoria

1. **Corrigir a inconsistencia numerica abstract-corpo.** Os numeros "27% and 41%" do abstract nao correspondem aos "35% and 48%" do Example 1. Ou unificar os numeros (usando os do Example 1 no abstract), ou adicionar uma frase no corpo que explicite de onde vem cada percentual. Inconsistencia numerica entre abstract e corpo e o tipo de erro que referee nota imediatamente e que sinaliza descuido -- mesmo que a explicacao seja benigna (parametrizacoes diferentes).
   - **Reescrita sugerida (abstract)**: "In a calibration to OPEC, unanimity gives the hegemon 35% higher payoffs on the aggressive branch and 48% on the conservative branch near the screening cutoff."

2. **Definir "screening" explicitamente na primeira ocorrencia.** A audiencia de RIO/IO/CP inclui muitos leitores que nao automaticamente distinguem screening de signaling. Uma frase na intro ou no motivating example bastaria:
   - **Reescrita sugerida (line 56, apos "screening problem")**: "By screening I mean a situation in which the uninformed side (weak states) designs the offer structure to sort the informed side (the hegemon) by type---the counterpart of signaling, where the informed side takes the initiative."

3. **Comprimir a secao OPEC.** Os paragrafos sobre Angola/UAE (line 602-603) e as limitacoes (line 604) poderiam ser reduzidos a ~3-4 frases cada. Os detalhes numericos sobre barris por dia nao acrescentam ao argumento teorico. Foco na predicao do modelo: outside options melhoram -> F_U contrai -> exit racional. A Discussion inteira (OPEC + Scope) poderia perder ~1 pagina sem perda de conteudo.

4. **Adicionar road map no final da intro.** Um paragrafo de 2-3 linhas indicando a estrutura do paper: "Section 2 reviews related literature. Section 3 presents a motivating example. Section 4 defines the model. Sections 5-6 characterize equilibrium under each rule. Section 7 compares the two institutions. Section 8 discusses scope and applications. Section 9 concludes." Isso custa 3 linhas e economiza tempo para o referee que quer saltar para os resultados.

5. **Adicionar diferenciacao explicita na intro (nao so na lit review).** A intro (lines 48-59) nao menciona nenhum paper por nome. Toda a diferenciacao esta na Section 2. Para maxima eficacia, incluir 1-2 frases na intro tipo: "Unlike work on information design in voting (Bardhi and Guo 2018) or persuasion under veto (Kim, Kim, and Van Weelden 2025), I show that the voting rule itself---not information design---determines whether screening occurs." Isso nao precisa ser um paragrafo; duas frases no P3 ou P4 bastam.

---

## Observacoes adicionais (nao contabilizadas no score)

- **Notacao $V_e(\mu)$**: Definida na line 109 como "expected value of cooperation at posterior belief mu". A notacao e funcional, mas a subscript "e" para "expected" pode confundir com "entry". Considerar $\bar{V}(\mu)$ ou $\mathbb{E}[V|\mu]$.

- **Secao 3 (Motivating Example) antes da Section 4 (Model)**: Esta e uma escolha deliberada e boa -- ancora a intuicao antes do aparato formal. Segue o conselho de Board & Meyer-ter-Vehn (2018) e Thomson (1999).

- **Figuras TikZ**: Os game trees (Figures 1-2) estao em landscape e sao complexos. Funcionam como referencia, mas poucos leitores vao estuda-los detalhadamente. Figure 3 (screening schematic) e Figure 4 (parameter regions) sao muito mais uteis para o argumento. Se houver restricao de espaco, os game trees poderiam ir para appendix.

- **Remark 2 sobre weighted voting**: O insight de "strategic inclusion" (w_H*) e potencialmente um resultado por si so. Ou formalizar (e merece um Proposition), ou comprimir para ~10 linhas. Atualmente ocupa um espaco intermediario que pode gerar a objecao "if it's important enough for 25 lines, why not prove it?"

- **Referencia Gould (2016) como working paper**: Para RIO, que trabalha com institucoes internacionais, este e um paper relevante e conhecido. Mas submeter a um journal citando um working paper de 10 anos que nao foi publicado pode gerar questoes. Verificar se houve publicacao.

- **Ausencia de referencia a literature de screening in bargaining (Cramton 1992, Sobel & Takahashi 1983, Fudenberg & Tirole 1983)**: Dado que "screening" e a palavra-chave do mecanismo, a lit review poderia reconhecer esses antecedentes. Nao e obrigatorio, mas um referee de teoria poderia notar.
