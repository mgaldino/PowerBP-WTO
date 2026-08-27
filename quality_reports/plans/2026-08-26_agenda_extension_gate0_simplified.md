# Gate 0 simplificado — extensão de agenda informal

**Data do candidato:** 2026-08-26  
**Status:** `SIMPLIFIED CANDIDATE — NOT APPROVED — GOAL 1 NOT AUTHORIZED`  
**Escopo autorizado:** uma única simplificação do Gate 0, limitada a reduzir
complexidade administrativa e obrigações que código não pode certificar.  
**Fora de escopo:** Goal 1; verifier ou harness; derivação de equilíbrio;
cálculos; edição ou compilação do manuscrito; figura; commit, tag ou push;
edição dos artefatos congelados de `essential-input`.

Este é o candidato canônico corrente. O candidato anterior permanece intacto
como fotografia histórica em
`quality_reports/plans/2026-08-23_agenda_extension_gate0.md`.

## 0. Proveniência e limite da simplificação

A simplificação foi autorizada pelo autor em 2026-08-26 depois do parecer
adversarial salvo em
`quality_reports/2026-08-26_agenda_extension_gate0_overengineering_adversarial_review.md`,
SHA-256 `c802bf389669b36ef53e4f244828a639eec2a0eee40a23a679e68d51cf022c67`.

Os bytes históricos preservados são:

- contrato anterior: `36ef554322945a7e44da492b46f15527855da603e06ef90d787b7645cc1c9b32`;
- DAG anterior: `9644151b8441ed5d09d1a870c3a2f5b94437c2376c7af6fb419c17297ebd5cd6`;
- cada ledger anterior: `e8579785d0a0277601e2468951bf387853cd89b3f9a49386d2af5f8f31c1cba0`.

A nova redação preserva integralmente:

1. jogadores, tipos, ações, informação, votação e implementação;
2. factibilidade e payoffs;
3. cronologia, datas e aplicação única de `beta`;
4. conceito de solução baseline já decidido, inclusive a regra local de Bayes;
5. correspondência completa e conjunta de equilíbrios, family records e binder
   atômico;
6. escolha de uma continuação literal completa, pública e comum aos tipos;
7. hashes exatos e revisão matemática independente.

Ela simplifica somente:

1. o que o código pode alegar ter verificado;
2. os campos administrativos dos schemas e ledgers;
3. o transporte de fontes, que passa a usar referências por ID e hash em vez de
   copiar payloads completos entre nós;
4. o número de ciclos independentes de autorização e revisão;
5. a obrigatoriedade antecipada dos benchmarks públicos, rendas e interação,
   que passam a formar uma fase opcional depois do resultado privado.

As fontes externas continuam sendo:

| Objeto | Fonte |
|---|---|
| planejamento da extensão | `quality_reports/plans/2026-08-23_agenda_extension_gated_plan_v3.md`, SHA-256 `56a933dc25532633d030ecba370a1d132ceb480e75cbf8ea4c4b48104ccb033a` |
| crenças, votação e `T^Y` | `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` |
| contrato e protocolo de referência | `quality_reports/plans/2026-08-12_essential_input_gate0.md` |
| `C_M` | `model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json`, SHA-256 histórico declarado `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| `C_U` | `model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json` |
| continuações públicas | `model_redesign/essential_input_n7_complete_information_benchmark_candidate.json` |

O Goal 1 futuro deverá recalcular e fixar os hashes correntes de todas as
interfaces externas. Nenhuma fonte congelada pode ser completada ou adaptada
localmente.

## Leitura para aprovação — sem jargão

O novo estágio pergunta o que muda quando o hegemon, já informado sobre seu
tipo, formula a primeira proposta. Ele é obrigado a propor. Sua proposta conta
como seu voto favorável, e os Estados fracos votam simultaneamente sobre o
pacote completo. Se a proposta passa, cada participante recebe a parcela que
ela lhe atribuiu. Se ela não passa, começa integralmente o jogo já congelado da
regra correspondente.

O trabalho principal é resolver esse estágio sob maioria e sob unanimidade sem
escolher silenciosamente o equilíbrio mais conveniente. Primeiro se preserva
o conjunto conjunto de estratégias, crenças, continuações, payoffs e resultados
que realmente pertencem ao mesmo equilíbrio. Benchmarks públicos, rendas e a
interação entre informação e agenda só serão abertos se o resultado privado
justificar esse investimento e o autor der novo GO.

## 1. Jogo, informação e cronologia

### 1.1 Jogadores e tipos

- jogadores: um hegemon `H` e `m=N-1` Estados fracos, com `N>=3`;
- tipo privado de `H`: `theta in {0,1}`;
- prior público: `nu=Pr(theta=1)` em `[0,1]`;
- Natureza determina `theta` antes da proposta;
- somente `H` observa `theta`.

### 1.2 Instituições e dependências

O núcleo contém maioria simples `M` e unanimidade `U`. As quotas, contando o
voto favorável automático de `H`, são

```text
q_M=floor(N/2)+1
q_U=N.
```

Cronologia:

```text
A_M -> C_M
A_U -> C_U
```

Ordem de solução:

```text
A_M depends_on C_M
A_U depends_on C_U
AC  depends_on A_M e A_U
AR  depends_on AC e nas continuações públicas congeladas
```

`AR` é opcional e não integra o pacote privado mínimo.

### 1.3 Proposta, votação e transição

Para cada regra `g in {M,U}`:

1. `H` deve escolher uma proposta factível em `Y`; não existe ação nula,
   renúncia ou passagem de vez;
2. a proposta torna-se pública e conta como o voto favorável de `H`;
3. todos os Estados fracos votam `sim` ou `não`, simultaneamente e em ballot
   selado;
4. ninguém observa votos alheios antes de votar;
5. depois do fechamento, o vetor completo e o resultado tornam-se públicos;
6. se a quota é satisfeita, o pacote completo é implementado para todos e o
   jogo termina na data de `A`;
7. se a quota não é satisfeita, não há pagamento em `A` e a história pública
   entra em exatamente uma continuação completa existente de `C_g`.

`H` não vota novamente. O voto individual de um Estado fraco afeta somente a
quota; não determina sua inclusão nem seu pagamento. Não há acordo parcial,
payoff-sentinela, continuação fictícia ou terceiro destino.

### 1.4 História pública rejeitada

A história levada à continuação contém:

- instituição;
- proposta completa;
- identidade do proponente;
- vetor completo de votos;
- resultado do ballot;
- posterior admissível sobre `theta`.

História e posterior apenas indexam uma continuação que já existe na interface
congelada. Não autorizam inventar payoff ou completar campo ausente.

## 2. Pacote, factibilidade, payoffs e datas

### 2.1 Pacote

`H` escolhe

```text
s_H=(z_H,(x_j)_{j in W}),
```

em que `z_H` é sua única parcela final e `x_j` é a parcela final do Estado
fraco `j`. O espaço factível é

```text
Y={s_H: z_H>=0, x_j>=0 e z_H+sum_j x_j<=1}.
```

`Y` é compacto e Boreliano com sua topologia relativa. Se uma decomposição
intermediária usar dois termos para `H`, eles são somados em `z_H`; não criam
duas parcelas econômicas. Eventual folga recebe exatamente o tratamento já
vigente para proposta de Estado fraco, sem nova redistribuição ex post.

### 2.2 Primitivas econômicas

- pie institucional fixa e normalizada em 1;
- benefício direto `b_theta=0`;
- opção externa `o_theta` externa à pie;
- domínio `0<o_0<o_1<1`;
- ausência de side payments externos ao pacote;
- formação, entrada e escolha endógena da regra fora deste jogo.

Se o acordo passa em `A`, `H` recebe `z_H` e cada Estado fraco `j` recebe
`x_j`, independentemente de seu voto individual.

### 2.3 Regra temporal

`A` é a nova data zero e `beta in (0,1)`. Regras invioláveis:

1. acordo em `A` não recebe desconto;
2. payoff nativo de `C` é multiplicado por `beta` exatamente uma vez quando
   transportado para `A`;
3. payoffs condicionados ao tipo são definidos antes de qualquer expectativa;
4. diferenças usam somente valores expressos na mesma data;
5. uma célula sem continuação não recebe valor convencional.

Todo valor-fonte usado em comparação registra:

```text
source_record_id
source_artifact_hash_if_external
native_value
native_date
transport_factor_to_A
beta_application_count
transported_value_at_A
```

Fonte interna do mesmo artefato é coberta pelo hash final do contêiner; não se
usa hash autorreferente.

## 3. Conceito de solução e crenças

O baseline é a correspondência completa de Perfect Bayesian equilibria sob:

1. **voto fraco as-if-pivotal:** comparação de `sim` e `não` condicionada ao
   evento de o voto ser decisivo;
2. **aceitação na indiferença:** em igualdade genuína de valor esperado, o voto
   é `sim`;
3. **no signaling what you do not know:** ação de Estado fraco não move por si
   a crença sobre `theta`;
4. **consistência estrutural:** ações prescritas de `H` atualizam pela regra de
   Bayes abaixo;
5. **suporte do prior:** em `nu=0`, posterior sempre 0; em `nu=1`, sempre 1;
6. **estratégias:** votos puros; propostas de `H` podem ser mistas;
7. **correspondência completa:** pooling, separating, semi-pooling, mistura,
   atraso endógeno e propostas ótimas múltiplas são resultados a provar, nunca
   seleções impostas.

### 3.1 Regra local de Bayes preservada

Se `sigma_0` e `sigma_1` são as medidas Borelianas de proposta e

```text
m=(1-nu)sigma_0+nu sigma_1,
```

defina, para `y in Y`, a vizinhança relativa

```text
B_delta^Y(y)=Y interseção {z in aff(Y): ||z-y||<delta}.
```

Para `0<nu<1`, a crença canônica em ponto disciplinado é

```text
mu(y)=lim_{delta desce a 0}
  nu sigma_1(B_delta^Y(y))
  /[(1-nu)sigma_0(B_delta^Y(y))+nu sigma_1(B_delta^Y(y))],
```

quando o limite existe. Um ponto é disciplinado se
`m(B_delta^Y(y))>0` para todo `delta>0`. Em todo ponto disciplinado, o limite
deve existir; se não existir, o ramo para e escala. Somente quando alguma
vizinhança relativa tem massa pública zero a crença fica livre dentro do
suporte do prior.

Essa disciplina é uma decisão autoral preservada, mais forte que exigir Bayes
apenas quase em toda parte. Ela vale para átomos, regiões contínuas regulares e
suportes singulares. Não é tremble, D1 nem Critério Intuitivo. O sistema de
crenças e os kernels necessários às expectativas são Borel-mensuráveis.

O verifier futuro não poderá certificar genericamente a existência desse limite
em toda medida admissível; essa é uma obrigação de prova do candidato e de
revisão matemática.

### 3.2 Extensões fora do baseline

Tremble, quóruns intermediários, D1 e Critério Intuitivo não selecionam o
baseline. Tremble e quóruns intermediários exigem contrato e GO próprios. D1 e
Critério Intuitivo podem ser diagnósticos rotulados no ledger de um nó já
autorizado, sem reescrever a correspondência baseline.

## 4. Continuação completa e correspondência conjunta

Cada artefato `A_g` referencia uma visão completa, consumível e presa por hash
da correspondência relevante de `C_g`. Essa visão não é copiada integralmente
para consumidores posteriores: ela recebe `complete_view_id`, caminho, hash e
schema, e os consumidores citam essa referência.

Cada assessment de `A_g` contém

```text
kappa_g: H_g^R -> R_g^C,
```

onde `H_g^R` é o conjunto de histórias públicas rejeitadas e `R_g^C` contém
elementos literais completos da continuação. `kappa_g` é pública, comum aos
tipos compatíveis e Borel-mensurável. Para cada história, devolve exatamente um
membro completo, identificado por family record, binding/selector de membro e
hash externo.

Estratégias internas, crenças, payoffs, outcomes, datas e proveniência desse
membro permanecem juntos. Payoff escalar ou ID desacompanhado do binding não é
continuação. Histórias distintas podem selecionar membros distintos. Se uma
compressão por posterior ou outro estado suficiente for pretendida, ela exige
prova; não é presumida.

Correspondências infinitas usam family records simbólicos. Um único binder
atômico liga estratégia, crença, votos, `kappa_g`, payoffs e outcomes do mesmo
membro. É proibido combinar coordenadas de membros distintos. O conjunto
conjunto exato precede envelopes e imagens marginais.

## 5. Perguntas e ordem científica

### 5.1 Pacote privado obrigatório quando autorizado

O primeiro pacote matemático futuro responderá, sem antecipar resultados:

1. qual é a correspondência completa de `A_M`;
2. qual é a correspondência completa de `A_U`;
3. quais payoffs de `H` por tipo pertencem a cada membro;
4. qual é a imagem ex ante desses payoffs para o prior `nu`;
5. qual é o conjunto conjunto exato de comparações maioria–unanimidade;
6. quais afirmações são invariantes e quais dependem do membro selecionado.

Esses resultados formam `A_M`, `A_U` e `AC`. Todos permanecem `pending`.

### 5.2 Fase pública opcional

Somente depois do pacote privado revisado e de novo GO autoral poderá abrir
`AR`, que perguntará:

1. quais são os benchmarks quando o tipo é público antes da proposta;
2. quais rendas informacionais existem por regra e tipo;
3. quais contrastes entre regras existem;
4. se existe interação útil entre informação privada e agenda.

Nenhum desses objetos é condição para fechar o pacote privado ou migrar um
resultado privado autônomo para o paper. A decisão de abrir `AR` deve declarar
qual pergunta pública é substantivamente necessária; não há obrigação de
produzir todos os objetos apenas porque o schema os admite.

## 6. Schemas mínimos

Campos adicionais são permitidos somente quando necessários à prova ou à
interpretação. Ausência de campo não listado abaixo não é finding.

### 6.1 Coleção e célula

```text
collection_id
node_id
institution
domain
status
family_record_ids
source_complete_view_id
cells
proof_paths
```

Cada célula contém:

```text
cell_id
domain
status
family_record_ids
none_reason
proof_path
```

`status` é `exists` ou `none`. Célula `none` não contém payoff-sentinela nem
family record. Domínio, cobertura e exclusividade precisam de prova, mas não de
campos administrativos duplicados.

### 6.2 Visão completa externa

```text
complete_view_id
source_node_id
source_artifact_path
source_artifact_hash
domain
source_cells_and_family_schemas
payoff_and_outcome_coordinates
native_dates
status
proof_path
```

O mesmo ID e hash são citados por todos os consumidores. `AC` e `AR` não
reproduzem o payload completo.

### 6.3 Family record privado ou público

```text
family_record_id
institution
cell_id
parameter_domain
member_parameter_or_selector
member_generator
necessary_and_sufficient_membership_rule
strategy_by_type
weak_vote_strategy
belief_system
continuation_rule
payoff_by_type_and_identity
outcome_distribution
atomic_binder
source_ids_and_hashes
selection_status
refinement_status
payoff_date
proof_path
```

Uma família contínua permanece em um registro simbólico; não recebe uma linha
por membro. Singleton pode usar domínio degenerado. O mesmo binder determina
todas as coordenadas. Estratégias e crenças são completas em todas as histórias
factíveis.

### 6.4 Imagem ex ante e comparação privada

A imagem ex ante contém:

```text
image_id
source_family_record_id
source_atomic_binder
prior_and_type_weights
type_values_at_A
ex_ante_value_formula
exact_image_set
proof_path
```

Uma comparação em `AC` contém:

```text
comparison_id
common_domain
source_A_M_ids_and_hashes
source_A_U_ids_and_hashes
source_member_domains_and_binders
necessary_and_sufficient_compatibility_rule
source_value_transport_records
exact_joint_value_and_outcome_set_at_A
derived_envelopes
proof_path
```

`AC` cita fontes; não copia suas visões completas. O conjunto conjunto exato é
primário. Envelope é apenas projeção e nunca produto de intervalos marginais.

### 6.5 Fase pública opcional

Se `AR` for autorizado, equilíbrios públicos com agenda usam o mesmo family
record da Seção 6.3, com `public_type`. Cada benchmark, renda ou interação cita
a tupla completa de IDs, hashes, binders, valores nativos, datas, fatores de
transporte e valores em `A`. Objeto que exija uma fonte inexistente recebe
`status=none`, sem apagar objetos independentes existentes.

### 6.6 Ledger mínimo

Cada nó mantém seu próprio ledger com uma linha de cabeçalho:

```text
claim_id
node_id
cell_id
record_or_family_id
member_domain
claim_kind
claim_text
domain
status
selection_status
assumptions_used
source_record_ids
source_hashes
payoff_date
evidence_path
proof_path
```

Status permitidos:

```text
proved
checked numerically
conjecture
pending
rejected
```

`claim_kind` usa `substantive`, `D1`, `intuitive_criterion`, `integration` ou
`coverage`. No Gate 0, cada ledger contém apenas o cabeçalho.

## 7. DAG e ciclo de vida

O manifesto é
`model_redesign/agenda_extension_game_dag_simplified.json`. Ele contém os quatro nós
`A_M`, `A_U`, `AC` e `AR`; `AR` é opcional. As arestas são:

```text
C_M -> A_M
C_U -> A_U
A_M -> AC
A_U -> AC
AC -> AR
N7_public -> AR
```

Enquanto um nó está pendente, contém apenas `status=pending` além de sua
estrutura. Ao passar, pode acrescentar somente:

```text
status=pass
artifact_path
artifact_hash
dependency_hashes
review_paths
```

Não existem `started_order`, `passed_order`, `frozen` redundante nem reviews
inteiros embutidos no DAG. Os pareceres ficam em arquivos próprios e citam o
hash coberto. Atualizar apenas esses campos previstos não reabre o Gate 0.

## 8. Limite do verifier e do harness

O futuro Goal 1 poderá construir um verificador de estrutura e um harness de
falsificação. O código poderá:

1. conferir caminhos e hashes;
2. validar JSON/TSV e os schemas mínimos;
3. conferir namespace, nós, arestas e aciclicidade;
4. conferir quotas e a transição de cada vetor de votos em casos finitos;
5. conferir datas, fatores de transporte e uma única aplicação de `beta`;
6. rejeitar payoff-sentinela, fonte inexistente, hash autorreferente e campo
   obrigatório ausente;
7. conferir que IDs e binders usados conjuntamente coincidem;
8. conferir que cada claim cita fonte, evidência ou prova quando exigida;
9. testar identidades algébricas fornecidas, casos finitos e negativos
   representativos;
10. produzir relatório explícito de PASS/FAIL para essas propriedades.

O código **não poderá alegar** que provou:

1. existência ou completude de PBE;
2. ausência de desvio lucrativo contra todo `Y`;
3. otimalidade em todo suporte de uma estratégia mista;
4. existência de limite local de Bayes em todos os pontos disciplinados;
5. totalidade ou mensurabilidade de uma função simbólica arbitrária;
6. necessidade e suficiência de um member generator;
7. cobertura de todas as famílias de equilíbrio;
8. invariância de um resultado sobre uma família contínua.

Para esses itens, o verifier confere apenas que a prova e o hash correspondentes
existem e que testes fornecidos não os contradizem. Prova e revisão humana são
a autoridade substantiva.

O Goal 1 não pode derivar `A_M`, `A_U`, `AC` ou `AR`, preencher ledgers com
resultados, adaptar interface congelada nem chamar teste numérico de prova.

## 9. Obrigações matemáticas

Quando o pacote privado for autorizado, as provas e revisões deverão verificar:

1. estratégia completa em toda história factível;
2. racionalidade sequencial dos votos;
3. ausência de desvio lucrativo de cada tipo de `H` sobre todo `Y`;
4. consistência das crenças com a Seção 3;
5. `kappa_g` total, unívoca, pública, comum aos tipos e mensurável;
6. seleção de membro literal completo da continuação;
7. necessidade e suficiência do family record e cobertura das células;
8. correspondência completa sem seleção ou simetria não autorizada;
9. mesmo binder em estratégia, crença, continuação, payoff e outcome;
10. conjunto conjunto exato antes de envelopes;
11. valores condicionados ao tipo antes de expectativas;
12. datas comuns e aplicação única de `beta`.

Essas obrigações pertencem às derivações e aos pareceres, não ao código.

## 10. Gates simplificados

### 10.1 Gate 0

Este candidato só pode ser aprovado depois de dois pareceres independentes
`read-only` sobre os mesmos hashes:

1. um parecer adversarial de proporcionalidade e executabilidade;
2. um parecer formal/game-theoretic que confirme preservação integral do jogo,
   do conceito de solução e da correspondência conjunta.

Implementador não revisa; revisor não edita. Finding substantivo retorna ao
autor. Mudança de bytes exige novos pareceres nos novos hashes. PASS técnico
não substitui aprovação autoral.

### 10.2 Goal 1 — infraestrutura mínima

Somente após aprovação do Gate 0 e GO próprio, o Goal 1 poderá:

1. fixar hashes das interfaces externas;
2. demonstrar sua consumibilidade sem editá-las;
3. implementar somente o verifier e harness da Seção 8;
4. receber uma revisão independente de código e escopo;
5. parar se campo ou interface indispensável estiver ausente.

Fechar Goal 1 não autoriza derivação.

### 10.3 Pacote privado — autorização única futura

Depois de Goal 1 fechado, um único GO autoral poderá abrir, em sequência:

1. `A_M`;
2. `A_U`, com reconstrução cega sem receber fórmulas candidatas;
3. `AC`, como integração por referências e hashes.

Não há GO nem freeze intermediário obrigatório entre os três nós. O pacote
inteiro só passa com dois pareceres independentes sobre seus hashes finais; um
deles deve incluir a reconstrução cega de `A_U`. Qualquer mudança matemática
reabre apenas o artefato afetado e seus consumidores.

### 10.4 Fase pública opcional

`AR` só abre depois do pacote privado revisado e de GO autoral que identifique
a pergunta pública necessária. A autorização pode limitar `AR` a benchmark,
renda ou interação específica. O pacote público autorizado recebe dois
pareceres independentes sobre seus hashes finais.

### 10.5 Migração

Migração para `formal_model_v6.Rmd` exige GO separado, matriz que ligue claims
a IDs e hashes aprovados, compilação e duas revisões independentes do
manuscrito final. Resultado privado autônomo pode migrar sem `AR`; nenhuma frase
sobre benchmark público, renda ou interação pode migrar sem o `AR`
correspondente.

## 11. Invalidação e preservação

Reabre o Gate 0 qualquer mudança em jogadores, tipos, ações, informação,
factibilidade, votação, implementação, payoffs, datas, crenças baseline,
continuação, correspondência conjunta, atomicidade, schemas mínimos, topologia
ou protocolo de revisão.

Não reabre o Gate 0:

- atualização exclusiva dos campos de ciclo de vida previstos no DAG;
- novo parecer ou registro autoral que apenas cite hashes existentes;
- cálculo de hash corrente de interface externa no Goal 1;
- abertura opcional de `AR` dentro do schema já aprovado.

Cascatas:

- mudança de `C_M` invalida `A_M`, `AC` e consumidores;
- mudança de `C_U` invalida `A_U`, `AC` e consumidores;
- mudança de `A_M` ou `A_U` invalida `AC`;
- mudança de `AC` invalida `AR` e consumidores que o usem;
- mudança de continuação pública invalida apenas `AR` e seus consumidores.

Conteúdo antigo não é apagado, mas nenhum consumidor pode tratá-lo como coberto
por parecer sobre hash diferente.

## 12. Estado e próxima fronteira

Este documento é um candidato simplificado, não aprovado. Nenhum nó saiu de
`pending`. Goal 1, derivações, cálculos e manuscrito continuam não autorizados.

A próxima ação autorizada é exclusivamente a auditoria adversarial solicitada
pelo autor, seguida de relato. Aprovação do Gate 0 e abertura de Goal 1 exigem
decisões autorais posteriores e separadas.
