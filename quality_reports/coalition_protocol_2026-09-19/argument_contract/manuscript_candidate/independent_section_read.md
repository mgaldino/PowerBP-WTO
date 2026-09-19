# Leitura independente de compreensão — manuscrito candidato de coalizão

Leitor: `/root/provenance_inventory`. Data: 19/09/2026. Esta leitura precede o contrato interpretativo do manuscrito e a crítica científica correspondente. Reconstrói os claims que o preview efetivamente faz, seus domínios, fontes e dependências. Não emite parecer matemático, editorial ou factual, não lê o parecer científico de outro agente e não altera candidato algum.

## Identidade, leitura e diff

| Objeto | SHA-256 |
|---|---|
| `derivations/combined_manuscript_preview.Rmd` | `9356d86a2e893481968ee96a918c2109e726444c5d902ce88edd6f1a5d86345f` |
| `derivations/combined_references_preview.bib` | `658af186c73c1291da02a9fd4e3482fc953549ed46036ae24303b45f61309447` |
| `derivations/composition_manifest.json` | `106c04dc0a4070f4b71fa4dbf1fedd67191deec48a498a7d0ba9564ed7f981f8` |
| `derivations/combined_manuscript_preview.diff` | `1af978d20e7b91eb9516c2c5aef03389cfcbf540ed48bbf8156472a1ce4d39a1` |
| `snapshots/original/formal_model_v6.Rmd` | `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411` |
| `snapshots/original/references.bib` | `71f1413b45b44a4c55a9d0ffb4fb2e1218cfac7ced547829bd0e3eae6200f755` |

Todos os caminhos são relativos a `quality_reports/coalition_protocol_2026-09-19/`. `M:L` abaixo significa a linha L do preview exato, não do original. O título continua sendo **Power and Its Shadow: When Unanimity Serves the Hegemon**. O projeto usa também o nome de trabalho Informational Power Through Pivotality. A data do YAML é 19/09/2026.

Conferi os sete inputs e dois outputs do manifesto de composição. O snapshot do Rmd coincide com o arquivo canônico ainda preservado. A aplicação em memória dos 34 hunks do diff armazenado reconstrói exatamente o preview, sem executar os patches ou escrever no manuscrito. Uma comparação por linhas com `difflib.SequenceMatcher(autojunk=False)` encontra 2.784 linhas idênticas, 335 linhas do original substituídas/removidas e 565 linhas novas em 110 blocos de alteração. São 3.119 linhas no original e 3.349 no preview. Esses números descrevem o diff textual, não sua importância substantiva.

Li o preview em blocos abrangendo corpo, apêndices e definições documentais. Para a leitura por impacto, usei a identidade textual para ligar passagens preservadas à compreensão anterior do original e às notas derivadas já lidas; não tratei preservação textual como aprovação científica. O contrato original `argument_contract/original/argument_contract.json`, SHA `ae46ab5718d1ccff6f3289ab44fc6ba37c4ccb5904656808caa16d8a5a2899fe`, fornece os IDs C01–C20, que atualizo abaixo. A leitura de derivações v2 é separada, em `argument_contract/derivations_v2/independent_section_read.md`, SHA `422a034afd04b33e40442ce1ebec26fc489863d46bf4ec53a5356608fe27b8b1`.

## Tese, contribuição e arquitetura da exposição

O argumento central continua sendo a margem de inclusão do único ator informado. Fracos desinformados podem compor uma coalizão sem H sob maioria; unanimidade torna sua adesão necessária. Com informação privada sobre a opção externa, a necessidade dessa adesão pode levar os fracos a pagar ao tipo baixo uma concessão suficiente para o tipo alto. O texto separa esse componente informacional da diferença pública de payoffs e do direito de propor.

O novo protocolo torna a coalizão um objeto público da proposta. Sua quota governa quais contratos são factíveis; todos os convidados, mesmo acima da quota, precisam consentir. A proposta aprovada é executada automaticamente. H excluído recebe sua opção externa e tem parcela zero por factibilidade; H convidado que recusa faz o pacote inteiro fracassar. Essa arquitetura é apresentada como regra do jogo, não resultado exclusivo da escolha ótima.

O baseline de duas rodadas continua sendo o modelo principal e dá a iniciativa apenas aos fracos. A extensão acrescenta uma etapa obrigatória anterior de H proponente. Ela mantém as fontes de continuação completas, mas usa uma seleção pública, anônima e Markov e uma restrição única de crença off-support. Na maioria da agenda, a coalizão também pode sinalizar o tipo. Em unanimidade, C=N é constante e pode ser suprimida da notação, com um mapa explícito que preserva a forma extensiva.

A exposição segue: pergunta e literatura; exemplo numérico; modelo e conceito; benchmarks e jogos privados; rendas; agenda; interpretação e limites; provas e correspondências exatas. A migração conserva grande parte dos resultados econômicos e das fórmulas, mas substitui os fundamentos do protocolo e os objetos de sinalização/leis majoritárias que os sustentam.

## Abstract e introdução

O abstract, M:35–36, tem **168 palavras separadas por whitespace**, contra 137 no original. A contagem é do texto do campo YAML, sem o rótulo `abstract: |`. Ele agora explicita coalizões, alocações e consentimento de todos os convidados. Mantém: exclusão de H acompanhada de sua opção externa; pooling unânime e renda do tipo baixo; possível eliminação dessa renda por exclusão; região sem equilíbrio na classe de votos puros; etapa de H proponente; benefício fraco da agenda sob U quando ambos os jogos existem; e a condição suficiente de vantagem majoritária para os dois tipos entre assessments comparáveis. Não afirma que unanimidade sempre favoreça H.

Na introdução, M:41–151, o puzzle da OMC e a distinção entre regras formais e influência informal permanecem. O benchmark que retira a proposta de H é usado como isolamento teórico, não afirmação de ausência histórica de influência de agenda. A mudança interpretativa importante está em M:119–139: exclusão elimina a renda de ambos os tipos quando ambos também seriam excluídos com informação pública; a região de inexistência é expressamente restrita a votos puros e não recebe comparação de payoff; e a contribuição de agenda é formulada em termos de existência das duas instituições e da condição suficiente do tipo alto descontado. O resumo introdutório deve ser lido com essas qualificações e com a decomposição posterior, não como um resultado universal de renda zero sob qualquer exclusão.

## Mapa atualizado dos 20 claims

| ID | Claim reconstruído no preview | Fontes principais e limites |
|---|---|---|
| C01 | Maioria permite substituir o único informado por fracos; unanimidade torna sua adesão necessária e pode transferir renda ao tipo baixo, mesmo com iniciativa dos fracos. | M:119–139,244–275,648–780,1270–1295,1377–1403. Condicional à célula e à existência; não é ranking universal. |
| C02 | Dois tipos privados de H, m≥3 fracos, duas rodadas, reconhecimento uniforme dos fracos com reposição, pie fixa em 1, β∈(0,1) e opção externa de H fora da pie. | M:303–342,355–371. Nenhuma produtividade adicional, externalidade ou informação privada fraca. |
| C03 | Proposta pública y=(C,x), proponente em C e quota mínima; x_j=0 fora de C; todos os convidados consentem; qualquer recusa rejeita todo o pacote. Aprovação paga as parcelas automaticamente; H excluído recebe o e tem x_H=0. | M:316–394,1411–1430. Substitui integralmente o protocolo histórico do C03 original. Não há cancelamento de parcela de H após aprovação. |
| C04 | Baseline usa PBE com ballots puros, comparação pivotal dos fracos, T^Y e desempate do proponente; fracos não sinalizam; Bayes positivo e liberdade local por voto de H preservam suporte inicial. | M:428–480,1432–1456. Ausência de convite é ⊥, não N. Não se alega equilíbrio sequencial. |
| C05 | Benchmark público: R2_M exclui H, R2_U paga o; R1_U paga βo e R1_M inclui H iff o≤1/m, com inclusão na igualdade. | M:504–559,1460–1492. B.1 distingue resultado econômico único de múltiplas coalizões nominais em R2_M. |
| C06 | R2 privada mantém maioria econômica; U oferece ℓ abaixo/na igualdade p* e h acima. | M:561–586,1494–1509. Alocação M única não significa C único; valores nativos sem β interno. |
| C07 | R1_M reduz propostas ótimas a E/S/P, com cinco regiões de preço, cortes e eventual segmento E/P vinculado. | M:588–646,1511–1567. B.3 completa respostas após todo (C,x), distingue veto fraco de não convite e compara remoções antes de votar. |
| C08 | R1_U: endpoint baixo, vazio em 0<p≤p* e pooling alto; vetores incluem o tipo sem probabilidade. | M:648–728,1569–1645. M:1601 define o menor pagamento apenas entre respondedores fracos. Não caracteriza votos mistos. |
| C09 | Contraste privado U−M depende da forma majoritária e mantém os vínculos entre tipos e pesos de mistura. | M:730–780,1647–1659,2179–2218. Célula vazia não recebe ranking ou interpolação. |
| C10 | Renda é privado menos público da mesma regra; maioria depende conjuntamente da forma privada e da inclusão pública de cada tipo. | M:782–903,1661–1683. Exclusão pode produzir renda positiva pela data da opção externa; não há zero universal. |
| C11 | A extensão acrescenta A obrigatório com H proponente de (C,x), sinal público completo, seleção de continuação literal e um β entre A e R1. | M:483–496,905–939,2301–2378. Não é reconhecimento adicional dentro do baseline nem direito opcional de saltar A. |
| C12 | Agenda pública conserva os ramos de v_M^A, v_U^A, cutoff o_M* e gap U−M. | M:941–1047,2888–2954. Empate de inclusão em 1/m e empate de atraso próprios; não é ranking público uniforme. |
| C13 | Agenda M admite todas as formas puras indicadas e leis Borel que satisfaçam Bayes, consentimento, seleção completa e desigualdades de desvios; há garantia uniforme e existência para algum ρ. | M:1051–1068,1685–1923,2380–2580. Domínio é Y_M; acordos usados são mínimos quase certamente, recusas maiores continuam factíveis. |
| C14 | Agenda U tem famílias baixa/alta, endpoints e vazios; interior existente dá valor comum aos tipos; posterior de continuação precisa estar em {0}∪(p*,1]. | M:1069–1116,1925–2106,2582–2797. Lema de suporte trata x^h também quando de massa zero; F-003 dá condições de probabilidade um nos endpoints. |
| C15 | Quando ambas as correspondências de agenda existem na mesma especificação, βh<e/m garante vantagem majoritária para ambos os tipos e ex ante em todos os assessments. | M:1118–1152,2838–2886. Condição suficiente, não necessária. Usa a garantia M e o teto global U; este teto tem argumento independente da classificação por US-1. |
| C16 | Na agenda, ΔV=Δv+ΔIR; U tem renda baixa não negativa e alta não positiva, com alguma estriteza. Reversão do ranking público exige compensação por ΔIR. | M:1154–1204,2956–3044. A tabela de reversão é um par específico na mesma fibra, não uma seleção universal. |
| C17 | T=D+I compara jogos e datas especificados; U ganha fracamente onde ambos existem. Q muda agenda e informação simultaneamente. | M:1206–1266,3046–3184,3270–3347. Uma aplicação de β; vazios propagam-se; efeitos M podem ser conjuntos. |
| C18 | Assinatura exata identifica a órbita diagonal das leis realizadas; resumo econômico remove nomes por registro; comparação forma pares completos antes de projetar. | M:2108–2175,2516–2580,2745–2797,3188–3268. C e ⊥ entram nos registros M. Funções off-path permanecem no assessment completo; sem sorteio comum entre instituições. |
| C19 | OMC é aplicação teórica ilustrativa que distingue influência de agenda, mudança de fallback, pacote e consentimento indispensável. | M:41–117,154–242,1297–1340. Não identifica causalmente a criação da OMC, os tipos históricos ou a escolha da regra. Os fatos históricos não foram verificados nesta leitura. |
| C20 | Escopo mantém dois tipos/rodadas, m≥3 e β<1, pure ballots e correspondências; igualdade formal pode coexistir com desigualdade por opções externas, proposta e adesão necessária. | M:1342–1403,3311–3347. Não inclui regra endógena, mais tipos, roll call ou comparação em células sem fonte. |

## Novos subclaims que precisam permanecer visíveis no contrato

1. **Não acúmulo em todas as histórias**, integrante de C03: M:1423–1430 faz a divisão dos ramos por H convidado/excluído e consentimento. O argumento consome factibilidade e regra de implementação, não apenas otimalidade ou screening no caminho.
2. **Correspondência completa no espaço de coalizões**, integrante de C11/C13/C18: M:1695–1745,1790–1846,2320–2361 e 2457–2580 retêm y=(C,x), mesmo quando x coincide. A seleção anônima é um representante específico; os pagamentos c/h isolados não esgotam a continuação.
3. **Minimalidade quase certa de acordos em A_M**, integrante de C13: M:1898–1923 usa um piso uniforme de consentimento e a garantia segura. Não retira coalizões maiores do domínio e não impõe argmax em todo ponto do suporte.
4. **Lema do preço alto em suporte Borel**, integrante de C14: M:1982–2021 pretende demonstrar, sob μ_off>p*, V=z_H e ambas as leis δ_(x^h), contemplando x^h com massa zero. Consome valor comum, ausência de desvios pointwise, igualdade quase certa, identidade média de Bayes e admissibilidade do limite. As duas aplicações estão em M:2030–2034 e 2081–2083.
5. **Probabilidade um no argmax**, integrante de C13/C14: M:1827–1829,2489–2491 e 2701–2718 usam a formulação de F-003. O tipo de probabilidade zero tem lei e payoff; seu suporte topológico não precisa estar contido no argmax.

US-1 não é o fundamento do teto global U: M:1987–1990 e 2095–2101 enunciam esse limite por factibilidade/pagamentos. Sua conclusão é consumida pela classificação B.8/E.3 e pelas imagens derivadas, não pelo bound suficiente C15 isoladamente.

## Leituras específicas das provas e interfaces

**Modelo, A.1, B.1 e B.3.** A quota mudou de limiar no vetor de votos universais para requisito de tamanho da coalizão. A aprovação requer consentimento de cada convidado. B.1 distingue o resultado econômico R2_M da liberdade de nomear coalizões só de fracos, inclusive maiores. B.3 apresenta respostas em todo contrato e a eliminação de propostas certamente rejeitadas, convites excedentes e pagamentos acima do necessário. Remover um convidado é escolha de uma proposta alternativa antes do ballot, sem executar uma subcoalizão após recusa.

**B.7, E.1 e E.2.** A agenda usa Y_g, uma união disjunta finita de faces X_C. A componente C é observada antes de votar e permanece no denominador e numerador de Bayes local. A comparação a posterior fixado identifica uma fronteira de pagamento; os desvios de sinalização completos entram posteriormente no critério pointwise/quase certo/off-support. A tabela pura mantém todas as mensagens que realizam cada forma, em vez de transformar testemunhas canônicas em restrição de ações. Os kernels M de E.2 são registros físicos finitos dos representantes uniformes, com C, reconhecido, parcelas, votos e resultados; funções de crença e planos não realizados permanecem no seletor literal.

**B.8 e E.3.** O mapa C=N permite notação x em U sem esquecer a coalizão. A nova prova de suporte começa depois da redução ao valor comum, não substitui essa redução nem altera a regra de crenças. O limite de médias fornece inicialmente μ(x^h)≥p*; o texto atribui a desigualdade estrita à admissibilidade, que exclui p* e, dado p*>0, exclui zero. A família baixa exige um átomo positivo do tipo baixo em x^ℓ; as referências a leis atomless não podem ser lidas como retirada dessa condição expressa. A família alta permite o intervalo declarado quando μ_off=0 e reduz-se ao átomo alto quando μ_off>p*. Os endpoints são jogos de suporte degenerado, não limites laterais das famílias interiores.

**B.9 e F.1.** A ação dos nomes permuta também coalizões e votos efetivos. A assinatura exata atua diagonalmente sobre o par de leis por tipo, preservando sua ligação. A fatoração econômica vale para observáveis anônimos sobre registros realizados; os objetos sensíveis a planos off-path continuam consumindo o assessment completo. As imagens marginais e seus envelopes não autorizam recombinação de coordenadas.

**QI-01 preservada.** Leio o prior que entra no baseline selecionado em E.1/E.3 como o prior de entrada daquele assessment de continuação. A seleção dos endpoints degenerados é a hipótese já explicitada no contrato das derivações. M:1432–1449 conserva, dentro de um mesmo baseline, a restrição de suporte do prior inicial. Esta leitura não infere que chegar a posterior zero em qualquer história de um jogo com suporte interior apague o tipo alto do suporte original. O contrato do manuscrito deve conservar essa distinção, sem anunciar consistência global mais ampla.

## Consumidores, referências e fronteiras

As fórmulas públicas/privadas do corpo e de E.4–F.4 permanecem em grande parte literais; agora consomem o protocolo e as correspondências reescritos. A composição apresenta uma nova realização da tabela de reversão em M:2443–2455, com μ_off=0 nas duas regras: M tem payoffs (.5905,.81), U tem (.729,.729). Os números da tabela permanecem, mas a mensagem majoritária passa a ser um par (C,x) explícito. A prova algébrica reparada de A-C5 está nas notas v2; a expressão fatorada corrigida não é um enunciado literal do preview. Seu consumidor textual é a afirmação de dominância da passagem no ramo público, junto das fórmulas em E.6 e no corpo.

O diagrama TikZ M:396–426 foi atualizado para proposta de coalizão/alocação, votos dos convidados, consentimento de todos e fracasso por qualquer recusa. As figuras externas continuam sendo as de preços/coalizões, comparação privada, rendas, gap público e existência unânime, com captions ligadas aos mesmos objetos econômicos e respectivas restrições. Esta leitura identifica seus claims e fontes; não renderizou nem inspecionou páginas/imagens. Não interpreta preservação de um PDF antigo como prova da nova migração.

O diff bibliográfico acrescenta somente a entrada `evdokimov2023equality`, com o título *Equality in Legislative Bargaining*, e uma ocorrência no modelo, M:324. A frase atribui a referência ao protocolo explícito de coalizão-alvo e apresenta separadamente a restrição de alocações aos membros. Não leio essa citação como afirmação de equivalência integral ao artigo citado. Não verifiquei a bibliografia externamente, o conteúdo desse artigo ou o render das citações.

As não-afirmações centrais do original continuam: informação privada não beneficia todo tipo em toda célula; exclusão não elimina toda renda em geral; U não possui ranking universal; ausência de equilíbrio em votos puros não cobre votos mistos; T inclui a antecipação de data e proposta obrigatória; Q é composto; aplicação histórica não é identificação causal. Acrescentam-se os limites de transporte: o texto atual não alega equivalência literal global à maioria histórica, não apaga C dos sinais rejeitados e não restringe todas as leis a suporte finito ou topologicamente ótimo.

## Estado interpretativo

Não identifiquei uma dúvida nova de significado que impeça construir o contrato. A questão de endpoints QI-01, a condição do átomo baixo em E.3, os quantificadores pointwise/quase certos e a diferença entre objetos realizados e planos completos precisam constar expressamente da síntese. A fidelidade entre essas alegações e as provas, o tratamento de fontes bibliográficas, a correção científica, os patches e a qualidade visual serão objetos de revisão posteriores ao gate, em seus hashes próprios.

Este registro comprova leitura e delimitação do argumento do fonte congelado. Não é aprovação científica do preview, não transfere automaticamente o PASS de derivações v1/v2 e não declara submissão pronta.
