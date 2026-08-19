# N6 v2 — finding bloqueante de schema e suficiência das fontes

**Data:** 2026-08-19

**Status:** `pending protocol decision`

**Classificação:** `substantivo / blocking`, pela Seção 11.1 do contrato

**Ponto de parada:** `N6` reaberto administrativamente; nenhum candidato `N6`
v2 criado, nenhuma revisão final iniciada e nenhuma renda de `N7` calculada

## 1. Escopo autorizado e resultado da tentativa

O autor autorizou reabrir somente `N6`, mantendo `N1`--`N4` congelados e
consumindo exclusivamente as interfaces congeladas de `N3` e `N4`, sem
rederivá-las, reinterpretá-las ou alterá-las. O objetivo era republicar `N6`
no mesmo schema `private_information_comparison_v1` como interface executável e
autossuficiente para a Fase B de `N7`.

A implementação parou antes de criar qualquer arquivo de candidato. Duas
auditorias preliminares independentes — uma da implementação e outra do encaixe
no schema — chegaram ao mesmo finding: a combinação das fontes autorizadas com
o schema corrente não comporta o output pedido sem uma decisão substantiva.

## 2. Texto original dos findings

### 2.1 Fonte congelada

> STOP condition triggered before edits. Rechecked solely in frozen N4
> interface ee61ce6f...27f2d: line 10 defines a0,z,p,u0 only for m=2
> (denominator 2); m>=3 cells at lines 235, 311, 386 merely say `Define a0,
> z, p, u0...` / use `nu_2` without formulas. `s=(1-nu)z` is stated, but z
> is undefined there. Generalizing /2 to /m or importing N4 derivation/N2
> would be inference beyond the frozen interface and violates the explicit
> no-rederive/no-reinterpret rule.

### 2.2 Schema corrente

> NÃO. O schema corrente `private_information_comparison_v1`, com os
> predicados e verificadores atuais, não comporta de modo normativamente
> válido e executável todos os objetos pedidos sem novo conteúdo substantivo.
> Mecanicamente, seria possível esconder objetos arbitrários dentro de
> `checks_performed` ou `private_rule_contrasts`, pois esses containers são
> pouco tipados. Isso seria “schema laundering”: os novos objetos continuariam
> substantivos, apenas sem campo declarado. A Seção 7.2 exige extensão
> explícita quando o nó precisa exportar mais que os campos definidos.

## 3. Evidência estritamente nas fontes autorizadas

### 3.1 Maioria

O registro de `N3` contém em `strategy_profile` as definições de `A_i_star`,
`I_H`, `I_X`, `I_D`, `t_0`, `t_1`, os candidatos `E_i`, `S_i`, `P_i` e as
fronteiras paramétricas. O schema de `N6`, porém, não transporta
`strategy_profile`, `belief_system`, `branch_classification`,
`assumptions_used` ou `payoff_date` nos registros privados. O `N6` antigo
transporta apenas a expressão aberta

```text
C_H(theta)=(1/m)*sum_i E_{s~F_i}[
  y*I_H(s,theta)+(y+o_theta)*I_X(s,theta)+t_theta*I_D(s,theta)
]
```

sem transportar o domínio executável de `F_i` nem as definições dos
indicadores. Por isso, `N7` não consegue projetar a correspondência de payoff
de `H` ou verificar singleton e fronteiras apenas a partir de `N6`.

### 3.2 Unanimidade para `m>=3`

A interface congelada de `N4`, hash
`sha256:ee61ce6f854d4393f51048592a5221a9999a8f3f7daca1e749e7f19a88927f2d`,
define explicitamente `a0`, `z`, `p` e `u0` somente na célula `m=2`. Nas
células `N4-CELL-MGE3-NU0`, `N4-CELL-MGE3-LOW` e
`N4-CELL-MGE3-HIGH`, ela apenas nomeia esses objetos e `nu_2`, sem fórmulas em
primitivas. As condições de pooling usam ainda `lambda_i^P`,
`lambda_i^D`, `R_i`, `Y_i`, factibilidade, crenças e punições sem exportar um
predicado fechado que determine os endpoints de `Y`.

Consequentemente, calcular os limites exatos de `Y`, seu status aberto ou
fechado e máximo versus supremo exigiria pelo menos uma das operações proibidas:

1. generalizar fórmulas específicas de `m=2` para `m>=3`;
2. importar a derivação de `N4` ou a interface de `N2` como nova fonte;
3. preencher uma definição ou uma regra de transporte que o contrato não dá.

### 3.3 Endpoint `nu=0`

Em `nu=0`, a interface de `N4` preserva três papéis puros payoff-distintos por
identidade: low-only, pooling e atraso. Um único `rho=k/m` e uma única oferta
média de pooling não parametrizam essa correspondência. Preservá-la exige ao
menos as parcelas `rho_L`, `rho_P` e `rho_D`, com soma um, e médias separadas
`bar_Y_L` e `bar_Y_P`, ou outra convenção escolhida pelo autor. Escolher a
redução sem essa decisão excluiria valores válidos de payoff de `H`.

## 4. Por que o reparo não é técnico

Há mais de um reparo coerente, com invalidações diferentes. Além disso, faltam
definições para `m>=3` e há ambiguidade sobre o local normativo do certificado
executável. Pela Seção 11.1, definição faltante e ambiguidade nunca são reparos
técnicos.

Usar `checks_performed` ou `private_rule_contrasts` como contêiner genérico não
resolve o problema: colocaria um novo contrato de projeção dentro de um campo
com outra função sem declarar a extensão no DAG. Também não é permitido ao
implementador transformar a derivação ou a interface de `N2` em autoridade
sem decisão autoral e hash explicitamente autorizados.

## 5. Estado preservado

- `N1`, `N2`, `N3` e `N4` permanecem byte a byte nos hashes congelados;
- o antigo `N6`, seu hash e seus pareceres permanecem como proveniência
  obsoleta, sem serem editados;
- o candidato intermediário da Fase A permanece exatamente em
  `sha256:db7b590ab53694e9d6cb90a0aae7242ce1926c32a9f59638788bb0758d632cb5`;
- `N6` e `N7` permanecem `pending/unfrozen`;
- nenhuma das duas revisões finais de `N6` foi iniciada, pois não existe hash de
  candidato a submeter;
- Fase B, equal-area, freeze de `N7`, Goal 5, manuscrito e `beta=1` permanecem
  parados.

## 6. Decisões possíveis

### A. Reabrir `N3` e `N4` para interfaces autossuficientes — recomendada

Republicar `N3` e `N4`, nos campos semanticamente próprios de
`equilibrium_correspondence_v1`, com mapas fechados entre primitivas, seleções
admissíveis e vetores de payoff. `N4` definiria explicitamente todos os objetos
de `m>=3`, o suporte exato de `Y`, os endpoints e a parametrização de `nu=0`.
Depois dos ciclos de revisão exigidos, `N6` poderia transportar literalmente
essas interfaces sem esconder um schema novo.

Consequência: `N3`, `N4`, `N6` e `N7` voltam ou permanecem `pending`; `N1` e
`N2` podem permanecer válidos se nenhuma fonte compartilhada mudar. Esta opção
substitui a autorização corrente, que limita a reabertura a `N6`.

### B. Criar um campo tipado novo em `N6`

Adicionar, por exemplo, um contrato explícito de projeção privada ao schema de
`N6`, com símbolos, domínios, seleções, mapas de payoff e endpoints. É a solução
mais clara para auditoria, mas muda o schema e, pela Seção 12.1, reabre Gate 0
e devolve todos os nós a `pending`.

### C. Autorizar fonte auxiliar ou dependências diretas

Autorizar um certificado externo hashado, permitir que `N6` consuma outro
artefato normativo ou dar a `N7` dependências diretas de `N3`/`N4`. Isso altera
a fronteira de dependência e possivelmente a topologia; também exige indicar a
fonte autoritativa das fórmulas ausentes de `m>=3`.

## 7. Decisão solicitada ao autor

Escolher uma das opções acima e, se escolher A ou C, decidir explicitamente
como parametrizar a célula `nu=0`. A recomendação é A, com
`(rho_L,rho_P,rho_D)` e `(bar_Y_L,bar_Y_P)` como coordenadas de reporte — não
como novas primitivas nem seleção de equilíbrio.

Até nova decisão, não existe reparo autorizado que permita criar `N6` v2.
