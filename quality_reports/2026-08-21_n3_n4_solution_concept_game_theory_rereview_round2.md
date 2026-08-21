# Parecer independente `game_theory` — rerevisão dirigida, round 2

**Papel:** revisor adversarial independente de teoria dos jogos.  
**Modo:** estritamente read-only. Nenhum arquivo foi criado, editado, removido, formatado, staged ou commitado.  
**Worktree:** `/private/tmp/PowerBayesianPersuasion-essential-input-solution-concept`  
**Data:** 2026-08-21.

## 1. Objeto e integridade

O SHA-256 observado do manifesto é:

```text
4cbc5b729eb12bf8b3d3c67cd4b4169e2259aa8e90e6f966e9754436d7d69333
```

Ele coincide exatamente com o hash esperado. `shasum -a 256 -c` passou para os nove candidatos, antes e depois da rerevisão:

| Candidato | SHA-256 |
|---|---|
| `n3_r1_majority_rederivation_candidate.md` | `d1efa9a18b170c45e0ad6a0525e3edca36f8bb58d91e7d66f12b4094953d0bed` |
| `n3_r1_majority_candidate.json` | `5c3caa60f419246f5923721ad1c38f195b7b86aea12de4ec6ab32c90f869a865` |
| `n3_claim_ledger.tsv` | `70e42a39cd4ac7f66820647933e6da8669a14b036b591e04d3dba3381b1c4a67` |
| `n4_r1_unanimity_rederivation_candidate.md` | `23eb5de8003e097323daf13bad1cf9370e5220b8daf72ce2ce9c0c88df16ff23` |
| `n4_r1_unanimity_candidate.json` | `c5347c1298ed1cd1c18540813131a3003afe6b857a3eb741f34587840362665e` |
| `n4_claim_ledger.tsv` | `3d236377a87af1cf5dd69d57eb46d8a2a505999f81429588799edf8f6f6fa05f` |
| matriz de sobrevivência | `d00c7678362b5d10d03ebcd40c954d76dcb6461fd117bc30a0091b92f52ae662` |
| relatório consolidado | `f18c32fa33b950cbcd8262407c77b4cd8ac7d18d00963591c1bf47b347acfd6b` |
| script dirigido | `8c5e2800d0210245c150560bc505519b6d0605f9cd57d63b953cf42346b70dd0` |

O script dirigido também passou, incluindo 54 células paramétricas de N3, 60 avaliações de fronteira de N4, identidades algébricas e enumeração dos quatro perfis puros de `H`. Esses resultados foram tratados apenas como checagem auxiliar; o parecer abaixo rederiva as condições relevantes das primitivas e de N2.

## 2. Escopo da rerevisão

A rerevisão foi limitada a:

1. `GT-01`: multiplicidade pura off-path exata em `nu=0`;
2. `GT-02`: endpoint `nu=1` por `T^Y`, sem aplicação indevida de Bayes;
3. `FD-MAJ-01`: vinculação atômica da família de estratégias em N3;
4. `FD-MAJ-02`: exportação apenas de crenças que sustentam as estratégias em N4;
5. invariância da matemática, existência, continuações, accounting e escopo após esses reparos.

Foram mantidas as regras fixadas: desvios fracos não alteram crenças sobre `theta`; ações prescritas de `H` atualizam por Bayes quando têm probabilidade positiva; após desvio de `H`, crenças são livres; votos fracos são avaliados como se pivotais; igualdade esperada implica `sim` por `T^Y`.

## 3. Teste de `GT-01` — multiplicidade em `nu=0`

Defina:

```text
u = min_j x_j,
ell = beta*o_0,
h = beta*o_1,
A = beta*(1-o_0)/m,
B = beta*(1-o_1)/m,
W(eta) = (1-eta)A, se eta<=nu_star,
         B,        se eta>nu_star.
```

Em `nu=0`, a enumeração independente dos quatro perfis de `H` produz:

- `(sim,sim)` é admissível se `u<A`, caso em que algum fraco veta usando o cutoff `A`, ou se `u>=A` e `Y>=h`. No ramo com veto fraco, a crença após `não` deve satisfazer `eta_N<=nu_star`, impedindo desvio lucrativo de `H0`.

- `(não,não)` é admissível se e somente se `u>=B` e `Y<ell`. Todos os fracos votam `sim`; como o `sim` de `H` tem probabilidade zero, sua crença deve satisfazer `W(eta_Y)<=u`. Para `B<=u<A`, isso equivale a `eta_Y>=1-u/A`; para `u>=A`, qualquer `eta_Y` serve.

- `(sim,não)` é admissível se e somente se `u>=A` e `ell<=Y<h`, com `eta_Y=0` por Bayes e `eta_N<=nu_star` para a ação de probabilidade total zero.

- `(não,sim)` nunca é admissível: alguma comparação de `H` viola preferência estrita ou `T^Y`.

Logo, as duas primeiras correspondências se sobrepõem **exatamente** em

```text
B <= u < A  e  Y < ell.
```

Nessa região coexistem duas estratégias puras genuinamente distintas:

1. `(sim,sim)`, com veto fraco;
2. `(não,não)`, com todos os fracos em `sim` e veto de `H`.

Ambas atrasam e pagam `A` ao proponente, mas não são a mesma estratégia. A multiplicidade aparece explicitamente no Lema N4-5, na correspondência JSON e nos registros `SM21` e `SM23` da matriz.

O reparo não cria multiplicidade on-path em `L_star`: ali `u=A` e `Y=ell`, de modo que apenas `(sim,não)` satisfaz as condições. Portanto, permanece correta a unicidade da proposta, do ballot e do resultado on-path em `nu=0`.

**Conclusão sobre GT-01:** resolvido integralmente.

## 4. Teste de `GT-02` — endpoint `nu=1`

Em `P_star`:

```text
Y = h,
x_j = B para todo j,
Q_P = B+1-beta.
```

Quando `nu=1`, uma ação prescrita apenas para `H0` tem probabilidade total zero. O texto reparado reconhece corretamente que Bayes não determina a crença após essa ação.

A eliminação dos perfis separadores não precisa dessa inferência:

- Em `(sim,não)`, `H1` recebe `h` votando `não`. Se desviar para `sim`, recebe igualmente `h`: ou a proposta passa em `Y=h`, ou algum veto fraco leva à continuação de valor `h`. A igualdade esperada ativa `T^Y`, que exige `sim`.

- Em `(não,sim)`, o `não` de `H0` rende no máximo `h`, enquanto o desvio para `sim` rende `h`. Preferência estrita, quando houver, ou `T^Y`, na igualdade, exige `sim`.

- Em `(não,não)`, `H1` também é indiferente entre seu veto e votar `sim`, ambos com valor `h`; `T^Y` novamente exige `sim`.

Assim, apenas `(sim,sim)` permanece. A prova de optimalidade não mudou: qualquer pooling paga ao menos `h` a `H` e `B` a cada fraco, enquanto atraso paga `B`, e

```text
Q_P-B = 1-beta > 0.
```

Separação continua impossível e `P_star` permanece o único ótimo on-path.

**Conclusão sobre GT-02:** resolvido integralmente, sem Bayes indevido no endpoint.

## 5. Teste de `FD-MAJ-01` — atomicidade de N3

O candidato reparado define uma única família

```text
F=(F_i)_{i in W},
```

com cada `F_i` suportada no argmax lexicográfico factível do proponente `i`, e usa essa mesma família em estratégias, payoffs e probabilidades de resultado.

Os indicadores

```text
I_H = passagem com H,
I_X = passagem sem H,
I_D = atraso até N1
```

são mutuamente exclusivos e exaustivos, proposta por proposta e tipo por tipo. Com isso:

- o proponente reconhecido recebe `V_star`;
- o valor ex ante de cada fraco identificado `l` usa o mesmo `F`;
- o payoff de cada tipo de `H` usa o mesmo `F`;
- as probabilidades de passagem com `H`, passagem sem `H` e atraso são marginais dessa mesma construção.

Os fatores de reconhecimento, os pagamentos em cada outcome e o timing de `o_theta` e `t_theta` estão corretos. Não foi imposta simetria `F_i=F_j`, e as multiplicidades de coalizão e de empate permanecem.

**Conclusão sobre FD-MAJ-01:** resolvido; o reparo impede combinações incompatíveis de marginais, mas não altera estratégia ótima, payoff ou existência em N3.

## 6. Teste de `FD-MAJ-02` — crenças compatíveis com IC em N4

O JSON reparado deixou de exportar um conjunto indiscriminado `[0,1]` após todo desvio de `H`. Agora registra apenas crenças que sustentam o perfil correspondente:

- em `nu=0`, `(sim,sim)` com veto fraco requer `eta_N<=nu_star`;
- em `(não,não)`, requer-se `W(eta_Y)<=u`;
- em `(sim,não)`, a ação de probabilidade total zero requer `eta_N<=nu_star`;
- em `nu_star<nu<=1`, `(não,não)` mantém somente `eta_Y` tal que `W(eta_Y)<=u`;
- no endpoint `nu=1`, nenhuma crença é atribuída por Bayes a uma ação de probabilidade total zero; permanecem apenas crenças compatíveis com as ICs e `T^Y`.

A aparente liberdade de `eta_N` em `(sim,sim)` na região alta é genuína: em suas regiões admissíveis, qualquer posterior após o `não` fora do perfil mantém as comparações prescritas. Portanto, não há omissão de restrição necessária.

**Conclusão sobre FD-MAJ-02:** resolvido; o reparo restringe assessments inválidos sem remover equilíbrios válidos ou selecionar entre crenças admissíveis.

## 7. Auditoria de invariância substantiva

| Dimensão | Resultado da rerevisão |
|---|---|
| Matemática de N3 | Inalterada: classes `E`, `S(nu)` e `P`, factibilidade, fronteira screening-pooling, caso `o_1=1/m`, desempate triplo e timing de `o_theta` permanecem os mesmos. |
| Matemática de N4 | Inalterada: `W(eta)`, piso `C`, fronteiras abertas de veto, `L_star`, `P_star`, caso `m=2`, ausência de misturas on-path e contabilidade por tipo permanecem os mesmos. |
| Existência | Inalterada: existe com `L_star` em `nu=0`; não existe PBE puro em `0<nu<=nu_star`; existe com `P_star` em `nu_star<nu<=1`. |
| Multiplicidade | Preservada corretamente: unicidade on-path nas células de existência, duas estratégias puras off-path na região exata de `nu=0` e multiplicidade de crenças apenas dentro das ICs. |
| Continuações | Inalteradas: N3 consome exclusivamente N1; N4 consome exclusivamente N2; `beta` entra exatamente uma vez ao transportar R2 para R1. |
| Accounting | Inalterado: payoffs de N3 agora estão apenas atomicamente ligados à mesma `F`; em N4, pagamentos e valores ex ante continuam separados por tipo e por identidade. |
| Escopo | Inalterado: candidatos seguem `pending/unfrozen`, sem integração ao DAG e sem autorização de N6, N7, comparação institucional, figuras, PDF ou manuscrito. |

## 8. Findings remanescentes

| ID | Severidade | Localização | Resultado |
|---|---|---|---|
| — | — | — | Nenhum finding remanescente ou novo. |

Contagem final:

```text
critical: 0
major:    0
minor:    0
```

# Veredito

**PASS 0/0/0**

Este veredito vale exclusivamente para os nove bytes candidatos vinculados ao manifesto de SHA-256 `4cbc5b729eb12bf8b3d3c67cd4b4169e2259aa8e90e6f966e9754436d7d69333`. Ele não congela N3/N4, não os integra ao DAG e não autoriza qualquer etapa posterior.
