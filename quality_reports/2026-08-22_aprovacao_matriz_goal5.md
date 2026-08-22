# Aprovação autoral da matriz de migração do Goal 5

**Data:** 2026-08-22  
**Status:** `APPROVED`  
**Matriz aprovada:**
`quality_reports/plans/2026-08-21_goal5_migration_matrix.md`  
**SHA-256 dos bytes da DRAFT submetida ao autor:**
`6a8aabb60ad5148017297b1cf5360b7f138eed9cf8a373f4655e7e4bfa321360`  
**Fronteira preservada:** tag anotada
`pre-goal5-essential-input-2026-08-21`, apontando após peeling para
`e0ff1aceb3d8b9ebeeea56feb65c019dafd32854`.

## Decisão autoral

O autor:

1. aprovou a substituição controlada da arquitetura substantiva dentro do
   mesmo arquivo `formal_model_v6.Rmd`, preservando seu título;
2. confirmou as três ordens editoriais da Seção 1 da matriz: abstract
   puzzle-primeiro; introdução com hook, puzzle e benchmark público logo após o
   puzzle; resultados em ordem benchmark público, jogos privados, rendas,
   diferença das diferenças e interpretação;
3. confirmou a nota que equipara *consensus* e *unanimity*, as keywords e a
   colocação de F1--F4 e da figura de sequência;
4. confirmou o remark de escopo imediatamente após a proposition de
   inexistência: o resultado exclui PBE em estratégias puras, sem derivar,
   caracterizar, selecionar ou comparar equilíbrios mistos e sem afirmar
   existência ou inexistência sob mistura;
5. fixou a disciplina de prosa para payoffs: nos resultados, exclusão sob
   maioria paga a `H` exatamente `o_theta`; `y+o_theta` aparece somente na
   definição completa de payoffs e, quando necessário, em provas fora do
   caminho. Toda frase de payoff em prosa deve ser checada contra a
   correspondência de equilíbrio congelada, não contra a definição geral do
   jogo;
6. aprovou o **tratamento** de P1 e P2: declarar as primitivas sem qualificação
   e marcar apenas as interpretações substantivas com `[AUTHOR: P1]` e
   `[AUTHOR: P2]`;
7. aprovou o **tratamento** de P3: imagem ex ante somente como remark e faceta
   de F1, nunca proposition, e fora do manuscrito até decisão autoral;
8. manteve P1, P2 e P3 substantivamente pendentes: nenhuma delas pode ser
   decidida pelo texto;
9. autorizou iniciar a sequência da Seção 10 da matriz a partir do checkpoint
   local anterior ao primeiro byte de edição do manuscrito.

## Limites da autorização

- Somente resultados congelados de N1--N7, pelos hashes da Seção 2.
- PBE em estratégias puras e `m>=3`.
- Intuição antes de cada proposition; provas no apêndice.
- Busca negativa por opt-out, entry, A/C/R, C-B-R, random proposer e referências
  a versões.
- Compilação somente por `rmarkdown::render("formal_model_v6.Rmd")`, respeitando
  o YAML.
- Dois revisores independentes e read-only sobre o mesmo snapshot; pareceres
  completos em `quality_reports/`.
- Readability audit sem Pangram.
- Sem push.
- Tag final somente após dois `PASS 0/0/0` e aval autoral, pelo workflow
  `paper-version`.
- Qualquer necessidade de resultado novo ou escolha substantiva pausa a
  migração e retorna ao autor.

Esta decisão é posterior à DRAFT e transforma seu status em `APPROVED` sem
alterar os hashes ou o conteúdo substantivo de N1--N7.
