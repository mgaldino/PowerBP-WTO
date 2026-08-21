# Parecer final A — Harness numérico N1–N4

## Resumo executivo

Os findings anteriores foram corrigidos. A rerevisão confirma comparações exatas nas fronteiras estruturais, suporte de Bayes correto para probabilidades positivas arbitrariamente pequenas e cobertura ampliada para 2.061 pontos por nó. Não encontrei regressões nem divergências em relação a N1–N4 congelados.

## Nota geral: A

## Veredito: PASS — 0 críticos / 0 importantes / 0 sugestões

## Problemas críticos 🔴

Nenhum.

## Melhorias importantes 🟡

Nenhuma.

## Sugestões 🟢

Nenhuma.

## Verificação dos findings anteriores

- `nu=0` agora usa igualdade exata; priors positivos como `1e-14`, `1e-12` e `5e-11` entram corretamente na célula interior de N4.
- Os cutoffs `nu_star`, `nu_SE`, `nu_SP` e `nu_EP` usam comparações exatas de célula.
- A posterior de Bayes é calculada sempre que a probabilidade da ação é estritamente positiva; a restrição de suporte só entra quando a probabilidade é exatamente zero.
- A tolerância numérica não participa mais da classificação de células, votos ou suporte.
- O grid inclui vizinhanças `1e-14`, `1e-12`, `1e-8` e `1e-7`, além de pontos muito próximos de `1/m`.
- O novo verificador dedicado cobre o endpoint N4, ambos os lados de `nu_star` e sinais informativos próximos de `nu=0` e `nu=1`.

## Pontos positivos ✓

- Os hashes congelados de N1–N4 permanecem exatos.
- Cada nó passou em 2.061 pontos.
- O CSV existente contém 8.244 observações, todas `PASS`.
- As onze células N3 e as três células N4 estão representadas.
- N4 inclui 882 pontos na região sem PBE puro, 66 endpoints `nu=0` e 1.113 pontos de prior alto.
- Nenhum payoff ou resultado N6/N7 é consumido.
- Execução determinística e caminhos relativos à raiz.
- Os avisos de locale são ambientais e não afetaram os resultados.

## Comandos/testes executados

```text
Rscript --vanilla scripts/verify_essential_input_n1_numeric.R
Rscript --vanilla scripts/verify_essential_input_n2_numeric.R
Rscript --vanilla scripts/verify_essential_input_n3_numeric.R
Rscript --vanilla scripts/verify_essential_input_n4_numeric.R
Rscript --vanilla scripts/verify_essential_input_numeric_boundaries.R
```

Resultados:

```text
N1_NUMERIC: PASS — 2061 linhas
N2_NUMERIC: PASS — 2061 linhas
N3_NUMERIC: PASS — 2061 linhas; onze células
N4_NUMERIC: PASS — 2061 linhas; três células
ESSENTIAL_INPUT_NUMERIC_BOUNDARIES: PASS
```

## Limitações

- A validação é numérica e finita, com `N∈{5,7}` e `beta∈{0.5,0.9,0.99}`; não substitui a prova congelada.
- O runner agregado não foi executado porque escreve outputs; os verificadores individuais e o teste de fronteiras são read-only.
- A revisão não abre nem deriva N7.

---

**Independência:** rerevisão produzida por agente separado, em modo estritamente read-only; nenhum arquivo foi alterado pelo revisor.
