# Parecer independente `formal_design` — round 2

**Revisor:** `/root/formal_design_review`  
**Modo:** rerevisão dirigida, estritamente read-only  
**Manifesto revisado:** `quality_reports/2026-08-21_candidatos_n3_n4_solution_concept.sha256`  
**SHA-256 do manifesto:** `4cbc5b729eb12bf8b3d3c67cd4b4169e2259aa8e90e6f966e9754436d7d69333`

O hash do manifesto conferiu no início e no fim da revisão. `shasum -a 256 -c` passou para os nove candidatos. Nenhum arquivo foi editado.

## Escopo da rerevisão

Foram reavaliados:

- FD-MAJ-01: atomicidade da família `F=(F_i)_i` em N3;
- FD-MAJ-02: exportação, em N4, somente das crenças compatíveis com as ICs;
- GT-01: multiplicidade de perfis puros off-path em `nu=0`;
- GT-02: prova separada do endpoint `nu=1`;
- consistência entre derivação Markdown, JSON, ledgers, matriz, relatório e script;
- manutenção das dependências exclusivas N3→N1 e N4→N2;
- unidades temporais e incidência única de `beta`;
- preservação de escopo e status `pending/unfrozen`.

As interfaces-fonte continuam exatamente nos hashes:

```text
N1: 1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5
N2: c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2
```

## Teste dos findings anteriores

### FD-MAJ-01 — resolvido

O registro N3 agora vincula estratégia, payoffs e outcomes à mesma família de distribuições `F=(F_i)_i`.

Foram definidos, proposta por proposta e tipo por tipo, os indicadores mutuamente exclusivos:

```text
I_H = passagem com H,
I_X = passagem sem H,
I_D = atraso para N1.
```

A interface exporta corretamente:

- payoff do proponente reconhecido sob `F_i`;
- valor pré-reconhecimento de cada fraco identificado `l`, incluindo sua probabilidade `1/m` de ser proponente;
- payoff de cada tipo de `H`;
- probabilidades de passagem com `H`, passagem sem `H` e atraso.

Todas as expressões usam explicitamente a mesma `F`. Logo já não é possível recombinar uma estratégia de proposta com payoff ou outcome pertencente a outra distribuição. A multiplicidade por coalizão e o empate residual exclusão–pooling permanecem preservados atomicamente.

### FD-MAJ-02 — resolvido

N4 não exporta mais toda crença livre em `[0,1]` independentemente da estratégia. A correspondência agora condiciona cada crença livre às ICs relevantes.

Na região alta, para um perfil `(não,não)` com `u=min_j x_j`, a crença após o `sim` fora do perfil deve satisfazer:

```text
W(eta_Y) <= u.
```

Assim, o contraexemplo do round 1 — `B<=u<A`, `Y<h` e `eta_Y=0`, que produziria `W(0)=A>u` — foi excluído corretamente. As crenças declaradas livres nos demais ramos são realmente inócuas para as ações prescritas.

Em `nu=0`, as restrições `eta_N<=nu_star` aparecem exatamente nos ramos em que uma crença pooling tornaria lucrativo o desvio de `H0`. A interface distingue corretamente unicidade on-path de multiplicidade off-path condicionada às ICs.

### GT-01 — resolvido sem quebrar o desenho formal

A enumeração completa em `nu=0` agora preserva os dois perfis puros na região:

```text
B <= min_j x_j < A
e
Y < ell.
```

Nessa região:

- `(sim,sim)` gera veto fraco, com cutoff `A`;
- `(não,não)` usa uma crença após `sim` tal que `W(eta_Y)<=min_j x_j`, todos os fracos votam `sim` e o veto é de `H`.

Ambos atrasam e dão `A` ao proponente, mas são estratégias distintas. A inclusão dessa multiplicidade não altera `L_star`, os payoffs on-path, a célula de inexistência ou o argumento de segurança. JSON, ledger, matriz e relatório estão consistentes com ela.

### GT-02 — resolvido sem nova convenção

A prova agora separa `nu<1` de `nu=1`.

No endpoint `nu=1`, uma ação prescrita apenas para `H0` tem probabilidade total zero e Bayes não fixa sua crença. Ainda assim, os dois perfis separadores em `P_star` são eliminados:

- `H1` recebe `h` votando `não` e também recebe `h` ao mudar para `sim`, por passagem em `Y=h` ou pela continuação após eventual veto fraco;
- `T^Y` determina `sim`;
- o tipo baixo de probabilidade zero também não pode sustentar `não`, pois recebe no máximo `h`, enquanto `sim` rende `h`.

A unicidade do perfil pooling `(sim,sim)` em `P_star` está, portanto, provada inclusive no endpoint.

## Estabilidade dos resultados

Os reparos não alteraram a caracterização substantiva:

- N3 continua existindo em todo o domínio, com exclusão, screening ou pooling conforme as fronteiras rederivadas;
- `E-R=1-beta*q/m>0` continua eliminando rejeição deliberada;
- N3 permanece posterior-invariante porque consome somente N1;
- N4 existe em `nu=0` com `L_star`;
- N4 não possui PBE com ballots puros em `0<nu<=nu_star`;
- N4 existe em `nu_star<nu<=1` com `P_star`;
- não há atraso on-path nas células de existência;
- `m=2` usa o mesmo cutoff aberto `x<C`;
- `beta` entra uma única vez ao transportar N1 ou N2 para R1.

O certificado `s_dagger` continua válido: `A` força todos os votos fracos em `sim`, e as quatro estratégias puras de `H` continuam eliminadas.

## Verificações dirigidas

O script R passou com:

```text
MODEL_PROOF_DIRECTED: PASS
ALGEBRA_IDENTITIES: PASS
FINITE_ENUMERATION: PASS
```

A enumeração agora cobre também a sobreposição off-path em `nu=0` e o endpoint `nu=1`. Os dois JSON passaram no parser, e `git diff --check` não encontrou problemas. Esses checks foram tratados como apoio algébrico e de integridade, não como substitutos das provas humanas.

## Findings remanescentes

Nenhum finding crítico, major ou minor foi encontrado no hash rerevisado.

```text
critical: 0
major:    0
minor:    0
```

## Veredito

**PASS 0/0/0**

O veredito aplica-se exclusivamente aos nove candidatos identificados pelo manifesto SHA-256 `4cbc5b729eb12bf8b3d3c67cd4b4169e2259aa8e90e6f966e9754436d7d69333`. Ele não congela N3/N4, não integra o DAG e não autoriza N6, N7, comparação, figuras, PDF ou manuscrito.
