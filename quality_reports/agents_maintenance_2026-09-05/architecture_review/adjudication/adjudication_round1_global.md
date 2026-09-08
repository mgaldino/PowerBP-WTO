# Adjudicação: exclusão e obrigação de prova

Veredicto: `BLOCKED`. Registro: `pbp-architecture-clarification:695069a7b432:round1-global`.

## Fonte e escopo

Artefato principal: `/private/tmp/pbp-architecture-clarification-2026-09-05/before/AGENTS.md`.
SHA-256: `695069a7b432a3204f43619931c211c8327f8533b30d3cfa969e42bba3806522`.

Diagnóstico estreito da regra de payoff e de sua obrigação de prova, conforme o mandato recebido. Não é uma revisão integral do argumento ou do manuscrito.

A transcrição literal da correção autoral está em `/private/tmp/pbp-architecture-clarification-2026-09-05/review_sources/author_correction.md`, SHA-256 `69cb27404295c3f3466222a6d61edd13896978c6f70159db2a58aecf8e3128a9`. O JSON preserva a transcrição e distingue dela o resumo do mandato.

As identidades adicionais e os hashes dos pareceres constam no JSON e em `identity_checks.json`. Todos os inputs selecionados conferiram com os snapshots.

## Encaminhamento

- R1-F004 é material e permanece não resolvido: nenhuma arquitetura alternativa completa foi especificada e verificada para cumprir todo o requisito.
- A integridade das fontes foi confirmada. O bloqueio é substantivo e limitado à conclusão sobre a arquitetura.
- A correção de instruções é independente: um record delimitado mantém a pendência e autoriza tecnicamente apenas a marcação de status e a obrigação de prova.

## Findings

| ID | Status | Objeto | Correção proposta |
| --- | --- | --- | --- |
| R1-F001 | CONFIRMED | A regra contestada ainda aparece como primitiva | safe |
| R1-F002 | CONFIRMED | A dominância é condicional e antecede a votação | needs_design |
| R1-F003 | CONFIRMED | O voto de H fora do caminho depende do payoff disputado | needs_design |
| R1-F004 | UNRESOLVED | A arquitetura que satisfaz todo o requisito ainda não está estabelecida | needs_design |
| R2-F001 | CONFIRMED | Rejeição certa e rejeição de alguns tipos são condições distintas | safe |
| R2-F002 | CONFIRMED | Dois sentidos de fora do caminho e tipos de probabilidade zero | safe |
| R2-F003 | CONFIRMED | O lema terminal é independente do payoff disputado de H | safe |
| R2-F004 | CONFIRMED | Desperdício exige preservação da aprovação e ganho estrito | safe |
| R2-F005 | CONFIRMED | A instrução deve exigir uma demonstração e manter a pendência visível | safe |

As contagens referem-se a nove observações normalizadas, incluindo limites de prova e um resultado auxiliar. Não significam oito defeitos distintos do manuscrito.

## R1-F001: A regra contestada ainda aparece como primitiva

Status: `CONFIRMED`. Tipo: `scope_or_consistency`. Severidade: `major`. Dimensão: `mechanism_and_instruction_fidelity`.

Fonte: R1, linhas 5–7. Decisão mantida do autor: sim.

Texto do parecer:

> A exigência nova ainda não está demonstrada pelas provas atuais. Elas demonstram a escolha ótima `x_H=0` quando os votos fracos bastam, mas definem previamente o pagamento de H após votar não como `o`, cancelando `x_H`.
> 
> 1. **A vedação está nas primitivas.** O manuscrito (`formal_model_v6.Rmd:340`) diz que, após aprovação com voto não de H, sua fatia não é paga a ninguém; a Appendix A (`formal_model_v6.Rmd:1385`) repete a regra para todas as histórias. O memorando de derivação (`quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:24`) a identifica expressamente como input. Portanto, não se pode apresentar essa exclusividade em toda história como conclusão de racionalidade.

Localizadores: AGENTS.md:21,27,33,39; formal_model_v6.Rmd:340-348,1385-1397; quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:24-32.

Evidência:

- AGENTS.md:21 determina o recebimento de o_theta sem x_H e o não pagamento da fatia; a frase final afirma que H nunca recebe ambos.
- O manuscrito define essa regra antes das provas, e o memo a lista no mandato como correção de payoff recebida como input.
- review_sources/author_correction.md:5 exige sustentação pela arquitetura e pelos incentivos e contesta essa solução por estipulação.

Há incompatibilidade entre o caráter inviolável dado à regra no AGENTS e o mandato atual. Isso não demonstra que as provas antigas sejam internamente falsas no jogo que especificam. Demonstra que usar esse input como evidência do novo requisito seria circular. A transcrição literal da correção autoral foi preservada como fonte adicional.

Encaminhamento: Atualizar apenas as instruções e a nota de estado: identificar a antiga regra como contestada e registrar a obrigação de prova. Preservar manuscrito, contratos e candidatos históricos; não instalar uma nova função de payoff.

## R1-F002: A dominância é condicional e antecede a votação

Status: `CONFIRMED`. Tipo: `logic_or_proof`. Severidade: `major`. Dimensão: `mechanism_and_scope`.

Fonte: R1, linhas 9–15. Decisão mantida do autor: não.

Texto do parecer:

> 2. **O resultado efetivamente derivado é mais delimitado.** Em B.1 (`formal_model_v6.Rmd:1429`) e B.3 (`formal_model_v6.Rmd:1479`), cada fraco vota por um limiar próprio, independente de `x_H` e das crenças: zero na rodada terminal, `β/m` na primeira. Se já há votos fracos suficientes, trocar a proposta por
> 
>    `x'_H=0`, `x'_i=x_i+x_H`, `x'_j=x_j` para `j≠i,H`
> 
>    preserva os votos fracos e a aprovação e aumenta estritamente o pagamento do proponente. Isso elimina `x_H>0` das propostas ótimas dessa classe. Trata-se de outra proposta escolhida antes da votação; não é devolução automática de uma fatia após a votação.
> 
> 3. **A dominância tem uma parte aproveitável sem a vedação.** O ganho do proponente decorre de ele receber `x_i` sob a proposta original e `x_i+x_H` sob a alternativa. Esse cálculo, por si só, não exige cancelar o pagamento de H quando este vota não. O lema atual (`quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:86`) descreve a regra de cancelamento, mas seu argumento de escolha ótima pode ser reconstruído com outra regra completa de payoffs, desde que os votos fracos e sua continuação permaneçam independentes da mudança proposta. Isso precisa ser verificado novamente a partir da rodada terminal.

Localizadores: formal_model_v6.Rmd:1429-1443,1479-1499; quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:73-118.

Evidência:

- A prova fixa a classe em que pelo menos k respondedores fracos aprovam, mantém suas alocações e muda a proposta para x_H=0 e x_i+x_H.
- O ganho x_H usa o pagamento do proponente e a preservação da aprovação. Não equivale a uma transferência automática após o resultado da votação.
- Em R1, a independência dos votos fracos usa a continuação terminal 1/m; portanto, reaproveitar o argumento depende de preservar ou rederivar essa interface.

O parecer descreve corretamente uma parte condicional reaproveitável: a identidade do ganho não precisa do payoff específico de H quando o pagamento do proponente e a aprovação são mantidos. Não há aqui validação de uma arquitetura alternativa completa nem licença para transplantar seus resultados de R1. A comparação ocorre entre propostas factíveis antes do ballot.

Encaminhamento: Reter como evidência delimitada e como requisito para uma derivação futura. Não confundir a alteração da proposta com reversão automática da fatia.

Checagens: mechanical_checks.json:C1_reallocation.

## R1-F003: O voto de H fora do caminho depende do payoff disputado

Status: `CONFIRMED`. Tipo: `logic_or_proof`. Severidade: `major`. Dimensão: `implementation_fidelity_and_mechanism`.

Fonte: R1, linhas 17–17. Decisão mantida do autor: não.

Texto do parecer:

> 4. **As respostas completas de H dependem da arquitetura rejeitada.** O limiar não pivotal `x_H≥o` vem diretamente de comparar `u_H(Y)=x_H` com `u_H(N)=o`. Se uma arquitetura alternativa permitisse, na história desviante, `u_H(N)=x_H+o`, esse limiar desapareceria: H preferiria não estritamente para `o>0`. Assim, mesmo que as propostas ótimas e seus resultados fossem preservados, a correspondência de estratégias fora do caminho mudaria. O próprio memorando (`quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:343`) já distingue estratégias completas de resultados reportados.

Localizadores: formal_model_v6.Rmd:1433-1435,1482-1489; quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:130-137,343-360.

Evidência:

- Os limiares não pivotais x_H>=o comparam explicitamente u_H(Y)=x_H e u_H(N)=o.
- O memo distingue alteração da estratégia completa de invariância dos resultados reportados, sujeita a revisão.

A sensibilidade é verificável diretamente: no exemplo hipotético aditivo, u_H(N)-u_H(Y)=o>0. Isso refaz a resposta ótima de H naquele ramo e mostra por que a regra antiga não pode ser retirada sem examinar estratégias completas. O exemplo é condicional; não define o jogo vigente.

Encaminhamento: Manter pendente a resposta completa de H sob qualquer arquitetura substituta. Não afirmar invariância das estratégias nem reusar o limiar por analogia.

Checagens: mechanical_checks.json:C5_payoff_sensitivity.

## R1-F004: A arquitetura que satisfaz todo o requisito ainda não está estabelecida

Status: `UNRESOLVED`. Tipo: `logic_or_proof`. Severidade: `major`. Dimensão: `mechanism_and_scope`.

Fonte: R1, linhas 19–25. Decisão mantida do autor: sim.

Texto do parecer:

> Uma obrigação de prova precisa para o novo texto seria:
> 
> > Para todo histórico em que um fraco formula uma proposta, inclusive históricos fora do caminho, e para toda crença admissível nesse histórico, cada proposta ótima com `x_H>0` deve atribuir probabilidade zero ao evento conjunto “a proposta é aprovada e H vota não”. A conclusão deve ser derivada das primitivas, das respostas ótimas e da disciplina de crenças vigentes.
> 
> Essa formulação **preserva screening**: uma oferta positiva pode ser rejeitada por um tipo de H quando sua rejeição faz a proposta fracassar. “Nunca oferecer positivo se algum tipo pode rejeitar” seria uma restrição indevida.
> 
> Há ainda uma fronteira indispensável: otimização em todos os nós, inclusive os não alcançados, elimina ofertas dominadas do comportamento prescrito nesses nós. **Não elimina da árvore do jogo as histórias posteriores a uma oferta desviante.** Logo, a arquitetura ainda precisa especificar payoffs e respostas nessas histórias. Se o requisito for impedir o recebimento conjunto também após qualquer desvio arbitrário do proponente, o lema de dominância não basta; será necessária outra arquitetura substantiva, que não pode ser disfarçada como consequência já demonstrada.

Localizadores: AGENTS.md:21,22,43-47; formal_model_v6.Rmd:314-354,1385-1423; review_sources/architecture_dependency.md:19-25; review_sources/offpath_requirement.md:13-17,29-35.

Evidência:

Não há evidência suficiente para decidir a questão substantiva.

As fontes verificadas definem o ramo disputado por cancelamento. Os pareceres oferecem uma obrigação sobre propostas ótimas e distinguem sua cobertura das histórias após desvios arbitrários; não fornecem outra arquitetura completa, nem uma prova que satisfaça toda a exigência autoral. Não é possível certificar a ausência de recebimento conjunto em toda história pertinente ou escolher uma nova regra de payoff a partir deste diagnóstico estreito. Isso não é uma prova de impossibilidade universal.

Encaminhamento: Preservar a pendência no registro global. Uma revisão substantiva do jogo e sua derivação exigem escopo próprio; a correção de instruções pode apenas tornar a pendência explícita.

## R2-F001: Rejeição certa e rejeição de alguns tipos são condições distintas

Status: `CONFIRMED`. Tipo: `method`. Severidade: `major`. Dimensão: `information_and_scope`.

Fonte: R2, linhas 7–11. Decisão mantida do autor: não.

Texto do parecer:

> 1. **“Saber que H rejeitará” precisa ser definido na informação do proponente.** Seja `I` seu conjunto de informação, `μ_I` sua crença sobre o tipo de H e `σ_H` a estratégia de votação já derivada. A expressão significa `Pr_{μ_I,σ_H}(v_H=N | I,x)=1`. Para tipos discretos, todos os tipos com probabilidade positiva em `μ_I` rejeitam com certeza. O proponente não pode condicionar sua proposta ao tipo verdadeiro conhecido somente por H.
> 
> 2. **Excluir ofertas positivas sob rejeição certa não cobre rejeição de alguns tipos.** Uma proposta pode ser aceita por um tipo e rejeitada por outro. A condição acima não é acionada, embora possa haver probabilidade positiva de aprovação acompanhada de voto não de H. Isso é uma insuficiência lógica da condição, sem afirmar que determinado perfil de votos seja um equilíbrio.
> 
>    O alvo mais forte para propostas ótimas seria demonstrar: `x_H>0 ⇒ Pr(A ∩ {v_H=N} | I,x)=0`, onde `A` significa aprovação. Assim, toda aprovação de uma proposta ótima que atribui valor positivo a H requer seu voto sim. Esse enunciado deve aparecer como resultado a demonstrar, não como uma nova restrição ao espaço de propostas.

Localizadores: formal_model_v6.Rmd:301-306,330-337,1401-1423; review_sources/offpath_requirement.md:7-11.

Evidência:

- O proponente fraco não observa o tipo de H; uma condição de conhecimento deve usar seu conjunto de informação, a crença admissível e a estratégia de H.
- Pode-se ter probabilidade de rejeição 1/2 e de aprovação com voto não 1/2. Uma condição acionada apenas por rejeição certa não cobre esse caso lógico.

A insuficiência lógica é confirmada sem afirmar que o vetor usado no exemplo seja um equilíbrio. O evento a verificar deve conter aprovação e voto não, preservando a possibilidade de screening em que o voto não faz a proposta fracassar.

Encaminhamento: Na obrigação de prova, exigir a verificação do evento conjunto aprovação e voto não para propostas ótimas com x_H>0. Não proibir de partida ofertas que algum tipo rejeitaria.

Checagens: mechanical_checks.json:C2_probability_logic.

## R2-F002: Dois sentidos de fora do caminho e tipos de probabilidade zero

Status: `CONFIRMED`. Tipo: `scope_or_consistency`. Severidade: `major`. Dimensão: `equilibrium_scope`.

Fonte: R2, linhas 13–17. Decisão mantida do autor: não.

Texto do parecer:

> 3. **Há dois sentidos distintos de “fora do caminho”.** Racionalidade pode disciplinar a proposta ótima de um fraco em qualquer conjunto de informação, inclusive depois de uma história que o equilíbrio não produz. Ela não elimina a possibilidade física de uma proposta desviadora `x_H>0`, seguida de voto não de H e aprovação pelos fracos. Mantidos o simplex de propostas e os votos simultâneos, esse ramo continua na árvore e precisa de payoffs definidos.
> 
>    Portanto, uma prova sobre propostas ótimas, mesmo válida em todos os conjuntos de informação fora do caminho, não demonstra que esse ramo seja impossível em toda história factível.
> 
>    Existe ainda uma diferença entre uma garantia quase certa sob `μ_I` e uma garantia para todos os tipos factíveis. Um tipo com probabilidade posterior zero não entra na maximização esperada do proponente. Se o objetivo inclui esse tipo, o resultado precisa ser verificado tipo a tipo; não basta a expressão probabilística acima sob a crença local.

Localizadores: AGENTS.md:22,43,45; formal_model_v6.Rmd:314-337,1401-1423; review_sources/offpath_requirement.md:13-17.

Evidência:

- O simplex permite x_H>0 e os votos simultâneos incluem um vetor em que fracos aprovam e H vota não. A eliminação de uma proposta da escolha ótima não a retira do conjunto de ações factíveis.
- O manuscrito exige regras de crença e racionalidade em propostas fora do caminho e contempla posteriores degenerados; probabilidade local zero não é cobertura tipo a tipo.

É correta a distinção entre otimizar em conjuntos de informação não alcançados e definir payoffs após uma ação desviadora. A garantia probabilística sob uma crença não cobre, por si, tipos factíveis aos quais essa crença atribui zero. Isso define uma fronteira de verificação, sem alegar que toda crença hipotética seja alcançável.

Encaminhamento: Exigir cobertura explícita dos dois sentidos de fora do caminho e declarar se o resultado cobre tipos de probabilidade posterior zero. Preservar o espaço de propostas e o timing até decisão substantiva.

Checagens: mechanical_checks.json:C3_zero_posterior.

## R2-F003: O lema terminal é independente do payoff disputado de H

Status: `CONFIRMED`. Tipo: `logic_or_proof`. Severidade: `minor`. Dimensão: `bounded_formal_result`.

Fonte: R2, linhas 19–23. Decisão mantida do autor: não.

Texto do parecer:

> 4. **Um resultado terminal já pode ser provado sem completar o payoff disputado de H.** Sob as primitivas fornecidas, suponha que a maioria possa ser atingida apenas pelos fracos. Na rodada terminal, cada fraco compara sua alocação não negativa com desacordo zero e vota sim na indiferença. A proposta `x_p=1`, `x_j=0` para `j≠p` passa pelos votos dos fracos e entrega 1 ao proponente. Qualquer proposta com `x_H>0` entrega ao proponente no máximo `1−x_H<1` se aprovada e zero se rejeitada. Logo, **toda proposta ótima terminal sob maioria tem `x_H=0`**, independentemente da crença e também em conjuntos de informação fora do caminho.
> 
>    A prova utiliza somente os payoffs dos fracos, a viabilidade e o desempate terminal. Não escolhe o payoff de H no ramo disputado. Sob unanimidade, aprovação e voto não de H são incompatíveis pela quota.
> 
>    Isso não resolve as rodadas anteriores: com valores de continuação positivos, outros fracos podem exigir concessões e o uso do voto de H pode alterar os custos de aprovação.

Localizadores: formal_model_v6.Rmd:301-318,330-353,1385-1393,1419-1443; review_sources/offpath_requirement.md:19-23.

Evidência:

- m>=3 implica floor((m+1)/2)<=m-1; os votos fracos bastam sob maioria.
- Com desacordo terminal zero e sim na indiferença, alocações zero aos respondedores passam. O proponente pode receber 1, enquanto qualquer x_H>0 limita seu payoff aprovado a 1-x_H<1 e o rejeitado a zero.

O resultado auxiliar está confirmado sob os payoffs dos fracos, o simplex, a quota e o desempate citados. Não utiliza a regra disputada de H. Não demonstra o resultado dinâmico completo nem exclui da árvore uma proposta arbitrária positiva. A checagem finita da quota apenas acompanha a desigualdade algébrica geral registrada.

Encaminhamento: Usar somente como resultado auxiliar terminal e entrada para trabalho posterior. Não migrar uma nova arquitetura para o manuscrito nesta tarefa.

Checagens: mechanical_checks.json:C4_terminal_quota.

## R2-F004: Desperdício exige preservação da aprovação e ganho estrito

Status: `CONFIRMED`. Tipo: `method`. Severidade: `major`. Dimensão: `dynamic_incentives`.

Fonte: R2, linhas 25–29. Decisão mantida do autor: não.

Texto do parecer:

> 5. **O argumento geral de “desperdício” exige verificar a proposta alternativa.** Para demonstrar que oferecer valor positivo a um rejeitante certo não é ótimo, seria necessário comparar a proposta com outra que reduza `x_H` a zero e aumente a alocação do proponente. Deve-se provar que essa mudança preserva os votos relevantes, a aprovação e, quando houver rejeição, as continuações pertinentes. Nada disso deve ser presumido num jogo dinâmico.
> 
>    Além disso, se ambas as propostas forem rejeitadas com certeza e produzirem a mesma continuação, a alteração pode não gerar ganho estrito. Nesse caso, a racionalidade isolada pode permitir a proposta positiva por indiferença. A palavra “jamais” exigiria uma prova que exclua também esse caso ou uma seleção adicional explicitamente autorizada.
> 
>    Condicionalmente, se o ramo ainda disputado fosse completado com pagamento aditivo `x_H+o_θ`, então, numa votação cuja aprovação independa do voto de H, votar não renderia estritamente mais que votar sim para `o_θ>0`. A racionalidade de H favoreceria esse voto. Isso mostra por que é necessário especificar e examinar esse ramo, sem adotá-lo aqui.

Localizadores: quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:75-102; formal_model_v6.Rmd:350-356,1479-1499; review_sources/offpath_requirement.md:25-29.

Evidência:

- A prova atual verifica que os votos fracos continuam bastando e que o ganho é x_H>0. Essa checagem faz parte da prova; não pode ser substituída pela palavra desperdício.
- Se duas propostas fracassam certamente e levam à mesma continuação, seus payoffs são iguais. Isso não sustenta uma eliminação estrita por racionalidade.

O alerta é correto como condição lógica. Ele não mostra que a situação de indiferença seja ótima ou ocorra no equilíbrio do baseline. A rederivação precisa verificar votos, aprovação e valores de continuação pertinentes. O exemplo aditivo reforça a dependência de H já registrada em R1-F003 e não é uma recomendação de adotá-lo.

Encaminhamento: Registrar uma comparação explícita de desvios como obrigação. Não inserir desempate, hipótese de estriteza ou restrição às ofertas para recuperar o resultado.

Checagens: mechanical_checks.json:C6_certain_failure.

## R2-F005: A instrução deve exigir uma demonstração e manter a pendência visível

Status: `CONFIRMED`. Tipo: `scope_or_consistency`. Severidade: `major`. Dimensão: `instruction_fidelity`.

Fonte: R2, linhas 31–35. Decisão mantida do autor: sim.

Texto do parecer:

> Minha sugestão de redação operacional é:
> 
> > A ausência de recebimento simultâneo de alocação positiva e opção externa por H deve ser sustentada pela arquitetura econômica e pelos incentivos do jogo. Derivar as propostas ótimas dos fracos em cada conjunto de informação, alcançado ou não no equilíbrio, usando as crenças admissíveis e as continuações previamente resolvidas. Verificar se uma proposta ótima com `x_H>0` pode ser aprovada quando algum tipo de H vota não, distinguindo os tipos com probabilidade posterior positiva dos demais tipos factíveis. Demonstrar por comparação de desvios qualquer alegação de que uma concessão positiva a H é desperdício; não usar essa alegação como restrição primitiva às propostas. Payoffs e comportamento após propostas desviadoras devem estar definidos. Se a arquitetura permitir o recebimento simultâneo que se pretende excluir, registrar a incompatibilidade e apresentar a revisão substantiva necessária.
> 
> **Status:** insuficiência da condição literal e lema terminal demonstrados; extensão dinâmica e cobertura dos ramos após propostas desviadoras permanecem pendentes da arquitetura completa. Não editei arquivos nem li a proposta de redação do implementador.

Localizadores: AGENTS.md:21-27,33,39,43-56; review_sources/offpath_requirement.md:31-35; review_sources/architecture_dependency.md:19-25.

Evidência:

- O AGENTS atual trata o cancelamento e a ausência de recebimento conjunto como regras já fixadas; não atribui a ausência de acúmulo a uma obrigação de demonstração pendente.
- As cláusulas de autorização e separação de revisão já existentes permitem registrar a exigência sem editar primitivas, provas ou manuscrito.

A direção operacional proposta é compatível com a correção literal em review_sources/author_correction.md:5: tornar a antiga estipulação contestada e exigir derivação das propostas e das respostas em cada histórico pertinente. A redação precisa preservar a distinção entre alvos de prova e restrições ao jogo. A implementação deve apontar para a nota dessa decisão.

Encaminhamento: Corrigir apenas AGENTS e nota de estado, mantendo payoffs dos fracos, votos simultâneos e continuação quando a proposta fracassa. Proibir a certificação do requisito com base apenas na antiga estipulação; não fixar automaticamente uma arquitetura alternativa.

## Correções inseguras e decisões do autor

- Converter o evento a provar em restrição adicional ao espaço de propostas.
- Manter o cancelamento de x_H como axioma e apresentá-lo como consequência de racionalidade.
- Adotar x_H+o como nova regra de payoff sem desenho e autorização.
- Eliminar histórias factíveis após desvios por serem subótimas.
- Inserir uma escolha de H depois da divulgação dos votos, um opt-out imediato após fracasso ou um novo desempate.
- Transportar limiares, estratégias completas ou resultados históricos para uma arquitetura nova sem rederivação.

- Qual revisão substantiva da arquitetura adotar, se necessária, e qual seu escopo de implementação. A exigência de sustentar a ausência de acúmulo é mantida; a solução econômica ainda não foi escolhida.

## Pendências e limites

R1-F004 permanece não resolvido no registro global. A ausência de um finding refutado não equivale a uma certificação global das proposições do manuscrito.

- Nenhuma edição de repositório, candidato ou artefato congelado.
- Nenhuma auditoria integral do paper ou da extensão de agenda.
- Nenhuma busca de equilíbrio, nova solução de jogo ou certificação matemática global.

Contagens: {"total": 9, "confirmed": 8, "partial": 0, "refuted": 0, "unresolved": 1, "held_decisions": 3}.

Veredicto: `BLOCKED`.
