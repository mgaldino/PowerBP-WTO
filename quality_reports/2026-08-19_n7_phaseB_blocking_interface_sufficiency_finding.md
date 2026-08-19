# Goal 4, N7 Fase B — finding bloqueante de suficiência da interface

**Data:** 2026-08-19  
**Status:** `pending protocol decision`  
**Classificação:** `substantivo / blocking`, conforme a Seção 11.1 do contrato  
**Ponto de parada:** autorização e escolhas da Fase B registradas; nenhuma renda,
projeção, agregação equal-area ou interface completa de `N7` foi construída

## 1. Fronteira verificada

Antes do finding, a auditoria read-only confirmou:

- raiz Git e novo worktree corretos;
- branch `codex/essential-input-goal4-n7-phaseb` no commit-base
  `c85c1876191af41935d200f1612db42b54324994`;
- contrato-base, DAG, verifier Gate 0, `N6` e candidato Fase A nos cinco hashes
  fornecidos pelo autor;
- tag `pre-essential-input-2026-08-12^{}` em
  `f53e6769624ce3dd6e64e21ad40d08230b0950a7`;
- `N6` `pass/frozen` no hash
  `sha256:e5a71e29720598f829beb4f720bc966a64d2b04569ded0ba404cdd03b81b3f2a`;
- candidato Fase A no hash
  `sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`;
- `N7` `pending/unfrozen`;
- verifier de `N6`: `PASS`;
- verifier Fase A: `PASS`;
- checker canônico com `--require-execution-order`: `VALID`;
- checker canônico com `--candidate N7`: `VALID`.

Os warnings de locale foram isolados e não constituem finding.

O contrato recebeu somente o registro da autorização e das convenções de
projeção/reporte da Fase B. O hash corrente desse arquivo é
`sha256:29ac686bf4093a9239b023bd767295b19f654478cb982b4047ded309ee3e7aca`.
O verifier Gate 0 ainda fixa o snapshot normativo anterior da Fase A. Ele não foi
repinado porque a decisão abaixo pode exigir nova transição de lifecycle e,
portanto, novo texto normativo.

## 2. Texto original consolidado do finding

> O `N6` congelado não exporta informação suficiente para executar a Fase B
> sem preencher lacunas por inferência. Na maioria, exporta apenas a fórmula
> abstrata `C_H(theta)` e referências a `A_i_star`, `I_H`, `I_X`, `I_D` e
> `t_theta`, sem definições, ramos, fronteiras ou tie-breaks que determinem a
> projeção. Na unanimidade `m>=3`, usa `a0`, `z`, `p`, `u0` e `nu_2` sem
> fórmulas completas e não exporta os witnesses off-path necessários para
> demonstrar o conjunto exato e os endpoints de `Y`. Assim, N6 mais o
> candidato público identificam apenas subtrações simbólicas; não identificam
> a unicidade genérica majoritária, suas exceções, os envelopes, o máximo ou
> supremo de pooling, as médias uniformes ou as parcelas de sinal robusto.

Este texto foi confirmado por três leituras read-only independentes, de
derivação, schema e agregação. Nenhuma delas editou arquivos.

## 3. Evidência no input autorizado

### 3.1 Maioria privada

O único registro majoritário de `N6` exige que cada `F_i` tenha suporte em
`A_i_star(nu)` e exporta:

```text
C_H(theta)=(1/m)*sum_i E_{s~F_i}[
  y*I_H(s,theta)+(y+o_theta)*I_X(s,theta)+t_theta*I_D(s,theta)
]
```

Mas o artefato não define `A_i_star`, os três indicadores, `t_theta`, as
famílias que integram o argmax, suas condições paramétricas ou as fronteiras
em que mais de um vetor de payoff de `H` sobrevive. Sem esses objetos, não é
possível provar a conjectura de projeção genericamente singleton nem preservar
suas exceções exatas.

### 3.2 Unanimidade privada

Os registros `m>=3` informam que pooling e atraso existem e impõem condições
como:

```text
s <= R_i <= p
Y_i >= beta*o_1
x_j >= z
factibilidade
R_i=s implica Y_i=beta*o_1
```

Porém suas células dizem apenas “defina `a0`, `z`, `p`, `u0`” ou usam
`nu_2`, sem exportar as fórmulas gerais. Também não exportam a construção de
crenças e punições off-path que demonstra suficiência para cada `Y`. Logo, a
factibilidade fornece apenas uma restrição simbólica; ela não basta para provar
quais endpoints são sustentáveis ou se o limite superior é máximo ou apenas
supremo.

No endpoint `nu=0`, há ainda três papéis privados payoff-distintos — low-only,
pooling e atraso. A parametrização `rho=k/m` mais oferta pooling média é
suficiente para as células positivas de prior com dois papéis, mas não para
`nu=0`; preservar a correspondência completa exige três parcelas que somem um,
além das ofertas médias low-only e pooling.

### 3.3 Contrafactual público

O candidato da Fase A é suficiente para o lado público. Ele fixa o payoff de
`H` sob unanimidade em `(beta*o_0,beta*o_1)` e fornece os ramos públicos de
maioria por tipo. A lacuna está integralmente no lado privado transportado por
`N6`.

## 4. Por que o reparo não é técnico

O contrato determina que `N7` depende diretamente apenas de `N6` e que o
consumidor não pode rederivar nem completar sua continuação. A autorização da
Fase B também manda consumir somente `N6` congelado e o candidato Fase A.

Há pelo menos três reparos possíveis, com consequências diferentes. Portanto,
não existe reparo único forçado e a Seção 11.1 exige escalação.

Durante o diagnóstico, o agente principal e um leitor chegaram a consultar as
derivações predecessoras de `N3`/`N4`. Esse material foi imediatamente
quarentenado: nenhuma fórmula ou conclusão obtida dali é promovida como output
da Fase B. O finding acima foi rechecado exclusivamente no contrato, em `N6` e
no candidato Fase A.

## 5. Decisões possíveis

### A. Reabrir e enriquecer somente `N6` — recomendada

Republicar `N6` no mesmo schema, consumindo os mesmos `N3` e `N4` congelados,
mas tornando a interface autossuficiente. Ela transportaria explicitamente:

1. definições e fronteiras da projeção majoritária;
2. `a0`, `z`, `p`, `u0`, `nu_2` e demais objetos por célula;
3. conjunto exato de `Y`, witnesses off-path e status dos endpoints;
4. mapa entre perfis puros por identidade, misturas locais e pesos `lambda`;
5. crosswalk notacional `nu=mu`.

Consequência: `N6` volta a `pending/unfrozen`, recebe novo hash e exatamente
dois novos pareceres; `N7` permanece pendente como descendente. `N1`--`N4`
podem permanecer congelados se seus conteúdos não mudarem. Esta opção exige
nova autorização porque o mandato corrente proíbe alterar `N1`--`N6`.

### B. Dar dependência direta de `N7` a `N3` e `N4` — não recomendada

Isso muda a topologia e o contrato de consumo de `N7`, acionando a invalidação
ampla da Seção 12.1 e enfraquecendo a fronteira de interface.

### C. Manter os congelamentos e calcular apenas diferenças abstratas

Seria possível registrar somente:

```text
RI_M = V_M^priv - V_M^pub
RI_U = V_U^priv - (beta*o_0,beta*o_1)
DeltaRI = RI_U - RI_M
```

Isso não cumpre as escolhas autorais de projeção, pooling, envelopes e
agregação equal-area. `N7` continuaria incompleto e pendente.

## 6. Decisão solicitada ao autor

Autorizar ou não a opção A: reabrir exclusivamente `N6`, sem mudar `N1`--`N4`,
para publicar uma interface autossuficiente e submetê-la novamente a dois
revisores antes de retomar a Fase B.

Até essa decisão, não se altera `N6`, não se constrói `N7`, não se executa a
agregação equal-area, não se congela nó algum e não se abre o Goal 5.
