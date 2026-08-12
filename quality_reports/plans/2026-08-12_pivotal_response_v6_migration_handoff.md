# Handoff: migração da cadeia pivotal-response para `formal_model_v6`

**Data:** 2026-08-12  
**Status:** derivação formal congelada e aprovada; migração ainda não iniciada  
**Alvo da próxima sessão:** `formal_model_v6.Rmd` e, depois de validação, `formal_model_v6.pdf`

## 1. Conclusão executiva

A rederivação não sustenta o enunciado geral de que unanimidade beneficia o
hegemon. Ela sustenta uma conclusão mais precisa e, substantivamente, mais
interessante:

> Unanimity can turn the privately informed hegemon's participation decision
> into a screening constraint for weak proposers, whereas majority adds a
> route for weak states to bypass the hegemon. Because simultaneous ballots
> admit proposal-contingent PBE completions, however, neither rule induces a
> unique payoff or a universal institutional ranking.

O paper deve, portanto, ser reescrito como uma teoria de **correspondências de
equilíbrio** e de **possibilidades institucionais**, não como uma teoria de um
único payoff selecionado por regra.

As três mensagens que devem organizar abstract, introdução e conclusão são:

1. quando a aprovação fraca está assegurada, a unanimidade transforma o limiar
   privado de participação de `H` em uma restrição informacional para o
   proponente;
2. a maioria não elimina mecanicamente a informação privada, mas acrescenta
   equilíbrios nos quais a coalizão fraca aprova sem `H`;
3. sob PBE e ballot simultâneo, a comparação entre regras é set-valued e
   assessment-specific: há resultados de existência e de comparação pareada,
   mas não dominância institucional universal.

## 2. Estado exato do repositório

No fechamento deste handoff:

```text
git root  /Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion
HEAD      19c431adb3d3e9af2291f7b4efb7757091534388
branch    main
remote    origin/main no mesmo commit
worktree  contém somente este handoff como arquivo novo não rastreado
```

O commit é um checkpoint automático genérico e ainda não tem uma tag semântica
de pré-migração. Este handoff foi criado depois dele e, portanto, não está
contido em `19c431a...`. Antes de editar o manuscrito, a próxima sessão deve usar
o workflow da skill `paper-version`, confirmar que **a única diferença** é este
arquivo novo, recalcular seu hash e pedir autorização para executar, nesta
ordem:

```text
1. criar/mudar para: codex/pivotal-response-v6-migration em 19c431a...
2. commitar somente este handoff na nova branch
3. confirmar worktree limpo
4. criar a tag anotada pre-pivotal-response-v6-migration-2026-08-12
   no commit que contém o handoff, mas ainda não altera o v6
```

Não criar a tag depois que `formal_model_v6.Rmd` já tiver sido alterado.

### Alvos ainda intactos

```text
formal_model_v6.Rmd
sha256:131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d

formal_model_v6.pdf
sha256:a7d36d5a1fb2d15ba0e40509ad846fbf001b5960232fcbf011d5b32bec298bdf
```

### Fontes congeladas autorizadas

```text
Full-chain release
sha256:d06fe49b9ae90b9f6def399b45b27aec264342a3a460722cbb38d633d373e917

Full-chain review
sha256:c198391dc24980eef150f58b6756e46d22b5b6aee168d67fdc687757c7304f80

Final status
sha256:955be0581ac176d1e49b8b1d16b9583818fd15be68186590f1540812ef6be451

Integrated analytic Rmd / HTML / TeX
sha256:de956ec7f84c37991494e87962317369d382674783d7af4de648c56be1cd0b66
sha256:0867d1cde8bceebcf57bc414a8e9ddb600f1a4d3e847c2bb3b6f7a423472ad44
sha256:9a5b27196d956bc95d99e5645956559bd2e1e6877ada03291819f2e19604c6bd

Reviewed 60-page PDF
sha256:6ff930e1a3d3ba11a0b9630149a42a23bdb1ef204b71ece7e17f5ece62594126

Master verifier / master checks
sha256:3d4537dd9042d3237f7a315473cb1a3cef154dae8901a9978f9ed640e0a16864
sha256:1b947c5049b3262f0802ef635be38f7ce6a95689207349edec8ad79e6a366da1

Candidate-status snapshot / candidate visual audit
sha256:05be9fbcc3ed0d12f53a142e282113d495a781b4c76c11faf2b874fcede98c3d
sha256:f448d595e55986aea21eb00345dd55105c145476c68816f9f3d740f45afb0e5c

Survival matrix JSON / CSV / review
sha256:5278b14d442d49d799b93323516fc081c9e7ed57a7ad2f794bfac3e7a5a27801
sha256:f634c46a764f9bacef13474be1c5f31371db8c42592f9699197191b94c0e0bd8
sha256:80c912ba35fc46bdb1859edeb91402dcb63f52079cd3ca8c4aeeb4b98b0077a7

Gate 0 / R2 / R1 / entry / comparison-review
sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1
sha256:00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a
sha256:f4ac7b89f4c08d4ee461ca1431135286304abaae2589a337aeffdb38b5941c3a
sha256:8817a9c505ce9e5b79deea1b38055d88a629e740e324fbcd5bca707b108b5433
sha256:0acd9648eb7e03d4dabfaa91ffd559fe3c5b6f61a96ba676d6c6ccd9d4c6bb3c

DAG / ledger / protected manifest
sha256:4b7aa1b9647791b7e2b3a62fd21c1b782982eca40d44414c8e23f88140b166c0
sha256:23d0566aa55aeac74b43819d907c9022ed02e065210694d26dda7b13283c1750
sha256:e6c2dcaea628acf84ea77853448b185b189e24d7b809e540e442fd820b0d6d6c
```

O freeze final registra master verifier `25/25`, master snapshot `25/25`,
full-chain freeze `27/27`, protected artifacts `27/27`, DAG válido, 12 nós PASS
e `Ready: none`.

## 3. Intuição dos equilíbrios

### 3.1 O ballot simultâneo cria multiplicidade substantiva

Cada não proponente vota sem observar os votos correntes dos demais. Um voto
pode ser individualmente irrelevante dado o perfil dos outros, embora uma
mudança conjunta de vários votos altere aprovação e pagamentos. Por exemplo,
com dois votos fracos `no`, a troca unilateral de qualquer um pode continuar
insuficiente para aprovar, mas a troca conjunta dos dois pode fazer a proposta
passar.

PBE testa desvios individuais, não desvios coalizacionais. Por isso, ações de
relevância zero precisam ser completadas no assessment e completions diferentes
podem sustentar passagem ou falha. Essa multiplicidade não é mero ruído de
notação: ela altera propostas ótimas, pagamentos, entry e comparações entre
regras.

Consequência: não se pode impor por atalho all-yes, coalizão mínima, zero gifts
ou uma completion global canônica.

### 3.2 Unanimidade terminal: o mecanismo informacional mais limpo

Quando todos os fracos aprovam, `H` é indispensável. O tipo `theta` aceita uma
concessão `y` quando ela cobre `o_theta`. Se `o_0<o_1`, então:

```text
y < o_0          ambos os tipos rejeitam;
o_0 <= y < o_1   tipo 0 aceita e tipo 1 faz opt-out;
y >= o_1         ambos os tipos aceitam.
```

Uma proposta entre os limiares separa os tipos. Para obter pooling, os fracos
precisam pagar ao menos o limiar alto. Esse é o mecanismo de informational
pivotality: a informação privada de `H` entra na escolha da proposta porque
sua participação é necessária.

Mas, para `N>=4`, há ao menos dois weak nonproposers. Eles podem coordenar em
uma completion de falha na qual nenhum voto isolado restaura a unanimidade.
Falha coordenada está sempre disponível nesse domínio. Além dela, há pooling
positivo quando `G=1-o_1>0` e separação positiva quando `nu<1`. Portanto, onde
os respectivos conjuntos não são vazios, essas classes coexistem entre
assessments; nenhuma é globalmente o único equilíbrio.

### 3.3 Maioria com `H` ativo: bypass, não eliminação da informação

Sob maioria, um `no` de `H` não precisa derrotar a proposta. Se os votos fracos
atingem a quota original, a proposta passa sem `H`, `H` recebe seu outside
payoff e `y` volta ao residual fraco.

Isso acrescenta uma rota de bypass: os fracos podem tornar a participação de
`H` dispensável. Contudo, a maioria também admite assessments que incluem,
excluem ou separam os tipos de `H`. Portanto, “majority is a no-screening
benchmark” não é um resultado geral.

Para `3<=N<=5` e `o_0>0`, a projeção do payoff terminal do proponente é `{1}`.
Para `3<=N<=5` e `o_0=0`, ela é exatamente
`[max{1-o_1,1-nu},1]`; nos endpoints, esse intervalo pode degenerar em
singleton. Para `N>=6`, completions de falha tornam a projeção `[0,1]`. Essas
são projeções de um objeto muito maior, não valores institucionais únicos.

### 3.4 Maioria depois do opt-out: presentes e apoio excedente

Com `H` fora, `N=3` é especial: há um único weak nonproposer e o resultado
terminal é único. A partir de `N=4`, passagem e falha podem coexistir, e
propostas aprovadas podem distribuir a unidade de várias formas.

Presentes positivos podem sobreviver desde `N>=4`. Apoio sobredimensionado e
gifts a eleitores não apoiadores requerem `N>=5`. Retirar um gift é outra
proposta e pode induzir outra completion off path; não é válido manter os votos
antigos por decreto ao avaliar o desvio.

### 3.5 Round 1: `H` compara acordo corrente, continuação e opt-out

Sob unanimidade, `H=no` produz opt-out imediato e payoff `o_theta`. Se `H=yes`
mas algum fraco impede a aprovação, `H` permanece ativo e chega a R2; somente
nesse ramo o payoff terminal é multiplicado por `beta`.

Assim, a decisão de `H` integra todos os vetores fracos:

```text
Delta_H(theta)
= Prob(all weak yes)*(y-o_theta)
  + sum_{w != all-yes} Prob(w)*(beta*c_H,w^theta-o_theta),

where c_H,w^theta is the H-payoff coordinate of the complete selection
kappa_i(h2^Y(w)) in C2_U(h2^Y(w);nu_w).
```

O cutoff direto `y>=o_theta` é válido apenas quando a passagem fraca é certa.
Com probabilidade positiva de falha, `H` pode aceitar `y<o_theta` se a
continuação for suficientemente boa, ou rejeitar por causa de uma continuação
ruim.

Sob maioria existem ainda os ramos de aprovação fraca após o opt-out e de
continuação weak-only. Isso reforça a possibilidade de bypass e impede uma
redução global a poucos rótulos escalares.

### 3.6 Entry: valor coletivo, não renda do proponente

Para um assessment completo `alpha` e regra `R`, o valor bruto por estado
fraco é

```text
G_R(alpha,mu)
= [(1-mu)T_W^R(alpha,0)+mu*T_W^R(alpha,1)]/(N-1),
```

onde `T_W` soma os payoffs de todos os fracos por tipo, integrando propostas,
reconhecimento e outcomes. A organização se forma se e somente se
`G_R>=chi`; na igualdade, forma.

Duas assessments com o mesmo payoff do proponente podem ter valores coletivos
diferentes, por causa de gifts, identidades e distribuições de outcomes. Entry
não pode ser inferida do payoff do proponente nem de um bound.

### 3.7 Comparação entre regras: quatro objetos diferentes

A comparação correta é o produto cartesiano das assessments completas sob U e
M. Para um par fixo:

```text
F_R(alpha_R)=[0,G_R(alpha_R,mu)]

F_U subseteq F_M  iff  G_U<=G_M.
```

Isso é diferente de comparar:

1. custos em que alguma assessment forma;
2. custos em que toda assessment forma;
3. todos os pares possíveis entre as duas regras.

Para `N>=4`, existe um par `M_only` para cada `0<chi<=1/(N-1)`. O nesting
universal M-em-U é falso. O nesting universal U-em-M e a existência geral de
um par U-only continuam pendentes.

O payoff de `H` nunca fica abaixo de `o_theta`, porque votar `no` garante o
opt-out. Mas esse floor não ordena as regras. Quando ambas formam, o sinal da
diferença é indeterminado; no par extremo `M_only`, `H` recebe exatamente seu
outside payoff em ambas.

## 4. Takeaways substantivos

### 4.1 O cutoff é mais direto quando a passagem fraca está assegurada

A informação privada de `H` gera o mecanismo de cutoff mais transparente
quando seu voto é necessário e os demais aprovam com certeza: a proposta pode
ser escolhida entre `o_0` e `o_1` para separar os tipos. Fora dessa subclasse,
o voto de `H` continua outcome-relevant porque pode alterar inclusão, opt-out ou
continuação, mas sua IC deixa de ser um cutoff direto em `y` e passa a integrar
as seleções completas de continuação.

### 4.2 Maioria expande o conjunto de opções dos fracos

O efeito primitivo da maioria não é “eliminar screening”, mas acrescentar um
ramo weak-only no qual a quota pode ser atingida após o opt-out de `H` e sua
parcela é reabsorvida. Não há uma relação de inclusão entre as correspondências
das duas regras. O resultado provado é mais estreito: existem pares completos
de assessments nos quais somente a maioria forma, sem dominância universal.

### 4.3 Regras alteram conjuntos de equilíbrio, não um único preço político

Unanimidade e maioria mudam a geometria das continuações, da inclusão de `H` e
da formação. Sob PBE sem uma seleção adicional, não há um único payoff por
regra. A pergunta correta é quais outcomes cada regra torna possíveis,
necessários ou universalmente impossíveis.

### 4.4 Estrutura de coalizão observada não identifica pivotalidade

Para `N>=5`, gifts a não apoiadores e coalizões maiores que a quota podem ser
equilíbrio; gifts positivos já aparecem em `N>=4`. Logo, observar uma coalizão
sobredimensionada não prova que os membros extras eram necessários, nem que a
ausência de um gift seria uma melhoria factível mantendo o mesmo comportamento.

### 4.5 Bargaining e formação não podem ser estudados separadamente

Selection into formation depende do assessment de bargaining. Amostras apenas
de organizações formadas misturam divisão do surplus e seleção por custo de
entrada. Custos e casos de não formação são parte substantiva do mecanismo.

### 4.6 Implicações observáveis são condicionais

O modelo não prova comparative statics empíricas nem identificação causal. Ele
sugere, para pesquisa futura, os seguintes requisitos de mensuração e
hipóteses restritas a subclasses:

- propostas completas, identidade do proponente e vetores individuais de voto
  são necessários; aprovação final isolada não identifica o mecanismo;
- na subclasse terminal de sure passage, uma hipótese testável é que concessões
  a `H` respondam a proxies de seu outside option privado;
- sob majority, acordos que excluem `H` e reabsorvem sua parcela tornam-se
  possíveis;
- o contraste teórico entre um voto indispensável e um ramo weak-only sugere
  estudar se o conteúdo informacional observado do voto de `H` varia com sua
  necessidade para a aprovação;
- qualquer desenho futuro baseado em mudanças de quota precisa manter ou
  controlar agenda, reconhecimento, simultaneidade e publicidade do ballot;
- frequências de pooling, separation, failure e oversized support podem
  disciplinar empiricamente a seleção que a teoria deixa aberta.

Esses itens são hipóteses e requisitos de desenho derivados da estrutura do
modelo, não teoremas de identificação nem previsões universais de frequência.

## 5. Arquitetura recomendada de resultados no paper

O corpo deve ser enxuto e correspondence-first. Recomenda-se no máximo os
seguintes resultados numerados.

### Definition 1 — Outcome-signature relevance and completion protocol

Enunciar como primitiva de solução, não como resultado derivado:

- se a probabilidade de uma mudança payoff-relevant no outcome signature é
  positiva, `yes` é obrigatório se e somente se sua vantagem esperada é não
  negativa;
- se essa probabilidade é zero, ambas as ações são completions admissíveis;

### Lemma 1 — Action-specific ballot incentives

Derivar, a partir da Definition 1 e do extensive form:

- a IC full-vector de `H` em R1-U, preservando a seleção completa
  `kappa_i(h2^Y(w))` e sua coordenada `c_H,w^theta`;
- a IC full-vector de cada weak voter, integrando tipos, voto de `H`, vetores
  dos demais e continuações action-specific;
- como corolário, o cutoff `y>=o_theta` somente sob sure passage.

Definition 1 e Lemma 1, em conjunto, apresentam o microfundamento sem linguagem
de quota-pivotality ou roll-call.

### Proposition 1 — Informational pivotality under unanimity

Para o subgame terminal U com `H` ativo, `N>=4`, `0<nu<1` e
`0<=o_0<o_1<=y_bar<=1`, definir:

```text
G      = 1-o_1
L(nu)  = (1-nu)(1-o_0)
M(nu)  = max{G,L(nu)}.
```

A correspondência PBE do proponente reconhecido contém:

1. para cada `V in (0,L(nu)]`, uma assessment separadora com todos os fracos
   aprovando, tipo 0 de `H` aprovando e tipo 1 fazendo opt-out;
2. para cada `V in (0,G]`, uma assessment pooling com todos aprovando;
3. assessments de falha coordenada com valor zero.

Essas são exatamente as classes puras de suporte com payoff positivo, e a
projeção do payoff do proponente é `[0,M(nu)]`. A proposition deve dizer
explicitamente que a correspondência completa retém gifts, crenças, ballots,
payoffs por tipo e identidade e outcomes.

Qualificação obrigatória: prova possibilidade de screening sob U; não prova
que todo PBE separa, que M não separa ou que `H` prefere U.

O caso `N=3`, inclusive o endpoint aberto quando `o_1=1`, deve ficar no
apêndice.

### Theorem 1 — Full-domain existence of Round-1 PBE correspondences

Para cada regra fixa `R in {U,M}` e toda primitiva admissível com `N>=3`, a
correspondência completa `A_R(P)` de PBEs de Round 1 é não vazia.

O theorem deve acrescentar que as correspondências são geralmente set-valued
e que pooling, low-only/separating e failure são subclasses construtivas, não
uma taxonomia exaustiva. A prova e os casos populacionais ficam no apêndice.

### Proposition 2 — Assessment-specific collective entry

Para qualquer `alpha_R in A_R(P)`, definir `G_R` como acima. A coalizão fraca
forma se e somente se `G_R>=chi`; igualdade forma; `chi` é externo e
subtraído apenas depois de bargaining. O operador preserva a assessment
completa e suas coordenadas alinhadas.

Acrescentar: payoff do proponente, bounds e endpoints não identificam `G_R`.

### Proposition 3 — Set-valued institutional comparison

O domínio exato é `A_U(P) x A_M(P)`. Para um par fixo,
`F_U subseteq F_M` se e somente se `G_U<=G_M`.

Se `S_R={G_R(alpha_R)}`, `l_R=inf S_R` e `u_R=sup S_R`, distinguir:

```text
possible-cost set     depende de u_R e upper attainment;
guaranteed-cost set   = [0,l_R];
universal U-in-M      iff u_U<=l_M.
```

Condições de strictness e flags de attainment podem ficar no apêndice.

### Lemma 2 — Hegemon participation floor

Para toda regra, assessment e tipo:

```text
C_1,R,H^alpha(theta) >= o_theta.
```

Na etapa de entry, se apenas U forma, U favorece fracamente `H`; se apenas M
forma, M favorece fracamente `H`; se nenhuma forma, há igualdade; se ambas
formam, o sinal não é identificado.

### Corollary 1 — Existence of an M-only assessment pair

Para todo `N>=4` e `0<chi<=1/(N-1)`, existe um par completo em que M forma e U
não forma. Nesse par, `Delta_H(theta)=0` para ambos os tipos. Isso refuta
universal M-in-U nesting, mas não estabelece majority dominance nem universal
U-in-M nesting.

## 6. Resultados para o apêndice

Preservar no apêndice, com provas ou referências internas completas:

1. correspondência fixa R2-U; impossibilidade de exatamente um weak zero;
   `N=3`, `N>=4`, `nu=1` e endpoint aberto;
2. R2-M active: classes failure/sure-passage, `rho(s)` versus prior verdadeiro,
   e projeções escalares apenas nos domínios exatos;
3. R2-M weak-only: caracterização completa, ausência de passagem estocástica,
   simplex/Minkowski, gifts positivos para `N>=4` e gifts a não apoiadores ou
   oversized support para `N>=5`;
4. fixed points necessários e suficientes de R1-U e R1-M;
5. `beta*C2` aplicado uma vez, Bayes e `kappa(h2)` público, mensurável e
   type-blind;
6. construções de existência separadas para U-`N=3`, U-`N>=4`, M-`N=3` e
   M-`N>=4`;
7. projeção exata de R1-M em `N=3` e domínios provados da projeção `[0,1]`;
8. lógica completa de infimum, supremum e attainment de entry;
9. condições estritas de nesting e tabela dos quatro formation patterns;
10. counterexamples de joint completions, gifts e falha da minimalidade.

## 7. Figuras e tabelas justificadas

### Corpo

1. **Timing/extensive form:** proposta, ballot selado simultâneo, revelação do
   vetor, opt-out/continuação, R2 e entry.
2. **Mecanismo terminal U, `N>=4`:** contra `nu`, plotar `G=1-o_1`,
   `L(nu)=(1-nu)(1-o_0)` e a projeção `[0,M(nu)]`, onde
   `M(nu)=max{G,L(nu)}`. A fronteira
   `nu*=(o_1-o_0)/(1-o_0)` indica qual classe atinge o upper envelope; não é
   uma fronteira de existência de separação. Registrar à parte que, em
   `N=3,o_1=1,nu<1`, a projeção é aberta em zero.
3. **Entry para um par fixo:** `W_R(chi)=max{G_R-chi,0}` e intervalos
   `[0,G_U]`, `[0,G_M]`.
4. **Quatro noções de nesting:** painéis separados para pairwise, possible,
   guaranteed e universal cross-assessment.
5. **Tabela de sinais:** neither, U-only, M-only, both, com sinais de
   `Delta_W` e `Delta_H`.

Não criar phase diagram de preferência de `H`, região de dominância universal,
probabilidade de cada equilibrium class, comparative static geral em `N` ou a
antiga calibração OPEC.

## 8. Claims que não podem aparecer como resultados

Não promover a theorem, proposition, corollary, caption ou conclusão:

- redução exaustiva a `P/L/R`;
- unicidade de payoff terminal ou de R1;
- majority como benchmark geral de no-screening;
- all-yes, zero gifts ou minimal winning coalition;
- entry inferida do payoff do proponente;
- inexistência de pares U-only;
- universal U-in-M nesting;
- preferência geral de `H` ou dominância institucional;
- ganho estrito de `H` no par M-only;
- No-Cheap-H como seletor de assessment;
- calibração OPEC ou janelas da arquitetura arquivada;
- resultados com `pi_H>0`, escolha endógena da regra, delayed continuation ou
  hybrid exit.

## 9. Contrato de migração claim-by-claim

Usar `tables/pivotal_response_v6_survival_matrix_v1.csv` como contrato
normativo:

```text
53 claims totais
 9 survives
13 conditional
 7 changes
12 rejected
 6 pending
 6 outside_scope
```

Na migração, cada ID `SM001`--`SM053` deve executar **literalmente a coluna
`manuscript_action`**; a ação não pode ser inferida apenas de
`current_status`. As contagens normativas são:

```text
22 retain_with_rewrite
10 replace
 9 remove
 6 pending
 6 do_not_add
```

Em particular, `SM018`, `SM019` e `SM020` têm status `rejected`, mas ação
`replace`; os outros nove claims rejeitados têm ação `remove`.

Não editar a matriz, os freezes ou o manifesto antigo. Como o manifesto
protegido inclui o Rmd e PDF do v6, a migração deve criar uma camada nova que
autorize esses dois deltas e confirme os demais `25/25` arquivos protegidos.

## 10. Plano da próxima sessão

### Gate -1 — read-only e versionamento

1. Ler `AGENTS.md` e as skills `solve-dynamic-games` e `paper-version`.
2. Confirmar Git root, `HEAD=origin/main=19c431a...` e que a única diferença no
   worktree é este handoff novo; recalcular o hash do handoff.
3. Confirmar o full-chain review, survival review, DAG `VALID`, 12 PASS e
   `Ready: none`.
4. Apresentar e pedir autorização para criar a branch, commitar somente o
   handoff, confirmar limpeza e então criar a tag no novo commit.
5. Registrar o commit tagueado sem tentar armazenar um hash autorreferente no
   próprio handoff.
6. Não editar o manuscrito antes desse boundary Git.

### Gate 0 — contrato editorial

1. Fixar a contribuição em três sentenças.
2. Fixar outline, resultados principais, resultados de apêndice e no-go list.
3. Criar mapa `SM001`--`SM053` para seções e ações do manuscrito.
4. Separar implementador e dois revisores read-only.

### Implementação

1. Reescrever abstract, introdução e conclusão com linguagem de possibilidade.
2. Reescrever o modelo e o protocolo a partir do Gate 0 congelado.
3. Migrar os resultados principais acima; mover caracterizações completas para
   o apêndice.
4. Executar literalmente `manuscript_action`: inclusive substituir
   `SM018`--`SM020` e remover somente os nove IDs marcados `remove`.
5. Criar figuras/tabelas apenas para relações identificadas.
6. Editar somente o alvo e novos artefatos específicos da migração; não tocar
   v5, standalone, interfaces, nodes, DAG, ledger ou freezes.

### Verificação e render

1. Criar `scripts/verify_pivotal_response_v6_migration.R` e checks novos.
2. Testar hashes upstream, cobertura `53/53`, domínios, claims proibidos e
   negative mutations.
3. Renderizar primeiro para `/private/tmp`.
4. Substituir `Sys.Date()` por uma data literal de release antes do render
   final, para que o PDF seja reprodutível.
5. Compilar o alvo com `rmarkdown::render("formal_model_v6.Rmd")`, respeitando
   o YAML/bookdown.
6. Verificar referências, captions, tabelas, figuras, logs e todos os valores.
7. Rasterizar e inspecionar visualmente todas as páginas.

### Revisões e freeze

1. Parecer formal/integration independente e read-only.
2. Auditoria adversarial game-theory independente e read-only.
3. Auditoria visual integral.
4. Qualquer finding exige reparo pelo implementador e rereview dos novos
   hashes.
5. Criar novo release/review/status bundle apenas após PASS `0/0/0` dos dois
   revisores.

## 11. Definition of Done

- boundary Git pré-migração tagueado e branch separada;
- todos os locks upstream exatos;
- `SM001`--`SM053` cobertos `53/53`;
- nenhum pending promovido a resultado;
- abstract, introdução, modelo, resultados, apêndices e conclusão coerentes;
- novo verifier integralmente PASS;
- PDF compilado pelo YAML, sem referência quebrada ou warning substantivo;
- data literal de release no YAML e render reproduzível;
- todas as páginas visualmente inspecionadas, com parecer visual PASS e zero
  finding aberto;
- dois pareceres substantivos independentes, exact-hash, PASS `0/0/0`;
- `25/25` protegidos não alvo inalterados;
- roots analíticos intactos e DAG ainda `VALID`, todos PASS, `Ready: none`;
- novo bundle registra hashes pré e pós-migração.

## 12. Prompt de abertura da próxima sessão

```text
Estamos no repo PowerBayesianPersuasion. Use obrigatoriamente as skills
$solve-dynamic-games e $paper-version.

Objetivo: realizar uma migração editorial controlada para formal_model_v6.Rmd
da cadeia pivotal-response PBE congelada. Use como handoff normativo
quality_reports/plans/2026-08-12_pivotal_response_v6_migration_handoff.md.
Não rederive nem reinterprete os objetos analíticos e não edite nenhum freeze.

Gate -1, inicialmente read-only:
1. confirme HEAD=origin/main=
   19c431adb3d3e9af2291f7b4efb7757091534388;
2. confirme que a única diferença no worktree é este handoff novo e recalcule
   seu hash;
3. confirme os hashes do v6, full-chain release/review/status e seus componentes
   diretos (Rmd/PDF/HTML/TeX, master verifier/checks, candidate status/visual), survival
   matrix/review, Gate 0, R2, R1, entry, comparison, DAG, ledger e manifest
   listados no handoff;
4. confirme DAG VALID, todos os 12 nós PASS e Ready none;
5. apresente e peça minha confirmação para: criar a branch
   codex/pivotal-response-v6-migration em 19c431a..., commitar somente este
   handoff, confirmar worktree limpo e criar a tag anotada
   pre-pivotal-response-v6-migration-2026-08-12 no novo commit. Não edite o v6
   antes do meu GO e desse boundary.

Após o GO, trate tables/pivotal_response_v6_survival_matrix_v1.csv como
contrato normativo de 53/53 claims. Reescreva o paper como correspondence-first:
informational pivotality sob unanimidade é uma possibilidade; majority adiciona
bypass; entry e comparação são assessment-specific; nenhum ranking universal
é autorizado.

Use no corpo apenas os resultados indicados no handoff: a definição do
protocolo de relevance/completions, o lema das ICs action-specific,
informational pivotality under unanimity, full-domain R1 existence,
assessment-specific entry, set-valued comparison, H's outside-option floor e
o corolário M-only. Leve as correspondências completas e boundaries ao
apêndice. Não use P/L/R exaustivo, majority no-screening, minimum coalitions,
zero gifts, No-Cheap-H, universal nesting/dominance, pi_H>0, endogenous rule
choice, delayed continuation ou a calibração histórica.

Execute literalmente a coluna manuscript_action para os 53 IDs. Crie um
verifier e checks novos específicos da migração, use uma data literal de
release, renderize primeiro em /private/tmp e depois compile
formal_model_v6.Rmd pelo YAML. O implementador
não revisa. Exija dois pareceres read-only independentes, auditoria visual de
todas as páginas e PASS 0/0/0 antes do freeze.
```
