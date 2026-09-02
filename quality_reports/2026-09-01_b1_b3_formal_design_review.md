# Parecer independente de design formal — B.1/B.3

## Boundary e independência

- **Artefato revisado:** `quality_reports/2026-09-01_b1_b3_exclusion_derivation.md`
- **SHA-256 revisado:** `f510f82eb0f9f6e3e7cc8a59a6d26724cea3cff7ee53da2d1eabdbb3c3264665`
- **Commit de revisão:** `3f0b035`
- **Branch:** `codex/exclusion-proof-b1-b3`
- **Escopo:** correção da regra de exclusão em B.1/B.3, seu efeito sobre estratégias, crenças, resultados, payoffs e multiplicidades reportadas, e blast radius em toda a Appendix B.
- **Independência:** o parecerista não implementou o memorando nem leu qualquer outro parecer sobre este candidato. Nenhum artefato revisado ou manuscrito foi editado; este relatório é o único arquivo criado pelo parecerista.

O `formal_model_v6.Rmd` permanece deliberadamente fora do objeto aprovado: suas linhas 1392 e 1433 ainda contêm a regra antiga `x_H+o`. Este parecer não estende PASS a esses bytes e não autoriza migração.

## Método

O parecer reconstruiu o argumento a partir dos primitives correntes do jogo, sem presumir a invariância pretendida:

1. conferência da exclusividade entre payoff de acordo e outside option, da factibilidade `x_H+\sum_j x_j\leq1` e da intransferibilidade de uma concessão não paga;
2. reconstrução do desvio do proponente para toda proposta aprovada por votos fracos suficientes;
3. separação dos três ramos exaustivos `n_Y\geq k`, `n_Y=k-1` e `n_Y\leq k-2`;
4. rederivação dos quatro candidatos `E`, `S`, `P` e delay e de suas diferenças de payoff;
5. conferência das regras de voto as-if-pivotal, do desempate em favor de sim, da datação por `\beta` e da disciplina de crenças;
6. leitura semântica das provas B.1--B.6 e confronto com as proposições e vetores que elas sustentam.

Não foi necessário teste numérico: as relações relevantes são identidades ou desigualdades exatas. Em particular, para `m\geq3`, `k=\lfloor(m+1)/2\rfloor\leq m-1`, de modo que há respondedores fracos suficientes para aprovar sem `H`, e `k+1\leq m`, de modo que `1-\beta(k+1)/m>0` para `\beta<1`.

## O modelo em uma frase

Um proponente fraco escolhe entre comprar o voto informacionalmente custoso de um hegemon com outside option privada e substituí-lo por votos fracos, sob duas rodadas e uma comparação institucional entre maioria e unanimidade.

## Tipo de contribuição (Board & Meyer-ter-Vehn)

O reparo preserva uma contribuição de **força política isolada**: pivotalidade transforma informação privada em restrição de participação apenas quando o voto de `H` é necessário. A regra corrigida fortalece esse isolamento porque impede que um ator excluído receba simultaneamente uma alocação do acordo e sua alternativa externa.

## Avaliação por dimensão

### MD1. Qualidade da pergunta — Excelente no escopo

A correção incide diretamente sobre a pergunta substantiva do modelo: quando um voto necessário cria poder informacional. Ela não adiciona uma questão lateral nem muda o domínio político dos acordos distributivos de clube.

### MD2. Simplicidade e KISS — Excelente

O lema das linhas 67--103 do memorando usa somente não negatividade, a restrição agregada da pie e o fato de que os votos fracos já garantem passagem. Não requer cap, reversão contingente, exaustão fora do caminho ou novo parâmetro. É a reparação mínima compatível com os primitives aprovados.

### MD3. Isolamento do mecanismo — Excelente

O memorando separa corretamente dois objetos antes confundidos: a resposta de voto de `H` fora do caminho e a escolha ótima do proponente. Quando `H` é não pivotal, ele compara `x_H` com `o`; apesar dessa mudança de resposta, o proponente elimina estritamente todo `x_H>0`. Quando `H` é pivotal, o limiar continua `\beta o`. Assim, a informação privada só precifica o voto necessário.

### MD4. Riqueza de insights — Adequada e preservada

O reparo não pretende gerar resultado novo. Seu mérito é mostrar que a mudança de primitive altera a estratégia completa fora do caminho sem alterar os resultados econômicos reportados. Essa distinção é analiticamente útil e evita transformar invariância de resultados em uma alegação falsa de invariância de assessments.

### MD5. Tipo de contribuição — Força política isolada

O desenho continua convincente como isolamento de poder por pivotalidade, e não como contribuição técnica autônoma. O desvio estrito mostra por que uma concessão positiva a um voto desnecessário não pode sustentar uma nova classe ótima.

### MD6. Processo de construção — Maduro

O memorando trabalha primeiro o lema mínimo, depois o benchmark público, depois o jogo privado e só então propaga o diagnóstico para B.2--B.6. Também preserva a fronteira entre derivação, revisão e futura migração do manuscrito.

## Verificação formal do mecanismo

### 1. Lema de eliminação da concessão não pivotal

Para qualquer proposta `x` com `n_Y\geq k` e `x_H>0`, defina

\[
x'_H=0,\qquad x'_i=x_i+x_H,\qquad x'_j=x_j\quad(j\neq i,H).
\]

A soma proposta é idêntica, portanto `x'` é factível. Cada respondedor fraco recebe a mesma alocação e mantém o mesmo voto; os `k` votos fracos continuam suficientes. A possível mudança do voto de `H` não muda passagem. Sob `x`, o proponente recebe `x_i` tanto se `H` votar sim quanto se votar não. Sob `x'`, recebe `x_i+x_H`. O ganho é `x_H>0` em cada tipo e em cada resposta de `H`. O desvio é, portanto, estritamente lucrativo em toda a classe declarada, inclusive quando `x` não exaure a pie.

Esse movimento é uma mudança **ex ante de proposta**, autorizada pelo espaço de propostas; não é uma transferência contingente de `x_H` depois do voto e, portanto, não viola a intransferibilidade da concessão específica a `H`.

### 2. B.1

Em maioria terminal, um respondedor fraco compara `x_j\geq0` com desacordo zero e vota sim na igualdade. Como `k\leq m-1`, a aprovação dispensa `H`. Um `H` não pivotal compara `x_H` com `o` e vota sim se e somente se `x_H\geq o`. O lema elimina todo `x_H>0`; com `x_H=0<o`, `H` vota estritamente não, o proponente escolhe sua própria alocação igual a um e o resultado terminal-majoritário reportado é único.

Em Round 1, inclusão custa `(k-1)\beta/m+\beta o`, enquanto exclusão custa `k\beta/m`. A comparação continua equivalente a `o\leq1/m`. Na igualdade, inclusão dá a `H` `\beta o`, contra `o` na exclusão, e o tie-break do proponente seleciona inclusão porque `\beta<1`. Nenhum payoff ou cutoff de `prop:public` muda.

### 3. B.3

- Se `n_Y\geq k`, a proposta passa qualquer que seja o voto de `H`; cada tipo vota sim sse `x_H\geq o`. O lema reduz a única escolha ótima dessa classe a `x_H=0`, com payoff `\Pi_E=1-k\beta/m` ao proponente e vetor `(\ell,h)` para `H`.
- Se `n_Y=k-1`, `H` é pivotal. Sim implementa `x_H` agora; não leva à maioria terminal, que paga `o` a `H` independentemente da crença, isto é, `\beta o` em unidades de Round 1. O limiar é exatamente `x_H\geq\beta o`; daí screening em `\beta\ell` e pooling em `\beta h`.
- Se `n_Y\leq k-2`, nem o sim de `H` completa a quota. Sim e não levam à mesma continuação terminal-majoritária `\beta o`; o desempate em favor de sim fixa a resposta. Posteriores distintos depois dos dois votos não alteram esse payoff porque a maioria terminal independe da crença.

Os únicos conjuntos de aceitação relevantes continuam sendo nenhum tipo, apenas o tipo baixo e ambos os tipos. Junto da exclusão não pivotal, isso deixa exatamente `E`, `S`, `P` e delay. As expressões `\Pi_E`, `\Pi_S(p)` e `\Pi_P`, suas diferenças, os cutoffs e as cinco regiões são as mesmas. Os vetores de B.5 continuam `(\beta\ell,\beta h)`, `(\beta h,\beta h)` e `(\ell,h)`; B.6 é apenas subtração desses vetores dos benchmarks públicos.

## Findings por severidade

### CRITICAL

Nenhum.

### IMPORTANT

Nenhum.

### MINOR

Nenhum.

As duas cautelas seguintes já estão satisfeitas pelo memorando e, por isso, não são findings: `n_Y` deve continuar definido como o número de votos fracos prescritos pela proposta, não como um vetor observado por `H` antes de votar; e a invariância não deve ser estendida ao assessment PBE completo, pois a nova lei de voto de `H` pode também alterar atualizações bayesianas em histórias terminais fora do caminho. As linhas 184--185 e 321--328 do memorando preservam essas fronteiras.

## Respostas às sete perguntas obrigatórias

1. **Sim.** O desvio é factível porque preserva exatamente a soma das alocações e é estritamente lucrativo porque eleva o payoff do proponente em `x_H>0` para qualquer resposta de `H`.
2. **Não.** As alocações fracas não mudam, logo seus votos e `n_Y` não mudam. O voto de `H` e o posterior após esse voto podem mudar, mas não a quota, a passagem ou o payoff do proponente nessa classe terminal.
3. **Sim.** No ramo pivotal, não leva à maioria terminal e paga `o` uma rodada depois; a datação corrente produz `\beta o`. Sim implementa `x_H` imediatamente.
4. **Sim.** Com `n_Y\leq k-2`, ambas as ações de `H` levam à mesma continuação `\beta o`; a indiferença exata cai sob o desempate em favor de sim.
5. **Não.** Nenhum cutoff, tie-break, segmento residual ou vetor de B.5/B.6 muda. A razão é que exclusão usa `x_H=0` e inclusão usa os mesmos limiares pivotais de antes.
6. **Sim.** O memorando limita a invariância a resultados, payoffs, cutoffs, classes e multiplicidades reportadas e reconhece que estratégias completas fora do caminho mudam. Lido como assessment, posteriores bayesianos fora do caminho também podem mudar com a nova lei prescrita, mas isso não é negado pelo memorando nem alimenta continuação após passagem.
7. **Não.** Não surge multiplicidade em propostas ótimas no componente `x_H`, pois o desvio é estrito. Permanecem a permutação de identidades fracas e o segmento residual já reportado. Pode mudar a multiplicidade de completamentos de resposta/crença em histórias fora do caminho, mas ela pertence ao assessment completo expressamente excluído da alegação de invariância e não muda qualquer objeto reportado.

## Contagem e veredicto

| Severidade | Contagem |
|---|---:|
| CRITICAL | 0 |
| IMPORTANT | 0 |
| MINOR | 0 |

**VEREDICTO: PASS — 0/0/0.**

O PASS cobre exclusivamente o memorando no SHA-256 registrado. Ele confirma a suficiência do lema, a correção dos limiares e a invariância das proposições reportadas nos limites explicitados. Não congela a prova, não cobre o texto ainda não migrado de B.1/B.3, não cobre alterações futuras dos bytes e não autoriza tag, merge, push ou mudança do manuscrito.
