# Adjudicação: exclusão e obrigação de prova

Veredicto: `READY_FOR_IMPLEMENTATION`. Registro: `pbp-architecture-clarification:695069a7b432:round1-agents-only`.

## Fonte e escopo

Artefato principal: `/private/tmp/pbp-architecture-clarification-2026-09-05/before/AGENTS.md`.
SHA-256: `695069a7b432a3204f43619931c211c8327f8533b30d3cfa969e42bba3806522`.

Diagnóstico estreito da regra de payoff e de sua obrigação de prova, conforme o mandato recebido. Não é uma revisão integral do argumento ou do manuscrito.

A transcrição literal da correção autoral está em `/private/tmp/pbp-architecture-clarification-2026-09-05/review_sources/author_correction.md`, SHA-256 `69cb27404295c3f3466222a6d61edd13896978c6f70159db2a58aecf8e3128a9`. O JSON preserva a transcrição e distingue dela o resumo do mandato.

As identidades adicionais e os hashes dos pareceres constam no JSON e em `identity_checks.json`. Todos os inputs selecionados conferiram com os snapshots.

## Encaminhamento

- R1-F001 e R2-F005 confirmam a necessidade de atualizar as instruções após a correção autoral.
- As intervenções seguras registram status e obrigação de prova sem depender da resolução de R1-F004.
- O record global BLOCKED é preservado e referenciado; nenhuma revisão substantiva do jogo é encaminhada.

Registro global preservado: `/private/tmp/pbp-architecture-clarification-2026-09-05/adjudication/adjudication_round1_global.json`, SHA-256 `938a2f6d539b082ac6397d5aa87087ca1bd96e5f52ef51be72a27c9918e94f85`.

Independência da parte segura:

- Os dois findings encaminhados corrigem a afirmação de que a antiga primitiva encerra a questão. Sua correção consiste em marcar que a questão está em aberto.
- A redação de uma obrigação de prova não escolhe o payoff do ramo contestado, não modifica as ações ou as crenças e não pressupõe que o resultado desejado exista.
- R1-F004 deve continuar identificado como não resolvido na nota e nas instruções. A revisão da arquitetura ou migração ao manuscrito não é encaminhada.

Demais IDs mantidos no registro global: R1-F002, R1-F003, R1-F004, R2-F001, R2-F002, R2-F003, R2-F004.

R1-F004: não impede registrar uma pendência; impede certificar ou implementar uma arquitetura que a resolva.

## Findings

| ID | Status | Objeto | Correção proposta |
| --- | --- | --- | --- |
| R1-F001 | CONFIRMED | A regra contestada ainda aparece como primitiva | safe |
| R2-F005 | CONFIRMED | A instrução deve exigir uma demonstração e manter a pendência visível | safe |

As contagens deste componente cobrem apenas duas correções de instruções. As demais observações e a pendência material permanecem no registro global.

## R1-F001: A regra contestada ainda aparece como primitiva

Status: `CONFIRMED`. Tipo: `scope_or_consistency`. Severidade: `major`. Dimensão: `mechanism_and_instruction_fidelity`.

Fonte: R1, linhas 5–7. Decisão mantida do autor: sim.

Texto do parecer:

> A exigência nova ainda não está demonstrada pelas provas atuais. Elas demonstram a escolha ótima `x_H=0` quando os votos fracos bastam, mas definem previamente o pagamento de H após votar não como `o`, cancelando `x_H`.
> 
> 1. **A vedação está nas primitivas.** O manuscrito (`formal_model_v6.Rmd:340`) diz que, após aprovação com voto não de H, sua fatia não é paga a ninguém; a Appendix A (`formal_model_v6.Rmd:1385`) repete a regra para todas as histórias. O memorando de derivação (`quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:24`) a identifica expressamente como input. Portanto, não se pode apresentar essa exclusividade em toda história como conclusão de racionalidade.

Localizadores: AGENTS.md:21,27,33,39; formal_model_v6.Rmd:340-348,1385-1397; quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:24-32.

Evidência:

- AGENTS.md:21 determina o recebimento de o_theta sem x_H e o não pagamento da fatia; a frase final afirma que H nunca recebe ambos.
- O manuscrito define essa regra antes das provas, e o memo a lista no mandato como correção de payoff recebida como input.
- review_sources/author_correction.md:5 exige sustentação pela arquitetura e pelos incentivos e contesta essa solução por estipulação.

Há incompatibilidade entre o caráter inviolável dado à regra no AGENTS e o mandato atual. Isso não demonstra que as provas antigas sejam internamente falsas no jogo que especificam. Demonstra que usar esse input como evidência do novo requisito seria circular. A transcrição literal da correção autoral foi preservada como fonte adicional.

Encaminhamento: Atualizar apenas as instruções e a nota de estado: identificar a antiga regra como contestada e registrar a obrigação de prova. Preservar manuscrito, contratos e candidatos históricos; não instalar uma nova função de payoff.

## R2-F005: A instrução deve exigir uma demonstração e manter a pendência visível

Status: `CONFIRMED`. Tipo: `scope_or_consistency`. Severidade: `major`. Dimensão: `instruction_fidelity`.

Fonte: R2, linhas 31–35. Decisão mantida do autor: sim.

Texto do parecer:

> Minha sugestão de redação operacional é:
> 
> > A ausência de recebimento simultâneo de alocação positiva e opção externa por H deve ser sustentada pela arquitetura econômica e pelos incentivos do jogo. Derivar as propostas ótimas dos fracos em cada conjunto de informação, alcançado ou não no equilíbrio, usando as crenças admissíveis e as continuações previamente resolvidas. Verificar se uma proposta ótima com `x_H>0` pode ser aprovada quando algum tipo de H vota não, distinguindo os tipos com probabilidade posterior positiva dos demais tipos factíveis. Demonstrar por comparação de desvios qualquer alegação de que uma concessão positiva a H é desperdício; não usar essa alegação como restrição primitiva às propostas. Payoffs e comportamento após propostas desviadoras devem estar definidos. Se a arquitetura permitir o recebimento simultâneo que se pretende excluir, registrar a incompatibilidade e apresentar a revisão substantiva necessária.
> 
> **Status:** insuficiência da condição literal e lema terminal demonstrados; extensão dinâmica e cobertura dos ramos após propostas desviadoras permanecem pendentes da arquitetura completa. Não editei arquivos nem li a proposta de redação do implementador.

Localizadores: AGENTS.md:21-27,33,39,43-56; review_sources/offpath_requirement.md:31-35; review_sources/architecture_dependency.md:19-25.

Evidência:

- O AGENTS atual trata o cancelamento e a ausência de recebimento conjunto como regras já fixadas; não atribui a ausência de acúmulo a uma obrigação de demonstração pendente.
- As cláusulas de autorização e separação de revisão já existentes permitem registrar a exigência sem editar primitivas, provas ou manuscrito.

A direção operacional proposta é compatível com a correção literal em review_sources/author_correction.md:5: tornar a antiga estipulação contestada e exigir derivação das propostas e das respostas em cada histórico pertinente. A redação precisa preservar a distinção entre alvos de prova e restrições ao jogo. A implementação deve apontar para a nota dessa decisão.

Encaminhamento: Corrigir apenas AGENTS e nota de estado, mantendo payoffs dos fracos, votos simultâneos e continuação quando a proposta fracassa. Proibir a certificação do requisito com base apenas na antiga estipulação; não fixar automaticamente uma arquitetura alternativa.

## Correções inseguras e decisões do autor

- Converter o evento a provar em restrição adicional ao espaço de propostas.
- Manter o cancelamento de x_H como axioma e apresentá-lo como consequência de racionalidade.
- Adotar x_H+o como nova regra de payoff sem desenho e autorização.
- Eliminar histórias factíveis após desvios por serem subótimas.
- Inserir uma escolha de H depois da divulgação dos votos, um opt-out imediato após fracasso ou um novo desempate.
- Transportar limiares, estratégias completas ou resultados históricos para uma arquitetura nova sem rederivação.

- Qual revisão substantiva da arquitetura adotar, se necessária, e qual seu escopo de implementação. A exigência de sustentar a ausência de acúmulo é mantida; a solução econômica ainda não foi escolhida.

## Pendências e limites

R1-F004 permanece não resolvido no registro global. A ausência de um finding refutado não equivale a uma certificação global das proposições do manuscrito.

- Nenhuma edição de repositório, candidato ou artefato congelado.
- Nenhuma auditoria integral do paper ou da extensão de agenda.
- Nenhuma busca de equilíbrio, nova solução de jogo ou certificação matemática global.

Contagens: {"total": 2, "confirmed": 2, "partial": 0, "refuted": 0, "unresolved": 0, "held_decisions": 2}.

Veredicto: `READY_FOR_IMPLEMENTATION`.
