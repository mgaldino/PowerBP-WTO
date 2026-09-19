# Escopo da composição proposta para o manuscrito

Data: 2026-09-19. Estado: patches preparados; migração canônica não aplicada por este agente.

O patch de agenda expõe a derivação congelada no novo protocolo de coalizão. A composição esperada é `migrate_agenda(migrate_baseline(original))`, seguida da conferência integral pelo coordenador. O preview `agenda_manuscript_preview.Rmd` contém apenas a parte da agenda aplicada à fonte original, portanto ainda depende das definições do modelo que serão fornecidas pelo patch do baseline.

| Responsável | Escopo da composição |
| --- | --- |
| Patch do baseline, coordenador | Modelo e protocolo gerais; `X` como simplex de alocações, `X_C` com zero fora da coalizão, `Y_g^i` e `y=(C,x)`; quotas `nu_M=k+1` e `nu_U=m+1`; transições e payoffs; provas B.1/B.3 e ajustes pertinentes de A; notação geral. Figura, limites e instruções permanecem sob responsabilidade do coordenador. |
| Patch da agenda | Contrato introdutório da seção 6; nota da tabela de reversão; B.7; domínio e ação sobre coalizões em B.9; entradas de notação da agenda; E.1/E.2; identificação explícita de `(N,x)` com `x` nas aberturas de B.8/E.3. |

Na agenda, `Y_g=Y_g^H`, os sinais públicos são os pares `(C,x)`, as leis de maioria e seus suportes pertencem a `Y_M`, e as bolas locais ficam na componente da coalizão. Os votos efetivos distinguem recusa de ausência do convite por meio de `bot`. A seleção retém a continuação completa; os kernels realizados usam o representante uniforme com coalizão mínima de fracos em R2. Os desvios continuam a incluir todas as coalizões admissíveis. O patch preserva os resultados econômicos nos limites da derivação e não afirma equivalência global entre estratégias ou leis dos dois jogos de maioria.

As projeções históricas de órbitas `q_g`, `q_M` e `q_U` permanecem intactas. A nova quota é escrita exclusivamente `\nu_g`, com `\nu_M=k+1` e `\nu_U=m+1`. A nota da reversão e sua testemunha usam `mu_off=0` sob ambas as instituições. As demais seções e a bibliografia não são modificadas pelo patch de agenda.

Verificações executadas: sintaxe do script, geração determinística do preview, preservação das ocorrências das projeções de órbitas e composição dos dois patches em ambas as ordens, exclusivamente em memória. As duas ordens produziram texto idêntico. Este teste cobre os hashes abaixo; alterações posteriores dos patches exigem nova conferência. Não houve compilação, edição do manuscrito ou alteração da derivação congelada. O teste de composição é mecânico e não substitui os pareceres matemáticos independentes.

| Artefato ou resultado | SHA-256 conferido |
| --- | --- |
| Fonte original `formal_model_v6.Rmd` | `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411` |
| Derivação congelada `agenda_transport.md` | `3b98454cb275f34a89c6f5a10037eaa34e30e4fbf81e4fb4f01a65e2f8ba9f6f` |
| `agenda_manuscript_patch.py` | `f8a6cb7d469f3723eef4480c0450b4e9b4179b40f0fdcfeb8dcdd75720437de5` |
| Snapshot lido de `baseline_manuscript_patch.py` | `4b85a9df692ed0fec54973a149de35a38f00c316aed13ed2754d639ab932103a` |
| Preview somente de agenda | `671f139d96ca333e9ecfb45e188205f76d2497c6f5ce6ab552ac49c5d56f84f8` |
| Diff somente de agenda | `bf479791c783027dedaff5a77574723d71c7e68b43810d848dbd6f8b8546d79c` |
| Texto composto nas duas ordens, sem gravação | `98aedf04f6f345964045a1517af1fc6a35dca0a7f1383cb19d425cce46742f4a` |
