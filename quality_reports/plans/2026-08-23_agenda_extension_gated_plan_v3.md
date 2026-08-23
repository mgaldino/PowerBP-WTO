# Plano v3 final — extensão de agenda informal com contrato, DAG e gates

**Status:** PLANO FECHADO PELO AUTOR — não autoriza execução

**Data:** 2026-08-23

**Objeto:** planejar a derivação, verificação, comparação e eventual migração
da extensão em que `H`, já informado de seu tipo, propõe antes do jogo
`essential-input` congelado.

**Substitui operacionalmente:**

- o fluxo simplificado de
  `quality_reports/plans/2026-08-23_agenda_extension_todo.md`;
- o plano v2, preservado no SHA-256
  `ef9b41b7d4875e06eaf19a764e2605b5c95a8a7aed1f5c6b41c67eb722bbf29b`;
- as recomendações do parecer Fable, preservado no SHA-256
  `f4d8a185088818878eafc4b07d0a6f63f09a0cd82474cb685a2c35916dd9a6b9`,
  apenas na medida explicitamente decidida neste documento.

**Fronteira protegida:** os nós congelados `N1`–`N4`, `N6` e `N7`, o contrato
`essential-input` e o snapshot revisado do manuscrito permanecem byte a byte
fora do escopo deste plano.

Fechar este plano significa fechar as decisões de planejamento. Não significa
abrir o Gate 0, iniciar derivação, executar scripts, editar o manuscrito, criar
commit ou tag, fazer push ou alterar qualquer artefato congelado. Cada Goal
continua exigindo a autorização expressa indicada abaixo.

---

## 0. Decisões autorais incorporadas após o parecer Fable

As decisões abaixo prevalecem sobre formulações incompatíveis do rascunho, do
plano v2 ou do parecer.

1. **Sem ação nula de agenda.** No estágio `A`, `H` deve formular uma proposta.
   Não existe botão primitivo de espera que leve diretamente a `C`. Atraso só
   pode surgir endogenamente se uma proposta admissível for rejeitada. A
   existência de uma proposta sacrificial não será presumida: deve ser provada
   a partir do espaço de propostas e das respostas dos votantes.
2. **Nova data zero.** O estágio `A` é a data zero da extensão. Os payoffs
   congelados de `C_M`, `C_U` e das continuações públicas de `N7` conservam sua
   data nativa e são descontados exatamente uma vez ao serem importados por
   `A`.
3. **Ações puras no ballot; propostas podem misturar.** Mantém-se a restrição a
   votos puros. As estratégias de proposta de `H` podem ser mistas, de modo que
   pooling, separating e semi-pooling não sejam excluídos por construção.
4. **Baseline sem seleção silenciosa.** O objeto principal é a correspondência
   completa de PBE sob o pacote vigente de votação e crenças. Nenhum ponto é
   escolhido para recuperar uma conta de guardanapo ou produzir um ranking.
5. **Robustez por trembling simétrico, se necessária.** Se uma proposição
   substantiva ou comparação institucional variar dentro da correspondência
   baseline, aplica-se o protocolo pré-especificado de trembling simétrico do
   §2.3, com medida de Lebesgue normalizada na dimensão afim do espaço factível
   de propostas. Se o limite induzir crenças passivas, elas serão reportadas
   como consequência da perturbação, não impostas como crença primitiva.
6. **D1 e Critério Intuitivo são diagnósticos de robustez, não baseline.** Sua
   aplicação não é presumida capaz de selecionar. A previsão de que sejam
   silenciosos em pooling é conjectura a verificar, sobretudo quando houver
   mistura ou semi-pooling.
7. **Domínio inicial completo de `A_U`.** O prior de entrada de `A_U` continua
   em `[0,1]`. A célula vazia herdada de `C_U` não autoriza cortar o domínio de
   `A_U` de saída: uma proposta informativa pode gerar um posterior cuja
   continuação existe. A existência de PBE em `A_U` será derivada.
8. **Uma continuação `none` nunca recebe payoff fictício.** Uma avaliação que,
   após alguma história relevante, exija consumir um registro inexistente de
   `C_U` é inválida. Crenças livres podem sustentar uma avaliação apenas se
   escolherem um posterior admissível com continuação existente; isso é
   admissibilidade sequencial, não seleção autoral.
9. **Consumibilidade pública antecipada.** O Goal 1 audita também as
   continuações públicas de `N7`, embora elas só sejam consumidas por `AR`.
10. **Derivações controladas em sequência.** `A_M` e `A_U` são graficamente
    independentes depois de suas continuações, mas serão executados como Goals
    separados e sequenciais para preservar a revisão cega exclusiva de `A_U`.
11. **Prosa só na migração.** As mudanças sobre Steinberg, Stone e o
    posicionamento da contribuição ficam no Goal 6, depois de os resultados
    estarem congelados.

---

## 1. Objetivo substantivo e estatuto das intuições

O jogo atual pergunta o que a informação privada de `H` vale quando apenas
Estados fracos propõem. A extensão acrescenta uma etapa anterior na qual `H`,
já informado, formula a primeira proposta. Se ela falha, começa integralmente
o jogo atual, sem modificação de suas primitivas, estratégias,
correspondências ou resultados.

A extensão investiga a interação entre:

1. **poder informacional:** a regra torna o voto informado de `H` substituível
   ou essencial na continuação;
2. **poder de agenda informal:** `H` explora, ao propor, as reservas dos
   votantes produzidas por essa continuação.

As afirmações substantivas do rascunho são intuições disciplinadoras e
conjecturas falsificáveis. Não têm precedência sobre a matemática. Cada uma
deve terminar como `proved`, `checked numerically`, `conjecture`, `pending` ou
`rejected`, com domínio, fronteiras, conceito de solução e dependência de
seleção explícitos.

Intuições candidatas, sem estatuto de resultado:

- a essencialidade futura de `H` sob unanimidade pode reduzir a reserva dos
  votantes fracos no estágio de agenda;
- a continuação por maioria pode fortalecer a recusa dos fracos por permitir
  excluir `H`;
- pode existir uma região na qual ambos os tipos de `H` prefiram unanimidade;
- a renda informacional do tipo baixo pode ser transportada mais uma rodada
  para trás;
- separação pode falhar sob unanimidade e surgir por rejeição sob maioria;
- o payoff por quórum pode apresentar um vale, mas isso exige extensão própria.

Resultados contrários são preservados. Nenhuma primitiva, crença ou seleção
será introduzida para salvar essas intuições.

---

## 2. Forma extensiva, conceito de solução e robustez

### 2.1 Cronologia e dependências

A orientação cronológica é:

```text
A_M  ->  C_M
A_U  ->  C_U
```

- `A_M`: `H` propõe sob maioria; se a proposta falha, entra `C_M`.
- `A_U`: `H` propõe sob unanimidade; se a proposta falha, entra `C_U`.
- `C_M`: continuação privada congelada de `N3`.
- `C_U`: continuação privada congelada de `N4`.

Essa é a ordem dos acontecimentos. A indução retroativa obedece à relação
inversa de consumo:

```text
A_M depends_on C_M
A_U depends_on C_U
AC  depends_on A_M, A_U
AR  depends_on AC e nas continuações públicas congeladas de N7
```

As duas representações devem aparecer juntas em todo handoff: `A -> C` para a
cronologia e `A depends_on C` para a ordem de solução. O DAG `essential-input`
permanece fechado; a extensão usa namespace, contrato, schema, ledger,
verifier e invalidação próprios.

### 2.2 Pacote baseline transportado

O Gate 0 deve transportar integralmente:

1. votação **as-if-pivotal** dos Estados fracos;
2. `T^Y`: `sim` na indiferença genuína em valor esperado;
3. **no signaling what you do not know**: ações de jogadores fracos, que não
   observam `theta`, não alteram crenças sobre `H`;
4. **consistência estrutural**: em subárvore alcançada por desvio fraco, ação de
   `H` prescrita pelo perfil atualiza por Bayes quando o perfil a identifica;
5. após desvio genuíno de `H` que nenhum tipo executa no perfil, crenças livres
   dentro do suporte permitido;
6. preservação de suporte: posterior sempre 0 em `nu=0`, sempre 1 em `nu=1`, e
   ambos os tipos disponíveis no interior;
7. PBE com estratégias puras no ballot e estratégias de proposta possivelmente
   mistas.

Propostas on-path de `H` atualizam por Bayes. A liberdade baseline após um
desvio genuíno de `H` não é crença passiva, D1, Critério Intuitivo ou tremble.
Esses objetos devem permanecer nominal e matematicamente separados.

### 2.3 Protocolo pré-especificado de trembling simétrico

O trembling simétrico é uma camada de robustez da proposta de `H`, acionada
somente pelo gatilho objetivo do §2.4. Antes de qualquer derivação, o Gate 0
deve formalizá-lo como uma família de jogos perturbados.

Construção canônica adotada:

1. o espaço factível de propostas `Y` deve ser um subconjunto compacto e
   Boreliano de um espaço euclidiano finito, escrito nas coordenadas econômicas
   primitivas do pacote. Se sua dimensão afim for `k`, exige-se
   `0 < L_k(Y) < ∞` e `Y` igual ao suporte relativo da medida;
2. `lambda` é fixada como a medida de Lebesgue `k`-dimensional normalizada em
   `Y`:

   ```text
   lambda(B) = L_k(B ∩ Y) / L_k(Y).
   ```

   Portanto, `lambda` é atomless e tem suporte completo na topologia relativa
   de `Y`. No caso unidimensional, ela é simplesmente a distribuição uniforme
   no intervalo factível;
3. para cada `epsilon > 0` e cada tipo `theta`, a estratégia de proposta é
   perturbada pela **mesma** intensidade e pela mesma `lambda`:

   ```text
   sigma_theta^epsilon = (1-epsilon) sigma_theta + epsilon lambda;
   ```

4. taxas, densidades ou kernels específicos por tipo são proibidos no teste
   principal, pois devolveriam liberdade arbitrária às crenças;
5. para prior `nu`, a distribuição pública de propostas no jogo perturbado é

   ```text
   m^epsilon = (1-nu) sigma_0^epsilon + nu sigma_1^epsilon.
   ```

   O posterior do tipo alto é a versão pré-especificada de Bayes dada por

   ```text
   nu^epsilon(y)
     = nu * d sigma_1^epsilon / d m^epsilon (y).
   ```

6. para cada tipo, escreve-se a decomposição

   ```text
   sigma_theta = sigma_theta^at + f_theta lambda,
   ```

   onde `sigma_theta^at` é a parte atômica e `f_theta` é uma versão Boreliana
   pontualmente especificada da densidade. Em um átomo, Bayes usa a razão das
   massas. Fora dos átomos, o posterior é fixado ponto a ponto por

   ```text
   nu^epsilon(y)
     = nu[(1-epsilon)f_1(y)+epsilon]
       / {(1-nu)[(1-epsilon)f_0(y)+epsilon]
          + nu[(1-epsilon)f_1(y)+epsilon]}.
   ```

   Onde `f_0(y)=f_1(y)=0`, a proposta é produzida apenas pelo erro comum e o
   posterior é passivo, `nu^epsilon(y)=nu`. Os endpoints continuam sujeitos à
   preservação de suporte;
7. se uma estratégia candidata contiver componente singular contínuo que não
   seja coberto pela decomposição em átomos e parte absolutamente contínua em
   relação a `lambda`, o protocolo para e escala essa ocorrência. Não se escolhe
   uma versão de crenças dentro da prova;
8. a votação as-if-pivotal continua sendo uma restrição separada. O plano não a
   declara equivalente a uma sequência formal de trembles no ballot;
9. a correspondência sobrevivente é o conjunto de todos os limites obtidos ao
   longo de sequências `epsilon_n -> 0` de equilíbrios dos jogos perturbados,
   exigindo convergência fraca das medidas de estratégia e convergência pontual
   de `nu^epsilon_n(y)` para todo `y in Y`. Convergência apenas quase em toda
   parte não basta para fechar crenças em histórias off-path;
10. existe uma única passagem ao limite, `epsilon -> 0`. Grades finitas podem
    aproximar numericamente o problema, mas o tamanho da malha não integra a
    definição do conceito e não cria um segundo limite;
11. inexistência de qualquer subsequência convergente ou passagem por uma
    continuação `none` é resultado de não robustez, nunca licença para escolher
    outro posterior. Se houver vários limites, todos permanecem na
    correspondência selecionada;
12. a correspondência baseline permanece publicada ao lado do subconjunto
   sobrevivente. O subconjunto não reescreve retroativamente o baseline.

Esse protocolo é uma seleção por perturbação no estágio de proposta. Ele não
será chamado de equilíbrio sequencial ou trembling-hand perfection sem prova
de equivalência ao conceito correspondente no jogo completo.

Não há análise de sensibilidade obrigatória a outras distribuições de erro. Uma
`lambda` diferente da Lebesgue normalizada é diagnóstico opcional posterior,
fora do critério de PASS do núcleo, e exige autorização própria. Ela não pode
substituir retroativamente a construção canônica após os resultados serem
conhecidos.

### 2.4 Gatilho e ordem dos testes de robustez

Para cada claim substantivo alvo:

1. derivar a correspondência completa de PBE baseline;
2. verificar se o claim é verdadeiro para todos os seus elementos relevantes;
3. se for, registrar `selection-robust` e não acionar seleção adicional;
4. se não for, registrar exatamente qual payoff, outcome ou ranking varia;
5. testar D1 e Critério Intuitivo apenas onde estejam bem definidos e
   documentar se eliminam algo;
6. acionar o trembling simétrico pré-especificado;
7. comparar a correspondência sobrevivente com a baseline e declarar toda
   dependência da perturbação.

O trembling não pode ser definido depois de conhecido o equilíbrio desejado.

### 2.5 Primitivas que o Gate 0 deve transcrever sem lacunas

- jogadores, tipos, prior `nu in [0,1]` e domínio dos parâmetros;
- `A` como data zero e `beta in (0,1)`;
- pie fixa em 1, `b_theta=0` e opção externa de `H` externa à pie;
- coordenadas e factibilidade do pacote, destino do residual e payoffs de todos;
- obrigação de `H` propor e inexistência de ação nula;
- se o voto do proponente conta automaticamente como `sim`;
- implementação para votantes fracos e efeito do voto individual;
- simultaneidade, informação disponível e publicação do vetor de votos;
- transição completa de toda proposta e vetor de votos para acordo ou `C`;
- história pública e posterior que entram em `C_M` ou `C_U`;
- ações puras no ballot e mistura permitida nas propostas;
- ausência de side payments externos e formação fora do escopo;
- correspondência completa quando houver propostas ótimas múltiplas;
- estimandos privados por tipo, ex ante, públicos, rendas e interação;
- maioria simples e unanimidade no núcleo; quóruns intermediários no Goal `Q`.

Nenhum item pode ser preenchido dentro da prova. O contrato deve marcá-lo
`APPROVED` ou `pending protocol decision`; uma pendência substantiva bloqueia
o ramo afetado.

---

## 3. Interfaces externas e datas

Antes de derivar `A_M` ou `A_U`, o Goal 1 verifica, sem editar nem rederivar,
que `N3`, `N4` e as continuações públicas de `N7` exportam para cada célula e
registro atômico:

- instituição, crença de entrada, domínio e status de existência;
- estratégias, crenças e seleção ou multiplicidade admissível;
- payoff de `H` condicionado ao tipo realizado;
- payoffs fracos por papel e, quando necessário, por tipo realizado;
- distribuição de passagem com `H`, sem `H`, falha e atraso;
- data nativa de cada payoff;
- IDs, caminhos e SHA-256 exatos.

O Goal 1 deve auditar também se a interface `C_M` é realmente genérica no
quórum `q` ou se contém fórmulas especializadas. A auditoria não autoriza
extrapolação para quóruns intermediários.

Se faltar dimensão substantiva, o Goal para e registra o campo ausente e os
cálculos afetados. As alternativas são reabrir a interface produtora com nova
autorização ou reduzir o escopo. O predecessor nunca completa localmente uma
continuação não consumível.

### Regra contábil

Toda IC deve ser projeção da mesma árvore:

```text
tipo realizado + estado público + proposta + votos
-> posterior admissível
-> registro existente da continuação
-> outcome realizado
-> vetor de payoffs
-> expectativa calculada por último
```

Valores condicionados ao tipo não podem ser substituídos por médias ex ante.
Cada transporte de `C` para `A` aplica `beta` exatamente uma vez.

---

## 4. Nós e interfaces da extensão

### `A_M` — agenda privada sob maioria

Consome apenas `C_M`. Caracteriza a correspondência completa sob maioria em
todas as células e classes de estratégia permitidas.

### `A_U` — agenda privada sob unanimidade

Consome apenas `C_U`. É o nó central e recebe reconstrução cega exclusiva. Seu
domínio de entrada é `[0,1]`; existência e fronteiras são resultados.

### `AC` — comparação privada com agenda

Consome `A_M` e `A_U` congelados. Preserva primeiro cada regra separadamente,
depois forma o refinamento comum. Uma regra vazia não apaga a sobrevivente.
Compara tanto as correspondências baseline quanto, quando ativadas, as
correspondências sobreviventes ao trembling simétrico, sempre rotuladas.

### `AR` — benchmark público, rendas e interação

Consome `AC` e as continuações públicas de `N7`. Resolve o novo estágio com
`theta` público e só então calcula rendas informacionais, diferença entre
regras, imagem ex ante e eventual interação formalmente definida. É consumidor
terminal e não pode orientar a seleção dos jogos privados.

### Schema mínimo por equilíbrio

```text
equilibrium_id
institution
admissibility_conditions
proposal_strategy_by_type
weak_voting_strategy
belief_system_on_path
belief_system_off_path
source_continuation_record_ids
source_continuation_hashes
hegemon_payoff_by_type
weak_payoffs_by_role_and_realized_type
outcome_distribution
existence_uniqueness_status
selection_status
refinement_status
tremble_family_id
assumptions_used
checks_performed
payoff_date
```

Payoffs, crenças, estratégias e outcomes do mesmo equilíbrio permanecem no
mesmo registro atômico. Envelopes marginais não podem fabricar um equilíbrio.

---

## 5. Obrigações de prova

### P0 — Suficiência das continuações

Provar que as interfaces privadas e públicas retêm todos os estados relevantes.

### P1 — Forma extensiva e payoff comum

Construir uma única transição e função de payoff para todos os jogadores. Não
impor exaustão da pie por conveniência.

### P2 — Votos fracos no estágio de agenda

Derivar cada resposta sob as-if-pivotal e `T^Y`; não impor coalizão mínima.

### P3 — Crenças baseline

Aplicar Bayes on-path, no-signaling das ações fracas, consistência estrutural,
liberdade após desvio genuíno de `H` e suporte nos endpoints.

### P4 — Exaustividade das propostas

Testar pooling, separating, semi-pooling, mistura, acordo imediato, propostas
rejeitadas e atraso. A estratégia de espera não é ação primitiva.

### P5 — Fechamento contra continuação

Comparar tipo a tipo o acordo em `A` com `beta` vezes o payoff nativo de `C`.

### P6 — Existência e multiplicidade baseline

Caracterizar a correspondência completa, fronteiras, empates e segmentos sem
seleção silenciosa.

### P7 — Separação e imitação

Testar cada instituição e célula separadamente, incluindo separação por falha
sob maioria e semi-pooling com mistura.

### P8 — Comparação institucional

Comparar no mesmo ponto de parâmetros, primeiro por tipo e depois ex ante,
somente onde os objetos necessários existirem.

### P9 — Benchmark público e rendas

Resolver o estágio com tipo público sob as mesmas primitivas antes de calcular
qualquer renda por contrafactual.

### P10 — Células `none` de `C_U`

Registrar exatamente `nu=0`, `0<nu<=nu_star` e `nu_star<nu<=1` nas interfaces
herdadas. Não restringir ex ante o prior de `A_U`. Provar, para cada avaliação,
que toda continuação efetivamente exigida existe. Uma proposta informativa pode
evitar a célula vazia; uma crença ou tremble que a alcance pode destruir a
avaliação. Ambos são resultados.

### P11 — Quóruns intermediários

Nenhum vale em `q` pertence ao núcleo. Se mantido, rederivar toda a família em
Goal separado.

### P12 — Robustez e seleção simétrica

Para claims sensíveis à seleção, construir os jogos perturbados, provar ou
refutar existência de equilíbrios, caracterizar seus limites, verificar a
indução de crenças passivas e aplicar a construção canônica com Lebesgue
normalizada. D1 e Critério Intuitivo recebem ledger próprio e não substituem
esse exercício. Uma grade finita é apenas aproximação numérica.

---

## 6. Harness computacional em R

O harness vem depois do Gate 0 aprovado. Serve para falsificação, fronteiras e
auditoria contábil, não como prova de equilíbrio.

Arquivos candidatos:

- `scripts/agenda_extension_transition_payoffs.R`;
- `scripts/verify_agenda_extension_napkin.R`;
- `scripts/verify_agenda_extension_trembles.R`;
- `scripts/verify_agenda_extension_gate0.R`;
- `tests/testthat/test-agenda-extension-*.R`.

Invariantes mínimos:

- uma história terminal gera um único vetor de payoff;
- expectativas são recompostas de payoffs condicionados ao tipo;
- ações fracas não alteram crenças sobre `theta`;
- ações prescritas de `H` respeitam consistência estrutural;
- endpoints preservam suporte;
- `beta` entra uma vez de `C` para `A`;
- endpoints e cutoffs usam comparações exatas;
- células `none` não recebem sentinela de payoff;
- cada registro cita IDs e hashes existentes;
- trembles principais usam a mesma taxa e a mesma Lebesgue normalizada por tipo;
- átomos usam razões de massas e a parte não atômica usa razões de densidades;
- a grade numérica não altera a definição analítica nem introduz limite duplo;
- fórmulas falham fora de seus domínios.

Alvos prioritários de contraexemplo:

- screening ou pooling sob maioria quando `beta*o_1` torna a continuação de
  `H` suficientemente valiosa;
- semi-pooling em que um tipo mistura entre uma demanda de pooling e outra
  demanda;
- atraso sob unanimidade, incluindo como candidato a região
  `1-beta < beta^2*(o_1-o_0)`, sem presumir que a desigualdade seja suficiente;
- mudança de ranking quando o posterior entra em célula distinta de `C_U`;
- inexistência ou não unicidade do limite quando `epsilon` tende a zero.

O implementador salva o script antes de executá-lo. Revisão `review-r`
independente é obrigatória, sem substituir os pareceres matemáticos.

---

## 7. Goals, gates e ordem de execução

### Preflight — somente leitura

Verificar raiz Git, branch, `HEAD`, worktree, arquivos não rastreados, snapshot
revisado do manuscrito e hashes das interfaces externas. Não criar branch,
worktree, tag, commit ou artefato derivado sem autorização.

### Goal 0 — contrato executável da extensão

**Entregas:** forma extensiva, informação, primitivas do §2.5, protocolo de
trembling com Lebesgue normalizada, Bayes para átomos e densidades, topologia
do limite, estimandos, schema, DAG, ledger vazio, verifier e invalidação.

**Gate:** dois pareceres independentes read-only `PASS 0/0/0` no mesmo hash,
um de desenho formal e outro de teoria dos jogos; depois, GO explícito do autor
para o Goal 1.

### Goal 1 — consumibilidade e harness

**Entregas:** visões hashadas de `C_M`, `C_U` e continuações públicas de `N7`;
auditoria de `q`; ledger de datas; função comum de payoff; testes e relatório
de contraexemplos.

**Gate:** revisão R independente, revisão formal da suficiência e GO explícito.
Campo substantivo ausente interrompe o Goal.

### Goal 2 — `A_M`

**Entregas:** derivação baseline, interface, claim ledger, verifier e módulo de
robustez se acionado pelo §2.4.

**Gate:** dois `PASS 0/0/0` read-only no mesmo hash; se o módulo de trembling
for acionado, os pareceres cobrem também a família perturbada e seus limites;
depois, GO para o Goal 3.

### Goal 3 — `A_U`

**Entregas:** derivação baseline, interface, claim ledger, verifier e módulo de
robustez apenas onde acionado pelo §2.4.

**Tratamento especial:** ciclo exclusivo e ao menos uma reconstrução cega a
partir do contrato e de `C_U`, sem fórmulas candidatas prévias.

**Gate:** dois `PASS 0/0/0` read-only no mesmo hash; se o módulo de trembling
for acionado, os pareceres cobrem também a família perturbada e seus limites;
depois, GO para o Goal 4.

### Goal 4 — `AC`

**Entregas:** coleções privadas separadas, refinamento comum, contrastes por
tipo e ex ante, células vazias, multiplicidade atômica e comparação claramente
separada entre baseline e seleção simétrica, se existente.

**Gate:** dois pareceres read-only, incluindo integração dos hashes; GO.

### Goal 5 — `AR`

**Entregas:** jogos públicos, rendas por regra, diferença institucional, imagem
ex ante e interação apenas se formalmente definida.

**Gate:** ciclo exclusivo com dois `PASS 0/0/0`; decisão autoral dos resultados
que entram no paper.

### Goal Q — quóruns intermediários, opcional

Só abre por decisão autoral. Deve fechar antes da migração se qualquer claim ou
figura sobre o vale no quórum entrar no manuscrito.

### Goal 6 — migração e manuscrito

**Entregas:** matriz literal de sobrevivência, edição controlada de
`formal_model_v6.Rmd`, figuras autorizadas, PDF via YAML/bookdown, relatório de
integração e hashes exatos do Rmd e PDF.

**Gate:** revisão formal e revisão de exposição/visual por quem não editou.
Reparo muda hash e retorna às duas revisões. Commit, tag, push e mudança de
versão exigem autorização adicional.

---

## 8. Revisão, congelamento e invalidação

1. Implementador não revisa; revisor não edita.
2. Interface matemática congela apenas com dois `PASS 0/0/0` no mesmo SHA-256.
3. Parecer completo é salvo antes do resumo; findings não são truncados.
4. O default é escalar. Finding só é técnico quando um único reparo é forçado.
5. Mudança de bytes gera novo hash e retorna aos revisores do ciclo.
6. Mudança de `C_M` invalida `A_M`, `AC`, `AR` e consumidores editoriais.
7. Mudança de `C_U` invalida `A_U`, `AC`, `AR` e consumidores editoriais.
8. Mudança de `A_M` ou `A_U` invalida `AC`, `AR` e migração.
9. Mudança de contrato, conceito de solução, schema, tremble ou protocolo de
   revisão reabre o Gate 0.
10. Prontidão topológica nunca constitui autorização.
11. O ledger usa apenas `proved`, `checked numerically`, `conjecture`,
    `pending` ou `rejected`.

---

## 9. Migração narrativa — somente depois dos resultados

Depois de `AR` congelado e de decisão autoral:

- manter o resultado sem agenda como principal e tipo-contingente;
- apresentar a imagem ex ante como objeto derivado;
- afirmar interação entre agenda e informação apenas se definida e identificada;
- dizer em quais células, equilíbrios e seleções a agenda altera o ranking;
- reportar lado a lado a correspondência baseline e a seleção por tremble;
- não reaproveitar intuições refutadas como resultados;
- incluir o vale no quórum somente se Goal `Q` fechar;
- usar Steinberg para motivar agenda informal e assimetria informacional sem
  converter evidência histórica em prova do mecanismo;
- distinguir de Stone o contorno das regras do valor de agenda produzido pela
  própria regra formal;
- remover do paper a linguagem de versões, Goals e infraestrutura interna.

---

## 10. Arquivos previstos — ainda não autorizados

- `quality_reports/plans/2026-08-23_agenda_extension_gate0.md`;
- `model_redesign/agenda_extension_game_dag.json`;
- `model_redesign/agenda_extension_interfaces/*.json`;
- `model_redesign/agenda_extension_*_derivation.md`;
- `model_redesign/agenda_extension_*_claim_ledger.tsv`;
- `scripts/agenda_extension_transition_payoffs.R`;
- `scripts/verify_agenda_extension_gate0.R`;
- `scripts/verify_agenda_extension_napkin.R`;
- `scripts/verify_agenda_extension_trembles.R`;
- `tests/testthat/test-agenda-extension-*.R`;
- `quality_reports/YYYY-MM-DD_agenda_extension_*_review*.md`;
- `quality_reports/plans/YYYY-MM-DD_agenda_extension_migration_matrix.md`;
- `formal_model_v6.Rmd`, somente no Goal 6 autorizado;
- figuras da extensão, somente depois de resultado congelado.

---

## 11. Fechamento e próxima autorização

O feedback do Fable foi triado e as decisões do autor foram incorporadas. Este
plano está fechado como instrumento de planejamento. O próximo passo possível
é abrir o **Goal 0**, mas apenas mediante novo GO explícito do autor.

Até esse GO, não se inicia contrato executável, script, derivação, revisão de
nó, edição do paper, commit, tag ou push.
