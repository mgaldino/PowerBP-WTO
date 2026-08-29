# Consulta técnica externa não formal — leitura do Fable: anonimidade, Reynolds e assinatura de A_M

**Data:** 29 de agosto de 2026
**Leitor:** Fable (Claude), na condição de leitor técnico externo.
**Objeto:** pacote
`reports/chatgpt_pro_packets/2026-08-29_A_M_anonimato_reynolds_consulta_decisao.md`
do worktree `agenda-extension-am-msb`.

## 1. Natureza e limite da consulta

Este documento é uma **consulta técnica externa não formal**. Não é parecer
formal do projeto, não abre nem fecha gate, não concede `PASS`, aprovação ou
congelamento, não substitui os dois pareceres formais já realizados e não
autoriza implementação, tag, merge ou consumo downstream. O Fable permanece
inelegível como parecerista formal desta cadeia. Tudo abaixo é insumo técnico
para uma decisão autoral posterior, e mesmo concordância integral entre os
leitores externos não altera o estado `BLOCKED`.

Tomo como dados os doze fatos formais listados no pacote, o veredito
adjudicado dos dois pareceres e o contraexemplo `x^P/x^Q` como diagnóstico
estabelecido. Não rederivo existência, classificação pura, `T4`, `C_M` nem a
arquitetura de crenças.

## 2. Resposta curta ao autor

A pergunta decide o que conta como "o mesmo equilíbrio" quando só os nomes dos
Estados fracos mudam. Duas noções estavam fundidas num objeto só: identidade
**formal** (existe uma única troca de nomes que transforma um perfil no outro)
e identidade **econômica** (mesmos payoffs, mesma revelação, mesmas
probabilidades, lidos anonimamente). O Reynolds componentwise tentou cumprir as
duas funções e não pode cumprir: ele é invariante, mas apaga a relação entre os
planos contrafactuais dos dois tipos — identifica órbitas distintas (`P/Q`) — e
produz um objeto que, em geral, nenhum assessment único realiza, porque
registra posteriores contraditórios no mesmo sinal.

O conflito não é um defeito reparável do Reynolds em particular. Provo na
Seção 6 que **qualquer** relação de equivalência que identifique um perfil com
seus baricentros de pesos comuns identifica `x^P` com `x^Q`, por transitividade
através do baricentro uniforme compartilhado. Ou seja: "quociente exato pela
mesma permutação" e "colapsar misturas sobre identidades" são exigências
incompatíveis sobre o mesmo objeto, em qualquer definição. Não existe solução
de uma camada.

A consequência positiva: a arquitetura em duas camadas (Alternativa D) deixa
de ser uma conveniência e passa a ser a única estrutura que cumpre o que é
cumprível. A camada exata deve ser exatamente a órbita diagonal da Alternativa
A — a lei de órbita `Λ_x` é um invariante completo, com prova curta — e o
resumo econômico fica na camada 2, onde o Reynolds é legítimo como estatística
declaradamente muitos-para-um.

Duas precisões são necessárias no texto aprovado. Primeira: a frase "misturas
sobre identidades pertencem à mesma classe" deve ser reescrita — como
identificação formal, é insatisfazível; e mesmo como resumo, só é verdadeira
quando a mistura não altera a revelação. Uma mistura dos dois tipos com
suportes sobrepostos muda os posteriores de Bayes e vira outro experimento; o
resumo correto a distingue. A fronteira certa é automática: perfis com as
mesmas marginais anônimas por tipo — payoffs, timing, **lei do posterior** e
outcome anônimo — têm o mesmo resumo; os demais, não. Segunda: o representante
de uma classe para exposição deve ser um membro real da órbita, nunca a média
de Reynolds, que pode não ser realizável por assessment algum.

Nada disso toca `rho`, `nu_off`, a existência ou a classificação pura: a ação
do grupo fixa essas coordenadas, e a ortogonalidade é verificável diretamente.
O reparo do finding menor da Seção 8.3 é local e está correto como proposto.

## 3. Reconstrução formal do problema

Sejam `m` Estados fracos e `G = S_m`. Assumo, como o pacote permite, que
`Z = Y × [0,1] × {0,1} × X_M × Ω_T` é um espaço de Borel padrão — `Y` é
compacto métrico, `[0,1]` e `{0,1}` são triviais, e `X_M` e `Ω_T` são
Borel-padrão por construção dos registros de membro e outcomes. Então
`P(Z)` com a topologia fraca é polonês, e `X := P(Z)^2` também.

`G` age sobre `Z` permutando as coordenadas que carregam identidade fraca
(pagamentos da proposta, rótulos de coalizão do outcome terminal) e fixando
`rho`, `nu_off`, o valor do posterior e o rótulo anônimo da continuação. A ação
é por homeomorfismos; o pushforward `g·Γ = g_#Γ` é contínuo em `P(Z)`; a ação
diagonal sobre pares é `g·x = (g_#Γ_0, g_#Γ_1)`.

O operador de Reynolds componentwise é

```text
R_cw(x) = ( |G|^{-1} Σ_g g_#Γ_0 , |G|^{-1} Σ_g g_#Γ_1 ).
```

**Invariância versus completude.** `R_cw` é `G`-invariante: `R_cw(g·x) =
R_cw(x)`. Invariância diz que a função é constante em cada órbita; completude
diria que ela separa órbitas distintas. São propriedades independentes, e o
contraexemplo adjudicado nega a segunda.

**Auditoria do contraexemplo (mandato, item 1).** `[PROVED]`, condicional aos
fatos dados. Com `N=5, m=4, k=2, beta=.9, o_0=.7, o_1=.8, nu=.5, rho=1`: o
ramo `E` é único porque `o_0 > 1/m`; `r = beta/m = .225`; `A = 1 − k·r = .55`;
`D_0 = .63`, `D_1 = .72`, independentes do posterior porque em `E` o hegemon
fica com a outside option. Cada `y_C = (.8, .1·1_C)` paga `.1 < .225` aos dois
fracos de `C` e é rejeitada pela regra as-if-pivotal; como `A < D_0 < D_1`,
qualquer proposta rejeitada é melhor resposta dos dois tipos, e as restrições
de imitação valem com igualdade. Os perfis separating-com-atraso `x^P` (paga
`{1,2}` / `{3,4}`) e `x^Q` (paga `{1,2}` / `{1,3}`) são então assessments
válidos. A cardinalidade da interseção contrafactual — `0` em `P`, `1` em `Q`
— é invariante sob permutação comum, logo as órbitas diagonais são distintas.
A média por tipo sobre `S_4` é uniforme sobre as seis coalizões de tamanho
dois nos dois perfis, e as demais coordenadas coincidem por tipo e são
equivariantes; logo `R_cw(x^P) = R_cw(x^Q)`. A formulação do pacote está
correta e o domínio (`X`, não marginais soltas) é o certo.

## 4. Os quatro desiderata

Resultado central: os desiderata 1–3 são simultaneamente realizáveis sobre
`X` pelo quociente de órbita diagonal; o desideratum 4, lido como
**identificação formal**, é incompatível com 2 (e, na leitura `cw`, também com
3); lido como **mesmo resumo econômico**, é realizável na camada 2, com uma
correção de escopo: ele vale exatamente para misturas que não alteram a
revelação.

| Desideratum | Órbita diagonal (camada 1) | Resumo anônimo (camada 2) |
|---|---|---|
| 1. anonimidade de rótulos | cumprido: relabelings puros colapsam | cumprido |
| 2. quociente diagonal exato | cumprido, com `Λ_x` como invariante completo | não prometido — o resumo é declaradamente muitos-para-um |
| 3. preservação da revelação | cumprido: a coordenada de posterior é fixada pela ação | cumprido, desde que o resumo inclua a lei do posterior por tipo |
| 4. colapso de misturas | não cumprido — e provadamente incumprível junto com 2 | cumprido na forma corrigida: mesmo resumo sse mesmas marginais anônimas por tipo |

A tabela antecipa a conclusão da Seção 6: nenhum objeto único cumpre 1–4; a
partição de trabalho entre camadas é forçada, não estilística.

## 5. Avaliação das alternativas A–D

| Critério | A — órbita/`Λ_x` | B — equivalência marginal grossa | C — acoplamento `Xi` | D — duas camadas |
|---|---|---|---|---|
| Completude da equivalência | exata `[PROVED]` | abandonada por construção | exata sobre objeto que o PBE não determina | exata na camada 1 (= A) |
| Preservação da revelação | sim | sim, somente se a lei do posterior por tipo integrar o resumo | sim | sim, nas duas camadas |
| Mensurabilidade | sim, no quadro polonês | sim | sim, mas o objeto é arbitrário | sim |
| Estratégias mistas | elementos distintos quando não relacionadas por permutação — correto | colapsa além do necessário | exige semente comum sem sentido estratégico | distintas na camada 1; mesmo resumo quando marginais anônimas coincidem |
| Ausência de recombinação | garantida: tudo deriva de um único `x` | risco médio: resumo por coordenadas convida à recombinação | risco | garantida, com a proibição explícita repetida nas duas camadas |
| Suficiência para `AC`/`AR` | trivial — transporta tudo, ao custo de peso | exige teorema e abre mão da fonte exata | n/a | exige teorema curto, mantendo a fonte exata como fallback |

**Recomendação: D, com a camada exata fixada como A.** Tentei refutar a
recomendação provisória do pacote pelos três caminhos disponíveis — tornar A
sozinha suficiente (falha: deixaria o desideratum 4 sem casa e o relato
econômico multiplicaria classes que `AC`/`AR` não distinguem), tornar B
sozinha suficiente (falha: sem a camada exata, a promessa do quociente
diagonal é abandonada e cada operação futura exige um teorema de suficiência
sem rede de segurança), e salvar uma camada única via acoplamento C (falha: o
PBE determina marginais por tipo; qualquer acoplamento contrafactual é
conteúdo sem interpretação estratégica, e a versão "semente comum" é um
dispositivo de correlação que o game form não contém — adotá-la seria mudança
de protocolo, desproporcional ao problema). A refutação não se sustenta em
nenhum dos três; D sobrevive.

## 6. Provas ou contraexemplos

### 6.1 `Λ_x` é invariante completo da órbita diagonal `[PROVED]`

Defina `Λ_x = |G|^{-1} Σ_{g∈G} δ_{g·x} ∈ P(X)`.

*Prova.* Se `x' = h·x`, então `Λ_{x'} = |G|^{-1} Σ_g δ_{gh·x} = Λ_x`, pela
invariância à translação direita da medida uniforme no grupo finito `G`.
Reciprocamente, `Λ_x({y}) = |{g : g·x = y}| / |G|`, que é `|Stab_G(x)|/|G| >
0` exatamente nos pontos da órbita; logo `supp(Λ_x) = G·x` como conjunto
finito. Se `Λ_x = Λ_{x'}`, os suportes coincidem e `x' ∈ G·x`. ∎

*Espaços mensuráveis necessários.* Basta que `X` seja polonês com a ação de
`G` por homeomorfismos — garantido se `Z` é Borel-padrão, como assumido — para
que `δ : X → P(X)` seja mergulho contínuo e injetivo, singletons sejam
mensuráveis e `x ↦ Λ_x` seja contínua. Para grupo finito, as órbitas são
finitas e fechadas e o quociente é Borel-padrão; uma seleção mensurável de
representantes existe (por exemplo, o mínimo lexicográfico sob um isomorfismo
de Borel fixado). A única hipótese a conferir contra os bytes é que `X_M` e
`Ω_T` sejam de fato Borel-padrão; se algum deles não for, `[UNRESOLVED]` até o
ajuste, que é de enquadramento e não de conteúdo.

### 6.2 Lema do colapso por baricentro `[PROVED]`

*Enunciado.* Seja `~` qualquer relação de equivalência sobre `X` tal que
`x ~ b` para todo `b ∈ Mix_G^com(x)`. Então `x^P ~ x^Q`.

*Prova.* O baricentro uniforme pertence ao conjunto de misturas:
`B_unif^com(x) = R_cw(x) ∈ Mix_G^com(x)`. Logo `x^P ~ R_cw(x^P)` e
`x^Q ~ R_cw(x^Q)`. Pelo contraexemplo adjudicado, `R_cw(x^P) = R_cw(x^Q)`.
Simetria e transitividade dão `x^P ~ x^Q`. ∎

*Corolários.* (i) A resposta à Questão 3 é **não** nos dois casos: não existe
equivalência sobre `X` que identifique `x` com todo `Mix_G^com(x)` sem
identificar `x^P` com `x^Q`; e como `Mix_G^cw ⊇ Mix_G^com` (tome
`q^0 = q^1`), o caso `cw` segue a fortiori. (ii) O defeito não é do Reynolds:
é do desideratum 4 lido como identificação sobre `X`. Nenhuma engenharia de
invariantes o contorna, porque a prova usa apenas álgebra de relações de
equivalência e a existência de um baricentro comum.

### 6.3 Não realizabilidade do par simetrizado `[PROVED]` — Questão 4

Em `R_cw(x^P)`, a lei condicional da coordenada de posterior dado o sinal
`y_C` é `δ_0` na componente do tipo 0 e `δ_1` na componente do tipo 1, para
toda coalizão `C`. Um assessment único possui **um** mapa público `pi(·)`: a
coordenada de posterior de `Γ_θ` é `pi(y)`, a mesma função de `y` para os dois
tipos. Como as duas componentes simetrizadas dão massa positiva a cada `y_C`
com valores contraditórios de posterior, nenhum `(sigma_0, sigma_1, pi)` gera o
par. Além disso, se ambos os tipos dessem massa ao mesmo átomo, Bayes forçaria
posterior interior, e não `0` e `1`.

*Consequências.* A não injetividade (6.2, via `P/Q`) desqualifica `R_cw` como
assinatura exata; a não realizabilidade desqualifica sua leitura como
"representante simétrico implementável" de uma classe. Nada impede seu uso
como **resumo** muitos-para-um — que é exatamente o lugar que a Alternativa D
lhe dá. Para relatar uma classe, o representante deve ser um membro real da
órbita (por exemplo, o de rotulagem lexicográfica mínima).

### 6.4 As três leituras de "mistura sobre a órbita" — Questão 1

**`L_q(x)` vive em `P(X)`**, não em `X`. Matematicamente, `L_q` uniforme é
`Λ_x`, o próprio invariante completo; `L_q` geral tem o mesmo suporte `G·x` e
pesos diferentes. Manter `L_q` no metaespaço **registra** a randomização — o
sorteio comum `g` fica como variável latente — mas **não identifica** objetos:
a identificação continua sendo o quociente de órbita dos pontos-base. E há um
ponto estratégico decisivo: o sorteio comum aos dois tipos é um dispositivo de
correlação entre mundos contrafactuais que o jogo não contém. `L_q` é
contabilidade legítima da classe; não é objeto de equilíbrio.
`[PROVED]` para a parte matemática; `[MODELING CHOICE]` para a recusa do
dispositivo de correlação.

**`Mix_G^com` vive em `X`.** Identificá-lo com `x` é incompatível com separar
`x^P` de `x^Q` (6.2). Adicionalmente, quando um baricentro comum é realizável
como assessment, ele em geral **muda a revelação**: com suportes dos tipos que
se sobrepõem após a mistura, Bayes atribui posteriores interiores pelos pesos
— o perfil separating vira pooling parcial de mensagens. No exemplo do
contraexemplo, a mistura uniforme dos dois tipos sobre as seis coalizões é um
PBE legítimo da região `E`, mas com `pi ≡ nu` em todo sinal alcançado: outro
experimento, outra lei de posterior, outro resumo. Colapsá-lo com o separating
violaria o desideratum 3 dentro da própria camada de resumo. `[PROVED]`.

**`Mix_G^cw` vive em `X`** e herda tudo do caso `com` (a fortiori, 6.2). Com
pesos próprios por tipo, o dano à revelação é direto: pesos distintos sobre os
mesmos sinais produzem posteriores interiores dados pela razão de
verossimilhança — identificaria separating com semipooling. `[PROVED]`.

*Síntese da Questão 1:* nenhuma das três leituras realiza os quatro desiderata
sobre `X`. `L_q` preserva 1–3 ao custo de morar no metaespaço e de postular
correlação contrafactual; `com` e `cw` sacrificam 2 e ameaçam 3. O desideratum
4 só tem casa como afirmação de resumo, e com escopo corrigido: **misturas que
não alteram as marginais anônimas por tipo — em particular, a lei do posterior
— têm o mesmo resumo; as demais são experimentos distintos e devem permanecer
distintas**. Exemplo positivo: tipo 0 misturando `{y_{12}, y_{13}}` com
qualquer peso, tipo 1 puro em `y_{34}`, suportes disjuntos na região `E` —
payoffs, timing e revelação idênticos aos do perfil puro; órbitas distintas na
camada 1; mesmo resumo na camada 2. É o caso que motivava a intuição original,
e a arquitetura D o trata exatamente como a intuição pedia.

### 6.5 Ortogonalidade a `rho` e às crenças `[PROVED]` — Questão 9

A ação de `G` fixa `rho`, `nu_off` e o valor do posterior; o quociente e o
resumo carregam `(rho, nu_off)` como coordenadas invariantes externas à
órbita. As provas 6.1–6.4 valem a `rho` fixado (o contraexemplo usa
`rho = 1`), e nenhuma cláusula da arquitetura de crenças menciona identidades
fracas. Não há implicação lógica em nenhuma direção; a arquitetura de crenças
não deve ser reaberta por este problema.

## 7. Definição recomendada

**Quadro.** `Z` Borel-padrão; `X = P(Z)^2` polonês; `G = S_m` agindo
diagonalmente como na Seção 3; `(rho, nu_off)` escalares `G`-invariantes.

**Camada 1 — correspondência formal exata.**

```text
x ≡_G x'  sse  existe g ∈ G com x' = g·x;
codificação canônica: Λ_x = |G|^{-1} Σ_g δ_{g·x} ∈ P(X);
assinatura exata: Sig_M^ex(R) = ( rho, nu_off, Λ_{x(R)} ).
```

Igualdade de `Sig_M^ex` identifica exatamente uma órbita diagonal (6.1).
Elementos são assessments reais; nenhum objeto médio entra na camada.
Representante expositivo: membro real da órbita por seleção mensurável fixada
(mínimo lexicográfico), com a órbita registrada.

**Camada 2 — resumo econômico anônimo.**

```text
s(x) = ( por tipo θ:  V_θ ;  lei de (pi, a, timing) sob Γ_θ ;
         lei simetrizada do outcome terminal anônimo, isto é,
         |G|^{-1} Σ_g g_#(marginal terminal de Γ_θ) ;
         payoffs fracos como multiconjunto/lei exchangeable );
Res_M(R) = ( rho, nu_off, s(x(R)) ).
```

`Res_M` é declaradamente muitos-para-um: `x^P` e `x^Q` têm o mesmo resumo, por
construção e por decisão — a relação entre coalizões contrafactuais de tipos
distintos não é consumida por `AC`/`AR` e não tem leitura política num estágio
único onde apenas um tipo se realiza. `[MODELING CHOICE]`, agora com o rótulo
correto de resumo e sem alegação de exatidão. O Reynolds por tipo aparece
somente dentro de `s`, como estatística.

**Regra de consumo.** `AC`/`AR` consomem `Res_M` somente mediante teorema de
suficiência por operação declarada (Seção 10); na ausência dele, consomem
`Sig_M^ex`. O produto fibrado em `(rho, nu_off)` precede qualquer resumo;
proibido combinar coordenadas de assessments distintos em qualquer camada.

## 8. Redação substitutiva

**(a) Decisão autoral de anonimidade** — substitui, na clarificação, o item de
misturas do §2 e absorve o §4:

> A equivalência formal exata de `A_M` identifica dois assessments se e
> somente se uma mesma permutação dos Estados fracos, aplicada ao perfil
> inteiro — propostas, votos, crenças, continuação e outcomes —, transforma um
> no outro. A codificação canônica é a lei de órbita `Λ_x`, invariante
> completo da ação diagonal. Misturas sobre identidades que não sejam
> relabelings de um mesmo perfil são elementos distintos da correspondência
> exata. A afirmação anterior sobre misturas passa a valer no nível do resumo
> econômico: perfis com as mesmas marginais anônimas por tipo — payoffs,
> timing, lei do posterior e outcome terminal anônimo — recebem o mesmo
> resumo, e o relato substantivo pode tratá-los como a mesma predição.
> O operador de Reynolds é admissível somente como estatística desse resumo:
> ele não é quociente exato (contraexemplo `P/Q`) nem, em geral, um objeto
> realizável por assessment (incoerência de posteriores). O representante
> expositivo de uma classe é um membro real da órbita, por seleção mensurável
> fixada, nunca a média.

**(b) Definição de assinatura de `A_M`:**

> `Sig_M^ex(R) = (rho, nu_off, Λ_{x(R)})` é a assinatura formal exata;
> `Res_M(R) = (rho, nu_off, s(x(R)))` é o resumo econômico anônimo, com `s`
> como na definição recomendada. A comparação institucional usa o produto
> fibrado no mesmo `(rho, nu_off)`; resumos são formados por fibra e nunca
> recombinam coordenadas de assessments distintos.

**(c) `AMX-016`, reenunciado em duas alíneas:**

> **AMX-016a (camada exata).** A correspondência de `A_M` sob M/S/B, a menos
> da órbita diagonal de `S_m`, com codificação `Λ` e transporte de
> `(rho, nu_off)` por fibra, é o objeto exato de consumo downstream.
> **AMX-016b (resumo e suficiência).** O resumo `Res_M` acompanha um teorema
> de suficiência por operação declarada de `AC`/`AR`; operações sem teorema
> consomem a camada exata.

**(d) `AMX-MSB-010`, parte afetada** — modelo de emenda, a ajustar pelo
implementador ao texto integral do claim, que o pacote não reproduz
(`[UNRESOLVED]` apenas quanto ao ponto exato de emenda, não quanto ao
conteúdo):

> A simetrização componentwise é `G`-invariante e permanece válida como
> estatística de resumo. Ela não é invariante completo da órbita diagonal
> (contraexemplo `P/Q`, adjudicado) e não é, em geral, realizável como
> assessment; a parte deste claim que a apresentava como quociente exato ou
> representante implementável é substituída pela arquitetura em duas camadas
> de AMX-016a/b.

## 9. Finding menor da Seção 8.3

O reparo proposto é local e correto; confirmo item a item. `[PROVED]`

1. Átomo com posterior interior: `pi(y) = nu·sigma_1({y}) / lambda({y})` em
   átomos; `0 < pi(y) < 1` força massa positiva dos dois tipos. Num átomo com
   `sigma_theta({y}) > 0`, a igualdade `u_theta(y) = V_theta` vale no ponto,
   porque um átomo de massa positiva não pode violar a igualdade
   quase-certa de `T4`.
2. Fora de átomos, apenas quase-certamente — é o máximo que leis atomless
   permitem, e `T4` já está escrito assim.
3. Setwise, para prior interior: em `{pi = 0}`, a identificação
   `pi = d(nu·sigma_1)/d(lambda)` (Besicovitch, já no pacote reparado) dá
   `nu·sigma_1({pi=0}) = ∫_{pi=0} pi · dlambda = 0`; simetricamente
   `sigma_0({pi=1}) = 0`. A forma setwise é a correta; a pointwise é falsa em
   geral.
4. A desigualdade de imitação vale ponto a ponto em todo o suporte pela
   primeira cláusula de `T4`, sem menção a uso positivo.
5. Nada disso altera `T4`/`AMX-015` ou `AMX-011`.

O slogan que evita a recaída: **pertencer ao suporte não significa ser usado
com probabilidade positiva**; toda frase auxiliar deve quantificar por átomo
ou quase-certamente.

## 10. Implicações downstream

- **Hoje:** `AC` e `AR` permanecem bloqueados; quando autorizados, consomem
  `Sig_M^ex` por fibra `(rho, nu_off)`.
- **Teorema de suficiência a escrever (curto):** para cada operação declarada
  — correspondência de payoffs por tipo, imagem ex ante, conjunto exato de
  comparações, afirmações de invariância, benchmarks de `AR` — exibir
  `O(x) = Õ(rho, nu_off, s(x))`. Para as operações hoje declaradas, os
  ingredientes são componentes literais de `s`; a prova deve ser rotineira,
  mas é obrigação de prova, não presunção. Enquanto não existir, a camada 1 é
  a interface.
- **Cláusula de reabertura:** se alguma operação futura consultar persistência
  de identidades entre estágios ou correlação contrafactual entre tipos —
  nada hoje declarado o faz —, essa operação não é `s`-mensurável e deve
  consumir a camada exata; a decisão B teria destruído essa possibilidade, a
  decisão D a preserva.
- **Testes adversariais do pacote:** sob a definição recomendada, os dez
  passam — relabeling puro colapsa (6.1); interseções distintas permanecem
  distintas na camada exata e coincidem, por decisão declarada, no resumo;
  pura versus uniforme-comum são distintas nas duas camadas quando a mistura
  altera a revelação, e distintas só na camada exata quando não altera;
  separating com mesma parcela preserva a diferença de posteriores nas duas
  camadas; pooling e separating nunca se confundem, porque a lei do posterior
  por tipo integra o resumo; pesos `(.9,.1)` e `(.5,.5)` com suportes
  disjuntos têm o mesmo resumo e órbitas distintas; o representante
  expositivo é sempre realizável, por ser membro; a construção é Borel em
  leis atomless; `rho` atravessa invariante; e a proibição de recombinação
  está repetida nas duas camadas.

## 11. Recomendação consultiva final

**Alternativa D, com a camada formal exata fixada como a órbita diagonal da
Alternativa A e codificada por `Λ_x`; o Reynolds rebaixado a estatística do
resumo; o desideratum de misturas reescrito como afirmação de resumo com o
escopo corrigido pela revelação; e o representante expositivo definido como
membro real da órbita.** Em símbolos: camada 1 `= (rho, nu_off, Λ_x)`; camada
2 `= (rho, nu_off, s(x))`; consumo downstream pela camada 2 somente sob
teorema de suficiência por operação.

Registro, na categoria exigida: a escolha de apagar no resumo a relação entre
coalizões contrafactuais dos dois tipos é `MODELING CHOICE` defensável — num
estágio único, apenas um tipo se realiza e nenhum consumidor declarado usa
essa relação —, e a incompatibilidade que força a arquitetura em duas camadas
é `PROVED` (Seção 6.2). A sequência institucional do pacote permanece
inalterada: decisão autoral explícita, novos bytes por implementador separado,
novo manifesto, duas novas revisões formais sobre os mesmos bytes, aprovação
autoral terminal e, somente então, eventual liberação para `AC`.
