# Informational Power Through Pivotality

<!-- Instruções atualizadas conforme as correções autorais de 2026-09-05; a exigência de arquitetura do item 4 está por demonstrar. -->

## Objetivo e arquivos de trabalho

Artigo de teoria formal sobre quando a unanimidade favorece um hegemon informado em organizações internacionais. O mecanismo é o poder informacional associado à necessidade do seu consentimento: sob maioria, os fracos podem formar um acordo sem H; sob unanimidade, precisam obter sua adesão.

- Manuscrito: `formal_model_v6.Rmd`. PDF: `formal_model_v6.pdf`.
- Derivações: o arquivo autorizado para a tarefa em `model_redesign/` ou `quality_reports/`. Computação: scripts separados em `scripts/`.
- `formal_model_v5.Rmd`, `RIO submission files/` e artefatos congelados são protegidos. Preserve-os e use erratas ou novos candidatos conforme o protocolo autorizado.
- Trabalhe no checkout autorizado; confira branch, alterações existentes e os hashes pertinentes antes de atribuir uma revisão ao candidato atual.

## Fundamentos aprovados em setembro

Estes fundamentos prevalecem sobre instruções históricas incompatíveis. H designa o hegemon; os demais jogadores são os Estados fracos. A decisão de 1º de setembro deve ser lida com a emenda posterior do mesmo dia e os esclarecimentos autorais em `quality_reports/agents_maintenance_2026-09-05/approval.md`. Para o item 4, prevalece a correção mais recente em `quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md`: a ausência de acúmulo deve ser sustentada pela arquitetura e pelos incentivos; sua demonstração permanece em aberto.

1. De Baron–Ferejohn/Kalandrakis, o baseline herda o protocolo: reconhecimento uniforme dos fracos, propostas de divisão, votação e rodadas com desconto; Kalandrakis 2006 fornece a referência de simetria. A estrutura de desacordo é especificada para este domínio.
2. A comparação institucional é unanimidade versus maioria, mantendo a mesma economia e o mesmo protocolo de votação.
3. H é o único ator com informação privada. Os fracos são simétricos, não possuem informação privada nem canal próprio de sinalização.
4. Quando uma proposta é aprovada, cada Estado fraco recebe apenas a alocação que ela lhe atribui, independentemente de seu voto; não a substitui por sua opção externa. H recebe `x_H` quando vota sim e a proposta é aprovada. Se a proposta é rejeitada e o jogo termina, H recebe sua opção externa, independentemente de seu voto; havendo outra rodada, o jogo continua segundo o protocolo. A ausência de recebimento simultâneo de alocação positiva e opção externa por H deve decorrer da arquitetura econômica e dos incentivos, inclusive fora do caminho de equilíbrio. O caso de aprovação com voto não de H exige derivação própria: não o resolva estipulando que `x_H` desaparece, deixa de ser pago ou retorna automaticamente ao proponente. A regra histórica de cancelamento não satisfaz essa exigência. Se a arquitetura não produzir o resultado, registre a incompatibilidade e formule a revisão substantiva necessária.
5. Propostas têm alocações não negativas cuja soma é no máximo 1. Não há teto adicional para a alocação de H; `bar_x_H` e `y_bar` foram eliminados.
6. O excedente disponível é fixado em 1. A opção externa de H está fora desse excedente, independe de acordos entre os demais e representa o valor privado de seu melhor fórum alternativo. Os fracos têm opção externa zero. No baseline, `pi_H=0` e `b_theta=0`.
7. O objeto são acordos distributivos de clube dentro da organização. O pacote da coalizão distribui benefícios entre seus membros e não impõe obrigações aos que ficaram fora. Para os fracos, votar não não os exclui da distribuição prevista na proposta aprovada, conforme o item 4. Decisões que vinculam toda a organização estão fora deste escopo.
8. O jogo é distributivo puro: não contém externalidades, bens públicos ou benefícios do acordo para quem não participa dele.

Qualquer proposta que viole um fundamento deve ser reportada como violação. Sua reversão exige identificar o fundamento afetado e obter decisão individual do autor, fora de um lote de correções.

## Índice de fontes vigentes

| Tema | Fonte e regra de leitura |
| --- | --- |
| Fundamentos, exclusão e espaço de propostas | `quality_reports/2026-09-01_decisao_exclusao_payoffs_e_fundamentos.md`, incluindo a emenda posterior do mesmo dia, com os esclarecimentos em `quality_reports/agents_maintenance_2026-09-05/approval.md` e a correção mais recente em `quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md`. O cancelamento primitivo de `x_H` no ramo contestado não é instrução vigente. Demais cláusulas de setembro prevalecem sobre agosto. Afirmações históricas de invariância precisam da revisão correspondente. |
| Crenças e votação no baseline | `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`, com Emenda 1a, e `quality_reports/2026-09-01_decisao_structural_consistency_baseline.md`. A codificação de setembro determina sua aplicação operacional. |
| Demais primitivas, dependências e gates do baseline | `quality_reports/plans/2026-08-12_essential_input_gate0.md`, somente nas cláusulas compatíveis com as decisões acima. O cabeçalho datado não substitui autorizações posteriores. |
| Extensão de agenda | `model_redesign/agenda_extension_STATUS.md` e `model_redesign/agenda_extension_status_current.json` apontam para os contratos e manifestos de cada nó. Verifique decisões posteriores e preserve a distinção entre o baseline e o jogo da extensão. |
| Revisão do manuscrito e escopo já executado | Manifestos da tarefa e hashes do checkout. Pontos de entrada: `quality_reports/2026-09-02_exposition_items20_28_manifest.md` e `quality_reports/2026-09-02_item13_proof_transport_manifest.md`. Uma revisão cobre apenas seu escopo e seus arquivos exatos. |

Uma nova decisão explícita do autor prevalece no assunto que modifica. Consulte apenas as fontes pertinentes à tarefa. Se houver conflito substantivo sem decisão que o resolva, apresente-o ao autor antes da etapa dependente. Registros antigos e `CLAUDE.md` não reabrem fases nem substituem os fundamentos vigentes.

## Protocolo formal a preservar

- As rodadas são sequenciais; os votos dentro de cada votação são simultâneos. O proponente conta como sim, e os votos individuais se tornam públicos ao encerrar a votação. Votar não não cria uma saída imediata e irreversível de H.
- Resolva R2, a rodada terminal, sem desconto interno; use `beta*C_2` quando a continuação de R2 entrar em R1. Siga as dependências e o domínio do contrato com suas emendas.
- No baseline, propostas e votos dos fracos não atualizam a crença sobre o tipo de H. Dentro de uma votação, vetores com o mesmo voto de H compartilham a crença posterior. Aplique Bayes quando seu denominador for positivo; caso contrário, use a liberdade local à votação e ao voto de H, dentro do suporte do prior. Votações distintas podem ter valores livres distintos.
- Preserve a regra de voto dos fracos por comparação de valor esperado condicional à pivotalidade e o desempate `T^Y`: votar sim na indiferença em valor esperado. Use as definições completas das decisões de agosto e setembro; não substitua esse conceito por equilíbrio sequencial ou por uma convenção da extensão de agenda.
- Derive a partir das primitivas. Não acrescente hipóteses, suprima trajetórias ou imponha crenças para recuperar um resultado desejado. Novos resultados devem ser derivados e revisados fora do manuscrito antes da migração autorizada.

## Exclusão de H: obrigação de derivação

- Derive as propostas ótimas em cada conjunto de informação do proponente, inclusive fora do caminho, sob as crenças e continuações admissíveis pelo conceito aprovado. Não imponha `x_H=0` como restrição adicional ao espaço de propostas.
- Verifique se uma proposta ótima com `x_H>0` pode ser aprovada quando H vota não. A expressão “o proponente sabe que H rejeitará” se refere à sua informação e às crenças sobre os tipos de H. Examinar apenas rejeição certa é insuficiente: cubra também rejeição por alguns tipos e distinga tipos com probabilidade posterior positiva dos demais tipos factíveis. Preserve a possibilidade de uma oferta de seleção de tipos ser rejeitada por um tipo quando isso faz a proposta fracassar.
- Uma prova por redução de `x_H` e aumento de `x_i` compara duas propostas formuladas antes da votação. Demonstre que a alternativa é factível e melhora o payoff do proponente, verificando votos, probabilidades de aprovação, continuações e empates relevantes. Não transforme essa comparação em devolução automática após a votação.
- Otimalidade em todos os conjuntos de informação não elimina histórias geradas por desvios nas propostas ou nos votos. A arquitetura deve especificar payoffs e respostas também nessas histórias e verificar se podem produzir acúmulo. Distinga voto, participação, alocação e exercício da opção externa; chamar H de “não participante” não substitui a explicação do mecanismo. Se a racionalidade não bastar, apresente a revisão da arquitetura sem apagar o ramo ou restaurar silenciosamente `x_H + o_theta`.
- O diagnóstico e um resultado delimitado para propostas ótimas nas duas rodadas estão em `quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md`. Esse resultado preserva o protocolo e os pagamentos dos fracos e pressupõe suas respostas de voto prescritas; não fecha os payoffs e incentivos de H após desvios. As provas atuais de B.1/B.3 usam a regra histórica e não certificam o requisito completo. A revisão de instruções não modifica o manuscrito ou contratos congelados nem estende pareceres históricos à arquitetura por definir.

## Autonomia, verificação e aprovação

- Resolva escolhas operacionais e reparos determinados pelas fontes dentro da tarefa solicitada. Reutilize a autorização já dada para a mesma ação e escopo.
- Consulte o autor quando a escolha ainda não resolvida alterar primitivas, informação, payoffs, conceito de solução, afirmações formais ou interpretação substantiva. Continue o trabalho independente dessa decisão. Ao pausar por uma instrução, cite o arquivo e o trecho responsável.
- O implementador pode compilar, executar verificações autorizadas, examinar resultados e corrigir erros durante o trabalho. Essas verificações não constituem aprovação independente.
- Mantenha implementador e revisores distintos. Preserve as exigências aplicáveis de dois pareceres independentes completos nos mesmos hashes, revisão formal e adversarial e adjudicação dos findings. Revisores não editam o candidato avaliado.
- Registre o alcance de provas e testes numéricos. Arquivos modificados são um novo candidato; revisões anteriores permanecem limitadas aos arquivos que avaliaram. Uma certificação mecânica não cobre, por si só, todas as estratégias, desvios ou condições de existência.
- Um PASS não autoriza outra fase. Migração, tag, merge, push e submissão seguem a autorização correspondente; se ela já existe para a ação e o escopo, não a solicite novamente. Antes de um reset substantivo, siga `paper-version` e preserve a fronteira de versão.

## Comandos e apresentação

- Compile respeitando o formato bookdown do YAML: `rmarkdown::render("formal_model_v6.Rmd")`. Não force `pdf_document`, salvo depuração solicitada.
- Quando solicitado `coarse-review`, use `python3 scripts/run_coarse_review.py formal_model_v6.pdf`. O wrapper trata a chave OpenRouter para evitar credenciais antigas herdadas pelo processo.
- Prefira R para figuras e relatórios reprodutíveis e use `dplyr::select()` em seleção de colunas. Preserve cálculos fora do Rmd.
- Escreva o artigo em inglês; notas podem ser em português. Preserve conceitos e notação; mantenha nomes internos de nós, estados de revisão e Lean fora da exposição do artigo. Lean é infraestrutura interna.
- Na conversa, explique siglas e use equações legíveis. Numere figuras e tabelas do artigo e forneça captions informativas.

## Histórico

O arquivo anterior e a organização de seus registros estão em `quality_reports/agents_maintenance_2026-09-05/`. Consulte-os para proveniência. Prompts antigos, planos cumpridos e comandos de arquiteturas abandonadas não são instruções para iniciar novas tarefas.
