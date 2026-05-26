# Spec: Extensão com Heterogeneidade, V Endógeno e Discriminação Estatística

**Status**: APPROVED  
**Date**: 2026-04-22

## Objetivo

Nota técnica para paper futuro. Extensão do modelo v3 com:
- α_i heterogêneo e privado (cada jogador sabe seu próprio tipo)
- V(S) endógeno: pie depende da composição da coalizão
- V S-shaped (logística): massa crítica + saturação
- γ ∈ (1,2): grandes α_i contribuem mais que proporcionalmente
- Mecanismo de exclusão via discriminação estatística (não aritmética)

## Decisões de Design

- **Funcional**: V(S) = M / (1 + e^{-λ(∑_{i∈S} α_i^γ - κ)}), logística
- **Tipos**: α_H ∈ {α_L, α_h} binário para tratabilidade; extensão contínua em sketch
- **W's**: α_W conhecido (simplificação base); extensão com W's privados em sketch
- **BP**: H commita sinal π(s|α_H) antes de BF (KG framework standard)
- **Screening**: W proposer faz offer a H → cutoff μ_s → jump → concavificação
- **Discriminação**: sob maioria, W proposer exclui H (adverse selection) → BP neutralizado

## Estrutura da Nota

1. Modelo (primitivas, V(S), timing)
2. Screening sob unanimidade (cutoff, value function, BP)
3. Maioria: exclusão por discriminação estatística
4. Comparação institucional
5. Estática comparativa (γ, κ, N, σ²_H)
6. Worked example
7. Extensões (W's privados, tipos contínuos, info assimétrica de H)
8. Conexão com modelo v3
9. Questões abertas
