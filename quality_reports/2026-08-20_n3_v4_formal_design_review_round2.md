# Parecer independente `formal_design` — N3 v4, round 2

**Data:** 2026-08-20

**Papel:** `formal_design`, read-only

**Candidato:** `model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v4.json`

**SHA-256:** `8e8f29bee16f65d00b8f154a434b47b3e001741760b80db4b7ee88476e7e842d`

**Commit auditado:** `fda770dcba895b21724de2ebd574391011171be0`

**Veredicto:** **FAIL**

**Findings:** `critical=0 / major=1 / minor=0 / epistemic=0`

## Integridade e resultado substantivo

- Os sete artefatos N3 v4 coincidiram com os blobs de `fda770d` antes e depois do parecer.
- O avanço posterior do HEAD para `b4a3fab` continha exclusivamente N4; os bytes N3 permaneceram idênticos.
- N1 permaneceu congelado em `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` e a tag protegida permaneceu em `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- Gate0, N1, verifier N3 v4 e checker DAG passaram; warnings isolados de locale não foram findings.
- A matemática, o schema, as onze células, fronteiras, endpoints, tie-break, factibilidade, crenças, multiplicidade, misturas, payoffs e outcomes permaneceram corretos e semanticamente idênticos a v3 após normalização apenas do namespace de versão.
- O revisor confirmou duas chamadas subprocessuais reais do builder, auditou 1.109 folhas do candidato, 305 do ledger e 17 claims e executou 200.000 draws.
- O revisor não criou nem editou arquivo ou PDF.

## Finding N3V4-FD-R2-01 — major técnico: oracle copia integralmente o builder

As linhas 44–531 de `scripts/build_essential_input_n3_v4.R` e as linhas 28–515 de `scripts/oracle_essential_input_n3_v4.R` contêm 488 linhas idênticas depois de normalizar apenas o nome da função. Prova reproduzível:

```r
b <- readLines("scripts/build_essential_input_n3_v4.R")[44:531]
o <- readLines("scripts/oracle_essential_input_n3_v4.R")[28:515]
b[1] <- sub("make_n3_v4_objects", "RECONSTRUCT", b[1], fixed = TRUE)
o[1] <- sub("oracle_reconstruct_n3_v4_objects", "RECONSTRUCT", o[1], fixed = TRUE)
stopifnot(length(b) == 488L, identical(b, o))
```

Assim, candidato, objeto esperado estrutural e referência do oracle são três cópias concordantes, não uma derivação independente.

Quando a mesma corrupção foi aplicada em memória às três cópias, a comparação estrutural e o oracle deram falso PASS. O resultado ocorreu nas dez classes já identificadas, em 958 das 1.109 folhas do candidato, nas 305 folhas do ledger e, após atualizar coordenadamente o digest, em contradições nas 17 seções de claims.

A suíte oficial rejeitava corrupções porque mantinha fixa a terceira cópia. Ela certificava divergência contra a cópia, não independência de construção.

## Disposição e reparo já autorizado

O finding é técnico, sem nova escolha substantiva. N3 v4 permanece `pending/unfrozen`. O reparo deve:

1. substituir o bloco copiado por vínculos derivados independentemente das primitivas, sem reutilizar serialização, textos ou fórmulas do builder;
2. ligar cada folha semântica, inclusive ledger e claims;
3. rejeitar corrupções conjuntas de candidato, expected estrutural e qualquer referência builder-equivalent;
4. preservar as duas construções subprocessuais já corrigidas.

Qualquer novo hash retorna aos dois papéis read-only. Este parecer não autoriza freeze, N6, N7 ou lifecycle.
