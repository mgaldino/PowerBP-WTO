# Parecer formal 2 — pacote `A_M` sob M/S/B

**Data:** 2026-08-29  
**Papel:** parecerista formal/game-theoretic 2, read-only sobre o candidato  
**Tipo de jogo:** bargaining dinâmico bayesiano com sinalização pela proposta, votação simultânea sob maioria e continuação congelada  
**Veredito:** `FAIL`  
**Contagens:** `0 critical / 1 important / 1 minor`

## 1. Declaração de independência e método

Este parecer foi produzido em sessão nova e por reconstrução matemática a
frio. Não consultei memória de sessões anteriores, rollout summaries, nem o
parecer do outro revisor. Também não procurei, abri ou esperei o arquivo
`quality_reports/2026-08-29_A_M_msb_formal_review_1.md`.

A análise foi separada em duas fases:

1. **Fase A — reconstrução:** li, na precedência determinada, a emenda M/S/B,
   a clarificação de anonimato, as decisões pós-parecer e o Gate 0; depois li o
   N3 congelado, os resultados candidatos e o ledger. Reconstituí votação,
   payoffs, ICs, Bayes, existência, membership puro/misto, kernels e assinatura
   antes de consultar qualquer narrativa de implementação.
2. **Fase B — provenance e cobertura:** somente depois de fixar os achados da
   Fase A, li o script e output mecânicos, o manifesto, os relatórios de
   implementação e a consulta externa. Esses itens foram usados para confirmar
   identidade, escopo e cobertura; não substituíram a prova.

O protocolo da skill `game-theory-audit` foi adaptado a este jogo de
barganha/sinalização: racionalidade sequencial dos votos, consistência de
crenças, IC bilateral, desvios sobre todo `Y`, existência/atingimento,
completude de classes, mensurabilidade e preservação atômica das continuações.
Não editei nenhum artefato do candidato.

## 2. Identidade do candidato

| Checagem | Esperado | Recalculado | Resultado |
|---|---|---|---|
| worktree | `/private/tmp/PBP-am-msb` | `/private/tmp/PBP-am-msb` | PASS |
| branch | `agenda-extension-am-msb` | `agenda-extension-am-msb` | PASS |
| `HEAD` | `6b94f2f57aaf8615972e27479435be1db7d44d7f` | igual | PASS |
| commit substantivo | `b2b7a34a2a320a5696f57ed8533495ffe3f4e6b6` | objeto `commit`; pai de `HEAD` | PASS |
| SHA-256 externo do manifesto | `7905d48837f64f7ff89d661c3458462d24e6296ae44c047710786343e1e51bd6` | igual | PASS |
| checks internos | 21 entradas | `shasum -a 256 -c`: 21 `OK` | PASS |
| worktree antes do parecer | limpo | `git status --short` vazio | PASS |

Hashes centrais recalculados:

| Artefato | SHA-256 |
|---|---|
| resultados | `020ffbb1d67daaabf9a330be1f0f3ea91d42b55e3b7047787a8c8eb06f6912ed` |
| ledger | `56073462c367277a1863d2a4eeb817e49c57845b4cd0f04c404ff57bfc4b38e1` |
| script | `0e460d286b2647ef5ed17485339ad69e3e332346494e22b9ffdca362b7c7374f` |
| output mecânico | `13716a16506c68e9153617194c71ccd608f6ccc3a2911ba87167ee17705f4ecb` |
| relatório de reparo | `1038ae8c513564f5c78648ccc933e51e0a2c881bad15fb940e292b8c7c59bfb1` |

Reexecutei o verificador com `LC_ALL=C LANG=C`; o resultado foi
`3944 PASS / 0 FAIL`. Isso confirma a evidência finita que o script declara
cobrir, não os teoremas de PBE, Bayes pointwise, mensurabilidade ou quociente
anônimo.

## 3. Reconstrução do jogo e objetos básicos

Há um proponente informado `H`, `m=N-1` Estados fracos, quota total
`q=floor(N/2)+1` e `k=q-1` votos fracos necessários porque a proposta de `H`
conta como voto favorável. O pacote é

```text
y=(z_H,x_1,...,x_m) in Y,
z_H>=0, x_j>=0, z_H+sum_j x_j<=1.
```

Se o ballot rejeita, a cláusula M seleciona por posterior, e não por proposta,
votos ou identidade, um membro literal uniforme da continuação congelada
`C_M`. Para o ramo `B in {E,S,P,EP}`, sejam `c_B(mu)` o payoff interino comum
de cada fraco e `h_B(theta)` o payoff nativo de `H` em `C_M`. Em unidades de
`A_M`, a reconstrução produz

```text
r_B(mu)=beta*c_B(mu),
D_B,theta(mu)=beta*h_B(theta),
A_B(mu)=1-k*r_B(mu).
```

Os três ramos puros têm

```text
c_E=1/m,
c_S(mu)=[(1-mu)(1-beta*o_0)+mu*beta]/m,
c_P=(1-beta*o_1)/m,

h_E=(o_0,o_1),
h_S=(beta*o_0,beta*o_1),
h_P=(beta*o_1,beta*o_1).
```

No empate residual `EP`, payoff e kernel usam o mesmo peso comum. A loteria
uniforme sobre coalizões está literalmente apoiada no argmax permitido por N3.
O ciclo reproduz apenas incidências e payoffs interinos; corretamente não entra
em `X_M`, no kernel terminal nem na assinatura.

Como `0<r_B(mu)<=beta/m` e `k<m`, vale `k r_B(mu)<1`. M e S tornam o preço
igual entre votantes, de modo que a racionalidade as-if-pivotal e `T^Y`
implicam

```text
j vota sim  iff  x_j>=r_B(mu),
proposta passa iff ao menos k pagamentos cobrem o corte.
```

Esse bloco passa o stress-test, inclusive `N=3`, quando `k-1=0` nos ramos
`S/P`, e os casos pares e ímpares de `N`.

## 4. Atingimento, não atingimento e votação

Condicionalmente a `(mu,chi(mu))`, o conjunto aceito é união finita de
interseções fechadas de `Y`; portanto é compacto. Pagar exatamente `r_B(mu)` a
alguma coalizão de tamanho `k` atinge `A_B(mu)`. A proposta `(1,0,...,0)` é
rejeitada e atinge `D_B,theta(mu)`. Logo o ótimo condicional é

```text
max{A_B(mu),D_B,theta(mu)}.
```

O candidato também acerta ao rejeitar fechamento global. Recalculei o exemplo
`N=5`, `m=4`, `k=2`, `beta=.9`, `o_0=.1`, `o_1=.9`, `nu_off=0`:

```text
r_S(0)=.20475, A_S(0)=.5905,
r_E(1)=.225,
D_0(0)=.081, D_1(0)=.729,
D_0(1)=.09, D_1(1)=.81.
```

O baixo acorda por `.5905`; o alto induz `mu=1` e rejeição por `.81`. Ambos
satisfazem imitação e desvios off-path. Pacotes off-path aceitos a `mu=0`
convergem ao sinal on-path rejeitado do alto. Assim, fechamento condicional
passa e fechamento global falha exatamente como alegado.

Para suportes puros finitos, retirar o suporte deixa `Y\S` denso. O supremo
off-path é, portanto,

```text
O_theta(rho)=max{A_chi(b_rho(nu)),D_chi,theta(b_rho(nu))},
```

mesmo quando o acordo canônico pertence ao suporte e o supremo no complemento
não é atingido. Esse uso de supremo, e não de máximo, fecha o teste de
não-atingimento.

## 5. Classes puras e IC bilateral

Para prior interior, um perfil puro é pooling ou separating. Recalculei as
restrições de factibilidade, imitação dos dois tipos e desvios a todo terceiro
pacote:

| Classe | Condição necessária e suficiente |
|---|---|
| pooling, ambos acordam | `O_1<=A_nu`; qualquer `z in [O_1,A_nu]` |
| pooling, ambos atrasam | `D_0,nu>=O_0` e `D_1,nu>=O_1` |
| separating, ambos acordam | imitação força `z_0=z_1=z`; `O_1<=z<=min{A_0,A_1}` |
| separating, baixo acorda/alto atrasa | `D_1,1>=O_1` e `max{D_0,1,O_0}<=z<=min{A_0,D_1,1}` |
| separating, baixo atrasa/alto acorda | impossível, pois em `mu=0`, `D_1,0>D_0,0` e a imitação exigiria `D_0,0>=z>=D_1,0` |
| separating, ambos atrasam | `D_0,0>=D_0,1`, `D_1,1>=D_1,0`, `D_0,0>=O_0`, `D_1,1>=O_1` |

Não encontrei classe pura ausente, IC invertida ou desvio de voto/proposta não
coberto. Em particular, a impossibilidade baixo-atraso/alto-acordo usa o fato
correto de que o ramo em posterior zero é `S` ou `E`, nunca `P`.

## 6. Existência, fronteiras, priors e `rho`

Defina

```text
Z_E=1-k*beta/m,
T=Z_E/beta=1/beta-k/m.
```

Como `q=k+1<=m` e `beta<1`, `T>1/m`. As três testemunhas cobrem o domínio:

1. `o_1<=T`: `rho=1`, `nu_off=nu`, pooling com acordo;
2. `o_0<=T<=o_1`: `rho=infinity`, `nu_off=1`, baixo acorda por `Z_E` e alto
   atrasa;
3. `T<=o_0`: `E` é único e ambos atrasam, para qualquer `rho`.

Nos empates, a mesma combinação convexa `E/P` preserva as desigualdades. As
misturas escritas para `o_1=T` e `o_0=T<o_1` têm posteriores de Bayes corretos,
inclusive `ell=0,1`. Se `T>1`, a primeira região cobre todo o domínio de
`o_1`. Nos priors `0/1`, suporte do prior força a crença correspondente em todo
`Y`; a fibra `rho` colapsa corretamente para `*`, e cada tipo, inclusive o
contrafactual, usa uma probabilidade Borel apoiada no argmax global.

No interior,

```text
b_rho(nu)=nu*rho/(1-nu+nu*rho)
```

é um homeomorfismo crescente de `[0,infinity]` em `[0,1]`, com `rho=0,1,
infinity` gerando `0,nu,1`. Os cutoffs `SP/SE/EP` foram rederivados pela
transformação de odds; a região desconexa do exemplo `N=3`, `beta=.9`,
`o_0=.04`, `o_1=.73`, `nu=.05` é de fato
`{0} union (78.66,infinity]`. O claim de existência quantifica corretamente
sobre algum `rho`; não afirma existência para cada `rho` fixado.

## 7. Bayes pointwise, mensurabilidade e membership misto

Para `lambda=(1-nu)sigma_0+nu sigma_1` e `S=supp(lambda)`, o candidato impõe o
limite local em todo `S`, embora Besicovitch o identifique com a derivada de
Radon–Nikodym apenas `lambda`-quase certamente. Fora de `S`, a crença é o
mesmo `nu_off`. Essa distinção pointwise versus quase certamente está
corretamente declarada.

As razões em bolas de raio racional são Borel; existência do limite pointwise,
fechamento de `S`, Borelidade de `chi` e finitude da soma de votos implicam
Borelidade de `pi`, `a`, `u_0`, `u_1` e do kernel composto.

Para o objeto reduzido bem tipado

```text
R=(rho,nu_off,sigma_0,sigma_1,lambda,pi,chi,a,u_0,u_1),
sigma_theta in P(Y),
```

o `iff` misto está correto no nível de medidas:

```text
u_theta(y)<=V_theta para todo y in S,
u_theta(y)=V_theta sigma_theta-q.c.,
V_theta>=sup_{y in Y\S}u_theta^off(y).
```

Essas condições cobrem imitação de sinais do outro tipo, desvios fora do
suporte e qualquer mistura alternativa. O exemplo atomless da Seção 9.4
satisfaz Bayes em todos os pontos de sua linha de suporte e entrega um
contínuo de assinaturas na mesma fibra. Há, contudo, uma imprecisão local nas
consequências pointwise da Seção 8.3; ela é o Finding `AM2-M001` abaixo e não
invalida o `iff` de medidas.

## 8. Lei conjunta, payoffs por tipo e preço bayesiano

A lei

```text
Gamma_theta=Law_theta(y,pi(y),a(y),chi(pi(y)),omega_T)
```

vincula corretamente sinal, posterior, timing, membro uniforme literal e
outcome terminal. `V_H^theta`, acordo/atraso, `Q_theta`, payoffs fracos e
`G_pi` são marginais ou integrais da mesma lei por tipo.

O candidato corrige também a distinção substantiva entre:

- `bar_w_j_theta(p,x)`, payoff fraco realizado condicional ao tipo; e
- `r_chi(p)`, preço de voto/interim payoff bayesiano.

No ramo `S`, os valores transportados condicionais são
`beta(1-beta o_0)/m` e `beta^2/m`; somente sua média sob o posterior é
`r_S(p)`. Essa parte passa.

O defeito material está na anonimização posterior da dupla
`(Gamma_0,Gamma_1)`: o operador proposto não preserva toda a órbita diagonal
determinada pela clarificação. Ver Finding `AM2-I001`.

## 9. Limites, cardinalidade e claims históricos

Para toda proposta, o payoff de desvio satisfaz

```text
0<=u_1(y)-u_0(y)<=beta(o_1-o_0).
```

Como os dois tipos maximizam sobre o mesmo `Y`, isso implica
`0<=V_H^1-V_H^0<=beta(o_1-o_0)`. Pagar `beta/m` a `k` fracos garante `Z_E`;
rejeitar claramente garante ao menos `beta^2 o_theta`. Logo os limites de
AMX-010 passam.

Recalculei o exemplo cardinal `N=5`, `beta=.9`, `o_0=.7`, `o_1=.8`,
`nu=.5`, `rho=1`: `E` é único, `A=.55`, `D_0=.63`, `D_1=.72`; as densidades
afins são probabilidades não negativas, geram `lambda=dt` e posterior local
`pi_epsilon(t)`. Como a linha de propostas é fixa por permutações dos fracos,
o quociente não elimina o contínuo. O teorema afirma corretamente apenas
incontabilidade/ausência de lista finita.

AMX-009 e AMX-NEG-001 estão corretamente separados dos claims correntes. O
primeiro define o comparador histórico e nega seu transporte sob S. O segundo
é explicitamente um lema importado do contrato antigo; conferi seu estatuto e
provenance, não revalidei aqui `kappa_old`, a crença antiga ou `g_theta`.

## 10. Cobertura claim por claim do ledger

| Claim | Resultado deste parecer | Fundamentação curta |
|---|---|---|
| `AMX-MSB-001` | PASS | Kernel uniforme é membro literal de N3; ciclo só calcula payoffs. |
| `AMX-MSB-002` | PASS | M+S, as-if-pivotal e `T^Y` dão o corte comum e quota `k`. |
| `AMX-MSB-003` | PASS | Aceitação compacta a posterior fixo; acordo e rejeição são atingidos. |
| `AMX-MSB-004` | PASS | Contraexemplo global e ICs numéricas foram rederivados. |
| `AMX-001` | PASS | Testemunhas nas três regiões cobrem primitivas e priors, quantificando sobre `rho`. |
| `AMX-002` | PASS | Condição pooling-acordo e intervalo de `z` são exatos. |
| `AMX-MSB-005` | PASS | As duas desigualdades são exatamente os desvios dos dois tipos. |
| `AMX-MSB-006` | PASS | Imitação bilateral força parcela comum; factibilidade/off-path fecham o iff. |
| `AMX-003` | PASS | Intervalo baixo-acordo/alto-atraso contém todas e somente as ICs. |
| `AMX-MSB-007` | PASS | `D_1,0>D_0,0` torna a classe inversa impossível. |
| `AMX-004` | PASS | Quatro desigualdades de atraso-atraso são necessárias e suficientes. |
| `AMX-005` | PASS | Endpoints, tipo contrafactual e fibra `*` estão bem formados. |
| `AMX-006` | PASS | Iff é correto dentro da família semipooling declarada. |
| `AMX-MSB-008` | PASS | `.5914<.63`; testemunha histórica falha sob S. |
| `AMX-007` | PASS | Misturas de fronteira e Bayes em `ell=0,1` estão explícitos e corretos. |
| `AMX-008` | PASS | Geometria assimétrica de preços está fora do kernel permitido por S. |
| `AMX-009` | PASS | Intervalo antigo está definido e corretamente marcado como não corrente. |
| `AMX-010` | PASS | Garantias e diferença por tipo seguem de desvios uniformes e desigualdade pointwise. |
| `AMX-011` | PASS | Uso aprovado com probabilidade positiva implica imitação e `V_0=V_1`; F2 não o atinge. |
| `AMX-012` | PASS | As impossibilidades puras foram rederivadas. |
| `AMX-013` | PASS mecânico | Reexecução: `3944/0`; não contado como prova. |
| `AMX-014` | PASS | Cinco padrões puros e condições exatas esgotam estratégias puras; a assinatura ainda requer re-corte por F1. |
| `AMX-015` | PASS com ressalva menor | O `iff` de medidas passa; as frases pointwise auxiliares precisam da correção F2. |
| `AMX-MSB-009` | PASS | Exemplo atomless prova incontabilidade mesmo sob o quociente pretendido. |
| `AMX-016` | **FAIL — AM2-I001** | A lei por tipo passa, mas o Reynolds componentwise não é o quociente diagonal exigido. |
| `AMX-NEG-001` | PASS quanto ao estatuto | Lema histórico importado e não corrente; conteúdo antigo não foi revalidado neste parecer. |
| `AMX-MSB-010` | **FAIL — AM2-I001** | Fechamento sob permutação passa; alegação de que o quociente elimina apenas variação estéril falha. |
| `AMX-MSB-011` | PASS | `rho` é coordenada bijetiva; sensibilidade mantém `chi` fixa. |
| `IC-D1-BENCHMARK` | FORA DO ESCOPO / corretamente `pending` | Não é requisito de fechamento de `A_M` e não foi importado silenciosamente. |

## 11. Findings

### AM2-I001 — `important` — o Reynolds componentwise não implementa o quociente diagonal aprovado

**Localizador:** resultados, linhas 951–977, especialmente a definição nas
linhas 955–964; assinatura nas linhas 856–865; ledger `AMX-016` e
`AMX-MSB-010`. Contrato violado: clarificação, linhas 60–68 e 79–84, que exige
a mesma permutação no perfil inteiro e preserva separação por identidade de
coalizão.

**Defeito.** O texto define

```text
Anon(Gamma_0,Gamma_1)
 = |G|^{-1} sum_g (g#Gamma_0,g#Gamma_1).
```

Como a soma de pares de medidas é componentwise, o resultado é apenas o par
das duas marginais separadamente simetrizadas. O índice comum `g` desaparece
depois da soma. Portanto esse operador não é um invariante completo da ação
diagonal e não preserva a correlação contrafactual entre as coalizões escolhidas
pelos dois tipos.

**Contraexemplo dentro do domínio.** Tome

```text
N=5, m=4, k=2, beta=.9,
o_0=.1, o_1=.2, nu=.5, rho=0.
```

Em `mu=0`, `S` dá `r_0=.20475`, `A_0=.5905`; em `mu=1`, `P` dá
`r_1=.1845`, `A_1=.631`; off-path em `mu=0`, `O_1=.5905`. Logo existem
PBEs separating em que os dois tipos acordam com `z_0=z_1=.5905`.

Compare dois perfis puros:

```text
perfil A: Q_0={1,2}, Q_1={3,4}, |Q_0 inter Q_1|=0;
perfil B: Q_0={1,2}, Q_1={2,3}, |Q_0 inter Q_1|=1.
```

Nenhuma permutação comum leva A a B, pois a cardinalidade da interseção é
invariante; são órbitas diagonais diferentes. Contudo, para cada tipo
separadamente, a média de grupo é a distribuição uniforme sobre as seis
coalizões de tamanho dois. Assim, o `Anon` escrito atribui exatamente a mesma
assinatura aos dois perfis. Os posteriores `0/1` ainda distinguem pooling de
separating, mas não resgatam a correlação `Q_0`–`Q_1` perdida.

**Consequência.** `AMX-016` não entrega a correspondência exata de assinaturas
e `AMX-MSB-010` é falso na parte que diz eliminar somente variação estéril. O
núcleo de existência, votação e membership permanece válido, mas as classes
puras/mistas precisam ser recortadas novamente antes de consumo por `AC`.
Uma correção deve representar a órbita da dupla sob a ação diagonal — por
exemplo, a lei da órbita no espaço de pares — em vez de guardar apenas o
baricentro componentwise. Isso é reparo técnico forçado pela clarificação, não
uma nova escolha normativa.

### AM2-M001 — `minor` — as restrições da Seção 8.3 precisam de qualificador quase certamente/uso com massa positiva

**Localizador:** resultados, linhas 803–810. O próprio Teorema T4, linhas
777–785, exige igualdade de melhor resposta apenas `sigma_theta`-quase
certamente.

**Defeito.** De `0<pi(y)<1` segue presença local dos dois tipos, mas não que um
ponto individual de suporte atomless receba massa positiva nem que a igualdade
de payoff valha nesse ponto nulo. Com payoffs apenas Borel, o suporte
topológico pode conter pontos nulos estritamente subótimos.

**Contraexemplo.** Nos parâmetros cardinais do próprio texto
`N=5`, `beta=.9`, `o_0=.7`, `o_1=.8`, `nu=.5`, `rho=1`, o ramo `E` é único,
`r=.225`, `A=.55`, `D_0=.63`, `D_1=.72`. Faça os dois tipos usarem a mesma
lei atomless sobre

```text
y(t)=(0,.225,.225-t,0,0),  t in [0,epsilon].
```

Para `t>0`, a proposta rejeita e entrega o valor ótimo `D_theta`; `t=0` está
no suporte, tem posterior `.5`, passa por `T^Y`, mas dá `z_H=0`. O ponto
`t=0` tem massa zero. O objeto satisfaz as condições de T4, porém contradiz a
afirmação pointwise `V_0=V_1=z_H(y(0))` das linhas 805–806.

**Consequência.** As três primeiras bullets de 8.3 devem ser lidas
`sigma_theta`-q.c. ou condicionadas a uso com massa positiva. O claim
`AMX-011`, que já exige probabilidade positiva de proposta aprovada, permanece
correto; o `iff` misto não é afetado.

## 12. Limites do parecer

- Não rederivei `C_M` do zero; auditei a membership literal e as coordenadas
  consumidas contra o N3 congelado.
- Não revalidei o conteúdo matemático histórico de `AMX-NEG-001`; apenas seu
  estatuto importado, hash e não transporte.
- `A_U`, `AC`, `AR`, IC/D1 e o manuscrito estão deliberadamente fora do
  escopo. A menção à futura fibra de `AC` foi testada somente como interface.
- O verificador cobre identidades e exemplos finitos; não prova existência,
  completude, Bayes pointwise, kernels Borel ou a correção do quociente.
- A álgebra finita de votos/ICs seria boa candidata a formalização leve; a
  classificação mista e o quociente de medidas exigiriam infraestrutura de
  teoria da medida e ação de grupos. Nenhuma formalização Lean foi tratada
  como evidência neste parecer.

## 13. Contagens e veredito

| Gravidade | Contagem |
|---|---:|
| `critical` | 0 |
| `important` | 1 |
| `minor` | 1 |

Há uma lacuna material na assinatura exata exigida por AMX-016 e pela
clarificação de anonimato. Pelas regras do gate, `PASS` requer `0/0/0`.

## Veredito final

FAIL
