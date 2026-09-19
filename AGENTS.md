# Informational Power Through Pivotality

<!-- Protocolo atualizado pela decisão autoral de 2026-09-19: coalizão explícita, alocações restritas aos membros, consentimento de todos os convidados e implementação automática. -->

## Objetivo e arquivos de trabalho

Artigo de teoria formal sobre quando a unanimidade favorece um hegemon informado em organizações internacionais. O mecanismo é o poder informacional associado à necessidade do seu consentimento: sob maioria, os fracos podem formar um acordo sem H; sob unanimidade, precisam obter sua adesão.

- Manuscrito: `formal_model_v6.Rmd`. PDF: `formal_model_v6.pdf`.
- Derivações: o arquivo autorizado para a tarefa em `model_redesign/` ou `quality_reports/`. Computação: scripts separados em `scripts/`.
- `formal_model_v5.Rmd`, `RIO submission files/` e artefatos congelados são protegidos. Preserve-os e use erratas ou novos candidatos conforme o protocolo autorizado.
- Trabalhe no checkout autorizado; confira branch, alterações existentes e os hashes pertinentes antes de atribuir uma revisão ao candidato atual.

## Fundamentos aprovados em setembro

Estes fundamentos prevalecem sobre instruções históricas incompatíveis. H designa o hegemon; os demais jogadores são os Estados fracos. A decisão mais recente está em `quality_reports/coalition_protocol_2026-09-19/author_decision.md`: o autor adotou a variante de coalizão explícita com alocações apenas aos membros e consentimento de todos os convidados. Ela substitui o protocolo anterior nos pontos indicados abaixo. As decisões de 1º e 5 de setembro continuam vigentes nas cláusulas compatíveis. O estado de derivação e revisão do candidato novo deve ser consultado nos registros de `quality_reports/coalition_protocol_2026-09-19/`; pareceres históricos não o certificam.

1. O baseline mantém reconhecimento uniforme dos fracos, propostas de divisão e duas rodadas com desconto. O proponente escolhe uma coalizão C que o contém e satisfaz a quota institucional, junto da alocação x. Todos os convidados precisam consentir simultaneamente. Kalandrakis 2006 fornece a referência de simetria; a estrutura de desacordo é própria deste domínio.
2. A comparação institucional é unanimidade versus maioria, com a mesma economia e o mesmo protocolo de consentimento. Varia a quota mínima para C: maioria permite excluir H; unanimidade força C=N.
3. H é o único ator com informação privada. Os fracos são simétricos, não possuem informação privada nem canal próprio de sinalização.
4. Uma proposta aprovada é implementada automaticamente e cada membro recebe a parcela proposta. Não há ação individual posterior de execução por H. Se H está fora de C e o acordo passa, recebe sua opção externa. Se qualquer convidado recusa, o pacote inteiro fracassa, inclusive em coalizões maiores que a quota; segue R2 ou, na rodada terminal, o desacordo. H recebe sua opção externa no desacordo terminal independentemente de seu voto. A regra vale também após desvios; nenhuma parcela é cancelada ou devolvida depois da aprovação.
5. As alocações são não negativas, somam no máximo 1 e satisfazem `x_j=0` para todo j fora de C. Essa restrição é simétrica e foi expressamente adotada pelo autor em 19/9. Não há teto adicional para H; `bar_x_H` e `y_bar` permanecem eliminados. Coalizões superdimensionadas e convidados com parcela zero continuam factíveis.
6. O excedente disponível é fixado em 1. A opção externa de H está fora desse excedente, independe de acordos entre os demais e representa o valor privado de seu melhor fórum alternativo. Os fracos têm opção externa zero. No baseline, `pi_H=0` e `b_theta=0`.
7. O objeto são acordos distributivos de clube dentro da organização. O pacote distribui benefícios entre seus membros e não impõe obrigações aos que ficaram fora. Um membro convidado que recusa veta aquele pacote, sem criar um acordo residual dos demais convidados. Decisões que vinculam toda a organização estão fora deste escopo.
8. O jogo é distributivo puro: não contém externalidades, bens públicos ou benefícios do acordo para quem não participa dele.

Qualquer proposta que viole um fundamento deve ser reportada como violação. Sua reversão exige identificar o fundamento afetado e obter decisão individual do autor, fora de um lote de correções.

## Índice de fontes vigentes

| Tema | Fonte e regra de leitura |
| --- | --- |
| Fundamentos, exclusão e espaço de propostas | `quality_reports/coalition_protocol_2026-09-19/author_decision.md` modifica explicitamente os fundamentos 1, 2, 4 e 5 e compatibiliza o 7. Os registros de 1º e 5 de setembro documentam a pendência anterior. Nem cancelamento de `x_H` nem a candidata de execução individual A1–A3 são adotados. |
| Crenças e votação no baseline | `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`, com Emenda 1a, e `quality_reports/2026-09-01_decisao_structural_consistency_baseline.md`. A codificação de setembro determina sua aplicação operacional. |
| Demais primitivas, dependências e gates do baseline | `quality_reports/plans/2026-08-12_essential_input_gate0.md`, somente nas cláusulas compatíveis com as decisões acima. O cabeçalho datado não substitui autorizações posteriores. |
| Extensão de agenda | `quality_reports/coalition_protocol_2026-09-19/derivations/v2/agenda_transport.md` e `derivations/v2/unanimity_support_lemma.md`, no mesmo diretório da tarefa, são as notas atuais sobre sinais `(C,x)`. O bundle v2 e o manifesto de entrega vinculam suas revisões. Os registros `model_redesign/agenda_extension_STATUS.md` e `agenda_extension_status_current.json` preservam os contratos anteriores e não certificam o protocolo novo. |
| Revisão do manuscrito e escopo já executado | `quality_reports/coalition_protocol_2026-09-19/delivery_report.md` e `delivery_manifest.json`, no mesmo diretório, registram a integração, os dois pareceres independentes, as adjudicações e os hashes de 19/9. Os manifestos de 2/9 permanecem históricos. Uma revisão cobre apenas seu escopo e seus arquivos exatos; consulte `status.json` para o fechamento da entrega. |

Uma nova decisão explícita do autor prevalece no assunto que modifica. Consulte apenas as fontes pertinentes à tarefa. Se houver conflito substantivo sem decisão que o resolva, apresente-o ao autor antes da etapa dependente. Registros antigos e `CLAUDE.md` não reabrem fases nem substituem os fundamentos vigentes.

## Protocolo formal a preservar

- As rodadas são sequenciais; apenas convidados votam e seus votos são simultâneos. O proponente conta como sim. C e x são públicos antes da votação; votos individuais tornam-se públicos ao encerrar a votação. H fora de C não emite voto, e sua ausência não é um voto não. Um não não cria saída imediata e irreversível de H.
- Resolva R2, a rodada terminal, sem desconto interno; use `beta*C_2` quando a continuação de R2 entrar em R1. Siga as dependências e o domínio do contrato com suas emendas.
- No baseline, propostas dos fracos, inclusive a escolha de C, e seus votos não atualizam a crença sobre o tipo de H. Se H está fora de C, toda a votação preserva a crença. Quando convidado, vetores da mesma votação com o mesmo voto de H compartilham a crença posterior. Aplique Bayes quando seu denominador for positivo; caso contrário, use a liberdade local à votação e ao voto de H, dentro do suporte do prior. Votações distintas podem ter valores livres distintos. Na agenda, H propõe e C também pode transmitir informação.
- Preserve a regra de voto dos fracos por comparação de valor esperado condicional à pivotalidade e o desempate `T^Y`: votar sim na indiferença em valor esperado. Use as definições completas das decisões de agosto e setembro; não substitua esse conceito por equilíbrio sequencial ou por uma convenção da extensão de agenda.
- Derive a partir das primitivas. Não acrescente hipóteses, suprima trajetórias ou imponha crenças para recuperar um resultado desejado. Novos resultados devem ser derivados e revisados fora do manuscrito antes da migração autorizada.

## Exclusão de H e desvios no protocolo adotado

- Derive propostas ótimas e respostas após todos os pares factíveis `(C,x)`, incluindo coalizões superdimensionadas, convites a parcela zero, screening e tipos de probabilidade posterior zero. A restrição de suporte fora de C é uma primitiva aprovada; não a apresente como consequência exclusiva de racionalidade.
- Demonstre a ausência de acúmulo para todos os perfis: H convidado que recusa provoca fracasso integral; H excluído tem `x_H=0`; H incluído em acordo aprovado recebe `x_H`. Aplique as mesmas transições a propostas e votos desviantes, sem cancelamento ou devolução posterior.
- Comparações por remoção de um convidado e redistribuição de sua parcela são comparações de propostas anteriores ao voto. Verifique quota, factibilidade, votos, probabilidade de aprovação, crenças, continuações e empates; uma recusa não autoriza executar outra subcoalizão.
- Sob maioria, igualdade de fórmulas econômicas não demonstra equivalência de estratégias, coalizões, crenças ou leis realizadas. Na agenda, os sinais `(C,x)` exigem derivação própria; mantenha C nas leis de propostas e histórias, inclusive em propostas rejeitadas. Sob unanimidade, qualquer transporte deve explicitar o mapa C=N.
- Os registros de 5 e 8 de setembro são proveniência das arquiteturas anteriores. Preserve contratos e pareceres congelados. A nova cadeia tem seu próprio contrato, interfaces, grafo, verificações e revisões em `quality_reports/coalition_protocol_2026-09-19/`.

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
