# H, aprovação e opção externa: exigência de arquitetura

Data: 2026-09-05. Escopo: correção das instruções do projeto e diagnóstico delimitado do baseline. A arquitetura substituta e a cobertura completa dos desvios ainda não estão demonstradas.

## 1. Decisão do autor

O autor rejeitou resolver o ramo “H vota não e a proposta é aprovada” simplesmente atribuindo a H sua opção externa e cancelando sua alocação. A ausência de recebimento simultâneo de uma alocação positiva e da opção externa deve decorrer da arquitetura econômica e dos incentivos, inclusive fora do caminho de equilíbrio. Se a arquitetura não gerar o resultado, ela deve ser revista, sem impor a conclusão de partida.

O autor sugeriu examinar a racionalidade de um proponente fraco que atribui `x_H>0` sabendo que H votará não, inclusive sob crenças fora do caminho. Essa sugestão orienta uma demonstração; não constitui uma restrição adicional já aprovada ao conjunto de propostas factíveis.

Permanecem os esclarecimentos anteriores:

- Se a proposta passa, cada fraco recebe sua alocação, independentemente do voto.
- Se H vota sim e a proposta passa, recebe `x_H`.
- Se a proposta é rejeitada e o jogo termina, H recebe a opção externa, independentemente do voto. Havendo nova rodada, aplica-se a continuação do protocolo.
- Reduzir a concessão numa proposta alternativa não significa devolver automaticamente uma parcela ao proponente depois da votação.

A decisão atual prevalece sobre o cancelamento primitivo descrito na emenda de setembro, no registro anterior `approval.md` e no antigo item 4. Os documentos históricos são preservados como evidência da arquitetura anterior. Esta nota não adota `x_H+o_θ` como payoff vigente nem cria uma nova etapa de decisão após a votação.

## 2. Diagnóstico das fontes atuais

Fontes verificadas no checkout `codex/exposition-items20-28`, HEAD `7682f59cbd4dac2317771e37bccaf1a24c547af8`:

| Fonte | SHA-256 | Evidência |
| --- | --- | --- |
| `formal_model_v6.Rmd` | `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411` | Linhas 340–348, 366–368 e 1385–1397 estipulam cancelamento de `x_H`; B.1, linhas 1429–1443, e B.3, linhas 1479–1494, derivam `x_H=0` nas propostas ótimas em que os fracos bastam. |
| `quality_reports/2026-09-01_b1_b3_exclusion_derivation.md` | `2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256` | Linhas 24–30 apresentam a exclusividade como input; o lema da seção 4 compara duas propostas e mostra o custo de uma concessão desnecessária. |

A prova de otimalidade do proponente contém um argumento aproveitável: quando os votos fracos bastam e permanecem iguais, retirar `x_H` da proposta e aumentar a própria parcela preserva a aprovação e melhora seu payoff. Esse cálculo não depende, por si só, de cancelar o recebimento de H. Porém, as respostas não pivotais de H atualmente usam a comparação entre `x_H` e `o_θ`, cuja validade depende justamente da regra contestada. Portanto, preservar um resultado para propostas ótimas não certifica os mesmos incentivos e estratégias em todas as histórias.

O diagnóstico identifica uma incompatibilidade entre a nova exigência autoral e a maneira como o ramo foi especificado. Ele não alega que o lema de dominância seja falso dentro do jogo anteriormente definido.

## 3. Formulação técnica candidata

Seja `I` um conjunto de informação de um proponente fraco, `μ_I` sua crença sobre H, `x` a proposta e `A` o evento de aprovação. As respostas e continuações usadas na comparação devem satisfazer o conceito de solução aprovado e sua disciplina de crenças.

“Saber que H rejeitará” significa atribuir probabilidade 1 ao voto não, com base na informação do proponente. Não significa observar o tipo privado verdadeiro. Examinar apenas esse caso deixa de fora ofertas que um tipo aceita e outro rejeita.

Uma obrigação de prova mais abrangente para a explicação pela racionalidade é:

\[
 x_H>0\quad\Longrightarrow\quad
 \Pr_{\mu_I,\sigma}(A\cap\{v_H=N\}\mid I,x)=0
\]

para toda proposta ótima `x`, em cada conjunto de informação `I`, alcançado ou não no equilíbrio, sob cada sistema admissível de crenças e continuações. Aqui `σ` descreve as respostas dos votantes e a continuação. A expressão é um resultado a verificar, não uma nova restrição ao espaço de propostas ou uma conclusão já provada para o modelo completo.

Essa formulação permite uma oferta positiva aceita por um tipo e rejeitada por outro quando a rejeição faz a proposta fracassar. Por exemplo, no mecanismo de seleção de tipos sob unanimidade, a rejeição de H impede a aprovação pela própria quota.

Uma garantia com probabilidade 1 sob `μ_I` não cobre automaticamente um tipo que recebeu probabilidade posterior zero. A auditoria deve examinar separadamente todos os tipos ainda factíveis na história e declarar o alcance da conclusão. Não se deve descartar um desses casos apenas porque não contribui para o payoff esperado do proponente.

## 4. Resultado para propostas ótimas nas duas rodadas

O argumento a seguir preserva o espaço de propostas, os pagamentos dos fracos, o reconhecimento uniforme independente com todos os fracos elegíveis e sua regra de votação em toda proposta. É válido para qualquer especificação completa dos payoffs de H que mantenha esses componentes. Não determina essa especificação nem certifica os incentivos de H. A conclusão pressupõe propostas ótimas e as respostas de voto prescritas dos fracos em todos os conjuntos de informação.

Considere a rodada terminal sob maioria no baseline, com `m≥3` Estados fracos. Além do proponente, a quota exige `k=floor((m+1)/2)` votos; existem `m−1≥k` respondedores fracos. Cada fraco recebe zero no desacordo e sua alocação não negativa na aprovação. Pela regra de voto aprovada e pelo desempate em favor de sim, todos os respondedores fracos aceitam uma alocação zero.

A proposta que atribui 1 ao proponente e zero a todos os demais passa pelos votos fracos e lhe dá payoff 1. Qualquer proposta com `x_H>0` lhe dá no máximo `1−x_H<1` se passar, e zero se fracassar. Logo, toda proposta ótima terminal sob maioria tem `x_H=0`, qualquer que seja a crença e também nos conjuntos de informação fora do caminho.

Esse argumento usa somente a viabilidade, os pagamentos dos fracos, a quota e o desempate. Não requer definir o payoff disputado de H. Além de `x_H=0`, a otimalidade implica parcela 1 para o proponente e zero para os demais fracos.

Como o reconhecimento em R2 é uniforme, independente e inclui todos os fracos em qualquer história, o valor de continuação de cada fraco antes desse sorteio é `1/m`. Em R1, sua comparação condicional à pivotalidade é, portanto, entre `x_j` e `β/m`. O limiar de voto independe da crença, do tipo de H e de seu voto. Essa conclusão usa a regra de votação aprovada, sem adotar outro conceito de equilíbrio.

Seja `n_Y` o número de respondedores fracos com `x_j≥β/m`. Uma proposta que passa com H votando não, sob essas respostas prescritas, precisa de `n_Y≥k`. Se também tem `x_H>0`, considere a proposta alternativa

\[
x'_H=0,\qquad x'_i=x_i+x_H,\qquad x'_j=x_j\ (j\ne i,H).
\]

Sua viabilidade decorre da preservação da soma. Cada alocação de um respondedor fraco fica igual, logo seus votos não mudam. Esses votos bastam para aprovar ambas as propostas, qualquer que seja a resposta de H. O proponente recebe `x_i` com a original e `x_i+x_H` com a alternativa, um ganho estrito em todo tipo e sob qualquer crença. Não há diferença de continuação a compensar, pois ambas passam.

Logo, nas duas rodadas sob maioria, toda proposta ótima com `x_H>0` só pode passar com o voto sim de H quando os fracos seguem suas respostas prescritas. A comparação vale tipo a tipo, inclusive para tipos com probabilidade posterior zero, e em conjuntos de informação alcançados ou não no equilíbrio. Sob unanimidade, a mesma implicação decorre diretamente da quota. Isso estabelece a propriedade delimitada da seção 3, sem resolver o jogo completo.

A conclusão não exclui ofertas positivas rejeitadas quando essa rejeição faz a proposta fracassar. Tampouco demonstra que toda oferta positiva a um rejeitante certo seja estritamente inferior: se duas propostas fracassarem e levarem à mesma continuação, o ganho da alteração pode ser zero. O resultado demonstrado tem como condição conjunta a aprovação com voto não de H.

## 5. Cobertura de histórias fora do caminho

Há duas perguntas diferentes: o que o proponente escolhe otimamente depois de cada história, e o que acontece depois de uma proposta que ele poderia fazer como desvio. A otimalidade da primeira escolha não apaga da árvore a segunda possibilidade. Mantidos o espaço de alocações e a votação simultânea, uma proposta positiva seguida de voto não de H e aprovação pelos fracos continua precisando de payoffs e respostas especificados. Também é necessário cobrir desvios nos votos: uma proposta positiva que depende de H sob as respostas fracas prescritas pode passar com seu voto não se um fraco que deveria votar não desviar para sim.

Essa distinção usa a separação usual entre forma extensiva, utilidades nos nós terminais e melhores respostas em cada conjunto de informação. Ver [Muhamet Yıldız, notas de Game Theory, seções 1.1 e 4.1](https://ocw.mit.edu/courses/14.126-game-theory-spring-2024/mit14_126_s24_yildiz-lecture-notes.pdf). A aplicação ao problema acima é nossa; a referência não substitui a disciplina específica de crenças e votos aprovada para este projeto.

Portanto, o trabalho de arquitetura ainda deve definir economicamente o direito à alocação e o exercício da opção externa no ramo contestado, avaliar as respostas de H a propostas desviantes e demonstrar o requisito no alcance declarado. Um mecanismo adicional precisa ter conteúdo econômico próprio; renomear o cancelamento como “não participação” apenas repetiria a solução que o autor contestou.

## 6. Resultado desta manutenção

O `AGENTS.md` foi preparado para substituir a regra de cancelamento por uma obrigação de derivação e pela identificação explícita dessa questão aberta. A nota registra um resultado delimitado para propostas ótimas nas duas rodadas, sob respostas prescritas dos fracos, e uma formulação técnica candidata para orientar a arquitetura. O manuscrito, os contratos congelados e as provas anteriores não foram alterados. A certificação da arquitetura completa permanece por fazer; os pareceres anteriores continuam válidos apenas para os arquivos e requisitos que efetivamente avaliaram.
