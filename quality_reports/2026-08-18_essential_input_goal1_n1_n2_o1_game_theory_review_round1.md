## Parecer independente — Goal 1, primeira fronteira

- `reviewer_role=game_theory`
- `reviewer_id=review-n1-n2-o1-game-2026-08-18`
- Escopo: N1 e N2 sob `o_1<1`
- Método: reconstrução integral antes da leitura dos candidatos; ciclo antigo
  usado apenas para orientar mutation tests, nunca como fonte matemática.
- Nenhum arquivo foi editado pelo revisor.

### Veredictos

| Nó | SHA-256 confirmado | Critical | Major | Minor | Veredicto |
|---|---|---:|---:|---:|---|
| N1 | `af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd` | 0 | 0 | 1 | **FAIL** |
| N2 | `32a2989f806af20b2557fa8f495dfbe661ac951be59ee68e583fd50735e486ed` | 0 | 0 | 1 | **FAIL** |

Os dois candidatos estão matematicamente corretos. O FAIL estrito decorre
exclusivamente de lacunas demonstradas nos verificadores.

## N1 — R2 sob maioria

### Reconstrução independente

Para qualquer proposta:

1. Se `x_j>0`, `sim` domina fracamente `não` para cada weak nonproposer, pois
   existe perfil no qual `j` é pivotal.
2. Se `x_j=0`, as ações são idênticas contra todos os perfis; `T^Y` seleciona
   `sim`.
3. Portanto, proponente mais `m-1` weak nonproposers fornecem `m=N-1>=q` votos.
4. `H` é não pivotal. `sim` paga `y`, enquanto `não` paga `y+o_theta`; como
   `o_theta>0`, ambos os tipos votam estritamente `não`.
5. Toda proposta passa sem `H`. O proponente maximiza `r_i`, produzindo o
   argmax único: `y=0`, todos os `x_j=0`, `r_i=1`.

Consequências:

- P0: uso integral da pie, sem proposta ótima com folga.
- Payoff do proponente reconhecido: `1`.
- Valor fraco pré-reconhecimento: `1/m`.
- Payoff de `H`: `(o_0,o_1)`.
- Aprovação sem `H` com probabilidade um.
- Nenhum `beta` em R2.
- Bayes mantém `nu` no caminho; crenças após propostas de probabilidade zero são
  arbitrárias e payoff-irrelevantes.
- A estratégia, outcome e payoff são únicos; apenas as crenças off-path geram
  multiplicidade de assessments.
- Histórias com o mesmo posterior induzem o mesmo problema, satisfazendo P5.
- A restrição `o_1<1` não altera a solução de N1.

A derivação, interface e ledger reproduzem corretamente toda essa reconstrução.

### Finding N1-MINOR-01 — verificador aceita contradições em unicidade e ledger

> `scripts/verify_essential_input_n1.R` não valida integralmente a semântica de
> `existence_uniqueness_status` nem o conteúdo dos claims do ledger. Em
> mutações realizadas somente em memória, o validador aceitou acrescentar
> `arbitrary proposer mixtures also survive` ao campo que declara unicidade e
> também aceitou substituir N1-C10 por `Restricting to o_1<1 changes the N1
> strategy and payoff correspondence.`. Assim, seu exit zero não certifica
> sozinho correspondence completeness nem a invariância registrada no ledger,
> embora o candidato atual esteja correto.

Severidade: **minor**. A falha é de cobertura executável, não da solução
game-theoretic atual.

## N2 — R2 sob unanimidade

### Reconstrução independente

Todos os weak nonproposers votam `sim` após toda proposta, pela mesma separação
entre dominância quando `x_j>0` e `T^Y` quando `x_j=0`. `H` é pivotal e vota
`sim` se e somente se `y>=o_theta`.

Logo, o proponente compara:

- rejeição de ambos: `0`;
- passagem apenas com o tipo baixo em `y=o_0`: `S(nu)=(1-nu)(1-o_0)`;
- pooling em `y=o_1`: `P=1-o_1`.

O cutoff é `nu_star=(o_1-o_0)/(1-o_0)`, com `0<nu_star<1`. Portanto:

- `0<=nu<nu_star`: oferta `o_0`;
- `nu=nu_star`: `o_0` e `o_1` empatam para o proponente, mas o tie-break
  seleciona `o_0`, que dá payoff esperado estritamente menor a `H`;
- `nu_star<nu<=1`: oferta `o_1`.

Em ambos os regimes, todos os `x_j` são zero e a pie é integralmente usada. Os
endpoints estão corretos. Não há passagem sem `H`, delay ou `beta`. P0, P5 e P6
estão satisfeitos. As crenças off-path permanecem arbitrárias e
payoff-irrelevantes.

### Efeito exato de `o_1<1`

No antigo ponto `o_1=1,nu=1`, toda proposta rejeitada e a proposta aceita
`y=1` davam payoff zero ao proponente. Consequentemente, toda ação de proposta
factível — e qualquer mistura — era ótima.

Com `o_1<1`, `y=o_1` rende `1-o_1>0`; toda proposta rejeitada rende zero e
oferta acima de `o_1`, pagamento positivo a weak state ou folga reduz o payoff.
O pacote pooling integral é o único argmax em `nu=1`. Assim, a restrição remove
toda a multiplicidade degenerada de proposta, outcome e payoff daquele corner,
preservando apenas multiplicidade rotineira de crenças off-path.

A derivação, interface e ledger atuais representam corretamente esse resultado.

### Finding N2-MINOR-01 — finding antigo ainda pode ser reintroduzido semanticamente

> `scripts/verify_essential_input_n2.R` rejeita domínio fraco, terceira célula
> degenerada, restrição indevida de crenças e mutações das estratégias
> estruturadas, mas não valida a semântica dos campos obrigatórios de
> unicidade/seleção nem dos claims atômicos. Em memória, foram aceitas três
> mutações centrais: `Exists. At nu=1 arbitrary mixed proposer strategies and
> slack packages also survive.` em `existence_uniqueness_status`; a mesma
> conclusão contraditória acrescentada a `selection_status`; e N2-CLM-007
> alterado para afirmar que a família `o_1=1` sobrevive em `o_1<1,nu=1`.
> Isso permite que o finding antigo sobre misturas seja reintroduzido nos
> próprios campos destinados a registrar sua exclusão, mantendo o verificador
> em PASS.

Severidade: **minor**. A estrutura matemática atual exclui corretamente o
corner; a insuficiência está no gate automatizado.

## Execuções

- Gate 0: `PASS`.
- Verificadores N1 e N2: exit `0`, hashes reproduzidos.
- Mutation tests adicionais, exclusivamente em memória:
  - N1, contradição sobre mistura: `ACCEPTED`.
  - N1, falso claim C10: `ACCEPTED`.
  - N2, contradição sobre unicidade: `ACCEPTED`.
  - N2, contradição sobre seleção: `ACCEPTED`.
  - N2, falso claim sobre o antigo corner: `ACCEPTED`.

## Conclusão

N1 e N2 passam a auditoria matemática, mas nenhum dos hashes pode receber PASS
estrito enquanto seu respectivo verificador aceitar as mutações documentadas.

- N1: **FAIL — 0/0/1**
- N2: **FAIL — 0/0/1**
