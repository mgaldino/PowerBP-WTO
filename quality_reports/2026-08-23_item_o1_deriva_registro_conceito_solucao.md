# Item O-1 — Deriva pós-pino no registro normativo do conceito de solução

**Data de abertura:** 2026-08-23
**Origem:** finding O-1 do parecer `formal_design` da rodada 1
(`quality_reports/2026-08-23_parecer_formal_design_emenda_cabecalho_gate0.md`),
confirmado de forma independente.
**Status:** `ABERTO` — diagnóstico feito, reparo **não autorizado**.
**Autorização vigente:** o autor autorizou abrir este item como investigação
separada, com autorização e revisores próprios. Nenhuma autorização foi dada
para restaurar arquivos, atualizar pinos ou alterar artefatos congelados.

---

## 1. O problema

`quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` é o
registro normativo do pacote de conceito de solução de 2026-08-21, assim
designado pelo `CLAUDE.md`. Seus bytes divergiram do valor pinado:

- **pinado:** `94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69`
- **atual:** `9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f`

A divergência está **commitada**; o `git status` do arquivo é limpo.

## 2. Consequência verificada

Cinco verificadores numéricos abortam com `Frozen formula source hash mismatch`:

```text
scripts/verify_essential_input_numeric_boundaries.R
scripts/verify_essential_input_n1_numeric.R
scripts/verify_essential_input_n2_numeric.R
scripts/verify_essential_input_n3_numeric.R
scripts/verify_essential_input_n4_numeric.R
```

Enquanto isso não for resolvido, `N1`–`N4` não têm camada de verificação
numérica viva. As interfaces congeladas e seus pareceres não são afetados: o
problema é do instrumento de verificação numérica, não dos resultados.

## 3. Diagnóstico: deriva pós-pino em três etapas, a terceira restauradora

Rastreamento dos bytes commit a commit:

| commit | SHA-256 (12) | leitura |
|---|---|---|
| `a6fd6bd` | `89f5700defd9` | importação inicial do registro |
| `8529e9c` | `89f5700defd9` | inalterado |
| `7a0a89e` | `73ee20685cbd` | edição |
| `b3f70f0` | `bb342c0fc683` | edição |
| `ec47406` | `75c4b4839728` | edição |
| `1a12b74` | `94062c0803d9` | **bytes que foram pinados** |
| `e29a519` | `828fe09b81a6` | edição pós-pino |
| `dae5faa` | `f067e978726f` | edição pós-pino |
| **`fa803b2`** | **`9189299798a6`** | **merge; produziu os bytes correntes** |

O pino foi tirado em `1a12b74`. Houve **três** edições posteriores, não duas.
A terceira, `fa803b2` (*"Merge reviewed Goal 5 manuscript into primary
checkout"*), é um merge de três vias cujo segundo pai, `cd326eb`, ainda
carregava os **bytes pinados**. O merge tem conteúdo próprio.

### Auditoria de conteúdo das três edições

- **`e29a519` regrediu texto normativo.** Na errata de N2, trocou
  `"opção errata"` por `"opção A"` e substituiu a atribuição precisa — *"no
  claim `N2-CLM-012` e na parcela sobre a classe de crenças do claim
  `N2-CLM-013` do ledger"* — pela formulação vaga *"nos claims de
  multiplicidade do ledger"*. Acrescentou também o bloco de autorização de N6 e
  uma nota qualitativa sobre inexistência.
- **`dae5faa`** acrescentou o bloco "REGISTRO PENDENTE — P1/P2/P3".
- **`fa803b2` restaurou** a redação da errata a partir do lado pinado e
  preservou os dois blocos aditivos.

**Consequência.** O estado corrente **não** é uma deriva não revisada: é
`1a12b74` mais dois blocos aditivos de decisão autoral, com a regressão de
`e29a519` já desfeita. O `CLAUDE.md` reproduz como canônicas exatamente as
palavras restauradas — "opção errata", `N2-CLM-012`, `N2-CLM-013` —, o que
corrobora que os bytes correntes, e não os de `e29a519`, são os que o projeto
trata como vigentes.

**Errata deste documento.** A versão anterior afirmava duas edições, omitia
`fa803b2` e prescrevia auditar apenas `e29a519` e `dae5faa`. Seguir aquela
prescrição levaria a encontrar a regressão da errata e concluir pela restauração
de `1a12b74` — conclusão errada, porque o merge já a desfez. A correção foi
apontada pelo parecer `formal_design` da rodada 3 e verificada de forma
independente.

---

## 4. As saídas, com custo real

### Opção 1 — restaurar os bytes de `1a12b74`

Custo baixo em pinos: nenhum precisa mudar. Mas descarta os dois blocos
aditivos de decisão autoral que `dae5faa` e o merge preservaram, e que
precisariam ser reintroduzidos por outra via.

### Opção 2 — recomputar os pinos para `91892997…`

**Custo real, medido:** o pino morto ocorre **24 vezes em 16 arquivos**
(excluídos este documento e os pareceres desta cadeia; contando o parecer da
rodada 1, 25 em 17). Desses 16:

- **três são artefatos congelados** — `model_redesign/essential_input_game_dag.json`,
  `essential_input_solution_concept/n4_r1_unanimity_candidate.json` e
  `essential_input_solution_concept/n4_r1_unanimity_rederivation_candidate.md`;
- **dez são pareceres e manifestos congelados** do ciclo N3/N4/N6/N7;
- três são outros (`scripts/essential_input_formulas.R`,
  `notes/2026-08-21_n5_motivating_example_n2.md`,
  `quality_reports/2026-08-21_rederivacao_n3_n4_…md`).

Mudar bytes de interface congelada aciona a **Seção 12, item 2** do contrato: o
produtor volta a `pending`/`unfrozen`, seus pareceres e hash tornam-se
obsoletos, e todos os descendentes transitivos voltam a `pending`. Pelo DAG e
por `N4`, a cascata alcança `N6` e `N7`.

**As duas opções não são comparáveis em custo.** A opção 2, como enunciada,
reabriria metade da cadeia.

### Opção 3 — repin parcial com errata

Recomputar apenas os pinos nos arquivos **não congelados** e tratar os
congelados por errata registrada, exatamente como já se fez para a errata de N2
em 2026-08-21: o artefato congelado permanece byte a byte como base histórica, e
a interface efetiva passa a ser esse artefato lido conjuntamente com a errata.
Evita a cascata da Seção 12 e preserva os blocos aditivos.

---

## 5. Fronteira

Este item não toca o contrato Gate 0, o verificador do Gate 0, o manuscrito nem
os artefatos congelados **enquanto nenhuma opção for autorizada**. Registro
explicitamente, corrigindo a versão anterior deste documento: a **opção 2 não
cabe dentro dessa fronteira** — ela exige editar o DAG, dois artefatos de `N4` e
dez pareceres e manifestos congelados. Escolher a opção 2 é, portanto, também
autorizar a cascata de invalidação correspondente.

A opção 3 foi acrescentada precisamente para oferecer uma saída que respeite a
fronteira.
