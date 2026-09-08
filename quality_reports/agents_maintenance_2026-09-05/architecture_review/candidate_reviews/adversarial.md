# Parecer adversarial das instruções e da nota de arquitetura

Data: 2026-09-05. Revisor independente: `/root/offpath_requirement`.

**Resultado: PASS 0/0/0, limitado ao candidato e ao escopo abaixo.** Não foram identificados defeitos críticos, maiores ou menores que exijam correção nesse candidato. Não se trata de certificação da arquitetura ou da solução completa do jogo.

## 1. Escopo e materiais

Foram lidos integralmente `AGENTS.md`, `architecture_clarification.md`, `approval.md`, `README.md` e a transcrição literal da correção autoral. A revisão examinou a fidelidade ao pedido, os quantificadores relativos a tipos e histórias, o alcance do lema terminal, as referências ao jogo histórico e a ausência de uma arquitetura substituta adotada silenciosamente.

Todos os hashes do manifesto recebido foram recalculados e coincidiram:

| Arquivo no candidato | SHA-256 |
| --- | --- |
| `AGENTS.md` | `da9c31477274309e6b34ed77637e74387026b2c6f7dee47c35ecb88080568d54` |
| `quality_reports/agents_maintenance_2026-09-05/AGENTS.approved.md` | `da9c31477274309e6b34ed77637e74387026b2c6f7dee47c35ecb88080568d54` |
| `quality_reports/agents_maintenance_2026-09-05/AGENTS.before_architecture_clarification.md` | `695069a7b432a3204f43619931c211c8327f8533b30d3cfa969e42bba3806522` |
| `quality_reports/agents_maintenance_2026-09-05/README.md` | `8d1c9037e685ca1bfddfdf4eb7e79f0589a2e9a8416816c50360d082b9a0d6b8` |
| `quality_reports/agents_maintenance_2026-09-05/approval.md` | `bebd9cc09304ca71ad0182ba759817da5e2b3358177cf8577636bc4bc4ae5fd8` |
| `quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md` | `b523d944ee4e9e2589a8837682a40e07687d92b2d4e3c2fd049267a2420a81c4` |

Também foram conferidos no repositório os trechos indicados da especificação e das provas históricas:

- `formal_model_v6.Rmd`: SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`; linhas 309–379 e 1385–1494.
- `quality_reports/2026-09-01_b1_b3_exclusion_derivation.md`: SHA-256 `2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256`; linhas 17–140.

## 2. Ataques examinados e conclusões

1. **Transformação de um resultado desejado em restrição primitiva.** O novo item 4 retira o cancelamento como solução vigente, conserva os ramos de payoff já esclarecidos e identifica a demonstração como aberta. A seção de derivação proíbe impor `x_H=0` como restrição adicional. A fórmula da nota é apresentada como obrigação candidata de prova para a explicação pela racionalidade, não como regra de viabilidade. Não há arquitetura nova selecionada.

2. **Supressão de seleção de tipos.** A nota não exige que toda proposta positiva seja aceita por todos os tipos. Exige examinar a interseção entre aprovação e voto não. Logo, uma oferta aceita por um tipo e rejeitada por outro continua admitida quando a rejeição implica fracasso. Isso está explícito tanto na nota quanto no AGENTS.

3. **Uso de certeza ex ante como se fosse certeza sobre o tipo verdadeiro.** A nota define a certeza na informação e crença do proponente, reconhece que rejeição por somente alguns tipos exige análise própria e não permite condicionar a proposta ao tipo privado verdadeiro.

4. **Descarte de tipos com posterior zero.** A garantia quase certa sob a crença local é expressamente distinguida da cobertura de todos os tipos ainda factíveis. O candidato exige examinar esses casos separadamente. Não altera a disciplina de crenças aprovada para alcançar uma conclusão.

5. **Uso de otimalidade para apagar desvios.** A nota e o AGENTS distinguem a escolha ótima em conjuntos de informação fora do caminho da resposta a propostas desviantes. Reconhecem que os ramos resultantes permanecem na árvore e exigem payoffs e respostas definidos. Nenhuma afirmação equipara a propriedade sobre propostas ótimas à cobertura de todas as histórias factíveis.

6. **Restauração silenciosa do payoff aditivo ou criação de uma ação posterior.** A nota exclui explicitamente essas interpretações da presente atualização. O ramo disputado permanece aberto para especificação econômica e revisão substantiva. A distinção entre voto, participação, alocação e exercício da opção externa impede usar uma troca de rótulo para repetir o cancelamento.

7. **Extensão indevida de revisões históricas.** A nota identifica corretamente o cancelamento nos payoffs do manuscrito e o uso dessa regra nas respostas não pivotais de H. O argumento de dominância do proponente é separado da regra usada para obter o voto de H. A conclusão não declara falsidade do lema no jogo anterior nem transporta seus pareceres para o novo requisito.

8. **Histórico confundido com instrução atual.** `approval.md` conserva as passagens anteriores para proveniência, mas abre com a precedência da correção posterior e encerra com sua substituição explícita. O README e o índice do AGENTS remetem à nota vigente. A sequência não apresenta o cancelamento antigo como comando atual.

## 3. Reconstituição do lema terminal

Sob maioria, com `m≥3`, a quota de respondedores é `k=floor((m+1)/2)` e satisfaz `k≤m−1`. O proponente já conta como sim. Na rodada terminal, cada respondedor fraco recebe zero no desacordo e `x_j≥0` na aprovação. A regra aprovada de comparação pivotal e desempate a favor de sim fixa sim para toda proposta factível, inclusive quando `x_j=0`. Essa conclusão independe da crença sobre H.

A proposta que aloca 1 ao proponente e zero aos demais é factível e passa apenas pelos votos fracos. Portanto, entrega 1 ao proponente, qualquer que seja a ação de H. Qualquer proposta com `x_H>0` entrega ao proponente no máximo `1−x_H<1` na aprovação e zero no fracasso. Assim, nenhuma proposta ótima terminal pode atribuir valor positivo a H.

A comparação não utiliza o payoff de H no ramo contestado. Ela também não utiliza uma regra de devolução posterior: o desvio é outra proposta, escolhida antes da votação. O candidato limita corretamente a conclusão às propostas ótimas terminais e não infere a resposta de H depois de uma proposta positiva desviadora.

## 4. Verificação adicional de R1 solicitada durante a revisão

Esta verificação não altera o veredicto sobre os hashes acima e não estava incorporada ao candidato recebido. Ela identifica um avanço possível para uma versão posterior, sujeito à leitura dos novos arquivos exatos.

No baseline de duas rodadas, o argumento pode ser estendido como certificado parcial de dominância em R1. As linhas 309–312 do manuscrito especificam sorteios uniformes independentes, com reposição, entre os mesmos `m` fracos. Em qualquer história terminal, a proposição da seção anterior e a possibilidade de reduzir a zero as demais concessões implicam payoff 1 ao fraco reconhecido e zero aos outros fracos. Antes do reconhecimento de R2, cada fraco tem, portanto, continuação `C_j2=1/m`, qualquer que seja a crença ou o comportamento de H. Em unidades de R1, a continuação é `β/m`.

A diferença entre aprovação e fracasso para um respondedor fraco em R1 é então `x_j−β/m`, em todos os estados relevantes. A disciplina de voto aprovada e `T^Y` fixam seu voto como sim exatamente quando `x_j≥β/m`. O voto não depende do tipo de H, da alocação de H ou da do proponente.

Considere agora uma proposta positiva para H que possa passar quando H vota não. Ela precisa reunir `n_Y≥k` respondedores fracos. Mantendo suas alocações, reduzindo `x_H` a zero e aumentando `x_i` em `x_H`, preservam-se os votos fracos, a aprovação e a viabilidade. O proponente ganha exatamente `x_H>0`, para qualquer voto ou tipo de H. A proposta original não é ótima. Essa conclusão vale tipo a tipo, inclusive para tipos com posterior zero, e em cada conjunto de informação do proponente. Se `n_Y<k`, a aprovação já requer o voto sim de H.

O argumento é uniforme em qualquer completamento do payoff de H que preserve o restante do protocolo e os pagamentos dos fracos. Não define o payoff disputado, não demonstra a existência de um equilíbrio do jogo ainda incompletamente especificado, não fecha a estratégia de H e não remove propostas desviantes. Pode-se afirmar a propriedade sobre propostas ótimas em R1/R2, mantendo essas limitações. O candidato atual, que declara R1 ainda por verificar, não contém um erro por se limitar ao resultado terminal.

## 5. Referência e limite da certificação

A referência a Muhamet Yıldız foi aberta e conferida. A seção 1.1 define árvore, ações e utilidades nos nós terminais; a seção 4.1 distingue estratégias e melhores respostas em cada conjunto de informação. A citação sustenta a distinção geral empregada na nota. Ela não demonstra o lema deste projeto e não substitui seu conceito específico de solução. Fonte: [Graduate Game Theory, notas de Yıldız](https://ocw.mit.edu/courses/14.126-game-theory-spring-2024/mit14_126_s24_yildiz-lecture-notes.pdf), seções 1.1 e 4.1, consultada em 2026-09-05.

Nenhum arquivo do candidato ou do repositório foi alterado pelo revisor. Não foram executados scripts de análise, renderização do artigo ou testes da solução completa. O parecer cobre a fidelidade e a precisão conceitual das instruções e da nota nos hashes registrados. Mudanças posteriores exigem conferência do novo candidato.
