# Parecer Consolidado do Modelo Formal

**Paper:** `formal_model_v5.Rmd`  
**Data:** 2026-05-14  
**Skills usados:** `formal-model-design`, `formal-model-writing`, `formal-model-presentation`  
**Escopo:** avaliação do design conceitual, apresentação técnica e apresentação dos resultados formais.  
**Observação:** este parecer não altera o paper. O diagnóstico prescritivo detalhado por resultado também está salvo em `quality_reports/2026-05-14_formal-model-presentation.md`.

## Resposta operacional: implementar agora ou em outra sessão?

Dá para implementar nesta sessão uma primeira leva de melhorias de baixo risco e alto retorno:

1. adicionar uma tabela de notação no apêndice;
2. renomear condições `D1`, `D2`, `D3`, `NC` com nomes substantivos;
3. adicionar chamadas explícitas "Proof in Appendix A.X" depois dos resultados;
4. transformar os principais checks da calibração em tabelas de margem;
5. deixar mais explícito o mapeamento dos parâmetros para OPEC.

Eu deixaria para outra sessão os itens que exigem nova computação e auditoria:

1. figuras de região para R2, R1 e classificação institucional;
2. comparative statics formais para todos os parâmetros;
3. janelas paramétricas de robustez;
4. decisão final sobre manter delay como resultado no corpo ou mover para apêndice/scope.

Essa divisão preserva a arquitetura já verificada. A primeira leva melhora leitura e rastreabilidade sem mexer na substância das provas. A segunda leva exige scripts novos e checagens, então deve ser tratada como uma rodada própria.

# Parecer de Design do Modelo (Dixit / Varian / Board)

## Score: 8/10

## O modelo em uma frase

Um modelo em que unanimidade dá poder informacional a um hegemon privado-informado porque propositoras fracas precisam satisfazer seu threshold de participação desconhecido, enquanto maioria pode remover o problema de screening quando estados fracos conseguem formar sem ele.

## Tipo de contribuição (Board & Meyer-ter-Vehn)

A contribuição principal é uma **nova lente / força política isolada**. O paper separa agenda power, outside-option power e pivotality power ao fixar `pi_H=0` no baseline. Isso torna o mecanismo conceitualmente limpo: o hegemon ganha poder sob unanimidade não porque propõe, mas porque sua aprovação se torna uma restrição informacional.

Não é uma contribuição técnica no sentido de novo conceito de equilíbrio ou método de prova. A contribuição é substantiva: formalizar uma lógica institucional de poder informacional em organizações internacionais.

## Avaliação por dimensão

### MD1. Qualidade da pergunta: Excelente

A pergunta é politicamente genuína: por que uma potência escolheria consenso se maioria parece dar mais controle? O paper fala com debates reais em RI e organizações internacionais. A pergunta é compreensível para não-especialistas e tem um "why should I care" claro.

### MD2. Simplicidade e KISS: Adequado

O redesign fixed-pie relative-package é uma grande melhoria. Ele elimina a arquitetura antiga de state-dependent pie e torna o mecanismo mais direto. Ainda assim, o baseline carrega muitos objetos ao mesmo tempo: duas rodadas, entrada coletiva, passive beliefs, maioria, unanimidade e classificação. O modelo é simples para o problema, mas a apresentação precisa modularizar melhor.

### MD3. Isolamento do mecanismo: Excelente

O mecanismo central está bem isolado: pivotalidade transforma informação privada em renda. A escolha `pi_H=0` é o ponto mais forte do design, porque empilha a agenda contra o hegemon e evita confundir pivotalidade com proposal power.

### MD4. Riqueza de insights: Adequada/Rica

O insight mais forte é a substituição da tese de dominância global por uma classificação condicional: unanimidade ajuda o hegemon quando a renda de screening por pivotalidade supera o payoff de exclusão sob maioria. O modelo também gera um escopo importante: maioria só elimina screening sob a condição no-cheap-H. A riqueza aumentaria muito com comparative statics e diagramas de região.

### MD5. Tipo de contribuição: Convincente

Classificação: **força política isolada + nova lente para desenho institucional**. O paper aplica ferramentas conhecidas de barganha/votação para isolar um mecanismo ainda pouco formalizado em RI: o valor informacional de ser pivotal.

### MD6. Processo de construção: Maduro

O paper mostra sinais claros de iteração: exemplo simples, baseline parcimonioso, escopo de extensões, e separação explícita entre baseline e `pi_H>0`. A próxima etapa de maturidade é transformar os resultados em objetos visualmente interpretáveis.

## Veredicto geral sobre design

O design é forte. O principal risco já não é conceitual; é de apresentação e persuasão. Um leitor formal vai aceitar melhor a arquitetura se vir fronteiras, margens e comparative statics que mostrem que a classificação não é uma calibração isolada.

## Sugestões construtivas

1. Nomear no texto a decomposição "outside-option power, pivotality power, proposal power" como princípio do design.
2. Inserir uma tabela de mapeamento entre primitivas e OPEC: \(H\), weak states, \(y\), \(t_\theta\), \(\chi\), \(\mu\).
3. Adicionar comparative statics para \(t_0,t_1,\beta,m,\chi,o_0,o_1\).
4. Criar ao menos um diagrama central de classificação em \((\mu,\chi)\).

# Parecer de Apresentação Técnica (Thomson / Board)

**Referências metodológicas:** Thomson (1999), Board & Meyer-ter-Vehn (2018), Dixit (2015), Varian (1997/2016).

## Score: 7/10

## Estrutura do modelo

O modelo define jogadores, ações, informação, preferências, timing e conceito de equilíbrio. Há \(N\) estados, um hegemon \(H\), \(m=N-1\) estados fracos, tipo binário \(\theta\), pacote institucional \(y\), thresholds \(t_\theta\), duas rodadas de barganha, reconhecimento fraco com \(\pi_H=0\), regras \(U\) e \(M\), entrada coletiva com custo \(\chi\), e solução por passive-belief pure-strategy PBE.

## Scorecard

| Dimensão | Veredicto | Comentário sintético |
|---|---|---|
| D2. Apresentação do modelo | Adequado | A ordem é boa, mas muitos objetos entram em bloco único. |
| D3. Notação | Precisa melhorar | A notação é em geral mnemônica, mas falta tabela de referência. |
| D4. Definições | Adequado | A definição principal é clara; passive-belief PBE merece definição destacada. |
| D5. Enunciado dos resultados | Adequado | Resultados são autocontidos, mas alguns precisam mais intuição antes. |
| D6. Provas | Adequado | Estão no apêndice; a prova de R1 precisa steps/claims. |
| D7. Figuras e diagramas | Precisa melhorar | Há timing figure, mas faltam region diagrams. |
| D8. Assumptions e estrutura lógica | Precisa melhorar | Condições D1/D2/D3/NC devem ser agrupadas e nomeadas. |
| D9. Exemplos e aplicações | Adequado | Exemplo e calibração ajudam; faltam tabelas de margem. |

## Diagnósticos principais

### D3. Notação

**Diagnóstico:** O paper usa muitos símbolos derivados: \(a_0^M,a_1^M,a_0^1,a_1,c_M,c(\nu),p_2,C_0,C_1,S_P,S_L,S_R,V_W,V_H,F_R,\Delta_H\). A maioria é necessária, mas o leitor não tem uma tabela para recuperá-los.

**Impacto:** O leitor consegue seguir localmente, mas perde visão global.

**Sugestão concreta:** Adicionar `Appendix C.1 Notation` antes do ledger de reprodutibilidade com colunas: Symbol, Type, Meaning, First use.

### D5. Enunciados

**Diagnóstico:** Proposition majority e Lemma R2 são bons. Theorem R1 é tecnicamente correto, mas denso: junta condições, candidatos, seleção, tie-break e escopo negativo.

**Impacto:** O resultado central pode parecer mais complicado do que é.

**Sugestão concreta:** Antes do Theorem R1, inserir uma frase-takeaway: "Under passive beliefs, the weak proposer faces exactly three relevant options: insure agreement, test the low threshold, or wait." Depois enunciar formalmente.

### D6. Provas

**Diagnóstico:** As provas estão no lugar certo, mas a prova de R1 é longa para um bloco corrido.

**Impacto:** Dificulta auditoria lógica.

**Sugestão concreta:** Dividir Appendix A.3 em claims:

1. Candidate exhaustion;
2. Pooling assessment;
3. Low-only assessment;
4. Rejection assessment;
5. Proposer optimality and tie-break.

### D7. Figuras

**Diagnóstico:** A timing figure é útil, mas os resultados não têm visualização de regiões.

**Impacto:** A classificação institucional fica abstrata, apesar de ser o principal payoff do paper.

**Sugestão concreta:** Criar três figuras:

1. R2 low-only vs pooling;
2. R1 \(P/L/R\) candidate regions;
3. classificação em \((\mu,\chi)\).

### D8. Assumptions

**Diagnóstico:** `D1`, `D2`, `D3`, `NC` são funcionais, mas pouco memoráveis.

**Impacto:** O leitor não sabe quais condições são substantivas e quais são técnicas.

**Sugestão concreta:** Renomear:

- `D1` = Threshold Order;
- `D2` = Majority Threshold Order;
- `D3` = R1 Threshold Order;
- `NC` = No-Cheap-H.

## Inventário de notação prioritário

| Símbolo | Significado | Problema? |
|---|---|---|
| \(N\) | número total de estados | OK |
| \(m=N-1\) | número de estados fracos | OK |
| \(q\) | quota de maioria | OK |
| \(k=q-1\) | votos adicionais necessários | OK |
| \(\theta\) | tipo de \(H\) | OK |
| \(\mu\) | crença de tipo alto | OK |
| \(y\) | pacote relativo pró-\(H\) | OK |
| \(t_\theta\) | threshold líquido de \(H\) | OK |
| \(\bar y\) | pacote máximo | OK |
| \(\beta\) | fator de desconto | OK |
| \(\pi_H\) | probabilidade de reconhecimento de \(H\) | OK |
| \(\chi\) | custo de entrada por weak state | OK |
| \(o_\theta\) | payoff externo de \(H\) | OK, mas precisa motivação mais cedo |
| \(a_0^M,a_1^M\) | thresholds de \(H\) sob majority R1 | OK, mas densos |
| \(a_0^1,a_1\) | thresholds de \(H\) sob unanimity R1 | OK, mas precisam tabela |
| \(p_2(\mu)\) | valor do propositor fraco em R2 | OK |
| \(c(\nu)\) | continuação de weak voter | OK |
| \(P,L,R\) | candidatos R1 | OK |
| \(F_U,F_M\) | formation sets | OK |
| \(\Delta_H\) | gap de payoff de \(H\) | OK |

# Diagnóstico de Presentation dos Resultados

O relatório detalhado por resultado está em:

`quality_reports/2026-05-14_formal-model-presentation.md`

## Estatísticas

- Itens avaliados: 63
- Presentes: 22
- Parciais: 16
- Ausentes: 25

## Gaps sistemáticos

1. comparative statics;
2. region diagrams;
3. parametric windows;
4. margin tables;
5. notation table.

## Prioridade de implementação

### Rodada 1: baixo risco, pode ser feita já

1. Tabela de notação.
2. Renomear condições.
3. Inserir "Proof in Appendix A.X".
4. Tabelas de margem da calibração.
5. Mapeamento OPEC-primitivas.

### Rodada 2: requer scripts/checagem

1. Figura \((\mu,\chi)\) de classificação.
2. Figura R1 de regiões \(P/L/R\).
3. Figura R2 low-only/pooling.
4. Comparative statics appendix.
5. Parametric windows de robustez.

## Veredicto final

A arquitetura formal está suficientemente forte para avançar. O que falta para uma versão convincente é transformar a prova correta em apresentação interpretável: notação rastreável, fronteiras visuais, margens numéricas e comparative statics. Eu implementaria a Rodada 1 nesta sessão se o objetivo for melhorar rapidamente a legibilidade sem mexer na substância. Eu deixaria a Rodada 2 para uma sessão separada com scripts dedicados e auditoria.
