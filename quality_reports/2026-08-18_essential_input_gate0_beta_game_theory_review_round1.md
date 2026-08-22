# Parecer adversarial — Gate 0 `beta<1`

`reviewer_role=game_theory`  
`reviewer_id=review-gate0-beta-game-2026-08-18-r1`

## Veredicto

**FAIL — critical: 0; major: 1; minor: 0.**

O contrato e o DAG atuais estão substantivamente coerentes com `beta in (0,1)`. A falha está no verifier canônico: seus testes de domínio e autorização aceitam contradições aditivas e campos não previstos, podendo produzir falso `PASS`.

## Snapshot verificado

- Branch: `codex/essential-input-beta-interior`
- HEAD: `341492c88908e23171180875bbc0c2971e4a184a`
- Tag anotada `pre-essential-input-2026-08-12`:
  - objeto tag: `ee11a84fd5a3cc270c0367eecf65b1f7a0572116`
  - commit após peeling: `f53e6769624ce3dd6e64e21ad40d08230b0950a7`
- Contrato: `2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- DAG: `740d0945ac2ee845331a75b7a0e5af1d49d2cc13a0c00dce98a386d8ff69fd21`
- Verifier: `c3342606ab88c2f194bf392645538046eb50e0394112b05e7c3912359085c42f`

## Auditoria substantiva de `beta`

A mudança de domínio é exatamente de `(0,1]` para `(0,1)`: exclui somente a fronteira paramétrica `beta=1`. Não acrescenta restrições sobre `N`, crenças, propostas, estratégias ou outcomes. Exclui toda a face `beta=1`, embora o canto `D=0` ocorra apenas quando também `q=m`.

A desigualdade está correta. Para `m=N-1`, `q=floor(N/2)+1` e `N>=3`:

- Se `N=2r+1`, então `q=r+1 <= 2r=m`.
- Se `N=2r`, com `N>=4`, então `q=r+1 <= 2r-1=m`.

Logo `q/m<=1`. Como `0<beta<1`, segue que `beta*q/m<1` e, condicionalmente à fórmula candidata,

`D = 1-beta*q/m > 0`.

Quando `beta=1`, `D=0` somente se `q=m`, isto é, em `N=3` ou `N=4`; para `N>=5`, ainda seria positivo. O contrato descreve corretamente essa distinção.

Também não transporta `D` como resultado provado: chama-o de “consequência a reavaliar” e exige que `N3` o rederive das primitivas. P0–P7, as crenças off-path, a exaustividade e a multiplicidade permanecem obrigações abertas. Portanto, a restrição não seleciona diretamente exclusão, ausência de atraso ou qualquer equilíbrio desejado.

A referência bibliográfica é adequada como precedente de domínio. Eraslan e Evdokimov definem `delta_i in [0,1)` na seção sobre probabilidades de reconhecimento e fatores de desconto. O contrato declara expressamente que isso não prova `D>0` nem resultados deste modelo, distinção metodologicamente correta. Veja o [preprint oficial da Rice University](https://economics.rice.edu/sites/g/files/bxs4046/files/2020-10/lb-ar-final.pdf) e a [publicação na Annual Review of Economics](https://www.annualreviews.org/content/journals/10.1146/annurev-economics-080218-025633).

## Reset, escopo e infraestrutura

- Os seis nós `N1`, `N2`, `N3`, `N4`, `N6`, `N7` estão `pending`.
- Todas as coleções de correspondência estão `null`.
- Não permanecem `artifact_hash`, `dependency_hashes`, `frozen`, ordens de execução ou reviews consumíveis.
- Apenas `N1` e `N2` estão topologicamente prontos.
- A autorização posterior alcança somente a futura reavaliação de `N1`–`N3`, após os dois PASS do contrato.
- `N4`, `N6`, `N7`, Goal 2, `beta=1` e migração continuam expressamente não autorizados.
- As dependências e invalidações transitivas estão corretas.
- `Rscript scripts/verify_essential_input_gate0.R` terminou com `PASS`.
- `git diff --check` terminou com exit `0`.
- O worktree modifica apenas contrato, DAG e verifier.
- `formal_model_v5.Rmd`, `formal_model_v6.Rmd`, o registro decisório protegido e os artefatos `pivotal-response` não foram alterados.

## Finding

**MAJOR — o verifier não valida de forma exclusiva o domínio de `beta`, o escopo autorizado nem o objeto pending.**

Texto exato:

> `scripts/verify_essential_input_gate0.R` valida `beta<1` e a autorização de `N1`–`N3` apenas pela presença de substrings esperadas e pela ausência de uma única grafia antiga. Em testes read-only, os predicados continuaram retornando `TRUE` depois de anexar, separadamente, “beta=1 integra o baseline”, “D<=0 é permitido no baseline” e “N4 pode começar imediatamente”. Além disso, `is_valid_current_pending_node` usa uma blacklist de campos de lifecycle, sem exigir o conjunto exato de chaves do nó, de modo que um campo adicional como `authorized=true` pode atravessar o gate. Assim, o verifier canônico pode emitir `PASS` para um contrato ou DAG que contradiga precisamente o domínio e o escopo que seu output afirma verificar.

Evidência principal: [verify_essential_input_gate0.R](/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion/scripts/verify_essential_input_gate0.R:1079), especialmente os validadores das linhas 1079–1086 e 1131–1151.

Classificação `major`, não `critical`: o snapshot exato auditado contém a restrição e o escopo corretos, mas o gate executável não é resistente a mutações centrais e pode certificar estados futuros contraditórios.

Nenhum arquivo foi editado e o parecer não foi salvo no repositório.
