# Parecer independente — exposição, matemática apresentada e qualidade visual

## Snapshot verificado

- Commit: `829b25f774a90398e53fb8d339e133b1b26be9ad`
- SHA-256 do Rmd: `848f86094fa6074fe034a3fdec97c47a0e710df8b99562b817a8224cf6b015e8`
- SHA-256 do PDF: `133bf3238ad99493a4e74a573a2035a3756f4aa743906d8b2b0a298432835876`
- Worktree limpa antes e depois da auditoria.
- Hashes das interfaces N1–N7 coincidem com a matriz aprovada.
- As 29 páginas do PDF foram inspecionadas visualmente.
- Os quatro PNGs e PDFs finais e o manifesto foram conferidos.
- Nenhum arquivo foi editado, recompilado ou commitado.

## Escopo e checagens

Foram verificados:

- ordem autoral do abstract, introdução e resultados;
- intuição antes das proposições;
- qualificação dos resultados por tipo, região e classe de equilíbrio;
- definição de jogadores, ações, informação, timing, payoffs e símbolos;
- nota que equipara *consensus* e *unanimity*;
- remark imediatamente após a inexistência sobre o escopo restrito a estratégias puras;
- ausência da imagem ex ante pendente em P3;
- colocação e conteúdo de F1–F4 e da figura de sequência;
- coerência entre texto, figuras, fórmulas e correspondências congeladas;
- suficiência expositiva das provas;
- cortes, referências, placeholders, paginação e legibilidade;
- readability audit sem Pangram.

## Aspectos aprovados

A arquitetura substantiva da exposição está correta:

- O abstract começa pelo puzzle, passa por abordagem, mecanismo, achado condicionado e escopo; não usa símbolos.
- A introdução preserva o hook OPEC/OMC, apresenta o puzzle em três camadas e coloca o benchmark de informação completa imediatamente depois.
- O mecanismo é corretamente apresentado como insumo essencial versus substitutos não informados.
- Os resultados são qualificados por tipo, região e classe de equilíbrio; não há claim global de que unanimidade sempre beneficia o hegemon.
- Piazolo–Vanberg e Glynia–Thum–Xefteris recebem crédito antes da contribuição estreita.
- A ordem dos resultados é benchmark público, jogos privados, rendas, diferença das diferenças e interpretação.
- A nota *consensus* = *unanimity* aparece no primeiro uso.
- O remark sobre estratégias mistas aparece imediatamente após a proposição de inexistência e não afirma existência nem inexistência sob mistura.
- Não há faceta, cálculo ou proposição ex ante de P3.
- F2 está com o mecanismo/preços; F1 com a comparação privada; F3 com as rendas; F4 somente na Discussion; a sequência está junto do timing.
- As fórmulas centrais, os cutoffs, os vetores de payoff, os vazios, os segmentos coordenados e o exemplo numérico coincidem com N1–N7.
- As provas são suficientes para os claims migrados: identificam candidatos e comparações, preservam a atomicidade do segmento e apresentam o certificado completo dos quatro perfis puros na célula vazia.
- Não foram encontrados placeholders, referências indefinidas ou bibliografia cortada.

## Findings SUBSTANTIVE

Nenhum.

## Findings TECHNICAL

### T1. Figura de sequência cortada

Na página 6, o diagrama ultrapassa a margem direita. Os nós terminais de Round 2 aparecem truncados; um deles termina visualmente em “Weak proposer c…”. A figura não mostra integralmente a sequência que sua legenda promete.

Local: `formal_model_v6.Rmd`, linhas 205–230.

### T2. Migração das tabelas aprovada, mas incompleta

O manuscrito contém apenas a tabela de escopo e a tabela de notação. Não foram transportadas como tabelas numeradas e captionadas as quatro entregas previstas na Seção 7 da matriz:

- protocolo corrente de transições e payoffs;
- quatro jogos públicos;
- correspondências privadas;
- `RI_M`, `RI_U` e `DeltaRI`.

O conteúdo matemático aparece em prosa e arrays nas proposições, portanto não falta resultado novo. Falta cumprir a forma editorial explicitamente aprovada.

### T3. Falta intuição antes das Proposições 4.6 e 4.7

Antes da Proposição 4.6 há definições e rótulos de regiões, mas não a intuição econômica do resultado. A Proposição 4.7 vem imediatamente depois, também sem intuição prévia. A explicação dos sinais aparece somente após ambas, nas linhas 573–580.

Isso viola diretamente a ordem aprovada “intuição antes de cada proposition”. O conteúdo necessário já existe e pode ser reposicionado ou dividido sem produzir matemática nova.

### T4. Identificadores conflitantes nas figuras

As figuras incorporadas mantêm títulos internos “Figure F1”, “Figure F2”, “Figure F3” e “Figure F4”, enquanto o manuscrito as numera, respectivamente, como Figuras 3, 2, 4 e 5. O leitor vê dois identificadores diferentes para a mesma figura, e as referências do texto usam apenas a numeração do artigo.

Como F2 precede F1 editorialmente, os prefixos internos não podem funcionar como numeração sequencial do manuscrito. Devem ser retirados ou substituídos por títulos sem identificador.

### T5. Linha órfã da conclusão

A página 20 contém somente a última linha da conclusão, seguida de uma página quase inteiramente vazia; o apêndice começa na página 21. É um defeito material de paginação, não uma preferência estilística.

## Findings ADVISORY

Nenhum.

## Veredicto

FAIL

**Contagem S/T/A: 0/5/0.**

O snapshot não satisfaz o gate `PASS 0/0/0`. Os cinco findings são técnicos e não indicam erro nos resultados congelados nem necessidade de decisão substantiva nova.
