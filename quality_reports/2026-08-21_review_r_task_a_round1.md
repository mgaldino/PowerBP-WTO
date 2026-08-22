# Parecer A — Harness numérico N1–N4

## Resumo executivo

Os quatro verificadores executam com sucesso em 638 pontos por nó e reproduzem todas as células previstas no grid. Entretanto, há uma incompatibilidade de fronteira entre o código e a partição matemática congelada: a tolerância numérica transforma intervalos estritamente positivos em igualdades exatas. O finding foi escalado imediatamente e nenhum arquivo foi alterado.

## Nota geral: C

## Veredito: FAIL — 1 crítico / 0 importantes / 0 sugestões

## Problemas críticos 🔴

1. **A tolerância altera células e até a existência de equilíbrio.**

   - `ei_tolerance <- 1e-10` é usada em decisões lógicas de célula.
   - Em `n4_closed_form()`, `nu <= ei_tolerance` recebe `N4-NU-ZERO/exists`. Logo, um prior admissível como `nu=5e-11` é tratado como zero, embora o N4 congelado determine `none` para todo `0<nu<=nu_star`.
   - `ei_support_restricted_posterior_candidates()` também trata `0<nu<=1e-10` como endpoint de suporte zero quando uma ação tem probabilidade positiva menor que a tolerância.
   - Em N2/N4, `nu <= nu_star + ei_tolerance` estende a célula inferior para uma faixa estritamente acima de `nu_star`; há efeito análogo nos cutoffs de N3 e nas comparações de `o_0,o_1` com `1/m`.
   - O grid não detecta o problema: seu menor prior interior explícito é `1e-8`, acima da tolerância.

Isso é um defeito do harness, não evidência contra a matemática congelada. Ainda assim, a saída do código diverge da partição exata em pontos admissíveis, impedindo PASS.

## Melhorias importantes 🟡

Nenhuma além do finding crítico.

## Sugestões 🟢

Nenhuma enquanto o finding estiver aberto.

## Pontos positivos ✓

- Os hashes SHA-256 das nove fontes congeladas são verificados antes de cada execução.
- N1–N4 permanecem desacoplados de N6/N7.
- Os quatro scripts passaram em 638 linhas cada.
- O CSV existente contém 2.552 resultados, todos `PASS`, e cobre:

  - N1: uma célula;
  - N2: duas células;
  - N3: todas as onze células;
  - N4: as três células.

- A enumeração N4 percorre os quatro perfis puros de voto de `H`.
- O diagnóstico da linha N3-105 documenta corretamente uma diferença de ponto flutuante de `1.11e-16`, sem finding matemático.
- Execução determinística; `set.seed()` não é necessário.
- Caminhos são resolvidos relativamente à raiz e `sessionInfo()` é preservado.

## Testes executados

```text
Rscript --vanilla scripts/verify_essential_input_n1_numeric.R
Rscript --vanilla scripts/verify_essential_input_n2_numeric.R
Rscript --vanilla scripts/verify_essential_input_n3_numeric.R
Rscript --vanilla scripts/verify_essential_input_n4_numeric.R
Rscript --vanilla scripts/diagnostics/diagnose_n3_numeric_row_105.R
```

Resultados:

```text
N1_NUMERIC: PASS — 638 linhas
N2_NUMERIC: PASS — 638 linhas
N3_NUMERIC: PASS — 638 linhas; onze células
N4_NUMERIC: PASS — 638 linhas; três células
Diagnóstico N3-105: diferença máxima 1.1102230246251565e-16
```

Também foram inspecionados read-only:

- os quatro JSONs congelados N1–N4;
- o contrato Gate 0;
- o CSV e os arquivos de sessão existentes;
- contagens por nó e célula;
- hashes dos outputs.

Os avisos de locale `C.UTF-8` são ambientais e não alteraram resultados.

## Limitações

- O runner agregado não foi executado porque reescreve CSV e `sessionInfo()`, incompatível com a revisão estritamente read-only.
- A execução confirma somente o grid implementado; não elimina o finding nas vizinhanças menores que a tolerância.
- O harness é verificação numérica de conformidade, não prova formal independente.

---

**Independência:** parecer produzido por agente separado, em modo estritamente read-only; nenhum arquivo foi alterado pelo revisor.
