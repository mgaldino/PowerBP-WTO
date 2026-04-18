# Carta Editorial v2 — Revisão de Modelo Formal

## Decisao: R&R Minor (para JTP/GEB) / R&R Major (para AJPS/IO)

## Scores consolidados (v1 → v2)
| Dimensao              | v1     | v2      |
|-----------------------|--------|---------|
| Design do modelo      | 7.5/10 | 7.5/10  |
| Apresentação técnica  | 6/10   | 7.5/10  |
| Exposição             | 7.5/10 | 8.2/10  |
| **Global**            | 7/10   | **7.7/10** |

## Melhorias reconhecidas
- Worked example N=3: "exatamente o que Thomson e Varian recomendam" (ME5: 9/10)
- "In plain language" paragraphs: "dual track exposition, excelente" (ME3: 9/10)
- Puzzle na intro: "gancho excelente ao estilo Board & Meyer-ter-Vehn"
- Assumptions formalizadas, PBE declarado
- Notação limpa (i_S em vez de S, conflito resolvido)

## Problemas remanescentes
- Falta isolamento limpo entre mecanismo de exclusão e mecanismo de BP (tabela 2x2 sugerida)
- Prova da Prop 2 tem possível gap (proposer oferece δH/N ao Sender sob μ=L/H?)
- Falta worked example para unanimidade (assimetria na exposição)
- Falta game tree e figura de concavificação
- Bug numérico no exemplo N=3 (CORRIGIDO)
- Seção 7 (aplicação) curta demais para a ambição da intro
- Falta seção de limitações/extensões

## Achado crítico: possível gap na prova da Prop 2

O parecerista notou: sob o sinal "alerta" (μ = L/H), o proposer deveria ir safe (c = L). Se o proposer vai safe, por que ofereceria δH/N ao Sender? O Sender com ω=L aceitaria δL/N. O argumento de que S recebe δH/N "em ambos os sinais" precisa ser reconstruído com mais cuidado.
