# Parecer de Apresentacao Tecnica (Thomson / Board)

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: formal_model_v3.Rmd
**Data**: 2026-04-26
**Avaliador**: Senior theorist, Thomson (1999) / Board & Meyer-ter-Vehn (2018) framework
**Dimensoes**: D2--D9 (apresentacao tecnica de modelo formal)

---

## Score: 7.5 / 10

O manuscrito esta acima da media de submissoes a journals de CP/RI em termos de apresentacao tecnica, com uma estrutura clara de "body narra, appendix prova" que segue o estilo JoP. A notacao e parcimoniosa e quase sempre mnemoica. A principal fraqueza e uma carga de simbolos auxiliares no appendix que nao sao absorvidos intuitivamente, e um desbalanceio entre o corpo (muito limpo) e o appendix (denso, com ratio linguagem natural / matematica abaixo do recomendado por Thomson). Algumas definicoes formais e o inventario de resultados poderiam ser mais cuidadosos em formato.

---

## Estrutura do modelo

**Jogadores**: 1 hegemon H + N-1 weak states W_i, N >= 3. **Acoes**: H escolhe R in {M, U} e signal pi; W's decidem entry; bargaining (propose/accept/reject) em 2 rounds Baron-Ferejohn. **Informacao**: H observa theta in {0,1}, W's observam signal realization s (public). **Preferencias**: H recebe share do pie V(theta) in {1,r}; outside option alpha V(theta); W's have outside option 0, entry cost c. **Timing**: Stage 0 (institutional choice) -> Stage 1 (BP + entry) -> Stage 2 (bargaining, 2 rounds, random proposer, discount beta). **Equilibrio**: PBE com tie-breaking H aceita quando indiferente.

---

## Scorecard

| Dimensao | Veredicto | Comentario |
|----------|-----------|------------|
| D2. Apresentacao do modelo | Adequado | Ordem canonica respeitada; parsimonia boa; um modelo, nao dois; mas "Preview of main result" entre model e results cria secao hibrida |
| D3. Notacao (Thomson S.3) | Adequado | Mnemonicas boas (V, alpha, mu, R); mas phi, omega, lambda_M, kappa_M sao opacos; x = (N-1)alpha r definido mas pouco usado no corpo |
| D4. Definicoes (Thomson S.4) | Precisa melhorar | Definition 1 e bem feita mas e a unica definicao formal; "net gain" v(mu,R) e "screening cutoff" nao recebem destaque tipografico; faltam exemplos ilustrativos para definicoes |
| D5. Enunciados (Board) | Adequado | Sequencia contexto->enunciado->prova->intuicao e consistente; takeaway messages boas; mas Lemma 1 statement mistura condicao e resultado de forma densa |
| D6. Provas (Thomson S.5) | Precisa melhorar | No corpo: adequadas (1-frase proof sketches). No appendix: ratio linguagem natural baixo (~30-40% vs 52-63.5% recomendado); steps sao numerados mas faltam explicacoes informais antes de passos chave |
| D7. Figuras e diagramas | Excelente | Game trees TikZ, screening schematic TikZ, plots R com caption completo; labels completos; figuras pedagogicamente eficazes |
| D8. Assumptions e estrutura logica | Adequado | Assumptions embutidas na Definition 1 (alpha < 1/r, beta in (0,1)); plausibilidade discutida na Scope; mas alpha < alpha* aparece tarde e nao e formalmente uma Assumption |
| D9. Exemplos e aplicacoes | Adequado | Motivating example (Sec 2) e eficaz; Example 1 (magnitudes) bom; Example 2 (p*) bom; mas faltam naming memoravel dos agentes e exemplo geometrico para a concavificacao |

---

## Analise detalhada

### D4. Definicoes -- Precisa melhorar

**Diagnostico**: O manuscrito tem apenas uma definicao formal (Definition 1, o jogo). Conceitos centrais ao argumento -- "net gain function" v(mu,R), "screening cutoff" mu_s^{R1}, "entry threshold" tau(R), "conditional payoff dominance" -- sao introduzidos em prosa corrida sem destaque tipografico. Thomson (1999, Sec. 4) e enfatico: "Be unambiguous when you define a new term. Set the term you define in italics or boldface." Board & Meyer-ter-Vehn (2018) recomendam que definicoes centrais recebam tratamento formal (Definition environment) ou pelo menos italico + tipo do objeto.

**Impacto**: O leitor que busca a definicao precisa de v(mu,R) precisa encontrar a equacao no meio de um paragrafo na Secao 6 (l.416-418). A definicao de alpha* esta embutida no statement do Lemma 1, nao como definicao independente. Isso aumenta a carga cognitiva quando o leitor quer localizar definicoes.

**Sugestao concreta**:
1. Criar uma Definition 2 para v(mu,R) logo antes da Proposition 4, com tipo do objeto explicito ("the function v: (0,1] x {M,U} -> R defined by...").
2. Dar destaque tipografico (italico ou boldface) na primeira ocorrencia de "screening cutoff", "entry threshold", "net gain function".
3. Definir alpha* em definicao propria antes do Lemma 1, ou pelo menos como "Define alpha* = ..." em paragrafo separado antes do enunciado, seguindo a receita Board de "Define p. Define q. Theorem: every p is q."

**Referencia**: Thomson (1999), Sec. 4: "If you need a new term, introduce it formally. [...] The minimal requirement is that the term be set in italics the first time it appears, and that a formal definition be given."

### D6. Provas -- Precisa melhorar

**Diagnostico**: No corpo, a abordagem "See Appendix B.k" e correta para o estilo JoP light-math. O problema esta no appendix. A prova do Lemma 1 (B.5, ~50 linhas) e a derivacao B.5a (~80 linhas) sao densas em algebra com ratio de linguagem natural estimado em 30-40%. Thomson (1999, Sec. 5) documenta que provas de papers publicados em top journals tem 52-63.5% de linguagem natural. Especificamente:

- B.5a Steps 1-3 apresentam algebra sem explicar *antes* o que cada step faz. A frase de abertura de cada step e "Step k: [titulo]", mas falta uma explicacao informal do tipo "The idea is to show that switching from aggressive to conservative R1 changes only the W-proposes component, because..."
- B.5 Steps 2-3 fazem verificacao de endpoint sem antecipar por que endpoints sao suficientes (a afirmacao "affine, so it suffices to check endpoints" aparece, mas sem explicar *por que* D e affine em cada branch -- isso requer que o leitor ja tenha absorvido B.5a).
- A prova de B.8 (Theorem 2) e a mais bem escrita: Parts 1-2 tem boa proporcao de linguagem natural.

**Impacto**: Um referee que tenta verificar Lemma 1 no appendix pode perder o fio condutor. A densidade algebrica aumenta o risco de rejeicao por "hard to follow" mesmo quando a prova esta correta.

**Sugestao concreta**:
1. Antes de cada Step em B.5a, adicionar 1-2 frases informais que expliquem a estrategia ("We now compute the change in H's payoff when W switches from aggressive to conservative R1 offers. Because this switch affects only the W-proposes component, the correction is independent of the R2 regime.").
2. Em B.5 Step 2, antes de "At mu = 1:", adicionar: "Since D_base is affine in mu (it depends on mu only through V_e(mu) = 1 + mu(r-1)), it suffices to verify positivity at the two endpoints mu = 0 and mu = 1."
3. Marcar o QED mais visivelmente em B.5 (o square esta la mas e facil perder no meio do texto).

**Referencia**: Thomson (1999), Sec. 5: "Explain in words what you are doing, and why. A good ratio is 55-60% words, 40-45% math."

### D3. Notacao -- Comentarios adicionais

**Diagnostico parcial**: A notacao do corpo e boa. Os problemas estao nos simbolos auxiliares do appendix:

- phi (Prop 2, eq. 5): definido como [rN - beta(N-1+r)] / [beta(r-1)]. Este simbolo nao e mnemonico e nao carrega intuicao. Thomson: "the best notation is notation that can be guessed."
- omega(mu) (App A.3): definido como (N-2) beta V_W^{R2}(mu). Usado apenas no appendix, mas sem mnemonico. "omega" sugere frequencia ou probabilidade para a maioria dos leitores.
- lambda_M (App B.5/B.8): definido como [N(1+(N-1)alpha) - C_buy] / N^2. Central ao argumento mas opaco.
- kappa_M (App A.7): definido como (1-alpha)[N(N-1)+beta(q-1)] / (N^2(N-1)). Usado uma vez.
- x = (N-1)alpha r (Sec 4, l.102): definido no corpo mas raramente usado la; aparece mais no appendix.

**Impacto**: Moderado. O corpo esta limpo. Mas um referee que verifica provas pode tropecar em phi, omega, lambda_M sem saber a que se referem.

**Sugestao concreta**:
1. Na tabela de notacao (App A), incluir phi, omega, lambda_M, kappa_M com definicoes e locais de uso.
2. Alternativamente, eliminar omega substituindo diretamente (N-2) beta V_W^{R2}(mu) nas expressoes -- e usado poucas vezes.
3. Para phi, considerar renomear para algo mais descritivo ou simplesmente expandir inline, ja que aparece apenas na formula do cutoff.

**Referencia**: Thomson (1999), Sec. 3: "The best notation is notation that can be guessed."

### D8. Assumptions -- Comentario

**Diagnostico**: A condicao alpha < alpha*(N, beta) e central a Lemma 1, Theorem 1 e Theorem 2. No entanto, ela nao e apresentada como uma Assumption formal (environment). Aparece pela primeira vez *dentro* do enunciado do Lemma 1 (l.499-502). Em Board & Meyer-ter-Vehn (2018), condicoes parametricas que restringem o dominio dos resultados devem ser introduzidas como Assumptions nomeadas antes dos resultados que delas dependem, seguindo a regra de plausibilidade decrescente.

**Impacto**: Baixo-moderado. O leitor entende que alpha < alpha* e a condicao relevante. Mas formalmente, a hierarquia logica ficaria mais clara se alpha < alpha* fosse uma Assumption 1 (ou pelo menos um "Maintained condition") definido antes do Lemma.

**Sugestao**: Considerar inserir um "Maintained Condition" ou "Standing Assumption" para alpha < alpha* entre as Secoes 5 e 6, com a interpretacao de que "bilateral alternatives are moderate relative to multilateral cooperation."

---

## Inventario de notacao

| Simbolo | Significado | Introduzido em | Usado em | Problema? |
|---------|-------------|----------------|----------|-----------|
| N | Numero de jogadores | Def. 1 (l.91) | Todo o paper | Nao |
| H | Hegemon | Def. 1 (l.91) | Todo o paper | Nao |
| W, W_i | Weak state(s) | Def. 1 (l.91) | Todo o paper | Nao |
| theta | Estado do mundo {0,1} | Def. 1 (l.92) | Todo o paper | Nao |
| p | Prior Pr(theta=1) | Def. 1 (l.92) | Todo o paper | Nao |
| mu | Posterior Pr(theta=1 given s) | Sec. 3.2 (l.110) | Todo o paper | Nao |
| V(theta) | Valor da cooperacao | Def. 1 (l.93) | Todo o paper | Nao |
| r | V(1), high-type value | Def. 1 (l.93) | Todo o paper | Nao |
| alpha | Outside option share d_H = alpha V(theta) | Def. 1 (l.95) | Todo o paper | Nao |
| beta | Discount factor | Def. 1 (l.96) | Todo o paper | Nao |
| c | Entry cost | Def. 1 (l.97) | Secs 6-8, App | Nao |
| R | Voting rule {M, U} | Def. 1 (l.98) | Todo o paper | Nao |
| q | Majority quota floor(N/2)+1 | Def. 1 (l.98) | Secs 5-8, App | Nao |
| V_e(mu) | Expected coop value 1+mu(r-1) | Sec. 3.1 (l.102) | Todo o paper | Nao |
| x | Shorthand (N-1)alpha r | Sec. 3.1 (l.102) | App A.2-A.4 | Definido no corpo mas usado quase so no appendix |
| pi | Signal structure | Sec. 3.2 (l.110) | Secs 2, 6, Fig 1 | Nao |
| s | Signal realization | Sec. 3.2 (l.110) | Secs 3, 6 | Nao |
| y_H | H's share in offer | Sec. 2 (l.70) | Secs 2, 5 | Nao, informal |
| mu_s^{R1} | R1 screening cutoff | Prop. 2 (l.308) | Secs 5-8, App | Nao |
| mu_s^{R2} | R2 screening cutoff | App A.2 (l.867) | App A.2-B.5 | Nao |
| phi | Auxiliary for cutoff formula | Prop. 2 (l.310) | Prop. 2, App A.3 | Sim: opaco, nao mnemonico |
| alpha_bar | Regime threshold | Prop. 2 (l.313) | Secs 5, 8, App A.5 | Nao |
| alpha* | Iff threshold for Lemma 1 | Lemma 1 (l.501) | Secs 6-8, App | Parcial: definido dentro do enunciado, nao como definicao independente |
| v(mu, R) | Net gain function | Sec. 6 (l.416) | Secs 6-7, App B | Sim: nao recebe Definition environment |
| tau(R) | Entry threshold | Sec. 6 (l.412) | Secs 6-8, App A.7 | Parcial: nao formalmente definida |
| E_U | Entry set under unanimity | Sec. 7 (l.527) | Secs 7, App B | Nao |
| p* | Threshold prior | Thm 2 (l.554) | Secs 7-8 | Nao |
| D(mu) | Payoff difference V_H(U) - V_H(M) | App B.5 (l.1055) | App B.5-B.5a | Nao, appendix only |
| D_base | Baseline payoff diff | App B.5a (l.1030) | App B.5-B.5a | Nao, appendix only |
| delta_R1 | R1 correction | App B.5a (l.1006) | App B.5-B.5a | Nao, appendix only |
| delta_R2 | R2 correction | App B.5a (l.1014) | App B.5-B.5a | Nao, appendix only |
| omega(mu) | (N-2) beta V_W^{R2}(mu) | App A.3 (l.892) | App A.3-A.5 | Sim: opaco, nao mnemonico |
| C_buy | Vote-buying cost beta(q-1)(1-alpha) | App B.5 (l.844) | App B.5-B.8 | Nao, mnemonico |
| C_out | Outside option cost N(N-1)alpha | App B.5 (l.844) | App B.5-B.8 | Nao, mnemonico |
| lambda_M | Majority payoff coefficient | App B.5 (l.1046) | App B.5-B.8 | Parcial: nao na tabela de notacao |
| kappa_M | Majority weak-state coefficient | App A.7 (l.926) | App A.7 | Parcial: usado uma vez |
| S_U, S_M | Max slope of value function | Thm 2/App B.8 | App B.8, fig code | Nao |
| Gamma | Marginal value of uncertainty | Remark 1 (l.519) | Remark 1 | Nao |
| mu_bar | Belief threshold for Remark 1 | Remark 1 (l.520) | Remark 1, Sec 8 | Nao |
| F_1^{con}, F_1^{agg} | Proposer surpluses | App A.3 (l.889) | App A.3-A.5, B.7 | Nao, appendix only |
| Delta_1 | F_1^{agg} - F_1^{con} | App A.3 (l.894) | App A.3, B.2 | Nao, appendix only |
| Pi_H^{prop}, Pi_H^W | Payoff components | App B.5a (l.970, 980) | App B.5a | Nao, appendix only |
| E_bench | Benchmark payoff | App B.5a (l.996) | App B.5a | Nao, appendix only |
| V_W^{R1}, V_W^{R2} | Weak state continuation values | Various | Throughout | Nao |
| V_H^{R1}, V_H^{R2} | Hegemon continuation values | Various | Throughout | Nao |

**Contagem**: ~40 simbolos distintos. Para o corpo: ~22. Para o appendix: ~38 (adicionando auxiliares). Thomson recomenda parcimonia; o corpo esta dentro de limites razoaveis, mas o appendix esta no limite alto.

---

## Analise resultado-a-resultado

### Proposition 1 (Majority produces no screening)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | "Under majority rule..." paragrafo antes |
| Enunciado formal | Sim | Claro: V_H affine, no cutoff |
| Prova | Adequada | "See Appendix B.1" + 3 linhas no appendix |
| Intuicao apos | Sim | Paragrafo explicando exclusion mechanism |
| Implicacoes | Sim | "BP operates only through entry channel" |
| Formato paralelo | N/A | Resultado isolado |
| Takeaway | Claro | Exclusion kills screening |

**Takeaway message**: Majority transforms bargaining into coalition arithmetic where H's vote is irrelevant, so BP has no non-convexity to exploit.

### Proposition 2 (R1 screening cutoff)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | Paragrafo sobre unanimity screening |
| Enunciado formal | Sim | Existencia, unicidade, closed form |
| Prova | Adequada | "See Appendix B.2" com derivacao completa |
| Intuicao apos | Sim | Paragrafo sobre independence from alpha |
| Implicacoes | Implicitas | Conectadas via Prop 3 |
| Formato paralelo | Parcial | Prop 2 define cutoff, Prop 3 define jump -- boa sequencia |
| Takeaway | Claro | Cutoff depends on r, beta, N but not alpha |

**Takeaway message**: The cutoff at which W switches behavior depends on the informativeness of theta, not on H's outside option strength.

**Nota**: O enunciado tem uma condicao (alpha < alpha_bar) e uma footnote longa sobre o caso alpha >= alpha_bar. Board recomendaria colocar a condicao no enunciado principal e o caso alternativo em remark separado, nao em footnote.

### Proposition 3 (Screening creates informational rent)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Implicito | Segue Prop 2 |
| Enunciado formal | Sim | Jump formula com closed form |
| Prova | Adequada | "See Appendix B.3" |
| Intuicao apos | Excelente | Paragrafo sobre r, beta, N interpretation |
| Implicacoes | Via Fig 3 | Screening schematic TikZ |
| Takeaway | Claro | Conservative offers overpay the low type |

**Takeaway message**: At the cutoff, W's switch to conservative behavior creates a discrete rent for H that grows with r, beta, and peaks at intermediate N.

### Example 1 (Magnitudes)

Bem escolhido. Parametros N=5, r=1.5, alpha=0.3, beta=0.9 sao intuitivos. Reporta magnitudes em percentuais (5.3%, 27%, 41%). Segue recomendacao de Board para "numbers that don't distract."

### Proposition 4 (Additional non-convexity)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | Net gain function defined |
| Enunciado formal | Sim | Claro |
| Prova | Adequada | 4 linhas no appendix |
| Intuicao apos | Sim | Via BP discussion |
| Takeaway | Claro | Unanimity has extra non-convexity that majority lacks |

### Lemma 1 (Conditional payoff dominance)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | "conditional on institution forming" |
| Enunciado formal | Denso | alpha* definido inline no enunciado; "if and only if" mistura condicao e resultado |
| Prova | Longa | B.5 + B.5a = ~130 linhas. Correta mas densa |
| Intuicao apos | Sim | 2 paragrafos sobre endpoint argument |
| Implicacoes | Sim | Remark 1 (mu_bar), Corollary |
| Formato paralelo | Precisa melhorar | Definir alpha* antes, depois enunciar |
| Takeaway | Claro | When bilateral alternatives are moderate, unanimity gives H more at every belief |

**Takeaway message**: alpha < alpha* is necessary and sufficient for unanimity to give H a strictly higher payoff at every interior belief, conditional on entry.

**Sugestao Board**: Reescrever como:

> Define alpha*(N, beta) = [formula]. 
>
> Lemma 1. alpha < alpha*(N, beta) if and only if E[V_H(mu, U)] > E[V_H(mu, M)] for every mu in (0,1].

Isso separa definicao de resultado e segue o padrao "Define p. Define q. Theorem: Every p is q."

### Theorem 1 (Dominance of unanimity)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | Secao 7.2 abre com contexto |
| Enunciado formal | Bom | Limpo: "For every p in E_U, Pi*(U,p) > Pi*(M,p)" |
| Prova | Adequada | B.6, ~25 linhas, boa proporcao NL/math |
| Intuicao apos | Sim | "regardless of connected/disconnected" |
| Implicacoes | Sim | Corollary (global dominance) |
| Takeaway | Excelente | "Whenever entry is feasible under unanimity, H strictly prefers it" |

### Corollary 1 (Global dominance)

Bem posicionado. Statement e claro. Segue naturalmente do Theorem 1.

### Theorem 2 (Single-crossing)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | Paragrafo sobre disconnected E_U |
| Enunciado formal | Bom | "upper interval", "p* such that..." |
| Prova | Boa | B.8, ~35 linhas, melhor proporcao NL/math do paper |
| Intuicao apos | Sim | "ranking never oscillates" |
| Implicacoes | Sim | Example 2 (p*) |
| Takeaway | Excelente | "Unanimity dominates above p*, majority below, transition at most once" |

### Example 2 (p*)

Eficaz. Computa p* = 0.24 com os mesmos parametros do Example 1, mostrando magnitudes (22%, 25%). Conecta com Theorem 2. Boa escolha de manter os mesmos parametros ao longo do paper (Board: "use a running example").

### Proposition 5 (K>2 types, App C)

Adequada como extensao. Provas curtas. A claim sobre K-1 screening boundaries e clara.

---

## Sugestoes construtivas (priorizadas por impacto)

### 1. Dar destaque formal a v(mu, R) e alpha*
**Impacto**: Alto. **Esforco**: Baixo.
Criar Definition 2 para v(mu, R) antes da Prop 4. Definir alpha* em paragrafo separado (ou mini-Definition) antes do Lemma 1. Seguir Board: "Define p. Define q. Theorem: Every p is q."
**Referencia**: Board & Meyer-ter-Vehn (2018), Sec. "Definitions and Conventions."

### 2. Aumentar ratio de linguagem natural nas provas do appendix (B.5, B.5a)
**Impacto**: Alto. **Esforco**: Medio.
Adicionar 1-2 frases informais antes de cada Step algebrico. Objetivo: passar de ~35% para ~55% de linguagem natural. Nao adicionar mais algebra -- adicionar mais *explicacao* da algebra existente.
**Referencia**: Thomson (1999), Sec. 5, Table 1 (52-63.5% NL in published proofs).

### 3. Completar a tabela de notacao no Appendix A
**Impacto**: Medio. **Esforco**: Baixo.
Adicionar phi, omega, lambda_M, kappa_M a tabela. Alternativamente, eliminar omega e kappa_M (usados poucas vezes) substituindo inline.
**Referencia**: Thomson (1999), Sec. 3: "Include a table of notation."

### 4. Mover a condicao sobre alpha < alpha_bar (footnote da Prop 2) para Remark
**Impacto**: Medio-baixo. **Esforco**: Baixo.
A footnote da Prop 2 (l.316) e longa e tecnica. Transformar em Remark separado ("When alpha >= alpha_bar, the R1 cutoff depends on alpha but the qualitative mechanism is unchanged").
**Referencia**: Board & Meyer-ter-Vehn (2018): "Don't bury important information in footnotes."

### 5. Considerar "Standing Assumption" para alpha < alpha*
**Impacto**: Medio-baixo. **Esforco**: Baixo.
Inserir entre Secoes 5 e 6: "Standing Assumption: alpha < alpha*(N, beta)." Isto clarifica que Lemma 1, Thm 1, Thm 2 operam sob a mesma condicao, e que a Scope (Sec 8) discute o que acontece fora dela.
**Referencia**: Board & Meyer-ter-Vehn (2018): "Assumptions should be introduced before the results that use them."

### 6. Adicionar um diagrama geometrico para a concavificacao
**Impacto**: Medio-baixo. **Esforco**: Medio.
O screening schematic TikZ (Fig. 3) ja mostra a concave envelope, mas um diagrama dedicado que compare v(mu, M) vs v(mu, U) com suas envelopes side by side -- como no Fig R (fig:bp-illustration) -- seria mais eficaz se fosse TikZ em vez de R plot, com labels mais legveis. O plot R atual e adequado mas as linhas sao finas em PDF.
**Referencia**: Thomson (1999), Sec. 6: "A good diagram replaces a paragraph of explanation."

### 7. Naming memoravel para os agentes no motivating example
**Impacto**: Baixo. **Esforco**: Baixo.
Em vez de "H" e "W_1, W_2", considerar nomes curtos no exemplo da Secao 2: "a hegemon (say, the US) and two smaller states" ou usar uma convencao como "Player H (hegemon) and players A, B (weak states)". Isto ajuda o leitor a lembrar quem e quem.
**Referencia**: Thomson (1999), Sec. 7: "Name your agents."

---

## Comentarios adicionais

### Pontos fortes

1. **Estrutura corpo/appendix**: A separacao e bem executada. O corpo conta a historia em prosa substantiva; as provas estao todas no appendix. Estilo consistente com JoP/AJPS.

2. **Figuras**: Os game trees TikZ (Figs 1-2) sao claros e informativos. O screening schematic (Fig 3) e pedagogicamente excelente -- mostra o jump, as branches, e a BP gain region. Os plots R (Figs 4-6) complementam bem.

3. **Running example**: Usar os mesmos parametros (N=5, r=1.5, alpha=0.3, beta=0.9) nos Examples 1 e 2 e uma boa pratica (Board: "use a running example").

4. **Sequencia de resultados**: A progressao Prop 1 (no screening under M) -> Prop 2 (cutoff under U) -> Prop 3 (jump) -> Prop 4 (non-convexity) -> Lemma 1 (conditional dominance) -> Thm 1 (dominance with BP) -> Thm 2 (single-crossing) e logicamente impecavel e segue a recomendacao Board de "build the results in order of increasing complexity."

5. **Motivating example**: Eficaz, com numeros simples (V(0)=1, V(1)=2, alpha=0.2, cutoff 1/9) que o leitor pode verificar mentalmente.

### Pontos de atencao menores

- L.102: V_e(mu) e x sao definidos na mesma linha, sem paragrafo separado. Considerar separar para facilitar localizacao.
- L.412: "tau(U) >= tau(M)" e afirmado antes de ser demonstrado (vem do Lemma 1 + budget identity). Marcar como "as established below" ou mover.
- App B.7 (Lemma VW_max): A prova e longa (~30 linhas) e verifica 4 candidates. Considerar se o caso "Aggressive R1, high R2" poderia ser abreviado com "by the same argument as the previous case."
- A notacao para tipos no R2 (theta=0, theta=1 com posterior mu'=1) pode confundir o leitor que confunde "posterior mu" com "posterior after rejection mu'". Considerar adicionar uma nota: "After rejection in R1, the posterior updates to mu'=1 (W learns theta=1 with certainty)."

---

*Parecer gerado em 2026-04-26. Framework: Thomson (1999) "The Young Person's Guide to Writing Economic Theory" + Board & Meyer-ter-Vehn (2018) "Writing Economic Theory Papers".*
