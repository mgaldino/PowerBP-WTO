# Auditoria matemática adversarial independente

**Data:** 24 de setembro de 2026.  
**Revisor:** segundo revisor independente, `audit_information_adversarial`.  
**Objeto:** `inputs/formal_model_v6.Rmd`, 3.349 linhas.  
**SHA-256:** `9356d86a2e893481968ee96a918c2109e726444c5d902ce88edd6f1a5d86345f`.  
**Contrato de fidelidade:** `informational-power-coalition-manuscript:9356d86a2e89:round2`.  
**Localizadores:** Pn designa a linha n, contada a partir de 1, desse snapshot.

## Resultado e alcance

O parecer é favorável à correção matemática dos resultados **no conceito de solução e nos domínios expressamente declarados**. Não identifiquei resultado falso, lacuna de prova material ou hipótese adicional necessária que o manuscrito omita. O arquivo `findings_adversarial.json` contém o array vazio: zero achados confirmados de qualquer gravidade. Esta conclusão resulta da reconstrução das provas, inclusive dos argumentos fora da trajetória e de suporte, e não de concordância com pareceres anteriores.

A leitura cobriu o manuscrito inteiro, P1–3349, e todos os apêndices A–F. Não consultei pareceres anteriores nem o trabalho do primeiro revisor. Li `AGENTS.md`, a skill `game-theory-audit`, o contrato de fidelidade e o snapshot. O `AGENTS.md` ativo coincide byte a byte com sua cópia em `inputs/`. Nenhum arquivo do autor foi editado. A busca limitada por módulos Lean foi apenas um inventário para recomendações; seus teoremas não serviram de evidência para este parecer.

Há duas distinções essenciais à conclusão. Primeiro, a inexistência em unanimidade é relativa a votos puros, à regra pivotal e às crenças declaradas. Segundo, a extensão seleciona continuações anônimas/Markov específicas e impõe uma disciplina própria de crenças sobre o sinal completo `(C,x)`. Não auditei uma correspondência irrestrita de todos os equilíbrios sequenciais de um jogo diferente.

As checagens independentes em `checks/adversarial/check_exact.py`, usando somente `fractions.Fraction` da biblioteca padrão de Python, executaram **67.796 verificações exatas sem divergências**. Elas são buscas finitas por contraexemplos; a justificativa para o domínio contínuo está na reconstrução matemática abaixo. Não executei Lean, compilei PDF, auditei imagens, procurei originalidade bibliográfica, verifiquei fatos históricos ou fiz validação empírica.

## Checklist formal

| Item | Resultado | Evidência e limite |
|---|---|---|
| Tipo de jogo | Conferido | Barganha dinâmica finita, com screening no baseline e signaling de propostas na agenda. Não há escolha comprometida de experimento informacional que exigisse uma concavificação de persuasão bayesiana. |
| Jogadores e informação | Conferido | H é o único informado; fracos sem sinal privado; reconhecimento uniforme independente, com reposição, P303–316. |
| Domínio | Conferido | m inteiro ≥3, 0<ℓ<h<1, 0<β<1, p∈[0,1]. Os limites m=2, β=1 e tipos iguais não foram incorporados por continuidade. |
| Contrato `(C,x)` | Conferido | Proponente pertence a C; quota de cardinalidade; x≥0, soma≤1, zero fora de C; todos os convidados consentem, P317–363. |
| Convites zero e coalizões maiores | Conferido | Permitidos no espaço factível. Podem ser ótimos nominalmente em R2 majoritária; em R1 são descartados somente por argumento de desvio quando há passagem; na agenda rejeitada permanecem como sinais. |
| Payoffs em todos os históricos | Conferido | H incluído e aprovado recebe x_H; excluído recebe o e x_H=0; recusa integral leva à continuação/desacordo. A não acumulação vale fora da trajetória, P1411–1430. |
| Datas | Conferido | R2 nativa sem desconto interno; β de R2 para R1; outro β de R1 para A. A renda do baseline recebe exatamente um β quando comparada à agenda. |
| Bayes no baseline | Conferido | Ação dos fracos não informa; atualização depende do voto público de H no mesmo ballot, inclusive após desvio fraco; valores livres locais somente se o denominador for zero. |
| Probabilidade zero | Conferido | Suporte do prior inicial preservado; tipos contrafactuais continuam tendo estratégias e payoffs. Não identifiquei ressurreição obrigatória de tipos nem equivalência indevida com limites interiores. |
| Racionalidade dos fracos | Conferido dentro do conceito | Comparação esperada como se o voto fosse pivotal; sim na igualdade. Isto é parte do conceito mantido, não uma consequência de PBE irrestrito. |
| Racionalidade de H | Conferido | Comparações por tipo após toda proposta; sim na igualdade, inclusive quando ambos os votos causam rejeição. |
| Empate do proponente fraco | Conferido | Minimiza payoff esperado de H entre melhores respostas próprias; os cutoffs e a célula E/P usam essa regra. |
| Inexistência U | Conferido | Uma proposta factível sem resposta pura válida basta para impedir um assessment completo; não é apenas uma comparação de propostas na trajetória. |
| Propostas Borel na agenda | Conferido analiticamente | Incentivos ponto a ponto em todo o espaço; igualdade com o valor somente quase certamente sob a lei do tipo. O teste numérico não pretende enumerar todas as leis Borel. |
| Posterior local em pontos sem átomo | Conferido analiticamente | O limite local é exigido em todo o suporte; no lema B.8, o limite pode atingir p*, mas esse valor é excluído pela admissibilidade da continuação. |
| Existência de agenda M | Conferido | Para algum ρ em cada economia/prior, não para todo ρ fixado; construções em três regiões de T, P1855–1886. |
| Correspondência U de agenda | Conferido | Duas famílias interiores, endpoints separados e células vazias; nenhuma terceira família resulta da decomposição pela massa de posterior zero. |
| Agregação e comparação | Conferido | Vetores vinculados; diferenças de conjuntos completos; pesos comuns nas misturas; ex ante após manter o par de tipos; nenhuma interpolação em células vazias. |
| Camadas exata e econômica | Conferido analiticamente | Órbita diagonal das leis realizadas e quociente por registro são objetos distintos; planos fora da trajetória ficam no assessment. |
| Generalizações/afirmações externas | Fora do escopo | Não revisei causalidade histórica, originalidade, votos mistos, mais tipos/rodadas, escolha endógena de regras ou instituições empíricas. |

## Reconstrução independente das provas

### 1. Protocolo e ausência de acumulação

Há três casos disjuntos relevantes para H. Se o contrato aprovado o inclui, seu payoff é x_H. Se o contrato aprovado o exclui, a restrição de suporte impõe x_H=0 e seu payoff é o. Se um convidado recusa, nenhuma parcela é implementada. A divisão é exaustiva antes de usar equilíbrio e continua válida quando C é maior que a quota, quando um convidado recebe zero e após qualquer desvio de voto. Portanto P1423–1430 prova a não acumulação sem introduzir uma ação posterior de execução.

Uma maioria de fracos pode executar a pie de valor um enquanto H recebe uma alternativa externa positiva. A soma dos payoffs pode então superar um. Isso não viola a restrição de orçamento, que recai sobre as alocações x e não sobre a soma de alocações e opções externas. Uma tentativa de tratar esse fato como erro contábil seria uma alteração das primitivas.

### 2. Tipos públicos e rodada terminal privada

Na R2, os fracos têm reserva zero e aceitam zero. Como k+1≤m, uma coalizão só de fracos dá ao proponente um, o maior payoff factível. Pagar H exigiria ao menos o>0 e reduziria esse residual. O resultado é alocativamente único, mas não identifica uma única coalizão nominal: qualquer coalizão vencedora só de fracos que inclua o proponente pode votar sim a zero. Essa distinção é preservada em B.1 e E.2.

Na unanimidade terminal, H aceita se e somente se x_H≥o. Sob tipo público, oferecer o é ótimo. Sob tipo privado, os únicos patamares candidatos são ℓ e h: os payoffs do proponente são `(1−p)(1−ℓ)` e `1−h`. A diferença troca de sinal em `p*=(h−ℓ)/(1−ℓ)`. Na igualdade, a oferta baixa dá a H expectativa `(1−p)ℓ+ph<h`; o desempate escolhe ℓ. Desconto não aparece dentro dessa rodada.

Na R1 pública, R2/M gera reserva β/m para cada fraco e βo para H. Inclusão mínima custa `(k−1)β/m+βo`; exclusão mínima custa `kβ/m`. Retirar um fraco de uma coalizão maior preserva a quota, a resposta de H, a continuação e todos os demais votos, porque esses preços são independentes do posterior. A igualdade o=1/m favorece inclusão pelo segundo desempate, pois βo<o. Exclusão supera atraso pela margem `1−β(k+1)/m>0`.

Na R1/U pública, os preços são βo e β(1−o)/m por fraco. A proposta esgota o orçamento e dá ao proponente sua continuação mais 1−β. Essa mesma margem elimina o atraso. Assim as fórmulas e a seleção de `prop:public` seguem das primitivas.

### 3. Maioria privada na R1: desvios e empates

R2/M paga H=o e dá a cada fraco 1/m antes do reconhecimento, independentemente de crenças e nomes de parceiros. Logo os votos fracos custam w=β/m em todos os históricos. Se todos os convidados fracos votam sim, H compara x_H com βo. Se algum fraco recusa, ambos os votos de H dão a mesma continuação, e H vota sim pelo desempate. Esta segunda cláusula importa para completar propostas fracassadas; não se pode manter mecanicamente o cutoff x_H≥βo quando H já não altera a aprovação.

Uma proposta seguramente rejeitada rende w ao proponente. Excluir H rende 1−kw>w. Portanto um ótimo passa com probabilidade positiva. Todo fraco convidado precisa então receber w>0; remover um fraco excedente transfere um valor positivo ao proponente sem mudar a probabilidade de sucesso ou a continuação. Em seguida, reduzir pagamentos excedentes e eliminar slack deixa os três candidatos E, S e P.

As comparações decisivas são

`Π_P−Π_E=β(1/m−h)` e  
`Π_S−Π_E=(1−p)β(1/m−ℓ)−p[1−β(k+1)/m]`.

Quando h<1/m, o denominador de p_SP é positivo e o cutoff está estritamente entre zero e um; quando ℓ<1/m, o mesmo vale para p_SE. Nos empates que envolvem S, seu payoff esperado de H é menor que o do candidato rival. Em h=1/m, E e P empatam para o proponente, e a segunda seleção compara `(1−p)ℓ+ph` com βh. Na igualdade, misturas E/P sobrevivem. Uma loteria comum gera um segmento de vetores, não um retângulo de coordenadas marginais.

Recalculei todas as cinco regiões de `prop:majority` por maximização lexicográfica direta dos três candidatos, incluindo p=0, p=1, ℓ=1/m, h=1/m e os cutoffs exatos. As 4.352 comparações racionais do script não apresentaram divergência. O argumento acima, e não essa grade, justifica a redução de todo o espaço de contratos.

### 4. Unanimidade privada na R1: completar o jogo inteiro

Escreva `t_ℓ(μ)=ℓ` para μ≤p* e `t_ℓ(μ)=h` para μ>p*, enquanto `t_h(μ)=h` sempre. Depois de rejeição, H do tipo o recebe βt_o(μ). O preço pivotal de um fraco é

`c_U(μ)=β(1−μ)(1−ℓ)/m` para μ≤p*, e `β(1−h)/m` acima.

Ele pertence ao intervalo fechado `[w_h^U,w_ℓ^U]`; no cutoff, `(1−p*)(1−ℓ)=1−h` torna o preço fraco contínuo, embora a resposta ótima terminal continue selecionando a oferta baixa.

Para conferir a racionalidade, fixei os quatro pares `(Y,Y),(N,N),(Y,N),(N,Y)`. Bayes determina μ_Y e μ_N quando a respectiva ação de H tem massa positiva; nos denominadores zero usei as alternativas permitidas. Se todos os fracos aceitam, H compara x_H com βt_o(μ_N). Se algum recusa, compara βt_o(μ_Y) com βt_o(μ_N). Essa enumeração reproduz precisamente B.4 nos domínios de existência, inclusive os tipos com massa zero.

Em p=0, o posterior é sempre zero. Com todos os fracos aceitando, `(N,N)` vale abaixo de βℓ, `(Y,N)` entre βℓ e βh, e `(Y,Y)` a partir de βh. Quando um fraco não aceita, ambos os tipos de H votam sim. Isso também mostra por que o vetor de payoffs da proposta ótima é `(βℓ,βh)` e não `(βℓ,βℓ)`.

Para p>p*, Bayes após um voto pooled mantém o posterior alto. Se x_min<w_h^U, `(Y,Y)` com recusa fraca fornece uma resposta válida. Se x_min≥w_h^U, `(N,N)` é válido abaixo de βh e `(Y,Y)` a partir de βh; um posterior livre adequado após o sim impossível sustenta os votos fracos no primeiro caso. Separação não funciona: a imitação torna incompatíveis as duas desigualdades de incentivo.

Na célula `0<p≤p*`, a proposta `s†` paga βℓ a H e w_ℓ^U a cada fraco. Ela é factível, pois o custo total antes do residual do proponente é inferior a β<1, e força sim de todos os fracos sob qualquer posterior admissível. Os quatro pares de H falham:

1. `(Y,Y)`: o alto rejeita βℓ para obter βh.
2. `(N,N)`: após o não pooled, o baixo recebe βℓ e o desempate exige sim à mesma oferta.
3. `(Y,N)`: o baixo imita o não do alto e recebe βh.
4. `(N,Y)`: o alto também prefere o não, que lhe rende βh, à oferta βℓ.

O fato de `s†` poder estar fora da trajetória não elimina a contradição: um assessment completo precisa especificar uma continuação racional depois dela. Verifiquei a impossibilidade no cutoff em 504 economias racionais e 41.916 completamentos fora da trajetória em pontos de fronteira dos domínios de existência. Os resultados confirmam a prova, sem estendê-la a votos mistos.

### 5. Contrastes e rendas do baseline

Os vetores privados de H são `(βℓ,βh)` em S, `(βh,βh)` em P e `(ℓ,h)` em E. Subtrair o vetor público da mesma instituição reproduz todas as linhas de `prop:rents`; subtrair as duas rendas reproduz `prop:deltari`. Os sinais negativos de renda majoritária do alto em screening são economicamente consistentes: no benchmark público ele pode receber h imediatamente, enquanto no jogo privado recebe βh após rejeitar a oferta baixa.

Em p=0, o tipo alto permanece contrafactual, mas a subtração por tipo continua bem definida. Não se pode substituir essa coordenada pelo payoff público do tipo com massa positiva. No intervalo sem U, a operação de diferença dá conjunto vazio. No residual E/P, todas as subtrações são afins no mesmo λ. Os envelopes C.2 são os extremos marginais do segmento quando o segmento integral sobrevive ao desempate; não autorizam combinar os extremos de tipos diferentes.

### 6. Agenda pública

A seleção anônima do baseline entrega a cada fraco `(1−βo)/m` quando H é incluído em R1 e 1/m quando é excluído. Um estágio antes, o preço é β vezes esse valor. H compra k fracos em maioria e m em unanimidade. Portanto

`v_U^A=1−β+β²o`,  
`v_M^A=1−kβ(1−βo)/m` se o≤1/m,  
`v_M^A=max{1−kβ/m,βo}` se o>1/m.

A alternativa de atraso é β²o no primeiro ramo e βo no segundo. Unanimidade tem ganho de 1−β sobre rejeição. A identidade `o_M*=1/β−k/m>1/m` decorre de `β(k+1)<m`; essa desigualdade estrita também cobre m=3. Na fronteira de atraso as fórmulas de gap coincidem. No ramo de atraso, `βo≥v_safe>e/m`, de modo que o gap público é positivo e o sinal alegado em E.8 permanece correto.

O salto de D_M em o=1/m resulta da seleção pública de inclusão na igualdade. Recalculei a diferença com o limite pela direita e obtive exatamente `β/m[1−eβ/m]>0`. Não é uma falha de continuidade que precise ser corrigida.

### 7. Agenda privada majoritária

O objeto de escolha é o par público `(C,x)`. As componentes da união disjunta distinguem duas propostas com a mesma alocação e coalizões diferentes. Num posterior fixado, todos os fracos têm o mesmo preço r_χ=βc_χ, por anonimato e Markov da continuação. Passagem paga x_H; rejeição paga d_χ,o. São comparações válidas porque os fracos não possuem informação própria e o seletor não reage a seus votos.

**Formas puras.** Há no máximo duas mensagens apoiadas. A melhor proposta de passagem no posterior off pode ser aproximada por mensagens fora desse conjunto finito reduzindo ligeiramente a parcela de H, mantendo coalizão e pagamentos fracos. Uma mensagem claramente rejeitada também pode ser escolhida fora dele. Isso prova que O_o é o supremo relevante, mesmo quando o melhor contrato exato está no suporte. Pooling exige as desigualdades de desvio off. Separação com dois acordos exige parcelas iguais por imitação bilateral. Acordo baixo/atraso alto exige `d_ℓ,1≤z≤d_h,1`, além da factibilidade e dos desvios off. O padrão inverso exigiria `d_ℓ,0≥z≥d_h,0`, impossível porque a primeira quantidade é estritamente menor. Dois atrasos deixam as duas desigualdades cruzadas de continuação. Estas são precisamente as seis linhas de E.2. Há pelo menos duas coalizões mínimas porque k<m, o que implementa mensagens distintas mesmo com a mesma parcela de H.

**Leis Borel.** Os três requisitos P1827–1829 particionam as condições de melhor resposta: nenhum ponto do suporte pode dar mais que V_o; a lei escolhida usa maximizadores quase certamente; nenhum ponto fora do suporte pode superar V_o. Como suporte e complemento cobrem todo Y_M, não falta classe de desvios. Exigir igualdade em todos os pontos do suporte seria mais forte e, com payoffs descontínuos, incorreto. A formulação do manuscrito evita esse erro.

O mapa posterior é Borel porque, a raio fixado, a massa de uma bola relativa é Borel no centro; o limite existente pode ser calculado ao longo de uma sequência de raios. Com χ Borel, os preços, votos, passagem e payoffs são mapas Borel. Kernels finitos uniformes, com a mistura E/P comum, geram as leis completas. Este raciocínio confere a suficiência analítica; a grade numérica não substitui a condição pointwise.

**Existência.** Defina T=v_safe/β. Se h≤T, pooling no posterior p e ρ=1 domina rejeição. Se ℓ≤T≤h, use μ_off=1, dê v_safe ao baixo numa proposta aprovada e faça o alto rejeitar; as quatro desigualdades da linha separadora são satisfeitas. Se T≤ℓ, todo baseline majoritário exclui H e rejeição pooled rende βo≥v_safe. Endpoints são problemas de melhor resposta com posterior fixo. Nenhuma dessas construções prova existência para todo ρ, e o texto não a alega.

**Pisos e coalizões maiores.** Pagar β/m a k fracos garante passagem em qualquer posterior e v_safe para H. Uma proposta rejeitada garante ao tipo o pelo menos β²o. Para a minimalidade em equilíbrios, o manuscrito usa um argumento mais forte que retirar convidados segurando a crença fixa. Em S,

`mc_S−(1−w)=(Π_S−Π_E)+μ(β−kw)≥0`.

E, P e a mistura residual preservam a desigualdade. Logo cada fraco de uma coalizão aprovada custa ao menos w(1−w). Convidar k+1 fracos deixa H no máximo `1−(k+1)w(1−w)<v_safe`, porque `(k+1)w<1`. Isso é dominado pela proposta segura qualquer que seja sua crença. A exclusão de coalizões maiores vale quase certamente entre propostas aprovadas usadas; não elimina esses sinais rejeitados do domínio.

### 8. Agenda privada unânime e pontos de massa zero

O transporte `(N,x)↔x` é literal: unanimidade fixa a coalizão em todas as rodadas, de modo que a identificação preserva ações, votos, crenças, transições e desvios. Rejeição depois de qualquer proposta requer uma continuação no mesmo posterior, mesmo quando essa recusa é fora da trajetória. Isso exclui os posteriores `(0,p*]` sob a classe mantida.

Defina `z_L=1−β+β²ℓ`, `z_H=1−β+β²h` e `d=β²h`. Os preços possíveis são r_U(ℓ) e r_U(h). O alto recebe d em toda rejeição. O baixo recebe β²ℓ no posterior zero e d no posterior alto. As desigualdades `z_H>z_L`, `z_H>d` e `r_U(ℓ)>r_U(h)>0` são estritas no domínio.

**Payoff comum.** A lei do alto atribui probabilidade zero ao conjunto de posterior zero, por Bayes. Copiando as propostas usadas pelo alto, o baixo obtém o mesmo payoff, seja em passagem ou rejeição alta; portanto V_ℓ≥V_h. Por outro lado, uma proposta rejeitada em posterior zero não pode ser usada pelo baixo: daria β²ℓ<d≤V_h. Todas as suas propostas usadas dão ao alto o mesmo payoff que ao baixo. A imitação inversa dá V_h≥V_ℓ. Logo V_ℓ=V_h=V no interior.

**Lema do suporte x^h.** Se V<z_H e x^h está fora do suporte com μ_off>p*, há um desvio imediato. Se x^h está no suporte, há uma vizinhança na qual x_H>V. Nela, o conjunto de posterior zero não pode ter massa alta; também não pode ter massa baixa, pois passagem pagaria mais que V e rejeição menos que d≤V. Logo o posterior é >p* quase certamente em cada bola menor de massa positiva. A identidade de Bayes integrada torna a razão local estritamente maior que p* em cada bola. Seu limite é ≥p*, não necessariamente >p*. O manuscrito faz a passagem correta: o limite deve ser admissível, e p* não pertence ao conjunto de continuação. Assim μ(x^h)>p*, x^h passa e há o desvio contraditório. V=z_H segue; somente x^h pode entregar esse valor com factibilidade, logo ambas as leis concentram ali.

A identidade integrada usada aqui é válida. Medidas Borel finitas no simplex são Radon e podem ser estendidas por zero ao espaço euclidiano; `pσ_h≪σ̄`. A diferenciação de medidas identifica a razão local com a derivada de Radon–Nikodym quase certamente. Conferi a hipótese na fonte matemática de Camillo De Lellis, **Theorem 2.10**, em [Lecture Notes on Rectifiable Sets, Densities, and Tangent Measures](https://www.math.ias.edu/delellis/sites/math.ias.edu.delellis/files/Delellis_note136_corrected.pdf), p. 9 impressa. A extensão por zero torna as bolas relativas do manuscrito compatíveis com esse teorema. Não é preciso supor densidades de Lebesgue nem suportes atômicos.

**Exaustão pelas duas famílias.** Se há massa pública de posterior zero, só o baixo a usa. Seu payoff é no máximo z_L. A proposta x^ℓ garante ao menos z_L em qualquer posterior admissível, pois paga o maior preço fraco; logo V=z_L. Factibilidade torna x^ℓ o único acordo com posterior zero capaz de dar esse valor, gerando um átomo baixo positivo. O alto deve obter pelo menos d, portanto z_L≥d. O lema anterior exclui μ_off alto, deixando μ_off=0. A testemunha pura x^ℓ/x^S é factível e satisfaz imitação e todos os desvios. Se não há massa de posterior zero, Bayes plausível dá `p=∫μdσ̄>p*`.

Na família alta com μ_off=0, x^ℓ garante z_L, rejeição garante d ao alto e a factibilidade impõe z_H como teto. Cada `z∈[max{z_L,d},z_H]` é implementado por pooling na proposta uniforme x(z). O posterior no único átomo é p e todos os desvios off rendem no máximo max{z_L,d}. Quando μ_off>p*, o lema reduz a lei a δ_xh. A decomposição da massa de posterior zero é exaustiva e não deixa uma terceira família.

**Endpoints.** Em p=0, o baixo escolhe x^ℓ; o alto contrafactual compara z_L com d e pode concentrar-se em propostas rejeitadas. A exigência é probabilidade um no argmax, não suporte topológico contido nele. Por exemplo, com `(m,β,ℓ,h)=(4,.9,.1,.9)`, o alto pode usar uma sequência de propostas que transfere ε_n de um fraco para H a partir de x^ℓ, com ε_n↓0. Todas são rejeitadas e dão d=.729. O limite x^ℓ é aprovado e dá .181; pode estar no suporte topológico da lei alta com massa zero. Isso não cria desvio lucrativo. Em p=1, ambos os tipos escolhem x^h porque z_H=d+1−β>d. O texto preserva essas distinções.

O teto uniforme U não depende do lema do suporte: cada acordo paga ao menos r_U(h) a cada um dos m fracos, deixando no máximo z_H; rejeição paga no máximo d<z_H. Isso é suficiente, separadamente, para a proposição de vantagem majoritária.

### 9. Comparações com agenda e decomposição

O piso M e o teto U dão

`v_safe−z_H=β(e/m−βh)`.

Por isso a condição βh<e/m garante a desigualdade estrita para ambos os tipos e para qualquer média ex ante do mesmo vetor. No ponto de igualdade, o ranking é fraco. A prova não seleciona um equilíbrio favorável e não afirma necessidade. O exemplo `(4,.9,.5,.6,p=0)` confere: M≥.55 enquanto U=(.505,.505), apesar de βh=.54>.5.

As rendas unânimes são a translação do intervalo de V pelo vetor público `(z_L,z_H)`. O baixo tem renda ≥0, o alto ≤0 e, como z_H>z_L, ambas não podem ser zero ao mesmo tempo. Em p=0 ou p=1, a desigualdade estrita pode estar apenas no tipo sem massa; o texto mantém essa coordenada em vez de confundi-la com a renda ex ante, que é zero nos endpoints.

`ΔV=Δv+ΔIR`, `T=D+I`, `Q=D−βIR^B` e suas imagens de conjuntos são identidades, não teoremas de identificação empírica. Em U, o baseline alto vale βh, portanto sua data-A vale d. O intervalo da agenda começa em max{z_L,d}, dando T_U≥0, ganho máximo 1−β e I_U≤0. Em p=0 a conta é feita por tipo antes de ponderar. Fontes vazias propagam conjunto vazio.

O exemplo de reversão foi recalculado exatamente: no ponto `(m,β,ℓ,h,p)=(4,.9,.1,.9,.95)`, com μ_off=0, M dá ao baixo .5905 e ao alto .81; U pode poolar em .729. O gap público baixo é −.4095, a diferença de renda é .5480 e o gap privado é .1385. A proposta majoritária alta é realmente rejeitada; seus sinais e os desvios off satisfazem a linha separadora. O ponto viola a condição suficiente βh<e/m, portanto não contradiz a vantagem majoritária uniforme.

### 10. Leis realizadas e fatoração

As continuações majoritárias escolhidas têm um conjunto finito de registros de resultados para primitivas fixas. Uma mistura E/P altera probabilidades, não acrescenta alocações continuamente novas aos registros. As propostas de agenda pertencem a uma união finita de simplexes compactos. Isso justifica os espaços compactos poloneses usados nos produtos e nas uniões disjuntas.

A permutação comum dos nomes fracos preserva quotas, factibilidade, uniformidade do reconhecimento e dos parceiros, votação e distâncias euclidianas dentro de cada componente. Ela comuta com o limite local de Bayes. Consequentemente relabeling leva assessments admissíveis a assessments admissíveis.

Para um par de leis x, a lei uniforme sobre sua órbita é invariante. Se duas dessas leis de órbita coincidem, o singleton da segunda representação recebe massa positiva na primeira, logo uma permutação leva uma à outra. Isso prova completude para a órbita **diagonal do par**, sem usar simetrizações separadas que perderiam o vínculo entre tipos.

O quociente por registro pode ser construído escolhendo o menor representante de cada órbita finita sob uma injeção Borel. Toda função Borel invariante sobre o registro é constante na órbita e, portanto, fatora por esse representante. A identidade de integração sob pushforward transfere os resultados anônimos e seus payoffs. Ela não transforma as marginais anônimas em uma assinatura completa de suportes nomeados ou de funções fora da trajetória; o manuscrito expressamente preserva essas funções no assessment subjacente.

Os envelopes `inf(U−M)=inf U−sup M` e `sup(U−M)=sup U−inf M` são válidos para os conjuntos limitados não vazios aqui usados. Não pressupõem que extremos sejam atingidos nem que o intervalo entre eles seja o conjunto exato. A comparação de resultados é um par ordenado de leis marginais; não introduz uma realização aleatória comum entre instituições.

## Mapa dos resultados e de suas provas

O arquivo `claim_coverage_adversarial.csv` contém a cobertura dos 20 claims do contrato e dos resultados auxiliares. O mapa abaixo destaca a cadeia lógica.

| Resultado | Enunciado | Prova no snapshot | Resultado da auditoria |
|---|---|---|---|
| Protocolo e não acumulação | P317–394 | P1411–1430 | Verificado por casos, em todo histórico factível. |
| Benchmark público | P515–534 | P1460–1492 | Verificado por preços, quotas e desempate. |
| Terminal privado | P572–582 | P1494–1509 | Verificado por redução a duas ofertas U e opção de exclusão M. |
| Maioria privada R1 | P619–641 | P1511–1567 | Verificado, incluindo resposta após recusa fraca, coalizões maiores e empates. |
| Unanimidade privada R1 | P669–685 | P1569–1645 | Verificado por enumeração de respostas em todos os históricos e desvio s†. |
| Contraste privado B | P739–754 | P1647–1659 | Subtração de vetores vinculados verificada. |
| Rendas e diferença de rendas B | P808–870 | P1661–1683 | Todas as células verificadas. |
| Endpoints e envelopes | P2179–2218 | B.1–B.6 e C | Conferidos como células literais e segmentos, sem recomposição de coordenadas. |
| Agenda pública | P949–996 | P2888–2954 | Fórmulas, atraso, empate e sinais verificados. |
| Agenda privada M, formas puras | P2399–2435 | P1740–1795 | Enumeração necessária e suficiente verificada. |
| Agenda M, leis Borel/endpoints | P2455–2514 | P1797–1854 | Condições globais de incentivo e mensurabilidade verificadas analiticamente. |
| Agenda M, existência e piso | P2510–2514, P2840–2844 | P1855–1898 | Existência para algum ρ e piso por desvios universais verificados. |
| Minimalidade M na agenda | P924–928 | P1900–1923 | Prova que permite mudança de crença verificada. |
| Agenda U, payoff comum | P1064–1078, P2632–2696 | P1968–1979 | Verificado por imitação e Bayes. |
| Lema x^h, incluindo massa zero | P1981–1984 | P1986–2021 | Verificado; admissibilidade exclui limite p*. |
| Agenda U, duas famílias | P2634–2696 | P2023–2087 | Necessidade, testemunhas e exaustividade verificadas. |
| Agenda U, endpoints | P2698–2727 | P2089–2094 | Probabilidade um no argmax verificada, sem impor fechamento. |
| Teto U e vantagem M | P1130–1142, P2840–2859 | P2096–2106, P2838–2886 | Verificado independentemente do lema x^h. |
| Incidência e reversão | P1171–1192 | P2956–3044 | Translação e exemplo exato verificados. |
| D/T/I/Q | P1217–1266 | P3046–3184, P3270–3347 | Identidades, datas, vazios e sinais declarados verificados. |
| Órbita exata e resumo econômico | P2516–2581, P2749–2797, P3188–3268 | P2108–2175 | Argumento Borel/órbitas finitas verificado, limitado às leis realizadas. |
| Exemplos numéricos | P279–299, P1022–1047, P2862–2873 | Fórmulas acima | Recalculados sem código do autor. |
| Aplicação histórica e originalidade | P41–275, P1297–1340 | Fontes externas fora desta auditoria | Leitura de escopo apenas; sem validação factual ou bibliográfica. |

## Tentativas adversariais descartadas e questões delimitadas

Nenhum item abaixo é um achado `IA-F`. Foram hipóteses de problema que não sobreviveram à reconstrução.

1. **Oferecer x_H positivo a um H excluído.** Não é desvio factível: x_H=0 fora de C é uma primitiva expressa. A recusa de um H convidado também não permite executar um subconjunto residual.
2. **Eliminar todo convite zero ou toda coalizão maior.** Isso seria errado em R2 e nos sinais rejeitados da agenda. O manuscrito conserva ambos; a minimalidade é provada somente onde cabe.
3. **Aplicar Bayes apenas na trajetória prescrita.** A.2 exige Bayes com denominador positivo no ballot considerado, inclusive após desvios fracos. A prova de não existência usa corretamente essa disciplina.
4. **Inferir μ(x^h)>p* apenas de médias locais estritas.** A inferência isolada seria inválida, pois o limite poderia ser p*. A prova acrescenta a condição de admissibilidade e exclui precisamente esse ponto.
5. **Exigir payoff ótimo em todo suporte topológico.** Isso excluiria leis endpoint legítimas sobre um conjunto de rejeição aberto. A condição atual é igualdade quase certa e ausência de desvio lucrativo ponto a ponto.
6. **Ler P1255 como afirmação de T_M negativo.** A frase diz que o sinal pode variar, sem afirmar existência de valores negativos. Há uma variação literal entre zero e positivo: com `(m,β,ℓ,h,p)=(4,.9,.1,.73,.25)` e μ_off=0, o baseline escolhe S e a agenda admite pooling com `z∈[.5913,.591625]`. Assim `T_M(h)∈[0,.000325]`. Portanto não registrei contradição. A possibilidade de provar um resultado mais forte de não negatividade global foi investigada preliminarmente, mas não foi necessária ao parecer, não foi promovida a novo teorema e não serve de base a uma correção.
7. **Ler a família baixa como composta de duas leis inteiramente sem átomos.** P2641 obriga um átomo positivo de σ_ℓ em x^ℓ. A referência posterior a leis atomless só pode abranger a parte restante ou a lei alta; o contrato já registra essa limitação. Para apresentação, dizer “an atomless remainder” seria mais claro, mas não identifiquei um erro no resultado formal.

As disciplinas de anonimato/Markov e de posterior único fora do suporte são escolhas explícitas de modelagem. Não tratá-las como PBE irrestrito é indispensável, mas sua adoção não é uma hipótese omitida. Votos mistos, mais tipos, mais rodadas e escolha de regras estão declarados fora do escopo; sua ausência não é prova incompleta de um teorema alegado.

## Evidência reproduzível e limites

Execute, a partir da raiz do projeto:

```sh
python3 quality_reports/2026-09-24_auditoria_seminario/checks/adversarial/check_exact.py
```

O script verifica o hash do snapshot antes de calcular. Não importa funções, resultados ou scripts do autor. A aritmética é racional exata. A grade usa m=3,…,8, β∈{.1,.5,.9,.99}, tipos em uma grade que inclui 1/m e seus dois lados, endpoints, cutoffs exatos e o empate residual E/P. As propostas de teste incluem preços exatamente no limiar e de ambos os lados, com filtro de factibilidade.

| Família de checagens | Quantidade |
|---|---:|
| Escolha majoritária e empates | 4.352 |
| Limites de preço de continuação M | 4.388 |
| Completamentos puros fora da trajetória em U | 41.916 |
| Inexistência U no cutoff | 504 |
| Perda estrita de coalizão maior na agenda | 504 |
| Identidade do limite uniforme da agenda | 504 |
| Intervalo U não vazio | 504 |
| Incidência, total U e interação U | 4.536 |
| Gap público, D_M e D_U | 10.584 |
| Exemplos numéricos e exemplo auxiliar de T_M | 4 |
| **Total** | **67.796** |

Não houve divergência. Isso não constitui uma enumeração de todos os parâmetros reais, de todo contrato factível ou de todo suporte Borel. A enumeração de ballots completa as quatro ações de H nos pontos amostrados; o argumento geral foi reconstruído acima. A teoria da medida foi auditada por hipóteses e passos lógicos, usando o teorema padrão de diferenciação; não foi formalizada em um verificador de provas. A aparência das figuras, a sincronização do PDF e a exatidão dos fatos sobre OMC não estão cobertas.

## Sugestões delimitadas de formalização em Lean

| Componente | Prioridade e dificuldade | O que seria necessário formalizar |
|---|---|---|
| Quotas, m≥3 e margens estritas | Alta; baixa/média | k como floor inteiro, k+1≤m, `(k+1)β/m<1`; aritmética com `omega`, coerções e `nlinarith`. |
| Protocolo sem acumulação | Alta; baixa | Tipo indutivo de aprovação/exclusão/rejeição e restrição x fora de C; prova por casos, anterior a equilíbrio. |
| Terminal e comparação S/P/E | Alta; média | Espaço factível, preços, redução de candidatos e desempates lexicográficos. Formalizar só as fórmulas seria insuficiente para certificar exaustividade. |
| Não existência U com votos puros | Alta; média | Tipo com quatro perfis, Bayes positivo/zero, desempate e factibilidade de s†. A prova é finita depois de explicitar a interface de continuação. |
| Piso M/teto U e condição suficiente | Alta; baixa/média | Primeiro provar que as propostas seguras são factíveis e passam para toda crença; depois `nlinarith` para a margem. |
| D/T/I/Q e intervalos vinculados | Média; baixa | Vetores por tipo, operações em conjuntos e domínio de existência; `ring` para identidades sem substituir os conjuntos por envelopes retangulares. |
| Lema x^h em suporte de massa zero | Média; alta | Medidas finitas, suporte, derivada de Radon–Nikodym, diferenciação por bolas e incentivos ponto a ponto. Não se reduz à álgebra. |
| Correspondência Borel completa | Baixa para a primeira etapa; alta | Espaço de avaliações, mensurabilidade de seletores, kernels e lema global de melhores respostas. |
| Órbita diagonal e fatoração Borel | Média; média/alta | Ação finita de permutações, medidas de órbita e escolha de representantes Borel. Separar da serialização de planos fora da trajetória. |

A documentação atual da Mathlib expõe a infraestrutura de [Radon–Nikodym](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Decomposition/RadonNikodym.html). Isso indica um ponto de partida; não demonstra que a cadeia específica de diferenciação em todos os suportes do manuscrito esteja pronta para uso. Não instalei dependências, alterei os módulos existentes nem executei compilação Lean. Os resultados históricos localizados em `formal_proofs/` não certificam automaticamente este snapshot ou este protocolo.

O parecer termina com zero achados confirmados e cobertura matemática de todas as proposições e caracterizações declaradas. A confiança é mais forte nos argumentos finitos e algébricos, que foram reconstruídos e submetidos a falsificação racional independente; os argumentos Borel foram conferidos analiticamente, com dependência explícita de teoremas padrão de medida. A evidência sustenta o mecanismo condicional de preço do consentimento do único informado. Ela não transforma esse mecanismo em preferência universal pela unanimidade, nem em explicação causal identificada para a escolha histórica de uma instituição.
