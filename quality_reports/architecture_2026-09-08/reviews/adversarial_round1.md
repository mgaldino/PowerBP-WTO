# Parecer adversarial integral — arquitetura condicional

**Veredicto: PASS 0/0/0 no escopo da nota condicional.** Não identifiquei defeito crítico, maior ou menor confirmado que impeça aceitar suas demonstrações e delimitações para o jogo candidato sob A1–A3 e o conceito expressamente mantido. A dependência de compromisso vinculante, tecnologia indivisível e `T^Y` é substantiva, mas aparece como hipótese ou limite explícito; não é apresentada como resultado dos fundamentos vigentes nem como robustez geral.

## Identidade, independência e escopo

- Revisor: `/root/architecture_reader_2`.
- Data: 8 de setembro de 2026.
- Tipo de jogo: barganha distributiva bayesiana de duas rodadas, reconhecimento aleatório de um fraco, votação simultânea e informação privada de H; a candidata acrescenta uma decisão terminal de execução. Não é um global game nem um problema de persuasão reduzido à escolha de uma distribuição de posteriores.
- Nota integral revisada: `quality_reports/architecture_2026-09-08/architecture_note.Rmd`, SHA-256 `493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3`.
- PDF associado: `quality_reports/architecture_2026-09-08/architecture_note.pdf`, SHA-256 `e5b7b258d64a85b4573f537315276a127f09e142383c65953e182a206c968ae0`.
- Contrato argumental recebido: `architecture_2026-09-08:493f513a096b:round1`, estado `PASS`, em `argument_contract/argument_contract.json`, SHA-256 `1d1c46c001c7e71a9fabb4b2ca7f1e7d592cc21dd179f64fdd05352407b8cdd0`.
- Os 18 arquivos de `candidate_manifest.json` coincidiram com seus hashes no início e no encerramento. O manuscrito histórico consultado conservou o SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`.
- A revisão utilizou as skills `devils-advocate` e `game-theory-audit`, adaptadas ao jogo e ao escopo solicitado. Não lancei outro agente, conforme a instrução específica desta revisão.
- Participei anteriormente da extração interpretativa da seção 2, sem editar o candidato. Nesta etapa li e avaliei a nota integral. Não implementei a nota, seus scripts ou suas interfaces, e não li `reviews/formal_round1.md`.
- Todos os localizadores `L...` abaixo pertencem à nota Rmd indicada, salvo identificação expressa de outra fonte. A avaliação científica usa a fonte completa; não atribuo a este parecer uma auditoria visual página a página do PDF.

O objeto avaliado é a construção condicional e suas repercussões declaradas. `G_0` é o jogo histórico com cancelamento; `G_*` é a especificação vigente incompleta; `G_C` é a candidata. O parecer não converte o primeiro ou o terceiro em arquitetura já adotada, nem substitui a ressalva explícita sobre a correção das caracterizações históricas consumidas por transporte.

## Findings confirmados

| Severidade | Número | Resultado |
|---|---:|---|
| `critical` | 0 | Nenhum defeito confirmado que invalide o diagnóstico ou a construção condicional. |
| `major` | 0 | Nenhuma lacuna confirmada nas demonstrações próprias ou no alcance do transporte. |
| `minor` | 0 | Nenhuma inconsistência relevante confirmada que exija reparo na nota para esse escopo. |

Não há itens de correção requeridos por este parecer. Os ataques e seus resultados estão registrados a seguir para que o veredicto seja verificável, inclusive quando um ataque encontra um limite já reconhecido pelo documento.

## Ataque principal: a execução mudaria os incentivos anteriores?

O ataque de maior consequência foi testar se substituir o cancelamento histórico por uma escolha ótima após não e aprovação amplia a correspondência de votos, muda o desempate do proponente ou altera a continuação usada pelos fracos. Se isso ocorresse sob o próprio conceito mantido, C4 seria falso mesmo que C1 fosse verdadeiro.

Quando os votos fracos já garantem aprovação, `G_0` dá a H `x_H` após sim e `o` após não. `G_C` dá `x_H` após sim e `max{x_H,o}` após não. Para `x_H<o`, não é estritamente melhor em ambos; para `x_H=o`, ambos empatam; para `x_H>o`, sim é estritamente melhor no histórico e empata na candidata. Portanto a igualdade das utilidades das ações é falsa, mas o voto selecionado por `T^Y` é igual: sim se e somente se `x_H>=o`. O pagamento no voto selecionado também é igual. A nota registra exatamente essa distinção em L272–285 e L577–581.

O novo nó ocorre apenas depois de aprovação, que é absorvente. Ele não pode mudar uma continuação de barganha nem produzir informação antes da votação que já terminou. As utilidades dos fracos continuam dependendo de sua parcela e da ocorrência de aprovação; a mudança do pagamento de H não entra em sua utilidade, pois não há externalidade. Esses fatos impedem que o ataque se propague para as comparações pivotais dos fracos ou para o valor de uma proposta sob as respostas prescritas. O resultado depende de `T^Y`; a nota não esconde essa dependência.

## Ataques ao diagnóstico e ao conteúdo econômico

### D1 não elimina ramos; D2 não prova impossibilidade geral

**Alvos:** K01–K02 do contrato; L29–33 e L126–161.

No exemplo de D1, com `m=4`, o proponente e os três respondedores fracos conseguem aprovar uma proposta que lhe dá `4/5`, dá `1/5` a H e zero aos demais. Os respondedores fracos votam sim pela comparação terminal com zero e pelo desempate aprovado. Substituir essa proposta pela atribuição de um ao proponente prova inferioridade da primeira, mas não retira a primeira do espaço de ações. Logo sua inferioridade não fornece o pagamento ausente de H. Um desvio adicional de um voto fraco tampouco desaparece porque a estratégia prescrita tem outro voto.

D2 exige conjuntamente transferência irrevogável, acesso ao exterior sem recurso rival impeditivo e soma dos recebimentos. Sob essas condições, o próprio ramo de D1 fornece `x_H+o`, com dois componentes positivos. A contradição é válida para essa interpretação. A nota diz expressamente que as três condições não são todas fundamentos aprovados; não há salto de incompletude para impossibilidade dos oito fundamentos.

**Resultado do ataque:** não confirmado. A distinção entre jogo incompleto e interpretação adicional incompatível é mantida. Não usei uma interpretação monetária irrevogável como se fosse hipótese já adotada da candidata.

### A1–A3 são apenas um novo nome para cancelamento?

**Alvos:** K03–K04; L170–218 e L235–268.

Não. Há uma diferença de ação e de payoff observável dentro da árvore especificada: se `x_H=1/5`, `o=1/10` e H votou não numa proposta aprovada, pode executar o clube e receber `1/5`; o cancelamento histórico pagaria `1/10`. A oportunidade positiva não desaparece por causa do voto e tampouco retorna ao proponente. O conjunto de ações de execução permite escolher o clube inclusive após esse voto não.

A exclusividade vem de três hipóteses econômicas expressas: o benefício do clube requer execução; o mesmo recurso indivisível é necessário às duas oportunidades; sim cria compromisso condicional vinculante. Isso é uma microfundamentação condicional por uma tecnologia e uma instituição de compromisso, não uma derivação dessas hipóteses a partir da racionalidade do proponente. O texto assume esse custo em L185–192 e L609–629. Uma aplicação pode rejeitar a plausibilidade dessas hipóteses; a nota não oferece evidência empírica que autorize presumir sua adequação a uma organização específica.

**Resultado do ataque:** não confirmado como defeito da nota. A candidata tem conteúdo adicional e distingue-se operacionalmente do cancelamento. Sua adoção permanece uma decisão substantiva separada.

### O recurso poderia produzir acúmulo depois de um desvio?

**Alvos:** K04; A2–A3, tabela de histórias, equação (1), Proposição C1; L178–207 e L224–261.

Examinei as classes de história abaixo sem supor que os desvios anteriores sejam racionais:

| História | Possibilidades efetivas de H | Resultado para dois recebimentos positivos |
|---|---|---|
| Aprovação após sim, inclusive sim desviante | Compromisso vinculante executa clube: `(x_H,0)`. | Não há acúmulo. |
| Aprovação após não, inclusive proposta e votos desviantes | H escolhe clube `(x_H,0)` ou exterior `(0,o)`. | Não há acúmulo em nenhuma das ações. |
| Aprovação após não e execução deliberadamente subótima | A mesma dupla de ações factíveis continua disponível. | A propriedade não exige melhor resposta. |
| Fracasso em R1, com qualquer voto de H | Nenhum recebimento atual; segue R2. | Não existe parcela corrente a acumular com a continuação. |
| Fracasso terminal, com qualquer voto de H | H recebe `o`; não há concessão de clube aprovada. | Não há acúmulo. |
| Igualdade `x_H=o` após não e aprovação | Ambas as ações são ótimas; uma eventual loteria escolhe uma delas em cada realização. | Não há dois componentes positivos em uma história realizada. |

Duplicação, empréstimo, fracionamento e execução sequencial das duas oportunidades dentro do terminal estão excluídos pela tecnologia A2; violar essa cláusula é mudar o jogo, não apresentar um desvio factível em `G_C`. Vender ou transferir a oportunidade também contraria o compromisso específico não negociável de A1. O documento formula essas restrições como novas hipóteses econômicas, não como conclusões de comportamento estratégico.

O contraexemplo com recurso divisível e retornos lineares realmente permite dois componentes positivos, inclusive uma execução ótima em igualdade. Ele já está em L567–575 e delimita a construção. Não o contabilizei como finding novo.

**Resultado do ataque:** não confirmado dentro de A1–A3. A propriedade de C1 vale por factibilidade tecnológica para todas as histórias do jogo, enquanto a fórmula `max{x_H,o}` exige escolha ótima. A nota separa os dois argumentos.

### Um sim vinculante é um pressuposto oculto de preservação?

**Alvos:** A3, K10; L194–207 e L558–562.

O compromisso é explícito. Se H pudesse votar sim e, depois, optar pelo exterior, a unanimidade terminal aceitaria uma oferta zero: sim e não renderiam `o`, e `T^Y` escolheria sim. O proponente guardaria um. Esse contrafactual destrói o limiar terminal original e confirma que A3 não é dispensável.

A nota enuncia precisamente esse teste. Não exige compromisso após uma votação fracassada nem trata o não como saída antecipada. Tampouco confunde o sim automático de H proponente na agenda com uma ação adicional gratuita: L202–207 registra que a interpretação vinculante precisaria valer também para esse sim se a candidata fosse adotada na extensão.

**Resultado do ataque:** dependência substantiva reconhecida; nenhum defeito confirmado.

## Ataques às derivações de rodada e à exclusão ótima

### R2 é resolvida sem desconto e antes de R1

**Alvos:** K05; L272–330 e interfaces `R2_M.md`/`R2_U.md`.

Na maioria terminal, os `m-1` respondedores fracos bastam porque `m-1>=floor((m+1)/2)` para `m>=3`. Todos aceitam zero sob o conceito mantido. A atribuição de um ao proponente, zero aos demais, passa; qualquer concessão adicional ou sobra do orçamento reduz seu payoff sem melhorar aprovação. O sorteio uniforme, independente e com reposição dá a cada fraco `1/m` antes do reconhecimento. H recebe `o` por tipo. Nenhum desses valores contém `beta`.

Na unanimidade terminal, aprovação com voto não de H é impossível pela quota, inclusive após desvios dos fracos. O novo nó não é alcançável. As únicas ofertas relevantes a H são `ell` e `h`: uma oferta intermediária mantém o conjunto de aceitação e pode ser reduzida; oferta inferior a `ell` fracassa para ambos; oferta superior a `h` desperdiça residual. A comparação `(1-mu)(1-ell)` versus `1-h` dá `p*=(h-ell)/(1-ell)`. Em `mu=p*`, a oferta baixa dá a H payoff esperado estritamente menor que `h`, porque `(1-p*)(h-ell)>0`; o desempate do proponente seleciona a baixa. As continuações por tipo `(ell,h)` e `(h,h)` estão corretas, inclusive sem transformar a coordenada de tipo de probabilidade zero em massa positiva.

**Resultado do ataque:** não confirmado. As duas soluções terminais fornecem interfaces diferentes, e a nota não transporta `beta` para dentro de R2.

### A tabela de H pressupõe observar votos simultâneos?

**Alvos:** K06; L334–352.

A contagem `n_Y` vem da proposta observada e das estratégias puras conhecidas dos fracos. Estes não possuem tipo ou sinal privado próprio. Logo H conhece a contagem prescrita sem observar antecipadamente ações simultâneas. Se um fraco efetivamente desvia, a contagem realizada pode mudar; a execução subsequente usa o resultado público, e os pagamentos continuam definidos. Isso não transforma o desvio em informação disponível a H antes da própria ação.

Com `w=beta/m`, as comparações de H são:

| Classe prescrita | Sim | Não | Consequência |
|---|---|---|---|
| `n_Y>=k` | `x_H` | `max{x_H,o}` | Sim exatamente quando `x_H>=o`, por `T^Y`. |
| `n_Y=k-1` | `x_H` | `beta o` | Sim exatamente quando `x_H>=beta o`. |
| `n_Y<=k-2` | `beta o` | `beta o` | Sim por `T^Y`. |

H compara payoffs do próprio tipo. Não calcula a média das opções externas sob a crença pública nem aplica a si a regra pivotal dos fracos. A tabela da nota coincide com essa reconstrução.

**Resultado do ataque:** não confirmado.

### A mudança do pagamento de H altera um desvio unilateral de um fraco?

**Alvos:** C4, especialmente L435–446.

Um fraco pode, mediante desvio, tornar aprovada uma proposta que fracassaria com H não. Esse caso foi tratado como um possível contraexemplo, pois ativa justamente o ramo modificado. No entanto, o pagamento do próprio fraco continua sendo `x_j` depois de aprovação, qualquer que seja seu voto; após fracasso majoritário em R1 sua continuação é `beta/m`, independente do posterior. A diferença entre `o` e `max{x_H,o}` é recebida por H e não modifica a utilidade do fraco. Se ambos os votos de um fraco mantêm fracasso, as continuações majoritárias tampouco diferem. Na unanimidade, o ramo modificado é impossível.

**Resultado do ataque:** não confirmado. A ausência de externalidades e a manutenção dos pagamentos fracos são insumos essenciais já declarados.

### C3 depende de certeza de rejeição ou elimina screening?

**Alvos:** K06; L354–403.

Não. A prova classifica o número de votos fracos, não o tipo provável de H. Quando `n_Y>=k`, a alteração de proposta `x'_H=0`, `x'_i=x_i+x_H` conserva a soma, a não negatividade, as parcelas dos respondedores e seus votos; ambas passam para cada tipo de H. O ganho `x_H` para o proponente é estrito por tipo e não depende de uma ponderação posterior positiva. Quando `n_Y=k-1`, um não de H causa fracasso; quando `n_Y<=k-2`, a aprovação não ocorre. Essas classes cobrem a alegação e preservam ofertas aceitas por um tipo e rejeitadas por outro quando a rejeição implica fracasso.

A comparação é feita antes da votação. Em nenhum passo o valor é devolvido automaticamente ao proponente após o voto não. Também não aparece um ganho estrito fictício entre duas propostas que fracassam com a mesma continuação; a nota nega essa ampliação em L369–372.

As quatro fórmulas em (5) e as diferenças em (6) são algebricamente corretas. O ganho da exclusão sobre atraso é `1-beta(k+1)/m>0`. Uma candidata de inclusão inviável tem residual negativo e não pode superar a exclusão; respeitar factibilidade antes de otimizar é consistente com esse cálculo. A enumeração independente descrita adiante também procurou ótimos fora dessas classes numa grade de propostas, sem encontrar contraexemplo.

**Resultado do ataque:** não confirmado. O alcance de C3 continua restrito a respostas fracas prescritas, ao passo que C1 cobre histórias que C3 não elimina.

## Ataques ao Teorema C4 e à disciplina de crenças

### A igualdade é de estratégias completas ou apenas de projeções?

**Alvos:** K07; L415–466.

O enunciado limita a equivalência às estratégias de proposta, votos puros prescritos e crenças anteriores à nova execução, com igualdade dos resultados induzidos quando essas estratégias são seguidas. A ressalva sobre pagamentos de perfis arbitrários de desvios aparece no próprio enunciado. Isso é necessário: o exemplo em L263–268 já prova que os pagamentos de H em toda a árvore não são idênticos.

Verifiquei as duas direções do transporte:

1. **Projetar de `G_C` para `G_0`.** Na maioria, as respostas puras selecionadas de H são as mesmas em cada proposta e tipo, apesar da alteração de algumas preferências estritas para empates. Os pagamentos dos fracos são idênticos em qualquer vetor de votos; as continuações após fracasso são as mesmas. Logo suas comparações e a avaliação de cada proposta factível pelo proponente são preservadas. Na unanimidade, todos os ramos de barganha têm os mesmos pagamentos por ação.
2. **Estender de `G_0` para `G_C`.** Acrescentar execução ótima em cada novo nó é possível, por exemplo escolhendo clube quando `x_H>=o` e exterior quando `x_H<o`. H conhece ambos os números ao escolher. Em igualdade, clube ou exterior dão o mesmo valor; não é necessário introduzir um desempate novo. A comparação no nó de voto passa a incluir esse valor otimizado, que seleciona o mesmo voto por `T^Y`.

A igualdade é ponto a ponto nas propostas sob respostas prescritas. Portanto a utilidade esperada de uma loteria de propostas e o critério secundário de minimizar o payoff esperado de H também são iguais nos dois jogos. Não é preciso escolher nova média sobre parâmetros nem um peso independente para cada coordenada de um vetor de payoffs. A existência de várias extensões na igualdade da execução não destrói a correspondência projetada.

**Resultado do ataque:** não confirmado. Seria incorreto anunciar equivalência literal de árvores ou de todos os incentivos cardinais, mas esse não é o claim de C4.

### O novo nó altera Bayes ou ressuscita um tipo de probabilidade zero?

**Alvos:** K07, domínio L117–124 e L435–457; fonte normativa de setembro, L16–18 de `quality_reports/2026-09-01_decisao_structural_consistency_baseline.md`.

Para cada votação, a atualização bayesiana relevante usa a crença de entrada e a probabilidade prescrita do voto de H por tipo. Como C4 preserva essa lei, preserva o denominador bayesiano e a atualização quando ele é positivo. Quando é zero, a liberdade continua ligada àquela votação e àquele voto de H, no suporte do prior inicial. A nova execução acontece somente depois de aprovação e não tem consumidor posterior na barganha; não introduz uma atualização que possa voltar no tempo e alterar o voto.

O argumento por tipo em C3 e C4 não exige que esse tipo receba probabilidade corrente positiva. Se o prior é interior, um tipo de posterior corrente zero pode continuar no suporte inicial; a disciplina permite uma crença livre futura no caso pertinente. Se o prior é degenerado, a regra continua impedindo que o tipo ausente receba posterior positivo. Essas duas afirmações não são confundidas em L117–124 ou L327–330.

Não substituí essa disciplina por equilíbrio sequencial nem por uma regra de crença única global, pois isso mudaria o objeto avaliado. Também não usei a probabilidade nula de pivotalidade para reintroduzir votos fracos arbitrários: o conceito aprovado prescreve a comparação pivotal em cada proposta, incluindo propostas fora do caminho.

**Resultado do ataque:** não confirmado.

### A nota usa transporte como recertificação de B.4?

**Alvos:** L407–466, L495–514.

O novo nó é inacessível sob unanimidade por força da quota. Assim, o argumento de identidade da árvore de barganha é suficiente para transportar uma correspondência histórica corretamente caracterizada, inclusive seu vazio. Ele não demonstra por si só que B.4 tenha classificado corretamente todos os assessments. Essa condição aparece expressamente em L460–466 e no mapa de impacto.

Conferi a interface histórica pertinente e o texto de B.4 para identificar o objeto consumido, sem atribuir a este parecer uma auditoria integral de sua prova de inexistência. O esgotamento referido em L214–216 é o orçamento das alocações prometidas nas propostas ótimas dos assessments considerados; não é eficiência realizada depois de qualquer desvio ou fracasso. Na maioria, C2 e as comparações de R1 sustentam diretamente essa propriedade; na unanimidade, a referência permanece vinculada à caracterização histórica transportada.

**Resultado do ataque:** limite reconhecido, não finding novo.

## Ataques às repercussões e à agenda

### Benchmark público e exemplo numérico

**Alvos:** K08; L508–554.

Sob maioria pública, inclusão custa `(k-1)beta/m+beta o` e exclusão custa `k beta/m`. Incluir é mais barato para `o<1/m`; em igualdade o proponente prefere o menor payoff de H, `beta o<o`, escolhendo inclusão. Sob unanimidade pública, pagar `beta o` a H e os valores de continuação aos fracos deixa ao proponente exatamente `1-beta` a mais que esperar. A comparação não introduz `beta` duas vezes.

No exemplo `m=4`, `beta=0,9`, `ell=0,10`, `h=0,35`, `p=0,80`, os valores de R1 sob maioria são `Pi_E=0,55`, `Pi_S=0,317` e `Pi_P=0,46`; exclusão é selecionada. Isso dá a H `(0,10;0,35)`. A interface unânime histórica consumida dá `(0,315;0,315)`; o benchmark público é `(0,09;0,35)` na maioria e `(0,09;0,315)` na unanimidade. As subtrações produzem rendas `(0,01;0)` e `(0,225;0)` e diferença `(0,215;0)`, com o denominador/unidade de payoff preservado e a direção da subtração declarada na caption.

A nota não usa esse exemplo como prova global de C4 e não imputa valores a células vazias.

**Resultado do ataque:** não confirmado.

### Igualdade econômica permitiria instalar automaticamente os contratos da agenda?

**Alvos:** K09; L511–533 e interfaces `economic_transport.md`/`conditional_contract.json`.

Não. A proposta de agenda de H conta como sim; se aprovada, não aciona a escolha adicional após não. Se rejeitada, consome o baseline com o desconto adicional próprio da extensão. Isso sustenta a preservação da interface econômica sob transporte, mas não faz um assessment antigo se tornar literalmente um assessment da árvore nova. Estratégias completas de execução, seleção por estado, anonimidade, mensurabilidade, membership e assinaturas ainda precisam de um levantamento explícito.

Essa distinção está em L523–533 e na linha de impacto sobre membership. O arquivo `game_dag.json` declara que seus estados são de fechamento local da derivação condicional, e não de adoção autoral ou certificação histórica global. Não encontrei uma importação silenciosa da restrição markoviana da agenda para as crenças do baseline.

**Resultado do ataque:** não confirmado. A pendência da agenda já é um limite do claim K09, não uma lacuna escondida descoberta neste parecer.

### Validação formal seria apresentada como adequação empírica ou autorização?

**Alvos:** K03, K10–K11; L185–192 e L593–637.

O exemplo produtivo é declarado abstrato; a nota não estima um mecanismo nem oferece evidência de que uma organização internacional opere essa tecnologia. As três decisões autorais separam concessão executável, rivalidade indivisível e compromisso/execução. Rejeitar uma delas não restaura automaticamente o cancelamento histórico ou a soma aditiva. As limitações dos testes finitos e o caráter condicional da revisão são explícitos.

Não apliquei um checklist de identificação causal empírica, dados observados ou unicidade de global games a esse objeto. Tampouco considerei a ausência de uma prova de minimalidade global um defeito, pois a nota afirma somente uma construção com uma escolha binária adicional e nenhum parâmetro numérico novo.

**Resultado do ataque:** não confirmado.

## Evidência computacional independente e reprodução

O script da candidata foi inspecionado, mas não executado novamente por este revisor, pois grava nos outputs fixados. Os arquivos armazenados contêm 29.005 registros `TRUE`, sem IDs duplicados, e coincidem com o manifesto. Essa inspeção não foi tratada como uma execução independente.

Criei e executei, inicialmente apenas em `/private/tmp`, uma busca independente em Python 3.13.3, usando `fractions.Fraction` da biblioteca padrão. Não há tolerância numérica: votos, comparações, probabilidades e empates usam números racionais exatos. Por instrução posterior do coordenador, preservei cópias byte a byte do script e do resultado em `reviews/adversarial_evidence/`, fora dos 18 arquivos do candidato. O script não foi alterado nem reexecutado durante essa preservação.

### Procedimento executado

Para a maioria em R1, foram enumeradas todas as composições inteiras do orçamento de grade, incluindo uma coordenada de sobra. Assim, a busca inclui propostas que não esgotam o orçamento e distribuições arbitrárias entre proponente, H e respondedores, não apenas as quatro candidatas da nota. Para cada proposta e tipo, dois cálculos separados usam os pagamentos de `G_0` e `G_C`, selecionam o voto de H por `T^Y` e comparam voto, aprovação, payoff do proponente e payoff de H. Depois a busca otimiza em cada prior, primeiro o payoff do proponente, depois o menor payoff esperado de H. Testa ainda C3 sobre todos os maximizadores primários, sem excluir tipos que tenham peso zero naquele prior.

| Configuração | `m` | `beta` | `ell` | `h` | Denominador da grade |
|---|---:|---:|---:|---:|---:|
| 1 | 3 | `1/2` | `1/6` | `2/3` | 12 |
| 2 | 3 | `9/10` | `1/9` | `2/3` | 20 |
| 3 | 4 | `2/3` | `1/8` | `1/2` | 12 |
| 4 | 4 | `4/5` | `1/8` | `3/4` | 20 |
| 5 | 5 | `5/6` | `1/10` | `2/5` | 12 |
| 6 | 4 | `2/3` | `1/8` | `1/4` | 12 |

Os priors incluem `0`, `1/4`, `1/2`, `3/4`, `1` e, quando pertencentes a `[0,1]`, os pontos exatos de empate screening/exclusão e de igualdade do payoff esperado de H entre exclusão/pooling. Os limiares de votação e das propostas relevantes pertencem às grades escolhidas. Na configuração 6, `h=1/m` e `p=1/3` fornecem o empate residual entre exclusão e pooling: a busca recuperou ambos com payoff do proponente `2/3` e payoff esperado de H `1/6`.

Para a unanimidade terminal, foram enumerados pares de alocação de H e do proponente numa grade de denominador 60, com a massa restante atribuível aos fracos ou à sobra. Como todos os respondedores fracos aceitam parcelas não negativas, essa representação mantém todas as comparações relevantes do proponente nessa grade. Foram usados três pares de tipos e cinco crenças por par, incluindo endpoints e o corte exato `p*`.

| Verificação executada | Quantidade | Resultado |
|---|---:|---|
| Propostas factíveis majoritárias enumeradas nas seis configurações | 96.516 | Nenhuma divergência entre os objetos comparados. |
| Comparações por tipo em propostas majoritárias | 193.032 | Voto prescrito, aprovação e payoffs selecionados iguais. |
| Células majoritárias de otimização por configuração e prior | 42 | Ótimos da grade coincidem com (5) e o desempate; nenhum maximizador primário viola C3. |
| Células terminais unânimes por par de tipos e crença | 15 | Oferta e valor ótimos coincidem com (3)–(4). |
| Avaliações de pares de alocações terminais unânimes | 28.365 | Sem contraexemplo às comparações verificadas. |
| Ações de execução, incluindo escolhas inferiores | 30 | Nenhuma realiza dois componentes positivos; valor ótimo igual a `max{x_H,o}`. |

O processo terminou com código de saída `0` e lista de falhas vazia. Os totais são contagens de configurações e avaliações finitas, não uma prova de cobertura do contínuo. A disciplina de crenças e a correspondência global foram examinadas logicamente; não afirmo que essas propriedades tenham sido enumeradas pelo programa.

### Arquivos preservados

| Arquivo em `reviews/adversarial_evidence/` | SHA-256 |
|---|---|
| `check_exact.py` | `bb04f48830ab1997a380e7903c1d76fe1675c642177597fbe78026f7da76e3b6` |
| `results.json` | `9eca2bb4ad972687ca685862392905c7b4985a203bbe1385f163fcadf9f94086` |
| `execution_record.json` | `0e82d0caba5ec9179fdaa69da83a5698c565f8316364286009ad168837635f38` |

Comandos para reproduzir a execução preservada:

```sh
mkdir -p /private/tmp/pbp_adversarial_20260908_493f
python3 /Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/architecture_2026-09-08/reviews/adversarial_evidence/check_exact.py
```

O script preservado grava a nova execução em `/private/tmp/pbp_adversarial_20260908_493f/results.json`; não sobrescreve os outputs do candidato ou a cópia de evidência armazenada no repositório. O registro de execução informa versão, comando, contagens, código de saída observado e hashes.

## O que sobrevive ao escrutínio e fronteira do parecer

Sobrevivem o diagnóstico de incompletude, a incompatibilidade condicional de D2, a construção tecnológica de ausência de acúmulo em toda história, as comparações por tipo de H, as derivações terminais e majoritárias, a exclusão ótima delimitada e a projeção e extensão bidirecionais de C4. Sobrevivem também a distinção entre valor econômico transportado e objeto completo da agenda e o mapa das decisões substantivas ainda pendentes.

Não foi confirmado que a candidata possua um defeito por depender de A1–A3 ou de `T^Y`: esses são insumos expressos do resultado. O parecer não certifica plausibilidade empírica, adoção autoral, toda a caracterização histórica de B.4, todos os resultados da agenda ou uma formalização mecânica da correspondência contínua. Nada neste veredicto autoriza migração, tag, merge, push ou submissão.

Como decomposição para eventual formalização, as identidades de recebimentos, os limiares majoritários, a factibilidade da alternativa de C3 e as diferenças de (6) são objetos algébricos finitos. A equivalência de assessments exige antes representar histórias, estratégias e a disciplina própria de crenças; os testes de grade não substituem essa infraestrutura. Não foi executada formalização em Lean nesta revisão.

**Veredicto final para os bytes identificados: PASS — `critical=0`, `major=0`, `minor=0`.**
