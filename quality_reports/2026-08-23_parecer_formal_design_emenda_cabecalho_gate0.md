# Parecer — Revisor independente `formal_design` (read-only)
## Emenda de status do cabeçalho, contrato Gate 0 essential-input

**Data:** 2026-08-23
**Papel:** `formal_design`, revisor independente, regime read-only
**Declaração de conformidade:** não chamei `Edit`, `Write` nem `NotebookEdit`. Nenhum arquivo do repositório foi criado, alterado ou apagado. Todas as verificações foram feitas por leitura, `git`, `shasum`, `grep`, `sed` e execução de verificadores já existentes, com saída dirigida a `stdout` e nunca a arquivo.

---

## 1. Objeto e hashes confirmados

Confirmei os dois hashes eu mesmo com `shasum -a 256`:

| Arquivo | SHA-256 observado | Esperado | Bate |
|---|---|---|---|
| `quality_reports/plans/2026-08-12_essential_input_gate0.md` | `f683b6a60cdd8a7085eafe0b803fa060dc931a592f2b70a144f881b1e437c462` | idem | sim |
| `scripts/verify_essential_input_gate0.R` | `e6ecc69d848ba63db92c5c86dbad8c218848c0250ae8d2adc732bbe9527821c7` | idem | sim |

**Discrepância de baseline, resolvida e sem efeito.** O briefing declara `HEAD` em `af5bfd5`; o `HEAD` real é `a315f59`. Verifiquei que `af5bfd5` é ancestral de `HEAD` e que `git diff af5bfd5 HEAD` toca **um único arquivo**, `quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md` (321 inserções, o próprio documento de diagnóstico). O contrato e o verificador são byte a byte idênticos entre `af5bfd5` e `HEAD`. Logo a comparação contra `HEAD` é exatamente a comparação contra `af5bfd5` para o objeto revisado, e a emenda na árvore de trabalho é integralmente o objeto desta revisão. Não parei.

**Árvore de trabalho.** Três arquivos modificados e não commitados: o contrato, o verificador e o documento de diagnóstico. Nenhum outro.

---

## 2. Metodologia

Comandos efetivamente executados (os relevantes):

```
shasum -a 256 quality_reports/plans/2026-08-12_essential_input_gate0.md scripts/verify_essential_input_gate0.R
git rev-parse HEAD ; git status --porcelain ; git log --oneline -8
git merge-base --is-ancestor af5bfd5 HEAD
git diff --stat af5bfd5 HEAD
git diff quality_reports/plans/2026-08-12_essential_input_gate0.md
git diff scripts/verify_essential_input_gate0.R
git diff quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md
git show HEAD:quality_reports/plans/2026-08-12_essential_input_gate0.md
grep -n "extract_normative_contract_regions" -A 80 scripts/verify_essential_input_gate0.R
# teste mecânico de confinamento (sem criação de arquivos, via process substitution)
sed -n '3,42p'  <contrato>            | perl -0pe 's/\n\z//' | shasum -a 256
git show HEAD:<contrato> | sed -n '3,21p' | perl -0pe 's/\n\z//' | shasum -a 256
cat <(sed -n '1,2p' <contrato>) <(git show HEAD:<contrato> | sed -n '3,21p') \
    <(sed -n '43,$p' <contrato>) | shasum -a 256
git show HEAD:<contrato> | shasum -a 256
# veracidade
python3 -c "<inspeção do model_redesign/essential_input_game_dag.json>"
shasum -a 256 formal_model_v6.Rmd formal_model_v6.pdf
git cat-file -p b5fdefb:formal_model_v6.Rmd | shasum -a 256
git cat-file -p b5fdefb:formal_model_v6.pdf | shasum -a 256
git merge-base --is-ancestor b5fdefb HEAD
git diff --stat e0ff1ac HEAD -- formal_model_v5.Rmd "RIO submission files/"
# coerência
sed -n '/^## 12\. Invalida/,/^## 13\./p' <contrato>
grep -n "Goal" <contrato>
grep -n "não alcança\|não autoriza\|migração para manuscrito" <contrato>
grep -rn "2f1f79efe4b9...\|dd1d2bb6b8ce..." . --exclude-dir=.git
# execução
Rscript --vanilla scripts/verify_essential_input_gate0.R
Rscript --vanilla scripts/verify_essential_input_{n1,n2,n6,n7,solution_concept_rederivation}.R
git diff --check
shasum -a 256 -c  <três manifestos .sha256 de N6/N7>
```

Não confiei em nenhuma afirmação do implementador nem do documento de diagnóstico: cada item abaixo foi recomputado.

---

## 3. Achados por item

### Item 1 — Veracidade

**Verdadeiro em todas as afirmações. Recomputado, não aceito.**

**(a) `N1`–`N4`, `N6`, `N7` `pass/frozen` com dois `PASS 0/0/0` cada, no mesmo hash.**
Inspecionei `model_redesign/essential_input_game_dag.json` contra o `freeze_gate_schema` do próprio manifesto (`status_value: "pass"`, `frozen_value: true`, `review_count: 2`, `reviewer_roles: [formal_design, game_theory]`, `reviewer_ids_must_be_distinct: true`, `verdict_value: "PASS"`, `finding_count_value: 0`, `review_hash_rule: "Each review artifact_hash exactly matches the node artifact_hash"`).

Os seis nós — `N1`, `N2`, `N3`, `N4`, `N6`, `N7`, e apenas esses; `N5` não integra o DAG — satisfazem simultaneamente: `status == "pass"`; `frozen == true`; exatamente dois reviews; papéis `{formal_design, game_theory}`; `reviewer_id` distintos; `verdict == "PASS"`; `finding_counts.critical == major == minor == 0`; e `review.artifact_hash == node.artifact_hash`. A cláusula "no mesmo hash" do cabeçalho é, portanto, literalmente verificada, e não apenas plausível.

**(b) "nenhum nó de derivação está topologicamente pronto".**
Verdadeiro por vacuidade forte: não existe nó `pending` ou `unfrozen` no manifesto. O conjunto de candidatos a prontidão é vazio.

**(c) Goals 1 a 4 encerrados.**
- **Goal 4:** encerrado por registro autoral explícito e literal em `quality_reports/2026-08-21_fechamento_autoral_goal4_n7.md` — *"Aprovo N7 congelado, encerro o Goal 4 e autorizo sua consolidação administrativa, sem abrir o Goal 5."*
- **Goal 3:** encerrado por implicação forçada. A Seção 11, item 6, condiciona `N7` a *"gate autoral do Goal 3"*; `quality_reports/2026-08-21_consolidacao_pos_n6_e_abertura_n7.md` §5 registra *"O autor autorizou explicitamente em 2026-08-21 o Goal 4, limitado a N7"*. Autorizar o Goal 4 pressupõe o gate do Goal 3.
- **Goal 2:** encerrado pela mesma estrutura. A Seção 11, item 5, condiciona `N6` a *"gate autoral do Goal 2"*; `quality_reports/2026-08-21_autorizacao_goal3_n6.md` é registro autoral explícito de abertura do Goal 3.
- **Goal 1:** Seção 11, item 4, condiciona `N4` ao gate autoral do Goal 1; `N4` foi derivado e congelado.

A cadeia fecha. Registro na Seção `Findings` que, para os Goals 2 e 3, o encerramento é atestado **indiretamente**, pela autorização explícita do goal sucessor, e não por registro autônomo análogo ao do Goal 4.

**(d) Goal 5 autorizado, migrado, revisado e ainda aberto.**
- Autorizado em 2026-08-21: `quality_reports/2026-08-21_autorizacao_goal5.md`, status `APPROVED`, com texto autoral literal.
- Matriz de migração aprovada em 2026-08-22: `quality_reports/2026-08-22_aprovacao_matriz_goal5.md`, status `APPROVED`.
- Revisado: `quality_reports/2026-08-22_goal5_puzzle_round2_formal_review.md` e `..._exposition_visual_review.md`, ambos com **"Contagem S/T/A: 0/0/0"**, ambos citando o commit `b5fdefb1f80090b8da893bf19e754915d557502a` e o Rmd `32b49f7503…`.
- **Ainda aberto:** `quality_reports/2026-08-22_goal5_candidate_ready_for_author_approval.md` declara textualmente *"O Goal 5 ainda não é declarado encerrado por este registro: falta o aval explícito do autor. A tag final pelo workflow `paper-version` só pode ser criada depois desse aval."* Isso é corroborado independentemente pelo texto autoral da autorização: *"A tag final da versão migrada só após os dois PASS e meu aval, pelo workflow paper-version."*

O cabeçalho reproduz essa condição com fidelidade, inclusive nomeando o workflow.

**Veredicto do item 1: PASS.**

---

### Item 2 — Ausência de overclaim

**Nenhum overclaim. O cabeçalho é, neste ponto, mais conservador do que precisaria ser, e corretamente assim.**

Li o cabeçalho novo integralmente (linhas 3–42). Não há sentença que declare ou insinue o Goal 5 encerrado, a tag criável, ou os pareceres estendidos aos bytes correntes. Ao contrário, os três aparecem como **negativas afirmativas** no bloco `**Não autorizado.**`:

> "a criação da tag final do Goal 5 sem aval autoral explícito; qualquer declaração de encerramento do Goal 5; e qualquer extensão daqueles pareceres aos bytes correntes do manuscrito."

**Verificação da cobertura dos pareceres — este é o ponto mais importante do item, e confirma que a ressalva não é decorativa mas necessária:**

| Objeto | Hash revisado em `b5fdefb` | Hash corrente na árvore | Coincide |
|---|---|---|---|
| `formal_model_v6.Rmd` | `32b49f7503caac34cdf225f73d7e76ab60d1340937b095e3e611f009030f8744` | `45c6bcbc19c55f97546a7ced06c2b6444a50a7a7c97b4ccb0214e7b14c7456e3` | **não** |
| `formal_model_v6.pdf` | `85d24122008af9ad484a6df53679c3f455f75fb94fffc70aa9ccbd8ffb62fe17` | `cc0294ff7501d464bcc9712f8777262bcda829d50658997feb80e6e2d85595f3` | **não** |

Confirmei por `git cat-file -p b5fdefb:<arquivo> | shasum -a 256` que os hashes citados pelo cabeçalho são de fato os bytes de `b5fdefb`, e que `b5fdefb` é ancestral de `HEAD`. Os bytes correntes divergem em ambos os arquivos. Portanto a ressalva do cabeçalho é **factualmente obrigatória**: sem ela, a leitura literal da fonte canônica atribuiria dois `PASS 0/0/0` a bytes que nenhum revisor viu.

**Veredicto do item 2: PASS.**

---

### Item 3 — Preservação das não-autorizações

Comparação item a item entre a lista antiga e a nova.

| Não-autorização antiga | Destino | Correto |
|---|---|---|
| `N4` | removida | sim — `N4` `pass/frozen`, Goal 2 encerrado |
| `N6` | removida | sim — `N6` `pass/frozen`, Goal 3 encerrado |
| `N7` | removida | sim — `N7` `pass/frozen`, Goal 4 encerrado com aval literal |
| Goal 2 | removida | sim — encerrado |
| fronteira `beta=1` | **preservada, literal** | sim |
| "qualquer migração para manuscrito" | removida | sim — Goal 5 autorizado em 2026-08-21 |

Nenhuma não-autorização ainda vigente foi perdida. As cinco remoções são cada uma justificada por decisão autoral registrada e verificada por mim no item 1.

**Adições, que endurecem a fronteira em vez de afrouxá-la:** extensão de agenda informal; tag final sem aval; declaração de encerramento do Goal 5; extensão dos pareceres aos bytes correntes.

Verifiquei que **"extensão de agenda informal" é termo de arte registrado**, não formulação improvisada: é o título literal de `quality_reports/plans/2026-08-23_agenda_extension_gated_plan_v3.md` — *"Plano v3 final — extensão de agenda informal com contrato, DAG e gates"* — e o plano usa "poder de agenda informal" como o objeto substantivo. A afirmação "cujo Gate 0 não foi aberto" é consistente com o registro (o plano aguarda GO). Isso importa porque o verificador pina a string `"agenda informal"`; se fosse paráfrase, seria pino frágil. Não é.

**Uma não-autorização colateral foi perdida — ver `Findings`, SUBSTANTIVE S-1.** A Seção 13 protege *"`formal_model_v5.Rmd` e `formal_model_v6.Rmd`, até o gate do Goal 5"*. Esse gate passou. Detalho abaixo.

**Veredicto do item 3: PASS quanto às não-autorizações enumeradas; ver S-1 quanto à proteção colateral da Seção 13.**

---

### Item 4 — Confinamento

**Confinamento provado mecanicamente, não por inspeção visual.**

Apliquei a definição do próprio verificador (`extract_normative_contract_regions`, linhas 79–134): início na linha exata `**Data:** 2026-08-12`, fim na linha anterior à primeira que começa com `### Regra de fonte normativa`.

| Versão | Início | Fim (exclusivo) | Região | SHA-256 da região |
|---|---|---|---|---|
| `HEAD` | 3 | 22 | 3–21 | `dd1d2bb6b8ce16f4604057e87c1edfcd4e3d4d413268a24d3d17616b554f3467` |
| árvore | 3 | 43 | 3–42 | `5a94de52ccfaaf81757e80c67328f2b3d7caecfe6f1f1cfa05ea56c2799e62a6` |

Ambos batem exatamente com os valores pinados no verificador (antigo e novo, respectivamente).

**Teste construtivo de confinamento.** Reconstruí um arquivo sintético concatenando `árvore[1–2]` + `HEAD[3–21]` + `árvore[43–fim]`, isto é, o arquivo corrente com a região `authorization_header` revertida para a de `HEAD`:

```
reconstruído: 2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6
arquivo HEAD: 2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6
```

Identidade byte a byte. E `2f1f79ef…` é precisamente o `expected_contract_hash` antigo que a emenda substitui, o que fecha o argumento por dois caminhos independentes.

Consequência lógica, e não mera observação: **todo o restante do contrato — Seções 1 a 14, o preâmbulo, a Regra de fonte normativa única e sua tabela — é byte a byte idêntico a `HEAD`.** O diff está 100% dentro da região `authorization_header`.

**Veredicto do item 4: PASS.**

---

### Item 5 — Alcance da emenda

**A emenda altera apenas status e autorização. Isso não é aceito da declaração do implementador; decorre do item 4.**

Como o confinamento é uma identidade de bytes, é **impossível** que primitivas, jogo, estimando, conceito de solução, desconto, schemas, obrigações de prova ou o protocolo da Seção 11 tenham sido tocados: esses conteúdos residem, pela tabela de fonte única, nas Seções 1, 2, 4, 5, 6, 7/7.2, 9 e 11, todas fora da região alterada e todas byte-idênticas.

**Verificador.** O diff altera exatamente **duas** constantes pinadas:

```
- expected_contract_hash <- "2f1f79ef…"        + "f683b6a6…"
- authorization_header   =  "dd1d2bb6…"        +  "5a94de52…"
```

Diferenciei mecanicamente todas as constantes de 64 hex do verificador entre `HEAD` e a árvore: **apenas essas duas mudaram.** Em particular permanecem intactas `beta_primitive = "bb7ee339…"`, `delay_cost_decision = "3c448385…"`, `expected_manifest_hash = "36155405…"` e `expected_manifest_object_hash = "4981280d…"`. `expected_beta_primitive` (`"Desconto       beta in (0,1)"`) inalterada. O restante do diff é reapontamento de testes de mutação e da mensagem final de `PASS` — guarda, não contrato.

**Execução.** `Rscript --vanilla scripts/verify_essential_input_gate0.R` termina com exit 0, `MUTATION_REJECTED` para as doze mutações Round 3 e `PASS`. Sem colateral: `verify_essential_input_n1.R`, `n2.R`, `n6.R`, `n7.R` e `solution_concept_rederivation.R` todos PASS. `git diff --check` limpo.

**Nenhum pino órfão.** Varri o repositório inteiro pelo hash antigo `2f1f79ef…` e pelo hash de região antigo `dd1d2bb6…`. As únicas ocorrências restantes são **proveniência histórica legítima** — pareceres de 2026-08-18 que registram o contrato que avaliaram, e três manifestos `.sha256` de N6/N7 — mais a citação do próprio documento de diagnóstico. Nenhum script executável pina o hash antigo. Ver A-3 e A-4 quanto aos manifestos.

**Veredicto do item 5: PASS.**

---

### Item 6 — Seção 12

**A leitura do documento de diagnóstico procede. Argumento a partir do texto da §12, não da afirmação dele.**

A §12 enumera quatro e apenas quatro gatilhos de reabertura:

1. **Mudança no contrato do jogo** — estimando ou escopo da comparação; primitivas ou factibilidade; ações, transições, informação, implementação ou payoffs; conceito de solução; desconto; topologia ou schema; obrigações de prova.
2. **Mudança em interface congelada.**
3. **Mudança no protocolo de revisão** — "uma alteração da Seção 11".
4. **Reparo de finding** — cujo alcance segue os itens anteriores.

Aplicação:

- **Item 1: não dispara.** O confinamento provado no item 4 estabelece que nenhum dos conteúdos listados foi tocado — todos residem fora da região alterada, byte-idênticos. Note-se que a lista do item 1 é **exaustiva e material**; "status da fase" e "autorização autoral" não figuram nela, nem por nome nem por gênero. A §12 simplesmente não trata alteração de status como evento de invalidação, o que é coerente: o status é registro do que já aconteceu, não regra sobre o jogo.
- **Item 2: não dispara.** Nenhuma interface foi tocada. `expected_manifest_hash` inalterado; verificadores de nó todos PASS.
- **Item 3: não dispara.** A Seção 11 é byte-idêntica. Refino aqui a formulação do diagnóstico, que está correta mas poderia ser mais precisa: as alterações no verificador **não são** alteração da Seção 11 porque a Seção 11 é texto normativo e o verificador é instrumento de verificação, governado pela **Seção 13** ("fronteira de versão, verificação da infraestrutura e artefatos protegidos"), não pela Seção 11. A §12 item 3 fala em "alteração da Seção 11", e a Seção 11 não mudou.
- **Item 4: não se aplica.** A emenda não é reparo de finding sobre derivação.

Adicionalmente, o cabeçalho preserva **literalmente** a cláusula que faz da §12 uma regra viva: *"A mudança do domínio de `beta` é mudança de primitiva: reabre o Gate 0 e devolve todos os nós a `pending`, conforme a Seção 12."* Ela sobrevive intacta à reescrita, o que é a evidência mais direta de que a emenda não afrouxou o mecanismo de invalidação.

**Veredicto do item 6: PASS. A afirmação do documento de diagnóstico procede, com o refino acima.**

---

### Item 7 — Coerência interna

**(a) Consistência com a Regra de fonte normativa única.** A tabela permanece intacta e continua atribuindo *"status e autorização da fase → cabeçalho acima"*. A emenda escreve exclusivamente dentro dessa competência. Não cria segunda autoridade nem qualifica regra de outra seção.

**(b) Nenhuma contradição residual.** Varri o contrato inteiro por `"não alcança"`, `"não autoriza"`, `"não está autorizad"`, `"permanece não"` e `"migração para manuscrito"`: **zero ocorrências.** Não sobrou nenhuma afirmação antiga de que `N4`, `N6`, `N7`, o Goal 2 ou a migração estejam bloqueados. As menções a Goals nas Seções 7, 8 e 11 são **descrições de escopo e ordem** ("Goal 2 — o nó decisivo. Resolve `N4` conforme as Seções 7, 9 e 11"), não asserções de status, e portanto não colidem com o cabeçalho.

**(c) A Seção 11, item 7, é compatível.** Ela diz: *"a migração para `formal_model_v6.Rmd` só pode começar depois dos dois PASS do ciclo de `N7` e de autorização explícita do autor."* Ambas as condições ocorreram e estão verificadas. O cabeçalho é consistente com ela.

**(d) O ponteiro para o diagnóstico não recria o problema da segunda autoridade.** O cabeçalho cita `quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md` como *"Diagnóstico e roteiro"* — explicação e proveniência. Ele **não** delega autorização ao documento: as afirmações normativas de status e de não-autorização estão escritas por extenso no próprio cabeçalho. Isso respeita a alternativa que o próprio diagnóstico havia descartado (*"apenas acrescentar ao cabeçalho um ponteiro para a cadeia de autorizações avulsas"*), porque o ponteiro aqui é ilustrativo e não constitutivo. Correto.

**(e) A tensão que resta é com a Seção 13 — ver S-1.**

**Veredicto do item 7: PASS quanto a (a)–(d); ver S-1.**

---

## Findings

### SUBSTANTIVE

**S-1 — A emenda torna operativa a caducidade da proteção da Seção 13 sobre `formal_model_v5.Rmd` e não a reassere.**

A Seção 13 do contrato lista como protegidos:

> `formal_model_v5.Rmd` e `formal_model_v6.Rmd`, **até o gate do Goal 5**;

O "gate do Goal 5" é definido na Seção 11, item 7, como os dois PASS do ciclo de `N7` mais autorização autoral explícita. Ambos ocorreram em 2026-08-21. Pela letra da Seção 13, a proteção contratual caducou para **os dois** arquivos — inclusive `v5`.

Isso contraria diretamente a instrução autoral do Goal 5, que é explícita: *"formal_model_v5.Rmd, a pasta 'RIO submission files/' e todos os artefatos congelados permanecem intocados."*

Estado factual, verificado: `git diff --stat e0ff1ac HEAD -- formal_model_v5.Rmd "RIO submission files/"` retorna vazio e o `git status` desses caminhos é limpo. **Nenhum dano ocorreu.** `v5` e a pasta RIO estão byte-idênticos desde a autorização.

Por que isso é finding da emenda, e não apenas da Seção 13. Reconheço explicitamente que a **causa raiz precede** a emenda: a caducidade ocorreu em 2026-08-21, com a autorização autoral, independentemente do texto do cabeçalho. O cabeçalho antigo apenas **mascarava** a caducidade ao afirmar falsamente que a migração não estava autorizada. Ainda assim o finding se dirige à emenda por três razões cumulativas:

1. O cabeçalho **é** a fonte canônica de autorização. Antes da emenda, um agente consultando apenas a fonte canônica concluía que o gate do Goal 5 não passara e que `v5` seguia protegido. Depois da emenda, o mesmo agente conclui que `v5` está desprotegido. O conteúdo normativo operativo, lido da fonte canônica, mudou quanto a `v5`.
2. A Seção 14 instrui o agente seguinte, textualmente: *"Tome a autorização corrente somente do cabeçalho"* e *"preserve os artefatos da Seção 13"*. As duas instruções, combinadas com a emenda, deixam `v5` sem cobertura em ambas as fontes.
3. A restrição autoral sobre `v5` passa a viver **apenas fora** do contrato, num registro avulso — exatamente a configuração que a Regra de fonte normativa única veda (*"não constituem uma segunda autoridade"*) e que o próprio documento de diagnóstico identificou como padrão a evitar. Há salvaguarda residual na cláusula preservada *"Decisão autoral posterior prevalece sobre registro histórico incompatível"*, mas ela e a regra de fonte única puxam em direções opostas neste caso, o que é ambiguidade normativa — e ambiguidade escala.

O instrutivo A1 do diagnóstico mandava registrar "o que continua **não** autorizado", exemplificando com `beta=1` e a extensão de agenda; a lista não era fechada. A emenda de fato acrescentou três não-autorizações novas por conta própria (tag, encerramento, extensão de pareceres), demonstrando que ampliar a lista estava dentro do escopo assumido. A omissão de `v5` é, portanto, assimétrica.

**Reparo sugerido, compatível com o confinamento** (uma cláusula dentro da região `authorization_header`, sem tocar a Seção 13): acrescentar ao bloco `**Não autorizado.**` algo como — *"qualquer edição de `formal_model_v5.Rmd`, da pasta `RIO submission files/` e dos artefatos congelados de `N1`–`N7`, que permanecem intocados por decisão autoral do Goal 5, não obstante a caducidade da cláusula de proteção da Seção 13"*. Isso reassere a proteção, registra a caducidade para o agente seguinte e mantém o diff dentro da região pinada. Exigirá recomputar os dois hashes (A2) e reexecutar A4.

Alternativa, se o autor preferir: declarar explicitamente que a caducidade é intencional e que `v5` fica sob a proteção da decisão autoral posterior. O que não deve permanecer é o silêncio, porque o silêncio é indistinguível de descuido para quem ler depois.

---

### TECHNICAL

Nenhum.

Considerei promover a A-1 (guardas `grepl` logicamente redundantes) a TECHNICAL e decidi contra: não há **exatamente um** reparo forçado pelo que já está escrito — há pelo menos três respostas defensáveis (reordenar, manter como documentação de intenção, remover) — e o critério do protocolo exige unicidade do reparo. Pela regra de que o ônus recai sobre quem classifica **para baixo**, também considerei promovê-la a SUBSTANTIVE e decidi contra, porque não é regressão: o guarda anterior era exclusivamente hash e a emenda só acrescenta expressividade. Fica ADVISORY.

---

### ADVISORY

**A-1 — Os cinco guardas `grepl` novos são logicamente redundantes e não adicionam poder discriminante.**

Em `is_valid_reopened_authorization` (linhas 136–148), os cinco `grepl` novos — `"permanece aberto"`, `"falta o aval"`, `"b5fdefb"`, `"sem aval autoral"`, `"agenda informal"` — são conjuntos avaliados **depois** de uma igualdade SHA-256 exata sobre a mesmíssima string:

```r
identical(sha256_text(regions$authorization_header),
          unname(expected_contract_region_hashes[["authorization_header"]])) &&
  grepl("permanece aberto", regions$authorization_header, fixed = TRUE) && ...
```

Se o hash bate, o texto é exatamente o texto pinado, que contém as cinco substrings — os `grepl` são necessariamente `TRUE`. Se o hash não bate, o `&&` faz curto-circuito antes deles. Os `grepl` nunca podem decidir nada.

Isso não torna o verificador incorreto: ele rejeita tudo que deve rejeitar, via pino de bytes. O ponto é de **calibragem de expectativa**. O A3 do diagnóstico pede que *"o guarda deve passar a falhar contra uma ampliação que autorize a extensão de agenda ou `beta=1`"*, formulação que sugere detecção semântica. A detecção é byte-exata, não semântica. O valor real dos `grepl` é documental — tornam a intenção legível a quem audite o script — e nesse papel são úteis. Convém apenas que ninguém os leia como camada independente de defesa.

**A-2 — Duas das doze mutações Round 3 inserem fora da região pinada e são capturadas apenas pelo hash de arquivo inteiro.**

`agenda_authorization_in_section_11` (insere antes de `## 12. Invalida`) e `final_tag_without_approval_in_section_13` (insere antes de `## 14. Prompt de abertura`) caem fora de `authorization_header`, `beta_primitive` e `delay_cost_decision`. Como `is_valid_contract_semantics` checa `identical(sha256_text(text), expected_contract_hash)` antes de qualquer diagnóstico regional, elas falham — corretamente — mas só por essa via. Não há guarda regional cobrindo as Seções 11 a 13. Arquitetura preexistente (a mutação antiga `n4_authorization_in_section_11` tinha a mesma propriedade), sem regressão. Registro para que a mensagem final de `PASS`, que enumera "regional diagnostics", não seja lida como se as regiões cobrissem essas seções.

**A-3 — Encerramento dos Goals 2 e 3 é atestado indiretamente.**

Não há registro autônomo de fechamento para os Goals 2 e 3 análogo a `2026-08-21_fechamento_autoral_goal4_n7.md`. O encerramento é inferido, de forma válida, das autorizações explícitas dos goals sucessores combinadas com os itens 5 e 6 da Seção 11. A inferência é sólida e eu a aceito. Registro porque o cabeçalho afirma o encerramento de forma direta ("decisões autorais posteriores abriram e encerraram os Goals 2, 3 e 4") e um auditor futuro procurando os registros correspondentes não os encontrará com esse nome.

**A-4 — Três manifestos `.sha256` congelados passam a falhar `shasum -c` em 4 de 4 linhas; já falhavam em 3 de 4 antes da emenda.**

`quality_reports/2026-08-21_n6_candidate_review_manifest.sha256`, `..._n6_final_integration_manifest.sha256` e `..._n7_candidate_review_manifest.sha256` pinam o contrato em `2f1f79ef…`. Depois da emenda essa linha falha.

**Verifiquei a linha de base antes de imputar isso à emenda, e a imputação não se sustenta.** Já em `HEAD`, esses manifestos falhavam em três das quatro linhas:

| Linha pinada | Pino | Valor em `HEAD` | Já falhava antes |
|---|---|---|---|
| `2026-08-21_decisao_conceito_solucao_essential_input.md` | `94062c08…` | `91892997…` | **sim** |
| `model_redesign/essential_input_game_dag.json` | `747ac44e…` | `36155405…` | **sim** |
| `scripts/verify_essential_input_gate0.R` | `74ec1a7b…` | `0bd17015…` | **sim** |
| `quality_reports/plans/2026-08-12_essential_input_gate0.md` | `2f1f79ef…` | `2f1f79ef…` | não — quebra agora |

A prática estabelecida no repositório, portanto, já trata esses manifestos como **fotografias históricas do que os revisores viram**, não como checagens vivas. A emenda completa um padrão existente em vez de instaurá-lo, e a leitura correta ("snapshot de commit, não estado corrente") é a única compatível com o histórico. Não é defeito da emenda. Registro apenas porque nenhum documento afirma essa semântica por escrito, e uma varredura de integridade futura verá quatro `FAILED` em artefatos rotulados como congelados — exatamente o padrão que se pareceria com adulteração.

**A-5 — O documento de diagnóstico, que é a especificação desta emenda, foi revisado na mesma janela e permanece não commitado.**

`quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md` tem alterações não commitadas na árvore. Auditei esse diff especificamente para descartar retro-ajuste da especificação ao entregável. **Não é retro-ajuste:** as mudanças estão documentadas num bloco "Revisão 3 — 2026-08-23" ao final, que registra veredicto de segundo parecer (`diagnóstico PASS; plano MINOR REVISION`) e enumera os três ajustes aceitos — endurecer A3 para proteger a fronteira viva do Goal 5, desambiguar a §1, e corrigir a formulação sobre "regra normativa". O registro é transparente e auditável, e as três correções melhoram genuinamente a especificação (a primeira, em particular, é a razão de o verificador hoje proteger o Goal 5). Boa prática. Recomendo apenas que os três arquivos sejam commitados **no mesmo commit**, para que o ponteiro do cabeçalho aponte para bytes estáveis, já que a citação é por caminho e sem pino de hash.

---

## Observações fora do objeto desta revisão

Não contam para a contagem. Levanto porque são materiais e o autor deve saber.

**O-1 — Falha de integridade preexistente e commitada em `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`.**

Esse documento é o registro normativo do pacote de conceito de solução de 2026-08-21 (o CLAUDE.md o designa assim). Seus bytes divergiram do valor pinado:

- pinado em três manifestos e em `scripts/essential_input_formulas.R`: `94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69`
- observado: `9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f`

A divergência está **commitada** (o `git status` do arquivo é limpo; última alteração no merge `fa803b2`, "Merge reviewed Goal 5 manuscript into primary checkout"). Consequência verificada: cinco verificadores numéricos abortam com `Erro: Frozen formula source hash mismatch`:

```
scripts/verify_essential_input_numeric_boundaries.R   FAIL
scripts/verify_essential_input_n1_numeric.R           FAIL
scripts/verify_essential_input_n2_numeric.R           FAIL
scripts/verify_essential_input_n3_numeric.R           FAIL
scripts/verify_essential_input_n4_numeric.R           FAIL
```

**Isto é rigorosamente independente da emenda.** Confirmei que nem `verify_essential_input_n1_numeric.R` nem `essential_input_formulas.R` referenciam o contrato ou `verify_essential_input_gate0.R` (`grep -c "essential_input_gate0"` retorna 0 em ambos), e que nenhum dos cinco scripts está entre os três arquivos modificados. A falha existe em `HEAD` e existiria com a emenda revertida.

Ainda assim é séria: ou o documento normativo sofreu deriva indevida e deve ser restaurado, ou sofreu revisão legítima e os pinos precisam ser recomputados com nova revisão independente. Enquanto não se decidir qual, a camada de verificação numérica de `N1`–`N4` está inoperante. Recomendo tratar isso como item próprio, com autorização e revisores próprios — não anexá-lo a esta emenda.

---

## Veredicto

**FAIL**

**S/T/A: 1/0/5**

- SUBSTANTIVE: 1 (S-1)
- TECHNICAL: 0
- ADVISORY: 5 (A-1 a A-5)

**Justificativa e proporcionalidade.** A emenda é, no essencial, correta e bem executada. Os itens 1, 2, 4, 5, 6 e 7 passam, e vários passam com folga: o confinamento é demonstrável por identidade de bytes; toda afirmação de status foi recomputada contra o manifesto e os registros autorais e é verdadeira; a divergência entre os bytes correntes do manuscrito e os revisados em `b5fdefb` é real, o que torna a ressalva do cabeçalho necessária e não decorativa; as não-autorizações removidas são todas justificadas, e as acrescentadas endurecem a fronteira viva em vez de afrouxá-la. O verificador foi reapontado corretamente e passa, sem colateral sobre os demais verificadores e sem deixar pino órfão em nenhum script executável.

O `FAIL` decorre de um único item, S-1, e o protocolo deste projeto só admite `PASS` em `0/0/0`. Não classifiquei S-1 para baixo porque o ônus, pelo contrato, recai sobre quem quer classificar como técnico, e porque o defeito é do gênero que esta arquitetura inteira existe para prevenir: perda silenciosa de proteção sobre um artefato que o autor mandou congelar, verificável apenas por quem cruze o cabeçalho com a Seção 13 e com um registro avulso. Registro com igual ênfase que **nenhum dano ocorreu** — `formal_model_v5.Rmd` e `RIO submission files/` estão byte-idênticos —, que a causa raiz precede a emenda, e que o reparo é uma cláusula dentro da região já pinada, seguida de recomputar os dois hashes (A2) e reexecutar o verificador (A4).

Recomendo, portanto: aplicar o reparo de S-1 ou registrar decisão autoral explícita de que a caducidade é intencional; commitar os três arquivos juntos; e abrir item separado para O-1.
