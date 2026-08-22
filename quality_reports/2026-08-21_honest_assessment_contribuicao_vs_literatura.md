# Honest assessment — contribuição real do paper vs. literatura próxima

**Data**: 2026-08-21 (v2 — atualizada após leitura direta de Piazolo–Vanberg e Glynia–Thum–Xefteris; a v1, baseada em memória, subestimava a proximidade desses vizinhos)
**Natureza**: avaliação informal solicitada pelo autor; não é parecer de skill de review. Condicional aos resultados de N6/N7, que ainda não existem.
**Formulação da contribuição pelo autor (aceita como alvo)**: um hegemon obtém renda informacional sob unanimidade relativa à maioria; o essencial é a informação privada sobre o tipo da outside option do hegemon. Sem informação privada, unanimidade ainda é preferível para H, mas o diferencial é poder puro (continuation value do mundo sem acordo). A contribuição é o *incremento informacional*, identificado por diferença-em-diferenças (ΔRI, estimando do contrato Gate 0).

## Os dois vizinhos mais próximos (lidos diretamente, PDFs em `references/`)

**Piazolo & Vanberg (2025, GEB, "Legislative Bargaining with Private Information: A Comparison of Majority and Unanimity Rule"; arquivo `modelo_similar_geb.pdf`).** Dois períodos, três jogadores: proponente fixo NÃO informado + dois respondentes com breakdown values privados b∈{l,h} (recebidos no breakdown), probabilidade de breakdown (1−δ) após falha do período 1, certa após o período 2. Maioria (1 respondente) vs unanimidade (2). Conceito: PBE em estratégias stagewise-undominated + crenças off-path à la D1 + seleção das continuações preferidas pelo proponente; mistura permitida. Resultados: rejeição tem valor de sinalização POSITIVO sob unanimidade (rejeitar → percebido como tipo alto → oferta melhor no período 2) e NEGATIVO sob maioria (quem rejeita é excluído da coalizão seguinte); respondentes "mais caros" sob unanimidade; mais atraso e desacordo ineficiente sob unanimidade.

**Glynia, Thum & Xefteris (2026, Public Choice, "Unanimity versus Majority: Proposing under Incomplete Information"; arquivo `modelo_similar_public_choice.pdf`).** One-shot: proponente não informado, dois respondentes com custos de aceitação privados iid, uma única proposta take-it-or-leave-it, maioria vs unanimidade. Moldura UE (unanimidade vs QMV no Conselho). Sem dinâmica/sinalização por construção ("shuts down the dynamic channel" de Tsai–Yang e P–V). Resultados: sob incerteza, proponente joga seguro (pooling caro) sob unanimidade e aposta (lowball) sob maioria; isso pode dar aprovação MAIS provável sob unanimidade e transferências totais MAIORES sob maioria — reversões da sabedoria convencional.

## O que esses vizinhos tomam (não reivindicar como novidade)

1. **"Jogador informado fica mais caro sob unanimidade; maioria põe teto via ameaça de exclusão"** — mecânica central de P–V, publicada. Inclui a economia da morte da separação (rejeição revela tipo alto → continuação melhor → tipo baixo imita = "positive signaling value" deles) e o atraso como fenômeno de unanimidade.
2. **Dois períodos + stage-undominated voting + desempates + seleção declarada** como arcabouço de comparação de regras com informação privada — P–V.
3. **Pooling-caro vs lowball do proponente incerto como motor de comparação institucional** — GTX, até em one-shot.
4. A célula "maioria vs unanimidade com informação privada em barganha multilateral" NÃO está vazia: P–V, GTX, Tsai (2009), Tsai & Yang (2010), Chen & Eraslan (2013, 2014), Ma (2023). A frase "literatura rala" (v1 desta avaliação) está datada; usar com cuidado.

## O que já era conhecido antes deles (benchmark, nunca contribuição)

1. **Veto/unanimidade beneficia o veto player sob informação completa**: estática de quotas em Baron–Ferejohn; **Miller et al. (2018)** — citação exata, via P–V: com breakdown values conhecidos, breakdown alto é vantagem sob unanimidade e pode ser desvantagem sob maioria (exclusão dos caros). Complementos a verificar: Winter (1996, APSR, "Voting and Vetoing"); McCarty (2000, AJPS). É o benchmark do resultado de informação completa do autor (N7): "diferencial = poder puro".
2. **Informação privada sobre reservas → renda e atraso em barganha**: Cramton (1984), Admati–Perry (1987), Fudenberg–Tirole (1983, o bilateral mais próximo de P–V), Fearon (1995) na versão RI.
3. **"Consenso serve ao poderoso" verbal em RI**: Steinberg (2002), Stone (2011), Gruber (2000).
4. **Persuasão/design**: Bardhi–Guo (2018), Kim–Kim–Van Weelden (2025) — distintos pela direção do fluxo de informação (design/commitment vs screening de um veto player informado); menos próximos que P–V/GTX.

## A contribuição que sobrevive (reposicionada; condicional a N6/N7)

1. **Margem de composição de coalizão com substitutos NÃO informados — o diferencial técnico mais nítido.** Em P–V/GTX todos os respondentes são informados e simétricos: sob maioria, o substituto de um informado é outro informado; a fricção informacional nunca desliga. Aqui o informado é UM jogador distinto (H) entre m fracos não informados: maioria permite montar a coalizão contornando o único informado, e a continuação fica belief-free (N1/N3). A regra não muda só o preço do voto informado (P–V) — decide SE algum informado precisa estar na coalizão. Maioria funciona como benchmark endogenamente livre de informação.
2. **A decomposição poder vs. informação (ΔRI) não existe em nenhum vizinho.** GTX usam informação completa só como ilustração; P–V nem isso. "Renda informacional por regra" como objeto contrafactual (privado − público, por regra, mesma primitiva; N7) permanece sem dono. A formulação do autor — sem info privada unanimidade ganha por continuation value; o incremento informacional liga só sob essencialidade — é o headline correto.
3. **Opção externa externa à torta + limiar de hegemonia.** Nos vizinhos, o desacordo do informado é o breakdown value do jogo pequeno. Aqui H excluído coleta o_θ fora da torta (exclusão ≠ punição a zero), e disso nasce a fronteira o₁ vs 1/m: diferencial informacional liga quando o tipo forte vale mais que o substituto — definição endógena de hegemonia (projeção do auditor sobre células de N3 + famílias de N4; N6/N7 decidem).
4. **N genérico, reconhecimento rotativo entre fracos (π_H=0), pergunta de RI.** Vizinhos: 3 jogadores, proponente fixo, sem pergunta hegemônica. O paper formaliza Steinberg: consenso como tecnologia de poder de um hegemon SEM poder de agenda. GTX moram na vizinhança aplicada (UE) mas pela ótica do proponente/eficiência.
5. **Subprodutos sem paralelo**: zona sem PBE puro interpretada como instabilidade sob declínio contestado (âncora: ciclos de Edgeworth) e descontinuidade reputacional em ν=0⁺.

## Fricções que a introdução/o conceito precisam enfrentar

1. **Existência vs P–V**: eles obtêm existência com D1 + mistura + seleção proponente-preferida; nosso pacote (puro + no-signaling + as-if-pivotal + T^Y) tem região sem equilíbrio. Referee que conhece P–V perguntará se a inexistência é artefato da escolha de conceito. Resposta: parágrafo deliberado comparando os pacotes, justificativa substantiva das convenções (registro de decisão 2026-08-21) e a leitura de instabilidade como interpretação, nunca teorema.
2. **Arquitetura da introdução**: P–V e GTX cedo, com crédito integral pela mecânica de preços/sinalização; novidade entra como configuração hegemônica (itens 1–4 acima). O resultado de informação completa entra como benchmark citando Miller et al. (2018) e afins.
3. **Preempção Feddersen–Pesendorfer (1998)**: agregação de informação dispersa entre votantes ≠ renda de um bargainer informado; GTX citam exatamente essa literatura — um parágrafo resolve.

## Vulnerabilidades

1. Tudo condicional a ΔRI > 0 robusto na região de comparação; se a fronteira o₁ vs 1/m não se confirmar em N6/N7, o paper vira nota quantitativa sobre tetos de preço — e aí a distância para P–V encolhe perigosamente.
2. Se a introdução reivindicar a mecânica de sinalização/exclusão como nova, o desk reject vem de quem conhece o GEB. O reposicionamento não é opcional.

## Ações derivadas

- [ ] Adicionar ao .bib e ler: Miller et al. (2018); Tsai (2009); Tsai & Yang (2010); Chen & Eraslan (2013, 2014); Ma (2023); Feddersen & Pesendorfer (1998); verificar Winter (1996) e McCarty (2000); considerar Miettinen & Vanberg (2025), Rosenthal & Zame (2022), Agranov et al. (2024) — todos localizáveis pelas bibliografias de P–V/GTX.
- [ ] Goal 5, introdução benchmark-primeiro: (i) informação completa = poder puro (Miller et al.); (ii) preços de informados por regra = P–V/GTX; (iii) novidade: composição de coalizão com substitutos não informados, decomposição ΔRI, limiar de hegemonia, consenso sem agenda power como tecnologia de poder.
- [ ] Parágrafo de conceito comparando nosso pacote com o de P–V (D1 + mistura + proposer-preferred) e explicando a região de inexistência.
- [ ] Quando N6/N7 fecharem: verificar a projeção o₁ vs 1/m; se confirmada, promover a resultado central.
