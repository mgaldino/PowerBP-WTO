# Prompt — Goal 0 da extensão de agenda (contrato executável)

**Executor designado:** sessão Opus (Claude Code) neste repositório.
**Autorização:** GO explícito do autor em 2026-08-23 para abrir o Goal 0 do
plano v3, após preflight executado. O GO cobre somente o Goal 0.
**Material de coordenação** redigido pelo Fable a pedido do autor; não é
artefato matemático e não entra em cadeia de revisão.

---

Prompt a colar na sessão Opus, íntegro:

```text
Estamos no repo PowerBayesianPersuasion, branch codex/essential-input. O autor
deu GO explícito em 2026-08-23 para o Goal 0 da extensão de agenda informal:
redigir o contrato executável do Gate 0. O preflight já foi executado. Esta
sessão REDIGE o contrato; ela não deriva equilíbrios, não escreve scripts R,
não revisa o próprio contrato, não edita o manuscrito e não cria commit, tag,
branch ou push.

PAPEL E LIMITES. Você é o redator do contrato. Separação de papéis: quem
implementa não revisa. Duas revisões independentes read-only virão em sessões
separadas sobre o hash final (uma de desenho formal, outra de teoria dos
jogos; Fable é inelegível como revisor desta cadeia). Scripts R são Goal 1;
derivações são Goals 2-5; manuscrito é Goal 6. Nada disso nesta sessão.

VERIFICAÇÃO INICIAL — pare e reporte se qualquer uma falhar:
1. git status e git diff: nenhum artefato congelado modificado. Arquivos de
   coordenação não rastreados são aceitáveis; liste-os no relatório final.
2. shasum -a 256 quality_reports/plans/2026-08-23_agenda_extension_gated_plan_v3.md
   deve retornar
   1706cda1b6902cbca4f368e5ad61f567cb0eb40f8f4850169cd595bbcf0ab17e.

LEITURAS OBRIGATÓRIAS, integrais, nesta ordem:
1. quality_reports/plans/2026-08-23_agenda_extension_gated_plan_v3.md — o
   plano v3, FECHADO pelo autor. É o objeto que o contrato transcreve. Em
   conflito com qualquer documento anterior, o v3 e a decisão de 2026-08-21
   prevalecem.
2. quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md — o
   pacote de crenças e votação que o §2.2 do v3 transporta (as-if-pivotal,
   T^Y, no-signaling, consistência estrutural, liberdade após desvio genuíno
   de H, preservação de suporte nos endpoints).
3. quality_reports/plans/2026-08-12_essential_input_gate0.md — precedente de
   formato de contrato Gate 0 neste repositório. Referência de FORMA; o
   conteúdo da extensão vem exclusivamente do v3.
4. CLAUDE.md e AGENTS.md do repositório.
5. Localize por ls, somente leitura, os artefatos congelados dos nós N3, N4 e
   N7 em model_redesign/essential_input_* — o contrato os cita por caminho; o
   hash-pinning das visões consumíveis é tarefa do Goal 1, não desta sessão.

ENTREGA PRINCIPAL: quality_reports/plans/2026-08-23_agenda_extension_gate0.md
(caminho fixado pelo §10 do v3), em português, autocontido — executável por
quem nunca viu conversa nenhuma —, contendo:

1. Forma extensiva e informação: estágio A como data zero; as DUAS
   representações do §2.1 (cronologia A_M -> C_M, A_U -> C_U e dependências
   de solução A_M depends_on C_M etc.); obrigação de H propor, sem ação nula;
   transição completa de toda (proposta, vetor de votos) para acordo ou
   continuação; história pública e posterior que entram em C_M/C_U; regra
   contábil do §3 do v3: payoff condicionado ao tipo realizado primeiro,
   expectativa calculada por último, beta aplicado exatamente uma vez no
   transporte de C para A.
2. Primitivas do §2.5 do v3, item a item, NA ORDEM do plano, cada uma com
   resolução explícita e status APPROVED (quando o v3, a decisão de
   2026-08-21 ou os artefatos congelados pinam a resposta, citando onde) ou
   pending protocol decision (quando não pinam; nesse caso apresente as
   opções e as consequências substantivas de cada uma, SEM decidir). Nenhum
   item pode ficar para ser preenchido dentro de uma prova.
3. Pacote de solução transportado: os 7 itens do §2.2, mantendo a distinção
   nominal exigida pelo v3 — liberdade baseline após desvio genuíno de H NÃO
   é crença passiva, não é D1, não é Critério Intuitivo, não é tremble.
4. Protocolo de trembling simétrico: transcrição integral dos 12 itens do
   §2.3, sem enfraquecimento — mesma taxa epsilon e mesma lambda (Lebesgue
   k-dimensional normalizada no espaço factível Y, compacto e Boreliano) para
   os dois tipos; Bayes por razão de massas nos átomos e por razão de
   densidades fora deles, com versão Boreliana pontualmente especificada;
   posterior passivo onde f_0 = f_1 = 0; preservação de suporte nos
   endpoints; parada e escalada em componente singular contínuo; limite único
   epsilon -> 0 exigindo convergência fraca das medidas de estratégia E
   convergência pontual do posterior em todo y de Y; inexistência de
   subsequência convergente ou passagem por continuação none = resultado de
   não robustez, nunca licença para outro posterior; correspondência baseline
   publicada ao lado do subconjunto sobrevivente. O protocolo não será
   chamado de equilíbrio sequencial nem trembling-hand perfection sem prova
   de equivalência.
5. Gatilho e ordem dos testes de robustez: os 7 passos do §2.4, com D1 e
   Critério Intuitivo como diagnósticos com ledger próprio, jamais baseline.
6. Estimandos: por tipo, ex ante, públicos, rendas informacionais e
   interação, formulados como PERGUNTAS com domínio e status inicial pending.
   Nenhum valor numérico, fórmula candidata ou desigualdade esperada.
7. Schema por equilíbrio: todos os campos do §4 do v3, com a semântica de
   cada campo e a regra de atomicidade (payoffs, crenças, estratégias e
   outcomes do mesmo equilíbrio no mesmo registro; envelopes marginais não
   fabricam equilíbrio).
8. DAG: seção no contrato e arquivo
   model_redesign/agenda_extension_game_dag.json com nós A_M, A_U, AC, AR e
   arestas depends_on, em namespace próprio; o DAG essential-input permanece
   fechado e intocado.
9. Ledgers vazios:
   model_redesign/agenda_extension_A_M_claim_ledger.tsv,
   model_redesign/agenda_extension_A_U_claim_ledger.tsv,
   model_redesign/agenda_extension_AC_claim_ledger.tsv,
   model_redesign/agenda_extension_AR_claim_ledger.tsv — apenas cabeçalho;
   status permitidos: proved, checked numerically, conjecture, pending,
   rejected.
10. Especificação do verifier: o que os scripts do Goal 1 deverão checar — no
    mínimo os invariantes do §6 do v3. NÃO escrever os scripts.
11. Invalidação e revisão: as regras do §8 do v3, incluindo cascatas (mudança
    de C_M invalida A_M, AC, AR...; mudança de A_M ou A_U invalida AC, AR e
    migração) e o que reabre o próprio Gate 0 (mudança de contrato, conceito
    de solução, schema, tremble ou protocolo de revisão).

REGRAS INVIOLÁVEIS:
1. Nada de resultados no contrato. A memória do projeto e notas em notes/
   contêm contas de guardanapo e condições candidatas desta extensão. NÃO
   transcreva nenhuma fórmula, condição, payoff esperado ou ranking candidato
   para o contrato — nem como hipótese a confirmar. As únicas intuições
   admissíveis são as qualitativas do §1 do v3, citadas por referência ao
   plano.
2. Congelados byte a byte, nenhuma edição: nós N1-N4, N6, N7 e o contrato
   essential-input; formal_model_v6.Rmd e .pdf do snapshot revisado (commit
   b5fdefb); quality_reports/2026-08-23_parecer_fable_agenda_extension_plan_v2.md
   (hash f4d8a185...); o próprio plano v3.
3. Fidelidade ao v3: onde o v3 decidiu (§0, §2.2, §2.3, §2.4), transcreva sem
   reabrir nem melhorar. Se julgar uma divergência necessária, ela vira
   finding escalado no relatório final, nunca alteração silenciosa.
4. Findings escalam por default; o ônus é de quem quiser classificar como
   técnico, e o teste é existir exatamente um reparo forçado pelo que já está
   escrito.
5. Idioma: português. Sem referência a versões, conversas ou sessões dentro
   do corpo normativo do contrato.

ENCERRAMENTO DA SESSÃO:
1. Apresente ao autor, NA SESSÃO e em linguagem simples, a lista completa de
   itens pending protocol decision, cada um com opções e consequências.
   Aguarde as decisões do autor e incorpore-as ao contrato com status
   APPROVED e a data.
2. Só então calcule e reporte shasum -a 256 do contrato e de cada arquivo
   criado (DAG e ledgers).
3. Feche com um resumo simples: o que o contrato fixa, o que segue pendente
   (se o autor deixou algo pendente, o ramo afetado fica bloqueado), e
   quaisquer findings escalados.
4. PARE. Não abra o Goal 1, não escreva scripts, não commite. As duas
   revisões independentes acontecem em sessões separadas sobre o hash final,
   e o GO para o Goal 1 é decisão posterior do autor.
```
