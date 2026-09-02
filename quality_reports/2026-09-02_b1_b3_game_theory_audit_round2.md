# Auditoria game-teórica adversarial final — B.1/B.3 e exclusão

**Data:** 2026-09-02

**Tipo de jogo:** barganha dinâmica de dois rounds com informação privada,
ballots simultâneos e PBE em estratégias puras, sujeito às disciplinas
declaradas de voto e de crenças

**Artefato auditado:**
`quality_reports/2026-09-01_b1_b3_exclusion_derivation.md`

**Commit informado e confirmado:**
`ddb5c48c97daf5e353b96d89345ceaceea7d732a`

**SHA-256 recalculado:**
`2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256`

**Integridade:** `PASS`. O hash recalculado coincide com o boundary do mandato.

**Independência:** não li o relatório do outro parecerista deste round. Esta
auditoria é somente leitura em relação ao candidato, ao manuscrito e aos
inputs normativos; o único arquivo criado é este relatório.

## 1. Escopo e veredicto

O objetivo foi tentar refutar integralmente o candidato reparado, com atenção
especial ao lema de eliminação de concessão não pivotal, aos três casos de
`n_Y`, ao desconto, às crenças após falha, aos cutoffs e às multiplicidades.
Também conferi se os quatro findings externos foram implementados exatamente
nos limites da adjudicação.

**VEREDICTO: `PASS — 0 CRITICAL / 0 IMPORTANT / 0 MINOR`.**

Não encontrei contraexemplo, condição ausente, erro de timing, mudança de
cutoff, nova multiplicidade ótima ou defeito textual substantivo nos bytes
auditados. O `PASS` cobre somente o memorando no hash acima. Não cobre os
bytes ainda não migrados de `formal_model_v6.Rmd` e não autoriza tag,
migração, merge ou push.

## 2. Inputs conferidos

| Artefato | SHA-256 recalculado | Uso |
|---|---|---|
| `formal_model_v6.Rmd` | `374bbd4b381a9be797fecadeca875fcd42ba8b946191ad389bd8b7994f70ae43` | primitivas, proposições, A.1--A.2 e Appendix B completa |
| `quality_reports/2026-09-01_decisao_exclusao_payoffs_e_fundamentos.md` | `5b165b65e3ade3ee1ff67c714fddbd35dd030b8e5b315b447132fd7f7c6e0982` | regra normativa, inclusive a emenda de não pagamento de `x_H` |
| `quality_reports/2026-09-01_decisao_structural_consistency_baseline.md` | `7e671effa200117228d837201a5151922c4fd014af93758de38616b04a8346d5` | crenças depois de votos e invariância em coordenadas fracas |
| `notes/2026-09-01_explicacao_completa_correcao_exclusao_teto.md` | `ea1cdae25e512543ded0af35456f2b2b22458a905d99a7592309dc798a1c1e0a` | explicação auxiliar, lida sob a atualização que supersede a reversão |
| `quality_reports/external_reviews/2026-09-01_consulta_tecnica_chatgpt_web_b1_b3_exclusion.md` | `cae750f8d5cc6e8fdab68d07d1d9fe7eb08050a8e43642396dc78c2e8cbeac3c` | quatro findings externos M1--M4 |
| `quality_reports/adjudication/b1_b3_exclusion_external/f510f82eb0f9/adjudication_round1.md` | `97b681a3450110c0e7c53f49c274946067192ece029656093cd19b03aa190a0e` | disposições `CONFIRMED`, `PARTIAL` e `REFUTED` |

Prevalece a emenda normativa: se `H` vota não e a proposta passa sem ele,
`H` recebe somente `o` e `x_H` não é pago a ninguém. Não há reversão de
`x_H` ao proponente. O desvio auditado é uma nova proposta que transfere a
concessão ex ante, não uma reversão contingente ao voto.

## 3. Método adversarial

Usei backward induction local e procurei falhas nas seguintes direções:

1. uma estratégia de voto fraco que dependesse do pacote completo e quebrasse
   a preservação dos ballots;
2. perda de factibilidade ao mover `x_H` para `x_i`, inclusive com slack na
   pie e sem cap individual;
3. mudança do voto de `H` que alterasse quota, payoff do proponente, posterior
   ou continuação;
4. insuficiência de respondedores nos menores valores admissíveis de `m`;
5. confusão entre o payoff imediato `o` no ramo que passa e a continuação
   descontada `beta o` no ramo que falha;
6. histórias em que o voto de `H` altera crenças depois de uma falha;
7. aceitação alta sem aceitação baixa, candidatos adicionais ou famílias
   ótimas com `x_H>0`;
8. falhas nos casos-limite `p=0`, `p=1`, `ell=1/m`, `h=1/m`, nos cutoffs e
   nos desempates;
9. mudança nos vetores de B.5, nas subtrações de B.6 ou na dimensão do
   segmento residual;
10. expansão indevida do reparo para além das disposições adjudicadas M1--M4.

## 4. Reconstrução e stress tests

### 4.1 Premissa de voto fraco e fechamento de M1

O candidato agora declara antes da prova do lema que, nas duas aplicações,
o ballot de um respondedor fraco depende apenas de sua própria alocação:

- na maioria terminal, o limiar é zero;
- em Round 1 sob maioria, o limiar é
  `w=beta/m`, porque sua continuação terminal-majoritária é `1/m` para toda
  posterior admissível e para qualquer voto de `H`.

Essa premissa é suficiente. Uma proposta de Estado fraco não move a crença, e
o desvio mantém cada `x_j` respondente fixo. Mesmo quando o voto de um
respondedor é avaliado no evento em que seria pivotal, os dois vetores
contrafactuais diferem somente numa coordenada fraca; a consistência
estrutural não cria sinal sobre o tipo por essa mudança. Além disso, qualquer
posterior que possa seguir a falha é irrelevante para seu payoff de maioria
terminal, que permanece `1/m`.

Assim, o salto lógico encontrado em M1 foi fechado nas linhas 80--84 e 92--96
do candidato, e a enumeração de hipóteses nas linhas 114--118 já não afirma
que somente três propriedades bastam.

### 4.2 Factibilidade, lucratividade estrita e simultaneidade

Para uma proposta não pivotal com `x_H>0`, o candidato constrói

\[
x'_H=0,\qquad x'_i=x_i+x_H,\qquad
x'_j=x_j\quad(j\ne i,H).
\]

A soma agregada é exatamente preservada:

\[
x'_H+\sum_{j\in W}x'_j
=x_H+\sum_{j\in W}x_j\leq1.
\]

Todas as coordenadas continuam não negativas, não existe cap individual e o
argumento vale também quando a proposta original deixa slack. Como as
alocações fracas não mudam, os mesmos `k` respondedores continuam votando
sim. Se `H` mudar seu voto depois da redução de `x_H`, a proposta ainda passa
sem ele.

Sob a proposta original, o proponente recebe `x_i` tanto se `H` votar sim
quanto se votar não: no primeiro caso `x_H` é pago a `H`; no segundo, não é
pago a ninguém. Sob a proposta desviada, o proponente recebe `x_i+x_H`. O
ganho é `x_H>0` estado por estado, e não apenas em esperança.

Não há condicionamento a um ballot observado. O proponente escolhe `x'` antes
dos votos simultâneos. Portanto, o desvio não reintroduz a reversão contingente
descartada pela decisão normativa e não viola a simultaneidade.

### 4.3 Contagem de votos: `k<=m-1` e `k+1<=m`

Há `m-1` respondedores fracos, porque o proponente é um dos `m` Estados
fracos. Para `m>=3`,

\[
k=\left\lfloor\frac{m+1}{2}\right\rfloor\leq m-1.
\]

No menor caso admissível, `m=3`, há exatamente dois respondedores e `k=2`;
logo a exclusão continua possível sem folga. A mesma desigualdade implica
`k+1<=m`. Assim,

\[
1-\frac{\beta(k+1)}m\geq1-\beta>0,
\]

pois `0<beta<1`. Isso valida tanto a disponibilidade dos votos de exclusão
quanto a dominância estrita de exclusão sobre delay em todo o domínio.

### 4.4 B.1

Na maioria terminal, cada respondedor aceita zero. Como `k<=m-1`, a proposta
passa sem `H`. Um `H` não pivotal compara `x_H` após sim com `o` após não e,
portanto, vota sim se e somente se `x_H>=o`, com sim na igualdade. O lema
elimina todo `x_H>0`; pagamentos positivos aos respondedores também podem ser
movidos ao proponente sem alterar seus votos. Logo o resultado ótimo é único:
`x_H=0`, pagamentos respondentes iguais a zero, `x_i=1`, `H` vota
estritamente não porque `o>0` e recebe `o`.

Sob unanimidade terminal, `H` é pivotal e o limiar continua `o`. Em Round 1,
inclusão custa `(k-1)beta/m+beta o`, enquanto exclusão custa `k beta/m`.
Portanto, inclusão é selecionada exatamente quando `o<=1/m`. Em `o=1/m`, o
proponente empata e o tie-break seleciona inclusão porque `beta o<o`.

O texto inglês candidato de B.1 contém a contagem correta, a regra de voto
não pivotal, o desvio estrito, a eliminação dos pagamentos respondentes e a
conclusão de unicidade. Não depende da antiga soma `x_H+o`.

### 4.5 B.3: três casos exaustivos de `n_Y`

**Caso `n_Y>=k`.** Os votos fracos passam a proposta. Cada tipo `o` compara
`x_H` com `o`, sem desconto, porque ambos são payoffs do encerramento no
Round 1. O lema elimina estritamente `x_H>0`. O candidato ótimo fixa
`x_H=0`, paga `w` a exatamente `k` respondedores e entrega
`Pi_E=1-kw` ao proponente. Os dois tipos votam não e recebem suas outside
options.

**Caso `n_Y=k-1`.** `H` é exatamente pivotal. Sim implementa `x_H` agora;
não faz a proposta falhar e leva à maioria terminal. O limiar correto é
`beta o`, pois a outside option terminal está a um round de distância. A
monotonicidade `ell<h` deixa somente a aceitação do tipo baixo, implementada
por `x_H=beta ell`, e a aceitação de ambos, implementada por
`x_H=beta h`; aceitação somente do tipo alto é impossível.

**Caso `n_Y<=k-2`.** Mesmo somando o sim de `H`, há no máximo `k-1` votos
adicionais. A proposta falha após qualquer voto de `H`. Os votos podem gerar
posteriors distintos, inclusive uma coordenada livre quando o denominador de
Bayes é zero, mas a continuação majoritária dá `beta o` ao tipo `o` para toda
posterior admissível. `H` é indiferente e a convenção de sim na igualdade
seleciona sim. O ramo não cria nova classe de resultado.

Os três casos são exaustivos e não misturam o limiar imediato `o` do primeiro
com o limiar descontado `beta o` do segundo.

### 4.6 Candidatos, factibilidade e cutoffs

Depois da eliminação não pivotal, restam exatamente exclusão, screening,
pooling e delay:

\[
\Pi_E=1-kw,
\]

\[
\Pi_S(p)=(1-p)[1-(k-1)w-\beta\ell]+pw,
\]

\[
\Pi_P=1-(k-1)w-\beta h,
\qquad \Pi_D=w.
\]

As diferenças do candidato foram rederivadas:

\[
\Pi_P-\Pi_E=\beta(1/m-h),
\]

\[
\Pi_S-\Pi_E
=(1-p)\beta(1/m-\ell)
-p[1-\beta(k+1)/m].
\]

Quando screening ou pooling pode vencer exclusão, sua factibilidade segue do
respectivo tipo relevante ser no máximo `1/m`: o custo é então no máximo
`kw<1`. Os cutoffs `p_{S=P}` e `p_{S=E}` continuam sendo as raízes das mesmas
diferenças; a correção de exclusão não aparece nessas expressões.

Nos empates com screening, seu payoff esperado a `H` é `beta q`, onde
`q=(1-p)ell+ph`, contra `q` em exclusão ou `beta h` em pooling. Isso preserva
o desempate em favor de screening. No knife edge `h=1/m`, exclusão e pooling
continuam empatando para o proponente; a comparação `q` versus `beta h`
preserva as duas seleções puras e o segmento residual na igualdade.

Nenhum ponto desse segmento introduz uma família ótima de concessões
positivas não pivotais: tais concessões continuam estritamente subótimas. A
multiplicidade por permutação das identidades dos respondedores também não é
afetada.

### 4.7 Appendix B downstream

- **B.2:** herda somente o resultado terminal-majoritário corrigido. Como o
  resultado continua `x_H=0`, payoff 1 ao proponente e `o` a `H`, o cutoff
  terminal de unanimidade permanece.
- **B.4:** é uma prova de unanimidade; não há aprovação após não de `H` e,
  portanto, não usa a contabilidade corrigida de exclusão.
- **B.5:** os vetores majoritários permanecem
  `(beta ell,beta h)`, `(beta h,beta h)` e `(ell,h)` para screening, pooling
  e exclusão.
- **B.6:** faz subtrações afins desses vetores. A dimensão comum do segmento
  residual e a exigência de um único peso conjunto não mudam.

O blast radius semântico da Appendix B está corretamente delimitado no
candidato.

## 5. Resposta aos findings externos adjudicados

| Finding | Disposição adjudicada | Resultado desta auditoria |
|---|---|---|
| M1 | `CONFIRMED`: reparar o lema no memorando | **Fechado.** A independência dos limiares fracos é premissa expressa, usada na prova e incluída na enumeração final das hipóteses. |
| M2 | `PARTIAL`: corrigir a contagem somente na futura migração de B.1 | **Implementado no limite correto.** O candidato de B.1 usa `m-1` respondedores e `k<=m-1`; não altera outras fórmulas ou resultados. |
| M3 | `PARTIAL`: separar dominância não pivotal e limiares pivotais na futura transição de B.3 | **Implementado no limite correto.** A transição fixa `x_H=0` apenas em `n_Y>=k`, reserva `beta ell`/`beta h` a `n_Y=k-1` e mantém delay no caso restante. |
| M4 | `REFUTED`: nenhuma correção obrigatória | **Corretamente não alterado.** A Seção 6.3 já cobre a falha, a possível mudança de posterior e a continuação belief-free; a tabela separa esse ramo do ramo que passa. |

O diff do commit `ddb5c48` confirma que M1 foi um reparo local do lema, M2 e
M3 foram incorporados apenas ao texto candidato e à derivação que os sustenta,
e M4 não foi convertido em alteração obrigatória.

## 6. Checklist game-teórico

| Item | Status | Evidência resumida |
|---|---|---|
| Histórias e timing distinguidos | `PASS` | passagem imediata usa `o`; falha usa `beta o` |
| Factibilidade do desvio | `PASS` | soma preservada, coordenadas não negativas, sem cap |
| Lucratividade estrita | `PASS` | ganho do proponente igual a `x_H>0` em ambos os votos de `H` |
| Simultaneidade | `PASS` | desvio é proposta ex ante; não condiciona em votos realizados |
| Votos fracos | `PASS` | limiares próprios zero e `beta/m`, belief-free |
| Quota | `PASS` | `k<=m-1` e `k+1<=m` para `m>=3` |
| Três casos de `n_Y` | `PASS` | não pivotal, pivotal e falha inevitável são exaustivos |
| Crenças off-path | `PASS` | podem mudar após falha, mas continuação majoritária é belief-free |
| Existência dos candidatos | `PASS` | exclusão factível; inclusão relevante factível quando competitiva |
| Cutoffs e tie-breaks | `PASS` | mesmas diferenças e mesmos payoffs de `H` |
| Vetores B.5/B.6 | `PASS` | nenhum componente depende de `x_H+o` |
| Multiplicidades | `PASS` | nenhuma família nova em `x_H`; identidades e segmento comum preservados |
| Texto candidato B.1/B.3 | `PASS` | regra nova, contagem e transição downstream explicitadas |
| M1--M4 | `PASS` | fechamento e limites coincidem com a adjudicação |

## 7. Findings

### CRITICAL

Nenhum (`0`).

### IMPORTANT

Nenhum (`0`).

### MINOR

Nenhum (`0`).

## 8. Formalização possível em Lean 4

Sem constituir requisito para este gate, os componentes de menor custo para
formalização futura seriam:

| Componente | Formalizável? | Dificuldade | Ferramenta provável |
|---|---|---|---|
| preservação da factibilidade pelo desvio | sim | baixa | `linarith` |
| ganho estrito `x_H>0` | sim | baixa | `linarith` |
| `k<=m-1` e `k+1<=m` com piso | sim | média | aritmética de naturais e casos de paridade |
| diferenças `Pi_P-Pi_E` e `Pi_S-Pi_E` | sim | baixa | `ring`, `linarith` |
| invariância de crenças/continuação no jogo completo | não sem infraestrutura própria | alta | formalização explícita de histórias e PBE |

## 9. Gate

O memorando no SHA-256
`2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256`
recebe `PASS — 0/0/0` nesta auditoria game-teórica adversarial.

Este parecer não congela o candidato por si só. Não autoriza migração para o
manuscrito, tag, merge, push ou promoção para `main`. Qualquer alteração dos
bytes auditados invalida a cobertura deste parecer e requer novo gate.
