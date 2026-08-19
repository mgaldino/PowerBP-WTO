# N6 — parecer independente de formal design

**Data:** 2026-08-19  
**Papel:** `formal_design`  
**Modo:** read-only; implementador não revisor  
**Hash avaliado:** `sha256:e5a71e29720598f829beb4f720bc966a64d2b04569ded0ba404cdd03b81b3f2a`

## Veredito

**PASS — critical 0 / major 0 / minor 0.**

## Evidência

- O schema `private_information_comparison_v1` mantém exatamente as duas coleções privadas, majority e unanimity, e a coleção de comparação, sem coleções públicas, de rendas ou de formação.
- O transporte é fonte-nativo: um registro privado de N3 e seis registros privados de N4, cada um preservado uma vez com IDs de célula/equilíbrio, hash da interface, payoffs, distribuições de resultados, `selection_status` e checks.
- A construção da interseção comum produz seis pares, o produto cartesiano esperado `1 x 6`, com hashes e IDs de origem preservados. O caminho para células `none` mantém certificado e não apaga a coleção sobrevivente.
- A instrução autoral está codificada sem alterar o contrato: o domínio formal conserva `m=2` e `m>=3`; a leitura substantiva prioriza `m>=3` (três fracos, quatro ou mais membros); nesse escopo, delay existe universalmente na correspondência de N4, mas não é forçado porque pooling também existe.
- O verificador N6 passou e rejeitou as seis mutações negativas: duplicação de registro, par ausente, hash N4 stale, exclusão de coleção sobrevivente, alteração de payoff e campo `RI_M` fora de escopo.
- Não houve alteração ou rederivação de N1–N4, protocolo, schema, domínio `beta<1` ou arquivos protegidos.

## Artefatos lidos

- [interface N6](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/model_redesign/essential_input_n6_private_information_comparison_v1.json:1)
- [builder](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/scripts/build_essential_input_n6.R:80)
- [verifier](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/scripts/verify_essential_input_n6.R:86)
- [ledger](</Users/manoelgaldino/.codex/worktrees/b12d/PowerBayesianPersuasion/model_redesign/essential_input_n6_private_information_comparison_ledger.json:1)
