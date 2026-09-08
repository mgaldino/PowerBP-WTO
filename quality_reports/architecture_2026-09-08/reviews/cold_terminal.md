# Auditoria fria da rodada terminal do baseline

Data: 2026-09-08. Revisor independente: `cold_terminal_review`. Escopo: reconstrução a partir das primitivas e decisões vigentes, antes de receber qualquer nova arquitetura candidata. Somente leitura do checkout; este relatório é o único arquivo salvo. Não certifica um candidato de arquitetura, não modifica o manuscrito e não resolve R1.

**Conclusão.** A rodada terminal de unanimidade é fechada pelas primitivas preservadas. Na maioria, a regra prescrita dos fracos fecha seus votos em toda proposta, a proposta ótima e seus valores antes do reconhecimento; isso independe do payoff de H no ramo “aprovação, H vota não”. A estratégia completa e o payoff de H nesse ramo não estão fechados pela correção de setembro. A incompletude não prova inexistência de equilíbrio nem impossibilidade de uma arquitetura econômica satisfatória. Prova apenas que os resultados remanescentes não suprem o payoff faltante.

## 1. Preflight e fontes exatas

Checkout: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion`.
Branch: `codex/exposition-items20-28`.
HEAD: `c2ed929ff992d4a85c76d3256845f44b09a14687`.
`git status --short` vazio no início e na conferência de hashes.

| Fonte | SHA-256 |
| --- | --- |
| `AGENTS.md` | `122a3a53047f9c8c3305a6d768c20687a5833287bf001420661f7fb7564f0098` |
| `quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md` | `873715a6848e2747d9d9e31234001c5d37a1c83cd622b0cafa85d4fd96e14a9f` |
| `quality_reports/agents_maintenance_2026-09-05/approval.md` | `c2b9c4d44918a39bd33007343dbf6de5c2c73676faceeaafc22c6bc55dd6306c` |
| `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` | `9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f` |
| `quality_reports/2026-09-01_decisao_structural_consistency_baseline.md` | `7e671effa200117228d837201a5151922c4fd014af93758de38616b04a8346d5` |
| `quality_reports/2026-09-01_decisao_exclusao_payoffs_e_fundamentos.md` | `5b165b65e3ade3ee1ff67c714fddbd35dd030b8e5b315b447132fd7f7c6e0982` |
| `quality_reports/plans/2026-08-12_essential_input_gate0.md` | `f5e0809bc1935dc8d386f5fcd9b1c6b387f563f95c95268c0f3b6b529c7cacc9` |
| `formal_model_v6.Rmd` | `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411` |

Hierarquia aplicada: `AGENTS.md:16–25,33–47` e `architecture_clarification.md:7–18`. O manuscrito continua especificando a regra histórica em `formal_model_v6.Rmd:340–348,366–368,1385–1397`; essas passagens documentam o jogo anterior, não substituem a obrigação de derivação vigente. A correção posterior de `approval.md:31–37` preserva explicitamente os pagamentos dos fracos, o pagamento de H quando vota sim e há aprovação, e o desacordo terminal. Não aprova soma de payoffs nem cria uma decisão pós-votação.

## 2. Contrato terminal reconstruído

Seja `p` o prior inicial, e `mu` a crença pública ao entrar no problema de R2. Não identificar automaticamente `mu` com `p`: uma história de R1 pode ter alterado a crença. Fixar instituição `g`, história pública, proponente reconhecido `i`, proposta pública `x` e, para a decisão de H, tipo `o`.

- Jogadores: H e `m >= 3` fracos; `o in {ell,h}`, com `0 < ell < h < 1`. Só H observa seu tipo.
- Proponente de R2: sorteio uniforme, independente, com reposição entre todos os `m` fracos. O proponente de R1 continua elegível.
- Propostas: `x_H >= 0`, `x_j >= 0`, `x_H + sum_j x_j <= 1`. Não há teto adicional para H.
- Proponente conta como sim. Os outros votos são simultâneos e revelados apenas ao fim do ballot.
- Maioria exige `k = floor((m+1)/2)` votos sim adicionais ao proponente; unanimidade exige todos.
- Se houver aprovação, todo fraco recebe exatamente sua alocação, inclusive se votou não. H recebe `x_H` se votou sim.
- Se houver rejeição em R2, todo fraco recebe zero e H recebe `o`, qualquer que tenha sido seu voto.
- Não existe continuação posterior a R2 nem desconto dentro de R2. O transporte para R1, quando legítimo, é `beta * C_2`, uma vez.
- No ramo de maioria com aprovação e voto não de H, a relação entre direito à alocação, participação e exercício da opção externa ainda requer fechamento econômico. Não usar o cancelamento ou a soma como preenchimento implícito.

Fontes: `formal_model_v6.Rmd:301–338,350–356`; `AGENTS.md:21–25,43–47`; `architecture_clarification.md:13–18`.

Apenas H observa seu tipo. Seu voto não pode condicionar no vetor simultâneo efetivamente realizado pelos fracos. Uma análise por contagem de votos fracos abaixo deve ser lida como comparação contra um perfil prescrito ou contrafactual fixo, não como nova informação disponível a H no ballot.

## 3. Votos dos fracos e aplicação de T^Y

O conceito aprovado prescreve aos fracos a comparação de valor esperado condicional à pivotalidade. Na rodada terminal, a diferença relevante para qualquer respondedor `j` é simplesmente

`Delta_j = x_j - 0 = x_j`.

A expressão é a mesma sob todo tipo de H e qualquer crença admissível. Se `x_j > 0`, o sim é prescrito por comparação estrita; se `x_j = 0`, o empate é exato e T^Y prescreve sim. Assim,

`a_j(x) = Y para todo x em X e todo fraco respondedor j`.

Isto vale em propostas no caminho e fora dele, sob maioria e unanimidade. O fato de um voto não ser efetivamente pivotal no perfil não autoriza veto: o refinamento foi escolhido precisamente como primazia da comparação pivotal. Quando o evento pivotal tem probabilidade zero sob o perfil puro, a interpretação operacional já aprovada é a comparação contrafactual de passagem contra falha; não se precisa construir aqui uma nova crença de tremble.

Fontes: Decisões 2 e 3 em `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md:20–35`; aplicação em `formal_model_v6.Rmd:1419–1423`; resultado delimitado em `architecture_clarification.md:54–60`.

**H tem disciplina distinta.** As-if-pivotal é imposto aos fracos, não a H. H escolhe a melhor resposta ao seu problema interino por tipo e T^Y seleciona sim somente se os payoffs relevantes forem iguais. H conhece `o`; não se faz uma média entre tipos na sua comparação. Fontes: decisão de agosto, linha 30; `formal_model_v6.Rmd:1419–1423`; cláusulas ainda compatíveis de Gate 0, linhas 587–606. A antiga fórmula aditiva nas linhas seguintes de Gate 0 não é vigente.

Não se pode substituir o payoff faltante por T^Y. “H é não pivotal” significa que seu voto não muda a aprovação; não significa que os dois votos necessariamente lhe dão a mesma utilidade.

## 4. H e a rodada terminal de maioria

Como todos os `m-1` respondedores fracos votam sim e `m-1 >= k` para `m >= 3`, qualquer proposta factível passa sob as respostas prescritas, independentemente de H.

Para localizar exatamente a lacuna, denote apenas por `G_o(I,x)` o valor ainda não determinado de H após aprovação com seu voto não e o perfil prescrito dos fracos. Este é um nome para uma célula em aberto, não uma primitiva proposta. Uma vez completamente definido esse valor, a regra de H naquele ballot seria

`H vota Y se e somente se x_H >= G_o(I,x)`,

com igualdade resolvida por T^Y. O limiar histórico `x_H >= o` só resulta quando se demonstra que `G_o(I,x)=o`. B.1 o obtém diretamente da regra histórica de cancelamento (`formal_model_v6.Rmd:1433–1437`); essa parte da prova não é certificação da arquitetura exigida em setembro.

Para tornar explícita a cobertura da árvore, fixe um perfil hipotético de votos fracos e seja `n` seu número de sim adicionais ao proponente:

| Perfil fixado de votos fracos | Consequência do voto de H | Comparação terminal de H |
| --- | --- | --- |
| `n >= k` | Passagem com Y e com N | `x_H` contra o payoff ainda aberto de `(A,N)` |
| `n = k-1` | Y aprova; N rejeita | Y se e somente se `x_H >= o` |
| `n <= k-2` | Falha com Y e com N | Ambos pagam `o`; T^Y seleciona Y |

Sob as respostas prescritas de R2 somente a primeira linha é o perfil do ballot. As outras linhas cobrem contrafactuais de votos, sem permitir que H observe esses desvios antes de agir. Elas não reabrem os votos prescritos dos fracos.

### 4.1 Proposta ótima e continuação dos fracos independem da célula aberta

A proposta `e_i` que dá `x_i=1` e zero a todos os demais passa pelos votos fracos e dá payoff 1 ao proponente. Qualquer proposta `x` passa e dá a ele `x_i <= 1`. A igualdade exige `x_i=1`, `x_H=0`, todos os outros `x_j=0` e exaustão da pie. Logo `e_i` é a única proposta ótima, qualquer que seja `mu`, o tipo verdadeiro de H ou a história pública anterior.

Mais explicitamente, se `x_H>0`, a alternativa formulada **antes** do ballot,

`x'_H=0; x'_i=x_i+x_H; x'_j=x_j para j diferente de i,H`,

é factível, mantém a soma, mantém todos os votos fracos e mantém aprovação em todo tipo, mesmo que H mude de voto. O ganho do proponente é exatamente `x_H>0`. Não há continuação nem compensação por risco. Isto é dominância estrita entre propostas; não é devolução posterior de uma parcela de uma proposta já aprovada. O mesmo raciocínio elimina pagamentos positivos a respondedores fracos, que continuam votando sim ao receber zero.

Consequentemente, antes do sorteio uniforme de R2, cada fraco tem valor `C^M_{2,j}=1/m`. Este componente é fechado e independente de crenças e da célula aberta de H. Fontes: `architecture_clarification.md:54–62`; a reconstrução acima não utiliza a comparação histórica de H em B.1.

O desempate entre propostas que minimiza o payoff esperado de H não é necessário aqui: a proposta maximizadora de payoff do proponente já é única.

### 4.2 Limite da conclusão sobre H na proposta ótima

`x_H=0` elimina a possibilidade de receber **alocação positiva** na proposta ótima. Isso não fornece sozinho uma tabela de payoffs para propostas positivas desviantes.

O resultado histórico “H vota não e recebe `o` em `e_i`” é compatível com a interpretação econômica de que H pode recorrer ao fórum externo quando não recebe nada do clube. Para exportá-lo como parte de uma interface formal completa, a arquitetura deve explicitar esse acesso e seu vínculo com os ramos terminais. Na leitura estritamente literal dos componentes que a correção posterior lista como preservados, a célula `(A,N)` não recebeu uma nova função de implementação; por isso esta auditoria não transporta silenciosamente `C^M_{2,H}=o` da regra revogada.

Esta observação é de precisão e escopo, não uma prova de que o resultado `o` em `x_H=0` esteja economicamente errado ou exija o mecanismo problemático de cancelamento positivo. Fechar esse caso pode ser simples, mas não fecha automaticamente `x_H>0`. De todo modo, a **estratégia completa** de H em propostas arbitrárias continua dependendo do ramo disputado.

## 5. Rodada terminal de unanimidade: reconstrução completa

Sob unanimidade, `(A,N)` é inalcançável pela própria quota, inclusive com desvios dos fracos. Todos os fracos têm o voto prescrito Y, e H é pivotal. Logo, para cada tipo, inclusive um tipo com posterior zero ainda mantido no domínio de estratégias,

`a_H(o,x)=Y se e somente se x_H >= o`.

No limiar `x_H=o`, as duas ações lhe dão exatamente `o` e T^Y seleciona sim. A origem desse limiar é aprovação `x_H` versus rejeição terminal `o`, ambos componentes preservados; não usa cancelamento.

Como todo respondedor fraco aceita zero, o proponente atribui zero a eles e compara:

- `x_H < ell`: rejeição pelos dois tipos e payoff zero;
- `ell <= x_H < h`: somente o tipo baixo aceita; o melhor ponto é `x_H=ell`, com payoff `(1-mu)(1-ell)`;
- `x_H >= h`: ambos aceitam; o melhor ponto é `x_H=h`, com payoff `1-h>0`.

Ofertas deliberadamente rejeitadas não são ótimas porque `h<1` permite payoff estritamente positivo. Valores positivos para fracos ou sobra não alocada reduzem o payoff em qualquer classe que possa ser ótima. A redução para `ell` ou `h` respeita a inclusão dos limiares por T^Y.

Defina `p*=(h-ell)/(1-ell)`, que pertence a `(0,1)`. A oferta ótima é

`y(mu)=ell se mu <= p*; y(mu)=h se mu > p*`.

No ponto `mu=p*`, ambas maximizam o payoff do proponente. A oferta baixa dá a H o vetor `(ell,h)` e expectativa `(1-mu)ell+mu h`, enquanto a alta lhe dá `(h,h)` e expectativa `h`. A diferença a favor de H na oferta alta é `(1-mu)(h-ell)>0`. Portanto, o **desempate de propostas** seleciona a oferta baixa; isso é uma regra diferente de T^Y.

Interface terminal derivada, em unidades de R2:

| Crença de entrada | Proposta e votos | Payoff de H por tipo `(ell,h)` | Valor de cada fraco antes de reconhecimento, pela crença corrente |
| --- | --- | --- | --- |
| `0 <= mu <= p*` | `x_H=ell`; fracos Y; H baixo Y, alto N | `(ell,h)` | `(1-mu)(1-ell)/m` |
| `p* < mu <= 1` | `x_H=h`; todos Y | `(h,h)` | `(1-h)/m` |

Na primeira linha, os valores fracos **condicionados no tipo verdadeiro** são `(1-ell)/m` se baixo e zero se alto; na segunda, `(1-h)/m` em ambos. A expectativa da tabela não deve ser confundida com esse vetor condicionado.

Fontes comparadas: `formal_model_v6.Rmd:544–569,1465–1475`; primitivas e regra de propostas em `formal_model_v6.Rmd:413–421`. Nenhum `beta` entra nessas fórmulas. Os jogos públicos coincidem com a coordenada de suporte de `mu=0` ou `mu=1`.

## 6. Crenças e tipos com probabilidade zero

A crença de entrada é mantida após uma proposta fraca, inclusive desviante. Em um ballot e sob perfil prescrito de H, existem duas coordenadas posteriores, `eta_Y` e `eta_N`; vetores que diferem somente em votos fracos usam a mesma coordenada. Usa-se Bayes se seu denominador sob a crença de entrada for positivo. Se for zero, a coordenada é livre dentro do suporte do **prior inicial**, localmente ao par ballot-voto; ballots diferentes podem usar valores livres diferentes.

Fontes: decisão operacional de setembro, linhas 16–18; Emenda 1a de agosto, linhas 39–55; `formal_model_v6.Rmd:1401–1417`.

- Se `0<p<1`, um posterior corrente `mu=0` ou `mu=1` não apaga o outro tipo do suporte inicial. Um voto atribuído apenas ao tipo com posterior corrente zero ainda gera denominador bayesiano zero; não identifica automaticamente aquele tipo. A crença continua livre em `[0,1]` na coordenada pertinente.
- Se `p=0`, todos os posteriores são zero; se `p=1`, todos são um. Não ressuscitar o tipo de prior zero.
- Uma garantia com probabilidade 1 sob `mu` não equivale a uma garantia para cada tipo factível. No interior do prior, um tipo com posterior zero pode alcançar a mesma história por seus próprios desvios anteriores. Deve-se conferir sua ação/payoff separadamente.
- O manuscrito também preserva coordenadas de payoff de tipos fora do suporte nos vetores comparativos (`formal_model_v6.Rmd:832–836`). Tais coordenadas não autorizam atribuir probabilidade positiva a um tipo impossível no endpoint; a equivalência pública se refere ao tipo no suporte.

Exemplo terminal que não exige o ramo disputado: sob unanimidade com `mu=0`, a oferta ótima é `ell`. O tipo alto, se mantido como coordenada factível fora do suporte corrente, rejeita, e a proposta fracassa para ele. Isso é permitido: a propriedade a demonstrar proíbe aprovação com seu não e alocação positiva, não a rejeição de toda oferta positiva. Sob maioria, a dominância de `x_H>0` vale ponto a ponto em ambos os tipos, independentemente de seu peso em `mu`.

Na rodada terminal os posteriores **após** o ballot não alimentam continuação. A disciplina de crenças ainda pertence a um assessment completo, mas não altera as comparações de unanimidade ou os valores fracos reconstruídos. Não se deve confundir essa irrelevância terminal com liberdade para introduzir uma atualização proibida. A escolha de proposta em unanimidade usa a crença **antes** do ballot, que é payoff-relevante.

## 7. Alcance exato da dominância ex ante e diagnóstico lógico

Resultados demonstrados sem completar o payoff disputado:

1. Em R2 de maioria, qualquer oferta positiva a H é estritamente subótima sob votos fracos prescritos; a proposta ótima é `e_i`, em toda história e toda crença.
2. A comparação pela transferência ex ante de `x_H` ao proponente é tipo a tipo e não exige rejeição certa de H. Se os fracos já aprovam, a resposta de H pode mudar sem alterar passagem nem o ganho estrito do proponente.
3. Sob unanimidade, aprovação com voto não de H é impossível pela quota, para toda proposta e todo vetor de votos. Ofertas de seleção de tipos com rejeição e falha permanecem disponíveis e podem ser ótimas.

O componente `C^M_{2,j}=1/m` explica a comparação fraca `x_j` versus `beta/m` registrada em `architecture_clarification.md:62–74`. Se em R1 ao menos `k` respondedores satisfazem esse limiar, a mesma transferência ex ante mantém seus votos e aprovação em ambos os tipos. Essa é a extensão delimitada do lema registrada na fonte. **Não** é uma solução completa de R1 nesta auditoria e não certifica sua IC de H: não foi importada uma interface terminal completa que feche todos os payoffs e estratégias de H.

A dominância não elimina da forma extensiva propostas desviantes. Exemplo: para `m=3`, escolher `0<epsilon<1`, `x_H=epsilon`, `x_i=1-epsilon` e zero aos dois respondedores fracos. Ambos têm voto prescrito Y; seus dois votos satisfazem `k=2`. O vetor com voto N de H aprova a proposta. Ele existe na árvore ainda que o proponente nunca o gere otimamente e ainda que H só possa gerar N por desvio sob determinada arquitetura. O exemplo estabelece a existência do **ramo com alocação proposta positiva**, não o recebimento efetivo simultâneo dos dois payoffs: este último depende justamente da implementação ainda em aberto.

Também não basta provar a exclusão de propostas subótimas em todos os conjuntos de informação: isso disciplina a escolha prescrita ao chegar a cada conjunto, sem remover suas outras ações. Em R1, um perfil de votos fracos desviante pode aprovar com H votando não uma proposta que dependeria de seu sim sob as respostas prescritas. Fonte: `architecture_clarification.md:76–82`; `AGENTS.md:51–55`.

Assim:

- **Provado:** a otimização do proponente não pode, sozinha, preencher os payoffs dos desvios nem apagar o ramo `(x_H>0,A,N)`.
- **Pendente:** como a economia implementa o pacote e permite exercer a opção externa nesse ramo, e como H responde a qualquer proposta sob esse mecanismo.
- **Não demonstrado:** que os fundamentos sejam logicamente incompatíveis ou que nenhuma arquitetura adicional possa satisfazê-los. Tampouco foi demonstrado que o jogo vigente possua uma região sem equilíbrio por causa dessa lacuna: sem completar utilidades, isso não é ainda uma afirmação bem definida sobre o novo jogo.
- **Rejeitado como inferência:** aproveitar B.1/B.3 para declarar todas as estratégias de H invariantes, ou chamar a ausência de propostas ótimas positivas de prova de ausência de acumulação em todo histórico.

## 8. Ledger, transporte e verificação

| Objeto | Estado nesta auditoria | Pode ser transportado |
| --- | --- | --- |
| Votos prescritos dos fracos em R2, toda proposta | `proved` | Sim, no fragmento que conserva seus pagamentos e o conceito aprovado |
| Maioria: proposta `e_i` e valores fracos `1/m` | `proved` | Como componente explicitamente parcial; não como interface completa de R2 |
| Maioria: voto de H não pivotal em propostas arbitrárias | `pending` | Não; depende do payoff de `(A,N)` |
| Maioria: `C^M_{2,H}=o` e a estratégia completa da interface histórica | `pending` quanto à certificação da nova arquitetura | Não importar por invariância presumida; verificar acesso ao fórum externo em `x_H=0` e cobrir separadamente propostas positivas |
| Unanimidade: estratégias, seleção de proposta e payoffs terminais acima | `proved` | Sim, dentro das primitivas preservadas; a revisão de candidato posterior deverá confirmar que ele as mantém |
| Bayes e endpoints após todo ballot | Regra `proved` por fonte normativa; valores específicos dependem do perfil de H | Preservar a regra e o suporte inicial, sem reusar automaticamente coordenadas de outro assessment |
| R1 completo, comparação institucional e rendas | Fora do escopo | Requerem interface completa apropriada e revisão de dependências |
| Ausência de acumulação em todos os desvios | `pending` | Não foi demonstrada por dominância ex ante |

Verificações executadas: leitura das fontes e emendas pertinentes; conferência de branch/HEAD/status; SHA-256 das fontes; reconstrução analítica das comparações, fronteiras e quotas; conferência do empate de propostas de unanimidade; separação entre posterior zero e prior zero. Não foram executadas simulações, recompilação do manuscrito, testes de código ou formalização Lean. Os argumentos universais acima são demonstrações analíticas no escopo declarado, não inferências de uma grade numérica.

Este relatório antecede a arquitetura candidata. Qualquer alteração posterior de payoffs, decisões, informação, regra de voto ou reconhecimento deve ser cotejada com ele antes de reutilizar as folhas terminais. Mudança no componente de H de maioria reabre seu voto e as interfaces que o consomem; mudança nos pagamentos fracos ou no seu refinamento também reabre a dominância, `1/m` e os limiares importados em R1.

Nota da conferência final: depois da redação, `git status --short` passou a listar `quality_reports/architecture_2026-09-08/` e `scripts/verify_architecture_20260908.R` como não rastreados. Não abri esses novos arquivos, preservando a independência da reconstrução fria. Os hashes de `AGENTS.md`, da clarificação de arquitetura e do manuscrito foram reconferidos e permaneceram idênticos aos do preflight; este revisor não realizou qualquer edição no checkout.
