# Parecer independente — `formal_design`

**Revisor:** `/root/formal_design_review`  
**Papel:** desenho formal, independente e read-only  
**Manifesto revisado:** SHA-256 `686af300db423fb5c691f6d8b0da116b51f291b6fb31691aab940f6b922652cb`  
**Integridade:** `shasum -a 256 -c` passou para os nove candidatos. Nenhum arquivo foi editado.

## Escopo lido

Foram lidos integralmente:

- `AGENTS.md`;
- contrato Gate 0 de 2026-08-12;
- decisão autoral de 2026-08-21;
- auditoria game-theórica que motivou a decisão;
- interface N1 no hash `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`;
- interface N2 no hash `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`;
- os nove artefatos listados no manifesto.

N3 consome apenas N1; N4 consome apenas N2. Não encontrei importação matemática de N3 em N4, de N2 em N3, nem uso de N6/N7, comparação institucional ou manuscrito.

## Rederivação independente

### N3

A derivação substantiva confere.

Como `q<=m`, a exclusão é factível. Definindo `w=beta/m` e `t_theta=beta*o_theta`:

- o fraco pivotal vota `sim` exatamente quando `x_j>=w`;
- com pelo menos `q-1` votos fracos, `H` é não pivotal e prefere estritamente `não`, recebendo `y+o_theta`;
- com exatamente `q-2` votos fracos, `H(theta)` aceita exatamente quando `y>=t_theta`;
- com no máximo `q-3` votos fracos, a proposta falha sob qualquer voto de `H`, e `T^Y` seleciona `sim`.

Reobtive:

```text
E-R = 1-beta*q/m > 0,
P-E = beta*(1/m-o_1),
S-E = (1-nu)beta*(1/m-o_0)-nu(1-beta*q/m).
```

As correções de factibilidade são válidas: `S>=E` força `o_0<=1/m`, enquanto `P>=E` força `o_1<=1/m`. No domínio `o_1<1/m`, o denominador de `nu_SP` é positivo e excede seu numerador. Os desempates, inclusive o empate triplo, foram corretamente tratados. Como N1 é posterior-invariante, o novo sistema de crenças reduz assessments admissíveis, mas não altera os incentivos nem a correspondência econômica de N3.

### N4

A caracterização matemática central também confere.

A partir de N2:

```text
ell = beta*o_0,
h   = beta*o_1,
A   = beta*(1-o_0)/m,
B   = beta*(1-o_1)/m,
D   = (1-nu)A,
C   = D se nu<=nu_star; B se nu>nu_star.
```

A continuação pivotal de um fraco pertence a `[B,A]`. Portanto:

- acordo exige `x_j>=C`;
- veto fraco exige estritamente `x_j<C`;
- igualdade leva a `sim`;
- o mesmo cutoff vale para `m=2`;
- com veto fraco, separação das ações de `H` é insustentável e ambos os tipos acabam em `sim`;
- separating com prior positivo é impossível por imitação.

O certificado de inexistência é legítimo. Na proposta

```text
s_dagger=(ell,A,...,A,Q_L),
Q_L-A=1-beta>0,
```

todos os fracos votam `sim` sob qualquer posterior admissível após `H=sim`. A enumeração das quatro estratégias puras de `H` elimina todas elas. Como o ballot posterior a uma proposta pública precisa ser sequencialmente racional mesmo fora do caminho, a ausência de resposta pura nesse ballot implica ausência de PBE puro do jogo completo para `0<nu<=nu_star`.

Os completamentos apresentados cobrem toda proposta factível e sustentam:

- `L_star` em `nu=0`;
- `P_star` em `nu_star<nu<=1`.

A diferença de `1-beta` elimina atraso e misturas acordo–atraso nessas células.

### Endpoint `nu=0`

A crença screening depois do `não` prescrito apenas para `H1` é admissível. Com prior `nu=0`, essa ação tem probabilidade total zero e a fórmula de Bayes tem denominador zero. A decisão de 2026-08-21 não impõe trembles, full support nem uma extensão de Bayes a eventos nulos. Portanto nenhuma convenção nova foi introduzida aqui.

## Findings

| ID | Severidade | Localização | Finding |
|---|---|---|---|
| FD-MAJ-01 | major | `model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json:53`, `:74-75`, `:92-103`; contraste com `n3_r1_majority_rederivation_candidate.md:217-238` | O registro N3 quantifica sobre uma família arbitrária de distribuições `F_i`, mas os campos exportados não são funções vinculadas à mesma `F_i`. O valor fraco é apenas descrito como “identity-indexed”; os payoffs de `H` e os outcomes são menus por classe. Assim, estratégia, payoff e outcome podem ser recombinados marginalmente, contrariando a atomicidade da Seção 7.2 e impedindo consumo inequívoco por N6. |
| FD-MAJ-02 | major | `model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json:149-168`; `n4_r1_unanimity_rederivation_candidate.md:183-229` e `:357-362` | O completamento matemático escolhe crenças pooling ou screening específicas, mas o registro alto declara toda crença após ação de `H` fora do perfil como livre em `[0,1]` e simultaneamente afirma que a multiplicidade é payoff-irrelevante. Essa classe contém assessments que não sustentam a estratégia registrada. Exemplo: na célula alta, tome `B<=min x<A` e `Y<h`. O registro prescreve `(não,não)` e todos os fracos em `sim`; se a crença após o `sim` off-path de `H` for `eta=0`, então `W(eta)=A>min x`, e algum fraco deve votar `não`. O JSON, portanto, é uma sobrecorrespondência de assessments e não exporta a correspondência completa admissível. |

## Reparações dirigidas

### FD-MAJ-01

Mantendo a representação já escolhida de uma família paramétrica única, o reparo é determinado pela própria derivação:

- definir indicadores `I_H(s,theta)`, `I_X(s)` e `I_D(s,theta)`;
- exportar, para a mesma família `(F_i)_i`, o valor de cada fraco `l`, os dois payoffs de `H` e as quatro probabilidades de outcome;
- fazer todos esses campos dependerem explicitamente da mesma `F_i`.

Em particular, o valor fraco deve incluir a probabilidade `1/m` de ser proponente e, quando outro `i` é reconhecido, o pagamento `x_l` nos ramos de passagem e `w` no ramo de atraso. Os payoffs de `H` devem integrar `y`, `y+o_theta` e `t_theta` pelos mesmos indicadores e distribuições. Isso não muda a matemática de N3.

### FD-MAJ-02

O registro deve exportar apenas crenças que sustentem o completamento:

- em `nu=0`, a crença após `H=não` deve permanecer no ramo screening sempre que uma crença pooling tornaria o desvio de `H0` lucrativo;
- em `nu>nu_star`, no ramo `min x>=B` e `Y<h`, a crença após o `sim` off-path deve satisfazer `W(eta_Y)<=min x`; pooling é uma escolha suficiente, mas não se pode declarar todo `[0,1]`;
- nas demais histórias, preservar explicitamente apenas a multiplicidade realmente admissível.

O campo de unicidade deve distinguir unicidade de estratégia/outcome on-path da multiplicidade restringida de crenças off-path. Isso completa a interface sem alterar `L_star`, `P_star` ou a célula de inexistência.

Nenhum finding exige nova primitiva ou decisão autoral: as duas reparações são impostas pelo conceito já fixado e pelo requisito existente de atomicidade. Após novo hash, os dois pontos precisam de rerevisão dirigida.

## Contagem e veredito

```text
critical: 0
major:    2
minor:    0
```

**VEREDITO: FAIL 0/2/0**

A prova econômica de N3 e a nova caracterização matemática de N4 sobreviveram à rederivação independente. O bloqueio está nas interfaces candidatas: N3 ainda não vincula atomicamente sua multiplicidade aos payoffs e outcomes, e N4 exporta uma classe de crenças mais ampla que a sustentada por seu próprio completamento.
