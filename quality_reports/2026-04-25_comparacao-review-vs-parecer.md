# Comparacao: Review de Correcao vs. Parecer JoP vs. Plano de Revisao

**Data**: 2026-04-25 (revisado)

Documentos comparados:
- `quality_reports/2026-04-25_correctness-review-v3.md` — review de correcao (este agente)
- `quality_reports/2026-04-25_analise_parecer_jop.md` — analise do parecer do referee JoP
- `quality_reports/plans/2026-04-25_revision-plan-jop-referee.md` — plano de revisao

---

## 0. Autocritica: onde meu review foi insuficiente

Meu review original disse "a matematica esta solida" sem qualificar. Isso foi impreciso. O que meu review verificou e o que nao verificou:

| Dimensao | Verificado? | Resultado |
|----------|------------|-----------|
| Cada passo logico e valido? | Sim | Correto |
| Cada caso esta tratado explicitamente? | **Nao** | Caso alternativo do Lemma 1 (mu_s^R1 < mu_s^R2) comprimido numa frase |
| As hipoteses sao justificadas? | **Nao** | Assumption 1 (monotone entry) falha em 5% do espaco de parametros |
| Os resultados fazem o que o paper diz? | **Parcialmente** | Theorem 1 atribui poder ao BP, mas BP contribui 0% do gap em E_U |

O referee identificou corretamente os tres problemas que meu review subestimou:

### Lemma 1: correto mas prova incompleta

O referee diz: "ainda nao aceitaria sem revisao." Ele esta certo. O caso alternativo (mu_s^R1 < mu_s^R2) recebe uma frase: "the same endpoint argument establishes positivity." Meus testes numericos (144/144) confirmam que o resultado e verdadeiro, mas uma prova precisa ser autocontida no papel. Ate que os intervalos sejam enumerados explicitamente e D(mu) > 0 mostrado em cada um, a prova nao esta publicavel.

Tie-breaking nos cutoffs: o enunciado diz "para todo mu in (0,1]" ponto a ponto. Nos cutoffs exatos, D(mu) = D_base(mu) (as correcoes se anulam), o que e positivo por Step 2. Mas isso precisa ser declarado, nao deixado implicito.

### Theorem 1: correto mas BP nao faz trabalho

O referee diz: "depende muito do Lemma 1, nao e demonstracao do mecanismo de persuasion." Verificacao numerica confirma:

| Prior p | Gap total Pi*(U)-Pi*(M) | Conditional dominance (Lemma 1) | BP contribution |
|---------|------------------------|---------------------------------|-----------------|
| 0.05 | 0.128 | 0.117 (91%) | 0.011 (9%) |
| 0.10 | 0.143 | 0.121 (84%) | 0.023 (16%) |
| 0.15 | 0.159 | 0.120 (76%) | 0.039 (24%) |
| 0.20+ | 0.173 | 0.173 (100%) | 0.000 (0%) |

Para todo p in E_U (onde entry ocorre sob unanimidade), o gap e 100% conditional dominance. BP so contribui para p ABAIXO de tau(U), que e o dominio do Theorem 2, nao do Theorem 1.

A cadeia do Theorem 1 e: cav v(p,U) >= v(p,U) > v(p,M) = cav v(p,M). O ">=" e trivial (definicao de concavificacao). O ">" e Lemma 1. O "=" e linearidade da maioria. BP (concavificacao) so contribui a desigualdade trivial. O trabalho real e Lemma 1.

Isso nao torna o Theorem 1 errado, mas torna a retorica do paper ("Bayesian persuasion exploits the jump") enganosa para este resultado. BP faz trabalho real no Theorem 2 (priors abaixo do threshold de entrada), nao no Theorem 1.

### Theorem 2: correto mas Assumption 1 e substantiva

O referee diz: "Assumption 1 sobre monotone entry e substantiva e precisa ser mais bem justificada."

Verificacao numerica: Assumption 1 falha em **4.9%** do espaco de parametros testado (348/7064 casos). Quando falha, E_U e desconectado — ha um gap de beliefs ao redor de mu_s^R1 onde entry nao ocorre. Exemplo: r=1.2, alpha=0.05, N=5, beta=0.9, c=0.190 produz E_U com gap em [0.144, 0.170].

**Ponto positivo**: nos 4 casos testados com E_U desconectado, single-crossing ainda se mantem (1 sign change). Isso sugere que o resultado pode ser mais robusto que Assumption 1, mas sem prova. O paper deveria ou (a) provar single-crossing sem Assumption 1, ou (b) mostrar que quando Assumption 1 falha, a entry set desconectada tem estrutura suficiente para preservar single-crossing, ou (c) ser honesto que o resultado e condicional e explicar quando a assuncao falha.

---

## 1. Convergencias (confirmacoes mutuas)

| Issue | Referee (analise) | Review correcao | Plano | Status |
|-------|-------------------|-----------------|-------|--------|
| "Principal regime" indefinido | 3.2 (Alta) | 5.4 (Minor) | R1 (Prioridade 1) | **Convergencia total.** Ambos identificam o problema. O plano propoe 3 opcoes; opcao 1 (provar que alpha < alpha* => principal regime) e a melhor. |
| Notacao pesada no corpo | 4.2 (Baixa) | 5.2 (Minor: C_buy/C_out no Remark 1) | R9 (Prioridade 3) | **Convergencia parcial.** O review de correcao identifica o ponto especifico (Remark 1 usa C_buy/C_out sem definir). O plano R9 e generico. |

## 2. Issue NOVA do review de correcao (nao no parecer)

### Game tree mislabeled (Issue 5.1 — MAJOR)

**O que encontrei**: A Figura 2 (`fig:gametree-b`) rotula as ofertas de R1 como $y_H = \alpha$ (agressiva) e $y_H = \alpha r$ (conservadora). Estas sao as ofertas de **R2** (round terminal). As ofertas corretas de R1 sao:
- Agressiva: $y_H = \beta(1+x)/N$ (reserva de theta=0 no R2 off-path com mu=1)
- Conservadora: $y_H = \beta(r+x)/N$ (reserva de theta=1 no R2)

**Verificacao numerica**: Para N=5, r=1.5, alpha=0.3, beta=0.9:
- Oferta agressiva R1 = 0.504 (tree diz 0.3 = alpha)
- Oferta conservadora R1 = 0.594 (tree diz 0.45 = alpha*r)

Os payoffs terminais na arvore tambem estao errados: mostram (alpha, 1-alpha-c) quando deveriam ser (beta(1+x)/N, ...).

**Impacto**: O referee JoP NAO pegou este erro. Mas um referee mais tecnico (AJPS, por exemplo) pegaria. Nao afeta nenhum resultado (provas usam formulas corretas), mas cria confusao sobre o equilibrio.

**NAO esta no plano de revisao.** Precisa ser adicionado como R0 (Prioridade 1).

### Jump aproximado no exemplo motivador (Issue 5.3 — Minor)

**O que encontrei**: Secao 2 diz "The jump is 0.18" mas o valor exato e 8/45 = 0.1778. Arredondamento aceitavel mas pode incomodar referee.

**NAO esta no parecer nem no plano.** Fix trivial: trocar "0.18" por "approximately 0.18" ou "$8/45$".

## 3. Issues do parecer que o review de correcao NAO aborda (fora do escopo)

| Issue | Referee | Por que nao abordei | Plano cobre? |
|-------|---------|---------------------|--------------|
| 3.1 Resultado mais estreito que a promessa | Alta | Framing, nao correcao | Sim (R4) |
| 3.4 Theorem 1 depende de Lemma 1, nao BP | Media | Framing retorico | Sim (R7) |
| 3.5 Entry game subespecificado | Media-alta | Nao e erro matematico | Sim (R3) |
| 3.6 WTO sem observable implications | Media | Conteudo substantivo | Sim (R5) |
| 4.1 Linguagem forte demais | Baixa | Calibracao de tom | Sim (R4) |
| 4.3 Consensus ≠ unanimity | Baixa | Definicional | Sim (R6) |

## 4. Issues do parecer que o review de correcao INFORMA

### 3.3 Prova do Lemma 1 — caso alternativo (mu_s^R1 < mu_s^R2)

**O que o referee diz**: A prova comprime o caso alternativo numa frase. Exige tratamento explicito.

**O que meu review acrescenta**: A prova esta CORRETA. 144/144 testes numericos passam, incluindo parametros no caso alternativo. A questao nao e de correcao mas de completude expositiva. O plano R2 e adequado: expandir a prova com intervalos explicitos. A confianca de que a expansao nao vai revelar erros e alta.

### 3.2 "Principal regime" (alfa < alfa_barra)

**O que meu review acrescenta para R1 do plano**: A opcao 1 do plano (provar alpha* < alpha_barra) deve ser viavel. No caso principal, Appendix A.5 diz que o regime vale quando Delta_1(mu_s^R2) > 0. Como Delta_1 depende de parametros mas NAO de alpha no principal regime, e alpha* depende apenas de N e beta, a verificacao e algebrica. Meus testes confirmam que para todos os parametros testados, alpha < alpha* implica estar no principal regime.

## 5. Avaliacao do plano de revisao

### O plano cobre as issues?

| Issue | Coberto por | Adequado? |
|-------|------------|-----------|
| 3.1 Framing condicional | R4 | Sim |
| 3.2 Principal regime | R1 | Sim, opcao 1 e a melhor |
| 3.3 Lemma 1 caso alternativo | R2 | Sim |
| 3.4 Desalinhamento retorico Thm 1 | R7 | Sim |
| 3.5 Entry subespecificado | R3 | Sim |
| 3.6 Observable implications | R5 | Sim |
| 4.1 Linguagem forte | R4 | Sim |
| 4.2 Notacao | R9 | Parcial — precisa incluir fix especifico para Remark 1 |
| 4.3 Consensus/unanimity | R6 | Sim |
| **5.1 Game tree mislabeled** | **NAO COBERTO** | **Precisa ser adicionado** |
| **5.3 Jump approximation** | **NAO COBERTO** | **Fix trivial, adicionar** |

### Gap principal no plano

**O plano nao inclui a correcao da Figura 2 (game tree).** Este e o unico issue MAJOR que falta. Sugiro adicionar como **R0** na Fase 1, pois:
1. E uma correcao localizada (linhas 220-277 do Rmd)
2. Nao tem dependencias com as outras revisoes
3. Um referee de AJPS (mais tecnico que JoP) provavelmente pegaria

### Ordem de execucao revisada

| Fase | Tasks originais | + Novos |
|------|----------------|---------|
| **Fase 1** | R1 (principal regime) + R2 (Lemma 1) | **+ R0 (game tree)** + fix jump 0.18 |
| **Fase 2** | R3 (entry) + R6 (consensus) + R8 (example) | + fix Remark 1 (C_buy/C_out) |
| **Fase 3** | R4 (reframing) + R5 (OIs) + R7 (Thm 1 paragrafo) | sem mudanca |
| **Fase 4** | R9 (notacao) + revisao final | sem mudanca |

---

## 6. Conclusao revisada

Os resultados sao **logicamente corretos** (nenhum passo invalido, 144+ testes numericos passam), mas a distancia entre "correto" e "publicavel" e real. O referee identificou tres problemas que meu review inicial subestimou:

1. **Lemma 1**: Prova incompleta no caso alternativo. Correto mas nao autocontido.
2. **Theorem 1**: Correto mas BP contribui 0% do gap em E_U. A retorica do paper superestima o papel do BP neste resultado.
3. **Theorem 2**: Correto mas Assumption 1 falha em 5% dos parametros. Single-crossing parece robusto mesmo sem a assuncao (4/4 testes), mas sem prova.

### O que o plano de revisao precisa adicionar

| Issue | No plano? | O que falta |
|-------|-----------|-------------|
| Lemma 1 caso alternativo | R2 (adequado) | Nada — R2 cobre |
| Theorem 1 retorica do BP | R7 (parcial) | R7 reescreve o paragrafo interpretativo, mas precisa ir mais fundo: separar explicitamente o que Lemma 1 faz (conditional dominance) vs o que BP faz (expandir o dominio de priors via Theorem 2). Nao basta ajustar prosa — a arquitetura narrativa de "BP explora o jump" deve ser recalibrada para "BP expande o dominio de viabilidade de unanimidade". |
| Assumption 1 | **NAO COBERTO** | O plano nao aborda. Opcoes: (a) provar single-crossing sem Assumption 1; (b) mostrar que E_U desconectado preserva a estrutura; (c) relaxar Assumption 1 para "E_U has at most K connected components" e provar single-crossing nesse caso; (d) ser honesto que e condicional, quantificar quando falha (5%), e mostrar numericamente que single-crossing sobrevive. |
| Game tree mislabeled | **NAO COBERTO** | Adicionar como R0 |
| Jump 0.18 | **NAO COBERTO** | Fix trivial |
| Remark 1 C_buy/C_out | R9 (generico) | Incluir fix especifico |

### Recomendacao atualizada

O plano R1-R9 e uma boa base, mas precisa de **tres adicoes**:

1. **R0 (Fase 1)**: Corrigir game tree — ofertas e payoffs de R1 com valores corretos
2. **R7 ampliado (Fase 3)**: Nao so reescrever o paragrafo apos Theorem 1, mas recalibrar a narrativa inteira. BP faz trabalho real em Theorem 2 (expansao do dominio de priors), nao em Theorem 1 (que e Lemma 1). O paper deve dizer isso honestamente.
3. **R10 novo (Fase 1 ou 2)**: Abordar Assumption 1. Opcao minima: quantificar quando falha (5% dos parametros, r baixo, c intermediario), mostrar numericamente que single-crossing sobrevive, e declarar que a assuncao e suficiente mas possivelmente nao necessaria. Opcao ideal: provar single-crossing sem ela.

O paper e publicavel com estas revisoes, mas "publicavel" requer tratar seriamente as 3 questoes do referee, nao apenas ajustar prosa.
