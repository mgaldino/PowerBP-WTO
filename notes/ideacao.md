# Ideação: Poder Informacional — Bayesian Persuasion e Poder Político

*Última atualização: 2026-03-29*

---

## 1. Ponto de partida

Bayesian Persuasion (BP, Kamenica & Gentzkow 2011) é um dos desenvolvimentos mais férteis da teoria econômica recente. Surpreendentemente, quase não há aplicações em Ciência Política — apesar de BP tratar de como um ator estratégico desenha informação para influenciar decisões de terceiros, o que é o *coração* da política.

### 1.1 Por que BP não penetrou CP?

1. **Silos disciplinares.** BP se disseminou via teoria econômica. Formal theorists em CP seguem tradições mais antigas (cheap talk, signaling).
2. **Ceticismo sobre commitment.** CP desconfia — com razão — de que atores políticos se comprometam com estruturas informacionais. Mas *instituições* podem ter commitment (protocolos de observação, normas INTOSAI, tratados).
3. **Sombra de Gilligan-Krehbiel.** A teoria informacional do legislativo usa cheap talk, e nunca foi "atualizada" para information design.
4. **Virada empírica.** CP moveu-se para inferência causal; teoria formal encolheu.
5. **Barreira matemática.** BP exige otimização sobre distribuições (concavificação).

### 1.2 O que diferencia BP de cheap talk?

| Dimensão | Cheap Talk (Crawford-Sobel) | Bayesian Persuasion (Kamenica-Gentzkow) |
|----------|---------------------------|----------------------------------------|
| Commitment | Sender NÃO se compromete; mensagem é "cheap" | Sender se COMPROMETE com estrutura de sinais antes de observar o estado |
| Credibilidade | Depende do alinhamento de preferências | Vem do commitment (institucional, reputacional) |
| Resultado | Partição parcial do espaço de estados | Revelação ótima pode ser parcial, desenhada para maximizar payoff do Sender |
| Insight central | Comunicação é limitada pelo conflito de interesses | O Sender pode fazer estritamente melhor que full revelation E que no revelation |

A diferença fundamental: em cheap talk, o Sender escolhe O QUE DIZER depois de observar o estado. Em BP, o Sender desenha o PROCESSO que gera informação, e se compromete com esse processo ANTES de observar o estado. É a diferença entre um político dando uma entrevista (cheap talk) e uma organização internacional desenhando um protocolo de observação eleitoral (BP).

---

## 2. A aplicação: Observação Eleitoral Internacional como Bayesian Persuasion

### 2.1 O dilema do observador

Missões de observação eleitoral (EOMs) enfrentam um dilema fundamental documentado pela literatura (Kelley 2012, Donno 2013, Hyde 2011, Willis, Lynch & Cheeseman 2017) e pela tese de Pereira (2025):

> "Should an imperfect election be denounced for failing to express the popular will, when it might yet play a role in state-building, and stave off the imminent collapse of order?" (Willis, Lynch & Cheeseman 2017, p. 19)

A EOM observa a qualidade real da eleição (fraude, irregularidades, violações) e deve decidir o que reportar. Reportar fraude pode ser necessário para integridade, mas pode também desestabilizar — legitimando oposições violentas ou provocando crises. NÃO reportar fraude protege a estabilidade, mas compromete a credibilidade da EOM e pode legitimar autocratas.

Este dilema é **exatamente** o problema de Bayesian Persuasion.

### 2.2 Por que EOMs são Bayesian Persuaders (e não cheap talkers)

O caso de BP requer commitment. EOMs têm:

1. **Protocolo de observação pré-definido**: A OEA/DECO publica manuais de observação (Table 4 da tese lista handbooks de 2006-2024). A metodologia — áreas observadas, formulários, critérios — é definida *antes* da missão ir a campo. O manual de 2024 define explicitamente as áreas e issues observados (Table 5).

2. **Commitment institucional**: A EOM se compromete publicamente com seu mandato. O Secretário-Geral nomeia o Chief of Mission. A reputação organizacional da OEA/UE/Carter Center funciona como enforcement do commitment.

3. **Processo gerador de informação, não mensagem**: A EOM não "diz o que quer" depois de ver a eleição (cheap talk). Ela *implementa um protocolo de observação* que gera dados — formulários de observadores, quick counts, análise de atas. O protocolo é o signal structure.

4. **O sinal não é totalmente controlado**: A EOM não inventa dados. Mas ela DESENHA o que será observado, com que granularidade, e como será agregado. Isso é information design.

### 2.3 Os atores no modelo

Mapeando para BP:

| Elemento BP | No contexto de observação eleitoral |
|-------------|--------------------------------------|
| **Sender** | EOM (Missão de Observação Eleitoral) |
| **Estado (ω)** | Grau real de integridade/fraude eleitoral (contínuo ou discreto) |
| **Sinal (s)** | Press release, relatório preliminar, declaração pública |
| **Receiver** | Atores domésticos (oposição, público) e comunidade internacional |
| **Ação do Receiver** | Aceitar resultado / contestar legalmente / contestar violentamente / sancionar |
| **Prior** | Crenças prévias sobre a integridade da eleição (informação pública disponível) |
| **Preferências do Sender** | NÃO é simplesmente "revelar a verdade" — inclui estabilidade, democracia, credibilidade institucional |

### 2.4 O que a tese de Pereira (2025) estabelece empiricamente

A tese de Lucas Damasceno Pereira ("International electoral observation and democracy protection in the Americas: Playing for the game", IRI-USP 2025) fornece três peças-chave:

**Peça 1: Evidência de comunicação estratégica**

Usando análise quantitativa de texto (Pysentimiento/BERT) dos press releases da OEA de 2012-2024:
- A polaridade (tom crítico vs. positivo) dos press releases **NÃO** correlaciona com o PEI (Perceptions of Electoral Integrity Index). Eleições com mesma qualidade recebem press releases com tons muito diferentes.
- A polaridade SIM correlaciona com a variável "Results" do PEI — que captura se resultados foram contestados, se houve protestos (pacíficos ou violentos), se disputas foram resolvidas legalmente.
- **Implicação para BP**: A EOM NÃO está simplesmente reportando integridade eleitoral. Ela está modulando seu sinal com base no contexto político mais amplo — exatamente o que um Bayesian Persuader faz.

**Peça 2: Os "vieses" de Kelley são preferências do Sender**

Kelley (2010, 2012) identifica cinco "vieses" de observadores:
- **Stability bias**: Endossar eleições em contextos de violência pré-eleitoral para evitar instabilidade
- **Progress bias**: Endossar eleições que mostram progresso democrático mesmo que imperfeitas
- **Glasshouse bias**: Evitar criticar países que podem retaliar
- **Special relationship bias**: Preferência por aliados/doadores
- **Subtlety bias**: Focar em irregularidades flagrantes, ignorar problemas pré-eleitorais

A literatura chama isso de "vieses" (deviation from accurate reporting). BP oferece uma **reinterpretação**: esses não são vieses irracionais. São características racionais da **função de utilidade do Sender**. A EOM *otimamente* escolhe não revelar tudo porque suas preferências incluem estabilidade, relações diplomáticas, e proteção da democracia — não apenas acurácia.

O stability bias é particularmente importante: a EOM internaliza as consequências de seu relatório sobre a paz. Em BP, isso significa que a função de utilidade do Sender é u(a, ω) onde a = ação do Receiver e ω = estado, e a EOM prefere ações moderadas (aceitar resultado, contestar legalmente) a ações extremas (violência, golpe).

**Peça 3: O jogo da tese (a ser reconstruído com BP)**

A tese propõe uma formalização (Cap. 3) com payoff matrices para OC/Oposição e EMB/EOM. A formalização tem problemas sérios:
- Payoffs numéricos arbitrários sem fundamentação
- Sem modelagem explícita da assimetria informacional
- Sem otimização da revelação de informação
- Equilíbrios identificados narrativamente, não resolvidos

Mas a **intuição substantiva** é correta: a EOM faz escolhas estratégicas entre support, shaming, diplomatic engagement, e withdrawal, e essas escolhas dependem do contexto político e não apenas da integridade eleitoral.

BP é o framework correto para formalizar essa intuição.

### 2.5 A pergunta que BP responde e que a literatura não responde

A literatura sobre EOMs debate se observadores são "objective" ou "biased" (Kelley 2010, 2012; Arceneaux & Leithner 2017). Essa é uma false dichotomy.

BP mostra que a EOM pode ser **racional e otimizadora** sem ser "objective" no sentido de full revelation. A pergunta correta não é "a EOM reporta acuradamente?" mas sim:

> **Qual é a estrutura de sinal ótima para uma EOM que se preocupa tanto com integridade eleitoral quanto com estabilidade?**

E as perguntas derivadas:
- Quando a EOM otimamente *omite* irregularidades? (não por viés, mas por design)
- Quando a EOM endossa uma eleição imperfeita? (porque o custo de não endossar é instabilidade)
- Quando a EOM faz shaming? (porque é o ponto onde a inação é pior que a instabilidade)
- Como o design ótimo depende da prior (quanto já se sabe sobre a qualidade da eleição)?

---

## 3. O mecanismo em linguagem simples

Uma missão de observação eleitoral precisa comunicar ao mundo se uma eleição foi legítima. Mas ela não é um termômetro neutro — ela sabe que suas palavras têm consequências. Se disser que houve fraude, a oposição pode usar isso para contestar violentamente. Se disser que está tudo bem quando não está, vai legitimar um autocrata e perder credibilidade.

Então a EOM desenha, antes de ir ao país, um *protocolo de observação*: o que vai examinar, com que detalhe, que critérios vai usar. Esse protocolo é público e funciona como um compromisso. Dado o protocolo, o que é observado gera um sinal — e é esse sinal, não a opinião pessoal do Chief of Mission, que vai a público.

O poder da EOM está em escolher o protocolo. Um protocolo muito detalhado (examinar tudo) pode gerar informação que desestabiliza. Um protocolo vago pode não gerar informação suficiente para ser crível. O protocolo ótimo — o que BP calcula — é aquele que maximiza os objetivos da EOM dado o que ela sabe sobre o contexto.

---

## 4. Pergunta central e MVP

### Pergunta central

> **Qual é o regime de observação eleitoral ótimo para uma EOM que valoriza tanto integridade quanto estabilidade, e como esse regime responde ao contexto político?**

### Paper mínimo viável (MVP)

| Elemento | Conteúdo |
|----------|----------|
| **Pergunta** | Qual é a estrutura de sinal ótima de uma EOM que valoriza integridade E estabilidade? |
| **Mecanismo** | A EOM desenha (e se compromete com) uma estrutura informacional sobre a qualidade da eleição. Diferentes estruturas geram diferentes respostas dos atores domésticos e internacionais. |
| **Modelo mínimo** | Estado ω ∈ [0,1] (qualidade da eleição). EOM (Sender) desenha sinal π. Receiver (comunidade internacional + oposição doméstica) toma ação a ∈ {aceitar, pressionar, sancionar}. EOM tem utilidade que depende de (a, ω) com trade-off integridade vs. estabilidade. |
| **Resultado esperado** | (1) O regime ótimo envolve *pooling parcial*: eleições com qualidade moderada-baixa são pooled com eleições boas ("endorsed with recommendations"), enquanto apenas fraude severa é denunciada. (2) O limiar de denúncia depende do risco de instabilidade — quanto maior o risco, mais "tolerante" a EOM. (3) A EOM pode preferir protocolos deliberadamente *menos* granulares em contextos voláteis — uma predição contraintuitiva. |
| **Contribuição** | (i) Primeira aplicação de BP a observação eleitoral; (ii) Reinterpretação dos "vieses" de Kelley como design ótimo; (iii) Predições testáveis sobre quando EOMs são mais/menos críticas. |
| **Fora do MVP** | Múltiplas EOMs competindo, design endógeno (a EOM escolhe se vai ou não), jogo repetido com reputação, aplicação empírica formal. |

---

## 5. A pergunta teórica geral: Poder Informacional vs. outros tipos de poder

A observação eleitoral é o **caso motivador**, mas a pergunta teórica é mais ampla e fundamental:

> **Quanto poder político um ator obtém ao controlar informação, comparado com quem controla agenda, proposta ou veto?**

### 5.1 Três tipos de poder em decisões coletivas

| Tipo | Quem tem (exemplos) | O que controla | Canal | Referência teórica |
|------|---------------------|----------------|-------|-------------------|
| **Proposal power** | Agenda setter, relator, formateur | O que é votado / a oferta | Espaço de ação | Kalandrakis (2006), Romer-Rosenthal (1978), Baron-Ferejohn (1989) |
| **Veto power** | Presidente, corte constitucional, CSNU | O que pode ser bloqueado | Status quo | Tsebelis (2002), Cameron (2000) |
| **Informational power** | EOM, TCU/GAO, comissão parlamentar, AIEA | O que os outros acreditam | Crenças | **← Novo: formalizar via BP** |

O ponto-chave: cada tipo de poder opera por um **canal distinto**:
- Proposal power muda o *menu* de opções
- Veto power protege o *status quo*
- Informational power muda as *crenças*

Esses canais são conceitualmente independentes. Um ator pode ter um sem os outros. A EOM é o caso puro: tem poder informacional mas zero proposal power e zero veto power. Mesmo assim, claramente influencia outcomes. BP quantifica QUANTO.

### 5.2 O framework de comparação

**Setup geral** (independente do caso concreto):

- **Decisão coletiva**: Um grupo de N jogadores precisa tomar uma decisão d ∈ D sob incerteza sobre o estado ω ∈ Ω.
- **Incerteza**: O estado ω afeta os payoffs de todos. Prior μ₀ ∈ Δ(Ω) é conhecimento comum.
- **Atores com poder**:
  - *Information designer* (I): Conhece ω, desenha e se compromete com sinal π antes de observar ω
  - *Proposer* (P): Escolhe a alternativa proposta; demais votam sim/não
  - *Veto player* (V): Pode bloquear qualquer decisão, revertendo ao status quo

**Medida de poder**: Para cada tipo de ator, calcular o payoff esperado em equilíbrio, comparado com o payoff de um jogador "comum" (sem poder especial). A diferença é o "prêmio de poder" daquele tipo.

### 5.3 Intuições teóricas sobre quando cada tipo domina

**Informational power é mais forte quando:**
- Incerteza é alta (há muito a revelar/ocultar)
- Preferências do Receiver não são extremas (ele é persuadível — está próximo do threshold)
- O prior é moderado (nem certeza de ω alto, nem de ω baixo)
- A ação do Receiver é discreta/threshold (aceitar vs. rejeitar) — a concavificação de BP morde

**Proposal power é mais forte quando:**
- Incerteza é baixa (todos sabem o estado, mas o proposer controla a oferta)
- O espaço de políticas é rico (o proposer pode extrair surplus da maioria)
- A paciência dos jogadores importa (Baron-Ferejohn: proposer ganha do continuation value)

**Veto power é mais forte quando:**
- O status quo é favorável ao veto player
- A agenda é controlada por outro ator (o veto player não precisa propor)
- O custo de delay/inação é baixo (pode-se bloquear sem custo)

**Pergunta empírica**: A EOM (informational power) tem mais ou menos influência que uma corte constitucional (veto power sobre resultado eleitoral) ou que uma comissão eleitoral (proposal/agenda power sobre as regras eleitorais)?

### 5.4 Relação com Kalandrakis (2006)

Kalandrakis prova um resultado extremo: via proposal rights, QUALQUER nível de poder é atingível em equilíbrio de barganha. A pergunta análoga para informational power:

> Manipulando a estrutura informacional, quais níveis de poder são atingíveis?

Se a resposta for "também todos" → informational power é tão potente quanto proposal power. Se "apenas um subconjunto" → informational power tem limites que proposal power não tem — e a natureza desses limites é a contribuição.

**Conjectura**: Informational power é LIMITADO de uma forma que proposal power não é. Especificamente:
- Se incerteza → 0, informational power → 0 (não há nada para revelar). Proposal power não depende de incerteza.
- Se preferências do Receiver são extremas (sempre aceita ou sempre rejeita), informational power → 0. Proposal power funciona mesmo com preferências extremas.
- Informational power é delimitado pela "distância" entre a prior e o threshold do Receiver. Proposal power não tem esse limite.

Isso significa que **informational power é poderoso mas fundamentalmente diferente e mais condicional** que proposal power. A natureza dessa condicionalidade é o resultado teórico central.

### 5.5 Comparação informal aprofundada

#### A. Natureza da influência

Cada tipo de poder opera por um canal qualitativamente distinto:

**Proposal power é CONSTRUTIVO.** O proposer *cria* a alternativa que vai a voto. É poder positivo: "eu determino o que está na mesa." Em Romer-Rosenthal, o agenda setter propõe; a única alternativa é o status quo. Em Baron-Ferejohn, o reconhecido propõe a divisão. O poder vem de que os outros só podem aceitar ou rejeitar — não podem reformular.

**Veto power é OBSTRUTIVO.** O veto player *bloqueia*. É poder negativo: "nada muda sem meu consentimento." Em Tsebelis, o veto player define o tamanho do winset do status quo. Quanto mais veto players, menor o conjunto de mudanças possíveis. O poder vem de proteger o status quo.

**Informational power é EPISTÊMICO.** O information designer *muda crenças*. É poder indireto: "eu mudo o que você acredita, e você muda o que faz." O poder não vem de agir — vem de fazer outros agirem diferente do que agiriam sem a informação.

Essa taxonomia (construtivo / obstrutivo / epistêmico) é potencialmente uma contribuição em si. A literatura de poder político não tem um framework unificado para comparar esses canais.

#### B. Robustez: o que cada tipo REQUER para funcionar

| Condição | Proposal power | Veto power | Informational power |
|----------|---------------|------------|---------------------|
| Incerteza sobre o estado | NÃO requer | NÃO requer | REQUER — sem incerteza, não há nada a revelar |
| Status quo favorável | Não depende | REQUER — sq ruim → veto fraco | Não depende |
| Receiver próximo de threshold | Não depende | Não depende | REQUER — Receiver com preferências extremas não é persuadível |
| Commitment institucional | Requer reconhecimento formal | Requer autoridade constitucional | REQUER — sem commitment, degenera em cheap talk |
| Misalinhamento de preferências | Funciona com qualquer grau | Funciona com qualquer grau | Requer *algum* misalinhamento (se perfeito alinhamento → full revelation é ótimo, sem ganho estratégico) |

**Implicação central**: Proposal power é o mais ROBUSTO — funciona em quase qualquer contexto. Informational power é o mais CONDICIONAL — requer incerteza, persuadibilidade, commitment, e misalinhamento parcial. Veto power está no meio.

Mas "condicional" não significa "fraco". Quando as condições estão presentes (alta incerteza, Receiver persuadível), informational power pode ser muito forte. A questão é: **o quanto?**

#### C. Os limites formais do informational power

BP impõe quatro restrições ao poder informacional que NÃO se aplicam a proposal/veto power:

**1. A restrição bayesiana (martingale constraint).** A expectativa do posterior deve igualar o prior. O Sender pode escolher a DISTRIBUIÇÃO dos posteriors, mas não a MÉDIA. Para cada sinal otimista, deve haver um sinal pessimista que "compensa". Isso limita fundamentalmente o que a persuasão pode alcançar.

Proposal power não tem análogo: o proposer pode fazer uma oferta arbitrariamente favorável a si.

**2. A restrição de incerteza.** Se σ² → 0 (incerteza desaparece), o valor do design informacional → 0. Em um mundo de informação perfeita, o information designer não tem poder. Proposal power funciona igualmente bem com ou sem incerteza.

**3. A restrição de persuadibilidade.** Se o Receiver tem preferências extremas (aceita SEMPRE ou rejeita SEMPRE), informação é irrelevante — nada muda a ação. O informational power requer que o Receiver esteja em uma "zona de persuasão" onde informação pode mudar a ação. Proposal power funciona mesmo com Receivers "teimosos" — o proposer ajusta a oferta.

**4. A restrição de alinhamento.** Se Sender e Receiver têm preferências idênticas, full revelation é ótimo e não há ganho estratégico. O valor de BP vem do conflito. Mas se o conflito é TOTAL (preferências completamente opostas), o Sender também ganha pouco — o Receiver desconta tudo. O informational power é máximo com conflito PARCIAL.

#### D. Quando informational power domina

Apesar dessas restrições, há settings onde informational power é o recurso estratégico mais importante:

**1. Decisões binárias com incerteza alta.** Quando o Receiver toma uma decisão sim/não (aceitar/rejeitar eleição, sancionar/não sancionar, ir à guerra/não ir) e há incerteza genuína sobre o estado, o information designer tem enorme poder. O resultado de concavificação de BP mostra que o Sender pode extrair valor significativo nesse cenário.

Exemplo concreto: A EOM pode fazer a diferença entre a comunidade internacional aceitar ou rejeitar uma eleição contestada. O "poder" da EOM é máximo exatamente nos casos de "zona cinzenta" — eleições que não são nem claramente limpas nem claramente fraudulentas. Bolívia 2019, Honduras 2017.

**2. Quando o ator não tem outros instrumentos.** A EOM não propõe, não veta, não sanciona. Informação é o ÚNICO recurso. Neste caso, informational power é todo o poder que o ator tem, e BP nos diz exatamente quanto é.

Isso se aplica a muitos atores em RI: organismos internacionais frequentemente têm poder informacional (relatórios, avaliações, ratings) mas pouco poder coercitivo. FMI Article IV consultations, FATF mutual evaluations, IPCC assessments, Universal Periodic Review. Em todos esses casos, o "poder" da IO vem do design informacional.

**3. Quando a incerteza é endógena à política.** Em ambientes voláteis — crises eleitorais, conflitos armados em escalada, pandemias emergentes — a incerteza é alta por definição. O ator que controla a informação nesse momento tem poder desproporcional. Isso explica por que EOMs importam mais em eleições contestadas, e por que agências de inteligência importam mais em crises.

#### E. Interação entre tipos de poder

Os tipos de poder são independentes conceitualmente, mas interagem na prática:

**Informação + Proposta (complementares).** Um ator com AMBOS pode desenhar informação que torna sua proposta mais atraente. A comissão legislativa (Gilligan-Krehbiel) é o caso clássico: controla tanto as audiências (informação) quanto o bill que vai ao plenário (proposta). A combinação é super-aditiva — a informação potencializa a proposta.

Predição: atores com proposal power investem em ADQUIRIR informational power (controlando hearings, comissionando estudos) exatamente porque os dois se reforçam.

**Informação + Veto (complementares de outro modo).** Um veto player que também controla informação pode revelar (ou ocultar) informação que faz o status quo parecer melhor. O presidente que veta legislação E controla briefings de inteligência é mais poderoso que o presidente que só veta.

**Proposta + Veto (já estudado).** Shepsle-Weingast structure-induced equilibrium. Ter ambos é extremamente poderoso — é o "monopoly agenda setter" de Romer-Rosenthal com proteção extra.

**Os três juntos.** O ator que propõe, veta E controla informação tem poder quase total. Isso raramente acontece em democracias (checks and balances impedem a concentração). Mas em autocracias? O autocrata frequentemente controla os três: propõe legislação, veta oposição, e controla a mídia. Isso sugere que **a concentração de informational power junto com proposal/veto power pode ser um indicador de autoritarismo**.

#### F. Paradoxos e resultados contraintuitivos

**Paradoxo da profissionalização.** Kelley (2012) e outros advogam profissionalização e padronização das EOMs. Mas se o protocolo é completamente padronizado, a EOM perde FLEXIBILIDADE de design. Em BP, o valor vem de ESCOLHER a estrutura de sinais. Padronização fixa a estrutura → reduz informational power. Resultado contraintuitivo: **mais profissionalização pode significar menos efetividade estratégica**.

Resolução possível: a profissionalização fortalece o COMMITMENT (que é necessário para BP) ao custo de reduzir o espaço de design. Há um trade-off ótimo.

**O poder dos fracos.** Informational power é acessível a atores que não têm nenhum outro tipo de poder. ONGs, think tanks, agências de rating, observadores eleitorais — nenhum desses tem proposal ou veto power. Mas todos podem ter informational power se conseguirem commitment (via reputação, institucionalização). BP formaliza como os "fracos" influenciam os "fortes" — não por coerção, mas por persuasão.

**O limite da transparência.** Se o ideal normativo é "full revelation" (transparência total), BP mostra que um Sender racional NUNCA escolhe full revelation se tem preferências minimamente diferentes do Receiver. Toda instituição de monitoramento (EOM, TCU, AIEA) que diz buscar "transparência" está na verdade fazendo information design. A transparência total não é um equilíbrio — é um benchmark teórico. O que existe na prática é informational power sendo exercido.

### 5.6 Possíveis estruturas de paper

**Opção A: Paper teórico geral + aplicação**
1. Framework de comparação (seção 5.1-5.4 acima)
2. Modelo formal: resolver os três tipos de poder no mesmo setting
3. Aplicação: observação eleitoral como o caso puro de informational power
- *Vantagem*: Contribuição ampla, dialoga com toda a literatura de poder político
- *Risco*: Pode ser ambicioso demais; a tractability da comparação é incerta

**Opção B: Paper aplicado — BP e observação eleitoral**
1. Motivar com o dilema do observador
2. Modelo de BP: EOM como Sender, comunidade internacional como Receiver
3. Resultados: design ótimo, estática comparativa
4. Na discussão: "informational power" como conceito, comparar informalmente com agenda/veto
- *Vantagem*: Mais focado, publicável mais rápido, testável com dados de Pereira
- *Risco*: A contribuição teórica é menor

**Opção C: Dois papers**
- Paper 1 (com Pereira): BP aplicado a observação eleitoral. IO ou JCR.
- Paper 2 (solo ou com outro co-autor): Informational power vs. proposal power, framework geral. APSR ou AJPS.
- *Vantagem*: Cada paper tem escopo adequado
- *Risco*: Dispersão de esforço

---

## 6. Primeiro resultado: TIOLI com pie incerta

### Setup
- Pie ω ∈ {L, H}, Pr(ω=H) = p, onde 0 < L < H
- Player R faz oferta take-it-or-leave-it: R fica com y, S fica com ω - y
- S conhece ω. Aceita se ω - y ≥ 0. Ambos têm outside option 0.

### Três cenários para S

**(1) Sem poder (benchmark):** R propõe, S aceita/rejeita, sem BP.
- R oferece y = L se p < L/H (safe). S ganha p(H-L).
- R oferece y = H se p > L/H (gamble). S ganha 0.

**(2) Informational power (BP):** R propõe, mas S desenha sinal sobre ω antes.
- v(μ) = μ(H-L) se μ < L/H, 0 se μ ≥ L/H
- Concavificação: V(μ) = μ(H-L) para μ ≤ L/H, V(μ) = L(1-μ) para μ > L/H
- Resultado: Se p ≤ L/H → p(H-L) (= benchmark). Se p > L/H → L(1-p) > 0.
- Sinal ótimo: dois sinais com posteriors μ₁ = L/H e μ₂ = 1.

**(3) Proposal power:** S propõe, R aceita/rejeita. S conhece ω.
- S propõe x = E[ω]. R aceita. S ganha E[ω] = pH + (1-p)L.

### Comparação

| p | Sem poder | Info power | Proposal power | Ratio info/prop |
|---|-----------|------------|----------------|-----------------|
| p < L/H | p(H-L) | p(H-L) | E[ω] | p(H-L)/E[ω] |
| p > L/H | 0 | L(1-p) | E[ω] | L(1-p)/E[ω] |

Exemplo (L=1, H=3, L/H=1/3):

| p | Sem poder | Info power | Proposal | Ratio |
|---|-----------|------------|----------|-------|
| 0.2 | 0.4 | 0.4 | 1.4 | 29% |
| 0.5 | 0 | 0.5 | 2.0 | 25% |
| 0.8 | 0 | 0.2 | 2.6 | 8% |

### Resultados

1. **Proposal power sempre domina informational power** neste setup.
2. **Info power é não-monótono em p**: máximo em p = L/H, zero nos extremos.
3. **Info power transforma 0 em algo positivo**: quando p > L/H, S vai de 0 a L(1-p).
4. **Informação não ajuda o proposer**: com ambos, payoff = E[ω] (por E[E[ω|s]] = E[ω]).
5. **TIOLI é o caso extremo de proposal power**. Em Rubinstein com δ < 1, proposal power é diluída → a comparação pode mudar.

### Extensão resolvida: T períodos (Rubinstein finito)

**Setup**: Alternating offers, T períodos. R propõe em ímpares, S em pares. Discount δ. S conhece ω. S pode fazer BP antes do período 1.

**Rubinstein com info completa (referência)**:
- f_R(T) = share de S como responder. f_S(T) = share de S como proposer.
- f_R(T) = δf_S(T-1). f_S(T) = 1 - δ + δf_R(T-1).
- f_R(1)=0, f_S(1)=1, f_R(2)=δ, f_S(2)=1-δ, f_R(3)=δ(1-δ), ...
- T → ∞: f_R = δ/(1+δ), f_S = 1/(1+δ).

**Com pie incerta (p > L/H), sem BP:**
S ganha f_R(T) × ω para cada tipo → E[S] = f_R(T)·E[ω].

**Com BP (concavificação):**
V_T(p) = L(1-p) + pH·f_R(T)

**BP gain = L(1-p) × r_R(T)**, onde r_R(T) = 1 - f_R(T) = share do proposer.

| T | f_R(T) | r_R(T) | BP gain |
|---|--------|--------|---------|
| 1 | 0 | 1 | L(1-p) |
| 2 | δ | 1-δ | L(1-p)(1-δ) |
| 3 | δ(1-δ) | 1-δ+δ² | L(1-p)(1-δ+δ²) |
| ∞ | δ/(1+δ) | 1/(1+δ) | L(1-p)/(1+δ) |

**Comparação com proposal power (first-mover premium):**
- PP gain = g(T)·E[ω], onde g(T) = f_S(T) - f_R(T).
- g(1)=1, g(2)=1-2δ, g(∞)=(1-δ)/(1+δ).

**BP domina PP para T → ∞ quando δ > δ\*:**

δ\* = pH / [L(1-p) + pH]

Exemplo (L=1, H=3, p=0.5): δ\* = 0.75.

### Três resultados centrais

1. **BP gain = L(1-p) × r_R(T)**. Proporcional ao "espaço de persuasão" × share do proposer.

2. **PP premium → 0 quando δ → 1; BP premium → L(1-p)/2 > 0.** Informational power é mais durável que proposal power.

3. **∃ δ\* < 1 tal que para δ > δ\*, BP domina PP.** Jogadores pacientes se beneficiam mais de controlar informação que de controlar a agenda.

### Exemplos numéricos (L=1, H=3, p=0.5)

**T=1 (Ultimatum):**

R oferece agressivo (y=3). S ganha 0. Com BP: S cria sinal "alerta" (75%, posterior=1/3 → R oferece safe y=1, S ganha ω-1) e "certeza" (25%, posterior=1 → R oferece y=3, S ganha 0). E[S com BP] = 0.5. Com proposal power: S ganha E[ω]=2. Info/Prop = 25%.

**T=2, δ=0.8:**

Sem BP: S ganha δE[ω] = 1.6. Com BP: 1.7 (gain = 0.1). Com proposal power: 0.4 (ser primeiro é PIOR que ser segundo com δ alto). BP domina PP.

**T=2, δ=0.3:**

Sem BP: 0.6. Com BP: 0.95 (gain = 0.35). Com proposal power: 1.4. PP domina BP.

**T→∞, δ=0.9:**

BP gain = L(1-p)/(1+δ) = 0.5/1.9 = 0.26. PP gain = (1-δ)E[ω]/(1+δ) = 0.2/1.9 = 0.11. **BP domina.**

### A pergunta-chave que emerge

> **Por que políticos investem tanto em proposal power e não em informational power?**

O modelo sugere três respostas:

**1. Porque não conseguem commitment.** Proposal power não requer commitment — vem da posição institucional (quem é reconhecido para propor). Informational power requer commitment a uma estrutura de sinais, que políticos individuais não têm. Usam o instrumento que funciona sem commitment.

**2. Porque δ na política é frequentemente baixo.** Legislaturas operam com deadlines (fim de sessão, eleições, crises) → δ efetivo baixo → proposal power domina. O resultado "BP domina" requer paciência que muitos contextos políticos não têm.

**3. Instituições existem para acessar informational power.** A implicação mais interessante: instituições (comissões, tribunais de contas, EOMs, agências de inspeção) são o mecanismo pelo qual atores políticos acessam informational power. O político individual não consegue commitment, mas a instituição sim — via protocolos, normas, reputação organizacional. Delegar a uma instituição converte impossibilidade de commitment individual em commitment institucional.

**Implicação para design institucional:**
- Ambientes pacientes (negociações longas, RI): vale criar instituições com poder informacional
- Ambientes impacientes (crises, votações urgentes): vale garantir proposal power
- Isso explica por que OIs (δ alto em RI) têm predominantemente poder informacional, enquanto legislaturas (δ baixo com deadlines) privilegiam proposal power

### Extensão N jogadores: BF com 3 jogadores, 2 períodos

**Setup**: N=3, maioria (proposer+1), reconhecimento simétrico 1/3, pie ω∈{L,H}, S=jogador 1 conhece ω.

**Resultado surpreendente**: A lógica do caso de 2 jogadores NÃO se generaliza diretamente.

Com N≥3, S pode ser EXCLUÍDO da coalizão vencedora. Quando excluído, S ganha 0 se a proposta é aceita. S PREFERE que propostas agressivas falhem (→ rejeição → período 2 → S pode propor). Portanto, BP que faz o proposer ir safe PREJUDICA S.

**Exemplo (L=1,H=3,p=0.5,δ=0.8)**: E[S sem BP] = 0.622. BP convencional (fazer proposer ir safe) reduziria S a ≈0.53. BP é contra-produtivo!

**Condição para BP ajudar S no BF com N jogadores**: S precisa ser membro provável da coalizão. Isso acontece quando:
1. S tem veto power (indispensável)
2. S é o parceiro mais barato
3. N = 2 (caso original)

**Implicação teórica**: Informational power é complementar a estar dentro da coalizão. Veto players são os maiores beneficiários de informational power (sempre na coalizão, nunca excluídos). Isso conecta informational power a veto power de forma nova:
- Veto + Info: muito poderoso (complementar)
- Proposal + Info: independentes ou substitutos
- Info sozinho (sem veto nem proposal): eficaz apenas se S está na coalizão

### Efeito de equilíbrio: exclusão de S redistribui valor para R

Quando S é sempre excluído da coalizão (por ser mais caro), o "mercado de parceiros" encolhe. R players são incluídos com mais frequência:

- BF padrão (N=5): Prob R na coalizão = q/N = 2/5 = 0.40
- Com S excluído: Prob R na coalizão = q/(N-1) = 2/4 = 0.50

Valores de continuação (pie conhecida = 1, N=5, q=2, δ=0.8):
- BF padrão: v_R = 1/N = 0.200
- S excluído: v_R = (N-1)/[N(N-1)-qδ] = 4/18.4 = **0.217** (+9%)
- S excluído: v_S = (1/N)(1-qδv_R) = **0.131** (-35%)

**Curse of knowledge**: ser informado no BF com maioria TRANSFERE valor de S para R. A informação que deveria dar poder a S acaba beneficiando os uninformed.

### Unanimidade resolvida: N=5, 2 períodos (L=1,H=3,p=0.5,δ=0.8)

Sob unanimidade, S está SEMPRE na coalizão (proposer precisa de todos).

**Sem BP**: E[S] = 0.464 (vs 0.368 sob maioria)
**Com BP**: E[S] = 0.592 (BP gain = +0.128)

Mecanismo: BP faz proposer ir safe (c=L). Sob safe, proposer ainda precisa comprar S. Oferece x_S = δH/N = 0.48 (para garantir aceitação de ambos tipos de ω). S ganha 0.48 com certeza, vs 0.32 sem BP.

Sinal ótimo: "alerta" (75%, μ=1/3 → safe) e "certeza" (25%, μ=1 → agressivo com ω=H certo). Em ambos, S ganha 0.48.

**A grande comparação (N=5):**

| | Maioria | Unanimidade |
|---|---|---|
| S sem BP | 0.368 | 0.464 |
| S com BP | ≤ 0.368 | **0.592** |
| BP gain | ≤ 0 (curse) | **+0.128** |

S informado prefere unanimidade: 0.592 vs 0.368 (+61%).

### Tabelas completas de payoff (N=5, L=1, H=3, p=0.5, δ=0.8)

**Correções importantes**: Rejeição de proposta agressiva (c=H quando ω=L) revela ω=L. Isso reduz continuações de R para δ(1/5)L = 0.16 (em vez de 0.24). S como proposer sob maioria separa (propõe c=ω), revelando ω e tornando parceiros mais caros.

**Tabela 1: Payoffs ex ante e condicionais**

| | **Maioria** | | **Unanimidade s/ BP** | | **Unanimidade c/ BP** | |
|---|---|---|---|---|---|---|
| | S | R | S | R | S | R |
| **Ex ante** | **0.336** | **0.428** | **0.464** | **0.364** | **0.592** | **0.252** |
| Cond: proposer | 1.36 | 1.42 | 1.04 | 1.10 | 1.04 | 0.30 |
| Cond: não-proposer | 0.08 | 0.18 | 0.32 | 0.18 | 0.48 | 0.24 |

**Tabela 2: Efeito do BP sob unanimidade**

| | Sem BP | Com BP | Variação |
|---|---|---|---|
| S ex ante | 0.464 | **0.592** | **+28%** |
| S como proposer | 1.04 | 1.04 | 0% |
| S como não-proposer | 0.32 | **0.48** | **+50%** |
| R ex ante | 0.364 | **0.252** | **-31%** |
| R como proposer | 1.10 | **0.30** | **-73%** |
| R como não-proposer | 0.18 | 0.24 | +33% |
| **Surplus total** | **1.92** | **1.60** | **-17%** |

### Seis resultados das tabelas

**R1. Sob maioria, S perde em TUDO.** S ex ante < R ex ante (0.336 < 0.428). S como proposer < R como proposer (1.36 < 1.42). S como não-proposer < R como não-proposer (0.08 < 0.18). Curse of knowledge é total.

**R2. S ganha menos como proposer que R sob maioria (1.36 < 1.42).** Quando S propõe, a proposta revela ω (separating). Parceiros de coalizão inferem ω e exigem mais. Quando ω=H, R exige δH/N = 0.48 de S, mas apenas δL/N = 0.16 de outro R proposer (cuja proposta agressiva revelaria ω=L só se falhasse). A informação de S torna S um proposer mais caro.

**R3. BP sob unanimidade é redistributivo, não eficiente.** S ganha +28%, R perde -31%, surplus cai -17%. BP faz proposer ir safe demais: quando ω=H e proposta é c=L, a diferença H-L = 2 fica na mesa.

**R4. R como proposer é destruído pelo BP (-73%).** BP faz R propor safe (c=L), mantendo apenas 0.04 — quase nada. O surplus que R extraía vai para S (que recebe 0.48 em cada coalizão).

**R5. S como proposer não muda com BP (1.04).** Martingale: E[custo de coalizão] é invariante ao sinal. BP redistribui condicionalmente mas não no agregado quando S propõe.

**R6. R como não-proposer MELHORA com BP (+33%).** R recebe mais quando incluído na coalizão sob "certeza" (0.48 vs 0.16). Mas o ganho como não-proposer não compensa a perda como proposer.

### Implicação normativa

Consenso + BP pode ser **Pareto-inferior** a maioria. Os uninformed (R) podem preferir maioria (0.428 cada) a unanimidade com BP (0.252 cada). A institucionalização do consenso favorece o Sender informado às custas dos outros membros E da eficiência.

Isso dá um ângulo normativo ao paper: países poderosos preferem consenso não porque é "melhor para todos" — mas porque é melhor *para eles*. O custo recai sobre os membros menores e sobre a eficiência total.

### Três proposições confirmadas

**P1 (Curse of Knowledge):** Sob maioria, informational power é negativo para S. S perde ex ante, como proposer, e como não-proposer.

**P2 (BP sob unanimidade):** Sob unanimidade, informational power é positivo para S (+28%) e negativo para R (-31%). BP é redistributivo.

**P3 (Escolha institucional):** S informado e minoritário prefere unanimidade a maioria (0.592 vs 0.336, +76%). R prefere maioria a unanimidade com BP (0.428 vs 0.252). A escolha institucional é conflitiva.

### Provas gerais para N genérico (resolvido 2026-03-29)

**Setup geral**: N jogadores (ímpar), 2 períodos, ω ∈ {L,H}, Pr(ω=H) = p > L/H, discount δ. S = jogador 1 (conhece ω). Jogadores 2,...,N uninformed, simétricos. Reconhecimento 1/N. Período 2 (último): proposer toma tudo.

Valores de continuação: v_S(ω) = ω/N, v_j(μ) = μH/N para j≠S (μ ≥ L/H).

#### Proposição 1: Curse of Knowledge (maioria, ∀ N ≥ 3)

**Enunciado**: Para N ≥ 3, maioria (q=(N-1)/2), p > L/H: E[S] < E[ω]/N.

**Lema 1**: S é mais caro que uninformed em expectativa. Custo de S: δE[ω|μ]/N. Custo de uninformed k: δμH/N. Diferença: δ(1-μ)L/N > 0. ∎

**Lema 2**: Para N ≥ 3, proposer pode excluir S sob maioria. Precisa q=(N-1)/2 de N-1. Uninformed disponíveis: N-2 ≥ q ↔ N ≥ 3. ∎

**Lema 3**: j exclui S em equilíbrio (por Lemas 1-2). ∎

**Prova**: Rejeição de proposta agressiva (c=H, ω=L) revela ω=L. Continuação: δL/N.

S quando propõe (1/N): separa (c=ω). Parceiros exigem δω/N. S fica com ω(1-qδ/N).
E[S|proposer] = E[ω](1-qδ/N).

S quando j propõe ((N-1)/N): excluído. ω=H → 0; ω=L → δL/N.
E[S|não-proposer] = (1-p)δL/N.

**E[S] = (1/N)E[ω](1-qδ/N) + ((N-1)/N)(1-p)δL/N**

**E[S] - E[ω]/N = δ(N-1)[(1-p)L - pH] / (2N²) < 0**

(pois p > L/H > L/(L+H) implica pH > (1-p)L). ∎

Exemplos numéricos (L=1, H=3, p=0.5, δ=0.8):

| N | q | E[S] | E[ω]/N | % abaixo benchmark |
|---|---|------|--------|--------------------|
| 3 | 1 | 0.489 | 0.667 | -27% |
| 5 | 2 | 0.336 | 0.400 | -16% |
| 7 | 3 | 0.249 | 0.286 | -13% |
| 11 | 5 | 0.164 | 0.182 | -10% |

#### Proposição 2: BP ajuda S sob unanimidade (∀ N ≥ 2)

**Enunciado**: Sob unanimidade, p > L/H: BP gain = (N-1)δ(1-p)(H-L)/N² > 0.

**Prova**: S não pode ser excluído (j precisa de todos N-1).

Sem BP: j agressivo. Oferece δH/N a S. ω=H → S ganha δH/N; ω=L → infeasível, S ganha δL/N.
E[S|j propõe, sem BP] = δE[ω]/N.

Com BP (sinal ótimo: "alerta" μ=L/H, "certeza" μ=1):
- "alerta": j safe, oferece δH/N a S → S ganha δH/N
- "certeza": j agressivo (ω=H certo), oferece δH/N → S ganha δH/N
E[S|j propõe, com BP] = δH/N.

BP gain por proposta de j: δH/N - δE[ω]/N = δ(1-p)(H-L)/N.

**BP gain total = ((N-1)/N) × δ(1-p)(H-L)/N = (N-1)δ(1-p)(H-L)/N²** > 0. ∎

Exemplos (L=1, H=3, p=0.5, δ=0.8):

| N | BP gain |
|---|---------|
| 3 | 0.178 |
| 5 | 0.128 |
| 7 | 0.098 |
| 11 | 0.066 |

#### Proposição 3: S prefere unanimidade a maioria (∀ N ≥ 3)

**Enunciado**: Para N ≥ 3, p > L/H, H(2-p) > 3L(1-p): E[S|unan,BP] > E[S|maj].

**Prova**:

E[S|unan,BP] = (1/N)E[ω](1-(N-1)δ/N) + ((N-1)/N)δH/N
E[S|maj] = (1/N)E[ω](1-qδ/N) + ((N-1)/N)(1-p)δL/N

Diferença = δ(N-1)/N² × [-E[ω]/2 + H - (1-p)L]
= **δ(N-1) × [H(2-p) - 3L(1-p)] / (2N²)**

Positivo quando H(2-p) > 3L(1-p), i.e., **H/L > 3(1-p)/(2-p)**.

| p | Threshold H/L | Satisfeito se... |
|---|---|---|
| 0.3 | 1.24 | H > 1.24L |
| 0.5 | 1.00 | H > L (sempre) |
| 0.7 | 0.69 | Sempre |

**A condição NÃO depende de N.** Para p ≥ 0.5, basta H > L (sempre verdade). ∎

#### Resumo

| Proposição | Resultado | Condição | Depende de N? |
|---|---|---|---|
| P1 (Curse) | E[S\|maj] < E[ω]/N | p > L/(L+H) | Não (∀ N≥3) |
| P2 (BP unanimidade) | BP gain > 0 | p > L/H, H > L | Não (∀ N≥2) |
| P3 (S prefere unanimidade) | E[S\|unan,BP] > E[S\|maj] | H(2-p) > 3L(1-p) | Não (∀ N≥3) |

### Horizonte infinito: resolvido (2026-03-29)

**Resultado: T=2 captura toda a ação estratégica. O horizonte não importa.**

#### Prova de equivalência T=2 ↔ T genérico ↔ T=∞

**Lema (Revelação no período 1):** Em equilíbrio, ω é SEMPRE revelado no período 1.

Dois mecanismos de revelação:
1. Se j≠S propõe agressivo (c=H) e ω=L: proposta infeasível → ω=L revelado.
2. Se S propõe: S separa (c=ω, pois separating domina pooling). → ω revelado.

Em ambos os casos, ω é revelado na primeira proposta. ∎

**Corolário:** Após o período 1, o jogo é BF padrão com pie conhecida ω. No BF padrão com pie conhecida e N jogadores simétricos, cada jogador ganha ω/N em expectativa, independente de T. Portanto, a continuação do período 2+ dá δω/N a cada jogador, para qualquer T.

**Proposição (Equivalência):** E[S | T períodos, belief updating] = E[S | T=2] para todo T ≥ 2.

Prova: Os valores de continuação que entram no período 1 são δv_i = δω/N (por ω conhecido após período 1 e BF padrão nos períodos restantes). Esses valores são idênticos para qualquer T ≥ 2. A análise do período 1 é portanto idêntica. ∎

#### Verificação: pooling forçado vs. belief updating (N=5, L=1, H=3, p=0.5, δ=0.8)

| | Belief updating | Pooling forçado (estacionário) |
|---|---|---|
| E[S] | **0.336** | **0.076** |
| E[R] | ~0.396 | 0.500 |

Pooling é muito pior para S (-77%) porque S é forçado a propor c=L quando ω=H, desperdiçando H-L=2.

**Pooling não é equilíbrio**: S tem incentivo para desviar (separar), pois propor c=H quando ω=H dá payoff muito maior. Portanto a versão com belief updating é a correta.

#### Implicação para o paper

O modelo de 2 períodos NÃO é uma simplificação — é o resultado geral. Não precisamos de análise separada para horizonte infinito. A revelação de ω no período 1 transforma o jogo multi-período em "período 1 estratégico + continuação BF padrão com pie conhecida."

### Pendência remanescente (atualizado após reviews v2, 2026-03-29)

- ~~Provar P1-P3 para N genérico~~ ✓
- ~~Belief updating~~ ✓
- ~~Horizonte infinito~~ ✓
- ~~Nota técnica v1 em RMarkdown~~ ✓
- ~~Literature search~~ ✓
- ~~Bug numérico no exemplo N=3~~ ✓ (corrigido: 0.489→0.578, 27%→13%)

#### Próximos passos (priorizados por impacto)

**Prioridade 1 — Provas e correções formais (blocking para qualquer submissão):**
1. Verificar e reconstruir prova da Prop 2 (BP gain sob unanimidade). Parecerista flagrou gap: sob "alerta" (μ=L/H), proposer vai safe → por que ofereceria δH/N ao Sender? Recalcular o mecanismo exato de como BP ajuda S sob unanimidade com safe proposals.
2. Tratar explicitamente o problema de adverse selection quando proposer inclui S na coalizão (S aceita se x ≥ δω/N, mas proposer não sabe ω).
3. Completar todas as provas (eliminar "proof sketches"). Steps numerados.
4. Provar formalmente que separação de S quando propõe é estratégia dominante (tratar off-path beliefs).

**Prioridade 2 — Exposição (necessário para circulação):**
5. Worked example para unanimidade (N=3, mesmos parâmetros) — assimetria na exposição flagrada por 3 pareceristas.
6. Tabela de decomposição 2×2: {maioria, unanimidade} × {com BP, sem BP} — isola efeito de exclusão vs. efeito de BP vs. interação.
7. Game tree (diagrama do jogo extensivo).
8. Figura da concavificação v(μ) vs V(μ).
9. Eliminar repetição intro/Seção 7.
10. Transformar Seção 6 (Horizon Independence) em Remark dentro da Seção 4.
11. Reescrever roadmap (lógica do argumento, não lista de seções).

**Prioridade 3 — Citações e posicionamento:**
12. Expandir referências (atualmente 7; mínimo ~20). Adicionar: Crawford-Sobel 1982, Banks-Duggan 2000, Diermeier-Feddersen 1998, Feddersen-Pesendorfer 1998, Maggi-Morelli 2006, Eraslan et al., Schnakenberg 2017, Bergemann-Morris 2016/2019, Gentzkow-Kamenica 2017 (competing senders).
13. Reconhecer homonímia "Curse of Knowledge" com psicologia cognitiva (Camerer, Loewenstein, Weber 1989).
14. Discutir Maggi-Morelli (2006) como explicação alternativa para consenso.

**Prioridade 4 — Robustez e extensões (para versão APSR/IO):**
15. Discutir (mesmo informalmente): pie contínuo, múltiplos Senders, cheap talk, reconhecimento assimétrico.
16. Análise de welfare/eficiência formal.
17. Seção de limitações antes da conclusão.
18. Case study ou vignette (Rodada Doha).

**Prioridade 5 — Estática comparativa:**
19. Gráficos: E[U_S] por N, por δ, por H/L, por p.
20. Discutir: quando o Curse é negligível? Quando S é quase indiferente entre maioria e unanimidade?

---

## 7. FRAMING UNIFICADO DO PAPER (revisado 2026-03-29)

### Visão do paper

**Um paper, duas contribuições conectadas:**

1. **Teoria (mensuração de poder):** Incorporar informational power (via BP) no framework de Kalandrakis, medindo-o na mesma métrica (expected share) que proposal power e veto power.

2. **Aplicação (design institucional):** O mesmo modelo explica por que legislaturas domésticas usam maioria + proposal power, enquanto OIs usam consenso + informational power.

A mensuração é o alicerce. O design institucional é a aplicação que dá relevância.

### O resultado central: Curse of Knowledge

> Em barganha legislativa (BF) com maioria, ser o Sender (ter informação via BP) PREJUDICA o detentor da informação e BENEFICIA os uninformed.

Este resultado é simultaneamente:
- Um resultado de mensuração (informational power é negativo sob maioria)
- A razão para a variação institucional (Senders preferem unanimidade)

### Estrutura do paper

**1. Introdução: dois puzzles conectados**
- Puzzle 1 (Kalandrakis): Como medir poder informacional junto com proposal/veto?
- Puzzle 2 (OMC): Por que OIs usam consenso enquanto legislaturas usam maioria?
- "A resposta ao primeiro resolve o segundo."

**2. Modelo: BF + BP + pie incerta**
- N jogadores, regra de decisão (maioria ou unanimidade), reconhecimento, δ
- Pie ω ∈ {L, H}, Pr(ω=H) = p
- Um jogador S é Sender: conhece ω, desenha BP

**3. Benchmark: 2 jogadores (Rubinstein + BP)**
- BP gain = L(1-p) × r_R(T)
- Informational power domina proposal power para δ > δ*
- Fórmula fechada para δ*

**4. N jogadores sob MAIORIA**
- Curse of knowledge: S excluído da coalizão
- v_R sobe, v_S desce
- Informational power é NEGATIVO para S
- Explica: legislaturas privilegiam proposal power, não informacional

**5. N jogadores sob UNANIMIDADE**
- S sempre na coalizão (veto efetivo)
- Recupera resultado de N=2: BP ajuda S
- Informational power é POSITIVO para S
- Explica: OIs com consenso maximizam retorno de ser Sender

**6. Escolha institucional endógena**
- Proposição: Sender informado e minoritário prefere unanimidade a maioria
- Estática comparativa: H/L (grau de incerteza), δ, N, custo de informação
- Se custo de informação é sunk (adquirido para política doméstica), Sender prefere consenso

**7. Aplicações**
- **OMC**: Consenso. EUA/UE são Senders (USTR, DG Trade). Consenso protege informational power.
  - Conexão com dissertação de MG (2007): "controle de agenda informal" como explicação insuficiente. Resposta real: consenso + informação = poder via BP.
- **CSNU**: Veto dos P5. P5 = países com mais inteligência → Senders. Veto garante coalizão.
- **FMI**: Maioria ponderada + supermaioria 85% (EUA com 17% = veto efetivo). EUA têm proposal power + veto + informação. Os três tipos.
- **Legislaturas**: Maioria simples. Proposal power via comissões. Informational power é secundário — modelo explica por quê.

**8. Discussão e conclusão**

### Revisão de literatura (realizada 2026-03-29)

**Resultado principal da busca: ninguém combinou BP com BF multilateral nem usou BP para explicar consenso em OIs. A janela está aberta.**

#### Trabalhos mais próximos e posicionamento

**Kim, Kim & Van Weelden (2025, AJPS)** — "Persuasion in Veto Bargaining." BP em veto bargaining com 2 jogadores. Proposer usa persuasão para convencer veto player. Resultado: persuasion aumenta valor de proposal power quando há misalignment. **Posicionamento**: Complementar. Eles fazem 2 jogadores com veto; nós fazemos N jogadores com BF, comparando maioria vs. unanimidade. O curse of knowledge (nosso resultado central) não aparece com 2 jogadores — requer N ≥ 3.

**Alonso & Câmara (2016, AER)** — "Persuading Voters." BP com votação. Resultado: sob maioria, Sender (= Proposer/político) explora heterogeneidade dos votantes. Votantes podem preferir unanimidade para forçar mais revelação. **Posicionamento — RESULTADO ESPELHO (crucial)**: Em A&C, Sender = Proposer. Unanimidade CONSTRANGE o Sender, forçando mais informação. Receivers preferem unanimidade. **No nosso modelo, Sender ≠ Proposer** (papéis separados, como em OIs). Unanimidade PROTEGE o Sender (garante inclusão na coalizão). Receivers preferem MAIORIA (0.428 > 0.252). O resultado se inverte porque a separação de papéis muda quem ganha com cada regra. Citação obrigatória com posicionamento explícito.

**Glynia, Thum & Xefteris (2025-26, Public Choice)** — "Unanimity vs. Majority: Proposing under Incomplete Information." Compara regras com info incompleta em BF. **Posicionamento**: Distinto. Eles têm info PRIVADA (tipo Crawford-Sobel/screening), não BP (information design com commitment). Não há design informacional. O mecanismo é fundamentalmente diferente.

**Schnakenberg (2015, JET; 2017, AJPS)** — Expert advice a voting body; lobbying informacional. BP em contexto político. **Posicionamento**: Precursor importante mas sem barganha multilateral nem comparação de regras.

**"Bayesian Persuasion as a Bargaining Game" (2025, arXiv)** — Trata BP como jogo de barganha. Abordagem reversa à nossa (nós colocamos BP DENTRO de um jogo de barganha).

#### Posicionamento vis-à-vis Alonso & Câmara (o mais importante)

A distinção Sender=Proposer (A&C) vs. Sender≠Proposer (nosso) é a chave:

| | A&C (2016) | Nosso paper |
|---|---|---|
| Sender é... | O Proposer (político) | Um dos N jogadores (país informado) |
| Unanimidade faz... | Constrange o Sender-Proposer | Protege o Sender de exclusão |
| Receivers preferem... | Unanimidade (mais info) | **Maioria** (mais surplus) |
| Sender prefere... | Maioria (mais liberdade) | **Unanimidade** (inclusion guarantee) |
| Aplicação | Eleições domésticas | OIs (OMC, CSNU) |

**Por que R prefere maioria no nosso modelo**: Sob maioria, S é excluído (curse of knowledge). O surplus que iria para S vai para R. v_R(maioria) = 0.428 > v_R(unanimidade+BP) = 0.252. Consenso na OMC não é Pareto — é imposição do Sender.

**Implicação para a OMC**: Países pequenos (R) prefeririam maioria. Consenso existe porque o Sender (EUA/UE) tem poder FORA do modelo (econômico, militar) para impor consenso como pré-condição de participação. Ou porque sem o Sender, a OI não funciona (a informação é necessária para o acordo existir). O consenso protege o informational power dos fortes, não os direitos dos fracos.

#### Gaps confirmados (todos abertos)

| Gap | Nosso paper preenche? |
|-----|----------------------|
| BP + BF multilateral (N jogadores) | ✓ |
| Curse of knowledge em barganha | ✓ |
| BP explica consenso em OIs | ✓ |
| Informational power na métrica de Kalandrakis | ✓ |
| Resultado espelho de A&C (Sender prefere unanimidade quando ≠ Proposer) | ✓ |

#### Risco de scooping: BAIXO
Kim et al. (2025, AJPS) abre caminho — mostra que BP em barganha política é publicável em top journal.

#### Referências organizadas por área

**Poder político e barganha legislativa:**
- Kalandrakis (2006, AJPS) — Proposal rights e poder político
- Baron & Ferejohn (1989, APSR) — Modelo base
- Eraslan & Evdokimov (2019, Annual Rev Econ) — Survey
- Shapley & Shubik (1954) — Medida de poder

**Bayesian Persuasion em política:**
- Kamenica & Gentzkow (2011, AER) — O framework
- Kim, Kim & Van Weelden (2025, AJPS) — Persuasion in veto bargaining
- Alonso & Câmara (2016, AER) — Persuading voters (resultado espelho)
- Schnakenberg (2015, JET; 2017, AJPS) — Expert advice e lobbying
- Bergemann & Morris (2019) — Survey de information design

**Design institucional de OIs:**
- Koremenos, Lipson & Snidal (2001, IO) — Rational design of IOs
- Stone (2011) — Informal governance in IOs
- Steinberg (2002) — Consensus at WTO
- Maggi & Morelli (2006) — Self-enforcing voting in IOs

**Barganha legislativa com informação incompleta:**
- Glynia, Thum & Xefteris (2025-26, Public Choice) — Unanimity vs. majority under incomplete info
- Gilligan & Krehbiel (1987, 1989, APSR) — Cheap talk em comissões
- Krehbiel (1991) — Information and Legislative Organization

### Target journals

1. **APSR** — fala com CP comparada, RI, e teoria formal. Contribuição ampla.
2. **IO (International Organization)** — se enfatizar o lado RI/design de OIs.
3. **AJPS** — se enfatizar a mensuração de poder.
4. **Journal of Politics** — receptivo a teoria formal em CP.

---

## 8. O que fica de fora (outros projetos)

- **BP e observação eleitoral** (paper com Pereira): EOM como Sender, aplicação específica de BP
- **Múltiplos Senders competindo** em OIs
- **Custo endógeno de informação**: quando vale adquirir informação?
- **Jogo repetido**: commitment endógeno via reputação
- **Comparação formal BP vs. cheap talk**: Gilligan-Krehbiel vs. nosso modelo
- **Aplicação empírica**: testar predições sobre OMC, CSNU com dados

---

## 9. Potenciais co-autores

- **Lucas Damasceno Pereira** (IRI-USP 2025): Para o paper separado sobre observação eleitoral. Conhecimento substantivo + dados.
- Para o paper principal: a definir. Possível co-autor com expertise em BF/teoria formal ou em design de OIs.

---

## 10. Próximos passos

1. **Resolver unanimidade no BF com N jogadores** — confirmar que BP ajuda S quando S não pode ser excluído
2. **Provar curse of knowledge para N genérico** sob maioria — generalizar de N=3,5 para N qualquer
3. **Formalizar a proposição de escolha institucional** — Sender prefere unanimidade a maioria
4. **Literature search focada**: "Bayesian persuasion" + "legislative bargaining" / "institutional design" / "consensus" / "WTO"
5. **Horizonte infinito**: verificar se resultados se mantêm em equilíbrio estacionário
6. **Escrever nota técnica** (10-15 páginas) com modelo e resultados principais para circular
