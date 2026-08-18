reviewer_role=game_theory  
reviewer_id=review-gate0-beta-game-2026-08-18-r3

## Veredicto

**FAIL — critical: 0; major: 1; minor: 0.**

O contrato e o DAG exatos estão corretos, mas F1 permanece aberto quando o pin global é neutralizado. As âncoras não cobrem toda a Seção 2, e objetos aninhados do manifest ainda aceitam campos extras.

## Hashes e fronteira

- Contrato: `2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- DAG: `740d0945ac2ee845331a75b7a0e5af1d49d2cc13a0c00dce98a386d8ff69fd21`
- Verifier: `f5755f4fa182faf9184c6e488794b2303fdb4baf659b410ed2b7b9c810a89c93`
- Branch: `codex/essential-input-beta-interior`
- HEAD: `cc9cea6d2425c7d22daaf66bdbc96058cb147b16`
- Tag anotada: `ee11a84fd5a3cc270c0367eecf65b1f7a0572116`
- Tag após peeling: `f53e6769624ce3dd6e64e21ad40d08230b0950a7`

## Testes correntes

- `Rscript scripts/verify_essential_input_gate0.R` → `PASS`.
- O verifier informou rejeição das nove mutações incorporadas.
- `git diff --check` → exit `0`.
- Todos os seis nós estão `pending`, com interfaces nulas e chaves exatas.
- Apenas `N1` e `N2` estão topologicamente prontos.
- `N4`, `N6`, `N7`, Goal 2, `beta=1` e migração permanecem não autorizados no snapshot real.
- Registro decisório, `formal_model_v5.Rmd`, `formal_model_v6.Rmd` e artefatos `pivotal-response` permanecem intocados.

## Semântica substantiva

Para `m=N-1`, `q=floor(N/2)+1` e `N>=3`, vale `q<=m`. Com `0<beta<1`:

`beta*q/m < 1`, portanto `D=1-beta*q/m>0`.

Essa conclusão é condicional à fórmula candidata. O contrato corretamente exige que `N3` a rederive; não importa `D` como premissa e não seleciona antecipadamente ausência de atraso ou outro outcome. A mudança de domínio exclui somente a face paramétrica `beta=1`.

A referência Eraslan–Evdokimov permanece tratada apenas como precedente para `delta_i in [0,1)`, não como prova de `D>0` ou do equilíbrio deste jogo.

## Stress test das nove mutações

Com o pin global neutralizado, `is_valid_contract_semantics()` produziu:

| Mutação | Resultado |
|---|---:|
| Exceção `beta=1` inserida na Seção 2 logo após a linha canônica | **aceita** |
| `Rodadas` alterada para permitir desconto unitário | **aceita** |
| Regra `beta=1` inserida no fim da Seção 2 | **aceita** |
| Autorização de N4 adicionada imediatamente após a âncora do cabeçalho | **aceita** |
| Autorização de N4 adicionada na Seção 11 | **aceita** |
| Exceção `beta=1` adicionada na Seção 12 | **aceita** |
| Eraslan–Evdokimov como prova, adicionada na Seção 13 | **aceita** |
| Contradição inserida dentro do cabeçalho regional hasheado | rejeitada |
| Premissa importada inserida dentro da decisão regional hasheada | rejeitada |

A mutação coordenada — `beta=1` dentro da Seção 2 mais autorização de N4 na Seção 11 — também foi aceita.

O campo superior `authorized_nodes` agora é corretamente rejeitado. Contudo, campos equivalentes aninhados em `invalidation_rule`, `freeze_gate_schema` ou `interface_schemas` continuam passando pelas validações explícitas.

## Finding textual

**MAJOR — as âncoras regionais não fecham a fonte canônica inteira e o manifest não é exato recursivamente.**

> `extract_normative_contract_regions()` identifica toda a Seção 2, mas valida somente a linha que começa por `Desconto`. Por isso, uma segunda regra incompatível dentro da mesma Seção 2 não altera `beta_primitive` nem os hashes do cabeçalho e da decisão sobre atraso. Com o pin global neutralizado, três contradições inseridas na própria fonte canônica das primitivas foram aceitas, assim como a mutação coordenada com autorização de N4. Além disso, `is_valid_manifest_top_level()` fecha apenas as chaves superiores: campos extras como `invalidation_rule$authorized_nodes`, `freeze_gate_schema$authorized_goal` e `interface_schemas$equilibrium_correspondence_v1$authorized_nodes` não são recusados. Logo o gate ainda pode emitir falso `PASS` para uma primitiva ou autorização contraditória no teste adversarial exigido.

Evidência principal: [verify_essential_input_gate0.R](/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion/scripts/verify_essential_input_gate0.R:73), especialmente a extração parcial da Seção 2 e a validação apenas das chaves superiores do manifest.

Classificação `major`: o snapshot exato está protegido pelo pin e é matematicamente coerente, mas o teste explicitamente requerido com essa barreira neutralizada continua falhando, e mutações aninhadas do DAG atravessam o verifier.

Nenhum arquivo foi editado e nenhum parecer foi salvo.
