# Protocolo de revisão R2 relative-package

Data: 2026-05-11

Status: protocolo operacional para comparar a auditoria do candidato R2 e a
derivação clean-room. Não é prova substantiva.

## Objetivo

Estabelecer um procedimento de revisão antes de promover qualquer resultado de
R2 unanimity no documento `model_redesign/power_architecture_derivations.Rmd`.

## Regra central

Nenhum resultado deve ser marcado como provado apenas porque aparece na versão
candidata ou porque coincide com fórmulas de arquiteturas antigas. A arquitetura
relative-package deve ser reconstruída a partir dos primitivos.

## Entradas independentes

1. Auditoria do candidato:
   `quality_reports/2026-05-11_relative_package_R2_candidate_audit.md`

2. Derivação clean-room:
   `quality_reports/2026-05-11_relative_package_R2_cleanroom_derivation.md`

3. Revisão comparativa:
   `quality_reports/2026-05-11_relative_package_R2_comparison_review.md`

## Critérios de PASS

Um objeto recebe PASS apenas se todos os itens abaixo forem satisfeitos:

1. O objeto decorre de primitivos já declarados.
2. O timing está explícito.
3. A ação usada pelo proposer está no espaço de ações declarado.
4. A resposta de H é sequencialmente racional para cada tipo.
5. A crença usada após aceitação ou rejeição segue Bayes no caminho, ou o
   resultado não depende dessa crença em R2.
6. O payoff de weak proposer e o payoff representativo de weak state não são
   confundidos.
7. O resultado não usa feasibility/C-B-R nem branch labels antigos.
8. O revisor não registra ressalva substantiva.

## Critérios de PENDING

Um objeto recebe PENDING se:

1. depende de uma opção estratégica ainda não declarada, como no-proposal;
2. depende de regra de desempate;
3. depende de limite inferior ou superior do espaço de pacotes não especificado;
4. depende de uma convenção de votação ou consentimento não declarada;
5. é correto apenas para uma calibração, mas foi escrito como resultado geral;
6. a auditoria e a derivação clean-room discordam em ponto substantivo.

## Critérios de FAIL

Um objeto recebe FAIL se:

1. contradiz um primitivo declarado;
2. importa resultado da arquitetura arquivada;
3. confunde payoff externo de H com custo para weak states;
4. impõe pooling, rejection, delay ou off-path belief sem demonstrar
   racionalidade sequencial;
5. transforma uma opção protocolar pendente em teorema.

## Iteração até sem ressalvas

Após a revisão comparativa:

1. Se todos os objetos relevantes recebem PASS, o Rmd pode ser ajustado para
   refletir a versão convergente.
2. Se qualquer objeto recebe PENDING, o Rmd deve marcar o ponto como pending
   protocol decision e não promover teorema.
3. Se qualquer objeto recebe FAIL, a derivação correspondente deve ser removida
   ou reescrita.
4. Depois do ajuste, deve haver nova rodada de verificação. O objetivo é um
   relatório final com PASS sem ressalvas substantivas antes de avançar para R1.

## Objetos mínimos a classificar

1. Espaço de pacotes y.
2. Custo de y para weak states.
3. Payoff de H ao aceitar.
4. Payoff terminal de H após rejeição.
5. Estratégia ótima de H por tipo.
6. Payoff do weak proposer.
7. Payoff representativo de weak state.
8. Entrada ou não da opção no-agreement no problema de maximização.
9. Cutoff entre pooling e low-only, se existir.
10. Valor de continuação de H para uso em R1.
11. Tratamento de pontos de empate.
12. Status de reprodutibilidade via script R.
