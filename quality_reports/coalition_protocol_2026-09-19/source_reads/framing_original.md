# Leitura do enquadramento do manuscrito original

**Reader ID:** `/root/baseline_source_read`. **Data:** 19 de setembro de 2026. **Papel:** leitor de compreensão para completar o contrato do manuscrito anterior à mudança de protocolo; não implementador, não revisor científico nesta etapa.

**Fonte original:** `formal_model_v6.Rmd`, SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`. O conteúdo integral foi capturado em memória da ferramenta antes de ler as unidades, e todos os localizadores abaixo se referem a esses bytes, mesmo que o arquivo canônico seja posteriormente alterado. Branch observada: `codex/exposition-items20-28`; HEAD observado nesta etapa: `c6dfab61a5a3b44d09ba389911df47726f81b51e`.

Foi lida a decisão posterior em `quality_reports/coalition_protocol_2026-09-19/author_decision.md`. Ela autoriza preparar uma candidata com coalizão explícita, alocações restritas a seus membros, consentimento de todos os convidados e implementação automática. Essa decisão orienta a tarefa subsequente, mas não é atribuída retroativamente ao manuscrito original. Este relatório não deriva a nova arquitetura, não revisa sua correção e não incorpora execução individual para H.

## Cobertura e fronteira

| Unidade original | Linhas | Papel na arquitetura argumentativa |
| --- | --- | --- |
| YAML, título, palavras-chave e abstract | 1–37 | Identidade e resumo do argumento |
| Seção 1, Introduction | 41–146 | Puzzle, lacuna, mecanismo e contribuições |
| Seção 2.1, Formal equality and informal power | 148–208 | Motivação institucional e separação dos mecanismos históricos |
| Seção 2.2, Proposal rights and multilateral bargaining | 210–238 | Benchmark de poder de agenda e comparação pública |
| Seção 2.3, Private information and the price of approval | 240–271 | Margem extensiva do único informado e contribuição informacional |
| Seção 3, A working numerical illustration | 273–295 | Exemplo dos quatro jogos e das rendas |
| Seção 7.1, Pivotality, substitutes, and contested strength | 1242–1269 | Interpretação do mecanismo formal |
| Seção 7.2, WTO creation, exit, and observable implications | 1271–1314 | Aplicação teórica e implicações observáveis |
| Seção 7.3, Limits | 1316–1347 | Domínio, conceitos e fronteira empírica |
| Seção 8, Conclusion | 1349–1375 | Síntese da contribuição e de suas condições |

As leituras anteriores em `quality_reports/peio_2027_2026-09-19/source_reads/baseline.md` e `agenda.md` cobrem, respectivamente, modelo/resultados do baseline/A/B.1–B.6/C/D e seção 6/B.7–B.9/E/F. Juntas com a presente leitura, cobrem todas as seções substantivas dos bytes originais. As lacunas numéricas entre intervalos são espaços, comandos de paginação ou cabeçalhos; a linha 3119 contém somente o cabeçalho de referências, cuja bibliografia é gerada de `references.bib`. Este encargo não verificou obras externas ou a exatidão das afirmações históricas atribuídas a elas.

## Tese e contribuição reconstruídas

A pergunta é quando uma regra formalmente igual de aprovação pode favorecer um hegemon mesmo sem lhe dar poder de proposta. O modelo concentra em H a única informação privada relevante e permite que uma coalizão inteiramente desinformada o substitua sob maioria. Unanimidade torna seu consentimento indispensável. Essa margem de inclusão ou exclusão do único informado distingue o argumento de modelos nos quais toda coalizão vencedora sempre contém algum respondedor informado (linhas 94–107, 117–128, 240–271).

O texto separa três objetos: o payoff de H sob informação pública, seu payoff sob informação privada e a diferença privado menos público, denominada renda informacional. Comparar essa renda entre regras requer os mesmos parâmetros e tipos. O ganho por unanimidade depende da forma de equilíbrio e não constitui uma vantagem incondicional de toda informação privada ou de todo hegemon (linhas 1252–1269 e 1353–1358).

H pode ser excluído do acordo formado pelos demais e ainda receber sua opção externa. No enquadramento, isso aparece nos vetores do exemplo, que pagam `(0.10,0.35)` a H excluído sob maioria, e na comparação com o payoff de desacordo corrente (linhas 281–290 e 1261–1263). A explicitação de protocolo está nas unidades já lidas, especialmente linhas 340–348: o acordo dos fracos não implica payoff zero para H. Essa característica deve permanecer distinta de fracasso do pacote ou adiamento até R2.

O uso da OMC é motivação e aplicação teórica. Mercado, ameaças de saída, alternativas externas e desenho de pacotes ajudam a interpretar objetos do jogo; não são variáveis estimadas. O manuscrito não identifica a causa histórica da criação da OMC nem classifica empiricamente Estados como tipos baixo/alto (linhas 1291–1314 e 1342–1347).

## Unidade F0 — YAML e abstract

**Tese da unidade.** Resumir o mecanismo do único informado, a comparação com o benchmark público, a limitação de existência e a extensão com proposta inicial de H.

O título efetivamente escrito no YAML original é **“Power and Its Shadow: When Unanimity Serves the Hegemon”**, não o título documental usado em `AGENTS.md`. Autor e data constam nas linhas 3–4. O abstract original tem **137 palavras**, contando sequências separadas por espaços; a contagem não constitui proposta de novo abstract.

| Claim explícito | Localizador | Evidência apresentada / consumidor | Escopo e hedge |
| --- | --- | --- | --- |
| O baseline tem duas rodadas, somente fracos propõem e H conhece privadamente se seu payoff de desacordo é baixo ou alto. | Linha 36 | Seção 4 e solução do baseline. | Dois tipos e protocolo específico, não todos os jogos de barganha. |
| Maioria permite substituir o voto de H; unanimidade torna seu consentimento indispensável. | Linha 36 | Correspondências e comparação institucional da seção 5. | Margem extensiva do único informado. |
| Relativamente ao benchmark público, unanimidade pode transferir renda ao tipo baixo; maioria pode eliminá-la por exclusão. | Linha 36 | Proposições de rendas e contraste. | O verbo modal “can” não afirma que toda exclusão zere toda renda. Domínios vêm da seção 5. |
| Algumas crenças não admitem equilíbrio na classe mantida de votos puros. | Linha 36 | Proposição unânime e ressalva sobre votos mistos. | Não é inexistência irrestrita de equilíbrio. |
| Propor primeiro muda o valor da agenda; maioria ainda pode ser melhor quando o payoff de desacordo é baixo em relação aos fracos dispensáveis. | Linha 36 | Seção 6, limites e comparações de agenda. | Não dá uma condição necessária nem um ranking universal. As fontes precisam existir na classe mantida. |

**Não-afirmações.** O abstract não apresenta identificação empírica, aplicação estimada à OMC, resultado para tipos contínuos ou solução de votos mistos. Não afirma que poder de agenda e renda informacional sejam a mesma grandeza.

**Ambiguidades.** A expressão breve “Agenda power benefits it under unanimity” não traz no abstract a condição de domínio dos objetos comparados; os limites da seção 7.3 e a comparação de agenda da seção 6 fornecem esse alcance. Trata-se de resumo dependente de definições posteriores, não autorização para ampliar o claim.

**Termos.** Unanimity; majority; powerful state/hegemon; disagreement payoff; informational rent; public-information benchmark; pure ballot strategies; agenda power.

## Unidade F1 — Introduction

**Tese da unidade.** Partir do aparente paradoxo de um hegemon apoiar uma organização de direitos formalmente iguais, retirar o poder de proposta de H no benchmark e mostrar por que a possibilidade de dispensar o único informado é uma diferença institucional relevante.

| Claim explícito | Localizador | Evidência apresentada | Escopo e hedge |
| --- | --- | --- | --- |
| A criação da OMC motiva o puzzle de igualdade formal sob assimetria de poder. | 45–53 | Descrição histórica de abertura. | Motivação do artigo; não é resultado estimado pelo modelo. |
| Coerção, informação, pacotes, acesso a mercado e saída podem inserir poder no ambiente de barganha. | 55–68 | Atribuição a Steinberg e narrativa do fechamento da Rodada Uruguai. | A abertura apresenta múltiplos canais; o modelo não procura explicar todos. |
| A literatura racionalista de barganha torna relevante separar regras de reconhecimento, agenda e aprovação. | 70–83 | Referências a Baron–Ferejohn, Kalandrakis e o exemplo Cairns. | A descrição de referência é uma claim bibliográfica do manuscrito, não verificada nesta leitura. |
| Modelos recentes estudam um proponente desinformado e vários respondedores informados; em suas coalizões vencedoras sempre permanece algum informado. | 85–107 | Contraste declarado com Glynia e Piazolo/Vanberg. | A lacuna não é “informação importa em barganha”, mas poder concentrado e possibilidade de coalizão só de desinformados. |
| O paper concentra assimetria e informação em H; primeiro retira, depois acrescenta uma proposta inicial de H. | 109–115 | Descrição dos dois jogos. | “General n-player” é restringido pelo modelo e pelos limites a um H e pelo menos três fracos, dois tipos e horizonte declarado. |
| A primeira contribuição relaciona a regra de aprovação ao valor da informação de H e à renda do tipo baixo em pooling. | 117–128 | Síntese das correspondências e rendas do baseline. | O parágrafo também exclui comparação na célula sem equilíbrio em votos puros. Ver ambiguidade F1-A abaixo sobre o alcance do zero. |
| A segunda contribuição separa renda de agenda e valor da informação quando H propõe primeiro. | 130–135 | Remissão substantiva à seção 6. | O ranking depende do payoff de desacordo e de quantos fracos a coalizão pode dispensar; ver F1-B. |

**Não-afirmações.** A introdução não apresenta a agregação de múltiplos sinais privados dos fracos como seu mecanismo. Não limita a fonte de renda a uma rejeição observada no caminho; pooling pode gerar acordo imediato. Não faz comparação institucional na célula vazia (linhas 126–128).

**Ambiguidades reais para a síntese macro.**

- **F1-A — Alcance de “informational rent is exactly zero”, linhas 117–121.** O parágrafo resume um caso de voto caro e coalizão formada só por desinformados sem explicitar a região do benchmark público. O exemplo das linhas 285–289 declara exclusão privada majoritária e renda majoritária positiva para o tipo baixo (`0.01`). A proposição de rendas, linhas 802–818, distingue exclusão sob tipos ambos publicamente excluídos de exclusão quando o tipo baixo era publicamente incluído. A leitura contratual não pode transformar a frase resumida em “toda exclusão elimina toda renda informacional”. Não emito juízo sobre a correção científica; registro o alcance que o texto técnico exige e que o parágrafo introdutório não parametriza.
- **F1-B — Antecedente de “In those cases”, linhas 132–135.** A passagem menciona vantagem da maioria para ambos os tipos quando H tem baixo payoff de desacordo e em seguida fala de renda informacional revertendo vantagem pública da maioria. A síntese precisa distinguir a condição suficiente de vantagem privada majoritária da possibilidade condicional de uma reversão da vantagem pública em outros pares de assessments. A condição suficiente está em 1104–1126, e a identidade/reversão condicional em 1158–1166. A expressão introdutória não identifica precisamente a qual domínio se refere “those cases”.

**Termos.** Formal equality; material power; hegemon; agenda/proposal power; informed responder; uninformed substitute; minimum winning coalition; screening; pooling; high/low disagreement-payoff type. “Overstated strength” nas linhas 122–126 designa o tipo baixo sendo remunerado pelo limiar alto, não uma conclusão de que certo ator histórico tenha enganado seus parceiros.

## Unidade F2a — Formal equality and informal power

**Tese da unidade.** Organizar a descrição histórica de poder informal por objetos estratégicos e explicitar o contrafactual que o baseline isola.

| Claim explícito | Localizador | Evidência apresentada | Escopo e hedge |
| --- | --- | --- | --- |
| Igualdade jurídica formal pode coexistir com desigualdade em mercados, alternativas externas e capacidade coercitiva. | 152–161 | Literatura de desenho institucional e governança informal. | Contexto teórico e bibliográfico; não é uma estimativa produzida neste paper. |
| As práticas de Steinberg podem ser relacionadas a protocolo, payoffs de desacordo, espaço contratual, informação e enforcement. | 163–200; `tab:steinbergmechanisms` | Tabela que associa práticas a objetos estratégicos. | Não afirma que toda prática seja um mecanismo separado nem que todos estejam modelados. |
| Acesso a mercado, sanções, fóruns alternativos e retirada ajudam a interpretar o payoff privado de desacordo. | 186–188 | Linha da tabela “Disagreement and continuation payoffs”. | Microfundamentação substantiva proposta; não há função tarifária estimada ou identificação do valor de `o`. |
| Pagamentos laterais, exceções, transições e linkage motivam o pacote divisível; single undertaking é distinto de destruição do fallback. | 189–191 | Linha da tabela sobre espaço contratual. | O modelo usa uma abstração distributiva, sem derivar cada instrumento. |
| A direção de informação em Steinberg pode ser dos fracos ao formulador de agenda; aqui é a informação privada de H. | 192–194 | Distinção expressa na tabela. | Não toma as duas direções como evidência do mesmo mecanismo. |
| Retirar proposta exclusiva de H é um contrafactual analítico, sem afirmar que a OMC carecesse de poder de agenda. | 202–208 | Explicação explícita da restrição do baseline. | Pergunta se aprovação igual pode criar vantagem distributiva mesmo com propostas dos fracos. |

**Não-afirmações.** O texto não modela enforcement, reputação ou legitimidade como canais do baseline; coloca-os fora do escopo em 195–197. Não identifica a fonte histórica do poder de agenda com a renda informacional isolada no jogo. Não oferece nesta seção um modelo de comércio que transforme reduções tarifárias em uma unidade fixa de excedente.

**Ambiguidades e resolução.** A abertura da introdução afirma que os EUA “had no agenda power” (linha 51), enquanto esta seção explicita que a restrição formal do benchmark não nega influência de agenda na OMC (202–208). Para o contrato, a leitura coerente do argumento desenvolvido distingue direito formal exclusivo de proposta e influência de facto; a frase inicial isolada não traz essa qualificação. Esse é um ponto de formulação/escopo a reconciliar, sem julgamento da tese histórica.

**Termos.** Formal right; de facto influence; recognition; proposal/amendment protocol; disagreement and continuation payoff; divisible package; single undertaking; fallback; information direction.

## Unidade F2b — Proposal rights and multilateral bargaining

**Tese da unidade.** Localizar o paper na barganha legislativa e separar poder de reconhecimento de pivotalidade e informação.

| Claim explícito | Localizador | Evidência apresentada | Escopo e hedge |
| --- | --- | --- | --- |
| Baron–Ferejohn fornece a linguagem de reconhecimento, propostas, votação e continuação. | 212–218 | Síntese da referência. | Fonte de protocolo; não implica que toda primitiva de desacordo venha daquele modelo. |
| Probabilidades de proposta podem dominar a distribuição atribuída a votos ou paciência; o baseline retira essa fonte de renda de H. | 220–230 | Kalandrakis e literatura de proposta/veto. | H nunca é reconhecido no baseline; isso não se aplica à etapa adicional A. |
| Disagreement heterogêneo conhecido fornece a ponte pública entre unanimidade, preço de voto e exclusão majoritária. | 232–238 | Miller, Montero e Vanberg. | O paper distingue esse efeito público daquilo que a informação privada acrescenta. |

**Não-afirmações.** Não reivindica como novidade que direitos de proposta influenciem resultados ou que unanimidade possa alterar inclusão quando os custos são conhecidos. Não interpreta renda de agenda como prova de valor da informação privada.

**Ambiguidades.** Não encontrei ambiguidade interpretativa residual na função dessa unidade. A exatidão bibliográfica dos teoremas mencionados não foi verificada nesta leitura.

**Termos.** Recognition; proposal rights; voting power; continuation values; known expensive vote; public-type effect; private-information increment.

## Unidade F2c — Private information and the price of approval

**Tese da unidade.** A contribuição se localiza na margem extensiva: a regra pode tornar dispensável o único ator informado, em vez de apenas mudar quantos respondedores informados são comprados.

| Claim explícito | Localizador | Evidência apresentada | Escopo e hedge |
| --- | --- | --- | --- |
| O artigo não reivindica como novos o valor de sinalizar por rejeição ou o seguro do proponente contra rejeição. | 242–248 | Distinção de mecanismos de Piazolo/Vanberg e Glynia/Thum/Xefteris. | Claim de posicionamento bibliográfico. |
| A informação privada está em um único ator assimétrico; seus substitutos são desinformados. | 250–253 | Descrição central do modelo. | Não há canal próprio de sinalização ou sinais privados dos fracos. |
| A regra atua na inclusão do participante informado e permite decomposição por tipo entre voto necessário e renda da incerteza. | 255–262 | Contribuições declaradas e remissão aos resultados. | A renda na região de pooling pode surgir com acordo imediato. |
| A comparação opera pela composição da coalizão e preço da participação de H. | 264–271 | Delimitação perante modelos de cheap talk, reputação, agregação de sinais e screening apenas majoritário. | Não é um modelo de informação distribuída pela assembleia. |

**Não-afirmações.** Não reivindica novidade genérica de screening, informação privada, signaling ou unanimidade. Não exige fracasso de proposta no caminho para que a renda exista. Não oferece conclusão sobre agregação eficiente de informação dos membros.

**Ambiguidades.** Não encontrei ambiguidade residual sobre a margem extensiva. “On-off switch” é formulação verbal da possibilidade de incluir ou dispensar o único informado; o sinal das rendas continua condicionado às correspondências e ao benchmark público.

**Termos.** Extensive inclusion margin; only privately informed actor; uninformed substitutes; indispensable/replaceable; pooling without on-path rejection; type-specific decomposition.

## Unidade F3 — A working numerical illustration

**Tese da unidade.** Dar um exemplo concreto em que ambos os jogos privados existem e mostrar por que payoff privado, benchmark público e renda informacional são objetos diferentes.

| Claim explícito | Localizador | Evidência apresentada | Escopo e hedge |
| --- | --- | --- | --- |
| Com quatro fracos, `beta=.9`, `ell=.10`, `h=.35`, `p=.80`, maioria privada exclui H e unanimidade privada faz pooling. | 275–283 | Cortes informados `p*=.2778` e screening/exclusão `.2935`. | Um ponto matemático; resultados gerais vêm das proposições. |
| Vetores públicos M/U são `(.09,.35)` / `(.09,.315)`; privados são `(.10,.35)` / `(.315,.315)`. | 285–287 | Substituição numérica nos resultados do baseline. | Coordenadas representam os tipos baixo/alto; não são Estados observados. |
| As rendas são `(.01,0)` sob maioria e `(.225,0)` sob unanimidade; a diferença baixa é `.215`. | 287–290 | Privado menos público dentro da regra e unanimidade menos maioria. | Mostra renda majoritária baixa positiva apesar de exclusão privada; não autoriza o claim de que toda exclusão produz zero. |
| A célula `0<p≤.2778` não recebe comparação e o exemplo não é calibração empírica. | 292–295 | Ressalva explícita. | Inexistência na classe mantida de votos puros. |

**Não-afirmações.** Não há teste empírico, calibração à OMC ou identificação de um tipo histórico. Não há claim de que exclusão prive H de sua opção externa: H excluído recebe os valores `.10` ou `.35` enquanto o acordo dos fracos é implementado.

**Ambiguidades.** Não encontrei ambiguidade residual no exemplo. Esta leitura inspecionou os números relatados e sua função; não os recalculou com scripts.

**Termos.** Public/private vector; low/high type; current disagreement payoff; informational rent; mathematical illustration; no empirical calibration.

## Unidade F4a — Pivotality, substitutes, and contested strength

**Tese da unidade.** Interpretar a regra de aprovação como substituibilidade do consentimento de H e separar a dimensão pública de poder do incremento devido à informação.

| Claim explícito | Localizador | Evidência apresentada | Escopo e hedge |
| --- | --- | --- | --- |
| Maioria permite substituir H por outro voto desinformado; unanimidade torna sua aprovação um insumo essencial. | 1246–1250 | Interpretação dos preços e coalizões. | “Technological” refere-se à possibilidade institucional de substituir consentimento, não a uma atividade produtiva de H. |
| O benchmark público paga o limiar descontado ao tipo barato; o caro pode ser excluído por maioria. | 1252–1257 | Proposição pública. | A questão informacional vem depois de retirar essa diferença pública. |
| Informação privada não beneficia sempre H; sinais dependem de pooling, screening, exclusão e região pública. | 1259–1264 | Proposições de rendas e comparação. | O tipo alto muda sua renda quando inclusão/preço divergem entre os jogos público e privado majoritários. |
| A célula intermediária não sustenta comparação institucional na classe mantida. | 1266–1269 | Remissão à faixa cinza hachurada de `fig:privatecompare`. | Não é efeito zero nem região interpolada. |

**Não-afirmações.** Não atribui produção adicional ao consentimento de H, não exige implementação individual, não faz unanimidade aumentar toda renda. O uso de “essential input” descreve aprovação necessária dentro do jogo.

**Ambiguidades.** Não encontrei ambiguidade residual após ler as definições de modelo. Preservar o termo “technological” sem criar uma tecnologia produtiva adicional é indispensável à fidelidade.

**Termos.** Pivotality; substitute vote; necessary approval; public power component; informational comparison; current versus discounted disagreement payoff.

## Unidade F4b — WTO creation, exit, and observable implications

**Tese da unidade.** Usar a criação da OMC para ilustrar objetos de barganha e formular implicações observáveis, preservando que o modelo isola apenas um canal e não identifica o evento histórico.

| Claim explícito | Localizador | Evidência apresentada | Escopo e hedge |
| --- | --- | --- | --- |
| A narrativa de single undertaking e retirada do GATT alterou pacote e fallback. | 1273–1289 | Atribuição histórica a Steinberg. | A leitura registra a atribuição; não verifica história, regras comerciais ou consequências jurídicas. |
| Single undertaking restringe aceitação seletiva; retirada altera o valor de rejeitar. | 1282–1289 | Mapeamento analítico dos dois objetos. | Não são o mesmo mecanismo. Privacidade do valor externo gera o problema formal apenas se esse valor não é conhecimento comum. |
| O episódio não implementa literalmente o baseline e não demonstra ausência de poder de agenda. | 1291–1297 | Distinção explícita de influência de facto e direito formal exclusivo. | O modelo não identifica por que os EUA criaram a OMC. |
| O mecanismo deve ser mais forte quando falta substituto para o consentimento de H, há incerteza sobre seu fallback e o pacote admite compensação. | 1299–1307 | Implicações observáveis derivadas da interpretação. | “Should” e descrição de assinatura, sem teste ou efeito estimado. |
| Pooling pode produzir acordo sem rejeição prévia; signaling por rejeição tem outra assinatura temporal. | 1303–1305 | Comparação de mecanismos. | Não classifica automaticamente todo acordo rápido como evidência exclusiva do modelo. |
| Aplicação empírica precisa distinguir informação sobre H de informação dos fracos e usar linguagem de consistência. | 1309–1314 | Advertência metodológica expressa. | O episódio não identifica causalmente o mecanismo formal. |

**Não-afirmações.** Não há estimação causal, análise de dados, probabilidade histórica inferida, identificação de tipos de EUA/EC ou alegação de que o caso OMC valide isoladamente o modelo. O texto não declara literalmente um mecanismo tarifário no qual concessões individuais sejam transformadas por uma função estimada em `x_H` e `x_j`.

**Ambiguidades.** Não encontrei ambiguidade residual entre ilustração e identificação nesta seção, que as distingue expressamente. As claims históricas permanecem claims atribuídas à fonte, não verificações deste leitor.

**Termos.** Theoretical application; institutional illustration; package; selective acceptance; fallback; market-access leverage; information direction; consistency rather than identification.

## Unidade F5 — Limits

**Tese da unidade.** Declarar restrições da comparação formal e impedir extrapolações em história institucional, tipos, horizonte, estratégias e multiplicidade.

| Claim explícito | Localizador | Evidência apresentada | Escopo e hedge |
| --- | --- | --- | --- |
| Bolo fixo, fracos proponentes, dois tipos, duas rodadas e regra institucional exógena delimitam o baseline. | 1318–1326 | Lista de hipóteses e exclusões. | A extensão relaxa a restrição de proposta pela etapa obrigatória anterior; não endogeneíza regra ou agenda. `m≥3` e `beta<1`. |
| Suporte do prior não ressuscita um tipo ausente; no interior há liberdade de crença após ações fora do caminho de H. | 1328–1332 | Disciplina de crenças do modelo. | Endpoints correspondem a informação completa, não limites de células interiores. |
| A agenda preserva multiplicidade; sinais robustos são sobre conjuntos e os demais dependem do assessment. | 1334–1340 | Síntese das correspondências e convenção de datas. | `T` depende da etapa obrigatória/data; `Q` muda informação e agenda. |
| OMC é aplicação teórica; motivos de desenho, tipos históricos e mecanismos não modelados permanecem fora. | 1342–1347 | Declaração explícita. | Abstrai de plurilaterais, procedimentos subsidiários, ratificação, implementação e reputação repetida. |

**Não-afirmações.** Não analisa escolha endógena de unanimidade, direito opcional de agenda, mais de dois tipos, roll-call sequencial, benefício intrínseco de acordo, três jogadores totais ou `beta=1`. Não atribui causalmente a criação da OMC a uma conclusão de equilíbrio.

**Ambiguidades.** Não encontrei ambiguidade residual nos limites. “Implementation” fora do escopo significa que o artigo não modela esses mecanismos institucionais; não autoriza acrescentar uma atividade individual como se já fosse sua primitiva.

**Termos.** Maintained class; endpoint support; endogenous rule choice; mandatory agenda stage; date convention; setwise/assessment-specific; theoretical application.

## Unidade F6 — Conclusion

**Tese da unidade.** Unanimidade pode criar renda ao tornar insubstituível o único informado; a extensão separa componente público e interação informacional, com todos os resultados limitados às correspondências existentes.

| Claim explícito | Localizador | Evidência apresentada | Escopo e hedge |
| --- | --- | --- | --- |
| Consenso pode beneficiar H sem agenda porque remove substitutos; pooling unânime pode remunerar o tipo baixo pelo alto. | 1353–1358 | Síntese das proposições do baseline. | Se essa renda supera a da maioria depende da correspondência e da região de desacordo. |
| Agenda não apaga a distinção: vantagem privada de unanimidade contra desvantagem pública requer compensação por renda relativa. | 1360–1367 | Identidade e resultados de agenda. | Não há sinal institucional universal; `T=D+I` é contabilidade dos jogos definidos. |
| Opções externas, direitos de proposta e consentimento sem substituto podem coexistir com igualdade formal. | 1369–1375 | Síntese dos canais e aplicação teórica. | Consistência com OMC; não identificação histórica; existência e domínios das correspondências permanecem condicionantes. |

**Não-afirmações.** Não diz que toda unanimidade beneficia todo hegemon; não equipara poder à produtividade nem declara que poder de agenda seja irrelevante. Não usa a aplicação à OMC para escolher empiricamente um assessment.

**Ambiguidades.** “Identifying benchmark” em 1372 tem sentido de isolamento analítico do canal, consistente com 1291–1314 e 1342–1347; não é um desenho de identificação causal por dados. O contrato deve preservar essa distinção.

**Termos.** Consensus/unanimity; public component; informational shadow; necessary approval; outside options; proposal rights; complete equilibrium correspondence; domains of existence.

## Não-afirmações transversais e controles de interpretação

1. A novidade pretendida é a inclusão/exclusão do **único** informado, com substitutos desinformados. Não é a descoberta genérica de informação privada, screening ou influência da regra de votação.
2. O valor externo de H pode ser recebido mesmo quando os fracos implementam um acordo que o exclui. Não interpretar “disagreement payoff” como algo necessariamente disponível apenas após fracasso agregado de todas as negociações.
3. Excluir H do acordo não torna seu payoff zero. Tampouco implica, em todas as regiões públicas, renda informacional zero; os objetos precisam ser distinguidos conforme as proposições e o exemplo.
4. Bolo fixo é hipótese do modelo. O enquadramento oferece acesso a mercado e outros instrumentos como motivação para payoffs/pacotes; não deriva endogenamente um bolo tarifário invariável a qualquer composição de coalizão.
5. As referências à OMC são aplicação teórica e linguagem de consistência. Não há estimando causal empírico, teste de mecanismo, classificação histórica de tipo ou explicação identificada da criação da organização.
6. Retirar poder formal exclusivo de proposta de H não equivale a negar influência de facto de EUA/EC sobre agenda e textos.
7. Aprovação necessária é chamada de insumo essencial, mas o artigo original não modela uma atividade produtiva individual de H para receber sua parcela.
8. Renda pode ser obtida no caminho de acordo imediato; não requer sinalização por rejeição observada. A possibilidade de screening e rejeição em outros casos permanece.
9. Inexistência é da classe mantida de votos puros. Célula vazia não recebe payoff zero, sinal, ranking ou interpolação.
10. As comparações de agenda preservam vetores/assessments e suas datas. Um resumo verbal não autoriza combinar tipos de assessments distintos nem um benchmark opcional diferente.

## Terminologia e campos do adaptador formal

- **Hegemon / strong type / low type:** H é o ator assimétrico e único informado; “forte/fraco” dentro de seus tipos corresponde ao payoff de desacordo alto/baixo, não a uma medida empírica estimada de poder militar ou de mercado.
- **Outside option / terminal disagreement payoff:** `o` é primitiva formal e “outside option” sua interpretação como melhor alternativa; a interpretação não deve apagar sua portabilidade sob exclusão de um acordo dos demais.
- **Pivotality / indispensable approval:** necessidade do consentimento segundo o protocolo, não contribuição produtiva de H para aumentar a pie.
- **Agenda power / recognition / de facto influence:** conceitos relacionados, mas distintos. O baseline fixa reconhecimento de H em zero, a extensão acrescenta etapa própria, e a narrativa histórica admite influência informal.
- **Informational rent / private payoff / institutional contrast:** privado menos público dentro de cada regra; não confundir com payoff bruto ou com unanimidade menos maioria antes da subtração pública.
- **Extensive margin / coalition composition:** possibilidade de ter uma coalizão vencedora sem nenhum informado. O texto não distribui sinais privados entre fracos.
- **Market access / divisible package:** interpretação e abstração distributiva; não há neste original uma especificação comercial estrutural de tarifas, fluxos, incidência ou bem-estar.
- **Campos empíricos:** tratamento, amostra, período de observação, estratégia de identificação e especificação estatística preferida são inaplicáveis. Os contrafactuais relevantes são regras, informação e etapa de agenda dentro do modelo.

## Questões para reconciliação macro

| ID | Questão | Locais para resolução | Estado desta leitura |
| --- | --- | --- | --- |
| F1-A | A expressão de renda zero na introdução refere-se a qual região pública e tipo? | 117–121; exemplo 285–289; prop:rents 802–818 | Não ampliar para toda exclusão. O contrato deve usar a caracterização por células; redação introdutória é menos delimitada. |
| F1-B | “In those cases” vincula-se à vantagem pública ou à condição suficiente de vantagem privada da maioria? | 130–135; 1104–1126; 1158–1166 | Antecedente não está explicitado; separar as duas claims na síntese. |
| F2-A | A abertura sobre ausência de agenda nega toda influência ou apenas direito formal exclusivo? | 49–51; 202–208; 1291–1297 | A leitura integral sustenta a segunda interpretação; registrar a qualificação que falta na abertura. |
| F6-A | “Identifying benchmark” significa identificação causal? | 1371–1375; 1291–1314; 1342–1347 | Resolvido: isolamento analítico de canal, com negação expressa de identificação empírica. |

Essas questões são de fidelidade e alcance textual. Não foram classificadas como defeitos científicos nem convertidas em correções autorizadas por este leitor. O título original, o abstract e os parágrafos preservam os bytes lidos; o contrato do futuro candidato precisará revalidar o enquadramento nas partes efetivamente alteradas.

## Verificações realizadas

Foi conferido o SHA-256 da fonte original no momento da captura; lidas integralmente as unidades acima e a decisão autoral posterior; consultadas as leituras de baseline e agenda para fechar a cobertura. Foi contada a extensão do abstract original por separação em espaços. Não foram executados cálculos do modelo, verificadores matemáticos, compilação, inspeção visual, revisão bibliográfica externa ou testes empíricos. O único arquivo escrito por esta tarefa é este relatório.
