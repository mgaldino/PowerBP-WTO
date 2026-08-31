# Extração editorial da apresentação final e da reconstrução racionalista de Steinberg

**Data:** 2026-08-31  
**Status:** `EDITORIAL_EXTRACTION_ONLY` — não autoriza edição do manuscrito  
**Worktree de integração:** `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion-agenda-integration`

## 1. Objetivo e limite

Este relatório transforma dois novos insumos em decisões auditáveis para a
matriz de migração da extensão de agenda:

1. a versão final da apresentação `seminario_agenda_informacao.pdf`; e
2. a nota `2026-08-31_rationalist_reconstruction_steinberg_paper_note.md`.

A apresentação foi lida integralmente, renderizada e inspecionada slide a
slide. A nota foi lida integralmente e suas atribuições empíricas foram
conferidas contra a cópia local de Steinberg (2002). Nenhum dos dois insumos
substitui os resultados formais congelados. O relatório seleciona narrativa,
figuras e aplicações; não cria teoremas, não fecha \(A_T\) e não autoriza
alterações em `formal_model_v6.Rmd`.

## 2. Proveniência

| Insumo | Estado | SHA-256 | Observação |
|---|---|---|---|
| `presentations/2026-08-30_agenda_information_seminar/seminario_agenda_informacao.pdf` | final, 23 páginas | `f921ecf8a0885492a22999946dce7d6f8e4a4d13e4d58b9c5b991aacbc0e3836` | commit de origem `478f6be604ddab412de2728ea1ae9ee70a6bc8b3` |
| `presentations/2026-08-30_agenda_information_seminar/seminario_agenda_informacao.Rmd` | fonte do deck | `82e24a0a2ba2402becc4996640426f60db88225df925b4c9d698e909cf49f4b4` | usada para localizar fórmulas e títulos |
| `presentations/2026-08-30_agenda_information_seminar/roteiro_de_fala.md` | roteiro oral | `a5da35d723daeb40b255212d2a37dfce584615334a9d5f489d0ceec230c860d0` | apoio interpretativo, não fonte formal |
| `notes/2026-08-31_rationalist_reconstruction_steinberg_paper_note.md` | nota analítica | `b29e5dcbb79395967423cd98a409a085281faf6f596910d9a02e0a44b58a2c6c` | commit de origem `bf1edb7676ab0357787f4622925f416fc7e8a82e` |
| `references/Steinberg-ShadowLawPower-2002.pdf` | fonte primária local | não incorporada como fonte formal da matriz | usada apenas para conferir a fidelidade das atribuições da nota |

Os hashes governantes são reunidos no manifesto
`quality_reports/plans/2026-08-31_agenda_extension_migration_round2_inputs.sha256`.

## 3. O que a apresentação acrescenta à migração

| Slides | Conteúdo | Decisão de migração | Trava |
|---|---|---|---|
| 2--4 e 16 | quebra-cabeça, Steinberg, contrafactual sem agenda hegemônica e três fontes de poder | usar como espinha narrativa da introdução e da extensão | trocar “não há controle formal de agenda por nenhum agente” por “\(H\) não detém monopólio formal de propostas”; não confundir benchmark identificador com descrição da OMC |
| 7 e 10 | hiato público \(G(o)\) e reversão institucional | fundir em uma figura de dois painéis no corpo | a figura ilustra a fórmula exata e um membro/calibração; não prova ordenação global |
| 13, 14 e 19 | desenho fatorial \(D\), \(I\), \(T=D+I\) e efeito direto da agenda | reservar uma figura ou quadro para a extensão | bloqueado até o congelamento de \(A_T\) |
| 18 e 21 | incidência por tipo e exemplo numérico | mover para apêndice ou ilustração curta | identificar como exemplo, não calibração empírica |
| 22 | fronteiras de honestidade | incorporar em `Limits` e na abertura da extensão | preservar correspondências, condições de domínio e resultados sem sinal global |

A melhor contribuição visual nova para o corpo é uma figura única em dois
painéis: à esquerda, o componente de informação pública \(G(o)\); à direita, a
região em que a renda informacional do tipo baixo supera a desvantagem pública
e reverte o ranking institucional. Ela torna visível a arquitetura defendida
pelo autor: unanimidade pode ganhar por dois canais distintos, e o canal
informacional é decisivo precisamente quando o componente público aponta na
direção contrária.

O diagrama de “três poderes” deve migrar como síntese verbal, não como uma
segunda taxonomia gráfica. A figura do mecanismo de coalizões substitutas
repete a intuição já central no benchmark e não justifica, por si só, outra
figura no manuscrito.

## 4. O que a reconstrução racionalista de Steinberg acrescenta

A nota não afirma que Steinberg formulou o jogo atual. Ela aplica um movimento
analítico no espírito racionalista: práticas institucionais observadas são
traduzidas em poucos parâmetros estratégicos capazes de explicar por que
alteram o conjunto de acordos ou sua distribuição.

| Família estratégica | Práticas reunidas | Primitiva do paper | Uso recomendado |
|---|---|---|---|
| agenda e emenda | Quad, Green Room, rascunhos, pacotes difíceis de emendar | reconhecimento, proposta e regra de emenda | motivar a extensão de poder de agenda |
| opção externa e paciência | tamanho de mercado, sanções, fóruns alternativos, custo do atraso | \(o_\theta\) e \(\beta\) | microfundar heterogeneidade de continuação |
| espaço contratual e compensação | side payments, issue linkage, pacotes multidimensionais | conjunto de propostas e pie divisível | justificar a forma reduzida do pacote |
| informação e screening | sondagens, propostas, objeções e emendas observáveis | estrutura de informação e restrições de incentivo | distinguir a direção informacional de Steinberg da direção no modelo |
| compromisso e interação futura | retaliação, confiança e reputação | jogo repetido fora do baseline | registrar como extensão, não como custo ad hoc |
| participação e implementação | legitimidade, ratificação e cumprimento | payoffs de implementação e participação | manter como mecanismo rival ou complementar |

No corpo, essa tabela deve ser condensada para cerca de meia a três quartos de
página. O quadro item a item da nota pertence a apêndice ou material online.
Isso permite dizer com precisão o que o paper acrescenta: ele mantém constantes
várias fontes conhecidas de poder, remove inicialmente o monopólio de propostas
de \(H\) e mostra que a indispensabilidade de seu voto pode converter sua
informação privada em renda. A extensão recoloca poder de agenda e separa seu
efeito direto de sua interação com a informação.

Três correções da nota devem governar a redação futura:

1. aquiescência e estoppel não formam um mecanismo independente; sua força vem
   das regras de decisão, objeção, emenda e timing;
2. reputação exige interação futura e fica fora do jogo finito atual;
3. single undertaking e destruição do fallback do GATT 1947 são mecanismos
   analiticamente distintos.

A conferência da fonte primária local encontrou suporte para as práticas
descritas: direitos formais de proposta e emenda (pp. 343--344), BATNA e
paciência (pp. 347--350), Green Room/Quad e redação (pp. 354--356), single
undertaking e GATT 1947 (pp. 359--360) e informação, legitimidade, estoppel e
reputação (pp. 361--365). A tradução dessas práticas para primitivas do jogo é
uma interpretação racionalista do autor, não uma proposição atribuída a
Steinberg.

## 5. Salvaguardas de notação e interpretação

- Não transportar literalmente `\rho` da nota: na extensão, `rho` já identifica
  uma razão/família aprovada. Se for indispensável nomear o protocolo, usar
  `\mathcal P` ou escrever “protocolo de proposta e emenda”.
- Usar \(\beta\), e não \(\delta\), para paciência, preservando a notação do
  paper.
- Não escrever que agenda power “aumenta” universalmente a extração de \(H\).
  O efeito é fraco/condicional e pode ser zero sob maioria.
- A aplicação ao tipo baixo dos Estados Unidos é uma leitura teórica, não
  evidência histórica de que os Estados Unidos efetivamente eram o tipo baixo.
- “Sem poder de agenda” significa sem privilégio formal de proposta de \(H\),
  não ausência de qualquer procedimento que reconheça proponentes.
- O movimento é “Fearon-style” no sentido de reconstruir mecanismos a partir
  de incentivos; não se deve afirmar equivalência substantiva com o modelo de
  guerra de Fearon sem uma comparação bibliográfica própria.

## 6. Arquitetura editorial resultante

Mantém-se a Opção 1, sem aumentar o núcleo formal do corpo:

1. na introdução, inserir a reconstrução racionalista condensada de Steinberg e
   explicar o contrafactual identificador;
2. no começo da extensão, apresentar o benchmark público e a figura de dois
   painéis \(G(o)\)/reversão;
3. em seguida, apresentar incidência por tipo e a decomposição entre componente
   público e renda informacional;
4. somente depois do congelamento de \(A_T\), acrescentar o contraste causal
   do poder de agenda \(T=D+I\);
5. no apêndice, manter as correspondências completas, o quadro detalhado de
   Steinberg, o exemplo numérico e todas as fronteiras de domínio.

Esta extração fecha o gate de leitura da apresentação. Permanecem abertos o
congelamento formal de \(A_T\), a autorização linha a linha da matriz e a
autorização para editar o manuscrito.
