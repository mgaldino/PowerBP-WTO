# Gate 0 — Arquitetura essential-input

**Data:** 2026-08-12
**Status:** `APPROVED` — aprovado pelo autor em 2026-08-12. Este contrato
incorpora o registro decisório do commit `162616d` e as decisões autorais
posteriores, inclusive as de 2026-08-17 sobre stage-undominated voting,
obrigações de prova e revisão e a de 2026-08-18 que torna o benchmark público
um nó terminal posterior ao congelamento do modelo principal, e a decisão de
2026-08-18 que impõe a restrição estrita da Seção 2, `o_1 < 1`. Decisão
autoral posterior prevalece sobre registro histórico incompatível. Essa mudança
de primitiva reabre o Gate 0 e devolve todos os nós a `pending`, conforme a
Seção 12. Depois de dois novos pareceres independentes `PASS 0/0/0` sobre este
mesmo contrato, a autorização autoral de 2026-08-18 permite reavaliar o Goal 1
exclusivamente para `N1`, `N2` e `N3`, seguindo integralmente os gates da
Seção 11. Esta autorização não alcança `N4`, `N6`, `N7`, o Goal 2 nem qualquer
migração para manuscrito.
**Substitui:** a cadeia `pivotal-response` (12 nós, commit `19c431a`) como arquitetura corrente.
**Alvo eventual:** `formal_model_v6.Rmd`, somente após derivação, revisão independente e migração controlada.

### Regra de fonte normativa única

Este arquivo é a **única fonte normativa corrente** da arquitetura
essential-input. Documentos decisórios anteriores são proveniência histórica:
servem para auditar como este contrato foi formado, mas não constituem uma
segunda autoridade sobre sua redação vigente.

Cada regra deste contrato tem **uma única fonte canônica**. Menções fora dessa
fonte servem apenas para explicar, usar o objeto já definido ou apontar para a
seção correspondente; não podem qualificá-lo, ampliá-lo nem criar exceções.

| Conteúdo normativo | Fonte única |
|---|---|
| status e autorização da fase | cabeçalho acima |
| estimando e escopo da comparação | Seção 1 |
| primitivas e factibilidade | Seção 2 |
| transições, informação e payoffs terminais | Seção 4 |
| conceito de solução | Seção 5 |
| unidades temporais e desconto | Seção 6 |
| nós, arestas e schema | Seções 7 e 7.2 |
| entregáveis e hashes das interfaces | Seção 8 |
| obrigações de prova | Seção 9 |
| materiais históricos que não podem ser transportados | Seção 10 |
| prontidão, congelamento, revisão, gates, findings e reporte | Seção 11 |
| invalidação | Seção 12 |
| fronteira de versão, verificação da infraestrutura e artefatos protegidos | Seção 13 |

---

## Leitura para aprovação — sem jargão

Esta seção explica a intuição para o autor. Ela não contém regras adicionais:
as definições e obrigações formais estão somente nas fontes indicadas acima.

### O que o paper quer mostrar

`H` constrói organizações por consenso porque, sob unanimidade, **ninguém pode
substituí-lo**. Sob maioria os fracos podem comprar o voto de outro fraco em vez
do dele, e isso põe um teto no preço que `H` consegue cobrar. Sob unanimidade o
teto some, e aí a informação privada de `H` — o quanto ele realmente precisa do
acordo — vira dinheiro.

O ponto não é que `H` tenha uma alternativa externa melhor. Isso só o protege.
O ponto é que a unanimidade transforma a informação privada dele em renda.

### As cinco decisões centrais, e o que observar

**1. Ninguém tem botão de saída.** A arquitetura anterior confundia votar não
com abandonar definitivamente a organização. Isso dava a `H` um privilégio que
os fracos não tinham e eliminava a possibilidade de rejeitar hoje e negociar
amanhã. O espaço de ações vigente está na Seção 4; a justificativa da escolha,
na Seção 3.

**2. A alternativa externa não pode distorcer o relógio.** O erro anterior
permitia que `H` acessasse sua alternativa numa data enquanto os fracos eram
avaliados noutra. A forma extensiva e os payoffs terminais estão na Seção 4; a
conversão entre datas, na Seção 6.

**3. O protocolo precisa lidar com falha coordenada.** Em votação simultânea,
vários weak states podem sustentar uma rejeição mesmo quando cada um aprovaria
se fosse decisivo. O conceito escolhido enfrenta essa patologia sem apagar a
assimetria substantiva entre `H` e os fracos. Seu escopo exato está somente na
Seção 5; o que ainda precisa ser demonstrado, na Seção 9.

**4. A aceitação na igualdade fecha o problema do proponente.** Sem uma regra
para indiferença, o melhor contrato pode virar apenas um ínfimo não atingido. A
definição e seu domínio estão exclusivamente na Seção 5.

**5. O bolo é mantido fixo para isolar o mecanismo.** É uma escolha menos
realista, mas impede que contribuição produtiva e renda informacional sejam
confundidas. A primitiva está na Seção 2; as alternativas descartadas, na
Seção 3.

### Como o trabalho é dividido, e o que checar em cada etapa

Resolve-se de trás para frente: a última rodada primeiro, porque a decisão de
hoje depende do que acontece amanhã.

**Goal 1 — nós terminais e R1 maioria.** Resolve `N1`, `N2` e `N3` conforme a
topologia da Seção 7 e testa as obrigações correspondentes da Seção 9.

**Goal 2 — o nó decisivo.** Resolve `N4` conforme as Seções 7, 9 e 11.

**Goal 3 — comparação.** Resolve `N6` no escopo definido na Seção 1 e entrega o
objeto especificado na Seção 8.

**Goal 4 — benchmark público.** Depois de congelado o modelo principal, resolve
`N7` e calcula as rendas informacionais sem alimentar de volta `N1`--`N6`.

**Goal 5 — manuscrito.** A migração segue exclusivamente os gates da Seção 11.

---

## 0. Por que esta arquitetura substitui a cadeia pivotal-response

A cadeia congelada em 2026-08-12 é internamente consistente, tem DAG `VALID`,
12 nós PASS e dois pareceres independentes `0/0/0`. Ela permanece válida **para
a especificação que revisou**. Deixa de descrever o jogo pretendido por três
razões, em ordem de gravidade.

**Primeira — assimetria de ação não justificada.** A primitiva de opt-out
imediato dá a `H` uma ação de saída irreversível que os weak states não têm
([pivotal_response_rederivation.Rmd:500](../../model_redesign/pivotal_response_rederivation.Rmd:500):
"No current or future agreement can include it after that action"). Sob maioria
o jogo demonstravelmente continua depois de um `não` de `H`, e o espaço de
contratos do proponente de R2 é truncado por decreto com base em um voto
passado. Nada na forma extensiva deriva essa restrição. Como consequência,
qualquer diferença de continuation value entre unanimidade e maioria fica
contaminada por um privilégio de ação, que não é nenhum dos canais de interesse.

**Segunda — o mecanismo dinâmico está eliminado por construção.** Sob a
primitiva da cadeia pivotal-response, `H` alcança R2 apenas votando sim.
Rejeitar termina o jogo.
O tipo baixo não pode rejeitar em R1 e esperar oferta melhor em R2. A opção de
atraso, que é a fonte de renda informacional dinâmica, não existe. Isso explica
por que o resultado de pooling da arquitetura atual coincide com o do jogo de
uma rodada de `@glynia2026unanimity`, já publicado e citado na lit review: as
duas rodadas acrescentaram condições de existência, não mecanismo.

**Terceira — a pergunta central fica sem resposta.** A cadeia entrega
correspondências set-valued que admitem pooling, separating e falha coordenada
simultaneamente. A pergunta do paper — a renda de `H` sobrevive a duas rodadas?
— não tem resposta num objeto que contém todos os cenários ao mesmo tempo.

As três se resolvem juntas. Nenhuma é reparo local; todas tocam a outcome
signature e o espaço de ações, logo exigem Gate 0 novo.

---

## 1. Pergunta de pesquisa e condição de falsificação

**Pergunta.** Por que um hegemon despenderia esforço para construir organizações
internacionais por consenso em vez de maioria?

**Resposta candidata.** Sob maioria, `H` é insumo **substituível**: o proponente
pode comprar um voto fraco em vez do dele, e o preço de `H` fica limitado por
cima pelo custo do substituto. Sob unanimidade, `H` é insumo **essencial**: não
há substituto, o teto some, e o preço passa a ser determinado pelo limiar
privado de `H`. Informação privada só vira renda quando o limiar não tem teto.
`H` paga por consenso para eliminar o substituto, não para proteger `o_theta`.
Toda comparação do baseline é condicional à organização existir sob as duas
regras; a decisão de formação não integra este jogo.

**Duas perguntas que a derivação deve responder:**

1. **Delay.** Existe atraso em equilíbrio, e ele é dependente da regra?
2. **Sobrevivência e diferença institucional da renda.** Para cada tipo, qual é
   a renda informacional sob unanimidade, qual é a renda informacional sob
   maioria e qual é a diferença entre as duas?

**Estimando da renda informacional.** Para cada regra institucional
`g in {U,M}`, seja `V_g^priv` o conjunto dos vetores de payoff de `H` por tipo,
`(U_H(0),U_H(1))`, gerados pela correspondência completa de equilíbrios do jogo
com informação privada. Seja `V_g^pub` o conjunto análogo obtido combinando os
equilíbrios dos jogos em que cada tipo é público desde `t=0`, mantendo todas as
demais primitivas e o protocolo idênticos. A correspondência de renda sob a
regra `g` é a diferença componente a componente
`RI_g = {v_priv - v_pub: v_priv in V_g^priv, v_pub in V_g^pub}`. Há, portanto,
duas rendas potencialmente distintas, `RI_U` e `RI_M`, e o contraste
institucional é a diferença das diferenças
`DeltaRI = {r_U - r_M: r_U in RI_U, r_M in RI_M}`.

**Existência separada por regra.** A existência de `RI_M` e de `RI_U` é
avaliada separadamente. Se `V_g^priv` ou `V_g^pub` for vazio, `RI_g` é vazio;
isso não apaga a renda da outra regra. `DeltaRI` é vazio quando `RI_M` ou
`RI_U` for vazio, pois somente o contraste exige as duas regras. Não se declara
ordenação institucional robusta numa região em que `DeltaRI` seja vazio. As
interfaces de `N6` e `N7` preservam esses três estados separadamente conforme a
Seção 7.2, sem campos opcionais nem registros parcialmente preenchidos.

Quando os jogos são payoff-únicos, esses conjuntos são singletons e, para cada
tipo, a definição se reduz a
`RI_g(theta) = U_H^priv(theta,g) - U_H^pub(theta,g)`. Se houver multiplicidade
com payoffs distintos, `N7` reporta os conjuntos exatos e seus envelopes
inferior e superior, sem preencher lacunas de um conjunto não convexo e sem
selecionar um equilíbrio ad hoc. Para um tipo `theta`, a conclusão
`RI_U(theta) > RI_M(theta)` só é robusta se a coordenada `theta` for positiva
em todo vetor de `DeltaRI`. `N7` reporta também a imagem ex ante de cada
conjunto, aplicando o mesmo prior `mu` a cada vetor, e só declara a ordenação ex
ante robusta se todos os valores dessa imagem tiverem o mesmo sinal. O campo
que carrega o contrafactual existe somente na interface terminal de `N7`,
definida na Seção 7.2; a obrigação de resolvê-lo por ramos está somente em P8,
na Seção 9. A renda nunca é definida pelo excesso sobre `o_theta`.

**Fronteira entre modelo principal e estimando.** `N1`, `N2`, `N3`, `N4` e `N6`
resolvem, comparam, revisam e congelam exclusivamente os jogos com informação
privada. O benchmark público não é argumento, continuação nem saída obrigatória
desses nós. `N7` só é aberto depois do congelamento de `N6`: deriva os jogos
públicos e combina seus payoffs com os registros privados congelados. Resultado,
multiplicidade ou inexistência no benchmark não altera o modelo principal; a
única exceção é um finding que demonstre erro em uma fonte compartilhada do
contrato, caso regido pela Seção 12.

**Benchmark público e delay.** Qual ramo prevalece no jogo com `theta` público
é resultado, não parte da definição do estimando. P8 é a única fonte da
obrigação de caracterizar a correspondência completa do benchmark e testar a
conjectura de equivalência necessária para usar qualquer medida simplificada.
A existência de separating e de atraso é testada por P3 sob o conceito da
Seção 5.

**Candidato substantivo, não premissa.** A decisão do autor antecipa que a
inexistência de separating fará a opção de espera gerar o componente de payoff
`beta*(o_1-o_0)` para todo prior mesmo sem atraso realizado. `N4` deve derivar
ou refutar esse componente no jogo privado; somente `N7` testa se ele coincide
com renda informacional no sentido contrafactual acima.

**Prior do autor e desfechos, registrados antes de derivar.** A prior do autor é
que o tipo privado permite extração de renda. Registrada aqui para que a
surpresa, se houver, seja informativa.

Os dois desfechos são informativos, e nenhum é fracasso:

- **Se a renda existir**: informação privada sob pivotalidade é o que explica a
  preferência por unanimidade, e o paper tem a contribuição pretendida.
- **Se todo equilíbrio separar**, revelando os tipos, de modo que `H` receba
  apenas função de `o_theta`: então **não é a informação privada que explica a
  preferência por unanimidade**. A unanimidade estaria apenas protegendo a
  opção externa de `H`, e o mecanismo teria que ser procurado em outro lugar.
  Isso é achado substantivo sobre o objeto, e o autor declara esperar
  surpreender-se com ele.

**Compromisso operacional.** Qualquer que seja o desfecho, ele é reportado como
saiu. Não é permitido ajustar primitiva, protocolo ou conceito de solução para
mudar o resultado depois de vê-lo. Qualquer mudança segue exclusivamente a
regra de invalidação da Seção 12.

---

## 2. Primitivas

```text
Jogadores      H mais m = N-1 weak states, N >= 3 genérico
Tipo           theta in {0,1}, prior mu = Pr(theta=1); observação na Seção 4
Pie            surplus institucional fixo, normalizado em 1
Pacote         alocação s = (y, (x_j)_{j in W sem i}, r_i), com
               0 <= y <= y_bar, x_j >= 0, r_i >= 0 e
               y + sum_j x_j + r_i <= 1; y é destinado a H
Benefício      b_theta = 0
Desacordo      weak state: 0; H: o_theta externo à pie, com
               0 < o_0 < o_1 < 1 e o_1 <= y_bar <= 1
Agenda         pi_H = 0 em toda rodada; só weak states propõem
Reconhecimento sorteios iid com reposição, uniformes entre os m weak states;
               todos seguem elegíveis em R2, inclusive o proponente de R1
Side payments inexistentes
Desconto       beta in (0,1]
Rodadas        duas; R2 terminal
```

`o_theta` é primitivo. Mapeamentos como `o_theta = alpha V(theta)` pertencem a
aplicação, ilustração numérica ou microfundamento, e não são impostos.

A opção externa de `H` não entra na restrição de factibilidade da pie. A função
de implementação e todos os payoffs terminais estão definidos exclusivamente na
Seção 4; sua comparação entre datas segue a Seção 6. A desigualdade no conjunto
factível não pode ser substituída por igualdade antes da prova P0 da Seção 9.

---

## 3. Decisões de desenho

Esta seção registra a razão das escolhas e as alternativas descartadas. A
especificação formal correspondente permanece exclusivamente nas Seções 2,
4, 5 e 6.

### Decisão: espaço de ações no ballot

- **Escolha**: o espaço de ações definido na Seção 4.
- **Alternativas descartadas**:
  - *Opt-out imediato e irreversível de `H` (arquitetura pivotal-response)*:
    descartada porque dá a `H` um privilégio de ação que `W` não tem,
    contaminando a comparação entre regras com um canal que não é nem opção
    externa nem informação privada; e porque elimina a opção de atraso, que é o
    mecanismo dinâmico buscado.
  - *Três ações para `H` — sim, não, sair*: descartada porque torna o
    confundimento explícito em vez de removê-lo. A assimetria de privilégio
    permanece, apenas nomeada.
  - *Ação de saída para todos os jogadores*: descartada porque para weak states
    com payoff de desacordo zero a saída é redundante com votar não, e
    acrescenta ramos sem conteúdo.

### Decisão: estatuto de `o_theta`

- **Escolha**: a natureza externa definida na Seção 2, a realização terminal da
  Seção 4 e o tratamento entre datas da Seção 6.
- **Alternativas descartadas**:
  - *`o_theta` disparado imediatamente pelo voto `não` de `H` em R1, mesmo sem
    o jogo terminar*: descartada porque cria uma assimetria de timing — `H`
    acessaria sua opção externa enquanto os fracos seguiriam para continuações
    descontadas. Se uma proposta passa sem `H` em R1, `o_theta` é corrente
    porque o jogo terminou para todos, não porque o voto `não` seja um opt-out.
  - *Híbrido `max{o_theta, beta*C_theta}`*: descartada como primitiva porque
    passa a ser **consequência** do desenho simétrico, não suposição. Se `H`
    tem valor de continuação superior, isso aparece na IC; não precisa ser
    imposto.

As consequências para maioria não são decisões de desenho. Elas estão
exclusivamente nas obrigações P1, P1a e P2 da Seção 9.

### Decisão: ganho estrito factível para os weak states

- **Escolha**: a restrição estrita de `o_1` definida exclusivamente na Seção 2.
  Mesmo quando `H` é do tipo alto, o pacote `y=o_1` satisfaz seu limiar em R2
  e deixa residual estritamente positivo `1-o_1` para os weak states. A
  restrição é uma condição de escopo sobre ganhos factíveis de acordo; não
  transforma a opção externa de `H` em parcela da pie.
- **Fronteira excluída**: `o_1=1`. Nessa fronteira, quando o tipo alto é certo,
  pagar seu limiar deixa payoff zero ao proponente, enquanto rejeitar também
  lhe dá zero. O problema terminal perde a comparação estrita que disciplina
  a proposta e admite multiplicidade degenerada, inclusive propostas com
  folga. A decisão autoral exclui esse caso de ganho residual nulo.
- **Alternativa descartada**: impor que toda crença sobre o tipo alto seja
  estritamente menor que um. Restringir apenas a prior não impediria posterior
  igual a um após uma ação reveladora; restringir todos os posteriores
  limitaria a aprendizagem bayesiana e alteraria o mecanismo informacional.
  Por isso o domínio de crenças permanece o definido nas Seções 1, 4, 5 e 7.2.

### Decisão: conceito de solução no ballot

- **Escolha**: o conceito definido exclusivamente na Seção 5, conforme decisão
  do autor em 2026-08-17.
- **Alternativas descartadas**:
  - *PBE sem restrição de votação (arquitetura pivotal-response)*:
    descartada porque admite equilíbrios de falha coordenada em que dois ou mais
    fracos votam não apesar de preferirem estritamente sim condicional a serem
    pivotais. Isso destrói unicidade em `N >= 4` e torna as perguntas 1 e 2 da
    Seção 1 não respondíveis. Baron & Ferejohn (1989), base do modelo, excluem
    exatamente esses equilíbrios.
  - *`T^Y` como substituto da undominância dos weak nonproposers*: descartada
    porque `T^Y` seleciona entre melhores respostas realmente empatadas, mas não
    elimina uma ação fracamente dominada quando há comparação estrita contra
    algum perfil relevante. Esta é a resolução da pendência registrada em
    `quality_reports/2026-08-05_goal3_accept_at_equality_pending.md`.
  - *Stage-undominated voting aplicado também a `H`*: descartada porque, sob
    execução integral, a linha não pivotal é estruturalmente diferente para
    `H`, conforme a Tabela 1. Um weak nonproposer recebe `x_j` com qualquer
    voto quando a proposta passa sem ele; `H` recebe `y` votando `sim` e
    `y+o_theta` votando `não` quando a proposta passa sem seu voto. Em uma
    igualdade na linha pivotal, essa linha não pivotal pode fazer `não`
    fracamente dominar `sim` para `H`, em conflito com a aceitação na igualdade.
  - *Eliminação ordenada weak-first e depois `H`*: descartada porque seria uma
    seleção lexicográfica adicional. Eliminação iterada de dominância fraca é
    dependente da ordem em geral, e a continuação após vetores off-path de R1
    impede tratar a prioridade weak-first como consequência automática das
    primitivas. A ordem não será inserida dentro de uma derivação.

### Decisão: a pie não depende de `H`

- **Escolha**: a pie e a factibilidade definidas exclusivamente na Seção 2;
  implementação e payoffs conforme a Seção 4. Decisão do autor em 2026-08-12.
- **Alternativas descartadas**:
  - *Pie dependente do tipo, `V(theta) in {1,r}` (arquitetura de 2026-04-19)*:
    descartada porque, embora mais rica e embora fosse o que sustentava o
    screening cross-round naquela versão, ela mistura duas fontes de vantagem
    para `H` — o valor que ele traz e a renda informacional da pivotalidade — e
    impede isolar a segunda, que é o objeto do paper.
  - *Pie dependente da inclusão, acordo sem `H` vale menos*: descartada pela
    mesma razão. É substantivamente mais realista para OPEP e OMC, e tornaria a
    exclusão sob maioria custosa em vez de gratuita, mas contamina o contraste
    entre as regras com um canal produtivo.
  - *Fator `(1-alpha)` sobre o pie na exclusão*: descartado por ser erro
    contábil, identificado por parecerista e corrigido em 2026-05-10. A opção
    externa de `H` é externa à pie e não é paga pela coalizão fraca.
- **Extensão futura, outro paper**: reintroduzir a contribuição produtiva de
  `H`. O intervalo interessante é aquele em que `H` agrega o suficiente para ser
  desejado sob maioria mas não o bastante para valer seu preço, e aí o contraste
  passa a depender de condição de magnitude em vez de ser automático. Fora do
  escopo do paper presente.

### Decisão: número de rodadas

- **Escolha**: o horizonte da Seção 2 e as transições da Seção 4.
- **Alternativas descartadas**:
  - *Uma rodada*: descartada porque o resultado estático de screening já está
    publicado em `@glynia2026unanimity`, e porque não permite responder se há
    delay nem se a renda sobrevive à dinâmica.
  - *Horizonte infinito ou muitas rodadas*: descartada porque entra em dinâmica
    coasiana, em que a incapacidade de compromisso do proponente colapsa a renda,
    e porque duas rodadas é a estrutura mínima que gera a opção de espera. O
    horizonte finito é a justificativa formal para o número de rodadas, além do
    apelo ao realismo da negociação multi-rodada.

---

## 4. Forma extensiva

Idêntica sob as duas regras, variando apenas a quota `q`: `q = N` sob
unanimidade, `q = floor(N/2)+1` sob maioria.

```text
t=0   Natureza sorteia theta; H observa; mu é comum
t=1   Reconhecimento de um weak state i conforme a Seção 2
      i propõe uma alocação s factível conforme a Seção 2
      Ballot simultâneo e selado de todos os não proponentes, inclusive H;
        i conta como sim
      Fecha o ballot; o vetor completo de votos e o resultado tornam-se públicos
      Se os sim atingem q: a alocação proposta é implementada, todos são pagos
        nessa data e o jogo termina
      Se não: segue para t=2
t=2   Novo reconhecimento conforme a mesma lei da Seção 2
      Proposta, ballot simultâneo e selado, publicação
      Se os sim atingem q: a alocação proposta é implementada, todos são pagos
        nessa data e o jogo termina
      Se não: o jogo termina com 0 para cada weak state e o_theta para H
```

**Implementação e inclusão.** Uma alocação aprovada é executada integralmente,
exatamente como votada. Não há destruição nem realocação ex post; pagamentos
laterais são excluídos pela Seção 2. O voto de `H` determina se ele integra o
acordo, não se a coordenada `y` é executada. Em toda aprovação, `y` é o valor
destinado a `H` na proposta efetivamente votada e pode ser zero. A aprovação
implementa esse `y`; `o_theta` é acrescido somente quando `H` vota `não` e fica
fora do acordo. Assim, na segunda linha da Tabela 1, se a proposta fixa `y=0`,
`H` recebe apenas `o_theta`. A Tabela 1 é a fonte completa dos payoffs e das
datas em cada resultado possível.

**Tabela 1. Payoffs e datas por resultado do ballot**

| Resultado | `H`, tipo baixo | `H`, tipo alto | Proponente `i` | Cada weak nonproposer `j` |
|---|---|---|---|---|
| Proposta aprovada com `H` — possível sob maioria e unanimidade | `y`, na data da aprovação | `y`, na data da aprovação | `r_i`, na data da aprovação | `x_j`, na data da aprovação |
| Proposta aprovada sem `H` — possível sob maioria; **inalcançável sob unanimidade** | `y+o_0`, na data da aprovação | `y+o_1`, na data da aprovação | `r_i`, na data da aprovação | `x_j`, na data da aprovação |
| Falha em R1 — história não terminal | Nenhum pagamento; o jogo não terminou e segue para R2 | Nenhum pagamento; o jogo não terminou e segue para R2 | Nenhum pagamento; o jogo não terminou e segue para R2 | Nenhum pagamento; o jogo não terminou e segue para R2 |
| Falha em R2 — história terminal | `o_0`, na data terminal de R2 | `o_1`, na data terminal de R2 | `0`, na data terminal de R2 | `0`, na data terminal de R2 |

A linha de falha em R1 registra uma transição, não um payoff corrente:
pagamentos só existem quando o jogo termina. A lei de reconhecimento é a
primitiva da Seção 2.

**Publicidade.** O jogo é sequencial e público **entre rodadas**. Dentro de cada
ballot os votos são simultâneos e selados, e os votos individuais só se tornam
públicos após o fechamento. Isso **não** é roll-call. Nenhuma ordem de votação e
nenhuma posição de `H` no ballot.

**Conjuntos de informação.** Weak states nunca observam `theta`. `H` observa
`theta` desde t=0. A história pública completa de R1 — proposta, vetor de votos
e resultado — induz o posterior `nu'` na entrada de R2. Se `(regra, nu')` basta
para representar o problema de R2 é exatamente a obrigação P5. Como `H`
permanece sempre ativo, não existe estado `weak-only`: os três nós de R2 da
arquitetura anterior colapsam em dois, um por regra.

**Resultados ainda não disponíveis.** A suficiência do posterior, o uso
integral da pie, a dominância do hedge, a ausência on-path de aprovação sem `H`
com `y>0` e a não informatividade das ações fracas são exclusivamente as
obrigações P0, P1, P1a, P4 e P5 da Seção 9. Esta seção não as assume nem as
demonstra.

---

## 5. Conceito de solução

**Base.** Perfect Bayesian equilibrium com estratégias **puras em todo
ballot**; mixed strategies de voto não são admissíveis em nenhuma rodada.
Crenças on-path por Bayes. Em propostas de probabilidade zero, a crença de
ballot é componente explícito do assessment e não é restringida por Bayes; o
proponente desviante avalia seu desvio com a distribuição verdadeira
pré-proposta.

**Refinamento — stage-undominated voting apenas para weak nonproposers.** Em
cada ballot, tomando como dados os valores de continuação induzidos pelo próprio
assessment, a ação prescrita para cada weak nonproposer não pode ser fracamente
dominada no stage game daquele ballot. Uma ação `a_j` é eliminada quando existe
`a'_j` que dá ao weak state payoff interim pelo menos igual contra todo perfil
dos demais votos e estritamente maior contra algum. O refinamento não se aplica
ao proponente, que não vota, nem a `H`.

Isto é refinamento de PBE implementado como **restrição de estratégias dos weak
nonproposers**, não de crenças. Não pertence à família sequential equilibrium /
D1 / intuitive criterion. É condição de ponto fixo: o assessment é admissível
se, em cada information set de ballot de um weak nonproposer, a ação prescrita é
não dominada no stage game induzido por aquele mesmo assessment. PBE continua
impondo racionalidade sequencial a todos os jogadores, inclusive `H`.

**Teste terminal do refinamento.** A Tabela 1 induz, em R2, a seguinte
comparação para o weak nonproposer `j`:

```text
perfil dos outros                 sim      não
j é pivotal                       x_j      0
quota passa mesmo sem j           x_j      x_j
quota falha mesmo com j           0        0
```

As relações de dominância e igualdade sugeridas por essa tabela, bem como sua
consequência para falha coordenada, pertencem à obrigação P6 da Seção 9 e devem
ser estabelecidas em `N1` e `N2`. Nenhum resultado de nó é declarado aqui. A
comparação terminal não pode ser transportada para R1 sem considerar as
continuações.

**Teste dinâmico do refinamento.** Quando uma proposta de R1 falha, o vetor
completo de votos torna-se público. Para um perfil `v_{-j}` dos demais votos, a
tabela relevante é:

```text
perfil dos outros                 sim                         não
j é pivotal                       x_j                         beta*C_j(h^não)
quota passa mesmo sem j           x_j                         x_j
quota falha mesmo com j           beta*C_j(h^sim)             beta*C_j(h^não)
```

As histórias públicas `h^sim` e `h^não` podem induzir crenças e continuações
distintas, sobretudo fora do caminho. Portanto não se pode substituir essa
tabela por uma única continuação sem antes demonstrar que as histórias induzem
o mesmo valor. P6 é a fonte única do teste e das consequências a reportar em
`N3` e `N4`.

**Convenção de igualdade — `T^Y`.** Depois de impor racionalidade sequencial e,
para weak nonproposers, a restrição de stage-undominance, `T^Y` seleciona `sim`
quando os payoffs interim de `sim` e `não` são exatamente iguais no information
set relevante. A regra vale para todos os votantes e nas duas rodadas, inclusive
quando o valor de continuação é endógeno ao próprio assessment. Com a restrição
a estratégias puras, ela exclui mistura no ballot. Sua função é fechar o
conjunto de ofertas aprováveis, garantir máximos e evitar argumentos de epsilon
e ínfimos não atingidos. Uma igualdade em apenas uma linha da tabela não aciona
`T^Y` se o problema relevante do votante contém uma preferência estrita.

```text
weak nonproposer -> PBE + stage-undominance; em indiferença genuína, T^Y
H                -> PBE; em indiferença genuína, T^Y
```

**Aplicação da Tabela 1 a `H`.** Stage-undominated voting **não se aplica a
`H`**. Sua ação
deve ser uma melhor resposta sequencial no assessment. Se os payoffs das duas
ações forem iguais, `T^Y` seleciona `sim`; se forem distintos, PBE seleciona a
ação de maior payoff.

Sob maioria, a IC de `H` deve preservar o ramo em que ele não é pivotal. Se a
proposta passa qualquer que seja seu voto, `sim` paga `y`, enquanto `não` paga
`y+o_theta`; como `o_theta>0`, `não` é estritamente melhor. A origem do conflito
de protocolo agora resolvido é estrutural: um weak nonproposer não pivotal
recebe `x_j` com qualquer voto, mas `H` não pivotal tem acesso adicional a
`o_theta` ao ficar fora do acordo. Com estratégias puras, a pivotalidade de `H`
no caminho deve ser derivada da proposta e das estratégias dos weak states. O
termo `y+o_theta` não pode ser apagado dos perfis fora do caminho nem da
construção da IC de `H`.

**Tie-break no nível da proposta.** Entre propostas que maximizam o payoff do
proponente, seleciona-se a que minimiza o payoff esperado de `H`. Esta seleção é
distinta de `T^Y`, que governa a resposta no ballot, e é conservadora em relação
ao resultado de interesse.

**Nenhum assessment passivo adicional.** A expressão `weak-vote-passive
assessment` pode nomear somente o lema se ele for provado; ela não acrescenta
uma suposição nem um refinamento ao conceito desta seção. O escopo on-path e o
tratamento separado das crenças off-path estão exclusivamente em P4, na Seção
9.

---

## 6. Timing do desconto

R2 é terminal e resolve-se inteiramente em unidades correntes, sem `beta`
interno. `beta` incide **exatamente uma vez**, quando um valor de R2 entra numa
comparação de incentivos de R1. Se o jogo termina por aprovação em R1, todas as
parcelas do payoff dessa história — inclusive `y` e `o_theta` quando `H` fica
fora — são pagas na data de R1. Se continua, não há pagamento em R1; todos os
payoffs de R2 entram na avaliação de R1 multiplicados uma única vez por `beta`.
Nenhum jogador recebe em data diferente dos demais na mesma história terminal.

---

## 7. Ordem de derivação

A tabela abaixo define somente os nós e as dependências. Ela não antecipa
resultados. As obrigações substantivas estão exclusivamente na Seção 9.

| Nó | Subjogo ou operação | Dependências | Função arquitetural |
|---|---|---|---|
| `N1` | R2 maioria | nenhuma | resolver o nó terminal e exportar a interface da Seção 7.2 |
| `N2` | R2 unanimidade | nenhuma | resolver o nó terminal e exportar a interface da Seção 7.2 |
| `N3` | R1 maioria | `N1` | resolver R1 consumindo somente a interface congelada de `N1` |
| `N4` | R1 unanimidade | `N2` | resolver R1 consumindo somente a interface congelada de `N2` |
| `N6` | comparação privada | `N3`, `N4` | comparar o modelo privado entre regras e congelar a cadeia principal |
| `N7` | benchmark público e renda | `N6` | depois de congelado `N6`, derivar os jogos públicos e calcular `RI_U`, `RI_M` e `DeltaRI` |

`N1` e `N2` são mutuamente independentes. `N3` e `N4` não consomem um ao
outro. `N7` é consumidor terminal: nenhum nó do modelo principal depende dele.
A prontidão para consumo e a cadência de revisão são definidas somente na
Seção 11.

---

### 7.1 Estrutura de goals

O DAG é construído **antes** de qualquer derivação, não depois. Um DAG post hoc
descreve o que foi feito; um DAG a priori restringe o que pode ser feito. O hash
torna mudanças de interface detectáveis; suas consequências são definidas
somente na Seção 12.

```text
Goal 0  Contrato e infraestrutura
        Fechar o contrato e representar no DAG os seis nós N1, N2, N3, N4,
        N6 e N7, as arestas e os schemas da Seção 7.2.

Goal 1  Nós baratos — N1, N2, N3
        N1 e N2 podem ser resolvidos em paralelo. Quando N1 estiver apto a ser
        consumido, resolver N3. Seguir a Seção 11 para revisão e avanço.

Goal 2  Nó caro — N4
        Resolver N4 a partir da interface congelada de N2. As obrigações a
        testar estão na Seção 9; o tratamento especial da revisão, na Seção 11.

Goal 3  Comparação privada — N6
        Resolver N6 a partir das interfaces congeladas de N3 e N4, revisar a
        integração e congelar o modelo principal.

Goal 4  Benchmark público e renda — N7
        Somente depois de N6 congelado, resolver os jogos públicos, calcular as
        rendas da Seção 1 e congelar N7 sem alimentar de volta o modelo
        principal.

Goal 5  Migração para formal_model_v6.Rmd
        Seguir o gate de migração da Seção 11.
```

O DAG registra a topologia desta seção. Os entregáveis e hashes estão na Seção
8; prontidão e congelamento, na Seção 11; invalidação, na Seção 12. Camadas
adicionais de release ou manifestos da cadeia anterior não integram esta
arquitetura.

### 7.2 Schemas de interface

Fixar os objetos consumidos **agora**, antes de derivar, evita congelamento
prematuro e seleção silenciosa entre continuações. Payoffs, estratégias,
crenças e outcomes do mesmo equilíbrio permanecem no mesmo registro atômico;
projeções marginais nunca podem ser recombinadas para fabricar um equilíbrio.
Os nomes de campos abaixo são espelhados no DAG e verificados pela Seção 13.

**Envelope comum de cobertura.** Toda coleção que representa uma
correspondência usa `coverage_cell_v1`. Em Gate 0, a coleção inteira é `null`.
Depois de PASS, ela é uma lista não vazia de células mutuamente exclusivas e
exaustivas do domínio declarado. Cada célula contém:

```text
cell_id
domain_conditions
existence_status: exists | none
<campo de registros próprio da família>
nonexistence_certificate
```

O `cell_id` é único dentro da coleção. Se `existence_status = exists`, o campo
de registros próprio da família é uma lista não vazia e
`nonexistence_certificate` é `null`. Se `existence_status = none`, esse campo é
uma lista vazia e o certificado é obrigatório, com
`ledger_claim_ids`, `assumptions_used` e `checks_performed`; os IDs do ledger
não podem ser vazios. A célula vazia registra a inexistência demonstrada sem
inventar um equilíbrio-sentinela. O mesmo envelope preserva regiões sem
comparação ou sem renda quando uma fonte necessária inexiste. A interface
continua sendo um objeto não vazio e pode ser revisada e congelada depois da
prova de inexistência.

**Nós de equilíbrio privado `N1`--`N4`.** A interface é função da crença de
entrada e usa o schema `equilibrium_correspondence_v1`. Em Gate 0,
`correspondence_cells` é `null`. Em cada célula, o campo próprio é
`equilibrium_records`; cada registro contém conjuntamente:

```text
equilibrium_id
admissibility_conditions
branch_classification
strategy_profile
belief_system
source_continuation_record_ids
source_interface_hashes
existence_uniqueness_status
selection_status
assumptions_used
checks_performed
recognized_proposer_payoff
weak_nonproposer_pre_recognition_expected_value
hegemon_payoff_by_type: theta_0, theta_1
outcome_distribution: pass_with_hegemon, pass_without_hegemon, failure, delay
payoff_date
```

O `equilibrium_id` é único dentro do artefato e identifica o mesmo objeto em
todo o ledger. `payoff_date` declara as unidades nativas da interface; desconto
para o predecessor segue somente a Seção 6. Nos nós terminais, os campos de
fonte de continuação são vazios; em `N3` e `N4`, identificam os registros e o
hash exatos de `N1` ou `N2` consumidos pelo equilíbrio.

**Comparação privada `N6`.** A interface usa
`private_information_comparison_v1`. Em Gate 0, todas as coleções abaixo são
`null`:

```text
private_rule_cells:
  majority
  unanimity
comparison_cells
```

`private_rule_cells` preserva cada regra antes de compará-las. Em cada célula,
o campo próprio é `private_rule_records`; cada registro contém conjuntamente:

```text
private_rule_record_id
institution
admissibility_conditions
source_equilibrium_cell_id
source_equilibrium_id
source_interface_hash
private_payoff_vector: theta_0, theta_1
private_outcome_distribution: pass_with_hegemon, pass_without_hegemon, failure, delay
selection_status
checks_performed
```

Cada `private_rule_record_id` é único no artefato e corresponde exatamente a um
registro de `N3` quando `institution = majority` ou de `N4` quando
`institution = unanimity`, preservando sua célula, ID e hash. Cada registro de
origem aparece exatamente uma vez na coleção de sua regra. Uma célula `none` de
uma regra não altera a coleção da outra.

Em `comparison_cells`, o campo próprio é `comparison_records`; cada registro
contém conjuntamente:

```text
comparison_id
admissibility_conditions
source_equilibrium_ids: majority, unanimity
source_interface_hashes: N3, N4
private_payoff_vectors_by_rule:
  majority: theta_0, theta_1
  unanimity: theta_0, theta_1
private_outcome_distributions_by_rule:
  majority: pass_with_hegemon, pass_without_hegemon, failure, delay
  unanimity: pass_with_hegemon, pass_without_hegemon, failure, delay
private_rule_contrasts
selection_status
checks_performed
```

Cada `comparison_id` é único no artefato. Cada registro cita **exatamente um**
`equilibrium_id` de maioria de `N3`, exatamente um de unanimidade de `N4` e os
hashes correspondentes nos campos `N3` e `N4`; cada vetor de payoff tem
exatamente as coordenadas `theta_0` e `theta_1`. `N6` inclui exatamente uma vez
cada combinação admissível desses registros congelados; não seleciona uma
delas. `comparison_cells` é o refinamento comum das duas partições por regra:
fica `none` onde qualquer regra não tiver registro, sem apagar os
`private_rule_records` da regra sobrevivente. Assim, a interface contém tudo
que `N7` precisa do modelo privado e `N7` continua dependendo diretamente
apenas de `N6`.

**Benchmark terminal `N7`.** A interface usa
`complete_information_benchmark_v1` e é função de `prior_mu in [0,1]` apenas
para formar objetos ex ante. Em Gate 0, cada coleção abaixo é `null`:

```text
public_equilibrium_cells:
  majority:
    R2: theta_0, theta_1
    R1: theta_0, theta_1
  unanimity:
    R2: theta_0, theta_1
    R1: theta_0, theta_1
informational_rent_cells:
  majority
  unanimity
informational_rent_contrast_cells
```

Em cada célula pública, o campo próprio é `public_equilibrium_records`. Cada
registro público contém conjuntamente `public_equilibrium_id`,
`institution`, `round`, `theta`, `admissibility_conditions`,
`branch_classification`, `strategy_profile`, `belief_system`,
`source_public_continuation_ids`,
`existence_uniqueness_status`, `selection_status`,
`assumptions_used`, `checks_performed`,
`payoff_vector` — com exatamente `recognized_proposer_payoff`,
`weak_nonproposer_pre_recognition_expected_value` e `hegemon_payoff` —,
`outcome_distribution` — com passagem com `H`, passagem sem `H`, falha e atraso
— e `payoff_date`. Cada `public_equilibrium_id` é único no artefato. Em `R2`,
`source_public_continuation_ids` é vazio. Em `R1`, ele contém todos e somente
os IDs de registros de `R2` da **mesma regra e do mesmo tipo** efetivamente
consumidos pelo registro de `R1`; portanto seu alvo é interno à coleção pública
de `N7`, nunca um ID privado. Como o registro público já fixa `theta`,
`hegemon_payoff` é escalar. As três coordenadas por papel espelham os payoffs
privados necessários para transportar R2 a R1 e tornam inequívoca a coordenada
de `H` usada em `V_g^pub`.

As células de renda são separadas por regra. Em cada uma, o campo próprio é
`informational_rent_records`; cada registro contém conjuntamente:

```text
rent_record_id
institution
admissibility_conditions
private_source_rule_record_id
public_source_equilibrium_ids: theta_0, theta_1
source_N6_interface_hash
RI: theta_0, theta_1
ex_ante_images
envelopes
selection_status
robustness_indicators
```

O `rent_record_id` é único no artefato. Cada registro combina exatamente um
`private_rule_record_id`, os dois `public_equilibrium_id` de `R1` da **mesma
regra** — um por tipo — e o hash congelado de `N6`; a ligação de cada registro
público de `R1` a `R2` permanece preservada pelos IDs de continuação acima.
Existe exatamente um registro de renda por tupla completa admissível dessas
fontes. A coleção de maioria calcula `RI_M`; a de unanimidade calcula `RI_U`.
Uma coleção permanece preenchida mesmo se a outra for `none`.

`informational_rent_contrast_cells` é o refinamento comum das duas coleções de
renda. Seu campo próprio é `informational_rent_contrast_records`; cada registro
contém conjuntamente:

```text
contrast_record_id
admissibility_conditions
source_rent_record_ids: majority, unanimity
DeltaRI: theta_0, theta_1
ex_ante_images
envelopes
selection_status
robustness_indicators
```

Cada `contrast_record_id` é único no artefato e cada par admissível de registros
de renda aparece exatamente uma vez. A célula de contraste é `none` sempre que
qualquer renda-fonte for `none`, mas as coleções individuais de `RI_M` e `RI_U`
permanecem intactas. Não há campos opcionais nem registro parcialmente
preenchido. Nenhuma dessas coleções retorna como input a `N1`, `N2`, `N3`, `N4`
ou `N6`.

Nenhum schema contém decisão nem valor de formação. Qualquer nó que precise
exportar mais do que isto deve declarar a extensão no DAG antes de derivar, com
justificativa; a mudança segue a Seção 12.

## 8. O que cada nó deve entregar

`N1`--`N4` entregam a correspondência completa de equilíbrio nas células e
registros atômicos da Seção 7.2. `N6` entrega a correspondência completa de
cada regra privada e, separadamente, a correspondência de comparações, inclusive
células vazias certificadas, mantendo IDs e hashes. `N7` entrega as
correspondências completas dos jogos públicos por regra e tipo, as duas
correspondências de renda por regra e a correspondência separada de `DeltaRI`,
inclusive as regiões em que apenas parte desses objetos existe.

Todo nó entrega ainda:

1. interface preenchida segundo seu schema da Seção 7.2;
2. ledger de claims ligado aos IDs dos registros, que registra ramo e data e
   classifica cada claim como `proved`, `checked numerically`, `conjecture`,
   `pending` ou `rejected`;
3. hash imutável do candidato submetido à revisão.

O candidato e seu hash entram no protocolo de prontidão, congelamento e revisão
da Seção 11. Qualquer alteração posterior segue a Seção 12.

`N6` fecha o modelo principal: responde à pergunta de delay, preserva cada regra
privada e reporta a comparação dos payoffs e outcomes entre regras, inclusive
se não houver ordenação robusta ou se a comparação for vazia. `N7` resolve P8
nas mesmas unidades dos registros privados e completa `RI_M`, `RI_U` e
`DeltaRI` conforme a existência separada da Seção 1, inclusive se qualquer
objeto for negativo, set-valued ou vazio sob o conceito vigente. O tratamento
de ambas as revisões está na Seção 11.

---

## 9. Obrigações de prova que não podem ser assumidas

As decisões de protocolo D1--D9 e a decisão autoral de 2026-08-17 sobre o escopo
de stage-undominated voting estão resolvidas. Os itens abaixo são obrigações de
prova ou testes a resolver sob essas decisões. Quando o item é formulado como
conjectura, a derivação deve prová-la ou refutá-la e preservar o resultado;
nenhum desfecho pode ser inserido como premissa ou orientação.

**P0 — Teste de uso integral da pie.** A factibilidade permite
`y+sum_j x_j+r_i<1`. Os nós de `N1` a `N4` devem determinar, sob o conceito da Seção 5, se
propostas com folga podem maximizar o payoff do proponente, levando em conta as
crenças e respostas após propostas fora do caminho. Não se pode substituir a
desigualdade factível por uma igualdade primitiva nem acrescentar uma restrição
de crenças para obter o resultado. Se alguma proposta com folga sobreviver, ela
deve permanecer na correspondência e no reporte.

**P1 — Teste da dominância candidata do hedge sob maioria.** `N3` deve comparar
a proposta `s=(y,x,r_i)`, com `y>0` e `q-1` votos fracos comprados, com
`s'=(0,x,r_i+y)`, que mantém os pagamentos aos mesmos `q-1` weak states e
preserva a soma orçamentária. A comparação é ex ante entre propostas, não
realocação depois do ballot, e deve incorporar as crenças e respostas que o
assessment atribui a cada proposta, inclusive quando uma delas está fora do
caminho. `N3` deve provar ou refutar a dominância estrita sem acrescentar uma
restrição de crenças. Se ela falhar, o hedge permanece candidato em P2.

**P1a — Teste on-path do ramo aprovado sem `H` com `y>0`.** Sob unanimidade, a
segunda linha da Tabela 1 é inalcançável. Sob maioria, `N3` deve determinar se a
ausência on-path dessa história decorre de P1. Se P1 for refutada, a história
não pode ser suprimida e P1a também pode ser refutada. A obrigação não elimina a
exclusão com `y=0`, preservada em P2.

**P2 — Caracterização de N3 desde as primitivas.** `N3` deve resolver R1 maioria
por indução retroativa, consumindo apenas a interface congelada de `N1`. Para
cada proposta factível e perfil de ações no ballot, os payoffs devem ser
construídos pelas transições e pelos desfechos terminais da Seção 4; quando a
história continua, a interface de `N1` é transportada para R1 conforme a
convenção temporal da Seção 6. Estratégias e crenças devem então satisfazer o
conceito de solução da Seção 5. Exclusão, inclusão pooling e screening são
rótulos aplicados à correspondência obtida, não regiões assumidas antes da
solução. `N3` deve derivar suas fronteiras, tratar as igualdades conforme `T^Y`
e demonstrar se os regimes candidatos são não vazios e exaustivos. Se aparecer
outro regime, ou se algum deles for vazio, deve registrar e escalar o resultado,
não suprimi-lo para reproduzir D3.

**P3 — Teste de separating e caracterização de N4.** Sob o conceito da Seção 5,
`N4` deve construir e testar todos os candidatos separating em estratégias
puras, além dos candidatos pooling, de falha deliberada e de atraso. Deve provar
quais sobrevivem e se a correspondência obtida é exaustiva. O contrato não fixa
o resultado: separating sobrevivente, delay ou qualquer regime adicional deve
ser preservado na correspondência e no reporte, não suprimido.

**P4 — Não informatividade on-path das ações fracas.** Em cada conjunto de
informação no caminho, `N4` deve testar por Bayes se, condicionalmente a toda a
informação pública já disponível naquele ponto, a distribuição de **cada ação
de weak state** é a mesma para todo tipo de `H` ainda possível. Isso inclui a
proposta do weak proposer e os votos dos weak nonproposers. A consequência a
demonstrar no ballot é que observar os votos fracos não acrescenta informação
sobre `theta` além da proposta e da história públicas; qualquer atualização
adicional do posterior pode vir apenas do voto de `H`. A expressão
`weak-vote-passive assessment` nomeia o lema se provado, não uma restrição de
crenças. Histórias de probabilidade zero e suas crenças devem ser tratadas
separadamente e explicitadas; nenhuma conclusão on-path é automaticamente
estendida para fora do caminho.

**P5 — Suficiência do posterior em R2.** Deve-se provar que, como R2 é terminal e
o reconhecimento é iid com reposição, histórias públicas com o mesmo posterior
induzem o mesmo problema de maximização, sem impor estratégias Markov como
restrição.

**P6 — Efeito on-path do refinamento.** Os nós de `N1` a `N4` devem demonstrar
quais ações o stage-undominated voting dos weak nonproposers elimina e como
`T^Y` resolve as indiferenças genuínas. Não se presume unicidade. Crenças em
propostas e vetores de votos off-path podem impedir dominância em R1 ou sustentar
multiplicidade residual. Se a multiplicidade impedir responder às perguntas da
Seção 1, o nó deve reportá-la sem acrescentar seleção ad hoc.

**P7 — Tratamento do voto de `H` em R1.** Como o voto de `H` integra a história
pública que conduz a R2, `N3` e `N4` devem incluí-lo na atualização para `nu'` e
tratar explicitamente as crenças off-path correspondentes. O contrato não
presume que esse voto separa os tipos: se e quanto ele atualiza a crença depende
das estratégias derivadas.

**P8 — Benchmark público terminal por ramos.** Somente depois de `N6` receber os
dois PASS e ser congelado, `N7` deve resolver os jogos em que `theta` é público
desde `t=0`, sob as mesmas primitivas e o conceito da Seção 5. Dentro de `N7`,
R2 é resolvida antes de R1 para cada regra; nenhum valor público de R1 pode ser
construído sobre continuação pública de R2 ainda aberta. A derivação pública não
usa o equilíbrio privado como premissa: a interface congelada de `N6` entra
apenas depois, no cálculo das rendas.

Para cada regra e tipo, `N7` determina existência e testa unicidade e unicidade
de payoff. Se houver múltiplos equilíbrios, caracteriza todos, com seus ramos,
estratégias, crenças, payoffs, outcomes e datas; se não houver equilíbrio sob o
conceito vigente, registra e escala a inexistência. Nenhuma seleção adicional
pode ser acrescentada.

A unicidade e a seguinte caracterização são conjecturas a provar ou refutar,
não resultados impostos: no ramo de inclusão, o proponente oferece exatamente
o valor de reserva ou continuação relevante e `H` aceita pela regra da Seção 5,
ficando na reserva; no ramo de exclusão sob maioria, a proposta fixa `y=0`, `H`
vota `não` e recebe `o_theta` na data da aprovação. `N7` testa essas propriedades
em cada equilíbrio encontrado a partir das Seções 4--6 e preserva qualquer
contraexemplo ou ramo adicional. Após falha em R1, transporta uma única vez a
continuação pública de R2 segundo a Seção 6.

Só depois dessa caracterização `N7` combina os registros públicos com todos os
registros privados admissíveis de `N6`, calcula `RI_U`, `RI_M` e `DeltaRI` pela
Seção 1 e testa se todo payoff público coincide com a opção externa na data
relevante. A medida simples só pode aparecer na exposição se essa equivalência
for provada. O conteúdo substantivo da conjectura é testar se, sem informação
privada, `H` deixa de capturar renda.

---

## 10. Índice de material não transportável

Esta seção identifica famílias históricas que não podem ser importadas como
resultado corrente. Ela não especifica novamente o jogo; para saber a regra
vigente, deve-se consultar a fonte canônica indicada.

- As arquiteturas de opt-out, saída assimétrica, `weak-only`, hybrid exit e
  delayed continuation foram descartadas na Seção 3. Espaço de ações,
  transições e tempo são regidos pelas Seções 2, 4 e 6.
- Destruição ou reversão de `y`, realocação contingente ao ballot e qualquer
  payoff terminal alternativo não são transportáveis. A única função de
  implementação está na Seção 4.
- A redução `P/L/R`, o rejected-history reduction lemma, afirmações gerais de
  no-screening sob maioria, fronteiras e rankings antigos só podem reaparecer se
  forem rederivados pelas obrigações da Seção 9.
- Teoremas, correspondências e pareceres da cadeia `pivotal-response` valem
  apenas para a especificação arquivada; a proteção dos artefatos está na
  Seção 13.
- Calibração OPEC, feasibility/C-B-R, `pi_H>0`, escolha endógena de regra e
  entry são extensões fora do escopo definido nas Seções 1 e 2.
- Atalhos no conceito de solução — mistura no ballot, seleção por uma igualdade
  apenas local, aplicação do refinamento a `H`, eliminação ordenada ou restrição
  adicional de crenças — não são transportáveis. A única especificação vigente
  está na Seção 5 e seu teste, em P6.
- O antigo weak-vote-passive assessment não pode ser imposto. O único objeto
  corrente com esse nome é o possível lema de P4.
- Medidas simplificadas de renda e conclusões universais sobre inclusão no
  benchmark público não substituem a definição da Seção 1 nem o teste por
  ramos de P8.

---

## 11. Protocolo de revisão

Implementador não revisa; revisor não edita. Cada ciclo usa dois revisores
independentes e read-only: um parecer de desenho formal e uma auditoria
adversarial de matemática e teoria dos jogos.

**Princípio da fronteira de dependência.** A fronteira de dependência determina
a frequência **mínima** de revisão. Nenhum nó pode consumir uma interface antes
de o mesmo hash receber PASS `0/0/0` dos dois revisores e ser congelado. Enquanto
a implementação ou a revisão estiver aberta, o nó permanece `pending`; somente
depois desses dois PASS o mesmo hash passa a `pass` e `frozen`. Nós independentes
que estejam prontos ao mesmo tempo podem compartilhar um ciclo, com veredicto
separado para cada nó e cada hash. Compartilhar não é obrigatório: a importância
substantiva de um nó pode justificar um ciclo exclusivo.

**Registro executável do congelamento.** Um nó só está congelado quando reúne
simultaneamente: `status = pass`; `frozen = true`; `artifact_hash` SHA-256
válido; e `reviews` com exatamente dois registros, um de papel
`formal_design` e outro de papel `game_theory`. Os `reviewer_id` devem ser
distintos. Cada registro deve declarar `verdict = PASS`, repetir exatamente o
`artifact_hash` do nó e trazer `finding_counts` iguais a zero em `critical`,
`major` e `minor`. Ausência de qualquer desses fatos não congela a interface e
não libera consumidor. Nós `pending` omitem `frozen`, `artifact_hash` e
`reviews`; o DAG de Gate 0 permanece nesse estado vazio.

A **prontidão topológica** significa apenas que todas as dependências de um nó
estão congeladas segundo o parágrafo anterior. Ela é condição necessária, não
autorização para trabalhar: os gates autorais da cadência canônica abaixo
continuam necessários. O verifier da Seção 13 testa somente essa prontidão
topológica e nunca concede autorização.

**Cadência canônica.** Esta é a única especificação da cadência; a Seção 7
apenas aponta para ela.

1. **Goal 0:** o contrato recebe os dois pareceres e o autor decide o gate do
   Goal 1 antes de qualquer derivação.
2. **Goal 1, primeira fronteira:** `N1` e `N2` podem ser implementados em
   paralelo e podem compartilhar um ciclo de revisão, com veredictos separados. `N3`
   só começa depois de `N1` obter os dois PASS e sua interface ser congelada.
3. **Goal 1, segunda fronteira:** `N3` recebe ciclo próprio. O Goal 1 só fecha
   quando `N1`, `N2` e `N3` tiverem passado e o autor autorizar o avanço.
4. **Goal 2:** `N4` só começa com `N2` congelado e após o gate autoral do Goal
   1. Embora não consuma `N3`, recebe um ciclo **exclusivo**, sem outro nó no
   mesmo pacote, porque decide o mecanismo central do paper. O Goal 2 só fecha
   após os dois PASS e o aval do autor.
5. **Goal 3:** `N6` só começa com `N3` e `N4` congelados e após o gate autoral
   do Goal 2. Seu ciclo revisa simultaneamente o próprio `N6` e a integração da
   cadeia privada. Depois dos dois PASS, `N1`, `N2`, `N3`, `N4` e `N6` formam
   o modelo principal congelado.
6. **Goal 4:** `N7` só começa com `N6` congelado e após gate autoral do Goal 3.
   Recebe ciclo exclusivo, que revisa os jogos públicos, a ligação aos registros
   privados congelados e as rendas. Finding sobre resultado, multiplicidade ou
   inexistência no benchmark não reabre o modelo principal; erro em fonte
   compartilhada segue a Seção 12. O Goal 4 só fecha após os dois PASS e o aval
   do autor.
7. **Goal 5:** a migração para `formal_model_v6.Rmd` só pode começar depois dos
   dois PASS do ciclo de `N7` e de autorização explícita do autor.

Todo finding segue a classificação da Seção 11.1. Apenas reparo técnico ou
reparo substantivo autorizado pelo autor pode gerar novo hash; todo hash novo
retorna aos dois revisores do ciclo afetado.

**Revisão do contrato no Goal 0.** Antes de qualquer derivação, os dois
revisores leem este contrato e tentam quebrá-lo. Instrução explícita ao revisor,
que não existia na cadeia anterior: verificar, para cada primitiva, se ela é
**necessária ao mecanismo** ou se está presente por conveniência de
tratabilidade. A primitiva de opt-out atravessou vários goals justamente porque
essa pergunta nunca foi feita.

### 11.1 Quem repara um finding, e quando o autor entra

Todo finding é classificado **antes** de qualquer reparo, e a classificação
aparece no reporte com o texto original do revisor transcrito, para que o autor
veja se algo foi rebaixado.

**O default é escalar.** O ônus da prova recai sobre quem quiser classificar um
finding como técnico. Na dúvida, escala.

**Teste de reparo único.** Um finding é *técnico* se, e somente se, existe
**exatamente um** reparo consistente com o que já está escrito, de modo que
aplicá-lo não envolve escolha. Se houver mais de um reparo razoável, ou se o
implementador não tiver certeza de que há só um, o finding é *substantivo*.

Este teste substitui a classificação por categoria, que não funciona:

> **Ambiguidade e definição faltando nunca são técnicas.** Ambiguidade significa
> que há mais de uma leitura; definição faltando significa que há mais de um
> preenchimento. Nos dois casos só se sabe o que a resolução muda **depois** de
> resolver, e resolver é exatamente o que está em disputa. Classificar antes é
> circular. Esses dois casos escalam sempre, sem exceção e sem julgamento de
> mérito sobre parecerem pequenos.

A mesma regra vale para qualquer coisa que fixe **quem sabe o quê**, **quem pode
fazer o quê** ou **quem recebe o quê**. Um conjunto de informação não
especificado é decisão de desenho, não lacuna de redação.

```text
técnico     -> reparo único e forçado pelo que já está escrito.
               Exemplos: mesmo objeto chamado por dois nomes onde o
               referente é inequívoco; erro de digitação em fórmula cuja
               forma correta é imposta pela derivação vizinha; ponteiro
               quebrado; aresta de dependência já explicitada no texto e
               ausente só no mapa; ordenação e duplicação.
               Implementador repara e registra no reporte de fim de goal.

substantivo -> tudo o mais, inclusive toda ambiguidade e toda definição
               faltando. Implementador PARA e não repara. Escreve o finding,
               as leituras possíveis, a consequência de cada uma, e marca
               `pending protocol decision`. Só o autor decide.
```

O implementador não tem autoridade para resolver finding substantivo, mesmo que
a solução pareça óbvia e mesmo que o revisor tenha sugerido uma. Sugestão de
revisor é insumo, não decisão.

**Escalação em lote, para não virar ruído.** Ambiguidades que não bloqueiam o
trabalho são acumuladas em lista e enviadas juntas na fronteira do goal, com as
leituras possíveis e a consequência de cada uma. Ambiguidade que bloqueia é
enviada na hora. A assimetria de custo justifica o viés: uma pergunta custa uma
mensagem; uma resolução errada propaga por seis nós e só aparece goals depois.

Todo parecer completo salvo em `quality_reports/YYYY-MM-DD_nome.md` antes de
resumir. Nunca truncar.

**Reporte ao autor ao final de cada goal.** Em linguagem corrente, sem jargão
interno. Notação inventada na derivação deve ser traduzida antes de aparecer.
Cada reporte diz: o que foi feito, por que, e qual pergunta o autor deve fazer
para verificar que o resultado está alinhado com o que ele quer. Nenhum goal
avança sem esse aval.

---

## 12. Invalidação

1. **Mudança no contrato do jogo.** Alteração do estimando ou do escopo da
   comparação; das primitivas ou da factibilidade; das ações, transições,
   informação, implementação ou payoffs; do conceito de solução; do desconto;
   da topologia ou do schema; ou das obrigações de prova reabre este Gate 0 e
   devolve todos os nós de derivação a `pending`.
2. **Mudança em interface congelada.** O produtor volta a `pending` e
   `unfrozen`; seus pareceres e hash anteriores tornam-se obsoletos; e todos os
   descendentes transitivos voltam a `pending`. Nós fora dessa descendência
   permanecem válidos somente se a mudança não alterar uma fonte compartilhada
   do contrato. Como `N7` é terminal, mudança em seu conteúdo invalida apenas
   `N7` e artefatos de migração que o tenham consumido. Finding sobre resultado,
   multiplicidade ou inexistência no benchmark não invalida `N1`, `N2`, `N3`,
   `N4` ou `N6`; se o finding demonstrar erro em primitiva, conceito de solução
   ou outra fonte
   compartilhada, aplica-se o item 1.
3. **Mudança no protocolo de revisão.** Uma alteração da Seção 11 reabre o Gate
   0 de prontidão: todos os nós de derivação voltam a `pending`, e seus pareceres,
   congelamento e autorização de consumo tornam-se inválidos. Derivações e
   interfaces cujo conteúdo permaneça idêntico não são apagadas nem precisam
   ser refeitas por esse motivo; podem ser submetidas novamente ao protocolo
   novo. Para a regra `contract_change` do DAG, “invalidar o nó” tem aqui esse
   sentido de status, revisão e prontidão, não de destruição do conteúdo
   matemático. Rederivação só é exigida se o conteúdo mudar ou se a nova revisão
   encontrar problema substantivo.
4. **Reparo de finding.** A autorização e a autoria do reparo seguem a Seção
   11.1; seu alcance de invalidação segue os itens anteriores. Nenhum reparo
   local pode contornar essas regras.

---

## 13. Fronteira de versão, verificação e artefatos protegidos

A tag anotada `pre-essential-input-2026-08-12` já existe e aponta, após
*peeling*, para o commit
`f53e6769624ce3dd6e64e21ad40d08230b0950a7`, a fronteira anterior a esta
arquitetura. Não recriar, mover nem substituir a tag.

`HEAD`, branch e limpeza do worktree são fatos operacionais mutáveis e devem ser
verificados ao vivo no início de cada sessão; não são congelados neste contrato.

**Verificação canônica da infraestrutura.** Antes de qualquer trabalho
autorizado, executar na raiz do repositório:

```text
Rscript scripts/verify_essential_input_gate0.R
```

Esse é o único verifier referido sem qualificação neste contrato. Ele checa a
infraestrutura do Gate 0 — topologia de seis nós sem `N5`, schemas vazios de
coleções de cobertura, preservação separada de `RI_M`, `RI_U` e `DeltaRI`,
tipagem dos payoffs públicos, isolamento terminal de `N7`, estados `pending`,
gates de congelamento com duas revisões, prontidão **topológica** e invalidação
— e deve terminar com `PASS`. Seu resultado não substitui nenhum gate autoral da Seção
11. Falha nessa verificação bloqueia o trabalho até ser classificada e resolvida
conforme a Seção 11.1.

São protegidos:

- `quality_reports/2026-08-12_essential_input_gate0_decisions.md`, registro
  histórico e proveniência das decisões incorporadas; permanece protegido, mas
  não é fonte normativa corrente nem prevalece sobre este contrato;
- `formal_model_v5.Rmd` e `formal_model_v6.Rmd`, até o gate do Goal 5;
- todos os artefatos da cadeia `pivotal-response`, que permanecem apenas como
  proveniência e não podem ser editados, migrados nem citados como evidência
  corrente.

---

## 14. Prompt de abertura da próxima sessão

```text
Estamos no repo PowerBayesianPersuasion. Leia AGENTS.md e este contrato inteiro
antes de agir. Este prompt é apenas um índice e não concede autorização nem
reformula regra alguma.

1. Verifique ao vivo a fronteira de versão e preserve os artefatos da Seção 13.
2. Tome a autorização corrente somente do cabeçalho.
3. Siga a topologia e o schema da Seção 7, os entregáveis da Seção 8, as
   obrigações da Seção 9, o protocolo da Seção 11 e a invalidação da Seção 12.
4. Execute a verificação canônica definida na Seção 13.
5. Se surgir finding, aplique a Seção 11.1 sem completar lacunas por suposição.
```
