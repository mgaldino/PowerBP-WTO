# Revisão adversarial independente — coalition-derivations-v1

**Veredito: PASS, no escopo do contrato interpretativo identificado abaixo.** A revisão cobre as quatro notas matemáticas integralmente, todos os 17 claims do contrato, as dependências históricas unânimes B.4/B.8/E.3 e os consumidores econômicos identificados neste parecer. Não encontrei um desvio lucrativo omitido, uma célula de existência incorreta ou uma afirmação de equivalência majoritária que o candidato efetivamente faça e que os exemplos contradigam. Há zero findings científicos bloqueantes, maiores ou menores. QI-05 admite a precisão expositiva indicada na seção 7; ela não requer nova hipótese ou mudança de resultado.

Revisor: `/root/provenance_inventory`; data: 19/09/2026. Não implementei as notas candidatas e não li o outro parecer científico. Minha reconstrução fria de R2 precedeu a leitura das novas soluções. A presente revisão é adicional àquela folha: não herda um PASS histórico para os novos bytes. Não editei o candidato, manuscrito, scripts de figuras ou instruções. Os únicos novos artefatos desta revisão são este parecer, seu JSON e os dois arquivos `adversarial_checks_v1.*`.

## 1. Objeto exato e fronteira do PASS

Todos os caminhos desta seção são relativos a `quality_reports/coalition_protocol_2026-09-19/`, salvo indicação contrária. `B:L` designa a linha L do bundle, que reproduz as quatro notas entre seus marcadores.

| Objeto | SHA-256 |
|---|---|
| `reviews/derivation_candidate_v1.json` | `8dfefecda3b9e369159bbfeb4276f5f6d7c2402e3e897320774b39be12d1feca` |
| `derivations/derivation_bundle_v1.md` | `b62a7c8e023568bf408c1b8929b5909b4e7af21c3271c95955970237801b799f` |
| `argument_contract/derivations_v1/argument_contract.json` | `a49fc5f5d1737b7d8661506b6e384b709314a98798cacd33e4d981ffb5b07c36` |
| `author_decision.md` | `7abfa53814ff23c61a9af2049c975be81e44f8e66270c4fa3f99accd51923726` |
| `derivations/game_contract.md` | `ac78634ea0da03b422a6d92930680d1bb1f94deee0d3c33b68dc9d9791a7d058` |
| `derivations/r2_interface.md` | `c83cf10483bf42e750e131a0792eedde60ae0eed244822c84ea2a1be285dd8a7` |
| `derivations/r1_interface.md` | `a07a14a115de877411319568a2982e6b5e6e6a8d03c550ead82a6e7078b487e0` |
| `derivations/agenda_transport.md` | `3b98454cb275f34a89c6f5a10037eaa34e30e4fbf81e4fb4f01a65e2f8ba9f6f` |
| `derivations/agenda_checks.py` | `9874ca255487e2245f8d44d3915e82cd6974331a7cd7a05278a7608e5de47445` |
| `derivations/agenda_checks.json` | `7e0a20ac6790a1f949e760c9fbf00d7d70b7290d266f9342dc794efa70e2a75e` |

Os sete hashes do manifesto foram conferidos, assim como o bundle e o contrato. A fonte histórica lida foi `formal_model_v6.Rmd`, na raiz do repositório, SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`. HEAD: `c6dfab61a5a3b44d09ba389911df47726f81b51e`.

O objeto é uma candidata matemática fora do manuscrito. Este PASS não certifica integração, redação final, PDF, renderização de figuras, fontes históricas inteiras ou prontidão para submissão. Em particular, não torna a maioria nova isomorfa à antiga e não amplia o conceito de solução para votos mistos ou equilíbrio sequencial.

A seleção de continuação da agenda é uma hipótese mantida, com seus representantes completos anônimos. Conforme QI-01, o endpoint de R1_U importado pela agenda é o assessment do jogo com prior de entrada degenerado. Isto não demonstra que um posterior degenerado alcançado em qualquer história de um baseline com prior inicial interior redefine o suporte original. Dentro desse baseline a disciplina original continua vigente. O PASS não apaga essa restrição interpretativa nem a transforma em teorema de consistência global.

## 2. Cobertura dos 17 claims

| Claim | Localizador | Resultado da revisão adversarial |
|---|---|---|
| C02 | B:14–43 | Primitivas preservadas; nenhum excedente dependente de H, externalidade ou fonte de informação fraca introduzido. |
| N01 | B:14–43,73–84 | A divisão exaustiva dos ramos fecha payoffs e não acúmulo para toda proposta e vetor de votos factíveis. |
| N02 | B:45–71,86–110 | Distinção entre não convite e voto N, simultaneidade, Bayes e crenças livres locais preservada no conceito declarado. |
| C06 | B:123–189 | Refeito a partir das primitivas; multiplicidade nominal em R2_M e corte/empate de R2_U corretos. |
| C07 | B:203–281 | Redução pré-ballot a E/S/P válida; verificados os cinco regimes de preço, endpoints e desempate residual E/P. |
| N03 | B:283–318,468–500,811–815 | Representante uniforme é uma seleção admissível completa; um mesmo peso λ liga payoffs e leis. Borelidade e equivariância verificadas. |
| C08 | B:320–381 | Respostas completas U e testemunha de inexistência conferidas; leitura e validação efetiva de B.4, não apenas invocação de isomorfismo. |
| C05 | B:383–399 | Benchmark público e contrastes econômicos seguem dos novos ótimos; a preservação não identifica histórias/estratégias antigas. |
| N04 | B:423–500 | Ação pública completa é (C,x); μ no suporte depende da face C. Verificados Bayes local, endpoints e continuação após toda recusa. |
| N05 | B:502–597 | Piso de consentimento, garantias e minimalidade quase certa demonstrados sem apagar coalizões superdimensionadas desviantes/rejeitadas. |
| C12 | B:598–624 | Melhores acordos e desacordo público produzem as fórmulas e cutoffs históricos; conferidos gap e D. |
| N06 | B:626–705 | Tabela pura necessária/suficiente e critério Borel cobrem todos os sinais; existência é para algum ρ. Construído teste analítico atomless independente. |
| N07 | B:707–763 | Ambos os contraexemplos e a testemunha de reversão têm factibilidade, votos, Bayes e IC válidos. |
| N08 | B:320–326,765–773 | Isomorfismo U válido em toda a árvore. B.4/B.8/E.3 revisados efetivamente e resultados consumidores derivados abaixo. |
| N09 | B:775–847 | Espaço ambiente, kernels Borel, órbita diagonal e fatorização por nomes são suficientes para os objetos realizados alegados. |
| C15 | B:591–595,849–869 | O bound usa garantias novas M e teto U, com existência de ambas as fontes; não exige equivalência global. |
| C17 | B:849–901 | Datas, vínculo entre coordenadas e propagação de vazios corretos; transportes de figuras limitados às fórmulas indicadas. |

## 3. Primitivas, R2 e R1_M: ataques a propostas e votos

A arquitetura fecha o ramo antes problemático sem recorrer à racionalidade. Se H é convidado e recusa, qualquer tamanho de C fracassa. Se H fica fora e há acordo, factibilidade já exige x_H=0. Se H é convidado e há acordo, houve seu consentimento e o pagamento é x_H. Desvios de voto ou proposta não criam um quarto ramo. O voto N dos fracos também faz o contrato inteiro fracassar quando são convidados; não existe fraco com voto N dentro de um contrato aprovado. Essa mudança é a decisão autoral, não uma conclusão obtida preservando o antigo ballot majoritário.

Em R2 todo fraco convidado aceita qualquer parcela não negativa: a recusa pivotal dá zero e T^Y resolve a igualdade. H convidado aceita iff x_H≥o. Em M, qualquer coalizão só de fracos de tamanho ao menos q, contendo o proponente, implementa x=e_i e lhe dá 1. Nenhuma proposta com parcela positiva para outrem ou probabilidade positiva de fracasso melhora 1; uma proposta que inclui H e o faz aceitar exige pagamento positivo. Assim a multiplicidade de C, inclusive tamanho maior que q, é real. Antes do reconhecimento cada fraco recebe 1/m e H recebe seu o. Em U o único C é N; comprar o baixo custa ℓ, comprar ambos custa h. Comparar (1−μ)(1−ℓ) e 1−h dá p*=(h−ℓ)/(1−ℓ); no empate o menor payoff esperado de H seleciona ℓ. Estes valores são nativos, sem β.

Em R1_M, w=β/m vale para todo convidado fraco, inclusive depois de propostas ou votos desviantes. Se todos os fracos prescritos aceitam, H compara x_H com βo. Se algum fraco está abaixo de w, a passagem é impossível sob ambas as ações de H; ambas as continuações valem βo, e H usa Y pelo desempate. Isso é uma resposta à estratégia simultânea prescrita, não observação antecipada dos votos realizados. Quando H não está em C, não lhe é atribuído um voto fictício.

Fracasso certo dá w ao proponente, inferior a E=1−kw porque 1−β(k+1)/m>0. Uma proposta com probabilidade positiva de aprovação e convidado fraco excedente pode remover esse convidado antes do ballot, transferindo ao proponente uma parcela de ao menos w, sem alterar a aceitação de H ou o valor da continuação M. A melhoria esperada é estrita. A mesma comparação elimina pagamentos acima do limiar e recursos desperdiçados nas propostas ótimas. Não se trata de cancelar pagamentos depois de votar.

Restam E, S e P, com os valores da tabela. Chequei as igualdades

\[
\Pi_P-\Pi_E=\beta(1/m-h),\qquad
\Pi_S-\Pi_E=(1-\mu)\beta(1/m-\ell)-\mu[1-\beta(k+1)/m].
\]

Elas dão os cortes declarados, incluindo ℓ=1/m, h=1/m e priors 0/1. Quando S empata no máximo, seu payoff esperado de H é estritamente menor que o concorrente relevante. Acima do cruzamento S, em h=1/m, E/P têm o mesmo payoff do proponente; a comparação entre (1−μ)ℓ+μh e βh dá o desempate secundário. A igualdade residual conserva uma mistura com um único λ. Propostas formalmente inviáveis de S/P jamais vencem E; não há máximo artificial obtido fora do simplex.

O representante de continuação retém reconhecimento uniforme, parceiros uniformes, C, parcelas, votos e a nova realização de R2 após a recusa do alto em S. A identidade do proponente não é confundida com uma realização independente por coordenada. Os valores condicionais dos fracos em S são ((1−βℓ)/m,β/m), cuja média produz a interface. Seleções Borel existem pelas células explícitas; λ é escolhido Borel no empate. Bayes nos denominadores positivos é racional/Borel e o complemento local que usa a crença de entrada é Borel e respeita o suporte. Os mapas de resposta e sorteios uniformes comutam com permutações dos nomes fracos.

## 4. R1_U e revisão efetiva de B.4

Li B.4 integralmente (`formal_model_v6.Rmd`:1532–1608) e confrontei os quatro perfis puros de H com a nova interface. Escreva A=β(1−ℓ)/m, B=β(1−h)/m, u como menor pagamento entre respondedores fracos, t=x_H e W(η)=(1−η)A para η≤p*, B acima. O proponente não entra no mínimo de respondedores.

No jogo de entrada μ=0, todo posterior permanece 0. Se u<A, o veto fraco torna H indiferente e ambos os tipos escolhem Y. Se u≥A, os perfis são NN para t<βℓ, YN para βℓ≤t<βh e YY para t≥βh. No jogo de entrada μ>p*, YY exige u<B ou, havendo consentimento fraco, t≥βh. NN exige u≥B e t<βh; sua crença livre após Y precisa sustentar o consentimento fraco, e escolher η^Y=μ é uma completação admissível. Perfis separadores não satisfazem simultaneamente as melhores respostas. O endpoint μ=1 tem suporte alto, com a mesma partição YY/NN. Os tipos de probabilidade zero continuam recebendo ações e payoffs.

Para 0<μ≤p*, a proposta desviada t=βℓ e todos os fracos respondedores recebendo A é factível: deixa ao proponente A+1−β>0. Todo fraco aceita para qualquer crença admissível porque A é o maior custo de continuação. Nenhum perfil puro de H fecha: YY dá desvio lucrativo ao alto; NN faz o baixo aceitar no empate; YN permite ao baixo imitar a recusa do alto e obter βh; NY deixa o alto preferir a recusa. Uma só proposta factível sem resposta completa já impede PBE com a classe de ballots mantida. Não inferi inexistência para votos mistos.

Onde há assessment, a proposta ótima paga βℓ e A a cada respondedor no endpoint baixo, ou βh e B na região alta. Acordo dá ao proponente 1−β mais seu valor de continuação; fracasso não compete. Os valores nativos, respostas desviantes e fronteiras de B.4 são, portanto, efetivamente validados, com a restrição de endpoints do contrato interpretativo.

## 5. Agenda M: incentivos, medidas e desvios fora do suporte

Os votos fracos em A comparam x_j com r=βc_χ(μ). Todos os convidados consentem ou o pacote falha; não convidados não votam. Como r>0, no ramo que passa a coalizão é recuperável pelas parcelas positivas. Esse argumento não permite apagar C de sinais rejeitados.

A posterior fixado, um acordo que maximiza a parcela de H compra k convidados por r e deixa A_μ=1−kr. O candidato não usa essa otimização local como solução do problema de sinalização: propostas desviantes podem mudar μ. A garantia global decorre de oferecer w=β/m a k convidados, o que passa para qualquer μ. A identidade do candidato para S, juntamente com sua otimalidade sobre E, dá w(1−w)≤r≤w. Assim um acordo com k+1 convidados entrega a H no máximo 1−(k+1)w(1−w), estritamente abaixo de 1−kw, pois w[1−(k+1)w]>0. A exclusão de acordos superdimensionados é quase certa em equilíbrio; eles continuam no espaço, nos desvios e nos pontos do suporte de massa zero. A recusa deliberada assegura ao menos β²o, sem opção de saltar A.

Na tabela pura A-C6, um ou dois átomos deixam um contínuo de sinais fora do suporte. O melhor acordo off-support pode ser aproximado por reduzir x_H em ε, mantendo os pagamentos fracos e evitando os sinais usados. A recusa também pode ser realizada por infinitos pares (C,x). Logo O_o=max{A_off,d_o,off} é o supremo correto, mesmo se um maximizador específico já pertencer ao suporte. Pooling exige proteção contra O_o; separação acrescenta imitação bilateral. Dois acordos precisam dar o mesmo z a H. Baixo recusando/alto acordando exigiria d_ℓ,0≥z≥d_h,0, impossível. Para as demais linhas, sinais distintos podem ser construídos por coalizões mínimas diferentes, pois k<m, ou por recusas diferentes. Verifiquei necessidade e suficiência, não apenas os payoffs das testemunhas.

As três construções de existência cobrem a economia usando T=(1−kw)/β>1/m: pooling se h≤T, separação baixo-acordo/alto-recusa se ℓ≤T≤h e recusa de ambos se T≤ℓ. O segundo caso usa μ_off=1, permitido por ρ=∞ em prior interior. Endpoints são problemas de maximização com posterior fixo. Não há prova ou alegação de existência para todo ρ.

Em A-C7, u_o≤V_o em todo S elimina desvios inclusive nos pontos de massa zero e nos sinais do outro tipo. A igualdade σ_o-quase certa garante que a própria mistura só usa melhores respostas com probabilidade um. A condição V_o≥sup fora de S completa todos os desvios puros e, por integração, também todos os desvios mistos. Reciprocamente, melhores respostas satisfazem as três condições. Os payoffs são limitados e Borel; as integrais existem. Não se supõe continuidade ou semicontinuidade superior para substituir o supremo por máximo.

Em cada componente euclidiana compacta X_C, razões de medidas de bolas são Borel, e a existência do limite em todo suporte produz o posterior Borel. A identidade ∫_E μ d\barσ=pσ_h(E) é a identificação quase certa da derivada de Radon–Nikodym pelo limite de razões de bolas; as componentes são finitas, de modo que a identidade vale na união disjunta. A exigência pointwise adicional em pontos excepcionais permanece uma restrição, não é deduzida de Bayes quase certamente. Não se usa a projeção x para calcular essa razão.

### Testemunha atomless independente

Para testar os quantificadores sem depender de uma enumeração finita de átomos, construí uma família no próprio Y_M. Fixe m=4, β=.9, ℓ=.1, h=.2, t=9/46, a=1/100, p=t+a/2. Para s∈[0,a], use C={H,1,2} e x(s)=(.6,.19+s,.19,0,0). Tome \barσ uniforme no segmento e densidades dσ_h/d\barσ=(t+s)/p e dσ_ℓ/d\barσ=(1−t−s)/(1−p). Ambas integram um; Bayes por bolas dá μ(s)=t+s inclusive nos endpoints. As leis dos dois tipos são sem átomos e têm o segmento inteiro como suporte.

Para s>0 o baseline seleciona P, r=.1845 e o acordo passa, pagando .6 a ambos. Em s=0, o desempate seleciona S e r=.225(.91−.01t)>.19; há recusa, com payoff (.081,.162). O ponto s=0 pertence a ambos os suportes e não é argmax, mas tem massa zero e satisfaz u≤.6. Com μ_off=0, o melhor desvio externo oferece no máximo .5905 ou a recusa (.081,.162). Portanto as condições de A-C7 são satisfeitas. Esse exemplo valida a necessidade da desigualdade pointwise e da igualdade apenas quase certa. Não é um contraexemplo ao candidato.

## 6. Unanimidade: B.8/E.3, não apenas isomorfismo

Além do mapa C=N, li e validei `formal_model_v6.Rmd`:1831–1964 (B.8) e 2362–2567 (E.3), incluindo famílias de leis, pontos de suporte de massa zero e tipos sem probabilidade. O isomorfismo preserva simplex, vetores de votos, transições, informação, datas e topologia relativa. O ramo histórico com H=N e passagem é impossível em U. Isso permite o transporte; os argumentos seguintes verificam o resultado transportado.

Escreva r_L=β(1−βℓ)/m, r_H=β(1−βh)/m, z_L=1−β+β²ℓ, z_H=1−β+β²h e d=β²h. Os únicos posteriores de continuação admissíveis são 0 ou estritamente maiores que p*. O alto consegue d por recusa; em posterior alto, o baixo tem o mesmo valor de recusa. No interior do prior, a identidade de Bayes dá μ>0 quase certamente sob σ_h. Imitando os sinais efetivamente usados pelo alto, o baixo obtém ao menos V_h≥d. Nos sinais de posterior positivo os dois tipos têm o mesmo payoff; um sinal usado pelo baixo com μ=0 não pode recusar, pois daria β²ℓ<d. Assim o alto também pode imitar os sinais relevantes do baixo, e V_ℓ=V_h=V.

O pacote X_L=(z_L,r_L,…,r_L) passa em todo posterior admissível, porque r_L≥r_H. Logo V≥max{z_L,d}. Se a massa de μ=0 é positiva, algum acordo nessa região precisa pagar V≤z_L; consequentemente V=z_L≥d. A restrição de recursos força que esse sinal seja precisamente X_L, com átomo positivo do baixo e nenhum átomo do alto. Não há segunda forma de realizar passagem e parcela z_L sob μ=0. Se a massa de μ=0 é zero, Bayes plausibility dá p>p* e a família alta permanece possível.

Um detalhe adversarial importante é que não basta chamar X_H de desvio off-support sem conferir se pertence ao suporte. Quando μ_off>p*, todos os pontos do suporte distintos de X_L também têm posterior alto: em uma vizinhança que exclua o único possível átomo X_L, a massa é quase certamente de posteriores >p*, logo o limite é ≥p*; a admissibilidade exclui a igualdade. Na família sem massa zero, o mesmo argumento vale em todo suporte. Portanto X_H=(z_H,r_H,…,r_H) passa esteja fora ou dentro do suporte. Ele garante z_H; a família baixa não subsiste e a família alta reduz-se a ambos os tipos em X_H. Este argumento fecha o caso de massa zero sem supor continuidade da estratégia.

Quando μ_off=0, a família baixa existe iff z_L≥d e pode ser construída com o baixo em X_L e o alto em outro acordo que lhe dá z_L, pagando r_H aos fracos. A família alta exige p>p* e tem V=z∈[max{z_L,d},z_H]; pooling em (z,(1−z)/m,…,(1−z)/m) realiza todo esse intervalo. As leis gerais de E.3 acrescentam as restrições pointwise e quase certas que impedem imitação e desvios; não há terceira família, porque a massa de μ=0 é positiva ou zero. Uma lei do baixo na família baixa precisa do átomo X_L; não interpretei a discussão de leis atomless como dispensa desse átomo obrigatório.

Em p=0 o baixo escolhe X_L e o alto contrafactual recebe max{z_L,d}; se prefere recusa, pode usar qualquer lei que lhe atribua probabilidade um. Em p=1 ambos escolhem X_H. Os payoffs das famílias e endpoints dão diretamente E.9, E.13 e F.2: renda é o vetor menos (z_L,z_H); T_U subtrai uma vez β do vetor nativo de R1; I_U subtrai βIR_U^B. Conferi os casos vazios e os extremos dos intervalos, inclusive o payoff contrafactual alto em p=0.

## 7. QI-05: precisão expositiva suficiente

Localizador: `agenda_transport.md`:300 / B:705, frase endpoint “medida suportada no argmax”; a formulação histórica correlata aparece em E.3:2478–2482. Conforme o contrato, o significado alegado é σ_o(argmax u_o)=1. Esse enunciado está correto. A contenção do suporte topológico seria uma afirmação mais forte e falsa em geral; o contrato explicitamente não a faz.

Uma testemunha exata usa m=4, β=.9, ℓ=.1, h=.9 e p=0. Temos r_0=.20475, a_0=1−2r_0=.5905 e d_h=.729. O baixo propõe y_0, com C={H,1,2} e x=(a_0,r_0,r_0,0,0), e obtém o acordo ótimo. O alto contrafactual prefere recusa. Ele pode sortear ε uniformemente em (0,r_0/2) e propor, na mesma C, x_ε=(a_0+ε,r_0−ε,r_0,0,0). Cada ε>0 causa recusa e maximiza seu payoff d_h; mas y_0 está no suporte topológico dessa lei e paga ao alto apenas a_0<d_h. A lei atribui probabilidade um ao argmax, sem ter suporte topológico contido nele.

Redação suficiente, sem revisão substantiva: “Nos endpoints, cada σ_o pode ser qualquer lei que atribua probabilidade um ao argmax de u_o em Y_M.” A explicitação da notação σ_o(argmax u_o)=1 também basta. Não classifico uma leitura topológica rejeitada pelo contrato como finding contra o claim efetivo. O PASS é da leitura reconciliada, e esta recomendação deve acompanhar a futura redação integrada para que ela seja autossuficiente.

## 8. Exemplos, leis realizadas e resultados consumidores

A-EX1 é um assessment novo válido: em m=4, β=.9, ℓ=.1, h=.9, o mesmo vetor (.55,.225,.225,0,0) passa com C={H,1,2} e posterior 0, mas fracassa quando C inclui também o terceiro fraco de parcela zero e posterior 1. Os payoffs (.55,.81) vencem imitação e todos os desvios a μ_off=1. Projetar o sinal em x destrói a distinção. Isso prova falha de transporte literal desse assessment, não impossibilidade de seu vetor de payoffs no jogo antigo.

Em A-EX2, o vetor (.56,.204525,.204525,.01,0) era um acordo majoritário possível no exemplo histórico. No jogo novo a terceira parcela positiva exige convidar o terceiro fraco; sua recusa faz o pacote falhar. Mesmo mudar apenas C e deixar o posterior variar não salva a passagem: .01 é menor que o piso uniforme w(1−w)=.174375. A soma .97905, os pagamentos e as restrições de imitação foram conferidos. A tabela de reversão usa outra testemunha: com p=.95 e μ_off=0 sob as duas regras, o baixo recebe .5905 em M e .729 em U; o alto recebe .81 em M e .729 em U. O contraste público do baixo é −.4095, o privado é +.1385 e o contraste de renda +.548. O mesmo ρ=0 liga o par; não há seleção universal implícita.

Na construção de Γ, o espaço de propostas é união disjunta de finitíssimos simplexes e o espaço terminal é ambiente, evitando inferir fechamento da imagem de um kernel descontínuo. Os registros incluem os convites e o marcador de ausência de voto, além das alocações e da continuação. A seleção e os mapas de resposta Borel geram um kernel Borel e a integral de A17 uma probabilidade. Se coordenadas de crenças internas forem guardadas, sua dependência também é Borel pelas fórmulas de Bayes e completações locais; não é necessário deduzir isso apenas da constância dos payoffs.

A ação finita S_m atua diagonalmente no par (Γ_ℓ,Γ_h). A média de átomos sobre sua órbita é invariante e completa: igualdade das duas medidas de órbita coloca um par na órbita do outro, porque o singleton do próprio par tem massa positiva. Uma transversal Borel pode ser construída ordenando lexicograficamente uma codificação finita dos registros e escolhendo o menor entre suas finitíssimas permutações. Todo observável Borel anônimo sobre um registro se fatora por esse representante; a fatoração e a identidade de integrais seguem por pushforward. Isso não codifica planos off-path nem preserva relações entre coordenadas recombinadas de binders diferentes.

O benchmark público novo dá v_U^A(o)=1−β+β²o. Em M, quando o≤1/m, o preço é β(1−βo)/m e a melhor passagem vence β²o. Acima de 1/m, comparar a garantia 1−kβ/m com βo dá o_M*=1/β−k/m. Conferi separadamente Δv^A e ΔD: seus segundos ramos são, respectivamente, β(βo−e/m) e β(o−e/m), não a mesma expressão. O ponto o=1/m pertence ao ramo de inclusão e o cutoff de atraso mantém a igualdade das fórmulas adjacentes.

O bound V_U−V_M≤−β(e/m−βh) decorre de V_U≤1−β+β²h e V_M≥1−kβ/m. Ele exige fontes existentes, mas não qualquer bijeção das correspondências. T=D+I e Q=D−βIR^B são identidades dos novos vetores, com apenas um desconto entre R1 e A. Conferi E.9–E.14 (Rmd:2726–2955) e F.2–F.3 (3040–3104); nenhum vazio foi substituído por zero.

Nos consumidores gráficos, li as fórmulas de `scripts/essential_input_formulas.R`, os blocos relevantes de `scripts/essential_input_manuscript_figure_functions.R`, seu gerador e `scripts/generate_agenda_extension_figures.R`. Os dados de preços do baseline, renda no ponto trabalhado, gap público e existência U conferem com as derivadas novas. A figura F1 usa as mesmas funções de corte e vetores econômicos; a inspeção foi de suas fontes, não uma nova validação de cada polígono renderizado. A figura auxiliar F4 não integra o manuscrito. O diagrama de protocolo e as referências/pinos históricos precisam da migração indicada no inventário operacional; nenhum PASS de script histórico é promovido ao protocolo novo.

## 9. Verificação executada e limites

O script independente `reviews/adversarial_checks_v1.py` é reexecutável sem alterar o candidato:

```sh
python3 quality_reports/coalition_protocol_2026-09-19/reviews/adversarial_checks_v1.py
```

Ele gera `reviews/adversarial_checks_v1.json`. O script tem SHA-256 `549f753908d1932a642a6accb502577132bf4399498bc256dde4c48392a2455a`; a saída avaliada tem SHA-256 `e1d09402d87ef33651f0e58e7b56736988cd3198c0bce1492b4bf2a12e9b53e8`.

| Controle | Evidência executada |
|---|---|
| Controles independentes, total | 3.620 asserções aprovadas, zero falhas; aritmética racional nas verificações estratégicas. |
| Propostas R1_M | 147 estados de parâmetros/crenças; 148.771 comparações proposta/estado, incluindo todas as coalizões desses estados, pagamentos assimétricos, subpagamentos, slack e ofertas fora dos limiares da malha declarada. |
| R1_U | 819 estados de ballot com quatro perfis de H e crenças locais; mais testemunhas da célula vazia nos pontos interiores e de fronteira. |
| Exemplos de medida | Normalização e desigualdades das testemunhas atomless e endpoint QI-05; a demonstração contínua está nas seções 5/7, não inferida da malha. |
| Reprodução do candidato | Os 409 checks originais passaram e geraram JSON byte a byte idêntico ao congelado. Somente o diretório de saída foi redirecionado em memória para um temporário; o script candidato permaneceu intacto. |
| Payloads de figuras | 863 linhas do gap, condições das 5 células de existência, 1.601 observações de payoff em F2 e 14 números em F3 conferidos; tolerância 10⁻¹² para números CSV arredondados. |

Os controles finitos não demonstram otimalidade em todo simplex ou existência de todas as leis Borel. Essas afirmações receberam os argumentos analíticos descritos acima. Não foram executados Lean, geradores de figuras, compilação do manuscrito ou auditoria visual nesta revisão; não houve certificação mecânica integral de estratégias. Não testei uma classe de equilíbrios diferente da autorizada, todas as possíveis seleções do baseline histórico ou uma interpretação de endpoints mais ampla que a contratada.

**Findings A-xxx:** nenhum candidato científico adicional foi identificado. **Questão interpretativa QI-05:** a precisão expositiva indicada basta; não é necessária alteração de primitivas, domínio, estratégia ou payoff. Qualquer edição das notas cria novos bytes e exige o tratamento de revisão correspondente. Este PASS permanece ligado exclusivamente aos hashes e ao contrato registrados na seção 1.
