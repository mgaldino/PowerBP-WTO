# Adjudicação independente final — integração manuscrita B.1/B.3

## 1. Identidade da fonte e do contrato

- **Artefato adjudicado:** `formal_model_v6.Rmd`
- **SHA-256 recalculado:**
  `7de0b2eddc20b98509f8fa37a299860f83164b7469097598532aa5cbfbd7a2a7`
- **PDF companheiro:** `formal_model_v6.pdf`
- **SHA-256 recalculado do PDF:**
  `97ff2d5fa3878550a5b6ea77c642b99ad4543aec760e92ff7941495ea552ed00`
- **Commit candidato de migração:**
  `03ab370cce3f06725d805054e6796a8e78e674b0`
- **Tag pré-migração:**
  `v6-pre-b1-b3-exclusion-migration-2026-09-02`, objeto anotado que resolve
  para `8be463f24e3012b75cd76623e167ac3ba1ed7904`
- **Integridade:** confirmada. O Rmd possui 2.648 linhas; o PDF possui 67
  páginas legíveis. Os hashes coincidem com os dois pareceres e com o
  manifesto de migração.

Pareceres adjudicados, ambos fixados no commit
`914f8d3b258f3200247a7cce5bff88b689ee4130`:

| ID | Papel | Artefato | SHA-256 |
|---|---|---|---|
| R1 | game-teórico adversarial | `quality_reports/2026-09-02_b1_b3_manuscript_game_theory_review.md` | `6a0e1ca9ad56f8c5dac608e109c92c24a03355bb0383657c122628a830a1a578` |
| R2 | redação formal e integridade visual | `quality_reports/2026-09-02_b1_b3_manuscript_visual_writing_review.md` | `90b6a2cd709863196e149d156747e1931932adbd9985663c1bb8473cd1f83225` |

Os dois relatórios identificam os mesmos bytes do Rmd, PDF e memorando,
declaram não ter lido um ao outro e reportam
`PASS — 0 CRITICAL / 0 IMPORTANT / 0 MINOR`. Esta adjudicação foi realizada
por agente distinto do implementador e dos dois pareceristas.

### Contrato textual

A substância aprovada foi confrontada com
`quality_reports/2026-09-01_b1_b3_exclusion_derivation.md`, SHA-256
`2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256`.
Esse memorando é um contrato **textual** de migração, não um JSON produzido por
`argument-fidelity-gate`: ele não contém `contract_id`, objeto `source` nem
objeto `gate` no formato exigido pelo schema. Portanto, o objeto `contract` do
JSON desta adjudicação permanece canonicamente com `required=false` e campos
nulos. O memorando foi, ainda assim, verificado integralmente como comparador
normativo; não foi promovido artificialmente a um contrato JSON.

## 2. Disposição executiva

**Veredicto: `NO_CONFIRMED_DEFECTS`.**

A concordância dos dois revisores não foi aceita como evidência suficiente. A
adjudicação recalculou os hashes, leu os pareceres, refez o diff da tag para o
commit candidato, comparou literalmente os novos parágrafos com o memorando,
rederivou os passos game-teóricos, verificou as dependências B.2--B.6 e
inspecionou estrutural e visualmente o PDF. Não há defeito confirmado, parcial
ou não resolvido no escopo exato da integração.

| Status | Contagem |
|---|---:|
| `CONFIRMED` | 0 |
| `PARTIAL` | 0 |
| `REFUTED` | 0 |
| `UNRESOLVED` | 0 |

## 3. Findings normalizados

R1 e R2 não apresentam finding adverso, explícito ou implícito, sobre os bytes
revisados. Ambos reportam `PASS 0/0/0`. Não há finding a normalizar ou a
encaminhar para implementação.

## 4. Evidência e raciocínio

### 4.1 Diff exato e fidelidade de escopo

O diff de `v6-pre-b1-b3-exclusion-migration-2026-09-02` para `03ab370`
contém quatro caminhos: o Rmd, o PDF recompilado, o relatório de migração e o
manifesto. No Rmd há exatamente dois hunks substantivos:

1. `formal_model_v6.Rmd:1390-1402`, abertura terminal-majoritária de B.1;
2. `formal_model_v6.Rmd:1439-1462`, abertura de B.3 e transição para os quatro
   candidatos.

Nenhuma primitiva, proposição, fórmula de payoff, cutoff, tabela, figura,
referência, trecho de B.2 ou trecho de B.4--B.6 mudou. Não existe diff adicional
fora dos quatro caminhos declarados.

A nova B.1 reproduz a Seção 5.4 do contrato textual: usa `m-1` respondedores e
`k<=m-1`, compara `x_H` com `o`, prova o desvio estrito, elimina pagamentos
positivos aos respondedores e obtém o resultado terminal único. A nova B.3
reproduz a Seção 6.5 e sua transição: declara o limiar fraco belief-free,
separa os três casos de `n_Y`, reserva `beta o` ao ramo pivotal e distingue
dominância não pivotal de redução a `beta ell` e `beta h`. Não há omissão nem
extensão substantiva.

### 4.2 Consistência com as regras governantes

As regras relevantes do manuscrito permanecem coerentes:

- `formal_model_v6.Rmd:302-319` fixa `m>=3`, o tipo
  `o in {ell,h}`, não negatividade e soma das alocações menor ou igual a um;
- `formal_model_v6.Rmd:331-349` fixa a quota, a simultaneidade e os payoffs
  mutuamente exclusivos: sim paga `x_H`; passagem sem `H` paga somente `o` e
  deixa `x_H` sem destinatário;
- `formal_model_v6.Rmd:351-381` distingue payoff imediato de continuação
  descontada e permite que votos de `H` gerem histórias públicas distintas;
- `formal_model_v6.Rmd:412-434` e `1360-1382` fixam PBE, consistência
  estrutural, voto fraco as-if-pivotal e sim na indiferença.

Os parágrafos migrados usam exatamente essas regras, sem introduzir nova
primitiva, cap, crença ou refinamento.

### 4.3 Quota, desvio e maioria terminal

Há `m-1` respondedores fracos porque o proponente é um dos `m` Estados fracos.
Para `m>=3`,

\[
k=\left\lfloor\frac{m+1}{2}\right\rfloor\leq m-1
\quad\text{e}\quad k+1\leq m.
\]

As desigualdades foram confirmadas por paridade; uma enumeração mecânica para
`m=3,...,10000` também passou, com igualdade `k=m-1=2` no menor caso.

Quando os votos fracos já bastam e `x_H>0`, a proposta alternativa

\[
x'_H=0,\qquad x'_i=x_i+x_H,\qquad x'_j=x_j\quad(j\neq i,H)
\]

preserva a soma, a não negatividade, os pagamentos e os ballots fracos. Se o
voto de `H` mudar, a passagem continua garantida. O proponente recebe `x_i`
sob a proposta original, qualquer que seja o voto de `H`, e `x_i+x_H` sob a
nova proposta. O ganho é `x_H>0`, estado por estado. É uma proposta alternativa
ex ante, não uma reversão condicionada ao ballot.

Na maioria terminal, pagamentos positivos aos respondedores também podem ser
reduzidos a zero, pois zero já induz sim. O resultado único
`x_H=0`, zero aos respondedores, um ao proponente e `o` a `H` sustenta
literalmente `prop:public` e `prop:terminal`.

### 4.4 Três casos de `n_Y`, datação e crenças

Os casos da B.3 são disjuntos e exaustivos:

1. `n_Y>=k`: passagem sem `H`; o tipo `o` compara `x_H` com `o`, sem
   desconto, e o desvio elimina todo `x_H>0`.
2. `n_Y=k-1`: `H` é pivotal; sim implementa `x_H` agora, enquanto não leva à
   maioria terminal. O limiar correto é `x_H>=beta o`.
3. `n_Y<=k-2`: mesmo o sim de `H` não satisfaz a quota; ambos os votos levam
   à continuação `beta o`, e a convenção seleciona sim.

No primeiro caso não há continuação. Nos casos que falham, as crenças depois
dos votos de `H` podem diferir, mas a maioria terminal dá `o` a cada tipo de
`H` e valor ex ante `1/m` a cada Estado fraco para toda posterior admissível.
Por isso o limiar fraco `w=beta/m`, o limiar pivotal `beta o` e a indiferença
no terceiro caso são belief-free. Nenhum passo permite a `H` observar o vetor
realizado antes do ballot simultâneo.

### 4.5 Candidatos, cutoffs e multiplicidades

A redução deixa exatamente exclusão, screening, pooling e delay:

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

As identidades

\[
\Pi_E-\Pi_D=1-\frac{\beta(k+1)}m>0,
\quad
\Pi_P-\Pi_E=\beta(1/m-h)
\]

e

\[
\Pi_S(p)-\Pi_E
=(1-p)\beta(1/m-\ell)-p[1-\beta(k+1)/m]
\]

permanecem válidas. Assim, `p_{S=P}`, `p_{S=E}`, as cinco regiões de
`prop:majority`, os desempates em favor de screening e o knife edge
`h=1/m` não mudam. O desvio estrito exclui uma nova família ótima em
`x_H>0`; permanecem apenas a multiplicidade por identidade dos respondedores
e o segmento residual com peso comum já reportados.

A correspondência completa de estratégias fora do caminho muda, pois `H` pode
votar sim em propostas não pivotais com `x_H>=o`. O manuscrito integrado não
alega sua invariância; preserva apenas resultados, payoffs, classes, cutoffs e
multiplicidades ótimas, conforme o contrato textual.

### 4.6 Dependências B.2--B.6

- B.2 reutiliza a maioria terminal corrigida e mantém `p^*` sob unanimidade.
- B.4 é uma prova de unanimidade; um não de `H` impede passagem, de modo que a
  regra de exclusão majoritária não entra.
- B.5 mantém os vetores majoritários
  `(beta ell,beta h)`, `(beta h,beta h)` e `(ell,h)`.
- B.6 subtrai esses vetores dos benchmarks públicos; as rents, os conjuntos
  vazios e o segmento atômico permanecem.

Não há alteração downstream que exija nova fórmula, cutoff, proposição ou
tabela.

### 4.7 Integridade e correspondência do PDF

`pdfinfo` reportou PDF 1.7, não criptografado, 67 páginas letter, rotação zero,
`Suspects: no`. `pypdf` percorreu as 67 páginas, encontrou media boxes
uniformes, recurso em todas as páginas, 108.147 caracteres extraídos e nenhuma
página vazia ou quase vazia. A extração alcança as referências finais.

As páginas 35--39 foram renderizadas a 180 dpi e inspecionadas diretamente. As
páginas 36--38 contêm B.1, B.2, toda B.3 e o início de B.4. Não há clipping,
sobreposição, glifo ausente, caixa preta, equação quebrada, margem invadida ou
hierarquia/paginação defeituosa. A extração textual contém a nova contagem, a
comparação `x_H` versus `o`, os três casos de `n_Y`, `beta o` e a transição aos
quatro candidatos. O PDF corresponde, portanto, ao Rmd integrado.

## 5. Correções inseguras, decisões do autor e limitações

Não há correção proposta porque não há finding confirmado ou parcial. As
decisões autorais sobre payoffs mutuamente exclusivos, não pagamento de `x_H`,
ausência de cap e disciplinas de voto/crença permanecem intactas.

Limitações registradas:

- `qpdf` não está instalado. Isso não deixa item material não resolvido:
  `pdfinfo`, `pypdf`, extração Poppler e renderização direta forneceram checks
  estruturais e visuais independentes e concordantes.
- O escopo é a integração B.1/B.3, não uma nova certificação global do paper.
  A marca preexistente `[AUTHOR: P1]` em `formal_model_v6.Rmd:356` já constava
  na tag pré-migração e não foi tocada; não é finding desta integração nem
  recebe aprovação deste record.
- O memorando é contrato textual e não foi representado como contrato JSON no
  campo `contract`, pelos limites do schema 1.0 explicados na Seção 1.

## 6. Itens não resolvidos

Nenhum item material no escopo adjudicado.

## 7. Checks mecânicos registrados

1. `shasum -a 256` confirmou Rmd, PDF, memorando e os dois pareceres.
2. `shasum -a 256 -c
   quality_reports/2026-09-02_b1_b3_manuscript_migration_manifest.sha256`
   retornou `OK` para os quatro artefatos.
3. `git cat-file` confirmou a tag anotada e seu commit; `git diff` confirmou
   dois hunks substantivos no Rmd e nenhum caminho inesperado.
4. Buscas literais por `x_H+o` e `x_H + o` retornaram zero ocorrências no Rmd;
   a extração do PDF também não contém a fórmula revogada.
5. `git diff --check` passou para a migração.
6. `pdfinfo`, `pypdf`, `pdftotext`, renderização Poppler e inspeção das páginas
   35--39 passaram nos termos registrados na Seção 4.7.
7. O JSON desta adjudicação foi validado pelo script canônico com
   `--artifact formal_model_v6.Rmd`; `--contract-file` foi omitido porque o
   comparador normativo é Markdown, não um argument contract JSON.
8. UTF-8 e `git diff --check` passaram nos dois records criados.

## 8. Veredicto da adjudicação

**`NO_CONFIRMED_DEFECTS`.**

Os dois `PASS 0/0/0` são sustentados pela verificação independente dos bytes,
do contrato textual, da matemática, do escopo e do PDF. Não há finding a
encaminhar nem item material não resolvido. Este veredicto cobre exclusivamente
`formal_model_v6.Rmd` no SHA-256
`7de0b2eddc20b98509f8fa37a299860f83164b7469097598532aa5cbfbd7a2a7`
e `formal_model_v6.pdf` no SHA-256
`97ff2d5fa3878550a5b6ea77c642b99ad4543aec760e92ff7941495ea552ed00`.
Não autoriza nova tag, merge, push ou promoção para `main`.
