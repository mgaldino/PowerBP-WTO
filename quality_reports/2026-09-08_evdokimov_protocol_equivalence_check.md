# Verificação focal: coalizão-alvo e equivalência econômica do baseline

**Resultado:** não encontrei contraexemplo à equivalência dos conjuntos de distribuições de **aprovação/fracasso, data, vetor de transferências e payoffs por tipo**, projetando a coalizão-alvo `C` e os votos. A redução local funciona para o baseline especificado de duas rodadas. A referência de Evdokimov legitima a representação institucional, mas a equivalência neste ambiente depende da derivação abaixo, não de importar automaticamente seus resultados.

Revisor: `/root/architecture_reader_2`, 2026-09-08. Verificação independente solicitada pelo coordenador; nenhum subagente lançado. Não foram editados manuscritos, candidatos ou contratos. O benchmark é `G_0`, o jogo histórico com cancelamento; a análise não adota esse pagamento no novo jogo nem trata `G_*`, ainda incompleto, como benchmark resolvido.

## Fontes e objeto comparado

- Evdokimov, *Equality in Legislative Bargaining*, JET 212 (2023), 105701, seção 2.1, páginas 6–7; texto local `PowerPieDependent/references/extracted/evdokimov_2023_equality_in_legislative_bargaining.txt`, linhas 279–329, SHA-256 `7efe0953e16bab0f71c15ea46814a9a5aa4d606e4d73b25e6346d78680bb392c`.
- `git show main:toy_model.md` em `PowerPieDependent`, protocolo nas linhas 107–175. `main=6217bde5527c04e6608c571ad8341abd4b423efd`; SHA-256 desse conteúdo: `4e093705675d22869db3a5996827bb9a4df2ba939fa341da6bdc804fee5eebc6`.
- Baseline histórico: `formal_model_v6.Rmd`, apêndices A.1–A.2 e B.1–B.4, SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`, lido com as decisões vigentes sobre crenças e votação.

No novo jogo considerado, um fraco propõe `(C,x)`, com o proponente em `C`, `|C|>=q` e alocações não negativas somente para `C`, somando no máximo um. Apenas convidados votam, e todos precisam consentir. Em acordo implementado, H recebe `x_H` se pertence a `C` e `o` se está fora; fracos fora recebem zero. Fracasso em R1 gera somente continuação; fracasso em R2 dá zero aos fracos e `o` a H. Mantêm-se reconhecimento uniforme dos fracos, tipos `0<ell<h<1`, prior, `0<beta<1`, votos puros, `T^Y`, crenças aprovadas e o desempate do proponente que minimiza o payoff esperado de H. Não há execução adicional.

## O que Evdokimov efetivamente estabelece

A seção 2.1 define coalizões vencedoras com pelo menos `q` membros, permite coalizões superdimensionadas, exige que a coalizão proposta contenha o proponente e requer consentimento simultâneo de todos os seus membros. Nas linhas 321–329, afirma a equivalência com votação universal por quota **dada sua função de excedente**, explicando que pagamentos de continuação identificam implicitamente os parceiros.

Há duas qualificações relevantes. Primeiro, seu ambiente tem informação completa, horizonte indefinido, probabilidades positivas de reconhecimento para todos e excedente produtivo dependente da coalizão. Não é o baseline privado de duas rodadas de PBP. Segundo, sua definição factível usa `x` em todo `N`, soma das alocações sobre `N` e pagamento a cada jogador; não impõe textualmente `x_j=0` fora de `C` no espaço de propostas (linhas 293–312). O suporte restrito a `C` é explícito no `toy_model.md` local e na candidata aqui avaliada. Esse arquivo também declara a coalizão-alvo como primitiva própria e adverte que membros externos não fornecem votos gratuitos (linhas 117–132).

Portanto, a leitura correta é adotar uma representação inspirada na referência e verificar sua equivalência econômica neste domínio. Não se importam sua tecnologia, seu conceito estacionário, a opção explícita de passar, seus resultados distributivos ou uma equivalência universal entre jogos.

## Redução local: R2 antes de R1

Use a notação de PBP: `m>=3` fracos, `k=floor((m+1)/2)` e quota majoritária `q=k+1<=m`.

**Maioria em R2.** Cada fraco convidado aceita zero. Existe uma coalizão vencedora somente de fracos, e a proposta `x=e_i` dá um ao proponente e zero aos demais. Nenhuma proposta pode dar mais que um. Qualquer acordo com H convidado exige `x_H>=o>0` e reduz o residual; qualquer outra parcela positiva ou sobra também impede atingir um. Assim, toda escolha ótima econômica é `e_i`, H fica fora e recebe `o`, e cada fraco tem valor ex ante `1/m`. `C` pode ser qualquer subconjunto vencedor de fracos que contenha `i`; essa multiplicidade custa zero e não altera o vetor econômico.

**Maioria em R1.** As continuações são `w=beta/m` para cada fraco e `beta o` para H. Um convidado fraco aceita exatamente quando `x_j>=w`. Como `w>0`, cada parceiro fraco adicional num acordo possível custa estritamente ao proponente. Se H é convidado e os demais convidados aceitam, é necessário ao acordo e aceita exatamente quando `x_H>=beta o`. Se algum convidado fraco rejeita, a proposta fracassa; isso não cria um recebimento corrente de H.

Uma proposta com probabilidade positiva de aprovação permite retirar convidados fracos excedentes e transferir suas parcelas ao proponente, preservando quota, aceitação por tipo e continuação após rejeição. O ganho esperado é estrito. Se a proposta fracassa com probabilidade um, vale apenas `w`. A exclusão mínima paga `w` a `k` fracos e dá

\[
\Pi_E-w=1-\beta(k+1)/m>0.
\]

Logo, propostas certamente rejeitadas, inclusive as sustentadas por vetos de fracos convidados a zero, não são ótimas. Convidar H junto com `k` ou mais respondedores fracos também não melhora a escolha: em aprovação o residual está abaixo da exclusão, e em rejeição vale `w<\Pi_E`.

Restam os mesmos candidatos factíveis do histórico:

\[
\begin{aligned}
\Pi_E&=1-kw, & \mathbf U_H^E&=(\ell,h),\\
\Pi_S&=(1-p)[1-(k-1)w-\beta\ell]+pw,
 &\mathbf U_H^S&=(\beta\ell,\beta h),\\
\Pi_P&=1-(k-1)w-\beta h,
 &\mathbf U_H^P&=(\beta h,\beta h),\\
\Pi_D&=w, &\mathbf U_H^D&=(\beta\ell,\beta h).
\end{aligned}
\]

Ofertas intermediárias a H podem ser reduzidas a `beta ell` ou `beta h`, preservando o conjunto de tipos que aceita. Se esse conjunto tiver probabilidade zero, a proposta já é dominada pela exclusão. Assim, o argumento não depende de dar peso artificial a tipos de posterior zero.

Os valores primários e os vetores de H são os mesmos; consequentemente, o desempate secundário e as misturas permitidas entre candidatos empatados preservam as mesmas distribuições econômicas. As identidades dos fracos recrutados e os pesos conjuntos devem ser mantidos na comparação; não basta comparar médias marginais de H.

**Unanimidade.** `q=m+1` força `C=N`. O espaço de alocações, os convidados, a votação e as continuações são os do baseline unânime histórico. Não há nova atividade de execução. Portanto seu jogo de barganha, inclusive as condições de existência e eventuais células vazias, é preservado. Isso transporta a caracterização histórica se correta; não constitui uma nova auditoria integral de B.4.

## Crenças, fronteiras e alcance da equivalência

`C` e `x` são escolhidos por um proponente sem informação privada; nenhum dos componentes sinaliza o tipo. H não convidado não realiza uma ação informativa. Quando é convidado, screening conserva os votos por tipo e Bayes onde o denominador é positivo. Liberdades em denominadores zero continuam no suporte do prior inicial e locais à votação pertinente. Sob maioria, as duas continuações de R2 são independentes dessas crenças; sob unanimidade, `C=N` mantém a disciplina inteira. `T^Y` é necessário para fechar os limiares exatos, inclusive ofertas zero em R2.

O limite sobre `C` é concreto: com `m=4`, `q=3` e `x=e_i` em R2, tanto uma coalizão de três fracos quanto `C=W` são ótimas no novo jogo. A votação universal histórica prescreve sim a todos os fracos. Portanto não há equivalência de membership nominal, embora aprovação, data, alocação e payoffs coincidam. Essa diferença foi explicitamente aceita pelo coordenador como parte da projeção econômica e não invalida o argumento do autor.

Também não há equivalência de todos os desvios: convidar H com parcela positiva e obter sua rejeição agora faz o pacote fracassar, mesmo quando um subconjunto de fracos bastaria na votação universal. Essa é a alteração institucional deliberada. O argumento exige que tais propostas não gerem novos ótimos econômicos, o que a redução acima estabelece; não exige restaurar cancelamento ou somar alocação e opção externa.

**Conclusão focal:** a equivalência econômica projetada é sustentada pela redução local, sem defeito confirmado no domínio especificado. Não certifico equivalência de estratégias, votos, rótulos de coalizão, payoffs em toda história ou a extensão de agenda. Nesta última, H proponente pode usar `C` como mais um componente público da proposta informativa, exigindo análise própria. Esta foi uma verificação analítica; não foram executados novos testes numéricos nem alterados candidatos ou manuscritos.
