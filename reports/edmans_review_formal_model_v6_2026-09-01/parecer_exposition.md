# Parecer de Exposition (Framework Edmans)

**Candidato avaliado:** `formal_model_v6.pdf`  
**Commit:** `611727865a9e0c6e9af142c84fcae4f2e18747df`  
**SHA-256 do PDF:** `146fee55cb063b645121f2a6802a85c58816c542a5474442691c0903af5fafc4`

## Score: 5/10

## Avaliação por dimensões

### Clareza [Fraca]

#### Qualidade da escrita

A redação matemática é, em geral, cuidadosa: proposições, tabelas e figuras têm numeração consistente, e as seções 4–7 preservam bem distinções difíceis entre tipos, informação pública e privada, correspondências vazias e multiplicidade. Entretanto, o PDF ainda contém marcas inequívocas de versão de trabalho, suficientes para impedir submissão:

- Na p. 3, a frase isolada “I show that..” é texto truncado justamente no lugar em que a introdução deveria apresentar os resultados. O roteiro subsequente também omite a Seção 6, que introduz toda a extensão de agenda. Sugestão de substituição:

  > “Three results emerge. First, majority can bypass the privately informed hegemon, whereas unanimity makes its approval an essential input. Second, above the pooling cutoff, unanimity grants the low type a rent of \(\beta(h-l)\), while an intermediate-belief region has no equilibrium in pure ballot strategies. Third, adding a mandatory hegemonic proposal stage weakly benefits both types under unanimity wherever both arms exist, but yields no general sign under majority.”

- Na p. 9 permanece o marcador “[AUTHOR: P1]”. A ideia pode ser integrada diretamente:

  > “Because disagreement is realized only after Round 2, a first-round no vote delays agreement rather than removing the voter from the game.”

- Há vocabulário de controle interno que não pertence ao artigo: “exact N7 formulas” (p. 23), “none in the source correspondences” e “pure-PBE M/S/B architecture” sem definição (p. 26), “the frozen result” e “later external consultation” (p. 57), “scripts check hashes, schemas” e “source manifests” (p. 61), “six later advisory corollaries” e “frozen theorems” (p. 62). A legenda da Figura 7 ainda diz “Historical annotations, if used” (p. 31). Esses trechos devem ser reescritos em linguagem substantiva. Por exemplo:

  > “Computational checks verify the enumerated identities and inequalities; equilibrium completeness rests on the proofs.”

- Persistem problemas pontuais de copyediting: “International Organizations” e “Coercion and Information institutions” com capitalização inadequada; “OMC” em um texto integralmente em inglês (p. 2); alternância “they highlighted”/“they show” (p. 3); e “legislative- bargaining” (p. 6). Uma formulação mais limpa para a abertura seria:

  > “Yet the WTO’s consensus rule gave every member a veto and conferred no exclusive formal proposal right on the United States.”

A apresentação visual é globalmente limpa, sem sobreposições ou glifos quebrados, mas há problemas de acabamento. As Figuras 2, 3, 4 e 7 (pp. 17, 19, 23 e 31) contêm títulos, notas, parâmetros e longos textos explicativos em fonte muito pequena dentro do gráfico, seguidos de nova legenda externa. A informação deve ser dividida: gráfico com apenas eixos, regiões e duas ou três anotações; hipótese, parâmetros e interpretação na legenda. A p. 34 contém apenas quatro linhas da conclusão e quase uma página inteira em branco. A Tabela 7 (pp. 42–43) tem entradas comprimidas — por exemplo, a definição de \(x\) e “\(x_H,x_j,x_i\)Allocations” — e a Tabela 10 atravessa três páginas (pp. 62–64) com colunas excessivamente estreitas, espaçamento irregular e ausência de cabeçalho repetido na última página.

#### Significância econômica/substantiva

O abstract, com cerca de 234 palavras, contém a arquitetura completa, mas apresenta resultados como uma sequência de qualificações: “conditional”, “empty in some belief regions”, “a correspondence”, “linked type vectors” e “no general sign”. O leitor termina sabendo que o resultado é cauteloso, mas não qual é a descoberta memorável.

Para um paper teórico, o equivalente da magnitude substantiva pode ser um cutoff, uma diferença de payoff ou uma reversão transparente. O manuscrito já contém bons candidatos, mas os enterra:

- \(p^*=(h-l)/(1-l)\);
- o rent do tipo baixo sob pooling, \(\beta(h-l)\);
- no exemplo da p. 23, a diferença de rents informacionais entre unanimidade e maioria é `0.215` para o tipo baixo;
- na p. 25, a informação reverte a vantagem pública da maioria para o tipo baixo, de `−0.4095` para `+0.1385`.

Uma frase memorável no abstract poderia ser:

> “In the four-weak-state illustration, private information raises the low type’s informational-rent advantage under unanimity by 0.215 of the unit surplus.”

Ela deve ser imediatamente qualificada como ilustração teórica, não calibração.

#### Precisão da linguagem

Algumas formulações corretas são vagas para um leitor não imerso na construção:

- “The institutional ranking is conditional” (abstract) deveria nomear as condições: o tipo, a região do outside option, a classe de equilíbrio majoritário e a existência do braço de unanimidade.
- “Public agenda power can favor either rule” deveria apresentar a fronteira: para \(o>1/m\), o sinal depende de \(\beta o-e/m\).
- “The maintained pure-strategy correspondence is empty” deveria ser traduzido antes do jargão:

  > “For intermediate beliefs, no pure contingent voting pattern is sequentially rational under the maintained belief and pivotal-voting restrictions.”

- “Binder”, “fiber product”, “exact signature”, “source correspondence” e “literal continuation member” tornam as pp. 43–61 semelhantes a documentação de uma arquitetura computacional. Se esses objetos forem matematicamente indispensáveis, devem ser definidos por sua função econômica antes da definição formal; caso contrário, devem permanecer apenas no suplemento técnico.

### Extensão [Longo]

#### Introdução

A introdução ocupa aproximadamente 2,5 páginas, portanto está confortavelmente abaixo do teto de seis páginas. O problema não é excesso, mas ausência do conteúdo mais valioso. Ela contém contexto histórico, literatura próxima e o desenho geral do jogo, mas não apresenta resultados porque o parágrafo central está truncado.

A sequência recomendada é:

1. paradoxo substantivo da igualdade formal;
2. mecanismo em uma frase — maioria oferece substitutos, unanimidade transforma a aprovação informada em insumo essencial;
3. jogadores, informação, ações e comparação contrafactual;
4. três resultados exatos, incluindo o domínio de não existência;
5. contribuição frente a Piazolo–Vanberg e Glynia–Thum–Xefteris;
6. roteiro completo, incluindo a Seção 6.

Hoje a literatura aparece antes de o leitor conhecer os resultados. Isso enfraquece a diferenciação porque ainda não existe uma contribuição claramente formulada para comparar com os trabalhos anteriores.

#### Notas de rodapé

Não identifiquei notas de rodapé no PDF. Isso é positivo: as qualificações estão no texto ou nos apêndices, sem navegação em staccato. O risco oposto é que restrições técnicas demais tenham permanecido no texto principal; várias poderiam ser deslocadas para uma seção compacta de escopo ou para o suplemento.

#### Extensões desnecessárias

O manuscrito tem 66 páginas: a conclusão termina na p. 34, os apêndices ocupam as pp. 35–64 e as referências, as pp. 65–66. Para um artigo formal, a extensão total não é automaticamente excessiva, mas a qualidade média cai porque a extensão de agenda recebe uma quantidade desproporcional de infraestrutura.

A Seção 6 ocupa aproximadamente sete páginas do texto principal e os Apêndices E–F acrescentam cerca de 19 páginas de correspondências Borel, binders, assinaturas, fatorizações e regras de propagação de células vazias. Recomendo manter no artigo:

- o desenho factorial \(T=D+I\);
- as duas ou três proposições economicamente interpretáveis;
- o resultado de vantagem suficiente da maioria;
- a reversão informacional ilustrativa.

A caracterização integral de leis Borel, assinaturas exatas, órbitas de relabeling e verificações de esquema deve ir para suplemento técnico online, com um breve teorema de representação no artigo.

Há ainda redundâncias removíveis:

- A Tabela 10 (pp. 62–64) amplia a mesma reconstrução Steinberg–primitivas já apresentada na Tabela 1 (p. 5). Uma única tabela de uma página seria superior.
- A Figura 7 repete a região vazia e o pooling já mostrados nas Figuras 2 e 3. Seu valor marginal não parece superar o custo de leitura.
- As várias tabelas de correspondências exatas podem ser consolidadas em uma tabela principal de resultados e tabelas completas no suplemento.

### Citações [Algumas problemáticas]

#### Extensão da bibliografia

A bibliografia ocupa apenas duas páginas e é proporcional ao artigo. As referências estão concentradas nas literaturas diretamente relevantes — bargaining legislativo, informação privada e instituições internacionais — e não há evidência de inflação bibliográfica sistemática.

#### Problemas específicos

- Na p. 2, “many coalitions” é uma afirmação ampla sustentada apenas pelo documento do Cairns Group. A evidência apresentada permite uma frase mais estreita:

  > “The Cairns Group submitted an agricultural proposal during the Uruguay Round (Cairns Group 1987).”

  Para manter “many coalitions”, seria necessário citar evidência mais abrangente.

- As afirmações específicas sobre a retirada de GATT 1947, perda de tratamento de nação mais favorecida e alteração do fallback aparecem nas pp. 2 e 31–32 sob uma referência geral a Steinberg (2002). Devem receber páginas precisas e, idealmente, o documento primário do GATT/WTO. O mesmo vale para as numerosas práticas listadas nas Tabelas 1 e 10: cada conjunto de linhas deveria ter fonte ou pinpoint próprio.

- A menção a Fearon (1995) na p. 2 — “much like Fearon did for war” — é retórica, não necessária ao argumento. Se não houver analogia analítica específica, a frase pode ser substituída por:

  > “The unresolved problem is therefore strategic: why choose a rule that makes the hegemon’s approval formally equal to every other member’s?”

- Na p. 10, Fudenberg–Tirole, Osborne–Rubinstein e Kreps–Wilson são usados para analogias com uma disciplina off-path específica do artigo. A redação já admite que a regra é parte do conceito mantido, mas deveria separar com mais nitidez antecedente e escolha autoral:

  > “We impose support-preserving off-path beliefs: a degenerate prior remains degenerate. This is an explicit equilibrium restriction, not a consequence of the cited solution concepts.”

Não afirmo que essas referências estejam substantivamente erradas; o problema de exposição é que o leitor não consegue distinguir rapidamente o que é resultado conhecido, analogia e restrição nova do autor.

## Veredicto geral sobre exposition

O manuscrito tem uma arquitetura intelectual promissora e uma apresentação matemática mais disciplinada do que o score isolado sugere. Contudo, o PDF atual não está em condição de submissão: o parágrafo de resultados da introdução está ausente, há um marcador explícito de autor, permanecem numerosos termos de workflow interno, e a extensão de agenda domina o artigo com uma infraestrutura técnica cuja função econômica se perde. A exposição hoje obscurece a contribuição em vez de simplesmente transmiti-la. Uma rodada editorial concentrada — não uma mudança do modelo — poderia elevar bastante o paper: o objetivo deve ser fazer o leitor lembrar “substitutos sob maioria, insumo essencial sob unanimidade, rent do tipo baixo e interação com agenda”, e não “binders, fibers e frozen sources”.

## Top 5 sugestões de melhoria

1. **Reconstruir imediatamente abstract e introdução.** Substituir “I show that..” por três resultados exatos, inserir uma magnitude ilustrativa e explicar em linguagem comum a região sem PBE pura. Atualizar também o roteiro para incluir a Seção 6.
2. **Eliminar todos os resíduos de produção interna e fazer copyedit integral.** Remover `[AUTHOR: P1]`, `N7`, `M/S/B` não definido, `source correspondence`, `frozen result`, `external consultation`, hashes, schemas, manifests e advisory corollaries; corrigir `OMC`, capitalização, hifenização e tempos verbais.
3. **Reduzir radicalmente a infraestrutura da extensão de agenda no corpo do paper.** Manter resultados e intuição econômica; mover a caracterização Borel, binders, assinaturas e fatorizações para suplemento técnico. Definir em linguagem substantiva qualquer objeto que permaneça.
4. **Redesenhar figuras, tabelas e paginação.** Aumentar fontes e retirar notas longas de dentro das Figuras 2, 3, 4 e 7; eliminar a Figura 7 se não acrescentar resultado; corrigir a Tabela 7; fundir as Tabelas 1 e 10; repetir cabeçalhos em tabelas multipágina; eliminar a página quase vazia 34.
5. **Aumentar a precisão documental das citações institucionais.** Acrescentar pinpoints e fontes primárias às afirmações sobre GATT/WTO, estreitar a alegação baseada no Cairns Group, remover a menção retórica a Fearon e distinguir explicitamente restrições autorais de conceitos herdados da literatura.
