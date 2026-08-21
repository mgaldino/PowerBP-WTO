# Parecer final independente de N6 — teoria dos jogos

Data: 2026-08-21
reviewer_role: game_theory
reviewer_id: codex-game-theory-n6-pure-final-20260821
veredicto: PASS
finding_counts: critical=0; major=0; minor=0
interface revisada: sha256:a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92
manifesto revisado: sha256:a59b4db15b84ffa06d4ced1e2cc0b9b31e62be2e40502df8d339a6977f00316e

## Independência e escopo

O revisor foi integralmente read-only, não implementou, editou ou criou nenhum
artefato submetido e não usou subagentes. A revisão ocorreu exclusivamente na
worktree /private/tmp/PowerBayesianPersuasion-essential-input-n6-pure, branch
codex/essential-input-goal3-n6-pure, no HEAD
1a12b749f967d460f819d8732634992ba75fdcf8.

O parecer cobre somente N6, a comparação dos dois jogos com informação privada
para m>=3 e a integração da cadeia privada. N3 e N4 foram consumidos apenas
pelas interfaces frozen:

- N3: sha256:ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d;
- N4: sha256:f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b.

Não houve rederivação de ancestral, benchmark público, renda informacional,
beta=1, análise de estratégias mistas de ballot, N7 ou manuscrito.

## Reconstrução independente

Com w=beta/m, ell=beta*o_0 e h=beta*o_1, as classes de maioria frozen entregam:

- exclusão E: payoff de H (o_0,o_1) e outcome (0,1,0,0);
- screening S: payoff de H (ell,h) e outcome (1-nu,0,0,nu);
- pooling P: payoff de H (h,h) e outcome (1,0,0,0).

As coordenadas de outcome são, nessa ordem, passagem com H, passagem sem H,
falha e delay.

No endpoint nu=0, N3 escolhe screening quando o_0<=1/m, inclusive na igualdade
pelo desempate que minimiza o payoff esperado de H, e exclusão quando o_0>1/m.
N4 entrega L_star, com payoff (ell,h) e outcome (1,0,0,0). Logo, sob screening,
o contraste unanimidade menos maioria é zero; sob exclusão, o contraste de
payoff é (-(1-beta)o_0, -(1-beta)o_1) e o de outcome é (1,-1,0,0).

Na região 0<nu<=nu_star, a maioria continua existente e a unanimidade não tem
PBE com ballots puros. N6 mantém a coleção de maioria, deixa vazias e
certificadas as células de unanimidade e comparação e não atribui payoff
sentinela.

Na região nu_star<nu<=1, N4 entrega P_star, com payoff (h,h) e outcome
(1,0,0,0). Os contrastes unanimidade menos maioria são:

- contra exclusão: payoff (beta*o_1-o_0, -(1-beta)o_1) e outcome (1,-1,0,0);
- contra screening: payoff (beta*(o_1-o_0),0) e outcome (nu,0,0,-nu);
- contra pooling: payoff e outcome iguais a zero.

As regiões de seleção frozen de N3, os domínios próprios de nu_SP e nu_SE, os
lados fechados das fronteiras e o empate residual exclusão/pooling foram
preservados. Assim, na célula alta, o tipo alto nunca melhora sob unanimidade:
empata contra screening ou pooling e perde contra exclusão. O tipo baixo melhora
contra screening, empata contra pooling e tem sinal beta*o_1-o_0 contra
exclusão. Unanimidade remove o delay quando maioria seleciona screening; a
falha terminal é zero nos jogos comparáveis.

Não existe um ranking escalar uniforme de payoff de H em todo o domínio
comparável, e nenhum peso ou média sobre parâmetros foi introduzido.

## Certificado none

Para 0<nu<=nu_star, a proposta factível s_dagger satisfaz Q_L-A=1-beta>0.
Como o valor pivotal de continuação de cada fraco pertence a [B,A], o pagamento
A força todos os weak responders a votar sim, inclusive nas igualdades fechadas
por T^Y.

Os quatro e somente quatro perfis puros de H são eliminados:

- YY: H1 desvia para não e recebe h>ell;
- NN: H0 fica indiferente, e T^Y exige sim;
- YN: H0 imita o não prescrito a H1 e recebe h>ell;
- NY: H1 imita o não prescrito a H0 e recebe h>ell.

A enumeração inclui nu=nu_star. Como a racionalidade sequencial deve valer
depois de toda proposta factível, nenhum desses perfis completa um PBE com
ballots puros. Não foi derivada, simulada, sugerida nem deixada como agenda
qualquer estratégia mista.

## Multiplicidade, conjuntos e simetria

A interface preserva a mesma família identificada F=(F_i)_i de N3 nos payoffs
dos dois tipos e nos quatro outcomes. No empate residual entre exclusão e
pooling, seja lambda=(1/m)sum_i lambda_i a massa agregada de exclusão. Então:

- H_M(lambda)=lambda*(o_0,o_1)+(1-lambda)*(beta*o_1,beta*o_1);
- O_M(lambda)=(1-lambda,lambda,0,0);
- DeltaH(lambda)=lambda*(beta*o_1-o_0, -(1-beta)*o_1);
- DeltaO(lambda)=(lambda,-lambda,0,0).

O mesmo lambda governa todos esses objetos. O segmento residual é a
correspondência frozen de N3, não uma convexificação produzida por N6. Os
envelopes são apenas mínimos e máximos coordenados derivados do conjunto
conjunto exato; não permitem recombinação marginal.

Permutar identidades fracas preserva quota, orçamento, reconhecimento uniforme,
classe econômica, payoff de H e outcome. O quociente por órbitas é válido
somente no relatório. A interface retém IDs, coalizões, F_i, massas e hashes;
alterar a massa entre exclusão e pooling não é uma permutação.

## Integridade e ataques dirigidos

A interface contém uma célula e um registro-família de maioria; três células e
dois registros de unanimidade; três células e dois registros de comparação.
Cada fonte e cada par admissível aparecem exatamente uma vez.

Foram rejeitados, entre outros, os seguintes ataques:

- mover nu=nu_star para a célula alta;
- criar comparação parcial na região none;
- apagar maioria quando unanimidade é none;
- alterar os lados fechados de o_0=1/m, nu_SP ou nu_SE;
- sustentar qualquer dos quatro perfis puros em s_dagger;
- separar payoff e outcome no empate residual;
- tratar envelope como produto cartesiano;
- quocientar a massa exclusão/pooling como mera permutação;
- introduzir benchmark público, renda, beta=1, mistura ou N7.

## Checks

O manifesto candidato e os manifestos finais de N3/N4 passaram integralmente.
O verifier N6 retornou PASS para integridade do schema, 60 identidades
matemáticas dirigidas, certificado none, simetria e atomicidade, além de 5/5
negativas representativas. Gate 0, verifier dirigido N3/N4, DAG checker e
git diff --check passaram. Nenhum manuscrito protegido apresentou diff. Os
avisos isolados de locale não alteraram cálculo ou hash e não são finding.

## Findings e veredicto

Critical: nenhum.
Major: nenhum.
Minor: nenhum.

VEREDICT: PASS — critical=0, major=0, minor=0.

Este PASS incide exclusivamente sobre a interface
sha256:a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92
sob o manifesto
sha256:a59b4db15b84ffa06d4ced1e2cc0b9b31e62be2e40502df8d339a6977f00316e.
Qualquer alteração nesses bytes exige novo ciclo dos dois pareceres.

O parecer não congela N6 sozinho e não autoriza N7, benchmark público, renda
informacional, extensão, manuscrito, push, merge ou tag.
