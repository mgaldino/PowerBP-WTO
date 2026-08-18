# Parecer adversarial N3 — Round 2

`reviewer_role=game_theory`  
`reviewer_id=review-n3-o1-game-2026-08-18-r2`

Auditoria exclusivamente read-only. Nenhum arquivo foi alterado pelo revisor.

## Hashes e lifecycle

- N1 consumido, `pass/frozen`: `af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd`
- Interface N3: `561026969956396dbcc8ee9015eb01eb839976385b3503332d9c6744b2fd951b`
- Derivação corrigida: `4aca972699bbe11aa275fc04ec62ccedda2ea94c74a5e7352cd61773b7fbd6a6`
- Verifier N3: `ac9f30d9f903f220f5ab6d4dadabe04333736c7c538f573131f66fbef5575cab`
- Ledger: `e54a575f646e756cc8baba814b1395d588ae19bf5ea5c705a257fc716edd8cb7`
- Contrato: `7b52f332aff353bf54a36992b0944ab3ff016a1c90e56a05e4853d26d92dab82`

Gate 0 e o verifier N3 terminaram com `PASS`. N3 permanece corretamente
`pending/null` até o encerramento do ciclo de duas revisões.

## Fechamento de N3-GT-01

O finding anterior foi fechado exatamente. A nova derivação afirma:

> “Em `nu=0`, não há análogo para o tipo alto: como `t_0<t_1`, a condição
> `y<t_0` de `R_i(0)` quando `H` é pivotal implica que ambos os tipos
> rejeitam.”

A lógica agora está correta:

- Em `nu=1`, uma proposta com `t_0<=y<t_1` pode pertencer a `R_i(1)`: o tipo
  alto no suporte rejeita, enquanto o baixo de prior zero aceitaria.
- Em `nu=0`, uma proposta pivotal de `R_i(0)` exige `y<t_0<t_1`; portanto ambos
  os tipos rejeitam.
- Se `k<=q-3`, nenhum tipo consegue produzir aprovação, independentemente de
  sua aceitação individual.

O verifier agora fixa também o hash exato da derivação, exige a afirmação
assimétrica correta, contém teste numérico independente para os dois endpoints e
rejeita a frase simétrica antiga, contradição anexada e remoção da demonstração.

Não permanece contradição na interface ou no ledger.

## Reconfirmação da correspondência

A interface permaneceu no mesmo hash e continua correta.

### Ballot e continuação

- Weak nonproposer vota sim se e somente se `x_j>=beta/m`.
- Para `x_j=beta/m`, a indiferença é global no information set e `T^Y`
  seleciona sim.
- Stage-undominance continua weak-only.
- Se `H` é não pivotal, não dá `y+o_theta`, contra `y` após sim; não é
  estritamente ótimo.
- Se `H` é pivotal, aceita se e somente se `y>=beta*o_theta`.
- Se a proposta falha com qualquer voto, `H` vota sim por `T^Y`.
- N1 é transportado exatamente uma vez: `w=beta/m` e
  `t_theta=beta*o_theta`.

### E/S/P/R e obrigações

A redução continua exaustiva:

- `E`: exclusão, `q-1` pagamentos de `w`, `y=0`;
- `S`: screening, `q-2` pagamentos de `w`, `y=t_0`;
- `P`: pooling, `q-2` pagamentos de `w`, `y=t_1`;
- `R`: propostas que falham para todos os tipos com prior positivo.

P0, P1 e P1a permanecem válidos:

- propostas aprovadas ótimas usam integralmente a pie;
- slack só sobrevive em `R` quando rejeição pertence ao argmax;
- toda aprovação sem `H` com `y>0` sofre o desvio estritamente lucrativo que
  transfere `y` para `r_i`;
- não há aprovação on-path sem `H` com `y>0`.

As fronteiras continuam determinadas por:

- `P-E=beta*(1/m-o_1)`;
- `S-E=(1-nu)beta*(1/m-o_0)-nu*D`;
- `D=1-beta*q/m>=0`.

A condição de delay permanece exata:

`R` é selecionado se e somente se `D=0`, `o_1>=1/m` e
`[nu=1 ou o_0>=1/m]`.

Assim, o domínio `o_1<1` não elimina o corner de delay/slack, pois `D=0`
depende de `beta=1` e `q=m`.

Foram repetidas 50.000 combinações independentes de primitivas para as
identidades de payoff e a seleção de `R`; houve zero falhas.

### Crenças, identidades e atomicidade

- Propostas com massa positiva preservam `nu` por Bayes.
- Propostas individuais de massa zero, inclusive em suporte atomless, recebem o
  tratamento off-path estipulado pelo contrato.
- O voto público de `H` entra em P7 e revela o tipo nos ramos separating com
  probabilidade positiva.
- Estratégias e payoffs permanecem definidos para tipos de prior zero.
- Cada proponente conserva sua própria distribuição `F_i`; nenhuma simetria é
  imposta.
- Weak payoffs continuam indexados por identidade.
- Payoffs e outcomes são derivados conjuntamente do mesmo perfil `(F_i)`, sem
  recombinação de marginais.

## Testes adversariais do verifier

Foram rejeitadas:

- reintrodução literal da falsa analogia em `nu=0`;
- paráfrase da falsa analogia;
- contradição anexada ao final da derivação;
- reversão coordenada da explicação dos endpoints;
- definição coordenada de `R_i(0)` com aceitação exclusiva do tipo alto;
- desconto duplo;
- destruição de `y` quando `H` é não pivotal;
- imposição de simetria entre `F_i`;
- eliminação de delay e slack em `D=0`;
- importação de N2.

Após neutralizar somente a primeira barreira canônica em memória, as
verificações restantes ainda rejeitaram a falsa definição de `R_i(0)`, a frase
simétrica antiga, desconto incorreto, remoção do corner `D=0` e eliminação das
estratégias de tipos com prior zero. A validação, portanto, não depende
exclusivamente do pinning.

## Findings

Nenhum finding remanescente.

- critical: `0`
- major: `0`
- minor: `0`

## Veredicto

**PASS**

Hash aprovado:

`561026969956396dbcc8ee9015eb01eb839976385b3503332d9c6744b2fd951b`
