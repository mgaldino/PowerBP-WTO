# BP Amplification: Comparative Statics em r e β

**Parâmetros fixos**: N=5, α=0.3, c=0.05 (baixo, para que o screening jump seja visível em E_U)

## Figura

![BP amplification heatmap](bp_amplification_r_beta.png)

## Leitura

- **Eixo x**: r (dispersão de payoffs entre tipos). Maior r → mais a ganhar com screening.
- **Eixo y**: β (fator de desconto). Maior β → R2 threat mais crível → screening mais efetivo.
- **Cor**: max BP amplification = max_μ [cav v(μ, U) - v(μ, U)]. Azul escuro = BP contribui mais.
- **Linha vermelha**: fronteira onde BP amplification se torna positiva. Abaixo/esquerda: BP amp = 0 (screening jump invisível ou inexistente).
- **Contornos cinza**: curvas de nível.

## Padrões

1. **c=0.05 (entry fácil)**: BP amp > 0 para quase todo r > 1.1. β quase irrelevante para a existência de BP, mas afeta a magnitude.
2. **c=0.10 e c=0.12 (entry custoso)**: a fronteira BP > 0 se curva — β passa a importar. Para β baixo, precisa de r maior.
3. Para r ≈ 1.1 (quase sem dispersão), BP amp ≈ 0 independente de β e c — sem dispersão, não há screening.

## Não-monotonicidade em r (c=0.12, β=0.9)

Para c alto, r alto faz duas coisas opostas:

| r | μ_s^R1 | τ(U) | Jump no entry set? | Jump size | αr |
|---|--------|------|---------------------|-----------|-----|
| 1.5 | 0.148 | 0.001 | **SIM** | 0.061 | 0.45 |
| 2.0 | 0.169 | 0.175 | **NÃO** | 0.120 | 0.60 |
| 2.5 | 0.178 | 0.220 | **NÃO** | 0.178 | 0.75 |
| 3.0 | 0.183 | 0.242 | **NÃO** | 0.235 | 0.90 |

**Mecanismo**: r alto aumenta o jump de screening (mais dispersão entre tipos), mas também sobe τ(U) via αr (outside option do hegemon cresce, W recebe menos, entry mais difícil). Enquanto isso, μ_s^R1 é quase insensível a r. Para r ≥ 2.0 com c=0.12, τ(U) ultrapassa μ_s^R1: o jump de screening cai fora do entry set e BP não pode explorá-lo — nenhum sinal Bayes-plausível gera payoff positivo nessa região porque a instituição não se forma ali.

**Implicação substantiva**: o outside option do hegemon é uma faca de dois gumes. αr alto produz screening mais valioso, mas dificulta entry sob unanimidade, podendo eliminar a amplificação de BP exatamente onde o screening seria mais poderoso.
