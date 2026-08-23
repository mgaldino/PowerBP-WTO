# Parecer — Revisão adversarial independente, rodada 2: guarda `verify_essential_input_gate0.R`

**Revisor:** agente independente, papel `game_theory` / auditoria adversarial
**Regime:** read-only estrito. Não chamei `Edit`, `Write` nem `NotebookEdit`. Nenhum arquivo foi criado, alterado ou apagado — nem no repositório, nem fora dele. Todo código auxiliar foi avaliado por `stdin` (`R --vanilla -q --no-echo <<'RS'`, `python3 - <<'PY'`), sem gravação. Registro a tensão com a regra global "salvar scripts antes de rodar": o mandato read-only desta tarefa é mais estrito e prevalece.
**Data:** 2026-08-23
**Rodada:** 2

---

## Objeto e hashes confirmados

`HEAD` verificado por mim: `6d88c0d06181561434300761feb7365846a33b68`, branch `codex/essential-input`. Confere com o enunciado.

| Arquivo | SHA-256 esperado | SHA-256 medido | Confere |
|---|---|---|---|
| `scripts/verify_essential_input_gate0.R` | `183f4677…1a578e` | `183f4677feaa397e60a86024b12c766241193a77e3a602d1ccda3d15351a578e` | SIM |
| `quality_reports/plans/2026-08-12_essential_input_gate0.md` | `ef38be13…2ac4ef` | `ef38be13c700baf78eab0819dbc7f06ae09c944945385c78370d00c4e52ac4ef` | SIM |

Árvore de trabalho (5 modificados, 1 não rastreado, nenhum staged):

```
 M AGENTS.md
 M CLAUDE.md
 M quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md
 M quality_reports/plans/2026-08-12_essential_input_gate0.md
 M scripts/verify_essential_input_gate0.R
?? quality_reports/plans/2026-08-23_prompt_goal0_agenda_extension_opus.md
```

Os dois primeiros são o escopo ampliado autorizado (decisão 3). Não prossegui com nenhuma parada: os hashes batem exatamente.

---

## Metodologia

1. `git rev-parse HEAD`, `git status --porcelain`, `shasum -a 256` nos dois objetos.
2. `git diff` completo dos cinco arquivos modificados.
3. Reimplementação independente em Python do algoritmo de regiões (`split("\n")` com descarte do campo final vazio → `unique_exact_line`/`unique_matching_line` → `"\n".join` → SHA-256 UTF-8), validada por reproduzir os **quatro** hashes canônicos, incluindo o novo.
4. Harness em R que faz `parse()` do próprio verificador e avalia **apenas** as atribuições às 23 funções/constantes de interesse — isto é, testei as funções **reais do script**, não paráfrases minhas. Uso de `LC_ALL=en_US.UTF-8` para literais acentuados.
5. Tabela de atribuição de camada para as 21 mutações de contrato: para cada uma, cálculo separado de hash integral, `authorization_header`, `protected_artifacts`, `beta_primitive`, `delay_cost_decision` e os cinco `grepl`.
6. Bateria de não-vacuidade: envenenamento das listas de mutação com âncora morta e com âncora duplicada, executando o corpo exato do `vapply` de cada laço.
7. Bateria de robustez: sete contratos malformados contra `extract_normative_contract_regions`.
8. Diff mecânico dos conjuntos de mensagens de `assert_true` entre `HEAD` e a árvore, com balanceamento de parênteses.
9. Oito ataques construídos e medidos em memória, com recontagem de constantes necessárias.
10. `Rscript --vanilla scripts/verify_essential_input_gate0.R` (execução completa).

---

## Item 1 — Hashes

Recalculei os quatro hashes de região independentemente, replicando o algoritmo. Todos batem.

| Objeto | Pinado no script | Recalculado | Confere | Mudou desde a rodada 1 |
|---|---|---|---|---|
| contrato integral | `ef38be13…2ac4ef` | idem | SIM | sim (`f683b6a6` → `ef38be13`) |
| `authorization_header` | `7ea2bdc4…6d9186` | idem | SIM | sim (`5a94de52` → `7ea2bdc4`) |
| `beta_primitive` | `bb7ee339…bf41b4` | idem | SIM | **não** |
| `delay_cost_decision` | `3c448385…bb8f2a` | idem | SIM | **não** |
| `protected_artifacts` (novo) | `0f3b64ac…b504f8e8` | idem | SIM | novo |

Verificações auxiliares: o arquivo termina com exatamente um `\n`, não contém `CR`, e `paste0(paste(readLines(...), collapse="\n"), "\n")` reconstrói o original byte a byte. Os oito marcadores de fronteira ocorrem **exatamente uma vez** cada, incluindo `## 13. Fronteira de vers` e `## 14. Prompt de abertura`; não há segundo `## 13` nem segundo `## 14` no arquivo.

A região `protected_artifacts` é o intervalo 1-based 1244–1281: da linha `## 13. Fronteira de versão, verificação e artefatos protegidos` até o `---` que precede `## 14`, exatamente como especificado.

**`beta_primitive` e `delay_cost_decision` continuam intactas.** Os dois hashes idênticos aos da rodada 1 são prova mecânica de que nenhum byte dessas regiões mudou. Nada relativo a primitivas, desconto ou custo de atraso foi tocado.

---

## Item 2 — A Seção 13 ficou de fato com duas camadas?

**Sim. Meu Ataque A da rodada 1 agora é pego.** Refiz o ataque exatamente como especificado: inserir na Seção 13, antes de `## 14. Prompt de abertura`, a linha *"A tag final do Goal 5 pode ser criada sem aval autoral explicito."*, e recalcular **apenas** `expected_contract_hash`.

Medição com as funções reais do script:

```
new whole-file hash: 5244c3ede37fca54c2efb78e1f03c40e16a75cbb4a3ad1296a8dffdf3ee7dbb0
   whole-file identity now passes : TRUE
   is_valid_reopened_authorization : TRUE
   is_valid_strict_beta_contract   : TRUE
   is_valid_protected_artifacts    : FALSE   <== NOVA CAMADA
   is_valid_contract_semantics     : FALSE
   VERDICT: guard CATCHES
```

**Qual asserção exatamente.** `is_valid_protected_artifacts`, incorporada ao quarto conjunto de `is_valid_contract_semantics` (linha 206). A captura é **ao vivo**, não apenas dentro da bateria de mutação: há dois pontos de enforcement sobre o contrato real, linhas 278–279 e 2247–2249, ambos `assert_true(is_valid_contract_semantics(contract_text), …)`. Este é o ponto que importava — um pino regional que só aparecesse dentro dos testes de mutação seria decorativo. Não é o caso.

Há ainda a asserção dedicada das linhas 2504–2514, que compõe `final_tag_without_approval_in_section_13` e exige `!is_valid_protected_artifacts(...)`, provando explicitamente que a fronteira falha **no pino regional, não só no hash de arquivo inteiro**. Verificado: essa asserção passa, e passa pela razão declarada.

Tabela completa de atribuição de camada (21 mutações, funções reais do script):

| Mutação r3 | full | hdr | **prot** | beta | delay | grepl | capturada por |
|---|---|---|---|---|---|---|---|
| `beta_exception_after_primitive` | REJ | pass | pass | pass | pass | pass | só hash integral |
| `unit_discount_in_rounds_primitive` | REJ | pass | pass | pass | pass | pass | só hash integral |
| `beta_exception_at_end_of_section_2` | REJ | pass | pass | pass | pass | pass | só hash integral |
| `goal5_closure_in_header` | REJ | **REJ** | pass | pass | pass | pass | integral + header |
| `goal5_terminal_approval_in_header` | REJ | **REJ** | pass | pass | pass | pass | integral + header |
| `goal5_reviews_extended_to_current_bytes` | REJ | **REJ** | pass | pass | pass | pass | integral + header |
| `agenda_authorization_in_section_11` | REJ | pass | pass | pass | pass | pass | só hash integral |
| `beta_exception_in_section_12` | REJ | pass | pass | pass | pass | pass | **só hash integral** |
| `citation_as_proof_in_section_13` | REJ | pass | **REJ** | pass | pass | pass | integral + Seção 13 |
| `contradiction_inside_hashed_header` | REJ | **REJ** | pass | pass | pass | pass | integral + header |
| `final_tag_without_approval_in_section_13` | REJ | pass | **REJ** | pass | pass | pass | **integral + Seção 13** |
| `imported_premise_inside_hashed_delay_decision` | REJ | pass | pass | pass | **REJ** | pass | integral + delay |

As nove mutações semânticas: as quatro de `header` quebram o hash de região do cabeçalho; as cinco de `delay` quebram o de `delay_cost_decision`. Nenhuma vacuosa.

Balanço: mutações capturadas por **duas ou mais** camadas subiram de 5/12 (rodada 1) para **7/12**. Os `grepl` continuam capturando **zero** de 12, exatamente como a nova nota do script declara.

---

## Item 3 — Não-vacuidade

**Cobertura dos dois laços: sim.** A asserção nova aparece em ambos — linha 2394 dentro do `vapply` de `semantic_mutations`, linha 2490 dentro do `vapply` de `r3_contract_mutations` — e ambas são avaliadas **antes** do validador, sobre o resultado da mutação.

**A asserção é ela própria não-vacuosa: testei, e ela dispara.** Envenenei cada laço com âncoras patológicas e executei o corpo exato:

| Cenário | Resultado |
|---|---|
| âncora inexistente (`## 99. Secao inexistente`) no laço r3 | **FIRED:** "A Round 3 contract mutation produced no change; its anchor is dead." |
| âncora **duplicada** (dois `## 12. Invalida`) no laço r3 | **FIRED:** mesma mensagem |
| âncora inexistente no laço semântico | **FIRED:** "A regional semantic mutation produced no change; its anchor is dead." |

O caso da âncora duplicada é importante e passa: `unique_matching_line` devolve `NA_integer_` tanto para zero quanto para duas ou mais ocorrências, e a asserção cobre os dois. A forma `!is.na(x) && !identical(x, contract_text)` também é segura contra retorno vetorial, porque `assert_true` usa `isTRUE()`.

**Há mutações fora desses dois laços ainda sujeitas a falha muda? Não.** Enumerei todos os sítios:

- **Mutações por `sub()`** — `old_beta_domain`, `missing_delay_cost`, `expanded_authorization`, `removed_v5_protection`. Estas falham **ruidosamente** por construção: `sub()` sem match devolve o texto inalterado, o validador devolve `TRUE`, e `assert_true(!TRUE)` para. Confirmei que as quatro âncoras ocorrem **exatamente uma vez** cada, e que `implica \`D>0\`` está dentro de `delay_cost_decision` e `agenda informal` dentro de `authorization_header` — isto é, cada `sub()` incide na região que sua asserção testa.
- **Chamadas diretas fora dos laços** — `section13_tag_mutation` (linha 2505), `coordinated_r3_contract_mutation` (2528–2533), `coordinated_contract_mutation` (2601). Todas reutilizam âncoras **já exercitadas dentro dos laços guardados**, que rodam antes (2394 e 2490 precedem 2505). A morte de qualquer uma dispara no laço primeiro. Cobertura transitiva completa.
- **Baterias N6, N7 e manifesto** — são mutações de **objeto** sobre `clone_object(...)`, não de âncora textual, e são estruturalmente imunes ao modo mudo: uma mutação que vira no-op deixa o objeto **válido**, o `vapply` devolve `TRUE`, e `all(!...)` falha **ruidosamente**. É o oposto exato do caso textual, em que a falha de âncora produzia um objeto inválido e portanto um `TRUE` silencioso na negação. Contagens conferidas: cinco fixtures N6, cinco N7.

**Conclusão do item 3: T-1 da rodada 1 está integralmente reparado, o reparo é não-vacuoso, e não sobrou exposição ao modo mudo em nenhuma bateria.**

---

## Item 4 — A nova região quebrou algo?

**Não. Testei sete contratos malformados; nenhum erro, todos devolvem `NULL`:**

| caso malformado | `regions` é NULL | `prot()` | `reopened()` | `semantics()` |
|---|---|---|---|---|
| Seção 13 sem cabeçalho | TRUE | FALSE | FALSE | FALSE |
| Seção 14 sem cabeçalho | TRUE | FALSE | FALSE | FALSE |
| cabeçalho da Seção 13 duplicado | TRUE | FALSE | FALSE | FALSE |
| Seção 14 movida para antes da 13 | TRUE | FALSE | FALSE | FALSE |
| string vazia | TRUE | FALSE | FALSE | FALSE |
| `NA_character_` | TRUE | FALSE | FALSE | FALSE |
| linha em branco isolada | TRUE | FALSE | FALSE | FALSE |

A guarda de ordem estendida (`protected_start >= protected_end`) funciona: inverter as seções devolve `NULL`. A guarda de `NA` foi corretamente estendida ao vetor de seis índices, e o `||` continua curto-circuitando na ordem certa — `primitives_start`/`primitives_end` são checadas por `is.na` antes de qualquer comparação que as use.

**Nenhuma outra função foi afetada.** Grep exaustivo: a lista de regiões é consumida somente pelos três validadores, **sempre por nome** (`regions$authorization_header`, `regions$protected_artifacts`, etc.), nunca por posição, `length()` ou `names()`. O quarto elemento não pode quebrar consumidor algum.

**Se a Seção 13 ou a 14 for renomeada, o comportamento é falha ruidosa, não muda.** Medido:

| ataque | constantes recalculadas | `regions` NULL | veredicto |
|---|---|---|---|
| renomear cabeçalho da Seção 13 | 1 | TRUE | **guarda pega** |
| renomear cabeçalho da Seção 14 | 1 | TRUE | **guarda pega** |
| duplicar o marcador da Seção 14 | 1 | TRUE | **guarda pega** |

Em todos os três casos a asserção viva da linha 279 dispara. A escolha de âncoras por prefixo (`## 13. Fronteira de vers`, `## 14. Prompt de abertura`) é adequadamente restritiva.

Registro um efeito colateral favorável não declarado: a nova região também dá segunda camada a `citation_as_proof_in_section_13`, que na rodada 1 era de camada única.

---

## Item 5 — Regressão da proteção de `v5`

**A asserção é não-vacuosa.** Medido: `RIO submission files/` ocorre **exatamente uma vez** no contrato, na linha 35, **dentro** da região `authorization_header` (linhas 3–49) e **fora** de `protected_artifacts`. A substituição altera o texto (`TRUE`) e `is_valid_reopened_authorization` devolve `FALSE`. A asserção testa o que diz testar.

**E é do tipo certo de canário.** Se um dia a cláusula for removida do contrato e os hashes recalculados, `sub()` vira no-op, `is_valid_reopened_authorization(contract_text)` devolve `TRUE`, e `assert_true(!TRUE)` **para ruidosamente**. Isto é estritamente mais forte que um `grepl`: detecta deleção com falha alta, ao passo que os cinco `grepl` estão presos atrás de um curto-circuito e nunca decidem nada. É o padrão que a camada `grepl` deveria ter usado.

**Mas cobre menos do que a mensagem afirma.** A mensagem é *"Removing the reasserted protection of v5, RIO files, and N1-N7 must fail."* — três itens. O teste ancora em **um**: `RIO submission files/`. Medições dos outros dois anchors possíveis:

| âncora | ocorrências | linhas |
|---|---|---|
| `formal_model_v5.Rmd` | 2 | 34 (cabeçalho) e 1275 (Seção 13) |
| `artefatos congelados de` | 1 | 35 |
| `RIO submission files/` | 1 | 35 |

Ambas seriam âncoras bem definidas — `sub()` pega a primeira ocorrência, que para `formal_model_v5.Rmd` é a do cabeçalho, e mesmo que essa fosse removida a substituição incidiria na Seção 13, deixando o cabeçalho intacto e disparando a asserção do mesmo modo. Isto é, o reparo é seguro nos dois sentidos. A assimetria é infeliz: o item que motivou toda a reasserção — `formal_model_v5.Rmd` — é justamente o que ficou sem canário, enquanto o item colateral tem um. Ver T-1.

**Há reescrita óbvia da cláusula de proteção que passaria?** Contra este canário isolado, não há reescrita que passe **e** preserve o hash do cabeçalho — qualquer edição no cabeçalho quebra `7ea2bdc4…`. Contra um atacante que recalcule os hashes, o canário é inerte, como qualquer teste sobre o texto canônico. Confirmei isso com o Ataque F abaixo: uma inversão **aditiva** do cabeçalho que preserva os cinco `grepl` **e** preserva `RIO submission files/` passa com duas constantes recalculadas.

---

## Item 6 — Enfraquecimento

**Contagem de `assert_true(`: 156 em `HEAD` → 161 na árvore. Diff +5.** Fiz o diff dos **conjuntos de mensagens** com balanceamento de parênteses, não por janela de texto:

```
--- REMOVIDAS (em HEAD, ausentes na árvore) ---
  (nenhuma)

--- ADICIONADAS ---
  1x The author authorization that scopes the still-open Goal 5 changed.
  1x A regional semantic mutation produced no change; its anchor is dead.
  1x A Round 3 contract mutation produced no change; its anchor is dead.
  1x …final tag without author approval must fail the regional pin, not only the whole-file hash.
  1x Removing the reasserted protection of v5, RIO files, and N1-N7 must fail.
```

**Nenhuma asserção removida, afrouxada ou tornada inalcançável.** As cinco adições correspondem exatamente aos três reparos autorizados (decisão 2), sendo que a não-vacuidade contou duas (um laço cada) e o pino da Seção 13 contou duas (a asserção regional dedicada mais o canário de `v5`). O diff é +106/−12 linhas.

A alteração de `is_valid_contract_semantics` é **monotonicamente mais forte**: ganhou um quarto conjunto `&&` e não perdeu nenhum. `extract_normative_contract_regions` ganhou dois marcadores e guardas correspondentes, sem afrouxar nenhuma condição existente.

**Contagens declaradas nas mensagens — todas conferem:**

| Declaração | Valor real medido |
|---|---|
| `"twelve Round 3 mutations"` / `"all 12 Round 3 mutations"` | `length(r3_contract_mutations) == 12` |
| `"nine regional semantic contradictions"` | 6 + 3 = 9 |
| `"five directed N6 mutations"` | 5 fixtures |
| `"five directed N7 mutations"` | 5 fixtures |

**Alcançabilidade:** o script corre até o fim e imprime as duas mensagens finais, o que só ocorre depois de todas as asserções top-level; as aninhadas estão em funções e laços efetivamente executados.

---

## Item 7 — Execução e mensagem final

```
$ Rscript --vanilla scripts/verify_essential_input_gate0.R
```
Termina com `MUTATION_REJECTED`, `PASS` e exit 0, em 1,70 s.

**As duas cláusulas novas da mensagem `PASS`, conferidas contra o texto do contrato:**

| Cláusula nova | Texto do contrato (região pinada, linhas 34–40) | Confere |
|---|---|---|
| *"formal_model_v5.Rmd, RIO submission files/, and the frozen N1-N7 artifacts are reasserted as protected"* | *"`formal_model_v5.Rmd`, a pasta `RIO submission files/` e os artefatos congelados de `N1` a `N7` permanecem protegidos e não autorizados para edição, por decisão autoral desta data."* | SIM |
| *"Section 13 now carries its own regional pin"* | claim sobre o verificador, não sobre o contrato; verificado verdadeiro: `protected_artifacts` pinado e imposto ao vivo | SIM |

As cláusulas pré-existentes continuam verdadeiras: `N1`–`N7` `pass/frozen` no mesmo hash; nenhum nó topologicamente pronto; Goals 1–4 encerrados; Goal 5 autorizado, migrado, revisado e **aberto**; aval terminal e tag pendentes; pareceres cobrindo só `b5fdefb`; agenda, `beta=1` e declaração de encerramento não autorizados. Cada uma tem correspondente literal no cabeçalho.

**Estado factual verificado independentemente:** `formal_model_v5.Rmd` e `RIO submission files/` estão limpos no `git status` e não foram tocados desde `21f5b7a`/`c761474`. `formal_model_v6.Rmd` corrente é `45c6bcbc…`, divergente do revisado em `b5fdefb` (`32b49f75…`) — exatamente como a ressalva do cabeçalho afirma. Nenhum dano ocorreu.

Duas ressalvas de leitura, em A-1 e A-2.

---

## Item 8 — Ataques novos contra o guarda atual

Oito ataques, nenhum gravado em arquivo, todos medidos em memória com as funções reais do script.

### Ataque 1 — Seção 13, tag final, **1 constante** *(explora a região nova)*
Inserir na Seção 13 a autorização da tag e recalcular só `expected_contract_hash`.
**PEGA.** `is_valid_protected_artifacts` devolve `FALSE`; asserção viva da linha 279 dispara. Era o buraco da rodada 1; está fechado.

### Ataque 2 — Seção 13, tag final, **2 constantes** *(explora a região nova)*
O mesmo, recalculando também `expected_contract_region_hashes[["protected_artifacts"]]`.
**NÃO PEGA.** É a escalação inevitável de qualquer pino regional: o custo do atacante sobe de uma para duas linhas visíveis no diff do script. Registro para calibrar expectativa — o pino regional compra **legibilidade do diff**, não uma fronteira de segurança nova.

### Ataque 3 — mesma frase na **Seção 14** ou no fim do arquivo, **1 constante**
**NÃO PEGA** pelo verificador, mas é **normativamente inerte**. A Seção 14 se autoneutraliza no próprio texto — *"Este prompt é apenas um índice e não concede autorização nem reformula regra alguma"* — e a tabela de fonte única atribui "status e autorização da fase" exclusivamente ao cabeçalho. Diferença material em relação ao Ataque A da rodada 1, que plantava a frase na Seção 13, o domínio canônico de "fronteira de versão … e artefatos protegidos". O reparo acertou o alvo certo.

### Ataque 4 — esvaziar a lista de protegidos da Seção 13, **2 constantes**
Trocar `- \`formal_model_v5.Rmd\` e \`formal_model_v6.Rmd\`, até o gate do Goal 5;` por `- nenhum manuscrito permanece protegido;`.
**NÃO PEGA** pelo verificador, **mas não obtém nada**: o cabeçalho continua intacto e continua reasserindo a proteção de `v5`, RIO e `N1`–`N7`. Para desfazer a proteção o atacante precisaria editar também o cabeçalho, exigindo uma **terceira** constante. Aqui a reasserção do cabeçalho faz trabalho real e mensurável.

### Ataque 5 — carve-out de invalidação na **Seção 12**, **1 constante**
Inserir antes de `## 13.`: *"Excecao de invalidacao: beta=1 pode ser usado sem reabrir o Gate 0."*
**NÃO PEGA**, e diferentemente do Ataque 3 é **normativamente eficaz**: a tabela de fonte única atribui "invalidação" à Seção 12, e a própria cláusula do cabeçalho remete — *"reabre o Gate 0 e devolve todos os nós a `pending`, **conforme a Seção 12**"* —, isto é, o cabeçalho **defere** à Seção 12 em vez de legislar. Ver S-2.

### Ataque 6 — inversão **aditiva** do cabeçalho preservando os cinco `grepl`, **2 constantes**
Inserir na região do cabeçalho uma frase que contém as cinco substrings com polaridade invertida.
Medido: os cinco `grepl` **satisfeitos**, `RIO submission files/` **preservado**, autorização invertida. **NÃO PEGA** com duas constantes. Confirma que a nota documental nova é honesta e que a decisão 1 estava certa.

### Ataque 7 — plantar autorização nos arquivos de memória, **0 constantes** *(explora `CLAUDE.md`/`AGENTS.md`)*
Escrever em `AGENTS.md` — declarado no repositório como "fonte operacional principal" e lido **antes** do contrato — algo como *"O autor concedeu o aval terminal do Goal 5; a tag final está autorizada."*
**NÃO PEGA.** O verificador tem **zero** referências a `AGENTS.md` e `CLAUDE.md` (medido: `grep -c` = 0), e pinar arquivos de memória vivos é inviável por construção. O ataque é neutralizado apenas pela Regra de fonte normativa única, e só para o agente que leia o contrato e a aplique. Prova empírica de que o canal é vivo: a contradição de status reparada agora (S-4 da rodada 1) sobreviveu vários dias exatamente nesses arquivos, sem nenhum mecanismo a detectar. Ver A-4.

### Ataque 8 — renomear ou duplicar os marcadores das Seções 13/14, **1 constante**
**PEGA, ruidosamente**, nos três casos, via `regions == NULL`. Ver item 4.

### Observação transversal
`sha256_file` continua chamando `system2("shasum", …)` resolvido por `PATH`. Os treze hashes pinados, as quatro regiões e o manifesto repousam nesse binário. Carregado de A-1 da rodada 1, ainda válido.

---

## Findings

### SUBSTANTIVE

**S-1 — A reasserção legisla, a partir do cabeçalho, sobre "artefatos protegidos", domínio que a tabela de fonte única atribui à Seção 13; a tabela e a Seção 13 ficaram inalteradas, e o parágrafo novo declara-se "a fonte canônica".**

O parágrafo acrescentado ao cabeçalho tem por título literal **"Artefatos protegidos, reasserção de 2026-08-23"** — o termo de arte que a tabela de fonte única usa para nomear o domínio da Seção 13 — e afirma: *"esta reasserção a restabelece **na fonte canônica**, sem depender daquela limitação temporal."*

A tabela, byte-idêntica e não emendada, diz o contrário:

| Conteúdo normativo | Fonte única |
|---|---|
| status e autorização da fase | cabeçalho acima |
| fronteira de versão, verificação da infraestrutura e **artefatos protegidos** | **Seção 13** |

E a regra que a acompanha é explícita: *"Menções fora dessa fonte servem apenas para explicar, usar o objeto já definido ou apontar para a seção correspondente; não podem qualificá-lo, ampliá-lo nem criar exceções."* Estender a proteção de `v5` para além do horizonte que a Seção 13 fixou ("até o gate do Goal 5", gate que passou) é precisamente **ampliá-la**.

O tell é comparativo, e está no próprio cabeçalho. Quando ele toca invalidação, ele **aponta**: *"reabre o Gate 0 … **conforme a Seção 12**"* — exatamente o que a regra permite. Quando toca artefatos protegidos, ele **desloca**: *"sem depender daquela limitação temporal"*. As duas construções não podem ambas estar corretas sob a mesma regra.

Consequência prática, e é assimétrica: sob a leitura de que o cabeçalho é canônico, `v5` está protegido e o reparo funcionou; sob a leitura de que a Seção 13 é canônica, o parágrafo do cabeçalho é uma menção ultra vires que não pode criar proteção, a cláusula da Seção 13 caducou, e `formal_model_v5.Rmd` está **desprotegido** — isto é, o defeito que o reparo existia para fechar continua aberto. A cláusula de salvaguarda *"Decisão autoral posterior prevalece sobre registro histórico incompatível"* não resolve: a Seção 13 não é registro histórico, é seção corrente do mesmo contrato.

Registro com igual ênfase o que **não** é o caso: nenhum dano ocorreu (`v5` e `RIO submission files/` estão byte-idênticos e limpos), a intenção autoral é inequívoca, e o texto implementa fielmente o reparo que o parecer `formal_design` recomendou. O defeito é que o contrato, lido pelas suas próprias regras, não entrega essa intenção sem ambiguidade — e ambiguidade escala.

*Reparos possíveis, não único (por isso SUBSTANTIVE):* emendar a Seção 13 removendo o limite temporal para `v5`; ou emendar a linha da tabela para atribuir artefatos protegidos ao cabeçalho; ou reescrever o parágrafo como remissão (*"a proteção de `v5` … permanece nos termos da Seção 13, cuja limitação temporal fica sem efeito por decisão autoral desta data"*), o que o converte de legislação em aviso. Escolher entre elas é decisão de desenho.

**S-2 — Das cinco fronteiras que o próprio cabeçalho declara não autorizadas, quatro passaram a ter duas camadas e uma continua com uma só, com efeito normativo dentro do domínio: `beta=1` pela Seção 12.**

Mapa medido, por domínio canônico:

| Fronteira do bloco "Não autorizado" | Domínio canônico | Pino regional |
|---|---|---|
| tag final do Goal 5 sem aval | Seção 13 + cabeçalho | **sim, duas** |
| declaração de encerramento do Goal 5 | cabeçalho | sim |
| extensão dos pareceres aos bytes correntes | cabeçalho | sim |
| extensão de agenda informal | cabeçalho (autorização de fase) | sim |
| **fronteira `beta=1`** | Seção 2 (linha `Desconto`) + Seção 3 (custo de atraso) + **Seção 12 (invalidação)** | **parcial — Seção 12 sem pino** |

O Ataque 5 mede a consequência: inserir na Seção 12 *"Excecao de invalidacao: beta=1 pode ser usado sem reabrir o Gate 0."* exige **uma** constante recalculada e produz `PASS`. E é eficaz, não inerte: a tabela atribui invalidação à Seção 12, e a cláusula do cabeçalho sobre `beta` explicitamente **remete** à Seção 12 em vez de legislar sobre ela. Uma exceção plantada ali não é neutralizada pela regra de fonte única — ela vence.

Isto é estruturalmente o mesmo finding que o autor aceitou e reparou para a Seção 13 na rodada 1, deslocado de seção. Não o levanto para pedir regresso infinito, e digo isso explicitamente: **o valor marginal de um pino regional é exatamente uma linha a mais no diff do script que um revisor independente precisa notar** — é dispositivo de legibilidade, não fronteira de segurança; o hash de arquivo inteiro já rejeita tudo. Mas o critério que o autor aplicou em 2026-08-23 foi "a fronteira viva merece segunda camada", e a fronteira `beta=1` é a única do bloco que ainda tem uma rota de camada única em domínio próprio. Fechar por pino ou fechar por decisão registrada de que a cobertura basta são ambas respostas defensáveis — por isso SUBSTANTIVE e não TECHNICAL.

### TECHNICAL

**T-1 — O canário de regressão da proteção reasserida ancora em um dos três artefatos que a mensagem nomeia, e o que ficou sem canário é justamente `formal_model_v5.Rmd`.**

A asserção testa a remoção de `RIO submission files/` e declara *"Removing the reasserted protection of v5, RIO files, and N1-N7 must fail."* Uma emenda futura que remova do cabeçalho a menção a `formal_model_v5.Rmd` ou à cláusula `N1`–`N7`, recalculando os hashes, **passa em silêncio** — que é exatamente o modo de falha que T-1 da rodada 1 identificou, aplicado ao objeto que o reparo existia para proteger.

O reparo é **único e forçado pelo que já está escrito**: replicar o padrão `sub()` que já está no arquivo para as duas âncoras faltantes. Verifiquei que ambas são bem definidas — `artefatos congelados de` ocorre uma vez (linha 35); `formal_model_v5.Rmd` ocorre duas (linhas 34 e 1275), e `sub()` pega a do cabeçalho, sendo que mesmo o caso degenerado dispara ruidosamente porque a substituição na Seção 13 deixa o cabeçalho intacto e o validador devolve `TRUE`. Reescrever a mensagem para nomear só o RIO não é alternativa admissível: contradiria o registro autoral do roteiro, que declara *"teste de regressão que falha se **ela** for removida"*, referindo-se à cláusula inteira. Reparo único ⇒ TECHNICAL.

**T-2 — A mensagem de diagnóstico do enforcement ao vivo enumera três regiões e não inclui a quarta, de modo que uma deriva só na Seção 13 acusa três regiões que não mudaram.**

`is_valid_contract_semantics` passou a checar quatro regiões (linha 206), mas a mensagem da asserção viva das linhas 280–282 continua enumerando três. Medido, com deriva apenas na Seção 13 e o pino de arquivo inteiro recalculado:

```
  reopened_authorization : TRUE
  strict_beta_contract   : TRUE
  protected_artifacts    : FALSE   <-- a que falhou
Mensagem que o operador vê:
  "The canonical authorization header, beta primitive, or complete strict-delay
   decision differs from its exact author-approved regional object/hash."
```

O operador é mandado investigar as três regiões que **passaram** e não é informado da que **falhou**. É defeito introduzido por este diff: a região nova foi ligada ao conjunto e não ao diagnóstico. O reparo é único e forçado — acrescentar a região de artefatos protegidos à enumeração da mensagem. A segunda asserção viva (linha 2248) tem mensagem genérica sobre `beta<1` e herda a mesma imprecisão.

### ADVISORY

**A-1 — A cláusula `PASS` "are reasserted as protected" convive com cláusulas que são fatos verificados, e não é uma delas.** O verificador pina treze hashes: contrato, manifesto (×2) e dez registros de `quality_reports/`. Pina **zero** bytes de manuscrito ou de artefato de nó — não há referência a `formal_model_v5.Rmd`, a `RIO submission files/` nem aos arquivos de artefato de `N1`–`N7` (os `artifact_hash` do manifesto são apenas validados por formato e cruzados com as revisões, nunca contra arquivos em disco). A afirmação é verdadeira **sobre o texto do contrato**; o risco é que seja lida como "conferidos e inalterados". Confirmei por fora que de fato estão inalterados, mas não foi o guarda quem o disse.

**A-2 — "Section 13 *now* carries its own regional pin" é changelog dentro de uma mensagem de estado.** A mensagem `PASS` descreve o mundo para quem a lê sem histórico; "now" pressupõe um estado anterior invisível, e a cláusula descreve a construção interna do próprio verificador em vez do repositório. É a mesma disciplina de atemporalidade que o projeto impõe ao paper, aplicada a um artefato que não é o paper — daí ADVISORY.

**A-3 — "the independent full-contract identity" compartilha a constante com o primeiro pino externo.** A linha 271 (`sha256_file(contract_path)`) e a linha 203 (`sha256_text(text)`) são independentes em **mecanismo** — arquivo versus texto reconstruído — mas usam **a mesma** `expected_contract_hash`. Recalcular uma constante derrota as duas. A palavra "independent" na mensagem `MUTATION_REJECTED` merece qualificação. Carregado da rodada 1 e afiado.

**A-4 — Os arquivos de memória continuam sendo status duplicado sem guarda de recorrência.** A contradição foi corrigida nos dois arquivos (grep confirma zero ocorrências residuais de "Goal 5 remains unauthorized" / "não está autorizado"), e ambos ganharam ponteiro de canonicidade — *"The canonical source for phase status is the Gate 0 contract header"* / *"A fonte canônica do status da fase é o cabeçalho do contrato Gate 0"*. Isso reduz materialmente o Ataque 7. O que permanece: o bullet de fase de cada arquivo continua **reafirmando** o status em vez de apenas apontar para ele, e reafirmação é gerador de deriva — foi assim que a contradição nasceu. Pinar arquivos vivos é inviável; a resposta possível é substituir a reafirmação por remissão, ou aceitar a duplicação e registrá-lo.

**A-5 — Raiz de confiança dependente de `PATH`.** `sha256_file` usa `system2("shasum", …)`. Considerar caminho absoluto ou `digest`/`openssl`. Carregado da rodada 1, inalterado.

**A-6 — O cabeçalho pinado continua citando um arquivo não pinado e não commitado.** A região `authorization_header` aponta para `quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md`, ainda modificado na árvore e sob nenhum hash. Ponteiro de dentro de região imutável para alvo mutável. Não explorável — a regra de fonte única o neutraliza —, mas recomendo commitar os cinco arquivos juntos, como o outro revisor também recomendou.

**A-7 — O roteiro descreve o reparo de forma inexata.** A Revisão 4, item 1, registra *"Cláusula acrescentada ao bloco `**Não autorizado.**` do cabeçalho"*. No contrato a cláusula é um **bloco próprio**, intitulado *"**Artefatos protegidos, reasserção de 2026-08-23.**"*, posicionado **depois** do bloco `**Não autorizado.**`. Ambos estão dentro da região pinada, então o efeito é nulo; mas o roteiro é o registro de proveniência da emenda, e um registro que descreve mal o artefato é o germe exato de deriva que esta arquitetura existe para impedir. Relaciona-se com S-1: a colocação em bloco separado, com título que ecoa o domínio da Seção 13, é o que torna o conflito de competência textualmente explícito em vez de inferencial.

---

## Veredicto

**FAIL — S/T/A: 2/2/7**

### O que os reparos entregaram, verificado e medido

Registro isto primeiro e sem hedging, porque a trajetória entre as rodadas é boa e o `FAIL` não deve ser lido como recuo.

- **S-2 da rodada 1 está fechado.** O Ataque A — inserir a autorização da tag final na Seção 13 e recalcular uma única constante — **agora é pego**, pela asserção `is_valid_protected_artifacts` incorporada a `is_valid_contract_semantics` e imposta ao vivo sobre o contrato real em dois pontos. Mutações com duas ou mais camadas subiram de 5/12 para 7/12.
- **T-1 da rodada 1 está fechado, e o reparo é ele próprio não-vacuoso.** Testei: as asserções disparam com âncora morta **e** com âncora duplicada, nos dois laços. Verifiquei que todos os sítios de mutação textual fora dos laços reutilizam âncoras já exercitadas dentro deles, e que as baterias de objeto (N6, N7, manifesto) são estruturalmente imunes ao modo mudo. Não sobrou exposição.
- **S-3 da rodada 1 está fechado.** `2026-08-21_autorizacao_goal5.md` pinado, hash `10e0d6d9…` conferido por mim.
- **S-4 da rodada 1 está fechado.** Zero contradições residuais em `AGENTS.md` e `CLAUDE.md`, e ambos ganharam ponteiro de canonicidade.
- **A decisão 1 foi cumprida com fidelidade.** A anotação nova do script descreve os `grepl` exatamente como eu os medi — avaliados após uma igualdade SHA-256 sobre a mesma string, testando presença e não ausência, satisfeitos por ataque aditivo, função documental. Reconfirmei as três afirmações. O roteiro A3 foi corrigido com a instrução literal *"Não descrever essa camada como defesa em profundidade"*. As duas ocorrências de "segunda camada" que restam no script referem-se ao **pino regional**, que genuinamente é uma segunda camada independente do hash de arquivo inteiro. Nada descreve mais os `grepl` como defesa.
- **Nenhum enfraquecimento.** 156 → 161 asserções, zero removidas, cinco adicionadas, todas as contagens declaradas corretas, região nova sem quebrar consumidor algum, extractor robusto em sete casos malformados, renomeação de seção falha ruidosamente.
- **`beta_primitive` e `delay_cost_decision` mecanicamente provadas intactas** pelos hashes inalterados. Nada de primitivas, desconto, jogo, estimando, conceito de solução, schemas ou obrigações de prova foi tocado.
- Script executa, `PASS`, exit 0, e cada cláusula da mensagem final é verdadeira contra o contrato.

### Por que ainda assim FAIL

O padrão deste repositório é `PASS 0/0/0`, e há dois findings SUBSTANTIVE e dois TECHNICAL. Nenhum é regressão; o guarda é monotonicamente mais forte que na rodada 1.

Respondendo diretamente à pergunta central do briefing — **ainda é possível ampliar a autorização e ver `PASS`?** Sim, mas o mapa mudou de forma relevante. Das cinco fronteiras que o cabeçalho declara não autorizadas, quatro exigem hoje **duas** constantes recalculadas e uma exige **uma**: a de `beta=1`, pela Seção 12, cujo domínio canônico é invalidação e à qual o próprio cabeçalho **defere** em vez de legislar (S-2). Fora dessas fronteiras, inserções nas Seções 1, 4–11, 14 e no fim do arquivo continuam de camada única, mas são normativamente inertes sob a regra de fonte única — inclusive a Seção 14, que se autoneutraliza no texto. O Ataque 3 confirma que o reparo mirou o alvo certo: a Seção 13 era o lugar onde a frase teria efeito; a Seção 14 não é.

Os dois findings que pesam mais são de coerência, não de cobertura:

- **S-1** é o mais sério. O reparo que fecha a lacuna de `v5` o faz legislando do cabeçalho para dentro do domínio que a tabela de fonte única atribui à Seção 13, com um parágrafo que se autodeclara "a fonte canônica" e que desloca a Seção 13 em vez de remeter a ela — ao contrário da cláusula vizinha sobre `beta`, que remete corretamente. A tabela e a Seção 13 ficaram inalteradas. O resultado é que **se `formal_model_v5.Rmd` está ou não protegido depende de qual de duas cláusulas não emendadas o leitor privilegia** — e as duas leituras dão respostas opostas para um artefato que o autor mandou não tocar. Nenhum dano ocorreu e a intenção autoral é inequívoca; o defeito é que o contrato não a entrega sem ambiguidade.
- **T-2** é pequeno mas é diagnóstico de processo: a região nova foi ligada ao conjunto de validação e não ao diagnóstico, de modo que uma deriva só na Seção 13 acusa três regiões intactas e silencia sobre a que falhou. Medi a mensagem exata que o operador veria.

### Recomendação

Não reverter. Os cinco reparos são bons, estão corretos, e três deles fecham findings da rodada 1 de forma verificável. Antes de tratar este estado como congelado sob `PASS 0/0/0`:

1. **S-1** — decidir e registrar qual seção é canônica para artefatos protegidos, e alinhar o texto: emendar a Seção 13, ou emendar a linha da tabela, ou reescrever o parágrafo do cabeçalho como remissão. Qualquer das três resolve; o silêncio não.
2. **S-2** — pinar regionalmente a Seção 12, ou registrar por escrito a decisão de que a cobertura de `beta=1` por `beta_primitive` e `delay_cost_decision` basta e que a rota da Seção 12 é aceita.
3. **T-1** — replicar o canário `sub()` para `formal_model_v5.Rmd` e para a cláusula `N1`–`N7`.
4. **T-2** — incluir a região de artefatos protegidos na mensagem de diagnóstico das linhas 280–282.
5. Commitar os cinco arquivos juntos (A-6), e manter O-1 como item separado, com autorização e revisores próprios, conforme a decisão 4.

Todos os reparos acima incidem sobre o cabeçalho do contrato, sobre o verificador e sobre proveniência. Nenhum toca primitivas, jogo, estimando, conceito de solução, desconto, schemas ou obrigações de prova — e as regiões `beta_primitive` e `delay_cost_decision` permanecem mecanicamente provadas intactas.
