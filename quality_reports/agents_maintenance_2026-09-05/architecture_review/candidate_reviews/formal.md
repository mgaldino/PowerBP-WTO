# Revisão independente de instruções e nota sobre arquitetura

Data: 2026-09-05.
Revisor: `audit_architecture_dependency`.
Escopo: fidelidade à correção autoral, coerência das instruções, demonstração terminal delimitada e cobertura declarada de histórias fora do caminho. Esta revisão não certifica uma arquitetura completa ou a correspondência integral de estratégias do artigo.

## Veredito

**1 DEFECT CONFIRMED, de redação documental.** O candidato principal `AGENTS.md` e a nota `architecture_clarification.md` não apresentam defeitos confirmados no escopo desta revisão. Há uma inconsistência residual no README, descrita em F1. Ela pode ser corrigida sem alterar a derivação terminal.

Nenhum arquivo do candidato foi editado pelo revisor.

## Arquivos e hashes avaliados

Todos os hashes abaixo foram recalculados a partir dos bytes e coincidem com `candidate_manifest.json`. Todos os arquivos decodificam em UTF-8.

| Arquivo no candidato | SHA-256 |
| --- | --- |
| `AGENTS.md` | `da9c31477274309e6b34ed77637e74387026b2c6f7dee47c35ecb88080568d54` |
| `quality_reports/agents_maintenance_2026-09-05/AGENTS.approved.md` | `da9c31477274309e6b34ed77637e74387026b2c6f7dee47c35ecb88080568d54` |
| `quality_reports/agents_maintenance_2026-09-05/AGENTS.before_architecture_clarification.md` | `695069a7b432a3204f43619931c211c8327f8533b30d3cfa969e42bba3806522` |
| `quality_reports/agents_maintenance_2026-09-05/README.md` | `8d1c9037e685ca1bfddfdf4eb7e79f0589a2e9a8416816c50360d082b9a0d6b8` |
| `quality_reports/agents_maintenance_2026-09-05/approval.md` | `bebd9cc09304ca71ad0182ba759817da5e2b3358177cf8577636bc4bc4ae5fd8` |
| `quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md` | `b523d944ee4e9e2589a8837682a40e07687d92b2d4e3c2fd049267a2420a81c4` |

Foram lidos integralmente o AGENTS, a nota, o README, `approval.md` e a transcrição `review_sources/author_correction.md`. A identidade de hashes confirma que `AGENTS.approved.md` contém o mesmo texto integral do AGENTS avaliado. A cópia anterior foi verificada como fronteira preservada.

As fontes do diagnóstico também tiveram hashes recalculados:

| Fonte no projeto | SHA-256 |
| --- | --- |
| `formal_model_v6.Rmd` | `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411` |
| `quality_reports/2026-09-01_b1_b3_exclusion_derivation.md` | `2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256` |

## Finding F1: exclusividade residual no README

**Local:** `quality_reports/agents_maintenance_2026-09-05/README.md:55`.

**Trecho:** “O item 4 explicita que H recebe `x_H` apenas quando vota sim e a proposta é aprovada”.

**Diagnóstico:** o advérbio “apenas” afirma que votar sim é uma condição necessária para receber a alocação. Isso ultrapassa a afirmação preservada pelo autor, segundo a qual sim e aprovação asseguram `x_H`, e decide por exclusão o ramo com voto não que a atualização deixa pendente de arquitetura. A seção relata a etapa de esclarecimento anterior, mas descreve no presente o item 4 atual. A nota atual, linhas 18 e 70–74, determina que o ramo ainda seja especificado economicamente. O AGENTS atual, linha 21, corretamente evita essa condição necessária.

**Impacto:** a documentação de uso pode recolocar uma exclusividade de pagamento como regra de partida, precisamente no ponto em que o usuário exigiu uma derivação. O problema é documental e localizado; não invalida o lema terminal.

**Correção mínima sugerida:** retirar “apenas”: “O item 4 explicita que H recebe `x_H` quando vota sim e a proposta é aprovada”. Alternativamente, descrever explicitamente a frase inteira como redação histórica superada. Nenhuma correção foi aplicada pelo revisor.

## Verificações substantivas

1. **Fidelidade à decisão autoral: satisfatória no AGENTS e na nota.** O usuário rejeitou o cancelamento primitivo como solução e sugeriu examinar incentivos sob crenças fora do caminho. AGENTS:16–21 e 49–55 e nota:7–18 registram a precedência da decisão atual e sua natureza. A sugestão de racionalidade não é transformada em uma restrição adicional já autorizada a propostas factíveis.

2. **Diagnóstico da dependência anterior: correto.** Rmd:340–348 e 1385–1397 estipulam o cancelamento em toda história. B.1:1433–1443 e B.3:1482–1494 derivam concessão zero quando votos fracos bastam, mas o limiar não pivotal de H compara `x_H` e `o`. O memorando:24–30 declara essa regra como input. A nota:29–31 preserva a parte aproveitável da dominância sem apresentar a prova anterior como certificação do requisito novo.

3. **Lema terminal: válido no escopo declarado.** Nota:54–58 usa `m≥3`, quota `k=floor((m+1)/2)`, pagamentos dos fracos e voto sim na indiferença. Há ao menos `k` respondedores fracos. Oferecer zero a todos e reservar 1 ao proponente passa sem depender do voto de H e dá o máximo factível 1. Qualquer proposta com `x_H>0` paga ao proponente no máximo `1−x_H<1` se passar e zero se fracassar. Portanto, não é ótima, independentemente da crença ou do payoff de H no ramo contestado. A prova não cancela a alocação, não devolve valor depois da votação e não exige conhecer a resposta de H.

4. **Formalização candidata: adequadamente qualificada.** Nota:41–46 formula a condição `x_H>0 => Pr(A e voto não de H | I,x)=0` para propostas ótimas, em todo conjunto de informação e sistemas admissíveis de crenças e continuações. Ela é expressamente uma obrigação a verificar. Nota:48 preserva seleção de tipos; nota:50 separa probabilidade posterior zero de impossibilidade física de um tipo.

5. **Histórias fora do caminho: distinção correta.** AGENTS:54 e nota:70–74 separam decisão ótima num conjunto de informação fora do caminho das respostas a uma proposta desviante. A condição sobre propostas ótimas não é usada para apagar a segunda história. A nota também mantém em aberto a explicação econômica de participação e exercício da opção externa.

6. **Referência técnica: conferida.** As notas de Muhamet Yıldız na URL citada contêm a forma extensiva e as utilidades terminais na seção 1.1 e a definição de racionalidade em cada conjunto de informação na seção 4.1. O candidato distingue expressamente essa referência geral da disciplina particular do projeto. Fonte: [Graduate Game Theory, Muhamet Yıldız](https://ocw.mit.edu/courses/14.126-game-theory-spring-2024/mit14_126_s24_yildiz-lecture-notes.pdf).

7. **Registros históricos: preservados com precedência explícita.** `approval.md:31–37` delimita a superação das passagens anteriores sobre cancelamento. O AGENTS não afirma que o manuscrito foi corrigido, nem estende os pareceres históricos aos requisitos novos.

## Observação adicional solicitada após a leitura do candidato

O agente implementador perguntou se a conclusão sobre propostas ótimas também pode ser estabelecida em R1 sem especificar o payoff contestado de H. A resposta é positiva sob as seguintes dependências mantidas: pagamentos dos fracos, espaço de propostas, reconhecimento uniforme independente de cada fraco, regra as-if-pivotal/T^Y e escolhas ótimas em toda continuação terminal.

A prova terminal estabelece payoff 1 para o proponente reconhecido e zero para os demais fracos em toda história terminal. Portanto, antes do sorteio, a continuação de cada fraco é `1/m` em toda história e para todo tipo de H. Na primeira rodada, seu limiar é `β/m`, independente das crenças ou do voto de H. Se a proposta passa com H votando não sob as respostas prescritas dos fracos, há ao menos `k` votos fracos adicionais. Reduzir `x_H` a zero e acrescentá-lo a `x_i` preserva cada voto fraco e a aprovação, tipo a tipo, e aumenta estritamente o pagamento do proponente. Logo, propostas ótimas dessa classe têm `x_H=0` também em R1.

Esse raciocínio não exige que se conheça o payoff de H e inclui tipos com probabilidade posterior zero, pois a contagem dos votos fracos independe do tipo. Contudo, ele não prova a existência de um completamento coerente dos payoffs de H, não resolve suas respostas a toda proposta e não cobre vetores desviantes de votos fracos: após uma proposta ótima positiva, um fraco que deveria votar não pode desviar para sim e tornar possível a aprovação apesar do não de H. Assim, uma eventual ampliação precisa ser enunciada para propostas ótimas e respostas fracas prescritas. Essa ampliação ainda não consta dos hashes avaliados e exigirá nova leitura dos bytes finais.

## Limites

Não foram executados código analítico, compilação do paper, auditoria da extensão de agenda ou rederivação completa. Nenhum parecer de arquitetura integral é emitido. O resultado é uma revisão das instruções e da nota especificadas acima; qualquer alteração posterior constitui outro candidato.
