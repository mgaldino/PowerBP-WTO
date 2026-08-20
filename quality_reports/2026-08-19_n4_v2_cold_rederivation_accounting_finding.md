# Finding bloqueante da rederivação fria de N4 v2

**Data:** 2026-08-19  
**Status:** `BLOCKED — aguardando decisão autoral`  
**Nó afetado:** `N4` e, por descendência, `N6` e `N7`  
**Nós não afetados:** `N1`, `N2` e a álgebra rederivada de `N3`  
**Contrato governante:** `quality_reports/plans/2026-08-12_essential_input_gate0.md`  
**Dependência consumida:** `N2`, `sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`

## 1. Regra de parada aplicada

A decisão autoral que reabriu `N3` e `N4` determinou que os objetos exportados
fossem rederivados friamente desde as primitivas e a dependência congelada. Se
a nova derivação divergisse da álgebra anterior, o trabalho deveria parar e o
resultado deveria ser escalado, sem promover silenciosamente uma fórmula
alternativa.

Essa regra foi acionada antes da criação de qualquer arquivo `N4 v2`. `N6` e
`N7` não foram iniciados. O candidato `N3 v2`, que reproduziu a álgebra de N3,
foi interrompido depois de concluído e permanece `pending`, sem revisão e sem
integração no DAG.

## 2. Finding original do implementador

> **FINDING N4-V2-ACCOUNTING-01 — substantivo e bloqueante.** A construção
> de punição usada anteriormente para obter `L3=(1-nu)z` prescreve dois weak
> nonproposers votando `não`, o tipo baixo de `H` votando `não` e o tipo alto
> votando `sim`. O vetor do tipo baixo recebe uma continuação pooling; o vetor
> do tipo alto, uma continuação low-only. No ramo realizado `theta=1`, porém,
> o equilíbrio low-only de N2 oferece `y=o_0`, o tipo alto rejeita e o payoff
> realizado de cada weak state é `0`. Usar `a0=beta*(1-o_0)/m` nesse ramo
> transporta indevidamente um valor ex ante de N2 como se fosse payoff
> condicionado ao tipo alto. Com o payoff correto, o weak rejector não prefere
> estritamente `não`; uma troca unilateral para `sim`, mantendo o outro weak
> rejector, dá payoff fracamente maior e, na igualdade, `T^Y` seleciona `sim`.
> A mesma contabilidade aparece na construção de punição de `m=2`. Portanto
> `L2`, `L3`, os limites de concessão `Y` e as condições de delay precisam ser
> rederivados antes de qualquer nova interface.

## 3. Verificação independente pela árvore terminal

Defina, sem o fator de desconto,

```text
a = (1-o_1)/m,
b = (1-o_0)/m,
b > a.
```

A interface congelada de N2 implica a seguinte tabela de payoffs realizados
para um weak state antes do reconhecimento em R2:

| Continuação de N2 | Oferta | `theta=0` | `theta=1` |
|---|---:|---:|---:|
| low-only | `y=o_0` | `b` | `0` |
| pooling | `y=o_1` | `a` | `a` |

O campo weak de N2 na célula low-only é `(1-nu)*(1-o_0)/m`: trata-se de uma
expectativa no information set de R2. Ele não transforma o payoff realizado do
ramo alto em `b`. Quando `theta=1`, `H` rejeita `y=o_0`, a proposta terminal
falha e os weak states recebem zero, conforme as transições e os payoffs da
Seção 4 do contrato.

Considere a construção antiga em uma proposta de probabilidade zero, com
crença de ballot `rho=Pr(theta=1)`. Dois weak states votam `não`; `H_0` vota
`não` e leva a uma continuação pooling; `H_1` vota `sim` e leva a uma
continuação low-only. O payoff interim correto de cada weak rejector é

```text
U_j(no) = beta*[(1-rho)*a + rho*0].
```

Se um rejector troca unilateralmente para `sim`, o outro `não` ainda impede a
aprovação em R1. Mesmo permitindo que cada vetor de votos de probabilidade
zero receba um posterior de R2 livre, os payoffs realizados possíveis são:

```text
theta=0: a ou b, logo no mínimo a;
theta=1: 0 ou a, logo no mínimo 0.
```

Assim, `U_j(sim) >= U_j(no)` para toda atribuição admissível desses
posteriors. Se a desigualdade for estrita, racionalidade sequencial exige
`sim`; se houver igualdade, a convenção `T^Y` também exige `sim`. A liberdade
das crenças off-path pode mudar a estratégia futura de N2, mas não pode
converter a falha realizada no estado alto em payoff `b`.

Uma auditoria read-only específica, feita sem consultar a derivação antiga de
N4, reproduziu essa tabela e esse veredicto. Um contracheque preliminar que
chegou à conclusão oposta reutilizou o valor ex ante de N2 no ramo
type-conditioned; por isso ele não constitui evidência contra o finding.

## 4. Classificação segundo a Seção 11.1

A substituição local do payoff do ramo `theta=1/low-only` por zero é
univocamente imposta pelas primitivas, pela interface congelada de N2 e pela
árvore terminal. Ela não requer mudar N2, `T^Y`, o schema, a topologia ou o
jogo.

O finding é, contudo, **bloqueante e substantivo para o conteúdo de N4**:
essa correção invalida a construção que sustentava as garantias exportadas e
altera potencialmente a correspondência de equilíbrio. Não há reparo local de
texto capaz de determinar automaticamente:

- a garantia exata do proponente em `m=2` e em `m>=3`;
- se cada limite é mínimo atingido ou apenas ínfimo;
- os intervalos e endpoints exatos das concessões `Y`;
- as condições de existência de delay e das misturas entre famílias;
- os payoffs de `H`, envelopes e objetos que seriam consumidos por N6 e N7.

Pela regra autoral explícita para divergências, esses objetos não são
promovidos sem nova autorização. Fórmulas alternativas mencionadas durante a
investigação são hipóteses de trabalho, não resultados.

## 5. Consequências de lifecycle e preservação

- `N1` permanece `pass/frozen` no hash corrente.
- `N2` permanece `pass/frozen` no hash
  `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`;
  o finding não está em N2.
- `N3`, `N4`, `N6` e `N7` permanecem `pending/unfrozen` no DAG.
- Nenhum candidato `N4 v2` foi criado.
- O candidato `N3 v2` concluído antes do STOP permanece não revisado e não
  congelado; não pode ser consumido por N6.
- O candidato intermediário da Fase A permanece byte a byte no hash
  `db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`.
- Nenhum PDF foi gerado, nenhum manuscrito foi tocado e nenhuma figura do
  Goal 5 foi produzida.

## 6. Decisão autoral necessária

**Recomendação:** autorizar exclusivamente a continuação da rederivação fria de
`N4` com a contabilidade type-conditioned corrigida, mantendo integralmente
N2, as primitivas, o conceito de solução, `T^Y`, o schema
`equilibrium_correspondence_v1` e a topologia. O novo N4 deverá reconstruir
`L2`, `L3`, todos os endpoints de `Y`, delay, misturas e multiplicidade desde a
árvore; qualquer nova divergência ou definição faltante volta a parar e
escalar. Depois disso, a cadência de dois pareceres independentes no mesmo hash
permanece inalterada.

Sem essa autorização, o estado correto é manter N3/N4/N6/N7 pendentes e parar.
Manter a fórmula antiga exigiria contrariar a interface N2 ou alterar o jogo e
não é uma opção autorizada.
