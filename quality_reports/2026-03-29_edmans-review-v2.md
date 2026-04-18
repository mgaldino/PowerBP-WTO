# Carta Editorial v2 — Framework Edmans

## Decisao: Reject-and-Resubmit

## Scores consolidados (v1 → v2)
| Dimensao     | v1    | v2     |
|-------------|-------|--------|
| Contribution | 5/10  | 6.5/10 |
| Execution    | 6/10  | 5.5/10 |
| Exposition   | 7.5/10| 6/10   |
| **Global**   | 6/10  | **6/10** |

## Mudanças detectadas pelos pareceristas

**Melhorias reconhecidas:**
- Puzzle da intro muito mais forte (Tucídides + contraste doméstico/internacional)
- Crítica a Steinberg precisa e cirúrgica ("description, not mechanism")
- Abstract com números concretos (16%, 28%, 76%)
- Worked example N=3 antes dos resultados gerais
- Parágrafos "in plain language" após cada proposição
- Assumptions formalizadas, PBE declarado

**Problemas persistentes/novos:**
- Provas incompletas (proof sketches para Prop 2 — parecerista de Execution flagrou possível gap lógico)
- Nenhuma análise de robustez (pie contínuo, múltiplos Senders, cheap talk)
- Citações insuficientes (7 referências para duas literaturas maduras)
- Repetição intro/Seção 7
- Seção 6 como seção separada é padding
- Bug numérico no exemplo N=3 (CORRIGIDO: 0.489→0.578, 27%→13%)

## Crítica mais importante (Execution T.3)

O parecerista de Execution v2 levantou um ponto sutil sobre adverse selection: quando o proposer inclui S na coalizão, o proposer precisa oferecer δH/N (para garantir aceitação em ambos os estados) ou δL/N (arriscando rejeição quando ω=H). Esse problema de screening não é tratado explicitamente no paper. Precisa ser endereçado nas provas.
