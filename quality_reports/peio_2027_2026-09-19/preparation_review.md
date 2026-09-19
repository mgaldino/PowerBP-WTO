# Parecer documental e visual dos materiais provisórios da PEIO 2027

Data: 2026-09-19T12:25:39.974379-03:00. Revisor: `/root/provenance_inventory`.

**Resultado final: PASS DOCUMENTAL/VISUAL para os artefatos provisórios identificados abaixo, após fechamento de dois achados menores. Zero achados documentais ou visuais relevantes remanescentes. Este veredicto não é aprovação científica do paper nem declaração de prontidão para submissão.**

## Independência, objeto e bytes avaliados

O coordenador escreveu o diagnóstico e os campos provisórios. O revisor não os editou: confrontou-os com fontes existentes, registrou findings candidatos e verificou os reparos feitos pelo coordenador. O revisor é autor do inventário de proveniência usado como uma das entradas; a conferência presente não é uma nova revisão científica independente da arquitetura ou do manuscrito.

| Artefato final | SHA-256 |
| --- | --- |
| `diagnostico.Rmd` | `41b723bc509ff0800f410c8be19ae5851be20a1d36c2306a8b7c0ba058102e46` |
| `diagnostico.pdf` | `66a317070142093984ff77c0d4291c0eaf03480a5a70f74902ed7b80c427d344` |
| `peio_fields_provisional.md` | `3e29d04613445c22be838dbd459874c858f94ca261144effe09b5e163281e7b7` |
| `peio_fields_provisional.json` | `a3ddc077f90484d4eb6d8c2fb611a0be5ae83955c1cc7a5a659decf969ecd811` |
| `verification.json` | `bf98f4c72c6afd77bc7d0dfc22e87cf8104e0e7f9f776d07834e5d4f3a6e5363` |

O PDF avaliado tem **5 páginas**, letter, 612 × 792 pt, sem criptografia. Todos os caminhos da tabela são relativos a `quality_reports/peio_2027_2026-09-19/`.

Fontes canônicas conferidas:

- `formal_model_v6.Rmd`: `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`.
- `formal_model_v6.pdf`: `55c4a70af928ead805949efd3d6bc6ff6125c01787cec09b8b26b058e57a0382`; 78 páginas, metadados inspecionados; o PDF do paper não foi renderizado ou revisado visualmente nesta conferência.
- `quality_reports/architecture_2026-09-08/architecture_note.Rmd`: `493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3`.
- O pacote condicional, os manifestos históricos, AGENTS e decisões de setembro mantêm os hashes registrados no inventário e no preflight. Os dois pareceres continuam correspondendo aos hashes de `adjudication/adjudication_round1.json`.

## Fidelidade documental

| Claim do diagnóstico | Fonte conferida | Resultado |
| --- | --- | --- |
| Manuscrito ainda não pronto, arquitetura não adotada (`diagnostico.Rmd:26`) | `AGENTS.md:17–26,54–60`; nota de arquitetura e README:5–22,58–78,132–138; contrato condicional:3–4 | Fiel. O diagnóstico não afirma autorização nem completude onde as fontes mantêm pendência. |
| B.1/B.3 já não usam pagamento aditivo; usam regra histórica de cancelamento | `formal_model_v6.Rmd:340–348,366–368,1385–1397,1429–1443,1479–1494` | Fiel. Distingue a correção de 2/9 da obrigação posterior de arquitetura. |
| Dominância de proposta ótima não fecha todos os terminais | `agents_maintenance_2026-09-05/architecture_clarification.md`; nota de arquitetura:126–161 | Fiel, inclusive ressalva sobre respostas prescritas e desvios. |
| Conteúdo de A1–A3, recebimentos alternativos e execução ótima | `architecture_note.Rmd:170–218,224–261` | Fiel depois do reparo DOC-001; hipótese econômica adicional permanece explícita. |
| Transporte bidirecional projetado, com limites | `architecture_note.Rmd:415–466,495–533` | Fiel. Preserva condição sobre caracterização histórica e exclui identidade de todos os pagamentos desviantes e das árvores completas. |
| Dois PASS e adjudicação da nota, sem extensão indevida | Pareceres formal e adversarial, README:26–42; `claim_ledger.json:2–10,69–80` | Fiel aos mesmos bytes e ao escopo condicional. Os PASS de 2/9 não foram ampliados. |
| Dependências de estratégias/assinaturas completas da agenda | `architecture_note.Rmd:523–533`; `source_reads/agenda.md`; ledger AGENDA | Fiel. O texto não declara esse levantamento executado. |
| Alternativa coalizão-alvo e seus limites | `2026-09-08_evdokimov_protocol_equivalence_check.md:5,13,60–66` | Fiel. Explicita mudança do protocolo, restrição de alocações a C, possível sinalização e ausência de certificação da agenda. |
| 29 registros, 15 diretórios existentes, 14 ausentes e 73 refs | Inventário completo, comandos Git e JSON de proveniência | Conferente; ressalva de ausência de consulta live ao remoto preservada. |
| Número de páginas, hashes, título corrente e último commit do manuscrito | `pdfinfo`; fonte YAML; `git log -1 -- formal_model_v6.Rmd`; preflight | Conferente: 78 páginas, título efetivo e última alteração em 2/9, commit 68ed3d872400. |

Não foi encontrada afirmação de que o paper esteja pronto para submissão. O diagnóstico abre afirmando o contrário, mantém A1–A3 pendentes, classifica os campos como provisórios e declara que nenhum formulário foi preenchido ou enviado. `verification.json` conserva `PASS_MECHANICAL_ONLY` e sua fronteira explícita.

## Campos PEIO, contagem e registros mecânicos

- O título em JSON coincide literalmente com `formal_model_v6.Rmd:2`: **Power and Its Shadow: When Unanimity Serves the Hegemon**.
- O abstract em JSON coincide literalmente, caractere a caractere, com a linha 36 da fonte. O mesmo texto aparece verbatim no Markdown provisório. No diagnóstico há somente quebras de linha de edição; normalização de whitespace reproduz a fonte exata.
- Contagem independente com `len(abstract.split())`: **137 palavras**. Hifenizados contam como uma palavra, conforme o método declarado. O número coincide com JSON, Markdown e diagnóstico.
- `source_sha256` dos campos coincide com a fonte canônica. `category` permanece `WTO`; o texto não converte a categoria em alegação de validação empírica.
- O prazo de 20 de setembro de 2026 foi confirmado no conteúdo da [chamada oficial da PEIO 2027](https://wp.peio.me/wp-content/uploads/PEIO19/PEIO2027.pdf), recuperado pela busca web em 19/9/2026. A abertura direta inicial retornou timeout; a busca retornou o texto da própria fonte oficial. Não foi usado um resultado de rede social como evidência.
- `finite_checks.csv` reproduzido contém **29.005 linhas**, todas com `pass=TRUE`, zero falhas. O resumo soma 4 + 84 + 20.160 + 6.840 + 315 + 1.600 + 2 = 29.005.
- Os cinco outputs preservados na reprodução, inclusive `sessionInfo.txt`, correspondem exatamente aos hashes registrados e aos originais. As três execuções de validadores registradas têm exit code 0; os dois pareceres correspondem aos hashes de adjudicação.
- Nesta revisão foram recontadas linhas, comparados textos e recomputados hashes. Não foi reexecutado o script R da arquitetura, porque o coordenador já o executou e a tarefa atual é de fidelidade documental. Os logs registram avisos de locale sem falha e os outputs conferem.

## Findings candidatos, adjudicação e fechamento

### DOC-001 — ambiguidade local na descrição dos recebimentos

- Localizador original: `diagnostico.Rmd:92–94`; snapshot `review_history/diagnostico_before_wording_fix.Rmd`, SHA-256 `480a4d8d566bb47e98db21c884d6672b244b86446692e74c945cf95d0fb6f7bf`.
- Finding candidato enviado: a sequência “após aprovação com H não são (x_H,0) ou (0,o)” pode ser lida como negação das duas possibilidades, embora a nota afirme a disjunção.
- Evidência: equação (1) e proposição C1, `architecture_note.Rmd:235–261`.
- Adjudicação do coordenador: **CONFIRMED**, severity minor, reparo de exposição safe; registro em `review_history/adjudication_DOC-001.json`.
- Reparo conferido nos bytes finais e na página 2: “Com A1–A3, após aprovação em que H votou não, os recebimentos são (x_H,0) ou (0,o)”. **Fechado**, sem mudança da hipótese ou do resultado.

### DOC-002 — overflow da referência ao JSON

- Localizador original: `diagnostico.Rmd:204–205`, PDF página 4. Fonte SHA-256 `3e8b99d7fcbb164cf596f0c9231e5c5caacae89968fb1bfa947b2c905c0973d6`; PDF SHA-256 `5c72b5d834fd7c3fe3f52a63d0b4cfbdead1c3782bcef32c99bfddb6d3429b11`.
- Finding candidato enviado: `peio_fields_provisional.json` avança 37,69 pt além da margem direita do corpo; bbox xMax 578,82573 versus limite esperado 541,134. Não havia corte físico na folha, mas havia overflow visível.
- Adjudicação do coordenador: **CONFIRMED**, severity minor, reparo de layout safe; registro em `review_history/adjudication_DOC-002.json` e snapshot `review_history/diagnostico_before_layout_fix.Rmd`.
- O coordenador separou as duas referências em parágrafos curtos com `\nolinkurl`. O diff foi conferido: apenas formatação/referência aos arquivos mudou, e a declaração de não envio foi preservada.
- Na página 4 final, todo texto está dentro da largura do corpo: xMax 541,135483. Nova inspeção visual e bbox confirmam ausência de overflow. **Fechado.**

## Inspeção visual integral do diagnóstico

O PDF de cinco páginas foi renderizado com Poppler a 150 dpi. As cinco páginas do candidato após DOC-001 foram abertas como imagens e inspecionadas. Após DOC-002, as cinco páginas foram renderizadas novamente: os PNGs das páginas 1–3 são byte a byte idênticos aos já inspecionados; as páginas 4–5 foram abertas e inspecionadas novamente. Assim, a cobertura visual alcança todas as páginas dos bytes finais.

| Página final | Resultado da inspeção |
| --- | --- |
| 1 | Título, sumário, identidade do manuscrito e limite de prontidão legíveis; margens e numeração preservadas. |
| 2 | Texto, enumeração A1–A3, fórmulas e fechamento DOC-001 legíveis; sem corte ou sobreposição com rodapé. |
| 3 | Tabela 1 inteira, caption numerada e coluna de tratamentos legíveis; alternativa coalizão-alvo e evidência mecânica sem corte. |
| 4 | Título/abstract/categoria legíveis; referências aos arquivos agora dentro das margens; fontes e comando de verificação íntegros. |
| 5 | Bloco de renderização íntegro e decisão pendente legível; numeração correta. Há espaço em branco remanescente, sem perda de conteúdo. |

Todas as caixas de palavras estão dentro das folhas físicas. Não há palavras fora da largura do corpo de texto usando tolerância de 2 pt sobre as margens de 25 mm. Não foram encontrados glifos de substituição, `??`, texto cortado, sobreposição de elementos ou referências indefinidas no texto extraído. As fórmulas e a tabela também foram verificadas visualmente; essas conclusões não se apoiam apenas na extração.

Comandos usados para a visualização e conferência:

```sh
pdfinfo quality_reports/peio_2027_2026-09-19/diagnostico.pdf
pdftoppm -r 150 -png <diagnostico.pdf> /private/tmp/<review>/page
pdftotext -layout <diagnostico.pdf> /private/tmp/<review>/diagnostico.txt
pdftotext -bbox <diagnostico.pdf> /private/tmp/<review>/diagnostico-bbox.html
```

Os PNGs e extrações temporários estão exclusivamente em `/private/tmp/pbp-peio-documentary-review-253gtt_q/`. A revisão aplicou a skill PDF para renderização e inspeção. Ela não criou, recompilou ou editou o PDF: essas ações couberam ao coordenador.

## Limite do parecer

A aprovação acima cobre fidelidade às fontes, consistência de números/hashes, reprodução literal dos campos, explicitação de pendências e legibilidade do diagnóstico. Não reaudita cientificamente a prova de arquitetura, B.1/B.3, toda a correspondência de equilíbrio, seleção mensurável ou a extensão de agenda. Não adota A1–A3, não migra resultados, não autoriza submissão e não atesta que o paper seja um candidato final pronto. A inspeção visual é do diagnóstico de cinco páginas; o paper de 78 páginas permaneceu somente identificado por hash e metadados nesta revisão.

Além deste parecer, o revisor escreveu apenas imagens/extrações temporárias em `/private/tmp`, conforme a autorização desta etapa. Fontes canônicas, campos provisórios e diagnóstico foram preservados pelo revisor.
