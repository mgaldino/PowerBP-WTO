# Entrega do candidato para a PEIO 2027

Concluída em 19 de setembro de 2026. O manuscrito canônico incorpora a arquitetura de coalizão expressamente adotada pelo autor, com dois pareceres científicos independentes aprovados, adjudicação encerrada, compilação bookdown e inspeção visual vinculada ao PDF final. Não resta pendência formal aberta no escopo revisado. O candidato está preparado para a revisão final do autor e para submissão; nenhuma submissão, publicação, comunicação externa, tag ou push foi realizada.

## Arquivos entregues

| Artefato | Localização | SHA-256 |
| --- | --- | --- |
| PDF, 83 páginas | [formal_model_v6.pdf](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.pdf) | `507cefdebe47830fb2f1b3f0ee0ab517c223c9fcaaeb268646367272027c0328` |
| Manuscrito em RMarkdown | [formal_model_v6.Rmd](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd) | `9356d86a2e893481968ee96a918c2109e726444c5d902ce88edd6f1a5d86345f` |
| Bibliografia | [references.bib](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/references.bib) | `658af186c73c1291da02a9fd4e3482fc953549ed46036ae24303b45f61309447` |

Os [campos da PEIO](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/peio_fields.md) contêm o título preservado, **Power and Its Shadow: When Unanimity Serves the Hegemon**, o abstract final de **168 palavras** e a categoria **WTO**, escolhida pelo autor. O abstract é idêntico ao do manuscrito.

O [manifesto de entrega](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/delivery_manifest.json) inventaria fontes, scripts, figuras, contratos, pareceres, adjudicações e verificações. A versão recebida permanece no checkpoint Git `c6dfab61a5a3b44d09ba389911df47726f81b51e`, na branch `codex/exposition-items20-28`; os fontes anteriores também foram copiados para `snapshots/original/`.

## Pendência resolvida e mudança substantiva

O jogo anterior permitia discutir uma proposta aprovada sem o voto de H, embora lhe atribuísse parcela positiva. A demonstração limitada a propostas ótimas não definia satisfatoriamente todos os pagamentos e incentivos após desvios. O cancelamento unilateral da parcela de H nesse ramo contrariava a exigência autoral de implementar integralmente uma divisão aprovada. A alternativa de uma ação individual posterior de execução também foi rejeitada pelo autor.

A [decisão autoral](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/author_decision.md) adota uma proposta pública `(C,x)`: uma coalizão que contém o proponente, satisfaz a quota institucional e distribui a pie somente entre seus membros. Todos os convidados precisam consentir simultaneamente; o proponente conta como sim. Um acordo aprovado paga automaticamente a alocação inteira. Qualquer recusa de convidado faz o pacote inteiro fracassar, inclusive quando a coalizão supera a quota.

Isso determina os pagamentos em todas as histórias factíveis, inclusive desviantes:

| Situação | Consequência |
| --- | --- |
| H recebe oferta positiva | H pertence a C. Seu voto não faz o pacote inteiro fracassar. |
| H pertence a C e o acordo é aprovado | H recebe a parcela proposta. |
| H está fora de C e o acordo é aprovado | Sua parcela é zero e ele recebe sua opção externa, que está fora da pie. H não emite voto nessa votação. |
| O pacote fracassa na primeira rodada | O jogo segue para a rodada terminal com o desconto declarado, sem pagamento intermediário da opção externa. |
| O pacote fracassa na rodada terminal | Os fracos recebem zero e H recebe a opção externa, independentemente de seu voto. |

A ausência de acúmulo decorre, portanto, da arquitetura adotada em todos os perfis, sem apagar pagamentos depois da aprovação. Ela não é apresentada como consequência de racionalidade apenas em propostas ótimas.

Há uma mudança substantiva de protocolo: a maioria passa a fixar a dimensão mínima de C, com consentimento de todos os convidados; sob unanimidade, C é necessariamente o conjunto de todos os jogadores. O sentido literal de “H vota não e o acordo passa sem ele” é substituído por “H fica fora da coalizão aprovada”. A economia mantém pie fixa, um único ator informado, fracos simétricos e desinformados e a opção externa de H independente dos acordos entre os demais.

Preserva-se a contribuição pela margem extensiva de inclusão do único ator informado. As fórmulas econômicas transportadas foram rederivadas ou verificadas no domínio pertinente. Sob maioria, isso não implica equivalência global entre estratégias, crenças ou leis de resultados dos dois protocolos. Na extensão em que H propõe primeiro, C integra o sinal público e permanece nas leis de propostas, inclusive rejeitadas. O manuscrito explicita essa distinção.

## Derivação, revisão e correções

As derivações estão no [bundle v2](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v2.md), SHA-256 `3b8043d49de9011a60c1e7e079b4fbf876f35239d100dad82a0072b53a19b4e2`. A ordem foi rodada terminal, primeira rodada e extensão de agenda; a nova prova de suporte para unanimidade precede seus consumidores. O encerramento da revisão dos nós está em `checks/reviewed_dependency_closure.json`; o grafo congelado anterior não foi reescrito.

Dois agentes distintos do implementador concluíram a revisão das 17 afirmações das notas e das 20 afirmações do transporte e da consistência formal do manuscrito. Ambos examinaram os mesmos hashes finais. A cobertura anterior foi reaproveitada apenas em partes comprovadamente idênticas; os reparos e suas dependências foram reavaliados.

- [Parecer formal](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/reviews/formal_derivations_v2.md): PASS; SHA-256 `2fbd16ed0224fd9516818cf597576733932938f163bd1be1af258680c13ce646`.
- [Parecer adversarial e de consistência](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/reviews/adversarial_derivations_v2_and_manuscript.md): PASS; SHA-256 `5ac0259990fbd413f60a07db6aa779c08f75ea2fc656afb922401b93efd4f003`.
- [Adjudicação das derivações](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/adjudication/final_derivations_v2.md) e [do manuscrito](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/adjudication/final_manuscript.md): nenhum defeito confirmado ou não resolvido no candidato final.

Três achados da primeira rodada foram confirmados e corrigidos:

1. Uma fatoração incorreta introduzida na nova nota de agenda foi substituída pela identidade correta. A desigualdade estrita e seu resultado econômico permanecem válidos. Esse erro estava na nota candidata, não na versão original do manuscrito.
2. A prova histórica de B.8 tratava uma proposta como desvio fora do suporte sem cobrir a possibilidade de ela estar no suporte com massa zero. O novo lema de Bayes local cobre ambos os casos e as duas aplicações da prova. Não se acrescentou restrição de crença ou hipótese para obter o resultado.
3. A expressão “suportada no conjunto ótimo” foi precisada como concentração com probabilidade um nesse conjunto. Mantiveram-se as desigualdades de ausência de desvio lucrativo em cada ponto, inclusive pontos de massa zero no suporte. Não se impôs um refinamento topológico novo.

O FAIL histórico da primeira revisão e sua adjudicação permanecem preservados. A integração copiou exatamente os bytes do Rmd e da bibliografia aprovados, conforme `checks/integration_manifest.json`. As instruções de AGENTS.md e o aviso inicial em CLAUDE.md registram a decisão atual para impedir que registros históricos sejam tratados como autorização de arquiteturas abandonadas.

## Verificações executadas

| Verificação | Resultado e alcance |
| --- | --- |
| Arquitetura e propostas | PASS em 37.772 histórias de uma malha de coalizões, alocações e votos; 7.116 são casos de oferta positiva recusada por H, todos com fracasso integral. Inclui coalizões maiores que a quota e desvios irracionais. |
| Incentivos e continuação | PASS em 412.077 comparações de propostas de maioria na primeira rodada, 432 perfis de unanimidade e um testemunho de mesma alocação com coalizões distintas. Os 457.398 casos agregados incluem a contagem de um subconjunto; não são 457.398 histórias distintas. |
| Verificação independente de maioria | O revisor formal enumerou 3.054.975 comparações proposta–estado, em 50 estados, com 100 assertivas aprovadas. Escopo finito explicitado no parecer; execução intacta da primeira rodada preservada. |
| Reparação algébrica | 4.353 verificações racionais em 870 casos, reexecutadas separadamente pelos dois revisores, com resultados idênticos ao arquivo congelado. |
| Cinco figuras econômicas externas | 9.031 verificações de coordenadas, fronteiras, preços, payoffs, rendas e existência. Nenhuma dessas figuras foi reescrita; a figura do protocolo incorporada ao texto foi atualizada e inspecionada. |
| Integridade do manuscrito | PASS: 31 rótulos, 26 referências cruzadas, 34 ocorrências de citações e 25 chaves citadas, todas resolvidas; 45 entradas bibliográficas, cinco figuras externas presentes e delimitadores matemáticos equilibrados. |
| Nova referência | A referência Evdokimov (2023) foi confrontada com a fonte primária local. O manuscrito distingue o protocolo de coalizão da restrição adicional adotada de não alocar a não membros. Não se certificou novamente toda a bibliografia histórica. |
| Compilação | `Rscript -e 'rmarkdown::render("formal_model_v6.Rmd")'`, com bookdown conforme o YAML, saída zero, PDF de 83 páginas. Houve cinco avisos de locale do R com fallback para C; não houve erro de compilação. |
| Inspeção visual | 83 de 83 páginas efetivamente inspecionadas; nove páginas também ampliadas. Todas as páginas renderizadas e o texto com layout da recompilação canônica são idênticos aos da cópia inspecionada. |
| Preservação | Apenas os caminhos rastreados autorizados mudaram. V5, RIO submission files, model_redesign e registros congelados anteriores permanecem intactos; cinco PDFs de figuras mantêm seus hashes. |

Malhas numéricas e checks mecânicos complementam as provas e não as substituem. Os scripts do coordenador são `scripts/verify_coalition_protocol_20260919.R`, `scripts/verify_coalition_figures_20260919.R`, `scripts/verify_coalition_manuscript_20260919.py` e `scripts/verify_coalition_pdf_20260919.py`. Os scripts independentes dos revisores estão em `reviews/`. Todos são inventariados no manifesto.

A [inspeção visual](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/checks/visual_candidate.md) está vinculada à cópia durável `snapshots/inspected_candidate.pdf`. O [registro de equivalência](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/checks/final_pdf_equivalence.json) cobre as 83 páginas finais. Uma omissão de glifo Delta pelo Poppler local na página 24 foi confrontada com Quartz, que mostra o rótulo correto. O PNG Quartz do PDF final é idêntico ao efetivamente inspecionado; a hipótese de defeito do conteúdo foi adjudicada como REFUTED em `adjudication/visual_candidate.json`.

## Limites de uso e reprodução

Os resultados de existência e comparação permanecem condicionados à classe de votos puros e às regras de crença, desempate e seleção de continuação declaradas. Algumas crenças não admitem equilíbrio nessa classe; o texto e o abstract o dizem expressamente. Não se afirma inexistência de equilíbrio em toda classe possível de estratégias.

Esta tarefa não formalizou provas em Lean, não refez uma auditoria de todos os fatos históricos ou de todas as alegações de originalidade e não oferece teste empírico da OMC. WTO é a categoria de submissão escolhida. Os limites bibliográficos, históricos e de aplicação não são apresentados como resultados demonstrados pelas revisões matemáticas.

Para reproduzir a composição a partir dos fontes anteriores preservados, executar `python3 quality_reports/coalition_protocol_2026-09-19/derivations/build_manuscript_candidate.py`. Esse comando escreve somente os previews separados; os hashes finais esperados são os da tabela inicial. O comando de compilação acima reproduz o PDF a partir do manuscrito canônico. Metadados de criação podem alterar o hash binário de uma nova compilação; `scripts/verify_coalition_pdf_20260919.py` verifica todas as páginas e o texto renderizado contra a cópia inspecionada.

Os contratos históricos conservam os caminhos que identificavam o manuscrito no momento das leituras. Após a integração, seus bytes originais devem ser recuperados em `snapshots/original/` ou no checkpoint Git, conforme o registro de integração. Os contratos e pareceres congelados não foram silenciosamente atualizados para cobrir o novo arquivo canônico.
