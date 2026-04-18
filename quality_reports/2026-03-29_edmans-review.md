# Carta Editorial — Framework Edmans (Contribution, Execution, Exposition)

## Decisao: Reject-and-Resubmit

## Scores consolidados
| Dimensao     | Score | Rating         |
|-------------|-------|----------------|
| Contribution | 5/10  | Fraca-Adequada |
| Execution    | 6/10  | Adequada       |
| Exposition   | 7.5/10| Boa            |
| **Global**   | 6/10  | Insuficiente para top journal na forma atual |

## Sintese editorial

O paper apresenta uma ideia genuinamente interessante e contra-intuitiva (a "Curse of Knowledge" — informacao prejudica o detentor sob regra de maioria em barganha multilateral) com uma aplicacao provocativa (explicar consenso na OMC). A escrita e clara, concisa, e o modelo e parcimonioso. Porem, ha uma tensao fundamental entre as tres dimensoes: a exposition e boa o suficiente para comunicar o que o paper faz, mas o que ele faz (execution) revela que o resultado central emerge de forma relativamente trivial das premissas, e a contribuicao, embora nova, tem alcance limitado pela especificidade do modelo (monopolio informacional, pie binaria, revelation completa no periodo 1).

A principal forca e a simplicidade do mecanismo e a clareza da comparacao maioria vs. unanimidade. A principal fraqueza e a distancia minima entre premissas e conclusoes (T.1 na Execution): o "Curse of Knowledge" segue mecanicamente do fato de que o Sender e mais caro e pode ser excluido — nao ha tradeoff genuino no modelo. A interacao com Bayesian Persuasion, que da nome ao paper, e na verdade marginal: sob maioria, BP e irrelevante; sob unanimidade, BP ajuda por razoes relativamente diretas.

## Hierarquia Edmans aplicada

A contribuicao e o bottleneck. O resultado e novo mas "pequeno": uma vez compreendido o setup, a conclusao e quase transparente. Melhorar exposition (que ja e boa) nao elevaria o paper ao nivel de top journal. Melhorar execution (equilibrio formal, robustez) ajudaria mas nao resolveria o problema de contribuicao. O que faria o paper publicavel em top journal seria **enriquecer o mecanismo para gerar tradeoffs** (e.g., S traz valor informacional a coalizao, criando tensao entre exclusao por custo e inclusao por valor) ou **endogeneizar a aquisicao de informacao** (tornando a Curse of Knowledge parte de um argumento de design institucional mais profundo).

## Prioridades para revisao

1. **Enriquecer o modelo com tradeoff**: criar circunstancia onde incluir S na coalizao e tentador (valor informacional), gerando exclusao como resultado de equilibrio nao-trivial, nao de dominancia de custo.
2. **Especificar formalmente o conceito de equilibrio e provas**: declarar PBE, especificar crencas on-path e off-path, provar existencia/unicidade.
3. **Analise de robustez**: estados continuos, reconhecimento assimetrico, relaxar commitment.
4. **Fortalecer a aplicacao empirica**: operacionalizar "capacidade informacional", distinguir de explicacoes alternativas (Steinberg 2002).
5. **Adicionar abstract, numeros concretos na intro, e corrigir referencias fantasma** (5 de 11 nao citadas no texto).

## Recomendacao estrategica ao autor

Na forma atual, o paper nao esta pronto para APSR, AJPS ou IO. A contribuicao e insuficiente para esses journals sem enriquecimento significativo. Porem, a ideia central e boa e o framework e promissor. Recomendo:

- **Curto prazo**: submeter a *Journal of Theoretical Politics* ou *Games and Economic Behavior* como nota/short paper, onde a parcimonia e a novidade do mecanismo seriam valorizadas.
- **Medio prazo**: desenvolver a versao "grande" para APSR/IO, com (a) tradeoff endogeno de inclusao/exclusao, (b) endogeneizacao da aquisicao de informacao, e (c) evidencia empirica ou case studies detalhados sobre OMC/CSNU.

---

## Parecer completo — Contribution (Score: 5/10)

### Resumo da contribuicao alegada
O manuscrito introduz "poder informacional" (Bayesian Persuasion) no modelo de Baron-Ferejohn e demonstra tres resultados: (i) sob maioria, o jogador informado e excluido de coalizoes ("Curse of Knowledge"), (ii) sob unanimidade, BP beneficia o informado, e (iii) minorias informadas preferem unanimidade — explicando consenso na OMC.

### Novidade [Adequada / Fraca — no limiar]
O Curse of Knowledge e genuinamente novo e contra-intuitivo. Porem, o mecanismo e relativamente transparente uma vez enunciado (Lemma 1 e uma desigualdade trivial). O resultado sob unanimidade e mais previsivel (extensao direta de Kamenica-Gentzkow). O "reversal" em relacao a Alonso-Camara decorre mecanicamente da mudanca de quem e Sender/Proposer.

### Importancia [Fraca / Adequada — no limiar]
A relevancia depende da credibilidade da aplicacao a OIs, que e estilizada demais (unico Sender, pie binaria). O puzzle "por que consenso?" ja tem explicacoes estabelecidas (Steinberg 2002, Koremenos et al. 2001). As predicoes testáveis sao vagas e dificilmente falsificaveis. Nao ha evidencia empirica.

### Adequacao ao escopo [Questionavel]
Zona de fronteira entre economia e CP. Para APSR/BJPS, audiencia estreita. Para IO, falta profundidade aplicada. Para JOP, falta generalidade teorica.

### Generalizabilidade [Limitada]
Monopolio informacional do Sender, pie binaria, revelation completa no periodo 1, propostas take-it-or-leave-it. Cada suposicao limita a aplicabilidade.

### Trade-offs [Parcial]
Reconhece conflito distributivo (S vs R). Falta analise de eficiencia, endogeneidade da informacao, e mecanismos alternativos de compartilhamento.

### Hipoteses [Claras e direcionais]
Dimensao forte. Proposicoes formais com direcionalidade clara. Mecanismo preciso e logicamente encadeado.

### Sugestoes construtivas
1. Endogeneizar aquisicao de informacao
2. Estender a multiplos Senders
3. Enriquecer aplicacao empirica (case studies OMC)
4. Relaxar estrutura binaria (estados continuos)
5. Dialogo mais profundo com literatura de CP

---

## Parecer completo — Execution (Score: 6/10)

### Tipo de paper: Teorico

### T.1 Distancia premissas-conclusoes [FRACO — 3/10]
O "Curse of Knowledge" segue trivialmente das premissas: S mais caro (desigualdade aritmetica) + exclusao factivel (contagem) = exclusao em equilibrio. Nao ha tensao estrategica genuina. BP e irrelevante sob maioria e relativamente direto sob unanimidade. A interacao BP-regra de votacao, que deveria ser o nucleo, consiste em dois resultados separados que nao interagem de forma rica.

### T.2 Parcimonia [ADEQUADO — 6/10]
Modelo parcimonioso e necessario. Porem, *demasiado* claro: nao ha tradeoff. Nunca e vantajoso incluir S. Modelo poderia ser enriquecido (S traz valor informacional a coalizao).

### T.3 Caminho causal [RAZOAVEL — 6/10]
Logica livre de circularidade. Porem, a afirmacao de que omega e "sempre revelado no Periodo 1" precisa de prova formal mais cuidadosa com especificacao de crencas em cada no.

### T.4 Robustez [FRACO — 4/10]
Nenhuma analise de robustez realizada ou discutida: estados continuos, reconhecimento assimetrico, relaxar commitment, bens publicos.

### T.5 Equilibrio [RAZOAVEL — 5/10]
Conceito de equilibrio nao especificado formalmente. Equilibrios multiplos nao discutidos. Crencas off-path nao especificadas.

### Sugestoes construtivas
1. Enriquecer mecanismo com tradeoff
2. Analise de robustez formal
3. Especificar equilibrio formalmente
4. Aprofundar conexao com BP (design do sinal interagindo com regra de votacao)
5. Tratar revelacao de informacao com mais rigor

---

## Parecer completo — Exposition (Score: 7.5/10)

### Clareza [Boa]
Escrita competente. Titulo longo demais. Sistema de citacao BibTeX nao utilizado (hardcoded). Falta abstract. Falta significancia substantiva (nenhum numero memoravel na intro). Imprecisoes: "informational power is negative" sem definicao previa; "provides a new explanation" linguagem forte demais.

### Extensao [Adequado, com reservas]
Intro muito curta (~1 pagina; top journals pedem 4-6). Secao bilateral ocupa espaco desproporcional. Falta roadmap, motivacao empirica na intro, e apendice.

### Citacoes [Sistematicamente problematicas]
5 de 11 referencias (45%) nao citadas no texto (Bergemann-Morris, Tsebelis, Steinberg, Koremenos et al., Schnakenberg). Faltam referencias fundamentais (Crawford-Sobel, Romer-Rosenthal, Banks-Duggan, Diermeier-Feddersen, Krehbiel, Feddersen-Pesendorfer).

### Sugestoes construtivas
1. Escrever abstract e reescrever intro com numeros e motivacao empirica
2. Corrigir referencias fantasma e adicionar referencias faltantes
3. Condensar secao bilateral
4. Definir "informational power" formalmente na intro
5. Elevar revelacao completa no periodo 1 a Proposicao formal
