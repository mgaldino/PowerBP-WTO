# Parecer de Contribution (Framework Edmans)

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: v5 (formal_model_v5.Rmd)
**Data**: 2026-04-27
**Framework**: Edmans (2025), "Learnings From 1,000 Rejections", adaptado para CP
**Avaliador**: Editor simulado de top journal CP (JoP/AJPS/IO)

---

## Score: 7.0/10

**Veredicto editorial**: Revise & Resubmit. A contribuicao e genuina e o mecanismo e original, mas enfrenta limitacoes quantitativas que precisam ser mais honestamente confrontadas, e a diferenciacao com a literatura mais proxima permanece insuficiente.

---

## Resumo da contribuicao alegada

O paper propoe que um hegemon pode preferir consenso (unanimidade) a maioria em organizacoes internacionais porque unanimidade forca estados fracos a incluir o hegemon em toda proposta sob incerteza sobre o valor da cooperacao. Isso cria um screening problem que gera uma renda informacional para o hegemon --- um jump discreto no payoff esperado. A comparacao institucional reduz-se a: unanimidade domina condicionalmente a entrada; maioria so domina via viabilidade institucional mais ampla.

---

## Avaliacao por dimensao

### Novidade [Forte]

Este e o ponto mais forte do paper. O mecanismo e genuinamente novo: ninguem na literatura de institutional design de OIs identificou que unanimidade pode ser preferida por um ator poderoso *porque* cria um screening problem que maioria elimina. A insight e counterintuitive --- a literatura convencional (Keohane, Ikenberry) trata unanimidade como self-binding, e a literatura de informal power (Steinberg, Stone) trata-a como irrelevante diante de poder assimetrico. O paper encontra um terceiro caminho: unanimidade como *tecnologia de poder informacional*.

A combinacao de Baron-Ferejohn com screening endogeno pela voting rule e original. Nao e uma combinacao convexa de resultados conhecidos. Bardhi & Guo (2018) estudam BP em votacao, mas nao com barganha legislativa e screening endogeno. Kim, Kim & Van Weelden estudam informacao em votacao, mas sem o mecanismo de institutional choice. O paper cria algo novo ao mostrar que a *voting rule* determina se screening ocorre ou nao.

O leitor atualiza significativamente suas crencas apos ler o resultado central? Sim: a proposicao de que unanimidade pode ser *preferida pelo ator mais poderoso* por razoes distributivas (nao normativas) e um update substantivo sobre como pensar sobre institutional design em OIs. A decomposicao limpa --- unanimidade domina condicionalmente, maioria domina por viabilidade --- e elegante e memoravel.

**Evidencia**: Theorem 1 (condicional dominance bicondicional), Proposition 4 (classificacao completa), e a identificacao precisa de alpha* como threshold necessario e suficiente.

### Importancia [Adequada, tendendo a Fraca]

Este e o ponto onde o paper enfrenta maior pressao editorial. Varias preocupacoes:

1. **Relevancia quantitativa para OIs reais**: alpha* diminui rapidamente com N. Para N=164 (WTO), alpha* ~ 0.03. O paper reconhece isso (p. 10, Sec. 7), mas a implicacao e severa: o resultado de dominancia condicional *global* so vale para hegemons com outside options muito modestas em organizacoes grandes. O Remark 1 (mu_bar) atenua parcialmente --- a fronteira e "remarkably stable" --- mas a regiao vermelha (maioria domina) perto de mu=1 existe e cresce com N. Para a aplicacao motivadora (WTO), o mecanismo opera num corredor parametrico estreito.

2. **"Just another" determinante?**: A literatura de institutional design de OIs ja tem multiplas explicacoes para consensus: legitimacy (Franck), self-binding (Ikenberry), informal power (Steinberg), transaction costs (Koremenos et al.). O paper adiciona "informational power" a esta lista. A questao Edmans e: um survey paper dedicaria um paragrafo ou uma subsecao a este resultado? Provavelmente uma subsecao, dado o mecanismo novo --- mas nao e claro que mudaria a narrativa dominante da area.

3. **Um policymaker mudaria decisoes?** Improvavel. O resultado e mais uma *explicacao* (por que consenso existe) do que uma *prescricao* (adote/evite consenso). A predicao empirica discriminante --- correlacao negativa entre consensus e stakes distributivos transparentes --- e interessante mas nao testada.

4. **Binary types como "most conservative case"**: O paper argumenta (via extensao continua, App. C.4) que o caso binario e o mais conservador. Isso e persuasivo para a existencia do screening rent, mas a afirmacao de que alpha*_cont >= alpha* (verificada numericamente para Uniform) nao e um resultado analitico geral. Para outras distribuicoes, nao se sabe.

### Adequacao ao escopo [Adequada]

A bibliografia e predominantemente de CP/RI: Baron & Ferejohn, Kalandrakis, Eraslan & Evdokimov (legislative bargaining); Koremenos et al., Steinberg, Keohane, Ikenberry (institutional design); Gould (consensus rules); Fearon (rationalist IR). A teoria de Bayesian Persuasion (Kamenica & Gentzkow) vem de Economics, mas e bem integrada como ferramenta tecnica.

O paper seria de interesse para a audiencia de JoP? Sim: o puzzle e central a RI (por que hegemons aceitam consensus?), o modelo usa ferramentas standard de formal political theory (Baron-Ferejohn), e o resultado fala a debates ativos na disciplina (Gould 2022 e recente). O paper estaria confortavel no JoP, AJPS ou IO.

Uma preocupacao menor: a literartura de trade negotiations (Jawara & Kwa, Jones et al., Blackhurst et al.) e invocada para motivar a assimetria informacional, mas esses trabalhos nao sao de teoria formal. A conexao empirica permanece ilustrativa, nao sistematica.

### Generalizabilidade [Adequada]

O mecanismo e formalmente geral: qualquer ambiente com (i) ator privadamente informado, (ii) veto power, (iii) screening problem existe. O paper nao depende de WTO-specific features.

Porem, a generalizabilidade quantitativa e limitada:
- O caso binario (K=2) tem alpha* em closed form; K>2 e qualitativo mas sem threshold geral.
- A extensao continua (C.4) e apenas para Uniform; outras distribuicoes sao "open".
- A estrutura de 2 rounds BF e especifica; T>2 nao e explorado.
- Entry all-or-nothing e uma simplificacao forte que suprime dinamicas importantes (free-riding, sequential accession).

O paper faz um bom trabalho na secao de Scope discutindo estas limitacoes. A honestidade sobre "most favorable case for the result" (K=2) no corpo vs. "most conservative case" (na conclusao, baseado em C.4) cria uma leve tensao que precisa ser resolvida.

### Trade-offs [Parcial]

O paper documenta claramente que unanimidade redistribui de fracos para o hegemon (Remark 3: "never Pareto-improving conditional on entry"). O paragrado sobre "why would weak states participate" e bem argumentado: weak states participam porque a alternativa e nenhuma instituicao, nao maioria.

O que esta menos desenvolvido:

1. **Welfare**: O paper e puramente distributivo (quem ganha mais). Nao ha analise de welfare agregado. Unanimidade pode causar surplus destruction (discounting quando theta=1 rejeita em R1), que e mencionado no budget check (A.6) mas nao discutido substantivamente. Quanto surplus se perde? Quando a destruicao de surplus supera o ganho distributivo?

2. **Custo de unanimidade para o sistema**: Se unanimidade beneficia o hegemon mas prejudica fracos e pode destruir surplus, ha um custo social que nao e quantificado. Um editor poderia perguntar: "unanimidade e eficiente?" A resposta parece ser "nao necessariamente", mas o paper nao engaja com isso.

3. **Alternativas ao binario M vs. U**: O paper compara apenas maioria simples vs. unanimidade. Regras intermediarias (supermaioria, quorum qualificado) nao sao discutidas. Um editor poderia perguntar se o mecanismo e monotono na supermaioria ou se ha um interior optimum.

### Hipoteses [Claras e direcionais]

O paper tem hipoteses claras, direcionais e derivadas do modelo:

1. **H prefere U condicionalmente a entrada** (Theorem 1): condicao necessaria e suficiente (alpha < alpha*).
2. **M domina apenas via entry** (Proposition 4): triparticao limpa do espaco de priors.
3. **Screening cutoff independente de alpha** (Proposition 2): resultado preciso e testavel.
4. **Predicao empirica discriminante**: correlacao negativa entre consensus e transparencia distributiva.

As hipoteses sao "fortes" no sentido de Edmans: derivadas de teoria, direcionais, com condicoes de contorno explicitas. Nao ha kitchen-sink.

---

## Veredicto geral sobre contribution

O paper tem uma contribuicao genuina e original: identificar que unanimidade pode ser uma tecnologia de poder informacional, nao uma concessao. O mecanismo (screening via pivotal inclusion) e novo, a formalizacao e limpa, e o resultado principal (Theorem 1 como bicondicional) e elegante. Isso o coloca acima da maioria dos papers de formal theory em CP/RI.

A principal fragilidade e quantitativa: o resultado de dominancia global (alpha < alpha*) e exigente para organizacoes grandes (alpha* -> 0 com N). O paper atenua isso com o Remark 1 (mu_bar estavel) e a extensao continua (alpha*_cont >= alpha*), mas a questao permanece: para a aplicacao motivadora (WTO, N=164), o mecanismo opera num corredor parametrico estreito. Isso nao invalida a contribuicao --- o mecanismo e teoricamente claro --- mas limita a importancia pratica.

Um segundo ponto e a diferenciacao insuficiente com Bardhi & Guo e Kim, Kim & Van Weelden. O paper menciona esses trabalhos na introducao mas dedica apenas uma frase a cada. Um editor de JoP ou AJPS pediria 2-3 paragrafos explicando por que este paper nao e uma extensao ou recombinacao desses resultados.

O score de 7.0 reflete: Novidade forte (o ativo principal), Hipoteses claras, Adequacao ao escopo, mas Importancia apenas adequada (corredor parametrico estreito para N grande, predicoes nao testadas) e Trade-offs parciais (sem welfare, sem supermaioria).

---

## Sugestoes construtivas

1. **Confrontar o problema de N grande mais diretamente**. O paper ja reconhece que alpha* diminui com N, mas poderia fortalecer a contribuicao mostrando que: (a) para organizacoes de tamanho moderado (N=5 a 30, tipo Quad, G7, G20, Conselho de Seguranca), alpha* e generoso; (b) para WTO-size, o mecanismo ainda opera numa faixa substantiva de beliefs (via mu_bar). Um paragrafo que mapeie alpha* para tipos concretos de organizacoes (pequenas, medias, grandes) tornaria o resultado mais tangivel.

2. **Expandir a diferenciacao com Bardhi & Guo e Kim-Kim-Van Weelden**. Esses sao os papers mais proximos. Dedique 2-3 paragrafos (nao 1 frase) explicando: (a) o que cada um faz, (b) o que *nao* faz que este paper faz, (c) por que a combinacao aqui nao e trivial. Isso e essencial para um referee que conheca essa literatura.

3. **Discutir welfare brevemente**. Adicione um paragrafo na Discussion ou Scope sobre eficiencia: unanimidade pode destruir surplus (via discounting em R1), entao o ganho distributivo do hegemon vem parcialmente a custa de eficiencia. Quantifique o surplus destruction para os parametros do Example 2. Isso mostra consciencia dos trade-offs e previne criticas de "one-sided analysis".

4. **Considerar supermaioria**. Ao menos um paragrafo discutindo se o mecanismo e monotono na supermaioria (i.e., se aumentar q de maioria simples ate unanimidade monotonicamente aumenta o screening rent). Se sim, isso fortalece a contribuicao; se nao, e informativo. Nao precisa ser formal --- uma conjectura fundamentada basta.

5. **Fortalecer a predicao empirica**. A predicao "correlacao negativa entre consensus e transparencia distributiva" e discriminante mas vaga. Operacionalize: que proxy para "transparencia distributiva"? Como distinguir esta predicao da de Koremenos et al. (que predizem unanimidade onde enforcement e fragil)? Uma tabela com 5-6 OIs, suas voting rules, e uma classificacao rough de transparencia das stakes fortaleceria muito.

6. **Resolver a tensao "most favorable" vs. "most conservative"**. O corpo (Scope) diz que K=2 e o "most favorable case for the result"; a conclusao diz que e o "most conservative case for the mechanism" (baseado em C.4). Ambos podem ser verdadeiros sob interpretacoes diferentes, mas um leitor desatento vera contradicao. Clarifique: K=2 e o caso mais conservador para a *existencia* do screening rent (que sempre existe), mas pode ser o mais favoravel para a *dominancia global* (alpha* pode ser menor com K>2 fora de Uniform). Essa distincao precisa ser explicita.

7. **Nota sobre mecanismo de escolha da voting rule**. O paper assume que H escolhe R unilateralmente. Na pratica, a escolha de voting rule e ela mesma negociada. Um paragrafo reconhecendo que a preferencia revelada de H por unanimidade pode nao se traduzir em unanimidade realizada (porque W prefere maioria) fortaleceria a honestidade do argumento. O paper ja toca nisso (Remark 3), mas poderia ser mais explicito.
