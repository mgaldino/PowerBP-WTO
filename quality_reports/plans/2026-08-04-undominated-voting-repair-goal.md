# Goal 3 — Correção da disciplina de voto sob ballot simultâneo

**Data:** 2026-08-04

**Status inicial:** autorizado por GO explícito; execução em andamento

**Addendum substantivo durante a rerevisão:** o usuário determinou que o
baseline retenha coalizões vencedoras mínimas e não pague países fora da
coalizão. A rederivação deve distinguir PBE-UD irrestrita da seleção
coalition-pure, manter propostas com gifts como desvios factíveis e não impor
voto sim quando um membro recebe exatamente seu valor de continuação.

**Tag de entrada:** `pre-undominated-voting-repair-2026-08-04`

**Commit protegido de referência:** `8692a6b31539d117134a580009d4e4dbe783403d`

## Objetivo

Rederivar o baseline limpo `pi_H=0` sob o objeto de solução **PBE acrescido de
admissibilidade de voto fracamente não dominado em cada ballot**, sem editar ou
recompilar o manuscrito v6. O produto final deste Goal é uma arquitetura formal
autônoma, verificadores reproduzíveis, pareceres independentes e uma matriz de
impacto pronta para orientar um Goal 4 de migração.

## Restrição decisiva de protocolo

Não há votação pública ou sequencial durante um ballot. Todos os não
proponentes votam simultaneamente, sem observar os votos alheios, e não existe
ordem de votação de `H`. O proponente é contado como voto sim. Somente depois do
fechamento o vetor completo e o resultado tornam-se públicos e podem integrar a
história da rodada seguinte.

Baron–Ferejohn é fonte para a motivação da eliminação de votos fracamente
dominados, não para o protocolo roll-call do artigo. Nenhum resultado poderá
depender da posição de `H` em uma ordem de votação inexistente.

## Artefatos imutáveis

Permanecem byte a byte iguais ao snapshot de entrada:

- `formal_model_v6.Rmd`;
- `formal_model_v6.pdf`;
- `formal_model_v5.Rmd`;
- `model_redesign/power_architecture_derivations.Rmd`;
- planos, matrizes, relatórios e pareceres encerrados dos Goals 1 e 2.

Hashes de entrada:

```text
formal_model_v6.Rmd
131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d

formal_model_v6.pdf
a7d36d5a1fb2d15ba0e40509ad846fbf001b5960232fcbf011d5b32bec298bdf

model_redesign/power_architecture_derivations.Rmd
8fbb7edff59fb0dc6fb36571564ec94d26e66b1211496ed10e9d9191ef2f68c6
```

## Primitivos preservados

- `pi_H=0` em todas as rodadas;
- `b_theta=0`;
- payoff corrente de `H` em acordo que o inclui igual a `y`;
- voto não de `H` em R1 produz opt-out imediato, irreversível e sem desconto
  `o_theta`;
- ballot simultâneo e selado até o fechamento;
- opção externa de `H` fora do bolo institucional;
- weak-vote-passive assessment apenas como disciplina de crenças;
- entry dos fracos coletiva e all-or-nothing;
- comparação institucional somente no domínio comum de existência.

Não são primitivos: voto como se pivotal, seleção sim na indiferença, redução
P/L/R, `F_M`, `[F_M,1]`, No-Cheap-H, delayed continuation,
hybrid exit, `t_theta`, `pi_H>0`, trembling-hand, coalition-proofness, escolha
endógena da regra ou qualquer ordem de votação.

A coalizão mínima não é presumida como consequência de PBE puro: ela entra,
após a decisão posterior do usuário, como seleção coalition-pure explicitamente
reportada ao lado da correspondência irrestrita.

## Objeto de solução e Gate 0

Antes da indução retroativa, o Gate 0 deve:

1. definir o jogo local de votação em cada conjunto de informação;
2. comparar sim e não contra todos os perfis factíveis dos demais votos;
3. incluir estados, tipos e ações compatíveis com a informação do jogador;
4. registrar, para cada ação, implementação, opt-out e continuação induzida
   pelo vetor público ex post;
5. definir dominância em jogos bayesianos sem dividir IC por probabilidade de
   pivotalidade;
6. separar admissibilidade por dominância de racionalidade sequencial de PBE;
7. derivar, e não presumir, qualquer redução a uma continuação escalar;
8. tratar a igualdade como correspondência antes das sensibilidades sim, não e
   mistura;
9. auditar `H` separadamente dos fracos;
10. marcar `pending protocol decision` e interromper a derivação afetada se um
    novo primitivo substantivo for necessário.

## Sequência de execução

### Fase A — Governança e erratum

- registrar Gate −1, tag, hashes e congelamento;
- produzir erratum pós-fechamento sem alterar os PASS anteriores;
- inventariar dependências da antiga disciplina de voto.

### Fase B — Gate 0

- formalizar dominância fraca local no ballot simultâneo;
- provar os lemas gerais de admissibilidade para fracos e para `H`;
- mapear knife-edges e seleções de indiferença;
- obter auditoria independente do Gate 0 antes de promover resultados.

### Fase C — Indução retroativa

- rederivar R2 sob unanimidade e maioria;
- rederivar continuações de R1 por vetor público;
- rederivar unanimidade e maioria sem impor coalizão mínima;
- classificar pooling, low-only, rejeição e separação apenas quando emergirem;
- tratar `N=3`, `N=4`, `N>=5`, além do diagnóstico `N=5, q=3`;
- identificar existência pura, mistura, multiplicidade e regiões vazias.

### Fase D — Entry e comparação institucional

- rederivar entry coletiva, formação, payoffs e bounds de `H`;
- comparar regras apenas no domínio comum no qual os objetos existem;
- registrar resultados negativos sem hipóteses de resgate.

### Fase E — Verificação reproduzível

- manter toda computação em scripts R novos `verify_undominated_voting_*.R`;
- enumerar ballots finitos para testes de regressão e contraexemplos;
- verificar condições simbólicas/fatorações quando possível;
- gerar outputs próprios com fonte, parâmetros e status;
- compilar apenas `model_redesign/undominated_voting_rederivation.Rmd`.

### Fase F — Impacto e revisão

- mapear cada definição, resultado, tabela, figura, caption e claim relevante do
  v6;
- usar exclusivamente as classificações finais: `sobrevive sem alteração`,
  `sobrevive com reescrita`, `precisa de nova prova`, `deve ser removido do
  baseline`;
- commitar a versão candidata;
- obter três pareceres independentes, somente leitura e com commit/hashes:
  BF/formal, teoria dos jogos adversarial e R/reprodutibilidade/PDF;
- reparar pelo implementador e rerevisar até três PASS sem ressalva substantiva.

### Fase G — Fechamento

- produzir status integral e handoff do Goal 4;
- comprovar hashes e ausência de diff dos arquivos protegidos;
- executar todos os verificadores, `git diff --check` e auditoria do PDF;
- deixar worktree limpa, sem push.

## Convenção de status formal

Cada item da nova derivação será marcado como `proved`, `checked numerically`,
`conjecture`, `pending` ou `rejected`. Enumeração e simulação nunca substituem
prova geral.

## Definition of Done

O Goal fecha apenas com Gate 0 completo, R2/R1 rederivados sob ambas as regras,
existência e multiplicidade classificadas, entry e comparação institucional
rederivadas, matriz de impacto sem pendência substantiva, scripts passando, PDF
autônomo validado, três PASS independentes, hashes protegidos preservados e
handoff explícito para o Goal 4. Nenhuma migração ao v6 pertence a este Goal.
