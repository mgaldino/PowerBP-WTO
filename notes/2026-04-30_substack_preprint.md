# Consenso como tecnologia de poder: por que os mais fortes escolhem regras que parecem enfraquecê-los

Meu último texto aqui tentou responder à pergunta: por que muitas organizações internacionais (OIs) operam por consenso? Se as Relações Internacionais são um estado hobbesiano, onde impera a lei dos mais fortes, por que diabos os mais fortes aceitariam participar de instituições sob a regra do consenso, em vez de qualquer outro critério que refletisse a distribuição de poder no Sistema Internacional — como é, por exemplo, o Conselho de Segurança da ONU ou o FMI?

Eu tinha anunciado um resultado e uma explicação e estava fazendo um modelo formal. Bem, acontece que meu modelo estava errado e, portanto, a explicação também. Isso me deixou bastante chateado, mas essa é a vida do pesquisador. Abandonei por um tempo para trabalhar em outros projetos, na esperança de que em algum momento tivesse uma luz de como reconstruir o modelo sem jogar tudo fora. Agora, aparentemente consegui. Digo "aparentemente" porque, desta vez, verifiquei o resultado com provas formais rigorosas — mas, como qualquer pesquisador sabe, sempre pode haver algo que escapou. O preprint está disponível [aqui](https://osf.io/preprints/socarxiv/ca8vj_v3) e foi submetido à Review of International Organizations.

## O puzzle

Os EUA, o país mais poderoso do mundo desde a Segunda Guerra Mundial, ajudaram a criar o GATT (General Agreement on Trade and Tariffs), que em 1994 se tornou a Organização Mundial do Comércio. Ambos funcionam por consenso desde sempre. Cada membro, não importa quão pequeno, pode efetivamente bloquear qualquer decisão. Os EUA não possuem nenhum poder formal que os demais não possuam — nem veto privilegiado, nem voto com peso diferenciado, nem controle da agenda. Por que o país hegemônico concordaria com isso?

O senso comum diz que não deveria, e os modelos de economia política também. No artigo seminal sobre negociação no legislativo, Baron e Ferejohn (1989) mostraram que quem tem o poder de agenda — o poder de propor como o excedente será distribuído — se beneficia enormemente da regra da maioria. Como ele escolhe quem faz parte da coalizão vencedora, extrai uma parte maior do bolo para si e usa a ameaça crível de substituir os membros da coalizão para disciplinar seus escolhidos. Kalandrakis (2006) estendeu esse resultado e mostrou que o poder de propor é a fonte de poder mais importante para resolver a distribuição de excedentes: sob maioria, poder de agenda supera poder de veto e voto qualificado.

As explicações clássicas de Relações Internacionais, como o texto de Steinberg (2002), dizem que informalmente os EUA usam suas cenouras e porretes para induzir os países a fazerem o que lhes é favorável. Por isso aceitariam operar sob a lógica do consenso e de suposta igualdade formal, pois a desigualdade apareceria nos bastidores. Mas essa é uma explicação insatisfatória: se o hegemon precisa "comprar o apoio nos bastidores", o consenso requer que ele compre *todo mundo*, o que sai muito mais caro que sob maioria. Então você precisa explicar por que ele não impôs a maioria em primeiro lugar. Steinberg diz que temeu que países em desenvolvimento se bandeassem para a URSS. Mas por que a OMC, formalmente outra organização, manteve o consenso em 1994, no auge da hegemonia liberal americana? E por que tantas outras OIs antes e depois fizeram o mesmo?

## A resposta: poder informacional sob pivotalidade

Durante meu mestrado, essa pergunta me perseguia. Minha resposta à época foi: os EUA possuem poder de agenda informal. Mas essa resposta é ruim, porque não explica por que os países menores não teriam o mesmo poder (já que é informal) nem demonstra qual seria esse poder quando há exigência de consenso — afinal, todo mundo é veto player. Saí frustrado e abandonei a agenda. Precisei esperar quase 15 anos para finalmente encontrar a solução.

A resposta que proponho no paper é esta: **consenso não é uma concessão do mais forte. É uma tecnologia institucional de poder.** O mecanismo é o que chamo de *screening* sob pivotalidade.

Para entender, imagine uma negociação sobre como dividir um bolo. O hegemon (pense na Arábia Saudita dentro da OPEP) tem informação privada sobre o tamanho verdadeiro do bolo — quanto vale, de fato, a cooperação multilateral. Os demais países não sabem disso.

Sob **unanimidade** (consenso), o voto do hegemon é necessário para qualquer acordo. Os países fracos precisam decidir quanto oferecer ao hegemon sem saber o verdadeiro valor em jogo. Se oferecem pouco, arriscam uma rejeição. Se oferecem muito, pagam mais do que o necessário. Essa incerteza cria um *cutoff*: abaixo de certo nível de crença sobre o valor da cooperação, os fracos fazem uma oferta agressiva (baixa). Acima, fazem uma oferta conservadora (alta). A transição entre os dois comportamentos gera um salto discreto no payoff esperado do hegemon — uma renda informacional que ele extrai simplesmente por ser pivotal sob incerteza.

Sob **maioria**, os países fracos podem formar coalizões vencedoras *sem incluir o hegemon*. Não precisam do voto dele — logo, não enfrentam o problema de screening. A informação privada do hegemon se torna inútil. E o resultado paradoxal é que, sob maioria, ter mais informação torna o hegemon um parceiro de coalizão mais caro, incentivando os outros a excluí-lo. É uma maldição do conhecimento: saber mais te faz mais excluível.

## Os resultados

A comparação institucional tem uma estrutura limpa:

1. **Unanimidade domina sempre que consegue sustentar participação.** Condicional à entrada dos fracos, o hegemon sempre ganha mais sob unanimidade do que sob maioria.

2. **A única vantagem da maioria é viabilidade institucional mais ampla.** A maioria reduz a barreira de entrada — é mais fácil para os fracos aceitarem participar. Mas, uma vez que estão na mesa, o hegemon extrai menos.

3. **O screening é robusto.** A renda informacional é estritamente positiva para *qualquer* distribuição contínua dos tipos, não apenas para o caso binário do modelo base. Sob maioria, ela é zero — independentemente da distribuição.

## OPEP como ilustração

O paper usa a OPEP como caso ilustrativo, com a Arábia Saudita como hegemon. A capacidade ociosa saudita — quanto petróleo adicional pode colocar no mercado em 90 dias — é informação privada desde 1982, quando o ministro Yamani descontinuou relatórios campo a campo. Nenhuma auditoria independente foi feita até 2019. Analistas divergem em 40-80% sobre a capacidade real.

Na calibração para a crise de 1985-86, o hegemon captura 28% do excedente da cooperação sob unanimidade, contra 23% sob maioria — um prêmio de screening de 5 pontos percentuais que a maioria elimina inteiramente.

Eventos recentes confirmam as previsões: Angola saiu da OPEP em janeiro de 2024 e os Emirados Árabes em abril de 2026, ambos porque suas opções externas melhoraram — exatamente quando o modelo prevê que a unanimidade deixa de ser individualmente racional. A reação da OPEP em 2027, encomendando auditorias independentes de capacidade, é uma tentativa direta de reduzir a assimetria informacional que sustenta as rendas de screening.

## Uma predição discriminante

O modelo gera uma predição testável que o distingue das teorias concorrentes: consenso deve ser mais frequente onde o valor da cooperação é *difícil de avaliar* (órgãos regulatórios, standard-setters) e *ausente* onde os stakes são transparentes (instituições financeiras com voto ponderado). Isso bate com a distribuição cross-sectional documentada por Gould (2016). Teorias baseadas em aversão ao risco (Koremenos et al. 2001) preveem unanimidade sob incerteza, mas por um mecanismo diferente — seguro, que protege todos simetricamente. O screening, ao contrário, beneficia assimetricamente quem detém a informação privada.

## Um percurso pessoal

Essa pergunta me acompanha há 15 anos. Saí do mestrado frustrado, fui para o setor privado, voltei para a academia. A pergunta nunca saiu da minha cabeça. A versão anterior do modelo estava errada, e admitir isso publicamente num Substack não é a coisa mais confortável do mundo. Mas a ciência funciona assim: você erra, volta, e tenta de novo.

Desta vez, além das provas matemáticas no paper, verifiquei os resultados principais com um proof assistant (Lean 4) — software que checa cada passo lógico automaticamente. Não é garantia absoluta (há premissas que o software aceita sem verificar), mas é uma camada extra de segurança que me deixa mais confiante. E usei extensivamente IA (Claude Code) como assistente de pesquisa ao longo de todo o processo — na formalização, nas provas, na escrita, na verificação.

O paper está submetido à Review of International Organizations e o preprint está disponível no SocArXiv: https://osf.io/preprints/socarxiv/ca8vj_v3

Comentários são bem-vindos — especialmente de quem trabalha com design institucional, governança de OIs, ou modelos de barganha legislativa.
