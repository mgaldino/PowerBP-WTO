# Parecer B — Calculadora sintética de renda informacional

## Resumo executivo

A arquitetura implementa corretamente diferenças cartesianas componente a componente, preserva conjuntos vazios, não convexifica e mantém `RI_M`, `RI_U` e `DeltaRI` separados. Dois problemas impedem PASS: a classificação de sinais não coincide exatamente com o estimando matemático perto de zero, e listas malformadas podem gerar payoffs por reciclagem silenciosa.

## Nota geral: C

## Veredito: FAIL — 1 crítico / 1 importante / 0 sugestões

## Problemas críticos 🔴

1. **A tolerância fixa pode alterar uma conclusão de robustez institucional.**

   `ri_sign_class()` classifica valores estritamente positivos menores ou iguais a `1e-12` como zero. Como `ri_robustness()` e `delta_ri()` não expõem essa tolerância, uma `DeltaRI` estritamente positiva pode deixar de ser declarada `robust_positive`.

O contrato define robustez pelo sinal estrito de todos os vetores, não por uma faixa numérica em torno de zero. A implementação precisa distinguir uma convenção aproximada explicitamente documentada da classificação matemática exata.

## Melhorias importantes 🟡

1. **Vetores de payoff com comprimento incorreto podem ser reciclados.**

   No ramo de lista de `ri_as_payoff_set()`, os elementos são convertidos e enviados diretamente a `do.call(rbind, ...)`. Um elemento escalar pode ser reciclado para duas colunas, fabricando silenciosamente um vetor como `(x,x)` em vez de produzir erro. Cada elemento da lista deve ter exatamente duas coordenadas antes do `rbind`.

## Sugestões 🟢

Nenhuma enquanto os dois findings estiverem abertos.

## Pontos positivos ✓

- A diferença de conjuntos usa o produto cartesiano completo.
- Duplicatas exatas são removidas sem convexificação.
- `RI_M` e `RI_U` existem separadamente.
- `DeltaRI` fica vazio quando qualquer renda-fonte é vazia.
- Conjuntos vazios não recebem sentinelas ou registros artificiais.
- Envelopes são calculados por coordenada.
- A imagem ex ante usa o mesmo prior em cada vetor e trata corretamente `nu=0` e `nu=1`.
- Os testes cobrem singleton, multiplicidade, ausência de convexificação, vazios, sinais coordenados, endpoints e diferenças duplicadas.
- A busca textual confirmou que nenhum payoff N6/N7 é importado; trata-se apenas de maquinaria sintética.

## Comandos executados

```text
Rscript --vanilla scripts/ri_estimand_functions.R
```

Esse comando apenas carregou/parseou o módulo e terminou sem erro.

O runner abaixo **não** foi executado nesta revisão:

```text
Rscript --vanilla scripts/run_test_ri_estimand_functions.R
```

Ele reescreve o arquivo de sessão, o que violaria o mandato read-only. O arquivo de sessão existente foi inspecionado e registra R 4.4.2 e `testthat` 3.2.3, mas não contém o resumo dos testes; portanto, não constitui por si só evidência independente do PASS anterior.

## Limitações

- Os 28 expectations existentes foram revisados estaticamente, mas não reexecutados nesta revisão read-only.
- Não há teste para vetores de lista com comprimento diferente de dois.
- Não há teste para sinais estritos com magnitude inferior a `1e-12`.
- Este parecer não deriva nem abre N7 e não avalia payoffs N6.

Nenhum arquivo foi criado, editado ou removido durante a revisão.

---

**Independência:** parecer produzido por agente separado, em modo estritamente read-only; nenhum arquivo foi alterado pelo revisor.
