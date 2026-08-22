# Integração administrativa final de N3 e N4

**Data:** 2026-08-21  
**Branch:** `codex/essential-input-solution-concept-rederive`  
**HEAD de partida:** `a6fd6bd543e9cefd4166581b80565916509e95a6`

## 1. Autoridade e limite

Este registro implementa as decisões autorais posteriores ao contrato congelado:

1. autorização para corrigir e certificar N3 e N4 sob o pacote de conceito de solução de 2026-08-21;
2. confirmação da errata de N2 sem reabrir seus artefatos;
3. ordem expressa, após os pareceres finais, para integrar N3 e N4 e preparar a abertura dos estágios seguintes.

A transição é exclusivamente administrativa. Ela não altera primitivas, obrigações, schemas, conceito de solução, fórmulas ou resultados revisados. Este registro **não autoriza executar N6, N7, extensões com `beta=1` ou migração para manuscrito**. Prontidão topológica não equivale a autorização autoral.

## 2. Objetos congelados

### N3 — R1 sob maioria

- interface: `sha256:ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`;
- dependência única N1: `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`;
- ordem administrativa: início 5, PASS 7;
- `formal_design`: `PASS`, `critical=0; major=0; minor=0`, parecer `sha256:0863f748fe6927794a7fa8cd14b99176dcfbc1092c60a8fee6f1189a30663b7c`;
- `game_theory`: `PASS`, `critical=0; major=0; minor=0`, parecer `sha256:b90efd428c24884ffc32a1bc713d9f77f4b88efb98a903fd3606e28b1436e99f`.

### N4 — R1 sob unanimidade

- interface: `sha256:f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`;
- dependência única N2: `sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`, lida com a errata de suporte do prior registrada em 2026-08-21;
- ordem administrativa: início 6, PASS 8;
- `formal_design`: `PASS`, `critical=0; major=0; minor=0`, parecer `sha256:69c64a2519e044a95f0ee765324b15165cca09d782d392d118adb07d81e2719a`;
- `game_theory`: `PASS`, `critical=0; major=0; minor=0`, parecer `sha256:008cd1c673354e6da4fe6827f4ac7ce48cd81ee7a82070fadd4251fd571c497d`.

Os implementadores não emitiram esses pareceres. Cada nó recebeu exatamente dois pareceres read-only independentes no mesmo hash da respectiva interface.

## 3. Estado do DAG após a integração

- N1, N2, N3 e N4: `pass/frozen`;
- N6 e N7: `pending`, com interfaces nulas e sem campos de execução ou review;
- próxima fronteira topologicamente pronta: somente N6;
- invalidação de N3 ou N4 alcança N6 e N7;
- N7 não fica pronto antes de N6 ser derivado, revisto e congelado.

## 4. Validação exigida

A integração só é válida se, no mesmo snapshot:

1. o verificador Gate 0 recompuser os artefatos, dependências, lifecycle e quatro pareceres finais;
2. o verificador dirigido de N3/N4 passar suas identidades algébricas e enumeração finita;
3. o checker do DAG confirmar a ordem executada, `Ready: N6` e as invalidações de N3/N4;
4. os manifestos finais de review de N3 e N4 passarem integralmente;
5. `git diff --check` passar e os manuscritos/artefatos históricos protegidos permanecerem intocados.

Nenhum commit, merge, push, tag ou execução de N6 faz parte desta integração.
