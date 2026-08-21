# Parecer independente — `game_theory`

**Papel:** auditor adversarial de teoria dos jogos, read-only  
**Worktree revisada:** `/private/tmp/PowerBayesianPersuasion-essential-input-solution-concept`  
**Manifesto revisado:** `quality_reports/2026-08-21_candidatos_n3_n4_solution_concept.sha256`  
**SHA-256 do manifesto:** `686af300db423fb5c691f6d8b0da116b51f291b6fb31691aab940f6b922652cb`

O hash do manifesto confere e `shasum -a 256 -c` passou para os nove candidatos. Nenhum arquivo foi editado.

## Fontes lidas

- `AGENTS.md`;
- `quality_reports/plans/2026-08-12_essential_input_gate0.md`;
- `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`;
- `quality_reports/2026-08-21_game-theory-audit_essential_input.md`;
- derivação e interface congelada de N1, hash `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`;
- derivação e interface congelada de N2, hash `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`;
- os nove arquivos listados no manifesto.

A auditoria reconstruiu os incentivos a partir das primitivas e das interfaces N1/N2. O script R foi executado apenas depois dessa rederivação e confirmou suas identidades dirigidas; não foi tratado como prova de PBE.

## Rederivação de N3

### Ballot e redução de propostas

N1 entrega, em unidades de R2, valor pré-reconhecimento `1/m` a cada fraco e `o_theta` a `H(theta)`. Em R1, portanto,

```text
w       = beta/m,
t_theta = beta*o_theta.
```

Um fraco pivotal compara `x_j` com `w`, votando `sim` exatamente quando `x_j>=w`; a igualdade pertence ao `sim` por `T^Y`.

Se `k` respondentes fracos votam `sim`:

- `k>=q-1`: os fracos aprovam sem `H`; `H` prefere estritamente `não`, pois recebe `y+o_theta` em vez de `y`;
- `k=q-2`: `H` é pivotal e o tipo `theta` vota `sim` exatamente quando `y>=t_theta`;
- `k<=q-3`: a proposta falha com qualquer voto de `H`; como N1 é posterior-invariante, `T^Y` determina `sim`.

Isso gera exaustivamente:

```text
E = 1-(q-1)beta/m,
L = 1-(q-2)beta/m-beta*o_0,
S = (1-nu)L+nu*beta/m,
P = 1-(q-2)beta/m-beta*o_1,
R = beta/m.
```

Não encontrei classe adicional. Aceitação apenas pelo tipo alto exigiria simultaneamente `y<t_0` e `y>=t_1`.

### Factibilidade, atraso e timing

As correções de factibilidade estão corretas:

- `S>=E` implica `o_0<=1/m`, o que torna o pacote de screening factível;
- `P>=E` equivale a `o_1<=1/m`, o que torna o pacote pooling factível.

Além disso,

```text
E-R = 1-beta*q/m > 0,
```

pois `q<=m` e `beta<1`. Rejeição deliberada não é ótima.

O timing também está correto: exclusão aprovada em R1 paga `o_theta` correntemente; falha de R1 transporta `o_theta` de N1 como `beta*o_theta`, uma única vez.

### Fronteiras e desempates

Reobtive:

```text
P-E = beta*(1/m-o_1),

S-E = (1-nu)beta*(1/m-o_0)
      -nu*(1-beta*q/m).
```

No domínio `o_1<1/m`, o denominador de

```text
nu_SP =
 beta*(o_1-o_0)/
 [1-beta*o_0-beta*(q-1)/m]
```

é estritamente positivo e excede o numerador. Logo `nu_SP` pertence a `(0,1)` exatamente onde é usado.

Os desempates também conferem:

- screening vence qualquer empate que o envolva, por reduzir estritamente o payoff esperado de `H`;
- em `o_1=1/m`, exclusão e pooling podem permanecer após o primeiro critério, devendo-se comparar seus payoffs de `H`;
- no empate triplo, screening é estritamente preferido pelo desempate anti-`H`.

A nova regra de crenças apenas reduz o conjunto de assessments: N1 é independente do posterior, portanto nenhum cutoff, payoff ou outcome de N3 muda.

**Conclusão sobre N3:** matemática substantiva confirmada; nenhum finding game-teórico.

## Rederivação de N4

### Continuação N2 e cutoff fraco

Transportando N2 uma única vez:

```text
ell = beta*o_0,
h   = beta*o_1,
A   = beta*(1-o_0)/m,
B   = beta*(1-o_1)/m,
nu_star = (o_1-o_0)/(1-o_0).
```

N2 screening realiza para cada fraco o vetor por tipo `(A,0)`; pooling realiza `(B,B)`. Também vale

```text
(1-nu_star)A = B.
```

Após `H` votar `sim`, um fraco pivotal compara seu pagamento com

```text
W(eta) =
  (1-eta)A, se eta<=nu_star;
  B,        se eta>nu_star.
```

Logo `W(eta)` pertence a `[B,A]`. No perfil pooling de `H`, o posterior permanece `nu`, de modo que o piso corrente é

```text
C = (1-nu)A, se nu<=nu_star;
    B,       se nu>nu_star.
```

Portanto:

```text
acordo fraco: x_j>=C;
veto fraco:   x_j<C.
```

A fronteira de acordo é fechada e a de veto é aberta.

### Vetos fracos e voto de H

Com qualquer veto fraco, a proposta falha independentemente de `H`.

- `H1` recebe `h` em toda continuação; na igualdade, `T^Y` força `sim`.
- Um perfil separador `H0=não, H1=sim` não sobrevive: o baixo obteria `ell` no voto revelador e pode imitar o alto para obter `h`, ou empata e é levado a `sim` no endpoint.
- O perfil inverso falha por `T^Y` para o alto.

Assim, com veto fraco, `H=(sim,sim)`, o posterior permanece `nu` e cada fraco veta exatamente quando `x_j<C`. Isso vale tanto para um veto quanto para vários, e para `m=2` ou `m>=3`.

Quando todos os fracos votam `sim`, `H=(não,não)` pode sustentar atraso apenas sob:

```text
Y<ell, se nu<=nu_star;
Y<h,   se nu>nu_star.
```

As desigualdades são estritas. A crença após o `sim` fora do perfil pode induzir pooling, dando o piso mínimo `B` aos fracos.

### Separação

Para prior estritamente interior, `H=(sim,não)` faria o `não` revelar o alto. O baixo poderia imitá-lo e obter `h`; aceitar exigiria `Y>=h`, enquanto o alto só votaria `não` se `Y<h`. Não há solução.

A separação inversa exigiria `Y<ell` para o baixo rejeitar e `Y>=h` para o alto aceitar. Também é impossível.

### Certificado de inexistência

Para `0<nu<=nu_star`, a proposta

```text
s_dagger = (Y=ell, x_j=A para todo j,
            r_i=1-ell-(m-1)A)
```

é factível porque

```text
r_i-A = 1-beta > 0.
```

Como `A` é o máximo de `W(eta)`, todos os fracos votam `sim`, qualquer que seja a estratégia pura de `H`. A enumeração é correta:

| Perfil de `H` | Desvio destrutivo |
|---|---|
| `(sim,sim)` | `H1` vota `não` e recebe `h>ell` |
| `(não,não)` | `H0` empata em `ell`; `T^Y` exige `sim` |
| `(sim,não)` | `H0` imita o `não` revelador do alto e recebe `h>ell` |
| `(não,sim)` | `H1` imita o `não` revelador do baixo e recebe `h>ell` |

Logo esse ballot não possui equilíbrio puro. Como PBE requer racionalidade sequencial também após propostas de probabilidade zero, a inexistência global em `0<nu<=nu_star` está provada.

### Regiões de existência

Em `nu=0`,

```text
L_star:
Y=ell, x_j=A, r_i=Q_L=A+1-beta.
```

O perfil on-path é `(sim,não)`. Todo acordo baixo precisa pagar pelo menos `ell` e `A` a cada fraco; pooling é mais caro; atraso paga no máximo `A`. Como `Q_L-A=1-beta>0`, `L_star` é o único ótimo on-path.

Em `nu_star<nu<=1`,

```text
P_star:
Y=h, x_j=B, r_i=Q_P=B+1-beta.
```

Todo pooling paga pelo menos `h` e `B`; atraso paga `B`; separação não sobrevive. Como `Q_P-B=1-beta>0`, `P_star` é o único ótimo on-path.

A contabilidade por tipo, a aplicação única de `beta`, o caso `m=2` e o desaparecimento das misturas acordo–atraso estão corretos.

## Findings

| ID | Severidade | Localização | Finding | Consequência | Reparação dirigida |
|---|---|---|---|---|---|
| GT-01 | **major** | `model_redesign/essential_input_solution_concept/n4_r1_unanimity_rederivation_candidate.md:183-229`, especialmente 193-209; afirmação de multiplicidade em 360-362; `n4_r1_unanimity_candidate.json:35-55`; claim `N4-C13` | A correspondência de N4 em `nu=0` omite multiplicidade de **estratégias de ballot** fora do caminho. Tome uma proposta factível com `Y<ell` e `B<=min_j x_j<A`. Há dois equilíbrios puros locais. Primeiro: `H=(sim,sim)`, posterior zero após `sim`, cutoff fraco `A`, ao menos um veto fraco; escolha screening após o `não` fora do perfil, e `T^Y` mantém ambos os tipos de `H` em `sim`. Segundo: `H=(não,não)`; após o `sim` fora do perfil escolha crença pooling, o cutoff vira `B`, todos os fracos votam `sim`, e ambos os tipos preferem estritamente `não` porque `Y<ell<h`. Ambos levam a atraso e dão `A` ao proponente, mas são perfis de estratégia distintos. | Não altera `L_star`, os payoffs, a partição de existência ou o certificado de inexistência. Porém contradiz a afirmação de que a multiplicidade restante está apenas em crenças e impede chamar o objeto de correspondência completa sem seleção. | Preservar explicitamente os dois completamentos nessa região. A classificação local forçada em `nu=0` é: `min x<B` ⇒ apenas `(sim,sim)` com veto fraco; `B<=min x<A` e `Y<ell` ⇒ ambos `(sim,sim)` com veto fraco e `(não,não)` com veto de `H`; `B<=min x<A` e `Y>=ell` ⇒ `(sim,sim)` com veto fraco; `min x>=A` ⇒ as três linhas já escritas. Atualizar JSON, status de multiplicidade, relatório e claim de correspondência. Não requer decisão autoral. |
| GT-02 | **minor** | `model_redesign/essential_input_solution_concept/n4_r1_unanimity_rederivation_candidate.md:304-325`, especialmente 319-321 | A eliminação de `(sim,não)` em `P_star` diz que o `sim` revela o tipo baixo em todo `nu_star<nu<=1`. Isso é falso em `nu=1`: a ação prescrita apenas para `H0` tem probabilidade total zero, então Bayes não fixa o posterior. | A conclusão de unicidade de `(sim,sim)` continua correta, mas o argumento escrito não cobre corretamente o endpoint `nu=1`. | Separar `nu<1` de `nu=1`. No endpoint, qualquer que seja a crença livre após o `sim`, `H1` recebe `h` votando `não`; ao desviar para `sim`, recebe `h` se a proposta passa e continua com `h` se houver veto fraco. A igualdade esperada aciona `T^Y`, eliminando seu `não`. Reparo único e sem decisão autoral. |

## Contagem e veredito

```text
critical: 0
major:    1
minor:    1
```

**Veredito: REVISE — 0/1/1.**

Os resultados centrais estão confirmados: N3 sobrevive com os reparos anunciados; N4 tem PBE apenas em `nu=0` e `nu>nu_star`, não tem PBE puro em `0<nu<=nu_star`, não apresenta atraso on-path onde existe e usa o mesmo cutoff `C` para `m=2`. O novo hash precisa apenas preservar a multiplicidade off-path omitida e corrigir o argumento de Bayes em `nu=1`; ambos são reparos dirigidos, sem escolha de protocolo.
