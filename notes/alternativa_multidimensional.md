# Alternativa: Acordo Multidimensional + Conhecimento de Preferências

**Data**: 2026-04-06
**Status**: IDEIA — não formalizada, não simulada

---

## 1. Motivação

Os caminhos anteriores (pie size ω, outside option b) sofrem de problemas conceituais:

- **Pie size**: linearidade fundamental, BP tem valor zero
- **Outside option privada**: quem sai da barganha? Status quo é info privada? Não faz sentido substantivo

A pergunta correta é: **o que os EUA sabem que outros não sabem?** Resposta: as **preferências dos outros jogadores** — reservation prices, linhas vermelhas, trade-offs que cada país está disposto a fazer. Os EUA têm embaixadas, USTR, inteligência econômica.

## 2. A intuição

O objeto de negociação não é unidimensional (dividir 1 real). É um **acordo multidimensional complexo**: tarifas por setor, propriedade intelectual, serviços, investimento, meio-ambiente, etc. O espaço de acordos possíveis é vasto.

S (EUA) conhece as preferências/reservas de cada jogador. Com esse mapa, S pode:

1. Identificar o **conjunto factível** (propostas que seriam aceitas por todos/maioria)
2. Dentre as factíveis, escolher a **melhor para S**
3. Extrair **renda informacional** = diferença entre "acordo aleatório factível" e "acordo ótimo para S dentro do factível"

## 3. Por que unanimidade amplifica o valor da informação

- **Sob unanimidade**: conjunto factível = ∩ das zonas de aceitação de TODOS os jogadores. Pequeno, difícil de encontrar sem conhecer cada um. Conhecimento de S é crucial.
- **Sob maioria**: factível = ∪ das interseções de q-coalizões. Muito maior. Mais fácil encontrar algo que passe sem conhecer todos.

**O valor marginal de conhecer preferências é maior sob unanimidade.**

Os EUA aceitam unanimidade porque é onde sua vantagem analítica rende mais. Sob maioria, qualquer proposer encontra algo que passe — a informação tem pouco valor. Sob unanimidade, só quem conhece o mapa consegue propor algo que passe.

## 4. Conexão com literature

- **McKelvey (1976)**: em espaços multidimensionais, resultados são genericamente instáveis. O agenda setter informado tem poder enorme.
- **Romer & Rosenthal (1978)**: agenda setting com info completa. Nosso twist: info incompleta sobre preferências.
- **Mechanism design com informed principal**: S conhece tipos dos outros e desenha o mecanismo.
- **Broker/mediator literature**: intermediário informado que facilita acordo e extrai renda.

## 5. Vantagens sobre modelos anteriores

| Dimensão | Pie size (v4) | Outside option | Multidimensional |
|---|---|---|---|
| Fonte de info privada | S sabe tamanho da pie | S sabe própria outside option | S sabe preferências dos outros |
| Plausibilidade | Média | Baixa (status quo privado?) | Alta (USTR, embaixadas) |
| Linearidade | Fatal (BP valor zero) | Parcial (requer screening) | Provavelmente não (otimização em R^K) |
| Complexidade formal | Baixa (BF padrão) | Média (BF + screening) | Alta (spatial + info incompleta) |
| Naturalidade para OIs | Média | Baixa | Alta |

## 6. O desafio

Formalizar isso é significativamente mais complexo que BF unidimensional. Spatial voting com informação incompleta requer ferramentas diferentes. **Mas talvez não precise de spatial voting formal** — o insight pode ser capturável num modelo mais simples se encontrarmos o breakthrough conceitual certo.

Possíveis simplificações a explorar:
- Reduzir K dimensões a 2 (mínimo para o efeito existir)
- Preferências lineares ou quadráticas
- Tipos discretos (cada R tem tipo binário, S conhece o perfil)
- Focar na comparação unanimidade vs. maioria, não no equilíbrio completo

## 7. O que falta: breakthrough conceitual

O autor nota que spatial voting provavelmente NÃO é o caminho. Precisa de uma forma simples de capturar a ideia de que "S sabe o mapa das preferências e extrai renda desse conhecimento" sem a maquinaria pesada de modelos espaciais.

Ideias para o breakthrough:
- **Reduzir a info privada a uma estatística suficiente**: S não precisa saber TUDO sobre as preferências — talvez saber um índice agregado (quem é pivotal, qual a coalizão mínima vencedora)
- **Modelar como menu de propostas**: S sabe qual "menu" de acordos é factível e escolhe o prato
- **Analogia com leilões**: S é o leiloeiro que conhece as avaliações dos bidders
- **Dois tipos por R**: cada R é "fácil" ou "difícil", S sabe o perfil → problem de coalition formation com tipos conhecidos por S
