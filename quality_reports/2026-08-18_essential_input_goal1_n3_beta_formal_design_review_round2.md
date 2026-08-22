# Parecer independente — N3 beta<1, Round 2

- `reviewer_role`: `formal_design`
- `reviewer_id`: `review-n3-beta-formal-2026-08-18-r2`
- Contrato normativo: `sha256:2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- Dependência única N1: `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`
- Candidato N3: `sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee`
- Verifier N3: `sha256:932234025f671ee1ace5e20f77b0dda593febe70f20608c1ead6bacaddc2bda7`
- Derivação: `sha256:b0e5e69e5eb774c2bb13170f00752fe138882282d268b8172c9c39dff5fefdd5`
- Ledger: `sha256:7219ef5572ae1df2fab8b2e00f534f209b8fdda0b70283d08c74b245afbc3b22`

## Veredicto

**FAIL**

Contagens: **critical 0 / major 1 / minor 0**

## Auditoria substantiva do candidato

A rederivação integral confirma a matemática do candidato no hash examinado:

- N1 é a única continuação e entra em R1 exatamente uma vez por `w=beta/m` e `t_theta=beta*o_theta`.
- A IC dos weak nonproposers produz `sim` sse `x_j>=w`, com `T^Y` na igualdade.
- A IC completa de `H` preserva corretamente:

  - não pivotal: `sim -> y`, `não -> y+o_theta`;
  - pivotal: `sim` sse `y>=t_theta`;
  - falha inevitável: `T^Y -> sim`.

- `D=1-beta*q/m>0`; exclusão domina estritamente rejeição deliberada.
- P0, P1 e P1a procedem: não há slack selecionado nem aprovação sem `H` com `y>0`.
- A redução `E/S/P` é exaustiva. O ramo `R_i` permanece apenas na prova de desvios e endpoints.
- Screening mantém corretamente o delay do tipo alto quando `nu>0`.
- Cutoffs, igualdades `o_0=1/m` e `o_1=1/m`, tie-break de proposta, factibilidade e tipos de prior zero estão corretos.
- Crenças on-path, propostas e vetores de votos de massa zero, voto público de `H`, multiplicidade `F_i` identity-indexed, payoffs e outcomes são coerentes e atômicos.
- N3 permanece `pending/null`; N1 permanece `pass/frozen`; N2 não é consumido.

## Fechamento do finding do Round 1

O F1 anterior foi fechado para todos os casos exatos solicitados. Com a âncora integral desativada, o novo verifier rejeitou:

- `E` com `y>0`;
- `S=t_1`;
- `H_star=max`;
- `beta=1`, `D=0` e `R_i` selecionado;
- `F_i` concentrado em `R_i`;
- outcomes de passagem adulterados;
- `delay=0*I_D`;
- claims C01, C04 e C10 falsos;
- corrupção coordenada da interface e ledger;
- os três apêndices contraditórios literais;
- 87 caminhos nomeados da interface e 119 células do ledger.

## Finding exato

**[MAJOR F2]**

> “Com `check_exact_anchor=FALSE`, `validate_derivation` ainda aceita contradições materiais formuladas como paráfrases e inseridas no corpo da derivação antes da Seção 8. As verificações regionais controlam headings, fronteira terminal, algumas âncoras positivas e uma lista finita de frases proibidas; não controlam a identidade ou a semântica integral das seções substantivas depois que o hash/âncora externa é neutralizado.”

Foram aceitas, separadamente:

```text
Adendo falso: o fator de desconto pode assumir valor unitário no domínio principal.
Adendo falso: sob S, a recusa de theta=1 encerra a negociação na primeira rodada em vez de levar a N1.
Adendo falso: propostas da família R maximizam o payoff do proponente em algumas regiões.
Adendo falso: folga orçamentária integra A_i_star em um subconjunto do domínio.
```

Resultados observados:

```text
PARAPHRASE_ACCEPTED=TRUE  [quatro casos]
NEAR_INTERFACE_ACCEPTED=FALSE
NEAR_LEDGER_ACCEPTED=FALSE
```

A classificação é major porque as paráfrases negam `beta<1`, `D>0`, a exclusão de `R_i`/slack e a sobrevivência do delay de screening. O hash normal rejeita tais mudanças, mas o teste pedido exigia resistência sem essa âncora. Não realizei reparo.

## Execuções

- Verifier N3 nativo: PASS.
- Gate 0: PASS.
- Checker do DAG: `VALID`; prontidão topológica `N3, N4`, sem autorização para N4.
- `git diff --check`: PASS.
- Diff dos artefatos protegidos: vazio.
- Nenhum arquivo foi editado pelo revisor.
