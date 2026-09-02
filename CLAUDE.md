# Informational Power Through Pivotality

## Projeto

Paper teórico sobre **quando consenso pode beneficiar um hegemon** em
organizações internacionais. O mecanismo-alvo é que unanimidade força W a
incluir H sob incerteza, criando screening que gera renda informacional. Sob
maioria, W pode excluir H; se a condição No-Cheap-H seleciona essa coalizão,
surge o benchmark sem screening. Exclusão e no-screening continuam pendentes de
rederivação no clean baseline. Screening é o mecanismo central; Bayesian
Persuasion aparece apenas como Remark.

### Resultado central
Unanimidade pode beneficiar H não apesar das restrições, mas por causa delas. Unanimidade ativa poder informacional (screening sob pivotalidade) sem precisar dar poder formal de agenda a H. O consenso pode funcionar como tecnologia institucional de poder, não apenas como concessão.

## Status

- **Lifecycle da extensão de agenda (2026-08-29):** `A_M` sob M/S/B e a
  arquitetura aprovada de assinatura em duas camadas está `pass/frozen`
  somente nos hashes de
  `quality_reports/2026-08-29_A_M_msb_two_layer_final_gate_manifest.sha256`
  (SHA-256 do manifesto
  `8eb870d5595a4373994e8f47a25a3dd137b00ac8c32fc09b947444498a32775e`).
  Ler primeiro `model_redesign/agenda_extension_STATUS.md` e
  `model_redesign/agenda_extension_status_current.json`. Os antigos
  `agenda_extension_game_dag*.json` são proveniência imutável anterior a M/S/B;
  seus campos `A_M=pending` não são a autoridade atual de lifecycle. `A_U`,
  `AC` e `AR` permanecem `pending/unfrozen` e sem autorização. Este fechamento
  não autoriza migração ao manuscrito, tag, merge ou push.
- **Cadeia essential-input (2026-08-21):** N1--N4, N6 e o nó terminal N7 estão
  `pass/frozen`, cada um no hash final com dois pareceres independentes PASS
  0/0/0; N5 não integra o DAG. O autor aprovou explicitamente N7 congelado e
  encerrou o Goal 4. O Goal 5 foi autorizado, migrado e revisado de forma
  independente.
- **Snapshot revisado do Goal 5 (2026-08-22):** os dois pareceres independentes
  PASS 0/0/0 cobrem somente o commit
  `b5fdefb1f80090b8da893bf19e754915d557502a` e os bytes exatos revisados de
  `formal_model_v6.Rmd` (SHA-256
  `32b49f7503caac34cdf225f73d7e76ab60d1340937b095e3e611f009030f8744`) e
  `formal_model_v6.pdf` (SHA-256
  `85d24122008af9ad484a6df53679c3f455f75fb94fffc70aa9ccbd8ffb62fe17`).
  Qualquer edição posterior, inclusive uma edição manual no RStudio, cria um
  candidato novo ainda não revisado. Ela não altera nem invalida o snapshot
  histórico revisado, que continua recuperável em `b5fdefb`, mas os novos bytes
  não podem ser descritos como cobertos por aqueles pareceres até nova
  compilação e nova revisão independente.
- **Fechamento do Goal 5 (2026-08-25):** o autor concedeu o aval terminal e a
  versão foi fixada pela tag anotada `v6-essential-input-2026-08-25`. Os bytes
  tagueados são `00bbaa3a5768348fede3f6584bab915b7c1dbf1fd1cccbf723bb64a90188e4a6`
  para `formal_model_v6.Rmd` e
  `3602b0753a8a61ddcb2450f7181ba2f8fc53b9f73ad16cdfbb46e337019182be`
  para `formal_model_v6.pdf`. Os pareceres `PASS 0/0/0` continuam limitados a
  `b5fdefb`; a abertura posterior é redação autoral aprovada pelo autor com
  proofread independente read-only em
  `quality_reports/2026-08-25_proofread_introducao_v6.md`, não uma extensão
  retroativa daqueles pareceres.

> ## FUNDAMENTOS INVIOLÁVEIS DO MODELO (2026-09-01, APPROVED)
>
> Registro: `quality_reports/2026-09-01_decisao_exclusao_payoffs_e_fundamentos.md`.
> **Regras de operação**: (1) toda proposta de protocolo, convenção ou
> contabilidade é checada contra esta lista ANTES de ser escalada — o que
> viola um fundamento não é opção escalável, é violação reportável; (2)
> reversão de um fundamento só pode ser proposta nomeando-se explicitamente
> como tal ("isto reverte o fundamento #k"), fora de lote, com assinatura
> autoral individual. Origem: a decisão D1 de 2026-08-12 (x_H+o) reverteu uma
> proibição explícita sem se anunciar como reversão e só foi detectada ao
> final — o básico não escrito perde para o racional escrito.
>
> 1. **Frame herdado de BF/Kalandrakis = PROTOCOLO**: reconhecimento uniforme
>    entre weak states, propostas sobre a pie, ballots, rodadas com desconto;
>    e o benchmark de simetria de Kalandrakis 2006. A estrutura de desacordo
>    NÃO é herdada (em BF é toda zero e não adjudica nada) — é especificação
>    própria do domínio, declarada.
> 2. **Comparação institucional exclusivamente unanimidade vs. maioria**,
>    mesma economia, mesmo protocolo de ballot.
> 3. **Exatamente um ator informado, H**; weak states simétricos, sem
>    informação privada e sem canal próprio de sinalização.
> 4. **Payoffs de acordo e desacordo mutuamente exclusivos em todo
>    histórico**: parte do acordo aprovado recebe sua alocação; quem está fora
>    (H excluído por maioria, ou desacordo terminal) recebe sua outside option
>    e nada da pie; alocação a não-parte não é paga a ninguém — a concessão é
>    específica ao ator e intransferível. NUNCA somar alocação e outside
>    option (erro x_H+o do D1, supersedido em 2026-09-01).
> 5. **Nenhuma restrição ao espaço de propostas** além de não-negatividade e
>    x_H+Σx_j ≤ 1. Sem tetos (o parâmetro `\bar x_H`/`y_bar` foi deletado).
> 6. **Pie fixa em 1** (surplus de clube dos membros); **outside option de H
>    externa à pie** e invariante ao acordo dos demais (simplificação
>    declarada); o_θ microfundada por **forum shopping** — valor privado do
>    melhor fórum alternativo de H (bilaterais, OMPI, coalition of the
>    willing); fracos têm o=0 por ausência de alternativas; π_H=0 no baseline;
>    b_θ=0.
> 7. **Escopo**: acordos distributivos de clube dentro da OI — o pacote da
>    coalizão vencedora aloca benefícios entre seus membros e não vincula nem
>    recruta não-coalizão. Decisões que vinculam todos os membros
>    (assessments, quotas) estão fora do escopo.
> 8. **Jogo distributivo puro**: sem externalidades, sem bens públicos, sem
>    free-riding. Argumento que dependa de um ator se beneficiar de acordo do
>    qual não é parte viola este fundamento.

> ## ARQUITETURA CORRENTE — essential-input (2026-08-12)
>
> **O contrato normativo é
> `quality_reports/plans/2026-08-12_essential_input_gate0.md`, status APPROVED.**
> Ele prevalece sobre qualquer afirmação no resto deste arquivo. Ler antes de agir.
> A seção "Leitura para aprovação" explica as decisões sem jargão.
>
> **O que mudou, e o que aqui está superado:**
>
> 1. **Ninguém tem ação de saída.** Ballots simétricos: todos votam sim ou não.
>    O `não` de `H` é só um não, e `H` continua no jogo. Toda afirmação abaixo
>    sobre opt-out imediato e irreversível de `H`, ou "nenhum acordo inclui `H`
>    depois disso", está **superada**. Aquela primitiva dava a `H` um privilégio
>    que os fracos não tinham e eliminava a opção de atraso, que é a fonte da
>    renda informacional dinâmica.
> 2. **`o_theta` é payoff de desacordo**, recebido ao fim do jogo se nada
>    passar, com a mesma data e o mesmo desconto de todo mundo. O limiar
>    `y_theta^* = o_theta` está **superado**: vale em R2, que é terminal; em R1
>    a reserva é o valor de continuação.
> 3. **Conceito de solução: PBE mais stage-undominated voting**, com `T^Y` na
>    igualdade exata. A pendência de 2026-08-05 sobre `T^Y` versus PBE-UD está
>    **RESOLVIDA e era dicotomia falsa**: na igualdade exata as duas ações de
>    voto são idênticas em todo contingente, então a undominância não elimina
>    nada e não há o que substituir. Domínios disjuntos — undominância decide os
>    casos estritos, `T^Y` decide o empate. Abandonar a undominância foi o ramo
>    errado. Stage-undominated voting é refinamento declarado de PBE
>    implementado como restrição de estratégias, não de crenças; não confundir
>    com o weak-vote-passive assessment, que não é refinamento.
> 4. **A pie é fixa em 1**, independente do tipo e da inclusão de `H`. Pie
>    `V(theta)` e pie dependente da inclusão são alternativas eliminadas,
>    extensões para outro paper. Não repropor.
> 5. **Ordem de derivação**: `N1` R2-maioria, `N2` R2-unanimidade, `N3`
>    R1-maioria, `N4` R1-unanimidade, `N5` entry, `N6` comparação. A dificuldade
>    está concentrada em `N4`. Trabalhar em `model_redesign/essential_input_*`.
>
> **A cadeia `pivotal-response` (12 nós, commit `19c431a`) é proveniência
> fechada.** Seus PASS valem apenas para a especificação que revisaram. Não
> migrar, não citar como evidência corrente, não editar. Idem para os artefatos
> PBE-UD do Goal 3 e o handoff do Goal 4.
>
> **Findings escalam por default.** O ônus é de quem quiser classificar como
> técnico, e o teste é se existe exatamente um reparo forçado pelo que já está
> escrito. Toda ambiguidade e toda definição faltando escalam, sem exceção.

> ## DECISÃO 2026-08-21 — Conceito de solução FIXADO (crenças off-path, votação, T^Y)
>
> **Registro normativo: `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`
> (status APPROVED, decisão do autor). Ler antes de qualquer derivação ou revisão de N4.**
> **Adendo 2026-09-01 (APPROVED)**: a codificação operacional de structural
> consistency — quais histórias compartilham a crença off-path (pares η_Y/η_N
> por ballot, quociente sobre coordenadas fracas), gatilho por denominador
> bayesiano zero, valores livres locais ao ballot — está em
> `quality_reports/2026-09-01_decisao_structural_consistency_baseline.md`.
> Codificação apenas: nenhum payoff, fronteira ou correspondência muda. As
> edições de manuscrito autorizadas (Solution concept, A.2, E.1) foram
> aplicadas em 2026-09-01 e criam candidato novo pendente de revisão
> independente, com item de checagem direcional e cláusula de reconciliação
> com a interface efetiva de N2 registrados no adendo.
> Origem: auditoria game-teórica em `quality_reports/2026-08-21_game-theory-audit_essential_input.md`
> (2 passes independentes), que demonstrou que as provas provisórias de N4 usavam
> convenções mutuamente incompatíveis. Conversa completa em
> `quality_reports/2026-08-21_conversa_decisao_conceito_solucao.md`.
>
> O pacote decidido, que prevalece sobre formulações anteriores do conceito de solução:
>
> 1. **Crenças off-path: no-signaling-what-you-don't-know + consistência estrutural.**
>    Desvios de Estados fracos (propostas ou votos) NÃO movem a crença sobre `theta`.
>    Só ações de `H` movem crenças, por Bayes dado o perfil, mesmo em subárvores
>    off-path; desvios do próprio `H` deixam a crença livre. Descartadas: crenças
>    livres literais; dominância path-dependent (incoerente — não repropor).
>    **EMENDA (endpoints, Decisão 1a)**: com denominador bayesiano zero, a crença é
>    livre DENTRO do suporte do prior — tipo com prior zero nunca recebe posterior
>    positivo. Em ν=0, posterior ≡ 0 em toda a árvore (ν=1: ≡ 1); endpoints
>    coincidem com informação completa (benchmark N7). Descartadas: pinagem no
>    tipo prescrito (ação não identifica tipo inexistente); livre em [0,1] no
>    endpoint (ressuscitaria tipo impossível off-path). Antes de PASS de N4,
>    verificar que nenhum registro off-path de endpoint usa posterior positivo
>    no tipo de prior zero. **Errata N2 registrada (opção errata, texto canônico
>    do Codex aceito)**: a interface efetiva de N2 é o artefato congelado
>    (`c6a65dc8...a85a2`, intacto byte a byte) lido conjuntamente com a Emenda
>    1a — endpoints sem multiplicidade de crenças; interior inalterado. Incide
>    em `belief_system.off_path_ballot` e `existence_uniqueness_status` das duas
>    células, na derivação, no claim `N2-CLM-012` e na parcela sobre a classe de
>    crenças do claim `N2-CLM-013`; nenhum payoff muda. NÃO editar artefatos
>    de N2 — texto integral no registro de decisão.
> 2. **Votação dos fracos: as-if-pivotal.** Comparação por valor esperado condicional
>    ao evento pivotal; se estrita, decide o voto. Admissibilidade pura (só proibir
>    voto fracamente dominado) foi descartada: com vetor público ex post ela deixa
>    vetos sustentados por linhas contrafactuais de desvios de `H` que nunca ocorrem.
> 3. **T^Y: indiferença em valor esperado** (integrando `theta` e a loteria de
>    reconhecimento) na comparação pivotal ⇒ vota sim. A leitura
>    contingência-a-contingência foi descartada (destrói existência de proposta
>    ótima). Isto REFINA o item 3 do banner de 2026-08-12: "idênticas em todo
>    contingente" vale nos nós terminais, não em geral; igualdade é em valor esperado.
>
> **Consequências assumidas**: S₃=(1−ν)B deixa de ser exata (segurança sobe, rederivar);
> pisos de pagamento em acordo viram o valor de continuação C, não B uniforme;
> necessidade do lema multi-veto passa a valer com fronteiras de veto ABERTAS
> (desigualdades estritas; em indiferença exata T^Y força sim); §10.3–§10.7 do
> relatório de provas de 2026-08-21 devem ser rederivados sob este pacote.
> N1/N2 intactos; N3 só reparos menores (belief-free sob maioria).

- **Fase**: N1--N4, N6 e N7 estão `pass/frozen`; os Goals 1 a 5 estão
  encerrados. O autor concedeu o aval terminal do Goal 5 em 2026-08-25 e a tag
  `v6-essential-input-2026-08-25` fixa os bytes finais. Os dois pareceres
  `PASS 0/0/0` do Goal 5 cobrem exclusivamente os bytes do commit `b5fdefb`;
  não cobrem os bytes tagueados posteriores.
- **Paper v6** (ALVO CORRETO): `formal_model_v6.Rmd` — alvo do próximo manuscript pass. `formal_model_v6.pdf` existe como PDF compilado atual.
- **Paper v5** (REFERÊNCIA HISTÓRICA): `formal_model_v5.Rmd` — baseline fixed-pie relative-package com `pi_H=0`, weak-state agenda e weak-vote-passive assessment. `formal_model_v5.pdf` recompilado em 2026-05-15. Não usar v5 como alvo do clean-baseline reset.
- **Atualização do baseline v5 (2026-05-15)**: v5 usa a arquitetura fixed-pie relative-package com `pi_H=0` no corpo. A avaliação de crenças deve ser chamada **weak-vote-passive assessment**, não refinement. A defesa é informacional: weak states não observam `theta`, então desvios unilaterais de voto dos fracos não sinalizam diretamente o tipo de `H`; votos separadores de `H` podem atualizar crenças; crenças on-path seguem Bayes. O resultado R1 deve ser formulado como selected PBE outcome payoff-equivalente a `P`, `L` ou `R` sob a avaliação mantida, não como unicidade nem caracterização de todos os PBEs.
- **Revisão AJPS/referee-driven (2026-05-15)**: `formal_model_v5.Rmd` foi reescrito para evitar linguagem de rule-choice endógeno, tratar No-Cheap-H como condição de escopo natural para hegemonia, substituir "calibration" por "working numerical illustration", corrigir `a_0(1)` e adicionar o lema de rejected-history reduction. Dois revisores independentes deram **A+** para a prova R1 rejeitada final e recomendaram parar de mexer nessa parte.
- **Protocolo de revisão**: quem implementa não revisa; quem revisa não implementa. Revisões formais, validação de scripts R, auditoria visual e integração final devem ser feitas por agentes independentes sem edição de arquivos.
- **Decisão de redesign**: a próxima versão do modelo principal deve separar três fontes de poder: outside option, veto/pivotality e proposal power. Agenda power entra por uma recognition probability `pi_H`. O baseline principal usa `pi_H = 0`, isto é, weak states / coalizões não-hegemônicas propõem e `H` é veto player informado. Isso isola informational power through pivotality de agenda power.
- **Reset arquitetural (2026-05-11, agora extensão para a próxima prova)**: abandonar o ramo de factibilidade state-contingent como mecanismo principal. Essa versão usava pacotes institucionais relativos, sempre factíveis, com `U_H(y, theta)=y+b_H(theta)`. Pela prioridade 2026-05-25, essa fórmula dinâmica não deve ser o próximo baseline; ela vira extensão/microfundamento.
- **Prioridade 1 para a próxima prova (2026-05-25)**: antes de mexer no
  manuscrito v6 — **SUPERADO em 2026-08-12**. Essa prioridade exigia opt-out
  imediato de `H` em R1, primitiva removida pelo contrato essential-input.
  `b_theta = 0` sobrevive; o opt-out não. `max{o_theta,beta C_theta}` deixou de
  ser extensão a supor e passou a ser consequência do desenho simétrico. A
  prioridade corrente é o Goal 0 de
  `quality_reports/plans/2026-08-12_essential_input_gate0.md`. Texto histórico a
  seguir, não executar;
  esse ramo deve ser definido no Gate 0 e derivado separadamente. Refaça
  primeiro em `model_redesign/power_architecture_derivations.Rmd`; só depois
  migre para `formal_model_v6.Rmd`.
- **Arquivo histórico**: a derivação feasibility/C-B-R foi preservada na tag `redesign-feasibility-branch-2026-05-11`. É história diagnóstica, não arquitetura atual.
- **Disciplina de protocolo**: não impor pooling, delay, rejeição, crenças off-path, ordem de votação, espaço contratual ou protocolo de continuação dentro de uma prova. Se uma prova precisar de novo protocolo, marcar `pending protocol decision`, explicar consequências substantivas e obter aprovação explícita antes de prosseguir.
- **Protocolo de votação adotado**: a barganha é sequencial e pública entre
  rodadas — proposta, ballot, publicação do vetor completo de votos e do
  resultado, seguida de eventual continuação. Dentro de cada ballot, porém, o
  proponente conta como voto favorável, todos os demais Estados votam
  simultaneamente e os votos individuais só são revelados após o fechamento.
  Portanto, “sequencial e pública” não significa roll-call sequencial. Uma
  extensão roll-call, na qual eleitores posteriores observam votos anteriores,
  exige ordem explícita e nova derivação de crenças e incentivos.
- **Status do paper**: `formal_model_v6.Rmd` é o alvo correto do próximo manuscrito. `formal_model_v5.Rmd` já recebeu o baseline fixed-pie `pi_H=0` e serve como referência histórica. Não reintroduzir branch labels antigos `A/C/R`, `C-B-R` ou linguagem random-proposer/H-proposer no corpo de v6.
- **Paper v4** (ARQUIVO): `formal_model_v4.Rmd` — versão com BP como co-protagonista. Preservada intacta.
- **Paper v2** (ARQUIVO): `formal_model_v2.Rmd` — versão densa com provas no corpo.

### Reviews de referência
- **Parecer simulado AJPS**: `quality_reports/parecer_AJPS_formal_model_v5.md` — Reject (resubmit). Base para pendências RIO.
- **Edmans Review v5 round 2**: `quality_reports/2026-04-27_edmans-review-v5-round2.md` (7.5/10, R&R minor — Contribution 7.0, Execution 8.0, Exposition 7.5).
- **Coarse review**: `coarse-output/coarse_0b50af74_coarse_review_cli_claude.md` — review externa.

## Especificação do Modelo

- **Status desta seção**: o baseline abaixo é o contrato-alvo do Goal 1 e ainda
  precisa ser rederivado. Fórmulas históricas não são resultados do baseline
  limpo.

### Baseline limpo a rederivar

- **N jogadores**: um hegemon `H` e `N-1` weak states, com `N` genérico.
- **Surplus institucional dos fracos**: fixo e normalizado em 1; o tipo privado
  não altera esse pie.
- **Pacote relativo**: `y` é uma concessão institucional a `H` e reduz o
  residual dos fracos um-para-um.
- **Payoff de H no acordo**: `y`, pois `b_theta=0` no baseline.
- **Desacordo de H** (SUPERSEDE o opt-out imediato, 2026-08-12): `o_theta` é o
  payoff de desacordo de `H`, recebido ao fim do jogo se nada passar, com a
  mesma data e desconto dos fracos, cujo payoff de desacordo é zero. `H` não
  tem ação de saída e permanece ativo depois de votar não. O limiar
  `y_theta^*=o_theta` vale em R2, que é terminal; em R1 a reserva é o valor de
  continuação. Screening continua exigindo `o_1>o_0`. Como os votos são
  simultâneos, derive a IC de `H` a partir dos payoffs que cada ação induz sobre
  todo o vetor de votos fracos; nunca permita que `H` condicione seu voto ao
  vetor ainda não revelado nem decida depois de observá-lo.
- **Agenda**: `pi_H=0` em todas as rodadas; apenas weak states propõem.
- **Votação**: ballots simultâneos com registro público ex post, usando o mesmo
  protocolo sob unanimidade e maioria.
- **Barganha**: duas rodadas no protocolo de referência; o tratamento exato de
  cada falha de R1 deve ser fechado no Gate 0 do Goal 1, sem presumir que toda
  falha ou todo candidato histórico sobreviva.
- **Conceito de solução**: PBE sob o escopo explicitamente declarado no
  resultado.

### Parametrizações históricas, aplicações e extensões

- A parametrização histórica `V(theta) in {1,r}` e
  `d_H(theta)=alpha V(theta)` pertence ao modelo anterior ou a uma possível
  aplicação/microfundação de `o_theta`; ela não define o clean baseline.
- A arquitetura antiga reconhecia cada Estado com probabilidade `1/N` e gerava
  um ramo `H`-proposer selection-dependent fora de accepted pooling.
- A arquitetura de 2026-05-11 usava
  `U_H(y,theta)=y+b_H(theta)` e a participação dinâmica
  `y+b_H(theta)>=beta C_H(theta,mu')`. Pela prioridade de 2026-05-25, ela é
  extensão/microfundamento, junto com
  `max{o_theta,beta C_theta}` e `t_theta=d_theta-b_theta`.
- Os casos `pi_H=1/N` e `pi_H>1/N` são extensões de agenda power.

### Comparação institucional: alvos pendentes de rederivação

- **Unanimidade**: W deve incluir H; sob condições a rederivar, isso pode gerar
  screening/pooling e renda informacional para `H`.
- **Maioria**: W pode excluir H da coalizão. A condição exata para ausência de
  screening e os payoffs devem ser rederivados sob `o_theta` primitivo; não
  importar automaticamente as fórmulas históricas em `alpha V(theta)`.

### Resultados-chave — status após correção das provas

**Verificados no appendix corrigido (2026-05-10):**
- Maioria não gera screening quando H's outside option é externa ao pie.
- Coeficientes corrigidos: `lambda_M^E = {N[1+(N-1)alpha] - beta(q-1)}/N^2`; `kappa_M^E = [N(N-1)+beta(q-1)]/[N^2(N-1)]`.
- R2 de unanimidade: `mu_s^R2 = alpha(r-1)/(r-alpha)`.
- R1 quando W propõe sob unanimidade: escolha restrita por factibilidade entre `A(mu)` agressivo, `C(mu)` conservador e `R(mu)` rejeição deliberada.
- Calibração OPEC (`N=13`, `r=1.5`, `alpha=.19`, `beta=.9`): regime W-proposer `A-C-A`, com cortes `0.031188` e `0.301717`; lower bound de unanimidade domina majority corrigida em todo `mu in [0,1]`.
- Teorema de condições suficientes: com `m=N-1`, `A0=1+m alpha`, `A1=1+m alpha r`, a dominância condicional por lower bound vale se:

```text
max{
  N A0 / [A0 + m A1 + q - 1],
  N m alpha / [q - 1 + N m alpha]
}
< beta <
N / [N + m alpha(r - 1)]
```

Na calibração OPEC: `max{0.6842105, 0.8316498} < 0.9 < 0.9193777`.
- Nesting calibrado: para os parâmetros OPEC, `V_W^R1(mu,M) > V_W^R1(mu,U)` para todo `mu in [0,1]` usando upper bound selection-free para os fracos sob unanimidade; logo `F_U subset F_M` para qualquer custo `c`.
- Classificação institucional calibrada: verificada para OPEC porque dominância condicional, nesting e `lambda_M^E > alpha` passam.

**Pendentes; não tratar como fechados:**
- Prioridade 1 (**substituída em 2026-08-12**): a antiga prioridade era o baseline limpo com opt-out imediato em `model_redesign/power_architecture_derivations.Rmd`. O opt-out foi removido e aquele workspace é proveniência. A prioridade corrente é o Goal 0 do contrato essential-input, derivando em `model_redesign/essential_input_*`. Continua valendo: usar `paper-version`/git tag antes de reset substantivo, e nunca criar tag enganosa em worktree suja.
- Revisão independente de coerência global de `formal_model_v6.Rmd` depois da migração do clean-baseline reset. A prova de rejected histories em v5 recebeu A+, mas v6 precisará de leitura final própria.
- Checar captions, figuras e tabelas para garantir que tudo usa a arquitetura fixed-pie relative-package `pi_H=0` e não importa linguagem antiga de feasibility/C-B-R ou random proposer.
- Reauditar Appendix C somente depois de estabilizar o modelo binário redesenhado.
- Decidir se haverá extensão separada para rule-choice/signaling. O modelo principal segura rule choice fixo para isolar screening; eventual extensão pode mostrar que signaling reduz, preserva ou amplifica screening.
- Tratar `pi_H > 0` e H-proposer agenda power apenas como extensões com lower bounds, upper bounds selection-free ou simulações, não como parte do teorema principal sem rederivação.
- Manter No-Cheap-H como condição de escopo natural do ambiente hegemônico. O caso `a_0^M < beta/m` é possível, mas periférico para hegemon/weak states e deve ser marcado como extensão.

**Remark weighted**: Screening depende de inclusão estratégica, não pivotalidade formal.

### Correção crítica das provas (2026-05-10)

O parecerista estava correto: o appendix antigo calculava payoffs de maioria
como se a outside option de H fosse paga pela coalizão majoritária. Isso é
errado no modelo. No branch histórico em que W exclui H, H recebe
`alpha V(theta)` externamente; o pie institucional disponível aos fracos não é
reduzido por `(1-alpha)`. A contabilidade externa sobrevive ao reset, mas a
seleção do branch no-H deve ser rederivada.

Inequality importante:

```text
lambda_M^E > alpha  iff  alpha < 1 - beta(q-1)/N
```

Essa condição não segue automaticamente de `alpha < 1/r`.

Sob strict BF, W não pode propor mais do que cabe no estado baixo quando a proposta pode passar nesse estado. Por isso o antigo cutoff único de R1 é supersedido por `max{A,C,R}`. Na calibração, isso gera `A-C-A`: agressivo em crenças baixas, conservador em crenças intermediárias, agressivo novamente em crenças altas porque a oferta conservadora deixa de ser factível.

### Atualização de prova: condições suficientes e nesting calibrado (2026-05-10)

Relatório de referência: `quality_reports/2026-05-10_sufficient_conditions_and_nesting.md`.

Scripts reprodutíveis:

```r
Rscript --vanilla scripts/verify_sufficient_conditions_lower_bound.R
Rscript --vanilla scripts/verify_calibrated_nesting_upper_bound.R
```

O primeiro script verifica a janela suficiente para dominância condicional e os endpoint gaps. O segundo verifica, para a calibração OPEC, que o upper bound dos payoffs dos fracos sob unanimidade fica abaixo do payoff dos fracos sob maioria em todos os ramos relevantes. Esses resultados sustentam uma arquitetura segura calibrada/paramétrica, mas não resolvem a classificação geral.

### Redesign: arquitetura de poder e `pi_H` (2026-05-10)

Relatórios de referência:

- `quality_reports/h_proposer_response_complete.md`
- `quality_reports/2026-05-10_model_redesign_weak_proposer_agenda.md`
- `quality_reports/2026-05-10_power_architecture_piH.md`
- `quality_reports/2026-05-25_clean_baseline_priority.md`
- `model_redesign/power_architecture_derivations.Rmd`

Conclusão: o ramo em que `H` propõe em R1 sob unanimidade é um jogo de signaling. Fora de accepted pooling, não há payoff único; PBEs mistos/semi-pooling dependem de tie-breaking e crenças off-path. Isso é ruído para a contribuição do paper.

Decisão: separar três fontes de poder:

1. **Outside-option power**: `H` tem `d_H = alpha V(theta)`.
2. **Veto/pivotality power**: sob unanimidade, `H` precisa aceitar.
3. **Proposal power**: `H` é reconhecido com probabilidade `pi_H`.

O baseline do modelo principal usa `pi_H = 0`. Em R1, weak states / coalizões não-hegemônicas fazem propostas; `H` é pivotal e informado. A justificativa substantiva é forte:

```text
Unanimity can favor a powerful privately informed actor not because it gives him more agenda power, but because it transforms his veto/acceptance behavior into an informational constraint on weaker states.
```

Para OPEC, a Arábia Saudita deve ser interpretada como ator pivotal informado, não agenda setter formal. O proposer representa os demais membros, o processo de conferência, comitês de quotas ou coalizões tentando montar um acordo viável.

Casos de extensão:

```text
pi_H = 1/N  : BF neutro/canônico, com H-proposer signaling branch.
pi_H > 1/N  : agenda power hegemônico.
```

Esses casos devem ser tratados com lower bounds, upper bounds selection-free e simulações calibradas quando não houver payoff function única.

### Reset: pacotes institucionais relativos (2026-05-11)

Relatórios / arquivos de referência:

- `model_redesign/power_architecture_derivations.Rmd` — documento limpo ativo.
- `quality_reports/2026-05-11_relative_package_reimplementation.md`.
- tag `redesign-feasibility-branch-2026-05-11` — arquivo histórico da tentativa C-B-R/feasibility.

Decisão: não usar mais a feasibility branch como mecanismo central. O problema
protocolo ficou dependente de quando a factibilidade é checada, se no-consent
revela o estado e se o tipo baixo de `H` consegue bloquear antes da checagem.

Arquitetura 2026-05-11, agora extensão/microfundamento:

```text
U_H(y, theta) = y + b_H(theta)
y_theta^*(mu') = beta C_H(theta, mu') - b_H(theta)
screening: y_1^*(mu') > y_0^*(mu')
```

Atualização prioritária de 2026-05-25 — **SUPERADA em 2026-08-12**. Ela mandava
começar pelo caso limpo com opt-out imediato de `H` em R1. O opt-out foi
removido; `b_theta=0` permanece. A fórmula acima continua sendo
extensão/microfundamento, e `max{o_theta,beta C_theta}` deixou de ser extensão
hipotética para virar consequência do desenho simétrico.

Interpretação OPEC: `y` é quota/share/flexibilidade/exceção/enforcement
favorável à Arábia Saudita; `b_H(theta)` é o benefício direto do acordo para a
Arábia Saudita; o tipo privado altera o threshold relativo de participação.

Próximo alvo formal: definir o custo de `y` para a coalizão fraca e derivar R2
unanimity no documento limpo. Criar scripts novos `scripts/verify_relative_package_*.R`.

### Workspace formal separado

A nova arquitetura deve ser desenvolvida fora do manuscrito. O documento de trabalho é:

```text
model_redesign/power_architecture_derivations.Rmd
```

Motivo: o erro anterior veio em parte de manter fórmulas de uma arquitetura antiga no corpo/apêndice enquanto a interpretação do outside option mudava. A regra agora é provar, auditar e compilar o documento separado antes de transportar qualquer theorem statement, fórmula ou figura para `formal_model_v6.Rmd`.

### Prompt recomendado para próxima sessão

A especificação canônica e executável é
`quality_reports/plans/2026-08-12_essential_input_gate0.md`, status APPROVED,
e seu prompt na Seção 14 governou a abertura original do Gate 0. Decisões
autorais explícitas posteriores autorizaram e encerraram o Goal 4 com N7
congelado; ver `quality_reports/2026-08-21_fechamento_autoral_goal4_n7.md`.
O Goal 5 foi autorizado em 2026-08-21 e encerrado pelo aval autoral terminal de
2026-08-25; a tag `v6-essential-input-2026-08-25` fixa a versão final. Ver
`quality_reports/2026-08-21_autorizacao_goal5.md` para a abertura e o cabeçalho
do contrato Gate 0 para o status canônico da fase.

O plano `2026-08-03-clean-baseline-goal.md` e o prompt abaixo são **históricos**:
especificam a arquitetura com opt-out imediato, removida em 2026-08-12. Não
executar.

Prompt histórico, superado — não rodar:

```text
Estamos no repo PowerBayesianPersuasion. Leia AGENTS.md, formal_model_v6.Rmd, formal_model_v5.Rmd, quality_reports/2026-05-15_ajps_revision_scope_after_discussion.md e quality_reports/2026-05-25_clean_baseline_priority.md. O alvo correto do próximo manuscrito é formal_model_v6.Rmd; formal_model_v5.Rmd é referência histórica da integração de 2026-05-15. Prioridade 1: antes de mexer no manuscrito v6, rederivar em model_redesign/power_architecture_derivations.Rmd o baseline limpo com b_theta=0 e opt-out imediato de H em R1: se H rejeita, nenhum acordo inclui H e o tipo theta recebe o_theta sem desconto. Trate delayed continuation dentro da IO, o caso hibrido max{o_theta,beta C_theta} e t_theta=d_theta-b_theta como extensões/microfundamentos. Preserve o protocolo adotado: o jogo é sequencial e público entre rodadas, mas dentro de cada ballot todos os não proponentes votam simultaneamente e os votos individuais só se tornam públicos após o fechamento; isso não é votação roll-call sequencial. Use paper-version/git tag workflow antes de reset substantivo, mas não crie tag enganosa em worktree suja. Preserve a linguagem de comparação institucional condicional, weak-state agenda pi_H=0 e weak-vote-passive assessment quando migrar para v6. Trate P/L/R e o rejected-history reduction lemma de v5 como candidatos históricos: preserve-os somente se forem rederivados no novo extensive form e, nesse caso, não alegue unicidade nem caracterização de todos os PBEs. Após implementar o reset, dois revisores independentes e sem edição devem revisar: um com formal-model review e outro com adversarial math/game-theory audit.
```

## PENDÊNCIAS RIO — Comparação com Hirsch & Shotts (AJPS 2025)

Fonte: `quality_reports/2026-04-27_comparison_hirsch_shotts.md`

### 1. Introdução

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Hook (fato estilizado concreto) | H&S superior (filibuster vs puzzle abstrato WTO) | **FEITO** — OPEC case study ancora na realidade |
| Preview de resultados counterintuitivos | H&S muito superior | **FEITO** |
| Apelo ao leitor não-técnico | H&S superior (WashPost, ACA) | **FEITO** — OPEC como exemplo tangível |
| Roadmap | Ausente | **FEITO** |

### 2. Discussão da Literatura

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Título substantivo | Corrigido (2026-04-27) | **FEITO** |
| Integração com o argumento (vs. catalográfica) | H&S superior | **FEITO** (2026-04-29) — "but" clauses, Koremenos reposicionado |
| Predição discriminante | Galdino superior | **FEITO** — adicionada distinção com Koremenos V3 |
| Posicionamento papers próximos | Adequado | **FEITO** — Koremenos conflicting predictions, Kim no corpo, Bardhi footnote |

### 3. Apresentação do Modelo

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Concisão (~3pp vs H&S ~1pp) | Galdino 3x mais longo | **PENDENTE** — footnotes migradas, mas modelo ainda longo demais |
| Footnotes na Definition 1 | 4 footnotes pesadas | **FEITO** (2026-04-29) — fn2 migrada para Scope, fn4 simplificada |
| Game trees (2 landscape pages) | Stage 0-1 trivial, Stage 2 tem valor | **PENDENTE** — cortar Stage 0-1 ou mover para appendix |
| Intuição verbal ANTES de resultados | H&S superior | **PARCIAL** — Motivating Example existe, mas falta intuição antes de cada proposição no corpo |
| Provas no corpo vs. appendix | Indeciso | **FEITO** — padrão Hirsch: sem proof sketches no corpo, roadmap migrado para B.5 |

### 4. Aplicações e Exemplos

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Mapping modelo→realidade | H&S muito superior | **FEITO** — OPEC: Saudi=H, spare capacity=θ, production share=α |
| Evidência empírica | Zero | **FEITO** — OPEC case study com dados reais |
| Exemplos numéricos calibrados | Inventados, hand-waving | **FEITO** — OPEC calibrado; motivating example honestamente "illustrative" |
| Confrontar predições com padrões observados | H&S muito superior | **FEITO** — OPEC 1985-86 price war, Angola/UAE exits confrontam Prop 4 |
| Figuras conectadas à realidade | Mundo abstrato | **PARCIAL** — calibradas para OPEC, mas sem dados empíricos reais (cf. H&S Figure 6) |

### 5. Conclusão

| Aspecto | Diagnóstico original | Status |
|---------|---------------------|--------|
| Implicações de policy | Ausentes | **PENDENTE** |
| Limites | Galdino superior em honestidade técnica | **FEITO** |
| Extensões | Adequadas | **FEITO** |

### Pendências remanescentes (pré-submissão RIO)

**Exposição (padrão Hirsch & Shotts)**
- [ ] Concisão do modelo — ~3pp, reduzir. Candidatos: parágrafo justificando 2 rounds (l.112), descrição dos 3 stages
- [ ] Game tree Stage 0-1 — cortar ou mover para appendix (trivial, ocupa 1 página landscape)
- [ ] Intuição verbal ANTES de cada proposição no corpo — Motivating Example existe, mas Props 1-3 no corpo não têm setup intuitivo antes do enunciado formal
- [x] Provas sem sketch no corpo — padrão Hirsch: roadmap pós-Thm 1 migrado para B.5 (2026-04-29)
- [ ] Figuras conectadas à realidade — calibradas para OPEC, mas sem dados empíricos reais (cf. H&S Figure 6 com Nominate scores)
- [ ] Implicações de policy na conclusão — OPEC reform e erosão estão na Discussion, não migram para Conclusion

**Arquivos de submissão (`RIO submission files/`)**
- [x] Corrigir 13 cross-refs quebradas no appendix — resolvido via `\usepackage{xr}` + `\externaldocument{01_manuscript}` (2026-04-30)
- [x] Remover frase "The decomposition is derived in Appendix B.5a." — removida do Rmd e do .tex (2026-04-30)
- [x] TikZ inline → `\includegraphics` — figuras standalone em `figures/fig{1,2}_*.tex`, script copia PDFs (2026-04-30)
- [x] Bib duplicada no appendix — removida; appendix sem seção References (2026-04-30)
- [x] Recompilar ambos os .tex — compilado 2x, 0 undefined refs (2026-04-30)
- [x] Submeter ao RIO — submetido 2026-04-30
- [x] Preprint no SocArXiv — upload 2026-04-30, aguardando moderação

#### Histórico de itens concluídos
Sessões 2026-04-27b e 2026-04-29: RIO-1 a RIO-10 (Scope, Lit Review, provas B.1/B.8, calibração, Conclusão), notação corrigida, Remark weighted voting, readability (passivas, em dashes, footnotes), Hirsch integration (Koremenos, Bardhi, Kim, predição discriminante). Sessão 2026-04-30: cross-refs appendix, TikZ→includegraphics, bib duplicada, recompilação final, submissão RIO + preprint SocArXiv. Detalhes em `git log`.

## Puzzle central

**Por que EUA aceitam consenso na OMC?** Três camadas (atualizadas em
2026-09-01 aos resultados congelados; a formulação anterior usava a
parametrização histórica αV(θ) do modelo de pie variável e a margem de
entrada do paper antigo — nenhuma das duas existe no v6):
1. Por que não agenda control? → Na extensão M/S/B, agenda obrigatória para H
   paga a renda de proponente (D_U = 1−β) mas lança sombra informacional
   (I_U ≤ 0 em fibers de prior alto; IR_U^A(h) ≤ 0), e com βh < e/m maioria
   domina estritamente para os dois tipos — agenda não é dominante. A resposta
   antiga "mata entrada (V_W = 0)" pertence ao paper com custo de entrada.
2. Por que não maioria? → Resultado congelado (prop:majority): quando
   1/m < ℓ (região XX), maioria exclui H para todo prior; H recebe o_θ e a
   informação privada vale exatamente zero (RI_M = (0,0)). A fórmula αV(θ) é
   da parametrização histórica, não do baseline o_θ.
3. Por que unanimidade? → Pooling sob pivotalidade: para p > p*, unanimidade
   paga o threshold alto e o tipo baixo ganha d = β(h−ℓ) (RI_U = (d,0)).
   Consenso preserva o canal informacional que nenhuma agenda compra.

## Compilação

O paper usa `bookdown::pdf_document2` (definido no YAML). Para compilar corretamente:

```r
rmarkdown::render("formal_model_v6.Rmd")
```

**NÃO** usar `output_format = "pdf_document"` — isso ignora o YAML e quebra cross-references de figuras (`\@ref(fig:...)`) gerando warnings de "undefined references". Deixar sem argumento para usar o formato do YAML.

## Referências-chave

### Barganha legislativa
- Baron & Ferejohn (1989) — Modelo base
- Kalandrakis (2006, AJPS) — Proposal rights e poder político
- Eraslan & Evdokimov (2019) — Survey

### Information and voting
- Bardhi & Guo (2018, AER) — Information design sob unanimidade (sem barganha)
- Kim, Kim & Van Weelden (2025, AJPS) — Persuasion in veto bargaining (bilateral, sem institutional choice)
- Kamenica & Gentzkow (2011, AER) — Bayesian Persuasion framework

### Design institucional
- Koremenos, Lipson & Snidal (2001) — Rational design of IOs
- Steinberg (2002) — Consensus at WTO
- Gould (2022) — Cross-section of consensus rules

## Estrutura do Repositório

```
├── AGENTS.md                          # Memória operacional para Codex (fonte principal atual)
├── CLAUDE.md                          # Memória legada para Claude; manter sincronizada com AGENTS.md
├── formal_model_v6.Rmd               # Paper alvo correto do próximo manuscript pass
├── formal_model_v5.Rmd               # Referência histórica (v5, screening central)
├── formal_model_v4.Rmd               # Arquivo (v4, BP co-protagonista)
├── formal_model_v2.Rmd               # Arquivo (v2, provas no corpo)
├── references.bib                     # Referências bibliográficas
├── scripts/model_functions.R          # Funções R do modelo
├── notes/                             # Notas de trabalho
├── figures/                           # Figuras geradas
├── archive/                           # Modelos abandonados
├── references/                        # PDFs de referências
├── quality_reports/                   # Relatórios de qualidade e planos
└── formal_proofs/                     # Lean 4 (segurança interna)
```

## Verificação Formal (Lean 4)

**REGRA**: Lean é ferramenta de segurança interna do PI. NÃO entra no paper, NÃO serve como base para escrita.

**Status** (2026-05-10): As provas Lean existentes verificam a arquitetura anterior e devem ser tratadas como segurança interna legada. Elas precisam ser atualizadas antes de qualquer uso substantivo, porque a correção de majority outside option externa e strict BF feasibility invalidou partes centrais da prova antiga.

### O que o Lean verificava antes da correção de 2026-05-10

- **Theorem 1** (conditional dominance iff): ÁLGEBRA COMPLETA — 19 teoremas encadeados
- **Prop 1** (majority affine + λ_M > α): ÁLGEBRA COMPLETA
- **Prop 3** (screening jump): ÁLGEBRA COMPLETA
- **Prop 2** (R1 cutoff): LÓGICA ABSTRATA — IVT correto, boundary values assumidos
- **Corollary** (F_U ⊆ F_M): LÓGICA ABSTRATA — budget identities assumidas
- **Prop 4** (classificação): LÓGICA ABSTRATA — herda gaps do Corollary
- **LemmaVWMax** (V_W global max): PARCIAL — 1/4 candidatos verificados

**Não usar esse status como evidência atual.** As provas Lean existentes verificam arquiteturas já abandonadas, incluindo a de opt-out imediato. Não há alvo Lean definido enquanto a cadeia essential-input não estabilizar; quando houver, o alvo será o baseline simétrico sem opt-out. O regime `A/C/R`, a factibilidade BF e o antigo lower bound do ramo H-proposer são história diagnóstica.

### O que o Lean NÃO verifica (e por quê)

- **Backward induction / PBE**: Nenhum proof assistant formalizou barganha legislativa. Estimativa: 2-4 meses. Fora do escopo.
- **LP / otimização de offers**: Mathlib não tem LP. Desnecessário (otimalidade trivial neste modelo).
- **Concavificação / BP**: Relegada a Remark no v5. Baixa prioridade.

### Próximos passos Lean

Roadmap detalhado em `quality_reports/2026-04-29_lean_v5_roadmap.md`. Resumo:

1. **Definir payoffs de equilíbrio + verificar budget identities** (~100 linhas, fecha Corollary + Prop 4)
2. **Verificar 3 candidatos restantes do LemmaVWMax** (~200 linhas, fecha gap de maior risco)
3. **Derivar boundary values de Δ₁** (~80 linhas, fecha Prop 2)

### Relatórios de referência

- Fidelidade: `quality_reports/2026-04-29_lean_fidelity_v5.md`
- Roadmap: `quality_reports/2026-04-29_lean_v5_roadmap.md`
- Game theory em Lean: `quality_reports/2026-04-29_lean4-game-theory-landscape.md`

### Skills disponíveis

- `/lean-proofs` — orquestrador: extrai do paper, monta scaffold, invoca tactic loop. **Gera Relatório de Fidelidade obrigatório** (classifica cada teorema como ÁLGEBRA COMPLETA / LÓGICA ABSTRATA / PARCIAL).
- `/lean-tactic` — loop iterativo: aplica tática por vez, lê goal state, interpreta, repete.
- `/lean-dashboard` — status de verificação.
- `/lean-setup` — configurar ambiente.

## Papers Futuros

- **Erosão endógena**: Jogo repetido, fracos investem para aprender V(θ). Projeto separado.
- **Heterogeneidade**: Outside options heterogêneas, potências médias. Movido para `/Users/manoelgaldino/Documents/DCP/Papers/heterogeneous-informational-power/`.

## Convenções

- **Frase parqueada da introdução**: quando a extensão de agenda fechar, a introdução ganha a formulação dos dois cenários (com e sem direito de proposta). Texto exato e o que revisar junto em `notes/2026-08-25_frase_introducao_apos_extensao_agenda.md`. Não inserir antes: o corpo afirma em quatro lugares que o hegemon nunca propõe, e a contribuição depende disso.

- **AGENTS.md é a fonte operacional principal para Codex**. Atualizar `AGENTS.md` e `CLAUDE.md` quando o status das provas mudar.
- **Não confiar no corpo principal para status das provas** até a próxima rodada de revisão textual; o appendix corrigido é a referência atual.
- **REGRA CRÍTICA — Pareceres completos**: Ao rodar QUALQUER skill de review, o output COMPLETO DEVE ser salvo em `quality_reports/YYYY-MM-DD_nome-do-review.md`. NUNCA truncar. NUNCA salvar apenas resumo.
- **v6 é o paper alvo correto para revisão e eventual nova submissão**; v5 é referência histórica; v4 preservado intacto; v2 preservado como arquivo
- **Paper é documento atemporal**: NUNCA referenciar versões anteriores ou mudanças. Escrever como se o leitor visse pela primeira vez.
- Notas em Markdown, modelo formal em Rmd → PDF
- Idioma: português para notas; inglês para o paper
- N genérico sempre. Exemplo motivador (Seção 2): usar **N=5** (decisão do autor,
  2026-08-21 — ímpar evita empates de maioria e fica dentro do domínio m≥3 da
  comparação; N=3 era a versão antiga). O exemplo corrente em
  `formal_model_v6.Rmd` usa um hegemon e quatro weak states, isto é, N=5, e a
  migração do Goal 5 removeu o opt-out imediato. Não reintroduzir N=3 nem
  linguagem de opt-out.
- Sob maioria no clean reset: W **pode** excluir H, mas exclusão/no-screening é
  um resultado a rederivar, não uma convenção. A frase histórica “W exclui H”
  vale apenas no branch no-H das provas corrigidas anteriores. Em qualquer
  branch, a outside option de H permanece externa ao pie.
- **Citações em ambientes LaTeX**: Dentro de `\begin{...}...\end{...}`, usar `[@key]` (bookdown resolve).
