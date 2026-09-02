# Prompt Codex — Atualizar provas B.1 e B.3 sob a regra de exclusão emendada (protocolo de provas)

**Status**: APPROVED — o autor confirmou em 2026-09-01 a leitura da definição 1
(desacordo por insuficiência de surplus); pronto para rodar no Codex
**Data**: 2026-09-01

---

Estamos no repo PowerBayesianPersuasion. Leia antes de agir, nesta ordem:

1. O bloco **FUNDAMENTOS INVIOLÁVEIS DO MODELO (2026-09-01)** no topo de `CLAUDE.md` (espelho em inglês em `AGENTS.md`).
2. `quality_reports/2026-09-01_decisao_exclusao_payoffs_e_fundamentos.md` — INCLUSIVE a **EMENDA** ao final, que governa esta tarefa.
3. `quality_reports/2026-09-01_decisao_structural_consistency_baseline.md`.
4. `notes/2026-09-01_explicacao_completa_correcao_exclusao_teto.md` (contexto sem jargão, com a atualização no topo).
5. `formal_model_v6.Rmd`: seção The model e Apêndices A.1/A.2 (definições já atualizadas e aprovadas — não mexer), e Apêndice B (provas — o alvo).

## Estado e tarefa

O manuscrito está temporariamente inconsistente, de propósito e com aviso registrado: as DEFINIÇÕES do jogo já usam a regra nova de exclusão, mas as provas **B.1** (prova da Proposição 1, benchmark de informação completa) e **B.3** (prova da Proposição 3, maioria com tipo privado de H) foram devolvidas ao estado anterior e mencionam a regra antiga `x_H+o` em dois passos. Sua tarefa: atualizar B.1 e B.3 à regra nova seguindo o protocolo de provas abaixo, e varrer o Apêndice B inteiro por outras menções à regra antiga (reportar o que achar; NÃO editar nada além de B.1 e B.3 sem autorização explícita do autor).

## A regra nova (já definida e aprovada no manuscrito — use-a, não a rederive)

- Proposta passa e H votou sim: H é parte do acordo e recebe x_H.
- Proposta passa por maioria e H votou não: H não é parte; recebe **apenas** sua outside option o; a fatia x_H **não é paga a ninguém** (a concessão é específica a H e intransferível a outro jogador); quando x_H>0 nesse evento, a soma distribuída fica abaixo de 1 — sem contradição com a pie fixa, que significa factibilidade (soma ≤ 1) mais exaustão **em equilíbrio**, como o manuscrito já enuncia.
- NUNCA somar alocação da pie e outside option em nenhum histórico (Fundamento 4).
- Timing inalterado: payoffs pagos na data em que o jogo termina.
- Sem tetos em propostas: X = {x_H ≥ 0, x_j ≥ 0, x_H+Σx_j ≤ 1} (Fundamento 5; o parâmetro `\bar x_H`/`y_bar` foi deletado por decisão de 2026-09-01).

## O que derivar (o texto candidato da EMENDA é insumo, não implementação)

1. O voto de H quando não-pivotal sob a regra nova: sim dá x_H, não dá o; indiferença exata resolve em sim pela convenção de desempate vigente no conceito de solução. Derivar, não assumir.
2. A dominância de x_H=0 na classe de exclusão (expectativa registrada: torna-se **estrita** sob a regra nova, porque x_H>0 é desperdiçado quer H aceite quer não — verificar) e a consequência para as afirmações de unicidade de outcome em prop:terminal e prop:majority.
3. Checagens obrigatórias: (a) nenhum passo remanescente usa a regra antiga com x_H>0; (b) varredura completa do Apêndice B por menções à regra antiga; (c) confirmar que nenhum payoff, cutoff, classe de equilíbrio, crença ou correspondência muda em relação ao texto vigente das proposições. A análise de invariância existente na decisão é de Fable e NÃO vale como aval — refaça de forma independente e reporte.

## Definições que você deve ter claras (do autor, 2026-09-01)

1. **Desacordo por insuficiência de surplus é resultado legítimo do modelo**: desacordo/atraso pode ocorrer em equilíbrio quando a pie unitária é insuficiente para cobrir a soma das continuações exigidas para a proposta passar (exemplo já derivado no paper: a região de delay do estágio de agenda sob maioria pública, onde βo > 1 − kβ/m). Não assuma que acordo sempre ocorre; não trate ramos de falha ou atraso como anomalia a consertar. No baseline R1 sob maioria, o atraso deliberado é derivado como dominado — conclusão, não premissa. Falha por screening (oferta baixa rejeitada pelo tipo forte) é fonte distinta e igualmente legítima de desacordo no caminho.
2. **Structural consistency está definida no baseline** (decisão APPROVED de 2026-09-01; texto no manuscrito em Solution concept e A.2): crenças mensuráveis no registro de votos de H; Bayes dada a lei prescrita quando o denominador é positivo sob a crença de entrada; denominador zero → um único valor livre por par (ballot, voto de H), dentro do suporte do prior; valores livres locais a cada ballot. Em B.1 (informação completa) e B.3 (continuação de maioria belief-free) crenças quase não entram, mas qualquer passo que as toque usa essa definição e nenhuma outra.

## Protocolo de provas (obrigatório)

- Quem implementa não revisa; quem revisa não implementa.
- Implementador: deriva, edita SOMENTE B.1 e B.3 em `formal_model_v6.Rmd`, recompila com `rmarkdown::render("formal_model_v6.Rmd")` (sem argumento output_format), salva nota de derivação em `quality_reports/`.
- Em seguida, DOIS revisores independentes, sem edição de arquivos: um de desenho formal, outro de auditoria game-teórica adversarial. Pareceres COMPLETOS salvos em `quality_reports/2026-09-XX_*.md` — nunca truncar, nunca salvar só resumo.
- Findings escalam por default; toda ambiguidade e definição faltante escala, sem exceção.
- Não tocar: artefatos em `model_redesign/` (congelados; as correções sobre eles são erratas de leitura já registradas na decisão), as definições do jogo (aprovadas), qualquer outra prova ou seção.
- Paper é documento atemporal: proibido "the new rule", "we have changed", "previously" — escrever como se sempre tivesse sido assim.
- Não inventar terminologia: conceitos novos em frases completas; termos canônicos da literatura em inglês.
- Se algo não estiver claro, PERGUNTE ao autor antes de derivar — não escolha silenciosamente.

## Entregáveis

1. B.1 e B.3 atualizados; PDF recompilado sem warnings de referência.
2. Nota de derivação + relatório da varredura do Apêndice B (com lista de qualquer menção remanescente à regra antiga fora de B.1/B.3, para o autor decidir).
3. Dois pareceres independentes completos em `quality_reports/`.
4. Status final ao autor em linguagem sem jargão: o que foi feito, por que, e o que ele deve verificar para confirmar. Após aval do autor, remover o aviso de inconsistência temporária no dashboard e na nota explicativa.
