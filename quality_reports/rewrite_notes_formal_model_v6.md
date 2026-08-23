# Notas editoriais: Informational Power Through Pivotality (v6)

**Arquivo original**: `formal_model_v6.Rmd`
**Data**: 2026-08-22
**Tag de segurança**: `pre-intro-abstract-rewrite-2026-08-22` (HEAD `1e43843`)
**Snapshot revisado do Goal 5**: `b5fdefb` permanece intacto e recuperável;
os novos bytes de `formal_model_v6.Rmd` são um candidato ainda não revisado.

## Diagnóstico da versão original

O abstract e a introdução vendiam o paper como "unanimidade vs. maioria sob
informação privada", território que Piazolo & Vanberg (2025) e Glynia, Thum &
Xefteris (2026) já ocupam. A contribuição própria (ator informado sem agenda;
substitutabilidade de coalizão; decomposição veto/informação via benchmark
público) aparecia tarde, em um parágrafo de "narrower contribution", e a
decomposição RI/ΔRI, que é o objeto mais distintivo do paper, não era nomeada
na introdução. O abstract tinha dois typos ("hegemeon", "approvaed") e abria
com uma pergunta retórica cuja resposta óbvia ("veto") um referee anteciparia.
A inquietação intelectual do autor (Kalandrakis 2006: agenda é poder; sem
agenda, resta outra fonte?) não aparecia em lugar nenhum.

## Principais mudanças

1. **Abertura reancorada em Kalandrakis.** P2 formula a pergunta da agenda de
   pesquisa: proposal rights são poder; o paper retira essa fonte do hegemon e
   pergunta se resta outra. `@kalandrakis2006proposal` passa a ser citado
   (chave já existia na bib, não era usada no v6).
2. **Pergunta em duas metades.** P3 separa "quando unanimidade beneficia o
   hegemon" de "quanto disso é informação e não veto", justificando o
   benchmark público antes de apresentá-lo.
3. **Decomposição nomeada na introdução.** P6 define a renda informacional
   por regra (privado menos público, tipo a tipo) e a diferença entre regras,
   sem notação. Era o item que o ChatGPT recomendou "colocar bem mais alto".
4. **Resultados com o mapa completo de sinais.** P7 cobre II/IX/XX e
   screening/pooling/exclusão em prosa: positivo (screening; exclusão em XX),
   zero (pooling), sinal de k (exclusão em II/IX), ganho/perda do tipo alto
   (a_1), célula vazia reportada como fronteira do domínio de equilíbrio.
5. **Literatura hierarquizada, não catalográfica.** P8 caracteriza os dois
   papers próximos pelo mecanismo (signaling dinâmico; insurance vs. gambling)
   e pelo objeto (preço dos votos; probabilidade de aprovação). P9 lista as
   três diferenças na ordem sugerida e lê "threat of exclusion" e "coalition
   substitute" como o mesmo fato institucional visto de dois lados.
6. **Abstract reescrito** com a mesma arquitetura: agenda como poder →
   pergunta → mecanismo → decomposição → resultado condicional → célula vazia
   → claim final ("private information can substitute for agenda control...
   only where the voting rule removes substitutes").
7. **Removido** o "three-part institutional-design question" (por que não
   agenda / por que não maioria / por que consenso), que prometia uma
   pergunta de escolha de regra que o modelo não responde (regra fixa).

## O que foi preservado

- Hook OPEC/WTO com as mesmas citações e a footnote consenso = unanimidade.
- Parágrafo do modelo (m ≥ 3, só fracos propõem, ballots simultâneos
  públicos, pie fixa, rodada terminal descontada) quase literal.
- Todas as citações existentes; nenhuma referência nova além de Kalandrakis.
- Roadmap, encurtado.
- `\enlargethispage{\baselineskip}` e posição do exemplo numérico.

## Verificação anti-LLM

- Em dashes: 0. Pivôs enfáticos (however/indeed/rather/instead...): 1
  ("rather than from the veto", P3). Construções "not X but Y": 0.
- Sem "key/central/critical/robust/nuanced". Sem finais performáticos.

## Pontos para verificação do autor

1. **Caracterização de Piazolo & Vanberg e Glynia et al.** (P8): baseada na
   leitura do ChatGPT com os PDFs anexados; os PDFs não estão em `references/`.
   Conferir que (i) P&V têm um proposer fixo e dois responders informados
   sobre o próprio disagreement value e que o resultado é "votos mais caros
   sob unanimidade"; (ii) Glynia et al. são one-shot, e o contraste
   insurance/gambling é a formulação deles.
2. **Kalandrakis (2006)** (P2): "the right to decide what is put to a vote
   translates into political power". Ajustar se o autor prefere a formulação
   exata do resultado (proposer extrai o surplus com direitos de proposta
   persistentes).
3. **Claim final do abstract**: "Private information can thus substitute for
   agenda control as a source of hegemonic power". É a tese da agenda de
   pesquisa; o modelo mostra rendas condicionais, não que a renda
   informacional iguale a renda de agenda. O "can" e o "only where" carregam a
   qualificação; confirmar que o autor aceita esse grau de força.
4. **P5, última frase**: "weak states price the hegemon as strong because a
   failed proposal has no fallback coalition". Paráfrase da lógica
   essential-input; verificar que não sugere que pooling é sempre ótimo
   (só para ν > ν*).
5. **P7**: o mapa de sinais foi conferido contra a Proposição
   \ref{prop:deltari} e a Tabela de ΔRI. "excludes the hegemon with or
   without information" = região XX; "of either sign" = k = βo₁ − o₀ em
   exclusão II/IX; perda do tipo alto = exclusão em II.
6. **P9, frase sobre Koremenos/Steinberg/Stone**: "document influence that
   formal rules do not record; the model specifies one channel". Verificar
   que o autor quer esse posicionamento (o modelo como microfundamento de
   poder informal) e não o anterior ("complements").
7. **Título**: não alterado; ver parecer na sessão.
