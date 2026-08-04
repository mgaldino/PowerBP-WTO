# Erratum pós-fechamento do Goal 2 — disciplina de voto

**Data do registro:** 2026-08-04

**Natureza:** problema conceitual identificado depois do fechamento documental
do Goal 2

**Escopo:** novo Goal 3; nenhuma alteração retrospectiva dos artefatos ou
pareceres encerrados

## Declaração executiva

Os PASS dos Goals 1 e 2 permanecem evidência válida para o objeto que aqueles
Goals efetivamente definiram e auditaram: um PBE fraco com ballot simultâneo e
uma convenção de voto sim na indiferença. Eles não demonstram que as estratégias
de voto usadas nesses equilíbrios são fracamente não dominadas em todo o jogo
local de votação.

A lacuna é sistêmica, não algébrica. Sob bare weak PBE, um votante redundante
pode aceitar uma oferta inferior à sua continuação porque seu desvio unilateral
não altera a aprovação no perfil candidato. A nova disciplina exige comparar
sim e não também em contingências factíveis nas quais esse mesmo voto é
pivotal, ainda que tais contingências tenham probabilidade zero no equilíbrio
candidato.

Portanto, resultados que dependem de all-yes redundante, ofertas zero,
rejeições descartadas apenas por não pivotalidade ou completions específicas
não podem ser migrados por inércia para o novo objeto de solução.

## O que este erratum não afirma

- Não afirma que todo voto não unilateral efetivamente causa R2.
- Não afirma que votação fracamente não dominada equivale a votar como se
  pivotal.
- Não afirma que a weak-vote-passive assessment seja um refinamento de voto.
- Não atribui aos revisores anteriores a obrigação de auditar um conceito de
  solução que não integrava o contrato então fechado.
- Não presume que maioria ou unanimidade necessariamente percam seus resultados.
- Não introduz coalizão mínima, roll-call, ordem de `H`, trembling-hand ou novo
  tie-break para preservar existência.

## Distância em relação a Baron–Ferejohn

Baron e Ferejohn (1989, pp. 1186–1187) motivam a exclusão de votos fracamente
dominados, mas seu ballot possui ordem fixa e observabilidade dos votos durante
a votação. Esse protocolo não é o protocolo do baseline limpo.

O Goal 3 adapta a admissibilidade por dominância ao ballot simultâneo e selado:
todos votam sem observar os demais; somente após o fechamento o vetor e o
resultado tornam-se públicos. Assim, não existe posição de `H` na ordem nem
sensibilidade por permutações dessa ordem.

A convenção BF de votar sim na indiferença também é separada da dominância
fraca. A nota 9 do artigo registra que essa convenção evita um conjunto aberto
de propostas aprováveis e a possível perda de existência. O Goal 3 mostrará a
correspondência sem seleção e depois as sensibilidades sim, não e mistura.

## Diagnóstico formal mínimo

Para um fraco `i` no conjunto de informação `I`, sejam `Y` e `N` seus votos e
`omega_-i` um perfil factível dos demais votos, tipos e ações compatíveis com
`I`. Defina

```text
Delta_i(omega_-i | I)
  = u_i(Y, omega_-i | I) - u_i(N, omega_-i | I).
```

`Y` é fracamente dominado por `N` se `Delta_i <= 0` em toda contingência
factível e `Delta_i < 0` em pelo menos uma. A relação inversa define quando `N`
é dominado por `Y`. Racionalidade sequencial de PBE continua sendo uma condição
separada.

Quando passagem oferece `x_i` e toda falha relevante produz a mesma continuação
`c_i`, a redução escalar candidata é:

```text
x_i < c_i  => somente N é admissível;
x_i > c_i  => somente Y é admissível;
x_i = c_i  => Y e N podem permanecer admissíveis.
```

Essa redução não pode ser aplicada se o vetor público induzir continuações
diferentes.

Para `H` de tipo `theta`, a comparação é própria:

```text
H-no                  => o_theta imediatamente;
H-yes + implementação => y;
H-yes + falha fraca   => beta C_H2(theta, h2^Y).
```

Logo, `y=o_theta` não basta para tornar `H`-yes admissível se alguma
contingência de falha fraca dá menos que `o_theta` e nenhuma dá mais. Pooling ou
low-only no threshold exato exigem nova prova.

## Claims colocados em quarentena analítica

Até a conclusão da rederivação, recebem o status provisório `precisa de nova
prova`:

- aprovação terminal all-yes e ofertas zero a votantes redundantes;
- preços escalares de aprovação em R1;
- redução global P/L/R e completions por não pivotalidade;
- exclusão/inclusão de `H` e tamanho do suporte vencedor sob maioria;
- `F_M`, `[F_M,1]` e limites atuais do payoff de `H`;
- No-Cheap-H e resultados por tamanho de grupo;
- pooling, low-only, separação e rejeição sob unanimidade;
- entry, formation-set nesting e comparação maioria–unanimidade;
- resultados de fronteira, endpoints e estática comparativa dependentes desses
  objetos.

Esse status não é uma conclusão negativa. Cada claim será classificado somente
depois de prova ou rejeição explícita no novo workspace.

## Integridade histórica e próximos passos

O v6, seu PDF, o v5, a derivação canônica do Goal 1 e todos os relatórios
encerrados permanecem byte a byte congelados. A correção será desenvolvida em
`model_redesign/undominated_voting_rederivation.Rmd`, com scripts e outputs
próprios. A incorporação ao manuscrito pertencerá exclusivamente ao futuro Goal
4.
