# N6 — auditoria de fechamento

**Data:** 2026-08-19  
**Hash da interface:** `sha256:e5a71e29720598f829beb4f720bc966a64d2b04569ded0ba404cdd03b81b3f2a`

## Estado congelado

N6 está `pass/frozen` no DAG, com dependências exatas de N3
(`sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee`)
e N4
(`sha256:ee61ce6f854d4393f51048592a5221a9999a8f3f7daca1e749e7f19a88927f2d`).
O objeto `interface` no DAG foi verificado como idêntico ao JSON N6 hashado.

Há um registro privado de majority, seis de unanimity, seis células de
comparação e seis registros de comparação; nenhuma célula `none` ocorre nas
fontes congeladas desta execução. A cobertura formal mantém `m=2` e `m>=3`.
O escopo substantivo enfatiza `m>=3` (três fracos, quatro ou mais membros). Nas
células `m>=3`, delay existe universalmente na correspondência N4, mas não é
forçado: pooling também existe. N6 preserva a correspondência set-valued e não
afirma ranking escalar de payoff ou de delay.

## Verificações

- `scripts/verify_essential_input_n6.R`: PASS; seis mutações negativas rejeitadas.
- checker do DAG com `--require-execution-order`: VALID; N7 é apenas o próximo
  nó topologicamente pronto.
- checker do DAG com `--changed N6`: VALID; N7 é invalidado como descendente.
- Gate 0 canonical verifier pós-N6: PASS. Ele fixa o contrato corrente, o DAG
  pós-N6, N1–N4/N6 `pass/frozen`, a identidade entre o objeto N6 do DAG e o JSON
  hashado, os hashes de N3/N4, os dois pareceres N6, as ordens 9/10, a prontidão
  apenas topológica de N7 e a proibição de N7/Goals 4–5.
- O verifier N4 foi atualizado apenas nos pins do contrato e do DAG correntes;
  sua interface permanece byte-idêntica no hash congelado.
- `git diff --check`: PASS; os artefatos protegidos não foram modificados.
- Tag protegida `pre-essential-input-2026-08-12` continua apontando para
  `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.

## Snapshot de integração submetido à revisão

- contrato: `sha256:70fdb6ade8f3b94e69e3b0ea96d1c9fdfe9179439634fee18be028ee7eb1f2f6`;
- DAG: `sha256:aafb39d47b0ae6a06f11b5a4894d82dc6c378e2f67e5d2b49176098066189507`;
- Gate0 verifier: `sha256:3b9e83fd9886705b4f60c651e1bf99ec771645e4c1a116299fbed2cf41bae33f`;
- N4 verifier: `sha256:57ca46c48560a70b283ad06c51e3d2bef08c3e0849620c5881553abb12b55e81`;
- interface N6: `sha256:e5a71e29720598f829beb4f720bc966a64d2b04569ded0ba404cdd03b81b3f2a`.

## Pareceres

- [formal_design](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/quality_reports/2026-08-19_n6_formal_design_review.md): PASS 0/0/0.
- [game_theory](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/quality_reports/2026-08-19_n6_game_theory_review.md): PASS 0/0/0.
- [formal_design — integração final](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/quality_reports/2026-08-19_n6_integration_formal_design_review.md): PASS 0/0/0 sobre o snapshot acima.
- [game_theory — integração final](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/quality_reports/2026-08-19_n6_integration_game_theory_review.md): PASS 0/0/0 sobre o mesmo snapshot.
