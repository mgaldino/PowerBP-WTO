# Parecer independente `game_theory` — N3 v5

**Data:** 2026-08-20
**Papel:** `game_theory`
**Modo:** read-only
**Veredicto:** **FAIL**
**Findings:** `0 critical / 1 major / 1 minor / 0 epistemic`

## Objeto auditado

- Commit inicial: `96c04ca76637743259f216077c3b3b061ce09e78`.
- Candidato: `model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v5.json`.
- SHA-256 inicial e final: `b30c63ac1afd29d7b1af64e9a8734270feea94bced2c8ec7e3c3bf2a94f405cb`.
- Implementador e revisor são agentes distintos; o revisor não editou arquivos.

## Resultado substantivo

A rederivação fria desde o contrato e N1 confirmou integralmente a matemática do candidato:

- continuação `c=beta/m` e `a_theta=beta*o_theta`, com desconto único;
- cutoff weak `x_j>=beta/m`, stage-undominance somente para weak voters e `T^Y` na igualdade;
- três casos corretos de H: não pivotal, pivotal e falha inevitável;
- redução exaustiva a `E`, `S`, `P` e `R`;
- `E-R=1-beta*q/m>0`;
- fronteiras `nu_SP` e `nu_SE`, endpoints fechados e as onze células;
- tie-break que minimiza o payoff esperado de H, inclusive a correspondência mista `E/P`;
- propostas, factibilidade, payoffs por identidade, outcomes e crenças para todos os vetores de voto de probabilidade zero;
- multiplicidade pura e mista sem simetria imposta.

A simultaneidade do ballot foi respeitada: `k_i(s)` é inferido das estratégias puras conhecidas após a proposta, não de votos observados antes da escolha de H.

Testes independentes adicionais cobriram 32.736 comparações de ballots weak, 130.944 de H, 100.000 ambientes paramétricos, 336 fronteiras, 7.800 payoffs por identidade e 189 misturas assimétricas. Não foi encontrada família de equilíbrio omitida nem erro no JSON matemático.

O verifier oficial também confirmou duas builds subprocessuais reais, identidade semântica v4→v5, 1.109 paths do candidato, 305 do ledger e 17 claims. Esses PASS operacionais, contudo, são superados pelos findings abaixo.

## Finding N3V5-GT-01 — major técnico: falso PASS common-mode persiste

O oracle não valida semanticamente todas as folhas que marca como cobertas. Parte relevante usa tokens e blacklists; as fórmulas escalares são comparadas apenas em poucos fixtures públicos.

Mutações materiais aceitas pelo validador completo, somente em memória:

- a corrupção histórica exata `999*o_0` no coeficiente do payoff misto de H;
- fator `999` na probabilidade mista de passagem com H;
- fatores `999` nos mapas weak misto e low-type-only;
- polinômios não nulos adicionados ao payoff do proponente e à fronteira, construídos para zerar somente nos fixtures publicados;
- 565 das 1.109 folhas do candidato após acrescentar uma autonegação explícita;
- os 17 textos de claims do ledger e as 17 seções da derivação após autonegação explícita.

A negativa oficial para o coeficiente misto troca `o_0` por `2*o_0`, enquanto o oracle proíbe literalmente `2*o_0`; ela não reproduz a corrupção histórica `999*o_0`, que passou. As mutações folha a folha substituem strings por `"0"`, o que prova rejeição de destruição grosseira, não equivalência semântica.

Locais centrais: `scripts/oracle_essential_input_n3_v5.R`, especialmente seus validadores por tokens, e `scripts/test_essential_input_n3_v5_common_mode.R`.

Consequência: corrupção coordenada de builder, candidato e referências estruturais ainda pode receber falso PASS. Isso viola diretamente o requisito já autorizado de oracle algébrico independente com cobertura de todas as folhas. É reparo técnico já autorizado; não requer nova escolha sobre jogo, schema ou interface.

## Finding N3V5-GT-02 — minor técnico: source guard é lexicalmente contornável

Em memória, o revisor extraiu o constructor completo de 489 linhas, renomeou a função, alterou dois espaçamentos e acrescentou comentários às linhas. O código:

- continuou executável;
- reproduziu interface e ledger byte-semanticamente após serialização;
- passou pelo source guard com `longest=7` e nenhuma expressão proibida.

O guard está em `scripts/verify_essential_input_n3_v5.R`.

A classificação é `minor` porque a inspeção do oracle efetivamente presente confirmou que ele não importa nem reconstrói o builder. O problema é a força excessiva da mensagem automatizada `SOURCE_INDEPENDENCE`, não uma cópia existente neste hash.

## Integridade e fronteira

- N1 permaneceu pass/frozen em `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`.
- Gate0 e N1: PASS; DAG `--require-execution-order` e `--candidate N3`: VALID.
- Tag protegida: `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- O HEAD avançou durante a auditoria de `96c04ca` para `c56a0c4`, exclusivamente para registrar um parecer N4. Todos os blobs N1/N3 auditados permaneceram inalterados.
- Worktree final limpa no encerramento do parecer; nenhum arquivo, PDF, commit ou lifecycle foi criado ou alterado pelo revisor.
- N3 permanece `pending/unfrozen`; este parecer não autoriza freeze, N6 ou N7.
