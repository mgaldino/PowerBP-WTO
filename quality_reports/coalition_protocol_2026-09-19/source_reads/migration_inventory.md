# Inventário de migração para o protocolo de coalizão restrita

Data: 2026-09-19. Natureza: inventário documental e operacional, por agente distinto dos implementadores do baseline e da agenda. Não contém derivação, parecer formal, validação de equivalência, revisão visual ou autorização adicional.

## 1. Fronteira documental

A fonte inventariada é `formal_model_v6.Rmd`, SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`, no checkout `codex/exposition-items20-28`, HEAD `c6dfab61a5a3b44d09ba389911df47726f81b51e`. Todos os números de linha abaixo se referem a esses bytes anteriores à migração. A primeira edição do manuscrito torna necessário relocalizar as ocorrências pelos títulos, labels ou termos também fornecidos.

A decisão aplicável é `quality_reports/coalition_protocol_2026-09-19/author_decision.md`, SHA-256 `7abfa53814ff23c61a9af2049c975be81e44f8e66270c4fa3f99accd51923726`. O preflight correspondente está em `preflight/manifest.json`. O inventário não reabre a discussão histórica sobre PowerPieDependent nem toma o relatório focal de 8 de setembro como certificado da extensão de agenda.

A nova unidade contratual é `(C,x)`: o proponente pertence a C; C satisfaz a quota institucional; as alocações são não negativas, somam no máximo 1 e são zero fora de C; todos os convidados devem consentir; aprovação executa automaticamente o vetor. H fora de C recebe sua opção externa quando a coalizão implementa; um não de H convidado faz o pacote inteiro fracassar. A recusa em R1 leva à continuação; a recusa em R2 leva ao desacordo terminal. Não se acrescenta uma escolha individual de execução. A quota muda entre maioria e unanimidade; o procedimento de consentimento dos convidados é comum.

Categorias usadas nas tabelas:

- **P — protocolo:** definição, domínio, pagamento, informação ou representação que deve ser compatibilizado diretamente com a decisão.
- **E — econômico:** fórmula, região, correspondência, interpretação ou figura potencialmente reutilizável, condicionada à derivação e revisão no novo protocolo. Esta classificação não afirma invariância.
- **H — histórico:** contrato, teste, revisão ou manifesto que documenta bytes anteriores e deve ser preservado como tal. Um novo apontador pode declarar a supersessão; não se deve reescrever um PASS antigo para cobrir o candidato novo.

## 2. Manuscrito: baseline e regras transversais

| Localizador na fonte | Categoria | Conteúdo que exige migração ou conferência |
|---|---|---|
| YAML, linha 36; Introdução 41–147; ilustração 273–296 | P/E | O abstract e a apresentação dizem que a maioria substitui o voto de H, enquanto a unanimidade o exige. Conferir a descrição por inclusão em C e consentimento; conferir novamente todas as afirmações econômicas contra o resultado novo. O título e a contagem histórica de 137 palavras do abstract não devem ser tratados como campos finais se esses bytes mudarem. |
| Model, 301–312 | P | Jogadores, único informado, simetria, reconhecimento uniforme dos fracos: fundamentos preservados. A proposta passa a incluir C, além de x. |
| Proposals, 312–326, simplex em 317–318 | P | A ação é atualmente apenas `x` no simplex. Definir espaço de pares `(C,x)`, proponente em C, quota de cardinalidade e zero fora de C. Não converter a restrição aprovada para todos os jogadores em um teto especial para H. |
| Ballots, 330–338 | P | Texto explícito: “All other states vote simultaneously”. Atualmente a aprovação usa k votos adicionais em uma votação universal. Substituir pelo conjunto de convidados que deve consentir; separar quota para C de regra de sucesso do ballot. |
| Payoffs, 340–348 | P | Ramo explícito de aprovação majoritária com H votando não e cancelamento da sua parcela. Substituir por inclusão/exclusão contratual e sucesso/fracasso da proposta. |
| Rounds, 350–356 | P | Manter duas rodadas e desconto. Distinguir H não convidado de H convidado que recusou; a recusa não é saída irreversível. |
| Tabela do protocolo, 358–373, especialmente 364 e 366–368 | P | Colunas atuais “H votes yes/no”; linha 367 diz que `x_H` “is paid to no one”. Trocar a partição por composição da coalizão e resultado de consentimento; o payoff deve corresponder ao vetor factível implementado. |
| Histórias e continuações, 376–380 | P | Histórias indexadas pelo voto Y/N de H. Quando H não pertence a C, não há voto de H: registrar a exclusão, sem atribuir um não artificial que gere uma atualização de crenças. |
| Figura `fig:timing`, 382–409 | P | TikZ inline: proposta, ballot, “Quota met” e “Quota not met”, em ambas as rodadas. Atualizar nós, ramos e caption para convite/consentimento e quotas sobre C. Ver seção 4 deste inventário. |
| Solution, 411–445 | P | Redefinir os domínios de estratégias, ballots e histórias segundo C. Preservar apenas na forma compatível aprovada a disciplina de crenças, o voto condicional à pivotalidade e `T^Y`; tornar explícito quais jogadores de fato respondem. |
| Tabela de escopo, 447–464; especialmente 457 | P | A linha “Simultaneous public ballots; majority or unanimity” precisa distinguir a simultaneidade entre convidados da quota institucional da coalizão. |
| Anúncio da extensão, 466–479 | P | A rejeição da agenda entra em uma avaliação completa do novo baseline. O anúncio deve concordar com o contrato de agenda em E.1. |
| Resultados públicos, 487–543; privados terminais, 544–570; R1 maioria, 571–630; R1 unanimidade, 631–712 | E/P | Mapear cada proposição e tabela à derivação nova; propostas de exclusão/pooling/screening passam a carregar C. A coincidência de uma expressão numérica não conserva automaticamente provas, estratégias ou desvios. |
| Comparações privadas, 713–764; rendas, 765–887 | E | Revalidar domínios de existência e mapas de payoffs usados. As identidades de diferenças são candidatas a reaproveitamento; suas fontes e imagens devem ser do novo jogo. |
| Discussão 1242–1348 e conclusão 1349–1378 | P/E | Explicar a pivotalidade por participação convidada e quota. Manter pie fixa, opção externa fora da pie, ausência de externalidades e limites empíricos. A adoção do protocolo não importa produtividade ou excedente dependente de coalizão de PowerPieDependent. |
| Appendix A.1, 1385–1397 | P | Transição completa atualmente utiliza todos os votos, quota de votos e cancelamento em 1389. É um dos pontos centrais de substituição, inclusive fora do caminho. |
| Appendix A.2, 1401–1423 | P | Restringir vetores de voto aos convidados e incluir C na história pública. Adequar o caso de H não convidado e manter o suporte do prior e as regras aprovadas de Bayes/valores livres. |
| B.1, 1427–1459 | P/E | A prova terminal majoritária usa fracos adicionais votando sim, H não pivotal e `x_H` não pago após não (1436); o resultado `x_H=0`, H vota não e proponente fica com a pie aparece em 1443. Esse argumento é do protocolo antigo e deve ser substituído por derivação do novo espaço de coalizões. |
| B.2, 1460–1476 | E/P | Mesmo que C=N sob unanimidade, conferir a fonte contratual e os domínios antes de transportar a prova. |
| B.3, 1477–1531 | P/E | A partição `n_Y≥k`, `n_Y=k−1`, `n_Y≤k−2` (1482–1494) é uma partição da votação universal. O ramo de H não pivotal compara acordo `x_H` a desacordo `o` (1484–1488). Reescrever a arquitetura da prova; registrar separadamente quais candidatos econômicos sobrevivem. |
| B.4, 1532–1609; B.5–B.6, 1610–1647 | E/P | Conferir oferta/consentimento e continuação no novo domínio. Transportar resultados, comparação e rendas somente depois de fixar as fontes. |
| Appendix C, 2028–2072 | E | Endpoints, conjuntos exatos e envelopes dependem das correspondências novas; a representação set-valued permanece um instrumento a conferir, não uma certificação automática. |
| Appendix D, 2073–2138 | P/E | Linha 2087 define k como votos adicionais; 2092 define só x; 2106 define e por coalizão mínima; 2111–2123 definem posterior, avaliações e leis. Acrescentar C e o espaço conjunto, distinguir quota de consentimento e adaptar domínios. Evitar colisão com `C_j`, `C_H`, `\mathcal C` e usos de C como evento Borel. |

Ocorrências literais de cancelamento encontradas: 342–345 (descrição), 367–368 (tabela), 1389 (A.1) e 1436 (B.1). O raciocínio dependente da mesma arquitetura também está em 1482–1488 (B.3), mesmo onde a frase literal não aparece. Atualizar apenas as frases literais deixaria a prova e o sistema de histórias inconsistentes.

## 3. Manuscrito: agenda e objetos de avaliação

Esta seção serve de interface para o implementador da agenda; não deriva a extensão.

| Localizador | Categoria | Impacto documental |
|---|---|---|
| Extensão, 888–917 | P | H propõe uma divisão na data A. Substituir por `(C,x)` com H em C; somente convidados respondem; recusa entra no novo baseline. Rever significado de k, e e sinal público de proposta. |
| Resultados públicos, 918–1022 | E | Custos de coalizões mínimas, limiar de atraso, gap público e figura precisam de fonte nova revisada. |
| Resultados privados, 1023–1127 | P/E | Comparações de propostas e suporte de leis devem conter C. Conferir a caracterização da existência e o mapa visual. |
| Rendas/comparações/contabilidade, 1128–1241 | E | As diferenças e a identidade contábil precisam apontar às novas correspondências. Preservar separação entre datas e entre contraste contábil e efeito causal. |
| B.7, 1648–1830 | P/E | Prova de maioria trata propostas no simplex, suporte, imitação entre tipos, ballot completo e estratégias Borel. O espaço de mensagens passa a incluir C; a alegação de exaustividade e as perturbações fora de suporte não se transportam por troca de palavras. |
| B.8, 1831–1965 | P/E | Leis `\mathcal P(\mathcal X)` e famílias de propostas unanimistas; conferir o contrato C=N, continuação e domínio da prova. |
| B.9, 1966–2027 | P/E | Tipos dos registros realizados, ação de relabeling, medidas e invariantes devem carregar a nova coalizão e ballots dos convidados. C em 1990–1992 é evento Borel e pode colidir com o símbolo da coalizão. |
| E.1, 2142–2194 | P | Contrato primitivo: proposta só x em 2152–2157, todos os fracos votam e k/m votos aprovam em 2158–2162, história com “full ballot” em 2164–2169, leis/razão Bayes e rho comum em 2171–2193. É necessária a especificação explícita de propostas `(C,x)`, domínio do ballot e espaço de continuação. |
| E.2, 2195–2361 | P/E | A avaliação completa, payoff maps, leis propostas e pushforwards em 2252–2342 precisam incluir C; a história já contém “coalition” em 2310, mas isso não basta para redefinir a ação inicial. |
| E.3, 2362–2568 | P/E | Em 2395 o ballot é um mapa `\mathcal X→{Y,N}^m`; adaptar ou justificar a redução C=N. Rever posterior, seletor literal de continuação e registros realizados em 2523. |
| E.4–E.5, 2569–2657 | E/P | Comparação a uma especificação fixa e região suficiente precisam consumir as avaliações novas, preservando vínculo entre tipos e suporte. |
| E.6–E.8, 2658–2725 | E | Formas públicas, coalizões mínimas, loterias e gap: candidatos econômicos a conferir. |
| E.9–E.14, 2726–2955 | E | Rendas, decomposição, contabilidade, diferenças e contraste diagonal dependem das fontes acima; não trocar uma tradução contábil por prova do novo jogo. |
| F.1, 2958–3039 | P/E | Assinaturas, leis realizadas e mapas anônimos devem ter os tipos novos; a estrutura genérica de órbitas não dispensa atualizar a lei da coalizão e o domínio dos mapas. |
| F.2–F.4, 3040–3117 | E/P | Comparação com baseline, datas, existência e limites. Linhas 3101–3104 atribuem completude/existência/fatoração a B.7–B.9: conferir essa atribuição após a nova prova, sem utilizar os PASS históricos como substituto. |

## 4. Figuras e seus geradores

Há **seis ambientes de figura no manuscrito atual**: uma figura TikZ de protocolo e cinco PDFs externos. A numeração abaixo é a ordem no texto. Além deles, o gerador de baseline produz um quarto bundle auxiliar que não está incluído no Rmd.

| Figura/label e localizador no Rmd | Entrada e gerador | Tratamento |
|---|---|---|
| 1, `fig:timing`, 382–409 | TikZ inline, ambiente em 385–403. Gerado na própria compilação bookdown/XeLaTeX do Rmd. Não há um script R separado responsável por esta figura. | **P**: convite `(C,x)`, consentimento dos membros e sucesso/fracasso em R1/R2; atualizar caption e ramos “Quota met/not met”. |
| 2, `fig:prices`, 703–711; include 705 | `figures/essential_input/figure_f2_prices_coalitions.pdf`; `scripts/generate_essential_input_manuscript_figures.R:108–116`; dados/plot em `essential_input_manuscript_figure_functions.R:703–1019`. | **E/P**: custos e alocações dependem das fórmulas; rótulo “Substitute votes” e caption devem ser semanticamente compatíveis com convidados/consentimento. |
| 3, `fig:privatecompare`, 744–752; include 746 | `figure_f1_private_comparison.pdf` no mesmo diretório; gerador 99–106; funções `essential_input_f1_data` (270 em diante), `essential_input_f1_final_data` (1624) e `plot_essential_input_f1_final` (1642). | **E**: regiões por tipo, fronteiras, endpoints e célula sem PBE precisam de certificação no novo modelo. |
| 4, `fig:rents`, 877–886; include 879 | `figure_f3_power_information.pdf`; gerador 118–125; `essential_input_f3_final_data:1728–1771`, plot 1774 em diante. | **E**: lê N3/N4 e calcula benchmark público diretamente; não basta atualizar caption. |
| 5, `fig:agendagap`, 979–990; include 981 | `figures/agenda_extension/figure_agenda_public_gap.pdf`; `scripts/generate_agenda_extension_figures.R:82–202`, save 340. | **E**: fórmulas e limiares codificados no próprio script, sem importação de módulo de resultados. Conferir fonte nova antes de regenerar. |
| 6, `fig:agendaexistence`, 1058–1072; include 1060 | `figure_agenda_unanimity_existence.pdf` no mesmo diretório; gerador de agenda 204–337, save 341. | **E**: mapa de famílias, fronteiras abertas/fechadas e não existência no domínio novo. |
| Auxiliar, sem include no Rmd | `figures/essential_input/figure_f4_hegemonic_decline.{pdf,png}` e `_data.csv`; gerador 127–134; funções 1191–1336. | Não integra as seis figuras atuais. Se continuar sendo entregue como bundle corrente, conferir/regenerar e registrar sua fonte; caso contrário preservar identificado como legado. |

Cada bundle externo é composto por PDF, PNG e `_data.csv`. Os geradores também gravam `figures/essential_input/essential_input_manuscript_figure_manifest.csv` e `figures/agenda_extension/agenda_extension_figure_manifest.csv`. A alteração de uma figura exige correspondência entre gráfico, dados, caption e manifesto do candidato; uma figura numericamente idêntica ainda precisa de proveniência explícita de transporte.

Dependências observadas:

- O gerador de baseline importa `scripts/essential_input_formulas.R` e `scripts/essential_input_manuscript_figure_functions.R` (linhas 22–26), verifica suas fontes e fixa N6/N7 (31–45). O manifesto de baseline declara N6 `a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92` e N7 `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45` em todas as linhas.
- `essential_input_formulas.R:30–58` fixa oito arquivos de interfaces/derivações N1–N4 e a decisão de conceito de solução. A função de figuras também fixa N6 em 8–31. Esses pinos documentam o modelo congelado; alterá-los sem nova fonte revisada apagaria a fronteira entre resultado histórico e resultado do candidato.
- O gerador de agenda contém internamente gap público (82–128) e condições de existência (204–240). Seu manifesto lista caminhos e dimensões, sem hashes de fonte: o manifesto novo do candidato deve identificar quais derivações revisadas justificam esses números, mesmo se o desenho for preservado.
- `scripts/generate_essential_input_draft_figures.R`, `figures/draft/`, `figures/old/` e figuras `relative_package_*` não são as cinco entradas externas do v6 atual. Preservar os artefatos históricos; não regenerar em lote para esta migração.
- `scripts/split_for_submission.py:3–17` usa **formal_model_v5.tex** e escreve em **RIO submission files/**; sua função de extração de TikZ não é o gerador da figura do v6. Este script e essas saídas são protegidos e não devem ser acionados para preparar o candidato atual.

## 5. Scripts de verificação e infraestrutura

| Arquivos ou família | Classificação e ação documental |
|---|---|
| `scripts/essential_input_formulas.R` | **H/E**: única fonte de fórmulas do harness N1–N4 e das figuras atuais, fixada aos contratos antigos. Reutilizar como comparador histórico ou criar uma camada/fonte do candidato; não atribuir ao hash antigo revisão do jogo novo. |
| `scripts/essential_input_numeric_helpers.R:182–347` | **H/P/E**: gera candidatos de posterior, perfis de ballot e solvers “primitivos”. Um novo harness precisa representar C e consentimento; a enumeração antiga de ballots não verifica o novo espaço de estratégias. |
| `scripts/run_verify_essential_input_n1_n4_numeric.R`; `verify_essential_input_n1_numeric.R` até `n4_numeric.R`; `verify_essential_input_numeric_boundaries.R` | **H/E**: consomem módulos congelados. Podem continuar reproduzindo o passado; resultados do novo jogo exigem testes identificados separadamente, com cobertura declarada de coalizões, convidados, fracasso, continuações e endpoints. Não executados neste inventário. |
| `verify_essential_input_gate0.R`, `verify_essential_input_n1.R`, `n2.R`, `n3.R`, `n6.R`, `n7.R`, `verify_essential_input_solution_concept_rederivation.R` | **H**: verificadores de contratos/resultados históricos. Preservar artefatos e relatórios; qualquer reutilização como controle auxiliar deve mencionar seu escopo, sem chamar o novo candidato de certificado por eles. |
| `scripts/ri_estimand_functions.R` | Utilidades de diferenças de conjuntos, envelopes, média ex ante e rendas. Candidatas a reutilização aritmética, desde que recebam os novos objetos. Não é importação direta dos dois geradores finais identificados; não inferir certificação formal de seus argumentos. |
| `scripts/verify_agenda_extension_A_M_msb.R`, `A_U_msb.R`, `AC_msb.R`, `AR_msb.R`, `AT_msb.R` | **H/P/E**: fazem checks de objetos congelados e fontes M/S/B. A mudança em proposta, história e tipos dos objetos exige uma interface nova; os outputs antigos continuam ligados a seus hashes. |
| `scripts/verify_agenda_extension_status_current.R`; `scripts/verify_agenda_extension_migration_matrix.R` | **H/administrativo**: verificam hashes/pinos de registros históricos. O segundo ainda fixa o snapshot do v6 de agosto em 185–186. Não converter esses checks em PASS de migração atual apenas substituindo hashes. Atualização de apontadores atuais pode exigir um verificador administrativo separado. |
| `scripts/verify_architecture_20260908.R`, `validate_architecture_20260908.py`, `render_architecture_20260908.R` | **H**: pacote condicional A1–A3 não adotado pelo protocolo novo. Preservar fonte, tests, outputs, PDF e reviews; não reutilizar seu resultado como certificado de consentimento coalizional. |
| `scripts/verify_peio_preflight_20260919.py` | **H/administrativo**: verifica manifesto da arquitetura de 8/9 e snapshot do preflight PEIO anterior à decisão nova. Manter reprodução do diagnóstico passado; a verificação final do candidato exige um manifesto novo com seus próprios hashes e escopo. |
| Famílias `clean_optout`, `pivotal_response`, `relative_package`, `baseline_piH0` e antigos verificadores de agenda `goal1`, `mechanical`, `explicit` | **H**: proveniência de arquiteturas anteriores. A presença de palavras iguais ou de `fig:timing` em um teste antigo não o torna verificador corrente. |

## 6. Instruções, apontadores atuais e registros a preservar

| Fonte e localizador | Ajuste ou preservação necessário |
|---|---|
| `AGENTS.md:3,16–25,33–37` | Acrescentar a decisão de 19/9 como autoridade corrente. Atualizar fundamentos 1/2/4/5 nos aspectos que a decisão expressamente substitui; tornar o fundamento 7 coerente com convidados que podem vetar o pacote. Preservar fundamentos 3/6/8 e o escopo distributivo. |
| `AGENTS.md:43–46` | Domínio dos ballots, história com C e ramo sem voto de H; preservar simultaneidade, revelação posterior, descontos, suporte e desempates conforme a compatibilidade aprovada. |
| `AGENTS.md:49–55` | As obrigações antigas partem de `x_H>0` junto com aprovação após não de H. A decisão nova impõe zero fora de C para todos e faz a recusa de convidado fracassar. Registrar explicitamente a supersessão dessa arquitetura, mantendo a obrigação de cobrir todos os desvios factíveis do novo jogo. Não manter como proibição vigente a frase de 51 que vetava acrescentar `x_H=0` ao espaço antigo. |
| `AGENTS.md:59–64,68–72` | Preservar separação entre implementação e revisores, revisão por hashes, bookdown e limites de ações externas. A decisão nova já autoriza derivação, revisão e integração no escopo registrado; não a converter em pedido repetido da mesma aprovação. |
| `CLAUDE.md:18–56,203–208` | Status do topo e da fase descreve snapshots antigos. Acrescentar apontador corrente para o protocolo novo e identificar explicitamente o alcance histórico de cada PASS/tag; não apagar os hashes do passado. |
| `CLAUDE.md:58–98`, especialmente 70–86 | Bloco de fundamentos ainda contém cancelamento de alocação a não parte (82–83) e proibição de qualquer restrição além do simplex (85–86). Marcar a supersessão e apresentar a regra corrente `(C,x)`. |
| `CLAUDE.md:101–143,145–201,228–235` | O bloco “ARQUITETURA CORRENTE” de agosto afirma que todos votam (110), que o contrato antigo prevalece (103–105), e o protocolo de 228–232 repete todos os demais Estados votando. Harmonizar autoridade atual e domínios. Manter os registros antigos de solução claramente datados, sem reativar conceitos já substituídos. |
| `CLAUDE.md:247–270,683,698–701` | Resumo de baseline “a rederivar” e status de frase parqueada são históricos. Acrescentar leitura corrente; distinguir escolha endógena de excluir H de zero fora de C como factibilidade aprovada. |
| `CLAUDE.md:649–664` | Preservar a separação entre este paper com pie fixa e projeto futuro de surplus dependente da participação. A nova decisão importa protocolo de coalizão, não o canal econômico do projeto PowerPieDependent. |
| `model_redesign/agenda_extension_STATUS.md:3–28` e `agenda_extension_status_current.json` | Registros administrativos datados de 31/8; os nós A_M/A_U/A_C/A_R/A_T permanecem pass/frozen apenas nos contratos antigos. Um apontador/overlay corrente precisa declarar que esses freezes não certificam o protocolo novo. Preservar entradas e manifestos históricos; não renomear seus resultados como resultados coalizionais. |
| `model_redesign/essential_input_game_dag.json`, interfaces e derivação congeladas N1–N7; DAGs históricos da agenda | **H**: preservar grafo, contratos, fontes e hashes. A derivação coalizional deve ter seu contrato/manifesto próprio e rastrear as dependências efetivamente reutilizadas. |
| `quality_reports/plans/2026-08-30_agenda_extension_migration_matrix.{md,tsv}` e seus manifestos editoriais/expandidos de 31/8 | **H**: matriz da migração anterior. Usar como índice de origem dos blocos, não como autorização ou confirmação do novo transporte. A tarefa atual precisa de matriz/manifesto próprio. |
| `quality_reports/2026-09-02_b1_b3_manuscript_migration_manifest.sha256` | **H**: registra a migração que usa a regra histórica em B.1/B.3. Não alterar para dissimular a substituição da prova. |
| `quality_reports/2026-09-02_item13_proof_transport_manifest.md:8–35` | **H**: cobre B.7–B.9, E.2–E.3, F.1 e fontes congeladas de agenda. Preservar; registrar novo transporte e sua revisão no candidato coalizional. |
| `quality_reports/2026-09-02_exposition_items20_28_manifest.md:11–40,65–83` | **H**: cobre exposição e figuras do Rmd de hash 6708…; não é revisão do protocolo novo. Preservar sua cadeia de figuras e reviews. |
| `quality_reports/architecture_2026-09-08/` e `2026-09-08_evdokimov_protocol_equivalence_check.md` | **H**: conservar pacote condicional e análise focal. A escolha autoral de hoje está no novo registro; o pacote de 8/9 não passa a ser adotado retrospectivamente. |
| `quality_reports/peio_2027_2026-09-19/status.json`, `retomada.md` | Apontadores correntes ainda dizem `A1_REJECTED_REASSESS_PAYOFF_ARCHITECTURE` e arquitetura pendente. Precisam apontar à decisão coalizional adotada e às fases efetivamente concluídas, quando o coordenador atualizar o estado. |
| Diagnóstico, PDF, reviews, `verification.json`, campos provisórios e `delivery_manifest.json` do pacote PEIO anterior | **H**: documentam a preparação anterior à decisão. Preservar resultados e limites; criar atualização/finalização com hashes do candidato novo, sem atribuir à inspeção documental anterior uma revisão científica ou visual do novo PDF. |
| `formal_model_v5.Rmd`, `RIO submission files/`, snapshots/tagueados e pareceres congelados | **H/protegido**: nenhuma alteração necessária ou autorizada por este inventário. |

## 7. Verificação executada e limite

Foram lidos a decisão nova, o preflight, os blocos pertinentes do Rmd e das instruções, os dois geradores finais, seus módulos diretamente importados, os manifestos de figuras e os registros de migração/status acima. Buscas dirigidas por `includegraphics`, `tikzpicture`, `quota`, `full ballot`, `paid to no one`, `simultaneous`, importações e pinos de fonte localizaram as dependências. O inventário das seis figuras foi conferido contra todas as inclusões externas e o ambiente TikZ no Rmd fixado.

Nenhum resultado foi derivado, nenhuma equivalência foi validada, nenhum teste formal ou numérico foi executado e nenhum PDF foi compilado ou inspecionado visualmente nesta subtarefa. “Potencialmente reutilizável” significa apenas que o item é uma expressão econômica ou estrutura geral a examinar, não um resultado aprovado no protocolo novo. Não há afirmação de submissão pronta.

O único arquivo criado por esta subtarefa é este relatório. Fontes, scripts, instruções, candidatos e manifestos não foram editados. Os hashes abaixo fixam os arquivos centrais lidos para tornar verificável o alcance documental.

## 8. Hashes das fontes centrais lidas

| Caminho relativo ao repositório | SHA-256 |
|---|---|
| `formal_model_v6.Rmd` | `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411` |
| `AGENTS.md` | `122a3a53047f9c8c3305a6d768c20687a5833287bf001420661f7fb7564f0098` |
| `CLAUDE.md` | `75a6c15a527e99440209993b24ddf0dbcaaeaf9965004b7d0a7c43926a32406a` |
| `quality_reports/coalition_protocol_2026-09-19/author_decision.md` | `7abfa53814ff23c61a9af2049c975be81e44f8e66270c4fa3f99accd51923726` |
| `quality_reports/coalition_protocol_2026-09-19/preflight/manifest.json` | `9612917dda8d71b738e2088f4ec444ff47b230c1af62eaf2c07f1cd96411bbb6` |
| `scripts/generate_essential_input_manuscript_figures.R` | `5fbfdb82f5588d74f1a0bb647ea8fea367475acb5f22612e49a273ddc6e9efed` |
| `scripts/essential_input_manuscript_figure_functions.R` | `54849bd55cd04d256458724920b6bd7ba72b2ac437939e05050a863e9a54774d` |
| `scripts/essential_input_formulas.R` | `91014a9691b7d6ce52a776d8ff7b323cf68f284be24cb354295393da173594ad` |
| `scripts/essential_input_numeric_helpers.R` | `aac5550e5b724ca65bda718105fd5f178ed16bdf4edfc80de364e093bfcde37b` |
| `scripts/ri_estimand_functions.R` | `a480d8cae0c626e0b3ab2af4e5e662008a75980ee78a5b99408a0e082948c0df` |
| `scripts/generate_agenda_extension_figures.R` | `97f18ecf1f786aee5481011620d200d0495f7f8243a0f222eca8ae53ed8a5a09` |
| `figures/essential_input/essential_input_manuscript_figure_manifest.csv` | `eb7563341759acc495b8e8cfb62f49e5816ead78615ce18e74c63d75bb5949ff` |
| `figures/agenda_extension/agenda_extension_figure_manifest.csv` | `91b4a415e9ed6b5476795af064ce689175d93128e1a70c34b3368b5e2b1409c9` |
| `model_redesign/agenda_extension_STATUS.md` | `ec00fc2f71ca9d857f279a848cd51650143893b4f52fc18c50096a61d333fc69` |
| `model_redesign/agenda_extension_status_current.json` | `0b12be9269859e59a36f35c1756e80b7b93493b1c822c58f660098992606d592` |
| `quality_reports/2026-09-02_item13_proof_transport_manifest.md` | `776c4f50be91207d40d1a190081f7bf4d9733e45e6802d34ac66b535792d9ea7` |
| `quality_reports/2026-09-02_exposition_items20_28_manifest.md` | `e97e01b55f7c52cca0cd228b71aa5bc3435f97a1c6f0b30131f56071299e0d5a` |
| `quality_reports/2026-09-02_b1_b3_manuscript_migration_manifest.sha256` | `2c7269708396e156af679284559115f10295a0fb31421edf4a7d406eff3fb3ac` |
| `quality_reports/peio_2027_2026-09-19/status.json` | `6d293aa36f7f2b4ed8f6a66170da78b9a75cca79f56a31dcb3e2153be2fbd147` |
