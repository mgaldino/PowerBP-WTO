# Parecer independente — N3 beta<1, Round 3

- `reviewer_role`: `formal_design`
- `reviewer_id`: `review-n3-beta-formal-2026-08-18-r3`
- Contrato: `sha256:2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- Dependência única N1: `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`
- Candidato N3: `sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee`
- Verifier N3: `sha256:7072a58bf9fbaf012535418a93418dffb8d4692f13919f39101c8ecb37710f6b`
- Derivação: `sha256:b0e5e69e5eb774c2bb13170f00752fe138882282d268b8172c9c39dff5fefdd5`
- Ledger: `sha256:7219ef5572ae1df2fab8b2e00f534f209b8fdda0b70283d08c74b245afbc3b22`

## Veredicto

**PASS**

Contagens: **critical 0 / major 0 / minor 0**

## Auditoria substantiva

A rederivação integral confirma:

- N1 é a única continuação, congelada no hash correto.
- `w=beta/m` e `t_theta=beta*o_theta` transportam R2 para R1 exatamente uma vez.
- Weak nonproposers votam `sim` sse `x_j>=w`; `T^Y` resolve a igualdade.
- A IC de `H` preserva os três casos:

  - não pivotal: `sim -> y`, `não -> y+o_theta`;
  - pivotal: aceita sse `y>=t_theta`;
  - falha inevitável: `T^Y -> sim`.

- `D=1-beta*q/m>0`; rejeição deliberada e slack são estritamente dominados por exclusão.
- P0, P1 e P1a estão demonstradas.
- A correspondência é exaustivamente reduzida a `E/S/P`; `R_i` permanece apenas na prova de desvios.
- Screening preserva o delay do tipo alto quando `nu>0`.
- Cutoffs, igualdades, tie-break de menor payoff esperado de `H`, factibilidade e endpoints `nu=0/1` estão corretos.
- Crenças em propostas e vetores de massa zero, atualização pelo voto público de `H`, tipos de prior zero, multiplicidade `F_i` identity-indexed, payoffs, outcomes e atomicidade estão completos.
- N3 permanece `pending/null`; nenhuma lifecycle foi inserida.

## Fechamento do F2

Com apenas `check_exact_anchor` neutralizado, os nove hashes independentes — preâmbulo e Seções 1–8 — permaneceram ativos e rejeitaram qualquer alteração de conteúdo ou bytes.

Foram rejeitados:

- os quatro adendos do Round 2;
- inserções no início, meio, fim e imediatamente antes da Seção 8;
- alteração exclusiva de whitespace;
- novo apêndice contraditório de teoria dos jogos;
- quatro paráfrases inéditas sobre desconto unitário, ausência de continuação em screening, seleção de rejeição e slack;
- substituição coordenada de mesmo comprimento;
- corrupção coordenada de interface e ledger sem autoidentidade.

Resultados independentes:

```text
start_ACCEPTED=FALSE
middle_ACCEPTED=FALSE
end_ACCEPTED=FALSE
before8_ACCEPTED=FALSE
whitespace_ACCEPTED=FALSE
patience_ACCEPTED=FALSE
screening_ACCEPTED=FALSE
rejection_ACCEPTED=FALSE
slack_ACCEPTED=FALSE
same_length_ACCEPTED=FALSE
game_appendix_ACCEPTED=FALSE
COORDINATED_INTERFACE_ACCEPTED=FALSE
COORDINATED_LEDGER_ACCEPTED=FALSE
```

A interface rejeitou 87 caminhos nomeados e o ledger rejeitou 119 células com a âncora externa desativada. F1 e F2 estão fechados.

## Execuções

- Verifier N3: PASS.
- Gate 0: PASS.
- Checker do DAG: `VALID`; `N3` e `N4` topologicamente prontos, sem ampliar a autorização além de N3.
- `git diff --check`: PASS.
- Diff dos artefatos protegidos: vazio.
- Nenhum arquivo foi editado pelo revisor.
