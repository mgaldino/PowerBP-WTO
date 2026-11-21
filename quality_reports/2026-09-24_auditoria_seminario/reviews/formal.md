# Auditoria matemática formal independente — Power and Its Shadow

**Data:** 24 de setembro de 2026. **Auditor:** agente `/root/audit_information_formal`, separado do implementador e do auditor adversarial desta rodada. **Protocolo:** `game-theory-audit`. **Objeto:** manuscrito integral, baseline, extensão de agenda e Apêndices A–F, sem edição do artigo.

**Fonte auditada:** `quality_reports/2026-09-24_auditoria_seminario/inputs/formal_model_v6.Rmd`, SHA-256 `9356d86a2e893481968ee96a918c2109e726444c5d902ce88edd6f1a5d86345f`. Todos os localizadores `P` abaixo são linhas 1-based desse snapshot, não páginas do PDF nem linhas do manuscrito de trabalho.

**Contrato de leitura:** `informational-power-coalition-manuscript:9356d86a2e89:round2`, fornecido em `argument_contract/argument_contract.json` e `.md`. O contrato fixou a interpretação e as limitações; nenhuma conclusão científica foi deduzida de seu status de fidelidade. Li o `AGENTS.md` vigente e as decisões autorais de 21/8, 1/9 e 19/9 apenas para identificar o conceito e o protocolo. Não li pareceres matemáticos nem adjudicações anteriores. A derivação e os checks deste parecer são independentes dos scripts de análise do projeto.

## Resultado e alcance

Não encontrei erro matemático confirmado nas onze proposições, nas correspondências de agenda, nos lemas auxiliares, nas fórmulas de comparação e na representação de leis examinadas. O parecer não é uma certificação genérica de submissão: a conclusão alcança os resultados identificados no mapa abaixo, sob o conceito de solução e os representantes de continuação expressamente mantidos pelo manuscrito.

Reconstituí analiticamente os incentivos após propostas arbitrárias do baseline; enumerei os quatro perfis puros de voto de H; verifiquei preços, empates, endpoints, coalizões maiores que a quota, convites com parcela zero e a data dos pagamentos. Na agenda, conferi separadamente a enumeração pura de maioria, seu critério necessário e suficiente para leis Borel, as duas famílias unânimes, o lema que trata pontos de suporte sem massa, os bounds uniformes e a fatoração por permutações. Os argumentos sobre um continuum de propostas e sobre medidas não são substituídos pela grade computacional.

Executei `checks/formal/independent_checks.py`: **172.316 verificações em aritmética racional exata, zero falhas**. O output completo, com contagem por família e hash do script, está em `checks/formal/independent_checks.json`. Trata-se de verificação finita complementar, não de uma prova de todos os parâmetros ou de todas as leis Borel. Nenhuma instalação, execução de Lean, chamada de API de parecer ou pipeline que sobrescrevesse outputs existentes foi feita.

O JSON `findings_formal.json` contém `[]`: não há finding matemático confirmado a corrigir. O CSV `claim_coverage_formal.csv` distingue os resultados derivados, as definições verificadas e a literatura/interpretação fora da certificação matemática. A ausência de findings não certifica originalidade, factualidade histórica, qualidade gráfica, fidelidade do PDF ou validade empírica da aplicação à OMC.

## Reconstrução do jogo e condições utilizadas

O baseline é um jogo de barganha distributiva finita com informação incompleta, não um problema de persuasão com compromisso sobre uma estrutura de sinais. Há um hegemon H e m≥3 Estados fracos. Somente H conhece seu desacordo terminal o∈{ℓ,h}, com 0<ℓ<h<1. As duas rodadas reconhecem um fraco uniformemente e com reposição. O desconto de R2 para R1 é β∈(0,1).

O proponente escolhe o par público (C,x), com seu nome em C, |C|≥ν_g, x≥0, soma de x≤1 e x_j=0 fora de C. A quota de maioria é k+1, k=⌊(m+1)/2⌋; unanimidade exige C=N. Cada convidado precisa consentir, inclusive numa coalizão maior que a quota. Um não rejeita o pacote inteiro. Um Estado não convidado não vota; seu marcador ⊥ não é um não. Não há execução individual posterior à aprovação nem cancelamento de parcela de H.

Se H pertence ao acordo aprovado, recebe x_H; se o acordo o exclui, recebe o na data desse acordo e x_H=0 por factibilidade. Rejeição em R1 não paga o imediatamente: passa a R2. Rejeição terminal dá o a H e zero aos fracos. Assim, a afirmação de ausência de acúmulo decorre da partição das transições e do suporte de x, em toda história factível. Não depende da escolha ótima de C.

A solução é a classe de PBE com ballots puros, comparação dos fracos condicional à pivotalidade e sim na indiferença em valor esperado. H também vota sim na indiferença. Entre propostas empatadas em payoff do proponente, minimiza-se o payoff esperado de H. O parecer não substitui essas regras por equilíbrio sequencial, admissibilidade simples ou voto sincero incondicional.

No baseline, propostas e votos de fracos não informam sobre H. Quando H está presente, cada ballot tem duas coordenadas de crença, uma para cada voto de H, comuns a vetores que diferem somente nos votos fracos. Bayes vale com denominador positivo, também após desvio fraco anterior. Denominador zero admite valor local dentro do suporte do prior inicial. No prior degenerado o tipo excluído não é ressuscitado. A liberdade entre ballots distintos permanece; ela não é substituída por um único μ_off.

A extensão adiciona uma proposta obrigatória de H em A, antes de R1. Rejeição transporta uma seleção completa de R1 por um único β. O sinal é (C,x), inclusive quando rejeitado. A seleção de continuação é pública, Borel, anônima e Markov conforme E.1; os representantes majoritários são os kernels uniformes literais de B.7/E.2. O posterior de cada ponto do suporte é o limite local de Bayes dentro da mesma componente de C. Fora do suporte, todas as propostas usam o mesmo μ_off=b_ρ(p). Estas são restrições declaradas, mais estreitas do que PBE irrestrito; as conclusões não são estendidas à classe maior.

## Derivações e verificações analíticas

### 1. Rodada terminal e benchmark público

Na rodada terminal todos os fracos convidados aceitam zero, pois a alternativa é zero e T^Y fecha o empate. Como k+1≤m, maioria permite ao proponente convidar apenas fracos, ficar com um e obter aprovação. Esse payoff atinge o máximo factível. Incluir H custa o>0, e slack ou transferências a outros fracos reduzem o residual. Há várias coalizões nominais ótimas, mas a alocação e o payoff de H são únicos. Antes do reconhecimento cada fraco recebe 1/m.

Em unanimidade pública H aceita exatamente x_H≥o. A oferta ótima é o, com residual 1−o. Na rodada terminal privada, qualquer oferta positiva com a mesma aceitação pode ser reduzida até ℓ ou h. As únicas alternativas potencialmente ótimas são screening com payoff do proponente (1−p)(1−ℓ) e pooling com 1−h. A igualdade ocorre em p*=(h−ℓ)/(1−ℓ), estritamente entre zero e um. Nesse ponto o payoff esperado de H sob screening é (1−p*)ℓ+p*h<h, portanto o desempate escolhe ℓ.

Em R1 pública os preços são β/m para um fraco sob maioria e βo para H. Uma coalizão mínima que inclui H compra k−1 fracos; uma que o exclui compra k. A diferença entre os custos é β(o−1/m), produzindo a inclusão em o≤1/m. No empate H recebe βo se incluído e o se excluído, então a inclusão é selecionada. Excluir H dá ao proponente 1−kβ/m, contra β/m de atraso; a diferença 1−β(k+1)/m é estritamente positiva porque k+1≤m e β<1. Sob unanimidade, pagar βo a H e β(1−o)/m a cada fraco deixa ao proponente sua própria continuação mais 1−β>0. Nenhuma redução mantém todas as aceitações.

### 2. Maioria privada em R1: todos os pares factíveis

Defina w=β/m. Depois de qualquer (C,x), a continuação terminal majoritária é independente de crenças. Todo fraco convidado aceita exatamente x_j≥w. Se todos os fracos convidados aceitam, H aceita exatamente x_H≥βo; se algum fraco recusa, os dois votos de H levam ao mesmo valor βo e T^Y seleciona sim. Portanto os pares impossíveis de aprovar, inclusive os com convidado fraco de parcela zero, têm uma resposta completa.

Uma proposta certamente rejeitada dá w ao proponente e é estritamente dominada pela exclusão. Se passa com probabilidade positiva, todo fraco convidado recebe ao menos w>0. Numa coalizão acima da quota pode-se retirar um fraco convidado, preservar a quota e H caso presente, e transferir sua parcela ao proponente antes do ballot. Os votos restantes, a probabilidade de aceitação de H e a continuação ficam iguais; o ganho é a parcela retirada vezes a probabilidade positiva de passagem. A comparação é entre propostas anteriores ao voto: não executa uma subcoalizão residual depois de um não.

Uma coalizão ótima é, assim, mínima. Reduzindo os preços restantes até seus limiares, restam E, S e P, com

\[
\Pi_E=1-kw,\quad
\Pi_S=(1-p)[1-(k-1)w-\beta\ell]+pw,\quad
\Pi_P=1-(k-1)w-\beta h.
\]

O termo pw de screening é a continuação do proponente depois da recusa do alto, não zero. As diferenças relevantes são Π_P−Π_E=β(1/m−h), Π_S−Π_E=(1−p)β(1/m−ℓ)−p[1−β(k+1)/m] e Π_S−Π_P=β(h−ℓ)−p[1−βℓ−βk/m]. Seus zeros dão exatamente p_SE e p_SP. O denominador de p_SP é positivo no domínio h<1/m em que o cutoff é usado. Um candidato que vence E é factível: sua parte aceita precisa deixar residual positivo, e screening precisa deixar residual maior que w.

Nos empates com S, o payoff esperado de H é menor em S. Quando h=1/m, E e P empatam para o proponente; o desempate compara (1−p)ℓ+ph com βh. Na igualdade secundária permanecem loterias E/P, com o mesmo peso em todas as coordenadas. Permutações de parceiros alteram identidades, não a comparação econômica. Esse argumento cobre o espaço contínuo de ofertas; a enumeração racional complementou-o em todas as cardinalidades factíveis.

### 3. Unanimidade privada: respostas e não existência

A continuação de um fraco em unidades de R1 é c_U(μ)=(1−μ)β(1−ℓ)/m quando μ≤p*, e β(1−h)/m quando μ>p*. Na fronteira as duas expressões coincidem. Seu intervalo é [w_h^U,w_ℓ^U]. Para H, a continuação alta é sempre βh; a baixa é βℓ no ramo terminal de screening e βh no de pooling.

Em p=0 toda crença é zero. Se x_min<w_ℓ^U, algum fraco recusa e H vota (Y,Y) por indiferença. Se x_min≥w_ℓ^U, os perfis são (N,N) para x_H<βℓ, (Y,N) para βℓ≤x_H<βh e (Y,Y) para x_H≥βh. O alto fora do suporte retém sua melhor resposta e recebe βh caso recuse a proposta baixa. Isso verifica tanto o acordo ótimo quanto a segunda coordenada do vetor em p=0.

Para p>p*, x_min<w_h^U permite (Y,Y) com veto fraco: o posterior de Y é p, e pode-se completar N fora do perfil no ramo alto. Se x_min≥w_h^U, (Y,Y) é racional para x_H≥βh; abaixo desse preço (N,N) é racional escolhendo o posterior livre de Y no ramo alto, de modo que os fracos votem sim. Nenhum perfil separador é racional: (Y,N) permite ao baixo imitar N e obter βh; no perfil inverso o baixo não pode preferir uma continuação baixa à oferta/continuação alta disponível por Y. Em p=1 a preservação de suporte dá a mesma classificação. São completamentos por ballot, sem impor uma crença livre global.

Para 0<p≤p*, a proposta s† que paga βℓ a H e w_ℓ^U a todo fraco convidado é factível: deixa ao proponente w_ℓ^U+1−β. Todos os fracos aceitam sob qualquer posterior admissível. Os quatro perfis falham: em (Y,Y) o alto recusa para receber βh; em (N,N) o baixo é indiferente entre βℓ e βℓ e T^Y exige Y; em (Y,N) o baixo imita N, que revela o alto e paga βh; em (N,Y) o alto prefere N, recebendo βh, a aceitar βℓ. Um único ballot factível sem resposta pura impede um assessment completo. Isso prova a célula vazia apenas na classe mantida; não diz o que ocorre com ballots mistos.

A proposta ótima nas células de existência paga os limiares e deixa 1−β acima do valor de atraso do proponente. A classificação completa exclui propostas separadoras ou de atraso que pudessem superar essa alocação. O transporte C=N é literal sob unanimidade.

### 4. Contrastes e rendas do baseline

Recalculei as subtrações usando os vetores ligados S=(βℓ,βh), P=(βh,βh), E=(ℓ,h) e o benchmark público por tipo. As seis células de IR_M, as três de IR_U, os contrastes U−M e os segmentos residuais coincidem com P739–870 e B.5–B.6. Em particular, excluir H privadamente não implica renda zero quando o tipo baixo seria incluído no benchmark público: a diferença (1−β)ℓ é de timing. Em p=0 a coordenada alta fora do suporte continua a integrar o vetor, mas não a média ex ante. Um conjunto fonte vazio propaga vazio.

Os envelopes de C.2 são os extremos coordenada a coordenada de uma única reta afim. Não autorizam formar combinações cruzadas de seus extremos. O exemplo de P279–299 resulta em p*=5/18, p_SE≈0,293478, V_M=(0,10;0,35), V_U=(0,315;0,315), IR_M=(0,01;0) e ΔIR baixo 0,215.

### 5. Agenda pública

Os representantes anônimos de R1 dão ao fraco (1−βo)/m se H é incluído e 1/m quando é excluído. Aplicando β uma única vez obtém-se r_M(o)=β(1−βo)/m para o≤1/m e β/m acima. Em A o proponente H precisa comprar k fracos sob maioria e m sob unanimidade. Os preços são positivos, portanto convites extras aprovados reduzem seu residual. A rejeição dá β²o no primeiro ramo majoritário e βo no segundo; em unanimidade dá β²o.

Assim, v_U^A=1−β+β²o; v_M^A=1−kβ(1−βo)/m no ramo o≤1/m e max{1−kβ/m,βo} acima. Atraso majoritário começa em o_M*=1/β−k/m>1/m, com mistura no empate. Unanimidade prefere passagem por 1−β. Subtração produz as três fórmulas do gap público e sua continuidade no cutoff de atraso. A descontinuidade na fronteira o=1/m é compatível com a seleção de inclusão do baseline; não foi suavizada.

### 6. Agenda privada majoritária: formas puras e leis gerais

Para uma seleção admissível χ, derivei diretamente os totais esperados de payoffs fracos em R1:

\[
mc_E=1,\qquad mc_P=1-\beta h,\qquad
mc_S(\mu)=(1-\mu)(1-\beta\ell)+\mu\beta.
\]

A mistura EP aplica o mesmo peso a todos. Logo 0<c_χ≤1/m; em A o preço é r_χ=βc_χ. O vetor de votos depende de cada convidado x_j≥r_χ(μ), com igualdade aceita. Um contrato aprovado não pode ter convidado fraco com parcela zero; x recupera C apenas nessa parte do espaço. As propostas rejeitadas continuam distintas quando seus C diferem.

Mantido o posterior, o maior residual que passa é a_pass(μ)=1−kr_χ(μ); qualquer residual menor não negativo é factível por slack. Rejeição é obtida, por exemplo, oferecendo um a H e zero a todos os convidados fracos. Esse cálculo com posterior fixo não presume que uma mudança de proposta mantenha sua crença no jogo privado.

Em perfis puros interiores há no máximo duas mensagens suportadas. O complemento é denso em cada componente da coalizão. Se a melhor proposta de passagem fora do caminho estiver suportada, reduções arbitrariamente pequenas em x_H preservam os limiares e evitam as mensagens finitas. Rejeições também podem ser escolhidas fora do suporte. Portanto o supremo de desvios não suportados é O_o=max{a_pass(μ_off),d_o(μ_off)}, mesmo quando a melhor passagem não é atingida fora do suporte. Exigir V≥esse supremo exclui todo desvio lucrativo.

Reconstituí as seis linhas da tabela de formas puras. Pooling aprovado exige O_h≤z≤a_p; pooling rejeitado exige d_o,p≥O_o para ambos. Dois acordos separadores exigem z igual por imitação bilateral e O_h≤z≤min(a_0,a_1). Acordo baixo/atraso alto exige max(d_ℓ,1,O_ℓ)≤z≤min(a_0,d_h,1) e d_h,1≥O_h. A inversão é impossível porque d_h,0>d_ℓ,0. Dois atrasos exigem as duas desigualdades de imitação e as duas relativas a O. Há mensagens distintas suficientes: k<m permite coalizões mínimas diferentes, e a região de rejeição contém um continuum.

Para leis Borel arbitrárias, o manuscrito não reaplica indevidamente o argumento de suporte finito. Usa o supremo verdadeiro sobre o complemento do suporte, inclusive −∞ quando vazio, a desigualdade de desvio em cada ponto suportado e igualdade somente quase certamente sob a própria lei. Essas condições são precisamente a condição global de melhor resposta para cada tipo, decomposta entre suporte e complemento. Os votos e a seleção completa completam a racionalidade após toda rejeição. O critério é uma caracterização implícita necessária e suficiente, não um algoritmo finito que enumera todas as medidas.

A mensurabilidade fecha: a razão de medidas de bolas é Borel em seu centro; um limite pontual existente no suporte fechado é Borel; χ, r_χ e d_χ são Borel; desigualdades entre x_j e r_χ definem conjuntos Borel. A união disjunta finita conserva C. Nos endpoints o posterior é constante, e cada lei atribui probabilidade um ao conjunto de melhores respostas. Não é necessário exigir que todo ponto do suporte topológico seja maximizador quando o payoff é descontínuo na fronteira de passagem.

A existência para algum ρ segue dos três casos de T=v_safe/β: h≤T permite pooling com ρ=1; ℓ≤T≤h permite acordo baixo em z=v_safe e atraso alto, com μ_off=1; T≤ℓ implica exclusão em toda continuação e pooling de atraso. Os empates e endpoints permanecem cobertos. Isto não demonstra existência para todo ρ fixo.

O piso seguro é uma garantia contra qualquer crença induzida: pagar β/m a quaisquer k fracos passa. Rejeição assegura ao menos β²o. A minimalidade dos acordos da agenda também não depende de manter crenças ao retirar um convidado: em toda continuação selecionada (1−w)/m≤c_χ≤1/m, w=β/m. Em S a identidade mc_S−(1−w)=(Π_S−Π_E)+μ(β−kw) dá o piso; P selecionado exige h≤1/m; E e EP satisfazem o mesmo bound. Com k+1 convidados aprovados, x_H≤1−(k+1)w(1−w)<1−kw=v_safe, pois (k+1)w<1. Uma proposta segura dá ganho estrito. Logo tais contratos têm massa zero sob cada lei de equilíbrio; os rejeitados de qualquer tamanho permanecem admissíveis.

### 7. Agenda privada unânime e pontos de suporte sem massa

Como C=N é obrigatório, o mapa (N,x)↔x é bijetivo e conserva todos os desvios e histórias. Uma recusa fraca não informa e exige uma continuação no mesmo posterior; por isso cada posterior disciplinado e μ_off precisam pertencer a {0}∪(p*,1]. Esse requisito vale mesmo depois de propostas aprovadas, pois uma recusa desviadora continua factível.

Em posterior zero os preços fracos são r_L=β(1−βℓ)/m e o máximo de passagem é z_L=1−β+β²ℓ; acima de p* são r_H=β(1−βh)/m e z_H=1−β+β²h. Rejeição dá d=β²h ao alto em ambos os ramos; dá β²ℓ ao baixo no ramo zero e d no alto. Logo z_H=d+1−β>d e z_H>z_L.

A igualdade de payoff dos dois tipos no interior usa imitação e igualdade quase certa às melhores respostas. Quase todo sinal utilizado pelo alto tem posterior positivo, portanto alto; sua imitação dá ao baixo o mesmo payoff. Se o baixo usa posterior zero, rejeitá-lo daria β²ℓ<d, incompatível com a imitação de um sinal ótimo do alto, cujo valor é ao menos d. Portanto esses sinais passam, e podem ser imitados pelo alto com o mesmo payoff. Nos demais sinais utilizados pelo baixo o posterior é alto e os dois tipos novamente têm o mesmo retorno. Conclui-se V_ℓ=V_h=V, sem impor igualdade de payoff em pontos de massa zero.

Conferi o passo de diferenciação de medidas do lema P1981–2021. As medidas são probabilidades Borel em um simplex compacto euclidiano; estendidas por zero ao espaço ambiente, são finitas e Radon. Além disso pσ_h é absolutamente contínua em relação a \barσ. A diferenciação por bolas relativas coincide com a razão de bolas do ambiente para essas extensões. Portanto o limite local mantido é a derivada de Radon–Nikodym quase certamente, dando pσ_h(E)=∫_E μd\barσ. O teorema padrão exige exatamente medidas euclidianas localmente finitas; essas hipóteses foram conferidas na fonte [De Lellis, Teorema 2.10, p. 9](https://www.math.ias.edu/delellis/sites/math.ias.edu.delellis/files/Delellis_note136_corrected.pdf), consultada em 24/9/2026. A existência do limite em *todos* os pontos do suporte continua sendo uma condição adicional do jogo, não uma conclusão desse teorema.

Se μ_off>p* e V<z_H, x^h não suportado é um desvio lucrativo. Se x^h é suportado, uma bola suficientemente pequena tem x_H>V. Seu subconjunto com μ=0 não tem massa alta por Bayes, nem massa baixa: passagem pagaria acima de V e rejeição pagaria abaixo de d≤V. Logo μ>p* quase certamente nessa bola e em todas as menores. Suas médias são maiores que p*, e o limite em x^h é **ao menos** p*, não automaticamente maior. O manuscrito usa corretamente a exclusão do ponto p* e p*>0 para concluir μ(x^h)>p*. Assim x^h passa com z_H>V, contradição. Quando V=z_H, a factibilidade e r_H tornam x^h o único contrato aprovado com essa parcela; rejeição paga menos. As duas leis concentram-se nele. Esse argumento alcança o caso delicado de ponto de suporte sem átomo.

Se existe massa pública de posterior zero, V≤z_L e d≤V, logo z_L≥d. O lema anterior força μ_off=0. A proposta x^ℓ passa sob qualquer posterior admissível, portanto garante z_L; isso explicita o passo abreviado em P2034–2035. Logo V=z_L e toda a massa de posterior zero se concentra no único maximizador x^ℓ, com átomo baixo positivo e nenhum átomo alto. Sinais de posterior alto usados devem passar com parcela z_L, ou rejeitar apenas se z_L=d. O witness (δ_xℓ,δ_xS) é factível e satisfaz imitação e desvios exatamente sob z_L≥d.

Sem massa de posterior zero, Bayes plausibility dá p=∫μd\barσ>p*. Com μ_off=0, as garantias x^ℓ e rejeição alta impõem V≥max(z_L,d), enquanto factibilidade dá V≤z_H. Para cada valor do intervalo, x(V)=(V,(1−V)/m,…) é um pooling factível e aceita, com todo desvio fora do suporte limitado por max(z_L,d). Com μ_off>p*, o lema reduz as leis a δ_xh. Esses casos esgotam a partição por massa de posterior zero. Pontos de suporte sem massa continuam sob as desigualdades ponto a ponto de E.3.

Em p=0, o tipo baixo escolhe unicamente x^ℓ, e o tipo alto fora do suporte maximiza entre z_L e d. Empate admite probabilidade um na união de x^ℓ e propostas rejeitadas; quando d>z_L somente as rejeitadas são usadas. Em p=1 ambos escolhem x^h. Isso respeita a importação declarada de assessments completos de prior de entrada degenerado na agenda; não modifica retroativamente a regra do suporte inicial dentro de outro baseline. Não registrei essa limitação contratada como descoberta.

O teto global V_U≤z_H é independente do lema de suporte: toda passagem paga ao menos r_H a m fracos, e rejeição paga no máximo d<z_H. É esse teto, junto ao piso seguro majoritário, que sustenta a vantagem uniforme de maioria.

### 8. Comparações de agenda, contabilidade e exemplos

O produto de comparação emparelha assessments completos no mesmo (primitivas,ρ,μ_off). Subtrair vetores e depois tomar (1−p) vezes a coordenada baixa mais p vezes a alta preserva o vínculo. Não se cria um sorteio comum entre instituições.

Recalculei v_safe−z_H=β(e/m−βh). Se βh<e/m, o gap privado U−M é no máximo o negativo estrito dessa margem, para cada tipo e ex ante. Na igualdade o bound é fraco. O exemplo de não necessidade com (m,β,ℓ,h,p)=(4;0,9;0,5;0,6;0) tem v_safe=0,55, z_L=0,505 e d=0,486, portanto todas as maiorias superam o vetor unânime (0,505;0,505), apesar de βh=0,54>0,5.

Os vetores de renda da agenda são traduções pelo benchmark público. Os limites z_L≤V≤z_H nas células interiores, e os endpoints explicitados, dão IR_U(ℓ)≥0 e IR_U(h)≤0 com pelo menos uma desigualdade estrita. O sinal ex ante pode diferir: a prova não infere uma vantagem ex ante universal a partir da renda do baixo.

O exemplo de reversão usa exatamente o mesmo μ_off=0 sob as duas regras. Em maioria, a oferta baixa (.5905,.20475,.20475,0,0) é aceita em posterior zero; a proposta alta (1,0,0,0,0) é rejeitada em posterior um. Payoffs (.5905,.81). Imitar ou desviar fora do suporte não melhora nenhum tipo. Em unanimidade, p=.95>p*=8/9 e o pooling em z=.729 pertence ao intervalo [max(.181,.729),.829]. O vetor (.729,.06775,.06775,.06775,.06775) é factível e aceito. As diferenças da tabela, -.4095, +.1385 e +.5480, são corretas.

As identidades ΔV=Δv+ΔIR, T=D+I e Q=D−βIR^B seguem por substituição, usando β apenas no baseline. Recalculei D_U=1−β, os três ramos de D_M e seu salto em 1/m. As fórmulas de T_U, Q_U e I_U em E.13–E.14/F.2 correspondem às traduções dos vetores de origem, inclusive o alto fora do suporte e cada célula vazia. Em particular, T_U não é definido na faixa em que o baseline não existe, mesmo quando a agenda existe ali.

### 9. Leis realizadas, órbitas e resumos econômicos

Em maioria o espaço de sinais é uma união disjunta finita de simplexes compactos; os estados de continuação e os registros terminais usados em E.2 dão um espaço ambiente compacto polonês. A lei Γ_o mantém o par (C,x), o posterior, a passagem, o estado de continuação e o resultado terminal. Os votos efetivos são recuperáveis de C, x, μ e do estado de continuação, preservando ⊥. Em unanimidade, a identificação C=N conserva os mesmos objetos relevantes.

Uma permutação comum dos nomes fracos é um homeomorfismo nas coordenadas; os kernels uniformes são equivariantes. Ela preserva bolas relativas, Bayes, factibilidade e desvios. A lei uniforme da órbita diagonal do par (Γ_ℓ,Γ_h) é um invariante completo: se duas leis de órbita coincidem, o singleton do segundo par tem massa positiva na primeira, logo é uma permutação do primeiro. Isso não afirma que a assinatura reconstrói funções completas fora do caminho.

Para o resumo econômico, uma injeção Borel num intervalo ordena cada órbita finita e permite selecionar seu menor representante de modo Borel. Toda função Borel invariante de um registro f é constante na órbita e, portanto, f=\bar f∘q. A integração passa ao pushforward q#Γ. Payoff, aprovação, atraso, tamanho da coalizão e multiconjunto de payoffs fracos têm essa invariância. As operações que exigem estratégias ou crenças fora do caminho continuam no assessment, como o texto declara.

Os extremos de um conjunto de diferenças de escalares satisfazem inf(U−M)=inf U−sup M e sup(U−M)=sup U−inf M. Isso usa o produto de todas as avaliações admissíveis na mesma especificação; não pressupõe que os extremos sejam atingidos nem que o conjunto de diferenças preencha o intervalo. O objeto de outcomes é um par ordenado de leis marginais, não uma distribuição conjunta acoplada entre regras.

## Mapa de cobertura dos resultados

Em cada linha, “validado analiticamente” significa que o argumento foi reconstruído neste parecer dentro das hipóteses indicadas. “Definição consistente” verifica coerência do objeto, sem tratar a escolha de modelagem como teorema. A grade mencionada na evidência é complementar. As hipóteses gerais são m≥3, 0<ℓ<h<1, 0<β<1, quotas e protocolo de consentimento declarados.

| ID | Resultado e localizadores P | Hipóteses/escopo examinado | Derivação ou evidência | Veredicto |
|---|---|---|---|---|
| F01 | Protocolo e ausência de acúmulo, 317–394; 1411–1430 | Todo (C,x), todo vetor de voto, convites zero e excesso de quota | Partição aprovação incluído/excluído e recusa; x fora de C=0 | Validado analiticamente |
| F02 | Conceito, Bayes e T^Y, 428–450; 1432–1456 | Denominador positivo/zero, endpoints, fracos desviantes | Conferência com decisões autorais; duas coordenadas locais por ballot | Definição consistente |
| F03 | Proposição public, 515–534; 1460–1492 | R2 e R1, M/U, o=1/m, atraso | Preços terminais, comparação de custos e ganho 1−β | Validado analiticamente |
| F04 | Proposição terminal, 572–582; 1494–1509 | Puro terminal, todos os priors e empate p* | Duas ofertas eficientes; T^Y; minimização de payoff de H | Validado analiticamente |
| F05 | Proposição majority, 619–641; 1511–1567 | Todos os contratos, cinco regiões, mistura EP | Redução por dominância a E/S/P; diferenças exatas; grade de cardinalidades | Validado analiticamente |
| F06 | Proposição unanimity, existência, 669–685; 1583–1617 | p=0 e p>p*, inclusive p=1 e alto fora do suporte | Completamento das quatro respostas e maximização do proponente | Validado analiticamente |
| F07 | Proposição unanimity, inexistência, 676–677; 1619–1645 | 0<p≤p*, ballots puros | s† factível; quatro contradições de incentivo/T^Y | Validado analiticamente |
| F08 | Proposição privatecompare, 739–754; 1647–1659 | Mesmas primitivas e vetores ligados; vazios | Subtração dos vetores E/S/P e U | Validado analiticamente |
| F09 | Proposição rents, 808–835; 1661–1671 | Public region por tipo; exclusão e timing | Subtração privado−público em seis células | Validado analiticamente |
| F10 | Proposição deltari, 849–870; 1673–1683 | Endpoints, célula vazia e residual EP | Diferença de rendas preservando peso comum | Validado analiticamente |
| F11 | Exemplo baseline, 279–299 | m=4, β=.9, ℓ=.1, h=.35, p=.8 | Recálculo racional de cutoffs e rendas | Valores confirmados |
| F12 | Endpoints baseline, 2179–2188 | Priors degenerados, tipo com massa e contrafactual | Estratégias de voto e inclusão pública no empate | Validado analiticamente |
| F13 | Envelopes baseline, 2190–2218 | Só o segmento residual admissível; vazios | Extremos de mapa afim com λ comum | Validado analiticamente |
| F14 | Contrato de agenda, 905–939; 2301–2378 | (C,x), leis Borel, Markov literal e μ_off global | Data, sinal, topologia e seletor conferidos | Definição consistente |
| F15 | Proposição agenda-public, 949–996; 2888–2954 | Todas cardinalidades, tipos e fronteiras | Preço βc; passagem versus rejeição; gap por ramos | Validado analiticamente |
| F16 | Preços majoritários a posterior fixo, 1704–1738 | Seleção χ admissível e todos os contratos | c_E,c_S,c_P; k limiares; rejeição factível | Validado analiticamente |
| F17 | Formas puras M, 1740–1795; 2395–2435 | Prior interior; seis padrões; sinais distintos | Supremo fora do suporte finito e imitação bilateral | Validado analiticamente |
| F18 | Critério Borel M, 1797–1846; 2455–2502 | Suporte arbitrário, pontos sem massa e complemento vazio | Decomposição da condição global de melhor resposta; Borel | Validado analiticamente |
| F19 | Endpoints da agenda M, 1848–1853; 2504–2509 | Ambas as leis, inclusive tipo impossível | Posterior constante; probabilidade um no argmax | Validado analiticamente |
| F20 | Existência M para algum ρ, 1855–1886; 2510–2513 | Toda economia/prior, sem afirmar todo ρ | Três construções por T=v_safe/β | Validado analiticamente |
| F21 | Piso uniforme M, 1888–1898 | Qualquer posterior induzido e qualquer lei | Proposta segura e rejeição garantida | Validado analiticamente |
| F22 | Minimalidade quase certa M, 1900–1923; 924–928 | Acordos sob ambas as leis; rejeitados retidos | Bound global do custo dos convidados e desvio seguro | Validado analiticamente |
| F23 | Transporte e domínio U, 1927–1965; 2584–2608 | C=N, inclusive recusa desviadora | Isomorfismo e necessidade de continuação no mesmo posterior | Validado analiticamente |
| F24 | Payoff comum interior U, 1968–1979 | Leis Borel, Bayes a.e., imitação | Comparações bilaterais e rejeição alta d | Validado analiticamente |
| F25 | Lema de x^h no suporte, 1981–2021 | μ_off>p*, ponto suportado com ou sem átomo | Diferenciação, massa local e exclusão de p* | Validado analiticamente |
| F26 | Família baixa U, 2023–2061; 2634–2664 | Massa positiva em posterior zero; Δ≥0 | Garantia xℓ, átomo necessário, witness xS e desigualdades pointwise | Validado analiticamente |
| F27 | Família alta U, 2063–2087; 2666–2696 | Massa zero de posterior zero; p>p* | Bayes plausibility, intervalo e witnesses de pooling | Validado analiticamente |
| F28 | Endpoints U, 2089–2094; 2698–2727 | Importação endpoint declarada; tipos de massa zero | Argmax entre z_L e d, e z_H>d | Validado analiticamente |
| F29 | Imagem exata U, 1068–1079; 2729–2747 | Todos os domínios admissíveis e vazios | União exaustiva das famílias/endpoints | Validado analiticamente |
| F30 | Teto uniforme U, 2096–2101 | Toda proposta e lei; independe de F25 | m pagamentos ≥r_H; rejeição ≤d<z_H | Validado analiticamente |
| F31 | Leis realizadas e assinatura exata, 2108–2149; 2516–2580; 2749–2795 | Relabeling diagonal comum das duas leis | Kernels Borel; ação finita; argumento do singleton da órbita | Validado analiticamente |
| F32 | Fatoração econômica e envelopes, 2151–2175; 3188–3268 | Funções invariantes dos registros; produto prévio | Transversal Borel, pushforward, extremos de diferença | Validado analiticamente |
| F33 | Comparação de especificação fixa, 2799–2836 | Fontes não vazias; mesma economia/ρ | Produto de assessments, subtração ligada, média afim | Definição consistente |
| F34 | Proposição agenda-majority, 1130–1152; 2838–2886 | Ambas as fontes existem; βh≤e/m | Subtração do piso M e teto U; exemplo de não necessidade | Validado analiticamente |
| F35 | Proposição agenda-incidence, 1171–1175; 2956–3005 | Todos os assessments U existentes | Tradução dos valores pelos benchmarks públicos | Validado analiticamente |
| F36 | Reversão e decomposição ΔV, 1022–1047; 2443–2453; 3007–3044 | Mesmo μ_off=0 e ponto numérico declarado | Incentivos da dupla de witnesses e diferenças racionais | Validado analiticamente |
| F37 | Proposição agenda-decomposition, 1217–1229; 3046–3070 | Todas as fontes e datas definidas | Substituição V=v+IR, um fator β | Validado analiticamente |
| F38 | D público e ΔD, 1231–1248; 3072–3105 | o=1/m, o_M*, cutoff fora do domínio | Subtração por ramos e salto calculado | Validado analiticamente |
| F39 | T_U e condições de sinal de T_M, 3107–3151 | Fontes conjuntas não vazias; vínculos mantidos | Traduções de vetores; condições de T_M são identidades | Validado analiticamente |
| F40 | Q diagonal, 3153–3184 | Público agenda versus privado baseline | Q=D−βIR^B; endpoint e ex ante | Validado analiticamente |
| F41 | I_U e ΔI, 3270–3309 | Fontes de renda existentes; todos os endpoints | Subtrações ligadas, sinal de z−z_H | Validado analiticamente |
| F42 | Propagação de vazios e escopo temporal, 3311–3347 | Jogos distintos, proposta obrigatória | Domínios das fontes e data de cada parcela | Definição consistente |
| F43 | Notação e tabelas de síntese, 536–555; 694–718; 2222–2297 | Fórmulas dos resultados já auditados | Comparação de símbolos, preços e células | Conteúdo matemático consistente |
| F44 | Resumo, discussão e aplicação, 35–299; 1268–1403 | Só implicações matemáticas do jogo | Condicionantes de pooling, timing, existência e agenda conferidos | Implicações matemáticas consistentes; história e novidade não certificadas |

## Candidatos examinados, sem finding confirmado

**Variação do sinal de T_M (P1250–1255).** Considerei se a frase “Its sign can vary across the correspondence” afirmava necessariamente a existência de ganhos negativos. Ela também pode designar zero versus positivo, e essa leitura tem witness exato. Para (m,β,ℓ,h,p)=(4,.9,.1,.73,.25) e μ_off=0, o baseline seleciona S e a tabela pura da agenda admite pooling com z∈[.5913,.591625]. Como βV_M^B(h)=.5913, T_M(h) varia de zero a .000325. Não classifiquei a frase como erro nem extrapolei as equivalências de E.13 para afirmar a existência de valores negativos. Uma explicitação dos sinais efetivamente atingíveis pode facilitar a exposição, mas não é correção matemática exigida por este parecer.

**Pontos de suporte sem massa.** Não tratei a desigualdade estrita das médias locais como suficiente para um limite estritamente acima de p*. Conferi o passo adicional que exclui p* do conjunto de continuações, presente em P2015–2017. Esse passo resolve a objeção; não há finding.

**Linguagem de leis atomless na família baixa (P2656).** A família exige um átomo positivo da lei baixa em xℓ. A possibilidade de parte atomless ou de lei alta atomless não elimina essa condição expressa. Não interpretei a frase como autorização para apagar o átomo obrigatório nem a registrei como falha da correspondência.

## Verificação computacional e seus limites

O script independente usa somente a biblioteca padrão de Python e `fractions.Fraction`. Ele confere o hash antes dos cálculos; usa m=3,…,10, cinco descontos racionais, tipos interiores incluindo o limiar 1/m e seus dois lados, priors endpoints, p*, p_SE, p_SP e empates residuais. As comparações não usam tolerância de ponto flutuante.

Entre as contagens: 10.405 comparações de células e desempates majoritários; 10.405 enumerações de cardinalidades e ofertas nos limiares após a redução analítica; 73.878 classificações de completamento unânime; 10.405 testes do ballot obstrutivo; 10.475 verificações de cada bound de continuação/minimalidade de agenda M; 3.060 witnesses altos de agenda U; além de identidades e exemplos. O total de 172.316 conta asserções, não economias independentes nem a cardinalidade do espaço contínuo.

Não há discretização de medidas Borel no script, nem tentativa de inferir prova por ausência de contraexemplos numa grade. A cobertura dessas leis reside nas condições de melhor resposta, na prova de suporte e nos argumentos de mensurabilidade expostos acima. Não certifiquei a compilação ou a aparência das figuras/PDF; apenas o conteúdo matemático dos números e descrições localizadas.

## Sugestões delimitadas de formalização em Lean

Nenhum código Lean foi executado, instalado ou alterado. As prioridades abaixo são sugestões para uma etapa separada, sem alegação de cobertura existente no repositório.

| Componente | Alvo que vale formalizar | Dificuldade e ferramentas |
|---|---|---|
| Protocolo | Transição única para cada (C,x,votos), zero fora de C e ausência de acúmulo | Baixa/média: tipos finitos, `Finset`, distinção por casos |
| Maioria baseline | k+1≤m; preços; Π_E, Π_S, Π_P; sinais e empates, denominadores positivos | Baixa/média: `omega`, `linarith`, `nlinarith`, `field_simp` |
| Unanimidade baseline | Quatro perfis de H e certificado de não existência em s† | Média: enumeração finita depois de formalizar crenças e T^Y |
| Comparações | IR, ΔIR, D, T, I, Q; domínios e peso residual comum | Baixa/média: vetores finitos, conjuntos e mapas afins |
| Agenda M | Piso seguro e bound que exclui k+1 convidados aprovados | Média: somas finitas, desigualdades uniformes e invariantes do seletor |
| Agenda U | Payoff comum, família baixa/alta e lema de x^h no suporte | Alta: medidas, suporte, quase certamente versus ponto a ponto e limites |
| Representação | Invariante completo de órbita sob grupo finito; fatoração Borel | Média/alta: ações de grupos e infraestrutura de medidas/quotientes |

A infraestrutura de diferenciação não precisa ser reconstruída do zero: a documentação oficial da Mathlib contém `Besicovitch.ae_tendsto_rnDeriv`, sobre a convergência quase certa de razões de medidas de bolas fechadas para a derivada de Radon–Nikodym. Uma implementação ainda precisaria ajustar o simplex, medidas estendidas, convenção de bolas e hipóteses do jogo; a presença desse teorema não formaliza automaticamente B.8. [Mathlib, Besicovitch covering theorems](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Covering/Besicovitch.html), consultada em 24/9/2026.

Para preservar a fidelidade, o primeiro objeto Lean deve distinguir prior inicial, posterior de entrada, coordenada local livre e posterior de agenda. Deve também distinguir proposição sobre todo desvio de proposição quase certa sob a lei de equilíbrio. Formalizar somente as identidades finais deixaria sem cobertura justamente as dependências mais relevantes desta auditoria.

## Conclusão delimitada

As provas examinadas sustentam os resultados matemáticos explicitamente condicionais do snapshot auditado: a regra altera a possibilidade de excluir o único informado; pooling unânime na célula existente cria renda do tipo baixo; a extensão de agenda tem correspondências próprias e um domínio suficiente uniforme de vantagem majoritária. O cálculo não transforma essas conclusões em preferência institucional universal, explicação causal da OMC ou resultado sobre votos mistos. Não encontrei correção matemática obrigatória neste passe independente. A adjudicação conjunta deve conservar os bytes, o domínio de solução e as limitações de verificação aqui registrados.
