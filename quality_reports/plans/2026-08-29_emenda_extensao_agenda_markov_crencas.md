# Emenda ao Gate 0 da extensão de agenda — seleção markoviana de continuação e crenças off-path constantes

**Data:** 2026-08-29
**Status:** PROPOSED — aguardando aprovação autoral. Nenhuma cláusula vale antes
do aval explícito do autor registrado neste arquivo (status → APPROVED).
**Contrato emendado:**
`quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md`,
presente no branch `codex/agenda-extension-am-exploratory` (snapshot `b675a37`).
**Gatilho:** certificado negativo da Seção 6.1 de
`model_redesign/agenda_extension_A_M_explicit_majority_results.md`
(SHA-256 `1e385fabd2e25a5b72344d22982d9648e28be92eb68665d484cd8116aaa7772f`),
explicado em
`quality_reports/2026-08-29_memoria_resultado_extensao_agenda_maioria.md` e
confirmado por três explorações independentes
(`quality_reports/2026-08-28_A_M_AMX014_016_exploration_convergence.md`).
AMX-014/015/016 estão `BLOCKED — NO INFORMATIVE COMPLETION UNDER CURRENT
CONTRACT`.
**Escopo:** cadeia da extensão de agenda (`A_M`, `A_U`, `AC`, `AR`). O baseline
congelado N1–N7, a tag `v6-essential-input-2026-08-25` e a decisão de conceito
de solução de 2026-08-21 para o jogo sem estágio de proposta de `H` permanecem
intactos e fora do alcance desta emenda.

## 1. Motivação

O contrato vigente permite que `kappa_g` selecione membros distintos da
continuação para histórias rejeitadas distintas (§4) e deixa a crença livre,
ponto a ponto, em toda proposta com vizinhança de massa pública zero (§3.1). O
certificado negativo mostra que essa dupla liberdade destrói o objeto de
estudo: com `N=5, m=4, k=2, beta=0.9, o_0=0.30, o_1=0.40`, um seletor Borel
admissível torna o payoff de `H` arbitrariamente próximo de `0.51` sem nunca
atingi-lo, de modo que não existe melhor resposta pura nem mista e nenhum PBE
usa esse seletor. A existência deixa de ser uniforme nos seletores permitidos e
a classificação completa vira reescrita da definição de equilíbrio.

O fenômeno tem precedente canônico no modelo-base do paper: Baron & Ferejohn
(1989) mostram que, sob maioria com estratégias dependentes de história,
essencialmente qualquer divisão do bolo é sustentável em equilíbrio, e a
resposta da literatura desde então é restringir a seleção a estados
payoff-relevantes (equilíbrio estacionário no jogo infinito deles; Kalandrakis
2006 e o survey de Eraslan & Evdokimov 2019 operam nesse padrão). Esta emenda
adota a versão finita dessa disciplina. As construções positivas já
testemunhadas (Seções 3–4 dos resultados exploratórios) satisfazem todas as
cláusulas abaixo; a emenda remove exatamente a liberdade que só o contraexemplo
adversarial usa.

## 2. Cláusula M — seleção markoviana de continuação

**Texto normativo.** `kappa_g` fatora pelo estado payoff-relevante: histórias
públicas rejeitadas que entram no mesmo ponto estrutural da continuação com o
mesmo posterior público selecionam o mesmo membro. Formalmente,
`kappa_g(h) = kappa_g(h')` sempre que `h` e `h'` induzem o mesmo estágio de
continuação e o mesmo posterior `mu` no fechamento do ballot rejeitado. Em
particular, `kappa_g` não varia com a identidade da proposta rejeitada nem com
o vetor de votos. Esta cláusula substitui, no §4 do contrato, o trecho
"Histórias distintas podem selecionar membros distintos. Se uma compressão por
posterior ou outro estado suficiente for pretendida, ela exige prova; não é
presumida": a compressão por (estágio, posterior) passa a ser regra do
protocolo, decidida como primitiva autoral.

### Decisão: dependência admissível de `kappa_g`
- **Escolha**: dependência apenas de (estágio de continuação, posterior público).
- **Alternativas descartadas**:
  - `kappa_g` livre Borel-mensurável na história: descartada porque o
    certificado §6.1 prova não-existência de melhor resposta sob seletores
    admissíveis dessa classe e impossibilidade de classificação informativa.
  - dependência do vetor de votos: descartada porque, sob no-signaling, votos
    fracos não movem o posterior; a dependência serviria apenas a punições de
    votantes individuais no estilo folk de Baron–Ferejohn, exatamente a classe
    de construção que a emenda elimina.
  - rótulo "estacionariedade": reservado ao análogo de horizonte infinito. O
    jogo da extensão é finito e rodadas distintas são jogos distintos; o termo
    tecnicamente correto para a cláusula é markoviano, com o estágio dentro do
    estado. Baron–Ferejohn (1989) entra como precedente, com nome próprio do
    caso recursivo infinito.

## 3. Cláusula S — simetria na continuação

**Texto normativo.** Para cada (estágio, posterior), o membro selecionado trata
simetricamente Estados fracos ex-ante idênticos: as loterias de coalizão e de
reconhecimento do membro são balanceadas entre os fracos. Junto com a Cláusula
M, isso institui o membro cíclico/balanceado usado nas construções como
representante canônico de `C_M` por posterior.

### Decisão: seleção dentro de `C_g` a posterior fixado
- **Escolha**: membro simétrico/balanceado (igual tratamento de iguais; é a
  seleção simétrica padrão da literatura de barganha legislativa; a
  multiplicidade residual de `C_M` é escolha de parceiros de coalizão).
- **Alternativas descartadas**:
  - membro assimétrico privilegiado: descartado por ausência de fundamento
    substantivo; nenhuma primitiva distingue os fracos.
  - manter a correspondência plena como entregável: descartada porque é o
    estado bloqueado atual — o conjunto exato indexado por seletores livres é
    a definição de PBE em notação mais longa.

## 4. Cláusula B — crença constante nos pontos não disciplinados

**Texto normativo.** No §3.1 do contrato, onde a crença "fica livre dentro do
suporte do prior" nos pontos com vizinhança relativa de massa pública zero,
passa a valer: cada assessment anuncia um único `nu_off in [0,1]` e fixa
`mu(y) = nu_off` em todo ponto não disciplinado. `nu_off` respeita o suporte do
prior: em `nu = 0` vale `nu_off = 0` e em `nu = 1` vale `nu_off = 1`, herdando
a Emenda 1a. A regra local de Bayes em pontos disciplinados permanece intacta,
inclusive a obrigação de escalar quando o limite não existir.

**O que a cláusula proíbe.** Mapas `y -> mu(y)` que variam entre pontos de
massa pública zero. Sem esta cláusula, a Cláusula M é contornável: a
continuação olharia apenas o posterior, mas o posterior off-path viraria um
disfarce da proposta, e o interruptor do certificado renasceria dentro do
sistema de crenças (risco antecipado na Seção 8 da memória de 2026-08-29).

### Decisão: disciplina de crenças off-path
- **Escolha**: constância com nível livre — um único `nu_off` por assessment,
  igual para todas as propostas fora do suporte, tratado como objeto do
  equilíbrio. A classificação fica indexada pelo escalar `nu_off`, prática
  padrão em jogos de sinalização.
- **Alternativas descartadas**:
  - crença livre ponto a ponto: descartada porque reconstrói o contraexemplo
    através das crenças mesmo sob a Cláusula M.
  - crença passiva estrita (`nu_off = nu` sempre): descartada como cláusula
    única porque eliminaria as famílias separating testemunhadas — as
    construções das Seções 3.2–3.3 dos resultados usam posterior off-path 0 ou
    1 para deter imitação — sem ganho adicional de existência. Permanece
    admissível como caso particular, e resultados que dependem de `nu_off`
    devem destacar a parte invariante.
  - D1/Critério Intuitivo como fundação: descartados porque fazem a crença
    off-path depender da proposta por desenho, e o §3.2 do contrato já os
    exclui do baseline; permanecem admissíveis como diagnóstico ex post sobre o
    conjunto classificado.
  - continuidade primitiva de `y -> mu(y)`: descartada porque é difícil de
    enunciar como primitiva num contínuo com nível livre e ainda permite
    liberdade por regiões.

## 5. Desempates preservados

Voto fraco as-if-pivotal, aceitação na indiferença e `T^Y` (§3 itens 1–2 do
contrato e decisão de 2026-08-21) permanecem sem alteração. Nada nesta emenda
toca a regra local de Bayes em pontos disciplinados.

## 6. Reescopo dos entregáveis

1. **Novo primeiro entregável**: lema de existência de PBE sob as Cláusulas
   M/S/B, por região paramétrica. As cláusulas tornam o problema de `H`
   semicontínuo superior sobre um simplex compacto na região off-path; a
   demonstração formal é obrigação do candidato, com revisão independente.
2. **AMX-014/015 reescopados**: classificação de outcomes e payoffs a menos de
   equivalência de payoffs, indexada por `(nu, nu_off)`. A enumeração de perfis
   de estratégia deixa de ser meta: a família atomless da Seção 6.1, com
   payoffs idênticos `(beta*o_0, beta*o_1)`, mostra que perfis distintos com o
   mesmo outcome não carregam conteúdo econômico.
3. **AMX-016 reescopado**: conjunto exato de payoffs por tipo sob M/S/B, com a
   parte invariante em `nu_off` destacada.
4. **Certificado negativo preservado**: vira resultado permanente e motivação
   desta emenda, citável como remark na escrita; os equilíbrios testemunhados e
   os limites globais da Seção 5.4 seguem válidos como construções.

## 7. Consequências assumidas

- Os preços de voto colapsam: `r_lower = r_upper = r(mu)` em todo o espaço de
  propostas, fechando o gap "sem voto puro admissível" da Seção 6.1.
- As testemunhas das Seções 3–4 satisfazem M/S/B como construídas (seletor
  constante dado o posterior; `nu_off` constante por construção) e entram como
  candidatos no novo snapshot; nada é herdado automaticamente sem re-validação.
- `A_M` rederiva do zero sob o contrato emendado. `AC` e `AR` reabrem, porque
  consumiram a interface de `A_M`. `A_U` deve ser auditada pela mesma
  liberdade (`kappa_U` e crenças): sob unanimidade não há escolha de coalizão,
  mas a Cláusula B se aplica igualmente.
- Verificar coerência com a convenção de continuação efetivamente usada por
  N3/N6 no baseline congelado: a extensão herda a leitura simétrica existente,
  sem redefini-la.

## 8. Protocolo

- Rederivação em snapshot novo, com implementador ≠ revisor; Fable permanece
  inelegível como revisor da cadeia (alocação de 2026-08-23); revisão
  matemática independente sobre os bytes novos; verificação mecânica não
  substitui prova.
- A aprovação desta emenda precede qualquer derivação. Pedidos de "continuar
  procurando" sob o contrato antigo estão vedados: o obstáculo tem certificado.

## 9. Invalidação

- Alterar qualquer cláusula desta emenda reabre todos os claims AMX
  downstream e as revisões correspondentes.
- Esta emenda não altera nem reinterpreta artefatos congelados do baseline
  essential-input; qualquer conflito aparente escala ao autor.

## Referências

- Baron, D. & Ferejohn, J. (1989). Bargaining in Legislatures. *APSR* —
  multiplicidade folk sob maioria com estratégias história-dependentes e
  resposta via equilíbrio estacionário.
- Maskin, E. & Tirole, J. (2001). Markov Perfect Equilibrium. *JET* — estados
  payoff-relevantes como fundamento da restrição markoviana.
- Bhaskar, V., Mailath, G. & Morris, S. (2013). A Foundation for Markov
  Equilibria in Sequential Games with Finite Social Memory. *REStud* —
  fundação por purificação e memória finita.
- Eraslan, H. & Evdokimov, K. (2019). Legislative and Multilateral Bargaining.
  *Annual Review of Economics* — SSPE como conceito padrão da literatura.
