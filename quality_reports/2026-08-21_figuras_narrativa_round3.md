# Figuras da narrativa — Round 3

- **Data**: 2026-08-21
- **Worktree**: `/private/tmp/PowerBayesianPersuasion-figures-narrative`
- **Branch**: `codex/essential-input-figures-narrative`
- **Base preservada**: commit `e7ea88c` (entrega do Round 2 antes dos reparos)
- **Auditoria de entrada**: `quality_reports/2026-08-21_visual_audit_figuras_narrativa_round2.md`, lida no repositório principal

## Escopo e limite de autoridade

Esta rodada executou os reparos de prioridade ALTA e MÉDIA indicados pela auditoria do Round 2, acrescentou à F1 a leitura ex ante autorizada pelo autor e salvou este relatório no repositório. A implementação apenas transforma em figura os vetores de payoff privados já congelados em N6. Não deriva um novo equilíbrio, não seleciona um elemento adicional da correspondência e não usa o benchmark público de N7.

O manuscrito `formal_model_v6.Rmd`, a Tabela C1, as fontes formais congeladas e a interface N6 não foram editados. A interface N6 consumida continua sendo `model_redesign/essential_input_n6_private_comparison_candidate.json`, SHA-256 `a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92`.

## F1 — comparação por tipo e comparação ex ante

### O que mudou

1. As caixas com fórmulas completas dentro dos painéis foram substituídas por rótulos curtos nas fronteiras: `nu*`, `nu_SP`, `nu_SE` e `nu_XA`. As fórmulas completas permanecem na caption.
2. Foi acrescentada a terceira faceta **“Ex ante (before H learns its type)”**.
3. A legenda passou a dizer **“H's payoff comparison (private information)”**, evitando o rótulo interno “Private-rule comparison”.
4. A largura da figura aumentou para acomodar as três facetas sem comprimir títulos, fronteiras e rótulos.

### Como a faceta ex ante foi calculada

N6 preserva, para cada regra, o vetor de payoff privado de H por tipo,

```text
(U_H(theta=0), U_H(theta=1)).
```

A faceta nova aplica o mesmo prior da figura a cada vetor:

```text
U_H^exante = (1-nu) U_H(theta=0) + nu U_H(theta=1).
```

Somente depois dessa ponderação a figura calcula unanimidade menos maioria. Quando N3 preserva mais de uma classe selecionada, a função mantém todos os vetores correspondentes; ela não recombina marginais nem escolhe um deles. Na região sem PBE puro sob unanimidade, a comparação ex ante continua vazia.

Na classe em que a maioria exclui H, a igualdade ex ante produz a fronteira já registrada pela auditoria:

```text
nu_XA = (beta-kappa)/(1-kappa), com o0 = kappa o1.
```

Isso é apenas a imagem do vetor N6 pelo prior, não uma nova derivação do jogo. A implementação foi checada em 653 pontos por fatia para `kappa = 0.25`, `2/7`, `0.50` e `0.75`, comparando a região desenhada com o sinal obtido diretamente dos vetores selecionados.

No exemplo trabalhado (`o0=0.10`, `o1=0.35`, `m=4`, `beta=0.90`, `nu=0.35`), a maioria seleciona exclusão e entrega o vetor `(0.10, 0.35)`; a unanimidade em pooling entrega `(0.315, 0.315)`. Logo,

```text
maioria ex ante    = 0.65(0.10) + 0.35(0.35) = 0.1875;
unanimidade ex ante = 0.65(0.315) + 0.35(0.315) = 0.3150;
diferença U-M       = 0.1275.
```

Portanto, o tipo baixo prefere unanimidade, o tipo alto prefere maioria e H prefere unanimidade ex ante antes de saber seu tipo.

**Frase da figura**: o consenso remunera o hegemon que é mais fraco do que parece; o tipo forte preferiria ser excluído, mas a unanimidade ainda pode ser preferida ex ante porque o ganho do tipo baixo supera a perda descontada do tipo forte.

Esta conclusão usa a convenção temporal congelada: quando a maioria exclui H e o jogo termina no primeiro round, H recebe `o_theta` nessa data; sob unanimidade, o preço de pooling é `beta o1`. A figura não substitui essa convenção pela alternativa de pagar toda opção externa apenas no final do horizonte.

## F2 — preços e anatomia da coalizão

### Reparos executados

1. **Costura das facetas**: o espaçamento horizontal foi ampliado; os rótulos `1.0` e `0.0` não se sobrepõem mais.
2. **Dois tipos no mesmo preço sob unanimidade**: a linha sólida do tipo baixo é desenhada primeiro e a linha tracejada, mais fina, do tipo forte é desenhada por cima. Uma chamada explícita informa “both types receive h”.
3. **Opção externa fora do bolo**: os marcadores de `o0` e `o1` foram deslocados para junto da barra de maioria e receberam a chave “H excluded: collects o_theta outside the pie”.
4. A caption foi atualizada para explicar tanto a coincidência das linhas quanto os marcadores externos. O compositor foi corrigido para ancorar captions longas no topo da área reservada, eliminando o corte no rodapé de F2 e preservando F3.

**Frase da figura**: a maioria limita o preço de H comprando votos substitutos; a unanimidade precisa comprar o próprio hegemon e, em pooling, paga aos dois tipos o preço do tipo forte.

### Por que não foi acrescentado o Painel C de delay

N6 contém distribuições de resultado comparáveis, portanto a omissão não se apoia em ausência de dados. No exemplo trabalhado, porém, o contraste de delay é não zero somente numa faixa muito estreita:

```text
nu* = 0.277778;
nu_SE = 0.293478.

0 < nu <= nu*       : unanimidade não tem PBE puro; não há comparação entre regras;
nu* < nu <= nu_SE   : maioria faz screening e atrasa com probabilidade nu;
                       unanimidade faz pooling sem atraso;
nu > nu_SE          : maioria exclui H e unanimidade faz pooling;
                       ambas encerram o jogo no round 1, com delay zero;
nu = 0              : ambas encerram sem atraso.
```

Um terceiro painel completo reservaria quase toda a área para uma linha zero e repetiria as duas fronteiras já marcadas no Painel A. Nesta versão, a escolha de desenho é manter F2 concentrada em preços e anatomia da coalizão e registrar aqui o contraste exato de delay. Se o atraso se tornar uma afirmação principal do manuscrito, a forma informativa será um inset ampliando apenas `(nu*, nu_SE]`, não um painel de largura integral.

## F3 — decomposição de poder e informação

F3 continua sendo um placeholder sintético, marcado como aguardando N7. Nenhum resultado público foi importado. A única mudança indireta foi a correção do compositor compartilhado de captions, que agora mostra integralmente a nota de que os valores são sintéticos e não têm interpretação substantiva.

## F4 — declínio hegemônico

O preenchimento laranja de altura total foi substituído por duas camadas: um campo laranja muito leve identifica a região de pooling e uma faixa mais escura entre `ell` e `h` isola a renda que realmente importa. A linha de payoff, a região hachurada de instabilidade, a leitura da direita para a esquerda e o endpoint isolado em `nu=0` foram preservados.

**Frase da figura**: quando a força crível declina, a renda de pooling dá lugar a uma região sem padrão puro estável; em `nu=0`, a fraqueza de H é conhecimento comum e ele é comprado por sua reserva.

## Saídas e verificação mecânica

O gerador `scripts/generate_essential_input_manuscript_figures.R --include-example-slice` produz 13 bundles, cada um com PDF vetorial, PNG de inspeção e CSV dos dados da figura, além do manifesto `figures/draft/essential_input_manuscript_figure_manifest.csv`.

Foram realizados:

- geração integral dos 13 bundles;
- verificação automática da imagem ex ante em 2.612 pontos no total;
- inspeção visual das oito variantes de F1;
- inspeção em cor e escala de cinza de F1, F2 e F4;
- reinspeção de F3 após a correção do compositor;
- checagem de captions e bounding boxes;
- verificação de PDFs vetoriais, presença dos arquivos e consistência do manifesto;
- nova execução dos verificadores Gate 0 e N6;
- conferência de que o manuscrito e os artefatos protegidos permaneceram sem diff.

Estas são verificações mecânicas e visuais do implementador. Elas não substituem a auditoria independente exigida pelo protocolo do projeto.

## Pendências deliberadamente preservadas

1. F3 só pode receber dados substantivos depois da autorização e do congelamento aplicável de N7.
2. A migração das figuras para `formal_model_v6.Rmd` não foi aberta nesta rodada.
3. A decisão de usar a variante normalizada no corpo e a variante raw no apêndice continua sendo uma recomendação editorial, não uma alteração do manuscrito.
4. Uma nova auditoria independente deve avaliar a entrega Round 3 antes da integração ao paper.
