# Prompt do passe de reparo de A_M pós-parecer externo

**Data:** 2026-08-29
**Executor:** a MESMA sessão Codex que derivou o pacote, no MESMO worktree
`/private/tmp/PBP-am-msb`, branch `agenda-extension-am-msb`. O passe de reparo
é trabalho de implementador; a exigência de frescor recai sobre os dois
revisores formais, que virão depois, em sessões novas. Se a sessão antiga
estiver degradada ou perto do limite de contexto, uma sessão nova no MESMO
worktree com este mesmo prompt executa sem perda — o prompt é autossuficiente.
**Snapshot pré-reparo:** `6fa852c` (pacote derivado em `38a3939` + packet da
consulta). O worktree está limpo; os reparos entram como commits novos no
mesmo branch. Não criar worktree novo: o candidato reparado é definido por
commits, preflight e manifesto de hashes, não por diretório.
**Documentos governantes (importados na árvore, com SHA-256 a verificar antes
de usar):**

| Documento | Caminho | SHA-256 |
|---|---|---|
| Emenda M/S/B (APPROVED) | `quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md` | `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b` |
| Clarificação anonimato + kernel uniforme (APPROVED, §§1–2 e §4) | `quality_reports/plans/2026-08-29_clarificacao_assinatura_anonimato.md` | `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3` |
| Decisões pós-parecer (APPROVED, 4 decisões) | `quality_reports/plans/2026-08-29_decisoes_pos_parecer_chatgpt_A_M.md` | `3000a25c89510f3e0ea471d4406c0c59282f41fd07662b5c077fa81f281e1471` |
| Parecer externo (consulta não formal; fonte do checklist) | `quality_reports/external_reviews/2026-08-29_consulta_tecnica_chatgpt_web_A_M_msb.md` | `d4928d7cf90ae01b37848d43b6d38d32498332822b1f73d955eebb7f1dabc47c` |

## Prompt — colar integralmente na sessão Codex

```text
Estamos no worktree /private/tmp/PBP-am-msb, branch agenda-extension-am-msb,
do repo PowerBayesianPersuasion. Você é o implementador do passe de reparo do
pacote A_M sob M/S/B, que você mesmo derivou (commits 38a3939 e 6fa852c). O
worktree está limpo; os reparos entram como commits novos neste branch. Você
não revisará o próprio trabalho: depois deste passe, o pacote vai a dois
revisores formais independentes em sessões novas.

Precedência de documentos, do mais alto ao mais baixo: (1) a emenda M/S/B
APROVADA; (2) a clarificação APROVADA (anonimato §§1-2 e estatuto do kernel
uniforme §4); (3) as decisões pós-parecer APROVADAS (4 decisões); (4) o
parecer externo, como fonte do checklist de reparos; (5) o contrato base
quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md. Os
caminhos e SHA-256 dos itens (1)-(4) estão na tabela do arquivo
quality_reports/plans/2026-08-29_prompt_reparo_A_M_pos_parecer.md; verifique
os quatro hashes antes de usar. AGENTS.md e CLAUDE.md deste snapshot são
anteriores a esses documentos e não os conhecem; os documentos prevalecem.
Hipóteses discutidas em conversa e NÃO constantes desses documentos estão
descartadas — em particular, simetria global/exchangeability da estratégia de
proposta de H está descartada pela clarificação §1: estratégias de estágio
assimétricas seguem admissíveis, e o tratamento da multiplicidade por
identidade de coalizão é o quociente de assinatura do §2.

Contexto do veredito: o parecer externo deu FAIL aos bytes exatos com núcleo
recuperável — 0 critical, 5 important, 6 minor. Existência por regiões,
classificação pura, endpoints, representante uniforme, preço comum e limites
de payoff passaram condicionalmente. Sua tarefa é aplicar os reparos e as
decisões aprovadas, sem rederivar o que passou.

TAREFAS, nesta ordem:

1. Registro pré-reparo. Anote no relatório do passe o commit pré-reparo
   (6fa852c) e os arquivos do pacote que serão alterados.

2. Decisão 1 — reparametrização rho. Introduza rho em [0,infty] como
   COORDENADA do assessment, com nu_off = b_rho(nu) = nu*rho/(1-nu+nu*rho),
   equivalentemente odds(nu_off) = rho*odds(nu), convenções usuais em
   rho = 0, infty e priors degenerados (nos endpoints do prior, nu_off = nu,
   como já exige a emenda). Inclua a interpretação por perturbações de lapses
   sigma_theta^n = (1-eps_theta_n)*sigma_theta + eps_theta_n*tau, com tau de
   suporte pleno comum aos tipos e eps_1n/eps_0n -> rho, e a ressalva
   OBRIGATÓRIA de que essa racionalização opera no nível dos sinais e não
   prova consistência sequencial do assessment completo. NÃO fixe rho ex
   ante. Entregáveis associados: benchmark rho = 1 reportado; análise de
   sensibilidade das classes em rho, incluindo os limites 0 e infty; destaque
   das classes válidas para todo rho quando existirem, sem alegar existência
   geral dessa subclasse.

3. Decisão 2 — assinatura por lei conjunta. Substitua a assinatura pela
   versão preferível do parecer (§10.4): a interface inclui rho (ou nu_off) e,
   para cada tipo, a lei conjunta
   Gamma_theta = L_theta(y, pi(y), a(y), chi(pi(y)), omega_T),
   em espaço terminal disjunto para acordo e atraso, com V, W, p_A, Q, G_pi
   derivados como marginais. Use a fórmula explícita do parecer para a
   distribuição terminal:
   Q_theta(B) = integral_Y [ a(y)*delta_{(A,y)}(B)
   + (1-a(y))*K_{theta,chi(pi(y))}(B) ] sigma_theta(dy).
   Documente que a comparação AC será por produto fibrado no MESMO rho/nu_off,
   nunca por produto cartesiano de marginais. O quociente de anonimato da
   clarificação (§2 e §4) aplica-se a Gamma_theta: a mesma permutação dos
   fracos no perfil inteiro; rho e nu_off são invariantes.

4. Clarificação — re-corte por anonimato e kernel uniforme. (a) Se o pacote
   tratou como classes distintas equilíbrios que diferem só pela identidade
   da coalizão paga ou por misturas sobre identidades, funda-os numa classe
   por órbita, reportada pelo representante simétrico com a órbita registrada;
   classes que diferem em revelação (posterior nos sinais alcançados)
   permanecem distintas, inclusive separação por identidade de coalizão no
   knife-edge z_0 = z_1. (b) Aplique o §4 da clarificação ao texto: a
   continuação efetivamente selecionada é o representante literal uniforme
   (ou a mistura comum E/P no empate residual); construções cíclicas servem
   somente para calcular payoffs interinos e não são kernels terminais
   admissíveis nem membros da assinatura. (c) Registre no ledger a
   verificação de que o conjunto de equilíbrios é fechado sob permutações dos
   fracos sob M/S/B.

5. Reparo 10.1 — Bayes local bem definido. Adote como texto normativo da
   cláusula B (ajustando notação ao pacote): seja d a métrica euclidiana
   relativa de Y, B_Y(y,r) = {y' in Y : d(y,y') < r},
   lambda = (1-nu)*sigma_0 + nu*sigma_1 e S = supp(lambda). Para todo y em S,
   pi(y) = lim_{r->0} nu*sigma_1(B_Y(y,r)) / lambda(B_Y(y,r)); se o limite
   falhar em algum y em S, o assessment é B-inadmissível. Para todo y fora de
   S, pi(y) = nu_off, o mesmo escalar em todo o complemento. Declare
   explicitamente: trata-se de restrição pointwise de crenças independentes
   da mensagem fora do suporte, disciplina adicional ao PBE usual — não é
   consequência de PBE, sequential equilibrium, trembles, Critério Intuitivo
   ou D1. Acrescente a linha invocando o teorema de diferenciação de
   Besicovitch para identificar pi = d(nu*sigma_1)/d(lambda), lambda-q.c.

6. Reparo 10.2 — Teorema 4 bem formado. Reescreva o cabeçalho: fixe
   0 < nu < 1, nu_off em [0,1] (equivalentemente rho) e chi: [0,1] -> X_M
   Borel; exija sigma_0, sigma_1 em P(Y) (probabilidades); inclua nu_off/rho
   no objeto reduzido R = (nu_off, sigma_0, sigma_1, lambda, pi, chi, a, u_0,
   u_1); exija ou prove que pi, a, u_0, u_1 são Borel. Reveja o iff com essas
   correções; o núcleo já foi validado condicionalmente pelo parecer (§6.6).

7. Reparo 10.5 — Teorema 6. Retitule e reescreva o enunciado para a versão
   cardinal: mesmo com (nu, nu_off) fixado, a correspondência exata de
   assinaturas pode ser incontável e nenhuma lista finita a representa. NÃO
   alegue inexistência de parametrização finita ou de todo resumo finito.

8. Reparo 10.6 — autocontenção dos claims históricos. Para AMX-NEG-001:
   anexe kappa_old, a crença antiga e g_theta completo, OU declare-o lema
   histórico importado, não revalidável pelo pacote autocontido — escolha a
   segunda opção se a anexação não for imediata. Para AMX-009: defina o
   "antigo intervalo" com objeto exato ou rebaixe o claim para refletir o que
   é comparável.

9. Achados menores (§9.6-9.7 do parecer): antecipe, antes do Teorema 2, o
   lema do supremo off-path para suporte puro finito (complemento denso;
   sup = max{A_off, D_theta_off}, com aproximação por epsilon e contínuo de
   propostas rejeitadas); mencione explicitamente o empate residual E/P e a
   preservação das desigualdades por convexidade na prova de existência;
   enuncie e prove 0 < r_chi(mu) <= beta/m e k*r < 1 como lema de
   factibilidade; explicite os valores off-path do Finding 1 (D_0(0), D_1(0),
   O_0, O_1); construa por escrito as misturas de fronteira de AMX-007; e
   restrinja "testemunhas adjacentes" a priors interiores, com endpoints
   tratados diretamente pelo teorema de endpoints.

10. AMX-013 — reprodutibilidade. Inclua no pacote o script de verificação
    mecânica e seus outputs (ou caminhos e hashes deles no worktree), para que
    a evidência 2891 PASS seja reprodutível por terceiros. Verificação
    mecânica não substitui prova.

11. Decisão 3 — IC/D1. NÃO execute forward induction neste passe. Registre no
    ledger o entregável futuro IC/D1-BENCHMARK, não bloqueante, na forma do
    §8.4 do parecer: para cada proposta inesperada, a correspondência de
    tipos que podem ganhar sob alguma resposta sequencialmente racional dos
    votantes e algum membro permitido de C_M, com IC/D1 aplicados a essa
    correspondência; anote a pendência de decidir se a resposta dos
    receptores inclui chi.

12. Ledger e relatório. Atualize o claim ledger: AMX-015 e AMX-016 reenunciados
    conforme os reparos; AMX-MSB-009 na versão cardinal; AMX-009 e AMX-NEG-001
    com o estatuto do item 8; o certificado negativo permanece resultado e
    motivação. Produza um relatório do passe com o mapeamento achado-do-parecer
    -> reparo-aplicado -> arquivo/trecho, claim a claim, salvo em
    quality_reports/ com data no nome.

13. Fechamento. Preflight novo e manifesto SHA-256 dos artefatos do pacote
    reparado; commits neste branch com mensagens descritivas; SEM tag; SEM
    merge; SEM tocar em artefatos congelados (baseline N1-N7, tag
    v6-essential-input-2026-08-25, snapshots b675a37 e anteriores). AC e AR
    continuam sem consumir A_M; a auditoria de A_U pela mesma liberdade
    continua pendente e não é tarefa deste passe.

Disciplina: findings escalam por default; toda ambiguidade e definição
faltando escalam; se um reparo exigir decisão não coberta pelos documentos
governantes, marque pending protocol decision, explique as consequências e
pare o ramo. Salve scripts em arquivo antes de rodar. Ao final, informe o
commit final, o hash do manifesto e o caminho do relatório do passe.
```
