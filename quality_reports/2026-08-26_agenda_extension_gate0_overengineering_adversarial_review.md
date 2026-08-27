# Parecer adversarial de design — Gate 0 da extensão de agenda

**Data:** 2026-08-26  
**Natureza:** auditoria independente, estritamente `read-only`  
**Pergunta:** o contrato, os schemas, o verifier/harness proposto e a cadeia
`A_M -> A_U -> AC -> AR` estão excessivamente complexos a ponto de o custo,
a rigidez ou a fragilidade superarem o ganho de rigor para este paper?

## Veredito

**APPROVE WITH SIMPLIFICATION**

**Nota de overengineering: 8/10.**

A pergunta teórica é boa e a forma extensiva está bem definida. O problema está
na camada construída ao redor dela: o contrato tenta tratar, simultaneamente,
estratégias mistas Borelianas arbitrárias, crenças ponto a ponto, escolhas de
continuação dependentes da história inteira, correspondência completa, seis
estimandos, schemas extensos e uma cadeia de até 14 pareceres. Isso transforma
uma extensão de paper em um projeto de infraestrutura formal.

## Vulnerabilidade principal

O contrato mistura três coisas diferentes:

1. regras indispensáveis do jogo;
2. obrigações que pertencem às provas matemáticas;
3. controles administrativos e de banco de dados.

Depois exige que o futuro verificador fiscalize as três. Um script consegue
conferir hashes, schemas, datas, desconto e transições finitas. Ele não consegue
certificar genericamente ausência de desvios em todo um contínuo, completude de
todos os PBE ou mensurabilidade de funções Borelianas. Essas tarefas continuam
dependendo de prova e revisão humana, apesar do volume do harness.

## Classificação dos componentes

| Componente | Classe | Diagnóstico |
|---|---:|---|
| Primitivas, timing, quotas, implementação e desconto | **(a) indispensável** | É o núcleo limpo do contrato e previne os erros contábeis anteriores. |
| Binder atômico e conjunto conjunto exato antes de envelopes | **(a) indispensável** | Evita combinar payoff de um equilíbrio com outcome de outro. Já foi útil nos artefatos congelados. |
| Correspondência completa por family records | **(b) útil porém pesada** | Registros simbólicos são a forma correta de representar contínuos. O excesso começa quando todo singleton deve virar família e todo registro recebe dezenas de campos e certificados. |
| Correspondência completa sobre medidas Borelianas arbitrárias | **(d) contraproducente**, como obrigação nuclear | Amplia o objeto muito além do necessário para o paper e pode tornar a tarefa impossível de encerrar. |
| Bayes local em todo ponto do suporte topológico | **(d) contraproducente** | O texto reconhece que Bayes vale quase em toda parte, mas depois exige limite local em todo ponto "disciplinado" e manda parar se ele falhar. Isso é uma restrição adicional, não algo indispensável ao PBE padrão. Pode eliminar ramos por comportamento patológico em pontos de probabilidade zero. |
| Continuação como membro completo, público e comum aos tipos | **(a) indispensável** | Impede payoff fabricado e seleção diferente para cada tipo. |
| `kappa` arbitrária sobre a história pública completa | **(b) útil porém pesada**, tendendo a **(c)** | Preserva equilíbrios dependentes de fatos passados sem importância econômica. Isso cria multiplicidade do tipo "sunspot" e pode tornar os resultados pouco informativos. |
| Schemas de benchmarks, rendas e interação | **(c) removível sem comprometer a pergunta central** | O núcleo precisa de payoff privado por regra e comparação entre regras. A interação de quatro contrafactuais e toda a infraestrutura de `AR` podem ser abertas apenas se o resultado principal sobreviver. |
| DAG de quatro nós | **(b) útil porém pesado** | A dependência matemática é clara. O transporte integral de "complete views" através de `AC`, em vez de referências diretas por hash, é duplicação administrativa. |
| Lifecycle detalhado no DAG | **(c) removível** | `started_order`, `passed_order` e reviews embutidos não melhoram a teoria. `status`, hashes de inputs, hash de output e review paths bastam. |
| Verifier/harness proposto | **(d) contraproducente** | A seção exige que código verifique propriedades que só uma prova pode estabelecer, especialmente as obrigações de racionalidade sequencial e completude. |
| Dois pareceres para cada nó | **(b) útil porém pesado** nos nós matemáticos; **(c)** nos nós mecânicos | Justificado para `A_U` e para o resultado integrado. Excessivo para harness e simples transporte de payload. |
| Cinco Goals antes da migração | **(c) removível sem comprometer rigor** | São úteis como ordem de trabalho, mas não precisam ser cinco ciclos independentes de autorização, freeze e dois pareceres. |

## Ponto matemático mais importante

A regra local de Bayes não é apenas uma solução técnica neutra. O contrato diz
que Bayes vale `m`-quase em toda parte, mas exige adicionalmente que a razão de
probabilidades em bolas tenha limite em **todo** ponto do suporte topológico;
caso contrário, o ramo para.

Isso escolhe uma disciplina mais forte que o PBE usual. Pode ser uma opção
legítima, mas deve ser chamada de restrição/refinamento do baseline e
justificada por ganho substantivo. Não deve ser tratada como requisito
inevitável para trabalhar com propostas contínuas.

## Contrato mínimo alternativo concreto

### Fase 1 — jogo e insumos

Fixar apenas:

- jogadores, informação, pacote, factibilidade, votação, implementação e datas;
- hashes de `C_M`, `C_U` e `N7`;
- regra de desconto;
- células existentes e inexistentes das continuações;
- harness limitado a hashes, schemas mínimos, transições, quotas, desconto e
  testes de fórmulas fornecidas.

O harness não "verifica PBE". Ele apenas tenta falsificar candidatos e conferir
contabilidade.

### Fase 2 — jogos privados

Resolver `A_M` e depois `A_U`, mantendo dois artefatos separados. Um family
record precisaria somente de:

```text
family_id
institution
parameter_cell_and_domain
member_parameter
strategy_by_type
weak_vote_strategy
belief_system
continuation_rule
payoff_by_type
outcome_distribution
atomic_binder
source_ids_and_hashes
selection_status
proof_path
```

Para células vazias:

```text
cell_id
domain
none_reason
proof_path
```

Manter:

- o mesmo binder em todas as coordenadas;
- conjunto conjunto exato antes de envelopes;
- ausência de sentinelas;
- fontes e datas explícitas.

Usar Bayes por razão de massas em átomos e uma probabilidade condicional regular
quase em toda parte na parte contínua. Crenças em histórias nulas ficam
explicitamente livres dentro do suporte, salvo refinamento posterior
autorizado.

Se o Goal 1 mostrar que a continuação depende apenas da instituição e do
posterior, usar `kappa(g,mu)`. Só adicionar outra dimensão da história se ela
alterar efetivamente o jogo de continuação.

### Fase 3 — análise condicional

Primeiro comparar os payoffs privados de `A_M` e `A_U`. Somente se essa
comparação produzir um resultado útil para o paper:

- resolver os benchmarks públicos;
- calcular rendas informacionais;
- calcular a interação informação × agenda, se ainda houver motivo
  substantivo.

`AC` e `AR` podem ser seções de um único artefato de análise, com referências
aos hashes originais, sem copiar integralmente as continuações.

### Revisão mínima

- uma revisão de código do harness;
- revisão formal independente de `A_M`;
- duas revisões independentes de `A_U`, incluindo a reconstrução cega;
- duas revisões do pacote final de resultados;
- nova decisão autoral antes de editar o paper.

Autorizações seriam necessárias em três fronteiras: contrato, pacote privado e
migração — não depois de cada transformação mecânica.

## O que se perderia

A simplificação abandonaria:

- a pretensão de caracterizar todos os PBE gerados por medidas Borelianas
  patológicas;
- uma crença canônica em cada ponto nulo pertencente ao suporte topológico;
- equilíbrios cuja seleção da continuação depende de detalhes passados sem
  relevância para o estado do jogo;
- rastreabilidade redundante de cada coordenada por dezenas de campos;
- a garantia antecipada de que todos os seis estimandos serão calculados.

Não se perderiam a pergunta central, a forma extensiva, a comparação
maioria–unanimidade, a multiplicidade economicamente relevante, a atomicidade
dos equilíbrios, o desconto correto, os hashes ou a revisão independente.

## Avaliação do design

- **Qualidade da pergunta:** excelente.
- **Simplicidade:** problema sério no contrato, não necessariamente no jogo.
- **Isolamento do mecanismo:** parcial; a infraestrutura ameaça obscurecer
  agenda, informação e pivotalidade.
- **Riqueza potencial:** alta, mas seis estimandos de saída são mais de um
  paper.
- **Tipo de contribuição:** extensão substantiva importante do mecanismo
  existente, não contribuição técnica em teoria da medida.
- **Processo de construção:** maduro, porém passou do ponto de proteção para
  sobre-especificação.

## Três maiores custos

1. Um verifier com obrigações matematicamente não automatizáveis.
2. Correspondência ampliada por medidas arbitrárias e seleções dependentes da
   história inteira.
3. Até 14 pareceres e sucessivos freezes antes da migração, mesmo para
   transformações mecânicas.

## Três proteções que não devem ser removidas

1. Hashes exatos, datas e aplicação única de `beta`.
2. Binder atômico e conjunto conjunto exato antes de qualquer envelope.
3. Revisão independente das derivações matemáticas, especialmente reconstrução
   cega de `A_U`.

## Recomendação simples ao autor

Não aprovaria o contrato exatamente como está. A pergunta merece ser resolvida,
mas o processo atual corre o risco de consumir mais esforço que a própria
extensão. Eu autorizaria uma única passada de simplificação: reduzir o verifier
ao que código realmente consegue testar, tratar Bayes ponto a ponto como
refinamento opcional, comprimir os schemas e deixar benchmarks de interação
para depois de saber se o resultado privado vale a pena.

## Integridade da revisão

Nenhum arquivo foi alterado durante a auditoria. Os hashes antes e depois da
leitura foram:

- contrato: `36ef554322945a7e44da492b46f15527855da603e06ef90d787b7645cc1c9b32`;
- DAG: `9644151b8441ed5d09d1a870c3a2f5b94437c2376c7af6fb419c17297ebd5cd6`;
- cada ledger: `e8579785d0a0277601e2468951bf387853cd89b3f9a49386d2af5f8f31c1cba0`.
