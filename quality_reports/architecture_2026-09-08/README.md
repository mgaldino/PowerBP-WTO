# Arquitetura de H: pacote de diagnóstico e análise condicional

Data: 2026-09-08.

**Estado:** itens 1–3 concluídos. Revisões formal e adversarial com PASS
0/0/0; adjudicação independente NO_CONFIRMED_DEFECTS, sem defeitos ou
questões materiais não resolvidas no escopo. A candidata continua
condicional e não foi adotada no artigo.

## Resultado a avaliar

O jogo vigente deixa em aberto o pagamento após aprovação com voto não de H.
O argumento sobre propostas ótimas não completa esse ramo. A nota apresenta
uma candidata que combina concessão executável, recurso indivisível rival
e compromisso de execução associado ao sim (hipóteses A1–A3).

Sob essas hipóteses, a execução impede recebimentos simultâneos do clube e
do exterior. O transporte demonstrado preserva estratégias prescritas e
resultados econômicos do baseline histórico após projeção da ação adicional.
Não afirma identidade literal de jogos, utilidades invariantes após todos
os desvios nem certificação das assinaturas completas da extensão de agenda.
As hipóteses novas ainda dependem de decisões autorais individuais.

## Revisão e evidências

Os dois pareceres integrais avaliaram a mesma fonte, SHA-256
`493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3`,
e os mesmos 18 artefatos do manifesto. Seus autores não implementaram a
candidata nem leram o parecer um do outro. O contrato de fidelidade foi
concluído antes da crítica científica.

| Registro | Resultado e alcance |
| --- | --- |
| `argument_contract/argument_contract.json` | PASS de fidelidade, com três leituras e reconciliação; não é parecer matemático. |
| `reviews/formal_round1.md` | PASS 0/0/0; revisão integral das demonstrações, dependências, crenças e transporte nos dois sentidos. |
| `reviews/adversarial_round1.md` | PASS 0/0/0; ataques à tecnologia, compromisso, desvios, seleção dos votos, transporte e limites de uso. |
| `adjudication/adjudication_round1.json` | NO_CONFIRMED_DEFECTS; fonte, contrato, julgamentos e evidências conferidos independentemente. Nenhuma correção a implementar. |

O contrato e a adjudicação passaram também por seus validadores de
integridade. O manifesto do candidato conserva seu estado histórico de
fixação antes das revisões; este índice registra a conclusão posterior
dos pareceres e da adjudicação, sem alterar os bytes avaliados.

As evidências computacionais têm unidades diferentes e não devem ser
somadas como se fossem testes independentes do mesmo objeto:

| Evidência | Execução e resultado |
| --- | --- |
| Script R da candidata | 29.005 verificações finitas aprovadas; reprodução independente gerou os cinco outputs idênticos, inclusive `sessionInfo.txt`. |
| Script próprio do revisor formal | 92.562 asserções exatas aprovadas, incluindo 3.735 propostas factíveis e desvios unilaterais dos fracos. |
| Script próprio do revisor adversarial | 96.516 propostas majoritárias, 193.032 comparações por tipo, 42 células de otimização e 15 células terminais unânimes; zero contraexemplo encontrado. |

Os scripts próprios e seus resultados estão em `reviews/formal_evidence/`
e `reviews/adversarial_evidence/`. Os pareceres registram comandos,
hashes e limites. As grades finitas complementam as demonstrações;
não enumeram todo o espaço contínuo de estratégias e crenças.

## Decisões antes de uma eventual migração

1. **D-A / A1:** aceitar que a alocação de H é uma oportunidade cujo
   benefício exige execução própria; o excedente unitário é disponível.
2. **D-B / A2:** aceitar um recurso indivisível de H, necessário tanto ao
   clube quanto à alternativa externa, que só admite um dos dois usos.
3. **D-C / A3:** aceitar o compromisso vinculante do voto sim quando há
   aprovação e a escolha voluntária de execução após aprovação com voto
   não de H.

Essas decisões são substantivas e individuais. O valor da opção externa
continua independente dos acordos entre os fracos; a impossibilidade de
dois recebimentos decorre da nova rivalidade de execução. Não foi
demonstrado que essa tecnologia descreva uma organização internacional
concreta. A seção 3.4 da nota explica quais fundamentos cada decisão afeta
e quais alternativas permanecem se a candidata for rejeitada.

Depois de eventual adoção, os objetos completos da extensão de agenda
ainda precisam de levantamento das estratégias para a árvore nova e da
revisão de seus consumidores. A preservação de seus valores econômicos
não recertifica automaticamente essas estratégias e assinaturas.

## Arquivos principais

- `architecture_note.pdf`: nota de 12 páginas, com quatro tabelas numeradas.
- `architecture_note.Rmd`: fonte exata da nota revisada.
- `candidate_manifest.json`: hashes da nota, PDF, interfaces, scripts e outputs.
- `interfaces/` e `game_dag.json`: especificação condicional e dependências.
- `argument_contract/`: leituras independentes e contrato de fidelidade.
- `reviews/`: auditoria terminal fria e pareceres científicos.
- `adjudication/`: verificação dos findings dos pareceres.
- `checks/`: resultados das 29.005 verificações finitas, exemplos e ambiente R.
- `claim_ledger.json`: alcance dos claims e pendências.
- `delivery_checks.json` e `visual_qa.json`: integridade e inspeção do PDF.
- `sources/preflight.json`: hashes dos 1.540 arquivos preexistentes conferidos.

## Reprodução

Os comandos abaixo usam a raiz de PowerBayesianPersuasion. Para preservar
o candidato revisado, execute cálculos e renderização numa cópia do
projeto; o comando de validação pode ser executado no checkout atual.

```sh
Rscript --vanilla scripts/verify_architecture_20260908.R
Rscript --vanilla scripts/render_architecture_20260908.R
python3 scripts/validate_architecture_20260908.py
```

O primeiro comando recalcula as verificações finitas em `checks/`.
O segundo respeita o YAML bookdown da nota e desativa instalação automática
de pacotes LaTeX. O terceiro compara os arquivos com os hashes do candidato
revisado e verifica outputs e texto do PDF. Uma nova renderização pode mudar
metadados e o hash do PDF; nesse caso, a validação sinaliza corretamente um
artefato diferente. Não se deve sobrescrever o manifesto histórico para
declarar uma reprodução diferente como o mesmo candidato revisado.

O revisor formal demonstrou uma reprodução apenas dos cálculos com o
script original por caminho absoluto e um diretório de trabalho
temporário. Esse procedimento, documentado em `reviews/formal_preflight.md`,
mantém as saídas fixadas intactas. Os scripts independentes têm seus
próprios procedimentos de reprodução registrados nos pareceres.

Para conferir a ordem lógica e os hashes das interfaces, quando a skill
local estiver disponível:

```sh
python3 /Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py quality_reports/architecture_2026-09-08/game_dag.json
```

O grafo não é uma reconstrução de horários da descoberta informal da prova.
Seus estados se referem à análise condicional, não a adoção ou congelamento
do jogo vigente. Os testes finitos não certificam a completude de espaços
contínuos de estratégias, crenças ou assinaturas.

## Fronteira preservada

O manuscrito v6, seu PDF, a v5, os arquivos de submissão e todos os demais
arquivos preexistentes conferidos permanecem intactos. Esta tarefa entrega
os itens 1–3 autorizados: nota, repercussões e revisão. Não incorpora a
candidata ao manuscrito, não altera os fundamentos vigentes e não migra
contratos ou resultados congelados.
