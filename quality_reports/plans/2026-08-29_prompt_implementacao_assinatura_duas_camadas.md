# Prompt de implementação — assinatura de A_M em duas camadas

**Data:** 2026-08-29
**Executor:** sessão Codex no worktree `/private/tmp/PBP-am-msb`, branch
`agenda-extension-am-msb` (a mesma sessão do passe de reparo serve; se estiver
degradada, sessão nova no mesmo worktree com este prompt executa sem perda —
ele é autossuficiente). Implementação é papel de implementador; quem
implementa não revisa. Os dois pareceres formais novos virão depois, de
sessões frescas, nunca do implementador e nunca do Fable.
**Snapshot pré-implementação:** o HEAD corrente do branch no momento de
iniciar, a registrar no relatório do passe. Linhagem: `6b94f2f` é o candidato
substantivo revisado pelos pareceres formais; `0eef332` acrescentou o pacote
de consulta; commits posteriores importam apenas documentos governantes. O
worktree está limpo; a implementação entra como commits novos no mesmo branch.
**Documentos governantes (hashes a verificar antes de usar):**

| Documento | Caminho | SHA-256 |
|---|---|---|
| Decisão em duas camadas (APPROVED) | `quality_reports/plans/2026-08-29_decisao_assinatura_duas_camadas_A_M.md` | `cd9650715442dc0beae2fa6af450c509c0ad871d51dc5d54b0a6a826d1fc86e8` |
| Consulta externa não formal — Fable | `quality_reports/external_reviews/2026-08-29_consulta_fable_anonimato_reynolds_A_M.md` | `608b9459d26063c6e45f895ba70bd00c2f73bf12cdff3dac854a9b62746e10d7` |
| Consulta externa não formal — ChatGPT Web | `quality_reports/external_reviews/2026-08-29_consulta_tecnica_externa_nao_formal_chatgpt_simetria_AM.md` | `142a39ed2124aca50743e92ef67f505192eb6d159f546b3d8b0c42a274804d0b` |
| Emenda M/S/B (APPROVED) | `quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md` | `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b` |
| Clarificação (APPROVED) | `quality_reports/plans/2026-08-29_clarificacao_assinatura_anonimato.md` | `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3` |

Pareceres formais 1 e 2, adjudicação e manifesto do gate já estão na árvore
(commits `6b94f2f` e `a3f7f7f`), com hashes na Seção de referências do pacote
de consulta.

## Prompt — colar integralmente na sessão Codex

```text
Estamos no worktree /private/tmp/PBP-am-msb, branch agenda-extension-am-msb,
com a árvore limpa. Registre no relatório o HEAD corrente como snapshot
pré-implementação; a linhagem relevante é: 6b94f2f = candidato substantivo
revisado pelos pareceres formais; 0eef332 = pacote de consulta; commits
posteriores importam apenas documentos governantes, sem conteúdo substantivo.
Você é o implementador da decisão autoral APROVADA
"assinatura de A_M em duas camadas". Você não revisará o próprio trabalho: ao
final, o pacote vai a dois pareceres formais independentes novos, de sessões
frescas, sobre exatamente os bytes que você produzir.

Precedência: (1) a decisão aprovada
quality_reports/plans/2026-08-29_decisao_assinatura_duas_camadas_A_M.md
(verifique o SHA-256
cd9650715442dc0beae2fa6af450c509c0ad871d51dc5d54b0a6a826d1fc86e8); (2) as
duas consultas externas não formais nela citadas, como bases textuais e fonte
das provas; (3) a adjudicação e os dois pareceres formais já na árvore; (4) a
emenda M/S/B, a clarificação e as decisões anteriores aprovadas; (5) o
contrato base. AGENTS.md/CLAUDE.md do snapshot são anteriores a esses
documentos; os documentos prevalecem. Hipóteses de conversa não constantes
deles estão descartadas.

Contexto em uma frase: os dois pareceres formais adjudicaram um defeito
importante — o Reynolds componentwise não é quociente diagonal exato (P/Q) e
não é realizável como assessment — e a decisão aprovada o resolve com duas
camadas: assinatura exata pela órbita diagonal codificada por Lambda_x, e
resumo econômico anônimo pelo pushforward para Z/G. Sua tarefa é implementar
exatamente isso em model_redesign/agenda_extension_A_M_msb_results.md e no
claim ledger, sem rederivar o que sobreviveu (existência para algum rho,
classificação pura, endpoints, T4/AMX-015, Gamma_theta pré-quociente,
fechamento por permutação comum, teorema cardinal, AMX-011).

TAREFAS, nesta ordem:

1. Registro pré-implementação: anote o HEAD corrente e os arquivos a alterar.

2. Camada exata. Defina a ação diagonal de G = S_m sobre X = P(Z)^2 e a
   assinatura exata Sig_ex_M(R) = (rho, nu_off, Lambda_{x(R)}), com
   Lambda_x = |G|^{-1} * soma_g delta_{g.x}. Enuncie e prove a proposição de
   completude: Lambda é Borel, G-invariante, e Lambda_x = Lambda_{x'} sse
   x' pertence à órbita G.x (prova nas duas consultas: mensurabilidade via
   mapas de avaliação; invariância por translação à direita; completude via
   Lambda_{x'}({x'}) = |Stab(x')|/|G| > 0). Verifique explicitamente, contra a
   formalização vigente do pacote, que Z = Y x [0,1] x {0,1} x X_M x Omega_T é
   Borel-padrão — em particular X_M e Omega_T; se algum não for, ajuste o
   enquadramento e, se a mudança for substantiva, escale. Defina o
   representante expositivo como membro real da órbita por seleção mensurável
   fixada (mínimo lexicográfico sob isomorfismo de Borel declarado), com a
   órbita registrada; declare que a média de Reynolds nunca é usada como
   representante.

3. Camada de resumo. Defina q_Z : Z -> Z/G (órbita do registro realizado
   inteiro; estrutura Borel-padrão do quociente para grupo finito) e
   Sum_econ_M(R) = (rho, nu_off, (q_Z)#Gamma_0, (q_Z)#Gamma_1). Prove o lema
   de fatorização: toda f Borel G-invariante fatora por q_Z, e
   integral f dGamma_theta = integral f_bar d(q_Z)#Gamma_theta; derive daí as
   estatísticas exibidas (payoffs por tipo, probabilidades de acordo/atraso,
   lei do posterior por tipo, outcome terminal anônimo, payoffs fracos como
   lei exchangeable). Prove as propriedades: q_Z compose T_g = q_Z; por
   linearidade, baricentros de identidade têm o mesmo resumo; o posterior, o
   indicador de acordo e a continuação anônima sobrevivem no quociente.

4. Reynolds rebaixado. Onde o texto atual usar o Reynolds componentwise como
   quociente exato ou representante, substitua pela arquitetura acima e
   declare explicitamente as quatro limitações: não é invariante completo da
   órbita diagonal (contraexemplo P/Q, adjudicado); não retém a relação entre
   os planos dos tipos; pode não pertencer à imagem de assessment algum
   (incoerência de posteriores no mesmo sinal); sua igualdade significa apenas
   igualdade de um resumo marginal. Mantenha o contraexemplo P/Q como
   certificado permanente da não completude.

5. Frase das misturas, reescrita com escopo pela revelação. Texto normativo:
   identidade formal somente por permutação comum aplicada ao perfil inteiro;
   mesmo resumo se e somente se as leis anônimas de registros realizados por
   tipo coincidem. Consequências explícitas: (i) misturas sobre identidades
   que não alteram Bayes (suportes disjuntos entre tipos) têm o mesmo resumo e
   órbitas distintas; (ii) misturas realizadas que alteram a revelação — os
   dois tipos misturando sobre o mesmo suporte — são outro experimento, com
   outra lei de posterior, e diferem nas duas camadas; (iii) x^P e x^Q
   diferem na camada exata e coincidem, deliberadamente, no resumo.

6. Regra de consumo downstream. Fibered product no mesmo (rho, nu_off) antes
   de qualquer resumo. AC/AR consomem Sum_econ somente mediante claim provado
   por operação: constância nas fibras do resumo e fatorização mensurável
   C = C_bar compose Sum_econ; para correspondências, prova setwise, sem
   emparelhar coordenadas de elementos distintos; verificações escalares
   pontuais não bastam. Liste as operações que usam obrigatoriamente a camada
   exata (identidade formal, suportes, coincidência de mensagens, mapa
   público pi, Bayes/crenças, correlação entre planos, contagem de classes,
   seleção de representante, composições que recombinem) e as que podem usar
   o resumo após fatorização (payoffs, probabilidades, lei de posterior,
   continuação e outcomes anônimos, estatísticas G-invariantes).

7. Claims. Reenuncie: AMX-016a = assinatura exata + proposição de completude
   de Lambda (base: consulta ChatGPT §8.2-8.3, fundida com a cláusula do
   representante real da consulta Fable §8a); AMX-016b = Sum_econ por Z/G +
   lema de fatorização + claims de suficiência por operação declarada;
   AMX-MSB-010 (parte afetada) = base na consulta ChatGPT §8.4. O teorema
   cardinal permanece inalterado (muda o objeto que codifica a órbita, não o
   contínuo de classes). Aplique ao finding menor da Seção 8.3 a redação
   corrigida das consultas, com a precisão átomo-versus-ponto-de-massa-zero e
   as provas atômica e setwise.

8. Verificação mecânica. Estenda o script com regressões implementáveis:
   assinaturas exatas distintas e resumos iguais para x^P/x^Q numa instância
   finita; invariância Lambda_{g.x} = Lambda_x; identidade
   (q_Z)#(T_g)#Gamma = (q_Z)#Gamma; igualdade de resumo para pesos (.9,.1) e
   (.5,.5) com suportes disjuntos; preservação da lei de posterior no
   quociente. Inclua script e outputs no pacote. Verificação mecânica não
   substitui prova.

9. Relatório e fechamento. Relatório do passe com o mapeamento
   item-da-decisão -> implementação -> arquivo/trecho, salvo em
   quality_reports/ com data. Ledger atualizado. Preflight novo e manifesto
   SHA-256 dos artefatos. Commits neste branch com mensagens descritivas; SEM
   tag; SEM merge; SEM tocar em artefatos congelados (baseline N1-N7, tag
   v6-essential-input-2026-08-25, snapshots anteriores da árvore). AC e AR
   continuam sem consumir A_M; a auditoria de A_U segue pendente e fora deste
   passe. Ao final, informe o commit final, o hash do manifesto e o caminho do
   relatório, e declare o pacote pronto para os dois pareceres formais novos.

Disciplina: findings escalam por default; toda ambiguidade e definição
faltando escalam; se a implementação exigir decisão não coberta pelos
documentos governantes, marque pending protocol decision, explique as
consequências e pare o ramo. Salve scripts em arquivo antes de rodar.
```
