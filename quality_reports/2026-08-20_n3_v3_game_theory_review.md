# Parecer independente `game_theory` — N3 v3

**Data:** 2026-08-20

**Papel:** `game_theory`, read-only

**Candidato:** `model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v3.json`

**SHA-256:** `8b47f6ed3ecf8e63f868bafd51f87fc76fff05545ebf9977ef5c1b27276005a9`

**Commit auditado:** `fd6de38798018f870251f83370519f6e92737157`

**Veredicto:** **FAIL**
**Findings finais após clarificação:** `critical=0 / major=1 / minor=0 / epistemic=0`

## Integridade

- N1 foi consumido no hash congelado `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`.
- O candidato e os artefatos N1/N3 auditados permaneceram idênticos aos blobs do commit antes e depois do parecer.
- A tag protegida permaneceu, após peeling, em `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- Gate0, verifier de N1, verifier N3 v3 e checker canônico do DAG passaram; warnings isolados de locale não foram findings.
- O revisor ignorou os artefatos N4 concorrentes e o outro parecer. Nenhum arquivo foi criado ou editado e nenhum PDF foi produzido.

## Resultado substantivo

A rederivação independente confirmou a correspondência matemática integral: continuação `c=beta/m`, cutoff weak com `T^Y`, três casos de pivotalidade de H, valores E/S/P/R, dominância estrita de E sobre deliberate failure, fronteiras, endpoints, onze células, empate E/P, convenções puras e misturas por identidade, payoffs, outcomes e crenças completas.

Os testes independentes cobriram 48.345 casos de ballot, 200.000 sorteios de regiões, 3.480 endpoints/knife-edges e 720 misturas assimétricas por identidade.

## Finding N3V3-GT-01 — major técnico: oracle aceita corrupções common-mode

O oracle não ligava todos os seus cálculos aos campos exportados. Na célula mista, procurava apenas tokens, sem verificar coeficientes de payoffs ou probabilidades. Também não validava integralmente `domain_conditions`, o ballot map, os candidate payoffs ou `selection_status`.

Com pins externos neutralizados somente em memória, o oracle aceitou:

1. coeficiente `999*o_0` no payoff misto de H;
2. probabilidade `999/m` de `pass_with_hegemon`;
3. cutoff weak invertido com `T^Y=no`;
4. domínio de célula impossível;
5. payoff de exclusão igual a `999`;
6. imposição de pesos simétricos entre identidades.

Quando candidato e objeto esperado receberam a mesma mutação, a comparação estrutural também passou. O verifier ainda serializava duas vezes uma única construção, em vez de executar o builder duas vezes. Algumas negativas oficiais usavam `require_oracle=FALSE`, confirmando que provavam identidade com o builder, não independência semântica.

## Disposição

O JSON exato está matematicamente correto, mas o pacote não sustenta `PASS 0/0/0`: pode certificar uma interface incorreta quando builder e candidato compartilham o erro. N3 v3 permanece `pending/unfrozen`; não autoriza freeze, N6, N7 ou lifecycle.

Após considerar o mandato autoral já vigente, o revisor esclareceu que parsing,
projeção semântica executável ou vínculos campo a campo são apenas implementações
técnicas equivalentes. O requisito funcional já está univocamente fixado: oracle
independente do builder, cobertura de todas as folhas semânticas, negativas que
neutralizem common mode e duas builds efetivamente separadas. O finding é,
portanto, `major` técnico, não epistêmico, e não requer novo aval autoral.

O novo candidato deve implementar esses reparos, reexecutar o pacote completo e
retornar aos dois papéis read-only no novo hash. Novo aval só seria necessário
se a implementação revelasse divergência matemática ou exigisse mudança
semântica com mais de uma solução possível.
