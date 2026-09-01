# Leitura de seção — modelo, protocolo e notação

## Identidade e cobertura

- `reader_id`: `reader-model:/root/contract_model`
- modo: somente leitura; extração argumental, sem avaliação de qualidade e sem edição do manuscrito
- artefato integral lido: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.pdf`
- SHA-256 do PDF: `146fee55cb063b645121f2a6802a85c58816c542a5474442691c0903af5fafc4`
- fonte auxiliar consultada para fórmulas e localizadores: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd`
- SHA-256 do Rmd: `ec9f281efb5e28c4e0b3c1c0c2756a2684aa85f0670e5ce42544ec886c3f0a97`
- cobertura exclusiva deste relatório: S04, “The model” (PDF pp. 8–11; Rmd 280–440); S11, “Appendix A: Protocol, beliefs, and incentives” (PDF p. 35; Rmd 1316–1347); S14, “Appendix D: Notation” (PDF pp. 42–43; Rmd 1623–1663)
- cobertura contextual: o PDF inteiro, 66 páginas, foi lido a partir de uma extração nova para resolver referências; claims de outras unidades não são atribuídos a este leitor, salvo quando explicitamente identificados abaixo como resolução de referência.

## Tese das unidades atribuídas

S04 define o jogo básico de “essential input”: um hegemon informado, mas sem poder de proposta, barganha com estados fracos não informados em duas rodadas sob maioria ou unanimidade. A seção fixa jogadores, informação, conjunto factível, protocolo de voto, transições, payoffs, conceito de solução e as disciplinas de crenças/voto. Ela também delimita a interface de uma extensão separada, na qual o hegemon informado deve propor em uma data anterior.

S11 completa o protocolo ao tornar explícitos todos os ramos de payoff, inclusive o ramo fora da trajetória em que a maioria aprova apesar do voto não do hegemon, e estende as regras de crença e voto a toda proposta, inclusive fora da trajetória.

S14 consolida a notação do jogo básico e dos objetos comparativos da extensão. A tabela é um glossário; ela não acrescenta, por si só, novos resultados de equilíbrio.

## Adaptador formal

### Jogadores

- Um hegemon privado \(H\).
- \(m\geq 3\) estados fracos simétricos, \(W=\{1,\ldots,m\}\).
- Total de \(m+1\) estados.
- Natureza escolhe o tipo de \(H\), representado por seu payoff terminal de desacordo \(o\in\{\ell,h\}\), com \(0<\ell<h<1\).
- Localizador: PDF p. 8, §4.1; Rmd 284–290. Notação reiterada em PDF p. 42; Rmd 1635–1639.

### Timing

1. Natureza escolhe \(o\), observado somente por \(H\).
2. Em cada uma das duas rodadas, um estado fraco é reconhecido uniformemente para propor. Os sorteios são independentes, com reposição; inclusive o proponente da Rodada 1 continua elegível na Rodada 2.
3. O proponente escolhe um pacote \(x\) e conta como voto sim.
4. Todos os demais votam simultaneamente; somente depois de todos os votos o vetor completo e o resultado se tornam públicos.
5. Se a quota é atingida, o pacote é implementado. Se a proposta da Rodada 1 falha, nada é pago naquela data e o jogo vai à Rodada 2. Se a proposta da Rodada 2 falha, ocorre o desacordo terminal.
- Localizador: PDF pp. 8–10, §§4.1–4.2 e Figura 1; Rmd 292–295, 313–321, 331–359, 369–386.

### Informação e crenças

- O prior é \(\Pr(o=h)=p\in[0,1]\); \(H\) conhece \(o\), os estados fracos não.
- Propostas e votos de estados fracos não alteram a crença corrente sobre \(o\).
- Uma ação de \(H\) atualiza por Bayes quando o denominador é positivo.
- Em uma ação de probabilidade zero para ambos os tipos com prior interior, o posterior pode ser qualquer elemento de \([0,1]\), sujeito a “structural consistency” entre histórias que codificam a mesma informação.
- Nos endpoints, o suporte não se expande: \(p=0\) mantém posterior zero e \(p=1\) mantém posterior um em toda história.
- Os históricos públicos \(\mathfrak h^Y\) e \(\mathfrak h^N\) após votos sim/não de \(H\) podem induzir continuações diferentes porque o voto público pode alterar crenças.
- Localizador: PDF pp. 9–10, §§4.2–4.3; PDF p. 35, §A.2; Rmd 355–359, 392–410, 1337–1341.

### Ações e estratégias

- Um proponente fraco \(i\) escolhe \(x=(x_H,(x_j)_{j\in W})\in\mathcal X\).
- Cada respondente escolhe \(Y\) ou \(N\); o proponente é automaticamente contado como \(Y\).
- No jogo básico, \(H\) nunca propõe; sua ação estratégica é o voto, condicionado ao tipo e à história.
- A restrição de pureza declarada recai sobre as estratégias de voto (“pure ballot strategies”). Não encontrei em S04, S11 ou S14 uma restrição que torne puras todas as estratégias de proposta.
- Sob maioria, a proposta requer \(k=\lfloor(m+1)/2\rfloor\) votos sim adicionais ao voto do proponente. Sob unanimidade, requer o sim de todos os estados.
- Localizador: PDF pp. 8–10, §§4.1–4.3; PDF p. 35, §§A.1–A.2; Rmd 292–301, 313–321, 392–399, 1320–1327.

### Factibilidade

\[
\mathcal X=\left\{x:0\leq x_H\leq\bar x_H,\ x_j\geq0,\ x_H+\sum_{j\in W}x_j\leq1\right\},
\qquad h\leq\bar x_H\leq1.
\]

- Pagamentos negativos e side payments fora do pacote são indisponíveis.
- \(x_H\) é a concessão institucional a \(H\); \(x_j\) é a parcela do estado fraco \(j\), inclusive do proponente quando \(j=i\).
- A desigualdade permite folga fora da trajetória; o texto afirma separadamente que o pie unitário é exaurido na trajetória de equilíbrio.
- Localizador: PDF p. 8, §4.1; Rmd 295–309. Notação reiterada em PDF p. 42; Rmd 1642–1644.

### Payoffs e transições

- Se o pacote passa, cada estado fraco recebe a parcela proposta; \(H\) recebe \(x_H\) após votar sim.
- Se \(H\) vota não e uma maioria aprova sem ele, seu payoff geral é \(x_H+o\), pois o termo institucional \(x_H\) é implementado mesmo sem sua aprovação.
- Esse ramo completa o jogo, mas não descreve uma exclusão de equilíbrio: qualquer \(x_H>0\) poderia ser transferido ao proponente sem alterar os votos; por isso, toda exclusão de equilíbrio usa \(x_H=0\) e paga a \(H\) exatamente \(o\).
- Se a Rodada 1 falha, não há payoff corrente; a continuação da Rodada 2 é multiplicada por β em unidades da Rodada 1, com \(\beta\in(0,1)\).
- Se a Rodada 2 falha, cada estado fraco recebe zero e \(H\) recebe \(o\), em unidades da Rodada 2.
- Um voto “não” é apenas uma ação de ballot: não remove o jogador e não aciona desacordo por si só.
- O acordo não dá a \(H\) benefício intrínseco além de \(x_H\).
- Localizador: PDF pp. 8–9, §§4.1–4.2 e Tabela 2; PDF p. 35, §A.1; Rmd 307–309, 323–359, 1320–1333.

### Conceito de equilíbrio e disciplinas declaradas

- Conceito: perfect Bayesian equilibrium com estratégias puras de voto.
- Disciplina 1, crenças: ações de jogadores que não conhecem (o) não mudam crenças; ações de (H) seguem Bayes quando possível e “structural consistency” caso contrário; endpoints preservam suporte.
- Disciplina 2, voto fraco: cada respondente fraco compara sim e não como se seu próprio voto fosse pivotal.
- Disciplina 3, igualdade: um eleitor vota sim quando exatamente indiferente em valor esperado.
- O Apêndice A explicita que (H) maximiza o payoff de continuação contingente ao tipo e vota sim em indiferença exata.
- Todas essas restrições valem em toda proposta, inclusive fora da trajetória.
- Seleção de propostas: entre propostas que dão o mesmo payoff esperado ao proponente, escolhe-se a que minimiza o payoff esperado de (H). O texto apresenta essa seleção depois das três disciplinas; convém não recontá-la como uma quarta disciplina de voto.
- Localizador: PDF p. 10, §4.3 e Tabela 3; PDF p. 35, §A.2; Rmd 392–410, 420–426, 1337–1347.

### Escopo mantido

- Um (H), (m\geq3) estados fracos, duas rodadas.
- Somente estados fracos propõem nas duas rodadas do benchmark.
- Ballots simultâneos e públicos após o fechamento, sob maioria ou unanimidade.
- Tipo binário privado (o\in\{\ell,h\}) e endpoints com preservação de suporte.
- Pie unitário; (0<\ell<h<1); (0<\beta<1); sem benefício intrínseco de acordo para (H).
- PBE com estratégias puras de voto e as regras declaradas de voto e desempate de propostas.
- Localizador: PDF pp. 10–11, Tabela 3; Rmd 412–429.

### Interface da extensão de agenda

- O benchmark continua sendo o modelo primário.
- Em uma extensão separada, o hegemon informado deve fazer uma proposta anterior na data (A).
- Aprovação implementa a proposta imediatamente; rejeição entra na Rodada 1 do benchmark e transporta a continuação completa por exatamente um fator \(\beta\).
- (H) não pode pular a proposta e manter uma continuação na data (A).
- S04 remete os resultados econômicos à Seção 6 e as correspondências completas/convenções de data aos Apêndices E–F.
- S14 nomeia (B) e (A) como os jogos sem e com o estágio anterior de agenda, e introduz os objetos (v,V,IR,\Delta IR,e,v_M^{\mathrm{safe}},o_M^*,\rho,\Delta v^A,\Delta V^A,D,I,T,Q).
- Localizador: PDF p. 11, §4.4; PDF pp. 42–43, Tabela 7; Rmd 431–440, 1647–1661.
- Resolução de referência fora da unidade atribuída: Appendix E.1 afirma que a proposta de (H) conta como seu voto afirmativo, os estados fracos votam simultaneamente e em estratégias puras, e a rejeição recebe exatamente um fator \(\beta\) (PDF pp. 43–44; Rmd 1678–1688). Essa informação resolve o protocolo de votação da extensão, mas não é um claim originado em S04/S11/S14.

## Claims explícitos

| claim | localizador | evidência | scope/hedge |
|---|---|---|---|
| O benchmark tem um hegemon e (m\geq3) estados fracos. | PDF p. 8, §4.1; Rmd 284–290 | Definição literal dos jogadores e domínio. | Somente o benchmark de duas rodadas. |
| (H) observa privadamente (o\in\{\ell,h\}), com prior (p). | PDF p. 8, §4.1; Rmd 284–290 | Movimento de Natureza e desigualdade (0<\ell<h<1). | Tipo binário; não afirma mais tipos. |
| Somente estados fracos propõem no benchmark, por reconhecimento uniforme, independente e com reposição em cada rodada. | PDF p. 8, §4.1; Rmd 292–295 | Regra explícita de reconhecimento. | Não se aplica ao estágio anterior da extensão. |
| As propostas pertencem a 𝒧 e não admitem pagamentos negativos nem side payments externos. | PDF p. 8, §4.1; Rmd 295–306 | Conjunto factível e proibições textuais. | 𝒧 admite folga; exaustão é afirmada apenas na trajetória de equilíbrio. |
| O pie unitário é exaurido na trajetória de equilíbrio. | PDF p. 8, §4.1; Rmd 306–307 | Afirmação textual. | Propriedade de trajetória, não igualdade embutida na definição de 𝒧. |
| O acordo não produz benefício intrínseco para (H) além de (x_H). | PDF p. 8, §4.1; Rmd 307–309 | Normalização textual. | Isola concessão informacional e pivotalidade. |
| Os votos dos respondentes são simultâneos, e vetor/resultado só ficam públicos após todos votarem. | PDF p. 9, §4.2; Rmd 313–315 | Regra temporal explícita; Figura 1. | O proponente já conta como sim. |
| Sob maioria, (k=\lfloor(m+1)/2\rfloor) votos adicionais bastam; unanimidade exige todos. | PDF p. 9, §4.2; Rmd 316–321 | Fórmula de (k) e quota textual. | O protocolo restante é idêntico entre regras. |
| Se maioria passa apesar do não de (H), o payoff geral de (H) é (x_H+o). | PDF p. 9, §4.2; Rmd 323–329 | Regra de payoff e Tabela 2. | Ramo completo do jogo, não descrição de exclusão de equilíbrio. |
| Toda exclusão de equilíbrio usa (x_H=0) e paga (o) a (H). | PDF p. 9, §4.2; PDF p. 35, §A.1; Rmd 327–329, 1329–1333 | Desvio que transfere (x_H>0) ao proponente mantendo votos fixos. | Restrito a propostas que passam sem (H). |
| Falha na Rodada 1 leva à Rodada 2 sem payoff corrente; a continuação é descontada por \(\beta\). | PDF p. 9, §4.2 e Tabela 2; Rmd 331–350 | Regra de transição e payoffs. | \(0<\beta<1\). |
| Falha terminal paga zero aos fracos e (o) a (H). | PDF p. 9, §4.2; PDF p. 35, §A.1; Rmd 333–335, 1324–1327 | Regra terminal explícita. | Em unidades da Rodada 2. |
| Um voto não não retira o jogador nem aciona desacordo sozinho. | PDF p. 9, §4.2; Figura 1; Rmd 335–337, 384–386 | Negação textual explícita. | Vale para ambos os rounds. |
| Históricos públicos distintos do voto de (H) podem gerar continuações distintas por atualizar crenças. | PDF pp. 9–10, §4.2; Rmd 355–359 | Definição de 𝔥ᵃ, 𝔥ᴺ e (C_H). | “Need not be equal”; não exige que sempre difiram. |
| O conceito é PBE com estratégias puras de voto e disciplinas adicionais. | PDF p. 10, §4.3; Tabela 3; Rmd 392–399, 425–426 | Declaração literal. | Não equivale a restringir todas as estratégias a puras. |
| Ações de não informados preservam a crença; ações de (H) seguem Bayes quando possível. | PDF p. 10, §4.3; PDF p. 35, §A.2; Rmd 392–396, 1337–1341 | Disciplina de crenças. | Fora da trajetória, aplica-se “structural consistency”. |
| Priors degenerados preservam suporte; com prior interior, uma ação zero-probabilidade de (H) para ambos os tipos admite qualquer posterior em ([0,1]). | PDF p. 10, §4.3; Rmd 401–410 | Regra explícita de endpoints e off path. | A preservação de suporte é condição do conceito, não teorema de trembles. |
| Respondentes fracos avaliam o voto como se fossem pivotais. | PDF p. 10, §4.3; PDF p. 35, §A.2; Rmd 396–397, 1343–1344 | Regra as-if-pivotal. | Aplica-se a toda proposta, inclusive off path. |
| Em indiferença exata, o voto é sim; (H) maximiza payoff de continuação contingente ao tipo. | PDF p. 10, §4.3; PDF p. 35, §A.2; Rmd 397–399, 1343–1347 | Regra de indiferença e esclarecimento do Apêndice A. | Igualdade é em valor esperado conforme S04. |
| O desempate entre propostas indiferentes ao proponente minimiza o payoff esperado de (H). | PDF p. 10, §4.3; Rmd 398–399 | Regra explícita de seleção. | Somente quando o proponente tem o mesmo payoff esperado. |
| A extensão adiciona uma proposta anterior obrigatória de (H), com passagem imediata ou continuação completa do benchmark descontada uma vez. | PDF p. 11, §4.4; Rmd 431–440 | Interface textual da extensão. | Extensão separada; benchmark segue primário. |
| A Tabela 7 distingue payoffs públicos (v), correspondências privadas (V), rendas (IR) e contrastes orientados unanimidade menos maioria. | PDF pp. 42–43, Appendix D; Rmd 1647–1658 | Definições de notação. | A tabela nomeia objetos; fórmulas/domínios vêm das seções de resultados e apêndices correspondentes. |
| (D_g,I_g,T_g,Q_g) são, respectivamente, efeito direto público da agenda, interação agenda–informação, efeito privado total da agenda e comparação diagonal. | PDF p. 43, Appendix D; Rmd 1659–1661 | Definição da Tabela 7. | A interpretação causal exata e a advertência sobre (Q_g) são dadas fora das unidades atribuídas. |

## Evidência disponível nas unidades

- A evidência é formal e definicional: conjunto factível, regra de reconhecimento, árvore temporal, tabela de transições/payoffs, sistema de crenças, restrições de voto e glossário.
- A.1 fornece o argumento local para (x_H=0) em toda exclusão de equilíbrio: mover (x_H>0) ao proponente preserva os votos e aumenta estritamente seu payoff.
- Não encontrei evidência empírica, calibração ou teste histórico em S04, S11 ou S14; essas unidades não apresentam tal pretensão.
- Não encontrei nessas unidades uma função utilidade única escrita como (u_i(\cdot)); os payoffs são especificados por eventos e ramos.

## Não-afirmações e guardrails

- O benchmark não dá a (H) poder de proposta: (H) nunca é reconhecido nas duas rodadas.
- Um voto não de (H) não é opt-out, saída ou acionamento imediato do desacordo.
- O ramo (x_H+o) após não de (H) e aprovação majoritária não é apresentado como trajetória de exclusão de equilíbrio com (x_H>0).
- O modelo não inclui benefício intrínseco de acordo para (H).
- O modelo não permite side payments fora do pacote proposto.
- A preservação de suporte nos endpoints não é apresentada como consequência teoremática de tremble consistency; trembles são apenas motivação.
- O conceito não é declarado como “PBE em estratégias puras” sem qualificação: a pureza explicitada é a das estratégias de voto.
- Não encontrei em S04/S11/S14 derivação, caracterização ou seleção de equilíbrios com votos mistos.
- Não encontrei nos bytes do manuscrito os rótulos `T^Y` ou `stage-undominated voting`; a terminologia operacional usada é “as-if-pivotal” e “indifference-to-yes”.
- A extensão de agenda não dá a (H) a opção de omitir sua proposta mantendo o payoff da data (A); a proposta é obrigatória.
- A notação (Q_g) não deve ser lida como efeito causal de um único fator: a resolução posterior em Appendix E.14 diz que ela muda agenda e informação ao mesmo tempo. Essa é uma resolução de referência, não um claim originado em S14.

## Ambiguidades textuais reais

1. **Alcance operacional de “structural consistency”.** S04 diz que crenças off path devem satisfazer structural consistency; S11 acrescenta consistência entre histórias que codificam a mesma informação. Não encontrei em S04/S11/S14 uma definição matemática completa da relação entre essas histórias. A extensão posterior usa o rótulo M/S/B e uma coordenada \(\rho\), mas não encontrei no PDF uma expansão literal da sigla `M/S/B`. O macro deve manter o termo como disciplina declarada ou importar cuidadosamente a especificação de Appendix E, sem inventar uma expansão.

2. **Teto \(\bar x_H\) na extensão de agenda.** O benchmark define \(x_H\leq\bar x_H\) (PDF p. 8; Rmd 300–303), e S14 mantém \(\bar x_H\) na notação (PDF p. 42; Rmd 1643). S04 chama a proposta da extensão apenas de “feasible division”. Na resolução de referência, E.1 inclui \(\bar x_H\) no vetor de primitivas, mas escreve o conjunto da extensão sem a desigualdade \(x_H\leq\bar x_H\) (PDF p. 43; Rmd 1672–1682). Esses trechos não determinam univocamente, por si só, se o teto é herdado ou omitido no estágio (A).

3. **Medida do payoff “esperado” no desempate de propostas.** A regra minimiza o payoff esperado de (H), mas S04/S11/S14 não escrevem a distribuição usada nessa expectativa em cada história. A leitura natural é a crença corrente, porém não encontrei uma fórmula local explícita.

4. **Estratégias puras: alcance restrito a ballots.** S04 qualifica expressamente “pure ballot strategies”, mas a introdução/abstract por vezes usam formulações abreviadas como “pure-strategy correspondence”. O adaptador deve preservar a formulação mais precisa de S04; não encontrei nas unidades atribuídas uma restrição de pureza para propostas.

5. **Marcador renderizado `[AUTHOR: P1]`.** O PDF p. 9 e o Rmd 336 exibem esse marcador imediatamente antes da interpretação de que o desacordo terminal atrasado representa o custo de prolongar negociações internacionais. Não encontrei no documento uma definição do status do marcador; o macro deve decidir se o trata como anotação editorial visível ou como parte do texto autoral, sem alterar o claim econômico que o sucede.

6. **Rótulo resumido de (Q_g).** S14 chama (Q_g) de “diagonal agenda-only versus information-only comparison”, enquanto Appendix E.14 esclarece que o objeto altera dois fatores de uma vez e não é efeito causal isolado. O contrato deve carregar a qualificação posterior para impedir uma leitura causal indevida.

## Terminologia que deve permanecer consistente

- `hegemon` / (H); `weak states` / (W); não substituir por proposer e responders de forma que apague a assimetria de informação.
- `terminal disagreement payoff` e `outside option` para (o\in\{\ell,h\}); registrar que o manuscrito usa ambos os termos.
- `institutional concession` para (x_H); `weak-state share` para (x_j); `proposer's share` para (x_i).
- `fixed unit pie`; `feasible allocation vector` \(x\in\mathcal X\); `maximum feasible allocation` \(\bar x_H\).
- `majority` (M), `unanimity` (U), `additional yes votes` (k), `simultaneous public ballots`.
- `perfect Bayesian equilibrium with pure ballot strategies`.
- `as-if-pivotal`, `indifference-to-yes`, `support-preserving endpoints`, `structural consistency`, `proposal tie-break`.
- `baseline/no-agenda arm` (B) e `agenda arm` (A); `earlier mandatory hegemonic agenda stage`.
- (v_g^B,v_g^A) para payoffs públicos; (V_g^B,V_g^A) para correspondências privadas; (IR) para private minus same-arm public benchmark.
- Contrastes institucionais orientados `unanimity minus majority`: \(\Delta IR,\Delta v^A,\Delta V^A\).
- (e=m-k), (v_M^{\mathrm{safe}}), (o_M^*\), \(\rho\), \(\mu^{\mathrm{off}}\), (D_g,I_g,T_g,Q_g).
- Não usar `T^Y` ou `stage-undominated voting` como se fossem rótulos do manuscrito: não encontrei esses termos nos bytes revisados.

## Perguntas para o agente macro

1. O contrato macro registrará explicitamente “PBE com estratégias puras de voto”, evitando a abreviação mais ampla “pure-strategy PBE”?
2. O macro consegue resolver, a partir de E–F, se a proposta de agenda está sujeita a (x_H\leq\bar x_H), ou deve conservar isso como ambiguidade textual do artefato?
3. O contrato precisa operacionalizar “structural consistency” para o benchmark além da descrição de S11? Se sim, qual localizador posterior o faz sem confundir a disciplina básica com a fibra M/S/B da extensão?
4. Qual crença deve ser registrada como medida da expectativa no desempate que minimiza o payoff esperado de (H)? Há um localizador posterior que elimine a dúvida?
5. O macro incluirá a regra de E.1 de que a proposta de (H) conta como voto afirmativo como parte da interface da extensão, embora S04 apenas remeta aos apêndices?
6. O macro tratará `[AUTHOR: P1]` como anotação editorial visível ou parte do texto final? O claim subsequente deve permanecer ancorado em PDF p. 9 de qualquer forma.
7. O macro registrará (Q_g) como comparação diagonal não causal, carregando a qualificação de Appendix E.14 além do rótulo curto da Tabela 7?
8. As regras de payoff por eventos são suficientes para o adaptador formal, ou o macro precisa registrar explicitamente que não encontrou uma função utilidade agregada (u_i(\cdot)) nas unidades do modelo?

## Itens não encontrados

- Uma expansão literal da sigla `M/S/B`: não encontrei.
- Os rótulos `T^Y` e `stage-undominated voting`: não encontrei.
- Uma restrição de pureza para todas as estratégias de proposta no benchmark: não encontrei.
- Uma fórmula local para a crença usada no payoff esperado do desempate entre propostas: não encontrei.
- Uma função utilidade única (u_i(\cdot)) que substitua as regras de payoff por eventos: não encontrei.
- Evidência empírica ou calibração nas unidades S04/S11/S14: não encontrei.
