# Parecer de Execution (Framework Edmans 2025)

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"  
**Autor**: Manoel Galdino (University of Sao Paulo)  
**Arquivo**: `formal_model_v3.Rmd`  
**Data**: 2026-04-25  
**Revisor**: Claude (papel: editor de top journal CP)

---

## Score: 7.5 / 10
## Tipo de paper: TEORICO

---

## Resumo da estrategia

O paper e puramente teorico. A "execucao" consiste em: (1) especificar um jogo de barganha legislativa com informacao privada e regras de votacao alternativas (unanimidade vs. maioria), (2) derivar equilibrios em forma fechada, (3) demonstrar que a unanimidade domina condicionalmente via screening e Bayesian persuasion, e (4) aplicar o mecanismo ao puzzle GATT/WTO. A estrategia formal e um modelo de Baron-Ferejohn com dois rounds, prior binario, entrada custosa e BP estagio-zero. O argumento avanca de proposicoes parciais (no screening sob maioria, screening cutoff sob unanimidade, jump, non-convexity) ate os dois teoremas centrais (dominancia e single-crossing).

---

## Principio "Dados vs. Evidencia"

Em um paper teorico, o analogo de "dados vs. evidencia" e: as premissas do modelo implicam os resultados, ou os resultados estao embutidos nas premissas? E as conclusoes substantivas decorrem logicamente dos resultados formais, ou ha saltos interpretativos?

O paper e honesto neste ponto. Os resultados formais (Theorems 1 e 2) sao consequencias nao triviais das premissas. O screening jump nao e assumido --- ele emerge da interacao entre veto power, informacao privada e a forma da outside option. A dominancia condicional (Lemma 1) requer verificar positividade de uma funcao afim por partes em tres regioes, o que nao e mecanicamente obvio a partir das premissas. O single-crossing (Theorem 2) depende de propriedades estruturais da concavificacao que precisam ser demonstradas. Portanto, a distancia premissas-conclusoes e genuina.

No entanto, ha um salto interpretativo entre os resultados formais e a afirmacao substantiva central ("consensus is a technology of hegemonic power"). O modelo mostra *quando* unanimidade pode ser preferida, nao que isso *e* a explicacao para consenso no GATT/WTO. O paper reconhece isso explicitamente na Discussion ("does not claim that the GATT/WTO was designed for this reason"), o que e correto. Mas a formulacao no abstract e na introducao por vezes sugere mais do que o modelo entrega --- ver avaliacao detalhada abaixo.

---

## Avaliacao por dimensao

### T.1 Distancia premissas-conclusoes: 8/10

**Avaliacao**: Boa distancia. O resultado central --- unanimidade gera screening rent que maioria elimina --- nao e trivial. Requer derivar equilibrios em dois rounds sob ambas as regras, identificar o jump, provar dominancia condicional, e mostrar que BP amplifica a vantagem.

**Pontos fortes**:
- O cutoff de screening $\mu_s^{R1}$ emerge endogenamente da indiferenca do proposer fraco, nao e parametrizado diretamente.
- A condicao $\alpha < \alpha^*$ para dominancia condicional e derivada, nao assumida. A necessidade (Step 4 do Lemma 1) mostra que e tight.
- O bicondicional (iff) no Lemma 1 e um resultado forte: nao so suficiencia mas necessidade.
- O single-crossing (Theorem 2) requer o Lemma B.7 (global maximum de $V_W$) como peca tecnica nao obvia.

**Preocupacoes**:
- A outside option proporcional $d_H = \alpha V(\theta)$ faz muito trabalho. Se $d_H$ fosse constante (independente de $\theta$), o screening desapareceria. O paper justifica a forma proporcional substantivamente ("bilateral alternatives scale with multilateral value"), mas poderia ser mais explicito sobre o quanto o resultado depende desta forma funcional especifica vs. qualquer outside option que varie com $\theta$.
- O entry cost $c > 0$ uniforme e exogeno. O papel do entry cost e apenas criar a margem por onde maioria pode dominar. Se $c = 0$, unanimidade domina globalmente (Corollary 1). O modelo nao endogeniza a participacao de forma rica.
- O pie $V(\theta) \in \{1, r\}$ com dois estados e muito estilizado. O Appendix C com $K > 2$ tipos e bem-vindo, mas e apenas um proof sketch, nao uma derivacao completa dos equilibrios com $K$ tipos.

**Veredicto**: A maquinaria formal e genuina --- o resultado nao esta "na cara" a partir das premissas. A principal limitacao e que a forma funcional da outside option e o motor do screening, e o paper poderia explorar mais explicitamente a robustez a formas alternativas.

### T.2 Parcimonia: 8.5/10

**Avaliacao**: O modelo e notavelmente parcimonioso para o que entrega.

**Pontos fortes**:
- A comparacao institucional e isolada por design: mesmas proposal rights, mesmo pie, mesmo desconto, mesmos jogadores --- a *unica* diferenca e a regra de votacao. Isso e exemplar.
- O modelo tem poucos parametros livres: $N$, $r$, $\alpha$, $\beta$, $c$, $p$. Cada um tem interpretacao clara.
- A normalizacao $d_W = 0$ e WLOG e explicada.
- O tie-breaking convention e relegado a footnote.
- O exemplo motivador (Secao 2) com $N = 3$, um round, e eficaz para transmitir a intuicao central antes da maquinaria geral.

**Preocupacoes**:
- Dois rounds de Baron-Ferejohn sao necessarios? O screening tambem ocorre com um round (como no exemplo motivador). O segundo round adiciona R2 continuation values e o cutoff $\mu_s^{R2}$, mas o resultado qualitativo (screening jump, dominancia) ja aparece com um round. O paper poderia justificar melhor por que dois rounds sao necessarios para a mensagem substantiva, ou discutir explicitamente o que se perde com um round so.
- O BP commitment assumption e forte. O paper discute isso na Scope, mas a justificacao ("reputation", "institutional transparency rules", "upper bound") e assertiva sem modelagem formal. "Upper bound interpretation" e a melhor defesa, mas poderia ser mais proeminente.

**Veredicto**: Excelente economia de meios. O modelo faz uma coisa (comparar regras de votacao sob assimetria informacional) e faz bem. A estrutura de dois rounds e o unico elemento cuja necessidade nao e completamente justificada.

### T.3 Caminho causal (variaveis endogenas no path estao livres?): 7/10

**Avaliacao**: O caminho causal principal e claro: regra de votacao -> pivotalidade de H -> screening -> jump -> BP explora non-convexity -> dominancia. Mas ha tres pontos onde variaveis endogenas merecem mais atencao.

**Ponto 1: Escolha da regra de votacao pelo hegemon (Stage 0).**

O modelo assume que H escolhe a regra de votacao em Stage 0. Mas na pratica, a regra de votacao e uma escolha coletiva (design constitucional). O paper reconhece isso implicitamente --- a questao e "when would a hegemon *prefer* unanimity" --- mas o timing do jogo faz H escolher unilateralmente. Isso e um shortcut, nao uma falha fatal, mas o paper deveria discutir mais explicitamente a gap entre "H prefere unanimidade" e "unanimidade emerge em equilibrio de um jogo de design constitucional."

Se fracos tambem votam na regra, e fracos preferem maioria (porque unanimidade lhes da menos surplus, como o paper prova), entao a escolha de unanimidade *nunca* seria equilibrio por voto unanime dos membros. O hegemon precisaria de algum poder assimetrico na fase constitucional para impor unanimidade. O paper menciona isso? Nao diretamente. A Section 8 (Discussion) fala de informal agenda power no GATT/WTO, mas a conexao com o Stage 0 do modelo nao e feita.

**Ponto 2: Entry como variavel endogena.**

O modelo trata entry como uma decisao endogena dos fracos, o que e correto. Mas a entry condition e binaria (all-or-nothing symmetric entry). Se fracoes dos fracos pudessem entrar seletivamente, o screening poderia mudar. O paper foca em symmetric equilibria por construcao (footnote: "we focus on symmetric entry"), o que e razoavel mas restritivo.

**Ponto 3: O mecanismo de BP e a direcao causal.**

O modelo assume que H *primeiro* escolhe a regra, *depois* faz BP, e *depois* os fracos decidem entry. Se o timing fosse invertido (fracos entram antes de BP, ou a regra e escolhida apos entry), os resultados poderiam mudar. O paper nao discute robustez a timing alternatives. Isso e particularmente relevante porque, na pratica, a regra de votacao e fixa quando membros decidem se engajar substantivamente em uma rodada de negociacao (o "entry" relevante).

**Veredicto**: O caminho causal principal e logicamente correto dentro do modelo. Mas a Stage 0 assumption (H escolhe a regra unilateralmente) e a mais problematica: se H precisa de poder assimetrico para impor unanimidade, entao o modelo explica *quando H preferiria* unanimidade, nao *quando unanimidade emerge*. Essa gap deveria ser discutida explicitamente.

---

## Veredicto geral sobre execution

A execucao formal e solida. O modelo e bem especificado, os equilibrios sao derivados com rigor, e os dois teoremas centrais sao consequencias nao triviais das premissas. A estrategia de isolar a diferenca entre regras de votacao mantendo tudo o mais igual e correta e eficaz. O bicondicional no Lemma 1 (necessidade + suficiencia) e o single-crossing no Theorem 2 sao resultados clean que permitem interpretacao clara.

As principais fraquezas de execucao sao: (1) a dependencia na forma funcional especifica da outside option proporcional ($d_H = \alpha V(\theta)$), que e o motor do screening mas cuja robustez a formas alternativas nao e explorada; (2) a gap entre "H prefere unanimidade" e "unanimidade emerge em equilibrio," dado que Stage 0 e design hegemonico unilateral; e (3) a ausencia de discussao sobre robustez a timing alternatives (entry antes de BP, regra pos-entry).

Nenhuma dessas fraquezas e fatal. A primeira e a mais tecnica --- o paper poderia adicionar um remark sobre outside options nao-proporcionais. A segunda e a mais substantiva --- merece um paragrafo explicito na Discussion. A terceira e menor mas relevante.

O score de 7.5 reflete execucao acima da media, com margem de melhoria identificavel. Para um 8.5-9, o paper precisaria: (a) demonstrar que o screening persiste sob formas mais gerais de outside option; (b) discutir explicitamente como unanimidade emerge quando fracos preferem maioria; (c) justificar melhor a necessidade de dois rounds.

---

## Sugestoes construtivas

1. **Robustez da outside option**: Adicionar um remark ou paragrafo na Discussion/Scope discutindo o que acontece se $d_H = f(\theta)$ para $f$ geral (monotona crescente, nao necessariamente proporcional). O screening depende de $f(1) > f(0)$, nao de proporcionalidade. Afirmar isso explicitamente fortaleceria o resultado.

2. **Gap de design constitucional (Stage 0)**: Adicionar um paragrafo na Scope discutindo que o modelo mostra *preferencia* de H, nao *emergencia* de unanimidade. Dado que fracos preferem maioria (surplus menor sob unanimidade), H precisa de algum poder no estagio constitucional para impor unanimidade. Isso conecta o paper a Koremenos et al. (2001) e Maggi & Morelli (2006) de forma mais precisa.

3. **Necessidade de dois rounds**: Adicionar uma frase explicando o que dois rounds adicionam alem do resultado com um round. Se a unica adicao e o R2 continuation value como threat off-path, dizer isso. Se dois rounds sao necessarios para algum resultado (e.g., o Lemma B.7), explicar.

4. **Timing alternatives**: Adicionar um paragrafo na Scope discutindo se os resultados sao robustos a timing alternatives: (a) entry antes de BP; (b) regra escolhida apos entry. Para (a), BP apos entry removeria o canal de entrada mas preservaria o screening condicional. Para (b), H escolheria a regra apos observar quem entrou, o que poderia mudar o equilibrio.

5. **Appendix C (K > 2 tipos)**: Completar a derivacao dos equilibrios para $K = 3$ com offers e cutoffs explicitos, nao apenas o proof sketch das screening boundaries. Isso daria confianca de que o mecanismo generaliza alem do caso binario.

6. **Numerical worked example pos-Theorem 1**: O paper promete um worked example (P6 no TODO list). Esse example e importante para mostrar como $p^*$ e computado, como a concavificacao funciona na pratica, e qual e a magnitude do ganho de unanimidade em numeros. Incluir antes de submeter.

7. **Sobre o abstract**: A frase "The model identifies conditions under which consensus functions as a technology of hegemonic power" e forte. O abstract poderia ser mais preciso: "The model identifies conditions on informational asymmetry and outside options under which a hegemon strictly prefers unanimity to majority rule." Isso e mais fiel ao que o modelo entrega.

---

## Avaliacao detalhada de integridade das provas

As provas no Appendix B sao completas e verificaveis. Pontos especificos:

- **B.1 (Prop 1)**: Trivial, correto.
- **B.2 (Prop 2)**: Existencia via TVI, unicidade via analise quadratica. Correto. Os dois regimes ($\alpha < \bar\alpha$ e $\alpha \geq \bar\alpha$) sao tratados separadamente. A cobertura do caso alternativo e boa.
- **B.3 (Prop 3)**: Direct computation. Correto.
- **B.4 (Prop 4)**: Correto --- a non-convexidade decorre do jump.
- **B.5 (Lemma 1)**: A prova mais longa e importante. A decomposicao $D = D_{base} + \delta_{R2} + \delta_{R1}$ e elegante. A verificacao de positividade nos endpoints e correta. O caso alternativo ($\mu_s^{R1} < \mu_s^{R2}$) e coberto explicitamente, o que e bom. A necessidade (Step 4) e simples e correta.
- **B.6 (Theorem 1)**: Usa o budget identity e a dominancia condicional para mostrar $E_U \subseteq E_M$, depois argumenta que concavificacao nao ajuda maioria. O argumento de concavificacao (linhas que mostram $\text{cav } v(p, M) = v(p, M)$ para $p \in E_M$) e correto.
- **B.7 (Lemma VW max)**: A cancellation quadratica (proposer + non-proposer) e o ponto tecnico mais delicado. A verificacao por endpoints e correta.
- **B.8 (Theorem 2)**: A partitioning do prior space em $[0, a)$ e $[a, 1]$ e clara. O argumento de gaps em $E_U$ (Part 1) usa concavidade de $u$ e affinidade de $m$ --- correto. O argumento de ratio decrescente (Part 2) e standard.

**Nota**: Nao identifiquei erros matematicos nas provas. Os argumentos sao correct-as-stated.

---

## Comparacao com standards de journals-alvo

- **JoP**: Adequado. O estilo v3 (corpo narrativo, provas no appendix) e consistente com publicacoes recentes de JoP em teoria formal (Hirsch 2023, Hill 2022, Tyson et al. 2024). A extensao e razoavel.
- **AJPS**: Possivel, mas AJPS tem sido menos receptivo a teoria formal pura sem componente empirico. O paper precisaria de mais "bite" empirico.
- **IO**: O puzzle e de IO, mas o metodo e teoria formal. IO publica teoria formal ocasionalmente (Maggi & Morelli 2006), mas pede conexao empirica mais forte.
- **BJPS**: Possivel. Menos competitivo que JoP, mas o paper esta acima do limiar.

**Recomendacao**: JoP como primeiro alvo e correto.
