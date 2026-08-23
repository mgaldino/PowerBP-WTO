# Parecer — Revisor independente `formal_design` (read-only), rodada 2
## Reparos do contrato Gate 0 essential-input, verificador, e alinhamento de `CLAUDE.md`/`AGENTS.md`

**Data:** 2026-08-23
**Papel:** `formal_design`, revisor independente, regime estritamente read-only
**Ângulo designado:** integridade normativa
**Declaração de conformidade:** não chamei `Edit`, `Write` nem `NotebookEdit`. Nenhum arquivo do repositório foi criado, alterado ou apagado. Toda escrita ficou confinada ao diretório de scratchpad da sessão, fora do repositório (`probe.R`, `probe2.R`, cópias de `git show`). Verificações por leitura, `git`, `shasum`, `grep`, `sed`, `perl`, `python3` e `Rscript` com saída para `stdout`.

---

## 1. Objeto e hashes confirmados

`HEAD` verificado por mim: `6d88c0d06181561434300761feb7365846a33b68`, branch `codex/essential-input`. Confere com o enunciado; os hooks de checkpoint não o moveram durante a revisão (reconferido ao final).

| Arquivo | SHA-256 medido | Esperado | Bate |
|---|---|---|---|
| `quality_reports/plans/2026-08-12_essential_input_gate0.md` | `ef38be13c700baf78eab0819dbc7f06ae09c944945385c78370d00c4e52ac4ef` | idem | sim |
| `scripts/verify_essential_input_gate0.R` | `183f4677feaa397e60a86024b12c766241193a77e3a602d1ccda3d15351a578e` | idem | sim |
| `CLAUDE.md` | `a9c1126a4aabb09e4226b41335e406c440d4b58b8f50cd2c68aa33e9336f2063` | idem | sim |
| `AGENTS.md` | `43b1d65adead195f7cbd2d625edd2db81ad94d775b02f70bb59923aed450749d` | idem | sim |
| `quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md` | `d586c1bfa9bf93ae1775244ac7271bf01c8e656b79a85c9c10126a643ef05d8f` | idem | sim |

Os cinco batem. Não parei.

**Árvore de trabalho:** exatamente os cinco arquivos modificados, nenhum staged, mais **um arquivo não rastreado** que não constava da rodada 1: `quality_reports/plans/2026-08-23_prompt_goal0_agenda_extension_opus.md`. Ele não integra o objeto declarado, mas é material para o item 2 e é tratado no finding S-2.

Confirmei também que `HEAD` já contém a versão revisada na rodada 1: o contrato em `HEAD` tem SHA-256 `f683b6a60cdd8a7085eafe0b803fa060dc931a592f2b70a144f881b1e437c462`, exatamente o hash que os dois pareceres da rodada 1 declaram ter revisado.

---

## 2. Metodologia

Comandos relevantes, todos read-only sobre o repositório:

```
shasum -a 256 <cinco objetos>
git rev-parse HEAD ; git status --porcelain ; git log --oneline -3 ; git diff --numstat
git diff -- <cada um dos cinco arquivos>
git show HEAD:<contrato> > <scratchpad>/head_contract.md
# confinamento construtivo
cat <(sed -n '1,2p' <contrato>) <(sed -n '3,42p' <scratchpad>/head_contract.md) \
    <(sed -n '50,$p' <contrato>) | shasum -a 256
sed -n '3,49p' <contrato> | perl -0pe 's/\n\z//' | shasum -a 256
sed -n '1244,1281p' <contrato> | perl -0pe 's/\n\z//' | shasum -a 256
sed -n '1237,1274p' <scratchpad>/head_contract.md | perl -0pe 's/\n\z//' | shasum -a 256
# artefatos congelados
python3 -c "<lê nodes de model_redesign/essential_input_game_dag.json>"
for f in <6 artefatos + DAG>; do shasum -a 256 "$f"; git show HEAD:"$f" | shasum -a 256; done
git status --porcelain formal_model_v5.Rmd "RIO submission files/"
# O-1
git status --porcelain quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md
shasum -a 256 quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md
grep -rln "94062c08…" . --exclude-dir=.git
# escopo memória operacional
grep -n "Goal 5" CLAUDE.md AGENTS.md
grep -n "não está autorizado\|remains unauthorized\|nova decisão autoral explícita" CLAUDE.md AGENTS.md
# execução
Rscript --vanilla scripts/verify_essential_input_gate0.R
Rscript --vanilla scripts/verify_essential_input_{n1,n2,n6,n7,solution_concept_rederivation}.R
Rscript --vanilla scripts/verify_essential_input_{numeric_boundaries,n1_numeric,n2_numeric,n3_numeric,n4_numeric}.R
git diff --check
# sondas adversariais (funções REAIS do script, extraídas por parse(); nenhum arquivo do projeto gravado)
Rscript --vanilla <scratchpad>/probe.R    # ataques A, B, C + comportamento de âncora morta
Rscript --vanilla <scratchpad>/probe2.R   # ataque D à tabela de fonte única
```

Não aceitei nenhuma afirmação do implementador nem do documento de diagnóstico. Cada item foi recomputado. As sondas R **avaliam as definições reais do verificador**, extraídas por `parse()` do próprio arquivo, não paráfrases minhas.

---

## 3. Achados por item do briefing

### Item 1 — S-1 da rodada 1 foi sanado?

**Parcialmente. A proteção substantiva foi restabelecida e é operativa; a forma escolhida cria um problema normativo novo. Ver S-1 abaixo.**

O texto acrescentado, integralmente:

> **Artefatos protegidos, reasserção de 2026-08-23.** `formal_model_v5.Rmd`, a pasta `RIO submission files/` e os artefatos congelados de `N1` a `N7` permanecem protegidos e não autorizados para edição, por decisão autoral desta data. A cláusula da Seção 13 limitava essa proteção ao gate do Goal 5, que já passou; esta reasserção a restabelece na fonte canônica, sem depender daquela limitação temporal.

**O que está certo, e é a maior parte.** A cláusula está dentro da região `authorization_header` (provado mecanicamente no item 3), nomeia os três conjuntos de artefatos sem elipse, registra explicitamente a caducidade da Seção 13 em vez de silenciá-la — que era o desfecho mínimo aceitável apontado na rodada 1 — e vem acompanhada de um teste de regressão no verificador (`removed_v5_protection`), que confirmei rejeitar a supressão. O núcleo operativo, *"não autorizados para edição"*, é asserção de **autorização**, competência que a tabela de fonte única atribui inequivocamente ao cabeçalho. Nesse ponto a proteção é válida e um agente que siga a Seção 14, item 2 (*"Tome a autorização corrente somente do cabeçalho"*), não editará `v5`. **Não há risco factual para `v5`, RIO ou os artefatos congelados**, e verifiquei que todos estão byte-idênticos (item 6).

**O que não está certo.** A cláusula foi escrita como **bloco autônomo intitulado com a expressão exata que a tabela de fonte única atribui à Seção 13** — "artefatos protegidos" — e não como cláusula do bloco `**Não autorizado.**`. Nessa forma ela faz três coisas que a Regra de fonte normativa única proíbe fora da fonte canônica: **amplia** a lista protegida (a Seção 13 não menciona `RIO submission files/` nem os artefatos de `N1`–`N7`; confirmei por leitura integral da seção), **qualifica** a cláusula da Seção 13 e **cria exceção** à sua limitação temporal. A regra é literal:

> Menções fora dessa fonte servem apenas para explicar, usar o objeto já definido ou apontar para a seção correspondente; não podem qualificá-lo, ampliá-lo nem criar exceções.

**Conflito com a Seção 13.** A Seção 13 continua dizendo, verbatim e agora sob pino regional próprio, *"`formal_model_v5.Rmd` e `formal_model_v6.Rmd`, até o gate do Goal 5"*. Esse gate passou. As duas afirmações coexistem em regiões independentemente hasheadas do mesmo documento.

**Um agente futuro chega à conclusão correta?** Na prática, sim, por dois caminhos: a Seção 14 manda tomar a autorização corrente **somente** do cabeçalho, e o núcleo operativo da cláusula é asserção de autorização. Em teoria, não necessariamente: um agente que aplique a tabela de fonte única literalmente tratará o conteúdo de *artefatos protegidos* do bloco como menção ampliadora fora da fonte, portanto normativamente nula, e lerá a Seção 13 sozinha — concluindo que a proteção de `v5` caducou e que RIO e `N1`–`N7` nunca estiveram na lista. Duas leituras defensáveis. Pela Seção 11.1, *"Ambiguidade e definição faltando nunca são técnicas… escalam sempre, sem exceção"*.

### Item 2 — Veracidade

**Íntegra quanto ao Goal 5. Uma não-autorização listada pode ter deixado de ser vigente — ver S-2.**

Reconferi cada asserção do cabeçalho contra o estado real:

- `N1`–`N4`, `N6`, `N7` `pass/frozen`, dois `PASS 0/0/0` no mesmo hash: verdadeiro; o manifesto está byte-idêntico a `HEAD` e todos os seis artefatos batem com os `artifact_hash` registrados.
- Nenhum nó topologicamente pronto: verdadeiro (não há nó `pending`/`unfrozen`).
- Goals 1 a 4 encerrados: inalterado desde a rodada 1, que o verificou.
- **Goal 5 continua descrito como aberto**: sim, literalmente *"**permanece aberto**: falta o aval autoral terminal, sem o qual a tag final pelo workflow `paper-version` não pode ser criada"*. Nenhuma sentença nova insinua encerramento.
- Ressalva dos pareceres restrita a `b5fdefb`: preservada intacta.
- Nenhuma não-autorização da redação anterior foi perdida: comparei o bloco `**Não autorizado.**` linha a linha entre `HEAD` e a árvore — ele é **byte-idêntico**; a cláusula nova foi acrescentada depois dele, sem remover nada.

O cabeçalho não passou a afirmar nada falso sobre o Goal 5. O problema de veracidade que encontrei é de sentido oposto e está em outra linha do mesmo bloco: a não-autorização da extensão de agenda pode já não ser vigente (S-2).

### Item 3 — Confinamento

**Provado mecanicamente, por identidade de bytes.**

Apliquei a definição do próprio verificador. Fronteiras medidas:

| Versão | `**Data:** 2026-08-12` | `### Regra de fonte normativa` | Região `authorization_header` |
|---|---|---|---|
| `HEAD` | linha 3 | linha 43 | 3–42 |
| árvore | linha 3 | linha 50 | 3–49 |

Reconstruí um arquivo sintético = `árvore[1–2]` + `HEAD[3–42]` + `árvore[50–fim]`, isto é, o contrato corrente com **apenas** a região `authorization_header` revertida:

```
reconstruído:        f683b6a60cdd8a7085eafe0b803fa060dc931a592f2b70a144f881b1e437c462
contrato em HEAD:    f683b6a60cdd8a7085eafe0b803fa060dc931a592f2b70a144f881b1e437c462
```

Identidade byte a byte, e o valor é exatamente o `expected_contract_hash` da rodada 1. **Logo o diff do contrato está 100% dentro de `authorization_header`**; todo o restante — preâmbulo, Regra de fonte normativa única e sua tabela, Seções 1 a 14 — é byte-idêntico a `HEAD`. O diff textual (um único hunk, `@@ -31,6 +31,13 @@`) corrobora.

**A Seção 13 foi alterada?** Não. Duplamente confirmado: (i) segue do confinamento acima; (ii) medi diretamente o hash da região da Seção 13 nas duas versões:

```
HEAD (linhas 1237–1274):      0f3b64ac2c54ea7ecc2c7896488ce8082405d115a3ec990100d28733b504f8e8
árvore (linhas 1244–1281):    0f3b64ac2c54ea7ecc2c7896488ce8082405d115a3ec990100d28733b504f8e8
```

Idênticos, e igual ao valor pinado em `expected_contract_region_hashes[["protected_artifacts"]]`. A Seção 13 foi **pinada sobre bytes não editados**, exatamente como a decisão autoral 4 previa. Correto.

Os quatro pinos regionais recomputados por mim batem: `authorization_header` = `7ea2bdc4…`, `beta_primitive` = `bb7ee339…` (inalterado), `delay_cost_decision` = `3c448385…` (inalterado), `protected_artifacts` = `0f3b64ac…`. Que `beta_primitive` e `delay_cost_decision` estejam inalterados é prova mecânica de que primitivas e a decisão de custo de atraso não foram tocadas.

### Item 4 — Escopo em `CLAUDE.md` e `AGENTS.md`

**Limitado a status do Goal 5. Nada entrou de carona. Nenhuma contradição sobreviveu.**

Diff completo: `CLAUDE.md` +8/−2 em dois hunks; `AGENTS.md` +9/−3 em dois hunks. Os quatro hunks tratam exclusivamente do status do Goal 5. Substituições:

| Arquivo | Antes | Depois |
|---|---|---|
| `CLAUDE.md:129` | "Goal 5 não está autorizado." | autorizado em 2026-08-21, migrado, revisado, **permanece aberto**; falta aval terminal; pareceres só cobrem `b5fdefb` |
| `CLAUDE.md:373` | "Goal 5 não está autorizado e exige nova decisão autoral explícita." | autorizado e aberto, à espera do aval terminal; aponta o registro; nomeia o cabeçalho como fonte canônica |
| `AGENTS.md:129` | "Goal 5 remains unauthorized." | idem, em inglês |
| `AGENTS.md:556` | "Goal 5 remains unauthorized and requires a new explicit authorial decision." | idem, em inglês |

Varri as duas memórias por `"Goal 5"` (6 ocorrências em `CLAUDE.md`, 5 em `AGENTS.md`) e por `"não está autorizado"` / `"remains unauthorized"` / `"not authorized"` / `"nova decisão autoral explícita"`: **zero ocorrências residuais**. As demais menções (`CLAUDE.md:21,23,580`; `AGENTS.md:12,13,559`) já eram compatíveis e não afirmam encerramento. As novas afirmações são verdadeiras e mutuamente consistentes, em ambos os idiomas, e espelham fielmente o cabeçalho. A S-4 da rodada 1 está sanada.

Registro como acerto de desenho a frase acrescentada em ambos — *"A fonte canônica do status da fase é o cabeçalho do contrato Gate 0"* / *"The canonical source for phase status is the Gate 0 contract header"*. Ela previne que a própria memória operacional vire segunda autoridade. É exatamente o oposto do erro que o cabeçalho comete em S-1.

### Item 5 — O-1 respeitado

**Sim, integralmente.**

- `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`: `git status` limpo, **não tocado**, SHA-256 ainda `9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f`.
- O pino `94062c08…` continua nos mesmos 17 arquivos (manifestos `.sha256`, `scripts/essential_input_formulas.R`, candidatos e pareceres). **Nenhum foi atualizado.** Verifiquei que `git diff -U0` não contém nenhuma linha alterando `94062c08`, `91892997` ou o caminho do arquivo.
- Nenhum artefato congelado mudou (item 6).
- Consequência inalterada e correta: `verify_essential_input_{numeric_boundaries,n1_numeric,n2_numeric,n3_numeric,n4_numeric}.R` continuam abortando. A camada numérica de `N1`–`N4` segue inoperante, exatamente como na rodada 1 — nem consertada por atalho nem agravada.

A decisão 5 foi cumprida à letra.

### Item 6 — Artefatos congelados

**Todos byte-idênticos a `HEAD`, e todos batendo com os `artifact_hash` do manifesto.**

| Artefato | SHA-256 | vs `HEAD` |
|---|---|---|
| `…/essential_input_interfaces/n1_r2_majority_candidate_v1.json` | `1a171791…d981b5` | idêntico |
| `…/essential_input_n2_r2_unanimity_interface.json` | `c6a65dc8…a85a2` | idêntico |
| `…/essential_input_solution_concept/n3_r1_majority_candidate.json` | `ff053798…47330d` | idêntico |
| `…/essential_input_solution_concept/n4_r1_unanimity_candidate.json` | `f1c82312…06408b` | idêntico |
| `…/essential_input_n6_private_comparison_candidate.json` | `a9cfd593…d90a5a92` | idêntico |
| `…/essential_input_n7_complete_information_benchmark_candidate.json` | `4e0169de…b49c45` | idêntico |
| `model_redesign/essential_input_game_dag.json` | `36155405…72abf9ab` | idêntico |

`formal_model_v5.Rmd`: `git status` limpo, hash `1b0e4201…620af` igual em árvore e `HEAD`. `RIO submission files/`: `git status` limpo, nenhum arquivo modificado ou não rastreado. `git diff --check` limpo.

O único arquivo não rastreado em todo o repositório é o prompt de coordenação da extensão de agenda (S-2); nenhum caminho protegido tem arquivo novo.

### Item 7 — Seção 12

**Nenhum gatilho de reabertura dispara. As duas mudanças citadas no briefing são as menos perigosas do conjunto.**

A §12 enumera quatro gatilhos, e nenhum alcança o que foi feito:

1. **Contrato do jogo** — estimando, escopo, primitivas, factibilidade, ações/transições/informação/implementação/payoffs, conceito de solução, desconto, topologia/schema, obrigações de prova. O confinamento do item 3 estabelece por identidade de bytes que **nenhum** desses conteúdos foi tocado: todos residem nas Seções 1, 2, 4, 5, 6, 7/7.2 e 9, fora da região alterada. `beta_primitive` e `delay_cost_decision` inalterados. Não dispara.
2. **Interface congelada** — item 6: nada mudou. Não dispara.
3. **Protocolo de revisão** — o gatilho é textualmente *"uma alteração da Seção 11"*. A Seção 11 é byte-idêntica. **A ampliação de escopo para `CLAUDE.md`/`AGENTS.md` não é alteração da Seção 11**: esses arquivos são memória operacional, não texto normativo do contrato, e a §12 não prevê gatilho para eles. Não dispara.
4. **Reparo de finding** — este é o caso aplicável: as cinco mudanças **são** reparos dos findings da rodada 1. A §12.4 diz que *"seu alcance de invalidação segue os itens anteriores"*, e nenhum dos anteriores dispara. Logo não há invalidação.

**A pinagem da Seção 13 merece nota específica, porque é o caso que mais convidaria ao erro.** Ela não é alteração da Seção 13 — o texto é byte-idêntico e o pino foi computado sobre os bytes de `HEAD`. É acréscimo ao **instrumento de verificação**, que a própria Seção 13 governa (*"verificação canônica da infraestrutura"*), e a §12 não trata mudança de verificador como evento de invalidação. Confirmei ainda que o instrumento continua sendo o mesmo arquivo referido sem qualificação pelo contrato, e que ele passa.

Quanto à autoria e autorização do reparo, a **Seção 11.1** foi respeitada: os findings da rodada 1 foram classificados pelos revisores, escalados ao autor com os pareceres completos salvos em disco, e o autor decidiu antes de qualquer reparo. Nenhum finding SUBSTANTIVE foi resolvido por iniciativa do implementador, e nenhum foi rebaixado — os cinco SUBSTANTIVE e o único TECHNICAL da rodada 1 receberam decisão autoral explícita, registrada.

**Execução, sem colateral.** `verify_essential_input_gate0.R` sai com código 0, `MUTATION_REJECTED` e `PASS`. `verify_essential_input_{n1,n2,n6,n7,solution_concept_rederivation}.R` todos passam.

**Verificação adversarial independente dos reparos** (sondas em R sobre as funções reais do script):

| Ataque | Resultado medido |
|---|---|
| A — inserir na Seção 13 autorização da tag final sem aval | pino regional `protected_artifacts` **rejeita**, independentemente do hash de arquivo. **S-2 da rodada 1 sanado**, confirmado por mim e não aceito da declaração |
| B — suprimir a proteção reasserida de `v5`/RIO | pino `authorization_header` **rejeita** |
| C — inserir fora de toda região pinada (fim da Seção 12) | nenhum pino regional cobre; só o hash integral rejeita |
| D — inserir linha nova na tabela de fonte única | nenhum pino regional cobre; só o hash integral rejeita — ver S-3 |
| âncora morta | `insert_before_matching_line` devolve `NA_character_`, cujo `sha256_text` é um hash válido de 64 hex dos bytes `"NA"` — o modo mudo confirmado; as novas asserções de não-vacuidade fecham isso nos dois laços |

`assert_true(` passou de 156 para 161: **cinco asserções acrescentadas, nenhuma removida**. As cinco são as duas de não-vacuidade, a do pino da Seção 13, a de remoção da proteção de `v5` e a do pino de `2026-08-21_autorizacao_goal5.md` (hash `10e0d6d9…`, que confirmei bater).

Sobre a decisão autoral 2, a nota nova no script é fiel e não overclaima:

> Eles NAO constituem defesa semantica contra quem edite o cabecalho e recalcule os hashes… `grepl` testa presenca e nao ausencia, de modo que um ataque aditivo os satisfaz. Sua funcao aqui e documental… A protecao efetiva e composta por hashes exatos, testes de regressao e revisao independente do diff.

Reproduz a decisão do autor com precisão, inclusive o mecanismo. Cumprido.

### Item 8 — Roteiro

**Registra a rodada 1 e as decisões com fidelidade. Descreve incorretamente o local de um reparo. Não há retro-ajuste da especificação ao entregável.**

O bloco "Revisão 4 — 2026-08-23" registra: os dois vereditos `FAIL` com os `S/T/A` exatos (1/0/5 e 4/1/4) e os caminhos dos dois pareceres; que nenhum revisor pediu reversão; as seis decisões autorais; a separação explícita de O-1 com a fórmula literal *"não autoriza restaurar arquivos, atualizar pinos nem alterar artefatos congelados"*; e a exigência de nova rodada de revisão independente antes de qualquer congelamento. Confirmei cada item contra os pareceres originais. A correção do A3 anterior (a nota "Sobre a natureza do guarda") **restringe** a especificação em vez de afrouxá-la, e é o oposto de retro-ajuste: o roteiro passou a exigir menos do guarda porque a rodada 1 provou que a exigência anterior era inatingível.

**A exceção.** O item 1 de "Revisão 4" afirma: *"Cláusula acrescentada ao bloco `**Não autorizado.**` do cabeçalho"*. Ela **não** foi acrescentada a esse bloco. O bloco `**Não autorizado.**` é byte-idêntico a `HEAD`; a cláusula é um parágrafo separado, com lead-in em negrito próprio, intitulado "**Artefatos protegidos, reasserção de 2026-08-23.**". Como no cabeçalho o lead-in em negrito é o delimitador de bloco usado em toda a seção, são blocos distintos. Isso importa porque o local descrito pelo roteiro — e recomendado literalmente pela rodada 1 — é justamente o que evitaria a colisão de domínio de S-1. O roteiro está certo e o entregável divergiu dele.

---

## Findings

### SUBSTANTIVE

**S-1 — A reasserção de artefatos protegidos foi escrita como bloco autônomo que invade o domínio canônico atribuído à Seção 13, contra a Regra de fonte normativa única; o roteiro descreve o local seguro, e o entregável divergiu dele.**

Fatos medidos, não inferidos:

1. A tabela de fonte única atribui *"fronteira de versão, verificação da infraestrutura e **artefatos protegidos**"* à **Seção 13**. O bloco novo intitula-se **"Artefatos protegidos**, reasserção de 2026-08-23" — a expressão exata da linha da tabela.
2. Li a Seção 13 integralmente: sua lista protege apenas (a) `2026-08-12_essential_input_gate0_decisions.md`, (b) `formal_model_v5.Rmd` e `formal_model_v6.Rmd` *até o gate do Goal 5*, (c) os artefatos da cadeia `pivotal-response`. **Nem `RIO submission files/` nem os artefatos de `N1`–`N7` aparecem**, confirmado por `grep`. O bloco novo, portanto, não reassere: **amplia** a regra de artefatos protegidos com dois conjuntos que sua fonte canônica nunca conteve.
3. O bloco **qualifica** a cláusula da Seção 13 e **cria exceção** à sua condição temporal, textualmente: *"sem depender daquela limitação temporal"*.
4. A Regra de fonte única proíbe as três coisas, nessas palavras: *"não podem qualificá-lo, ampliá-lo nem criar exceções"*.
5. O bloco declara operar *"na fonte canônica"*. Duas leituras: "neste arquivo" (o contrato se autodenomina *"única fonte normativa corrente"*) ou "na seção canônica desta regra" — que seria a Seção 13, tornando a frase autocontraditória. **A ambiguidade sobrevive às duas leituras**, porque a ampliação em (2) e a exceção em (3) permanecem sob qualquer delas.
6. A Seção 13 continua dizendo *"até o gate do Goal 5"*, gate que passou, e agora está **congelada nesses bytes sob pino regional próprio** — o conflito ficou fixado em duas regiões hasheadas independentes do mesmo documento.
7. O roteiro afirma que a cláusula foi posta no bloco `**Não autorizado.**`; não foi. A rodada 1 recomendara exatamente esse local. Ali, enquadrada como pura não-autorização, a cláusula estaria inteiramente dentro da competência do cabeçalho e **não haveria colisão alguma**.

**Proporcionalidade, dita com a mesma ênfase.** A proteção substantiva **funciona**: `"não autorizados para edição"` é asserção de autorização, competência do cabeçalho, e a Seção 14 manda tomar a autorização corrente somente dali. Verifiquei que `v5`, `RIO submission files/` e os sete artefatos estão byte-idênticos: **nenhum dano ocorreu e nenhum está iminente**. O finding é de arquitetura normativa, não de risco factual, e a rodada 2 melhorou o estado em relação à rodada 1, em que a restrição vivia inteiramente fora do contrato.

**Por que não classifico como técnico.** Há pelo menos três reparos defensáveis: (a) reescrever a cláusula dentro de `**Não autorizado.**`, sem o título "Artefatos protegidos" e sem "restabelece na fonte canônica" — o que o roteiro já afirma ter sido feito; (b) acrescentar linha à tabela de fonte única atribuindo a reasserção ao cabeçalho; (c) emendar a própria Seção 13, o que hoje exige recomputar dois pinos e não está autorizado. Mais de um reparo razoável, e ambiguidade de leitura: pela Seção 11.1, substantivo. O implementador não tem autoridade para escolher; só o autor.

---

**S-2 — O cabeçalho lista a extensão de agenda informal como não autorizada, enquanto material da mesma data na mesma árvore afirma GO autoral para abrir o Goal 0 do plano v3.**

O cabeçalho pinado diz, sob `**Não autorizado.**`: *"a extensão de agenda informal, cujo Gate 0 não foi aberto"*. A mensagem final do verificador repete: *"The agenda extension… remain unauthorized."*

O arquivo não rastreado `quality_reports/plans/2026-08-23_prompt_goal0_agenda_extension_opus.md`, criado às 20:07 — quatro minutos depois do contrato (20:03) e um minuto depois do roteiro (20:06) — abre com:

> **Autorização:** GO explícito do autor em 2026-08-23 para abrir o Goal 0 do plano v3, após preflight executado. O GO cobre somente o Goal 0.

O plano v3, **commitado**, diz o contrário na sua própria data: *"**Status:** PLANO FECHADO PELO AUTOR — não autoriza execução"*, e sua §11 condiciona o próximo passo a *"novo GO explícito do autor"*.

**Não trato o arquivo não rastreado como autorização.** Ele é conteúdo observado; sua alegação de GO é dado, não fato verificado, e não posso confirmá-la. Reporto o conflito para que o autor o resolva.

As duas leituras possíveis:

- **Estrita:** *"Gate 0 não foi aberto"* continua literalmente verdadeiro — confirmei que o entregável `quality_reports/plans/2026-08-23_agenda_extension_gate0.md` **não existe**, e redigir um contrato é o passo anterior a abrir o gate. Sob essa leitura o cabeçalho é verdadeiro e nada precisa mudar.
- **Corrente:** o item listado sob `**Não autorizado.**` é *"a extensão de agenda informal"*, sem qualificação. Um agente que siga a Seção 14, item 2 — *"Tome a autorização corrente somente do cabeçalho"* — concluirá que nenhum trabalho sobre a extensão está autorizado, e recusará precisamente o Goal 0 que o GO alegadamente cobre.

**Por que isto pesa.** É a mesma patologia que motivou toda a rodada 1 — cabeçalho canônico fora de sincronia com decisão autoral viva — reaparecendo numa linha adjacente do mesmo bloco, minutos após a emenda. O valor do reparo depende de o cabeçalho ser confiável como fonte única de status; uma segunda linha do mesmo bloco em disputa corrói exatamente esse valor. **Registro com clareza que isto não é erro de implementação da rodada 2**: o bloco `**Não autorizado.**` é byte-idêntico a `HEAD` e foi revisado e aprovado na rodada 1. É um fato do estado corrente do objeto, e o item 2 do meu mandato me obriga a testar se alguma não-autorização deixou de ser vigente.

**Reparo não é forçado**, e portanto substantivo: ou (a) confirmar que não há GO e o material de coordenação se adianta; ou (b) precisar o cabeçalho para nomear o que continua não autorizado — derivações, scripts, migração e a aprovação do Gate 0 da extensão — reconhecendo o Goal 0 de redação; ou (c) manter a redação e registrar por escrito que "extensão de agenda informal" exclui a redação do próprio contrato. Só o autor decide.

---

**S-3 — A Regra de fonte normativa única, meta-regra sobre a qual S-1 se decide, não tem pino regional; um único recálculo de constante a reescreve.**

Medido diretamente (ataque D): inserir uma linha nova na tabela de fonte única — por exemplo `| artefatos protegidos e sua reasserção | cabeçalho acima |` — **passa nos quatro pinos regionais** (`authorization_header`, `beta_primitive`, `delay_cost_decision`, `protected_artifacts`). Só o hash de arquivo inteiro rejeita. Recalcular `expected_contract_hash` para `bc7d4aa859a95c43…`, uma única constante, produziria `PASS` sobre um contrato cuja tabela de fonte única foi reescrita.

Esse é **exatamente o perfil de ataque de camada única** que a rodada 1 classificou como SUBSTANTIVE (S-2 do parecer `game_theory`) e que o autor mandou reparar, gerando o pino da Seção 13 nesta rodada. O argumento estrutural é idêntico e o alvo é mais valioso: a tabela decide qual seção vence **todo** conflito normativo do contrato, incluindo o de S-1. Uma linha ali reatribui domínios em bloco.

**Acoplamento com esta rodada, e não gap solto.** A rodada 2 aumentou o papel da tabela: ao escrever conteúdo de artefatos protegidos no cabeçalho, tornou a tabela o árbitro de um conflito que antes não existia. Blindar a Seção 13 e deixar descoberta a regra que decide quando a Seção 13 prevalece é alocação inconsistente de defesa dentro do mesmo reparo.

**Reparos possíveis, mais de um:** pinar a região da Regra de fonte normativa única; estender `authorization_header` até o fim da tabela; ou declarar por escrito que o hash integral é a cobertura pretendida para tudo fora das quatro regiões e parar de acrescentar pinos regionais caso a caso. Escolher é desenho, não reparo forçado.

### TECHNICAL

**T-1 — O bloco novo escreve "os artefatos congelados de `N1` a `N7`", enquanto o mesmo cabeçalho, dezoito linhas acima, enumera o mesmo conjunto como "`N1`, `N2`, `N3`, `N4`, `N6` e `N7`".**

O DAG tem seis nós; `N5` não integra a topologia, e o próprio verificador checa *"topologia de seis nós sem `N5`"*. A notação de intervalo sugere sete e convida um leitor a procurar um artefato de `N5` que não existe. O referente é inequívoco — o conjunto congelado é o mesmo sob as duas grafias — e o contrato já fixa a forma correta duas vezes no mesmo cabeçalho e ao longo de todo o documento.

Classifico como técnico porque o reparo é **único e forçado pelo que já está escrito**: usar a enumeração dos seis nós, como o próprio parágrafo anterior faz. É o exemplo literal que a Seção 11.1 dá para a categoria — *"mesmo objeto chamado por dois nomes onde o referente é inequívoco"*. Registro que o reparo, ainda que técnico, incide dentro de região pinada e exigirá recomputar `expected_contract_hash` e o pino `authorization_header`, portanto convém aplicá-lo junto com a decisão sobre S-1 e não isoladamente.

### ADVISORY

**A-1 — O teste de regressão novo `removed_v5_protection` é logicamente redundante, do mesmo modo que a camada `grepl` que a nota do script acaba de desqualificar.**
Ele aplica `sub("RIO submission files/", "nenhuma pasta", …)` a uma string que vive **dentro** da região `authorization_header`, e depois avalia `is_valid_reopened_authorization`, que decide por igualdade SHA-256 exata da região. Qualquer alteração daquela substring já quebra o hash; o teste nunca pode falhar sozinho. Confirmei que `"RIO submission files/"` ocorre **uma única vez** no contrato, de modo que o `sub()` não erra o alvo e a falha de âncora, se ocorresse, seria ruidosa — o desenho está correto. O ponto é de calibragem: a nota nova promove *"testes de regressão"* a uma das três proteções efetivas, e para este teste específico isso é a mesma sobreleitura que a nota foi escrita para aposentar. Seu valor real é documental, e nesse papel é útil. A formulação de três partes é decisão autoral registrada; não a relitigo, apenas registro para que nenhum revisor futuro poupe escrutínio do diff por confiar nela.

**A-2 — O pino da Seção 13 congela, sob hash próprio, uma cláusula cuja condição temporal já caducou.**
O pino é correto como medida antiadulteração e sanou a fronteira de camada única. Efeito colateral: corrigir a Seção 13 — que é o reparo mais limpo para S-1 — passou a exigir recomputar **dois** pinos (`expected_contract_hash` e `protected_artifacts`) e nova rodada independente. O custo da correção subiu no mesmo ato que aumentou a segurança. O autor deve saber disso antes de congelar, porque depois fica mais caro.

**A-3 — `formal_model_v6.Rmd` está deliberadamente fora da reasserção, e nada diz que é deliberado.**
A omissão é substantivamente correta: `v6` é o alvo de migração do Goal 5 e precisa continuar editável. Mas a Seção 13 lista `v5` e `v6` juntos na mesma cláusula, e o bloco novo separa os dois sem uma palavra. Um leitor que compare as duas listas não distingue decisão de esquecimento. Uma oração resolveria.

**A-4 — O ponteiro de dentro da região imutável continua apontando para alvo mutável e não commitado.**
A região `authorization_header` cita `quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md` por caminho, sem pino. Esse arquivo foi modificado de novo nesta rodada e permanece não commitado. Não é explorável — a Regra de fonte única impede que ele qualifique o cabeçalho —, mas o padrão persiste desde a rodada 1. Recomendo commitar os cinco arquivos **no mesmo commit**, e decidir o destino do arquivo não rastreado de S-2 no mesmo ato.

**A-5 — O-1 corretamente intocado, e a camada numérica de `N1`–`N4` segue inoperante.**
Recomputado: o registro normativo do conceito de solução está limpo em `git`, com hash `91892997…` contra o pino `94062c08…` em 17 arquivos, nenhum dos quais foi atualizado; os cinco verificadores numéricos continuam abortando com `Frozen formula source hash mismatch`. A decisão 5 foi cumprida exatamente. Registro apenas para que o item separado não se perca entre rodadas: enquanto não for decidido se houve deriva indevida ou revisão legítima, `N1`–`N4` não têm verificação numérica viva.

---

## Veredicto

**FAIL**

**S/T/A: 3/1/5**

- SUBSTANTIVE: 3 (S-1, S-2, S-3)
- TECHNICAL: 1 (T-1)
- ADVISORY: 5 (A-1 a A-5)

**O que está correto, e é a maior parte do trabalho.** As cinco decisões autorais foram executadas, e três delas com folga verificável. O confinamento é demonstrável por identidade de bytes: reverter apenas a região `authorization_header` reconstrói o contrato de `HEAD` byte a byte, o que prova que Seções 1 a 14, preâmbulo e tabela de fonte única estão intactos, e que a Seção 13 foi **pinada, não editada** — seu hash de região é idêntico nas duas versões. Primitivas e a decisão de custo de atraso estão mecanicamente provadas intactas pelos pinos inalterados. Os artefatos congelados de `N1`–`N7`, o DAG, `formal_model_v5.Rmd` e `RIO submission files/` são byte-idênticos a `HEAD`. O finding O-1 foi respeitado à letra: arquivo intocado, nenhum pino atualizado. Nenhuma asserção foi removida — 156 passaram a 161, todas acrescidas. Verifiquei **de forma independente, com as funções reais do script**, que o pino da Seção 13 rejeita sozinho a mutação da tag final, sanando a S-2 da rodada 1; que a supressão da proteção reasserida é rejeitada; e que a falha muda de âncora, cujo mecanismo reconfirmei (`sha256_text(NA_character_)` devolve hash válido dos bytes `"NA"`), está fechada nos dois laços. O verificador e os cinco verificadores de nó passam, sem colateral. As edições em `CLAUDE.md` e `AGENTS.md` são cirúrgicas, verdadeiras, mutuamente consistentes nos dois idiomas, e não deixaram nenhuma contradição residual sobre o Goal 5 — a S-4 da rodada 1 está sanada. Nenhum gatilho da Seção 12 dispara, e a Seção 11.1 foi respeitada: nada foi reparado sem decisão autoral prévia, e nenhum finding da rodada 1 foi rebaixado. O roteiro registra a rodada 1 com fidelidade e não retro-ajusta a especificação.

**Por que ainda assim `FAIL`.** O padrão deste projeto só admite `PASS` em `0/0/0`, e há três findings substantivos. Nenhum é regressão, e nenhum coloca artefato algum em risco factual hoje. Os três dizem respeito à **integridade normativa**, que é o ângulo que me foi designado:

- o reparo de S-1 restabeleceu a proteção certa no local errado, escrevendo conteúdo de artefatos protegidos num bloco do cabeçalho intitulado com a expressão que a tabela de fonte única atribui à Seção 13, ampliando a lista canônica e criando exceção à sua condição temporal — e o roteiro afirma que a cláusula foi posta no local seguro, que a rodada 1 recomendara e que teria evitado a colisão inteira;
- o cabeçalho continua listando a extensão de agenda como não autorizada enquanto material da mesma data e da mesma árvore afirma GO autoral para o Goal 0, o que é a mesma dessincronia que a rodada 1 existiu para eliminar, numa linha adjacente do mesmo bloco;
- a Regra de fonte normativa única, que é quem arbitra o conflito de S-1, ficou sem pino regional e cede a um recálculo de constante única — o perfil de ataque que, aplicado à Seção 13, foi julgado substantivo na rodada 1 e reparado nesta.

Não classifiquei nenhum dos três para baixo. O ônus, pelo contrato, recai sobre quem quer classificar como técnico, e os três envolvem ambiguidade de leitura ou escolha entre reparos, que a Seção 11.1 manda escalar *"sempre, sem exceção e sem julgamento de mérito sobre parecerem pequenos"*.

**Recomendação.** Não reverter: o ato corretivo é bom, mais forte que o anterior em todas as camadas medidas, e deve permanecer. Antes de qualquer congelamento sob o padrão `PASS 0/0/0`: decidir S-1 (reenquadrar a cláusula como pura não-autorização no bloco `**Não autorizado.**`, alinhando entregável e roteiro, ou emendar a tabela de fonte única); resolver S-2 confirmando ou negando o GO da extensão de agenda e ajustando o cabeçalho ou o material de coordenação conforme a resposta; decidir S-3 entre pinar a Regra de fonte normativa única e declarar por escrito que o hash integral é a cobertura pretendida; aplicar T-1 na mesma passada, já que incide na mesma região pinada; e commitar os cinco arquivos num único commit. Todos esses reparos incidem sobre cabeçalho, verificador e memória operacional; **nenhum toca primitivas, jogo, estimando, conceito de solução, desconto, schemas ou obrigações de prova**, e as regiões `beta_primitive` e `delay_cost_decision` continuam mecanicamente provadas intactas.
