# Parecer Fable — Plano v2 da extensão de agenda (gated)

**Data:** 2026-08-23
**Objeto:** `quality_reports/plans/2026-08-23_agenda_extension_gated_plan_v2.md`
**SHA-256 do objeto:** `ef9b41b7d4875e06eaf19a764e2605b5c95a8a7aed1f5c6b41c67eb722bbf29b`
**Natureza:** feedback de desenho solicitado pelo §10 do próprio plano. Não é
um dos dois pareceres independentes do Gate 0 (ver Declaração de conflito).
**Formato:** findings bloqueantes e não bloqueantes, com transcrição,
leituras alternativas e consequências; depois respostas às dez perguntas.

---

## Veredito geral

A arquitetura é sólida e adota as proteções certas: namespace próprio,
continuações consumidas por hash, guardanapo rebaixado a conjectura
falsificável, nenhum refinamento presumido, quórum intermediário isolado em
Goal opcional, benchmark público como consumidor terminal. Recomendo adotar
o plano **com três adições bloqueantes ao Gate 0** — todas completude de
contrato, nenhuma arquitetural — e oito recomendações não bloqueantes.

O plano é pesado (sete Goals mais Q, dois pareceres e GO autoral por Goal).
O custo é decisão do autor; aponto abaixo onde ele pode ser reduzido sem
perder proteção (paralelismo de Goals 2–3; possível generalidade em `q` já
existente em N3).

---

## Findings bloqueantes (para o fechamento do Gate 0, não para o plano)

### B1 — Ação nula de `H` no estágio de proposta não está decidida

**Problema.** O §2.3 não decide se `H` pode **abster-se de propor** no
estágio `A` (ação nula que leva direto a `C`), ou se é obrigado a propor,
com "espera" implementada por proposta deliberadamente derrotada. P4 lista
"espera" como classe a testar, mas a forma extensiva não diz qual das duas
implementações existe.

**Por que importa.** As duas diferem como sinais: uma ação nula é uma ação
observável distinta, com atualização de crença própria; uma proposta
derrotada carrega o conteúdo da proposta como sinal. Também diferem na
estrutura off-path (uma proposta derrotada exige votos fracos
sequencialmente racionais; a ação nula não).

**Leituras alternativas.** (i) Sem ação nula: espaço de ações menor, espera
só via derrota, mais limpo, mas exige que os votos fracos na proposta
sacrificial estejam bem definidos. (ii) Com ação nula: espera não
sinalizante disponível por construção; espaço de ações maior; a crença após
a ação nula precisa de cláusula (Bayes se prescrita a algum tipo; livre se
desviante).

**Consequência.** Acrescentar ao §2.3 como item 10. Sem isso, P4 é
inexecutável tal como escrito.

### B2 — Seleção dentro do conjunto de pooling sustentado por crenças off-path

**Problema.** O §2.3 item 6 trata do empate entre propostas ótimas de `H`
dadas as crenças. Falta a decisão distinta e mais consequente: sob
unanimidade, a cláusula 5 (crença livre após desvio genuíno de `H`) deve
sustentar um **contínuo de equilíbrios de pooling** indexados pela demanda
aceita — crenças pessimistas fora do caminho (por exemplo, posterior 0, que
eleva a reserva fraca a `β(1−β·o_0)/m`) rejeitam demandas maiores e seguram
o pooling em níveis abaixo do máximo. Sob maioria, na célula de exclusão, a
continuação é livre de crença, então `A_M` tende a previsão única. A
comparação institucional viraria conjunto contra ponto.

**Leituras alternativas.** (i) Reportar correspondências completas e
enunciar comparações por elementos extremos ("o supremo do conjunto de
unanimidade supera maioria sse ..."). (ii) Seleção conservadora à la D9 do
jogo atual: dentro do conjunto, selecionar **contra** a tese do paper (o
elemento que minimiza o payoff de `H`), e reportar o iff do máximo como
cota superior. (iii) Refinamento de crenças (D1 ou análogo), que o plano
corretamente não presume. Não escolho; a escolha é autoral e deve ser feita
no Gate 0, não no meio do Goal 3 — decidir o princípio antes de conhecer
qual resultado ele favorece.

**Consequência.** Sem decisão prévia, o Goal 3 estaciona em P6 com
escalada previsível e um ciclo de revisão é desperdiçado. Acrescentar ao
§2.3 como item próprio, separado do item 6.

### B3 — Domínio de entrada e pertencimento de fronteiras

**Problema.** Pela interface congelada, a célula vazia de `C_U` é
`0 < ν ≤ ν*`, **com `ν*` incluído na célula vazia**. No estágio `A_U`, a
comparação as-if-pivotal do votante fraco referencia o valor de `C_U` no
posterior; onde `C_U` é vazio, nem "aceitar sempre" é verificável. Logo o
domínio núcleo de `A_U` é `{0} ∪ (ν*, 1]`, salvo prova em contrário via
P10, e o contrato precisa dizer isso — inclusive o que acontece com prior
exatamente igual a `ν*`, `ν_SE`, `ν_SP` (pertencimento aberto/fechado
herdado das interfaces, tornado explícito na tabela do contrato).

**Leituras alternativas.** (i) Declarar o domínio herdado e derivar só
nele. (ii) Tentar em P10 um equilíbrio em que a rejeição é inalcançável —
mas a racionalidade sequencial as-if-pivotal referencia a continuação
mesmo em eventos de probabilidade zero, então a leitura (ii) provavelmente
falha; se falhar, (i) é forçada.

**Consequência.** Sem a declaração, P2 e P5 ficam com domínio ambíguo e o
harness não sabe onde as fórmulas devem "falhar ruidosamente".

---

## Findings não bloqueantes

### NB1 — Pré-registrar a escalada esperada em cláusula 5 × célula vazia

Crenças livres após desvio de `H`, seguidas de rejeição, podem cair na
célula vazia de `C_U`. Restringir a crença livre ao domínio de existência é
uma seleção autoral. P10 tangencia isso; recomendo pré-registrar como
escalada esperada, com as alternativas, para não parecer improviso quando
ocorrer.

### NB2 — Paralelismo de Goals 2 e 3

`A_M` e `A_U` são mutuamente independentes. A cadência por fronteira de
dependência — princípio já adotado nesta casa — permite derivá-los em
paralelo com um único ciclo conjunto de revisão, mantendo a reconstrução
cega exclusiva de `A_U`. O sequenciamento atual é aceitável, apenas mais
lento.

### NB3 — Verificar se `C_M` já é genérico em `q`

A interface de N3 exibe `ν_SP = β(o_1−o_0)/(1 − β·o_0 − β(q−1)/m)` com `q`
genérico. Se a derivação congelada vale para `q` arbitrário na família
majoritária, o Goal Q encolhe: a família de continuações já existe e
faltaria só a família de estágios `A_q` e a comparação. Checar antes de
orçar o Goal Q como rederivação completa.

### NB4 — Consumibilidade das continuações públicas de N7

O Goal 1 verifica `C_M` e `C_U`, mas `AR` consome também as continuações
públicas congeladas de N7. Incluí-las no mesmo Goal de consumibilidade
custa pouco e evita descobrir campo faltante no Goal 5.

### NB5 — Data zero explícita

Declarar no contrato que o estágio `A` é a nova data zero e que toda
grandeza importada das interfaces converte com exatamente um `β` (o §2.1 e
P5 já dizem "uma única vez"; falta ancorar a origem). O invariante do §6
cobre o teste; falta a cláusula normativa.

### NB6 — Alvos prioritários de contraexemplo no §0

As células perigosas para as conjecturas são as de **screening/pooling sob
maioria** (`o_1 < 1/m`; `o_0 < 1/m < o_1` com `ν ≤ ν_SE`): ali a
continuação majoritária paga `H` de dentro da pie, o valor coletivo fraco
cai abaixo de 1, a reserva fraca em `A_M` cai, e a região de preferência
por unanimidade pode encolher ou sumir. Na célula de exclusão, ao
contrário, as conjecturas parecem robustas (verificação rápida: o tipo
alto não pode preferir maioria ali, porque
`(1−β) + β²o_1 − β·o_1 = (1−β)(1−β·o_1) > 0`). Registrar as células
perigosas no §0 orienta o harness do Goal 1.

### NB7 — Semi-pooling com mistura de propostas

Se o §2.3 item 5 admitir mistura no estágio de proposta, o candidato
natural é o tipo baixo misturando entre a demanda de pooling e uma demanda
baixa: o posterior após a demanda de pooling sobe acima do prior, o que
sob unanimidade **reduz** a reserva fraca e pode sustentar semi-separação
lucrativa. O lema de não-separação em puras não cobre esse caso. P4/P7 já
o listam; sinalizo apenas que a decisão do item 5 muda materialmente o
espaço de equilíbrios, não é detalhe.

### NB8 — Prosa de Steinberg e Stone não depende da extensão

O §9 posterga toda a migração narrativa para depois de `AR`. Os parágrafos
de Steinberg (triagem fontes/consequências/práticas não-racionalizáveis) e
de Stone (distinção contornar-a-regra versus valor-produzido-pela-regra)
apoiam-se nos resultados já congelados e poderiam acompanhar o ciclo de
revisão do abstract/intro já pendente, se o autor quiser adiantar. A única
trava real é a decisão tipo-a-tipo versus ex ante. Fica a critério do
autor; o conservadorismo do §9 também é defensável.

---

## Respostas às dez perguntas do §10

**1. Forma extensiva completa?** Quase. Falta decidir a ação nula de `H`
(B1) e declarar domínio de entrada e pertencimento de fronteiras (B3).
Com §2.3 itens 1–9 mais esses dois, não identifico outra ação, observação,
payoff, data ou transição pendente. A cadeia de informação está bem
especificada: proposta pública, ballot simultâneo, vetor revelado após o
fechamento, posterior herdado por `C`.

**2. Transporte do pacote de crenças correto?** Sim. As seis cláusulas
reproduzem a decisão de 2026-08-21 com a Emenda 1a, e a classificação da
proposta de `H` como ação do informado (Bayes on-path; cláusula 5 nos
desvios) está certa. Um caso a explicitar na tabela do contrato: proposta
on-path seguida de rejeição off-path por fracos — posterior = prior, por
no-signaling dos votos fracos mais Bayes na proposta. A interação da
cláusula 5 com a célula vazia é a escalada esperada (NB1).

**3. Precisa de refinamento adicional?** Para caracterizar a
correspondência PBE completa, não. Para enunciar a comparação
institucional como iff de ponto, **provavelmente sim** — sob unanimidade
deve sobrar um contínuo de pooling sustentado por crenças pessimistas,
enquanto maioria (célula de exclusão) tende a ponto único, belief-free. Os
resultados que dependem da decisão: o sinal e a forma do contraste em P8 e
as rendas pontuais de `AR`. Alternativas em B2; não insiro refinamento,
escalo a necessidade de decidir o princípio no Gate 0.

**4. `C_M` e `C_U` exportam o suficiente?** A lista do §3 é suficiente se
os campos existirem nos JSONs congelados — exatamente o que o Goal 1
verifica. Bom sinal: a interface de N4 já carrega payoff de `H` por tipo
realizado na célula `ν = 0` (vetor `(ℓ, h)`), que é o campo mais fácil de
faltar. Acréscimos à lista: pertencimento explícito de fronteiras por
célula (B3) e, para `AR`, as continuações públicas de N7 (NB4). Nas
células de screening de `C_M`, conferir payoffs fracos condicionados ao
tipo realizado antes de qualquer expectativa — o §3 já exige; é o campo
crítico para P2 sob maioria.

**5. P0–P11 cobrem tudo?** Cobrem as classes listadas. Três lacunas
menores: a execução de P4 depende de B1; a auditoria de datas merece
cláusula normativa (NB5), embora o invariante exista; e P6 deveria
nomear explicitamente o contínuo de pooling de B2 como objeto a
caracterizar, para o revisor cego saber que o conjunto, não um ponto, é o
entregável default.

**6. Divisão de nós mínima e dependency-safe?** Sim. `A_M`⊣`C_M`,
`A_U`⊣`C_U`, `AC`⊣ambos, `AR` terminal é a divisão mínima que preserva
paralelismo e isolamento de risco. Não dividiria nem fundiria nenhum nó.
Goals 2 e 3 podem rodar em paralelo com fronteira de revisão conjunta
(NB2).

**7. Benchmark público isolado?** Sim. `AR` como consumidor terminal
replica o padrão N6→N7 da cadeia atual e impede que o benchmark selecione
equilíbrios privados. Correto também em exigir que o estágio público use
as mesmas datas, votação e tie-breaks.

**8. Goal Q separado?** Sim, separado — nenhum resultado do núcleo precisa
da família de quóruns. Com a ressalva NB3: se N3 já for genérico em `q`, o
custo do Goal Q cai bastante e a decisão do autor sobre incluir o vale
pode mudar.

**9. Primeiros contraexemplos contra as conjecturas do §0.**
(i) Contra "essencialidade reduz a reserva fraca" e "ambos preferem
unanimidade": célula `o_0 < 1/m < o_1` com `ν` logo abaixo de `ν_SE` —
screening majoritário barateia os votos fracos em `A_M`; procurar
parâmetros com `β·o_1 > 1/2` em que `A_M` supera `A_U`. (ii) Contra o lema
de não-separação: semi-pooling com mistura de propostas, se admitida
(NB7); em puras, o lema parece robusto porque aceitação trata os tipos
identicamente. (iii) Contra "renda transportada": testar se a renda em
`A_U` degrada de `β²(o_1−o_0)` quando a célula de continuação muda em
`ν = 0` versus `ν > ν*`. (iv) Contra a separação-por-falha sob maioria:
conferir se o tipo baixo realmente não ganha imitando a falha quando a
continuação majoritária está numa célula de screening, onde crenças
importam — ali a imitação pode deixar de ser gratuita e a separação pode
quebrar.

**10. Primitiva incluída só para recuperar o guardanapo?** Não encontrei.
As primitivas são herdadas; fechamento em `A` não é assumido (P5);
nenhum refinamento importado. O risco residual é a decisão B2 ser tomada
depois, sob a tentação de escolher o princípio que devolve o iff limpo —
por isso ela deve ser fechada no Gate 0, às cegas quanto ao resultado.

---

## Declaração de conflito

As conjecturas do §0 têm origem em contas minhas (sessão de 2026-08-23).
Este parecer avalia o plano de processo, não valida aquelas contas, e eu
não posso ser um dos dois revisores independentes do contrato do Gate 0
nem dos nós `A_M`/`A_U`. A reconstrução cega prevista no Goal 3 deve usar
revisor sem acesso a este parecer e às notas de guardanapo.

## Nota de consistência com as regras da casa

Ordem simulação-antes-de-formalização preservada (script após Gate 0,
antes dos nós). Cadência de revisão por fronteira de dependência admite o
paralelismo NB2. Nenhuma sugestão deste parecer altera o plano até decisão
do autor.

---

## Adendo 1 (2026-08-23, mesma sessão) — previsão sobre D1 e Critério Intuitivo em `A_U`

Contexto: ao ler o parecer, o autor confirmou que o pacote de crenças vigente
está mantido, verificou que a regra do denominador 0/0 (Emenda 1a) pinça o
suporte mas não o valor no interior, e inclinou-se por adotar um refinamento
adicional para a extensão: D1 ou Critério Intuitivo, provavelmente D1.

**Previsão registrada, a verificar na derivação: D1 e o Critério Intuitivo
saem vazios em `A_U`, e o contínuo de pooling (B2) sobrevive a ambos.**

Razão, em três passos verificáveis:

1. **Ramo de aceitação type-simétrico.** Se a proposta desviante de `H` é
   aceita, `H` recebe a fatia que alocou a si, na data de `A`, idêntica para
   os dois tipos porque `b_θ = 0`. Refinamentos à la Cho–Kreps podam tipos
   comparando payoffs de desvio; aqui os conjuntos de resposta que tornam o
   desvio lucrativo coincidem entre tipos no único ramo lucrativo.
2. **Ramo de rejeição type-assimétrico, mas nunca estritamente lucrativo.**
   O valor do tipo alto ao entrar em `C_U` é `h = β·o_1` em TODAS as células
   admissíveis de crença de entrada (`(ℓ,h)` em `ν'=0`; `(h,h)` acima de
   `ν*` — vetores congelados de N4/v6), logo `β²·o_1` em unidades de `A` e
   independente da crença off-path. Isso põe o piso `u*_alto ≥ β²·o_1` em
   todo equilíbrio de `A_U`. Como em pooling os dois tipos recebem a mesma
   demanda `d ≥ β²·o_1`, rejeição não ganha estritamente para nenhum tipo.
3. **Conclusão D1/IC.** Conjuntos de ganho idênticos e não vazios em toda
   demanda desviante relevante → nenhum tipo é podado → a crença após o
   desvio permanece livre → crenças pessimistas (`μ'=0`, que elevam a
   reserva fraca a `β(1−β·o_0)/m`) continuam sustentando pooling abaixo do
   máximo. O Critério Intuitivo, mais fraco que D1, é silencioso a
   fortiori (nenhum desvio a demanda maior é equilibrium-dominated para
   tipo algum).

**Agravante encontrado na mesma verificação**: crenças pessimistas podem
sustentar equilíbrio com **atraso no próprio estágio `A`** (os dois tipos
propõem algo rejeitado) quando `1 − β < β²(o_1 − o_0)` — o melhor desvio
aceitável sob crença pessimista paga `1 − β + β²·o_0`, inferior ao piso
`β²·o_1` do tipo alto nessa região. D1 também não elimina esse equilíbrio,
pelo mesmo argumento. A multiplicidade de B2 portanto abrange não só o
nível do pooling mas agreement-versus-delay.

**Diagnóstico**: a multiplicidade de `A_U` não é de signaling à la Spence;
é a multiplicidade clássica de jogos de proposta com crenças do respondente
fora do caminho, para a qual a literatura usa crenças passivas,
estacionariedade ou seleção declarada — não D1.

**Recomendação decorrente para o Gate 0** (substitui a neutralidade do B2
apenas em ordenação, não em autoridade — a decisão segue autoral):

- Regra primária: **crenças passivas** após proposta desviante de `H`
  (posterior = prior), declarada como convenção com racional de
  desvio-como-tremble — o racional "não sinaliza o que não sabe" NÃO se
  aplica a `H`, que sabe `θ`, e isso deve ficar explícito. Fecha a
  assimetria do pacote (desvios fracos já não movem crença) e entrega
  previsão pontual — o ótimo do proponente, coincidente com o guardanapo.
  Custo declarado: o lema de não-separação vira consequência da convenção.
- Alternativa conservadora: reportar a correspondência completa e comparar
  por extremos (à la D9 em espírito).
- **D1 no máximo como verificação de robustez**, com expectativa registrada
  de silêncio. Adotá-lo como regra primária instalaria cláusula sem
  trabalho no contrato, que a reconstrução cega apontaria.

**Pontos de checagem que falsificariam esta previsão**: (i) payoff de
aceitação depender do tipo por alguma via não considerada; (ii) o valor de
continuação do tipo alto variar com a crença de entrada em alguma célula
admissível; (iii) o piso `β²·o_1` falhar em alguma classe de equilíbrio
admitida pelo Gate 0 (por exemplo, com mistura de propostas, §2.3 item 5).
Se qualquer um falhar, reavaliar D1 do zero.

**Nota sobre trembles (pergunta do autor na mesma sessão).** Duas versões,
nenhuma é terceira opção. (a) Trembles livres — perfeição de Selten,
consistência de Kreps–Wilson: sem mordida; a crença limite é razão de
taxas de tremble por tipo, que são parâmetros livres, então qualquer
posterior em `[0,1]` é justificável e o contínuo e o atraso sobrevivem;
ademais, esses conceitos são definidos para jogos finitos e o espaço de
propostas é contínuo — exigiria discretização ou extensão ad hoc.
(b) Trembles com taxas iguais entre tipos (desvio lido como erro,
não mais provável num tipo que no outro): posterior limite = prior, isto
é, **crenças passivas** — o tremble simétrico é a microfundação delas, não
uma alternativa. A simetria é coerente com a estrutura verificada do jogo:
os payoffs de desvio no ramo lucrativo são idênticos entre tipos, então
não há assimetria que justifique taxas diferentes. Registre-se também que
a votação as-if-pivotal já é a lógica de tremble aplicada ao ballot; o que
restava era o estágio de proposta, onde tremble ou é vácuo ou colapsa em
crenças passivas. Menu efetivo do Gate 0: crenças passivas (com
microfundação por tremble simétrico) ou correspondência completa com
comparação por extremos.
