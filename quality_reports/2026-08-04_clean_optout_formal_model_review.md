# Revisão independente do modelo formal: baseline de opt-out imediato

## Rodada 1

- **Commit revisado:** `70969f5f14bdc63d557bc6d7d1e27bb3aa4c5304`.
- **Revisor:** agente independente read-only `/root/formal_final_reviewer`.
- **Workflow:** `review-formal-model`; a dimensão de exposição também foi
  examinada pelo subagente read-only
  `/root/formal_final_reviewer/exposition_dimension`.
- **Edição pelo revisor:** nenhuma.
- **Veredito:** **REPAIR**.
- **Scores:** design 9/10; apresentação técnica 7/10; exposição 8,5/10;
  geral 8/10.

### Achados

| Severidade | Achado | Evidência no candidato |
|---|---|---|
| major | O lema de segurança de unanimidade construía o upper bound, mas não demonstrava separadamente que as propostas de garantia forçavam `G_L` e `G_P` contra toda completion sequencialmente racional. | Seção “Off-path completion lemma”, então linhas 795--850. |
| major | As proposições exatas de fronteira eram promovidas sem provas autônomas de completions, necessity/sufficiency, empates e desvios. | Seção “Unanimity boundary results”, então linhas 896--948; proof ledger. |
| minor | A caracterização de maioria deveria explicitar que propostas puras no suporte de misturas pertencem às classes listadas e que os bounds sobrevivem à mistura. | Seção de `N>=5`. |
| editorial | O status dizia aguardar verificações que já haviam passado. | Parágrafo inicial de status. |

Não houve finding crítico. O revisor aprovou o contrato Gate 0, as primitivas
`pi_H=0`, `b_theta=0` e `o_theta`, a separação entre baseline e extensões, a
comparação condicional, a matriz de sobrevivência e a autonomia visual e
textual do documento. Confirmou também o SHA-256 intacto de
`formal_model_v6.Rmd`:
`f18a999300c88e32bdc7542f3249cd258afd19a0c251c0b29c2c387a7131dbc1`.

### Resposta do implementador

1. O lema passou a separar a construção de upper bound das duas propostas de
   garantia e a provar que nenhuma completion racional pode sustentar um weak
   rejector nessas propostas.
2. As fronteiras `o0=0`, `o1=1` e `beta=1`, inclusive suas interseções, foram
   rederivadas como proposições com security values, classes on-path, desvios,
   tie-breaks, overpaid pooling e provas.
3. O escopo de misturas foi explicitado, e a maioria `N>=5` recebeu uma
   construção de suficiência para todo payoff em `[F_M,1]`, inclusive o piso.
4. O status inicial foi atualizado.

## Rodada 2

- **Commit revisado:** `db52b2030b4c4e8e84c845a18ea04d4c2a27ab9c`.
- **Veredito:** **PASS sem ressalvas substantivas**.
- **Critical/major/minor:** nenhum.
- **Editorial:** o PDF repete o cabeçalho da tabela na página de continuação;
  `y<=ybar` podia ser repetido nas condições de overpaid pooling; e o escopo
  de suporte/mistura de `N=3,4` podia igualar o detalhamento de `N>=5`.

O revisor confirmou as duas direções do lema de segurança, as crenças
off-path, todas as fronteiras e interseções, os limites laterais, a construção
de `[F_M,1]`, a comparação condicional, 96/96 checks, PDF/HTML válidos e o
hash intacto de v6. As três observações editoriais foram respondidas no
candidato administrativo de fechamento: o relatório não chama o cabeçalho de
continuação de órfão; o domínio de `y` foi repetido; e o escopo de misturas de
`N=3,4` foi explicitado.
