# Parecer independente — N3 R1 maioria

`reviewer_role=formal_design`  
`reviewer_id=review-n3-formal-2026-08-18`

Nenhum arquivo foi editado. N3 foi reconstruído antes da leitura do candidato, consumindo exclusivamente N1. N2 não foi usado.

## Dependência e timing

N1 está efetivamente `pass/frozen`, com dois pareceres `0/0/0`, no hash:

`sha256:bfe56e486098589b10724d6dbd7889eaf1ead087443717c96b6a1f45bd498c9d`

Seu transporte correto para R1 é:

```text
w       = beta/m
t_theta = beta*o_theta
```

O desconto incide exatamente uma vez. Aprovações em R1 permanecem em unidades correntes.

## Reconstrução e confronto

A reconstrução independente coincide com o candidato:

- Weak nonproposer vota `sim` iff `x_j>=w`; em `x_j=w`, `T^Y` seleciona `sim`.
- Se `k>=q-1`, `H` é não pivotal e vota `não`: `sim` paga `y`, enquanto `não` paga `y+o_theta`.
- Se `k=q-2`, `H` é pivotal e o tipo `theta` aprova iff `y>=t_theta`.
- Se `k<=q-3`, a proposta falha com qualquer voto de `H`; a continuação é `t_theta` em ambos os casos e `T^Y` seleciona `sim`.
- A fórmula do proponente cobre perfil por perfil todas as propostas factíveis.

A redução para os ramos derivados é exaustiva:

```text
E = 1-(q-1)w
L = 1-(q-2)w-t_0
P = 1-(q-2)w-t_1
S(nu) = (1-nu)L + nu*w
D = E-w = 1-qw >= 0
```

As fronteiras de screening–pooling, screening–exclusão e as igualdades em `o_0=1/m` e `o_1=1/m` estão corretas. O canto `D=0` ocorre exatamente quando `beta=1` e `N` é `3` ou `4`; nele, delay, folga e multiplicidade são preservados precisamente nas condições derivadas.

## Obrigações do contrato

| Obrigação | Resultado |
|---|---|
| P0 | PASS — optima aprovados exaurem a pie; folga só sobrevive endogenamente no ramo de rejeição selecionado com `D=0`. |
| P1 | PASS — o hedge `s'=(0,x,r_i+y)` é factível e melhora estritamente o payoff do proponente, inclusive off-path. |
| P1a | PASS — nenhuma aprovação on-path sem `H` mantém `y>0`; exclusão com `y=0` permanece. |
| P2 | PASS — derivação usa somente N1 congelado, cobre propostas, votos, factibilidade, fronteiras e igualdades. |
| P6 | PASS — stage-undominance aplica-se somente aos weak nonproposers; `T^Y` é usado apenas em indiferenças genuínas. |
| P7 | PASS — o voto público de `H` entra em Bayes; propostas e vetores de probabilidade zero recebem crenças explícitas e irrestritas. |

A parametrização por `(F_i)_{i in W}` não impõe simetria entre proponentes. Payoffs dos weak states permanecem indexados por identidade, e estratégias, crenças, payoffs por tipo e outcomes usam o mesmo perfil `(F_i)`, preservando atomicidade. Tipos de probabilidade zero e pontos de suporte atomless com probabilidade individual zero estão explicitamente cobertos.

## Execução

- Hash N3 confirmado: `820b2478205d25338511a372b1f5662514ffb499f666e7b91d6813eb00db93f6`.
- `verify_essential_input_n3.R`: PASS.
- Verificador de N1: PASS no hash congelado.
- Verificador canônico do Gate 0: PASS.
- Checker do DAG com `--candidate N3`: `VALID`; N3 está topologicamente pronto.
- Checker com `--require-execution-order`: `VALID`.
- Todas as mutation fixtures foram rejeitadas.
- Avisos observados limitaram-se ao locale do R/shell.

## Findings e veredicto

Não há findings.

- `critical=0`
- `major=0`
- `minor=0`
- **VEREDICTO ESTRITO PARA O HASH N3: PASS**
