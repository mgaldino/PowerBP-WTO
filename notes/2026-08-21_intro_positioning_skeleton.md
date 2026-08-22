# Esqueleto de posicionamento da introdução — benchmark primeiro

**Data:** 2026-08-21

**Natureza:** nota de posicionamento; não altera o manuscrito nem constitui resultado de N7.

**Estado da cadeia usado nesta nota:** N1–N6 congelados; N7 `pending/null`, não iniciado.

## Proveniência e limite inferencial

Esta nota desenvolve a arquitetura da avaliação histórica
`quality_reports/2026-08-21_honest_assessment_contribuicao_vs_literatura.md`,
lida no commit `e29a519` (blob Git
`d42fae0a57012dda14a20ec6b5ab69304fc380a1`; SHA-256
`2c1c3acae17b419838082b7682a1609ca5a491cbf1887982bff82a8497710cef`).
Esse arquivo não existe na base desta worktree (`8813303`) e, por decisão de
coordenação, não foi copiado, reconstruído, mesclado ou cherry-picked.

Também foram consultados, apenas como fontes bibliográficas externas à branch:

- `references/modelo_similar_geb.pdf`, SHA-256
  `c4558ecddec75a11f94f7dd61d22e6cccb8cfdc29eeaf9da4710a6eaa84968a6`;
- `references/modelo_similar_public_choice.pdf`, SHA-256
  `f265b0d43303dfe6b827ac36cfda3b31c099c9531d11593196d9f8c64641c636`.

As formulações abaixo tratam `DeltaRI` como estimando-alvo. Elas não antecipam
seu sinal nem promovem a projeção `o_1` versus `1/m` a resultado: isso requer o
benchmark público de N7, que permanece fechado.

## Sequência proposta

### 1. Benchmark: informação completa revela poder puro

Abrir com o resultado conhecido de que votos de veto e valores de desacordo
alteram poder distributivo mesmo sem assimetria informacional. Em barganha
legislativa com valores de desacordo conhecidos, um valor alto pode ser uma
vantagem sob unanimidade e uma desvantagem sob maioria se jogadores caros forem
substituíveis [@miller2018heterogeneous]. Situar esse benchmark junto da
literatura clássica sobre voto, veto e direitos de proposta
[@winter1996voting; @mccarty2000proposal]. A pergunta do paper começa depois
desse benchmark: quanto do diferencial institucional decorre de poder puro e
quanto é incremento gerado pela informação privada?

### 2. Crédito integral: regras mudam o preço de participantes informados

Apresentar Piazolo e Vanberg como o vizinho dinâmico mais próximo: no jogo
deles, rejeição tem valor de sinalização diferente sob maioria e unanimidade,
o que altera o preço de respondentes informados. Apresentar Glynia, Thum e
Xefteris como o vizinho estático: mesmo sem o canal dinâmico, a regra muda a
escolha entre uma oferta segura e uma aposta de preço baixo. Não reivindicar
como novidade que unanimidade torna informados mais caros, que exclusão limita
seu preço, nem o contraste entre oferta cara e `lowball`. Localizar essa agenda
mais ampla com [@tsai2009evaluation; @tsaiYang2010majoritarian;
@chenEraslan2013informational; @chenEraslan2014rhetoric; @ma2023efficiency].

### 3. Configuração distintiva: a regra liga ou desliga o único canal informado

Introduzir então a assimetria organizacional específica. Há um único ator
informado, `H`, e `m=N-1` Estados fracos não informados e substituíveis. Sob
maioria, a coalizão pode contornar `H`; sob unanimidade, `H` é essencial. Assim,
a regra não apenas muda o preço de votos informados: ela decide se algum voto
informado precisa integrar a coalizão. Esse contraste produz um benchmark de
maioria endogenamente livre da informação de `H`, sem atribuir poder de agenda
ao hegemon.

### 4. Objeto estimado: decompor poder e informação

Definir, em palavras, a renda informacional de cada regra como a diferença
entre as correspondências de payoff privado e público, mantendo as primitivas
fixas. `DeltaRI` é então a diferença entre essas diferenças. Essa decomposição
separa o ganho de unanimidade que já existiria sob informação completa do
incremento associado à informação privada. Enquanto N7 estiver `pending`, a
introdução pode apresentar essa decomposição como desenho e estimando, nunca
como resultado assinado.

### 5. Interpretação hegemônica e fronteira candidata

Explicar por que a opção de desacordo de `H` é externa à torta institucional:
excluir o hegemon não o pune para zero. A comparação candidata entre `o_1` e o
valor de um substituto fraco, `1/m`, oferece uma interpretação econômica de
hegemonia: o tipo forte seria caro demais para ser substituído nos mesmos termos.
Enquanto N7 não fechar, chamar `o_1=1/m` de fronteira candidata/projeção, não de
teorema de renda informacional.

## Parágrafo de conceito de solução

O contraste com Piazolo–Vanberg precisa ser explícito. O presente modelo busca
equilíbrios puros sob `no-signaling-what-you-don't-know`, consistência estrutural
das crenças, votação `as-if-pivotal` e `T^Y` na igualdade em valor esperado.
Piazolo–Vanberg usam crenças off-path do tipo D1, admitem mistura e selecionam
continuações preferidas pelo proponente. Portanto, a região sem PBE puro nesta
arquitetura é dependente do conceito e da restrição a estratégias puras; ela
pode ser interpretada como instabilidade do protocolo selecionado, mas não como
um teorema geral de inexistência nem como contradição com a existência obtida
sob o pacote deles.

## Parágrafo preventivo sobre agregação de informação

Feddersen e Pesendorfer estudam informação dispersa entre votantes e os efeitos
das regras sobre agregação estratégica dessa informação
[@feddersenPesendorfer1998convicting]. Aqui a fricção é diferente: um único
barganhador conhece sua própria opção de desacordo e pode obter renda porque a
regra o torna essencial. A comparação institucional opera pela composição da
coalizão e pelo preço de participação desse ator, não por um júri que agrega
sinais privados distribuídos.

## Claim de abertura, em versão calibrada ao estado da prova

> Regras de consenso podem transformar a informação privada de um ator
> essencial em poder distributivo mesmo quando esse ator não controla a agenda.
> O paper separa esse incremento informacional do poder que o veto já produziria
> sob informação completa e pergunta quando a maioria consegue desligar o canal
> ao substituir o único participante informado.

Essa formulação preserva a contribuição de desenho já disponível e não afirma
o sinal de `DeltaRI` antes de N7.
