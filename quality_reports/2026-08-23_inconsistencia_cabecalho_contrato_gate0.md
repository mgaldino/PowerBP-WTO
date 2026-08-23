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
| Migração para manuscrito | autorizada e executada; dois `PASS 0/0/0` sobre `b5fdefb`; **aval autoral terminal pendente** | `2026-08-21_autorizacao_goal5.md`, `2026-08-22_aprovacao_matriz_goal5.md` |

A fronteira `beta=1` continua legitimamente não autorizada. É o único item da
lista que ainda descreve a realidade.

O caso da migração exige precisão, porque a caducidade do cabeçalho não implica
que o Goal 5 esteja encerrado. A aprovação da matriz autorizou **executar** a
migração; ela não fechou o gate final. Seus próprios limites condicionam a tag
final a "dois `PASS 0/0/0` e aval autoral", e
`2026-08-22_goal5_candidate_ready_for_author_approval.md` declara literalmente
que "o Goal 5 ainda não é declarado encerrado por este registro: falta o aval
explícito do autor". Nenhum registro posterior concede esse aval, e a tag final
não foi criada. O estado correto é portanto: **Goals 1 a 4 encerrados; Goal 5
autorizado, migrado e revisado, aguardando aval autoral terminal.**

Um segundo cuidado se soma a esse. Os dois pareceres `PASS 0/0/0` do Goal 5
cobrem exatamente os bytes de `b5fdefb` (Rmd `32b49f75…`, PDF `85d24122…`). Os
arquivos hoje em disco são outros (Rmd `45c6bcbc…`, PDF `cc0294ff…`), por conta
da reescrita de abstract e introdução em `c6af7f6`. Os arquivos atuais não
podem ser descritos como aprovados por aqueles pareceres.

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

Convém separar o que no verificador avançou do que ficou parado. A lógica de
status dos nós **acompanhou** a realidade: a mensagem final reconhece
`N1/N2/N3/N4/N6/N7 pass/frozen`, afirma que nenhum nó de derivação está
topologicamente pronto e fixa a aprovação autoral pós-congelamento com o Goal 4
encerrado. O que ficou congelado no passado é especificamente o cabeçalho e os
guards que o cercam:

- o hash de região `authorization_header` (`dd1d2bb6…`), que fixa o texto
  obsoleto;
- os testes adversariais de mutação, ainda redigidos em torno da fronteira
  antiga `N4 / Goal 2` (linhas ~2279–2396);
- a mensagem final de `PASS` (linhas ~2708–2710), que afirma que "Goal 5,
  beta=1 extensions, and manuscript migration remain unauthorized". Era
  verdade quando escrita; hoje é falsa quanto ao Goal 5 e à migração, ambos
  autorizados em 2026-08-21.

Ou seja, o verificador hoje **imprime `PASS` enquanto afirma um estado que os
registros autorais contradizem**. Esse é o sintoma mais visível do problema.

### 2.5 Existe um precedente do procedimento correto, não incorporado

Worktree: `/Users/manoelgaldino/.codex/worktrees/essential-input-n4/PowerBayesianPersuasion`
Branch: `codex/essential-input-n4` — HEAD `3c8639238f1f685dae7265a148284cf59cbae4f5`

Ela contém, **não commitado**, um reparo do mesmo tipo, escrito por volta de
2026-08-18, que atualizava o cabeçalho para registrar o fechamento do Goal 1 e
a autorização do Goal 2 para `N4`. A cópia local do contrato hasheia
`368b09eace9b1c2e68ffdcc61e6583dbc060591f1faf627f93919bae79e2241a`.

O valor desse material não está no texto. Ele é duplamente superado: nasceu
parando no Goal 2 e, desde então, a cópia primária do verificador avançou por
conta própria para além dele, reconhecendo os seis nós congelados e o
fechamento do Goal 4. O que resta de útil é a demonstração do **procedimento**
que a operação exige. Naquele reparo foram alterados, no mesmo ato:

1. o texto do cabeçalho;
2. `expected_contract_hash`;
3. `expected_contract_region_hashes[["authorization_header"]]`;
4. as asserções semânticas de `is_valid_reopened_authorization`, que passaram a
   exigir por `grepl` o novo texto em vez do antigo;
5. os testes adversariais de mutação, deslocados da fronteira antiga para a
   nova (`n4_*` renomeados para `n6_*`);
6. a mensagem final de `PASS` do script.

Esse encadeamento continua sendo o roteiro correto para o Passo A, mesmo que
seus valores concretos estejam obsoletos. Ele não é, porém, a razão principal
para não remover a worktree: essa razão está no Passo B.

---

## 3. Proposta de reparo

### Passo A — corrigir cabeçalho e verificador em um único ato

Exige autorização autoral explícita. A ordem interna é:

- **A1.** O autor fixa o novo texto do cabeçalho, registrando o estado real:
  `N1`–`N4`, `N6` e `N7` `pass/frozen`; Goals 1 a 4 encerrados; Goal 5
  autorizado, migrado e revisado, com dois `PASS 0/0/0` sobre o snapshot
  `b5fdefb` e **aval autoral terminal pendente**. E registrando o que continua
  **não** autorizado: a fronteira `beta=1` e a extensão de agenda, cujo Gate 0
  não foi aberto. O cabeçalho não deve declarar encerrado um goal que os
  registros mantêm aberto: substituir uma afirmação falsa por outra é o mesmo
  defeito com o sinal trocado.
- **A2.** Recalcular e substituir, no mesmo commit, `expected_contract_hash` e
  o hash de região `authorization_header`.
- **A3.** Reapontar para a **nova** fronteira as asserções semânticas, os
  testes adversariais de mutação (linhas ~2279–2396) e a mensagem final de
  `PASS` (linhas ~2708–2710). O guarda deve passar a falhar contra uma
  ampliação que autorize a extensão de agenda ou `beta=1`, e não mais contra
  uma que autorize `N4` ou o Goal 2. A mensagem final deve deixar de afirmar
  que o Goal 5 e a migração estão não autorizados.
- **A4.** Executar `scripts/verify_essential_input_gate0.R` até `PASS`.
- **A5.** **Dois** pareceres independentes e read-only, por quem não editou,
  sobre os mesmos hashes novos do contrato e do verificador — o mesmo padrão do
  gate de congelamento dos nós. Os pareceres devem demonstrar mecanicamente que
  mudaram apenas o status/autorização e os guards correspondentes, e que
  nenhuma primitiva, payoff, conceito de solução, schema ou obrigação de prova
  foi tocada. O diff do contrato deve ficar confinado à região
  `authorization_header`.

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

### Passo B — só depois de A, e só depois de auditar o que ela contém

Depois que A estiver commitado e revisado, o **reparo de cabeçalho e
verificador** daquela worktree perde qualquer valor: seu texto estará superado
pelo de A1 e suas edições no verificador pelas de A3. Isso vale para os dois
arquivos rastreados que ela modifica.

Isso **não** autoriza remover a worktree, porque ela contém quatro arquivos
adicionais, não rastreados, que nada têm a ver com o reparo do cabeçalho:

- `model_redesign/essential_input_n4_r1_unanimity_derivation.md`
- `model_redesign/essential_input_n4_r1_unanimity_interface.json`
- `model_redesign/essential_input_n4_r1_unanimity_ledger.json`
- `scripts/verify_essential_input_n4.R`

Verificação de alcançabilidade em 2026-08-23: os blobs correspondentes existem
no banco de objetos, mas **nenhum deles é alcançável a partir de qualquer ref**
(`git rev-list --all --objects` não os lista). Objetos não alcançáveis são
podados por `git gc`. Na prática, esses bytes só existem naquela worktree, e
remover a worktree como proposto causaria perda efetiva.

Convém notar que o `…_interface.json` não é cópia do artefato congelado de
`N4`: o congelado é
`model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json`
(SHA-256 `f1c82312…`), enquanto o não rastreado hasheia `17134288…`. São bytes
distintos, provavelmente um candidato anterior ou paralelo. A redundância
substantiva é plausível, mas não está demonstrada.

Portanto o Passo B fica: **auditar os quatro arquivos e obter decisão explícita
de preservar ou descartar, exatamente como o Item C exige para as worktrees
frias; só então remover a worktree.** Preservar significa commit de
proveniência numa branch própria, não deixá-los em `/private/tmp` nem
dependendo de objetos soltos.

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

Não há bloqueio **matemático** à abertura do Goal 0 da extensão: os artefatos
que ela consumiria estão íntegros e verificados. Ainda assim, a recomendação é
tratar o Passo A como **pré-condição de sequência**. O Gate 0 da extensão
transportará o pacote baseline deste contrato, e não convém abrir uma extensão
que consome um baseline cuja fonte canônica e cujo verificador afirmam um
estado sabidamente falso — inclusive porque o verificador, ao terminar, imprime
hoje que a migração para o manuscrito permanece não autorizada, o que
contradiz a autorização registrada do Goal 5.

---

## 5. Histórico de revisão deste documento

**Revisão 1 — 2026-08-23.** A primeira redação recebeu parecer independente do
Codex, com veredicto `diagnóstico PASS; proposta de reparo REVISE`. Três
achados foram verificados e incorporados:

1. **Goal 5 declarado encerrado prematuramente.** Confirmado contra
   `2026-08-22_goal5_candidate_ready_for_author_approval.md` e os limites de
   `2026-08-22_aprovacao_matriz_goal5.md`. Corrigido em §2.2 e A1, com o
   acréscimo de que os bytes atuais do manuscrito divergem dos revisados em
   `b5fdefb`.
2. **Passo B destrutivo e insuficientemente auditado.** Confirmado, e com
   precisão maior do que a do parecer: os quatro arquivos não rastreados da
   worktree `essential-input-n4` têm blobs presentes no banco de objetos, mas
   **não alcançáveis por nenhum ref**, portanto sujeitos a poda por `git gc`.
   O Passo B foi reescrito para exigir auditoria e decisão explícita antes de
   qualquer remoção.
3. **Revisão do reparo deve ser dupla e mecanicamente demonstrada.** Aceito e
   incorporado em A5.

A ressalva do parecer sobre a conclusão também foi aceita: a correção passa de
"não bloqueia" a pré-condição de sequência para o Goal 0 da extensão.

**Revisão 2 — 2026-08-23.** Correção de um erro próprio, detectado ao conferir
a mensagem final do verificador. A Revisão 1 descrevia o verificador primário
como parado na fronteira `N4 / Goal 2`; isso vinha de ler o lado "antes" de um
diff calculado dentro da worktree `essential-input-n4`, cujo `HEAD` é o commit
antigo `3c86392`, e não a cópia primária em `af5bfd5`. O verificador primário
está mais avançado: reconhece os seis nós congelados e o fechamento do Goal 4.
O que permanece obsoleto é o cabeçalho, seus guards de mutação e a mensagem
final de `PASS`. §2.4, §2.5 e A3 foram corrigidos. A consequência colateral é
que o valor da worktree como roteiro cai, e a razão para não removê-la passa a
ser exclusivamente os quatro arquivos não rastreados do Passo B.
