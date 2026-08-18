## Parecer independente — N3 R1-majority, round 2

`reviewer_role=formal_design`  
`reviewer_id=review-n3-o1-formal-2026-08-18-r2`

### Veredicto

**PASS** no artefato exato:

`sha256:561026969956396dbcc8ee9015eb01eb839976385b3503332d9c6744b2fd951b`

Contagens:

- critical: **0**
- major: **0**
- minor: **0**

### Proveniência confirmada ao vivo

| Artefato | SHA-256 |
|---|---|
| Contrato normativo | `7b52f332aff353bf54a36992b0944ab3ff016a1c90e56a05e4853d26d92dab82` |
| N1 congelado, única dependência substantiva | `af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd` |
| Derivação N3 corrigida | `4aca972699bbe11aa275fc04ec62ccedda2ea94c74a5e7352cd61773b7fbd6a6` |
| Interface candidata N3 | `561026969956396dbcc8ee9015eb01eb839976385b3503332d9c6744b2fd951b` |
| Ledger N3 | `e54a575f646e756cc8baba814b1395d588ae19bf5ea5c705a257fc716edd8cb7` |
| Verifier N3 | `ac9f30d9f903f220f5ab6d4dadabe04333736c7c538f573131f66fbef5575cab` |
| DAG compartilhado | `2979568e25b4ee81690e569b1594be49674abe675e57c958eef95f560a0b063e` |

N2 não foi usado na reconstrução, nas fórmulas nem nos
`source_interface_hashes` de N3. A mutação que tenta introduzir N2 como
dependência é rejeitada.

## Reconstrução independente

Com `m=N-1`, quota `q=floor(N/2)+1` e continuação congelada de N1:

- valor de continuação de um weak state em R1: `w=beta/m`;
- valor de continuação de H tipo `theta`: `t_theta=beta*o_theta`;
- portanto `t_0<t_1`, pois `beta>0` e `o_0<o_1`.

Se `k` é o número de weak nonproposers que votam sim:

1. Cada weak nonproposer vota sim exatamente quando `x_j>=w`; igualdade é
   resolvida por `T^Y`.
2. Se `k>=q-1`, H não é pivotal. O acordo passa com qualquer voto de H. Votar
   sim rende `y`; votar não rende `y+o_theta`. Logo ambos os tipos votam não
   estritamente.
3. Se `k=q-2`, H é pivotal. Sim rende `y`; não produz continuação `t_theta`.
   Logo o tipo `theta` vota sim exatamente quando `y>=t_theta`, com `T^Y` na
   igualdade.
4. Se `k<=q-3`, o acordo falha independentemente do voto de H. Ambas as ações
   rendem `t_theta`; `T^Y` seleciona sim.

Isso produz corretamente, para qualquer proposta factível:

- payoff do proposer `r_i` quando `k>=q-1`;
- `(1-nu)[r_i se y>=t_0, senão w] + nu[r_i se y>=t_1, senão w]` quando
  `k=q-2`;
- `w` quando `k<=q-3`.

Não há desconto duplo: o `beta` aparece uma única vez no transporte dos payoffs
terminais de N1 para R1.

## Redução e correspondência

A redução a `E_i`, `S_i`, `P_i` e `R_i(nu)` é exaustiva:

- `E_i`: aprovação sem H, `y=0`, `q-1` weak supporters pagos em `w`;
- `S_i`: aprovação somente pelo tipo baixo, com `q-2` weak supporters e
  `y=t_0`;
- `P_i`: pooling, com `q-2` weak supporters e `y=t_1`;
- `R_i(nu)`: toda proposta que falha para cada tipo com probabilidade positiva.

Os valores canônicos estão corretos:

- `E=1-(q-1)w`;
- `L=1-(q-2)w-t_0`;
- `P=1-(q-2)w-t_1`;
- `D=E-w=1-qw`;
- `P-E=beta(1/m-o_1)`;
- `S-E=(1-nu)beta(1/m-o_0)-nu D`.

As fronteiras, igualdades e o tie-break que minimiza o payoff esperado de H
coincidem com a maximização direta. A redução não impõe rótulo como seleção:
para cada identidade `i`, `F_i` pode ser qualquer distribuição sobre o argmax
lexicográfico `A_i_star(nu)`, sem impor `F_i=F_j`. Ballots permanecem puros
mesmo quando propostas misturam.

P0, P1, P1a, P2, P6 e P7 estão preservados:

- toda proposta ótima que passa exaure a unidade;
- qualquer aprovação sem H com `y>0` é estritamente dominada pelo hedge factível
  com `y=0`;
- não há aprovação on-path sem H com `y>0`;
- slack só sobrevive endogenamente em propostas selecionadas de rejeição no
  corner `D=0`;
- stage-undominance e `T^Y` atuam em seus domínios próprios;
- o vetor público completo, inclusive o voto de H, entra na atualização.

## Endpoints de `R_i(nu)`

A correção textual é substantiva e exata:

> “Em `nu=1`, também pode conter propostas que o tipo baixo, de probabilidade
> zero, aceitaria. Em `nu=0`, não há análogo para o tipo alto: como `t_0<t_1`,
> a condição `y<t_0` de `R_i(0)` quando `H` é pivotal implica que ambos os
> tipos rejeitam.”

Verificação:

- Em `nu=1`, `R_i(1)` exige apenas falha para o tipo alto. Uma oferta pivotal
  `y` em `[t_0,t_1)` é aceita pelo tipo baixo de probabilidade zero e rejeitada
  pelo alto.
- Em `nu=0`, a falha do tipo baixo exige `y<t_0`. Como `t_0<t_1`, segue também
  `y<t_1`: ambos rejeitam. Não existe o análogo simétrico para o tipo alto de
  probabilidade zero.

A relação foi adicionalmente confirmada em **100.000** sorteios admissíveis
independentes.

O corner de delay permanece admissível sob `o_1<1`: `D=0` ocorre apenas quando
`beta=1` e `q=m`, e `R_i(nu)` é selecionado exatamente sob `D=0`,
`o_1>=1/m` e `[nu=1 ou o_0>=1/m]`. A restrição estrita não elimina slack ou
multiplicidade nesse corner.

## Beliefs, zero-prior types e atomicidade

A interface:

- aplica Bayes a propostas com massa positiva;
- atribui belief explícita irrestrita a toda proposta individual de
  probabilidade zero, inclusive pontos do suporte topológico de mistura
  atomless;
- atualiza após o vetor publicado usando o voto informativo de H;
- atribui posterior irrestrito a todo histórico proposta-vetor de probabilidade
  zero;
- mantém estratégias, outcomes e payoffs dos dois tipos em `nu=0` e `nu=1`.

O schema `equilibrium_correspondence_v1` está completo. A célula cobre todo o
domínio e conserva atomicamente payoff do proposer reconhecido, mapa de payoffs
weak por identidade, payoff de H por tipo, probabilidades separadas de passagem
com H, passagem sem H e delay, e multiplicidade de coalizão, proposta,
identidade, zero-prior type, payoff e outcome.

`failure=0` e `delay=E[I_D]` são corretos em R1: toda rejeição corrente conduz
a N1 em R2, não ao desacordo terminal imediato.

## Verificação executável e resistência a mutações

O verifier retornou PASS para P0, P1, P1a, P2, P6 e P7; endpoints e zero-prior
types; `F_i` por identidade; beliefs off path; corner `D=0`; todos os **87
campos nomeados** da interface; e todas as **7 colunas** do ledger.

O checker independente retornou `VALID`, com N3 e N4 topologicamente prontos.
O hash corrigido da derivação está explicitamente pinned pelo verifier e é
conferido antes da validação.

Também neutralizei em memória a primeira barreira de identidade canônica. Ainda
assim, foram rejeitados:

- reintrodução da frase falsa “vale para o tipo alto”;
- reintrodução de “symmetric zero-prior-high acceptance exists”;
- remoção do parágrafo que demonstra a assimetria;
- corrupção coordenada da definição de `R_i`, do tratamento de zero-prior
  types, do ledger e da derivação.

Logo, os testes não se reduzem a pinning de bytes: as barreiras semânticas
posteriores detectam a falsidade mesmo quando o objeto corrompido é
temporariamente tratado como canônico.

## Lifecycle

N3 permanece corretamente `pending`, com coleções nulas e sem hash/reviews no
DAG compartilhado. O presente parecer não autoriza alteração automática desse
estado: o congelamento exige os dois reviews independentes PASS previstos no
contrato.

## Findings

Nenhum finding critical, major ou minor. Nenhuma ambiguidade ou definição
faltante foi encontrada no hash examinado. O revisor não editou arquivos.
