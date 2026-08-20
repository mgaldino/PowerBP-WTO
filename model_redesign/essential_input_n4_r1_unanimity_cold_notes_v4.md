# N4 v4 — nota fria do reparo multi-veto e da certificação integral

**Nó:** `N4`
**Status:** nota fria de reparo; `N4` permanece `pending/unfrozen`
**Fonte normativa:** Gate 0, especialmente Seções 2, 4--6 e P3--P7
**Única dependência:** N2 congelado em
`sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`
**Candidato v3 que motivou o reparo:**
`sha256:6c199f961ba2b8e1f55719c8d678decf752fb7bcda042bf796a585f2a4278905`

Esta nota foi escrita depois de dois pareceres independentes `FAIL` sobre o
mesmo hash v3. Ambos preservaram toda a álgebra de N4 v3 exceto uma
superinclusão localizada dos atrasos on-path com múltiplos vetos weak; ambos
também demonstraram que a certificação v3 não ligava todas as folhas materiais
à matemática. O reparo abaixo é o único imposto pelos findings. Nenhuma
primitiva, ação, informação, payoff, crença admissível, tie-break, schema ou
topologia é alterado.

## 1. Objetos importados e notação

Há `m>=2` weak states, um proponente e `m-1` weak responders. O ballot de R1
contém H e os `m-1` responders, todos simultâneos e selados. Defina

```text
nu_star = (o1-o0)/(1-o0)
ell     = beta*o0
h       = beta*o1
A       = beta*(1-o0)/m
B       = beta*(1-o1)/m
D       = (1-nu)*A
C       = D, se nu<=nu_star; B, se nu>nu_star
```

N2 fornece exatamente dois registros, já transportados uma vez para R1:

| continuação | posterior | valor subjetivo weak | weak realizado por tipo | H por tipo |
|---|---|---|---|---|
| low-type-only | `0<=eta<=nu_star` | `A*(1-eta)` | `(A,0)` | `(ell,h)` |
| pooling | `nu_star<eta<=1` | `B` | `(B,B)` | `(h,h)` |

Logo todo valor subjetivo weak de continuação pertence a `[B,A]`. Numa falha
on-path não reveladora, Bayes fixa esse valor em `C`.

## 2. Reparo localizado: múltiplos vetos weak on-path

Considere `m>=3`, H0=H1=`yes` e um conjunto rotulado `K` de pelo menos dois
weak responders que votam `no`. O vetor realizado é o mesmo nos dois tipos e
tem probabilidade positiva. Bayes, portanto, fixa seu posterior em `nu`.

### 2.1 Região `nu<nu_star`

O veto de `k in K` paga `C=D>B`. Se `k` trocar unilateralmente para `yes`,
outro veto permanece e a proposta continua falhando. Esse vetor unilateral é
off-path e pode receber pooling, que paga `B`. Assim, no perfil prescrito,
`no` é estritamente melhor que `yes` para cada veto.

Essa desigualdade estrita também impede que `yes` domine fracamente `no` no
stage game completo, independentemente do pagamento pivotal `x_k`. Os
responders fora de `K` podem ser mantidos em `yes` escolhendo uma continuação
menor após seu desvio para `no`. H pode ser mantido em `yes` usando a mesma
continuação low-type-only em seus dois vetores. Portanto:

```text
m>=3, |K|>=2, on-path, nu<nu_star:
  nenhum limite adicional sobre x_k além da factibilidade.
```

### 2.2 Fronteira e região `nu>=nu_star`: necessidade

Na fronteira, `D=B`; acima dela, pooling também dá `C=B`. Para cada veto `k`,
o payoff prescrito é, portanto, `B`. Sua troca unilateral para `yes` ainda
deixa falha e não pode pagar menos que `B`, porque `[B,A]` é todo o intervalo
de valores subjetivos disponível em N2. `No` não pode ser estritamente melhor
no perfil prescrito. Como `T^Y` escolheria `yes` numa indiferença genuína,
`no` só pode sobreviver se eliminar `yes` por stage-undominance.

Stage-undominance compara todos os perfis dos demais votos. Denote por `c(S)`
o valor de continuação quando exatamente o conjunto não vazio `S` de weak
responders veta e H vota `yes`. Para cada `k in K`, a dominância de `no_k`
impõe

```text
c(S union {k}) >= c(S)
```

em toda linha falha-falha. Como `c(K)=B` por Bayes e todo `c(S)>=B`, uma
indução descendente sobre os subconjuntos não vazios de `K` dá `c(S)=B`, em
particular `c({k})=B`. Na linha pivotal de `k`, `yes` aprova a proposta e paga
`x_k`, enquanto `no` leva ao vetor de veto único e paga `B`. Logo a dominância
necessária exige

```text
x_k<=B para cada k in K.
```

### 2.3 Suficiência e igualdade

Fixe `x_k<=B` para todo `k in K`. Nos vetores com H=`yes`, atribua valor weak
`B` a toda falha: no vetor realizado, Bayes seleciona low-type-only na
fronteira e pooling acima dela; nos demais vetores, pooling é admissível
off-path. Nos vetores com H=`no`, use valor `A` exatamente quando todos os
membros de `K` votam `no` e nenhum responder fora de `K` veta; use `B` nos
demais vetores.

Para cada `k in K`, `no_k` paga pelo menos `yes_k` em todas as linhas e é
estritamente melhor na linha H=`no` em que `k` completa `K`. Para cada
responder fora de `K`, `yes` é estritamente melhor na linha H=`no` em que
todos os membros de `K` vetam e ele próprio é o único possível veto adicional.
No perfil realizado, todos os responders fora de `K` são indiferentes e
`T^Y` escolhe `yes`. Acima da fronteira H0 prefere `yes`, pois compara `h` com
`ell`; na fronteira H0 é indiferente em `ell` e usa `T^Y=yes`. H1 é
indiferente em `h` e também usa `T^Y=yes`. A construção satisfaz Bayes no vetor
realizado e demonstra que a desigualdade fraca é exata:

```text
m>=3, |K|>=2, on-path, nu>=nu_star:
  x_k<=B para cada veto k, incluindo x_k=B.
```

Nenhum bound é imposto aos responders que votam `yes`, além da factibilidade.

## 3. Fixture obrigatório

Para

```text
m=3, beta=.9, o0=.2, o1=.6, y_bar=.8, nu=.75,
nu_star=.5, A=.24, B=.12,
(Y,x1,x2,r)=(.10,.30,.30,.30),
```

H vota `yes` nos dois tipos e os dois responders vetam. Bayes fixa o vetor
realizado em pooling, com valor `B=.12`. A condição necessária falha porque
`.30>.12`; o assessment é impossível. Substituindo `x1=x2=.12`, a construção
da Seção 2.3 fornece um assessment válido. O oracle v4 deve reproduzir as duas
conclusões e expor os diagnósticos de dominância e `T^Y`.

## 4. Por que `S3` e as demais famílias não mudam

A punição que estabelece a garantia para `m>=3` ocorre depois de proposta de
probabilidade zero. Nessa história Bayes não fixa o posterior do vetor
realizado. O assessment pode continuar prescrevendo todos os responders em
`no`, H0=`no`, H1=`yes`, pooling no vetor realizado por H0, low-type-only no
vetor realizado por H1 e valores crescentes com o número de vetos. Seu payoff
realizado para o proponente é `(B,0)`. A oferta `Y=0` continua garantindo esse
vetor inferior. Portanto

```text
S3(nu)=(1-nu)*B
```

permanece um máximo atingido. O reparo on-path não altera o conjunto de
ameaças após propostas zero-probabilidade.

Também permanecem, conforme rechecado nos dois pareceres:

- as classes puras exaustivas `P`, `L` apenas em `nu=0`, e `D`;
- a inexistência de high-only e de separação de H com veto weak;
- pisos `x_j>=B` em P/L e o bound `x_k<=C` no veto weak único;
- H-veto, inclusive o bound `x>=B` em `m=2,nu>=nu_star`;
- `S2=max{R0,RL,RP}`, todos os endpoints, attainment, `H_tie` e pooling caps;
- pooling universal, delay universal para `m>=3` e delay `C>=S2` para `m=2`;
- misturas L/D e P/D somente nos loci já derivados;
- multiplicidade completa por identidade, vetores weak type-conditioned,
  coordenadas em `nu=0`, folga e payoffs de H.

## 5. Certificação v4

O candidato v4 preservará a estrutura pública e a forma de representação da
interface v3: os mesmos campos de `equilibrium_correspondence_v1`, as mesmas
categorias e as mesmas descrições legíveis, exceto pelo reparo multi-veto e
pelas referências de versão. A certificação é uma camada separada; ela não
converte a interface em uma nova linguagem normativa nem exige alteração dos
consumidores N6/N7.

O validador tratará cada folha conforme sua função semântica. Fórmulas e
predicados, inclusive os que aparecem dentro de sentenças controladas, serão
analisados em AST e normal form. Sentenças institucionais serão consumidas por
uma gramática integral ancorada, que rejeita texto residual não interpretado e
produz uma regra semântica; IDs, hashes, caminhos, estados e enums serão
validados estruturalmente. Assim, uma folha não recebe PASS por mera presença
de token, por blacklist ou por coincidência numérica em fixtures.

O validador v4 deve:

1. analisar integralmente cada fórmula, predicado ou sentença controlada com
   gramática restrita e rejeitar qualquer resíduo não consumido;
2. comparar seu normal form estrutural à regra independente derivada nesta
   nota e no contrato, sem avaliar apenas grids numéricos;
3. registrar exatamente uma certificação por folha escalar e falhar diante de
   folha descoberta ou certificada duas vezes;
4. validar claims do ledger como regras formais, não por busca de palavras;
5. rejeitar corrupção coordenada de candidato, builder e pins, inclusive
   autonegações e polinômios que zeram em fixtures publicados;
6. executar o builder em dois subprocessos R reais como teste adicional de
   reprodutibilidade, sem confundir identidade de bytes com validade semântica.

O oracle e o validador não leem, não executam e não importam o builder. Um
guard estático pode demonstrar ausência de importação em runtime; sua mensagem
não deve alegar que inspeção lexical prova independência autoral ou ausência de
código semanticamente equivalente.

## 6. Fronteira de parada

O schema corrente comporta a correção por restrições paramétricas já aninhadas
em `strategy_profile`; nenhum campo novo de interface é necessário. Não foi
encontrada nova família, ambiguidade ou pluralidade de reparos. Qualquer fato
novo dessa natureza interrompe N4 v4 sob a Seção 11.1. N4 não é congelado por
esta nota e não autoriza N6, N7, Goal 5, PDF ou manuscrito.
