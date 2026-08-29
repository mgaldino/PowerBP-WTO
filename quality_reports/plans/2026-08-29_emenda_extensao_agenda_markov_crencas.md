# Emenda ao Gate 0 da extensão de agenda — seleção markoviana de continuação e crenças off-path constantes

**Data:** 2026-08-29 (v2)
**Status:** APPROVED — aval autoral concedido em 2026-08-29, na sessão Claude
Code, sobre o texto integral da v2. As cláusulas M/S/B governam a cadeia da
extensão de agenda a partir desta data.
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
**Histórico de revisão:**
- v1 (2026-08-29): draft inicial, Fable.
- v2 (2026-08-29): incorpora integralmente a revisão independente de Sol 5.6
  trazida pelo autor — registro completo e mapeamento ponto-a-seção em
  `quality_reports/2026-08-29_review_sol56_emenda_extensao_agenda.md`. Mudanças:
  domínio formal de `nu_off` por vizinhanças; vinculação institucional de
  `nu_off`; Cláusula S reescrita como classe anônima de payoffs com
  representante uniforme; correção do argumento de existência (sem alegação de
  semicontinuidade superior); assinatura de equivalência downstream; ajustes de
  literatura.
- APPROVED (2026-08-29): aval autoral concedido sobre a v2, sem alterações de
  texto entre a v2 e a aprovação.

## 1. Motivação

O contrato vigente permite que `kappa_g` selecione membros distintos da
continuação para histórias rejeitadas distintas (§4) e deixa a crença livre,
ponto a ponto, em toda proposta com vizinhança relativa de massa pública zero
(§3.1). O certificado negativo mostra que essa dupla liberdade destrói o objeto
de estudo: com `N=5, m=4, k=2, beta=0.9, o_0=0.30, o_1=0.40`, um seletor Borel
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
testemunhadas (Seções 3–4 dos resultados exploratórios) cumprem as cláusulas
abaixo na leitura de classes de payoff; a verificação formal disso integra a
re-validação prevista no §7. A emenda remove exatamente a liberdade que só o
contraexemplo adversarial usa.

## 2. Cláusula M — seleção markoviana de continuação

**Texto normativo.** Defina o estado suficiente da continuação

```text
phi_g(h) = (instituição g, nó/estágio de entrada da continuação, posterior público mu(h)),
```

onde `mu(h)` é o posterior público no fechamento do ballot rejeitado. A
cláusula exige

```text
kappa_g(h) = kappa_hat_g(phi_g(h))
```

para alguma função `kappa_hat_g` Borel-mensurável. Os parâmetros fixos do jogo
— `N`, `m`, quota `k`, `beta`, `(o_0, o_1)` — são constantes globais do
contrato, não variam com a história e ficam implícitos em `phi_g`. Em
particular, `kappa_g` não varia com a identidade da proposta rejeitada nem com
o vetor de votos. Esta cláusula substitui, no §4 do contrato, o trecho
"Histórias distintas podem selecionar membros distintos. Se uma compressão por
posterior ou outro estado suficiente for pretendida, ela exige prova; não é
presumida": a compressão por `phi_g` passa a ser regra do protocolo, decidida
como primitiva autoral.

### Decisão: dependência admissível de `kappa_g`
- **Escolha**: dependência apenas de `phi_g(h)` (instituição, estágio de
  continuação, posterior público), na fatoração acima.
- **Alternativas descartadas**:
  - `kappa_g` livre Borel-mensurável na história: descartada porque o
    certificado §6.1 prova não-existência de melhor resposta sob seletores
    admissíveis dessa classe e impossibilidade de classificação informativa.
  - dependência do vetor de votos: descartada porque a proposta rejeitada e o
    vetor de votos não alteram o jogo que começa após a rejeição além da
    informação contida no posterior; a dependência serviria apenas a punições
    de votantes individuais no estilo folk de Baron–Ferejohn, baseadas em
    eventos sem efeito econômico futuro.
  - rótulo "estacionariedade": reservado ao análogo de horizonte infinito. O
    jogo da extensão é finito e rodadas distintas são jogos distintos; o termo
    tecnicamente correto para a cláusula é markoviano, com o estágio dentro do
    estado (Maskin & Tirole 2001). Baron–Ferejohn (1989) entra como
    precedente, com nome próprio do caso recursivo infinito.

## 3. Cláusula S — anonimidade na continuação

**Texto normativo.** Para cada valor de `phi_g`, a seleção recai sobre a classe
de equivalência anônima de payoffs de `C_g`: membros cujos vetores de payoffs
interinos são invariantes a permutações dos Estados fracos. O representante
canônico é a loteria uniforme: quando um fraco é reconhecido, seus parceiros de
coalizão são sorteados uniformemente entre todas as coalizões admissíveis do
tamanho requerido. O membro cíclico usado nas construções exploratórias
permanece admissível como implementação computacional, condicionado à
verificação de que é payoff-equivalente ao representante uniforme. A
rederivação deve verificar que o representante adotado é membro literal da
correspondência congelada relevante (`C_M`; `C_U` onde aplicável); essa
verificação é obrigação de prova, não presunção.

### Decisão: seleção dentro de `C_g` a posterior fixado
- **Escolha**: classe de equivalência anônima de payoffs, com a loteria
  uniforme como representante literal — genuinamente invariante a permutações
  dos nomes; igual tratamento de iguais, na linha da seleção simétrica da
  literatura de barganha legislativa.
- **Alternativas descartadas**:
  - membro cíclico como seleção canônica literal: rebaixado a implementação —
    entrega as mesmas frequências marginais de inclusão, mas sua estrutura de
    coalizões depende de uma ordenação artificial dos nomes; várias outras
    loterias balanceadas produzem os mesmos payoffs.
  - membro assimétrico privilegiado: descartado por ausência de fundamento
    substantivo; nenhuma primitiva distingue os fracos.
  - manter a correspondência plena como entregável: descartada porque é o
    estado bloqueado atual — o conjunto exato indexado por seletores livres é
    a definição de PBE em notação mais longa.

## 4. Cláusula B — crença constante nos pontos não disciplinados

**Domínio de aplicação.** A cláusula usa a taxonomia do §3.1 do contrato, com o
critério de vizinhanças relativas `B_delta^Y(y)` e a medida pública `m`:

1. **Ponto disciplinado** — `m(B_delta^Y(y)) > 0` para todo `delta > 0`: vale o
   limite local de Bayes do contrato; se o limite não existir num ponto
   disciplinado, o ramo para e escala (§3.1, preservado).
2. **Massa pontual zero não torna um ponto não disciplinado.** Em medidas
   contínuas, pontos cuja toda vizinhança relativa tem massa pública positiva
   são disciplinados e seus posteriores variam conforme Bayes. A expressão
   "fora do suporte" não é usada nesta cláusula; o critério é exclusivamente o
   de vizinhanças.
3. **Ponto não disciplinado** — existe `delta > 0` com `m(B_delta^Y(y)) = 0`:
   a crença deixa de ser livre ponto a ponto e passa a valer
   `mu(y) = nu_off`, com um único `nu_off in [0,1]` anunciado pelo assessment.

`nu_off` respeita o suporte do prior sobre os tipos (Emenda 1a): em `nu = 0`
vale `nu_off = 0` e em `nu = 1` vale `nu_off = 1`.

**O que a cláusula proíbe.** Mapas `y -> mu(y)` que variam entre pontos não
disciplinados. Sem esta cláusula, a Cláusula M é contornável: a continuação
olharia apenas o posterior, mas o posterior nos pontos não disciplinados
viraria um disfarce da proposta, e o interruptor do certificado renasceria
dentro do sistema de crenças (risco antecipado na Seção 8 da memória de
2026-08-29).

**Natureza da restrição.** Crença constante nos pontos não disciplinados é uma
restrição transparente e parcimoniosa de crenças, adotada para impedir que
sinais de probabilidade zero funcionem como rótulos arbitrários de punição. O
PBE em geral permite crenças distintas entre sinais fora do caminho; a
constância é convenção de modelagem desta extensão, com propósito declarado, e
o texto do paper deve apresentá-la assim.

**Vinculação institucional.** Na comparação principal de `AC`, maioria e
unanimidade usam o mesmo `nu_off` (diagonal `nu_off^M = nu_off^U`). O registro
do par `(nu_off^M, nu_off^U)` fora da diagonal é admissível como anexo de
robustez, com a diagonal destacada. Motivo: diferenças atribuídas à regra
institucional não podem originar-se de convenções distintas de crença fora do
caminho.

### Decisão: disciplina de crenças nos pontos não disciplinados
- **Escolha**: constância com nível livre — um único `nu_off` por assessment,
  tratado como objeto do equilíbrio, com a mesma `nu_off` entre instituições na
  comparação principal de `AC`.
- **Alternativas descartadas**:
  - crença livre ponto a ponto: descartada porque reconstrói o contraexemplo
    através das crenças mesmo sob a Cláusula M.
  - crença passiva estrita (`nu_off = nu` sempre): descartada como cláusula
    única porque eliminaria as famílias separating testemunhadas — as
    construções das Seções 3.2–3.3 dos resultados usam posterior 0 ou 1 nos
    pontos não disciplinados para deter imitação — sem ganho adicional de
    existência. Permanece admissível como caso particular, e resultados que
    dependem de `nu_off` devem destacar a parte invariante.
  - `nu_off` livre por instituição na comparação principal: descartada porque
    confundiria o efeito da regra de votação com o efeito da convenção de
    crença; relegada a anexo de robustez fora da diagonal.
  - D1/Critério Intuitivo como fundação: descartados porque fazem a crença
    depender da proposta por desenho, e o §3.2 do contrato já os exclui do
    baseline; permanecem admissíveis como diagnóstico ex post sobre o conjunto
    classificado.
  - continuidade primitiva de `y -> mu(y)`: descartada porque é difícil de
    enunciar como primitiva num contínuo com nível livre e ainda permite
    liberdade por regiões.

## 5. Desempates preservados

Voto fraco as-if-pivotal, aceitação na indiferença e `T^Y` (§3 itens 1–2 do
contrato e decisão de 2026-08-21) permanecem sem alteração. Nada nesta emenda
toca a regra local de Bayes em pontos disciplinados.

## 6. Reescopo dos entregáveis

1. **Lema de existência (novo primeiro entregável).** As cláusulas removem a
   dependência diagonal dos preços de voto em relação à proposta. Elas não
   tornam o payoff de `H` semicontínuo superior em geral: na fronteira de
   aceitação pode haver salto para baixo quando a continuação vale mais que o
   acordo-limite. A rota de prova esperada é construtiva: o conjunto de
   propostas aceitas, incluída a indiferença, é fechado, logo o melhor acordo é
   atingido; o valor de rejeição é atingido por qualquer proposta claramente
   rejeitada; o ótimo de `H` é o maior dos dois. A existência permanece
   obrigação de prova do candidato, por região paramétrica, com revisão
   independente.
2. **Assinatura de equivalência downstream.** Dois perfis de equilíbrio são
   identificados somente se coincidem na assinatura:
   - payoffs por tipo de `H`;
   - payoffs interinos dos Estados fracos;
   - probabilidade de acordo e de atraso por tipo;
   - distribuição de outcomes/alocações terminais por tipo;
   - posterior nos sinais alcançados.
   A assinatura contém o que `AC` e `AR` consomem. Equivalência restrita a
   payoffs esperados foi descartada: perfis com os mesmos payoffs podem diferir
   em acordo imediato, atraso, revelação de tipo e alocação — coordenadas
   usadas downstream. Provar que alguma coordenada é redundante é permitido
   depois, por teorema.
3. **AMX-014/015/016 reescopados.** Meta: classificar as classes de assinatura
   dos PBEs sob M/S/B, indexadas por `(nu, nu_off)` e pelos objetos on-path
   exigidos por Bayes. A enumeração de perfis de estratégia deixa de ser meta:
   a família atomless da Seção 6.1 realiza infinitos perfis com a mesma
   assinatura. A Cláusula B não disciplina o interior do suporte público da
   proposta: posteriores on-path podem variar continuamente por Bayes — a mesma
   família atomless é o exemplo. Portanto, reduzir toda variação on-path a um
   número finito de classes de assinatura por `(nu, nu_off)` é teorema a
   provar, não consequência automática das cláusulas; enquanto não provado, o
   entregável descreve as classes com os objetos on-path necessários.
4. **Certificado negativo preservado**: vira resultado permanente e motivação
   desta emenda, citável como remark na escrita; os equilíbrios testemunhados e
   os limites globais da Seção 5.4 seguem válidos como construções.

## 7. Consequências assumidas

- Os preços de voto colapsam: `r_lower = r_upper = r(mu)` em todo o espaço de
  propostas, fechando o gap "sem voto puro admissível" da Seção 6.1.
- As testemunhas das Seções 3–4 entram como candidatos no novo snapshot; nada é
  herdado automaticamente. A re-validação inclui verificar a
  payoff-equivalência entre o membro cíclico usado nas construções e o
  representante uniforme da Cláusula S.
- `A_M` rederiva do zero sob o contrato emendado. `AC` e `AR` reabrem, porque
  consumiram a interface de `A_M`. `A_U` deve ser auditada pela mesma
  liberdade (`kappa_U` e crenças): sob unanimidade não há escolha de coalizão,
  mas a Cláusula B se aplica igualmente.
- A Cláusula S é escolha nova da extensão. O `C_M` congelado preserva a
  multiplicidade de coalizões e não impõe seleção simétrica; nada em N3/N6 é
  reinterpretado. A obrigação de compatibilidade é pontual: verificar que o
  representante uniforme (ou o cíclico, se payoff-equivalente) é membro
  literal da correspondência congelada.

## 8. Protocolo

- Rederivação em snapshot novo, com implementador ≠ revisor; Fable permanece
  inelegível como revisor da cadeia (alocação de 2026-08-23); revisão
  matemática independente sobre os bytes novos; verificação mecânica não
  substitui prova.
- A v2 já recebeu uma revisão independente de texto e conceito (Sol 5.6,
  registro citado no histórico). Essa revisão não substitui a revisão
  matemática da derivação futura.
- A aprovação desta emenda precede qualquer derivação. Pedidos de "continuar
  procurando" sob o contrato antigo estão vedados: o obstáculo tem certificado.

## 9. Invalidação

- Alterar qualquer cláusula desta emenda reabre todos os claims AMX
  downstream e as revisões correspondentes.
- Esta emenda não altera nem reinterpreta artefatos congelados do baseline
  essential-input; qualquer conflito aparente escala ao autor.

## Referências

- Baron, D. & Ferejohn, J. (1989). Bargaining in Legislatures. *American
  Political Science Review* 83(4): 1181–1206 — multiplicidade folk sob maioria
  com estratégias história-dependentes e resposta via equilíbrio estacionário.
- Maskin, E. & Tirole, J. (2001). Markov Perfect Equilibrium I: Observable
  Actions. *Journal of Economic Theory* 100(2): 191–219 — estados
  payoff-relevantes como fundamento da restrição markoviana.
- Kalandrakis, T. (2006). Proposal Rights and Political Power. *American
  Journal of Political Science* 50(2): 441–448 — poder das regras de proposta;
  uso padrão de equilíbrios estacionários em barganha legislativa.
- Bhaskar, V., Mailath, G. & Morris, S. (2013). A Foundation for Markov
  Equilibria in Sequential Games with Finite Social Memory. *Review of
  Economic Studies* 80(3): 925–948 — analogia de horizonte infinito (memória
  social finita e purificação); citada como analogia, sem servir de fundação
  direta para a restrição num jogo finito.
- Eraslan, H. & Evdokimov, K. (2019). Legislative and Multilateral Bargaining.
  *Annual Review of Economics* 11: 443–472 — SSPE como conceito padrão da
  literatura.
- Nenhuma dessas referências demonstra a Cláusula B; ela é convenção de
  modelagem desta extensão, com o propósito declarado no §4.
