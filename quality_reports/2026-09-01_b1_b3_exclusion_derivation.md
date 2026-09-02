# Derivação candidata — B.1/B.3 sob a regra de exclusão mutuamente exclusiva

**Status:** REPAIRED CANDIDATE — NEW BYTES PENDING INDEPENDENT REVIEW — UNFROZEN

**Manuscrito:** NÃO ALTERADO por este memorando

**Branch:** `codex/exclusion-proof-b1-b3`

**HEAD de abertura:** `e10bf08e1f994705b64430e60328cbdd952f01d4`

**Boundary anterior:** SHA-256
`f510f82eb0f9f6e3e7cc8a59a6d26724cea3cff7ee53da2d1eabdbb3c3264665`,
com dois pareceres internos `PASS 0/0/0`. A consulta externa posterior foi
adjudicada em
`quality_reports/adjudication/b1_b3_exclusion_external/f510f82eb0f9/`.

## 1. Mandato e limite

Este memorando rederiva apenas as partes das provas B.1 e B.3 afetadas pela
regra aprovada de exclusão. Ele também realiza uma auditoria semântica de toda
a Appendix B, mas não autoriza nem executa alterações em
`formal_model_v6.Rmd`.

A correção de payoff é:

- se `H` vota sim e a proposta passa, `H` participa e recebe `x_H`;
- se `H` vota não e a maioria aprova sem ele, `H` não participa, recebe apenas
  `o`, e `x_H` não é pago a ninguém;
- alocação de acordo e outside option nunca são somadas na mesma história.

Não são reabertos o protocolo de votação, o espaço de propostas, o conceito de
solução, a estrutura de crenças, o valor unitário da pie ou qualquer extensão.

## 2. Inputs normativos e boundary reproduzível

Os inputs lidos antes da derivação foram:

| Artefato | SHA-256 na abertura |
|---|---|
| `formal_model_v6.Rmd` | `374bbd4b381a9be797fecadeca875fcd42ba8b946191ad389bd8b7994f70ae43` |
| `quality_reports/2026-09-01_decisao_exclusao_payoffs_e_fundamentos.md` | `5b165b65e3ade3ee1ff67c714fddbd35dd030b8e5b315b447132fd7f7c6e0982` |
| `quality_reports/2026-09-01_decisao_structural_consistency_baseline.md` | `7e671effa200117228d837201a5151922c4fd014af93758de38616b04a8346d5` |
| `notes/2026-09-01_explicacao_completa_correcao_exclusao_teto.md` | `ea1cdae25e512543ded0af35456f2b2b22458a905d99a7592309dc798a1c1e0a` |

Alterações simultâneas do autor em `CLAUDE.md` e o arquivo não rastreado
`notes/2026-09-01_escopo_exit_power_exemplos_do_autor.md` foram preservados e
ficam fora do candidato aqui delimitado.

## 3. Objetos usados

Há um hegemon `H`, `m >= 3` Estados fracos e um proponente fraco. O proponente
é contado como voto sim. Sob maioria, são necessários

\[
k=\left\lfloor\frac{m+1}{2}\right\rfloor
\]

votos adicionais. A proposta é não negativa e satisfaz

\[
x_H+\sum_{j\in W}x_j\leq 1.
\]

Em Round 1, o preço de continuação de um Estado fraco sob maioria é

\[
w=\frac{\beta}{m}.
\]

Seja `n_Y` o número de respondedores fracos cuja alocação é ao menos `w` e que,
pela regra as-if-pivotal e pelo desempate em favor de sim, votam sim.

## 4. Lema de eliminação de concessão não pivotal

**Lema.** Considere uma proposta aprovada sob maioria pelos votos do
proponente e de pelo menos `k` respondedores fracos, de modo que o voto de `H`
não seja necessário. Qualquer proposta dessa classe com `x_H>0` é
estritamente subótima para o proponente.

Nas duas aplicações do lema, o voto de cada respondedor fraco depende apenas
de sua própria alocação. Na maioria terminal, seu limiar é zero. Na maioria de
Round 1, seu limiar é `w=beta/m`, pois a continuação terminal-majoritária de um
Estado fraco é `1/m` e independe da crença, de `x_H`, da alocação do proponente
e do voto de `H`.

**Prova.** Fixe uma proposta `x` dessa classe com `x_H>0`. Construa `x'` por

\[
x'_H=0,\qquad x'_i=x_i+x_H,\qquad x'_j=x_j\quad(j\neq i,H),
\]

onde `i` é o proponente. A soma das alocações não muda, portanto `x'` é
factível. A alocação de cada respondedor fraco permanece fixa e, pelos
limiares próprios e independentes descritos acima, seu voto também não muda.
Seus votos continuam bastando para aprovar a proposta. Uma eventual mudança
do voto de `H` também não muda a aprovação.

Sob `x`, há duas possibilidades. Se `H` vota não, `x_H` não é pago e o
proponente recebe `x_i`. Se `H` vota sim, `H` recebe `x_H`, embora seu voto seja
desnecessário, e o proponente novamente recebe `x_i`. Sob `x'`, o proponente
recebe `x_i+x_H`. Seu ganho é estritamente `x_H>0` nos dois casos. Logo `x` não
pode ser uma escolha ótima do proponente. \(\square\)

Uma formulação verbal clara do argumento é:

> Quando os votos dos Estados fracos já bastam para aprovar a proposta, o
> proponente não ganha nada ao reservar uma parcela positiva para `H`. Se `H`
> votar não, `x_H` não será pago; se votar sim, `H` receberá `x_H`, embora seu
> voto seja desnecessário para a aprovação. Em qualquer dos casos, o
> proponente pode fixar `x_H=0`, acrescentar essa parcela à própria alocação e
> manter a proposta aprovada. Portanto, nessa classe de propostas, todo
> `x_H>0` é estritamente subótimo para o proponente.

O lema usa não negatividade, a restrição agregada da pie, a especificidade de
`x_H` e o fato de que, nas duas aplicações majoritárias, cada voto fraco segue
um limiar próprio independente dos demais componentes da proposta e da
crença. Não introduz cap sobre `x_H` nem requer que a pie seja exaurida fora do
caminho.

## 5. B.1 — benchmark de tipo público

### 5.1 Maioria terminal

O valor de desacordo de um respondedor fraco é zero. A regra de sim na
indiferença implica voto sim para toda alocação não negativa, inclusive zero.
Há `m-1` respondedores fracos e
`k=floor((m+1)/2)<=m-1` para `m>=3`; portanto, seus votos bastam para aprovar
sem `H`, e o proponente pode oferecer zero a todos eles.

Quando os votos fracos já bastam, `H` é não pivotal e compara:

\[
u_H(Y)=x_H,\qquad u_H(N)=o.
\]

Logo `H` vota sim se e somente se `x_H >= o`, com sim na igualdade. Não é
correto afirmar que todo tipo vota não para todo `x_H`.

Pelo lema da Seção 4, porém, qualquer `x_H>0` é estritamente subótimo para o
proponente nessa classe. A escolha ótima fixa `x_H=0`. Como `o>0`, `H` então
vota estritamente não, recebe `o`, cada respondedor fraco recebe zero e o
proponente recebe a pie inteira. Portanto, permanece válido o resultado
reportado na Proposition `prop:public` e reutilizado como resultado único na
Proposition `prop:terminal`.

### 5.2 Unanimidade terminal

Sob unanimidade, `H` é pivotal. Votar sim implementa `x_H`; votar não leva ao
desacordo terminal `o`. Assim, `H` aceita exatamente quando `x_H >= o`, e o
proponente escolhe `x_H=o`. A correção da regra de exclusão não altera este
ramo, pois uma proposta não pode passar sob unanimidade após o voto não de
`H`.

### 5.3 Round 1

Sob maioria, as duas escolhas relevantes continuam sendo:

- inclusão: comprar `k-1` votos fracos por `w=beta/m` e o voto pivotal de `H`
  por `beta o`, ao custo `(k-1)w+beta o`;
- exclusão: comprar `k` votos fracos por `w` e fixar `x_H=0`, ao custo `kw`.

Quando `H` é pivotal, votar não leva ao Round 2, no qual a maioria terminal lhe
garante `o`; em unidades de Round 1, seu limiar é `beta o`. Quando os `k` votos
fracos já bastam, o lema elimina todo `x_H>0`, e `H` recebe `o` após votar não.

Portanto, inclusão é fracamente mais barata exatamente quando

\[
(k-1)\frac{\beta}{m}+\beta o
\leq k\frac{\beta}{m}
\quad\Longleftrightarrow\quad
o\leq\frac1m.
\]

Na igualdade, o payoff do proponente coincide e o desempate entre propostas
seleciona inclusão porque ela dá a `H` o payoff menor, `beta o < o`. O cutoff,
os payoffs e as classes da Proposition `prop:public` permanecem inalterados.

### 5.4 Texto inglês candidato para B.1

O texto abaixo é apenas candidato para migração futura, depois dos gates:

> In terminal majority, a weak responder's disagreement value is zero, so any
> nonnegative allocation induces yes under the indifference-to-yes convention.
> There are \(m-1\) weak responders, and
> \(k=\lfloor(m+1)/2\rfloor\leq m-1\) for \(m\geq3\); their votes can
> therefore pass the proposal without \(H\). At any such proposal, a
> nonpivotal \(H\) votes yes exactly when \(x_H\geq o\): yes yields \(x_H\),
> whereas no yields \(o\). Yet every \(x_H>0\) is strictly suboptimal for the
> proposer. If \(H\) votes no, \(x_H\) is paid to no one; if \(H\) votes yes,
> it is paid for a vote that is unnecessary for passage. In either case,
> setting \(x_H=0\) and assigning that amount to the proposer preserves every
> weak responder's allocation and ballot, preserves passage, and raises the
> proposer's payoff by \(x_H\). Positive payments to weak responders can
> likewise be reduced to zero without changing their ballots. Hence the unique
> equilibrium outcome has \(x_H=0\), zero payments to every weak responder,
> the proposer keeps the unit pie, and \(H\) votes no and receives \(o\).

Os demais parágrafos atuais de B.1 podem permanecer, pois seus preços de voto,
comparações e desempates são os rederivados acima.

## 6. B.3 — maioria privada em Round 1

Um respondedor fraco vota sim exatamente quando `x_j >= w`. Esse limiar é
independente da crença e do voto de `H`, porque sua continuação sob maioria
terminal é sempre `1/m`. Fixada uma proposta, há três classes exaustivas.

### 6.1 Caso `n_Y >= k`: `H` não pivotal

Os votos fracos aprovam a proposta qualquer que seja o voto de `H`. A
comparação correta de `H`, tipo a tipo, é

\[
u_H(Y\mid n_Y\geq k)=x_H,
\qquad
u_H(N\mid n_Y\geq k)=o.
\]

Logo o tipo `o` vota sim se e somente se `x_H >= o`, com sim na igualdade. A
estratégia fora do caminho, portanto, muda em relação ao texto antigo.

Para a escolha ótima do proponente, o lema elimina estritamente todo
`x_H>0`. Reduzir `x_H` a zero e transferir a diferença ao proponente preserva
os votos fracos e a aprovação. Assim, o único candidato ótimo dessa classe
fixa `x_H=0`; ambos os tipos votam estritamente não porque `ell>0`, e recebem
suas respectivas outside options. Pagando exatamente `w` a `k` respondedores
fracos, o payoff do proponente continua sendo

\[
\Pi_E=1-kw.
\]

### 6.2 Caso `n_Y = k-1`: `H` pivotal

Se `H` vota sim, a proposta passa e o tipo `o` recebe `x_H`. Se vota não, a
proposta falha e segue para a maioria terminal. Como a maioria terminal exclui
`H` e lhe entrega `o` independentemente da crença, o valor da continuação em
unidades de Round 1 é `beta o`. Portanto,

\[
u_H(Y\mid n_Y=k-1)=x_H,
\qquad
u_H(N\mid n_Y=k-1)=\beta o,
\]

e `H` vota sim exatamente quando `x_H >= beta o`.

Os candidatos de screening e pooling permanecem:

- screening: `x_H=beta ell`, aceito pelo tipo baixo e rejeitado pelo alto;
- pooling: `x_H=beta h`, aceito por ambos os tipos.

Se o tipo alto rejeita a oferta de screening, a proposta falha e ele recebe
`beta h`; esse cálculo não soma alocação e outside option.

### 6.3 Caso `n_Y <= k-2`: falha inevitável

Mesmo acrescentando o voto de `H`, a quota não é atingida. A proposta falha e
cada tipo de `H` recebe a mesma continuação de maioria terminal `beta o` após
sim ou não. Como a continuação é independente da crença, `H` é indiferente e
vota sim pela convenção de desempate. Este detalhe completa a estratégia fora
do caminho, mas não cria uma nova classe de resultado.

### 6.4 Redução aos candidatos e comparação

O argumento de dominância precedente deixa apenas `x_H=0` na classe
`n_Y>=k`. Na classe pivotal `n_Y=k-1`, pagamentos fracos podem ser reduzidos a
`w` e `x_H` a `beta ell` ou `beta h`, conforme o conjunto de tipos que se
pretende fazer aceitar. Propostas na classe restante produzem delay. Atribuir
ao proponente o resíduo aumenta fracamente seu payoff. Permanecem exatamente
quatro candidatos:

\[
\Pi_E=1-kw,
\]

\[
\Pi_S(p)=(1-p)[1-(k-1)w-\beta\ell]+pw,
\]

\[
\Pi_P=1-(k-1)w-\beta h,
\]

e delay, com payoff `w`.

Essas expressões e suas diferenças não usam a fórmula antiga `x_H+o`. Logo
permanecem:

\[
\Pi_E-w=1-\frac{\beta(k+1)}m>0,
\]

\[
\Pi_P-\Pi_E=\beta(1/m-h),
\]

e

\[
\Pi_S(p)-\Pi_E
=(1-p)\beta(1/m-\ell)-p[1-\beta(k+1)/m].
\]

Os cutoffs `p_{S=P}` e `p_{S=E}`, as cinco regiões da Proposition
`prop:majority`, o desempate em favor de screening, o segmento residual no
knife edge e a multiplicidade por permutação de Estados fracos permanecem
inalterados.

### 6.5 Texto inglês candidato para a abertura de B.3

> A responding weak state votes yes exactly when \(x_j\geq
> w=\beta/m\). This threshold is independent of the posterior and of \(H\)'s
> vote because a weak state's terminal-majority continuation is always
> \(1/m\). Let \(n_Y\) be the number of such responders. If
> \(n_Y\geq k\), the weak-state votes pass the proposal without \(H\). A
> nonpivotal type with outside option \(o\) then votes yes exactly when
> \(x_H\geq o\): yes yields \(x_H\), whereas no yields \(o\). Nevertheless,
> every \(x_H>0\) in this class is strictly suboptimal for the proposer. Moving
> \(x_H\) to the proposer's own allocation preserves the weak-state votes and
> passage and raises the proposer's payoff by \(x_H\). Hence the optimal
> exclusion candidate sets \(x_H=0\); both types then vote no and receive their
> outside options. If \(n_Y=k-1\), \(H\) is pivotal and a type with outside
> option \(o\) votes yes exactly when \(x_H\geq\beta o\), because no leads to
> the terminal-majority continuation. If \(n_Y\leq k-2\), the proposal fails
> regardless of \(H\)'s vote; the two ballot actions deliver the same
> terminal-majority continuation, so the indifference-to-yes convention
> selects yes.

Na futura migração, o parágrafo seguinte deve começar com a transição:

> The preceding dominance argument leaves only \(x_H=0\) in the class
> \(n_Y\geq k\). In the pivotal class \(n_Y=k-1\), weak payments can be
> reduced to \(w\) and \(x_H\) to \(\beta\ell\) or \(\beta h\), according to
> the desired acceptance set; proposals in the remaining class deliver delay.

Depois dessa transição, as quatro fórmulas candidatas, as comparações, os
cutoffs e as afirmações de multiplicidade podem permanecer como no texto
vigente.

## 7. O que muda e o que não muda

| Objeto | Diagnóstico candidato | Razão |
|---|---|---|
| Payoff de `H` após aprovação sem sua participação | **Muda** | É `o`, nunca `x_H+o`. |
| Resposta de `H` quando `n_Y>=k` e `x_H>0` | **Muda** | `H` compara `x_H` com `o`; não vota sempre não. |
| Resposta de `H` quando `n_Y<=k-2` | **É explicitada** | A continuação terminal-majoritária é igual após os dois votos; o desempate seleciona sim. |
| Escolha ótima de `x_H` sob exclusão | **Não muda** | O lema elimina estritamente todo `x_H>0`. |
| Resultado terminal-majoritário | **Não muda** | `x_H=0`, aprovação sem `H`, proponente recebe 1 e `H` recebe `o`. |
| Limiar de `H` quando pivotal em Round 1 | **Não muda** | Continua `beta o`. |
| `Pi_E`, `Pi_S`, `Pi_P` e delay | **Não mudam** | Usam `x_H=0` na exclusão e os limiares pivotais nas classes de inclusão. |
| Cutoffs e cinco regiões de `prop:majority` | **Não mudam** | Derivam das mesmas diferenças de payoff. |
| Crenças após votos fora do caminho | **A disciplina não muda** | A nova resposta deve respeitar Bayes/consistência estrutural, mas não há continuação após uma proposta que já passou. |
| Correspondência completa de estratégias | **Muda** | Há respostas diferentes de `H` em propostas não pivotais com `x_H>0`; não se deve alegar invariância da estratégia completa. |
| Correspondência reportada de resultados e payoffs | **Não muda, sujeito a revisão** | As propostas alteradas são estritamente subótimas para o proponente. |
| Multiplicidades existentes | **Não mudam, sujeito a revisão** | Persistem permutações de respondedores e o segmento residual já declarado; não surge família ótima em `x_H`. |

Portanto, a afirmação segura é de invariância das proposições reportadas sobre
resultados, payoffs, cutoffs, classes e multiplicidades já declaradas — não de
invariância da estratégia PBE completa em todas as histórias.

## 8. Auditoria semântica de toda a Appendix B

### B.1

**Afetada diretamente.** A frase que atribui `x_H+o` após não está errada. A
substituição candidata da Seção 5 corrige a resposta de `H` e prova, por
desvio estrito do proponente, por que o resultado reportado continua válido.

### B.2

**Afetada apenas por referência.** O argumento de maioria terminal remete à
parte terminal-majoritária de B.1. Lida com a B.1 corrigida, a conclusão
`x_H=0`, payoff 1 ao proponente e `o` a `H` permanece. O argumento de
unanimidade e o cutoff `p^*` não usam exclusão por maioria.

### B.3

**Afetada diretamente.** A classificação inicial das respostas de `H` precisa
ser corrigida nos três casos de `n_Y`. A redução aos quatro candidatos e todas
as comparações subsequentes permanecem, condicionadas aos pareceres
independentes.

### B.4

**Não afetada.** Trata de unanimidade. Toda proposta aprovada requer o sim de
`H`; não existe aprovação que exclua `H`. Seus argumentos de continuação,
crenças e existência não usam `x_H+o`.

### B.5

**Não afetada nos vetores reportados.** Os vetores de maioria usam `o` para a
classe de exclusão e `beta o` para as classes em que `H` é pivotal. São
exatamente os payoffs rederivados aqui. A subtração componente a componente
permanece.

### B.6

**Não afetada na álgebra reportada.** As correspondências de rents usam os
vetores de B.5 e o benchmark público. Como esses vetores permanecem, as
diferenças também permanecem. A conclusão depende, contudo, da confirmação
independente de B.1/B.3 e não recebe PASS deste memorando.

## 9. Perguntas obrigatórias para os pareceristas

1. O desvio `x_H -> 0`, `x_i -> x_i+x_H` é factível e estritamente lucrativo
   em todas as propostas nas quais os votos fracos já bastam?
2. Existe alguma história em que reduzir `x_H` altere votos fracos, a quota ou
   o payoff do proponente de forma não considerada?
3. O limiar `beta o` no ramo pivotal permanece correto sob a datação e a
   continuação terminal-majoritária atuais?
4. A indiferença no ramo `n_Y<=k-2` realmente deve selecionar sim?
5. Algum cutoff, tie-break, segmento residual ou vetor de B.5/B.6 muda?
6. O memorando distingue corretamente estratégia completa de correspondência
   reportada de resultados/payoffs?
7. Há multiplicidade adicional em propostas ótimas, crenças ou respostas que
   invalide a alegação de invariância?

## 10. Consulta externa e reparo adjudicado

A consulta técnica externa no hash
`cae750f8d5cc6e8fdab68d07d1d9fe7eb08050a8e43642396dc78c2e8cbeac3c`
propôs quatro findings menores. A adjudicação independente decidiu:

| Finding | Decisão | Implementação neste candidato |
|---|---|---|
| M1 | `CONFIRMED` | O lema agora declara a independência dos limiares de voto fracos e deixa de afirmar que usa apenas três propriedades. |
| M2 | `PARTIAL` | O texto candidato de B.1 agora demonstra `k<=m-1` e elimina pagamentos positivos aos respondedores. |
| M3 | `PARTIAL` | A transição candidata de B.3 agora separa dominância não pivotal de limiares pivotais. |
| M4 | `REFUTED` | Nenhuma mudança: a Seção 6.3 e a tabela da Seção 7 já distinguem passagem terminal de falha com continuação belief-free. |

## 11. Gate atual

Este documento reparado não emite PASS e não congela nenhuma prova. Como seus
bytes diferem do boundary anterior, o próximo gate é obter dois novos
pareceres independentes, um de design formal e outro game-teórico adversarial,
sobre seu novo SHA-256, seguidos de adjudicação. Nenhuma tag, migração para o
manuscrito, merge ou push é autorizada por este memorando.
