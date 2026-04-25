# Parecer JoP — Referee Report (recebido 2026-04-25)

**Recomendação: Reject** (with encouragement to resubmit a substantially revised version)

---

## 1. Avaliação geral

O paper promete explicar por que um hegemon escolheria consenso em vez de maioria. A tese central é forte: consenso não é apenas constraint; pode ser tecnologia de poder informacional. Isso é interessante e merece desenvolvimento.

O problema é que o resultado formal principal é mais estreito do que a promessa. O manuscrito acaba mostrando algo como:

> se a instituição já é viável sob unanimidade, e se o parâmetro de outside option do hegemon é suficientemente baixo, então unanimidade dá maior payoff condicional ao hegemon; maioria só pode vencer via margem de entrada.

Isso é um resultado coerente, mas não plenamente satisfatório como explicação geral de escolha institucional. A contribuição prometida é sobre institutional design; o resultado provado é sobretudo uma comparação condicional de payoffs em um ambiente bastante parametrizado.

Além disso, partes importantes da prova ainda dependem de regimes não formalizados ou de argumentos que são insuficientes para um leitor de teoria formal.

## 2. Pontos fortes

### 2.1. A intuição central é boa

O mecanismo é claro:
- sob maioria, weak states podem excluir o hegemon;
- logo, a informação privada do hegemon afeta o tamanho esperado do surplus, mas não cria um problema de screening;
- sob unanimidade, o hegemon precisa ser comprado;
- weak states não sabem se devem oferecer pouco ou muito;
- isso cria um cutoff de screening;
- no cutoff, há um salto no payoff do hegemon;
- Bayesian persuasion explora essa não-concavidade.

Esse é um mecanismo formalmente interessante.

### 2.2. O exemplo inicial funciona bem

A seção "Motivating Example" é uma das melhores partes do paper. Ela mostra o mecanismo sem a maquinaria do modelo geral. Para leitores do JOP, isso é importante: formal models com intuição institucional precisam de uma entrada simples.

Eu manteria esse exemplo, mas o revisaria para deixar explícito que ele é um ambiente simplificado, não uma versão especial completa do modelo de dois rounds.

### 2.3. A arquitetura "majority = linear / unanimity = jump" é potencialmente elegante

A distinção entre linearidade sob maioria e não-concavidade sob unanimidade é a contribuição formal mais promissora. Se o paper conseguir reduzir o resultado principal a essa diferença estrutural, ele fica muito mais forte.

## 3. Problemas principais

### 3.1. O resultado principal é menos geral do que a introdução promete

A introdução pergunta: *Why would a hegemon prefer consensus to majority rule?*

Mas o resultado principal é condicionado por várias restrições:
- α < α*(N,β);
- entrada viável sob unanimidade;
- em parte do argumento, monotonicidade do entry set;
- em partes da derivação, um "principal regime" para os cutoffs;
- no Theorem 2, uma estrutura específica de concavificação e entry threshold.

Isso não invalida o paper. Mas a escrita precisa ser mais honesta: o modelo não mostra que hegemons geralmente preferem consenso; mostra que consenso pode dominar maioria quando a informação privada é suficientemente valiosa e quando a margem de entrada não é proibitiva.

A versão atual ainda vende demais a contribuição.

Eu mudaria a formulação central para algo mais próximo de:

> The model identifies conditions under which unanimity can dominate majority rule for a hegemon because unanimity converts private information into screening rents. Majority may still dominate when its lower entry barrier is decisive or when the hegemon's outside option is sufficiently strong.

### 3.2. O "principal regime" não está incorporado corretamente aos teoremas

A Proposition sobre o cutoff de R1 afirma um closed form:

μ_s^{R1} = [φ − sqrt(φ² − 4(N−2))] / [2(N−2)]

Mas o próprio apêndice diz que isso vale no "principal regime" e que esse regime ocorre quando uma condição envolvendo α é satisfeita. O problema: essa condição não aparece de maneira formal no enunciado principal.

O texto diz que o regime "holds throughout the empirically relevant parameter range". Isso não é aceitável como prova para teoria formal. Um referee do JOP vai exigir uma de três coisas:
- colocar a condição exata no enunciado;
- provar que ela é implicada por hipóteses já assumidas, como α < α*(N,β);
- reescrever o resultado para cobrir todos os regimes.

Do jeito atual, o teorema usa uma expressão fechada que não está garantida em todo o domínio declarado.

**Esse é um problema sério.**

### 3.3. A prova do Lemma 1 ainda parece frágil

O Lemma 1 é o coração matemático do paper. Ele afirma uma condição bicondicional:

α < α*(N,β) ⇔ E[V_H(μ,U)] > E[V_H(μ,M)] para todo μ ∈ (0,1].

A estratégia da prova é boa: decompor a diferença em termos afins e checar endpoints. Mas a implementação ainda está muito comprimida para sustentar um resultado tão importante.

O trecho mais problemático é o tratamento do caso alternativo:

> If instead μ_s^{R1} < μ_s^{R2}, one intermediate region carries both corrections; since ... the same endpoint argument establishes positivity.

Isso é insuficiente. Para um resultado bicondicional sharp, não basta dizer que "the same endpoint argument" funciona. É preciso mostrar explicitamente:
- quais são os intervalos;
- qual expressão vale em cada intervalo;
- quais endpoints são usados;
- quais correções são positivas, negativas ou nulas em cada fronteira;
- por que o endpoint mais apertado continua sendo μ=1.

Esse ponto provavelmente geraria uma objeção de referee.

Além disso, o uso de indicadores com desigualdades estritas — μ < μ_s^{R2} e μ > μ_s^{R1} — precisa de tie-breaking explícito nos cutoffs. Como o argumento explora jumps, o valor exatamente no cutoff não é detalhe cosmético. Pode ser medida zero para integrais, mas não é irrelevante para enunciados ponto a ponto, concavificação e definição de envelope.

### 3.4. O Theorem 1 é correto em espírito, mas parece menos profundo do que o paper sugere

Theorem 1 diz: p ∈ E_U ⇒ Π_H*(U,p) > Π_H*(M,p).

A prova usa:
- Lemma 1: payoff condicional sob unanimidade é maior;
- E_U ⊆ E_M;
- majority é linear acima do entry threshold;
- logo persuasion não melhora maioria quando p ∈ E_M;
- concavification sob unanimidade não pode piorar o payoff.

Isso é limpo, mas observe: uma vez que Lemma 1 está estabelecido, Theorem 1 quase não usa o screening jump. O screening jump é usado indiretamente para motivar o Lemma e a concavificação sob unanimidade, mas a prova do teorema principal depende mais de conditional dominance do que de persuasion.

Isso cria um **desalinhamento retórico**. O paper promete que Bayesian persuasion e o jump são centrais; o principal theorem acaba descansando principalmente sobre uma comparação condicional de continuation values.

Eu recomendaria reorganizar os resultados:
- Proposition 1: Majority payoff is affine.
- Proposition 2: Unanimity creates a screening jump.
- Proposition 3: The jump creates a persuasion gain for priors below the cutoff.
- Lemma 1: Conditional dominance under α < α*.
- Theorem 1: Institutional comparison with entry.

Assim o leitor vê melhor onde o mecanismo de informação realmente faz trabalho.

### 3.5. A entrada dos weak states está subespecificada

O modelo diz que weak states simultaneously decide whether to enter. Mas não está suficientemente claro o que acontece se apenas alguns entram.

Questões:
- A instituição forma se todos os N−1 weak states entram?
- Forma se pelo menos uma coalizão mínima entra?
- O número de membros é fixo após entrada?
- O hegemon participa automaticamente?
- A regra de unanimidade se aplica aos entrantes ou ao universo potencial?
- Há múltiplos equilíbrios na entrada simultânea?
- Weak states têm payoff idêntico ex ante, mas e se um deles não entra enquanto outros entram?

A análise trata a entrada como uma condição representativa: V_W^{R1}(μ,R) ≥ c.

Isso é aceitável como forma reduzida, mas precisa ser declarado como tal. Caso contrário, o entry game está incompleto.

Para um artigo de teoria formal, eu sugeriria substituir a entrada simultânea por uma regra mais simples:

> A representative weak state, or equivalently all symmetric weak states, enter iff their expected equilibrium payoff weakly exceeds c; if the condition fails, the institution does not form.

Ou então modelar explicitamente entrada coletiva.

### 3.6. A aplicação GATT/WTO ainda está subteorizada

A aplicação ao GATT/WTO é plausível, mas ainda parece ilustrativa demais. O paper diz que consenso emerge quando informational asymmetry aumenta e entry costs deixam de ser dominantes. Mas isso precisa virar implicações observáveis mais claras.

Por exemplo, o modelo deveria gerar algo como:
- consenso deve ser mais provável quando o hegemon tem vantagem informacional sobre o valor da cooperação;
- consenso deve ser mais provável quando weak states precisam do hegemon como participante pivotal;
- maioria deve ser mais provável quando o principal problema é induzir entrada;
- hegemonic use of consensus should be associated with agenda preparation, technical drafting, controlled disclosure, and staged information release;
- o mecanismo deve ser fraco quando o valor da cooperação é common knowledge.

Sem isso, a seção empírica parece uma aplicação plausível, mas não disciplinada pelo modelo.

## 4. Problemas de exposição

### 4.1. O paper ainda usa linguagem forte demais

Expressões como "technology of hegemonic power" são boas, mas o texto precisa evitar a impressão de que consenso sempre favorece o hegemon. O próprio modelo mostra que maioria pode dominar em priors pessimistas ou quando α é alto.

A contribuição deve ser formulada como condicional.

### 4.2. A notação é pesada

O paper tem muitos objetos: μ_s^{R1}, μ_s^{R2}, τ(M), τ(U), α*, S_U, S_M, λ_M, κ_M, C_buy, C_out.

Isso é administrável, mas o corpo principal deve conter menos álgebra e mais estrutura. Eu colocaria no texto principal apenas:
- majority linearity;
- unanimity cutoff;
- jump;
- conditional dominance;
- entry trade-off.

O resto deveria ir para o apêndice.

### 4.3. Algumas afirmações precisam de cuidado terminológico

O paper usa "consensus" e "unanimity" quase como equivalentes. Há uma nota dizendo que WTO consensus is not formal unanimity, mas o ponto precisa aparecer antes e com mais força. Para IOs, consenso como "not objecting" não é exatamente unanimidade formal. A tradução institucional do modelo precisa ser mais cuidadosa.

## 5. Avaliação dos teoremas

**Lemma 1**: Promissor, mas ainda não aceitaria sem revisão. A condição α* é interessante e potencialmente sharp. Porém a prova precisa ser mais explícita, especialmente no regime μ_s^{R1} < μ_s^{R2} e nas fronteiras dos cutoffs.

**Theorem 1**: Provavelmente correto se Lemma 1 estiver correto. Mas substantivamente depende muito do Lemma 1. Não é, por si só, uma demonstração forte do mecanismo de persuasion; é mais uma consequência da conditional dominance.

**Theorem 2**: Útil, mas menos central. A single-crossing property é boa, mas depende de Assumption 1 sobre monotone entry. Essa assunção é substantiva e precisa ser mais bem justificada ou movida para uma seção de extensão. O resultado principal do paper não deveria depender muito dela.

## 6. Recomendação substantiva ao autor

Eu sugeriria uma revisão estrutural profunda:
- Rebaixar a promessa geral. O paper não deve dizer que explica por que hegemons preferem consenso em geral. Deve dizer que identifica um mecanismo pelo qual unanimidade pode dominar maioria.
- Formalizar todos os regimes. Não use "principal regime" sem hipótese explícita.
- Fortalecer o Lemma 1. Esse é o ponto em que o paper vive ou morre.
- Separar claramente três resultados: screening jump; persuasion gain; institutional choice with entry.
- Clarificar o entry game. Ou modelar entrada explicitamente, ou assumir uma regra reduzida.
- Transformar a aplicação WTO em implicações observáveis. Do contrário, ela parece motivação, não evidência ou disciplina teórica.

## 7. Veredito

Eu rejeitaria no JOP nesta rodada.

A razão não é falta de potencial. O mecanismo é interessante e pode virar um bom artigo. Mas, para um journal generalista de alto nível, o paper ainda apresenta três problemas simultâneos:
- matemática ainda não completamente limpa;
- promessa teórica mais ampla que o resultado formal;
- microfundação da entrada e escopo institucional ainda subespecificados.

> Reject. The paper develops a potentially valuable formal mechanism linking unanimity, screening, and Bayesian persuasion, but the current manuscript is not yet ready for publication. The main result is narrower than advertised, the proof architecture relies on incompletely specified parameter regimes, and the entry stage is under-modeled. I would encourage the author to substantially revise and resubmit elsewhere or as a new submission after tightening the formal results and reframing the contribution more conditionally.
