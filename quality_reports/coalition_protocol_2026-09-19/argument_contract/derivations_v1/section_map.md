# Mapa de leitura: derivações v1

**Contrato:** `coalition-derivations-v1:b62a7c8e0235:round1`. **Fonte:** [bundle](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md), SHA-256 `b62a7c8e023568bf408c1b8929b5909b4e7af21c3271c95955970237801b799f`.

B:a–b são linhas inclusivas do bundle. As dez unidades cobrem consecutivamente as 903 linhas; nenhuma supera 4.000 palavras brutas. O leitor independente `/root/provenance_inventory` leu o bundle integralmente e escreveu [independent_section_read.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v1/independent_section_read.md), hash `991663cef8090ce773865c7b81123f0a19be3a850eddd096155b14a7507c3b29`. O macro `/root/baseline_source_read` releu integralmente fonte e record.

| Unidade | Fonte | Função | Claims | Evidência | Dependências | Record de leitura |
|---|---|---|---|---|---|---|
| D01: Contrato de coalizão | [B:1–114](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:1) | Primitivas, payoffs completos, disciplina de crenças, estado e dependências. | C02, N01, N02 | Tabela de histórias; factibilidade e prova por casos B:73–84. | primitivas autorais | independent_section_read.md:32–57 |
| D02: R2: maioria e unanimidade | [B:115–193](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:115) | Folhas nativas que alimentam R1. | C06 | Ballots, todos os desvios, redução terminal e desempate p*. | D01 | independent_section_read.md:47–57 (cold R2:19–271) |
| D03: R1_M e representante anônimo | [B:194–319](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:194) | Deriva redução E/S/P, cutoffs, empates e kernel consumido pela agenda. | C07, N03 | Resposta de ballot; proposta mínima; tabela Π/H; representantes c/h. | D01, D02 | independent_section_read.md:59–80 |
| D04: R1_U, benchmark e baseline transportado | [B:320–405](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:320) | Regiões unânimes de ballot, inexistência e preservação econômica. | C08, C05, N08 | C=N constante; proposta s†; comparação pública inclusão/exclusão. | D01, D02 | independent_section_read.md:59–80,139–147 |
| D05: Agenda: contrato, Y_g e dependências | [B:406–501](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:406) | Define sinal informado completo e consumo das interfaces. | N03, N04, N08 | A1–A3; união disjunta de faces; disciplina pointwise; tabela c/h. | D01, D02, D03, D04 | independent_section_read.md:82–108 |
| D06: Agenda: consentimento, limites e público | [B:502–625](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:502) | Deriva votos, recuperação de C na passagem, custo, garantia e benchmarks. | N05, C12 | A-C1–A-C5, A4–A12. | D03, D05 | independent_section_read.md:90–98 |
| D07: Agenda: formas puras, existência e Borel | [B:626–705](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:626) | Caracteriza condições de payoff e melhor resposta no novo espaço. | N06 | A-C6/A-C7, tabela, três testemunhas para algum ρ, A13/A14. | D03, D05, D06 | independent_section_read.md:98–100 |
| D08: Agenda: contraexemplos, reversão e U | [B:706–773](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:706) | Mostra limites de equivalência M e o mapa literal U. | N07, N08 | A-EX1, A-EX2, testemunha mesma ρ=0, A-C8. | D04, D05, D06, D07 | independent_section_read.md:101–104 |
| D09: Agenda: kernels, leis e fatoração | [B:774–847](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:774) | Constrói leis completas e assinaturas com coalizões e votos efetivos. | N03, N09 | A15–A18; equivariância do representante; órbita S_m. | D03, D04, D05, D07 | independent_section_read.md:105–106 |
| D10: Impactos, checks e ledger | [B:848–903](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md:848) | Delimita consumidores preservados, refeitos e não transportados. | C15, C17, N09 | Tabela B:851–867; limites dos 409 checks; hashes das interfaces. | D01, D02, D03, D04, D05, D06, D07, D08, D09 | independent_section_read.md:107–137 |

R2 também tem [reconstrução fria independente](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/reviews/cold_r2_from_primitives.md), hash `57b83c8d83fad84f6f5ce41a6e34d75c60ede19b3e09c71d307bd7d70764896c`, feita antes de consultar as interfaces candidatas. Ela não é transformada aqui em adjudicação de todo o bundle.

## Tese e limites por unidade

| Unidade | Não-afirmação / limite | Ambiguidades |
|---|---|---|
| D01 | Não confunde implementabilidade com otimalidade; não exclui supercoalizões factíveis. | Sem ambiguidade material remanescente |
| D02 | Sem β interno; multiplicidade nominal R2_M mantida; nenhum resultado de R1 deduzido da malha fria. | Sem ambiguidade material remanescente |
| D03 | Representante uniforme é restrição da extensão, não toda a correspondência baseline. | Sem ambiguidade material remanescente |
| D04 | Endpoints explícitos têm prior degenerado; não certifica todas as histórias de suporte interior. | QI-01: resolvida por delimitação ao endpoint declarado |
| D05 | Não esconde C antes de Bayes nem substitui kernel por payoff escalar. | Sem ambiguidade material remanescente |
| D06 | Minimalidade de passagem usada vale q.c.; recusas maiores continuam possíveis. | Sem ambiguidade material remanescente |
| D07 | Não enumera todos os suportes nem prova bijeção histórica; desigualdade pointwise e igualdade q.c. distintas. | Sem ambiguidade material remanescente |
| D08 | Igualdade de payoff não implica identidade de estratégias; transporte U depende da validade histórica. | Sem ambiguidade material remanescente |
| D09 | Off-path completo permanece no binder; nenhuma assinatura comum antiga/nova alegada para M. | Sem ambiguidade material remanescente |
| D10 | Não certifica cientificamente o candidato nem generaliza testes finitos a leis Borel. | Sem ambiguidade material remanescente |

## Cadeia de consumo

Decisão → contrato (D01) → folhas nativas R2 (D02) → R1_M/U (D03/D04) → representante completo e contrato de sinais A (D05) → votos/garantias/benchmarks (D06) → propostas puras e Borel (D07) → exemplos e transportes delimitados (D08) → leis/assinaturas (D09) → comparações e consumidores (D10). As dependências históricas unânimes permanecem explícitas; ler B.4/B.8/E.3 do original para revisão científica.

Não há figuras no bundle. As tabelas são contratos, interfaces, formas puras, mapas de impacto e ledger. O script e output de 409 checks são artefatos auxiliares com limites finitos declarados; não foram executados pelo macro. Scripts de patch e qualquer futuro manuscrito integram outro escopo.

