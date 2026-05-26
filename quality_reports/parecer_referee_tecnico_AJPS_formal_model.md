# Parecer técnico de referee — modelo formal sobre consenso, pivotalidade e hegemonia

**Manuscrito:** *Informational Power Through Pivotality: When a Hegemon May Choose Consensus*  
**Tipo de avaliação:** referee report técnico, com ênfase em teoria dos jogos, equilíbrio, provas, payoffs e calibração.  
**Recomendação editorial:** **Reject na forma atual**. Uma versão substancialmente reformulada poderia ser considerada, mas o manuscrito ainda não atinge o padrão de uma contribuição formal publicável em AJPS.

---

## 1. Resumo do argumento

O paper propõe um modelo de barganha institucional com um hegemon `H` e `m = N − 1` estados fracos. O hegemon tem tipo privado, `θ ∈ {0,1}`, associado a um limiar de participação `t_θ`. A contribuição pretendida é separar três canais que frequentemente aparecem misturados: payoff externo, pivotalidade e poder de agenda. O baseline fixa `π_H = 0`, de modo que apenas estados fracos fazem propostas. Sob maioria, estados fracos podem aprovar uma proposta sem `H`, desde que o tipo baixo de `H` não seja mais barato do que um voto fraco. Sob unanimidade, `H` é pivotal, e os proponentes fracos precisam escolher entre pooling, teste do tipo baixo ou atraso sem informação.

A ideia central é interessante: consenso pode gerar poder informacional para o ator pivotal mesmo sem poder formal de agenda. Contudo, a versão atual não entrega uma caracterização de equilíbrio suficientemente limpa. O principal resultado de Round 1 depende de uma avaliação de crenças altamente específica, não de uma caracterização robusta de PBE/sequential equilibrium. A calibração também está em um caso de fronteira que bloqueia separação estrita, o que enfraquece justamente o mecanismo que o texto vende como screening informacional.

---

## 2. Avaliação geral

O manuscrito tem uma arquitetura promissora, mas os resultados principais são mais frágeis do que a apresentação sugere. Há três problemas centrais.

Primeiro, o conceito de equilíbrio é insuficientemente disciplinado. O paper afirma trabalhar com PBE sob uma “weak-vote-passive assessment”, mas essa assessment faz trabalho substantivo demais. Ela fixa crenças fora do caminho, restringe como votos públicos devem ser interpretados e seleciona candidatos. Isso transforma o resultado de Round 1 em uma seleção sob protocolo ad hoc, não em uma caracterização de equilíbrios.

Segundo, o resultado de unanimidade em Round 1, especialmente a Proposição 2, não é uma prova completa de exaustão estratégica. A demonstração compara três candidatos — `P`, `L`, `R` — mas não fornece uma estratégia completa para todos os jogadores após todas as propostas possíveis nem mostra que nenhum outro sistema de crenças sequencialmente racional sustenta payoffs diferentes. O próprio texto admite que não caracteriza PBEs irrestritos; isso é uma limitação séria para uma peça formal que pretende fazer uma afirmação geral sobre consenso.

Terceiro, a calibração “OPEC-style” é uma ilustração paramétrica escolhida, não uma calibração empírica. Além disso, ela se apoia na igualdade `a_0^1 = a_1`, uma fronteira que elimina separação low-only estrita. Isso torna a principal narrativa de screening muito menos convincente. Na calibração, o resultado é pooling para todos os valores de `μ`; o mecanismo de separação/teste aparece apenas em exemplos diagnósticos fora da calibração principal.

Minha recomendação é rejeição na forma atual. O paper precisaria de uma revisão estrutural: caracterização formal de equilíbrio, regra de seleção institucional endógena, calibração não degenerada e melhor alinhamento entre teoria e aplicação empírica.

---

## 3. Comentários maiores

### 3.1. O conceito de equilíbrio é o maior problema do paper

O paper declara que caracteriza “pure-strategy PBE outcomes under the weak-vote-passive assessment”. Essa formulação é insuficiente. Uma assessment de crenças pode fazer parte de um PBE, mas aqui ela funciona como uma restrição adicional sobre interpretações de votos públicos, sobretudo fora do caminho. O resultado não é uma propriedade do jogo; é uma propriedade do jogo mais uma regra de interpretação imposta.

O ponto crítico é que a assessment determina exatamente quais desvios informam sobre `θ` e quais não informam. Por exemplo:

- desvios unilaterais de estados fracos não atualizam crenças sobre `θ`;
- quando `H` deveria votar sim em pooling e vota não, o posterior é fixado em `ν = 1`;
- quando uma proposta falha porque algum estado fraco recebe menos do que seu valor de continuação, o voto de `H` é tratado como não informativo.

Essas escolhas não são derivadas de Bayes no caminho nem de um refinamento padrão. Elas são assumidas. Como os limiares dinâmicos de aceitação dependem diretamente de `C_θ(ν)`, essas crenças fora do caminho entram nos payoffs e nas restrições de incentivo. Em particular, `a_0^1 = t_0 − o_0 + βC_0(1)` depende da hipótese de que uma rejeição do tipo baixo é interpretada como posterior alto. Esse é um objeto central, não um detalhe técnico.

Para AJPS, o autor precisa fazer uma de três coisas:

1. caracterizar o conjunto de PBEs sob crenças arbitrárias e depois mostrar onde o resultado sobre unanimidade sobrevive;
2. justificar a assessment por um refinamento padrão, por exemplo sequential equilibrium com perturbações explicitadas, D1/intuitive criterion quando aplicável, ou uma estrutura informacional microfundada;
3. rebaixar a contribuição: apresentar o modelo como uma análise de um protocolo institucional específico, não como uma caracterização geral do efeito de consenso.

Na versão atual, a assessment carrega o resultado.

### 3.2. A Proposição 2 não é uma caracterização completa de PBE

A Proposição 2 afirma que o resultado selecionado em Round 1 sob unanimidade é payoff-equivalente a um dos três candidatos: pooling `P`, low-only `L` ou rejeição sem informação `R`. A prova não é suficiente para uma revista de teoria formal.

O problema não é a comparação algébrica entre `Π_P^U(μ)`, `Π_L^U(μ)` e `Π_R^U(μ)`. Essa parte é clara. O problema é a alegação de exaustão. A prova precisa mostrar que, para qualquer proposta `(y,x_1,...,x_m)`, nenhuma combinação alternativa de estratégias de voto e crenças sequencialmente racionais gera um payoff maior para o proponente fraco. O texto não faz isso. Ele restringe o espaço por meio da assessment e depois compara candidatos.

A Step 5 do Apêndice A.3 é particularmente fraca. Ela descarta “informative rejected ballots” com o argumento de que o tipo baixo prefere mimetizar o voto que induz posterior alto, pois `βC_0(1) > βC_0(0)`. Isso mostra uma força intuitiva relevante, mas não fecha a prova. Faltam pelo menos quatro elementos:

- especificar as estratégias completas de `H` após propostas arbitrárias, não apenas após os candidatos selecionados;
- especificar as estratégias completas dos votantes fracos em todos os histories de proposta;
- mostrar sequencial rationality para todos os jogadores em todos os histories relevantes;
- mostrar que as crenças usadas após cada falha são consistentes com o sistema de estratégias e com Bayes sempre que possível.

Além disso, a votação é simultânea. Logo, várias ações são não pivotais em equilíbrio. O paper usa prescrições comportamentais para votos não pivotais, mas não mostra por que essas prescrições são selecionadas por algum refinamento. Isso importa especialmente para o candidato `R`, no qual a proposta é desenhada para falhar por rejeição fraca.

A formulação correta deveria ser algo como: “Sob a assessment X e sob as estratégias Y, existe um PBE cujo payoff selecionado pertence a `{P,L,R}`.” Isso é muito mais fraco do que a linguagem atual de “candidate exhaustion”.

### 3.3. A assessment “weak-vote-passive” mistura uma hipótese plausível com escolhas fortes e controversas

Há uma intuição defensável: estados fracos não observam o tipo de `H`, então um desvio unilateral de um estado fraco não deveria sinalizar `θ`. Isso é plausível.

Mas o paper vai além. Ele também impõe crenças específicas após desvios de `H` em histories de pooling. Em particular, se ambos os tipos de `H` deveriam votar sim e `H` vota não, o posterior é fixado em `ν = 1`. Essa escolha favorece a interpretação de que a rejeição é sinal do tipo alto. Talvez seja natural. Mas ela não é neutra. Ela aumenta o valor de continuação do tipo baixo quando o posterior alto induz pooling terminal, pois o tipo baixo recebe a renda `t_1 − t_0` no Round 2. Portanto, a própria ameaça de ser interpretado como alto disciplina o limiar de aceitação do tipo baixo no Round 1.

Esse é um ponto substantivo: a renda informacional do tipo baixo no modelo depende de como o observador interpreta rejeições fora do caminho. O paper precisa reconhecer que esse não é apenas um protocolo de voto; é uma hipótese de seleção de crenças com força substantiva.

### 3.4. O paper não modela realmente “quando o hegemon escolhe consenso”

O título e a introdução perguntam por que um hegemon escolheria consenso. Mas o modelo não contém uma etapa em que `H` escolhe a regra. A regra institucional é comparada por fora. A entrada é decidida coletivamente pelos estados fracos, com custo `χ`, e o resultado formal é uma classificação de regiões em que unanimidade e/ou maioria formam.

A Proposição 4 diz apenas que, condicionalmente a ambas as instituições formarem, `H` prefere unanimidade se `Δ_H(μ) > 0`. Isso é verdadeiro por definição. Não é uma teoria de escolha institucional pelo hegemon.

Para sustentar a linguagem do paper, seria necessário adicionar uma etapa de escolha de regra. Por exemplo:

- `H` propõe uma regra e estados fracos decidem entrar;
- estados fracos escolhem a regra antecipando os payoffs de `H`;
- há uma barganha constitucional sobre `R ∈ {U,M}`;
- ou há um designer externo com pesos distributivos.

Sem essa etapa, o paper deveria mudar o framing: não é “quando o hegemon escolhe consenso”, mas “quando o hegemon prefere consenso, condicionalmente à formação institucional”. Essa diferença é editorialmente importante.

### 3.5. A calibração principal é degenerada para o mecanismo de screening

A calibração fixa:

`N = 13`, `m = 12`, `β = 0.9`, `t_0 = 0.19`, `t_1 = 0.285`, `o_0 = t_0`, `o_1 = t_1`.

Com esses valores:

`μ_2^* = 0.117283950617`,  
`a_1 = 0.2565`,  
`a_0^1 = 0.2565`.

Logo,

`a_1 − a_0^1 = 0`.

Mas a folga geral é:

`a_1 − a_0^1 = (1 − β)(t_1 − t_0 + o_0 − o_1)`.

Ao escolher `o_1 − o_0 = t_1 − t_0`, o paper coloca a calibração exatamente na fronteira. Isso bloqueia separação low-only estrita. O próprio texto reconhece isso, mas não absorve totalmente a implicação: a principal ilustração não mostra screening estrito em Round 1. Ela mostra pooling para todos os valores de `μ`.

Isso é um problema porque a narrativa do paper enfatiza que unanimidade força estados fracos a escolher entre pooling, pacote low-threshold e delay. Na calibração usada para gerar as principais conclusões substantivas, a opção low-only não é admissível. Assim, a aplicação numérica não demonstra a geometria completa do mecanismo.

A robustez reportada também não resolve o problema. A Tabela 6 apresenta janelas de perturbação unilaterais, não uma vizinhança aberta. A coluna “pooling-only” é degenerada para praticamente todos os parâmetros estruturais, exceto `β`. A Tabela 7 mostra que pequenas mudanças substantivas podem trocar o candidato selecionado para rejeição ou introduzir low-only/pooling. Portanto, o resultado “pooling para todos os beliefs” não é robusto; e o paper também não apresenta uma calibração central não degenerada em que o mecanismo de screening opere de forma transparente.

### 3.6. A “calibração OPEC-style” não é uma calibração

O texto chama os números de “working OPEC-style calibration”, mas os parâmetros não são estimados, calibrados a momentos observáveis, nem justificados por dados externos. `t_0 = 0.19`, `t_1 = 0.285`, `o_0 = t_0` e `o_1 = t_1` parecem escolhidos para gerar uma classificação conveniente:

`V_W^U = 0.0619583`,  
`V_W^M = 0.0833333`,  
`Δ_H(μ) = 0.0665 − 0.095μ`,  
com cruzamento em `μ = 0.7`.

A aritmética está correta. O problema é interpretativo. Esses números não são uma calibração empírica de OPEC; são uma ilustração numérica com rótulo substantivo. Para AJPS, isso deve ser apresentado como “illustrative numerical example”, a menos que o autor forneça disciplina empírica clara para thresholds, outside payoffs, custos de entrada e beliefs.

Também há uma tensão substantiva. O benchmark de maioria assume que a coalizão sem `H` preserva a unidade inteira de excedente fraco (`ρ = 1`). Em OPEC, excluir a Arábia Saudita provavelmente alteraria dramaticamente o valor da coordenação. O paper reconhece que poderia haver `ρ < 1`, mas não explora como isso muda a classificação. Para uma aplicação a OPEC, essa extensão não é opcional; é central.

### 3.7. O resultado de nesting é quase contábil

A Proposição 3 mostra que, sob No-Cheap-H, `V_W^U(μ) ≤ V_W^M(μ) = 1/m`. A prova é correta, mas o resultado é quase mecânico: em maioria, os estados fracos mantêm o excedente total normalizado a 1; em unanimidade, ou pagam algo a `H`, ou atrasam, ou ambos. Portanto, `S_K^U(μ) ≤ 1`.

Esse resultado não é errado. Mas ele não deve ser vendido como uma descoberta substantiva forte. Ele segue diretamente da normalização de fixed pie e do benchmark favorável à maioria. A parte substantiva teria de vir de `Δ_H(μ)`, mas essa comparação é definida por construção e depois ilustrada por calibração.

### 3.8. A maioria é tratada de forma mais limpa do que a unanimidade, mas o benchmark ainda precisa de escopo mais explícito

A Proposição 1 é uma das partes mais sólidas do paper. A condição No-Cheap-H,

`a_0^M = t_0 − (1 − β)o_0 ≥ β/m`,

é uma comparação clara entre comprar o tipo baixo de `H` e comprar um votante fraco. A prova algébrica está correta sob as hipóteses do modelo. Em particular, o gap do payoff de uma proposta majority-including low-only em relação ao caminho no-H é:

`c_M − a_0^M + μ(a_0^M + k c_M − 1)`,

com `c_M = β/m`. A condição em `μ = 0` dá a necessidade, e os endpoints fecham a suficiência.

Mas o paper deveria deixar claro que essa é uma caracterização do benchmark sob uma seleção específica de continuação: após falha, a maioria terminal exclui `H`, e o payoff de continuação de `H` é `o_θ`. Além disso, se No-Cheap-H falha, o paper apenas observa que maioria pode também screenar `H`, mas não caracteriza essa região. Dado que o contraste entre maioria e unanimidade é central, a região complementar não deveria ser tratada apenas como nota de escopo.

### 3.9. Há ambiguidade no tratamento temporal do outside payoff

A fórmula dinâmica de aceitação é:

`a_θ(ν) = t_θ − o_θ + βC_θ(ν)`.

Isso implica que, se uma proposta é rejeitada no Round 1, o jogador não recebe um payoff corrente `o_θ`; ele recebe apenas o payoff de continuação descontado. Se a interpretação substantiva é que `o_θ` é uma alternativa externa disponível durante atraso, seria natural considerar `o_θ + βC_θ(ν)` como payoff de rejeição. O paper usa uma estrutura de payoff terminal/one-shot, não uma outside option de fluxo.

Essa escolha pode ser perfeitamente válida, mas precisa ser explicitada. Na aplicação a OPEC, o payoff externo de produção unilateral, spare capacity, ameaça de guerra de preços etc. parece mais próximo de uma oportunidade de fluxo do que de um payoff terminal. Se o timing de `o_θ` mudar, os limiares dinâmicos mudam, e com eles a calibração.

### 3.10. A aplicação a OPEC está subdesenvolvida em relação ao modelo

A seção de OPEC é plausível como motivação, mas não como evidência. O paper mapeia `H` para Arábia Saudita, `y` para quota/flexibilidade/exceções e `t_θ` para threshold de participação. Isso é intuitivo. Mas há pelo menos três lacunas:

1. O modelo fixa `π_H = 0`, enquanto a Arábia Saudita provavelmente tem influência informal ou formal sobre agenda, timing e viabilidade das propostas.
2. O benchmark de maioria sem `H` mantém excedente total dos fracos, uma hipótese difícil de defender em cartel de petróleo.
3. A unidade de excedente, os thresholds e os custos de entrada não são conectados a quantidades observáveis.

Como ilustração, a seção funciona. Como sustentação empírica de um mecanismo em AJPS, ela ainda é insuficiente.

---

## 4. Verificação técnica de resultados específicos

### 4.1. Lemma 1: terminal unanimity

O Lemma 1 parece correto. Em Round 2, rejeição encerra a barganha, votantes fracos têm continuação zero, e o proponente compara apenas:

`(1 − μ)(1 − t_0)` contra `1 − t_1`.

O cutoff

`μ_2^* = (t_1 − t_0)/(1 − t_0)`

segue diretamente. A fórmula para `C_0(ν)` e `C_1(ν)` também é consistente: o tipo alto recebe `o_1` em qualquer posterior, enquanto o tipo baixo recebe renda adicional `t_1 − t_0` quando o posterior induz pooling terminal.

### 4.2. Proposition 1: maioria sem screening

A Proposição 1 é tecnicamente convincente sob as hipóteses impostas. A condição `a_0^M ≥ β/m` é realmente a margem relevante. A prova deveria, porém, explicitar melhor as estratégias e crenças no subgame de votação majoritária, especialmente quando `H` é incluído e rejeita. A continuidade com a assessment usada em unanimidade também deveria ser clarificada.

### 4.3. Proposition 2: unanimidade em Round 1

Esta é a proposição mais problemática. A comparação de candidatos está bem definida:

`Π_P^U(μ) = 1 − a_1 − (m − 1)c(μ)`,

`Π_L^U(μ) = (1 − μ){1 − a_0^1 − (m − 1)c(0)} + μc(1)`,

`Π_R^U(μ) = c(μ)`.

Mas a prova de que esses são os únicos candidatos payoff-relevantes depende da assessment. Não é uma caracterização de PBE irrestrito. A proposição deveria ser renomeada e enfraquecida. Algo como “Candidate selection under the maintained assessment” seria mais honesto do que uma proposição de equilíbrio.

### 4.4. Proposition 3: nesting de entrada

A prova é correta, mas substantivamente fina. Como `S_P^U = 1 − a_1 ≤ 1`, `S_L^U ≤ 1` e `S_R^U ≤ 1`, segue `V_W^U ≤ 1/m`. Sob No-Cheap-H, `V_W^M = 1/m`. Isso é contabilidade do fixed pie, não uma propriedade profunda da regra de unanimidade.

### 4.5. Proposition 4 e Corollary 1

A Proposição 4 é basicamente definicional: se ambas as instituições formam, a preferência de `H` é o sinal de `Δ_H(μ)`. O Corolário 1 também é uma partição por construção. Isso não é um problema lógico, mas o paper deveria evitar apresentar esses objetos como resultados formais substantivos.

### 4.6. Calibração

A aritmética principal está correta:

- `μ_2^* = 0.095/0.81 = 0.117283950617`;
- `a_1 = 0.285 − 0.1 × 0.285 = 0.2565`;
- `a_0^1 = 0.19 − 0.19 + 0.9(0.19 + 0.285 − 0.19) = 0.2565`;
- `V_W^U = (1 − 0.2565)/12 = 0.0619583`;
- `V_W^M = 1/12 = 0.0833333`;
- `Δ_H(μ) = 0.0665 − 0.095μ`.

O problema não é erro numérico. O problema é que os números são escolhidos para colocar a calibração em uma fronteira teórica e gerar uma classificação limpa. Isso deve ser apresentado como exemplo ilustrativo de fronteira, não como calibração substantiva.

---

## 5. Comentários menores e problemas de exposição

1. A expressão “selected Round-1 outcome” deve ser substituída por linguagem que indique seleção sob uma assessment mantida. A palavra “selected” não resolve o problema de equilíbrio.

2. O texto deveria separar claramente três objetos: `t_θ` como threshold terminal, `o_θ` como payoff externo, e `a_θ(ν)` como limiar dinâmico. Em vários pontos, a intuição substantiva mistura esses objetos.

3. A notação `a_0^1` é potencialmente confusa. Ela indica o limiar do tipo baixo quando sua rejeição induz posterior alto, não um limiar do tipo 1. Uma notação como `a_0(1)` seria mais transparente.

4. O paper deveria restringir explicitamente `μ ∈ (0,1)` quando usa argumentos de Bayes com separação. Em `μ = 0` ou `μ = 1`, várias crenças após desvios são fora do caminho de tipos de probabilidade zero.

5. A discussão sobre maioria quando `a_0^M < β/m` é muito curta. Se maioria também pode screenar `H`, o contraste institucional central fica menos limpo. A região complementar deveria ser caracterizada ou o escopo deveria ser reduzido de forma mais agressiva.

6. As figuras são úteis, mas algumas delas fazem mais do que o resultado formal permite. A Figura 4, por exemplo, mostra uma geometria de três candidatos que não é a geometria da calibração principal. Isso precisa ficar mais saliente no texto.

7. A seção de robustez deveria reportar vizinhanças abertas quando existirem. Se não existirem, isso deve ser reconhecido como falta de robustez local da calibração, não como robustez por perturbações unilaterais.

---

## 6. O que seria necessário para uma versão publicável

Para transformar o paper em uma contribuição competitiva, eu exigiria pelo menos cinco mudanças.

1. **Caracterização de equilíbrio.** Fornecer estratégias completas e crenças para todos os histories relevantes. Mostrar existência de PBE/sequential equilibrium para os candidatos e caracterizar multiplicidade ou impor um refinamento defensável.

2. **Reformular a Proposição 2.** Ou provar uma exaustão real do conjunto de equilíbrios, ou rebaixar o resultado para uma seleção sob protocolo comportamental explícito.

3. **Endogeneizar escolha institucional.** Se a pergunta é por que o hegemon escolhe consenso, o jogo deve conter uma etapa de escolha de regra. Caso contrário, o título e a contribuição devem ser reformulados para “preferência condicional do hegemon”.

4. **Substituir a calibração de fronteira.** Apresentar uma calibração interior em que `a_0^1 < a_1` e low-only seja admissível em algum intervalo relevante, ou então abandonar a linguagem de screening como mecanismo calibrado.

5. **Disciplinar a aplicação a OPEC.** Introduzir `ρ < 1` para maioria sem Arábia Saudita, justificar thresholds e outside payoffs por dados ou literatura empírica, e deixar claro que `π_H = 0` é um exercício de isolamento, não uma descrição realista da organização.

---

## 7. Conclusão

A intuição do paper é promissora: consenso pode transformar informação privada de um ator pivotal em poder distributivo, mesmo sem poder formal de agenda. Mas a versão atual não entrega o resultado com a disciplina formal necessária. A parte mais importante do modelo é conduzida por uma assessment específica de crenças; a Proposição 2 não é uma caracterização robusta de PBE; a calibração principal está em uma fronteira que bloqueia separação estrita; e a escolha de consenso pelo hegemon não é endogenizada.

Minha recomendação é **rejeição**. O paper pode se tornar interessante após reconstrução formal, mas, na forma atual, as fragilidades de equilíbrio e calibração seriam obstáculos sérios em AJPS.
