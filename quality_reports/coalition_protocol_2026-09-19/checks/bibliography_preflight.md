# Conferência bibliográfica prévia

Data: 2026-09-19. Escopo: metadados de Evdokimov (2023) contra a fonte primária local e resolução das chaves citadas no Rmd original e nos previews. A conferência passou para `references.bib` acrescido, em memória, de `derivations/evdokimov_entry.bib`. O arquivo bibliográfico canônico não foi alterado.

## Evdokimov: registro e limite da atribuição

Entrada preparada: `evdokimov2023equality`, em `derivations/evdokimov_entry.bib`.

| Campo | Valor confirmado | Evidência primária local |
| --- | --- | --- |
| Autor | Kirill S. Evdokimov | Página 1; linha 11 do texto extraído |
| Título | Equality in legislative bargaining | Página 1; linha 10 |
| Periódico | Journal of Economic Theory | Página 1; linha 4 |
| Volume, ano e identificador | 212, 2023, artigo 105701 | Página 1; linha 4 |
| DOI | `10.1016/j.jet.2023.105701` | Página 1; linha 50 |

O campo BibTeX `pages={105701}` representa o identificador do artigo, seguindo a convenção já usada no registro de Ma (2023); não é uma faixa de páginas. Não foi inventado número de fascículo. A entrada conserva o nome completo do autor e inclui DOI e URL DOI.

Fonte: [texto primário extraído](/Users/manoelgaldino/Documents/DCP/Papers/PowerPieDependent/references/extracted/evdokimov_2023_equality_in_legislative_bargaining.txt:280), seção 2.1, página 6, linhas 280–312. Evdokimov define uma proposta como um par `(C,x)`, com coalizão vencedora contendo o proponente e vetor não negativo sobre **todos** os jogadores. A condição orçamentária soma as alocações sobre `N`, e não contém `x_j=0` para `j` fora de `C`. Os membros de `C` votam simultaneamente, uma recusa impede o acordo e, havendo aprovação, a alocação é implementada para todos os jogadores. Logo, o espaço de propostas da fonte permite alocações positivas a não membros.

Um exemplo de factibilidade deixa a diferença explícita: com três jogadores, quota dois, `C={1,2}`, produtividades dos membros iguais a `1/2` e proponente 1, a alocação `x=(3/4,0,1/4)` satisfaz a restrição da fonte e remunera o jogador 3, que está fora de `C`. O exemplo demonstra apenas a factibilidade; não afirma que a proposta seria aceita ou ótima. A discussão posterior de equilíbrio na página 8, linhas 382–383, atribui zero a excluídos como propriedade de propostas ótimas no ambiente estudado, sem acrescentar essa condição à definição de factibilidade da página 6.

Na nossa candidata, a condição `x_j=0` fora de `C` é uma **restrição adicional expressamente autorizada**, documentada em [author_decision.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/author_decision.md:7), sobretudo itens 1–2 e a incidência sobre os fundamentos 4–5. A referência sustenta a representação por coalizão-alvo e consentimento de seus membros; não deve ser usada para atribuir à fonte a nossa restrição de alocações, a pie fixa, as opções externas ou o jogo de informação privada. A passagem de equivalência da fonte, seção 2.1, página 7, linhas 321–329, depende do excedente definido no próprio artigo e não certifica equivalência global dos nossos jogos.

## Cruzamento de citações

Método executado: Pandoc 3.7.0.2 leu o BibTeX concatenado com o formato `bibtex` e saída `csljson`; a leitura não emitiu avisos. O mesmo Pandoc extraiu os nós `Cite` do AST de cada Rmd, usando `markdown` e saída `json`. Uma extração independente das chaves `@...` coincidiu com o multiconjunto do AST; a busca por comandos LaTeX de citação não encontrou chaves adicionais. O e-mail do autor não foi contado como citação. As contagens abaixo são ocorrências de chaves, incluindo múltiplas chaves numa mesma citação.

| Fonte ou preview | Ocorrências | Chaves distintas | Órfãs com a entrada preparada |
| --- | ---: | ---: | ---: |
| `formal_model_v6.Rmd` original | 33 | 24 | 0 |
| `agenda_manuscript_preview.Rmd` | 33 | 24 | 0 |
| `combined_manuscript_preview.Rmd`, snapshot em disco | 34 | 25 | 0 |
| Patch do baseline aplicado em memória à fonte original | 34 | 25 | 0 |
| Composição baseline + agenda, produzida em memória | 34 | 25 | 0 |

Sem a entrada preparada, a única chave órfã nos previews com o novo baseline é `evdokimov2023equality`. A fonte original e o preview somente de agenda já resolvem todas as chaves em `references.bib`.

Inventário integral das chaves citadas; a segunda coluna vale para o original e o preview de agenda, e a terceira para os três previews com baseline novo:

| Chave | Original / agenda | Novo baseline / composição |
| --- | ---: | ---: |
| `baron1989bargaining` | 2 | 2 |
| `cairnsgroup1987proposal` | 1 | 1 |
| `chenEraslan2013informational` | 1 | 1 |
| `chenEraslan2014rhetoric` | 1 | 1 |
| `eraslan2019legislative` | 1 | 1 |
| `evdokimov2023equality` | 0 | 1 |
| `fearon1995rationalist` | 1 | 1 |
| `feddersenPesendorfer1998convicting` | 1 | 1 |
| `fudenberg1991game` | 1 | 1 |
| `glynia2026unanimity` | 2 | 2 |
| `kalandrakis2006proposal` | 2 | 2 |
| `koremenos2001rational` | 1 | 1 |
| `krasner1983structural` | 1 | 1 |
| `kreps1982sequential` | 2 | 2 |
| `ma2023efficiency` | 1 | 1 |
| `mccarty2000proposal` | 1 | 1 |
| `miller2018heterogeneous` | 1 | 1 |
| `osborneRubinstein1990` | 2 | 2 |
| `piazolo2025legislative` | 2 | 2 |
| `steinberg2002shadow` | 4 | 4 |
| `stone2011controlling` | 1 | 1 |
| `tsai2009evaluation` | 1 | 1 |
| `tsaiYang2010majoritarian` | 1 | 1 |
| `voeten2019making` | 1 | 1 |
| `winter1996voting` | 1 | 1 |

## Colisões, duplicatas e campos

`references.bib` contém 44 entradas; a adição resulta em 45. Foram encontrados **zero** casos de chave duplicada, colisão de chave ignorando maiúsculas/minúsculas, título duplicado após normalização ou DOI duplicado. A nova chave não colide com o registro conjunto `eraslan2019legislative`, de outra obra. Não há ausência de autor, título ou ano nas entradas; artigos têm periódico, livros têm editora e o capítulo tem livro e editora. Os anos estão entre 1500 e 2026. Esses testes verificam estrutura e consistência interna; somente os metadados de Evdokimov foram conferidos externamente ao `.bib`, na fonte primária local.

Há duas observações preexistentes sem efeito na resolução das citações:

- `yergin1990prize` tem ano bibliográfico 1991. É divergência entre o nome interno da chave e o campo de ano, não comprovação de erro no ano. A entrada não é citada nos arquivos conferidos.
- Treze artigos não têm DOI registrado: `kamenica2011bayesian`, `kreps1982sequential`, `cho1987signaling`, `bardhi2018modes`, `kim2025persuasion`, `fearon1995rationalist`, `cramton1984bargaining`, `admati1987strategic`, `blackhurst2000options`, `griffin1994oil`, `alhajji2000dominant`, `fattouh2013opec` e `nakov2013saudi`. Não houve busca ou preenchimento desses metadados nesta tarefa.

As 20 entradas não citadas em nenhum dos snapshots são: `admati1987strategic`, `alhajji2000dominant`, `bardhi2018modes`, `bhagwati2008termites`, `blackhurst2000options`, `cho1987signaling`, `cramton1984bargaining`, `fattouh2013opec`, `gould2016consensus`, `griffin1994oil`, `gruber2000ruling`, `ikenberry2001after`, `jawara2003behind`, `jones2010manoeuvring`, `kamenica2011bayesian`, `keohane1984after`, `kim2025persuasion`, `nakov2013saudi`, `simmons2005twilight` e `yergin1990prize`. Elas foram preservadas.

## Proveniência e limites

| Entrada ou resultado conferido | SHA-256 |
| --- | --- |
| Texto primário local de Evdokimov | `7efe0953e16bab0f71c15ea46814a9a5aa4d606e4d73b25e6346d78680bb392c` |
| `references.bib`, inalterado | `71f1413b45b44a4c55a9d0ffb4fb2e1218cfac7ced547829bd0e3eae6200f755` |
| `evdokimov_entry.bib` | `d2fe0f91396a26c955af16414e01e25e0d5b4c59815ce472fadadcedfde80ab2` |
| `author_decision.md` | `7abfa53814ff23c61a9af2049c975be81e44f8e66270c4fa3f99accd51923726` |
| Rmd original | `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411` |
| Preview de agenda | `671f139d96ca333e9ecfb45e188205f76d2497c6f5ce6ab552ac49c5d56f84f8` |
| Preview combinado em disco | `67c20caaf0ca5fff200fd18a87ea962f6512f19a478fca8537ecfacafd55f8ca` |
| Snapshot do patch do baseline | `8075a77feffe870986955d83f42d98ba7df97cf55c5fcc08249e859ca007e513` |
| Patch de agenda | `f8a6cb7d469f3723eef4480c0450b4e9b4179b40f0fdcfeb8dcdd75720437de5` |
| Preview do baseline produzido em memória | `e1c916930c68f67cbef8f3f50b250088159d7e3a4fafba0dc4ee217428f238f0` |
| Composição produzida em memória | `d68a86a466b13f051dcb896391320dbf51edd158745512ba90cf006a2e503861` |

O preview combinado em disco e a composição produzida durante esta conferência são snapshots diferentes; ambos foram testados separadamente. Não se atribui a nenhum deles identidade com versões posteriores. Não foram editados Rmd, `.bib` canônico, patches ou contratos congelados; não houve compilação do manuscrito nem revisão matemática do trabalho implementado pelo próprio agente. A entrada está preparada para integração pelo coordenador.
