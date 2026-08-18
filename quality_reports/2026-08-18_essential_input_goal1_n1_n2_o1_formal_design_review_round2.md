## Parecer independente — Round 2

`reviewer_role=formal_design`  
`reviewer_id=review-n1-n2-o1-formal-2026-08-18-r2`  
Modo: read-only; nenhum arquivo editado pelo revisor.

### Veredito executivo

| Nó | Hash candidato auditado | Critical | Major | Minor | Veredito |
|---|---|---:|---:|---:|---|
| N1 | `af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd` | 0 | 0 | 0 | **PASS** |
| N2 | `32a2989f806af20b2557fa8f495dfbe661ac951be59ee68e583fd50735e486ed` | 0 | 0 | 0 | **PASS** |

Os bytes dos dois candidatos permanecem idênticos aos do Round 1. O finding
major anterior do verificador N1 está fechado no novo verificador, sem alteração
do candidato.

### Snapshot e execução

- Branch: `codex/essential-input-o1-interior`
- Contrato: `7b52f332aff353bf54a36992b0944ab3ff016a1c90e56a05e4853d26d92dab82`
- DAG: `9e7c73a5444711cfaae2b2f9868b244500bd173f5214533fd897dad280c4cb76`
- Verificador N1: `a1a3a05f48bcecb38d503b4f8ff51275cc4ccf12dd7cb84d18a28049d7788a31`
- Verificador N2: `5bc16794dfa05d7184c0f2ff5eb998d1a97519b8d2d8836c5caa0b31e72ebfd6`
- Ledger N1: `b438312588ed8af113b6a4313bf78df625aa954abfcbf3e4b4ed795630d2b990`
- Ledger N2: `e13702a1e3f94fb2a7ea682b15cdf91befc6558497ce363b951959f71ee02049`

Resultados ao vivo:

- `verify_essential_input_n1.R`: PASS, hash candidato correto, N1 ainda
  `pending` e `unfrozen`.
- `verify_essential_input_n2.R`: PASS, hash candidato correto.
- Checker DAG: `VALID`; batches `[N1, N2] -> [N3, N4] -> [N6] -> [N7]`;
  `Ready: N1, N2`.
- Os avisos de locale do R/Perl não alteraram execução, parsing ou resultados.

## N1 — R2 sob maioria

### Reconstrução substantiva

Com `m=N-1` weak states e `q=floor(N/2)+1`, o proponente conta como `sim`.
Cada weak nonproposer:

- vota `sim` por stage-undominance se `x_j>0`;
- é indiferente em todo o information set se `x_j=0`, quando `T^Y` seleciona
  `sim`.

Logo, os `m` votos weak satisfazem a quota para `N>=3`, tornando `H` não
pivotal em toda proposta factível. Para cada tipo:

- `sim` paga `y`;
- `não` paga `y+o_theta`.

Como `o_theta>0`, `H` vota estritamente `não`. A execução integral de `y` e o
gatilho de `o_theta` estão corretamente preservados.

O proponente maximiza `r_i` e escolhe unicamente:

```text
y=0, x_j=0 para todo j, r_i=1.
```

Assim:

- aprovação sem `H` com probabilidade 1;
- proponente reconhecido recebe 1;
- weak nonproposers recebem 0;
- `H` recebe `o_theta`;
- cada weak state, antes do reconhecimento, recebe `1/m`.

Não há `beta` interno. O resultado vale para todo `nu∈[0,1]`, inclusive tipos
de probabilidade zero. A restrição estrita `o_1<1` apenas reduz o domínio e não
altera estratégia, payoff, outcome ou multiplicidade — exatamente o conteúdo
de N1-C10.

### P0, P5, P6, beliefs e correspondência

- **P0:** qualquer folga pode ser transferida a `r_i`; atingir `r_i=1` força
  `y=x=0`.
- **P5:** R2 é terminal, reconhecimento é iid com reposição e histórias com o
  mesmo posterior induzem o mesmo problema.
- **P6:** a passagem on-path com `x_j=0` depende corretamente de `T^Y`, não de
  uma alegação falsa de dominância.
- Bayes preserva `nu` após a proposta on-path comum aos tipos.
- Toda proposta de probabilidade zero, inclusive pontos de massa zero em
  suporte atomless, admite `kappa(s)∈[0,1]` arbitrária.
- Há uma única classe de estratégias, outcome e payoff. A única multiplicidade
  é de assessments por beliefs off-path payoff-irrelevantes.
- A célula única cobre todo o domínio e contém um registro conjunto atômico;
  não há produto cartesiano artificial entre estratégias, outcomes e payoffs.
- O lifecycle `pending/unfrozen` está correto.

### Auditoria adversarial do novo verificador

Além das fixtures anteriores, mutações diretas pelo mesmo validador confirmaram:

- restrição de beliefs em suporte atomless: rejeitada;
- Bayes on-path contraditório: rejeitado;
- campo de mixing arbitrário do proponente: rejeitado;
- contradição anexada à unicidade: rejeitada;
- contradição anexada à seleção: rejeitada;
- C10 falsa ou ausente na interface: rejeitada;
- C10 falsa no ledger: rejeitada.

Também foram rejeitadas mutações de cobertura, slack, votos weak/H, payoff
externo de `H`, continuação espúria, `beta`, outcome, data de payoff, domínio
antigo, freeze prematuro, schema incompleto e claim pendente.

**Findings N1:** nenhum texto a transcrever.  
**Contagem:** critical 0; major 0; minor 0.  
**Veredito no hash exato:** **PASS**.

## N2 — R2 sob unanimidade

### Reconstrução substantiva

Todo weak nonproposer vota `sim` após qualquer proposta factível:
stage-undominance quando `x_j>0` e `T^Y` quando `x_j=0`. `H` é pivotal e vota:

```text
sim se e somente se y >= o_theta.
```

O problema do proponente reduz-se a:

```text
y<o_0:          0
o_0<=y<o_1:    (1-nu)(1-y)
y>=o_1:         1-y
```

Os únicos candidatos maximizadores são:

```text
S(nu)=(1-nu)(1-o_0), em y=o_0
P=1-o_1, em y=o_1
nu_star=(o_1-o_0)/(1-o_0).
```

Como `0<o_0<o_1<1`, tem-se `0<nu_star<1`. Em `nu=nu_star`, o tie-break de
proposta minimiza o payoff esperado de `H` e seleciona `y=o_0`.

A correspondência correta é:

- `0<=nu<=nu_star`: passagem apenas para o tipo baixo, proposta
  `(o_0,0,1-o_0)`, payoff do proponente `(1-nu)(1-o_0)`, payoffs de `H`
  `(o_0,o_1)`, passagem com `H` `1-nu` e falha `nu`;
- `nu_star<nu<=1`: pooling, proposta `(o_1,0,1-o_1)`, payoff do proponente
  `1-o_1`, payoffs de `H` `(o_1,o_1)` e passagem com `H` com probabilidade 1.

### Endpoints, corner, atomicidade e lifecycle

- Em `nu=0`, a célula low-type-only é estritamente ótima.
- Em `nu=1`, `1-o_1>0`: pooling é estritamente superior à rejeição e único.
- O corner antigo `o_1=1,nu=1`, que permitia uma família degenerada de argmax
  com slack, está fora do domínio e não sobrevive.
- Toda proposta ótima usa integralmente a pie, com `x_j=0` e `r_i=1-y`.
- Não há passagem sem `H`, delay ou `beta` interno.
- Beliefs após propostas de probabilidade zero permanecem totalmente livres e
  payoff-irrelevantes.
- As duas células são exclusivas, exaustivas e contêm registros conjuntos
  atômicos.
- Proposta, estratégia, outcome e payoff são únicos em cada célula; somente
  beliefs off-path geram multiplicidade de assessments.
- P0, P5 e P6 estão corretamente demonstrados.
- Ledger e DAG preservam `pending/unfrozen`; o candidato não se autofinaliza.

### Auditoria adversarial do novo verificador

Mutações diretas confirmaram a rejeição de:

- alegação de mistura atomless sobre pacotes com slack em `nu=1`;
- alegação de sobrevivência de slack no campo de seleção em `nu=1`;
- claim de que o corner antigo `o_1=1` permanece admissível;
- domínio `o_1<=1`;
- payoff errado do tipo alto;
- distribuição de outcomes incorreta;
- claim `pending` no ledger;
- voto weak incompatível;
- cutoff de igualdade de `H` incompatível com `T^Y`;
- restrição inventada de belief off-path;
- fronteira que exclui a igualdade `nu=nu_star`.

As fixtures integradas também rejeitaram campo ausente, passagem sem `H`,
continuação importada, `beta` em R2, belief on-path incorreta, célula degenerada
extra, link para equilíbrio excluído e freeze prematuro no DAG.

**Findings N2:** nenhum texto a transcrever.  
**Contagem:** critical 0; major 0; minor 0.  
**Veredito no hash exato:** **PASS**.

Os PASS qualificam exclusivamente os hashes acima. A passagem formal dos nós
para `pass/frozen` continua condicionada ao protocolo de dois pareceres
independentes e ao registro posterior no DAG.
