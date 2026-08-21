# Registro da conversa — decisão do conceito de solução essential-input (2026-08-21)

**Natureza deste documento**: registro reconstruído da sessão Claude Code de 2026-08-21, escrito na própria sessão para referência posterior. Não é transcript literal palavra a palavra, mas preserva a sequência das trocas, os argumentos completos e as falas decisivas do autor entre aspas, quase verbatim. A decisão final está formalizada em `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`; a auditoria que originou tudo está em `quality_reports/2026-08-21_game-theory-audit_essential_input.md`.

---

## 1. Pedido inicial

O autor pediu parecer sobre a matemática das provas provisórias em
`quality_reports/2026-08-21_essential_input_jogo_e_provas_disponiveis.md`
(worktree `codex/essential-input-beta-interior`), que registra o jogo essential-input e as demonstrações disponíveis para N1 (R2 maioria), N2 (R2 unanimidade), N3 (R1 maioria, provisória) e N4 (R1 unanimidade, provisória).

## 2. Auditoria em dois passes

O skill `game-theory-audit` foi executado com dois passes independentes: verificação linha a linha pelo assistente principal e um agente adversarial independente (sem edição de arquivos), instruído a rederivar tudo e refutar ou confirmar os pontos suspeitos. Os passes convergiram. Vereditos: N1 e N2 SOUND; N3 SOUND WITH GAPS (reparos de um parágrafo); N4 FLAWED como pacote.

**Achado central (C1–C4 da auditoria)**: as provas de N4 dependem de convenções mutuamente incompatíveis sobre crenças em histórias de probabilidade zero e sobre o refinamento de votação:

- A **necessidade** do lema dos múltiplos vetos (§10.4: proposta rejeitada por ≥2 vetos com ν≥ν* exigiria x_k ≤ B para cada vetante) precisa de crenças **presas** ao prior após desvio de um fraco. Com crenças livres há contraexemplo: o desvio de um vetante para sim pode ser punido com a continuação screening, que vale D=(1−ν)A < B para o desviante quando ν>ν*, tornando o veto sustentável com qualquer x_k.
- A **exatidão da segurança** S₃=(1−ν)B (§10.5) precisa de crenças **livres**: a punição usa votos separadores de H com crença invertida (η≤ν* num vetor que, dado o perfil, só o tipo alto alcança). Qualquer consistência estrutural força η=1 ali e a segurança sobe.
- Além disso, a prova da necessidade usa uma noção de votação mais forte que a declarada: exige que o voto jogado **domine fracamente** a alternativa (raciocínio pivotal), enquanto o §2.5 só proibia jogar voto **fracamente dominado** (admissibilidade).
- Achados adicionais: piso x_j ≥ B do §10.3 não é uniforme sob nenhuma convenção (vira min{D,B} ou C); fronteira x_k=B falha no knife-edge ν=ν*; m=2 (§10.6) usa limiares em A que contradizem o bound C do §10.3 para todo ν>0. Um alarme falso do primeiro passe (orçamento da família pooling em §10.7) foi corrigido pelo segundo: respondentes são m−1, a soma fica ≤ β < 1.

O que sobrevive em N4: contabilidade condicionada ao tipo (§10.1, incluindo a identidade (1−ν*)A=B), exaustividade P/L/D, impossibilidade de separação com ν>0, existência de atraso para m≥3. O que muda conforme a convenção: pisos, fronteiras, valor de segurança.

## 3. Opções apresentadas

Dois eixos independentes:

**Eixo 1 — crenças off-path**: (1a) livres literais; (1b) no-signaling só para fracos, meio-termo instável; (1c) no-signaling + consistência estrutural (só ações de H movem crenças, por Bayes mesmo em subárvores off-path; desvios do próprio H ficam livres).

**Eixo 2 — refinamento de votação dos fracos**: (2a) admissibilidade (não jogar voto fracamente dominado); (2b) as-if-pivotal (voto ótimo condicional ao evento decisivo, quando estrito).

Matriz de consequências: (1a)+(2a) preserva S₃ exata mas perde a necessidade do multi-veto e rebaixa o piso para min{D,B}; (1c)+(2b) ganha a necessidade e a disciplina, mas S₃ deixa de ser exata e os pisos viram C; combinações cruzadas são dominadas; a pseudo-regra "dominância só on-path" salvaria tudo mas é incoerente (o caminho é determinado pelo próprio perfil) e foi descartada em definitivo. Em qualquer escolha, T^Y precisa de definição (valor esperado vs. contingência a contingência).

Critério recomendado e aceito: escolher a regra de crenças defensável como descrição do ambiente, não a que salva mais resultados.

## 4. Falas decisivas do autor

Sobre no-signaling (fundamento substantivo da Decisão 1):

> "No signaling é para mim o mais óbvio. Estou modelando estados, que contam com diplomatas para as negociações. Ninguém vai achar que Moçambique é informativo se erra e joga fora do equilíbrio e não tem info privada sobre o tipo do Hegemon (não houve comunicação privada do Hegemon pra Moçambique). Isso pra mim é bem óbvio."

Sobre as-if-pivotal, o autor inicialmente hesitou ("proibir votar fracamente dominado parece excessivo e não vejo bom motivo para isso, mas também não tenho muita intuição sobre as-if-pivotal") — hesitação apoiada numa inversão lógica que foi corrigida na conversa: **admissibilidade é a restrição fraca e as-if-pivotal a forte** (as-if-pivotal proíbe tudo que a admissibilidade proíbe, e mais). O argumento que o autor declarou convincente:

> [citando a explicação aceita] "Admissibilidade sozinha permite que o diplomata de Moçambique sustente um veto contra oferta melhor que sua continuação com a justificativa: 'num cenário que nunca ocorre, e no qual as crenças e continuações foram desenhadas sob medida, meu não teria sido melhor'. As-if-pivotal assume que o diplomata raciocina instrumentalmente: 'meu voto só importa quando decide o resultado; condicional a decidir, o que eu prefiro?' — e vota isso."

O autor: "me convence de o que importa pra mim é as-if-pivotal".

Sobre indiferença em valor esperado: o autor declarou-se convencido pelo argumento de que (i) os jogadores são maximizadores de utilidade esperada e sua preferência no momento do voto É a comparação de valores esperados; (ii) a leitura contingência-a-contingência faria o T^Y quase nunca acionar, reabrindo o problema do "reserva + ε" do ultimato (proposta ótima inexistente).

## 5. Dúvidas conceituais resolvidas na conversa (para o autor de daqui a 6 meses)

**Por que a intuição do ultimato não bastava**: no ultimato não há tipos, nem loteria de reconhecimento, nem votos simultâneos — então indiferença esperada e indiferença realização-a-realização coincidem, e admissibilidade e as-if-pivotal coincidem. Este jogo separa as duas coisas por três canais: tipos privados (payoffs θ-contingentes), loteria de reconhecimento em R2 (pagamento certo vs. loteria de mesma média), e simultaneidade com vetor público (linhas off-path onde os votos diferem sem serem pivotais).

**Objeção do autor que fechou o quebra-cabeça**: "Mesmo quando Moçambique não é pivotal, o voto de Moçambique muda a história pública — mas não deveria mudar de maneira consequente, no sentido de alterar qualquer crença de alguém." Resposta: a objeção está correta sob o pacote escolhido, e é o próprio argumento do no-signaling. Com no-signaling, vetores que diferem só em votos de fracos levam à mesma continuação (o subjogo R2 é essencialmente único dada a crença). Não há sutileza de common knowledge envolvida. O único canal residual são vetores que diferem no voto **de H** (informado, crença livre após desvio dele) — e é exclusivamente desse material que a admissibilidade sozinha é feita: linhas contrafactuais "e se H tivesse votado não". As-if-pivotal fecha exatamente esse canal.

**Fronteiras que abrem/fecham (sentido topológico literal)**: o conjunto de x_k que sustenta um veto passa de intervalo fechado [0,C] para meio-aberto [0,C): no ponto de indiferença exata, T^Y força sim e o veto quebra; regiões de veto/atraso ficam definidas por desigualdades estritas, enquanto fronteiras de acordo fecham (proponente paga exatamente a reserva). Análogo exato do ultimato (respondente aceita a oferta zero). Consequências práticas: (i) quase inócuo em payoffs, pois x_k de proposta rejeitada nunca é pago; (ii) morde em construções que dependiam de veto em indiferença exata — ex.: mistura pooling/atraso em Y=h via veto de H indiferente — e multiplica distinções sup vs. máx.

## 6. Decisão final (martelo batido pelo autor)

> "ok, ciente, martelo batido nas escolhas. no-signaling, as-if-pivotal e comparação por valor esperado."

Pacote completo: **no-signaling + consistência estrutural** (crenças), **as-if-pivotal** (votação dos fracos), **T^Y em valor esperado na comparação pivotal** (desempate). As três peças expressam o mesmo princípio: comportamento disciplinado pelo que importa instrumentalmente — informação que o jogador tem, eventos em que é decisivo, preferências em expectativa — não por contingências fantasma.

Consequências assumidas de olhos abertos (detalhadas no registro de decisão): S₃=(1−ν)B deixa de ser exata; pisos viram C; necessidade do multi-veto passa a valer com fronteiras abertas (e a cláusula ν<ν* "sem restrição" não sobrevive); §10.3–§10.7 rederivar; N1/N2 intactos; N3 afetado só pelos reparos menores.

## 6a. Adendo — episódio dos endpoints durante a rederivação cega de N4 (Decisão 1a)

Na sequência, com o Codex rederivando N3 e N4 sob o pacote decidido, a derivação cega de N4 parou em `pending protocol decision`: nos endpoints ν=0 e ν=1, uma ação prescrita exclusivamente ao tipo de probabilidade a priori zero produz denominador bayesiano nulo (0/0), e o pacote não determinava a crença. Os agentes propuseram um binário — "crença livre em [0,1]" vs. "pinagem estrutural no tipo prescrito" — e o orquestrador recomendou a primeira, invocando "a leitura padrão de PBE".

A análise nesta sessão mostrou que o binário era falso: a resposta canônica é a terceira leitura, **restrição de suporte** (crenças livres dentro do suporte do prior; tipo com prior zero nunca recebe posterior positivo; em ν=0, posterior ≡ 0 na árvore inteira). Argumentos: em ν=0 o jogo É o de informação completa (caso-limite do no-signaling: não se sinaliza ser o que todos sabem que você não é); Kreps–Wilson implica a restrição automaticamente via trembles; Fudenberg–Tirole a impõe na definição de PBE (suporte do posterior nunca cresce); e ela alinha os endpoints de N4 com o benchmark N7 de θ público. A pinagem estrutural destruiria o acordo de informação completa do endpoint e reabriria o pacote; a crença livre literal permitiria ressuscitar o tipo impossível como instrumento off-path — a mesma classe de contabilidade que causou as crises anteriores.

O autor bateu o martelo na restrição de suporte e enviou a decisão ao Codex, com a verificação obrigatória antes de PASS (nenhum registro off-path de endpoint, do N4 principal ou da derivação cega, pode usar posterior positivo no tipo de prior zero). Registrada também a consequência substantiva: descontinuidade da correspondência em ν=0⁺ (reputação à la Fudenberg–Levine) — incerteza infinitesimal sobre a opção externa do hegemon já destrói a compra barata de H0 pelos fracos; é resultado para o paper, não anomalia. No mesmo ciclo, a derivação cega confirmou independentemente a inexistência de equilíbrio puro no ballot para propostas off-path com 0<ν≤ν*, inclusive com m=2.

Formalização: seção "EMENDA — Decisão 1a" em `2026-08-21_decisao_conceito_solucao_essential_input.md`; destaques atualizados em CLAUDE.md e AGENTS.md.

Ressalva de citação (Codex, aceita e refinada): a restrição de suporte não é teorema geral de Kreps–Wilson (o domínio formal do equilíbrio sequencial assume natureza com probabilidades positivas; a lógica de trembles é motivação). Para Fudenberg–Tirole (1991) a base é mais forte do que o Codex sugeriu: a definição completa de PBE deles para jogos multi-estágio com ações observadas (classe do nosso jogo) inclui B(ii) "no signaling what you don't know" — a mesma condição do pacote, com o mesmo nome — e B(iv) "never dissuaded once convinced" (proibição de ressurreição), que juntas implicam a restrição de suporte com prior degenerado. Citação correta no manuscrito: condição declarada do conceito de equilíbrio, na linha de B(ii)/B(iv) de Fudenberg–Tirole, com Kreps–Wilson como motivação — nunca "segue de Kreps–Wilson".

Neste mesmo período o autor validou dois pontos de protocolo: (i) a exigência de registrar toda multiplicidade, inclusive off-path, antes de PASS — rastreada às cláusulas P0, P4, P6, ao envelope de cobertura (§10) e ao PASS 0/0/0 (§11) do contrato Gate 0, e avaliada como correta (completude é o claim certificado; interfaces off-path alimentam N6/N7); (ii) a intuição pré-derivação sobre unanimidade: nenhuma separação pelo voto de H sobrevive em R1 para ν>0 (nem pivotal nem por voto informativo não pivotal — o tipo baixo sempre imita; o voto é cheap talk sem single-crossing), separação vive só no screening terminal de R2; a renda do tipo baixo vive no pooling (h−ℓ). Registrado como intuição, não resultado — a derivação cega deve chegar lá por conta própria.

## 7. Artefatos produzidos na sessão

1. `quality_reports/2026-08-21_game-theory-audit_essential_input.md` — auditoria completa (2 passes), no repo principal e na worktree `725d`.
2. `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` — registro formal da decisão com alternativas descartadas.
3. Este registro de conversa.
4. Destaques em `CLAUDE.md` e `AGENTS.md` apontando para a decisão.
