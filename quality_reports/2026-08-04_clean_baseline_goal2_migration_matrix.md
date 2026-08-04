# Matriz de migração e auditoria de sobrevivência — Goal 2

**Data:** 2026-08-04
**Fonte canônica:** `model_redesign/power_architecture_derivations.Rmd`
**Alvo:** `formal_model_v6.Rmd`
**Estado do alvo nesta auditoria:** read-only; SHA-256
`f18a999300c88e32bdc7542f3249cd258afd19a0c251c0b29c2c387a7131dbc1`.

## Regra de classificação

- **sobrevive sem alteração:** o conteúdo substantivo e o escopo já coincidem
  com o baseline fechado; ajustes apenas tipográficos não mudam a classe.
- **sobrevive com reescrita:** há um resultado estável correspondente, mas
  notação, domínio, prova, escopo ou exposição de v6 precisam mudar.
- **precisa de nova prova:** o objeto não foi fechado no laboratório; fica fora
  da migração até derivação e revisão independentes.
- **deve ser removido do baseline:** o objeto pertence à arquitetura antiga ou
  contradiz um resultado fechado.

## A. Enquadramento, primitivas e protocolo

| ID | Resultado estável / objeto em v6 | Fonte no laboratório | Local correspondente em v6 | Classificação | Ação de migração |
|---|---|---|---|---|---|
| A1 | Título, pergunta sobre informational power through pivotality e ausência de agenda power | Status; `pi_H=0` | YAML; Introduction; Conclusion | **sobrevive sem alteração** | Preservar o título e a pergunta; alinhar apenas os resultados anunciados. |
| A2 | Bolo fraco fixo normalizado em 1; `y` reduz o residual um-para-um | Gate 0, players e budget | Motivating Example; Definition `def:game` | **sobrevive sem alteração** | Preservar a interpretação substantiva; usar as identidades exatas do Gate 0. |
| A3 | `pi_H=0` em todas as rodadas e reconhecimento `1/m` entre fracos | Horizon and recognition | Abstract; Introduction; Definition `def:game`; Scope | **sobrevive sem alteração** | Manter literalmente em todas as rodadas e evitar qualquer ramo proponente de `H`. |
| A4 | `b_0=b_1=0`; payoff corrente de `H` igual a `y` | Players/type/parameters | `def:game`, parágrafo “Hegemon payoff” | **sobrevive com reescrita** | Substituir `o_theta+y-t_theta` por `y`; retirar threshold líquido antigo. |
| A5 | Contrato `s_i=(y,(x_j)_{j!=i})`, residual do proponente e reabsorção de `y` quando maioria exclui `H` | Contract space; `G0-H-budget`--`G0-budget-closure` | `def:game`; Majority; Appendix proofs | **sobrevive com reescrita** | Especificar inclusão observável, budgets H-including/weak-only e outside option externo. |
| A6 | Dois rounds, R2 terminal e unidades temporais | Horizon, recognition and time units | `def:game`; Figure `fig:timing`; Appendix B | **sobrevive com reescrita** | Distinguir acordo, `H`-no/opt-out e `H`-yes seguido de falha fraca; remover seta genérica “fail -> R2”. |
| A7 | Opt-out imediato e irreversível `o_theta` depois de `H`-no em R1 | Immediate opt-out; history table | Ausente/incorreto em `def:game`; timing figure; provas | **sobrevive com reescrita** | Inserir como primitivo central; impedir reinclusão e dupla remuneração. |
| A8 | Mesmo ballot simultâneo sob U e M; proposer conta sim; vetor público após fechamento | Common simultaneous ballot | `def:game`; equilibrium assessment; Figure `fig:timing` | **sobrevive sem alteração** | Preservar; explicitar que não é roll-call. |
| A9 | Quota original após opt-out; unanimidade futura impossível; maioria pode seguir weak-only | Common ballot; immediate opt-out; histories | Ausente em v6 | **sobrevive com reescrita** | Integrar no contrato e nas provas; não recalcular quota. |
| A10 | Formação coletiva/all-or-nothing por payoff fraco médio | Formation; `G0-entry-value` | `def:game`; Entry section | **sobrevive com reescrita** | Remover a equivalência não provada com preferência individual realizada; manter média per capita. |
| A11 | Conhecimento comum e PBE com escopo explícito | Common knowledge and solution concept | Equilibrium assessment | **sobrevive com reescrita** | Inventariar estratégias/crenças e declarar o escopo de cada resultado. |
| A12 | Avaliação *weak-vote-passive* e liberdade de crenças globalmente off-path sob PBE fraco | Belief discipline; public histories | Definition `def:passive`; Table `tab:assessment-scope`; Appendix B.1 | **sobrevive com reescrita** | Retirar as regras antigas automáticas `nu=1/0`; declarar ballot belief, posterior de continuação e limitação frente a sequential equilibrium. |
| A13 | Domínio regular `mu in (0,1)`, `beta in (0,1)`, `0<o0<o1<1` | `regular-domain` | Table `tab:baseline-domain`; theorem statements | **sobrevive com reescrita** | Substituir Threshold Orders em `t/a` pelo domínio limpo e separar fronteiras. |
| A14 | Regras institucionais exógenas; sem escolha endógena | Gate 0; scope exclusions | Abstract; Introduction; Scope | **sobrevive sem alteração** | Preservar como limite do baseline, sem criar estágio de signaling. |
| A15 | Domínio primitivo `0<=o0<o1<=ybar<=1`, `beta in (0,1]` e `y in [0,ybar]` | `G0-domain`; contract space | `def:game`; domain table; notation | **sobrevive com reescrita** | Transportar antes do domínio regular; não perder o bound do pacote nem confundi-lo com state-contingent feasibility. |
| A16 | Jogadores, tipo persistente, prior e outside payoff fraco zero | Players, type, prior and parameters | `def:game`; notation | **sobrevive com reescrita** | Manter `N>=3`, `m=N-1`, tipo binário conhecido só por `H`, prior compartilhado e normalização fraca zero. |
| A17 | Information set `I=(h,s_i)`, história completa `h2` e separação entre posterior e continuação | Public histories and beliefs | Definition `def:passive`; protocol appendix; proofs | **sobrevive com reescrita** | Exigir que `h2` contenha proposta, voto de `H`, vetor fraco, quota e opt-out; indexar `C_H2(theta,h2)` por história e `nu(h2)` separadamente. Não usar `C_theta(nu)` como continuation posterior-sufficient. |
| A18 | Tabela Gate 0 com 21 classes de históricos | Exhaustive voting-history table; TSV canônico | Sem equivalente completo; Figure `fig:timing` é insuficiente | **sobrevive com reescrita** | Incluir contrato autônomo e tabela/painel resumido no apêndice, mantendo o TSV como fonte auditável. |
| A19 | Dois tie-breaks e nenhum terceiro | Tie-breaking | Definition `def:passive`; theorem boundaries | **sobrevive com reescrita** | Manter yes em empate e minimizar payoff esperado de `H` entre propostas ótimas; deixar outros ties set-valued ou usar domínio estrito. |
| A20 | Payoffs de desvios avaliados no prior verdadeiro, distintos da crença declarada no ballot off-path | Belief discipline and theorem domains | Ausente | **sobrevive com reescrita** | Declarar antes do completion lemma; essa distinção gera as descontinuidades dos security values. |

## B. Backward induction e resultados formais

| ID | Resultado estável / objeto em v6 | Fonte no laboratório | Local correspondente em v6 | Classificação | Ação de migração |
|---|---|---|---|---|---|
| B1 | R2 unanimidade: `P=1-o1`, `L(nu)=(1-nu)(1-o0)`, `S=max{P,L}` e cutoff | `R2-U-value`; `R2-U-cutoff` | Lemma `lem:r2`; Terminal Round; Appendix A.2 | **sobrevive com reescrita** | Trocar `t0,t1` por `o0,o1`; preservar tie low-only e escopo all-PBE do payoff terminal. |
| B2 | R2 maioria: proponente retém o bolo; `C_W2^M=1/m`; `H` recebe outside payoff | `R2-M-values` | Majority terminal benchmark; Appendix A.1 | **sobrevive com reescrita** | Reescrever com ramos ativo/weak-only e outside option externo. |
| B3 | IC esperado de `H` em R1 e cutoff direto apenas sob implementação certa | `G0-H-yes-R1`--`G0-H-IC-R1`; `G0-direct-cutoff` | `def:game`; R1 U/M proofs | **sobrevive com reescrita** | Incluir IC sobre vetores simultâneos; não usar `a_theta=t_theta-o_theta+beta C_theta`. |
| B4 | IC terminal de R2: diferença `beta*p*(y-o_theta)` | `G0-H-R2-difference` | Terminal proof / protocol appendix | **sobrevive com reescrita** | Distinguir `p>0` e `p=0`; não promover como regra global de R1. |
| B4a | IC esperado de cada weak voter no ballot simultâneo | `G0-W-IC` | `def:game`; R1 U/M proofs | **sobrevive com reescrita** | Enunciar o IC geral antes das especializações; ofertas nomeadas são pagas quando o acordo passa mesmo após voto individual não. |
| B5 | R1 U: security values `G_L,G_P` e off-path completion/guarantee lemma | `U-security`; `U-low-guarantee`; `U-pool-guarantee` | Substitui `lem:weak-caused-nonpivotal` e `lem:rejected-histories`; Appendix A.3 | **sobrevive com reescrita** | Transportar as duas direções da prova e o par de crenças off-path. |
| B6 | Existência regular U iff `beta*o1>=o0` e `G_P>G_L` (`mu>mu_E`) | `U-existence`; `U-existence-cutoff` | Substitui Proposition `prop:r1` | **sobrevive com reescrita** | Enunciar iff, strict tie e regiões sem PBE; não alegar seleção global. |
| B7 | Todo PBE regular U existente tem classe on-path pooling: `y=o1`, `T_W=P`, `H=o1` | `U-regular-payoffs` | R1 unanimity; Entry; H comparison; Abstract | **sobrevive com reescrita** | Substituir máximos P/L/D e claims de low-only/delay no interior. |
| B8 | R1 low-only regular desaparece; delay/rejection regular não sobrevive | `U-shaving-gap`; on-path candidates | Current low-only `L`, delay `D`, Remark `rem:delay` | **deve ser removido do baseline** | Remover candidatos, regiões, interpretação dinâmica e proofs correspondentes. |
| B9 | Fronteira `o0=0`: low-only, pooling canônico/sobrepago e multiplicidade sob condições exatas | `U-zero-low-security`--`U-zero-low-overpay` | Nova subseção em Appendix A; menção de escopo no body | **sobrevive com reescrita** | Transportar separadamente, incluindo tie-break e bounds de `y<=ybar`. |
| B10 | Fronteira `o1=1`, `o0>0`, `beta<1`: não existência U | “No terminal weak surplus” | Nova subseção em Appendix A | **sobrevive com reescrita** | Registrar como região de não existência, não como continuidade do interior. |
| B11 | Fronteira `beta=1`: rejection/continuation e multiplicidade podem reaparecer | `U-beta-one-security`--`U-beta-one-overpay` | Nova subseção em Appendix A | **sobrevive com reescrita** | Manter como único locus baseline de delay on-path, sem restaurar redução global. |
| B12 | R1 M: `F_M=max{E,B_M,P}` é security value exato | `M-security`; voting reduction | Substitui Proposition `prop:majority` | **sobrevive com reescrita** | Reescrever toda a maioria a partir do contrato limpo. |
| B13 | Majority `N=3`: proposer payoff exato `F_M`, classes e totals | `M-N3-value`; `M-N3-totals` | Majority proposition/proof | **sobrevive com reescrita** | Incluir ties e escopo de propostas puras/misturas. |
| B14 | Majority `N=4`: PBE existe iff `E>=B_M` ou `P>B_M` | `M-N4-existence` | Majority proposition/proof | **sobrevive com reescrita** | Incluir região sem PBE e boundary `B_M=P>E`. |
| B15 | Majority `N>=5`: PBE sempre; proposer payoff `[F_M,1]`; exclusão, separação e pooling | `M-large-value`; `M-large-separating`; `M-weak-bounds` | Majority proposition/proof | **sobrevive com reescrita** | Transportar construção de suficiência inclusive no piso; majority é set-valued. |
| B16 | Majority no-screening não é all-PBE | Majority characterization; No-Cheap changes | Abstract; Introduction; Proposition `prop:majority`; Scope | **deve ser removido do baseline** | Retirar benchmark único `V_W^M=1/m` e payoff único de `H`. |
| B17 | No-Cheap-H uniforme muda para `o0>=k*beta/m` e não elimina separação para `N>=5` | `M-no-cheap-gap`; `M-no-cheap-strong` | No-Cheap discussion; figure `fig-no-cheap-h` | **sobrevive com reescrita** | Substituir fórmula antiga; remover promessa de no-screening global. |
| B18 | Bounds de fronteira da maioria em `beta=1` e `o0=0` | `M-beta-one-floor`; `M-zero-low-floor` | Nova subseção Appendix A/B | **sobrevive com reescrita** | Rotular como bounds, não como caracterização completa nem comparação. |
| B19 | Priors `mu=0,1` como cluster correspondences laterais, não jogos degenerados literais | `endpoint-limit`; U/M endpoint limits | Equilibrium assessment; Appendix A | **sobrevive com reescrita** | Remover convenção antiga vaga e transportar limites por tamanho de grupo. |

## C. Entry e comparação institucional

| ID | Resultado estável / objeto em v6 | Fonte no laboratório | Local correspondente em v6 | Classificação | Ação de migração |
|---|---|---|---|---|---|
| C1 | Domínio comum derivado: U-existence e, para `N=4`, M-existence | Common PBE domain | Entry section; comparison proposition | **sobrevive com reescrita** | Antepor o domínio a toda comparação; não o chamar de assumption ad hoc. |
| C2 | `F_M>=P`, logo todo PBE M dá `V_W^M>=P/m=V_W^U` | `comparison-floor`; `entry-nesting` | Proposition `prop:nesting`; Appendix A.4 | **sobrevive com reescrita** | Preservar nesting como selection-free apenas no domínio comum. |
| C3 | Formação: ambos / apenas M / nenhum, dado um payoff majoritário selecionado `v_M` | Conditional institutional comparison | Corollary `cor:classification`; OPEC classification table | **sobrevive com reescrita** | Substituir partição de cinco conjuntos baseada em `Delta_H`. |
| C4 | `bar o <= E[u_H^M] <= o1=E[u_H^U]` | `H-payoff-bounds` | Proposition `prop:h-comparison`; Conclusion | **sobrevive com reescrita** | Quando ambos formam, U favorece fracamente `H`; igualdade só sob pooling M. |
| C5 | Ranking por `Delta_H(mu)` com cruzamento `.943` | Current equations (22)--(31); worked example | Entry; example; abstract; discussion | **deve ser removido do baseline** | Não há payoff majoritário único nem crossing correspondente no clean game. |
| C6 | Colisão de `F_M`: security value limpo versus conjunto de formação atual | `M-security`; `formation-nesting` | Eq. (19) atual e notation table | **sobrevive com reescrita** | Reservar `F_M=max{E,B_M,P}` ao security value e renomear conjuntos de formação como `mathcal F_R`. |
| C7 | Dominância institucional global | Não existe; explicitamente excluída | Framing e conclusion | **deve ser removido do baseline** | Usar apenas comparação condicional à formação e ao domínio comum. |

## D. Exposição, exemplos, figuras e apêndices

| ID | Objeto em v6 | Dependência atual | Local em v6 | Classificação | Ação de migração |
|---|---|---|---|---|---|
| D1 | Abstract e parágrafos de “quatro resultados” | `t/a`, P/L/D, no-screening, `.315`, `.943` | YAML abstract; Introduction | **sobrevive com reescrita** | Reescrever integralmente com existência U, pooling regular, M set-valued e comparação condicional. |
| D2 | Revisão de literatura e mecanismo de pivotality | Enquadramento conceitual majoritariamente estável | Literature | **sobrevive com reescrita** | Preservar contribuições/citações; retirar continuation-priced low-only e delay como resultado regular. |
| D3 | Motivating Example terminal | Mesma lógica algébrica, mas usa `t0,t1` | Motivating Example | **sobrevive com reescrita** | Usar `o0,o1`, explicitar ambiente terminal/certain implementation e não extrapolar para R1. |
| D4 | Figure `fig:timing` | Toda falha leva genericamente a R2 | Model | **sobrevive com reescrita** | Redesenhar com H-no opt-out, H-yes/weak-failure e ramos U/M. |
| D5 | Tables `tab:baseline-domain` e `tab:assessment-scope` | Threshold Orders e lema antigo | Model | **sobrevive com reescrita** | Reconstruir com domínio regular, fronteiras, escopos e crenças weak-PBE. |
| D6 | Figure `fig-no-cheap-h` | Fórmula antiga em `t0,a0M` | Majority | **deve ser removido do baseline** | Só substituir por nova figura se derivada em R e auditada; não reutilizar PDF. |
| D7 | Figure terminal regions | `t0,t1` e exemplo antigo | Terminal U | **sobrevive com reescrita** | Regenerar em `o0,o1` ou omitir; caption deve declarar escopo R2. |
| D8 | Figure R1 candidate regions e Figure `fig:result-logic` | P/L/D, delay e no-screening único | R1 U | **deve ser removido do baseline** | Substituição opcional requer figura nova de existência/arquitetura limpa. |
| D9 | Main Worked Example, phase diagram, tables/chunks e claims `.315/.943` | Parâmetros `o0=o1`, `t/a`, P/L/D e `Delta_H` | Main Worked Example | **deve ser removido do baseline** | Remover do texto e deixar CSV/PDF antigos apenas como história não citada. |
| D10 | Substituição numérica não fechada no Goal 1 | Não é resultado do laboratório | Possível seção futura | **deve ser removido do baseline** | Omitir neste Goal. Uma futura ilustração exigirá derivação computacional, script R e revisão, mas não deve ser chamada de nova prova formal. |
| D11 | OPEC mapping e interpretação | Usa `t_theta`, low-only R1 e delay | Discussion tables/prose | **sobrevive com reescrita** | Mapear `o_theta` à opção/threshold de participação; remover predictions não provadas. |
| D12 | Scope sobre `pi_H>0` e rule choice | Limites do modelo estáveis | Scope; Appendix B.3 | **sobrevive sem alteração** | Manter apenas como non-goals, sem resultados ou fórmulas de extensão. |
| D13a | Observable implications atuais baseadas em switching P/L/D e `Delta_H` | Arquitetura antiga | Discussion | **deve ser removido do baseline** | Remover claims de low-only/delay regular, crossing e maioria escalar. |
| D13b | Implicações diretamente dedutíveis dos teoremas limpos | R2 screening, U pooling regular, M correspondence e bounds | Discussion | **sobrevive com reescrita** | Limitar a redação ao que segue dos resultados fechados; qualquer implicação adicional **precisa de nova prova** e fica fora deste Goal. |
| D14 | Conclusion | Ranking por `Delta_H` e majority no-screening | Conclusion | **sobrevive com reescrita** | Reescrever para pooling regular U, M set-valued e comparação condicional. |
| D15 | Appendix A.1--A.5 atual | Provas em `t/a`, P/L/D e `Delta_H` | Appendix A | **deve ser removido do baseline** | Substituir integralmente pelas provas transportadas do laboratório, sem omitir fronteiras. |
| D16 | Appendix B.1 weak-vote-passive | Crenças antigas e lema nonpivotal | Appendix B.1 | **sobrevive com reescrita** | Declarar o par de crenças off-path e a dependência de PBE fraco. |
| D17 | Appendix B.2 threshold microfoundation `t=d-b` | Arquitetura explicitamente excluída | Appendix B.2 | **deve ser removido do baseline** | Não manter como microfundamento neste Goal. |
| D18a | One-shot bridge como interpretação isomorfa do R2 terminal | `R2-U-value`; `R2-U-cutoff` | Appendix B.3 | **sobrevive com reescrita** | Pode permanecer somente como leitura do subgame terminal já provado, em `o0/o1`; não apresentá-lo como jogo autônomo adicional. |
| D18b | Complete-information benchmark como jogo próprio | Não rederivado no Goal 1 | Appendix B.3 | **precisa de nova prova** | Omitir durante a migração; eventual retorno exige derivação separada sob opt-out imediato. |
| D19 | Comparative statics, region sweep e delay example | `t/a`, P/L/D e dados antigos | Appendix B.4--B.5 | **deve ser removido do baseline** | Remover chunks, tabelas, captions e interpretações; novas estáticas exigem derivação própria. |
| D20 | Notation table | Inventário quase todo antigo | Appendix C | **sobrevive com reescrita** | Reconstruir com `o0,o1,P,L,S,G_L,G_P,mu_E,E,B_M,F_M,K0,K1` e escopos. |
| D21 | YAML/bookdown, bibliography e infraestrutura LaTeX | Independente da arquitetura | Front matter | **sobrevive sem alteração** | Preservar formato de compilação; remover apenas helpers R sem consumidores. |
| D22 | Delayed continuation como payoff de `H`-no, hybrid exit `max{o_theta,beta C_theta}`, viabilidade/C-B-R e branches A/C/R | Arquiteturas explicitamente excluídas | Qualquer corpo, prova, caption, tabela ou notação | **deve ser removido do baseline** | Não transportar fórmulas, labels ou resultados; uma continuação após `H`-yes/weak-failure permanece legítima e deve ser distinguida semanticamente. |

## E. Reprodutibilidade e artefatos

| ID | Objeto | Estado | Classificação | Ação |
|---|---|---|---|---|
| E1 | Seis scripts e outputs `clean_optout_*` do Goal 1 | 96/96 e revisão R PASS | **sobrevive sem alteração** | Reexecutar; não mudar fórmulas para acomodar o manuscrito. |
| E2 | Scripts, CSVs e figuras `relative_package_*` atualmente usados por v6 | `scripts/plot_relative_package_regions_piH0.R`, `scripts/revise_v5_coarse_review_checks.R` e artefatos `relative_package_*` | **deve ser removido do baseline** | Remover includes/chunks; arquivos podem permanecer como história não citada e não são evidência do baseline limpo. |
| E4 | PDF v6 atual | Compila arquitetura antiga | **deve ser removido do baseline** | Substituir somente por render YAML/bookdown do Rmd migrado e auditado. |

O novo verificador de integração v6 é uma entrega de implementação, não um
resultado formal e, portanto, não recebe classificação de sobrevivência. Ele
deve ser rotulado como check reproduzível, nunca como prova.

## Resultado da auditoria de sobrevivência

O v6 atual não pode receber correções pontuais. A incompatibilidade atravessa
o payoff de `H`, o timing do opt-out, as ICs, o conjunto de equilíbrios, a
existência, o benchmark majoritário, entry, o ranking institucional, o exemplo
e as provas. A ação coerente é um reset editorial controlado das seções
formais, preservando apenas o framing, a infraestrutura e os componentes que a
matriz marca como sobreviventes.

**Blockers antes de editar v6:**

1. aprovação explícita do snapshot `paper-version`;
2. veredito independente sobre esta matriz;
3. designação de implementador que não será revisor;
4. compromisso de omitir todos os itens `precisa de nova prova`.

## Rodada 1 da auditoria independente da matriz

- Revisor: agente read-only `/root/survival_auditor`.
- Edição pelo revisor: nenhuma.
- Veredito: `REPAIR`.
- Reparos solicitados: taxonomia de nova prova; arquiteturas excluídas;
  indexação por história completa; colisão de `F_M`; domínio primitivo; e
  separação entre one-shot e complete information.
- Resposta: incorporada nas linhas A15--A20, C6--C7, D10, D13a--D13b,
  D18a--D18b, D22 e na nota de E2--E4.

## Rodada 2 da auditoria independente da matriz

- Revisor: o mesmo agente read-only `/root/survival_auditor`.
- Edição pelo revisor: nenhuma.
- Escopo: cobertura integral; taxonomia; arquiteturas excluídas; indexação por
  história completa; colisão de `F_M`; domínios primitivo e regular; e
  separação one-shot/complete information.
- Veredito: **`PASS` sem ressalvas substantivas**.

**Status do Gate 0:** **`PASS`**.
