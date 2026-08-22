# Goal 5 — candidato de migração para o manuscrito

**Data:** 2026-08-22
**Status:** PENDING INDEPENDENT REVIEW
**Branch:** codex/essential-input-goal5-migration-matrix
**Checkpoint anterior à edição:**
3e8f1d06e4f23546eea3bb7f54dc22b08471b48f
**Fronteira preservada:** tag anotada
pre-goal5-essential-input-2026-08-21, após peeling em
e0ff1aceb3d8b9ebeeea56feb65c019dafd32854

## 1. Conteúdo transportado

O arquivo formal_model_v6.Rmd foi reescrito dentro do alvo aprovado,
preservando título, YAML/bookdown e tipografia. A arquitetura substantiva
anterior foi substituída pelo jogo essential-input congelado.

A ordem editorial implementada é:

1. abstract puzzle-primeiro;
2. introdução com hook OPEC/OMC, puzzle, benchmark público, mecanismo,
   resultados qualificados, literatura e roadmap;
3. resultados na ordem benchmark público, jogos privados, comparação privada,
   rendas e diferença das diferenças;
4. Discussion e limites;
5. provas, endpoints, conjuntos exatos, exemplo e notação no apêndice.

Os marcadores [AUTHOR: P1] e [AUTHOR: P2] permanecem apenas nas frases
interpretativas autorizadas. A imagem ex ante de P3 não entrou no manuscrito
nem nas figuras finais.

## 2. Fontes congeladas

| Nó | SHA-256 verificado |
|---|---|
| N1 | 1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5 |
| N2 | c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2 |
| N3 | ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d |
| N4 | f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b |
| N6 | a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92 |
| N7 | 4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45 |

Nenhum desses artefatos, o DAG ou seus verificadores foi editado.

## 3. Artefatos candidatos

| Artefato | SHA-256 |
|---|---|
| formal_model_v6.Rmd | 848f86094fa6074fe034a3fdec97c47a0e710df8b99562b817a8224cf6b015e8 |
| formal_model_v6.pdf | 133bf3238ad99493a4e74a573a2035a3756f4aa743906d8b2b0a298432835876 |
| references.bib | a87aac22667c6d22c707308f8d6072900b4051498a0975d93803f9147d736db4 |
| gerador de figuras | 5fbfdb82f5588d74f1a0bb647ea8fea367475acb5f22612e49a273ddc6e9efed |
| funções de figuras | 007650974ac39b4b0da37f2a537c3b1457d4b15684e095432d6210eaace28a26 |

As figuras permanentes estão em figures/essential_input/, com PDF, PNG, CSV
e manifesto. F1 contém somente as duas coordenadas de tipo; F2 mostra preços e
anatomia de coalizão; F3 usa valores reais de N7 no exemplo; F4 usa a
formulação neutra “no pure-strategy PBE”.

## 4. Validação executada

- Rscript --vanilla scripts/verify_essential_input_gate0.R: PASS;
- verificador N1: PASS no hash congelado;
- verificador N2: PASS no hash congelado;
- verificador dirigido N3/N4: PASS, incluindo quatro perfis puros;
- verificador N6: PASS, inclusive atomicidade e célula vazia;
- verificador N7: PASS, inclusive equivalência de endpoints e sinais;
- gerador de figuras: PASS nos hashes N6 e N7;
- busca negativa no Rmd: zero ocorrências da arquitetura e dos rótulos
  proibidos;
- git diff --check: PASS;
- compilação exclusiva por rmarkdown::render("formal_model_v6.Rmd"): PASS;
- PDF final: 29 páginas, zero referência indefinida e inspeção visual de todas
  as páginas;
- readability audit: executado sem Pangram e salvo separadamente.

O verificador congelado de Gate 0 ainda imprime que Goal 5 não estava
autorizado. Essa frase pertence ao snapshot anterior à decisão autoral e não
foi editada. A autorização posterior está registrada em
quality_reports/2026-08-22_aprovacao_matriz_goal5.md.

## 5. Fronteira de parada

Este candidato ainda não está aprovado nem etiquetado. Ele requer dois
pareceres independentes, read-only e sobre o mesmo snapshot: desenho/fidelidade
formal e exposição/qualidade visual. Qualquer alteração posterior cria novo
hash e exige os dois pareceres novamente. Não houve push e nenhuma tag final
foi criada.
