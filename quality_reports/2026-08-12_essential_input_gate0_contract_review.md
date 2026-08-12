# Parecer independente — contrato Gate 0 da arquitetura essential-input

## Escopo e método

Auditoria estritamente read-only do contrato, tratado como desenho de um jogo dinâmico de barganha com informação incompleta, e não como paper ou prova. Apliquei `formal-model-design` para testar minimalidade e isolamento do mecanismo e `game-theory-audit` para verificar completude de ações, informação, transições, payoffs e assessment.

Classificação usada:

- **(a) necessária**: sem ela, desaparece o mecanismo de essential-input pivotality;
- **(b) conveniente**: simplifica ou isola o mecanismo, mas não é logicamente necessária;
- **(c) restritiva/contaminante**: pode limitar ou predeterminar delay, screening, renda ou ranking institucional.

## Auditoria primitiva por primitiva

| Primitiva/decisão | Classe | Avaliação |
|---|---|---|
| `H` e `m=N-1` weak states, `N>=3` | (a)+(b) | Mais de um fraco é necessário para haver substituto sob maioria. Simetria entre fracos e `N` genérico são conveniências. |
| `theta in {0,1}`, privado de `H`, prior comum `mu` | (a)+(b) | Informação privada e limiares heterogêneos são necessários. Tipo binário e prior comum são simplificações úteis. |
| Pie fixa em 1 | (b)+(c) | Isola pivotalidade de contribuição produtiva, mas torna a exclusão de `H` produtivamente gratuita e pode favorecer mecanicamente a substituição sob maioria. Não é necessária ao mecanismo. |
| Pacote escalar `y` e custo fraco 1:1 | (b)+(c) | Algum custo da concessão é necessário; escalaridade e custo unitário são normalizações. O conjunto factível não está completo. |
| `b_theta=0` | (b)+(c) | Separa benefício direto de outside-option power, mas concentra toda heterogeneidade de `H` em `o_theta`. Não é necessária ao mecanismo. |
| `0<=o_0<o_1<=y_bar<=1` | (a)+(b)+(c) | A ordem estrita sustenta limiares privados; os limites garantem que ambos possam ser comprados e excluem tipos inviáveis, restringindo falha e delay. |
| `pi_H=0` | (b)+(c) | Isola agenda power, mas elimina por construção todo ramo de proposta de `H`. Deve permanecer descrito como benchmark deliberadamente restritivo. |
| Reconhecimento uniforme dos fracos | (b) | Simetria conveniente. A lei conjunta entre R1 e R2 não está definida. |
| `beta in (0,1]`, duas rodadas | (a)+(b)+(c) | Duas datas são o mínimo para delay; exatamente duas rodadas e horizonte finito são escolhas de tratabilidade que podem ser decisivas para a sobrevivência da renda. |
| Entry coletiva e `chi` | (b)+(c) | Não é necessária para delay ou screening; serve à formação institucional. Seu lugar temporal e seus payoffs estão incompletos. |
| Ballot binário e simétrico, sem saída | (a) | Remove o privilégio de ação que destruiu o mecanismo anterior e permite rejeitar hoje sem sair do jogo. |
| Votos simultâneos e selados | (b)+(c) | É uma escolha de protocolo, não requisito do mecanismo; cria a patologia que motiva stage-undominance. |
| Vetor público após fechamento | (a) para P2 | É necessário para o voto de `H` atualizar a crença entre rodadas. |
| Quotas `q=N` e `q=floor(N/2)+1` | (a)+(b) | O contraste unanimidade/maioria é essencial; maioria simples é uma especificação conveniente entre outras quotas possíveis. |
| Proposta `s=(y,(x_j))` e residual | (a), incompleta | Transferências são necessárias para comprar votos, mas faltam restrição orçamentária, definição dos destinatários e regra de implementação. |
| PBE | (a)+(b) | Conceito-base adequado, mas não seleciona sozinho outcomes únicos. |
| Stage-undominated voting | (b)+(c) | Elimina falha coordenada, mas é uma restrição de estratégia potencialmente decisiva para delay e ranking; não é parte necessária da essential-input pivotality. |
| `T^Y` | (b)+(c) | Fecha o conjunto de ofertas, mas seleciona comportamento em indiferença e pode eliminar mistura. Seu domínio não está definido de modo compatível com N4. |
| Weak-vote-passive assessment | (b)+(c) | Convenção de assessment potencialmente relevante para seleção. A frase informacional não define ainda uma restrição de crenças completa. |
| Bayes on-path e crenças livres off-path | (a)+(b) | Padrão para PBE, mas não basta para determinar crenças após todos os vetores de voto e propostas desviantes. |
| Posterior como estado suficiente | (b), não estabelecida | É desejável para modularidade, mas não decorre apenas da ausência de transferências após falha; multiplicidade e dependência histórica podem invalidá-la. |
| Desconto apenas de R2 para R1 | (a) | Correto como disciplina de backward induction. A data de `o_theta` quando passa acordo sem `H` continua ambígua. |
| DAG e hashes | (b) | Boa disciplina de auditoria, não parte do mecanismo. O schema uniforme não representa adequadamente N5/N6. |
| P1 | Salvaguarda | Corretamente proíbe seleção ad hoc, mas é uma questão a provar, não uma decisão de protocolo já resolvida. |
| P2 | (a), incompleta | A informatividade do voto de `H` é central; falta o mapeamento completo entre histórias e crenças. |

## Stress-tests

### 1. O contrato permite responder às duas perguntas da Seção 1?

**Ainda não.** Ele cria a possibilidade de delay ao remover o opt-out e registra delay nas interfaces de R1. Contudo, não permite ainda identificar univocamente:

- quando um acordo inclui `H`;
- o payoff de `H` quando maioria aprova sem seu voto;
- o benchmark que transforma `U_H-o_theta` em renda causada pela informação;
- se `T^Y` permite a mistura prevista em N4;
- como a entry transforma payoffs brutos em formação e comparação.

Logo, nem delay por regra nem sobrevivência/ranking da renda estão operacionalmente identificados pelo contrato atual.

### 2. Algum no-go da Seção 10 reentrou?

**Sim.** O opt-out imediato, o desconto errado e os resultados da cadeia antiga não reentraram. Porém, o benchmark geral de no-screening sob maioria reaparece na descrição de N3 e dos goals, embora `o_0>=1/m` não pertença às primitivas. Para `o_0<1/m`, e especialmente quando `o_0<1/m<o_1`, o preço de `H` pode ser tipo-dependente e a maioria pode enfrentar seleção.

### 3. O jogo e o assessment estão completos sem inserir protocolo dentro de N1–N6?

**Não.** Faltam orçamento e implementação da proposta, definição de inclusão, payoff de `H` quando há passagem sem ele, lei conjunta de reconhecimento, kernel de crenças do assessment passivo e regra temporal/estratégica de entry. Resolver qualquer desses pontos dentro de uma derivação introduziria decisão de protocolo.

## Findings

### Finding 1 — Crítico: proposta, inclusão e implementação não definem outcomes e payoffs

#### Texto original do finding

> O contrato não define a restrição orçamentária nem como votos, proposta e quota determinam quem integra o acordo e quem recebe `y`, `x_j` e o residual. Sem essa função de implementação, N1–N4 não são jogos completamente especificados.

**Evidência/localização:** Seções 2 e 4, especialmente linhas 180–182 e 308–317. `s=(y,(x_j)_{j != i})` inclui formalmente `H` entre os `j`, embora `y` já seja destinado a `H`; não aparece uma igualdade como `y+sum x_j+r_i=1`; tampouco se define se votar não exclui o agente de um acordo aprovado.

**Leituras possíveis:**

1. Pagamentos são implementados para todos os destinatários, independentemente do voto.
2. Apenas votantes `sim` integram a coalizão e recebem pagamentos.
3. A proposta designa inclusão separadamente, mas essa variável foi omitida.
4. O voto de `H` determina sua inclusão mesmo quando não altera a passagem.

**Consequências:** mudam dominância no ballot, preço de cada voto, capacidade de excluir `H`, payoff residual do proponente e distribuições “passa com/sem `H`”.  
**Status:** `pending protocol decision`.

### Finding 2 — Crítico: estatuto e data de `o_theta` na passagem sem `H` são ambíguos

#### Texto original do finding

> O contrato afirma simultaneamente que `o_theta` é realizado se nenhum acordo passar e que `H` recebe `o_theta` quando um acordo sem ele passa. Falta definir em que data e sob qual evento `H` recebe esse payoff, especialmente quando maioria aprova em R1 sem `H`.

**Evidência/localização:** linhas 182, 193–194, 219–231 e 312–317.

**Leituras possíveis:**

1. `o_theta` é recebido sempre que `H` fica fora do acordo, na data da aprovação.
2. `o_theta` é recebido apenas após falha global ao fim de R2.
3. Aprovação sem `H` encerra a negociação dos fracos, mas o payoff externo de `H` só vence na data terminal.
4. “Desacordo” é individual para `H`, não falha institucional global.

**Consequências:** altera o custo de recrutar `H`, a comparação com `beta/m`, a condição `o_0>=1/m`, o desconto e o payoff de delay.  
**Status:** `pending protocol decision`.

### Finding 3 — Crítico: no-screening sob maioria foi antecipado fora de sua região de parâmetros

#### Texto original do finding

> O contrato declara a informação privada inerte em N3 e organiza maioria como benchmark de no-screening, embora suas primitivas permitam `o_0<1/m`. Nesse domínio, `H` pode ser mais barato que um weak substitute apenas para certos tipos; exclusão e ausência de screening não podem entrar como orientação da derivação.

**Evidência/localização:** linhas 233–237, 414–425, 467–470 e no-go das linhas 552–555.

**Leituras possíveis:**

1. Restringir o baseline a `o_0>=1/m`.
2. Manter o suporte genérico e derivar todas as regiões de N3, inclusive seleção de `H`.
3. Condicionar a comparação apenas a tamanhos de organização que endogenamente satisfaçam a desigualdade.

**Consequências:** a primeira leitura transforma resultado em condição de escopo; a segunda pode tornar N3 informacional e alterar o DAG substantivo; a terceira liga N3 a entry de modo não representado nas arestas atuais.  
**Status:** `pending protocol decision`.

### Finding 4 — Crítico: `T^Y` pode excluir a mistura prevista como motor de N4

#### Texto original do finding

> `T^Y` manda aceitar na igualdade, mas N4 antecipa que o tipo baixo mistura entre aceitar e rejeitar. Como mistura exige indiferença, o contrato precisa definir se `T^Y` seleciona `sim` em toda igualdade de payoff ou apenas em limiares estáticos específicos; as duas leituras geram conjuntos de equilíbrio diferentes.

**Evidência/localização:** linhas 372–391 e 437–445.

**Leituras possíveis:**

1. `T^Y` vale para toda igualdade entre os payoffs esperados de votar `sim` e `não`; a mistura de `H` fica excluída.
2. `T^Y` vale apenas quando oferta corrente e opção externa/continuação determinística coincidem, não em indiferença estratégica com sinalização.
3. `T^Y` vale apenas em R2 ou apenas para weak voters.

**Consequências:** determina existência de pooling parcial, informatividade da rejeição, delay e renda informacional.  
**Status:** `pending protocol decision`.

### Finding 5 — Crítico: “renda por causa da informação privada” não tem estimando definido

#### Texto original do finding

> O contrato exporta o payoff de `H` e sua opção externa, mas não define o contrafactual que identifica a parcela causada pela informação privada. Exceder `o_theta` não basta, por si só, para separar renda informacional de renda de pivotalidade ou de dinâmica.

**Evidência/localização:** perguntas da Seção 1, linhas 144–162, e schema/N6, linhas 498–522.

**Leituras possíveis:**

1. Renda informacional é simplesmente `U_H(theta)-o_theta`.
2. É a diferença entre o jogo privado e o mesmo jogo com `theta` público desde `t=0`.
3. É a diferença em relação ao equilíbrio com prior degenerado por tipo.
4. É a renda do tipo baixo gerada por pooling/mistura, demonstrada por uma decomposição de IC.

**Consequências:** diferentes benchmarks podem produzir magnitudes e rankings distintos; N6 não pode “assinar” a resposta causal sem escolher um deles.  
**Status:** `pending protocol decision`.

### Finding 6 — Crítico: transições, assessment passivo e suficiência do posterior estão incompletos

#### Texto original do finding

> O contrato não especifica a lei conjunta dos reconhecimentos nem o mapeamento de crenças após cada proposta e vetor de votos. A afirmação de que weak votes “não sinalizam diretamente” não define o weak-vote-passive assessment, e a ausência de transferências após falha não prova que o posterior sozinho seja estado suficiente.

**Evidência/localização:** linhas 307–336, 342–357, 393–398 e P2, linhas 537–540.

**Leituras possíveis:**

1. Reconhecimentos são independentes entre rodadas e crenças dependem apenas do voto de `H`.
2. Reconhecimentos podem ser correlacionados, fazendo a identidade/história de R1 prever R2.
3. Estratégias de R2 são restringidas a Markov no posterior.
4. PBE permite seleção de continuação dependente de histórias públicas com o mesmo posterior.

**Consequências:** mudam continuation values, incentivos de sinalização, possibilidade de sunspots/história dependente e validade das interfaces de N2 para N4.  
**Status:** `pending protocol decision`.

### Finding 7 — Maior: entry e interfaces de N5/N6 não correspondem a um jogo definido

#### Texto original do finding

> A entry aparece em `t=3`, depois de a barganha já ter terminado, sem jogador decisor, ação coletiva, payoff de não formação ou definição inequívoca de `chi`. Além disso, o schema comum de interfaces não contém decisão de formação, valor líquido ou outputs separados por regra para N5/N6.

**Evidência/localização:** linhas 186–188, 318–320, 428–435 e 491–512.

**Leituras possíveis:**

1. Entry é cronologicamente ex ante, mas resolvida depois por backward induction.
2. É uma regra mecânica aplicada a valor esperado, não uma etapa estratégica.
3. É uma decisão coletiva ex post.
4. `chi` é custo por weak state ou custo total repartido.

**Consequências:** alteram quem participa, quando o custo é pago, payoffs fora da organização, formação na igualdade e o objeto comparado em N6.  
**Status:** `pending protocol decision`.

### Finding 8 — Menor: uma desigualdade estrita antecipada não vale em todo o suporte permitido

#### Texto original do finding

> A afirmação `M(nu')<1`, usada para concluir `a_U<a_M`, não vale em todo o suporte declarado: com `o_0=0` e `nu'=0`, o candidato registrado dá `M(nu')=1`. O contrato precisa escolher entre admitir igualdade ou restringir o suporte.

**Evidência/localização:** suporte nas linhas 182 e candidato/afirmação nas linhas 421–423 e 447–449.

**Leituras possíveis:**

1. Substituir a conclusão por desigualdade fraca nos pontos de fronteira.
2. Impor `o_0>0` ou excluir crenças degeneradas relevantes.
3. Tratar separadamente os knife-edges.

**Consequências:** afeta a alegação estrita de que weak states valem menos sob unanimidade, embora não determine sozinho o mecanismo central.  
**Status:** `pending protocol decision`.

## Observações e riscos que não são findings autônomos

- Pie fixa, `pi_H=0`, tipos binários e duas rodadas são restrições fortes, mas estão declaradas e cumprem uma função legítima de isolamento.
- Stage-undominated voting é uma seleção substantiva, não uma correção neutra; o contrato a declara corretamente como restrição de estratégias.
- P1 é uma salvaguarda adequada: se a multiplicidade impedir resposta, deve-se reportar o conjunto, não acrescentar seleção.
- Não encontrei reintrodução do opt-out imediato nem uso interno de `beta` em R2.

## Contagem final

- **Críticos:** 6
- **Maiores:** 1
- **Menores:** 1

## Veredicto

# FAIL / PENDING PROTOCOL DECISION

O contrato corrige o defeito fundamental da arquitetura anterior e isola de forma promissora essential-input pivotality. Contudo, ainda não define completamente o jogo nem o estimando da renda informacional. Em particular, um implementador teria de escolher dentro de N1–N6 como propostas são implementadas, quando `H` recebe `o_theta`, qual é o domínio de `T^Y`, como crenças transitam e como entry funciona. Essas escolhas podem predeterminar justamente delay, screening, renda e ranking institucional. Portanto, nenhuma derivação deve começar antes de decisão explícita do autor sobre os findings acima.
