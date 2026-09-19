# Leitura independente das derivações v1: compreensão de R1 e agenda

**reader_id:** `/root/provenance_inventory`  
**Data:** 2026-09-19  
**Papel:** leitor independente para o agente macro `/root/baseline_source_read`.  
**Perfil do contrato:** formal.  
**Estado:** leitura de compreensão concluída; não é parecer científico nem verdict do gate.

## 1. Artefato exato e cobertura

Li integralmente as 903 linhas de `derivations/derivation_bundle_v1.md`, título **Coalition derivation candidate v1**, SHA-256 `b62a7c8e023568bf408c1b8929b5909b4e7af21c3271c95955970237801b799f`. O texto combina inglês e português e contém quatro fontes matemáticas em Markdown, sem PDF associado nesta leitura. Os localizadores abaixo são **linhas desse bundle**, para evitar confusão entre numerações dos quatro arquivos.

Conferi o manifesto `reviews/derivation_candidate_v1.json`, SHA-256 `8dfefecda3b9e369159bbfeb4276f5f6d7c2402e3e897320774b39be12d1feca`: seus sete hashes correspondem aos arquivos presentes. Conferi mecanicamente que os quatro blocos matemáticos do bundle reproduzem os respectivos fontes. Li também o script `agenda_checks.py` e examinei a estrutura e os 409 registros do JSON mediante parsing; não executei seus cálculos nesta fase de compreensão. A decisão autoral já havia sido lida integralmente.

| Unidade | Linhas do bundle | Fonte e SHA-256 | Papel na leitura |
|---|---|---|---|
| Contrato | 8–110 | `derivations/game_contract.md` — `ac78634ea0da03b422a6d92930680d1bb1f94deee0d3c33b68dc9d9791a7d058` | Premissas, solução, estados e dependências |
| R2 | 117–189 | `derivations/r2_interface.md` — `c83cf10483bf42e750e131a0792eedde60ae0eed244822c84ea2a1be285dd8a7` | Folha importada por R1; mapa de claims, sem comparação científica nesta fase |
| R1 | 196–399 | `derivations/r1_interface.md` — `a07a14a115de877411319568a2982e6b5e6e6a8d03c550ead82a6e7078b487e0` | Unidade principal desta leitura |
| Agenda | 406–901 | `derivations/agenda_transport.md` — `3b98454cb275f34a89c6f5a10037eaa34e30e4fbf81e4fb4f01a65e2f8ba9f6f` | Unidade principal desta leitura |

A folha R2 tem também a reconstrução fria anterior `reviews/cold_r2_from_primitives.md`, SHA-256 `57b83c8d83fad84f6f5ce41a6e34d75c60ede19b3e09c71d307bd7d70764896c`, concluída antes de consultar estas interfaces candidatas. Ela pode ser recebida pelo macro como leitura independente de R2. Esta leitura não promove retrospectivamente aquele relatório a uma comparação aprovada com o candidato.

## 2. Tese e arquitetura do argumento

O pacote pretende fechar uma **nova implementação de contrato de coalizão**: o proponente escolhe `(C,x)`, só convidados votam, todos devem consentir, e a implementação do vetor é automática. No baseline, essa mudança preservaria as fórmulas econômicas de payoffs, mas substituiria os argumentos e os registros literais da maioria. Sob unanimidade, o texto afirma um isomorfismo de toda a forma extensiva mediante a etiqueta constante C=N. Na agenda majoritária, a nova ação pública C também é um sinal: a nota rejeita uma equivalência estratégica global com o jogo anterior e constrói seus objetos diretamente no novo espaço.

A cadeia declarada é **R2 → R1 → seletor de avaliação completa → votos em A → propostas de H → leis realizadas → assinaturas/comparações** (98–104 e 472–479). “Interface fechada” e o campo interno “pass” designam estado de implementação, não revisão independente (102–104, 421, 875 e 886–899).

O contraste central que a revisão futura precisa preservar é entre: (a) igualdade de algumas fórmulas de payoff; (b) igualdade de avaliações, sinais, coalizões e leis; e (c) existência de uma aplicação explícita entre jogos. O pacote afirma (a) em vários resultados majoritários, nega (b) globalmente sob maioria e afirma (c) sob unanimidade. Não atribuo ao documento uma alegação de invariância global das correspondências de agenda.

## 3. Premissas e termos que governam os claims

| Elemento | Localizador | Leitura vinculante para o macro |
|---|---|---|
| Jogadores, tipos e domínio | 16–24; 119–121; 425 | m≥3 fracos, um H informado, 0<ℓ<h<1, β∈(0,1), crenças em [0,1] com suporte preservado. O prior da agenda é p; a crença local em continuações é μ/η. |
| Factibilidade e quotas | 20–22; 427–443 | Proponente pertence a C; maioria q=k+1, unanimidade C=N; parcelas não negativas, soma≤1, zero fora de C. Coalizões maiores que a quota e convidados de parcela zero permanecem factíveis. |
| Payoffs, execução e datas | 35–43; 445–452; 492–500 | Aprovação implementa automaticamente; H excluído de acordo do baseline recebe o; qualquer recusa de convidado faz todo o pacote fracassar. Fracasso em A não paga naquele instante e entra em R1 com exatamente um β. |
| Solução e desempates do baseline | 47–71 | PBE com ballots puros, voto fraco as-if-pivotal, sim na indiferença e segundo desempate do proponente que minimiza o payoff esperado de H. Não equivale a consistência de equilíbrio sequencial. |
| Crenças do baseline | 51–62 | Ações dos fracos, incluindo C e x, não informam; com H convidado, Bayes usa seu voto quando possível; caso contrário há valor livre por ballot/voto dentro do suporte original. H não convidado não tem voto. |
| Seleção consumida pela agenda | 88–96; 283–318; 454; 470–500 | Seletor público, anônimo e Markov com representante literal completo. É uma restrição declarada da extensão, não descrição de todas as seleções do baseline. |
| Informação da proposta em A | 443; 456–466 | O sinal é `(C,x)` no espaço de união disjunta finita. Bayes local usa bolas nesse espaço e requer o limite em todo o suporte, incluindo pontos de massa zero. Um só posterior fora do suporte é parametrizado por ρ. |
| Binder/avaliação completa | 666–705; 779–847 | Estratégias, crenças, seleção, leis e payoffs permanecem vinculados. Uma assinatura de leis realizadas não retém toda a informação off-path. |

Aqui “maioria” e “unanimidade” nomeiam a quota institucional admissível de C, mantendo consentimento de todos os convidados. `⊥` é ausência de convite, não voto não. E/S/P/EP são rótulos de resultados/seleções, não novas primitivas. “Exato” em A-C7 significa critério funcional necessário e suficiente, não enumeração finita de suportes.

## 4. Claims de contrato e R2

| Claim explícito | Localizador/evidência textual | Domínio e limite afirmado |
|---|---|---|
| A arquitetura impede acúmulo de parcela positiva implementada e opção externa de H | 75–84: separa H convidado que deve consentir de H não convidado cuja parcela é zero | Todo par factível e todo perfil de votos, inclusive desvios; não deriva só da otimalidade |
| Sob maioria terminal, todas as propostas ótimas excluem H e alocam a unidade ao proponente | 125–145 | Payoffs e data únicos, mas coalizões nominais ótimas podem ser maiores que a quota |
| Os valores pré-reconhecimento de R2_M são H=(ℓ,h), cada fraco=1/m | 147–151 | Unidades R2; o representante mínimo/uniforme usado na agenda não elimina a multiplicidade do baseline |
| Sob unanimidade terminal, oferta baixa selecionada até p*, alta acima | 155–182 | p*=(h−ℓ)/(1−ℓ); segundo desempate seleciona baixa na igualdade; todas as propostas desviantes têm resposta definida |
| O transporte público e de datas usa exatamente β ao importar R2 em R1 | 184–189 | Nenhum desconto dentro da folha; equivalência literal mencionada apenas para U |

A reconstrução fria registra a compreensão independente desta folha. Não apresento aqui uma conclusão sobre a validade das provas candidatas ou sua identidade com aquele relatório.

## 5. Unidade principal: R1

### Tese da unidade

A nota apresenta respostas completas ao novo protocolo, reduz o problema do proponente majoritário a E/S/P, especifica desempates e multiplicidade, e exporta representantes anônimos completos para a agenda. Para U, afirma isomorfismo com o jogo anterior e enuncia explicitamente uma caracterização por regiões de crença, inclusive vazio sob ballots puros. Seu fechamento termina em igualdade das fórmulas econômicas do baseline, não dos históricos majoritários.

| ID | Claim explícito | Localizador e evidência | Scope/hedge |
|---|---|---|---|
| R1-01 | Em maioria, fraco convidado aceita iff x_j≥β/m; H convidado aceita iff x_H≥βo quando os demais aceitam, e vota Y se um veto fraco torna seus dois votos equivalentes | 205–216 | Regra em toda proposta factível; crenças completadas pelo contrato, não apenas no caminho |
| R1-02 | Fracasso certo é dominado pela coalizão mínima E | 218–222, diferença positiva entre Π_E e w | Domínio m≥3 e β<1, com continuação terminal importada |
| R1-03 | Propostas ótimas com chance positiva de acordo têm coalizão mínima e pagamentos de reserva; os únicos candidatos são E/S/P | 224–254, argumento de comparar propostas completas antes do ballot | Não cancela uma parcela depois da votação; compara factibilidade, aceitação e continuações. Não atribui probabilidade positiva a tipo de posterior zero |
| R1-04 | Payoffs ligados de H são E=(ℓ,h), S=(βℓ,βh), P=(βh,βh) | Tabela 242–247 | Valores em R1. Sob S, alto segue R2; sob E, H é excluído do acordo em R1 |
| R1-05 | A seleção exata depende da posição de ℓ/h em relação a 1/m, das fronteiras S/P e S/E e do segundo desempate | 258–273 | S vence empates próprios. Em h=1/m pode sobrar empate E/P; a regra compara a média de (ℓ,h) com βh e pode permitir uma loteria vinculada |
| R1-06 | Persistem escolhas de parceiros, loterias nominais de R2 e, quando autorizada, uma mistura E/P com peso comum | 275–281 | Não são intervalos independentes de payoff por tipo. A ausência de outra forma econômica não é unicidade de avaliação literal |
| R1-07 | O representante para agenda é uniforme/anônimo e tem kernel completo Borel | 283–318, incluindo tabela 302–310 | Definido como representante da correspondência, não todas as seleções históricas. χ deve ser admissível/Borel; aplicar β uma vez em A |
| R1-08 | A unanimidade nova e antiga são isomorfas mediante C=N constante | 322–327 | Inclui todos os perfis e desvios; não afirma equivalência de M |
| R1-09 | Regiões completas de perfis puros em U são fornecidas para endpoint baixo e crenças acima de p*, com suporte e crenças livres especificados | 329–359 | O endpoint baixo é expressamente rotulado “initial low-only support” em 336; ver dúvida interpretativa na seção 9 |
| R1-10 | Para 0<μ≤p*, a correspondência inteira de PBE em ballots puros é vazia | 361–368, proposta s† e exclusão dos quatro perfis de H | O vazio inclui exigências fora do caminho; não é afirmação sobre equilíbrios com ballots mistos ou outro conceito |
| R1-11 | No endpoint baixo e acima de p* há acordo ótimo com pisos A/B, e valores nativos explícitos | 370–381 | Retém payoff contrafactual do tipo de probabilidade zero; a agenda usa o endpoint assessment declarado |
| R1-12 | Benchmarks públicos e comparações econômicas privadas/públicas do baseline conservam suas fórmulas | 385–399 | Inclui células vazias e segmentos de igualdade. Exclui explicitamente equivalência de coalizões, ballots, todas as avaliações off-path e do jogo de sinalização da agenda |

A evidência invocada por esta unidade é dedutiva: respostas de ballot, redução por desvios completos, comparações de objetivos, tratamento de empate e construção de kernels. Não há estimando empírico, amostra, identificação causal ou evidência observacional; esses campos são inaplicáveis ao contrato desta nota.

## 6. Unidade principal: agenda

### Tese da unidade

A nota distingue nova derivação majoritária em `(C,x)` de transporte unânime por isomorfismo. Ela afirma conservar condições de payoff das formas puras, benchmarks, limites e um exemplo, mas inclui contraprovas contra identidade estratégica global. Para leis gerais, fornece um critério funcional e uma reconstrução dos espaços de registros, kernels, relabeling e fatorização, condicionada às continuações completas importadas.

| ID | Claim explícito | Localizador e evidência | Scope/hedge |
|---|---|---|---|
| A-01 | C é parte observada do sinal e pode informar o tipo de H | 412–419; 427–466 | O modelo de agenda não projeta o sinal para x antes de atualizar. Endpoints fixam posterior p em todo o espaço |
| A-02 | A extensão exige κ_g(μ) literal completo; os preços de reserva são r=βc e d_o=βh_o | 470–500 | Uma só conversão de data; o seletor não é meramente um vetor numérico. Sob U, o domínio importado é {0}∪(p*,1] |
| A-03 | A-C1 caracteriza consentimento: cada convidado aceita iff x_j≥r_χ(μ) | 504–514 | Comparação as-if-pivotal; seleção Markov faz toda recusa fraca no mesmo posterior usar a mesma continuação |
| A-04 | A-C2 recupera C de x no ramo que passa | 516–527 | Requer r>0 e passagem. Não redefine o espaço de ações, não elimina zero-payment invitees e não autoriza ignorar C em recusas |
| A-05 | A-C3 dá melhor passagem a posterior fixado: exatamente k convidados, share de H=1−kr | 529–542 | O texto ressalva que mudar o sinal pode mudar a crença; este claim sozinho não otimiza uma mensagem de equilíbrio privado |
| A-06 | A-C4 fornece limite uniforme sobre c/r, garantia segura e exclusão de passagem com coalizão maior que a quota em equilíbrio | 544–587 | Condicional à interface selecionada E/S/P/EP. “Mínima” vale quase certamente sob a lei de cada tipo; não afirma que todo ponto do suporte com massa zero seja argmax |
| A-07 | Recusas com coalizão maior continuam possíveis; H também tem garantia β²o | 589–595 | Não transforma recusa em acordo com uma subcoalizão. Pode haver sinalização por convites destinados a provocar veto |
| A-08 | A-C5 conserva fórmulas públicas e cutoff de atraso/gap | 600–624 | Condicional à interface pública R1. Propostas rejeitadas majoritárias agora carregam C; a igualdade é das fórmulas, não da correspondência literal |
| A-09 | A-C6 dá condições necessárias e suficientes de existência e payoff para seis formas puras | 626–652, tabela 637–644 | p interior e χ fixado. A tabela não é catálogo completo de estratégias; deixa variar todos os pares `(C,x)` admissíveis que realizam a forma |
| A-10 | Há existência majoritária para algum ρ em toda economia da interface | 654–662, três construções segundo T=v_safe/β | Não afirma existência para todo ρ fixado nem identidade de leis com o jogo histórico |
| A-11 | A-C7 caracteriza membership de leis Borel mediante desigualdade em todo o suporte, igualdade quase certamente e limite off-support | 664–705 | Dadas continuação completa admissível, Bayes local e regra de ballot. É caracterização funcional exata, não lista finita de todos os suportes |
| A-12 | A-EX1 usa mesmo x com coalizões diferentes para separar tipos e resultados | 709–723 | Uma contraprova de transporte por projeção x; o texto não afirma que o vetor de payoffs fosse impossível em outra estratégia antiga |
| A-13 | A-EX2 apresenta acordo histórico com pequena parcela para fraco dispensável que não pode passar com esse mesmo vetor no protocolo novo | 725–735 | Igualdade possível de payoff após mudar o sinal não restaura identidade de estratégias, crenças e alocações |
| A-14 | O exemplo de reversão do manuscrito admite testemunha nova com os mesmos números | 737–763 | Mesmo m,β,ℓ,h,p e mesma fibra ρ=0 sob as duas regras; é um par de avaliações, não seleção de toda a correspondência |
| A-15 | A-C8 transporta integralmente a unanimidade pelo mapa C=N | 765–773 | Inclui desvios, sinais, suporte, Bayes local e leis. Expressamente não é nova prova da correção histórica de B.4/B.8; não existência segue limitada a ballots puros |
| A-16 | A construção de Γ incorpora C, dados terminais, posterior, passagem e seleção; kernels importados são Borel/equivariantes | 775–815 | A lei realizada e a avaliação completa são objetos distintos. A observação sobre kernels não substitui completude de estratégias importadas |
| A-17 | Assinatura por órbita diagonal é invariante completo de relabeling; observáveis anônimos Borel fatoram pelo resumo econômico | 817–847 | No espaço novo. Off-path permanece no binder, não na assinatura. Só U recebe mapa explícito para as laws antigas |
| A-18 | Região suficiente de vantagem majoritária, contabilidade e definições de rendas conservam sua forma | 849–869, especialmente 862 e 866 | Comparações exigem binders existentes na mesma economia/fibra. Não cria existência em célula vazia e não afirma igualdade global dos conjuntos antigos/novos |
| A-19 | Os checks finitos apoiam casos declarados, não prova global ou revisão independente | 871–875 e 883–899 | 409 checks relatados, condicionais à interface; não verificam todas as leis Borel, todos os seletores nem toda a prova do baseline |

## 7. Não-afirmações explícitas que devem restringir a revisão posterior

- O pacote **não** afirma equivalência global entre o jogo majoritário novo e o antigo: 106–110, 396–399, 412–419, 723 e 735.
- A eliminação de pagamentos a não membros **não** é reembolso ou cancelamento depois de uma votação: 75–84 e 224–233. A1–A3 com implementação individual não são adotadas: 408.
- Coalizões maiores que a quota **não** foram removidas do espaço de ações; na agenda, recusas desse tipo permanecem: 83–84, 527 e 589.
- A redução de cardinalidade da passagem em A **não** diz que todo ponto do suporte seja um argmax: 587 e 703.
- A melhor oferta a posterior fixado **não** é automaticamente a melhor mensagem privada: 542.
- O representante anônimo para a agenda **não** exaure todas as escolhas possíveis do baseline: 93–96, 283–318 e 490.
- A disciplina de ρ único da agenda **não** é imposta aos ballots internos do baseline: 454.
- O claim de existência majoritária **não** cobre cada ρ previamente fixado: 662.
- A-C6 **não** enumera todas as estratégias; A-C7 **não** enumera finitamente todos os suportes: 652 e 705.
- Isomorfismo sob U **não** recertifica a validade da matemática histórica: 419 e 773.
- Não existência **não** é estendida a ballots mistos ou a outra disciplina de crenças: 368 e 773.
- Igualmente chamados “payoffs” **não** permitem combinar coordenadas de binders diferentes; λ é comum, e pares M/U são marginais contrafactuais, sem sorteio comum fabricado: 275–281, 490 e 847.
- Assinaturas de leis realizadas **não** retêm todo o plano off-path: 792 e 847.
- O exemplo de reversão **não** escolhe uma solução para toda a correspondência: 763.
- Os 409 checks **não** equivalem a prova de todos os seletores/leis Borel nem revisão independente: 873–875.
- “Candidata fechada” **não** significa manuscrito integrado, revisão científica aprovada ou submissão pronta: 3, 12, 102–104, 421 e 883–899.

Não encontrei pretensão de estimar efeitos empíricos, testar o caso WTO com dados ou inferir validade externa nesta nota. As referências ao manuscrito funcionam como destinos de migração e identificação dos claims, e as identidades IR/D/I/T/Q permanecem contábeis (866–869).

## 8. Inventário de evidência, dependências e limites reconhecidos

A evidência principal do pacote é uma sequência de argumentos formais numerados e tabelas de interfaces. As demonstrações da agenda são condicionais às propriedades da interface R1/R2 em hashes fixados (421, 470–500, 875 e 891–899). Os dois contraexemplos fazem parte positiva da tese de ausência de equivalência literal, não são críticas externas ao pacote. A testemunha de reversão prova um caso de existência de um par de avaliações na mesma fibra; o texto não a apresenta como robustez de sinal para todo o conjunto.

O arquivo `agenda_checks.json` declara 409 resultados aprovados e zero reprovados, com hash de script idêntico ao manifesto (`9874ca255487e2245f8d44d3915e82cd6974331a7cd7a05278a7608e5de47445`). A cobertura declarada no texto coincide com as famílias nomeadas no script: desigualdade de coalizão maior, identidade/piso de screening, A-EX1, A-EX2 e reversão. Isso é correspondência documental; não é uma validação científica dos critérios testados. Não reexecutei esse script nem alterei o JSON.

A nota reconhece dependência substantiva de consentimento de todos, observação pública de C, restrição de alocações fora de C e obrigatoriedade da proposta em A (877). Também reconhece que mudar uma lei terminal sem mudar c/h ainda pode invalidar Γ e assinaturas (901). Esses limites devem constar do contrato interpretativo; não devem ser apresentados depois como descobertas omitidas pelo implementador.

## 9. Dúvida interpretativa para esclarecimento pelo macro

**QI-01 — Alcance do endpoint μ=0 em R1_U.** Há uma distinção textual que pode mudar a leitura de completude. O contrato retém “current belief” e “original support” separadamente (88–90), e a crença livre deve permanecer no suporte original (56–59). A caracterização R1_U em 336, porém, diz expressamente “At μ=0 (initial low-only support)”, fixa ambos os posteriors em zero e, em 379–381, remete ao endpoint assessment declarado para a agenda.

Minha leitura estreita é: o fechamento explícito do endpoint usa esse assessment de suporte baixo declarado; as linhas citadas não devem ser ampliadas automaticamente para **todos** os históricos com μ=0 e suporte original interior. A pergunta ao macro é se o contrato interpretativo deve delimitar o claim exatamente dessa maneira ou se existe, nos bytes fornecidos, um localizador adicional que afirme a extensão. Esta é uma dúvida de quantificador e unidade de estado, não um finding de invalidade matemática. Foi enviada ao macro antes da crítica.

**Esclarecimento recebido do macro antes do fechamento desta leitura:** `/root/baseline_source_read` consultou o implementador/coordenador `/root` e transmitiu que μ=0/1 em R1_U designam jogos baseline cujo prior de entrada é degenerado. A agenda importa esses assessments endpoint completos pela seleção declarada, como na convenção histórica de E.1/E.3. Não se afirma que um posterior degenerado dentro de um baseline cujo prior inicial é interior altere o suporte original; nesse mesmo baseline, valores de denominador zero continuam limitados ao suporte inicial. Registro QI-01 como **esclarecida para fins interpretativos**: é limitação/assunção mantida do transporte da agenda, não prova adicional de consistência global. Nenhum byte do bundle foi alterado por esse esclarecimento.

As diferenças entre (i) representantes e toda a correspondência do baseline, (ii) payoffs puros e estratégias completas da agenda, (iii) claims quase certos e ponto a ponto, e (iv) isomorfismo e validade histórica estão expressamente resolvidas pelas ressalvas listadas acima. Não as registro como ambiguidades abertas.

## 10. Entrega ao macro e fronteira de uso

Este relatório pode alimentar o contrato interpretativo `derivations_v1`, especialmente suas unidades R1 e agenda. O relatório frio anterior cobre a reconstrução independente de R2. A condição de passagem do gate, o registro da resolução de QI-01 e a correspondência com o contrato interpretativo do manuscrito original cabem à síntese macro.

Nenhuma crítica científica, adjudicação ou verdict foi emitido aqui. Não alterei fontes, interfaces, scripts, resultados de testes ou manifesto. O único arquivo criado nesta fase é `argument_contract/derivations_v1/independent_section_read.md`. Os hashes do manifesto e do bundle foram reconferidos no momento de gravação.
