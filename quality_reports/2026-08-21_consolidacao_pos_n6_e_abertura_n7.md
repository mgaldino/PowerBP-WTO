# Consolidação pós-N6 e abertura autorizada de N7

**Data:** 2026-08-21

**Natureza:** registro administrativo e de proveniência; não é artefato matemático

**Escopo:** consolidar a linhagem congelada N1–N6, a infraestrutura paralela de apoio e a documentação autoral; registrar a abertura autorizada de N7 sem antecipar seus resultados

## 1. Linhagens consolidadas

A consolidação foi construída em
`/private/tmp/PowerBayesianPersuasion-post-n6-consolidation`, branch
`codex/essential-input-post-n6-consolidation`, preservando as duas histórias
Git relevantes:

- checkpoint matemático de N6: commit
  `8813303ac37be6d5ac9f3da822c0855d34e9e349`, mensagem
  `Freeze N6 private-information comparison`;
- infraestrutura paralela A–D, construída sobre esse checkpoint: commit
  `1e84279bffd5da1af2aadd95f7edda4356cb7c87`, mensagem
  `Add essential-input support harness and positioning notes`;
- documentação autoral da checkout principal: commit
  `e29a51983de7ed65936195470a1d739d44ae0355`, mensagem
  `chore: codex checkpoint (session-stop)`.

Não foi feito cherry-pick cego entre linhagens divergentes. A consolidação usa
um merge com dois pais, de modo que a proveniência matemática e a documental
permaneçam recuperáveis no histórico.

## 2. Resolução dos quatro conflitos documentais

O merge produziu somente quatro conflitos esperados:

1. `AGENTS.md`;
2. `CLAUDE.md`;
3. `quality_reports/2026-08-21_conversa_decisao_conceito_solucao.md`;
4. `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`.

Nos dois arquivos de instruções foram preservados tanto a Emenda 1a sobre
restrição de suporte nos endpoints quanto o estado administrativo corrente. No
registro da conversa foi mantido o adendo autoral sobre endpoints e disciplina
de citação.

O registro da decisão exigiu uma resolução mais restrita. Esse arquivo integra
o manifesto final congelado de N6. A tentativa de combinar material documental
adicional alterou seus bytes e fez o manifesto falhar. Como nenhum conteúdo
matemático ou autorização substantiva admitia uma escolha discricionária, o
único reparo técnico forçado foi restaurar exatamente a versão pinada por N6,
SHA-256
`94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69`.
O conteúdo alternativo continua recuperável no segundo pai Git e a autorização
de N6 permanece registrada em arquivo próprio.

A variante `e29a519` contém ainda a seção “Nota autoral registrada para o Goal
5 — interpretação qualitativa da inexistência”. Ela é uma hipótese para a
Discussion, nunca um teorema; seu texto integral permanece recuperável em
`e29a519:quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`.
Essa nota fica fora de N7 e não autoriza Goal 5.

O arquivo
`quality_reports/2026-08-21_honest_assessment_contribuicao_vs_literatura.md`,
presente apenas na linhagem documental, foi incorporado sem conflito.

## 3. Estado matemático preservado

Após a consolidação:

- N1, N2, N3, N4 e N6 permanecem `pass/frozen`;
- N2 continua sendo consumido com a errata da Emenda 1a, sem edição de sua
  interface congelada;
- N6 permanece congelado com interface SHA-256
  `a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92`;
- os pareceres `formal_design` e `game_theory` de N6 permanecem `PASS 0/0/0`
  sobre o mesmo hash;
- o DAG congelado de N6 permanece no SHA-256
  `c7ceac8552599b19147742fe7f31edd636f44d563cd72f63ece86665489034c3`;
- nenhum artefato matemático congelado de N1–N6 foi rederivado ou editado;
- nenhum manuscrito foi editado ou compilado.

O manifesto final de integração de N6 foi reexecutado e confirmou todas as 18
entradas antes do fechamento deste merge.

## 4. Infraestrutura paralela de apoio

O commit `1e84279...` acrescenta infraestrutura auxiliar, não normativa:

- harness numérico N1–N4, com 8.244 de 8.244 linhas aprovadas e testes dirigidos
  de fronteira;
- calculadora genérica de estimandos de renda informacional, testada apenas com
  fixtures sintéticas: 10 blocos e 33 expectativas aprovadas;
- três PDFs permanentes de rascunho, acompanhados dos respectivos CSVs;
- notas de posicionamento e exemplo motivador;
- nove referências bibliográficas verificadas;
- dois ciclos independentes de `review-r` para o harness e para a calculadora,
  com parecer final `PASS 0/0/0` em cada tarefa;
- revisão visual independente dos PDFs de rascunho.

Essa infraestrutura não abriu N7 e não contém resultados reais de renda
informacional. Seus findings iniciais foram de implementação — tolerâncias que
alteravam classificação/sinal e validação insuficiente de vetores —, foram
corrigidos e rerevisados. A execução também documenta um probe isolado com
`Rscript -e`, um empate de ponto flutuante, uma chamada com nome de script
incorreto e a restauração imediata de renders rastreados removidos antes do
staging. Nenhum desses incidentes alterou artefatos congelados.

O script histórico `scripts/verify_essential_input_n3.R` permanece obsoleto e
intocado; a validação corrente de N3/N4 é feita pelo verificador conjunto
congelado.

## 5. Abertura de N7

O autor autorizou explicitamente em 2026-08-21 o Goal 4, limitado a N7:
benchmark público terminal e rendas informacionais. A implementação foi lançada
em task própria:

- task: `01a026c4-b7b3-7763-8d2d-596ea7bcd722`;
- worktree exclusiva:
  `/private/tmp/PowerBayesianPersuasion-essential-input-n7-fresh`;
- branch: `codex/essential-input-goal4-n7-fresh`;
- baseline obrigatório: commit
  `8813303ac37be6d5ac9f3da822c0855d34e9e349`;
- modelo: GPT-5.6 Sol, esforço `ultra`.

N7 foi deliberadamente iniciado do checkpoint congelado de N6, e não desta
branch de consolidação, para impedir que o harness ou a calculadora auxiliar
contaminem a derivação. A task foi instruída a não ler nem comparar qualquer
output da worktree/branch paralela de tooling e a não consultar antigas
worktrees de N7.

## 6. Próxima fronteira e parada

N7 deve:

1. resolver independentemente os quatro jogos públicos terminais;
2. provar a equivalência com os endpoints privados congelados;
3. calcular os conjuntos exatos de renda informacional e a diferença das
   diferenças, preservando vazios e multiplicidade;
4. produzir a interface terminal e sua cobertura exaustiva;
5. receber dois pareceres independentes, read-only, `PASS 0/0/0` sobre o mesmo
   hash;
6. somente então ser congelado administrativamente.

Mesmo depois do freeze, o Goal 4 não fecha automaticamente: exige aval
explícito posterior do autor. Goal 5, migração para manuscrito, push e tag
continuam fora do escopo.
