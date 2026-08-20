# Parecer independente `formal_design` — N4 v3

**Data:** 2026-08-20
**Papel:** `formal_design`
**Modo:** read-only
**Veredicto:** **FAIL**
**Findings:** `0 critical / 2 major / 0 minor / 0 epistemic`

## Objeto auditado

- Base N4: commit `b4a3fab911f836ef99c28c032e8f009910c9ccda`.
- Candidato: `model_redesign/essential_input_interfaces/n4_r1_unanimity_candidate_v3.json`.
- SHA-256 inicial e final: `6c199f961ba2b8e1f55719c8d678decf752fb7bcda042bf796a585f2a4278905`.
- Implementador e revisor são agentes distintos; o revisor não editou arquivos nem abriu o parecer `game_theory`.

## Finding N4V3-FD-01 — major: superinclusão de múltiplos vetos weak

O candidato afirma que, para `m>=3`, qualquer conjunto de pelo menos dois vetos weak é sustentável em todo prior e para qualquer pacote factível, sem limite adicional sobre `x_k`. Isso é falso quando `nu>=nu_star`.

Prova:

- Num atraso on-path por múltiplos vetos, `H0=H1=yes`; Bayes fixa a continuação do vetor realizado no valor subjetivo `C=B` quando `nu>=nu_star`.
- Para qualquer veto `k`, trocar unilateralmente `no` por `yes` ainda deixa ao menos outro veto. A continuação dessa troca vale pelo menos `B`.
- Portanto, `no` paga `B` e `yes` paga pelo menos `B`. Se a desigualdade for estrita, `no` não é melhor resposta; se houver empate, `T^Y` seleciona `yes`, salvo se `yes` tiver sido eliminada por dominância.
- A dominância simultânea dos demais vetos força o valor do vetor de veto único de `k` a ser no máximo `B`. Na linha pivotal, `yes` paga `x_k`; logo `no` só pode dominar `yes` se `x_k<=B`.

A condição exata é:

```text
m>=3, pelo menos dois vetos weak:
  nu<nu_star:  sem limite adicional além da factibilidade;
  nu>=nu_star: x_k<=B para cada weak state que veta.
```

Fixture reproduzível:

```text
m=3, beta=.9, o0=.2, o1=.6, y_bar=.8, nu=.75
nu_star=.5, A=.24, B=.12
(Y,x1,x2,r)=(.10,.30,.30,.30)
```

O pacote é factível, mas nenhum dos dois `no` sobrevive. Uma enumeração independente de 4.096 mapas de continuação encontrou zero assessments válidos. A impossibilidade vale para todo posterior admissível pelo argumento acima. Em contraste, `x1=x2=B` é sustentável; o oracle confirmou a fronteira exata.

A punição de proposta zero-probabilidade usada para `S_3=(1-nu)B` continua válida, pois ali Bayes não fixa o vetor realizado. Portanto, o erro é localizado na correspondência on-path e na multiplicidade exportada; não refuta `S_3`, a existência geral de delay ou P/L.

Classificação §11.1: reparo único, forçado pelo ballot, Bayes e `T^Y`; não requer nova escolha substantiva ou schema. Deve corrigir nota, derivação, candidato, ledger, builder, validator e testes, gerando novo hash para ambos os revisores.

## Finding N4V3-FD-02 — major técnico: cobertura semântica insuficiente

A alegação de cobertura semântica integral não é sustentada por fonte independente. O manifesto integral fixa os bytes correntes, mas seus valores esperados são pins internos; o oracle vetorial não lê nem reconstrói a interface completa.

Neutralizando somente os pins em memória e mutando cada folha:

```text
candidato: 163/1662 rejeitadas; 1499 escaparam
ledger:    171/259 rejeitadas;   88 escaparam
```

As fugas cobrem conteúdo material em estratégias, continuações, security, pooling, delay, payoffs e claims. Dois exemplos exatos passaram com zero erro:

```text
pooling_family.hegemon_payoff_by_type.theta_0: "Y" -> "0"
N4V3-CLM-012.claim -> "CORRUPTED: multi-veto semantics deleted"
```

Os testes common-mode correntes cobrem apenas mutações dirigidas pré-escolhidas. O manifesto detecta drift unilateral, mas uma alteração coordenada de candidato, builder e hashes/manifests esperados não encontra uma segunda fonte que ligue todas as folhas à álgebra.

Não há duplicação literal maciça de código: builder/oracle têm maior bloco comum de quatro linhas; builder/semantic-validator, três. O problema é cobertura semântica insuficiente, não cópia textual como no N3 anterior.

Classificação §11.1: reparo técnico único no requisito — ligar independentemente todas as folhas e claims materiais à reconstrução algébrica/estrutural, acrescentando mutações coordenadas, inclusive o caso on-path de múltiplos vetos. As possíveis implementações são tecnicamente equivalentes e não exigem decisão autoral sobre o jogo.

## Auditoria matemática restante

A rederivação confirmou, salvo o primeiro finding:

- transporte N2 type-conditioned correto: low-only `(A,0)`, pooling `(B,B)`;
- enumeração de `2^m` vetores e `2^m-1` continuações;
- classes P/L/D, inexistência de high-only e de low-only com prior positivo;
- pisos P/L `x_j>=B`, condições de H-veto e veto weak único;
- `S_3=(1-nu)B`;
- `S_2=max{R_0,R_L,R_P}`, seus endpoints e condição de delay;
- identidade, misturas L/D e P/D, coordenadas `nu=0` e payoffs type-conditioned.

Sobre `R_P`: nenhum finding separado. O subproblema pooling em `x>A` tem `R_P>0` como supremo não atingido, mas o mesmo valor numérico pode ser atingido em `x=A` por outro componente. Por exemplo, com `m=2`, `o0=1/5`, `o1=3/5`, `beta=5/6`, `nu=0`, tem-se `R_0=R_L=R_P=S_2=1/6`; `R_P` continua não atingido no seu subproblema, enquanto `R_0` atinge o valor em `x=A`. A regra de `H_tie` distingue corretamente essas duas afirmações.

## Integridade e bateria

- HEAD final observado: `c56a0c4dd3f7285a6d5ac1d63c22a6f5fdb1a96d`; os 12 blobs N4 permaneceram idênticos a `b4a3fab`.
- N2: `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`, `pass/frozen`.
- N4: `pending/unfrozen`.
- Tag protegida: `f53e6769624ce3dd6e64e21ad40d08230b0950a7` após peeling.
- Gate0: PASS.
- DAG: VALID; `Ready: N3, N4`.
- Builder, negativas v2, boundaries, integration, common-mode e verifier N4 retornaram PASS operacional.
- Duas execuções subprocessuais reais do builder produziram bytes idênticos.
- Warnings de locale foram isolados e não são findings.
- Nenhum arquivo ou PDF foi criado ou alterado pelo revisor.
- N4 não pode ser congelado nem consumido por N6; qualquer reparo gera novo hash e retorna aos dois revisores.
