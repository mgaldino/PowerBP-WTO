# Registro de revisão externa — Sol 5.6 sobre a emenda M/S/B (v1)

**Data:** 2026-08-29
**Objeto revisado:** v1 de
`quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md`
(draft Fable, untracked em `codex/essential-input` no momento da revisão; o
revisor declarou não ter editado o arquivo).
**Proveniência:** parecer do modelo "Sol 5.6", trazido pelo autor à sessão
Claude Code em 2026-08-29, seguido de uma troca autor–revisor sobre suporte
versus massa pontual. Texto integral abaixo, sem cortes.
**Disposição:** integralmente incorporado na v2 da emenda. Mapeamento:

| Ponto do parecer | Seção da v2 |
|---|---|
| 1. Domínio formal de `nu_off` | §4, "Domínio de aplicação" |
| 2. Retirar "prática padrão" | §4, "Natureza da restrição" |
| 3. Complexidade on-path; `(nu, nu_off)` como teorema | §6, item 3 |
| 4. Vinculação de `nu_off` entre instituições | §4, "Vinculação institucional" |
| 5. Cláusula S: classe anônima + representante uniforme; retirar "herança" | §3 e §7 |
| Existência: sem semicontinuidade superior; rota construtiva | §6, item 1 |
| Assinatura de equivalência downstream | §6, item 2 |
| Literatura: BMM como analogia; Kalandrakis na bibliografia | Referências |
| Troca suporte × massa pontual | §4, item 2 do domínio |

---

## Texto integral do parecer

Sobre a Proposta B
A ideia central é correta: depois de impor que a continuação dependa apenas do posterior, não podemos deixar o posterior fora do caminho variar arbitrariamente com cada proposta. Caso contrário, a arbitrariedade apenas migraria de `kappa_M` para `mu(y)`.
A regra “um único `nu_off` por assessment” tem quatro virtudes:

* elimina exatamente esse disfarce da proposta dentro das crenças;
* é muito menos restritiva que impor sempre `nu_off=nu`;
* preserva as construções explícitas já encontradas;
* reduz uma função arbitrária sobre o espaço de propostas a um escalar interpretável.

Conferi as construções existentes:

* pooling usa `nu_off=nu`;
* separação com acordo dos dois tipos usa `nu_off=0` ou `1`;
* separação com acordo do baixo e atraso do alto usa `nu_off=1`;
* o semipooling construído também usa `nu_off=1`.

Portanto, a afirmação de que os exemplos positivos sobrevivem à cláusula B está correta.
Mas eu faria quatro ajustes.
1. Definir exatamente onde B se aplica
A redação deve usar a definição formal já existente:

* nos pontos disciplinados, vale o limite local de Bayes;
* se o limite deveria existir e não existe, o assessment é inadmissível;
* somente no complemento — quando alguma vizinhança tem massa pública zero — vale `mu(y)=nu_off`.

“Fora do suporte” não é uma descrição suficientemente precisa. Numa distribuição contínua, um ponto pode ter massa individual zero e ainda ser disciplinado porque toda vizinhança tem massa positiva.
2. Não chamar a regra de padrão geral dos jogos de sinalização
Crença constante fora do caminho é uma convenção perfeitamente defensável, mas não é uma exigência comum do PBE. O PBE normalmente permite que crenças variem entre sinais fora do caminho.
Eu a descreveria como:
uma restrição transparente e parcimoniosa de crenças, adotada para impedir que sinais de probabilidade zero funcionem como rótulos arbitrários de punição.
Isso é mais preciso do que “prática padrão”.
3. A cláusula não elimina a complexidade dentro do suporte
B disciplina somente pontos não alcançados. Em estratégias contínuas, todos os pontos do suporte podem ser disciplinados e ter posteriores diferentes.
A própria exploração já contém uma família sem átomos com posterior local variando continuamente. Ela sobrevive à cláusula B porque a variação ocorre no caminho. Nesse exemplo, os payoffs são constantes, portanto isso não causa problema. Mas ainda é preciso provar que toda variação on-path relevante pode ser reduzida à mesma classe de payoffs ou outcomes.
Assim, eu não afirmaria ainda que AMX-015 e AMX-016 ficam completamente indexados apenas por `(nu,nu_off)`. Isso deve ser um teorema a provar, não uma consequência automática da cláusula.
4. Fixar como `nu_off` viaja para a comparação institucional
É preciso dizer se maioria e unanimidade são comparadas:

* usando o mesmo `nu_off`; ou
* permitindo um par `(nu_off^M,nu_off^U)`.

Minha recomendação é usar o mesmo `nu_off` na comparação principal. Caso contrário, parte da diferença atribuída à regra institucional pode vir de convenções distintas de crença fora do caminho. Se quiser preservar a correspondência mais ampla, pode registrar o par, mas destacar a comparação na diagonal `nu_off^M=nu_off^U`.
Sobre a Cláusula M
Aprovo conceitualmente.
Proposta rejeitada e vetor de votos não alteram o jogo que começa depois da rejeição, exceto pela informação contida no posterior. Permitir que esses detalhes escolham continuações diferentes cria punições baseadas em eventos sem efeito econômico futuro.
Essa é precisamente a motivação markoviana: estratégias devem depender de estados relevantes para payoffs e possibilidades futuras, não de toda a história. A justificativa está alinhada com Maskin e Tirole.
Eu apenas escreveria a fatoração de forma mais explícita: phi_g(h) = (instituição g, nó/estágio da continuação, posterior público mu(h))
kappa_g(h) = kappa_hat_g(phi_g(h))

Os parâmetros fixos — `N`, `beta`, opções externas e quota — ficam implícitos no jogo, mas devem aparecer na definição do estado suficiente ou numa frase imediatamente posterior.
A motivação de Baron–Ferejohn também está correta: eles mostram que estratégias históricas complexas podem sustentar praticamente qualquer divisão e então concentram a análise em equilíbrios estacionários com maior poder preditivo. Baron e Ferejohn (1989).
Sobre a Cláusula S
Aprovo o princípio de tratamento igual dos Estados fracos, mas reescreveria sua implementação.
“Simétrico”, “balanceado” e “cíclico” não são exatamente a mesma coisa:

* o membro cíclico dá a todos a mesma frequência marginal de inclusão;
* mas sua estrutura de coalizões depende de uma ordenação artificial dos nomes;
* várias outras loterias também são balanceadas e produzem os mesmos payoffs.

A solução mais limpa seria selecionar uma classe de equivalência anônima de payoffs, não afirmar que a simetria escolhe literalmente o membro cíclico.
Como representante literal, eu usaria:
quando um fraco é reconhecido, seus parceiros são sorteados uniformemente entre todas as coalizões admissíveis do tamanho necessário.
Isso é genuinamente invariável a permutações dos nomes. O membro cíclico pode continuar como uma implementação computacional equivalente.
Também retiraria a frase de que a extensão “herda a leitura simétrica existente” do baseline. O `C_M` congelado preserva multiplicidade de coalizões e declara expressamente que não impõe uma seleção simétrica. S é uma nova escolha para a extensão — defensável, mas nova.
Sobre o lema de existência
Aqui está a correção técnica mais importante: M/S/B não tornam necessariamente o payoff do hegemon semicontínuo superior.
Exemplo simples: no limite em que uma oferta passa, o hegemon recebe o restante do bolo. Em ofertas ligeiramente menores, a proposta é rejeitada e ele recebe a continuação. Se a continuação valer mais que o acordo no limite, há um salto para baixo exatamente na fronteira de aceitação. Isso viola semicontinuidade superior.
Felizmente, existência ainda pode ser demonstrada por outro caminho:

* o melhor acordo é atingido porque o conjunto de ofertas aceitas, incluindo a indiferença, é fechado;
* o payoff de rejeição também é atingido por propostas claramente rejeitadas;
* o hegemon escolhe o maior entre o melhor acordo atingível e a rejeição atingível.

Portanto, eu substituiria:
“As cláusulas tornam o problema semicontínuo superior…”
por:
“As cláusulas removem a dependência diagonal dos preços em relação à proposta e devem permitir uma prova construtiva de atingimento, comparando o melhor acordo factível com uma rejeição deliberadamente induzida. A existência permanece obrigação de prova.”
Sobre o reescopo de AMX-014–016
A direção é boa: não precisamos enumerar estratégias diferentes que geram exatamente o mesmo resultado econômico.
Mas “equivalência de payoffs” pode ser estreita demais. Dois equilíbrios podem gerar os mesmos payoffs esperados e diferir em:

* probabilidade de acordo imediato;
* probabilidade de atraso;
* revelação do tipo;
* distribuição das parcelas;
* resultado consumido posteriormente por `AC` ou `AR`.

Eu definiria uma assinatura de equivalência downstream suficiente, contendo pelo menos:
payoffs por tipo de H;
payoffs dos fracos;
probabilidade de acordo e atraso por tipo;
resultado/alocação terminal por tipo;
posterior nos sinais alcançados.

Só perfis com a mesma assinatura seriam identificados. Depois pode-se provar que algumas coordenadas são redundantes.
Sobre a literatura
A fundamentação geral é boa, com duas ressalvas:

* O resultado de Bhaskar, Mailath e Morris trata jogos de horizonte infinito, memória social finita e purificação. É uma analogia útil, mas não uma fundação direta para esta restrição num jogo finito.
* Kalandrakis (2006) é mencionado no texto, mas falta na bibliografia. O provável trabalho é “Proposal Rights and Political Power”. Ele reforça a importância das regras de proposta e dos equilíbrios estacionários, mas não prova a cláusula B.

Recomendação final
Entre as alternativas que estavam na mesa, prefiro claramente M–S–B a:

* discretizar artificialmente as propostas;
* restringir suportes de mistura;
* trocar PBE exato por `epsilon`-equilíbrio;
* impor apenas continuidade abstrata.

Minha recomendação é aprovar a direção, mas revisar o texto antes do aval terminal, com cinco mudanças:

1. definir formalmente o domínio de aplicação de `nu_off`;
2. decidir como `nu_off` é vinculado entre maioria e unanimidade;
3. substituir “membro cíclico canônico” por anonimidade de payoffs com representante uniforme;
4. remover a alegação antecipada de semicontinuidade;
5. substituir equivalência simples de payoffs por equivalência suficiente para `AC` e `AR`.

Com essas correções, considero a emenda economicamente defensável, tecnicamente bem direcionada e proporcional ao problema. Ela não parece overengineering: elimina duas liberdades que produziram resultados sem conteúdo econômico, mantendo intactas as regras substantivas de proposta, voto, informação e continuação.

---

## Troca autor–revisor sobre suporte × massa pontual

**Comentário do autor:** "“Fora do suporte” não é uma descrição suficientemente
precisa. Numa distribuição contínua, um ponto pode ter massa individual zero e
ainda ser disciplinado porque toda vizinhança tem massa positiva." Se a massa é
zero nao quer dizer fora do suporte. O suporte da normal é os reais, ainda que
cada ponto tenha massa zero. No mais, bons pontos.

**Resposta do Sol 5.6:**
Exatamente — estamos de acordo. A distinção correta é:

* Massa do ponto: pode ser zero.
* Pertencer ao suporte: toda vizinhança do ponto tem massa positiva.
* Ponto não disciplinado no contrato: existe alguma vizinhança relativa com massa pública zero.

Na normal, cada ponto tem massa zero, mas todos os reais pertencem ao suporte e são disciplinados pela regra local de Bayes.
Portanto, a emenda deve evitar “fora do suporte” como sinônimo de “massa pontual zero” e conservar a formulação por vizinhanças.
