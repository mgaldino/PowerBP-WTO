# N6 — parecer independente de game theory

**Data:** 2026-08-19  
**Papel:** `game_theory`  
**Modo:** read-only; implementador não revisor  
**Hash avaliado:** `sha256:e5a71e29720598f829beb4f720bc966a64d2b04569ded0ba404cdd03b81b3f2a`

## Veredito

**PASS — critical 0 / major 0 / minor 0.**

## Evidência

- N6 consome N3 e N4 nos hashes congelados exatos e não rederiva nem seleciona continuações.
- O transporte preserva um registro de N3 e seis de N4; a comparação contém os seis pares da interseção comum, sem inventar equilíbrio ou eliminar multiplicidade.
- Payoffs por tipo e as quatro distribuições — `pass_with_hegemon`, `pass_without_hegemon`, `failure` e `delay` — são comparados conjuntamente. A representação permanece set-valued e não impõe ranking escalar, tie-break ou seleção.
- A cobertura formal mantém as células `m=2` e `m>=3`, enquanto a interpretação substantiva enfatiza `m>=3`. Para `m>=3`, delay existe universalmente na correspondência de N4, mas pooling também existe; portanto delay não é forçado.
- Células `none` e certificados são preservados pelo desenho, embora nenhuma célula de entrada congelada seja `none` nesta execução. A exclusão em majority e a ausência de passagem sem H em unanimity são mantidas como propriedades das fontes, não como novas premissas.
- O verificador N6 passou, com as seis mutações negativas rejeitadas. Não há cálculo de benchmark público, `RI_M`, `RI_U`, `DeltaRI`, formação, `beta=1` ou N7.

## Artefatos lidos

- [interface N6](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/model_redesign/essential_input_n6_private_information_comparison_v1.json:1)
- [derivação executável/documentação](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/model_redesign/essential_input_n6_private_information_comparison_derivation.md:1)
- [builder](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/scripts/build_essential_input_n6.R:80)
- [verifier](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/scripts/verify_essential_input_n6.R:86)
