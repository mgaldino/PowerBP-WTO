# Revisão final da nota técnica `2026-04-20_extension_proposal_bias(1).md`

## Veredito

A nova versão está **substancialmente melhor** que a anterior. O erro mais sério da versão passada — a agregação incorreta de `V_W^{R1}(μ,M)` sob maioria — foi corrigido. O núcleo formal da extensão agora está em boa forma.

Ainda assim, eu **não usaria a nota exatamente como está** em texto de paper. O que resta não é mais um problema de álgebra central, mas sim de:

1. **formulação excessivamente forte de alguns claims**;
2. **mistura entre objetos conceituais distintos** (`v`, `cav(v)`, BP condicional vs BP total);
3. **exposição ainda exploratória demais em algumas passagens de maioria em R1**.

Em termos práticos: a extensão está **quase pronta**, mas ainda precisa de uma última rodada de limpeza para não deixar flancos para parecerista.

---

## 1. O que eu considero agora correto e defensável

### 1.1. R2 sob unanimidade com bias

Está correto:

- `V_H^{R2}(1,μ,U) = r[p_H + (1-p_H)α]`
- `V_H^{R2}(0,μ<μ_s,U) = p_H + (1-p_H)α`
- `V_H^{R2}(0,μ>μ_s,U) = p_H + (1-p_H)αr`
- `V_W^{R2}(μ<μ_s,U) = p_W(1-μ)(1-α)`
- `V_W^{R2}(μ>μ_s,U) = p_W(V_e(μ)-αr)`

com `p_W=(1-p_H)/(N-1)`.

O jump terminal em R2 também está correto:

`Jump^{R2} = (1-μ_s)(1-p_H)α(r-1)`.

### 1.2. R1 sob unanimidade: estrutura do screening

A lógica principal está correta.

Em particular, o gap entre ofertas é mesmo:

`y_H^{con} - y_H^{agg} = β p_H (r-1)`.

Isso é um resultado limpo e importante da extensão: **o custo marginal do pooling em R1 cresce com o proposal bias pró-H**.

### 1.3. R2 sob maioria: ausência de screening

Correto. A intuição também está bem melhor formulada agora.

O ponto certo é:

- sob maioria, `W` não precisa do voto de `H` para aprovar a proposta;
- portanto, a resposta de `H` não é payoff-relevant para `W`;
- logo, não emerge o problema de screening/pooling que existe sob unanimidade.

### 1.4. R1 sob maioria: payoff de H

A derivação de `V_H^{R1}(θ,M)` está correta, e o closed form

`E[V_H^{R1}(μ,M)] = V_e(μ) Φ_M`

com

`Φ_M = [p_H + (1-p_H)α] - p_H(q-1)β p_W(1-α)`

está certo.

### 1.5. R1 sob maioria: payoff de W

Esta foi a correção decisiva da nova versão, e ela está boa.

Com a convenção da nota de que `W_j` inclui `H` WLOG, o payoff esperado do `W_i` não-proposer depende da probabilidade de entrar na coalizão vencedora, e o coeficiente correto é

`κ = p_H (q-1)/(N-1) + p_W (q-2) = (q-2+p_H)/(N-1)`.

A partir daí, a simplificação para

`V_W^{R1}(μ,M) = p_W(1-α)V_e(μ)
\left[1 + β p_H (q-1)/(N-1)\right]`

está consistente.

Essa parte agora está bem melhor do que antes.

---

## 2. O principal problema remanescente: “BP = 0 sob maioria” está errado no modelo completo

No trecho em que a nota conclui a derivação de maioria em R1, aparece a ideia de que, como `E[V_H^{R1}(μ,M)]` é linear em `μ`, então “BP = 0 sob maioria”.

Isso, formulado assim, está **errado**.

### 2.1. O que é verdade

É verdade que:

- **não há BP via screening sob maioria**;
- a continuação `E[V_H^{R1}(μ,M)]` é affine em `μ`;
- não existe o jump endógeno de screening que aparece sob unanimidade.

### 2.2. O que não é verdade

Não é verdade que isso implique automaticamente que **não há BP nenhum** sob maioria.

Se a entrada é endógena, o objeto relevante é o valor total

`v_M(μ) = 1{V_W^{R1}(μ,M) ≥ c} · E[V_H^{R1}(μ,M)]`.

Mesmo que `E[V_H^{R1}]` seja linear, o indicador de entrada pode gerar uma não-convexidade no valor total via `τ(M)`.

Ou seja:

- **majority may still generate a BP motive through the entry threshold**;
- o que majority **não** gera é **screening-based BP**.

### 2.3. Como eu reescreveria

Trocar por algo como:

> Under majority, there is no screening-based BP channel. Since continuation values are affine in beliefs, any residual BP motive can arise only through the entry threshold, not through a jump in continuation payoffs.

Essa formulação está correta e fecha a porta para objeção fácil.

---

## 3. Segundo problema remanescente: a comparação “cav_U vs v_M” não é a comparação final entre regras

Na seção numérica, a nota diz algo como “H sempre prefere U sobre M” e apresenta uma tabela comparando:

- `cav_U(p)`
- `v_M(p)`

Isso é conceitualmente perigoso.

### 3.1. Por quê

Se a pergunta é “qual regra H prefere quando pode usar Bayesian persuasion?”, então os objetos corretos são:

- `cav(v_U)(p)`
- `cav(v_M)(p)`

não `cav(v_U)(p)` contra `v_M(p)`.

Comparar `cav(v_U)` com `v_M` subestima `M` sempre que houver qualquer ganho de concavificação em majority via entry threshold.

### 3.2. Quando isso talvez não importe

Pode ser que, para os parâmetros e para `p=0.5`, você tenha de fato:

`cav(v_M)(p) = v_M(p)`.

Mas isso precisa ser **mostrado**, não presumido.

### 3.3. Como eu reescreveria

Em vez de afirmar

> H always prefers U over M

eu escreveria algo como:

> For the parameter values considered here, `cav(v_U)(p)` exceeds `v_M(p)` at `p=0.5`. Since majority has no screening-based non-convexity, this suggests that the incremental value of persuasion under unanimity dominates in these examples. A full rule comparison should compare `cav(v_U)` and `cav(v_M)` directly.

Se você puder computar `cav(v_M)` e confirmar que coincide com `v_M` nos pontos reportados, aí sim dá para endurecer o texto.

---

## 4. O resultado hump-shaped agora está quase certo, mas ainda deve ser formulado com cuidado cirúrgico

A nova versão melhorou bastante esse ponto. Ela já não afirma mais que o jump total é literalmente uma parábola em `p_H`, o que é ótimo.

### 4.1. O que está certo agora

Está correto dizer que:

- o **salto local** em `V_H^{R1}(θ=0)` é
  `(1-p_H)p_H β(r-1)`;
- com `μ_s^{R1}` fixo, isso geraria um formato parabólico;
- como `μ_s^{R1}` sobe com `p_H`, o jump total
  
  `Jump^{R1}(p_H) = (1-μ_s^{R1}(p_H))(1-p_H)p_Hβ(r-1)`
  
  não é exatamente quadrático;
- nos exemplos, o total continua hump-shaped e o pico vai para a esquerda.

### 4.2. O que eu ainda ajustaria

Na redação final, eu evitaria qualquer frase que soe como teorema geral sobre o formato global do jump sem prova formal.

A formulação segura é:

> In the numerical examples, the total R1 jump is hump-shaped in `p_H`: the local gap effect initially dominates, but at higher values of `p_H` the lower frequency of W proposals and the rightward shift in the cutoff reduce the total jump.

Isso é elegante e à prova de crítica.

---

## 5. A monotonicidade de `μ_s^{R1}` em `p_H` está bem encaminhada, mas ainda não é uma prova completa

A nova versão melhorou esse ponto ao dizer explicitamente que o argumento é **parcial** e depende do branch relevante. Isso foi uma boa correção.

### 5.1. O que está convincente

A nota diz, corretamente, que no branch relevante dos exemplos,

`Δ(μ,p_H) = F_1^{agg}(μ,p_H) - F_1^{con}(μ,p_H)`

satisfaz

`∂Δ/∂p_H > 0` para `μ < 1`.

Esse é o objeto certo para olhar.

### 5.2. O que ainda falta para teorema geral

Ainda faltam:

1. explicitar formalmente o branch em que a raiz está;
2. mostrar unicidade do crossing relevante nesse branch;
3. excluir trocas de branch quando `p_H` varia, se quiser uma afirmação global.

### 5.3. Minha recomendação

Deixar isso como:

> In the relevant branch for the parameterizations considered here, `F_1^{agg} - F_1^{con}` shifts upward with `p_H`, implying a rightward shift in the unique interior cutoff.

Perfeito para uma nota técnica ou remark. Ainda não é teorema geral de paper.

---

## 6. A parte numérica está muito melhor, mas eu não deixaria duas inconsistências de apresentação passarem

### 6.1. O código ainda contém blocos “exploratórios” demais

No código de maioria para `EVH_R1_M`, ainda há comentários do tipo:

- “Wait, this double-counts”
- “Let me redo”

Isso é bom para working notes, mas eu limparia se a nota for circular.

### 6.2. A seção de jump ainda exibe um bloco antigo com proxy por `μ_s^{R2}`

Mesmo que a seção de resultados já reporte o jump exato usando `μ_s^{R1}`, o bloco de código anterior ainda mostra uma tabela de `Jump_R1*` com proxy em `μ_s^{R2}`.

Isso não está “errado” se marcado como proxy, mas eu removeria. Ele só cria ruído, porque a nota já avançou para a versão correta do resultado.

---

## 7. Minha leitura sobre o que já pode entrar no paper

### Pode entrar, com confiança

1. O resultado de que **majority eliminates screening**.
2. O resultado de que o **gap relevante em R1 cresce com** `p_H`.
3. O closed form de `Φ_M`.
4. O fato de que, **nos exemplos**, `μ_s^{R1}` sobe com `p_H`.
5. O fato de que, **nos exemplos**, o jump total em R1 é hump-shaped e atinge máximos para `p_H` intermediário.

### Eu ainda não colocaria do jeito que está

1. “BP = 0 sob maioria.”
2. “H sempre prefere U sobre M” com base em `cav_U` vs `v_M`.
3. qualquer frase que soe como teorema geral do hump-shape do jump total.
4. qualquer frase que soe como prova global de monotonicidade de `μ_s^{R1}`.

---

## 8. Formulações seguras para substituir no texto

### Sobre maioria e BP

> Under majority, continuation values are affine in beliefs and there is no screening-based jump. Hence majority does not generate a persuasion motive through screening; any residual persuasion value can only come from the entry threshold.

### Sobre a comparação entre regras

> In the examples, the concavified value under unanimity exceeds the raw majority value at moderate priors. A full institutional comparison, however, should compare the concavified value functions under both rules.

### Sobre hump-shape

> Holding the cutoff fixed, the local R1 jump scales with `p_H(1-p_H)`. In the full model, because the cutoff itself moves with `p_H`, the total jump is not literally quadratic; in our numerical examples it remains hump-shaped, with the peak shifted left of `1/2`.

### Sobre o cutoff

> In the relevant branch of the model, `F_1^{agg} - F_1^{con}` shifts upward with `p_H`, implying that the unique interior cutoff moves rightward in the numerical parameterizations we study.

---

## 9. Bottom line

Se eu fosse seu coautor, minha recomendação seria:

- **sim**, manter a extensão;
- **sim**, tratar esta versão como a primeira realmente boa;
- **não**, ainda não chamar de fechada;
- **sim**, fazer uma última limpeza antes de confiar plenamente.

### Em uma frase

A nova nota **já não tem um erro formal grave aparente**, mas ainda tem **duas fragilidades conceituais** que um parecerista atento pode explorar:

1. confundir ausência de screening com ausência total de BP sob maioria;
2. comparar `cav(v_U)` com `v_M` como se isso resolvesse a escolha institucional.

Corrigidos esses pontos, eu ficaria confortável em dizer que você não está correndo risco de passar vergonha com essa extensão.
