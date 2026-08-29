# Memória para retomar a extensão de agenda sob maioria

**Data:** 2026-08-29  
**Finalidade:** explicar para o autor, inclusive depois de muito tempo sem
trabalhar no projeto, o resultado da investigação sobre o estágio em que o
hegemon faz a proposta sob maioria, as escolhas que ficaram abertas e a
recomendação de encaminhamento.  
**Estatuto:** memória explicativa de um resultado exploratório. Não é aprovação
matemática, congelamento, alteração do contrato ou autorização para a etapa
seguinte.

## Resumo em uma frase

Encontramos vários equilíbrios explícitos sob regras específicas e válidas de
continuação, mas provamos que **não é possível classificar de forma informativa
todos os equilíbrios permitidos pelo contrato atual**: a liberdade de escolher
o que acontece depois de cada proposta rejeitada é tão grande que pode fazer o
hegemon não ter uma melhor proposta, nem mesmo quando ele pode sortear entre
propostas.

## 1. O problema que estávamos tentando resolver

A extensão acrescenta ao modelo o caso em que o hegemon `H` recebe o direito de
fazer a proposta. Sob maioria:

1. `H` é obrigado a propor uma divisão do bolo; não pode passar a vez;
2. a proposta especifica quanto `H` conserva e quanto cada Estado fraco recebe;
3. a proposta de `H` já conta como um voto favorável;
4. cada Estado fraco decide seu voto comparando apenas o que receberia com a
   proposta e o que receberia se ela fosse rejeitada;
5. se a proposta for rejeitada, começa a continuação do jogo de maioria que já
   havia sido resolvida anteriormente, com o desconto temporal aplicado uma
   única vez.

O objetivo era mais ambicioso do que simplesmente exibir alguns exemplos.
Queríamos caracterizar:

- todos os equilíbrios em estratégias puras (`AMX-014`);
- todos os equilíbrios com mistura ou semiseparação (`AMX-015`);
- o conjunto conjunto exato de resultados e payoffs (`AMX-016`).

Esses nomes são apenas identificadores de controle do projeto. A questão
substantiva era: **podemos descrever todas as maneiras pelas quais o estágio de
proposta do hegemon pode terminar em equilíbrio sob maioria?**

## 2. Por que a continuação depois da rejeição se tornou decisiva

O estágio que começa depois de uma rejeição não tem necessariamente um único
equilíbrio. O objeto chamado `C_M` contém vários equilíbrios possíveis da
continuação sob maioria.

Por isso, para resolver o estágio anterior, é preciso dizer qual membro de
`C_M` será usado depois de cada história. A regra que faz essa escolha recebeu
o nome técnico `kappa_M`. Em termos comuns, ela responde:

> Se esta proposta específica for rejeitada, qual dos equilíbrios válidos da
> continuação será jogado?

O contrato vigente permite que essa escolha dependa da história e da proposta,
desde que a regra seja mensurável. Isso parecia uma maneira cuidadosa de não
esconder a multiplicidade da continuação. O problema descoberto é que essa
liberdade também permite mudanças extremamente bruscas: duas propostas quase
idênticas podem ser seguidas por continuações muito diferentes.

Essa diferença altera quanto cada Estado fraco exige para votar a favor. Assim,
a própria proposta muda o preço dos votos que ela precisa comprar.

## 3. O que conseguimos construir positivamente

Usando uma continuação cíclica e balanceada, que é um membro literal e válido
de `C_M`, foram construídos exemplos explícitos de:

- pooling com acordo imediato;
- separação com acordo dos dois tipos de hegemon;
- separação com acordo do tipo baixo e atraso do tipo alto;
- pooling e separação com atraso dos dois tipos;
- semipooling, no qual o tipo alto mistura entre acordo e atraso;
- misturas nas fronteiras de indiferença.

Também obtivemos limites rigorosos para os payoffs e uma descrição exata dos
preços dos votos quando a regra de continuação já está fixada.

Esses resultados continuam úteis. Eles mostram que os tipos de equilíbrio
acima realmente podem existir e explicam seus incentivos. Mas são **famílias de
equilíbrios testemunhadas**, não uma lista completa de tudo que o contrato
permite.

A derivação e as condições paramétricas estão no
[relatório formal de resultados](../model_redesign/agenda_extension_A_M_explicit_majority_results.md),
especialmente nas Seções 2 a 6.

## 4. O contraexemplo que impede a classificação geral

O resultado decisivo usa uma instância pequena:

```text
N = 5 jogadores no total
m = 4 Estados fracos
k = 2 votos fracos necessários
beta = 0,9
o_0 = 0,30
o_1 = 0,40
```

Foram construídos dois membros perfeitamente válidos da continuação `C_M`:
um torna relativamente baratos os votos necessários; o outro os torna mais
caros. A regra de continuação escolhe o membro barato somente para a sequência
de propostas

```text
s_n = (0,51 - 0,01/n; 0,24; 0,24; 0; 0),  n = 1, 2, ...
```

Nessas propostas, os dois Estados fracos pagos votam a favor e `H` recebe

```text
0,51 - 0,01/n.
```

Esse valor se aproxima de `0,51`, mas nunca chega a `0,51`. Fora dessa
sequência, a continuação cara faz com que qualquer acordo deixe para `H` no
máximo `0,4825`. A rejeição dá apenas `0,27` ao tipo baixo e `0,36` ao tipo
alto.

Portanto:

- nenhuma proposta dá `0,51`;
- existem propostas que chegam arbitrariamente perto de `0,51`;
- qualquer proposta escolhida pode ser melhorada por outra proposta da
  sequência.

Sortear entre propostas não resolve. A média de qualquer sorteio continua
estritamente abaixo de `0,51`, e alguma proposta da sequência oferece mais do
que essa média. Logo, para essa regra de continuação permitida pelo contrato,
`H` não possui melhor resposta pura nem mista. Consequentemente, não existe um
equilíbrio bayesiano perfeito que use essa regra.

O argumento completo, incluindo as matrizes de incidência e a prova de que as
duas continuações são membros literais de `C_M`, está na
[Seção 6.1 da derivação](../model_redesign/agenda_extension_A_M_explicit_majority_results.md#61-certificado-negativo-para-amx-014--016-sob-o-contrato-atual).

## 5. O que esse resultado significa — e o que não significa

### Significa

- Não há garantia geral de existência para toda regra de continuação hoje
  admitida.
- Não podemos enumerar todos os equilíbrios puros e mistos por um número
  informativo de casos paramétricos.
- A descrição em termos de conjuntos ainda possível — “reúna todas as regras, crenças,
  propostas e medidas que satisfaçam a própria definição de equilíbrio” — seria
  apenas reescrever a definição de equilíbrio em notação mais longa.
- A compactação do espaço de propostas não basta. Uma função pode estar
  definida num conjunto compacto e ainda não atingir o máximo quando tem os
  saltos permitidos aqui.
- Estratégias mistas não são uma pequena coleção adicional de casos: o contrato
  permite famílias indexadas por conjuntos e medidas muito gerais, inclusive
  distribuições sem átomos.

### Não significa

- Não provamos que o jogo sob maioria nunca tem equilíbrio.
- Não invalidamos os equilíbrios explícitos já construídos.
- Não encontramos erro nas regras econômicas básicas do voto de cada Estado
  fraco: ele continua comparando apenas sua oferta com sua continuação.
- Não provamos que maioria ou unanimidade seja melhor para o hegemon.
- Não aprovamos `A_M`, nem autorizamos usar seus resultados em `AC`, `AR` ou no
  manuscrito.

O relatório de
[convergência das três explorações independentes](2026-08-28_A_M_AMX014_016_exploration_convergence.md)
mostra como três abordagens diferentes chegaram a esse mesmo diagnóstico.

## 6. Estado exato em que o trabalho parou

Os reparos locais que independiam do problema geral foram feitos:

- as construções gerais de `AMX-003` e `AMX-007` foram limitadas ao interior
  do prior, `0 < nu < 1`;
- os casos extremos do prior passaram a ser tratados exclusivamente por
  `AMX-005`;
- a referência de prova de `AMX-011` foi corrigida para a Seção 5.4;
- os contraexemplos dos extremos viraram testes de regressão.

O verificador mecânico terminou com **571 PASS e 0 FAIL**. Isso confirma
identidades, exemplos, contabilidade temporal e regressões programadas. Não é
uma prova de completude matemática e não é uma aprovação do pacote.

`AMX-014`, `AMX-015` e `AMX-016` permanecem com o estatuto:

```text
BLOCKED — NO INFORMATIVE COMPLETION UNDER CURRENT CONTRACT
```

Não houve commit, push, merge, tag ou congelamento. A worktree estava no
snapshot Git `b427671efee954831901e75762988043a2df7205`.

## 7. Opções na mesa

### Opção A — aceitar o resultado negativo e encerrar esta versão da extensão

Preservar o teorema negativo, os equilíbrios testemunhados e os limites
parciais. Não tentar uma classificação universal sob a liberdade atual.

**Vantagem:** é a conclusão mais honesta sob o contrato aprovado e não adiciona
uma hipótese escolhida apenas para facilitar a matemática.

**Custo:** a extensão não entrega a comparação completa de agenda sob maioria
e unanimidade que inicialmente se desejava.

### Opção B — fixar previamente uma regra transparente de continuação

Escolher, antes de `H` propor, um membro ou protocolo canônico para a
continuação depois da rejeição. A escolha não poderia funcionar como uma tabela
de punições diferente para cada proposta rejeitada.

Uma formulação possível seria fixar um membro balanceado de `C_M` em cada
região economicamente relevante, com a dependência permitida declarada de
antemão. A continuação cíclica usada nas construções é uma candidata técnica,
mas adotá-la exigiria uma justificativa substantiva; sua conveniência algébrica
não basta.

**Vantagem:** provavelmente permite uma solução exata e compreensível.

**Custo:** seleciona um equilíbrio da continuação e, portanto, muda o contrato
econômico. A comparação encontrada será condicional a essa seleção.

### Opção C — impor regularidade ou continuidade

Exigir que pequenas mudanças na proposta não provoquem saltos arbitrários no
payoff de continuação. Tecnicamente, seria preciso garantir que o problema de
maximização do hegemon atinja seu máximo.

**Vantagem:** remove diretamente o mecanismo usado pelo contraexemplo e pode
preservar uma família maior de continuações do que a Opção B.

**Custo:** é uma hipótese mais abstrata e pode ser difícil explicar por que a
instituição real deveria satisfazê-la. Garantir existência também não garante,
sozinho, uma classificação simples.

### Opção D — restringir propostas ou distribuições permitidas

Usar uma grade finita de propostas, limitar suportes de misturas ou admitir
apenas algumas famílias paramétricas.

**Vantagem:** torna máximos e enumerações mais fáceis.

**Custo:** parece artificial para um bolo divisível e pode criar resultados
dependentes da grade escolhida. É uma solução matemática com justificativa
econômica fraca.

### Opção E — aceitar equilíbrios aproximados

Trabalhar com `epsilon`-equilíbrios: ninguém consegue melhorar mais do que uma
margem pequena predeterminada.

**Vantagem:** captura precisamente a sequência de propostas que chega cada vez
mais perto de `0,51`.

**Custo:** muda o conceito de solução do paper e não entrega o PBE exato que
orientou todo o restante do projeto.

## 8. Recomendação

**Recomendação principal:** adotar a Opção A para o paper atual. Preservar o
resultado negativo e tratar a extensão de poder de agenda como trabalho futuro
ou como resultado condicional, sem transportá-la agora para o manuscrito.

A razão não é apenas dificuldade técnica. A classificação completa exigiria
uma decisão nova sobre qual equilíbrio ocorre depois de uma rejeição. Se não
há uma justificativa institucional independente para essa decisão, escolhê-la
somente para obter fórmulas fechadas arrisca transformar uma extensão
secundária em uma estrutura mais complexa e mais arbitrária do que o mecanismo
central do paper.

**Recomendação condicional:** se a comparação completa com poder de agenda for
considerada indispensável, escolher a Opção B, não as opções D ou E. O novo
contrato deveria fixar uma regra simples e transparente antes do estágio de
proposta, explicar por que os atores coordenariam naquela continuação e proibir
que a escolha varie com detalhes da proposta rejeitada sem conteúdo econômico.
Depois disso, a derivação deve recomeçar sob o novo contrato e receber nova
revisão matemática independente sobre os mesmos bytes.

Eu não recomendo impor apenas a frase “a continuação depende do posterior”. As
crenças fora do caminho também podem variar muito, de modo que essa formulação
pode apenas deslocar o mesmo problema para outro objeto. A restrição precisa
dizer com precisão qual regra é fixada e quais variáveis podem alterá-la.

## 9. Como retomar daqui a um ano

1. Não comece pela álgebra. Leia primeiro esta nota e a
   [conclusão confrontada dos exploradores](2026-08-28_A_M_AMX014_016_exploration_convergence.md#conclusão-confrontada).
2. Confirme que a worktree e os hashes abaixo ainda existem. Os artefatos não
   foram commitados; não presuma que estejam preservados em uma branch remota.
3. Decida entre aceitar o teorema negativo ou alterar explicitamente a regra de
   continuação. Não peça apenas “continue procurando”: sob o contrato atual, o
   obstáculo já tem certificado.
4. Se houver mudança de regra, altere primeiro o contrato do Gate 0 e registre a
   motivação econômica.
5. Só depois rederive `A_M`. Não reutilize automaticamente `A_U`, `AC` ou
   comparações antigas, porque elas dependem da interface exata de `A_M`.
6. Exija revisão matemática independente do novo snapshot. O resultado
   **571/0** é apenas controle mecânico.

## 10. Relatórios, provas e artefatos para aprofundamento

- [Derivação exploratória completa](../model_redesign/agenda_extension_A_M_explicit_majority_results.md)
  — construções positivas, limites, contraexemplo e certificado negativo.
- [Ledger dos claims](../model_redesign/agenda_extension_A_M_explicit_majority_claim_ledger.tsv)
  — mostra o que está resolvido e o que permanece bloqueado.
- [Convergência das três explorações independentes](2026-08-28_A_M_AMX014_016_exploration_convergence.md)
  — reconstruções pura, mista e de existência.
- [Pacote técnico em PDF](../output/pdf/agenda_extension_A_M_equilibria_chatgpt_pro_packet.pdf)
  — versão conveniente para leitura e auditoria externa.
- [Auditoria externa original que motivou a reabertura](external_reviews/2026-08-28_auditoria_equilibrios_AM_original.md)
  — importante como história do diagnóstico, mas não cobre os bytes atuais.
- [Revisão fria histórica](2026-08-28_A_M_cold_counterexample_review.md) e
  [revisão guiada histórica](2026-08-28_A_M_guided_proof_review.md)
  — pareceres preservados; não constituem aprovação da derivação corrente.
- [Script de verificação mecânica](../scripts/verify_agenda_extension_A_M_explicit.R)
  — reproduz os 571 testes, sem pretensão de provar completude.
- [Preflight do snapshot corrente](2026-08-28_A_M_exploratory_blocked_preflight.md)
  — escopo, estado e hashes.
- [Manifesto SHA-256](2026-08-28_A_M_exploratory_blocked_manifest.sha256)
  — permite verificar os bytes exatos das fontes técnicas desta memória.

## 11. Hashes do snapshot explicado nesta nota

```text
Base Git
b427671efee954831901e75762988043a2df7205

Derivação
1e385fabd2e25a5b72344d22982d9648e28be92eb68665d484cd8116aaa7772f

Ledger
d2d81d3b0cf65d59e4e5846f599a5f67677507c51c9c3677e39e75907a0e4274

Script R
e277d1ab845391b8ae01a61ce7fc9a64225dca1591783102b3916ccc07bf6177

Pacote técnico em Markdown
3c961923f598973ac845e6b92b10b8606c288fac57c14bf5b4f24bbf90b74e04

Pacote técnico em PDF
9e3f9ec4a055ca7bfa5630d53b77fbce16605030797e1d68cedf4760a7e1eb75

Manifesto
712aec4263ce0be7d00b6a72f9970cdbe9eb0567542aece6d344ac9449d6c3d4
```

Se qualquer um desses bytes mudar, esta nota continua válida como memória
histórica, mas deixa de descrever exatamente o candidato corrente.
