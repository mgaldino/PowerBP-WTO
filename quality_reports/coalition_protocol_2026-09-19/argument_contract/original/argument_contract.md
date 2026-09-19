# 1. Source-bound identity

**Contract ID:** `informational-power-original:6708eaafca2f7:round1`  
**SHA-256:** `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`  
**Artefato:** [formal_model_v6.Rmd](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd)  
**Escopo:** contrato interpretativo do original; leitura integral, sem crítica científica ou edição. **Perfil:** formal. **Data:** 2026-09-19T14:19:26-03:00.

O título inscrito no original é *Power and Its Shadow: When Unanimity Serves the Hegemon*. O nome de trabalho do projeto é *Informational Power Through Pivotality*. O contrato descreve os bytes do primeiro, sem migrar a decisão autoral posterior para esse texto. M:a–b indica linhas inclusivas do fonte exato.

Checkout conferido: `codex/exposition-items20-28`, HEAD `c6dfab61a5a3b44d09ba389911df47726f81b51e`. Checkout conferido durante o gate. Há artefatos concorrentes de implementação não lidos como substitutos do original; o hash do Rmd controla a identidade.

Leituras integrais preservadas:

- **R-baseline** — leitor `/root/baseline_source_read`; M:297–887, 1381–1647, 2028–2139; [record](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/peio_2027_2026-09-19/source_reads/baseline.md); SHA-256 `06b38af6b9e65365bddaf4d99a9cf2f64bb1321e2dc69f26cc1573e3e3fe93c6`.
- **R-agenda** — leitor `/root/agenda_source_read`; M:888–1241, 1648–2027, 2140–3117; [record](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/peio_2027_2026-09-19/source_reads/agenda.md); SHA-256 `1a5a8743f354410d923f9dbf190d70878b5282de3bf9e18e7bdc1c19744bcdd5`.
- **R-framing** — leitor `/root/baseline_source_read`; M:1–296, 1242–1375; [record](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/source_reads/framing_original.md); SHA-256 `9873cb825396a17a3d1073b209a4a3feeba881f5abdaf804b0fc295b4d8656a3`.

Fontes complementares usadas somente para resolver o alcance de notação ou a fronteira de versão:

- [agenda_extension_A_M_msb_results.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/model_redesign/agenda_extension_A_M_msb_results.md) — SHA-256 `7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3`; leitura: 90–144,183–267,305–323. Esclarece domínio de seletores, Bayes pointwise e representantes literais; não substitui o manuscrito como objeto do contrato.
- [agenda_extension_A_U_msb_contract.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/model_redesign/agenda_extension_A_U_msb_contract.md) — SHA-256 `348ffc702d75e47ec8f8008bccb71338174649f57d90af8fc78e919cfd4ded26`; leitura: 39–47,128–133. Esclarece a restrição Markov e a fronteira entre binder completo e leis realizadas.
- [author_decision.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/author_decision.md) — SHA-256 `7abfa53814ff23c61a9af2049c975be81e44f8e66270c4fa3f99accd51923726`; leitura: integral. Apenas fronteira de versão/autoridade; não retroimportada ao original.

# 2. Document profile

Idioma inglês; fonte RMarkdown/bookdown. 17.784 tokens separados por whitespace no Rmd bruto, incluindo YAML e LaTeX; não equivale à contagem de palavras em prosa renderizada. O artefato lido é o fonte, sem contagem de páginas ou QA visual do PDF. São 8 seções do corpo e 5 apêndices substantivos (A,B,C,E,F); D é documental. O mapa subdivide isso em 35 unidades substantivas e 2 unidades documentais, cobrindo linhas 1–3118. References inicia na linha 3119.

O abstract tem 137 palavras por separação simples. Macro leu integralmente o Rmd e os três records. Dois agentes realizaram as leituras por blocos: baseline/framing pelo leitor /root/baseline_source_read; agenda pelo leitor /root/agenda_source_read. O macro reutiliza os próprios records de baseline/framing e incorpora a leitura independente da agenda; não alega um leitor distinto por cada subunidade do mapa. Nenhum leitor editou o manuscrito nesta tarefa.

O [section_map.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/original/section_map.md) registra 37 unidades, funções, evidência, limites, dependências documentais e rastreio por leitor. Referências não foram tratadas como seção substantiva; a exatidão bibliográfica não foi auditada.

# 3. Thesis, question, and contribution

**Tese.** A unanimidade pode beneficiar um hegemon com informação privada porque torna seu consentimento indispensável, enquanto a maioria pode substituí-lo por fracos desinformados; o efeito distributivo e a renda informacional dependem do tipo, do benchmark público, da correspondência e de sua existência, com um jogo de agenda separado para H proponente.

**Pergunta.** Quando a necessidade do consentimento do único ator informado, distinguida de sua opção externa e de seus direitos de proposta, faz unanimidade favorecer H em comparação com maioria?

**Contribuição apresentada.** O manuscrito apresenta como contribuição a margem extensiva de inclusão/exclusão do único informado, além das margens pooling/screening presentes na literatura motivadora. Caracteriza os benchmarks e jogos privados de duas rodadas, separa payoff público e renda informacional, e acrescenta uma etapa de proposta informada para decompor o efeito de agenda sem apagar multiplicidade. A aplicação à OMC é teórica; a novidade bibliográfica e os fatos históricos não são verificados por este contrato.

**Tipo de claim:** formal. Histórias e exemplos motivam e interpretam; não são a evidência que identifica as proposições.

# 4. Core claims

**C01 — mecanismo teórico condicional.** A margem extensiva é a inclusão do único ator informado: maioria permite acordo entre fracos desinformados sem H; unanimidade exige seu consentimento. Isso pode gerar renda informacional do tipo baixo mesmo sem H propor.

**C02 — primitivas e domínio declarados.** O original modela um jogo distributivo de duas rodadas, m≥3 fracos simétricos, H com o∈{ℓ,h}, 0<ℓ<h<1, prior p e desconto 0<β<1. A pie é fixa em 1; a opção externa de H é privada, externa à pie e disponível quando um acordo o exclui.

**C03 — regra histórica explícita do artefato.** No protocolo original, propostas x não negativas somam no máximo 1; todos os respondedores votam simultaneamente, o proponente conta sim, e a quota decide aprovação. Um fraco recebe x_j na aprovação independentemente do voto. H que vota sim recebe x_H; se vota não e há aprovação, recebe o e x_H não é pago a ninguém.

**C04 — conceito declarado, não refinamento demonstrado.** A solução do baseline é uma correspondência de PBE com votos puros, votação dos fracos como se fossem pivotais, sim na indiferença e disciplina específica de crenças: fracos não sinalizam; votos com mesmo voto de H no mesmo ballot têm mesmo posterior; Bayes sempre que seu denominador é positivo; valores livres locais quando zero, dentro do suporte inicial.

**C05 — proposição formal por rodada e regra.** Com tipo público, R2 dá aos fracos a possibilidade de excluir H sob maioria e exige pagar o a H sob unanimidade. Em R1, unanimidade paga βo; maioria inclui H se o≤1/m e lhe paga βo, ou o exclui e H recebe o.

**C06 — proposição formal terminal.** Na rodada terminal privada, maioria mantém o resultado terminal público; sob unanimidade o proponente oferece ℓ para p≤p*=(h−ℓ)/(1−ℓ), e h para p>p*. A igualdade seleciona a oferta baixa.

**C07 — caracterização formal exaustiva declarada.** A correspondência privada de maioria em R1 compara screening S, pooling P e exclusão E, com preços βℓ, βh e β/m e cutoffs p_SP e p_SE. Os regimes dependem de ℓ e h em relação a 1/m; empates obedecem à seleção prescrita, com mistura E/P vinculada apenas no residual permitido.

**C08 — caracterização e inexistência na classe declarada.** No baseline privado unânime, p=0 dá acordo imediato baixo; 0<p≤p* dá correspondência vazia na classe mantida de votos puros; p>p* dá pooling imediato a βh. O vetor tipo a tipo é (βℓ,βh) em p=0 e (βh,βh) na célula alta.

**C09 — comparação formal condicionada à existência.** O contraste privado do baseline é unanimidade menos maioria e mantém tipos e seleção vinculados. Acima de p*, unanimidade menos screening dá (β(h−ℓ),0); menos pooling dá (0,0); menos exclusão dá (βh−ℓ,−(1−β)h).

**C10 — decomposição e incidência por célula.** Renda informacional é privado menos público dentro da mesma regra; ΔIR é unanimidade menos maioria dessas rendas. Unanimidade dá (β(h−ℓ),0) para p>p*, zero em p=0 e vazio no intervalo sem equilíbrio. Em maioria a renda depende conjuntamente da inclusão pública de cada tipo e da forma privada; exclusão pode alterar a data do recebimento de o e produzir renda positiva.

**C11 — jogo distinto e restrições declaradas.** A extensão acrescenta uma etapa A obrigatória em que H propõe antes do baseline. Aprovação implementa em A; rejeição entra em um assessment completo da R1 correspondente, descontado por β uma vez. H propõe medidas Borel e pode sinalizar; o seletor de continuação é público, Borel, anônimo/Markov no domínio declarado.

**C12 — proposição formal por ramo.** Na agenda pública, v_U^A(o)=1−β+β²o; v_M^A(o)=1−kβ(1−βo)/m para o≤1/m e max{1−kβ/m,βo} para o>1/m. Sob maioria, o cutoff o_M* governa acordo imediato ou atraso; o gap institucional depende do nível de o.

**C13 — caracterização e limite uniforme declarados.** A agenda privada majoritária é uma correspondência de assessments completos: formas puras e medidas Borel gerais devem satisfazer incentivos tipo a tipo, crenças pointwise e uma continuação literal comum. Todo payoff admissível satisfaz V_M^A(o)≥max{v_M^safe,β²o}; existência é afirmada para algum ρ em cada economia/prior, não para todo ρ fixado.

**C14 — caracterização formal por domínio.** A agenda privada unânime tem famílias de posterior baixo e alto, endpoints próprios e células vazias. No interior existente, ambos os tipos têm o mesmo payoff por imitação; V_U^A(o)≤z_H=1−β+β²h. Posteriors de continuação em (0,p*] são inadmissíveis porque a continuação baseline está vazia.

**C15 — condição suficiente uniforme sobre assessments.** Se as duas correspondências de agenda são não vazias na mesma especificação e βh<e/m, maioria dá mais a ambos os tipos e ex ante: V_U^A(o)−V_M^A(o)≤−β(e/m−βh)<0; na igualdade o ranking é fraco.

**C16 — decomposição algébrica e incidência delimitada.** Na agenda, IR_g^A=V_g^A−v_g^A e ΔV^A=Δv^A+ΔIR^A. Em todo assessment unânime existente, IR_U^A(ℓ)≥0, IR_U^A(h)≤0 e alguma desigualdade é estrita. Uma reversão privada quando o público favorece maioria exige que ΔIR compense o gap público.

**C17 — identidade entre jogos e sinais delimitados.** A comparação temporal da agenda separa D=v^A−βv^B, I=IR^A−βIR^B e T=V^A−βV^B, com T=D+I. D_U=1−β; T_U é não negativo onde definido. Q=v^A−βV^B muda simultaneamente agenda e informação e é um contraste composto.

**C18 — resultado de representação declarado.** A representação exata registra a órbita conjunta das leis realizadas sob renomeação diagonal dos fracos; a representação econômica elimina nomes registro a registro para observáveis anônimos. Comparações emparelham assessments completos antes de projetar; envelopes são apenas limites marginais.

**C19 — interpretação substantiva com limites explícitos.** A discussão da OMC é uma aplicação teórica ilustrativa: acesso a mercado, saída, agenda e pacotes motivam primitivas; o modelo isola o preço do consentimento indispensável. Não identifica causalmente a criação da OMC, o tipo histórico de EUA/CE nem a escolha endógena da regra.

**C20 — síntese e limites reconhecidos.** Os resultados mantêm duas rodadas, dois tipos, m≥3 e β<1; formal igualdade de votos pode coexistir com desigualdade por opção externa, proposta e consentimento sem substituto. O paper preserva multiplicidade e ausência de comparação nas células vazias.

# 5. Claim → evidence → scope map

| Claim | Localizador | Evidência declarada | Escopo |
|---|---|---|---|
| C01 | [M:94–128, 240–271, 631–711, 1244–1269, 1353–1358](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:94) | Contraste entre correspondências de maioria e unanimidade e distinção entre screening, pooling e exclusão. | Economia fixa, um informado, baseline com propostas dos fracos; o sinal e a existência dependem da célula. Não se infere que toda exclusão zera renda. |
| C02 | [M:299–326, 328–374, 1383–1397](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:299) | Definições de jogadores, alocações e transições; tabela de payoffs e Appendix A.1. | Sem produtividade adicional de H, sem externalidades, sem benefícios intrínsecos do acordo; todos os fracos têm opção externa zero. |
| C03 | [M:309–348, 358–374, 1383–1397](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:309) | Texto do ramo contestado, tabela tab:protocol e A.1 convergem sobre o cancelamento primitivo. | Caracterização de G0, o manuscrito original. Não atribui essa regra à decisão autoral posterior nem a deriva da nova arquitetura (C,x). |
| C04 | [M:411–464, 1399–1423](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:411) | Definições de assessment e regras operacionais de A.2. | Não é equilíbrio sequencial nem disciplina global única de crenças. Loterias de propostas permitidas e tipos fora do suporte retidos nos vetores não autorizam ressuscitar sua probabilidade. |
| C05 | [M:487–542, 1427–1458](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:487) | Proposição prop:public, tabela tab:publicgames e prova B.1. | No empate o=1/m, a seleção inclui H. Preço do voto não é o payoff de H excluído. |
| C06 | [M:544–569, 1460–1475](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:544) | Proposição prop:terminal e prova B.2. | p é a crença de entrada de R2. Resultado terminal sem desconto interno; continuação trazida a R1 recebe β uma vez. |
| C07 | [M:571–629, 677–701, 1477–1530](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:571) | Proposição prop:majority e prova B.3; tabela de correspondências. | Não são três estratégias livremente escolhidas em toda célula; o mesmo peso residual vincula todas as coordenadas e outcomes. |
| C08 | [M:631–711, 1532–1608](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:631) | Proposição prop:unanimity, tab:privatecorrespondence e prova B.4. | Inexistência não é payoff zero nem prova de inexistência com votos mistos. O componente do tipo alto em p=0 é fora do suporte. |
| C09 | [M:713–763, 1610–1622, 2030–2069](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:713) | Proposição prop:privatecompare, figura fig:privatecompare e B.5. | p=0 tem as próprias células; 0<p≤p* não recebe ranking. Misturas geram segmentos vinculados, não produtos de envelopes. |
| C10 | [M:765–886, 1624–1646, 2041–2069](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:765) | Proposições prop:rents e prop:deltari, tabela algébrica completa e figura fig:rents. | Não há zero universal sob exclusão, nem sinal institucional universal. O exemplo M:273–295 tem IR_M=(.01,0) apesar da exclusão privada. |
| C11 | [M:466–479, 888–916, 1023–1056, 2142–2193, 2195–2215, 2362–2394](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:466) | Contrato da extensão, indexação por ρ e μ_off, correspondências E.2/E.3; fontes de derivação esclarecem a dependência apenas em regra/estágio/posterior. | Não é concessão de reconhecimento em uma das duas rodadas já existentes, nem o mesmo refinamento de crenças do baseline. Só H possui informação privada. |
| C12 | [M:918–1021, 2658–2724](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:918) | Proposição prop:agenda-public, fig:agendagap, E.6–E.8. | A figura usa m=4, β=.90, k=e=2. O uso de 'comprar voto de H' em M:992–995 remete ao baseline que determina a continuação, não ao ballot corrente em A. |
| C13 | [M:1023–1056, 1648–1830, 2195–2360, 2608–2656](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:1023) | B.7 e E.2 descrevem r_χ, d_χ,o, formas puras, desvios fora do suporte e leis Borel; E.5 usa o bound. | Continuações são representantes literais uniformes de C_M e suas misturas residuais vinculadas. Nenhuma recombinação de estratégias/crenças/payoffs entre assessments. |
| C14 | [M:1058–1102, 1831–1965, 2362–2567, 2608–2656](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:1058) | B.8/E.3 e fig:agendaexistence. | A figura usa uma economia específica em que a família de prior baixo falha sua condição; não generalizar esse mapa a todas as economias. Endpoints não são limites. |
| C15 | [M:1104–1126, 2608–2656](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:1104) | Proposição prop:agenda-majority e bounds de B.7/B.8; exemplo fora da condição mostra não necessidade. | e=m−k; condição suficiente, não necessária. Uma reversão privada a favor de unanimidade deve estar fora dessa região estrita. |
| C16 | [M:999–1021, 1128–1178, 2726–2814](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:999) | Proposição prop:agenda-incidence, tabela trabalhada e E.9–E.10. | A reversão é condicional/assessment-specific, não existência universal; a tabela usa (m,β,ℓ,h,p)=(4,.9,.1,.9,.95), fora de βh<e/m. |
| C17 | [M:1180–1240, 2816–2954, 3040–3117](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:1180) | Proposição prop:agenda-decomposition, E.11–E.14, F.2–F.4. | Cada diferença exige a existência de todas as fontes e datas compatíveis; β entra uma vez no baseline. I_U≤0 na célula de prior alto existente. Multiplicidade não é resolvida por uma seleção implícita. |
| C18 | [M:1966–2027, 2558–2606, 2958–3038](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:1966) | B.9, E.4 e F.1 com Sig_ex e Sum_econ. | 'Exact' não significa serialização de toda função off-path. Não impõe um sorteio comum entre instituições nem autoriza recombinar marginais como vetores atingíveis. |
| C19 | [M:45–83, 150–208, 1271–1347, 1369–1375](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:45) | Literatura atribuída, tabela das práticas de Steinberg e limites da aplicação. | A pie permanece fixa, independente de H e sem spillovers; não se acrescenta uma tarefa produtiva/execução individual para H receber x_H. 'Identifying benchmark' é isolamento analítico. |
| C20 | [M:1316–1347, 1349–1375, 3081–3117](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd:1316) | Seção de limites, conclusão e F.3–F.4. | Não há resultado universal de preferência de H pela unanimidade; não resolve ratificação, implementação institucional, reputação, roll-call, mais tipos ou formação endógena das regras. |

**Condições transversais de escopo**

- O objeto é G0, o manuscrito original de hash 6708eaaf..., anterior à mudança autoral de 19/09/2026 para (C,x).
- Economia distributiva fixa, H único informado, m≥3 fracos simétricos e desinformados, dois tipos, duas rodadas baseline e β∈(0,1). M:299–326,1316–1326.
- Maioria e unanimidade diferem pela quota no mesmo protocolo do jogo considerado. A agenda acrescenta uma etapa obrigatória e sua disciplina própria de proposta/continuação; não se confunde com baseline. M:328–338,466–479,2142–2193.
- A opção externa de H é portátil em relação a acordos entre fracos e está fora da pie; não há efeito produtivo de sua participação nem execução individual para receber a parcela. M:299–348,1244–1269.
- Os payoffs dependem do protocolo original escrito em A.1, inclusive o cancelamento histórico de x_H no ramo de aprovação com H não. A leitura não aprova esse ramo para o candidato novo.
- Os resultados de inexistência são na classe de PBE com votos puros e restrições declaradas. Não se estendem a votos mistos ou a outros refinamentos. M:411–464,1316–1340.
- Só se comparam correspondências não vazias. Datas e desconto devem ser compatíveis; endpoints preservam suporte e não são limites. M:2030–2069,3081–3117.
- Vetores por tipo, leis realizadas, seletores e resultados devem vir dos mesmos assessments. Rendas usam o benchmark público correspondente. M:435–442,765–886,2569–2606.
- A condição βh<e/m da agenda é suficiente e uniforme; fora dela a classificação depende da correspondência. A tabela de reversão é um exemplo admissível, não um ranking global. M:999–1126.
- A discussão da OMC não é evidência causal, calibração ou explicação identificada da escolha institucional. M:1291–1314,1342–1347.

# 6. Profile-specific contract

## Jogadores

**Conteúdo.** H e W={1,…,m}, m≥3. Só os fracos são reconhecidos no baseline, com probabilidade uniforme e sorteios independentes com reposição; o primeiro proponente permanece elegível em R2. H é o único informado; todos os fracos são simétricos e têm opção externa zero.

### Localizadores

- M:299–312
- M:328–338

**Agenda.** A extensão acrescenta H como proponente obrigatório em A, antes de uma continuação baseline completa, sem alterar quem propõe dentro de R1/R2.

## Timing

### Baseline

- Natureza determina o∈{ℓ,h}, conhecido só por H.
- R1: reconhece-se um fraco; ele propõe x; respondedores votam simultaneamente; proponente conta sim; publica-se o vetor completo.
- Aprovação encerra e implementa o ramo de payoff original. Rejeição em R1 leva a R2 sem exercício imediato irreversível de o.
- R2: novo reconhecimento uniforme; proposta e ballot; aprovação implementa; rejeição encerra em desacordo. R2 não usa desconto interno; valor de R2 em R1 é βC_2.

### Agenda

- H deve fazer a proposta em A; sua proposta conta como sim.
- Os fracos votam simultaneamente; maioria exige k votos fracos e unanimidade todos m.
- Aprovação implementa em A; rejeição entra em R1 do mesmo regime, com β aplicado uma única vez ao valor nativo baseline.

### Localizadores

- M:309–409
- M:1383–1397
- M:888–916
- M:2142–2169

## Informação

**Parâmetros.** 0<ℓ<h<1; p=Pr(o=h)∈[0,1]. A versão pública revela o; a privada não. Em toda comparação econômica usam-se os mesmos parâmetros.

**Baseline.** Propostas e votos dos fracos não sinalizam o tipo de H. No mesmo ballot, os vetores com o mesmo voto de H têm o mesmo posterior. Bayes tem precedência quando o denominador é positivo, inclusive após desvios anteriores dos fracos. Se zero, há um valor livre local por ballot/voto de H, sempre no suporte do prior original; ballots distintos podem ter valores livres distintos.

**Agenda.** As leis Borel de proposta de H podem sinalizar seu tipo. O limite local de Bayes deve existir em todo ponto do suporte, inclusive pontos de massa zero. Fora do suporte há um único μ_off=b_ρ(p)=pρ/(1−p+pρ), com ρ∈[0,∞]; b_0=0 e b_∞=1 no interior. Endpoints preservam μ_off=p e tornam ρ irrelevante.

### Localizadores

- M:299–307
- M:411–433
- M:1399–1417
- M:2171–2193
- M:2390–2405

**Alcance.** A disciplina global do sinal/proposta na agenda não substitui a liberdade local dos ballots no baseline.

## Ações e estratégias

**Espaço de propostas.** Original: x=(x_H,x_1,…,x_m)≥0 e Σ_j x_j+x_H≤1; sem teto adicional para H e sem vetor C explícito. Loterias de propostas são admitidas; seleção residual mantém um único peso comum nos objetos relacionados.

**Quota.** k=floor((m+1)/2) votos adicionais além do proponente sob maioria; unanimidade exige todos. No baseline votam H e os fracos não proponentes; em A os respondedores são os m fracos.

**Payoffs originais.** Na aprovação, cada fraco recebe a parcela proposta independentemente do voto. H votando sim recebe x_H; H votando não recebe o, e o original declara x_H não pago a ninguém. Em rejeição terminal H recebe o independentemente do voto e fracos zero. Em rejeição não terminal há continuação.

**Fora do caminho.** Estratégias, crenças e respostas a propostas e votos fora do caminho compõem o assessment; não se pode ignorar desvios só porque uma proposta é subótima. A leitura registra o que o original exige, sem julgar suas provas.

### Localizadores

- M:314–348
- M:358–374
- M:435–442
- M:626–629
- M:1383–1423
- M:2142–2169

**Fronteira da decisão posterior.** A restrição x_j=0 fora de C pertence à decisão autoral nova. Não integra o simplex de G0 nem é inferida das provas do original.

## Conceito de solução

**Baseline.** Correspondência de PBE na classe de votos puros, com os fracos comparando valores esperados como se fossem pivotais. T^Y impõe sim na indiferença em valor esperado; H maximiza por tipo e também vota sim na indiferença. Empates do proponente entre propostas com o mesmo payoff esperado seguem a minimização do payoff esperado de H. O conceito não é equilíbrio sequencial.

**Agenda.** Assessments completos com propostas Borel puras ou mistas, ballots fracos puros, restrição comum de crença fora do suporte e seletor total, público, Borel, anônimo/Markov. A seleção de continuação depende de regra/estágio/posterior; os estados E/S/P/EP em M são representantes literais uniformes da continuação aprovada no original.

**Vinculação dos objetos.** Cada assessment fixa conjuntamente estratégias, crenças, seletores, reconhecimento, ballots, payoffs e leis de outcomes. Os dois tipos permanecem vinculados, inclusive o tipo de probabilidade zero. Comparações institucionais emparelham assessments completos na mesma economia/especificação de crença antes da projeção.

### Localizadores

- M:411–464
- M:1399–1423
- M:1648–1676
- M:2142–2193
- M:2195–2360
- M:2385–2405
- M:2569–2606

### Fontes de esclarecimento

- model_redesign/agenda_extension_A_M_msb_results.md:90–144,183–267
- model_redesign/agenda_extension_A_U_msb_contract.md:39–47,128–133

## Pressupostos e domínio

### Economia

- Pie distributiva fixa em 1, sem externalidades, bens públicos ou ganhos de produtividade de H.
- o está fora da pie e independe de acordos dos fracos; H pode recebê-lo quando uma maioria aprova um acordo que o exclui.
- β∈(0,1), duas rodadas no baseline, dois tipos, m≥3 e fracos simétricos desinformados.
- Não há benefício intrínseco do acordo para H, ratificação, reputação ou escolha endógena da regra.

**Regra original.** O ramo de aprovação com voto não de H contém a regra histórica de cancelamento em G0. Esta é uma premissa registrada, não uma conclusão desta leitura.

### Domínio

- Comparação apenas onde cada objeto fonte existe na classe mantida.
- Endpoints são jogos com suporte degenerado, não limites laterais.
- Misturas residuais têm peso comum e observáveis preservam o vínculo; envelopes marginais não são produtos atingíveis.

### Localizadores

- M:299–348
- M:447–464
- M:1316–1347
- M:1383–1397
- M:2030–2069
- M:3081–3117

## Resultados declarados

**Estatuto da leitura.** Os itens abaixo registram enunciados e a cadeia alegada pelo texto. Não certificam demonstrações, generalidade dos desvios ou equivalência com outro protocolo.

### Baseline

#### Public-type benchmark (`prop:public`)

**Enunciado.** R1: v_U^B(o)=βo; v_M^B(o)=βo se o≤1/m e o se o>1/m. R2: maioria exclui H e entrega a pie ao proponente; unanimidade oferece o a H e retém 1−o.

##### Localizadores

- M:498–517
- M:1427–1458

#### Private terminal games (`prop:terminal`)

**Enunciado.** R2/M coincide com o terminal público; em R2/U a oferta é ℓ para p≤p* e h acima, p*=(h−ℓ)/(1−ℓ), com empate na oferta baixa.

##### Localizadores

- M:555–565
- M:1460–1475

#### Private majority correspondence (`prop:majority`)

**Enunciado.** Π_E=1−kw; Π_S=(1−p)[1−(k−1)w−βℓ]+pw; Π_P=1−(k−1)w−βh; w=β/m. p_SE=β(1/m−ℓ)/[β(1/m−ℓ)+1−β(k+1)/m]; p_SP=β(h−ℓ)/[1−βℓ−βk/m].

##### Células

- h<1/m: S até p_SP inclusive, depois P.
- ℓ<1/m<h: S até p_SE inclusive, depois E.
- 1/m<ℓ<h: E em todos os p.
- ℓ=1/m<h: S só em p=0, E em p>0.
- ℓ<h=1/m: S até p_SE inclusive; acima, E se (1−p)ℓ+ph<βh, P se >, mistura comum E/P se =.

##### Localizadores

- M:571–629
- M:1477–1530

#### Private unanimity correspondence (`prop:unanimity`)

**Enunciado.** p=0: V_U^B=(βℓ,βh); 0<p≤p*: vazio; p>p*: V_U^B=(βh,βh). A primeira coordenada em p=0 é o tipo com massa positiva; a segunda permanece como componente fora do suporte.

##### Localizadores

- M:652–668
- M:1532–1608

#### Private institutional payoff contrast (`prop:privatecompare`)

**Enunciado.** Para p>p*, ΔV^B=(β(h−ℓ),0) sob S, (0,0) sob P e (βh−ℓ,−(1−β)h) sob E; residual vincula esses vetores. p=0 tem células próprias; faixa sem U fica vazia.

##### Localizadores

- M:722–737
- M:1610–1622

#### Informational rents by voting rule (`prop:rents`)

**Enunciado.** IR=V−v. IR_U^B é zero em p=0, vazio na faixa sem U e (β(h−ℓ),0) para p>p*. IR_M^B é dado pelas células abaixo; os rótulos público/privado são conjuntos.

##### Células de renda majoritária

| Benchmark público | Forma privada | IR_M |
|---|---|---|
| ambos incluídos | S | (0,0) |
| ambos incluídos | P | (β(h−ℓ),0) |
| ambos incluídos | E | ((1−β)ℓ,(1−β)h) |
| baixo incluído, alto excluído | S | (0,−(1−β)h) |
| baixo incluído, alto excluído | E | ((1−β)ℓ,0) |
| ambos excluídos | E | (0,0) |

##### Localizadores

- M:791–818
- M:1624–1646

#### Institutional informational-rent contrast (`prop:deltari`)

**Enunciado.** ΔIR^B=IR_U^B−IR_M^B; para p>p*, as seis células correspondentes são (β(h−ℓ),0), (0,0), (βh−ℓ,−(1−β)h), (β(h−ℓ),(1−β)h), (βh−ℓ,0), (β(h−ℓ),0). Em p=0 a célula pública assimétrica retém um componente alto fora do suporte; a faixa sem U permanece vazia.

##### Localizadores

- M:832–853
- M:1624–1646
- M:2030–2069

### Agenda

#### Public agenda payoffs and institutional gap (`prop:agenda-public`)

**Enunciado.** v_U^A=1−β+β²o; v_M^A=1−kβ(1−βo)/m se o≤1/m, e max{v_M^safe,βo} se o>1/m; v_M^safe=1−kβ/m, e=m−k. Atraso majoritário acima de o_M*=1/β−k/m; mistura vinculada na igualdade. Gap baixo negativo; acima de 1/m, sinal de βo−e/m.

##### Localizadores

- M:926–973
- M:2658–2724

#### Private-majority agenda correspondence (`B.7/E.2`)

**Enunciado.** r_χ=βc_χ, d_χ,o=βh_χ,o, a_pass=1−kr_χ. Inclui formas puras e leis Borel/atomless com incentivos pointwise, continuidade literal e uma crença comum fora do suporte. V_M^A(o)≥max{v_M^safe,β²o}; para toda economia/prior há algum ρ com PBE, sem quantificar existência em todo ρ fixado.

##### Localizadores

- M:1648–1830
- M:2195–2360

#### Private-unanimity agenda correspondence (`B.8/E.3`)

**Enunciado.** z_L=1−β+β²ℓ, z_H=1−β+β²h, d=β²h. Continuação só em {0}∪(p*,1]. Em interior existente o vetor é (z,z). A família baixa exige z_L≥d e μ_off=0; a alta exige p>p*. Com μ_off=0 e p>p*, z∈[max{z_L,d},z_H]; com μ_off>p*, payoff (z_H,z_H); μ_off∈(0,p*] é vazio. Em p=0: (z_L,max{z_L,d}); em p=1: (z_H,z_H). As leis e condições pointwise não se reduzem a essa imagem de payoffs.

##### Localizadores

- M:1831–1965
- M:2362–2517

#### Selection-free majority advantage (`prop:agenda-majority`)

**Enunciado.** Mesma especificação e ambas as correspondências não vazias: βh<e/m implica ΔV^A(o)≤−β(e/m−βh)<0 para ambos os tipos e ex ante. Igualdade dá ranking fraco; é condição suficiente, não necessária.

##### Localizadores

- M:1104–1126
- M:2608–2656

#### Informational-rent incidence under unanimity (`prop:agenda-incidence`)

**Enunciado.** Em todo assessment U existente, IR_U^A(ℓ)≥0, IR_U^A(h)≤0 e alguma desigualdade estrita; os componentes fora do suporte continuam definidos. ΔV^A=Δv^A+ΔIR^A é identidade no assessment emparelhado.

##### Localizadores

- M:1128–1166
- M:2726–2814

#### Agenda-comparison decomposition (`prop:agenda-decomposition`)

**Enunciado.** T_g=D_g+I_g em cada comparação completa definida; D_g=v_g^A−βv_g^B, I_g=IR_g^A−βIR_g^B, T_g=V_g^A−βV_g^B. D_U=1−β; D_M≥0; T_U≥0 onde ambas as fontes existem. I_U≤0 na célula alta existente. Q_g=v_g^A−βV_g^B é composto.

##### Localizadores

- M:1180–1240
- M:2816–2954
- M:3040–3117

#### Exact and economic layers (`B.9/F.1`)

**Enunciado.** Sig_ex é invariante completo para a órbita diagonal das duas leis realizadas por tipo; Sum_econ é o pushforward registro a registro no quociente dos nomes fracos. Mantêm-se especificação de crenças e vínculo dos tipos; a assinatura não serializa toda a função off-path do binder.

##### Localizadores

- M:1966–2027
- M:2558–2606
- M:2958–3038

## Mecanismos

**Margem extensiva.** A maioria permite substituir o único informado por mais um voto fraco. A unanimidade elimina esse substituto. A informação não está difundida pelos respondedores fracos.

**Incidência da renda.** Pooling unânime na célula alta paga a ambos o limiar do alto; o baixo retém diferença em relação ao próprio benchmark. Screening, exclusão e a mudança de data de o sob maioria alteram o contrafactual da renda.

**Agenda.** H proponente tem incentivos de sinalização e recebe valor da proposta inicial. O efeito total dessa etapa separa ganho público e interação com informação; não se confunde com o gap U−M no jogo com agenda.

**Interpretação econômica.** Acesso a mercado é motivação estilizada para benefícios distribuíveis e fóruns alternativos. A pie não depende de presença ou execução de H; a opção externa não é destruída pela aprovação de um acordo entre fracos.

### Localizadores

- M:94–128
- M:240–271
- M:820–830
- M:1128–1178
- M:1180–1240
- M:1244–1314

## Comparações e estática comparativa

### Variações consideradas

- Regra U versus M na mesma economia e protocolo de cada jogo.
- Informação privada versus pública do mesmo tipo dentro de cada regra.
- Inclusão pública em o=1/m e mudanças S/P/E em p_SP ou p_SE.
- Prior versus p* e suporte degenerado; a célula vazia interrompe o ranking.
- Agenda A versus baseline B em datas compatíveis, com D/T/I e separação de Q.
- Na agenda, o versus o_M* e e/(mβ); a condição uniforme βh<e/m e seus limites.

**Orientação.** Todos os gaps institucionais são U−M. IR é privado−público. Ex ante aplica-se (1−p) à coordenada baixa e p à alta do mesmo vetor vinculado.

**Restrições.** Os sinais robustos são sobre a correspondência inteira no domínio indicado. Demais sinais pertencem a avaliações/células específicas. Envelopes resumem conjuntos e não os completam artificialmente.

### Localizadores

- M:487–887
- M:926–1240
- M:2030–2069
- M:2569–2656
- M:3081–3117

## Campos empíricos inaplicáveis

- **treatment:** Não há tratamento empírico observado; U/M, informação e agenda são intervenções analíticas em jogos definidos.
- **outcome:** Não há outcome empírico medido; há payoffs, alocações e leis de outcomes endógenos do jogo.
- **estimands:** Não há estimando causal identificado em dados. Os objetos são correspondências formais e diferenças de payoffs/rendas com domínio explícito.
- **preferred_specification:** Não há regressão ou especificação empírica preferida. O jogo baseline e a extensão têm primitivas, conceito e domínio declarados acima.
- **empirical_identification:** A discussão da OMC é aplicação teórica, explicitamente sem identificação causal da criação da instituição ou do tipo histórico.
- **empirical_inference:** Não há inferência estatística ou teste empírico dos mecanismos no manuscrito.
- **population_time:** O domínio é paramétrico/estratégico; exemplos históricos contextualizam, sem população amostral ou janela identificadora.

# 7. What the document does not claim

- Não afirma que toda exclusão privada de H zera sua renda informacional; a tabela de prop:rents diferencia o benchmark público e o timing de o. M:802–818.
- Não afirma que unanimidade favoreça universalmente H ou ambos os tipos. M:739–763,855–875,926–977,1104–1126.
- Não afirma reversão favorável à unanimidade dentro da região estrita βh<e/m em que a proposição garante o contrário. M:1104–1166.
- Não atribui informação privada, capacidade de sinalização própria ou poder assimétrico de proposta aos fracos. M:299–312,1399–1417.
- Não torna H produtivo para a pie, nem exige uma atividade individual posterior para receber x_H. M:314–326,1244–1269. A interpretação de acesso a mercado não acrescenta essa primitiva.
- Não elimina a opção externa de H porque os fracos aprovaram um acordo sem ele. M:340–348,366–368,1383–1397.
- Não trata voto não de H como saída irreversível imediata quando há rodada de continuação. M:328–409,1383–1397.
- Não confunde a regra histórica escrita no original com sua autoridade para o candidato novo; este contrato não adota A1–A3 nem a nova arquitetura por retroação.
- Não demonstra inexistência com votos mistos; permite mistura de propostas e distingue 'ballots puros' de estratégias de proposta puras. M:411–464,652–668,2195–2360.
- Não atribui payoff zero, sinal, ranking ou interpolação a uma célula vazia. M:2067–2069.
- Não ressuscita tipos de probabilidade zero no posterior; seus componentes contrafactuais podem permanecer no vetor de payoffs. M:1399–1417,2030–2039,2473–2517.
- Não permite recombinar coordenadas de seleções diferentes nem interpretar envelopes como retângulos atingíveis. M:2041–2065,2569–2606.
- Não afirma existência de agenda majoritária em todo ρ fixado; o enunciado é existência para algum ρ em cada economia/prior. M:2295–2305.
- Não reduz o assessment completo a uma assinatura de leis realizadas nem impõe um sorteio comum entre regras. M:2558–2606,2958–3038.
- Não apresenta T, I e Q como efeitos estimados em dados. T exige os dois jogos; Q muda agenda e informação simultaneamente. M:1180–1240,3081–3117.
- Não identifica a causa da criação da OMC, a preferência histórica pela regra ou o tipo de um ator histórico. Não nega influência informal de agenda. M:202–208,1291–1314,1342–1347.
- Não resolve mais de dois tipos, mais de duas rodadas baseline, m=2, β=1, roll-call, benefícios intrínsecos, regras/agenda endógenas, ratificação, implementação institucional ou reputação. M:1316–1347.
- O contrato de leitura não certifica provas, cálculos das figuras, referência bibliográfica, fatos históricos, Lean, scripts ou transporte ao jogo novo. Esses objetos têm verificações e revisões separadas.

# 8. Terminology

| Termo preferido | Evitar | Razão |
|---|---|---|
| hegemon (H) | leader; proposer como sinônimo de H no baseline | H concentra a opção externa privada, mas só propõe na etapa A. Poder, hegemonia e liderança não são sinônimos. |
| low/high disagreement-payoff type (ℓ/h) | Estado fraco como sinônimo de H baixo; tipo moral ou produtivo | Os tipos diferem no valor privado da melhor alternativa, não no status de jogador ou produtividade. |
| weak states, uninformed and symmetric | respondedores informados; sinalização dos fracos | A margem central depende de todos os substitutos de H serem desinformados. |
| outside option o, outside the fixed pie | parcela da pie; benefício do acordo dos fracos | A opção externa independe dos acordos dos demais e pode ser recebida sob exclusão. |
| allocation x_j versus payoff | alocação como sinônimo de payoff total | Payoff pode ser opção externa ou continuação descontada; a soma das alocações é que respeita a pie. |
| pivotal approval / substitute vote | veto produtivo; contribuição tecnológica de H | O canal é institucional: possibilidade de aprovar sem o único informado. |
| informational rent IR=V−v | todo excedente; todo benefício de unanimidade; renda de agenda | Renda de informação usa o benchmark público da mesma regra e tipo. |
| institutional gap Δ=U−M | gap sem orientação; inversão silenciosa M−U | A orientação é uniforme nas comparações do manuscrito. |
| screening S / pooling P / exclusion E | classes disponíveis livremente em qualquer célula | Os rótulos identificam formas selecionadas pela correspondência; seus regimes e empates são específicos. |
| pure ballot strategies | equilíbrio inteiramente puro; inexistência geral de equilíbrio | Propostas podem ser mistas/Borel; a inexistência é restrita à classe mantida de ballots. |
| complete equilibrium assessment | vetor de payoff independente; escolha de continuação escalar | Estratégias, crenças, seletores e outcomes precisam permanecer conjuntamente admissíveis. |
| exact signature of realized laws | código de toda estratégia off-path | Exact refere-se à órbita diagonal do par de leis realizadas, com binder completo subjacente. |
| D, I, T e Q como comparações entre jogos | efeitos causais estimados | D/T/I respeitam datas e fontes; Q é um contraste composto. |
| theoretical WTO application / analytical benchmark | identificação causal da criação da OMC; ausência histórica de poder informal | O texto declara a limitação empírica e separa agenda formal da influência de facto. |

# 9. Reconciliation log

As formulações comprimidas do original permanecem identificadas. A leitura estreita usa as definições e células explícitas do próprio documento; não apaga divergência de redação, não altera o fonte e não impede crítica posterior dessa redação. Não restou dúvida interpretativa material sobre o claim usado pelo contrato.

## R01

**Pergunta.** A introdução M:117–121 afirma zero de renda sob qualquer exclusão privada, ou a renda precisa ser lida nas células públicas/privadas de prop:rents?

**Origem.** R-framing:72–77 e releitura macro; delimitação estreita solicitada pelo coordenador.

**Resposta e resolução.** A redação de abertura é mais comprimida que a caracterização. O contrato adota a regra explícita M:802–818: IR_M depende conjuntamente da inclusão pública e da forma privada. Se ambos são excluídos também no benchmark público, E dá (0,0); se o público inclui o baixo e exclui o alto, E dá ((1−β)ℓ,0). O exemplo M:285–289 fornece (.01,0) com exclusão privada. Logo não se atribui ao paper uma proposição universal de renda zero sob E. A compressão textual permanece registrada como tal, sem alteração da fonte.

**Evidência.** M:117–128; M:273–295; M:791–818; M:820–830.

**Status:** `resolved_by_explicit_cellwise_scope`.

## R02

**Pergunta.** A expressão 'In those cases' em M:132–135 coloca a reversão informacional dentro da região de vantagem majoritária robusta βh<e/m?

**Origem.** R-framing:72–77, R-agenda:32–68 e releitura macro.

**Resposta e resolução.** O contrato separa dois resultados. Prop:agenda-majority em M:1104–1116 garante vantagem privada de maioria em toda a região estrita βh<e/m, dadas ambas as correspondências. M:1158–1166 oferece uma implicação condicional quando Δv_A(ℓ)<0 e um assessment tem ΔV_A(ℓ)>0. A tabela M:999–1021 exibe esse caso com h=.90, β=.90 e e/m=.5, portanto fora da região suficiente. A introdução não é usada para autorizar reversão dentro da região em que a proposição a exclui. Registra-se o referente comprimido; não se afirma que o original já o redigiu de forma plenamente delimitada.

**Evidência.** M:130–135; M:926–973; M:999–1021; M:1104–1126; M:1158–1166.

**Status:** `resolved_by_distinguishing_robust_region_and_conditional_reversal`.

## R03

**Pergunta.** 'US had no agenda power' em M:51 nega influência informal histórica ou descreve a ausência do direito formal exclusivo retirado no benchmark?

**Origem.** R-framing:79–96 e releitura macro.

**Resposta e resolução.** A leitura do argumento desenvolvido restringe a afirmação à agenda formal exclusiva. M:55–68 relata influência por textos, pacotes e alternativas; M:202–208 declara expressamente que o benchmark não pretende negar agenda no caso histórico. M:1291–1297 repete a separação. O contrato não certifica a afirmação histórica nem atribui ao autor ausência de influência de facto; a omissão de qualificação da frase inicial fica registrada.

**Evidência.** M:45–83; M:202–208; M:1291–1297.

**Status:** `resolved_by_formal_right_vs_informal_influence`.

## R04

**Pergunta.** O acesso a mercado e o 'identifying benchmark' autorizam interpretar o artigo como modelo produtivo ou identificação causal da criação da OMC?

**Origem.** R-framing:148–215, 217–250 e releitura macro.

**Resposta e resolução.** Não. O original fixa a pie, coloca o fora dela e não dá papel produtivo à participação de H. M:1291–1314 e 1342–1347 delimitam a aplicação como teórica, sem identificar criação da OMC ou tipos históricos. 'Identifying' em M:1372 designa isolamento analítico do canal. Acesso a mercado é interpretação estilizada das alocações/alternativas, sem estimar efeitos comerciais nem exigir atividade individual para receber x_H.

**Evidência.** M:299–326; M:1244–1269; M:1291–1314; M:1342–1347; M:1369–1375.

**Status:** `resolved_by_explicit_theoretical_scope`.

## R05

**Pergunta.** Na frase M:992–995, quem compra o voto de H se H é proponente em A?

**Origem.** Pergunta do macro ao leitor /root/agenda_source_read e resposta em 19/09/2026; confirmação dos localizadores.

**Resposta e resolução.** O referente consistente é o baseline que determina a continuação/preço em A. Na etapa corrente de agenda, H compra votos fracos. E.6 deriva o preço dos fracos da continuação majoritária que inclui ou exclui H. A frase de interpretação da figura não muda o protocolo corrente.

**Evidência.** M:888–916; M:992–995; M:2658–2671.

**Status:** `resolved_by_temporal_reference_to_baseline`.

## R06

**Pergunta.** E.1 retém a história rejeitada inteira. O seletor de agenda pode depender livremente da proposta e do vetor de votos, ou só de regra, estágio e posterior?

**Origem.** R-agenda:127–147, conferência macro nas fontes e confirmação direta do leitor /root/agenda_source_read em 19/09/2026.

**Resposta e resolução.** O assessment retém a história completa, mas o seletor admissível da agenda tem dependência mais estreita: regra, estágio de entrada e posterior. M:1656–1658, 2195–2215 e 2385–2399 usam a seleção Markov χ(μ)/κ(μ); as fontes de derivação explicitam a restrição. As crenças internas do baseline continuam com valores livres locais de A.2; não se transporta o Markov da agenda ao baseline.

**Evidência.** M:1399–1417; M:1650–1658; M:2164–2193; M:2195–2215; M:2385–2399; model_redesign/agenda_extension_A_M_msb_results.md:90–103; model_redesign/agenda_extension_A_U_msb_contract.md:39–47,128–133.

**Status:** `resolved_by_declared_selector_domain`.

## R07

**Pergunta.** 'Disciplined' restringe somente pontos de massa positiva, e os rótulos E/S/P/EP denotam qualquer vetor anônimo de continuação?

**Origem.** R-agenda:70–87,127–147 e leitura direta macro dos trechos da derivação; leitor confirmou ausência de outra ambiguidade material.

**Resposta e resolução.** Não. A regra pointwise alcança todo suporte, inclusive pontos de massa zero, e exige existência do limite local de Bayes; fora dele há um único μ_off. E/S/P/EP designam os representantes literais uniformes e sua mistura comum admissível. As fontes de derivação citadas pelo leitor tornam explícitos o domínio e os kernels compactados pela notação. Isso esclarece o objeto afirmado, sem verificar que as caracterizações o provem.

**Evidência.** M:1648–1676; M:2195–2215; M:2265–2305; M:2390–2405; model_redesign/agenda_extension_A_M_msb_results.md:106–144,183–267,305–323.

**Status:** `resolved_by_pointwise_support_and_literal_representatives`.

## R08

**Pergunta.** A assinatura exata codifica estratégias fora do caminho completas ou apenas uma órbita de leis realizadas?

**Origem.** R-agenda:108–125, releitura macro e confirmação direta do leitor /root/agenda_source_read em 19/09/2026.

**Resposta e resolução.** Sig_ex codifica a órbita diagonal conjunta das leis realizadas por tipo. O binder completo continua subjacente para definir admissibilidade e comparações, mas sua função off-path inteira não é o objeto reconstruído a partir da assinatura. Sum_econ elimina nomes por registro; avaliações completas são emparelhadas antes da projeção.

**Evidência.** M:1966–2027; M:2558–2565; M:2569–2606; M:2976–2997.

**Status:** `resolved_by_explicit_realized_law_object`.

## R09

**Pergunta.** Qual arquitetura é atribuída ao artefato original, diante da decisão autoral de 19/09/2026?

**Origem.** R-baseline:290–312, leitura da decisão atual e instrução explícita do coordenador de contratar os bytes originais.

**Resposta e resolução.** O objeto desta leitura é somente G0: M:340–348, tabela M:366–368 e A.1 contêm o cancelamento de x_H quando H vota não e há aprovação. A decisão de 19/09/2026 autoriza uma arquitetura diferente, (C,x), com parcelas zero fora de C, consentimento de todos os convidados e implementação integral. Ela não é retroimportada a G0 nem torna A1–A3 adotada. O contrato original descreve o que deverá ser revalidado após mudanças e não certifica transporte.

**Evidência.** M:340–348; M:358–374; M:1383–1397; quality_reports/coalition_protocol_2026-09-19/author_decision.md:11–28.

**Status:** `resolved_by_source_identity_and_version_boundary`.

**Confirmação do leitor da agenda:** Confirmadas as três resoluções: referente de 992–995 é baseline; seletor depende apenas de regra/estágio/posterior; Sig_ex classifica órbitas de leis realizadas e plans off-path ficam no binder. Não é avaliação da validade das provas. Escopo: R05,R06,R08; ausência de outra ambiguidade interpretativa material em sua leitura, com R07 ancorada no record e nas fontes verificadas.

**Pendências interpretativas:** nenhuma. O objeto novo autorizado tem contrato e revisão separados; resultados novos não foram retroimportados.

# 10. Gate verdict

**PASS para fidelidade interpretativa do original**, round 1, hash `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`. Isso não certifica validade científica, completude de provas, figuras ou transporte ao novo protocolo.

- Leitura integral do artefato e dos três records; mapa cobre o corpo, todos os apêndices substantivos, a notação e o abstract.
- Claims centrais, domínios, não-afirmações e termos têm localizadores verificáveis; a especificação empírica é explicitamente inaplicável.
- As compressões textuais foram preservadas no log e delimitadas pelas tabelas/células e definições explícitas, sem alterar o texto ou inventar novos resultados.
- O leitor independente da agenda confirmou as resoluções de sua seção; nenhuma ambiguidade interpretativa material permanece após a delimitação documentada.
- O fonte lido mantém o SHA-256 registrado. PASS vale apenas para fidelidade deste original, não para validade científica ou versões alteradas.

| Controle | Resultado |
|---|---|
| coverage | satisfeito |
| anchors | satisfeito |
| scope | satisfeito |
| nonclaims | satisfeito |
| preferred_specification | satisfeito |
| ambiguities | satisfeito |
| source_hash | satisfeito |

**Validação mecânica do record:** VALID; SHA-256 do artefato confere. Verificações complementares: 37 unidades contíguas, cada uma abaixo de 4.000 palavras brutas, 20 claims com evidência, hashes dos três records e UTF-8 conferidos.

```bash
python3 /Users/manoelgaldino/.codex/skills/argument-fidelity-gate/scripts/validate_contract.py quality_reports/coalition_protocol_2026-09-19/argument_contract/original/argument_contract.json --artifact formal_model_v6.Rmd
```

**Limites do gate**

- Sem edição do manuscrito ou das notas de derivação.
- Sem revisão científica/adversarial, derivação nova ou verificação numérica.
- Sem compilação, QA visual ou atualização de figuras.
- Não certifica equivalência/transportabilidade ao novo protocolo de coalizão; esse candidato requer contrato e revisão próprios.

Qualquer finding deve citar o artefato/hash/claim e não ampliar a versão delimitada. Se a crítica visar uma compressão textual original, ela pode citar R01–R09; a reconciliação não torna a formulação imune a crítica. Mudanças de primitivas, resultados ou escopo suspendem o uso deste PASS para o novo candidato até revalidação.
