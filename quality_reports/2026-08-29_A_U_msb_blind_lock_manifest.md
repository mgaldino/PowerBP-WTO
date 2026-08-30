# Manifesto SHA-256 não autorreferente — blind-lock de `A_U`

**Data:** 2026-08-29  
**Payload verificável:**
`quality_reports/2026-08-29_A_U_msb_blind_lock_manifest.sha256`  
**Declaração cega:** esta solução foi fechada sem acesso ao candidato antigo.

O payload fixa os contratos autorizados, a única dependência congelada
`C_U`, a decisão downstream lida somente depois do fechamento estratégico
próprio, e todos os artefatos da reconstrução cega. Ele não contém o próprio
hash nem o hash deste wrapper; portanto é não autorreferente.

Antes deste lock, não foram lidos, buscados, abertos ou comparados artefatos
históricos de `A_U`, artefatos `AC`, auditorias do pacote privado, memórias,
rollouts, sessões ou resultados matemáticos de `A_M`.

As skills `solve-dynamic-games` e `formal-game-theory-polisci` governaram o
contrato, o DAG, a ordem reversa e os gates. O DAG passou o verificador da
skill com ordem de execução exigida, e o harness R registrou `1094 PASS / 0
FAIL`, sem alegar prova matemática.
