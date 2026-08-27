# Gate 0 — Extensão de agenda informal

**Data do candidato reparado:** 2026-08-26
**Status:** `REPAIRED CANDIDATE — NOT APPROVED — AWAITING TWO NEW INDEPENDENT REVIEWS`
**Escopo autorizado:** redação deste contrato, criação do DAG próprio e criação
dos quatro ledgers vazios.
**Fora de escopo:** aprovação deste Gate 0; scripts; derivações; cálculos de
equilíbrio; revisão; edição ou compilação de manuscrito; figuras; commit, tag,
branch ou push; edição de qualquer artefato congelado.

Este documento é a especificação executável da extensão na qual `H`, já
informado sobre seu tipo, propõe antes das continuações congeladas do jogo
`essential-input`. O contrato não contém resultados. Intuições qualitativas
disciplinam perguntas, nunca respostas.

## Regra de fonte normativa única

Cada objeto normativo deste contrato tem uma única fonte canônica interna. As
fontes externas abaixo justificam o transporte inicial, mas não criam uma
segunda redação vigente:

| Objeto transportado | Fonte externa |
|---|---|
| planejamento fechado da extensão | `quality_reports/plans/2026-08-23_agenda_extension_gated_plan_v3.md`, SHA-256 `56a933dc25532633d030ecba370a1d132ceb480e75cbf8ea4c4b48104ccb033a` |
| crenças, votação e `T^Y` | `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` |
| formato de Gate 0, desconto, implementação de referência e protocolo de revisão | `quality_reports/plans/2026-08-12_essential_input_gate0.md` |
| family records completos e binder atômico | `model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json`, SHA-256 `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| conjunto conjunto exato antes de envelopes | `model_redesign/essential_input_n6_private_comparison_candidate.json`, SHA-256 `a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92` |
| famílias reais parametrizadas por fórmula | `model_redesign/essential_input_n7_complete_information_benchmark_candidate.json`, SHA-256 `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45` |
| seleção pública e mensurável de continuação completa | `model_redesign/pivotal_response_interfaces/r1_majority_v1.json` e `model_redesign/pivotal_response_interfaces/r1_unanimity_v1.json` |
| manifesto vivo e convenção de lifecycle | `model_redesign/essential_input_game_dag.json` e §§11--12 de `quality_reports/plans/2026-08-12_essential_input_gate0.md` |
| continuação privada de maioria `C_M` | `model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json`, SHA-256 `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| continuação privada de unanimidade `C_U` | `model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json` |
| continuações públicas | `model_redesign/essential_input_n7_complete_information_benchmark_candidate.json` |

O hash-pinning e a auditoria de consumibilidade dessas três visões externas
pertencem ao Goal 1. A mera indicação dos caminhos neste contrato não as
reabre, não as rederiva e não certifica sua consumibilidade.

Dentro deste contrato, as fontes únicas são:

| Conteúdo | Fonte única interna |
|---|---|
| objetivo e estimandos-pergunta | Seções 1 e 8 |
| forma extensiva, informação, transição e contabilidade | Seções 2 e 3 |
| primitivas e decisões autorais | Seção 4 |
| conceito de solução baseline | Seção 5 |
| extensões futuras não autorizadas | Seção 6 |
| invariância, seleção e diagnósticos autorizados | Seção 7 |
| schemas por família e por objeto derivado; atomicidade | Seção 9 |
| topologia | Seção 10 e DAG externo |
| verifier futuro | Seção 11 |
| revisão, gates posteriores, congelamento e invalidação | Seção 12 |

---

## Leitura para aprovação — sem jargão

O estágio novo pergunta o que muda quando o hegemon, além de votar informado
na continuação, formula a primeira proposta. Se essa proposta não passa, o jogo
congelado começa integralmente. O mecanismo não pode ser resolvido escolhendo o
equilíbrio mais conveniente: primeiro se preserva toda a correspondência de
PBE. Quando uma afirmação varia dentro dela, essa variação permanece explícita
na correspondência e nos metadados de seleção.

A forma extensiva transpõe exatamente o papel de proponente já definido no jogo
de continuação. Quando `H` propõe, escolhe uma única parcela final para si e uma
parcela para cada Estado fraco. Sua proposta conta como voto favorável; os
demais votos decidem somente a aprovação coletiva do pacote completo. Não há
ação nula, segunda decisão de voto de `H`, inclusão individual condicionada ao
voto nem acordo aprovado sem `H`.

---

## 1. Objeto, escopo e perguntas

### 1.1 Objeto

Há duas instituições no núcleo:

- `M`: maioria simples;
- `U`: unanimidade.

Em cada instituição, o estágio de agenda `A` antecede a continuação congelada
`C`. `H` conhece seu tipo antes de propor. A organização já existe; formação,
entrada e escolha endógena de regra ficam fora deste jogo. Quóruns
intermediários pertencem apenas ao Goal `Q`, que requer autorização própria.

### 1.2 Perguntas substantivas

O contrato abre, sem antecipar resposta:

1. como a correspondência completa de equilíbrios do estágio de agenda varia
   entre maioria e unanimidade;
2. como os payoffs privados por tipo de `H` mudam quando `H` pode propor;
3. como a imagem ex ante desses payoffs depende do prior comum;
4. quais são os benchmarks quando o tipo é público antes da proposta;
5. quais rendas informacionais existem por regra e por tipo;
6. se há interação entre informação privada e agenda informal, em domínio no
   qual todos os objetos necessários existam;
7. quais afirmações são invariantes em toda a correspondência baseline e quais
   variam entre famílias ou dependem de seleção já autorizada.

Todos esses itens têm status inicial `pending` como resultados. Esse status não
é uma decisão de protocolo em aberto e não autoriza fórmula candidata,
desigualdade esperada ou ranking antecipado.

---

## 2. Forma extensiva e informação

### 2.1 As duas representações obrigatórias

Cronologia dos acontecimentos:

```text
A_M -> C_M
A_U -> C_U
```

Ordem inversa de consumo para solução:

```text
A_M depends_on C_M
A_U depends_on C_U
AC  depends_on A_M, A_U
AR  depends_on AC e nas continuações públicas congeladas
```

`A -> C` descreve tempo. `A depends_on C` descreve a ordem da indução
retroativa. As duas representações não são intercambiáveis e devem aparecer
juntas em todo handoff.

### 2.2 Cronologia do estágio `A`

Para cada regra `g in {M,U}`:

1. antes da proposta, Natureza determina `theta in {0,1}` segundo o prior
   público `nu`; somente `H` observa `theta`;
2. `H` formula uma proposta factível em `Y`; não existe ação nula de espera;
3. a proposta torna-se pública;
4. a proposta conta como o voto favorável de `H`; todos os Estados fracos
   votam simultaneamente e em ballot selado;
5. depois de todos os votos, o vetor completo e o resultado tornam-se públicos;
6. se a quota for satisfeita, a proposta é implementada segundo a função de
   implementação da Seção 4 e o jogo termina na data de `A`;
7. se a quota não for satisfeita, não há pagamento em `A`; a história pública
   completa e o posterior admissível acionam o plano de continuação do
   assessment; esse plano associa a história a exatamente um registro
   existente e congelado de `C_g`, com ID e hash, cuja data nativa é
   preservada.

As quotas contam o voto favorável automático de `H` e são

```text
q_M=floor(N/2)+1
q_U=N.
```

Logo, sob `M`, além de `H`, são necessários `q_M-1` votos fracos favoráveis;
sob `U`, são necessários todos os `N-1` votos fracos favoráveis.

`H` deve propor. Atraso só pode ser resultado da rejeição de uma proposta
admissível. A existência de proposta sacrificial, de pooling, de separating,
de semi-pooling ou de atraso é obrigação de prova, não ação primitiva.

### 2.3 Transição total

A função de transição tem domínio em toda dupla:

```text
(proposta factível, vetor completo de votos admissíveis)
```

e codomínio exatamente em:

```text
acordo implementado em A | entrada em continuação C_g
```

Não existe terceiro destino, payoff-sentinela ou continuação fictícia. `H`
conta como um voto favorável e não vota novamente. Cada Estado fraco escolhe
`sim` ou `não`; seu voto afeta somente a satisfação da quota. Se a quota é
satisfeita, o pacote completo é executado para todos os participantes. Caso
contrário, entra-se em `C_g`. Toda dupla do domínio recebe um único destino, e
uma proposta de `H` não pode passar sem `H`.

### 2.4 História pública e posterior na continuação

A história pública levada a `C_g` contém, no mínimo:

- instituição;
- proposta completa;
- identidade do proponente;
- vetor completo de votos;
- resultado do ballot;
- posterior público sobre `theta` após aplicar o pacote da Seção 5.

Separadamente de qualquer assessment, a coleção produzida por `A_g` carrega
uma `source_continuation_complete_view`: visão completa, consumível e presa por
hashes de toda a correspondência relevante de `C_g`. Essa visão contém todas
as células, family records, schemas de membros, binders, domínios, status de
existência, payoffs, outcomes, datas e certificados exportados pela interface
congelada que possam ser necessários a `A_g` ou a consumidores posteriores.
Ela não se reduz aos membros escolhidos em equilíbrio por `continuation_plan`.

Cada assessment completo de `A_g` inclui uma função mensurável de continuação

```text
kappa_g: H_g^R -> R_g^C,
```

em que `H_g^R` é o conjunto de histórias públicas rejeitadas e `R_g^C` é o
conjunto dos elementos literais completos da correspondência congelada de
`C_g`. `kappa_g` é componente público, type-blind e Borel-mensurável do
assessment. Para toda história no domínio, devolve exatamente um elemento
completo; se a fonte usa family record, a seleção inclui
`family_record_id`, `complete_member_binding_or_selector` e o hash externo da
fonte. Um ID ou payoff escalar não substitui o elemento.

O membro selecionado retém integralmente suas estratégias internas, crenças,
payoffs de todos os tipos e identidades, outcomes, datas e proveniência. Todas
as coordenadas usam o mesmo member binding; coordinate splicing é proibido.
Histórias públicas distintas podem selecionar membros distintos, mesmo com o
mesmo posterior. Para uma mesma história, uma única seleção type-blind rege
todos os tipos compatíveis.

Não se exige ID material para cada membro de um contínuo: a função simbólica
`kappa_g` e seus bindings são o objeto auditável. O conjunto-alvo de family
records usa sigma-álgebra discreta, enquanto os member selectors e kernels
induzidos são Borel-mensuráveis. A representação auditável preferida é uma
tabela finita com, para cada linha:

```text
region_id
borel_region_predicate_or_definition
target_family_record_id
complete_member_binding_or_selector
target_external_artifact_hash
coverage_certificate
exclusivity_certificate
measurability_certificate
proof_or_evidence_path
```

As regiões formam partição Borel exaustiva e exclusiva de `H_g^R`. Se não
existir representação simbólica finita, o artefato de derivação deve registrar
a definição matemática formal de `kappa_g`, o domínio, o contradomínio de
family records, o member selector e o caminho da prova de totalidade, unicidade
e mensurabilidade. Nesse caso, o verifier exige e valida o certificado; não
tenta enumerar o contínuo.

Somente se o Goal 1 provar uma compressão suficiente e mensurável da história,
o domínio poderá ser representado por esse estado suficiente; até lá, vale a
história pública completa.

O Goal 1 deve demonstrar quais registros são consumíveis e se a interface pode
ser indexada apenas por instituição e posterior ou exige referência adicional
à história. O estágio `A` não pode completar localmente campo que a interface
congelada não exporte. Se mais de uma associação `kappa_g` for admissível, cada
plano completo define um assessment distinto e todos permanecem na
correspondência. Não há seleção global, média, sentinela nem fabricação de
continuação. Assessment que exija registro inexistente é inadmissível.

---

## 3. Regra contábil e datas

Toda restrição de incentivo deve ser projeção da mesma árvore:

```text
tipo realizado
-> estado público
-> proposta
-> vetor de votos
-> posterior admissível
-> registro existente da continuação, se houver
-> outcome realizado
-> vetor de payoffs condicionados ao tipo
-> expectativa calculada por último
```

Regras invioláveis:

1. `A` é a nova data zero;
2. valores de `C_M`, `C_U` e das continuações públicas mantêm suas unidades
   nativas;
3. `beta in (0,1)` entra exatamente uma vez quando um payoff nativo de `C` é
   transportado para uma comparação em `A`;
4. nenhum `beta` é aplicado a acordo implementado na própria data de `A`;
5. nenhum payoff condicionado ao tipo pode ser substituído por média ex ante;
6. a expectativa sobre `theta`, estratégias mistas e qualquer loteria é
   calculada somente depois de definidos os payoffs realizados;
7. nenhum jogador recebe em data diferente dos demais dentro da mesma história
   terminal;
8. uma continuação `none` nunca recebe número, zero convencional, infinito ou
   qualquer outra sentinela.

Todo valor-fonte usado em comparação, renda ou interação é transportado por um
registro temporal explícito:

```text
source_record_id
source_scope
external_source_artifact_hash
native_value
native_date
transport_factor_to_A
beta_application_count
transported_value_at_A
```

`source_scope` é `external_frozen` ou `internal_same_artifact`.
`external_source_artifact_hash` é obrigatório somente no primeiro caso e é
`null` no segundo; fonte interna é coberta pelo hash contêiner calculado após a
serialização, nunca por hash autorreferente. O fator é 1 para payoff já
realizado em `A` e incorpora exatamente um `beta` quando a fonte nativa pertence
a `C`. Uma operação de diferença só pode usar `transported_value_at_A`; é
proibido subtrair valores em datas distintas ou aplicar desconto sem registrar
todos esses campos.

---

## 4. Primitivas e decisões autorais de protocolo

Os itens aparecem na ordem obrigatória do plano de trabalho. `APPROVED` indica
que a regra já está fixada por uma fonte autorizada. Não resta decisão
protocolar pendente neste candidato; os resultados continuam `pending` e
qualquer nova ambiguidade substantiva bloqueia o ramo afetado.

### P-01 — Jogadores, tipos, prior e domínio

**Status:** `APPROVED`.

- jogadores: um hegemon `H` e `m=N-1` Estados fracos, com `N>=3`;
- tipo privado: `theta in {0,1}`;
- prior público: `nu=Pr(theta=1)` em `[0,1]`;
- `H` observa `theta` antes de propor; Estados fracos nunca o observam;
- nos endpoints, o suporte inicial é preservado conforme a Seção 5.

**Fonte:** contrato `essential-input`, Seções 2 e 4; decisão de conceito de
solução, Decisão 1a; fonte de planejamento, §§0 e 2.5.

### P-02 — Data de `A` e desconto

**Status:** `APPROVED`.

`A` é a nova data zero e `beta in (0,1)`. O transporte de `C` para `A` segue
exclusivamente a Seção 3.

**Fonte:** fonte de planejamento, §§0 e 2.5; contrato `essential-input`,
Seções 2 e 6.

### P-03 — Pie, benefício direto e opção externa

**Status:** `APPROVED`.

- pie institucional fixa, normalizada em 1;
- `b_theta=0`;
- `o_theta` é externo à pie;
- domínio transportado: `0<o_0<o_1<1`;
- a opção externa não é side payment pago pelos Estados fracos.

**Fonte:** contrato `essential-input`, Seções 2--4; fonte de planejamento,
§2.5.

### P-04 — Coordenadas, factibilidade, residual e payoffs

**Status:** `APPROVED` em 2026-08-25.

Quando `H` é o proponente, escolhe o pacote

```text
s_H = (z_H, (x_j)_{j in W}),
```

com uma única coordenada final `z_H` para si e uma coordenada `x_j` para cada
Estado fraco. A factibilidade é

```text
z_H >= 0, x_j >= 0 e z_H + sum_j x_j <= 1.
```

Se uma decomposição intermediária separar concessão a `H` e parcela do
proponente, seus termos são somados em `z_H`; eles nunca aparecem como duas
parcelas econômicas ou duas coordenadas finais de `H`. Em acordo aprovado na
data de `A`, `H` recebe `z_H` e cada Estado fraco `j` recebe `x_j`.

A desigualdade factível, o uso do bolo e o estatuto de eventual folga são
exatamente os do pacote vigente do proponente fraco. Uma folga não é
realocada ex post e não recebe regra nova de destruição, redistribuição ou
apropriação; se puder integrar proposta ótima, isso será resultado a preservar,
não primitiva adicional.

O espaço `Y` é o conjunto desses pacotes factíveis, em suas coordenadas
econômicas primitivas. É compacto e Boreliano, com a topologia relativa herdada
de seu fecho afim e as vizinhanças relativas definidas na Seção 5.1.

**Fonte:** decisão autoral de 2026-08-25; transposição por identidade do pacote,
factibilidade e implementação do contrato `essential-input`, Seções 2 e 4.

### P-05 — Obrigação de propor

**Status:** `APPROVED`.

`H` deve escolher uma proposta em `Y`. Não há ação nula, botão de espera ou
transição direta voluntária a `C`. Rejeição endógena é o único caminho de
atraso.

**Fonte:** fonte de planejamento, §0, item 1, e §2.5.

### P-06 — Voto do proponente

**Status:** `APPROVED` em 2026-08-25.

Como todo proponente no modelo vigente, `H` conta automaticamente como `sim` e
não lança voto separado. A proposta é sua única ação no estágio. Não existe
segunda decisão de votar contra a própria proposta.

**Fonte:** decisão autoral de 2026-08-25; transposição da regra do proponente no
contrato `essential-input`, Seções 4 e 5.

### P-07 — Implementação para os Estados fracos e efeito do voto individual

**Status:** `APPROVED` em 2026-08-25.

Cada Estado fraco vota somente sobre a aprovação coletiva do pacote completo.
Se a quota é satisfeita, a alocação é executada integralmente e cada Estado
fraco recebe `x_j`, independentemente de seu voto individual. O voto não cria
inclusão individual, pagamento contingente ao voto ou coalizão parcial.

**Fonte:** decisão autoral de 2026-08-25; transposição da implementação coletiva
do contrato `essential-input`, Seção 4.

### P-08 — Simultaneidade, informação e publicação

**Status:** `APPROVED`.

- todos os votos exigidos no ballot são simultâneos e selados;
- ninguém observa votos alheios antes de votar;
- a proposta e a história pública anterior são observadas antes do ballot;
- o vetor completo de votos e o resultado são publicados somente após o
  fechamento;
- não existe ordem roll-call.

**Fonte:** contrato `essential-input`, Seção 4; fonte de planejamento, §§2.2 e
2.5.

### P-09 — Transição completa

**Status:** `APPROVED` em 2026-08-25.

Para qualquer `s_H in Y` e qualquer vetor de votos fracos, soma-se o voto
favorável automático de `H`. As quotas são matematicamente
`q_M=floor(N/2)+1` e `q_U=N`. Se o total satisfaz a quota da regra, `s_H` é
executado integralmente e o jogo termina na data de `A`. Se não satisfaz, não
há pagamento em `A` e a história pública entra em `C_g` pelo plano mensurável
de continuação do assessment. Não existe acordo de `H` que passe sem `H`.

### P-10 — História pública e posterior consumidos por `C`

**Status:** `APPROVED`, sujeito à auditoria de consumibilidade do Goal 1.

A história e o posterior são os definidos na Seção 2.4. Propostas on-path de
`H` atualizam pela regra local de Bayes da Seção 5.1. Ações fracas seguem
no-signaling. Uma avaliação só pode entrar em registro existente de `C_M` ou
`C_U`.

**Fonte:** fonte de planejamento, §§2.2, 2.5 e 3; decisão de conceito de
solução.

### P-11 — Pureza no ballot e mistura nas propostas

**Status:** `APPROVED`.

Estratégias são puras em todo ballot. Estratégias de proposta de `H` podem ser
mistas. Pooling, separating e semi-pooling não podem ser excluídos por
construção.

**Fonte:** fonte de planejamento, §0, item 3, e §2.2, item 7.

### P-12 — Side payments e formação

**Status:** `APPROVED`.

Não há side payments externos ao pacote. Formação, entrada e escolha endógena
da regra permanecem fora do jogo.

**Fonte:** fonte de planejamento, §§1 e 2.5; contrato `essential-input`,
Seções 1 e 2.

### P-13 — Propostas ótimas múltiplas

**Status:** `APPROVED`.

O baseline preserva a correspondência completa. Todas as propostas ótimas e
todos os equilíbrios admissíveis permanecem registrados. Não há tie-break de
proposta adicional nem seleção silenciosa.

**Fonte:** fonte de planejamento, §0, item 4, e §§2.4 e 2.5.

### P-14 — Estimandos

**Status de protocolo:** `APPROVED como perguntas`.
**Status de resultado:** `pending`.

As perguntas, seus domínios e as regras para objetos vazios estão na Seção 8.
Nenhum valor ou ranking integra este Gate 0.

### P-15 — Regras institucionais

**Status:** `APPROVED`.

O núcleo contém maioria simples e unanimidade. Quóruns intermediários só podem
ser abertos no Goal `Q`, com autorização própria e rederivação da família.

**Fonte:** fonte de planejamento, §§2.5, 5 e 7.

### 4.1 Decisão autoral consolidada de 2026-08-25

O estágio `A` transpõe por identidade o papel do proponente fraco para `H`, sem
criar formato de proposta, regra distributiva ou ação adicional:

1. `H` escolhe uma parcela final para si e uma parcela identificada para cada
   Estado fraco, uma coordenada por participante;
2. a soma obedece à mesma factibilidade fraca e ao mesmo tratamento de eventual
   folga do pacote vigente;
3. `H` é obrigado a propor, sem ação nula, renúncia ou passagem de vez;
4. a proposta conta como o voto favorável de `H`, que não vota novamente;
5. os Estados fracos votam apenas sobre a aprovação coletiva do pacote
   completo;
6. o pacote aprovado é implementado integralmente, sem pagamentos condicionais
   ao voto individual;
7. uma proposta de `H` não passa sem `H`.

As alternativas de dupla coordenada para `H`, divisão fraca mecânica,
redistribuição nova, destruição nova, voto posterior de `H`, inclusão individual
e acordo sem o proponente ficam descartadas.

### 4.2 Decisões autorais consolidadas de 2026-08-26

Estão `APPROVED`, com conteúdo executável nas Seções 5--9:

1. Bayes para propostas mistas contínuas é definido por razões locais de
   probabilidades em vizinhanças relativas de `Y`, sem escolher versões
   pontuais arbitrárias de densidades;
2. cada assessment inclui uma função mensurável da história rejeitada, ou de
   estado suficiente provado, para exatamente um elemento literal completo da
   continuação congelada, identificado por family record e complete member
   binding/selector quando necessário;
3. `AC` e `AR` preservam o produto de todas as tuplas completas compatíveis;
   objetos derivados só são escalares quando invariantes em todas as tuplas
   relevantes;
4. D1 e Critério Intuitivo são claims explicitamente rotuladas no ledger do nó
   examinado, com evidência própria; não criam ledgers globais novos.
5. a razão local vale para medidas Borelianas arbitrárias, inclusive suportes
   em faces, curvas e superfícies de dimensão menor; singularidade relativa à
   Lebesgue de dimensão cheia não é causa de parada, mas inexistência do limite
   local necessário faz o ramo parar e escalar;
6. `A_M` e `A_U` transportam visões completas e hash-pinned de suas
   continuações, `AC` preserva payloads independentes por regra e `AR` produz
   family records públicos próprios sem hash-fonte autorreferente;
7. toda comparação temporal registra valor e data nativos, fator de transporte,
   contagem de `beta` e valor na data de `A`.

### 4.3 Decisão arquitetural autoral de 2026-08-26

**Status:** `APPROVED`.

O Goal 0 repete a arquitetura dos equilíbrios congelados atuais:

1. correspondências infinitas usam registros simbólicos de família, um binder
   atômico comum e regras necessárias e suficientes de membership;
2. estratégias, crenças, votos, escolhas de continuação, payoffs e outcomes de
   um membro usam o mesmo binder, sem recombinação entre membros;
3. `kappa_g` seleciona por história pública um elemento literal completo da
   continuação, incluindo family record e complete member binding quando
   necessário;
4. conjuntos conjuntos exatos precedem envelopes e imagens marginais;
5. o DAG é manifesto vivo: transições de lifecycle previstas pelo schema não
   reabrem o Gate 0, mas mudança do jogo, schema, topologia, conceito, obrigação
   de prova ou protocolo de revisão reabre.

---

## 5. Conceito de solução baseline transportado

O baseline é a correspondência completa de Perfect Bayesian equilibria sob os
itens seguintes:

1. **Votação as-if-pivotal dos Estados fracos.** Cada votante fraco compara
   `sim` e `não` pelo valor esperado condicional ao evento de seu voto ser
   decisivo. Comparação estrita determina o voto.
2. **`T^Y`.** Na indiferença genuína em valor esperado na comparação pivotal,
   o voto é `sim`. A expectativa integra `theta` e loterias futuras relevantes.
3. **No signaling what you do not know.** Ação de jogador fraco, que não
   observa `theta`, não altera por si a crença pública sobre o tipo de `H`.
4. **Consistência estrutural.** Em subárvore alcançada por desvio fraco, ação
   de `H` prescrita pelo perfil atualiza pela regra local de Bayes desta seção
   sempre que as medidas do perfil disciplinam a história.
5. **Liberdade somente em história genuinamente não disciplinada.** A
   distribuição pública disciplina um ponto quando atribui massa a
   vizinhanças relativas arbitrariamente pequenas. Nesse ponto, o limite local
   canônico definido abaixo deve existir; se não existir, o ramo para e escala.
   Somente no complemento não disciplinado a crença é livre dentro do suporte
   do prior. Isso não transforma todo singleton de probabilidade zero em
   desvio: ponto gerado por mistura contínua é disciplinado pela razão local.
6. **Preservação de suporte.** Em `nu=0`, todo posterior é 0; em `nu=1`, todo
   posterior é 1; no interior, ambos os tipos pertencem ao suporte inicial.
7. **Estratégias.** Votos são puros; propostas de `H` podem ser mistas.
8. **Plano de continuação.** O assessment contém a função mensurável `kappa_g`
   da Seção 2.4; cada história rejeitada recebe exatamente um elemento literal
   completo de `C_g`, por family record e complete member binding quando
   necessário. A função é pública, type-blind e Borel-mensurável.

### 5.1 Regra local de Bayes para propostas mistas

Sejam `sigma_0` e `sigma_1` as medidas Borelianas de proposta dos dois tipos e

```text
m=(1-nu)sigma_0+nu sigma_1.
```

Escreva `aff(Y)` para o fecho afim de `Y` e, para `y in Y`, defina a
vizinhança euclidiana relativa

```text
B_delta^Y(y)=Y interseção {z in aff(Y): ||z-y||<delta}.
```

Para `0<nu<1`, a regra canônica é, sempre que o limite existir,

```text
mu(y)=lim_{delta desce a 0}
  nu sigma_1(B_delta^Y(y))
  /[(1-nu)sigma_0(B_delta^Y(y))+nu sigma_1(B_delta^Y(y))].
```

Em átomos, essa expressão reproduz a razão de massas. Em regiões contínuas
regulares, reproduz a razão de densidades. A mesma razão de probabilidades vale
sem alteração quando uma medida Boreliana arbitrária concentra massa em face,
curva, fractal ou outra superfície de dimensão menor. Singularidade em relação
à Lebesgue de dimensão cheia não autoriza parada nem escolha alternativa de
crença. A regra não depende de uma versão Boreliana de densidade escolhida
ponto a ponto. Bayes vale `m`-quase em toda parte. Formalmente, `m` disciplina
`y` se

```text
m(B_delta^Y(y))>0 para todo delta>0.
```

Em todo ponto disciplinado, a razão local canônica deve existir. Se o limite
necessário não existir, o ramo para e escala em vez de receber crença inventada.
O complemento genuinamente não disciplinado é formado pelos pontos para os
quais existe alguma vizinhança relativa com massa pública zero; somente nesse
complemento a crença é livre dentro do suporte do prior. Em `nu=0` a crença é
identicamente 0 e em `nu=1` é identicamente 1.

As medidas `sigma_theta` são probabilidades Borelianas em `Y`. O sistema de
crenças do assessment é uma função Borel-mensurável que coincide com a razão
local canônica em todo ponto disciplinado e usa uma seleção mensurável dentro
do suporte do prior apenas no complemento livre. Não se usa a mensurabilidade
para alterar a razão canônica em ponto disciplinado.

A liberdade no complemento **não é** crença passiva, D1 nem Critério Intuitivo.
No-signaling, consistência estrutural, liberdade baseline, D1 e Critério
Intuitivo são objetos nominal e matematicamente distintos.

Uma continuação `none` nunca recebe payoff fictício. Em história genuinamente
não disciplinada, uma crença livre sustenta um assessment somente se `kappa_g`
associar a história a registro admissível e existente. Se várias funções
`kappa_g` forem admissíveis, cada função integra um assessment completo distinto
e nenhum é descartado por seleção global.

---

## 6. Extensões futuras não autorizadas

Refinamentos por tremble podem ser estudados futuramente somente mediante novo
Gate e GO autoral. Eles não integram o baseline, não condicionam Goal 0, Goal 1,
`A_M`, `A_U`, `AC` ou `AR`, e não criam campo, claim, estimando, gate ou
obrigação de verifier nesta cadeia.

A regra local de Bayes da Seção 5.1 permanece parte indispensável do PBE
baseline para propostas contínuas e medidas Borelianas arbitrárias. Se uma
letra como `lambda` aparecer futuramente como parâmetro econômico de um segmento
de equilíbrio, ela liga atomicamente os membros dessa família e não representa
medida de perturbação.

---

## 7. Invariância, seleção e diagnósticos autorizados

Para cada claim substantivo alvo:

1. derivar a correspondência completa de PBE baseline em registros simbólicos
   de família;
2. verificar se o claim vale para todos os membros relevantes usando o mesmo
   binder atômico em todas as coordenadas;
3. se valer, registrar invariância sobre a família sem acionar seleção
   adicional;
4. se não valer, preservar o conjunto conjunto exato e registrar quais payoffs,
   outcomes ou rankings variam;
5. testar D1 e Critério Intuitivo somente onde estejam bem definidos; cada
   diagnóstico é uma claim explicitamente rotulada no ledger canônico do nó
   examinado, com registro, fontes, checks e evidência próprios.

D1 e Critério Intuitivo são diagnósticos, nunca baseline. “Ledger próprio”
significa o ledger já existente do nó examinado, não arquivo global ou ledger
novo. Nenhum diagnóstico autorizado reescreve retroativamente o baseline.

---

## 8. Estimandos formulados como perguntas

Todos os objetos abaixo têm status inicial `pending`. Eles são perguntas, não
fórmulas candidatas.

### E-01 — Payoffs privados por tipo

Para cada regra, célula de parâmetros e equilíbrio baseline admissível, qual é
o vetor de payoffs de `H`, condicionado separadamente a `theta=0` e `theta=1`?

**Domínio:** cada regra separadamente e somente avaliações cujas continuações
existam.

### E-02 — Imagem ex ante

Qual é a imagem ex ante de cada vetor privado quando o mesmo prior `nu` é
aplicado às coordenadas por tipo?

**Output obrigatório:** `ex_ante_image_collection` da Seção 9.3, produzida em
`A_M` e `A_U` e transportada por `AC` e `AR` quando consumida.

**Domínio:** cada family record de E-01 sob o mesmo member binding. Prior,
pesos de tipo, valores por tipo, valor ex ante, datas e transportes permanecem
ligados pelo binder. Nunca se combinam envelopes marginais nem se enumeram
membros contínuos.

### E-03 — Benchmarks públicos

Quais são as correspondências de payoff quando o tipo de `H` é público antes
da proposta, mantendo as demais primitivas e o protocolo idênticos?

**Domínio:** cada regra e cada tipo, resolvidos no nó `AR` depois de `AC`
congelado.

### E-04 — Rendas informacionais

Para cada regra e tipo, qual é a diferença entre cada payoff privado admissível
e cada payoff público admissível proveniente da mesma regra? A resposta é uma
coleção indexada por todas as tuplas completas compatíveis, não um escalar
escolhido.

**Domínio:** somente tuplas completas de fontes existentes. Se a fonte privada
ou pública de uma regra for vazia, a renda dessa regra é vazia; isso não apaga a
outra regra.

### E-05 — Contraste entre regras

Como as rendas e os payoffs privados diferem entre maioria e unanimidade no
mesmo ponto de parâmetros? A resposta preserva o produto simbólico de todos os
family records e complete member binders compatíveis das duas regras no
refinamento comum.

**Domínio:** somente células do refinamento comum em que os objetos das duas
regras existam. Uma célula vazia não recebe ranking.

### E-06 — Interação entre informação e agenda

Quanto a introdução do estágio de agenda altera, por regra e por tipo, a
diferença entre o jogo privado e o benchmark público, relativamente aos
objetos sem agenda exportados pelas continuações congeladas?

**Domínio e definição operacional:** para cada regra e tipo, uma tupla completa
compatível contém quatro objetos: payoff privado com agenda, payoff público com
agenda, payoff privado sem agenda e payoff público sem agenda. A renda com
agenda é a diferença, dentro da mesma tupla, entre os dois primeiros objetos; a
renda sem agenda é a diferença entre os dois últimos; a interação é a diferença
entre essas duas rendas. Contrastes entre regras usam somente tuplas completas
de `M` e `U` no mesmo ponto de parâmetros.

Todos esses objetos são coleções derivadas indexadas pelos IDs de todas as
fontes e pelos hashes de todos os insumos externos já congelados. Registros que
nascem no mesmo artefato de `AR` são citados por record ID; o hash contêiner de
`AR` é fixado somente depois da serialização e não é embutido no próprio
conteúdo. Só se pode expor projeção escalar quando o valor for invariante em
todas as tuplas relevantes, mediante certificado que enumere a coleção
verificada. A coleção-fonte nunca é substituída pelo escalar. É proibido parear
envelopes marginais, combinar extremos de registros diferentes ou introduzir
seleção. Antes de qualquer subtração, cada componente é convertido para a data
de `A` pelo registro temporal da Seção 3; valores em datas distintas não podem
integrar a mesma renda ou interação.

`A_M` e `A_U` devem carregar visões completas e hash-pinned de `C_M` e `C_U`,
respectivamente. `AC` transporta essas visões em payloads independentes por
regra. `AR` combina o payload pertinente com os benchmarks públicos sem agenda
de `N7_public` e com os jogos públicos com agenda resolvidos no próprio nó. Se
uma regra estiver vazia, sua ausência não apaga a coleção sobrevivente da outra;
apenas o objeto que exija ambos os lados fica vazio. Se qualquer interface não
exportar dimensão necessária, a coleção dependente fica vazia com certificado
de cobertura e o ramo para; nenhuma dependência oculta, novo nó ou valor
fabricado é permitido.

## 9. Schemas executáveis e atomicidade

### 9.1 Coleções e células de `A_M` e `A_U`

Cada artefato de `A_M` e `A_U` contém uma coleção com o schema:

```text
collection_id
node_id
institution
collection_domain
collection_status
equilibrium_family_record_ids
source_continuation_complete_view_id
cells
exhaustive_coverage_certificate
exclusive_partition_certificate
none_certificate
none_evidence_path
proof_paths
checks_performed
```

Cada elemento de `cells` contém:

```text
cell_id
cell_predicate
cell_domain
status
equilibrium_family_record_ids
exhaustive_coverage_certificate
exclusive_partition_certificate
none_certificate
none_evidence_path
source_record_ids
source_artifact_hashes
```

`status` é exatamente `exists` ou `none`. Se `exists`,
`equilibrium_family_record_ids` enumera somente os registros simbólicos finitos
que cobrem todos os assessments admissíveis da célula; não enumera membros de
família. Se `none`, a lista é vazia e `none_certificate` e
`none_evidence_path` são obrigatórios. Os certificados demonstram que as
células cobrem exaustivamente o domínio e formam partição exclusiva.

No nível agregado, `collection_status=exists` se ao menos uma célula tiver
assessment e `collection_status=none` somente se todas as células forem
`none`. `equilibrium_family_record_ids` agrega sem perda os family records das
células. Uma coleção `exists` não apaga suas células `none`.

A visão completa de continuação usa um único schema em `A_M`, `A_U`, `AC` e
`AR`:

```text
complete_view_id
source_node_id
source_artifact_path
source_artifact_hash
view_domain
source_cells
family_record_ids
family_record_schemas_and_atomic_binders
payoff_coordinates
outcome_coordinates
payoff_dates
coverage_certificate
nonexistence_certificates
status
checks_performed
```

O mesmo `complete_view_id` e o mesmo conteúdo hash-pinned atravessam todos os
consumidores. A visão completa não se reduz ao que um membro seleciona em
equilíbrio.

### 9.2 Registro simbólico de família em `A_M` e `A_U`

Cada family record contém:

```text
family_record_id
collection_id
cell_id
institution
admissibility_conditions
member_parameter_space
member_generator
necessary_and_sufficient_membership_rule
atomic_family_binder
complete_proposal_strategy_formula_by_type
complete_weak_voting_strategy_formula
complete_belief_system_formula
belief_local_ratio_status
source_continuation_complete_view_id
complete_continuation_selection_formula
complete_payoff_formula_by_type_and_identity
complete_outcome_distribution_formula
existence_multiplicity_status
selection_status
refinement_status
assumptions_used
checks_performed
proof_paths
coverage_certificate
exclusivity_certificate
payoff_date
```

`family_record_id` é estável. `member_parameter_space` pode conter medidas de
proposta, funções Borel-mensuráveis, selectors e intervalos reais.
`member_generator` e `necessary_and_sufficient_membership_rule` definem
matematicamente todos e somente os membros. Uma família singleton é degenerada;
uma família contínua permanece em um registro simbólico, sem linhas infinitas e
sem `equilibrium_id` material para cada membro.

`atomic_family_binder` liga um mesmo `F` — ou outro nome interno declarado — a
estratégias, crenças, votos, `kappa_g`, member selectors, payoffs e outcomes.
Todo valor de membro é obtido substituindo o mesmo binding nas fórmulas
completas. É proibido combinar coordenada proveniente de outro binding.

`complete_proposal_strategy_formula_by_type` e
`complete_weak_voting_strategy_formula` especificam ações após toda proposta e
história factível, inclusive fora do caminho. `complete_belief_system_formula`
aplica Bayes local da Seção 5.1. `complete_continuation_selection_formula`
implementa a `kappa_g` pública e type-blind da Seção 2.4. Os kernels de votos,
seleção de membro, payoffs e outcomes necessários às expectativas são
Borel-mensuráveis.

### 9.3 Coleção de imagem ex ante E-02

Cada `A_M` e `A_U` produz, junto da correspondência privada, uma
`ex_ante_image_collection` com:

```text
ex_ante_image_collection_id
node_id
institution
collection_id
cell_id
source_family_record_id
source_atomic_family_binder
member_parameter_space
prior
type_weights
type_conditional_values_at_A
ex_ante_value_formula
exact_joint_ex_ante_image_set
source_value_transport_records
existence_coverage_status
existence_coverage_certificate
selection_status
refinement_status
checks_performed
proof_paths
payoff_date
```

O mesmo member binding que determina os valores por tipo determina o valor ex
ante. `prior` e `type_weights` ficam explícitos, e todos os componentes já estão
na data de `A`. A imagem é gerada simbolicamente sobre todo o
`member_parameter_space`; não enumera membros, não combina envelopes marginais
e preserva metadados de existência, cobertura, seleção e refinamento.

### 9.4 Payloads independentes e comparações privadas em `AC`

O artefato de `AC` contém um envelope estrutural, sem fundir as regras:

```text
ac_collection_id
node_id
common_partition_id
majority_payload
unanimity_payload
cross_rule_comparison_collection
coverage_certificates
checks_performed
proof_paths
```

Cada `majority_payload` ou `unanimity_payload` contém:

```text
rule_payload_id
institution
source_A_collection_id
source_A_artifact_hash
source_A_cell_ids
source_A_family_record_ids
source_A_atomic_family_binders
source_continuation_complete_view_id
transported_complete_view_id_and_source_hash
private_with_agenda_exact_joint_family
private_without_agenda_exact_joint_family
ex_ante_image_collection_ids
source_value_transport_records
status
existence_coverage_certificate
selection_status
refinement_status
checks_performed
evidence_path
payoff_date
```

Os dois payloads existem independentemente. Se uma regra tiver `status=none`
em uma célula, o payload e o certificado dessa regra permanecem registrados e
a coleção sobrevivente da outra regra permanece íntegra. A ausência de um lado
torna vazia apenas a comparação cruzada que exija ambos.

Cada membro de `cross_rule_comparison_collection` contém:

```text
comparison_record_id
common_cell_id
common_domain
source_majority_tuple_ids_and_hashes
source_unanimity_tuple_ids_and_hashes
complete_member_parameter_space
complete_member_binder
necessary_and_sufficient_tuple_membership_rule
source_value_transport_records
exact_joint_value_and_outcome_set_at_A
derived_envelopes
existence_coverage_status
selection_status
refinement_status
assumptions_used
checks_performed
evidence_path
payoff_date
```

`comparison_record_id` é único e estável. O registro representa simbolicamente
o produto dos family records e complete member binders compatíveis; não cria
uma linha por membro. Primeiro conserva
`exact_joint_value_and_outcome_set_at_A`; somente depois calcula
`derived_envelopes`, que são projeções e nunca produtos cartesianos de
intervalos marginais.

`AC` não consulta `C_M` ou `C_U` por
aresta nova: recebe de `A_M` e `A_U` as duas
visões identificadas pelo mesmo `source_continuation_complete_view_id`,
preserva cada uma integralmente e
transporta seus IDs, hashes, coordenadas, valores nativos, datas e valores na
data de `A` para `AR`. Comparação cruzada só existe no refinamento comum e para
tupla na qual todos os lados requeridos existam.

### 9.5 Famílias de equilíbrios públicos com agenda produzidas em `AR`

Para cada regra, tipo público pertinente e célula, `AR` preserva uma coleção
própria com o schema de coleção/célula da Seção 9.1. Cada família de equilíbrios
públicos com agenda contém um family record:

```text
public_family_record_id
public_collection_id
cell_id
institution
public_type
admissibility_conditions
source_public_continuation_complete_view_id
member_parameter_space
member_generator
necessary_and_sufficient_membership_rule
atomic_family_binder
complete_proposal_strategy_formula
complete_weak_voting_strategy_formula
complete_belief_system_formula
complete_continuation_selection_formula
complete_payoff_formula_by_identity
complete_outcome_distribution_formula
existence_multiplicity_status
selection_status
refinement_status
source_external_family_record_ids
source_external_artifact_hashes
source_value_transport_records
assumptions_used
checks_performed
proof_paths
payoff_date
```

`source_public_continuation_complete_view_id` identifica a visão completa pertinente
de `N7_public`, separada dos registros selecionados pelo plano.
O mesmo `atomic_family_binder` liga estratégia integral no espaço de propostas,
crenças públicas degeneradas no tipo conhecido, votos em todos os conjuntos de
informação, `kappa`, payoffs e outcomes.
`complete_continuation_selection_formula` satisfaz a Seção 2.4 e seleciona
elementos literais completos. Existência e multiplicidade são registradas pela
coleção e pelas células, sem enumeração infinita nem seleção silenciosa.

Esses family records nascem dentro de `AR` e recebem IDs próprios e estáveis.
Membros contínuos não recebem IDs materiais. Os records não
possuem `source_artifact_hash` de `AR` nem qualquer hash autorreferente. O hash
do artefato de `AR` só é calculado depois de sua serialização e só se torna
hash congelado após o gate correspondente. Os `source_external_artifact_hashes`
apontam exclusivamente para insumos já congelados, como `AC` e `N7_public`.

As coleções públicas de `M` e `U` são independentes: uma célula `none` de uma
regra não apaga registros existentes da outra.

### 9.6 Registros derivados de benchmarks, rendas e interação em `AR`

O envelope de análise contém:

```text
analysis_collection_id
node_id
common_partition_id
majority_analysis_payload
unanimity_analysis_payload
cross_rule_contrast_collection
coverage_certificates
checks_performed
proof_paths
```

Cada payload por regra preserva, independentemente:

```text
rule_analysis_payload_id
institution
source_AC_rule_payload_id
source_AC_artifact_hash
source_continuation_complete_view_id
source_public_agenda_family_record_ids
source_N7_public_family_record_ids
source_public_continuation_complete_view_id
source_atomic_family_binders
source_external_artifact_hashes
private_with_agenda_exact_joint_family
public_with_agenda_exact_joint_family
private_without_agenda_exact_joint_family
public_without_agenda_exact_joint_family
ex_ante_image_collection_ids
payoff_comparison_collection
information_rent_collection
interaction_collection
source_value_transport_records
existence_coverage_status
selection_status
refinement_status
checks_performed
evidence_path
payoff_date
```

Rendas e interações são derivadas somente quando a tupla completa pertinente
existe. Uma fonte ausente deixa vazio apenas o objeto dependente; os quatro
objetos de base e todos os objetos independentes sobreviventes da regra ficam
registrados. `cross_rule_contrast_collection` só recebe tuplas para as quais
ambos os payloads necessários existem na mesma célula comum.

Cada membro de qualquer coleção derivada contém, no mínimo:

```text
derived_object_id
object_kind
institution
realized_type
common_cell_id
common_domain
complete_source_tuple_ids
complete_source_family_record_ids
complete_member_parameter_space
complete_member_binder
necessary_and_sufficient_tuple_membership_rule
internal_AR_source_record_ids
external_source_artifact_hashes
source_value_transport_records
native_value_coordinates
native_dates
transport_factors_to_A
beta_application_counts
exact_joint_value_and_outcome_set_at_A
derived_envelopes
existence_coverage_status
selection_status
refinement_status
checks_performed
evidence_path
payoff_date
```

`derived_object_id` é único e estável em todos os consumidores. O conjunto de
IDs e o `complete_member_binder` cobrem a tupla inteira sem enumerar membros;
`external_source_artifact_hashes` cobre somente insumos externos congelados. O
`artifact_hash` do contêiner `AR`, calculado depois da serialização, cobre
conjuntamente os registros internos sem criar autorreferência.

Os objetos públicos com agenda são registros próprios de `AR`; os públicos sem
agenda vêm apenas de `N7_public`; os privados com e sem agenda chegam pelos
payloads independentes de `AC`. Nenhum objeto pode omitir a proveniência de uma
das quatro posições quando seu `object_kind` a exigir. Nenhuma diferença é
calculada antes de todos os componentes estarem na data de `A`.

### 9.7 Conjunto conjunto exato, invariância e envelopes

Dentro de cada regra e `common_cell_id`, `AC` e `AR` preservam cada family
record existente, mesmo quando a outra regra está vazia. Para cada objeto
derivado, formam simbolicamente o produto dos family records necessários e de
seus complete member binders sob uma regra necessária e suficiente de
compatibilidade. Não criam uma linha por membro.

O resultado primário é o conjunto conjunto exato de estratégias, crenças,
continuações, payoffs e outcomes. O mesmo `F`, `lambda` econômico ou binder
declarado aparece em todas as coordenadas do membro. Comparações entre regras
usam os family records das duas coleções somente nas células em que ambas
existem. É proibido produto cartesiano de envelopes marginais, coordinate
splicing, convexificação não gerada pela família ou seleção nova.

Envelopes e imagens são projeções derivadas somente depois do conjunto conjunto
exato. Uma projeção escalar adicional só é admissível quando prova de
invariância cobre toda a família relevante; a projeção não substitui nem apaga
o conjunto. `selection_status` e `refinement_status` acompanham cada objeto.

### 9.8 Regra de atomicidade

Payoffs, crenças, estratégias e outcomes do mesmo equilíbrio ficam no mesmo
family record sob o mesmo binder. Projeções, envelopes, mínimos, máximos ou
imagens marginais nunca podem ser recombinados para fabricar membro
inexistente. Cada objeto de comparação ou renda cita a tupla completa de family
record IDs, bindings, hashes externos e records internos que o gerou.

### 9.9 Células sem existência

Uma célula `none` contém `collection_id`, `cell_id`, predicado, domínio,
certificado de inexistência ou falta de cobertura, claims do ledger, fontes,
hashes, premissas, checks, prova e evidência. Não contém family record, payoff,
estratégia ou sentinela. A célula vazia de uma regra não apaga registros da
outra, mas todo objeto derivado que exija a fonte ausente fica vazio e recebe
seu próprio certificado.

### 9.10 Ledgers

Os quatro ledgers usam apenas os status:

```text
proved
checked numerically
conjecture
pending
rejected
```

No Gate 0, cada ledger contém somente o cabeçalho canônico:

```text
claim_id
node_id
collection_id
cell_id
record_id
family_record_id
member_binding_or_domain
claim_kind
claim_text
branch
domain
status
selection_status
refinement_status
assumptions_used
checks_performed
source_record_ids
source_hashes
payoff_date
evidence_path
proof_path
```

Esses nomes aparecem em uma única linha TSV, nessa ordem. `claim_kind` usa
`substantive`, `D1`, `intuitive_criterion`, `integration` ou `coverage`.
Claims D1 e Critério Intuitivo ficam no ledger do nó examinado,
são explicitamente rotuladas por `claim_kind` e têm `checks_performed` e
`evidence_path` próprios. `collection_id`, `cell_id` e `record_id` identificam
a coleção, a partição e o objeto derivado ou certificado `none`;
`family_record_id` e `member_binding_or_domain` ligam a claim à família inteira
ou ao domínio simbólico pertinente, sem criar ID por membro. `proof_path` aponta
para a prova correspondente quando exigida.
`source_record_ids` cobre fontes internas e externas; `source_hashes` contém
somente hashes externos já fixáveis e nunca o hash autorreferente do próprio
artefato. Nenhum ledger global adicional é permitido.

---

## 10. DAG próprio

O namespace é `agenda_extension`. Os únicos nós produzidos pela extensão são:

| Nó | Objeto | Dependências |
|---|---|---|
| `A_M` | agenda privada sob maioria | `C_M` externo |
| `A_U` | agenda privada sob unanimidade | `C_U` externo |
| `AC` | comparação privada com agenda | `A_M`, `A_U` |
| `AR` | jogos públicos, rendas e interação | `AC`, continuações públicas externas |

O arquivo canônico é
`model_redesign/agenda_extension_game_dag.json`. As fontes `C_M`, `C_U` e
continuações públicas são inputs externos, não novos nós da cadeia
`essential-input`. O DAG daquela cadeia permanece fechado e intocado.

Para não criar dependência oculta, `A_M` e `A_U` carregam as visões completas,
consumíveis e hash-pinned de `C_M` e `C_U`. `AC` transporta essas visões em
payloads independentes por regra, inclusive células vazias, registros,
coordenadas, valores nativos, datas e registros de transporte para `A`. `AR`
depende formalmente apenas de `AC` e `N7_public`: consome por `AC` a
proveniência privada com e sem agenda e por `N7_public` a proveniência pública
sem agenda; os objetos públicos com agenda são produzidos em `AR` com family
record IDs próprios. Essa passagem não cria nó nem aresta adicional.

O manifesto distingue duas camadas:

1. **estrutura imutável do Gate 0:** jogo, schemas substantivos, namespace,
   nós, arestas, dependências, ordem obrigatória, obrigações de prova e
   protocolo de revisão;
2. **valores de ciclo de vida previstos:** `status`, `artifact_paths`,
   `artifact_hash`, `dependency_hashes`, `started_order`, `passed_order`,
   `frozen` e `reviews`.

A convenção única é a mesma do DAG `essential-input`: enquanto um nó está
`pending`, o objeto do nó contém `status=pending` e **omite** os demais campos
futuros de ciclo de vida. Lista vazia e `null` não são uma representação
alternativa permitida. Quando o nó passa e é congelado, a transição normal
adiciona `status=pass`, caminhos dos artefatos, hash do artefato, hashes
das dependências, `started_order`, `passed_order`, `frozen=true` e exatamente dois itens em
`reviews`. Cada item contém `reviewer_id`, `reviewer_role`, `verdict`,
`finding_counts`, `covered_hash` e `review_path`; os dois revisores são
distintos, cobrem o mesmo `artifact_hash`, registram `PASS` e contagens
`0/0/0`.

Essa atualização exclusiva dos valores previstos de ciclo de vida executa o
DAG e não reabre o Gate 0. Alteração da estrutura imutável o reabre. GO autoral
é condição externa e separada: cada gate futuro deve citá-lo em registro
autoral próprio, nunca inferi-lo de prontidão topológica nem inventá-lo neste
DAG. Não se cria arquivo geral de status ou sétimo artefato do Goal 0.

---

## 11. Especificação do verifier do Goal 1

O Goal 1 deverá escrever, revisar e somente então executar os scripts. Este
Goal 0 não cria script algum. O verifier futuro deverá, no mínimo:

### 11.1 Contrato e arquivos

1. verificar a existência exata deste contrato, do DAG e dos quatro ledgers;
2. verificar o hash aprovado do contrato e dos cinco arquivos auxiliares;
3. rejeitar arquivo extra que se apresente como produto do Gate 0;
4. verificar que o contrato não contém resultado, payoff candidato, ranking ou
   desigualdade substantiva não pertencente às primitivas ou às definições do
   baseline;
5. verificar que as decisões autorais de 2026-08-25 e 2026-08-26 estão
   registradas como `APPROVED` e que não resta decisão protocolar pendente;
6. rejeitar declaração de contrato aprovado, Gate aprovado ou PASS antes dos
   pareceres e da decisão autoral correspondentes.

### 11.2 Topologia e namespace

1. exigir namespace `agenda_extension`;
2. exigir exatamente os nós produzidos `A_M`, `A_U`, `AC`, `AR`;
3. exigir as dependências externas `A_M <- C_M`, `A_U <- C_U` e
   `AR <- N7_public`;
4. exigir as arestas internas `AC <- A_M`, `AC <- A_U` e `AR <- AC`;
5. rejeitar aresta da extensão que altere o DAG `essential-input`;
6. verificar que todo nó `pending` contém `status=pending` e omite
   `artifact_paths`, `artifact_hash`, `dependency_hashes`, `started_order`,
   `passed_order`, `frozen` e `reviews`, rejeitando `null` ou listas vazias como
   alternativa;
7. ao congelamento, exigir `status=pass`, caminhos, hash do artefato,
   hashes das dependências, `started_order`, `passed_order`, `frozen=true` e exatamente dois
   reviews de revisores distintos, ambos `PASS 0/0/0` sobre o mesmo
   `artifact_hash`, com todos os campos de review da Seção 10;
8. distinguir prontidão topológica de autorização autoral e exigir que cada GO
   futuro venha de registro autoral próprio externo ao DAG;
9. exigir `AR <- AC` e `AR <- N7_public`, sem aresta oculta de `AR` para `C_M`
   ou `C_U`, e conferir o transporte auditável dessas fontes por `AC`;
10. validar o schema futuro de review com reviewer ID/role, verdict, finding
   counts, covered hash e review path, sem aceitar valores fabricados;
11. rejeitar em registros internos de `AR` hash-fonte autorreferente e exigir
    que o hash de `AR` só seja fixado após serialização e freeze.

### 11.3 Interfaces e contabilidade

1. verificar que cada história terminal gera um único vetor de payoff;
2. recompor expectativas somente de payoffs condicionados ao tipo;
3. exigir `q_M=floor(N/2)+1` e `q_U=N`, ambas contando o voto favorável
   automático de `H`, e conferir a transição em cada vetor de votos;
4. verificar que ação fraca não move por si a crença sobre `theta`;
5. verificar consistência estrutural para ações prescritas de `H`;
6. para medidas de proposta Borelianas arbitrárias, recomputar a razão local em
   `B_delta^Y(y)`, incluindo razão de massas, regiões contínuas regulares e
   suportes singulares em faces, curvas ou superfícies de dimensão menor;
7. rejeitar crença baseada em versão de densidade escolhida pontualmente e
   rejeitar classificação automática de singleton contínuo como desvio ou de
   suporte singular como erro;
8. conferir Bayes `m`-quase em toda parte, liberdade apenas no complemento não
   disciplinado, parada e escala quando faltar limite local necessário em
   história disciplinada e suporte 0/1 nos endpoints;
9. verificar `beta` exatamente uma vez de `C` para `A`;
10. usar comparações exatas em endpoints e cutoffs;
11. rejeitar sentinela de payoff em célula `none`;
12. exigir que cada member assessment traga `kappa_g` pública, type-blind,
    Borel-mensurável, total nas histórias rejeitadas e unívoca em cada história;
13. exigir sigma-álgebra discreta no conjunto-alvo e tabela finita de regiões
    Borel com family record, complete member binding, hash externo, cobertura,
    exclusividade e mensurabilidade; quando tabela finita não existir, exigir
    definição formal e caminho de prova em vez de enumerar o contínuo;
14. permitir compressão por estado suficiente somente com prova registrada;
15. preservar como assessments distintos todos os planos de continuação
    admissíveis e rejeitar seleção global, média ou fabricação de registro;
16. exigir em cada `A_M` e `A_U` uma visão completa, consumível e hash-pinned da
    correspondência relevante de `C_M` ou `C_U`, separada dos registros
    selecionados em equilíbrio;
17. auditar se `C_M` é genérica no quórum ou especializada, sem extrapolar;
18. verificar que todas as duplas proposta-vetor de votos têm uma única
    transição;
19. para toda fonte de comparação, exigir record ID, `source_scope`, hash
    externo quando aplicável, `native_value`, `native_date`, fator de
    transporte, contagem de `beta` e valor transportado em `A`;
20. rejeitar diferença entre valores em datas distintas e verificar que
    `beta` foi aplicado exatamente uma vez quando cabível.

### 11.4 Racionalidade sequencial e completude do PBE baseline

O verifier deve exigir, sem substituir prova por teste numérico nem enumerar
uma família contínua:

1. votos fracos sequencialmente racionais em todos os conjuntos de informação
   sob as-if-pivotal e `T^Y`;
2. ausência de desvio lucrativo de cada tipo de `H` contra **todo `Y`**, não
   apenas contra propostas observadas ou uma grade;
3. otimalidade de toda ação no suporte da estratégia de proposta e ausência de
   ação fora do suporte com payoff estritamente maior;
4. estratégia completa após toda proposta e história factível, inclusive fora
   do caminho;
5. consistência das crenças baseline pela Seção 5 e compatibilidade de `kappa_g`
   com cada história rejeitada;
6. seleção de um elemento literal completo da continuação, nunca payoff escalar,
   com family record e complete member binding quando necessário;
7. mesmo `F`, `lambda` econômico ou binder em estratégia, crença, voto,
   continuação, payoff e outcome, com testes que rejeitem coordinate splicing;
8. member generator necessário e suficiente que cubra pooling, separating,
   semi-pooling, misturas e quaisquer outras formas admissíveis sem impor uma
   taxonomia finita como primitiva;
9. correspondência completa por family records, partição exclusiva e cobertura
   exaustiva das células, incluindo certificados `none`;
10. conjunto conjunto exato antes de envelopes; envelope é somente projeção e
    nunca produto cartesiano de intervalos marginais;
11. ausência de simetria, coalizão mínima, zero gifts ou seleção adicionada sem
    primitiva autorizada;
12. ausência de uma seleção única compartilhada por histórias públicas
    distintas; posterior igual não funde histórias;
13. mensurabilidade Borel dos votos, `kappa_g`, member selectors/bindings e
    kernels de payoff/outcome necessários às expectativas;
14. todos os payoffs, outcomes, crenças, estratégias e continuações do mesmo
    membro preservados atomicamente;
15. para cada família pública com agenda produzida em `AR`, as mesmas
   obrigações de racionalidade sequencial, desvios sobre todo `Y`, optimalidade
   no suporte, completude da coleção e `kappa`, adaptadas ao tipo publicamente
   conhecido;
16. verificação por identidades algébricas e provas, enumerações pequenas quando
    finitas e negativos representativos; nunca por enumeração impossível de um
    contínuo.

### 11.5 Schemas, atomicidade e ledgers

1. exigir todos os campos dos schemas de coleção, célula, family record
   privado, `ex_ante_image_collection`, payload de `AC`, family record público
   de `AR` e objeto derivado da Seção 9;
2. exigir unicidade dos IDs;
3. exigir `collection_id`, `collection_status`, `cell_id`, predicado/domínio,
   `status=exists|none`, `equilibrium_family_record_ids` e certificados
   exaustivos e exclusivos;
4. exigir certificado e evidência próprios para `none`, sem payoff ou
   sentinela;
5. exigir em cada family record domínio de membros, gerador, regra necessária
   e suficiente de membership, `atomic_family_binder`, fórmulas completas,
   status de existência/multiplicidade/seleção/refinamento, provas, checks e
   certificados; singleton é família degenerada e não há ID por membro;
6. exigir que payoff, crença, estratégia, voto, outcome e plano de continuação
   pertençam ao mesmo family record e ao mesmo complete member binding;
7. exigir que cada `kappa_g(h)` selecione o elemento literal completo da
   continuação por family record e complete member binding/selector, sem
   scalarização nem coordinate splicing;
8. validar o schema único de complete view e exigir o mesmo `complete_view_id`,
   conteúdo, fonte e hash em `A_M`/`A_U`, `AC` e `AR`;
9. validar cada `ex_ante_image_collection`: mesmo binder da família-fonte,
   prior, pesos e valores por tipo, valor ex ante, datas, transportes, conjunto
   conjunto exato, existência/cobertura e metadados de seleção/refinamento;
10. construir simbolicamente o produto de todas as famílias e complete member
    binders compatíveis na mesma célula, preservar primeiro o conjunto conjunto
    exato e rejeitar recombinação de envelopes marginais ou seleção;
11. exigir IDs de todas as fontes e hashes de todos os insumos externos
   congelados em comparações, rendas, contrastes e interações; registros
   internos de `AR` usam record ID e são cobertos pelo hash contêiner somente
   após serialização;
12. permitir escalar apenas com certificado de invariância que cubra toda a
   coleção relevante sem apagá-la;
13. exigir que `AC` preserve payloads independentes por regra e as visões
   completas transportadas por `A_M` e `A_U`, sem introduzir dependência oculta;
14. verificar que regra vazia não apaga a correspondência existente da
    outra e que comparação cruzada só existe quando ambos os lados existem;
15. exigir family records públicos completos em `AR`, com estratégia integral,
    visão completa da continuação pública, votos, `continuation_plan`, outcomes,
    payoffs, existência, multiplicidade, provas e checks;
16. rejeitar hash-fonte de `AR` nos próprios registros internos e aceitar como
    source hashes somente insumos externos congelados;
17. verificar existência e cobertura, incluindo certificados de coleção vazia;
18. exigir os campos temporais completos e proibir subtração pré-transporte;
19. exigir os cabeçalhos canônicos dos quatro ledgers;
20. restringir status dos ledgers aos cinco valores permitidos;
21. exigir `selection_status`, `refinement_status`, checks, evidência e data do
    payoff em todo objeto aplicável;
22. exigir que cada claim preenchida cite coleção, célula, registro, family
    record, binding/domínio, fontes, evidência e prova quando aplicável;
23. exigir claims D1 e Critério Intuitivo explicitamente rotuladas no ledger do
    próprio nó, cada uma com evidência própria, e rejeitar ledger global novo.

### 11.6 Gates posteriores

O verifier deve representar como checks distintos todos os gates da Seção 12,
incluindo ordem sequencial de `A_M` e `A_U`, ciclo exclusivo e reconstrução
cega de `A_U`, hashes idênticos entre revisões requeridas, separação entre
implementador e revisores, GO autoral de cada passagem, Gate `Q` condicional e
revisão novamente disparada por qualquer mudança de bytes.

Os testes computacionais são instrumentos de falsificação e auditoria, não
prova de equilíbrio nem aprovação de Gate.

---

## 12. Revisão, congelamento e invalidação

### 12.1 Gate 0

1. implementador não revisa; revisor não edita;
2. este candidato só pode passar o Gate 0 depois de dois pareceres
   independentes read-only `PASS 0/0/0` no mesmo SHA-256: um de desenho formal
   e outro de teoria dos jogos;
3. qualquer finding é escalado por default;
4. finding só é técnico quando existe exatamente um reparo único e forçado
   pelo texto já aprovado;
5. ambiguidade, definição faltante, ação, informação ou payoff não especificado
   são sempre substantivos;
6. mudança de bytes gera novo hash e exige os dois pareceres novamente;
7. mesmo depois dos dois PASS, o Goal 1 só abre por GO explícito do autor.

Este candidato reparado ainda não recebeu esses dois novos pareceres. Os
pareceres anteriores incidiram sobre bytes diferentes e não podem ser
reaproveitados como PASS do novo hash.

### 12.2 Goal 1 — consumibilidade e harness

Somente após o Gate 0 e o GO autoral, o Goal 1 pode:

1. fixar os hashes das interfaces externas e demonstrar sua consumibilidade;
2. verificar todos os campos obrigatórios, inclusive histórias, posteriores,
   datas, payoffs por tipo, registros e hashes de continuação;
3. implementar o verifier e o harness sem derivar `A_M` ou `A_U`;
4. receber dois pareceres independentes read-only `PASS 0/0/0` no mesmo hash:
   um de qualidade do código e outro de suficiência formal;
5. congelar somente esse hash e somente após os pareceres; o Goal 2 ainda exige
   GO autoral próprio.

Campo faltante, hash incompatível ou compressão não provada faz o Goal 1 parar;
não autoriza adaptação local de interface.

### 12.3 Goals 2 e 3 — `A_M` e `A_U`, em sequência

Embora `A_M` e `A_U` sejam graficamente independentes, a execução é
obrigatoriamente sequencial:

1. Goal 2 resolve `A_M`, registra a correspondência completa por family
   records, a `ex_ante_image_collection` de E-02, ledgers e certificados de
   cobertura; exige dois pareceres
   independentes read-only `PASS 0/0/0` sobre o mesmo hash, freeze e GO autoral
   antes de qualquer abertura de `A_U`;
2. Goal 3 resolve `A_U` em ciclo exclusivo. Nenhuma derivação ou revisão de
   outro nó corre em paralelo com esse ciclo. Pelo menos uma das revisões deve
   fazer reconstrução cega a partir apenas deste contrato aprovado e de `C_U`
   congelado, sem receber fórmulas candidatas; só depois confronta a
   reconstrução com o candidato;
3. `A_U` também produz sua `ex_ante_image_collection` de E-02 e exige dois
   pareceres independentes read-only `PASS 0/0/0` no mesmo hash, freeze e GO
   autoral antes de `AC`;
4. em ambos os Goals, o implementador não revisa e qualquer mudança de bytes
   exige repetir as revisões no novo hash.

### 12.4 Goals 4 e 5 — `AC` e `AR`

1. Goal 4 (`AC`) só abre após `A_M` e `A_U` congelados e autorizados. Preserva
   coleções privadas separadas, as imagens ex ante de E-02, refinamento comum,
   multiplicidade atômica e células vazias. Constrói o conjunto conjunto exato
   antes de qualquer envelope. Exige duas revisões
   independentes read-only `PASS 0/0/0` no mesmo hash, incluindo auditoria de
   integração dos hashes-fonte, freeze e GO autoral para `AR`.
2. Goal 5 (`AR`) só abre após `AC` congelado e autorizado. Resolve os jogos
   públicos com agenda e constrói as coleções de benchmarks, rendas, contrastes
   e interação nos schemas aprovados. O ciclo é exclusivo e exige dois
   pareceres independentes read-only `PASS 0/0/0` no mesmo hash, freeze e
   decisão autoral explícita sobre quais resultados podem seguir para o paper.

### 12.5 Goal `Q` opcional e Goal 6 de migração

1. Goal `Q` não abre automaticamente. Requer autorização autoral própria. Se
   qualquer claim, figura ou texto sobre quórum intermediário ou “vale de
   quórum” for pretendido, `Q` deve ser derivado, revisado por dois pareceres
   independentes read-only `PASS 0/0/0` no mesmo hash, congelado e aprovado
   antes da migração.
2. Goal 6 só abre após `AR` congelado, decisão autoral sobre os resultados e,
   quando acionado, fechamento de `Q`. Exige matriz de migração que ligue cada
   claim editorial a IDs e hashes congelados, edição controlada em tarefa
   própria, recompilação e os dois pareceres independentes read-only
   `PASS 0/0/0` exigidos no mesmo hash final pelo protocolo de migração.
3. Nenhum gate, freeze, PASS técnico ou prontidão topológica substitui o GO
   autoral da etapa seguinte. Mudança de bytes em qualquer artefato congelado
   invalida a cobertura de revisão e exige novo ciclo no novo hash.

### 12.6 Cascatas de invalidação

- mudança de `C_M` invalida `A_M`, `AC`, `AR` e consumidores editoriais;
- mudança de `C_U` invalida `A_U`, `AC`, `AR` e consumidores editoriais;
- mudança das continuações públicas invalida `AR` e consumidores editoriais;
- mudança de `A_M` invalida `AC`, `AR` e migração;
- mudança de `A_U` invalida `AC`, `AR` e migração;
- mudança de `AC` invalida `AR` e migração;
- mudança de `AR` invalida a migração que o tenha consumido;
- uma regra vazia não invalida por si a coleção sobrevivente da outra regra,
  mas impede todo contraste que exija ambas.

### 12.7 O que reabre o próprio Gate 0

Reabre este Gate 0 qualquer mudança na camada imutável, incluindo:

- contrato, objetivo, estimando ou domínio;
- jogadores, tipos, prior, ações, pacote, factibilidade, transições,
  informação, implementação ou payoffs;
- conceito de solução baseline;
- schema ou regra de atomicidade;
- DAG, namespace, topologia ou dependências;
- obrigações de prova e interface do verifier;
- protocolo de revisão, congelamento ou findings.

Não reabre o Gate 0 a atualização exclusiva, já prevista pelo schema, dos
valores de ciclo de vida de um nó: `status=pending` passa a `status=pass` com
caminhos, hash do artefato, hashes das dependências, `started_order`,
`passed_order`, `frozen=true` e
exatamente dois reviews `PASS 0/0/0` de revisores distintos sobre o mesmo hash.
Essa exceção não permite mudar campos imutáveis nem converter prontidão em GO.

Quando a camada imutável muda, a reabertura devolve todos os nós produzidos a
`pending` e invalida sua prontidão de consumo. Conteúdo antigo não é apagado,
mas nenhum consumidor pode tratá-lo como congelado até novo ciclo.

---

## 13. Estado do Gate 0 e próxima fronteira

As decisões autorais de protocolo de 2026-08-25 e 2026-08-26 estão
incorporadas como `APPROVED`. O documento, porém, é somente um candidato
reparado: o Gate 0 está **não aprovado** e aguarda duas novas revisões
independentes read-only no mesmo hash, uma de desenho formal e outra de teoria
dos jogos.

Os hashes apenas fixam bytes candidatos. Eles não aprovam o contrato, não
congelam o Gate e não abrem o Goal 1. As revisões e o eventual GO autoral
pertencem a tarefas posteriores.
