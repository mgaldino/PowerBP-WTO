# Parecer adversarial N3 — ciclo exclusivo

`reviewer_role=game_theory`  
`reviewer_id=review-n3-o1-game-2026-08-18-r1`

## Escopo e evidência

Auditoria estritamente read-only. A reconstrução foi feita antes da leitura do
candidato, usando somente o contrato vigente e N1 congelado. N2 não foi usado.

Hashes confirmados ao vivo:

- Contrato: `7b52f332aff353bf54a36992b0944ab3ff016a1c90e56a05e4853d26d92dab82`
- Dependência N1: `af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd`
- Candidato N3: `561026969956396dbcc8ee9015eb01eb839976385b3503332d9c6744b2fd951b`
- Verifier N3: `52d24ce2446f0bd14aa322f8bb111b71281e36765004fa1bbeab82ed37c68cfe`
- Derivação N3: `c34ce53da4da3964c796b33101f3cf1d3b00529b34fe96d4d014b6fd1a762160`
- Ledger N3: `e54a575f646e756cc8baba814b1395d588ae19bf5ea5c705a257fc716edd8cb7`

Gate 0 passou. N1 está `pass/frozen` no hash correto; N3 permanece `pending`,
com interface nula no DAG.

## Reconstrução independente

Definindo:

- `w=beta/m`;
- `t_theta=beta*o_theta`;
- `E=1-(q-1)w`;
- `L=1-(q-2)w-t_0`;
- `P=1-(q-2)w-t_1`;
- `S(nu)=(1-nu)L+nu*w`;
- `D=E-w=1-qw>=0`.

### Ballot dos weak nonproposers

Contra todo vetor dos demais votos:

- `x_j>w`: sim domina fracamente não;
- `x_j<w`: não domina fracamente sim;
- `x_j=w`: as ações são idênticas em todas as contingências e `T^Y` seleciona
  sim.

Logo, o cutoff correto é `sim` se e somente se `x_j>=w`. A continuação usa N1
uma única vez; histórias de votos diferentes não alteram o valor `w`.

### Ballot de H

Se `k` é o número de weak nonproposers com `x_j>=w`:

- `k>=q-1`: `H` é não pivotal. Sim paga `y`; não paga `y+o_theta`. Ambos os
  tipos votam não estritamente.
- `k=q-2`: `H` é pivotal. O tipo `theta` vota sim se e somente se
  `y>=t_theta`; `T^Y` opera apenas na igualdade.
- `k<=q-3`: a proposta falha com qualquer voto. Ambos os votos geram
  `t_theta`, e `T^Y` seleciona sim.

Stage-undominance é aplicado apenas aos weak nonproposers. A resposta de `H`
decorre de PBE e `T^Y`.

### Payoff por proposta

O mapa completo correto é:

- `k>=q-1`: payoff do proponente `r_i`;
- `k=q-2`: `(1-nu)[r_i se y>=t_0; w caso contrário] + nu[r_i se y>=t_1; w caso contrário]`;
- `k<=q-3`: `w`.

Isso incorpora cada vetor relevante, desvios off-path e o prior verdadeiro do
proponente.

### Redução E/S/P/R e P0–P2

- Exclusão `E`: `q-1` pagamentos de `w`, `y=0`, residual `E`.
- Screening `S`: `q-2` pagamentos de `w`, `y=t_0`, residual `L`.
- Pooling `P`: `q-2` pagamentos de `w`, `y=t_1`, residual `P`.
- Rejeição `R`: qualquer proposta que falha para todos os tipos com prior
  positivo; payoff `w`.

P0 é correto: propostas aprovadas ótimas usam a pie integralmente. Slack só pode
sobreviver em `R` quando `D=0` e rejeição pertence ao argmax.

P1 também é correto. Toda aprovação sem `H` com `y>0` é estritamente dominada
por manter os mesmos pagamentos fracos, substituir `y` por zero e acrescentar
`y` a `r_i`. Crenças off-path não afetam o desvio. Consequentemente, P1a
elimina aprovação on-path sem `H` com `y>0`, preservando exclusão com `y=0`.

As diferenças centrais são:

- `P-E=beta*(1/m-o_1)`;
- `S-E=(1-nu)beta*(1/m-o_0)-nu*D`.

As fronteiras estritas e de igualdade da interface estão corretas:

- `o_1<1/m`: screening até `nu_SP`, inclusive pelo tie-break, e pooling acima;
- `o_0<1/m<o_1`, `D>0`: screening abaixo de `nu_SE`, exclusão acima; na
  igualdade, screening se `beta<1`, e screening mais exclusão se `beta=1`;
- `o_0>1/m`, `D>0`: exclusão;
- `o_0=1/m<o_1`: tratamento correto de `nu=0`;
- `o_0<o_1=1/m`: tratamento correto do empate `E=P` pelo payoff esperado de
  `H`.

### Delay, slack e `D=0`

`D=0` ocorre exatamente quando `beta=1` e `q=m`, isto é, `N` é 3 ou 4.
Rejeição é selecionada exatamente quando:

`D=0`, `o_1>=1/m` e `[nu=1 ou o_0>=1/m]`.

Portanto, `o_1<1` não elimina esse corner. Delay, slack e misturas entre
propostas empatadas permanecem corretamente na correspondência. Uma checagem
independente de 50.000 combinações de primitivas não encontrou contraexemplo a
essa condição.

### Misturas, identidades e atomicidade

Cada proponente pode usar sua própria distribuição `F_i` sobre o argmax após o
tie-break. Não há fundamento para impor `F_i=F_j`. A interface preserva:

- diferentes coalizões compradas;
- misturas entre propostas empatadas;
- weak payoffs indexados pela identidade;
- payoffs de `H`, outcomes e delay derivados da mesma família conjunta `(F_i)`.

Não há recombinação indevida de projeções marginais.

### Crenças, P7 e endpoints

Propostas com massa positiva preservam `nu` por Bayes porque o weak proposer não
observa `theta`. O tratamento contratual de propostas individuais de massa
zero, inclusive em suporte atomless, é explicitado. O voto público de `H` entra
na atualização; no screening interior, o não do tipo alto revela `theta=1`.

Nos endpoints, ambos os tipos continuam com estratégias e payoffs especificados.
N1 torna qualquer posterior de continuação payoff-irrelevante. `beta` entra
exatamente uma vez por meio de `w` e `t_theta`.

## Auditoria do verifier

O verifier oficial passou e rejeitou mutações em todos os 87 campos nomeados da
interface e nas sete colunas do ledger.

Mutações coordenadas rejeitadas incluíram desconto duplo, imposição de simetria
entre `F_i`, remoção de `R`, delay e slack, eliminação de tipos com prior zero,
restrição de crenças em suporte atomless, importação de N2, inversão das
fronteiras, fórmulas algebricamente reescritas, ledger falso e lifecycle
prematuramente alterado.

Neutralizando somente a primeira barreira canônica em memória, as validações
matemáticas restantes ainda rejeitaram violações de P0, P1, P6, P7, `D=0`,
payoffs identity-indexed, desconto e sinal das fronteiras. Portanto, o script
não depende apenas do hash pinning.

## Finding

### N3-GT-01 — simetria falsa entre endpoints de prior zero

**Severidade:** minor

Texto exato da derivação:

> “Essa família pode conter propostas com folga. Em `nu=1`, também pode conter
> propostas que o tipo baixo de probabilidade zero aceitaria; em `nu=0`, o
> análogo vale para o tipo alto.”

A primeira parte é correta: em `nu=1`, uma proposta com `k=q-2` e
`t_0<=y<t_1` falha para o tipo alto no suporte, embora o tipo baixo de prior zero
aceitasse.

O suposto análogo em `nu=0` é impossível. Como `t_0<t_1`, se o tipo alto aceita,
então o tipo baixo necessariamente também aceita. Mais diretamente, uma
proposta de `R_i(0)` tem:

- `k<=q-3`, caso em que nenhum tipo pode produzir aprovação; ou
- `k=q-2` e `y<t_0<t_1`, caso em que ambos os tipos rejeitam.

A definição formal de `R_i(nu)` na interface está correta, assim como as
fórmulas, fronteiras e correspondência. O erro está confinado à afirmação
explicativa da derivação e não altera o objeto JSON. O verifier não testa essa
assimetria direcional dos tipos e, por isso, não detecta a frase falsa.

## Contagens e veredicto

- critical: `0`
- major: `0`
- minor: `1`

**Veredicto estrito:** `FAIL`  
**Hash revisado:** `561026969956396dbcc8ee9015eb01eb839976385b3503332d9c6744b2fd951b`

O `PASS` operacional do verifier não supera o finding substantivo do parecer;
o requisito para aprovação é `0/0/0`.
