# Parecer formal independente 1 — assinatura de `A_M` em duas camadas

**Data:** 29 de agosto de 2026  
**Papel:** parecerista formal independente 1, somente leitura  
**Objeto:** candidato de assinatura exata e resumo econômico de `A_M` sob M/S/B  
**Worktree:** `/private/tmp/PBP-am-msb`  
**Branch:** `agenda-extension-am-msb`  
**Snapshot revisado:** `e17520ee927eaca96ac9624ea032f855a6dc284d`  
**Commit substantivo:** `e020629d5bad8fbd66d67cf108b1a2e0d8b048fd`

## 1. Declaração de independência

Não implementei o candidato, não editei, criei ou apaguei arquivos e não fiz commit, tag ou merge. Não consultei memórias, rollout summaries, a web ou qualquer novo parecer sobre a implementação em duas camadas. Os dois pareceres formais anteriores e sua adjudicação foram lidos exclusivamente para identificar os dois findings cuja reparação deveria ser verificada.

A reconstrução foi feita a frio, com a skill `game-theory-audit` adaptada a um jogo finito de barganha e sinalização bayesiana. Não usei outro agente ou parecerista. A execução do verificador R não alterou o worktree.

## 2. Identidade e hashes

| Checagem | Resultado |
|---|---|
| branch | `agenda-extension-am-msb` — coincide |
| `HEAD` | `e17520ee927eaca96ac9624ea032f855a6dc284d` — coincide |
| ancestral substantivo | `e020629d5bad8fbd66d67cf108b1a2e0d8b048fd` — confirmado por ancestralidade Git |
| hash externo esperado do manifesto | `4130c09b9a7d504e0dd18f63c8793a0f6ce5f239369c585d924c48742177c0aa` |
| hash externo recalculado | idêntico |
| `shasum -a 256 -c` | `24/24 OK` |
| estado do worktree após a auditoria | limpo |

Hashes centrais recalculados:

| Artefato | SHA-256 |
|---|---|
| resultados | `7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3` |
| claim ledger | `321cb2ed45ed1c5ebb6103a4ac567f07b735dd7a2ca8e2252925b43b8a2add9c` |
| verificador R | `b3133ab97870cf9c5730c57da40c2c9f4d68912226bb8d8f080022653e2a8391` |
| output preservado | `3a242732c07b3d6ed5c508ca0238d1665c42de9d4f00f857b4030fe724ce7628` |
| decisão em duas camadas | `cd9650715442dc0beae2fa6af450c509c0ad871d51dc5d54b0a6a826d1fc86e8` |
| emenda M/S/B | `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b` |
| clarificação de anonimato | `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3` |
| interface congelada N3 | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |

Entre `e020629` e `e17520e` foram apenas acrescentados preflight, relatório de implementação e manifesto. Os bytes substantivos são exatamente os do commit `e020629`.

## 3. Reconstrução matemática independente

### 3.1 Espaços mensuráveis e ação do grupo

Para primitivas e `N` fixos:

- `Y` é um simplex compacto de dimensão finita, portanto compacto polonês.
- `X_M={E,S,P} ⊔ ({EP}×[0,1])` é soma topológica finita de compactos poloneses.
- `Omega_D` é corretamente construído como conjunto finito discreto dos registros terminais presentes nos kernels uniformes literais `E`, `S` e `P`. O kernel `EP` apenas mistura suportes já existentes.
- `Omega_T=({A}×Y) ⊔ ({D}×Omega_D)` é compacto polonês.
- `Z=Y×[0,1]×{0,1}×X_M×Omega_T` é compacto polonês e, portanto, Borel-padrão.
- `P(Z)` com a topologia fraca é polonês; logo `X=P(Z)^2` também é polonês.

A ação de `G=S_m` permuta simultaneamente todas as coordenadas nomeadas dos fracos e fixa posterior, indicador de acordo e rótulo anônimo da continuação. Cada `T_g:Z→Z` é homeomorfismo; seu pushforward em `P(Z)` é contínuo. A ação sobre `X` é efetivamente diagonal: o mesmo `g` atua nas duas leis de tipo.

### 3.2 Lei de órbita `Lambda_x`

A definição

\[
\Lambda_x=\frac1{|G|}\sum_{g\in G}\delta_{g\cdot x}
\]

está bem tipada em `P(X)`.

A prova de AM-MSB-T5 é completa:

1. **Borelidade:** para todo Borel `B⊆X`,  
   \[
   \Lambda_x(B)=|G|^{-1}\sum_g1_B(g\cdot x)
   \]
   é Borel em `x`; os mapas de avaliação geram a σ-álgebra de `P(X)`.

2. **Invariância:** `g↦gh` apenas reordena a soma, inclusive quando há estabilizadores.

3. **Completude:** se `Lambda_x=Lambda_x'`, então
   \[
   \Lambda_{x'}(\{x'\})=\frac{|\operatorname{Stab}_G(x')|}{|G|}>0.
   \]
   Logo `Lambda_x({x'})>0`, e algum `g` satisfaz `g·x=x'`. A recíproca segue da invariância.

Portanto, `Lambda_x=Lambda_x'` se e somente se os dois pares pertencem à mesma órbita diagonal.

### 3.3 Representante expositivo real

O candidato fixa um isomorfismo Borel injetivo `iota_X` e escolhe o mínimo de `iota_X` na órbita finita. As comparações são Borel, o resultado é constante na órbita e pertence literalmente a ela.

Para `x=x(R)`, o lema de fechamento sob relabeling garante que o representante é produzido por algum PBE `g·R`. Não há uso de Reynolds nem alegação de seletor mensurável no espaço bruto de assessments.

### 3.4 Quociente `Z/G` e fatorização

A transversal

\[
\bar Z=\{z:\iota_Z(z)\leq\iota_Z(T_gz)\ \forall g\}
\]

é Borel e contém exatamente um ponto por órbita. Como `G` é finito, o mapa de mínimo `q_Z:Z→\bar Z` é Borel e satisfaz `q_Z∘T_g=q_Z`. Assim, a realização adotada de `Z/G` é Borel-padrão.

Para toda `f:Z→E` Borel e `G`-invariante, a restrição de `f` à transversal define a única Borel `f_bar` tal que `f=f_bar∘q_Z`. A identidade

\[
\int_Zf\,d\Gamma_\theta
=
\int_{Z/G}\bar f\,d(q_Z)_\#\Gamma_\theta
\]

é a identidade de integração por pushforward.

As aplicações econômicas estão corretamente delimitadas:

- payoff de `H` por tipo;
- acordo e atraso;
- lei do posterior por tipo;
- continuação anônima;
- outcome terminal anônimo;
- vetor ordenado dos payoffs fracos, isto é, o multiconjunto anônimo;
- lei do payoff de uma identidade fraca sorteada uniformemente.

O candidato não afirma recuperar `W_j`, suportes ou propostas nomeadas. Isso respeita a exigência de tratar payoffs fracos como multiconjunto/lei, não como índices nomeados.

### 3.5 Camada exata, resumo e Reynolds

A distinção está formalmente correta:

\[
\operatorname{Sig}^{ex}_M(R)
=
(\rho,\nu_{\mathrm{off}},\Lambda_{x(R)})
\]

é a assinatura exata; enquanto

\[
\operatorname{Sum}^{econ}_M(R)
=
(\rho,\nu_{\mathrm{off}},
(q_Z)_\#\Gamma_0,
(q_Z)_\#\Gamma_1)
\]

é um resumo deliberadamente muitos-para-um.

Os quatro limites de Reynolds estão expressos sem ambiguidade:

1. não é invariante completo da órbita diagonal;
2. perde a relação entre os planos dos tipos;
3. pode não ser imagem de assessment algum;
4. sua igualdade representa apenas igualdade de resumo marginal.

O contraexemplo `P/Q` fecha corretamente o primeiro ponto: a cardinalidade da interseção contrafactual das coalizões é preservada por permutação comum, mas não pelas médias componentwise. A incompatibilidade de posteriores `0` e `1` na mesma mensagem fecha a não realizabilidade.

Nas misturas de identidades, o critério formal operativo é exato: o resumo coincide se e somente se os pushforwards anônimos por tipo coincidem. Misturas finitas com suportes de mensagens disjuntos preservam a separação e podem ter o mesmo resumo; misturas com sinais compartilhados positivamente alteram as razões de verossimilhança e a lei do posterior. Nenhum baricentro é presumido PBE.

### 3.6 Fibra, endpoints e cardinalidade

O produto fibrado na mesma dupla `(rho,nu_off)` precede qualquer resumo. Para consumidores futuros:

- funções exigem constância nas fibras e fatorização mensurável própria;
- correspondências exigem prova setwise, preservação das propriedades relevantes do gráfico e proibição de recombinação;
- sem esse claim específico, consome-se `Sig_ex`.

Nos endpoints, `rho` é corretamente substituído por `*`, `nu_off=nu`, e as leis conjuntas e assinaturas são construídas sem divisão por prior nulo.

O teorema cardinal permanece válido. Na família atomless, a linha de propostas é fixa pela ação de `S_m`; valores distintos de `epsilon` produzem leis distintas em `(y,pi(y))`. As órbitas são singletons distintos, gerando um contínuo de assinaturas exatas. O texto limita corretamente a conclusão à inexistência de lista finita.

### 3.7 Reparo átomo versus ponto de massa zero

O finding menor anterior foi integralmente reparado:

- em átomo público com posterior interior, Bayes força massa positiva dos dois tipos;
- a igualdade quase-certa de T4 passa então a valer naquele singleton;
- em pontos de massa zero, não se infere igualdade pontual;
- as identidades setwise  
  `sigma_1({pi=0})=0` e `sigma_0({pi=1})=0`  
  seguem das identidades integrais de Bayes;
- a prova de `AMX-011` usa conjuntos de probabilidade positiva e imitação, sem hipótese de atomicidade.

T4 e `AMX-015` permanecem substantivamente inalterados.

## 4. Checklist formal

| Item | Status | Fundamentação |
|---|---|---|
| tipagem de `Y`, `X_M`, `Omega_D`, `Omega_T`, `Z`, `P(Z)^2` | PASS | carriers explicitamente poloneses/Borel-padrão |
| ação diagonal finita e Borel | PASS | mesmo `g` atua no par inteiro; pushforwards contínuos |
| Borelidade de `Lambda` | PASS | mapas de avaliação |
| invariância de `Lambda` | PASS | translação à direita em grupo finito |
| completude de `Lambda`, inclusive estabilizadores | PASS | massa positiva no singleton da própria órbita |
| representante expositivo real e mensurável | PASS | mínimo Borel numa órbita finita |
| `Z/G` Borel-padrão | PASS | transversal Borel explícita |
| lema de fatorização e identidade de integrais | PASS | restrição à transversal e pushforward |
| estatísticas econômicas derivadas | PASS | funções ou pushforwards `G`-invariantes |
| payoffs fracos anônimos | PASS | multiconjunto ordenado/lei uniforme de identidade |
| distinção assinatura versus resumo | PASS | codomínios e regras de uso separados |
| quatro limites do Reynolds | PASS | todos explicitados e demonstrados por `P/Q`/posterior contraditório |
| misturas e revelação | PASS | critério exato pelas leis anônimas por tipo |
| produto fibrado e consumo downstream | PASS | mesma fibra primeiro; claims por operação |
| reparo átomo versus ponto nulo | PASS | provas atômica e setwise corretas |
| endpoints | PASS | fibra `*`, sem Reynolds ou divisão por prior |
| teorema cardinal | PASS | família atomless continua injetiva no quociente exato |
| preservação dos resultados anteriores | PASS | alterações materiais confinadas aos dois findings e à tipagem necessária |
| ledger | PASS | 31 linhas, 16 campos em todas, IDs únicos |
| regressão mecânica | PASS limitado | `3954 PASS / 0 FAIL`; não substitui prova |

## 5. Tabela claim a claim

| Claim | Status | Razão |
|---|---|---|
| `AMX-015` | PASS | T4 continua um `iff` necessário e suficiente; apenas as glosas pontuais foram corrigidas |
| `AMX-016a` | PASS | assinatura exata bem tipada; `Lambda` Borel, invariante e completa; representante real |
| `AMX-016b` | PASS | resumo por `Z/G`, fatorização mensurável das estatísticas declaradas e gate correto para consumidores |
| `AMX-MSB-009` | PASS | a família atomless continua produzindo um contínuo de órbitas exatas distintas |
| `AMX-MSB-010` | PASS | fechamento sob relabeling comum, escopo exato das misturas e consumo condicionado corretamente reenunciados |
| `AMX-MSB-011` | PASS | homeomorfismo `rho↦b_rho(nu)` e fibras permanecem inalterados |
| `AMX-011` | PASS | prova por uso aprovado com probabilidade positiva; não depende de átomos |
| `AMX-MSB-006` | PASS | igualdade de payoff não apaga separação; a lei do posterior permanece no resumo |
| `AMX-005` | PASS | endpoints transportados para as duas camadas sem alterar o argmax |
| `AMX-013` | PASS mecânico | reexecução reproduziu `3954/0`; escopo do código está corretamente limitado |
| `AMX-014` | PASS | classificação pura não foi rederivada nem alterada fora das referências à nova interface |

Demais claims por bloco:

| Bloco | Claims | Status |
|---|---|---|
| continuação, ballot, atingimento e existência | `AMX-MSB-001`–`004`, `AMX-001` | PASS, inalterados |
| classificação pura | `AMX-002`, `AMX-MSB-005`–`007`, `AMX-003`, `AMX-004` | PASS, inalterados |
| testemunhas, fronteiras e limites | `AMX-006`–`012`, `AMX-MSB-008` | PASS, inalterados |
| comparador e certificado históricos | `AMX-009`, `AMX-NEG-001` | PASS no escopo histórico explicitamente limitado |
| refinamento futuro | `IC-D1-BENCHMARK` | corretamente `pending/nonblocking` |

O antigo `AMX-016` foi substituído, conforme decisão autoral, por `AMX-016a` e `AMX-016b`; não há claim substantivo órfão.

## 6. Findings

Não identifiquei finding `critical`, `important` ou `minor`.

Os dois clusters adjudicados foram efetivamente fechados:

- o finding `important` do Reynolds foi reparado pela órbita diagonal exata, sem rebatizar o baricentro;
- o finding `minor` pointwise foi reparado pela distinção átomo versus ponto de massa zero, sem alterar T4, `AMX-015` ou `AMX-011`.

## 7. Verificação mecânica e seus limites

Executei, em modo somente leitura:

```text
Rscript --vanilla scripts/verify_agenda_extension_A_M_msb.R
SUMMARY | 3954 PASS | 0 FAIL
```

O processo terminou com status zero; os avisos observados foram apenas de locale. O worktree permaneceu limpo.

Essa regressão confirma os fixtures finitos, a aritmética, `P/Q`, invariância de `Lambda`, invariância do pushforward, misturas de pesos e preservação da lei do posterior. Ela não prova PBE, Bayes pointwise geral, Borelidade abstrata, completude de `Lambda`, fatorização geral ou suficiência de qualquer operação futura de `AC/AR`.

## 8. Limites do parecer

- Não formalizei as provas em Lean.
- Não rederivei a correspondência congelada `C_M`; conferi seu hash, sua interface e a compatibilidade do representante uniforme consumido.
- Não auditei `A_U`, `AC`, `AR`, o manuscrito ou qualquer afirmação de comparação institucional.
- Nenhum claim é promovido por este parecer a `pass/frozen`; isso ainda depende do segundo parecer e da aprovação autoral terminal.
- As consultas externas foram usadas como fontes de provas a reconstruir, não como autoridade ou parecer formal.

## 9. Veredito

PASS

FINAL_STATUS: PASS  
COUNTS: 0/0/0
