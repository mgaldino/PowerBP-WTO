# Adjudicação independente final — derivação B.1/B.3 sob exclusão

## 1. Identidade da fonte e do contrato

- **Artefato adjudicado:**
  `quality_reports/2026-09-01_b1_b3_exclusion_derivation.md`
- **SHA-256 recalculado:**
  `2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256`
- **Commit do candidato:** `ddb5c48c97daf5e353b96d89345ceaceea7d732a`
- **Integridade:** confirmada. O arquivo tem 438 linhas, é UTF-8 legível e o
  hash coincide com o boundary dos dois pareceres.
- **Argument contract:** não requerido (`contract.required=false`).

Pareceres adjudicados:

| ID | Papel | Artefato | SHA-256 |
|---|---|---|---|
| R1 | design formal | `quality_reports/2026-09-02_b1_b3_formal_design_review_round2.md` | `15940c12a7786d94249c819b417689970708d731cb12007db59ec7263250d65a` |
| R2 | auditoria game-teórica adversarial | `quality_reports/2026-09-02_b1_b3_game_theory_audit_round2.md` | `fcf9bee5188285d085a8b5baeb6fb6e69c163fc271d689493845936c0839dd0a` |

Os dois pareceres estão fixados no commit
`e85e606c4d40c584a261b9063d068361ea134f64`. Ambos identificam o mesmo
candidato por caminho, hash e commit, cobrem integralmente o escopo B.1--B.6 e
declaram `PASS — 0 CRITICAL / 0 IMPORTANT / 0 MINOR`.

A independência está preservada: os pareceres foram produzidos por agentes
distintos, em papéis diferentes, e cada relatório declara não ter lido o outro
parecer desta rodada. Cada revisor criou somente seu próprio relatório e não
editou o candidato, o manuscrito ou os inputs normativos. O fato de os dois
relatórios terem sido fixados no mesmo commit não altera essa separação de
produção.

## 2. Disposição executiva

**Veredicto: `NO_CONFIRMED_DEFECTS`.**

A concordância dos revisores não foi tomada como prova. A adjudicação voltou ao
candidato, ao manuscrito e às decisões normativas, refez o desvio, a contagem
da quota, os três casos de `n_Y`, as diferenças de payoff, os desempates e o
blast radius de B.2--B.6. Nenhum defeito confirmado, parcial ou não resolvido
permanece nos bytes adjudicados.

| Status | Contagem |
|---|---:|
| `CONFIRMED` | 0 |
| `PARTIAL` | 0 |
| `REFUTED` | 0 |
| `UNRESOLVED` | 0 |

## 3. Findings normalizados

Os pareceres R1 e R2 não apresentam finding adverso: ambos reportam
`PASS 0/0/0`. Portanto, não há finding a normalizar ou encaminhar para
implementação nesta rodada.

## 4. Evidência e raciocínio por objeto verificado

### 4.1 Fechamento de M1

O defeito anterior era a omissão da propriedade que preserva os votos fracos
quando `x_H` é transferido ex ante para a alocação do proponente. Ele está
fechado no candidato:

- linhas 80--84 declaram que, nas duas aplicações, cada voto fraco depende
  apenas da própria alocação: limiar zero na maioria terminal e
  `w=beta/m` em Round 1;
- linhas 92--96 usam expressamente esses limiares para preservar os votos;
- linhas 114--118 incluem a propriedade na lista de hipóteses do lema.

A propriedade não é apenas declarada. O manuscrito determina que um respondedor
fraco compara sua alocação com a continuação se seu voto transformar passagem
em falha (`formal_model_v6.Rmd:1378-1382`). Na maioria terminal essa continuação
é zero; em Round 1 a continuação terminal-majoritária de qualquer Estado fraco
é `1/m`, independentemente da posterior e do voto de `H`, de modo que o limiar
é `beta/m`. Manter cada `x_j` fixo preserva, portanto, cada ballot fraco.

### 4.2 Limite correto de M2

M2 era uma instrução para a futura migração de B.1, não um convite a alterar
outros resultados. O candidato respeita esse limite:

- linhas 126--128 usam os `m-1` respondedores fracos e provam
  `k=floor((m+1)/2)<=m-1` para `m>=3`;
- linhas 183--197 incorporam a contagem no texto inglês e eliminam também
  pagamentos positivos aos respondedores, pois eles votam sim até com zero.

Por paridade, se `m=2r`, então `k=r<=2r-1`; se `m=2r+1`, então
`k=r+1<=2r=m-1`. Logo existem respondedores fracos suficientes para passagem
sem `H` em todo o domínio, inclusive no caso-limite `m=3`.

### 4.3 Limite correto de M3

M3 exigia separar a dominância no ramo não pivotal dos limiares no ramo
pivotal. O candidato o faz sem mudar fórmulas:

- linhas 266--270 fixam `x_H=0` somente quando `n_Y>=k`, usam
  `x_H=beta ell` ou `x_H=beta h` somente quando `n_Y=k-1` e classificam o
  ramo restante como delay;
- linhas 330--335 fornecem a transição inglesa exata para a futura B.3.

Assim, “relevant type threshold” não é reutilizado indevidamente na classe não
pivotal. A redução a exclusão, screening, pooling e delay permanece completa.

### 4.4 Disposição de M4 preservada

M4 havia sido refutado como reparo obrigatório, e não foi reintroduzido. A
Seção 6.3 do candidato (linhas 256--262) diz que, se `n_Y<=k-2`, a proposta
falha após qualquer voto de `H`, ambos os ballots entregam a mesma continuação
`beta o` e `T^Y` seleciona sim. A posterior pode diferir depois de `Y` e `N`,
conforme a consistência estrutural, mas a maioria terminal entrega o mesmo
payoff ao tipo `o` para toda posterior admissível. Já quando `n_Y>=k`, a
proposta passa e não há continuação. A distinção substantiva está completa;
nenhuma nova alteração é necessária.

### 4.5 Desvio, factibilidade e simultaneidade

Para uma proposta não pivotal com `x_H>0`, o candidato constrói

\[
x'_H=0,\qquad x'_i=x_i+x_H,\qquad x'_j=x_j\quad(j\neq i,H).
\]

A soma agregada é preservada, todas as coordenadas continuam não negativas e
não existe cap individual. As alocações e os votos dos respondedores não mudam;
se o voto de `H` mudar, a quota continua satisfeita pelos votos fracos. Sob a
proposta original, o proponente recebe `x_i`, quer `H` vote sim, quer vote não.
Sob a proposta desviada, recebe `x_i+x_H`. O ganho é exatamente `x_H>0` em
cada tipo e história. Trata-se de proposta alternativa feita antes do ballot,
não de reversão condicionada a um voto observado; a simultaneidade é
respeitada.

### 4.6 Quota e três casos de `n_Y`

Os casos são exaustivos e usam a datação correta:

1. `n_Y>=k`: a proposta passa sem `H`; um tipo `o` compara `x_H` com `o`,
   ambos imediatos. Ele vota sim sse `x_H>=o`. O desvio elimina estritamente
   todo `x_H>0`, e a exclusão ótima tem `x_H=0`.
2. `n_Y=k-1`: `H` é pivotal; sim implementa `x_H` agora e não leva à maioria
   terminal. O limiar é `x_H>=beta o`.
3. `n_Y<=k-2`: mesmo o sim de `H` não satisfaz a quota; ambos os votos geram
   continuação `beta o`, ainda que possam gerar posteriors diferentes, e
   `T^Y` seleciona sim.

Não há mistura entre o limiar imediato `o` do primeiro ramo e o limiar
descontado `beta o` do segundo.

### 4.7 Candidatos, cutoffs, desempates e multiplicidades

Os payoffs rederivados são

\[
\Pi_E=1-kw,\quad
\Pi_S(p)=(1-p)[1-(k-1)w-\beta\ell]+pw,\quad
\Pi_P=1-(k-1)w-\beta h,\quad
\Pi_D=w.
\]

Como `k+1<=m` para `m>=3` e `beta<1`,

\[
\Pi_E-\Pi_D=1-\frac{\beta(k+1)}m>0.
\]

As diferenças decisivas continuam

\[
\Pi_P-\Pi_E=\beta(1/m-h)
\]

e

\[
\Pi_S(p)-\Pi_E
=(1-p)\beta(1/m-\ell)-p[1-\beta(k+1)/m].
\]

Logo os cutoffs `p_{S=P}` e `p_{S=E}` e as cinco regiões não mudam. Em empates
com screening, seu payoff esperado a `H` permanece menor e o tie-break o
seleciona. Em `h=1/m`, exclusão e pooling continuam empatados para o
proponente; a comparação entre `(1-p)ell+ph` e `beta h` preserva as duas
seleções e o segmento residual com peso comum. O desvio estrito impede uma
nova família ótima parametrizada por `x_H>0`; apenas as multiplicidades já
reportadas — identidades dos respondedores e segmento comum — sobrevivem.

### 4.8 Redação inglesa e blast radius

Os textos ingleses candidatos nomeiam o sujeito, o objeto aprovado, o
destinatário de `x_H` e o ganho do proponente. A B.1 explicita os `m-1`
respondedores, `k<=m-1`, a ação de `H`, o não pagamento de `x_H`, a eliminação
dos pagamentos fracos e o resultado terminal único. A B.3 explicita o limiar
fraco belief-free, os três casos de `n_Y` e a transição que separa dominância
não pivotal de limiares pivotais.

O alcance downstream também é correto:

- B.2 apenas reutiliza o resultado terminal-majoritário preservado;
- B.4 trata de unanimidade, na qual um não de `H` impede aprovação;
- B.5 mantém os vetores `(beta ell,beta h)`, `(beta h,beta h)` e `(ell,h)`;
- B.6 faz subtrações afins desses vetores e preserva o segmento conjunto.

O candidato não alega invariância do assessment ou da estratégia PBE completa:
a resposta de `H` muda fora do caminho quando `n_Y>=k` e `x_H>0`. A invariância
afirmada limita-se aos resultados ótimos, payoffs, classes, cutoffs e
multiplicidades reportadas.

## 5. Correções inseguras e decisões do autor

Não há correção proposta, segura ou insegura, porque não há finding confirmado
ou parcial nesta rodada. Permanecem decisões autorais mantidas, não findings:

- acordo e outside option são mutuamente exclusivos;
- `x_H` não é pago a ninguém após exclusão e não reverte ao proponente;
- não há cap individual além da restrição agregada;
- as-if-pivotal, `T^Y` e consistência estrutural continuam vigentes;
- o gate de derivação permanece separado da migração do manuscrito.

## 6. Itens não resolvidos

Nenhum.

## 7. Checks mecânicos registrados

1. `shasum -a 256` confirmou o candidato e os dois pareceres nos hashes
   declarados.
2. `git show` confirmou o candidato no commit `ddb5c48` e os pareceres no
   commit `e85e606`.
3. Leituras integrais e numeradas verificaram as 438 linhas do candidato, as
   289 linhas de R1 e as 327 linhas de R2, além das definições, proposições,
   A.1--A.2 e B.1--B.6 do manuscrito.
4. A busca literal por `x_H+o` encontrou no manuscrito apenas as duas passagens
   antigas e deliberadamente ainda não migradas, em B.1 e B.3. No candidato, a
   expressão ocorre apenas quando identificada como fórmula antiga ou erro.
5. As desigualdades de quota foram verificadas por paridade, e as identidades
   de payoff foram rederivadas algebricamente, sem usar checagem numérica como
   prova.
6. `git diff --check` foi executado sobre os dois records desta adjudicação.
7. O JSON foi validado com o script canônico de `adjudicate-review` contra o
   hash do artefato; o resultado foi `VALID`.

## 8. Veredicto da adjudicação

**`NO_CONFIRMED_DEFECTS`.**

Os dois `PASS 0/0/0` são sustentados pela verificação independente do candidato
e das fontes normativas. Não há finding a encaminhar a um implementador e nada
material permanece não resolvido. Este veredicto cobre exclusivamente o
candidato no SHA-256
`2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256`.
Não autoriza tag, migração para `formal_model_v6.Rmd`, merge, push ou promoção
para `main`.
