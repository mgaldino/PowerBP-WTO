# Parecer independente — preservação formal e game-theoretic

**Data:** 2026-08-27  
**Natureza:** revisão independente, estritamente `read-only`  
**Candidato coberto:** Gate 0 simplificado da extensão de agenda

## Veredito

**PASS 0/0/0**

- Críticos: 0
- Importantes: 0
- Menores: 0

A simplificação preservou integralmente o jogo e as salvaguardas matemáticas
relevantes.

## O que foi preservado

- Um hegemon e `N-1` Estados fracos, tipo binário privado e prior comum.
- Conhecimento do tipo antes da proposta.
- Obrigação de `H` propor, sem passar a vez.
- Uma parcela final para `H` e uma para cada Estado fraco, com a mesma
  factibilidade econômica anterior.
- Voto favorável automático do proponente, sem segundo voto de `H`.
- Votos fracos simultâneos e selados, seguidos da publicação do vetor completo.
- Quotas corretas: `q_M=floor(N/2)+1` e `q_U=N`.
- Implementação integral e coletiva do pacote, independentemente do voto
  individual.
- Rejeição como único caminho para a continuação congelada.
- Payoffs, datas e transporte de `C` para `A` com exatamente uma aplicação de
  `beta`.
- PBE com votação as-if-pivotal e voto `sim` na indiferença em valor esperado.
- No-signaling para ações fracas, consistência estrutural e preservação do
  suporte do prior.
- Regra local de Bayes em vizinhanças relativas, inclusive para suportes
  singulares.
- Correspondência completa de equilíbrios, sem impor pooling, separating,
  simetria ou seleção adicional.
- Family records simbólicos, binder atômico e proibição de combinar coordenadas
  pertencentes a equilíbrios diferentes.
- `kappa_g` pública, comum aos tipos, mensurável e selecionando um membro
  literal completo da continuação para cada história rejeitada.
- Células `none` sem payoff fictício.
- Conjunto conjunto exato antes de envelopes e imagens marginais.

## Simplificações sem perda lógica

Tornar `AR` opcional não cria lacuna. `A_M`, `A_U` e `AC` formam um resultado
privado autônomo. Benchmarks públicos, rendas e interação só poderão ser
afirmados se o objeto correspondente de `AR` for posteriormente autorizado,
derivado e revisado. A migração também está expressamente impedida de fazer
afirmações públicas que não tenham esse suporte.

Revisar `A_M`, `A_U` e `AC` como um pacote único também é formalmente seguro
porque:

- a execução continua sequencial;
- `A_U` mantém reconstrução cega;
- `AC` só vem depois das duas derivações;
- os dois pareceres finais cobrem os hashes finais do pacote;
- qualquer alteração invalida o artefato mudado e seus consumidores.

Os schemas mínimos ainda identificam domínio, células, famílias, binders,
estratégias, crenças, continuações, payoffs, outcomes, datas, fontes, hashes e
provas. Campos administrativos retirados foram substituídos por referências e
caminhos de prova; nenhuma propriedade matemática deixou de ter responsável.

A divisão de trabalho também está correta:

- o código verifica estrutura, hashes, quotas, datas, contabilidade e
  consistência de referências;
- provas e revisores humanos respondem por existência, completude, desvios no
  contínuo, mensurabilidade, Bayes local e invariância sobre famílias.

## Limites deliberados, não findings

O Goal 1 poderá parar se as interfaces congeladas não forem consumíveis. Isso é
a barreira prevista pelo contrato, não uma autorização para adaptá-las. Da
mesma forma, uma estratégia candidata cuja razão local de Bayes não exista onde
exigida deverá parar e escalar.

## Verificações mecânicas

O DAG é JSON válido, acíclico, com quatro nós produzidos e seis arestas. Os
quatro ledgers têm o cabeçalho canônico de 16 campos.

Os hashes foram confirmados antes e depois da leitura:

- contrato: `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4`;
- DAG: `a2572dc8954d63535d4edcbf04158e9524d11ed4537a822713e534df580ee9e0`;
- cada ledger: `3bd87820cd88b1ffe25f562c4e7952d91a028813a610c8ab728389eed1e6e580`.

Os bytes históricos também correspondem aos hashes declarados. O revisor não
editou nem criou arquivos, não executou Goal 1, não derivou equilíbrios e não
fez commit, tag ou push.
