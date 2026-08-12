# Gate 0 — Arquitetura essential-input

**Data:** 2026-08-12
**Status:** `APPROVED` — aprovado pelo autor em 2026-08-12. Autoriza o Goal 0.
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

### As cinco decisões, e o que observar

**1. Ninguém tem botão de saída.** Todos votam sim ou não, e um não é só um não.
Antes, o não de `H` significava "saio da organização para sempre", e nenhum
acordo futuro podia incluí-lo. Isso dava a `H` um poder que os fracos não tinham
e, pior, impedia `H` de recusar hoje para negociar melhor amanhã — que é
justamente o mecanismo que queremos.
*Observe:* se em algum momento reaparecer a ideia de que `H` "sai" ao votar não,
está errado.

**2. A alternativa externa de `H` é o que ele recebe se nada for acordado.**
Igual aos fracos, que recebem zero. Antes, `H` recebia sua alternativa
imediatamente e sem desconto, enquanto os fracos só acessavam suas continuações
descontadas — o que inflava artificialmente o preço de `H` por razão errada.
*Observe:* `H` deve ficar mais fraco com essa correção, não mais forte. Se o
resultado ficar mais fácil de obter, algo está errado.

**3. Cada um vota como se seu voto fosse o decisivo.** Em votação simultânea
existe um problema conhecido: se ninguém sozinho muda o resultado, todo mundo
pode votar qualquer coisa, e o modelo passa a admitir que todos rejeitem um bom
acordo. Isso é patologia de votação, não descoberta sobre organizações. A
correção padrão — usada por Baron e Ferejohn, que é a base do modelo — é exigir
que cada votante escolha o que seria melhor **se seu voto decidisse**.
*Observe:* isso é um refinamento declarado, e deve estar dito no paper como tal,
não escondido dentro de uma prova.

**4. Empate conta como aceitação.** Quando a oferta dá a alguém exatamente o que
ele teria recusando, a regra do item 3 não decide nada — as duas opções valem o
mesmo, e nenhuma é pior. Precisa de uma convenção, e a convenção é: aceita. Sem
ela o proponente ficaria querendo oferecer "um centavo a mais que o mínimo", que
não existe, e o modelo perde solução fechada. Nos documentos técnicos isso
aparece como `T^Y`; é só isso que significa.
*Observe:* os itens 3 e 4 não competem. Um decide quando há preferência estrita,
o outro quando há empate. A confusão entre os dois travou o trabalho em agosto.

**5. O bolo é sempre o mesmo, com ou sem `H`.** Decisão sua, reafirmada, e
definitiva para este paper. É menos realista, e é o preço de isolar o mecanismo.
*Observe:* se alguém propuser que o acordo vale menos sem `H` "porque é mais
realista", é alternativa já eliminada. Vai para outro paper.

### Como o trabalho é dividido, e o que checar em cada etapa

Resolve-se de trás para frente: a última rodada primeiro, porque a decisão de
hoje depende do que acontece amanhã.

**Goal 1 — as partes fáceis.** Maioria nas duas rodadas, e unanimidade na
segunda. São fáceis porque, sob maioria, a informação privada de `H` não faz
diferença: ele é substituível, então nunca é preciso descobrir o tipo dele.
*Checar:* a exclusão de `H` sob maioria tem que **sair como resultado**,
condicionada ao tamanho da organização, e não entrar como suposição. A conta
esperada é que os fracos excluam `H` quando a organização for grande o
bastante — porque aí cada voto fraco é individualmente barato.

**Goal 2 — a parte difícil.** Unanimidade na primeira rodada. É aqui que o paper
se decide. A pergunta: o tipo "barato" de `H` finge ser o tipo "caro", recusa a
primeira oferta e espera uma melhor?
*Checar:* se a resposta for não — se todo equilíbrio revelar os tipos — então
não é a informação privada que explica a preferência por unanimidade, e sim
apenas a proteção da alternativa externa. Achado informativo, e contrário à
prior do autor. **Nos dois casos o resultado é reportado como saiu**, sem ajuste
de suposição depois de visto. Compromisso escrito na Seção 1.

**Goal 3 — juntar tudo e responder.** Formação da organização e comparação entre
as regras. Ao final desta etapa, apresentação do equilíbrio, da intuição e do
take away substantivo, em linguagem corrente.

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
primitiva atual, `H` alcança R2 apenas votando sim. Rejeitar termina o jogo.
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

**Duas perguntas que a derivação deve responder:**

1. **Delay.** Existe atraso em equilíbrio, e ele é dependente da regra?
2. **Sobrevivência da renda.** O payoff de equilíbrio de `H` excede
   estritamente sua opção externa **por causa** da informação privada, e esse
   excesso é maior sob unanimidade que sob maioria?

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
Pacote         y in [0, y_bar] concedido a H, reduz o residual fraco 1-para-1
Payoff de H    y se o acordo o inclui; b_theta = 0
Desacordo      weak state: 0;  H: o_theta, com 0 <= o_0 < o_1 <= y_bar <= 1
Agenda         pi_H = 0 em toda rodada; só weak states propõem
Reconhecimento uniforme entre os m weak states, probabilidade 1/m
Desconto       beta in (0,1]
Custo de entry chi >= 0, coletivo, subtraído só depois da barganha
Rodadas        duas; R2 terminal
```

`o_theta` é primitivo. Mapeamentos como `o_theta = alpha V(theta)` pertencem a
aplicação, ilustração numérica ou microfundamento, e não são impostos.

A opção externa de `H` é **externa à pie institucional**: quando `H` é excluído,
a coalizão fraca dispõe da unidade inteira e `H` recebe `o_theta` de fora.

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

- **Escolha**: `o_theta` é o **payoff de desacordo** de `H`, realizado ao fim do
  jogo se nenhum acordo passar, exatamente como o payoff de desacordo zero dos
  weak states. Recebe o mesmo tratamento de data e desconto que o de qualquer
  outro jogador.
- **Alternativas descartadas**:
  - *`o_theta` imediato e sem desconto em R1*: descartada porque cria uma
    assimetria de timing — `H` acessa sua opção externa sem desconto enquanto os
    fracos só acessam continuações descontadas — que infla artificialmente o
    preço de reserva de `H` e favorece o resultado pretendido por razão errada.
  - *Híbrido `max{o_theta, beta*C_theta}`*: descartada como primitiva porque
    passa a ser **consequência** do desenho simétrico, não suposição. Se `H`
    tem valor de continuação superior, isso aparece na IC; não precisa ser
    imposto.

**Consequência registrada.** Sob maioria, a condição para o proponente de R1
excluir `H` passa de `o_0 >= beta/m` para `o_0 >= 1/m`, isto é,
`N >= 1 + 1/o_0`. Condição mais exigente. Com `o_0 = 0.2` exige `N >= 6`; com
`o_0 = 0.1`, `N >= 11`. Isso é cota de escopo em `N`, substantivamente
interpretável e não assumida.

### Decisão: conceito de solução no ballot

- **Escolha**: **PBE com stage-undominated voting**, mais a convenção `T^Y` de
  aceitação na igualdade. Os dois instrumentos, e sua divisão de trabalho, estão
  especificados na Seção 5.
- **Alternativas descartadas**:
  - *PBE puro sem restrição de votação (arquitetura pivotal-response)*:
    descartada porque admite equilíbrios de falha coordenada em que dois ou mais
    fracos votam não apesar de preferirem estritamente sim condicional a serem
    pivotais. Isso destrói unicidade em `N >= 4` e torna as perguntas 1 e 2 da
    Seção 1 não respondíveis. Baron & Ferejohn (1989), base do modelo, excluem
    exatamente esses equilíbrios.
  - *`T^Y` como substituto da undominância*: descartada porque a dicotomia é
    falsa. Na igualdade a undominância não elimina ação alguma, logo não há o
    que substituir. Os dois instrumentos operam em domínios disjuntos. Esta é a
    resolução da pendência registrada em
    `quality_reports/2026-08-05_goal3_accept_at_equality_pending.md`.
  - *Eliminação de dominância fraca sobre estratégias completas*: descartada
    porque é dependente da ordem de eliminação e não é o objeto padrão da
    literatura de barganha legislativa.

### Decisão: a pie não depende de `H`

- **Escolha**: o surplus institucional dos fracos é **fixo e normalizado em 1**,
  independente do tipo de `H` e independente de `H` estar ou não no acordo.
  Quando `H` é excluído, a coalizão fraca dispõe da unidade inteira e `H` recebe
  `o_theta` de fora. Decisão do autor em 2026-08-12, definitiva para este paper.
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
t=1   Reconhecimento uniforme de um weak state i entre os m
      i propõe s = (y, (x_j)_{j != i}) com y >= 0, x_j >= 0, residual r_i >= 0
      Ballot simultâneo e selado de todos os não proponentes, inclusive H;
        i conta como sim
      Fecha o ballot; o vetor completo de votos e o resultado tornam-se públicos
      Se os sim atingem q: acordo implementado, jogo termina
      Se não: segue para t=2
t=2   Reconhecimento uniforme de um weak state entre os m
      Proposta, ballot simultâneo e selado, publicação
      Se os sim atingem q: acordo implementado
      Se não: payoffs de desacordo — 0 para cada weak state, o_theta para H
t=3   Entry coletiva: a coalizão fraca forma se e somente se o valor coletivo
        bruto por estado fraco G_R >= chi; forma na igualdade
```

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
pelo posterior sobre `theta`. Isso vale porque a falha de R1 não transfere
pagamentos nem altera conjuntos de ação, mas precisa constar como lema.

---

## 5. Conceito de solução

**Base.** Perfect Bayesian equilibrium. Crenças on-path por Bayes. Em propostas
de probabilidade zero, a crença de ballot é componente explícito do assessment e
não é restringida por Bayes; o proponente desviante avalia seu desvio com a
distribuição verdadeira pré-proposta.

**Refinamento — stage-undominated voting.** Em cada ballot, tomando como dados
os valores de continuação induzidos pelo próprio assessment, a ação de cada
votante não pode ser fracamente dominada no stage game daquele ballot. Uma ação
`a` é eliminada quando existe `a'` que dá payoff pelo menos igual contra todo
perfil dos demais votos e estritamente maior contra algum.

Isto é refinamento de PBE implementado como **restrição de estratégias**, não de
crenças. Não pertence à família sequential equilibrium / D1 / intuitive
criterion. É condição de ponto fixo: o assessment é admissível se, em cada
information set de ballot, a ação prescrita é não dominada no stage game
induzido por aquele mesmo assessment.

**O que ele elimina.** Para o não proponente fraco `j`, com pagamento `x_j` e
continuação `c_j`:

```text
perfil dos outros          sim      não
todos sim (j pivotal)      x_j      c_j
algum não (j irrelevante)  c_j      c_j
```

Se `x_j > c_j`, o `não` é fracamente dominado e sai; se `x_j < c_j`, o `sim`
sai. A eliminação é unilateral, logo mata os equilíbrios de falha coordenada
independentemente do que os outros fracos façam.

**Convenção de igualdade — `T^Y`.** Em `x_j = c_j` as duas colunas são idênticas
em toda linha. Nenhuma ação domina a outra e a undominância é **silenciosa**.
`T^Y` decide: o agente aceita quando a oferta iguala exatamente sua opção
externa ou seu valor de continuação. Sua função é fechar o conjunto de ofertas
aprováveis, garantir máximos e evitar argumentos de epsilon e ínfimos não
atingidos.

Os dois instrumentos têm domínios disjuntos:

```text
x_j > c_j  ou  x_j < c_j   ->  undominância decide
x_j = c_j                  ->  undominância silenciosa, T^Y decide
```

**Aplicação a `H`.** A undominância se aplica igualmente a `H`. Nota antecipada
para a derivação, a ser verificada e não assumida: quando o assessment faz a
continuação de R2 depender do voto de `H`, a ação de `H` é payoff-relevante em
todo perfil e a undominância tende a ficar slack, com o PBE já determinando a
melhor resposta em esperança. Onde as crenças não respondem ao voto de `H`, sua
decisão reduz-se à comparação na linha de aprovação.

**Assessment de votos fracos.** Mantém-se a linguagem
`weak-vote-passive assessment`, e ela **não** deve ser chamada de refinamento. A
defesa é informacional: weak states não observam `theta`, então seus desvios
unilaterais de voto não sinalizam diretamente o tipo de `H`. O voto do próprio
`H` é informativo e atualiza crenças — e nesta arquitetura isso é o motor do
mecanismo, não ruído a ser truncado.

---

## 6. Timing do desconto

R2 é terminal e resolve-se inteiramente em unidades correntes, sem `beta`
interno. `beta` incide **exatamente uma vez**, quando um valor de R2 entra numa
comparação de incentivos de R1. Nenhum payoff de desacordo é privilegiado com
acesso sem desconto.

---

## 7. Ordem de derivação

Do mais simples ao mais difícil. A dificuldade é assimétrica entre as regras, e
a assimetria é o próprio mecanismo: sob maioria a informação privada fica inerte
porque `H` é substituível, e o jogo é quase de informação completa.

```text
N1  R2 maioria           quase informação completa. Dá o valor terminal
                         e o preço do substituto.
N2  R2 unanimidade       screening puro, sem sinalização (terminal).
                         Candidato: G = 1-o_1, L(nu) = (1-nu)(1-o_0),
                         M(nu) = max{G,L}, nu* = (o_1-o_0)/(1-o_0).
                         Rederivar sob as primitivas novas; não importar.
N3  R1 maioria           preço do voto fraco a_M = beta/m; condição de
                         exclusão o_0 >= 1/m; benchmark.
N4  R1 unanimidade       ÚNICO NÓ DIFÍCIL. Screening sequencial de dois
                         períodos com proponente desinformado.
N5  Entry                valor coletivo bruto G_R por regra; formação em
                         G_R >= chi.
N6  Comparação           produto cartesiano dos assessments; delay e renda
                         por regra; resposta às perguntas 1 e 2.
```

`N1` e `N2` são independentes e podem ser derivados em paralelo. `N3` consome
`N1`; `N4` consome `N2`. `N5` consome `N3` e `N4`. `N6` consome `N5`.

**Sobre N4.** Com stage-undominated voting o proponente paga cada não proponente
fraco pelo menos `a_U = beta*M(nu')/m`, e o ramo de falha fraca sai do caminho
de equilíbrio — o que deve ser **provado**, não assumido. Provado isso, R1
unanimidade reduz-se a: proponente oferece `y_1`; `H` aceita ou rejeita; se
rejeita, a crença sobe para `nu'` e o jogo entra na solução de `N2`. Objeto
padrão, com literatura estabelecida em screening sequencial de horizonte finito
(Sobel & Takahashi 1983; Fudenberg, Levine & Tirole). O efeito ratchet é
esperado: o tipo baixo mistura entre aceitar e rejeitar, tornando a rejeição
informativa sem ser plenamente reveladora.

Note de passagem que `a_U = beta*M(nu')/m < a_M = beta/m`, porque o prêmio de R2
sob unanimidade é `M(nu') < 1`. Weak states valem menos sob unanimidade, o que é
parte de por que preferem maioria.

---

### 7.1 Estrutura de goals

O DAG é construído **antes** de qualquer derivação, não depois. Um DAG post hoc
descreve o que foi feito; um DAG a priori restringe o que pode ser feito. Com as
interfaces registradas por hash antes de derivar, mudar silenciosamente um valor
de continuação invalida os consumidores automaticamente.

```text
Goal 0  Contrato e infraestrutura
        Fechar este Gate 0 após aprovação do autor. Construir o DAG com os seis
        nós, arestas, e interfaces vazias com schema declarado (7.2). Registrar
        a regra de invalidação. Revisão independente do contrato antes de
        qualquer derivação.

Goal 1  Nós baratos — N1, N2, N3
        N1 e N2 em paralelo; N3 consome N1. Informação privada inerte em N1 e
        N3; screening puro sem sinalização em N2. Um ciclo de revisão ao final
        do batch, não por nó.

Goal 2  Nó caro — N4
        R1 unanimidade, sozinho, com ciclo de revisão próprio. Consome a
        interface congelada de N2. É aqui que o efeito ratchet aparece ou não.

Goal 3  Entry e comparação — N5, N6
        Consomem N3 e N4. N6 assina a resposta às perguntas 1 e 2 da Seção 1.
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
       -> é isto que vira o preço do voto na rodada anterior:
          a_M = beta/m  a partir de N1;  a_U = beta*M(nu')/m  a partir de N2
  3. payoff de H por tipo, theta = 0 e theta = 1
  4. distribuição de outcomes: passagem com H, passagem sem H, falha
       -> e, nos nós de R1, atraso, que é o que responde à pergunta 1
```

Qualquer nó que precise exportar mais do que isto deve declarar a extensão do
schema no DAG antes de derivar, com justificativa.

## 8. O que cada nó deve entregar

Além do schema de 7.2: correspondência completa de equilíbrio com payoffs por
tipo e por identidade; crenças on-path e off-path explícitas; interface
congelada com hash para o consumidor; e ledger de claims classificando cada
resultado como `proved`, `checked numerically`, `conjecture`, `pending` ou
`rejected`.

`N6` deve entregar, adicionalmente, resposta explícita e assinada às perguntas 1
e 2 da Seção 1, incluindo o desfecho negativo se for o caso.

---

## 9. Pendências de protocolo não resolvidas neste Gate 0

Registradas conforme a regra do projeto. Nenhuma pode ser resolvida dentro de
uma prova.

**P1 — Unicidade on-path após o refinamento.** Espera-se que stage-undominated
voting restaure unicidade no caminho de equilíbrio, mas isso deve ser **provado
por nó**, não assumido. Crenças em propostas off-path permanecem livres e podem
sustentar multiplicidade residual. Se sobrar multiplicidade que impeça responder
às perguntas 1 e 2, parar e reportar, não adicionar seleção ad hoc.

**P2 — Informatividade do voto de `H` em R1.** O voto de `H` é público e entra
em `nu'`. Isso é o motor do mecanismo e não deve ser truncado. Mas gera um ramo
de sinalização em R1 que precisa de tratamento explícito de crenças off-path.

---

## 10. No-go list

Não promover a resultado, caption ou conclusão, sem rederivação sob estas
primitivas:

- opt-out imediato, exclusão de `H` por voto passado, ou qualquer ação de saída
  assimétrica;
- `o_theta` acessado sem desconto em R1;
- redução exaustiva a `P/L/R`; rejected-history reduction lemma;
- maioria como benchmark geral de no-screening — a exclusão é resultado
  condicional em `N`, não premissa;
- No-Cheap-H como condição de escopo assumida; ela é o resultado
  `o_0 >= 1/m` e deve ser derivada;
- calibração OPEC histórica, arquitetura feasibility/C-B-R, `pi_H > 0`,
  escolha endógena de regra, delayed continuation, hybrid exit;
- qualquer teorema, fronteira ou ranking da cadeia `pivotal-response`;
- `weak-vote-passive assessment` chamado de refinamento;
- stage-undominated voting descrito como restrição de crenças.

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

Qualquer mudança em espaço de ações, estatuto de `o_theta`, conceito de solução,
convenção de igualdade, estrutura de informação simultânea, timing do desconto,
regra de formação, ou na resposta a P1, reabre este Gate 0 e invalida todo nó
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
2. mapa de dependências com os seis nós N1..N6, arestas conforme a Seção 7, e
   interfaces vazias declarando o schema da Seção 7.2;
3. revisão independente do próprio contrato, read-only, por dois revisores que
   não o escreveram, com a instrução da Seção 11: verificar, para cada
   primitiva, se ela é necessária ao mecanismo ou se está ali por conveniência
   de tratabilidade.

Não iniciar nenhuma derivação. N1..N6 permanecem não autorizados até o Goal 0
fechar com PASS dos dois revisores.

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
