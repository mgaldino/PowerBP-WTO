# Leitura independente de compreensão por impacto — derivações v2

Leitor: `/root/provenance_inventory`. Data: 19/09/2026. Esta é uma reconstrução interpretativa anterior ao gate científico v2. Não emite PASS/FAIL das provas, não adjudica findings e não transfere o parecer científico v1 aos bytes novos. Não li o parecer formal de outro agente. As referências a F-001/F-002/F-003 abaixo identificam o escopo declarado nas fontes candidatas; não dependem da leitura dos pareceres ou da adjudicação.

## Objeto congelado e reaproveitamento comprovado

O manifesto `reviews/derivation_candidate_v2.json` tem SHA-256 `8f6603ff00050b6870995d4d893eeeb2bdffe13e0a90304b19b3574de8b7e9f1`. Conferi todos os dez itens de `files`, não apenas as cinco notas. O bundle `derivations/derivation_bundle_v2.md`, com 1.021 linhas, tem SHA-256 `3b8043d49de9011a60c1e7e079b4fbf876f35239d100dad82a0072b53a19b4e2`. Cada nota aparece nele uma única vez com bytes idênticos ao arquivo indicado. Não abri um preview de manuscrito nesta leitura.

| Nota v2 | SHA-256 | Operação de leitura |
|---|---|---|
| `derivations/v2/game_contract.md` | `ac78634ea0da03b422a6d92930680d1bb1f94deee0d3c33b68dc9d9791a7d058` | Identidade byte a byte com v1; cobertura de compreensão preservada. Bundle:8–110. |
| `derivations/v2/r2_interface.md` | `c83cf10483bf42e750e131a0792eedde60ae0eed244822c84ea2a1be285dd8a7` | Identidade byte a byte com v1; cobertura de compreensão preservada. Bundle:117–189. |
| `derivations/v2/r1_interface.md` | `a07a14a115de877411319568a2982e6b5e6e6a8d03c550ead82a6e7078b487e0` | Identidade byte a byte com v1; cobertura de compreensão preservada. Bundle:196–399. |
| `derivations/v2/agenda_transport.md` | `223d70575f64ca60b8807ab6e0bff5fec8819328a8a4d91fc10f22825f3f6c04` | Diff integral contra v1; leitura dos quatro blocos alterados e seu contexto. O restante tem igualdade comprovada pelo diff. Bundle:406–907. |
| `derivations/v2/unanimity_support_lemma.md` | `1491acd877ae5d3ca4eda2c6c9cacd10bffe9221fe52964f11cd7d962d5068ef` | Texto novo de 106 linhas, lido integralmente. Bundle:914–1019. |

A leitura anterior reaproveitada é `argument_contract/derivations_v1/independent_section_read.md`, SHA-256 `991663cef8090ce773865c7b81123f0a19be3a850eddd096155b14a7507c3b29`, vinculada ao bundle v1 `b62a7c8e023568bf408c1b8929b5909b4e7af21c3271c95955970237801b799f`. O contrato v1 `a49fc5f5d1737b7d8661506b6e384b709314a98798cacd33e4d981ffb5b07c36` é fonte dos IDs e das reconciliações interpretativas, não certificação da v2.

A decisão autoral continua no hash `7abfa53814ff23c61a9af2049c975be81e44f8e66270c4fa3f99accd51923726`. As instruções AGENTS atuais registram o protocolo de coalizão adotado em 19/9. O manuscrito histórico referido nas notas continua sendo a fonte `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`; o novo lema não declara alterar esse arquivo por si mesmo.

## Tese reconstruída e alcance

As notas procuram fechar a variante em que o proponente escolhe um contrato público (C,x), somente membros podem ter parcelas positivas e todos os convidados precisam consentir. A comparação institucional varia a quota mínima para a coalizão, preservando a mesma economia e o protocolo. Essa arquitetura é usada para definir payoffs também após desvios e para impedir recebimento simultâneo de parcela positiva e opção externa por H. O baseline majoritário é rederivado; seu resultado econômico pode coincidir com o histórico enquanto suas histórias e propostas diferem. Na agenda, H propõe e C é parte do sinal, exigindo um novo espaço de leis e desvios. A unanimidade admite o mapa estrutural C=N; a v2 acrescenta uma obrigação explícita de prova para um resultado histórico transportado.

O texto não apresenta novos fundamentos, quotas, tipos, descontos, seleção de continuações, funções de payoff ou células econômicas. A mudança declarada é de demonstração e precisão de quantificadores. Isso é uma descrição da intenção e do enunciado, não um julgamento de suficiência dos reparos.

## Diff interpretativo v1 → v2

| Bloco | Localizador v2 | Mudança de leitura e dependências |
|---|---|---|
| Proveniência da candidata | `agenda_transport.md`:5 | Novo parágrafo delimita F-001/F-002/F-003 e distingue os 409 checks históricos v1 dos novos checks algébricos. Não declara revisão independente concluída. |
| A-C5, ramo público de inclusão | `agenda_transport.md`:211–221 | Substitui a identidade fatorada histórica por uma decomposição e um limite estrito. O consumidor é a comparação acordo/recusa que sustenta o benchmark público. |
| Endpoint de A-C7 | `agenda_transport.md`:304 | Explicita σ_o(argmax u_o)=1, distingue igualdade quase certa de desigualdade em todo suporte e rejeita a contenção topológica como requisito. |
| Transporte U | `agenda_transport.md`:373–375 | Acrescenta dependência no novo lema, abrangendo as duas invocações de x^h em B.8, tanto com massa positiva quanto nula no posterior zero. |
| Lema US-1 | `unanimity_support_lemma.md`:1–106 | Nova demonstração candidata para leis Borel, incluindo x^h em suporte com massa zero. Consome a primeira redução de B.8, não a reprova integralmente. |

Na álgebra de A-C5, a v2 afirma

\[
1-k\beta(1-\beta o)/m-\beta^2o
=1-k\beta/m-\beta^2o(1-k/m)>1-\beta>0,
\]

e identifica a diferença para 1−β como β(1−k/m)(1−βo), usando k<m, β∈(0,1) e o∈(0,1). O local de consumo continua sendo o ramo o≤1/m da comparação pública. A candidata não muda a expressão da proposta ótima, o cutoff de inclusão ou o cutoff de atraso. A legitimidade da identidade e do argumento será objeto da revisão científica posterior.

## Mapa dos claims e suas dependências

Os 17 claims do contrato v1 continuam sendo a estrutura apropriada de leitura. Não interpreto o novo lema como uma nova hipótese para recuperar um resultado; ele se apresenta como uma prova auxiliar para uma conclusão já transportada. O macro pode manter um ID auxiliar US-1 para rastrear essa obrigação.

| Claim(s) | Compreensão preservada ou impacto v2 |
|---|---|
| C02, N01, N02 | Primitivas, factibilidade, payoffs completos e conceito baseline não mudam. H fora de C não vota; H convidado que recusa veta o contrato inteiro. Suporte inicial não é redefinido pelo posterior corrente. |
| C06 | R2 permanece nativa, com multiplicidade nominal M e corte p* em U; nenhuma alteração de fonte. |
| C07 | R1_M conserva respostas completas, E/S/P, cutoffs e desempate E/P; não há nova forma proposta. |
| N03 | A agenda continua consumindo os representantes anônimos completos, com parceiros uniformes e λ comum. Não são todos os assessments históricos possíveis. |
| C08 | R1_U mantém endpoint baixo, vazio em 0<μ≤p* e região alta. QI-01 continua delimitando os endpoints como jogos de entrada degenerada selecionados pela agenda. |
| C05 | Preservação de benchmarks e vetores privados do baseline continua econômica, sem equivalência literal M. |
| N04 | Sinais de A são pares (C,x), com topologia por componente; Bayes local em cada ponto do suporte e μ_off único fora dele. |
| N05 | Consentimento, piso, garantia e minimalidade quase certa permanecem nos bytes inalterados da nota. Coalizões maiores rejeitadas não são apagadas. |
| C12 | A fórmula pública continua a mesma, mas sua demonstração local A-C5 passa pela álgebra revisada. |
| N06 | A tabela pura e A-C7 mantêm enunciados; F-003 torna explícito o quantificador endpoint que o contrato v1 já fixava. |
| N07 | Dois exemplos de não equivalência M e a testemunha de reversão na mesma fibra permanecem inalterados. |
| N08 | O isomorfismo U continua condicional à correção dos resultados históricos. US-1 passa a fechar explicitamente uma dependência de B.8 para suporte Borel arbitrário. |
| N09 | Leis completas, órbita diagonal e fatorização por nomes mantêm seus domínios e limites. O novo lema não transforma assinatura realizada em código de todo off-path. |
| C15 | O limite suficiente βh<e/m mantém forma e requisito de existência. Usa a garantia M e apenas o teto global V_U≤z_H, enunciado/justificado antes de US-1 (lema:26–33); não depende da conclusão de US-1. |
| C17 | IR/D/I/T/Q, uma aplicação de β e propagação de vazios permanecem. Os consumidores U relacionados a B.8/E.3 e os consumidores públicos de A-C5 recebem as novas dependências de prova. |

A cadeia de impacto é, portanto, `R2_U → R1_U → disciplina da agenda + primeira redução de B.8 → US-1 → duas aplicações em B.8 → E.3 → consumidores das imagens U`. O teto global U e seu consumidor C15 têm argumento separado e não consomem a conclusão de US-1. Separadamente, `interface pública baseline → diferença acordo/recusa corrigida em A-C5 → v_M^A → gap público e D`. F-003 incide na linguagem da caracterização de leis em endpoints; não altera a seleção χ, os kernels ou os valores max{A_p,d_o,p}.

## Leitura do novo lema US-1

O domínio declarado é unanimidade, prior interior 0<p<1, tipos 0<ℓ<h<1 e β∈(0,1). C=N é constante e o espaço é o simplex compacto X. Os posteriores admitidos na continuação são P_C={0}∪(p*,1], com p*=(h−ℓ)/(1−ℓ)>0. As leis σ_ℓ e σ_h são Borel, a lei pública é sua mistura pelo prior e S é seu suporte topológico. A existência do limite local de Bayes é exigida em cada ponto de S, inclusive pontos de massa zero. Fora dele há uma crença única admissível μ_off.

O lema consome explicitamente a conclusão V_ℓ=V_h=V da primeira redução de B.8, a otimalidade quase certa dos sinais usados e a ausência de desvios em todo X. Registra os limites d≤V≤z_H, com d=β²h, z_H=1−β+β²h e x^h=(z_H,r_U(h),…,r_U(h)). Não começa de payoffs arbitrários ou de um mero par de leis sem restrições de incentivo.

A etapa US2 pretende identificar o posterior quase certamente com a derivada de Radon–Nikodym de pσ_h em relação a \barσ. Usa diferenciação por bolas após extensão das medidas por zero ao ambiente euclidiano e obtém pσ_h(E)=∫_E μ d\barσ para todo Borel E. O enunciado admite leis sem densidade de Lebesgue e sem átomos. A exigência pointwise do contrato continua distinta da identidade quase certa.

US-1 afirma: se μ_off>p*, então V=z_H e ambas as leis são δ_(x^h), logo μ(x^h)=p>p*. O argumento anunciado supõe V<z_H, usa continuidade da coordenada x_H para construir uma vizinhança de x^h com x_H>V e separa x^h fora ou dentro de S. Dentro de S, elimina massa local em μ=0 por Bayes para o alto e pela igualdade quase certa de payoff para o baixo. As médias locais ficam estritamente acima de p*, mas o limite é concluído primeiro como ≥p*. A estriteza final é atribuída à admissibilidade P_C, que exclui 0 e p* nesse caso. O desvio em x^h, inclusive se de massa zero, encerra a contradição. A igualdade V=z_H e a soma das parcelas identificam a proposta única.

As duas aplicações declaradas são distintas: quando λ_0=\barσ({μ=0})>0, os limites anteriores V≤z_L contradizem US-1 sob μ_off alto; quando λ_0=0, US-1 determina diretamente δ_(x^h). As passagens históricas localizadas são Rmd:1889–1893 e 1938–1943, sob hash 6708eaaf…. O lema não afirma demonstrar a primeira redução de B.8, a família μ_off=0 inteira, os endpoints do prior ou todos os demais teoremas do apêndice.

## F-003, domínios e não-afirmações

O endpoint de A-C7 agora diz literalmente “atribua probabilidade um ao argmax” e escreve σ_o(argmax u_o)=1. Um ponto de suporte de massa zero precisa satisfazer u_o(y)≤V_o, mas não precisa satisfazer igualdade. A fonte nega explicitamente supp(σ_o)⊆argmax u_o como requisito. Portanto não leio um novo refinamento que exija ótimo em todo limite de sinais sorteados. Esta formulação também mantém a estratégia e o payoff do tipo de probabilidade zero.

Continuam fora dos claims: equivalência literal global dos jogos majoritários; identificação do sinal completo por x em propostas rejeitadas; eliminação de coalizões maiores do espaço; igualdade de payoff em todo suporte; existência para qualquer ρ; transporte automático de correção científica por isomorfismo; reclassificação de todo histórico com posterior degenerado como jogo de prior degenerado; mistura de coordenadas de binders diferentes; certificação de manuscrito ou figuras.

## Evidência mecânica desta leitura e dúvidas

Conferi hashes, contagem de linhas, incorporação exata das cinco notas no bundle, igualdade das três notas reaproveitadas e diff integral da agenda. Li o script dos novos checks e os campos de escopo/resumo de sua saída: eles declaram 870 casos e 4.353 verificações algébricas aprovadas, zero falhas, exclusivamente para F-001. Não os executei nesta fase e não li os milhares de registros individuais como se fossem prova do lema de medidas. Os 409 checks originais são declaradamente um registro v1 mantido, não uma nova execução v2.

Não identifiquei dúvida de significado nova que impeça o macro de montar o contrato. As condições de US-1, sua dependência na primeira redução de B.8, a distinção limite ≥p*/admissibilidade >p*, QI-01 e o sentido probabilístico de F-003 devem permanecer explícitos no contrato. A validade das provas e a suficiência dos reparos ficam para a revisão científica após o gate. O preview do manuscrito terá leitura e registro separados, ligados a seus próprios hashes.
