# Parecer independente adversarial — `A_C` fortalecido

**Snapshot:** `02d217283948fbf430a10491c0907d484dbac3b4`  
**Branch:** `agenda-extension-am-msb`  
**Modo:** estritamente read-only  
**Manifesto:** `509cc3540135721011f979ffd63ff1413b364fd8065b8c7a1ae581a572605e0e`

## Resultado

A matemática fortalecida está correta. Não encontrei erro em T5, `g_T5`,
`g_0`, `D_E`, no tratamento de `nu=0`, no exemplo `N=5` ou na fórmula de
paridade.

Encontrei duas inconsistências menores de redação e rastreabilidade. Elas não
alteram os teoremas, mas precisam ser reparadas antes do congelamento.

**FINAL_STATUS: FAIL — 0 Critical / 0 Major / 2 Minor**

O `FAIL` é do candidato como pacote pronto para congelamento, não uma rejeição
da matemática.

## Findings

### Minor 1 — A qualificação do acoplamento cross-world ainda contém uma afirmação absoluta

O texto agora reconhece corretamente que acoplamentos matemáticos existem, mas
afirma que `A_C` nunca identifica uma lei conjunta e que qualquer acoplamento
acrescenta uma convenção:

- `model_redesign/agenda_extension_AC_msb_contract.md`, Seção 6;
- `model_redesign/agenda_extension_AC_msb_results.md`, Seção 11;
- `model_redesign/agenda_extension_AC_msb_interface.json`, `outcome_scope`;
- `model_redesign/agenda_extension_AC_msb_claim_ledger.tsv`, `AC-MSB-019`.

Isso é forte demais em casos degenerados. Se uma marginal é Dirac, por exemplo
`mu_M=delta_x`, qualquer acoplamento com marginal `mu_U` é necessariamente
`delta_x times mu_U`. Nesse caso, o par de marginais determina uma única lei no
produto; não há escolha entre acoplamentos.

O ponto substantivo correto sobrevive: o game form não introduz choque comum,
dispositivo de correlação ou interpretação de realizações pareadas. A
formulação deve dizer:

> `A_C` preserva somente o par de leis marginais e não introduz um dispositivo
> cross-world. Em geral, as marginais não identificam um acoplamento único. Nos
> casos degenerados em que o acoplamento é matematicamente único, essa unicidade
> não autoriza interpretações substantivas de realizações pareadas além das
> operações declaradas.

### Minor 2 — A autorização específica do fortalecimento não percorre toda a cadeia de proveniência

A autorização correta, derivada do “do it”, existe e está pinada:

- `quality_reports/plans/2026-08-30_autorizacao_fortalecimento_A_C_pos_consulta.md`;
- primeira entrada do manifesto fortalecido;
- campo superior do DAG.

Entretanto:

- o contrato menciona apenas a autorização inicial;
- a interface também pina apenas a autorização inicial;
- o DAG registra a nova autorização fora de `nodes`, sem torná-la dependência
  de `A_C_contract` ou `A_C_candidate`;
- o claim de paridade ainda atribui sua autoridade ao hash inicial, não ao
  documento que autorizou expressamente esse resultado.

Um consumidor da interface isolada não consegue reconstruir a decisão que
autorizou os novos resultados. O reparo é puramente administrativo: pinar a
autorização de fortalecimento no contrato e na interface, representá-la como
nó/dependência no DAG e corrigir os claims cuja autoridade declarada é a
decisão nova.

## Auditoria matemática

- **T5 fortalecido:** correto. Dos bounds congelados,
  `V_M^theta>=Z_E`, `V_U^theta<=z_H`, e
  `Z_E-z_H=beta*(c/m-beta*o_1)=g_T5`. A mesma margem passa à média ex ante.

- **Corolário de célula baixa:** correto:
  `Z_E-z_L=beta*(c/m-beta*o_0)=g_0`.

- **Endpoint `nu=0`:** corretamente restrito. Como `V_g^E=V_g^0`, o bound
  com `o_0` prova a conclusão ex ante. O texto não promove automaticamente
  essa conclusão ao tipo alto contrafactual.

- **Exemplo `N=5`:** correto: `c/m=0.5`, `beta*o_1=0.54`, `Z_E=0.55`,
  `z_L=0.505`, `d_H=0.486`. Logo T5 falha, mas o bound de maioria supera os
  dois payoffs de unanimidade no endpoint. É um contraexemplo válido à
  necessidade, não à suficiência.

- **Paridade:** correta: `c/m=1/2` para `N` ímpar e
  `c/m=(N-2)/(2*(N-1))` para `N` par.

- **`D_E`:** corretamente construído como imagem afim dos vetores ligados de
  `D_01`, sem recombinar projeções marginais independentes.

## Integridade e lifecycle

- Manifesto fortalecido: **8/8 hashes OK**.
- Manifestos congelados de `A_M` e `A_U`: todos os itens **OK**.
- Nenhum byte das fontes congeladas mudou desde `8220d0d`.
- Interface e DAG: JSON válidos.
- Ledger: 24 claims, 16 colunas, IDs únicos.
- Verificador reproduzido sem output persistente: **1197 PASS / 0 FAIL**.
- A evidência mecânica foi tratada apenas como teste, não como prova.
- Worktree permaneceu limpa.
- `A_C` continua `pending/unfrozen`.
- `A_R`, manuscrito, tag, merge e push continuam não autorizados.

Nenhum arquivo foi editado, criado ou commitado nesta revisão.
