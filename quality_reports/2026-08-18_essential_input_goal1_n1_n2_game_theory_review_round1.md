## Parecer independente

`reviewer_role=game_theory`  
`reviewer_id=review-n1-n2-game-2026-08-18`  
Modo: read-only; nenhum arquivo alterado; nenhum subagente utilizado.

### Resultado executivo

| Nó | Hash confirmado | Veredicto | Critical | Major | Minor |
|---|---|---:|---:|---:|---:|
| N1 | `bfe56e486098589b10724d6dbd7889eaf1ead087443717c96b6a1f45bd498c9d` | **PASS** | 0 | 0 | 0 |
| N2 | `9dc0fbf82903648fe574373cfe0280f29168e017de0c53ec32fd298f2be66da5` | **FAIL** | 0 | 1 | 1 |

O núcleo matemático de N1 e N2 foi confirmado. N2 falha no hash corrente por uma incompletude da correspondência de crenças no corner misto e por cobertura insuficiente do verificador.

### Execução

- Gate 0 canônico: exit `0`, PASS.
- Verificador N1: exit `0`, hash esperado, PASS.
- Verificador N2: exit `0`, hash esperado, PASS.
- Auditoria independente adicional: `1.010` células parâmetro-crença e `N=3,...,50`, sem divergência nas fórmulas, fronteiras ou pivotalidade.

## N1 — R2 maioria

A reconstrução independente confirma:

1. Para cada weak nonproposer:

   - se `x_j>0`, `sim` domina fracamente `não`, com desigualdade estrita no perfil pivotal;
   - se `x_j=0`, as ações são idênticas contra todo perfil, e somente então `T^Y` seleciona `sim`.

2. Os `N-1` weak states votam `sim`; como `N-1 >= floor(N/2)+1` para todo `N>=3`, `H` é não pivotal.

3. Para cada tipo de `H`:

   - `sim` produz `y`;
   - `não` produz `y+o_theta`;
   - como `o_theta>0`, PBE exige `não` estritamente. Stage-undominance não é aplicado a `H`, e `T^Y` não é acionado.

4. Toda proposta passa sem `H`; o proponente maximiza `r_i`. A proposta única é `y=0`, todos os `x_j=0`, `r_i=1`. Folga não sobrevive, confirmando P0.

5. Desvios por qualquer proposta factível foram cobertos: recebem exatamente `r_i<=1`. Crenças off-path não alteram votos nem payoffs.

6. P5, P6, ausência de `beta`, payoff de `H=(o_0,o_1)`, valor weak pré-reconhecimento `1/m` e distribuição de outcomes estão corretos.

7. Interface e ledger preservam atomicamente estratégia, crenças, payoff e outcome. Os 14 testes negativos de interface e o teste negativo do ledger são proporcionais aos claims centrais.

**N1: PASS 0/0/0.**

## N2 — R2 unanimidade

A reconstrução independente confirma o núcleo:

1. Todo weak nonproposer vota `sim`:

   - `x_j>0`: `sim` domina fracamente;
   - `x_j=0`: indiferença genuína global e `T^Y`.

2. `H` é pivotal e, por PBE, o tipo `theta` vota `sim` exatamente quando `y>=o_theta`; `T^Y` opera apenas em `y=o_theta`.

3. Com `x_j=0`, o problema completo do proponente é:

   - `y<o_0`: `0`;
   - `o_0<=y<o_1`: `(1-nu)(1-y)`;
   - `y>=o_1`: `1-y`.

4. Os únicos candidatos regulares são `y=o_0` e `y=o_1`. Com  
   `nu_star=(o_1-o_0)/(1-o_0)`:

   - `nu<nu_star`: oferta `o_0`;
   - `nu=nu_star`, `o_1<1`: o tie-break de proposta seleciona `o_0`;
   - `nu>nu_star`: oferta `o_1`.

5. P0 está correto nos ramos regulares. No corner `o_1=nu=1`, toda proposta factível dá zero ao proponente e um a `H`; portanto toda proposta pura e toda mistura `F` sobrevivem, inclusive propostas com folga.

6. As três células são mutuamente exclusivas e exaustivas. Não há passagem sem `H`, atraso ou `beta` interno.

### Findings exatos

**N2-GT-01 — Major**

> A célula `N2-EQ-DEGENERATE-CORNER-FAMILY` não representa a correspondência completa de assessments que ela afirma representar. Ela admite qualquer distribuição `F`, inclusive atomless, mas fixa crença igual a 1 “after every proposal in the support of F” e permite crença arbitrária apenas fora do suporte. Sob uma `F` atomless, cada proposta individual no suporte tem probabilidade zero. A Seção 5 do contrato determina que a crença após toda proposta de probabilidade zero é explícita e não restringida por Bayes. Portanto, existem assessments admissíveis com crenças arbitrárias em pontos de probabilidade zero pertencentes ao suporte que o registro exclui. Como crenças, estratégia, payoff e outcome devem permanecer no mesmo registro atômico, o hash corrente não contém a correspondência completa exigida.

Local: [essential_input_n2_r2_unanimity_interface.json](/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion/model_redesign/essential_input_n2_r2_unanimity_interface.json:132), especialmente linhas 141–146. A falha não altera os payoffs ou outcomes, mas viola a completude do objeto de equilíbrio.

**N2-GT-02 — Minor**

> `verify_essential_input_n2.R` pode retornar PASS para corrupções substantivas da interface. O validador não examina o conteúdo de `domain_conditions`, não confirma as propostas regulares `y=o_0` e `y=o_1`, não verifica nenhum `belief_system`, aceita qualquer texto contendo `y >=` para o cutoff do tipo alto e não confere os payoffs regulares de `H`. Os cinco fixtures negativos cobrem campo ausente, passagem sem H, continuação espúria, beta e supressão da multiplicidade do corner, mas não cobrem a partição, as estratégias regulares ou a falha de crenças identificada acima. Assim, o exit `0` não valida integralmente a correspondência que a mensagem final do script declara validada.

Local: [verify_essential_input_n2.R](/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion/scripts/verify_essential_input_n2.R:101), com fixtures negativos nas linhas 394–414.

**N2: FAIL 0/1/1.** O mesmo hash não pode ser congelado; qualquer correção gera novo hash e exige os dois novos pareceres.
