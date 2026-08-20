# Parecer independente `formal_design` — N4 v2 — rodada 1

**Data:** 2026-08-19
**Veredicto:** **FAIL — 0 critical / 2 major / 0 minor / 0 epistemic**

N4 deve permanecer `pending/unfrozen`; este parecer não autoriza freeze nem
consumo por N6/N7.

## Integridade do objeto revisado

- Branch: `codex/essential-input-goal4-n7-phaseb`.
- HEAD inicial/final: `889c5ffcc8cc6bc5c903ec5197e418fed407c758`.
- SHA-256 inicial/final do candidato:
  `67dc008a42db6d6c7f7c12eb3abf9fd7eb4a273a73ca0ec6f4a1ece180320c0b`.
- N2 congelado:
  `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`.
- Tag peeled: `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- Worktree limpo; nenhum arquivo foi alterado.
- Gate0: PASS.
- Verifier N2: PASS.
- Verifier N4 v2: PASS mecânico.
- Checker DAG `--require-execution-order --candidate N4`: VALID.
- Warnings de locale foram isolados e não classificados como findings.

O envelope `equilibrium_correspondence_v1`, os seis IDs de célula, os campos
exigidos, a proveniência N2, o lifecycle `pending` e a contabilidade realizada
`(a,0)` da continuação low-only estão estruturalmente presentes. Isso não salva
a correspondência substantiva pelos findings abaixo.

## N4V2-FD-01 — major, substantivo pela Seção 11.1

**Aplicação incorreta de stage-undominated voting e `T^Y`; as garantias do
proponente e a cobertura da correspondência são falsas.**

O contrato exige comparar a ação de cada weak voter em todos os vetores de
votos simultâneos relevantes e diz expressamente que igualdade em uma linha
não aciona `T^Y` quando há preferência estrita em outra linha (contrato, linhas
719 e 736–744 no snapshot revisado).

O candidato, porém, sustenta:

- `S_m=min{P,D}` e proíbe rejeição a pooling em `x=b`;
- que `(h,a,F)` força ambos os votantes a `yes` em `m=2`;
- inexistência de veto por dois ou mais weak voters na fronteira e acima dela.

Essas alegações são quebradas por assessments admissíveis.

### Contraprova `m=3`

Use `beta=.9`, `o0=.2`, `o1=.6`, `nu=.1`, `y_bar=.6`. Então:

```text
ell=.18, h=.54, a=.24, b=.12, D=.216, P=.22.
```

Na oferta candidata `(Y,x1,x2,r)=(h,b,b,P)`, em uma proposta de probabilidade
zero, faça ambos os weak responders votarem `no` e ambos os tipos de H votarem
`yes`. Associe:

- falhas com `H=yes` a pooling;
- `H=no` e nenhum weak no a pooling;
- `H=no` e pelo menos um weak no a low-only com posterior zero.

Para cada weak voter:

| H | outro weak | payoff de `yes` | payoff de `no` |
|---|---:|---:|---:|
| yes | yes | .12 | .12 |
| yes | no | .12 | .12 |
| no | yes | .12 | .24 |
| no | no | .24 | .24 |

Logo, `no` domina fracamente `yes`, com desigualdade estrita na terceira linha.
`No` sobrevive à stage-undominance; `T^Y` não pode reintroduzir `yes`,
precisamente pela regra contratual de comparação do vetor inteiro. No perfil
efetivo, a troca unilateral mantém pooling e o weak voter está indiferente,
portanto `no` também é sequencialmente racional.

Para H, no perfil efetivo:

```text
theta0: yes=h=.54 > no=ell=.18
theta1: yes=h=.54 = no=h=.54
```

Assim, H0 escolhe `yes` estritamente e `T^Y` seleciona `yes` para H1. A oferta
falha para pooling e o proponente recebe `b=.12`, estritamente abaixo do suposto
`S_m=.216`.

Todas as crenças usadas são admissíveis: a proposta e os vetores
contrafactuais têm probabilidade zero, e cada continuação é um registro
congelado de N2. Isso refuta diretamente a `exact guarantee offer`, o
`forbidden_b_punishment` e a prova do lower bound.

A mesma construção, com todos os weak responders votando `no`, sobrevive em
`nu=nu_star` e `nu>nu_star`. Portanto, os certificados de inexistência de
multi-veto na fronteira e na região alta também omitem assessments válidos.

### Contraprova `m=2`

Use `beta=.5`, `o0=.2`, `o1=.6`, `nu=.5`. Então:

```text
ell=.1, h=.3, a=.2, b=.1, D=.1, F=.5.
```

Na oferta `(h,a,F)`, faça o único weak responder votar `no` e H votar `yes` em
ambos os tipos. Associe `(W=no,H=yes)` e `(W=no,H=no)` a low-only com posterior
zero, e `(W=yes,H=no)` a pooling. O problema completo do weak voter é:

| H | payoff de `yes` | payoff de `no` |
|---|---:|---:|
| yes | .2 | .2 |
| no | .1 | .2 |

Novamente `no` domina fracamente `yes`. H está indiferente entre suas ações no
perfil efetivo e `T^Y` seleciona `yes`. A oferta falha e o proponente recebe
`D=.1`, não `F=.5`. Logo, a afirmação de que a oferta `forces both voters to
yes` e o componente atingido `F` são falsos.

### Consequência

Precisam ser rederivados, desde P6 e N2, `S_m`, `S_2`, mínimo versus ínfimo,
pooling caps, endpoints, residual rules, delay, multi-veto, misturas e
multiplicidade. Os claims `N4V2-CLM-003` a `009`, além da exaustividade
`CLM-018`, ficam sem suporte.

**Classificação Seção 11.1:** substantivo. Não é correção local nem fórmula
determinada pela derivação vizinha; altera a correspondência, topologia de
endpoints e objetos que N6/N7 consumiriam. Preservar as fórmulas atuais exigiria
mudar P6, `T^Y` ou restringir crenças off-path, o que seria mudança não
autorizada de conceito/protocolo. Deve-se parar e escalar.

## N4V2-FD-02 — major, substantivo neste ciclo

**O verifier e os testes não possuem oracle semântico independente e produzem
falso PASS.**

`validate_interface()` verifica somente identidade com o próprio JSON
carregado. A varredura de 1.675 folhas apenas muta esse objeto e o compara
novamente ao mesmo pin. As verificações chamadas de semânticas codificam como
expectativa as próprias fórmulas contestadas.

Os testes negativos também apenas afirmam booleanos previamente construídos;
`expect_wrong_rejected()` não chama um validador. Em particular, eles tratam
exatamente a rejeição pooling válida da contraprova como erro e proíbem
multi-veto na fronteira.

Em mutação adversarial somente em memória, o revisor neutralizou o pin e
alterou simultaneamente:

```text
high-region multi-veto status -> "exists: adversarial mutation"
recognized_proposer_payoff    -> "FALSE_PAYOFF_MAP"
```

Resultado:

```text
pin_neutralized_validate=TRUE
hardcoded_semantic_subset=TRUE
```

Portanto, as contagens de mutação medem selagem/identidade, não validade do
jogo. Elas não detectam mudanças arbitrárias em payoffs ou na cobertura de
ballots.

Depois da rederivação, será necessário um oracle independente que enumere os
vetores completos de votos, aplique melhor resposta, stage-undominance e `T^Y`
na ordem contratual e confira payoffs realizados por tipo.

**Classificação Seção 11.1:** substantivo neste ciclo, porque o conjunto de
invariantes corretos depende da resolução do finding anterior; atualizar pins,
tokens ou fixtures agora apenas selaria uma correspondência incorreta.

## Conclusão

A correção type-conditioned `(a,0)` de N2 foi transportada corretamente, mas
N4 v2 falha na etapa seguinte: transforma igualdade no perfil efetivo em `T^Y`
sem verificar a comparação estrita presente em outro vetor simultâneo. Isso
altera resultados centrais, não apenas documentação.

**N4 v2 não recebe PASS; N3/N6/N7 não foram revisados; nenhum freeze é
autorizado.**
