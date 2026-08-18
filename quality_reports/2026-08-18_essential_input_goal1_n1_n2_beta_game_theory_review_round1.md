## Parecer independente — primeira fronteira `beta<1`

- `reviewer_role=game_theory`
- `reviewer_id=review-n1-n2-beta-game-2026-08-18-r1`
- Modo: read-only; nenhum arquivo editado
- Fonte normativa exclusiva: contrato SHA-256 `2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- DAG confirmado: `740d0945ac2ee845331a75b7a0e5af1d49d2cc13a0c00dce98a386d8ff69fd21`
- Gate 0 R4: PASS
- Estado ao vivo: `N1`, `N2`, `N3`, `N4`, `N6` e `N7` permanecem `pending`, com `correspondence_cells=null`.

## N1 — R2 sob maioria

**Hash auditado:** `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`

### Reconstrução independente

Para toda proposta factível:

1. Um weak nonproposer pivotal compara `x_j` sob sim com zero sob não. Se `x_j>0`, não é fracamente dominado; se `x_j=0`, as ações são genuinamente indiferentes e `T^Y` seleciona sim.
2. Todos os weak nonproposers votam sim. Proponente mais `m-1` weak nonproposers fornecem `m>=q` votos, portanto `H` não é pivotal.
3. `H` compara `y` ao votar sim com `y+o_theta` ao votar não. Como `o_theta>0`, ambos os tipos votam estritamente não.
4. A proposta passa sem `H`. O proponente maximiza `r_i` escolhendo unicamente `y=0`, todos os `x_j=0` e `r_i=1`.
5. Payoffs: proponente reconhecido `1`; weak state antes do reconhecimento `1/m`; `H` recebe `(o_0,o_1)`. A distribuição é passagem sem `H` com probabilidade um.
6. R2 é terminal: não há `beta` interno. Restringir `beta` a `(0,1)` não altera estratégia, payoff, resultado ou multiplicidade.
7. O posterior de entrada é suficiente. Bayes preserva `nu` na proposta on-path; após cada proposta de probabilidade zero, `kappa(s)` permanece arbitrária em `[0,1]`, inclusive em pontos de massa zero. A única multiplicidade é de crenças off-path sem efeito sobre payoff.

O candidato, derivação e ledger coincidem integralmente com essa reconstrução. P0, P5 e P6 estão demonstrados, sem impor igualdade de factibilidade como primitiva e sem aplicar stage-undominance a `H`.

### Verificação adversarial

O verificador SHA-256 `ba0a4e332e0cb87f029a2e6fc4d582bacaffb3d6a19ca7586eb583329cce7f6c` terminou com PASS.

Com as barreiras canônicas neutralizadas em memória, foram rejeitadas mutações de:

- domínio de `beta` e de `o_1`;
- proposta com slack;
- votos weak e de `H`;
- restrição das crenças off-path;
- outcome e payoff;
- introdução de `beta` interno;
- proposal mixing/campo aninhado;
- claims falsos, status de claim e campo extra no ledger;
- promoção prematura do lifecycle.

### Findings N1

Nenhum.

**Contagens:** critical `0`; major `0`; minor `0`.

**Veredicto N1:** **PASS** no hash `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`.

## N2 — R2 sob unanimidade

**Hash auditado:** `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`

### Reconstrução independente

1. Todos os weak nonproposers votam sim pela mesma combinação de stage-undominance para `x_j>0` e `T^Y` na indiferença genuína `x_j=0`.
2. `H` é pivotal e o tipo `theta` vota sim se e somente se `y>=o_theta`; a igualdade é aceita por `T^Y`.
3. O payoff máximo do proponente em cada região é:

   - `y<o_0`: `0`;
   - `o_0<=y<o_1`: `(1-nu)(1-y)`;
   - `y>=o_1`: `1-y`.

   Logo, os únicos candidatos são `y=o_0`, com valor `(1-nu)(1-o_0)`, e `y=o_1`, com valor `1-o_1`.

4. A fronteira é `nu_star=(o_1-o_0)/(1-o_0)`, estritamente entre zero e um. A proposta low-type-only vence para `nu<nu_star`; pooling vence para `nu>nu_star`.
5. Em `nu=nu_star`, os payoffs do proponente empatam. A oferta `o_0` dá a `H` payoff esperado `(1-nu_star)o_0+nu_star o_1<o_1`; portanto o tie-break de propostas seleciona low-type-only.
6. Os endpoints estão corretos: `nu=0` pertence ao primeiro registro e `nu=1` ao pooling.
7. `o_1<1` elimina a degeneração relevante do antigo corner `o_1=1,nu=1`: agora pooling rende `1-o_1>0`, enquanto toda proposta rejeitada rende zero. Não aparece nova multiplicidade de propostas, slack ou mixing.
8. Ambos os registros usam integralmente a pie e zeram todos os `x_j`. Não há passagem sem `H` nem delay.
9. R2 não contém `beta`; a nova restrição `beta<1` apenas remove o endpoint paramétrico e não muda a correspondência terminal.
10. Crenças são irrestritas depois de cada proposta de probabilidade zero e não afetam votos ou desvios. Estratégias de tipos com prior zero continuam completamente especificadas.

O candidato representa exatamente as duas células, inclusive outcomes, payoffs condicionais de `H`, valor weak pré-reconhecimento, fronteira fechada do lado low-type-only e multiplicidade apenas de crenças off-path.

### Verificação adversarial

O verificador SHA-256 `1c6e77f0e53e4801269465cf7d28eae2e0e54a823e59645e67e5c75a447ae22f` terminou com PASS e reportou rejeição de mutações em 105 campos da interface e 135 campos do ledger.

Com hash e igualdade canônica neutralizados em memória, a camada substantiva ainda rejeitou mutações de:

- domínios `beta` e `o_1`;
- proposta com slack;
- votos weak e cutoff estrito incorreto de `H`;
- restrição de crenças off-path;
- alocação incorreta da igualdade em `nu_star`;
- outcome e payoff;
- inserção de `beta`;
- claims falsos e lifecycle prematuro.

Uma chave aninhada puramente adicional depende da guarda de identidade canônica para rejeição. Isso não constitui bypass do verificador ativo: a alteração muda o hash e o objeto exato, sendo rejeitada antes da validação substantiva. Nenhuma mutação coordenada dos campos matemáticos ou de lifecycle passou.

### Findings N2

Nenhum.

**Contagens:** critical `0`; major `0`; minor `0`.

**Veredicto N2:** **PASS** no hash `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`.

## Conclusão

A primeira fronteira sob `0<beta<1` está matematicamente correta nos dois hashes auditados. N1 e N2 são terminais e invariantes à exclusão de `beta=1`; `o_1<1` regulariza exatamente a multiplicidade substantiva do corner terminal de N2, sem restringir `nu=1` nem criar ausência de equilíbrio. Os nós devem continuar `pending` até a segunda revisão independente e a integração formal no DAG.
