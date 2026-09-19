# 1. Source-bound identity

**Contrato:** `coalition-derivations-v1:b62a7c8e0235:round1`  
**SHA-256 do bundle:** `b62a7c8e023568bf408c1b8929b5909b4e7af21c3271c95955970237801b799f`  
**Objeto:** [derivation_bundle_v1.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md), notas matemáticas fora do manuscrito. **Perfil:** formal. **Estado:** PASS de fidelidade interpretativa; revisão científica pendente.

Os quatro fontes foram lidos integralmente e sua reprodução no bundle foi conferida:

| Fonte | Linhas no bundle | SHA-256 |
|---|---|---|
| [game_contract.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/game_contract.md) | B:8–110 | `ac78634ea0da03b422a6d92930680d1bb1f94deee0d3c33b68dc9d9791a7d058` |
| [r2_interface.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/r2_interface.md) | B:117–189 | `c83cf10483bf42e750e131a0792eedde60ae0eed244822c84ea2a1be285dd8a7` |
| [r1_interface.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/r1_interface.md) | B:196–399 | `a07a14a115de877411319568a2982e6b5e6e6a8d03c550ead82a6e7078b487e0` |
| [agenda_transport.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/agenda_transport.md) | B:406–901 | `3b98454cb275f34a89c6f5a10037eaa34e30e4fbf81e4fb4f01a65e2f8ba9f6f` |

B indica linhas inclusivas do bundle. M indica o original `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`. A autoridade é a [decisão autoral](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/author_decision.md), hash `7abfa53814ff23c61a9af2049c975be81e44f8e66270c4fa3f99accd51923726`. Scripts de patch não integram este objeto.

# 2. Document profile

903 linhas; 9.509 palavras brutas por whitespace, com matemática/metadata. Quatro fontes substantivas, subdivididas em dez unidades de leitura menores que 4.000 palavras. Nenhum PDF revisado. Línguas: inglês e português. O macro leu integralmente o bundle, a leitura independente e a reconstrução fria R2. Não implementou nenhuma das quatro notas. O leitor independente também leu o bundle integralmente; sua reconstrução R2 anterior usou primitivas, sem consultar as interfaces candidatas. A leitura atual não emite parecer matemático.

Registros: [leitura independente integral](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v1/independent_section_read.md), hash `991663cef8090ce773865c7b81123f0a19be3a850eddd096155b14a7507c3b29`; [folha fria R2](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/reviews/cold_r2_from_primitives.md), hash `57b83c8d83fad84f6f5ce41a6e34d75c60ede19b3e09c71d307bd7d70764896c`. O [mapa](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v1/section_map.md) liga unidades e leitores.

# 3. Thesis, question, and contribution

**Tese.** A variante autorizada de contrato de coalizão fecha payoffs por factibilidade e consentimento, rederiva a redução econômica do baseline majoritário, preserva U por um mapa estrutural declarado e exige uma nova agenda majoritária no espaço público (C,x), sem alegar equivalência literal global com o jogo histórico.

**Pergunta.** Quais resultados e objetos do modelo original permanecem, mudam ou exigem derivação própria quando todos os convidados devem consentir e somente membros de C podem receber alocações?

**Contribuição interna.** Estas notas são uma candidata matemática fora do manuscrito. Sua contribuição interna é uma arquitetura de payoffs completos, interfaces nativas R2/R1, representantes e kernels de continuação e uma caracterização da agenda que separa fórmulas econômicas preservadas de sinais/leis alterados. A leitura delimita as alegações para a revisão formal e adversarial; não julga a validade das demonstrações.

# 4. Core claims

- **C02.** Mantêm-se H único informado, m≥3 fracos simétricos, dois tipos 0<ℓ<h<1, p∈[0,1], β∈(0,1), pie fixa em 1 e opção externa privada fora da pie, independente de acordos dos fracos.
- **N01.** O proponente escolhe (C,x), pertence a C, a coalizão alcança q_M=k+1 ou q_U=m+1 e x_j=0 fora de C. Todos os convidados devem consentir; qualquer recusa faz o pacote inteiro fracassar. Na aprovação H membro recebe x_H; H excluído recebe o. A ausência de acúmulo vale em todas as histórias factíveis, incluindo desvios.
- **N02.** O baseline mantém PBE com votos puros, fracos as-if-pivotal, T^Y e desempate do proponente; as ações desinformadas (C,x) e votos fracos não atualizam crenças. Se H não é convidado não vota. Com H convidado, Bayes e valores livres locais dependem de seu voto e respeitam o suporte original.
- **C06.** R2 tem unidades nativas sem β: maioria admite toda coalizão vencedora só de fracos que contém i, com x=e_i, dando H=(ℓ,h) e cada fraco 1/m antes do reconhecimento. Em unanimidade C=N; oferta ℓ para μ≤p* e h para μ>p*, p*=(h−ℓ)/(1−ℓ); empate seleciona ℓ.
- **C07.** Em R1_M, fracos convidados aceitam iff x_j≥β/m; H convidado usa x_H≥βo quando todos os fracos aceitam, e Y se um veto fraco prescrito torna ambos os votos equivalentes. Propostas ótimas reduzem-se a E/S/P, com os mesmos valores, cutoffs e desempates econômicos do baseline original.
- **N03.** A agenda consome representantes anônimos específicos de R1/R2: reconhecimento e parceiros uniformes, estados E/S/P/EP e mesmo peso λ nas misturas, com coalizões, votos efetivos e histórias terminais retidos. Seus valores c_χ e h_χ não esgotam o assessment.
- **C08.** Em R1_U, a correspondência mantém o endpoint baixo, vazio para 0<μ≤p*, e pooling acima de p*. Vetor nativo de H: (βℓ,βh) no endpoint baixo e (βh,βh) acima de p*. O texto fornece respostas completas e um argumento de inexistência por proposta desviada.
- **C05.** O benchmark público R1 permanece v_M(o)=βo se o≤1/m e o se o>1/m; v_U(o)=βo. Os vetores privados S/P/E e as diferenças econômicas do baseline preservam suas fórmulas, células vazias e segmentos vinculados.
- **N04.** Em A, H propõe obrigatoriamente sinais públicos y=(C,x) em Y_g, união disjunta finita dos simplexes X_C. Bayes pointwise usa o par observado em todo suporte; um único μ_off vale fora. A continuação completa é selecionada por regra/estágio/posterior, com a disciplina interna própria do baseline.
- **N05.** Com o representante declarado, convidado fraco aceita iff x_j≥r_χ(μ). A posterior fixado, melhor passagem paga r a k convidados. O piso w(1−w)≤r≤w implica V_M^A≥max{1−kw,β²o}; toda passagem usada em equilíbrio tem exatamente k convidados fracos quase certamente.
- **C12.** As fórmulas públicas da agenda, o cutoff o_M*, gap público e D_g mantêm-se sob a nova interface: v_U^A=1−β+β²o e v_M^A igual aos dois ramos históricos.
- **N06.** A-C6 caracteriza condições de payoff/existência das formas puras M no novo espaço; A-C7 caracteriza binders Borel por ausência de desvio no suporte, igualdade de payoff σ_o-quase certamente e proteção contra todo y fora do suporte. Há existência M para algum ρ em cada economia da interface.
- **N07.** Dois exemplos impedem equivalência literal majoritária: o mesmo x pode separar tipos apenas por C e induzir passagem/recusa diferentes; um pacote histórico com pequena parcela a fraco dispensável pode não passar em qualquer C nova factível. Uma testemunha distinta reproduz a tabela de reversão na mesma fibra ρ=0.
- **N08.** Adicionar/remover C=N é apresentado como isomorfismo do jogo unânime inteiro, baseline e A, preservando histórias, estratégias, payoffs, suporte e Bayes local. O transporte de resultados históricos U depende da correção daqueles resultados.
- **N09.** Kernels e leis realizadas novos retêm (C,x), não convite ⊥ e histórias da continuação. Sig_ex é órbita diagonal do par de leis por tipo e Sum_econ quocienta registros por nomes; a construção e fatoração são refeitas no novo espaço.
- **C15.** A região suficiente βh<e/m de vantagem majoritária para ambos os tipos e ex ante permanece, usando o novo limite inferior M e o limite superior U transportado, quando ambas as correspondências existem.
- **C17.** IR,D,I,T,Q mantêm suas definições e datas, com uma conversão β da R1 para A; T=D+I é identidade quando as fontes existem. As imagens majoritárias devem ser produzidas pela correspondência nova, e vazios continuam propagando-se.

# 5. Claim → evidence → scope map

| Claim | Fonte | Evidência declarada | Alcance que restringe a revisão |
|---|---|---|---|
| C02 | [B:14–43](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:14) | Contrato de jogadores, informação, reconhecimento e payoffs. | Não há produtividade de H ou atividade individual posterior para receber x_H. |
| N01 | [B:14–43,73–84](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:14) | Tabela de transições e argumento por casos de participação/consentimento/factibilidade. | Não é cancelamento após aprovação, devolução ao proponente, resultado apenas de otimalidade ou equivalência ao ballot majoritário histórico. |
| N02 | [B:45–71,86–110,203–216,320–381](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:45) | Regras de crenças/ballots e manutenção do estado (belief,support) para payoffs e do histórico para assessment completo. | μ atual e suporte inicial não são confundidos. Os endpoints R1_U descritos são jogos com prior de entrada degenerado e a agenda seleciona esses assessments específicos. |
| C06 | [B:123–189](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:123) | Derivação local de ballots, redução do simplex e desempate; leitura fria R2 independente. | Valores econômicos preservados, mas R2_M conserva multiplicidade de C, inclusive superdimensionados, e crenças fora do caminho. β entra só no consumidor R1. |
| C07 | [B:203–281](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:203) | Dominância do fracasso certo, remoção pré-ballot de convidado excedente e redução a preços limiares; tabela E/S/P. | A redução cobre otimização antes da votação; não cancela parcela depois. Segue multiplicidade de identidades, kernels R2 e peso comum no residual. |
| N03 | [B:283–318,468–500,811–815](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:283) | Construção explícita do representante e tabela c/h; Borelidade alegada dos kernels e respostas fora do caminho. | Não é classificação de todas as seleções dependentes da história do baseline. Alterar kernel mantendo c/h pode alterar leis/assinaturas. |
| C08 | [B:320–381](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:320) | Isomorfismo C=N, regiões de ballots e s† que impede fechamento em votos puros. | Endpoints referem-se ao suporte de entrada declarado; a cláusula não classifica todos os históricos μ=0/1 com suporte original interior. Inexistência é da classe mantida. |
| C05 | [B:383–399](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:383) | Comparação dos custos de inclusão/exclusão e tradução componente a componente dos vetores. | Não preserva identidade nominal de coalizões, vetores de ballot, todas as estratégias/desvios ou o jogo de sinalização da agenda. |
| N04 | [B:423–500](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:423) | Definição A1, topologia por componentes C, Bayes A2, tabela de transições e interface A3. | Não projeta x antes de atualizar crenças, não adiciona voto de H em A, não permite H fora de C ou pular A, nem impõe o Markov da agenda ao baseline inteiro. |
| N05 | [B:502–597](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:502) | A-C1–A-C4: produto de consentimentos, custo por convidado, identidade do piso e garantia independente de crença. | C é recuperável de x só no ramo que passa. Coalizões maiores continuam factíveis, sobretudo rejeitadas; massa zero no suporte não é tratada como argmax obrigatório. Melhor proposta a μ fixado não resolve sozinha desvios de sinalização. |
| C12 | [B:598–624](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:598) | A-C5 compara a melhor passagem à continuação; a tabela de impactos aponta E.6–E.8/E.12. | Propostas majoritárias rejeitadas incluem C e não são literalmente as antigas, mesmo quando o payoff coincide. |
| N06 | [B:626–705](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:626) | Tabela de seis formas, construções de existência, u_o(C,x), supremo fora do suporte e condições A14. | Não é catálogo finito de estratégias nem bijeção com medidas históricas em X. Não garante existência em todo ρ fixado. Suporte inclui pontos de massa zero, onde há desigualdade, não igualdade obrigatória. |
| N07 | [B:707–763](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:707) | A-EX1, A-EX2 e par explícito M/U para (4,.9,.1,.9,.95). | Não diz que o vetor de payoffs do primeiro exemplo era impossível em toda estratégia antiga. A testemunha não seleciona toda a correspondência nem prova igualdade global das imagens de payoff. |
| N08 | [B:320–326,765–773](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:320) | A-C8 compara todas as ações, ballots, transições e informações; C=N é constante. | Não é nova prova da correção histórica de B.4/B.8; não se estende à maioria; continua a inexistência restrita aos votos puros. |
| N09 | [B:775–847](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:775) | A15–A18, ação finita S_m, lei de órbita e argumento de fatoração Borel. | Não identifica assinaturas antigas e novas, não codifica todo plano off-path, não recombina binders e não cria common random draw entre regras. |
| C15 | [B:591–595,849–869](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:591) | A-C4, A-C8 e linha de consequências: ΔV≤−β(e/m−βh). | Exige ambas as fontes; fora da região não dá ranking universal nem igualdade de conjuntos antigos/novos. |
| C17 | [B:849–869,871–901](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:849) | Tabela de impacto, limites de verificação e ledger de dependências. | Mesmas fórmulas não certificam transporte de outcomes. Os 409 checks reportados são finitos/condicionais; revisão científica independente permanece pendente. |

# 6. Profile-specific contract

- **Jogadores.** H único informado, m≥3 fracos, dois tipos; reconhecimento dos fracos no baseline, H obrigatório em A. Pie fixa e o fora dela. B:14–43,423–425.
- **Timing.** Proposta pública (C,x), votação simultânea dos convidados, aprovação só com todos; implementação automática. Rejeição R1→R2, rejeição R2→desacordo, rejeição A→R1. Um β por passagem de data. B:26–43,445–452.
- **Informação.** Fracos não sinalizam; H só vota quando convidado no baseline. Em A, C integra o sinal e a geometria do suporte. Bayes pointwise e μ_off único da agenda não substituem a disciplina local do baseline. B:45–71,443–466.
- **Ações e estratégias.** C contém o proponente e satisfaz quota; x≥0, soma≤1, zero fora de C. Ballots puros e propostas Borel/loterias. Supercoalizões e convidados com zero continuam factíveis. B:20–24,427–452,664–705.
- **Conceito.** PBE, fracos as-if-pivotal, T^Y e desempate do proponente. Agenda seleciona assessments completos públicos/anônimos/Markov. A diferença entre μ e suporte inicial e o alcance dos endpoints ficam em QI-01. B:45–71,86–96,454–500.
- **Pressupostos e interfaces.** A decisão substitui a árvore majoritária, com payoffs completos. Agenda consome kernels literais uniformes e Borel; c/h não bastam. O transporte U é condicional à correção histórica. B:73–110,283–318,765–847.
- **Resultados.** R2 nativa → R1 E/S/P e U → A-C1–A-C7 em Y_M; A-C8 fornece mapa U. Os 17 claims acima são formais, estruturais ou condicionais conforme seu texto, sem avaliação científica por este gate.
- **Mecanismos.** A combinação de zero fora de C e consentimento integral impede acúmulo em todos os ramos. O único informado continua substituível no baseline majoritário; quando propõe em A, C pode sinalizar seu tipo. B:73–84,203–281,707–773.
- **Comparações.** Cortes 1/m, p*, t_SE/t_SP, o_M* e βh<e/m são preservados nos objetos explicitamente indicados. Gap institucional é U−M; IR é privado−público; T=D+I e Q composto usam novas fontes. B:256–281,383–399,849–869.

Campos empíricos são inaplicáveis: não há tratamento observado, outcome estimado, especificação estatística preferida, estimando causal, identificação ou inferência em dados. Payoffs, crenças e outcomes são objetos do jogo. O JSON registra o adaptador formal completo e as justificativas por campo.

# 7. What the document does not claim

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

# 8. Terminology

| Termo | Evitar | Motivo |
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
| candidata de implementação fechada | PASS científico; manuscrito final | O texto distingue fechamento, verificação finita, revisão e integração. |

# 9. Reconciliation log

**QI-01 — Os endpoints μ=0/1 de R1_U classificam todos os históricos com posterior degenerado, inclusive sob suporte inicial interior?** Não. São jogos baseline com prior de entrada degenerado. A agenda importa os assessments endpoint completos por sua seleção declarada; isso não altera o suporte original de um baseline de prior interior. No mesmo baseline, os valores livres de denominador zero respeitam seu prior inicial. O alcance é limitação/assunção mantida do transporte da agenda, não prova de consistência global diferente. Evidência: B:56–59,88–96,336–346,379–381; independent_section_read.md:139–147; Confirmação do implementador/coordenador /root, 19/09/2026. Status: `resolved_interpretive_scope_only`.

**QI-02 — Preservação de fórmulas e 'interface fechada' certificam equivalência majoritária ou revisão científica?** Não. As notas distinguem explicitamente implementação e revisão; M tem espaço novo e dois contraexemplos de equivalência literal. Igualdade de payoff não identifica sinais, avaliações ou laws. Fechamento e checks finitos não são pareceres independentes. Evidência: B:98–110,391–419,707–735,849–901; independent_section_read.md:24–30,110–137. Status: `resolved_by_explicit_nonclaims`.

**QI-03 — Isomorfismo U dispensa revisar as provas históricas que ele transporta?** Não. O mapa C=N afirma preservação estrutural; a validade dos resultados históricos permanece condição expressa. A revisão científica posterior deverá ler B.4, B.8 e E.3 do original exato, incluindo seus argumentos de desvios e suporte; o contrato não adjudica esses argumentos. Evidência: B:419,765–773,859; M original:1532–1608,1831–1965,2362–2567; Pedido de cobertura do coordenador /root, 19/09/2026. Status: `resolved_by_conditional_transport`.

**QI-04 — Uma coalizão mínima no ramo aprovado permite apagar todas as coalizões maiores ou todos os pontos não ótimos do suporte?** Não. A-C4 tem conclusão quase certa sobre propostas aprovadas usadas em equilíbrio; convidados excedentes e recusas permanecem factíveis. A-C7 exige desigualdade em todo suporte, inclusive massa zero, e igualdade apenas σ_o-quase certamente. A-C3, a μ fixado, é distinta da otimização de sinais privados. Evidência: B:527,529–542,561–589,690–705; independent_section_read.md:93–100,113–120. Status: `resolved_by_pointwise_vs_almost_sure_quantifiers`.

**QI-05 — No endpoint de A-C7, 'supported on its argmax' exige suporte topológico contido no argmax ou probabilidade um nele?** O implementador esclareceu que pretende probabilidade um no argmax, conforme a igualdade σ_o-quase certamente em A14, sem impor contenção do suporte topológico no argmax quando o payoff é descontínuo. Esta é uma resolução de intenção/escopo da redação congelada; a revisão científica deverá adjudicar se a precisão é apenas expositiva e se os argumentos a sustentam. O bundle não foi alterado. Evidência: B:690–705, especialmente A14 e a frase endpoint de B:705; esclarecimento do implementador em 19/09/2026. Status: `resolved_intended_scope_scientific_adjudication_pending`.

Nenhuma ambiguidade interpretativa material permanece. A resolução de QI-01 foi confirmada pelo implementador e incorporada também pelo leitor independente; não alterou o bundle nem acrescentou demonstração. QI-05 registra intenção de probabilidade um no argmax, sem hipótese de contenção topológica. A revisão futura deve avaliar as hipóteses, a precisão e as provas delimitadas.

# 10. Gate verdict

**PASS — fidelidade interpretativa apenas**, round 1, SHA `b62a7c8e023568bf408c1b8929b5909b4e7af21c3271c95955970237801b799f`. Cobertura, âncoras, escopo, não-afirmações, campos inaplicáveis, ambiguidades e identidade do fonte foram conferidos. Foram lidos textos, hashes e outputs declarados. Nenhuma nota científica, script, manifesto ou manuscrito foi editado por este macro; nenhum check matemático foi reexecutado neste gate.

A [revalidação substantive_scoped](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v1/revalidation.md) liga o objeto ao contrato original e à decisão de 19/09. Ela não revalida antecipadamente o futuro manuscrito. Os reparos de compressão da introdução R01/R02 continuam relevantes para a consistência depois da migração.

**Validação JSON:** VALID; hash do bundle, quatro fontes, sete itens do manifesto, leituras e contrato anterior conferidos; 10 unidades contíguas cobrem 903 linhas, cada uma abaixo de 4.000 palavras brutas; 17 claims e cinco reconciliações mapeados.

```bash
python3 /Users/manoelgaldino/.codex/skills/argument-fidelity-gate/scripts/validate_contract.py quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v1/argument_contract.json --artifact quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md
```

Revisores formal/adversarial devem verificar as provas do bundle e as dependências históricas U no original 6708eaaf...; o contrato não antecipa findings. Toda alteração de interface, suporte, sinal, kernel ou hash exige revalidação e reexame dos consumidores pertinentes. Scripts de patch de manuscrito não pertencem a este objeto.
