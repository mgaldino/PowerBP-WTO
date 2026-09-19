# Preparação PEIO 2027: protocolo de coalizão

Este diretório registra a decisão autoral de 19/9, as derivações fora do manuscrito, revisões independentes, adjudicações e validações do candidato. Consulte `delivery_report.md`, `delivery_manifest.json` e `status.json` para o resultado e os arquivos exatos da entrega. A publicação ou submissão não faz parte da tarefa.

## Decisão que governa o modelo

Uma proposta é um par público `(C,x)`. O proponente pertence a C; C satisfaz a quota institucional; as parcelas são não negativas, somam no máximo 1 e são zero fora de C. Todos os convidados precisam consentir simultaneamente. O acordo aprovado paga automaticamente todas as parcelas. H fora de um acordo recebe sua opção externa, exterior à pie; uma recusa de convidado faz o pacote inteiro fracassar. Não há ação individual de execução por H.

A maioria permite excluir H e a unanimidade exige C=N. Permanecem um único ator informado, fracos simétricos e desinformados, pie fixa e as rodadas, crenças e desempates declarados. A decisão substitui explicitamente o protocolo majoritário anterior; igualdade de fórmulas econômicas não implica equivalência global de estratégias.

## Roteiro dos arquivos

- `author_decision.md`: decisão e alterações dos fundamentos.
- `diagnosis.md`: pendência anterior, dependências e mudança arquitetural.
- `preflight/`: checkout, instruções anteriores, hashes e worktrees.
- `snapshots/original/`: Rmd/BibTeX recebidos; o checkpoint Git registra também o PDF anterior.
- `derivations/derivation_bundle_v2.md` e `reviews/derivation_candidate_v2.json`: fonte matemática atual e hashes; v1 permanece como histórico.
- `derivations/v2/unanimity_support_lemma.md`: cobertura de massa zero no suporte.
- `argument_contract/derivations_v2/` e `argument_contract/manuscript_candidate/`: contratos de leitura com fontes e âmbito precisos.
- `reviews/`: pareceres científicos e verificações independentes; cada veredicto tem fronteira própria.
- `adjudication/`: decisões sobre os achados, distinguindo versões e escopos.
- `derivations/build_manuscript_candidate.py`: composição reproduzível dos patches sobre os fontes preservados, sem escrita canônica.
- `checks/`: controles numéricos, referências, figuras, compilação e apresentação visual.
- `peio_fields.md`: título, abstract de 168 palavras e categoria WTO, prontos para copiar.

## Reprodução

Na raiz do repositório:

```sh
python3 quality_reports/coalition_protocol_2026-09-19/derivations/build_manuscript_candidate.py
Rscript scripts/verify_coalition_protocol_20260919.R
Rscript scripts/verify_coalition_figures_20260919.R
python3 scripts/verify_coalition_manuscript_20260919.py --output quality_reports/coalition_protocol_2026-09-19/checks/final_source_integrity.json
Rscript -e 'rmarkdown::render("formal_model_v6.Rmd")'
```

O primeiro comando reproduz somente o candidato separado; os demais validam/compilam os respectivos arquivos atuais. Os scripts registram seus escopos. Malhas finitas não substituem as provas, compilação não substitui inspeção visual e igualdade de hashes não transforma uma revisão antiga em revisão de conteúdo diferente. A validação de entrega liga cada resultado ao arquivo efetivamente usado.

A inspeção visual integral está em `checks/visual_candidate.md`; sua transferência para o PDF recompilado é documentada em `checks/final_pdf_equivalence.json`. O script `scripts/verify_coalition_pdf_20260919.py` compara todas as páginas renderizadas. A renderização Quartz reproduzível da página 24 documenta o glifo Delta, corretamente presente no PDF apesar de uma diferença no Poppler local.
