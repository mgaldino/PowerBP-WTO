# Parecer — Revisão adversarial independente, rodada 3: guarda `verify_essential_input_gate0.R`

**Revisor:** agente independente, papel `game_theory` / auditoria adversarial
**Regime:** read-only estrito. Não chamei `Edit`, `Write` nem `NotebookEdit`. Nenhum arquivo do repositório foi criado, alterado ou apagado. Todo código auxiliar foi avaliado por `stdin` (`R --vanilla -q --no-echo <<'RS'`, `python3 -c`), sem gravação. Registro novamente a tensão com a regra global "salvar scripts antes de rodar": o mandato read-only desta tarefa é mais estrito e prevalece. Este parecer não foi salvo em disco por mim; o enunciado determina que o texto integral seja salvo pelo chamador.
**Data:** 2026-08-25
**Rodada:** 3

---

## Objeto e hashes confirmados

`HEAD` verificado por mim: `ee0c8d572ab6a002111ed7668f876c856ac70178`, branch `codex/essential-input`, worktree **limpo** (`git status --porcelain` vazio). Commit do objeto: `ee0c8d5 Align Gate 0 contract header with recorded authorial decisions`.

| Arquivo | SHA-256 esperado | SHA-256 medido | Confere |
|---|---|---|---|
| `scripts/verify_essential_input_gate0.R` | `a9f931fb…020f12` | `a9f931fb8bcd71f5ae72ac42f9756f3c5c980ce4bb15c63e8b85c881b6020f12` | SIM |
| `quality_reports/plans/2026-08-12_essential_input_gate0.md` | `20c331df…de1d0d` | `20c331dff3d67a759bf3408f9037a841594e9b3e4721d6a83c31f452dede1d0d` | SIM |

Não houve parada. Reconstruí também a proveniência das três rodadas, para poder medir deltas em vez de aceitar descrições:

| Commit | contrato | verificador | rodada |
|---|---|---|---|
| `6d88c0d` | `f683b6a6…` | `e6ecc69d…` | objeto da rodada 1 |
| `a490a7a` | `ef38be13…` | `183f4677…` | objeto da rodada 2 |
| `ee0c8d5` | `20c331df…` | `a9f931fb…` | **objeto desta rodada** |

---

## Metodologia

1. `git rev-parse HEAD`, `git status --porcelain`, `shasum -a 256` nos dois objetos.
2. `git cat-file -p` para materializar os blobs das rodadas 1 e 2 e medir o diff exato (`git diff a490a7a ee0c8d5`) dos dois arquivos.
3. **Harness sobre as funções reais do script**, não paráfrases: `parse()` do verificador e avaliação seletiva de 26 atribuições (funções + constantes) num `new.env()`, com `environment(sha256_file) <- e` para religar `assert_true`. Locale `en_US.UTF-8` para os literais acentuados.
4. Recomputação independente dos quatro hashes de região a partir do contrato reconstruído (`paste0(paste(readLines(...), collapse="\n"), "\n")`), com verificação prévia de que a reconstrução é byte-idêntica ao arquivo.
5. Extração das fronteiras de região por 1-based line index, para localizar cada âncora de `sub()` dentro ou fora de região pinada.
6. Diff mecânico dos conjuntos de mensagens de `assert_true` entre `a490a7a` e `ee0c8d5`, via `parse()` + walker de AST, com `setdiff` nos dois sentidos e teste de duplicatas.
7. Análise de alcançabilidade: grep de toda atribuição (`<-` / `=`) aos 12 símbolos de que a asserção viva depende, para decidir se o segundo `is_valid_contract_semantics(contract_text)` pode falhar.
8. Bateria de derivas dirigidas (Seção 13 / `beta_primitive` / cabeçalho) com o pino de arquivo inteiro recalculado, lendo a mensagem exata que o operador veria.
9. Bateria de não-vacuidade dos três canários, incluindo o caso degenerado forçado (substituição só na cópia da Seção 13).
10. Oito ataques construídos e medidos em memória, com **contagem de constantes** feita mecanicamente: recomputo cada região e conto quantos pinos mudaram, em vez de estimar.
11. `Rscript --vanilla scripts/verify_essential_input_gate0.R` — execução completa, `PASS` em 3,5 s.

---

## Item 1 — Hashes

**Todos os cinco batem.** Recomputados independentemente pelo algoritmo do próprio script:

| Objeto | Pinado | Recomputado | Confere | Mudou desde a rodada 2 |
|---|---|---|---|---|
| contrato integral | `20c331df…de1d0d` | idem | SIM | sim (`ef38be13` → `20c331df`) |
| `authorization_header` | `7b7c601e…bbad04` | idem | SIM | sim (`7ea2bdc4` → `7b7c601e`) |
| `beta_primitive` | `bb7ee339…bf41b4` | idem | SIM | **não** |
| `delay_cost_decision` | `3c448385…bb8f2a` | idem | SIM | **não** |
| `protected_artifacts` | `0f3b64ac…b504f8e8` | idem | SIM | **não** |

**`beta_primitive`, `delay_cost_decision` e `protected_artifacts` continuam byte-idênticos aos da rodada 2.** Três hashes inalterados são prova mecânica de que nada em primitivas, desconto, custo de atraso ou Seção 13 foi tocado. O diff confirma: a única região editada é o cabeçalho.

Fronteiras medidas (1-based): `authorization_header` = 3–52; `beta_primitive` = linha 297; `delay_cost_decision` = 369–388; `protected_artifacts` = 1247–1284. Cada um dos oito marcadores de fronteira ocorre exatamente uma vez.

Delta do contrato: o bloco `**Artefatos protegidos, reasserção de 2026-08-23.**` desapareceu como bloco autônomo; a lista de protegidos migrou para dentro de `**Não autorizado.**` como oração relativa com remissão; surgiu o bloco `**Goal 0 da extensão de agenda.**`; e `N1` a `N7` virou a enumeração correta `N1`, `N2`, `N3`, `N4`, `N6`, `N7`, sem `N5`. Delta do verificador: duas constantes, um comentário de decisão, três mensagens reescritas, dois canários novos, mensagem final reescrita.

---

## Item 2 — Os três canários

### Não-vacuidade e localização das âncoras

| Canário | Âncora | Ocorrências | Linhas | Região do 1º acerto | `sub()` altera? | validador vira FALSE? | Não-vacuoso |
|---|---|---|---|---|---|---|---|
| `removed_v5_protection` | `RIO submission files/` | **1** | 35 | HEADER | SIM | SIM | SIM |
| `removed_v5_manuscript_protection` | `formal_model_v5.Rmd` | **2** | 34, 1278 | HEADER | SIM | SIM | SIM |
| `removed_frozen_artifact_protection` | `artefatos congelados de` | **1** | 35 | HEADER | SIM | SIM | SIM |

**`formal_model_v5.Rmd` ocorre duas vezes e o `sub()` acerta a do cabeçalho.** Confirmado: linha 34 (dentro de 3–52) e linha 1278 (dentro de 1247–1284); `sub()` substitui só a primeira. Nenhuma ocorrência anterior de `formal_model_v5.Rmd` existe no arquivo — a linha 51 menciona `formal_model_v6.Rmd`, string distinta.

**O caso degenerado falha ruidosamente.** Forcei a substituição apenas na cópia da Seção 13 (linha 1278): `is_valid_reopened_authorization` devolve `TRUE`, logo `assert_true(!TRUE, …)` chama `stop()`. Medido:

```
  Section-13-only replacement changes text : TRUE
  is_valid_reopened_authorization          : TRUE
  assert_true(!.) would STOP loudly        : TRUE
  is_valid_protected_artifacts             : FALSE
```

**Os três cobrem os três itens que a mensagem nomeia.** O bloco `**Não autorizado.**` protege exatamente `formal_model_v5.Rmd`, `RIO submission files/` e os artefatos congelados; há um canário para cada. T-1 da rodada 2 foi implementado como especificado.

### O que os canários *não* fazem — e isso é grave

A verificação acima confirma a conformidade formal e para por aí. Mecanicamente, os três canários são `assert_true(!is_valid_reopened_authorization(mutado))`, e `is_valid_reopened_authorization` é dominada por uma igualdade SHA-256 exata da região inteira do cabeçalho. **Qualquer** alteração de **qualquer** byte do cabeçalho já faz o validador devolver `FALSE`. Portanto o que os três canários testam é:

> "a string-âncora ocorre pelo menos uma vez dentro da região do cabeçalho"

e nada além disso. Eles não testam que a âncora está na cláusula de proteção, nem que a cláusula existe. A propriedade que verificam já é implicada pelo pino integral do cabeçalho, que existia antes deles.

O script é explicitamente honesto sobre esse mesmo mecanismo quando se trata dos cinco `grepl` — a nota das linhas 176–182 diz que eles "nunca decidem nada" porque vêm depois de uma igualdade SHA-256 sobre a mesma string. Essa honestidade não foi estendida aos três canários novos, cujas mensagens afirmam testar "Removing X … must fail". Ver **S-2**, com ataque medido.

O que salva os canários contra a deleção *pura* é um acidente, não um desenho: se a âncora sumir, `sub()` devolve o texto inalterado, o validador devolve `TRUE` e a asserção dispara. Note que os três canários **não têm** a asserção de não-vacuidade que os dois laços de mutação carregam (`"… its anchor is dead."`); dependem inteiramente daquele acidente. O ataque de isca da S-2 é precisamente a construção que o quebra.

---

## Item 3 — T-2, deriva dirigida e a mensagem que o operador vê

Forcei três derivas isoladas, cada uma com o pino de arquivo inteiro recalculado (de modo que a primeira asserção viva, linha 287, passa seu teste de hash e a falha cai em `is_valid_contract_semantics`):

| Deriva | `authorization_header` | `beta_primitive` | `delay_cost_decision` | `protected_artifacts` | `is_valid_contract_semantics` |
|---|---|---|---|---|---|
| só na Seção 13 | TRUE | TRUE | TRUE | **FALSE** | FALSE |
| só em `beta_primitive` | TRUE | **FALSE** | TRUE | TRUE | FALSE |
| só no cabeçalho | **FALSE** | TRUE | TRUE | TRUE | FALSE |

Mensagem que o operador vê nos **três** casos, byte a byte idêntica:

```
One of the four pinned regions -- authorization header, beta primitive,
complete strict-delay decision, or Section 13 protected artifacts -- differs
from its exact author-approved regional object/hash.
```

**T-2 está cumprido como especificado.** O reparo que a rodada 2 forçou era único e literal — "acrescentar a região de artefatos protegidos à enumeração da mensagem" —, e foi feito. O defeito concreto que T-2 nomeava desapareceu: uma deriva só na Seção 13 já não manda o operador investigar exclusivamente regiões que passaram, porque a região que falhou está agora na lista.

**Mas a mensagem não aponta a região certa; ela nomeia as quatro.** Ela é invariante à deriva: a mesma string para deriva no cabeçalho, na primitiva de desconto e na Seção 13. O operador recebe "uma das quatro" e refaz o trabalho à mão. A maquinaria para discriminar já está construída e é gratuita — `is_valid_reopened_authorization`, `is_valid_strict_beta_contract` e `is_valid_protected_artifacts` são três booleanos separados, e minha tabela acima foi produzida em três linhas de R usando as funções do próprio script. Classifico como ADVISORY (A-1) e não como finding novo, porque a não-discriminação é propriedade pré-existente das rodadas 1 e 2, não foi introduzida por este diff, e o reparo que a rodada 2 forçou foi entregue integralmente.

Há, porém, um achado adjacente: **a segunda "asserção viva" nunca imprime sua mensagem.** Ver **S-4**.

---

## Item 4 — Não houve enfraquecimento

**Contagem.** `grep -c assert_true` = **164**, dos quais 1 é a definição (linha 9) → **163 chamadas**. Rodada 2: 162 − 1 = 161. Rodada 1: 157 − 1 = 156. Trajetória monotônica crescente.

**Diff mecânico do conjunto de mensagens** (AST walker, `setdiff` nos dois sentidos):

Removidas/alteradas (3), todas substituídas por versão mais forte ou mais precisa:
- `"The canonical authorization header, beta primitive, or complete strict-delay decision differs…"` → passou a nomear as quatro regiões.
- `"The governing contract must retain strict beta<1; the separate posterior authorization pinned above remains limited to N6."` → `"…across all four pinned regions, including the Section 13 protected artifacts."`
- `"Removing the reasserted protection of v5, RIO files, and N1-N7 must fail."` → dividida em três mensagens, uma por âncora.

Acrescentadas (5): as três reescritas acima mais os dois canários novos. **Zero mensagens duplicadas.** **Nenhuma asserção removida. Nenhuma afrouxada.** Toda alteração de predicado é no sentido de mais cobertura: o conjunto de regiões checadas passou de três para quatro, e `is_valid_contract_semantics` ganhou o conjunto `is_valid_protected_artifacts`.

**Contagens declaradas nas mensagens — todas corretas**, medidas contra os objetos reais:

| Declaração | Medido | Confere |
|---|---|---|
| "one of the **nine** regional semantic contradictions" | `length(semantic_mutations)` = 9 (6 + 3) | SIM |
| "one of the **twelve** Round 3 full-contract mutations" | `length(r3_contract_mutations)` = 12 | SIM |
| "FALSE for all **12** Round 3 mutations" (`MUTATION_REJECTED`) | 12 | SIM |
| "**four** pinned regions" / "**Four** contract regions are pinned" | 4 | SIM |

**Uma asserção inalcançável.** `assert_true(is_valid_contract_semantics(contract_text), …)` aparece duas vezes: linhas 288 e 2259. Verifiquei por grep de atribuição que **nenhum** dos doze símbolos de que o predicado depende é reatribuído em lugar algum do arquivo:

```
contract_text                        linha 283  (única)
expected_contract_hash               linha  72  (única)
expected_contract_region_hashes      linha  73  (única)
expected_beta_primitive              linha  71  (única)
is_valid_contract_semantics          linha 211  (única)
is_valid_reopened_authorization      linha 183  (única)
is_valid_strict_beta_contract        linha 197  (única)
is_valid_protected_artifacts         linha 167  (única)
extract_normative_contract_regions   linha  80  (única)
sha256_text / sha256_file / assert_true   linhas 36 / 23 / 9  (únicas)
```

Logo a chamada de 2259 aplica uma função pura a um argumento inalterado que já foi asseverado verdadeiro em 288, e `assert_true` chama `stop()`. **A asserção de 2259 não pode falhar; sua mensagem não pode ser exibida.** Ver **S-4**.

---

## Item 5 — A remissão de S-1 mudou a superfície de ataque? **Mudou, e barateou.**

### O texto, tal como está

```
**Não autorizado.** … e a edição de `formal_model_v5.Rmd`, da pasta
`RIO submission files/` e dos artefatos congelados de `N1`, `N2`, `N3`, `N4`,
`N6` e `N7`, que permanecem protegidos nos termos da Seção 13, cuja limitação
temporal ao gate do Goal 5 fica sem efeito por decisão autoral desta data.
```

Conformidade com a decisão fechada (item 4 do enunciado): **cumprida.** A cláusula está dentro do bloco `**Não autorizado.**`, é remissiva ("nos termos da Seção 13"), a Seção 13 é byte-idêntica e a tabela de fonte única é byte-idêntica — as três coisas medidas, não inferidas.

### Ataque 1 — esvaziar a lista de protegidos da Seção 13

Substituí `- \`formal_model_v5.Rmd\` e \`formal_model_v6.Rmd\`, até o gate do Goal 5;` por `- nenhum manuscrito permanece protegido;`, recalculando o que mudou. Medido:

```
constants the attacker must recompute : 2   (whole-file + protected_artifacts)
guard is_valid_contract_semantics     : TRUE
canary[RIO]    : silent pass
canary[v5]     : silent pass
canary[frozen] : silent pass
```

O verificador **não pega**, e nenhum dos três canários novos dispara — eles mutam o cabeçalho, que está intacto.

**Comparação com o Ataque 4 da rodada 2.** Lá o custo também era 2 constantes, mas o ataque **não obtinha nada**: o cabeçalho dizia, em bloco próprio e por autoridade própria, *"`formal_model_v5.Rmd`, a pasta `RIO submission files/` e os artefatos congelados de `N1` a `N7` permanecem protegidos e não autorizados para edição, **por decisão autoral desta data**"* — afirmação autossuficiente, sem deferência. Para desfazer a proteção era preciso editar também o cabeçalho: **terceira constante**.

Agora existe uma leitura em que 2 constantes bastam, e é a leitura que o próprio reparo instalou. "Nos termos da Seção 13" é deferência: transfere para a Seção 13 o conteúdo operativo da proteção. Se a Seção 13 deixa de listar `formal_model_v5.Rmd`, a remissão aponta para conjunto vazio. A regra de fonte única reforça essa leitura, e não a contrária: menções fora da fonte "servem apenas para explicar, usar o objeto já definido ou apontar para a seção correspondente; não podem qualificá-lo, ampliá-lo nem criar exceções" — e uma menção que não pode ampliar tampouco pode *criar* proteção onde a fonte canônica não a tem.

**A força normativa independente do cabeçalho era exatamente o que exigia a terceira constante. O reparo de S-1 curou o conflito de competência removendo essa força. Custo medido: 3 → 2.**

Registro a leitura concorrente com igual ênfase, porque ela existe: "**Não autorizado** … a edição de X" é, gramaticalmente, proibição direta no domínio canônico do cabeçalho ("status e autorização da fase"), e a oração relativa seria explicativa. Sob essa leitura o custo continua 3. Duas leituras, consequências opostas sobre se `v5` fica protegido — **ambiguidade escala**.

### Ataque 2 — o custo real para dois dos três objetos é **zero**

Este é o achado central da rodada. Lista completa da Seção 13, verbatim:

```
São protegidos:

- `quality_reports/2026-08-12_essential_input_gate0_decisions.md`, …;
- `formal_model_v5.Rmd` e `formal_model_v6.Rmd`, até o gate do Goal 5;
- todos os artefatos da cadeia `pivotal-response`, …
```

Medido por grep sobre o contrato inteiro:

- **`RIO submission files/` ocorre uma única vez no contrato — linha 35, dentro do cabeçalho.** A Seção 13 nunca o menciona.
- Os **artefatos congelados de `N1`, `N2`, `N3`, `N4`, `N6`, `N7`** não estão na Seção 13. Ela protege "todos os artefatos da cadeia `pivotal-response`", que o próprio contrato declara arquitetura **substituída** (linha 50). Confirmei em disco que são conjuntos disjuntos: os artefatos congelados vivem em `model_redesign/essential_input_*` (`essential_input_interfaces/n1_r2_majority_candidate_v1.json`, `essential_input_n2_r2_unanimity_interface.json`, `essential_input_solution_concept/n3_…`, `n4_…`, `essential_input_n6_private_comparison_candidate.json`, `essential_input_n7_complete_information_benchmark_candidate.json`), ao lado de — e não dentro de — `model_redesign/pivotal_response_*`.

Intersecção entre a lista do cabeçalho e a lista da Seção 13: **apenas `formal_model_v5.Rmd`**. A remissão defere, para dois de três objetos, a uma seção que nunca os menciona.

Custo do ataque: **zero constantes, zero edições.** Sob a leitura remissiva, `RIO submission files/` e os artefatos congelados de N1–N7 não estão protegidos por nenhuma cláusula do contrato hoje, e o guarda passa. Ver **S-1**.

### Ataque 3 (novo) — isca no cabeçalho anula os três canários de T-1

Construção: inserir uma linha inócua logo após `**Data:** 2026-08-12`, dentro do cabeçalho, contendo as três strings-âncora; depois **apagar** a cláusula de proteção do bloco `**Não autorizado.**`. Custo: as mesmas 2 constantes de qualquer edição de cabeçalho (integral + `authorization_header`); a isca é gratuita porque cai na região cujo pino já vai ser recomputado.

Medido:

```
constants the attacker must recompute : 2
guard is_valid_contract_semantics     : TRUE
canary[RIO]    : silent pass
canary[v5]     : silent pass
canary[frozen] : silent pass
header still contains the protection clause? FALSE
```

Bloco resultante, com a proteção removida e os cinco `grepl` intactos:

```
**Não autorizado.** A fronteira `beta=1`; a aprovação do Gate 0 da extensão de
agenda informal e tudo o que a suceda nessa cadeia — scripts, derivações,
comparação e migração —, ressalvado o Goal 0 tratado abaixo; a criação da tag
final do Goal 5 sem aval autoral explícito; qualquer declaração de encerramento
do Goal 5; qualquer extensão daqueles pareceres aos bytes correntes do
manuscrito.
```

O mecanismo: com a isca presente, `sub()` morde a isca em vez da cláusula; o texto mutado difere do original; o hash da região difere; o validador devolve `FALSE`; `assert_true(!FALSE)` passa **em silêncio**. Os três canários foram construídos para tornar ruidosa exatamente esta classe de edição, e não a tornam. Ver **S-2**.

### Tabela consolidada dos ataques medidos

| # | Ataque | Constantes | Guarda pega? |
|---|---|---|---|
| 1 | Esvaziar a lista de protegidos da Seção 13 | **2** | não |
| 2 | Zero-edição: RIO e congelados sem base na Seção 13 | **0** | n/a — nada mudou |
| 3 | Isca no cabeçalho + apagar a cláusula de proteção | **2** | não; anula os 3 canários |
| 4 | Carve-out de `beta=1` na Seção 12 (risco aceito, S-2 r2) | **1** | não |
| 5 | Inversão **aditiva** do cabeçalho preservando os cinco `grepl` | **2** | não |
| 6 | Alargar o Goal 0 no plano v3 (não pinado) | **0** | não; zero referências |
| 7 | Editar o registro do GO de 2026-08-23 (não pinado) | **0** | não |
| 8 | Renomear o marcador `## 13.` (controle) | 1 | **SIM**, ruidoso via `regions == NULL` |

Ataque 5, re-medido: os cinco `grepl` — `permanece aberto`, `falta o aval`, `b5fdefb`, `sem aval autoral`, `agenda informal` — continuam todos `TRUE` após inserção de frase com polaridade invertida. Confirma que a nota documental das linhas 176–182 é honesta. Carregado da rodada 2, inalterado.

---

## Item 6 — Goal 0 e a mensagem final

### Registro da decisão sobre S-2 (item 1 do enunciado): fiel e localizável, com uma imprecisão

O comentário está nas linhas 154–161, imediatamente após `extract_normative_contract_regions` e imediatamente antes do pino da Seção 13 — posição correta, quem for propor um pino regional novo lê os dois juntos. O roteiro `quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md`, item 2 da lista de reparos, repete a decisão. **Localizável e fiel quanto à decisão e quanto ao alcance** ("a rota de inserção pela Seção 12 é aceita como risco conhecido"; "não repropor sem nova decisão autoral").

Uma frase do **motivo** é mecanicamente falsa: *"um pino regional compra legibilidade do diff, não uma fronteira de segurança nova — **o hash integral já rejeita a mutação**"*. O hash integral só rejeita a mutação de quem **não** o recalcula. Todo o resto da arquitetura de pinos existe precisamente porque o hash integral é recalculável: é essa a premissa dos quatro pinos regionais e dos vinte e um testes de mutação. Re-medi o Ataque 4: **1 constante** e o carve-out da Seção 12 passa. A frase, lida por um revisor futuro, sugere cobertura que não existe. Ver **T-1**.

### Fidelidade cláusula a cláusula da mensagem `PASS`

| Cláusula nova da `PASS` | Texto do contrato | Veredicto |
|---|---|---|
| "Beta=1 extensions … remain unauthorized" | linha 29: "A fronteira `beta=1`" | **verdadeira** |
| "any declaration of Goal 5 closure remain unauthorized" | linha 32: "qualquer declaração de encerramento do Goal 5" | **verdadeira** |
| "as is approval of the agenda-extension Gate 0 contract and every later goal in that chain" | linhas 29–31: "a aprovação do Gate 0 da extensão de agenda informal e tudo o que a suceda nessa cadeia — scripts, derivações, comparação e migração —, ressalvado o Goal 0 tratado abaixo" | **verdadeira**; a `PASS` diz "every later goal", o contrato diz "tudo o que a suceda … scripts, derivações, comparação e migração" — paráfrase mais estreita, mas não falsa |
| "the author's 2026-08-23 GO covers only drafting that contract" | linhas 39–42: "GO explícito em 2026-08-23 para o Goal 0 do plano v3, limitado à redação do contrato executável do respectivo Gate 0. O GO não alcança a aprovação desse contrato, os Goals seguintes da extensão nem qualquer artefato matemático." | **fiel**; omite "nem qualquer artefato matemático", que "covers only drafting" implica sem afirmar |
| "Editing formal_model_v5.Rmd, RIO submission files/, or the frozen N1/N2/N3/N4/N6/N7 artifacts is **unauthorized under Section 13**" | Seção 13 protege o registro de decisões, `v5`+`v6` até o gate do Goal 5, e a cadeia `pivotal-response` | **FALSA para dois dos três objetos.** Ver **S-1** |
| "whose Goal 5 time limit the author set aside" | linha 36: "cuja limitação temporal ao gate do Goal 5 fica sem efeito" | **verdadeira** |
| "Four contract regions are pinned, Section 13 among them" | 4 pinos medidos | **verdadeira** |

**Nenhuma afirmação residual de que a extensão de agenda está integralmente não autorizada.** Grep exaustivo em `quality_reports/plans/2026-08-12_essential_input_gate0.md` (só linhas 30 e 39 mencionam "agenda", ambas já com a ressalva), nas mensagens vivas do verificador, em `AGENTS.md` e em `CLAUDE.md`. As três ocorrências de "extensao de agenda … autorizada/liberada" no script estão dentro de *payloads de mutação* — strings que o guarda deve rejeitar —, o que é correto. A mensagem antiga "The agenda extension, beta=1 extensions, and any declaration of Goal 5 closure remain unauthorized" foi removida. **Item cumprido.**

### O que não foi feito, e é estrutural

O GO de 2026-08-23 é a **única autorização atualmente viva** desta arquitetura, e é a única sem registro pinado. Padrão do repositório, verificado: `2026-08-21_autorizacao_goal3_n6.md` (pinado, `4c18e9bf…`), `2026-08-21_autorizacao_goal5.md` (pinado, `10e0d6d9…`), `2026-08-21_fechamento_autoral_goal4_n7.md` (pinado, `ca7a842b…`). Os dez registros pinados são **todos** de 2026-08-21. Não existe em `quality_reports/` nenhum `2026-08-23_autorizacao_*`; o GO só está narrado no item 5 da lista de reparos de `2026-08-23_inconsistencia_cabecalho_contrato_gate0.md`, arquivo **não pinado**. E o alcance operativo do GO é definido por remissão a "o Goal 0 do plano v3" — `quality_reports/plans/2026-08-23_agenda_extension_gated_plan_v3.md`, também **não pinado**: o verificador tem **zero** referências a ele. Ver **S-3**.

---

## Item 7 — Ataques novos

Além dos re-medidos (4, 5, 8 da tabela), construí quatro novos. Três estão detalhados no item 5 (Ataques 2 e 3) e no item 6; segue o restante.

### Ataque 6 — alargar o Goal 0 no plano v3, **0 constantes**

O bloco novo do cabeçalho é pinado, mas seu referente não é. Editar `quality_reports/plans/2026-08-23_agenda_extension_gated_plan_v3.md` para alargar o "Goal 0" custa zero constantes e é invisível ao guarda.

**Mitigação real, que registro com honestidade:** o cabeçalho não defere apenas; ele traz um limite autossuficiente ("limitado à redação do contrato executável do respectivo Gate 0"; "não alcança … nem qualquer artefato matemático"). Um Goal 0 alargado no plano colidiria com esse limite, e qualquer agente que leia o cabeçalho recusaria.

**Mas o conflito já existe hoje, sem ataque nenhum.** O Goal 0 do plano v3 (§7, linha 528) entrega: *"forma extensiva, informação, primitivas do §2.5, protocolo de trembling com Lebesgue normalizada, Bayes para átomos e densidades, topologia do limite, estimandos, schema, DAG, ledger vazio, **verifier** e invalidação."* Confrontado com o cabeçalho: (i) "não alcança … qualquer artefato matemático" — protocolo de trembling com medida de Lebesgue normalizada, Bayes para átomos e densidades e topologia do limite são conteúdo matemático, ainda que especificação e não derivação; (ii) o bloco `**Não autorizado.**` lista "**scripts**, derivações, comparação e migração" como não autorizados, "ressalvado o Goal 0" — e o Goal 0 do plano entrega justamente um `verifier`, que é script. Duas leituras defensáveis, uma autorizando a redação da especificação matemática e do verificador, outra proibindo. Ver **S-3**.

### Ataque 7 — plantar alcance no registro não pinado do GO, **0 constantes**

Editar `quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md`, item 5, para narrar um GO mais largo ("o autor confirmou GO para os Goals 0 e 1"). Nenhum byte pinado muda. É o único registro de autorização viva em disco e não tem hash. Contraste: cada autorização **encerrada** tem registro pinado. A arquitetura protege melhor o que já não pode ser usado do que aquilo que pode.

### Observação transversal

`sha256_file` continua chamando `system2("shasum", …)` resolvido por `PATH`. Os treze hashes pinados, as quatro regiões e o manifesto repousam nesse binário. Carregado de A-1 da rodada 1 e A-5 da rodada 2, ainda válido.

---

## Findings

### SUBSTANTIVE

**S-1 — A remissão defere a uma seção que não protege dois dos três objetos deferidos, e a mensagem `PASS` afirma uma base normativa inexistente.**

O bloco `**Não autorizado.**` declara que `formal_model_v5.Rmd`, `RIO submission files/` e os artefatos congelados de `N1`, `N2`, `N3`, `N4`, `N6` e `N7` "permanecem protegidos **nos termos da Seção 13**". Medido sobre o contrato inteiro:

- `RIO submission files/` ocorre **uma única vez em todo o arquivo**, na linha 35, dentro do cabeçalho. A Seção 13 nunca o menciona.
- A Seção 13 não menciona os artefatos congelados da cadeia essential-input. Sua terceira alínea protege "todos os artefatos da cadeia `pivotal-response`" — a arquitetura que este contrato declara **substituída** (linha 50). Verifiquei em disco que os conjuntos são disjuntos: `model_redesign/essential_input_*` versus `model_redesign/pivotal_response_*`.
- Intersecção das duas listas: **apenas `formal_model_v5.Rmd`**.

Consequências, em ordem de gravidade:

1. Sob a leitura remissiva — que é a leitura que o reparo instalou, e a que a regra de fonte única sustenta —, `RIO submission files/` e os artefatos congelados de N1–N7 **não estão protegidos por cláusula alguma do contrato**. Custo do ataque: **zero**.
2. A cláusula final "cuja limitação temporal ao gate do Goal 5 fica sem efeito" só faz sentido para a alínea de `v5`/`v6`. Para os outros dois objetos, afasta um limite de uma proteção que não existe.
3. A mensagem `PASS` afirma, ao operador, que editar os três "is unauthorized **under Section 13**". Isso é falso para dois deles. É uma afirmação normativa errada no artefato que o contrato designa como verificação canônica (Seção 13, "Verificação canônica da infraestrutura").
4. Ainda que se adote a leitura de que o cabeçalho legisla diretamente, a remissão é então uma **citação errada** — o cabeçalho manda o leitor a uma seção que não contém a regra —, e a cláusula "fica sem efeito" continua sendo qualificação de fonte alheia, que a regra de fonte única proíbe. As duas leituras deixam defeito; elas discordam apenas sobre qual.

Registro com igual ênfase o que **não** é o caso: nenhum dano ocorreu — worktree limpo, `formal_model_v5.Rmd`, `RIO submission files/` e os seis artefatos congelados byte-idênticos —, a intenção autoral é inequívoca, e a decisão fechada (remissão dentro de `**Não autorizado.**`, Seção 13 e tabela intactas) foi implementada com fidelidade literal. Não estou relitigando a escolha. Estou reportando a consequência que a escolha não antecipou: o alvo da remissão está vazio para dois de três objetos.

*Reparos possíveis, não único (por isso SUBSTANTIVE):* emendar a Seção 13 para incluir `RIO submission files/` e os artefatos congelados de `N1`, `N2`, `N3`, `N4`, `N6` e `N7`, com recomputação de `protected_artifacts` e do hash integral; ou reescrever a remissão para deferir apenas quanto a `v5`/`v6` e legislar explicitamente sobre os outros dois no cabeçalho, emendando a linha da tabela de fonte única; ou emendar a tabela para atribuir "artefatos protegidos" ao cabeçalho. Em qualquer caso, a cláusula "unauthorized under Section 13" da mensagem `PASS` precisa acompanhar. Escolher é decisão de desenho autoral.

**S-2 — Os três canários de T-1 não testam o que suas mensagens afirmam, e um ataque de 2 constantes anula os três em silêncio.**

`is_valid_reopened_authorization` é dominada por uma igualdade SHA-256 exata da região inteira do cabeçalho. Qualquer byte alterado ali já a torna `FALSE`. Logo `assert_true(!is_valid_reopened_authorization(sub(âncora, …, contract_text)))` verifica somente que **a âncora ocorre em algum ponto do cabeçalho** — propriedade já implicada pelo pino integral do cabeçalho, que precede os canários. As mensagens afirmam mais: *"Removing formal_model_v5.Rmd from the reasserted protection must fail."*

Ataque medido (Ataque 3 do item 5): inserir no cabeçalho uma linha-isca contendo as três âncoras e **apagar** a cláusula de proteção. Custo: as mesmas 2 constantes de qualquer edição de cabeçalho — a isca é gratuita, porque cai na região cujo pino já vai ser recomputado. Resultado: cláusula ausente, cinco `grepl` intactos, guarda `PASS`, e os três canários passam **em silêncio**, porque `sub()` mordeu a isca.

Agrava: os três canários **não têm** a asserção de não-vacuidade que os dois laços de mutação carregam (`"A regional semantic mutation produced no change; its anchor is dead."` e `"A Round 3 contract mutation produced no change; its anchor is dead."`). Sua robustez contra deleção *pura* é acidental — depende de o texto inalterado continuar válido — e é exatamente esse acidente que a isca desfaz.

Nota de contraste que reforça o ponto: o script é explicitamente honesto sobre este mesmo mecanismo nas linhas 176–182, ao dizer dos cinco `grepl` que "são avaliados depois de uma igualdade SHA-256 exata sobre a mesma string, logo nunca decidem nada". A mesma análise se aplica aos canários novos e não foi feita.

*Reparos possíveis, não único:* aplicar o `sub()` sobre `extract_normative_contract_regions(contract_text)$authorization_header` e comparar o resultado contra a região original, em vez de mutar o texto inteiro; ou substituir o par âncora/hash por um teste de conteúdo positivo (a região **deve conter** as três strings, e o teste falha se alguma sumir — o que a isca não satisfaz porque o predicado seria sobre a cláusula, não sobre a região); ou acrescentar a asserção de não-vacuidade dos laços e documentar que a cobertura é a fraca. As três são desenhos diferentes com propriedades diferentes.

**S-3 — A única autorização viva da arquitetura é a única sem registro pinado, e seu alcance é definido por remissão a um plano não pinado cujas entregas contradizem o limite declarado.**

Duas metades, ambas medidas.

*Primeira.* Os dez registros de `quality_reports/` pinados pelo guarda são **todos** de 2026-08-21 e correspondem a autorizações **encerradas** (`autorizacao_goal3_n6`, `autorizacao_goal5`, `fechamento_autoral_goal4_n7`, integrações e manifestos de revisão). O GO de 2026-08-23 — a única autorização atualmente operante — não tem arquivo dedicado em `quality_reports/`; está narrado no item 5 de `2026-08-23_inconsistencia_cabecalho_contrato_gate0.md`, que o guarda não pina (zero referências). A arquitetura pina melhor o que já não pode ser usado do que aquilo que pode. Ataque 7: alargar o GO editando esse registro custa **zero** constantes.

*Segunda.* O cabeçalho pinado defere a "o Goal 0 **do plano v3**", arquivo vivo e não pinado (zero referências no verificador). Não é só risco prospectivo: o conflito já existe. O Goal 0 do plano v3 (§7, linha 528) entrega "protocolo de trembling com Lebesgue normalizada, Bayes para átomos e densidades, topologia do limite … e **verifier**". O cabeçalho diz que o GO "não alcança … qualquer artefato matemático" e que "scripts" estão entre as não-autorizações, "ressalvado o Goal 0". Um agente que leia o plano produz especificação matemática e um script e se julga autorizado; um agente que leia o cabeçalho recusa. Duas leituras defensáveis do mesmo GO — **ambiguidade escala**.

*Reparos possíveis, não único:* criar e pinar `quality_reports/2026-08-23_autorizacao_goal0_extensao_agenda.md` reproduzindo o GO e seu alcance; e/ou pinar o plano v3; e/ou reescrever o bloco do cabeçalho de modo autossuficiente, enumerando o que o GO alcança sem remeter ao plano e sem a locução "qualquer artefato matemático", que colide com as entregas de especificação. A escolha, e sobretudo a delimitação substantiva entre "especificação matemática de um contrato executável" e "artefato matemático", é decisão autoral.

**S-4 — A segunda "asserção viva" é inalcançável em seu ramo de falha; sua mensagem foi editada nesta rodada e nunca poderá ser exibida.**

`assert_true(is_valid_contract_semantics(contract_text), …)` ocorre nas linhas 288 e 2259. Verifiquei por grep de atribuição que **nenhum** dos doze símbolos de que o predicado depende — `contract_text`, `expected_contract_hash`, `expected_contract_region_hashes`, `expected_beta_primitive`, as quatro funções `is_valid_*`, `extract_normative_contract_regions`, `sha256_text`, `sha256_file`, `assert_true` — é reatribuído em ponto algum do arquivo; cada um tem atribuição única, e todas anteriores à linha 288. Como `assert_true` chama `stop()`, a segunda chamada só é alcançada quando a primeira devolveu `TRUE`, e aplica a mesma função pura ao mesmo argumento. Ela não pode falhar. Não re-lê o arquivo do disco, portanto também não funciona como guarda de TOCTOU.

O reparo de T-2 editou a mensagem dessa asserção, e o roteiro registra: *"As duas asserções vivas enumeravam três regiões … Agora nomeiam as quatro."* Apenas uma delas pode ser vista por um operador. É o mesmo gênero de imprecisão de proveniência que A-7 da rodada 2 apontou: um registro que descreve mal o artefato é o germe de deriva que esta arquitetura existe para impedir. A execução real, que rodei, confirma — a mensagem impressa é a de 288.

Registro o que **não** é o caso: o enforcement está intacto. A verificação das quatro regiões é genuinamente executada em 288 e a linha 2259 não enfraquece nada. O defeito é de diagnóstico morto e de registro inexato, não de cobertura.

*Reparos possíveis, não único:* remover a chamada redundante; ou torná-la não-redundante relendo `contract_path` do disco, o que a converteria num teste TOCTOU real e daria conteúdo à mensagem; ou mantê-la como redundância deliberada e corrigir o roteiro para dizer que só uma asserção é observável.

### TECHNICAL

**T-1 — O motivo registrado da decisão sobre S-2 afirma cobertura que a medição contradiz.**

Linhas 154–161, comentário `DECISAO AUTORAL 2026-08-23`. A decisão e seu alcance estão fielmente registrados e o comentário está bem localizado — imediatamente antes do pino da Seção 13, onde quem for repropor o lerá. A imprecisão está em uma frase do motivo: *"um pino regional compra legibilidade do diff, não uma fronteira de segurança nova — **o hash integral já rejeita a mutação**"*. O hash integral rejeita a mutação apenas de quem não o recalcula; toda a arquitetura de quatro pinos regionais e vinte e um testes de mutação pressupõe o contrário. Re-medi: com o integral recalculado, o carve-out de `beta=1` na Seção 12 passa por **1 constante**. Um revisor futuro que leia essa frase concluirá que a Seção 12 está coberta.

O reparo é único e forçado pelo que já está escrito no próprio comentário, que na frase seguinte já qualifica corretamente ("aceita como risco conhecido"): substituir a oração pela medição — que a Seção 12 permanece alcançável por **uma** constante após recomputação do hash integral, e que a decisão é aceitar esse residual. Não altera a decisão, corrige o registro. Reparo único ⇒ TECHNICAL.

### ADVISORY

**A-1 — A mensagem das quatro regiões é invariante à deriva.** T-2 foi cumprido literalmente e o defeito que ele nomeava desapareceu. Resta que a mensagem é byte-idêntica para deriva no cabeçalho, na primitiva de desconto e na Seção 13: nomeia as quatro e não identifica a que falhou. A maquinaria para discriminar já existe — três booleanos separados —, e produzi a tabela discriminante em três linhas de R com as funções do próprio script. Não é defeito introduzido por este diff; é propriedade herdada das rodadas 1 e 2.

**A-2 — Duas das três mensagens de canário usam termo superado.** *"from the reasserted protection"* nas linhas 2547 e 2558. A cláusula deixou de ser reasserção e virou remissão; a mensagem do primeiro canário foi atualizada e as duas novas não. Cosmético, mas é vocabulário normativo dentro do artefato de verificação.

**A-3 — Raiz de confiança dependente de `PATH`.** `sha256_file` usa `system2("shasum", …)`. Considerar caminho absoluto ou `digest`/`openssl`. Carregado das rodadas 1 e 2, inalterado.

**A-4 — Ponteiros de dentro de região imutável para alvos mutáveis.** A região `authorization_header`, pinada, aponta para `quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md` e, agora, para "o plano v3". Ambos commitados — A-6 da rodada 2 fechou nessa parte —, mas nenhum pinado. Relaciona-se com S-3; registro separadamente porque a recomendação (pinar) é a mesma para os dois arquivos e independe da decisão substantiva sobre o alcance do GO.

**A-5 — "Goal 0" virou nome sobrecarregado, justo quando um GO passou a existir para um deles.** O contrato tem seu próprio Goal 0 (essential-input), e o plano v3 tem outro (extensão de agenda). O cabeçalho desambigua bem ("**Goal 0 da extensão de agenda** … do plano v3"), e a `PASS` também. Mas `CLAUDE.md` (linhas 146 e 249) e `AGENTS.md` (linhas 425 e 495) ainda dizem que "a prioridade corrente é o Goal 0 do contrato essential-input" — Goal 0 encerrado, Goals 1–4 fechados. Um agente que leia a memória e depois ouça "há GO para o Goal 0" pode juntar as duas metades erradas.

**A-6 — O cabeçalho afasta um limite que ainda não mordeu.** A Seção 13 protege `v5`/`v6` "até o gate do Goal 5"; o cabeçalho declara o Goal 5 **aberto** ("falta o aval autoral terminal") e, na mesma página, afasta aquele limite temporal. Se o gate não passou, o limite ainda não caducou e o afastamento é prospectivo — legítimo, mas note que a premissa da rodada 2 ("gate que já passou") e o cabeçalho corrente discordam sobre o fato. Vale fixar qual é, porque a cláusula é a única coisa entre `v5` e a desproteção depois que o gate fechar.

**A-7 — "the independent full-contract identity" compartilha a constante com o primeiro pino externo.** A linha 288 (`sha256_text`) e a linha 273 (`sha256_file`) são independentes em mecanismo, mas usam a mesma `expected_contract_hash`. Recalcular uma constante derrota as duas. A palavra "independent" na `MUTATION_REJECTED` merece qualificação. Carregado das rodadas 1 e 2.

---

## Veredicto

**FAIL**

**S/T/A: 4/1/7**

O que foi verificado e está correto, sem ressalva: os cinco hashes batem; `beta_primitive`, `delay_cost_decision` e `protected_artifacts` são byte-idênticos à rodada 2, prova mecânica de que nada de primitivas, desconto, custo de atraso ou Seção 13 foi tocado; nenhuma asserção foi removida ou afrouxada, e o total subiu de 161 para 163 chamadas; as quatro contagens declaradas nas mensagens (nove, doze, doze, quatro) estão corretas; os três canários de T-1 são não-vacuosos no sentido que o script checa, e o caso degenerado de `formal_model_v5.Rmd` falha ruidosamente como projetado; T-2 foi entregue exatamente como a rodada 2 o forçou; o registro da decisão sobre S-2 é fiel e bem localizado; a `PASS` não contém mais nenhuma afirmação de que a extensão de agenda esteja integralmente não autorizada, e seis das sete cláusulas novas são verdadeiras contra o texto do contrato; o guarda executa em 3,5 s e imprime `PASS`.

O FAIL repousa em quatro pontos, três deles novos e um estrutural:

1. **S-1.** A remissão instalada por S-1 defere, quanto a `RIO submission files/` e aos artefatos congelados de N1–N7, a uma Seção 13 que nunca os menciona — ela protege a cadeia `pivotal-response`, conjunto disjunto. O ataque a esses dois objetos custa **zero**. E a mensagem `PASS` afirma ao operador uma base normativa — "unauthorized under Section 13" — que é falsa para dois dos três objetos que enumera.
2. **S-2.** Os três canários acrescentados por T-1 verificam apenas que a âncora ocorre em algum lugar do cabeçalho, propriedade já implicada pelo pino que os precede. Uma linha-isca no cabeçalho, gratuita em constantes, permite apagar a cláusula de proteção inteira com os três canários passando em silêncio.
3. **S-3.** A única autorização viva da arquitetura é a única sem registro pinado, e seu alcance é definido por remissão a um plano não pinado cujas entregas de Goal 0 — trembling com Lebesgue normalizada, Bayes para átomos e densidades, topologia do limite, e um `verifier` — colidem com o limite que o cabeçalho declara ("nem qualquer artefato matemático"; "scripts" não autorizados).
4. **S-4.** Uma das duas asserções que o registro descreve como "vivas" é inalcançável em seu ramo de falha; sua mensagem foi editada nesta rodada e nunca poderá ser exibida.

Quanto à pergunta direta do item 5: **sim, a remissão barateou o ataque, e mais do que a comparação com o Ataque 4 da rodada 2 sugeria.** Para `formal_model_v5.Rmd`, o custo caiu de 3 constantes para 2, porque a força normativa independente do cabeçalho — exatamente o que exigia a terceira — foi o que o reparo removeu para curar o conflito de competência. Para `RIO submission files/` e para os artefatos congelados de N1, N2, N3, N4, N6 e N7, o custo caiu para **zero**, porque a remissão aponta para uma lista que nunca os continha. Nenhum dano ocorreu: os objetos estão byte-idênticos e o worktree está limpo. O que mudou foi que o contrato, lido pelas suas próprias regras, deixou de dizer que eles estão protegidos.
