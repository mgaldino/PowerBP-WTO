# Parecer independente `formal_design` — N3 v5

**Data:** 2026-08-20
**Papel:** `formal_design`
**Modo:** read-only
**Veredicto:** **FAIL**
**Findings:** `0 critical / 0 major / 0 minor / 1 epistemic`

## Objeto auditado

- Commit: `96c04ca76637743259f216077c3b3b061ce09e78`.
- Candidato: `model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v5.json`.
- SHA-256 inicial e final: `b30c63ac1afd29d7b1af64e9a8734270feea94bced2c8ec7e3c3bf2a94f405cb`.
- Implementador e revisor são agentes distintos; o revisor não editou arquivos nem leu o parecer `game_theory` de N3 v5.

## Finding N3V5-FD-01 — epistemic: cobertura semântica superestimada

A separação física builder–oracle existe: não há import do builder, o maior trecho normalizado comum tem sete linhas e os guards rejeitam a injeção literal de blocos longos. Isso não basta para demonstrar independência semântica ou correção folha a folha.

O problema combina três mecanismos:

- fórmulas escalares são testadas em apenas quatro fixtures fixos no oracle;
- fórmulas com somatórios, payoffs weak, payoffs mistos de `H`, outcomes mistos e textos normativos são validados principalmente por presença ou ausência de tokens;
- o teste descrito como exaustivo substitui cada string inteira por `"0"`, portanto testa visitação de paths e rejeição de alterações grosseiras, não equivalência matemática.

Em testes exclusivamente em memória, sem alterar arquivos, o oracle aceitou:

| Alteração | Resultado |
|---|---|
| Acrescentar ao payoff do proponente `(beta-.21)*(beta-.64)*(beta-.83)*(beta-.97)`, termo que zera exatamente nos quatro fixtures | `ACCEPTED` |
| Trocar `1/m` por `2/m` no segundo termo do payoff weak por identidade | `ACCEPTED` |
| Acrescentar `+1` dentro da fórmula do payoff misto de `H` | `ACCEPTED` |
| Acrescentar `+1` dentro da probabilidade mista de passagem | `ACCEPTED` |
| Acrescentar ao candidato uma frase afirmando que votos weak dependem de `theta`, contradizendo a frase anterior | `ACCEPTED` |
| Acrescentar ao claim do ledger que `beta` entra duas vezes | `ACCEPTED` |
| Acrescentar à derivação que o claim é falso e `beta` entra duas vezes | `ACCEPTED` |

Logo, as mensagens impressas pelo verifier devem ser lidas como “todos os paths foram visitados por algum check”, não como validação matemática independente de cada folha.

Segundo §11.1, não é reparo técnico de solução única: AST simbólica, DSL tipada, formas canônicas e diferentes estratégias de testes são reparos plausíveis. O finding deve ser escalado.

## Rederivação substantiva

A interface congelada de N1 fornece, em R2, `1/m` a cada weak state antes do reconhecimento e `o_theta` a `H`. Transportados uma única vez para R1:

- `c=beta/m`;
- continuação de `H(theta)=beta*o_theta`.

Para cada proposta:

- weak nonproposer vota `yes` exatamente quando `x_j>=beta/m`; `T^Y` decide a igualdade;
- se `k>=q-1`, `H` não é pivotal e vota `no`, pois recebe `y+o_theta` em vez de `y`;
- se `k=q-2`, `H(theta)` vota `yes` exatamente quando `y>=beta*o_theta`;
- se `k<=q-3`, ambos os votos conduzem à mesma continuação e `T^Y` seleciona `yes`.

Os quatro valores do proponente foram confirmados:

- `E=1-beta*(q-1)/m`;
- `S(nu)=(1-nu)*[1-beta*o_0-beta*(q-2)/m]+nu*beta/m`;
- `P=1-beta*o_1-beta*(q-2)/m`;
- `R=beta/m`.

Também foram confirmados:

- `E-R=1-beta*q/m>0`;
- `P-E=beta*(1/m-o_1)`;
- `S-E=(1-nu)*beta*(1/m-o_0)-nu*(1-beta*q/m)`;
- `nu_SP=beta*(o_1-o_0)/[1-beta*o_0-beta*(q-1)/m]`;
- `nu_SE=beta*(1/m-o_0)/[beta*(1/m-o_0)+1-beta*q/m]`.

As onze células são mutuamente exclusivas e exaustivas, inclusive `nu=0`, `nu=1`, `o_0=1/m`, `o_1=1/m`, as igualdades `S=P` e `S=E` e o empate residual `h_E=h_P`. O tie-break atribui corretamente as fronteiras `S=P` e `S=E` ao ramo low-type-only.

No knife-edge `o_1=1/m`, acima de `nu_SE`, a comparação correta é:

- `h_E=(1-nu)*o_0+nu/m`;
- `h_P=beta/m`.

Quando `h_E=h_P`, todas as escolhas puras por identidade e todas as misturas entre exclusão e pooling devem permanecer, como faz o candidato.

Os payoffs por tipo, outcomes, crenças on-path/off-path, atualização para posterior um após falha low-type-only, coalizões assimétricas e payoffs weak por identidade também estão corretos. O caso `m=2` permanece coberto.

Os 17 claims substantivos, C01–C17, passaram individualmente. Além da prova manual, 1.000 avaliações aleatórias fora dos quatro fixtures confirmaram todas as fórmulas escalares do candidato atual. Não foi encontrado erro matemático no blob submetido.

## Builds, integridade e lifecycle

- Duas builds reais, em subprocessos separados, foram byte-estáveis.
- Candidato, ledger e as 17 seções matemáticas v5 são idênticos a v4 após normalização exclusiva do namespace.
- N1 permaneceu congelado em `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`.
- Gate0: PASS.
- Tag protegida: `f53e6769624ce3dd6e64e21ad40d08230b0950a7` após peeling.
- DAG: N1 `pass/frozen`; N3 `pending/unfrozen`, dependendo somente de N1.
- O commit auditado é ancestral do HEAD administrativo `5b22c7ef00187e58ea3e8c9c4fceea8609cff245`; os sete artefatos N3 v5, contrato, DAG e N1 permaneceram inalterados.
- Quatro artefatos N4 v4 surgiram concorrentemente no worktree e não foram lidos, editados nem removidos pelo revisor.
- N3 permanece `pending/unfrozen`; não autoriza freeze, N6 ou N7.

## Recomendação para decisão autoral

Substituir a validação por tokens por uma representação matemática tipada:

1. AST canônica e comparação simbólica para todas as fórmulas escalares.
2. Estruturas explícitas de coeficientes, índices e restrições para somatórios.
3. Aritmética exata e avaliações fora dos fixtures como defesa complementar, nunca substituto da equivalência simbólica.
4. Claims normativos estruturados em campos verificáveis; prosa livre não deve contar como semanticamente validada.
5. Testes que preservem tokens e alterem coeficientes, termos, endpoints ou lógica.
6. Até o reparo, rotular o resultado como visitação estrutural com validação semântica parcial.

Qualquer novo hash deve retornar aos mesmos dois papéis independentes.
