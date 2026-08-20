# Parecer independente `formal_design` — N3 v3

**Data:** 2026-08-20

**Papel:** `formal_design`, read-only

**Candidato:** `model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v3.json`

**SHA-256:** `8b47f6ed3ecf8e63f868bafd51f87fc76fff05545ebf9977ef5c1b27276005a9`

**Commit auditado:** `fd6de38798018f870251f83370519f6e92737157`

**Veredicto:** **FAIL**
**Findings:** `critical=0 / major=1 / minor=1 / epistemic=0`

## Integridade

- N1 foi consumido no hash congelado `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`.
- O candidato e os seis artefatos auxiliares coincidiram com os blobs do commit auditado antes e depois do parecer.
- A tag protegida permaneceu, após peeling, em `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- Gate0, verifier de N1, verifier N3 v3 e os checks canônicos do DAG passaram.
- Artefatos N4 concorrentes foram ignorados. O revisor não criou nem editou arquivos.

## Resultado substantivo

A rederivação independente não encontrou erro na correspondência matemática: dependência exclusiva de N1, desconto único, respostas dos weak voters e de H, redução a E/S/P/R, onze células, fronteiras, endpoints, tie-break, factibilidade, payoffs, outcomes, multiplicidade, crenças on-path e off-path completas e mapas por identidade coincidiram com o candidato.

Como evidência adicional, o revisor executou 200.000 draws, enumerou todos os vetores binários de votos para `N=3,...,12`, verificou 1.109 mutações escalares do candidato e 305 do ledger contra a comparação estrutural e confirmou as 21 mutações oficiais dirigidas.

## Finding N3V3-FD-01 — major: falso PASS common-mode no oracle

Com os pins externos neutralizados somente em memória, o revisor corrompeu simultaneamente o candidato e o objeto estrutural esperado, simulando drift coordenado entre builder e candidato. `oracle_validate_candidate()` aceitou corrupções materiais em:

1. `candidate_payoffs_in_primitives$low_type_only`;
2. mapa completo do payoff do proponente;
3. regra de voto weak no ballot;
4. fronteira da primeira célula;
5. coeficiente do payoff de H na célula mista, mantendo apenas os tokens buscados.

O oracle calculava a álgebra correta internamente, mas não a ligava a todas essas folhas exportadas. A comparação estrutural rejeitava drift unilateral, porém não o drift common-mode que motivou a autorização de um oracle independente. Assim, as mensagens de PASS sobre ballots, fronteiras, regiões e todos os payoffs eram mais amplas que a evidência executável.

## Finding N3V3-FD-02 — minor: uma construção serializada duas vezes

O verifier chamava `make_n3_v3_objects()` uma única vez e escrevia o mesmo objeto em dois destinos. Isso testava estabilidade da serialização, não duas execuções reais do builder, apesar da mensagem de PASS afirmar o contrário.

## Disposição e reparo já autorizado

N3 v3 permanece `pending/unfrozen` e não pode ser congelado ou consumido. A autorização autoral anterior já fecha o único reparo semântico admissível:

1. o oracle, sem importar objetos ou funções do builder, deve ligar suas derivações a todas as folhas matemáticas da interface;
2. negativas common-mode devem corromper candidato e objeto esperado em conjunto e ainda ser rejeitadas pelo oracle;
3. o verifier deve executar duas construções reais e independentes e comparar seus bytes;
4. o novo hash deve voltar aos dois papéis independentes de revisão.

Parsing, projeção semântica executável ou vínculos locais campo a campo são somente escolhas técnicas equivalentes, não novas escolhas sobre jogo, schema, interface, fórmulas, seleção ou protocolo.
