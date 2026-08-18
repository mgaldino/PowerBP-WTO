# Parecer final — Gate 0 `beta<1`

`reviewer_role=formal_design`  
`reviewer_id=review-gate0-beta-formal-2026-08-18-r1`

## Veredicto

**FAIL**

Contrato examinado: `sha256:2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`

Contagens:

- critical: **0**
- major: **1**
- minor: **0**

O contrato exato está substantivamente correto. O FAIL decorre de uma falha major nos gates negativos do verifier.

## Fronteira e hashes confirmados

- Branch: `codex/essential-input-beta-interior`
- HEAD: `341492c88908e23171180875bbc0c2971e4a184a`
- Tag anotada `pre-essential-input-2026-08-12`, após peeling: `f53e6769624ce3dd6e64e21ad40d08230b0950a7`
- O merge-base com HEAD coincide com essa fronteira.
- DAG: `740d0945ac2ee845331a75b7a0e5af1d49d2cc13a0c00dce98a386d8ff69fd21`
- Gate 0 verifier: `c3342606ab88c2f194bf392645538046eb50e0394112b05e7c3912359085c42f`

O worktree contém somente as três modificações esperadas deste Gate 0: contrato, DAG e verifier. `git diff --check` passou. Os arquivos protegidos da Seção 13 não têm diff contra HEAD.

## Auditoria substantiva do contrato

O escopo está preciso:

- A primitiva canônica é `beta in (0,1)`.
- `beta=1` está explicitamente excluído do baseline e reservado a extensão ou apêndice futuro não autorizado.
- Para `N>=3`, `q=floor(N/2)+1<=m=N-1`. Portanto `beta<1` implica `beta*q/m<1` e, se a fórmula for rederivada, `D=1-beta*q/m>0`.
- O texto classifica corretamente essa relação como “**Consequência a reavaliar, não premissa transportada**” e exige que N3 a revalide desde as primitivas.
- Eraslan–Evdokimov é chamado explicitamente de “**Precedente de domínio, não prova**”; o contrato também afirma que a referência não demonstra `D>0` nem qualquer equilíbrio deste modelo. A página primária confirma o artigo de 2019 e seu caráter de revisão de bargaining legislativo e multilateral, incluindo extensões por preferências temporais e de risco. [Annual Reviews](https://www.annualreviews.org/content/journals/10.1146/annurev-economics-080218-025633)
- A mudança de primitiva aciona corretamente a Seção 12: N1, N2, N3, N4, N6 e N7 estão `pending`, com interfaces `null` e sem lifecycle, hashes ou reviews antigos.
- Depois dos dois pareceres do contrato, a autorização alcança somente a reavaliação de N1–N3, respeitadas as dependências. Não autoriza N4, Goal 2, N6, N7, `beta=1` ou manuscrito.

## Testes executados

O Gate 0 real terminou em PASS. O checker retornou:

```text
VALID
Dependency batches: [N1, N2] -> [N3, N4] -> [N6] -> [N7]
Ready: N1, N2
```

Os gates negativos rejeitaram corretamente:

- N3 antes de N1;
- N4 antes de N2;
- batch ancestral `N1 N2 N3`;
- status PASS, hashes, reviews ou interfaces preenchidas residuais;
- domínio antigo `beta in (0,1]`;
- remoção da exclusão explícita de N4/N6/N7/Goal 2/`beta=1`;
- nove fixtures do checker.

A invalidação foi confirmada para todos os nós:

- N1 → N3, N6, N7;
- N2 → N4, N6, N7;
- N3 ou N4 → N6, N7;
- N6 → N7;
- N7 → nenhum descendente.

## Finding F1 — major

**Texto do finding:**

> O verifier `c3342606ab88c2f194bf392645538046eb50e0394112b05e7c3912359085c42f` valida `beta<1`, a natureza não importada de `D>0`, o uso da citação e a fronteira de autorização apenas pela presença de substrings corretas. Ele não rejeita afirmações contraditórias simultâneas nem ancora o contrato integral. Consequentemente, o verifier completo pode retornar PASS para um contrato que, no próprio cabeçalho, também autorize N4, Goal 2 e `beta=1`, ou que transforme `D>0` e Eraslan–Evdokimov em prova importada.

**Evidência:**

As funções relevantes usam apenas `grepl(...)` positivo nas linhas 1131–1151 de `scripts/verify_essential_input_gate0.R`. Após substituir apenas a leitura do contrato em memória, mantendo todo o restante do verifier intacto, o verifier completo aceitou estas três mutações exatas:

```text
**Autorizacao corrente adicional:** N4, Goal 2 e beta=1 estao autorizados agora.
```

```text
- **Resultado importado e premissa corrente:** D>0 e assumido sem rederivacao em N3.
```

```text
- **Prova importada:** Eraslan-Evdokimov demonstram D>0 e o equilibrio deste modelo.
```

Resultados observados:

```text
contradictory_header_authorization FULL_VERIFIER_ACCEPTED
imported_D_result FULL_VERIFIER_ACCEPTED
citation_as_model_proof FULL_VERIFIER_ACCEPTED
```

A falha é **major** porque atinge diretamente os gates que deveriam impedir ampliação de autorização e importação de resultados. Não a classifico como técnica: há mais de um reparo plausível — pin do hash integral, validação estrutural das seções canônicas ou proibições semânticas explícitas — e o contrato exige escalada quando não há reparo único.

Nenhum arquivo foi editado pelo revisor.
