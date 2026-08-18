## Parecer formal — Gate 0 beta<1, Round 2

- `reviewer_role`: `formal_design`
- `reviewer_id`: `review-gate0-beta-formal-2026-08-18-r2`
- Contrato avaliado: `sha256:2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- DAG: `sha256:740d0945ac2ee845331a75b7a0e5af1d49d2cc13a0c00dce98a386d8ff69fd21`
- Verifier: `sha256:c7255bc4cf98200f6ddde5e7f9d3596bd90a3c87042ac37eb10a5d00efd4d853`
- Veredicto estrito: **FAIL**
- Findings: **critical 0 / major 1 / minor 0**

### Auditoria substantiva do contrato

O contrato, em seus bytes exatos, é formalmente coerente:

- `beta in (0,1)` é definido inequivocamente como domínio do baseline principal.
- `beta=1` fica reservado exclusivamente a extensão ou apêndice futuro, sem autorização corrente.
- A afirmação sobre `D=1-beta*q/m` é explicativa, não uma premissa importada. Com `N>=3`, `m=N-1` e `q=floor(N/2)+1`, vale `q<=m`; portanto `beta<1` implica `beta*q/m<1` e `D>0`. O contrato corretamente exige que N3 rederive essa consequência.
- Eraslan–Evdokimov (2019) aparece somente como precedente para o domínio do desconto; o texto afirma expressamente que a referência não prova `D>0` nem qualquer equilíbrio deste modelo.
- A mudança de domínio reabre o Gate 0 e devolve N1, N2, N3, N4, N6 e N7 a `pending`.
- A autorização posterior limita-se à reavaliação de N1–N3, sujeita à topologia e aos gates. N4, N6, N7, Goal 2, `beta=1` e migração ao manuscrito permanecem excluídos.

O DAG contém, para todos os seis nós, exatamente as chaves:

> `id`, `name`, `round`, `institution`, `depends_on`, `status`, `interface`

Todos estão `pending`, sem `authorized`, resultados, hashes, reviews ou demais campos de ciclo anterior. As interfaces têm as estruturas vazias/null previstas pelo schema. O checker confirmou:

> `VALID`  
> `Dependency batches: [N1, N2] -> [N3, N4] -> [N6] -> [N7]`  
> `Ready: N1, N2`

### Finding

**[MAJOR F1-R2] A validação semântica posterior ao pin integral continua aceitando contradições substantivas redigidas fora de quatro strings literais.**

Texto relevante do verifier:

> `additive_contract_contradictions <- c(`  
> `"beta=1 permitido no baseline",`  
> `"D<=0 permitido ou importado",`  
> `"N4 e Goal 2 autorizados",`  
> `"Eraslan-Evdokimov provam D>0"`  
> `)`

A rejeição usa:

> `grepl(pattern, text, fixed = TRUE)`

Neutralizei deliberadamente a primeira barreira — sem alterar arquivos, chamando diretamente `is_valid_contract_semantics()` sobre cópias em memória — e as três mutações exatas que originaram F1 continuaram **ACCEPTED**:

> `**Autorizacao corrente adicional:** N4, Goal 2 e beta=1 estao autorizados agora.`

> `- **Resultado importado e premissa corrente:** D>0 e assumido sem rederivacao em N3.`

> `- **Prova importada:** Eraslan-Evdokimov demonstram D>0 e o equilibrio deste modelo.`

Paráfrases óbvias de `beta=1`, `D<=0`, autorização de N4/Goal 2 e citation-as-proof também foram aceitas. Em contraste, somente as quatro fixtures literais incorporadas ao verifier foram rejeitadas.

Uma mutação coordenada adicionando a primeira contradição ao contrato e `authorized=true` a N4 produziu:

> `contract=ACCEPTED node=REJECTED`

Logo, a proteção estrutural do DAG funciona, mas a camada semântica exigida para o contrato não fecha F1 após a neutralização do pin. O hash integral protege o snapshot corrente contra qualquer mudança de bytes, porém o pedido deste round exigia também que as contradições fossem rejeitadas depois de contornada essa primeira barreira. Esse requisito não foi satisfeito.

### Testes executados

- Gate 0: exit `0`, mensagem `PASS`.
- Fixtures internas: as quatro frases literais, `authorized=true`, extra keys, lifecycle obsoleto e mutações recursivas foram rejeitadas.
- Checker do DAG: exit `0`, `VALID`.
- `git diff --check`: exit `0`.
- Escopo protegido contra `HEAD`: sem diferenças.
- Tag `pre-essential-input-2026-08-12^{}`: `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- Branch: `codex/essential-input-beta-interior`.
- `HEAD`: `cc9cea6d2425c7d22daaf66bdbc96058cb147b16`.
- Worktree: apenas `scripts/verify_essential_input_gate0.R` está modificado; contrato, DAG, manuscritos e artefatos protegidos estão intactos.

Não editei nem criei arquivos.
