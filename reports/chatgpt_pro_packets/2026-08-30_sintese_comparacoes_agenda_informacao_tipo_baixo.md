# Síntese das comparações entre agenda, informação e regra de votação

**Data:** 30 de agosto de 2026  
**Foco substantivo:** renda informacional do tipo baixo de `H`  
**Orientação das comparações institucionais:** unanimidade menos maioria (`U-M`)  
**Natureza:** nota técnica autocontida; reorganiza resultados já derivados e distingue o que está fechado do que permanece como correspondência. Não é um novo parecer formal nem uma nova seleção de equilíbrio.

## 1. Resposta executiva

Sim, temos a comparação relevante entre as rendas informacionais sob
unanimidade e maioria. Ela existe de forma **exata e membro a membro**, mas em
geral é uma correspondência, não um único número.

Para um par comparável de equilíbrios privados, defina

```text
delta_0 = V_U^0-V_M^0,
DeltaRI_0 = RI_U^{A,0}-RI_M^{A,0},
G(o_0)=h_M(o_0)-h_U(o_0).
```

A identidade já provada é

```text
delta_0=-G(o_0)+DeltaRI_0,
DeltaRI_0=delta_0+G(o_0).
```

Portanto, não é necessário assinar `RI_M^{A,0}` isoladamente para recuperar o
diferencial informacional. `A_C` fornece o conjunto exato de valores privados
`delta_0`; `A_R` fornece o escalar fechado `G(o_0)`; somar esse escalar a cada
membro de `delta_0` produz a correspondência exata `DeltaRI_0`.

O que **não** temos é um sinal único de `DeltaRI_0` válido para toda primitiva
e toda seleção admissível. A multiplicidade de maioria permanece econômica e
matematicamente relevante.

O achado mais forte para o tipo baixo é o seguinte. Se

```text
G(o_0)>0,
```

então informação completa favorece maioria. Se, apesar disso, um membro do
jogo privado satisfaz `delta_0>0`, a renda informacional relativa é
necessariamente positiva e suficientemente grande para inverter o ranking:

```text
DeltaRI_0>G(o_0)>0.
```

Nessa região, a informação não é uma explicação secundária. Ela é a única
força que aponta para unanimidade e precisa primeiro compensar a vantagem que
maioria teria se o tipo baixo fosse conhecido.

## 2. Objetos e datas

Há `m=N-1>=3` Estados fracos. Sob maioria, `H` precisa de `k=q-1` votos fracos e
pode excluir

```text
c=m-k
```

Estados fracos. O fator de desconto é `beta in (0,1)`. O tipo de `H` é
`theta in {0,1}`, com

```text
0<o_0<o_1<1.
```

O tipo `0` é o tipo baixo: sua opção externa é menor. O tipo `1` é o tipo alto.
A renda informacional positiva que interessa ao argumento substantivo pertence
ao tipo baixo, porque ele pode ser confundido com o tipo alto.

O estágio obrigatório de agenda, quando existe, ocorre na data `A`. Se a
proposta falha, o jogo entra em `R1` uma data depois. Valores nativos de `R1`
são transportados para `A` por exatamente um fator `beta`.

## 3. Mapa das comparações

| Pergunta | Objeto | Fórmula | Interpretação |
|---|---|---|---|
| Qual regra dá mais a `H` quando o tipo é público e há agenda? | comparação institucional pública | `h_U(o_theta)-h_M(o_theta)=-G(o_theta)` | efeito da regra sem sinalização |
| Quanto a informação privada altera o payoff dentro de uma regra com agenda? | renda informacional com agenda | `RI_g^{A,theta}=V_g^{A,theta}-h_g(o_theta)` | payoff privado menos benchmark do próprio tipo público |
| Qual regra produz maior renda informacional? | diferencial informacional | `DeltaRI_theta=RI_U^{A,theta}-RI_M^{A,theta}` | vantagem informacional relativa de unanimidade |
| Qual regra dá maior payoff no jogo privado com agenda? | comparação institucional privada | `delta_theta=V_U^theta-V_M^theta=-G(o_theta)+DeltaRI_theta` | soma da parte sem sinalização e da parte informacional |
| Qual é o efeito causal da etapa de agenda sob informação completa? | efeito direto da agenda | `D_g=h_g^A-beta*h_g^N` | com agenda menos sem agenda, mantendo informação completa |
| Qual é o efeito causal da etapa de agenda sob informação privada? | efeito total da agenda | `T_g=V_g^A-beta*V_g^N` | com agenda menos informação apenas |
| Como informação privada altera o efeito da agenda? | interação agenda × informação | `I_g=RI_g^A-beta*RI_g^N` | diferença entre o efeito total e o efeito direto |
| Sob qual regra agenda vale mais? | diferença institucional dos efeitos | `DeltaT=DeltaD+DeltaI` | efeito da agenda em `U` menos efeito da agenda em `M` |
| Agenda com informação completa é melhor que informação privada sem agenda? | contraste diagonal | `Q_g=h_g^A-beta*V_g^N` | muda simultaneamente agenda e informação; não é efeito causal puro |

Esses objetos não são sinônimos. Em especial, `delta_theta` compara regras no
mesmo jogo privado, enquanto `T_g` compara presença e ausência de agenda dentro
da mesma regra.

Quando for útil acompanhar a notação usada na consulta externa, escrevemos

```text
Lambda_A(o_theta)=h_U(o_theta)-h_M(o_theta)=-G(o_theta).
```

## 4. Comparação institucional quando o tipo é público

O termo “público” significa somente que o tipo de `H` é conhecido antes da
proposta. Não significa bem público nem publicidade das propostas.

Sob unanimidade,

```text
h_U(o)=1-beta+beta^2*o.
```

Sob maioria, defina

```text
Z_E=1-k*beta/m.
```

Então

```text
h_M(o)=1-k*beta*(1-beta*o)/m,  se o<=1/m;
h_M(o)=max{Z_E,beta*o},        se o>1/m.
```

Escrevendo a vantagem pública de maioria como

```text
G(o)=h_M(o)-h_U(o),
```

temos

```text
G(o)=beta*(c/m)*(1-beta*o),
       se o<=1/m;

G(o)=beta*(c/m-beta*o),
       se o>1/m e beta*o<=Z_E;

G(o)=(1-beta)*(beta*o-1),
       se o>1/m e beta*o>=Z_E.
```

Consequentemente:

1. se `o<=1/m`, maioria favorece estritamente `H`;
2. se `o>1/m`, o sinal de `G(o)` é o sinal de `c/m-beta*o`;
3. unanimidade favorece o tipo público quando `beta*o>c/m`;
4. no ramo em que maioria induz atraso, unanimidade continua produzindo acordo
   imediato e preserva uma vantagem positiva para `H`.

Para o tipo baixo, o caso substantivamente central é

```text
G(o_0)>0.
```

Nesse caso, se seu tipo fosse conhecido, ele preferiria maioria.

## 5. Renda informacional do tipo baixo sob unanimidade

Defina

```text
nu_star=(o_1-o_0)/(1-o_0),
z_L=1-beta+beta^2*o_0,
z_H=1-beta+beta^2*o_1,
d_H=beta^2*o_1,
D_2=z_H-z_L=beta^2*(o_1-o_0),
u_min=max{z_L,d_H}.
```

Nas tabelas abaixo, `rho` resume a razão off-path aprovada pelo protocolo
M/S/B; `rho=0` fixa a crença off-path no tipo baixo. As células são sempre as
fibras admissíveis do contrato, não escolhas feitas por esta nota.

O resultado de incidência é

```text
RI_U^{A,0}>=0,
RI_U^{A,1}<=0
```

em toda fibra existente. Economicamente, a renda positiva pertence ao tipo
baixo; a coordenada do tipo alto registra indiferença ou custo informacional.

As células de unanimidade são:

| Fibra | `RI_U^{A,0}` | Leitura |
|---|---:|---|
| `nu=0` | `0` | não há ganho informacional realizado no endpoint baixo |
| `0<nu<=nu_star`, célula existente com `rho=0` | `0` | a renda positiva ainda não aparece para o tipo baixo |
| `nu_star<nu<1`, `rho=0` | `u-z_L`, com `u in [u_min,z_H]` | intervalo entre `u_min-z_L` e `D_2` |
| prior alto, crença off-path alta | `D_2` | renda máxima do tipo baixo |
| `nu=1` | `D_2` na coordenada contrafactual baixa | tipo baixo tem probabilidade zero, mas a coordenada permanece definida |
| células sem PBE requerido | `none` | renda não definida, nunca igualada artificialmente a zero |

O maior valor possível sob unanimidade é

```text
D_2=beta^2*(o_1-o_0).
```

Isso mostra por que `o_1` alto importa para o tipo baixo: ele não melhora o
benchmark público do tipo baixo, que depende de `o_0`; ele aumenta a diferença
entre os tipos e, portanto, o valor de o tipo baixo ser confundido com o alto.

## 6. Renda informacional sob maioria

Para cada binder privado completo `R_M` de maioria,

```text
RI_M^{A,0}(R_M)=V_M^0(R_M)-h_M(o_0).
```

A correspondência completa de `A_M` está disponível e preserva pooling,
separação, acordo, atraso, misturas, crenças e continuações. Por isso,
`RI_M^{A,0}` pode ser calculada para cada membro. O que não está autorizado é
substituir essa correspondência por um equilíbrio conveniente ou atribuir-lhe
um único sinal global.

Se o objetivo for somente o diferencial institucional da renda, não é
necessário assinar `RI_M^{A,0}` separadamente. Tome o conjunto exato de pares
comparáveis

```text
J_AC^{bind}(d,eta)
```

onde `d` é o vetor de primitivas e `eta` identifica a mesma fibra admissível de
prior, crença off-path e continuação nos dois jogos.

e defina

```text
Dpriv_0(d,eta)
 ={V_U^0(R_U)-V_M^0(R_M):
   (R_M,R_U) in J_AC^{bind}(d,eta)}.
```

Então a correspondência exata do diferencial informacional é simplesmente

```text
DeltaRI_0(d,eta)=Dpriv_0(d,eta)+G(o_0).
```

A soma acima é uma translação de cada membro pelo mesmo escalar. Ela não
recombina coordenadas de tipos, não escolhe equilíbrios e não introduz um
sorteio comum entre jogos contrafactuais.

## 7. Quando a informação carrega a preferência do tipo baixo

Para cada membro comparável,

```text
delta_0=-G(o_0)+DeltaRI_0.
```

Há três regiões.

### 7.1 Informação completa favorece maioria: `G(o_0)>0`

Unanimidade é preferida no jogo privado se e somente se

```text
DeltaRI_0>G(o_0).
```

Se isso ocorre, a renda informacional relativa:

- é positiva;
- é necessária para o sinal de `delta_0`;
- compensa integralmente a vantagem pública de maioria;
- ainda deixa um excedente líquido igual a `delta_0`.

Sua contribuição bruta excede o ganho líquido:

```text
DeltaRI_0/delta_0
 =1+G(o_0)/delta_0
 >1.
```

Falar em contribuição superior a 100% não é contabilidade dupla. Parte da
renda informacional neutraliza o componente público negativo antes de gerar a
vantagem líquida da unanimidade.

### 7.2 Empate público: `G(o_0)=0`

Nesse caso,

```text
delta_0=DeltaRI_0.
```

Toda preferência estrita entre as regras é informacional.

### 7.3 Informação completa favorece unanimidade: `G(o_0)<0`

Agora `-G(o_0)>0`. A unanimidade já possui vantagem sem informação privada. O
diferencial informacional pode reforçar, deixar inalterada, reduzir ou reverter
essa vantagem. Nessa região não se pode dizer, apenas pelo sinal de `delta_0`,
que informação é a fonte necessária da preferência.

## 8. Critérios robustos com multiplicidade

Seja `DeltaRIset_0` o conjunto exato dos diferenciais informacionais na fibra.
Os critérios corretos são:

| Afirmação | Condição setwise |
|---|---|
| informação reforça unanimidade em todo membro | `DeltaRIset_0 subset (0,infinity)` |
| informação é neutra em todo membro | `DeltaRIset_0={0}` |
| informação favorece relativamente maioria em todo membro | `DeltaRIset_0 subset (-infinity,0)` |
| tipo baixo prefere unanimidade em todo membro | `DeltaRIset_0 subset (G(o_0),infinity)` |
| tipo baixo prefere maioria em todo membro | `DeltaRIset_0 subset (-infinity,G(o_0))` |
| há empate institucional em algum membro | `G(o_0) in DeltaRIset_0` |
| ranking depende da seleção | o conjunto cruza `G(o_0)` |
| comparação não existe no conceito mantido | a fibra comparável é `none` |

Portanto, temos a comparação exata e o teste de sinal. O passo ainda não
realizado é reduzir todas as fibras e primitivas a um mapa global fechado de
regiões nas quais essas inclusões valem. Esse seria um novo corolário de
classificação, não um reparo de uma lacuna algébrica.

Uma medida útil da força do mecanismo na região `G(o_0)>0` é

```text
kappa_0=DeltaRI_0/G(o_0).
```

Então:

- `kappa_0>1`: unanimidade vence por causa da informação;
- `kappa_0=1`: empate institucional;
- `0<kappa_0<1`: informação favorece unanimidade, mas não basta para superar
  a vantagem pública de maioria;
- `kappa_0<=0`: informação não favorece unanimidade.

Com multiplicidade, `kappa_0` também é uma correspondência.

## 9. Comparação ex ante

O contraste ex ante preserva o vetor ligado por tipos:

```text
delta_E=(1-nu)*delta_0+nu*delta_1
       =-G_E+DeltaRI_E,

G_E=(1-nu)*G(o_0)+nu*G(o_1),
DeltaRI_E=(1-nu)*DeltaRI_0+nu*DeltaRI_1.
```

A renda positiva sob unanimidade pertence ao tipo baixo. O peso `1-nu`
determina quanto essa renda entra no payoff ex ante. O tipo alto não recebe a
renda positiva do mecanismo; sua coordenada sob unanimidade é zero ou
negativa relativamente ao benchmark em que seu tipo é conhecido.

Assim, `o_1` alto exerce dois papéis distintos:

1. pode tornar o componente público do tipo alto favorável à unanimidade;
2. amplia `o_1-o_0` e, portanto, a renda que o tipo baixo pode obter por ser
   confundido com o alto.

Esses canais não devem ser agregados antes de calcular os payoffs por tipo.

## 10. Efeito causal da etapa de agenda

As comparações anteriores perguntam qual regra é melhor. Uma pergunta distinta
é quanto a introdução da etapa obrigatória de agenda altera o payoff dentro de
cada regra.

### 10.1 Informação completa

Defina

```text
D_g(o)=h_g^A(o)-beta*h_g^{N,R1}(o).
```

Sob unanimidade,

```text
D_U(o)=1-beta>0.
```

Sob maioria, com

```text
tau_M=Z_E/beta,
```

temos

```text
D_M(o)=Z_E-(c/m)*beta^2*o,  se o<=1/m;
D_M(o)=Z_E-beta*o,          se 1/m<o<tau_M;
D_M(o)=0,                   se o>=tau_M.
```

Portanto, agenda nunca reduz o payoff público de `H` sob maioria, mas pode
deixar de ter valor quando `H` usa a proposta obrigatória para induzir o mesmo
atraso que ocorreria sem a etapa de agenda.

A diferença entre regras é

```text
DeltaD(o)=D_U(o)-D_M(o)
 =-beta*(c/m)*(1-beta*o),  se o<=1/m;
 = beta*(o-c/m),          se 1/m<o<=tau_M;
 = 1-beta,                se o>=tau_M.
```

Logo maioria converte melhor agenda em payoff quando `o` é baixo; unanimidade
converte melhor quando `o` é suficientemente alto.

### 10.2 Informação privada: agenda versus informação apenas

O efeito total é

```text
T_g^theta=V_g^{A,theta}-beta*V_g^{N,R1,theta}.
```

Ele se decompõe em

```text
T_g^theta=D_g^theta+I_g^theta,
I_g^theta=RI_g^{A,theta}-beta*RI_g^{N,R1,theta}.
```

Sob unanimidade, em toda célula na qual tratamento e controle existem, agenda
beneficia fracamente cada tipo. Sob maioria, o efeito permanece set-valued e
seu sinal depende da interação informacional:

```text
T_M^theta>0  sse I_M^theta>-D_M(o_theta).
```

Quando `o_theta>=tau_M`, `D_M(o_theta)=0`; nessa região, todo o efeito total de
agenda sob maioria vem da interação com a informação.

O limiar `tau_M` pode ser maior ou igual a `1`; nesse caso, o ramo
`o>=tau_M` é vazio no domínio admissível `o in (0,1)`.

### 10.3 Sob qual regra agenda beneficia mais `H`?

Defina

```text
DeltaT^theta=T_U^theta-T_M^theta,
DeltaI^theta=I_U^theta-I_M^theta.
```

Então

```text
DeltaT^theta=DeltaD^theta+DeltaI^theta.
```

Assim:

- se `DeltaD<0`, a interação precisa ser suficientemente favorável à
  unanimidade para inverter a vantagem direta de maioria;
- se `DeltaD>0`, a interação pode reforçar, reduzir ou reverter a vantagem
  direta da unanimidade;
- se `DeltaD=0`, a interação decide sozinha.

## 11. Agenda apenas versus informação apenas

O contraste diagonal é

```text
Q_g^theta=h_g^A(o_theta)-beta*V_g^{N,R1,theta}
         =D_g^theta-beta*RI_g^{N,R1,theta}.
```

Ele compara `(agenda, informação completa)` com `(sem agenda, informação
privada)`. Como dois fatores mudam simultaneamente, `Q_g` não é um efeito causal
puro de agenda nem um efeito causal puro de informação.

Esse objeto pode existir em células nas quais `T_g` é `none`, porque `T_g`
exige o braço privado com agenda, enquanto `Q_g` não o utiliza.

## 12. O que podemos afirmar agora

### Afirmações fechadas

1. O benchmark público institucional `G(o)` possui forma fechada.
2. A renda positiva sob unanimidade pertence ao tipo baixo.
3. Sua escala máxima é `beta^2*(o_1-o_0)`.
4. A comparação relativa de rendas existe exatamente como
   `DeltaRI_0=delta_0+G(o_0)`.
5. Se `G(o_0)>0` e o tipo baixo prefere unanimidade, o diferencial
   informacional é necessário, positivo e maior que a vantagem pública de
   maioria.
6. Todos os rankings robustos devem ser enunciados por inclusão do conjunto
   exato, nunca pela escolha silenciosa de um equilíbrio.
7. O efeito causal da agenda é `T=D+I`; a interação isolada não é o efeito
   total.

### O que permanece dependente da correspondência

1. O sinal global de `RI_M^{A,0}`.
2. O sinal global de `DeltaRI_0` em todas as primitivas.
3. O sinal de `T_M`, `DeltaT` e `Q_M` quando suas fontes são múltiplas.
4. Uma partição fechada de todo o espaço de parâmetros segundo a parcela da
   preferência institucional atribuível à informação.

Esses itens não são ausência da comparação. São consequências de preservar a
correspondência completa em vez de impor uma seleção adicional.

## 13. Formulação substantiva recomendada

> Quando a opção externa do tipo baixo é suficientemente pequena, maioria lhe
> daria um payoff maior se seu tipo fosse conhecido, porque permite comprar uma
> coalizão menor. A informação privada pode inverter esse ranking. Sob
> unanimidade, os Estados fracos não podem substituir a aprovação de `H` e
> precisam negociar sem saber se enfrentam o tipo baixo ou o alto. O tipo baixo
> pode então ser tratado como se tivesse a opção externa mais forte. Sempre que
> ele prefere unanimidade numa região em que o benchmark público favorece
> maioria, o diferencial informacional não é secundário: é a força que compensa
> integralmente a vantagem pública de maioria e produz a vantagem líquida da
> unanimidade.

Essa formulação não afirma que toda seleção produz o mesmo ranking. Ela diz o
que necessariamente carrega qualquer membro no qual o tipo baixo prefere
unanimidade sob `G(o_0)>0`.

## 14. Status e referências formais

| Componente | Fonte principal | Estado relevante em 30/08/2026 |
|---|---|---|
| comparação privada `U-M` | [`agenda_extension_AC_msb_results.md`](../../model_redesign/agenda_extension_AC_msb_results.md) | `A_C pass/frozen` |
| benchmarks públicos, rendas e `DeltaRI` | [`agenda_extension_AR_msb_results.md`](../../model_redesign/agenda_extension_AR_msb_results.md) | `A_R pass/frozen` |
| contrato de rendas e datas | [`agenda_extension_AR_msb_contract.md`](../../model_redesign/agenda_extension_AR_msb_contract.md) | bytes cobertos pelo congelamento de `A_R` |
| efeito total da agenda `T=D+I` | [`agenda_extension_AT_msb_results.md`](../../model_redesign/agenda_extension_AT_msb_results.md) | `reviewed/unfrozen`; aprovação autoral terminal pendente |
| estado formal de `A_T` | [`2026-08-30_AT_msb_reviewed_status.md`](../../quality_reports/2026-08-30_AT_msb_reviewed_status.md) | dois pareceres `PASS 0/0/0`; sem congelamento |
| consulta externa sobre `A_T` | [`2026-08-30_consulta_tecnica_externa_nao_formal_chatgpt_AT_msb.md`](../../quality_reports/external_reviews/2026-08-30_consulta_tecnica_externa_nao_formal_chatgpt_AT_msb.md) | favorável; não substitui revisão formal |
| adjudicação da consulta externa | [`adjudication_round1.md`](../../quality_reports/adjudication/A_T_msb_external_chatgpt/be8831a5ec59/adjudication_round1.md) | sem defeito matemático; reparos expositivos e corolários ainda não implementados |

Esta nota não altera nenhum desses estados. Em particular, não congela `A_T`,
não seleciona um PBE e não autoriza migração ao manuscrito.
