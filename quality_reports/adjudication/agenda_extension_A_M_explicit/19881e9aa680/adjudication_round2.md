# Adjudicação histórica / supersessão — `A_M`, round 2

## 1. Identidade e preservação das fontes

Esta é uma nova adjudicação histórica do artefato que foi examinado no round
1; o round 1 não foi reescrito nem apagado. O artefato então examinado foi:

- `model_redesign/agenda_extension_A_M_explicit_majority_results.md`;
- SHA-256 dos bytes do round 1:
  `19881e9aa680784c93251f8b1c09921f28152ed36941661a6d351697e9dc6885`.
  A cópia byte a byte usada para validar este registro está em
  `quality_reports/adjudication/agenda_extension_A_M_explicit/19881e9aa680/round1_reviewed_artifact.md`.

O parecer externo original foi preservado integralmente em
`quality_reports/external_reviews/2026-08-28_auditoria_equilibrios_AM_original.md`,
SHA-256 de origem e da cópia: `d8b5654f1ab9c8a78ecc6efe071d7e7537c61c39fb648e64ed3103e6e009c70c`.
O PDF efetivamente auditado também foi preservado em
`quality_reports/external_reviews/2026-08-28_agenda_extension_A_M_equilibria_chatgpt_pro_packet_audited_original.pdf`,
com SHA-256 de origem e da cópia
`a4794a258c20ad028d31908ae2e59fe10ab847cd3a7f203ee08ca6fb91fe7394`.

O parecer interno anterior permanece no caminho original, com SHA-256
`1e2fc2bf9d48688135bc75b8cea5232c18a78780fdbe09ef4d234135e26404f1`; o
parecer sobre o pacote permanece com SHA-256
`6a6714eb519226bcef5db7effb0f8fcc632cbd4391394edeb5b94e23231df60a`.

## 2. Disposição executiva

O parecer externo foi `FAIL` localizado, com contagens **critical 0,
important 2, minor 2**. A verificação do texto exato confirmou os cinco pontos
de reparo substantivo abaixo: o erro de atingibilidade em AM-L2, o escopo de
AMX-009, a tipagem entre posteriores, a prova explícita de `K(s)<1` e o
contraexemplo `17/25` versus `13/25`.

Por decisão autoral expressa, os reparos 1--6 foram autorizados para
implementação sobre os bytes atuais. O resultado desta rodada é
`READY_FOR_IMPLEMENTATION`; ela não é um novo parecer de aprovação.

## 3. Findings confirmados e encaminhados

| ID | Status | Escopo confirmado | Correção autorizada |
|---|---|---|---|
| EXT-AM-L2 | `CONFIRMED` | Para seletor que depende de `s`, o cálculo dos preços em um `s` dá apenas teto pontual; mudar a proposta pode mudar o seletor e os preços. | Separar teto pontual de atingibilidade e exigir autoconsistência proposta--membro--preços. |
| EXT-AMX-009 | `CONFIRMED` | “Plano” é ambíguo e o resultado exato falha se a regra só for constante nos vetores, mas variar entre propostas. | Restringir AMX-009 à subfamília de continuação globalmente constante e declarar que isso não restringe o modelo geral. |
| EXT-FAMILY | `CONFIRMED` | “O mesmo membro” em posteriores diferentes pode ser falso literalmente; a incidência/família deve ser fixa e o membro deve acompanhar `\(\mu\)`. AMX-008 precisa manter seu ramo puro `B` fixado. | Usar `E_F(\(\mu\))`/família fixa e explicitar o ramo puro. |
| EXT-K | `CONFIRMED` | AM-L2 não continha prova curta e explícita de `K(s)<1`. | Acrescentar a cota uniforme `\(K_\kappa(s)\le k\beta\bar C=1-A_g<1\)`. |
| EXT-CE | `CONFIRMED` | O caso `N=5,m=4,k=2,\beta=4/5,o_0=3/10,o_1=2/5` refuta a atingibilidade ingênua de `17/25`; o máximo autoconsistente é `13/25`. | Incorporar o contraexemplo e um teste mecânico que falhe se `17/25` voltar a ser declarado atingível. |

Cada finding tem como localização verificável a seção correspondente do
parecer externo preservado (`§2`, `§5` e `§7`) e a passagem AM-L2/AMX-009 do
artefato acima. As correções são seguras porque apenas estreitam claims que
eram mais amplos que a prova; não selecionam nova continuação no modelo geral,
não impõem simetria ou exaustão do bolo e não alteram `A_U`, `AC`, `AR` ou o
manuscrito.

## 4. Relação com o PASS interno anterior

O PASS interno anterior fica **superado apenas** quanto a AM-L2, AMX-009 e aos
pontos correlatos de tipagem de posteriores, a prova de `K(s)<1` e a
atingibilidade usada no teste. Ele não é reclassificado quanto aos resultados
centrais que o parecer externo não derrubou: as construções explícitas de
equilíbrio, os limites globais, a diagonalidade e os certificados de
impossibilidade continuam sendo tratados como resultados candidatos, sujeitos
à revisão dos bytes reparados. Nenhuma parte deste registro transforma maioria
em aprovada ou congelada.

## 5. Lição de processo registrada

A falha não foi apenas esquecer um caso. O revisor anterior permaneceu dentro
da formulação e da lista de ataques oferecidas pelo autor. Revisões futuras
devem separar (a) verificação guiada da prova e (b) uma fase fria, livre para
reformular o objeto e construir contraexemplos não antecipados. A lista de
testes é piso de cobertura, não teto de busca. Esta nota não cria protocolo
novo nesta rodada.

## 6. Estado após a autorização

O implementador deve atualizar os artefatos exploratórios, gerar novos hashes
e parar em

```text
REPAIRED CANDIDATE — EXTERNAL FINDINGS IMPLEMENTED — REVIEW PENDING
```

Sem nova revisão independente, não há novo `PASS`, aprovação autoral adicional,
commit, push, merge ou tag.

## 7. Veredicto desta adjudicação histórica

```text
READY_FOR_IMPLEMENTATION
```
