# Parecer independente — N3 sob `o_1<1`

`reviewer_role=formal_design`  
`reviewer_id=review-n3-o1-formal-2026-08-18-r1`  
Modo: read-only; nenhum arquivo editado pelo revisor.

## Veredito

| Nó | Hash candidato auditado | Critical | Major | Minor | Veredito |
|---|---|---:|---:|---:|---|
| N3 | `561026969956396dbcc8ee9015eb01eb839976385b3503332d9c6744b2fd951b` | 0 | 0 | 0 | **PASS** |

## Hashes, dependência e execução

- Contrato: `7b52f332aff353bf54a36992b0944ab3ff016a1c90e56a05e4853d26d92dab82`
- N1 consumido: `af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd`
- N3 candidato: `561026969956396dbcc8ee9015eb01eb839976385b3503332d9c6744b2fd951b`
- Verificador N3: `52d24ce2446f0bd14aa322f8bb111b71281e36765004fa1bbeab82ed37c68cfe`
- Ledger N3: `e54a575f646e756cc8baba814b1395d588ae19bf5ea5c705a257fc716edd8cb7`
- DAG: `2979568e25b4ee81690e569b1594be49674abe675e57c958eef95f560a0b063e`

Confirmações ao vivo:

- Gate 0: PASS.
- N1 aparece no DAG como `pass/frozen`, com dois reviews `PASS 0/0/0` e o hash
  exato acima.
- N3 depende exclusivamente de N1.
- N2 não aparece nos campos de fonte, na derivação nem no objeto consumido.
- Verificador N3: PASS.
- Checker DAG: `VALID`; N3 está topologicamente pronto.
- N3 permanece corretamente `pending`, com interface `null` no DAG.

## Reconstrução independente de N3

A interface N1 fornece, em unidades nativas de R2:

```text
weak state pré-reconhecimento = 1/m
H do tipo theta = o_theta
R2 passa sem H com probabilidade 1.
```

Transportando exatamente uma vez para R1:

```text
w       = beta/m
t_theta = beta*o_theta.
```

### Ballot de R1

Para cada weak nonproposer:

```text
sim se e somente se x_j >= w.
```

Se `x_j>w`, `sim` domina fracamente; se `x_j<w`, `não` domina fracamente; em
`x_j=w`, há igualdade em todo o stage game e `T^Y` seleciona `sim`.

Se `k` é o número de weak nonproposers que votam `sim`, a IC completa de `H` é:

- `k>=q-1`: `H` é não pivotal; `sim` paga `y` e `não` paga `y+o_theta`;
  ambos os tipos votam estritamente `não`;
- `k=q-2`: `H` é pivotal e aceita se e somente se `y>=t_theta`, inclusive na
  igualdade por `T^Y`;
- `k<=q-3`: a proposta falha com qualquer voto; ambos os votos levam a
  `t_theta`, e `T^Y` seleciona `sim`.

Isso respeita simultaneidade: `H` não observa votos realizados, mas, sob
estratégias puras dos weak states, infere do pacote o vetor prescrito.

O payoff do proponente para toda proposta factível é corretamente:

```text
r_i,                                                     se k>=q-1;
(1-nu)[r_i se y>=t_0, senão w]
 + nu[r_i se y>=t_1, senão w],                           se k=q-2;
w,                                                       se k<=q-3.
```

## E/S/P/R, P0, P1 e P1a

Definindo:

```text
E     = 1-(q-1)w
L     = 1-(q-2)w-t_0
P     = 1-(q-2)w-t_1
S(nu) = (1-nu)L+nu*w
D     = E-w = 1-qw >= 0,
```

a redução exaustiva é:

- `E_i`: compra exatamente `q-1` weak votes a `w`, fixa `y=0` e passa sem `H`;
- `S_i`: compra `q-2` weak votes, oferece `t_0`, passa com o tipo baixo e
  atrasa com o alto;
- `P_i`: compra `q-2` weak votes, oferece `t_1` e inclui ambos;
- `R_i(nu)`: qualquer proposta factível que falha para todo tipo com
  probabilidade positiva no prior.

Os rótulos são aplicados depois da solução e não impostos como regiões.

### P0

Propostas vencedoras de E/S/P usam integralmente a pie. Entretanto, propostas
com folga sobrevivem corretamente dentro de `R_i(nu)` quando `D=0` e a rejeição
está no argmax após o tie-break. Portanto o candidato não transforma a
desigualdade factível em igualdade primitiva nem apaga a exceção de slack.

### P1 e P1a

Para qualquer proposta que já compra `q-1` votos weak e tem `y>0`, o hedge
`s'=(0,x,r_i+y)` é factível, mantém os mesmos votos e aumenta estritamente o
payoff do proponente em `y`. Beliefs off-path não alteram essa comparação porque
N1 é posterior-invariante.

Consequentemente, P1 é provada; nenhuma aprovação on-path sem `H` possui `y>0`;
e a exclusão com `y=0` permanece.

## Fronteiras e igualdades

As diferenças centrais são:

```text
P-E = beta*(1/m-o_1)
S-E = (1-nu)*beta*(1/m-o_0)-nu*D.
```

A classificação do candidato está correta:

1. Se `o_1<1/m`, screening prevalece até
   `nu_SP=beta*(o_1-o_0)/(L-w)`, inclusive na igualdade pelo tie-break; pooling
   prevalece acima.
2. Se `o_0<1/m<o_1` e `D>0`, screening prevalece abaixo de
   `nu_SE=beta*(1/m-o_0)/[beta*(1/m-o_0)+D]`, e exclusão acima. Na igualdade,
   screening é selecionado se `beta<1`; com `beta=1`, screening e exclusão
   permanecem.
3. Se `o_0>1/m` e `D>0`, exclusão é estritamente ótima.
4. Se `o_0=1/m<o_1` e `D>0`, a única igualdade relevante ocorre em `nu=0`:
   screening é selecionado se `beta<1`; com `beta=1`, screening e exclusão
   sobrevivem.
5. Se `o_0<o_1=1/m` e `D>0`, acima da fronteira screening–E, `E=P`; o tie-break
   compara corretamente `h_E=(1-nu)o_0+nu o_1` e `h_P=beta/m`.
6. O corner de delay satisfaz `D=0 iff beta=1 e q=m iff N∈{3,4}`.

`R_i(nu)` é selecionado exatamente quando:

```text
D=0,
o_1>=1/m,
e [nu=1 ou o_0>=1/m].
```

Como `beta=1` nesse corner, exclusão, delay e os demais candidatos empatados dão
o mesmo payoff esperado a `H`; o tie-break não pode eliminar `R_i`. A restrição
`o_1<1` não remove esse corner.

## Beliefs, P6, P7 e priors degenerados

- Propostas com massa positiva preservam `nu` por Bayes porque o weak proposer
  não observa `theta`.
- Toda proposta individual de probabilidade zero admite `kappa_i(s)∈[0,1]`,
  inclusive pontos de massa zero no suporte topológico de uma distribuição
  atomless.
- Todo vetor proposta-votos de probabilidade zero admite `eta_i(s,v)∈[0,1]`.
- Em vetores on-path, o voto publicado de `H` entra explicitamente em Bayes.
- No screening interior, o `não` de `H` após a falha revela o tipo alto.
- Quando os dois tipos votam da mesma forma, o vetor não atualiza além da
  proposta.
- Em `nu=0` e `nu=1`, estratégias, outcomes e payoffs condicionais continuam
  especificados para ambos os tipos.
- Qualquer posterior conduz ao mesmo registro N1, de modo que beliefs off-path
  não alteram os valores transportados.

P6 está aplicada apenas aos weak nonproposers; `H` é disciplinado por
racionalidade sequencial e `T^Y`, sem stage-undominance indevida.

## Payoffs, identidade e atomicidade

Cada proponente reconhecido `i` pode usar sua própria distribuição `F_i` sobre o
conjunto lexicográfico `A_i_star(nu)`. Não se impõe `F_i=F_j`.

O mesmo perfil completo `(F_i)` entra conjuntamente em payoffs dos weak states,
payoffs condicionais de `H`, passagem com `H`, passagem sem `H` e delay. Assim,
a interface preserva multiplicidade de coalizão, proposta, payoff e outcome sem
recombinar marginais incompatíveis. Ballots continuam puros mesmo quando a
proposta é randomizada.

A falha terminal é zero: todo delay de R1 entra em N1, que aprova em R2 com
probabilidade 1.

## Auditoria adversarial do verifier

O verifier ancora os hashes exatos de N1, N3 e ledger N3. Em execução normal,
todos os 87 campos nomeados da interface e as sete colunas do ledger rejeitaram
mutações.

Após neutralizar deliberadamente a primeira barreira canônica:

- `126/126` caminhos recursivos da interface foram rejeitados pela camada
  semântica;
- `112/112` células do ledger foram rejeitadas;
- nenhum campo passou pela neutralização.

Também foram rejeitadas corrupções coordenadas de desconto duplo, destruição de
`y`, imposição de simetria em `F_i`, remoção de R/delay/slack, restrição de
beliefs, remoção de tipo de prior zero/P7, substituição de N1 por N2 e restauração
de `o_1<=1`.

Auditoria matemática independente:

- `12.138.762` propostas factíveis enumeradas em grades e sorteios sobre
  `N=3,…,20`: nenhuma proposta fora de E/S/P/R superou `V_star`.
- `468` verificações independentes de regiões estritas, cutoffs e igualdades:
  todas coincidiram com a interface.
- `32` verificações do corner `D=0`: a condição exata de sobrevivência de
  `R_i` coincidiu em todas.

## Lifecycle e invalidação

N3 permanece `pending`, com `correspondence_cells=null` no DAG e sem
`artifact_hash`, `frozen` ou reviews próprios. Este PASS qualifica apenas o hash
candidato e não congela o nó sozinho.

**Findings:** nenhum texto a transcrever.  
**Contagem final:** critical 0; major 0; minor 0.  
**Veredito estrito no hash exato:** **PASS**.
