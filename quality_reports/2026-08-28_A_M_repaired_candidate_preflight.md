# Preflight final — candidato reparado de `A_M`

**Data:** 2026-08-28  
**Worktree:** `/Users/manoelgaldino/.codex/worktrees/4678/PowerBayesianPersuasion`  
**Base Git:** `b427671efee954831901e75762988043a2df7205`  
**Estado:** `REPAIRED CANDIDATE — EXTERNAL FINDINGS IMPLEMENTED — REVIEW PENDING`

## Escopo e fronteira

Foram alterados somente os artefatos exploratórios do estágio de agenda sob
maioria, o registro de adjudicação/evidência, o script mecânico e o pacote
externo/PDF correspondente. `A_U`, `AC`, `AR`, o manuscrito, `C_M`, o pacote
privado e os artefatos congelados permanecem fora do escopo. Não houve agente,
revisor independente, novo `PASS`, commit, push, merge ou tag.

O parecer externo original foi copiado byte a byte de
`/Users/manoelgaldino/Downloads/auditoria_equilibrios_AM.md` para
`quality_reports/external_reviews/2026-08-28_auditoria_equilibrios_AM_original.md`;
origem e cópia têm SHA-256
`d8b5654f1ab9c8a78ecc6efe071d7e7537c61c39fb648e64ed3103e6e009c70c`.
O PDF efetivamente auditado foi preservado de
`/Users/manoelgaldino/Downloads/agenda_extension_A_M_equilibria_chatgpt_pro_packet.pdf`;
origem e cópia têm SHA-256
`a4794a258c20ad028d31908ae2e59fe10ab847cd3a7f203ee08ca6fb91fe7394`.
O artefato textual examinado no round 1 também foi preservado em
`quality_reports/adjudication/agenda_extension_A_M_explicit/19881e9aa680/round1_reviewed_artifact.md`,
com o hash histórico `19881e9aa680784c93251f8b1c09921f28152ed36941661a6d351697e9dc6885`.

## Reparos implementados

1. AM-L2 agora separa o teto pontual `1-K_kappa(s)` da atingibilidade e exige
   autoconsistência entre proposta, votantes, família/incidência e preços.
2. AMX-009 foi definido somente para a subfamília de continuação globalmente
   constante `E_F`, sem restringir o seletor geral.
3. Posteriores diferentes usam a mesma família fixa `F`, produzindo o membro
   compatível `E_F(mu)`; AMX-008 mantém o ramo puro `B` fixado.
4. A prova explícita de `K(s)<1` foi acrescentada pela cota `C_bar`/`A_g`.
5. O contraexemplo `N=5,m=4,k=2,beta=4/5,o_0=3/10,o_1=2/5` está na derivação,
   no pacote e no teste R: o cálculo pontual dá `17/25`, mas o máximo
   autoconsistente é `13/25`, com transferências mínimas `12/25`.
6. A adjudicação round 2 preserva os pareceres anteriores e registra que o PASS
   interno foi superado apenas em AM-L2, AMX-009 e pontos correlatos.

## Bytes finais do candidato

| Artefato | SHA-256 |
|---|---|
| `model_redesign/agenda_extension_A_M_explicit_majority_results.md` | `158ea83e6b896a6c3318643c948164757761128e7c2522b94c145a6e5547fce3` |
| `model_redesign/agenda_extension_A_M_explicit_majority_claim_ledger.tsv` | `83924102e227bb3445222e52805d5f25db77badc4237164002c8a31305ba44ed` |
| `scripts/verify_agenda_extension_A_M_explicit.R` | `6b615da5a0caf9e25ea5381b8e108b245aadc6705c79d39d5c232c3db9e50040` |
| `reports/chatgpt_pro_packets/2026-08-28_A_M_explicit_equilibria_review_packet.md` | `41064624e5a6e397e0477536c60219e4adbc196280b13638c125e78958b29658` |
| `output/pdf/agenda_extension_A_M_equilibria_chatgpt_pro_packet.pdf` | `7f243257a9262bf6bda4c50f6f933a7204837c90a156f40209c752e022e6bfbc` |
| `quality_reports/external_reviews/2026-08-28_auditoria_equilibrios_AM_original.md` | `d8b5654f1ab9c8a78ecc6efe071d7e7537c61c39fb648e64ed3103e6e009c70c` |
| `quality_reports/external_reviews/2026-08-28_agenda_extension_A_M_equilibria_chatgpt_pro_packet_audited_original.pdf` | `a4794a258c20ad028d31908ae2e59fe10ab847cd3a7f203ee08ca6fb91fe7394` |
| `quality_reports/adjudication/agenda_extension_A_M_explicit/19881e9aa680/round1_reviewed_artifact.md` | `19881e9aa680784c93251f8b1c09921f28152ed36941661a6d351697e9dc6885` |
| `quality_reports/adjudication/agenda_extension_A_M_explicit/19881e9aa680/adjudication_round2.md` | `953a558acdebb894cc635d354696174909fbaf918c77194a2a2cb02af7a48fce` |
| `quality_reports/adjudication/agenda_extension_A_M_explicit/19881e9aa680/adjudication_round2.json` | `9a374752bdf7723bb5fdbeac6f7c0c22c5599f17671f651d2c0bcfb482e2bedd` |

## Verificações executadas

- `Rscript --vanilla scripts/verify_agenda_extension_A_M_explicit.R`:
  **567 PASS / 0 FAIL**, incluindo o contraexemplo e o guard contra `17/25`.
- `python3 .../validate_adjudication.py ...adjudication_round2.json
  --artifact ...round1_reviewed_artifact.md`: `VALID`.
- O pacote foi recompilado com Pandoc/XeLaTeX; `pdfinfo` reportou 20 páginas.
  A renderização Poppler foi inspecionada nas páginas de abertura, AM-L2,
  AMX-009/contraexemplo, limites, mapa de claims e proveniência; não foram
  observados cortes, sobreposições ou glifos ilegíveis.

As mensagens `PASS` acima são somente saídas mecânicas do script. A revisão
matemática independente dos bytes reparados continua pendente; este arquivo não
estende nenhum `PASS` histórico.
