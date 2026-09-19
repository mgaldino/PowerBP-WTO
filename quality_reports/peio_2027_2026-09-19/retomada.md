# Retomada da preparação para PEIO 2027

**Atualização posterior à entrega do diagnóstico:** o autor aprovou A2 e A3 e manteve A1 em dúvida, com inclinação à rejeição. A pergunta atual é se as três cláusulas são necessárias. Consultar `author_decision_A2_A3.md` e o `status.json` atualizado. O registro abaixo descreve a entrega anterior e está superado quanto ao estado individual de A2 e A3; não solicitar sua aprovação novamente.

Estado deste registro: aguardando decisões autorais individuais A1, A2 e A3. A pergunta foi apresentada durante a tarefa de 19/09/2026. Ausência de resposta não é aprovação. O pedido autoriza diagnóstico, correção dentro dos fundamentos, revisão independente, integração e materiais; não autoriza submissão, publicação, push ou comunicação externa.

## Base verificada

- Checkout: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion`.
- Branch `codex/exposition-items20-28`; HEAD `26b1a40cb98933ae3cd5fd43dd4b7e691b13f5ba`.
- Fonte canônica SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`; PDF `55c4a70af928ead805949efd3d6bc6ff6125c01787cec09b8b26b058e57a0382`.
- Título atual: *Power and Its Shadow: When Unanimity Serves the Hegemon*. Abstract atual: 137 palavras. Categoria escolhida pelo autor: WTO.
- Candidata condicional: `quality_reports/architecture_2026-09-08/architecture_note.Rmd`, hash `493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3`. Dois PASS e adjudicação nos mesmos bytes, conferidos novamente. Não repetir como trabalho faltante.
- A memória do rollout de 8/9 estava incompleta sobre a entrega de revisões; usar os documentos atuais. A arquitetura ainda não foi adotada, mas a análise condicional foi concluída.
- Nenhum arquivo preexistente foi alterado. Somente este diretório e `scripts/verify_peio_preflight_20260919.py` foram criados.

## Decisões apresentadas

1. A1: benefício de H requer execução da oportunidade; orçamento é de oportunidades disponíveis, mantendo pagamentos dos fracos.
2. A2: recurso de H indivisível e rival entre clube e fórum externo.
3. A3: sim é compromisso executável condicionado à aprovação; não seguido de aprovação deixa escolha voluntária de execução C/O.

Não confundir aprovação da correção formal em geral com adoção dessas novas hipóteses. Se forem aprovadas, registrar cada resposta e a incidência nos fundamentos/protocolo. Não pedir de novo autorização para integração e revisão já dadas no pedido.

## Trabalho após decisão

1. Conferir novamente Git e hashes para preservar qualquer edição posterior do autor. Antes de um reset substantivo, ler/aplicar `paper-version` e preservar a fronteira de versão. Não modificar fontes congelados; usar adendos/candidatos novos.
2. Se A1–A3 forem adotadas, reutilizar a prova condicional atual e documentar a interface adotada. Resolver primeiro execução e continuações R2, depois R1. A continuidade unânime é a própria do jogo unânime; nunca substituir universalmente por `beta o`.
3. Completar fora do manuscrito o levantamento de assessments para os consumidores de agenda. `source_reads/agenda.md` mapeia 15 consumidores: seleção literal/total/Borel, reconhecimento e votos, estratégias de execução, kernels e leis realizadas, anonimidade/ação diagonal, produto comparável e decomposições.
4. Preservar distinções: assinatura exata é órbita diagonal de leis realizadas, não serialização de planos off-path; empate de execução não é T^Y; representante Borel não elimina automaticamente outras execuções ótimas; projeção econômica não é identidade literal de jogos.
5. Fixar candidato e contrato de leitura antes da revisão científica. As leituras `source_reads/baseline.md` e `source_reads/agenda.md` são mapas fonte-vinculados, não pareceres de validade ou um PASS global do paper. Revalidar por impacto e completar a leitura macro/framing no candidato efetivamente alterado.
6. Exigir duas revisões independentes completas sobre os mesmos hashes: formal/adversarial e consistência arquitetura/resultados/interpretação; manter revisores sem edição. Adjudicar os findings e separar implementação de revisão.
7. Integrar a arquitetura/provas aprovadas e consumidores. Harmonizar apenas o necessário em seção 4/A.1/B.1/B.3, figura de sequência, referências, seção 6/B.7–B.9/E–F, limits, abstract e interpretação. Conferir B.4 e sua disciplina de crenças no escopo exigido, pois o transporte de 8/9 não a reaudita integralmente.
8. Reexecutar verificadores afetados com suas fronteiras declaradas; renderizar via `rmarkdown::render("formal_model_v6.Rmd")`, respeitando YAML bookdown; inspeção visual integral independente do PDF final; fixar fontes, hashes, resultados e pareceres.
9. Só então promover os campos provisórios a finais, conferir limite de 250 palavras e categoria WTO. Preservar o título atual salvo benefício concreto de mudança. Não inventar identificação/aplicação empírica da OMC.

Se o autor rejeitar uma cláusula, o transporte condicional não autoriza substituí-la por outra. A alternativa de coalizão-alvo tem análise focal em `quality_reports/2026-09-08_evdokimov_protocol_equivalence_check.md`, mas muda o protocolo/espaço de ações e não resolve automaticamente a agenda. A escolha deve ser registrada antes da derivação dependente.

## Evidência produzida em 19/9

`verification.json`: contrato, adjudicação e DAG válidos; 29.005 verificações R reexecutadas em diretório temporário, zero falhas, cinco outputs idênticos. Não é recertificação matemática. `provenance_inventory.json`: 29 registros de worktree, 15 existentes, 73 refs locais, fontes dirty preservados; sem fetch remoto. `diagnostico.Rmd/.pdf`: estado e decisões para revisão. `preparation_review.md`: conferência documental/visual independente do diagnóstico. `review_history/`: dois reparos locais, de ambiguidade gramatical e de quebra de linha em nomes de arquivos, sem mudança de conteúdo matemático.
