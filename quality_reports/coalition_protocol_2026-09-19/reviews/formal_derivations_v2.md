# Parecer formal independente — derivações v2 e transporte ao manuscrito

**Veredicto: PASS em duas fronteiras delimitadas.** Os 17 claims matemáticos do bundle v2 estão sustentados pelas provas revisadas; o preview transporta esses resultados e mantém consistentes os 20 claims de seu contrato, no escopo formal e interpretativo. F-001, F-002 e F-003 estão resolvidos. Não surgiu novo finding aberto. O FAIL do candidato v1 permanece válido para seus bytes históricos.

**Revisor:** `/root/baseline_source_read`, 19/09/2026. Não implementou as notas, o lema ou os patches e não editou as fontes candidatas. O parecer v1 propôs os reparos agora implementados por outros agentes. O revisor produziu os contratos interpretativos, função distinta desta auditoria científica. Leu os relatórios independentes de compreensão autorizados, sem consultar o parecer científico/adversarial corrente de B.

## 1. Identidade e fronteiras

Nas referências, **B2** são linhas do bundle v2, **P** são linhas do preview e **M** são linhas do original preservado. Um PASS abaixo não se estende automaticamente à próxima versão nem constitui validação empírica, bibliográfica, visual ou autorização de submissão.

| Objeto | SHA-256 | Alcance |
|---|---|---|
| [bundle_v2](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/derivation_bundle_v2.md) | `3b8043d49de9011a60c1e7e079b4fbf876f35239d100dad82a0072b53a19b4e2` | Cinco notas, 17 claims; fechamento matemático |
| [manifest_v2](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/reviews/derivation_candidate_v2.json) | `8f6603ff00050b6870995d4d893eeeb2bdffe13e0a90304b19b3574de8b7e9f1` | Dez membros conferidos |
| [notes_gate](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/derivations_v2/argument_contract.json) | `7db1a7a72dd12178e7f5b63ce45c94ae08576e0a6a22daa8dbbbd13aab25d4ca` | Fidelidade; cinco notas e 17 claims |
| [preview_rmd](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/combined_manuscript_preview.Rmd) | `9356d86a2e893481968ee96a918c2109e726444c5d902ce88edd6f1a5d86345f` | 20 claims: transporte formal e consistência |
| [preview_bib](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/combined_references_preview.bib) | `658af186c73c1291da02a9fd4e3482fc953549ed46036ae24303b45f61309447` | Identidade do sidecar; sem validação externa |
| [preview_gate](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/manuscript_candidate/argument_contract.json) | `a1a39f8548cfdbe285a9bd5be7cee7f28d92156e8a411b91a74bd65099d3cebc` | Fidelidade do preview |
| [prior_formal_md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/reviews/formal_derivations_v1.md) | `0372743e4bd512feb670fb76b26057736ee986903158760616676352dbd55b8c` | Auditoria v1 retida, inclusive dependências históricas |
| [prior_formal_json](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/reviews/formal_derivations_v1.json) | `d9af586c44054823239313885bf2ae26d98548bee5fa967b491c3cf2115bce02` | Ledger v1 preservado |

O bundle é `3b8043d4…`, o preview é `9356d86a…` e o original preservado é `6708eaaf…`. O checkout continua em `codex/exposition-items20-28`, HEAD `c6dfab61a5a3b44d09ba389911df47726f81b51e`. O JSON do parecer registra todos os hashes completos, incluindo notas, scripts, manifesto de composição, DAG, contratos e leituras.

A revisão v1 leu as quatro notas integralmente e auditou criticamente B.4, B.8 e E.3 do original. Reconstruiu as respostas e a célula vazia de R1_U, o valor comum de agenda, a classificação por posterior, endpoints e seus consumidores; não se limitou a invocar isomorfismo. Essa cobertura continua parte deste parecer. Contrato/R2/R1 v2 são byte-idênticos aos arquivos examinados. A nota de agenda foi comparada integralmente; o novo lema foi lido por inteiro. Não foram refeitos cálculos intactos.

O diff integral do preview foi lido: 34 hunks, correspondentes a 110 blocos de mudança no comparador sem heurística, com 2.784 linhas idênticas, 335 linhas antigas substituídas/removidas e 565 novas. O diff armazenado reconstrói exatamente o preview. Houve releitura científica das mudanças e de seus consumidores em modelo/A.1/A.2, B.1–B.4, B.7–B.9, E.1–E.3/E.6, abstract e introdução. As partes iguais retêm suas leituras anteriores. C01, C19 e C20 são examinados quanto ao que o modelo sustenta e ao escopo declarado, sem certificação das afirmações históricas.

## 2. Reparo F-001: dominância pública e consumidores

**RESOLVED; erro algébrico LOW em v1, nenhuma severidade remanescente.** A nota atual, `agenda_transport.md:215–219` (B2:620–624), escreve literalmente:

```tex
1-k\beta(1-\beta o)/m-\beta^2o
=1-k\beta/m-\beta^2o(1-k/m)>1-\beta>0.
```

A expansão é exata. Subtrair `1−β` dá `β(1−k/m)(1−βo)>0`, pois `k<m`, `β∈(0,1)` e `o∈(0,1)`. A prova vale também em `o=1/m`. Portanto, no primeiro ramo público majoritário, a passagem domina o atraso `β²o`. No segundo ramo, a comparação continua entre `1−kβ/m` e `βo`; sob U a passagem supera a recusa em `1−β`. Os preços, cutoff, fórmulas de gap e componente distributivo não mudam.

P2894–2901 mantém a fórmula e afirma “Passage strictly dominates the delayed payoff”; não reproduz a igualdade falsa. Sua conclusão é precisamente a desigualdade agora demonstrada. E.6–E.8 e os consumidores de D usam o resultado correto. A solução implementada coincide com o reparo solicitado e não altera as primitivas.

O novo script racional foi lido e executado em cópia temporária: 870 casos de parâmetros, 4.353 verificações, zero falhas; o JSON produzido é byte-idêntico ao congelado. Isso corrobora a álgebra, mas a justificativa no domínio inteiro é a identidade acima.

## 3. Reparo F-002: suporte Borel e classificação unânime

**RESOLVED; lacuna de prova MEDIUM em v1, nenhuma severidade remanescente.** A nota `unanimity_support_lemma.md:7–99` (B2:920–1012) prova US-1 e suas duas aplicações nas linhas 103–104. A versão condensada P1981–2021 preserva os passos necessários, e P2030–2034/P2081–2086 aplica o lema aos dois casos de B.8.

A premissa é o valor comum V da primeira redução de B.8, que foi efetivamente reconstruída em v1. Pela identidade de Bayes, o alto usa posterior zero com probabilidade zero. Quase toda proposta usada pelo alto pode ser imitada pelo baixo com mesmo retorno, dando V_ℓ≥V_h≥d. Uma proposta usada pelo baixo em posterior zero não pode ser rejeitada, pois daria β²ℓ<d; se passa, o alto pode imitá-la. Nas demais propostas os retornos coincidem. Logo V_ℓ=V_h=V. Separadamente, a recusa garante d=β²h e a factibilidade de passagem dá V≤z_H=1−β+β²h. Essas premissas não pressupõem a conclusão do novo lema.

Para medidas Borel finitas no simplex compacto, `pσ_h` é absolutamente contínua em relação a `σ̄`. Estender as medidas por zero ao espaço euclidiano e aplicar diferenciação por bolas identifica o limite local com a derivada de Radon–Nikodym quase certamente. As bolas relativas do contrato são as mesmas interseções. Portanto, para todo Borel E,

\[
p\sigma_h(E)=\int_E\mu\,d\bar\sigma.
\]

Não se exige densidade de Lebesgue, suporte finito ou existência de átomos. A restrição adicional do contrato exige que o limite exista em cada ponto do suporte e pertença a `{0}∪(p*,1]`.

Suponha μ_off>p* e V<z_H. Fora do suporte, x^h passa e dá z_H, contrariando V. Dentro do suporte, escolha uma bola pequena em que x_H>V. Seu subconjunto de posterior zero tem massa alta zero por Bayes e massa baixa zero por incentivos: uma passagem daria mais que V, e uma recusa daria β²ℓ<d≤V. Toda bola menor tem massa pública positiva e posterior>p* quase certamente. Sua razão local de Bayes é, assim, estritamente maior que p*. O limite só autoriza `μ(x^h)≥p*`; a estriteza vem da admissibilidade, pois nem zero nem p* podem ser esse limite. Esse cuidado aparece expressamente nas linhas 97–99 do lema e P2015–2018.

Consequentemente x^h passa também nesse ponto de suporte, mesmo sem massa, e produz o desvio lucrativo z_H>V. Logo V=z_H. Recusas dão menos; passagem nesse valor esgota o orçamento com cada parcela fraca igual a r_U(h), de modo que a única proposta usada é x^h. Ambas as leis são δ_xh; Bayes no átomo dá p>p*.

Quando λ_0>0, o resultado anterior de B.8 dá V≤z_L<z_H, logo μ_off alto é impossível. Quando λ_0=0 e μ_off alto, o lema determina diretamente δ_xh. As famílias com μ_off=0, seus witnesses, a desigualdade V≥max{z_L,d}, os endpoints e a ausência de terceira família conservam as provas criticamente auditadas em v1. E.3 e as imagens de renda/T/I/Q consomem agora uma classificação fechada.

O teto global U usado em C15 decorre de factibilidade e de `d<z_H`, independentemente de US-1. Seu confronto com a garantia majoritária permanece

\[
V_U^A(o)-V_M^A(o)\le-\beta(e/m-\beta h).
\]

Não se ampliou a região suficiente nem se atribuiu valor a uma célula vazia.

## 4. Reparo F-003 e QI-05: melhor resposta em medidas

**RESOLVED; precisão LOW em v1, nenhuma severidade remanescente.** A nota `agenda_transport.md:304` (B2:709) exige literalmente `σ_o(argmax u_o)=1` e nega a contenção do suporte topológico no argmax. P2504–2509 transporta essa condição para M. P2701–2718 escreve `σ_h(R_L)=1` no ramo de recusa estritamente preferida e `σ_h({x^ℓ}∪R_L)=1` no empate, seguido da mesma distinção entre igualdade quase certa e ausência de desvio em pontos sem massa.

A mudança é expositiva em relação a A14 e à interpretação explicitamente confirmada no contrato. Com payoff descontínuo, uma lei pode dar probabilidade um ao argmax e ter um ponto-limite de massa zero com payoff inferior. O contraexemplo v1, uma sequência de recusas que converge a uma passagem inferior, continua corretamente admitido. O candidato não impõe continuidade de payoff, fechamento do argmax ou um refinamento adicional. Os tipos de probabilidade zero conservam suas estratégias e melhores respostas completas.

QI-01 permanece uma limitação mantida, distinta de QI-05: a agenda seleciona os assessments endpoint de prior de entrada degenerado. Isso não demonstra que todo histórico interno com posterior zero, partindo de prior interior, perde seu suporte inicial. A.2 preserva esse suporte e E.1 mantém as crenças internas do baseline. O parecer não estende o resultado a seleções não declaradas.

## 5. Ledger dos 17 claims das notas

Todos os itens recebem PASS no seu domínio contratado. “Retido” conserva a prova auditada em v1 por identidade de conteúdo; “reparo” inclui nova verificação analítica, não somente o gate interpretativo.

| Claim | Fonte atual | Método | Fundamento |
|---|---|---|---|
| C02 | B2:14–43 | retained | Primitivas idênticas: H único informado, fracos simétricos, pie fixa e opção externa fora dela. Não acrescenta atividade individual. |
| N01 | B2:14–43,73–84 | retained_and_transport_checked | Partição exaustiva: H fora implica x_H=0; H dentro e N implica fracasso; passagem com H implica consentimento. Payoffs definidos também após desvios. |
| N02 | B2:45–71,86–110,203–216,320–381 | retained_and_transport_checked | Disciplina baseline preserva crença atual e suporte inicial separadamente; agenda importa assessments endpoint declarados, sob QI-01. ⊥ não vira N. |
| C06 | B2:123–189 | retained | R2_M dá 1 ao proponente por exclusão; R2_U compara (1−μ)(1−ℓ) com 1−h. Empate, tipos zero e multiplicidade nominal de C mantidos. |
| C07 | B2:203–281 | retained_and_transport_checked | E domina fracasso certo; coalizão maior perde estritamente ao remover convidado pago; redução E/S/P preserva votos, probabilidade e continuação. Todos os cruzamentos e empates retidos. |
| N03 | B2:283–318,470–502,817–821 | retained_and_transport_checked | Representante uniforme completo, novo sorteio R2 após S rejeitada e peso EP comum. Kernel finito/Borel, sem equivalência por simples igualdade de c/h. |
| C08 | B2:320–381 | retained_and_transport_checked | Auditoria real histórica B.4 retida: quatro perfis, extremos e s† para célula vazia. Correção do mínimo sobre respondedores presente no preview. |
| C05 | B2:383–399 | retained_and_transport_checked | Public benchmark e vetores econômicos baseline preservados; coalizões nominais e estratégias majoritárias não identificadas com o histórico. |
| N04 | B2:425–502 | retained_and_transport_checked | Sinal completo (C,x), união disjunta compacta, bolas na componente C e seletor anônimo completo. Propostas com x comum e C distintos não são coladas. |
| N05 | B2:504–599 | retained_and_transport_checked | Votos por produto de consentimentos; piso r≥w(1−w), garantia 1−kw e exclusão quase certa de passagem superdimensionada. Desvios por qualquer C continuam disponíveis. |
| C12 | B2:600–628 | repaired_and_verified | F-001 resolvido: expansão exata e margem β(1−k/m)(1−βo)>0. Fórmulas públicas, cutoff e gaps preservados; E.6 é consumidor válido. |
| N06 | B2:630–709 | repaired_precision_and_verified | Seis formas e critério Borel A14 retidos; F-003 explicita probabilidade um no argmax, sem contenção topológica. Existência para algum ρ e endpoints conferidos. |
| N07 | B2:711–767 | retained_and_transport_checked | Duas contraprovas de equivalência literal retidas. Witness de reversão preserva mesma fibra μ_off=0, com vetores M=(.5905,.81), U=(.729,.729). |
| N08 | B2:320–326,769–779,914–1019 | new_proof_verified | Isomorfismo U retido e dependências históricas efetivamente auditadas em v1. US-1 verificado integralmente e aplicado às duas famílias de B.8; prova condensada no preview é suficiente. |
| N09 | B2:781–853 | retained_and_transport_checked | Kernels e registros mantêm C, votos e ⊥; ação diagonal finita e fatoração Borel preservam órbitas das leis realizadas. Off-path completo permanece no binder. |
| C15 | B2:593–597,855–875 | retained_dependency_verified | V_U≤z_H e V_M≥1−kβ/m bastam ao bound −β(e/m−βh). Não consome conclusão de US-1. Ambas as fontes precisam existir. |
| C17 | B2:855–875,877–907 | consumers_verified | T=D+I, I, Q, datas e vazio propagados corretamente; classificação U agora tem fechamento, e M usa a nova correspondência em Y_M. Não cola seleções nem coordenadas. |

## 6. Transporte ao preview e ledger dos 20 claims

A implementação no manuscrito corresponde ao jogo aprovado. Sob M, a quota determina a cardinalidade admissível de C; uma coalizão maior continua sujeita ao consentimento de todos. Se H é excluído, conserva o fora da pie e não recebe alocação porque x_H=0 por factibilidade. Se recusa como convidado, o pacote inteiro fracassa. As histórias de desvios não recorrem a cancelamento ou execução individual posterior.

B.3 especifica as respostas em qualquer proposta, inclusive em pacotes que fracassam, antes de reduzir os ótimos a E/S/P. B.4 conserva o domínio de inexistência em votos puros e passa a definir o mínimo sobre respondedores, excluindo o proponente. B.7 mantém todos os contratos no espaço de desvios e demonstra minimalidade apenas quase certamente nas passagens usadas. E.1 distingue (C,x), preserva bolas por componente e declara o seletor por regra/etapa/posterior. O marcador ⊥ não é interpretado como voto N nem sinal de H.

As leis de E.2 preservam a coalizão, reconhecimentos, alocações, votos e resultados. Para primitivas fixas e o representante uniforme escolhido, os registros de continuação são finitos: E/S/P usam alocações fixas e EP muda pesos, não cria novos registros. Funções de crenças e planos não realizados permanecem no assessment completo. A ação diagonal de S_m relabela conjuntamente os tipos e as trajetórias. A assinatura continua classificando órbitas das leis realizadas, sem serializar toda estratégia off-path. O transporte de U usa C=N e o lema agora inserido; M foi rederivada, sem equivalência estratégica literal com o jogo antigo.

| Claim | Fonte atual | Resultado/fundamento |
|---|---|---|
| C01 | P:94–129, 244–275, 648–728, 1270–1295, 1381–1386 | PASS_SCOPED: Margem extensiva do único informado corresponde às soluções: exclusão de H sob M, adesão indispensável sob U. Não vira ranking universal. |
| C02 | P:303–342, 344–388, 1411–1430 | PASS: Economia, tipos, reconhecimento e desconto correspondem ao contrato autorizado e às folhas; sem produtividade de H ou informação privada dos fracos. |
| C03 | P:316–394,1411–1430 | PASS: P316–394/A.1 fecham todas as histórias: quota restringe C, todos consentem, zero fora, implementação integral e outside option após exclusão. |
| C04 | P:428–481, 1432–1456 | PASS: P428–481/A.2 preservam votação simultânea, T^Y, pivotalidade dos fracos e suporte inicial. E.1 declara disciplina própria da agenda. |
| C05 | P:504–559, 1460–1492 | PASS: B.1 rederiva os custos de inclusão/exclusão e empate público; valores das tabelas preservados, multiplicidade de coalizões reconhecida. |
| C06 | P:561–586, 1494–1509 | PASS: B.2 consome R2 nativa e preserva cutoff e tie-break; enunciado distingue alocação de outcome nominal. |
| C07 | P:588–646, 694–718, 1511–1567 | PASS: B.3 inclui votos em todo pacote, dominância de fracasso, remoção pré-votação e redução E/S/P, inclusive tipos de probabilidade zero e λ comum. |
| C08 | P:648–728, 1569–1645 | PASS: B.4 transporta U isomorfo; mínimo exclui proponente. Auditoria histórica completa em v1 é retida, incluindo a não existência somente na classe de votos puros. |
| C09 | P:730–780, 1647–1659, 2179–2218 | PASS: B.5 e tabelas subtraem vetores vinculados por tipo; célula vazia e segmentos com peso comum conservados. |
| C10 | P:782–903, 1661–1683, 2190–2218 | PASS: B.6/rendas preservados; introdução P119–122 agora condiciona zero de ambas as rendas à exclusão também no benchmark público. |
| C11 | P:905–939,2301–2378 | PASS: A é obrigatória, H∈C, (C,x) público, recusa entra em R1 com um β. E.1 preserva topologia e seletores completos por regra/estágio/posterior. |
| C12 | P:941–1047, 2888–2954 | PASS: E.6–E.8 e prop:agenda-public consomem desigualdade reparada F-001; fórmulas e domínios inalterados; rejeições continuam contratos completos. |
| C13 | P:1685–1924,2380–2581 | PASS: B.7/E.2 usam Y_M, ballots com ⊥, todos os C nos desvios e A14 ponto a ponto/quase certo. Minimalidade de passagem é resultado, não restrição do espaço. |
| C14 | P:1925–2107,2582–2798 | PASS: B.8 contém US-1 e ambas aplicações; E.3 preserva famílias, endpoints e probabilidade um. Fechamento cobre suportes Borel sem pressupor densidade, suporte finito ou átomos no argumento. |
| C15 | P:1130–1152, 2838–2886 | PASS: E.5 usa os limites globais, não US-1. Região βh<e/m, igualdade fraca e exigência de fontes não vazias mantidas. |
| C16 | P:1022–1047, 1154–1204, 2956–3044 | PASS: E.9/E.10 e witness P2443–2453 mantêm sinais, mesma fibra e decomposição de rendas. Intro P132–139 distingue resultado robusto de reversão condicional. |
| C17 | P:1206–1266, 3046–3184, 3270–3347 | PASS: E.11–E.14/F.2–F.4 retêm fontes/datas, incidência e células vazias. A mudança de espaço não altera identidades, mas imagens usam a fonte M nova. |
| C18 | P:2108–2176,2516–2581,2745–2798,3186–3269 | PASS: B.9/E.2/E.3/F.1 mantêm C nas leis e relabeling diagonal. Ω_D^M é finito para os kernels escolhidos; planos de crença e contingências fora do caminho ficam no binder. |
| C19 | P:45–83, 154–212, 1297–1375, 1397–1403 | PASS_SCOPED: Acesso a mercado permanece interpretação estilizada de pie fixa e outside option portátil. Não foi testada a verdade de afirmações históricas, referências externas ou causalidade empírica. |
| C20 | P:1342–1375, 1377–1403, 3311–3347 | PASS_SCOPED: Limites preservam club goods distributivos, dois tipos/rodadas, votos puros, seletores declarados e ausência de ranking universal. Não se ampliou o resultado a outros jogos. |

As duas correções da introdução têm efeito substantivo de precisão: P119–122 condiciona a renda zero sob exclusão ao benchmark público, e P132–139 separa o limite robusto favorável à maioria da reversão condicional. A testemunha de E.2 usa μ_off=0 nas duas instituições; não implica reversão na região em que C15 a exclui. A aplicação a acesso a mercado continua estilizada e não transforma a comparação formal em identificação causal da escolha institucional.

## 7. Checks, rastreio e limites

| Check | Resultado | Limite |
|---|---|---|
| Identidade v2 | Dez membros do manifesto; cinco payloads do bundle; três notas idênticas a v1 | Vincula o parecer à fonte exata |
| Composição do preview | Sete inputs, dois outputs e diff exato; Rmd/bib congelados | Patches não executados/revisados como software |
| DAG v2 | VALID; R2 → R1 → A_M/US-1 → A_U | Ordem persistida conferida, sem auditoria de logs brutos |
| F-001 novo | 870 casos, 4.353 PASS, zero FAIL, JSON byte-idêntico | Finito; não prova US-1 |
| 409 checks v1 | Resultado anterior retido, sem reexecução | Código/fórmulas intactos; não conta como teste novo |
| Enumeração independente R1_M | 50 estados, 100 asserções, 3.054.975 comparações, zero falhas; execução v1 retida | Grid racional, m=3/4, β=3/5; não prova o contínuo |
| Dois contratos | PASS de fidelidade e JSON VALID | Interpretação separada deste parecer científico |
| Revisão analítica | Três reparos, dependências e consumidores verificados | Provas legíveis, sem prover formal |

O novo script é `derivations/v2/repaired_algebra_checks.py`, SHA `ffb8a213b34258fe9a000f932240e392f3334339150938a886fd1a9698940ac1`; a saída tem SHA `427c7b001a0a8483e914b681eaad004f31954b4b4d3755d125862ee371a1d688`. A enumeração independente permanece em `reviews/formal_checks_v1.py` e `.json`, hashes `bc3bc6e73a550a98dd54e1204dd88e45612497b5429fe2ea212637627c8e2d93` e `77504c6fc206ff4ca08ce5cb8863e3c7453bca013d11c4ea48b326c760fc1208`. Todos os cálculos ficam nos scripts, fora das fontes científicas.

Não executei Lean, geração de figuras, render ou QA visual. Não verifiquei externamente a bibliografia nem os fatos históricos. A bibliografia é vinculada por hash e seu diff foi inspecionado, sem alegar equivalência integral com a fonte citada. A QA visual conduzida por outros agentes não integra este parecer. Valores e captions formais foram confrontados com os resultados, mas o código dos gráficos não recebeu nova auditoria. Este PASS não significa que todo manuscrito, em todas as dimensões, foi certificado.

## 8. Disposição

**PASS para coalition-derivations-v2 e PASS para o transporte formal/consistência do preview 9356d86a…**, com 17 e 20 claims rastreados respectivamente. Os três findings v1 estão resolvidos nos arquivos atuais; nenhum finding permanece aberto. O próprio v1 não foi corrigido retroativamente.

Uma mudança futura em factibilidade, observação de C, consentimento, suporte inicial, seletor, kernel, topologia ou datas reabre seus dependentes. A substituição de um kernel por outro com os mesmos payoffs pode reabrir leis e assinaturas. O parecer é um dos controles independentes exigidos e não substitui adjudicação ou outro parecer. Nenhum arquivo canônico foi migrado por este revisor.
