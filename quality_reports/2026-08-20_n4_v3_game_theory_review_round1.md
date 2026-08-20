# Parecer independente `game_theory` — N4 v3

**Data:** 2026-08-20
**Papel:** `game_theory`
**Modo:** read-only
**Veredicto:** **FAIL**
**Findings:** `0 critical / 1 major / 0 minor / 0 epistemic`

## Objeto auditado

- Candidato: `model_redesign/essential_input_interfaces/n4_r1_unanimity_candidate_v3.json`
- SHA-256 inicial e final: `6c199f961ba2b8e1f55719c8d678decf752fb7bcda042bf796a585f2a4278905`
- Dependência N2: `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`
- Implementador e revisor são agentes distintos; o revisor não editou arquivos.

## Resultado substantivo

A rederivação independente confirmou a matemática do candidato:

- N2 é consumido corretamente, com vetores realizados `(A,0)` e `(B,B)` e desconto único.
- As classes puras on-path são exaustivamente `P`, `L` apenas em `nu=0`, e `D`; high-only e separação de H com veto weak não sobrevivem.
- Para `m>=3`, `S_3=(1-nu)B` é atingido e delay existe universalmente.
- Para `m=2`, `S_2=max{R_0,R_L,R_P}`, com os endpoints de `R_L`, delay `C>=S_2`, `H_tie`, pooling, low-only e misturas coerentes.
- Foram reproduzidos os três contraexemplos obrigatórios de v2, inclusive o caso `x=A` em que `no` domina fracamente `yes`.
- Multiplicidade por identidade, coordenadas `rho_L/rho_P/rho_D`, médias condicionais, payoffs, outcomes, Bayes e crenças off-path estão substantivamente corretos.

Clarificação não contabilizada como finding: `Q_P` pode coincidir com um payoff atingido em `x=A` quando `Q_P<=R_0`, mas `R_P` continua sendo o supremo não atingido do subproblema force-passage `x>A`. Nesse caso ele não é binder exclusivo de `S_2`; `H_tie` e a correspondência não mudam. Em `nu=nu*`, pooling pode fornecer a punição com payoff de H igual a `h`, portanto não há queda para `H_L`.

## Finding N4V3-GT-01 — major técnico: falso PASS common-mode

O oracle de ballot é independente, mas não lê a interface. A camada que deveria ligá-lo às 1.662 folhas do candidato faz sobretudo checks estruturais, presença de tokens e alguns campos selecionados, em particular em `scripts/lib_essential_input_n4_v3_semantic_validator.R` e `scripts/test_essential_input_n4_v3_common_mode.R`.

Com pins e manifestos neutralizados somente em memória, a validação aceitou com zero erros:

- corrupção coordenada de candidato e builder de `H_tie` para `h` em todos os parâmetros;
- vetor realizado low-only alterado de `(A,0)` para `(A,A)`;
- payoff weak alterado para denominador `999`;
- payoff `nu=0` alterado para `999*rho_L*bar_Y_L+...`;
- endpoint low-only alterado para excluir sempre `r=S`;
- domínio da primeira célula alterado para `m=99`;
- inversão da claim 007 do ledger.

A mutação de `H_tie` muda diretamente a correspondência: inclui pooling em regiões onde deveria inexistir no endpoint e exclui famílias quando o security é somente supremo não atingido. Portanto, hashes, duas builds reais e cobertura de paths não bastam para sustentar o PASS sem vínculo semântico independente.

O finding é `major` técnico: o requisito funcional já está determinado — ligar todas as folhas semânticas à derivação/oracle independente e acrescentar negativas common-mode dirigidas. Não requer nova escolha sobre jogo, schema ou protocolo, mas qualquer novo hash deve voltar aos dois revisores.

## Integridade e fronteira

- Gate0: PASS.
- Verificador N2: PASS.
- Verificador N4 v3: operacionalmente PASS, mas insuficiente pelo finding acima.
- Checker canônico: `VALID`, com `Ready: N3, N4`.
- Warnings isolados de locale não foram classificados como findings.
- Durante a revisão, HEAD avançou por trabalho concorrente de N3; os 12 blobs N4 permaneceram byte a byte idênticos ao commit `b4a3fab`.
- A tag protegida permaneceu em `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- N4 permanece `pending/unfrozen`; este parecer não autoriza freeze, N6 ou N7.
