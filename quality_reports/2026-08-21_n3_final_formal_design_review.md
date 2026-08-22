# Parecer final independente de N3 — desenho formal

**reviewer_role:** `formal_design`  
**reviewer_id:** `codex-formal-design-n3-final-20260821`  
**independência:** revisor read-only; não implementou nem editou os candidatos submetidos  
**escopo:** ciclo próprio de `N3` apenas; `N4` não foi revisto substantivamente  
**manifesto revisado:** `sha256:90d6d8bfc4f1ef18c7edf5f9e1ea08870aec0385e625573e31b1b63a5a3d2bd4`  
**interface N3 revisada:** `sha256:ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`  
**dependência N1 consumida:** `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` (`N1-EQ-01`)  
**veredicto:** `PASS`  
**finding_counts:** `critical=0; major=0; minor=0`

## 1. Integridade, escopo e material lido

Confirmei antes da revisão:

- a raiz Git `/private/tmp/PowerBayesianPersuasion-essential-input-solution-concept`, `HEAD a6fd6bd543e9cefd4166581b80565916509e95a6` e branch `codex/essential-input-solution-concept-rederive`;
- o hash do próprio manifesto, `90d6d8bfc4f1ef18c7edf5f9e1ea08870aec0385e625573e31b1b63a5a3d2bd4`;
- todas as oito entradas do manifesto por `shasum -a 256 -c`, inclusive a interface N3 no hash `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`;
- a interface N1 consumida no hash `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`.

Li integralmente `AGENTS.md`, o contrato Gate 0, a decisão/errata de 2026-08-21, o manifesto e todos os arquivos nele enumerados. Para a verificação expressamente pedida de `FD-SUP-MIN-01`, li ainda o relatório de reparo dirigido. A análise abaixo reconstrói N3 desde as primitivas e N1; referências a N4 limitam-se ao fechamento textual e lógico desse finding.

## 2. Reconstrução independente de N3

### 2.1 Quota, votos fracos e pivotalidade de H

Com `m=N-1`, `q=floor(N/2)+1` e `N>=3`, vale `q<=m` e há `m-1` weak responders além do proponente, que já conta como `sim`. N1 entrega, em unidades de R2, `1/m` a cada weak state antes do reconhecimento e `o_theta` a `H(theta)`. Transportados uma única vez a R1:

```text
w = beta/m
t_theta = beta*o_theta
```

Pela comparação as-if-pivotal, cada weak responder recebe `x_j` se seu `sim` aprova e `w` se seu `não` causa continuação. Logo vota `sim` exatamente quando `x_j>=w`; `T^Y` fecha a igualdade em `sim`. A posterior-invariância de N1 torna irrelevante para esse cutoff qual vetor público de votos levou à continuação.

Se `k` é o número de weak responders com `x_j>=w`, a partição é exaustiva:

- `k>=q-1`: os fracos já aprovam; `H` recebe `y` votando `sim` e `y+o_theta` votando `não`, portanto ambos os tipos votam `não` estritamente;
- `k=q-2`: `H` é pivotal e vota `sim` exatamente quando `y>=t_theta`, com igualdade fechada por `T^Y`;
- `k<=q-3`: ambos os votos de `H` levam a N1 e pagam `t_theta`; `T^Y` determina `sim`.

Essa tabela preserva simultaneidade do ballot, execução integral de `y`, ausência de opt-out e a diferença temporal entre `o_theta` corrente numa aprovação sem `H` e `beta*o_theta` após falha de R1.

### 2.2 Payoff proposta a proposta e classes E/S/P/R

A tabela anterior implica, antes de nomear ramos:

```text
v_i(s;nu) = r_i                                                     se k>=q-1;
            (1-nu)[r_i se y>=t_0, senão w]
              + nu[r_i se y>=t_1, senão w]                         se k=q-2;
            w                                                       se k<=q-3.
```

Minimizar o custo de cada classe que pode ser globalmente ótima fornece:

```text
E       = 1-(q-1)w
L       = 1-(q-2)w-t_0
S(nu)   = (1-nu)L+nu*w
P       = 1-(q-2)w-t_1
R       = w
```

Não existe aceitação somente pelo tipo alto porque `t_0<t_1`. Propostas low-only não canônicas que ficam payoff-equivalentes apenas quando o tipo baixo tem probabilidade zero não geram equilíbrio omitido: em `nu=1`, toda a classe low-only paga `w=R`, enquanto `E-R=1-beta*q/m>0`.

### 2.3 Factibilidade, uso da pie e hedge

Exclusão é sempre factível porque `q-1<=m-1` e `beta(q-1)/m<1`. Se `S>=E`, então `o_0<=1/m` — estritamente para `nu>0` — e o custo de screening satisfaz

```text
t_0+(q-2)w <= beta(q-1)/m < 1.
```

Se `P>=E`, então `o_1<=1/m` e a mesma desigualdade garante a factibilidade de pooling. Assim, escrever o valor como o máximo de `E`, `S(nu)` e `P` não permite que um candidato infactível vença.

Toda proposta selecionada passa com probabilidade positiva; qualquer folga pode ser transferida a `r_i` sem mudar respostas e aumenta estritamente o payoff do proponente. P0 está, portanto, fechado. Em qualquer aprovação sem `H` com `y>0`, substituir `y` por zero e somá-lo a `r_i` preserva os mesmos pagamentos fracos, o mesmo ballot e a mesma soma orçamentária, elevando estritamente o payoff do proponente. Isso fecha P1 e P1a sem usar crença adicional.

Finalmente,

```text
E-R = 1-beta*q/m > 0,
```

pois `q<=m` e `beta<1`. Rejeição deliberada não pode ser on-path.

### 2.4 Fronteiras, igualdades e desempate da proposta

As comparações reconstruídas são:

```text
P-E = beta(1/m-o_1)
S-E = (1-nu)beta(1/m-o_0)-nu(1-beta*q/m).
```

Para `o_0<1/m`, a fronteira screening-exclusão é

```text
nu_SE = beta(1/m-o_0)
        / [beta(1/m-o_0)+1-beta*q/m],
```

que pertence a `(0,1)`. No empate, screening minimiza o payoff esperado de `H`, pois entrega `beta[(1-nu)o_0+nu o_1]`, estritamente abaixo do payoff de exclusão.

Pooling só pode superar exclusão quando `o_1<=1/m`. No domínio estrito `o_1<1/m`, a fronteira screening-pooling é

```text
nu_SP = beta(o_1-o_0)
        / [1-beta*o_0-beta(q-1)/m].
```

O denominador é positivo e excede o numerador; logo `nu_SP` pertence a `(0,1)`. Na igualdade, screening novamente vence pelo desempate, pois seu payoff para `H` é estritamente menor que `beta*o_1`.

A partição em cinco casos no candidato é exaustiva. Nos cantos `o_0=1/m<o_1` e `o_0<o_1=1/m`, as igualdades são tratadas corretamente. No segundo, acima da região de screening, `E=P` e o desempate compara `h_E=(1-nu)o_0+nu o_1` com `h_P=beta o_1`; somente quando esses payoffs também empatam sobrevivem exclusão, pooling e misturas entre elas. No empate triplo, screening é a única proposta selecionada.

### 2.5 Crenças, endpoints e desconto

O sistema de crenças da interface implementa a decisão vigente:

- propostas e votos fracos não movem `nu`;
- ações prescritas de `H` atualizam por Bayes quando o denominador é positivo;
- uma ação de `H` fora do perfil permite crença livre em `[0,1]` somente quando `0<nu<1`;
- em `nu=0` todo posterior permanece zero e em `nu=1` todo posterior permanece um.

Embora o registro histórico de N1 descreva uma classe mais ampla de crenças off-path, sua estratégia, outcome e payoff são posteriores-invariantes. N3 aplica expressamente a decisão/errata mais recente ao assessment que constrói e consome apenas essas coordenadas invariantes de `N1-EQ-01`; não há recombinação nem mudança silenciosa de continuação.

R2 não contém `beta`. N3 multiplica `1/m` e `o_theta` exatamente uma vez ao formar `w` e `t_theta`; aprovação em R1 sem `H` paga `o_theta` corrente. A auditoria não encontrou duplo desconto nem desconto ausente.

### 2.6 Correspondência completa, multiplicidade e atomicidade

Para cada identidade reconhecida `i`, `F_i` pode ser qualquer distribuição sobre o argmax lexicográfico factível. Isso preserva:

- a escolha da coalizão de `q-1` responders em exclusão;
- a escolha da coalizão de `q-2` responders em screening ou pooling;
- a mistura residual entre exclusão e pooling somente quando também empata o payoff esperado de `H`.

Não se impõe simetria entre `F_i` e `F_j`. O binder `F=(F_i)_{i in W}` é comum à estratégia, ao payoff de cada weak identity, aos dois payoffs condicionais de `H` e às distribuições de passagem e atraso. As fórmulas de reconhecimento usam `1/m` uma vez para cada identidade proponente, e `I_H`, `I_X` e `I_D` formam uma partição proposta a proposta e tipo a tipo. Assim, a interface não fabrica equilíbrios recombinando projeções marginais.

Os vetores condicionais de `H` conferem com a reconstrução:

```text
exclusão  = (o_0,o_1)
screening = (beta*o_0,beta*o_1)
pooling   = (beta*o_1,beta*o_1).
```

Há atraso apenas no estado alto de um screening selecionado com `nu>0`; não há falha terminal em R1. Os treze claims do ledger correspondem às etapas efetivamente demonstradas e usam a data de payoff correta.

## 3. Verificação limitada de FD-SUP-MIN-01

O finding está fechado no relatório consolidado. A contradição `Y<ell<h<=Y` foi corretamente limitada a `0<nu<1`. O endpoint `nu=1` agora recebe argumento próprio: a restrição de suporte fixa posterior um após qualquer dos votos; ambos os tipos comparam `Y` com `h`; a separação inversa exigiria `Y<h<=Y`, com `T^Y` eliminando a igualdade. Isso corresponde exatamente ao reparo único descrito em `quality_reports/2026-08-21_reparo_fd_sup_min_01.md`.

Essa confirmação não constitui parecer substantivo sobre N4, sua correspondência ou sua interface.

## 4. Checagens dirigidas executadas

- `Rscript --vanilla scripts/verify_essential_input_solution_concept_rederivation.R`: `MODEL_PROOF_DIRECTED PASS`, `ALGEBRA_IDENTITIES PASS` e `FINITE_ENUMERATION PASS`;
- parser JSON sobre a interface N3: `PASS`;
- ledger N3: treze claims e número constante de campos: `PASS`;
- `git diff --check`: limpo;
- reconstrução manual dos casos `N=3`, `nu=0`, `nu=1`, `o_0=1/m`, `o_1=1/m`, `S=E`, `S=P` e empate triplo.

Essas checagens são matemáticas dirigidas e representativas; não houve mutação exaustiva por folha ou schema.

## 5. Findings transcritos e contagens

### Critical

Nenhum.

### Major

Nenhum.

### Minor

Nenhum.

```text
critical = 0
major    = 0
minor    = 0
```

## 6. Veredicto estrito

`PASS 0/0/0` para a interface N3 `sha256:ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` no manifesto `sha256:90d6d8bfc4f1ef18c7edf5f9e1ea08870aec0385e625573e31b1b63a5a3d2bd4`.

O parecer atesta desenho formal, cobertura matemática e coerência interna do candidato N3 sob o contrato e a decisão/errata vigentes. Não congela a interface, não altera o DAG, não autoriza consumo por N6 e não emite veredicto substantivo sobre N4.
