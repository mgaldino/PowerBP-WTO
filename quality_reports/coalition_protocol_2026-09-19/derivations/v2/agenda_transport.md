# Agenda sob contratos de coalizão: derivação, limites de transporte e leis completas

Data: 2026-09-19. Implementador: `agenda_source_read`. Documento fora do manuscrito, destinado a revisão independente. A nova autoridade é `quality_reports/coalition_protocol_2026-09-19/author_decision.md`; A1–A3 não são adotadas. Fonte histórica: `formal_model_v6.Rmd`, SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`, HEAD observado `c6dfab61a5a3b44d09ba389911df47726f81b51e`. A leitura histórica em `quality_reports/peio_2027_2026-09-19/source_reads/agenda.md` permanece aplicável à identificação de claims, não ao novo protocolo.

**Candidata v2, sem aprovação independente:** incorpora F-001 e F-002, confirmados em `adjudication/preliminary_v1.json`, e a precisão de F-003/QI-05, confirmada pelo coordenador a partir de `reviews/formal_derivations_v1.md` e do contrato v1. F-001 corrige a álgebra de A-C5; F-002 é demonstrado em `v2/unanimity_support_lemma.md` e fecha as duas invocações de \(x^h\) em B.8. F-003 explicita a probabilidade um no argmax já exigida por A14, sem acrescentar contenção do suporte topológico nem novo refinamento. As cópias v2 de contrato/R2/R1 são idênticas aos bytes v1. Os 409 checks descritos na seção 12 continuam sendo o registro histórico v1; não foram reexecutados. Os novos checks de F-001 estão separados em `v2/repaired_algebra_checks.py` e seu JSON. Os demais pontos permanecem fora desta intervenção.

## 1. Resultado e fronteira lógica

Sob maioria, a extensão deve ser formulada sobre sinais públicos `(C,x)`, pois a identidade dos convidados pode informar o tipo de H. Não há equivalência de jogos com a formulação histórica cujo sinal era somente x. Há dois fatos concretos:

1. Em qualquer proposta de A que passa, os convidados fracos recebem parcelas estritamente positivas; portanto C é recuperável de x **nesse ramo**. Com a interface econômica E/S/P abaixo, toda proposta aprovada usada em equilíbrio tem exatamente k convidados fracos, quase certamente sob a lei de cada tipo.
2. A mesma alocação pode passar com uma coalizão e fracassar com outra que acrescente um convidado com parcela zero. Essas são mensagens públicas distintas. A seção 7 constrói um equilíbrio puro no qual os tipos usam o mesmo x e se separam apenas por C. Também constrói um equilíbrio histórico com pequena parcela para um fraco dispensável cujo vetor x não pode passar em nenhuma coalizão factível nova.

Apesar dessa mudança da correspondência estratégica, as condições de **payoff** das formas puras de maioria são novamente deriváveis, assim como o critério exato de membership de medidas Borel no espaço novo. Os benchmarks públicos, o limite majoritário seguro, a região suficiente de vantagem da maioria e o exemplo de reversão informacional conservam suas fórmulas, desde que a interface completa do novo baseline seja a descrita abaixo. A afirmação é uma nova derivação no novo espaço; não é transporte literal de todas as estratégias ou leis antigas.

Sob unanimidade, C é sempre o conjunto de todos os jogadores. Acrescentar/remover essa etiqueta constante é um isomorfismo da árvore inteira, inclusive desvios e payoffs. A agenda unânime e seu baseline histórico podem ser transportados por esse mapa, condicionadamente à correção dos resultados históricos citados.

**Fechamento como candidata de implementação:** as interfaces completas R2/R1 do coordenador foram recebidas, lidas integralmente e tiveram seus hashes conferidos antes de fechar a solução da agenda. Seus identificadores estão na seção 13. Elas coincidem com a interface parametrizada usada nas provas e especificam os votos/crenças off-path e kernels que faltavam ao trabalho estrutural inicial. Este fechamento depende desses bytes e de sua correção; não é PASS de revisão independente. A ordem respeita `solve-dynamic-games`: o trabalho anterior ao recebimento limitou-se ao contrato e aos teoremas parametrizados, sem promover a continuação a resultado certificado.

## 2. Contrato do estágio A

Há H e W={1,…,m}, m≥3, e N={H}∪W. O tipo de H é o∈{ℓ,h}, 0<ℓ<h<1, com prior p∈[0,1]. H conhece seu tipo. O fator de desconto é β∈(0,1). Escreva k=⌊(m+1)/2⌋ e q=k+1. Em A, H propõe obrigatoriamente.

As coalizões admissíveis em A são

\[
\mathcal C_M^A=\{C\subseteq N:H\in C,\ |C|\ge q\},
\qquad \mathcal C_U^A=\{N\}.
\]

Para cada C, defina

\[
X_C=\{x\in\mathbb R_+^{m+1}:\sum_{i\in N}x_i\le1,
\ x_i=0\text{ se }i\notin C\},\qquad
Y_g=\bigsqcup_{C\in\mathcal C_g^A}(\{C\}\times X_C).
\tag{A1}
\]

O sinal público é y=(C,x). Cada componente tem a topologia euclidiana relativa; coalizões distintas são componentes distintas. Essa é a extensão tipada da disciplina de sinais existente: uma coalizão pública não pode ser esquecida antes da atualização de crenças. A união é finita de simplexes compactos, portanto Y_g é compacto metrizable e padrão Borel. Pode-se usar uma métrica que coincida com a euclidiana em cada componente e separe coalizões distintas por distância maior que o diâmetro de um simplex. Uma permutação de nomes fracos age por isometria.

| Nó | Informação/ações | Transição/payoffs |
|---|---|---|
| H propõe em A | Observa tipo e história pública; escolhe qualquer y∈Y_g. | Proposta e coalizão tornam-se públicas. O proponente conta como sim. |
| Consentimento | Cada j∈C\{H} observa y; votos simultâneos e puros. Não convidados não votam. | Só o consentimento de todos os convidados implementa o pacote. |
| Passagem | Nenhuma decisão adicional de execução. | H recebe x_H; convidados fracos recebem x_j; excluídos recebem zero. Como H é proponente, H pertence a C. |
| Recusa de algum convidado | Vetor dos votos efetivos e resultado tornam-se públicos. | Nenhum pagamento em A; entra-se em um assessment completo de R1 sob a mesma instituição e posterior. |

É conveniente codificar a participação no vetor de votos por `⊥` para não convidados; `⊥` não é voto não nem ação adicional. Uma recusa de convidado rejeita inclusive uma coalizão superdimensionada. Não existe opção de H escolher C sem si, votar outra vez em A, saltar a proposta, ou executar uma alternativa depois da aprovação.

Mantêm-se as restrições específicas da extensão histórica: seleção pública, anônima e Markov da continuação por instituição, estágio e posterior; disciplina local de Bayes no suporte dos sinais; um único μ^off=b_ρ(p) fora do suporte; e votos fracos as-if-pivotal com sim na igualdade. Não se impõem essas restrições Markov/off-support às crenças internas do baseline. A fonte completa importada continua seguindo a disciplina própria do baseline.

Se σ_ℓ,σ_h∈P(Y_g) são leis Borel e \(\bar\sigma=(1-p)\sigma_\ell+p\sigma_h\), seja S=supp(\barσ). Para p interior, a condição local passa a ser

\[
\mu(C,x)=\lim_{\varepsilon\downarrow0}
\frac{p\,\sigma_h(B_{Y_g}((C,x),\varepsilon))}
     {\bar\sigma(B_{Y_g}((C,x),\varepsilon))}
\quad\text{para todo }(C,x)\in S.
\tag{A2}
\]

O denominador é positivo no suporte; a existência do limite em todos os pontos, inclusive limites de massa zero, é requisito mantido. Fora de S, μ=μ^off. Nos endpoints, μ=p em todo Y_g e o tipo de probabilidade zero ainda recebe estratégia e payoff contrafactual. O mesmo argumento Borel por razões de medidas de bolas e limites pontuais usado na fonte histórica aplica-se em cada uma das finitíssimas faces; logo μ é Borel. Bayes também satisfaz a identidade de medidas \(\int_E\mu\,d\bar\sigma=p\sigma_h(E)\) para conjuntos Borel E. Não se usa posterior calculado da projeção x se C também é observado.

## 3. Interface de continuação e ordem de dependência

Denote por B_g^C(μ) a correspondência completa do **novo** baseline na crença de entrada μ, com suas convenções de suporte e endpoints. A seleção κ_g(μ) precisa devolver um membro literal completo admissível, público e comum aos tipos compatíveis com a história. Esse membro contém estratégias, crenças, reconhecimento, coalizões, votos efetivos, payoffs e leis de terminais. Seu kernel realizado e os mapas usados a seguir devem ser Borel. Não basta fornecer c e h como números.

A ordem de dependência é

\[
\text{novo R2}_g\to\text{novo R1}_g\to
\kappa_g(\mu)\to\text{votos em A}\to
\text{propostas de H}\to\Gamma_g\to
\text{assinaturas/comparações}.
\]

Não se rederiva aqui R1/R2. A interface econômica conferida no pacote fechado do coordenador é:

| Estado majoritário selecionado ξ | Valor nativo comum de um fraco c_ξ(μ) | Vetor nativo de H h_ξ=(h_ℓ,h_h) |
|---|---|---|
| E: exclusão | 1/m | (ℓ,h) |
| S: screening | `[(1−μ)(1−βℓ)+μβ]/m` | (βℓ,βh) |
| P: pooling | (1−βh)/m | (βh,βh) |
| EP: mistura residual | λc_E+(1−λ)c_P | λh_E+(1−λ)h_P |

Na interface, S só é selecionado quando Π_S≥Π_E; P só é selecionado quando h≤1/m; EP só na igualdade residual autorizada, usando **o mesmo λ** nos payoffs, propostas, coalizões e kernel. O representante anônimo fechado pelo coordenador reconhece i uniformemente e sorteia uniformemente k parceiros fracos em E e k−1 em S/P; R2 majoritário usa uma coalizão mínima de q fracos, também uniformemente. A eventual multiplicidade de outras coalizões de R2 não é removida do jogo: esse representante é a seleção específica consumida pela extensão.

Escreva χ(μ) para o estado e suas escolhas literais. Os valores na data A são

\[
r_\chi(\mu)=\beta c_\chi(\mu),\qquad
d_{\chi,o}(\mu)=\beta h_{\chi,o}(\mu).
\tag{A3}
\]

Há exatamente um β entre R1 e A. Nenhum pagamento é realizado em A quando há recusa. Sob unanimidade, a interface histórica é transportada pelo isomorfismo da seção 9: seu domínio é \(\{0\}\cup(p^*,1]\), com \(p^*=(h-\ell)/(1-\ell)\), sujeito à validade da caracterização histórica. Os valores de rejeição são β²ℓ para o baixo em μ=0, β²h para o alto em μ=0 e β²h para ambos em μ>p*.

## 4. Votos, coalizões e garantias: provas locais

### Proposição A-C1: regra de consentimento

Dado y=(C,x) e posterior μ, cada fraco convidado j aceita se e somente se x_j≥r_χ(μ), com igualdade aceita. Assim

\[
a_M(C,x)=\prod_{j\in C\setminus\{H\}}
1\{x_j\ge r_\chi(\mu(C,x))\}.
\tag{A4}
\]

**Prova.** Sob a comparação pivotal prescrita, seu sim entrega x_j se todos os demais convidados consentem e seu não entrega o valor da continuação de R1, transportado uma vez. O seletor Markov usa o mesmo posterior após qualquer recusa fraca: a recusa não informa o tipo e o seletor não depende de C, x ou do vetor de recusas além de μ. Portanto a diferença relevante é x_j−r_χ(μ). Sim na igualdade conclui. A regra é aplicada também quando outro voto prescrito faz a pivotalidade factual ter probabilidade zero, conforme a disciplina as-if-pivotal mantida. Não convidados não fazem comparação nem emitem voto. □

### Proposição A-C2: recuperação de C no ramo que passa

Se r_χ(μ)>0 e y passa, então

\[
C=\{H\}\cup\{j\in W:x_j>0\}.
\tag{A5}
\]

**Prova.** Todo convidado fraco que consente recebe ao menos r>0. Todo não convidado tem parcela zero pela factibilidade. H pertence a C por ser proponente, independentemente de x_H. □

Isso não é definição do espaço de ações. Coalizões com convidados de parcela zero continuam factíveis e são rejeitadas em A. A identidade não autoriza atualizar crenças apenas por x antes de saber que se trata de um ramo que passa, nem autoriza omitir C de terminais rejeitados.

### Proposição A-C3: escolha ótima a posterior fixado

Se 0<r≤β/m, a melhor proposta que passa **a um posterior dado** compra exatamente k votos fracos, paga r a cada um e deixa

\[
a_\chi^{pass}(\mu)=1-k r_\chi(\mu)
\tag{A6}
\]

a H. Toda parcela z∈[0,a^pass(μ)] pode ser implementada por uma coalizão mínima: pague r aos k convidados e deixe o orçamento restante não alocado. Uma proposta com x_H=1 e parcelas fracas zero, em qualquer C admissível, é rejeitada e produz d_χ,o(μ).

**Prova.** Se há s≥k convidados fracos, passagem exige custo pelo menos sr, estritamente crescente em s. Com k convidados o limite é atingido e a soma é um; com share z menor, a soma é no máximo um. Na proposta de rejeição cada convidado fraco prefere estritamente a continuação, pois r>0. □

A conclusão de melhor oferta condicionada a μ não prova que toda proposta de equilíbrio privado maximize a parcela a esse μ: uma alteração de mensagem pode alterar a crença. A próxima proposição fornece um argumento independente das crenças contra passagem com coalizão superdimensionada.

### Proposição A-C4: limite uniforme e exclusão de passagem superdimensionada usada em equilíbrio

Na interface da seção 3, escreva w=β/m. Então, para todo posterior e estado selecionável,

\[
\frac{1-w}{m}\le c_\chi(\mu)\le\frac1m,
\qquad w(1-w)\le r_\chi(\mu)\le w.
\tag{A7}
\]

Em todo assessment de agenda existente e para cada tipo,

\[
V_M^A(o)\ge v_M^{safe}:=1-kw.
\tag{A8}
\]

Uma proposta aprovada com pelo menos k+1 convidados fracos dá a H estritamente menos que v_M^safe. Logo não é um desvio lucrativo contra um assessment existente e não pode ser usada com probabilidade positiva por nenhum tipo em equilíbrio. Em particular, toda proposta aprovada usada em equilíbrio tem |C|=k+1, quase certamente.

**Prova do limite.** Em E, c=1/m. Em P, h≤1/m implica 1−βh≥1−w. Para S, ponha t=βℓ. As utilidades do proponente na interface são

\[
\Pi_E=1-kw,\qquad
\Pi_S=(1-\mu)[1-(k-1)w-t]+\mu w.
\]

Uma identidade direta dá

\[
mc_S-(1-w)=(\Pi_S-\Pi_E)+\mu(\beta-kw)\ge0,
\tag{A9}
\]

pois S só é selecionável quando Π_S≥Π_E e k<m. Os limites superiores seguem das fórmulas; EP preserva ambos por convexidade com o mesmo peso. Multiplique por β para obter (A7).

**Prova da garantia e da cardinalidade.** H pode convidar quaisquer k fracos, pagar w a cada um e ficar com 1−kw. Essa proposta passa qualquer que seja o posterior, pois todos os preços são no máximo w. Portanto (A8) independe de crenças. Se há pelo menos k+1 convidados e passagem, (A7) e factibilidade dão

\[
x_H\le1-(k+1)w(1-w)
<1-kw,
\tag{A10}
\]

porque a diferença entre o lado direito de (A8) e o primeiro limite de (A10) é \(w[1-(k+1)w]>0\); k+1≤m e β<1. Isso exclui a proposta do argmax de cada tipo. Em medidas Borel, a igualdade de melhor resposta vale quase certamente; não se afirma que todo ponto de massa zero do suporte seja um argmax. □

Coalizões superdimensionadas **rejeitadas** não são excluídas. Sua recusa rende d_o no posterior que a mensagem induz, e C pode sinalizar o tipo. Não se pode substituir uma recusa por acordo com uma subcoalizão dos convidados originais: a proposta autorizada fracassa integralmente.

Também existe a garantia \(V_M^A(o)\ge\beta^2o\): uma proposta com parcelas fracas zero sempre rejeita e, em E/S/P/EP, o payoff de rejeição é ao menos β²o. Consequentemente

\[
V_M^A(o)\ge\max\{v_M^{safe},\beta^2o\}.
\tag{A11}
\]

## 5. Informação pública e condições de payoff das formas puras privadas

### Proposição A-C5: benchmarks públicos

Condicionalmente à interface pública de R1, as fórmulas públicas são

\[
v_U^A(o)=1-\beta+\beta^2o,
\qquad
v_M^A(o)=
\begin{cases}
1-k\beta(1-\beta o)/m,&o\le1/m,\\
\max\{1-k\beta/m,\beta o\},&o>1/m.
\end{cases}
\tag{A12}
\]

**Prova.** Com o público, os valores nativos de R1 são c=(1−βo)/m e h=βo quando a continuação inclui H, e c=1/m e h=o quando a maioria o exclui. Use (A3) e (A6). No primeiro ramo majoritário,

\[
1-k\beta(1-\beta o)/m-\beta^2o
=1-k\beta/m-\beta^2o(1-k/m)>1-\beta>0.
\]

A primeira desigualdade é estrita porque a diferença para \(1-\beta\) é \(\beta(1-k/m)(1-\beta o)>0\), usando \(k<m\), \(0<\beta<1\) e \(0<o<1\).

No segundo, compare passagem segura a βo. Toda proposta que passa e é ótima compra exatamente k convidados a seu cutoff; toda proposta rejeitada entrega a mesma continuação pública. No empate, qualquer medida sobre esses argmax é permitida, com o mesmo peso ligando sinal, passagem e payoff. Sob unanimidade, H precisa pagar todos os m fracos e passagem vence rejeição β²o por 1−β. □

Assim, o cutoff \(o_M^*=1/\beta-k/m\), o gap público e D_g da seção 6/E.6–E.8/E.12 conservam as fórmulas. A correspondência de **propostas rejeitadas** majoritárias passa a incluir C e não é literalmente a antiga. Sob maioria pública, as coalizões aprovadas ótimas continuam mínimas.

### Proposição A-C6: payoff das formas puras de maioria privada

Fixe χ e p interior. Defina

\[
A_t=a_\chi^{pass}(t),\quad d_{o,t}=d_{\chi,o}(t),\quad
O_o=\max\{A_{\mu^{off}},d_{o,\mu^{off}}\},\qquad t\in\{0,p,1\}.
\]

Sob a interface da seção 3, as condições necessárias e suficientes para existência de cada **forma pura e vetor de payoff** são:

| Forma | Condições | Vetor |
|---|---|---|
| Pooling com acordo | `O_h≤A_p`; z∈[O_h,A_p] | (z,z) |
| Pooling com recusa | `d_ℓ,p≥O_ℓ` e `d_h,p≥O_h` | (d_ℓ,p,d_h,p) |
| Separação, ambos acordam | `O_h≤min{A_0,A_1}`; z nesse intervalo | (z,z) |
| Baixo acorda, alto recusa | `d_h,1≥O_h`; `max{d_ℓ,1,O_ℓ}≤z≤min{A_0,d_h,1}` | (z,d_h,1) |
| Baixo recusa, alto acorda | Impossível | ∅ |
| Separação, ambos recusam | `d_ℓ,0≥d_ℓ,1`, `d_h,1≥d_h,0`, `d_ℓ,0≥O_ℓ`, `d_h,1≥O_h` | (d_ℓ,0,d_h,1) |

**Prova.** Um perfil puro tem no máximo dois sinais y. Em cada face X_C há infinitas propostas que recusam. A oferta mínima que passa em μ^off pode ser aproximada por ofertas que diminuem x_H por ε>0, preservam os k pagamentos e evitam os finitíssimos sinais em suporte. Assim o supremo off-support é exatamente O_o, mesmo que o pacote maximizador esteja no suporte. `O_h≥O_ℓ` pois o termo de passagem é comum e a rejeição do alto é fracamente maior.

No pooling, a crença é p; acordo produz z comum e recusa produz d_o,p. As condições da tabela são factibilidade e proteção contra off-support. Na separação, as crenças são 0 e 1. Se ambos os sinais passam, cada tipo pode copiar o par **(C,x)** do outro e obter sua parcela; imitação bilateral exige z comum. Se só o baixo passa, as duas restrições de imitação são z≥d_ℓ,1 e d_h,1≥z, acrescidas de factibilidade/off-support. O padrão reverso exigiria d_ℓ,0≥z≥d_h,0, impossível porque d_h,0>d_ℓ,0 na interface endpoint. Se ambos recusam, a imitação compara os dois d por tipo.

Para suficiência, construa acordos em coalizões mínimas conforme A-C3 e recusas com parcela zero para algum convidado. Os sinais separadores podem ser escolhidos distintos: há mais de uma coalizão mínima porque k<m; há também um contínuo de sinais rejeitados. Não é necessário apagar ou identificar coalizões superdimensionadas rejeitadas. Prescreva posterior 0/1 nos dois átomos, ou p no átomo pooling, e μ^off fora; cada face tem a topologia especificada em (A2), e Bayes nos átomos satisfaz a disciplina. As desigualdades excluem todas as propostas fora do suporte e toda imitação, e os votos são (A4). □

A tabela caracteriza payoffs e existência de formas. Um catálogo completo de **estratégias** deve ainda deixar variar todos os pares (C,x) que realizam cada forma e obedecem aos votos e à factibilidade. Não se deve substituir essa família por uma lista de propostas canônicas.

### Existência majoritária para algum ρ

Ponha T=v_M^safe/β. A construção histórica tem análogos factíveis novos:

- Se h≤T, use μ^off=p (ρ=1), χ fixado e pooling na proposta mínima que passa ao posterior p. A rejeição em E é no máximo βh≤v_safe; em S/P é no máximo β²h<v_safe; EP preserva a comparação. O acordo maximizador vence esses desvios.
- Se ℓ≤T≤h, use μ^off=1, faça o baixo passar com z=v_safe e o alto enviar proposta rejeitada. A tabela dá as condições: d_ℓ,1=βℓ≤v_safe≤βh=d_h,1, e A_0≥v_safe.
- Se T≤ℓ, o baseline exclui H em todos os posteriores, pois T>1/m. Ambos podem propor a mesma recusa e receber βo≥v_safe para qualquer ρ.

Os empates são retidos e endpoints são tratados pelo argmax. Isso prova existência para **algum** ρ em toda economia da interface, não para todo ρ fixado nem identidade com a correspondência histórica de leis.

## 6. Correspondência Borel exata no novo espaço

Um binder de maioria R_M^C contém, no mínimo,

\[
(\rho,\mu^{off},\sigma_\ell,\sigma_h,\bar\sigma,\mu,
\kappa_M,\chi,b_M,a_M,u_\ell,u_h,
K^D,\Gamma_\ell,\Gamma_h),
\]

onde σ_o∈P(Y_M), b_M:Y_M→{Y,N,⊥}^m é o vetor de votos efetivos dos fracos, a_M é passagem, κ_M é a seleção completa e K^D seu kernel literal. Todas as coordenadas pertencem ao mesmo binder. Escreva

\[
u_o(C,x)=a_M(C,x)x_H+[1-a_M(C,x)]d_{\chi,o}(\mu(C,x)),
\qquad V_o=\int_{Y_M}u_o\,d\sigma_o.
\tag{A13}
\]

O mapa u_o^off avalia y usando μ^off e a mesma seleção. Com S=supp(\barσ), defina

\[
\mathfrak O_o(S)=\sup_{y\notin S}u_o^{off}(y),
\]

com supremo do vazio −∞.

### Teorema A-C7: membership por ponto e por medida

Dada uma seleção admissível completa de continuacões, Bayes (A2), a regra (A4) e os payoffs (A13), um binder é equilíbrio exatamente quando, para ambos os tipos,

\[
u_o(y)\le V_o\quad\forall y\in S,\qquad
u_o(y)=V_o\quad\sigma_o\text{-q.c.},\qquad
V_o\ge\mathfrak O_o(S).
\tag{A14}
\]

**Prova.** Qualquer y, com qualquer C admissível, é desvio disponível a qualquer tipo. A primeira desigualdade elimina desvios no suporte, incluindo sinais do outro tipo e pontos limite de massa zero. A última elimina todos os desvios fora do suporte, incluindo convites extras destinados a obter uma recusa. Uma mistura de melhores respostas é apoiada no argmax quase certamente, produzindo a igualdade. Reciprocamente, as três condições eliminam qualquer proposta desviante; a regra pivotal determina os votos em toda proposta; e a interface importada determina comportamento sequencialmente racional após qualquer recusa. A parte de crenças já foi incluída nas hipóteses. □

A Borelidade segue por composição: μ e χ são Borel; os custos por estado são Borel; os conjuntos {y:x_j≥r_χ(μ(y))} são Borel como pré-imagens de [0,∞) pelo mapa Borel x_j−r_χ∘μ; produtos finitos e indicadores de componentes C são Borel; u_o é Borel. As integrais e kernels usados abaixo são, portanto, bem definidos. Não é alegada igualdade ponto a ponto de payoff em todo suporte: apenas desigualdade ponto a ponto e igualdade quase certamente.

Nos endpoints, posterior é fixado em p e cada σ_o pode ser qualquer medida que atribua probabilidade um ao argmax de u_o no novo Y_M, isto é, \(\sigma_o(\operatorname{argmax}_{Y_M}u_o)=1\). Seu valor é \(\max\{A_p,d_{o,p}\}\). A estratégia do tipo de probabilidade zero é incluída. Um ponto de suporte de massa zero precisa apenas satisfazer a ausência de desvio lucrativo, \(u_o(y)\le V_o\); a igualdade é exigida \(\sigma_o\)-quase certamente, não em todo ponto do suporte topológico. Não se exige \(\operatorname{supp}(\sigma_o)\subseteq\operatorname{argmax}_{Y_M}u_o\). Este critério é uma caracterização exata funcional, não uma enumeração finita de todos os suportes, e não acrescenta refinamento a A14.

## 7. Coalizão como sinal: duas contraprovas de equivalência literal

### Exemplo A-EX1: mesmo x, tipos separados por C

Tome m=4, k=2, β=.9, ℓ=.1, h=.9 e qualquer p interior. Use μ^off=1. Defina

\[
x=(.55,.225,.225,0,0),\quad
y_\ell=(\{H,1,2\},x),\quad
y_h=(\{H,1,2,3\},x).
\]

O baixo propõe y_ℓ e o alto y_h. Bayes no par observado dá μ(y_ℓ)=0 e μ(y_h)=1. Em zero, r_0=.20475, portanto 1 e 2 aceitam y_ℓ. Em um, r_1=.225; o convidado 3 recebe zero e recusa y_h, rejeitando o pacote inteiro. Os payoffs são (.55,.81).

O baixo que copia y_h recebe βℓ=.09<.55. O alto que copia y_ℓ recebe .55<.81. Fora do suporte, o melhor acordo deixa .55 e a rejeição dá .09 ao baixo e .81 ao alto; logo nenhum tipo melhora. Todos os votos fora do caminho seguem (A4). As propostas são factíveis e Bayes tem átomos isolados em componentes distintos. Assim o perfil satisfaz A-C7, condicionalmente à interface completa.

Esquecer C faz ambas as leis de proposta virarem o mesmo átomo x e perde tanto a revelação do tipo quanto a distinção acordo/recusa. Logo a projeção x não transporta este assessment para um assessment histórico com as mesmas leis, crenças e outcomes. O exemplo não afirma que seu vetor de payoffs fosse impossível em outra estratégia antiga.

### Exemplo A-EX2: parcela pequena ao fraco dispensável no jogo antigo

Tome m=4, k=2, β=.9, ℓ=.1, h=.6, p=.1 e μ^off=1. A continuação em p é S, pois p≤p_SE. Seu preço fraco é r=.204525. No jogo histórico, ambos os tipos podem propor

\[
x=(.56,.204525,.204525,.01,0).
\]

A soma é .97905. Dois fracos aceitam; o fraco com .01 recusa, mas o limiar majoritário é atingido. Ambos os tipos recebem .56. Fora do suporte, μ=1 implica melhor passagem .55 e rejeição (.09,.54), logo nenhum tipo melhora. O pooling é um assessment histórico admitido pela tabela E.2, com seus votos fora do caminho e a continuação selecionada.

No novo protocolo, qualquer C factível para esse mesmo x deve conter os fracos 1,2,3. A parcela .01 do terceiro é inferior ao custo de consentimento; ele recusa e o pacote inteiro fracassa. Não há coalizão factível que implemente esse x. Esse exemplo demonstra que nem toda law histórica de acordos é transportável preservando as alocações. Uma nova proposta pode conservar .56 e eliminar a pequena parcela deixando-a não alocada, mas isso é outro sinal e requer suas próprias crenças/IC; igualdade de payoffs não equivale a identidade de estratégias.

## 8. Testemunha para a tabela de reversão informacional do manuscrito

O exemplo da seção 6 (`formal_model_v6.Rmd`, 1001–1020) pode ser realizado no novo protocolo sem alterar seus números. Use m=4, β=.9, ℓ=.1, h=.9, p=.95 e **μ^off=0 sob ambas as regras**, isto é, a mesma fibra ρ=0.

Sob maioria, o baixo propõe C={H,1,2} e

\[
x^\ell=(.5905,.20475,.20475,0,0).
\]

O alto propõe, na mesma coalizão, x^h=(1,0,0,0,0), que fracassa. Os posteriores são 0 e 1. O payoff do alto é .81. A oferta baixa é a melhor passagem em posterior zero; desvios off-support dão ao baixo no máximo .5905 e ao alto no máximo max{.5905,.729}=.729. Imitação do alto pelo baixo dá .09; imitação do baixo pelo alto dá .5905. As IC são satisfeitas.

Sob unanimidade, ambos propõem C=N e

\[
x^U=(.729,.06775,.06775,.06775,.06775).
\]

O posterior é p=.95>p*=8/9. O custo por fraco nesse posterior é .04275, e a proposta passa. Em μ^off=0, a melhor passagem deixa .181 e o alto pode rejeitar para obter .729. Logo o pooling em .729 satisfaz as IC de ambos os tipos. O baixo tem payoff público majoritário .5905 e unânime .181; sua renda privada sob unanimidade é .548 e sob maioria zero. Os contrastes são

\[
\Delta v^A(\ell)=-.4095,\qquad
\Delta V^A(\ell)=+.1385,\qquad
\Delta IR^A(\ell)=+.5480.
\]

Essa é uma testemunha concreta de um par de assessments na mesma economia e fibra, não uma seleção imposta ao conjunto inteiro. Seus binders completos dependem das continuações importadas, cujos hashes estão registrados na seção 13.

## 9. Unanimidade: isomorfismo integral, incluindo off-path

### Teorema A-C8

O novo jogo unânime, tanto no baseline quanto no estágio A, é isomorfo ao histórico pela aplicação que acrescenta C=N em toda proposta e sua inversa que remove essa etiqueta.

**Prova.** A quota força C=N. Logo a restrição x_{−C}=0 é vazia e o espaço de alocações é exatamente o simplex histórico. A votação em unanimidade já exigia sim de todos os respondedores, com proponente sim e votos simultâneos. Assim, para qualquer vetor de votos, a proposta passa nos dois jogos exatamente nas mesmas circunstâncias. Se passa, todos recebem x e H recebe x_H. Se fracassa, seguem-se a mesma rodada ou o mesmo desacordo terminal, nas mesmas datas. O ramo histórico “H não e proposta passa” é impossível sob unanimidade. Todas as informações, ações, sinais, atualizações e desempates são preservados, incluindo propostas ou votos desviantes. A aplicação entre histórias e estratégias é bijetiva, preserva payoffs ponto a ponto e é homeomorfismo nas componentes de propostas. Portanto preserva suportes, bolas relativas, limites locais de Bayes e pushforwards. □

Isso permite transportar B.8/E.3 e os resultados unânimes E.9/E.13/F.2 sem inventar uma arquitetura de execução. O transporte não é uma nova prova da correção histórica de B.4/B.8: é uma prova de que a mudança aprovada não altera esses jogos. Seus claims de não existência continuam restritos aos votos puros e à disciplina aprovada.

O atalho histórico de B.8 que trata \(x^h\) como necessariamente fora do suporte é corrigido separadamente no [lema de suporte unânime](unanimity_support_lemma.md). Sob \(\mu^{off}>p^*\), o lema demonstra \(V=z_H\) também quando \(x^h\) pertence ao suporte com massa zero, recorrendo à identidade média de Bayes e à admissibilidade do limite local. Ele se aplica tanto à exclusão de um posterior off-support alto na família com \(\lambda_0>0\) quanto à determinação da solução \(\delta_{x^h}\) na família com \(\lambda_0=0\). O reparo mantém as células de existência e os payoffs; é uma candidata sujeita à revisão independente de v2.

## 10. Kernels, leis completas e assinaturas no espaço novo

### 10.1 Objetos e mensurabilidade

O kernel de continuação deve registrar a coalizão proposta em cada rodada, a alocação, o reconhecido, o vetor de votos efetivos (com ⊥ para não convidados), aprovação/recusa, data terminal e payoffs. Seja Ω_D^{g,C} um espaço ambiente compacto que acomode essas histórias terminais finitas: uma união finita de produtos de simplexes de alocação, conjuntos finitos de coalizões/votos/identidades/datas e intervalos compactos de posterior/payoff. Usar um espaço ambiente evita identificar o conjunto de realizacões de um kernel descontínuo com um subconjunto fechado sem prova. O kernel K_{o,ξ}^{D,C} toma valores em P(Ω_D^{g,C}).

Defina

\[
\Omega_T^{g,C}=(\{\mathsf A\}\times Y_g)\sqcup
(\{\mathsf D\}\times\Omega_D^{g,C}),
\qquad
Z_g^C=Y_g\times[0,1]\times\{0,1\}\times\mathfrak C_g
\times\Omega_T^{g,C}.
\tag{A15}
\]

Aqui \(\mathfrak C_M=\{E,S,P\}\sqcup(\{EP\}\times[0,1])\) e \(\mathfrak C_U=\{L,P\}\) codificam os representantes selecionados. Toda multiplicidade de crenças/estratégias off-path que não está nesses rótulos continua no binder literal κ_g; não é eliminada por (A15).

Para y=(C,x), escreva ξ_g(y)=χ_g(μ(y)). A lei condicional terminal é

\[
L_o^R(d\omega\mid y)=a_g(y)\delta_{(\mathsf A,y)}(d\omega)
+[1-a_g(y)]\widetilde K_{o,\xi_g(y)}^{D,C}(d\omega),
\tag{A16}
\]

e a law realizada completa por tipo é

\[
\Gamma_o^{g,C,R}(E)=\int_{Y_g}\int_{\Omega_T^{g,C}}
1_E(y,\mu(y),a_g(y),\xi_g(y),\omega)
L_o^R(d\omega\mid y)\,\sigma_o(dy).
\tag{A17}
\]

Se os kernels importados são Borel em seu estado/seleção, (A16) é kernel Borel, e (A17) é probabilidade Borel em Z_g^C. O termo de passagem usa o sinal inteiro y, inclusive C. Não se adiciona desconto à law; o extrator de payoffs aplica a data correta, com um β na entrada do baseline. O exemplo A-EX1 prova que projetar y para x antes de formar (A17) pode identificar outcomes distintos.

No representante majoritário importado, a Borelidade do **kernel realizado** pode ser conferida diretamente: para primitivas fixas, há finitíssimas identidades e coalizões ótimas; sorteios uniformes têm pesos constantes; E/P têm kernels fixos; S usa o ramo correspondente ao tipo de H e o novo sorteio uniforme de R2 após recusa; EP é a mistura dos kernels E/P com o mesmo λ. A média interina dos fracos varia com μ em S, mas o kernel condicional a cada tipo é fixo nesse estado. A completude das estratégias que geram esses kernels é fornecida em `r1_interface.md` e `r2_interface.md`; não é substituída por essa observação sobre leis realizadas.

Para explicitar a compatibilidade da implementação literal: em cada R1_M, o respondedor fraco convidado usa x_j≥β/m; H convidado usa x_H≥βo quando todos os demais aceitam e vota Y quando alguma recusa fraca torna ambos os seus votos equivalentes. H não convidado não vota. Toda recusa entra no representante R2_M importado, no qual os convidados fracos aceitam qualquer parcela não negativa e H, se convidado, aceita x_H≥o. Nas crenças de denominador zero, escolher o posterior de entrada constitui o representante Borel especificado na interface; ele permanece no suporte permitido. Essas regras são definidas em todas as coalizões e alocações factíveis e usam apenas quantidades invariantes sob nomes fracos. Os sorteios uniformes são transportados por permutação para sorteios uniformes na coalizão renomeada. Isso verifica a equivariância do representante completo usado aqui, inclusive seu complemento off-path, sem declarar equivalência com o representante histórico majoritário.

### 10.2 Ação dos nomes e fatorização

Se τ∈G=S_m permuta os fracos, sua ação em y é

\[
T_\tau(C,x)=(\{H\}\cup\tau(C\setminus\{H\}),\tau x),
\]

fixando a coordenada de H. Ela também permuta todo nome fraco da história terminal: reconhecido, coalizões, alocações e votos, preservando ⊥ como indicador de não convite. A ação é homeomorfismo no espaço ambiente e deixa datas, tipo, posterior, estado econômico e payoffs anônimos invariantes. Sob seletores anônimos equivariantes, os kernels satisfazem o relabeling correspondente. Essa propriedade deve ser conferida nas estratégias completas importadas, não apenas nos valores c/h.

Ponha γ=(Γ_ℓ,Γ_h)∈P(Z_g^C)^2. Defina a lei da órbita diagonal

\[
\Lambda_\gamma=\frac1{|G|}\sum_{\tau\in G}\delta_{\tau\gamma}.
\]

Então a assinatura nova é \(Sig_g^{ex,C}(R)=(\rho,\mu^{off},\Lambda_\gamma)\), com (*,p) nos endpoints. O mapa γ↦Λ_γ é Borel porque para qualquer conjunto Borel B sua massa é a soma finita \(|G|^{-1}\sum_\tau1_B(\tau\gamma)\). É invariante; se duas leis de órbita coincidem, o singleton do segundo par de laws tem massa positiva na primeira e, portanto, pertence à mesma órbita. Isso prova completude do invariante de relabeling diagonal.

Escolha uma transversal Borel q_g^C das órbitas finitas de Z_g^C. O resumo econômico é

\[
Sum_g^{econ,C}(R)=(\rho,\mu^{off},(q_g^C)_\#\Gamma_\ell,
(q_g^C)_\#\Gamma_h).
\tag{A18}
\]

Todo observável Borel invariante f sobre a tupla realizada é constante na órbita, logo tem fator único \(f=\bar f\circ q_g^C\). Se integrável, sua integral pode ser tomada na law pushforward. Isso inclui payoff de H, passagem/atraso, law de posterior, multiconjunto de pagamentos fracos e tamanho de C. O operador institucional é aplicado primeiro a pares de binders completos na mesma economia/off-path; só depois esses extratores fatoram pelos resumos.

Esse argumento prova a extensão de B.9/F.1 **no novo espaço**, sujeito ao kernel/selector importado. Não afirma `Sig^{ex,C}=Sig^{ex,old}` nem identifica os binders por igualdade de payoffs. Sob maioria, A-EX1 e A-EX2 impedem tal identidade global. Sob unanimidade, A-C8 fornece a aplicação explícita entre espaços e laws.

Off-path continua fora da assinatura realizada: duas funções de crenças ou planos de continuação podem gerar a mesma Γ. Qualquer operação sensível a tais funções continua consumindo o binder completo. O conjunto de pares de laws entre instituições é composto de marginais contrafactuais; não se cria um sorteio comum entre M/U nem colagem de coordenadas de binders diferentes.

## 11. Consequências precisas para seção 6, B.7–B.9 e E–F

| Objeto histórico | Tratamento no novo protocolo | Prova/limite nesta nota |
|---|---|---|
| Protocolo de agenda e espaço de propostas, E.1 | Substituir x por (C,x), convidar apenas C e exigir consentimento de todos. | Seção 2; não é edição terminológica apenas. |
| Melhor passagem a posterior fixado e preços, B.7 | Mesmos números na interface, nova regra de passagem (produto sobre C). | A-C1/A-C3. |
| Propostas superdimensionadas | Passagem usada em equilíbrio é mínima; recusas superdimensionadas permanecem. | A-C4; vale quase certamente, não eliminação de todas as histórias. |
| Tabela pura E.2 | Condições de payoff e existência conservadas por nova prova; mensagens completas passam a variar em Y_M. | A-C6; não equivalência de toda proposta histórica. |
| Membership misto E.2/B.7 | Reescrever sobre medidas em Y_M e posterior do par (C,x). | A-C7. Não há alegação de bijeção com medidas em X. |
| Existência de maioria para algum ρ e limite seguro | Preservados na interface. | A-C4 e três testemunhas da seção 5. |
| Unanimidade B.8/E.3 | Transporte via C=N constante na árvore inteira. | A-C8; depende da correção histórica, não de A1–A3. |
| Assinaturas/laws B.9, E.2/E.3/F.1 | Novos espaços, coalizões/votos efetivos e kernels literais; mesma construção abstrata de órbitas. | Seção 10. Só U tem isomorfismo literal demonstrado. |
| Benchmark público E.6–E.8 e figura do gap | Fórmulas preservadas condicionalmente à interface pública baseline. | A-C5. |
| Região suficiente `βh<e/m` | Preservada: A-C4 dá limite inferior M e U transportada dá superior `1−β+β²h`. | `V_U−V_M≤−β(e/m−βh)`; exige ambos os binders existentes. |
| Incidência de renda unânime e figura de existência | Preservadas via isomorfismo U. | A-C8 e benchmarks públicos. |
| Exemplo numérico de reversão | Testemunha concreta nova na mesma fibra ρ=0. | Seção 8; números históricos reproduzidos exatamente. |
| Comparação exata M/U | Formar nova correspondência de pares completos em Y_M/Y_U. | Não substituir por produto de marginais nem alegar igualdade global de conjuntos antigos/novos. |
| `IR`, `D`, `I`, `T`, `Q` e identidades | Mesmas definições contábeis e uma conversão β; imagens devem usar as novas fontes. | Unanimidade transportada; maioria continua exata/set-valued pelo novo critério. |
| Afirmações genéricas de transportabilidade de outcomes | Não autorizadas por igualdade das fórmulas. | A-EX1/A-EX2 são contraprovas concretas. |

O resultado de vantagem majoritária usa apenas os dois limites, logo independe de uma bijeção entre correspondências antigas e novas. Similarmente, a identidade `T=D+I` é álgebra uma vez definidos os novos vetores. Nenhuma dessas observações certifica existência em célula que perdeu uma fonte; o vazio continua propagando-se.

## 12. Verificação e limites

O script `agenda_checks.py` usa frações exatas e grava `agenda_checks.json`. Foram executados **409 checks, todos aprovados**, abrangendo a identidade (A9) e o limite estrito de superdimensionamento para m=3,…,12 e pontos de fronteira; factibilidade, passagem e IC dos dois contraexemplos; e o par concreto que reproduz a tabela de reversão. Os checks são finitos e condicionais à interface declarada. Não verificam todas as leis Borel, a existência de cada seletor completo ou toda a prova do baseline.

As provas de A-C1–A-C7 explicitam dependência da interface; A-C8 é isomorfismo da forma extensiva. Mensurabilidade/fatorização são demonstradas no espaço novo na seção 10, consumindo os kernels completos Borel e equivariantes importados e verificados contra os hashes da seção 13. Não foi realizada revisão independente deste arquivo pelo implementador.

Variações de timing, informação ou forma de payoff são testes de escopo, não alterações propostas: permitir saltar A muda a garantia/valor do jogo; omitir C da observação pública muda Bayes e elimina A-EX1; permitir pagamentos positivos fora de C restaura a factibilidade de A-EX2 e invalida (A5). Esses três fatos indicam quais hipóteses sustentam o resultado sem abrir extensões não autorizadas.

## 13. Ledger de dependências e fechamento

| Nó | Estado nesta versão | Dependência |
|---|---|---|
| Contrato do novo estágio A e Y_g | Derivado da decisão autoral | `author_decision.md`; parâmetros históricos mantidos. |
| A-C8: isomorfismo U | Demonstrado estruturalmente | Formas extensivas históricas e nova decisão. |
| Interface majoritária E/S/P/EP completa | Recebida, lida e hashes conferidos | Novo R2/R1, estratégias/crenças e kernels completos. |
| A-C1–A-C7 e fórmulas M | Candidata de implementação fechada | Interface da seção 3 nos bytes abaixo; revisão independente pendente. |
| Kernels/Γ/assinaturas | Construção e provas fechadas como candidata | Kernel completo Borel/equivariante do baseline; novo espaço Y; revisão independente pendente. |
| Checks finitos | Executados: 409 PASS, 0 FAIL | Fórmulas da interface explícita e casos declarados. |
| Revisão independente | Pendente | Agente distinto; hashes finais comuns. |

Interfaces efetivamente consumidas, todas em `quality_reports/coalition_protocol_2026-09-19/derivations/`:

| Arquivo | SHA-256 verificado | Escopo consumido |
|---|---|---|
| `game_contract.md` | `ac78634ea0da03b422a6d92930680d1bb1f94deee0d3c33b68dc9d9791a7d058` | Primitivas, informação, suporte, consentimento, payoffs e disciplina de solução. |
| `r2_interface.md` | `c83cf10483bf42e750e131a0792eedde60ae0eed244822c84ea2a1be285dd8a7` | Respostas completas terminais, desacordo, sorteio uniforme e kernels em unidades R2. |
| `r1_interface.md` | `a07a14a115de877411319568a2982e6b5e6e6a8d03c550ead82a6e7078b487e0` | Respostas completas de R1, seleções E/S/P/EP, vetor por tipo, representante Borel e interface literal U. |

Antes do recebimento dessas interfaces, A-C1–A-C7 e a construção de laws eram somente teoremas parametrizados. Depois do recebimento, cada requisito da seção 3 foi conferido: mesmos preços, domínios, prioridades de empate, tipo de probabilidade zero, uma aplicação de β, respostas em propostas desviantes, kernels e escolhas Borel. Nenhuma dependência foi rederivada ou modificada por este implementador. A revisão científica deverá receber as três interfaces e este arquivo nos mesmos hashes.

Qualquer mudança no conjunto de coalizões, observação de C, consentimento de todos os convidados, disciplina de crenças de agenda, estado de seleção ou interface baseline reabre os descendentes pertinentes. Uma alteração de lei terminal que preserve c/h pode ainda invalidar Γ e as assinaturas. Uma alteração apenas de nomes por permutação é coberta pela ação definida acima; uma seleção de coalizões diferente com mesmo payoff não é automaticamente a mesma assinatura.
