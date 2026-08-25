# Handoff — estado do repositório e próximos passos

**Data:** 2026-08-25
**Destino:** sessão Codex.
**Natureza:** orientação de estado. Não autoriza nada além do que está descrito.

---

## Prompt a colar

```text
Estamos no repo PowerBayesianPersuasion, branch codex/essential-input. Leia
CLAUDE.md e AGENTS.md, e depois o cabeçalho de
quality_reports/plans/2026-08-12_essential_input_gate0.md, que é a fonte
canônica do status da fase e do que está autorizado.

ESTADO EM 2026-08-25, já verificado:
- N1, N2, N3, N4, N6 e N7 estão pass/frozen; Goals 1 a 4 encerrados.
- verify_essential_input_gate0.R passa, e os cinco verificadores numéricos
  (numeric_boundaries, n1/n2/n3/n4_numeric) voltaram a passar.
- O item O-1 está RESOLVIDO; ver
  quality_reports/2026-08-23_item_o1_deriva_registro_conceito_solucao.md.
- A introdução do manuscrito foi reescrita em inglês, revisada e recompilada.
  O autor aprovou. formal_model_v6.pdf está atualizado.

DUAS TAREFAS EM ABERTO, independentes entre si.

TAREFA A — fechar o Goal 5.
O autor deu o aval terminal. Falta criar a tag da versão pelo workflow
paper-version sobre os bytes correntes de formal_model_v6.Rmd e .pdf, e
atualizar o status em três lugares: o cabeçalho do contrato Gate 0, CLAUDE.md e
AGENTS.md, que hoje descrevem o Goal 5 como aberto.
Cuidados: o cabeçalho do contrato está sob pino de região; qualquer edição nele
exige recomputar expected_contract_hash e authorization_header em
scripts/verify_essential_input_gate0.R e rodar o verificador até PASS. O
procedimento e o histórico estão em
quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md.
Os dois pareceres PASS 0/0/0 do Goal 5 cobrem o commit b5fdefb, não os bytes
correntes; o registro de fechamento deve dizer isso com todas as letras, e
registrar que a abertura posterior é redação autoral aprovada pelo autor mais um
proofread independente (quality_reports/2026-08-25_proofread_introducao_v6.md).

TAREFA B — Goal 0 da extensão de agenda.
O autor deu GO explícito em 2026-08-23, limitado à redação do contrato
executável do Gate 0 da extensão. O prompt completo e autossuficiente está em
quality_reports/plans/2026-08-23_prompt_goal0_agenda_extension_opus.md; use
aquele prompt, não este. Ele já foi corrigido: o hash do plano v3 estava preso a
uma versão anterior e foi atualizado para 56a933dc.

NÃO AUTORIZADO, conforme o cabeçalho do contrato: aprovar o contrato do Gate 0
da extensão, os goals seguintes daquela cadeia, escrever qualquer script dela
inclusive o verificador, a fronteira beta=1, e a edição de formal_model_v5.Rmd,
da pasta RIO submission files/ e dos artefatos congelados de N1, N2, N3, N4, N6
e N7.

AVISO: este repositório tem hook de session-stop que commita e faz push
sozinho. Reporte sempre os hashes que você calculou, para que qualquer revisão
saiba sobre quais bytes se pronuncia.
```

---

## Contexto que não cabe no prompt

**Frase parqueada.** Quando a extensão de agenda fechar, a introdução ganha a
formulação dos dois cenários, com e sem direito de proposta. O texto exato e o
que precisa ser revisto no mesmo ato estão em
`notes/2026-08-25_frase_introducao_apos_extensao_agenda.md`. Não inserir antes:
o corpo afirma em quatro lugares que o hegemon nunca propõe, e a contribuição
depende disso.

**Itens de clareza não aplicados.** O proofread da introdução levantou dezesseis
itens de clareza; os de reparo local foram aplicados, e sobraram os que são
preferência de estilo — repetição de "power" na abertura, marcadores
`First/Second/Third` numa enumeração de três, e a reconciliação entre "One
explanation offered in the literature" e "The standard answer". Viajam sem custo
para uma passada futura.

**Dívida registrada e fechada por decisão autoral.** Os canários de regressão do
verificador verificam menos do que suas mensagens afirmam; o autor decidiu em
2026-08-25 que a proteção efetiva é hash exato mais revisão do diff, e que a
modelagem de adversário deliberado é desproporcional para este projeto. Não
reabrir sem decisão nova.
