# Adjudicação independente — B.1/B.3, round 1

## 1. Identidade da fonte e do contrato

| Campo | Valor |
|---|---|
| Artefato adjudicado | `quality_reports/2026-09-01_b1_b3_exclusion_derivation.md` |
| SHA-256 recalculado | `f510f82eb0f9f6e3e7cc8a59a6d26724cea3cff7ee53da2d1eabdbb3c3264665` |
| Integridade | Confirmada; 393 linhas lidas integralmente |
| Argument contract | Não requerido para este reparo delimitado (`contract.required=false`) |
| Parecer R1 | `quality_reports/2026-09-01_b1_b3_formal_design_review.md` |
| SHA-256 R1 recalculado | `f761ff617be28062198e6c2378c4d70a806b908a78cd46792a33ec7191b129f2` |
| Parecer R2 | `quality_reports/2026-09-01_b1_b3_game_theory_audit.md` |
| SHA-256 R2 recalculado | `b185d21aae71148be7ed444d2abe4256493890314ac1d59d129ecb6e8fcedd6a` |

Os três hashes coincidem com os informados no mandato da adjudicação. Os
quatro inputs normativos registrados no candidato também permanecem
byte-idênticos aos hashes de abertura. A alteração simultânea e externa em
`CLAUDE.md` não foi consumida como parte do candidato e não foi tocada nesta
adjudicação.

## 2. Disposição executiva

**Veredicto: `NO_CONFIRMED_DEFECTS`.**

Os dois pareceres efetivamente revisaram o artefato completo pretendido, e não
somente a frase a ser substituída. R1 reconstrói o lema, B.1, os três ramos de
B.3, as quatro classes de candidatos, as sete perguntas obrigatórias e o
blast radius em B.2--B.6. R2 declara e executa uma bateria adversarial que
inclui factibilidade, quota, timing, crenças, fronteiras paramétricas,
multiplicidade e dependências semânticas de toda a Appendix B.

A concordância dos pareceres não foi tratada como prova. A adjudicação voltou
ao candidato, às definições correntes do jogo, às Propositions `prop:public`,
`prop:terminal` e `prop:majority`, ao conceito de solução e à Appendix B. O
argumento central se sustenta diretamente: em toda proposta que já passa com
os votos fracos, deslocar uma concessão positiva de `H` para a alocação do
proponente preserva a factibilidade e a quota e aumenta o payoff do proponente
em exatamente `x_H>0`, qualquer que seja o voto de `H`.

## 3. Checks mecânicos

1. **Identidade de bytes.** `shasum -a 256` devolveu exatamente os três hashes
   registrados acima.
2. **Boundary normativo.** `shasum -a 256` confirmou os hashes de abertura de
   `formal_model_v6.Rmd`, da decisão de exclusão, da decisão de consistência
   estrutural e da nota explicativa.
3. **Cobertura estrutural.** A enumeração de headings mostrou que o candidato
   contém as Seções 1--10, incluindo B.1, os três ramos de B.3, a auditoria de
   B.1--B.6 e as sete perguntas; R1 e R2 contêm boundary, método,
   reconstrução, respostas, findings, contagens e veredicto.
4. **Confronto textual.** A busca dos termos `x_H+o`, `n_Y`, `beta o`, B.1--B.6
   e das três proposições confirmou que o candidato localiza a fórmula antiga,
   corrige as respostas de `H` e limita a invariância aos objetos reportados;
   ambos os pareceres tratam esses mesmos pontos.
5. **Quota e álgebra.** Uma grade suplementar em R para `m=3,...,100`, cinco
   valores de `beta`, múltiplos valores de `ell`, `h` e `p` confirmou
   `k<=m-1`, `k+1<=m`, `Pi_E-w>0` e as duas identidades de diferenças de
   payoff. Output: `ALGEBRA_GRID_PASS max_error=2.5e-16 m=3..100`. A grade é
   apenas um check suplementar; as identidades são verificáveis algebricamente
   no candidato.

## 4. Findings

| Status | Contagem |
|---|---:|
| `CONFIRMED` | 0 |
| `PARTIAL` | 0 |
| `REFUTED` | 0 |
| `UNRESOLVED` | 0 |
| Decisões reservadas ao autor | 0 |

R1 e R2 reportam `PASS — 0/0/0` e não formulam findings candidatos. As duas
explicitações sugeridas por R2 para uma futura migração — tornar visível
`k<=m-1` e lembrar que a continuação fraca majoritária é belief-free — já são
propriedades usadas corretamente no candidato e foram expressamente
classificadas pelo parecer como recomendações expositivas, não defeitos do
artefato. Não há finding a normalizar artificialmente.

## 5. Evidência e raciocínio

### 5.1 Lema de concessão não pivotal

O candidato define a proposta desviada por `x'_H=0`,
`x'_i=x_i+x_H` e mantém todas as alocações fracas. A soma proposta permanece
idêntica, a não negatividade é preservada e os `k` votos fracos continuam
suficientes. Sob a proposta original, o proponente recebe `x_i` quer `H` vote
sim, quer vote não; sob a desviada, recebe `x_i+x_H`. O ganho é estrito em
cada tipo e ação, não apenas em esperança. O passo não confunde uma nova
proposta ex ante com uma transferência contingente após o ballot.

### 5.2 B.1

Na maioria terminal, o cutoff correto de um `H` não pivotal é `x_H>=o`, mas o
lema elimina toda proposta ótima com `x_H>0`. Com `x_H=0<o`, `H` vota
estritamente não, os respondedores fracos aceitam zero e o proponente retém a
pie unitária. Em Round 1, inclusão continua custando
`(k-1)beta/m+beta o` e exclusão, `k beta/m`; o cutoff permanece `o<=1/m`.
Nada nesse cálculo soma alocação de acordo e outside option.

### 5.3 B.3

Os três casos são exaustivos e preservam a simultaneidade do ballot:

- com `n_Y>=k`, `H` é não pivotal e compara `x_H` com `o`; o lema força
  `x_H=0` no candidato ótimo de exclusão;
- com `n_Y=k-1`, `H` é pivotal, sim implementa `x_H` agora e não conduz à
  maioria terminal uma rodada depois, produzindo o cutoff `x_H>=beta o`;
- com `n_Y<=k-2`, a proposta falha sob os dois votos de `H`; a continuação
  terminal-majoritária é `beta o` e independente da crença, de modo que a
  regra de sim na indiferença seleciona sim.

As fórmulas de `Pi_E`, `Pi_S`, `Pi_P` e delay usam apenas `x_H=0` na classe de
exclusão e os limiares pivotais preservados nas classes de inclusão. Suas
diferenças, cutoffs e cinco regiões permanecem iguais. A strictness do desvio
impede uma nova família ótima indexada por `x_H>0`.

### 5.4 Escopo da invariância

O candidato não afirma que o assessment PBE completo é invariável. Ele
registra expressamente que a lei de voto de `H` e possivelmente os posteriores
fora do caminho mudam em propostas não pivotais com `x_H>0`. A invariância é
restrita aos resultados, payoffs, cutoffs, classes e multiplicidades já
reportados. Essa restrição é essencial e está refletida nos dois PASS.

### 5.5 Blast radius

B.2 apenas herda o resultado terminal-majoritário corrigido de B.1; B.4 é um
ramo de unanimidade no qual `H` permanece pivotal; B.5 usa os mesmos vetores
`(beta ell,beta h)`, `(beta h,beta h)` e `(ell,h)`; B.6 subtrai esses vetores
dos benchmarks públicos. Não foi encontrada dependência adicional da fórmula
antiga `x_H+o` nesses objetos.

## 6. Correções perigosas e decisões do autor

Nenhuma correção foi proposta ou autorizada. Em particular, esta adjudicação
não autoriza restaurar `x_H+o`, introduzir teto para `x_H`, modificar a
disciplina de crenças, estender a alegação à correspondência completa de
assessments ou reabrir qualquer fundamental do modelo.

## 7. Itens não resolvidos

Nenhum item material permanece não resolvido no artefato adjudicado. O texto
antigo ainda presente em `formal_model_v6.Rmd` está fora deste PASS e deverá
ser objeto de uma etapa posterior de implementação e revisão, caso autorizada.

## 8. Veredicto da adjudicação

`NO_CONFIRMED_DEFECTS` para o candidato no SHA-256
`f510f82eb0f9f6e3e7cc8a59a6d26724cea3cff7ee53da2d1eabdbb3c3264665`.

Este veredicto sustenta os dois `PASS — 0/0/0` apenas no boundary declarado.
Não congela a prova, não cobre o manuscrito, não autoriza migração, tag, merge
ou push e não substitui a consulta técnica externa prevista no protocolo.
