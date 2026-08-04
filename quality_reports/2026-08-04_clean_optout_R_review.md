# Revisão independente dos verificadores R: baseline de opt-out imediato

## Rodada 1

- **Commit revisado:** `70969f5f14bdc63d557bc6d7d1e27bb3aa4c5304`.
- **Revisor:** agente independente read-only `/root/r_final_reviewer`.
- **Workflow:** `review-r`.
- **Edição pelo revisor:** nenhuma; a reprodução ocorreu em extração
  temporária do commit.
- **Veredito:** **REPAIR**.
- **Nota:** B.

### Reprodução

Os seis scripts retornaram exit status zero e reproduziram CSVs byte a byte
idênticos aos blobs revisados: protocolo 36/36, R2 8/8, R1 unanimidade 11/11,
maioria 17/17, entrada/classificação 10/10 e fronteiras 7/7. Um stress test
independente com 200 mil sorteios não encontrou contracounterexample numérico.

### Achados

| Severidade | Achado | Arquivo/objeto |
|---|---|---|
| major | A IC terminal de `H`, a igualdade de pooling para `H`, o low candidate de maioria, o valor de rejection e alguns máximos/endpoints eram testados por expressões tautológicas ou mais fracas que seus rótulos. | Verificadores R2, majority, entry/classification e boundaries. |
| major | Duas desigualdades de maioria usavam apenas as primeiras 1.000 de 7.560 linhas ordenadas do grid. | `verify_clean_optout_majority_piH0.R`. |
| minor | Cinco logs algébricos não registravam integralmente inputs, output, commit de execução ou `sessionInfo()`. | Logs R2, R1, majority, entry/classification e boundaries. |

### Resposta do implementador

1. `EU_yes` e `EU_no` passaram a ser construídos separadamente; payoffs de
   ramos, reconhecimento, outside options e ponderação de tipos também são
   calculados por caminhos independentes antes da comparação.
2. O grid de 7.560 linhas é usado integralmente.
3. Checks de cobertura que não são provas foram rotulados como smoke/coverage;
   as provas permanecem no Rmd.
4. Os logs registram inputs, número de linhas, output, data, status,
   `git_head_at_execution` e `sessionInfo()`.
5. O verificador de fronteiras passou a testar as novas provas e sequências de
   limites laterais. A suíte reparada contém 96 checks: 36 + 8 + 11 + 18 + 10
   + 13.

## Rodada 2

Pendente até a fixação do novo commit candidato.
