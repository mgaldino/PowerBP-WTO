# Carta Editorial v3 — Revisao de Modelo Formal

**Referencias**: Thomson (1999), Board & Meyer-ter-Vehn (2018), Dixit (2015), Varian (1997/2016)

## Decisao: R&R Minor (para JTP/GEB) / R&R Major (para AJPS)

## Scores consolidados
| Dimensao              | Score  | Rating     |
|-----------------------|--------|------------|
| Design do modelo      | 7/10   | Adequado+  |
| Apresentacao tecnica  | 7/10   | Adequado   |
| Exposicao             | 7.5/10 | Boa        |
| **Global**            | **7.2/10** | **R&R Minor** |

## Sintese editorial

O modelo e bem desenhado: puzzle genuino (do mundo, nao dos journals), estrutura KISS (BF + BP + pie incerto), mecanismo central isolado (custo diferencial → exclusao), e processo de construcao maduro (exemplo N=3 antes da generalizacao, baseline β=0 antes de β>0). O Curse of Knowledge e o resultado mais limpo e a principal forca do paper.

A apresentacao tecnica e competente mas tem lacunas sistematicas: **notacao ambigua** (α usado com dois significados, γ desnecessario, V(μ) e V̂ sem definicao formal), **definicoes ausentes** para conceitos centrais ("informational power", "symmetric benchmark", "screening"), e **provas sem numeracao de steps e QED inconsistente**. Todas essas sao corrigiveis sem alterar conteudo.

A exposicao e a dimensao mais forte. Os tres pareceristas convergem em uma lacuna critica: **falta a figura de concavificacao** — o diagrama canonico de Bayesian Persuasion que tornaria o mecanismo da Proposicao 2 imediatamente visual. A introducao tem contexto excessivo antes da contribuicao tecnica.

## Hierarquia aplicada: Design > Apresentacao > Exposicao

O design e adequado para publicacao em journal de teoria (JTP, GEB). O Curse of Knowledge e genuinamente novo e o isolamento do mecanismo e limpo. A fragilidade esta em β: sem β, BP tem valor zero, e a narrativa de "informational power" perde substancia. Os pareceristas de Design e Exposition convergem: **o paper e mais sobre "information as liability under majority" do que sobre "informational power under unanimity"**. Recalibrar a narrativa nessa direcao fortaleceria o design sem alterar os resultados.

A apresentacao tecnica e o principal alvo de revisao: as lacunas de notacao/definicao sao numerosas mas mecanicas de corrigir. A exposicao precisa principalmente da figura de concavificacao e de enxugamento da introducao.

## Prioridades para revisao

1. **Adicionar figura de concavificacao V(μ).** Unanimidade dos 3 pareceristas. Plotar V_safe(μ), V_agg(μ), kink em μ*, e V̂. Esta figura substitui paragrafos de prova e comunica o resultado em segundos.
2. **Definir formalmente "informational power", "symmetric benchmark", e "screening proposal".** Os tres conceitos mais usados no paper nao tem definicao formal.
3. **Resolver ambiguidade de notacao.** α com significado unico (α(q) = 1 - qδ/N), eliminar γ, definir V(μ) e V̂ antes do uso.
4. **Numerar steps nas provas e padronizar QED.** Todas as provas com >2 etapas devem ter steps numerados. QED (□) em todas as provas.
5. **Reestruturar introducao.** Mover contribuicao tecnica para o segundo paragrafo; condensar Steinberg e burocracias para depois dos resultados. Mover tabela Alonso-Camara da Secao 7 para a intro.
6. **Adicionar timeline e game tree simplificada.** Para o timing e para o exemplo N=3.
7. **Separar hipoteses de conclusao nos enunciados.** Formato "Suppose [conditions]. Then [conclusion]" para Proposicoes 1-4.

## Recomendacao estrategica ao autor

O modelo esta maduro para circulacao em seminarios e submissao a **JTP ou GEB** apos implementar as prioridades 1-5 (estimativa: 1-2 semanas de trabalho). Para **AJPS**, alem dessas correcoes seria necessario: (a) regras intermediarias (supermaioria) para capturar mais designs institucionais reais, (b) discussion substantiva de robustez a commitment e multiplos Senders, e (c) engagement com literatura de RI (Maggi & Morelli, Diermeier & Feddersen). A versao JTP pode servir como nota tecnica que ancora uma submissao posterior mais ambiciosa.
