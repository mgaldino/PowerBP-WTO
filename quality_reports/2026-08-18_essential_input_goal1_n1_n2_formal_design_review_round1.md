# Parecer independente — primeira fronteira do Goal 1

`reviewer_role=formal_design`  
`reviewer_id=review-n1-n2-formal-2026-08-18`

Nenhum arquivo foi editado. A reconstrução foi feita antes da leitura dos candidatos e sem transportar resultados históricos.

## N1 — R2 maioria

### Reconstrução independente

- Stage-undominance elimina `não` quando `x_j>0`; com `x_j=0`, a indiferença é genuína e `T^Y` seleciona `sim`.
- Os `N-1` votos fracos atingem `q=floor(N/2)+1` para todo `N>=3`.
- `H` é não pivotal: `sim` rende `y`; `não` rende `y+o_theta`. Como `o_theta>0`, ambos os tipos votam `não`.
- Toda proposta passa sem `H`. O proponente maximiza `r_i` com a proposta única `y=0`, todos os `x_j=0`, `r_i=1`.
- Payoffs de R2: proponente reconhecido `1`; weak state antes do reconhecimento `1/m`; `H` recebe `(o_0,o_1)`.
- Não há `beta` interno. P0, P5 e P6 estão demonstrados.
- A única multiplicidade está nas crenças off-path, corretamente preservada como payoff-irrelevante.

A derivação, a célula única, o registro atômico, o ledger e os testes negativos são aderentes ao contrato.

### Veredicto estrito

- Hash confirmado: `bfe56e486098589b10724d6dbd7889eaf1ead087443717c96b6a1f45bd498c9d`
- Verificador: exit code `0`; PASS.
- Findings: `critical=0`, `major=0`, `minor=0`
- **VEREDICTO: PASS**

## N2 — R2 unanimidade

### Reconstrução independente

Com todos os weak nonproposers votando `sim`, `H` é pivotal e o tipo `theta` aceita exatamente quando `y>=o_theta`. Definindo

`nu_star=(o_1-o_0)/(1-o_0)`,

a solução substantiva é:

- `nu<nu_star`: oferta `y=o_0`, passagem apenas com o tipo baixo;
- `nu=nu_star`, `o_1<1`: o tie-break da proposta seleciona `y=o_0`;
- `nu>nu_star`: pooling em `y=o_1`;
- `o_1=1`, `nu=1`: toda proposta factível maximiza o payoff zero do proponente; propostas com folga, aprovação em `y=1`, falha em `y<1` e misturas sobrevivem.

As fórmulas regulares, P0, P5, P6, a execução integral de `y`, o gatilho terminal de `o_theta` e a ausência de `beta` estão corretos. Entretanto, a correspondência e seu gate executável têm três findings major.

### Findings — texto exato

> **[MAJOR 1] O registro `N2-EQ-DEGENERATE-CORNER-FAMILY` não preserva a correspondência completa de crenças que afirma representar. Ele determina “Belief remains 1 after every proposal in the support of F” e permite crença arbitrária apenas “after a proposal outside the support of F”. Como `F` pode ser atomless, uma proposta pode pertencer ao suporte e ainda ter probabilidade exatamente zero. A Seção 5 do contrato torna a crença irrestrita em toda proposta de probabilidade zero. Portanto, o registro exclui assessments admissíveis, embora essa omissão seja payoff-irrelevante.**

Evidência: [interface N2](/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion/model_redesign/essential_input_n2_r2_unanimity_interface.json:139), confrontada com [contrato](/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion/quality_reports/plans/2026-08-12_essential_input_gate0.md:449).

> **[MAJOR 2] No canto degenerado, `F` não é definida como distribuição comum entre proponentes, família indexada pela identidade reconhecida `(F_i)`, ou distribuição incondicional induzida depois do sorteio de reconhecimento. A primeira leitura impõe simetria não declarada; a segunda exige que os payoffs e outcomes de `H` sejam calculados pela média das `F_i`; a terceira não especifica o strategy profile completo. Consequentemente, o registro não liga sem ambiguidade a estratégia do mesmo equilíbrio aos seus payoffs e outcomes, contrariando a atomicidade e a correspondência completa exigidas pela Seção 8.**

Evidência: [derivação N2](/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion/model_redesign/essential_input_n2_r2_unanimity_derivation.md:188) e [interface N2](/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion/model_redesign/essential_input_n2_r2_unanimity_interface.json:128), confrontadas com [contrato](/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion/quality_reports/plans/2026-08-12_essential_input_gate0.md:834). É uma ambiguidade substantiva nos termos da Seção 11.1.

> **[MAJOR 3] O verificador de N2 não constitui um gate semântico suficiente para o artefato que declara validar. O mesmo `validate_interface` usado pelos testes negativos aceitou, em auditoria read-only, uma célula com domínio substituído por `WRONG`, um payoff `theta_0` do canto degenerado substituído por `WRONG` e as probabilidades de passagem e falha do canto substituídas por `WRONG`. As checagens algébricas posteriores não leem essas coordenadas do candidato. Assim, uma interface semanticamente corrompida, acompanhada de ledger com hash atualizado, ainda poderia produzir PASS.**

Evidência: [verificador N2](/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion/scripts/verify_essential_input_n2.R:124). A auditoria produziu literalmente:

```text
MUTATION_ACCEPTED: wrong degenerate theta_0 payoff
MUTATION_ACCEPTED: wrong degenerate outcome distribution
MUTATION_ACCEPTED: wrong coverage domain
```

### Veredicto estrito

- Hash confirmado: `9dc0fbf82903648fe574373cfe0280f29168e017de0c53ec32fd298f2be66da5`
- Verificador corrente: exit code `0`; PASS, mas esse resultado não supera os findings acima.
- Findings: `critical=0`, `major=3`, `minor=0`
- **VEREDICTO: FAIL**

## Resultado consolidado

| Nó | Hash exato | Critical | Major | Minor | Veredicto |
|---|---|---:|---:|---:|---|
| N1 | `bfe56e486098589b10724d6dbd7889eaf1ead087443717c96b6a1f45bd498c9d` | 0 | 0 | 0 | **PASS** |
| N2 | `9dc0fbf82903648fe574373cfe0280f29168e017de0c53ec32fd298f2be66da5` | 0 | 3 | 0 | **FAIL** |

O verificador canônico do Gate 0 também terminou em PASS. Pelo contrato, N1 pode receber o registro `formal_design` para esse hash; N2 não pode ser congelado nem consumido por N4 enquanto os findings permanecerem.
