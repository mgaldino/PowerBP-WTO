# Inconsistência no cabeçalho de autorização do contrato gate0

**Data:** 2026-08-23
**Natureza:** achado administrativo. Nenhum artefato matemático congelado está
afetado. Nada foi executado; este documento apenas registra o problema e propõe
uma sequência de reparo.
**Origem:** preflight §7 do plano
`quality_reports/plans/2026-08-23_agenda_extension_gated_plan_v3.md`
(SHA-256 `56a933dc25532633d030ecba370a1d132ceb480e75cbf8ea4c4b48104ccb033a`).

---

## 1. Resumo

O cabeçalho do contrato `essential-input` declara que a autorização autoral não
alcança `N4`, `N6`, `N7`, o Goal 2 nem qualquer migração para o manuscrito. Os
cinco itens dessa lista de exclusões já ocorreram e foram aprovados por decisão
autoral registrada. O contrato se declara fonte normativa única e designa esse
mesmo cabeçalho como fonte canônica do status da fase, de modo que a leitura
literal da fonte canônica contradiz o estado real do projeto.

O problema é agravado por um fato de infraestrutura: o verificador canônico
`scripts/verify_essential_input_gate0.R` **impõe** o texto desatualizado, por
hash do arquivo inteiro e por hash de região do cabeçalho. O texto obsoleto não
é apenas residual; ele está ativamente protegido contra alteração.

---

## 2. Evidência

### 2.1 O texto vigente

Arquivo: `quality_reports/plans/2026-08-12_essential_input_gate0.md`
SHA-256: `2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`

O cabeçalho afirma:

> a autorização autoral posterior permite reavaliar o Goal 1 exclusivamente
> para `N1`, `N2` e `N3`, seguindo integralmente os gates da Seção 11. Esta
> autorização não alcança `N4`, `N6`, `N7`, o Goal 2, a fronteira `beta=1` nem
> qualquer migração para manuscrito.

### 2.2 O estado real, verificado

Verificação de `model_redesign/essential_input_game_dag.json` em 2026-08-23:
os seis nós `N1`, `N2`, `N3`, `N4`, `N6`, `N7` estão `pass/frozen`, com dois
pareceres independentes `PASS 0/0/0` cada, revisores distintos nos papéis
`formal_design` e `game_theory`, e hash de parecer idêntico ao hash do nó. Os
seis artefatos em disco conferem byte a byte com os hashes declarados, e a
cadeia de `dependency_hashes` fecha.

| Item excluído pelo cabeçalho | Estado real | Registro |
|---|---|---|
| `N4` | `pass/frozen`, `f1c82312…` | DAG, verificado |
| `N6` | `pass/frozen`, `a9cfd593…` | DAG, verificado |
| `N7` | `pass/frozen`, `4e0169de…` | `2026-08-21_fechamento_autoral_goal4_n7.md` |
| Goal 2 | encerrado; Goals 3 e 4 também | `2026-08-21_fechamento_autoral_goal4_n7.md` |
| Migração para manuscrito | executada, revisada e aprovada | `2026-08-21_autorizacao_goal5.md`, `2026-08-22_aprovacao_matriz_goal5.md` |

A fronteira `beta=1` continua legitimamente não autorizada. É o único item da
lista que ainda descreve a realidade.

### 2.3 Por que isso não é uma desatualização inofensiva

O próprio contrato contém a regra de fonte normativa única:

> Este arquivo é a **única fonte normativa corrente** da arquitetura
> essential-input. Documentos decisórios anteriores são proveniência histórica:
> servem para auditar como este contrato foi formado, mas não constituem uma
> segunda autoridade sobre sua redação vigente.

E sua tabela de fontes canônicas atribui `status e autorização da fase` ao
`cabeçalho acima`.

As autorizações que superaram o cabeçalho estão precisamente nos arquivos
avulsos que essa regra classifica como não-autoridade. Um agente que siga o
contrato à risca conclui que `N4`, `N6`, `N7` e a migração nunca foram
autorizados — o oposto do estado real — e não tem, dentro das regras do próprio
contrato, um caminho legítimo para corrigir essa conclusão lendo os registros
avulsos.

### 2.4 O verificador impõe o texto obsoleto

`scripts/verify_essential_input_gate0.R`, linhas 72–76:

```r
expected_contract_hash <- "2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6"
expected_contract_region_hashes <- c(
  authorization_header = "dd1d2bb6b8ce16f4604057e87c1edfcd4e3d4d413268a24d3d17616b554f3467",
  beta_primitive       = "bb7ee3390b0f63a4d293fe8deab7d33fea725d280ad43121c615375f96bf41b4",
  delay_cost_decision  = "3c4483859bc7cdaf36c8fe3c4a1c2d54a278e40980eacdaba2fb9b684ebb8f2a"
)
```

O contrato é fixado duas vezes: pelo hash do arquivo inteiro e pelo hash da
região isolada do cabeçalho. Além disso, o script contém uma bateria de testes
adversariais de mutação que falham deliberadamente se alguém inserir no
cabeçalho texto que amplie a autorização — por exemplo
`n4_authorization_in_header`, `n4_authorization_in_section_11` e
`contradiction_inside_hashed_header`.

Esse desenho é correto e deve ser preservado: ele existe para impedir que um
agente amplie silenciosamente a própria autorização. A consequência é que
corrigir o cabeçalho **não é uma edição de documentação**. É uma operação
guardada, que quebra o verificador canônico se feita isoladamente.

### 2.5 Existe um precedente do procedimento correto, não incorporado

Worktree: `/Users/manoelgaldino/.codex/worktrees/essential-input-n4/PowerBayesianPersuasion`
Branch: `codex/essential-input-n4` — HEAD `3c8639238f1f685dae7265a148284cf59cbae4f5`

Ela contém, **não commitado**, um reparo do mesmo tipo, escrito por volta de
2026-08-18, que atualizava o cabeçalho para registrar o fechamento do Goal 1 e
a autorização do Goal 2 para `N4`. A cópia local do contrato hasheia
`368b09eace9b1c2e68ffdcc61e6583dbc060591f1faf627f93919bae79e2241a`.

O valor desse material não está no texto, que já nasceu incompleto para hoje
— ele para no Goal 2 —, mas em demonstrar o **procedimento completo** que a
operação exige. Naquele reparo foram alterados, no mesmo ato:

1. o texto do cabeçalho;
2. `expected_contract_hash`;
3. `expected_contract_region_hashes[["authorization_header"]]`;
4. as asserções semânticas de `is_valid_reopened_authorization`, que passaram a
   exigir por `grepl` o novo texto em vez do antigo;
5. os testes adversariais de mutação, deslocados da fronteira antiga para a
   nova (`n4_*` renomeados para `n6_*`);
6. a mensagem final de `PASS` do script.

Enquanto o passo A não estiver concluído, essa worktree é a única cópia
existente desse roteiro.

---

## 3. Proposta de reparo

### Passo A — corrigir cabeçalho e verificador em um único ato

Exige autorização autoral explícita. A ordem interna é:

- **A1.** O autor fixa o novo texto do cabeçalho, registrando o estado real:
  `N1`–`N4`, `N6` e `N7` `pass/frozen`; Goals 1 a 5 encerrados; migração do
  Goal 5 executada, revisada e aprovada. E registrando o que continua **não**
  autorizado: a fronteira `beta=1` e a extensão de agenda, cujo Gate 0 não foi
  aberto.
- **A2.** Recalcular e substituir, no mesmo commit, `expected_contract_hash` e
  o hash de região `authorization_header`.
- **A3.** Reapontar as asserções semânticas e os testes adversariais de mutação
  para a **nova** fronteira. O guarda deve passar a falhar contra uma ampliação
  que autorize a extensão de agenda ou `beta=1`, e não mais contra uma que
  autorize `N4`.
- **A4.** Executar `scripts/verify_essential_input_gate0.R` até `PASS`.
- **A5.** Revisão independente por quem não editou, conforme a disciplina do
  projeto.

Observação sobre a Seção 12. Minha leitura é que esta correção **não** reabre o
Gate 0: a §12 enumera como gatilhos o estimando ou escopo, primitivas ou
factibilidade, ações, transições, informação ou payoffs, conceito de solução,
desconto, topologia ou schema, obrigações de prova (item 1) e o protocolo de
revisão da Seção 11 (item 3). Uma linha de status de fase não é nenhum deles, e
as alterações no verificador são constantes do guarda, não o protocolo de
revisão. A decisão, porém, é do autor: o cabeçalho é a fonte canônica de
autorização e o autor é a parte autorizante. A emenda deve declarar
explicitamente que é status-only e que não altera nenhuma regra normativa, para
que o próximo agente não precise refazer esse raciocínio.

Alternativa considerada e descartada: apenas acrescentar ao cabeçalho um
ponteiro para a cadeia de autorizações avulsas. O contrato proíbe que menções
fora da fonte canônica a qualifiquem ou ampliem, de modo que o ponteiro seria
lido como a segunda autoridade que a regra de fonte única veda.

### Passo B — só depois de A: descartar a worktree parada

Descartar antes de A destrói o único registro do roteiro descrito em §2.5.
Depois que A estiver commitado e revisado, a worktree
`codex/essential-input-n4` perde qualquer valor: seu texto de cabeçalho estará
superado pelo de A, e suas edições no verificador estarão superadas pelas de
A3. Nesse momento, descartar as modificações não commitadas e remover a
worktree.

### Item C — separado e menor

As worktrees `/private/tmp/PowerBayesianPersuasion-essential-input-n3-cold` e
`…-n4-cold` contêm arquivos não rastreados de rederivação cega que não existem
em nenhum commit de nenhuma branch:

- `model_redesign/essential_input_n3_cold_rederivation.md`, `…_correspondence.json`, `…_ledger.md`
- `model_redesign/essential_input_n4_r1_unanimity_cold_rederivation.md`, `…_correspondence_candidate.json`, `…_ledger.md`
- `scripts/verify_essential_input_n3_cold.R`, `scripts/verify_essential_input_n4_r1_unanimity_cold.R`

Reconstruções cegas de `N4` estão versionadas sob outros nomes
(`essential_input_n4_r1_unanimity_cold_notes_v2/v3/v4.md`), então estes são
provavelmente duplicatas ou variantes tardias. Como residem em `/private/tmp`,
que o sistema limpa, a decisão é preservá-los num commit de proveniência ou
aceitar a perda. Convém confirmar se são de fato duplicatas antes de decidir.

---

## 4. O que não está afetado

- Os seis artefatos congelados `N1`–`N4`, `N6`, `N7` e seus pareceres.
- O snapshot histórico revisado do manuscrito em `b5fdefb`.
- O plano da extensão de agenda, que segue fechado e não autorizado.

Nada aqui bloqueia a abertura do Goal 0 da extensão. O acoplamento é de outra
ordem: o Gate 0 da extensão transportará o pacote baseline deste contrato, e
convém que a fonte normativa que ele cita descreva corretamente o estado do
projeto no momento da citação.
