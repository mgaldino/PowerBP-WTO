# Adjudicação independente dos pareceres formais de `A_U` sob M/S/B — rodada 1

## 1. Identidade do artefato e das normas governantes

Esta adjudicação cobre exclusivamente o snapshot abaixo, em modo read-only quanto ao candidato:

| Item | Identidade conferida |
|---|---|
| Worktree | `/private/tmp/PBP-am-msb` |
| Branch | `agenda-extension-am-msb` |
| `HEAD` | `b59ce1bf5b5ee7b57707684de92c38d4fa325b30` |
| Artefato adjudicado | `model_redesign/agenda_extension_A_U_msb_results.md` |
| SHA-256 do artefato | `fefe77fe0dcd86941ed41ed5cd13ff22323ffb2e12221db5e2d91604de7774fc` |
| Manifesto final do implementador | `quality_reports/2026-08-29_A_U_msb_final_implementer_manifest.sha256` |
| SHA-256 do manifesto | `f95322c800e113ac74dbf8d378d7a329b9e6a06cb27e7e016c0a1c6322d2be81` |
| Checagem do manifesto | `shasum -a 256 -c`: 26/26 entradas `OK` |
| Contrato candidato em Markdown | `model_redesign/agenda_extension_A_U_msb_contract.md`, SHA-256 `4136d897d3606a5cec926247d1dc57e60a90e83344a5c19efbef8dd789d97a57` |
| Interface | `model_redesign/agenda_extension_A_U_msb_interface.json`, SHA-256 `ee9582805b17562d5b1e2bb9e511eca7984ae2fd3379d94667b8464c50932410` |
| Ledger | `model_redesign/agenda_extension_A_U_msb_claim_ledger.tsv`, SHA-256 `e2d7b0f19429bf7149b7e2ba0afd998469004b5dad23e1b8a7330aec6a8bd03b` |

As normas pinadas pelo manifesto também foram conferidas diretamente: Gate 0 simplificado (`fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4`), emenda M/S/B (`8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b`), clarificação autoral de assinatura/anonimato (`6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3`) e decisão de duas camadas explicitamente limitada a `A_M` (`cd9650715442dc0beae2fa6af450c509c0ad871d51dc5d54b0a6a826d1fc86e8`). O membro congelado `C_U` permaneceu no hash `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`.

Não existe um argument-contract JSON separado compatível com o validador da skill. O contrato candidato acima é Markdown e foi lido e hasheado diretamente, mas não foi fingido como argument-contract JSON. Por isso, no record autoritativo, `contract.required=false`, os campos opcionais são `null` e `stale=false`; a validação é feita sem `--contract-file`.

## 2. Disposição executiva

**Veredito: `BLOCKED`.** O finding `R2-I-1` é **CONFIRMED**, com severidade `important`, estritamente na arquitetura da equivalência e da interface downstream. O candidato define a classe exata como a órbita do binder sob uma permutação comum e declara que misturas sobre relabelings não são automaticamente o mesmo assessment. A clarificação geral aprovada determina expressamente que essas misturas pertençam à mesma classe; a decisão posterior que autoriza a órbita diagonal exata como camada formal está circunscrita a `A_M`.

O finding não derruba a solução estratégica de `A_U`: forma extensiva, consumo literal de `C_U`, desconto, thresholds, Bayes local, famílias de PBE, endpoints, payoffs e preservação conjunta do binder sobreviveram à verificação adversarial. O bloqueio incide sobre `AUX-MSB-023`, a parte relevante de `AUX-MSB-024`, a relação de equivalência e seu default downstream. Não há patch técnico único: a continuação exige decisão autoral específica para `A_U`.

## 3. Pareceres adjudicados

| Fonte | SHA-256 | Independência e snapshot | Resultado declarado | Disposição nesta adjudicação |
|---|---|---|---|---|
| `R1` — `quality_reports/2026-08-29_A_U_msb_formal_review_1.md` | `36e1e092ff2135e5610b2d942a81b7955ed899702ae266986ca2c712659f380d` | Declara papel independente/read-only; cobre o mesmo `HEAD` e o mesmo manifesto; 576 linhas lidas integralmente | `PASS`, C/I/M `0/0/0` | Sua reconstrução estratégica e a prova de fechamento sob permutação comum são sustentadas; sua conclusão sobre a classe de assinatura omite as cláusulas explícitas de colapso de misturas e não refuta `R2-I-1` |
| `R2` — `quality_reports/2026-08-29_A_U_msb_formal_review_2.md` | `79a335f6557b4274786256011cc850fbf8dd81e606b43ef7f2d04d951aa4ea57` | Declara independência de `R1`, read-only e sem comunicação; cobre o mesmo `HEAD` e o mesmo manifesto; 373 linhas lidas integralmente | `FAIL`, C/I/M `0/1/0` | `R2-I-1` confirmado no escopo restrito da equivalência/interface; a matemática estratégica permanece separada e sustentada |

## 4. Teste de divergência não espúria

A divergência não decorre de bytes diferentes, truncamento ou cobertura desigual: ambos os pareceres identificam o mesmo `HEAD`, o mesmo manifesto de 26 artefatos e o mesmo conjunto governante. Também não foi decidida por contagem ou confiança dos revisores.

A leitura de `R1` nas linhas 430–454 estabelece corretamente que uma única permutação comum dos fracos age sobre o perfil inteiro, preserva o jogo e leva PBE a PBE; também acerta ao não importar `Lambda_x` ou `Sum_econ` de `A_M`. Isso prova que a ação e suas órbitas são objetos matemáticos válidos e que o binder exato deve ser preservado. Não prova, porém, que cada órbita seja toda a classe de assinatura de `A_U`. A clarificação geral, linhas 59–73 e 86–95, adiciona a instrução explícita de que misturas sobre a órbita ou sobre identidades formam uma única classe. Já a decisão de duas camadas, linhas 1–11 e 32–54, cria a equivalência formal por órbita exata apenas para `A_M`; seu processo ainda exige auditoria própria de `A_U` na linha 153.

O contraexemplo `P/Q` de `R2` foi recalculado independentemente. Com `N=3`, `m=2`, `beta=0.9`, `o_0=0.2`, `o_1=0.5` e `nu=0.6`, obtêm-se

```text
nu_star=0.375, a=0.369, b=0.2475, d=0.405,
z_L=0.262, z_H=0.505, Delta=-0.143.
```

As propostas relabeladas `P=(0.45,0.3025,0.2475)` e `Q=(0.45,0.2475,0.3025)` esgotam a pie, pagam ao menos `b` a ambos os fracos e dão `V=0.45>max{z_L,d}=0.405`. Pooling puro em qualquer uma e toda mistura comum `p delta_P+(1-p) delta_Q` preservam posterior `0.6`, aprovação e payoff. A órbita do candidato identifica apenas os pesos `p` e `1-p`; portanto não identifica, por exemplo, `p=0.9` e `p=0.5`, embora a clarificação mande colapsar essas misturas e não haja diferença de revelação. Esse teste confirma o conflito sem recorrer a Reynolds, recombinação de marginais ou consumo por `AC`.

O verificador oficial foi também reexecutado sobre os bytes manifestos e retornou `1095 PASS / 0 FAIL`. Ele permanece evidência mecânica finita e não prova completude de PBE, ausência de todos os desvios contínuos, existência pointwise de Bayes local ou totalidade Borel dos binders.

## 5. Finding adjudicado

| Finding | Tipo | Severidade | Status | Reparo |
|---|---|---|---|---|
| `R2-I-1` | `scope_or_consistency` | `important` | `CONFIRMED` | `owner_decision` |

### `R2-I-1` — a equivalência exata de `A_U` contradiz o colapso geral de misturas e não é autorizada pela decisão exclusiva de `A_M`

**Localizações do defeito:**

- `model_redesign/agenda_extension_A_U_msb_results.md:95-101` define as classes exatas como órbitas do binder e fixa essa camada como default de consumo;
- `model_redesign/agenda_extension_A_U_msb_results.md:335-337` afirma que misturas sobre relabelings não são automaticamente o mesmo assessment;
- `model_redesign/agenda_extension_A_U_msb_results.md:354-365` exporta binder/órbita como interface downstream;
- `model_redesign/agenda_extension_A_U_msb_interface.json:87-91` codifica a equivalência e o default exatos;
- `model_redesign/agenda_extension_A_U_msb_claim_ledger.tsv:24-25` marca `AUX-MSB-023` como provado e pressupõe a mesma arquitetura em `AUX-MSB-024`;
- `model_redesign/agenda_extension_A_U_msb_contract.md:126-128,160-171` diz que nenhuma compressão adicional é presumida e que nenhuma decisão adicional de assinatura foi imposta, deixando sem base a escolha posterior como regra completa de equivalência.

**Evidência governante:**

- `quality_reports/plans/2026-08-29_clarificacao_assinatura_anonimato.md:59-73,86-95,116-118` manda aplicar a mesma permutação ao perfil inteiro e, adicionalmente, coloca misturas sobre a órbita/identidades na mesma classe, preservando separadamente diferenças de revelação;
- `quality_reports/plans/2026-08-29_decisao_assinatura_duas_camadas_A_M.md:1-11,32-54,76-85,144-153` transforma a órbita diagonal exata em camada formal e relega o colapso de misturas ao resumo econômico, mas somente para `A_M`;
- o exemplo `P/Q` acima produz assessments no domínio de `A_U` que a regra do candidato separa e a clarificação geral identifica.

**Limite da confirmação:** preservar o binder atômico inteiro, `Gamma_0,Gamma_1` conjuntamente e a ação Borel de uma permutação comum continua correto e necessário. O candidato tampouco importou as construções específicas `Lambda_x` ou `Sum_econ` de `A_M`. O defeito confirmado é escolher a órbita como relação completa de equivalência de `A_U`, declarar as misturas distintas por default e exportar essa escolha como interface resolvida. Não há finding confirmado contra thresholds, payoffs, Bayes, famílias estratégicas, mensurabilidade do binder literal ou existência/exaustão no nível de assessments.

## 6. Decisões autorais, correções inseguras e limites

A clarificação geral e a circunscrição da decisão de duas camadas a `A_M` são decisões autorais já tomadas e foram tratadas como `held_decision`. Elas não autorizam o adjudicador a escolher a arquitetura específica de `A_U`.

Seria inseguro tanto aplicar silenciosamente a decisão exclusiva de `A_M` a `A_U` quanto apagar ou recombinar o binder exato para forçar um colapso. O reparo recebe `owner_decision`: requer decisão autoral específica para `A_U`, seguida de recorte coerente do contrato, resultados, interface, ledger, comparação/manifesto e nova revisão independente. Esta adjudicação não propõe nem implementa essa escolha.

O escopo termina em `A_U`. Não há promoção a `pass/frozen`, aprovação autoral, consumo por `AC`/`AR`, edição de manuscrito ou implementação.

## 7. Itens não resolvidos

Não há finding com status probatório `UNRESOLVED`: a existência e o escopo do conflito estão decididos pela evidência textual e pelo contraexemplo. Permanece, porém, um item material reservado ao autor — qual arquitetura de equivalência governará `A_U`. Enquanto essa decisão não existir, não há reparo seguro nem interface final autorizada, o que mantém o pacote bloqueado.

## 8. Veredito

`R2-I-1` é confirmado como defeito importante de fidelidade normativa e interface, sem contaminação da matemática estratégica. O artefato e os insumos estão íntegros, mas o finding não pode ser encaminhado como patch automático porque sua resolução exige decisão autoral.

ADJUDICATION_VERDICT: BLOCKED  
COUNTS: total=1; confirmed=1; partial=0; refuted=0; unresolved=0; held_decisions=1
