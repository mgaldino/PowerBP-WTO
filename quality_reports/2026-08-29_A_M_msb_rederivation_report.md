# Relatório de execução — rederivação de `A_M` sob M/S/B

**Data:** 2026-08-29  
**Status:** `ROUNDS 1–2 FAIL ADJUDICATED — ROUND 3 REVIEWS PENDING`  
**Escopo:** somente a rederivação de `A_M` sob a emenda aprovada M/S/B.

## 1. Preflight e worktree

O worktree Codex gerenciado foi verificado antes de leitura substantiva:

```text
/Users/manoelgaldino/.codex/worktrees/4ecf/PowerBayesianPersuasion
HEAD b675a372d7c92703335e5c70a18077e9151f254d
git status --porcelain: vazio
branch: detached HEAD
```

A criação de `agenda-extension-am-msb` nesse checkout não foi repetida porque o
branch já existia e estava ocupado no worktree expressamente nomeado pelo
prompt autoral:

```text
/private/tmp/PBP-am-msb
branch agenda-extension-am-msb
HEAD 4bda7b71e1e6d4e836912b533fef8b28ee044c71
git status --porcelain: vazio
parent b675a372d7c92703335e5c70a18077e9151f254d
```

O commit `4bda7b7` contém somente a emenda, o registro Sol 5.6 e o prompt de
rederivação. O trabalho continuou nesse worktree já criado; nenhum comando
`git worktree add`, nenhuma alteração do checkout principal e nenhuma
movimentação de branch foram executados.

## 2. Documentos externos

Os dois documentos externos foram lidos somente por seus caminhos absolutos no
checkout principal. Os hashes coincidiram com o mandato:

```text
8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b
/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md

a1b89479a44d7cef148859d8219701ce370cbcedcfe994d5436bc565980bc25a
/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/2026-08-29_review_sol56_emenda_extensao_agenda.md
```

## 3. Entregáveis produzidos

1. `model_redesign/agenda_extension_A_M_msb_results.md`: derivação, lema de
   existência corrigido, membership literal, classificação pura, redução mista
   e assinatura downstream;
2. `model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv`: ledger AMX
   reescopado, com o certificado histórico preservado;
3. `scripts/verify_agenda_extension_A_M_msb.R`: verificação mecânica separada;
4. este relatório e o manifesto de hashes do pacote.

Nenhum artefato herdado de `b675a37`, nenhum baseline N1–N7, `A_U`, `AC`,
`AR`, manuscrito ou tag foi editado.

## 4. Resultados principais

### 4.1 Membership e preço de voto

O representante que sorteia uniformemente os parceiros de cada proponente
fraco é membro literal de `C_M`: cada proposta de sua loteria permanece no
argmax permitido pelo registro congelado. Seu vetor de payoffs interinos é
anônimo. O membro cíclico tem a mesma incidência agregada e, portanto, é
payoff-equivalente; ele não é identificado ao uniforme na distribuição de
coalizões rotuladas.

M/S colapsam o ballot para um único preço por posterior,
`r_chi(mu)=beta*c_chi(mu)`. Condicionalmente a `mu`, o conjunto de acordos é
compacto, o melhor acordo `A_chi(mu)` é atingido e uma proposta clara atinge a
rejeição `D_chi_theta(mu)`.

### 4.2 Existência

Existe ao menos um PBE para toda primitiva e prior. Para prior interior, as
testemunhas cobrem:

```text
o_1<=T          -> pooling com acordo, nu_off=nu;
o_0<=T<=o_1     -> baixo acorda e alto atrasa, nu_off=1;
T<=o_0          -> ambos atrasam, qualquer nu_off.
```

Nos endpoints, `nu_off=nu` e cada tipo escolhe entre o acordo e a rejeição
condicionais ao único posterior possível.

### 4.3 Classificação

Para estratégias puras e prior interior, pooling ou separating e o outcome de
cada tipo geram uma lista finita e completa, com condições necessárias e
suficientes em `A_p`, `D_theta_p` e no melhor desvio sob `nu_off`.

Para estratégias mistas, a classe completa requer as medidas de propostas,
o posterior local em cada ponto disciplinado, a seleção anônima markoviana, o
outcome de ballot e as condições de melhor resposta no suporte e fora dele.
A assinatura registra payoffs por tipo, payoffs interinos por identidade,
acordo/atraso, distribuição terminal e posteriores nos sinais alcançados.

Depois da rodada 1, a seleção foi tipada explicitamente como o codomínio Borel
dos representantes uniformes `E/S/P` e da única mistura residual `E/P`. Os
endpoints receberam objetos próprios de medidas Borel no argmax, sem divisões
por `nu` ou `1-nu`. O domínio herdado
`0<o_0<o_1<1` e `o_1<=y_bar<=1` foi restaurado; as
fórmulas são invariantes em `y_bar` porque `t1=beta*o_1<=y_bar`.

Não existe redução finita geral por `(nu,nu_off)`: uma família de misturas
entre coalizões já produz um contínuo de vetores interinos, e uma família
atomless produz posteriores on-path continuamente variáveis.

## 5. Findings escalados

### Finding 1 — fechamento global falso

A rota sugerida pela emenda não pode usar a afirmação global de que “o conjunto
de propostas aceitas é fechado”. O relatório constrói um PBE M/S/B no qual
propostas off-path aceitas convergem para um sinal on-path rejeitado. O
fechamento vale condicionalmente a um posterior fixo. A existência foi provada
por testemunhas explícitas, sem adicionar protocolo e sem alegar
semicontinuidade superior.

### Finding 2 — testemunha semipooling histórica parcialmente removida por S

A antiga condição baseada em `Zbar_B` comprava os `k` votos mais baratos num
membro de incidência assimétrica. Esse membro não tem vetor interino anônimo.
Sob o representante uniforme, a família semipooling sobrevive somente se

```text
beta*o_1>=Z_E
e
A_chi(mu_A)>=beta*o_1.
```

O exemplo histórico `N=5`, `beta=.9`, `o_0=.1`, `o_1=.7`, `nu=.5`,
`lambda=.25` falha: a capacidade uniforme é `.5914`, abaixo de `.63`.

Esses findings não exigem uma nova decisão de protocolo para fechar `A_M`; eles
mudam duas alegações intermediárias e devem ser avaliados pelos revisores e
pelo autor antes de consumo downstream.

## 6. Certificado negativo histórico

O certificado original — seletor Borel dependente da proposta com
`sup g=51/100` não atingido — permanece provado no domínio anterior. M exclui
o seletor literal dependente da proposta; B impede reconstruir o mesmo
interruptor por crenças não disciplinadas. Isso altera seu escopo, não sua
validade nem sua função de motivar a emenda.

## 7. Verificação mecânica

Comando:

```bash
Rscript scripts/verify_agenda_extension_A_M_msb.R
```

Resultado:

```text
SUMMARY | 2891 PASS | 0 FAIL
```

O script cobre identidades de incidência, payoffs uniforme/cíclico, preços e
factibilidade para `N=3,...,20`, testemunhas em grades paramétricas, os dois
findings numéricos, Bayes na família atomless, o domínio estrito
`0<o_0<o_1<1`, `y_bar`, a mistura residual `E/P` e a aritmética do
certificado histórico. Ele não prova PBE,
completude, limite local de Bayes ou
mensurabilidade simbólica.

## 8. Revisão independente — rodada 1

Dois pareceres read-only sobre o manifesto `407114fe...` retornaram `FAIL`:

```text
formal/game-theoretic: 0 critical / 3 important / 3 minor;
adversarial/contrato:  1 critical / 1 important / 1 minor.
```

Os findings convergentes foram adjudicados em
`quality_reports/2026-08-29_A_M_msb_round1_adjudication.md`. Foram aplicados
somente reparos forçados: objetos endpoint, codomínio uniforme Borel,
`y_bar`, prova robusta do limite, distinção Bayes/B, escopo M/B do certificado
e semântica dos status. Nenhuma hipótese, crença, refinamento ou seleção
econômica nova foi adicionada.

## 9. Revisão independente — rodada 2

Os pareceres sobre o manifesto `0cb55a70...` retornaram:

```text
formal/game-theoretic: FAIL — 0 critical / 1 important / 3 minor;
adversarial/contrato:  FAIL — 0 critical / 1 important / 1 minor.
```

O finding comum foi exclusivamente de domínio: a primeira reinserção de
`y_bar` permitiu por lapso `o_1=1`. A adjudicação em
`quality_reports/2026-08-29_A_M_msb_round2_adjudication.md` restaurou
literalmente `0<o_0<o_1<1` e `o_1<=y_bar<=1`, corrigiu a descrição Borel de
`c_S(mu)`, a fronteira `o_0>=T` e a redação M/B. O verificador agora contém
uma regressão que rejeita `o_1=1`.

## 10. Gate de revisão — rodada 3

O implementador não atribui `PASS` substantivo ao pacote. Os bytes reparados serão
submetidos a dois revisores independentes, read-only, com hashes recalculados:

1. revisão formal/game-theoretic de membership, existência e completude;
2. revisão adversarial de fidelidade à emenda, escopo, assinaturas e ledger.

Fable é inelegível. Qualquer mudança matemática posterior invalida os
pareceres sobre hashes anteriores.
