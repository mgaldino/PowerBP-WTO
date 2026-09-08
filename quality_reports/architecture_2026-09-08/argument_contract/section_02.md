# Leitura independente da seção 2

- `reader_id`: `/root/architecture_reader_2`
- Data: 2026-09-08.
- Perfil: `formal`.
- Artefato: `quality_reports/architecture_2026-09-08/architecture_note.Rmd`.
- SHA-256 final conferido: `493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3`.
- Checkout observado: `codex/exposition-items20-28`; o pacote desta tarefa e seus scripts constavam como arquivos não rastreados no preflight.
- Seção de responsabilidade exclusiva: **Arquitetura candidata e demonstrações condicionais**, linhas 163–489, compreendendo as seis subseções 2.1–2.6. Documento completo lido para resolver referências e limites.
- Natureza do registro: extração interpretativa, sem auditoria de validade das provas, sem alterações no candidato e sem juízo de aprovação científica.
- Histórico dos bytes: a leitura integral no hash `0223eea09bd952538b4f218a457412ba51b0cbd4fef9556a70d205f12e5c63ee` foi preservada em `section_02_0223eea_historical.md`. Esta versão registra revalidação por impacto para o hash atual, com verificação da base anterior, do diff e das passagens afetadas. Todos os localizadores dos claims abaixo pertencem à versão atual.

## Tese da seção

A seção constrói um jogo candidato completo, `G_C`, por meio de três hipóteses adicionais: a concessão a H requer execução própria, o recurso de execução é indivisível e rival entre clube e exterior, e um voto sim assume compromisso vinculante condicional à aprovação. Depois de não seguido de aprovação, H conserva uma decisão voluntária entre executar o clube e o exterior. Essa tecnologia impede dois recebimentos positivos em qualquer história factível e dá a H o valor `max{x_H,o}` quando escolhe otimamente nesse ramo.

Com o domínio e o conceito da seção 1.3, a nota afirma que essa alteração preserva os votos puros prescritos, as propostas ótimas, as crenças admissíveis e os resultados econômicos do jogo histórico com cancelamento, após projetar fora a nova decisão terminal. Isso abrange propostas desviantes para a determinação das respostas prescritas, mas não afirma igualdade dos pagamentos de H depois de todo perfil arbitrário de desvios. A comparação é com `G_0`, não uma demonstração de que a especificação vigente incompleta `G_*` já tenha a mesma arquitetura.

## Claims, evidência textual e alcance

Todos os localizadores de linhas nesta tabela se referem ao Rmd de SHA-256 indicado no cabeçalho. “Evidência” significa o argumento que o texto oferece; este registro não certifica que a demonstração esteja correta.

| Claim | Localizador | Evidência oferecida | Scope/hedge |
|---|---|---|---|
| A candidata requer três cláusulas matemáticas conjuntas e decisões autorais distinguíveis. | §2.1, L167–168; contexto §1.1, L35–55 | Apresentação explícita das três cláusulas, identificadas como adicionais e ainda não adotadas. | Construção condicional fora do manuscrito; não são resultados já implicados pelos fundamentos vigentes. |
| A concessão `x_H` é uma oportunidade cujo benefício exige execução por H; compromissos são específicos ao destinatário e não negociáveis após a votação. | §2.1, cláusula A1, L170–176 | Definição econômica da concessão; os compromissos somam no máximo um. | Os fracos mantêm seus pagamentos aprovados independentemente do voto; a execução de H não afeta esses pagamentos nem a aprovação dos outros. |
| Clube e exterior exigem o uso inteiro do mesmo recurso de H. | §2.1, cláusula A2, L178–192 | Conjunto de usos `{C,O}`; proibição tecnológica de empréstimo, duplicação, fracionamento e sequência das duas execuções no terminal. | Hipótese nova; o exemplo de capacidade produtiva é abstrato, sem alegação empírica sobre uma organização específica. A independência do valor externo em relação ao acordo dos outros é mantida. |
| O sim de H compromete o recurso ao clube somente se houver aprovação; o não seguido de aprovação mantém a escolha de execução. | §2.1, cláusula A3, L194–200 | Especificação dos ramos de sucesso e fracasso; depois de não, `x_H` continua disponível. | O não não causa saída antecipada; fracasso preserva continuação ou desacordo terminal. O compromisso de sim é vinculante. |
| A escolha de execução amplia o protocolo e as estratégias de H sem criar nova barganha, desconto, pagamento lateral ou comunicação anterior à votação. | §2.1, L202–207 | Descrição do novo nó e aplicação da mesma tecnologia às duas instituições. | Se a candidata for levada à agenda, o sim automático de H proponente também precisará assumir esse compromisso; a frase não certifica a migração da extensão. |
| A oportunidade não executada não é redistribuída e pode produzir capacidade contratada não utilizada. | §2.1, L209–218 | Estoque de oportunidades fixo e sem retorno ao proponente; interpretação de excedente disponível. | Nega realização total de um em toda história. Nas propostas ótimas dos assessments considerados, esgotamento se refere à soma das alocações prometidas; não afirma execução integral depois de desvios. |
| A implementação mantém todas as classes de história e acrescenta a escolha de execução apenas depois de aprovação com H não. | §2.2, tabela de histórias e caption, L224–233 | Linhas próprias para aprovação com sim, aprovação com não, fracasso em R1 e fracasso em R2. | A escolha observa o resultado final; não entra na votação simultânea. Fracasso em R1 não gera recebimento atual. |
| Nenhuma história factível paga simultaneamente a H recebimentos positivos do clube e do exterior. | §2.2, equação (1), Proposição C1 e prova, L235–256 | Cada ação factível dá `(x_H,0)` ou `(0,o)`; aprovação com sim compromete o recurso ao clube; fracasso não fornece parcela do clube. | Propriedade tecnológica sob as três cláusulas, inclusive execução subótima e desvios anteriores quaisquer. Não depende da otimalidade da proposta. |
| A melhor resposta depois de aprovação com não é clube se `x_H>o`, exterior se `x_H<o`, e ambas na igualdade; o valor é `max{x_H,o}`. | §2.2, Proposição C1, L244–252 | Comparação dos dois retornos da equação (1). | Refere-se à escolha ótima no novo nó. O conjunto de histórias factíveis continua incluindo escolhas subótimas. |
| O desempate de voto não seleciona a ação de execução na igualdade. | §2.2, L258–261 | Correspondência `{C,O}` quando `x_H=o`; seleção canônica de `C` apenas como representante. | O teorema de transporte não depende dessa seleção; estratégias completas podem diferir entre extensões. |
| Alguns pagamentos depois de votos desviantes de H diferem do cancelamento histórico. | §2.2, L263–268; remissão à Proposição D1, L136–143 | Para `x_H=1/5`, tipo `o=1/10` que vota não escolhe clube e recebe `1/5`, enquanto no histórico receberia `1/10`; tipo `7/20` escolhe exterior. | O primeiro não é identificado como desvio da estratégia prescrita. O exemplo sustenta diferença entre terminais dos jogos, não diferença de resultado sob as respostas prescritas. |
| Em R2 sob maioria, H vota sim exatamente quando `x_H>=o`. | §2.3, equação (2) e comentário, L272–285 | Os votos fracos bastam; H compara `x_H` com `max{x_H,o}`, usando `T^Y`. | Para `x_H>o`, há empate na candidata e preferência estrita por sim no histórico. Preservação da estratégia não significa preservação de ambas as utilidades das ações. |
| Em R2 sob maioria, o proponente recebe um, os demais recebem zero do clube, H escolhe exterior e cada fraco tem continuação ex ante `1/m`. | §2.3, Proposição C2 e prova, L287–298 | Aprovação garantida pelos fracos; parcelas a outros e sobra de orçamento reduzem o residual do proponente sem melhorar aprovação; reconhecimento uniforme. | Em cada conjunto de informação de proposta, independentemente da crença. Valores em unidades de R2, sem desconto interno. |
| Sob unanimidade terminal, o novo ramo é impossível pela quota e o jogo é idêntico ao histórico. | §2.3, L300–302 | A aprovação exige o sim de H, inclusive após desvios dos fracos. | Afirmação específica à unanimidade; não se estende como identidade literal à maioria. |
| A escolha terminal unânime é a oferta baixa até `p*=(h−ell)/(1−ell)`, inclusive a igualdade, e a alta acima desse corte. | §2.3, equação (3), L303–316 | Comparação `(1−mu)(1−ell)` com `1−h`; redução de ofertas ao menor valor que preserva aceitação; desempate do proponente. | `mu` é a crença corrente; ofertas rejeitadas por ambos são inferiores. Trata seleção de tipos e pooling terminal. |
| As continuações unânimes por tipo são `(ell,h)` no ramo baixo e `(h,h)` no ramo alto, com as continuações fracas da equação (4). | §2.3, equação (4) e comentário, L318–330 | Vetor explícito: fraco recebe `(1−mu)(1−ell)/m` ou `(1−h)/m` antes do reconhecimento. | Coordenadas de tipos com peso zero não recebem peso artificial em expectativas. No benchmark público H recebe `o`; não entra `beta` nas equações (2)–(4). |
| Em R1 sob maioria, cada fraco vota sim exatamente quando `x_j>=w`, com `w=beta/m`. | §2.4, L334–338 | Continuação terminal da Proposição C2; comparação com a própria parcela de aprovação. | Em toda proposta; a comparação não depende de crença, voto de H ou identidade do proponente anterior. |
| O voto de H em R1 sob maioria depende de três classes de contagem dos respondedores fracos que votam sim. | §2.4, tabela, caption e explicação, L340–352 | Se `n_Y>=k`, compara `x_H` e `max{x_H,o}`; se `n_Y=k−1`, compara `x_H` e `beta o`; se `n_Y<=k−2`, ambas as ações dão `beta o`. | Contra estratégias puras prescritas e conhecidas, com `T^Y`. A contagem não pressupõe observação dos votos simultâneos. Um desvio efetivo de fraco é resolvido no terminal conforme (1). |
| Uma proposta ótima positiva a H não passa com H não quando os fracos seguem suas respostas prescritas. | §2.4, Proposição C3 e prova, L354–367 | Na classe que passa sem H, a alternativa ex ante `x'_H=0`, `x'_i=x_i+x_H` mantém factibilidade, parcelas fracas e aprovação e melhora estritamente o proponente; nas outras classes, H não implica fracasso ou não há aprovação. | Qualquer conjunto de informação e cada tipo, inclusive com posterior corrente zero. R2 usa a Proposição C2; unanimidade decorre da quota. A hipótese sobre votos fracos é expressa. |
| A exclusão ótima não elimina seleção de tipos nem implica ganho estrito entre duas ofertas que fracassam com a mesma continuação. | §2.4, L369–372 | Exemplo pivotal: oferta `beta ell` aceita pelo tipo baixo, rejeitada pelo alto, com fracasso no alto. | Limitação explícita da Proposição C3; não proíbe toda oferta positiva rejeitada por algum tipo. |
| Os candidatos econômicos em R1 são exclusão, screening, pooling e desacordo, com valores em (5); sua comparação em (6) preserva cortes históricos. | §2.4, equações (5)–(6) e explicação, L374–403 | Valores `Pi_E`, `Pi_S(p)`, `Pi_P`, `Pi_D` e diferenças algébricas; exclusão supera desacordo porque `k+1<=m` e `beta<1`. | Candidatas de inclusão precisam ser factíveis antes da otimização. Em `h=1/m` preserva a família residual de misturas com o mesmo peso ligando resultados e payoffs; não faz média entre parâmetros ou pesos. |
| Sob unanimidade em R1, a árvore de barganha e a continuação são as mesmas do histórico. | §2.5, L407–413 | O único novo ramo nunca é acionado; a equação (4) entra multiplicada uma vez por `beta`. | A continuação de H baixo no ramo de pooling é `beta h`, não genericamente `beta o`. |
| O Teorema C4 afirma igualdade das correspondências de propostas, votos puros prescritos e crenças admissíveis após projetar fora a nova ação terminal. | §2.5, enunciado C4, L415–423 | Demonstração por resolução terminal, comparação das ações relevantes, igualdade das continuações e extensão/restrição de assessments, L425–458. | Sob as três cláusulas, domínio da seção 1.3 e conceito aprovado. Resultados induzidos são iguais, incluindo endpoints, misturas e células sem assessment; não identifica estratégias completas sem projeção nem todos os pagamentos desviantes. |
| A igualdade das avaliações relevantes vale ponto a ponto e conserva o desempate entre propostas e integrais de propostas sorteadas. | §2.5, prova C4, L425–457 | Pagamentos fracos não mudam em vetores de votos; posteriores e continuações após fracasso são os mesmos; execução futura não atualiza crenças antes da votação; extensão por melhores respostas em (1). | Valores para H são comparados sob as respostas prescritas; tipos de posterior zero são avaliados sem lhes atribuir probabilidade positiva. Diferentes escolhas de execução em igualdade podem fornecer extensões distintas. |
| O transporte não reaudita a caracterização histórica de unanimidade nem melhora sua existência. | §2.5, L460–466 | Se B.4 caracteriza corretamente `G_0`, a célula vazia em `0<p<=p*` e as células de acordo transportam-se; o ramo adicional é inacessível. | Declaração explicitamente condicional à correção de B.4. Não cobre votos fracos mistos ou outro desempate. |
| A execução possui informação suficiente local, mas propostas e votos preservam a história pública inteira e a informação privada de H. | §2.6, L470–475 | Estado de execução `(x_H,o,a_H,A)`; independências de valores atribuídas às provas terminais. | Não restringe crenças do baseline a uma seleção markoviana da extensão. |
| A solução e a invalidação seguem as dependências do jogo condicional. | §2.6, L477–489 | Execução → R2 de cada instituição → R1 → correspondências/consumidores; interfaces e `game_dag.json` são nomeados; alterações de cláusulas ou disciplina reabrem descendentes. | Fechamento interno não significa adoção, congelamento ou certificação de `G_*`. Mudar a escolha ótima na igualdade de execução altera o representante completo sem alterar valores transportados. |

## Não-afirmações a preservar

1. A nota não afirma que as cláusulas econômicas já pertençam aos fundamentos aprovados nem que `G_*` já seja `G_C` ou `G_0` (L35–55, L84–88, L167–192, L477–483).
2. Não apresenta a exclusividade tecnológica como consequência genérica de forum shopping nem o exemplo de capacidade produtiva como evidência empírica (L185–192).
3. Não afirma que a soma de benefícios realizados dentro do clube seja um em toda história (L209–218).
4. Não cancela a oportunidade `x_H` por voto não nem a devolve ao proponente após a votação (L194–200, L209–211, L263–268).
5. Não identifica não com saída antecipada ou ausência obrigatória de participação na execução (L194–200; contexto L619–623).
6. Não usa `T^Y` para desempatar a nova escolha terminal de execução (L258–261).
7. Não afirma que H observe votos simultâneos antes de escolher o próprio voto (L348–352).
8. A exclusão da Proposição C3 não elimina histórias desviantes nem todas as ofertas de seleção de tipos; sua hipótese sobre respostas fracas é expressa (L354–372).
9. Não afirma ganho estrito ao comparar duas propostas que fracassam com a mesma continuação (L369–372).
10. Não confunde igualdade da estratégia prescrita de H com igualdade de suas utilidades para as duas ações em toda proposta (L281–285).
11. O Teorema C4 não afirma identidade literal global de jogos, de estratégias completas ou de payoffs após todo perfil arbitrário de desvios (L415–423, L454–457; contexto L43–48).
12. Não reaudita integralmente B.4 nem elimina sua eventual não existência; transporta sua caracterização se correta (L460–466).
13. Não cobre votos mistos dos fracos, desempates alternativos ou uma restrição markoviana nova das crenças (L460–475).
14. Não atribui peso positivo a um tipo apenas para garantir validade da avaliação por tipo (L327–330, L454–457; domínio L117–124).
15. Não certifica, por transporte de valores, os assessments completos, assinaturas ou todos os resultados da extensão de agenda (limite contextual explícito em L523–533).
16. Não encontrei na seção 2 uma alegação de adequação empírica da tecnologia a uma organização internacional específica, de minimalidade global da arquitetura, ou de autorização para sua incorporação ao artigo. A seção 3 nega explicitamente essas extensões em L600–629.

## Esclarecimentos e ambiguidades

### A2.1 — Rótulos das cláusulas e proposições: resolvida

A leitura anterior registrou o uso simultâneo de C1–C3 para hipóteses e resultados. A candidata atual denomina as hipóteses A1, A2 e A3 (L170, L178 e L194), preserva as Proposições C1–C3 (L244, L287 e L354) e enuncia C4 sob A1–A3 (L415–416). As referências “em R2 aplica-se C2” e “usando C3” continuam apontando às proposições (L366–367 e L374). O macro confirmou essa interpretação, e o texto agora a distingue por rótulo. Não resta ambiguidade interpretativa nessa referência.

### A2.2 — “Resultado de esgotamento histórico”: resolvida por delimitação explícita

A leitura anterior registrou que a frase não definia esgotamento. A candidata atual explicita: “Nas propostas ótimas dos assessments considerados, a soma das alocações prometidas conserva o esgotamento histórico do orçamento. Não se afirma execução integral depois de desvios” (L214–216). Assim, o claim diz respeito ao orçamento das alocações prometidas, não a realização total em toda história. A não-afirmação de total realizado igual a um em toda história permanece em L209–214. Foram reexaminadas a propriedade terminal de orçamento integral da Proposição C2 (L287–298), a comparação ex ante da Proposição C3 (L354–372) e o alcance de C4 (L415–466). Não resta dúvida de leitura sobre o objeto a que “esgotamento” se refere. Sua validade matemática é matéria da revisão posterior.

Não encontrei outra ambiguidade interpretativa na seção 2 que altere materialmente os claims para uma revisão posterior. Os limites científicos explicitamente reconhecidos permanecem registrados como não-afirmações, sem serem convertidos em defeitos.

## Termos que devem permanecer consistentes

| Termo | Sentido autorizado nesta leitura | Localizador |
|---|---|---|
| `G_0` | Jogo histórico com cancelamento, usado como referência de transporte. | L84–88; L300–302; L415–423 |
| `G_*` | Especificação vigente cujo ramo contestado ainda não foi completado. | L84–88; L477–483 |
| `G_C` | Jogo candidato completo, condicional às três cláusulas adicionais. | L84–88; L167–207 |
| Cláusulas A1–A3 | Concessão executável; recurso rival e indivisível; compromisso e opção de execução. | L170–200 |
| Proposições C1–C3 | Ausência de acúmulo; solução de R2 sob maioria; exclusão de propostas ótimas sob respostas fracas prescritas. | L244–256; L287–298; L354–372 |
| Voto | Ação simultânea que conta para a quota; sim de H cria compromisso condicional. | L98–115; L194–200; L224–233 |
| Execução `C` ou `O` | Uso terminal do recurso no clube ou no exterior; após não e aprovação, é escolha adicional de H. | L178–200; L235–261 |
| `x_H` | Benefício potencial da oportunidade contratada para H, condicionado à execução própria em `G_C`. | L170–176 |
| `r_C`, `r_O` | Recebimentos efetivamente realizados, distinguíveis da oportunidade `x_H`. | L235–256 |
| Excedente disponível | Estoque fixo de oportunidades/compromissos, cuja soma é no máximo um; pode haver capacidade contratada não utilizada. | L209–218 |
| Opção externa `o` | Valor privado do melhor fórum alternativo de H; está fora do unitário, independente dos acordos alheios e usa recurso próprio rival na candidata. | L92–109; L178–192 |
| `T^Y` | Sim na indiferença do voto em valor esperado pertinente, sem impor seleção na execução. | L111–115; L258–261; L281–285 |
| `mu`, `p`, `p*` | Crença corrente em R2; prior de tipo alto no domínio de R1; corte terminal `(h−ell)/(1−ell)`. | L92–93; L303–322; L379–393 |
| `w`, `n_Y`, `k` | Continuação fraca descontada `beta/m`; número de respondedores fracos com sim prescrito; votos necessários além do proponente. | L98–103; L334–346 |
| Screening/seleção de tipos | Oferta aceita pelo tipo baixo e rejeitada pelo alto, podendo produzir fracasso no alto. | L311–322; L369–372 |
| Transporte | Igualdade de correspondências após projetar a decisão terminal e igualdade dos resultados induzidos, com dependência da caracterização histórica quando consumida. | L415–466 |
| Assessment | Objeto de estratégias e crenças do conceito aprovado; a projeção distingue esse objeto de sua extensão com ações de execução. | L415–423; L450–457 |
| Tipo com posterior zero | Tipo que pode permanecer no suporte inicial e ser avaliado por tipo sem ganhar peso positivo artificial. | L117–124; L327–330; L454–457 |

## Perguntas ao agente macro e resolução

1. **Referência às hipóteses ou proposições:** resolvida pela confirmação do macro e pelos rótulos A1–A3/C1–C4 atuais. O contrato deve preservar os títulos completos, conforme A2.1.
2. **Objeto de “esgotamento”:** resolvida pela explicitação em L214–216. O contrato deve registrar soma das alocações prometidas nas propostas ótimas dos assessments considerados, conforme A2.2.
3. **Três alcances diferentes:** conservar em claims separados a ausência de acúmulo em todas as histórias (L244–256), a exclusão sob respostas fracas prescritas (L354–372) e o transporte após projeção (L415–466). Trata-se de orientação ancorada ao texto para a síntese, não de dúvida remanescente.

## Revalidação por impacto

- Leitura reaproveitada: `argument_contract/section_02_0223eea_historical.md`, SHA-256 `9a7a90aa2aef946fdefcb5f574957e01ac367acee74d6468f5d8c52f9ef17322`, produzida por este mesmo leitor após leitura integral do documento anterior.
- Base anterior conferida: `sources/candidate_before_label_clarification.Rmd`, SHA-256 `0223eea09bd952538b4f218a457412ba51b0cbd4fef9556a70d205f12e5c63ee`.
- Artefato atual conferido: `architecture_note.Rmd`, SHA-256 `493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3`.
- Diff conferido: `sources/label_clarification.diff`. O diff recalculado entre as duas fontes é idêntico ao arquivo fornecido. Os blocos de equações em display são idênticos entre as fontes.
- Classificação: renomeação de hipóteses e quebra de página são `editorial`; explicitação do objeto de esgotamento é tratada conservadoramente como `substantive_scoped` para leitura, pois resolve a extensão de um claim antes abreviado. Isso não afirma alteração de matemática; evita concluir invariância sem examinar a delimitação.
- Reexame focal realizado por `/root/architecture_reader_2`: cláusulas e referências A1–A3; parágrafo de orçamento em L209–218; tabela de histórias e Proposição C1 em L224–261; Proposição C2 em L287–298; Proposição C3 e valores econômicos em L354–403; C4 e dependências em L415–489. Referências alteradas da seção 3 foram conferidas no diff para consistência global.
- Partes reaproveitadas: todos os demais trechos da seção 2 e contexto das seções 1 e 3, cujo conteúdo substantivo está intacto no diff. A leitura integral antiga permanece acessível; a revalidação não é apresentada como uma segunda leitura integral independente.
- Localizadores: atualizados para os novos números de linha. As inserções após L213 deslocam os trechos posteriores em quatro linhas; os intervalos do parágrafo modificado foram ajustados ao conteúdo atual.
- Resultado interpretativo: os claims permanecem como extraídos, com o esgotamento explicitamente limitado à soma prometida nas propostas ótimas. A2.1 e A2.2 estão resolvidas. Nenhum claim sobre adequação empírica, adoção autoral ou igualdade global de jogos foi acrescentado.
- Estado: leitura da seção atual apta à síntese macro. O `PASS` do gate completo cabe à síntese com todas as seções; este record não é uma aprovação científica.

## Limite deste registro

Leitura integral da base anterior, releitura após captions e revalidação por impacto da candidata atual concluídas. Hash atual e integridade do diff verificados. Não foram executados scripts matemáticos, não foram auditadas provas históricas externas ao artefato, e não se atribui `PASS` científico ou aprovação autoral. As fontes de memória foram consultadas apenas para contextualizar a distinção histórica entre propostas ótimas e histórias desviantes; todos os claims deste registro são ancorados no documento atual.
