# Revisão independente read-only — `A_M` M/S/B, rodada 1

**Data:** 2026-08-29  
**Revisor:** agente Codex independente, formal/game-theoretic  
**Edição de arquivos pelo revisor:** nenhuma  
**Snapshot:** `4bda7b71e1e6d4e836912b533fef8b28ee044c71`  
**Manifesto revisado:** SHA-256
`407114fefa8d0fc13066ef1a1d706bb7e6290ec904c2b76f892b948229e70e0d`;
todos os dez registros passaram em `shasum -a 256 -c`.  
**Verificador reproduzido:** `2831 PASS / 0 FAIL`, tratado somente como
controle mecânico.

## Veredicto

```text
FAIL — 0 critical / 3 important / 3 minor
```

## Findings importantes

1. **Domínio omite `y_bar`.** A interface congelada N3 exige
   `o_1<=y_bar<=1`, mas a rederivação declarou somente
   `(N,beta,o_0,o_1)`. Reparo: transportar `y_bar` e provar invariância.
2. **Codomínio mensurável de `chi` e kernels não definido.** “Subconjunto
   anônimo literal” não especificava espaço mensurável, mapas de payoff nem
   kernels terminais. Reparo: parametrizar explicitamente os representantes
   uniformes `E/S/P`, a mistura residual `E/P` e suas projeções Borel.
3. **AMX-016 omite endpoints.** `R` e `Sig(R)` eram definidos somente para
   `0<nu<1`, mas o ledger alegava todos os PBEs. Reparo: criar objetos endpoint
   sem divisões por `nu` ou `1-nu` e incluir suas assinaturas.

## Findings menores

1. A prova escrita de AMX-010 deveria usar a proposta robusta que paga
   `beta/m` a `k` fracos, em vez de inferir atingibilidade de
   `A_chi(mu)>=Z_E` para um posterior endógeno.
2. Em §10, `s_D` tem posterior 1 por Bayes; ele apenas coincide com
   `nu_off=1`. Em §12, M exclui o seletor literal antigo e B exclui sua
   reconstrução por crenças — não são duas violações literais independentes.
3. Claims negativos verdadeiros estavam marcados `rejected`; devem receber
   `proved`, ou o texto do claim deve ser invertido.

## Resultados confirmados

- membership literal da loteria uniforme e payoff-equivalência com o ciclo,
  condicional ao domínio completo de N3;
- transporte único de `beta`, cutoff `r_chi(mu)` e quota de `k` votos;
- validade do PBE que refuta fechamento global;
- completude da classificação pura interior para `(nu_off,chi)` fixados;
- cobertura das regiões paramétricas pelas testemunhas de existência;
- reescopo correto do semipooling e falha do exemplo assimétrico;
- não-finitude das assinaturas e validade da família atomless;
- validade substantiva dos limites, com a prova robusta indicada;
- preservação do certificado histórico `sup g=51/100` no contrato antigo.

## Limite do parecer

AMX-015 permanecia condicional à estrutura mensurável faltante e AMX-016 não
cobria endpoints. Nenhum resultado foi autorizado para consumo downstream.

