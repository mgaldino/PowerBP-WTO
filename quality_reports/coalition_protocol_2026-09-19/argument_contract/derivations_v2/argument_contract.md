# Argument contract — derivações v2

## 1. Source-bound identity

**Contract ID:** `coalition-derivations-v2:3b8043d49de9:round2`. **SHA-256:** `3b8043d49de9011a60c1e7e079b4fbf876f35239d100dad82a0072b53a19b4e2`.
Artefato: [derivation_bundle_v2.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v2.md). Manifesto: `8f6603ff00050b6870995d4d893eeeb2bdffe13e0a90304b19b3574de8b7e9f1`. Revalidação: [revalidation.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v2/revalidation.md).

## 2. Document profile

1.021 linhas e 10.648 palavras brutas por whitespace. Cinco notas, subdivididas em onze unidades contíguas; sem PDF.
Macro e leitor independente não implementaram as notas; reaproveitaram leituras v1 com igualdade comprovada e leram alterações/consumidores e US-1. O macro fez também parecer formal v1 separado; este record continua interpretativo.

## 3. Thesis, question, and contribution

A variante autorizada de contrato de coalizão fecha payoffs por factibilidade e consentimento, rederiva a redução econômica do baseline majoritário, preserva U por um mapa estrutural declarado e exige uma nova agenda majoritária no espaço público (C,x), sem alegar equivalência literal global com o jogo histórico.

Quais resultados e objetos do modelo original permanecem, mudam ou exigem derivação própria quando todos os convidados devem consentir e somente membros de C podem receber alocações?

Estas notas são uma candidata matemática fora do manuscrito. Sua contribuição interna é uma arquitetura de payoffs completos, interfaces nativas R2/R1, representantes e kernels de continuação e uma caracterização da agenda que separa fórmulas econômicas preservadas de sinais/leis alterados. A leitura delimita as alegações para a revisão formal e adversarial; não julga a validade das demonstrações.

## 4. Core claims

| ID | Claim | Força |
|---|---|---|
| C02 | Mantêm-se H único informado, m≥3 fracos simétricos, dois tipos 0<ℓ<h<1, p∈[0,1], β∈(0,1), pie fixa em 1 e opção externa privada fora da pie, independente de acordos dos fracos. | primitivas preservadas |
| N01 | O proponente escolhe (C,x), pertence a C, a coalizão alcança q_M=k+1 ou q_U=m+1 e x_j=0 fora de C. Todos os convidados devem consentir; qualquer recusa faz o pacote inteiro fracassar. Na aprovação H membro recebe x_H; H excluído recebe o. A ausência de acúmulo vale em todas as histórias factíveis, incluindo desvios. | nova arquitetura e claim estrutural |
| N02 | O baseline mantém PBE com votos puros, fracos as-if-pivotal, T^Y e desempate do proponente; as ações desinformadas (C,x) e votos fracos não atualizam crenças. Se H não é convidado não vota. Com H convidado, Bayes e valores livres locais dependem de seu voto e respeitam o suporte original. | conceito de solução e estado suficientes declarados |
| C06 | R2 tem unidades nativas sem β: maioria admite toda coalizão vencedora só de fracos que contém i, com x=e_i, dando H=(ℓ,h) e cada fraco 1/m antes do reconhecimento. Em unanimidade C=N; oferta ℓ para μ≤p* e h para μ>p*, p*=(h−ℓ)/(1−ℓ); empate seleciona ℓ. | folhas terminais e correspondência de propostas declaradas |
| C07 | Em R1_M, fracos convidados aceitam iff x_j≥β/m; H convidado usa x_H≥βo quando todos os fracos aceitam, e Y se um veto fraco prescrito torna ambos os votos equivalentes. Propostas ótimas reduzem-se a E/S/P, com os mesmos valores, cutoffs e desempates econômicos do baseline original. | redução de propostas e seleção completa declaradas |
| N03 | A agenda consome representantes anônimos específicos de R1/R2: reconhecimento e parceiros uniformes, estados E/S/P/EP e mesmo peso λ nas misturas, com coalizões, votos efetivos e histórias terminais retidos. Seus valores c_χ e h_χ não esgotam o assessment. | restrição de seleção e interface literal |
| C08 | Em R1_U, a correspondência mantém o endpoint baixo, vazio para 0<μ≤p*, e pooling acima de p*. Vetor nativo de H: (βℓ,βh) no endpoint baixo e (βh,βh) acima de p*. O texto fornece respostas completas e um argumento de inexistência por proposta desviada. | caracterização unânime declarada |
| C05 | O benchmark público R1 permanece v_M(o)=βo se o≤1/m e o se o>1/m; v_U(o)=βo. Os vetores privados S/P/E e as diferenças econômicas do baseline preservam suas fórmulas, células vazias e segmentos vinculados. | preservação de payoff explicitamente delimitada |
| N04 | Em A, H propõe obrigatoriamente sinais públicos y=(C,x) em Y_g, união disjunta finita dos simplexes X_C. Bayes pointwise usa o par observado em todo suporte; um único μ_off vale fora. A continuação completa é selecionada por regra/estágio/posterior, com a disciplina interna própria do baseline. | novo espaço de ações/sinais e hipótese de continuação |
| N05 | Com o representante declarado, convidado fraco aceita iff x_j≥r_χ(μ). A posterior fixado, melhor passagem paga r a k convidados. O piso w(1−w)≤r≤w implica V_M^A≥max{1−kw,β²o}; toda passagem usada em equilíbrio tem exatamente k convidados fracos quase certamente. | novos argumentos locais e limites |
| C12 | As fórmulas públicas da agenda, o cutoff o_M*, gap público e D_g mantêm-se sob a nova interface: v_U^A=1−β+β²o e v_M^A igual aos dois ramos históricos. | benchmark público preservado condicional à interface |
| N06 | A-C6 caracteriza condições de payoff/existência das formas puras M no novo espaço; A-C7 caracteriza binders Borel por ausência de desvio no suporte, igualdade de payoff σ_o-quase certamente e proteção contra todo y fora do suporte. Há existência M para algum ρ em cada economia da interface. | caracterização funcional declarada |
| N07 | Dois exemplos impedem equivalência literal majoritária: o mesmo x pode separar tipos apenas por C e induzir passagem/recusa diferentes; um pacote histórico com pequena parcela a fraco dispensável pode não passar em qualquer C nova factível. Uma testemunha distinta reproduz a tabela de reversão na mesma fibra ρ=0. | contraexemplos e testemunha construtiva declarados |
| N08 | Adicionar/remover C=N é isomorfismo estrutural de todo o jogo U. O transporte depende da correção histórica; v2 acrescenta US-1: sob prior interior e μ_off>p*, todo assessment admissível com as premissas declaradas tem V=z_H e ambas as leis δ_xh, inclusive quando x^h poderia ser ponto de suporte de massa zero. As duas aplicações de B.8 são explicitamente cobertas. | isomorfismo estrutural e lema auxiliar declarado; validade científica ainda não decidida por este gate |
| N09 | Kernels e leis realizadas novos retêm (C,x), não convite ⊥ e histórias da continuação. Sig_ex é órbita diagonal do par de leis por tipo e Sum_econ quocienta registros por nomes; a construção e fatoração são refeitas no novo espaço. | representação no espaço novo, condicional aos kernels |
| C15 | A região suficiente βh<e/m de vantagem majoritária para ambos os tipos e ex ante permanece, usando o novo limite inferior M e o limite superior U transportado, quando ambas as correspondências existem. | preservação de bound, não equivalência global |
| C17 | IR,D,I,T,Q mantêm suas definições e datas, com uma conversão β da R1 para A; T=D+I é identidade quando as fontes existem. As imagens majoritárias devem ser produzidas pela correspondência nova, e vazios continuam propagando-se. | identidades preservadas com novas fontes |

## 5. Claim → evidence → scope map

| ID | Fonte | Evidência | Escopo |
|---|---|---|---|
| C02 | B:14–43 | Contrato de jogadores, informação, reconhecimento e payoffs. | Não há produtividade de H ou atividade individual posterior para receber x_H. |
| N01 | B:14–43,73–84 | Tabela de transições e argumento por casos de participação/consentimento/factibilidade. | Não é cancelamento após aprovação, devolução ao proponente, resultado apenas de otimalidade ou equivalência ao ballot majoritário histórico. |
| N02 | B:45–71,86–110,203–216,320–381 | Regras de crenças/ballots e manutenção do estado (belief,support) para payoffs e do histórico para assessment completo. | μ atual e suporte inicial não são confundidos. Os endpoints R1_U descritos são jogos com prior de entrada degenerado e a agenda seleciona esses assessments específicos. |
| C06 | B:123–189 | Derivação local de ballots, redução do simplex e desempate; leitura fria R2 independente. | Valores econômicos preservados, mas R2_M conserva multiplicidade de C, inclusive superdimensionados, e crenças fora do caminho. β entra só no consumidor R1. |
| C07 | B:203–281 | Dominância do fracasso certo, remoção pré-ballot de convidado excedente e redução a preços limiares; tabela E/S/P. | A redução cobre otimização antes da votação; não cancela parcela depois. Segue multiplicidade de identidades, kernels R2 e peso comum no residual. |
| N03 | B:283–318,470–502,817–821 | Construção explícita do representante e tabela c/h; Borelidade alegada dos kernels e respostas fora do caminho. | Não é classificação de todas as seleções dependentes da história do baseline. Alterar kernel mantendo c/h pode alterar leis/assinaturas. |
| C08 | B:320–381 | Isomorfismo C=N, regiões de ballots e s† que impede fechamento em votos puros. | Endpoints referem-se ao suporte de entrada declarado; a cláusula não classifica todos os históricos μ=0/1 com suporte original interior. Inexistência é da classe mantida. |
| C05 | B:383–399 | Comparação dos custos de inclusão/exclusão e tradução componente a componente dos vetores. | Não preserva identidade nominal de coalizões, vetores de ballot, todas as estratégias/desvios ou o jogo de sinalização da agenda. |
| N04 | B:425–502 | Definição A1, topologia por componentes C, Bayes A2, tabela de transições e interface A3. | Não projeta x antes de atualizar crenças, não adiciona voto de H em A, não permite H fora de C ou pular A, nem impõe o Markov da agenda ao baseline inteiro. |
| N05 | B:504–599 | A-C1–A-C4: produto de consentimentos, custo por convidado, identidade do piso e garantia independente de crença. | C é recuperável de x só no ramo que passa. Coalizões maiores continuam factíveis, sobretudo rejeitadas; massa zero no suporte não é tratada como argmax obrigatório. Melhor proposta a μ fixado não resolve sozinha desvios de sinalização. |
| C12 | B:600–628 | A-C5 com decomposição corrigida e margem β(1−k/m)(1−βo)>0; fórmulas e domínios declarados inalterados. | Propostas majoritárias rejeitadas incluem C e não são literalmente as antigas, mesmo quando o payoff coincide. |
| N06 | B:630–709 | Tabela de seis formas, construções de existência, u_o(C,x), supremo fora do suporte e condições A14. | Não é catálogo finito de estratégias nem bijeção com medidas históricas em X. Não garante existência em todo ρ fixado. Suporte inclui pontos de massa zero, onde há desigualdade, não igualdade obrigatória. A frase endpoint B:709 explicita σ_o(argmax u_o)=1 e nega contenção do suporte topológico no argmax. |
| N07 | B:711–767 | A-EX1, A-EX2 e par explícito M/U para (4,.9,.1,.9,.95). | Não diz que o vetor de payoffs do primeiro exemplo era impossível em toda estratégia antiga. A testemunha não seleciona toda a correspondência nem prova igualdade global das imagens de payoff. |
| N08 | B:320–326,769–779,914–1019 | A-C8 preserva a árvore U; US1–US6 e US-1 acrescentam argumento de suporte, Bayes em bolas e aplicações a λ_0>0 e λ_0=0. | US-1 consome o valor comum da primeira redução de B.8 e disciplina de melhores respostas/limites. Não revalida por si só toda a prova histórica; não se estende a M ou a endpoints de prior. |
| N09 | B:781–853 | A15–A18, ação finita S_m, lei de órbita e argumento de fatoração Borel. | Não identifica assinaturas antigas e novas, não codifica todo plano off-path, não recombina binders e não cria common random draw entre regras. |
| C15 | B:593–597,855–875 | A-C4, A-C8 e linha de consequências: ΔV≤−β(e/m−βh). | Exige ambas as fontes; fora da região não dá ranking universal nem igualdade de conjuntos antigos/novos. Seu teto global U é premissa/argumento anterior a US-1 (B:939–946); a conclusão de US-1 não é necessária a este bound. |
| C17 | B:855–875,877–907 | Tabela de impacto, limites de verificação e ledger de dependências. | Mesmas fórmulas não certificam transporte de outcomes. Os 409 checks reportados são finitos/condicionais; revisão científica independente permanece pendente. |

## 6. Profile-specific contract

**players**

B:14–24,425–427. H único informado e m≥3 fracos; N={H}∪W. Baseline reconhece um fraco uniformemente, independente com reposição; A acrescenta H como proponente obrigatório.

**timing**

B:26–43,447–454. Proposta pública (C,x), votos simultâneos apenas dos convidados, proponente sim; todo convidado consente ou o pacote inteiro falha. Aprovação implementa automaticamente; falha R1→R2 com β, falha R2→desacordo nativo. Em A, falha→R1 com um β. Não convidado não vota; ⊥ é marcador, não ação. H não exerce o imediatamente se há continuação.

**information**

B:45–71,86–96,445–468. Só H observa o. No baseline (C,x) desinformado e votos fracos preservam crença; H convidado informa por sua ação, Bayes positivo ou valor livre local no suporte original. Na agenda o par (C,x) é sinal; suporte na união disjunta Y, Bayes local em todo ponto, μ_off único fora; endpoints e suporte de entrada conforme Q01.

**actions_strategies**

B:20–24,75–84,203–254,429–454,668–709. C contém proponente e alcança quota; x≥0, Σx≤1, x fora de C zero. Toda coalizão factível permanece no espaço. Votos puros; propostas podem ser loterias/Borel, com vínculo dos pesos. H∈C é necessário em A. C maior só é removido por argumento de otimalidade onde explicitamente demonstrado, nunca pela factibilidade.

**equilibrium_concept**

B:45–71,456–502,694–709. PBE com fracos as-if-pivotal e sim na indiferença; H otimiza por tipo, usando T^Y. Desempate do proponente minimiza payoff esperado de H entre máximos próprios. Agenda usa seleção completa pública/anônima/Markov por instituição, estágio e posterior, com crença única fora do suporte. As restrições da agenda não são impostas às crenças internas de todo baseline.

**assumptions**

- m≥3, 0<ℓ<h<1, β∈(0,1), pie fixa em 1, fracos com outside zero e nenhum informado adicional. B:14–43.
- o de H está fora da pie e permanece mesmo quando acordo entre fracos passa sem H. Não há execução individual nem benefício extra de aprovação. B:35–43.
- A restrição x fora de C zero e consentimento de todos são decisão substantiva de 19/09; não são consequência da racionalidade ou correção editorial. B:73–84.
- A agenda consome os representantes completos uniformes de R1/R2 declarados e hashed. Igualdade de c/h não basta para transportar kernels. B:283–318,470–502,781–853.
- Os endpoints explícitos R1_U são jogos de continuação de prior de entrada degenerado, selecionados como tais pela agenda; dentro do mesmo baseline, crença livre continua vinculada ao suporte do prior inicial. B:336–346,379–381; confirmação do implementador registrada em Q01.
- Resultados transportados por U dependem da correção dos resultados históricos; claims vazios permanecem restritos à classe de votos puros. B:769–777.
- Toda comparação requer suas fontes não vazias, mesma economia/especificação e datas compatíveis. B:855–875.
- US-1 usa leis Borel arbitrárias no simplex, limite local existente em todo suporte, μ∈{0}∪(p*,1], ausência de desvios pointwise e igualdade quase certa de payoff. A identidade de Bayes por diferenciação é argumento, não nova hipótese de densidade. B:920–964.

**propositions**

- N01 (B:73–84): não acumulação em todo histórico factível por participação/consentimento e alocação zero fora de C.
- R2 (B:123–189): M todos os ótimos têm C⊆W, x=e_i; U ofertas ℓ/h com corte p* e empate em ℓ; valores nativos H=(ℓ,h) ou (h,h), fracos 1/m em M e c2_U correspondente em U.
- R1_M (B:203–318): w=β/m; Π_E=1−kw, Π_S=(1−μ)[1−(k−1)w−βℓ]+μw, Π_P=1−(k−1)w−βh. Mesmos cutoffs e desempates que C07 original, nova prova e novos records de coalizão.
- R1_U (B:320–381): C=N; endpoint baixo e pooling alto; vazio para 0<μ≤p*. Região de respostas e s† são explicitadas; aplicação endpoint estreita conforme Q01.
- A-C1/A-C2 (B:506–529): regra de produto sobre convidados; com r>0, passagem determina C por parcelas fracas positivas. Não é identidade global de sinais.
- A-C3/A-C4 (B:531–599): a_pass=1−kr a μ fixado, piso w(1−w)≤r≤w; V_M≥max{1−kw,β²o}; passagem usada com exatamente k convidados fracos, quase certamente.
- A-C5 (B:602–628): v_U^A=1−β+β²o; v_M^A=1−kβ(1−βo)/m para o≤1/m e max{1−kβ/m,βo} acima.
- A-C6 (B:630–666): seis formas puras; pooling acordo/recusa, separação ambos acordam, baixo acorda/alto recusa, ambos recusam; baixo recusa/alto acorda impossível. Tabela caracteriza payoffs e existência, deixando variar sinais completos. Existência para algum ρ.
- A-C7 (B:668–709): u_o(y)≤V_o em todo suporte; u_o=V_o σ_o-q.c.; V_o≥sup de desvios fora do suporte. Endpoint: qualquer lei que atribua probabilidade um ao argmax de u_o em Y_M, retendo tipo sem probabilidade; não se exige suporte topológico contido no argmax (QI-05).
- A-EX1/A-EX2 (B:711–739): não equivalência literal M em sinais/outcomes; B:741–767 preserva uma testemunha de reversão na mesma fibra ρ=0.
- A-C8 (B:769–777): C=N é isomorfismo estrutural U, sem recertificar provas históricas.
- A15–A18 (B:781–853): novas leis Γ com Y_g e kernels completos; órbita diagonal e resumo por quociente, condicionados à Borelidade/equivariância importadas.
- Consequências (B:855–875): bound βh<e/m e identidades IR/D/I/T/Q preservam seus enunciados delimitados, consumindo fontes novas; não equivalência global de correspondências M.
- US-1 (B:966–1019): sob prior interior, μ_off>p*, valor comum V e demais premissas B:920–946, V=z_H e ambas as leis δ_xh; usa US2 para x^h dentro ou fora do suporte e aplica-se às duas invocações históricas.

**mechanisms**

B:73–84,203–281,412–421,711–777. A nova arquitetura torna impossível pagar parcela positiva a H excluído e impede aprovação após recusa de H convidado; aprovação implementa todo o contrato. A margem extensiva do único informado continua em maioria. No baseline, proposta é desinformada; na agenda, identidade C é informação observável e pode separar tipos mesmo quando x coincide. O isomorfismo U deriva da constância C=N, enquanto M exige nova caracterização.

**comparative_statics**

B:256–281,383–399,600–666,741–767,855–875. Preservam-se os cortes de preço 1/m, p*, t_SE/t_SP e o_M* nos objetos indicados; U−M mantém orientação. Renda=privado−público; T=D+I e Q composto respeitam datas. βh<e/m é suficiente com ambos os binders existentes. A tabela de reversão é um par específico; nenhuma igualdade global das correspondências majoritárias antigas e novas é alegada.

Inaplicáveis: {"treatment": "Não é estudo empírico; alterações são primitivas e comparações entre jogos.", "outcome": "Payoffs e leis são objetos formais, sem variável observacional estimada.", "estimands": "Não há estimando causal de dados; há correspondências, transportes e identidades contábeis.", "preferred_specification": "Inaplicável como especificação empírica. A especificação formal é a decisão de 19/09, conceito e interfaces registradas.", "empirical_identification": "Nenhuma identificação causal da OMC ou de preferências históricas é feita nas notas.", "empirical_inference": "Sem inferência estatística; checks finitos são controles computacionais condicionais."}

## 7. What the document does not claim

- Não afirma que o novo jogo majoritário seja equivalente ao antigo em estratégias, desvios, ballots, coalizões ou leis realizadas; A-EX1/A-EX2 integram positivamente a tese.
- Não preserva todo acordo histórico com o mesmo vetor x; pequena parcela a um fraco antes dispensável pode agora exigir seu consentimento.
- Não afirma que a projeção de (C,x) em x baste para Bayes; recuperação de C na passagem não se estende a propostas rejeitadas.
- Não resolve não acumulação por cancelamento após aprovação, repasse automático ou racionalidade somente no caminho; a arquitetura nova define todo ramo.
- Não exige execução individual ou contribuição produtiva de H. A implementação contratada é automática.
- Não remove coalizões superdimensionadas ou convidados com zero do espaço. R2_M conserva coalizões nominais ótimas maiores; recusas maiores da agenda podem sinalizar.
- Não usa o argumento a μ fixado como prova suficiente de otimização de sinais privados nem equipara desigualdade em todo suporte a igualdade em todo suporte.
- Não declara o representante anônimo da agenda como todos os assessments do baseline; χ/κ é uma restrição de continuação explícita.
- Não impõe o ρ único da agenda às crenças internas de todo baseline; não redefine suporte original após posterior degenerado.
- Não amplia R1_U μ=0/1 para todo histórico de suporte inicial interior. O endpoint da agenda é um assessment de continuação declarado.
- Não afirma existência de M em todo ρ fixado; não transforma A-C7 em enumeração finita de suportes.
- Não usa isomorfismo U como recertificação de B.4/B.8/E.3; argumentos históricos e seus desvios permanecem objeto de revisão.
- Não estende inexistência a votos mistos ou outro conceito de solução.
- Não identifica assinatura de leis realizadas com binder off-path completo; não cria sorteio comum entre instituições ou misturas de coordenadas de binders distintos.
- Não prova igualdade global de todas as imagens de payoff majoritárias antigas/novas. A tabela pura, bounds e exemplo têm claims mais estreitos.
- Não trata a testemunha de reversão como seleção universal, nem as identidades IR/D/I/T/Q como causalidade empírica.
- Não certifica scripts de patch de manuscrito, integração, figuras renderizadas, revisão científica ou submissão. Esses objetos não integram o bundle matemático.
- O gate de fidelidade não aprova ou refuta as provas nem adjudica a coincidência científica da folha fria com a interface candidata.
- A frase endpoint 'supported on its argmax' é contratada como probabilidade um no argmax; não se acrescenta hipótese de contenção topológica do suporte. A adjudicação científica dessa precisão permanece pendente.
- O novo lema não demonstra a primeira redução de B.8: consome seu valor comum, com incentivos quase certos e pointwise já estabelecidos.
- A conclusão de US-1 não é necessária ao teto global U nem ao bound C15; repara a classificação completa e suas imagens.
- v2 não reexecuta os 409 checks v1 nem atribui aos checks algébricos a validação do argumento de medidas.
- Este contrato não revalida o preview do manuscrito; ele terá fonte e contrato próprios.

## 8. Terminology

| Preferir | Evitar | Motivo |
|---|---|---|
| proposta (C,x) | x como sinal completo em A_M | C é pública e pode sinalizar o tipo; a projeção perde resultados distintos. |
| consentimento de todos os convidados | quota de votos no ballot atual | A quota define coalizões factíveis; qualquer convidado pode fazer o pacote inteiro fracassar. |
| não convidado / ⊥ | voto não fictício | Quem não pertence a C não toma ação de voto. |
| fórmula econômica preservada | equivalência de jogos majoritários | Payoffs iguais não identificam estratégias, crenças ou laws. |
| representante literal da continuação | payoff escalar escolhido livremente | Kernel, crenças, estratégias e identificação de coalizões permanecem vinculados. |
| endpoint com prior de entrada degenerado | qualquer histórico com posterior zero/um | Suporte original e posterior são distintos; a seleção de agenda é declarada. |
| quase certamente / ponto a ponto | todo ponto do suporte é argmax | A-C4 e A-C7 têm quantificadores diferentes e explícitos. |
| isomorfismo U, transporte condicional | prova histórica automaticamente aprovada | O mapa de jogos não estabelece a validade dos teoremas transportados. |
| binder completo / lei realizada | assinatura como código de todo off-path | A assinatura registra somente a órbita das leis realizadas. |
| candidata de implementação fechada | PASS científico, manuscrito final | O texto distingue fechamento, verificação finita, revisão e integração. |

## 9. Reconciliation log

**QI-01** — Não. São jogos baseline com prior de entrada degenerado. A agenda importa os assessments endpoint completos por sua seleção declarada; isso não altera o suporte original de um baseline de prior interior. No mesmo baseline, os valores livres de denominador zero respeitam seu prior inicial. O alcance é limitação/assunção mantida do transporte da agenda, não prova de consistência global diferente. Fontes: B:56–59,88–96,336–346,379–381; independent_section_read.md:139–147; Confirmação do implementador/coordenador /root, 19/09/2026.
**QI-02** — Não. As notas distinguem explicitamente implementação e revisão; M tem espaço novo e dois contraexemplos de equivalência literal. Igualdade de payoff não identifica sinais, avaliações ou laws. Fechamento e checks finitos não são pareceres independentes. Fontes: B:98–110,391–421,711–739,855–907; independent_section_read.md:24–30,110–137.
**QI-03** — Não. O mapa C=N afirma preservação estrutural; a validade dos resultados históricos permanece condição expressa. A revisão científica posterior deverá ler B.4, B.8 e E.3 do original exato, incluindo seus argumentos de desvios e suporte; o contrato não adjudica esses argumentos. Em v2 US-1 torna explícita uma nova obrigação de prova e suas duas aplicações; as demais dependências históricas permanecem. Fontes: B:421,769–777,865; M original:1532–1608,1831–1965,2362–2567; Pedido de cobertura do coordenador /root, 19/09/2026.
**QI-04** — Não. A-C4 tem conclusão quase certa sobre propostas aprovadas usadas em equilíbrio; convidados excedentes e recusas permanecem factíveis. A-C7 exige desigualdade em todo suporte, inclusive massa zero, e igualdade apenas σ_o-quase certamente. A-C3, a μ fixado, é distinta da otimização de sinais privados. Fontes: B:529,531–544,563–591,694–709; independent_section_read.md:93–100,113–120.
**QI-05** — v2 explicita probabilidade um no argmax e nega a inclusão de todo suporte topológico. A distinção já fixada interpretativamente em v1 permanece; a ciência dos reparos tem parecer separado. Fontes: B:694–709; independent_section_read.md: F-003, domínios e não-afirmações.
**QI-06** — Somente à classificação e suas imagens. O teto V_U≤z_H é anterior ao lema e usado como limite em US1; junto à garantia M sustenta C15 sem a conclusão US-1. O leitor independente confirmou e corrigiu apenas o mapa de dependências no record final. Fontes: B:939–946,968–1019; Leitura independente v2, linha C15 e cadeia de impacto; Confirmação /root/provenance_inventory em 19/09/2026.

Nenhuma ambiguidade interpretativa material não resolvida.

## 10. Gate verdict

**PASS de fidelidade**, condicionado aos bytes identificados; não é julgamento científico.
- Onze unidades cobrem 1.021 linhas; cobertura v1 reaproveitada somente com igualdade comprovada e fontes preservadas.
- Diff completo de agenda, nova nota US-1 e consumidores foram lidos pelo macro e pelo leitor independente; dez itens do manifesto e cinco payloads conferidos.
- Dezessete claims preservados, com US-1 auxiliar de N08, nova evidência C12 e quantificador N06 explícito.
- QI-06 delimita a dependência da classificação, preservando o teto global e C15; nenhuma ambiguidade interpretativa material remanesce.
- Revalidação substantive_scoped registrada em revalidation.md. PASS de fidelidade não é aprovação científica nem revalida o manuscrito.

Correção documental de 19/09/2026: o campo de escopo do JSON agora identifica as cinco notas e o bundle v2. O JSON anterior `15813af5fe6efbd53a840bebe7c072a5f6ec3b2738786743f2a4ee831ca92e2c` está preservado em `snapshots/15813af5/`. Não há mudança de conteúdo científico ou da conclusão deste gate.
