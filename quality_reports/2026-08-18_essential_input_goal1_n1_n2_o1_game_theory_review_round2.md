## Parecer adversarial — Round 2

- `reviewer_role=game_theory`
- `reviewer_id=review-n1-n2-o1-game-2026-08-18-r2`
- Escopo: N1 e N2, candidatos inalterados, novos verificadores.
- Nenhum arquivo foi editado pelo revisor.

### Identidade confirmada

| Artefato | SHA-256 |
|---|---|
| N1 | `af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd` |
| Verificador N1 | `a1a3a05f48bcecb38d503b4f8ff51275cc4ccf12dd7cb84d18a28049d7788a31` |
| N2 | `32a2989f806af20b2557fa8f495dfbe661ac951be59ee68e583fd50735e486ed` |
| Verificador N2 | `5bc16794dfa05d7184c0f2ff5eb998d1a97519b8d2d8836c5caa0b31e72ebfd6` |

## N1 — R2 maioria

### Reconfirmação matemática

A solução continua correta:

- `sim` domina fracamente `não` para weak nonproposer quando `x_j>0`;
- em `x_j=0`, há indiferença genuína e `T^Y` seleciona `sim`;
- os `m=N-1` votos fracos satisfazem `m>=q`;
- `H` é não pivotal e prefere estritamente `não`, pois recebe `y+o_theta` em
  vez de `y`;
- o proponente escolhe unicamente `y=0`, todos os `x_j=0`, `r_i=1`;
- P0, P5 e P6 estão satisfeitos;
- payoffs: proponente `1`, weak state pré-reconhecimento `1/m`,
  `H=(o_0,o_1)`;
- nenhuma expressão contém desconto interno;
- estratégia, payoff e outcome são únicos; somente crenças off-path arbitrárias
  geram multiplicidade de assessments;
- a restrição `o_1<1` é inócua para N1.

Não encontrei erro na derivação, interface ou ledger atuais.

### Mutações do round 1

O novo verificador rejeitou corretamente:

- contradição anexada a `existence_uniqueness_status`;
- contradição anexada a `selection_status`;
- restrição em pontos de massa zero de suporte atomless;
- posterior on-path contraditório apesar da substring “by Bayes”;
- campo adicional de proposer mixing;
- falso claim N1-C10 no ledger.

### Finding N1-R2-MINOR-01

> O exact matching pode ser contornado pelo campo obrigatório
> `assumptions_used`, cujo conteúdo não é validado. O verificador aceitou tanto
> `At nu=1 arbitrary atomless proposer mixtures over slack packages are
> admissible and survive.` quanto `The admissible primitive domain includes
> o_1=1.` acrescentados a esse campo. Assim, uma interface pode contradizer
> simultaneamente sua unicidade e seu domínio primitivo e ainda obter PASS
> executável.

A correção do round 1 foi efetiva nos campos então identificados, mas não
fechou todo o registro atômico.

- Critical: `0`
- Major: `0`
- Minor: `1`
- Veredicto N1: **FAIL**

## N2 — R2 unanimidade

### Reconfirmação matemática

A solução permanece correta:

- todos os weak nonproposers votam `sim`;
- `H(theta)` vota `sim` exatamente quando `y>=o_theta`, com `T^Y` na igualdade;
- os candidatos exaustivos são `S(nu)=(1-nu)(1-o_0)` em `y=o_0` e
  `P=1-o_1` em `y=o_1`;
- `nu_star=(o_1-o_0)/(1-o_0)` pertence estritamente a `(0,1)`;
- screening é selecionado para `nu<=nu_star`, inclusive na igualdade pelo
  tie-break de proposta;
- pooling é único para `nu>nu_star`;
- em `nu=1`, `1-o_1>0` torna pooling estritamente superior a toda rejeição,
  folga ou pagamento fraco positivo;
- nenhuma mistura substantiva de propostas sobrevive;
- somente crenças off-path payoff-irrelevantes permanecem múltiplas;
- P0, P5, P6, endpoints, ausência de `beta`, execução integral de `y` e
  cobertura das duas células estão corretos.

Logo, `o_1<1` remove integralmente a multiplicidade degenerada de
proposta/outcome/payoff do corner antigo de N2, sem restringir posterior igual a
um. Não remove — nem deveria remover — a multiplicidade residual de crenças
off-path.

### Mutações do round 1

O novo verificador rejeitou corretamente:

- contradições anexadas a unicidade e seleção;
- crença off-path restringindo pontos atomless;
- contradição on-path de Bayes;
- proposer mixing acrescentado à estratégia;
- falso claim de sobrevivência do corner no ledger;
- terceira célula degenerada, domínio `[0,1)` e reintrodução direta de
  `o_1=1`.

### Finding N2-R2-MINOR-01

> O exact matching não cobre todos os campos obrigatórios do registro. O
> verificador aceitou: (i) em `assumptions_used`, `At nu=1 arbitrary atomless
> proposer mixtures over slack packages are admissible and survive.`; (ii) em
> `checks_performed`, `Verified that the former degenerate mixed family survives
> at nu=1.`; e (iii) em `branch_classification`, `pooling plus arbitrary
> atomless mixtures over slack proposals at nu=1`. Além disso, embora a
> substring literal `o_1=1` seja bloqueada, a formulação semanticamente idêntica
> `The admissible primitive domain includes the equality o_1 equals 1.` foi
> aceita em `assumptions_used`. Portanto, a denylist textual e os equality
> checks podem ser contornados sem alterar os campos já protegidos.

A interface atual não contém essas contradições; o problema continua restrito à
cobertura do gate automatizado.

- Critical: `0`
- Major: `0`
- Minor: `1`
- Veredicto N2: **FAIL**

## Execuções

- Gate 0: `PASS`.
- Verificador N1: exit `0`, hash N1 reproduzido.
- Verificador N2: exit `0`, hash N2 reproduzido.
- Todas as mutações foram realizadas somente em memória.
- Todos os findings do round 1 foram diretamente cobertos e rejeitados.
- Os novos bypasses acima foram aceitos.

## Veredicto final por hash

- N1 `af128d…34fd`: **FAIL — 0 critical / 0 major / 1 minor**
- N2 `32a298…86ed`: **FAIL — 0 critical / 0 major / 1 minor**

Os candidatos continuam matematicamente aptos, mas não podem receber PASS
estrito enquanto os verificadores aceitarem contradições nos demais campos
atômicos.
