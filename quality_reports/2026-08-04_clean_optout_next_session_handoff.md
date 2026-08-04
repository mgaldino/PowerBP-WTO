# Handoff para a próxima sessão — PowerBayesianPersuasion

Data: 2026-08-04
Goal fechado: baseline limpo com opt-out imediato

## Estado confirmado

- Repositório: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion`.
- Commit final do Goal: `4467da58f99b1cf75b22e5bfca1a08ccf80d9be1`.
- Worktree estava limpo no fechamento.
- Tag de proveniência: `pre-clean-optout-goal1-2026-08-03` →
  `84a644128586d4f4d81c022cd7d3e09454ee8004`.
- `formal_model_v6.Rmd` não foi editado. SHA-256 inicial e final:
  `f18a999300c88e32bdc7542f3249cd258afd19a0c251c0b29c2c387a7131dbc1`.

## O que foi fechado

O documento autônomo `model_redesign/power_architecture_derivations.Rmd`
rederiva o baseline com:

- `pi_H = 0` em todas as rodadas;
- `b_theta = 0`;
- payoff corrente do hegemon igual a `y` quando o acordo o inclui;
- opt-out imediato e irreversível `o_theta` depois de um H-no no Round 1;
- ballot simultâneo dentro de cada rodada;
- PBE com avaliação *weak-vote-passive*;
- opção externa do hegemon fora do bolo institucional.

Resultados principais:

1. Round 2 unanimista: o hegemon aceita se e somente se `y >= o_theta`; o
   proponente escolhe entre low-only e pooling conforme a crença sobre o tipo
   alto.
2. Round 2 majoritário: os estados fracos excluem o hegemon e retêm o bolo.
3. Round 1 unanimista: no domínio regular, PBE existe somente sob as condições
   `beta o_1 >= o_0` e `G_P > G_L`; quando existe, o resultado em caminho é
   pooling com `y = o_1`.
4. Fronteiras (`o_0 = 0`, `beta = 1`, `o_1 = 1` e priors degenerados) foram
   tratadas separadamente, com multiplicidade e regiões sem PBE quando
   aplicável.
5. A maioria favorece fracamente os estados fracos no domínio comum de
   existência, mas permanece set-valued para grupos grandes.
6. A unanimidade favorece fracamente o hegemon quando ambos os regimes se
   formam, mas a comparação é condicional e não é uma tese de dominância
   global.

O relatório em linguagem natural está em:

- `quality_reports/2026-08-04_clean_optout_findings_natural_language.Rmd`;
- `quality_reports/2026-08-04_clean_optout_findings_natural_language.pdf`;
- `quality_reports/2026-08-04_clean_optout_findings_natural_language.html`.

## Evidência e pareceres

- Gate 0: 36/36.
- Verificadores R: 36/36, 8/8, 11/11, 18/18, 10/10 e 13/13; total 96/96.
- PDF autônomo: 23 páginas, sem referências não resolvidas, validado visualmente.
- Revisores formal, adversarial e R: `PASS` sem ressalvas substantivas no
  commit final.
- Status completo:
  `quality_reports/2026-08-03_clean_baseline_goal1_status.md`.

## Não reabrir sem instrução explícita

- Não editar `formal_model_v6.Rmd` como parte de uma continuação automática.
- Não reintroduzir a arquitetura de viabilidade/C-B-R, os rótulos históricos
  `P/L/R` como caracterização global ou a fórmula de continuação descontada.
- Não promover `pi_H > 0`, escolha endógena da regra, sinalização da escolha
  institucional ou continuação atrasada ao baseline.
- Não chamar *weak-vote-passive* de refinamento, D1, critério intuitivo ou
  equilíbrio sequencial.
- Não transformar as checagens numéricas em provas universais.

## Próxima fase autorizada

A próxima tarefa substantiva, se solicitada, é a migração cuidadosamente
controlada dos resultados estáveis para `formal_model_v6.Rmd`. Antes dela:

1. reler o relatório natural-language e o status do Goal;
2. verificar `git status`, o commit final e o hash de v6;
3. usar o fluxo de versionamento antes de qualquer reset editorial;
4. transportar apenas resultados realmente derivados no documento autônomo;
5. preservar a linguagem de comparação institucional condicional;
6. fazer uma revisão de coerência independente do v6 depois da migração.

Comandos de retomada:

```sh
cd /Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion
git status --short
git rev-parse HEAD
git show -s --format='%H%n%B' HEAD
shasum -a 256 formal_model_v6.Rmd
```

O Goal do baseline está encerrado. Qualquer item acima da seção “Próxima fase
autorizada” é extensão futura, não pendência deste Goal.
