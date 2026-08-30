# Parecer formal independente 2 — `A_C` sob M/S/B

**Data:** 2026-08-30  
**Papel:** parecerista formal independente e adversarial, read-only  
**Objeto:** comparação das correspondências privadas de PBE de `A_M` e `A_U`  
**Orientação:** unanimidade menos maioria (`U-M`)  
**Commit empacotado revisado:** `886c440c4ea882cca42472975e6316c927c86a6e`  
**Veredito:** `PASS`

## 1. Independência e integridade

O parecerista não implementou `A_C` e não consultou o outro parecer. Releu os
bytes congelados relevantes de `A_M` e `A_U`, reconstruiu a comparação e tentou
produzir contraexemplos próprios. Não editou o repositório.

O manifesto tinha SHA-256
`6ba078efb05f7aea628f73644e26a05e26dd6de592237a239855a365e6389d9a` e
as 6/6 entradas passaram. O commit `886c440` era ancestral do `HEAD` posterior
`996abd3`; os seis artefatos permaneciam byte-idênticos. Os manifestos finais
de `A_M` e `A_U` também passaram integralmente.

## 2. Produto fibrado e tipagem

Fixadas as primitivas comuns e a fibra

```text
eta=(rho,p),
p=nu_off=nu*rho/(1-nu+nu*rho),
```

com `eta=(*,nu)` nos endpoints, a exigência de mesmo `d` e mesmo `eta`
implementa a comparação autorizada. `y_bar` permanece no domínio e não é
confundido com `y_H`.

O objeto

```text
J_AC^bind(d,eta)=B_M(d,eta) times_(d,eta) B_U(d,eta)
```

é necessário e suficiente: cada componente permanece um binder completo da
própria instituição e o game form não contém dispositivo de correlação
cross-world. Propostas, suportes, continuações e realizações não precisam
coincidir entre regras.

## 3. Fatorização e recombinação

Cada `Sum_econ_g` preserva como uma unidade a fibra e as duas leis anônimas por
tipo. Payoffs, acordo/atraso e marginais anônimas são projeções ou integrais
Borel invariantes. Produtos finitos, subtrações e médias afins preservam
Borelidade, de modo que T3 é válido.

O lifting setwise de C1 usa pares de resumos inteiros e suas pré-imagens
completas; ele não requer seletor Borel e não autoriza formar `V^0` de uma
pré-imagem e `V^1` de outra. Um stress-test com

```text
V_M^01={(0.2,0.8),(0.4,0.6)},
V_U^01={(0.5,0.5)}
```

produz somente `(0.3,-0.3)` e `(0.1,-0.1)`; o vetor espúrio marginalmente
recombinado `(0.3,-0.1)` é corretamente excluído.

## 4. Células de `A_U`

A partição importada foi reconstruída e coincide com a fonte congelada:

| Região | Fibra de `A_U` |
|---|---|
| `nu=0` | `(z_L,max{z_L,d_H})` |
| prior baixo, `Delta_U>=0`, `rho=0` | `(z_L,z_L)` |
| prior baixo, `Delta_U<0` ou `p>0` | `none` |
| prior alto, `rho=0` | `(u,u)`, `u in [max{z_L,d_H},z_H]` |
| prior alto, `p in (0,nu_star]` | `none` |
| prior alto, `p in (nu_star,1]` | `(z_H,z_H)` |
| `nu=1` | `(z_H,z_H)` |

Em particular, `p=nu_star` continua excluído; tipos de probabilidade zero
permanecem no binder; `A_C` só existe quando ambas as fontes são não vazias na
mesma fibra; e nenhuma célula vazia recebe valor fictício.

## 5. Seleção, sinais e envelopes

A orientação `U-M` é consistente. Os sinais são calculados sobre o conjunto
exato antes dos envelopes. Na célula alta com `rho=0`, o intervalo de payoff de
unanimidade é não degenerado, logo valores dependem da seleção, mesmo quando o
sinal é robusto.

Para imagens escalares limitadas,

```text
inf(U-M)=inf U-sup M,
sup(U-M)=sup U-inf M.
```

O texto não presume atingimento e chama o intervalo apenas de casco.

## 6. Stress-test de T5

As fontes congeladas implicam

```text
V_M^theta>=Z_E=1-k*beta/m,
V_U^theta<=z_H=1-beta+beta^2 o_1.
```

Como

```text
Z_E-z_H=beta*(c/m-beta*o_1),
```

`beta*o_1<c/m` basta para dominância estrita da maioria nos dois tipos e ex
ante; igualdade dá apenas dominância fraca. Fora da região, o teorema permanece
silencioso. Nenhuma hipótese nova e nenhum fator novo de `beta` aparecem.

Fixtures independentes confirmaram uma região estrita, uma região silenciosa e
a fronteira de igualdade.

## 7. Evidência mecânica

O verificador foi reexecutado:

```text
MECHANICAL RESULT: PASS | 941 PASS | 0 FAIL
```

O output foi byte-idêntico ao versionado. O DAG também passou como `VALID`. A
prontidão topológica de `A_R` não foi interpretada como autorização.

## 8. Findings e limites

Nenhum finding Critical, Major ou Minor foi identificado. Não apareceu
contraexemplo ao produto fibrado, à fatorização, ao lifting setwise, à partição
de `A_U`, a T5 ou à preservação do vínculo entre tipos.

O parecer não congela `A_C`, não aprova `A_R`, não autoriza migração ao
manuscrito e não autoriza tag, merge ou push.

## 9. Veredito

O candidato é formalmente consistente com as interfaces congeladas de `A_M` e
`A_U`, preserva binders atômicos e distingue corretamente conjunto exato,
resumo econômico, envelopes e seleção.

FINAL_STATUS: PASS  
COUNTS: Critical=0 | Major=0 | Minor=0
