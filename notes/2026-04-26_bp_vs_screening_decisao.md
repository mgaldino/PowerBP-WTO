# Decisão estratégica: manter ou remover BP do paper?

**Data**: 2026-04-26
**Status**: ON HOLD — autor precisa pensar

---

## O problema

A narrativa do paper está complicada pela coexistência de dois mecanismos (screening + BP). A decomposição quantitativa (CR8) revelou que:

1. Para o Example 2 do paper (N=5, r=1.5, α=0.3, β=0.9, c=0.14), **BP amplification = 0** em todo o entry set E_U. A vantagem inteira é screening puro (Lemma 1).
2. BP amplification > 0 só quando o screening jump μ_s^R1 cai dentro de E_U (requer c baixo).
3. Há uma não-monotonicidade em r: r alto aumenta o jump mas também sobe τ(U) via αr, podendo empurrar o jump para fora do entry set.
4. O coarse review flaggou a hipótese de commitment (CR3) como fraqueza — sem análise de cheap talk ou verifiable disclosure.

## O que o paper tem SEM BP (só screening)

### Resultado principal
**Lemma 1**: Para α < α\*, unanimidade dá a H payoff estritamente maior que maioria em todo μ ∈ (0,1], condicional a entry. Resultado limpo, sharp, sem hipótese de commitment.

**Resultado sem BP**: H prefere unanimidade para todo p ∈ E_U. Fora de E_U, unanimidade não forma e maioria pode dominar.

### Preferências de W sem BP
- V_W(μ, U) < V_W(μ, M) para todo μ ∈ (0,1] (budget identity + Lemma 1)
- τ(U) > τ(M): entry mais difícil sob unanimidade
- W **sempre** prefere maioria, mas aceita unanimidade quando entry é individualmente racional (V_W ≥ c)
- W não escolhe a regra; H escolhe

### Conflito distributivo

| | H prefere | W prefere |
|---|---|---|
| Regra | Unanimidade | Maioria |
| Razão | Screening: D(μ) > 0 | Mais surplus: V_W(M) > V_W(U) |
| Entry | Mais difícil (τ(U) > τ(M)) | Mais fácil (τ(M) < τ(U)) |

Não é Pareto-comparável em E_U: H ganha, W perde sob unanimidade.

### A ironia central
W aceita unanimidade porque o **veto protege W contra exclusão** (sob maioria, W pode ser excluído da coalizão). Mas essa mesma proteção cria o screening problem que beneficia H. W troca risco de exclusão por exposição ao screening. A igualdade formal (veto para todos) é o mecanismo pelo qual H extrai mais.

### Condição necessária
O argumento depende **inteiramente** de informação privada de H sobre o valor do deal. Sem informação privada:
- Não há screening (W sabe θ, faz oferta ótima sem incerteza)
- V_H é o mesmo sob ambas as regras
- A vantagem de unanimidade desaparece

Informação privada é a condição necessária. Unanimidade é o que a torna estrategicamente produtiva.

## O que BP adiciona

1. **Estende o resultado para p < τ(U)**: BP permite a H induzir entry sob unanimidade em priors onde a instituição não se formaria sozinha. Amplia o range de priors onde unanimidade domina (de E_U para (p\*, 1]).
2. **Sob maioria, BP é inútil**: v(·, M) é affine, cav v = v. Assimetria bonita.
3. **BP amplification = cav v(p,U) - v(p,U)**: o gap entre envoltória côncava e função-valor. Positivo somente onde v tem não-convexidade explorável dentro de E_U.

## O que BP custa

- Hipótese de commitment (CR3: coarse review considera fraca)
- Maquinaria de concavificação (Kamenica-Gentzkow)
- Interação c vs. μ_s^R1 vs. τ(U) que complica a narrativa
- BP amplification = 0 no próprio Example 2 do paper
- Leitor de JoP precisa entender concavificação

## Comparative statics de BP

BP amplification cresce com:
- **r** (dispersão de payoffs) — mas com não-monotonicidade: r alto também sobe τ(U)
- **β** (paciência) — R2 threat mais crível, screening mais efetivo
- **c baixo** — τ(U) desce, screening jump entra no entry set

Tabela (c=0.12, β=0.9, N=5, α=0.3):

| r | μ_s^R1 | τ(U) | Jump em E_U? | Jump size | αr |
|---|--------|------|--------------|-----------|-----|
| 1.5 | 0.148 | 0.001 | SIM | 0.061 | 0.45 |
| 2.0 | 0.169 | 0.175 | NÃO | 0.120 | 0.60 |
| 2.5 | 0.178 | 0.220 | NÃO | 0.178 | 0.75 |
| 3.0 | 0.183 | 0.242 | NÃO | 0.235 | 0.90 |

## Trade-off

| | Com BP | Sem BP |
|---|---|---|
| Resultado | H prefere U para p > p\* | H prefere U para p ∈ E_U |
| Hipóteses | Commitment a info structure | Nenhuma adicional |
| Narrativa | Screening + BP + interação | Só screening |
| Contribuição para IR | Dupla (screening + info design) | Única (screening) |
| Vulnerabilidade | CR3, CR8 | Nenhuma dessas |
| W's perspective | Mais complexa (BP pode prejudicar W) | Limpa: W prefere M, aceita U quando IR |
| Journal fit | JET, TE | JoP, AJPS |

## Opções

**A — Remover BP do corpo**: Corpo só com screening (Lemma 1, Theorem sem concavificação). BP como extensão no Appendix ("if the hegemon can also design information structures..."). Elimina CR3, CR8, simplifica narrativa. Título muda.

**B — Manter BP subordinado ao screening**: Screening é o resultado; BP é corolário em 1 parágrafo. Reformular narrativa para que BP não seja co-protagonista. Mantém contribuição dupla mas com hierarquia clara.

**C — Manter como está**: Screening + BP como co-protagonistas. Requer resolver CR3, CR8, e melhorar comunicação.

## Erro numérico encontrado nesta sessão

p\* no Example 2 era 0.24 no paper. Valor correto: **0.12**. Já corrigido no v4.

## Decisão (2026-04-26)

**Opção B modificada**: screening é o mecanismo central no corpo. BP removido como co-protagonista. Um Remark (sem prova) aponta que a estrutura do modelo é hospitable a information design, sem desenvolver.

Texto aprovado do Remark (versão final):

> Remark X (Information design). The model also clarifies why information design would matter differently under the two voting rules. Under majority rule, the hegemon's continuation payoff is affine in weak states' posterior belief once entry is feasible. Splitting beliefs therefore does not create additional value beyond the payoff implied by the prior. Under unanimity, by contrast, weak states must include the hegemon in any agreement. This creates a screening discontinuity at the posterior threshold at which entry becomes feasible. As in standard Bayesian persuasion, such nonconcavities are precisely where information design can matter. Thus, although persuasion is not necessary for the paper's main result, the model identifies why consensus institutions are more hospitable to informational leverage than majority institutions.

Nota: o autor preferiu manter "nonconcavities" (da versão original) em vez de "discontinuities". A função inteira (incluindo o zero abaixo de τ(U)) não é côncava — o termo é defensável.

**Implementação**: pendente autorização explícita do autor. NÃO reescrever até autorizar.
