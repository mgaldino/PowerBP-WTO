# Reparo dirigido de `FD-SUP-MIN-01`

**Data:** 21 de agosto de 2026  
**Papel:** registro do implementador; não é parecer independente  
**Escopo:** somente a prova resumida da separação inversa no relatório consolidado

## Finding recebido

O parecer `formal_design` pós-restrição de suporte identificou que a
contradição `Y<ell<h<=Y` foi enunciada sem limitar seu domínio ao interior do
prior. No endpoint `nu=1`, a restrição de suporte fixa posterior um após ambos
os votos e a contradição correta é `Y<h<=Y`.

## Reparo único aplicado

No relatório consolidado:

1. `Y<ell<h<=Y` ficou expressamente restrita a `0<nu<1`;
2. o endpoint `nu=1` recebeu o argumento próprio: ambos os tipos comparam `Y`
   com `h`, de modo que a separação inversa exigiria `Y<h<=Y` e é eliminada
   por preferência estrita ou por `T^Y` na igualdade.

Nenhuma primitiva, estratégia, crença admissível, fronteira, proposta,
resultado, payoff, célula de existência, interface JSON, ledger ou script foi
alterado. O reparo fecha apenas a qualificação textual indicada pelo finding.

## Integridade pós-reparo

- relatório consolidado:
  `sha256:1b324c0eb0e03e8c42aa9494dcfbbc1e3c69947a2dfa92d3a92f33783ba4eba8`;
- interface N3 preservada:
  `sha256:ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`;
- interface N4 preservada:
  `sha256:f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`;
- verificação dirigida: `MODEL_PROOF_DIRECTED`, `ALGEBRA_IDENTITIES` e
  `FINITE_ENUMERATION` retornaram `PASS`;
- `git diff --check` retornou limpo.

N3 e N4 continuam sem integração ao DAG durante a revisão. N6, N7, figuras,
PDF e manuscrito permanecem fora do escopo.
