# Revisão game-teórica independente — migração de B.1/B.3

**Data:** 2026-09-02

**Papel:** parecerista game-teórico adversarial, sem participação na migração

**Tipo de jogo:** barganha legislativa dinâmica de horizonte finito, com
informação privada unilateral, votações públicas simultâneas e solução por PBE
sob disciplinas declaradas de voto, crenças e desempate

**Veredicto:** **PASS — 0 CRITICAL / 0 IMPORTANT / 0 MINOR**

Este PASS vale exclusivamente para os bytes e para o escopo fixados abaixo. Ele
não autoriza merge, push, promoção para `main` ou tag final.

## 1. Boundary imutável

| Objeto | SHA-256 ou identificador verificado |
|---|---|
| `formal_model_v6.Rmd` | `7de0b2eddc20b98509f8fa37a299860f83164b7469097598532aa5cbfbd7a2a7` |
| `formal_model_v6.pdf` | `97ff2d5fa3878550a5b6ea77c642b99ad4543aec760e92ff7941495ea552ed00` |
| `quality_reports/2026-09-01_b1_b3_exclusion_derivation.md` | `2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256` |
| manifesto de migração | `quality_reports/2026-09-02_b1_b3_manuscript_migration_manifest.sha256` — `shasum -a 256 -c`: PASS 4/4 |
| commit candidato | `03ab370cce3f06725d805054e6796a8e78e674b0` |
| tag pré-migração | `v6-pre-b1-b3-exclusion-migration-2026-09-02` |
| commit apontado pela tag | `8be463f24e3012b75cd76623e167ac3ba1ed7904` |
| objeto anotado da tag | `57adaff7b21cc171df9b9042f0dd1978a6a06cc0` |

A tag registra como baseline o Rmd anterior no SHA-256
`374bbd4b381a9be797fecadeca875fcd42ba8b946191ad389bd8b7994f70ae43`.

## 2. Independência, materiais e método

Não li o parecer do outro revisor e não alterei Rmd, PDF, memorando,
manifesto, relatório de migração ou qualquer fonte do modelo. O único arquivo
criado por esta revisão é o presente relatório.

Li e confrontei:

1. as definições do jogo, a regra de passagem, os payoffs e o conceito de
   solução em `formal_model_v6.Rmd`, linhas 298--450;
2. os enunciados e objetos das Propositions `prop:public`, `prop:terminal`,
   `prop:majority`, `prop:unanimity`, `prop:privatecompare`, `prop:rents` e
   `prop:deltari`, inclusive cutoffs, tabelas e multiplicidades;
3. Appendix A.1--A.2 e Appendix B.1--B.6, linhas 1340--1605;
4. o memorando aprovado de derivação, integralmente;
5. o diff exato entre a tag pré-migração e o commit candidato;
6. o PDF compilado por extração textual e suas propriedades mecânicas.

O teste adversarial rederivou as escolhas do proponente e as respostas de `H`
em cada contagem de votos fracos, examinou os casos-limite `m=3`, `p=0`,
`p=1`, `ell=1/m`, `h=1/m` e as igualdades dos limiares, e procurou desvios que
pudessem restaurar um candidato ótimo com `x_H>0` quando `H` é não pivotal.

## 3. Auditoria do diff e do escopo

O diff da tag ao commit candidato contém quatro caminhos:

- modificação de `formal_model_v6.Rmd`;
- recompilação de `formal_model_v6.pdf`;
- adição do relatório de migração;
- adição do manifesto de hashes.

No Rmd, o diff tem exatamente dois hunks substantivos:

1. abertura de B.1, linhas 1388--1402 do candidato;
2. abertura de B.3 e transição para os quatro candidatos, linhas 1438--1462.

Nenhuma definição, enunciado de proposição, fórmula de payoff, cutoff, tabela,
figura, referência, trecho de B.2 ou trecho de B.4--B.6 mudou. `git diff
--check` não acusa erro. A extração do PDF contém a nova comparação
`x_H` versus `o`, os três casos de `n_Y` e a transição revisada. A busca literal
por `x_H+o` e por `x_H + o` no Rmd retorna zero ocorrências.

## 4. Reconstituição game-teórica

### 4.1 Quota e votos fracos

O proponente já conta como um voto sim. A maioria exige

\[
k=\left\lfloor\frac{m+1}{2}\right\rfloor
\]

votos adicionais. Existem `m-1` respondedores fracos. Para `m>=3`,

\[
k\leq m-1.
\]

A desigualdade é justa em `m=3` e estrita para todo `m>3`. Logo, os
respondedores fracos podem aprovar sem `H`. Também
segue `k+1<=m`, usada em

\[
1-\beta(k+1)/m>0
\]

porque `beta<1`.

Na maioria terminal, a continuação de um respondedor fraco após rejeição é
zero; com sim na indiferença, toda alocação não negativa induz sim. Em Round
1, a continuação terminal-majoritária de cada Estado fraco, antes do sorteio
de reconhecimento, é `1/m`. Portanto seu limiar em unidades de Round 1 é

\[
w=\beta/m.
\]

Esse valor é independente do posterior, de `x_H`, da parcela do proponente e
do voto de `H`. A nova prova usa corretamente essa independência para preservar
os votos fracos no desvio do proponente.

### 4.2 Maioria terminal e B.1

Quando os votos fracos já bastam, o payoff de um tipo `o` é

\[
u_H(Y)=x_H,\qquad u_H(N)=o.
\]

Logo `H` vota sim se e somente se `x_H>=o`, inclusive na igualdade. Essa é a
resposta correta sob payoffs mutuamente exclusivos; a prova não repete a regra
revogada `x_H+o`.

Para qualquer proposta dessa classe com `x_H>0`, o desvio

\[
x'_H=0,\qquad x'_i=x_i+x_H,\qquad x'_j=x_j\quad(j\neq i,H)
\]

preserva a soma das alocações e, portanto, a factibilidade; preserva todas as
alocações e votos dos respondedores fracos; preserva a passagem, mesmo se o
voto de `H` mudar; e aumenta o payoff do proponente exatamente em `x_H>0`.
Se `H` votava não, `x_H` não era pago; se votava sim, pagava-se um voto
desnecessário. Não há terceiro caso.

Reduzir alocações positivas dos respondedores a zero mantém seus votos sim na
maioria terminal. Assim, o único resultado ótimo é `x_H=0`, pagamentos fracos
iguais a zero, parcela unitária do proponente e voto estritamente não de `H`,
que recebe `o` porque `o>0`. Isso sustenta literalmente `prop:public` e o
resultado único de maioria em `prop:terminal`.

Os demais ramos de B.1 permanecem válidos. Na unanimidade terminal, `H` é
pivotal e seu limiar é `o`, sem `beta`. Em Round 1, o limiar pivotal é
`beta o`; inclusão custa `(k-1)w+beta o`, enquanto exclusão compra `k` votos
fracos e custa `kw`. A comparação continua equivalente a `o<=1/m`. No empate,
inclusão dá ao proponente o mesmo payoff e a `H` o payoff menor
`beta o<o`, como exige o desempate entre propostas.

### 4.3 Os três casos de `n_Y` em B.3

Seja `n_Y` o número de respondedores fracos que satisfazem `x_j>=w`.

**Caso 1: `n_Y>=k`.** Os votos fracos aprovam sem `H`. O tipo `o` compara
`x_H` após sim com `o` após não e vota sim sse `x_H>=o`. O mesmo desvio estrito
da Seção 4.2 elimina todo `x_H>0`. A escolha ótima da classe tem `x_H=0`; como
`0<ell<h`, ambos os tipos votam estritamente não e recebem `(ell,h)`. Reduzir
pagamentos acima de `w` e eliminar respondedores pagos além dos `k` necessários
leva ao custo mínimo `kw` e ao payoff

\[
\Pi_E=1-kw.
\]

**Caso 2: `n_Y=k-1`.** `H` é pivotal. Sim implementa `x_H`; não faz a
proposta falhar e leva à maioria terminal, cujo payoff de `H` é `o`. Em
unidades de Round 1, o limiar é exatamente `beta o`. Logo `x_H=beta ell`
seleciona apenas o tipo baixo e `x_H=beta h` seleciona ambos, com sim na
igualdade. Não há soma entre alocação e outside option.

**Caso 3: `n_Y<=k-2`.** Mesmo um voto sim de `H` deixa a contagem abaixo de
`k`; portanto a proposta falha sob ambos os votos. Cada tipo recebe a mesma
continuação `beta o` após sim e não. A convenção de sim na indiferença seleciona
sim. Esse voto fora do caminho completa a estratégia, mas não cria um novo
resultado ou candidato do proponente.

Os três casos são disjuntos e exaustivos. Em particular, `n_Y=k-1` e
`n_Y=k-2` recebem a datação correta e não são confundidos.

### 4.4 Crenças e simultaneidade

A simultaneidade não cria uma decisão adicional para `H`: sua estratégia é
condicionada à proposta e ao tipo, e a contagem `n_Y` resulta das estratégias
determinísticas dos respondedores dadas suas alocações. Nenhum passo permite a
`H` observar o vetor realizado antes de votar.

No ramo `n_Y>=k`, a proposta passa independentemente do voto de `H`; não há
continuação cuja crença possa alterar o payoff. Nos ramos que falham, o voto de
`H` pode alterar a crença pública sob Bayes ou consistência estrutural, mas a
maioria terminal entrega `o` a cada tipo de `H` e `1/m` ex ante a cada Estado
fraco para qualquer posterior. Portanto:

- o limiar fraco `w` é belief-free;
- o limiar pivotal de `H` é `beta o`;
- no ramo de falha inevitável, sim e não dão a mesma continuação.

A migração não altera a disciplina de crenças de A.2 e não depende de fixar
arbitrariamente um posterior fora do caminho.

### 4.5 Redução aos quatro candidatos

Na classe não pivotal, o desvio elimina `x_H>0`, pagamentos fracos acima de
`w` podem ser reduzidos, e apenas `k` votos fracos precisam ser comprados. Na
classe pivotal, os únicos conjuntos de aceitação monotônicos não vazios são o
tipo baixo sozinho, ao preço `beta ell`, e ambos os tipos, ao preço `beta h`;
a aceitação apenas do tipo alto é impossível. A classe de falha inevitável e
qualquer oferta pivotal rejeitada pelos dois tipos entregam delay. Restam:

\[
\Pi_E=1-kw,
\]

\[
\Pi_S(p)=(1-p)[1-(k-1)w-\beta\ell]+pw,
\]

\[
\Pi_P=1-(k-1)w-\beta h,
\]

e delay com payoff `w`. A exclusão é factível. Como

\[
\Pi_E-w=1-\frac{\beta(k+1)}m>0,
\]

delay nunca é escolhido. Se um candidato de screening ou pooling fosse
inviável, seu residual de passagem seria negativo; ele não poderia superar
`Pi_E>w`, de modo que a cláusula de factibilidade da prova é correta.

Reexpansão algébrica confirma:

\[
\Pi_P-\Pi_E=\beta(1/m-h)
\]

e

\[
\Pi_S(p)-\Pi_E
=(1-p)\beta(1/m-\ell)-p[1-\beta(k+1)/m].
\]

Essas são exatamente as diferenças que geram `p_{S=P}`, `p_{S=E}` e as cinco
regiões de `prop:majority`. Nenhuma delas contém a regra antiga de payoff.

### 4.6 Desempates, knife edges e multiplicidades

Nos empates de screening, o vetor de `H` é `(beta ell,beta h)`. Ele dá a `H`
payoff esperado estritamente menor do que pooling, quando esse empate é
relevante, e estritamente menor do que exclusão porque `beta<1`; o desempate
seleciona screening.

Em `h=1/m`, `Pi_P=Pi_E`. O critério entre pooling e exclusão continua sendo a
comparação do payoff esperado de `H`, `beta h` versus `(1-p)ell+ph`; na
igualdade permanece o segmento vinculado pelo mesmo peso de proposta. A
correção no ramo não pivotal não acrescenta uma família ótima em `x_H`, porque
todo `x_H>0` nessa classe é estritamente dominado para o proponente.

A multiplicidade por permutação das identidades dos respondedores pagos
permanece, assim como o segmento residual já declarado. A correspondência
completa de estratégias fora do caminho muda — `H` agora pode votar sim em
propostas não pivotais com `x_H>=o` —, mas as correspondências reportadas de
resultados, payoffs, classes, cutoffs e multiplicidades ótimas não mudam. O
manuscrito não afirma o contrário.

## 5. Dependências B.2--B.6

| Bloco | Resultado da checagem |
|---|---|
| B.2 | Usa a maioria terminal por referência a B.1. Com a prova corrigida, o resultado único `x_H=0`, payoff 1 ao proponente, `o` a `H` e continuação fraca `1/m` permanece. A unanimidade terminal e `p^*` não usam exclusão majoritária. |
| B.4 | É um argumento de unanimidade: toda aprovação requer o voto de `H`. Nenhum passo paga `o` junto com `x_H`, e a migração não altera seus limiares, crenças ou células de existência. |
| B.5 | Os vetores majoritários continuam `V_M^{B,S}=(beta ell,beta h)`, `V_M^{B,P}=(beta h,beta h)` e `V_M^{B,E}=(ell,h)`. O último é precisamente o payoff mutuamente exclusivo corrigido. |
| B.6 | É subtração dos vetores de B.5 e dos benchmarks públicos. Como os vetores reportados não mudam, rents, diferenças de diferenças, conjuntos vazios e segmento atômico permanecem. |

Não identifiquei dependência downstream que exija nova fórmula, novo cutoff,
novo enunciado ou mudança de tabela.

## 6. Fidelidade literal ao memorando aprovado

A abertura nova de B.1 coincide com o texto inglês candidato da Seção 5.4 do
memorando: inclui a contagem `k<=m-1`, a comparação correta `x_H` versus `o`, o
desvio estrito, a redução dos pagamentos fracos a zero e o resultado único.

A abertura nova de B.3 coincide com a Seção 6.5: declara o limiar fraco
belief-free, separa os três casos de `n_Y`, preserva `beta o` somente no ramo
pivotal e explicita sim por indiferença no ramo de falha inevitável. A transição
seguinte também coincide com a instrução do memorando: separa a dominância que
impõe `x_H=0` na classe não pivotal da redução a `beta ell` e `beta h` na
classe pivotal. Não encontrei omissão ou extensão substantiva em relação ao
candidato aprovado.

## 7. Stress tests adversariais

| Tentativa de quebra | Resultado |
|---|---|
| `m=3`, caso mais apertado | `k=2=m-1`; os dois respondedores fracos aprovam sem `H`, e `Pi_E-w=1-beta>0`. |
| `x_H` entre zero e `o` em ramo não pivotal | `H` vota não, mas transferir `x_H` ao proponente continua estritamente lucrativo. |
| `x_H>=o` em ramo não pivotal | `H` pode votar sim, mas seu voto é redundante; o mesmo desvio estrito elimina a proposta. |
| `n_Y=k-1` | Apenas `H` pode completar a quota; rejeição leva a `beta o`, não a `o` corrente nem a `x_H+o`. |
| `n_Y=k-2` | Mesmo sim de `H` não completa a quota; ambos os votos levam a `beta o`, e o tie-break exige sim. |
| `p=0` ou `p=1` | Suporte degenerado não altera a continuação majoritária belief-free nem os limiares auditados. |
| `ell=1/m` | A igualdade pública de custos e a seleção por menor payoff de `H` permanecem; o caso 4 de `prop:majority` não muda. |
| `h=1/m` | `Pi_P=Pi_E`; a seleção e o segmento residual continuam regidos pelo payoff esperado de `H`. |
| mudança do voto de `H` após o desvio `x_H -> 0` | A passagem é preservada porque já existem pelo menos `k` votos fracos. |
| possível novo ótimo com `x_H>0` | Refutado pelo ganho estrito `x_H` do proponente na classe não pivotal; na classe pivotal, os mínimos `beta ell` e `beta h` já estão entre os candidatos. |

## 8. Findings

### CRITICAL

Nenhum.

### IMPORTANT

Nenhum.

### MINOR

Nenhum.

**Contagens:** `0 CRITICAL / 0 IMPORTANT / 0 MINOR`.

## 9. Componentes candidatos a Lean 4

Isto não é condição para o gate atual, mas os seguintes passos seriam
formalizáveis sem infraestrutura de PBE:

| Componente | Dificuldade | Ferramentas prováveis |
|---|---:|---|
| `k<=m-1` e `k+1<=m` para `m>=3` | baixa--média | aritmética de `Nat.floor`/divisão inteira, `omega` |
| factibilidade e ganho estrito do desvio `x_H -> 0`, `x_i -> x_i+x_H` | baixa | `linarith` |
| identidades `Pi_P-Pi_E` e `Pi_S-Pi_E` | baixa | `ring_nf`, `linarith` |
| `Pi_E-w>0` sob `beta in (0,1)` | baixa | `nlinarith` após o lema da quota |

A completude PBE com crenças estruturais e correspondências de propostas
exigiria uma formalização consideravelmente maior e não é necessária para
certificar esta migração localizada.

## 10. Veredicto e limite de autoridade

**PASS — 0/0/0.** Nos bytes fixados, a migração de B.1/B.3 é fiel ao memorando
aprovado e correta sob as primitivas e o conceito de solução do manuscrito. A
regra de payoff é mutuamente exclusiva; a quota, os desvios, os três casos de
`n_Y`, a datação, as crenças, os quatro candidatos, os cutoffs, os desempates,
os knife edges e as multiplicidades são preservados corretamente. B.2--B.6
continuam válidos, e nenhum outro trecho substantivo do Rmd foi alterado.

Este parecer não congela sozinho os bytes e não autoriza merge, push, promoção
para `main` ou tag final.
