# Parecer independente — `formal_design`, rodada 3
## Emenda de status do cabeçalho do contrato Gate 0 + item O-1

**Papel:** revisor independente, `formal_design`. **Regime:** read-only estrito. Nenhum `Edit`, `Write` ou `NotebookEdit` foi chamado. Nenhum arquivo do repositório foi criado, alterado ou apagado. Os dois scripts auxiliares que escrevi ficaram no scratchpad da sessão, fora do repositório.

---

## 1. Objeto e hashes

**Repositório:** `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion`
**Branch:** `codex/essential-input`
**`HEAD` verificado ao vivo:** `ee0c8d572ab6a002111ed7668f876c856ac70178` — *"Align Gate 0 contract header with recorded authorial decisions"*. O briefing não fixou `HEAD`; confirmei-o eu mesmo, como instruído.
**Worktree:** limpa. `git status --porcelain --untracked-files=all` devolve vazio. Diferentemente das rodadas 1 e 2, não há arquivo modificado nem não rastreado; o trabalho está integralmente commitado.

Os quatro objetos conferem byte a byte:

| Arquivo | SHA-256 esperado | Observado | |
|---|---|---|---|
| `quality_reports/plans/2026-08-12_essential_input_gate0.md` | `20c331df…dede1d0d` | `20c331dff3d67a759bf3408f9037a841594e9b3e4721d6a83c31f452dede1d0d` | OK |
| `scripts/verify_essential_input_gate0.R` | `a9f931fb…6020f12` | `a9f931fb8bcd71f5ae72ac42f9756f3c5c980ce4bb15c63e8b85c881b6020f12` | OK |
| `quality_reports/2026-08-23_inconsistencia_cabecalho_contrato_gate0.md` | `7e739d67…f283216e2` | `7e739d67855467cd75ec760fe11666c5773e8d617769ed8f6bcecbaf283216e2` | OK |
| `quality_reports/2026-08-23_item_o1_deriva_registro_conceito_solucao.md` | `3a401a4e…3e1043b8` | `3a401a4ec71e994ba58fca3f322700926b47774bf6ebf7c32eab232e4e1043b8` | OK |

Nenhuma divergência. Prossegui.

**Material de contexto lido integralmente:** os quatro pareceres das rodadas 1 e 2, o contrato inteiro, o verificador inteiro, `quality_reports/plans/2026-08-23_agenda_extension_gated_plan_v3.md` e `quality_reports/plans/2026-08-23_prompt_goal0_agenda_extension_opus.md`.

---

## 2. Metodologia

Todas as verificações são mecânicas e reproduzíveis. Comandos efetivamente executados:

```bash
git rev-parse HEAD; git status --porcelain --untracked-files=all
shasum -a 256 <os quatro objetos>
git show HEAD                                    # diff integral da emenda
git diff --name-only a315f59 ee0c8d5             # janela completa das três rodadas
git diff --name-only a315f59 ee0c8d5 -- \
  model_redesign/essential_input_interfaces \
  model_redesign/essential_input_game_dag.json \
  model_redesign/essential_input_solution_concept \
  formal_model_v5.Rmd "RIO submission files/" \
  quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md
awk '/^## 13\./,/^## 14\./' <contrato anterior e atual> | shasum -a 256
Rscript --vanilla scripts/verify_essential_input_gate0.R
Rscript --vanilla scripts/verify_essential_input_{n1,n2,n3,n4}_numeric.R
Rscript --vanilla scripts/verify_essential_input_numeric_boundaries.R
```

Mais dois scripts próprios no scratchpad:

- `confinement_check.R` — reconstrói o contrato de `HEAD` a partir do contrato anterior trocando **apenas** a região `authorization_header`, usando os mesmos delimitadores que `extract_normative_contract_regions()` usa, e compara os bytes.
- `o1_check.sh` — reconstrói a história completa do registro pinado commit a commit, confere cada linha da tabela do documento O-1, conta os pinos e roda os cinco verificadores numéricos.

**Não** aceitei nenhuma afirmação do roteiro, da mensagem de commit ou dos pareceres anteriores como evidência. Tudo que afirmo abaixo foi medido nesta sessão.

---

## 3. Achados por item do briefing

### Item 1 — S-1 está sanado?

**Parcialmente. A metade do defeito que a rodada 2 chamou de "legislar" foi reparada. A metade que ela chamou de "ampliar" não foi — foi reformulada de modo a ficar menos visível. Ver S-1 e S-2.**

**O que a rodada 2 diagnosticou.** Os dois pareceres convergiram de ângulos independentes. O `game_theory` (S-1) apontou que o parágrafo se autodeclarava "a fonte canônica" e deslocava a Seção 13 em vez de remeter a ela. O `formal_design` mediu a lista da Seção 13 e concluiu: *"Nem `RIO submission files/` nem os artefatos de `N1`–`N7` aparecem, confirmado por `grep`. O bloco novo, portanto, não reassere: **amplia** a regra de artefatos protegidos com dois conjuntos que sua fonte canônica nunca conteve."*

São **dois** defeitos, não um: (i) forma — legislar de fora; (ii) conteúdo — ampliar a lista.

**O texto atual**, agora como último item do bloco `**Não autorizado.**`:

> […] e a edição de `formal_model_v5.Rmd`, da pasta `RIO submission files/` e dos artefatos congelados de `N1`, `N2`, `N3`, `N4`, `N6` e `N7`, **que permanecem protegidos nos termos da Seção 13, cuja limitação temporal ao gate do Goal 5 fica sem efeito por decisão autoral desta data.**

**O que melhorou, e é real.** A expressão "Artefatos protegidos" — o termo que a tabela de fonte única atribui à Seção 13 — desapareceu como título de bloco. A autodeclaração "na fonte canônica" desapareceu. O ato normativo passou a ser *"Não autorizado: … a edição de X, Y, Z"*, que é uma afirmação de **autorização**, e a tabela atribui "status e autorização da fase" ao próprio cabeçalho. Esse é exatamente o reparo que o `formal_design` da rodada 2 recomendou em primeiro lugar, e ele foi executado.

**O que não foi reparado.** A oração final. Medi a Seção 13 (byte-idêntica, região pinada):

> São protegidos:
> - `quality_reports/2026-08-12_essential_input_gate0_decisions.md` […]
> - `formal_model_v5.Rmd` e `formal_model_v6.Rmd`, até o gate do Goal 5;
> - todos os artefatos da cadeia `pivotal-response` […]

Três entradas. `grep` sobre o intervalo `## 13.`→`## 14.` não encontra `RIO`, nem `N1`, nem "artefatos congelados". Dos três conjuntos que o cabeçalho nomeia, **apenas `formal_model_v5.Rmd` está na Seção 13**. Os artefatos congelados de `N1`–`N7` não: o terceiro *bullet* protege a cadeia **`pivotal-response`**, que é outra cadeia — a que o próprio contrato declara proveniência fechada.

Portanto a oração "permanecem protegidos nos termos da Seção 13" é **falsa para dois dos três conjuntos**. A ampliação continua lá; o que mudou é que antes o texto ampliava assumidamente e agora amplia atribuindo à Seção 13 um conteúdo que ela não tem. Em termos de auditabilidade isso é pior, não melhor: um leitor que confie na remissão não vai à Seção 13 conferir.

**Ela cria exceção?** Sim — a segunda metade: *"cuja limitação temporal ao gate do Goal 5 fica sem efeito por decisão autoral desta data."* A Regra de fonte normativa única: *"não podem qualificá-lo, ampliá-lo nem criar exceções"*. Tratado em S-2.

**Comparação com a cláusula vizinha sobre `beta`**, que o briefing manda usar como padrão: ela **repete** a regra da Seção 12 e aponta para lá, sem alterá-la. A cláusula de proteção agora aponta **e** emenda. Antes o cabeçalho **deslocava** a Seção 13; agora ele **remete e emenda**.

**Um agente futuro chega à conclusão correta sobre `formal_model_v5.Rmd`?** Depende de como formula a pergunta:

- *"Estou autorizado a editar `formal_model_v5.Rmd`?"* → tabela manda ao **cabeçalho** → "Não autorizado". **Correto.**
- *"`formal_model_v5.Rmd` é artefato protegido?"* → tabela manda à **Seção 13** → "até o gate do Goal 5", que passou. **Errado.**

O reparo melhorou o caso, mas o diagnóstico da rodada 2 permanece verdadeiro, apenas com probabilidade menor de ser exercido.

### Item 2 — Seção 13 e tabela byte-idênticas? Pino inalterado?

**Sim para as três coisas, mecanicamente provado.**

- **Seção 13:** hash do intervalo `## 13.`→`## 14.` é `6be64f632298652bfe76175c73c763a994e43c1a39bc43e8f2374724dce8f854` nas duas versões. Idêntica.
- **Tabela de fonte única:** identidade linha a linha e identidade do sufixo inteiro (1 246 linhas, `identical() == TRUE`).
- **Pino:** `protected_artifacts` continua `0f3b64ac…b504f8e8`; apenas `expected_contract_hash` e `authorization_header` foram repontados.

### Item 3 — Confinamento, provado por identidade de bytes

```
prefix identical: TRUE
suffix identical: TRUE          (1246 linhas)
byte-identical reconstruction:  TRUE
current file sha256:      20c331df…dede1d0d
reconstructed sha256:     20c331df…dede1d0d
single-source table identical: TRUE
```

A reconstrução devolve exatamente o SHA-256 do objeto declarado. Varredura da janela inteira (`a315f59..ee0c8d5`): doze arquivos, nenhum sob `model_redesign/`; sob `scripts/`, apenas `verify_essential_input_gate0.R`.

### Item 4 — Goal 0

**A direção está certa e o núcleo é apertado. Duas frações não estão: a colocação da ressalva (T-1) e o termo "contrato executável" (S-3).**

**Ele autoriza mais do que redigir o contrato?** Não. Aprovação: excluída. Goals seguintes: excluídos. Derivações, comparação, migração: excluídas duas vezes. Confrontei com o prompt de Goal 0, ainda mais restritivo, e não há conflito nessa direção.

**A ressalva é inequívoca?** Não. *"a aprovação do Gate 0 … e tudo o que **a** suceda nessa cadeia … ressalvado o Goal 0"* — o pronome retoma "a aprovação"; o conjunto ressalvado é o do que **sucede** a aprovação. O Goal 0 é a redação e **precede** a aprovação. A ressalva é inerte na melhor leitura e invertida na pior. Ver T-1.

### Item 5 — T-1 (notação)

**Sanado, sem resíduo.** `grep` por `N1 a N7`, `N1--N7`, `N1-N7`, `N1–N7` na região pinada: zero. As duas enumerações são explícitas e concordantes, `N5` ausente das duas.

### Item 6 — Artefatos congelados e O-1

**Todos intactos. O-1 respeitado à letra.** `git diff --name-only a315f59 ee0c8d5` restrito aos artefatos, DAG, `v5`, RIO e o arquivo do O-1 devolve **vazio**.

**Ressalva.** `formal_model_v6.Rmd` **mudou** nesta janela: `45c6bcbc…` → `b899f906…`, em `a490a7a`. Não é ação sobre artefato protegido e não integra o objeto declarado, mas interage com S-2.

### Item 7 — O documento do item O-1

**O núcleo está certo e eu o reproduzi integralmente.** Os dois hashes conferem; os cinco verificadores abortam com a mensagem exata; as oito linhas da tabela conferem uma a uma; o *subject* de `1a12b74` confere; "17 locais" confere como 17 arquivos distintos (25 ocorrências).

**A conclusão de "deriva pós-pino" se sustenta? Sim, sem reservas.**

**Onde falha:** ver S-4 e S-5.

### Item 8 — Roteiro

**A Revisão 5 registra a rodada 2 com fidelidade aritmética e factual.** Conferi os `S/T/A` nos originais: 3/1/5 e 2/2/7, exatos, inclusive as contagens de blocos `**A-`. Os quatro findings listados como fechados aparecem exatamente assim nos veredictos. Nenhum finding foi rebaixado ou silenciado.

**Correção do item 1 da Revisão 4: feita.** Fecha o A-7 do `game_theory` e o parágrafo "A exceção" do `formal_design`.

**Retro-ajuste? Não.** O movimento foi o inverso — o registro foi puxado para a realidade.

**Superavaliação.** O item 1 conclui *"Deixa de legislar e vira aviso"*, citando imediatamente antes o texto que anula a limitação temporal. Anular condição de outra seção é legislar. Ver A-3.

### Item 9 — Seção 12

**Nenhum gatilho dispara.** Os quatro itens verificados um a um, com identidade de bytes por trás. Asserções: 156 → 163; a bateria foi repontada e cresceu de 9 para 12 mutações. **Nenhuma cobertura retirada.**

---

## 4. Findings

### SUBSTANTIVE

**S-1 — A remissão à Seção 13 é falsa para dois dos três conjuntos que nomeia; a ampliação diagnosticada na rodada 2 não foi reparada, apenas tornada menos visível.**

`RIO submission files/` não aparece na Seção 13. Os artefatos congelados da cadeia essential-input também não — o terceiro *bullet* cobre a cadeia `pivotal-response`, que é a cadeia substituída, declarada proveniência fechada, e cujo material a Seção 10 proíbe transportar.

Para dois dos três conjuntos não existem "termos da Seção 13" sob os quais permanecer protegido. O reparo trocou uma ampliação declarada por uma ampliação atribuída, e a atribuída é pior de auditar.

Efeito prático hoje: **nulo** — o ato operativo é a não-autorização, que é competência do cabeçalho, e os três conjuntos estão intocados.

*Reparos admissíveis:* (a) suprimir a oração final, deixando não-autorização pura; (b) emendar a Seção 13 acrescentando os dois conjuntos e removendo o limite, ao custo de recomputar `protected_artifacts` e `expected_contract_hash`; (c) emendar a tabela. A opção (a) é a única que não toca região pinada além da que já mudou.

**S-2 — A cláusula anula, do cabeçalho, uma condição escrita na Seção 13, e o efeito colateral recai sobre `formal_model_v6.Rmd`, que foi editado dentro desta janela.**

A Seção 13 tem exatamente uma limitação temporal, e ela governa **`v5` e `v6` no mesmo *bullet***:

> - `formal_model_v5.Rmd` e `formal_model_v6.Rmd`, até o gate do Goal 5;

Duas leituras:

1. "cuja" retoma "a Seção 13" — leitura gramaticalmente natural. A limitação cai, e **`formal_model_v6.Rmd` passa a estar protegido sem prazo**. O contrato proíbe editá-lo.
2. "cuja" é lida distributivamente sobre os itens nomeados. `v6` não é nomeado, mantém os termos originais, e sua proteção terminou no gate do Goal 5.

`formal_model_v6.Rmd` mudou nesta janela. Sob a leitura 1 o contrato agora proíbe o que o autor está fazendo e o que o Goal 5 ainda exige. O bloco `**Não autorizado.**` não nomeia `v6`, então não desempata.

A rodada 2 levantou o silêncio sobre `v6` como ADVISORY, e a classificação era adequada **naquele texto**, que corria em paralelo à Seção 13 e portanto não a tocava. Ao passar a agir **sobre** a cláusula compartilhada, esta rodada converteu um silêncio advisory numa ambiguidade operativa sobre arquivo em edição ativa.

**S-3 — O alcance do GO do Goal 0 depende de um termo que o plano v3 define incluindo um verifier.**

Cabeçalho: *"limitado à redação do **contrato executável** do respectivo Gate 0"*. Plano v3, §7: *"Goal 0 — **contrato executável** da extensão"*, com entregas incluindo *"… schema, DAG, ledger vazio, **verifier** e invalidação"*.

O cabeçalho adota o termo do plano, e o plano o define incluindo um verifier. E o mesmo bloco `**Não autorizado.**` lista "scripts" entre o que não está liberado. Um agente frio pode concluir, com texto na mão, que escrever `scripts/verify_agenda_extension_gate0.R` está dentro do GO.

A resolução existe mas está fora da fonte canônica: o prompt de Goal 0 diz *"não escreve scripts R"*, *"Scripts R são Goal 1"*, *"NÃO escrever os scripts"*. O cabeçalho não cita esse arquivo.

**S-4 — O documento do item O-1 omite o commit que produziu os bytes correntes, conta duas edições onde houve três, e direciona a auditoria decisiva a dois commits que não produziram o estado atual.**

| commit | sha256(12) | |
|---|---|---|
| `1a12b74` | `94062c0803d9` | ← bytes pinados |
| `e29a519` | `828fe09b81a6` | edição pós-pino |
| `dae5faa` | `f067e978726f` | edição pós-pino |
| **`fa803b2`** | **`9189299798a6`** | ← **produziu os bytes correntes; ausente da tabela** |

`fa803b2` é *"Merge reviewed Goal 5 manuscript into primary checkout"*, com pais `dae5faa` e `cd326eb`. Medi o arquivo em `cd326eb`: **`94062c0803d9`** — o segundo pai ainda carregava os **bytes pinados**. O merge é resolução de três vias com conteúdo próprio.

Auditei o conteúdo:
- `e29a519` **regrediu** o texto da errata de N2: `"opção errata"` → `"opção A"`, e a atribuição precisa a `N2-CLM-012`/`N2-CLM-013` → a vaga "nos claims de multiplicidade do ledger".
- `dae5faa` acrescentou o bloco "REGISTRO PENDENTE … P1/P2/P3".
- `fa803b2` **restaurou** a redação da errata a partir do lado pinado e preservou os dois blocos novos.

Um auditor que examine só `e29a519` e `dae5faa` encontra uma regressão em texto normativo e concluiria pela opção 1 ("restaurar `1a12b74`"), quando o merge já desfez aquilo e o estado corrente é **os bytes pinados mais dois blocos aditivos**. O procedimento que o documento define aponta para o ramo errado da sua própria decisão.

**S-5 — A fronteira da Seção 5 do O-1 é incompatível com a opção 2 da sua Seção 4, e a opção 2 dispararia a Seção 12 item 2.**

Enumerei os 17 arquivos. Três são **artefatos congelados**: `essential_input_game_dag.json`, `n4_r1_unanimity_candidate.json`, `n4_r1_unanimity_rederivation_candidate.md`. Outros onze são **pareceres e manifestos congelados**. Ou seja, a opção 2 não pode ser executada dentro da fronteira declarada, e mudar bytes de interface congelada aciona a Seção 12 item 2: cascata que alcança `N6` e `N7`.

O autor está sendo convidado a escolher entre duas opções apresentadas como comparáveis, quando uma custa a reabertura de metade da cadeia. Essa assimetria não está no documento e é provavelmente o argumento decisivo.

### TECHNICAL

**T-1 — "ressalvado o Goal 0 tratado abaixo" está preso a um conjunto do qual o Goal 0 não é membro.** Reparo único forçado: suprimir a ressalva. O bloco "Goal 0 da extensão de agenda" já enuncia o escopo de forma exaustiva, e um bloco de não-autorizações não é lugar de conceder autorização.

### ADVISORY

**A-1 — Os bytes correntes de `formal_model_v6.Rmd` contêm defeitos de rascunho.** Citação `@kalandrakis2006proposal` removida sem substituto, marcadores `[inserir citação]`, prosa em português no corpo em inglês, frase órfã. É rascunho autoral em curso e não é objeto deste parecer; registro para que ninguém leia `b899f906…` como candidato pronto.

**A-2 — A mensagem de `ee0c8d5` afirma cobertura de revisão que os bytes não têm.** *"Two independent read-only review rounds ran on these bytes"* — a rodada 1 correu sobre `a315f59`, a rodada 2 sobre o que virou `a490a7a`. Os bytes de `ee0c8d5` têm **zero** revisões concluídas. O roteiro diz o certo. Como emendar mensagem reescreve história, o reparo é registrar a correção no roteiro.

**A-3 — O roteiro afirma que a cláusula "deixa de legislar e vira aviso".** A mesma frase cita o texto que anula a limitação da Seção 13. Decorre de S-1/S-2.

**A-4 — A reescrita do item 1 da Revisão 4 descartou duas informações verdadeiras**: "dentro da região pinada" e "com teste de regressão que falha se ela for removida".

**A-5 — "17 locais"**: 17 arquivos, 25 ocorrências, 14 deles material congelado.

**A-6 — A região pinada continua citando um caminho não pinado.**

**A-7 — "Goal 0" está sobrecarregado**, e `CLAUDE.md`/`AGENTS.md` carregam a acepção velha como corrente.

---

## 5. O que está correto, e é a maior parte do trabalho

O ato corretivo é **monotonicamente mais forte** que o da rodada 2 em todas as camadas medidas, e não deve ser revertido: confinamento provado por bytes; Seção 13 pinada e não editada; a forma do S-1 reparada; o S-2 da rodada 2 fechado do jeito que o autor mandou; T-1 e T-2 da rodada 2 fechados; notação corrigida; o GO registrado com núcleo apertado; nenhuma cobertura retirada (156 → 163 asserções, bateria de 9 → 12); O-1 respeitado à letra; núcleo do diagnóstico do O-1 sólido; roteiro fiel; nenhum gatilho da Seção 12.

## 6. Por que ainda assim não é PASS

Restam cinco findings substantivos. S-1 e S-2 são o **mesmo** defeito de competência que a rodada 2 escalou, atravessando a rodada 3 atenuado, e S-2 adquiriu no caminho a ambiguidade sobre `formal_model_v6.Rmd`, arquivo que mudou nesta janela. S-3 é fronteira de autorização cuja única resolução inequívoca está fora da fonte canônica. S-4 e S-5 são, juntos, o item O-1 inteiro.

**Nota de método.** A oração final do bloco `**Não autorizado.**` é a origem de S-1 e S-2 ao mesmo tempo. Suprimi-la fecha os dois de uma vez, deixa o cabeçalho dizendo apenas o que lhe compete, devolve `formal_model_v6.Rmd` ao regime da Seção 13 sem ambiguidade, e não toca nem a Seção 13 nem a tabela. É a única das opções examinadas que não abre segunda frente.

**Nada em nenhum destes findings toca primitivas, jogo, estimando, conceito de solução, desconto, schemas, obrigações de prova ou o protocolo de revisão da Seção 11.**

---

## Veredicto

**FAIL**

**S/T/A: 5/1/7**

**Recomendação.** Não reverter. Decidir S-1 e S-2 em conjunto, já que a mesma oração os produz; fechar S-3 nomeando explicitamente se escrever o verifier está dentro ou fora; corrigir a tabela e a Seção 4 do documento O-1 e escrever o custo real da opção 2 antes de o autor escolher; aplicar T-1 na mesma passada; registrar no roteiro as correções de A-2 e A-3.
