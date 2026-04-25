# Parecer para o editor — Journal of Politics

**Recomendação: rejeitar, com encorajamento para nova submissão após revisão substantiva.**

O paper tem uma ideia teoricamente interessante: unanimidade/consenso pode ser uma tecnologia de poder informacional, não apenas uma restrição ao hegemon. A contribuição potencial é real. A combinação de bargaining legislativo, entrada endógena e Bayesian persuasion é promissora, e o mecanismo de screening sob unanimidade é substantivamente elegante.

Mas, no estado atual, eu não recomendaria R&R no *Journal of Politics*. A razão principal é que a versão ainda não está matematicamente fechada o suficiente para um paper de teoria formal em um generalista de topo. Há problemas de consistência de payoff, lacunas em provas centrais, excesso de afirmações não derivadas e uma conexão empírica com GATT/WTO que parece mais ilustrativa do que realmente disciplinada pelo modelo.

Minha recomendação editorial seria:

> **Reject.** The paper contains a promising and potentially publishable idea, but the formal argument is not yet sufficiently disciplined or transparent for JoP. A substantially revised version could be competitive if the authors clarify the payoff normalization, fully derive the equilibrium objects, replace asserted decompositions by explicit algebra, and narrow or strengthen the substantive claims.

---

# 1. Avaliação geral

O paper está muito melhor do que um manuscrito meramente especulativo. Há um mecanismo identificável:

1. Sob maioria, weak states podem excluir o hegemon.
2. Portanto, a informação privada do hegemon afeta o valor esperado da cooperação, mas não cria problema de screening.
3. Sob unanimidade, weak states precisam comprar o voto do hegemon.
4. Como não observam o tipo, enfrentam um trade-off entre oferta agressiva e conservadora.
5. A mudança de regime gera um salto no payoff do hegemon.
6. Bayesian persuasion explora essa não-concavidade.
7. A comparação institucional vira um trade-off entre vantagem condicional da unanimidade e facilidade de entrada sob maioria.

Esse é um mecanismo bom. O paper tem um núcleo publicável.

O problema é que o paper ainda promete mais do que prova. Ele quer estabelecer uma comparação institucional geral, com resultado de dominância, single-crossing e aplicação substantiva a IOs. Para JoP, isso exige que as provas sejam auditáveis, que os objetos de equilíbrio estejam completamente definidos e que não haja ambiguidade sobre payoffs fora da instituição. No momento, há pontos que um referee de teoria provavelmente exploraria.

---

# 2. Principal problema formal: inconsistência sobre payoff de não entrada

Este é, para mim, o problema mais sério.

No modelo, quando a instituição não se forma, o hegemon recebe seu payoff de desacordo:

\[
\alpha V(\theta).
\]

Isso aparece no timing e também na árvore do jogo. Mas, na seção de entrada e persuasão, o valor reduzido é definido como:

\[
v(\mu,R)=E_\theta[V_H^{R1}(\theta,\mu,R)]
\]

quando weak states entram, e **zero otherwise**.

Isso é uma inconsistência. Se a instituição não se forma, o payoff do hegemon não é zero; é

\[
\alpha V_e(\mu).
\]

Talvez o autor esteja trabalhando com payoffs líquidos em relação ao outside option. Mas isso não está declarado, e várias fórmulas anteriores tratam \(\alpha V(\theta)\) como payoff real, não como baseline subtraído.

Essa inconsistência afeta diretamente:

1. a definição de \(v(\mu,R)\);
2. a concavificação;
3. a prova do Theorem 1;
4. a prova do single-crossing;
5. a interpretação de majority dominance em priors baixos;
6. a inclinação da função de payoff abaixo do threshold de entrada.

Se o payoff fora da instituição é comum aos dois regimes, a comparação entre regras pode sobreviver depois de subtrair o outside option. Mas isso precisa ser feito explicitamente. O paper deveria escolher uma destas duas alternativas:

### Opção A: payoffs absolutos

Então, quando não há entrada,

\[
v(\mu,R)=\alpha V_e(\mu),
\]

independentemente de \(R\). A concavificação precisa ser refeita com esse outside payoff.

### Opção B: payoffs líquidos

Definir desde o início:

\[
\tilde u_H = u_H - \alpha V(\theta),
\]

e trabalhar com ganhos incrementais relativos à alternativa bilateral. Nesse caso, não entrada gera payoff líquido zero. Mas então todas as fórmulas de \(V_H\), \(V_W\), budget identities e interpretações precisam ser consistentes com essa normalização.

No estado atual, o paper mistura as duas coisas. Um referee de teoria provavelmente trataria isso como uma falha estrutural, não como detalhe de exposição.

---

# 3. Provas centrais ainda não estão suficientemente fechadas

## 3.1 Proposition 2: existência e unicidade do cutoff de R1

A prova de unicidade ainda é frágil.

O texto diz, em essência, que \(\Delta_1\) é quadrática, que há sinais opostos nos endpoints e que, portanto, há uma única raiz. Isso não basta em vários trechos.

Por exemplo, no caso \(\alpha \geq \bar\alpha\), o argumento é:

> \(\Delta_1(0)>0\), \(\Delta_1(\mu_s^{R2})\leq 0\); como \(\Delta_1\) é quadrática, há exatamente uma raiz.

Isso prova existência, mas não unicidade. Uma quadrática pode ter duas raízes no intervalo, dependendo da curvatura e do vértice. Para provar unicidade, é preciso mostrar algo como:

\[
\Delta_1'(\mu)<0
\]

no intervalo relevante, ou então localizar explicitamente as duas raízes e mostrar que apenas uma pertence ao domínio relevante.

O mesmo problema aparece na discussão do ramo high-R2. A fórmula fechada da raiz é útil, mas o paper precisa provar:

1. que o discriminante é positivo;
2. que a raiz menor está no intervalo relevante;
3. que a raiz maior está fora do intervalo relevante, ou não é estrategicamente admissível;
4. que não há raiz adicional no ramo low-R2.

Do jeito atual, a prova usa intuições gráficas e sinais de endpoint, mas não fecha a unicidade analiticamente.

---

## 3.2 Lemma 1: a decomposição é afirmada, não derivada

O Lemma 1 é o coração do paper:

\[
\alpha < \alpha^*(N,\beta)
\quad \Longleftrightarrow \quad
E[V_H(\mu,U)]>E[V_H(\mu,M)]
\quad \forall \mu\in(0,1].
\]

Esse resultado é muito forte e muito importante. A prova deveria ser totalmente transparente.

Mas o passo central é a decomposição:

\[
D(\mu)
=
D_{\text{base}}(\mu)
+
\mathbf{1}\{\mu<\mu_s^{R2}\}\delta_{R2}(\mu)
+
\mathbf{1}\{\mu>\mu_s^{R1}\}\delta_{R1}(\mu).
\]

Essa decomposição é plausível, mas no texto ela é mais afirmada do que demonstrada. Para um paper no JoP, especialmente com uma proposição “if and only if”, isso não basta. O apêndice deveria derivar \(E[V_H^{R1}(\mu,U)]\) ramo por ramo e então mostrar, por subtração direta de \(E[V_H^{R1}(\mu,M)]\), que a decomposição segue.

O referee precisa conseguir auditar:

1. ramo agressivo R1 + agressivo R2;
2. ramo agressivo R1 + conservador R2;
3. ramo conservador R1 + agressivo R2;
4. ramo conservador R1 + conservador R2.

Hoje o paper diz que as correções são independentes porque afetam componentes diferentes do payoff. Isso é uma intuição correta, mas não é uma prova suficiente.

---

## 3.3 Theorem 1 depende da normalização de payoff

A prova do Theorem 1 usa a estrutura:

\[
v(\mu,M)=0
\]

fora da região de entrada e

\[
v(\mu,M)=\lambda_M[1+(r-1)\mu]
\]

dentro da região de entrada.

Mas, como mencionado, se o hegemon recebe \(\alpha V(\theta)\) quando a instituição não se forma, essa função de valor está errada em payoffs absolutos. Isso compromete a prova de que a concavificação sob maioria não melhora o payoff em \(p\in E_M\).

O resultado pode ser recuperável com payoffs líquidos. Mas precisa ser reescrito de forma explícita.

---

## 3.4 Theorem 2: single-crossing ainda está topologicamente incompleto

A prova do single-crossing é engenhosa, mas ainda não está completamente fechada.

O paper define:

\[
a=\inf E_U.
\]

Depois afirma que, para \(p\geq a\), se \(p\notin E_U\), então \(p\) está em um gap \((b,d)\) de \(E_U\) com \(b,d\in E_U\).

Isso exige uma caracterização topológica do conjunto \(E_U\). Mas \(E_U\) pode ser desconexo e a função \(V_W^{R1}(\mu,U)\) tem descontinuidades nos cutoffs de screening. O paper precisa provar que os gaps são de fato intervalos com endpoints pertencentes a \(E_U\), ou então ajustar o argumento para lidar com endpoints de fechamento.

Também falta tratar explicitamente casos degenerados:

1. \(E_U=\emptyset\);
2. \(E_U=(0,1]\);
3. \(a=0\);
4. \(a=1\);
5. pontos de descontinuidade exatamente no cutoff;
6. igualdade no entry constraint.

Esses casos podem parecer menores, mas em teoria formal eles importam, especialmente quando o resultado é uma propriedade global de single-crossing.

---

# 4. Problemas de exposição formal

O paper tem boa intuição, mas a exposição formal ainda não segue completamente o padrão de um paper de teoria formal de alto nível.

## 4.1 Muitas provas importantes são “See Appendix”

Isso é aceitável, mas o corpo do texto precisa dar mais estrutura. O leitor deveria entender quais são os objetos exatos antes de aceitar os resultados.

Por exemplo, em majority rule, o paper diz que o payoff é afim, mas a fórmula exata de \(\lambda_M\) só aparece depois. Seria melhor apresentar no corpo:

\[
E[V_H^{R1}(\mu,M)] = \lambda_M V_e(\mu),
\]

com \(\lambda_M\) definido imediatamente.

Da mesma forma, sob unanimidade, seria útil apresentar uma tabela com os quatro regimes relevantes:

| R1 regime | R2 regime | condition | \(E[V_H]\) | \(V_W\) |
|---|---|---|---|---|

Isso reduziria muito a carga cognitiva e tornaria as provas mais auditáveis.

---

## 4.2 O paper depende demais de figuras numéricas para convencer

As figuras são úteis, mas o paper deve evitar qualquer impressão de que os resultados principais dependem de código ou simulação.

A seção numérica deveria ser claramente secundária. Além disso, o arquivo chama:

```r id="6lbtcp"
source("scripts/model_functions.R", local = TRUE)
```

Para fins de replicabilidade, isso é problemático se o script não estiver incluído e documentado. Em um paper formal, isso não é fatal para a teoria, mas enfraquece a apresentação das figuras.

---

## 4.3 A robustez com \(K>2\) tipos é muito superficial

O Appendix C é apresentado como robustez, mas é basicamente um proof sketch. Isso não deveria aparecer como se fosse um resultado formal completo.

Há duas opções:

1. remover o apêndice \(K>2\), ou
2. rebaixá-lo explicitamente para “discussion of extension”, sem aparência de proposição formal.

Do jeito atual, ele cria uma vulnerabilidade desnecessária.

---

# 5. Problemas substantivos e de framing

## 5.1 O paper ainda promete mais do que entrega sobre GATT/WTO

A seção GATT/WTO é interessante, mas não está suficientemente integrada ao modelo.

O paper diz que o modelo ajuda a entender o consenso no GATT/WTO. Mas a aplicação empírica parece ambígua. Em alguns momentos, o texto sugere que consenso é uma adaptação que se tornou mais atraente à medida que a organização se expandiu e a assimetria informacional cresceu. Mas o GATT/WTO já tinha normas de consenso desde cedo. Então o timing histórico precisa ser cuidadosamente alinhado.

O paper não precisa testar empiricamente o modelo, mas precisa evitar que a aplicação pareça selecionada ex post.

Eu recomendaria apresentar GATT/WTO como **motivating illustration**, não como evidência. O texto deve dizer claramente:

> The purpose is not to test the model, but to show how the mechanism can reinterpret a familiar institutional arrangement.

---

## 5.2 “Most international organizations operate by consensus” precisa ser qualificado

A frase de abertura é forte. Para um referee, ela levanta imediatamente perguntas:

1. “Most” em qual universo de IOs?
2. Consenso em decisões substantivas, orçamento, membership, dispute settlement ou agenda-setting?
3. Consenso formal ou informal?
4. IOs universais ou regionais?
5. IOs econômicas, ambientais, segurança, direitos humanos?

O argumento não precisa cobrir todas as IOs. Mas a motivação deve ser calibrada. Talvez melhor:

> Many prominent international organizations rely on consensus or unanimity for consequential decisions, including cases in which powerful states played central roles in institutional design.

Isso reduz o risco de o paper ser atacado por uma generalização empírica periférica.

---

## 5.3 A escolha institucional pelo hegemon é forte demais

O modelo assume que o hegemon escolhe unilateralmente a regra \(R\). Isso é uma simplificação útil, mas substantivamente pesada.

Em IOs, regras constitucionais são frequentemente escolhidas por negociação. O hegemon pode ter influência desproporcional, mas raramente escolhe sozinho. O paper deveria justificar isso como uma forma reduzida:

> The hegemon’s choice represents institutional designs that are feasible given its bargaining leverage at the founding stage.

Ou então deve reinterpretar \(R\) não como escolha unilateral literal, mas como a regra que o hegemon prefere e tenta implementa.

Sem essa qualificação, um referee pode dizer que o paper resolve o puzzle assumindo justamente o poder institucional que deveria explicar.

---

# 6. O que está forte

Apesar das críticas, há elementos muito bons.

## 6.1 O mecanismo de screening é substantivamente novo

A distinção entre maioria e unanimidade está bem colocada. Sob maioria, o hegemon pode ser excluído; sob unanimidade, ele é pivotal. Isso transforma informação privada em renda de screening. Essa é a melhor parte do paper.

## 6.2 O exemplo de três jogadores ajuda muito

A seção de exemplo é uma adição excelente. Ela mostra o mecanismo sem o aparato completo. Eu manteria essa seção.

Mas ela deve ser revisada para garantir consistência com a normalização de payoffs. Se o exemplo usa payoff absoluto, o modelo geral não pode depois usar zero como payoff fora da instituição sem explicação.

## 6.3 A intuição sobre entry margin é boa

A ideia de que maioria pode dominar não porque dá payoff condicional maior ao hegemon, mas porque facilita entrada, é substantivamente forte. Essa distinção entre “bargaining advantage” e “participation advantage” deveria ser ainda mais enfatizada.

---

# 7. Recomendação ao autor

Eu não enviaria esta versão ao JoP ainda.

A ordem de revisão deveria ser:

1. **Resolver a normalização de payoffs.**  
   Decidir se o paper trabalha com payoffs absolutos ou líquidos. Reescrever a seção de BP e entry de acordo.

2. **Derivar explicitamente os payoffs de R1 sob maioria e unanimidade.**  
   Colocar fórmulas completas em uma tabela ou proposição auxiliar.

3. **Refazer a prova da unicidade dos cutoffs.**  
   Não usar apenas sinais nos endpoints. Provar monotonicidade ou localizar raízes.

4. **Transformar a decomposição do Lemma 1 em derivação algébrica completa.**  
   O referee precisa ver de onde vêm \(D_{\text{base}}\), \(\delta_{R2}\) e \(\delta_{R1}\).

5. **Revisar Theorem 1 e Theorem 2 depois da normalização.**  
   Especialmente a concavificação e a estrutura dos conjuntos de entrada.

6. **Rebaixar ou remover o apêndice \(K>2\).**  
   Ele ainda não está no mesmo nível de rigor que o resto.

7. **Enfraquecer a aplicação GATT/WTO.**  
   Tratar como ilustração motivadora, não como evidência.

---

# 8. Recomendação final

**Minha recomendação ao editor do JoP seria: Reject.**

Mas não é uma rejeição porque a ideia é fraca. É o contrário: a ideia é boa o suficiente para merecer uma versão formalmente mais limpa. No estado atual, porém, o paper ainda tem vulnerabilidades que um referee de teoria formal identificaria rapidamente.

A formulação mais justa seria:

> This is a promising paper with a potentially important mechanism, but the current version is not yet ready for publication in JoP. The core insight is valuable, but the formal apparatus does not yet meet the standard required for a top general-interest political science journal. The paper should be substantially revised and resubmitted only after the payoff normalization, cutoff proofs, conditional dominance lemma, and concavification arguments are made fully explicit.
