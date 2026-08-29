# Revisão independente do pacote para ChatGPT Pro sobre `A_M`

**Data:** 2026-08-28  
**Modo:** somente leitura; o revisor não editou arquivos  
**Escopo:** pacote autocontido de equilíbrios explícitos sob maioria  
**SHA-256 auditado:** `9671cd3a2ed73d7accb2eb82d41b6edb7c508d4e0afff45306a44a8469e2d584`

## Barreira de escopo

O revisor tratou `AX-N1` e `AX-CM-1` a `AX-CM-4` como axiomas e não reabriu
as provas do jogo anterior. A auditoria substantiva começou em `AM-L1` e
cobriu `AMX-001` a `AMX-016` nos mesmos bytes acima.

## Veredito final

**PASS**

- critical: 0
- important: 0
- minor: 0

Resultado por bloco:

- `AM-L1` a `AM-L3`: PASS;
- `AMX-001` a `AMX-012`: PASS;
- `AMX-013`: `MECHANICAL EVIDENCE ONLY`, sem pretensão de prova;
- `AMX-014` a `AMX-016`: `OPEN BY DESIGN`, sem afetar os resultados
  explícitos.

## Pontos conferidos

- Bayes e suporte do prior, inclusive fronteiras e endpoints;
- assessment coordenado e continuação literal total;
- regra pivotal ponto a ponto;
- aplicação de `beta` exatamente uma vez após a rejeição em `A_M`;
- ausência de recombinação entre membros de `C_M`;
- construções de incidência para `N=3` e para ambas as paridades;
- condições e quantificadores dos certificados de não existência;
- distinção entre resultados provados, evidência mecânica e problemas ainda
  abertos;
- declaração inequívoca de que maioria permanece candidata exploratória, não
  aprovada nem congelada.

## Reparos feitos antes do hash final

Em versões intermediárias, o revisor detectou: escopo inadequado do prior em
algumas construções separating, ausência de definição de `D_M^0`, tratamento
ambíguo de `AMX-013` e uma sobreafirmação de que as taxas admissíveis de
semipooling sempre formariam um único intervalo. O editor corrigiu todos os
pontos. O revisor releu os bytes finais e confirmou o veredito acima.

Este parecer aprova apenas a consistência matemática interna do pacote no hash
declarado. Não constitui aprovação autoral ou congelamento de `A_M`.
