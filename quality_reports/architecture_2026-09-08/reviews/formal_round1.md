# Parecer formal independente — rodada 1

Data: 2026-09-08. Revisor: `/root/cold_terminal_review`.

**Veredicto: PASS 0/0/0 no escopo da nota condicional.** Foram encontrados zero defeitos `critical`, zero `major` e zero `minor` relevantes nesse escopo. A conclusão resulta da revisão analítica de D1/D2, A1–A3 e C1–C4, do exame das interfaces e da disciplina de crenças, e de verificações computacionais delimitadas. Não equivale à adoção da candidata, à validação empírica da tecnologia ou à recertificação integral do baseline histórico e da extensão de agenda.

## 1. Objeto, integridade e independência

- Nota: `quality_reports/architecture_2026-09-08/architecture_note.Rmd`.
- SHA-256 da nota: `493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3`.
- PDF associado: SHA-256 `e5b7b258d64a85b4573f537315276a127f09e142383c65953e182a206c968ae0`, 12 páginas.
- Contrato de fidelidade: `argument_contract/argument_contract.json`.
- `contract_id`: `architecture_2026-09-08:493f513a096b:round1`.
- SHA-256 do contrato: `1d1c46c001c7e71a9fabb4b2ca7f1e7d592cc21dd179f64fdd05352407b8cdd0`.
- Manifesto dos 18 artefatos: SHA-256 `29d5eef6196933898512a22631237a79d2bf76b5386b2e70e1135cf9de34124d`.

Todos os localizadores da nota abaixo usam a Rmd nesse hash. A distinção do contrato entre `G_0` (jogo histórico com cancelamento), `G_*` (especificação vigente incompleta) e `G_C` (candidata sob A1–A3) foi mantida. Os claims K01–K11 e suas não-afirmações foram usados como limite interpretativo; não encontrei claim relevante que exigisse reabrir o contrato por contraprova textual.

O revisor realizou uma reconstrução fria de R2 antes de ver a candidata, preservada em `reviews/cold_terminal.md`, e participou somente como leitor de compreensão da seção 1. Não implementou ou editou a nota, suas interfaces, scripts ou outputs fixados. Não leu o parecer adversarial. A crítica formal integral começou após receber o contrato PASS. Os únicos arquivos novos desta fase pertencem ao parecer e às evidências próprias em `reviews/formal_evidence/`.

Foram conferidos os 18 hashes do manifesto antes e depois da reprodução e, posteriormente, os 1.540 arquivos preexistentes registrados em `sources/preflight.json`: nenhuma diferença foi encontrada. A validação do contrato retornou `VALID`. O validador da skill dinâmica retornou:

```text
VALID
Dependency batches: [implementation] -> [R2_M, R2_U] -> [R1_M, R1_U] -> [economic_transport]
Ready: none
```

O manifesto registra dependências lógicas e interfaces fixas, sem alegar reconstrução de horários de descoberta informal. O parecer valida a ordem das dependências usadas nas demonstrações; não transforma esse registro em prova de uma cronologia que ele explicitamente não contém.

## 2. Classificação do jogo e contrato verificado

O objeto é uma barganha bayesiana finita de duas rodadas, com propostas de fracos, votação simultânea e um problema adicional de decisão individual de H após certos terminais aprovados. Não é um problema de persuasão com compromisso sobre desenho de sinais, nem requer substituir o conceito aprovado por equilíbrio sequencial.

A nota preserva `m>=3`, `0<ell<h<1`, prior inicial em `[0,1]`, `0<beta<1`, reconhecimento uniforme independente com reposição e alocações não negativas cuja soma é no máximo um, sem teto extra para H. O proponente conta como sim; a maioria exige `k=floor((m+1)/2)` votos adicionais e a unanimidade exige todos. Esses componentes são descritos nas linhas 92–124 e correspondem às fontes vigentes pertinentes.

As novas cláusulas têm conteúdo e fronteira declarados, nas linhas 170–218:

- **A1:** `x_H` é uma oportunidade executável, não dinheiro irrevogavelmente entregue antes da execução. As parcelas dos fracos continuam pagas conforme o contrato.
- **A2:** um único recurso indivisível de H admite os usos rivais C e O. Não há duplicação, empréstimo, divisão ou execução sequencial das duas oportunidades no terminal.
- **A3:** o sim compromete o recurso ao clube se houver aprovação; o não aprovado deixa a escolha de execução; votação fracassada mantém a continuação ou o desacordo terminal.

Isso é uma nova especificação econômica e de implementação. O texto a identifica como tal e distribui sua aceitação entre D-A/D-B/D-C, linhas 609–637. A ausência de acúmulo de `G_C` não é apresentada como resultado já provado para `G_*`. Também não se afirma que a rivalidade seja implicação genérica de forum shopping. Não encontrei reversão silenciosa de fundamento tratada como mero reparo técnico.

A estrutura temporal está completa para o alcance condicional:

| Ramo factível | Continuação ou recebimento de H | Informação relevante | Cobertura |
| --- | --- | --- | --- |
| Aprovação com sim | Compromisso ao clube, valor `x_H` | Proposta, voto e aprovação | A3 e tabela, 194–200, 224–231 |
| Aprovação com não | Escolha C/O, recebimentos `(x_H,0)` ou `(0,o)` | H conhece tipo e vê proposta, votos concluídos e aprovação | 224–261; `conditional_contract.json` |
| Falha em R1 | Sem recebimento atual; R2 segundo história pública | Vetor concluído e posterior admissível | 98–103, 224–231 |
| Falha em R2 | Zero aos fracos, `o` a H | Estado terminal | 98–103, 224–231 |

Não foi acrescentada uma oportunidade de saída no meio de R1, uma nova rodada de barganha ou um desconto dentro da execução. O estado comprimido da execução `(x_H,o,a_H,A)` é suficiente para seus retornos; conservar a história pública inteira antes dela evita restringir indevidamente crenças e seleções do baseline, linhas 470–489.

## 3. D1 e D2: diagnóstico e quantificadores

**D1, linhas 132–143, está correta.** Com `m=4`, existem três respondedores fracos e `k=2`. Na rodada terminal, zero é aceito por cada fraco. A proposta `x_H=1/5`, `x_i=4/5`, demais zero pertence ao espaço factível e passa com voto não de H. A oferta de um ao proponente é melhor para ele, mas essa comparação não retira a primeira proposta da árvore nem determina seu pagamento a H.

O argumento também separa corretamente um desvio na proposta e um desvio nos votos. Otimalidade depois de toda história não elimina as outras ações disponíveis naquele conjunto de informação. A existência do ramo com `x_H` proposto positivo não é convertida numa afirmação de recebimento aditivo já definido em `G_*`.

**D2, linhas 145–161, está correta com suas três condições adicionais.** Se a transferência positiva for irrevogável após aprovação com H não, a alternativa puder ser executada independentemente sem rivalidade impeditiva, e os dois recebimentos forem somados, o ramo de D1 paga `x_H+o` com ambos positivos. Isso viola o requisito forte. Como as três condições não são atribuídas integralmente aos fundamentos aprovados, o resultado não demonstra uma impossibilidade geral desses fundamentos. Essa delimitação coincide com K01/K02.

## 4. C1: execução e ausência de acúmulo em todas as histórias

A equação (1) e C1, linhas 235–261, seguem de A1–A3. Para uma realização C, o par é `(x_H,0)`; para O, `(0,o)`. A exclusão de dois recebimentos positivos vale para **cada ação factível**, inclusive uma execução subótima depois de desvios anteriores. Depois de sim, A3 impõe execução do compromisso; depois de falha, não há benefício do clube a somar. Portanto, o argumento cobre também trajetórias que a racionalidade não seleciona.

A maximização é uma segunda conclusão: escolher C se `x_H>o`, O se `x_H<o` e admitir ambas na igualdade dá valor `max{x_H,o}`. A nota não usa T^Y para escolher a execução na igualdade. Não é preciso impor um novo desempate para fechar o valor de continuação: todas as escolhas ótimas ali dão o mesmo valor, e C4 não afirma unicidade do levantamento de estratégias.

A diferença para cancelamento é verificável. Com `x_H=1/5` e `o=1/10`, um voto não seguido de aprovação permite executar C e receber `1/5`, enquanto `G_0` pagaria `1/10`; com `o=7/20`, O rende `7/20`. A primeira história pode envolver voto desviante, mas continua sendo corretamente implementada. O fato de ela não ser selecionada pelo desempate de voto não enfraquece a cobertura de C1.

A soma unitária diz respeito às oportunidades/alocações prometidas. As linhas 209–218 explicitam que não se promete realização integral do clube após toda história ou depois de desvios. Não encontrei uso da conservação da soma de propostas como se fosse uma restituição automática ao proponente.

## 5. Folhas terminais antes de R1

### 5.1 Votos prescritos e distinção entre H e fracos

Em R2, o fraco compara, condicionalmente à pivotalidade, sua parcela `x_j` com zero. Não negatividade e T^Y implicam sim em toda proposta, inclusive quando a própria pivotalidade tem probabilidade zero sob o perfil puro. Isso aplica a regra operacional aprovada, sem inventar crenças de tremble.

H não recebe esse refinamento pivotal. Ele conhece seu tipo e compara os payoffs efetivos de seus votos contra as estratégias prescritas dos outros. Sob maioria, `m-1>=k`, e esses payoffs são

`U_C(Y)=x_H; U_C(N)=max{x_H,o}`.

Se `x_H<o`, o não é estritamente preferido; se `x_H>=o`, há igualdade na candidata e T^Y seleciona sim. O voto resultante é o mesmo do jogo histórico, mas a natureza da preferência muda quando `x_H>o`: `G_0` tinha sim estrito. A nota reconhece exatamente essa dependência, linhas 272–285 e 577–581. Não usa uma igualdade de ações prescritas como prova de igualdade de toda utilidade desviante.

### 5.2 C2 e a interface de maioria

C2, linhas 287–298, é válida em cada conjunto de informação do proponente. A proposta de um para si e zero aos demais passa e entrega o máximo possível, um. Qualquer `x_H>0`, parcela positiva a outro fraco ou sobra orçamentária reduz esse máximo sem melhorar aprovação, já garantida pelos votos fracos. A proposta ótima é única.

Em `x_H=0`, a candidata fecha explicitamente a parte de H que a reconstrução fria deixara sem transporte automático: votar não permite O, cujo valor `o>0` supera o sim de valor zero; O é a execução ótima. Assim, o valor de H é `o`. O reconhecimento uniforme dá a cada fraco `1/m` antes do sorteio. Ambos estão em unidades de R2, sem beta e sem dependência da crença. Esses são os valores de `interfaces/R2_M.md`.

### 5.3 Unanimidade terminal e empate de propostas

Sob unanimidade, aprovação com não de H é impossível pela quota, inclusive após quaisquer desvios fracos. Logo o ramo novo não participa de nenhuma história factível nessa instituição. Com todos os fracos aceitando zero, H aceita se e somente se `x_H>=o`, pois o sim aprovado dá `x_H` e o não provoca desacordo terminal `o`.

As únicas classes potencialmente ótimas são oferta `ell` com valor `(1-mu)(1-ell)` e oferta `h` com valor `1-h`; uma oferta rejeitada por ambos dá zero e é inferior a `1-h>0`. Da igualdade dos dois valores resulta `p*=(h-ell)/(1-ell)`. Na igualdade `mu=p*`, a oferta baixa dá a H expectativa `(1-mu)ell+mu h`, menor que `h` por `(1-mu)(h-ell)>0`. Portanto, a seleção da oferta baixa decorre do desempate de **propostas**, distinto de T^Y.

As continuações da equação (4), linhas 318–330, estão corretas. A expectativa dos fracos é `(1-mu)(1-ell)/m` no screening e `(1-h)/m` no pooling. Os vetores de H são `(ell,h)` e `(h,h)`, respectivamente. Em particular, o tipo alto no screening recebe `h` no desacordo terminal; a parcela dos fracos condicionada nesse tipo é zero. Não se devem confundir essa coordenada condicionada com a expectativa do fraco pela crença corrente. O arquivo `interfaces/R2_U.md` preserva essas distinções.

## 6. R1 de maioria, C3 e candidatos factíveis

O transporte de R2 para R1 usa beta exatamente uma vez: fracos comparam `x_j` com `w=beta/m`; H recebe `beta o` após continuação majoritária. A independência desse valor fraco em relação a tipo, voto de H e história anterior é resultado de C2 e do reconhecimento com reposição, não uma crença adicional.

A tabela das linhas 340–352 esgota as três classes de votos fracos prescritos:

| Classe | Comparação real de H | Voto com T^Y |
| --- | --- | --- |
| `n_Y>=k` | `x_H` versus `max{x_H,o}` | Sim se e somente se `x_H>=o` |
| `n_Y=k-1` | `x_H` versus `beta o` | Sim se e somente se `x_H>=beta o` |
| `n_Y<=k-2` | `beta o` versus `beta o` | Sim |

A contagem deriva de proposta pública e estratégias conhecidas. H não observa uma realização dos votos simultâneos antes de votar. Se um fraco de fato desviar, o resultado final e a execução são avaliados na árvore correspondente, mantendo fixo o voto de H escolhido naquele conjunto de informação.

**C3, linhas 354–372, está correta.** Quando `n_Y>=k` e `x_H>0`, transferir essa parcela ao residual do proponente antes da votação preserva a soma, cada parcela fraca, cada voto fraco e aprovação com qualquer resposta de H. O ganho é estritamente `x_H` em cada tipo. Quando `n_Y=k-1`, um não de H implica falha; quando `n_Y<=k-2`, não há aprovação. R2 já foi resolvida por C2, e unanimidade exclui o evento pela quota.

O quantificador da conclusão cobre todo conjunto de informação e tipo, inclusive posterior corrente zero, mas pressupõe os votos fracos prescritos. Não elimina screening que seja rejeitado por um tipo e fracasse para ele, nem exige ganho estrito entre duas propostas que fracassem e levem à mesma continuação. Não foi encontrada restrição primitiva `x_H=0` disfarçada na prova.

A redução aos valores `Pi_E`, `Pi_S`, `Pi_P` e `Pi_D` e as identidades das equações (5)–(6), linhas 374–403, foram conferidas. Em particular:

- `Pi_E-Pi_D = 1-beta(k+1)/m > 0`, pois `k+1<=m` e `beta<1`; exclusão é factível.
- `Pi_P-Pi_E = beta(1/m-h)`.
- `Pi_S-Pi_E = (1-p)beta(1/m-ell)-p[1-beta(k+1)/m]`.

Se o custo mínimo de um candidato de inclusão exceder um, seu residual é negativo. O pooling inviável tem valor inferior à exclusão; no screening inviável, a combinação do residual negativo com `w` também não supera `Pi_E>w`. Isso justifica a ressalva de factibilidade, sem remover a restrição do problema de otimização. Em `h=1/m`, a igualdade ponto a ponto de payoffs relevantes preserva o desempate histórico e qualquer família residual de misturas que ele admita, sem selecionar peso novo.

## 7. Crenças, tipos de peso zero e C4 em ambos os sentidos

### 7.1 Crenças

A disciplina das linhas 117–124 preserva a crença após ações fracas, usa Bayes quando o denominador é positivo e atribui uma única coordenada livre ao par votação/voto de H quando ele é zero. Vetores da mesma votação com o mesmo voto de H partilham essa coordenada; votações diferentes podem ter valores distintos.

A restrição é pelo suporte do prior **inicial**, não pelo suporte do posterior corrente. No interior do prior, um tipo de posterior corrente zero não é apagado; nos priors degenerados, não recebe probabilidade positiva um tipo ausente. As comparações de H, os ganhos de dominância e a igualdade de payoffs no transporte foram verificadas por tipo antes de ponderar pelo prior. Logo o transporte não depende de dar peso artificial positivo à coordenada de peso zero.

A nova execução só ocorre depois de aprovação, em um estado absorvente. Não pode fornecer informação para uma votação anterior, nem altera posteriores ou continuações depois de fracassos. A prova não importa a disciplina markoviana/global de crenças da extensão de agenda.

### 7.2 Projeção de `G_C` em `G_0`

C4, linhas 415–458, preserva o alcance correto. Em qualquer assessment da candidata, racionalidade na execução entrega o valor `max{x_H,o}`. Em R2 majoritária, votos fracos e T^Y dão os mesmos votos de H que em `G_0` em cada proposta. No voto prescrito, seu payoff coincide: sim dá `x_H`; não exige `x_H<o` e dá `o`. Os payoffs fracos permanecem idênticos em cada vetor.

Essas folhas produzem os mesmos valores em R1. As três classes da tabela majoritária dão a mesma ação pura de H; nos casos pivotais ou de falha certa, até os payoffs dos dois votos coincidem; no caso não pivotal, coincide o payoff do voto prescrito e continua não existindo desvio estritamente lucrativo. Um desvio de voto fraco que provoque aprovação com H não muda somente o recebimento potencial de H: o fraco segue recebendo sua própria parcela, e não surge continuação no terminal aprovado. Portanto, seus incentivos e a comparação pivotal são preservados.

Cada proposta factível tem o mesmo payoff esperado ao proponente e a H sob as respostas prescritas. Isso preserva tanto maximização do proponente quanto o desempate que minimiza H. Os votos prescritos e a lei de H em cada ballot coincidem; assim também coincidem os denominadores bayesianos e a classe de crenças admissíveis. Ao esquecer a execução, obtém-se um assessment de `G_0`.

### 7.3 Levantamento de `G_0` em `G_C`

Para qualquer assessment admissível de `G_0`, manter suas estratégias e crenças antes da execução e acrescentar uma melhor resposta C/O em cada novo nó produz um assessment de `G_C`. Uma seleção canônica por comparação entre `x_H` e `o` fornece explicitamente um levantamento; não é preciso alegar unicidade na igualdade.

As oportunidades desviantes de H foram consideradas: quando `x_H>o` e os fracos bastam, o não agora permite obter `x_H`, tornando o antigo sim estrito um empate. Esse desvio não é lucrativo, e T^Y exige sim. Não basta invocar igualdade dos payoffs no caminho; a prova utiliza a comparação efetiva do desvio. Nos demais casos, as comparações relevantes já coincidem. Os desvios de proposta e de voto fraco preservam seu próprio valor, e toda execução acrescentada é ótima.

A igualdade é ponto a ponto em propostas e tipos, portanto preserva expectativas e integrais de misturas já admissíveis, seus pesos comuns e as seleções ligadas. Não há necessidade de uma nova média nem de escolher arbitrariamente uma continuação econômica. A inclusão recíproca das correspondências projetadas preserva também sua eventual vacuidade.

### 7.4 Unanimidade e limites do transporte

A árvore de barganha unânime é idêntica porque o novo ramo é impossível por quota. Em R1, a continuação do tipo baixo pode ser `beta h` no ramo de pooling, não necessariamente `beta ell`. A nota preserva isso expressamente, linhas 407–413; a interface `R1_U.md` não usa o atalho majoritário indevido.

A afirmação de que as células históricas de B.4 se transportam **se sua caracterização for correta** é adequada, linhas 460–466. O parecer valida a identidade de jogos e o transporte, não fornece uma segunda prova integral de todas as afirmações de B.4. Também não certifica os registros históricos oriundos de outra arquitetura sem as emendas pertinentes. A referência `G_0` deste parecer é o jogo com cancelamento definido pela nota, não o antigo jogo aditivo.

As mudanças de payoffs depois de votos desviantes e a multiplicidade de extensões de execução impedem identidade literal geral dos jogos completos. A nota reconhece essa limitação e não a contradiz com o enunciado de C4. Seu claim de correspondência é projetado, como exige K07.

## 8. Repercussões públicas, agenda e contrafactuais

No benchmark público majoritário, os custos mínimos são `(k-1)beta/m+beta o` para inclusão e `k beta/m` para exclusão. A comparação dá inclusão se e somente se `o<=1/m`; no empate, `beta o<o` determina a escolha pelo desempate do proponente. Sob unanimidade pública, a oferta `beta o` mais os pagamentos `beta(1-o)/m` aos respondedores deixa ganho `1-beta` sobre o valor de esperar. Esses cálculos das linhas 516–521 foram conferidos.

O exemplo de `m=4`, `beta=0,9`, `ell=0,10`, `h=0,35`, `p=0,80` é internamente consistente: `Pi_E=0,55`, `Pi_S=0,317`, `Pi_P=0,46`, `Pi_D=0,225`; logo a maioria privada exclui. As rendas são `(0,010;0)` sob maioria e `(0,225;0)` sob unanimidade, e sua diferença é `(0,215;0)`. A caracterização privada unânime usada nessa ilustração permanece condicionada ao transporte da caracterização histórica, conforme declarado. O exemplo não prova C4 nem constitui evidência observada.

A análise da agenda, linhas 523–533, não extrapola o transporte. H proponente conta como sim; uma aprovação nessa etapa não aciona a escolha acrescentada. Se houver fracasso, a continuação econômica preservada é importada com o desconto próprio da extensão. Igualdade desses valores não certifica automaticamente membership, assinaturas de assessments, anonimidade, mensurabilidade ou seleção por estado. O levantamento e seus consumidores permanecem explicitamente pendentes. Essa é uma limitação reconhecida de K09, não um defeito descoberto pelo revisor.

Os contrafactuais das linhas 558–581 também são corretos no alcance declarado. Permitir revogar um sim possibilita o exterior após aprovação de oferta zero sob unanimidade terminal, gerando empate e sim por T^Y. Uma tecnologia divisível com retornos lineares permite dois componentes positivos, inclusive uma divisão ótima em `x_H=o`; impedir duas oportunidades integrais não é a mesma propriedade que impedir dois componentes positivos. Retirar T^Y permite votos não que empatam com sim na candidata mas seriam estritamente inferiores em `G_0`. Esses casos demonstram a relevância das hipóteses e da seleção, sem alegar necessidade universal de uma tecnologia particular.

## 9. Verificação computacional, evidências duráveis e limites

A reprodução do script original consta integralmente em `reviews/formal_preflight.md`. Executado em diretório temporário próprio, ele produziu **29.005 PASS, zero FAIL**, com 29.005 IDs distintos. Os cinco outputs, inclusive `sessionInfo.txt`, foram idênticos por bytes e hash aos fixados no candidato. Os avisos de locale não impediram a execução, que terminou com código zero.

Para complementar essa reprodução, sem importar código do implementador, foi salvo e executado:

```text
python3 quality_reports/architecture_2026-09-08/reviews/formal_evidence/exact_checks.py
```

- Script próprio: SHA-256 `00413d7ff2c588bac513fd1a26d6502c2c1cdfcbd7f15405bca1ea62380c9989`.
- Resultado próprio `exact_checks.json`: SHA-256 `65806599f7c6805d0c721e7857137580ac8939db1c3a66933251d302d7754d85`.
- Aritmética: `fractions.Fraction`, com desigualdades exatas e sem tolerância flutuante.
- Resultado: **92.562 asserções PASS, zero FAIL**, incluindo **3.735 propostas factíveis completas de R1**.

O script enumera usos de execução antes de maximizar, compara H exatamente nos limiares e em ambos os lados, verifica as três classes de contagem, compara desvios unilaterais dos fracos mantendo fixo o voto simultâneo de H, confere dominância entre propostas factíveis, expectativas em priors incluindo zero e um, identidade unânime com continuações diferentes depois de Y/N, o desempate terminal de propostas, as identidades algébricas e exemplos em que payoffs de desvios mudam. O número de asserções não é um número de equilíbrios independentes nem uma enumeração de todo o espaço contínuo.

O script do candidato usa tolerância para comparar números representados em ponto flutuante; a nota limita explicitamente esses testes às grades enumeradas. Os checks próprios exatos complementam essa verificação, mas também não provam exaustividade de propostas, crenças ou assessments. As demonstrações analíticas das seções anteriores sustentam os claims universais no domínio declarado.

O PDF foi conferido por hash, metadados e extração de texto das passagens formais centrais; as equações (1)–(6), a tabela de votos e o enunciado/prova de C4 aparecem no documento associado. Não foi executada nova compilação nem uma auditoria visual integral de paginação. Nenhum verificador histórico foi usado como suposto certificado de uma nova arquitetura; nenhuma prova Lean ou análise empírica foi realizada.

## 10. Ledger e findings para adjudicação

| Objeto | Estado | Alcance certificado neste parecer |
| --- | --- | --- |
| D1 / K01 | `proved` | Otimalidade não apaga histórias nem define utilidades |
| D2 / K02 | `proved` | Incompatibilidade sob as três condições adicionais, sem impossibilidade geral dos fundamentos |
| A1–A3 / K03 | Especificação completa e coerente no escopo condicional | Novas hipóteses declaradas; não aprovadas como fundamentos vigentes |
| C1 / K04 | `proved` | Ausência de dois recebimentos positivos em toda história factível de `G_C`; execução ótima e igualdade separadas |
| C2 e R2 unânime / K05 | `proved` | Estratégias, propostas e valores terminais nativos, inclusive fronteiras |
| C3 e R1 majoritária / K06 | `proved` | Dominância tipo a tipo sob votos fracos prescritos, candidatos e factibilidade |
| C4 / K07 | `proved` | Inclusões recíprocas após projeção, mesmos valores induzidos e mesma classe de crenças |
| Benchmark e rendas / K08 | `proved` por transporte e álgebra no alcance declarado | Não reaudita integralmente a caracterização privada histórica |
| Agenda / K09 | Limite adequadamente registrado | Interface econômica transportada; objetos completos e consumidores não recertificados |
| Testes e contrafactuais / K10 | `checked numerically` e argumentos locais conferidos | Grades finitas e dependência de tecnologia/compromisso/desempate, sem exaustividade global |
| Adoção / K11 | Pendente por desenho da tarefa | Depende de decisões autorais D-A/D-B/D-C; fora do PASS matemático |

**Findings numerados:** nenhum. Contagem final: `critical=0`, `major=0`, `minor=0`. Não há instruções de edição decorrentes deste parecer. As limitações reconhecidas pela nota foram preservadas como limites de uso, não recadastradas como defeitos.

O PASS cobre exclusivamente os bytes fixados e o escopo de `G_C` sob A1–A3 e o conceito aprovado. Alterar essas hipóteses, votos, crenças ou payoffs invalida o transporte relevante e reabre os descendentes; alterar a escolha de execução na igualdade pode mudar o representante completo sem mudar os valores projetados. Migração ao manuscrito, promoção dos contratos ou adoção econômica da candidata exigem a decisão correspondente e não são autorizadas por este parecer.
