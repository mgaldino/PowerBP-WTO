## Parecer independente — N3

`reviewer_role=game_theory`  
`reviewer_id=review-n3-game-2026-08-18`  
Modo: read-only; nenhum arquivo alterado; nenhum subagente utilizado.

### Veredicto estrito

- Hash N3 confirmado: `820b2478205d25338511a372b1f5662514ffb499f666e7b91d6813eb00db93f6`
- Dependência N1 confirmada e congelada: `sha256:bfe56e486098589b10724d6dbd7889eaf1ead087443717c96b6a1f45bd498c9d`
- **Veredicto: PASS**
- `finding_counts = {critical: 0, major: 0, minor: 0}`

## Reconstrução independente

A partir de N1:

```text
w       = beta/m
t_theta = beta*o_theta
```

O desconto aparece exatamente uma vez.

### Ballot

Para cada weak nonproposer:

- `x_j>w`: `sim` domina fracamente `não`;
- `x_j<w`: `não` domina fracamente `sim`;
- `x_j=w`: igualdade contra todos os perfis; `T^Y` seleciona `sim`.

Logo, `sim iff x_j>=beta/m`.

Definindo `k` como o número de weak nonproposers que votam `sim`, a estratégia de `H` está correta em todos os perfis:

- `k>=q-1`: `H` é não pivotal; `não` paga `y+o_theta`, contra `y` em `sim`, portanto `não` estritamente;
- `k=q-2`: `H` é pivotal e vota `sim iff y>=beta*o_theta`;
- `k<=q-3`: a proposta falha com qualquer voto; a continuação é igual e `T^Y` seleciona `sim`.

Stage-undominance é aplicado somente aos weak nonproposers; `H` é disciplinado por PBE e `T^Y`.

### Problema do proponente

A fórmula proposta por proposta está correta e exaustiva. Com

```text
E = 1-(q-1)w
L = 1-(q-2)w-t_0
P = 1-(q-2)w-t_1
S(nu) = (1-nu)L+nu*w
D = E-w = 1-qw
```

todo ótimo pertence a:

- `E`: exclusão com `q-1` weak votes;
- `S`: oferta `t_0`, baixa aceita e alta rejeita;
- `P`: oferta `t_1`, ambos aceitam;
- `R`: propostas que falham para todos os tipos no suporte do prior.

Pagamentos acima do cutoff, votos redundantes, `x_j>0` para votantes dispensáveis ou ofertas acima dos thresholds são desvios estritamente inferiores sempre que a aprovação tem probabilidade positiva.

### P0, P1 e P1a

- Ramos aprovados usam integralmente a pie.
- Folga só sobrevive na família de rejeição quando ela é ótima.
- Toda exclusão com `y>0` sofre o hedge factível `(0,x,r_i+y)`, que preserva votos e eleva estritamente o payoff do proponente.
- Portanto não há aprovação on-path sem `H` com `y>0`.

### Fronteiras e ties

Foram confirmadas:

```text
P-E = beta*(1/m-o_1)
S-E = (1-nu)*beta*(1/m-o_0)-nu*D
```

Bem como `nu_SP`, `nu_SE`, a fronteira `nu_HP` quando `o_1=1/m`, e todos os casos `o_0=1/m`, `o_1=1/m`, `nu=0`, `nu=1`.

A família deliberada `R` é selecionada exatamente quando:

```text
D=0,
o_1>=1/m,
e [nu=1 ou o_0>=1/m].
```

Como `D=0 iff beta=1 e q=m`, o corner está corretamente limitado a `N in {3,4}`. Screening pode gerar delay fora desse corner; o corner caracteriza especificamente a sobrevivência da família de rejeição, de folga e de multiplicidade adicional.

### Crenças e multiplicidade

- Bayes preserva `nu` em toda proposta com massa positiva.
- Crenças são corretamente deixadas livres em toda proposta individual de probabilidade zero, inclusive pontos no suporte topológico de `F_i` atomless.
- O voto público de `H` entra corretamente em P7.
- Vetores proposta-votos de probabilidade zero recebem posterior explícito e irrestrito.
- Tipos de prior zero permanecem nas estratégias e nos payoffs condicionais.
- A correspondência preserva distribuições `F_i` específicas por identidade, sem impor `F_i=F_j`.
- O mapa de payoffs weak é indexado por identidade; não há simetrização silenciosa.
- Estratégias, crenças, payoffs e outcomes usam o mesmo perfil `(F_i)`, preservando atomicidade.

## Verificação executável

- Gate 0 canônico: exit `0`, PASS.
- `verify_essential_input_n3.R`: exit `0`, PASS.
- 16 mutações negativas de interface rejeitadas.
- Mutação negativa do ledger rejeitada.
- Ledger: 15/15 claims, todos `proved`, ligados ao mesmo registro e à data R1.
- Auditoria independente adicional: `20.000` sorteios de parâmetros, com `20` desvios factíveis por sorteio, sem proposta fora do envelope `E/S/P/R`.

**Findings exatos: nenhum.**

O hash submetido satisfaz o gate `game_theory` com `PASS 0/0/0`.
