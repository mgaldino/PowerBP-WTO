# Parecer formal independente — coalition-derivations-v1

**Revisor:** agente `/root/baseline_source_read`. **Data:** 19 de setembro de 2026. **Veredicto:** **FAIL para o fechamento formal do candidato v1 congelado**. O problema está em uma igualdade falsa e em uma passagem incompleta da prova histórica que a nova derivação consome. A auditoria reconstruiu os resultados correspondentes sem mudar as primitivas e não encontrou contraexemplo aos 17 enunciados do contrato. Isso não transforma os bytes examinados em uma prova corrigida: os reparos devem constituir novo candidato e receber revisão própria.

Este parecer é independente da implementação das quatro notas e dos scripts candidatos. O revisor produziu anteriormente leituras de compreensão e os contratos interpretativos do original e do bundle; essa função não foi apresentada como revisão científica. Não consultou o parecer adversarial corrente, seus scripts ou resultados, nem os arquivos v2. Leu a folha fria de R2, que antecede as interfaces propostas, como evidência separada; a solução abaixo também foi reconstruída diretamente. Nenhum arquivo candidato ou manuscrito foi alterado.

## 1. Identidade, fontes e fronteira da revisão

Objeto científico: quatro notas matemáticas fora do manuscrito, concatenadas integralmente em `derivations/derivation_bundle_v1.md` (903 linhas). O contrato de fidelidade tem ID `coalition-derivations-v1:b62a7c8e0235:round1`; seu PASS autoriza a leitura compartilhada do argumento, sem decidir a validade das provas.

| Fonte | SHA-256 |
|---|---|
| Bundle v1 | b62a7c8e023568bf408c1b8929b5909b4e7af21c3271c95955970237801b799f |
| Manifesto `reviews/derivation_candidate_v1.json` | 8dfefecda3b9e369159bbfeb4276f5f6d7c2402e3e897320774b39be12d1feca |
| `author_decision.md` | 7abfa53814ff23c61a9af2049c975be81e44f8e66270c4fa3f99accd51923726 |
| `game_contract.md` | ac78634ea0da03b422a6d92930680d1bb1f94deee0d3c33b68dc9d9791a7d058 |
| `r2_interface.md` | c83cf10483bf42e750e131a0792eedde60ae0eed244822c84ea2a1be285dd8a7 |
| `r1_interface.md` | a07a14a115de877411319568a2982e6b5e6e6a8d03c550ead82a6e7078b487e0 |
| `agenda_transport.md` | 3b98454cb275f34a89c6f5a10037eaa34e30e4fbf81e4fb4f01a65e2f8ba9f6f |
| `agenda_checks.py` | 9874ca255487e2245f8d44d3915e82cd6974331a7cd7a05278a7608e5de47445 |
| `agenda_checks.json` | 7e0a20ac6790a1f949e760c9fbf00d7d70b7290d266f9342dc794efa70e2a75e |
| Contrato interpretativo JSON | a49fc5f5d1737b7d8661506b6e384b709314a98798cacd33e4d981ffb5b07c36 |
| Original `formal_model_v6.Rmd` | 6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411 |
| Leitura independente de compreensão | 991663cef8090ce773865c7b81123f0a19be3a850eddd096155b14a7507c3b29 |
| Folha fria de R2 | 57b83c8d83fad84f6f5ce41a6e34d75c60ede19b3e09c71d307bd7d70764896c |

Checkout: branch `codex/exposition-items20-28`, HEAD `c6dfab61a5a3b44d09ba389911df47726f81b51e`. Mudanças preexistentes não foram revertidas.

Nas referências abaixo, **B** designa a linha do bundle; **M** designa a linha do original exato. As quatro notas foram lidas integralmente: contrato B8–110, R2 B117–189, R1 B196–399 e agenda B406–901. O script de checks foi lido por inteiro; seu JSON foi analisado e reproduzido byte a byte em diretório temporário.

O manuscrito original havia sido lido integralmente para o contrato. Nesta auditoria houve releitura crítica de B.4 (M1532–1608), B.8 (M1831–1964), E.3 (M2362–2517), benchmarks públicos (M2658–2724), renda unânime (M2726–2768), efeito total de agenda (M2877–2921), contraste diagonal e representação (M2923–3038) e consumidores de interação/escopo (M3040–3117), além das primitivas e definições utilizadas na reconstrução. Essa cobertura não constitui parecer integral sobre a literatura, evidência empírica, qualidade de apresentação, PDF ou códigos das figuras.

## 2. Contrato reconstruído e cobertura de histórias

O jogo é finito, de barganha com informação privada unilateral, seguido retrospectivamente pela análise de um estágio de sinalização. Não há compromisso com uma política de informação do tipo Bayesian persuasion. A ordem de dependência é R2 → R1 → A, separadamente por regra. Valores de R2 são nativos de R2; o consumidor R1 aplica um β. Valores nativos de R1 recebem outro β apenas quando entram em A.

| Etapa/estado | Ação e informação relevante | Transição/payoff auditado |
|---|---|---|
| Reconhecimento baseline | Sorteio uniforme dos fracos, independente entre rodadas; só H conhece o tipo | Proponente fraco observa a crença pública, não o tipo |
| Proposta baseline | Proponente escolhe (C,x), pertence a C; tamanho mínimo q; x≥0, soma≤1, zero fora de C | A escolha desinformada de C e x não sinaliza o tipo |
| Votação | Votos simultâneos dos convidados respondedores; proponente Y; não convidado tem marcador ⊥ | Todos os convidados precisam consentir, inclusive em C superdimensionada |
| Aprovação com H em C | O voto de H necessariamente foi Y | Cada membro recebe x; H recebe x_H |
| Aprovação sem H | H não vota e x_H=0 por factibilidade | H recebe o fora da pie; fracos recebem o pacote aprovado |
| Recusa em R1 | Qualquer veto inviabiliza o pacote inteiro | R2 na próxima data; não há saída imediata de H |
| Recusa em R2 | Fim do jogo | H recebe o, fracos zero |
| Agenda A | H propõe obrigatoriamente, pertence a C, e não vota novamente; sinal observado é (C,x) | Passagem implementa o pacote; recusa leva à seleção completa de R1 no mesmo posterior |

A não acumulação vale por casos na nova forma extensiva. O ramo “H convidado vota N e o pacote passa” é inviável; se H está fora, não há parcela positiva a ele. Isso é a mudança substantiva aprovada em 19/9, não uma prova de que o protocolo majoritário histórico eliminava o ramo contestado. Propostas desviantes, vetos desviantes e desvios compostos têm payoffs definidos. Nenhum argumento depende de execução individual de H para receber a parcela.

No baseline, o estado de cálculo inclui etapa, regra, crença atual e suporte inicial. O assessment completo retém histórias e liberdades locais de crença. Ações dos fracos não atualizam; com H convidado, Bayes usa sua lei prescrita de voto. Denominadores zero preservam o suporte inicial e a liberdade local à votação e ao voto de H. Votações distintas não compartilham automaticamente os mesmos valores livres. Não se substituiu essa disciplina por equilíbrio sequencial.

Na agenda, o seletor anônimo por regra/etapa/posterior é uma restrição declarada sobre as continuações consumidas. Não é uma classificação de todas as seleções possíveis do baseline. QI-01 foi mantida na interpretação estreita: os endpoints explícitos de R1_U são jogos de continuação com prior de entrada degenerado, importados como assessments determinados; um posterior zero dentro de um baseline iniciado com prior interior não apaga seu suporte inicial. Escolher as crenças livres do assessment endpoint dentro desse suporte maior é admissível; afirmar que todas as continuações nesse histórico colapsam ao endpoint seria extrapolação.

## 3. Ledger dos 17 claims

“Verificado” abaixo significa argumento matemático reconstruído sob o contrato declarado. “Reparo exigido” identifica uma deficiência dos bytes-fonte, ainda que o resultado tenha sido recuperado nesta revisão.

| Claim | Localizador | Resultado da auditoria e fundamento |
|---|---|---|
| C02 | B14–43 | Verificado como conjunto de primitivas: um informado, pie fixa, outside option independente, fracos simétricos, domínio estrito de tipos e desconto |
| N01 | B14–43,73–84 | Verificado em todas as histórias factíveis por consentimento integral e zero fora de C; nova factibilidade não equivale ao ballot histórico |
| N02 | B45–110,203–216,320–381 | Verificado sob a distinção entre crença atual/suporte inicial e a seleção endpoint explicitamente declarada |
| C06 | B123–189 | R2 reconstruída de primitives; limiares, empate, coalizões ótimas e coordenadas de tipo zero conferidos |
| C07 | B203–281 | Redução R1_M E/S/P demonstrada com dominância estrita, redução pré-votação e todos os empates; enumeração finita independente compatível |
| N03 | B283–318,468–500,811–815 | Representante completo anônimo e Borel construível; conserva peso λ comum e o novo sorteio R2 após recusa de S |
| C08 | B320–381; M1532–1608 | B.4 efetivamente auditada; completude dos ballots e célula vazia sustentadas no conceito mantido |
| C05 | B383–399 | Vetores econômicos e benchmark público baseline preservados; não se transportam automaticamente estratégias ou leis majoritárias |
| N04 | B423–500 | Espaço disjunto Y_g, posterior do par observado e seleção completa verificados; C não pode ser projetado antes de Bayes |
| N05 | B502–597 | Limiar de voto, piso, garantia segura e minimalidade quase certa da passagem demonstrados para toda a interface declarada |
| C12 | B598–624 | Fórmulas públicas verificadas, mas a igualdade usada em sua prova é falsa: F-001 exige reparo |
| N06 | B626–705 | Seis formas puras, existência para algum ρ e critério Borel A14 verificados; QI-05 adjudicada em F-003 |
| N07 | B707–763 | Ambos os contraexemplos de equivalência e a testemunha de reversão conferidos, inclusive desvios e mesma fibra |
| N08 | B320–326,765–773; M1831–1964,2362–2517 | Isomorfismo U verificado; transporte completo ainda consome lacuna de B.8, F-002. Resultado reconstruído com lema adicional |
| N09 | B775–847 | Kernels, leis, órbitas finitas e fatoração Borel verificados sob os seletores completos declarados; não codificam planos off-path |
| C15 | B591–595,849–869 | Limite suficiente βh<e/m verificado diretamente; só compara células em que ambas as fontes existem |
| C17 | B849–901 | Identidades e datas verificadas; a imagem U completa depende do reparo F-002 e a precisão endpoint de F-003; a fonte M é a nova correspondência |

## 4. R2 e R1: reconstrução dos incentivos

### 4.1 Rodada terminal

Em R2, um fraco convidado recebe zero com recusa terminal. Logo aceita toda parcela não negativa por T^Y, inclusive zero. Se H foi convidado, seu limiar é x_H≥o. Sob maioria uma coalizão só de fracos é factível porque q_M≤m. A proposta x=e_i entrega ao proponente 1, o máximo factível; qualquer doação positiva ou pagamento a H reduz esse máximo. Todas as coalizões só de fracos contendo i e com tamanho permitido continuam possíveis, inclusive maiores que a quota. Antes do reconhecimento cada fraco recebe 1/m, e H recebe (ℓ,h).

Sob unanimidade C=N. Não há vantagem em pagar fracos ou reter slack. As duas propostas relevantes pagam ℓ ou h a H; o proponente compara (1−μ)(1−ℓ) com 1−h. O cruzamento é p*=(h−ℓ)/(1−ℓ). No empate, a oferta baixa reduz estritamente o payoff esperado de H, conforme o desempate secundário. A oferta baixa vale no endpoint zero e no cutoff; a alta vale acima. A coordenada contrafactual do alto continua h após recusa da oferta baixa. Nenhum β pertence a esse cálculo terminal.

### 4.2 Maioria na primeira rodada

Escreva w=β/m. Todo fraco convidado compara sua parcela com w, independentemente do posterior ou do voto de H. Se todos os fracos convidados têm voto prescrito Y, H aceita iff x_H≥βo. Se um fraco tem veto prescrito, as duas ações de H dão βo e T^Y seleciona Y. Essa condição usa a estratégia simultânea prescrita, não a observação antecipada de um voto ainda não revelado.

O fracasso certo dá w ao proponente. A exclusão E dá 1−kw, maior por 1−β(k+1)/m>0. Uma proposta com probabilidade positiva de aprovação paga no mínimo w a cada convidado fraco. Se a coalizão excede a quota, remover um desses convidados, preservando H quando presente, e transferir sua parcela ao proponente preserva todas as aceitações e continuações e aumenta estritamente o retorno. É uma nova proposta antes da votação.

Na coalizão mínima, reduzir as parcelas aos limiares e eliminar slack produz E, S ou P. A comparação é

\[
\Pi_E=1-kw,\qquad
\Pi_S=(1-\mu)[1-(k-1)w-\beta\ell]+\mu w,\qquad
\Pi_P=1-(k-1)w-\beta h.
\]

Se S ou P vence E, seu residual é positivo; não se seleciona uma proposta algebricamente vantajosa mas inviável. Os cruzamentos e casos ℓ=1/m ou h=1/m foram conferidos. S vence o desempate com E e P. No empate residual E/P, a comparação secundária usa (1−μ)ℓ+μh contra βh; quando também há igualdade, as coordenadas, histórias e valores devem usar o mesmo λ. Não se podem combinar marginais independentes.

A construção anônima sorteia proponente e parceiros uniformemente. Após recusa do alto em S, novo reconhecimento independente produz o kernel R2. Isso dá exatamente os valores condicionais e interim de B302–310. As células de seleção são Borel e a mistura EP é afim em λ. Escolher a crença de entrada para cada posterior livre dá uma conclusão completa Borel em maioria, pois essas crenças não alteram seus valores de continuação.

### 4.3 Unanimidade: auditoria de B.4

Defina A=β(1−ℓ)/m e B=β(1−h)/m. A continuação pivotal de um fraco é W(η)=(1−η)A para η≤p* e B para η>p*, sempre em [B,A]. O mínimo de parcelas relevante é sobre os respondedores fracos, excluindo o proponente; essa definição está explícita em B332.

No endpoint baixo, a crença permanece zero e os limiares de H são βℓ e βh. Com veto fraco prescrito H vota Y por indiferença. Acima de p*, o perfil YY fixa η_Y=μ e o cutoff fraco B. Sem veto fraco, YY exige x_H≥βh. NN fixa η_N=μ e exige x_H<βh, todos os fracos Y e W(η_Y)≤u no ramo livre de Y. Com veto fraco, um N prescrito de H não sobrevive a T^Y. Os perfis separadores contradizem os incentivos: em YN o baixo precisaria receber ao menos βh para não imitar N, enquanto o alto só rejeita abaixo de βh; em NY o alto precisa βh e o baixo não pode preferir a continuação βℓ.

Para 0<μ≤p*, a proposta desviada s† paga βℓ a H e A a cada fraco respondedor. É factível, com residual A+1−β. Todos os fracos votam Y sob qualquer crença admissível. YY permite desvio lucrativo do alto; NN viola T^Y do baixo; YN permite ao baixo imitar a recusa reveladora do alto; NY permite ao alto recusar. Logo não existe conclusão em votos puros após essa proposta factível, e a célula inteira da correspondência é vazia. Isso não afirma inexistência em estratégias mistas ou em outro conceito.

Nas células existentes, a proposta limiar deixa ao proponente sua continuação acrescida de 1−β, vencendo o atraso. Conferi os vetores por tipo, inclusive a coordenada fraca zero quando um alto contrafactual recusa as ofertas baixas de R1 e R2 no endpoint baixo. Essa coordenada não pode ser substituída pela média sob o prior degenerado.

## 5. Agenda: desvios, medidas e comparações

Y_g é uma união disjunta finita de simplexes compactos identificados por C. As bolas locais usadas por Bayes pertencem à mesma componente C. O espaço é compacto e standard Borel; estender as medidas por zero ao ambiente euclidiano de cada componente permite a identidade de Bayes por diferenciação de medidas. Para priors interiores,

\[
\int_E\mu\,d\bar\sigma=p\,\sigma_h(E)
\]

para todo conjunto Borel E. A disciplina mais forte exige adicionalmente o limite local em cada ponto do suporte, inclusive pontos sem átomo. Não se presumiu que toda lei Borel satisfaz essa exigência: a correspondência filtra as leis admissíveis.

Sob a seleção completa declarada, o voto pivotal compara x_j com r_χ(μ)=βc_χ(μ). Como r>0, numa proposta aprovada C é recuperável das parcelas positivas dos fracos. Essa recuperação não vale para propostas rejeitadas. A posterior fixado, a passagem mais barata compra k convidados ao preço r; isso fornece uma fronteira de payoff, não resolve por si só o problema de sinalização.

O piso w(1−w)≤r≤w segue de E/P e da identidade

\[
mc_S-(1-w)=(\Pi_S-\Pi_E)+\mu(\beta-kw)\ge0
\]

na região em que S é selecionado. P só é selecionado com h≤1/m; EP preserva os limites. Uma proposta que paga w a k fracos passa sob qualquer posterior e garante 1−kw. Uma passagem com k+1 fracos deixa no máximo 1−(k+1)w(1−w), estritamente menor que a garantia: a diferença é w[1−(k+1)w]>0. Assim, passagens usadas têm coalizão mínima quase certamente. Não se eliminam coalizões maiores do espaço de desvios ou de recusas, nem se exige optimalidade em cada ponto de massa zero do suporte. Recusa também garante ao menos β²o. Esses argumentos fecham A-C1–A-C4.

A-C5 tem as fórmulas corretas, mas contém a igualdade falsa F-001. Com seu reparo, os três ramos do gap público são −β(e/m)(1−βo), β(βo−e/m) e (1−β)(1−βo), com e=m−k, nos respectivos domínios. Nenhuma fórmula autoriza bijeção entre pacotes rejeitados antigos e novos.

Para um perfil puro de A, há no máximo dois sinais. Fora desse conjunto finito, o payoff de passagem máximo pode ser aproximado reduzindo x_H por ε, mantendo os pagamentos e evitando os átomos; sinais rejeitados também continuam disponíveis. Portanto o supremo fora do suporte é O_o=max{A_off,d_o,off}, mesmo se seu maximizador estiver no suporte. Imitação bilateral e factibilidade produzem exatamente as seis linhas de A-C6. A forma “baixo rejeita, alto passa” é impossível porque d_h,0>d_ℓ,0. Há sinais distintos para separação com passagem porque k<m e há várias coalizões mínimas. A prova de existência por T=(1−kw)/β cobre h≤T, ℓ≤T≤h e T≤ℓ; mantém empates e demonstra existência para algum ρ, não para todo ρ.

A-C7 é o critério correto de melhor resposta: desigualdade para todo ponto no suporte, igualdade σ_o-quase certamente e proteção contra o supremo fora dele. Os payoffs são Borel por composição de μ, χ, indicadores de componente e comparações de parcelas. As condições são necessárias e suficientes dadas a seleção completa admissível e as crenças. QI-05 não exige igualdade em pontos-limite com massa zero; F-003 demonstra por que tal fortalecimento seria falso.

Os dois exemplos de não equivalência foram conferidos com os números exatos e com desvios. A-EX1 separa apenas por C: o mesmo x passa na coalizão mínima do baixo e falha numa coalizão do alto com convidado adicional de parcela zero. A-EX2 tem uma pequena parcela positiva a um fraco dispensável na votação histórica; a nova factibilidade o obriga a entrar em C, onde sua recusa bloqueia o pacote. O primeiro exemplo não prova que seu vetor de payoffs era impossível no jogo antigo; o segundo prova a falta de uma preimagem que preserve aquele pacote aprovado.

A testemunha de reversão usa a mesma fibra ρ=0. Em (m,β,ℓ,h,p)=(4,.9,.1,.9,.95), os valores privados são (.5905,.81) em M e (.729,.729) em U. Para o baixo, Δv=−.4095, ΔV=.1385 e ΔIR=.548. Todos os desvios de imitação e fora do suporte foram comparados; esse par é testemunha, não seleção universal.

## 6. Dependência histórica U: resultado reconstruído e lacuna localizada

O isomorfismo de A-C8 é válido para a árvore inteira U: a quota força C=N, de modo que adicionar ou retirar esse rótulo preserva ações, informação, votação, fracasso, datas, payoffs e topologia de propostas. O antigo ramo de aprovação com N de H não existia sob U. Esse argumento não prova B.8; por isso a prova foi examinada separadamente.

Ponha z_L=1−β+β²ℓ, z_H=1−β+β²h, d=β²h e P_C={0}∪(p*,1]. A identidade de Bayes implica que σ_h atribui massa zero ao conjunto {μ=0}. O alto garante d com uma recusa. Quase toda proposta usada pelo alto tem posterior alto; o baixo pode imitá-la e obter o mesmo payoff, portanto V_ℓ≥V_h≥d. Uma proposta usada pelo baixo com posterior zero não pode ser rejeitada, porque pagaria β²ℓ<d; se passa, o alto pode imitá-la. Nas propostas de posterior alto os payoffs dos tipos coincidem. Logo V_h≥V_ℓ e existe valor comum V≥d. A proposta x^ℓ passa sob todos os posteriores admissíveis e garante z_L; assim V≥max{z_L,d}. O limite superior V≤z_H é global, pois toda passagem paga no mínimo r_U(h) a cada fraco, e toda recusa dá no máximo d<z_H.

Se existe massa pública positiva em {μ=0}, o valor comum só pode ser z_L e o pacote usado nesse conjunto é o único maximizador x^ℓ. Exige-se z_L≥d e há átomo positivo do baixo em x^ℓ, sem átomo alto. A testemunha (x^ℓ,x^S) é factível e satisfaz imitação e desvios quando μ_off=0.

Se não existe essa massa, Bayes plausibility exige p>p*. Com μ_off=0, cada V em [max{z_L,d},z_H] é atingido pelo pooling x(V)=(V,(1−V)/m,…). O critério ponto a ponto de E.3 fecha todas as demais leis Borel, não apenas as testemunhas puras.

Falta no original justificar o caso μ_off>p* quando x^h pode pertencer ao suporte. O lema em F-002 fecha esse caso sem mudar o resultado: força V=z_H e, portanto, ambas as leis δ_xh. A mesma conclusão exclui μ_off alto na família de massa positiva em posterior zero. A classificação, seus endpoints e as traduções econômicas ficam matematicamente sustentados com esse complemento. A fonte congelada ainda não o contém.

Os endpoints são correspondências de estratégias completas. Em p=0 o baixo escolhe x^ℓ; o alto contrafactual recebe max{z_L,d}, podendo usar leis de recusas quando d domina. Em p=1 ambos escolhem x^h. A precisão de probabilidade um em F-003 é necessária quando o conjunto de recusas é aberto.

Os sinais de IR_U seguem de subtrair (z_L,z_H): baixo fracamente não negativo e alto fracamente não positivo, com as coordenadas endpoint indicadas na tabela original. T_U compara fontes existentes na mesma data: no interior de prior baixo a fonte baseline é vazia, mesmo quando A existe; no prior alto seus valores variam entre 0 e 1−β por tipo. Identidades I,T,D,Q não restauram células ausentes.

## 7. Findings

### F-001 — Igualdade algébrica falsa na prova do benchmark público

- **Tipo/severidade:** erro algébrico local; **LOW**. **Estado:** CONFIRMED. **Claim:** C12; consumidor C17.
- **Local:** `agenda_transport.md:210–217`; B615–622.
- **Citação literal:**

\[
1-k\beta(1-\beta o)/m-\beta^2o
=(1-\beta^2o)(1-k\beta/m)>0.
\]

O lado esquerdo menos o produto alegado é kβ²o(1−β)/m>0, no domínio inteiro. Com m=4, β=.9, o=.1, os lados são .5095 e .50545. A igualdade é falsa, embora a desigualdade e a fórmula de v_M^A sejam verdadeiras.

**Reparo proposto:** substituir pela identidade

\[
1-k\beta/m-\beta^2o(1-k/m)>1-\beta>0.
\]

A primeira desigualdade usa β²o<β. Isso prova a dominância de passagem no primeiro ramo sem modificar nenhum resultado. O script candidato de 409 checks não testa a igualdade falsa. O candidato deve corrigir a prova antes de declarar seu fechamento.

### F-002 — O argumento “off-support x^h” omite o caso de ponto no suporte sem massa

- **Tipo/severidade:** lacuna de prova sobre medidas Borel; **MEDIUM**. **Estado:** CONFIRMED. **Claims:** N08 e a classificação completa U consumida por C17; não refuta o isomorfismo estrutural.
- **Local:** M1889–1893 e M1938–1943; consumidos por B765–773.
- **Citação literal principal:**

> If \(\mu^{\mathrm{off}}>p^*\), the off-support proposal \(x^h\) guarantees
> \(z_H\).

A hipótese não estabelece x^h∉supp(σ̄). Se ele estiver no suporte, mesmo sem átomo, sua crença é o limite local de Bayes, e não μ_off. A passagem paralela em M1889–1891 tem a mesma lacuna. Ela afeta a exclusão de famílias adicionais, não apenas uma witness escolhida.

**Reparo proposto e verificado matematicamente:** acrescente o seguinte lema, usando o valor comum e os limites já demonstrados na seção 6.

Suponha μ_off>p* e V<z_H. Se x^h está fora do suporte, passa a preço alto e contradiz V. Se está no suporte, tome bolas relativas B_ε(x^h) pequenas o bastante para que x_H>V em toda a bola. Cada bola tem massa pública positiva. Dentro dela, o conjunto {μ=0} tem massa pública zero: o alto não usa posterior zero quase certamente; uma proposta usada pelo baixo nesse posterior, se aceita, daria x_H>V, e, se rejeitada, daria β²ℓ<d≤V. Ambos violam igualdade ao valor em sua lei. Portanto μ>p* quase certamente em cada bola.

Por Bayes,

\[
\frac{p\,\sigma_h(B_\epsilon(x^h))}
     {\bar\sigma(B_\epsilon(x^h))}
=
\frac{\int_{B_\epsilon(x^h)}\mu\,d\bar\sigma}
     {\bar\sigma(B_\epsilon(x^h))}
\ge p^*.
\]

O limite existe por disciplina e pertence a {0}∪(p*,1]. Como p*>0, não pode ser zero; como p* é excluído, μ(x^h)>p*. Logo x^h passa e rende z_H>V, novamente uma contradição. Conclui-se V=z_H. Como d<z_H e x^h é a única passagem que deixa z_H a H, ambas as leis são δ_xh. O mesmo lema impede μ_off alto quando a família de posterior zero tem V=z_L<z_H.

O reparo não acrescenta refinamento nem restringe as leis admissíveis: usa a disciplina pointwise e a igualdade quase certa já exigidas. Nenhum contraexemplo ao resultado foi encontrado. A prova congelada deve incorporar o caso antes de seu transporte ser certificado.

### F-003 — QI-05: “suportada no argmax” deve significar probabilidade um

- **Tipo/severidade:** precisão de exposição com consequência matemática se lida topologicamente; **LOW**. **Estado:** CONFIRMED quanto à ambiguidade; a leitura topológica forte é refutada.
- **Local:** `agenda_transport.md:300`, B705; dependência histórica M2480–2487.
- **Citação literal:** “cada σ_o pode ser qualquer medida suportada no argmax de u_o no novo Y_M”.
- **Citação histórica:** “any Borel law supported on”.

O critério correto é σ_o(argmax u_o)=1. Não exige supp(σ_o)⊂argmax u_o quando o payoff é descontínuo.

**Contraexemplo à leitura forte:** use m=4, k=2, β=.9, ℓ=.1, h=.9, p=1. A continuação M é E, r=.225, melhor passagem .55 e recusa do alto .81. Em C={H,1,2}, ponha ε_n=.1/(n+1) e

\[
x_n=(.55,.225-\epsilon_n,.225,0,0),\qquad n\ge1.
\]

Cada pacote é rejeitado e dá .81 ao alto. A lei \(\sigma_h=\sum_{n\ge1}2^{-n}\delta_{(C,x_n)}\) dá probabilidade um a melhores respostas. Seu suporte contém também o limite \(\bar x=(.55,.225,.225,0,0)\), que passa e dá apenas .55. A crença endpoint é 1 em toda parte. O baixo contrafactual pode escolher δ_(C,xbar), sua melhor resposta. Portanto a lei é admissível, embora o ponto-limite de massa zero não seja maximizador do alto.

Em E.3 ocorre o mesmo fenômeno: para esses parâmetros z_L=.181<d=.729 e r_U(ℓ)=.20475. Leis de recusas com x_H=.181 e uma parcela r_U(ℓ)−ε_n convergem a x^ℓ, que passa e não maximiza para o alto. O conjunto aberto R_L recebe probabilidade um, mas não contém o suporte inteiro.

**Adjudicação de QI-05:** sob a intenção expressamente confirmada no contrato, trata-se de precisão expositiva, não de mudança de conceito ou teorema. A14 já impõe a condição correta e só requer desigualdade no suporte. Recomenda-se “assigning probability one to its argmax” e a mesma precisão para R_L em E.3. Não se deve fortalecer A14 para impor igualdade em pontos sem massa.

## 8. Leis realizadas, assinaturas e consumidores

Os kernels majoritários novos retêm C, o marcador ⊥, reconhecimentos, vetores de votos e o caminho R2 quando presente. Suas misturas são finitas e Borel, com λ comum. Em U, o rótulo constante é transportado pelo isomorfismo. A construção Γ conserva o par (C,x), posterior, passagem, rótulo de seleção e lei terminal; o desconto entra na extração do payoff, não como uma segunda alteração da lei.

O grupo finito de permutações dos fracos age por homeomorfismos no espaço compacto ambiente e induz uma ação Borel nas leis. A medida uniforme da órbita é invariante completo: órbitas diferentes são disjuntas e a igualdade dessas medidas força que cada ponto de uma pertença à outra. Uma seleção Borel de representante em órbitas finitas permite fatorar funções Borel invariantes. A ação sobre o par de leis por tipo é diagonal; nomes não podem ser permutados independentemente entre tipos. A construção econômica igualmente quocienta registros pelas mesmas permutações.

A conclusão se limita às leis realizadas. Planos fora do caminho permanecem no binder; igualdade de c/h não implica igualdade de Γ ou de assinatura. Um par M/U mantém suas próprias fontes completas e a fibra comum especificada; não há licença para recombinar marginais ou criar sorteio comum entre regras.

O limite de comparação usa somente V_M≥1−kβ/m e V_U≤1−β+β²h. Assim,

\[
V_U-V_M\le-\beta(e/m-\beta h),
\]

estritamente negativo para βh<e/m, para ambos os tipos e ex ante, quando ambas as fontes existem. O bound não depende da parte incompleta da classificação B.8 nem de equivalência majoritária. As identidades T=D+I e suas diferenças decorrem de subtrações nas datas corretas; suas imagens devem ser geradas pela nova fonte majoritária.

## 9. Verificações executadas e limites

| Check | Execução e resultado | Alcance real |
|---|---|---|
| Identidade de fontes | SHA-256 confrontados com manifesto, bundle, contrato e original | Vincula o parecer aos bytes indicados; não certifica versão futura |
| DAG | `check_game_dag.py derivations/game_dag.json --require-execution-order`: VALID | Grafo R2→R1→A, hashes e ordem registrada coerentes |
| Checks do candidato | Cópia temporária do script exato: 409 PASS, 0 FAIL; JSON byte-idêntico | Aritmética finita, dois exemplos, witness; não cobre todas as leis Borel ou a igualdade F-001 |
| Enumeração independente | `reviews/formal_checks_v1.py`: 50 estados, 100 asserções, 3.054.975 comparações, 0 falhas | R1_M em grid racional D=20, β=3/5, m=3 e 4 |
| Reconstrução analítica | Desvios, tie-breaks, endpoints, Bayes, suportes, composição e órbitas | Base principal do parecer; não é certificação por prover formal |
| Folha fria R2 | Leitura integral da derivação independente anterior às interfaces | Evidência de reconstrução sem resposta candidata; seus checks próprios não foram apresentados como execução deste revisor |

A enumeração independente percorre **todas** as coalizões nomeadas e alocações não negativas do grid com soma≤1 e zero fora de C, incluindo slack e coalizões maiores. São 15.939 propostas para m=3 e 106.260 para m=4. Em cada m, cinco pares de tipos cobrem h<1/m, ℓ<1/m<h, 1/m<ℓ, ℓ=1/m e h=1/m. Os priors incluem endpoints, 1/2, cruzamentos exatos, vizinhanças racionais dos cruzamentos e o empate secundário E/P quando interior. O script compara valor e conjunto inteiro de maximizadores, com o desempate esperado sobre H. Isso corrobora o argumento contínuo; não prova a redução em todos os parâmetros, não enumera medidas, e não testa R1_U.

O script e o JSON dessa enumeração são artefatos de revisão separados do candidato. Seus hashes finais constam no JSON deste parecer. Nenhum cálculo foi colocado no manuscrito ou nas notas. Os eventos do DAG foram conferidos como registro persistente; não foram auditados contra o log bruto do orquestrador, portanto o check não prova por si só a execução histórica narrada.

Não foram executados Lean, testes dos códigos das figuras, render do manuscrito, revisão visual, busca bibliográfica ou validação empírica. Álgebra, limiares e desigualdades finitas são candidatos naturais à formalização Lean; a parte de medidas e órbitas exigiria infraestrutura adicional. Não há alegação de formalização já realizada.

## 10. Disposição e invalidação

O candidato v1 permanece **FAIL quanto ao fechamento formal de suas provas** até corrigir F-001 e acrescentar a cobertura Borel de F-002. F-003 deve ser precisado no texto para refletir o contrato e evitar a restrição falsa de suporte. Não foi identificado motivo para alterar as primitivas aprovadas, os 17 enunciados sob sua interpretação delimitada, os valores das tabelas ou a testemunha de reversão.

O reparo F-001 reabre o trecho de A-C5 e seus consumidores públicos. F-002 reabre o fechamento de A_U e da classificação histórica transportada, seus conjuntos de existência e imagens econômicas; não invalida a folha R2, R1_U, o isomorfismo estrutural ou o bound global U. F-003 requer conferir endpoints de A-C7/E.3 e a consistência da linguagem sobre suporte. Qualquer nova hash é um novo candidato; uma revisão dos reparos deve preservar a cobertura original e declarar seu próprio alcance.

Mudanças futuras em factibilidade, observação de C, consentimento, suporte original, seletor, kernel ou datas reabrem seus descendentes no DAG. Uma alteração de kernel com os mesmos valores pode reabrir leis e assinaturas mesmo quando os cálculos econômicos ficam iguais. Este parecer não autoriza migração canônica, publicação ou submissão e não se estende automaticamente a previews, patches ou notas v2.
