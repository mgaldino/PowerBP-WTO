# Leitura independente do baseline e mapa de dependências

**Reader:** `/root/baseline_source_read`. Data: 19 de setembro de 2026. Perfil: formal. Escopo: seção 4 (modelo), seção 5 (resultados), apêndice A, provas B.1–B.6 e apêndices C–D. Esta é uma leitura de compreensão conforme `argument-fidelity-gate`: registra o argumento e suas dependências; não avalia a validade das demonstrações, não adjudica achados e não edita o manuscrito.

## Identidade e convenção de localizadores

- Checkout inspecionado: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion`, branch `codex/exposition-items20-28`, HEAD `26b1a40cb98933ae3cd5fd43dd4b7e691b13f5ba`.
- Fonte principal, aqui abreviada **M**: `formal_model_v6.Rmd`, SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`, conferido nesta leitura. Localizadores `M:299–326` são linhas dessa fonte.
- Fonte condicional, aqui abreviada **N**: `quality_reports/architecture_2026-09-08/architecture_note.Rmd`, SHA-256 `493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3`, conferido nesta leitura. A nota foi lida integralmente, para mapear o alcance de seu transporte.
- Contrato interpretativo da nota consultado: `architecture_2026-09-08:493f513a096b:round1`, em `quality_reports/architecture_2026-09-08/argument_contract/argument_contract.md`. Seu PASS registra fidelidade interpretativa da nota; esta leitura não o converte em adoção da arquitetura, nova revisão científica ou certificação do manuscrito.
- Registro autoral pertinente lido: `quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md`, especialmente linhas 7–18, 29–31, 54–86. O registro distingue a propriedade de propostas ótimas da cobertura de todos os terminais factíveis.
- A inspeção inicial de Git mostrou apenas o diretório de trabalho corrente `quality_reports/peio_2027_2026-09-19/` como não rastreado. Não foi modificada fonte, figura, contrato congelado ou arquivo de outro leitor.

O objeto do manuscrito é denominado **jogo histórico G0** nesta leitura quando necessário distingui-lo das instruções posteriores. A nota define **G\*** como especificação vigente incompleta no ramo contestado e **GC** como candidata condicional A1–A3 (N:84–88). Esses rótulos documentais não são propostos para a exposição do artigo. O relatório não trata GC como adotado.

## Resultado da leitura

O baseline compara unanimidade e maioria com um único ator informado, H, sem agenda nas duas rodadas. Sob maioria, os fracos podem substituir o voto de H por um voto fraco adicional; sob unanimidade, o consentimento de H é indispensável. A contribuição formal apresentada nas unidades lidas depende de distinguir efeito da regra sobre o payoff privado, renda da informação dentro de cada regra e diferença dessas rendas entre regras.

A especificação histórica do ramo **aprovação + H não** aparece explicitamente em M:340–348, M:366–368 e M:1385–1397. As comparações não pivotais de H nas provas B.1 e B.3 a consomem diretamente (M:1433–1437 e M:1482–1489). As continuações majoritárias assim caracterizadas alimentam os resultados públicos e privados e, depois, as subtrações em B.5/B.6 e as três figuras econômicas da seção 5. A quota torna esse ramo inacessível sob unanimidade; a prova unânime B.4 não usa o payoff de aprovação com H não.

A nota de arquitetura afirma a preservação condicional das estratégias de proposta, votos puros prescritos, crenças e resultados econômicos do baseline após projetar fora a nova ação de execução. Ela separa esse claim da igualdade de todos os payoffs desviantes e da validade das classificações históricas transportadas (N:415–466, N:495–514). Assim, o mapa abaixo identifica dependências do texto histórico e o que a nota afirma transportar; não anuncia que a pendência autoral já esteja resolvida.

## Unidade 4 — The model

**Tese da seção.** Construir a comparação institucional mantendo jogadores, economia, reconhecimento e protocolo de votação comuns às duas regras. A diferença de quota altera a necessidade de obter o consentimento do único ator informado. A extensão com agenda é expressamente um jogo adicional, posterior à solução do baseline.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| Há H e `m≥3` fracos; somente H observa `o∈{ell,h}`, com `0<ell<h<1` e prior `p`. | M:299–307 | Definição de jogadores, informação e domínio. | Dois tipos; não há informação privada dos fracos. |
| O baseline tem duas rodadas; somente fracos são reconhecidos, uniformemente, com sorteios independentes e reposição. | M:309–312 | Protocolo declarado. | H nunca propõe no baseline; o primeiro proponente continua elegível na segunda rodada. |
| A proposta é um vetor não negativo com soma no máximo um; não há pagamentos laterais externos ao pacote. | M:313–326 | Definição de `mathcal X` e interpretação das parcelas. | Não há teto adicional para `x_H`. O esgotamento do unitário é afirmado no caminho de equilíbrio. H não tem benefício intrínseco de acordo além de sua parcela. |
| Votos são simultâneos, o proponente conta como sim e o vetor completo só se torna público ao final. | M:328–338 | Definição de `k=floor((m+1)/2)` e das quotas. | Maioria requer `k` votos adicionais; unanimidade requer todos. |
| No jogo escrito, aprovação com H sim paga `x_H`; aprovação com H não paga `o` e a parcela `x_H` não é paga a ninguém. | M:340–348; tabela `tab:protocol`, M:360–368 | Regra primitiva de implementação, reiterada em tabela. | Claim histórico de exclusividade em toda história. O próprio texto distingue a regra do resultado posterior de exclusão ótima com `x_H=0`. |
| Fracasso em R1 não realiza payoff corrente e leva a R2; fracasso em R2 paga zero aos fracos e `o` a H. | M:350–356, M:369–380 | Transições e valores `beta C_H(h^Y)`, `beta C_H(h^N)`. | O voto não isoladamente não termina o jogo nem remove H. A continuação depende potencialmente do voto público. |
| O conceito usa PBE com votos puros, disciplina de crenças, comparação pivotal dos fracos, sim na indiferença e desempate do proponente que minimiza o payoff esperado de H. | M:411–433 | Regras declaradas e remissão a A.2. | Não é uma afirmação de equivalência com equilíbrio sequencial. Preserva o suporte do prior nos endpoints. |
| Forma de equilíbrio, célula de parâmetros, assessment completo e vetor vinculado são objetos distintos. | M:435–445 | Definições expressas. | Uma mistura de propostas usa o mesmo peso para payoffs e resultados. `o` é primitivamente payoff terminal de desacordo; “outside option” é sua interpretação. |
| A extensão A acrescenta uma proposta obrigatória de H antes do baseline e transporta a continuação por exatamente um fator `beta`. | M:466–479 | Definição dos superscritos B/A e remissões. | Não altera retroativamente quem propõe no baseline; não dá a H a opção de pular a etapa mantendo continuação na data A. |

**Não-afirmações.** A seção não impõe `x_H=0` ao espaço de propostas; não exclui propostas desviantes com parcela positiva de H; não modela votos sequenciais; não faz um voto não equivaler a saída imediata; não dá benefício de acordo adicional a H; não compara um baseline com agenda de H a outro sem agenda dentro da comparação B entre quotas. Essas fronteiras aparecem em M:313–326, 330–338, 350–356 e 466–479.

**Ambiguidades e resolução de leitura.** Não encontrei ambiguidade residual sobre o pagamento dos fracos que votam não: a expressão “parties to the agreement” de M:340 pode ser lida isoladamente como vínculo entre voto e pagamento, mas `tab:protocol` em M:366 e A.1 em M:1385–1389 atribuem as parcelas a cada fraco sem condicionar seu voto. A distinção relevante para o contrato é entre a regra efetivamente escrita e sua autoridade posterior: o manuscrito contém cancelamento histórico; a nota de 8 de setembro não o declara vigente nem declara sua candidata adotada.

**Terminologia a preservar.** H/hegemon; weak states; terminal disagreement payoff; outside option; institutional concession; majority/unanimity; pure ballot strategies; complete equilibrium assessment; linked payoff vector; B/A. “Voto”, “parte do acordo” e “recebimento” coincidem de modo diferente entre o texto histórico e a candidata e não devem ser intercambiados na síntese.

## Unidade 5.1 — Complete-information benchmark

**Tese.** Separar o valor de tornar o voto de H necessário do efeito da informação privada. O preço do consentimento de H é `o` no terminal e `beta o` na primeira rodada, enquanto maioria pode comprar um voto fraco substituto.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| R2 maioria exclui H, fixa `x_H=0`, dá um ao proponente e `o` a H; R2 unanimidade oferece `o` e deixa `1-o` ao proponente. | `prop:public`, M:498–502 | Enunciado e prova B.1. | Tipo público fixado; R2 sem desconto interno. |
| R1 unanimidade acorda com `x_H=beta o`; maioria inclui H sse `o≤1/m`. | M:504–515 | Comparação dos custos de H e do voto fraco; B.1. | Igualdade seleciona inclusão pelo menor payoff de H: `beta o<o` (M:540–542). |
| As parcelas dos fracos e o residual do proponente dependem da quota e de inclusão/exclusão. | tabela `tab:publicgames`, M:519–535 | Tabela de pagamentos por rodada e regra. | Quantidades em R1 usam preços de continuação descontados. |

**Não-afirmações.** Não afirma que unanimidade eleve sempre o payoff público de H: `v_U^B(o)=beta o`, enquanto H excluído por maioria recebe `o`. Não apresenta esse efeito como renda informacional, pois o tipo é conhecido.

**Ambiguidades.** Não encontrei ambiguidade interpretativa residual nessa unidade. “Preço do voto” designa a alocação suficiente para aceitação, não o payoff corrente de H sob exclusão.

**Termos.** Public-type benchmark; inclusão; exclusão; preço do voto; `v_g^B(o)`; threshold `1/m`.

## Unidade 5.2 — Private information in the terminal round

**Tese.** Sob maioria, o consentimento de H não é necessário no terminal; sob unanimidade, o proponente compara selecionar somente o tipo baixo com pagar o alto para ambos.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| R2 maioria tem resultado único: proponente recebe um, demais parcelas zero, H recebe seu `o` e cada fraco tem expectativa `1/m` antes do reconhecimento. | `prop:terminal`, M:555–559 | Reuso de B.1 em B.2 e simetria. | A unicidade declarada é de resultado; identidade do proponente é sorteada. |
| R2 unanimidade oferece `ell` se `p≤p*` e `h` se `p>p*`, com `p*=(h-ell)/(1-ell)`. | M:546–569 | Comparação `(1-p)(1-ell)` versus `1-h`; prova B.2. | Tipo alto rejeita a oferta baixa. A igualdade escolhe a oferta baixa. Não há `beta` nesse cálculo terminal. |

**Não-afirmações.** Não diz que toda oferta terminal obtenha acordo nem que unanimidade sempre faça pooling. O fracasso para o tipo alto sob a oferta baixa é preservado.

**Ambiguidades.** Não encontrei. O `p` da caracterização pode ser usado como crença de entrada do terminal; B.4 depois escreve a continuação em função do posterior `mu`.

**Termos.** Terminal round; low offer; pooling; screening; `p*`; continuation before recognition.

## Unidade 5.3 — Private majority in Round 1

**Tese.** Caracterizar a escolha do proponente entre excluir H, selecionar o tipo baixo ou fazer pooling, usando o voto fraco substituto a preço `w=beta/m`.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| Os candidatos econômicos têm valores `Pi_E=1-kw`, `Pi_S=(1-p)[1-(k-1)w-beta ell]+pw` e `Pi_P=1-(k-1)w-beta h`. | M:573–587 | Valores declarados e redução de B.3. | A demora deliberada é inferior à exclusão. No screening, o tipo alto leva a R2. |
| Para `h<1/m`, há screening até `p_S=P`, depois pooling. Para `ell<1/m<h`, screening até `p_S=E`, depois exclusão. Para `1/m<ell`, exclusão sempre. | `prop:majority`, M:589–609 | Cortes algébricos e comparação de candidatos em B.3. | Seleção de screening nas igualdades. |
| `ell=1/m<h` distingue `p=0` dos positivos; `ell<h=1/m` pode deixar seleção de exclusão/pooling ou uma família residual. | M:610–617 | Desempate por payoff esperado de H. | Na família, o mesmo peso de mistura vincula todas as coordenadas. |
| Permutar fracos identicamente pagos gera multiplicidade sem alterar o vetor de H nem a forma de equilíbrio. | M:619–629 | Simetria e esclarecimento da mistura. | Payoffs de fracos identificados por rótulo podem mudar; a família atingível é unidimensional. |

**Não-afirmações.** Votos puros não excluem sorteio sobre propostas. A unidade não agrega todos os equilíbrios em uma média nem afirma que qualquer combinação de coordenadas seja atingível. Não diz que toda parcela positiva de H aceita por um tipo também passe quando o outro tipo vota não.

**Ambiguidades.** Não encontrei ambiguidade residual entre “segmento de propostas” e mistura: M:626–629 explicita que o peso é probabilidade sobre propostas puras, não interpolação arbitrária entre payoffs.

**Termos.** Exclusion E; screening S; pooling P; deliberate delay; `w`; proposal tie-break; residual proposal family; linked segment.

## Unidade 5.4 — Private unanimity in Round 1

**Tese.** A disciplina de crenças e os votos puros produzem acordo nos dois domínios extremos e ausência de PBE na célula intermediária; a limitação é explicitamente da classe mantida de estratégias.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| Em `p=0`, preservação de suporte sustenta acordo imediato com oferta `beta ell` e parcelas fracas `w_ell^U`. | M:633–643, 652–667 | Fórmulas e prova B.4. | O vetor por tipo contém também coordenada de tipo fora do suporte; isso não atribui probabilidade positiva ao tipo ausente. |
| Em `p>p*`, o acordo é pooling imediato com oferta `beta h` e parcelas `w_h^U`. | M:641–667 | Continuação pooling e prova B.4. | Mesma classe de votos e crenças. |
| Em `0<p≤p*`, não há PBE em votos puros. | M:645–675 | Desvio factível que força sim de todos os fracos e enumeração dos quatro perfis puros de H em B.4. | A ressalva M:670–675 exclui qualquer conclusão sobre existência, seleção ou comparação com votos mistos. |
| A tabela de correspondências mantém a célula vazia e a multiplicidade majoritária. | `tab:privatecorrespondence`, M:677–701 | Resumo conjunto das proposições. | Não substitui a correspondência por um ponto selecionado adicionalmente. |

**Não-afirmações.** O claim de inexistência não é geral sobre todas as estratégias de votação; a unidade não deriva nem seleciona equilíbrios em votos mistos. Não imputa payoff à célula vazia.

**Ambiguidades.** Não encontrei ambiguidade residual sobre a classe da inexistência. “Sequentially rational” usado na prova descreve incentivos dentro do conceito declarado, não substitui A.2 por equilíbrio sequencial.

**Termos.** Support preservation; pure-ballot scope; empty correspondence; pooling continuation; type-contingent vector.

## Unidade 5.5 — Comparing the private games

**Tese.** A diferença entre as quotas não tem sinal único: depende do tipo e da coalizão que a maioria seleciona, e somente está definida quando os dois jogos têm assessment na classe mantida.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| A comparação usa o mesmo ponto de parâmetros e os vetores de ambos os jogos. | M:713–723 | Definição e `prop:privatecompare`. | Contraste vazio quando unanimidade não existe em votos puros. |
| Para `p>p*`, unanimidade menos maioria é `(beta(h-ell),0)` sob screening, zero sob pooling, e `(beta h-ell,-(1-beta)h)` sob exclusão. | M:725–735 | Subtração por componentes em B.5. | A família residual usa o mesmo `lambda` de proposta. |
| Exclusão realiza `o` agora, enquanto a inclusão pode remunerar a continuação descontada. | M:715–720 | Distinção entre os termos `(1-beta)ell`, `(1-beta)h`, `beta(h-ell)` e `beta h-ell`. | São quantidades distintas; não se identifica todo ganho institucional com renda da informação. |
| A figura compara tipos separadamente e marca a célula vazia. | `fig:privatecompare`, M:744–763 | Caption, guia de leitura e arquivo `figure_f1_private_comparison.pdf`. | Não faz média entre tipos; a comparação ocorre no mesmo ponto dos dois painéis. |

**Não-afirmações.** Não há ranking institucional incondicional, imputação na área vazia ou dominância de unanimidade para todos os tipos. A frase central permite que a mesma regra favoreça o tipo baixo e prejudique o alto.

**Ambiguidades.** Não encontrei. “Empty” significa ausência da correspondência mantida, não efeito zero.

**Termos.** Private institutional payoff contrast; timing wedges; discounted type gap; same parameter point; type-specific comparison.

## Unidade 5.6 — Informational rents and the difference of differences

**Tese.** Medir o valor da informação privada dentro de cada regra antes de comparar esse valor entre regras. O benchmark público remove o componente de payoff que advém da quota mesmo sem informação privada.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| `IR_g^B=V_g^B-v_g^B` e `Delta IR^B=IR_U^B-IR_M^B`. | M:765–779 | Definições explícitas. | Mesmos tipos e parâmetros; diferenças de correspondências; conjunto vazio permanece vazio; pesos comuns preservados. |
| Sob unanimidade, a renda é zero em `p=0`, vazia na célula intermediária e `(beta(h-ell),0)` acima do corte. | `prop:rents`, M:791–800 | Subtração do benchmark público em B.6. | Pooling aumenta somente o payoff do tipo baixo relativo ao benchmark. |
| A renda majoritária depende tanto da inclusão pública de cada tipo quanto de screening/pooling/exclusão no privado. | M:802–818 | Seis combinações explicitadas e conjunto residual. | A lista não é um conjunto de casos independentes livremente combináveis. |
| A diferença de rendas pode ser positiva, nula ou negativa conforme a célula e o tipo. | `prop:deltari`, M:832–853; interpretação M:855–875 | Vetores exatos e cálculo em B.6. | Em `p=0`, há coordenada alta fora do suporte; nenhuma probabilidade artificial é atribuída. |
| A figura separa benchmark público, renda dentro da regra e contraste entre rendas. | `fig:rents`, M:877–886 | Caption e arquivo `figure_f3_power_information.pdf`. | Não recompõe tipos nem seleciona entre equilíbrios múltiplos. |

**Não-afirmações.** Renda informacional não é sinônimo de payoff total nem de `V_U-V_M`. O artigo não afirma que informação privada sempre beneficie cada tipo; a tabela admite renda negativa para o tipo alto em screening majoritário quando o benchmark público o excluiria. Não oferece um estimando causal identificado por dados: são contrafactuais formais entre jogos.

**Ambiguidades.** Não encontrei ambiguidade residual na direção das subtrações: privado menos público dentro da regra, depois unanimidade menos maioria. O mesmo peso de mistura aparece nos objetos relacionados.

**Termos.** Informational rent; public benchmark; institutional informational-rent contrast; type-contingent; public inclusion region; linked correspondence.

## Unidade A — Protocol, beliefs, and incentives

**Tese.** Completar as transições e especificar precisamente o conteúdo de “structural consistency” e dos incentivos de votação usados pelas provas.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| A.1 reitera a regra histórica para todo vetor de votos: fracos recebem suas parcelas; H sim recebe `x_H`; H não recebe `o` e `x_H` não é pago. | M:1383–1397 | Regras explícitas por resultado e rodada. | Afirma exclusividade de acordo/desacordo em todas as histórias e `o` em toda exclusão de equilíbrio. |
| Propostas e votos fracos não atualizam crenças; dentro de uma votação, vetores com o mesmo voto de H compartilham posterior. | M:1399–1410 | Definição do posterior pela crença de entrada, lei prescrita e voto de H. | Inclui votações alcançadas por desvios anteriores dos fracos. |
| Bayes é aplicado quando o denominador é positivo; caso contrário, há valor livre local à votação/voto de H, dentro do suporte do prior. | M:1411–1417 | Cláusula explícita. | Votações distintas podem ter valores livres distintos; não é a consistência de equilíbrio sequencial. |
| Fracos comparam a parcela à continuação condicional a seu voto transformar aprovação em fracasso; H maximiza seu payoff por tipo; ambos aceitam na igualdade pertinente. | M:1419–1423 | Restrição de incentivos. | Aplica-se em toda proposta, inclusive fora do caminho. |

**Não-afirmações.** Não restringe o posterior a uma função markoviana importada da agenda; não permite que votos fracos revelem informação privada que os fracos não têm; não atribui aos fracos opções externas positivas em aprovação; não aplica a H a regra pivotal dos fracos; não apaga votações fora do caminho.

**Ambiguidades.** Não encontrei ambiguidade residual no conceito operacional; A.2 resolve os termos abreviados de M:413–433. A.1 descreve o jogo histórico e deve ser mantido distinto do estado autoral posterior.

**Termos.** Entering belief; prescribed type-contingent vote law; structural consistency; ballot-and-vote pair; support of prior; conditional pivotality.

## Unidade B.1 — Proof of public-type benchmark

**Tese.** Resolver R2 antes de R1: fracos custam zero em R2 maioria, o que fixa suas continuações em `1/m`; em R1 o proponente compara H a um voto fraco substituto.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| Todos os fracos aceitam zero no terminal; seus votos bastam para aprovação majoritária porque `m-1≥k`. | M:1429–1433 | Quota e desempate sim. | Domínio `m≥3`. |
| H não pivotal aceita exatamente quando `x_H≥o`; toda parcela positiva de H é subótima para o proponente. | M:1433–1443 | Comparação histórica `Y→x_H`, `N→o`; alternativa ex ante `x_H'=0`, `x_i'=x_i+x_H`. | O texto usa expressamente a regra histórica no argumento de voto. A alternativa é outra proposta anterior à votação, não devolução posterior. |
| Sob unanimidade terminal a menor oferta aceita é `o`; em R1 as continuações determinam os custos. | M:1445–1457 | Limiar de aceitação e comparação de `(k-1)w+beta o` com `kw`. | Desempate seleciona inclusão na igualdade. |

**Não-afirmações.** A prova não afirma que propostas com `x_H>0` sejam infactíveis. Não oferece uma tecnologia de execução que produza por si só o payoff do ramo H não; esse payoff entra da regra A.1.

**Ambiguidades.** Não encontrei. Esta leitura identifica o input usado e o encadeamento, sem julgar sua demonstração dentro de G0.

**Termos.** Nonpivotal H; weak-vote continuation; ex ante reallocation; inclusion cost; exclusion cost.

## Unidade B.2 — Proof of private terminal games

**Tese.** Reusar a solução terminal majoritária e reduzir ofertas unânimes aos dois conjuntos não vazios de aceitação.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| O braço majoritário é o argumento terminal de B.1; cada fraco recebe `1/m` ex ante. | M:1460–1463 | Remissão explícita e simetria. | Herda a dependência do braço majoritário de B.1. |
| Os conjuntos de aceitação relevantes sob unanimidade são tipo baixo somente ou ambos, implementados por `ell` e `h`. | M:1465–1474 | Redução ao menor limiar e comparação de retornos do proponente. | Igualdade seleciona oferta baixa pelo desempate do proponente. |

**Não-afirmações.** Não há desconto interno; não há seleção de tipos fracos; não se estende a comparação terminal a R1 sem construir continuações.

**Ambiguidades.** Não encontrei.

**Termos.** Acceptance set; terminal continuation; prior/posterior entering terminal; low-offer tie-break.

## Unidade B.3 — Proof of private majority correspondence

**Tese.** Classificar qualquer proposta pelo número de fracos que aceitam, determinar o incentivo de H em cada classe e reduzir a otimização a exclusão, screening, pooling ou demora.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| O voto fraco usa limiar `w=beta/m` independentemente da crença e do voto de H. | M:1479–1482 | Continuação terminal majoritária de B.1/B.2. | Usa reconhecimento e resposta terminal já caracterizados. |
| Se `n_Y≥k`, H é não pivotal e compara `x_H` a `o`; toda parcela positiva pode ser removida em favor do proponente. | M:1482–1489 | Regra histórica de H e proposta alternativa com mesmos pagamentos/votos fracos. | A exclusão ótima tem `x_H=0`; a prova não elimina propostas desviantes positivas. |
| Se `n_Y=k-1`, H aceita sse `x_H≥beta o`; se `n_Y≤k-2`, a proposta fracassa e H vota sim por indiferença. | M:1489–1494 | Comparação com a continuação terminal majoritária. | Classificação de propostas com votos fracos prescritos. |
| A redução produz E/S/P/demora; demora é dominada; diferenças de retornos geram cinco casos e desempates. | M:1496–1530 | Candidatos factíveis, `Pi_E-w>0`, diferenças `Pi_P-Pi_E` e `Pi_S-Pi_E`. | Todo candidato selecionado esgota o orçamento; família residual e permutações são preservadas. |

**Não-afirmações.** O limiar `o` pertence à classe não pivotal, não a todas as propostas. Um screening positivo pode fracassar quando o tipo alto vota não. Nenhuma afirmação elimina terminais gerados por desvios dos fracos; o pagamento nesses terminais ainda vem de A.1.

**Ambiguidades.** Não encontrei ambiguidade residual sobre as três classes. O número `n_Y` é determinado pelas respostas prescritas à proposta; não requer que H observe os votos simultâneos antecipadamente.

**Termos.** `n_Y`; pivotal/nonpivotal; feasibility; prescribed weak ballots; screening cutoff; proposal mixture.

## Unidade B.4 — Proof of private unanimity correspondence

**Tese.** Transportar a continuação unânime e examinar respostas após todas as propostas, incluindo um desvio factível cuja falta de resposta pura sustenta a célula vazia.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| A continuação de cada fraco é `c_U(mu)=(1-mu)w_ell^U` até `p*`, e `w_h^U` acima. | M:1534–1544 | Transporte da solução R2 unânime. | O intervalo entre `w_h^U` e `w_ell^U` permite forçar votos sim com a parcela superior. |
| Endpoints e célula alta têm propostas aceitas que superam a demora por `1-beta`. | M:1546–1562 | Valores de continuação, parcelas mínimas e residual. | Payoffs em unidades de R1. |
| Nos domínios de existência, a prova fornece condições por proposta para os quatro perfis puros de H e a disciplina de crenças. | M:1564–1580 | Enumeração por `x_min`, `x_H` e posterior de sim fora do caminho. | Claim de completar respostas puras, não só caminho de equilíbrio. |
| Para `0<p≤p*`, a proposta `s†` força sim dos fracos, mas nenhum dos quatro perfis puros de H satisfaz o argumento de incentivos apresentado. | M:1582–1608 | Enumeração de desvio alto, indiferença baixa e imitação. | Claim de inexistência dentro de PBE com votos puros; não alcança votos mistos. |

**Não-afirmações.** A prova não usa aprovação com H não, impossível pela quota. Não introduz uma melhoria da existência pela arquitetura candidata. Não pode ser lida como prova de inexistência de todo equilíbrio bayesiano sob outras estratégias.

**Ambiguidades.** Não encontrei ambiguidade de escopo. A presente leitura não avalia se a enumeração é uma prova completa; registra o que ela pretende estabelecer.

**Termos.** `c_U(mu)`; response completion; support preservation; `x_min`; `s†`; imitation; pure-profile enumeration.

## Unidade B.5 — Proof of private institutional contrast

**Tese.** Subtrair vetores privados já caracterizados e manter sua estrutura vinculada.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| Os vetores majoritários são S=`(beta ell,beta h)`, P=`(beta h,beta h)` e E=`(ell,h)`; a unanimidade usa o endpoint, vazio ou pooling. | M:1610–1620 | Reiteração das proposições de correspondência. | Depende de B.3 e B.4; não é nova solução de incentivos. |
| A subtração é componente a componente e afim no mesmo peso de mistura. | M:1620–1622 | Operação algébrica declarada. | Mantém o conjunto atingível ligado aos resultados da mesma proposta. |

**Não-afirmações.** Não cria solução na célula vazia nem compara coordenadas de assessments diferentes.

**Ambiguidades.** Não encontrei; “atomic” nessa passagem descreve manutenção do vínculo conjunto, conforme as definições da seção 4.

**Termos.** Componentwise subtraction; affine in common proposal weight; linked payoff/outcome set.

## Unidade B.6 — Proofs of informational rents

**Tese.** Aplicar primeiro privado menos público dentro de cada regra e depois unanimidade menos maioria, sem quebrar a correspondência.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| O benchmark público de B.1 subtraído dos vetores privados dá as rendas da proposição. | M:1624–1634 | Vetores `v_M^B`, `v_U^B` e subtração. | Usa a seleção pública de inclusão/exclusão e as correspondências privadas. |
| Subtrair `IR_M^B` de `IR_U^B` produz os vetores da diferença de rendas. | M:1636–1646 | Enumeração por região pública e forma privada; afim na família residual. | Vazio permanece vazio; o endpoint é cálculo no suporte, mantendo vetor por tipo. |

**Não-afirmações.** Não demonstra novas melhores respostas; não valida por si só os inputs de B.1–B.4. Não toma o produto cartesiano dos intervalos de coordenadas.

**Ambiguidades.** Não encontrei.

**Termos.** Public inclusion region; informational rent; exact correspondence; common `lambda`.

## Unidade C — Endpoints, exact sets, and illustration

**Tese.** Delimitar a interpretação dos extremos de crença e da multiplicidade: endpoints são jogos de informação completa e envelopes marginais não substituem o conjunto conjunto.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| `p=0` e `p=1` reproduzem literalmente o respectivo jogo público, incluindo o empate `o=1/m`. | M:2030–2039 | Preservação do suporte e aplicação dos resultados público/privado. | Não são limites laterais de uma célula interior. |
| A multiplicidade residual usa um `lambda` único; intervalos coordenados são apenas envelopes do segmento. | M:2041–2065 | Fórmulas dos envelopes e explicação explícita. | Produto cartesiano dos intervalos não é atingível. |
| Na célula `0<p≤p*`, `V_U^B`, `IR_U^B` e `Delta IR^B` permanecem vazios. | M:2067–2069 | Consequência da correspondência unânime. | Não atribui payoff, sinal, ranking ou interpolação. |

**Não-afirmações.** O apêndice exclui explicitamente interpretação dos envelopes como retângulo atingível e dos endpoints como limites. Apesar do título conter “illustration”, não encontrei nesta unidade uma figura ou exemplo numérico adicional.

**Ambiguidades.** Não encontrei ambiguidade substantiva residual. As fórmulas dos envelopes devem ser lidas no caso residual a que os parágrafos as vinculam, não como intervalos disponíveis em toda célula.

**Termos.** Endpoint equivalence; exact set; envelope; line segment; Cartesian product; empty source correspondence.

## Unidade D — Notation

**Tese.** Fixar os símbolos do baseline e da extensão e separar os preços de voto em datas diferentes.

| Claim | Localizador | Evidência apresentada | Escopo / hedge |
| --- | --- | --- | --- |
| `o`, `p`, `mu`, `beta`, alocações, continuidades, correspondências e rendas têm os significados listados. | M:2073–2105 | Tabela de notação. | A tabela inclui símbolos da agenda sem tornar essas definições parte da solução do baseline. |
| Assessments completos, vetores vinculados, leis realizadas e assinaturas são objetos diferentes. | M:2109–2129 | Definições de `R_g`, `mathcal B_g`, `mathcal V_g^A`, `Gamma` e assinaturas. | A equivalência de uma interface numérica não afirma identidade desses objetos completos. |
| `w`, `w_o^U` e os preços `r_M(o)`, `r_U(o)` da agenda pertencem a datas distintas. | M:2134–2138 | Advertência explícita sobre desconto adicional. | Não são nomes alternativos da mesma quantidade. |

**Não-afirmações.** A tabela não oferece provas dos resultados de agenda nem transforma todo objeto chamado “payoff” em escalar desvinculado. O relatório não examinou os consumidores completos da agenda, atribuição de outro leitor.

**Ambiguidades.** Não encontrei ambiguidade residual nas definições do baseline. A distinção entre `w_o^U` e `r_g` está explicitada.

**Termos.** Public/private payoff; B/A; complete assessment; linked type-payoff vector; joint realized law; exact relabeling signature; anonymous economic summary; date-specific vote prices.

## Mapa do ramo contestado e dos consumidores

“Direta” abaixo significa que a unidade usa a regra de pagamento de H no ramo aprovado com H não. “Herdada” significa que usa um resultado que a consumiu. “Quota” significa que esse ramo é inviável na instituição tratada. São categorias de dependência textual, não veredictos científicos.

| Objeto | Dependência localizada no manuscrito | O que a nota condicional afirma | Limite que deve acompanhar a leitura |
| --- | --- | --- | --- |
| Regra da seção 4; `tab:protocol`; A.1 | Direta: M:340–348, 366–368, 1385–1397. | A1–A3 substituem cancelamento por oportunidade executável, recurso rival e compromisso/execução; valor ótimo após H não é `max{x_H,o}` (N:170–261). | A implementação e o espaço de estratégias mudam. Não é correção editorial determinada nem regra já adotada. |
| B.1 terminal maioria | Direta: M:1433–1437. | C2 rederiva exclusão ótima, payoff do proponente um, de H `o`, dos fracos `1/m` ex ante (N:272–298). | Com `x_H>o`, voto sim é estritamente melhor em G0 e empate selecionado por `T^Y` em GC (N:281–285). Mesma estratégia não implica mesmos payoffs de todo desvio. |
| `prop:public`, `tab:publicgames`, R1 maioria de B.1 | Herdada das continuações terminais e da resposta de H. | Mesmos custos de inclusão/exclusão e limiar `o≤1/m` (N:508, 516–521). | Transporte condicionado a A1–A3, conceito e caracterização histórica correta; a descrição dos incentivos não pivotais muda. |
| B.2 e `prop:terminal`, braço maioria | Herdada por remissão explícita a B.1 (M:1462–1463). | Mesma interface R2 de C2 (N:287–298). | Não confundir a interface ótima com o payoff após qualquer proposta ou voto desviante. |
| B.1/B.2 terminais unânimes e corte `p*` | Quota: H não impede aprovação. | Mesmo jogo terminal; nota apresenta as continuações `(ell,h)` ou `(h,h)` (N:300–330). | Sem `beta` interno; não substituir a continuação unânime de todo posterior por `o`. |
| B.3 e `prop:majority` | Direta na classe `n_Y≥k`, herdada nas continuações de todas as classes (M:1479–1508). | Mesmos votos prescritos, candidatos E/S/P/D, cortes e família residual sob `T^Y`; C3 cobre propostas ótimas por tipo (N:332–403). | C3 pressupõe respostas prescritas dos fracos. A escolha de execução é que completa terminais de desvios. |
| B.4 e `prop:unanimity` | Quota; consome somente R2 unânime. | Identidade da árvore de barganha unânime e transporte, inclusive célula vazia, se B.4 caracteriza corretamente G0 (N:405–466). | A nota declara que não reaudita integralmente B.4. Não oferece existência em votos mistos. |
| `prop:privatecompare`, B.5 | Herdada de `V_M^B` e `V_U^B`. | Vetores e conjuntos vinculados transportam-se (N:415–423, 509). | Somente correspondências existentes; mesmo peso de proposta; não igualdade de todos os payoffs desviantes. |
| `prop:rents`, `prop:deltari`, B.6 | Herdada dos públicos de B.1 e privados de B.3/B.4. | Transporte algébrico das rendas e diferença de rendas (N:508–514). | Depende de ambos os braços público/privado no mesmo ponto. Não imputa células vazias. |
| Apêndice C | Herdada de benchmarks, endpoints, desempates e segmentos. | C4 inclui endpoints e misturas; N:400–403 preserva peso; N:420–421 inclui células sem assessment. | Mesma vinculação entre coordenadas; endpoints não viram limites laterais. |
| `fig:timing` | Protocolo de proposta/voto/passagem, M:382–409. | A nota acrescenta execução terminal após aprovação com H não (N:194–233). | Fluxograma atual não explicita essa nova ação. Este é mapa de conteúdo, não proposta de redesenho ou juízo visual. |
| `fig:prices`, arquivo F2 | M:703–710; preços e payoffs das correspondências privadas. | Valores econômicos preservados sob C4. | Verificação do arquivo/gerador permanece distinta do teorema. |
| `fig:privatecompare`, arquivo F1 | M:744–763; consumidor de contraste privado B.5. | Mesmo contraste tipo a tipo, fronteiras e célula vazia sob transporte. | Não é renda informacional; não efetua média entre tipos na versão final. |
| `fig:rents`, arquivo F3 | M:877–886; consumidor público/privado e B.6. | Mesmos quatro pontos e respectivas subtrações sob transporte. | Ilustração matemática; não prova global nem aplicação empírica. |
| Símbolos de assessments e agenda em D | M:2109–2123. | A nota preserva interface econômica de continuação da agenda (N:523–527). | Levantamento literal de assessments, membership, assinaturas, mensurabilidade e anonimidade não são certificados pela nota (N:528–533). |

O resultado delimitado de 5 de setembro pode ser lido separadamente: em `architecture_clarification.md:54–74`, toda proposta ótima positiva a H passa apenas com H sim quando os fracos seguem as respostas prescritas; a comparação é válida por tipo, inclusive posterior zero. O registro afirma que isso não define os payoffs de H nem certifica todos os incentivos; em `:78–86` conserva os ramos gerados por desvios. A nota de 8 de setembro acrescenta a construção condicional, não converte retroativamente aquele resultado de otimalidade em teorema de toda a árvore.

## Proveniência das figuras do escopo

Foram inspecionadas referências no manuscrito e trechos do gerador/funções; não foram reexecutados scripts, calculados hashes dos PDFs das figuras ou examinadas imagens nesta leitura.

- `scripts/generate_essential_input_manuscript_figures.R:22–46` importa `essential_input_formulas.R`, importa funções de figuras e verifica fontes congeladas N6/N7. Isso registra os inputs esperados pelo gerador; a leitura não executou essas verificações nem estendeu os pareceres históricos a GC.
- F1 é gerada em `:99–106`; `essential_input_f1_final_data` em `scripts/essential_input_manuscript_figure_functions.R:1624–1639` restringe a versão final às vistas “Low type” e “High type”. Seu consumidor no manuscrito é `fig:privatecompare`.
- F2 é gerada em `:108–116`; a função de dados em `essential_input_manuscript_figure_functions.R:703–783` inclui screening/exclusão majoritários, pooling unânime, endpoint baixo e parcelas/preços. Os marcadores externos usam os valores dos dois tipos; o argumento `public_benchmark` é `NULL` no gerador final. Seu consumidor é `fig:prices`.
- F3 é gerada em `:118–125`; `essential_input_f3_final_data` em `essential_input_manuscript_figure_functions.R:1728–1771` usa `n3_closed_form`, `n4_closed_form`, benchmark público por inclusão/exclusão e subtrações de rendas. Seu consumidor é `fig:rents`. A função exige que o exemplo escolhido esteja em exclusão majoritária e pooling unânime.

Os localizadores acima não substituem uma auditoria do gerador. A dependência da figura em resultados econômicos é uma afirmação rastreável; afirmar que seus bytes estão corretos ou que dispensam atualização após adoção exigiria verificação própria.

## Não-afirmações transversais que devem entrar no contrato macro

1. O manuscrito não oferece um efeito incondicional de unanimidade sobre H. O sinal depende do tipo, da região pública e da forma privada (M:739–742, 866–875).
2. Inexistência significa ausência de PBE na classe de votos puros com o conceito declarado; não significa inexistência em votos mistos (M:670–675).
3. Uma proposta positiva de screening pode fracassar para um tipo; a exclusão ótima não elimina esse caso (M:582–585; N:369–372).
4. Otimalidade em todos os conjuntos de informação não elimina propostas e votos desviantes da árvore. O registro de 5 de setembro e N:D1 deixam essa distinção explícita.
5. O transporte G0↔GC não é identidade de jogos completos nem igualdade de todo payoff desviante. Sua projeção esquece a nova execução; seu alcance é condicionado (N:415–466).
6. Preservação dos resultados históricos na nota pressupõe que estejam corretamente caracterizados. A nota não reaudita B.4 nem a totalidade dos resultados formais da agenda (N:460–466, 495–533).
7. O PASS interpretativo da nota não autoriza A1/A2/A3, não certifica plausibilidade empírica e não autoriza sua migração por si só.
8. `IR` difere de payoff privado total e de contraste institucional privado. `Delta IR` remove o benchmark público de cada regra antes de comparar (M:765–830).
9. Corresponder coordenadas do mesmo assessment é condição substantiva do objeto matemático: não se forma um retângulo juntando envelopes ou pesos diferentes (M:435–443, 2041–2065).
10. Não há ranking, sinal ou payoff imputado à célula vazia (M:2067–2069). Coordenadas fora do suporte são avaliações por tipo, sem peso artificial na expectativa (M:833–836; N:117–124).
11. A extensão com agenda é outro jogo e adiciona uma data/desconto; H não adquire agenda no baseline pela simples referência a A em notação (M:466–479, 2134–2138).
12. As figuras e os exemplos são representações de resultados do modelo, não identificação empírica da OMC ou teste de A1–A3.

## Perguntas e encargos para o agente macro

1. **Identidade do objeto.** No contrato do candidato ainda não alterado, registrar separadamente o que M afirma como G0 e o que a decisão autoral exige em G\*. A adoção de A1–A3 não pode ser inferida do PASS da nota. Esta é decisão pendente, não ambiguidade que o leitor possa eliminar.
2. **Fronteira da leitura.** As afirmações de abstract, introdução, extensão, discussão, conclusão e F4 estão fora deste encargo. Seus leitores devem cruzar a dependência herdada nos vetores majoritários, sobretudo quando fazem interpretações de poder, declínio hegemônico e agenda.
3. **Três alcances.** Manter distintas a ausência de acúmulo em toda história sob C1, a exclusão de aprovação com H não em propostas ótimas sob C3 e o transporte projetado em C4. Nenhum desses rótulos deve resumir os outros dois.
4. **Revisão científica posterior.** Encaminhar B.1/B.3 como consumidores diretos da mudança de incentivos não pivotais e B.4 como caracterização histórica cuja correção a nota não reaudita. Isso delimita o escopo; não é um finding desta leitura.
5. **Figuras e tabelas.** Preservação algébrica alegada não demonstra identidade de implementação. O contrato deve diferenciar a claim representada da posterior verificação do arquivo gráfico.

## Verificações realizadas e limite da entrega

Foram lidas todas as unidades atribuídas, a nota condicional completa e seu contrato interpretativo; conferidos os dois hashes solicitados, branch e HEAD; rastreadas as três figuras econômicas até seus consumidores e trechos de geração. Não foram executados verificadores matemáticos, compilação, geração de figuras, testes empíricos ou inspeção visual. Não houve revisão de correção das provas e não foi emitido PASS científico.

A memória local foi consultada apenas para localizar a distinção histórica entre dominância de propostas e arquitetura completa (`MEMORY.md:694–721`). Todas as afirmações de conteúdo neste relatório foram ancoradas nas fontes atuais acima; a memória não serviu como certificação do candidato.
