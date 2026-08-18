## Parecer formal — Gate 0 beta<1, Round 3

- `reviewer_role`: `formal_design`
- `reviewer_id`: `review-gate0-beta-formal-2026-08-18-r3`
- Contrato: `sha256:2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- DAG: `sha256:740d0945ac2ee845331a75b7a0e5af1d49d2cc13a0c00dce98a386d8ff69fd21`
- Verifier: `sha256:f5755f4fa182faf9184c6e488794b2303fdb4baf659b410ed2b7b9c810a89c93`
- Veredicto estrito: **PASS**
- Findings: **critical 0 / major 0 / minor 0**

### Auditoria substantiva

O contrato integral permanece coerente e inequívoco:

- `beta in (0,1)` é a primitiva exclusiva do baseline principal.
- `beta=1` permanece apenas como extensão futura não autorizada.
- `D=1-beta*q/m` é explicitamente consequência a rederivar em N3, não resultado importado. Como `N>=3`, `m=N-1`, `q=floor(N/2)+1<=m` e `beta<1`, segue `D>0`; o contrato corretamente exige nova derivação antes de incorporar esse resultado.
- Eraslan–Evdokimov é usado somente como precedente para o domínio do desconto; o contrato nega expressamente que a referência prove `D>0` ou o equilíbrio deste modelo.
- A alteração de `beta` reabre o Gate 0 e mantém N1, N2, N3, N4, N6 e N7 em `pending`.
- A autorização alcança somente a reavaliação de N1–N3, respeitada a topologia. N4, N6, N7, Goal 2, `beta=1` e migração ao manuscrito seguem não autorizados.

### Fechamento do finding anterior

O verifier agora fixa três objetos normativos regionais completos:

- cabeçalho de status e autorização: `dd1d2bb6b8ce16f4604057e87c1edfcd4e3d4d413268a24d3d17616b554f3467`;
- linha primitiva de `beta`: `bb7ee3390b0f63a4d293fe8deab7d33fea725d280ad43121c615375f96bf41b4`;
- seção integral sobre custo estrito de atraso: `3c4483859bc7cdaf36c8fe3c4a1c2d54a278e40980eacdaba2fb9b684ebb8f2a`.

Neutralizei o pin global chamando diretamente a validação regional sobre objetos em memória. Foram rejeitadas:

- as três mutações originais do finding anterior;
- as seis paráfrases incorporadas ao verifier;
- quatro paráfrases independentes adicionais sobre `beta=1`, `D<=0`, autorização de N4/Goal 2 e uso da citação como prova.

Resultado: **13/13 REJECTED**. A validação deixou de depender de reconhecer frases literais específicas: qualquer alteração dentro das fontes normativas ancoradas muda o hash regional.

### Manifesto e interfaces `pending`

O envelope canônico foi aceito, enquanto quatro mutações independentes foram rejeitadas:

- chave superior adicional;
- chave superior ausente;
- reordenação das chaves;
- renomeação de chave.

As interfaces são comparadas por identidade estrutural completa. Foram rejeitadas mutações em:

- ordem de `function_of` e substituição de `null` por `[]` em N1;
- ordem e extra field dentro de `private_rule_cells` em N6;
- ordem de rodadas, ordem de tipos e extra field profundo em N7;
- `authorized=true` no nó, na interface e em `function_of`;
- valores, chaves e estruturas recursivas de todos os nós.

A mutação coordenada de autorização foi rejeitada simultaneamente nas três barreiras:

> `contract=REJECTED envelope=REJECTED N4=REJECTED`

### Execução e integridade

- `Rscript --vanilla scripts/verify_essential_input_gate0.R`: exit `0`, `PASS`.
- Checker do DAG: exit `0`, `VALID`.
- Ordem: `[N1, N2] -> [N3, N4] -> [N6] -> [N7]`.
- Prontidão exclusivamente topológica: `N1, N2`.
- `git diff --check`: exit `0`.
- Contrato e DAG sem diferenças contra `HEAD`.
- Artefatos protegidos da Seção 13 sem diferenças.
- Nenhum arquivo protegido apareceu entre os untracked.
- Branch: `codex/essential-input-beta-interior`.
- `HEAD`: `cc9cea6d2425c7d22daaf66bdbc96058cb147b16`.
- Tag, após peeling: `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- O worktree contém somente o verifier candidato modificado e dois pareceres Round 2 não rastreados; não há alteração do contrato, DAG ou escopo protegido.

Não editei nem criei arquivos.
