# Revalidação por impacto: notas matemáticas novas

**Classificação:** `substantive_scoped`. **Novo contrato:** `coalition-derivations-v1:b62a7c8e0235:round1`. **Status interpretativo:** PASS, limitado ao bundle.

## Relação entre os objetos

Base: [contrato original](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/original/argument_contract.json), ID `informational-power-original:6708eaafca2f7:round1`, record SHA-256 `ae46ab5718d1ccff6f3289ab44fc6ba37c4ccb5904656808caa16d8a5a2899fe`, fonte Rmd `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`.

Atual: [bundle](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v1.md), SHA-256 `b62a7c8e023568bf408c1b8929b5909b4e7af21c3271c95955970237801b799f`; quatro fontes e hashes no [contrato](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v1/argument_contract.json) e manifesto `reviews/derivation_candidate_v1.json` de hash `8dfefecda3b9e369159bbfeb4276f5f6d7c2402e3e897320774b39be12d1feca`.

Esta é uma comparação de argumento entre manuscrito original e novas notas de derivação, fora do manuscrito. Não é um diff editorial nem uma revalidação do manuscrito integrado. A decisão autoral de 19/09 resolve a arquitetura; o gate apenas registra o que a candidata matemática afirma nessa arquitetura.

## Impacto e dependências reexaminadas

| Alteração | Base original | Novo bundle | Consequência para a leitura |
|---|---|---|---|
| Quota de votos universal → coalizão factível e consentimento integral | M:299–409,1383–1423 | B:14–84 | Payoffs completos passam a depender de C; ramo de cancelamento histórico não é importado. |
| Factibilidade x fora de C zero | Original simplex irrestrito por membresia | B:20–43,75–84 | Não acumulação é arquitetural, válida para desvios; não mero resultado de escolha ótima. |
| R2/R1 majoritárias | M:544–629,1460–1530 | B:123–318 | Mesmos valores alegados com nova derivação, coalizões/votos literais diferentes e multiplicidade nominal preservada. |
| R1/U e suporte | M:631–711,1532–1608 | B:320–381 | Mapa C=N e fechamento explícito; QI-01 restringe endpoint à seleção declarada. |
| Sinal x → (C,x) na agenda M | M:2142–2360 | B:423–705 | Nova geometria do suporte, Bayes, ballots e critérios de desvio; nenhuma bijeção global com medidas antigas. |
| Exemplos e limites de equivalência | Exemplo M:999–1021 | B:707–763 | Dois contraexemplos e uma nova testemunha de reversão; não igualdade de toda a correspondência. |
| Transporte U | M:B.4/B.8/E.3 e consumidores | B:765–773 | Isomorfismo não certifica a prova histórica, que continua na revisão formal. |
| Kernels, laws e assinaturas | M:1966–2027,2958–3038 | B:775–847 | Novos espaços retêm C/⊥; redefinição e fatoração próprias, sem identidade global M. |
| Comparações e contabilidade | M:1104–1240,2608–3117 | B:849–901 | Bounds e identidades consomem novas fontes; vazios, vínculo e condicionalidade permanecem. |

## Leituras utilizadas e integridade

- Leitura macro integral das 903 linhas e da decisão autoral: `/root/baseline_source_read`, sem participação na implementação das quatro notas.
- Leitura independente integral: [independent_section_read.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v1/independent_section_read.md), `/root/provenance_inventory`, hash `991663cef8090ce773865c7b81123f0a19be3a850eddd096155b14a7507c3b29`; nenhuma crítica científica nessa leitura.
- [Folha fria R2](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/reviews/cold_r2_from_primitives.md), hash `57b83c8d83fad84f6f5ce41a6e34d75c60ede19b3e09c71d307bd7d70764896c`; reconstrução feita sem consultar soluções candidatas. Lida como fonte independente delimitada, não como aprovação de R1/agenda.
- O contrato original e suas três leituras são reaproveitados somente para identificar claims/dependências antigos. As novas primitivas e notas foram lidas novamente; não se trocou simplesmente o hash do PASS anterior.
- Os sete hashes do manifesto atual foram conferidos e os quatro payloads matemáticos comparados à reprodução no bundle. Os 409 checks reportados não foram reexecutados pelo macro.

## Linhagem de claims

IDs C02/C05/C06/C07/C08/C12/C15/C17 identificam conteúdos econômicos/primitivos preservados no alcance descrito, com provas/protocolo ou fontes novas onde indicado. IDs N01–N09 registram mudanças ou construções adicionais. A tabela exata separa preservação econômica e preservação estratégica:

| Claim atual | Vínculo anterior | Tipo de mudança |
|---|---|---|
| C02 | C02 | preserved |
| N01 | C03 | modified |
| N02 | C04 | adapted |
| C06 | C06 | preserved_payoff_claim_with_new_protocol_proof |
| C07 | C07 | preserved_economic_claim_new_derivation |
| N03 | C11, C13 | new_explicit_interface |
| C08 | C08 | preserved |
| C05 | C05, C09, C10 | preserved_economic_claim |
| N04 | C11 | modified |
| N05 | C13 | new_derivation |
| C12 | C12 | preserved |
| N06 | C13 | modified |
| N07 | C16 | new |
| N08 | C08, C14 | new_transport_statement |
| N09 | C18 | modified |
| C15 | C15 | preserved |
| C17 | C17 | preserved_identity_new_sources |

Os claims de framing, aplicação à OMC e literatura não são revalidados por estas notas. As compressões da introdução sobre zero de IR na exclusão e o referente de “In those cases”, registradas em R01/R02 do contrato original, precisam de conferência de consistência após migração. Nenhum texto foi alterado aqui.

## Ambiguidades e gate

QI-01 sobre posterior degenerado/suporte inicial foi levantada tanto pelo macro quanto pelo leitor independente e resolvida com o implementador: o fechamento explícito usa jogos endpoint e sua seleção declarada; não cobre por inferência todo histórico de suporte interior. QI-02–04 preservam limites explicitamente escritos: fechamento não é aprovação, isomorfismo não prova matemática histórica e quase certeza não é igualdade em todo suporte. QI-05 registra a confirmação de intenção do implementador para B:705: "supported on its argmax" significa probabilidade um no argmax, sem contenção topológica obrigatória do suporte. A revisão científica deverá adjudicar se essa precisão é só expositiva; este gate não altera o bundle nem resolve a prova.

Cobertura, âncoras, escopo, não-afirmações, campos empíricos inaplicáveis, resolução de ambiguidades e hash estão satisfeitos para fidelidade. O validador JSON e o [contrato](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v1/argument_contract.md) registram o resultado mecânico. Nenhum veredito científico é emitido. Mudança em um fonte, domínio, kernel ou exemplo exige revalidação das dependências pertinentes e impede usar este PASS para bytes novos.
