# Parecer — Revisão adversarial independente do guarda `verify_essential_input_gate0.R`

**Revisor:** agente independente, papel `game_theory` / auditoria adversarial
**Regime:** read-only estrito. Nenhum `Edit`, `Write` ou `NotebookEdit` foi chamado. Nenhum arquivo do projeto foi criado, alterado ou apagado.
**Data:** 2026-08-23

---

## Objeto e hashes confirmados

| Arquivo | SHA-256 esperado | SHA-256 medido | Confere |
|---|---|---|---|
| `scripts/verify_essential_input_gate0.R` | `e6ecc69d848ba63db92c5c86dbad8c218848c0250ae8d2adc732bbe9527821c7` | `e6ecc69d848ba63db92c5c86dbad8c218848c0250ae8d2adc732bbe9527821c7` | SIM |
| `quality_reports/plans/2026-08-12_essential_input_gate0.md` | `f683b6a60cdd8a7085eafe0b803fa060dc931a592f2b70a144f881b1e437c462` | `f683b6a60cdd8a7085eafe0b803fa060dc931a592f2b70a144f881b1e437c462` | SIM |

**Divergência no enunciado da tarefa, não nos artefatos.** O briefing declara `HEAD` = `af5bfd5`. O `HEAD` real do branch `codex/essential-input` é `a315f59`, dois commits adiante (`af5bfd5` → `3b3492f` → `a315f59`). Todas as comparações `git diff` deste parecer são contra `a315f59`. Isso não afeta os bytes revisados, mas registro para que o parecer não seja lido como cobrindo uma base diferente da que examinei.

Árvore de trabalho (3 arquivos modificados, nenhum staged):
```
 M quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md
 M quality_reports/plans/2026-08-12_essential_input_gate0.md
 M scripts/verify_essential_input_gate0.R
```

---

## Metodologia

Comandos efetivamente executados (todos read-only sobre o projeto):

1. `shasum -a 256` nos dois objetos; `git status --porcelain`; `git rev-parse HEAD`; `git log --oneline -8`.
2. `git diff` e `git diff -U0` nos três arquivos modificados, com extração programática dos ranges de hunk.
3. Reimplementação independente em Python do algoritmo de regiões do script (`contract_lines` → `unique_exact_line` / `unique_matching_line` → `paste(collapse="\n")` → SHA-256 UTF-8), validada por reproduzir os **quatro** hashes canônicos.
4. `Rscript --vanilla -e` com `parse()` sobre o próprio verificador, avaliando **apenas** as definições de `contract_lines`, `unique_*`, `insert_before_matching_line`, `insert_after_matching_line`, `replace_matching_line`, `insert_in_authorization_header`, `insert_in_delay_cost_decision`, `r3_contract_mutations`, `game_reviewer_paraphrases`, `formal_reviewer_mutations` e `semantic_mutations` — isto é, testei as funções **reais do script**, não uma paráfrase minha.
5. Aplicação de cada uma das 21 mutações de contrato ao texto real, medindo `is.na(out)`, `identical(out, contract_text)` e `nchar(out) - nchar(contract_text)`.
6. Atribuição de camada: para cada mutação, cálculo separado de (i) hash integral, (ii) hash da região `authorization_header`, (iii) os cinco `grepl`, (iv) `beta_primitive`, (v) `delay_cost_decision`.
7. `Rscript --vanilla -e` isolado para determinar o comportamento de R em `charToRaw(enc2utf8(NA_character_))`.
8. `Rscript --vanilla scripts/verify_essential_input_gate0.R` (execução completa, 1,44 s).
9. Construção analítica e numérica de ataques (sem gravar arquivos).

---

## Item 1 — Corretude dos hashes

Recalculei os quatro hashes replicando o algoritmo do script. A região `authorization_header` vai da linha exata `**Data:** 2026-08-12` (índice 0-based 2) até a linha anterior à que começa com `### Regra de fonte normativa` (índice 42), unidas por `\n`, sem newline final, em UTF-8 — 40 linhas.

| Objeto | Esperado no script | Recalculado | Confere | Tocado no diff |
|---|---|---|---|---|
| contrato integral | `f683b6a6…37c462` | `f683b6a6…37c462` | SIM | sim (atualizado) |
| `authorization_header` | `5a94de52…9e62a6` | `5a94de52…9e62a6` | SIM | sim (atualizado) |
| `beta_primitive` | `bb7ee339…bf41b4` | `bb7ee339…bf41b4` | SIM | **não** |
| `delay_cost_decision` | `3c448385…bb8f2a` | `3c448385…bb8f2a` | SIM | **não** |

Verificações auxiliares:
- O arquivo termina com exatamente um `\n` e não contém `CR`; portanto `paste0(paste(readLines(...), collapse="\n"), "\n")` reconstrói o original byte a byte (confirmado: `reconstructed == original`).
- Todos os marcadores de fronteira de região são **únicos**: `**Data:** 2026-08-12` (1 ocorrência), `### Regra de fonte normativa` (1), o par de `### Decis…` do custo de atraso (1 e 1), `## 2. Primitivas` (1), `## 3. Decis` (1).
- A linha de primitiva de desconto extraída é exatamente `Desconto       beta in (0,1)` — única no bloco da Seção 2.

**Conclusão do item 1: correto.** Os dois hashes atualizados batem com os bytes reais; os dois hashes não relacionados permanecem intactos e continuam corretos. Isso é, por si só, prova mecânica de que as regiões `beta_primitive` e `delay_cost_decision` não foram tocadas.

**Requisito A5 do roteiro — confinamento do diff.** O diff do contrato tem **um único hunk**, `@@ -15,4 +15,25 @@`, cobrindo linhas antigas 15–18 e novas 15–39. A região `authorization_header` são as linhas 1-based 3–42. O diff está integralmente confinado à região `authorization_header`. Requisito A5 cumprido.

---

## Item 2 — Não-vacuidade das mutações (ponto central)

Primeiro, confirmei mecanicamente **o mecanismo da vacuidade**, que é pior do que o briefing supõe:

```
> charToRaw(enc2utf8(NA_character_))
[1] 4e 41
```

`charToRaw` de `NA_character_` **não dá erro**: devolve os bytes da string literal `"NA"`. Portanto `sha256_text(NA_character_)` calcula um hash válido de dois bytes, `is_valid_contract_semantics(NA_character_)` devolve `FALSE` **silenciosamente**, e `all(!results)` fica `TRUE`. Uma âncora quebrada não produz erro, não produz aviso e não produz diagnóstico — produz um PASS.

Testei então **todas as 21 mutações de contrato** com as funções reais do script:

**As doze de `r3_contract_mutations`:**

| Mutação | `is.na` | texto mudou | Δ chars |
|---|---|---|---|
| `beta_exception_after_primitive` | FALSE | TRUE | +64 |
| `unit_discount_in_rounds_primitive` | FALSE | TRUE | +41 |
| `beta_exception_at_end_of_section_2` | FALSE | TRUE | +69 |
| `goal5_closure_in_header` | FALSE | TRUE | +72 |
| `goal5_terminal_approval_in_header` | FALSE | TRUE | +65 |
| `goal5_reviews_extended_to_current_bytes` | FALSE | TRUE | +68 |
| `agenda_authorization_in_section_11` | FALSE | TRUE | +71 |
| `beta_exception_in_section_12` | FALSE | TRUE | +68 |
| `citation_as_proof_in_section_13` | FALSE | TRUE | +62 |
| `contradiction_inside_hashed_header` | FALSE | TRUE | +73 |
| `final_tag_without_approval_in_section_13` | FALSE | TRUE | +66 |
| `imported_premise_inside_hashed_delay_decision` | FALSE | TRUE | +75 |

**As nove de `semantic_mutations`:** todas `is.na=FALSE`, `changed=TRUE`, Δ entre +69 e +123.

Âncora por âncora, contagem de linhas correspondentes no contrato real:

| Âncora | Ocorrências | Única |
|---|---|---|
| `Desconto       beta in (0,1)` (prefixo) | 1 | SIM |
| `Rodadas        duas; R2 terminal` (prefixo) | 1 | SIM |
| `## 3. Decis` (prefixo) | 1 | SIM |
| `**Alcance da emenda de status` (prefixo) | 1 | SIM |
| `**Substitui:**` (prefixo) | 1 | SIM |
| `## 12. Invalida` (prefixo) | 1 | SIM |
| `## 13. Fronteira de vers` (prefixo) | 1 | SIM |
| `## 14. Prompt de abertura` (prefixo) | 1 | SIM |
| `### Decis…` + `conceito de solu` | 1 | SIM |

**Conclusão do item 2: nenhuma mutação é vacuosa hoje.** Todas as 21 âncoras existem, são únicas e produzem texto efetivamente modificado.

**Porém, encontrei prova de que o risco é real e já se materializou uma vez.** A mutação retirada neste diff, `n4_authorization_in_header`, ancorava em `identical(line, "manuscrito.")`. Contei as ocorrências dessa linha no contrato **novo**: **zero**. Se ela tivesse sido deixada no lugar, teria devolvido `NA_character_` e a asserção teria passado **vaziamente**, sem nenhum sinal. Não foi por isso que ela foi corrigida: o que forçou a atualização foi a outra asserção, `expanded_authorization`, que usa `sub()` — e `sub()` sem match devolve o texto **inalterado**, fazendo `is_valid_reopened_authorization` retornar `TRUE` e a asserção `assert_true(!TRUE)` falhar **ruidosamente**. Ou seja: o guarda tem dois modos de falha de âncora, um alto e um mudo, e a correção foi induzida pelo modo alto enquanto o modo mudo foi consertado por acaso. Nada no script assegura que isso se repita.

Não existe hoje nenhuma asserção que verifique que `mutate(contract_text)` é não-`NA` e difere de `contract_text`. Ver finding T-1.

---

## Item 3 — Cobertura da fronteira viva

Testei separadamente cada camada de defesa contra cada mutação. Resultado:

| Mutação | hash integral | hash `header` | grepl | beta | delay | **capturada por** |
|---|---|---|---|---|---|---|
| `beta_exception_after_primitive` | rejeita | passa | passa | passa | passa | só hash integral |
| `unit_discount_in_rounds_primitive` | rejeita | passa | passa | passa | passa | só hash integral |
| `beta_exception_at_end_of_section_2` | rejeita | passa | passa | passa | passa | só hash integral |
| `goal5_closure_in_header` | rejeita | **rejeita** | passa | passa | passa | hash integral + região |
| `goal5_terminal_approval_in_header` | rejeita | **rejeita** | passa | passa | passa | hash integral + região |
| `goal5_reviews_extended_to_current_bytes` | rejeita | **rejeita** | passa | passa | passa | hash integral + região |
| `agenda_authorization_in_section_11` | rejeita | passa | passa | passa | passa | só hash integral |
| `beta_exception_in_section_12` | rejeita | passa | passa | passa | passa | só hash integral |
| `citation_as_proof_in_section_13` | rejeita | passa | passa | passa | passa | só hash integral |
| `contradiction_inside_hashed_header` | rejeita | **rejeita** | passa | passa | passa | hash integral + região |
| `final_tag_without_approval_in_section_13` | rejeita | passa | passa | passa | passa | **só hash integral** |
| `imported_premise_inside_hashed_delay_decision` | rejeita | passa | passa | **rejeita** (delay) | | hash integral + região delay |

Respondendo às três perguntas do briefing:

**(a) Declarar o Goal 5 encerrado — coberto em duas camadas.** `goal5_closure_in_header` insere logo após a linha `**Alcance da emenda de status…` (índice 33), dentro da região `[2,42)`; `contradiction_inside_hashed_header` insere antes de `**Substitui:**` (índice 39), também dentro. Ambas quebram o hash de região. Boa cobertura.

**(b) Estender os `PASS 0/0/0` de `b5fdefb` aos bytes correntes — coberto em duas camadas.** `goal5_reviews_extended_to_current_bytes` insere dentro da região hasheada. Boa cobertura.

**(c) Autorizar a tag final sem aval autoral — coberto em UMA camada só.** `final_tag_without_approval_in_section_13` insere na Seção 13, que **não pertence a nenhuma região hasheada** e não é tocada por nenhum `grepl`. Só o hash integral a rejeita. Isso importa porque a tabela de fonte normativa única do próprio contrato atribui **"fronteira de versão, verificação da infraestrutura e artefatos protegidos" à Seção 13**. Um texto inserido ali autorizando a tag final está *dentro do domínio canônico da Seção 13*, e portanto não é neutralizado pela regra de fonte única — cria conflito normativo genuíno com o cabeçalho, que o verificador não detecta. Ver finding S-2.

**`beta=1` — continua rejeitado**, em três frentes independentes: `old_beta_domain` (teste regional direto de `is_valid_strict_beta_contract`), `missing_delay_cost` (idem, região `delay_cost_decision`), e três entradas do r3. A região `delay_cost_decision` é a única região, além do cabeçalho, que captura uma mutação por conta própria.

**Extensão de agenda — continua rejeitada**, mas de forma assimétrica: a *remoção* da exclusão é capturada em duas camadas (`expanded_authorization` quebra hash de região **e** o `grepl("agenda informal")`); a *adição* de uma autorização na Seção 11 é capturada só pelo hash integral.

**Fronteiras descobertas.** Sim, três:

1. A criação da tag final (item c acima), como detalhado.
2. `quality_reports/2026-08-21_autorizacao_goal5.md` **existe** (6.284 bytes, SHA-256 `10e0d6d94d205e97863d908d7f4b4e99206d521636cbe30d9f76bcb6b2e68f37`) e **não é referenciado pelo verificador** (0 ocorrências). Isso rompe um padrão já estabelecido: o script pina `2026-08-21_autorizacao_goal3_n6.md` (linha 262) e `2026-08-21_fechamento_autoral_goal4_n7.md` (linha 346). O documento que define o **escopo do único goal aberto** é o único da série que fica livre. Ver finding S-3.
3. Nenhum hash de manuscrito é pinado. As duas únicas ocorrências de `b5fdefb` no script são o `grepl` do cabeçalho (linha 145) e a mensagem de PASS (linha 2735). O verificador não consegue detectar deriva dos bytes de `formal_model_v6.Rmd` em relação ao snapshot revisado; ele apenas repete o que o cabeçalho pinado afirma. Isso não é errado, mas é menos do que a mensagem de PASS sugere ao leitor apressado.

---

## Item 4 — Enfraquecimento

Contagem de `assert_true(` no arquivo: **156 em `HEAD`, 156 na árvore de trabalho.** Nenhuma asserção removida. O diff é +45/−19 linhas, 2718 → 2744.

Alcançabilidade: 137 asserções são top-level e 19 são aninhadas. Verifiquei os contextos das aninhadas (linhas 30/32 dentro de `sha256_file`, 924–967 e 2714 dentro de laços `for` sobre `expected_ids`, 1862–1993 dentro de laços sobre specs de revisão, 2086/2095 dentro de laços de fixture). Todas pertencem a funções ou laços efetivamente executados — o script correu até o fim e imprimiu as duas mensagens finais, o que só ocorre depois de todas elas.

Mudanças, uma a uma:

- `is_valid_reopened_authorization` ganhou **cinco conjuntos `&&`** e não perdeu nenhum. Monotonicamente mais forte no nível do código.
- `expanded_authorization`: âncora de `sub()` trocada de `` `N4`, `N6`, `N7`, o Goal 2, a fronteira `beta=1` `` (0 ocorrências no contrato novo — teria falhado ruidosamente) para `agenda informal` (1 ocorrência, dentro do cabeçalho, verificado que é a primeira e única do arquivo, o que torna a semântica de `sub()` inequívoca). Troca forçada e correta.
- `n4_authorization_in_header` → `goal5_closure_in_header`: âncora morta trocada por âncora viva **dentro da região hasheada**. Estritamente melhor.
- `n4_authorization_in_section_11` → `agenda_authorization_in_section_11`: mesma âncora (`## 12. Invalida`), texto reapontado. Mesma força.
- Três entradas novas no r3 (`goal5_terminal_approval_in_header`, `goal5_reviews_extended_to_current_bytes`, `final_tag_without_approval_in_section_13`). Nenhuma removida sem substituta.
- `game_reviewer_paraphrases[[4]]` e `[[6]]` e `formal_reviewer_mutations[[1]]`: textos reapontados para a fronteira viva. Mesma âncora, mesma camada.
- `coordinated_r3_contract_mutation` passou a compor `beta_exception_after_primitive` com `agenda_authorization_in_section_11`. Equivalente.

**Contagens declaradas nas mensagens — todas conferem:**

| Declaração | Valor real |
|---|---|
| `"twelve Round 3 mutations"` (asserção) | `length(r3_contract_mutations) == 12` |
| `"all 12 Round 3 mutations"` (MUTATION_REJECTED) | 12 |
| `"nine regional semantic contradictions"` | `length(semantic_mutations) == 9` (6 + 3) |
| `"five directed N6 mutations"`, `"five directed N7"` | não recontados em detalhe; intocados pelo diff |

**Conclusão do item 4: nenhuma asserção foi removida, afrouxada ou tornada inalcançável; nenhuma mutação que antes falhava agora passaria; as contagens declaradas estão corretas.**

Ressalva de leitura, não de código: 7 das 12 mutações do r3 são rejeitadas **exclusivamente** pelo hash integral. Para essas, a bateria demonstra apenas que o SHA-256 muda quando os bytes mudam. A mensagem `MUTATION_REJECTED` é literalmente exata ("the independent full-contract identity returned FALSE"), mas a enumeração retórica que a segue pode induzir um leitor a atribuir à bateria mais profundidade do que ela tem.

---

## Item 5 — Bypass do hash: os `grepl` são substantivos?

**Não. Os cinco `grepl` capturam exatamente zero das doze mutações do r3.** Vê-se na coluna "grepl" da tabela do item 3: `passa` em todas as doze, incluindo as três novas mutações de Goal 5 que são o propósito declarado da atualização.

A razão é estrutural: `grepl` testa **presença**, nunca **ausência**. Os cinco padrões (`permanece aberto`, `falta o aval`, `b5fdefb`, `sem aval autoral`, `agenda informal`) detectam a *supressão ou reformulação* de cinco substrings. Não detectam a *adição* de texto que os contradiga. Um atacante que já esteja recalculando o hash — que é exatamente o cenário contra o qual essa camada foi introduzida — não precisa apagar nada: basta **acrescentar**.

Pior, dois dos cinco padrões são **cegos a polaridade**, isto é, aparecem naturalmente tanto na frase restritiva quanto na frase permissiva:

- `sem aval autoral` está hoje em "*a criação da tag final do Goal 5 **sem aval autoral** explícito*" (proibição). Aparece igualmente bem em "*a tag final pode ser criada **sem aval autoral** adicional*" (permissão).
- `permanece aberto` está hoje ligado ao Goal 5. Nada o prende ao Goal 5; serve a qualquer sujeito.

Construí e testei numericamente um cabeçalho reescrito que **inverte integralmente a autorização** e ainda assim satisfaz os cinco `grepl`:

> "**Emenda.** O Goal 5 esta encerrado; o aval autoral terminal foi concedido e a tag final pode ser criada **sem aval autoral** adicional. Os pareceres **b5fdefb** cobrem tambem os bytes correntes. A extensao de **agenda informal** esta liberada. Nenhum item **permanece aberto** salvo o que **falta o aval** de terceiros."

Resultado medido: `permanece aberto` TRUE, `falta o aval` TRUE, `b5fdefb` TRUE, `sem aval autoral` TRUE, `agenda informal` TRUE — **os cinco satisfeitos**, com a autorização invertida em todos os pontos.

**Sobre o ASCII puro.** A restrição de locale não é o problema. Verifiquei que os cinco padrões ocorrem **exatamente uma vez em todo o arquivo** e todos dentro do cabeçalho, portanto não há ambiguidade nem falso positivo em outro lugar. A fraqueza é a semântica de `grepl`, não a codificação.

**Conclusão do item 5:** a camada `grepl` é um detector de *deleção*, não um detector de *contradição*. Ela adiciona custo real contra o ataque preguiçoso (apagar a restrição) e **custo zero** contra o ataque aditivo, que é pelo menos igualmente fácil. Descrevê-la como "defesa em profundidade contra quem edite o cabeçalho e recalcule o hash" superestima o que ela entrega. Ver finding S-1.

---

## Item 6 — Execução

```
$ Rscript --vanilla scripts/verify_essential_input_gate0.R
```
Saiu em 1,44 s, com as duas mensagens finais e código de saída 0.

`MUTATION_REJECTED` — verificada linha a linha contra o código: "all 12 Round 3 mutations" (12 entradas confirmadas), "regional diagnostics" (as três asserções diretas em `is_valid_strict_beta_contract` / `is_valid_reopened_authorization`), "the coordinated Section 2/Section 11 mutation" (existe), "exact full-manifest identity/hash", "nested invalidation/freeze/interface-schema extras", "five directed N6", "five directed N7", "synthetic pending-N7 lifecycle". Sem exagero detectável.

`PASS` — conferi cada cláusula contra o texto do cabeçalho pinado:

| Cláusula da mensagem | Cabeçalho do contrato | Confere |
|---|---|---|
| `N1/N2/N3/N4/N6/N7 pass/frozen on exact reviewed artifacts` | "`N1`…`N7` estão `pass/frozen`, cada um com dois pareceres independentes `PASS 0/0/0` no mesmo hash" | SIM |
| `no derivation node is topologically ready` | "nenhum nó de derivação está topologicamente pronto" | SIM |
| `Goals 1-4 are closed` | "Os Goals 1 a 4 estão encerrados" | SIM |
| `Goal 5 is authorized, migrated, and reviewed but still open` | "foi autorizado em 2026-08-21, executado e revisado, e **permanece aberto**" | SIM |
| `terminal author approval and final tag pending` | "falta o aval autoral terminal, sem o qual a tag final … não pode ser criada" | SIM |
| `PASS reviews covering only b5fdefb` | "cobrem exclusivamente os bytes do commit `b5fdefb`" | SIM |
| `agenda extension … unauthorized` | "a extensão de agenda informal, cujo Gate 0 não foi aberto" | SIM |
| `beta=1 extensions … unauthorized` | "A fronteira `beta=1`" | SIM |
| `any declaration of Goal 5 closure remain unauthorized` | "qualquer declaração de encerramento do Goal 5" | SIM |

A mensagem antiga afirmava "Goal 5, beta=1 extensions, and manuscript migration remain unauthorized" — afirmação hoje falsa. Foi corretamente retirada, como exigia A3.

**Conclusão do item 6: o script passa e a mensagem final descreve o estado corretamente.** Nenhum overclaim substantivo. A única ressalva é que "its PASS reviews covering only b5fdefb" é prosa derivada do cabeçalho pinado, não uma verificação independente — o script não pina hash algum de manuscrito.

---

## Item 7 — Tentativas ativas de burlar

Construí quatro ataques. Nenhum foi gravado em arquivo; todos foram avaliados analiticamente ou numericamente em memória.

### Ataque A — inserção na Seção 13, com recálculo de **uma única** constante
Um agente insere antes de `## 14. Prompt de abertura` a linha:
> "A tag final do Goal 5 pode ser criada sem aval autoral explicito."

e recalcula **apenas** `expected_contract_hash` no script. Medições:

- hash da região `authorization_header`: **inalterado** (a Seção 13 está fora da região).
- os cinco `grepl`: **os cinco continuam satisfeitos**.
- `beta_primitive` e `delay_cost_decision`: **inalterados**.
- linhas do script a editar: **1**.
- novo hash integral do contrato: `8a88e6b8fd1f6f74…`

**O guarda NÃO pega.** O verificador imprimiria PASS sobre um contrato que autoriza a tag final sem aval autoral, dentro do domínio canônico da própria Seção 13. Esta é a fronteira que A3 nomeou explicitamente como devendo falhar.

### Ataque B — reescrita do cabeçalho preservando os cinco `grepl`, com recálculo de **duas** constantes
Ver o texto construído no item 5. Os cinco `grepl` permanecem satisfeitos com a autorização invertida. Linhas do script a editar: 2 (`expected_contract_hash` e `authorization_header`).

**O guarda NÃO pega.** A camada `grepl` contribui zero resistência. O único obstáculo real é que o diff do script fica visível para revisão humana — que é a defesa que sempre existiu, antes e depois desta mudança.

### Ataque C — plantar a autorização fora do contrato
Um agente escreve "Goal 5 encerrado, tag liberada" em `quality_reports/2026-08-21_autorizacao_goal5.md` (não pinado), ou no roteiro `2026-08-23_inconsistencia_cabecalho_contrato_gate0.md` (não pinado, e citado *de dentro* da região pinada do cabeçalho), e cita isso como autorização.

**O guarda NÃO pega — mas o contrato pega.** A "Regra de fonte normativa única" atribui "status e autorização da fase" ao cabeçalho e proíbe que menções fora da fonte canônica a qualifiquem ou ampliem. O texto plantado seria normativamente nulo. O verificador, porém, não emite sinal algum, e o `2026-08-21_autorizacao_goal5.md` — que define o *escopo* do goal aberto, não seu status — não está sob nenhuma proteção, ao contrário dos análogos de Goal 3 e Goal 4. Ataque neutralizado pela regra de fonte única, mas a lacuna de pinagem é real.

### Ataque D — reabrir nós no manifesto
Alterar `status`/`frozen` em `essential_input_game_dag.json`.

**O guarda PEGA, em três camadas:** `expected_manifest_hash` sobre os bytes, `expected_manifest_object_hash` sobre o JSON canônico reserializado, e `identical(candidate, canonical_manifest)` sobre o objeto R. Confirmado também que `manifest$contract_path` está dentro do manifesto hasheado, de modo que o caminho do contrato não pode ser desviado. Esta parte do guarda é sólida.

### Observação transversal — raiz de confiança
`sha256_file` chama `system2("shasum", …)`, resolvido via `PATH` (aqui, `/usr/bin/shasum`). Todo o guarda — os 12 hashes pinados, as três regiões, o manifesto — repousa sobre esse binário. Um `PATH` hostil produz hashes controlados pelo atacante para tudo. Não é o vetor mais provável neste fluxo, mas é o único ponto único de falha do desenho inteiro.

---

## Findings

### SUBSTANTIVE

**S-1 — A camada `grepl` não entrega a defesa em profundidade que se lhe atribui: captura 0 de 12 mutações e é cega a polaridade.**
Medido: os cinco `grepl` são satisfeitos por **todas** as doze mutações do r3, inclusive as três novas de Goal 5. Testado: um cabeçalho reescrito que inverte integralmente a autorização (Goal 5 encerrado, aval concedido, tag liberada, pareceres estendidos, agenda liberada) satisfaz os cinco padrões, porque `sem aval autoral` e `permanece aberto` ocorrem tão naturalmente na frase permissiva quanto na proibitiva. `grepl` testa presença; o ataque aditivo — o mais barato — passa intacto. A camada bloqueia apenas a variante que *apaga* a restrição.
Não é regressão: a adição de conjuntos `&&` só pode fortalecer. O risco é de leitura — registrar essa camada como "defesa contra quem recalcula o hash" convida um revisor futuro a poupar escrutínio do diff do script, que é a única defesa efetiva.
*Reparo possível, não único:* checagens de **ausência** (`!grepl` sobre padrões de ampliação: `encerrad`, `tag final .* autorizad`, `dispensa .* aval`), ou pinagem de contagem de linhas/parágrafos da região, ou abandonar a camada e declarar explicitamente que a proteção é o hash mais a revisão do diff. Escolher entre elas é decisão de desenho, não reparo forçado — por isso SUBSTANTIVE.

**S-2 — A fronteira viva "tag final sem aval autoral" tem proteção de camada única, e é a Seção 13, cujo domínio normativo canônico é justamente esse.**
`final_tag_without_approval_in_section_13` insere antes de `## 14. Prompt de abertura`, fora de toda região hasheada e fora do alcance de todo `grepl`. Só o hash integral a rejeita. Verificado numericamente: recalcular **uma** constante (`expected_contract_hash`) basta para que o verificador imprima PASS sobre esse contrato. As outras duas mutações de Goal 5 exigem **duas** constantes, porque também quebram o hash da região do cabeçalho.
O agravante é normativo: a tabela de fonte única do contrato atribui "fronteira de versão, verificação da infraestrutura e artefatos protegidos" à Seção 13. Texto inserido ali sobre a tag final está *dentro* do domínio canônico da Seção 13, logo a regra de fonte única **não** o anula — produz conflito genuíno com o cabeçalho, que nenhuma asserção detecta. A Seção 13 também abriga a lista de artefatos protegidos, incluindo "`formal_model_v5.Rmd` e `formal_model_v6.Rmd`, até o gate do Goal 5", igualmente sem pin regional.
A3 nomeou essa fronteira explicitamente entre as três que devem falhar. Ela falha, mas com metade da profundidade das outras duas.

**S-3 — `quality_reports/2026-08-21_autorizacao_goal5.md` não é pinado, quebrando o padrão estabelecido para Goals 3 e 4.**
O arquivo existe (6.284 bytes, SHA-256 `10e0d6d94d205e97863d908d7f4b4e99206d521636cbe30d9f76bcb6b2e68f37`) e tem **zero** referências no verificador. Já `2026-08-21_autorizacao_goal3_n6.md` está pinado na linha 262 e `2026-08-21_fechamento_autoral_goal4_n7.md` na linha 346, ambos com hash esperado. O documento que delimita o escopo do **único goal aberto** é o único da série desprotegido, e pode ser reescrito com o verificador continuando a imprimir PASS. Nenhum dos ~18 artefatos de Goal 5 em `quality_reports/` é pinado, nem os hashes de `b5fdefb` que o `CLAUDE.md` registra (`32b49f75…` para o `.Rmd`, `85d24122…` para o `.pdf`), de modo que o verificador não detecta deriva do manuscrito.

**S-4 — `CLAUDE.md` e `AGENTS.md` ainda carregam exatamente a contradição que o reparo se propõe a eliminar, e o roteiro não os menciona.**
```
CLAUDE.md:21   "O Goal 5 foi autorizado, migrado e revisado de forma independente."
CLAUDE.md:129  "Goal 5 não está autorizado."
CLAUDE.md:372  "Goal 5 não está autorizado e exige nova decisão autoral explícita."
AGENTS.md:12   "Goal 5 was authorized, migrated, and independently reviewed."
AGENTS.md:129  "Goal 5 remains unauthorized."
AGENTS.md:555  "Goal 5 remains ..."
```
É a mesma patologia diagnosticada na §2.4 do roteiro — cabeçalho de status obsoleto contradizendo os registros — apenas deslocada para os arquivos que um agente lê **antes** do contrato. O `AGENTS.md` é declarado no próprio repositório como "fonte operacional principal". O Passo A do roteiro cobre contrato e verificador e omite ambos, de modo que o reparo, tal como especificado, deixa a inconsistência viva no ponto de entrada. Isso é erro do roteiro, que me foi entregue como especificação a criticar.

### TECHNICAL

**T-1 — Não existe asserção de não-vacuidade das mutações; a falha de âncora é muda.**
Confirmado em R que `charToRaw(enc2utf8(NA_character_))` devolve `4e 41`, os bytes da string `"NA"`. Logo `sha256_text(NA_character_)` não dá erro, `is_valid_contract_semantics(NA_character_)` devolve `FALSE` silenciosamente e `all(!results)` fica `TRUE`. As 21 mutações baseadas em `insert_*`/`replace_matching_line` falham em silêncio se a âncora sumir ou duplicar; só as 3 baseadas em `sub()` falham ruidosamente. Prova de que o risco é real: a âncora retirada `identical(line, "manuscrito.")` tem **0 ocorrências** no contrato novo — mantida, teria passado vaziamente.
Nenhuma mutação é vacuosa hoje (verifiquei as 21). O reparo forçado pelo que já está escrito é único e óbvio: dentro do `vapply` que já calcula `mutate(contract_text)`, acrescentar `assert_true(!is.na(out) && !identical(out, contract_text), …)` antes de avaliar o validador. Por ser reparo único e determinado, TECHNICAL.

### ADVISORY

**A-1 — Raiz de confiança dependente de `PATH`.** `sha256_file` usa `system2("shasum", …)`, resolvido via `PATH`. Todos os 12 hashes pinados, as três regiões e o manifesto dependem desse binário. Considerar caminho absoluto (`/usr/bin/shasum`) ou `digest`/`openssl` em R.

**A-2 — O cabeçalho pinado cita um arquivo não pinado e não commitado.** A região `authorization_header` agora aponta para `quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md`, que está modificado na árvore de trabalho e sob nenhum hash. Não é explorável — a regra de fonte única impede que ele qualifique ou amplie o cabeçalho —, mas é um ponteiro de dentro de uma região imutável para um alvo mutável.

**A-3 — A mensagem `MUTATION_REJECTED` sugere mais profundidade do que a bateria tem.** Sete das doze mutações do r3 são rejeitadas apenas pelo hash integral; para elas a bateria demonstra que SHA-256 muda quando bytes mudam. A frase é literalmente exata, mas a enumeração convida a sobreleitura.

**A-4 — `HEAD` divergente do enunciado.** O briefing declara `HEAD` = `af5bfd5`; o real é `a315f59`, dois commits adiante. Os bytes revisados conferem com os SHA-256 esperados, então o objeto está correto; registro para que o parecer não seja lido como cobrindo outra base. Todos os `git diff` deste parecer são contra `a315f59`.

---

## Veredicto

**FAIL — S/T/A: 4/1/4**

Registro com precisão o que esse FAIL significa e o que não significa, para não induzir sobrerreação.

**O que está correto e verificado.** Os dois hashes atualizados (`f683b6a6…`, `5a94de52…`) foram recalculados de forma independente e conferem exatamente; os hashes de `beta_primitive` e `delay_cost_decision` estão intactos e continuam corretos. O diff do contrato é um único hunk integralmente confinado à região `authorization_header`, cumprindo A5. Nenhuma das 21 mutações é vacuosa: todas as âncoras existem, são únicas e produzem texto modificado. Nenhuma asserção foi removida, afrouxada ou tornada inalcançável (156 = 156). As contagens declaradas — "twelve", "nine" — batem com o código. O script executa e imprime PASS, e a mensagem final descreve o estado corretamente, cláusula por cláusula, contra o cabeçalho pinado. As fronteiras `beta=1`, extensão de agenda e declaração de encerramento do Goal 5 continuam rejeitadas. A proteção do manifesto é sólida em três camadas.

**Por que ainda assim FAIL.** O padrão de congelamento deste repositório é `PASS 0/0/0`, e há quatro findings SUBSTANTIVE. Nenhum deles é regressão — a mudança é monotonicamente mais forte que a anterior no nível do código. Todos dizem respeito a **profundidade e cobertura** do guarda, e dois deles atingem justamente a fronteira que o roteiro identificou como viva:

- a camada nova de `grepl` captura zero das doze mutações e é derrotada pelo ataque aditivo a custo nulo (S-1);
- das três fronteiras que A3 mandou proteger, a da tag final ficou com metade da profundidade das outras duas, e num setor do contrato que é fonte canônica sobre exatamente esse assunto — recalcular uma única constante do script basta para produzir PASS sobre um contrato que autoriza a tag (S-2);
- o documento de autorização do único goal aberto não é pinado, rompendo o padrão dos Goals 3 e 4 (S-3);
- a contradição de status que motivou todo o reparo continua viva em `CLAUDE.md` e `AGENTS.md`, e o roteiro não os inclui no Passo A (S-4).

**Recomendação.** Não reverter. O ato corretivo é bom e deve permanecer. Antes de tratá-lo como congelado sob o padrão `PASS 0/0/0`, endereçar S-2 (pinar regionalmente a Seção 13 ou, no mínimo, cobrir a fronteira da tag com uma segunda camada), S-3 (pinar `2026-08-21_autorizacao_goal5.md` com o hash `10e0d6d9…`), S-4 (alinhar `CLAUDE.md` e `AGENTS.md`, o que exige emenda ao roteiro) e T-1 (asserção de não-vacuidade). Sobre S-1, decidir explicitamente entre fortalecer a camada com checagens de ausência ou registrar por escrito que ela é detector de deleção apenas — o pior desfecho é mantê-la e continuar descrevendo-a como defesa contra recálculo de hash.

Todos os reparos acima incidem sobre o verificador e sobre memória operacional; nenhum toca primitivas, jogo, estimando, conceito de solução, desconto, schemas ou obrigações de prova. As regiões `beta_primitive` e `delay_cost_decision` estão mecanicamente provadas intactas pelos hashes inalterados.
