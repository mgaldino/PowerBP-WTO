# Parecer independente — N3 v2, game theory — rodada 1

**Data:** 2026-08-19  
**Papel:** revisor independente read-only (`game_theory`)  
**Hash revisado:** `sha256:0954f7b7070c69f442981bec46f212cfa91b9f55bb337645fa91e991a2e54bb1`  
**Veredito:** **NÃO PASSA — 0 major / 0 minor / 1 epistemic**

## Fronteira verificada

- Raiz: `/Users/manoelgaldino/.codex/worktrees/592e/PowerBayesianPersuasion`.
- Branch: `codex/essential-input-goal4-n7-phaseb`.
- HEAD observado: `5a165a56a6e7be30a43dd4c46807758f71e14d35`.
- Tag `pre-essential-input-2026-08-12`: objeto `ee11a84f...`, com peeling para `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- N1 congelado: `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`.
- Os bytes de N1 e N3 no worktree coincidiram com os blobs de HEAD.
- O DAG registrava corretamente N1 `pass/frozen`, N3 `pending`, dependência única `N3 <- N1`, e N6/N7 ainda `pending`.
- O diff dos arquivos N1/N3/DAG permaneceu vazio. Artefatos concorrentes de N4 e do outro parecer foram ignorados e não lidos.

## Auditoria substantiva

A rederivação fria não encontrou erro matemático no candidato corrente:

- N1 transporta `1/m` para cada weak state e `o_theta` para H; em R1 entram exatamente uma vez como `beta/m` e `beta*o_theta`.
- Weak nonproposer: `yes` se e somente se `x_j >= beta/m`, com `T^Y` na igualdade.
- H:
  - não pivotal em aprovação: vota `no`, pois recebe `y+o_theta > y`;
  - pivotal: vota `yes` se e somente se `y >= beta*o_theta`;
  - incapaz de alterar a falha: vota `yes` por `T^Y`.
- Os quatro payoffs candidatos são corretamente reduzidos a:
  - `E = 1-beta*(q-1)/m`;
  - `S = (1-nu)*(1-beta*o_0-beta*(q-2)/m)+nu*beta/m`;
  - `P = 1-beta*o_1-beta*(q-2)/m`;
  - `R = beta/m`.
- `E-R = 1-beta*q/m > 0`, pois `q<=m` e `beta<1`; logo não há falha deliberada selecionada.
- As fronteiras `nu_SP` e `nu_SE`, os endpoints `o_0=1/m`, o knife-edge `o_1=1/m`, o desempate por payoff esperado de H e as onze células são consistentes, exclusivas e exaustivas.
- As multiplicidades por identidade, misturas de propostas, mapas de payoff de H por tipo, mapas weak por identidade e outcomes estão corretos.
- Bayes on-path, crenças off-path payoff-irrelevantes e atualização pelo voto público de H são compatíveis com N1.
- Os três verificadores canônicos terminaram com exit `0`; um stress test independente com 200.000 draws também confirmou as regiões estritas.

## Finding N3V2-GT-EPI-01 — falso PASS semântico no verificador

O verificador faz apenas checagens parciais em `scripts/verify_essential_input_n3_v2.R`. Ele não valida o conteúdo da proposta selecionada nem o mapa weak, e o teste de crenças exige apenas que certas strings contenham a palavra `arbitrary`.

O revisor reproduziu em memória o mesmo bypass do hash usado pelos próprios negative fixtures. Cada uma das seguintes mutações manifestamente inválidas ainda terminou com exit `0` e imprimiu todos os PASS:

1. substituir a proposta low-type-only por `y=0; x_j=0; r_i=0`;
2. declarar arbitrário o posterior mesmo após falha de probabilidade positiva, violando Bayes;
3. substituir o mapa weak por `C_l=999`.

O script ainda afirmou que P2, P7, os mapas weak e os testes negativos haviam passado. O pin de hash protege os bytes atuais contra drift, mas não transforma essas checagens em validação semântica; uma atualização coordenada dos hashes poderia certificar conteúdo incorreto.

Pela Seção 11.1, o revisor classifica o finding como **epistêmico e substantivo para o gate**, não técnico: há mais de uma reparação razoável — comparação estrutural exata, avaliação algébrica independente ou enumeração semântica — e portanto falha o teste de reparo único.

## Conclusão e lifecycle

A matemática do candidato exato sobreviveu à auditoria, mas o revisor não pode emitir `PASS 0/0/0` enquanto o verificador aceitar esses contraexemplos semânticos. N3 permanece `pending/unfrozen`; este parecer não autoriza N6. O revisor não editou nenhum artefato do projeto.
