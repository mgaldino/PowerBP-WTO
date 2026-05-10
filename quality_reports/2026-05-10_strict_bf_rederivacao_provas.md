# Rederivação das provas sob BF estrito

**Projeto:** *Informational Power Through Pivotality*  
**Objeto:** correção das provas após o parecer sobre a outside option de `H` e a decisão de manter Baron-Ferejohn estrito.  
**Status:** assessment analítico após rederivação por agentes independentes e verificação cruzada.

## 1. Veredito executivo

O parecer está correto, e o problema é maior do que a contabilidade de maioria.

1. **Maioria com outside option externa passa.** A correção remove o fator `(1-alpha)` dos payoffs dos fracos sob majority. Com isso, weak proposers excluem `H`, a informação privada de `H` não entra na coalizão, e majority continua sem screening.

2. **Unanimidade em R2 passa.** O cutoff de R2 sobrevive exatamente.

3. **Unanimidade em R1, quando W propõe, não é a prova antiga.** Sob BF estrito, W não pode propor uma alocação que só fecha em valor esperado. Se o posterior contém os dois estados, uma proposta aceita no estado baixo tem de caber no bolo baixo. A escolha de W em R1 vira uma escolha constrangida entre oferta agressiva, oferta conservadora factível e rejeição deliberada. Não há um único cutoff global monotônico.

4. **Unanimidade em R1, quando H propõe, é o ponto mais delicado.** A fórmula antiga de pooling,
   `V_e(p) - (N-1) beta W2(p)`,
   só é válida em uma região. Fora dela, o subgame de H-proposer é um jogo de sinalização. Não há pure-strategy PBE simples com separação aceita dos dois tipos; o ramo high-accepted/low-rejected também falha como caracterização PBE limpa. Para provas gerais, não devemos usar a fórmula antiga globalmente.

5. **Há uma rota segura para a calibração.** Mesmo sem selecionar um equilíbrio do ramo H-proposer, `H` tem um lower bound selection-free. Com esse lower bound e a caracterização verificada do W-proposer, a unanimidade domina a maioria corrigida em toda a faixa `p in [0,1]` na calibração `N=13, r=1.5, alpha=0.19, beta=0.9`. O menor gap ocorre em `p=1` e é aproximadamente `0.02162`.

6. **Não há, ainda, PASS sem ressalva para o teorema geral antigo.** O resultado geral precisa ser reescrito como um teorema de condições suficientes ou como uma proposição calibrada/paramétrica baseada em bounds, não como a antiga prova fechada com cutoff único.

## 2. Primitivos que devem governar a reescrita

- `N >= 3`: um hegemon `H` e `N-1` weak states.
- `theta in {0,1}`; `V(0)=1`, `V(1)=r>1`.
- `H` observa `theta`; weak states não observam.
- Outside option de `H`: `alpha V(theta)`, com `alpha in (0,1/r)`.
- Outside option dos fracos: `0`.
- Dois rounds BF, proposta aleatória em cada round.
- Se R1 é rejeitado, a rejeição e o perfil de votos são públicos; novo proponente é sorteado em R2.
- Sob unanimidade, todos os membros precisam aprovar.
- Sob majority, `q=floor(N/2)+1`.
- Factibilidade BF estrita: uma proposta aceita com probabilidade positiva no estado baixo deve caber no bolo baixo.
- Entrada dos fracos é coletiva, all-or-nothing: a instituição forma se o payoff representativo dos fracos cobre `c`.

Essa última mudança precisa substituir a linguagem atual de entrada simultânea individual.

## 3. Majority corrigida: PASS

Defina:

```text
V_e(p) = 1 + p(r-1)
A0 = 1 + (N-1) alpha
q = floor(N/2) + 1
```

### R2 majority

Se `H` propõe, compra `q-1` votos fracos a custo zero e fica com `V(theta)`. Se `W` propõe, forma uma coalizão de fracos e exclui `H`; a outside option de `H` é externa ao bolo institucional.

Valores corretos:

```text
V_H^R2(theta,M) = A0 V(theta) / N
V_W^R2(p,M) = V_e(p) / N
```

A fórmula antiga `V_W^R2(p,M) = (1-alpha)V_e(p)/N` está errada sob a contabilidade externa.

### R1 majority

Payoff esperado de `H`:

```text
E[V_H^R1(p,M)] = lambda_M^E V_e(p)
lambda_M^E = [N A0 - beta(q-1)] / N^2
```

Payoff representativo dos fracos:

```text
V_W^R1(p,M) = kappa_M^E V_e(p)
kappa_M^E = [N(N-1) + beta(q-1)] / [N^2(N-1)]
```

Conjunto de entrada coletiva sob majority:

```text
F_M^E = {p: kappa_M^E [1+p(r-1)] >= c}
```

Com truncagem:

- se `c <= kappa_M^E`, majority forma para todo `p`;
- se `c > r kappa_M^E`, majority nunca forma;
- caso contrário, forma se `p >= (c/kappa_M^E - 1)/(r-1)`.

### Condição `lambda_M^E > alpha`

Isso não é automático. Agora:

```text
lambda_M^E > alpha
iff alpha < 1 - beta(q-1)/N
```

Substantivamente: se a outside option de `H` for alta demais, majority institucional pode dar a `H` menos do que ficar fora. A prova antiga de B.8 não pode usar `lambda_M > alpha` sem essa condição.

## 4. Unanimity R2: PASS, com tie-breaking no cutoff

Defina:

```text
g(p) = max{ (1-p)(1-alpha), V_e(p) - alpha r }
W2(p) = g(p)/N
p2 = alpha(r-1)/(r-alpha)
```

Interpretação:

- oferta agressiva de `W` em R2 paga `alpha` a `H`; só o tipo baixo aceita;
- oferta conservadora paga `alpha r`; os dois tipos aceitam.

O cutoff de R2 é:

```text
p2 = alpha(r-1)/(r-alpha)
```

Esse objeto passa. No ponto `p=p2`, W é indiferente; o paper precisa declarar tie-breaking.

Valores de `H` em R2 sob unanimidade:

```text
H2_1(p) = r[1+(N-1)alpha]/N
```

para o tipo alto sempre, e

```text
H2_0(p) = [1+(N-1)alpha]/N
```

no ramo agressivo de R2, enquanto

```text
H2_0(p) = [1+(N-1)alpha r]/N
```

no ramo conservador.

## 5. Unanimity R1 quando W propõe: PASS com condições

Aqui está a principal rederivação.

Defina:

```text
k = N-2
A0 = 1 + (N-1)alpha
A1 = 1 + (N-1)alpha r
hC = beta r A0 / N
hA = beta A1 / N
yA = beta W2(0) = beta(1-alpha)/N
```

### Oferta conservadora

W paga `hC` a `H`, suficiente para o tipo alto aceitar. Paga `beta W2(p)` a cada um dos `N-2` fracos não proponentes.

Payoff do proponente:

```text
C(p) = V_e(p) - hC - (N-2) beta W2(p)
```

Factibilidade BF estrita:

```text
hC + (N-2) beta W2(p) <= 1
```

Esse ramo passa somente onde essa desigualdade vale.

### Oferta agressiva

W quer que `H` baixo aceite e `H` alto rejeite.

Pagamento mínimo a `H` baixo:

```text
hA = beta [1+(N-1)alpha r] / N
```

Razão: se o tipo baixo rejeitar, a rejeição é interpretada como o caminho de rejeição do alto, levando a posterior alto em R2; logo ele precisa ser compensado por essa continuação.

Pagamento mínimo aos fracos não proponentes:

```text
yA = beta W2(0) = beta(1-alpha)/N
```

Esse ponto foi verificado por dois agentes independentes. No padrão BF com votos simultâneos e perfil de votos público, o voto de um fraco não proponente é pivotal apenas quando `H` aceita, isto é, no estado baixo. O termo de estado alto cancela. Portanto:

- `beta W2(0)`: PASS.
- `beta W2(p)`: FAIL.
- `beta W2(1)`: FAIL.
- mistura ex ante: FAIL sob BF público padrão.

Payoff do proponente:

```text
A(p) =
(1-p)[1 - hA - (N-2)yA] + p beta W2(1)
```

Factibilidade:

```text
hA + (N-2)yA <= 1
```

### Rejeição deliberada

W também pode fazer uma proposta que ambos os tipos rejeitam:

```text
R(p) = beta W2(p)
```

### Caracterização correta

O payoff de W-proposer em R1 é:

```text
W1_prop(p) = max{ A(p) if feasible, C(p) if feasible, R(p) }
```

Logo, o enunciado antigo de cutoff único não passa. O objeto correto é uma escolha constrangida. Cutoffs existem apenas localmente, entre alternativas factíveis.

### Calibração

Para `N=13, r=1.5, alpha=0.19, beta=0.9`:

```text
p2 = 0.072519
hC = 0.340615
hA = 0.306000
yA = 0.056077
```

Oferta agressiva é factível:

```text
hA + 11*yA = 0.922846 < 1
```

Root entre agressiva e conservadora:

```text
p_AC = 0.031188
```

Limite superior de factibilidade da conservadora:

```text
p_C^F = 0.301717
```

Regimes do W-proposer:

```text
A para p < 0.031188
C para 0.031188 < p <= 0.301717
A para p > 0.301717
```

Rejeição deliberada não domina estritamente; empata com agressiva em `p=1`.

Conclusão: a branch conservadora global da prova antiga é inválida. No exemplo calibrado, ela só é factível até aproximadamente `p=0.302`.

## 6. Unanimity R1 quando H propõe: FAIL para a fórmula antiga global

A fórmula antiga pressupõe que `H` oferece `beta W2(p)` a cada fraco e fica com:

```text
V(theta) - (N-1) beta W2(p)
```

Isso é um pooling accepted offer. Ele só é válido onde o pooling é um PBE.

### Condição de pooling aceito

Com `m=N-1`, o pooling em `t_p = beta W2(p)` exige:

```text
1 - m beta W2(p) >= beta A0/N, se p <= alpha
1 - m beta W2(p) >= beta A1/N, se p > alpha
```

Além disso, o total precisa caber no estado baixo:

```text
m beta W2(p) <= 1
```

O tipo alto não gera uma condição mais forte se a condição do tipo baixo vale.

Na calibração:

```text
pooling aceito existe iff p <= 0.240741
```

A factibilidade pura só falha perto de `p=0.977407`, mas a racionalidade sequencial do tipo baixo falha bem antes.

### Separação aceita dos dois tipos

Não existe pure-strategy PBE em que os dois tipos sejam aceitos com ofertas separadas. Se o baixo oferece `t0` e o alto oferece `t1`, o alto quer mimetizar a oferta mais barata do baixo. O argumento de IC força `t1 <= t0`; a IC do baixo força `t0 <= t1` quando ambas são factíveis. Logo as ofertas colapsam para pooling.

### Alto aceito, baixo rejeitado

Um agente verificou que isso pode ser sustentado como weak PBE com crenças hostis; outro mostrou que, sob a disciplina necessária para impedir o alto de desviar para uma oferta mais barata, o baixo ganha manipulando a crença de rejeição. A conclusão segura é:

```text
não usar esse ramo como valor selecionado no paper
```

Sem resolver o subgame misto ou declarar seleção, não há fórmula única para esse ramo fora da região de pooling.

## 7. Lower bound selection-free para H-proposer: PASS

Há, porém, uma garantia de payoff que não depende de seleção do subgame de sinalização.

### Tipo baixo

O tipo baixo pode oferecer zero. Se a oferta é aceita, recebe `1`. Se é rejeitada, vai a R2 e recebe pelo menos:

```text
beta A0 / N
```

Como `1 >= beta A0/N`, o tipo baixo garante:

```text
beta A0/N
```

### Tipo alto

O tipo alto pode oferecer a cada fraco:

```text
beta W2(1) + epsilon
```

Como `W2(q) <= W2(1)` para todo posterior `q`, isso garante aceitação para qualquer crença. A oferta é factível para o tipo alto porque:

```text
(N-1) beta W2(1) < r
```

Tomando `epsilon -> 0`, o tipo alto garante:

```text
r - (N-1) beta W2(1)
```

Portanto, o lower bound selection-free do ramo H-proposer é:

```text
L_H(p) =
(1-p) beta A0/N
+ p [r - (N-1) beta r(1-alpha)/N]
```

Esse bound vale independentemente de crenças off-path e de seleção de equilíbrio.

## 8. Comparação calibrada usando lower bound: PASS para a calibração

Com `N=13, r=1.5, alpha=0.19, beta=0.9`, `q=7`:

```text
lambda_M^E = 0.220355029586
```

Usando:

- o lower bound selection-free para H-proposer;
- os regimes verificados do W-proposer: `A -> C -> A`;
- majority corrigida com outside option externa;

o payoff de unanimidade fica acima de majority para todo `p in [0,1]`.

O menor gap ocorre em `p=1`:

```text
U_LB(1) = 0.352153846154
M(1)    = 0.330532544379
gap     = 0.021621301775
```

Esse é um resultado calibrado/paramétrico. Não deve ser vendido como teorema geral sem checar endpoints por regiões paramétricas.

## 9. Implicações para o paper atual

### Enunciados que podem ser mantidos após reescrita

1. Majority elimina screening: sim, com fórmulas corrigidas.
2. R2 unanimity screening cutoff: sim.
3. O mecanismo de screening sob unanimity existe: sim, mas a R1 forma não é cutoff global monotônico.
4. A calibração principal ainda sustenta vantagem de unanimity sobre majority: sim, usando lower bound.

### Enunciados que não podem ser reenviados como estão

1. Proposition de cutoff único de R1.
2. Fórmula antiga do jump em R1.
3. Teorema geral de dominância condicional com a prova antiga.
4. Prova de `F_U subset F_M` via budget balance.
5. Classificação institucional B.8 sem condição `lambda_M^E > alpha`.
6. Figura com branch conservadora global acima do cutoff antigo.
7. Appendix C com majority usando `(1-alpha)` e sem reauditoria BF estrita.

## 10. Arquitetura recomendada das novas provas

### Lemma 1: Majority external-option accounting

Provar que W exclui `H` sob majority e que:

```text
V_H^R1(p,M) = lambda_M^E V_e(p)
V_W^R1(p,M) = kappa_M^E V_e(p)
```

### Lemma 2: R2 unanimity screening

Provar `p2`, `W2(p)`, `H2_0(p)`, `H2_1(p)`.

### Lemma 3: R1 W-proposer constrained choice

Definir `A(p)`, `C(p)`, `R(p)` com as factibilidades. Enunciar que o W-proposer escolhe o máximo factível.

### Lemma 4: H-proposer lower bound

Provar o lower bound selection-free `L_H(p)`.

### Proposition 1: Calibrated dominance

Para a calibração, verificar por regiões que:

```text
[L_H(p) + (N-1) Hpay_Wprop(p)]/N > lambda_M^E V_e(p)
```

em todos os intervalos relevantes:

```text
[0, p_AC]
[p_AC, p_C^F]
[p_C^F, 1]
```

Como cada expressão é afim por intervalo, basta checar endpoints.

### Proposition 2: Entry sets with collective entry

Definir:

```text
F_R = {p: V_W^R1(p,R) >= c}
```

com entrada coletiva. Não usar mais argumento de jogo simultâneo individual.

### Theorem: Institutional comparison

Há duas opções seguras:

1. **Teorema calibrado/paramétrico:** sob `N=13, r=1.5, alpha=0.19, beta=0.9` e para custos `c` em região especificada, unanimity domina onde sustenta entrada; majority domina apenas pela margem de entrada.

2. **Teorema geral de condições suficientes:** derivar condições por endpoint para que o lower bound de unanimity exceda majority em todos os ramos. Esse teorema é mais trabalhoso, mas seria o substituto correto do Theorem 1 antigo.

## 11. Conclusão

A correção mínima não é suficiente. A prova antiga mistura três problemas:

- outside option externa sob majority;
- factibilidade BF estrita;
- sinalização no ramo H-proposer de R1.

A boa notícia é que o mecanismo não morreu. O caso calibrado sobrevive com uma prova mais rigorosa e até mais defensável, porque não depende de selecionar um equilíbrio frágil no subgame de H-proposer. A má notícia é que o teorema geral antigo não deve ser reenviado ao parecerista. Ele precisa virar um resultado por condições suficientes ou um resultado calibrado/paramétrico com provas por intervalo.
