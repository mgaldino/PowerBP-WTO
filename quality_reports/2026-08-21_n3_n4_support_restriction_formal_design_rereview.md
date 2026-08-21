# Parecer `formal_design` — rerevisão dirigida pós-reparo da restrição de suporte

**Modo:** independente, estritamente read-only. Nenhum arquivo foi criado ou alterado.  
**Manifesto auditado:** `d0a5a98ee7fdb9f28e778b71de5ea98657af81c849fb942dba7bce5fa548eec4`.  
**Integridade:** hash do manifesto e os nove hashes confirmados antes e depois da revisão.

## Escopo e dependências

Foram lidos e confrontados os nove candidatos do manifesto. As dependências continuam corretas e inalteradas:

- N3 consome exclusivamente N1 no hash `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`;
- N4 consome exclusivamente N2 no hash `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`;
- ambos os hashes conferem com os arquivos de interface;
- N3/N4 permanecem `pending/unfrozen`, sem DAG, N6, N7 ou manuscrito.

Dos bytes anteriores, os oito artefatos previstos mudaram e o ledger N3 preservou exatamente o hash `70e42a39cd4ac7f66820647933e6da8669a14b036b591e04d3dba3381b1c4a67`.

## Rederivação independente dos endpoints

Com `u=min_j x_j`:

| Prior | Perfil de `H` | Condição |
|---|---|---|
| `nu=0` | `(sim,sim)` | `u<A`, ou `u>=A` e `Y>=h` |
| `nu=0` | `(não,não)` | `u>=A` e `Y<ell` |
| `nu=0` | `(sim,não)` | `u>=A` e `ell<=Y<h` |
| `nu=0` | `(não,sim)` | nunca |
| `nu=1` | `(sim,sim)` | `u<B`, ou `u>=B` e `Y>=h` |
| `nu=1` | `(não,não)` | `u>=B` e `Y<h` |
| `nu=1` | separadores | nunca |

A construção confirma:

- posterior zero em toda história quando `nu=0`;
- posterior um em toda história quando `nu=1`;
- cutoff `A` no primeiro endpoint e `B` no segundo;
- remoção correta de `NN` em `B<=u<A, Y<ell`;
- ausência da antiga sobreposição;
- unicidade da crença, dos votos fracos e do perfil puro de `H` proposta a proposta nos dois endpoints;
- condições e multiplicidade IC-compatível interiores inalteradas;
- `L_star`, `P_star`, payoffs e certificado de inexistência inalterados.

## Correspondência entre artefatos

- As duas declarações N3 — Markdown e `belief_system` JSON — implementam corretamente suporte endpoint e liberdade apenas no interior.
- O Markdown e o JSON de N4 apresentam as mesmas três partições endpoint.
- O registro `nu=0` consome agora somente `N2-EQ-LOW-TYPE-ONLY`.
- `N4-C14` e `N4-C15` registram unicidade endpoint e posterior um.
- `SM18`, `SM21` e `SM23` removem corretamente a antiga multiplicidade endpoint.
- O script fixa os posteriors endpoint antes do cálculo bayesiano, rejeita `NN` na antiga região sobreposta e testa representantes de todas as células endpoint.
- O script R passou; ambos os JSON passaram no parser; CSV/TSV têm shape constante e IDs únicos.

## Finding

| ID | Severidade | Localização | Finding e reparação dirigida |
|---|---|---|---|
| FD-SUP-MIN-01 | minor | [relatório principal, §6.3, linhas 226–231](/private/tmp/PowerBayesianPersuasion-essential-input-solution-concept/quality_reports/2026-08-21_rederivacao_n3_n4_conceito_solucao_essential_input.md:226) | A frase sobre separação inversa afirma, sem restringir ao interior, que ela exigiria `Y<ell<h<=Y`. Em `nu=1`, o suporte fixa posterior um também após o voto de `H0`, de modo que sua continuação é `h`, não `ell`; a contradição correta é `Y<h<=Y`. O resultado e as tabelas posteriores estão corretos, mas essa etapa da prova resumida não vale no endpoint. Reparação única: qualificar `Y<ell<h<=Y` por `0<nu<1` e acrescentar que, em `nu=1`, ambos os tipos comparam `Y` com `h`, sendo a separação eliminada por preferência estrita ou `T^Y`. |

## Contagem e veredito

```text
critical: 0
major:    0
minor:    1
```

**VEREDITO: NOT PASS — 0/0/1 no manifesto `d0a5a98ee7fdb9f28e778b71de5ea98657af81c849fb942dba7bce5fa548eec4`.**

O finding é exclusivamente uma qualificação incorreta numa prova resumida do relatório. A correspondência formal no Markdown N4, JSON, ledger, matriz e script está correta; nenhum resultado substantivo ou endpoint precisa ser alterado.
