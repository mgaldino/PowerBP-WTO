## Parecer formal — Gate 0 beta<1, Round 4

- `reviewer_role`: `formal_design`
- `reviewer_id`: `review-gate0-beta-formal-2026-08-18-r4`
- Contrato: `sha256:2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- DAG: `sha256:740d0945ac2ee845331a75b7a0e5af1d49d2cc13a0c00dce98a386d8ff69fd21`
- Verifier: `sha256:7015ed544927085f72b76b4aec0dcdcd6fc091e08599ff186a9b2cb5a9a9fa0d`
- Veredicto estrito: **PASS**
- Findings: **critical 0 / major 0 / minor 0**

### Identidade integral do contrato

A dupla identidade autorizada está implementada corretamente:

1. O pin externo compara os bytes do arquivo com o hash aprovado.
2. Depois da leitura UTF-8, `is_valid_contract_semantics()` recalcula a identidade do texto integral contra o mesmo snapshot aprovado.

Neutralizei somente a primeira comparação, mantendo intactos o hash esperado e toda a validação interna. A segunda identidade rejeitou alterações:

- no início do contrato;
- em seção intermediária;
- na parte final e no escopo protegido;
- por byte adicional;
- pela remoção do newline terminal.

Também foram rejeitadas:

- as nove fixtures originais e paráfrases: **9/9**;
- as nove mutações integrais do Round 3, inclusive mudanças nas Seções 2, 11, 12 e 13: **9/9**;
- a mutação coordenada das Seções 2 e 11.

As âncoras regionais permanecem como diagnóstico adicional, mas a rejeição já decorre da identidade integral. Não imponho requisito semântico adicional além do snapshot autoral aprovado.

### Identidade integral do manifesto

O DAG possui igualmente duas barreiras:

1. hash externo dos bytes do JSON;
2. identidade recursiva do objeto canônico, acompanhada pelo hash da serialização JSON canônica.

Com o objeto original, a validação retornou `ACCEPTED`. Os testes adversariais produziram:

- extra field inserido em cada objeto-lista, do topo ao nível mais profundo: **86/86 REJECTED**;
- substituição recursiva de cada campo nomeado: **196/196 REJECTED**;
- preenchimento profundo de uma célula `pending`: `REJECTED`;
- mutação coordenada com `authorized_nodes`, `N4.authorized=true` e alteração contratual: contrato, manifesto e nó, todos `REJECTED`.

Isso cobre chaves superiores, schemas, regras de invalidação, freeze gate, nós e interfaces aninhadas. A identidade integral impede extras, remoções, reordenações e mudanças de valor em qualquer profundidade.

### Auditoria substantiva

Contrato e DAG permanecem invariantes e coerentes:

- baseline: `beta in (0,1)`;
- `beta=1`: somente extensão futura não autorizada;
- `D=1-beta*q/m`: consequência a rederivar em N3, não premissa importada;
- Eraslan–Evdokimov: precedente de domínio, não prova;
- todos os seis nós: `pending`, com interfaces null exatas;
- autorização: somente N1–N3, respeitada a topologia;
- N4, N6, N7, Goal 2, `beta=1` e manuscrito: não autorizados.

### Execução

- Gate 0: exit `0`, `PASS`.
- Checker: exit `0`, `VALID`.
- Batches: `[N1, N2] -> [N3, N4] -> [N6] -> [N7]`.
- Prontidão apenas topológica: `N1, N2`.
- `git diff --check`: exit `0`.
- Contrato e DAG sem diferenças contra `HEAD`.
- Escopo protegido sem diferenças.
- Branch: `codex/essential-input-beta-interior`.
- `HEAD`: `cc9cea6d2425c7d22daaf66bdbc96058cb147b16`.
- Tag após peeling: `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- O worktree contém somente o verifier candidato e pareceres anteriores não rastreados; nenhum é artefato protegido.

Não editei nem criei arquivos.
