# Auditoria adversarial de teoria dos jogos: baseline de opt-out imediato

## Rodada 1

- **Commit revisado:** `70969f5f14bdc63d557bc6d7d1e27bb3aa4c5304`.
- **Revisor:** agente independente read-only
  `/root/adversarial_final_reviewer`.
- **Workflow:** `game-theory-audit`.
- **Edição pelo revisor:** nenhuma.
- **Veredito:** **REPAIR**.

### Achados

| Severidade | Achado | Consequência |
|---|---|---|
| major | `mu=0,1` eram prometidos, mas não derivados. O jogo degenerado literal depende de uma convenção sobre estratégias e crenças para tipos de probabilidade zero. | Era necessário escolher casos degenerados ou limites, conforme autorizado pela Especificação operacional. |
| major | A completion off-path regular não declarava conjuntamente a crença no ballot e o posterior na continuação. | A suficiência dependia de PBE fraco sem consistência Bayes local dentro de uma subtree globalmente off-path; essa dependência precisava ser explícita. |
| major | As fronteiras tinham fórmulas plausíveis, mas não provas de ballots, garantias, completions e ties. | O proof ledger superestimava seu status. |
| minor | A weak-vote-passive assessment deveria dizer expressamente que não impõe consistência local em uma proposta globalmente off-path. | Evita confusão com sequential equilibrium. |
| minor | A maioria grande deveria construir a suficiência de `[F_M,1]` e tratar o tie em `F_M`. | A construção existia implicitamente, mas não estava escrita. |

Não houve finding crítico. O stress test adversarial aprovou Gate 0, R2, os
teoremas regulares interiores de unanimidade e maioria, os bounds, nesting e o
ranking institucional no domínio comum. Também confirmou que nenhuma fórmula
de delayed continuation, híbrido ou `t_theta` foi importada e que
`formal_model_v6.Rmd` permaneceu intacto.

### Resposta do implementador

1. O documento escolhe explicitamente limites laterais de PBEs interiores. A
   nova correspondência `L_e^R` não faz qualquer alegação sobre um jogo
   degenerado literal e deriva os limites exatos por regra e tamanho de grupo.
2. A crença do ballot off-path retém o prior, pois o proposer é desinformado;
   a continuação globalmente off-path declara o posterior pooling. O texto
   explica por que PBE fraco não liga essas crenças e nega robustez a uma
   solução mais forte.
3. As provas de fronteira foram incorporadas.
4. A construção de maioria para cada `v in [F_M,1]`, inclusive `v=F_M`, foi
   explicitada.

## Rodada 2

- **Commit revisado:** `db52b2030b4c4e8e84c845a18ea04d4c2a27ab9c`.
- **Veredito:** **PASS sem ressalvas substantivas**.
- **Critical/major/minor:** nenhum.
- **Editorial:** apenas os marcadores administrativos ainda pendentes no
  commit revisado.

O stress test aprovou o PBE fraco e o par de crenças off-path, as garantias
`G_L/G_P`, `K_0`, `K_1`, a não existência em `o1=1`, todos os endpoint limits,
a construção de maioria grande e o nesting/ranking. Confirmou novamente Gate
0 intacto, ausência de extensões no baseline e SHA-256 de v6 inalterado.
