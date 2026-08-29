# Auditoria matemática — equilíbrios explícitos sob maioria

Documento auditado: *Equilíbrios explícitos sob maioria — Pacote autocontido para auditoria matemática externa do estágio de maioria*, de 28 de agosto de 2026.

## 1. Veredito global

**FAIL, mas localizado e corrigível.**

Os equilíbrios explícitos e os principais limites estão corretos. O problema é uma afirmação de atingibilidade em AM-L2: quando \(\kappa_M\) depende da própria proposta, não se pode calcular os preços, alterar a proposta para pagá-los e supor que os preços permanecerão iguais. Isso cria um problema de ponto fixo.

Além disso, AMX-009 depende de uma definição ainda ambígua de “seletor plano”.

## 2. Contagens

- **Critical:** 0
- **Important:** 2
- **Minor:** 2

Achados importantes:

1. A parte de atingibilidade de AM-L2 é falsa para seletores dependentes da proposta.
2. AMX-009 é verdadeiro se “plano” significa globalmente constante em propostas e vetores; é falso sob a leitura apenas “constante nos vetores, dada a proposta”.

Achados menores:

1. AM-L2 não demonstra explicitamente \(K(s)<1\).
2. “Mesmo membro” em posteriores diferentes deve ser escrito como a mesma família de incidência \(F\), produzindo o membro posterior-compatível \(E_F(\mu)\). Em AMX-008, “seletor arbitrário” também deve permanecer no ramo puro \(B\) fixado.

## 3. Matriz claim por claim

| Claim | Status | Justificativa |
|---|---|---|
| AMX-001 | **PASS** | AMX-002–005 cobrem todas as regiões e os endpoints, logo existe PBE puro para toda primitiva admissível. |
| AMX-002 | **PASS** | Pooling e os dois casos separating fecham Bayes, factibilidade, imitação e desvios fora do caminho. |
| AMX-003 | **PASS** | Sob \(o_0\le T\le o_1\), o baixo acorda e o alto atrasa; ambos satisfazem as restrições de imitação. |
| AMX-004 | **PASS** | \(T\le o_0\Rightarrow o_0>1/m\), portanto \(E\) é único; pooling e separating com atraso são PBEs. |
| AMX-005 | **PASS** | A crença constante respeita o suporte degenerado, inclusive nas ações do tipo de probabilidade zero. |
| AMX-006 | **PASS** | O semipooling satisfaz Bayes, reservas ponto a ponto, capacidade e todos os desvios sob (SP). |
| AMX-007 | **PASS** | As misturas nas fronteiras e nos endpoints são válidas. |
| AMX-008 | **PASS** | A geometria combinatória e os dois extremos são exatos, inclusive para \(N=3\) e ambas as paridades. Deve-se fixar o ramo puro \(B\). |
| AMX-009 | **UNRESOLVED** | **PASS** para seletor globalmente constante; **FAIL** se “plano” significar apenas independência do vetor pivotal, permitindo dependência da proposta. |
| AMX-010 | **PASS** | As cotas coordenada a coordenada, a garantia \(A_g\) e o limite para \(V_H^1-V_H^0\) estão corretos. |
| AMX-011 | **PASS** | Se o alto usa acordo com probabilidade positiva, o baixo pode imitá-lo; combinado com AMX-010, isso força diagonalidade. |
| AMX-012 | **PASS** | Os cinco certificados de não existência são válidos dentro dos escopos declarados. |
| AMX-013 | **MECHANICAL EVIDENCE ONLY** | O script não foi fornecido; os 559 testes não substituem prova. |
| AMX-014 | **OPEN BY DESIGN** | A classificação completa de PBEs puros não é reivindicada. |
| AMX-015 | **OPEN BY DESIGN** | A classificação das misturas Borel permanece aberta. |
| AMX-016 | **OPEN BY DESIGN** | O conjunto completo de payoffs permanece aberto. |

Nos lemas: **AM-L1 PASS**, **AM-L2 FAIL como escrito**, **AM-L3 PASS**.

## 4. Assessments coordenados validados

Use a seguinte notação:

- \(F_B^\circ(\mu)\): membro literal cíclico do ramo \(B\), compatível com posterior \(\mu\);
- \(F_B^{\min}(\mu)\): membro literal que atinge \(M_B(\mu)\);
- \(\rho_j(F)=\beta C^I_{M,j}(F)\);
- \(A(F,z,Q)=(z,(\rho_j(F)\mathbf 1\{j\in Q\})_j)\), com \(Q\) contendo \(k\) preços mínimos;
- \(D=(1,0,\ldots,0)\) e \(D_0=(0,\ldots,0)\).

Em cada célula da tabela, \(\kappa_M\) seleciona o membro indicado em **todo** vetor rejeitado. Os votos são definidos em todo \(Y\) por

\[
v_j(s)=\text{sim}\iff x_j\ge \rho_j(F(s)).
\]

Assim, em \(A(F,z,Q)\), os membros de \(Q\) votam sim e os demais não; em \(D\) e \(D_0\), todos votam não.

| Família e condições | Estratégias de \(H\) | Crenças e continuação | Outcome e payoffs |
|---|---|---|---|
| AMX-002a, \(o_1\le T\) | \(\sigma_0=\sigma_1=\delta_{A(F_{B(\nu)}^\circ(\nu),Z_{B(\nu)},Q)}\) | \(\mu\equiv\nu\); \(F(s)=F_{B(\nu)}^\circ(\nu)\) | Ambos acordam; \((Z_{B(\nu)},Z_{B(\nu)})\). |
| AMX-002b A, \(0<\nu<1,\ o_1\le1/m\) | Baixo usa \(A(F_S^\circ(0),Z_0,Q)\); alto usa \(A(F_P^\circ(1),Z_0,Q)\) | \(\mu(s_1)=1\), \(\mu=0\) nos demais pontos; \(P\) em \(s_1\), \(S\) alhures | Dois acordos; \((Z_0,Z_0)\). O acordo alto deixa folga. |
| AMX-002b B, \(1/m<o_1\le T\) | Baixo usa \(A(F_{B(0)}^\circ(0),Z_E,Q_0)\); alto usa \(A(F_E^\circ(1),Z_E,Q_1)\) | \(\mu(s_0)=0\), \(\mu=1\) alhures | Dois acordos; \((Z_E,Z_E)\). Se ambos os ramos são \(E\), tome \(Q_0\ne Q_1\). |
| AMX-003, \(o_0\le T\le o_1\) | Baixo usa \(A(F_{B(0)}^\circ(0),Z_E,Q)\); alto usa \(D\) | \(\mu(s_0)=0\), \(\mu=1\) alhures; \(B(0)\) em \(s_0\), \(E\) alhures | Baixo acorda, alto atrasa; \((Z_E,\beta o_1)\). |
| AMX-004 pooling, \(T\le o_0\) | \(\sigma_0=\sigma_1=\delta_D\) | \(\mu\equiv\nu\); \(F_E^\circ(\nu)\) | Ambos atrasam; \((\beta o_0,\beta o_1)\). |
| AMX-004 separating, \(0<\nu<1,\ T\le o_0\) | Baixo usa \(D_0\); alto usa \(D\) | Posteriores \(0\) e \(1\) nos átomos, \(\nu\) fora; \(F_E^\circ(\mu(s))\) | Ambos atrasam; \((\beta o_0,\beta o_1)\). |
| AMX-005, \(\nu\in\{0,1\}\) | Cada tipo escolhe acordo canônico se \(Z>D_\theta\), \(D\) se \(D_\theta>Z\), e mistura na igualdade | \(\mu\equiv\nu\); \(F_{B(\nu)}^\circ(\nu)\) | \(V_{H\theta}=\max\{Z,D_\theta\}\). |
| AMX-006, sob (SP) | \(\sigma_0=\delta_{s_A}\), \(\sigma_1=\lambda\delta_{s_A}+(1-\lambda)\delta_D\), com \(s_A=A(F_{B(\mu_A)}^{\min}(\mu_A),\beta o_1,Q)\) | \(\mu(s_A)=\frac{\nu\lambda}{1-\nu+\nu\lambda}\), \(\mu=1\) alhures; membro mínimo em \(s_A\), \(E^\circ(1)\) alhures | \(s_A\) passa e \(D\) falha; \((\beta o_1,\beta o_1)\). |
| AMX-007, \(o_0=T<o_1\) | \(\sigma_0=\alpha\delta_{s_A}+(1-\alpha)\delta_D\), \(\sigma_1=\delta_D\), \(s_A=A(F_E^\circ(0),Z_E,Q)\) | \(\mu(s_A)=0\), \(\mu(D)=\frac{\nu}{\nu+(1-\nu)(1-\alpha)}\); família \(F_E^\circ(\mu(s))\) | O baixo mistura; \((\beta o_0,\beta o_1)\). |

A fronteira \(o_1=T\) é a especialização de AMX-006 com \(\beta o_1=Z_E\). Os limites \(\lambda=0,1\) reproduzem, respectivamente, baixo-acordo/alto-atraso e pooling com acordo.

## 5. Contraexemplo ao AM-L2 e à leitura ampla de AMX-009

Considere

\[
N=5,\quad m=4,\quad k=2,\quad
\beta=\frac45,\quad o_0=\frac3{10},\quad o_1=\frac25.
\]

Como \(o_0>1/4\), somente \(E\) existe. Nesse ramo,

\[
E=\frac35,\qquad w=\frac15,
\]

e a reserva em \(A_M\) de um fraco com grau \(d\) é

\[
\rho(d)=\beta\frac{E+wd}{m}=\frac{3+d}{25}.
\]

Após cada proposta, ordene os \(x_j\) do maior para o menor, usando desempate lexicográfico. Atribua grau \(3\) aos dois maiores e grau \(1\) aos dois menores. Uma matriz literal válida, nos ranks \(A,B,C,D\), é

\[
A\to\{B,C\},\qquad
B\to\{A,D\},\qquad
C\to\{A,B\},\qquad
D\to\{A,B\}.
\]

Ela tem graus \((3,3,1,1)\), diagonal zero e linhas somando dois. Use esse mesmo membro em todos os vetores rejeitados após a proposta. O seletor é Borel e é “plano” no vetor pivotal, mas depende da proposta.

Os dois maiores pagamentos enfrentam preço \(6/25\); os dois menores, \(4/25\). Portanto, ponto a ponto,

\[
K(s)=\frac8{25},\qquad Z(s)=\frac{17}{25}.
\]

Entretanto, \(17/25\) não é atingível. Se os dois maiores votarem sim, as transferências somam pelo menos

\[
2\frac6{25}=\frac{12}{25}.
\]

Qualquer combinação envolvendo um dos pagamentos menores custa ainda mais por causa da ordenação dos \(x_j\). Logo todo acordo satisfaz

\[
z_H\le1-\frac{12}{25}=\frac{13}{25}.
\]

A proposta que paga \(6/25\) aos dois maiores e retém \(13/25\) passa, de modo que \(13/25\) é o máximo verdadeiro.

Isso refuta a frase geral de AM-L2 segundo a qual pagar os \(k\) preços pontualmente menores produz \(Z(s)\): ao mudar os pagamentos, muda-se \(s\), o seletor reordena os graus e os preços também mudam.

Também refuta AMX-009 sob a leitura “plano apenas no vetor”. Como

\[
\beta o_0=\frac6{25},\qquad \beta o_1=\frac8{25},
\]

ambos os tipos podem poolar no acordo de \(13/25\), produzindo o PBE

\[
\left(\frac{13}{25},\frac{13}{25}\right).
\]

Mas (5) exige \(a\in[Z_E,\bar Z_E]=[15/25,17/25]\). Portanto esse payoff fica fora do conjunto alegadamente exato.

Se, porém, AMX-009 restringe \(\kappa_M\) a uma mesma matriz \(F\) em todas as propostas e vetores, o contraexemplo está fora da classe e a prova de (5) passa.

## 6. Fronteiras e endpoints

- **\(N=3\):** \(m=2,k=1\), com \(r_E=1\) e \(r_{S/P}=0\). Todas as construções continuam válidas.
- **Paridades:** se \(m=2h\), \(A_{\min}(k)=h\) e \(A_{\min}(k-1)=0\); se \(m=2h-1\), os valores são \(3h-2\) e \(h-1\). As matrizes propostas atingem essas cotas.
- **\(\nu=0,1\):** AMX-005 respeita o suporte, inclusive para o tipo contingente de probabilidade zero.
- **\(o_0=1/m\):** \(S\) é usado em posterior zero e \(E\) para posterior positivo, como determina AX-CM-2.
- **\(o_1=1/m\):** em posterior um, \(P\) é o ramo correto. Nos empates residuais, deve-se fixar um membro literal completo e manter o mesmo peso conjunto.
- **\(o_0=T\):** o baixo fica indiferente entre acordo e atraso, permitindo a mistura de AMX-007.
- **\(o_1=T\):** o alto fica indiferente entre acordo por \(Z_E\) e atraso por \(\beta o_1\).
- **\(T>1\):** como \(o_1<1<T\), AMX-002 fornece pooling com acordo em todo o caso.
- **Fator \(\beta\):** não encontrei aplicação duplicada. \(C_M\) fornece o valor nativo e \(A_M\) aplica exatamente um fator adicional.
- **Exemplos numéricos:** os cinco exemplos da Seção 11 reproduzem corretamente os números declarados.

## 7. Correções mínimas e problemas abertos

### AM-L2

Substituir a afirmação de atingibilidade por:

> Toda proposta aprovada \(s\) dá a \(H\) no máximo \(Z(s)\). Reciprocamente, se um membro literal \(F\) é fixado na proposta resultante \(s^F\), e \(s^F\) paga as \(k\) menores reservas induzidas por \(F\), então \(s^F\) passa e dá a \(H\) o restante do bolo. Não se afirma atingibilidade de \(Z(s)\) para um seletor arbitrário dependente de \(s\).

Acrescentar a prova de factibilidade:

\[
\sum_jC_j^E=1,\qquad
\sum_jC_j^P=1-\beta o_1<1,
\]

\[
\sum_jC_j^S=(1-\mu)(1-\beta o_0)+\mu\beta<1.
\]

Logo \(K(s)\le\beta\sum_jC_j\le\beta<1\).

### AMX-009

O autor precisa escolher e declarar formalmente o escopo. A definição que salva o resultado é:

> Um seletor \(E\)-plano globalmente constante é aquele para o qual existe uma família atômica \(F\) tal que, para toda proposta \(s\) e todo vetor rejeitado \(a\),
> \[
> \kappa_M(s,a,\mu(s))=E_F(\mu(s)).
> \]
> AMX-009 restringe-se a essa classe.

Com essa definição, AMX-009 passa. Sem a independência em relação a \(s\), o contraexemplo acima o refuta.

### AMX-008 e tipagem dos membros

Em §7.1.3, trocar “seletor arbitrário” por:

> seletor arbitrário cuja imagem permaneça no ramo puro \(B\) fixado.

Quando o posterior varia, escrever \(E_F(\mu(s))\), e não literalmente “o mesmo membro \(E\)”. O que permanece igual é a família atômica/incidência; a coordenada de crença deve acompanhar o posterior.

### AMX-014–016

O objeto que impede o fechamento é

\[
\rho_j(s)
=
\beta\max_{a_{-j}\in\mathcal P_j}
C^I_{M,j}\!\left(\kappa_M(s,(0,a_{-j}),\mu(s))\right).
\]

A região de aprovação é endógena:

\[
\mathcal A_\kappa
=
\left\{
s:\#\{j:x_j\ge\rho_j(s)\}\ge k
\right\}.
\]

Em geral,

\[
\sup_{s\in\mathcal A_\kappa}z_H
\neq
\sup_s Z(s),
\]

justamente porque \(\rho(s)\) muda com a proposta. Uma classificação completa exigiria caracterizar todas as regiões de aprovação implementáveis por seletores Borel literais, conjuntamente com crenças e payoffs de rejeição.

Para misturas, soma-se o problema de caracterizar pares de medidas \((\sigma_0,\sigma_1)\) para os quais a regra local de Bayes existe em todo ponto relevante. O conjunto completo de payoffs é a união sobre esses objetos funcionais.

A decisão autoral é, portanto:

- restringir \(\kappa_M\) a uma seleção global ou independente da proposta, obtendo uma classificação mais tratável; ou
- manter toda a liberdade de seleção e aceitar que AMX-014–016 exigem uma análise funcional substancialmente mais ampla.

## 8. Resumo não técnico

Os equilíbrios centrais são seguros:

- pooling com acordo quando \(o_1\le T\);
- baixo acorda e alto atrasa quando \(o_0\le T\le o_1\);
- ambos atrasam quando \(T\le o_0\);
- os separating correspondentes;
- os endpoints;
- o semipooling sob (SP);
- as misturas das fronteiras.

Também são seguros a geometria membro a membro de AMX-008, os limites globais de AMX-010, a diagonalidade de AMX-011 e os certificados de AMX-012.

O único erro matemático efetivo está em tratar preços de continuação endógenos como se permanecessem fixos enquanto a proposta é alterada. Isso não derruba os equilíbrios construídos, porque neles proposta e membro são coordenados explicitamente. Mas impede a afirmação geral de atingibilidade em AM-L2.

Com a correção de AM-L2 e uma definição explícita de “globalmente plano”, o pacote fechado ficaria muito próximo de um **PASS**.
