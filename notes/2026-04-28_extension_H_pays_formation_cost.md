# Extensao: H paga custo de formacao da IO (W entra de graca)

**Data**: 2026-04-28  
**Status**: Nota exploratoria

## Setup

Modelo base inalterado, exceto na estrutura de custos de entrada:

- **Modelo atual**: cada W paga $c > 0$; H participa automaticamente (sem custo).
- **Extensao**: H paga custo de formacao $C > 0$; W entra de graca ($c_W = 0$).

Interpretacao: H e o responsavel por produzir o bem publico refletido na IO (financiar secretariado, dispute settlement, infraestrutura de negociacao). W se beneficia do bem publico sem custo de entrada.

**O subgame de barganha nao muda.** Condicional na formacao da IO, os payoffs $V_H^{R1}(\mu, R)$ e $V_W^{R1}(\mu, R)$ sao identicos ao modelo base. O que muda e quem decide se a IO se forma.

## Decisao de entrada

### Modelo atual (W paga c)

- W entra sse $V_W^{R1}(p, R) \geq c$
- Conjuntos de formacao: $\mathcal{F}_R = \{p : V_W^{R1}(p, R) \geq c\}$
- Resultado: $\mathcal{F}_U \subseteq \mathcal{F}_M$ (unanimidade reduz surplus de W)

### Extensao (H paga C)

- W entra sempre: $c_W = 0$ e $V_W^{R1}(p, R) \geq 0$ para todo $p$
- H forma a IO sob regra $R$ sse o net gain cobre o custo: $v(p, R) \geq C$
  - onde $v(p, R) = E[V_H^{R1}(p, R)] - \alpha V_e(p)$
- Conjuntos de formacao: $\mathcal{G}_R = \{p : v(p, R) \geq C\}$

## Resultado central: inclusao se inverte

**Pelo Theorem 1**, se $\alpha < \alpha^*(N, \beta)$:

$$v(p, U) > v(p, M) \quad \forall\; p \in (0, 1]$$

Portanto:

$$\mathcal{G}_M \subseteq \mathcal{G}_U$$

A inclusao e o **oposto** do modelo base. Em todo prior onde majority sustenta formacao, unanimity tambem sustenta — e da payoff estritamente maior.

## Classificacao institucional simplificada

No modelo base (Proposition 4), ha tres regioes:
1. $p \in \mathcal{F}_U$: unanimidade domina (screening)
2. $p \in \mathcal{F}_M \setminus \mathcal{F}_U$: maioria domina (via entry)
3. $p \notin \mathcal{F}_M$: indiferenca (nenhuma IO)

Na extensao, a **regiao 2 desaparece**:
1. $p \in \mathcal{G}_U$: unanimidade domina (screening + formacao mais facil)
2. $p \notin \mathcal{G}_U$: indiferenca (nenhuma IO sob nenhuma regra, ou diferenca residual se $\alpha \geq \alpha^*$)

**Majority nunca domina.** O unico canal pelo qual majority poderia dominar (entrada mais facil) desaparece porque quem decide a entrada agora e H, e H se beneficia de unanimidade.

## Formato dos conjuntos de formacao

### Majority
$v(p, M) = (\lambda_M - \alpha) V_e(p)$, que e **afim** em $p$.
- $\mathcal{G}_M$ e um intervalo: $\mathcal{G}_M = [\tau_H^M,\; 1]$ se $\lambda_M > \alpha$, vazio se $\lambda_M \leq \alpha$.
- Threshold: $\tau_H^M = \frac{C/(\lambda_M - \alpha) - 1}{r - 1}$.

### Unanimity
$v(p, U)$ herda o screening jump em $\mu_s^{R1}$.
- $v(p, U)$ tem uma **descontinuidade positiva** (para cima) em $\mu_s^{R1}$ (mesma descontinuidade do payoff condicional).
- Com os parametros do paper (N=13, r=1.5, alpha=0.19, beta=0.9), $v(p, U)$ e decrescente em $p$ (com jump para cima em $\mu_s^{R1}$). Portanto $\mathcal{G}_U$ e sempre um **intervalo** $[\epsilon, \tau_H^U]$ — nunca desconexo. O net gain e maximo para priors baixos (onde incerteza e alta e screening mais valioso) e minimo em $p = 1$ (sem incerteza, sem screening).
- Para $C$ pequeno, $\mathcal{G}_U = (0, 1]$ — unanimidade domina em todo prior.
- *Nota tecnica*: desconexao de $\mathcal{G}_U$ pode ocorrer em parametros atipicos ($\alpha \geq \bar\alpha$, cutoff R1 no low R2 branch), mas nao nos parametros relevantes para o paper.

## Figura $(p, C)$

No plano $(p, C)$ analogo a Figure 4 do paper:
- **Azul** ($\mathcal{G}_U$): unanimidade domina. Inclui toda a area onde a IO se forma.
- **Laranja** ($\mathcal{G}_M \setminus \mathcal{G}_U$): **vazio**. Nao existe.
- **Cinza**: nenhuma IO forma.

O mapa simplifica para duas regioes em vez de tres.

## Intuicao

No modelo base, unanimidade cria um tradeoff:
- **Dentro da IO**: H ganha mais (screening)
- **Formacao da IO**: mais dificil (W recebe menos → entry condition mais restritiva)

Na extensao, o tradeoff **desaparece**. Quem decide a formacao e H, e H ganha mais sob unanimidade em ambas as margens:
- Margem condicional: screening → payoff maior
- Margem de formacao: net gain maior → mais disposto a pagar C

Unanimidade e estritamente dominante em ambas as dimensoes.

## Conexao empirica

Interpretacao natural: EUA financiam infraestrutura do GATT/WTO (secretariado, DSM, capacidade tecnica). Os custos de "produzir o bem publico" recaem sobre H.

Resultado: nao ha tension nenhuma na escolha de unanimidade. H paga o custo de formacao E escolhe a regra que maximiza seu retorno. Unanimidade faz ambos — gera mais surplus para H e amplia o conjunto de parametros onde a IO se forma.

Isso fortalece o argumento do paper: se H e simultaneamente o financiador e o designer institucional, unanimidade nao e apenas preferida condicionalmente — e preferida **incondicionalmente** (entre as IOs que se formam).

## Implicacoes para o paper

1. **Robustez**: O resultado principal (H prefere unanimidade) e robusto a quem paga o custo. Na verdade, quando H paga, o resultado e mais forte.

2. **Cleanness**: A extensao elimina a regiao onde majority domina. O mecanismo puro (screening) opera sem a complicacao do entry channel.

3. **Tradeoff pedagogico**: O modelo base e mais interessante *porque* tem o tradeoff. O entry channel sob maioria e o que da substancia a Proposition 4. Sem ele, o resultado e "unanimidade domina everywhere" — mais limpo, mas menos rico.

4. **Possivel uso**: Mencionar em footnote ou na Discussion como robustez check. "If the hegemon also bears the formation cost, majority's only advantage—wider institutional viability—vanishes, and unanimity dominates unconditionally."

## Observacoes tecnicas

- A condicao $\alpha < \alpha^*$ ainda e necessaria para $v(p, U) > v(p, M)$ em todo $p$. Se $\alpha \geq \alpha^*$, existe $\bar\mu$ acima do qual $v(p, M) > v(p, U)$, e pode surgir uma regiao onde majority domina para priors altos.
- Nos parametros do paper, $\mathcal{G}_U$ e sempre um intervalo (verificado numericamente). Desconexao so ocorre com $\alpha \geq \bar\alpha$ (parametros atipicos).
- Tudo segue diretamente do Theorem 1 — nao requer prova adicional.
