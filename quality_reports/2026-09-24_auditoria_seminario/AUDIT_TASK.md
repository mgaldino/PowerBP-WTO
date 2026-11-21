# Instruções da auditoria informacao

Fonte congelada: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/2026-09-24_auditoria_seminario/inputs/formal_model_v6.Rmd`.
SHA-256: `9356d86a2e893481968ee96a918c2109e726444c5d902ce88edd6f1a5d86345f`.
Pasta de trabalho e entregas: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/2026-09-24_auditoria_seminario`.
Configuração prevista: `gpt-6-astra` / `xhigh`.

1. Antes da crítica, ler a fonte inteira e os registros independentes em section_reads/. Produzir síntese macro em argument_contract/argument_contract.md e .json, com perfil formal, mapa de cobertura, localizadores e reconciliação. Usar o schema em /Users/manoelgaldino/.codex/skills/argument-fidelity-gate/references/contract-schema.md. Só marcar PASS após conferir cobertura e resolver ambiguidades pela fonte. Validar com o script da skill.
2. Fazer primeira auditoria fria sem pareceres históricos. Não alterar o manuscrito nem suas primitivas. Reconstituir todos os resultados e registrar provas, hipóteses, fronteiras e desvios. Distinguir teoremas de conjecturas e extensões declaradas em aberto.
3. Gravar a primeira leitura antes de consultar os pareceres antigos. Depois confrontar a evidência existente; uma crítica já resolvida não reaparece como se fosse atual.
4. Entregar reviews/audit.md integral, reviews/findings.json (array: id,type,severity,claim,source_locations,evidence,proposed_fix) e reviews/claim_coverage.csv. Scripts independentes e outputs em checks/primary/. Cada finding deve ter localizador 1-based, derivação ou contraexemplo e impacto. Não deduzir validade geral de uma grade numérica.
5. Notar limitações concretas, inclusive resultados não verificados. A tarefa é auditoria, sem implementar correções, iniciar seminário ou alterar o objeto escolhido pelo autor.

Não escrever fora desta pasta de entregas. Não criar subagentes sem combinar com root: os slots são compartilhados. Não ler relatórios de outro auditor atual antes de sua própria primeira passagem.
