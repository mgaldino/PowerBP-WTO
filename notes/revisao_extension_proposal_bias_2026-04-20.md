# Revisão crítica da nota `2026-04-20_extension_proposal_bias.md`

## Veredito geral

A extensão tem uma ideia boa e o mecanismo central **sobrevive**, mas a nota **não está pronta para virar texto de paper** sem correções. Em particular:

1. **R2 sob unanimidade**: está consistente.
2. **R2 sob maioria**: está consistente, desde que você mantenha a convenção do modelo base de que, quando W propõe, H efetivamente obtém `αV(θ)` sem gerar screening.
3. **R1 sob unanimidade**: a parte principal está consistente; o gap entre ofertas é mesmo `β p_H (r-1)`.
4. **R1 sob maioria**: a fórmula de `E[V_H^{R1}(μ,M)] = V_e(μ) Φ_M` está correta, mas a fórmula de `V_W^{R1}(μ,M)` na nota está mal agregada.
5. **Jump em R1**: a fórmula local do salto está correta, mas a afirmação de que o jump é “proporcional a `p_H(1-p_H)`” é **forte demais** porque `μ_s^{R1}` também depende de `p_H`.
6. **Monotonicidade de `μ_s^{R1}` em `p_H`**: a conclusão parece correta nos exemplos e há um bom caminho analítico, mas a nota, como está, **não prova** isso completamente.

---

## 1. O que está correto

### 1.1. R2 sob unanimidade com bias

As fórmulas da nota estão consistentes:

- `V_H^{R2}(1,μ,U) = r[p_H + (1-p_H)α]`
- `V_H^{R2}(0,μ<U) = p_H + (1-p_H)α`
- `V_H^{R2}(0,μ>μ_s) = p_H + (1-p_H)αr`

- `V_W^{R2}(μ<μ_s,U) = p_W (1-μ)(1-α)`
- `V_W^{R2}(μ>μ_s,U) = p_W (V_e(μ)-αr)`

com `p_W = (1-p_H)/(N-1)` e `V_e(μ)=1+μ(r-1)`.

O jump em `E[V_H^{R2}]` no cutoff terminal também está correto:

`Jump^{R2} = (1-μ_s)(1-p_H) α (r-1)`.

Isso cai monotonicamente com `p_H`.

### 1.2. R1 sob unanimidade: ofertas agressiva e conservadora

Aqui a nota também está essencialmente certa.

Se um `W_j` propõe em R1:

- oferta conservadora para H:
  `y_H^{con} = β r [p_H + (1-p_H)α]`
- oferta agressiva para H:
  `y_H^{agg} = β [p_H + (1-p_H) α r]`

Logo,

`y_H^{con} - y_H^{agg} = β p_H (r-1)`.

Esse ponto é importante e está correto: **o custo incremental de pooling em R1 cresce linearmente com `p_H`**.

### 1.3. R1 sob maioria: ausência de screening

A conclusão qualitativa está correta: **sob maioria, não há screening**.

A razão correta é esta:

- quando `W` propõe, a proposta passa sem o voto de `H`;
- portanto, a aceitação/rejeição de `H` não é payoff-relevant para `W`;
- logo, não surge o problema estratégico de escolher uma oferta para induzir separação ou pooling.

A nota chega a isso, mas uma frase deve ser eliminada: dizer que “W pode tailor the offer to the true type” é incorreto, porque `W` **não observa** `θ`. O ponto correto não é esse; o ponto correto é que `W` **não precisa** usar a resposta de `H` para fechar o acordo.

---

## 2. O principal erro: `V_W^{R1}(μ,M)` na nota não está bem agregado

A parte de maioria em R1 para H está boa. O problema está no payoff do `W_i` representativo.

### 2.1. Fórmula correta para H em R1 sob maioria

Com `q = floor(N/2)+1`,

`V_H^{R1}(θ,M) = p_H [ V(θ) - (q-1) β V_W^{R2}(μ,M)] + (1-p_H) α V(θ)`

Como

`V_W^{R2}(μ,M) = p_W (1-α) V_e(μ)`,

segue que

`E[V_H^{R1}(μ,M)] = V_e(μ) Φ_M`

com

`Φ_M = [p_H + (1-p_H)α] - p_H (q-1) β p_W (1-α)`.

Esse closed form está correto.

### 2.2. Onde a nota erra para W

A nota usa:

`V_W^{R1}(μ,M) = p_W F_1^M(μ) + (1-p_W) β V_W^{R2}(μ,M)`

Isso **não é uma agregação correta** em geral, porque quando `W_i` não é proposer ele **não recebe automaticamente** `β V_W^{R2}`. Ele só recebe isso se for selecionado para a coalizão vencedora do proposer daquele período.

Portanto, é preciso ponderar explicitamente as probabilidades de inclusão na coalizão.

### 2.3. Fórmula correta para `V_W^{R1}(μ,M)` usando a convenção da nota (W inclui H)

Mantendo a convenção da própria nota/base de que, quando um `W_j` propõe, ele inclui `H` e paga a H o equivalente a `αV(θ)`, então ele precisa comprar apenas `q-2` outros W's.

Nesse caso:

- payoff do proposer `W_j`:
  `F_1^M(μ) = (1-α) V_e(μ) - (q-2) β V_W^{R2}(μ,M)`

- payoff esperado de um `W_i` não-proposer:
  - se H propõe: `W_i` é incluído com probabilidade `(q-1)/(N-1)`;
  - se outro W propõe: `W_i` é incluído com probabilidade `(q-2)/(N-2)`.

Logo,

`V_W^{R1}(μ,M) = p_W F_1^M(μ) + p_H ((q-1)/(N-1)) β V_W^{R2}(μ,M) + (N-2)p_W ((q-2)/(N-2)) β V_W^{R2}(μ,M)`

ou seja,

`V_W^{R1}(μ,M) = p_W F_1^M(μ) + [ p_H (q-1)/(N-1) + p_W (q-2) ] β V_W^{R2}(μ,M)`.

Essa é a expressão consistente com a convenção adotada.

### 2.4. Consequência prática

Os números da nota para:

- `τ(M)`,
- `V_W^{R1}(0.5,M)`,
- e toda comparação de entrada `U` vs `M`

**não são confiáveis** como estão.

A comparação de H entre regras sobrevive melhor, porque `E[V_H^{R1}(μ,M)]` estava correto. Mas toda a parte de entry thresholds precisa ser refeita.

---

## 3. Jump em R1: fórmula local correta, interpretação global exagerada

### 3.1. O salto local está correto

Seja `μ_s^{R1}` o cutoff entre agressiva e conservadora em R1. O salto em `V_H^{R1}(θ=0)` é

`Jump_{θ=0}^{R1} = (1-p_H) β p_H (r-1)`.

Então, em termos de payoff esperado,

`Jump^{R1} = (1-μ_s^{R1}) (1-p_H) p_H β (r-1)`.

Essa fórmula está correta.

### 3.2. O erro conceitual

A nota afirma que o jump em R1 é “proporcional a `p_H(1-p_H)`” e por isso hump-shaped com pico em `1/2`.

Isso **só seria literalmente verdade** se `μ_s^{R1}` fosse constante em `p_H`.

Mas a própria nota sustenta que `μ_s^{R1}` é crescente em `p_H`. Logo, o termo `(1-μ_s^{R1})` **não é constante**.

Portanto, a afirmação correta é:

- **com `μ_s^{R1}` fixado**, o componente mecânico do salto é proporcional a `p_H(1-p_H)`;
- **no modelo completo**, o jump exato é
  `J(p_H) = (1-μ_s^{R1}(p_H)) (1-p_H)p_H β(r-1)`
  e não há razão algébrica imediata para dizer que o pico ocorre exatamente em `p_H=1/2`.

### 3.3. O que sobrevive numericamente

Nos dois exemplos da nota, o jump exato continua hump-shaped, mas o pico ocorre **antes** de `1/2` porque `μ_s^{R1}` sobe com `p_H`.

Valores aproximados calculados a partir das fórmulas analíticas:

#### Exemplo 1 (`N=5, β=0.9, r=1.1, α=0.5`)

- `p_H=0.2`: `μ_s^{R1}≈0.1020`, jump `≈0.0129`
- `p_H=0.3`: `μ_s^{R1}≈0.1525`, jump `≈0.0160`
- `p_H=0.4`: `μ_s^{R1}≈0.2019`, jump `≈0.0172`
- `p_H=0.5`: `μ_s^{R1}≈0.2495`, jump `≈0.0169`
- `p_H=0.6`: `μ_s^{R1}≈0.2950`, jump `≈0.0152`

#### Exemplo 2 (`N=5, β=0.9, r=1.5, α=0.3`)

- `p_H=0.2`: `μ_s^{R1}≈0.1970`, jump `≈0.0578`
- `p_H=0.3`: `μ_s^{R1}≈0.2997`, jump `≈0.0662`
- `p_H=0.4`: `μ_s^{R1}≈0.3984`, jump `≈0.0650`
- `p_H=0.5`: `μ_s^{R1}≈0.4876`, jump `≈0.0576`
- `p_H=0.6`: `μ_s^{R1}≈0.5638`, jump `≈0.0471`

Então o claim correto é: **nos exemplos, o jump total em R1 é hump-shaped**, mas **não** porque seja exatamente uma parábola em `p_H`.

---

## 4. `μ_s^{R1}` crescente em `p_H`: a intuição está boa, a prova da nota não basta

A nota diz que `μ_s^{R1}` cresce com `p_H`. Isso bate com os números e com a lógica econômica. Mas, como prova, ela está incompleta.

### 4.1. O ponto importante

No branch relevante dos exemplos (`μ_s^{R1} > μ_s^{R2}`), a diferença

`Δ(μ,p_H) = F_1^{agg}(μ) - F_1^{con}(μ)`

satisfaz

`∂Δ/∂p_H = β (1-μ)(r-1) [Nμ + N - 2μ - 1]/(N-1) > 0`  para todo `μ<1`.

Ou seja: **para qualquer μ fixo**, aumentar `p_H` torna a estratégia agressiva relativamente mais atraente.

Se, além disso, você tem um único crossing interior, o cutoff necessariamente se desloca para a direita.

### 4.2. O que falta para virar prova limpa

Faltam duas coisas:

1. explicitar em que branch a raiz está sendo estudada;
2. garantir unicidade do crossing relevante.

Sem isso, a frase “`μ_s^{R1}` é crescente em `p_H`” está certa nos exemplos, mas não totalmente demonstrada como proposição geral.

### 4.3. O que dá para escrever com segurança

Algo como:

> In the relevant branch for the parameterizations considered here, `F_1^{agg} - F_1^{con}` has increasing differences in `(p_H, -μ)`. Hence the unique interior cutoff `μ_s^{R1}` shifts to the right as `p_H` rises.

Isso é muito mais defensável do que simplesmente afirmar monotonicidade global sem condições.

---

## 5. Consistência numérica: o que confere e o que não confere

### Confere

- Tabelas de `μ_s^{R1}`: os números reportados estão muito próximos dos valores obtidos pelas fórmulas.
- `E[V_H^{R1}(μ,M)]` sob maioria: os valores batem com o closed form `Φ_M`.
- A direção qualitativa “mais bias → cutoff maior em R1” bate nos exemplos.

### Não confere / não é confiável

- tabela de `Jump_R1` apresentada como se decorresse da parábola `p_H(1-p_H)`;
- uso de `μ_s^{R2}` como proxy para `μ_s^{R1}` no código de jump;
- fórmulas e tabelas de `V_W^{R1}(μ,M)`;
- thresholds `τ(M)` e comparações de entrada baseadas nisso;
- conclusões quantitativas sobre “entry is the binding constraint” quando dependem dessas contas de maioria.

---

## 6. Minha recomendação editorial

### Você pode manter

1. a extensão como ideia substantiva;
2. a ausência de screening sob maioria;
3. o closed form de `Φ_M` para `E[V_H^{R1}(μ,M)]`;
4. o fato de que o custo incremental da oferta conservadora em R1 é `β p_H (r-1)`;
5. a conclusão numérica de que, nos exemplos, `μ_s^{R1}` sobe com `p_H` e o jump total em R1 é hump-shaped.

### Você deve corrigir antes de usar em paper

1. a derivação de `V_W^{R1}(μ,M)`;
2. toda a parte de threshold de entrada sob maioria;
3. a redação do resultado hump-shaped, trocando “exactly proportional” por algo condicional/numerical;
4. a “prova” da monotonicidade de `μ_s^{R1}` em `p_H`.

---

## 7. Formulações seguras para o paper

### Claim seguro sobre R1 jump

> The local size of the R1 jump induced by switching from aggressive to conservative offers is `(1-p_H) β p_H (r-1)` for the low type, so holding the cutoff fixed the mechanical component is hump-shaped in `p_H`. Since the cutoff `μ_s^{R1}` itself rises with `p_H`, the exact total jump is not literally quadratic in `p_H`; in our numerical examples, however, it remains hump-shaped.

### Claim seguro sobre monotonicidade do cutoff

> In the relevant branch of the model, the payoff difference `F_1^{agg} - F_1^{con}` shifts upward with `p_H` for every fixed `μ<1`, implying that the unique interior cutoff moves rightward as proposal bias in favor of H increases.

---

## Bottom line

Você **não vai passar vergonha** se usar a extensão **depois** destas correções:

- maioria sem screening: **sim, está certa**;
- `Φ_M`: **sim, está certo**;
- `gap = β p_H(r-1)` em R1: **sim, está certo**;
- `jump R1 é exatamente parabólico em p_H`: **não, isso está forte demais**;
- `μ_s^{R1}` crescente em `p_H`: **provavelmente sim, mas a prova precisa ser fechada melhor**;
- thresholds de entrada sob maioria como estão na nota: **não confie neles**.
