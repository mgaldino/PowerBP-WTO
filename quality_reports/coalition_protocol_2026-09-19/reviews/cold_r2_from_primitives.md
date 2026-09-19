# Reconstrução fria de R2 a partir das primitivas

**Data:** 19 de setembro de 2026. **Revisor:** `/root/provenance_inventory`, distinto dos implementadores. **Escopo:** somente a rodada terminal do baseline, para maioria e unanimidade. **Estado:** reconstrução concluída; nenhuma comparação com a solução candidata foi feita.

## 1. Independência, fontes e regra de leitura

Li `author_decision.md` e `derivations/game_contract.md`, além de `AGENTS.md`. Avisei o coordenador, antes de reconstruir a solução, que havia lido essas regras e **não havia lido `r2_interface.md`, `r1_interface.md` ou `agenda_transport.md`**. Esses três arquivos continuam não consultados ao fechar este parecer. A inspeção documental anterior do manuscrito antigo não é cegamento a toda a história do projeto; a reconstrução é fria em relação às novas soluções candidatas. Nenhuma fórmula de uma interface nova foi usada como premissa.

A decisão de 19/9 prevalece sobre as obrigações anteriores de permitir alocações positivas fora da coalizão. No contrato, uso como primitivas as linhas 9–64: jogadores, factibilidade, consentimento, payoffs, informação e conceito de solução. As afirmações resumidas nas linhas 68–103 sobre resultados, dependências ou equivalência não substituem a derivação abaixo.

| Fonte lida | SHA-256 |
|---|---|
| `quality_reports/coalition_protocol_2026-09-19/author_decision.md` | `7abfa53814ff23c61a9af2049c975be81e44f8e66270c4fa3f99accd51923726` |
| `quality_reports/coalition_protocol_2026-09-19/derivations/game_contract.md` | `ac78634ea0da03b422a6d92930680d1bb1f94deee0d3c33b68dc9d9791a7d058` |
| `AGENTS.md` | `122a3a53047f9c8c3305a6d768c20687a5833287bf001420661f7fb7564f0098` |

Método: reconstrução de folha conforme `solve-dynamic-games`, com checagem de melhores respostas e desvios conforme `game-theory-audit`, adaptadas à tarefa restrita. A prova é analítica; uma enumeração racional finita independente é documentada ao final. Não há revisão do manuscrito, da agenda ou de R1 neste parecer.

## 2. Contrato terminal e estado suficiente

Há um hegemon H e m≥3 fracos. O tipo de H é \(o\in\{\ell,h\}\), com \(0<\ell<h<1\). Denoto por \(\mu\in[0,1]\) a crença **ao entrar nesta história de R2**, que pode diferir do prior original \(p_0\). Denoto o suporte original por \(S_0\). Um proponente fraco i é reconhecido uniformemente e escolhe \(y=(C,x)\), com

\[
i\in C\subseteq N,\qquad |C|\ge q_g,\qquad x\ge0,\qquad
\sum_{a\in N}x_a\le1,\qquad x_a=0\quad(a\notin C),
\]

onde \(q_M=k+1\), \(k=\lfloor(m+1)/2\rfloor\), e \(q_U=m+1\). A proposta e C são públicos. Somente \(C\setminus\{i\}\) vota, simultaneamente. O proponente conta como sim. O pacote passa se todos os convidados consentirem.

| Resultado terminal | Fraco j | H |
|---|---:|---:|
| Passa, H∈C | \(x_j\) | \(x_H\) |
| Passa, H∉C | \(x_j\), zero fora de C | \(o\) |
| Qualquer recusa de convidado | 0 | \(o\) |

Estes são payoffs em **unidades nativas de R2**. Nenhum termo abaixo recebe β. A passagem de um valor deste relatório a R1 requer exatamente um fator β, aplicado pelo consumidor da interface.

Para resolver payoffs basta reter \((g,\mu,S_0,i;\ell,h,m)\). Para descrever avaliações completas, preservo a história pública, os rótulos de coalizão, as distribuições de propostas e os valores livres de crença permitidos por ballot. Não identifico avaliações completas apenas porque seus valores coincidem.

O problema de ballot é uma folha: cada perfil conduz diretamente a um resultado terminal. O problema do proponente consome essa solução local de ballot; não consome R1, agenda ou qualquer continuação ainda não resolvida. Trata-se de um problema de continuação com informação imperfeita, sem presumir que toda história pública inicie um subjogo próprio.

## 3. Estratégias após toda proposta factível

### 3.1. Todos os fracos convidados votam sim

Considere qualquer \((C,x)\), inclusive fora do caminho, com descarte, convidados de parcela zero ou coalizão maior que a quota. Para um fraco convidado j≠i, a comparação prescrita condicional à pivotalidade é

\[
u_j(Y\mid\text{pivotal})-u_j(N\mid\text{pivotal})=x_j-0\ge0.
\]

O payoff de fracasso é zero em todos os tipos. Logo a crença condicional não altera essa diferença. Se \(x_j>0\), sim é estritamente preferido na comparação; se \(x_j=0\), `T^Y` seleciona sim. Isso continua verdadeiro quando o evento usado para a pivotalidade tem probabilidade zero: qualquer crença local admitida fornece o mesmo payoff terminal zero após fracasso. Portanto, a disciplina declarada seleciona

\[
a_j(C,x)=Y\quad\text{para todo }j\in C\cap W\setminus\{i\}
\]

após **toda** proposta. Não convidados não têm ação de voto.

A conclusão depende do conceito aprovado, em particular do desempate na indiferença. Não é uma alegação de unicidade dos equilíbrios de votação se essa disciplina for removida.

### 3.2. H convidado aceita exatamente quando sua parcela cobre o tipo

Dados os votos prescritos dos fracos, quando H∈C seu sim faz passar e seu não faz fracassar, mesmo quando a coalizão é maior que a quota. Assim,

\[
a_H(o;C,x)=
\begin{cases}
Y,&x_H\ge o,\\
N,&x_H<o.
\end{cases}
\]

Na igualdade, `T^Y` seleciona sim. Quando H∉C, não há voto de H; não se registra um não fictício.

As estratégias acima são prescritas antes de observar os votos simultâneos dos demais. Se um fraco desvia para não, o pacote fracassa e H recebe o qualquer que seja seu voto efetivamente escolhido. Não é preciso nem admissível acrescentar uma resposta de H condicionada a esse voto simultâneo ainda não observado. A tabela do contrato cobre também perfis com vários desvios.

### 3.3. Mapa de sucesso e payoffs de qualquer proposta

Defina \(t=x_H\). Sob as respostas prescritas,

\[
P_o(C,x)=
\begin{cases}
1,&H\notin C,\\
\mathbf 1\{t\ge o\},&H\in C.
\end{cases}
\]

Para todo fraco j, o payoff realizado é \(P_o(C,x)x_j\). Para H, é

\[
U_H(o;C,x)=
\begin{cases}
o,&H\notin C,\\
t,&H\in C\text{ e }t\ge o,\\
o,&H\in C\text{ e }t<o.
\end{cases}
\]

O proponente maximiza \(x_i[(1-\mu)P_\ell+\mu P_h]\), e, entre máximos próprios, minimiza \((1-\mu)U_H(\ell)+\mu U_H(h)\). Estes mapas incluem todas as propostas factíveis; não pressupõem coalizões mínimas ou ofertas ótimas.

## 4. Crenças em todos os ballots

A escolha desinformada de \((C,x)\) conserva μ, inclusive após um desvio do proponente. Se H∉C, todo vetor de votos dos fracos conserva μ, inclusive vetos fora do caminho.

Se H∈C, escreva \(b_\ell=\mathbf1\{t\ge\ell\}\) e \(b_h=\mathbf1\{t\ge h\}\). Os denominadores e os posteriors disciplinados são

\[
D_Y=(1-\mu)b_\ell+\mu b_h,\qquad
\mu_Y=\frac{\mu b_h}{D_Y}\quad(D_Y>0),
\]
\[
D_N=(1-\mu)(1-b_\ell)+\mu(1-b_h),\qquad
\mu_N=\frac{\mu(1-b_h)}{D_N}\quad(D_N>0).
\]

Se um denominador é zero, seu posterior é um valor livre local ao par (ballot, voto de H), com suporte em \(S_0\). Todos os vetores de votos dos fracos nesse ballot que compartilhem o voto de H têm o mesmo posterior. Diferentes propostas, coalizões ou ballots podem ter valores livres distintos.

| Oferta a H convidado | Votos dos tipos (ℓ,h) | Posterior após Y, quando disciplinado | Posterior após N, quando disciplinado |
|---|---|---|---|
| \(0\le t<\ell\) | (N,N) | denominador zero | μ |
| \(\ell\le t<h\) | (Y,N) | 0 se μ<1 | 1 se μ>0 |
| \(h\le t\le1\) | (Y,Y) | μ | denominador zero |

A regra vale também quando o vetor contém um veto desviado de fraco. Não se infere informação adicional do voto desse fraco. Uma crença terminal não afeta payoffs ou votos já escolhidos; sua especificação ainda é parte da avaliação completa.

O suporte relevante para os valores livres é o **original**, não necessariamente o suporte do posterior μ. Se \(p_0\in(0,1)\), um ballot de probabilidade zero pode admitir qualquer posterior em [0,1], ainda que μ seja 0 ou 1. Se \(p_0=0\), toda crença admissível é 0; se \(p_0=1\), toda crença admissível é 1. Os estados de entrada devem respeitar essa disciplina.

## 5. Solução ótima de R2 sob maioria

Como m≥3,

\[
q_M=\lfloor(m+1)/2\rfloor+1\le m.
\]

Existe, portanto, uma coalizão factível composta apenas por fracos, contendo i. Escolha qualquer \(C\subseteq W\) com \(i\in C\), \(|C|\ge q_M\), e atribua \(x_i=1\), todas as demais parcelas zero. Todos os convidados votam sim e o proponente recebe 1 com certeza.

Nenhuma proposta pode render mais que 1. Além disso, se H é convidado:

- se \(t<\ell\), nenhum tipo aceita, e o proponente recebe zero;
- se \(t\ge\ell>0\), seu payoff esperado é no máximo \(x_i\le1-t<1\).

Logo nenhuma proposta com H pode empatar com o valor 1. Sem H, atingir 1 exige \(x_i=1\), o que, por factibilidade, força todas as outras parcelas a zero e nenhum descarte. A correspondência ótima completa é exatamente

\[
\mathcal Y^M_{2,i}
=\{(C,x): i\in C\subseteq W,\ |C|\ge q_M,\ x_i=1,\ x_a=0\ (a\ne i)\}.
\]

O desempate secundário não reduz esse conjunto: todas essas propostas dão a H o seu tipo o, com a mesma média \((1-\mu)\ell+\mu h\). Qualquer distribuição sobre essas coalizões é admissível, desde que a mesma distribuição seja usada para a lei de resultados. Não há seleção autorizada de uma coalizão mínima específica.

Após reconhecimento de i, o vetor de payoffs é

\[
(U_H,U_i,(U_j)_{j\ne i})=(o,1,0).
\]

Antes do reconhecimento uniforme,

\[
C^M_{H,2}(\ell;\mu)=\ell,\qquad C^M_{H,2}(h;\mu)=h,\qquad
C^M_{j,2}(\mu)=\frac1m\quad(j\in W).
\]

O payoff condicional de cada fraco, dado qualquer tipo de H e antes do reconhecimento, também é 1/m. Há acordo imediato com probabilidade um, e H não pertence à coalizão implementada.

**Multiplicidade:** o vetor de payoffs é único. Os rótulos de coalizão e suas loterias podem variar. Por proponente, o número de coalizões ótimas é

\[
\sum_{r=q_M}^{m}{m-1\choose r-1}.
\]

Para m=3 há apenas W; para m=4 há quatro coalizões. Acrescenta-se a multiplicidade de crenças terminais livres onde o suporte original a permite. Essa multiplicidade de avaliações não torna os valores escalares acima set-valued.

## 6. Solução ótima de R2 sob unanimidade

Aqui C=N. Oferecer h a H, dar \(1-h\) a i e zero aos demais produz payoff positivo \(1-h\). Portanto, uma proposta ótima precisa ter probabilidade positiva de aprovação e payoff positivo do proponente.

Dado t com probabilidade positiva de aprovação, quaisquer parcelas a outros fracos ou descarte reduzem estritamente o residual de i sem mudar os votos prescritos. Logo, em um ótimo, \(x_i=1-t\) e os demais fracos recebem zero. A função objetivo reduzida é

\[
Q_U(t;\mu)=
\begin{cases}
0,&0\le t<\ell,\\
(1-\mu)(1-t),&\ell\le t<h,\\
1-t,&h\le t\le1.
\end{cases}
\]

No ramo intermediário, se μ<1, o melhor ponto é t=ℓ; se μ=1, o ramo rende zero e perde para h. No ramo superior, o melhor ponto é t=h. Assim a redução a duas ofertas é uma consequência da otimização em todo o simplex, e não uma restrição imposta ao espaço de propostas.

Defina

\[
\mu^*=\frac{h-\ell}{1-\ell}\in(0,1).
\]

A oferta baixa L rende \(Q_L=(1-\mu)(1-\ell)\), enquanto a oferta alta P rende \(Q_P=1-h\). A oferta L vence estritamente para μ<μ*, e P vence estritamente para μ>μ*.

Na igualdade μ=μ*, o desempate aprovado é decisivo. O payoff esperado de H em L é \((1-\mu)\ell+\mu h\); em P é h. A diferença é

\[
h-[(1-\mu)\ell+\mu h]=(1-\mu)(h-\ell)>0.
\]

O proponente, portanto, seleciona **L no limiar**. Uma mistura L/P no limiar não sobrevive ao segundo desempate. A proposta escolhida, para cada i reconhecido, é unicamente

\[
(C,x)=
\begin{cases}
(N,x_H=\ell,\ x_i=1-\ell,\ x_j=0\ \forall j\in W\setminus\{i\}),&\mu\le\mu^*,\\
(N,x_H=h,\ x_i=1-h,\ x_j=0\ \forall j\in W\setminus\{i\}),&\mu>\mu^*.
\end{cases}
\]

### Payoffs e leis de resultado

| Ramo selecionado | Tipo de H | Resultado e payoff de H | Proponente i | Outro fraco j≠i |
|---|---|---|---:|---:|
| L, μ≤μ* | ℓ | passa; H recebe ℓ | \(1-\ell\) | 0 |
| L, μ≤μ* | h | fracassa; H recebe h | 0 | 0 |
| P, μ>μ* | ℓ | passa; H recebe h | \(1-h\) | 0 |
| P, μ>μ* | h | passa; H recebe h | \(1-h\) | 0 |

Antes do reconhecimento,

\[
C^U_{H,2}(\ell;\mu)=
\begin{cases}\ell,&\mu\le\mu^*,\\ h,&\mu>\mu^*,\end{cases}
\qquad C^U_{H,2}(h;\mu)=h,
\]
\[
C^U_{j,2}(\mu)=
\begin{cases}
\dfrac{(1-\mu)(1-\ell)}m,&\mu\le\mu^*,\\[4pt]
\dfrac{1-h}m,&\mu>\mu^*.
\end{cases}
\]

O payoff esperado de H é \((1-\mu)\ell+\mu h\) no ramo L e h no ramo P. A probabilidade de acordo é \(1-\mu\) no ramo L e 1 no ramo P. Para uso em uma lei ligada por tipos, o payoff pré-reconhecimento de um fraco é \((1-\ell)/m\) dado o tipo baixo e zero dado o alto no ramo L; no ramo P é \((1-h)/m\) para ambos os tipos. Esses valores condicionais não devem ser substituídos pela média em μ quando a operação posterior exige a lei conjunta.

**Multiplicidade:** para cada história de entrada, μ e proponente, C e a alocação ótima são únicos depois dos dois desempates. Votos são únicos sob a disciplina prescrita. Permanecem valores livres de crença terminal quando permitidos, que não alteram resultados. Não há multiplicidade econômica no limiar depois do desempate secundário.

## 7. Endpoints e existência

Os endpoints aqui são μ=0 e μ=1, no domínio estrito \(0<\ell<h<1\). Não se estende a solução a ℓ=0 ou h=1 sem nova análise.

| Regra | μ=0, tipo que recebe probabilidade positiva | μ=1, tipo que recebe probabilidade positiva |
|---|---|---|
| M | H recebe ℓ; cada fraco recebe 1/m em expectativa; acordo certo | H recebe h; cada fraco recebe 1/m em expectativa; acordo certo |
| U | oferta ℓ, H recebe ℓ; cada fraco recebe \((1-\ell)/m\); acordo certo | oferta h, H recebe h; cada fraco recebe \((1-h)/m\); acordo certo |

As estratégias completas do ballot continuam definidas para cada tipo factível. Se se calcula contrafactualmente o payoff do tipo alto em uma história μ=0, ele rejeita a oferta baixa e recebe h; se se calcula o do tipo baixo em μ=1, ele aceita a oferta alta e recebe h. Essas coordenadas de probabilidade zero não são resultados realizados com probabilidade positiva e não justificam uma alegação de equivalência pública para ambos os tipos simultaneamente em um prior degenerado.

Existe uma avaliação que satisfaz o contrato em **todo** estado de entrada admissível e sob ambas as instituições. Uma construção concreta usa a coalizão W deterministicamente em M, a oferta selecionada acima em U, votos de fracos sempre sim, o limiar de H e crenças como na seção 4. Os mapas de limiar são mensuráveis; as escolhas de coalizão podem ser constantes. Logo nenhuma célula de não existência surge em R2 sob as primitivas deste relatório. Isso nada decide sobre existência em R1 ou na agenda.

## 8. Interface fria e livro de verificações

| Nó | Estratégias / seleções | Valor exportado em R2 | Estado desta reconstrução |
|---|---|---|---|
| Ballot terminal após qualquer (C,x) | Fracos convidados Y; H convidado Y iff x_H≥o; não convidados sem voto; crenças da seção 4 | Mapas realizados da seção 3.3, inclusive fracasso após qualquer veto | Demonstrado analiticamente |
| R2_M, após reconhecimento i | Qualquer mistura nas coalizões da seção 5; alocação unitária ao proponente | H=o; i=1; demais fracos=0 | Demonstrado analiticamente |
| R2_M, antes do reconhecimento | Reconhecimento uniforme; manter a lei escolhida de C quando a identidade importa | \((C_{H,2}(\ell),C_{H,2}(h),C_{j,2})=(\ell,h,1/m)\) | Demonstrado analiticamente |
| R2_U, após reconhecimento i | L para μ≤μ*, P para μ>μ*, sem mistura entre os ramos | Lei por tipo da seção 6 | Demonstrado analiticamente |
| R2_U, antes do reconhecimento | Reconhecimento uniforme; preservar vínculo entre tipo, aprovação e payoff | Valores da seção 6, sem β | Demonstrado analiticamente |
| Comparação com `r2_interface.md` | Arquivo não lido | Nenhum veredito de correspondência emitido | Pendente da etapa seguinte |
| R1, agenda, equivalência com o jogo antigo e manuscrito | Fora do escopo | Nenhum resultado exportado sobre essas matérias | Não avaliados |

Cobertura analítica: todo par factível (C,x), coalizões maiores que a quota, convidados de parcela zero, propostas com descarte, perfis desviados de voto, endpoints de crença, igualdade x_H=o, igualdade dos objetivos do proponente e multiplicidade de avaliações. Cada resultado de R2 foi obtido sem importar valor de R1 nem parâmetro de agenda. Alterar payoffs terminais, factibilidade, consentimento, `T^Y` ou o segundo desempate exige refazer a folha e reabrir seus consumidores. Alterar apenas a escolha entre coalizões ótimas de M conserva os payoffs escalares, mas pode alterar a lei de resultados com nomes/identidades.

## 9. Enumeração finita independente e reproduzível

Uma enumeração em Python, com aritmética racional exata (`fractions.Fraction`), percorreu **todas** as propostas de uma malha com denominador 20 e soma de parcelas no máximo 20, para cada coalizão factível que contém o proponente. Foram usados m=3 e m=4; tipos (1/10,7/20) e (1/5,4/5); μ em {0, μ*−1/100, μ*, μ*+1/100, 1}; e ambas as regras. Para cada estado, ordenou-se o objetivo primário e, em empate exato, o negativo do payoff esperado de H. A enumeração não impôs coalizões mínimas, zero a outros convidados, ausência de descarte ou uma lista prévia de ofertas candidatas.

Resultado: **40 estados, 120 asserts, 1.859.550 comparações proposta–estado e zero falhas**. O conjunto de malha tinha 15.939 propostas factíveis para m=3 e 106.260 para m=4 antes do filtro de unanimidade. A enumeração confirmou os ótimos, o desempate em μ*, e a contagem completa das coalizões ótimas de M. Ela é um controle finito da prova; não demonstra por si só todos os parâmetros ou o simplex contínuo.

O script foi executado por entrada padrão, sem criar arquivo adicional. Reprodução integral:

```python
from fractions import Fraction as F
from itertools import combinations
from math import comb

def allocations(c, budget):
    if c == 1:
        for z in range(budget + 1):
            yield (z,)
    else:
        for z in range(budget + 1):
            for rest in allocations(c - 1, budget - z):
                yield (z,) + rest

D = 20
proposals = {}
for m in (3, 4):
    n, q, i = m + 1, (m + 1) // 2 + 1, 1
    arr = []
    for c in range(q, n + 1):
        for rest in combinations([j for j in range(n) if j != i], c - 1):
            C = (i,) + rest
            for amounts in allocations(c, D):
                x = [0] * n
                for j, a in zip(C, amounts):
                    x[j] = a
                arr.append((C, tuple(x)))
    proposals[m] = arr

checks = comparisons = states = 0
for m in (3, 4):
    n, q, i = m + 1, (m + 1) // 2 + 1, 1
    for ell, h in [(F(1, 10), F(7, 20)), (F(1, 5), F(4, 5))]:
        cut = (h - ell) / (1 - ell)
        for mu in (F(0), cut - F(1, 100), cut, cut + F(1, 100), F(1)):
            for rule in ('M', 'U'):
                best, maximizers = None, []
                for C, xn in proposals[m]:
                    if rule == 'U' and len(C) != n:
                        continue
                    x = tuple(F(v, D) for v in xn)
                    if 0 not in C:
                        pass_l = pass_h = True
                        H_l, H_h = ell, h
                    else:
                        pass_l, pass_h = x[0] >= ell, x[0] >= h
                        H_l = x[0] if pass_l else ell
                        H_h = x[0] if pass_h else h
                    prop = ((1-mu)*int(pass_l) + mu*int(pass_h))*x[i]
                    EH = (1-mu)*H_l + mu*H_h
                    rank = (prop, -EH)
                    comparisons += 1
                    if best is None or rank > best:
                        best, maximizers = rank, [(C, x)]
                    elif rank == best:
                        maximizers.append((C, x))
                if rule == 'M':
                    assert best == (F(1), -((1-mu)*ell + mu*h))
                    count = sum(comb(m-1, r-1) for r in range(q, m+1))
                    assert len(maximizers) == count
                    assert all(0 not in C and x[i] == 1 and
                               all(x[j] == 0 for j in range(n) if j != i)
                               for C, x in maximizers)
                else:
                    t = ell if mu <= cut else h
                    rate = 1-mu if t == ell else F(1)
                    EH = (1-mu)*ell + mu*h if t == ell else h
                    assert best == (rate*(1-t), -EH)
                    assert len(maximizers) == 1
                    C, x = maximizers[0]
                    assert (len(C) == n and x[0] == t and x[i] == 1-t and
                            all(x[j] == 0 for j in range(n) if j not in (0, i)))
                checks += 3
                states += 1
print(dict(grid_denominator=D, states=states, assertions=checks,
           proposal_state_comparisons=comparisons, failures=0,
           m3_feasible_proposals=len(proposals[3]),
           m4_feasible_proposals=len(proposals[4])))
```

**Limite final:** esta é uma reconstrução independente da folha R2 sob os hashes de primitivas registrados. Nenhum candidato de solução foi aprovado ou refutado por comparação, pois ainda não foi consultado. Somente este parecer foi criado; candidatos e fontes não foram editados.
