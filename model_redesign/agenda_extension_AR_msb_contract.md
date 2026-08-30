# Contrato de `A_R` sob M/S/B — benchmark público, rendas e interação

**Data:** 2026-08-30  
**Nó:** `A_R`  
**Status:** `AUTHORIZED / IMPLEMENTER CANDIDATE / UNREVIEWED / UNFROZEN`  
**Orientação institucional:** unanimidade menos maioria, `U-M`

## 1. Autoridade e pergunta

O autor abriu `A_R` com a decisão literal “Ok. Faça A_R”, registrada em
`quality_reports/plans/2026-08-30_autorizacao_inicio_A_R.md`, SHA-256
`0bc58b63f05de25ad9ef134dbf0fdf02d3ca2e4c50c0fd1b9627d6f0eced5e09`.

O nó responde, nessa ordem:

1. quais são as correspondências de PBE quando o tipo de `H` é público antes da proposta de agenda;
2. quanto cada tipo ganha ou perde por a informação permanecer privada, em cada regra;
3. qual é a diferença `U-M` dessas rendas;
4. como agenda altera as rendas do benchmark sem agenda de `N7`.

Não há autorização para manuscrito, tag, merge ou push.

## 2. Fontes congeladas

`A_R` consome somente:

| Fonte | Artefato | SHA-256 | Status |
|---|---|---|---|
| comparação privada | `model_redesign/agenda_extension_AC_msb_interface.json` | `ea869c023ce7426dae3b92ffad344b4c79f1f0ce220b8fffaceb011904a85249` | `A_C pass/frozen` |
| resultados privados | `model_redesign/agenda_extension_AC_msb_results.md` | `8cadee000f6b8a9f94aff754fdb680f427b731bccf121ae642126a9383693d0a` | `A_C pass/frozen` |
| autoridade terminal de `A_C` | `quality_reports/2026-08-30_A_C_msb_strengthened_terminal_approval_and_freeze.md` | `b331f88b7abb99c03a5a8c657d163d1e006c0cf4cb51e744abcee298ac6af557` | `pass/frozen` |
| manifesto final de `A_C` | `quality_reports/2026-08-30_A_C_msb_strengthened_final_gate_manifest.sha256` | `332d1d7be7a7b38f715c8d7d872c6f7010c22a27fc924b91e8f694199a190fe4` | `20/20` |
| benchmark público sem agenda | `model_redesign/essential_input_n7_complete_information_benchmark_candidate.json` | `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45` | `N7 pass/frozen` |
| autoridade terminal de `N7` | `quality_reports/2026-08-21_fechamento_autoral_goal4_n7.md` | `ca7a842b3a953ab16e76dbf518692a0d05a87d1224093a53d4ccc647624545d2` | `pass/frozen` |

O contrato simplificado aprovado e a emenda M/S/B continuam governantes. Nenhum arquivo congelado é alterado ou reinterpretado.

O DAG governante continua sendo o DAG canônico de Gate 0,
`model_redesign/agenda_extension_game_dag_simplified.json`, SHA-256
`a2572dc8954d63535d4edcbf04158e9524d11ed4537a822713e534df580ee9e0`.
Ele é citado somente como topologia e proveniência imutáveis; seu lifecycle
histórico `pending` não é reescrito por `A_R`. Não existe um segundo DAG de
`A_R`.

## 3. Domínio comum e datas

Fixe

```text
d=(N,m,q,k,c,beta,o_0,o_1,y_bar,Y,nu),
m=N-1>=3,
q=floor(N/2)+1,
k=q-1=floor(N/2),
c=m-k,
0<beta<1,
0<o_0<o_1<1,
o_1<=y_bar<=1,
nu in [0,1].
```

O estágio de agenda `A` está na data 0. Se a proposta falha, o jogo entra em `R1` de `N7`; por isso, cada payoff nativo de `R1` é multiplicado por `beta` exatamente uma vez. Todos os payoffs privados importados de `A_C` já estão na data `A`; subtrair o benchmark público aplica zero fatores adicionais de `beta`.

## 4. Informação e solução no jogo público

Para cada `theta in {0,1}`, o tipo é anunciado publicamente antes de `H` propor. A crença é degenerada em `theta` em toda história; não há sinalização nem crença livre.

O conceito é o já aprovado:

- PBE;
- votos fracos puros e as-if-pivotal;
- `T^Y`: voto sim em indiferença esperada;
- M/S/B na continuação.

Em particular, uma rejeição seleciona em `N7` a classe anônima simétrica, com representante literal canônico dado pela loteria uniforme sobre reconhecimento e coalizões. Essa seleção afeta o preço de continuação de cada Estado fraco. Ela não impõe simetria à proposta corrente de `H`: sob maioria, toda loteria de `H` sobre coalizões mínimas ótimas deve ser preservada.

## 5. Objetos públicos primários

Para `o=o_theta`, defina o payoff público de `H` em `R1` sob maioria:

```text
p_M(o)=beta*o,  se o<=1/m,
p_M(o)=o,       se o>1/m.
```

A igualdade pertence à inclusão, conforme `N7`. Sob unanimidade,

```text
p_U(o)=beta*o.
```

Pela continuação anônima de M/S, cada Estado fraco tem valor nativo de `R1`

```text
w_M(o)=(1-beta*o)/m, se o<=1/m,
w_M(o)=1/m,          se o>1/m,
w_U(o)=(1-beta*o)/m.
```

A segunda linha é importante: quando a maioria exclui `H`, o payoff externo
`o` de `H` não sai da unidade repartida pelos fracos. Portanto, nesse ramo,
`w_M(o)` não é `(1-o)/m`.

Na data `A`, seus limiares de voto são

```text
r_M(o)=beta*w_M(o),
r_U(o)=beta*w_U(o).
```

Denote por `P_g^theta(d)` o conjunto de binders completos do jogo público de agenda sob a regra `g`. A camada exata preserva proposta, loteria de coalizão, votos em toda proposta e o binder literal da continuação. A camada econômica preserva payoff de `H`, probabilidade de acordo/atraso e lei anônima do resultado realizado.

Os family records públicos completos e as tuplas completas de benchmark,
renda, contraste e interação são materializados em
`model_redesign/agenda_extension_AR_msb_complete_records.json`. A interface
principal rotula seus objetos abreviados como resumos econômicos e fixa esse
export completo por hash externo; o próprio export não contém hash de si
mesmo.

## 6. Binders de renda de agenda

Na fibra privada comum `eta` de `A_C`, tome `(R_M,R_U) in J_AC^bind(d,eta)` e, separadamente, um binder público de cada tipo e regra. Não se presume realização aleatória comum entre jogos contrafactuais.

Para `g in {M,U}` e `theta in {0,1}`, defina

```text
RI_g^{A,theta}(R_g)=V_g^theta(R_g)-h_g(o_theta),
RI_g^{A,E}=(1-nu)RI_g^{A,0}+nu*RI_g^{A,1}.
```

`h_g` é o payoff público derivado no próprio `A_R`. O vetor por tipo sempre vem do mesmo binder privado; as coordenadas não podem ser recombinadas a partir de marginais distintas.

A diferença institucional de renda é

```text
DeltaRI_A^theta=RI_U^{A,theta}-RI_M^{A,theta},
DeltaRI_A^E=(1-nu)DeltaRI_A^0+nu*DeltaRI_A^1.
```

Se `A_C` é `none` na fibra, a comparação de rendas é `none`; não se cria payoff-sentinela.

## 7. Interação agenda × informação

Seja `RI_g^{N,R1,theta}` a renda informacional sem agenda já congelada em
`N7`, na data nativa de `R1`. Antes da comparação, transporte-a para `A`:

```text
RI_g^{N,A,theta}=beta*RI_g^{N,R1,theta},
I_g^theta=RI_g^{A,theta}-RI_g^{N,A,theta},
DeltaI^theta=DeltaRI_A^theta-beta*DeltaRI_N^{R1,theta}.
```

Esse `beta` é o único transporte de `R1` para `A` no ramo sem agenda. Ele não
é um novo desconto aplicado às rendas de agenda ou aos valores privados de
`A_C`, que já chegam em `A`.

Os conjuntos exatos são formados por produtos de binders completos nas mesmas primitivas. Não se introduz acoplamento cross-world, sorteio comum ou selector. Se qualquer fonte necessária é `none`, o objeto composto correspondente é `none`, enquanto as fontes existentes permanecem registradas.

## 8. Fatorização em duas camadas

Primeiro formam-se os binders exatos públicos e os produtos exatos de fontes. Depois, para as operações declaradas — payoffs de `H`, acordo/atraso e leis anônimas — prova-se a fatorização mensurável pelos resumos econômicos completos das fontes.

As propostas nomeadas e loterias de coalizão de maioria pertencem à assinatura exata. Elas podem variar sem alterar o payoff público de `H` ou a renda econômica. Nenhum baricentro de Reynolds é promovido a assessment ou representante.

## 9. Escopo da prova mecânica e revisão

O verificador pode conferir hashes, schemas, o DAG canônico, family records,
tuplas derivadas, enum do ledger, identidades algébricas, desigualdades e
partições em grades finitas. Ele não prova completude de PBE, mensurabilidade
abstrata, fatorização setwise universal ou inexistência de desvios fora das
provas textuais.

O candidato permanece `unreviewed/unfrozen` até duas revisões independentes sobre os mesmos bytes, adjudicação e aprovação autoral terminal.

## 10. Invalidação

Mudança em `A_C`, `N7`, M/S/B, quota, data dos payoffs, convenção de igualdade, domínio comum ou operação de interação invalida `A_R`. `A_R` não altera retroativamente nenhuma fonte.
