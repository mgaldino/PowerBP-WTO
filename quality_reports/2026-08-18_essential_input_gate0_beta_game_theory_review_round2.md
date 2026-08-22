reviewer_role=game_theory  
reviewer_id=review-gate0-beta-game-2026-08-18-r2

## Veredicto

**FAIL — critical: 0; major: 1; minor: 0.**

O contrato e o DAG exatos continuam corretos. O reparo fecha as mutações literais do Round 1, mas não fecha F1 quando o pin do hash é neutralizado, como exigido: paráfrases contraditórias ainda passam pela validação semântica. Há também um bypass por campo extra no nível superior do DAG.

## Snapshot verificado

- Branch: `codex/essential-input-beta-interior`
- HEAD: `cc9cea6d2425c7d22daaf66bdbc96058cb147b16`
- Contrato: `2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- DAG: `740d0945ac2ee845331a75b7a0e5af1d49d2cc13a0c00dce98a386d8ff69fd21`
- Verifier reparado: `c7255bc4cf98200f6ddde5e7f9d3596bd90a3c87042ac37eb10a5d00efd4d853`
- Tag anotada:
  - objeto: `ee11a84fd5a3cc270c0367eecf65b1f7a0572116`
  - commit após peeling: `f53e6769624ce3dd6e64e21ad40d08230b0950a7`

## Testes executados

- `Rscript scripts/verify_essential_input_gate0.R` → exit `0`, com `MUTATION_REJECTED` e `PASS`.
- `git diff --check` → exit `0`.
- Rechecagem algébrica para `N=3,...,10000` e valores interiores representativos de `beta` → `q<=m` e `D>0`.
- Mutações read-only dos validadores semânticos com o pin do contrato neutralizado.
- Mutações de campos extras no DAG.
- Auditoria de status, interfaces nulas, dependências, prontidão e arquivos protegidos.

## Semântica substantiva

Para `m=N-1`, `q=floor(N/2)+1` e `N>=3`, vale `q<=m`. Portanto, se a fórmula candidata sobreviver à rederivação de `N3`,

`D = 1-beta*q/m > 0`

para todo `beta in (0,1)`.

A mudança de `(0,1]` para `(0,1)` exclui exatamente a fronteira paramétrica `beta=1`; não acrescenta restrição sobre crenças, propostas ou estratégias. O contrato reconhece que o canto `D=0` requer conjuntamente `beta=1` e `q=m`, o que ocorre em `N=3,4`.

`D` permanece consequência a reavaliar, não premissa: `N3` deve reconstruí-lo das primitivas, e P0–P7 permanecem abertos. Não há seleção silenciosa de ausência de atraso, exclusão ou outro outcome.

A referência de Eraslan–Evdokimov sustenta apenas o precedente de domínio: o texto usa `delta_i in [0,1)`, mas não prova a desigualdade nem o equilíbrio deste jogo. O contrato explicita corretamente essa limitação. Fonte: [preprint oficial da Rice University](https://economics.rice.edu/sites/g/files/bxs4046/files/2020-10/lb-ar-final.pdf).

## Estado e escopo

- `N1`, `N2`, `N3`, `N4`, `N6` e `N7`: todos `pending`.
- Todas as coleções de correspondência: `null`.
- Nenhum nó contém hash, reviews, congelamento ou ordem de execução.
- Apenas `N1` e `N2` estão topologicamente prontos.
- A autorização alcança somente `N1`–`N3`, após o gate dos dois pareceres.
- `N4`, `N6`, `N7`, Goal 2, `beta=1` e migração permanecem não autorizados.
- O worktree modifica apenas o verifier.
- Registro decisório, `formal_model_v5.Rmd`, `formal_model_v6.Rmd` e `pivotal-response` permanecem intocados.

## Finding textual

**MAJOR — F1 permanece aberto sob neutralização do pin e campos extras no envelope do DAG.**

> O hash exato agora impede qualquer alteração dos bytes do contrato no caminho normal, e as quatro frases literais do Round 1 são rejeitadas. Contudo, depois de neutralizar isoladamente esse pin, `has_no_additive_contract_contradictions()` continua sendo uma denylist de quatro strings exatas. As seguintes contradições semanticamente equivalentes foram todas aceitas por `is_valid_contract_semantics()`:
>
> - “REGRA POSTERIOR: beta = 1 também pertence ao baseline principal.”
> - “REGRA POSTERIOR: desconto unitário integra o domínio principal.”
> - “REGRA POSTERIOR: o ganho D pode ser não positivo no baseline.”
> - “AUTORIZAÇÃO POSTERIOR: o Goal 2 pode começar por N4.”
> - “A referência de Eraslan e Evdokimov demonstra o sinal positivo de D.”
> - “DECISÃO POSTERIOR: desconto unitário integra o benchmark e o segundo goal está liberado.”
>
> Todas retornaram `TRUE`, inclusive a mutação coordenada. Além disso, o verifier não exige o conjunto exato de chaves do objeto superior `manifest`; acrescentar `authorized_nodes=["N4"]` não é alcançado pelos testes recursivos dos nós nem por qualquer asserção sobre `names(manifest)`. Assim, removida a primeira barreira conforme solicitado, o gate ainda pode certificar uma contradição substantiva; e o DAG pode carregar autorização extra mesmo com o pin do contrato ativo.

Evidência: [verify_essential_input_gate0.R](/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion/scripts/verify_essential_input_gate0.R:1231). As chaves externas dos nós foram corretamente fechadas nas linhas 1105–1123, mas o envelope superior do manifest e a semântica por paráfrase permanecem abertos.

Classificação `major`: o snapshot atual é correto e protegido pelo hash, portanto não há erro matemático corrente; porém o teste negativo explicitamente exigido com o pin neutralizado continua falhando, e o verifier ainda admite um falso `PASS` por mutação do DAG.

Nenhum arquivo foi editado e nenhum parecer foi salvo no repositório.
