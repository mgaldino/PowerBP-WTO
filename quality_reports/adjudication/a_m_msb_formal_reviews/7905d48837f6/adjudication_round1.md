# Adjudicação round 1 — pareceres formais de `A_M` sob M/S/B

**Data:** 2026-08-29  
**Papel:** adjudicador independente, read-only sobre o pacote e os pareceres  
**Adjudication ID:** `a_m_msb_formal_reviews:7905d48837f6:round1`  
**Veredito:** `BLOCKED`

## 1. Identidade da fonte e do contrato

O artefato composto revisado é o manifesto
`quality_reports/2026-08-29_A_M_msb_post_review_repair_manifest.sha256`.

| Checagem | Resultado |
|---|---|
| worktree | `/private/tmp/PBP-am-msb` |
| branch | `agenda-extension-am-msb` |
| `HEAD` esperado/recalculado | `6b94f2f57aaf8615972e27479435be1db7d44d7f` — coincide |
| commit substantivo | `b2b7a34a2a320a5696f57ed8533495ffe3f4e6b6` — objeto `commit`, pai e ancestral de `HEAD` |
| diff substantivo → `HEAD` | somente o relatório pós-reparo e o manifesto foram acrescentados |
| SHA-256 externo do manifesto | `7905d48837f64f7ff89d661c3458462d24e6296ae44c047710786343e1e51bd6` — coincide |
| checks internos do manifesto | `21/21 OK` por `shasum -a 256 -c` |
| resultados | `020ffbb1d67daaabf9a330be1f0f3ea91d42b55e3b7047787a8c8eb06f6912ed` |
| ledger | `56073462c367277a1863d2a4eeb817e49c57845b4cd0f04c404ff57bfc4b38e1` |
| verificador | `0e460d286b2647ef5ed17485339ad69e3e332346494e22b9ffdca362b7c7374f` |
| output preservado | `13716a16506c68e9153617194c71ccd608f6ccc3a2911ba87167ee17705f4ecb` |
| parecer R1 | `29e2db70cffc0931f2c5838f48113cf5d21cfcd60b1a3a361c38c1967fb49187` — coincide |
| parecer R2 | `a072d86ecbdecbda26b9197a4523e49c35bec14f0d1faf34dfdd4da8ea5bc1ce` — coincide |

O worktree continha, no início da adjudicação, apenas os dois pareceres como
arquivos não rastreados; isso é o input esperado desta rodada e não altera os
bytes manifestados. O artefato está íntegro.

Não há argument-contract JSON para esta rodada (`contract.required=false`). A
precedência normativa foi conferida diretamente, em leitura integral, nos
seguintes documentos:

1. emenda M/S/B aprovada, SHA-256
   `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b`;
2. clarificação aprovada de anonimato/kernel, SHA-256
   `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3`;
3. decisões pós-parecer aprovadas, SHA-256
   `3000a25c89510f3e0ea471d4406c0c59282f41fd07662b5c077fa81f281e1471`;
4. Gate 0 simplificado, no que não foi emendado, SHA-256
   `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4`.

## 2. Disposição executiva

Os quatro source findings são confirmados, mas formam somente dois clusters:

- **Cluster A — importante:** o Reynolds componentwise das linhas 951–964 não
  é invariante completo do quociente pela ação diagonal. Ele identifica duplas
  em órbitas diagonais distintas e torna falsas a exatidão de `AMX-016` e a
  segunda metade de `AMX-MSB-010`. A definição individual de `Gamma_theta`, as
  marginais derivadas e o lema de fechamento por permutação sobrevivem.
- **Cluster B — minor:** as três primeiras bullets da §8.3 transformam
  propriedades quase-certamente ou setwise em afirmações ponto a ponto. Há
  PBEs atomless que satisfazem T4 e contêm pontos nulos de suporte estritamente
  subótimos. T4 e `AMX-015` já usam a formulação correta e sobrevivem.

O Teorema cardinal AM-MSB-T6 e `AMX-MSB-009` também sobrevivem ao Cluster A:
na família da §9.4 cada proposta e cada lei são fixas pelas permutações dos
fracos, e uma estatística invariante distingue continuamente `epsilon`.

O veredito é `BLOCKED`, embora não haja finding diagnóstico `UNRESOLVED`. O
reparo material do Cluster A ainda exige desenho e decisão autoral: a órbita
diagonal ordinária preserva a mesma permutação nos dois tipos, mas não colapsa
automaticamente todas as misturas sobre identidades que a clarificação também
manda pôr na mesma classe. Nenhuma das propostas dos pareceristas resolve essa
tensão para medidas mistas sem acrescentar uma noção de acoplamento ou alterar
a equivalência aprovada. O reparo do Cluster B é local e seguro, mas não basta
para liberar o pacote.

## 3. Tabela de findings normalizados

| Source finding | Cluster | Tipo | Severidade | Status | Reparo proposto | Disposição |
|---|---|---|---|---|---|---|
| `R1-AM-FR1-ANON` | A | `false_statement` | important | `CONFIRMED` | `needs_design` | não encaminhar até definir a equivalência mista exata |
| `R2-AM2-I001` | A | `false_statement` | important | `CONFIRMED` | `needs_design` | a “lei da órbita no espaço de pares” resolve a órbita ordinária, mas não está autorizada como solução completa |
| `R1-AM-FR2-POINTWISE` | B | `overclaim` | minor | `CONFIRMED` | `safe` | qualificar as bullets com enunciados atômicos/setwise/quase-certamente exatos |
| `R2-AM2-M001` | B | `overclaim` | minor | `CONFIRMED` | `safe` | mesmo reparo local, sem mudar T4 ou o ledger substantivo |

Contagens por source finding: **4 total; 4 CONFIRMED; 0 PARTIAL; 0 REFUTED;
0 UNRESOLVED**. Em termos de defeitos não duplicados: **1 important e 1 minor**.

## 4. Evidência e raciocínio por cluster

### 4.1 Cluster A — Reynolds componentwise versus quociente diagonal

#### Norma e localização

A clarificação, linhas 59–68, exige que a mesma permutação atue no perfil
inteiro. As linhas 79–84 preservam separação por identidade da coalizão quando
ela altera a revelação, e as linhas 88–95 mandam colapsar rotulações e misturas
estéreis. Os resultados definem, nas linhas 951–964,

```text
Anon(Gamma_0,Gamma_1)
  = |G|^{-1} sum_g (g#Gamma_0,g#Gamma_1).
```

Em um espaço vetorial de pares de medidas, essa soma é necessariamente
componentwise:

```text
( |G|^{-1} sum_g g#Gamma_0,
  |G|^{-1} sum_g g#Gamma_1 ).
```

O índice comum `g` não permanece como coordenada observável. Assim, o operador
retém as duas médias marginais, mas perde invariantes relacionais entre os dois
tipos. A frase das linhas 959–964 de que o operador preserva todas as órbitas
economicamente distintas é falsa.

#### Reprodução do contraexemplo R1

Para `N=5`, `m=4`, `k=2`, `beta=.9`, `o_0=.7`, `o_1=.8`, `nu=.5`,
`rho=1`, o ramo `E` é único:

```text
r=.225, A=.55, D_0=.63, D_1=.72.
```

Os perfis de atraso–atraso

```text
P=(delta_y12,delta_y34),
Q=(delta_y12,delta_y13),
y_C=(.8,.1*1_C),
```

são PBEs: qualquer acordo dá no máximo `.55`, enquanto cada tipo obtém seu
valor de rejeição. A enumeração das 24 permutações de `S_4` deu:

```text
orbit_size(P)=6
orbit_size(Q)=24
intersection(orbit(P),orbit(Q))=0
```

O tamanho da interseção das coalizões dos dois tipos é `0` em `P` e `1` em
`Q`, logo nenhuma permutação comum liga os perfis. Apesar disso, cada uma das
três marginais testadas (`C12`, `C34`, `C13`) apareceu exatamente quatro vezes
em cada uma das seis coalizões sob a média de grupo. Portanto o Reynolds
componentwise coincide.

#### Reprodução independente do contraexemplo R2

Para `o_0=.1`, `o_1=.2`, `rho=0`, os cálculos deram:

```text
r_S(0)=.20475, A_S(0)=.5905,
r_P(1)=.1845,  A_P(1)=.631,
O_1(off)=.5905.
```

Logo existem PBEs separating acordo–acordo com parcela comum `.5905`. Pares
de coalizões com interseção `0` e `1` continuam em órbitas diagonais distintas,
mas as duas marginais simetrizadas voltam a ser uniformes sobre as seis
coalizões. O segundo exemplo não depende dos payoffs de atraso do primeiro.

#### Alcance exato

- `Gamma_theta` nas linhas 840–853 permanece uma lei conjunta válida por tipo.
- As marginais e integrais das linhas 867–918 permanecem vinculadas à mesma
  `Gamma_theta`.
- O lema de fechamento das linhas 941–949 permanece correto.
- Falha a identificação `[(Gamma_0,Gamma_1)]_anon` definida por igualdade das
  médias componentwise; portanto `AMX-016` não é uma correspondência de
  assinaturas exata nos bytes atuais.
- Em `AMX-MSB-010`, sobrevive apenas o fechamento sob permutação; é falsa a
  afirmação de que o quociente escrito elimina somente variação estéril.
- T4/`AMX-015` não usam esse operador e não são afetados. As condições de
  membership puro de `AMX-014` também não mudam, embora a partição final em
  classes de assinatura precise ser refeita depois da decisão de desenho.

### 4.2 Cluster B — pointwise versus quase-certamente

#### Norma e localização

A disciplina de Bayes é deliberadamente pointwise em todo o suporte (resultados,
linhas 109–131 e 716–753). Isso não transforma a condição de melhor resposta em
igualdade pointwise. T4, linhas 757–785, distingue corretamente:

```text
u_theta(y)<=V_theta para todo y no suporte,
u_theta(y)=V_theta para sigma_theta-quase todo y.
```

As três primeiras bullets das linhas 803–810 apagam essa distinção ao dizer que
os tipos “usam o sinal” em um ponto individual e ao concluir igualdade de valor
nesse ponto.

#### Reprodução da bullet de acordo

Nos parâmetros `N=5`, `beta=.9`, `o_0=.7`, `o_1=.8`, `nu=.5`, `rho=1`,
o ramo `E` é único e `r=.225`, `A=.55`, `D_0=.63`, `D_1=.72`. Faça os dois
tipos usarem a mesma lei atomless em

```text
y(t)=(.55,.225,.225-t,t,0), 0<=t<=.1.
```

Em `t=0`, dois pagamentos atingem o corte e a proposta passa por `T^Y`, dando
`.55` a ambos os tipos. Para todo `t>0`, apenas um pagamento atinge o corte e a
proposta rejeita, dando `.63` e `.72`. O ponto `t=0` está no suporte, tem
posterior `.5` e massa zero. Assim,

```text
V_0=.63, V_1=.72,
u_0(y(0))=u_1(y(0))=.55.
```

O objeto satisfaz T4: a desigualdade vale em todo o suporte, a igualdade vale
quase certamente e o valor off-support é exatamente o valor de rejeição.

#### Reprodução adicional da bullet de rejeição

O mesmo problema não é exclusivo da primeira bullet. Tome
`beta=.9`, `m=4`, `k=2`, `o_0=.1`, `o_1=.2`. No cutoff `S/P`,

```text
p_SP=.195652174,
r_S(p_SP)=.204309783,
r_P=.1845,
V=A_S(p_SP)=.591380435,
A_P=.631.
```

Em uma curva `t in [0,.02]`, use posterior
`pi(t)=p_SP+.5t`, medida pública uniforme e as densidades bayesianas
`d sigma_1/d lambda=pi/nu`, `d sigma_0/d lambda=(1-pi)/(1-nu)`, onde
`nu=.200652174`. A crença off-support `p_SP` corresponde a
`rho=.969019941`. Use propostas

```text
y(t)=(V,r_P,r_P,t,0).
```

Em `t>0`, o ramo `P` aceita e entrega `V`; em `t=0`, o ramo `S` é inclusivo,
seu corte é maior e a proposta rejeita, entregando apenas `.081` e `.162`.
O ponto excepcional tem massa zero. A folga máxima é `.039619565`, logo toda a
curva é factível. Off-support, o melhor acordo dá exatamente `V`; portanto o
objeto satisfaz T4 e refuta a igualdade pointwise da segunda bullet.

#### Leitura correta da bullet de posterior extremo

Com `sigma_0(dt)=dt` e `sigma_1(dt)=2t dt` numa linha de propostas rejeitadas,
o ponto `t=0` pertence ao suporte topológico de ambas as medidas, mas
`pi(0)=0` e nenhuma delas tem átomo no ponto. Logo “somente o tipo
correspondente usa o sinal” não é uma afirmação pointwise bem formada em suporte
atomless. A consequência correta, para prior interior, é setwise:

```text
sigma_1({y:pi(y)=0})=0,
sigma_0({y:pi(y)=1})=0.
```

Em átomos, pode-se falar pontualmente: se `lambda({y})>0` e
`0<pi(y)<1`, ambos os tipos dão massa positiva ao átomo e as igualdades de
melhor resposta seguem. Fora desse caso, as duas primeiras consequências valem
`lambda`-quase certamente nos conjuntos relevantes. A desigualdade de imitação
do outro tipo continua válida ponto a ponto em todo `S` por T4.

#### T4, AMX-015 e AMX-011

T4 e o texto exato de `AMX-015` sobrevivem porque já exigem desigualdade em todo
o suporte e igualdade apenas `sigma_theta`-quase certamente. `AMX-011` também
sobrevive: seu antecedente é uso de proposta aprovada com probabilidade
positiva, o que exclui o ponto excepcional de massa zero usado nos exemplos.

### 4.3 Teorema cardinal sob o quociente correto

Na família da §9.4, `s(t)=(t,0,0,0,0)` e o kernel uniforme `E` são fixos por
toda permutação dos fracos. Portanto cada dupla `(Gamma_0,Gamma_1)` tem órbita
diagonal singleton. Para

```text
d sigma_1_epsilon(t)=[1+2 epsilon(2t-1)]dt,
```

a estatística invariante

```text
E_{sigma_1_epsilon}[t]=1/2+epsilon/3
```

é estritamente crescente em `epsilon`. Assim, valores distintos de `epsilon`
continuam produzindo assinaturas distintas sob qualquer quociente diagonal
exato. AM-MSB-T6 e `AMX-MSB-009` sobrevivem como teorema somente cardinal; nada
novo é inferido sobre parametrização finita.

## 5. Independência dos pareceres

As declarações de não acesso mútuo são coerentes com os arquivos, mas uma
negação de acesso não é verificável apenas pelos bytes. A independência
processual deve, portanto, ser tratada como documentada, não provada.

A evidência matemática não é uma simples cópia: R1 usa PBEs atraso–atraso com
`o=(.7,.8)`; R2 usa PBEs acordo–acordo com `o=(.1,.2)`. As curvas atomless
também usam parcelas diferentes. Isso sustenta independência evidencial parcial.
Ainda assim, os pares `AM-FR1-ANON`/`AM2-I001` e
`AM-FR2-POINTWISE`/`AM2-M001` são duplicatas diagnósticas e não contam como
quatro defeitos.

Os Clusters A e B são logicamente independentes: o primeiro surge depois da
construção de `Gamma_theta`, no quociente; o segundo surge antes, na passagem de
otimalidade quase-certamente para prosa pointwise. Corrigir qualquer um não
corrige o outro.

## 6. Reparos inseguros e decisões autorais

| Proposta | Avaliação | Razão |
|---|---|---|
| manter o Reynolds componentwise e apenas renomeá-lo “diagonal” | `unsafe` | os dois contraexemplos continuam identificados |
| usar a classe de órbita ordinária da dupla, ou a lei uniforme dessa órbita no espaço de pares | `needs_design` e `owner_decision` | é um invariante completo da ação diagonal ordinária, mas distingue uma estratégia pura de uma mistura não degenerada sobre seus rótulos; isso não implementa automaticamente as linhas 65–66 e 88–90 da clarificação |
| acrescentar uma lei/acoplamento contrafactual entre as randomizações dos dois tipos e anonimizar essa lei | `needs_design` | a dupla de marginais `Gamma_0,Gamma_1` não determina um acoplamento canônico; escolher produto, correlação comum ou outro binder muda o objeto downstream |
| adotar equivalência marginal mais grossa | `owner_decision` | exigiria enfraquecer a decisão explícita de usar a mesma permutação no perfil inteiro e aceitaria a falsa identificação demonstrada |
| substituir as três bullets da §8.3 pelas versões atômica, setwise e quase-certamente acima | `safe` | é consequência direta das identidades de Radon–Nikodym e de T4; não muda equilíbrio, payoff, ledger nem kernel |

O conflito central é concreto. Sob a órbita diagonal ordinária,
`delta_C` e uma mistura não degenerada sobre coalizões da mesma órbita não são
o mesmo ponto do quociente. Sob o Reynolds componentwise, ambas colapsam para a
uniforme, mas pares puros com interseções diferentes também colapsam. O contrato
aprovado pede simultaneamente o mesmo `g` no perfil e o colapso das misturas
sobre identidades; ele não especifica o objeto adicional que faria ambas as
operações coexistirem em medidas mistas.

## 7. Itens não resolvidos

Não há dúvida diagnóstica material: os quatro source findings foram
`CONFIRMED`. Permanecem não resolvidos para implementação:

1. a relação de equivalência exata sobre pares de medidas mistas que reconcilie
   a ação diagonal com o colapso autoral de misturas sobre identidades;
2. se a relação contrafactual entre coalizões escolhidas pelos dois tipos é
   conteúdo downstream ou deve ser descartada por nova decisão;
3. caso seja conteúdo, qual acoplamento/binder a assinatura deve registrar;
4. depois da decisão, o re-corte de `AMX-016` e da segunda metade de
   `AMX-MSB-010`, além da nova revisão das classes de assinatura afetadas.

`A_U`, `AC`, `AR` e o manuscrito continuam fora do escopo. Nada desta
adjudicação autoriza consumo downstream ou implementação.

## 8. Veredito da adjudicação

**`BLOCKED`**.

Há um defeito material confirmado na assinatura exata e nenhum reparo geral
suficientemente definido e autorizado para o domínio misto. O reparo local do
Cluster B pode ser aplicado depois por implementador separado, mas não libera
`AMX-016`, `AMX-MSB-010` nem o consumo por `AC`. A próxima etapa substantiva é
uma decisão/desenho autoral sobre a equivalência anônima; depois disso, um
implementador separado produz novos bytes, novo hash e novas revisões
independentes.
