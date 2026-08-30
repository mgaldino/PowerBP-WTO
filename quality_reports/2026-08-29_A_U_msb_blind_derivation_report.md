# Relatório do passe cego — `A_U` sob M/S/B

**Data:** 2026-08-29  
**Papel:** implementador; este arquivo não é parecer  
**Status:** reconstrução própria fechada; `1094 PASS / 0 FAIL`; pronta para o
commit de blind-lock antes de abrir o material histórico  
**Declaração cega:** esta solução foi fechada sem acesso ao candidato antigo.

## Escopo executado

1. preflight exato de branch, HEAD, limpeza e hashes;
2. contrato extensivo completo, informação, ballots, transições, payoffs e
   datas;
3. estado suficiente e DAG com dependência única de `C_U`;
4. importação de `C_U` com `beta` exatamente uma vez;
5. derivação de votos, crenças admissíveis, estratégias puras e mistas,
   endpoints, imitação, atraso, existência e não existência;
6. family records que preservam medidas, crenças, continuação, payoffs e leis
   de outcomes no mesmo binder;
7. interface exata preparada para uso downstream sem presumir suficiência de
   resumo anônimo;
8. ledger de claims e harness R separados da prova.

As skills `solve-dynamic-games` e `formal-game-theory-polisci` governaram o
contrato, o DAG, a ordem reversa e os gates. O trabalho não avançou a `AC`.

## Resultado formal central

Depois do transporte temporal, os preços de voto são

```text
a=beta(1-beta o_0)/m,
b=beta(1-beta o_1)/m,
```

e as maiores parcelas aceitas de `H` são

```text
z_L=1-beta+beta^2 o_0,
z_H=1-beta+beta^2 o_1.
```

O tipo alto recebe `d=beta^2 o_1` depois de qualquer rejeição. A fronteira

```text
Delta=z_L-d=1-beta-beta^2(o_1-o_0)
```

determina se uma família com massa em posterior zero pode existir.

- Em `0<nu<=nu_star`, existe PBE sse `Delta>=0`; todos têm payoff comum
  `z_L` e pertencem à família com `y_L` como único sinal usado de posterior
  zero.
- Em `nu_star<nu<1`, sempre existem famílias high-only com `nu_off=0` e
  payoff comum no intervalo `[max{z_L,d},z_H]`; crença off-path alta força o
  pooling eficiente único `y_H`. Se `Delta>=0`, existe também a família com
  massa em posterior zero.
- Atraso recebe massa somente quando o payoff comum é `d`.
- Em `nu=0`, a estratégia do tipo de prior zero muda com o sinal de `Delta`;
  em `nu=1`, ambos os tipos escolhem unicamente `y_H`.

## Gates e limites honestos

- Contrato: fechado para este candidato.
- DAG: acíclico; `C_U` fechou antes de `A_U`; `AC` não começou.
- Célula `none`: nunca recebe payoff.
- `y_bar`: explicitamente demonstrado em `Y`.
- Crenças: Bayes local pointwise; `nu_off` único.
- Assinatura: binder conjunto e órbita diagonal exata preservados.
- Teste R: evidência mecânica, não prova matemática.
- Revisão: duas revisões independentes ainda pendentes; o implementador não se
  autodeclara revisor.

Qualquer defeito descoberto na comparação posterior reabrirá explicitamente
estes bytes, com origem e reparo documentados; nenhum arquivo histórico será
alterado.
