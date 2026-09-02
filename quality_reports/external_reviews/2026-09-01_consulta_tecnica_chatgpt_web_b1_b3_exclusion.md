# Consulta técnica externa não formal — B.1/B.3 e regra de exclusão

## 1. Boundary e método

Esta consulta examina exclusivamente se a regra segundo a qual a alocação de acordo de \(H\) e sua outside option são mutuamente exclusivas foi corretamente propagada às provas B.1 e B.3, e se a alegação restrita de invariância dos resultados downstream é sustentável. Não avalio a comparação institucional entre maioria e unanimidade, o conceito de solução, a regra *as-if-pivotal*, a estrutura de crenças, a unidade da pie ou extensões do modelo.

A reconstrução foi feita sem tomar como dadas as revisões internas. Para tentar refutar o candidato, considerei separadamente:

1. propostas majoritárias nas quais os votos fracos já satisfazem a quota;
2. propostas nas quais \(H\) é exatamente pivotal;
3. propostas que fracassam mesmo com o voto de \(H\);
4. mudanças de voto de \(H\) induzidas pelo desvio \(x_H\mapsto0\);
5. possíveis efeitos desse desvio sobre votos fracos, posterior, quota e payoff do proponente;
6. os casos-limite \(m=3\), \(p\in\{0,1\}\), \(\ell=1/m\), \(h=1/m\), os dois cutoffs e todos os empates de propostas.

A verificação dos cutoffs abaixo é algébrica. Eventuais checagens numéricas foram usadas apenas como diagnóstico e não fundamentam o veredicto.

## 2. Veredicto executivo

**REPAIR — 0 CRITICAL / 0 IMPORTANT / 4 MINOR.**

A conclusão substantiva central está correta:

- numa proposta que passa com pelo menos \(k\) votos fracos, todo \(x_H>0\) é estritamente dominado, para o proponente, pela transferência integral dessa parcela à sua própria alocação;
- por isso, a proposta ótima de exclusão continua tendo \(x_H=0\);
- o limiar de \(H\) quando pivotal continua sendo \(\beta o\);
- \(\Pi_E\), \(\Pi_S\), \(\Pi_P\), o payoff de delay, os cutoffs, os knife edges, os vetores de B.5 e as subtrações de B.6 permanecem inalterados;
- muda a estratégia de \(H\) em propostas não pivotais fora do caminho com \(x_H>0\), mas não a correspondência reportada de resultados ótimos.

Não encontrei contraexemplo às proposições reportadas. Contudo, os bytes candidatos não merecem `PASS 0/0/0`: há uma hipótese usada mas não declarada no lema, uma desigualdade de contagem incorreta no texto vigente e dois pontos de integração textual que devem ser ajustados antes da migração.

## 3. Reconstrução independente

### 3.1 Factibilidade e ganho do desvio

Considere uma proposta factível \(x\) que recebe pelo menos \(k\) votos de respondedores fracos, além do voto automático do proponente. Defina

\[
x'_H=0,\qquad x'_i=x_i+x_H,\qquad x'_j=x_j\quad(j\neq i,H).
\]

A factibilidade é imediata:

\[
x'_H+\sum_{j\in W}x'_j
=0+(x_i+x_H)+\sum_{j\neq i}x_j
=x_H+\sum_{j\in W}x_j\leq1.
\]

Não há cap individual sobre \(x_i\), e todas as alocações permanecem não negativas.

O ponto que precisa ser explicitamente invocado é que, nos dois ambientes majoritários em que o lema é utilizado, a resposta de cada Estado fraco é independente de \(x_H\) e de \(x_i\):

- na maioria terminal, o valor de desacordo do respondedor fraco é zero, de modo que ele vota sim para toda \(x_j\geq0\);
- na maioria de Round 1, a continuação terminal-majoritária de qualquer Estado fraco é \(1/m\), independentemente da posterior e do voto de \(H\); portanto ele vota sim exatamente quando \(x_j\geq w=\beta/m\).

Como o desvio não altera nenhum \(x_j\) de respondedor, não altera nenhum voto fraco. Se o voto de \(H\) mudar, a aprovação tampouco muda, pois os \(k\) votos fracos já bastam.

Para qualquer tipo de \(H\), sob \(x\) o proponente recebe \(x_i\), quer \(H\) vote sim, quer vote não. Sob \(x'\), recebe \(x_i+x_H\). Portanto o ganho é exatamente \(x_H>0\), estado por estado e não apenas em esperança. O desvio é feito no estágio da proposta e não condiciona a transferência a votos observados; logo não viola a simultaneidade do ballot.

### 3.2 Contagem da quota

Há \(m-1\) respondedores fracos, pois um dos \(m\) Estados fracos é o proponente. Para passar sem \(H\), é preciso que

\[
k=\left\lfloor\frac{m+1}{2}\right\rfloor\leq m-1.
\]

Isso é verdadeiro para todo \(m\geq3\). Essa, e não apenas \(k\leq m\), é a desigualdade que demonstra a disponibilidade de votos fracos suficientes.

Também vale \(k+1\leq m\), o que será usado para provar

\[
1-\frac{\beta(k+1)}m>0.
\]

### 3.3 B.1: benchmark público

#### Maioria terminal

Cada respondedor fraco aceita zero. Como \(k\leq m-1\), a proposta passa sem \(H\). Numa proposta não pivotal, o tipo público \(o\) compara

\[
u_H(Y)=x_H,\qquad u_H(N)=o.
\]

Logo vota sim se e somente se \(x_H\geq o\), com sim na igualdade. Essa é a correção da estratégia fora do caminho.

Pelo desvio acima, porém, todo \(x_H>0\) é estritamente subótimo. Pagamentos positivos a respondedores fracos também podem ser reduzidos a zero sem perder votos. Assim, a escolha ótima é

\[
x_H=0,\qquad x_j=0\ \text{para todo respondedor fraco},\qquad x_i=1.
\]

Como \(o>0\), \(H\) vota estritamente não e recebe somente \(o\). O resultado terminal-majoritário reportado permanece correto.

#### Unanimidade terminal

Aqui \(H\) é pivotal. A ação \(Y\) implementa \(x_H\); a ação \(N\) conduz ao desacordo terminal \(o\). Portanto \(H\) aceita exatamente quando \(x_H\geq o\), e o proponente escolhe \(x_H=o\). A exclusão por uma coalizão majoritária não existe sob unanimidade, de modo que esse ramo não é alterado.

#### Round 1

Sob maioria, o preço de um voto fraco é \(w=\beta/m\). As alternativas relevantes são:

\[
C_I=(k-1)w+\beta o
\]

para inclusão, e

\[
C_E=kw
\]

para exclusão. Quando \(H\) é pivotal, a ação \(N\) leva ao Round 2 e produz continuação \(\beta o\); quando \(k\) votos fracos já bastam, a ação \(N\) de \(H\) produz \(o\) imediatamente e o desvio força \(x_H=0\).

Assim,

\[
C_I\leq C_E
\iff (k-1)\frac\beta m+\beta o\leq k\frac\beta m
\iff o\leq\frac1m.
\]

Em \(o=1/m\), o proponente empata. Inclusão dá a \(H\) \(\beta o\), enquanto exclusão dá \(o\). Como \(0<\beta<1\) e \(o>0\), o desempate seleciona inclusão. O cutoff e os payoffs públicos não mudam.

### 3.4 B.3: os três casos de \(n_Y\)

Um respondedor fraco vota sim exatamente quando \(x_j\geq w\). Seja \(n_Y\) o número desses respondedores.

#### Caso 1: \(n_Y\geq k\)

A proposta passa qualquer que seja o voto de \(H\). Para o tipo \(o\),

\[
u_H(Y)=x_H,\qquad u_H(N)=o.
\]

Logo \(H\) vota sim se e somente se \(x_H\geq o\). Entretanto, todo \(x_H>0\) é estritamente dominado pelo desvio ao proponente. A proposta ótima dessa classe tem \(x_H=0\), paga \(w\) a exatamente \(k\) respondedores e dá ao proponente

\[
\Pi_E=1-kw.
\]

Ambos os tipos de \(H\) votam estritamente não e recebem \((\ell,h)\).

#### Caso 2: \(n_Y=k-1\)

\(H\) é pivotal. A ação \(Y\) faz a proposta passar e paga \(x_H\); a ação \(N\) faz a proposta fracassar em Round 1 e leva à maioria terminal, que entrega \(o\) a \(H\) independentemente da crença. Em unidades de Round 1,

\[
u_H(Y)=x_H,\qquad u_H(N)=\beta o.
\]

Portanto o limiar é \(x_H\geq\beta o\). As duas classes não dominadas são:

- screening: \(x_H=\beta\ell\), com aceitação do tipo baixo e rejeição do alto;
- pooling: \(x_H=\beta h\), com aceitação de ambos.

#### Caso 3: \(n_Y\leq k-2\)

Mesmo com o sim de \(H\), há no máximo \(k-1\) votos adicionais. A proposta fracassa após qualquer ação de \(H\). Embora os votos possam gerar posteriors distintos, a continuação terminal-majoritária de um tipo \(o\) é \(\beta o\) em ambos os casos. \(H\) é indiferente e a convenção seleciona sim.

Esse ramo completa a estratégia fora do caminho. Não cria nova classe de resultado porque a proposta fracassa sob ambas as ações.

### 3.5 Redução aos quatro candidatos

As quatro alternativas relevantes são

\[
\Pi_E=1-kw,
\]

\[
\Pi_S(p)=(1-p)\left[1-(k-1)w-\beta\ell\right]+pw,
\]

\[
\Pi_P=1-(k-1)w-\beta h,
\]

\[
\Pi_D=w.
\]

A expressão de screening é correta: quando o tipo é baixo, há acordo e o proponente fica com o resíduo; quando o tipo é alto, a proposta fracassa e o proponente tem continuação \(w=\beta/m\).

Delay é estritamente dominado por exclusão:

\[
\Pi_E-\Pi_D
=1-\frac{\beta(k+1)}m>0,
\]

pois \(k+1\leq m\) e \(\beta<1\).

As diferenças decisivas são

\[
\Pi_P-\Pi_E=\beta\left(\frac1m-h\right),
\]

\[
\Pi_S(p)-\Pi_E
=(1-p)\beta\left(\frac1m-\ell\right)
-p\left[1-\frac{\beta(k+1)}m\right],
\]

e, para a comparação direta entre screening e pooling,

\[
\Pi_S(p)-\Pi_P
=(1-p)\beta(h-\ell)
-p\left[1-\beta h-\frac{\beta k}{m}\right].
\]

Da segunda igualdade segue

\[
p_{S=E}
=\frac{\beta(1/m-\ell)}
{\beta(1/m-\ell)+1-\beta(k+1)/m},
\]

quando \(\ell<1/m\). Da terceira segue

\[
p_{S=P}
=\frac{\beta(h-\ell)}
{1-\beta\ell-\beta k/m},
\]

quando \(h<1/m\). Os denominadores são estritamente positivos nas regiões em que os cutoffs são utilizados.

A factibilidade também está preservada. Exclusão custa \(kw<1\). Se screening pode vencer exclusão, necessariamente \(\ell\leq1/m\), e então

\[
(k-1)w+\beta\ell\leq kw<1.
\]

Se pooling pode vencer exclusão, necessariamente \(h\leq1/m\), e analogamente seu custo não excede \(kw\).

### 3.6 Desempates e knife edges

Defina

\[
q(p)=(1-p)\ell+ph.
\]

Os payoffs esperados de \(H\) são

\[
U_H^S=\beta q(p),\qquad U_H^E=q(p),\qquad U_H^P=\beta h.
\]

Assim:

- num empate \(S=E\), screening dá payoff estritamente menor a \(H\), pois \(\beta q<q\);
- num empate \(S=P\), screening dá payoff estritamente menor, pois o cutoff ocorre com \(p<1\) e, portanto, \(q<h\);
- se \(h=1/m\), exclusão e pooling dão sempre o mesmo payoff ao proponente; o desempate escolhe exclusão quando \(q<\beta h\), pooling quando \(q>\beta h\), e permite qualquer mistura entre as duas propostas puras quando \(q=\beta h\).

Nenhum \(x_H>0\) não pivotal entra nessa multiplicidade, porque continua estritamente dominado. Logo os cinco casos, os cutoffs, o segmento residual e a multiplicidade por identidade dos respondedores permanecem como reportados.

## 4. Findings

### Finding M1 — o lema omite uma premissa necessária para preservar os votos fracos

- **Severidade:** MINOR.
- **Localizador:** memorando candidato, Seção 4, especialmente o passo “as alocações e os votos dos respondedores fracos não mudam” e a afirmação final de que o lema usa “apenas” não negatividade, restrição agregada e especificidade de \(x_H\).
- **Evidência:** manter \(x_j\) fixo não preserva, em geral, a ação de um jogador cuja estratégia pode depender do pacote inteiro. Aqui a conclusão é verdadeira somente porque a disciplina de voto e as continuações majoritárias implicam um limiar fraco independente de \(x_H\): zero no terminal e \(w=\beta/m\) em Round 1.
- **Efeito downstream:** nenhum. A premissa faltante vale no modelo, de modo que o desvio e todas as fórmulas sobrevivem.
- **Correção mínima:** inserir antes do passo de preservação dos votos: “In the terminal-majority and Round-1-majority applications below, a weak responder’s ballot depends only on whether its own allocation reaches, respectively, zero or \(w=\beta/m\); these thresholds are independent of \(x_H\), \(x_i\), \(H\)’s vote, and the posterior.” Alterar a frase final para reconhecer também essa propriedade.

### Finding M2 — a desigualdade \(k\leq m\) não demonstra que a maioria pode excluir \(H\)

- **Severidade:** MINOR.
- **Localizador:** B.1 vigente, abertura da maioria terminal.
- **Evidência:** há apenas \(m-1\) respondedores fracos, pois o proponente é um dos \(m\) Estados fracos. A condição necessária é \(k\leq m-1\), verdadeira para \(m\geq3\). A desigualdade \(k\leq m\) permitiria, por si só, contar \(H\) entre os \(k\) votos adicionais e não prova passagem sem ele.
- **Efeito downstream:** nenhum; a desigualdade correta vale em todo o domínio do modelo.
- **Correção mínima:** substituir por “Since there are \(m-1\) weak responders and \(k=\lfloor(m+1)/2\rfloor\leq m-1\) for \(m\geq3\), the weak-state votes can pass without \(H\).” A redação candidata de B.1 deve incorporar essa contagem explicitamente.

### Finding M3 — o parágrafo de redução subsequente em B.3 não deve permanecer literalmente inalterado

- **Severidade:** MINOR.
- **Localizador:** B.3 vigente, parágrafo iniciado por “Within each acceptance class, reducing weak payments to \(w\), reducing \(x_H\) to the relevant type threshold...”; memorando candidato, indicação de que o restante poderia permanecer após confirmação.
- **Evidência:** depois da correção, o limiar de aceitação de um \(H\) não pivotal é \(o\), não \(\beta o\). Entretanto, a proposta ótima não reduz \(x_H\) a esse limiar: elimina-o integralmente por dominância. Os limiares \(\beta\ell\) e \(\beta h\) são aplicáveis apenas ao ramo pivotal \(n_Y=k-1\).
- **Efeito downstream:** nenhum, porque o novo parágrafo de abertura já contém o argumento de dominância. O problema é de encadeamento lógico e pode induzir uma leitura errada da redução aos quatro candidatos.
- **Correção mínima:** substituir a primeira frase do parágrafo por: “The preceding dominance argument leaves only \(x_H=0\) in the class \(n_Y\geq k\). In the pivotal class \(n_Y=k-1\), weak payments can be reduced to \(w\) and \(x_H\) to \(\beta\ell\) or \(\beta h\), according to the desired acceptance set; proposals in the remaining class deliver delay.”

### Finding M4 — a justificativa sobre crenças cobre apenas o ramo que passa

- **Severidade:** MINOR.
- **Localizador:** memorando candidato, tabela da Seção 7, linha sobre “Crenças após votos fora do caminho”.
- **Evidência:** em \(n_Y\geq k\), de fato não há continuação após o ballot. Em \(n_Y\leq k-2\), contudo, a proposta fracassa e há continuação; o voto de \(H\) pode alterar a posterior. O motivo correto para a invariância é que a maioria terminal produz o mesmo resultado e os mesmos payoffs para toda posterior admissível.
- **Efeito downstream:** nenhum; a Seção 6.3 já usa corretamente a independência em relação à crença.
- **Correção mínima:** completar a célula: “When \(n_Y\geq k\), passage ends the game. When \(n_Y\leq k-2\), continuation exists and posteriors may differ, but terminal-majority outcomes and continuation payoffs are belief-independent.”

## 5. Respostas às dez perguntas de escopo

1. **Factibilidade do desvio.** Sim. A soma agregada é exatamente preservada e não há cap individual sobre \(x_i\).

2. **Lucratividade estrita.** Sim, para todo \(x_H>0\) em toda proposta na qual os votos fracos já bastam. O proponente ganha exatamente \(x_H\) para cada tipo e para qualquer voto de \(H\).

3. **Quota, votos fracos e simultaneidade.** Preservados, desde que a prova invoque explicitamente que os limiares dos votos fracos são independentes de \(x_H\). O desvio é uma proposta alternativa ex ante, não uma realocação feita após observar o ballot.

4. **Respostas de \(H\).** Se \(n_Y\geq k\), sim se e somente se \(x_H\geq o\). Se \(n_Y=k-1\), sim se e somente se \(x_H\geq\beta o\). Se \(n_Y\leq k-2\), ambas as ações conduzem a \(\beta o\), e o desempate exige sim.

5. **Datação do limiar pivotal.** \(\beta o\) está correto. A ação \(N\) adia o jogo para Round 2; o payoff terminal \(o\) é então avaliado em unidades de Round 1. No ramo não pivotal que passa agora, o limiar correto é \(o\), sem desconto.

6. **Desempate em favor de sim.** Corretamente aplicado em \(x_H=o\) no ramo não pivotal, em \(x_H=\beta o\) no ramo pivotal e em todo o ramo \(n_Y\leq k-2\), no qual os dois votos geram a mesma continuação.

7. **\(\Pi_E\), \(\Pi_S\), \(\Pi_P\), cutoffs e knife edges.** Corretos e invariantes. As diferenças de payoff e os desempates foram rederivados acima. Não aparece novo candidato ótimo com \(x_H>0\) não pivotal.

8. **B.2, B.4, B.5 e B.6.** Não exigem mudança substantiva. B.2 herda a maioria terminal corrigida; B.4 trata de unanimidade; B.5 usa exatamente os vetores preservados; B.6 faz subtrações desses mesmos vetores.

9. **Assessment completo versus correspondência reportada.** A distinção está correta. A resposta de \(H\) muda em propostas não pivotais com \(x_H>0\), e algumas crenças associadas a votos fora do caminho podem mudar. As propostas ótimas, os resultados, os payoffs, as classes e as multiplicidades reportadas não mudam.

10. **Redação inglesa proposta.** O conteúdo econômico e os limiares estão corretos. O parágrafo de B.1 deve explicitar \(k\leq m-1\) e a eliminação dos pagamentos positivos aos respondedores. O parágrafo de abertura de B.3 é correto, mas a primeira frase do parágrafo seguinte deve ser ajustada para separar dominância não pivotal de redução a limiares pivotais.

## 6. Auditoria da redação candidata

### 6.1 B.1

A redação candidata é fiel à nova regra e corrige corretamente o erro \(x_H+o\). Ela fica matematicamente completa com duas adições locais: a contagem \(k\leq m-1\) e a observação de que pagamentos positivos aos respondedores também são desnecessários.

Texto substitutivo recomendado:

> In terminal majority, a weak responder's disagreement value is zero, so any nonnegative allocation induces yes under the indifference-to-yes convention. There are \(m-1\) weak responders, and \(k=\lfloor(m+1)/2\rfloor\leq m-1\) for \(m\geq3\); their votes can therefore pass the proposal without \(H\). At any such proposal, a nonpivotal \(H\) votes yes exactly when \(x_H\geq o\): yes yields \(x_H\), whereas no yields \(o\). Yet every \(x_H>0\) is strictly suboptimal for the proposer. If \(H\) votes no, \(x_H\) is paid to no one; if \(H\) votes yes, it is paid for a vote that is unnecessary for passage. In either case, setting \(x_H=0\) and assigning that amount to the proposer preserves every weak-state allocation and ballot, preserves passage, and raises the proposer's payoff by \(x_H\). Positive payments to weak responders can likewise be reduced to zero without changing their ballots. Hence the unique equilibrium outcome has \(x_H=0\), zero payments to every weak responder, the proposer keeps the unit pie, and \(H\) votes no and receives \(o\).

### 6.2 B.3

O parágrafo inglês candidato para os três casos de \(n_Y\) é matematicamente correto, claro e fiel ao protocolo. Não há necessidade de substituir esse parágrafo. Recomendo apenas acrescentar, na primeira frase ou imediatamente antes dele, que o limiar \(w\) é independente da posterior e do voto de \(H\) porque a continuação terminal-majoritária de um Estado fraco é sempre \(1/m\).

O parágrafo atual que vem logo depois deve, contudo, ser substituído pela transição indicada no Finding M3. Sem essa pequena mudança, a expressão “relevant type threshold” pode parecer aplicável também à classe não pivotal, na qual o argumento correto é \(x_H=0\) por dominância.

## 7. Blast radius B.2--B.6

| Subseção | Status | Justificativa |
|---|---|---|
| B.2 | **UNCHANGED** | A maioria terminal continua tendo resultado único \(x_H=0\), payoff 1 ao proponente e \(o\) a \(H\); a parte de unanimidade e \(p^*\) não usa a regra corrigida de exclusão. |
| B.3 | **REPAIR** | Substituir a abertura antiga e ajustar a frase de redução aos candidatos; fórmulas, regiões e multiplicidades permanecem. |
| B.4 | **UNCHANGED** | Sob unanimidade, um não de \(H\) impede a aprovação; não há acordo majoritário que exclua \(H\). |
| B.5 | **UNCHANGED** | Os vetores \((\beta\ell,\beta h)\), \((\beta h,\beta h)\) e \((\ell,h)\) são exatamente os rederivados sob a regra correta. |
| B.6 | **UNCHANGED** | As correspondências de rents são subtrações dos mesmos vetores públicos e privados; o segmento residual continua unidimensional e conjunto, não um produto cartesiano. |

## 8. Conclusão operacional

O candidato não está bloqueado por erro matemático substantivo. A nova regra de exclusão foi corretamente incorporada à lógica econômica: o payoff de um \(H\) que vota não numa proposta que passa sem ele é \(o\), o limiar não pivotal é \(o\), o limiar pivotal é \(\beta o\), e concessões positivas não pivotais são estritamente eliminadas pelo desvio ao proponente.

Ainda assim, eu não avançaria os bytes atuais como `PASS 0/0/0`. O candidato pode avançar **com reparo delimitado**: explicitar a independência dos votos fracos no lema, corrigir a contagem \(k\leq m-1\), ajustar a frase de redução em B.3 e completar a justificativa sobre crenças no ramo que fracassa. Feitos esses reparos, a migração de B.1/B.3 pode prosseguir sem alteração das proposições, dos cutoffs, dos payoffs downstream ou das multiplicidades reportadas.

Este parecer cobre apenas o objeto delimitado no pacote e não autoriza merge, push, tag ou migração automática do manuscrito.
