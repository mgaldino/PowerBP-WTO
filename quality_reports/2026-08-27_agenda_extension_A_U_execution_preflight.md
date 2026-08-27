# Registro de execução e preflight — `A_U`

**Data:** 2026-08-27

**Escopo:** somente reconstrução cega de `A_U`; sem `A_M`, `AC`, `AR`,
manuscrito, push, merge ou mudança do DAG.

**Status:** candidato completo não revisado; `A_U` continua `pending` no DAG.

## Preflight

- `HEAD` inicial: `8b5ea05b355c870116d0b70d7b5fbbea81b44176`;
- worktree inicial: limpa;
- `C_U` recalculado:
  `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`,
  igual ao hash esperado;
- contrato simplificado:
  `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4`;
- manifesto do Goal 1:
  `588e7da2ec7df2f208ccaf082d3bc30834ea12625484b04b25d3eae7fce20a86`.

Foram lidos integralmente `CLAUDE.md`, `AGENTS.md`, o contrato simplificado,
os dois fechamentos, a auditoria e o manifesto do Goal 1, `C_U`, as três fontes
normativas presas pelo manifesto e os `SKILL.md` de
`formal-game-theory-polisci` e `solve-dynamic-games` (incluído seu template de
dependências). Não foi acessado nenhum candidato, derivação, ledger preenchido,
commit, conversa ou resultado de `A_M`, nem a worktree proibida.

## Arquivos de `A_U` e hashes antes do commit

| Arquivo | SHA-256 |
|---|---|
| `model_redesign/agenda_extension_A_U_candidate_simplified.json` | `d4bedcc1d579a38ca2a095ab2f1ce0256d1b4ce0af039076c2a954eeee3e47a7` |
| `model_redesign/agenda_extension_A_U_derivation_simplified.md` | `4100baa6b3fa00ccbc5ef1c9b8d656e14d844fdc6a36026fe61eb855b378e8e5` |
| `model_redesign/agenda_extension_A_U_claim_ledger_simplified.tsv` | `fb8447d5aff10efdc600ad4753066636f86e994985d802684b19ddde2139d3dc` |
| `scripts/verify_agenda_extension_A_U_mechanical.R` | `c5032f7baf8748a0bff2638c1a62d8ab609a8a964503975661dcf9c5d1270e60` |

O hash deste próprio registro é calculado e reportado externamente para evitar
autorreferência.

## Verificações

### Checker específico de `A_U`

```text
Rscript --vanilla scripts/verify_agenda_extension_A_U_mechanical.R
SUMMARY | 14 PASS | 0 FAIL
```

Ele verifica JSON, schemas mínimos de famílias e imagens, binders, ledger,
hash de `C_U`, ausência de payoff-sentinela, identidades algébricas e
testemunhas finitas. Não prova equilíbrio.

### Runner histórico do Goal 1

Depois do preenchimento legítimo do ledger `A_U`:

```text
Rscript --vanilla scripts/verify_agenda_extension_goal1.R
SUMMARY | 30 PASS | 1 FAIL
```

A única falha é `gate0_hash_A_U_empty_ledger`: o runner prende historicamente
os bytes do ledger vazio aprovado no Gate 0, enquanto o ledger corrente agora
contém as 16 linhas exigidas por `A_U`.

```text
Rscript --vanilla scripts/test_agenda_extension_goal1.R
SUMMARY | 38 PASS | 1 FAIL
```

A única falha é a agregação `repository_positive_all_checks`, herdada da mesma
divergência esperada do ledger vazio. Os 38 testes positivos e negativos
restantes passam. O verificador, o conjunto de testes, o manifesto e o DAG não
foram alterados.

Os avisos de locale do R não mudaram parsing, hashes ou resultados.

## Limite probatório

A prova matemática está em
`model_redesign/agenda_extension_A_U_derivation_simplified.md`. O script é
somente falsificação mecânica. Este registro não marca `A_U` como `pass` e não
substitui as duas revisões matemáticas finais do pacote privado depois de `AC`.
