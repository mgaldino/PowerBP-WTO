# Relatório da adjudicação

A correção de instruções pode seguir; a questão da arquitetura permanece aberta.

O AGENTS atual, o manuscrito e o memorando B.1/B.3 estipulam que, após aprovação sem o voto de H, ele recebe apenas a opção externa e sua fatia não é paga. As provas de dominância também usam a comparação entre propostas para eliminar x_H positivo quando os votos fracos já bastam. Essa comparação não retira da árvore histórias que seguem a uma proposta desviadora. A exigência autoral atual não pode ser certificada apenas pela antiga estipulação.

O registro global é BLOCKED por R1-F004. Isso preserva a pergunta sobre a arquitetura completa, as respostas fora do caminho e a cobertura de tipos com probabilidade posterior zero. Não significa que foi provada a inexistência de uma arquitetura adequada.

O registro delimitado ao AGENTS é READY_FOR_IMPLEMENTATION para R1-F001 e R2-F005: marcar a regra antiga como contestada, exigir a demonstração pelas primitivas e incentivos e manter a pendência visível. A intervenção não escolhe novos payoffs, restringe propostas, modifica votos ou autoriza uma migração de provas.

Os demais pontos confirmados delimitam a obrigação de prova: rejeição certa não cobre rejeição de alguns tipos; propostas ótimas fora do caminho não esgotam histórias após desvios arbitrários; e probabilidade local zero não é garantia tipo a tipo. O argumento terminal x_H=0 foi verificado apenas sob os payoffs dos fracos, a quota, a viabilidade e o desempate. Os registros não promovem essa observação a solução do jogo dinâmico.

Arquivos: adjudication_round1_global.json e .md; adjudication_round1_agents_only.json e .md; identity_checks.json; mechanical_checks.json. A construção é reproduzível por build_adjudication.py. O relatório validation.txt registra a execução do validador da skill.

Nenhum arquivo do repositório, candidato do implementador ou artefato congelado foi editado por esta adjudicação.

## Etapa posterior: candidato final

Os dois pareceres finais foram adjudicados no candidato AGENTS 122a3a53047f e na nota 873715a6848e. O resultado é NO_CONFIRMED_DEFECTS para instruções e nota. A demonstração limitada para propostas ótimas foi estendida e conferida também em R1, sob os componentes e respostas fracas prescritas declarados. R3-F001 está resolvido no README. O registro global original permanece preservado e a pendência R1-F004 continua aberta para payoffs e respostas após desvios nas propostas e nos votos. Esta evolução não é uma certificação da arquitetura completa.

Registro: candidate_final.json e candidate_final.md. Validação: candidate_final_validation.json e candidate_final_validation.txt.
