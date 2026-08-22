## Parecer independente — Gate 0

- `reviewer_role=game_theory`
- `reviewer_id=review-gate0-o1-interior-game-2026-08-18`
- Escopo: auditoria adversarial read-only do contrato, DAG e verificador atuais.
- Veredicto estrito: **PASS**
- Contagens: **critical 0 / major 0 / minor 0**
- Findings exatos: **nenhum**.

### Identidade do snapshot

- Branch: `codex/essential-input-o1-interior`
- Contrato: `7b52f332aff353bf54a36992b0944ab3ff016a1c90e56a05e4853d26d92dab82` — **PASS**
- DAG: `9e7c73a5444711cfaae2b2f9868b244500bd173f5214533fd897dad280c4cb76` — **PASS**
- Verificador: `c19d8d1c27261d0586ceba6aed389ebed9454f37fa6375e1210f689b00d281e1` — **PASS**

`AGENTS.md` e o contrato foram lidos integralmente. Nenhum arquivo foi alterado
pelo revisor.

### Reconstrução independente do efeito de `o_1 < 1`

Em R2-unanimidade, stage-undominance e `T^Y` fazem todos os weak nonproposers
votarem `sim`, inclusive quando recebem zero. `H` é então pivotal e vota `sim`
exatamente quando `y >= o_theta`, aceitando na igualdade.

Com crença de entrada `nu`, os únicos candidatos ótimos são:

- screening baixo em `y=o_0`, com payoff do proponente
  `S(nu)=(1-nu)(1-o_0)`;
- pooling em `y=o_1`, com payoff `P=1-o_1`.

Como `o_1<1`, `P>0`. Portanto, em `nu=1`, pooling em `y=o_1`, `x_j=0` e
`r_i=1-o_1` domina estritamente toda proposta rejeitada, com folga ou que
desperdice recursos. Desaparece precisamente a patologia econômica do corner
`o_1=1, nu=1`: payoff zero tanto ao satisfazer o tipo alto quanto ao provocar
rejeição, permitindo qualquer proposta e misturas arbitrárias.

A fronteira entre screening e pooling é
`nu*=(o_1-o_0)/(1-o_0)`, que agora pertence estritamente a `(0,1)`. Na
igualdade, o tie-break de proposta seleciona screening, pois seu payoff esperado
para `H` é estritamente inferior ao de pooling. Não resta mistura de propostas
naquele empate.

### Posterior igual a um

A restrição incide na primitiva `o_1`, não nas crenças:

- as interfaces de N1–N4 e N6 continuam definidas em `[0,1]`;
- N7 mantém `prior_mu in [0,1]`;
- posterior igual a um após ação reveladora continua admissível;
- nesse posterior, o problema de N2 agora tem solução disciplinada e
  estritamente lucrativa, em vez de ser excluído do domínio.

Logo, a mudança preserva aprendizagem bayesiana completa.

### Compatibilidade com o restante do jogo

- **`y_bar`:** não há conflito. `o_1 <= y_bar` garante a factibilidade de
  `y=o_1`; `o_1<1` deixa residual estritamente positivo.
- **`T^Y`:** continua indispensável. `H` permanece genuinamente indiferente em
  `y=o_theta`, e `T^Y` fecha o conjunto de ofertas aprováveis. A nova restrição
  torna o proponente estritamente favorável à aprovação, sem fabricar
  preferência estrita para `H`.
- **P0:** a desigualdade de factibilidade permanece intacta. A restrição prova
  uso integral apenas no corner terminal reconstruído; não antecipa P0 em N1,
  N3 ou N4.
- **Payoff externo:** relacionar `o_1` à unidade da pie é uma condição de ganhos
  de acordo, não inclusão de `o_1` na restrição orçamentária. A implementação e
  os payoffs `y+o_theta` quando `H` fica fora permanecem inalterados.
- **Estimando:** `V_g^priv`, `V_g^pub`, `RI_g` e `DeltaRI` não mudam. A mesma
  restrição primitiva vale nos jogos privado e público, evitando assimetria
  contrafactual.
- **N1:** o resultado terminal de maioria não depende materialmente do novo
  limite; `H` não pivotal continua preferindo `não`.
- **N3:** a restrição não elimina empates dinâmicos independentes, como os que
  podem surgir em `beta=1` e `q=m`. Eles permanecem obrigações da rederivação,
  como devem.
- **N4:** a continuação de unanimidade em posterior um passa a ser positiva e
  disciplinada. Separating, pooling, delay e eventual multiplicidade continuam
  pendentes em P3–P7.
- **N7:** a mudança também exclui, coerentemente, o análogo público de
  R2-unanimidade para `theta=1`. Empates dinâmicos em `beta=1` ainda podem
  sobreviver e devem ser preservados por P8.

Assim, “remove exatamente o corner de N2” deve ser entendido como remoção da
patologia terminal de residual nulo. Por ser uma primitiva comum, ela
necessariamente remove também seu análogo no benchmark público e qualquer
célula definida exclusivamente por `o_1=1`; não seleciona resultados no
interior.

A restrição não é necessária ao mecanismo de pivotalidade informacional. É uma
condição substantiva de escopo/regularidade: exige ganhos estritamente positivos
de acordo mesmo com o tipo alto. O contrato a identifica transparentemente como
tal e não a disfarça como consequência do equilíbrio.

### Existência e degenerações

Não encontrei nova degeneração ou fonte de inexistência causada por `o_1<1`:

- para cada parâmetro admissível, o pacote pooling terminal existe e produz
  payoff positivo;
- a abertura do domínio no limite `o_1=1` não prejudica máximos, pois `o_1` é
  fixo em cada jogo e o espaço de propostas continua compacto;
- multiplicidades ou inexistências que possam surgir dinamicamente continuam
  representáveis pelas coverage cells e certificados previstos pelo contrato.

### DAG, reabertura e verificador

Os seis nós `N1`, `N2`, `N3`, `N4`, `N6` e `N7` estão `pending`, com coleções
vazias `null` e sem `artifact_hash`, `frozen`, `reviews` ou resultados. O DAG
conserva:

`[N1,N2] → [N3,N4] → [N6] → [N7]`.

O diff do verificador é apenas aditivo quanto à mudança atual. Ele passou a
exigir:

- a expressão estrita `o_1<1`;
- ausência da expressão primitiva supersedida;
- registro de reabertura do Gate 0 e retorno a `pending`.

Os gates anteriores não foram enfraquecidos: continuam as exigências de duas
revisões independentes, mesmo hash, PASS 0/0/0, IDs distintos, campos de
congelamento completos, interfaces vazias em `pending`, testes negativos de
schema, invalidação transitiva e separação entre prontidão topológica e
autorização autoral. Os domínios `[0,1]` são conferidos executavelmente.

Execuções:

- `Rscript scripts/verify_essential_input_gate0.R` → exit `0`, `PASS`.
- checker geral → `VALID`; lotes `[N1,N2] -> [N3,N4] -> [N6] -> [N7]`; ready
  `N1,N2`.
- checker com `--candidate N1 N2` → `VALID`.

A prontidão de N1/N2 é somente topológica. N4, N6, N7, Goal 2 e migração
permanecem sem autorização.

### Veredicto final

**PASS — 0 critical / 0 major / 0 minor.**
