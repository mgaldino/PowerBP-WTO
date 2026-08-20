# Finding de arquitetura de certificação semântica — N3/N4

**Data:** 2026-08-20
**Status:** `BLOCKING — AUTHOR DECISION REQUIRED`
**Escopo:** somente a certificação executável de N3 e, por implicação direta, N4

## 1. Gatilho

O candidato N3 v5 permaneceu byte a byte em:

```text
b30c63ac1afd29d7b1af64e9a8734270feea94bced2c8ec7e3c3bf2a94f405cb
```

Exatamente dois revisores independentes, read-only, examinaram esse mesmo hash:

| Papel | Veredicto | Findings |
|---|---|---|
| `game_theory` | FAIL | `0 critical / 1 major / 1 minor / 0 epistemic` |
| `formal_design` | FAIL | `0 critical / 0 major / 0 minor / 1 epistemic` |

Ambos confirmaram integralmente a matemática das onze células, payoffs, crenças, endpoints, tie-break e multiplicidade. Ambos também concluíram que o verifier ainda superestima sua cobertura semântica: visita todas as folhas, mas não compara cada fórmula ou claim com uma expectativa matemática independente.

As evidências convergentes incluem coeficientes alterados, termos que zeram somente nos fixtures numéricos e contradições textuais que preservam os tokens esperados e ainda recebem falso PASS.

## 2. Por que a execução deve parar

O contrato exige escalada quando mais de um reparo plausível permanece. Aqui há pelo menos três arquiteturas distintas:

1. companion tipado separado, com AST e certificados;
2. DSL canônica dentro dos campos string do schema corrente;
3. redução explícita da alegação automatizada, mantendo a prova semântica em revisão humana.

As três preservam primitivas, jogo e payoffs, mas diferem na representação normativa, nos consumidores e no significado do PASS. Nenhuma delas é forçada unicamente pelo texto atual. Portanto, escolher silenciosamente violaria §11.1.

## 3. Opções autorais

### Opção A — companion tipado, preservando a interface pública — recomendada

- Manter `equilibrium_correspondence_v1` e a representação pública legível de N3/N4.
- Criar um companion derivado, machine-readable e hashado, com ASTs tipadas, formas canônicas e certificados por claim.
- Ligar o companion no ledger e no relatório, sem torná-lo nova primitiva, novo payoff ou dependência substantiva do jogo.
- Fazer o kernel independente derivar as expectativas somente das primitivas e da dependência congelada; ele não pode consumir builder, candidato esperado ou manifesto como prova.
- Analisar integralmente as strings matemáticas do candidato e compará-las por equivalência simbólica exata.
- Tratar prosa livre como evidência legível submetida a revisão humana; nunca contabilizá-la como “semanticamente provada” apenas por tokens.
- Aplicar a mesma arquitetura a N3 e N4 para evitar dois padrões de PASS.

**Consequência:** preserva schema e consumidores; acrescenta um artefato de certificação, não uma interface de jogo. N3 e N4 continuam dependendo somente de N1 e N2, respectivamente.

### Opção B — DSL canônica dentro das strings existentes

- Manter os nomes de campos e o schema, mas substituir conteúdo material por uma linguagem formal canônica.
- Exigir parse integral, tipos, normal form e certificados dentro da própria interface.
- Manter a derivação separada como camada legível.

**Consequência:** não cria campo novo, mas altera materialmente a representação pública e pode exigir adaptação dos consumidores N6/N7.

### Opção C — reduzir a alegação do verifier

- Rotular o resultado como cobertura estrutural integral com validação semântica parcial.
- Confiar a correção matemática aos dois pareceres independentes e a testes numéricos/algebraicos direcionados.

**Consequência:** é a opção menos invasiva, mas não satisfaz a autorização anterior de comparação semântica integral e oracle algébrico independente sem uma dispensa autoral explícita.

## 4. Recomendação

Autorizar a **Opção A para N3 e N4**, com quatro limites expressos:

1. o companion é certificação derivada, não primitiva nem nova dependência do jogo;
2. `equilibrium_correspondence_v1` permanece inalterado;
3. N6/N7 consomem as interfaces congeladas, não o companion como fonte substantiva;
4. todo novo pacote de certificação volta aos mesmos dois papéis read-only e só recebe PASS com `0/0/0/0` no mesmo hash do candidato.

## 5. Estado de N4 na parada

Os dois pareceres N4 v3 também estão completos no hash:

```text
6c199f961ba2b8e1f55719c8d678decf752fb7bcda042bf796a585f2a4278905
```

Eles confirmaram quase toda a matemática, mas exigiram a correção única dos múltiplos vetos on-path:

```text
m>=3 e pelo menos dois vetos weak:
  nu<nu_star  -> apenas factibilidade;
  nu>=nu_star -> x_k<=B para todo weak k que veta.
```

`S_3=(1-nu)B` permanece válido. A rederivação fria v4 confirmou necessidade e suficiência dessa condição, mas foi interrompida antes de publicar candidato. Quatro arquivos intermediários permanecem não rastreados no worktree; seus hashes são snapshots de interrupção, não artefatos selados ou consumíveis:

```text
a2f44b0ba0bdc1658406489be0605ffbb626d023ed0abb478530b96cec56e4c7  model_redesign/essential_input_n4_r1_unanimity_cold_notes_v4.md
84570652b9215625da553153b27aaf176d309a124f80dbbca67e82a07ecc3f6b  model_redesign/essential_input_n4_r1_unanimity_derivation_v4.md
143aaab2dfa5a7bd029182af1a041ef44846c57d9c517dbb0cad690d33a1fce8  scripts/build_essential_input_n4_v4.R
0df08dd8adbaca480aab6f0d537322502ef39c18c140509907c17109b627d810  scripts/oracle_essential_input_n4_v4.R
```

Não existe candidato N4 v4. Esses arquivos não devem ser revisados, consumidos ou promovidos antes da decisão autoral.

## 6. Fronteiras preservadas

- N1 e N2 permanecem `pass/frozen` e byte-idênticos.
- N3, N4, N6 e N7 permanecem `pending/unfrozen`.
- Fase A e a tag protegida permanecem intactas.
- Nenhum PDF foi gerado.
- Goal 5, manuscrito, figuras e `beta=1` permanecem não autorizados.
