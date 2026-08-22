# Parecer independente — gate final após reflow tipográfico

## Snapshot verificado

- Commit: `b5fdefb1f80090b8da893bf19e754915d557502a`
- SHA-256 de `formal_model_v6.Rmd`: `32b49f7503caac34cdf225f73d7e76ab60d1340937b095e3e611f009030f8744`
- SHA-256 de `formal_model_v6.pdf`: `85d24122008af9ad484a6df53679c3f455f75fb94fffc70aa9ccbd8ffb62fe17`
- Worktree limpa antes e depois da revisão.
- Revisão estritamente read-only: não editei, compilei, gerei artefatos ou fiz commit.

## Escopo e diff

A única alteração em `formal_model_v6.Rmd` desde o último PASS foi:

```tex
\enlargethispage{\baselineskip}
```

imediatamente após o título da Introdução. Não houve alteração em palavras,
fórmulas, referências, proposições, provas, tabelas, figuras ou marcadores
autorais.

A mudança modifica apenas a capacidade vertical daquela página e explica a
alteração do hash do PDF. Não muda numeração, conteúdo lógico ou significado
substantivo.

## Checagens

- O puzzle continua limitado às duas perguntas respondidas pelo jogo:
  - quando unanimidade favorece o hegemon relativamente à maioria;
  - quando essa diferença é informacional, descontado o componente presente com tipo público.
- A introdução continua declarando explicitamente que a pergunta de escolha institucional é apenas motivação e que o modelo mantém a regra fixa.
- Não surgiu claim de criação, adoção ou escolha endógena da regra.
- A decomposição público–privado permanece intacta.
- N1, N2, N3, N4, N6 e N7 continuam nos seis hashes congelados.
- Não há diff em `model_redesign/`.
- Vazios, multiplicidade, segmentos atômicos, envelopes e certificado de N4 permanecem inalterados.
- P1 e P2 continuam sendo os únicos marcadores autorais; P3 permanece ausente.
- A busca negativa não encontrou retorno de linguagem ou arquitetura proibida.
- `git diff --check` passou.

## Findings

### SUBSTANTIVE

Nenhum.

### TECHNICAL

Nenhum.

### ADVISORY

Nenhum.

## Veredicto

**PASS**

**Contagem S/T/A: 0/0/0**
