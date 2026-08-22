# Parecer independente — correção autoral do puzzle

## Snapshot verificado

- Commit: `6d0725f7770fa164f772e5979877d9e1a648efae`
- SHA-256 de `formal_model_v6.Rmd`: `61c309c5a24bd93c72b42136d5ea637c56a714b91393b04cfaf21c6831abceb1`
- SHA-256 de `formal_model_v6.pdf`: `5a29b0de02249ce80911555cd377ceae9d96afcdd4fe9371847a0d4b09f193b4`
- Worktree limpa antes e depois da auditoria.
- Interfaces N1–N7 intactas nos seis hashes congelados.
- Nenhum arquivo em `model_redesign/` foi alterado.
- Revisão estritamente read-only: não editei, compilei, gerei artefatos ou fiz commit.

## Escopo

Auditei integralmente o manuscrito e confrontei a mudança com a matriz aprovada,
o conceito de solução, as interfaces congeladas e os pareceres anteriores. O
foco foi:

- correspondência entre o puzzle e aquilo que o jogo endogeniza;
- ausência de inferência sobre criação, escolha ou adoção da regra;
- decomposição entre diferença institucional sob informação pública e componente informacional;
- preservação de todas as proposições, provas, tabelas, figuras e resultados N1–N7;
- disciplina de escopo, P1/P2/P3 e busca negativa.

## Checagens aprovadas

### Puzzle e fronteira explicativa

O abstract agora formula duas perguntas efetivamente respondidas pelo modelo:

1. quando o payoff do hegemon sob unanimidade supera seu payoff sob maioria, mantendo primitivas e parâmetros constantes;
2. quanto dessa diferença decorre da informação privada, depois de descontada a diferença existente quando o tipo é público.

A primeira pergunta corresponde à comparação privada congelada em N6. A
segunda corresponde a `DeltaRI` em N7. Logo, o puzzle agora coincide com os
estimandos formais do artigo.

### Escolha institucional

A introdução mantém criação e adoção institucional apenas como motivação
histórica. Ela declara imediatamente que essa pergunta mais ampla excede o
modelo e que a regra é mantida fixa.

O manuscrito não afirma que o jogo:

- explica por que organizações são criadas;
- endogeniza a escolha entre maioria e unanimidade;
- demonstra por que um hegemon adota ou insiste em consenso;
- caracteriza um equilíbrio de seleção institucional.

A seção de limites continua dizendo expressamente que escolha endógena da regra não é analisada.

### Decomposição público–privado

A nova abertura é coerente com a identidade usada no artigo:

- a comparação pública identifica o componente institucional existente com tipos conhecidos;
- `RI_M` e `RI_U` medem o efeito da informação privada dentro de cada regra;
- `DeltaRI = RI_U - RI_M` mede quanto a informação privada acrescenta diferencialmente à unanimidade.

O abstract distingue corretamente a vantagem total da unanimidade do contraste
especificamente informacional. Os resultados permanecem qualificados por tipo,
classe de equilíbrio e região paramétrica.

### Integridade da cadeia formal

- O diff substantivo do Rmd está limitado ao abstract e ao enquadramento inicial da introdução.
- Nenhuma definição, fórmula, fronteira, correspondência, prova, figura ou tabela foi modificada.
- N1–N4, o certificado de inexistência de N4, N6 e N7 permanecem idênticos ao snapshot anteriormente aprovado.
- Vazios, multiplicidade, segmentos atômicos e envelopes permanecem preservados.
- Não houve feedback do novo enquadramento para os resultados congelados.
- P1 e P2 continuam somente nos marcadores autorizados; P3 permanece ausente.
- A busca negativa não encontrou linguagem que atribua ao modelo criação, adoção ou escolha endógena da regra.

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
