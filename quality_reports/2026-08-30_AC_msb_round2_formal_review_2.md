# Parecer formal independente 2 — `A_C` M/S/B, rodada 2

**Data:** 2026-08-30  
**Papel:** parecerista formal independente e adversarial, read-only  
**Commit revisado:** `7248c56cca098d86c0117a78f89c4555c0d934d3`  
**Manifesto:** `quality_reports/2026-08-30_AC_msb_round2_candidate_manifest.sha256`  
**Veredito:** `FAIL — Critical 0 / Major 0 / Minor 1`

## 1. Identidade, diff e reparo adjudicado

O manifesto teve SHA-256 externo
`fc9788a0a9cd02bb6e059c9f918f4fe5ad7ebdcdb79e210f036684d65602cbba`
e 7/7 entradas `OK`. A árvore estava limpa.

O commit de reparo mudou somente oito campos `source_record_ids`. O commit de
empacotamento adicionou manifesto/relatório e atualizou somente o hash do ledger
e a nota de lifecycle do DAG. Contrato, resultados, interface, verificador e
output de `A_C` são byte-idênticos à rodada 1.

Todos os novos IDs existem e são semanticamente pertinentes:

- fibra: `AMX-MSB-011;AUX-MSB-031`;
- tipo antes do prior: `AMX-016b;AUX-MSB-020`;
- datas/desconto: `AMX-016b;AUX-MSB-004` junto à tabela temporal do contrato;
- partição: células `AUX-MSB-010`–`014`, exaustão `015`, endpoints `021/022` e
  diagonal `031`;
- T4/none: `AMX-001` e a cobertura completa de `A_U`;
- T5: `AMX-010` e todas as famílias existentes/endpoints de `A_U`.

`AC-R1-MIN-1` foi integralmente reparado.

## 2. Mérito matemático e checks

T1–T5 permaneceram inalterados e foram rechecados. Não há nova hipótese,
seleção, recombinação, acoplamento cross-world ou `beta` adicional.

O verificador retornou `941 PASS / 0 FAIL`, com output byte-idêntico. O DAG
retornou `VALID`, repina o novo ledger e mantém `A_R` e todos os demais passos
downstream não autorizados.

## 3. Finding

### `AC-R2-MIN-1` — Minor — o snapshot central `current` ainda fixa a rodada 1

**Localização:**

- `model_redesign/agenda_extension_status_current.json`;
- `model_redesign/agenda_extension_STATUS.md`;
- `scripts/verify_agenda_extension_status_current.R`;
- `quality_reports/verification_outputs/2026-08-30_agenda_extension_status_current_verifier_output.txt`.

O registro central ainda aponta para:

```text
packaged commit = 886c440...
manifesto       = 6ba078ef...
DAG             = bd440d...
ledger          = f753140...
```

O candidato corrente é:

```text
packaged commit = 7248c56...
manifesto       = fc9788a...
DAG             = 830aede...
ledger          = 280f816...
```

O output versionado do checker central declara `82 PASS / 0 FAIL`, mas sua
reexecução no `HEAD` revisado produz:

```text
FAIL | A_C dependency DAG bytes match
FAIL | A_C candidate bytes match: model_redesign/agenda_extension_AC_msb_claim_ledger.tsv
SUMMARY | 80 PASS | 2 FAIL
```

Logo o output `current` está stale e não é reproduzível. O defeito é apenas
administrativo e conservador; não afeta T1–T5, a interface, os sete hashes do
manifesto ou o fechamento de `AC-R1-MIN-1`.

**Reparo mínimo:** repinar o snapshot central para o commit `7248c56`, o
manifesto `fc9788a`, o DAG `830aede` e o ledger `280f816`; atualizar a descrição
humana, o script e seu output. Nenhum blob matemático pode mudar.

## 4. Veredito

O candidato matemático e o reparo de rastreabilidade passam. O snapshot global,
porém, contém um registro chamado `current` que falha em reproduzir o estado
presente.

FINAL_STATUS: FAIL  
COUNTS: Critical 0 / Major 0 / Minor 1
