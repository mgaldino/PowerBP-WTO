# Carta Editorial — Framework Edmans (Contribution, Execution, Exposition)

**Manuscrito**: "Informational Power Through Pivotality: How Consensus Can Benefit a Hegemon" — `formal_model_v6.Rmd`, versão essential-input migrada (Goal 5).
**Arquivo revisado**: `/private/tmp/PowerBayesianPersuasion-goal5-migration/formal_model_v6.Rmd`, branch `codex/essential-input-goal5-migration-matrix`, commit `b5fdefb` ("Reflow introduction after puzzle correction"), worktree limpo no momento da revisão. PDF compilado de 31 páginas (21 de corpo, 8 de apêndice, 2 de referências).
**Data**: 2026-08-22
**Protocolo**: três avaliadores independentes (Contribution, Execution, Exposition) lançados em paralelo, instruídos a ler apenas o manuscrito, o PDF e as figuras — sem acesso a CLAUDE.md, AGENTS.md ou `quality_reports/` — e sem permissão de edição. A carta editorial foi redigida após o recebimento dos três pareceres, que seguem integrais ao final deste arquivo.
**Referência anterior**: Edmans round 2 sobre v5 (2026-04-27): 7.5/10, R&R minor.

## Decisão: Reject-and-Resubmit

## Scores consolidados

| Dimensão     | Score   | Rating |
|--------------|---------|--------|
| Contribution | 4/10    | Fraca — mecanismo previsível, catálogo de células sem teorema-síntese, região central vazia |
| Execution    | 5.5/10  | Média — correção alta (zero erros nas provas refeitas), desenho da análise questionável |
| Exposition   | 5/10    | Adequada na frase, descuidada no documento (marcadores editoriais, floats órfãos, figuras com rótulos internos) |
| **Global**   | **4.5/10** | **Reject-and-Resubmit** (ponderação pela hierarquia Edmans: a contribuição é o gargalo) |

## Síntese editorial

**A principal força do manuscrito é que as provas estão certas.** O avaliador de Execution refez todos os cortes (`ν*`, `ν_SE`, `ν_SP`), os vetores de payoff de todas as proposições, as tabelas de `RI` e `ΔRI`, o exemplo numérico do Apêndice C.3 e as quatro figuras, e não encontrou erro em nenhum deles. As células vazias são tratadas com consistência lógica em abstract, introdução, proposições, tabelas, discussão e conclusão — nenhum trecho atribui payoff ou sinal à célula sem equilíbrio. O aparato é enxuto (uma nota de rodapé em 21 páginas, 16 referências), o que no framework Edmans vale muito.

**A principal fraqueza é que o paper vende o que os resultados não entregam e não vende o que eles entregam.** Três achados convergentes, cada um apontado por pelo menos dois avaliadores que não se comunicaram:

1. **Quem ganha com o consenso é o tipo baixo, nunca o tipo alto.** Em todas as células com equilíbrio, o tipo alto recebe `βo_1` sob unanimidade e `βo_1` ou `o_1` sob maioria; seu contraste privado é `0` ou `−a_1`, nunca positivo. Título ("How Consensus Can Benefit a Hegemon"), abstract e conclusão falam do "hegemon"; o resultado sustenta "o consenso protege um hegemon cuja força é superestimada". Essa tese — a mais interessante do paper, segundo Contribution e Execution — aparece no texto apenas como observação de passagem (l. 97–98: "A hegemon whose strength is overestimated receives the concession needed by the high type even when its own type is low").

2. **O componente "de poder" da decomposição é fracamente negativo.** Execution calculou `V_U^{pub} − V_M^{pub}`: `(0,0)` na região II, `(0,−a_1)` em IX, `(−a_0,−a_1)` em XX. Com o proponente fraco detendo todo o poder de barganha, a unanimidade compra `H` exatamente ao valor de continuação `βo`, enquanto a exclusão sob maioria paga `o` sem desconto. A introdução afirma que a unanimidade "adds veto power" e a discussão fala em "familiar veto-power component"; no modelo, o veto vale zero ou custa ao hegemon. Parte do que aparece como renda informacional positiva (o `a_1` do tipo alto em IX-screening) é apenas a anulação desse componente negativo — Execution mostra que o payoff do tipo alto é `βo_1` sob ambas as regras nessa célula, de modo que "also benefits the high type" (introdução) é overclaim.

3. **A célula vazia está exatamente onde a narrativa vive, e as janelas positivas são finas.** A célula `0 < ν ≤ ν*` tem largura média de cerca de metade do espaço de crenças; é o cenário de força contestada que a Figura de "hegemonic decline" pretende ilustrar — e a figura é majoritariamente hachurada. As janelas em que o mecanismo-título opera (maioria faz screening, unanimidade faz pooling) são estreitas: Contribution e Execution derivaram independentemente que na região II a janela `(ν*, ν_SP]` é não vazia se e somente se `β > m/(m+q−1)` (2/3 para `m=4`), condição ausente do texto; na região IX, no próprio exemplo do paper, a janela mede `0.2935 − 0.2778 = 0.016`. O ganho positivo robusto do tipo baixo é `k = βo_1 − o_0` sob exclusão, que depende inteiramente da convenção de datação de `o_θ` (exclusão paga `o_θ` agora; inclusão precifica `βo_θ`) — os dois avaliadores de substância chamam isso de efeito de calendário, não de instituição.

**Onde os pareceres se reforçam.** Os três apontaram os marcadores `[AUTHOR: P1]` e `[AUTHOR: P2]` impressos na página 5 do PDF e os rótulos internos nas figuras ("N7", "estimand", "if used", "No prior-weighted or ex ante image is displayed"). Os três identificaram a célula de inexistência como o ponto em que o leitor vai suspeitar que o desempate `T^Y` está fabricando o resultado (B.4, item 2, diz literalmente que `(N,N)` cai porque "`T^Y` requires yes at equality"). Contribution e Execution recomendam estender a estratégias mistas de voto; Execution e Exposition apontam que o segmento de medida zero em `o_1 = 1/m` ocupa espaço desproporcional (oito aparições no corpo, segundo Exposition).

**Onde divergem.** Exposition elogia a bibliografia enxuta; Contribution pede cerca de doze referências adicionais. Não é contradição: as ausências apontadas são pontuais e previsíveis para um editor de IO ou de teoria formal — Maggi & Morelli (2006), Tsebelis (2002); veto bargaining informado (Matthews 1989; Cameron 2000; Kim, Kim & Van Weelden 2025); barganha dinâmica com informação unilateral (Sobel & Takahashi 1983; Fudenberg, Levine & Tirole 1985). O que se pede é cobertura do vizinho imediato, não volume.

## Hierarquia Edmans aplicada

A contribuição é o gargalo, mas neste paper ela está acoplada à execução de um modo incomum. A decisão de desenho da análise que mantém a célula vazia (estratégias puras de voto + `T^Y` + as-if-pivotal) é a mesma que faz a contribuição ler como "catálogo de células condicionais": sem a célula intermediária, não há trajetória de crenças, não há atraso com screening sob unanimidade, e o resultado positivo fica confinado a janelas finas ou a um efeito de datação. Execution observa que a inexistência é off-path — decorre de uma proposta de desvio sem resposta pura, não de colapso no caminho — e que, dentro da célula, o proponente preferiria atraso com screening em R2 para `ν` baixo e pooling imediato para `ν` mais alto (no exemplo: `ν = 0.10` dá residual de pooling `0.138 < 0.182` do atraso; `ν = 0.20` dá `0.199 > 0.162`). Esse é, nas palavras do avaliador, "precisamente o resultado de screening through pivotality que o título promete".

Os problemas de exposição são corrigíveis em uma passagem e não bloqueariam sozinhos; mas os marcadores editoriais e os rótulos internos sinalizam a um editor que o manuscrito não está em estado de submissão, e isso contamina a leitura de todo o resto.

**Sobre a comparação com o 7.5/10 do v5.** A queda de três pontos não é regressão de qualidade. As afirmações do v5 repousavam em provas que a auditoria game-teórica de 2026-08-21 mostrou usarem convenções mutuamente incompatíveis; aquele score estava parcialmente sustentado por resultados que não se sustentavam. A versão nova é mais correta, e a correção expôs o quão estreito é o resultado positivo. Este é o estado honesto do paper.

## Prioridades para revisão

1. **Decidir o destino da célula `0 < ν ≤ ν*`.** É a decisão estratégica central. Contribution e Execution recomendam estender o conceito a estratégias mistas de voto — relaxando `T^Y` nas histórias em que a indiferença sustenta a mistura — e caracterizar o equilíbrio (equilíbrio de skimming padrão: o tipo baixo randomiza; a crença após rejeição cai em `ν*`; o proponente de R2 fica indiferente). **Nota do editor**: isso reabre a decisão de 2026-08-21, que fixou estratégias puras de voto e classificou mistas como fora de escopo. Registro a convergência dos três leitores frios: o custo dessa escolha é o ponto de venda central do paper. Dois caminhos coerentes: (a) derivar a célula mista como nó separado, sob conceito próprio, sem reabrir N1–N3; (b) manter o escopo e realocar a contribuição para fora da célula vazia — o que implica abandonar a narrativa de declínio hegemônico (Figura de decline) e reformular título e abstract. O que não é coerente é manter a célula vazia e manter a narrativa que vive nela. **Reparo imediato e barato, independente da decisão**: reescrever B.4 com `y ∈ (ℓ, h)` em vez de `y = ℓ`. Verifiquei a afirmação de Execution: com `y` estritamente entre `ℓ` e `h` e `x_j = A`, os quatro perfis falham estritamente — `(Y,Y)`: o tipo alto obtém `y < h` e desvia para não; `(N,N)`: o tipo baixo obtém `y > ℓ` desviando para sim; `(Y,N)`: o não do tipo baixo leva a posterior 1 e continuação `h > y`; `(N,Y)`: o não do tipo alto leva a posterior 0, R2 oferece `o_0`, o tipo alto rejeita e obtém `h > y`. A inexistência deixa de depender de `T^Y`, e a objeção mais previsível de um referee desaparece.

2. **Reescrever a tese em torno do tipo baixo e enunciar o sinal do componente de poder.** Título, abstract, introdução e conclusão devem dizer que o tipo alto nunca ganha em payoff com o consenso e que o ganho é do tipo baixo via pooling. Uma proposição-síntese: para `ν > ν*`, o contraste do tipo baixo é positivo se a maioria faz screening, ou se exclui e `βo_1 > o_0`; é zero quando ambas as regras fazem pooling. Reportar `V_U^{pub} − V_M^{pub} ≤ 0` por região no corpo e explicar por que, com proponente fraco, o veto não tem valor. Substituir "also benefits the high type" por uma frase sobre `ΔRI` que não sugira ganho de payoff.

3. **Caracterizar as janelas e tratar a convenção de datação de `o_θ`.** Enunciar `β > m/(m+q−1)` (região II) e `ν_SE > ν*` (região IX), com uma figura da largura das janelas em função de `(β, m)`. Discutir — ou separar em dois parâmetros — os dois papéis de `o_θ`: "a OI funciona sem `H`" (exclusão, pago em R1 sem desconto) e "não há OI" (desacordo terminal, descontado). **Nota do editor**: isso toca o contrato Gate 0 (`o_θ` como payoff de desacordo terminal) pelo ramo de exclusão `y + o_θ` na data de R1. Não é erro de prova; é uma identificação de modelagem que governa os sinais de `k` e `a_θ`. Pela regra do projeto, escala como finding.

4. **Complemento ex ante e lado dos Estados fracos.** A recusa de qualquer imagem ex ante elimina o objeto relevante para a pergunta de desenho institucional da Seção 1. No exemplo trabalhado, a unanimidade domina a exclusão sob maioria, ex ante para `H`, se e somente se `ν < k/(o_1 − o_0) = 0.86` — corte limpo e interpretável (verificado: `βo_1 > (1−ν)o_0 + νo_1 ⟺ ν < (βo_1 − o_0)/(o_1 − o_0)`). Adicionar bem-estar esperado dos fracos por regra, probabilidade de fracasso (`ν` sob screening terminal) e atraso esperado. Isso responde, ao menos parcialmente, à pergunta tripla que a introdução formula e retira na frase seguinte.

5. **Limpeza e desduplicação, em uma passagem.** Remover `[AUTHOR: P1]` (l. 215) e `[AUTHOR: P2]` (l. 188); retirar "N7", "estimand", "if used" e "No prior-weighted or ex ante image is displayed" das figuras e legendas; referenciar no texto toda figura e tabela que sobreviver (hoje, um de onze floats é citado); cortar Tabela 3 (duplica Prop. 1), Tabela 2, Figura 1 (fluxograma), Figura 4B e Figura 5 (ou escrever o parágrafo de declínio que ela ilustraria); mover Tabela 5 para o apêndice; reduzir o segmento `o_1 = 1/m` a uma frase no corpo com o resto em C.2; abstract com no máximo 150 palavras e um número (`0.10 → 0.315`; `0.225` contra `0.01`; 28%); definir screening/pooling/exclusão antes de usar na introdução; corrigir a descrição de Miller, Montero & Vanberg (2018) (heterogeneous *disagreement values*, não *voting rules*); substituir "receive full priority" por diferenciação concreta de Piazolo & Vanberg (2025) e Glynia, Thum & Xefteris (2026); resolver colisões de notação (`k`, `h`, `W`); definir "structural consistency" ou removê-la; justificar `m ≥ 3` ou relaxar (as contas funcionam para `m = 2`); remover `ȳ`, que nunca morde.

## Recomendação estratégica ao autor

Na forma atual, o paper seria rejeitado em APSR, AJPS, JOP ou IO: a contribuição lê como mecanismo de livro-texto mais catálogo de células condicionais, com a região central vazia. Não é o caso de "submeter a outro journal com mudanças menores" — o problema é a contribuição, e a seção 5.1 de Edmans é clara em que revisão extensiva sem mudar a contribuição não ajuda.

Há, porém, um caminho identificável, e ele não é longo em termos formais: (i) a célula mista, ou uma reformulação que não dependa dela; (ii) a tese do hegemon superestimado com o sinal do componente de poder enunciado; (iii) as condições de janela e a discussão da convenção de datação; (iv) o complemento ex ante e o lado dos fracos. Com (i)–(iv), a contribuição sobe para 6–7 e o paper vira candidato real em IO ou BJPS; com uma ilustração com dados (OPEP 1985–86 ou o impasse de Doha, como ilustração e não como teste), em AJPS ou JOP. Os reparos de exposição são trabalho de uma passagem e não devem esperar a decisão formal.

O maior ativo do autor neste momento é que as provas estão certas. A auditoria não encontrou nenhum erro depois de refazer tudo. O trabalho agora é decidir o que o paper afirma, não consertar o que ele prova.

---

## Parecer completo — Contribution

# Parecer de Contribution (Framework Edmans)

## Score: 4/10

Justificativa do score: a pergunta é bem posta e a execução é honesta, mas o mecanismo é previsível a partir da literatura, os resultados formam um catálogo de células condicionais sem um teorema-síntese, a região substantivamente central fica sem resultado por uma escolha de conceito de solução que a literatura resolve com ferramentas padrão, a bibliografia é rala para qualquer das audiências-alvo, e as implicações observáveis não discriminam o que o abstract promete discriminar. Rejeição na forma atual, com caminho identificável para 6–7.

## Resumo da contribuição alegada

O manuscrito compara barganha legislativa em duas rodadas — um hegemon `H` com payoff de desacordo privado `o_θ ∈ {o_0, o_1}` e `m ≥ 3` Estados fracos que são os únicos proponentes — sob maioria e unanimidade, mantendo primitivas idênticas. A alegação central é que a unanimidade converte o hegemon em "essential input": remove o substituto (comprar mais um voto fraco desinformado) que, sob maioria, limita o preço de `H`, e por isso pode transformar pivotalidade em poder informacional. A contribuição formal é uma decomposição "poder versus informação": renda informacional `RI_g = V^priv − V^pub` por regra e o contraste institucional `ΔRI = RI_U − RI_M`, reportado tipo a tipo e célula a célula, incluindo uma célula (`0 < ν ≤ ν*`) em que a unanimidade não tem PBE em estratégias puras de voto e o contraste é declarado vazio.

## Avaliação por dimensão

### Novidade [Fraca]

1. **O mecanismo é previsível.** "Substituto limita o preço; insumo essencial obriga a precificar o limiar privado" é a lógica padrão de que concorrência entre fornecedores reduz rendas informacionais (leilões com mais licitantes, procurement com fornecedor alternativo, barganha com outside options). Lida a frase do abstract — "proposers can buy uninformed weak-state votes instead of the hegemon's, and this substitute caps its price" — um leitor treinado antecipa o resultado qualitativo antes de abrir o modelo.

2. **As peças formais são de livro-texto.** O corte `ν* = (o_1 − o_0)/(1 − o_0)` da Proposição 2 é o corte de screening de uma oferta take-it-or-leave-it a um vendedor com reserva privada binária. A renda `(d, 0)`, `d = β(o_1 − o_0)`, da Proposição 6 é a renda de pooling usual: em qualquer pooling o tipo baixo recebe o preço do tipo alto. A correspondência de maioria (Proposição 3) é Baron–Ferejohn com um membro precificado como veto e substitutos a `β/m`; as três classes (exclusão, screening, pooling) e seus cortes decorrem de comparações lineares. O benchmark público (Proposição 1) é imediato.

3. **O elemento não óbvio é fenômeno conhecido, e o manuscrito opta por não resolvê-lo.** A inexistência de PBE puro em `0 < ν ≤ ν*` é a propriedade de skimming da barganha dinâmica com informação unilateral: em dois períodos, o tipo baixo precisa randomizar entre aceitar e rejeitar para que a crença após rejeição deixe o proponente de R2 indiferente (Sobel & Takahashi 1983; Fudenberg, Levine & Tirole 1985). O manuscrito declara estratégias mistas fora de escopo (Remark "Pure-strategy scope") e converte um problema resolvível em célula vazia. Pior: pela prova B.4, item 2, o perfil `(N,N)` só falha porque "T^Y requires yes at equality" — o vazio é produto da convenção de desempate escolhida, e não uma descoberta sobre consenso. Um referee de teoria dirá "resolva com mistas; é o equilíbrio padrão".

4. **O posicionamento frente ao trabalho mais próximo não permite avaliar diferenciação.** Piazolo (2025) e Glynia (2026) recebem uma oração cada, seguida de "Their mechanisms and results receive full priority as the nearest points of comparison" (Rmd l. 119–123) — frase que cede prioridade sem dizer em que o resultado presente difere. O próprio texto chama a contribuição de "narrower" (l. 125). Não há engajamento com veto bargaining informado (Matthews 1989; Cameron 2000; Kim, Kim & Van Weelden 2025) nem com unanimidade versus maioria sob assimetria informacional em outros protocolos (Bardhi & Guo 2018; Chan, Lizzeri, Suen & Yariv 2018).

5. **Atualização bayesiana do leitor: modesta, e sobretudo negativa.** O que se aprende é que a afirmação simples "consenso beneficia o hegemon via informação" não se sustenta de forma limpa: o ganho é específico de tipo, de região e de faixa de crenças. Isso pode ser contribuição se apresentado como resultado disciplinador; título e abstract, contudo, vendem a versão positiva ("How Consensus Can Benefit a Hegemon").

6. **O núcleo genuinamente interessante está no texto e não é explorado.** A renda informacional do consenso acrua ao tipo *baixo*: "A hegemon whose strength is overestimated receives the concession needed by the high type even when its own type is low" (l. 97–98). O tipo alto nada ganha informacionalmente — seu componente em `ΔRI` é 0 ou `±a_1`, e `a_1` é um "timing wedge" de convenção de datação. A Figura 3, painel B, mostra isso literalmente: todas as barras do tipo alto são zero. A leitura "consenso protege um hegemon sobreestimado" é a ideia com maior potencial de novidade substantiva e aparece apenas como observação de passagem.

### Importância [Fraca]

1. **Lacuna entre motivação e entrega.** A Introdução formula a pergunta de desenho em três partes (por que aceitar sem controle de agenda; por que regra mais estrita que maioria; por que consenso) e em seguida a retira: "That broader question motivates the paper, but the model holds the institutional rule fixed" (l. 71–72); Limits: não analisa "endogenous rule choice, agenda power for H". O que se entrega é o payoff de `H` sob cada regra fixa, por tipo e por região, com uma região sem resultado. Um formulador de política que quisesse saber se um hegemon deve aceitar consenso não encontra resposta.

2. **A região que importa para a história substantiva fica vazia.** Força contestada — `0 < ν ≤ ν*` — é exatamente o cenário de "hegemonic decline" que a Figura 4 pretende ilustrar; a figura é majoritariamente hachurada. O texto está certo ao dizer que o vazio "does not justify filling the gap by interpolation" (l. 767–768), mas isso significa que o modelo é silencioso onde a narrativa vive.

3. **O resultado positivo é estreito onde existe.** Pela minha leitura das Proposições 3 e 7 (cálculo meu, a verificar pelo autor): na região II (hegemon barato, `o_1 ≤ 1/m`) a vantagem do tipo baixo existe apenas na faixa `(ν*, ν_SP]`, e `ν_SP > ν*` requer `β > m/(m+q−1)` (aproximadamente 2/3) — com jogadores mais impacientes a vantagem desaparece em toda a região II, porque maioria já paga o preço de pooling; na região IX, a faixa `(ν*, ν_SE]` do exemplo numérico é `(0.2778, 0.2935]`, e acima de `ν_SE` o sinal é o de `k = βo_1 − o_0`. O resultado robusto está onde `H` é caro relativo a um voto fraco (`o_1 > 1/m`) com crenças altas. Isso seria enunciável em uma frase — "consenso paga ao hegemon sobreestimado quando ele é caro de incluir" — e o manuscrito não a enuncia.

4. **Relevância prática declaradamente nula.** "This is a mechanism illustration, not an estimate of OPEC bargaining" (l. 786–787); para a OMC, "The model suggests looking for institutional concessions that arise because partners cannot confidently price the major state's willingness to accept" (l. 790–792) — sugestão que não distingue poder de veto de poder informacional, distinção que o abstract promete ("when is that advantage informational rather than merely due to veto power?").

5. **Teste do survey.** Um survey de barganha legislativa com informação privada poderia citar o paper como aplicação a organizações internacionais; um survey de desenho institucional internacional teria dificuldade de resumir o resultado em uma frase, porque ele é uma tabela de seis células por tipo (Tabela de `ΔRI`, l. 677–714). Não é "just another determinant", mas também não é um teorema com sinal.

6. **Recusa de avaliação ex ante.** "Figure \ref{fig:privatecompare} maps these exact classes without averaging types" (l. 578–579); legenda da Figura 1: "No prior-weighted or ex ante image is displayed". Isso elimina o objeto relevante para escolha de regra sob véu de ignorância. A avaliação interina por tipo é legítima, mas então a afirmação correta é "o tipo baixo se beneficia", e o título diz "a hegemon".

### Adequação ao escopo [Questionável]

1. **Bibliografia com 15 entradas.** RI: Koremenos et al. (2001), Steinberg (2002), Stone (2011) e duas referências sobre OPEP. Formal: Baron & Ferejohn, Winter, Feddersen & Pesendorfer, Eraslan & Evdokimov, Miller et al., Piazolo, Glynia; três clássicos de conceito de solução. Para IO ou BJPS faltam Maggi & Morelli (2006, regras de votação autoimpostas em IOs — o paper formal mais próximo na área), Gruber (2000, go-it-alone power — precisamente outside options hegemônicas e regras), Voeten (2001), Blake & Payton (2015), Posner & Sykes (2014), Gould (2022). Para APSR/AJPS/JOP faltam veto bargaining informado (Matthews 1989; Cameron 2000; Cameron & McCarty 2004; Kim, Kim & Van Weelden 2025), barganha dinâmica com informação unilateral (Sobel & Takahashi 1983; Fudenberg, Levine & Tirole 1985; survey de Ausubel, Cramton & Deneckere 2002) e unanimidade/maioria com informação (Austen-Smith & Banks 1996; Bardhi & Guo 2018; Chan et al. 2018).

2. **Audiência.** A pergunta é de interesse geral; a entrega lê-se como nota técnica para teóricos de barganha: três "disciplinas declaradas" de conceito de solução, preservação de suporte em endpoints, catálogo de células, segmentos residuais com peso `λ` e advertências sobre "Cartesian product of marginal envelopes" (C.2). A parte de RI é um parágrafo sobre OPEP e um sobre OMC. O manuscrito precisa escolher audiência: IO (mais RI, ilustração com dados) ou teoria formal geral (solução completa, engajamento com teoria de barganha).

### Generalizabilidade [Limitada]

1. **Não há problema de caso único** — o modelo é abstrato e `N`-genérico. A limitação está na fragilidade da estrutura dos resultados a convenções de modelagem:
   - A inexistência depende de estratégias puras e de `T^Y` (B.4, item 2). Com a convenção oposta de desempate, ou com mistas, a célula se preenche e a comparação muda.
   - O padrão de sinal do tipo alto (`±a_1`) e o sinal de `k` vêm da convenção de datação de `o_θ`: exclusão em R1 paga `o_θ` sem desconto, inclusão precifica `βo_θ`. O texto chama isso de "timing wedge" (l. 554–557); é uma escolha sobre quando o payoff de desacordo se realiza, e convenções alternativas (fluxo por período; realização em R1) alteram o padrão. Hoje, parte do que o paper reporta como efeito institucional é efeito de calendário.
   - Dois tipos, duas rodadas, `b_θ = 0`, pie fixo, fracos com desacordo zero, só fracos propõem, `m ≥ 3`, `β < 1`. A seção Limits lista isso com honestidade.

2. **Validade externa para IOs reais.** Com pie fixo e `b_θ = 0`, a participação de `H` não acrescenta nada ao excedente; por isso a maioria exclui `H` sempre que `o > 1/m` — um hegemon forte é simplesmente ignorado. Em OMC ou OPEP, a inclusão do hegemon costuma ser valiosa (acesso a mercado, capacidade ociosa). A defesa da normalização é uma frase ("This normalization isolates informational concessions and pivotality from any intrinsic benefit", l. 189–190) e não bastará para um leitor de RI. Nada no modelo torna `H` "hegemon" além de `o_θ > 0` e informação privada.

3. O mecanismo geral (substitutos limitam rendas informacionais) é o componente mais robusto — e o menos novo.

### Trade-offs [Parcial]

1. **Do lado de `H`, sim.** O paper mostra que a unanimidade pode prejudicar o tipo alto (`−a_1`) e que o efeito sobre o tipo baixo pode ser negativo (`k < 0`). Isso é mérito e evita o one-sidedness típico.

2. **Ausente: o lado dos Estados fracos e a eficiência institucional.** As tabelas reportam payoffs do proponente fraco, mas não há proposição comparando bem-estar dos fracos, atraso esperado ou probabilidade de fracasso entre regras. No jogo terminal sob unanimidade com screening, o acordo fracassa com probabilidade `ν` (Proposição 2) — perda de peso morto; sob maioria o pie é sempre exaurido. No jogo completo, o custo de gridlock do consenso residiria precisamente na célula não resolvida. O trade-off central da literatura de rational design que o paper cita não é quantificado.

3. **Ausente: o trade-off de escolha de regra.** Com regra fixa, não se pesa o ganho informacional de `H` contra o que ele cede (controle de agenda, motivação da §1).

4. **Ausente: avaliação ex ante** (ver Importância, item 6).

### Hipóteses [Presentes mas vagas]

1. **Mecanismo claro e não kitchen-sink**: insumo essencial versus substituto; renda de pooling ao tipo baixo. Proposições direcionais e condicionais, derivadas de teoria — bem.

2. **Sem tradução em estática comparativa testável.** Exemplos que o modelo já contém e não enuncia: a renda do tipo baixo `d = β(o_1 − o_0)` cresce com paciência e com a dispersão dos tipos; `ν*` decresce em `o_0` e cresce em `o_1`, logo pooling (e renda) ocorre para crenças mais baixas quando o tipo fraco é muito fraco; a vantagem da unanimidade se concentra onde `o_1 > 1/m` (hegemon caro relativo a um voto fraco, ou `m` grande); na região II ela desaparece para `β` baixo (cálculo meu, a verificar).

3. **As implicações observáveis não discriminam veto de informação.** A decomposição `RI` responde à pergunta do abstract dentro do modelo, mas nenhuma contraparte observável de `RI` é oferecida: o que se observaria, em OPEP ou OMC, que distinguiria uma concessão por pivotalidade pública de uma concessão por incerteza sobre a reserva? Sem isso, a §5.2 ("Observable implications") é uma lista de lugares onde olhar, não de predições.

## Veredicto geral sobre contribution

O manuscrito formula uma pergunta boa — separar o componente informacional do componente de veto no benefício que um hegemon extrai do consenso — e responde com honestidade e disciplina formal. A contribuição, porém, não atinge o patamar de um top journal nesta forma. O mecanismo é previsível; as peças formais são padrão; o resultado é um catálogo de células condicionais sem teorema-síntese; a região substantivamente central (força contestada) fica vazia por uma escolha de conceito de solução que a literatura de barganha dinâmica resolve com estratégias mistas; o ganho informacional, onde existe, acrua ao tipo baixo e é estreito em boa parte do espaço de parâmetros; a literatura de RI e de barganha dinâmica está ausente; e não há trade-off de bem-estar dos fracos, de gridlock ou de escolha de regra, embora a Introdução motive precisamente a escolha de regra. A ideia com maior potencial — consenso como proteção a um hegemon sobreestimado — está no texto, mas não organiza o paper. Recomendação: rejeitar na forma atual. Uma versão que resolva a célula intermediária, lidere com a mensagem do tipo baixo, adicione o lado dos fracos e engaje a literatura relevante teria chance real em IO ou BJPS e, com estática comparativa e ilustração empírica, em AJPS/JOP.

## Sugestões construtivas

1. **Resolver a célula `0 < ν ≤ ν*` com estratégias mistas de voto** (equilíbrio de skimming padrão: o tipo baixo randomiza entre sim e não; a crença após rejeição cai em `ν*`; o proponente de R2 fica indiferente). Isso transforma "contraste vazio" em "screening parcial com atraso e renda", define a comparação em todo `[0,1]` e elimina a dependência de `T^Y`. A Figura 4 deixa de ser majoritariamente hachurada e passa a mostrar a trajetória de declínio que o texto descreve.

2. **Reorganizar em torno do resultado substantivo**: a renda informacional do consenso vai ao tipo baixo; o tipo alto nada ganha informacionalmente. Título, abstract e uma proposição-síntese devem dizer isso, com a condição exata: para `ν > ν*`, `ΔRI` do tipo baixo é positivo se a maioria faz screening, ou se a maioria exclui e `βo_1 > o_0`; é zero quando ambas as regras fazem pooling. Uma frase, uma condição, um sinal.

3. **Adicionar o lado dos Estados fracos e a eficiência**: bem-estar esperado dos fracos por regra, probabilidade de fracasso e atraso esperado. Em seguida, um resultado de escolha de regra, ainda que simples (comparação sob véu de ignorância ou restrição de participação de `H`), para responder ao menos parcialmente à pergunta da §1.

4. **Tratar a convenção de datação de `o_θ`**: mostrar que o padrão de sinal do tipo alto sobrevive a convenções alternativas, ou explicitar que `±a_1` é artefato de datação e retirá-lo da narrativa institucional.

5. **Ampliar e aprofundar a literatura**: Maggi & Morelli (2006), Gruber (2000), Voeten (2001), Blake & Payton (2015); Matthews (1989), Cameron (2000), Kim, Kim & Van Weelden (2025); Sobel & Takahashi (1983), Fudenberg, Levine & Tirole (1985); Bardhi & Guo (2018), Chan et al. (2018). Substituir a frase que "cede prioridade" a Piazolo e Glynia por um parágrafo que diga o que cada um mostra e o que este paper mostra que eles não mostram.

6. **Enunciar estática comparativa com contraparte institucional**: concessões ao hegemon sob consenso crescem com a incerteza sobre sua reserva, com a paciência e com o custo relativo de comprar outros membros (`m · o_1 > 1`); queda da força percebida abaixo de `ν*` gera episódios de screening e atraso. Mapear a OPEP 1985–86 ou o impasse de Doha como ilustração, não como teste, e dizer o que se observaria se o mecanismo fosse apenas veto.

7. **Antecipar e defender a normalização do pie fixo com `b_θ = 0`.** A crítica mais previsível de um leitor de RI será que excluir o hegemon é, na prática, inviável porque sua participação cria excedente. Se a normalização for o caso conservador para o mecanismo (qualquer valor de inclusão só reforça a posição de `H`), isso deve ser argumentado em um parágrafo, não em uma frase.

8. **Escolher audiência e calibrar**: IO (mais RI, ilustração com dados) ou formal geral (solução completa, engajamento com teoria de barganha). A forma atual não serve bem a nenhuma das duas.

Nota à parte, fora da dimensão de contribuição: o texto contém marcadores de autor não resolvidos ("[AUTHOR: P1]", "[AUTHOR: P2]", §3, Rmd l. 188 e 215) — sinal de que o manuscrito não está em estado de submissão.

---

## Parecer completo — Execution

# Parecer de Execution (Framework Edmans)

## Score: 5,5/10

## Tipo de paper: Teórico

## Resumo da estratégia

O manuscrito constrói um jogo de barganha em duas rodadas com um hegemon `H`, privadamente informado sobre um payoff de desacordo binário `o_θ`, e `m ≥ 3` Estados fracos que monopolizam a proposta. Compara maioria e unanimidade sob primitivas idênticas e decompõe o payoff de `H` em um componente de "poder" (benchmark de informação completa) e um componente "informacional" (jogo privado menos benchmark), reportando vetores tipo-contingentes e uma diferença de diferenças `ΔRI = RI_U − RI_M`. O conceito de solução é PBE em estratégias puras de voto com cinco disciplinas declaradas: no-signaling de jogadores desinformados, preservação de suporte nos endpoints, voto as-if-pivotal, desempate `T^Y` (indiferença vota sim) e desempate de proposta que minimiza o payoff esperado de `H`.

## Princípio "Dados vs. Evidência"

Para um paper teórico, os "dados" são as proposições e as "evidências" são as proposições que sustentam univocamente a conclusão anunciada. Refiz as contas-chave (detalhes na verificação (a) abaixo) e as proposições estão corretas como enunciadas; o exemplo numérico do Apêndice C.3 e as quatro figuras reproduzem exatamente as fórmulas. Os dados, portanto, são sólidos.

Eles ainda não são evidência para o título e o abstract, por três razões que admitem leituras concorrentes:

1. **Quem ganha com consenso é o tipo baixo.** Em todas as células com equilíbrio, o tipo alto recebe `βo_1` sob unanimidade e `βo_1` ou `o_1` sob maioria; o contraste privado para o tipo alto é `0` ou `−a_1`, nunca positivo. O hegemon genuinamente forte nunca ganha com unanimidade neste modelo, e perde `a_1 = (1−β)o_1` sempre que maioria o excluiria. A leitura que os resultados sustentam com mais força é "consenso beneficia um hegemon cuja força é superestimada", o que é uma tese diferente da do título.

2. **O componente de "poder" é não positivo.** Calculei `V_U^{pub} − V_M^{pub}`: `(0,0)` na região II, `(0,−a_1)` em IX, `(−a_0,−a_1)` em XX. Sob informação completa, o veto de unanimidade vale zero ou custa ao hegemon, porque o proponente compra `H` exatamente ao valor de continuação `βo` enquanto a exclusão paga `o` sem desconto. O paper chama isso de "familiar veto-power component" sem dizer em lugar algum que o sinal é fracamente negativo. Parte do que aparece como "renda informacional positiva" (o `a_1` do tipo alto em IX-screening) é apenas a anulação desse componente negativo.

3. **A comparação é indefinida numa célula larga.** A célula vazia tem largura `ν* = (o_1−o_0)/(1−o_0)`; sob sorteio uniforme de `(o_0,o_1)` sua largura média é cerca de metade do espaço de crenças. A janela em que o mecanismo-título opera (maioria faz screening e unanimidade faz pooling, `ν* < ν ≤ ν_SE` ou `ν_SP`) é, em contrapartida, fina ou vazia (ver verificação (c)).

Veredicto sobre o princípio: os resultados são dados corretos com múltiplas interpretações; a interpretação escolhida para título, abstract e conclusão é uma das menos sustentadas.

## Avaliação por dimensão

### T.1 Distância premissas–conclusões — Rating: Médio

O resultado não é assumido, mas a distância entre premissas e conclusões é curta, e a parte mais longa do caminho é negativa.

- A renda informacional sob unanimidade, `d = β(o_1−o_0)`, é o resultado estático de oferta take-it-or-leave-it com dois tipos (o proponente faz pooling quando o tipo alto é suficientemente provável), transportado para R1 por `β`. Isso é livro-texto. A estrutura de duas rodadas acrescenta (i) a inexistência no intervalo `(0,ν*]` e (ii) a cunha temporal `a_θ = (1−β)o_θ`, que governa todos os sinais em `k` e `a_1`.
- A cunha temporal nasce de uma escolha de modelagem que o texto trata como inofensiva: quando maioria aprova sem `H`, o hegemon recebe `y + o_θ` imediatamente (Tabela 1 e A.1), ao passo que o mesmo `o_θ` é o payoff de desacordo terminal descontado. O parâmetro acumula dois papéis conceitualmente distintos: "a OI funciona sem `H`" e "a OI não existe". No caso da OMC esses dois estados do mundo têm valores muito diferentes para os EUA. Toda a classificação II/IX/XX e os sinais de `ΔRI` sob exclusão dependem dessa identificação.
- O resultado genuinamente derivado e não trivial é que, para qualquer `ν` interior, nenhum perfil separador é sequencialmente racional sob unanimidade: o tipo baixo sempre imita o "não" do tipo alto porque a posterior após "não" vai a 1 e a continuação de R2 o recompensa com `h`. Isso é um resultado sobre a impossibilidade de screening sob unanimidade, e é mais interessante do que a narrativa de "poder informacional através de pivotalidade" sugere. Sob maioria, o screening existe porque R2 exclui `H` independentemente da crença, de modo que rejeitar não é recompensado. Esse é o mecanismo real e ele aparece apenas parcialmente no texto ("the resulting rent is frequently attached to pooling rather than to separation").

### T.2 Parcimônia — Rating: Médio-baixo

As primitivas são parcimoniosas (`m, β, o_0, o_1, ν`). A saída não é. A correspondência de maioria tem cinco casos, a de unanimidade três células, há três regiões públicas, e o objeto final `ΔRI` é uma segunda diferença apresentada em cerca de vinte células (Tabela 5). Desse total, uma fração desproporcional do espaço formal (Proposição 3 caso 5, Proposição 4 item 4, Proposições 5 e 6, as linhas de "segmento" da Tabela 5, todo o Apêndice C.2) trata do conjunto de medida zero `o_1 = 1/m` conjugado com o único `ν̂ = k/(o_1−o_0)` em que exclusão e pooling empatam também no payoff de `H`. O endpoint `ν = 0`, que é literalmente o jogo de informação completa, recebe item próprio em quatro proposições e uma seção do apêndice (C.1). O leitor gasta mais energia com a aritmética de conjuntos atingíveis do que com o mecanismo.

A construção `ΔRI` tem um custo adicional de parcimônia: ela pode ser positiva quando a comparação de payoffs relevante é zero (tipo alto em IX-screening) e pode ser `(d,0)` em XX-exclusão quando a comparação privada direta é `(k,−a_1)`. O leitor precisa carregar três objetos (contraste privado, contraste público, diferença) para entender um sinal.

### T.3 Caminho causal — Rating: Médio

O caminho é regra de votação → existência de substituto para o voto de `H` → teto de preço → renda. As variáveis endógenas no caminho (propostas, votos, crenças) são derivadas, não fixadas. A regra, o reconhecimento uniforme entre fracos e o pie fixo são exógenos e declarados como tais. Não identifico variável endógena indevidamente congelada.

Dois pontos do caminho merecem atenção:
- O "teto" só morde em IX/XX. Na região II, maioria também paga `βo_1` no pooling e o contraste é zero; a frase do abstract "this substitute caps its price" descreve a metade do espaço paramétrico em que o hegemon é caro.
- O passo "unanimidade → `H` essencial → proposta responde ao limiar privado" é verdadeiro apenas no sentido de pooling: em equilíbrio a proposta responde ao limiar alto qualquer que seja o tipo real, e abaixo de `ν*` não há equilíbrio. O limiar privado nunca "molda" a proposta via separação.

### Verificação (a): as provas sustentam cada proposição como enunciada? — Rating: Alto (correção), com reparos pontuais

Refiz as seguintes contas e todas fecham:

- **Proposição 1.** Inclusão custa `(q−2)w + βo`, exclusão `(q−1)w`; inclusão fracamente mais barata sse `o ≤ 1/m`. Residual do proponente sob unanimidade em R1 excede o atraso em exatamente `1−β`. Tabela 3 consistente.
- **Proposição 2.** `(1−ν)(1−o_0) ≥ 1−o_1` sse `ν ≤ ν*`. Correto.
- **Proposição 3.** `P − E = β(1/m − o_1)`; `S(ν) − E = (1−ν)β(1/m−o_0) − ν(1−βq/m)`, que dá `ν_SE`; `S − P ≥ 0` sse `ν ≤ β(o_1−o_0)/(1−βo_0−β(q−1)/m) = ν_SP`. Verifiquei que `ν_SP < 1` sempre que `o_1 < 1/m` (equivale a `βq/m < 1`). Os cinco casos e os desempates nos cortes seguem.
- **Proposição 4.** `W(η)` é contínua em `ν*` (`(1−ν*)A = B`), logo `W ∈ [B,A]` e `x_j = A` força sim. Residuais `1−ℓ−(m−1)A = A+1−β` e `1−h−(m−1)B = B+1−β` corretos. A enumeração dos quatro perfis após `s†` está correta: `(Y,Y)` falha porque o tipo alto obtém `h > ℓ` rejeitando; `(Y,N)` falha porque o "não" revela tipo alto e o tipo baixo imita para obter `h`; `(N,Y)` falha porque o tipo alto imita o "não" do tipo baixo. A completude das respostas nos domínios de existência (ν = 0 e ν > ν*) está correta, incluindo o papel da posterior off-path `η_Y` para sustentar `(N,N)` quando `u ≥ B`.
- **Proposições 5 e 6 e Tabela 5.** Todas as células conferem por subtração componente a componente, incluindo XX-exclusão (`k + a_0 = d`) e o segmento residual (`d − a_0 = k`, logo `{λ(k,−a_1)}`). Envelopes de C.2 corretos.
- **Exemplo C.3.** `q = 3`, `ν* = 0,2778`, `ν_SE = 0,135/0,46 = 0,2935`, `A = 0,2025`, `B = 0,14625`, `V_M^{pub} = (0,09; 0,35)`, `V_U^{pub} = (0,09; 0,315)`, `RI_M = (0,01; 0)`, `RI_U = (0,225; 0)`, `ΔRI = (0,215; 0) = (k, 0)`. Figura 2B: substitutos `0,45`, residual `0,55` sob maioria; pisos `0,43875`, concessão `0,315`, residual `0,24625` sob unanimidade. Tudo confere.
- **Figuras 1 a 4.** Regiões e fronteiras consistentes com as proposições (por exemplo, no corte `o_0 = 0,5·o_1` da Figura 1, `ν* = s/(8−s)` com `s = m·o_1`, cruzando `s = 1` em `1/7 ≈ 0,14`, como desenhado; `k = 0,4·o_1 > 0`, o que explica o azul em toda a região de exclusão para o tipo baixo).

Reparos pontuais nas provas, nenhum fatal:

1. **B.4, perfil `(N,N)` após `s†`.** A eliminação depende de `T^Y` porque o tipo baixo está exatamente indiferente (`ℓ` contra `ℓ`). Com `y ∈ (ℓ,h)` e `x_j = A` os quatro perfis falham estritamente, o que tornaria a inexistência independente do desempate. Recomendo reescrever a prova com esse `y`, já que o paper dá muito peso aos desempates.
2. **B.4, item 4.** A frase "while the prescribed comparison cannot support strict no against yes at the offer" é obscura; o que está acontecendo é que o tipo baixo também desvia por `T^Y`. Reescrever.
3. **"Structural consistency across histories that encode the same information"** (A.2) nunca é definida. Se ela restringe `η_Y` entre propostas diferentes, isso pode afetar a completude das respostas para `ν > ν*`; se não restringe nada, deve ser removida.
4. **`m ≥ 3`** é imposto sem justificativa ("excludes the three-player case"); as contas funcionam para `m = 2`.
5. **`ȳ`** é introduzido e nunca morde (`h < o_1 ≤ ȳ`). Primitiva ociosa.
6. Marcadores editoriais `[AUTHOR: P1]` e `[AUTHOR: P2]` permanecem no texto das seções 3.1 e 3.2.

### Verificação (b): o conceito de solução e os desempates fazem trabalho de resultado? — Rating: Médio

- **`T^Y`** é padrão e necessário para existência (sem ele o problema do proponente não tem máximo). Faz trabalho em todo o caminho de equilíbrio, como em qualquer modelo Baron-Ferejohn. Aceitável.
- **Desempate de proposta pessimista para `H`** só atua em conjuntos de medida zero (`o = 1/m`, `ν = ν*`, `ν_SE`, `ν_SP`, `ν̂`). Não distorce resultados, mas é uma seleção contra o hegemon que o paper não justifica substantivamente; deveria ser apresentada como escolha conservadora em relação à tese.
- **As-if-pivotal e `T^Y` conjuntamente** são o que torna a célula `(0,ν*]` vazia. Sem as duas disciplinas, o perfil fracamente dominado "todos votam não" responde a `s†` e o PBE existe. A inexistência é, portanto, relativa ao refinamento. O paper diz isso ("under the declared belief and pivotality conditions"), o que é correto, mas a Figura 4 e a Discussão tratam a célula como achado institucional.
- **Preservação de suporte** é o que faz `ν = 0` ter equilíbrio e `ν = 0,001` não ter. Razoável em si, mas o paper extrai muito de um ponto de medida zero que é apenas o jogo de informação completa.
- **Assimetria puro/misto.** O paper proíbe estratégias mistas de voto mas admite estratégia mista de proposta no segmento residual ("a probability over pure proposals in the proposer's strategy"). A restrição que gera a célula vazia é exatamente a que não se aplica ao proponente. Isso precisa ser defendido ou removido.
- **O ponto mais importante.** A inexistência em `(0,ν*]` é off-path: ela decorre de uma proposta de desvio (`y ∈ [ℓ,h)`, `u ≥ (1−ν)A`) que não tem resposta pura, e não de qualquer colapso no caminho. A proposta de pooling `y = h`, `x_j = (1−ν)A` passa sob `(Y,Y)` para todo `ν ≤ ν*`, e o atraso deliberado é implementável. No exemplo do paper, em `ν = 0,10` o residual de pooling é `0,138 < 0,182` do atraso; em `ν = 0,20`, `0,199 > 0,162`. Ou seja, dentro da célula vazia o proponente preferiria atrasar para fazer screening em R2 quando `ν` é baixo e fazer pooling imediato quando `ν` é mais alto. Esse é precisamente o resultado de "screening through pivotality" que o título promete, e a restrição a votos puros o torna invisível. Observo ainda que `T^Y` é incompatível com mistura na indiferença, de modo que a extensão a estratégias mistas exigirá relaxar `T^Y` nessas histórias; o Remark de escopo é honesto, mas a omissão não é neutra para a contribuição.

### Verificação (c): células vazias e conjuntos vazios são tratados com consistência lógica? — Rating: Alto (consistência), Baixo (cobertura)

Consistência: abstract, introdução, Proposições 4 a 6, Tabela 5, Apêndice C.2, Discussão e Conclusão marcam a célula como `∅` e nenhum trecho lhe atribui payoff, sinal ou interpolação. Figuras 1, 2 e 4 hachuram a região e as legendas são explícitas. A Remark de escopo puro é correta.

Cobertura, que é onde o problema está: as afirmações positivas do abstract vivem em janelas cuja não vacuidade o paper nunca caracteriza.

- **Região II** (hegemon barato): a janela `(ν*, ν_SP]` é não vazia sse `β > m/(m+q−1)` (derivação: `ν_SP > ν*` equivale a `β(1−o_0) > 1−βo_0−β(q−1)/m`, que se reduz a `β(m+q−1) > m`, independente de `o_0, o_1`). Para `m = 4` isso exige `β > 2/3`; para `m = 5`, `β > 5/7`. A condição é limpa e ausente do texto. Com `m = 4`, `β = 0,9`, a largura média da janela sob sorteio uniforme é cerca de `0,06`; com `m = 12`, cerca de `0,02`.
- **Região IX** (o caso do exemplo trabalhado): a janela `(ν*, ν_SE]` depende de todos os parâmetros. Em simulação com `m = 4`, `β = 0,9`, ela é não vazia em cerca de 13% dos sorteios, com largura média `0,008`; com `β ≤ 0,5` é sempre vazia; com `m = 12` praticamente desaparece. No próprio exemplo do paper ela mede `0,2935 − 0,2778 = 0,016`.
- A célula vazia tem largura `ν*`, em média cerca de `0,5`.

Em suma, a afirmação "positive for the low type when majority screens" é verdadeira num conjunto que, fora da região do hegemon barato com desconto alto, tem medida quase nula, e o abstract não informa isso. O ganho positivo robusto do tipo baixo é `k = βo_1 − o_0` sob exclusão, que depende inteiramente da cunha temporal discutida em T.1.

### Verificação (d): há afirmações no corpo que excedem os resultados? — Rating: Médio-baixo

1. **Introdução: "also benefits the high type when public majority would exclude it."** O payoff do tipo alto é `βo_1` sob ambas as regras nessa célula; `ΔRI_1 = a_1` é a anulação de um componente público negativo. "Benefits" é overclaim. O abstract usa "can also be positive for the high type", que é tecnicamente correto para `ΔRI` mas induz a mesma leitura.
2. **Título e conclusão: "Consensus can benefit a hegemon."** Apenas o tipo baixo ganha, e ganha porque é confundido com o forte. O hegemon forte é indiferente ou prejudicado em todas as células. O corpo diz isso em fragmentos ("Pooling under unanimity benefits the low type"); título, abstract e conclusão não.
3. **Introdução e conclusão: "unanimity makes its approval necessary and therefore adds veto power"; "the familiar veto-power component."** No modelo o componente é `≤ 0` em toda parte. Afirmar que o benchmark "revela" poder de veto sem dizer que o sinal é negativo é uma descrição que excede o resultado.
4. **Abstract: "its private threshold shapes the proposal."** Em equilíbrio a proposta é moldada pelo limiar alto independentemente do tipo; nenhuma separação ocorre.
5. **Discussão: "The empty middle-belief cell is equally important for scope. It records the failure of every pure voting pattern."** Correto literalmente, mas a Figura 4 ("Hegemonic decline across pooling, an empty pure-strategy cell, and the endpoint") apresenta um artefato de refinamento como trajetória substantiva. A Figura 4 é, além disso, redundante com o painel direito da Figura 2A.
6. **Figura 1**: a linha horizontal tracejada `m·o_1 = 1` não consta da legenda, que lista apenas `ν*`, `ν_SP`, `ν_SE`, e usa o mesmo traço longo de `ν_SE`.

## Veredicto geral sobre execution

A execução mecânica é competente: refiz todos os cortes, vetores de payoff e sinais, e não encontrei erro em nenhuma proposição, no exemplo numérico ou nas figuras. As células vazias são tratadas com disciplina lógica em todo o manuscrito. O que impede uma nota mais alta são decisões de desenho da análise, não erros. Primeiro, a comparação institucional é indefinida em cerca de metade do espaço de crenças por uma restrição autoimposta (votos puros) cuja saída é padrão e cujo relaxamento provavelmente revelaria o resultado mais interessante do paper, o atraso com screening sob unanimidade a crenças baixas. Segundo, a decomposição poder/informação está construída sobre um componente de poder fracamente negativo que o texto nunca confronta, e a linguagem de título, abstract e conclusão atribui ao "hegemon" um ganho que os resultados só concedem ao tipo fraco. Terceiro, as janelas em que o mecanismo anunciado opera são finas ou vazias e sua condição de existência (`β > m/(m+q−1)` em II) não é enunciada, enquanto um aparato extenso é dedicado a conjuntos de medida zero. A cunha temporal, que governa os sinais robustos, repousa na identificação de dois estados do mundo distintos no mesmo parâmetro `o_θ`. Com esses pontos, o manuscrito entrega dados corretos e uma interpretação que ainda não está sustentada por eles.

## Sugestões construtivas

1. **Preencher a célula `(0,ν*]`.** Estender o conceito a estratégias mistas de voto (relaxando `T^Y` nas histórias em que a indiferença é o que sustenta a mistura), ou adotar um refinamento alternativo, e caracterizar o equilíbrio. Minha expectativa, a partir das contas acima, é uma região de atraso deliberado com screening em R2 a crenças baixas e pooling imediato acima de um corte interior. Esse resultado é o que o título promete e fortaleceria a contribuição mais do que qualquer outra mudança.
2. **Enunciar e discutir o sinal do componente de poder.** Reportar `V_U^{pub} − V_M^{pub} = (0,0), (0,−a_1), (−a_0,−a_1)` por região no corpo e explicar por que, com proponente fraco com todo o poder de barganha, o veto não tem valor. Isso muda a narrativa: a unanimidade só compensa o hegemon por via informacional, e só para o tipo cuja força é superestimada.
3. **Reconciliar título, abstract e conclusão com o vetor de tipos.** Dizer explicitamente que o tipo alto nunca ganha com consenso e que o ganho é do tipo baixo via pooling. Substituir "benefits the high type" por uma frase sobre `ΔRI` que não sugira ganho de payoff.
4. **Caracterizar as janelas.** Incluir a condição `β > m/(m+q−1)` para a janela de screening em II e a condição correspondente `ν_SE > ν*` em IX, com uma figura que mostre sua largura em função de `(β, m)`. O leitor precisa saber que a afirmação "positive when majority screens" vive em um conjunto fino.
5. **Separar os dois papéis de `o_θ`.** Introduzir um payoff distinto para "excluído de um acordo que funciona" e para "nenhum acordo", ou ao menos discutir que a cunha `a_θ` e o sinal de `k` dependem de o acordo sem `H` pagar-lhe exatamente o payoff de desacordo, sem desconto.
6. **Reportar a comparação ex ante como complemento.** A decisão de não ponderar tipos é defensável para o objeto interim, mas a pergunta de desenho institucional que motiva o paper é ex ante. No exemplo trabalhado, unanimidade domina exclusão sob maioria ex ante sse `ν < k/(o_1−o_0) = 0,86`; esse é um corte limpo e interpretável que o paper deixa de lado.
7. **Enxugar o aparato de medida zero.** Mover o segmento residual em `o_1 = 1/m`, os envelopes de C.2 e a equivalência de endpoints de C.1 para notas de rodapé ou um apêndice curto; cortar a Figura 4.
8. **Reparos formais.** Reescrever B.4 com `y ∈ (ℓ,h)` para tornar a inexistência independente de `T^Y`; definir "structural consistency" ou removê-la; justificar `m ≥ 3`; remover `ȳ`; remover `[AUTHOR: P1]` e `[AUTHOR: P2]`; corrigir a legenda da Figura 1.

---

## Parecer completo — Exposition

# Parecer de Exposition (Framework Edmans)

**Manuscrito**: "Informational Power Through Pivotality: How Consensus Can Benefit a Hegemon" (formal_model_v6; PDF de 31 páginas: 21 de corpo, 8 de apêndice, 2 de referências).

## Score: 5/10

Justificativa resumida: a prosa é limpa na frase e o aparato é enxuto (1 nota de rodapé em 21 páginas, 16 referências, corpo de ~5.000 palavras), o que em Edmans vale muito. Mas a exposição falha no nível do documento: marcadores editoriais residuais impressos no PDF, rótulos internos de trabalho vazando para as figuras, dez de onze objetos flutuantes (figuras e tabelas) nunca referenciados no texto, abstract acima do limite e sem um único número, parágrafo de resultados da introdução ilegível para quem chega frio, e cada resultado formal apresentado quatro ou cinco vezes enquanto a intuição do resultado mais surpreendente (inexistência) recebe três frases. Nenhum desses problemas é estrutural; todos são corrigíveis em uma passagem cuidadosa, e o manuscrito chegaria a 7–8 com ela. Hoje, porém, o conjunto sinaliza descuido ao editor e obscurece uma contribuição que o modelo em si apresenta com clareza.

## Avaliacao por dimensao

### Clareza [Adequada]

#### Qualidade da escrita

**Marcadores editoriais residuais no PDF (problema mais grave de descuido).** Dois marcadores de trabalho aparecem impressos na página 5 do PDF:

- l.188: "[AUTHOR: P2] This normalization isolates informational concessions and pivotality from any intrinsic benefit…"
- l.215: "[AUTHOR: P1] The delayed terminal disagreement payoff represents the cost of prolonging international negotiations."

Um editor que vê isso na página 5 passa a ler o restante procurando outros sinais de versão não finalizada. E os encontra:

- **Figura 4** (arquivo `figure_f3_power_information`), nota interna: "This is a working numerical illustration of the exact **N7 formulas**, not a calibration." "N7" é um rótulo interno de derivação; não existe no manuscrito.
- **Figura 3** (arquivo `figure_f1_private_comparison`), nota interna: "**No prior-weighted or ex ante image is displayed.**" É linguagem de resposta a revisor, não de legenda.
- **Figura 2** (`figure_f2_prices_coalitions`), nota interna: "not the public-benchmark rent **estimand**" — "estimand" é vocabulário de inferência empírica em um paper puramente teórico.
- **Figura 5** (`figure_f4_hegemonic_decline`), legenda LaTeX: "Historical annotations, **if used**, are illustrations rather than empirical tests or calibration." A figura não contém nenhuma anotação histórica. É uma legenda-placeholder.

**Referências cruzadas: dez de onze objetos flutuantes são órfãos.** O manuscrito contém exatamente um `\ref` para figura ou tabela em todo o texto (l.578, "Figure \ref{fig:privatecompare} maps these exact classes"). As Figuras 1, 2, 4 e 5 e as Tabelas 1 a 6 nunca são mencionadas na prosa. O leitor chega à Figura 5 ("Hegemonic decline across pooling…") e descobre que a palavra "decline" não aparece em nenhum lugar do texto — a figura ilustra uma narrativa (queda de ν como declínio hegemônico, "read from right to left") que o corpo nunca constrói.

**Figuras: legenda tripla e texto ilegível.** Cada figura ggplot traz título, subtítulo e uma nota de quatro a seis linhas embutidos na imagem, **e** uma legenda LaTeX por cima. Ao serem reduzidas à largura do texto (pp. 12, 14, 18, 20), as notas embutidas ficam em corpo de ~4pt, ilegíveis em impressão. A notação nas figuras é ASCII ("nu", "beta x o1", "h - ell", "o_theta", "nu_SE", "RI_M", "DeltaRI") enquanto o corpo usa símbolos tipografados; a Figura 3 mistura ν* em grego com "nu" no eixo. A Figura 3 ainda introduz dois objetos que o texto nunca define: o eixo "Relative hegemonic strength, m × o₁" e a restrição "Closed-form slice o₀ = 0.50 × o₁" (o corte o₀ = o₁/2 não é mencionado nem na prosa nem na legenda LaTeX). A Figura 1 (fluxograma de seis caixas) é trivial e repete a Tabela 1 e o Apêndice A.1 — exatamente o tipo de "game tree" que Hirsch & Shotts não imprimiriam.

**Diagramação.** A p. 13 fica ~60% em branco e a p. 19 ~60% em branco por causa de floats forçados com `[H]`. A Tabela 4 está em `\scriptsize` e a coluna "H payoff vector" quebra com "or" pendurado no fim da linha ("(t₀,t₁) or / (o₀,o₁)"). A Tabela 3 quebra a desigualdade ao meio ("Majority, o ≤ / 1/m"). A Tabela 5 (longtable de 21 linhas) atravessa as pp. 16–17.

**Deriva terminológica para o mesmo primitivo.** O objeto o_θ é chamado de "outside option" (4 ocorrências, inclusive no abstract), "disagreement payoff" (8), "reservation value" (2) e "threshold" (para βo_θ). A introdução rotula a classe de equilíbrio de maioria como "type-contingent delay" (l.101) e cinco linhas depois usa o verbo "screens" (l.106); o substantivo "screening" só é definido na Seção 4.3. "weak respondent" (A.1) convive com "weak responder" (27 ocorrências).

**Colisões de notação.** (i) Em B.3, "Let *k* be the number of such responders", mas *k* = βo₁ − o₀ é definido em 4.5 e no Apêndice D. (ii) *h* = βo₁ (4.4) e *h^Y*, *h^N* são histórias (Tabela 1). (iii) *W* é o conjunto de Estados fracos (3.1) e *W(η)* é a continuação de um Estado fraco (B.4). (iv) *b_θ* é introduzido apenas para ser normalizado a zero (l.186–189) — ruído.

**Frases que soam como notas internas, não como prosa para o leitor.**
- l.122–123: "Their mechanisms and results **receive full priority** as the nearest points of comparison." Um leitor não sabe o que "receber prioridade" significa aqui; parece instrução a um coautor.
- l.457: "The last segment is genuine multiplicity." (falta "a case of")
- l.459–460: "It is not a license to combine componentwise minima and maxima into an unattained rectangle." Resposta a um parecerista, não exposição.
- l.742: "The model's central distinction is **technological**." Para leitor de CP, "technological" é literal; o sentido (substituibilidade de insumos) precisa ser dito: "The distinction is one of substitutability: under majority the hegemon's vote has a substitute; under unanimity it has none."
- Conclusão: "The decomposition disciplines the claim." Jargão de processo, não de conteúdo.

**Registro defensivo.** Contei sete formulações do tipo "not an estimate / not an empirical calibration / no claim / do not derive, characterize, select, or compare / is not a license / does not justify / do not average", além do Remark (Pure-strategy scope), da Tabela 2 (Scope), do último parágrafo de 5.1, de 5.3 e do último parágrafo de C.2 — a ressalva sobre a célula vazia aparece cinco vezes. Cada uma é defensável isoladamente; juntas, ocupam o espaço que deveria ser da intuição e dão ao paper o tom de documento escrito para um auditor, não para um leitor de APSR/IO.

#### Significancia economica

**Zero números no abstract e na introdução.** O paper tem números memoráveis, mas eles estão na p. 28 (Apêndice C.3): no exemplo, o tipo baixo recebe **0,315 sob unanimidade contra 0,10 sob maioria** (mais do que o triplo); a renda informacional é **0,225 sob unanimidade contra 0,01 sob maioria** (vinte e duas vezes); e para qualquer crença abaixo de **28%** não existe equilíbrio em estratégias puras. Nenhum desses aparece antes do apêndice. Em Edmans, "7 percentage points" vence "statistically significant"; aqui, o equivalente é "0.10 → 0.315" contra "positive for the low type when majority screens".

**A magnitude nunca é dimensionada em palavras.** O leitor aprende que ΔRI ∈ {(d,0), (0,0), (k,−a₁), …}, mas nunca lê a frase simples: sob pooling, **o tipo baixo captura integralmente o gap de tipo descontado, β(o₁ − o₀)**. Isso é o resultado em uma linha, e é memorável; a notação (d, 0) não é.

**"Quando é zero" está bem tratado; "quando é grande" não.** O paper é cuidadoso em dizer onde o efeito é zero ou indefinido (ponto forte). Falta o complemento: o efeito é grande quando o gap de tipos é grande e β é alto, e desaparece com β → 0. Uma frase de estática comparativa verbal resolve.

**A Seção 2 ("A working numerical illustration") gasta meia página para ilustrar apenas o corte terminal ν\***, não o mecanismo central (substituto vs. insumo essencial). Seu retorno expositivo é baixo; os números que importam estão em C.3 e na Figura 2B.

#### Precisao da linguagem

- **l.96–97**: "The resulting rent is **frequently** attached to pooling rather than to separation." No modelo, sob unanimidade a renda existe **somente** via pooling: em ν = 0 ela é zero e a célula intermediária é vazia. "Frequently" é impreciso e subestima o resultado. Reescrever: "Under unanimity, the rent arises only through pooling: a hegemon whose strength is overestimated receives the concession calibrated to the high type."
- **Abstract**: "the institutional informational-rent contrast **depends on the hegemon's type, the majority equilibrium class, and the parameter region**" é o "it depends" clássico, seguido de uma frase que só é parseável por quem já conhece as classes do modelo. A última frase — "but only under conditions that the equilibrium correspondence makes explicit" — não diz nada ao leitor.
- **Introdução, l.100–112**: o parágrafo de resultados é uma transcrição em prosa da Tabela 5, usando "screens/pools/excludes" e "public/private majority" antes de qualquer definição. Para quem chega frio é ilegível. (Sugestão de reescrita na seção "Introducao" abaixo.)
- **l.60–75**: o paper formula uma pergunta em três partes (por que sem controle de agenda, por que regra mais estrita que maioria, por que consenso) e a retira na frase seguinte ("That broader question motivates the paper, but the model holds the institutional rule fixed"). Isso lê como bait-and-switch. Ou corta a pergunta tripla, ou a move para a Conclusão como "o que o modelo não responde".
- **l.130–132**: "This distinction **complements** rational-design and informal-power accounts" — como? Em qual previsão? Sem uma frase, é citação decorativa.
- **5.2, implicações observáveis**: "The model suggests looking for institutional concessions that arise because partners cannot confidently price the major state's willingness to accept" não é operacional; "whether majority would provide a cheaper coalition of uninformed votes" é um contrafactual, não um observável. O modelo permite afirmações mais nítidas, por exemplo: concessões ao hegemon devem ser maiores sob consenso do que sob maioria **quando** sua opção externa é incerta; devem crescer com a dispersão de crenças sobre ela; e devem cair quando a opção externa se torna pública (choque observável). Três frases assim substituem o parágrafo.
- **Prop. 4.7**: "the high-type component there is off support but remains part of the type-contingent vector" — o leitor lê que se reporta payoff para um tipo de probabilidade zero. Precisa de uma frase em linguagem comum: trata-se da comparação com o jogo de informação completa do tipo alto, reportada por completude.
- **4.3**: "the proposer's payoffs from the **three** undominated outcome classes" seguido de **quatro** objetos exibidos (E, L, S(ν), P); L não é uma classe, é um componente de S(ν).
- **Roadmap (l.134–140)** omite a Seção 2 e a Seção 6.
- **O resultado mais surpreendente recebe a menor intuição.** A inexistência (4.4, l.471–476) tem três frases, e o item 2 de B.4 diz literalmente que, sob (N,N), "T^Y requires yes at equality". Um leitor atento concluirá que a inexistência é fabricada pela convenção de desempate. A prova mostra mais do que isso — para qualquer y ∈ (ℓ, h) não há indiferença alguma e o que destrói o perfil separador é o salto de crença após um "não" fora do caminho —, mas o corpo não diz isso. É um reparo de exposição com retorno de execução: uma frase como "the emptiness does not hinge on the tie-break: for every offer strictly between ℓ and h, the low type's deviation to 'no' is rewarded by the belief jump, not by indifference" desarma a objeção antes que ela apareça.
- **Título da 4.6, "difference of differences"**: para um público de CP treinado empiricamente, evoca DiD. "Netting out the public benchmark" é mais preciso.

### Extensao [Adequado — corpo enxuto, mas com redundância estrutural]

#### Introducao

~710 palavras, duas páginas — muito abaixo do teto de seis. A estrutura segue contexto → análise → literatura → contribuição → roadmap, sem intercalar literatura com contribuição. Isso está correto.

O problema é que a introdução é curta **e opaca**, não curta e clara. Faltam três coisas que cabem em cinco linhas: (i) um número; (ii) o resultado principal em uma frase de linguagem comum; (iii) uma frase de diferenciação do paper mais próximo (Piazolo & Vanberg 2025 recebe uma oração subordinada). Além disso, "narrower" aparece duas vezes ("a narrower theoretical puzzle", "Our narrower contribution") — o autor subvende o próprio resultado.

Sugestão de reescrita do parágrafo de resultados (l.100–112), definindo os rótulos antes de usá-los:

> "Call a proposal *screening* if only the low type accepts it, *pooling* if both types accept, and *exclusion* if it passes without the hegemon. Three results follow. First, under majority a proposer always has a substitute for the hegemon's vote, so private information changes little: the hegemon is bought at its discounted threshold, screened, or left outside. Second, under unanimity there is no substitute. When weak states believe the high type sufficiently likely, every proposal pays the high threshold, and a low-type hegemon captures the entire discounted gap between the two disagreement payoffs; in the worked example its payoff rises from 0.10 to 0.315. Third, for intermediate beliefs the unanimity game has no equilibrium in pure voting strategies, so the comparison is undefined there rather than small."

Sugestão de abstract (≈150 palavras; o atual tem **200**, acima do limite de APSR, AJPS, JOP e IO):

> "Why would a hegemon accept a consensus rule that gives every member an equal vote and no agenda control? We compare majority and unanimity in a two-round bargaining game in which only weak states propose and the hegemon privately knows whether its disagreement payoff is low or high. Under majority, a proposer can replace the hegemon's vote with an uninformed weak-state vote; that substitute caps what the hegemon can extract. Under unanimity the hegemon is an essential input, so proposals must respond to a threshold the proposer cannot observe. When the high type is sufficiently likely, unanimity pools at the high threshold and a low-type hegemon captures the entire discounted type gap; in a worked example its payoff rises from 0.10 to 0.315. The advantage is zero when majority already pools, can reverse when majority excludes, and is undefined for intermediate beliefs, where no pure-strategy equilibrium exists."

#### Notas de rodape

Uma nota em 21 páginas. Exemplar. (A única nota, sobre consenso = unanimidade, poderia virar parêntese, mas é questão de gosto.)

#### Extensoes desnecessarias

Não há seção de extensões, o que é bom. Mas o corpo carrega material que se comporta como extensão desnecessária:

1. **O segmento exclusão–pooling em o₁ = 1/m** (caso de medida zero) aparece **oito vezes**: Prop. 4.3 item 5, o parágrafo seguinte ("The last segment is genuine multiplicity…"), Prop. 4.5 item 4, última frase da Prop. 4.6, última frase da Prop. 4.7, duas linhas da Tabela 5, a frase após a Tabela 5 e todo o Apêndice C.2. Deveria ser uma frase no corpo ("At the knife-edge o₁ = 1/m, exclusion and pooling tie and a proposal segment survives; Appendix C.2 reports the exact set") e o resto no apêndice. O mesmo vale para a "identity multiplicity" (permutação de respondentes), enunciada na Prop. 4.3 e de novo em B.3.

2. **Cada resultado é apresentado quatro ou cinco vezes.** Prop. 4.1 e Tabela 3 são duplicatas literais. Props. 4.6/4.7, Tabela 5 (21 linhas), o parágrafo "The sign pattern is transparent…", a Figura 4 e o Apêndice C.2 reportam os mesmos doze vetores. O modelo é enunciado quatro vezes: prosa de 3.2, Tabela 1, Figura 1 e Apêndice A.1; a Tabela 2 ainda reapresenta as hipóteses recém-enunciadas. A média de qualidade sobe se: manter as proposições; manter a Tabela 4 (a única com valor de síntese); mover a Tabela 5 para o apêndice; cortar Tabela 3, Tabela 2 e Figura 1.

3. **Figuras.** Das cinco, só a Figura 3 (mapa de regiões em (ν, m·o₁)) tem densidade informacional real — e precisa que o texto explique o eixo e o corte o₀ = o₁/2. A Figura 2A (funções-degrau de preço) é útil; a 2B é uma barra empilhada de um único ponto paramétrico. A Figura 4B é um gráfico de barras de três números (0,010; 0,225; 0,215) e três zeros, já reportados em C.3. A Figura 5 é uma linha horizontal, um retângulo hachurado e um ponto, ilustrando uma narrativa de "declínio" que o texto não faz. Recomendação: manter 3 (corrigida) e 2A; cortar 1, 4B e 5 — ou escrever o parágrafo de declínio hegemônico que a 5 ilustraria, que aliás seria o parágrafo mais interessante da Discussão.

4. **Extensão total**: 21 + 8 + 2 = 31 páginas é adequado para APSR/AJPS/IO. O problema não é o tamanho, é o que ocupa o espaço.

### Citacoes [Precisas, com uma descricao imprecisa e duas ausencias conspicuas]

Dezesseis referências, nenhuma por método padrão, nenhuma por fato conhecido antes do paper citado, nenhuma visivelmente estratégica. Pelo teste de Edmans ("o manuscrito faria a mesma afirmação sem a citação?"), a bibliografia passa quase inteira. Os problemas são de precisão e de omissão, não de inflação.

#### Problemas especificos

1. **Descrição imprecisa de Miller, Montero & Vanberg (2018).** l.117–119: "provide a useful complete-information benchmark for bargaining under **heterogeneous voting rules**." O título na bibliografia é "Legislative Bargaining with **Heterogeneous Disagreement Values**: Theory and Experiments." O que torna o paper relevante aqui é exatamente o que o manuscrito não menciona — valores de desacordo heterogêneos, que é o que 0 < o₀ < o₁ é. Reescrever: "…a complete-information benchmark for Baron–Ferejohn bargaining with heterogeneous disagreement values, the primitive our hegemon holds privately."

2. **Os papers mais próximos não são diferenciados.** l.119–123: Piazolo & Vanberg (2025) e Glynia, Thum & Xefteris (2026) recebem uma oração cada e a frase "Their mechanisms and results receive full priority as the nearest points of comparison." O editor não consegue avaliar novidade porque o texto não diz o que eles encontram nem o que muda aqui. Uma frase por paper, no formato [o que fazem] / [o que encontram] / [o que difere aqui: o ator informado nunca propõe, é só votante; a pergunta é se a regra preserva um substituto para seu voto].

3. **Koremenos, Lipson & Snidal (2001) e Stone (2011)** são citados uma vez, em uma oração, para afirmar complementaridade (l.130–132) sem dizer em quê. Ou o texto dedica uma frase (por exemplo, que o modelo oferece um microfundamento para a escolha de regra de voto de Koremenos et al. e para o "informal power" de Stone via preço do voto), ou a citação é decorativa.

4. **Ausências que um editor de IO/CP vai apontar.** Maggi & Morelli (2006, *AER*, "Self-Enforcing Voting in International Organizations") é o tratamento formal canônico de unanimidade versus maioria em organizações internacionais; sua ausência em um paper cujo título é sobre consenso em OIs chama atenção. Tsebelis (2002, *Veto Players*) é esperado dado que o benchmark público é apresentado como "veto power" em todo o texto. Não é inflação pedir essas duas; é o mínimo para sustentar a frase "complements rational-design and informal-power accounts".

5. **Feddersen & Pesendorfer (1998)** está agrupado na primeira citação como "work showing how voting rules organize legislative bargaining and information aggregation". É jurí, não barganha legislativa; a oração "and information aggregation" cobre, mas o paper só o usa de fato como contraste em 5.2. Aceitável; apenas não o liste junto de Baron–Ferejohn como se fosse a mesma literatura.

6. **Fattouh & Mahadeva (2013) e Nakov & Nuño (2013)** sustentam o fato estilizado sobre capacidade ociosa saudita. Adequado como fonte de fato específico (não é "polarization has increased"). Manter.

7. **Fudenberg & Tirole (1991), Osborne & Rubinstein (1990), Kreps & Wilson (1982)** para o conceito de solução: precisos e necessários.

## Veredicto geral sobre exposition

Este é um manuscrito com prosa limpa, aparato disciplinado e um modelo enunciado com clareza, cuja exposição no nível do documento ainda está uma rodada atrás do conteúdo. Os sinais de descuido são concretos e visíveis ao editor na primeira leitura: "[AUTHOR: P1]" e "[AUTHOR: P2]" impressos na p. 5, "N7" em uma nota de figura, uma legenda com "if used", duas páginas 60% em branco, notas de figura ilegíveis, e dez de onze figuras e tabelas que o texto nunca menciona. A contribuição é obscurecida por três vias: o abstract e a introdução não contêm nenhum número nem uma frase simples do resultado ("sob pooling o tipo baixo captura o gap de tipo descontado inteiro"); o parágrafo de resultados da introdução usa rótulos que só são definidos na Seção 4; e a repetição de cada objeto formal em proposição, tabela, parágrafo, figura e apêndice consome o espaço que faltou à intuição — sobretudo para a inexistência em estratégias puras, que o leitor vai atribuir ao desempate T^Y se o texto não disser por que não é o caso. O registro defensivo (sete ressalvas, cinco repetições da mesma cláusula de escopo) agrava a percepção de que o paper foi escrito para um auditor. Nada disso exige novo trabalho formal; exige uma passagem de edição que tire o que está repetido, ponha o que está faltando e trate as figuras como parte do argumento, não como anexos.

## Top 5 sugestoes de melhoria

1. **Limpeza mecânica, antes de qualquer outra coisa.** Remover "[AUTHOR: P1]" (l.215) e "[AUTHOR: P2]" (l.188); remover "N7", "No prior-weighted or ex ante image is displayed", "estimand" e "if used" das figuras e legendas; referenciar no texto toda figura e tabela que sobreviver (hoje só a Figura 3 é citada); tirar título, subtítulo e nota embutidos dos ggplots (deixar a legenda LaTeX como única legenda) e tipografar a notação (ν, β, ℓ, h, o_θ) nas figuras; resolver as páginas em branco (trocar `[H]` por `[tbp]` ou reposicionar); corrigir as quebras nas Tabelas 3 e 4. Esta é a correção de maior retorno por hora de trabalho, porque são esses itens que levantam dúvida sobre rigor.

2. **Reescrever abstract (≤150 palavras) e o parágrafo de resultados da introdução com um número e com o mecanismo em linguagem comum.** Definir screening / pooling / exclusão antes de usar; substituir "type-contingent delay" por "screening"; dizer que sob pooling o tipo baixo captura o gap descontado inteiro, β(o₁ − o₀), e que no exemplo seu payoff vai de 0,10 a 0,315 enquanto sob maioria a renda informacional é 0,01. Cortar a pergunta tripla que é retirada na frase seguinte, ou movê-la para a Conclusão. Eliminar "narrower" (duas vezes). Textos sugeridos acima.

3. **Desduplicar e realocar.** Cortar Tabela 3 (duplica a Prop. 4.1), Tabela 2 (reapresenta as hipóteses), Figura 1 (fluxograma trivial), Figura 4B (três números já em C.3) e Figura 5 (ou escrever o parágrafo de declínio hegemônico que ela ilustraria). Mover a Tabela 5 para o apêndice. Reduzir o segmento o₁ = 1/m a uma frase no corpo, com o resto em C.2. Consolidar as sete ressalvas e as cinco repetições da cláusula de escopo em um único parágrafo de escopo ao fim da Seção 3.

4. **Colocar intuição antes dos dois resultados que carregam o paper.** (a) Inexistência (4.4): explicar em um parágrafo por que a célula é vazia para qualquer oferta em (ℓ, h), e dizer explicitamente que o desempate T^Y só decide o ponto y = ℓ — o motor é o salto de crença após um "não" fora do caminho. (b) Sinal de ΔRI (4.6): antes da Prop. 4.7, um parágrafo verbal com o caso de cada região (II, IX, XX), e uma frase de estática comparativa ("the advantage grows with the type gap and with β"). Renomear 4.6 para evitar "difference of differences".

5. **Precisão terminológica e de citações.** Escolher um termo para o_θ ("disagreement payoff") e usá-lo no abstract, na introdução e nas regiões II/IX/XX; unificar "responder"; resolver as colisões *k*, *h* e *W*; eliminar b_θ ou levá-lo para Limits; trocar "technological" por "substitutability". Corrigir a descrição de Miller, Montero & Vanberg (2018) para "heterogeneous disagreement values"; substituir "receive full priority" por uma frase de diferenciação concreta para Piazolo & Vanberg (2025) e Glynia, Thum & Xefteris (2026); desenvolver ou cortar a oração sobre Koremenos et al. e Stone; considerar Maggi & Morelli (2006) e Tsebelis (2002), que um editor de IO vai cobrar.
