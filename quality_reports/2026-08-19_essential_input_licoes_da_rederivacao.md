# Lições aprendidas com a rederivação da arquitetura `essential-input`

**Data:** 2026-08-19  
**Status:** nota metodológica de aprendizado  
**Escopo:** interfaces entre nós, construção de payoffs e governança do contrato  
**Efeito normativo:** nenhum. Esta nota não altera o jogo, o contrato, os schemas, o DAG, os artefatos congelados nem as autorizações correntes.

## 1. Contexto

A rederivação de N4 revelou um erro conceitualmente simples, mas com consequências amplas. Uma continuação de N2 que produz acordo apenas quando o tipo baixo do hegemon está presente havia sido resumida pelo payoff esperado dos países fracos antes da realização do tipo. Esse valor médio foi depois usado em N4 dentro de um ramo em que o tipo alto já estava realizado.

Nesse ramo, porém, a proposta dirigida ao tipo baixo é rejeitada pelo tipo alto. O payoff realizado dos países fracos é zero. O erro consistiu, portanto, em calcular primeiro a média entre tipos e depois transportar essa média para uma história que já estava condicionada a um tipo específico.

O mesmo erro reapareceu durante a rederivação independente, embora o agente tivesse inicialmente escrito corretamente a tabela de payoffs condicionais. A auditoria interna detectou a contradição antes do congelamento do novo artefato. Isso indica que o problema não foi apenas copiar uma fórmula antiga: a representação utilizada tornava fácil apagar a dimensão “tipo realizado” ao passar de uma tabela explícita para expressões compactas de incentivos.

As seis lições abaixo registram o que deve ser aprendido com esse episódio.

## 2. Lição 1 — As interfaces devem preservar payoffs condicionados ao estado realizado

Uma interface de continuação não deve exportar apenas um valor esperado quando um nó predecessor pode precisar avaliar histórias nas quais a incerteza já foi resolvida.

No caso que gerou o erro, era necessário preservar explicitamente algo equivalente a:

| Continuação | Estado realizado | Payoff do país fraco |
|---|---|---:|
| Acordo dirigido ao tipo baixo | tipo baixo | positivo |
| Acordo dirigido ao tipo baixo | tipo alto | zero |

O valor esperado antes da realização do tipo continua sendo útil, mas não substitui esse vetor. A interface deve ser suficiente para os usos posteriores do nó, inclusive avaliações contrafactuais e fora do caminho.

**Lição:** compressão é legítima apenas quando preserva todas as dimensões relevantes para as decisões dos nós descendentes.

## 3. Lição 2 — A expectativa deve ser calculada por último

A ordem segura do raciocínio é:

1. fixar o estado ou tipo realizado;
2. determinar a estratégia induzida pelas crenças e pela história pública;
3. determinar aceitação, rejeição e outcome terminal;
4. atribuir os payoffs realizados a cada jogador;
5. somente então calcular a expectativa usando a crença apropriada ao conjunto de informação.

O erro inverteu essa ordem: um payoff já agregado entre tipos foi introduzido numa condição de incentivo cujo ramo estava condicionado ao tipo alto.

**Lição:** campos denominados “valor esperado” não devem entrar diretamente em uma condição de incentivo quando algum ramo dessa condição já fixa a incerteza sobre a qual a média foi calculada.

## 4. Lição 3 — A notação deve carregar sua condição semântica

Um símbolo compacto que passou a significar informalmente “valor da continuação dirigida ao tipo baixo” escondia que esse valor positivo somente era realizado quando o tipo baixo estava de fato presente.

Nomes ou índices semanticamente completos reduziriam esse risco. A representação deve distinguir, por exemplo:

- payoff do fraco sob proposta dirigida ao tipo baixo quando o tipo baixo está realizado;
- payoff do fraco sob a mesma proposta quando o tipo alto está realizado, que é zero.

**Lição:** a economia de notação não compensa a perda da condição que determina quando um payoff existe. Símbolos reutilizados em muitos ramos devem explicitar tipo, estado, outcome ou data sempre que essas dimensões alterarem seu significado.

## 5. Lição 4 — Todas as condições de incentivo devem consumir a mesma árvore de transições e payoffs

Na derivação problemática, o payoff do proponente foi calculado corretamente como zero após a rejeição do tipo alto, enquanto o payoff de outro país fraco no mesmo ramo recebeu indevidamente um valor positivo. Isso ocorreu porque as fórmulas dos dois jogadores foram construídas em “livros contábeis” separados.

O objeto comum deveria seguir a cadeia:

```text
estado realizado + proposta + votos + crenças relevantes
-> estratégia de continuação
-> aceitação ou rejeição
-> outcome terminal
-> vetor de payoffs de todos os jogadores
```

As condições de incentivo de proponentes e votantes devem ser projeções desse mesmo vetor, e não fórmulas manuais independentes.

**Lição:** uma única árvore executável de transições e payoffs deve ser a fonte comum de todas as condições de incentivo. Isso impede que jogadores diferentes recebam payoffs incompatíveis no mesmo ramo terminal.

## 6. Lição 5 — Invariantes substantivos devem ser permanentes e executáveis

Testes formais precisam cobrir identidades econômicas simples que continuam válidas mesmo quando fórmulas, regiões e schemas mudam. Para esta classe de problema, os invariantes centrais são:

- tipo alto diante de proposta destinada apenas ao tipo baixo implica rejeição;
- rejeição terminal implica payoff zero para todos os países fracos;
- países fracos simétricos têm o mesmo valor antes do reconhecimento em N2;
- o valor esperado de N2 deve ser exatamente recomposto a partir dos payoffs condicionados aos tipos;
- crenças podem selecionar estratégias futuras, mas não podem substituir o tipo verdadeiro nem modificar diretamente o payoff terminal;
- jogadores diferentes devem receber componentes do mesmo vetor de payoff em cada outcome.

Esses testes não substituem a derivação. Eles funcionam como barreiras contra uma classe recorrente de erro: transportar uma média pré-revelação para uma história pós-revelação.

**Lição:** o verifier deve testar não apenas fórmulas finais, mas também as identidades econômicas e contábeis que tornam essas fórmulas possíveis.

## 7. Lição 6 — O contrato deve disciplinar mudanças sem bloquear o aprendizado

O contrato e os schemas são necessários para impedir que agentes acrescentem silenciosamente ações, crenças, seleções ou payoffs. Contudo, a execução pode produzir um insight legítimo de que uma representação planejada descartou informação necessária ou substantivamente útil.

Nessa situação, o insight não deve ser ignorado apenas porque não cabe no contrato vigente. Tampouco o agente deve corrigir o desenho por conta própria. A resposta adequada é pausar, expor claramente o que foi aprendido e consultar o autor. Só depois se decide, caso a caso, se convém manter a simplificação, revisar o schema ou reabrir alguma tarefa para repopular uma interface mais informativa.

O episódio de N2/N4 ilustra precisamente essa tensão. A interface terminal continha um valor esperado correto, mas não preservava diretamente o vetor de payoffs condicionados ao tipo que N4 veio a necessitar. A disciplina contratual evitava uma alteração silenciosa do schema, mas não deveria obrigar a descartar o diagnóstico de que o schema poderia ser melhor.

**Lição:** estabilidade normativa e aprendizado durante a execução são objetivos complementares. O contrato deve funcionar como controle de mudanças, não como proibição de aprender com a própria derivação.

## 8. Síntese

A causa estrutural do erro foi a perda de uma dimensão do estado durante a composição de crenças, estratégias, continuações e payoffs. As respostas correspondentes são:

1. preservar payoffs condicionados nas interfaces;
2. calcular expectativas somente depois dos outcomes por estado;
3. usar notação semanticamente completa;
4. derivar todas as condições de incentivo de uma árvore comum de transições e payoffs;
5. manter invariantes econômicos executáveis;
6. permitir que insights da execução sejam apresentados ao autor e possam motivar, mediante autorização, a revisão do desenho planejado.

Esta nota registra aprendizado para a revisão futura do processo. Ela deliberadamente não especifica um novo protocolo nem altera retroativamente os gates vigentes.
