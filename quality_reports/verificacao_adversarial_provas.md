# Verificação adversarial das provas

**Arquivo auditado:** `formal_model_v5(1).Rmd` disponível na sessão.  
**Foco:** consistência formal das demonstrações, não estilo geral do paper.  
**Veredito curto:** o núcleo matemático está majoritariamente correto, mas há alguns pontos que um parecerista formalista poderia atacar. Os problemas não parecem destruir o resultado central, desde que você faça ajustes de escopo, seleção em fronteiras e implementação de PBE.

---

## 1. Problema moderado: No-Cheap-H é fraco para dominância, mas a seleção majoritária precisa de uma regra de desempate

### Onde aparece

- Proposição de maioria: linhas aproximadas 196--214.
- Prova: linhas aproximadas 798--820.
- Tie-break contra `H`: linhas aproximadas 123--127.

### Diagnóstico adversarial

A Proposição de maioria prova corretamente que o caminho sem `H` **domina fracamente** propostas majoritárias que incluem `H` quando

\[
a_0^M \geq c_M=\frac{\beta}{m}.
\]

O problema é a fronteira \(a_0^M=c_M\). Na prova, a proposta low-only que inclui `H` empata com a proposta sem `H` em \(\mu=0\). Como a Definition 2 diz que empates entre propostas payoff-maximizing são resolvidos minimizando o payoff esperado de `H`, um parecerista pode perguntar se, na fronteira, o modelo seleciona a proposta que inclui `H`, não o caminho sem `H`.

Isso importa porque o paper depois usa

\[
V_W^M(\mu)=\frac{1}{m}
\]

como payoff representativo de entrada sob maioria. Esse valor é o payoff total fraco do caminho sem `H`. Se uma proposta majoritária empatada que inclui `H` fosse selecionada em uma fronteira, o payoff total fraco poderia ser menor, mesmo que o payoff do propositor fosse igual.

### Avaliação

Não é um problema na calibração, porque o exemplo tem margem estrita: \(a_0^M=0.171>0.075=\beta/m\). Mas é uma vulnerabilidade formal no enunciado geral.

### Fix recomendado

Use uma distinção explícita entre:

1. **No-Cheap-H fraco**, que entrega dominância fraca do caminho sem `H`:

\[
a_0^M\geq\frac{\beta}{m};
\]

2. **No-Cheap-H estrito**, que entrega seleção única do caminho sem `H`:

\[
a_0^M>\frac{\beta}{m}.
\]

### Patch sugerido

Substitua o trecho principal da Proposição de maioria por algo como:

```latex
Under the Majority Threshold Order, the no-\(H\) majority path weakly dominates all
\(H\)-including majority proposals for every belief if and only if
\[
a_0^M\geq\frac{\beta}{m}.
\]
If the inequality is strict, the selected majority path excludes \(H\) for every belief,
so majority produces no screening of \(H\),
\[
V_W^M(\mu)=\frac{1}{m},
\qquad
V_H^M(\mu)=(1-\mu)o_0+\mu o_1.
\]
At the knife-edge \(a_0^M=\beta/m\), the no-\(H\) path remains weak-proposer optimal;
the paper selects the no-\(H\) benchmark at this boundary. All substantive comparative
claims below use either the strict condition or this no-\(H\) boundary selection.
```

Alternativa mais limpa: restrinja o tie-break contra `H` à comparação dos candidatos de unanimidade `P,L,R`, e defina separadamente que, em empates majoritários, o benchmark seleciona o caminho sem `H`.

---

## 2. Problema moderado: a Proposição R1 prova comparação de candidatos, mas precisa deixar mais explícita a implementação como PBE

### Onde aparece

- Definição da weak-vote-passive assessment: linhas aproximadas 123--129.
- Candidatos `P,L,R`: linhas aproximadas 322--357.
- Proposição R1: linhas aproximadas 389--397.
- Prova da Proposição R1: linhas aproximadas 856--885.

### Diagnóstico adversarial

A prova faz bem a comparação de payoff do propositor entre `P`, `L` e `R`. O ponto vulnerável é o salto de:

> “nenhum outro candidato dá payoff maior ao propositor”

para:

> “o resultado selecionado é um PBE puro sob a assessment.”

Em um paper formal de alto nível, um parecerista pode exigir a especificação completa do profile de estratégias e crenças que implementa cada candidato selecionado: ações de `H`, ações dos weak voters, crenças após desvios de `H`, crenças após desvios weak, e racionalidade sequencial em cada subgame relevante.

O texto já contém quase todos os ingredientes. O fix é mais de apresentação formal do que de matemática.

### Fix recomendado

Adicione uma lemma curta antes da Proposição R1:

```latex
\begin{lemma}[Candidate implementation]\label{lem:candidate-implementation}
For every \(K\in\mathcal K(\mu)\), candidate \(K\in\{P,L,R\}\) is implementable by a
pure-strategy assessment satisfying Definition \ref{def:passive}. In each candidate,
responders' prescribed votes are sequentially rational at the stated transfers and thresholds,
on-path beliefs follow Bayes' rule, and off-path weak-vote deviations are evaluated according
to the weak-vote-passive assessment.
\end{lemma}
```

Depois prove em três blocos: pooling, low-only e rejection.

### Patch de prova sugerido

Para `P`:

```latex
For \(P\), both types of \(H\) vote yes. If a weak voter deviates to no, the proposal fails,
\(H\)'s yes vote pools types, and Definition \ref{def:passive} keeps posterior \(\mu\).
Thus payment \(c(\mu)\) makes every non-proposing weak voter willing to approve. The high
type is indifferent at \(a_1\); the low type accepts by the R1 Dynamic Threshold Order.
```

Para `L`:

```latex
For \(L\), the low type of \(H\) votes yes and the high type votes no. A no vote by \(H\)
pins down posterior one; a yes vote pins down posterior zero. For \(\mu<1\), a non-proposing
weak voter's approval constraint is
\[
(1-\mu)x+\mu c(1)\geq (1-\mu)c(0)+\mu c(1),
\]
so the minimal payment is \(x=c(0)\). At \(\mu=1\), the same formula is interpreted by
continuity and \(L\) is payoff-equivalent to its high-state rejection branch.
```

Para `R`:

```latex
For \(R\), at least one non-proposing weak voter is prescribed to reject because its allocation
is below its continuation value. If \(m>2\), any unilateral weak-voter deviation leaves another
weak rejection in place, so the proposal still fails and the posterior remains \(\mu\). If \(m=2\),
a unilateral weak-voter deviation can make weak approval unanimous; if the proposal then passes,
the deviator receives zero, and if it fails, the deviator receives a continuation value no larger
than \(c(\mu)\). Hence rejection is sequentially rational for the underpaid weak voter.
```

Esse bloco fecha a lacuna entre “candidate comparison” e “PBE implementation”.

---

## 3. Problema moderado: o rejected-history lemma deve tratar explicitamente o caso `m=2`

### Onde aparece

- Lemma de rejected histories: linhas aproximadas 384--387.
- Prova: linhas aproximadas 841--854.
- Prova de `R`: linhas aproximadas 878--880.

### Diagnóstico adversarial

A prova diz que, em uma proposta desenhada para falhar por rejeição weak, o voto de `H` é não pivotal e não informa. Isso é correto no caminho prescrito. Mas em uma checagem de one-shot deviation, se houver apenas um weak voter não propositor, isto é, quando \(m=2\) e \(N=3\), uma única mudança desse voter de “no” para “yes” pode remover a causa weak da falha. A prova menciona esse caso de forma rápida, mas deveria incorporá-lo ao lemma, porque o modelo permite \(N\geq3\).

### Fix recomendado

Adicione ao final da prova do rejection candidate:

```latex
The edge case \(m=2\) requires one additional check. There is then only one non-proposing
weak voter. If that voter deviates from no to yes, either the proposal still fails because \(H\)
votes no, or it passes because \(H\) votes yes. In the passing case the deviator receives zero,
which is weakly below \(c(\mu)\). In the failing case, the continuation payoff is at most the
relevant Round-2 continuation value. Since \(p_2(\mu)\geq p_2(1)\), we have \(c(\mu)\geq c(1)\),
so the deviation cannot strictly improve on the prescribed rejection payoff. Thus \(R\) is also
sequentially rational in the minimal weak-coalition case.
```

Essa adição evita que o parecerista diga que o proof silently assumes \(m>2\).

---

## 4. Problema pequeno, mas formal: a equivalência `x >= c(0)` no candidato `L` precisa ressalvar endpoints

### Onde aparece

- Candidato `L`: linhas aproximadas 331--337.
- Prova do candidato `L`: linhas aproximadas 868--876.

### Diagnóstico adversarial

A prova escreve:

\[
(1-\mu)x+\mu c(1)\geq(1-\mu)c(0)+\mu c(1),
\]

que é equivalente a \(x\geq c(0)\) quando \(\mu<1\). Em \(\mu=1\), o termo \(1-\mu\) desaparece, então qualquer \(x\) satisfaz a desigualdade. Isso não muda o resultado, porque o estado baixo tem probabilidade zero e `L` se torna payoff-equivalente à rejeição no ramo alto. Mas vale explicitar.

### Fix recomendado

Troque a frase “which is equivalent to \(x\geq c(0)\)” por:

```latex
For \(\mu<1\), this is equivalent to \(x\geq c(0)\). At \(\mu=1\), the low-state
approval constraint is vacuous; the expression for \(\Pi_L^U\) is understood as the limiting
payoff and is payoff-equivalent to the high-state rejection continuation.
```

---

## 5. Problema de escopo: a comparação de `H` deve carregar explicitamente No-Cheap-H e a seleção majoritária

### Onde aparece

- Payoff de maioria de `H`: linhas aproximadas 207--210.
- Definição de \(\Delta_H\): linhas aproximadas 490--518.
- Proposição de comparação de `H`: linhas aproximadas 520--523.
- Corolário de classificação: linhas aproximadas 525--550.

### Diagnóstico adversarial

A comparação de `H` é tautologicamente correta quando \(V_H^M\) e \(V_H^U\) são os payoffs selecionados sob as regras correspondentes. Mas a fórmula substantiva usada para maioria,

\[
V_H^M(\mu)=(1-\mu)o_0+\mu o_1,
\]

depende do caminho majoritário sem `H`, que por sua vez depende de No-Cheap-H e da regra de seleção nos empates.

### Fix recomendado

Reforce o enunciado da Proposição 4:

```latex
Under No-Cheap-H, the selected no-\(H\) majority benchmark, and the maintained unanimity
assessment, on beliefs where both institutions form, \(H\)'s ranking is determined by the sign
of \(\Delta_H(\mu)\).
```

E no corolário:

```latex
Under the conditions of Propositions \ref{prop:majority}, \ref{prop:r1}, and \ref{prop:nesting},
with the selected no-\(H\) majority benchmark, the following five sets form a mutually exclusive
and exhaustive partition of \([0,1]\).
```

Isso evita que o leitor aplique a classificação fora do domínio em que a fórmula de maioria foi provada.

---

## 6. Claim-proof mismatch pequeno: “only majority forms, majority is better” não é provado sob os payoffs atuais

### Onde aparece

- Introdução, linha aproximada 62.
- Classificação formal: linhas aproximadas 525--550.

### Diagnóstico adversarial

A introdução diz que, se apenas a maioria forma, “majority is better”. Mas a classificação formal só diz que apenas a maioria forma. No baseline atual, quando maioria passa sem `H`, `H` recebe o payoff externo \(o_\theta\). Se unanimidade não forma e não há instituição, parece natural que `H` também receba o payoff externo \(o_\theta\). Nesse caso, `H` não estritamente prefere maioria; ele é payoff-equivalente entre majority-with-exclusion e no institution, salvo se você adicionar um benefício de existência institucional para `H`.

### Fix recomendado

Troque a frase da introdução por:

```latex
If only majority forms, majority is the only viable institutional arrangement; under the baseline
no-\(H\) majority payoff, \(H\)'s payoff is its external payoff unless an additional benefit from
institutional existence is introduced.
```

Ou, se você quer manter “majority is better”, acrescente uma definição explícita de payoff de fallback quando a regra não forma e mostre que ele é menor que \(V_H^M\). Sem isso, o claim é mais forte do que a prova.

---

## 7. Problema editorial-formal: tag de equação duplicada

### Onde aparece

Há duas equações marcadas como `\tag{14}`:

- valor selecionado do propositor em R1, linha aproximada 393;
- payoff fraco total sob pooling, linha aproximada 447.

### Por que importa

Não altera a matemática, mas em um paper formal gera confusão de referência e parece descuido de prova.

### Fix recomendado

Renumerar os payoffs totais de entrada como, por exemplo:

```latex
\tag{15}
\tag{16}
\tag{17}
```

ou, melhor ainda, remover tags manuais e usar labels automáticos:

```latex
\begin{equation}\label{eq:r1-selected-value}
...
\end{equation}
```

---

## O que parece sólido

1. **Álgebra da maioria.** A expressão da diferença em relação ao caminho sem `H`,
   \[
   c_M-a_0^M+\mu(a_0^M+kc_M-1),
   \]
   está correta. O argumento por endpoints funciona porque a expressão é afim em \(\mu\).

2. **Lema terminal de unanimidade.** A comparação entre
   \[
   (1-\mu)(1-t_0)
   \quad\text{e}\quad
   1-t_1
   \]
   e o cutoff
   \[
   \mu_2^*=\frac{t_1-t_0}{1-t_0}
   \]
   está correta.

3. **Nesting de entrada.** Dado que a seleção majoritária é o caminho sem `H`, a prova de
   \[
   V_W^U(\mu)\leq V_W^M(\mu)=\frac{1}{m}
   \]
   é válida: cada candidato de unanimidade entrega payoff fraco total no máximo igual a 1.

4. **Comparação condicional de `H`.** A Proposição de comparação é correta como identidade de payoff, desde que o domínio de validade de \(V_H^M\) esteja explícito.

5. **Ilustração numérica.** Os valores principais são consistentes:
   \[
   \mu_2^*\approx0.117,
   \quad
   a_0(1)=a_1\approx0.257,
   \quad
   V_W^U\approx0.062,
   \quad
   V_W^M\approx0.083,
   \quad
   \Delta_H(\mu)\approx0.0665-0.095\mu.
   \]

---

## Ordem recomendada de implementação

1. **Primeiro**, resolver o problema de escopo/seleção da Proposição de maioria: strict No-Cheap-H ou boundary selection explícita.
2. **Segundo**, adicionar a lemma de implementação dos candidatos `P,L,R`.
3. **Terceiro**, fortalecer o tratamento do rejection candidate no caso \(m=2\).
4. **Quarto**, ajustar endpoints em `L`.
5. **Quinto**, reforçar o domínio da Proposição de comparação de `H` e do Corolário.
6. **Sexto**, corrigir a frase “only majority forms, majority is better”.
7. **Sétimo**, corrigir tags duplicadas.

---

## Formulação curta para orientar um agente de edição

> Audit and patch the proof architecture without changing the model. Strengthen the majority result by distinguishing weak dominance from selected no-H majority behavior, especially at the No-Cheap-H boundary. Add a candidate-implementation lemma for P, L, and R under the weak-vote-passive assessment. Explicitly handle the m=2 edge case in no-information rejection. Add endpoint language for the low-only weak-voter IC. Scope the hegemon comparison and classification to No-Cheap-H and the selected no-H majority benchmark. Remove or qualify the statement that majority is strictly better when only majority forms. Fix duplicate equation tag (14).

