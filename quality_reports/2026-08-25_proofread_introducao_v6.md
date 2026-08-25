# Proofread — Introduction, `formal_model_v6.Rmd` (linhas 37–168)

**Data:** 2026-08-25
**Revisora:** agente independente, read-only. Nenhum arquivo alterado.
**Objeto:** `formal_model_v6.Rmd`, SHA-256 `c4a5f5d4575fad02b2e078e50656eb1071b3001aca2257f7e0f9e6e6f38549dc`, confirmado.
**Escopo:** somente a seção Introduction.

Checagens mecânicas: as onze chaves de citação (`koremenos2001rational`,
`krasner1983structural`, `kalandrakis2006proposal`, `steinberg2002shadow`,
`baron1989bargaining`, `winter1996voting`, `eraslan2019legislative`,
`piazolo2025legislative`, `glynia2026unanimity`, `miller2018heterogeneous`,
`stone2011controlling`) resolvem em `references.bib`; número verbal concorda com
contagem de autores em toda citação textual; `\ref{model}`, `\ref{results}` e
`\ref{discussion}` têm `{#id}` correspondente; sem palavra repetida, sem espaço
duplo, sem violação de atemporalidade.

---

## Erros

**1. Linha 43 — quebra de tempo verbal dentro de série de três**
> `rules, states hold equal voting power, the United States took no agenda power,`

A série corre presente / passado / presente (`hold` … `took` … `require`) sob uma
única regência, "Under its rules".

Correção: `rules, states hold equal voting power, the United States holds no agenda power,`

**2. Linha 62 — "thus" marca inferência que o parágrafo anterior contradiz**
> `The United States thus holds neither exclusive proposal rights nor extra`

O parágrafo imediatamente anterior estabelece que o poder de agenda *está*
concentrado num punhado de países pelo green room; "thus" tira, portanto, a
conclusão oposta à sua própria premissa.

Correção: `Formally, however, the United States holds neither exclusive proposal rights nor extra`

**3. Linhas 76–77 — comparação mal ligada**
> `The institutional version of the question is when unanimity advantages a` / `hegemon over majority rule, given equal votes...`

Como está, "over majority rule" liga-se a "advantages a hegemon", comparando um
hegemon com uma regra de votação. A comparação pretendida é entre as duas regras.

Correção: `The institutional version of the question is when unanimity, relative to majority rule, advantages a hegemon, given equal votes...`

**4. Linha 96 — vírgula faltando após adverbial antecipado**
> `knows. Under unanimity the substitute disappears.`

Inconsistente com "Under majority," quatro linhas acima.

Correção: `knows. Under unanimity, the substitute disappears.`

**5. Linha 126 — vírgula faltando após oração subordinada antecipada**
> `pure-strategy equilibrium the contrast is empty; we report that emptiness as`

Correção: `pure-strategy equilibrium, the contrast is empty; we report that emptiness as`

**6. Linhas 140–142 — oração relativa deslocada**
> `@miller2018heterogeneous supply the complete-information benchmark with` / `heterogeneous disagreement values, in which an expensive player can be` / `included under unanimity and excluded under majority.`

"in which" liga-se ao sintagma mais próximo, "heterogeneous disagreement values",
não ao benchmark.

Correção: `@miller2018heterogeneous supply a complete-information benchmark with heterogeneous disagreement values, showing that an expensive player can be included under unanimity and excluded under majority.`

**7. Linha 145 — pronome órfão e dêitico errado**
> `features of the model separate it from this work.`

"it" não tem antecedente limpo — o candidato mais próximo é "the model", tornando
a frase circular. E "this work" aponta, no uso acadêmico inglês, para o próprio
paper; o referente aqui são os três trabalhos recém-resenhados.

Correção: `features of the model separate this paper from that work.`

**8. Linhas 153–154 — comma splice, e "they" sem antecedente válido**
> `read as the same institutional fact from two sides: they trace its` / `consequences for responders' incentives to signal, we trace its consequences`

Duas orações independentes unidas por vírgula. Além disso, o sujeito gramatical é
"The threat of exclusion … and the coalition substitute here", de modo que "they"
aponta para esses dois objetos, não para os autores.

Correção: `read as the same institutional fact from two sides: @piazolo2025legislative trace its consequences for responders' incentives to signal; we trace its consequences`

**9. Linha 165 — referência definida a termo que a seção nunca introduz**
> `rules. Section \ref{discussion} interprets the essential-input mechanism and`

A introdução nomeia o mecanismo "coalition substitutability" (linha 92) e nunca
usa "essential input". O leitor encontra aqui uma descrição definida sem
antecedente.

Correção: ou `interprets the coalition-substitutability mechanism` aqui, ou
introduzir o termo na linha 92: `The mechanism is coalition substitutability: under unanimity the hegemon's vote is an essential input.`

**10. Linhas 162–167 — o roadmap pula uma seção do corpo e desloca seu conteúdo**
> `Section \ref{model} defines the game and solution concept.` … `The appendix gives the proofs, endpoint discipline, exact` / `correspondence tables, and a worked numerical illustration.`

A seção `{#example}`, "A working numerical illustration" (linha 169), é seção
numerada do corpo, situada entre a Introdução e a Seção `\ref{model}`, e não é
referenciada em lugar nenhum do arquivo. O roadmap diz que vem o modelo; o leitor
encontra a ilustração. Agrava que a linha 167 atribui "a worked numerical
illustration" ao apêndice, duplicando a descrição da própria seção do corpo.

Correção: inserir antes de "Section \ref{model}": `Section \ref{example} works a numerical case.` e mudar a linha 167 para `correspondence tables, and worked values.`

**11. Linha 166 — singular onde há quatro apêndices**
> `its limits. The appendix gives the proofs, endpoint discipline, exact`

Correção: `its limits. The appendices give the proofs, ...`

**12. Linha 59 — capitalização de nome próprio**
> `such as the green room, alongside other mechanisms through which the United`

O dispositivo da OMC é convencionalmente capitalizado na literatura de IPE,
inclusive na fonte citada.

Correção: `such as the Green Room, alongside other mechanisms through which the United`

---

## Tradução

**13. Linha 44 — decalque de "para o modelo"**
> `and agreements require consensus.^[For the model, *consensus* and *unanimity*`

Correção: `and agreements require consensus.^[In the model, *consensus* and *unanimity*`

**14. Linha 51 — "against" por "ao contrário do que"**
> `American primacy in a unipolar order, against what any realist account would`

Correção: `American primacy, contrary to what any realist account would`

**15. Linhas 48–49 — construção inexistente em inglês**
> `The WTO is, of course, no exception in how international organizations set` / `their rules [@koremenos2001rational].`

"no exception in how X do Y" é decalque; "exception" em inglês pede "to" (uma
regra) ou "among" (uma classe).

Correção: `In this the WTO is no exception among international organizations [@koremenos2001rational].`

**16. Linha 53 — decalque de preposição e overclaim de superlativo**
> `widest on the greatest source of power of all, agenda power`

"widest on" é calcado; e "the greatest source of power of all" afirma mais do que
@kalandrakis2006proposal sustenta.

Correção: `widest precisely where power is greatest: agenda power`

**17. Linhas 57–58 — ordem de palavras portuguesa, e preposição errada**
> `some form of informal inequality must exist. @steinberg2002shadow documents,` / `for the WTO, agenda power confined to a handful of countries through devices`

Adverbial entre vírgulas encravado entre verbo e objeto é ordem portuguesa; e a
preposição deve ser "in the WTO".

Correção: `some form of informal inequality must exist. @steinberg2002shadow documents that in the WTO agenda power is confined to a handful of countries through devices`

**18. Linha 60 — modal passado após verbo de reporte no presente**
> `States could steer the organization in a direction of its own choosing.`

Correção: `States can steer the organization in a direction of its own choosing.`

**19. Linha 56 — artigo definido afirmando unicidade**
> `The explanation offered in the literature is that, despite formal equality,`

O português tolera o definido aqui; o inglês o lê como afirmação de que existe uma
única explicação. Colide também com "The standard answer is…" na linha 66.

Correção: `One explanation offered in the literature is that, despite formal equality,`

**20. Linha 136 — decalque comprimido**
> `that uncertainty about several responders changes the proposer's choice`

A incerteza é sobre os valores de desacordo deles, não sobre os respondentes.

Correção: `that uncertainty about the disagreement values of several responders changes the proposer's choice`

**21. Registro, linhas 41–54 vs 85 em diante — observação geral**

Os quatro parágrafos de abertura correm retóricos e periódicos; tudo a partir da
linha 85 corre chapado e declarativo. A costura é audível na linha 62. Os itens 16
e 19 puxam a abertura um passo em direção ao segundo registro.

---

## Clareza

**22. Linhas 41–54 — "power" seis vezes em catorze linhas, "at the height of" duas**

Sugestão: nas linhas 50–51, cortar `the asymmetry of power at the height of American primacy in a unipolar order` para `the asymmetry of power under American primacy`.

**23. Citação e claim duplicados, linhas 53–54 vs 66–67**

A mesma fonte carrega o mesmo claim duas vezes, a dois parágrafos de distância.
As linhas 66–67 o enunciam corretamente e o ligam ao movimento do paper.

Sugestão: retirar a citação da linha 54 e deixar a 66 carregá-la.

**24. Linhas 56 e 66 — dois claims concorrentes sobre o que a literatura diz**

Ambos definidos, ambos pretendendo ser *a* resposta, mas nomeando coisas
diferentes. O item 19 suaviza o primeiro; os dois ainda precisam ser reconciliados.

Sugestão na linha 66: `The standard answer in the bargaining literature is proposal rights.`

**25. Linhas 56–64 — dobradiça ausente na costura**

O parágrafo do Steinberg apresenta a explicação da desigualdade informal e para; o
parágrafo seguinte estipula que os EUA não têm vantagem formal. Nada diz ao leitor
por que a resposta informal está sendo posta de lado, que é o movimento que motiva
o paper inteiro.

Sugestão, substituindo a abertura da linha 62: `That answer locates power outside the formal rules. This paper asks what the rules themselves can generate. Formally, the United States holds neither exclusive proposal rights nor extra votes, and it knows more than its partners about what it can obtain if no agreement is reached.` (Absorve também o item 2.)

**26. Linha 79 — "the second half" de uma pergunta**

Sugestão: `The second part of that question matters because`

**27. Linha 106 — a concessão precisa de "even"**

Sugestão: `necessary, an advantage that exists even under complete information.`

**28. Linha 107 — comprimido demais**

Sugestão: `solve each voting rule twice, once with the hegemon's type public and once with it private, and`

**29. Linha 119 — um terceiro rótulo para o mesmo objeto**

Os termos do paper são "informational rent" e "the difference of differences" /
ΔRI. "informational advantage" não aparece em nenhum outro lugar do arquivo.

Sugestão: `Above the pooling cutoff, the low type's difference of rents is positive when...`

**30. Linhas 120–121 — escopo ambíguo**

"with or without information" lê-se como se a informação fosse opcional para a
exclusão. O sentido pretendido é exclusão nos dois jogos, público e privado.

Sugestão: `...or when majority excludes the hegemon under both public and private information, zero when...`

**31. Linha 131 — sintagma solto**

Sugestão: `with unanimity, each through a distinct mechanism. @piazolo2025legislative study`

**32. Linha 135 — verbo ambíguo de forma**

"shut down" é idêntico no presente e no passado; ao lado de "show" no presente, o
leitor tropeça.

Sugestão: `under unanimity. @glynia2026unanimity close the dynamic channel and show`

**33. Linha 149 — o único marcador de enumeração chega no terceiro item**

Sugestão: marcar os três (`First,` / `Second,` / `Third,`) ou tirar o "And".

**34. Linhas 159–160 — "it" ambíguo**

Sugestão: `...and the voting rules under which that channel operates.`

**35. Linhas 166–167 — determinantes mistos e jargão não glosado**

Sugestão (incorporando 10 e 11): `its limits. The appendices give the proofs, the endpoint conventions, the exact correspondence tables, and the worked values.`

**36. Linhas 41–42 — afirmação de data checável**

A OMC foi estabelecida em 1995, quatro a seis anos depois das datas usuais para o
fim da Guerra Fria. "immediately" é o tipo de palavra que um parecerista confere na
primeira frase.

Sugestão: `In the years following the end of the Cold War, at the height of American power, the United States led the creation of the World Trade Organization.`

**37. Linhas 42–43 — possessivo momentaneamente ambíguo**

Sugestão: `Under WTO rules, states hold equal voting power,`

---

## Veredicto

**Erros: 12. Tradução: 9. Clareza: 16.**

Dois critérios do autor voltaram limpos e ficam registrados. Não há construção
`não é X, mas sim Y` em nenhum ponto das linhas 37–168; o único "rather than"
(linha 79) é pergunta genuína de repartição e deve ficar como está. Tampouco há
violação de atemporalidade: nenhum "now", nenhum "previously", nenhuma referência
a estado anterior do manuscrito.

A seção **não está pronta para congelar**. Os defeitos não estão espalhados por
igual: as linhas 41–64, a abertura traduzida, carregam seis dos doze Erros e sete
dos nove itens de Tradução, e dois deles são estruturais, não cosméticos — o
"thus" da linha 62 tira a conclusão oposta à sua própria premissa (item 2), e a
dobradiça que justificaria pôr de lado a explicação do poder informal está
simplesmente ausente (item 25). Um leitor que chegue frio à linha 62 não consegue
acompanhar o argumento. Fora da abertura, o item 10 é o outro bloqueador.

Gate recomendado: corrigir os doze Erros e os itens 13–20, que são mecânicos e
saem numa passada. Os itens 22–25 pedem o autor, não um editor, porque envolvem
decidir qual é a resposta padrão da literatura e por que o paper a põe de lado.
Os demais itens de Clareza podem viajar para uma passada posterior sem custo.
