# Parecer formal independente 2 — `A_M` sob M/S/B e assinatura em duas camadas

**Data:** 29 de agosto de 2026  
**Papel:** Parecerista formal independente 2  
**Tipo de jogo:** jogo bayesiano dinâmico de agenda e barganha sob maioria, com proposta do hegemon de tipo privado, votação simultânea dos Estados fracos, sinalização pela proposta e continuação majoritária após rejeição.  
**Conceito auditado:** PBE sob as cláusulas adicionais M/S/B, votação as-if-pivotal e desempate \(T^Y\).

## 1. Independência e método

A revisão foi conduzida a frio, estritamente em modo read-only. Não usei memórias, rollout summaries nem material do outro parecerista desta rodada; um arquivo de parecer não rastreado que apareceu no worktree durante a auditoria foi ignorado e não foi aberto.

A ordem de leitura respeitou a precedência determinada:

1. decisão autoral aprovada sobre a assinatura em duas camadas;
2. consultas externas Fable e ChatGPT apenas como insumos;
3. pareceres formais da rodada anterior e adjudicação, para identificar os defeitos que a implementação deveria reparar;
4. emenda M/S/B, clarificação de anonimato, decisões anteriores e contrato-base;
5. resultados, ledger, script e output, preflight, relatório de implementação e manifesto do candidato;
6. interfaces congeladas N3 e N1 necessárias à reconstrução.

Além da leitura semântica, refiz:

- identidade de branch, commits e ancestralidade;
- hashes SHA-256 normativos e do candidato;
- todas as entradas do manifesto;
- derivação do ballot, classificação pura e membership misto;
- provas de mensurabilidade, invariância e completude das duas camadas;
- exemplos `P/Q`, misturas de identidades e família cardinal;
- execução independente do verificador R.

O verificador foi tratado exclusivamente como evidência mecânica finita.

## 2. Identidade dos bytes

| Item | Resultado |
|---|---|
| Worktree | `/private/tmp/PBP-am-msb` |
| Branch | `agenda-extension-am-msb` |
| HEAD | `e17520ee927eaca96ac9624ea032f855a6dc284d` |
| Commit substantivo | `e020629d5bad8fbd66d67cf108b1a2e0d8b048fd` |
| Ancestralidade | confirmada; `e020629...` é o pai substantivo do HEAD |
| Alterações rastreadas durante a revisão | nenhuma |
| Artefato não rastreado de outro parecerista | ignorado, conforme o mandato |
| SHA-256 externo do manifesto | `4130c09b9a7d504e0dd18f63c8793a0f6ce5f239369c585d924c48742177c0aa` |
| Entradas do manifesto | 24 |
| `shasum -a 256 -c` | 24/24 `OK` |

O commit substantivo altera somente resultados, ledger, script e output. O HEAD acrescenta manifesto, preflight e relatório de implementação.

### 2.1 Artefatos centrais

| Artefato | SHA-256 recalculado |
|---|---|
| `model_redesign/agenda_extension_A_M_msb_results.md` | `7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3` |
| `model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv` | `321cb2ed45ed1c5ebb6103a4ac567f07b735dd7a2ca8e2252925b43b8a2add9c` |
| `scripts/verify_agenda_extension_A_M_msb.R` | `b3133ab97870cf9c5730c57da40c2c9f4d68912226bb8d8f080022653e2a8391` |
| output versionado | `3a242732c07b3d6ed5c508ca0238d1665c42de9d4f00f857b4030fe724ce7628` |
| preflight | `596c81a6d163bf21bc57020ea8fdc0c1a323feba2ac345bc27660ec05b0dca80` |
| relatório de implementação | `796ce5b75325396b4e4124e8560f99cf5e22991453c2c6dfb6379d85c54e4364` |

### 2.2 Cadeia normativa e de proveniência

Também coincidiram com os hashes declarados:

| Documento | SHA-256 |
|---|---|
| decisão da assinatura em duas camadas | `cd9650715442dc0beae2fa6af450c509c0ad871d51dc5d54b0a6a826d1fc86e8` |
| consulta Fable | `608b9459d26063c6e45f895ba70bd00c2f73bf12cdff3dac854a9b62746e10d7` |
| consulta ChatGPT | `142a39ed2124aca50743e92ef67f505192eb6d159f546b3d8b0c42a274804d0b` |
| emenda M/S/B | `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b` |
| clarificação de anonimato | `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3` |
| decisões pós-parecer | `3000a25c89510f3e0ea471d4406c0c59282f41fd07662b5c077fa81f281e1471` |
| contrato-base | `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4` |
| N3 congelado | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| interface N1 consumida por N3 | `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` |
| resultado histórico importado | `1e385fabd2e25a5b72344d22982d9648e28be92eb68665d484cd8116aaa7772f` |

Os hashes dos dois pareceres anteriores, da adjudicação em Markdown/JSON, dos manifestos intermediários, do repair report e do pacote externo também passaram dentro das 24 verificações do manifesto.

## 3. Reconstrução formal

### 3.1 Primitivas, continuação e ballot

Há \(m=N-1\) Estados fracos, quota \(q=\lfloor N/2\rfloor+1\) e \(k=q-1\) votos fracos necessários, pois a proposta de \(H\) traz seu próprio voto favorável. O tipo privado é \(\theta\in\{0,1\}\), com \(0<o_0<o_1<1\).

Para uma seleção uniforme literal \(\chi(\mu)\) da continuação congelada:

\[
r_\chi(\mu)=\beta c_\chi(\mu),\qquad
D_{\chi,\theta}(\mu)=\beta h_{\chi,\theta}(\mu),\qquad
A_\chi(\mu)=1-k r_\chi(\mu).
\]

A interface congelada implica

\[
0<r_\chi(\mu)\leq \frac{\beta}{m},
\qquad
k r_\chi(\mu)<1.
\]

A cláusula M faz todos os vetores pivotais no mesmo estado consumirem o mesmo membro literal da continuação. Portanto, as-if-pivotal e \(T^Y\) produzem exatamente:

\[
j\text{ vota sim}\iff x_j\geq r_\chi(\mu),
\]

e a proposta passa se e somente se ao menos \(k\) fracos atingem o corte.

Para posterior e \(\chi\) fixos, o conjunto aceito é união finita de fechados do simplex compacto. O melhor acordo, \(A_\chi(\mu)\), e uma rejeição que paga \(D_{\chi,\theta}(\mu)\) são ambos atingidos. A implementação distingue corretamente esse fechamento condicional do falso fechamento global através da colagem Bayes/off-path.

### 3.2 Bayes local e coordenada \(\rho\)

No prior interior,

\[
\lambda=(1-\nu)\sigma_0+\nu\sigma_1,\qquad
S=\operatorname{supp}\lambda,
\]

e, para todo \(y\in S\),

\[
\pi(y)=\lim_{r\downarrow0}
\frac{\nu\,\sigma_1(B_Y(y,r))}
     {\lambda(B_Y(y,r))}.
\]

A existência do limite é exigida pointwise, não apenas quase certamente. Fora de \(S\), a crença é o único escalar

\[
\nu_{\mathrm{off}}
=b_\rho(\nu)
=\frac{\nu\rho}{1-\nu+\nu\rho},
\qquad \rho\in[0,\infty].
\]

No interior, \(b_\rho(\nu)\) é homeomorfismo crescente entre a reta não negativa estendida e \([0,1]\). Nos endpoints, o suporte do prior fixa toda crença em \(\nu\) e \(\rho\) é substituído por `*`. Não há posterior positivo sobre tipo de prior zero.

### 3.3 Classificação pura e existência

Fixando \((\nu,\rho,\chi)\), escreva

\[
p_\rho=b_\rho(\nu),\qquad
O_\theta(\rho)=
\max\{A_\chi(p_\rho),D_{\chi,\theta}(p_\rho)\}.
\]

A classificação necessária e suficiente foi rederivada:

| Classe pura | Condição exata |
|---|---|
| pooling com acordo | \(O_1(\rho)\leq A_\nu\) |
| pooling com atraso | \(D_{0,\nu}\geq O_0(\rho)\) e \(D_{1,\nu}\geq O_1(\rho)\) |
| separating, ambos acordam | \(O_1(\rho)\leq\min\{A_0,A_1\}\), com parcela comum |
| baixo acorda, alto atrasa | \(D_{1,1}\geq O_1(\rho)\) e \(\max\{D_{0,1},O_0(\rho)\}\leq\min\{A_0,D_{1,1}\}\) |
| baixo atrasa, alto acorda | impossível |
| ambos atrasam | \(D_{0,0}\geq D_{0,1}\), \(D_{1,1}\geq D_{1,0}\), \(D_{0,0}\geq O_0(\rho)\), \(D_{1,1}\geq O_1(\rho)\) |

Essas condições incorporam factibilidade, imitação bilateral e todos os desvios off-path. A sensibilidade a \(\rho\) é corretamente expressa como imagem inversa setwise; não se impõe monotonicidade onde a troca de ramo de \(C_M\) pode produzir fibras desconexas.

Com

\[
Z_E=1-\frac{k\beta}{m},
\qquad
T=\frac{Z_E}{\beta}
=\frac1\beta-\frac{k}{m},
\]

a prova construtiva cobre todo o domínio:

- \(o_1\leq T\): pooling com acordo e \(\rho=1\);
- \(o_0\leq T\leq o_1\): baixo acorda, alto atrasa e \(\rho=\infty\);
- \(T\leq o_0\): ambos atrasam, para qualquer \(\rho\).

Portanto a existência quantifica sobre \(\rho\), não uniformemente para cada \(\rho\) fixado. Os endpoints são resolvidos diretamente por medidas Borel suportadas no argmax global de cada tipo.

### 3.4 Membership misto

O objeto reduzido é

\[
R=(\rho,\nu_{\mathrm{off}},
\sigma_0,\sigma_1,\lambda,\pi,\chi,a,u_0,u_1).
\]

Além de tipagem Borel, Bayes pointwise, kernel uniforme literal e ballot de corte, o Teorema T4 exige, para cada tipo,

\[
V_\theta=\int u_\theta\,d\sigma_\theta,
\]

\[
u_\theta(y)\leq V_\theta
\quad\forall y\in S,
\]

\[
u_\theta(y)=V_\theta
\quad\sigma_\theta\text{-q.c.},
\]

\[
V_\theta\geq
\sup_{y\in Y\setminus S}u_\theta^{\mathrm{off}}(y).
\]

A necessidade segue de imitação de qualquer mensagem no suporte e de todo pacote não disciplinado. A suficiência prescreve votos, crenças e continuação e elimina todos os desvios de proposta, inclusive mistos. O supremo fora do suporte não é substituído indevidamente por uma proposta canônica que possa pertencer ao próprio suporte.

A nova assinatura é aplicada somente depois dessa verificação de PBE. Ela não redefine Bayes, racionalidade sequencial nem membership.

## 4. Assinatura exata

O registro realizado é

\[
Z=Y\times[0,1]\times\{0,1\}\times X_M\times\Omega_T.
\]

Para primitivas fixas:

- \(Y\) é compacto polonês;
- \(X_M=\{E,S,P\}\sqcup(\{EP\}\times[0,1])\) é compacto polonês;
- \(\Omega_D\) é finito para os representantes literais consumidos;
- \(\Omega_T=(\{A\}\times Y)\sqcup(\{D\}\times\Omega_D)\) é compacto polonês;
- logo \(Z\) é compacto polonês e \(\mathcal P(Z)^2\) é polonês.

A lei \(\Gamma_\theta^R\) liga no mesmo registro proposta, posterior, acordo/atraso, continuação canônica e outcome terminal. Isso impede recombinação de marginais provenientes de assessments diferentes.

Para \(G=S_m\), \(T_g\) permuta simultaneamente todas as coordenadas nomeadas dos fracos e fixa posterior, indicador de acordo e rótulo canônico de continuação. A ação diagonal sobre

\[
X=\mathcal P(Z)^2
\]

é Borel, de fato contínua.

Definindo

\[
\Lambda_x=\frac1{|G|}\sum_{g\in G}\delta_{g.x},
\]

a prova de T5 é válida:

1. **Mensurabilidade:** para cada Borel \(B\subseteq X\),

   \[
   \Lambda_x(B)=\frac1{|G|}\sum_g1_B(g.x)
   \]

   é Borel em \(x\).

2. **Invariância:** multiplicação por qualquer \(h\in G\) apenas reordena a soma.

3. **Completude:** se \(\Lambda_x=\Lambda_{x'}\), então

   \[
   \Lambda_{x'}(\{x'\})
   =\frac{|\operatorname{Stab}_G(x')|}{|G|}>0.
   \]

   Logo \(\Lambda_x(\{x'\})>0\), o que exige \(x'=g.x\) para algum \(g\). A recíproca é imediata.

O argumento continua válido com estabilizadores não triviais. Assim,

\[
\operatorname{Sig}^{ex}_M(R)
=(\rho(R),\nu_{\mathrm{off}}(R),\Lambda_{(\Gamma_0^R,\Gamma_1^R)})
\]

é completo para a órbita diagonal aprovada.

A seleção expositiva pelo mínimo de uma órbita finita sob isomorfismo Borel é mensurável e escolhe um membro real da órbita. Pelo fechamento do PBE sob permutação comum, esse membro é realizado por um PBE relabelado. Não se seleciona um baricentro nem se afirma um seletor no espaço bruto de funções de \(R\).

## 5. Resumo econômico

O quociente registro a registro usa o mínimo de cada órbita finita sob um isomorfismo Borel:

\[
q_Z:Z\rightarrow Z/G,\qquad q_Z\circ T_g=q_Z.
\]

A transversal é Borel, \(Z/G\) é Borel-padrão e

\[
\operatorname{Sum}^{econ}_M(R)
=(\rho,\nu_{\mathrm{off}},
(q_Z)_\#\Gamma_0^R,(q_Z)_\#\Gamma_1^R).
\]

Para toda função Borel \(G\)-invariante \(f\), a restrição à transversal define uma única função Borel \(\bar f\) tal que

\[
f=\bar f\circ q_Z.
\]

A identidade de integrais decorre diretamente da definição de pushforward. Portanto o resumo recupera, por tipo:

- payoff de \(H\);
- probabilidades de acordo e atraso;
- lei do posterior;
- timing e rótulo canônico da continuação;
- outcome terminal anônimo;
- lei do vetor ordenado de payoffs fracos;
- lei do payoff de uma identidade fraca sorteada uniformemente.

A conclusão depende do registro inteiro. Não resulta de invariância separada de marginais escolhidas livremente. Proposta nomeada, payoff de um \(W_j\) específico, suporte estratégico nomeado, coincidência de mensagens, mapa público pointwise e relação entre os planos dos tipos continuam fora do resumo e exigem a camada exata.

## 6. Checklist da auditoria

| Item | Resultado |
|---|---|
| Reconstrução do jogo, Bayes local, racionalidade e membership | `PASS` |
| Resultados puros previamente sobreviventes | `PASS` |
| T4/AMX-015 e desvios puros/mistos | `PASS` |
| Endpoints e tipo de probabilidade zero | `PASS` |
| Representante uniforme, AMX-015 e interface N3/N1 | `PASS` |
| Assinatura \(\Lambda\): Borelidade, invariância e completude | `PASS` |
| Fechamento por uma permutação comum | `PASS` |
| Resumo \((q_Z)_\#\Gamma_\theta\) por tipo | `PASS` |
| Posterior, acordo/atraso e continuação como invariantes do registro inteiro | `PASS` |
| `P/Q` e correlação entre planos dos tipos | `PASS` |
| Misturas \((.9,.1)\) versus \((.5,.5)\) | `PASS` |
| Reynolds integralmente rebaixado | `PASS` |
| Produto fibrado em \((\rho,\nu_{\mathrm{off}})\) | `PASS` |
| Fatorização downstream por operação | `PASS` |
| Correspondências setwise, sem emparelhamento espúrio | `PASS` |
| Ausência de autorização indevida a `AC/AR` | `PASS` |
| Átomo versus ponto de massa zero e AMX-011 | `PASS` |
| Teorema cardinal | `PASS` |
| Ledger, proveniência e escopo | `PASS` |
| Verificador tratado apenas como evidência finita | `PASS` |

## 7. Tabela claim a claim

| Claim | Localização principal | Resultado da revisão |
|---|---|---|
| `AMX-015` | resultados, §8, especialmente §§8.1–8.3 | `PASS`. A tupla reduzida é bem tipada; Bayes é pointwise; suporte, melhor resposta quase certa e supremo off-path formam condição necessária e suficiente. |
| `AMX-016a` | resultados, §§9.1, 9.2.1 e 9.3 | `PASS`. \(\Lambda\) é Borel, invariante e completo para a ação diagonal; o representante é membro real da órbita e não Reynolds. |
| `AMX-016b` | resultados, §§9.2.2 e 9.3 | `PASS`. O quociente \(Z/G\) e o lema de fatorização sustentam exatamente as estatísticas declaradas; consumo futuro permanece condicionado à operação. |
| `AMX-MSB-009` | resultados, §9.4 | `PASS`. A família atomless produz um contínuo de assinaturas exatas na mesma fibra; o enunciado permanece apenas cardinal. |
| `AMX-MSB-010` | resultados, §§9.1–9.3 | `PASS`. Relabeling comum preserva PBE e assinatura; misturas de identidades não são promovidas a equivalência formal; igualdade de resumo exige igualdade das leis anônimas por tipo. |
| `AMX-MSB-011` | resultados, §§2.1 e 6.3 | `PASS`. \(b_\rho(\nu)\) é a coordenada correta, as fibras são imagens inversas exatas e podem ser desconexas; existência não é afirmada para todo \(\rho\). |
| `AMX-011` | resultados, §8.3 e §11 | `PASS`. A prova setwise de \(V_H^0=V_H^1\) quando o alto usa acordo com probabilidade positiva não depende de atomicidade. |
| `AMX-MSB-001`–`004` e `AMX-001` | resultados, §§3–5 e §7 | permanecem válidos. Uniformização, corte de voto, problema de posterior fixo, rejeição do fechamento global e existência construtiva são compatíveis com a nova assinatura. |
| Claims puros `AMX-002`, `AMX-003`, `AMX-004`, `AMX-014` e `AMX-MSB-005`–`007` | resultados, §§6–7 e §10 | permanecem válidos. As seis classes outcome-puras são exaustivas e incorporam imitação e desvios off-path. |
| Endpoints, semipooling e misturas de fronteira `AMX-005`–`007` | resultados, §§6.4, 9.3 e 10 | permanecem válidos dentro do escopo reenunciado. |
| Limites e impossibilidades `AMX-010`–`012` | resultados, §11 | permanecem válidos; decorrem das desigualdades pointwise dos payoffs e não da codificação de anonimato. |
| `AMX-013` | script/output | escopo corretamente mecânico; não é usado como prova de PBE ou mensurabilidade. |
| `AMX-NEG-001` | resultados, §12 | corretamente importado como resultado histórico do contrato antigo, sem ser promovido a não existência sob M/S/B. |
| `IC-D1-BENCHMARK` | ledger e resultados, §13.1 | corretamente `PENDING / NONBLOCKING`; nenhuma hipótese D1 foi introduzida no baseline. |

O ledger contém 31 linhas, 16 campos por linha de claim, identificadores únicos e correspondência substantiva entre enunciado, status, dependências, proveniência e localização da prova.

## 8. Stress-tests

### 8.1 Certificado `P/Q`

Na instância

\[
N=5,\quad \beta=.9,\quad
(o_0,o_1)=(.7,.8),\quad
\nu=.5,\quad \rho=1,
\]

o ramo \(E\) é único:

\[
r=.225,\qquad A=.55,\qquad
(D_0,D_1)=(.63,.72).
\]

Propostas que pagam \(0.1\) a dois fracos são rejeitadas e são ótimas para ambos os tipos.

Em \(P\), as coalizões planejadas são \(\{1,2\}\) e \(\{3,4\}\), com interseção de cardinalidade zero. Em \(Q\), são \(\{1,2\}\) e \(\{1,3\}\), com interseção de cardinalidade um. Uma permutação comum preserva essa cardinalidade, logo \(P\) e \(Q\) não estão na mesma órbita e suas leis \(\Lambda\) diferem.

Por tipo isolado, Reynolds uniformiza cada coalizão sobre as seis coalizões de tamanho dois; por isso seus baricentros componentwise coincidem. Os pushforwards por \(q_Z\) também coincidem deliberadamente. O exemplo separa corretamente identidade formal, resumo econômico e correlação entre planos contrafactuais.

### 8.2 Misturas \((.9,.1)\) e \((.5,.5)\)

Se o tipo baixo mistura entre \(y_{12}\) e \(y_{13}\), enquanto o alto usa exclusivamente \(y_{34}\), os suportes dos tipos são disjuntos. Bayes continua atribuindo posteriores 0 e 1. Alterar os pesos de \((.9,.1)\) para \((.5,.5)\):

- altera a lei exata;
- não pode ser produzido por uma permutação comum;
- preserva o resumo econômico quando os registros misturados pertencem à mesma órbita em \(Z\).

Se ambos os tipos passam a usar a mesma mensagem com massa positiva, o posterior deve ser recalculado pela razão de verossimilhança e torna-se interior. Não é possível misturar linearmente leis \(\Gamma_\theta\) que carreguem versões antigas e contraditórias do posterior. Nesse segundo caso mudam tanto a camada exata quanto o resumo econômico.

### 8.3 Reynolds

Todas as ocorrências substantivas foram conferidas. Reynolds aparece somente como estatística computacional marginal, acompanhado das quatro limitações necessárias:

1. não é invariante completo da órbita diagonal;
2. não preserva a relação entre planos dos tipos;
3. pode não ser realizável por assessment algum;
4. sua igualdade implica somente igualdade do resumo marginal pertinente.

Ele não reaparece como assessment, PBE, representante real ou invariante completo.

### 8.4 Regra downstream

A interface exige primeiro o produto fibrado na mesma dupla \((\rho,\nu_{\mathrm{off}})\), na camada exata. Uma operação futura somente pode consumir o resumo se provar:

\[
\operatorname{Sum}^{econ}(R)
=\operatorname{Sum}^{econ}(R')
\Longrightarrow
C(R)=C(R')
\]

na fibra relevante e uma fatorização mensurável própria.

Para correspondências, a prova deve ser setwise e preservar as propriedades do gráfico e as seleções empregadas. O texto proíbe emparelhamento de coordenadas de elementos diferentes e recombinação cartesiana. `A_U` permanece pendente e nenhum consumo por `AC` ou `AR` é autorizado neste passe.

### 8.5 Átomo versus massa zero

Se \(\lambda(\{y\})>0\) e \(0<\pi(y)<1\), Bayes no átomo implica massa positiva de ambos os tipos. A igualdade de melhor resposta quase certa torna-se então pontual naquele singleton:

- se passa, \(V_0=V_1=z_H(y)\);
- se rejeita, \(V_\theta=D_\theta(\pi(y))\).

Em pontos de massa zero não há promoção pointwise. As conclusões corretas nos extremos são setwise:

\[
\sigma_1(\{\pi=0\})=0,
\qquad
\sigma_0(\{\pi=1\})=0,
\]

derivadas das identidades integrais de Bayes. A prova de AMX-011 usa desigualdades de imitação e suporte quase certo e não depende de átomos. O reparo é completo e não altera T4.

### 8.6 Teorema cardinal

Na linha de propostas rejeitadas \(s(t)=(t,0,\ldots,0)\), a família

\[
\pi_\varepsilon(t)=
\frac12+\varepsilon(2t-1),
\qquad
\varepsilon\in[-1/2,1/2],
\]

com densidades tipo-específicas correspondentes, satisfaz Bayes local em todo ponto e mantém \(\lambda\) uniforme. A ação dos fracos fixa essa linha, enquanto as leis de \((y,\pi(y))\) diferem para valores distintos de \(\varepsilon\). Logo há um contínuo de leis de órbita distintas na mesma fibra.

A conclusão correta é somente que nenhuma lista finita enumera a correspondência em geral. O texto não afirma impossibilidade de parametrização finito-dimensional.

## 9. Verificação mecânica

Reexecutei:

```text
env LC_ALL=C LANG=C Rscript scripts/verify_agenda_extension_A_M_msb.R
```

Resultado:

```text
SUMMARY | 3954 PASS | 0 FAIL
```

A contagem coincide com a saída versionada. O script cobre aritmética dos ramos, factibilidade, cutoffs, classes puras, exemplos de mistura, `P/Q`, invariância de \(\Lambda\), pushforward por \(q_Z\), pesos de identidade e família cardinal.

Ele não prova mensurabilidade geral, completude, existência de PBE, Bayes pointwise, realizabilidade ou fatorização downstream. O próprio output declara corretamente essa limitação.

## 10. Findings

Não identifiquei finding `critical`, `important` ou `minor` nos bytes auditados.

As limitações remanescentes — revisão ainda não incorporada ao status interno do ledger, `A_U` pendente e ausência de autorização corrente para `AC/AR` — são fronteiras processuais e de escopo expressamente declaradas, não defeitos formais do candidato.

## 11. Veredito

A implementação repara integralmente os defeitos adjudicados:

- substitui Reynolds pela lei de órbita diagonal exata;
- preserva um resumo econômico canônico sem promovê-lo a assessment;
- fecha os espaços mensuráveis e prova completude;
- distingue corretamente identidade, anonimato, revelação e mistura;
- preserva T4, endpoints, fechamento por permutação comum e o teorema cardinal;
- corrige a distinção átomo/massa zero;
- impõe a regra downstream setwise e por operação;
- mantém o verificador no papel apropriado de regressão finita.

O parecer é limitado exatamente ao branch, commits, manifesto e bytes identificados acima. Qualquer alteração nesses artefatos exige nova revisão.

FINAL_STATUS: PASS  
COUNTS: 0/0/0
