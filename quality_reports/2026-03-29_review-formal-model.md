# Carta Editorial — Revisao de Modelo Formal

**Referencias**: Thomson (1999), Board & Meyer-ter-Vehn (2018), Dixit (2015), Varian (1997/2016)

## Decisao: Reject-and-Resubmit

## Scores consolidados
| Dimensao              | Score  | Rating         |
|-----------------------|--------|----------------|
| Design do modelo      | 7.5/10 | Bom            |
| Apresentacao tecnica  | 6/10   | Precisa melhorar |
| Exposicao             | 7.5/10 | Boa            |
| **Global**            | 7/10   | Promissor, precisa de desenvolvimento |

## Sintese editorial

O paper tem um design de modelo que e sua maior forca: parcimonioso, com mecanismo bem isolado, e resultados contra-intuitivos que emergem de uma estrutura simples. O Curse of Knowledge e um achado genuino que deveria ser publicado. A estrutura segue exemplarmente o conselho de Varian ("start with the simplest possible model").

Porem, a apresentacao tecnica e o elo mais fraco: notacao com conflitos (S vs. S, v(mu) vs. v_S(omega)), definicoes informais, conceito de equilibrio nao declarado, provas sem steps numerados nem intuicao previa, e ausencia quase total de figuras para os resultados centrais. A exposition e boa em estrutura macro mas deficiente em exemplos concretos e intuicao verbal apos os resultados formais.

## Hierarquia aplicada: Design > Apresentacao > Exposicao

O design e forte o suficiente para justificar investimento em melhorar apresentacao e exposicao. O bottleneck NAO e o design — e a apresentacao tecnica, que esta abaixo do padrao esperado para publicacao em teoria formal. Com as correcoes indicadas (equilibrio formal, notacao limpa, figuras, worked examples), o paper estaria pronto para submissao.

## Prioridades para revisao

1. **Especificar formalmente o conceito de equilibrio** (PBE), estrategias, crencas on-path/off-path
2. **Corrigir conflitos de notacao**: renomear espaco de sinais (S vs S); substituir E[S] por E[u_S]; distinguir v(mu) de v_S(omega)
3. **Adicionar figuras**: game tree, concavificacao v(mu)/V(mu), payoffs comparativos maioria vs. unanimidade por N
4. **Incluir worked example com N=3** antes dos resultados formais
5. **Bloco formal de Assumptions** (commitment, observabilidade, tie-breaking, propostas binarias)
6. **Paragrafos de intuicao apos cada Proposition** ("In plain language, this means...")

## Recomendacao estrategica ao autor

O design do modelo e solido e publicavel. O problema e de apresentacao, nao de substancia. Uma revisao focada em (1) formalizar o equilibrio, (2) limpar notacao, (3) adicionar figuras e exemplos transformaria o paper de technical note em artigo publicavel. Recomendo:

- Para JTP/GEB: as correcoes acima sao suficientes.
- Para AJPS/APSR: alem das correcoes, enriquecer o mecanismo com tradeoff (ver Edmans Contribution) e adicionar evidencia/aplicacao empirica mais detalhada.

---

## Parecer completo — Design do Modelo (Score: 7.5/10)

### O modelo em uma frase
BF com jogador informado que usa BP; sob maioria e excluido da coalizao (Curse of Knowledge); sob unanimidade extrai surplus via BP; informado prefere unanimidade — explicando consenso em OIs.

### Tipo de contribuicao
Pergunta nova aplicada a modelo existente com forca politica isolada (exclusao de coalizao do informado).

### MD1. Qualidade da pergunta [7/10]
Puzzle real (por que consenso?), acessivel, relevante. Fraquezas: conexao modelo-puzzle e tenue (unico Sender, pie binaria vs. OMC real). Intuicao parcialmente antecipada por Steinberg (2002).

### MD2. Simplicidade e KISS [9/10]
Ponto mais forte. Modelo enunciavel em <4 paginas. Cada componente e necessario (teste Schelling-Spence satisfeito). Horizon independence e particularmente elegante.

### MD3. Isolamento do mecanismo [8/10]
Cadeia causal cristalina em 5 passos (informacao → custo maior → exclusao factivel → exclusao em equilibrio → perda de surplus). Fraqueza: commitment nao justificado para contexto de OIs.

### MD4. Riqueza de insights [7/10]
Tres insights interconectados + comparacao com Alonso-Camara. Fraqueza: estatica comparativa limitada; faltam extensoes formais (multiplos Senders, supermaioria).

### MD5. Tipo de contribuicao [7/10]
Aplicacao importante de ferramentas existentes. Tecnica (concavificacao) nao e nova. Predicoes empiricas dificeis de distinguir de alternativas.

### MD6. Processo de construcao [8/10]
Exemplar em progressao bilateral → multilateral → maioria → unanimidade. Faltam: worked example N=3 pre-proposicoes, extensoes formais.

### Sugestoes construtivas
1. Formalizar multiplos Senders
2. Fortalecer justificacao de commitment
3. Explorar mais estatica comparativa
4. Worked example N=3 antes das proposicoes
5. Discutir explicacoes alternativas explicitamente
6. Regras de votacao intermediarias (supermaioria)
7. Endogeneizar aquisicao de informacao

---

## Parecer completo — Apresentacao Tecnica (Score: 6/10)

### Problemas principais

**Notacao**: Conflito S (Sender) vs. S (espaco de sinais). E[S] ambiguo (jogador como variavel aleatoria). v(mu) reutilizado como v_S(omega). alpha usado sem definicao. 5+ simbolos introduzidos sem definicao formal previa.

**Definicoes**: Nenhuma definicao formal com destaque tipografico (ambiente definition carregado mas nao usado). Concavificacao mencionada sem explicacao. "Informational power", "Curse of Knowledge", "BP gain" nao definidos formalmente.

**Provas**: Texto corrido sem steps numerados. Sem explicacao informal antes das provas. Lemma 3 sem prova propria. Proposicao 4 (resultado mais sutil) comprimida em 1 paragrafo.

**Figuras**: Apenas 1 figura (caso bilateral, nao o resultado central). Falta game tree, concavificacao, graficos comparativos maioria vs. unanimidade.

**Assumptions**: 5 assumptions implicitas nao declaradas (commitment, observabilidade, tie-breaking, simetria, propostas binarias).

**Equilibrio**: Conceito nao declarado. Equilibrios multiplos nao discutidos. Crencas off-path nao especificadas.

### Sugestoes construtivas (priorizadas)
1. Renomear S → M (espaco de mensagens) ou S₀ (Sender)
2. Substituir E[S] por E[u_S] em todas as proposicoes
3. Bloco formal de Assumptions 1-5
4. Game tree + concavificacao + graficos comparativos
5. Worked example N=3 ponta a ponta
6. Steps numerados nas provas + proof sketches
7. Declarar PBE formalmente
8. Usar ambiente definition para conceitos centrais
9. Definir alpha, q, f_R(T) com destaque
10. Eliminar reuso de v para significados distintos

---

## Parecer completo — Exposicao (Score: 7.5/10)

### ME1. Estrutura [8/10]
Gancho na primeira pagina. Resultado principal cedo. Fluxo logico solido. Fraqueza: Secao bilateral atrasa resultado central.

### ME2. Introducao [8.5/10]
Contribuicao clara nos primeiros paragrafos. Sem laundry lists. Fraqueza: falta puzzle explicito como gancho (a pergunta da OMC so aparece na Secao 7).

### ME3. Escrita e estilo [7/10]
Prosa direta. Algumas frases longas. Violacoes menores (frases comecando com simbolo). Nao ha apendice — provas e material tecnico inline.

### ME4. Extensao [7/10]
Conciso no geral. Secao bilateral desproporcional. Comparacao com Alonso-Camara duplicada (intro + Secao 7).

### ME5. Exemplos e intuicao [6.5/10]
Ponto mais fraco. Falta exemplo motivador concreto. Falta intuicao em ingles apos cada Proposition. Aplicacao WTO excelente mas aparece tarde. Falta worked example N=3.

### Sugestoes construtivas (priorizadas)
1. Worked example N=3 antes/logo apos o modelo
2. Abrir com puzzle empirico ("Why do IOs operate by consensus?"), nao com contribuicao tecnica
3. Paragrafo de intuicao em ingles apos cada Proposition
4. Comprimir secao bilateral, mover material tecnico para apendice
5. Eliminar duplicacao da comparacao com Alonso-Camara
