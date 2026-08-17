# Gate 0 — Arquitetura essential-input

**Data:** 2026-08-12
**Status:** `APPROVED` — aprovado pelo autor em 2026-08-12, emendado pelas
decisões normativas do commit `162616d` e pela decisão autoral de 2026-08-17
sobre o escopo de stage-undominated voting. Autoriza o Goal 0; nenhum nó de
derivação está autorizado antes das duas novas revisões independentes e da
resolução de qualquer finding remanescente.
**Substitui:** a cadeia `pivotal-response` (12 nós, commit `19c431a`) como arquitetura corrente.
**Alvo eventual:** `formal_model_v6.Rmd`, somente após derivação, revisão independente e migração controlada.

---

## Leitura para aprovação — sem jargão

Esta seção é para o autor decidir se o desenho está alinhado com o que ele quer.
As seções numeradas depois são para quem implementa.

### O que o paper quer mostrar

`H` constrói organizações por consenso porque, sob unanimidade, **ninguém pode
substituí-lo**. Sob maioria os fracos podem comprar o voto de outro fraco em vez
do dele, e isso põe um teto no preço que `H` consegue cobrar. Sob unanimidade o
teto some, e aí a informação privada de `H` — o quanto ele realmente precisa do
acordo — vira dinheiro.

O ponto não é que `H` tenha uma alternativa externa melhor. Isso só o protege.
O ponto é que a unanimidade transforma a informação privada dele em renda.

### As cinco decisões centrais, e o que observar

**1. Ninguém tem botão de saída.** Todos votam sim ou não, e um não é só um não.
Antes, o não de `H` significava "saio da organização para sempre", e nenhum
acordo futuro podia incluí-lo. Isso dava a `H` um poder que os fracos não tinham
e, pior, impedia `H` de recusar hoje para negociar melhor amanhã — que é
justamente o mecanismo que queremos.
*Observe:* se em algum momento reaparecer a ideia de que `H` "sai" ao votar não,
está errado.

**2. A alternativa externa de `H` é o que ele recebe quando fica fora do
acordo.** Isso ocorre se uma proposta passa sem `H` ou se R2 termina sem acordo.
Todos são pagos na data em que o jogo termina: aprovação em R1, aprovação em R2
ou falha de R2. Antes, `H` acessava sua alternativa em R1 enquanto os fracos só
acessavam continuações descontadas, inflando artificialmente seu preço.
Se uma proposta passa sem `H`, a coordenada `y` votada continua sendo paga a
`H`, além de `o_theta`, que vem de fora da pie. `y` não é destruído nem
redistribuído depois do ballot.
*Observe:* `H` não recebe `o_theta` antes de o jogo terminar nem em data
diferente da alocação recebida pelos weak states.

**3. Weak nonproposers não usam votos fracamente dominados.** Em votação
simultânea existe um problema conhecido: vários weak states podem sustentar uma
falha coordenada embora cada um preferisse aprovar se seu voto fosse decisivo.
O baseline enfrenta essa patologia exigindo stage-undominated voting dos
**weak nonproposers apenas**. Em R2, isso elimina a falha coordenada dos fracos;
em R1, se a elimina é resultado a provar porque os vetores de votos podem
induzir continuações distintas. `H` não está sujeito a essa restrição adicional:
seu voto é disciplinado por racionalidade sequencial em PBE, porque pode mudar
sua inclusão e seu payoff mesmo quando não altera a aprovação da proposta.
*Observe:* a assimetria é deliberada e deve estar declarada no paper. Não se
pode reaplicar undominância a `H` dentro de uma prova.

**4. Empate conta como aceitação.** Quando os payoffs de `sim` e `não` são
exatamente iguais no problema relevante do votante, a convenção é: aceita. Sem
ela o proponente ficaria querendo oferecer "um centavo a mais que o mínimo", que
não existe, e o modelo perde solução fechada. Nos documentos técnicos isso
aparece como `T^Y`; é só isso que significa. A convenção vale para todos os
votantes, inclusive `H`, nas duas rodadas e também quando a igualdade envolve
continuação endógena. Ela não transforma igualdade em uma linha isolada em
aceitação quando o mesmo votante tem preferência estrita no problema que
efetivamente enfrenta.
*Observe:* para weak nonproposers, primeiro se verifica a restrição do item 3 e,
entre melhores respostas admissíveis realmente empatadas, aplica-se `T^Y`. Para
`H`, PBE determina a melhor resposta e `T^Y` seleciona `sim` apenas na
indiferença genuína.

**5. O bolo é sempre o mesmo, com ou sem `H`.** Decisão sua, reafirmada, e
definitiva para este paper. É menos realista, e é o preço de isolar o mecanismo.
*Observe:* se alguém propuser que o acordo vale menos sem `H` "porque é mais
realista", é alternativa já eliminada. Vai para outro paper.

### Como o trabalho é dividido, e o que checar em cada etapa

Resolve-se de trás para frente: a última rodada primeiro, porque a decisão de
hoje depende do que acontece amanhã.

**Goal 1 — os nós terminais e R1 maioria.** Maioria nas duas rodadas, e
unanimidade na segunda. A substituibilidade de `H` põe um teto em seu preço, mas
não torna sua informação inerte por construção. `N3` deve derivar, sem orientação
prévia, as regiões em que `H` é excluído nos dois tipos, incluído nos dois tipos
ou screened porque apenas um tipo é mais barato que o voto fraco substituto.
*Checar:* a dominância que elimina o hedge caro e as três regiões precisam sair
como resultados, não entrar como suposições.

**Goal 2 — a parte difícil.** Unanimidade na primeira rodada. É aqui que o paper
se decide. Com estratégias puras no ballot e `T^Y` em toda igualdade, `N4` deve
provar — não assumir — se pode existir equilíbrio separating e se a opção de
espera gera renda mesmo sem atraso realizado.
*Checar:* a inexistência de separating e a ausência de atraso são obrigações de
prova condicionadas à restrição a estratégias puras, não primitivas escondidas.

**Goal 3 — juntar tudo e responder.** Comparação entre as regras, condicional à
organização existir sob ambas. Ao final desta etapa, apresentação do equilíbrio,
da intuição e do take away substantivo, em linguagem corrente. A decisão de
entry fica fora do baseline e é extensão futura.

**Goal 4 — levar para o manuscrito.** Só depois que dois revisores independentes
aprovarem sem ressalvas.

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
2. **Sobrevivência da renda.** O payoff de equilíbrio de `H` excede
   o payoff do mesmo jogo e da mesma regra quando `theta` é público, e essa
   renda informacional é maior sob unanimidade que sob maioria?

**Estimando da renda informacional.** Para cada regra e tipo, renda
informacional é a diferença entre o payoff de `H` no jogo com informação privada
e seu payoff no mesmo jogo com `theta` público desde `t=0`, mantendo todas as
demais primitivas e o protocolo idênticos. Cada nó deve exportar esse benchmark;
a renda é calculada como diferença e nunca inferida do excesso sobre `o_theta`.

**Lema do benchmark público, por ramos.** O jogo com `theta` público deve ser
resolvido, não substituído por um payoff imposto. Para cada regra, tipo e nó, a
derivação deve primeiro determinar qual ramo é ótimo:

1. **Inclusão.** Se a proposta ótima inclui `H`, provar que o proponente oferece
   exatamente a reserva relevante do tipo conhecido e que `H` aceita na
   igualdade por `T^Y`. Em R2 a reserva é corrente; em R1 ela é a continuação
   pública de R2 transportada uma única vez por `beta`. Stage-undominated voting
   não se aplica a `H`; sua aceitação deve satisfazer racionalidade sequencial e
   a convenção de igualdade da Seção 5.
2. **Exclusão sob maioria.** Se a proposta ótima exclui `H`, provar que ela fixa
   `y=0`, passa sem o voto de `H`, `H` vota `não` e recebe `o_theta` de fora na
   data da aprovação. Este ramo é inalcançável sob unanimidade.
3. **Continuação ou falha.** Se R1 falha, não há pagamento e o benchmark de R1
   importa a interface pública de R2 uma única vez por `beta`. Se R2 falha, `H`
   recebe `o_theta` na data terminal e os weak states recebem zero.

Qual ramo prevalece é resultado, não primitiva. Somente depois de provar o lema
no ramo pertinente a exposição pode substituir o contrafactual por uma medida
simples de payoff menos opção externa, com a opção externa transportada para a
data correta. Essa equivalência não é global entre ramos nem entre regras.

**Escopo da resposta sobre delay.** O ballot é restrito a estratégias puras e
`T^Y` vale em toda igualdade. A decisão do autor antecipa ausência de atraso sob
essa restrição, mas `N4` deve prová-la. O paper deverá declarar que a renda vem
da opção de atraso, não necessariamente de seu exercício, e que a ausência de
delay é condicionada à restrição a puras.

**Candidato substantivo, não premissa.** A decisão do autor antecipa que a
inexistência de separating fará a opção de espera sustentar renda
`beta*(o_1-o_0)` para todo prior mesmo sem atraso realizado. `N4` deve derivar
ou refutar essa expressão sob o contrato emendado.

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
mudar o resultado depois de vê-lo. Se um ajuste parecer justificado por outra
razão, ele reabre o Gate 0 e a derivação recomeça declaradamente, não como
reparo local.

---

## 2. Primitivas

```text
Jogadores      H mais m = N-1 weak states, N >= 3 genérico
Tipo           theta in {0,1}, privado de H, prior comum mu = Pr(theta=1)
Pie            surplus institucional fixo, normalizado em 1
Pacote         alocação s = (y, (x_j)_{j in W sem i}, r_i), com
               0 <= y <= y_bar, x_j >= 0, r_i >= 0 e
               y + sum_j x_j + r_i <= 1; y é destinado a H
Payoff de H    se a proposta passa: y quando H vota sim; y+o_theta quando H
               vota não e a proposta passa sem ele; se R2 falha: o_theta;
               b_theta = 0
Desacordo      weak state: 0;  H: o_theta, com 0 < o_0 < o_1 <= y_bar <= 1
Agenda         pi_H = 0 em toda rodada; só weak states propõem
Reconhecimento sorteios iid com reposição, uniformes entre os m weak states;
               todos seguem elegíveis em R2, inclusive o proponente de R1
Desconto       beta in (0,1]
Rodadas        duas; R2 terminal
```

`o_theta` é primitivo. Mapeamentos como `o_theta = alpha V(theta)` pertencem a
aplicação, ilustração numérica ou microfundamento, e não são impostos.

A opção externa de `H` é **externa à pie institucional**. Se uma proposta passa
com voto `não` de `H`, ele fica fora do acordo, recebe `o_theta` de fora na data
da aprovação **e recebe `y` como escrito na proposta**. Toda coordenada da
alocação aprovada é executada integralmente, para todos os destinatários,
independentemente do voto: nada é destruído e nada é realocado depois do ballot.
Se R2 falha, `H` recebe `o_theta` e os weak states recebem zero na data terminal.
Não há pagamentos laterais. Que propostas com folga orçamentária não sejam
ótimas é resultado a provar, não restrição adicional ao conjunto factível.

---

## 3. Decisões de desenho

### Decisão: espaço de ações no ballot

- **Escolha**: conjuntos de ação **simétricos**. Todos os não proponentes votam
  `{sim, não}`. Ninguém tem ação de saída. O voto de `H` é apenas um voto.
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

- **Escolha**: `o_theta` é o **payoff de desacordo individual** de `H`, realizado
  quando o jogo termina sem `H`: na data em que uma proposta passa sem ele ou,
  se nada passa, ao fim de R2. Recebe o mesmo tratamento de data e desconto que
  as alocações dos weak states na mesma história terminal.
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

**Sem caracterização antecipada sob maioria.** Com `a` denotando o preço do voto
fraco substituto em R1, `N3` deve derivar três regiões: ambos os tipos de `H`
acima de `a`, ambos abaixo de `a`, e `o_0 < a < o_1`. A última admite screening
sob maioria. Nenhuma região, condição de exclusão ou inércia informacional pode
ser imposta antes da derivação.

**Dominância a provar sob maioria.** Oferecer `y>0` e simultaneamente comprar
`q-1` votos fracos de reserva na proposta `s=(y,x,r_i)` deve ser comparado com a
proposta alternativa `s'=(0,x,r_i+y)`, que compra os mesmos votos fracos e é
factível sempre que `s` é. Esta é uma comparação **ex ante entre duas
propostas**, não realocação depois do ballot. Que `s` seja estritamente dominada
por `s'` é obrigação de prova de `N3`, apoiada na pie fixa e na execução integral
de `y`; não é restrição do espaço de propostas. Uma vez provada, restam para
comparação a exclusão com `y=0` e `q-1` votos fracos, ou a tentativa de
substituir um voto fraco por `H`, com `y>0` e `q-2` votos fracos.

### Decisão: conceito de solução no ballot

- **Escolha**: **PBE com estratégias puras no ballot e stage-undominated
  voting somente para weak nonproposers**, mais a convenção `T^Y` de aceitação
  em toda igualdade para todos os votantes. `H` é disciplinado por racionalidade
  sequencial em PBE e por `T^Y` quando estiver genuinamente indiferente. Decisão
  do autor em 2026-08-17; os instrumentos e sua divisão de trabalho estão
  especificados na Seção 5.
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
    `H`. Um weak nonproposer recebe `x_j` com qualquer voto quando a proposta
    passa sem ele; `H` recebe `y` votando `sim` e `y+o_theta` votando `não`
    quando a proposta passa sem seu voto. Em uma igualdade na linha pivotal,
    essa linha não pivotal pode fazer `não` fracamente dominar `sim` para `H`,
    em conflito com a aceitação na igualdade.
  - *Eliminação ordenada weak-first e depois `H`*: descartada porque seria uma
    seleção lexicográfica adicional. Eliminação iterada de dominância fraca é
    dependente da ordem em geral, e a continuação após vetores off-path de R1
    impede tratar a prioridade weak-first como consequência automática das
    primitivas. A ordem não será inserida dentro de uma derivação.

### Decisão: a pie não depende de `H`

- **Escolha**: o surplus institucional dos fracos é **fixo e normalizado em 1**,
  independente do tipo de `H` e independente de `H` estar ou não no acordo.
  Quando uma proposta passa sem `H`, ele recebe `o_theta` de fora; a pie factível
  continua sendo uma unidade e toda a alocação proposta, inclusive `y`, é paga
  exatamente como votada. `o_theta` não reduz a pie porque é externo. Decisão do
  autor em 2026-08-12, definitiva para este paper.
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

- **Escolha**: duas rodadas, R2 terminal.
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
t=1   Sorteio uniforme de um weak state i entre os m
      i propõe s = (y, (x_j)_{j in W sem i}, r_i), com 0 <= y <= y_bar,
        x_j >= 0, r_i >= 0 e y + sum_j x_j + r_i <= 1
      Ballot simultâneo e selado de todos os não proponentes, inclusive H;
        i conta como sim
      Fecha o ballot; o vetor completo de votos e o resultado tornam-se públicos
      Se os sim atingem q: a alocação proposta é implementada, todos são pagos
        nessa data e o jogo termina
      Se não: segue para t=2
t=2   Novo sorteio uniforme, independente e com reposição, entre todos os m
        weak states, inclusive quem propôs em R1
      Proposta, ballot simultâneo e selado, publicação
      Se os sim atingem q: a alocação proposta é implementada, todos são pagos
        nessa data e o jogo termina
      Se não: o jogo termina com 0 para cada weak state e o_theta para H
```

**Implementação e inclusão.** Se uma proposta passa, todos os weak states
recebem exatamente a alocação proposta a cada um e o proponente recebe `r_i`,
independentemente de seus votos. `H` recebe `y` sempre que a proposta passa. Se
vota `sim`, integra o acordo e seu payoff é `y`. Se vota `não` e a proposta ainda
assim passa, fica fora do acordo e seu payoff é `y+o_theta`: `y` é a coordenada
institucional executada e `o_theta` é externo à pie, ambos recebidos na mesma
data. Não há destruição, realocação ex post nem pagamentos laterais. Se o ballot
falha em R1, o jogo não terminou: nenhum pagamento ocorre e o jogo segue para
R2.

**Tabela 1. Payoffs e datas por resultado do ballot**

| Resultado | `H`, tipo baixo | `H`, tipo alto | Proponente `i` | Cada weak nonproposer `j` |
|---|---|---|---|---|
| Proposta aprovada com `H` — possível sob maioria e unanimidade | `y`, na data da aprovação | `y`, na data da aprovação | `r_i`, na data da aprovação | `x_j`, na data da aprovação |
| Proposta aprovada sem `H` — possível sob maioria; **inalcançável sob unanimidade** | `y+o_0`, na data da aprovação | `y+o_1`, na data da aprovação | `r_i`, na data da aprovação | `x_j`, na data da aprovação |
| Falha em R1 — história não terminal | Nenhum pagamento; o jogo não terminou e segue para R2 | Nenhum pagamento; o jogo não terminou e segue para R2 | Nenhum pagamento; o jogo não terminou e segue para R2 | Nenhum pagamento; o jogo não terminou e segue para R2 |
| Falha em R2 — história terminal | `o_0`, na data terminal de R2 | `o_1`, na data terminal de R2 | `0`, na data terminal de R2 | `0`, na data terminal de R2 |

A linha de falha em R1 registra uma transição, não um payoff corrente: pagamentos
só existem quando o jogo termina.

**Reconhecimento.** Os sorteios de R1 e R2 são independentes, com reposição e
uniformes entre os `m` weak states. Todos continuam elegíveis em R2. A identidade
do proponente anterior não altera probabilidades nem conjuntos de ação.

**Publicidade.** O jogo é sequencial e público **entre rodadas**. Dentro de cada
ballot os votos são simultâneos e selados, e os votos individuais só se tornam
públicos após o fechamento. Isso **não** é roll-call. Nenhuma ordem de votação e
nenhuma posição de `H` no ballot.

**Conjuntos de informação.** Weak states nunca observam `theta`. `H` observa
`theta` desde t=0. Na entrada de R2 o estado público é `(regra, nu')`, onde
`nu'` é o posterior induzido pelo vetor de votos de R1. Como `H` permanece
sempre ativo, não existe estado `weak-only`: os três nós de R2 da arquitetura
anterior colapsam em dois, um por regra.

**Suficiência do estado.** A derivação deve **provar**, não assumir, que a
crença é estatística suficiente para R2 — que a história de R1 afeta R2 apenas
pelo posterior sobre `theta`. O argumento a provar usa o fato de R2 ser terminal:
o proponente reconhecido maximiza seu payoff corrente e não tem motivo para
condicionar em identidade ou história além da crença. A mera ausência de
pagamentos após uma falha de R1 não estabelece o lema.

**Obrigações de prova da forma extensiva.** Nenhuma pode ser usada como
premissa: (i) propostas com soma estritamente menor que 1 não são ótimas; (ii)
sob maioria, a proposta-hedge `s=(y,x,r_i)`, com `y>0` e `q-1` votos fracos, é
estritamente dominada pela proposta alternativa `s'=(0,x,r_i+y)` com os mesmos
votos; e (iii) o ramo em que uma proposta aprovada paga `y+o_theta` a `H` fora
do acordo **com `y>0`** não ocorre no caminho de equilíbrio — sob unanimidade é
inalcançável, e sob maioria sua exclusão do caminho deve decorrer da prova de
(ii); e (iv)
votos e demais ações fracas são não informativos sobre `theta`, de modo que o
posterior depende apenas do voto do próprio `H`. A quarta obrigação deve ser
demonstrada por Bayes nas histórias on-path a partir de `pi_H=0` e do fato de
nenhum weak state observar `theta`. Para histórias off-path, as crenças devem ser
explicitadas e a extensão do lema verificada; PBE sozinho não autoriza impor a
mesma atualização.

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

**O que ele elimina em R2.** Como R2 é terminal, a continuação de qualquer weak
state após falha é zero. Para o weak nonproposer `j`:

```text
perfil dos outros                 sim      não
j é pivotal                       x_j      0
quota passa mesmo sem j           x_j      x_j
quota falha mesmo com j           0        0
```

Se `x_j>0`, `não` é fracamente dominado por `sim`. Se `x_j=0`, as ações dão o
mesmo payoff em todo perfil e a convenção de igualdade seleciona `sim`. Assim, o
refinamento elimina em R2 a falha coordenada sustentada por votos fracos contra
uma oferta estritamente positiva. Esta conclusão terminal não pode ser
transportada para R1 sem verificar as continuações.

**Ressalva obrigatória em R1.** Quando uma proposta de R1 falha, o vetor
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
tabela por uma única constante `c_j`, nem afirmar de antemão que um voto fraco é
dominado independentemente de `H` ou dos demais votos. `N3` e `N4` devem
verificar a dominância contra todos os perfis e valores de continuação do
assessment. Se o refinamento não eliminar toda multiplicidade relevante em R1,
reportar o conjunto sobrevivente; não acrescentar uma restrição de crenças ou
uma ordem de eliminação.

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

**Aplicação a `H`.** Stage-undominated voting **não se aplica a `H`**. Sua ação
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

**Não informatividade dos votos fracos — lema, não assessment mantido.** A
expressão `weak-vote-passive assessment` pode nomear apenas o resultado a ser
provado; ela não é suposição nem refinamento. Sob `pi_H=0`, nenhum weak state,
inclusive o proponente, observa `theta`, de modo que nenhuma estratégia fraca
pode condicionar diretamente no tipo. On path, `N4` deve demonstrar por Bayes
que ações fracas são não informativas sobre `theta` e que o posterior depende
apenas do voto do próprio `H`. Fora do caminho, PBE não disciplina crenças por
Bayes; o nó deve tornar explícitas as crenças após cada história relevante e
verificar se o lema se estende. Se não se estender sob todos os assessments
admissíveis necessários à caracterização, parar e escalar em vez de impor o
resultado como restrição. O voto de `H` permanece informativo e atualiza
crenças.

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

Do mais simples ao mais difícil. A substituibilidade de `H` sob maioria limita
seu preço, mas não autoriza concluir de antemão que sua informação é inerte.
Inclusão, exclusão e screening devem ser derivados em cada região.

```text
N1  R2 maioria           dá o valor terminal e o preço do substituto; deriva
                         inclusão ou exclusão sem assumir no-screening.
N2  R2 unanimidade       screening puro, sem sinalização (terminal).
                         Candidato: G = 1-o_1, L(nu) = (1-nu)(1-o_0),
                         M(nu) = max{G,L}, nu* = (o_1-o_0)/(1-o_0).
                         Rederivar sob as primitivas novas; não importar.
N3  R1 maioria           prova a dominância que elimina o hedge e deriva as
                         três regiões em torno do preço a do voto substituto.
N4  R1 unanimidade       screening sequencial puro de dois períodos; prova ou
                         refuta separating e caracteriza pooling/falha.
N6  Comparação           produto cartesiano dos assessments; delay e renda
                         informacional contra o benchmark público por regra e
                         por ramo;
                         resposta às perguntas 1 e 2, condicional à organização
                         existir sob ambas as regras.
```

`N1` e `N2` são independentes e podem ser derivados em paralelo. `N3` consome
`N1`; `N4` consome `N2`. `N6` consome diretamente `N3` e `N4`.

**Sobre N4.** Com stage-undominated voting restrito aos weak nonproposers,
`T^Y` em toda igualdade e estratégias puras no ballot, `N4` deve provar — não
assumir — se o ramo de falha fraca sai do caminho, que não existe equilíbrio
separating e se restam apenas pooling e falha deliberada. A decisão do autor
antecipa que não haverá atraso em equilíbrio e que a opção de esperar
precificará o acordo mesmo sem ser exercida; ambas as afirmações permanecem
obrigações de prova. Nenhuma mistura pode ser introduzida para obter o efeito
ratchet.

Com `o_0>0`, a desigualdade estrita candidata `a_U<a_M` deixa de ter o ponto de
fronteira que produzia igualdade, mas ainda deve ser verificada na derivação dos
nós correspondentes.

---

### 7.1 Estrutura de goals

O DAG é construído **antes** de qualquer derivação, não depois. Um DAG post hoc
descreve o que foi feito; um DAG a priori restringe o que pode ser feito. Com as
interfaces registradas por hash antes de derivar, mudar silenciosamente um valor
de continuação invalida os consumidores automaticamente.

```text
Goal 0  Contrato e infraestrutura
        Fechar este Gate 0 após aprovação do autor. Construir o DAG com os cinco
        nós, arestas, e interfaces vazias com schema declarado (7.2). Registrar
        a regra de invalidação. Revisão independente do contrato antes de
        qualquer derivação.

Goal 1  Nós baratos — N1, N2, N3
        N1 e N2 em paralelo; N3 consome N1. N3 deriva a dominância do hedge e
        as três regiões, sem assumir informação privada inerte. Um ciclo de
        revisão ao final do batch, não por nó.

Goal 2  Nó caro — N4
        R1 unanimidade, sozinho, com ciclo de revisão próprio. Consome a
        interface congelada de N2. Prova inexistência de separating, ausência
        ou presença de delay e não informatividade dos votos fracos sob puras.

Goal 3  Comparação — N6
        Consome diretamente N3 e N4. N6 assina a resposta às perguntas 1 e 2
        da Seção 1, condicional à organização existir sob as duas regras.
        Entrega obrigatória ao autor, em linguagem corrente e sem jargão:
        o equilíbrio, a intuição e o take away substantivo.

Goal 4  Migração para formal_model_v6.Rmd
        Só após PASS 0/0/0 dos dois revisores em Goal 3.
```

**Escopo da infraestrutura.** Manter DAG, hashing de interfaces e a regra de
invalidação: é isso que dá a disciplina de dependência. Não replicar as camadas
de release/review/status bundles, o manifesto de 27 artefatos protegidos nem os
verificadores de mutação da cadeia anterior — foi daí que veio a maior parte do
custo, e não da auditabilidade em si.

### 7.2 Schema de interface

Todo nó exporta o mesmo objeto, como função da crença que entra nele. Fixar isto
**agora**, antes de derivar, evita os dois modos de falha da cadeia anterior:
congelamento prematuro, quando o consumidor precisa de algo que o produtor não
exportou, e inchaço de interface, quando o produtor exporta tudo por precaução.

```text
Para cada nó, em função da crença de entrada:

  1. payoff do proponente reconhecido
  2. valor esperado pré-reconhecimento de um weak nonproposer
       -> é isto que, transportado uma vez por beta, vira o preço do voto
          na rodada anterior; valor e regiões devem ser derivados
  3. payoff de H por tipo, theta = 0 e theta = 1
  4. distribuição de outcomes: passagem com H, passagem sem H, falha
       -> e, nos nós de R1, atraso, que é o que responde à pergunta 1
  5. benchmark de informação completa: payoff de H por tipo, theta=0 e
       theta=1, no mesmo nó e sob a mesma regra com theta público desde t=0
       e todas as demais primitivas idênticas
```

O schema não contém decisão ou valor de formação. A renda informacional é a
diferença entre o payoff sob informação privada e a coordenada correspondente
do benchmark de informação completa; ela não é inferida de `U_H-o_theta`.
O ramo que produz cada payoff público — inclusão, exclusão, continuação ou falha
— e sua data devem constar do ledger de claims do nó. Isso não amplia o schema
comum: é parte da correspondência completa exigida na Seção 8.

Qualquer nó que precise exportar mais do que isto deve declarar a extensão do
schema no DAG antes de derivar, com justificativa.

## 8. O que cada nó deve entregar

Além do schema de 7.2: correspondência completa de equilíbrio com payoffs por
tipo e por identidade; crenças on-path e off-path explícitas; interface
congelada com hash para o consumidor; e ledger de claims classificando cada
resultado como `proved`, `checked numerically`, `conjecture`, `pending` ou
`rejected`. O benchmark de informação completa deve ser resolvido sob a mesma
regra, por ramos, e reportado nas mesmas unidades antes de calcular qualquer
renda informacional. O nó deve registrar qual ramo gera o payoff público de cada
tipo e não pode impor inclusão de `H` como parte da definição do benchmark.

`N6` deve entregar, adicionalmente, resposta explícita e assinada às perguntas 1
e 2 da Seção 1, incluindo o desfecho negativo se for o caso.

---

## 9. Obrigações de prova que não podem ser assumidas

As decisões de protocolo D1--D9 e a decisão autoral de 2026-08-17 sobre o escopo
de stage-undominated voting estão resolvidas. Os itens abaixo são resultados que
a derivação deve provar sob essas decisões; nenhum pode ser inserido como
premissa ou orientação de resultado.

**P0 — Uso integral da pie em equilíbrio.** A factibilidade permite
`y+sum_j x_j+r_i<1`. Deve-se provar que propostas com folga não maximizam o
payoff do proponente; não se pode substituir a desigualdade factível por uma
igualdade primitiva.

**P1 — Dominância do hedge sob maioria.** `N3` deve provar que oferecer `y>0` e
comprar simultaneamente `q-1` votos fracos na proposta `s=(y,x,r_i)` é
estritamente dominado pela proposta `s'=(0,x,r_i+y)`, com os mesmos pagamentos
aos `q-1` weak states. A comparação é entre propostas ex ante e preserva a soma
orçamentária; não é realocação depois do ballot. O resultado depende da pie fixa,
da execução integral de `y` e da IC de `H`, e não pode ser assumido.

**P1a — Ausência on-path do ramo aprovado sem `H` com `y>0`.** Deve-se provar
que a história em que uma proposta com `y>0` passa sem `H` e lhe paga
`y+o_theta` não ocorre no caminho de equilíbrio. Sob unanimidade a história é
inalcançável porque o `não` de `H` derruba a proposta. Sob maioria, a conclusão
deve seguir da prova de P1, não de uma regra de implementação que destrua ou
reverta `y`. A obrigação não elimina a exclusão com `y=0`, preservada em P2.

**P2 — Três regiões de N3.** Com `a` como preço do voto fraco substituto, `N3`
deve derivar separadamente os casos em que ambos os tipos de `H` estão acima de
`a`, ambos abaixo, e `o_0<a<o_1`. Inércia informacional sob maioria não é
premissa. Nos pontos `o_theta=a`, a fronteira deve respeitar `T^Y`, que exige
aceitação na igualdade.

**P3 — Inexistência de separating em R1 unanimidade.** `N4` deve provar, sob
estratégias puras e `T^Y` em toda igualdade, se candidatos separating falham e
se pooling ou falha deliberada esgotam os equilíbrios admissíveis. A ausência de
delay também deve sair dessa prova, não da descrição do nó.

**P4 — Não informatividade dos votos fracos.** `N4` deve provar por Bayes, nas
histórias on-path, que, como nenhum weak state observa `theta`, suas ações são
não informativas e o posterior depende apenas do voto de `H`.
`Weak-vote-passive assessment` é o nome do lema, não uma restrição mantida de
crenças. Como PBE deixa livres crenças após histórias de probabilidade zero, o
nó deve verificar separadamente se o lema se estende às histórias off-path
relevantes. Se não se estender, registrar o finding e escalar; não converter o
lema em assessment imposto.

**P5 — Suficiência do posterior em R2.** Deve-se provar que, como R2 é terminal e
o reconhecimento é iid com reposição, histórias públicas com o mesmo posterior
induzem o mesmo problema de maximização, sem impor estratégias Markov como
restrição.

**P6 — Unicidade on-path após o refinamento.** Espera-se que stage-undominated
voting dos weak nonproposers restaure unicidade no caminho de equilíbrio, mas
isso deve ser **provado por nó**, não assumido. Crenças em propostas e vetores de
votos off-path permanecem livres e podem impedir dominância em R1 ou sustentar
multiplicidade residual. Se sobrar multiplicidade que impeça responder às
perguntas 1 e 2, parar e reportar, não adicionar seleção ad hoc.

**P7 — Informatividade do voto de `H` em R1.** O voto de `H` é público e entra
em `nu'`. Isso é o motor do mecanismo e não deve ser truncado. Mas gera um ramo
de sinalização em R1 que precisa de tratamento explícito de crenças off-path.

**P8 — Benchmark público por ramos.** Cada nó deve resolver o mesmo jogo com
`theta` público e provar qual ramo prevalece para cada tipo. Condicional à
inclusão, deve provar oferta na reserva relevante e aceitação na igualdade;
condicional à exclusão sob maioria, deve provar `y=0`, voto `não` de `H` e payoff
`o_theta` na data corrente; após falha em R1, deve importar uma única vez por
`beta` o benchmark público de R2. A definição contrafactual é primária. A medida
simples de excesso sobre a opção externa só pode ser usada no ramo e na data em
que sua equivalência tiver sido provada. A aceitação de `H` na igualdade segue
PBE e `T^Y`; stage-undominated voting não se aplica a `H`.

---

## 10. No-go list

Não promover a resultado, caption ou conclusão, sem rederivação sob estas
primitivas:

- opt-out imediato, exclusão de `H` por voto passado, ou qualquer ação de saída
  assimétrica;
- `o_theta` disparado por um voto `não` antes de o jogo terminar, ou payoff de
  R2 importado em R1 sem exatamente uma aplicação de `beta`;
- destruição de `y`, reversão de `y` ao residual ou qualquer realocação
  contingente ao resultado do ballot; uma proposta aprovada é executada
  integralmente e `H` recebe `y+o_theta` se ela passa com seu voto `não`;
- redução exaustiva a `P/L/R`; rejected-history reduction lemma;
- maioria como benchmark geral de no-screening, exclusão geral ou inclusão
  geral — `N3` deve derivar as três regiões em torno do preço substituto;
- afirmação universal de que o benchmark público inclui `H` sob ambas as regras,
  ou substituição global do contrafactual por `U_H-o_theta`; inclusão, exclusão,
  continuação e data devem ser derivadas por ramo;
- dominância do hedge, inexistência de separating, ausência de delay ou
  não informatividade dos votos fracos tratadas como premissas;
- calibração OPEC histórica, arquitetura feasibility/C-B-R, `pi_H > 0`,
  escolha endógena de regra, decisão de entry, delayed continuation, hybrid exit;
- qualquer teorema, fronteira ou ranking da cadeia `pivotal-response`;
- `weak-vote-passive assessment` chamado de refinamento ou imposto em vez de
  provado como lema;
- mixed strategies no ballot ou exceção a `T^Y` em igualdade endógena;
- stage-undominated voting descrito como restrição de crenças, aplicado a `H`
  ou estendido por uma eliminação ordenada weak-first;
- igualdade em uma linha isolada usada para acionar `T^Y` apesar de preferência
  estrita no problema relevante do votante;
- uma única continuação `c_j` atribuída a todos os vetores de falha de R1 sem
  provar que as histórias induzem o mesmo valor.

---

## 11. Protocolo de revisão

Implementador não revisa; revisor não edita. Após cada nó, e obrigatoriamente ao
final da cadeia, duas revisões independentes read-only: uma `review-formal-model`
e uma auditoria adversarial de teoria dos jogos. Qualquer finding exige reparo
pelo implementador e rereview dos hashes novos. Nenhuma migração para
`formal_model_v6.Rmd` antes de PASS `0/0/0` dos dois revisores.

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
mensagem; uma resolução errada propaga por cinco nós e só aparece goals depois.

Todo parecer completo salvo em `quality_reports/YYYY-MM-DD_nome.md` antes de
resumir. Nunca truncar.

**Reporte ao autor ao final de cada goal.** Em linguagem corrente, sem jargão
interno. Notação inventada na derivação deve ser traduzida antes de aparecer.
Cada reporte diz: o que foi feito, por que, e qual pergunta o autor deve fazer
para verificar que o resultado está alinhado com o que ele quer. Nenhum goal
avança sem esse aval.

---

## 12. Invalidação

Qualquer mudança no espaço ou na implementação das propostas, destino de `y`,
estatuto ou data de `o_theta`, conceito de solução, restrição a estratégias
puras, convenção de igualdade, tie-break de proposta, estrutura de informação,
lei de reconhecimento, timing do desconto, benchmark de informação completa ou
escopo condicional da comparação reabre este Gate 0 e invalida todo nó
descendente.

---

## 13. Estado do repositório na abertura

```text
HEAD      f53e6769624ce3dd6e64e21ad40d08230b0950a7
branch    main
worktree  limpo exceto por este documento
```

`formal_model_v6.Rmd` e `formal_model_v5.Rmd` intocados. A cadeia
`pivotal-response` permanece no repositório como proveniência: não editar, não
migrar, não citar como evidência corrente.

Antes de iniciar a derivação, usar o workflow `paper-version` para criar o
marcador pré-arquitetura. Não criar tag em worktree suja.

---

## 14. Prompt de abertura da próxima sessão

```text
Estamos no repo PowerBayesianPersuasion. Leia AGENTS.md e, como contrato
normativo, quality_reports/plans/2026-08-12_essential_input_gate0.md. Use as
skills solve-dynamic-games e paper-version.

O contrato está APPROVED e autoriza o Goal 0, e só o Goal 0. Ele substitui a
cadeia pivotal-response, que permanece no repositório apenas como proveniência:
não editar, não migrar, não citar como evidência corrente. Não editar nem
compilar formal_model_v5.Rmd ou formal_model_v6.Rmd.

Goal 0 tem três entregas, nesta ordem:
1. marcador de versão pré-arquitetura pelo workflow paper-version, pedindo
   autorização antes de criar tag ou branch, e nunca em worktree suja;
2. mapa de dependências com os cinco nós `N1`, `N2`, `N3`, `N4` e `N6`, arestas
   conforme a Seção 7, e interfaces vazias declarando o schema da Seção 7.2;
3. revisão independente do próprio contrato, read-only, por dois revisores que
   não o escreveram, com a instrução da Seção 11: verificar, para cada
   primitiva, se ela é necessária ao mecanismo ou se está ali por conveniência
   de tratabilidade.

Não iniciar nenhuma derivação. Os cinco nós permanecem `pending` e não
autorizados até o Goal 0 fechar com PASS dos dois revisores.

Regras que valem desde o primeiro minuto. O default de qualquer finding é
escalar ao autor; o ônus da prova é de quem quiser classificar como técnico, e o
teste é se existe exatamente um reparo forçado pelo que já está escrito. Toda
ambiguidade e toda definição faltando escalam sempre, sem exceção, em lote na
fronteira do goal quando não bloqueiam e na hora quando bloqueiam. Quem
implementa não revisa e quem revisa não edita. Ao fechar o goal, reportar ao
autor em linguagem corrente, sem jargão interno e sem notação inventada na
derivação, dizendo o que foi feito, por que, e qual pergunta ele deve fazer para
verificar alinhamento.
```
