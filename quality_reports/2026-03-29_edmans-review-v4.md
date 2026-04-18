# Carta Editorial v4 — Framework Edmans

## Decisao: Reject-and-Resubmit

## Scores consolidados (v3 → v4)
| Dimensao     | v3     | v4      | Delta |
|-------------|--------|---------|-------|
| Contribution | 6/10   | 6/10    | =     |
| Execution    | 6.5/10 | 5.5/10  | -1.0  |
| Exposition   | 7.5/10 | 7.5/10  | =     |
| **Global**   | 6.5/10 | **6.3/10** | -0.2 |

## Sintese editorial

A reestruturacao (beta=0 no modelo principal, beta>0 como extensao) resolveu o problema de narrativa — o paper agora e honesto sobre o que depende de beta e o que nao depende. Design e Exposition do modelo formal melhoraram. Mas a mudanca expos um problema que antes estava parcialmente mascarado: **o Curse of Knowledge e mecanicamente simples demais**.

O parecerista de Execution v4 articulou o ponto de forma contundente: o Curse segue de dois lemmas aritmeticos (E[omega] > muH, e N-2 >= q para N>=3). Nao ha forca oposta, nao ha tradeoff, nao ha regiao de parametros onde o Sender seria incluido. A "distancia premissas-conclusoes" (T.1) e quase zero. Compare com BF original: proposal power como resultado de equilibrio NAO e transparente a partir do setup. Aqui, a exclusao e transparente.

Este e agora o bottleneck principal do paper — acima de beta, acima de citacoes, acima de aplicacao. O modelo precisa de um mecanismo que **torne a inclusao do Sender potencialmente vantajosa**, criando tensao entre custo (informacao torna S caro) e beneficio (informacao de S melhora a proposta). O Curse emergiria quando o custo supera o beneficio, que seria um resultado de equilibrio nao-trivial.

## Prioridades para revisao

1. **Introduzir valor informacional do Sender na coalizao.** Se incluir S permite calibrar a proposta (e.g., propor c=omega vs arriscar c=H), o custo maior de S seria compensado. A exclusao emergiria como resultado de equilibrio nao-trivial, nao como aritmetica.
2. **Expandir citacoes** (9 → 20+). Eraslan, Schnakenberg, Maggi & Morelli, etc.
3. **Fortalecer Secao 7** (aplicacao) ou reduzir a paragrafo motivacional.
4. **Robustez a omega continuo** ou ao menos 3 estados.
5. **Formalizar verificacao de equilibrio** (perfil completo de estrategias + no-deviation).

## Recomendacao estrategica

O Curse e uma ideia genuinamente boa que precisa de um modelo que faca justica a ela. Na forma atual, a elegancia da exposicao mascara a simplicidade excessiva do mecanismo. Para JTP/GEB, o paper pode passar com as correcoes de exposicao. Para AJPS/JOP, o modelo precisa de mais "teeth" — a sugestao de valor informacional do Sender na coalizao e a mais promissora.
