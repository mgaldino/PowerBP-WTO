# Parecer independente final de design formal — B.1/B.3

## 1. Boundary, integridade e independência

- **Artefato revisado:**
  `quality_reports/2026-09-01_b1_b3_exclusion_derivation.md`
- **SHA-256 recalculado:**
  `2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256`
- **Commit:** `ddb5c48c97daf5e353b96d89345ceaceea7d732a`
- **Branch:** `codex/exclusion-proof-b1-b3`
- **Manuscrito usado como fonte:** `formal_model_v6.Rmd`, SHA-256
  `374bbd4b381a9be797fecadeca875fcd42ba8b946191ad389bd8b7994f70ae43`
- **Papel do revisor:** `formal_design`, distinto do implementador.
- **Independência:** revisão realizada sem ler o relatório do parecerista
  game-teórico desta rodada. O parecer externo e sua adjudicação foram lidos
  porque integram expressamente o mandato deste gate. Nenhum arquivo candidato,
  manuscrito, input normativo ou artefato congelado foi editado.

Também foram lidos integralmente o manuscrito e o contrato Gate 0, além dos
registros normativos de exclusão mutuamente exclusiva e consistência
estrutural. Onde o contrato histórico ainda contém `x_H+o`, prevalece a decisão
autoral posterior de 2026-09-01 e sua emenda: após aprovação sem participação
de `H`, este recebe somente `o` e `x_H` não é pago a ninguém.

## 2. Método

A revisão refez, sem tomar as conclusões do candidato como premissas:

1. a contagem da quota para todo `m>=3`;
2. os limiares dos votos fracos na maioria terminal e em Round 1;
3. a factibilidade e a lucratividade estrita do desvio
   `x_H -> 0`, `x_i -> x_i+x_H`;
4. a melhor resposta de `H` nos três casos de `n_Y`;
5. a redução a exclusão, screening, pooling e delay;
6. as diferenças de payoff que geram os cutoffs e os cinco casos da
   Proposition `prop:majority`;
7. os desempates, endpoints, knife edges e multiplicidades;
8. a auditoria semântica completa de B.1--B.6 e a distinção entre estratégia
   completa e correspondência reportada de resultados.

As fórmulas foram verificadas algebricamente. Nenhuma checagem numérica foi
usada como prova.

## 3. Score: 10/10 no escopo delimitado

## O modelo em uma frase

Um proponente fraco escolhe entre comprar votos fracos substitutos ou tornar
`H` pivotal; a correção examina por que uma concessão positiva a `H` é
estritamente subótima quando esses votos fracos já bastam para aprovar.

## Tipo de contribuição (Board & Meyer-ter-Vehn)

O paper isola uma força política: a regra de votação transforma o voto do único
ator informado em insumo substituível sob maioria e essencial sob unanimidade.
O reparo preserva esse isolamento ao corrigir a contabilidade de exclusão sem
introduzir uma nova primitiva, seleção ou classe de equilíbrio.

## 4. Avaliação por dimensão

### MD1. Qualidade da pergunta — Excelente

A pergunta substantiva permanece clara: quando informação privada gera renda
para o hegemon por tornar sua aprovação insubstituível? A correção elimina uma
soma de payoffs sem interpretação substantiva e melhora a correspondência entre
o domínio de acordos de clube e a forma extensiva.

### MD2. Simplicidade e KISS — Excelente

O candidato usa um único lema local. Não acrescenta cap, transferência
contingente, externalidade, crença auxiliar ou refinamento. O desvio mantém a
soma da proposta e apenas desloca `x_H` para a alocação do proponente.

### MD3. Isolamento do mecanismo — Excelente

O argumento separa corretamente dois objetos: a melhor resposta fora do
caminho de `H`, que muda quando seu voto é não pivotal, e os resultados ótimos
reportados, que não mudam porque todo `x_H>0` nessa classe é eliminado
estritamente. Isso preserva o mecanismo de pivotalidade sem esconder a mudança
na estratégia completa.

### MD4. Riqueza de insights — Adequada ao reparo

O reparo não pretende criar novo resultado. Seu valor é mostrar que a
invariância downstream decorre de dominância estrita, não de uma convenção de
reporte ou da antiga soma `x_H+o`.

### MD5. Tipo de contribuição — Força política isolada

A contribuição do modelo continua sendo o papel da substituibilidade do voto
informado. A correção é de coerência interna e deixa essa contribuição mais
nítida.

### MD6. Processo de construção — Maduro

O trabalho separa decisão autoral, derivação, consulta externa, adjudicação,
reparo e nova revisão independente. O candidato explicita o que muda, o que
permanece e quais bytes ainda não podem ser migrados.

## 5. Respostas explícitas aos quatro findings adjudicados

### M1 — fechado

O finding exigia declarar a propriedade que preserva os votos fracos após o
desvio. Isso foi feito nas linhas 80--84 e usado explicitamente nas linhas
92--96. O resumo das hipóteses nas linhas 114--118 também passou a incluir que
cada voto fraco segue um limiar próprio independente de `x_H`, da alocação do
proponente, do voto de `H` e, nas aplicações relevantes, da crença.

A propriedade é verdadeira:

- na maioria terminal, o limiar é zero;
- em Round 1 sob maioria, o limiar é `w=beta/m`, pois a continuação de qualquer
  Estado fraco na maioria terminal é `1/m` para toda crença admissível.

O passo lógico que antes estava apenas implícito está agora completo.

### M2 — instrução de migração correta

O candidato agora usa a contagem pertinente:

\[
k=\left\lfloor\frac{m+1}{2}\right\rfloor\leq m-1
\qquad\text{para todo }m\geq3.
\]

Há exatamente `m-1` respondedores fracos porque um dos `m` Estados fracos é o
proponente. A desigualdade vale inclusive no caso-limite `m=3`, no qual
`k=2=m-1`. O texto inglês candidato reproduz essa contagem e elimina também os
pagamentos positivos aos respondedores, que podem ser reduzidos a zero sem
alterar seus votos. A instrução para a futura migração de B.1 é matematicamente
correta e suficiente.

### M3 — instrução de migração correta

A transição das linhas 330--335 distingue agora, sem sobreposição:

- `x_H=0` por dominância estrita na classe não pivotal `n_Y>=k`;
- `x_H=beta ell` ou `x_H=beta h` apenas na classe pivotal `n_Y=k-1`;
- delay quando `n_Y<=k-2`.

Assim, a futura B.3 não poderá reutilizar “the relevant type threshold” como se
o limiar pivotal governasse também a exclusão. A redução aos quatro candidatos
fica logicamente completa.

### M4 — corretamente deixado sem mudança

A adjudicação refutou M4 como defeito obrigatório, e o candidato preserva a
distinção correta. Na classe `n_Y>=k`, a aprovação termina o jogo. Na classe
`n_Y<=k-2`, as linhas 256--262 reconhecem que há continuação e que o voto de
`H` pode pertencer a histórias públicas distintas; o ponto decisivo é que a
maioria terminal entrega ao tipo `o` o mesmo payoff `beta o` para toda crença.
A linha própria da tabela na Seção 7 repete esse diagnóstico. Não faltava
reparo matemático adicional.

## 6. Checks formais do candidato

### 6.1 Desvio estrito

Para toda proposta na qual os votos fracos já bastam, o candidato constrói

\[
x'_H=0,\qquad x'_i=x_i+x_H,\qquad x'_j=x_j.
\]

A soma das alocações é idêntica, todas permanecem não negativas e nenhum cap
individual existe. Os votos fracos permanecem fixos pelos limiares declarados;
qualquer mudança do voto de `H` é irrelevante para passagem. Sob a proposta
original, o proponente recebe `x_i` quer `H` vote sim, quer vote não; sob a nova,
recebe `x_i+x_H`. O ganho é exatamente `x_H>0` para cada tipo e história, não
somente em esperança. O desvio é uma proposta alternativa ex ante e respeita a
simultaneidade do ballot.

### 6.2 Três casos de `n_Y`

Os casos são exaustivos e as respostas estão corretas:

1. `n_Y>=k`: a proposta passa sem `H`; um tipo `o` compara `x_H` com `o` e
   vota sim sse `x_H>=o`. A escolha ótima fixa `x_H=0`, de modo que os dois
   tipos votam estritamente não.
2. `n_Y=k-1`: `H` é pivotal; sim paga `x_H` agora e não leva à continuação
   `beta o`. O limiar permanece `x_H>=beta o`.
3. `n_Y<=k-2`: a proposta falha após qualquer voto de `H`; ambos produzem a
   mesma continuação `beta o`, e `T^Y` seleciona sim.

O limiar fraco `w=beta/m` é belief-free em todos esses casos porque a maioria
terminal dá a cada Estado fraco valor ex ante `1/m` independentemente do tipo
de `H` e da posterior.

### 6.3 Cutoffs, knife edges e multiplicidades

Os quatro payoffs candidatos permanecem:

\[
\Pi_E=1-kw,\quad
\Pi_S=(1-p)[1-(k-1)w-\beta\ell]+pw,\quad
\Pi_P=1-(k-1)w-\beta h,\quad
\Pi_D=w.
\]

As diferenças decisivas rederivam exatamente as fórmulas do candidato:

\[
\Pi_E-\Pi_D=1-\frac{\beta(k+1)}m>0,
\]

pois `k+1<=m` e `beta<1`,

\[
\Pi_P-\Pi_E=\beta(1/m-h),
\]

e

\[
\Pi_S-\Pi_E
=(1-p)\beta(1/m-\ell)
-p[1-\beta(k+1)/m].
\]

Logo não muda nenhum cutoff. Em `ell=1/m`, screening empata com exclusão
somente em `p=0` e o tie-break seleciona screening. Em `h=1/m`, exclusão e
pooling continuam empatados para o proponente; a comparação entre
`(1-p)ell+ph` e `beta h` preserva a seleção e o segmento residual com peso
comum. A multiplicidade por identidade dos respondedores pagos também
permanece. O desvio estrito impede uma nova família ótima parametrizada por
`x_H>0` na classe não pivotal.

### 6.4 Redação inglesa e precisão do sujeito

Os dois textos candidatos nomeiam quem vota, quem recebe cada payoff e qual
objeto passa. “Weak responder” é inteligível no vocabulário já definido do
manuscrito — um respondedor pertencente ao conjunto dos weak states — e não
gera ambiguidade matemática. A formulação “a responding weak state” usada em
B.3 é igualmente correta. A eventual harmonização editorial entre as duas
formas pode ocorrer no gate de integração, mas não constitui correção exigida
para a validade do candidato.

A passagem central evita o defeito de redação anteriormente identificado: ela
declara que são os votos dos Estados fracos que bastam para aprovar a proposta,
que `H` é o destinatário de `x_H`, que o proponente é quem melhora sua própria
alocação e que o objeto preservado é a aprovação da proposta.

### 6.5 Ausência de overclaim

O candidato não afirma invariância do assessment ou da estratégia PBE completa.
Reconhece expressamente que a resposta de `H` muda fora do caminho quando
`n_Y>=k` e `x_H>0`. A alegação preservada é mais estreita: resultados ótimos,
payoffs, cutoffs, classes e multiplicidades já reportadas. B.2 herda a maioria
terminal corrigida; B.4 é unanimidade; B.5 usa os mesmos vetores; B.6 apenas os
subtrai. Nenhuma dessas seções requer nova fórmula.

## 7. Findings

### CRITICAL

Nenhum.

### IMPORTANT

Nenhum.

### MINOR

Nenhum.

| Severidade | Contagem |
|---|---:|
| CRITICAL | 0 |
| IMPORTANT | 0 |
| MINOR | 0 |

## 8. Veredicto geral sobre design

**PASS — 0 CRITICAL / 0 IMPORTANT / 0 MINOR.**

O SHA-256
`2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256`
fecha M1, incorpora M2 e M3 como instruções corretas de migração e preserva a
disposição adjudicada de M4. O reparo é mínimo, identifica corretamente as
premissas que fazem o desvio funcionar e não altera resultados, cutoffs,
knife edges ou multiplicidades reportadas.

## 9. Limite deste parecer

Este PASS cobre somente o artefato e o hash acima, no papel de design formal.
Não congela o candidato sozinho, não autoriza tag, migração para
`formal_model_v6.Rmd`, merge, push ou promoção para `main`. Qualquer novo byte
exige o gate correspondente.
