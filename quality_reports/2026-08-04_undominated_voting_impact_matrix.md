# Goal 3 — Matriz de impacto PBE-UD sobre o manuscrito v6

**Data:** 2026-08-04

**Status pós-fechamento (2026-08-05): BLOQUEADA / HISTÓRICA.** O usuário adotou
`T^Y`, com aceitação na igualdade, e confirmou que R2 é resolvido sem `beta`,
descontando-se a continuação apenas quando ela entra em R1. Esta matriz mapeia a
especificação PBE-UD anterior e não pode orientar a migração ao v6. Todas as
classificações abaixo são provisórias até uma rederivação integral. Ver
`quality_reports/2026-08-05_goal3_accept_at_equality_pending.md`.

**Fonte protegida inventariada:** formal_model_v6.Rmd, SHA256
131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d

**Objeto novo de referência:** model_redesign/undominated_voting_rederivation.Rmd

**Escopo:** inventário somente leitura. Este relatório não autoriza nem executa
a migração ao v6. As linhas abaixo se referem ao arquivo protegido no snapshot
de entrada. As classificações finais usam exclusivamente os quatro rótulos
autorizados pelo Goal 3.

## Síntese executiva

Os primitivos, o timing e o argumento substantivo de poder informacional
através de pivotalidade sobrevivem. A indução retroativa atual, porém, usa
aprovação na indiferença como seleção global. Sob PBE acrescido de
admissibilidade local de votos fracamente não dominados, a migração precisa:

1. substituir a seleção global por uma correspondência de igualdade e
   sensibilidades T^Y, T^N e T^p;
2. condicionar os resultados terminais à existência de suportes gratuitos que
   realmente atinjam o máximo;
3. substituir integralmente os resultados regulares de R1 sob unanimidade e
   maioria;
4. reescrever entry, ranking de H, fronteiras e limites com as novas provas;
5. atualizar a exposição somente depois da arquitetura matemática.

## Front matter, introdução e motivação

| Linhas v6 | Objeto | Consequência PBE-UD | Classificação |
|:--|:--|:--|:--|
| 2, 36 | Título e keywords | O mecanismo geral permanece | sobrevive sem alteração |
| 37–38, primeira parte | Ambiente de duas rodadas, agenda fraca, tipo privado e opt-out | Primitivos preservados | sobrevive sem alteração |
| 38, cláusulas de resultados | Pooling exato em o1, maioria set-valued e nesting antigo | Substituir pelos resultados PBE-UD | sobrevive com reescrita |
| 57–78 | Puzzle, mecanismo, pi_H=0 e opt-out | Núcleo substantivo preservado | sobrevive sem alteração |
| 79–90 | Preview dos resultados | Usa thresholds exatos e regiões antigas | sobrevive com reescrita |
| 92–98 | Escopo do conceito de solução | Precisa introduzir PBE-UD e correspondência de igualdade | sobrevive com reescrita |
| 100–137 | Literatura e contribuição conceitual | Não depende da seleção de igualdade | sobrevive sem alteração |
| 139–154 | Exemplo terminal low-only/pooling | Manter somente condicionado a suporte terminal atingido | sobrevive com reescrita |
| 156–161 | Cutoff direto não é regra global em R1 | Continua correto e ganha importância | sobrevive sem alteração |

## Definições, protocolo, figura e tabela de escopo

| Linhas v6 | Objeto | Consequência PBE-UD | Classificação |
|:--|:--|:--|:--|
| 165–239 | Definição do jogo e equações 1–5 | Jogadores, orçamento, quota, opt-out e formação permanecem | sobrevive sem alteração |
| 241–273 | Figura 1, timing e caption | Ballot simultâneo e três ramos permanecem exatos | sobrevive sem alteração |
| 275–302 | Weak-vote-passive assessment | Preservar como disciplina de crenças; adicionar admissibilidade local | sobrevive com reescrita |
| 303–305 | Jogadores votam sim quando indiferentes | Seleção não pode permanecer como primitivo | deve ser removido do baseline |
| após 306 | Definição ausente de PBE-UD e lemas locais | Inserir definição interim, não iterada, e separar admissibilidade de PBE | sobrevive com reescrita |
| 308–328 | IC esperado de H e equações 6–7 | Fórmula permanece; acrescentar teste min–max de dominância | sobrevive sem alteração |
| 332–338 | Domínio regular e fronteiras | Domínio permanece | sobrevive sem alteração |
| 340–356 | Tabela de escopo e caption | Atualizar status, suportes e seleções | sobrevive com reescrita |

## Indução retroativa: rodada terminal

| Linhas v6 | Objeto | Consequência PBE-UD | Classificação |
|:--|:--|:--|:--|
| 362–378 | Lema terminal U e equações 9–10 | Valor S(nu) apenas se um boundary maximizador for atingido; no teto usar a correspondência proposal-contingent J_s, incluindo mistura fraca parcial e rejeição de valor zero | precisa de nova prova |
| 380–392 | Proposição terminal M e equação 11 | Payoff 1/m sobrevive condicionado a suporte gratuito vencedor | sobrevive com reescrita |
| 394–397 | R1 requer IC esperado | Permanece | sobrevive sem alteração |

## Indução retroativa: R1 sob unanimidade

| Linhas v6 | Objeto | Consequência PBE-UD | Classificação |
|:--|:--|:--|:--|
| 401–406 | Notação U, d, delta e a | P e D permanecem; preços devem vir da nova derivação | sobrevive com reescrita |
| 408–419 | Payoffs on-path exatos, equações 13–14 | Não descrevem as novas classes estritas e mistas | deve ser removido do baseline |
| 421–435 | G_L, G_P e shaving gap, equações 15–16 | Garantias em thresholds exatos deixam de ser válidas | deve ser removido do baseline |
| 437–445 | Completion lemma antigo | Incompatível com PBE-UD | deve ser removido do baseline |
| 447–474 | mu_E, existência U e payoff exato, equações 17–19 | Substituir por bar_y>o1, mu>nu2*, overpayment e mistura | deve ser removido do baseline |
| 476–481 | Interpretação do resultado U | Mecanismo sobrevive com nova correspondência | sobrevive com reescrita |

## Indução retroativa: R1 sob maioria

| Linhas v6 | Objeto | Consequência PBE-UD | Classificação |
|:--|:--|:--|:--|
| 485–496 | k, c, E, B_M e F_M | Manter k, c, E; trocar B_M por B_UD e C_UD; remover F_M global | sobrevive com reescrita |
| 497–502 | IC fraco M e equação 21 | Preservar fórmula e explicitar x<c, x=c, x>c | sobrevive com reescrita |
| 506–511 | Caso N=3 | Adicionar seleção, cap proposal-contingent Q_x e attainment; no baseline coalition-pure, outsider recebe zero | sobrevive com reescrita |
| 512–518 | Existência N=4, equação 22 | Fórmula antiga é falsa sob PBE-UD | deve ser removido do baseline |
| 519–533 | N>=5 sempre existe, intervalo e separação | Rejeitado; mesmo gate de N=4 e payoff de exclusão | deve ser removido do baseline |
| 534–540 | Bounds via F_M, equação 25 | Substituir por igualdade em N>=4 e classes em N=3 | deve ser removido do baseline |
| 543–555 | No-Cheap-H, equações 26–27 | Não transportar à nova arquitetura | deve ser removido do baseline |

## Entry, comparação e claims substantivos

| Linhas v6 | Objeto | Consequência PBE-UD | Classificação |
|:--|:--|:--|:--|
| 559–563 | Domínio PBE comum | Recalcular pela interseção dos novos domínios e suportes | sobrevive com reescrita |
| 565–585 | Entry nesting e equações 28–29 | A prova antiga cai; novo resultado usa T_U<P<=T_M | precisa de nova prova |
| 587–601 | Bounds de H e equação 30 | Novo ranking requer prova própria | precisa de nova prova |
| 603–606 | Classificação institucional | Reescrever após as novas provas | precisa de nova prova |
| 612–623 | Mapeamento OPEC dos primitivos | Permanece | sobrevive sem alteração |
| 623–630 | Pooling exato U e separação M | Trocar por U overpaid/misto e M exclusão para N>=4 | sobrevive com reescrita |
| 634–641 | Quatro implicações | Refazer após os teoremas PBE-UD | sobrevive com reescrita |
| 643–647 | Agenda power e rule choice fora do baseline | Permanece | sobrevive sem alteração |
| 649–657 | Escopo dos primitivos | Permanece | sobrevive sem alteração |
| 658–662 | Escopo weak PBE | Distinguir weak-vote-passive de PBE-UD | sobrevive com reescrita |
| 664–669 | Fronteiras | Reportar seleção e attainment explicitamente | sobrevive com reescrita |
| 673–677 | Conclusão do mecanismo | Permanece | sobrevive sem alteração |
| 679–686 | Síntese dos resultados e ranking | Depende das novas provas | precisa de nova prova |
| 688–692 | Implicação ampla | Permanece | sobrevive sem alteração |

## Apêndice A: histórias e ICs

| Linhas v6 | Objeto | Consequência PBE-UD | Classificação |
|:--|:--|:--|:--|
| 700–717 | História pública e Bayes, A1–A2 | Permanece | sobrevive sem alteração |
| 719–726 | Diferença de payoff de H em R2, A3 | Permanece | sobrevive sem alteração |
| 727–730 | p=0 implica voto sim | Na igualdade, ambas as ações podem ser admissíveis | deve ser removido do baseline |
| 732–743 | IC fraco, A4 | Preservar e acrescentar teste de dominância interim | sobrevive com reescrita |
| 745–882 | Quatro painéis de histórias e captions | Registram primitivos, não seleção | sobrevive sem alteração |

## Apêndice B: provas

| Linhas v6 | Objeto | Consequência PBE-UD | Classificação |
|:--|:--|:--|:--|
| 888–901 | Prova terminal U | Substituir por prova de suporte e attainment | precisa de nova prova |
| 903–911 | Prova terminal M | Reescrever pelo desvio epsilon e suporte gratuito | sobrevive com reescrita |
| 915–965 | Prova do completion lemma U | Incompatível com PBE-UD | deve ser removido do baseline |
| 967–992 | Prova do teorema U, B1 | Substituir integralmente | deve ser removido do baseline |
| 996–1016 | Segurança M | Substituir por E, B_UD, C_UD e attainment | deve ser removido do baseline |
| 1018–1028 | N=3 e totais, B2 | Totais sobrevivem; seleção, cap e Q1 devem entrar | sobrevive com reescrita |
| 1030–1057 | Provas N=4, N>=5 e separação | Rejeitadas | deve ser removido do baseline |
| 1059–1062 | Prova No-Cheap-H | Objeto removido | deve ser removido do baseline |
| 1066–1081 | Provas de nesting e ranking de H | Substituir pelos novos bounds | precisa de nova prova |

## Apêndice C: fronteiras e limites

| Linhas v6 | Objeto | Consequência PBE-UD | Classificação |
|:--|:--|:--|:--|
| 1085–1135 | U em o0=0, C1–C3 | Reescrever por seleção e attainment | sobrevive com reescrita |
| 1137–1154 | U em o1=1 | Não existência regular sobrevive, mas exige prova PBE-UD | precisa de nova prova |
| 1156–1198 | Fronteira beta=1, C4–C6 | Thresholds e delay reentram; no teto, mistura parcial de H gera Q_1,N para todo N, residual desconta todas as ofertas e a seleção coalition-pure zera gifts a outsiders | sobrevive com reescrita |
| 1200–1225 | Floors M, C7–C8 | Rederivar como correspondência de attainment | precisa de nova prova |
| 1227–1247 | Definição de limite unilateral, C9 | Permanece | sobrevive sem alteração |
| 1249–1258 | Limites U, C10 | Recalcular sob o novo domínio | deve ser removido do baseline |
| 1260–1322 | Floors, tabela e limites M, C11–C13 | F_M e regiões antigas são inaplicáveis | deve ser removido do baseline |
| 1324–1327 | Comparação nos endpoints | Refazer depois dos novos limites | precisa de nova prova |
| 1329–1336 | One-shot bridge | Condicionar à existência e seleção terminal | sobrevive com reescrita |

## Tabela de notação

| Linhas v6 | Objeto | Consequência PBE-UD | Classificação |
|:--|:--|:--|:--|
| 1340–1382 | Tabela e caption | Preservar estrutura e substituir objetos rejeitados | sobrevive com reescrita |
| 1352–1364 | Primitivos na tabela | Permanecem | sobrevive sem alteração |
| 1365–1372 | Notação U antiga | Trocar por K, nu2*, B(nu), A e Ecal | deve ser removido do baseline |
| 1373–1374 | c e E | Manter com qualificação de suporte e existência | sobrevive com reescrita |
| 1375–1376 | B_M e F_M | Trocar por B_UD, C_UD e Q1 | deve ser removido do baseline |
| 1377–1380 | bar_o, formação e limites | Definições válidas; atualizar referências | sobrevive com reescrita |

## Ordem segura para o Goal 4

1. Inserir PBE-UD e os lemas locais na definição da solução.
2. Substituir os dois resultados terminais e suas provas.
3. Substituir integralmente R1-U e R1-M.
4. Rederivar e transportar entry, ranking de H, fronteiras e endpoints.
5. Atualizar abstract, introdução, discussão, conclusão, tabela de escopo e
   notação por último.
6. Preservar sem alteração a definição do jogo, a Figura 1 e os quatro painéis
   de histórias do Gate 0.

Novos resultados devem receber labels internos novos ou substituir
integralmente os labels rejeitados. Reutilizar labels antigos sugeriria
continuidade lógica onde a prova e o objeto mudaram.
