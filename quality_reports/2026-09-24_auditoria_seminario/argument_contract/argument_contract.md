# Argument contract — manuscrito de coalizão

## 1. Source-bound identity

**Contract ID:** `informational-power-coalition-manuscript:9356d86a2e89:round2`. **SHA-256 do Rmd:** `9356d86a2e893481968ee96a918c2109e726444c5d902ce88edd6f1a5d86345f`. **Bibliografia:** `658af186c73c1291da02a9fd4e3482fc953549ed46036ae24303b45f61309447`.
Fonte: [combined_manuscript_preview.Rmd](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/combined_manuscript_preview.Rmd). Registro de impacto: [revalidation.md](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/argument_contract/manuscript_candidate/revalidation.md).

## 2. Document profile

3.349 linhas e 19.487 palavras brutas por whitespace, incluindo YAML, código e LaTeX. Treze seções substantivas subdivididas em 35 unidades substantivas e 2 documentais, cobrindo P1–3348; References inicia em P3349. Sem renderização/contagem de páginas.
Macro leu diff integral, bibliografia alterada e consumidores; reutiliza leituras originais somente por identidade comprovada. Leitor independente /root/provenance_inventory leu o preview inteiro por blocos e registrou impacto. Nenhum dos dois implementou os patches ou este candidato.

## 3. Thesis, question, and contribution

A unanimidade pode beneficiar um hegemon com informação privada porque torna seu consentimento indispensável, enquanto a maioria pode substituí-lo por fracos desinformados; o efeito distributivo e a renda informacional dependem do tipo, do benchmark público, da correspondência e de sua existência, com um jogo de agenda separado para H proponente.

Quando a necessidade do consentimento do único ator informado, distinguida de sua opção externa e de seus direitos de proposta, faz unanimidade favorecer H em comparação com maioria?

O manuscrito apresenta como contribuição a margem extensiva de inclusão/exclusão do único informado, além das margens pooling/screening presentes na literatura motivadora. Caracteriza os benchmarks e jogos privados de duas rodadas, separa payoff público e renda informacional, e acrescenta uma etapa de proposta informada para decompor o efeito de agenda sem apagar multiplicidade. A aplicação à OMC é teórica; a novidade bibliográfica e os fatos históricos não são verificados por este contrato.

## 4. Core claims

| ID | Afirmação | Força |
|---|---|---|
| C01 | A margem extensiva é a inclusão do único ator informado: maioria permite acordo entre fracos desinformados sem H; unanimidade exige seu consentimento. Isso pode gerar renda informacional do tipo baixo mesmo sem H propor. | mecanismo teórico condicional |
| C02 | O candidato modela um jogo distributivo de duas rodadas, m≥3 fracos simétricos, H com o∈{ℓ,h}, 0<ℓ<h<1, prior p e desconto 0<β<1. A pie é fixa em 1; a opção externa de H é privada, externa à pie e disponível quando um acordo o exclui. | primitivas e domínio declarados |
| C03 | A proposta pública é y=(C,x): o proponente pertence a C, cuja cardinalidade alcança a quota; x≥0, soma≤1 e x_j=0 fora de C. Votam simultaneamente os convidados, proponente conta sim, e todos devem consentir. Qualquer recusa rejeita o pacote inteiro. Aprovação implementa automaticamente as parcelas; H membro recebe x_H, H excluído recebe o. Não há acúmulo em qualquer história factível nem cancelamento após aprovação. | primitivas novas e claim estrutural de não acúmulo, em todas as histórias factíveis |
| C04 | A solução baseline é uma correspondência de PBE com votos puros, comparação pivotal dos convidados fracos, T^Y e desempate do proponente. Ações dos fracos, inclusive C, não informam; sem H convidado o ballot mantém a crença. Com H convidado, Bayes positivo e valores livres locais por ballot/voto de H respeitam o suporte inicial. | conceito declarado, não refinamento demonstrado |
| C05 | Com tipo público, R2 dá aos fracos a possibilidade de excluir H sob maioria e exige pagar o a H sob unanimidade. Em R1, unanimidade paga βo; maioria inclui H se o≤1/m e lhe paga βo, ou o exclui e H recebe o. | proposição formal por rodada e regra |
| C06 | Na rodada terminal privada, maioria mantém o resultado terminal público; sob unanimidade o proponente oferece ℓ para p≤p*=(h−ℓ)/(1−ℓ), e h para p>p*. A igualdade seleciona a oferta baixa. | proposição formal terminal |
| C07 | A correspondência privada de maioria em R1 compara screening S, pooling P e exclusão E, com preços βℓ, βh e β/m e cutoffs p_SP e p_SE. Os regimes dependem de ℓ e h em relação a 1/m; empates obedecem à seleção prescrita, com mistura E/P vinculada apenas no residual permitido. | caracterização formal exaustiva declarada |
| C08 | No baseline privado unânime, p=0 dá acordo imediato baixo; 0<p≤p* dá correspondência vazia na classe mantida de votos puros; p>p* dá pooling imediato a βh. O vetor tipo a tipo é (βℓ,βh) em p=0 e (βh,βh) na célula alta. | caracterização e inexistência na classe declarada |
| C09 | O contraste privado do baseline é unanimidade menos maioria e mantém tipos e seleção vinculados. Acima de p*, unanimidade menos screening dá (β(h−ℓ),0); menos pooling dá (0,0); menos exclusão dá (βh−ℓ,−(1−β)h). | comparação formal condicionada à existência |
| C10 | Renda informacional é privado menos público dentro da mesma regra; ΔIR é unanimidade menos maioria dessas rendas. Unanimidade dá (β(h−ℓ),0) para p>p*, zero em p=0 e vazio no intervalo sem equilíbrio. Em maioria a renda depende conjuntamente da inclusão pública de cada tipo e da forma privada; exclusão pode alterar a data do recebimento de o e produzir renda positiva. | decomposição e incidência por célula |
| C11 | A extensão acrescenta A obrigatório: H propõe o sinal público completo (C,x) em Y_g, com H∈C, e todos os convidados fracos precisam consentir. Aprovação implementa em A; recusa entra numa seleção completa pública, Borel, anônima/Markov de R1 no mesmo posterior, com β uma vez. C permanece no espaço de sinais e em Bayes. | jogo distinto e restrições declaradas |
| C12 | Na agenda pública, v_U^A(o)=1−β+β²o; v_M^A(o)=1−kβ(1−βo)/m para o≤1/m e max{1−kβ/m,βo} para o>1/m. Sob maioria, o cutoff o_M* governa acordo imediato ou atraso; o gap institucional depende do nível de o. | proposição formal por ramo |
| C13 | A agenda privada M é correspondência no espaço Y_M de contratos completos: formas puras e leis Borel gerais satisfazem incentivos por tipo, Bayes pointwise e seleção literal comum. V_M≥max{v_safe,β²o}; acordos usados convidam k fracos quase certamente, sem apagar recusas maiores. Há existência para algum ρ por economia/prior. Em endpoints, cada lei dá probabilidade um ao argmax. | caracterização e limite uniforme declarados |
| C14 | A agenda privada U tem famílias baixa/alta, endpoints próprios e vazios, preservadas pelo mapa C=N. No interior existente, ambos os tipos têm o mesmo payoff. O novo lema cobre x^h dentro e fora do suporte e força V=z_H e leis δ_xh quando μ_off>p*. O teto global V_U≤z_H tem argumento separado. Endpoints especificam probabilidade um no conjunto de melhores respostas. | caracterização formal por domínio |
| C15 | Se as duas correspondências de agenda são não vazias na mesma especificação e βh<e/m, maioria dá mais a ambos os tipos e ex ante: V_U^A(o)−V_M^A(o)≤−β(e/m−βh)<0; na igualdade o ranking é fraco. | condição suficiente uniforme sobre assessments |
| C16 | Na agenda, IR_g^A=V_g^A−v_g^A e ΔV^A=Δv^A+ΔIR^A. Em todo assessment unânime existente, IR_U^A(ℓ)≥0, IR_U^A(h)≤0 e alguma desigualdade é estrita. Uma reversão privada quando o público favorece maioria exige que ΔIR compense o gap público. | decomposição algébrica e incidência delimitada |
| C17 | A comparação temporal da agenda separa D=v^A−βv^B, I=IR^A−βIR^B e T=V^A−βV^B, com T=D+I. D_U=1−β; T_U é não negativo onde definido. Q=v^A−βV^B muda simultaneamente agenda e informação e é um contraste composto. | identidade entre jogos e sinais delimitados |
| C18 | A representação exata registra a órbita diagonal conjunta das leis realizadas por tipo; M conserva (C,x), os votos efetivos e ⊥ como não convite. O resumo econômico elimina nomes por registro. Os pares de assessments completos são formados antes de projetar; planos off-path permanecem no binder e envelopes são limites marginais, sem sorteio comum entre regras. | resultado de representação declarado |
| C19 | A discussão da OMC é uma aplicação teórica ilustrativa: acesso a mercado, saída, agenda e pacotes motivam primitivas; o modelo isola o preço do consentimento indispensável. Não identifica causalmente a criação da OMC, o tipo histórico de EUA/CE nem a escolha endógena da regra. | interpretação substantiva com limites explícitos |
| C20 | Os resultados mantêm duas rodadas, dois tipos, m≥3 e β<1; formal igualdade de votos pode coexistir com desigualdade por opção externa, proposta e consentimento sem substituto. O paper preserva multiplicidade e ausência de comparação nas células vazias. | síntese e limites reconhecidos |

## 5. Claim → evidence → scope map

| Claim | Localizadores atuais | Evidência | Escopo |
|---|---|---|---|
| C01 | P:94–129, 244–275, 648–728, 1270–1295, 1381–1386 | Contraste entre correspondências de maioria e unanimidade e distinção entre screening, pooling e exclusão. | Economia fixa, um informado, baseline com propostas dos fracos; o sinal e a existência dependem da célula. Não se infere que toda exclusão zera renda. |
| C02 | P:303–342, 344–388, 1411–1430 | Definições de jogadores, alocações e transições; tabela de payoffs e Appendix A.1. | Sem produtividade adicional de H, sem externalidades, sem benefícios intrínsecos do acordo; todos os fracos têm opção externa zero. |
| C03 | P:316–394,1411–1430 | Definição de Y_g^i, quotas, tabela de transições e divisão de casos de A.1. | Substitui a regra histórica; não depende apenas de propostas ótimas, não permite x_H>0 fora de C e não exige execução individual posterior. |
| C04 | P:428–481, 1432–1456 | Definições de assessment e regras operacionais de A.2. | Não é equilíbrio sequencial nem disciplina global única de crenças. Loterias de propostas permitidas e tipos fora do suporte retidos nos vetores não autorizam ressuscitar sua probabilidade. |
| C05 | P:504–559, 1460–1492 | Proposição prop:public, tabela tab:publicgames e prova B.1. | No empate o=1/m, a seleção inclui H. Preço do voto não é o payoff de H excluído. |
| C06 | P:561–586, 1494–1509 | Proposição prop:terminal e prova B.2. | p é a crença de entrada de R2. Resultado terminal sem desconto interno; continuação trazida a R1 recebe β uma vez. |
| C07 | P:588–646, 694–718, 1511–1567 | Proposição prop:majority e prova B.3; tabela de correspondências. | Não são três estratégias livremente escolhidas em toda célula; o mesmo peso residual vincula todas as coordenadas e outcomes. |
| C08 | P:648–728, 1569–1645 | Proposição prop:unanimity, tab:privatecorrespondence e prova B.4. | Inexistência não é payoff zero nem prova de inexistência com votos mistos. O componente do tipo alto em p=0 é fora do suporte. |
| C09 | P:730–780, 1647–1659, 2179–2218 | Proposição prop:privatecompare, figura fig:privatecompare e B.5. | p=0 tem as próprias células; 0<p≤p* não recebe ranking. Misturas geram segmentos vinculados, não produtos de envelopes. |
| C10 | P:782–903, 1661–1683, 2190–2218 | Proposições prop:rents e prop:deltari, tabela algébrica completa e figura fig:rents. | Não há zero universal sob exclusão, nem sinal institucional universal. O exemplo P:277–299 tem IR_M=(.01,0) apesar da exclusão privada. |
| C11 | P:905–939,2301–2378 | Etapa A, sinal público completo, topologia por componente, limite Bayes em todo suporte e seleção Markov completa. | A obrigatório, sem skip; a disciplina única de μ_off não substitui a regra local dentro do baseline. |
| C12 | P:941–1047, 2888–2954 | Proposição prop:agenda-public, fig:agendagap, E.6–E.8. | A figura usa m=4, β=.90, k=e=2. O uso de 'comprar voto de H' em P:1015–1018 remete ao baseline que determina a continuação, não ao ballot corrente em A. |
| C13 | P:1685–1924,2380–2581 | B.7 e E.2 reescritos sobre Y_M; formas puras, A14 equivalente, piso uniforme, minimalidade quase certa e representantes literais. | Não equivale ao jogo majoritário histórico; não restringe todos os suportes a finitos nem retira convites maiores rejeitados. Igualdade de payoff é quase certa. |
| C14 | P:1925–2107,2582–2798 | Isomorfismo C=N, primeira redução de B.8, lema P1982–2021 e duas aplicações, famílias e endpoints E.3. | US-1 consome valor comum e disciplina de Bayes/incentivos; não é premissa do teto global. A família baixa exige átomo positivo em x^ℓ. Endpoints importados conforme QI-01. |
| C15 | P:1130–1152, 2838–2886 | Proposição prop:agenda-majority e bounds de B.7/B.8; exemplo fora da condição mostra não necessidade. | e=m−k; condição suficiente, não necessária. Uma reversão privada a favor de unanimidade deve estar fora dessa região estrita. |
| C16 | P:1022–1047, 1154–1204, 2956–3044 | Proposição prop:agenda-incidence, tabela trabalhada e E.9–E.10. | A reversão é condicional/assessment-specific, não existência universal; a tabela usa (m,β,ℓ,h,p)=(4,.9,.1,.9,.95), fora de βh<e/m. |
| C17 | P:1206–1266, 3046–3184, 3270–3347 | Proposição prop:agenda-decomposition, E.11–E.14, F.2–F.4. | Cada diferença exige a existência de todas as fontes e datas compatíveis; β entra uma vez no baseline. I_U≤0 na célula de prior alto existente. Multiplicidade não é resolvida por uma seleção implícita. |
| C18 | P:2108–2176,2516–2581,2745–2798,3186–3269 | Ação de S_m nas coalizões, votos e registros, kernels uniformes completos e fatoração das leis realizadas. | Assinatura não serializa todo off-path; seleção não é payoff escalar e não há colagem de coordenadas ou sorteio comum entre instituições. |
| C19 | P:45–83, 154–212, 1297–1375, 1397–1403 | Literatura atribuída, tabela das práticas de Steinberg e limites da aplicação. | A pie permanece fixa, independente de H e sem spillovers; não se acrescenta uma tarefa produtiva/execução individual para H receber x_H. 'Identifying benchmark' é isolamento analítico. |
| C20 | P:1342–1375, 1377–1403, 3311–3347 | Seção de limites, conclusão e F.3–F.4. | Não há resultado universal de preferência de H pela unanimidade; não resolve ratificação, implementação institucional, reputação, roll-call, mais tipos ou formação endógena das regras. |

## 6. Profile-specific contract

### players

```json
{
  "text": "H e W={1,…,m}, m≥3. Só os fracos são reconhecidos no baseline, com probabilidade uniforme e sorteios independentes com reposição; o primeiro proponente permanece elegível em R2. H é o único informado; todos os fracos são simétricos e têm opção externa zero.",
  "locators": [
    "P:303–316",
    "P:344–353"
  ],
  "agenda": "A extensão acrescenta H como proponente obrigatório em A, antes de uma continuação baseline completa, sem alterar quem propõe dentro de R1/R2."
}
```

### timing

```json
{
  "baseline": [
    "Natureza determina o∈{ℓ,h}, conhecido só por H.",
    "R1: reconhece-se um fraco; ele propõe (C,x), publicamente; convidados votam simultaneamente, proponente conta sim e o vetor efetivo é publicado.",
    "Todos os convidados consentem: implementa automaticamente as parcelas. Qualquer recusa leva a R2, sem saída imediata irreversível de H.",
    "R2: novo reconhecimento uniforme; proposta e ballot; aprovação implementa; rejeição encerra em desacordo. R2 não usa desconto interno; valor de R2 em R1 é βC_2."
  ],
  "agenda": [
    "H deve fazer a proposta em A; sua proposta conta como sim.",
    "Os convidados fracos votam simultaneamente; todos precisam consentir. A regra g determina a cardinalidade mínima de C.",
    "Aprovação implementa em A; rejeição entra em R1 do mesmo regime, com β aplicado uma única vez ao valor nativo baseline."
  ],
  "locators": [
    "P:313–426",
    "P:1411–1430",
    "P:905–939",
    "P:2301–2335"
  ]
}
```

### information

```json
{
  "parameters": "0<ℓ<h<1; p=Pr(o=h)∈[0,1]. A versão pública revela o; a privada não. Em toda comparação econômica usam-se os mesmos parâmetros.",
  "baseline": "Propostas desinformadas (inclusive C) e votos fracos não sinalizam H. H fora de C não vota e todo ballot preserva o posterior. Com H convidado, Bayes usa sua lei prescrita quando o denominador é positivo; no denominador zero há valor livre local por ballot/voto dentro do suporte inicial. Distintos C podem gerar ballots distintos.",
  "agenda": "As leis Borel de proposta de H podem sinalizar seu tipo. O limite local de Bayes deve existir em todo ponto do suporte, inclusive pontos de massa zero. Fora do suporte há um único μ_off=b_ρ(p)=pρ/(1−p+pρ), com ρ∈[0,∞]; b_0=0 e b_∞=1 no interior. Endpoints preservam μ_off=p e tornam ρ irrelevante. O sinal é o par (C,x) e as bolas relativas de Bayes ficam na mesma componente da união disjunta Y_g.",
  "locators": [
    "P:303–311",
    "P:428–450",
    "P:1432–1450",
    "P:2337–2378",
    "P:2615–2630"
  ],
  "scope": "A disciplina global do sinal/proposta na agenda não substitui a liberdade local dos ballots no baseline."
}
```

### actions_strategies

```json
{
  "proposal_space": "Y_g^i=união disjunta de {C}×X_C, com i∈C, |C|≥ν_g, x≥0, soma≤1, zero fora de C. ν_M=k+1, ν_U=m+1. No estágio A i=H. Coalizões acima da quota e convidados zero continuam factíveis.",
  "quota": "A quota determina coalizões admissíveis, não o número suficiente de sim dentro de uma coalizão maior: todos os convidados consentem. Não convite é marcador ⊥ e não N.",
  "payoffs": "Aprovação automática paga parcelas aos membros; fracos fora recebem zero; H membro recebe x_H, H fora recebe o com x_H=0. Recusa R1 continua; recusa R2 paga H=o e fracos zero.",
  "off_path": "Todos os pares e vetores de voto factíveis têm transição; recusa de H convidado impede aprovação integralmente. Desvios de proposta são avaliados antes da votação.",
  "locators": [
    "P:317–363",
    "P:373–388",
    "P:452–459"
  ]
}
```

### equilibrium_concept

```json
{
  "baseline": "Correspondência de PBE na classe de votos puros, com os fracos comparando valores esperados como se fossem pivotais. T^Y impõe sim na indiferença em valor esperado; H maximiza por tipo e também vota sim na indiferença. Empates do proponente entre propostas com o mesmo payoff esperado seguem a minimização do payoff esperado de H. O conceito não é equilíbrio sequencial.",
  "agenda": "Assessments completos com propostas Borel em Y_g, ballots convidados puros, posterior único fora de suporte e seleção completa pública, Borel, anônima/Markov por regra/etapa/posterior. Os representantes M usam parceiros uniformes e λ comum. Não se transporta Markov ao baseline inteiro.",
  "linkage": "Cada assessment fixa conjuntamente estratégias, crenças, seletores, reconhecimento, ballots, payoffs e leis de outcomes. Os dois tipos permanecem vinculados, inclusive o tipo de probabilidade zero. Comparações institucionais emparelham assessments completos na mesma economia/especificação de crença antes da projeção.",
  "locators": [
    "P:428–481",
    "P:1432–1456",
    "P:1685–1727",
    "P:2301–2378",
    "P:2380–2580",
    "P:2610–2630",
    "P:2799–2836"
  ],
  "clarifying_sources": [
    "/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/v2/game_contract.md",
    "/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/v2/r1_interface.md",
    "/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/derivations/v2/agenda_transport.md"
  ]
}
```

### assumptions

```json
{
  "economic": [
    "Pie distributiva fixa em 1, sem externalidades, bens públicos ou ganhos de produtividade de H.",
    "o está fora da pie e independe de acordos dos fracos; H pode recebê-lo quando uma maioria aprova um acordo que o exclui.",
    "β∈(0,1), duas rodadas no baseline, dois tipos, m≥3 e fracos simétricos desinformados.",
    "Não há benefício intrínseco do acordo para H, ratificação, reputação ou escolha endógena da regra."
  ],
  "domain": [
    "Comparação apenas onde cada objeto fonte existe na classe mantida.",
    "Endpoints são jogos com suporte degenerado, não limites laterais.",
    "Misturas residuais têm peso comum e observáveis preservam o vínculo; envelopes marginais não são produtos atingíveis.",
    "Cada lei endpoint atribui probabilidade um ao argmax; não se exige que seu suporte topológico inteiro seja maximizador. Em U a seleção endpoint é o assessment de prior de entrada degenerado contratado, sem apagar suporte original de outros históricos."
  ],
  "locators": [
    "P:303–363",
    "P:464–481",
    "P:1342–1375",
    "P:1411–1430",
    "P:2179–2218",
    "P:3311–3347"
  ],
  "coalition_rule": "Quota de tamanho, consentimento de todos os convidados, zero fora de C e implementação automática são a arquitetura expressamente adotada em 19/09. O tipo de H e sua opção externa permanecem fora da pie."
}
```

### propositions

```json
{
  "reading_status": "Os itens abaixo registram enunciados e a cadeia alegada pelo texto. Não certificam demonstrações, generalidade dos desvios ou equivalência com outro protocolo.",
  "baseline": [
    {
      "name": "Public-type benchmark",
      "label": "prop:public",
      "statement": "R1: v_U^B(o)=βo; v_M^B(o)=βo se o≤1/m e o se o>1/m. R2: maioria exclui H e entrega a pie ao proponente; unanimidade oferece o a H e retém 1−o.",
      "locators": [
        "P:515–534",
        "P:1460–1492"
      ]
    },
    {
      "name": "Private terminal games",
      "label": "prop:terminal",
      "statement": "R2/M coincide com o terminal público; em R2/U a oferta é ℓ para p≤p* e h acima, p*=(h−ℓ)/(1−ℓ), com empate na oferta baixa.",
      "locators": [
        "P:572–582",
        "P:1494–1509"
      ]
    },
    {
      "name": "Private majority correspondence",
      "label": "prop:majority",
      "statement": "Π_E=1−kw; Π_S=(1−p)[1−(k−1)w−βℓ]+pw; Π_P=1−(k−1)w−βh; w=β/m. p_SE=β(1/m−ℓ)/[β(1/m−ℓ)+1−β(k+1)/m]; p_SP=β(h−ℓ)/[1−βℓ−βk/m].",
      "cells": [
        "h<1/m: S até p_SP inclusive, depois P.",
        "ℓ<1/m<h: S até p_SE inclusive, depois E.",
        "1/m<ℓ<h: E em todos os p.",
        "ℓ=1/m<h: S só em p=0, E em p>0.",
        "ℓ<h=1/m: S até p_SE inclusive; acima, E se (1−p)ℓ+ph<βh, P se >, mistura comum E/P se =."
      ],
      "locators": [
        "P:588–646",
        "P:1511–1567"
      ]
    },
    {
      "name": "Private unanimity correspondence",
      "label": "prop:unanimity",
      "statement": "p=0: V_U^B=(βℓ,βh); 0<p≤p*: vazio; p>p*: V_U^B=(βh,βh). A primeira coordenada em p=0 é o tipo com massa positiva; a segunda permanece como componente fora do suporte.",
      "locators": [
        "P:669–685",
        "P:1569–1645"
      ]
    },
    {
      "name": "Private institutional payoff contrast",
      "label": "prop:privatecompare",
      "statement": "Para p>p*, ΔV^B=(β(h−ℓ),0) sob S, (0,0) sob P e (βh−ℓ,−(1−β)h) sob E; residual vincula esses vetores. p=0 tem células próprias; faixa sem U fica vazia.",
      "locators": [
        "P:739–754",
        "P:1647–1659"
      ]
    },
    {
      "name": "Informational rents by voting rule",
      "label": "prop:rents",
      "statement": "IR=V−v. IR_U^B é zero em p=0, vazio na faixa sem U e (β(h−ℓ),0) para p>p*. IR_M^B é dado pelas células abaixo; os rótulos público/privado são conjuntos.",
      "majority_cells": [
        {
          "public": "ambos incluídos",
          "private": "S",
          "IR": "(0,0)"
        },
        {
          "public": "ambos incluídos",
          "private": "P",
          "IR": "(β(h−ℓ),0)"
        },
        {
          "public": "ambos incluídos",
          "private": "E",
          "IR": "((1−β)ℓ,(1−β)h)"
        },
        {
          "public": "baixo incluído, alto excluído",
          "private": "S",
          "IR": "(0,−(1−β)h)"
        },
        {
          "public": "baixo incluído, alto excluído",
          "private": "E",
          "IR": "((1−β)ℓ,0)"
        },
        {
          "public": "ambos excluídos",
          "private": "E",
          "IR": "(0,0)"
        }
      ],
      "locators": [
        "P:808–835",
        "P:1661–1683"
      ]
    },
    {
      "name": "Institutional informational-rent contrast",
      "label": "prop:deltari",
      "statement": "ΔIR^B=IR_U^B−IR_M^B; para p>p*, as seis células correspondentes são (β(h−ℓ),0), (0,0), (βh−ℓ,−(1−β)h), (β(h−ℓ),(1−β)h), (βh−ℓ,0), (β(h−ℓ),0). Em p=0 a célula pública assimétrica retém um componente alto fora do suporte; a faixa sem U permanece vazia.",
      "locators": [
        "P:849–870",
        "P:1661–1683",
        "P:2179–2218"
      ]
    }
  ],
  "agenda": [
    {
      "name": "Public agenda payoffs and institutional gap",
      "label": "prop:agenda-public",
      "statement": "v_U^A=1−β+β²o; v_M^A=1−kβ(1−βo)/m se o≤1/m, e max{v_M^safe,βo} se o>1/m; v_M^safe=1−kβ/m, e=m−k. Atraso majoritário acima de o_M*=1/β−k/m; mistura vinculada na igualdade. Gap baixo negativo; acima de 1/m, sinal de βo−e/m.",
      "locators": [
        "P:949–996",
        "P:2888–2954"
      ]
    },
    {
      "name": "Private-majority agenda correspondence",
      "label": "B.7/E.2",
      "statement": "r_χ=βc_χ, d_χ,o=βh_χ,o, a_pass=1−kr_χ. Inclui formas puras e leis Borel/atomless com incentivos pointwise, continuidade literal e uma crença comum fora do suporte. V_M^A(o)≥max{v_M^safe,β²o}; para toda economia/prior há algum ρ com PBE, sem quantificar existência em todo ρ fixado.",
      "locators": [
        "P:1685–1924",
        "P:2380–2580"
      ]
    },
    {
      "name": "Private-unanimity agenda correspondence",
      "label": "B.8/E.3",
      "statement": "z_L=1−β+β²ℓ, z_H=1−β+β²h, d=β²h. Continuação só em {0}∪(p*,1]. Em interior existente o vetor é (z,z). A família baixa exige z_L≥d e μ_off=0; a alta exige p>p*. Com μ_off=0 e p>p*, z∈[max{z_L,d},z_H]; com μ_off>p*, payoff (z_H,z_H); μ_off∈(0,p*] é vazio. Em p=0: (z_L,max{z_L,d}); em p=1: (z_H,z_H). As leis e condições pointwise não se reduzem a essa imagem de payoffs.",
      "locators": [
        "P:1925–2107",
        "P:2582–2747"
      ]
    },
    {
      "name": "Selection-free majority advantage",
      "label": "prop:agenda-majority",
      "statement": "Mesma especificação e ambas as correspondências não vazias: βh<e/m implica ΔV^A(o)≤−β(e/m−βh)<0 para ambos os tipos e ex ante. Igualdade dá ranking fraco; é condição suficiente, não necessária.",
      "locators": [
        "P:1130–1152",
        "P:2838–2886"
      ]
    },
    {
      "name": "Informational-rent incidence under unanimity",
      "label": "prop:agenda-incidence",
      "statement": "Em todo assessment U existente, IR_U^A(ℓ)≥0, IR_U^A(h)≤0 e alguma desigualdade estrita; os componentes fora do suporte continuam definidos. ΔV^A=Δv^A+ΔIR^A é identidade no assessment emparelhado.",
      "locators": [
        "P:1154–1192",
        "P:2956–3044"
      ]
    },
    {
      "name": "Agenda-comparison decomposition",
      "label": "prop:agenda-decomposition",
      "statement": "T_g=D_g+I_g em cada comparação completa definida; D_g=v_g^A−βv_g^B, I_g=IR_g^A−βIR_g^B, T_g=V_g^A−βV_g^B. D_U=1−β; D_M≥0; T_U≥0 onde ambas as fontes existem. I_U≤0 na célula alta existente. Q_g=v_g^A−βV_g^B é composto.",
      "locators": [
        "P:1206–1266",
        "P:3046–3184",
        "P:3270–3347"
      ]
    },
    {
      "name": "Exact and economic layers",
      "label": "B.9/F.1",
      "statement": "Sig_ex é invariante completo para a órbita diagonal das duas leis realizadas por tipo; Sum_econ é o pushforward registro a registro no quociente dos nomes fracos. Mantêm-se especificação de crenças e vínculo dos tipos; a assinatura não serializa toda a função off-path do binder.",
      "locators": [
        "P:2108–2176",
        "P:2788–2836",
        "P:3188–3268"
      ]
    },
    {
      "name": "High-price proposal at support points",
      "label": "B.8 support lemma / US-1",
      "statement": "Sob prior interior e μ_off>p*, dado valor comum e demais restrições do assessment, V=z_H e σ_ℓ=σ_h=δ_xh; inclui o caso x^h no suporte com massa zero. Cobre as duas aplicações B.8 sem fornecer nova hipótese.",
      "locators": [
        "P:1982–2021",
        "P:2030–2034",
        "P:2081–2083"
      ]
    }
  ]
}
```

### mechanisms

```json
{
  "extensive_margin": "Maioria permite não convidar o único informado e contratar fracos desinformados, deixando a H seu fórum alternativo; unanimidade exige C=N. Informação privada e poder de sinalização não são atribuídos aos fracos.",
  "rent_incidence": "Pooling unânime na célula alta paga a ambos o limiar do alto; o baixo retém diferença em relação ao próprio benchmark. Screening, exclusão e a mudança de data de o sob maioria alteram o contrafactual da renda.",
  "agenda": "H proponente tem incentivos de sinalização e recebe valor da proposta inicial. O efeito total dessa etapa separa ganho público e interação com informação; não se confunde com o gap U−M no jogo com agenda. C é parte observável do sinal em A; projetar para x antes de Bayes mudaria o jogo.",
  "economic_interpretation": "Acesso a mercado é motivação estilizada para benefícios distribuíveis e fóruns alternativos. A pie não depende de presença ou execução de H; a opção externa não é destruída pela aprovação de um acordo entre fracos.",
  "locators": [
    "P:94–129",
    "P:244–275",
    "P:837–847",
    "P:1154–1204",
    "P:1206–1266",
    "P:1270–1340"
  ]
}
```

### comparative_statics

```json
{
  "variables": [
    "Regra U versus M na mesma economia e protocolo de cada jogo.",
    "Informação privada versus pública do mesmo tipo dentro de cada regra.",
    "Inclusão pública em o=1/m e mudanças S/P/E em p_SP ou p_SE.",
    "Prior versus p* e suporte degenerado; a célula vazia interrompe o ranking.",
    "Agenda A versus baseline B em datas compatíveis, com D/T/I e separação de Q.",
    "Na agenda, o versus o_M* e e/(mβ); a condição uniforme βh<e/m e seus limites."
  ],
  "orientation": "Todos os gaps institucionais são U−M. IR é privado−público. Ex ante aplica-se (1−p) à coordenada baixa e p à alta do mesmo vetor vinculado.",
  "restrictions": "Os sinais robustos são sobre a correspondência inteira no domínio indicado. Demais sinais pertencem a avaliações/células específicas. Envelopes resumem conjuntos e não os completam artificialmente.",
  "locators": [
    "P:504–904",
    "P:949–1266",
    "P:2179–2218",
    "P:2799–2886",
    "P:3311–3347"
  ]
}
```

Condições de escopo:

- Objeto: preview de manuscrito de coalizão 9356d86a… com bibliografia 658af186…, fora dos arquivos canônicos.
- Economia distributiva fixa, H único informado, m≥3 fracos simétricos e desinformados, dois tipos, duas rodadas baseline e β∈(0,1). P:303–342,1342–1354.
- Maioria e unanimidade diferem pela quota no mesmo protocolo do jogo considerado. A agenda acrescenta uma etapa obrigatória e sua disciplina própria de proposta/continuação; não se confunde com baseline. P:344–353,483–496,2301–2378.
- A opção externa de H é portátil em relação a acordos entre fracos e está fora da pie; não há efeito produtivo de sua participação nem execução individual para receber a parcela. P:303–363,1270–1295.
- O protocolo adotado usa quota mínima de coalizão e consentimento de todos os convidados, com pagamentos zero fora de C e implementação automática. P:316–394,1411–1430.
- Os resultados de inexistência são na classe de PBE com votos puros e restrições declaradas. Não se estendem a votos mistos ou a outros refinamentos. P:428–481,1342–1368.
- Só se comparam correspondências não vazias. Datas e desconto devem ser compatíveis; endpoints preservam suporte e não são limites. P:2179–2218,3311–3347.
- Vetores por tipo, leis realizadas, seletores e resultados devem vir dos mesmos assessments. Rendas usam o benchmark público correspondente. P:452–459,782–903,2799–2836.
- A condição βh<e/m da agenda é suficiente e uniforme; fora dela a classificação depende da correspondência. A tabela de reversão é um exemplo admissível, não um ranking global. P:1022–1152.
- A discussão da OMC não é evidência causal, calibração ou explicação identificada da escolha institucional. P:1317–1340,1370–1375.
- O prior de entrada do assessment endpoint selecionado em A não redefine o suporte inicial de qualquer baseline que atinge posterior zero. A restrição QI-01 das notas é preservada; P1432–1449,2301–2378,2698–2718.

## 7. What the document does not claim

- Não afirma que toda exclusão privada de H zera sua renda informacional; a tabela de prop:rents diferencia o benchmark público e o timing de o. P:819–835.
- Não afirma que unanimidade favoreça universalmente H ou ambos os tipos. P:756–780,872–892,949–1000,1130–1152.
- Não afirma reversão favorável à unanimidade dentro da região estrita βh<e/m em que a proposição garante o contrário. P:1130–1192.
- Não atribui informação privada, capacidade de sinalização própria ou poder assimétrico de proposta aos fracos. P:303–316,1432–1450.
- Não torna H produtivo para a pie, nem exige uma atividade individual posterior para receber x_H. P:317–342,1270–1295. A interpretação de acesso a mercado não acrescenta essa primitiva.
- Não elimina a opção externa de H porque os fracos aprovaram um acordo sem ele. P:355–363,381–385,1411–1430.
- Não trata voto não de H como saída irreversível imediata quando há rodada de continuação. P:344–426,1411–1430.
- Não demonstra inexistência com votos mistos; permite mistura de propostas e distingue 'ballots puros' de estratégias de proposta puras. P:428–481,669–685,2380–2580.
- Não atribui payoff zero, sinal, ranking ou interpolação a uma célula vazia. P:2216–2218.
- Não ressuscita tipos de probabilidade zero no posterior; seus componentes contrafactuais podem permanecer no vetor de payoffs. P:1432–1450,2179–2188,2698–2747.
- Não permite recombinar coordenadas de seleções diferentes nem interpretar envelopes como retângulos atingíveis. P:2190–2214,2799–2836.
- Não afirma existência de agenda majoritária em todo ρ fixado; o enunciado é existência para algum ρ em cada economia/prior. P:2504–2514.
- Não reduz o assessment completo a uma assinatura de leis realizadas nem impõe um sorteio comum entre regras. P:2788–2836,3188–3268.
- Não apresenta T, I e Q como efeitos estimados em dados. T exige os dois jogos; Q muda agenda e informação simultaneamente. P:1206–1266,3311–3347.
- Não identifica a causa da criação da OMC, a preferência histórica pela regra ou o tipo de um ator histórico. Não nega influência informal de agenda. P:206–212,1317–1340,1370–1375.
- Não resolve mais de dois tipos, mais de duas rodadas baseline, m=2, β=1, roll-call, benefícios intrínsecos, regras/agenda endógenas, ratificação, implementação institucional ou reputação. P:1342–1375.
- Não resolve a arquitetura histórica por cancelamento: ela foi substituída no candidato pelo contrato de coalizão autorizado. P:316–394,1411–1430.
- Não afirma equivalência literal global da maioria antiga e nova, nem identifica sinais rejeitados que compartilham x mas diferem em C. P:2320–2361,2457–2581.
- Não apaga coalizões maiores factíveis ou exige igualdade de payoff em todos os pontos de suporte. P:1898–1923,2489–2491,2701–2718.
- Não permite ler a família baixa de E.3 como totalmente sem átomos: exige massa positiva do baixo em x^ℓ. P:2634–2648.
- Este contrato não certifica provas, patches, referência externa, fatos históricos, cálculos de figuras, renderização ou submissão. Ciência e visualização permanecem etapas separadas.

## 8. Terminology

| Preferir | Evitar | Motivo |
|---|---|---|
| hegemon (H) | ['leader', 'proposer como sinônimo de H no baseline'] | H concentra a opção externa privada, mas só propõe na etapa A. Poder, hegemonia e liderança não são sinônimos. |
| low/high disagreement-payoff type (ℓ/h) | ['Estado fraco como sinônimo de H baixo', 'tipo moral ou produtivo'] | Os tipos diferem no valor privado da melhor alternativa, não no status de jogador ou produtividade. |
| weak states, uninformed and symmetric | ['respondedores informados', 'sinalização dos fracos'] | A margem central depende de todos os substitutos de H serem desinformados. |
| outside option o, outside the fixed pie | ['parcela da pie', 'benefício do acordo dos fracos'] | A opção externa independe dos acordos dos demais e pode ser recebida sob exclusão. |
| allocation x_j versus payoff | ['alocação como sinônimo de payoff total'] | Payoff pode ser opção externa ou continuação descontada; a soma das alocações é que respeita a pie. |
| pivotal approval / substitute vote | ['veto produtivo', 'contribuição tecnológica de H'] | O canal é institucional: possibilidade de aprovar sem o único informado. |
| informational rent IR=V−v | ['todo excedente', 'todo benefício de unanimidade', 'renda de agenda'] | Renda de informação usa o benchmark público da mesma regra e tipo. |
| institutional gap Δ=U−M | ['gap sem orientação', 'inversão silenciosa M−U'] | A orientação é uniforme nas comparações do manuscrito. |
| screening S / pooling P / exclusion E | ['classes disponíveis livremente em qualquer célula'] | Os rótulos identificam formas selecionadas pela correspondência; seus regimes e empates são específicos. |
| pure ballot strategies | ['equilíbrio inteiramente puro', 'inexistência geral de equilíbrio'] | Propostas podem ser mistas/Borel; a inexistência é restrita à classe mantida de ballots. |
| complete equilibrium assessment | ['vetor de payoff independente', 'escolha de continuação escalar'] | Estratégias, crenças, seletores e outcomes precisam permanecer conjuntamente admissíveis. |
| exact signature of realized laws | ['código de toda estratégia off-path'] | Exact refere-se à órbita diagonal do par de leis realizadas, com binder completo subjacente. |
| D, I, T e Q como comparações entre jogos | ['efeitos causais estimados'] | D/T/I respeitam datas e fontes; Q é um contraste composto. |
| theoretical WTO application / analytical benchmark | ['identificação causal da criação da OMC', 'ausência histórica de poder informal'] | O texto declara a limitação empírica e separa agenda formal da influência de facto. |

## 9. Reconciliation log

**R01** — A introdução P119–122 agora explicita que exclusão zera a renda de ambos quando ambos também seriam excluídos publicamente. As células de renda mantêm as diferenças de timing. A compressão original foi substituída, sem ampliar o resultado. Fontes: P:117–129; P:277–299; P:808–835.

**R02** — A introdução P132–139 separa a região suficiente robusta e a implicação contábil de uma reversão. O exemplo usa h=.9 e μ_off=0 nas duas regras, fora de βh<e/m. A frase antiga foi substituída. Fontes: P:131–139; P:949–996; P:1022–1047; P:1130–1152.

**R03** — A leitura do argumento desenvolvido restringe a afirmação à agenda formal exclusiva. P:55–68 relata influência por textos, pacotes e alternativas; P:206–212 declara expressamente que o benchmark não pretende negar agenda no caso histórico. P:1317–1323 repete a separação. O contrato não certifica a afirmação histórica nem atribui ao autor ausência de influência de facto; a omissão de qualificação da frase inicial fica registrada. Fontes: P:45–83; P:206–212; P:1317–1323.

**R04** — Não. O candidato fixa a pie, coloca o fora dela e não dá papel produtivo à participação de H. P:1317–1340 e 1342–1347 delimitam a aplicação como teórica, sem identificar criação da OMC ou tipos históricos. 'Identifying' em P:1400 designa isolamento analítico do canal. Acesso a mercado é interpretação estilizada das alocações/alternativas, sem estimar efeitos comerciais nem exigir atividade individual para receber x_H. Fontes: P:303–342; P:1270–1295; P:1317–1340; P:1370–1375; P:1397–1403.

**R05** — O referente consistente é o baseline que determina a continuação/preço em A. Na etapa corrente de agenda, H compra votos fracos. E.6 deriva o preço dos fracos da continuação majoritária que inclui ou exclui H. A frase de interpretação da figura não muda o protocolo corrente. Fontes: P:905–939; P:1015–1018; P:2888–2901.

**R06** — O assessment retém a história completa, mas o seletor admissível da agenda tem dependência mais estreita: regra, estágio de entrada e posterior. P:1693–1706, 2380–2400 e 2385–2399 usam a seleção Markov χ(μ)/κ(μ); as fontes de derivação explicitam a restrição. As crenças internas do baseline continuam com valores livres locais de A.2; não se transporta o Markov da agenda ao baseline. Fontes: P:1432–1450; P:1687–1706; P:2329–2378; P:2380–2400; P:2610–2624; model_redesign/agenda_extension_A_M_msb_results.md:90–103; model_redesign/agenda_extension_A_U_msb_contract.md:39–47,128–133.

**R07** — Não. A regra pointwise alcança todo suporte, inclusive pontos de massa zero, e exige existência do limite local de Bayes; fora dele há um único μ_off. E/S/P/EP designam os representantes literais uniformes e sua mistura comum admissível. As fontes de derivação citadas pelo leitor tornam explícitos o domínio e os kernels compactados pela notação. Isso esclarece o objeto afirmado, sem verificar que as caracterizações o provem. Fontes: P:1685–1727; P:2380–2400; P:2464–2514; P:2615–2630; model_redesign/agenda_extension_A_M_msb_results.md:106–144,183–267,305–323.

**R08** — Sig_ex codifica a órbita diagonal conjunta das leis realizadas por tipo. O binder completo continua subjacente para definir admissibilidade e comparações, mas sua função off-path inteira não é o objeto reconstruído a partir da assinatura. Sum_econ elimina nomes por registro; avaliações completas são emparelhadas antes da projeção. Fontes: P:2108–2176; P:2788–2795; P:2799–2836; P:3206–3227.

**R09** — O objeto agora é o preview com (C,x), autorizado pela decisão de 19/09. A regra original de cancelamento foi retirada dos trechos do modelo e A.1. O original permanece snapshot e contrato históricos; não é reescrito por retroação. Fontes: P:355–363; P:373–388; /Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/author_decision.md.

**R10** — Não. A seleção de agenda importa os assessments completos de prior de entrada degenerado; dentro de um mesmo baseline as crenças livres continuam no suporte inicial. É a hipótese/limitação QI-01 mantida. Fontes: P:1432–1449; P:2301–2378; P:2698–2718; Leitura independente: QI-01 preservada.

**R11** — US-1 fecha a classificação B.8/E.3 e suas imagens; o teto global decorre separadamente de factibilidade e pagamentos. C15 usa somente esse teto e a garantia M. Fontes: P:1987–1990; P:2095–2101; P:2838–2886.

**R12** — Não. A condição expressa é probabilidade um no conjunto de melhores respostas; pontos de massa zero só precisam obedecer ausência de desvio lucrativo. Fontes: P:1827–1829; P:2489–2491; P:2701–2718.

Nenhuma ambiguidade interpretativa material não resolvida.

## 10. Gate verdict

**PASS de fidelidade**, sem aprovação científica/visual e sem integração canônica.

- 37 unidades mantêm cobertura de P1–3348; References inicia P3349. Trechos intactos ligados às leituras originais por diff verificado.
- Macro leu os 34 hunks completos do diff e consumidores; leitor independente leu o preview por blocos e registrou os 20 claims atualizados.
- C03 substituído pelo protocolo aprovado; C11/C13/C18 usam Y_g; C14 inclui o novo lema e probabilidade um. R01/R02 agora constam explicitamente da introdução.
- Escopo de endpoints, margem extensiva do único informado, outside option após exclusão, aplicação estilizada e ausência de causalidade empírica mantidos.
- Revalidação substantive_scoped em revalidation.md; hashes Rmd/bib, snapshot, manifesto e leitura independentes conferidos. PASS somente de fidelidade.
