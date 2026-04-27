# Plano: Reescrita v5 — Opção B Modificada (Screening Central, BP → Remark)

**Status**: APPROVED
**Data**: 2026-04-26

## Objetivo

Reescrever `formal_model_v5.Rmd` removendo Bayesian Persuasion como co-protagonista. Screening passa a ser o **único** mecanismo central. BP é demovido a um Remark apontando que unanimidade é "hospitable to information design." O v4 permanece intacto.

## Princípio guia

A estrutura mais simples que conta a história do screening, com BP em um único Remark. Tudo que depende de concavificação ou commitment sai do corpo.

---

## Decisões de design

| # | Questão | Decisão |
|---|---------|---------|
| 1 | **Hierarquia de resultados** | **Lemma 1 → Theorem 1** (promovido). Conditional payoff dominance é o resultado central: α < α\* ⟺ V_H(U,μ) > V_H(M,μ) ∀μ ∈ (0,1]. Bicondicional, sharp, sem hipótese de entry. |
| 1b | **Antigo Theorem 1 (dominance on E_U)** | Vira **Corollary** do novo Theorem 1. "Since E_U ⊆ E_M, Theorem 1 applies pointwise on E_U." Justificativa de E_U ⊆ E_M: "Since weak states' aggregate payoff is weakly lower under unanimity whenever the hegemon's payoff is higher, the unanimity entry constraint is harder to satisfy; hence E_U ⊆ E_M." (Ou referir a um Lemma separado se preferir.) |
| 1c | **Antigo Corollary 1 (global dominance)** | Absorvido: caso particular da Proposition (E_U = (0,1]). Mencionado no ¶ interpretativo após a Proposition. |
| 2 | **Antigo Theorem 2 (single-crossing)** | **Deletado como Theorem.** Substituído por **Proposition (Institutional classification)**: U ≻ M iff p ∈ E_U; M ≻ U iff p ∈ E_M \ E_U; M ~ U iff p ∉ E_M. Formulação via sets, sem threshold p\*, sem assumir connectedness de E_U. Frase de fechamento: "majority's only advantage is that it can support institutional entry at priors for which unanimity cannot." |
| 3 | **O que acontece com p\*?** | Conceito eliminado. Substituído pela comparação E_U vs E_M. Se E_U for upper interval em parâmetros concretos, pode-se mencionar τ(U) no Example, mas não no statement formal. |
| 4 | **O que acontece com Section 6?** | Renomeia para "Entry and Institutional Viability." Mantém Definition (net gain), entry thresholds, insere Remark BP. Deleta Prop 4 e chunk R. |
| 5 | **R code chunks?** | `bp-illustration`: DELETE. `parameter-regions`: SIMPLIFY (comparação direta sem concavificação). |
| 6 | **Model Stage 1?** | Remove signal design. Game: Stage 0 (choose R) → Stage 1 (entry com prior p) → Stage 2 (bargaining). |
| 7 | **Game tree figures?** | Remove nó TikZ "H designs π", atualizar caption. |
| 8 | **Prova do Corollary (antigo Thm 1)?** | Curta mas explícita. (1) Fix p ∈ E_U, logo V_W(p,U) ≥ c. (2) Weak states' aggregate payoff é weakly lower sob U quando H's payoff é higher (Theorem 1 + surplus accounting), logo V_W(p,M) > V_W(p,U) ≥ c ⇒ p ∈ E_M. (3) Theorem 1 ⇒ V_H(U,p) > V_H(M,p). ~6–8 linhas. |
| 9 | **Prova da Proposition (antigo Thm 2)?** | 3 cases exaustivos via E_U ⊆ E_M (do Corollary). (i) p ∈ E_U: Corollary dá U ≻ M. (ii) p ∈ E_M \ E_U: U não forma (V_H(U,p) = αV_e(p)); M forma (V_H(M,p) > αV_e(p) pois entry é IR). M ≻ U. (iii) p ∉ E_M: nenhuma forma, V_H = αV_e(p) sob ambas. M ~ U. ~8–10 linhas. |
| 10 | **Appendix C (K>2)?** | Mantém resultado estrutural, remove framing BP. |
| 11 | **Example 2** | Reescrito sem BP. Mostra E_U e E_M para parâmetros concretos. Verificar se E_U é conectado. Sem p\* = 0.12. |
| 12 | **BP commitment ¶ (Scope)?** | DELETE inteiro. |

---

## Implementação por fases

### FASE 0: Preparação

| Step | Ação | Arquivo | Tipo |
|------|------|---------|------|
| 0.1 | Backup v5 → `archive/formal_model_v5_pre_optionB.Rmd` | v5 | Copy |

### FASE 1: Modelo e Setup (Seções 1–3)

| Step | Local | O que muda | Tipo |
|------|-------|------------|------|
| 1.1 | **Título** (l.2) | Manter. "Informational Power" descreve screening, não só BP. | Sem mudança |
| 1.2 | **Abstract** (l.35–36) | Remover "shaping what weaker states learn." Substituir por frase sobre screening + entry trade-off: "This screening advantage means that, once cooperation is promising enough for weaker states to participate under unanimity, the hegemon strictly prefers it. Below that threshold, majority can dominate—but only because it makes participation easier, not because it gives better terms." | Rewrite 2 frases |
| 1.3 | **Intro** (l.55) | "Using Bayesian persuasion [@kamenica2019bayesian], I show..." → "I show..." Remover citações @bardhiguo2018 e @kim2025persuasion (mover para Remark). | Rewrite |
| 1.3b | **Intro** (l.57) | "Bayesian persuasion extends this conditional advantage..." → "The institutional comparison reduces to a single threshold: once the prior is high enough for weaker states to participate under unanimity, the hegemon strictly prefers it." | Rewrite 1 frase |
| 1.3c | **Intro** (l.61) | Road map: "connects bargaining to entry and persuasion" → "connects bargaining to entry." | Edit 1 palavra |
| 1.4 | **Motivating Example** (l.78–79) | DELETE parágrafo inteiro sobre BP concavificação ("The jump creates a non-convexity...majority does not."). Substituir por: "The screening jump gives the hegemon a strictly higher conditional payoff under unanimity than under majority for every belief above the cutoff. The general model shows this holds across the entire belief space (Lemma 1)." | Delete ¶ + add 2 frases |
| 1.4b | **Motivating Example** (l.80) | Atualizar forward refs para Theorems restated. "Theorem 1 shows that whenever entry is feasible under unanimity, the hegemon strictly prefers it. Theorem 2 establishes that the transition occurs at the unanimity entry threshold." | Rewrite forward refs |
| 1.5 | **Model Stage 1** (l.102–107) | Remover signal design ("commits to public signal structure π..."). Substituir por: "Nature draws θ; the hegemon observes θ. Weak states hold prior belief p and simultaneously decide whether to enter (paying cost c)." Remover texto sobre π, s, update. Simplificar entry condition. | Rewrite ¶ |
| 1.6 | **Model justification** (l.100) | "...create a richer non-convexity that Bayesian persuasion can exploit" → "...create a richer conditional payoff advantage for the hegemon." | Edit 1 frase |
| 1.7 | **Game tree Fig 1** (l.~178–184) | Remover nó TikZ "H designs π". Atualizar caption: remover "Bayesian persuasion" e "signal π." | Delete TikZ node + edit caption |
| 1.8 | **L.116** | "covers institutional choice, Bayesian persuasion, and entry" → "covers institutional choice and entry" | Edit |

### FASE 2: Seções 4–5 (Majority + Unanimity)

| Step | Local | O que muda | Tipo |
|------|-------|------------|------|
| 2.1 | **Sec 4** (~l.286) | Remover: "Bayesian persuasion under majority therefore operates only through the entry channel..." Substituir por frase sobre ausência de screening. | Edit 1 frase |
| 2.2 | **Sec 5 Screening schematic** (l.371–386) | Remover shading TikZ de concavificação, linha dashed de envelope, anotação "BP gains". Atualizar caption. | Delete TikZ + edit caption |
| 2.3 | **Example 1** (~l.393) | "the non-convexity that Bayesian persuasion exploits" → "the screening rent that drives the hegemon's preference for unanimity." | Edit 1 frase |

### FASE 3: Seção 6 — Entry (REWRITE MAJOR)

| Step | Local | O que muda | Tipo |
|------|-------|------------|------|
| 3.1 | **Header** (l.398) | "Entry and Bayesian Persuasion" → "Entry and Institutional Viability". `{#entry_bp}` → `{#entry}`. | Rename |
| 3.2 | **Opening ¶** (l.398–402) | Manter. Já limpo (entry cost, τ(U) ≥ τ(M)). | Sem mudança |
| 3.3 | **Definition 4** (l.404–409) | Manter net gain function v(μ,R). Útil sem BP. | Sem mudança |
| 3.4 | **L.411** | "a single non-convexity. Under unanimity, the screening jump...creates an additional non-convexity." → "Under unanimity, the screening jump at μ_s^R1 creates a discontinuity that gives the hegemon a higher net gain at every belief where entry occurs (Lemma 1)." | Rewrite 1 frase |
| 3.5 | **Proposition 4** (l.413–419) | DELETE Prop 4 + proof ref. NÃO inserir Remark aqui — Remark vai após a Proposition (Sec 7). | Delete |
| 3.6 | **BP explanation ¶** (l.421–422) | DELETE inteiro ("By the standard Bayesian persuasion result..."). ~15 linhas. | Delete |
| 3.7 | **R chunk `bp-illustration`** (l.423–480) | DELETE inteiro. ~58 linhas. | Delete |
| 3.8 | **App B.4** (l.955–957) | DELETE prova da Prop 4 (não existe mais). | Delete |

### FASE 4: Seção 7 — Institutional Choice (REWRITE MAJOR)

Nova hierarquia de resultados:
- **Theorem 1** = antigo Lemma 1 (promovido). Conditional payoff dominance.
- **Corollary** = antigo Theorem 1 (demovido). Dominance on E_U + E_U ⊆ E_M.
- **Proposition** (nova) = antigo Theorem 2 (substituído). Classificação institucional via sets.

| Step | Local | O que muda | Tipo |
|------|-------|------------|------|
| 4.1 | **L.485** | Manter. | Sem mudança |
| 4.2 | **Subsec "Conditional payoff comparison"** (l.487–520) | **Promover Lemma 1 a Theorem 1.** `\begin{lemma}` → `\begin{theorem}`. Label `lem:conditional` → `thm:conditional`. Título: "Conditional payoff dominance of unanimity." Statement inalterado (bicondicional). ¶ interpretativo (l.508–510) mantido. | Promote + relabel |
| 4.2b | **L.489** | "Before turning to the full institutional comparison with persuasion" → "Before turning to the full institutional comparison." | Edit |
| 4.2c | **L.520** | "Without persuasion, the institutional comparison is therefore ambiguous..." → "The institutional comparison is therefore determined by the entry margin: unanimity dominates when the institution forms, but majority can dominate when only it can induce entry." | Rewrite |
| 4.3 | **Subsec "The main result"** (l.522–566) | Reescrever subsection inteira. Remover introductory ¶ sobre BP/concavificação (l.524). | Rewrite |
| 4.4 | **Antigo Theorem 1** (l.526–536) → **Corollary** | Demover a Corollary do novo Theorem 1. Statement: "Suppose α < α\*. For every p ∈ E_U, V_H(U,p) > V_H(M,p). Moreover, E_U ⊆ E_M." Justificativa de E_U ⊆ E_M: "Since weak states' aggregate payoff is weakly lower under unanimity whenever the hegemon's payoff is higher, the unanimity entry constraint is harder to satisfy; hence E_U ⊆ E_M." Proof ref → App B.6. | Rewrite |
| 4.5 | **Antigo Corollary 1** (l.540–542) | DELETE como resultado separado. Absorvido no ¶ interpretativo da Proposition: "When entry costs are low enough that E_U = (0,1], unanimity dominates at every prior." | Delete + absorb |
| 4.6 | **L.544** (disconnected E_U ¶) | DELETE. Não é mais relevante — a Proposition não assume connectedness. | Delete |
| 4.7 | **Antigo Theorem 2** (l.546–556) → **Proposition (Institutional classification)** | Substituir inteiro. Statement: "Under the conditions of Theorem 1, the hegemon's preferred rule is characterized as follows: U ≻ M iff p ∈ E_U; M ≻ U iff p ∈ E_M \ E_U; U ~ M iff p ∉ E_M. Since E_U ⊆ E_M, majority's only advantage is that it can support institutional entry at priors for which unanimity cannot." Proof ref → App (antigo B.8). | Rewrite |
| 4.8 | **¶ interpretativo** (após Proposition) | 2–3 frases para JoP audience: "When the prior is such that weak states find it individually rational to enter under unanimity, the hegemon strictly prefers it. When only majority can sustain entry, majority dominates—not through better bargaining terms, but through wider institutional viability. When neither rule can induce entry, the voting rule is irrelevant." + caso especial E_U=(0,1] (absorve antigo Corollary 1). | New content |
| 4.8b | **Remark (Information design)** | Inserir APÓS ¶ interpretativo da Proposition. Texto aprovado: "The model also clarifies why information design would matter differently..." Posição: fecha a seção dizendo que o resultado é hospitable a BP, sem desenvolver. | Insert |
| 4.9 | **Example 2** (l.560–566) | Reescrever sem BP. Mostrar E_U e E_M para parâmetros concretos (N=5, r=1.5, α=0.3, β=0.9, c=0.14). Verificar se E_U é conectado. Sem p\*=0.12. Ilustrar os 3 cases da Proposition. | Rewrite |
| 4.10 | **R chunk `parameter-regions`** (l.570–670) | Simplificar `compute_preference`: comparação direta V_H sem concavificação. Lógica: se p ∈ E_U → comparar V_H; se p ∈ E_M \ E_U → M vence; se p ∉ E_M → empate. Atualizar caption. | Rewrite R code |
| 4.11 | **L.672** (interpretation) | Reescrever sem "concavification gains." Usar linguagem de E_U vs E_M. | Edit |

### FASE 5: Discussion e Conclusion

| Step | Local | O que muda | Tipo |
|------|-------|------------|------|
| 5.1 | **Discussion GATT** (l.689) | Atualizar refs implícitas a p\* → E_U/E_M. | Minor edit |
| 5.2 | **Scope: BP commitment ¶** (l.699) | DELETE inteiro (~8 linhas). | Delete |
| 5.3 | **Scope** (l.703) | "Bayesian persuasion can still exploit it at low priors" → "unanimity can still dominate at beliefs where the screening rent outweighs the vote-buying cost." | Edit 1 frase |
| 5.4 | **Conclusion** (l.795) | "Bayesian persuasion extends this advantage to priors where the institution would not otherwise form." → "The institutional comparison has a clean structure: unanimity dominates wherever it can sustain entry, and majority's only advantage is wider institutional viability." | Edit 1 frase |
| 5.5 | **Conclusion K>2** (l.799) | Remover framing Dworczak-Martini/info design. Substituir por: "The qualitative mechanism—unanimity creates screening, screening creates a conditional payoff advantage—extends naturally to richer type spaces." | Rewrite |

### FASE 6: Appendices

| Step | Local | O que muda | Tipo |
|------|-------|------------|------|
| 6.1 | **Notation table** (l.810–847) | Remover S_U, S_M (slopes de concavificação). Remover p\* (não existe mais). Atualizar Lemma 1 → Theorem 1 na coluna "Defined in." | Edit rows |
| 6.2 | **App B.4** (l.955–957) | DELETE prova Prop 4 (já coberto em 3.8). | Delete |
| 6.3 | **App B.5** (prova do antigo Lemma 1, agora Theorem 1) | Manter intacto. Apenas atualizar header: "Proof of Theorem 1" (era "Proof of Lemma 1"). | Rename header |
| 6.4 | **App B.6** (l.1108–1120) → **Proof of Corollary** | Reescrever. (1) Fix p ∈ E_U, logo V_W(p,U) ≥ c. (2) Since weak states' aggregate payoff is weakly lower under U when H's payoff is higher (Theorem 1 + surplus accounting), V_W(p,M) > V_W(p,U) ≥ c ⇒ p ∈ E_M. (3) Theorem 1 ⇒ V_H(U,p) > V_H(M,p). ~6–8 linhas. | Rewrite |
| 6.5 | **App B.7** (l.1122–1142) | Manter intacto. Puro screening. | Sem mudança |
| 6.6 | **App B.8** (l.1144–1156) → **Proof of Proposition** | Reescrever como 3 cases exaustivos. (i) p ∈ E_U: Corollary dá V_H(U,p) > V_H(M,p). U ≻ M. (ii) p ∈ E_M \ E_U: U não forma, V_H(U,p) = αV_e(p); M forma, V_H(M,p) > αV_e(p) pois entry é IR. M ≻ U. (iii) p ∉ E_M: nenhuma forma, V_H = αV_e(p) sob ambas. U ~ M. Exhaustivo porque E_U ⊆ E_M (Corollary). ~8–10 linhas. | Rewrite |
| 6.7 | **App C** (l.1159–1194) | Remover framing BP. "potential source of non-convexity" → "conditional payoff advantage." Limitations: "for persuasion to overturn" → "for unanimity to conditionally dominate." | Edit 2 frases |

### FASE 7: Cross-cutting

| Step | Ação |
|------|------|
| 7.1 | **Bibliografia**: Manter @kamenica2011bayesian no Remark. Remover @bardhiguo2018 e @kim2025persuasion da intro (mover para Remark se desejado). |
| 7.2 | **Global search**: `persuasion` → só no Remark. `cav`/`operatorname{cav}` → zero. `Π_H^*` → `V_H`. `signal structure` → zero. `lem:conditional` → `thm:conditional` (Lemma promovido). |
| 7.3 | **Renumeração**: Prop 4 deletada, Lemma 1 → Theorem 1, Theorem 1 → Corollary, Theorem 2 → Proposition. Buscar: `\ref{prop:nonconvexity}`, `\ref{fig:bp-illustration}`, `\ref{thm:dominance}`, `\ref{thm:crossing}`, `\ref{cor:global}` → atualizar ou remover todas as refs. Buscar "Lemma 1" / "Lemma~\\ref" em texto corrido → atualizar para "Theorem 1". |
| 7.4 | **`model_functions.R`**: Sem mudança. `concavify()` permanece no script (não é mais chamada pelo Rmd). |

### FASE 8: Verificação

| Step | Ação |
|------|------|
| 8.1 | Compilar: `rmarkdown::render("formal_model_v5.Rmd")` |
| 8.2 | Cross-ref audit: buscar `\ref{}` quebrados |
| 8.3 | Narrative consistency: leitura front-to-back. BP só no Remark. |

---

## Ordem de execução

```
FASE 0 (backup)
    ↓
FASE 2 (Secs 4–5, edits simples)  ←  independente de Fase 1
    ↓
FASE 1 (Intro, Model)
    ↓
FASE 3 (Sec 6 — rewrite major)
    ↓
FASE 4 (Sec 7 — rewrite major, depende de Fase 3 para Remark)
    ↓
FASE 6 (Appendices — depende de Fase 4 para novos theorems)
    ↓
FASE 5 (Discussion/Conclusion — depende de Fase 4 para refs)
    ↓
FASE 7 (Cross-cutting — depende de todas as fases)
    ↓
FASE 8 (Verificação)
```

## Riscos

| Risco | Mitigação |
|-------|-----------|
| Proposition parece "simples demais" a referee | É uma classificação exaustiva, não um resultado trivial. Formulação via sets é mais geral que threshold. Comparar com classification propositions em Dixit/Baron. |
| E_U desconectado | Formulação via E_U (não τ(U)) é imune. Verificar numericamente se E_U é conectado nos parâmetros do Example 2 — se for, mencionar; se não, ilustra por que a formulação por sets é necessária. |
| Paper fica mais curto (~80–100 linhas a menos) | Tighter is better para JoP. Remark adiciona ~8 linhas. |
| Contribuição mais estreita (só screening, não info design) | Remark preserva ponte para BP literature. Screening puro é mais defensável. |
| Example 2 menos dramático | A história honesta é mais limpa. +25% advantage at p=0.50 ainda é substancial. Mostra E_U e E_M concretamente. |
| Muitas refs cruzadas mudam (Lemma→Thm, Thm→Cor/Prop) | Global search obrigatório na Fase 7. Compilação na Fase 8 pega refs quebradas. |

## Verificação

- [ ] Paper compila sem erros
- [ ] BP aparece SOMENTE no Remark
- [ ] Nenhum `\ref{}` quebrado
- [ ] `cav`, `concav`, `Π_H^*` ausentes do corpo
- [ ] Theorem 2 usa E_U (não τ(U)) na formulação; 3 cases exaustivos
- [ ] E_U desconectado tratado corretamente (gaps caem em case ii)
- [ ] Prova B.6 explicita entry inclusion (p ∈ E_U ⇒ p ∈ E_M) via budget identity
- [ ] Prova B.8 cobre os 3 cases exaustivamente
- [ ] Narrative flows: screening → Lemma 1 → Thm 1 → Thm 2
