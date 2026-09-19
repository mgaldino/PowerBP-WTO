# Revisão adversarial independente: derivações v2 e preview integrado

**Derivações v2: PASS científico no escopo declarado. Preview: PASS de consistência científica da migração integral, por impacto.** Não encontrei um novo finding científico nos três reparos, nas dependências atingidas ou na integração dos resultados. Os dois veredictos são separados: a revisão das notas cobre os 17 claims de seu contrato; a conferência do preview cobre os 20 claims do contrato do manuscrito, reutilizando evidência apenas para texto e resultados comprovadamente preservados. Este parecer não certifica um PDF, aparência das figuras, factualidade de toda a discussão histórica, novidade perante toda a literatura ou prontidão para submissão.

Revisor: `/root/provenance_inventory`; data: 19/09/2026. Não implementei as notas ou os patches do manuscrito. Não li o parecer científico formal de outro revisor. Minha reconstrução fria de R2 e minha revisão adversarial v1 continuam preservadas. Só escrevi meus próprios checks e este parecer/JSON; nenhum candidato foi editado.

## 1. Objetos exatos

Os caminhos relativos deste parecer partem de `quality_reports/coalition_protocol_2026-09-19/`. `V2:L` denota linha da nota v2 indicada; `P:L` denota linha do preview. Não se atribuem os números de linha antigos à fonte nova.

| Objeto | SHA-256 |
|---|---|
| `reviews/derivation_candidate_v2.json` | `8f6603ff00050b6870995d4d893eeeb2bdffe13e0a90304b19b3574de8b7e9f1` |
| `derivations/derivation_bundle_v2.md` | `3b8043d49de9011a60c1e7e079b4fbf876f35239d100dad82a0072b53a19b4e2` |
| `argument_contract/derivations_v2/argument_contract.json` | `7db1a7a72dd12178e7f5b63ce45c94ae08576e0a6a22daa8dbbbd13aab25d4ca` |
| `derivations/combined_manuscript_preview.Rmd` | `9356d86a2e893481968ee96a918c2109e726444c5d902ce88edd6f1a5d86345f` |
| `derivations/combined_references_preview.bib` | `658af186c73c1291da02a9fd4e3482fc953549ed46036ae24303b45f61309447` |
| `argument_contract/manuscript_candidate/argument_contract.json` | `a1a39f8548cfdbe285a9bd5be7cee7f28d92156e8a411b91a74bd65099d3cebc` |
| `derivations/composition_manifest.json` | `106c04dc0a4070f4b71fa4dbf1fedd67191deec48a498a7d0ba9564ed7f981f8` |
| Fonte original preservada | `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411` |
| `author_decision.md` | `7abfa53814ff23c61a9af2049c975be81e44f8e66270c4fa3f99accd51923726` |

Os contratos finais estão PASS e seus hashes foram conferidos. O primeiro tem ID `coalition-derivations-v2:3b8043d49de9:round2`; o segundo, `informational-power-coalition-manuscript:9356d86a2e89:round2`. Conferi os dez arquivos do manifesto v2, a igualdade dos cinco payloads do bundle durante a leitura e as sete entradas/duas saídas do manifesto de composição. O JSON acompanhante registra também os hashes de todas as fontes e dos meus checks.

A compreensão independente precedeu a crítica científica. Os records são `argument_contract/derivations_v2/independent_section_read.md`, SHA `422a034afd04b33e40442ce1ebec26fc489863d46bf4ec53a5356608fe27b8b1`, e `argument_contract/manuscript_candidate/independent_section_read.md`, SHA `1ad0a2b224f4d6bd21c5c40a8479ffdc2b75bb73f2d7a305968feef5240b8563`.

## 2. Reutilização delimitada da v1

`game_contract.md`, `r2_interface.md` e `r1_interface.md` são idênticos, byte a byte, às versões avaliadas na v1. Seus hashes são, respectivamente, `ac78634ea0da03b422a6d92930680d1bb1f94deee0d3c33b68dc9d9791a7d058`, `c83cf10483bf42e750e131a0792eedde60ae0eed244822c84ea2a1be285dd8a7` e `a07a14a115de877411319568a2982e6b5e6e6a8d03c550ead82a6e7078b487e0`. Retenho a reconstrução de R2, os desvios e votos completos de R1_M, os endpoints e a validação efetiva de B.4 para essas mesmas fontes. Não repetirei as 3.620 verificações numéricas intactas para aparentar nova evidência.

A retenção não se aplica automaticamente às três obrigações corrigidas. Meu parecer v1 tinha PASS e **não detectou a identidade algébrica incorreta de F001**. Isso foi uma falha daquela revisão. Preservo o documento histórico, identifico abaixo a desigualdade correta e refaço sua validação. O resultado econômico preservado não torna a identidade anterior verdadeira. A prova US-1 e a precisão endpoint são examinadas por seu conteúdo novo, não pela conclusão geral da v1.

O parecer v1 efetivamente leu e conferiu B.4/B.8/E.3 da fonte original, sem tratar isomorfismo como prova da correção dos resultados históricos. Nesta rodada, releio a primeira redução de B.8, a classificação por massa de posterior zero e as condições de E.3 que consomem US-1, além dos consumidores no preview. A condição de equilíbrio da agenda continua dependente da seleção completa declarada, incluindo sua restrição Markov e os representantes uniformes. QI-01 permanece: endpoints importados são assessments com prior de entrada degenerado; isso não demonstra que um posterior degenerado em qualquer história de um baseline com prior original interior redefine seu suporte.

## 3. F001: a diferença correta é positiva em todo o domínio

Localizador: `derivations/v2/agenda_transport.md:212–223`. O novo hash da nota é `223d70575f64ca60b8807ab6e0bff5fec8819328a8a4d91fc10f22825f3f6c04`.

No ramo público de inclusão, passagem menos rejeição é

\[
D=1-\frac{k\beta(1-\beta o)}m-\beta^2o
 =1-\frac{k\beta}m-\beta^2o\left(1-\frac km\right).
\]

Subtrair \(1-\beta\) dá exatamente

\[
D-(1-\beta)=\beta\left(1-\frac km\right)(1-\beta o)>0.
\]

De fato, \(k=\lfloor(m+1)/2\rfloor<m\) para \(m\ge3\), e \(0<\beta,o<1\). Assim a passagem domina estritamente a recusa. A identidade vale em todo esse domínio; o consumidor público aplica-a no subdomínio \(o\le1/m\). Não foi acrescentada hipótese econômica.

A diferença entre D e o produto incorreto da v1 é \((k/m)\beta^2o(1-\beta)>0\). Por exemplo, em \(m=4,\beta=.9,o=.1\), D é `1019/2000`, o produto antigo é `10109/20000`, e a diferença é `81/20000`. Portanto o reparo elimina um erro real de prova mantendo o sinal e a fórmula final.

Conferi os consumidores: a regra pública A12, o cutoff \(o_M^*=1/\beta-k/m\), o gap público e os contrastes D conservam o argumento. No preview, E.6 (`P:2888–2920`) afirma corretamente a dominância estrita e não contém o produto falso. Não há dependência desse produto nos resultados privados, em US-1 ou na comparação C15.

## 4. F002: US-1 fecha também pontos de suporte de massa zero

Localizador: `derivations/v2/unanimity_support_lemma.md:7–106`, hash `1491acd877ae5d3ca4eda2c6c9cacd10bffe9221fe52964f11cd7d962d5068ef`; ligação na nota de agenda `V2:364–374`. A conclusão foi verificada analiticamente, sem usar uma grade numérica como prova sobre medidas Borel.

O argumento usa efetivamente as premissas declaradas: prior interior, posteriors admissíveis \(\{0\}\cup(p^*,1]\) em todo o suporte, existência do limite local em todo ponto, posterior comum fora do suporte, valor comum das duas leis e incentivos pontuais. Nenhuma afirmação de continuidade do payoff foi introduzida. A única função cuja continuidade é usada é a coordenada \(x_H\).

A identidade média de Bayes é válida para as medidas em questão. A medida \(p\sigma_h\) é dominada por \(\bar\sigma\); ambas são medidas Borel finitas no simplex euclidiano compacto. A diferenciação de medidas por bolas identifica sua derivada de Radon–Nikodym com o limite da razão de massas quase certamente em relação à medida denominadora. A extensão por zero preserva a razão das bolas relativas. Portanto \(p\sigma_h(E)=\int_E\mu\,d\bar\sigma\) para todo conjunto Borel E. Isso vale para átomos, medidas singulares e leis sem átomos; não exige densidade de Lebesgue.

Os limites \(d\le V\le z_H\) são independentes de US-1: o alto pode provocar recusa; toda passagem precisa pagar os pisos fracos; toda recusa paga no máximo d. A primeira redução de B.8 fornece o valor comum pela possibilidade de imitação e pela igualdade de payoff quase certa, usando que sinais de posterior zero não têm massa do tipo alto.

Se \(V<z_H\), uma bola suficientemente pequena em torno de \(x^h\) tem \(x_H>V\). O caso fora do suporte é resolvido pelo posterior comum alto. No caso dentro do suporte, a parte dessa bola com posterior zero tem massa alta zero por Bayes e massa baixa zero por incentivos: passagem daria estritamente mais que V, enquanto recusa daria \(\beta^2\ell<d\le V\). Ambas contradizem o payoff usado quase certamente pelo baixo. Em cada bola menor, de massa pública positiva, o posterior é portanto maior que \(p^*\) quase certamente.

A média local é estritamente maior que \(p^*\). Seu limite só é, inicialmente, **maior ou igual** a \(p^*\); a prova não troca incorretamente limite por desigualdade estrita. A admissibilidade elimina o zero, pois \(p^*>0\), e elimina a igualdade, pois \(p^*\) não está no domínio admissível. Segue \(\mu(x^h)>p^*\). Assim a proposta no próprio ponto de suporte passa e é um desvio lucrativo, mesmo com massa zero. A contradição estabelece \(V=z_H\).

Por fim, recusa rende menos que \(z_H\); passagem nesse valor requer todos os pisos \(r_U(h)\), cuja soma com \(z_H\) esgota a pie. Isso força a proposta única \(x^h\) quase certamente para ambas as leis. Bayes no átomo comum implica posterior p, necessariamente maior que \(p^*\). A conclusão de lei pontual, além do payoff, está demonstrada.

As duas aplicações estão cobertas. Quando \(\lambda_0>0\), o limite \(V\le z_L<z_H\) elimina posterior off-support alto, deixando apenas zero. Quando \(\lambda_0=0\) e o posterior off-support é alto, US-1 determina diretamente as duas leis pontuais. A divisão continua exaustiva, os domínios de existência não mudam e E.3 mantém as imagens e os endpoints. No preview, o lema está em `P:1981–2021` e as aplicações em `P:2027–2036` e `P:2081–2087`; a integração preserva todos os passos essenciais.

O teto global \(V_U^A\le z_H\) e C15 não dependem da conclusão US-1: decorrem dos limites elementares anteriores. US-1 fecha a classificação B.8/E.3 e, por ela, os consumidores de existência, renda unânime e efeito total de agenda.

## 5. F003: probabilidade um no argmax é a condição correta

Localizador: nota de agenda `V2:289–304`; preview `P:1827–1829`, `P:2494–2509` e `P:2698–2718`. A precisão expositiva é suficiente. Não foi necessário mudar a primitiva, o conceito de equilíbrio ou os conjuntos de payoff interpretados por QI-05.

A condição de melhor resposta de uma lei é \(\sigma_o(\operatorname{argmax}u_o)=1\). A condição pontual em toda proposta é ausência de desvio lucrativo. Quando o payoff é descontínuo, essas condições não impõem igualdade no valor em cada ponto do suporte topológico da lei.

Uma testemunha simples verifica que a distinção é substantiva para a redação. Tome \(m=4,\beta=.9,\ell=.1,h=.9,p=0\). O preço fraco é \(r_0=.20475\). Sob M, o melhor acordo deixa \(a_0=.5905\) com dois convidados fracos; sob U deixa \(a_0=.181\) com quatro. Em ambos, o alto de probabilidade zero prefere recusa, que lhe dá \(\beta^2h=.729\). De uma proposta no cutoff que passa, acrescente \(\varepsilon\) a H e retire \(\varepsilon\) de um fraco convidado. Para todo \(0<\varepsilon<r_0/2\), o contrato é factível, esse convidado veta e o alto recebe seu máximo .729. Uma lei uniforme nesse intervalo atribui probabilidade um a melhores respostas; seu suporte contém a proposta limite \(\varepsilon=0\), que passa e dá estritamente menos ao alto. Proibi-la por inclusão topológica de suporte excluiria uma estratégia ótima permitida.

O preview formula a condição de probabilidade um tanto em M quanto em U, preserva o tipo de probabilidade zero e distingue a desigualdade pontual da igualdade quase certa. O exemplo interior sem átomos da revisão v1, com um limite do suporte que troca o ramo da continuação, também continua válido porque as interfaces e o critério geral não mudaram.

## 6. Cobertura científica das notas: 17 claims

| Claims | Conferência e resultado |
|---|---|
| C02, N01, N02 | Primitivas, todos os ramos de consentimento, não convite, não acúmulo e disciplina baseline retidos pelas três notas idênticas. A restrição de alocação fora de C é uma escolha autoral explícita, não um teorema de racionalidade. |
| C06 | R2 retém todas as coalizões nominais ótimas M, thresholds U, empate e endpoints. A reconstrução fria e a verificação v1 continuam nos mesmos bytes. |
| C07, N03 | R1_M conserva votos após toda proposta, veto de convidado extra, redução pré-voto a E/S/P, inviabilidade de delay ótimo e desempates. A seleção uniforme/EP usa a mesma mistura em todos os objetos. |
| C08 | R1_U conserva a prova efetivamente conferida de B.4, o domínio vazio de votos puros, sua testemunha de desvio e os tipos de probabilidade zero. QI-01 não é convertido em consistência global. |
| C05 | Benchmark público e vetores econômicos baseline preservados; não se conclui identidade de histórias majoritárias. |
| N04, N05 | O sinal é o par completo (C,x), Bayes local distingue componentes, os pisos e garantias M continuam uniformes. Acordos mínimos são conclusão quase certa; recusas superdimensionadas e desvios permanecem no domínio. |
| C12 | Revalidado pelo cálculo correto F001 e pela leitura dos consumidores públicos. |
| N06 | Critério Borel retido com incentivos pontuais e igualdade quase certa; F003 torna endpoints explícitos. A existência continua para algum valor de ρ, sem promessa em toda fibra. |
| N07 | Contraprovas de equivalência majoritária e testemunha de reversão são intactas. Seus números, Bayes e incentivos já verificados continuam nas mesmas fontes. |
| N08 | Isomorfismo U permanece válido em toda a árvore; US-1 e suas duas aplicações foram conferidos independentemente, além das dependências históricas B.4/B.8/E.3. |
| N09 | Nova representação conserva C e não convite; kernels Borel e equivariantes, órbita diagonal conjunta e fatoração por nomes são preservados. A assinatura realizada não é promovida a codificação de toda função off-path. |
| C15 | Garantia M e teto global U produzem a região suficiente; dependência separada de US-1 e exigência de existência das duas fontes explicitadas. |
| C17 | Datas, uma aplicação de β e identidades IR/D/I/T/Q continuam ligadas ao mesmo vetor. Fórmulas/figuras só são transportadas para os consumidores indicados; vazios propagam-se. |

## 7. Preview integral: fidelidade e consequências científicas

O preview tem 3.349 linhas. A comparação com o snapshot original de 3.119 linhas encontra 2.784 linhas idênticas, 335 antigas substituídas/removidas e 565 novas em 110 blocos de diferença. Esses números vêm de `SequenceMatcher(autojunk=False)`; os 34 hunks do diff armazenado usam outro agrupamento de contexto e não são uma contagem de mudanças substantivas. A leitura integral por blocos foi concluída antes da revisão. Nesta fase confrontei os trechos alterados e seus consumidores com as notas, sem presumir que igualdade de fórmula estabelecesse equivalência estratégica.

| Claim do manuscrito | Localizadores e conclusão de consistência |
|---|---|
| C01 | Abstract `P:35–36`, introdução `P:117–139` e resultados: a vantagem informacional é condicional à inclusão e às células de existência. A renda zero por exclusão é qualificada pelo benchmark público; a reversão não é situada dentro da região de vantagem majoritária robusta. |
| C02 | `P:303–342`: tipos, pie, informação, reconhecimento e quota refletem as primitivas aprovadas. |
| C03 | `P:321–394`, diagrama `P:396–425`, A.1 `P:1411–1430`: consentimento de todos os convidados, execução automática, veto integral e payoff de H excluído são consistentes. Não resta cancelamento primitivo no ramo contestado. |
| C04 | `P:428–450`, A.2 `P:1432–1456`: C escolhido por fraco não sinaliza, H excluído não vota, crenças locais por ballot/voto permanecem. Distinção baseline/agenda e QI-01 preservadas. |
| C05 | `P:504–559`, B.1 `P:1460–1492`: exclusão e inclusão públicas seguem dos novos contratos; a multiplicidade nominal terminal M é conservada. |
| C06 | `P:561–586`, B.2 `P:1494–1509`: solução terminal e empate coincidem com a reconstrução fria e a interface revisada. |
| C07 | `P:588–646`, B.3 `P:1511–1567`: respostas completas e remoção de convidado são comparações pré-voto; screening parcial, continuidade de fracasso e endpoints são preservados. |
| C08 | `P:648–728`, B.4 `P:1569–1645`: o transporte U mantém respostas, desvios e domínio de inexistência. A escrita do mínimo sobre respondedores fracos evita incluir o proponente por engano. |
| C09 | `P:730–780`, B.5 `P:1647–1659`, C `P:2179–2218`: vetores e misturas vinculadas permanecem corretos; figuras não preenchem a célula vazia com zero. |
| C10 | `P:782–903`, B.6 `P:1661–1683`: rendas usam seu benchmark público por tipo. A mudança de data do payoff externo sob exclusão continua considerada. |
| C11 | `P:905–939`, E.1 `P:2301–2378`: proposta obrigatória (C,x), componentes distintos, Bayes em todos os pontos do suporte, posterior off-support único e seleção completa Markov são os da nota. |
| C12 | `P:941–1047`, E.6–E.8 `P:2888–2954`: fórmulas públicas e sinal do gap preservados pelo reparo F001. |
| C13 | B.7 `P:1685–1923`, E.2 `P:2380–2580`: seis formas puras, critério Borel, garantias, endpoint de probabilidade um e quantificador de existência correspondem à derivação. A construção de leis retém recusas com qualquer C. |
| C14 | `P:1049–1106`, B.8 `P:1925–2106`, E.3 `P:2582–2797`: US-1 foi migrado com seus passos e ambas as aplicações. A correspondência e os endpoints refletem as notas v2. |
| C15 | `P:1118–1152`, E.5 `P:2838–2886`: condição suficiente deriva do teto/garantia; não exige US-1 e não é apresentada como necessária. |
| C16 | `P:1154–1204`, E.9–E.10 `P:2956–3044`: incidência de renda e decomposição usam os vetores mantidos. A testemunha da tabela agora explicita as propostas e a mesma fibra ρ=0 em `P:2443–2453`. |
| C17 | `P:1206–1266`, E.11–E.14 e F.2–F.4: contrastes entre jogos usam uma conversão temporal e suas fontes não vazias. T_U≥0 continua condicionado à existência das duas fontes. |
| C18 | B.9 `P:2108–2175`, E.2/E.3 e F.1: órbita diagonal e resumo anônimo são das novas leis realizadas. A codificação finita de continuação M em `P:2516–2525` é compatível com propostas fixas E/S/P e probabilidades EP; funções de crença/off-path continuam no binder. |
| C19 | Discussão `P:1268–1347`: a migração não acrescenta identificação causal, estimativas empíricas ou equivalência econômica com Evdokimov. A leitura delimitada do direito formal de agenda é a do contrato, sem certificação independente de todos os fatos históricos. |
| C20 | `P:1349–1403`: horizonte, informação binária, multiplicidade, células vazias e âmbito da interpretação continuam declarados. |

As figuras externas consomem fórmulas econômicas que permanecem válidas: preços/coalições públicas, diferenças privadas baseline, rendas, gap público da agenda e existência U. Reconfirmei os hashes dos quatro CSVs numéricos usados na revisão v1 e a existência/hash dos cinco PDFs referidos. Os checks v1 validaram 863 registros do gap, as condições do mapa U, 1.601 valores de payoff da figura de preços e os 14 registros de renda; o CSV de preços tem 1.608 linhas totais por conter registros auxiliares. A classificação da figura de contraste privado permanece apoiada nos vetores e cutoffs comprovados, sem nova execução de seu gerador. O diagrama de protocolo é TikZ inline e seus rótulos/transições foram lidos na fonte. Não atribuo a essas verificações uma inspeção visual dos PDFs.

Na nova citação, conferi diretamente o texto primário local de Evdokimov, SHA `7efe0953e16bab0f71c15ea46814a9a5aa4d606e4d73b25e6346d78680bb392c`, em `/Users/manoelgaldino/Documents/DCP/Papers/PowerPieDependent/references/extracted/evdokimov_2023_equality_in_legislative_bargaining.txt`, página 1 e seção 2.1, página 6. Autor, título, JET 212 (2023), identificador 105701 e DOI coincidem com a entrada. A fonte admite proposta (C,x), consentimento simultâneo de C e pagamentos no vetor de N; não impõe zero fora de C na definição de factibilidade. A frase do preview (`P:324–325`) atribui o protocolo-alvo e declara separadamente a restrição adicional do artigo. Ela não atribui à fonte a pie fixa, os dois tipos, os outside payoffs ou uma equivalência global dos jogos.

O BibTeX preserva as 44 entradas anteriores e acrescenta somente a nova. As 34 ocorrências de citação usam 25 chaves, todas resolvidas; a nova chave aparece uma vez. Os 31 labels são únicos e as 26 referências LaTeX resolvem. O abstract tem 168 palavras por whitespace. São verificações do par Rmd/BibTeX congelado, não do caminho de uma compilação futura.

## 8. Execuções, observação documental e limites finais

Comandos reprodutíveis, executados na raiz do repositório:

```sh
python3 quality_reports/coalition_protocol_2026-09-19/reviews/adversarial_v2_checks.py
python3 quality_reports/coalition_protocol_2026-09-19/reviews/adversarial_manuscript_checks.py
```

O primeiro produziu **221 PASS, zero FAIL**, incluindo 36 casos racionais próprios da álgebra corrigida, aritmética das testemunhas endpoint, hashes e replay seguro. O script do implementador foi executado com saída redirecionada exclusivamente para `/private/tmp`; seus **4.353 PASS em 870 casos** reproduziram byte a byte o JSON congelado. Os arquivos candidatos permaneceram idênticos. O segundo produziu **29 PASS, zero FAIL**. Um falso positivo inicial do meu extrator de citações incluía o ponto final de uma frase na chave; corrigi o extrator e reexecutei o check, sem alteração no manuscrito.

A prova sobre medidas, os desvios em domínios contínuos e o transporte integral não são inferidos desses totais. Os checks numéricos v1 de 3.620 PASS e o replay anterior de 409 checks são evidência retida em fontes idênticas, não execuções novas desta rodada. A validação analítica e seus limites estão descritos acima.

Durante a conferência encontrei um resíduo documental no contrato v2 então SHA `15813af5fe6efbd53a840bebe7c072a5f6ec3b2738786743f2a4ee831ca92e2c`: `synthesis.scope_conditions[0]` ainda dizia quatro notas/bundle v1. Avisei o macro e o coordenador. O macro confirmou o resíduo editorial, preservou o snapshot e corrigiu o contrato; o hash final `7db1a7…` identifica cinco notas/bundle v2 corretamente. O contrato final do manuscrito também atualizou seu vínculo e localizadores. Não houve mudança de candidato ou de interpretação substantiva. Esta observação está encerrada e não constitui finding científico aberto.

**Fronteira dos veredictos:** PASS das cinco notas exatas, com cobertura v1 expressamente delimitada e reparos revistos; PASS de fidelidade científica da migração para o preview completo exato e sua bibliografia. Não houve renderização, inspeção visual, aplicação dos patches, migração canônica, commit, tag, merge, push ou submissão por este revisor. Qualquer alteração posterior dos candidatos é outro objeto e deve ser avaliada pelo seu impacto. Não há finding científico pendente neste parecer.
