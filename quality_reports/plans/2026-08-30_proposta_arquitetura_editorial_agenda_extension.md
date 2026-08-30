# Proposta de arquitetura editorial para a extensão de poder de agenda

**Data:** 2026-08-30  
**Status:** PROPOSTA PARA DECISÃO — NÃO AUTORIZA EDIÇÃO DO MANUSCRITO

## 1. A decisão em linguagem direta

Os resultados novos são fortes o bastante para entrar no paper, mas há mais de uma maneira de acomodá-los. A decisão não é matemática: é qual promessa o paper fará ao leitor.

O paper atual tem uma promessa muito nítida: mesmo sem controlar a agenda, o hegemon pode ganhar com unanimidade porque seu veto privado cria um problema informacional para os Estados fracos. A extensão mostra o que acontece quando também permitimos poder de agenda. Ela deve ampliar essa promessa, sem substituí-la.

Minha recomendação é manter o mecanismo informacional como núcleo e apresentar agenda como uma extensão disciplinada. Assim, o leitor primeiro entende o resultado mais surpreendente — poder sem ser proponente — e depois vê como o controle da agenda reforça ou contrabalança esse mecanismo.

## 2. Três arquiteturas possíveis

### Opção 1 — Extensão enxuta e integrada (recomendada)

O benchmark sem agenda continua sendo o resultado principal. Uma nova seção de aproximadamente 3,5 a 5 páginas introduz a etapa de agenda e entrega duas proposições centrais, corolários e uma figura. Correspondências completas e provas ficam no apêndice.

**Vantagens:** preserva a identidade do paper; usa todos os resultados fortes; torna transparente a diferença entre poder público de agenda e renda gerada pela informação; exige pouca duplicação do modelo.  
**Custo:** requer disciplina para não despejar no corpo todas as células e correspondências.

### Opção 2 — Agenda e informação como pilares equivalentes

O paper seria reescrito como uma teoria geral de duas fontes de poder institucional: controlar propostas e ser pivotal sob informação privada. Isso exigiria mudar resumo, introdução, arquitetura do modelo e ordem dos resultados.

**Vantagem:** ambição teórica maior.  
**Custos:** aumenta muito a carga de notação; enfraquece a surpresa do benchmark sem agenda; aproxima o projeto de dois papers em um; exige nova revisão integral, não apenas migração.

### Opção 3 — Extensão somente no apêndice

O texto principal apenas mencionaria que os resultados sobrevivem ou se modificam com poder de agenda, remetendo todas as fórmulas ao apêndice.

**Vantagem:** máxima proteção da narrativa atual.  
**Custo:** subutiliza resultados que agora têm interpretação própria e uma decomposição limpa.

## 3. Arquitetura recomendada do paper

### Introdução

Manter a pergunta e a contribuição atuais. Acrescentar, perto do fim da introdução, um parágrafo sem notação:

> O mecanismo não depende de o hegemon controlar propostas. A extensão permite que ele também tenha poder de agenda e separa seus efeitos: o controle público da proposta pode favorecer maioria ou unanimidade, dependendo do custo do atraso, enquanto a informação privada acrescenta uma renda distinta. Essa separação mostra quando os dois poderes se reforçam e quando operam em direções contrárias.

Não incluir catálogo de equilíbrios na introdução.

### Modelo

Preservar o modelo-base. Criar uma subseção curta, “Extensão: poder de agenda”, contendo apenas:

- quem propõe e em que momento;
- o que é observado;
- como a continuação congelada é consumida;
- uma figura simples do timing;
- uma frase explícita de que o benchmark sem agenda continua sendo o caso-base.

### Resultados principais existentes

Mantê-los antes da extensão. Essa ordem é importante: primeiro se demonstra que pivotalidade e informação já produzem poder; depois se adiciona a capacidade de propor.

### Nova seção: “Poder de agenda e poder informacional”

1. **Visão geral dos jogos privados.** Uma tabela pequena resume o que pode ocorrer em \(A_M\) e \(A_U\), sem reproduzir as correspondências completas.
2. **Proposição 1: comparação privada exata.** O objeto é o conjunto de comparações válidas entre equilíbrios no mesmo ambiente. Um corolário apresenta T5 como região suficiente limpa — nunca como caracterização necessária.
3. **Proposição 2: benchmark público e decomposição.** Apresenta maioria pública, unanimidade pública, \(G(o)\) e a identidade que separa o componente público do componente informacional.
4. **Corolário por tipo e ex ante.** Primeiro mostra quem recebe a renda; depois calcula a média. A média não deve esconder a incidência entre os tipos.
5. **Figura 1 da extensão.** Um único gráfico do sinal de \(G(o)\), indicando a região em que o poder público de agenda favorece maioria ou unanimidade.

### Discussão

Explicar a diferença entre três capacidades:

- ter uma opção externa melhor;
- ser indispensável para a aprovação;
- controlar a proposta.

A mensagem é que elas não são sinônimas. Um ator pode extrair renda informacional por ser indispensável mesmo sem propor; quando passa a propor, surge um efeito público adicional cujo sinal não é universal.

Qualquer ampliação empírica ou comparação com casos reais deve passar por auditoria própria de fontes. A extensão formal, por si só, não autoriza novas afirmações factuais.

## 4. Organização proposta dos apêndices

### Apêndice E — Jogos de agenda e provas econômicas

- E.1 Contrato, timing e regra de continuação
- E.2 Correspondência completa de maioria privada
- E.3 Correspondência completa de unanimidade privada
- E.4 Comparação privada exata no mesmo ambiente
- E.5 T5, certificado local, igualdade e contraexemplo à necessidade
- E.6 Classes de PBE da maioria pública
- E.7 Prova da unanimidade pública
- E.8 Derivação e continuidade de \(G(o)\)
- E.9 Rendas informacionais por tipo e ex ante
- E.10 Decomposição institucional

### Apêndice F — Estrutura conjuntista e governança da prova

- F.1 Assinaturas de duas camadas, fatoração, envelopes e células `none`
- F.2 Interação com N7 e mapa exato das fontes
- F.3 Datas dos payoffs, limites dos verificadores e convenções de representação

Essa divisão evita que a maquinaria de correspondências interrompa a leitura econômica, mas preserva tudo que torna os resultados auditáveis.

## 5. Cinco decisões para o autor

### D1. Resultado por tipo ou somente ex ante?

**Recomendação:** resultado por tipo no corpo; média ex ante como corolário.  
**Por quê:** o mecanismo é sobre informação privada. Mostrar apenas a média esconde quem extrai a renda e pode produzir a impressão errada de que os tipos são intercambiáveis.

### D2. Quanto de T5 deve entrar no corpo?

**Recomendação:** enunciar a condição suficiente simples no corpo; deixar a prova, a igualdade e o contraexemplo à necessidade no apêndice.  
**Por quê:** T5 oferece uma região interpretável, mas não esgota todas as economias em que o resultado aparece.

### D3. Como ligar agenda ao benchmark sem agenda?

**Recomendação:** uma decomposição no corpo e a tabela completa de sinais no apêndice.  
**Por quê:** a identidade mostra com precisão o que mudou; uma enciclopédia de células desviaria o leitor da ideia central.

### D4. Quantas figuras?

**Recomendação:** uma figura de \(G(o)\) no corpo. Qualquer diagrama completo das regiões de equilíbrio deve ficar no apêndice.  
**Por quê:** a figura principal deve responder uma pergunta substantiva, não reproduzir toda a prova.

### D5. Quanto de aplicação substantiva acrescentar?

**Recomendação:** por enquanto, apenas um parágrafo de motivação institucional. Expandir casos ou literatura somente após uma checagem própria de fontes.  
**Por quê:** os resultados formais estão aprovados; novas afirmações empíricas ainda não estão.

## 6. Riscos editoriais e como contê-los

| Risco | Como conter |
|---|---|
| O paper parecer dois papers | manter o benchmark sem agenda como contribuição principal e limitar a extensão a uma seção |
| Sobrecarga de notação | reutilizar apenas objetos essenciais no corpo e remeter correspondências ao apêndice |
| Contradição com a frase “sem poder de agenda” | qualificá-la como resultado-base, não como restrição de todo o paper |
| Seleção silenciosa de equilíbrio | enunciar resultados como correspondências e usar comparações da mesma fibra |
| Exagerar o alcance de T5 | chamá-la sempre de condição suficiente |
| Confundir efeito público e renda informacional | usar a decomposição e manter a orientação dos sinais explícita |

## 7. Minha recomendação final

Escolher a **Opção 1**. Ela preserva a contribuição distintiva e incorpora a extensão como um teste teoricamente produtivo: primeiro o paper demonstra poder informacional sem controle da agenda; depois mostra como o controle da agenda acrescenta um componente separável, que pode reforçar ou contrariar o primeiro.

Se essa arquitetura for aprovada, o próximo ato não deve ser uma reescrita livre. Deve ser a autorização linha a linha da matriz de migração, seguida de edição controlada, compilação e revisão independente do novo snapshot.
