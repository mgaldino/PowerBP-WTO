# Preflight mecânico da revisão formal

Data: 2026-09-08. Revisor: `/root/cold_terminal_review`. Escopo exclusivo: integridade do candidato e reprodução do script autorizado, antes de iniciar a crítica substantiva e antes de receber o contrato macro PASS.

**Resultado: 18 de 18 artefatos coincidem com o manifesto antes e depois da reprodução; 29.005 verificações PASS e zero FAIL; os cinco arquivos de saída reproduzidos são byte a byte idênticos aos do candidato.**

- Fonte Rmd: SHA-256 `493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3`.
- PDF: SHA-256 `e5b7b258d64a85b4573f537315276a127f09e142383c65953e182a206c968ae0`.
- Manifesto: SHA-256 `29d5eef6196933898512a22631237a79d2bf76b5386b2e70e1135cf9de34124d`.
- Diretório de execução independente: `/private/tmp/pbp_formal_preflight_20260908_5my048cu`.
- Nenhum arquivo enumerado no manifesto foi escrito ou alterado pelo revisor. Este relatório não integra o manifesto.

## Comandos e procedimento executados

1. Ler `candidate_manifest.json`, exigir exatamente 18 entradas e calcular SHA-256 de cada arquivo com `hashlib.sha256(path.read_bytes()).hexdigest()`. Comparar cada valor com o hash esperado antes da execução.
2. Criar um diretório próprio por `tempfile.mkdtemp(prefix="pbp_formal_preflight_20260908_", dir="/private/tmp")`. A inspeção mecânica do script confirmou saídas relativas a `getwd()` e não identificou gravação em caminhos absolutos do candidato.
3. Executar o comando abaixo com o diretório de trabalho temporário explicitado. O caminho do script é absoluto; seus outputs foram gravados sob a réplica relativa `quality_reports/architecture_2026-09-08/checks/` dentro do diretório temporário.

```text
cwd: /private/tmp/pbp_formal_preflight_20260908_5my048cu
/usr/local/bin/Rscript /Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/scripts/verify_architecture_20260908.R
exit_code: 0
wall_time_seconds: 5.887587792
```

4. Recalcular todos os 18 hashes e o hash do próprio manifesto. O record posterior coincidiu integralmente com o anterior.
5. Comparar os bytes e SHA-256 de `summary.csv`, `finite_checks.csv`, `counterexamples.csv`, `worked_example.csv` e `sessionInfo.txt`. Conferir separadamente 29.005 linhas de testes, 29.005 IDs distintos e `pass=TRUE` em todas as linhas de `finite_checks.csv`.

## Saída da execução

```text
During startup - Warning messages:
1: Setting LC_CTYPE failed, using "C" 
2: Setting LC_COLLATE failed, using "C" 
3: Setting LC_TIME failed, using "C" 
4: Setting LC_MESSAGES failed, using "C" 
5: Setting LC_MONETARY failed, using "C" 
           category passed total failed
    counterexamples      4     4      0
     implementation     84    84      0
    majority_ballot  20160 20160      0
 proposal_dominance   6840  6840      0
 terminal_unanimity    315   315      0
 unanimity_identity   1600  1600      0
     worked_example      2     2      0
TOTAL: 29005 PASS | 0 FAIL
```

Os avisos de locale foram emitidos na inicialização de R; o processo terminou com código zero. A igualdade inclusive de `sessionInfo.txt` confirma que a reprodução registrada coincidiu com a sessão do candidato. Não foi necessário modificar o ambiente ou repetir a execução.

## Comparação das categorias

| Categoria | PASS | Total | FAIL |
| --- | ---: | ---: | ---: |
| counterexamples | 4 | 4 | 0 |
| implementation | 84 | 84 | 0 |
| majority_ballot | 20160 | 20160 | 0 |
| proposal_dominance | 6840 | 6840 | 0 |
| terminal_unanimity | 315 | 315 | 0 |
| unanimity_identity | 1600 | 1600 | 0 |
| worked_example | 2 | 2 | 0 |
| **Total** | **29005** | **29005** | **0** |

## Artefatos do manifesto

Todos os hashes abaixo foram verificados antes e depois da execução. O manifesto permaneceu inalterado.

| Artefato | SHA-256 esperado e observado | Estado antes/depois |
| --- | --- | --- |
| `quality_reports/architecture_2026-09-08/architecture_note.Rmd` | `493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/architecture_note.pdf` | `e5b7b258d64a85b4573f537315276a127f09e142383c65953e182a206c968ae0` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/checks/counterexamples.csv` | `2831289f893f43938b26a2ca1f1530439a3d063b56be4cba1870238accf5c2b9` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/checks/finite_checks.csv` | `888a09728798243da80b146e468f10d370229b107350de02ce440023a6b96070` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/checks/sessionInfo.txt` | `c0d2eea1d4bbe22eea22116507c2abffaef60b23ac7be5a3477527b3a6cb98ec` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/checks/summary.csv` | `ffec29b1aa773ba932bd41f131bc6525ecd0f45028f9d7a73b2ecc93114b963a` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/checks/worked_example.csv` | `7a1b7ddd0665d6d78b621734523bed829cad7837b5a6a2be6e47557ae0c66358` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/game_dag.json` | `6cee95e1b342059437c9b951e7d39fdb8faf3ebb827f48c1a0d77bc9cefe2e23` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/interfaces/R1_M.md` | `be318d2dfdda884c6a4b7576234fa91c3f53ad9a0e0c82a1f05bd118e1071908` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/interfaces/R1_U.md` | `ecc7878c20543c036681cf4cfb480908795872f81a06cbc46b8bb2a35a1e2ea4` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/interfaces/R2_M.md` | `a7e757a39cfc161f0e5cc96b1fa1616176be90a586cdc40c66b49438f3a236b0` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/interfaces/R2_U.md` | `c31391611b0b63e53b54d62209b8719bd0a89d98793ab659bd437d38aeaa8768` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/interfaces/conditional_contract.json` | `a60970889a92642a215e45497da6ac6ba85ddff69a207e1ad74607516fb83ae5` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/interfaces/economic_transport.md` | `163fcee078361af351579cf8df56abe406e6678fa9a0f4279ef87ca5daf14da5` | coincide / coincide |
| `quality_reports/architecture_2026-09-08/interfaces/implementation.md` | `02d11cf68f3addc7733f49f649e99677a36123ca9acb41f82923d8ed8dcc8723` | coincide / coincide |
| `scripts/render_architecture_20260908.R` | `8c979753a144c2a84ed43eea90b238a050abad896e059f25ba0c7c6447cbce89` | coincide / coincide |
| `scripts/validate_architecture_20260908.py` | `59d258eadab770ec3978bf2d2153122faffe7f76eb942c25239cede0f792da0e` | coincide / coincide |
| `scripts/verify_architecture_20260908.R` | `775ef3fd9ed0bf91142a37502a719ba2988fc23b1b95946bcd88939b0b16c3ab` | coincide / coincide |

## Outputs reproduzidos

| Arquivo | SHA-256 de ambos os arquivos | Comparação de bytes |
| --- | --- | --- |
| `summary.csv` | `ffec29b1aa773ba932bd41f131bc6525ecd0f45028f9d7a73b2ecc93114b963a` | idênticos |
| `finite_checks.csv` | `888a09728798243da80b146e468f10d370229b107350de02ce440023a6b96070` | idênticos |
| `counterexamples.csv` | `2831289f893f43938b26a2ca1f1530439a3d063b56be4cba1870238accf5c2b9` | idênticos |
| `worked_example.csv` | `7a1b7ddd0665d6d78b621734523bed829cad7837b5a6a2be6e47557ae0c66358` | idênticos |
| `sessionInfo.txt` | `c0d2eea1d4bbe22eea22116507c2abffaef60b23ac7be5a3477527b3a6cb98ec` | idênticos |

## Evidência preservada e limite do preflight

Os logs integrais estão no diretório temporário: `manifest_before.json`, `manifest_after.json`, `run_command.json`, `run_output.txt` e `reproduction_comparison.json`. Este relatório conserva o comando, a saída, a contagem, os hashes dos 18 artefatos e a comparação de todos os outputs, sem depender dos logs temporários para interpretar o resultado.

A reprodução confirma os resultados do script fornecido e sua integridade nos arquivos registrados. Ainda não avalia se os testes cobrem os claims do teorema, se a arquitetura é substantivamente adequada ou se todas as provas formais estão corretas. Não foram iniciadas críticas da nota, executados verificadores históricos, recompilado o PDF ou emitido PASS científico. A revisão formal integral aguardará o contrato macro validado.
