# DECISÃO 2026-09-01 — Codificação operacional de "structural consistency" no baseline

**Status**: APPROVED (decisão do autor, 2026-09-01)
**Autor da decisão**: Manoel Galdino
**Origem**: discussão da sessão de 2026-09-01 sobre a pergunta "quais histórias devem compartilhar a mesma crença off-path", seguida de auditoria adversarial em
`quality_reports/2026-09-01_devils-advocate_structural_consistency.md`. A versão aprovada é a **definição corrigida** do relatório adversarial, que fecha o buraco de gatilho e as duas imprecisões de redação encontradas na proposta original da sessão.
**Relação com decisões anteriores**: esta decisão CODIFICA as Decisões 1 e 1a de
`quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`; não altera nenhuma primitiva, estratégia, fronteira, correspondência ou payoff. Nenhum artefato congelado é editado. A verificação direcional exigida (item de checagem abaixo) pertence ao próximo ciclo de revisão independente do manuscrito.

---

### Decisão: definição operacional de structural consistency (baseline)

- **Escolha** (texto canônico, em inglês, para o Apêndice A.2 do manuscrito):

  > Fix a profile. At each ballot, let the entering belief be the current posterior (weak-state proposals and votes never change it), and let H's prescribed law be the type-contingent vote distribution the profile assigns at that ballot. The posterior after any vote vector depends on the history only through the entering belief, the prescribed law, and H's realized vote; it is therefore invariant across vote vectors of the same ballot that differ only in weak-state votes. If H's realized vote has positive probability under the prescribed law and the entering belief, the posterior is the Bayes update given that law, including at ballots reached by earlier weak-state deviations. If the Bayes denominator is zero, the posterior is a single free value attached to that ballot-and-vote pair, chosen within the support of the prior: any value in [0,1] for an interior prior, and the degenerate posterior at p=0 or p=1. Distinct ballots may carry distinct free values. This condition is a declared restriction of our equilibrium concept; it is not the consistency notion of sequential equilibrium (Kreps and Wilson 1982), and it is narrower than the never-dissuaded discipline of Osborne and Rubinstein (1990).

  Conteúdo operacional: (i) dentro de um ballot, todos os vetores com o mesmo voto de H compartilham o posterior — cada ballot tem exatamente duas coordenadas de crença (η_Y, η_N), aplicadas independentemente das coordenadas fracas do vetor, inclusive em desvios compostos (H e fraco desviando no mesmo vetor); (ii) Bayes estrutural dado o perfil, mesmo em subárvores alcançadas por desvio anterior de um fraco; (iii) o gatilho da coordenada livre é **denominador bayesiano zero sob a crença de entrada** (não "probabilidade zero sob os dois tipos"), com liberdade dentro do suporte do **prior** (Emenda 1a); (iv) a liberdade é **local ao ballot** — ballots distintos podem carregar valores livres distintos.

- **Proveniência de uso** (a definição é codificação, não mudança): campos `belief_system` e `complete_off_path_ballot_correspondence` de
  `model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json` — pares (η_Y, η_N) por ballot; `H_yes_yes_with_weak_veto` herdando o mesmo η; `structural Bayes for prescribed H actions`; restrições de crença livre dependentes da proposta desviante (por exemplo `eta_Y >= 1 - u/A quando B <= u < A`), que comprovam o exercício da liberdade por ballot.

- **Alternativas descartadas**:
  - **Coordenada livre global no baseline** (um único valor para todos os ballots, análogo ao ρ do M/S/B): descartada por proveniência — seria conceito novo, exigiria rederivação e re-revisão de material congelado sem ganho para nenhum resultado atual. A alegação da sessão de que a coordenada global quebraria as construções de existência congeladas NÃO foi verificada e não é o fundamento do descarte; o fundamento é exclusivamente a disciplina de proveniência.
  - **Crenças variando com as coordenadas fracas do vetor dentro do mesmo ballot**: descartada — é a reintrodução do meio-termo instável já eliminado na Decisão 1 (deixaria desvios compostos sem regra ou com regra dependente do desviante fraco, canal de sinalização que o no-signaling proíbe).
  - **Pinagem por razão de verossimilhança no caso denominador-zero-com-lei-positiva** (voto prescrito ao tipo de posterior corrente zero identificaria o tipo, posterior 1): descartada — contradiz a cláusula interior da Emenda 1a ("crenças após desvios de H continuam livres em [0,1], mesmo que algum posterior tenha atingido zero no caminho") e reabriria a classe de contabilidade off-path que causou as crises anteriores.
  - **Gatilho "probabilidade zero sob os dois tipos"** (formulação original da sessão e frase corrente da seção Solution concept): descartada como redação — não é exaustiva; falha exatamente no caso do voto prescrito ao tipo de posterior corrente zero, deixando a história sem regra. O gatilho canônico é denominador bayesiano zero.
  - **"Invariant to the proposer's identity" como cláusula autônoma**: descartada — a invariância vale através da lei prescrita, não incondicionalmente; se a lei de H condiciona na identidade do proponente, Bayes legitimamente separa os posteriores (canal endossado pela Decisão 1).

### Cláusulas de acompanhamento (aprovadas junto)

1. **Reconciliação com N2 (sem refreeze)**: a interface efetiva de N2
   (`model_redesign/essential_input_n2_r2_unanimity_interface.json`, campo `off_path_ballot`, lido com a errata da Emenda 1a) admite, no interior, qualquer crença em [0,1] após proposta fraca de probabilidade zero — classe MAIS permissiva que o no-signaling. A latitude extra é payoff-invariante, como o próprio artefato declara ("Terminal weak and H ballot strategies and the proposer's deviation payoff are invariant to that belief"): em rodada terminal a crença pós-proposta não alimenta continuação. A norma corrente é a definição desta decisão; a interface congelada permanece byte a byte; nenhum objeto de N2 muda; nenhuma errata adicional é necessária. Esta cláusula existe para que um auditor que leia A.2 ao lado do artefato não conclua por contradição não tratada.
2. **Assimetria declarada com o estágio de agenda**: no M/S/B da extensão, todas as propostas indisciplinadas de H na data A compartilham um único μ^off = b_ρ(p) por registro — restrição mais forte que a liberdade por ballot do baseline, adotada lá para indexar as correspondências. As duas convenções nunca interagem: proposta de agenda rejeitada entra numa continuação de Rodada 1 como registro completo, cujas crenças internas seguem a regra do baseline. O manuscrito deve declarar essa assimetria em uma frase (E.1).
3. **Item de checagem para o próximo ciclo de revisão independente**: verificar direcionalmente que a codificação (a) não admite nenhum assessment que os artefatos congelados excluam e (b) não exclui nenhum assessment que alguma construção de existência congelada use. Relevância: o resultado de inexistência (0<p≤p*) quantifica sobre toda a classe admissível — alargar a classe reabriria a prova; a codificação não alarga, mas a verificação deve constar do parecer, não ser presumida.

### Edições de manuscrito autorizadas por esta decisão

- `formal_model_v6.Rmd`, seção Solution concept: corrigir o gatilho ambíguo ("zero probability under both outside-option values" → denominador bayesiano zero) e apontar para A.2.
- `formal_model_v6.Rmd`, Apêndice A.2: substituir "subject to structural consistency across histories that encode the same information" pela definição canônica acima.
- `formal_model_v6.Rmd`, Apêndice E.1: uma frase declarando a assimetria baseline/agenda (cláusula 2).
- Nenhuma outra parte do manuscrito, nenhum artefato em `model_redesign/`, nenhum payoff, proposição ou tabela.

As edições criam um candidato novo de manuscrito, sujeito ao ciclo normal de revisão independente; esta decisão não constitui parecer sobre o candidato.

## Proveniência

| Objeto | Caminho |
|---|---|
| Auditoria adversarial (origem da versão corrigida) | `quality_reports/2026-09-01_devils-advocate_structural_consistency.md` |
| Decisões codificadas (1, 1a, errata N2) | `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` |
| Uso congelado (N4) | `model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json` |
| Interface efetiva de N2 | `model_redesign/essential_input_n2_r2_unanimity_interface.json` + errata da Emenda 1a |
| Contrato do estágio de agenda (ρ global) | `formal_model_v6.Rmd`, Apêndice E.1 |
