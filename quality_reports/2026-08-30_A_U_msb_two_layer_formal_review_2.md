# Parecer formal independente 2 — `A_U` sob M/S/B, duas camadas

**Data:** 2026-08-30

**Papel:** parecerista formal independente 2, adversarial e read-only

**Snapshot:** `be482e329e34e6690211089363358c2399706e52`

**Manifesto:** `quality_reports/2026-08-30_A_U_msb_two_layer_candidate_manifest.sha256`

**SHA-256 do manifesto:**
`3cf2c047ad2da35665c21b47f94ca117482d7e7f537d9caa4e0ddce29ae7b369`

**Veredito:** `FAIL — 0 critical / 0 important / 1 minor`

## 1. Independência e identidade

Trabalhei em modo read-only, sem memória, web, parecer do outro revisor ou
parecer histórico. Consultei a adjudicação antiga somente para identificar
`R2-I-1`. Não editei nem commitei arquivos.

Confirmei worktree, branch e `HEAD` exatos, árvore limpa, hash externo do
manifesto e 16/16 entradas `OK`. O commit substantivo
`b56085c436eb629c335764eb982d174e5cc2d392` é ancestral do snapshot revisado.

## 2. Reconstrução estratégica e ausência de regressão

Reconstruí independentemente:

```text
nu_star=(o_1-o_0)/(1-o_0),
d_0=beta^2 o_0, d=beta^2 o_1,
a=beta(1-beta o_0)/m, b=beta(1-beta o_1)/m,
z_L=1-beta+d_0, z_H=1-beta+d,
Delta=z_L-d.
```

`C_U` é consumível somente em `{0} union (nu_star,1]` e recebe exatamente um
fator externo `beta`. O voto aceita sse `x_j>=a` em zero e `x_j>=b` em
posterior alto, incluindo a igualdade por `T^Y`.

Imitação bilateral iguala os payoffs dos tipos no interior. A dicotomia da
massa em posterior zero gera exatamente `AU-MSB-L`, `H0` e `HB`, com:

- prior baixo: existe PBE sse `Delta>=0`, apenas `L`;
- prior alto e `Delta<0`: `H0` e `HB`;
- prior alto e `Delta>=0`: `L`, `H0` e `HB`;
- atraso somente em `V=d`;
- endpoints preservando a estratégia do tipo de prior zero.

O diff contra o candidato adjudicado conserva thresholds, transporte,
payoffs, Bayes, famílias, endpoints e exaustão. Não encontrei regressão
estratégica.

## 3. Binder e lei realizada

O binder completo permanece atômico e vincula estratégias, crenças, votos,
continuações e outcomes. A lei

```text
Gamma_theta^{U,R}=Law_theta(y,mu(y),pass/reject,xi_U,omega_T)
```

é deliberadamente a projeção realizada. “Exata” não significa recuperação de
funções off-path; essas continuam no binder e operações sensíveis a elas devem
consumi-lo. A interface expressa corretamente esse limite.

`Z_U` é polonês: `Y` é compacto, os fatores discretos são finitos e os
registros terminais literais de `C_U` têm carrier compacto. A ação de `S_m`
usa uma única permutação comum em todas as coordenadas fracas, fixa posterior,
timing e `L/P`, e leva PBE a PBE sem impor simetria comportamental.

## 4. `Lambda`, quociente e fatorização

Para `x=(Gamma_0,Gamma_1)`,

```text
Lambda_x=|G|^{-1} sum_g delta_(g.x)
```

é Borel e invariante. Se `Lambda_x=Lambda_x'`, o singleton `{x'}` tem massa
positiva `|Stab_G(x')|/|G|` sob sua própria lei; a igualdade força
`x'=g.x`. Portanto `Lambda` é completo para a órbita diagonal, mesmo quando a
ação não é livre.

O mínimo Borel da órbita finita pertence realmente à órbita; não é Reynolds.
O mesmo mecanismo em `Z_U` define a transversal e `q_U`. Toda função Borel
invariante fatora unicamente pelo quociente, e a igualdade de integrais decorre
do pushforward.

Assim, `Sum_econ_U` recupera legitimamente payoffs de `H`, acordo/atraso, lei
do posterior, célula `L/P`, proposta e outcome anônimos e distribuição
anônima dos payoffs fracos. Não recupera objetos nomeados, suportes, mapa
público pointwise, coincidência de mensagens, relação entre planos ou funções
off-path.

## 5. Stress-tests `P/Q` e Reynolds

Com `N=3`, `beta=.9`, `o_0=.2`, `o_1=.5`, refiz:

```text
nu_star=.375, d_0=.162, d=.405,
a=.369, b=.2475, z_L=.262, z_H=.505, Delta=-.143.
```

As propostas

```text
P=(.45,.3025,.2475),
Q=(.45,.2475,.3025)
```

somam 1 e passam. Com prior `.6` e pesos comuns pelos dois tipos, Bayes mantém
`.6`; fora do suporte, `nu_off=0` oferece no máximo `.405`, abaixo de `.45`.
Logo toda mistura comum é PBE. A órbita diagonal identifica `p` apenas com
`1-p`; `.9` e `.5` têm assinaturas distintas. Como `q_U(P)=q_U(Q)`, têm o
mesmo resumo econômico.

Com prior `.9`, pesos `sigma_0=(.9,.1)` e `sigma_1=(.1,.9)` dão

```text
mu(P)=.5,
mu(Q)=81/82,
```

ambos acima de `.375`. Reynolds produz, em cada proposta física, massa com os
dois posteriores; nenhuma lei apoiada no gráfico de um único mapa público
`y -> mu(y)` pode fazê-lo. Portanto Reynolds não é assessment, não é
representante, não é completo e pode apagar a relação entre planos.

Não encontrei contraexemplo a nenhum claim matemático da arquitetura em duas
camadas. Os 31 claims do ledger são substantivamente sustentados.

## 6. `rho`, endpoints e downstream

No prior interior,

```text
nu_off=nu rho/(1-nu+nu rho)
```

é apenas reparametrização. Nos endpoints, `rho=*` evita a degeneração e a lei
do tipo de prior zero permanece registrada.

`A_M` e `A_U` devem ser combinados primeiro na mesma fibra de prior e
`(rho,nu_off)` usando a camada exata. Uso do resumo exige prova específica de
constância e fatorização, setwise para correspondências. Não há autorização
para `AC`, `AR`, manuscrito, tag, merge ou push.

## 7. Evidência mecânica

O verificador foi reexecutado read-only e produziu output byte a byte idêntico
ao versionado:

```text
MECHANICAL RESULT: PASS | 1110 PASS | 0 FAIL
```

Não o tratei como prova de completude, desvios contínuos, Bayes pointwise,
teoremas Borel, seletores literais ou fatorização downstream.

## 8. Finding

### `R2-M-1` — o DAG versionado falha no verificador que o governa

**Classificação proposta:** `minor`

**Tipo:** artefato/reprodutibilidade

**Localização:**
`model_redesign/agenda_extension_A_U_msb_game_dag.json:16-57`

**Escopo:** auditabilidade da dependência e da ordem de execução; não afeta a
correspondência estratégica, `Lambda`, `q_U`, `P/Q` ou a interface econômica.

O comando prescrito por `solve-dynamic-games`,

```text
python3 /Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py \
  model_redesign/agenda_extension_A_U_msb_game_dag.json \
  --require-execution-order
```

retorna `INVALID`. Os erros são:

1. falta o hash de `C_U_frozen` no nó histórico;
2. falta o hash do candidato histórico na decisão autoral;
3. faltam hashes de `C_U` e da decisão no contrato;
4. falta o hash do candidato histórico no candidato atual;
5. o candidato lista hashes de entradas que não declarou em `depends_on`;
6. três `artifact_path` são interpretados relativamente a `model_redesign/`,
   criando caminhos inexistentes duplicados.

O grafo é acíclico, mas o certificado persistente é inválido. A linha
`Ready: AC` impressa antes dos erros não supera `INVALID` nem a autorização
explícita `not authorized`.

**Fix assessment:** reparo técnico único e local:

1. tornar `artifact_path` relativo ao diretório do DAG;
2. adicionar a cada nó iniciado hashes de todas e somente as dependências
   diretas;
3. alinhar `depends_on` e `dependency_hashes`;
4. reexecutar o checker até `VALID`;
5. repinar DAG e manifesto para nova revisão.

A severidade é minor porque nada na matemática muda. Ainda assim, o artefato
de auditoria governado falha objetivamente, e o protocolo não permite PASS com
finding aberto.

## 9. Veredito

A arquitetura matemática resolve corretamente `R2-I-1`, preserva o binder,
distingue identidade formal de consequência econômica e rebaixa Reynolds de
modo válido. Não há finding critical ou important.

O finding administrativo `R2-M-1` impede PASS neste snapshot. Nenhum
congelamento ou trabalho downstream é autorizado.

FINAL_STATUS: FAIL

COUNTS: 0/0/1
