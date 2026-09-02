# Auditoria game-teórica adversarial independente — B.1/B.3

**Data:** 2026-09-01

**Parecerista:** agente independente de auditoria game-teórica

**Tipo de jogo:** barganha dinâmica de duas rodadas sob informação incompleta,
com votação simultânea, proposta por Estado fraco, conceito de PBE em
estratégias puras de voto e disciplinas declaradas de votação e crenças

**Artefato revisado:**
`quality_reports/2026-09-01_b1_b3_exclusion_derivation.md`

**SHA-256 revisado:**
`f510f82eb0f9f6e3e7cc8a59a6d26724cea3cff7ee53da2d1eabdbb3c3264665`

**Commit e branch informados:** `3f0b035`,
`codex/exclusion-proof-b1-b3`

**Independência:** este parecer não leu o relatório do outro parecerista e
não alterou o memorando candidato, o manuscrito, os registros normativos ou
qualquer artefato congelado.

## 1. Veredicto

**PASS — 0 CRITICAL / 0 IMPORTANT / 0 MINOR.**

O memorando corrige corretamente os dois passos afetados pela nova regra de
exclusão. O desvio que fixa `x_H=0` é factível e estritamente lucrativo para o
proponente em toda proposta majoritária na qual os votos fracos já bastam.
Não encontrei alteração nos resultados, payoffs, cutoffs, classes ou
multiplicidades reportadas nas Propositions `prop:public`, `prop:terminal` e
`prop:majority`, nem nos vetores derivados em B.5/B.6.

A correção muda, como o próprio memorando reconhece, a resposta fora do
caminho de `H` em propostas não pivotais com `x_H>0` e pode mudar quais
posteriores fora do caminho são determinados por Bayes ou ficam livres. Isso
muda a correspondência completa de assessments, não a correspondência
reportada de resultados e payoffs ótimos. O memorando não confunde esses dois
objetos.

## 2. Método adversarial

Li o memorando fixado pelo hash acima, os dois registros normativos de
2026-09-01, a nota explicativa, a definição corrente do jogo, o conceito de
solução, as Propositions `prop:public`, `prop:terminal` e `prop:majority`, o
Apêndice A.1--A.2 e a Appendix B completa.

Tentei invalidar o candidato pelos seguintes caminhos:

1. violação de factibilidade ao deslocar `x_H` para o proponente;
2. perda da quota quando a mudança de `x_H` altera o voto de `H`;
3. mudança indireta dos votos fracos por alteração da crença posterior;
4. datação incorreta da outside option no ramo pivotal;
5. falha do desempate em `n_Y<=k-2`;
6. novos candidatos ótimos com `x_H>0`;
7. alteração dos cutoffs e dos casos de fronteira
   `ell=1/m`, `h=1/m`, `p=0` e `p=1`;
8. criação de multiplicidade ótima adicional em propostas, respostas ou
   crenças;
9. uso implícito do teto removido sobre `x_H`;
10. dependência semântica de B.2, B.4, B.5 ou B.6 da fórmula antiga
    `x_H+o`.

Também verifiquei o caso mínimo `m=3`, no qual
`k=floor((m+1)/2)=2=m-1`, e o limite de desconto relevante para a dominância
do atraso: `Pi_E-w=1-beta(k+1)/m=1-beta>0`. Esses são os casos de quota e de
dominância mais apertados permitidos pelas primitivas.

## 3. Reconstrução independente

### 3.1 Quota e votos fracos

Há `m-1` respondedores fracos além do proponente. Para `m>=3`,

\[
k=\left\lfloor\frac{m+1}{2}\right\rfloor\leq m-1,
\]

portanto os votos fracos podem aprovar uma proposta majoritária sem `H`.

Na maioria terminal, o payoff de desacordo de um Estado fraco é zero; pela
regra de sim na indiferença, qualquer `x_j>=0` induz sim. Em Round 1, a
continuação majoritária de um Estado fraco antes do reconhecimento é `1/m`,
independente da crença e do voto de `H`, de modo que seu cutoff é
`w=beta/m`. Portanto, nos dois usos do lema, manter cada `x_j` fixo mantém
cada voto fraco fixo mesmo se a mudança de `x_H` alterar a ação prescrita de
`H` e o posterior depois do ballot.

Esse ponto bloqueia o contraexemplo mais promissor: em jogos nos quais a
continuação fraca dependesse da crença, mudar o voto de `H` poderia mudar o
incentivo as-if-pivotal de um respondedor. Isso não ocorre aqui porque a
continuação terminal sob maioria é belief-free.

### 3.2 Desvio de eliminação de concessão não pivotal

Fixe uma proposta com `n_Y>=k` e `x_H>0`. Substituir

\[
x'_H=0,\qquad x'_i=x_i+x_H,\qquad x'_j=x_j\quad(j\ne i,H)
\]

preserva exatamente a soma proposta e, portanto, a factibilidade, inclusive
quando a restrição agregada já vale com igualdade. A não negatividade também
é preservada. Como os `x_j` não mudam, os votos fracos e a quota não mudam.

Sob a proposta original, o proponente recebe `x_i` tanto quando `H` vota sim
quanto quando vota não: no primeiro caso `x_H` é pago a `H`; no segundo, não
é pago a ninguém. Sob a proposta desviada, o proponente recebe
`x_i+x_H`. O ganho é `x_H>0` em cada tipo e em cada ação de `H`, não apenas
em esperança. Logo nenhuma proposta ótima dessa classe tem `x_H>0`.

Não há uso de reversão, transferência contingente, exaustão fora do caminho
ou teto sobre `x_H` nesse argumento.

### 3.3 Resposta de `H` por classe de votos fracos

- Se `n_Y>=k`, a proposta passa sob as duas ações de `H`. Um tipo `o`
  compara `x_H` após sim com `o` após não e vota sim se e somente se
  `x_H>=o`, inclusive na igualdade. Essa resposta fora do caminho é diferente
  da regra antiga. Na proposta ótima da classe, `x_H=0<ell<h`, de modo que
  ambos os tipos votam estritamente não.
- Se `n_Y=k-1`, `H` é pivotal. Sim implementa `x_H` agora; não leva ao Round
  2, cuja maioria terminal entrega `o` em unidades de Round 2. Em unidades de
  Round 1, o payoff de não é `beta o`. Logo o cutoff permanece
  `x_H>=beta o`, com sim na igualdade.
- Se `n_Y<=k-2`, nem o sim de `H` completa a quota. As duas ações levam à
  mesma maioria terminal e dão `beta o` a cada tipo. Embora o voto de `H`
  possa alterar o posterior, o payoff terminal-majoritário é independente da
  crença. A regra de sim na indiferença seleciona sim.

### 3.4 Candidatos e fronteiras

As únicas classes que podem ser ótimas continuam sendo:

\[
\Pi_E=1-k\frac{\beta}{m},
\]

\[
\Pi_S(p)=(1-p)\left[1-(k-1)\frac{\beta}{m}-\beta\ell\right]
           +p\frac{\beta}{m},
\]

\[
\Pi_P=1-(k-1)\frac{\beta}{m}-\beta h,
\]

e atraso, com payoff `beta/m`. A correção só afeta propostas não pivotais
com `x_H>0`, que o desvio anterior elimina estritamente. Os candidatos de
screening e pooling usam o cutoff pivotal `beta o`, que não mudou.

Recalculando as diferenças:

\[
\Pi_P-\Pi_E=\beta(1/m-h),
\]

\[
\Pi_S(p)-\Pi_E
=(1-p)\beta(1/m-\ell)-p[1-\beta(k+1)/m],
\]

e `Pi_E-beta/m>0` para todo `m>=3`, `beta in (0,1)`. Portanto os cutoffs
`p_{S=P}` e `p_{S=E}` e as cinco regiões não mudam.

Nos knife edges:

- em `ell=1/m`, screening empata com exclusão apenas em `p=0` e entrega a
  `H` `beta ell<ell`, sendo selecionado pelo tie-break;
- em `h=1/m`, pooling e exclusão continuam empatados para o proponente; o
  tie-break compara, como antes, `beta h` com `(1-p)ell+ph`, e a igualdade
  preserva o segmento residual com um único peso comum;
- em todo empate que envolve screening, seu payoff esperado para `H` é
  estritamente menor que o da alternativa empatada;
- em `p=0` e `p=1`, a preservação de suporte afeta apenas os posteriores
  admissíveis, não os cutoffs typewise nem o desvio estrito do proponente.

## 4. Respostas às sete perguntas obrigatórias

### 1. O desvio é factível e estritamente lucrativo em todas as propostas relevantes?

**Sim.** A soma proposta é preservada exatamente; a não negatividade é
preservada; os pagamentos e votos fracos não mudam; e o payoff do proponente
aumenta de `x_i` para `x_i+x_H` em cada tipo e sob qualquer voto de `H`.

### 2. Reduzir `x_H` pode alterar votos fracos, quota ou payoff do proponente de modo omitido?

**Não nos subgames auditados.** O voto de `H` e o posterior podem mudar, mas
o cutoff fraco é zero na maioria terminal e `beta/m` em Round 1, ambos
independentes de `x_H`, do tipo e da crença. A quota permanece satisfeita por
`k` votos fracos, e o payoff do proponente aumenta estritamente.

### 3. O limiar `beta o` no ramo pivotal permanece correto?

**Sim.** Sim implementa `x_H` na data corrente; não causa falha da proposta e
leva à maioria terminal, que paga `o` na rodada seguinte. A datação em
unidades de Round 1 produz exatamente `beta o`.

### 4. A indiferença em `n_Y<=k-2` seleciona sim?

**Sim.** A proposta falha sob as duas ações e a continuação typewise é
`beta o` sob ambas. A convenção `T^Y` aplica-se à igualdade esperada e
seleciona sim.

### 5. Algum cutoff, tie-break, segmento residual ou vetor de B.5/B.6 muda?

**Não.** As fórmulas dos quatro candidatos são idênticas, assim como suas
diferenças. Os vetores de `H` continuam sendo
`(beta ell,beta h)`, `(beta h,beta h)` e `(ell,h)` para screening, pooling e
exclusão. B.5 e B.6 apenas subtraem esses vetores e preservam o mesmo peso no
segmento residual.

### 6. O memorando separa corretamente estratégia completa e resultados reportados?

**Sim.** Ele declara que a resposta de `H` muda em propostas não pivotais com
`x_H>0` e proíbe alegar invariância da estratégia PBE completa. A invariância
reivindicada fica limitada às propostas ótimas e aos resultados, payoffs,
cutoffs, classes e multiplicidades reportados.

### 7. Surge multiplicidade adicional que invalide a invariância reportada?

**Não.** A estrita lucratividade do desvio elimina qualquer família ótima
indexada por `x_H>0`. Continuam apenas a permutação de identidades fracas e o
segmento residual já reportado. A mudança da lei prescrita de `H` fora do
caminho pode mudar quais crenças terminais são bayesianas ou livres e,
portanto, a multiplicidade da correspondência completa de assessments; como
essas histórias já encerram o jogo e as propostas são estritamente
subótimas, isso não cria novo resultado ótimo nem invalida a afirmação
restrita do memorando.

## 5. Checklist de condições

| Condição | Status | Evidência |
|---|---|---|
| Factibilidade do desvio | PASS | Soma e não negatividade preservadas. |
| Quota sem `H` | PASS | `k<=m-1` para `m>=3`. |
| Simultaneidade | PASS | O desvio não condiciona pagamentos ao voto realizado; compara duas propostas ex ante. |
| Resposta fraca | PASS | Cutoffs belief-free: zero no terminal e `beta/m` em Round 1. |
| Timing de `H` não pivotal | PASS | Sim dá `x_H`; não, com aprovação, dá `o` na data corrente. |
| Timing de `H` pivotal | PASS | Não leva a `beta o`; sim dá `x_H` agora. |
| Empate `T^Y` | PASS | Sim em `x_H=o`, `x_H=beta o` e na falha inevitável. |
| Bayes e consistência estrutural | PASS | Mudam assessments fora do caminho, mas não continuações payoff-relevantes. |
| Cutoffs e classes | PASS | Mesmas diferenças `Pi_P-Pi_E` e `Pi_S-Pi_E`. |
| Multiplicidades reportadas | PASS | Nenhuma família ótima em `x_H`; identidades e segmento preservados. |
| Uso do teto removido | PASS | Nenhum passo exige limite além de soma menor ou igual a um. |
| Blast radius B.2--B.6 | PASS | B.2 herda B.1 corrigida; B.4 é unanimidade; B.5/B.6 usam vetores invariantes. |

## 6. Findings por severidade

### CRITICAL

Nenhum.

### IMPORTANT

Nenhum.

### MINOR

Nenhum.

Duas explicitações são recomendáveis na futura migração, sem constituírem
finding contra o candidato: escrever `k<=m-1` ao justificar que os
respondedores fracos bastam e lembrar, na aplicação em Round 1, que seus
votos permanecem fixos porque a continuação majoritária `1/m` é independente
da crença. As duas propriedades já estão presentes e usadas corretamente no
memorando; explicitá-las apenas torna o bloqueio aos contraexemplos visível ao
leitor.

## 7. Sugestões de formalização em Lean 4

| Componente | Formalizável? | Dificuldade | Ferramenta provável |
|---|---|---|---|
| `k<=m-1` para `m>=3` | Sim | Fácil | aritmética de `Nat`, `omega` |
| Factibilidade de `x_H -> 0`, `x_i -> x_i+x_H` | Sim | Fácil | `linarith` |
| Ganho estrito do proponente igual a `x_H` | Sim | Fácil | `linarith` |
| Equivalência do cutoff público `o<=1/m` | Sim | Fácil | `field_simp`, `linarith` |
| Diferenças entre `Pi_E`, `Pi_S`, `Pi_P` | Sim | Fácil--média | `field_simp`, `ring_nf`, `linarith` |
| Classificação completa dos assessments PBE e crenças estruturais | Não recomendada neste gate | Alta | exigiria infraestrutura própria para jogos e sistemas de crença |

O maior retorno de formalização está no lema de desvio, na desigualdade de
quota e nas identidades algébricas dos payoffs. A disciplina bayesiana fora
do caminho deve permanecer documentada e auditada, não tratada como se Lean
já dispusesse de uma biblioteca pronta para este conceito declarado.

## 8. Conclusão operacional

O memorando pode avançar ao próximo gate sem reparo matemático. Este PASS
cobre exclusivamente o arquivo e o SHA-256 registrados no cabeçalho. Não
autoriza edição de `formal_model_v6.Rmd`, tag, merge ou push.
