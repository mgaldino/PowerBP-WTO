# DECISÃO 2026-09-01 — Payoffs de exclusão mutuamente exclusivos, deleção de \bar x_H e Fundamentos invioláveis

**Status**: APPROVED (decisão do autor, 2026-09-01: "Fechado, vamos assim")
**Autor da decisão**: Manoel Galdino
**Origem**: sessão de 2026-09-01. O autor identificou duas primitivas indevidas: o ramo `x_H+o` quando maioria passa sem H, e o teto `\bar x_H` sobre a alocação de H. Investigação de proveniência (Codex + Fable) rastreou o `x_H+o` à decisão D1/D2 de 2026-08-12 (`quality_reports/2026-08-12_essential_input_gate0_decisions.md`), que reverteu sem se anunciar como reversão a proibição explícita do plano de 2026-08-03 ("nunca somar y com o no mesmo histórico"); o teto `y_bar` está no contrato Gate 0 (linhas 297, 301) mas nenhuma prova o utiliza. A defesa substantiva do D1 tentada em sessão (free-riding/MFN) foi refutada pelo autor: o jogo é distributivo puro, sem externalidades nem bens públicos — não há sobre o que pegar carona.

---

## Decisão 1: Payoffs de exclusão mutuamente exclusivos (supersede D1/D2 de 2026-08-12)

- **Escolha**: acordo e desacordo são mutuamente exclusivos em todo histórico. Se uma proposta passa, ela é implementada **entre as partes do acordo**: cada respondente fraco recebe x_j, o proponente recebe x_i, e H recebe x_H **se votou sim**. Se H votou não e a maioria passou sem ele, H não é parte: recebe sua outside option o_θ e nada da pie; a fatia x_H, inentregável a não-parte, acresce ao residual do proponente (reversão). Fundamento substantivo: a barganha é sobre acordos distributivos de clube dentro da OI; o pacote da coalizão vencedora não vincula nem paga quem ficou fora; o o_θ é o valor do melhor fórum alternativo de H (forum shopping).
- **Invariância (análise de Fable, 2026-09-01 — A VERIFICAR por revisor independente)**: nenhum objeto de equilíbrio muda. Toda exclusão de equilíbrio tem x_H=0 (B.1/B.3), então H recebe exatamente o_θ sob ambas as convenções; o ramo antigo só (i) fixava o voto off-path de H não-pivotal (estritamente não) e (ii) definia payoffs em desvios dominados que terminam o jogo (aprovação → terminal, sem crença nem continuação). Sob a nova convenção, H não-pivotal vota sim sse x_H ≥ o_θ (T^Y na igualdade); em x_H=0 o voto continua não. O cálculo as-if-pivotal dos fracos nunca referencia o payoff de H. Propostas que diferem apenas num x_H que reverte são payoff-equivalentes para todos; o reporte usa o representante x_H=0 (quociente análogo ao de permutação de identidades fracas).
- **Alternativas descartadas**:
  - **Manter D1 (x_H+o)**: descartada — sem interpretação substantiva defensável num jogo distributivo puro (free-riding refutado), outlier também na literatura vizinha (Glynia–Thum–Xefteris: medida adotada vincula todos, U_i=t_i−c_i, desacordo zero só na rejeição; Piazolo–Vanberg: breakdown value só sem acordo; ninguém soma), e contrária à proibição explícita do plano de 2026-08-03.
  - **x_H destruído**: descartada — pie encolheria off-path, contradizendo a pie fixa (mesma razão de 2026-08-12).
  - **Convenção de política vinculante (H excluído recebe alocação, perde o_θ)**: descartada — é a convenção dos vizinhos (orçamento/reforma que vinculam todos, inclusive Kalandrakis JET 2004 com status quo endógeno), mas errada para o domínio: o objeto aqui é acordo de clube dentro da OI, e o excluído faz forum shopping (bilaterais, OMPI, coalition of the willing — Voeten 2001 APSR; Helfer 2004; Busch 2007; Morse–Keohane 2014; Lipscy 2017). Adotá-la mudaria payoffs de exclusão de o_θ para 0 e destruiria a região XX e o resultado "tipo forte prefere maioria" — seria outro paper.
  - **Justificar via pacta tertiis (tratado não vincula não-parte)**: descartada como fundamentação — H já é membro da OI quando barganha; o que ele perde é o pacote, não a membership. A fundamentação correta é forum shopping.
  - **Justificar via "em BF o proponente não altera o status quo dos rejeitados"**: descartada — falsa como afirmação sobre a tradição legislativa (com reversão orçamentária, o orçamento aprovado substitui o status quo de todos; Romer–Rosenthal; Kalandrakis 2004). BF 1989/Kalandrakis 2006 têm desacordo zero e alocação zero ao excluído: as convenções coincidem e BF não adjudica. O que se herda de BF é o protocolo, não a estrutura de desacordo.

## Decisão 2: Deleção do teto \bar x_H (e do y_bar do baseline)

- **Escolha**: o espaço de propostas é X = {x_H ≥ 0, x_j ≥ 0, x_H+Σx_j ≤ 1}. Sem teto. O parâmetro sai da definição do modelo, da tabela de notação, do vetor de parâmetros do E.1 e dos worked values.
- **Fundamento**: (i) inconsistente com BF/Kalandrakis (proponente pode propor a pie inteira para si); (ii) nunca binde em nenhum objeto congelado — no DAG do baseline aparece só em declarações de domínio; o candidato N4 não o menciona; nenhuma proposição ou prova do manuscrito o invoca; (iii) os contratos congelados M/S/B derivaram o jogo SEM teto (A_U define z_H = 1−β+d diretamente), então mantê-lo com \bar x_H < 1 contradiria as fórmulas da extensão para β pequeno (ex.: β=.5, h=.6=\bar x_H dá v_U^A(h)=.65 > .6).
- **Alternativa descartada**: manter o parâmetro "por segurança" — descartada; é exatamente o tipo de primitiva órfã que gera inconsistência silenciosa.

## Erratas de leitura (artefatos congelados intactos, padrão errata-N2)

1. `model_redesign/essential_input_game_dag.json`, linhas 1576 e 1640 ("no yields y+o_0>y" / "y+o_1>y"): ler sob a Decisão 1 — o voto não de H não-pivotal permanece prescrito nos registros relevantes (x_H=0 ⇒ o_θ > 0 = x_H), mas a justificativa passa a ser "não dá o_θ e sim dá x_H=0", não a soma. Nenhum payoff, estratégia on-path ou crença muda.
2. Declarações de domínio com `o_1 <= y_bar <= 1` no DAG e no contrato Gate 0: ler com y_bar := 1 (restrição vácua). Nenhuma condição derivada as utiliza.
3. `quality_reports/2026-08-12_essential_input_gate0_decisions.md` (D1/D2): superseded por este registro na parte do destino de y e do ramo x_H+o; a parte de data/timing dos payoffs (P1, "pagos quando o jogo termina") permanece válida e intocada.

## Fundamentos invioláveis (aprovados junto)

Inseridos em CLAUDE.md e AGENTS.md com duas regras de operação: (1) toda proposta de protocolo/convenção é checada contra a lista ANTES de escalar — violação não é opção escalável, é violação reportável; (2) reversão de fundamento exige nomear-se como tal, fora de lote, com assinatura autoral individual. Motivação: o episódio D1 mostrou que o básico não escrito perde para o racional escrito.

## Itens autorizados para o próximo manuscript pass (não executados nesta decisão)

- Frase de escopo na seção do modelo: acordos distributivos de clube vs. decisões que vinculam todos os membros (assessments/quotas fora do escopo).
- Parágrafo de microfundação forum-shopping do o_θ (com o vínculo a Fearon 1995: valor privado do caminho externo) e a assimetria o=0 dos fracos.
- Ressalva em Limits: o_θ invariante ao acordo dos demais (sem desvio de comércio; caso GATT-47 como contraexemplo deliberado).
- Remark de isomorfismo com tipos de custo de aceitação: idênticos na margem de aceitação, divergentes no valor de exclusão e nas cunhas temporais — onde vivem os resultados do paper.
- Checar/adicionar ao references.bib: Voeten 2001 (APSR), Helfer 2004, Busch 2007 (IO), Alter–Meunier 2009, Raustiala–Victor 2004, Morse–Keohane 2014 (RIO), Lipscy 2017, Jupille–Mattli–Snidal 2013.

## Verificação obrigatória (próximo ciclo de revisão independente)

1. Confirmar a invariância da Decisão 1: nenhum payoff, cutoff, classe, crença ou correspondência muda em registro algum (a análise acima é de Fable; quem analisa não dá o próprio aval).
2. Confirmar que a deleção do teto não remove nenhuma restrição usada implicitamente em alguma prova (varredura de usos: linhas 318/321/1675/1704/1707/2078 do Rmd pré-edição; DAG só domínio).
3. Confirmar que o quociente de reporte (representante x_H=0) é consistente com a linguagem de unicidade de outcome nas proposições (prop:terminal, prop:majority).

## Proveniência

| Objeto | Caminho |
|---|---|
| D1/D2 supersedido | `quality_reports/2026-08-12_essential_input_gate0_decisions.md` |
| Proibição original | `quality_reports/plans/2026-08-03-clean-baseline-goal.md` |
| Contrato Gate 0 (y_bar, y+o) | `quality_reports/plans/2026-08-12_essential_input_gate0.md` (linhas 297, 301, 418, 502, 610–615) |
| Vizinhos verificados em fonte primária | `references/modelo_similar_public_choice.pdf` (Seção 4 + fn. 12), `references/modelo_similar_geb.pdf` |
| Análise de invariância e blast radius | conversa da sessão 2026-09-01 |

---

## EMENDA (2026-09-01, mais tarde no mesmo dia — decisão do autor)

**O que muda.** O destino da fatia x_H quando H fica fora do acordo deixa de
ser "reverte ao residual do proponente" e passa a ser: **a fatia não é paga a
ninguém, porque a concessão é específica a H e não pode ser transferida a
outro jogador**. Quando x_H > 0 nessa situação, a soma distribuída fica
abaixo de 1.

**Por que a reversão foi descartada.** (i) Sem microfundamentação: o
proponente não tem título sobre uma concessão específica de terceiro — numa
conferência internacional, o redator não embolsa o carve-out não utilizado de
outro Estado. (ii) A reversão é, ela própria, uma cláusula contingente ao
voto ("se H votar não, x_H passa a ser meu"), exatamente o que a decisão de
2026-08-12 proibiu por princípio. (iii) A reversão criava famílias de
propostas com payoffs idênticos (reservar 0.1 que reverte = reservar 0),
exigindo uma frase auxiliar no Apêndice A dizendo qual representante as
proposições descrevem — frase agora deletada por desnecessária.

**Por que "não pagar a ninguém" não contradiz a pie fixa.** Pie fixa em 1
significa a restrição de factibilidade (soma ≤ 1) mais a propriedade de
equilíbrio de que a pie é exaurida no caminho — que é o que o manuscrito já
diz ("exhausted on the equilibrium path"). Nada exige que toda proposta
hipotética fora do caminho exaura a pie; a objeção de 2026-08-12 contra essa
opção ("a pie encolheria") lia exaustão como identidade nó a nó, o que é
leitura errada. A fatia não paga nunca ocorre em equilíbrio: reservar fatia
positiva para quem não é necessário reduz o que o proponente pode ficar.

**O que foi editado agora (somente definições do jogo, aprovadas item a item
pelo autor):**
1. Seção The model, parágrafo da proposta aprovada: "...the share x_H is paid
   to no one, because the concession is specific to H and cannot be
   transferred to another player."
2. Tabela de protocolo, célula "H votes no": "o; x_H is paid to no one, so
   the total distributed falls below one when x_H>0". Removida a nota de
   reversão da coluna dos fracos.
3. Apêndice A.1: "after no, H receives o and x_H is paid to no one"; deletada
   a frase auxiliar sobre representante com x_H=0 (mantida a frase de
   exclusão mútua e a frase pré-existente "All equilibrium exclusions pay H
   exactly o").
4. Fundamento nº 4 (CLAUDE.md/AGENTS.md): "alocação a não-parte não é paga a
   ninguém — a concessão é específica ao ator e intransferível".

**O que NÃO foi editado — provas seguem o protocolo editorial próprio.** O
autor determinou que alterações em provas (Apêndice B) e qualquer afirmação
nova sobre comportamento de equilíbrio ("o proponente prefere...") passam
pelo processo editorial de provas: implementador distinto, revisão formal
independente, mesmos passos das demais provas. Em consequência:

- As edições que Fable fez em B.1 e B.3 na manhã de 2026-09-01 (que
  introduziram a reversão nas provas) foram DESFEITAS: B.1 e B.3 voltaram ao
  texto anterior à sessão, que usa a regra antiga x_H+o.
- **AVISO DE INCONSISTÊNCIA TEMPORÁRIA**: até o processo editorial de provas
  rodar, o manuscrito define o jogo com a regra nova (Seção The model, tabela
  de protocolo, Apêndice A.1) enquanto as provas B.1 e B.3 mencionam a regra
  antiga x_H+o em dois passos. NÃO circular nem submeter o manuscrito neste
  estado. A tarefa está registrada no dashboard.

**Texto candidato para o processo editorial de provas (entrada, não
implementação; deve ser derivado e revisado independentemente):**

- B.1, passo do H não-pivotal: "H is nonpivotal: yes yields x_H and no yields
  o, and after a no the share x_H is paid to no one. Any x_H>0 therefore
  strictly lowers the proposer's payoff, whether H accepts it or not.
  Equilibrium exclusion has x_H=0 and H receives o."
- B.3, caso n_Y ≥ k: "the weak votes pass the proposal without H; a type with
  outside option o votes yes only when x_H ≥ o; after a no it receives o and
  x_H is paid to no one."
- Pontos que a derivação/revisão deve checar: (a) a regra de voto do H
  não-pivotal muda de "sempre não" para "sim sse x_H ≥ o" (com sim na
  indiferença exata, pela convenção de desempate) — verificar que nenhum
  registro usa a regra antiga com x_H > 0; (b) sob a regra nova a dominância
  de x_H=0 na exclusão é estrita, então as afirmações de unicidade de outcome
  das proposições valem como escritas; (c) varrer o restante do Apêndice B por
  menções remanescentes à regra antiga.
