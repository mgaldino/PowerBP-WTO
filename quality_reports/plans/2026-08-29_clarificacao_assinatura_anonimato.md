# Clarificação da emenda M/S/B — escopo da simetria e leitura anônima da assinatura

**Data:** 2026-08-29
**Status:** APPROVED — aval autoral concedido em 2026-08-29 ("ok, aprovo sua
recomendação") sobre as decisões dos §§1–2. O §4 incorpora, na mesma data, o
reparo 10.3 do parecer externo lido pelo autor antes da aprovação.
**Relação com a emenda:** clarificação interpretativa da Cláusula S (§3) e da
assinatura de equivalência (§6, item 2) de
`quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md`.
Este registro NÃO altera os bytes aprovados da emenda (SHA-256
`8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b`), no padrão
da errata de N2: registro separado, artefato intacto, leitura conjunta.
**Gatilho:** divergência interpretativa na sessão de derivação Codex sobre
equilíbrios que pagam coalizões distintas de fracos (por exemplo, comprar os
votos de {1,2} versus {2,3}) e sobre se a Cláusula S exige estratégia corrente
de `H` invariante a permutações dos fracos.

## 1. Escopo da Cláusula S — confirmação da letra e do espírito

A Cláusula S restringe o membro selecionado da continuação `C_g`: payoffs
interinos invariantes a permutações dos Estados fracos, representante uniforme.
A Cláusula M restringe `kappa_g`. A Cláusula B restringe crenças em pontos não
disciplinados. Nenhuma cláusula restringe a estratégia corrente de proposta de
`H` além da mensurabilidade e das regras do contrato base. Comportamento
assimétrico de `H` no estágio — pagar {1,2} e não {2,3} — é admissível em
equilíbrio. A leitura do derivador está correta.

O espírito coincide com a letra. A simetria foi imposta onde uma seleção era
forçada: a multiplicidade de coalizões em `C_M` precisava colapsar para a
Cláusula M ter conteúdo, e anonimidade era o critério não arbitrário. Na
proposta corrente nenhuma seleção é forçada: com a continuação simétrica, todos
os fracos carregam o mesmo preço de voto `beta*C(mu)`, e a indiferença de `H`
entre coalizões é multiplicidade comum de equilíbrio, sem ameaça à existência
nem à classificação. A simetria da continuação é precisamente o que torna as
escolhas assimétricas de estágio gratuitas: se a continuação fosse assimétrica,
`H` preferiria estritamente os fracos baratos e a coalizão ficaria pinada.

### Decisão: simetria comportamental de `H` no estágio
- **Escolha**: não impor. A estratégia de proposta de `H` pode discriminar
  identidades; o conjunto de equilíbrios é fechado sob permutações dos fracos
  (o jogo é simétrico nos fracos sob M/S/B), mas cada equilíbrio
  individualmente não precisa ser simétrico.
- **Alternativas descartadas**:
  - exigir estratégia de `H` invariante a permutações (mistura uniforme
    obrigatória sobre coalizões): descartada — hipótese comportamental sem
    motivação institucional; desnecessária para existência; e apagaria um
    traço substantivo da regra de maioria: a liberdade de excluir fracos e
    formar coalizão mínima vencedora é parte do contraste com unanimidade,
    onde `H` precisa pagar todos. O precedente confirma: no equilíbrio
    estacionário de Baron–Ferejohn, os payoffs são únicos (Eraslan 2002), mas
    a composição da coalizão permanece indeterminada; o representante uniforme
    é seleção expositiva, e não exigência do conceito. A diferença local — em
    BF o favoritismo persistente se autocorrige via preços; em `A_M` a
    continuação congelada não responde aos hábitos de `H` — não muda a
    conclusão, porque o estágio é único e o favoritismo é rotulagem pura.

## 2. Leitura anônima da assinatura de equivalência

### Decisão: quociente por permutações dos fracos
- **Escolha**: a assinatura do §6, item 2 da emenda é lida **a menos de
  permutações dos Estados fracos ex-ante idênticos**. "Payoffs interinos dos
  fracos" e "distribuição de outcomes terminais" entram como objetos anônimos
  (multiconjuntos/distribuições), não como vetores nomeados. Cada classe é
  reportada por um representante — o simétrico (mistura uniforme sobre a
  órbita) quando existir — com a órbita registrada (cardinalidade até
  `C(m,k)` nas puras; misturas sobre a órbita pertencem à mesma classe). O
  quociente aplica a MESMA permutação ao perfil inteiro (propostas, votos,
  crenças, payoffs).
- **Motivo**: com vetores nomeados, cada rotulagem de coalizão e cada mistura
  sobre rotulagens viraria classe distinta sem conteúdo econômico,
  multiplicando a classificação por permutações estéreis. Downstream, `AC` e
  `AR` consomem apenas objetos anônimos — payoffs ex ante, distribuições,
  posteriores —, então o quociente preserva tudo que os consumidores usam.
- **Alternativas descartadas**:
  - assinatura nomeada: multiplica classes por rotulagem; contraria o
    propósito do reescopo;
  - eliminar a multiplicidade na fonte impondo simetria à estratégia de `H`:
    descartada no §1;
  - quocientar também o mapa tipo→sinal: descartado — separação por identidade
    de coalizão (os dois tipos pagando coalizões distintas com `z_0 = z_1`)
    não é rotulagem de um mesmo perfil: altera a coordenada "posterior nos
    sinais alcançados" e deve aparecer como classe própria, consistente com o
    certificado de impossibilidade que exige `z_0 = z_1` em separating com
    acordo dos dois tipos.

## 3. Instrução ao derivador e aos revisores

1. Equilíbrios que diferem apenas pela identidade da coalizão paga, ou por
   misturas sobre identidades, formam UMA classe de assinatura, reportada pelo
   representante simétrico com a órbita registrada.
2. Classes que diferem em revelação (posterior nos sinais alcançados)
   permanecem distintas mesmo após o quociente — inclusive a separação por
   identidade de coalizão no knife-edge `z_0 = z_1`.
3. Registrar no ledger a verificação, barata, de que o conjunto de equilíbrios
   é fechado sob permutações dos fracos sob M/S/B; ela sustenta o quociente.
4. Se o pacote entregue tratou rotulagens como classes distintas, aplicar um
   passe de re-corte sob esta clarificação ANTES das revisões independentes.

## 4. Precisão adicional — estatuto do kernel uniforme

O parecer técnico externo de 2026-08-29
(`quality_reports/external_reviews/2026-08-29_consulta_tecnica_chatgpt_web_A_M_msb.md`,
SHA-256 `d4928d7cf90ae01b37848d43b6d38d32498332822b1f73d955eebb7f1dabc47c`,
achado 9.4 e reparo 10.3) identificou de forma independente a mesma
ambiguidade na expressão "implementação computacional" da Cláusula S e a
resolveu no sentido desta clarificação, com uma precisão que fica adotada:

- a continuação efetivamente selecionada em cada estado é o representante
  literal uniforme, ou a mistura comum dos representantes uniformes `E/P` no
  empate residual;
- construções cíclicas servem somente para calcular payoffs interinos; não são
  kernels terminais admissíveis nem membros adicionais da assinatura;
- como a assinatura preserva a lei das coalizões terminais (`Q_theta`),
  anonimidade significa igualdade de payoffs E kernel terminal uniforme, e não
  apenas a primeira;
- o quociente por permutações do §2 aplica-se à assinatura enriquecida
  recomendada pelo parecer (incluindo `nu_off` ou `rho`, escalares invariantes
  por permutação, e a lei conjunta `Gamma_theta`), sem alteração de conteúdo.

**Aprovação autoral:** concedida em 2026-08-29 (§§1–2 pela mensagem do autor;
§4 como adoção literal de reparo do parecer externo lido pelo autor).
