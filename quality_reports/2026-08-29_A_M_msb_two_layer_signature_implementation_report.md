# Relatório de implementação — assinatura de `A_M` em duas camadas

**Data:** 2026-08-29

**Status:** `IMPLEMENTER CANDIDATE COMPLETE — TWO FRESH FORMAL REVIEWS PENDING`

**Natureza:** registro de implementação e rastreabilidade. Não é parecer
formal, não aprova os novos bytes e não substitui nenhuma das duas revisões
independentes exigidas.

## 1. Resultado do passe

A decisão autoral aprovada foi implementada no mesmo worktree e branch do
reparo anterior. O snapshot pré-implementação foi
`9ff11e4c0f41b95dadc026efb77072197ce487ec`; o commit substantivo produzido é
`e020629d5bad8fbd66d67cf108b1a2e0d8b048fd`.

O defeito dos pareceres anteriores foi removido sem mudar as primitivas, o
conceito M/S/B ou a caracterização de equilíbrios que sobreviveu. A antiga
média componentwise de Reynolds deixou de ser chamada de quociente exato ou
representante. Em seu lugar, há agora:

```text
camada exata:     Sig_ex_M=(rho,nu_off,Lambda_(Gamma_0,Gamma_1));
camada econômica: Sum_econ_M=(rho,nu_off,(q_Z)#Gamma_0,(q_Z)#Gamma_1).
```

## 2. Mapa decisão → implementação → evidência

| Item aprovado | Implementação | Localizador |
|---|---|---|
| camada exata | ação diagonal de `S_m` em `P(Z)^2`; lei de órbita `Lambda`; prova de Borelidade, invariância e completude | resultados, §§9.1 e 9.2.1; ledger `AMX-016a` |
| representante real | mínimo sob isomorfismo Borel fixado, dentro da órbita; par realizado por um PBE relabelado; nenhuma alegação de seletor no espaço bruto de assessments | resultados, §9.2.1 |
| quadro Borel-padrão | `Y` e `X_M` compactos poloneses; `Omega_D` construído como conjunto finito discreto dos registros terminais efetivamente usados; `Omega_T`, `Z` e espaços de medidas tipados | resultados, §9.1 |
| resumo por `Z/G` | transversal Borel, `q_Z`, pushforwards por tipo e lema de fatorização de estatísticas invariantes | resultados, §9.2.2; ledger `AMX-016b` |
| estatísticas econômicas | payoffs de `H`, acordo/atraso, lei do posterior, outcome/continuação anônimos e lei anônima dos payoffs fracos | resultados, §9.2.2 |
| Reynolds rebaixado | quatro limitações explícitas; não completude `P/Q`; não realizabilidade por posterior público contraditório | resultados, §9.2.3; script, §16 |
| misturas e revelação | separação entre mistura com suportes disjuntos, mistura que altera Bayes e o par `P/Q` | resultados, §9.2.4; ledger `AMX-MSB-010` |
| consumo downstream | produto fibrado exato primeiro; constância setwise e fatorização mensurável por operação antes de usar o resumo | resultados, §9.3; ledger `AMX-016b` |
| endpoints | assinaturas exata e econômica próprias na fibra `*`, sem Reynolds e sem divisão por prior nulo | resultados, §9.3 |
| finding menor | distinção átomo/ponto de massa zero; provas atômica e setwise; prova de `AMX-011` sem atomicidade | resultados, §8.3; `AMX-015` substantivamente inalterado |
| teorema cardinal | prova atomless preservada; apenas a codificação da órbita foi trocada | resultados, §9.4; ledger `AMX-MSB-009` |
| evidência mecânica | regressões finitas em `S_4`, novo output versionado | script, §16; output de verificação; ledger `AMX-013` |

## 3. Fechamento dos espaços mensuráveis

O prompt exigia verificar, e não apenas assumir, que o carrier de `Gamma` era
Borel-padrão. `Y` e `X_M` já permitiam a prova. A única lacuna de tipagem era
`Omega_D`, antes apenas denominado “espaço Borel”.

O reparo é técnico e determinado pelos representantes já aprovados: para `N`
e primitivas fixos, `Omega_D` reúne os registros terminais tagueados nos
suportes dos kernels uniformes `E`, `S` e `P`. Há finitas identidades,
coalizões, votos e propostas canônicas; `EP` apenas mistura `E/P` e não cria
novo suporte. Logo `Omega_D` é finito discreto. Isso fecha
`Omega_T`, `Z`, `P(Z)^2` e `P(P(Z)^2)` sem acrescentar seleção econômica ou
alterar `C_M`.

## 4. Intuição e conteúdo formal das duas camadas

A camada exata responde “é literalmente o mesmo equilíbrio, salvo renomear
todos os Estados fracos de uma só vez?”. Ela guarda o par inteiro dos planos
por tipo. `Lambda_x` lista uniformemente a órbita desse par no metaespaço. A
prova de completude usa um fato simples: `Lambda_x` dá massa positiva
exatamente aos pontos da órbita; por isso duas leis de órbita iguais têm a
mesma órbita.

A camada econômica responde “as distribuições de registros realizados são as
mesmas depois de apagar apenas os nomes?”. O mapa `q_Z` apaga o nome dentro do
registro inteiro, sem separar proposta, posterior, timing, continuação e
outcome. Toda função Borel invariante a nomes fatora por esse mapa, e sua
integral pode ser calculada pelo pushforward.

As camadas não competem. `x^P` e `x^Q` têm interseções contrafactuais de
coalizões diferentes, portanto órbitas exatas diferentes; registro a registro,
porém, produzem as mesmas leis anônimas por tipo, logo têm o mesmo resumo. É
precisamente a perda de informação que agora está declarada e confinada à
camada econômica.

## 5. Reynolds e misturas

O baricentro de Reynolds continua calculável, mas somente como estatística
marginal. Ele não é completo para a órbita diagonal, não conserva a relação
entre planos dos tipos, pode exigir dois valores contraditórios do posterior
na mesma mensagem e não é presumido PBE.

A frase sobre misturas recebeu o escopo aprovado:

1. identidade formal só por uma permutação comum do perfil inteiro;
2. mesmo resumo exatamente quando as leis anônimas por tipo coincidem;
3. pesos diferentes sobre rótulos com suportes dos tipos disjuntos podem ter
   o mesmo resumo e assinaturas exatas distintas;
4. quando os dois tipos misturam sobre o mesmo suporte, Bayes e a lei do
   posterior mudam, de modo que as duas camadas distinguem o novo experimento.

## 6. Reparo da Seção 8.3

O texto antigo confundia “pertence ao suporte” com “tem massa positiva”. O
reparo mantém a desigualdade de melhor resposta ponto a ponto no suporte, mas
reserva a igualdade para `sigma_theta`-quase todo ponto. Num átomo com
posterior interior, Bayes força massa positiva dos dois tipos e restaura a
igualdade pontual para ambos. Nos pontos de massa zero não há essa conclusão.

As identidades setwise

```text
sigma_1({pi=0})=0,
sigma_0({pi=1})=0
```

seguem das fórmulas integrais de Bayes. A prova de `AMX-011` foi escrita sem
atomicidade: imitação de uma proposta aprovada usada pelo alto dá uma
desigualdade; monotonicidade do payoff de atraso e imitação dos sinais do
baixo dão a desigualdade oposta.

## 7. Ledger e verificação mecânica

O antigo `AMX-016` foi substituído por `AMX-016a` e `AMX-016b`.
`AMX-MSB-010` foi reenunciado; `AMX-015` não foi substantivamente alterado;
`AMX-MSB-009` preserva o teorema cardinal. O ledger tem 31 linhas e 16 campos
em todas.

O verificador passou:

```text
env LC_ALL=C LANG=C Rscript scripts/verify_agenda_extension_A_M_msb.R
SUMMARY | 3954 PASS | 0 FAIL
```

As dez novas regressões verificam `P/Q`, `Lambda_(g.x)=Lambda_x`, a identidade
do pushforward por `q_Z`, as misturas `(.9,.1)`/`(.5,.5)` e a lei do
posterior. Código finito não prova a proposição Borel, o lema de fatorização
geral ou qualquer PBE.

## 8. Escopo institucional e próximo gate

Este passe foi de implementação. As leituras auxiliares e a QA de integração
foram assistência ao implementador e não contam como parecer formal. Ainda
são necessários dois pareceres formais independentes, de sessões frescas,
sobre exatamente os bytes do manifesto.

Até lá:

- nenhum claim novo é `pass/frozen`;
- `AC/AR` não consomem `A_M`;
- `A_U` continua pendente de auditoria própria;
- não houve tag, merge, push ou alteração de N1–N7/manuscrito.

O preflight detalhado está em
`quality_reports/2026-08-29_A_M_msb_two_layer_signature_preflight.md`. O
manifesto não autorreferente acompanha este relatório no commit de fechamento.
