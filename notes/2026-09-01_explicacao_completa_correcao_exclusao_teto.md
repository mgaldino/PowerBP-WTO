# Explicação completa da correção de 2026-09-01 (exclusão, teto, Fundamentos)

Escrita para o Manoel de daqui a seis meses, sem jargão. Registro formal:
`quality_reports/2026-09-01_decisao_exclusao_payoffs_e_fundamentos.md`.

## ATUALIZAÇÃO — emenda do mesmo dia (ler antes do resto)

Depois de escrita esta nota, você questionou a regra "a fatia volta ao
proponente" (faltava justificativa: por que o redator embolsaria a concessão
não usada de terceiro?) e ela foi TROCADA por: **a fatia reservada a H não é
paga a ninguém quando H fica fora, porque a concessão é específica a H e não
pode ser transferida**. Quando isso acontece, a soma distribuída fica abaixo
de 1 — o que não contradiz o bolo fixo, pois bolo fixo significa "soma ≤ 1"
mais "em equilíbrio o bolo é exaurido", e essa situação nunca ocorre em
equilíbrio.

Segunda mudança importante: você determinou que **provas só mudam pelo
processo editorial de provas** (outro agente implementa, revisão formal
independente). Por isso as edições da manhã nas provas B.1 e B.3 (B.1 =
prova da Proposição 1, o benchmark com tipo conhecido; B.3 = prova da
Proposição 3, maioria com tipo privado) foram DESFEITAS — as provas voltaram
ao texto anterior à sessão, que ainda menciona a regra antiga da soma.
**Portanto o manuscrito está temporariamente inconsistente: a definição do
jogo usa a regra nova, e dois passos das provas B.1/B.3 mencionam a antiga.
Não circular nem submeter até o processo de provas rodar.** O texto candidato
para as provas está na emenda do registro formal. As partes 3 (itens 5 e 6) e
o final da Parte 1 desta nota descrevem o estado da manhã e estão superadas
no que diz respeito à reversão.

## O que aconteceu, em três frases

Você encontrou duas regras erradas na definição do jogo: (1) um hegemon
excluído do acordo recebia a fatia proposta MAIS a outside option, somadas; e
(2) existia um teto arbitrário sobre quanto uma proposta podia dar ao hegemon.
Decidimos: payoffs mutuamente exclusivos (ou fatia, ou outside option, nunca
ambos) e deleção do teto. Pela minha análise nenhum resultado matemático muda
— mas essa análise é minha e AINDA PRECISA de conferência independente.

## Parte 1 — O erro grave: o que um hegemon excluído recebe

**Como era.** Se os fracos aprovassem um acordo por maioria sem o voto do
hegemon, e a proposta tivesse reservado uma fatia x_H para ele, o hegemon
recebia a fatia E MAIS a outside option. Somava as duas.

**Por que era errado.** Ou você está dentro do acordo (recebe sua fatia) ou
está fora (recebe o valor da sua alternativa). Somar não corresponde a nada:
o jogo divide um bolo fixo, sem externalidades nem bens públicos — não existe
nada em que um não-membro possa "pegar carona". (Eu tentei defender a soma
com uma analogia de free-riding/MFN; você refutou e eu retirei: free-riding
exige benefício não-excludável, e fatia de bolo é transferência privada.)

**De onde veio.** Decisão D1 de 2026-08-12, dentro de um lote de 8 decisões
do Gate 0. Ela reverteu uma proibição explícita do plano de 2026-08-03
("nunca somar y com o no mesmo histórico") SEM se anunciar como reversão.
Foi proposta por agente, consolidada em commit coassinado por Claude Opus, e
aprovada por você no lote — sem que a implicação ficasse visível. O defeito
de processo: reversão silenciosa de uma restrição, embrulhada como escolha
neutra de contabilidade.

**Como ficou.** Mutuamente exclusivos. Votou sim e a proposta passou → é
parte do acordo, recebe a fatia. Votou não e a maioria passou sem ele → está
fora, recebe só a outside option; a fatia que a proposta reservava para ele
volta para o residual do proponente. Por que "volta para o proponente" e não
outra coisa: o bolo é fixo (destruir a fatia faria o bolo encolher), e um
não-membro não pode reclamar fatia de acordo que não assinou — o que sobra
fica com quem é o dono do residual, o proponente.

**Por que (quase) nada muda na matemática.** Em TODOS os equilíbrios em que
a maioria exclui o hegemon, o proponente já reservava fatia ZERO para ele —
dar fatia a quem não é necessário é jogar dinheiro fora. Então a soma errada
nunca acontecia no caminho de equilíbrio; ela só descrevia jogadas
hipotéticas que ninguém joga (propostas dominadas que, se aprovadas, encerram
o jogo — sem efeito sobre crenças nem continuações). Corrigir a regra muda a
descrição dessas jogadas hipotéticas, não os resultados.

**ONDE O MESMO ERRO PODE VOLTAR — o que a revisão independente tem de
conferir.** A afirmação "nada muda" é MINHA (Fable). Três pontos exatos:

1. A regra de voto do hegemon quando o voto dele não decide nada mudou: antes
   era "sempre não" (porque não dava fatia+outside); agora é "sim se a fatia
   ≥ outside option, não caso contrário". Com fatia zero dá o mesmo "não" —
   mas alguém tem de varrer os registros e confirmar que nenhum usa a regra
   antiga num ponto em que a fatia é positiva.
2. A reversão cria propostas diferentes com payoffs idênticos para todo mundo
   (reservar fatia 0.1 que reverte = reservar fatia 0). Adotamos a convenção
   de reportar a versão com fatia zero. Conferir que a linguagem de "único
   equilibrium outcome" nas proposições (prop:terminal, prop:majority)
   continua correta com essa convenção de reporte.
3. Varrer as provas por qualquer uso remanescente da soma (a varredura por
   grep deu limpa, mas grep não lê matemática).

## Parte 2 — O segundo erro: o teto sobre a fatia do hegemon

**Como era.** Um parâmetro (chamado y_bar no baseline, \bar x_H na extensão)
dizia que nenhuma proposta podia dar ao hegemon mais do que certo limite.

**Por que era errado.** Em Baron–Ferejohn, a referência do paper, o
proponente pode propor qualquer divisão, inclusive o bolo inteiro para si.
Teto arbitrário não tem justificativa e não veio de decisão substantiva —
entrou no contrato Gate 0 de 2026-08-12 e ninguém o questionou.

**A descoberta que facilitou tudo.** O teto nunca fez nada: (a) nenhuma
proposição ou prova do manuscrito o usa; (b) nos artefatos congelados do
baseline ele aparece só em declarações de domínio; (c) as derivações
congeladas da extensão de agenda foram feitas SEM teto — e, se o teto fosse
levado a sério, ele CONTRADIRIA as fórmulas da extensão para desconto pequeno
(o hegemon proponente ficaria com mais do que o teto permite). Ou seja:
deletar não foi só permitido, foi obrigatório para a coerência.

## Parte 3 — As oito edições no manuscrito, uma a uma

Todas em `formal_model_v6.Rmd`; PDF recompilado sem erros depois delas.

1. **Definição do espaço de propostas** (seção The model): saiu
   "0 ≤ x_H ≤ teto"; ficou "x_H ≥ 0, x_j ≥ 0, soma ≤ 1". E saiu a frase que
   definia o domínio do teto.
2. **Parágrafo do que acontece quando uma proposta passa** (mesma seção):
   reescrito. Antes explicava a soma ("a fatia é implementada mesmo sem a
   aprovação de H"). Agora diz: as alocações valem para as partes do acordo;
   H que votou não recebe a outside option e a fatia não-reclamada vai para o
   residual do proponente; payoffs de acordo e desacordo são mutuamente
   exclusivos em todo histórico.
3. **Tabela-resumo do protocolo** (Transitions and payoffs): a célula
   "proposta passa / H vota não" mudou de "x_H + o" para "o", e a coluna dos
   fracos anota que, após um não de H, o proponente também recebe a fatia
   revertida.
4. **Apêndice A.1** (regras completas): mesma correção, mais a convenção de
   reporte — propostas que só diferem numa fatia que reverte são equivalentes
   e reportamos a representante com fatia zero. O parágrafo antigo que
   defendia a soma ("necessary for a complete strategy specification") foi
   substituído.
5. **Prova B.1** (benchmark de informação completa, maioria terminal): o
   passo "H vota não porque não dá x_H+o" virou "sim dá x_H, não dá o; fatia
   abaixo de o induz não e equivale a fatia zero via reversão; fatia ≥ o
   induz sim e é pior para o proponente; logo exclusão de equilíbrio tem
   fatia zero e H recebe o".
6. **Prova B.3** (maioria com informação privada, Rodada 1): o caso em que os
   fracos têm votos suficientes sem H foi reescrito com a nova regra de voto
   (sim sse x_H ≥ o) e a reversão. As quatro classes de proposta (exclusão,
   screening, pooling, atraso) e todos os payoffs ficaram como estavam.
7. **Apêndice E.1** (contrato da extensão de agenda): o teto saiu do vetor de
   parâmetros.
8. **Notação (Apêndice D) e worked values (Apêndice E)**: linha do teto
   deletada da tabela de notação; teto removido do exemplo numérico (que
   nunca o usava de fato).

O que NÃO foi tocado: nenhuma proposição, fórmula de resultado, tabela de
resultados ou figura; nenhum artefato congelado em `model_redesign/` (as
correções sobre eles são "erratas de leitura" no registro de decisão, bytes
intactos — mesmo padrão da errata N2 de agosto).

## Parte 4 — Os Fundamentos invioláveis (o conserto de processo)

**Por que existem.** O erro da soma entrou porque o "óbvio" não estava
escrito como regra: BF aparecia como item de bibliografia, "recebe só a
outside option" estava numa nota histórica marcada "a rederivar", e a única
frase com força de norma ("outside option externa à pie") era satisfeita pela
soma errada. O óbvio não escrito perde para o racional escrito.

**O que são.** Um bloco no topo de CLAUDE.md e AGENTS.md (PT/EN espelhados)
com 8 itens e 2 regras de operação. As regras: (1) todo agente checa qualquer
proposta de mudança de regra do jogo contra a lista ANTES de escalar — o que
viola um item não é "opção a discutir", é violação a reportar; (2) reverter
um item exige dizer explicitamente "isto reverte o fundamento #k", fora de
lote, com sua assinatura individual.

**Os 8 itens, em linguagem simples**:
1. De BF/Kalandrakis herdamos o PROTOCOLO (quem propõe, como se vota,
   rodadas, desconto) e o benchmark de simetria. A estrutura de desacordo é
   escolha nossa, declarada — BF tem tudo zero e não decide nada ali.
2. Comparação é só unanimidade vs. maioria, mesma economia.
3. Um único ator informado (H); fracos simétricos e sem informação privada.
4. Ou fatia ou outside option, nunca ambos. Fatia de não-membro reverte ao
   proponente. (O erro corrigido hoje.)
5. Nenhum teto ou restrição a propostas além de não-negatividade e soma ≤ 1.
   (O outro erro corrigido hoje.)
6. Bolo fixo em 1; outside option de H fora do bolo e microfundada por forum
   shopping (valor privado do melhor fórum alternativo: bilaterais, OMPI,
   coalizão própria); fracos têm outside option zero porque não têm
   alternativas; π_H=0 e b_θ=0 no baseline.
7. Escopo: acordos distributivos de clube dentro da OI. Decisões que vinculam
   todos os membros (orçamento da AGNU, quotas do FMI) estão fora.
8. Jogo distributivo puro: sem externalidades, bens públicos ou free-riding.
   Argumento que dependa de alguém se beneficiar de acordo do qual não é
   parte é violação, não opção.

## Parte 5 — As discussões da sessão que fundamentam as escolhas

- **Forum shopping** é a justificativa da outside option do excluído: H já é
  membro da OI quando barganha (por isso descartamos "tratado não vincula
  terceiros" — confunde membership da OI com participação no acordo); o que
  ele faz ao ficar fora do pacote é ir a outro fórum. Seus exemplos: acesso a
  mercado via bilaterais; propriedade intelectual via OMPI; Iraque via
  coalition of the willing (mais caro que via CSNU, mas não zero — o
  contraste com a Rússia na Ucrânia, que não monta coalizão nenhuma).
- **Seu exemplo do orçamento** derrubou a ideia de que "em BF o proponente
  não altera o status quo dos rejeitados": com reversão orçamentária, o
  orçamento aprovado substitui o status quo de TODOS — o excluído fica com
  zero. É por isso que o item 1 dos Fundamentos herda de BF só o protocolo.
- **Os papers vizinhos** (verificados na fonte): no da Public Choice, a
  reforma aprovada vincula todo mundo — quem votou não ainda paga seu custo
  (pode ficar ABAIXO do status quo); no do GEB, o breakdown value só existe
  quando nada é aprovado. Nenhum soma nada; e nenhum tem a sua convenção de
  clube. A sua convenção é diferente dos dois DE PROPÓSITO (soberania /
  forum shopping) e é load-bearing: com a convenção deles, H excluído
  receberia zero e o resultado "tipo forte prefere maioria" desapareceria.

## Parte 6 — O que ainda falta (pendências abertas)

1. **Revisão independente do candidato** com os 3 itens de verificação da
   Parte 1 (mais o item da decisão de structural consistency do início do
   dia). Nada do que fiz hoje vale como aval — quem analisa não revisa.
2. **Manuscript pass** autorizado mas não executado: frase de escopo
   clube-vs-vinculante na seção do modelo; parágrafo de forum shopping
   (ligando a Fearon 1995 — tipo = valor privado do caminho externo);
   ressalva em Limits (outside option assumida invariante ao acordo dos
   outros — sem desvio de comércio); remark do isomorfismo com tipos de custo
   de aceitação (idênticos na margem de aceitação, diferentes no valor de
   exclusão — onde vivem os resultados); checar bibliografia (Voeten 2001,
   Helfer 2004, Busch 2007, Alter–Meunier 2009, Raustiala–Victor 2004,
   Morse–Keohane 2014, Lipscy 2017).
3. **"I show that" da introdução continua vazio** (linha ~113 do Rmd).
