# Adjudicação independente — `A_U` M/S/B em duas camadas, rodada 1

## 1. Identidade do artefato

Esta adjudicação cobre exclusivamente o pacote abaixo:

| Item | Identidade conferida |
|---|---|
| Worktree | `/private/tmp/PBP-am-msb` |
| Branch | `agenda-extension-am-msb` |
| `HEAD` revisado | `be482e329e34e6690211089363358c2399706e52` |
| Manifesto candidato | `quality_reports/2026-08-30_A_U_msb_two_layer_candidate_manifest.sha256` |
| SHA-256 do manifesto | `3cf2c047ad2da35665c21b47f94ca117482d7e7f537d9caa4e0ddce29ae7b369` |
| Verificação do manifesto | 16/16 entradas `OK` |
| DAG | `model_redesign/agenda_extension_A_U_msb_game_dag.json` |
| SHA-256 do DAG | `772ad71235597391726908b9e9864b9625f4b4dc8fcfa6e1d286630b242a73c7` |
| Commit substantivo | `b56085c436eb629c335764eb982d174e5cc2d392` |

O manifesto fixa as normas, `C_U`, a adjudicação anterior, contrato,
resultados, interface, ledger, verificador, output, DAG e relatório de
implementação. Todos os hashes conferiram. Não há argument-contract JSON; o
record autoritativo usa `contract.required=false`.

## 2. Disposição executiva

**Veredito: `READY_FOR_IMPLEMENTATION`.**

`R2-M-1` é `CONFIRMED`, severidade `minor`, tipo `artifact` e reparo `safe`.
O DAG é acíclico e registra ordem numérica válida, mas falha no checker que
governa sua auditabilidade: faltam hashes de dependências diretas, há hashes de
entradas não declaradas e três `artifact_path` resolvem para caminhos
inexistentes.

O defeito é local ao certificado persistente de dependências. Não afeta
thresholds, Bayes, payoffs, famílias de PBE, `Lambda`, `q_U`, `P/Q`, Reynolds
ou a interface em duas camadas. Uma simulação somente em memória do reparo
eliminou todos os erros. Não há decisão autoral nem questão material não
resolvida.

## 3. Pareceres adjudicados

| Fonte | SHA-256 | Resultado | Disposição |
|---|---|---|---|
| `R1` — `quality_reports/2026-08-30_A_U_msb_two_layer_formal_review_1.md` | `28fbd376afc18feaf890b30454cc3f51ac3cfdc4db63039b8ab174a1734d7a2a` | `PASS 0/0/0` | mérito matemático sustentado; não refuta a falha mecânica |
| `R2` — `quality_reports/2026-08-30_A_U_msb_two_layer_formal_review_2.md` | `073b32ea58f0b32ff760ff8b5f170400d091ef97fb461f0a1421273062698ed9` | `FAIL 0/0/1` | `R2-M-1` confirmado no escopo de artefato/reprodutibilidade |

Ambos cobriram o mesmo `HEAD`, manifesto e 16 entradas. Os dois sustentaram a
matemática. `R2` executou adicionalmente o checker oficial do DAG, cuja falha
foi reproduzida nesta adjudicação.

## 4. Verificação independente

O checker exige que todo nó iniciado congele o `artifact_hash` de cada
dependência direta, sem entradas excedentes, e resolve `artifact_path`
relativamente ao diretório do manifesto.

Comando:

```text
python3 /Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py \
  model_redesign/agenda_extension_A_U_msb_game_dag.json \
  --require-execution-order
```

Exit status `1`. Output relevante:

```text
INVALID
Dependency batches: [C_U_frozen] -> [A_U_blind_candidate_historical] -> [A_U_two_layer_author_decision] -> [A_U_two_layer_contract] -> [A_U_two_layer_candidate] -> [AC]
Ready: AC
ERROR: A_U_blind_candidate_historical: frozen hash for C_U_frozen is missing or stale
ERROR: A_U_two_layer_author_decision: frozen hash for A_U_blind_candidate_historical is missing or stale
ERROR: A_U_two_layer_contract: frozen hash for C_U_frozen is missing or stale
ERROR: A_U_two_layer_contract: frozen hash for A_U_two_layer_author_decision is missing or stale
ERROR: A_U_two_layer_candidate: frozen hash for A_U_blind_candidate_historical is missing or stale
ERROR: A_U_two_layer_candidate: dependency_hashes contains undeclared inputs: A_U_two_layer_author_decision, C_U_frozen
ERROR: A_U_two_layer_author_decision: cannot read artifact_path model_redesign/quality_reports/plans/2026-08-30_decisao_assinatura_duas_camadas_A_U.md
ERROR: A_U_two_layer_contract: cannot read artifact_path model_redesign/model_redesign/agenda_extension_A_U_msb_contract.md
ERROR: A_U_two_layer_candidate: cannot read artifact_path model_redesign/model_redesign/agenda_extension_A_U_msb_interface.json
```

`Ready: AC` é apenas prontidão topológica calculada antes dos erros. Não
supera `INVALID` nem cria autorização.

## 5. Finding adjudicado

| Finding | Tipo | Severidade | Status | Reparo |
|---|---|---|---|---|
| `R2-M-1` | `artifact` | `minor` | `CONFIRMED` | `safe` |

### `R2-M-1` — o DAG falha no verificador que o governa

**Localizações:**

- `model_redesign/agenda_extension_A_U_msb_game_dag.json:16-73`;
- `quality_reports/2026-08-30_A_U_msb_two_layer_formal_review_2.md`;
- `quality_reports/2026-08-30_A_U_msb_two_layer_candidate_manifest.sha256`.

**Defeito confirmado:**

- o candidato histórico não congela `C_U_frozen`;
- a decisão não congela o candidato histórico;
- o contrato não congela `C_U_frozen` e a decisão;
- o candidato atual não congela o candidato histórico;
- o candidato atual registra duas entradas transitivas não declaradas;
- três caminhos foram escritos a partir da raiz, mas o checker usa
  `model_redesign/` como base.

**Limites:** o grafo é acíclico; a ordem não falha; os hashes substantivos
conferem; ambos os pareceres sustentam a matemática; o verificador matemático
retorna `1110 PASS / 0 FAIL`. A severidade `minor` é adequada.

## 6. Reparo autorizado

O reparo técnico seguro é:

1. alinhar `dependency_hashes` exatamente a `depends_on` em cada nó iniciado;
2. no candidato, remover hashes transitivos não declarados e registrar os dois
   inputs diretos;
3. tornar os três `artifact_path` relativos ao diretório do DAG;
4. reexecutar o checker até `VALID`;
5. recalcular o hash do DAG, repinar o manifesto e submeter os novos bytes à
   verificação independente cabível.

A simulação somente em memória retornou:

```text
SIMULATED_REPAIR_VALID=True
SIMULATED_ERRORS=[]
```

O reparo não deve alterar contrato, resultados, interface, ledger, verificador
matemático, decisão autoral ou qualquer fórmula estratégica. Remover
dependências substantivas ou interpretar `Ready: AC` como autorização seria
inseguro.

## 7. Decisões e itens não resolvidos

Não há nova decisão autoral nem finding `UNRESOLVED`. `A_U` continua
`pending/unfrozen`; nada aqui autoriza `AC`, `AR`, manuscrito, congelamento,
tag, merge ou push.

## 8. Veredito

O único finding é confirmado, limitado e pronto para implementação separada.

ADJUDICATION_VERDICT: READY_FOR_IMPLEMENTATION

COUNTS: total=1; confirmed=1; partial=0; refuted=0; unresolved=0; held_decisions=0
