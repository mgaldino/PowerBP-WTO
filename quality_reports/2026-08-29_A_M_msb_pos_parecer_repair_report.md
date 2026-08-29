# Relatório do passe de reparo de `A_M` pós-parecer externo

**Data:** 2026-08-29

**Status:** `IMPLEMENTER REPAIR COMPLETE — FRESH FORMAL REVIEWS PENDING`

**Natureza:** relatório de implementação e rastreabilidade. Não é parecer
formal, não aprova as provas reparadas e não conta como uma das duas revisões
matemáticas independentes ainda exigidas.

## 1. Identidade do passe e escopo

O snapshot substantivo pré-reparo é
`6fa852c52cd3a277735697b78a42d5f1774c6320`. A abertura operacional da
sessão ocorreu em `bfd149898cdf1915b453f95d7d4401c4d2de5682`, que apenas
importou a clarificação, as decisões, a consulta externa e o prompt deste
passe. O commit substantivo reparado é
`b2b7a34a2a320a5696f57ed8533495ffe3f4e6b6`.

Arquivos do pacote alterados ou acrescentados no commit substantivo:

1. `model_redesign/agenda_extension_A_M_msb_results.md`;
2. `model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv`;
3. `scripts/verify_agenda_extension_A_M_msb.R`;
4. `quality_reports/verification_outputs/2026-08-29_A_M_msb_verifier_output.txt`;
5. `quality_reports/adjudication/a_m_msb_pos_parecer/bd395ab2d182/adjudication_round1.md`;
6. `quality_reports/adjudication/a_m_msb_pos_parecer/bd395ab2d182/adjudication_round1.json`.

Este relatório e o manifesto SHA-256 são metadados de fechamento posteriores
ao commit substantivo. Não foram alterados `A_U`, `AC`, `AR`, N1–N7,
`formal_model_v6.Rmd`, `formal_model_v6.pdf`, a tag
`v6-essential-input-2026-08-25` nem snapshots históricos.

## 2. Preflight normativo e adjudicação

Os quatro hashes governantes foram conferidos antes e depois da implementação:

| Documento | SHA-256 conferido |
|---|---|
| Emenda M/S/B aprovada | `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b` |
| Clarificação de anonimato e kernel uniforme | `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3` |
| Decisões pós-parecer aprovadas | `3000a25c89510f3e0ea471d4406c0c59282f41fd07662b5c077fa81f281e1471` |
| Consulta técnica externa não formal | `d4928d7cf90ae01b37848d43b6d38d32498332822b1f73d955eebb7f1dabc47c` |

A interface congelada de N3 continuou em
`ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`.

Antes de editar o pacote, uma agente independente adjudicou os achados da
consulta contra os bytes pré-reparo e os documentos aprovados. O resultado foi
`READY_FOR_IMPLEMENTATION`: 16 registros, sendo 10 `CONFIRMED` e 6
`PARTIAL`, sem `REFUTED` ou `UNRESOLVED`. Esse rótulo apenas autorizou
correções locais; não é PASS matemático. O JSON passou no schema do
`adjudicate-review` contra o packet de SHA-256
`bd395ab2d1824b660e72ad53fce6efb574484272bcaf40840771386fb2f7b867`.

## 3. Mapa achado → reparo → evidência

| Finding adjudicado | Reparo aplicado | Arquivo/trecho |
|---|---|---|
| `WEB-I01-BAYES-LOCAL` | Bolas euclidianas relativas, razão local pointwise, inadmissibilidade quando o limite falha, constância fora do suporte, Besicovitch e estatuto de disciplina adicional ao PBE. | resultados, Seção 2.1 |
| `WEB-I02-THEOREM4-WELLFORMED` | `sigma_theta in P(Y)`; `rho` e `nu_off` dentro de `R`; espaços de chegada e Borelidade de `pi,a,u_0,u_1` definidos/provados. | resultados, Seções 8.1–8.2; `AMX-015` |
| `WEB-I03-DOWNSTREAM-SIGNATURE` | `Gamma_theta` passa a ser a lei conjunta de sinal, posterior, acordo, seleção e outcome terminal; resumos são marginais/integrais vinculados; `AC` futuro usa a mesma fibra `rho`. | resultados, Seções 9–9.3; `AMX-016` |
| `WEB-I04-UNIFORM-VERSUS-CYCLE` | Kernel selecionado é literalmente uniforme; ciclo ficou apenas como cálculo de payoffs interinos e não entra em `X_M` nem na assinatura. | resultados, Seções 3.2–3.3; `AMX-MSB-001` |
| `WEB-I05-THEOREM6-OVERCLAIM` | Enunciado estreitado à cardinalidade: uma fibra pode ser incontável e nenhuma lista finita basta; nenhuma negação de parametrização finita. | resultados, Seção 9.4; `AMX-MSB-009` |
| `WEB-M01-OFFSUPPORT-SUPREMUM-ORDER` | Lema do suporte finito antecipado antes da classificação pura, com complemento denso, aproximação por `epsilon_n` e contínuo de rejeições. | resultados, abertura da Seção 6 |
| `WEB-M02-RESIDUAL-EP` | Empate residual tratado pela mesma combinação convexa em payoff e kernel, vinculada a `chi`. | resultados, Seções 7.1 e 8.2; verificador |
| `WEB-M03-FEASIBILITY-BOUNDS` | Prova ramo a ramo de `0<r_chi(mu)<=beta/m` e `k r_chi(mu)<1`. | resultados, Seção 4; verificador |
| `WEB-M04-FINDING1-CALCULATIONS` | Valores `D_0(0)=.081`, `D_1(0)=.729`, `O_0=.5905` e `O_1=.729` explicitados. | resultados, Seção 5.1; verificador |
| `WEB-M05-BOUNDARY-MIXTURES` | Medidas `sigma_0,sigma_1` e posteriores escritos para `o_1=T` e `o_0=T<o_1`; endpoints tratados diretamente. | resultados, Seções 5.2, 6.4, 9.2 e 10; verificador |
| `WEB-M06-HISTORICAL-SELFCONTAINMENT` | AMX-009 ganhou `A_min`, `M_E` e `Zbar_E`; AMX-NEG-001 foi declarado lema histórico importado, sem falsa revalidação autocontida. | resultados, Seções 11–12; ledger |
| `WEB-C01-AMX-009` | Claim reenunciado com o antigo intervalo e sua subfamília globalmente constante definidos exatamente; transporte corrente limitado ao representante uniforme. | ledger `AMX-009`; resultados, Seção 11 |
| `WEB-C02-AMX-015` | Iff misto agora usa tupla bem tipada, Bayes pointwise, mapas Borel, kernel literal e supremo off-support exato. | ledger `AMX-015`; resultados, Seção 8 |
| `WEB-C03-AMX-MSB-009` | Claim e título agora dizem apenas incontabilidade/ausência de lista finita; o antigo exemplo por identidades foi removido como fundamento. | ledger `AMX-MSB-009`; resultados, Seção 9.4 |
| `WEB-C04-AMX-016` | Assinatura inclui `rho,nu_off` e a dupla `Gamma` anonimizada; endpoints usam fibra `*` e `AC` futuro é produto fibrado. | ledger `AMX-016`; resultados, Seções 9–9.3 |
| `WEB-C05-AMX-NEG-001` | Estatuto alterado para `imported historical lemma`, com caminho/hash da prova original e limite explícito do verificador atual. | ledger `AMX-NEG-001`; resultados, Seção 12 |

## 4. Decisões autorais implementadas

### 4.1 `rho` como coordenada, não refinamento fixo

Para prior interior,

```text
nu_off=b_rho(nu)=nu*rho/(1-nu+nu*rho),
rho in [0,infinity].
```

O mapa é uma reparametrização bijetiva das crenças off-support permitidas. O
texto inclui `rho=1` como benchmark passivo, os limites `0/infinity`, as
convenções de suporte nos priors degenerados e a interpretação por lapses com
suporte pleno comum. Também preserva a ressalva mandatória: lapses
racionalizam crenças sobre sinais, não consistência sequencial do assessment
completo.

A quantificação de existência ficou explícita:

```text
para toda primitiva existe algum rho e algum PBE;
não: para toda primitiva e todo rho existe PBE.
```

A sensibilidade mantém `chi` fixa. O exemplo
`N=3,beta=.9,o_0=.04,o_1=.73,nu=.05` produz a região desconexa
`{0} uniao (78.66,infinity]` para a classe baixo-acorda/alto-atrasa e mostra
por que monotonicidade de `b_rho` não implica monotonicidade da classe.

### 4.2 Lei conjunta e payoff fraco por tipo

`Gamma_theta` é definida no espaço terminal disjunto
`({A}xY) uniao_disjunta ({D}xOmega_D)`. A fórmula usa o kernel da continuação
condicional ao tipo. Isso também corrige um erro detectado na QA de integração:
`r_chi(pi(y))` é preço/interim payoff bayesiano e não pode substituir o payoff
fraco condicionado ao tipo em `W_j^theta`. Agora `W_j^theta` integra o payoff
terminal sob `K^D_{theta,chi(pi(y))}`; apenas a média ex ante sob `lambda`
colapsa para `r_chi(pi(y))`.

### 4.3 Anonimato sem simetria comportamental

Estratégias de proposta de `H` continuam podendo discriminar identidades. O
conjunto de PBEs foi provado fechado sob permutações dos fracos. A assinatura
usa o operador de Reynolds sobre a dupla inteira:

```text
Anon(Gamma_0,Gamma_1)
 =|G|^{-1} sum_g (g#Gamma_0,g#Gamma_1).
```

O mesmo `g` atua nos dois tipos e em proposta, votos e outcome terminal. A
média remove pesos estéreis dentro da órbita, mas preserva posterior e
revelação; portanto pooling e separação por coalizões distintas no
`z_0=z_1` continuam diferentes. O representante simétrico é um objeto de
assinatura, não uma alegação de convexidade ou de que a média das estratégias
é PBE.

### 4.4 IC/D1 permanece fora

`IC/D1-BENCHMARK` foi registrado como `PENDING / NONBLOCKING`. Ele exigirá
uma derivação própria e a decisão sobre incluir `chi` entre as respostas dos
receptores. Nenhuma crença de forward induction foi imposta silenciosamente à
Cláusula B.

## 5. Verificação mecânica e QA

O verificador pré-reparo reproduzido pela adjudicação tinha
`2891 PASS / 0 FAIL`. O script reparado acrescentou testes para:

- mapa/inversa/extremos de `rho`;
- cutoffs `SP/SE/EP` e a região desconexa;
- classes puras robustas a todo `rho` quando `E` é único;
- limites de factibilidade;
- valores off-path do Finding 1;
- convexidade `E/P`;
- misturas de fronteira;
- invariância e média de grupo;
- payoffs fracos condicionados ao tipo;
- família atomless cardinal;
- definição do intervalo histórico.

Execução preservada:

```text
env LC_ALL=C LANG=C Rscript scripts/verify_agenda_extension_A_M_msb.R
SUMMARY | 3944 PASS | 0 FAIL
```

Hashes da evidência:

| Artefato | SHA-256 |
|---|---|
| resultados reparados | `020ffbb1d67daaabf9a330be1f0f3ea91d42b55e3b7047787a8c8eb06f6912ed` |
| ledger reparado | `56073462c367277a1863d2a4eeb817e49c57845b4cd0f04c404ff57bfc4b38e1` |
| script | `0e460d286b2647ef5ed17485339ad69e3e332346494e22b9ffdca362b7c7374f` |
| output preservado | `13716a16506c68e9153617194c71ccd608f6ccc3a2911ba87167ee17705f4ecb` |
| adjudicação Markdown | `dfea1bb1e476678b770112b371e3213286a6228a934868cc667e7bb0245ed664` |
| adjudicação JSON | `44c27cba2ee237c3de395b8766133dc0b6487933c45886e7dae40498d176b177` |

Checagens adicionais no commit substantivo:

- `git diff --check`: limpo;
- ledger: 16 colunas em todas as linhas;
- Markdown: fences balanceados;
- adjudicação JSON: `VALID`;
- verificador: exit status zero;
- QA consultiva independente: nenhum problema material restante depois de
  corrigir `W_j^theta`, anonimização por Reynolds e o caso `ell=0`.

O aumento de 2891 para 3944 PASS significa cobertura mecânica ampliada, não
prova matemática adicional. O script não prova existência/completude de PBE,
Bayes pointwise, Borelidade ou os teoremas de lei conjunta.

## 6. Resultado e limites do fechamento

O pacote está pronto como **candidato reparado do implementador**. Em
particular:

1. AMX-014–016 foram reenunciados nos objetos aprovados;
2. AMX-MSB-009 agora é somente cardinal;
3. AMX-009 e AMX-NEG-001 têm estatuto histórico auditável;
4. AMX-013 é reproduzível por script e output versionados;
5. a interface futura proíbe recombinação entre fibras `rho`.

Ainda faltam dois pareceres formais independentes, em sessões novas e sobre os
mesmos bytes fixados pelo manifesto. Até ambos fecharem e houver a decisão
autoral subsequente:

- estes claims não são `pass/frozen`;
- `AC` e `AR` não podem consumir `A_M`;
- `A_U` continua pendente de auditoria própria;
- não há tag, merge ou alteração do baseline/manuscrito.
