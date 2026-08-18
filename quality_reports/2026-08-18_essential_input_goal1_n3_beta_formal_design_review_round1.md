## Parecer independente — N3 beta<1

- `reviewer_role`: `formal_design`
- `reviewer_id`: `review-n3-beta-formal-2026-08-18-r1`
- Contrato: `sha256:2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- Dependência única N1: `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`
- Candidato N3: `sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee`
- Verifier N3: `sha256:f6586719f15aa5417e4ca05f2cbafcf9d7b07c094ef4b0dca9a637d3e9bc2ebd`
- Veredicto estrito: **FAIL**
- Findings: **critical 0 / major 1 / minor 0**

### Reconstrução e auditoria substantiva

A matemática do candidato está correta no hash examinado:

- N1 entra em R1 exatamente uma vez: `w=beta/m` para weak states e `t_theta=beta*o_theta` para `H`.
- O cutoff fraco é `sim` sse `x_j>=w`, com `T^Y` na igualdade.
- A IC completa de `H` preserva:

  - não pivotal: `sim -> y`, `não -> y+o_theta`, logo `não`;
  - pivotal: `sim` sse `y>=t_theta`;
  - falha inevitável: indiferença genuína e `T^Y -> sim`.

- `D=1-beta*q/m>0`, pois `q<=m` e `beta<1`. Logo exclusão domina estritamente rejeição deliberada; `R_i` e slack não são selecionados.
- P1 e P1a procedem: todo ramo que passa sem `H` com `y>0` é estritamente dominado pelo hedge que transfere `y` para `r_i`.
- A redução `E/S/P` é exaustiva; screening preserva corretamente o delay do tipo alto quando `nu>0`.
- As fronteiras `S/P`, `S/E`, `o_0=1/m` e `o_1=1/m`, inclusive a multiplicidade residual `E=P`, aplicam corretamente o tie-break de menor payoff esperado de `H`.
- Factibilidade, `nu=0/1`, tipos de probabilidade zero, crenças em toda história de massa zero, publicação do voto de `H`, payoffs identity-indexed por `F_i`, atomicidade e outcomes estão corretamente representados.
- N3 permanece `pending/null`; N1 está `pass/frozen`; N2 não é consumido.

### Finding exato

**[MAJOR F1]**

> “Após neutralizar somente as barreiras de pin/hash e `identical` do objeto canônico, o verificador aceita mutações substantivas e coordenadas nos campos que definem as famílias `E/S/P/R`, `A_i_star/F_i`, `assumptions_used` e os outcomes, além de mutações correspondentes de claim/branch no ledger e contradições materiais na derivação. Portanto, os testes negativos declarados como cobertura integral não constituem validação semântica independente; para esses campos, a rejeição depende apenas da identidade canônica.”

Evidência:

- A primeira barreira de `validate_candidate` é `identical(object, canonical_candidate)` em `scripts/verify_essential_input_n3.R:105-109`.
- Neutralizada essa barreira em memória, passaram **12 caminhos da interface**, incluindo todas as famílias puras, `V_star`, `H_star`, `A_i_star`, a estratégia condicional, assumptions e as probabilidades de passagem.
- Passaram **31 células do ledger**, sobretudo claims e classificações de ramo.
- Uma mutação coordenada foi aceita com:

  - `E_i` reescrito para admitir `beta=1`, `D=0`, slack e `y>0`;
  - `R_i` declarado selecionado;
  - `A_i_star` reduzido falsamente a `R_i`;
  - `F_i` degenerado em rejeição;
  - delay alterado para `0*I_D (screening never delays)`;
  - claim e branch correspondentes do ledger adulterados.

- Resultados observados:

```text
COORDINATED_CANDIDATE_ACCEPTED=TRUE
COORDINATED_LEDGER_ACCEPTED=TRUE
FALSE_DERIVATION_APPEND_ACCEPTED=TRUE
```

A severidade é major, não critical: o candidato efetivamente hash-pinado continua matematicamente correto, mas o verifier não satisfaz o ataque semântico solicitado e pode emitir PASS para corrupção material quando se remove a barreira de identidade.

### Execuções

- `Rscript scripts/verify_essential_input_n3.R`: PASS nativo.
- `Rscript scripts/verify_essential_input_n1.R`: PASS.
- `Rscript scripts/verify_essential_input_gate0.R`: PASS.
- Checker do DAG: `VALID`; prontidão topológica `N3, N4`, sem ampliar a autorização além de N3.
- `git diff --check`: PASS.
- Diff dos artefatos protegidos: vazio.
- Nenhum arquivo foi editado por este revisor.
