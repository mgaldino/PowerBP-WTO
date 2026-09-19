# Inventário de proveniência da arquitetura de não acúmulo

Data da inspeção: 2026-09-19T15:10:26.442517+00:00. Escopo: proveniência documental, somente leitura dos artefatos existentes. Foram criados apenas este relatório e seu JSON complementar.

**Resultado:** existe trabalho posterior à correção autoral de 5 de setembro: a nota condicional de 8 de setembro foi concluída e recebeu os dois pareceres documentados. Não foi encontrada adoção autoral de A1–A3, migração para o manuscrito ou fechamento completo da extensão de agenda nos worktrees e refs locais inspecionados.

A memória que descrevia essa execução como incompleta estava desatualizada quanto à entrega da nota e de seus pareceres. A conclusão deste inventário usa os arquivos atuais. A análise condicional concluída e a arquitetura vigente ainda incompleta são estados distintos, expressamente registrados nas fontes.

## Identidade e cadeia documental

- Checkout: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion`.
- Branch: `codex/exposition-items20-28`.
- HEAD: `26b1a40cb98933ae3cd5fd43dd4b7e691b13f5ba` (8 de setembro, 12:57:03, UTC−03).
- Manuscrito atual: SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`.
- PDF atual: SHA-256 `55c4a70af928ead805949efd3d6bc6ff6125c01787cec09b8b26b058e57a0382`.
- A última alteração do manuscrito ocorreu em `68ed3d8724004d359f39baf2ea39fb469960ec4f`, 2 de setembro, 20:00:17, UTC−03. Não há migração de arquitetura nesse arquivo depois disso.

| Fonte | Estado documental e alcance |
| --- | --- |
| Decisão de 1 de setembro e emenda | A reversão da parcela foi substituída por cancelamento. Essa regra histórica foi depois rejeitada como solução primitiva pela correção de 5 de setembro. |
| `agents_maintenance_2026-09-05/approval.md:31–37` | Preserva a obrigação de derivar a arquitetura; não aprova arquitetura nova. |
| `architecture_2026-09-08/README.md:5–22` | Nota, repercussões e duas revisões concluídas; candidata condicional não adotada. |
| `architecture_2026-09-08/README.md:58–78` | D-A/A1, D-B/A2 e D-C/A3 exigem decisões individuais; objetos completos de estratégias e assinaturas da agenda ainda requerem transporte e revisão. |
| `architecture_2026-09-08/claim_ledger.json:69–80` | AGENDA e ADOPT têm estado pending. |
| `architecture_2026-09-08/interfaces/conditional_contract.json:2–4` | `PENDING_OWNER_DECISIONS_DA_DB_DC`; jogo vigente incompleto no ramo aprovação + H não. |
| `2026-09-08_evdokimov_protocol_equivalence_check.md:3–5,62–66` | Checagem focal posterior de coalizão-alvo; não adota arquitetura, não certifica estratégias completas nem extensão de agenda. |

Os caminhos abreviados acima estão sob `quality_reports/`. O JSON registra seus hashes completos.

## Candidato mais recente e fronteira dos pareceres

A nota mais recente revisada está em `quality_reports/architecture_2026-09-08/architecture_note.Rmd`, SHA-256 `493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3`. Seu PDF tem SHA-256 `e5b7b258d64a85b4573f537315276a127f09e142383c65953e182a206c968ae0`. Os 18 artefatos do manifesto continuam idênticos aos hashes registrados, conforme conferência mecânica deste inventário.

O README vincula os pareceres formal e adversarial e a adjudicação à nota condicional. Esse estado não é reclassificado aqui como aprovação científica nova. Os pareceres de 2 de setembro são históricos: o manifesto de exposição cobre seus itens e os bytes atuais do manuscrito; o transporte do item 13 cobre a versão anterior de hash `20fb9837918e4e91bbe9da3b8b1ff90e45d42188444e50b05bb27a41dd233a71`. Nenhum desses PASS é estendido à obrigação posterior de arquitetura.

Os três únicos commits alcançáveis por refs locais com data posterior a 3 de setembro são:

| Commit | Data UTC−03 | Conteúdo relevante |
| --- | --- | --- |
| `c2ed929ff992d4a85c76d3256845f44b09a14687` | 8/9 11:02:37 | Atualização de AGENTS e documentação da manutenção/correção de arquitetura de 5/9. |
| `919ddef2c7eb9f69a6f37360a920ca1eda2e76c1` | 8/9 12:14:51 | Adiciona a nota condicional, interfaces, evidências e revisões de 8/9. |
| `26b1a40cb98933ae3cd5fd43dd4b7e691b13f5ba` | 8/9 12:57:03 | Adiciona exclusivamente a checagem focal inspirada em Evdokimov. |

## Worktrees e alterações não commitadas

Foram inspecionados os 29 registros de `git worktree list --porcelain`: 15 diretórios existem; 14 diretórios temporários estão ausentes e marcados prunable. Todos os 15 existentes tiveram status Git, HEAD, hash do manuscrito e fontes ignorados conferidos. Os diretórios alternativos não contêm os arquivos de arquitetura de setembro.

| ID | Diretório absoluto | HEAD | Estado observado |
| --- | --- | --- | --- |
| WT00 | `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion` | `26b1a40cb989` | Limpo no início; relatórios desta tarefa criados posteriormente |
| WT01 | `/private/tmp/PBP-am-msb` | `9739504db475` | Ausente; prunable |
| WT02 | `/private/tmp/PBP-at-freeze` | `7bba18e7c00f` | Ausente; prunable |
| WT03 | `/private/tmp/PBP-at-release` | `e8e82fc4575e` | Ausente; prunable |
| WT04 | `/private/tmp/PowerBayesianPersuasion-agenda-private-repair` | `b427671efee9` | Ausente; prunable |
| WT05 | `/private/tmp/PowerBayesianPersuasion-essential-input-n3-cold` | `d575651f8253` | Ausente; prunable |
| WT06 | `/private/tmp/PowerBayesianPersuasion-essential-input-n4-cold` | `d575651f8253` | Ausente; prunable |
| WT07 | `/private/tmp/PowerBayesianPersuasion-essential-input-n6-pure` | `8813303ac37b` | Ausente; prunable |
| WT08 | `/private/tmp/PowerBayesianPersuasion-essential-input-n7-fresh` | `8ef5fa980976` | Ausente; prunable |
| WT09 | `/private/tmp/PowerBayesianPersuasion-essential-input-solution-concept` | `1a12b749f967` | Ausente; prunable |
| WT10 | `/private/tmp/PowerBayesianPersuasion-essential-input-support` | `1e84279bffd5` | Ausente; prunable |
| WT11 | `/private/tmp/PowerBayesianPersuasion-figures-narrative` | `ee2fe05a235b` | Ausente; prunable |
| WT12 | `/private/tmp/PowerBayesianPersuasion-goal1-verifier-retest` | `8b5ea05b355c` | Ausente; prunable |
| WT13 | `/private/tmp/PowerBayesianPersuasion-goal5-migration` | `cd326eb5a761` | Ausente; prunable |
| WT14 | `/private/tmp/PowerBayesianPersuasion-post-n6-consolidation` | `e0ff1aceb3d8` | Ausente; prunable |
| WT15 | `/Users/manoelgaldino/.codex/worktrees/2718/PowerBayesianPersuasion` | `b427671efee9` | Limpo |
| WT16 | `/Users/manoelgaldino/.codex/worktrees/4678/PowerBayesianPersuasion` | `b675a372d7c9` | 82 PNGs de QA untracked; fontes limpos |
| WT17 | `/Users/manoelgaldino/.codex/worktrees/4ecf/PowerBayesianPersuasion` | `b675a372d7c9` | Limpo |
| WT18 | `/Users/manoelgaldino/.codex/worktrees/592e/PowerBayesianPersuasion` | `94367dff7b71` | Limpo |
| WT19 | `/Users/manoelgaldino/.codex/worktrees/725d/PowerBayesianPersuasion` | `c34cf0ed6100` | Limpo |
| WT20 | `/Users/manoelgaldino/.codex/worktrees/9421/PowerBayesianPersuasion` | `b427671efee9` | Limpo |
| WT21 | `/Users/manoelgaldino/.codex/worktrees/ce27/PowerBayesianPersuasion` | `08d11a4b5589` | Limpo |
| WT22 | `/Users/manoelgaldino/.codex/worktrees/ebe1/PowerBayesianPersuasion` | `b427671efee9` | Limpo |
| WT23 | `/Users/manoelgaldino/.codex/worktrees/ee35/PowerBayesianPersuasion` | `ad6cf6fd40e0` | Limpo |
| WT24 | `/Users/manoelgaldino/.codex/worktrees/essential-input-n4/PowerBayesianPersuasion` | `3c8639238f1f` | 2 fontes modificados + 4 fontes untracked; trabalho N4 de agosto |
| WT25 | `/Users/manoelgaldino/.codex/worktrees/f842/PowerBayesianPersuasion` | `8b5ea05b355c` | Limpo |
| WT26 | `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion-agenda-integration` | `53e9bb80e9a6` | Limpo |
| WT27 | `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion-agenda-total-effect` | `b3d299a0011b` | Limpo |
| WT28 | `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion-notation-refactor` | `4f17b9ee1577` | Limpo |

O trabalho não commitado em `essential-input-n4` altera a autorização do Goal 2 para N4 de 18 de agosto e seu verificador; os quatro arquivos novos são a derivação, interface, ledger e verificador N4. A derivação se declara pending e usa o contrato de agosto; o ledger se declara pending_independent_review. Seus hashes e diff completo estão no JSON. Eles não contêm adoção das hipóteses A1–A3 ou uma arquitetura posterior de não acúmulo.

Os PNGs em `4678` pertencem às pastas de QA `tmp/pdfs/am_pro_packet/` e `tmp/pdfs/am_pro_packet_repaired/`. Não há fontes ignorados nos worktrees alternativos. Os cinco fontes ignorados na raiz são saídas TeX e dois registros de maio; nenhum constitui adoção nova.

## Refs, verificações e limites

Foram inventariados 73 refs, incluindo branches, remote-tracking e tags anotadas com suas datas de criação e objetos desreferenciados. A ponta mais recente é o HEAD da raiz, também presente no remote-tracking correspondente. Não existe stash. O JSON inclui todos os refs sem truncamento, todos os registros de worktree, hashes, dirty files, o diff N4 e os arquivos alterados pelos três commits posteriores.

Não foi realizado fetch nem consulta ao servidor Git remoto. Logo, a conclusão sobre refs remotos limita-se ao snapshot local. Os 14 caminhos temporários ausentes não permitem examinar conteúdo não commitado que possa ter existido antes de sua remoção. Nenhuma conclusão deste inventário substitui prova formal, decisão autoral, migração ou recertificação dos objetos completos da agenda.

Comandos principais usados:

```sh
git worktree list --porcelain
git -C <worktree> status --short --untracked-files=all
git -C <worktree> ls-files --others --ignored --exclude-standard
git -C <essential-input-n4> diff -- quality_reports model_redesign scripts
git for-each-ref --sort=-creatordate
git log --all --since=2026-09-03 --name-status --date-order
git log -1 --format="%cI|%H|%s" -- formal_model_v6.Rmd
git stash list
```

A conferência SHA-256 foi feita por `hashlib.sha256`, sem renderizar, reexecutar derivações ou alterar artefatos históricos. A criação deste inventário ficou limitada a `provenance_inventory.md` e `provenance_inventory.json` no diretório autorizado.
