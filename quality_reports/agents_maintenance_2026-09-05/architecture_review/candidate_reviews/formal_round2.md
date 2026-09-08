# Revisão independente final de instruções e nota sobre arquitetura

Data: 2026-09-05.
Revisor: `audit_architecture_dependency`.
Rodada: 2.
Resultado: **NO_CONFIRMED_DEFECTS**.

## Escopo e fronteira

Este parecer cobre os seis arquivos de `candidate_manifest.json`, com leitura integral dos textos operacionais e documentais e verificação de integridade da cópia histórica. Avalia fidelidade à correção autoral, a demonstração delimitada para propostas ótimas em R2 e R1, a distinção entre propostas ótimas e histórias desviantes e a coerência dos registros. Não certifica a existência de uma arquitetura completa, as respostas de H em todas as histórias ou a correspondência de equilíbrio do artigo.

Nenhum arquivo do candidato foi editado. O parecer anterior permanece preservado em `candidate_reviews/formal.md` e se refere exclusivamente aos hashes da primeira rodada.

## Hashes verificados

Todos os SHA-256 foram recalculados e coincidem com o manifesto. Os arquivos são UTF-8. `AGENTS.md` e `AGENTS.approved.md` foram comparados byte a byte e são idênticos.

| Arquivo | SHA-256 | Bytes |
| --- | --- | --- |
| `AGENTS.md` | `122a3a53047f9c8c3305a6d768c20687a5833287bf001420661f7fb7564f0098` | 12642 |
| `quality_reports/agents_maintenance_2026-09-05/AGENTS.approved.md` | `122a3a53047f9c8c3305a6d768c20687a5833287bf001420661f7fb7564f0098` | 12642 |
| `quality_reports/agents_maintenance_2026-09-05/AGENTS.before_architecture_clarification.md` | `695069a7b432a3204f43619931c211c8327f8533b30d3cfa969e42bba3806522` | 9731 |
| `quality_reports/agents_maintenance_2026-09-05/README.md` | `ee1e14980ad882a85460a6028df84abc5f46057051a5b0dee6df4688d8562b49` | 7304 |
| `quality_reports/agents_maintenance_2026-09-05/approval.md` | `c2b9c4d44918a39bd33007343dbf6de5c2c73676faceeaafc22c6bc55dd6306c` | 4089 |
| `quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md` | `873715a6848e2747d9d9e31234001c5d37a1c83cd622b0cafa85d4fd96e14a9f` | 10797 |

## F1 da rodada anterior

**RESOLVED.** README:55 agora afirma que H recebe `x_H` quando vota sim e a proposta é aprovada. A retirada de “apenas” elimina a condição necessária que a redação anterior impunha ao recebimento de `x_H`. README:59 mantém explícita a necessidade de especificar o ramo contestado e cobrir desvios em propostas e votos.

## Avaliação de fidelidade e das instruções

O pedido autoral em `review_sources/author_correction.md` rejeita que se resolva o problema simplesmente cancelando a alocação de H após seu voto não; exige fundamento na arquitetura e na racionalidade, com cobertura fora do caminho. AGENTS:16–21, 33 e 49–55 reproduzem esse mandato. O texto não impõe `x_H=0` no espaço de propostas, não instala um payoff aditivo e não introduz uma nova etapa de escolha de H.

O AGENTS distingue as propostas ótimas das histórias geradas por desvios nas propostas ou nos votos. Exige conferir factibilidade, votos, aprovação, continuações e empates antes de usar uma realocação como desvio lucrativo. Preserva o protocolo e o conceito aprovado, sem trocar a disciplina de votos por equilíbrio sequencial.

`approval.md:31–37` declara a precedência da correção sobre o cancelamento histórico e identifica a formulação matemática e a arquitetura como objetos distintos. O registro mantém as etapas anteriores como histórico; elas não são apresentadas como autoridade que revalide o cancelamento. O README final é coerente com essa precedência.

## Auditoria da seção 4 da nota

### Rodada terminal

As condições estão declaradas em nota:54–56. No baseline há `m≥3` fracos e `k=floor((m+1)/2)` votos necessários além do proponente. Existem `m−1≥k` respondedores fracos. Um fraco recebe sua alocação não negativa quando a proposta passa e zero no desacordo terminal; a regra aprovada de comparação pivotal e sim na indiferença implica aceitação de zero.

A proposta `(x_i=1, demais=0)` passa pelos votos fracos e dá 1 ao proponente. A viabilidade impede obter mais de 1. Uma proposta com `x_H>0` dá no máximo `1−x_H<1` ao proponente se passar e zero se falhar. Logo, toda proposta ótima terminal tem `x_i=1` e zero para todos os demais, inclusive H. A prova é independente da crença e do payoff disputado de H. Não há uso oculto de cancelamento ou de devolução ex post.

### Continuação dos fracos

Rmd:309–312 especifica reconhecimento uniforme, independente, com reposição e elegibilidade de todos os fracos em R2. Como a conclusão terminal vale em todos os conjuntos de informação e cada reconhecido obtém 1, a continuação antes do sorteio é `1/m` para cada fraco, independentemente do tipo de H e da história. Essa dependência está declarada em nota:54 e 62.

### Primeira rodada

Pela regra de voto vigente, Rmd:413–420 e decisão de 21 de agosto, as respostas dos fracos são determinadas pela comparação pivotal e pelo sim na indiferença. A continuação constante permite comparar `x_j` com `β/m` sem depender da crença, de `x_H` ou do voto de H. Assim, o número `n_Y` de respondedores prescritos para sim é determinado apenas pelas suas alocações.

Uma aprovação com H votando não requer `n_Y≥k`. Se `x_H>0`, a alternativa `x'_H=0`, `x'_i=x_i+x_H`, `x'_j=x_j` preserva a soma e cada alocação dos respondedores. Preserva, portanto, seus votos prescritos e a aprovação independentemente da resposta de H. Ambas as propostas passam, não havendo diferença de continuação, e o ganho do proponente é estritamente `x_H` para cada tipo de H. A proposta original não é ótima sob nenhuma crença.

A conclusão em nota:72 é correta para propostas ótimas em ambas as rodadas, sob os pagamentos, protocolo e respostas fracas mantidos. O argumento é tipo a tipo e não descarta tipos factíveis com posterior zero. Sob unanimidade, a impossibilidade de aprovação com voto não de H decorre da quota. Não é preciso calcular a resposta ótima de H para demonstrar essa propriedade delimitada.

### Quantificadores e limites

A expressão da seção 3 é apresentada como obrigação de derivação para propostas ótimas, em todos os conjuntos de informação e sistemas admissíveis de crenças e continuações. A seção 4 demonstra a propriedade delimitada, preservadas suas condições. O resultado não presume a existência de um completamento de payoffs de H que satisfaça integralmente o mandato autoral. A nota não afirma que ele exista.

Nota:74 preserva corretamente ofertas de seleção de tipos cujo voto não de H ocasiona fracasso. Não confunde rejeição por um tipo com aprovação apesar dessa rejeição. Também reconhece que alterações entre duas propostas fracassadas podem deixar inalterado o payoff de continuação, de modo que um ganho estrito não decorre de qualquer redução de `x_H` em abstrato.

## Auditoria da seção 5 da nota

Nota:78 cobre duas lacunas que uma prova apenas sobre propostas ótimas não fecha:

1. Após uma proposta desviante positiva, a árvore pode conter votação com H votando não e aprovação pelos fracos. O payoff de H e suas respostas continuam precisando de especificação econômica.
2. Mesmo após uma proposta ótima positiva que exige o voto de H sob respostas prescritas, votos desviantes dos fracos podem tornar a aprovação possível com H votando não. O lema não cobre esses vetores como se fossem as respostas prescritas.

Nota:82 mantém aberta a definição econômica do direito à alocação e do exercício da opção externa. Não resolve essa falta chamando H de não participante. A distinção entre forma extensiva, utilidades terminais e melhores respostas é coerente com a referência previamente conferida às seções 1.1 e 4.1 de [Graduate Game Theory, Muhamet Yıldız](https://ocw.mit.edu/courses/14.126-game-theory-spring-2024/mit14_126_s24_yildiz-lecture-notes.pdf), sem adotar a disciplina de crenças desse texto como substituta da decisão autoral específica.

## Diagnóstico das fontes anteriores

O diagnóstico em nota:26–31 continua correto para os hashes registrados: o Rmd estipula cancelamento em 340–348 e 1385–1397; o memorando de B.1/B.3 o toma como input em 24–30. Os limiares não pivotais de H dependem dessa regra, enquanto a realocação proposta pelo fraco tem uma parte independente dela. Não se alega que a prova anterior seja falsa no jogo que ela de fato estudou.

Os hashes de fonte registrados, conferidos na rodada anterior, são:

- `formal_model_v6.Rmd`: `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`.
- `quality_reports/2026-09-01_b1_b3_exclusion_derivation.md`: `2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256`.

## Resultado e limites do parecer

**NO_CONFIRMED_DEFECTS** nos seis arquivos e hashes desta rodada, dentro do escopo delimitado. O único finding anterior foi corrigido. A demonstração sobre propostas ótimas nas duas rodadas é correta sob suas condições declaradas; o requisito sobre payoffs e respostas após todos os desvios permanece explicitamente aberto.

Não foram rodados testes numéricos, recompilado o paper ou auditada a extensão de agenda. Não é emitida certificação de uma nova arquitetura, nem invariância da correspondência completa de estratégias. Revisões antigas continuam limitadas aos próprios requisitos e hashes, e este parecer não é autorização para fases externas.
