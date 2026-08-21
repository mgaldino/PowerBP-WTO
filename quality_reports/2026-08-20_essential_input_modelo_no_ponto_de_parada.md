# Modelo *essential-input* no ponto de parada

**Data do registro:** 20 de agosto de 2026  
**Decisão autoral:** documentar o modelo alcançado e interromper o trabalho  
**Contrato governante:** [`plans/2026-08-12_essential_input_gate0.md`](plans/2026-08-12_essential_input_gate0.md)  
**DAG canônico:** [`../model_redesign/essential_input_game_dag.json`](../model_redesign/essential_input_game_dag.json)

## 1. Finalidade e estatuto deste documento

Este documento registra, sem nova derivação, o modelo *essential-input* no ponto exato em que o autor determinou a interrupção. Ele reúne apenas primitivas, resultados, correções e pareceres já existentes no repositório.

Há uma distinção de ciclo de vida que deve ser preservada em toda leitura futura:

- `N1` e `N2` estão **PASS/frozen** no DAG canônico e podem ser consumidos pelas dependências autorizadas.
- A matemática mais recente de `N3` foi rederivada e confirmada nos pareceres frios, mas seu pacote de certificação semântica não foi concluído. `N3` continua **pending/unfrozen** e não pode ser consumido por `N6`.
- A matemática mais recente de `N4` incorpora a correção *type-conditioned* e a correção localizada de múltiplos vetos, mas não existe candidato `N4-v4` completo, certificado ou congelado. `N4` continua **pending/unfrozen** e não pode ser consumido por `N6`.
- `N6` e `N7` não foram iniciados sob dependências válidas.
- `N5` foi removido da arquitetura: entrada não é um nó do DAG atual.

Este registro não congela nenhum nó, não promove intermediários, não altera interfaces públicas e não substitui os dois pareceres independentes exigidos para o fechamento de `N3` ou `N4`.

## 2. Primitivas e notação do jogo

### 2.1 Jogadores, estado e informação

- Há `N >= 3` Estados: um hegemon `H` e `m = N - 1` Estados fracos, reunidos no conjunto `W`.
- A natureza sorteia o tipo do hegemon `theta in {0,1}` no início do jogo.
- A crença pública inicial é `nu = Pr(theta=1)`.
- `H` observa seu próprio tipo no tempo zero. Os Estados fracos nunca observam `theta` diretamente.
- O jogo tem dois rounds. O segundo round é terminal.

### 2.2 Propostas e factibilidade

Em cada round, somente um Estado fraco pode ser reconhecido como proponente. A probabilidade de reconhecimento de `H` é zero em todos os rounds. Cada Estado fraco é reconhecido com probabilidade `1/m`, independentemente entre rounds e com reposição; todos continuam elegíveis no segundo round.

Uma proposta de um proponente fraco `i` é um pacote

`s = (y, (x_j)_{j in W\{i}}, r_i)`,

em que:

- `y` é a parcela destinada a `H`;
- `x_j` é a parcela destinada ao respondente fraco `j`;
- `r_i` é o resíduo retido pelo proponente;
- `0 <= y <= y_bar`, `x_j >= 0`, `r_i >= 0`;
- `y + sum_j x_j + r_i <= 1`.

A unidade disponível é uma torta fixa de tamanho `1`. Ela não depende do tipo de `H` nem da inclusão de `H`. Não há pagamentos laterais fora desse pacote.

### 2.3 Opções externas, desconto e limites paramétricos

- O benefício direto adicional de um acordo para `H` é normalizado em `b_theta = 0`.
- O payoff de desacordo dos Estados fracos é zero.
- O payoff externo de desacordo de `H` é `o_theta`, com

  `0 < o0 < o1 < 1` e `o1 <= y_bar <= 1`.

- O fator de desconto satisfaz estritamente `0 < beta < 1`.

As duas desigualdades estritas destacadas pelo contrato — `beta < 1` e `o1 < 1` — são parte do domínio vigente. O caso `beta=1` e a fronteira degenerada `o1=1` não pertencem ao modelo aqui registrado.

O desconto é aplicado exatamente uma vez quando valores de continuação do segundo round entram nos incentivos do primeiro round. Não se aplica `beta` internamente aos payoffs terminais do segundo round.

### 2.4 Regra de votação

O proponente conta como voto favorável. Todos os demais Estados — inclusive `H` — votam simultaneamente `sim` ou `não` em urna fechada. Nenhum votante observa os votos correntes dos demais. Somente depois de todos os votos o vetor completo e o resultado se tornam públicos.

Não há voto sequencial nominal, ação de saída ou veto que retire permanentemente `H` do jogo.

- Sob maioria, a quota é `q = floor(N/2) + 1`.
- Sob unanimidade, a quota é `N`.

Se uma proposta passa no primeiro round, o jogo termina. Se falha, o jogo segue para o segundo round. Se também falha no segundo round, os Estados fracos recebem zero e `H` recebe `o_theta`.

Quando uma proposta aprovada inclui `H`, os payoffs correntes são `y` para `H`, `r_i` para o proponente e `x_j` para cada respondente fraco. Sob maioria, uma proposta pode passar sem o voto de `H`; nesse caso, `H` recebe `y + o_theta`, com `o_theta` externo à torta institucional, e os payoffs fracos permanecem os componentes da proposta.

### 2.5 Conceito de solução e desempates

O conceito vigente é equilíbrio bayesiano perfeito (`PBE`) com estratégias puras de votação e votação não dominada por estágio para os respondentes fracos. A restrição de não dominância não se aplica a `H`.

- Crenças *on path* obedecem a Bayes sempre que o histórico tem probabilidade positiva.
- Crenças após propostas fora do caminho podem ser irrestritas, respeitada a estrutura informacional.
- Um desvio do proponente é avaliado sob a distribuição verdadeira anterior à proposta, não sob uma crença escolhida pelo próprio desviador.
- A convenção `T^Y` seleciona `sim` apenas em uma indiferença genuína no conjunto de informação. Ela não substitui a eliminação de ações estritamente dominadas.
- Entre propostas que maximizam o payoff do proponente, o desempate seleciona a que minimiza o payoff esperado de `H`.

A expressão “avaliação de voto fraco passivo” não cria uma nova primitiva nem um refinamento. Ela só pode nomear uma propriedade informacional efetivamente demonstrada.

## 3. Resultado congelado de N1: segundo round sob maioria

**Interface congelada:** [`../model_redesign/essential_input_interfaces/n1_r2_majority_candidate_v1.json`](../model_redesign/essential_input_interfaces/n1_r2_majority_candidate_v1.json)  
**Derivação:** [`../model_redesign/essential_input_n1_r2_majority_derivation.md`](../model_redesign/essential_input_n1_r2_majority_derivation.md)  
**Hash da interface:** `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`

No segundo round sob maioria:

1. Um respondente fraco vota `sim` quando `x_j > 0`. Em `x_j=0`, há indiferença genuína e `T^Y` seleciona `sim`.
2. Os Estados fracos conseguem atingir sozinhos a quota de maioria.
3. `H` é não pivotal e prefere estritamente votar `não`, pois recebe `y + o_theta` sem participar e apenas `y` se participar.
4. A proposta ótima e única é

   `y=0`, `x_j=0` para todos os respondentes fracos e `r_i=1`.

5. A proposta passa sem `H` com probabilidade um.

Payoffs terminais:

- proponente reconhecido: `1`;
- valor fraco antes do reconhecimento: `1/m`;
- `H` do tipo `theta`: `o_theta`.

Não há desconto dentro desse round terminal. Estratégias, resultado e payoffs são únicos. Pode restar arbitrariedade em crenças fora do caminho que seja irrelevante para payoffs.

## 4. Resultado congelado de N2: segundo round sob unanimidade

**Interface congelada:** [`../model_redesign/essential_input_n2_r2_unanimity_interface.json`](../model_redesign/essential_input_n2_r2_unanimity_interface.json)  
**Derivação:** [`../model_redesign/essential_input_n2_r2_unanimity_derivation.md`](../model_redesign/essential_input_n2_r2_unanimity_derivation.md)  
**Hash da interface:** `sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`

Defina

`nu_star = (o1-o0)/(1-o0)`.

Como `0 < o0 < o1 < 1`, vale `0 < nu_star < 1`.

No segundo round sob unanimidade:

1. Todos os respondentes fracos votam `sim` depois de qualquer proposta factível: `x_j>0` torna `sim` estritamente melhor, e `x_j=0` é resolvido por `T^Y`.
2. `H` é pivotal. O tipo `theta` vota `sim` se, e somente se, `y >= o_theta`.
3. O proponente compara duas opções relevantes:

   - oferta apenas ao tipo baixo: `y=o0`, `x_j=0`, `r_i=1-o0`, payoff esperado `(1-nu)(1-o0)`;
   - *pooling*: `y=o1`, `x_j=0`, `r_i=1-o1`, payoff `1-o1`.

4. Em `nu=nu_star`, os payoffs do proponente empatam e o desempate que minimiza o payoff esperado de `H` seleciona a oferta apenas ao tipo baixo.

A correspondência congelada tem dois regimes:

- Se `0 <= nu <= nu_star`, a proposta é aceita apenas pelo tipo baixo. Os payoffs de `H` são `(o0,o1)`, a probabilidade de aprovação com `H` é `1-nu`, a probabilidade de fracasso terminal é `nu`, e o valor fraco antes do reconhecimento é `(1-nu)(1-o0)/m`.
- Se `nu_star < nu <= 1`, há *pooling*. Os payoffs de `H` são `(o1,o1)`, a aprovação com `H` ocorre com probabilidade um, e o valor fraco antes do reconhecimento é `(1-o1)/m`.

Não há *delay* nesse nó terminal nem aprovação sem `H`. Propostas, resultados e payoffs são únicos, salvo multiplicidade de crenças fora do caminho sem efeito sobre o resultado.

## 5. Caracterização matemática mais recente de N3: primeiro round sob maioria

**Candidato público preservado:** [`../model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v5.json`](../model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v5.json)  
**Derivação v5:** [`../model_redesign/essential_input_n3_r1_majority_derivation_v5.md`](../model_redesign/essential_input_n3_r1_majority_derivation_v5.md)  
**Ledger v5:** [`../model_redesign/essential_input_n3_r1_majority_ledger_v5.json`](../model_redesign/essential_input_n3_r1_majority_ledger_v5.json)  
**Hash do candidato:** `sha256:b30c63ac1afd29d7b1af64e9a8734270feea94bced2c8ec7e3c3bf2a94f405cb`

### 5.1 Estatuto

A matemática de `N3-v5` foi rederivada e confirmada pelos dois pareceres frios quanto a payoffs, fronteiras, onze células e conteúdo das reivindicações. Os pareceres, porém, recusaram o fechamento porque a infraestrutura então usada não provava semanticamente cada expressão material de forma independente. A arquitetura de certificação Opção A começou a ser implementada, mas foi interrompida antes de produzir companion, manifesto, pacote revisável e dois pareceres finais `PASS 0/0/0/0` sobre o mesmo hash.

Portanto:

> `N3` contém uma caracterização matemática confirmada, mas permanece `pending/unfrozen`. Seu candidato v5 não é uma dependência consumível de `N6`.

### 5.2 Valores de continuação e respostas

A dependência válida é somente `N1`. No primeiro round sob maioria:

- o valor de continuação de um Estado fraco é `beta/m`;
- o valor de continuação de `H` do tipo `theta` é `beta*o_theta`;
- um respondente fraco vota `sim` se, e somente se, `x_j >= beta/m`.

Se `k` é o número de respondentes fracos pagos exatamente no limiar necessário:

- `k >= q-1`: a proposta passa sem `H`; `H` vota `não` estritamente;
- `k = q-2`: `H` é pivotal e o tipo `theta` vota `sim` se, e somente se, `y >= beta*o_theta`;
- `k <= q-3`: a proposta falha qualquer que seja o voto de `H`; em uma indiferença sem efeito causal, `T^Y` seleciona `sim`.

### 5.3 Quatro valores relevantes do proponente

Defina:

- exclusão de `H`: `E = 1 - beta*(q-1)/m`;
- oferta aceita somente pelo tipo baixo, se ele for o tipo verdadeiro: `L = 1 - beta*o0 - beta*(q-2)/m`;
- valor esperado de separação por tipo baixo: `S(nu) = (1-nu)*L + nu*beta/m`;
- *pooling*: `P = 1 - beta*o1 - beta*(q-2)/m`;
- rejeição deliberada: `R = beta/m`.

A rejeição deliberada nunca é escolhida, pois

`E-R = 1-beta*q/m > 0`.

Quando o tipo alto rejeita a oferta direcionada ao tipo baixo, o fracasso do primeiro round é informativo e leva ao segundo round: trata-se de *delay*, não de fracasso terminal.

As comparações que geram as fronteiras são:

- `P-E = beta*(1/m-o1)`;
- `S-E = (1-nu)*beta*(1/m-o0) - nu*(1-beta*q/m)`;
- `nu_SP = beta*(o1-o0) / [1-beta*o0-beta*(q-1)/m]`;
- `nu_SE = beta*(1/m-o0) / [beta*(1/m-o0)+1-beta*q/m]`.

### 5.4 As onze células

Use ainda

- `h_E = (1-nu)*o0 + nu/m`;
- `h_P = beta/m`.

A caracterização mais recente é:

1. `o1 < 1/m` e `0 <= nu <= nu_SP`: oferta apenas ao tipo baixo.
2. `o1 < 1/m` e `nu_SP < nu <= 1`: *pooling*.
3. `o0 < 1/m < o1` e `0 <= nu <= nu_SE`: oferta apenas ao tipo baixo.
4. `o0 < 1/m < o1` e `nu_SE < nu <= 1`: exclusão de `H`.
5. `1/m < o0 < o1`: exclusão de `H` para todo `nu`.
6. `o0 = 1/m < o1` e `nu=0`: oferta apenas ao tipo baixo.
7. `o0 = 1/m < o1` e `nu>0`: exclusão de `H`.
8. `o0 < o1 = 1/m` e `nu <= nu_SE`: oferta apenas ao tipo baixo.
9. `o0 < o1 = 1/m`, `nu > nu_SE` e `h_E < h_P`: exclusão de `H`.
10. `o0 < o1 = 1/m`, `nu > nu_SE` e `h_P < h_E`: *pooling*.
11. `o0 < o1 = 1/m`, `nu > nu_SE` e `h_E = h_P`: exclusão e *pooling*, incluindo todas as misturas entre ambos.

Os empates `S=P` e `S=E` pertencem à oferta apenas ao tipo baixo porque o desempate do proponente minimiza o payoff esperado de `H`.

### 5.5 Payoffs, resultados, crenças e multiplicidade

- Oferta apenas ao tipo baixo: payoffs de `H` `(beta*o0,beta*o1)`; aprovação com `H` com probabilidade `1-nu`; *delay* com probabilidade `nu`.
- *Pooling*: payoffs de `H` `(beta*o1,beta*o1)`; aprovação com `H` com probabilidade um.
- Exclusão: payoffs de `H` `(o0,o1)`; aprovação sem `H` com probabilidade um.
- Mistura da célula 11: mistura entre exclusão e *pooling*, sem fracasso terminal e sem *delay*.

O fracasso de uma oferta ao tipo baixo que ocorre com probabilidade positiva revela que `H` é do tipo alto; a crença posterior é um. As crenças depois de propostas e vetores de votos fora do caminho são completas na representação v5, mas não se tornam primitivas adicionais.

Há multiplicidade payoff-relevante somente na fronteira residual entre exclusão e *pooling*. As probabilidades de mistura podem variar por identidade do proponente. Também podem variar as identidades dos membros da coalizão e os pesos de reconhecimento; não se impõe simetria entre identidades que o jogo não declarou.

## 6. Caracterização matemática mais recente de N4: primeiro round sob unanimidade

**Notas frias v4:** [`../model_redesign/essential_input_n4_r1_unanimity_cold_notes_v4.md`](../model_redesign/essential_input_n4_r1_unanimity_cold_notes_v4.md)  
**Derivação v4:** [`../model_redesign/essential_input_n4_r1_unanimity_derivation_v4.md`](../model_redesign/essential_input_n4_r1_unanimity_derivation_v4.md)  
**Dependência válida:** interface congelada de `N2`

### 6.1 Estatuto

Os arquivos v4 são intermediários preservados de rederivação. Eles incorporam a correção *type-conditioned* e a correção localizada de múltiplos vetos, mas não foram promovidos a um candidato completo, não receberam companion/manifesto e não foram submetidos aos dois pareceres finais exigidos.

> Não existe candidato `N4-v4` certificado ou congelado. Nenhuma fórmula de `N4` pode ser consumida por `N6` enquanto o nó continuar `pending/unfrozen`.

### 6.2 Continuação corrigida por tipo

Defina:

- `nu_star = (o1-o0)/(1-o0)`;
- `ell = beta*o0` e `h = beta*o1`;
- `A = beta*(1-o0)/m`;
- `B = beta*(1-o1)/m`;
- `D = (1-nu)*A`;
- `C = D` quando `nu <= nu_star`, e `C = B` quando `nu > nu_star`.

A correção central é distinguir valores subjetivos usados para votar de valores realizados por tipo usados para avaliar desvios:

- na continuação `N2` de oferta apenas ao tipo baixo, o valor subjetivo fraco é `A*(1-eta)`, o vetor realizado por tipo é `(A,0)` e o vetor de `H` é `(ell,h)`;
- na continuação de *pooling*, os valores subjetivo e realizado são `B`, o vetor fraco é `(B,B)` e o vetor de `H` é `(h,h)`.

A versão anterior usava `A` como payoff fraco realizado também no estado alto depois da oferta apenas ao tipo baixo. Isso foi refutado: no estado alto a proposta terminal é rejeitada e o payoff fraco realizado é zero. O voto fraco continua dependendo de seu valor subjetivo; os desvios do proponente são avaliados sob o vetor realizado e a prior verdadeira; `H` usa seu vetor condicionado ao tipo.

### 6.3 Classes puras exaustivas sustentadas

A rederivação preservada encontra três classes puras:

- `P` — *pooling*: os dois tipos de `H` e todos os Estados fracos votam `sim`; pode ocorrer para qualquer prior.
- `L` — oferta aceita somente pelo tipo baixo: `H0` vota `sim`, `H1` vota `não` e todos os Estados fracos votam `sim`; só é sustentável em `nu=0`.
- `D` — *delay*: o primeiro round falha por veto de `H`, por um veto fraco ou por múltiplos vetos fracos.

Uma classe aceita somente pelo tipo alto é impossível, pois exigiria simultaneamente `Y < ell` e `Y >= h`, embora `ell < h`. Para prior positivo, uma proposta separadora aceita apenas pelo tipo baixo é eliminada pelo desvio imitador e pela atualização de Bayes. Quando há veto fraco, o tipo alto de `H` vota sempre `sim`; uma separação pelo voto de `H` é incompatível com a melhor resposta do tipo baixo nesse ramo.

### 6.4 Restrições dos votos fracos e correção de múltiplos vetos

Nas classes `P` e `L`, cada respondente fraco precisa receber

`x_j >= B`.

Para implementações de `D`:

- **veto de H, `m=2`:** se `nu < nu_star`, basta factibilidade; se `nu >= nu_star`, exige-se `x >= B`;
- **veto de H, `m>=3`:** basta factibilidade;
- **um único veto fraco de identidade `k`:** exige-se `x_k <= C`, incluindo a igualdade;
- **múltiplos vetos fracos, `m>=3`:**
  - se `nu < nu_star`, basta factibilidade;
  - se `nu >= nu_star`, cada Estado fraco que integra o conjunto de vetos deve satisfazer `x_k <= B`, incluindo a igualdade.

Esta última condição é a correção localizada de v4. A versão v3 permitia indevidamente, na região `nu >= nu_star`, vetores *on path* com múltiplos vetos em que algum votante contrário recebia mais que `B`. O limite vale individualmente para cada veto e inclui a fronteira de igualdade. Ele não altera a punição ótima fora do caminho usada no cálculo de segurança quando `m>=3`.

### 6.5 Segurança do proponente para `m>=3`

Quando `m>=3`, o valor de segurança permanece

`S3(nu) = (1-nu)*B`.

O valor é exato e atingido. A punição fora do caminho que o sustenta permanece válida porque a correção de múltiplos vetos é uma restrição sobre vetos *on path*, não uma alteração da continuação punitiva fora do caminho.

As famílias sustentadas usam:

- `P`: `h <= Y <= y_bar`, todos os `x_j >= B`, `r_i >= S3`, além de factibilidade;
- se `r_i=S3`, o desempate seleciona `Y=h`;
- payoff máximo do proponente em `P`: `U_P = 1-(m-1)B-S3`;
- `L`, somente em `nu=0`: `ell <= Y < h`, todos os `x_j >= B`, `r_i >= S3`, além de factibilidade;
- `D`: payoff do proponente `C` e existência para todos os priors porque `C>S3` nas regiões pertinentes da caracterização v4.

Em `L`, `Y=ell` é atingido e `Y=h` é apenas supremo, pois em `h` o tipo alto também aceita.

### 6.6 Segurança do proponente para `m=2`

Quando há somente dois Estados fracos, defina:

- `Q_L = 1-ell-A`;
- `Q_P = 1-h-A`;
- `R0 = min(D,B)`;
- `R_L = min((1-nu)*Q_L,B)`;
- `R_P = max(0,Q_P)`;
- `S2 = max(R0,R_L,R_P)`;
- `H_L = (1-nu)*ell + nu*h`.

Os detalhes de atingimento importam:

- `R0` é atingido em `x=A`;
- `R_P>0` é somente um supremo, não um máximo atingido;
- para `nu<1`, `R_L` é atingido se `(1-nu)*Q_L > B`; em igualdade ou abaixo dela, é apenas supremo;
- em `nu=1`, o valor zero é atingido.

Defina o limite de desempate

- `H_tie = H_L` se `S2=R0=D<B`;
- `H_tie = h` se algum componente atingido iguala `S2` e o caso anterior não vale;
- `H_tie = +infinity` se somente componentes não atingidos alcançam `S2` como supremo.

Então:

- `P` exige `h <= Y <= y_bar`, `x_j>=B`, `r_i>=S2` e factibilidade; se `r_i=S2`, exige ainda `Y<=H_tie`;
- `L`, somente em `nu=0`, exige `ell <= Y < h`, `x_j>=B`, `r_i>=S2` e factibilidade;
- `D` existe se, e somente se, `C>=S2`, equivalendo a `D>=R_P` na região baixa e `B>=R_P` na região alta.

As diferenças entre `m=2` e `m>=3` não são convenções expositivas: elas refletem a disponibilidade, ou não, de múltiplos vetos fracos e a geometria distinta das punições e limites de segurança.

### 6.7 Identidades, pooling, delay e misturas

Não se impõe simetria entre identidades. Para um proponente `i` e um Estado fraco `k`, o valor antes do reconhecimento é construído como

`V_Wk = (R_k + sum_{i != k} w_ik)/m`,

em que `w_ik=x_k` nas classes `P` e `L`, e `w_ik=C` na classe `D`. Pesos, coalizões e probabilidades de mistura são mantidos por identidade.

As únicas misturas entre classes sustentadas pelos artefatos v4 são:

- mistura `L/D` em `(Y,r_i)=(ell,A)` quando `nu=0`;
- mistura `P/D` em `(Y,r_i)=(h,B)` quando `nu>nu_star`, condicionada à existência de `D`.

Todo elemento do suporte de cada uma dessas misturas gera o mesmo vetor de payoffs de `H`. Se `rho_L+rho_P+rho_D=1`, os payoffs de `H` registrados são:

- em `nu=0`:
  - tipo baixo: `rho_L*barY_L + rho_P*barY_P + rho_D*ell`;
  - tipo alto: `(rho_L+rho_D)*h + rho_P*barY_P`;
- em prior positivo na região baixa:
  - tipo baixo: `rho_P*barY_P + rho_D*ell`;
  - tipo alto: `rho_P*barY_P + rho_D*h`;
- na região alta: ambos recebem `rho_P*barY_P + rho_D*h`.

A massa de aprovação com `H` é `rho_L+rho_P` em `nu=0` e `rho_P` nos demais priors. A massa de *delay* é `rho_D`. Aprovação sem `H` e fracasso terminal no primeiro round têm probabilidade zero sob unanimidade.

Ao contrário de `N3`, folga pode sobreviver em `N4`: preencher toda folga pode alterar a proposta, as respostas e a classe de equilíbrio. Os artefatos v4 organizam a correspondência em seis células, separando `m=2` de `m>=3` e os priors `nu=0`, `0<nu<=nu_star` e `nu>nu_star`.

## 7. Resultados refutados, abandonados ou apenas históricos

Os seguintes elementos não pertencem ao modelo vigente ou foram refutados durante a rederivação:

1. **Saída imediata e irreversível de H.** O voto `não` de `H` não o retira do jogo nem impede sua participação futura.
2. **Três ações `sim/não/sair`.** O espaço de ações do voto é binário e simétrico.
3. **Desacordo de H realizado imediatamente após seu voto contrário no primeiro round.** `o_theta` é payoff de desacordo no fim do jogo, se nenhuma proposta passar.
4. **`max{o_theta,beta*C_theta}` como primitiva.** A continuação deve ser derivada do jogo, não imposta.
5. **Fronteiras `beta=1` e `o1=1`.** Estão fora do domínio atual.
6. **Torta dependente do tipo ou da inclusão de H.** A torta é fixa em um; `o_theta` é externo.
7. **Fator `(1-alpha)` retirado da torta fraca quando H é excluído.** Essa contabilidade é incompatível com a opção externa de `H`.
8. **Reconhecimento de H no baseline.** `pi_H=0`; agenda de `H` é possível extensão, não parte deste DAG.
9. **Votação nominal sequencial dentro do ballot.** Os votos são simultâneos e só se tornam públicos depois do fechamento do ballot.
10. **`T^Y` substituindo não dominância ou não dominância aplicada a H.** Ambas as leituras foram rejeitadas.
11. **`N5` como nó de entrada.** A decisão arquitetural removeu entrada do DAG atual.
12. **Valor realizado `A` para os fracos no estado alto após continuação low-only de N2.** O valor correto por tipo é `(A,0)`.
13. **Fórmulas antigas de segurança de N4 derivadas da contabilidade não condicionada ao tipo.** Foram invalidadas e não podem ser reutilizadas.
14. **Inclusão irrestrita de múltiplos vetos em N4-v3 acima de `nu_star`.** A condição correta em v4 é `x_k<=B` para cada veto, igualdade incluída.
15. **PASS semântico inferido de buscas por tokens, hashes ou reprodução do próprio builder.** Esses mecanismos atestam integridade e regressão, não equivalência matemática independente.
16. **Arquiteturas históricas de factibilidade `A/C/R`, *opt-out* imediato e resultados do ramo `pivotal-response`.** Permanecem como proveniência de especificações anteriores, não como resultados do modelo atual.

## 8. Estado dos nós N1–N7 e regras de consumo

| Nó | Objeto | Dependências | Estado canônico | Pode ser consumido? |
|---|---|---|---|---|
| `N1` | R2, maioria | nenhuma | `PASS/frozen` | Sim, pela interface congelada. |
| `N2` | R2, unanimidade | nenhuma | `PASS/frozen` | Sim, pela interface congelada. |
| `N3` | R1, maioria | `N1` | `pending/unfrozen` | Não. A matemática v5 foi confirmada, mas o pacote semântico não foi certificado nem congelado. |
| `N4` | R1, unanimidade | `N2` | `pending/unfrozen` | Não. V4 existe apenas como rederivação intermediária; não há candidato certificado. |
| `N5` | entrada | — | removido do DAG | Não existe como nó nesta arquitetura. |
| `N6` | comparação institucional | `N3`, `N4` | `pending/unfrozen` | Não. Suas dependências não estão fechadas. |
| `N7` | benchmark/renda terminal | `N6` | `pending/unfrozen` | Não. `N6` não está fechado. |

Em particular, não podem ser consumidos:

- o candidato público `N3-v5` como se fosse uma interface congelada;
- o ledger ou a derivação de `N3-v5` como substitutos do companion e dos dois pareceres finais;
- o candidato `N4-v3`, pois contém a condição de múltiplos vetos corrigida depois;
- as notas, derivação, builder ou oracle intermediários `N4-v4` como se formassem um candidato;
- qualquer resultado de `N6` ou `N7` derivado de versões históricas de `N3` ou `N4`;
- qualquer resultado de entrada atribuído a um suposto `N5`;
- os sete scripts locais de certificação descritos abaixo.

## 9. Artefatos e hashes relevantes

Os hashes abaixo são os últimos selos já registrados nos artefatos e checkpoints existentes. Eles identificam bytes e proveniência; não promovem o ciclo de vida do objeto.

| Artefato | Hash SHA-256 | Estatuto |
|---|---|---|
| [`plans/2026-08-12_essential_input_gate0.md`](plans/2026-08-12_essential_input_gate0.md) | `1e0bb0e42f3e65eab6d297e5d7d6776abbca9e88bbeabf3fb848a3a3a4dc8c21` | contrato governante |
| [`../model_redesign/essential_input_game_dag.json`](../model_redesign/essential_input_game_dag.json) | `0be4ff7eac0c0dfcb15338a8dd6ac7a1069089f6a24a644c28172c0feb6bcd94` | DAG canônico no checkpoint documentado |
| [`../model_redesign/essential_input_interfaces/n1_r2_majority_candidate_v1.json`](../model_redesign/essential_input_interfaces/n1_r2_majority_candidate_v1.json) | `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` | `N1 PASS/frozen` |
| [`../model_redesign/essential_input_n2_r2_unanimity_interface.json`](../model_redesign/essential_input_n2_r2_unanimity_interface.json) | `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2` | `N2 PASS/frozen` |
| [`../model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v5.json`](../model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v5.json) | `b30c63ac1afd29d7b1af64e9a8734270feea94bced2c8ec7e3c3bf2a94f405cb` | candidato público preservado, não frozen |
| [`../model_redesign/essential_input_n3_r1_majority_ledger_v5.json`](../model_redesign/essential_input_n3_r1_majority_ledger_v5.json) | `99a20b0137dbebb6d27d64e870ac11de5cdec8e1997b41dcd92cc647c521dcc1` | ledger v5, não substitui certificação |
| [`../model_redesign/essential_input_n3_r1_majority_derivation_v5.md`](../model_redesign/essential_input_n3_r1_majority_derivation_v5.md) | `a0ac3b59c9f0219245e038c805f54b9ee15b2eb249fe2c2a97c2e295267ef6b6` | derivação matemática v5 |
| candidato público `N4-v3` histórico | `6c199f961ba2b8e1f55719c8d678decf752fb7bcda042bf796a585f2a4278905` | não consumível; condição multi-veto superada |
| [`../model_redesign/essential_input_n4_r1_unanimity_cold_notes_v4.md`](../model_redesign/essential_input_n4_r1_unanimity_cold_notes_v4.md) | `a2f44b0ba0bdc1658406489be0605ffbb626d023ed0abb478530b96cec56e4c7` | intermediário v4 não consumível |
| [`../model_redesign/essential_input_n4_r1_unanimity_derivation_v4.md`](../model_redesign/essential_input_n4_r1_unanimity_derivation_v4.md) | `84570652b9215625da553153b27aaf176d309a124f80dbbca67e82a07ecc3f6b` | intermediário v4 não consumível |
| builder intermediário `N4-v4` | `143aaab2dfa5a7bd029182af1a041ef44846c57d9c517dbb0cad690d33a1fce8` | checkpoint de proveniência |
| oracle intermediário `N4-v4` | `0df08dd8adbaca480aab6f0d537322502ef39c18c140509907c17109b627d810` | checkpoint de proveniência |

Pareceres e decisões relevantes:

- [`2026-08-20_n3_v5_formal_design_review_round3.md`](2026-08-20_n3_v5_formal_design_review_round3.md)
- [`2026-08-20_n3_v5_game_theory_review_round3.md`](2026-08-20_n3_v5_game_theory_review_round3.md)
- [`2026-08-20_n3_n4_semantic_certification_architecture_finding.md`](2026-08-20_n3_n4_semantic_certification_architecture_finding.md)
- [`2026-08-19_n4_v2_cold_rederivation_accounting_finding.md`](2026-08-19_n4_v2_cold_rederivation_accounting_finding.md)
- [`2026-08-19_n4_v2_stage_undominance_blocking_finding.md`](2026-08-19_n4_v2_stage_undominance_blocking_finding.md)
- [`2026-08-20_n4_v3_formal_design_review_round1.md`](2026-08-20_n4_v3_formal_design_review_round1.md)
- [`2026-08-20_n4_v3_game_theory_review_round1.md`](2026-08-20_n4_v3_game_theory_review_round1.md)

## 10. Infraestrutura local de certificação: incompleta e não consumível

Sete scripts não rastreados permanecem preservados na árvore de trabalho:

1. [`../scripts/lib_essential_input_exact_algebra_v1.R`](../scripts/lib_essential_input_exact_algebra_v1.R)
2. [`../scripts/lib_essential_input_n3_game_kernel_v1.R`](../scripts/lib_essential_input_n3_game_kernel_v1.R)
3. [`../scripts/lib_essential_input_proof_kernel_v1.R`](../scripts/lib_essential_input_proof_kernel_v1.R)
4. [`../scripts/lib_essential_input_schema_roles_v1.R`](../scripts/lib_essential_input_schema_roles_v1.R)
5. [`../scripts/lib_essential_input_semantic_ast_v1.R`](../scripts/lib_essential_input_semantic_ast_v1.R)
6. [`../scripts/test_essential_input_n3_replay_common_mode_v1.R`](../scripts/test_essential_input_n3_replay_common_mode_v1.R)
7. [`../scripts/test_essential_input_n3_replay_shape_registry_v1.R`](../scripts/test_essential_input_n3_replay_shape_registry_v1.R)

Eles são infraestrutura incompleta da Opção A, não uma interface do jogo, não uma fonte substantiva e não uma dependência autorizada. Não existe companion materializado, manifesto final ou pacote com sentinel `READY`.

A grande bateria gerada durante o endurecimento desses scripts examinou formas, tipos, caminhos, mutações e falhas comuns da infraestrutura. Ela não deve ser apresentada como validação substantiva da teoria. Testes gerados podem demonstrar que um verificador rejeita certas corrupções conhecidas; não substituem uma derivação independente nem os dois pareceres finais sobre um pacote hashado comum. A bateria foi interrompida antes do fechamento da infraestrutura e não autoriza promoção de `N3`.

Os sete arquivos devem permanecer exatamente como trabalho local incompleto: não foram apagados, não são incluídos no commit deste registro e não podem ser consumidos por qualquer nó do DAG.

## 11. Ponto exato de parada e decisões futuras

O ponto de parada é o seguinte:

1. O contrato do jogo permanece vigente e `N1`/`N2` permanecem congelados.
2. `N3-v5` preserva uma matemática confirmada, mas ainda não possui um companion e um pacote final certificados por exatamente dois pareceristas independentes com `PASS 0/0/0/0` no mesmo hash.
3. `N4-v4` preserva a rederivação *type-conditioned* e a correção localizada de múltiplos vetos, mas ainda não existe como candidato completo, hashado, certificado ou congelado.
4. `N6` e `N7` continuam bloqueados por dependências. `N5` não integra a arquitetura.
5. A implementação parcial da Opção A está nos sete scripts não rastreados e não é consumível.
6. Nenhum manuscrito, figura, PDF, caso `beta=1` ou extensão foi iniciado por esta linha de trabalho.

Este documento não recomenda retomada automática. Se o autor decidir voltar ao projeto, as decisões futuras permanecem autorais: manter ou abandonar a Opção A; simplificar o padrão de certificação; aceitar outro limite de prova automatizada; ou encerrar a arquitetura com `N1` e `N2` como únicos nós congelados. Qualquer escolha deverá começar por uma autorização nova e explícita, preservando o estado registrado aqui e sem tratar a infraestrutura incompleta como evidência substantiva.
