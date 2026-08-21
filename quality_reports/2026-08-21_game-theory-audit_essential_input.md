# Game Theory Audit — Jogo essential-input e demonstrações disponíveis

**Data**: 2026-08-21
**Documento auditado**: `quality_reports/2026-08-21_essential_input_jogo_e_provas_disponiveis.md` (worktree codex/725d)
**Tipo de jogo**: barganha legislativa em dois rounds (variante Baron–Ferejohn com proponente fraco), com veto player privadamente informado (H, tipo binário), ballots simultâneos com registro público ex post, comparação maioria vs. unanimidade
**Referências canônicas**: Baron & Ferejohn (1989); stage-undominated voting (Baron–Kalai 1993; Austen-Smith & Banks); PBE com crenças off-path (Fudenberg–Tirole; Cho–Kreps para disciplina de crenças)
**Método**: dois passes independentes — (1) verificação linha a linha pelo auditor principal (Claude, sessão corrente); (2) agente adversarial independente (general-purpose, sem edição de arquivos), com perguntas dirigidas mas instrução explícita de refutar ou confirmar por rederivação própria. Os dois passes convergiram em todos os pontos centrais; uma divergência (feasibility em §10.7) foi resolvida a favor do agente adversarial (ver M-resolvido abaixo).
**Escopo**: apenas a matemática do documento de prova. Não audita o contrato Gate 0, não congela nós, não edita arquivos.

---

## Vereditos por nó

| Nó | Veredito | Uma linha |
|---|---|---|
| N1 (§7, R2 maioria) | **SOUND** | Álgebra e lógica corretas; falta declarar o passo m ≥ q para todo N ≥ 3. |
| N2 (§8, R2 unanimidade) | **SOUND** | ν* = (o₁−o₀)/(1−o₀), desempate e exaustividade das classes de oferta confirmados por rederivação. |
| N3 (§9, R1 maioria) | **SOUND WITH GAPS** | Todas as fórmulas, cutoffs, as onze células e os knife-edges rederivam corretamente; faltam a discussão de factibilidade orçamentária de S/P (reparável em um parágrafo) e o domínio de validade de ν_SP. |
| N4 (§10, R1 unanimidade) | **FLAWED como pacote** | Nenhuma construção isolada é internamente errada, mas §10.3, §10.4-necessidade, §10.5-exatidão e as duas metades do §10.4 exigem convenções *diferentes* de crenças off-path e de refinamento de votação. Sob o conceito literal de §2.5, a necessidade do §10.4 é falsa (contraexemplo explícito) e o piso B do §10.3 é falso para ν>ν*. §10.6 (m=2) usa limiares em A que contradizem o bound C do §10.3 para todo ν>0. |

O núcleo qualitativo de N4 — contabilidade condicionada ao tipo, exaustividade P/L/D em nível de resultado, impossibilidade de separação para ν>0, existência de atraso para m ≥ 3 — **sobrevive**. O que não sobrevive, como enunciado, são os limiares exatos (pisos, fronteiras, valor de segurança) e o rótulo "necessidade e suficiência".

---

## Checklist de condições (adaptado a barganha com veto player informado)

**Estrutura do jogo**
- [x] Primitivas completas: jogadores, tipos, prior ν, torta fixa 1, o_θ externo, β, ȳ, protocolo de ballot — declaradas em §2.
- [x] Espaço de propostas e restrições de factibilidade declarados (§2.2).
- [x] Protocolo de votação simultâneo com registro ex post, idêntico sob as duas regras (conforme contrato do projeto).
- [ ] **Timing de o_θ declarado como regra geral** — usado consistentemente (o_θ acumula na data em que o jogo termina), mas §2.4 dá a regra passa-sobre-o-não sem data; a assimetria (exclusão em R1 paga o_θ sem desconto; desacordo final paga β·o_θ do ponto de vista de R1) é escolha substantiva que deve ser explícita. Ver M6.

**Conceito de solução (§2.5)**
- [x] PBE declarado; Bayes on-path; T^Y; desempate anti-H declarados.
- [ ] **"Indiferença genuína" (domínio de T^Y) não definida** — e a definição é load-bearing. Ver M3.
- [ ] **"Crenças livres... respeitada a informação do jogo" ambígua** — as provas de N4 puxam essa cláusula em direções opostas. Ver C1–C4.
- [ ] **"Votação não dominada por estágio" ambígua entre duas leituras** — (i) não jogar votos fracamente dominados (admissibilidade, leitura padrão) vs. (ii) o voto jogado deve dominar fracamente a alternativa (primazia da linha pivotal, leitura mais forte). A necessidade do §10.4 só segue sob (ii); §2.5 declara (i). Ver C1.

**Indução retroativa e continuações**
- [x] Ordem de derivação respeita dependências (N1→N3, N2→N4); nenhum valor de continuação não resolvido foi importado.
- [x] Desconto aplicado exatamente uma vez nos valores de R2 usados em R1 (verificado em a_θ, A, B, ℓ, h, C, D).
- [x] N2 rederivável em posterior genérico η (interface reutilizada corretamente em N4).
- [x] Identidade (1−ν*)·A = B verificada por álgebra direta — é o que faz o piso B de §10.3 parecer natural sob uma convenção e falhar sob outra.

**Seleção entre continuações múltiplas**
- [ ] N4 prescreve continuações off-path (pooling vs. screening) por vetor de votos — legítimo sob crenças livres, mas a *mesma* liberdade que sustenta §10.5 destrói a necessidade de §10.4. Este é o defeito estrutural central. Ver C2–C3.

---

## Issues críticos (podem invalidar resultados enunciados)

### C1. §10.4 (necessidade, ν ≥ ν*): não segue do conceito de solução declarado — contraexemplo explícito

Sob a leitura literal de §2.5 (crenças livres em histórias de probabilidade zero + respondentes fracos não jogam votos *fracamente dominados* + T^Y), tome ν > ν* e um perfil multi-veto com x_k > B para um vetante k:

- O vetor on-path (k não, j não, resto sim) tem posterior ν por Bayes; continuação vale B para k.
- Prescreva, no vetor de probabilidade zero (k sim, j não, resto sim), uma crença η ≤ ν*. A continuação é o subjogo de screening de N2, que k — cuja crença própria continua ν, pois o desvio de k não informa k sobre θ — avalia em (1−ν)·A = D < B.
- Racionalidade sequencial: o desvio de k para sim paga D < B, logo "não" é resposta estritamente melhor para **qualquer** x_k.
- Dominância fraca: "sim" é estritamente melhor na linha pivotal (x_k > B), mas "não" é estritamente melhor na linha em que j veta (B vs. D). **Nenhum dos dois votos é fracamente dominado.** O perfil sobrevive.

Logo x_k ≤ B **não é necessário** sob §2.5. Dois sub-defeitos na prova escrita:

1. A frase "Bayes fixa a continuação fraca em C=B... Esse desvio paga ao menos B" é falsa sob crenças livres: o vetor pós-desvio tem probabilidade zero, Bayes não se aplica ali, e o desvio pode pagar D < B. O passo dos "subconjuntos sucessivos" afirma que todos os vetores de subconjuntos de veto "precisam entregar B" — nada em §2.5 fixa esses vetores.
2. O princípio operativo da própria prova — "Para sustentar não, é preciso que ele **domine fracamente** sim" — é um refinamento estritamente mais forte (primazia da linha pivotal / as-if-pivotal) do que o "votação não dominada" declarado. Mesmo com o pagamento do desvio fixado em B, o passo "na linha em que k se torna pivotal, não paga B e sim paga x_k, portanto x_k ≤ B" não segue da definição usual de stage-undominated voting.

**Reparo**: ou crenças passivas/no-signaling em todos os ballots de probabilidade zero, ou um refinamento as-if-pivotal declarado explicitamente em §2.5 — com os custos itemizados em C2–C4. Nota importante de escopo: como x_k nunca é pago em propostas rejeitadas, este defeito muda o *conjunto de perfis sustentáveis*, não os payoffs de equilíbrio da classe D; mas o enunciado "necessidade e suficiência" é matemática declarada e, como declarada, não está provada.

### C2. As duas metades do §10.4 usam convenções contraditórias entre si

A cláusula ν < ν* ("nenhuma restrição além da factibilidade") **exige** crenças livres literais: sustenta "não" para qualquer x_k atribuindo ao vetor de desvio a continuação pooling (valor B < D), o que é um salto de crença para *cima* de ν* depois de um desvio de um jogador *não informado*. A cláusula de necessidade em ν ≥ ν* **exige** o oposto: crenças fixadas em ν no vetor de desvio (senão o contraexemplo de C1). Nenhuma regra única de crenças entrega as duas cláusulas:

- Crenças livres literais: cláusula ν < ν* ✓, necessidade ✗.
- Crenças passivas/no-signaling: necessidade ✓ (com o refinamento forte, ou até com dominância fraca padrão, pois todas as linhas de falha ficam payoff-iguais), mas então em ν < ν* o desvio paga D e a linha pivotal impõe x_k ≤ D — restrição que o documento diz não existir.

### C3. §10.5 (exatidão de S₃ = (1−ν)·B): incompatível com qualquer reparo de C1 — **não existe convenção única sob a qual §10.4-necessidade e §10.5-exatidão valham simultaneamente**

A construção de §10.5 foi verificada como internamente consistente **sob crenças livres literais + leitura fraca (admissibilidade) da votação**: a punição (todos os fracos não; H0 não com continuação pooling; H1 sim com continuação screening) é incentive-compatible para H (H0: h > ℓ estrito; H1: h = h, T^Y → sim), dá ao proponente desviante o vetor realizado (B, 0), esperança (1−ν)·B; e qualquer proposta rejeitada garante ≥ (1−ν)·B porque continuações no estado 0 pagam no mínimo min{A,B} = B e no estado 1 pagam ≥ 0. A exatidão vale — **mas somente ali**, porque:

- Precisa da **crença invertida**: η ≤ ν* no vetor alcançado (dentro do perfil de punição) *somente por H1*. Qualquer convenção com consistência estrutural ou no-signaling força η = 1 nesse vetor, a continuação vira pooling, a punição colapsa para vetores tipo (A,B) ou (B,B), e o valor de segurança sobe estritamente acima de (1−ν)·B (todos esses valores são ≥ min{D,B} > (1−ν)·B).
- Precisa do refinamento **fraco** no ballot de punição. Sob o refinamento forte que salva §10.4 (aplicado uniformemente, como restrição de estratégia deve ser), os vetos de punição contra uma proposta desviante *generosa* (x_j > B para todos os respondentes, Y = h) são excluídos exatamente pelo argumento do §10.4, a proposta passa, e o proponente garante 1 − h − (m−1)·(piso), que excede (1−ν)·B numa região aberta de parâmetros (por exemplo, β moderado: 1 − β vs. (1−ν)·β(1−o₁)/m).

A reconciliação implícita do documento — "§10.4 restringe vetos on path; a punição está fora do caminho" — não é uma restrição de estratégia válida: stage-undominated voting está declarado (no documento e no contrato do projeto) como restrição sobre *estratégias*, e uma restrição de estratégia não pode valer num conjunto de informação apenas quando ele está no caminho de equilíbrio, porque o caminho é determinado pelo próprio perfil. Pode-se definir um refinamento sob medida, dependente do caminho ("votos jogados com probabilidade positiva devem dominar fracamente"), sob o qual §10.4 e §10.5 sobrevivem juntos — mas mesmo esse pacote contradiz §10.3 e a cláusula ν < ν* do §10.4 (ver C4), e não é o que §2.5 diz.

**Conclusão conjunta dos dois passes (auditor e agente adversarial, independentes): não existe convenção única, precisamente enunciada e aplicada uniformemente, sob a qual §10.4-necessidade, §10.5-exatidão, o piso uniforme de §10.3 e a cláusula ν<ν* do §10.4 valham ao mesmo tempo. Toda candidata (crenças livres + dominância fraca; crenças passivas + dominância fraca; crenças livres + as-if-pivotal; híbridos no-signaling-para-ações-fracas; dominância dependente do caminho) derruba pelo menos um resultado enunciado.** Este é o defeito estrutural central de N4 como pacote.

### C4. §10.3 (piso uniforme x_j ≥ B em classes de acordo): falso sob toda convenção candidata

O piso é igual à pior punição admissível no vetor pós-veto de probabilidade zero, e essa punição depende da convenção:

- **Crenças livres literais**: piso = min{D, B}. Correto (= B) para ν ≤ ν*; **errado para ν > ν***, onde a punição por screening paga ao desviante seu valor interino D < B (a aceitação em R2 depende do θ verdadeiro, e o desviante não atualizou a própria crença; o η̂ público só seleciona *qual* continuação, não a probabilidade interina de aceitação). Existem então equilíbrios de acordo com x_j ∈ [D, B) — a família de §10.7 fica incompleta e o payoff pooling ótimo do proponente fica subestimado (r_i pode chegar a 1 − h − (m−1)·D > 1 − h − (m−1)·B). Isso propaga para N6.
- **No-signaling (posterior fica em ν após desvio fraco)**: piso = C. Correto para ν ≥ ν*; **errado para ν < ν***, onde o piso é D > B e x_j = B é inatingível.

A afirmação do piso exato B precisa de crenças livres de um lado de ν* e fixadas do outro — a mesma incoerência de C2. **Reparo**: declarar a convenção e reenunciar o piso como min{D,B} (livres) ou C (no-signaling); B não é uniforme sob nenhuma.

Sobre a crença que sustenta punição exatamente B: é η > ν* no vetor pós-veto (continuação pooling). Para ν < ν*, isso é um salto de crença para cima após desvio de jogador que nada sabe de θ — crenças livres permitem, no-signaling proíbe.

### C5. §10.6 (m = 2): limiares em A contradizem o bound C do §10.3

Q_L = 1 − ℓ − A, Q_P = 1 − h − A e "R₀ é atingido em x = A" colocam o limiar de sustentabilidade do veto do respondente único em A. Mas a continuação-de-falha máxima sustentável para o respondente, pela própria maquinaria do documento, é max{D, B} = C (as únicas continuações disponíveis a um fraco não informado valem D ou B em termos interinos; a construção correlacionada ao tipo que entregaria A no estado 0 exige a atribuição H0-vetor→screening / H1-vetor→pooling, que *não* é incentive-compatible para H0, que desvia para obter h > ℓ). A = C somente em ν = 0. Portanto, para todo ν > 0, ou o bound de veto único x_k ≤ C do §10.3 está errado, ou os limiares em A do §10.6 estão. A passagem forçada deveria ler x > C com Q_P = 1 − h − C, e analogamente para Q_L. Os caps min{·, B} em R₀ e R_L são afirmados sem derivação. O documento já rotula a seção como provisória; o rótulo é merecido, e a discrepância A-vs-C deve ser o primeiro item da revisão fria de N4-v4.

---

## Issues médios (imprecisão de enunciado ou prova incompleta, provavelmente reparáveis)

**M1. §9 — factibilidade orçamentária de S e P nunca tratada.** Para o₀, o₁, q grandes, os pacotes violam o orçamento: por exemplo, N = 9 (q = 5, m = 8), o₀ = 0.95, β = 0.99 dá β·o₀ + β(q−2)/m ≈ 1.31 > 1, isto é, L < 0. O resultado sobrevive por uma propriedade de segurança demonstrável: S ≥ E força o₀ ≤ 1/m (e P ≥ E força o₁ ≤ 1/m), e nessas regiões os pacotes são automaticamente factíveis; logo max{E,S,P} nunca *seleciona* classe infactível. Mas essa implicação não está enunciada nem provada, e "max{E,S,P}" como escrito quantifica sobre valores de propostas possivelmente infactíveis. Um parágrafo repara.

**M2. §9.6 — denominador de ν_SP.** 1 − β·o₀ − β(q−1)/m pode ser negativo (N = 3, o₀ = 0.9, β = 0.99 dá ≈ −0.386). Na única região em que ν_SP é usado (o₁ ≤ 1/m, logo o₀ < 1/m) ele é provavelmente positivo (> 1 − β·q/m > 0), mas a restrição de domínio não está declarada.

**M3. "Indiferença genuína" (T^Y) não definida — e a definição é load-bearing.** N1/N2 usam T^Y sob identidade de payoffs contingência a contingência. O fechamento do §10.3 em x_j = B compara um pagamento certo com uma *loteria de reconhecimento* de média B — então "indiferença genuína" tem que significar igualdade de payoffs *esperados* (sobre θ e sobre o sorteio de reconhecimento de R2) em cada linha de votos dos demais, com T^Y aplicando somente sob equivalência completa de linhas. A suficiência do §10.4 depende exatamente dessa leitura (uma linha estrita off-path escapa do T^Y). Isso precisa estar em §2.5; como escrito, "indiferença genuína" não determina qual das duas leituras governa.

**M4. §10.4 — fechamento da fronteira falha no knife-edge ν = ν*.** Em ν = ν*, D = B, então *toda* continuação admissível paga exatamente B ao Estado fraco. Com x_k = B, os dois votos ficam payoff-equivalentes em toda linha, T^Y força "sim", e o multi-veto com x_k = B não é sustentável. "A construção inclui x_k = B; logo a fronteira é fechada" é falsa em ν = ν* (vale para ν > ν* sob a convenção operativa do documento, onde uma continuação-D fornece a linha estrita). Sob crenças passivas + dominância padrão (o reparo natural de C1), a fronteira fica aberta em x_k = B para *todo* ν ≥ ν*.

**M5. §10.2 — o passo de separação de H sob veto fraco é afirmado, não provado.** "Com veto fraco, o tipo alto de H vota sim" não é derivado. O lema necessário: votos separadores de H sob atraso com veto fraco são insustentáveis — H1-não/H0-sim falha porque H0 desvia para a continuação pooling (h > ℓ); H0-não/H1-sim falha simetricamente (T^Y quebra a indiferença de H1 para sim). Ambos verificados pelos dois passes; a conclusão de exaustividade em nível de resultado (P, L-em-ν=0, D) é correta — pass-iff-high é impossível exatamente como argumentado (Y < ℓ e Y ≥ h incompatíveis) — mas o texto da prova não contém o argumento de que precisa.

**M6. Convenção de timing de o_θ usada consistentemente, mas nunca declarada como regra.** O documento usa implicitamente: o_θ acumula na data em que o jogo termina — em R1 (sem desconto) quando uma proposta passa sobre o "não" de H em R1 (§9.7, exclusão paga (o₀, o₁)); em R2 (logo β·o_θ visto de R1) após rejeição em R1 (§9.3, cutoff β·o_θ). Internamente consistente em todos os pontos checados, incluindo N2. Mas §2.4 dá a regra passa-sobre-o-não sem data, e a assimetria (H coleta a opção externa um round antes quando excluído em R1 do que quando o screening atrasa) é escolha substantiva de modelagem que deve ser explícita — também porque interage com a formulação do contrato do projeto ("o_θ recebido ao fim do jogo").

**M7. §10.7 — famílias herdam C4.** Com o piso corrigido (min{D,B} sob crenças livres, ou C sob no-signaling), as famílias pooling e L como escritas ficam respectivamente incompletas ou parcialmente não sustentadas; o enunciado de desempate "r_i = S₃ exige Y = h" e a cláusula de m = 2 "exige Y ≤ H_tie" não podem ser avaliados antes de fixada a convenção.

**M-resolvido (registro de divergência entre os passes).** O auditor principal levantou preocupação de factibilidade orçamentária na família pooling de §10.7 (h + m·B + S₃ > 1 para β próximo de 1). O agente adversarial mostrou que a preocupação vem de contar m respondentes em vez de m−1 (o proponente não recebe x_j): Y = h mais (m−1)·B mais r_i = (1−ν)·B soma no máximo β·o₁ + β(1−o₁) = β < 1. **Não há gap**; a família pooling é sempre não vazia. Registrado para que ninguém reintroduza o falso alarme.

---

## Issues menores (defensáveis, mas devem ser reconhecidos)

1. **§7**: o passo 3 precisa do lema de uma linha m ≥ q para todo N ≥ 3 (apertado em N = 3, 4).
2. **§8**: o caso de fronteira ν = 1 (V_L = 0, rejeição também 0, V_P > 0) merece uma linha; nenhuma classe de oferta foi omitida (y < o₀ → 0 < V_P; y ∈ (o₀,o₁) dominado por o₀; y > o₁ dominado por o₁; rejeição deliberada dominada pois 1 − o₁ > 0). Desempate em ν* confirmado: (1−ν)o₀ + ν·o₁ < o₁.
3. **§9.6, linhas 8–11**: em ν = ν_SE com o₁ = 1/m há empate triplo S = E = P; o desempate para screening é correto ((1−ν)β·o₀ + ν·β·o₁ é menor que ambas as alternativas), mas deve ser computado, não afirmado (claim 5 da prova da partição).
4. **§10.1**: verificado integralmente, incluindo (1−ν*)·A = B (álgebra: (1−o₁)/(1−o₀) · β(1−o₀)/m = β(1−o₁)/m) e a continuidade de C em ν* dada a regra de desempate de N2.
5. **§10.7/§10.8**: verificados C > S₃ estrito para todo ν (ambos os ramos) e a igualdade de payoffs nos suportes das duas misturas (L/D em (ℓ, A) para ν = 0; P/D em (h, B) para ν > ν*, com H recebendo h nos dois suportes).
6. **§9**: não há abuso de crenças off-path em N3 — corretamente, porque a continuação de R2-maioria (N1) é livre de crenças, o que é exatamente o que torna o lema de cutoff legítimo sob maioria e ilegítimo de transplantar para unanimidade.
7. **§10.3, veto único**: o bound x_k ≤ C é robusto — a linha pivotal é *on path* nesse caso, Bayes fixa a continuação em C; verificado pelos dois passes. (O "incluindo a igualdade" em ν > ν* depende da leitura de T^Y de M3 mais linhas H-não off-path; funciona sob a leitura precisa, mas deve ser escrito.)

---

## Sugestões de formalização em Lean 4

Sem alvo Lean ativo enquanto a cadeia essential-input não estabilizar (regra do projeto). Quando estabilizar, a triagem é:

| Componente | Formalizável? | Dificuldade | Observação |
|---|---|---|---|
| N2: cutoff ν*, ν* ∈ (0,1), desempate | Sim | Fácil | field_simp + linarith |
| Identidade (1−ν*)·A = B | Sim | Trivial | Fecha a porta a regressões no piso de §10.3 |
| N3: E−R > 0, sinais de P−E e S−E, fórmulas ν_SP/ν_SE | Sim | Fácil | linarith/nlinarith |
| N3: lema de segurança de factibilidade (L < 0 → o₀ > 1/m → S < E; P < 0 → P < E) | Sim | Fácil–Médio | Repara M1 com garantia mecânica |
| N3: partição das onze células (análise de casos) | Sim | Médio | rcases + linarith por célula |
| N4: pisos/fronteiras (§10.3–§10.5) | **Não por enquanto** | — | Dependem da convenção de crenças a fixar em §2.5; formalizar antes disso congelaria a ambiguidade |
| PBE/crenças off-path em geral | Não (sem infraestrutura) | Muito difícil | Fora do escopo, como já documentado no projeto |

---

## Recomendações de edição (para a próxima iteração da derivação; nenhuma edição feita nesta auditoria)

1. **§2.5 — reescrever o conceito de solução com três definições precisas** (pré-requisito para qualquer rederivação de N4):
   (i) o sentido exato de "votação não dominada por estágio" (admissibilidade padrão vs. as-if-pivotal — são diferentes e as provas atuais usam ambos);
   (ii) o domínio de T^Y (proposta concreta: contingências = vetores de voto × θ, payoffs = valores esperados de continuação integrando a loteria de reconhecimento; T^Y aplica somente sob equivalência completa);
   (iii) a regra de crenças em histórias de probabilidade zero (escolher UMA: livres literais, ou no-signaling com consistência estrutural — e dizer o que "respeitada a informação do jogo" significa operacionalmente, inclusive para desvios de voto de H, que é informado).
2. **§10.4 e §10.5 — rederivar sob a convenção escolhida**, aceitando que pelo menos um dos dois muda de enunciado: sob crenças livres, a necessidade do multi-veto cai (e o piso de §10.3 vira min{D,B}); sob no-signaling/consistência, S₃ = (1−ν)·B deixa de ser exata (a segurança sobe) e o piso vira C. Não existe redação que preserve os dois como estão.
3. **§10.3 — reenunciar o piso** conforme a convenção (min{D,B} ou C), e reescrever as famílias de §10.7 em conformidade (M7).
4. **§10.6 (m = 2) — corrigir a discrepância A-vs-C** (C5) antes de qualquer uso; derivar os caps min{·,B} em vez de afirmá-los.
5. **N3 — três reparos pequenos e o nó fica pronto para proposição**: parágrafo de factibilidade (M1), domínio de ν_SP (M2), cálculo explícito do desempate triplo (menor 3). Adicionalmente declarar o timing de o_θ como regra (M6) — vale para o documento inteiro.
6. **§10.2 — incluir o lema anti-separação de H sob veto fraco** (M5); o argumento existe e foi verificado, só não está escrito.
7. **Escalação conforme contrato do projeto**: pelos critérios do Gate 0 ("findings escalam por default; toda ambiguidade e toda definição faltando escalam, sem exceção"), C1–C5 e M3 escalam. Nenhum deles admite "exatamente um reparo forçado pelo que já está escrito" — a escolha da convenção em §2.5 é decisão de desenho do autor, não reparo técnico.

---

## Apêndice A — Report integral do agente adversarial (segundo passe, verbatim)

# ADVERSARIAL VERIFICATION REPORT — `2026-08-21_essential_input_jogo_e_provas_disponiveis.md`

## VERDICTS

- **N1 (§7): SOUND.** Algebra and logic check out; one implicit step (m ≥ q for all N ≥ 3) should be stated.
- **N2 (§8): SOUND.** nu_star, tie-break, and offer-class exhaustiveness all verified.
- **N3 (§9): SOUND WITH GAPS.** All formulas, cutoffs, the eleven cells, and knife-edges rederive correctly; budget feasibility of S/P is never addressed (repairable), and nu_SP's domain of validity is unstated.
- **N4 (§10): FLAWED.** Not because any single construction is internally wrong, but because §10.3, §10.4-necessity, §10.5-exactness, and the two halves of §10.4 each require a *different* belief/refinement convention. Under the solution concept as literally stated in §2.5, §10.4-necessity is false (explicit counterexample below) and §10.3's uniform floor B is false for nu > nu_star. §10.6 uses thresholds in A that contradict §10.3's C-bound for all nu > 0.

## CRITICAL ISSUES

### C1. §10.4 necessity fails under the stated solution concept (§2.5). Counterexample exists.

§2.5 states: free beliefs at zero-probability histories + weak responders may not play *weakly dominated* votes + T^Y at genuine indifference. Under this literal concept, take nu > nu_star and a multi-veto profile with x_k > B for a vetoer k:

- On-path vector (k no, j no, rest yes) has posterior nu (Bayes), continuation B to k.
- Prescribe, at the zero-probability vector (k yes, j no, rest yes), a belief eta ≤ nu_star. Then the continuation is the N2 screening subgame, which k — whose own belief is still nu, since k's deviation is uninformative to k — values at (1-nu)A = D < B.
- Sequential rationality: k's deviation to yes pays D < B, so "no" is a strict best response for **any** x_k.
- Weak dominance: "yes" is strictly better in the pivotal row (x_k > B ≥ any continuation), but "no" is strictly better in the row where j vetoes (B vs D). **Neither vote is weakly dominated.** The profile survives.

Hence x_k ≤ B is *not* necessary under §2.5. The proof's own operative principle — "Para sustentar não, é preciso que ele **domine fracamente** sim" — is a strictly stronger refinement (played vote must weakly dominate the alternative, i.e., pivotal-row primacy / as-if-pivotal voting) than §2.5's "votação não dominada" (played vote must not be weakly dominated). The lemma is FLAWED as a consequence of the stated concept; it is repairable only by changing §2.5 (see C3 for the cost).

Also note: the phrase in the proof "Bayes fixa a continuação fraca em C=B... Esse desvio paga ao menos B" is false under free beliefs — the deviation vector has probability zero and can pay D < B. The "successive subsets" step asserts that all non-empty veto-subset vectors "precisam entregar B"; nothing in §2.5 pins those zero-probability vectors. Under the strong (as-if-pivotal) refinement this entire detour is unnecessary — the pivotal row plus the bound (continuation values ∈ {D, B} ≤ B for nu ≥ nu_star) suffices.

### C2. The two halves of §10.4 use contradictory conventions.

The nu < nu_star clause ("nenhuma restrição além da factibilidade") **requires** literal free beliefs: it sustains "no" for any x_k by assigning the pooling continuation (value B < D) to the deviation vector — a belief jump *above* nu_star after a deviation by an *uninformed* player. The nu ≥ nu_star necessity clause **requires** the opposite: beliefs at the deviation vector pinned at nu (else C1's counterexample). No single belief rule delivers both clauses. Under literal free beliefs: nu < nu_star clause ✓, necessity ✗. Under no-signaling/passive beliefs: necessity ✓ (with the strong refinement or even standard weak dominance, since all fail-rows become payoff-equal), but then for nu < nu_star the deviation vector pays D and the pivotal row imposes x_k ≤ D — a restriction the document says does not exist.

### C3. §10.5 exactness of S_3 = (1-nu)B is incompatible with any repair of C1. No single convention supports both §10.4-necessity and §10.5-exactness.

I verified §10.5 is internally consistent **under literal free beliefs + the weak (not-weakly-dominated) reading**: the punishment (all weak no; H0 no with pooling continuation; H1 yes with screening continuation) is incentive-compatible for H (H0: h > ell strict; H1: h = h, T^Y → yes), gives the deviant proposer (B, 0), expected (1-nu)B; and any rejected proposal guarantees ≥ (1-nu)B because state-0 continuations pay min{A,B} = B and state-1 continuations pay ≥ 0. Exactness holds. But:

- It needs the **inverted belief**: eta ≤ nu_star at the vector reached (within the punishment profile) *only by H1*. Any structural-consistency or sequential-equilibrium-style convention forces eta = 1 there, the punishment collapses to (A,B)- or (B,B)-type vectors, and the security value rises strictly above (1-nu)B (all such values are ≥ min{D,B} > (1-nu)B).
- It needs the **weak** voting refinement at the punishment ballot. Under the strong refinement that rescues §10.4 (applied uniformly, as a strategy restriction must be), the punishment vetoes against a *generous* deviant proposal (x_k > B for all responders, Y = h) are excluded by exactly the §10.4 argument, the proposal passes (single vetoes are barred by x_k ≤ C < x_k; H accepts at Y = h by T^Y), and the proposer secures 1 − h − (m−1)·(floor) which exceeds (1-nu)B for a large open parameter region (e.g., any moderate beta: 1 − beta vs (1-nu)beta(1−o_1)/m).

The document's own reconciliation — "§10.4 restringe vetos **on path**; a punição está **fora do caminho**" — is not a valid strategy restriction: stage-undominated voting is declared (here and in the project contract) as a restriction on *strategies*, and a strategy restriction cannot apply at an information set only when that set is on the equilibrium path, because the path is itself determined by the strategy profile. One can define a bespoke path-dependent refinement ("votes played with positive probability must weakly dominate"), under which §10.4 and §10.5 both survive — but even that package contradicts §10.3 and §10.4's nu<nu_star clause (see C4), and it is not what §2.5 says.

**Direct answer to 3(e): NO — there is no single, uniformly applied belief convention plus voting refinement under which §10.4-necessity, §10.5-exactness, §10.3's uniform floor, and §10.4's nu<nu_star clause all hold. Every candidate (literal free beliefs + weak dominance; full passive beliefs + weak dominance; free beliefs + as-if-pivotal; no-signaling-for-weak-actions hybrids; path-dependent dominance) flips at least one stated result.** This is the key structural defect of N4 as a package.

### C4. §10.3's uniform floor x_j ≥ B ("o menor valor") is wrong under every candidate convention.

The floor equals the worst admissible punishment at the zero-probability post-veto vector, and that punishment is convention-dependent:

- **Literal free beliefs:** floor = min{D, B}. Correct (= B) for nu ≤ nu_star; **wrong for nu > nu_star**, where the screening punishment pays the deviator its interim value D < B, so agreement equilibria with x_j ∈ [D, B) exist — the family in §10.7 is then incomplete, and the proposer-optimal pooling payoff is understated (r_i can reach 1 − h − (m−1)D > 1 − h − (m−1)B). This propagates to N6.
- **No-signaling (posterior stays nu after a weak deviation):** floor = C. Correct for nu ≥ nu_star; **wrong for nu < nu_star**, where the floor is D > B and x_j = B is unattainable.

The exact-floor-B claim thus needs free beliefs on one side of nu_star and pinned beliefs on the other — the same incoherence as C2. Repair: state the convention, then restate the floor as min{D,B} (free) or C (no-signaling); B is uniform under neither.

Answer to the belief question in 3(c): the belief supporting punishment exactly B is eta > nu_star at the post-veto vector (pooling continuation). For nu < nu_star this is an upward belief jump after a deviation by a player who knows nothing about theta — free beliefs permit it, no-signaling forbids it.

### C5. §10.6 (m = 2) thresholds contradict §10.3.

Q_L = 1 − ell − A and Q_P = 1 − h − A, and "R_0 é atingido em x = A", place the responder's veto-sustainability threshold at A. But the maximum sustainable fail-continuation for the lone responder, by the document's own machinery, is max{D, B} = C (the only continuation values available to an uninformed weak state are D and B; the type-correlated construction that would deliver A in state 0 requires the H-assignment H0-vector→screening / H1-vector→pooling, which is *not* incentive-compatible for H0, who deviates to obtain h > ell). A = C only at nu = 0. So for every nu > 0, either §10.3's single-veto bound x_k ≤ C or §10.6's A-thresholds is wrong; forced-passage should read x > C with Q_P = 1 − h − C, and similarly for Q_L. The min{·, B} caps in R_0 and R_L are asserted without derivation. The document flags this section as provisional; the flag is warranted, and the specific A-vs-C discrepancy should be the first item checked in the cold review of v4.

## MEDIUM ISSUES

**M1. §9 — budget feasibility of S and P never addressed (question 2(a)).** For large o_0, o_1, q the packages violate the budget: e.g., N = 9 (q = 5, m = 8), o_0 = 0.95, beta = 0.99 gives beta·o_0 + beta(q−2)/m ≈ 1.31 > 1, i.e., L < 0. The result survives: S ≥ E forces (1−nu)beta(1/m − o_0) ≥ nu(1 − beta q/m) ≥ 0, hence o_0 ≤ 1/m, hence beta[o_0 + (q−2)/m] ≤ beta(q−1)/m < 1; symmetrically P ≥ E forces o_1 ≤ 1/m. So max{E,S,P} never *selects* an infeasible class — but this implication is nowhere stated or proved, and "max{E,S,P}" as written quantifies over values of possibly infeasible proposals. One paragraph repairs it.

**M2. §9.6 — nu_SP's denominator (question 2(b)).** 1 − beta·o_0 − beta(q−1)/m can be negative (e.g., N = 3, o_0 = 0.9, beta = 0.99 gives −0.386). Within the only region where nu_SP is used (o_1 ≤ 1/m, hence o_0 < 1/m), it is provably positive (> 1 − beta·q/m > 0), but the domain restriction is unstated.

**M3. "Genuine indifference" for T^Y is undefined, and the definition is load-bearing.** N1/N2 use T^Y under contingency-by-contingency payoff identity. §10.3's closure at x_j = B compares a sure payment against a recognition *lottery* with mean B — so "genuine indifference" must mean equality of *expected* payoffs (over theta and R2 recognition) in every row of others' votes, with T^Y applying only under full row-equivalence. §10.4's sufficiency relies on precisely this reading (a strict off-path row escapes T^Y). This must be stated in §2.5; as written, "indiferença genuína" does not determine which of the two readings governs.

**M4. §10.4 boundary closure fails at the knife-edge nu = nu_star.** At nu = nu_star, D = B, so *every* admissible continuation pays a weak state exactly B. With x_k = B, the two votes are then payoff-equivalent in every row, T^Y forces "yes", and the multi-veto with x_k = B is not sustainable. The claim "A construção inclui x_k = B; logo a fronteira é fechada" is false at nu = nu_star (it holds for nu > nu_star under the document's operative convention, where a D-continuation supplies the strict row). Note also that under passive beliefs + standard dominance (the natural repair of C1) the boundary is open at x_k = B for *all* nu ≥ nu_star.

**M5. §10.2 — the weak-veto/H-separation step is asserted, not proved.** "Com veto fraco, o tipo alto de H vota sim" is not derived. The needed lemma is: H-separating votes under weak-veto delay are unsustainable — H1-no/H0-yes fails because H0 deviates to the pooling continuation (h > ell); H0-no/H1-yes fails symmetrically. I verified both, so the exhaustiveness conclusion (outcome classes P, L-at-nu=0, D) is correct at outcome level — pass-iff-high is impossible exactly as argued (Y < ell and Y ≥ h incompatible) — but the proof text does not contain the argument it needs.

**M6. o_theta timing convention is used consistently but never stated as a rule (question 2(c)).** The document implicitly uses: o_theta accrues at the date the game ends — at R1 (undiscounted) when a proposal passes over H's "no" at R1 (§9.7 exclusion payoffs (o_0, o_1)); at R2 (hence beta·o_theta from R1) after R1 rejection (§9.3 cutoff beta·o_theta; §9.1 a_theta). Internally consistent everywhere I checked, including N2 (terminal o_theta undiscounted within-round). But §2.4 states the passes-over-no rule without a date, and the asymmetry (H collects the outside option a round earlier when excluded at R1 than when screening delays) is a substantive modeling choice that should be explicit, also because it interacts with the project contract's "o_theta recebido ao fim do jogo".

**M7. §10.7 families inherit C4.** With the floor corrected (min{D,B} under free beliefs, or C under no-signaling), the pooling and L families as written are respectively incomplete or partially unsupported; the tie-break statement "r_i = S_3 exige Y = h" and the m = 2 clause "exige Y ≤ H_tie" cannot be evaluated until the convention is fixed.

## MINOR ISSUES

1. **§7:** step 3 needs the one-line lemma m ≥ q for all N ≥ 3 (tight at N = 3, 4).
2. **§8:** the boundary case nu = 1 (V_L = 0, rejection also 0, V_P > 0) deserves a line; no offer class is missed (y < o_0 → 0 < V_P; y in (o_0, o_1) dominated by o_0; y > o_1 dominated by o_1; deliberate rejection dominated since 1 − o_1 > 0). Tie-break at nu_star confirmed: (1−nu)o_0 + nu·o_1 < o_1.
3. **§9.6, rows 8–11:** at nu = nu_SE with o_1 = 1/m there is a triple tie S = E = P; the tie-break to screening is correct ((1−nu)beta·o_0 + nu·beta·o_1 < both alternatives) but should be computed, not asserted (claim 5).
4. **§10.1:** verified in full, including (1 − nu_star)·A = B (algebra: (1−o_1)/(1−o_0) · beta(1−o_0)/m = B) and continuity of C at nu_star given N2's tie-break.
5. **§10.7 feasibility (question 3(g)):** *no gap.* With m−1 responders (proposal syntax §2.2), Y = h plus (m−1)B plus r_i = (1−nu)B totals at most beta·o_1 + beta(1−o_1) = beta < 1. The concern "h + m·B + S_3 > 1" only arises if one miscounts responders as m. Also verified: C > S_3 strictly for all nu (both branches), and both §10.8 mixtures are payoff-equal on their supports (L/D at (ell, A) for nu = 0; P/D at (h, B) for nu > nu_star, H getting h under both).
6. **§9:** no off-path belief abuse in N3 — correctly so, because the R2-majority continuation (N1) is belief-free, which is exactly what makes the weak-dominance cutoff lemma legitimate under majority and illegitimate to transplant to unanimity.
7. **§10.3 single-veto bound x_k ≤ C:** robust — the pivotal row is *on path* there, Bayes pins the continuation at C; verified.

## EXPLICIT ANSWERS TO 3(d) AND 3(e)

**3(d).** Both concerns in the question are confirmed. (i) Under the literal §2.5 convention, the equilibrium can prescribe a screening continuation (eta ≤ nu_star) at the zero-probability post-switch vector; the deviator, whose own belief remains nu, values it at D = (1−nu)A < B when nu > nu_star, so "no" is a strict best response for any x_k, and the claimed necessity x_k ≤ B fails — see C1 for the full counterexample. "Respeitada a informação do jogo" rescues necessity only if it is read as no-signaling-what-you-don't-know *and* extended to pin beliefs at vectors differing in **H's** off-path vote as well (H is informed, so no-signaling does not naturally cover H's actions; if H-deviation rows keep free beliefs, they supply the strict row that protects "no" from weak dominance). (ii) Even with the deviation payoff pinned at B, the pivotal-row step does **not** follow from stage-undominated voting as usually defined: with x_k > B, "yes" is strict in the pivotal row and "no" is strict in a suitably constructed off-path row, so neither vote is weakly dominated. The proof's own sentence "é preciso que ele domine fracamente sim" reveals that the operative refinement is pivotal-row-primacy / played-vote-weak-dominance — strictly stronger than §2.5. Verdict on the lemma as stated: **FLAWED** (necessity direction), repairable by either full passive beliefs at all zero-probability ballots or an explicitly stated as-if-pivotal refinement, at the costs itemized in C2–C4.

**3(e).** Confirmed, and it is the central finding: **no single, uniformly applied convention supports both §10.4-necessity and §10.5-exactness** — nor, a fortiori, those two plus §10.3's uniform floor and §10.4's nu<nu_star clause. Literal free beliefs + not-weakly-dominated: §10.5 exact, §10.4-necessity false, §10.3 floor false for nu > nu_star. Passive/no-signaling beliefs: §10.4-necessity true (boundary open at x_k = B), §10.5 punishment collapses (the H1-only vector forces pooling, security rises strictly above (1−nu)B), §10.3 floor becomes C. Free beliefs + as-if-pivotal voting applied uniformly: §10.4 true, §10.5 exactness false (generous deviant proposals cannot be vetoed and force passage at 1 − h − (m−1)·floor > (1−nu)B on an open region). The only package that saves §10.4 and §10.5 simultaneously is a *path-dependent* dominance requirement ("on-path votes must weakly dominate"), which contradicts the declared status of stage-undominated voting as a strategy restriction, and still leaves §10.3 and the nu<nu_star clause wrong. N4 must fix one convention in §2.5 and rederive §10.3, §10.4, §10.5, §10.6 and the §10.7 families under it; the results will genuinely change (floors, boundary closures, and possibly the security value) depending on the choice.

---

*Fim do parecer. Nenhum arquivo do modelo foi editado. Este parecer não congela nós nem autoriza derivação; a escolha de convenção em §2.5 é decisão do autor (escala conforme o contrato Gate 0).*
