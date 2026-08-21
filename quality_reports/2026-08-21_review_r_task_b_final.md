# Parecer final B — Calculadora sintética de renda informacional

## Resumo executivo

Os dois findings anteriores foram corrigidos. A classificação padrão agora segue o sinal matemático exato, tolerâncias aproximativas são opcionais e propagadas explicitamente, e listas malformadas são rejeitadas antes de qualquer reciclagem. Os dez blocos e 33 expectations passaram sem escrita de sessão.

## Nota geral: A

## Veredito: PASS — 0 críticos / 0 importantes / 0 sugestões

## Problemas críticos 🔴

Nenhum.

## Melhorias importantes 🟡

Nenhuma.

## Sugestões 🟢

Nenhuma.

## Verificação dos findings anteriores

- `ri_sign_class()`, `ri_envelopes()`, `ri_robustness()`, `ri_rule()` e `delta_ri()` usam `tolerance=0` por padrão.
- Uma diferença positiva de `1e-13` permanece `robust_positive`.
- Quando o usuário solicita `tolerance=1e-12`, a classificação aproximativa é explícita e registrada no objeto retornado.
- Tolerâncias negativas ou não finitas são rejeitadas.
- Cada elemento de uma lista de payoffs precisa ter exatamente duas coordenadas antes do `rbind`; não há mais reciclagem silenciosa.
- O teste de regressão verifica diretamente `list(c(1,2),3)` e o sinal estrito abaixo de tolerâncias convencionais.

## Pontos positivos ✓

- Produto cartesiano completo, sem convexificação.
- Preservação correta de conjuntos vazios.
- Existência separada de `RI_M` e `RI_U`.
- `DeltaRI` vazio somente quando necessário ao contraste.
- Envelopes e sinais calculados coordenada a coordenada.
- Imagens ex ante tratam corretamente os endpoints do prior.
- Nenhum payoff N6/N7 é importado.
- O modo `--no-write-session` foi efetivamente read-only: SHA-256 e mtime do arquivo de sessão permaneceram idênticos.

## Comando/teste executado

```text
Rscript --vanilla scripts/run_test_ri_estimand_functions.R --no-write-session
```

Resultado:

```text
ri-estimand-functions: .................................

== DONE ==
RI_ESTIMAND_SYNTHETIC_TESTS: PASS
Session info write skipped by --no-write-session.
```

Cobertura: 10 blocos, 33 expectations.

## Limitações

- A calculadora opera sobre conjuntos finitos de vetores de duas coordenadas.
- Trata-se somente de maquinaria sintética; o teste não deriva benchmark público, não abre N7 e não avalia resultados substantivos de N6.
- Os avisos de locale são ambientais e não afetaram os testes.

Nenhum arquivo foi criado, editado ou removido durante a rerevisão.

---

**Independência:** rerevisão produzida por agente separado, em modo estritamente read-only; nenhum arquivo foi alterado pelo revisor.
