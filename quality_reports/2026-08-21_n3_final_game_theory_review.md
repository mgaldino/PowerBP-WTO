# Parecer final independente de N3 — teoria dos jogos

**reviewer_role:** `game_theory`  
**reviewer_id:** `codex-game-theory-n3-final-20260821`  
**independência:** revisor read-only dos candidatos; não implementou nem editou nenhum artefato submetido  
**escopo:** ciclo próprio de `N3` apenas; nenhuma revisão substantiva de `N4`  
**manifesto revisado:** `sha256:90d6d8bfc4f1ef18c7edf5f9e1ea08870aec0385e625573e31b1b63a5a3d2bd4`  
**interface N3 revisada:** `sha256:ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`  
**dependência N1 consumida:** `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` (`N1-EQ-01`)  
**veredicto:** `PASS`  
**finding_counts:** `critical=0; major=0; minor=0`

## 1. Integridade, independência e escopo

Revisei a worktree
`/private/tmp/PowerBayesianPersuasion-essential-input-solution-concept`, na
branch `codex/essential-input-solution-concept-rederive` e no `HEAD`
`a6fd6bd543e9cefd4166581b80565916509e95a6`.

Antes de avaliar a matemática, confirmei:

- o SHA-256 do próprio manifesto:
  `90d6d8bfc4f1ef18c7edf5f9e1ea08870aec0385e625573e31b1b63a5a3d2bd4`;
- o SHA-256 da interface N3:
  `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`;
- todas as oito entradas do manifesto com `shasum -a 256 -c`, sem
  divergência;
- o SHA-256 da continuação N1 consumida:
  `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`.

Os objetos exatos abrangidos pelo manifesto foram:

| Objeto | SHA-256 |
|---|---|
| interface N1 | `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` |
| decisão/errata de conceito de solução | `94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69` |
| derivação N3 em Markdown | `75931253fd04303420b2d17552f60d9ee6fc2bf108f8b7ff03ada2eeed9201d3` |
| interface N3 em JSON | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| ledger N3 | `70e42a39cd4ac7f66820647933e6da8669a14b036b591e04d3dba3381b1c4a67` |
| matriz de sobrevivência | `90e2a467d38453a9cad5942da90d95e3cba9e064761b85adf44d0a3759c0577c` |
| relatório consolidado | `1b324c0eb0e03e8c42aa9494dcfbbc1e3c69947a2dfa92d3a92f33783ba4eba8` |
| verificador dirigido | `90c30f217e9c87251905ddd213a2d6ddb5207dd591692ac745c5563e4dce590c` |

Li integralmente `AGENTS.md`, o contrato Gate 0, a decisão/errata de
2026-08-21, o manifesto e todos os arquivos nele listados. Li também o registro
de reparo de `FD-SUP-MIN-01`, unicamente para conferir o fechamento solicitado.
Não usei N4 para sustentar nenhuma conclusão sobre N3.

## 2. Reconstrução adversarial desde N1 e as primitivas

### 2.1 Continuação e unidades temporais

N1 entrega, em unidades de R2, `1/m` a cada Estado fraco antes do
reconhecimento e `o_theta` ao tipo `theta` de `H`. A única conversão para R1 é

```text
w       = beta/m,
t_theta = beta*o_theta.
```

Não há `beta` dentro de N1 nem segundo desconto ao consumir a continuação. Em
contraste, quando uma proposta de R1 passa sem `H`, seu `não` preserva
`y+o_theta` na data corrente, sem desconto. A interface, o Markdown e o ledger
mantêm essa distinção em todos os ramos.

### 2.2 Ballot simultâneo e melhores respostas

Seja `k` o número de weak responders cuja oferta satisfaz `x_j>=w`. Pela regra
autoral as-if-pivotal, cada weak responder compara `x_j` com `w` condicionalmente
a decidir o resultado. Assim, vota `sim` se e somente se `x_j>=w`; em igualdade,
`T^Y` fecha a escolha em `sim`. A continuação N1 é posterior-invariante, logo
um vetor público distinto depois de um voto não pivotal não altera essa
comparação.

Para `H`, a reconstrução proposta por proposta produz exatamente três casos:

1. `k>=q-1`: o bloco fraco já aprova. O payoff de `sim` é `y`; o de `não` é
   `y+o_theta`. Como `o_theta>0`, ambos os tipos votam `não` estritamente. Este
   é o ramo não pivotal que uma contabilidade incorreta costuma perder.
2. `k=q-2`: `H` é pivotal. `Sim` paga `y`; `não` leva a N1 e paga
   `t_theta`. Portanto o tipo `theta` vota `sim` se e somente se
   `y>=t_theta`, com `T^Y` na igualdade.
3. `k<=q-3`: mesmo o `sim` de `H` não aprova. Ambos os votos levam à mesma
   continuação `t_theta`; `T^Y` prescreve `sim`.

Esses casos usam o ballot simultâneo: `H` não observa o vetor de votos antes de
agir e não recebe uma segunda oportunidade de decisão.

### 2.3 Exaustividade de exclusão, screening, pooling e rejeição

Substituindo as melhores respostas acima na função objetivo do proponente,
obtém-se, antes de aplicar qualquer rótulo:

```text
k>=q-1:  r_i;
k=q-2:   (1-nu)[r_i se y>=t_0, senão w]
          + nu[r_i se y>=t_1, senão w];
k<=q-3:  w.
```

Minimizar o custo dentro de cada classe e usar a pie inteira reduz a escolha a

```text
E       = 1-(q-1)w,
L       = 1-(q-2)w-t_0,
S(nu)   = (1-nu)L+nu*w,
P       = 1-(q-2)w-t_1,
R       = w.
```

- exclusão compra exatamente `q-1` weak responders a `w`, fixa `y=0` e deixa
  `E` ao proponente;
- screening compra exatamente `q-2`, fixa `y=t_0`, passa com o tipo baixo e
  chega a N1 com o alto;
- pooling compra exatamente `q-2`, fixa `y=t_1` e passa com ambos;
- qualquer classe que falha para todo tipo de probabilidade positiva rende
  `R=w`.

Não existe classe aceita apenas pelo tipo alto, pois ela exigiria
simultaneamente `y<t_0` e `y>=t_1`, enquanto `t_0<t_1`. Também não existe outro
valor ótimo dentro das três classes de aprovação: pagamento fraco acima de
`w`, concessão a `H` acima do cutoff aplicável ou compra de votante redundante
reduz estritamente o residual sem mudar a decisão relevante.

A rejeição deliberada é eliminada, e não presumida, porque

```text
E-R = 1-beta*q/m > 0.
```

Aqui `q<=m` e `beta<1`, inclusive no caso mínimo `N=3`, em que `m=q=2`.

### 2.4 Factibilidade, uso da pie e hedge

Exclusão é sempre factível. Os candidatos condicionais não são usados fora de
seu domínio factível:

- `S>=E` implica `o_0<=1/m` — estritamente quando `nu>0` — e, portanto,
  `t_0+(q-2)w<=beta(q-1)/m<1`;
- `P>=E` equivale a `o_1<=1/m` e implica
  `t_1+(q-2)w<=beta(q-1)/m<1`.

Assim, escrever o valor selecionável como o máximo das três expressões não
permite que um candidato infactível vença.

P0 está satisfeito sem converter a desigualdade orçamentária em primitiva:
aumentar apenas `r_i` preserva proposta, votos e crenças e melhora todo estado
em que há aprovação; as classes que nunca aprovam não são selecionadas porque
`E>R`.

P1 e P1a também são demonstradas. Dada uma aprovação sem `H` com `y>0`, a
proposta que preserva todos os `x_j`, reduz `y` a zero e soma `y` a `r_i`
continua factível, mantém os votos fracos decisivos e mantém `H` não pivotal.
Ela melhora estritamente o proponente. Logo nenhuma aprovação on-path sem `H`
mantém concessão positiva; a exclusão com `y=0` permanece.

### 2.5 Fronteiras e desempates

As identidades básicas conferidas são

```text
P-E = beta(1/m-o_1),

S-E = (1-nu)beta(1/m-o_0)
      - nu(1-beta*q/m).
```

Quando `o_0<1/m`, a única raiz de `S-E` é

```text
nu_SE = beta(1/m-o_0)
        / [beta(1/m-o_0)+1-beta*q/m].
```

Quando `o_1<1/m`, pooling já domina exclusão e a única raiz relevante de
`S-P` é

```text
nu_SP = beta(o_1-o_0)
        / [1-beta*o_0-beta(q-1)/m].
```

Nesse domínio, o denominador é positivo e excede o numerador; logo
`nu_SP` pertence estritamente a `(0,1)`. A fórmula não é extrapolada para um
domínio em que pooling não pode vencer exclusão.

Essas comparações reproduzem, sem lacuna, as cinco regiões registradas:

1. `o_1<1/m`: screening até `nu_SP`, inclusive, e pooling depois;
2. `o_0<1/m<o_1`: screening até `nu_SE`, inclusive, e exclusão depois;
3. `1/m<o_0<o_1`: exclusão em todo o intervalo;
4. `o_0=1/m<o_1`: screening apenas em `nu=0`, exclusão para `nu>0`;
5. `o_0<o_1=1/m`: screening até `nu_SE`, inclusive; depois, o valor do
   proponente empata entre exclusão e pooling e o desempate autorizado compara
   seus payoffs esperados para `H`.

Nos empates `S=E`, screening dá a `H` exatamente `beta` vezes o payoff de
exclusão e é estritamente preferido pelo desempate. Nos empates `S=P` do
domínio relevante, `nu<1` e o payoff esperado de `H` sob screening é
estritamente menor. No empate triplo, ambos os argumentos valem. Acima da
fronteira de screening quando `o_1=1/m`, exclusão e pooling só permanecem
juntos — inclusive em misturas — se também empatam no payoff esperado de `H`.

## 3. Crenças, suporte e obrigação P7

O candidato implementa a decisão posterior ao contrato:

- proposta ou voto de weak state, inclusive desvio, não move `nu`;
- voto prescrito de `H` atualiza por Bayes quando o denominador é positivo;
- ação de `H` fora do perfil permite posterior livre em `[0,1]` apenas quando
  o prior de entrada é interior;
- em `nu=0`, todo posterior fica em zero; em `nu=1`, todo posterior fica em um.

Examinei todos os campos de crença da interface N3 e as construções off-path do
Markdown. Nenhuma delas atribui probabilidade positiva, nos endpoints, ao tipo
que tem probabilidade a priori zero. Portanto a verificação obrigatória de
suporte para N3 é satisfeita.

O registro histórico de N1 descreve uma classe mais ampla de crenças off-path.
Isso não contamina N3: o assessment N3 é explicitamente intersectado com a
decisão/errata autoral, enquanto a estratégia, o outcome e todos os payoffs de
`N1-EQ-01` são invariantes ao posterior. N3 consome apenas essas coordenadas
invariantes e mantém o identificador e o hash exatos da continuação.

P7 também está satisfeita: o voto público de `H` aparece no sistema de crenças;
ele separa apenas quando a estratégia derivada separa, e crenças fora do perfil
são tratadas separadamente. Nenhum resultado econômico de N3 depende de impor
uma atualização adicional depois de uma ação fraca.

## 4. Multiplicidade e vínculo atômico

A multiplicidade não foi eliminada por anonimização. Para cada proponente
identificado `i`, o artefato permite uma distribuição própria `F_i` sobre seu
conjunto de propostas lexicograficamente ótimas `A_i^*(nu)`. Logo sobrevivem:

- diferentes identidades das coalizões compradas;
- distribuições distintas para proponentes fracos distintos;
- no empate residual autorizado, exclusão, pooling e misturas entre essas
  propostas.

O único registro JSON é uma família simbólica de equilíbrios, não uma seleção
de uma de suas marginais. Ele é atômico porque a mesma família
`F=(F_i)_{i in W}` aparece simultaneamente em:

- estratégia de proposta;
- payoff do proponente reconhecido;
- payoff pré-reconhecimento de cada weak state identificado;
- payoff de cada tipo de `H`;
- probabilidades de inclusão, exclusão e atraso.

Os indicadores `I_H`, `I_X` e `I_D` particionam cada par proposta-tipo. As
esperanças de payoff e outcome usam o mesmo `F_i`, e a fórmula de cada weak
state separa corretamente a chance `1/m` de ele próprio propor das chances
`1/m` de cada outra identidade propor. Não encontrei possibilidade de combinar
uma estratégia de uma convenção com payoff ou outcome de outra.

## 5. Tentativas dirigidas de contraexemplo

Não foi usada mutação exaustiva por folha nem força bruta de schema. Os testes
foram algébricos e representativos.

| Ataque tentado | Resultado |
|---|---|
| Fazer rejeição deliberada vencer | impossível por `E-R=1-beta*q/m>0` |
| Fazer candidato screening ou pooling infactível vencer | as desigualdades `S>=E` e `P>=E` forçam sua factibilidade |
| Sustentar aprovação sem `H` com `y>0` | o hedge para `y=0` preserva votos e eleva estritamente `r_i` |
| Construir aceitação apenas do tipo alto | exigiria `y<t_0<t_1<=y` |
| Fazer `H` aceitar quando não pivotal | `não` preserva o mesmo `y` e acrescenta `o_theta>0` |
| Criar segundo cutoff interior | `S-E` e `S-P` são afins em `nu`, com as raízes únicas acima |
| Ressuscitar tipo impossível no endpoint | vedado expressamente em todos os campos de crença de N3 |
| Ocultar multiplicidade por identidade | impedido pela família indexada `F_i` e pelas fórmulas por weak state identificado |

Como cheque numérico de fronteiras, usei o caso mínimo `N=3`, `m=q=2` e
`beta=0.8`, no qual `q-2=0` e, portanto, screening e pooling não compram weak
responder algum. Os resultados foram:

- `o_0=0.1`, `o_1=0.3`: `E=0.6`, `L=0.92`, `P=0.76` e
  `nu_SP=0.307692`;
- `o_0=0.1`, `o_1=0.7`: `E=0.6`, `L=0.92`, `P=0.44` e
  `nu_SE=0.615385`;
- `o_0=0.6`, `o_1=0.8`: exclusão supera screening e pooling em todo
  `nu`;
- `o_0=0.5`, `o_1=0.7`: screening empata em valor com exclusão somente em
  `nu=0` e vence ali pelo desempate sobre o payoff de `H`;
- `o_0=0.1`, `o_1=0.5`: `E=P=0.6`, screening termina em
  `nu_SE=0.615385`, e o empate adicional de payoff de `H` entre exclusão e
  pooling ocorre em `nu=0.75`, já na região residual correta.

Esses pontos cobrem as cinco regiões, o menor número admissível de jogadores,
os dois cutoffs, o empate triplo relevante e o empate residual com mistura.

## 6. Consistência executável e documental

- O JSON é UTF-8 válido e parseia sem erro. Contém uma célula exaustiva com
  `existence_status=exists` e um registro familiar atômico, sem equilíbrio
  sentinela.
- O ledger tem 13 claims, sete campos por linha e nenhum registro malformado.
  Os claims cobrem voto fraco, IC de `H`, exaustividade, factibilidade, P0,
  P1/P1a, fronteiras, multiplicidade, crenças, desconto e atomicidade.
- Markdown, JSON, ledger, matriz de sobrevivência e relatório consolidado
  usam as mesmas expressões, domínios, datas e hashes para N3.
- A inspeção de whitespace não encontrou erro além das quebras rígidas
  Markdown de dois espaços usadas deliberadamente no cabeçalho.
- O verificador dirigido terminou com
  `MODEL_PROOF_DIRECTED: PASS — N3 54 células paramétricas`. O mesmo script
  também imprime verificações de N4; elas não foram usadas para este veredicto.
- Os avisos isolados de locale do R não alteram cálculo nem constituem finding
  substantivo.

## 7. Fechamento dirigido de FD-SUP-MIN-01

O finding está fechado no relatório consolidado no hash manifestado. A versão
anterior usava a contradição `Y<ell<h<=Y` sem restringir seu domínio. O texto
corrente agora separa corretamente:

- o interior `0<nu<1`, em que a desigualdade com `ell` é aplicável;
- o endpoint `nu=1`, em que a restrição de suporte fixa o posterior em um para
  ambos os votos e a tentativa de separação inversa exige diretamente
  `Y<h<=Y`.

Isso é exatamente o reparo único descrito no registro
`quality_reports/2026-08-21_reparo_fd_sup_min_01.md`. Esta checagem atesta a
correção lógica e textual do fechamento; não constitui parecer sobre a
correspondência, as fronteiras ou a existência de equilíbrios de N4.

## 8. Findings e veredicto estrito

| Severidade | Quantidade | Findings |
|---|---:|---|
| critical | 0 | nenhum |
| major | 0 | nenhum |
| minor | 0 | nenhum |

**VEREDICT: PASS — critical=0, major=0, minor=0.**

Este PASS vale exclusivamente para a interface N3
`ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`
sob o manifesto
`90d6d8bfc4f1ef18c7edf5f9e1ea08870aec0385e625573e31b1b63a5a3d2bd4`.
O parecer não congela sozinho o nó, não edita o DAG, não autoriza N6 e não
emite veredicto substantivo sobre N4. Até o registro administrativo dos dois
pareceres no mesmo hash, N3 permanece `pending/unfrozen`.
