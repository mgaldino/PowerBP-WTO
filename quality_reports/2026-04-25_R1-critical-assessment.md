# Avaliacao critica: R1 resolvido?

**Veredito: NAO. R1 fez melhorias reais mas deixou o problema central sem resolver.**

---

## O que o agente fez (e fez bem)

1. Substituiu "principal regime" por condicao explicita alpha < alpha_bar — **bom**
2. Definiu alpha_bar em equacao numerada — **bom**
3. Derivou alpha_bar explicitamente em A.5 — **bom**
4. Expandiu prova B.2 para cobrir unicidade em ambos os regimes — **parcialmente bom**
5. Atualizou tabela de notacao — **bom**

Estas mudancas sao genuinas melhorias. A Proposition 2 agora tem uma condicao formal em vez de uma vagueza. Ate aqui, OK.

## O problema central: a footnote faz uma afirmacao nao demonstrada

A footnote 5 (nova) diz:

> "All subsequent results—Lemma 1, Theorems 1-2—require only the existence of a unique cutoff and the resulting jump, not the specific closed form; they hold for all alpha in (0, alpha*) regardless of regime."

**Esta afirmacao e o nucleo do R1** e nao esta demonstrada. E por isso que R1 nao esta resolvido.

## Por que a afirmacao e problematica

### 1. alpha* < alpha_bar NAO vale em geral

O plano propunha como opcao 1: "provar que alpha < alpha* implica alpha < alpha_bar." Isso eliminaria o problema automaticamente.

**Resultado**: alpha* >= alpha_bar em **26.823 combinacoes de parametros** testadas. Exemplos no range empiricamente relevante:

| r | N | beta | alpha_bar | alpha* | Gap |
|---|---|------|-----------|--------|-----|
| 1.5 | 5 | 0.9 | 0.424 | 0.474 | [0.424, 0.474] |
| 1.5 | 10 | 0.9 | 0.220 | 0.333 | [0.220, 0.333] |
| 2.0 | 10 | 0.9 | 0.175 | 0.333 | [0.175, 0.333] |
| 1.5 | 30 | 0.99 | 0.097 | 0.631 | **[0.097, 0.631]** |

O gap NAO e raro. Para N=30, beta=0.99, r=1.5: a maioria do dominio do Lemma 1 esta FORA do regime principal.

### 2. A prova do Lemma 1 (B.5) usa formulas do regime principal

A decomposicao D(mu) = D_base + delta_R2·1{mu<mu_s^R2} + delta_R1·1{mu>mu_s^R1} assume o regime principal (mu_s^R2 < mu_s^R1). No regime alternativo (mu_s^R1 <= mu_s^R2), a estrutura de branches muda:

**Regime principal** (mu_s^R2 < mu_s^R1):
- (0, mu_s^R2): agg R1, agg R2
- (mu_s^R2, mu_s^R1): agg R1, **con R2** — branch medio, D = D_base
- (mu_s^R1, 1): con R1, con R2

**Regime alternativo** (mu_s^R1 <= mu_s^R2):
- (0, mu_s^R1): agg R1, agg R2
- (mu_s^R1, mu_s^R2): **con R1, agg R2** — branch medio NOVO, nao coberto pela prova
- (mu_s^R2, 1): con R1, con R2

O branch medio do regime alternativo (conservador R1 + agressivo R2) e DIFERENTE do regime principal (agressivo R1 + conservador R2). As formulas de D_base, delta_R2, delta_R1 nao se aplicam diretamente. A prova precisaria ser refeita para este caso.

### 3. A prova do Lemma 1 comprime o caso alternativo

B.5 diz (linha 983): "If instead mu_s^R1 < mu_s^R2, one intermediate region carries both corrections; since D_base + delta_R2 + delta_R1 remains affine on each subinterval and the corrections vanish or are nonnegative at the branch boundaries, the same endpoint argument establishes positivity."

O referee especificamente pediu que este caso fosse expandido (issue 3.3). O agente NAO expandiu B.5 — apenas adicionou a footnote na Proposition 2 dizendo que "funciona igual."

### 4. Unicidade no regime alternativo: nao demonstrada analiticamente

Em B.2, o agente argumenta unicidade para alpha >= alpha_bar via:
- Delta_1(0) > 0, Delta_1(mu_s^R2) <= 0, logo raiz em (0, mu_s^R2)
- No high branch, Delta_1 <= 0, logo sem raizes adicionais

Mas nao mostra que Delta_1^low e monotona ou tem exatamente UMA raiz em (0, mu_s^R2). A quadratica no low branch poderia ter 2 raizes. O agente diz "numerical verification confirms" — isso nao e prova.

## O que foi verificado numericamente (e o que isso vale)

- Lemma 1 no gap (alpha_bar, alpha*): **162/162 testes passam**. O resultado e verdadeiro.
- Single-crossing (Theorem 2): sobrevive nos testes.

Verificacao numerica confirma que os resultados sao corretos, mas um journal nao aceita "numerical verification" como prova. O referee pediu provas explicitas.

## O que falta para R1 estar realmente resolvido

### Opcao A (rigorosa): Expandir B.5 para o regime alternativo

Escrever D(mu) no regime alternativo com os 3 branches corretos:
1. (0, mu_s^R1): agg R1, agg R2 — calcular D explicitamente
2. (mu_s^R1, mu_s^R2): con R1, agg R2 — NOVO, calcular D
3. (mu_s^R2, 1): con R1, con R2 — mesmo D_base + delta_R1

Verificar endpoints em cada fronteira. Isso resolve R1 E R2 do plano de uma vez.

### Opcao B (pragmatica): Restringir Lemma 1 a alpha < alpha_bar

Se nao quiser expandir a prova, pode restringir o enunciado do Lemma 1 a alpha < min(alpha*, alpha_bar). Isso reduz o dominio mas evita a questao. Downstream, Theorems 1-2 herdam a restricao.

Problema: para beta alto e N grande, alpha_bar pode ser muito pequeno (0.097 para N=30, beta=0.99, r=1.5), reduzindo significativamente o dominio dos resultados.

### Opcao C (minima): Ser honesto

Declarar explicitamente que a prova cobre alpha < alpha_bar e que para alpha in (alpha_bar, alpha*) a afirmacao e verificada numericamente. Isso e mais honesto que a footnote atual, que afirma sem demonstrar.

## Resumo

| Aspecto | Status |
|---------|--------|
| alpha_bar definido e derivado | FEITO |
| "Principal regime" substituido por condicao formal | FEITO |
| Prova B.2 expandida para ambos os regimes | PARCIAL (unicidade no low branch nao demonstrada) |
| Prova B.5 (Lemma 1) expandida para regime alternativo | NAO FEITO |
| Afirmacao da footnote demonstrada | NAO FEITO |
| Relacao alpha* vs alpha_bar verificada | NAO (e alpha* > alpha_bar em muitos casos) |

**O que o agente deveria ter feito**: Antes de escrever a footnote, verificar se alpha* < alpha_bar sempre vale. Ao descobrir que nao, teria que escolher entre opcao A (expandir prova) ou C (ser honesto). Em vez disso, escreveu uma afirmacao nao demonstrada.
