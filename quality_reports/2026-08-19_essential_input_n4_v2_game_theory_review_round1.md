# Parecer independente `game_theory` — N4 v2 — rodada 1

**Data:** 2026-08-19

**Artefato:** `model_redesign/essential_input_interfaces/n4_r1_unanimity_candidate_v2.json`

**SHA-256 revisado:** `67dc008a42db6d6c7f7c12eb3abf9fd7eb4a273a73ca0ec6f4a1ece180320c0b`

**HEAD inicial/final:** `889c5ffcc8cc6bc5c903ec5197e418fed407c758`
**Veredicto:** **FAIL — 0 critical / 1 major / 0 minor / 0 epistemic**

## N4V2-GT-01 — major

O construtor de atraso `H_veto` admite ballots inválidos para `m=2` quando
`nu>=nu_star`.

A interface prescreve todos os weak responders votando `yes`, ambos os tipos
de H votando `no`, impondo apenas a restrição sobre Y. Isso aparece no candidato
no endpoint `nu=nu_star` e no ramo high. A mesma omissão está no builder, na
derivação e nas cold notes.

Para `m=2`, há um único weak responder. Quando `nu>=nu_star`, tem-se `C=b`. Se
seu pagamento é `x<b`:

- contra `H=no`, votar `yes` leva ao atraso on-path e paga `b`; votar `no` leva
  a uma continuação N2 cujo valor subjetivo é sempre pelo menos `b`;
- contra `H=yes`, votar `yes` aprova a proposta e paga `x<b`; votar `no`
  provoca atraso e paga pelo menos `b`.

Logo, `no` dá payoff pelo menos igual contra todo perfil dos demais votos e
estritamente maior contra `H=yes`. Portanto, `no` fracamente domina `yes`, que
é eliminado por stage-undominated voting. `T^Y` não pode salvar o ballot porque
há desigualdade estrita no perfil `H=yes`; crenças off-path tampouco podem
fazê-lo porque `b` é o piso global de toda continuação N2.

### Contraprova numérica

```text
m=2, beta=.9, o0=.2, o1=.6, nu=.75
nu_star=.50, ell=.18, h=.54, a=.36, b=.18
D=.09, C=.18, F=.10
Y=.10<h, x=.10<b
```

O candidato classifica o atraso como existente (`C>=F`) e o pacote satisfaz o
construtor textual de `H_veto`, mas o weak `yes` é fracamente dominado.

A condição faltante identificada pelo parecer é:

```text
m=2 e nu>=nu_star  =>  x_ij>=b no construtor H_veto.
```

Para `nu<nu_star`, `C=D>b`, de modo que uma continuação off-path pooling pode
tornar `yes` estritamente melhor no perfil `H=no`; portanto, não se deve impor
esse bound nessa região. Tampouco ele se estende automaticamente a `m>=3`, onde
existem perfis contrafactuais adicionais com outro weak veto.

Se `pure_ballot_constructors` for lido como suficiente, a correspondência
sobreinclui assessments inválidos. Se o mapa genérico de respostas for lido
como filtro implícito, o construtor deixa de ser fechado e executável e não
expõe o limite exato exigido para N6/N7. Em ambas as leituras, o candidato não
constitui uma interface autossuficiente completa.

O parecer classificou o reparo local deste construtor como aparentemente único
e forçado pelo contrato e por N2: inserir o bound nos registros, derivação,
ledger e builder, além de acrescentar testes de fronteira e high-region. O
revisor não realizou reparo.

## Demais resultados da auditoria

A rederivação independente deste parecer confirmou, fora do finding:

- vetores N2 realizados `(a,0)` e `(b,b)`;
- piso subjetivo weak `b` versus valor verdadeiro do proponente `D`;
- `S_m=min(P,D)` para `m>=3`;
- `S_2=max(F,K,M)` para `m=2`;
- existência e endpoints de pooling, low-only e delay;
- misturas `L/D` e `P/D`;
- convenções por identidade e coordenadas
  `rho_L,rho_P,rho_D,bar_Y_L,bar_Y_P`;
- payoffs de H, distribuições de outcome, Bayes, simultaneidade e `T^Y`.

Os quatro scripts oficiais, o builder `--check` e o verifier retornaram PASS.
Stress tests aleatórios independentes com 500.000 vetores não encontraram outra
divergência. A suíte negativa, porém, não testa o ballot `m=2`,
`nu>=nu_star`, `H_veto`, `x<b`; por isso o erro semântico passa mesmo com a
identidade canônica protegida.

## Integridade final

- Hash inicial e final do candidato:
  `67dc008a42db6d6c7f7c12eb3abf9fd7eb4a273a73ca0ec6f4a1ece180320c0b`.
- Hash N2:
  `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`.
- HEAD final: `889c5ffcc8cc6bc5c903ec5197e418fed407c758`.
- Worktree final limpo; candidato e N2 coincidiram com os blobs de HEAD.
- A tag protegida continuou peelando para
  `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- Gate0 e N2: PASS; verifier N4 v2: PASS; checker DAG: VALID.
- Warnings isolados de locale não foram tratados como findings.
- Nenhum arquivo foi criado ou alterado pelo revisor.

Este parecer não autoriza freeze de N4 nem trabalho em N3, N6 ou N7.
