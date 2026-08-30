# Pacote final do implementador — `A_U` sob M/S/B

**Data:** 2026-08-29  
**Resultado do passo 2:** `SUCCESS — READY FOR TWO INDEPENDENT REVIEWS`  
**Lifecycle do projeto:** `pending/unfrozen`  
**Papel:** implementador; não parecerista

## Cadeia de proveniência

1. reconstrução fria a partir do contrato, da emenda/clarificação e de `C_U`;
2. manifesto não autorreferente e blind-lock no commit `c193f3b`;
3. somente então comparação claim a claim com o candidato histórico;
4. reparo explícito de uma omissão de interface, sem copiar uma fórmula
   candidata: a coordenada foi rechecada no `C_U` literal;
5. harness rerodado, DAG revalidado e pacote final hash-pinado.

Esta solução foi fechada sem acesso ao candidato antigo antes do blind-lock.

## Resultado formal central

Com

```text
nu_star=(o_1-o_0)/(1-o_0),
d_0=beta^2 o_0,
d=beta^2 o_1,
a=beta(1-beta o_0)/m,
b=beta(1-beta o_1)/m,
z_L=1-beta+d_0,
z_H=1-beta+d,
Delta=z_L-d,
```

o domínio de continuação é `{0} union (nu_star,1]`, `y_L` e
`y_bar=y_H` pertencem a `Y`, e toda importação de `C_U` recebe exatamente um
`beta`.

- `0<nu<=nu_star`: existe PBE sse `Delta>=0`; payoff dos dois tipos `z_L`;
  toda família tem massa no sinal baixo `y_L` e `nu_off=0`.
- `nu_star<nu<1`, high-only e `nu_off=0`: payoff comum
  `V in [max{z_L,d},z_H]`.
- `nu_star<nu<1`, `nu_off>nu_star`: somente pooling eficiente em `y_H`, payoff
  `z_H`.
- Se `Delta>=0`, a família com massa em posterior zero também existe para
  priors altos.
- Atraso entra no suporte somente quando o payoff comum é `d`.
- `nu=0`: `H0` escolhe `y_L`; a correspondência contrafactual de `H1` depende
  do sinal de `Delta`.
- `nu=1`: ambos escolhem unicamente `y_H`.

As medidas Borel puras, discretas, semi-pooling e atomless são preservadas pelo
member generator, sujeito a Bayes local em todo ponto disciplinado, `nu_off`
único, continuação markoviana e teste pointwise de desvios.

## Entregáveis

- contrato e estado suficiente;
- DAG validado com hashes de dependência;
- derivação completa e interface JSON;
- ledger de 28 claims;
- harness R e dois outputs versionados;
- blind-lock e manifestos;
- comparação histórica claim a claim;
- preflight pós-comparação;
- manifesto final exato não autorreferente.

## Resultado mecânico e pendências

```text
blind: 1094 PASS / 0 FAIL
pós-comparação: 1095 PASS / 0 FAIL
```

Permanecem para os pareceres: reconstruir friamente ao menos uma família,
testar completude do argumento de imitação, auditar limites locais pointwise,
verificar binders literais de `C_U`, a classificação de atraso e a assinatura
exata. Nenhuma dessas obrigações foi chamada de provada pelo R.

`AC` e os pareceres não foram iniciados nesta tarefa.
